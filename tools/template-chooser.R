# Interactive Template Selection Tool
# Run this script to help choose the right template for your project

library(cli)

template_chooser <- function() {
  cli_h1("Project Template Chooser")
  cli_text("This tool will help you select the right template for your research project.")
  cli_rule()
  
  # Project type questions
  cli_h2("Project Type Assessment")
  
  # Question 1: Data collection
  data_collection <- menu(
    choices = c("Yes", "No"),
    title = "Will your project involve collecting new data from participants?"
  )
  
  # Question 2: IRB requirements
  if (data_collection == 1) {
    irb_needed <- menu(
      choices = c("Yes", "No", "Not sure"),
      title = "Will you need IRB approval (human subjects research)?"
    )
  } else {
    irb_needed <- 2  # No
  }
  
  # Question 3: Statistical analysis
  stats_analysis <- menu(
    choices = c("Complex statistical analysis", "Basic analysis/calculations", "No quantitative analysis"),
    title = "What level of statistical analysis will you need?"
  )
  
  # Question 4: Project purpose
  purpose <- menu(
    choices = c(
      "Research paper with original findings",
      "Theoretical/conceptual paper", 
      "Literature review or meta-analysis",
      "Grant proposal or funding application",
      "Conference presentation only",
      "Mixed - multiple outputs planned"
    ),
    title = "What is the primary purpose of this project?"
  )
  
  # Question 5: Timeline
  timeline <- menu(
    choices = c("< 6 months", "6-12 months", "1-2 years", "> 2 years"),
    title = "What is your expected project timeline?"
  )
  
  # Generate recommendation
  cli_rule()
  cli_h2("Recommendation")
  
  recommendation <- get_template_recommendation(data_collection, irb_needed, stats_analysis, purpose, timeline)
  
  cli_alert_success(paste("Recommended template:", recommendation$template))
  cli_text(recommendation$rationale)
  
  if (length(recommendation$alternatives) > 0) {
    cli_h3("Alternative considerations:")
    for (alt in recommendation$alternatives) {
      cli_li(alt)
    }
  }
  
  cli_rule()
  cli_h3("Next steps:")
  cli_ol(c(
    paste("Copy the recommended template: cp -r templates/", recommendation$template, "/ your-project-name/", sep = ""),
    "Review the template _README-template.qmd for specific setup instructions",
    "Customize the template based on your specific needs",
    "Consider combining elements from multiple templates if needed"
  ))
  
  return(recommendation)
}

get_template_recommendation <- function(data_collection, irb_needed, stats_analysis, purpose, timeline) {
  
  # Decision logic
  if (purpose == 4) {  # Grant proposal
    return(list(
      template = "grant-application",
      rationale = "Grant proposals require specialized structure for budgets, timelines, and compliance documentation.",
      alternatives = c(
        "Consider 'empirical-study' if the grant includes a research component",
        "Use 'literature-review' if the grant focuses on synthesis work"
      )
    ))
  }
  
  if (purpose == 5) {  # Conference presentation only
    return(list(
      template = "conference-presentation", 
      rationale = "Standalone presentations need focused templates for slides and abstract submission.",
      alternatives = c(
        "Consider 'simple-paper' if you plan to develop this into a full paper later"
      )
    ))
  }
  
  if (purpose == 3) {  # Literature review
    return(list(
      template = "literature-review",
      rationale = "Systematic reviews require specialized tools for citation management, quality assessment, and meta-analysis.",
      alternatives = c(
        "Use 'simple-paper' for non-systematic literature syntheses",
        "Consider 'empirical-study' if you're conducting original meta-analysis"
      )
    ))
  }
  
  if (data_collection == 1 && (irb_needed == 1 || irb_needed == 3)) {  # Data collection + IRB
    return(list(
      template = "empirical-study",
      rationale = "Projects with data collection and IRB requirements need comprehensive research infrastructure including ethics documentation, data management, and analysis pipelines.",
      alternatives = c(
        "Consider 'grant-application' if you need funding first",
        "Use 'literature-review' if you're also conducting systematic review"
      )
    ))
  }
  
  if (stats_analysis == 1) {  # Complex statistical analysis
    return(list(
      template = "empirical-study",
      rationale = "Complex statistical analyses benefit from the structured R pipeline and data management features of the empirical study template.",
      alternatives = c(
        "Consider 'simple-paper' if you're doing theoretical work with some analysis",
        "Use 'literature-review' if you're conducting meta-analysis"
      )
    ))
  }
  
  if (purpose == 2) {  # Theoretical/conceptual
    return(list(
      template = "simple-paper",
      rationale = "Theoretical and conceptual papers work best with minimal infrastructure focused on writing and citation management.",
      alternatives = c(
        "Consider 'literature-review' if you're synthesizing extensive literature",
        "Use 'empirical-study' if you plan to include some supporting analysis"
      )
    ))
  }
  
  if (purpose == 6) {  # Mixed outputs
    return(list(
      template = "empirical-study",
      rationale = "Projects with multiple planned outputs benefit from the comprehensive structure that can accommodate papers, presentations, and grant applications.",
      alternatives = c(
        "Start with 'simple-paper' and add components as needed",
        "Consider creating separate projects for distinct outputs"
      )
    ))
  }
  
  # Default recommendation
  return(list(
    template = "simple-paper",
    rationale = "When in doubt, start simple. The simple-paper template provides a solid foundation that can be extended as your project grows.",
    alternatives = c(
      "Easy to upgrade to 'empirical-study' if you add data collection",
      "Can incorporate elements from other templates as needed"
    )
  ))
}

# Run the chooser if script is executed directly
if (interactive()) {
  result <- template_chooser()
}