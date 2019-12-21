%-------------------------------------------------------------------------------
% Identification
%-------------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{customcv}[2019/12/19 Custom Curriculum Vitae Class]

%-------------------------------------------------------------------------------
% Class options
%
% (need to be done before the external package loading, for example because
% we need \paperwidth, \paperheight and \@ptsize to be defined before loading
% geometry and fancyhdr)
%-------------------------------------------------------------------------------
% Needed to use \if-\then-\else statement
\RequirePackage{xifthen}
\newboolean{nocolor}
\setboolean{nocolor}{true}
\DeclareOption{nocolor}{\setboolean{nocolor}{true}}
\DeclareOption{color}{\setboolean{nocolor}{false}}
% Inherit options of article
\DeclareOption*{%
  \PassOptionsToClass{\CurrentOption}{article}
}
\ProcessOptions\relax
\LoadClass{article}


%-------------------------------------------------------------------------------
% 3rd party packages
%-------------------------------------------------------------------------------
% Needed to handle list environment
\RequirePackage{enumitem}
% Needed to configure page layout
\RequirePackage{multicol}
% Needed to configure page layout
\RequirePackage{geometry}
% Needed to make header & footer effeciently
\RequirePackage{fancyhdr}
% Needed to manage colors
\RequirePackage{xcolor}
% Needed to deal with string things
\RequirePackage{xstring}
% Needed to use a toolbox of programming tools
\RequirePackage{etoolbox}
% Needed to change letter spacing in specific environment
\RequirePackage{soulutf8}
% Needed to manage fonts
\RequirePackage[quiet]{fontspec}
% To support LaTeX quoting style
\defaultfontfeatures{Ligatures=TeX}
\RequirePackage[default]{FiraSans}
% Needed for the photo ID
\RequirePackage[skins]{tcolorbox}
% Needed to deal a paragraphs
\RequirePackage{parskip}
% Needed to deal hyperlink
\RequirePackage[hidelinks,unicode]{hyperref}
\hypersetup{%
  pdftitle={},
  pdfauthor={},
  pdfsubject={},
  pdfkeywords={}
}


%-------------------------------------------------------------------------------
% Layout configuration
%-------------------------------------------------------------------------------
%% Page Layout
% Configure page margins with geometry
\geometry{left=2.0cm, top=1.5cm, right=2.0cm, bottom=2.0cm, footskip=.5cm}
\setlength{\columnsep}{1cm}

\linespread{1.2}

%% Header & Footer
% Set offset to each header and footer
\fancyhfoffset{0em}
% Remove head rule
\renewcommand{\headrulewidth}{0pt}
% Clear all header & footer fields
\fancyhf{}
% Enable if you want to make header or footer using fancyhdr
\pagestyle{fancy}


%-------------------------------------------------------------------------------
% Color configuration
%-------------------------------------------------------------------------------
% Gray-scale colors
\ifthenelse{\boolean{nocolor}}{%
  \definecolor{white}{HTML}{FFFFFF}
  \definecolor{black}{HTML}{000000}
  \definecolor{gray750}{HTML}{000000}
  \definecolor{gray700}{HTML}{000000}
  \definecolor{gray650}{HTML}{000000}
  \definecolor{gray600}{HTML}{000000}
  \definecolor{gray550}{HTML}{000000}
  \graphicspath{{bw/}}
}{%
  \definecolor{white}{HTML}{FFFFFF}
  \definecolor{black}{HTML}{000000}
  \definecolor{gray750}{HTML}{44505f}
  \definecolor{gray700}{HTML}{4a5568}
  \definecolor{gray650}{HTML}{68778d}
  \definecolor{gray600}{HTML}{718096}
  \definecolor{gray550}{HTML}{8e9cb4}
  \graphicspath{{color/}}
}

% Text colors
\colorlet{text}{gray700}
\colorlet{darktext}{gray750}
\colorlet{graytext}{gray650}
\colorlet{lighttext}{gray550}
\color{text}

%-------------------------------------------------------------------------------
% Font configuration
%-------------------------------------------------------------------------------
\newcommand*{\headerfont}{\firabook}
\newcommand*{\headerfontsemibold}{\firasemibold}
\newcommand*{\footerfont}{\firabook}
\newcommand*{\bodyfont}{\firabook}
\newcommand*{\bodyfontlight}{\firalight}
\newcommand*{\bodyfontsemibold}{\firasemibold}

