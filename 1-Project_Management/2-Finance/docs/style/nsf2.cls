\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{nsf2}
\LoadClass[12pt, letterpaper, onecolumn]{article}
%\LoadClass[12pt, letterpaper]{article}
\usepackage[factor=0]{microtype}

\RequirePackage[margin=1in]{geometry}

\RequirePackage[pdftex]{graphicx}
\DeclareGraphicsExtensions{.eps,.pdf,.jpeg,.png,.jpg}

\RequirePackage{wrapfig}

\RequirePackage{fancyhdr}
\pagestyle{fancyplain}
\renewcommand{\headrulewidth}{0pt}
\fancyhf{}
%\fancyfoot[R]{\thepage} 

\RequirePackage{titlecaps}
\RequirePackage[explicit]{titlesec}
\titleformat{\section}{\Large\bfseries\filcenter}{\thesection}{12pt}{\titlecap{#1}\\\rule{\textwidth}{0.4pt}}
\titleformat{\subsection}{\large\bfseries}{\thesubsection}{12pt}{\titlecap{#1}}
\titleformat{\subsubsection}{\bfseries}{\thesubsubsection}{12pt}{\titlecap{#1}}
\titlespacing*{\title}{0pt}{0em}{-60pt}
\titlespacing*{\section}{0pt}{0.5em}{0.3 pt}
\titlespacing*{\subsection}{0pt}{0.35em}{0pt}
\titlespacing*{\subsubsection}{0pt}{0.25em}{0pt}
\titlespacing*{\paragraph}{0pt}{0em}{0pt}
\usepackage[skip=2pt,font=scriptsize]{caption}

%\newcommand{\newsection}[1]{\pagenumbering{arabic}\renewcommand{\thepage}{#1--\arabic{page}}}

\usepackage{parskip}
\setlength{\parindent}{.5cm}
%\setlength{\parskip}%{1cm plus0mm minus7mm}
% \usepackage[document]{ragged2e}

% \usepackage{enumitem}
% \setlist[itemize]{noitemsep}

\RequirePackage{titling}
\setlength{\droptitle}{-60pt}

\setcounter{tocdepth}{5}
\setcounter{secnumdepth}{5}
%\pagenumbering{gobble}

%\usepackage[american]{babel}
%\usepackage{csquotes}
%\usepackage[style=apa,backend=biber]{biblatex}
%\DeclareLanguageMapping{american}{american-apa}

%\renewcommand*{\nameyeardelim}{\addcomma\space}











