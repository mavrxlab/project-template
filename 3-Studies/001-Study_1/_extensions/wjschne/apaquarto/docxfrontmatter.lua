-- Handle frontmatter stuff for .docx and html formats
if FORMAT:match 'latex' then
  return
end

local List = require 'pandoc.List'
local stringify = pandoc.utils.stringify

---http://lua-users.org/wiki/StringRecipes
local function ends_with(str, ending)
   return string.sub(str.text, -1) == ending
end

local function file_exists(name)
 
  local f = io.open(name, 'r')
  if f ~= nil then
    io.close(f)
    return true
  else
    return false
  end
end

-- Check if meta is present or if it has length of 0
local function chkmeta(meta_item)
    ispresent = false
    if meta_item then
      if #meta_item > 0 then
        ispresent = true
      end
    end
    return ispresent
  end

-- Convert list to string with oxford comma
local function oxfordcommalister(lists)
  local lastsep = pandoc.Str(", and ")
  local sep = pandoc.Str(", ")
  
  if #lists == 2 then
    lastsep = pandoc.Str(" and ")
  end
   
  local result = List:new{}
  for i, v in ipairs(lists) do
    
    if i > 1 then
      if i == #lists then
        result:extend(List:new{lastsep})
      else
        result:extend(List:new{sep})
      end
      
    end
    result:extend(List:new{v})
    
  end

  return result
end