%-------------------------------------------------------------------------------
% Configuration for styles
%-------------------------------------------------------------------------------
% Configure styles for each CV elements
% For fundamental structures
\newcommand*{\headernamestyle}[1]{%
  {\fontsize{14pt}{1em}\headerfont\bfseries\color{darktext} #1}}
\newcommand*{\headerinitialsstyle}[1]{{\fontsize{0.9em}{1em}\headerfontsemibold\color{white}#1}}

\sodef\lsw{}{.1em}{.6em plus1em}{2em plus.1em minus.1em}
\newcommand*{\sectionstyle}[1]{{\footnotesize\bodyfont\color{lighttext}\MakeUppercase{\lsw{#1}}}}

\newcommand*{\entrytitlestyle}[1]{{\normalsize\bodyfontsemibold\color{text} #1}}
\newcommand*{\entrydatepositionstyle}[1]{{\small\bodyfont\color{graytext} #1}}

%-------------------------------------------------------------------------------
% Commands for personal information
%-------------------------------------------------------------------------------
\newcommand*{\extractFirstChar}[1]{%
  \StrRemoveBraces{#1}[\FirstChar]%
  \StrChar{\FirstChar}{1}[\FirstChar]%
  \FirstChar
}

% Define writer's name
% Usage: \name{<firstname>}{<lastname>}
% Usage: \firstname{<firstname>}
% Usage: \lastname{<lastname>}
% Usage: \familyname{<familyname>}
\newcommand*{\name}[2]{\def\@firstname{#1}\def\@lastname{#2}}
\newcommand*{\firstname}[1]{\def\@firstname{#1}}
\newcommand*{\lastname}[1]{\def\@lastname{#1}}
\newcommand*{\familyname}[1]{\def\@lastname{#1}}
\def\@familyname{\@lastname}

% Define writer's address
% Usage: \address{<address>}
\newcommand*{\address}[1]{\def\@address{#1}}

% Defines writer's mobile (optional)
% Usage: \mobile{<mobile number>}
\newcommand*{\mobile}[1]{\def\@mobile{#1}}

% Defines writer's email (optional)
% Usage: \email{<email address>}
\newcommand*{\email}[1]{\def\@email{#1}}

% Defines writer's homepage (optional)
% Usage: \homepage{<url>}
\newcommand*{\homepage}[1]{\def\@homepage{#1}}


%-------------------------------------------------------------------------------
% Commands for extra
%-------------------------------------------------------------------------------
%% Define helper macros a user can change easily
% Header
\newcommand{\cvHeaderNameDelim}{\space}
\newcommand{\cvHeaderAfterSkip}{4mm}

% Others
\newcommand{\cvSectionTopSkip}{3mm}
\newcommand{\cvSectionContentTopSkip}{2.5mm}


%-------------------------------------------------------------------------------
% Commands for utilities
%-------------------------------------------------------------------------------
% Use to execute conditional statements by checking empty string
\newcommand*{\ifempty}[3]{\ifthenelse{\isempty{#1}}{#2}{#3}}


%-------------------------------------------------------------------------------
% Commands for elements of CV structure
%-------------------------------------------------------------------------------
% Define a header for CV
% Usage: \makecvheader
\newcommand*{\makecvheader}{%
  \renewcommand{\arraystretch}{.75}%
  \tcbox[size=small,nobeforeafter,center title, tcbox raise=-10.5pt, sharp corners, colframe=gray750, colback=gray750, coltext=white, left=3.5pt, right=3.5pt, top=2pt, bottom=0pt]{\begin{tabular}{@{} c @{}}\headerinitialsstyle{\extractFirstChar{\@firstname}}\\\headerinitialsstyle{\extractFirstChar{\@lastname}}\end{tabular}}%
  \renewcommand{\arraystretch}{1}%
  \quad
  \headernamestyle{\@firstname}\headernamestyle{{}\cvHeaderNameDelim\@lastname}%
  \vspace{\cvHeaderAfterSkip}
}

% Define a section for CV
% Usage: \cvsection{<section-title>}
\newcommand{\cvsection}[1]{%
  \vspace{\cvSectionTopSkip}
  \sectionstyle{#1}
  \phantomsection
}

% Define an environment for cventry
\newenvironment{cventries}{%
}{%
}
% Define an entry of cv information
% Usage: \cventry{<position>}{<title>}{<date>}{<description>}
\newcommand*{\cventry}[4]{%
  \entrytitlestyle{#2}\\
  \entrydatepositionstyle{#3 | #1}\\
  #4
  \vspace{\cvSectionContentTopSkip}%
}

% Define an environment for cvitems(for cventry)
\newenvironment{cvitems}{%
  \vspace{-1\baselineskip}
  \begin{itemize}[leftmargin=1.2em,label=\resizebox{!}{.8em}{\includegraphics{checkmark}}]
  %  \setlength{\parskip}{.05em}
}{%
  \end{itemize}
}

% Define an entry of cv information
% Usage: \skillgroup{<title>}{<skills>}
\newcommand*{\skillgroup}[2]{%
  \entrytitlestyle{#1}\vspace{\cvSectionTopSkip}\\
  #2
  \vspace{\cvSectionContentTopSkip}%
}

% Define a skill
% Usage: \skill{<title>}
\newcommand*{\skill}[1]{%
  \fcolorbox{lighttext}{white}{%
    \raisebox{0pt}[.5\baselineskip][0.125\baselineskip]{\small \, #1 \,}%
  }%
}

\newcommand*{\contactinfo}{%
  \cvsection{Contact}

  \setlength{\tabcolsep}{3pt}%
  \renewcommand{\arraystretch}{1.25}%
  \begin{tabular}{@{}c l@{}}%
    \ifthenelse{\isundefined{\@homepage}}%
      {}%
      {%
        \includegraphics[height=.8em, keepaspectratio]{link} & \href{\@homepage}{\@homepage}\\
      }%
    \ifthenelse{\isundefined{\@address}}%
      {}%
      {%
        \includegraphics[height=.8em, keepaspectratio]{location} & \@address\\
      }%
    \ifthenelse{\isundefined{\@email}}%
      {}%
      {%
        \includegraphics[height=.8em, keepaspectratio]{mail} & \href{mailto:\@email}{\@email}\\
      }%
    \ifthenelse{\isundefined{\@mobile}}%
      {}%
      {%
        \includegraphics[height=.8em, keepaspectratio]{phone} & \@mobile\\
      }%
  \end{tabular}%
}
