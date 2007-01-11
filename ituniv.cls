%% -----------------------------------------------------------------------------
%% Class: ituniv
%% Part of IT University of Göteborg LaTeX template
%% Author: Oscar Hellström
%% Email: it4heos@ituniv.se
%% Date: 2006-10-03
%% -----------------------------------------------------------------------------
%% This work may be distributed and/or modified under the
%% conditions of the LaTeX Project Public License, either version 1.3
%% of this license or (at your option) any later version.
%% The latest version of this license is in
%%   http://www.latex-project.org/lppl.txt
%% and version 1.3 or later is part of all distributions of LaTeX
%% version 2005/12/01 or later.
%%
%% This work has the LPPL maintenance status `maintained'.
%% 
%% The Current Maintainer of this work is O. Hellström.
%%
%% This work consists of the files pig.dtx and pig.ins
%% and the derived file pig.sty.
%% -----------------------------------------------------------------------------
%%
%% TODO:
%% Documentation ;)
%%
%% -----------------------------------------------------------------------------
\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{ituniv}[2006/10/03 Document class for IT-University reports]

%%
%% Setup of class
%%

% declare some new options
\DeclareOption{utf8}{
	\PassOptionsToPackage{utf8}{inputenc}
}
\DeclareOption{latin1}{
	\PassOptionsToPackage{latin1}{inputenc}
}
\DeclareOption*{
	\PassOptionsToClass{\CurrentOption}{report}
}
\ProcessOptions*\relax

% base this on report class
\LoadClass{report}

%%
%% Load packages
%%

\RequirePackage{ifthen}
\RequirePackage{babel}
\RequirePackage{inputenc}
\RequirePackage{color}
\RequirePackage{graphicx}
\RequirePackage{verbatim}
\RequirePackage{appendix}
\RequirePackage{fancyhdr}
\RequirePackage{multirow}
\RequirePackage{colortbl}
\RequirePackage[numbers,square]{natbib}
\RequirePackage[%
	lmargin=3cm,rmargin=3cm,tmargin=3cm,bmargin=3cm%
]{geometry}
\RequirePackage[plainpages=false,%
	pdfpagelabels,%
	pdftex,%
	colorlinks=true,%
	pagecolor=black,%
	linkcolor=black,%
	urlcolor=rltblue,%
	citecolor=black,%
	pdfproducer={pdfLaTeX},%
	pdfpagemode=None]{hyperref}

\setlength\headheight{15pt}

%%
%% Do some tests
%%

\IfFileExists{inc/ituniv_logo.pdf}{}{
	\ClassError{ituniv_logo}%
	{Cannot find ituniv_logo.pdf}%
	{Please make sure that the ituniv_logo.pdf exists in inc dir}
}

\AtBeginDocument{
\renewcommand\bibname{References}
\hypersetup{pdftitle={\@title},%
	pdfsubject={\ituniv@course},%
	pdfauthor={\ituniv@pdfauthor},%
	pdfkeywords={\ituniv@pdfkeywords}}

	\ifthenelse{\equal{\ituniv@course}{}}{%
	\ClassWarning{course}{No course set}}{}
	\ifthenelse{\equal{\ituniv@groupname}{}}{%
	\ClassWarning{groupname}{No group name set}}{}
	\ifthenelse{\equal{\ituniv@semester}{}}{%
	\ClassWarning{semester}{No semester set}}{}
}

%%
%% Settings
%% 

% make sure that some things are set not to cause errors
\def\ituniv@coord{}
\def\ituniv@supervisor{}
\def\ituniv@version{}
\def\ituniv@course{}
\def\ituniv@groupname{}
\def\ituniv@semester{}
\def\ituniv@logo{}
\def\ituniv@pdfauthor{}
\def\ituniv@pdfkeywords{}

% take all images from inc dir
\graphicspath{{inc/}}

% define some fancy colours
\definecolor{rltblue}{rgb}{0,0,0.75}
\definecolor{ittblhead}{rgb}{0.8,0.8,1}
\definecolor{itblue}{cmyk}{1.0,0.72,0,0.06} % IT-Univs color

% headers TODO, make ruler itblue
\fancyhead{} %reset fancyhead
\fancyhead[LO,LE]{\@title}
\fancyhead[RO,RE]{\ituniv@version}
\renewcommand{\headrulewidth}{0.5pt}
\fancypagestyle{plain}{%
	\fancyhead{} %get rid of the headers on plain pages
	\renewcommand{\headrulewidth}{0pt} % and the line
}

\renewcommand\headrule{%
	{\color{itblue}\vspace{2pt}\hrule}}
\renewcommand{\headrulewidth}{0.4pt}

% footer
\fancyfoot[C]{\thepage}

% activate
\pagestyle{fancy}

% arabic numbering, in the beginning 
\pagenumbering{roman} % reset this in \beginreport

%%
%% Define commands
%%

% Titlepage
\renewcommand{\maketitle}{%
\begingroup%
\renewcommand{\thepage}{}%
\begin{titlepage}
	\parbox{10cm}{
		\LARGE{\raggedright\textbf{\@title}}\\*
		\Large{\raggedright\textbf{\printreportversion{}}}
		\Large{\raggedright\textbf{\ituniv@groupname}}\\*
		\large{\raggedright\textbf{\@author}}\\*\\*
		\raggedright\textbf{\ituniv@semester}\\*
		\raggedright\textbf{\ituniv@course}
	}
	\hfill
	\parbox{4cm}{\includegraphics[keepaspectratio, width=4.0cm]{ituniv_logo}}
	\vspace{0.5cm}
	{\color{itblue}\hrule{}} % ruler under image
	\vspace{\stretch{1}}
	\begin{figure}[!h]
		\centering
		\ituniv@logo
	\end{figure}
	\vspace{\stretch{2}}
	\begin{figure}[!b]
		\begin{minipage}[t]{\textwidth}
		\ifthenelse{\equal{\ituniv@coord}{}}{}{
		
		\textbf{Project Coordinator: \ituniv@coord}\\*
		}
		\ifthenelse{\equal{\ituniv@supervisor}{}}{}{
			\textbf{Supervisor: \ituniv@supervisor}
			}
			
		\end{minipage}
	\end{figure}

	\vspace{\stretch{1}}
\end{titlepage}%
\setcounter{footnote}{0}%
\global\let\thanks\relax
\global\let\maketitle\relax
\global\let\@thanks\@empty
\global\let\@author\@empty
\global\let\@date\@empty
\global\let\author\relax
\global\let\date\relax
\global\let\and\relax
\endgroup
\pagebreak
}

% custom setings for ituniv reports
\newcommand{\coordinator}[1]{\def\ituniv@coord{#1}}
\newcommand{\groupname}[1]{\def\ituniv@groupname{#1}}
\newcommand{\semester}[1]{\def\ituniv@semester{#1}}
\newcommand{\course}[1]{\def\ituniv@course{#1}}
\newcommand{\supervisor}[1]{\def\ituniv@supervisor{#1}}
\newcommand{\pdfauthor}[1]{\def\ituniv@pdfauthor{#1}}
\newcommand{\pdfkeywords}[1]{\def\ituniv@pdfkeywords{#1}}
\newcommand{\logo}[1]{\def\ituniv@logo{#1}}

% handle versions of the report
\newcommand*{\printreportversion}{}
\newcommand*{\reportversion}[1]{%
	\def\ituniv@version{Version #1}
	\ifx\@empty\ituniv@version\else
	\renewcommand*{\printreportversion}{\ituniv@version\\*}
	\fi
}

% redefine report chapters
\renewcommand\chapter{%
	\if@openright\cleardoublepage\else\clearpage\fi
	\global\@topnum\z@
	\@afterindentfalse
	\secdef\@chapter\@schapter%
}
\def\@makechapterhead#1{%
	\vspace*{20\p@}%
	{\parindent \z@ \raggedright \normalfont
		\ifnum \c@secnumdepth >\m@ne
		\vskip 20\p@
	\fi
	\interlinepenalty\@M
	\Huge \thechapter. \bfseries #1\par\nobreak
	\vskip 40\p@
}}

% Version control
\newcommand*{\version}[4][minor]{
	\ifthenelse{\equal{#1}{major}}%
		{\stepcounter{vmajor}}%
		{\stepcounter{vminor}}
	\raggedright{\arabic{vmajor}.\arabic{vminor}} &
	\raggedright{#2} &
	\raggedright{#3} &
	\raggedright{#4}\tabularnewline
}

\newcounter{vmajor}
\newcounter{vminor}
\@addtoreset{vminor}{vmajor}

\newenvironment{vsncontrol}[0]%
	{\pagebreak
	\chapter*{Version History}
	\arrayrulecolor{black}
	\noindent%
	\begin{tabular}{@{}p{0.13\textwidth}@{}@{}p{0.17\textwidth}@{}%
		@{}p{0.40\textwidth}@{}@{}p{0.30\textwidth}@{}}%
		{\raggedright\textbf{Version}} &
		{\raggedright\textbf{Date}} &
		{\raggedright\textbf{Description}} &
		{\raggedright\textbf{Author}} \tabularnewline
		\hline
}%
{\end{tabular}\pagebreak\ignorespacesafterend}

% set up page numbering
\newcommand\beginreport[0]{\newpage\pagenumbering{arabic}}
