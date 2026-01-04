\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{etsartcl}[2025/10/26 Modify scrartcl according to Robert Bringhurst’s “The Elements of Typographical Style”]

%% Capture the paperformat, given e.g. by \documentclass[paper=a5]{etsartcl}.
%% The default is b5, since a4 is just too large for a proper typearea.
%% I have not yet implemented a case-insensitive comparison below, so please
%% give the desired paper format in lowercase.
\RequirePackage{xkeyval}
\newcommand{\paperformat}{b5}
\DeclareOptionX{paper}{\renewcommand{\paperformat}{#1}}
\ProcessOptionsX

%% Forward all further options to the documentclass to come.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrartcl}}
\ProcessOptions\relax

%% Everything is based on Markus Kohm’s class scrartcl.
\LoadClass{scrartcl}
\KOMAoptions{
  numbers  = enddot,           % “1. Section” instead of “1. Section”.
  headings = standardclasses,  % Use the main font for titles
  paper    = \paperformat      % Give scrarctl the paperformat from above.
}

%% All packages receive the language from the global option.
\RequirePackage{babel,csquotes}
\RequirePackage[cleanlook]{isodate}

%% We need the font declarations from otfontstyles.
\RequirePackage{otfontstyles}

%% ETS, §2.1.4 recommends single word spaces between sentences.
\frenchspacing

%% Now we design the section headings as in etsbook.
\setkomafont{section}{\mdseries\sctitle}
\renewcommand*{\sectionformat}{\mdseries\sctitle\thesection.\hspace*{.75em}}
\RedeclareSectionCommand[beforeskip  = 1\baselineskip plus 2pt minus 2pt,%
                         afterskip   = 1\baselineskip plus 2pt minus 2pt,%
                         afterindent = false]{section}

%% … and subsections!
\setkomafont{subsection}{\mdseries\itshape}
\renewcommand*{\subsectionformat}{\mdseries\upshape\thesubsection\hspace*{.5em}}
\RedeclareSectionCommand[beforeskip  = .97\baselineskip plus 2pt minus 2pt,%
                         afterskip   = .97\baselineskip plus 2pt minus 2pt,%
                         afterindent = false]{subsection}


%% Set the typearea, very similar to etsbook (see explanations there).
%% For articles, the typearea will be centered horizontally, i.e. the left
%% and the right margin are equally large.
\ifdefstring{\paperformat}{a5}{
  \areaset{280pt}{480pt}
  \setlength{\footskip}{2.5\baselineskip}
}{
  \areaset{320pt}{570pt}
  \setlength{\footskip}{3\baselineskip}
}

%% Redefine maketitle (essentially avoid bold)
\setkomafont  {title}  {\mdseries}
\addtokomafont{subject}{\mdseries}
 
%% Set footnotes without any indentation, causing the number to actually be
%% placed outside the typearea, following §4.3.3 of Bringhurst. Again,
%% we use tabular figures for the numbering.
\deffootnote{0em}{0em}{\tbfigures{\thefootnotemark}.\ }

%% Declare both kind of widows as infinitely bad
\widowpenalty=10000
\clubpenalty =10000

%% Captions for figures and tables
\setkomafont{captionlabel}{\footnotesize\sclabel}
\setkomafont{caption}     {\footnotesize}
\renewcommand*{\captionformat}{.\ }
\setcapindent{0em}

%% Style abstracts
\AtBeginEnvironment{abstract}{\footnotesize}
\patchcmd{\abstract}{\quotation}{\quotation\noindent\ignorespaces}{}{}
\AfterEndEnvironment{abstract}{\smallskip}

%% Finally, prepare options for the hyperref package, which might be loaded later;
%% see the comments in etsbook for explanations.
\PassOptionsToPackage{pdfusetitle,bookmarksnumbered=true,bookmarksdepth=2}{hyperref}