local are_affiliations_different = function(authors)
  
      local superii = ""
      local hash = {}
      local res = {}
      
      
      --Check if affilations are the name for each authors
      for i, a in ipairs(authors) do
        superii = ""
        if a.affiliations then
          for j, aff in ipairs(a.affiliations) do
            if j > 1 then
              superii = superii .. ","
            end
            superii = superii .. aff.number
          end
        end

        if (not hash[superii]) then
          res[#res+1] = superii 
          hash[superii] = true
        end

      end
  
  return #res > 1
  end


local get_author_paragraph = function(authors, different)
  
      local authordisplay = List:new{}
      local superii = ""
      local sep = ", "
  
      for i, a in ipairs(authors) do
        
        if i == 1 then
          sep = ""
        elseif i == #authors then
          if i == 2 then
            sep = " and "
          else
            sep = ", and "
          end
        else 
          sep = ", "
        end

        authordisplay:extend({pandoc.Str(sep .. stringify(a.name.literal))})
        
        superii = ""
        if a.affiliations then
          for j, aff in ipairs(a.affiliations) do
            if j > 1 then
              superii = superii .. ","
            end
            superii = superii .. aff.number
          end
        end
        
        if different then
          authordisplay:extend({pandoc.Superscript(superii)})
        end
        
      end
      return pandoc.Para(authordisplay)
end


local extend_paragraph = function(para, meta_item, sep)
  sep = sep or pandoc.Space()
  
  
  
        if meta_item and #meta_item > 0 then
          if #para.content > 1 then
            para.content:extend({sep})
          end
          para.content:extend(meta_item)
        end
        return para
      end


return {
  {
    Pandoc = function(doc)
           
      local body = List:new{}
      local meta = doc.meta
      
      local documenttitle = ""
      local intabovetitle = 2
      local newline = pandoc.LineBreak()
      if FORMAT:match 'docx' then
         newline = pandoc.SoftBreak()
      end
      
      if meta.apatitledisplay then
        if meta["blank-lines-above-title"] and #meta["blank-lines-above-title"] > 0 then
          local possiblenumber = stringify(meta["blank-lines-above-title"])
          intabovetitle = math.floor(tonumber(possiblenumber)) or 2
        end
        for i=1,intabovetitle do 
          body:extend({newline})
        end
        documenttitle = pandoc.Header(1, meta.apatitledisplay)
        documenttitle.classes = {"title", "unnumbered", "unlisted"}
        documenttitle.identifier="title"
        body:extend({documenttitle})
      end
      

      
      local byauthor = meta["by-author"]
      local affiliations = meta["affiliations"]
      
      local authornote = meta["author-note"]
      
      local mask = false
      
      if meta["mask"] and stringify(meta["mask"]) == "true" then
        mask = true
      end
      
      
      local affilations_different = are_affiliations_different(byauthor)
      
      local affiliations_str = List()

   
      

      
      
      local authordiv = pandoc.Div({
        newline, 
        get_author_paragraph(byauthor, affilations_different)
      })
      authordiv.classes:insert("Author")
      
      
      

      for i, a in ipairs(affiliations) do
        
        affiliations_str = List()
        
        mysep = pandoc.Str("")


        if affilations_different then
          affiliations_str:extend({pandoc.Superscript(stringify(a.number))})
        end
        
         if chkmeta(a.group) then
          affiliations_str:extend(a.group)
          mysep = pandoc.Str(", ")
        end
        
        
        if chkmeta(a.department) then
          affiliations_str:extend({mysep})
          affiliations_str:extend(a.department)
          mysep = pandoc.Str(", ")
        end
        
        if chkmeta(a.name) then
          affiliations_str:extend({mysep})
          affiliations_str:extend(a.name)
          mysep = pandoc.Str(", ")
        end
        

        

          if not (chkmeta(a.group) or chkmeta(a.department) or chkmeta(a.name)) then
             mysep = pandoc.Str("")
            if chkmeta(a.city) then 
              affiliations_str:extend(a.city) 
              mysep = pandoc.Str(", ")
            end
            if chkmeta(a.region) then
              affiliations_str:extend({mysep})
              affiliations_str:extend(a.region)
            end
          end

        authordiv.content:extend({pandoc.Para(pandoc.Inlines(affiliations_str))})
      end
      
      
      

      
      if not mask then
      body:extend({authordiv})
      end
      
      local authornoteheadertext = "Author Note"
      if meta.language and meta.language["title-block-author-note"] then
        authornoteheadertext = meta.language["title-block-author-note"]
      end 
      
      local authornoteheader = pandoc.Header(1, authornoteheadertext)
      authornoteheader.classes = {"unnumbered", "unlisted", "AuthorNote"}
      authornoteheader.identifier = "author-note"
      
      local intabovenote = 2
      
      if authornote then
        if FORMAT:match 'docx' then
          blanklines = authornote["blank-lines-above-author-note"]
          if authornote["blank-lines-above-author-note"] and #authornote["blank-lines-above-author-note"] > 0 then
            local possiblenumber = stringify(authornote["blank-lines-above-author-note"])
            intabovenote = math.floor(tonumber(possiblenumber)) or 2
          end
          for i=1,intabovenote do 
            body:extend({newline})
          end
        end
      end


        
        
        
      if not mask then
        body:extend({authornoteheader})
      end
      
      local img
      
      for i, a in ipairs(byauthor) do
        
        if a.orcid then
          local orcidfile = "_extensions/wjschne/apaquarto/ORCID-iD_icon-vector.svg"
          if not file_exists(orcidfile) then
            orcidfile = "_extensions/apaquarto/ORCID-iD_icon-vector.svg"
          end 
          img = pandoc.Image("Orcid ID Logo: A green circle with white letters ID", orcidfile)
          img.attr = pandoc.Attr('orchid', {'img-fluid'},  {width='16px'})
          pp = pandoc.Para(pandoc.Str(""))
          pp.content:extend(a.name.literal)
          pp.content:extend({pandoc.Space(), img})
          pp.content:extend({pandoc.Space(), pandoc.Str("http://orcid.org/")})
          pp.content:extend(a.orcid)
          
          if not mask then
            body:extend({pp})
          end
        end 

      end
      

      if authornote then
        if authornote["status-changes"] then
          local second_paragraph = pandoc.Para(pandoc.Str(""))
          
          second_paragraph = extend_paragraph(second_paragraph, authornote["status-changes"]["affiliation-change"] or authornote["affiliation-change"] or meta["affiliation-change"])
          second_paragraph = extend_paragraph(second_paragraph, authornote["status-changes"].deceased or authornote.deceased or meta.deceased)
      

          if #second_paragraph.content > 1 then
            if not mask then
              body:extend({second_paragraph})
            end
          end
        end
        
        if authornote.disclosures then
          local third_paragraph = pandoc.Para(pandoc.Str(""))
          
          third_paragraph = extend_paragraph(third_paragraph, authornote.disclosures["study-registration"] or authornote["study-registration"] or meta["study-registration"])
          third_paragraph = extend_paragraph(third_paragraph, authornote.disclosures["data-sharing"] or authornote["data-sharing"] or meta["data-sharing"])
          third_paragraph = extend_paragraph(third_paragraph, authornote.disclosures["related-report"] or authornote["related-report"] or meta["related-report"])
          third_paragraph = extend_paragraph(third_paragraph, authornote.disclosures["conflict-of-interest"] or authornote["conflict-of-interest"] or meta["conflict-of-interest"])
          third_paragraph = extend_paragraph(third_paragraph, authornote.disclosures["financial-support"] or authornote["financial-support"] or meta["financial-support"])
          third_paragraph = extend_paragraph(third_paragraph, authornote.disclosures.gratitude or authornote.gratitude or meta.gratitude)
          third_paragraph = extend_paragraph(third_paragraph, authornote.disclosures["authorship-agreements"] or authornote["authorship-agreements"] or meta["authorship-agreements"])
          
          if #third_paragraph.content > 1 then
            if not mask then
              body:extend({third_paragraph})
            end
          end
        end
      
      end
      
      local credit_paragraph = pandoc.Para(pandoc.Str(""))
      
      for i,a in ipairs(byauthor) do
        if a.roles then
          credit_paragraph = extend_paragraph(credit_paragraph, {pandoc.Emph(a.name.literal)}, pandoc.Str(". "))
          credit_paragraph.content:extend({pandoc.Strong(pandoc.Str(": "))})
          local rolelist = {}
          for j, role in ipairs(a.roles) do
            if role.role == "Writing - original draft" or role.role == "writing - original draft" then
              role["vocab-term"] = "writing – original draft"
            end
            if role.role == "Writing - reviewing & editing" or role.role == "writing - reviewing & editing" then
              role["vocab-term"] = "Writing – reviewing & editing"
            end
          
            if role["vocab-term"] then
              role.display = role["vocab-term"]
            else 
              role.display = role.role
            end
            
            if role["degree-of-contribution"] then
              role.display = role.display .. " (" .. role["degree-of-contribution"] .. ")"
            end
            table.insert(rolelist, pandoc.Str(role.display))
          end
          credit_paragraph.content:extend(oxfordcommalister(rolelist))
        end
      end
        
        
        
        if #credit_paragraph.content > 1 then
          
          local authorroleintroduction = pandoc.Str("Author roles were classified using the Contributor Role Taxonomy (CRediT; https://credit.niso.org/) as follows:")
          if meta.language and meta.language["title-block-role-introduction"] then
            authorroleintroduction = meta.language["title-block-role-introduction"]
            if type(authorroleintroduction) == "string" then
              authorroleintroduction = pandoc.Inlines(authorroleintroduction)
            end
          end
          
          credit_paragraph.content:insert(1, pandoc.Space())
          for i,j in pairs(authorroleintroduction) do
            credit_paragraph.content:insert(i, j)
          end
          if not mask then
            body:extend({credit_paragraph})
          end
        end
      
  
      local corresponding_paragraph = pandoc.Para(pandoc.Str(""))
      local check_corresponding = false
      
      for i,a in ipairs(byauthor) do
        if a.attributes then
          if a.attributes.corresponding and stringify(a.attributes.corresponding) == "true" then
            if check_corresponding then
              error("There can only be one author marked as the corresponding author. " .. stringify(a.name.literal) .. " is the second author you have marked as the corresponding author.")
            end
            check_corresponding = true
            corresponding_paragraph.content:extend(a.name.literal)
            
            if a.affiliations then
              local address = a.affiliations[1]
              corresponding_paragraph = extend_paragraph(corresponding_paragraph, address.group, pandoc.Str(", "))
              corresponding_paragraph = extend_paragraph(corresponding_paragraph, address.department, pandoc.Str(", ")) 
              corresponding_paragraph = extend_paragraph(corresponding_paragraph, address.name, pandoc.Str(", ")) 
              corresponding_paragraph = extend_paragraph(corresponding_paragraph, address.address, pandoc.Str(", ")) 
              corresponding_paragraph = extend_paragraph(corresponding_paragraph, address.city, pandoc.Str(", ")) 
              corresponding_paragraph = extend_paragraph(corresponding_paragraph, address.region, pandoc.Str(", ")) 
              corresponding_paragraph = extend_paragraph(corresponding_paragraph, address["postal-code"]) 
              if a.email then
                corresponding_paragraph.content:extend({pandoc.Str(", Email:")})
                corresponding_paragraph = extend_paragraph(corresponding_paragraph, a.email) 
              end
              
            end
          end
          
        end
      end
      
      
        if #corresponding_paragraph.content > 1 then
          local correspondencenote = pandoc.Str("Correspondence concerning this article should be addressed to ")
          if meta.language and meta.language["title-block-correspondence-note"] then
            correspondencenote = meta.language["title-block-correspondence-note"]
            if type(correspondencenote) == "string" then
              correspondencenote = pandoc.Inlines(correspondencenote)
            end
          end
          corresponding_paragraph.content:insert(1, pandoc.Space())
          for i,j in pairs(correspondencenote) do
            corresponding_paragraph.content:insert(i, j)
          end
          
          if not mask then
            body:extend({corresponding_paragraph})
          end
        end
        
      if meta.apaabstract and #meta.apaabstract > 0 then
        local abstractheadertext = pandoc.Str("Abstract")
        if meta.language and meta.language["section-title-abstract"] then
          abstractheadertext = meta.language["section-title-abstract"]
        end
        local abstractheader = pandoc.Header(1, abstractheadertext)
        abstractheader.classes = {"unnumbered", "unlisted", "AuthorNote"}
        abstractheader.identifier = "abstract"
        if FORMAT:match 'docx' then
          body:extend({pandoc.RawBlock('openxml', '<w:p><w:r><w:br w:type="page"/></w:r></w:p>')})
        end
        
        body:extend({abstractheader})
        local abstract_paragraph = pandoc.Para(pandoc.Str(""))
        
        if pandoc.utils.type(meta.apaabstract) == "Inlines" then
          abstract_paragraph.content:extend(meta.apaabstract or meta.abstract)
          local abstractdiv = pandoc.Div(abstract_paragraph)
          abstractdiv.classes:insert("Abstract")
          body:extend({abstractdiv})
        end
        
        if pandoc.utils.type(meta.apaabstract) == "Blocks" then
          local abstractdiv = pandoc.Div({})
          meta.apaabstract:walk {
            LineBlock = function(lb)
              lb:walk {
                Inlines = function(el)
                    local lbpara = pandoc.Para(el)
                    abstractdiv.content:extend({lbpara})
                end
              }
            end
          }
          body:extend({abstractdiv})
        end

      end
      
      if meta.keywords then
        local keywordsword = pandoc.Str("Keywords")
        if meta.language and meta.language["title-block-keywords"] then
          keywordsword = stringify(meta.language["title-block-keywords"])
        end
        
        local keywords_paragraph = pandoc.Para({pandoc.Emph(keywordsword), pandoc.Str(":")})
        for i, k in ipairs(meta.keywords) do
          if i == 1 then
            keywords_paragraph = extend_paragraph(keywords_paragraph, k)
          else
            keywords_paragraph = extend_paragraph(keywords_paragraph, k, pandoc.Str(", "))
          end
          
        end
        body:extend({keywords_paragraph})
      end

        if FORMAT:match 'docx' then
          body:extend({pandoc.RawBlock('openxml', '<w:p><w:r><w:br w:type="page"/></w:r></w:p>')})
        end
        
      if meta.apatitledisplay then
        local firstpageheader = documenttitle:clone()
        firstpageheader.identifier = "firstheader"
        firstpageheader.classes = {"title"}
        body:extend({firstpageheader})
      end
  

      
      local myshorttitle = meta["apatitle"]

      if meta["shorttitle"] and #meta["shorttitle"] > 0 then
        myshorttitle = meta["shorttitle"]
      end
        
      for i, v in ipairs(myshorttitle) do
        if v.t == "Str" then
          --if v.text:match("’") then
            --v.text = v.text:gsub("’","fixcurlyquote")
          --end
          -- v.text = string.gsub(string.upper(v.text), string.upper("fixcurlyquote"), "’")
          v.text = pandoc.text.upper(v.text)
        end
      end
      meta.description = myshorttitle
      
      body:extend(doc.blocks)
      return pandoc.Pandoc(body, meta)
    end
  }
}