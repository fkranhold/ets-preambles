\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{etsbook}[2025/10/26 Modify scrbook according to Robert Bringhurst’s “The Elements of Typographical Style”]

%% Capture the paperformat, given e.g. by \documentclass[paper=a5]{etsbook}.
%% The default is b5, since a4 is just too large for a proper typearea.
%% I have not yet implemented a case-insensitive comparison below, so please
%% give the desired paper format in lowercase.
\RequirePackage{xkeyval}
\newcommand{\paperformat}{b5}
\DeclareOptionX{paper}{\renewcommand{\paperformat}{#1}}
\ProcessOptionsX

%% Forward all further options to the documentclass to come.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrbook}}
\ProcessOptions\relax

%% Everything is based on Markus Kohm’s class scrbook.
\LoadClass{scrbook}
\KOMAoptions{
  numbers       = noenddot,        % “1.1 Section” instead of “1.1. Section”.
  headings      = standardclasses, % Use the main font for titles
  chapterprefix = false,           % We don’t want the line “Chapter 1”
  paper         = \paperformat     % Give scrbook the paperformat from above.
}

%% Language, quotation marks, and dateformat.
%% All packages receive the language from the global option.
\RequirePackage{babel,csquotes}
\RequirePackage[cleanlook]{isodate}

%% We need the font declarations from otfontstyles.
\RequirePackage{otfontstyles}

%% Colours. We use the name “Maroon”, hence the option.
\RequirePackage[dvipsnames]{xcolor}

%% ETS, §2.1.4 recommends single word spaces between sentences.
\frenchspacing

%% Next we design the chapter headings. First, we reset the default settings of
%% KOMA using \setkomafont.  Then we overwrite the mechanism that actually
%% prints the chapter: We print the chapter name (#3) in all caps, and we place
%% a huge chapter number (#2) at the margin of the page.  Finally, we adjust the
%% space before and after the actual chapter title.
\setkomafont{chapter}{\mdseries}
\renewcommand{\chapterlinesformat}[3]{%
  {\allcaps #3}\par%
  \rule[-.15\baselineskip]{\linewidth}{.5pt}\par\nobreak%
  \marginline{\smash{\fontsize{70}{60}\selectfont #2}}%
}%
\RedeclareSectionCommand[beforeskip=1.15\baselineskip,afterskip=1\baselineskip,afterindent=false]{chapter}

%% Now we design the section headings.  We redefine the font style for the
%% section title using \setkomafont: We use small caps, spaced in the context of
%% sections, and uppercase letters are transformed to small caps via the
%% OpenType feature c2sc.  The same has to be done for the section number, by
%% redefining \sectionformat; here we also set the space between section number
%% and section title.  Finally, we adjust the space before and after the actual
%% section title.
\setkomafont{section}{\mdseries\sctitle}
\renewcommand*{\sectionformat}{\mdseries\sctitle\thesection\hspace*{.75em}}
\RedeclareSectionCommand[beforeskip  = 1\baselineskip plus 2pt minus 2pt,%
                         afterskip   = 1\baselineskip plus 2pt minus 2pt,%
                         afterindent = false]{section}

%% Finally, we also design subsection headings.  After the above examples of
%% chapters and sections, these three lines should be fairly self-explanatory.
\setkomafont{subsection}{\mdseries\itshape}
\renewcommand*{\subsectionformat}{\mdseries\upshape\thesubsection\hspace*{.5em}}
\RedeclareSectionCommand[beforeskip  = .97\baselineskip plus 2pt minus 2pt,%
                         afterskip   = .97\baselineskip plus 2pt minus 2pt,%
                         afterindent = false]{subsection}

%% Design of the titlepage, which is set using \maketitle.  We first define a
%% new command \coverfigure that allows setting a cover (or whatever you want to
%% put instead) for the titlepage.  The redefinition of the \maketitle command
%% itself should be rather self-explanatory.
\makeatletter
\def\@coverfigure{\vspace*{6cm}}
\newcommand{\coverfigure}[1]{\def\@coverfigure{#1}}
\def\maketitle{
  \begin{titlepage}
    \centering\large
    \null
    \vskip 6em
    {\color{Maroon}\allcaps\@title}\par
    \medskip
    {\sctitle\@author}\par
    \vfill
    \@coverfigure
    \vfill
    \@subject\par
    \@date\par
    \@publishers\par
    \vskip 6em
  \end{titlepage}
}
\makeatother

%% Setting the typearea, depending on the paper format.  Note that a5 and b5 are
%% reasonable paper formats, anything else will just use the same typearea as b5
%% (resulting in huge margins e.g. for a4).
%%
%% A width of 280pt–300pt will result in 65–70 characters per line (using Minion
%% Pro Regular at 11pt), which feels like a good compromise.  The optimal height
%% has been found by trial and erorr.  (We intentionally do not follow Kohm’s
%% rule that the ratio of the typearea should match the ratio of the paper; this
%% rule is also neglected in Bringhurst’s book.)
%%
%% The typearea will be placed on the paper such that the bottom and outer
%% margins are twice as large as the top and inner margins, respectively.
\ifdefstring{\paperformat}{a5}{%
  \areaset{280pt}{480pt}%
  \setlength{\footskip}{2.5\baselineskip} % Distance between typearea and page numer
  \setlength{\marginparwidth}{6em}        % Width of the printable outer margin
}{
  \areaset{300pt}{570pt}
  \setlength{\footskip}{3\baselineskip}
  \setlength{\marginparwidth}{7em}
}%
\setlength{\marginparsep}{1.4em}      % Distance between typearea and margin area

%% No headlines
\pagestyle{plain}
 
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

%% Set the layout for a table of contents (not as in Bringhurst’s book).
%% The chapter entry should look like a section, but using the Maroon color.
%% Moreover, we want to slightly increase the line space.  Subsections should
%% not appear in the printed table of contents (tocdepth=1).
\setkomafont{chapterentry}{\mdseries\color{Maroon}\sctitle}
\RedeclareSectionCommand[tocbeforeskip=1\baselineskip plus 1pt minus 1pt]{chapter}
\RedeclareSectionCommand[tocbeforeskip=.9pt]{section}
\setcounter{tocdepth}{1}

%% We want to use tabular text figures in the table of contents, both for the
%% chapter and section numbers, and for the page numbers of the sections.  This
%% is again achieved by a snippet from tabfigures, which has been modified in
%% order to suppress page numbers for the chapters (which I find more appealing).
\makeatletter
\AtBeginDocument{%
  \let\tf@@dottedtocline\@dottedtocline
  \def\@dottedtocline#1#2#3#4#5{\tf@@dottedtocline{#1}{#2}{#3}{#4}{{\tbfigures#5}}}%
  \let\tf@numberline\numberline
  \def\numberline#1{\tf@numberline{{\tbfigures#1}}}%
  \let\tf@l@chapter\l@chapter
  \def\l@chapter#1#2{\tf@l@chapter{#1}{}}
  \let\tf@l@section\l@section
  \def\l@section#1#2{\tf@l@section{#1}{{\tbfigures#2}}}
}
\makeatother

%% Finally, prepare options for the hyperref package, which might be loaded later:
%% * pdfusetitle (use what you by \title and \author as PDFtitle and PDFauthor),
%% * bookmarksnumbered=true (chapter/(sub-)section numbers in the PDF table of contents)
%% * bookmarksdepth=2 (go until subsections although the printed TOC doesn’t display them)
\PassOptionsToPackage{pdfusetitle,bookmarksnumbered=true,bookmarksdepth=2}{hyperref}
