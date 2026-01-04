\NeedsTeXFormat{LaTeX2e}
\ProvidesClass{etslttr}[2025/10/26 Modify scrlttr2 according to Robert Bringhurst’s “The Elements of Typographical Style”]

%% Forward all further options to the documentclass to come.  We do not
%% distinguish paper formats, assuming letter to be a4 anyway.
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{scrlttr2}}
\ProcessOptions\relax

%% Everything is based on Markus Kohm’s class scrlttr2.
%% The default font size for scrlttr2 is 12pt, which I find too large (and it
%% also interferes with the scale for optical sizes); hence we change it to 11pt.
\LoadClass[11pt]{scrlttr2} 
\KOMAoptions{%
  parskip,           % vertical space between paragraphs instead of indentation
  foldmarks=TBMpL,   % see §4.10.1 of the KOMA documentation
  enlargefirstpage,  % without this, the typearea is even smaller!
  fromemail          % show email address in letter head
}

%% Language packages (which inherit the global language option).
\RequirePackage{babel,csquotes}
\RequirePackage[cleanlook]{isodate}

%% We need the font declarations from otfontstyles.
\RequirePackage{otfontstyles}

%% ETS, §2.1.4 recommends single word spaces between sentences.
\frenchspacing

%% Choose layout for KOMA fields (essentially avoid sans font and change
%% \scriptsize to \footnotesize)
\setkomafont{lettersubject}{\normalfont\sctitle}
\setkomafont{backaddress}  {\normalfont\footnotesize}
\setkomafont{refname}      {\rmfamily\footnotesize}

%% Separator between name, street, city, …
\setkomavar{backaddressseparator}{~·~}

%% Do not write “E-Mail” in front of the email address
\setkomavar*{emailseparator}{}

%% Short commands for hidden PDF links, requires hyperref
\NewDocumentCommand{\mail}{m}{\href{mailto:#1}{#1}}
\NewDocumentCommand{\web} {m}{\href{#1}{#1}}

%% Prepare options for hyperref, similar to etsbook and etsartcl
\PassOptionsToPackage{pdfusetitle}{hyperref}

%% Setting the typearea, with similar arguments as in etsbook/etsartcl.
\areaset{300pt}{650pt}


