% Latex style for Talent (https://talent.edu.pl) statemnts
% 
% Copyright (c) Stanisław Czech 2024
% Copyright (c) Jakub Rożek 2024
% Provided under MIT licence 
%
% Based on sinol.cls made by:
% Grzegorz Jakacki, Tomasz Waleń, Marcin Kubica, Jakub Pawlewicz
% Adam Iwanicki, Szymon Acedanski, Tomasz Idziaszek, Jakub Radoszewski


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Formalności
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\def\sinolVersion{0.0.6}
\ProvidesClass{talentTex}[Stowarzyszenie Talent \sinolVersion]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Include pakietów
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[T1]{fontenc}
\RequirePackage{epsf}
\RequirePackage{graphicx}
\RequirePackage{fancyhdr}
\RequirePackage[latin2,utf8]{inputenc}
\RequirePackage{verbatim}
\RequirePackage{xcolor}
\RequirePackage{xstring}
\RequirePackage{xparse}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pliki w paczce
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\sinolTestInPath{../in}
\def\sinolTestOutPath{../out}
\def\sinolContestLogoPath{logo}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Kolory
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\definecolor{talentBrown}{RGB}{97, 31, 30}
\definecolor{talentBlue}{RGB}{0, 56, 117} % logo
% \definecolor{talentBlue}{RGB}{31, 101, 157} % środek
% \definecolor{talentBlue}{RGB}{31, 129, 189} % Jasny (SZU)
% \definecolor{talentBlue}{RGB}{31, 73, 125} % Ciemny

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% zmienne logiczne i liczniki
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\ifsinolerrors  \sinolerrorsfalse % bledy
\newif\ifkonkursdefed \konkursdefedfalse  % czy podano konkurs
\newif\ifdaydefed \daydefedfalse  % czy podano dzień
\newif\ifgroupdefed \groupdefedfalse  % czy podano grupę
\newif\ifMemorydefed \Memorydefedfalse  % czy podano dostępną pamięć
\newif\iftimedefed \timedefedfalse % czy podano czas działania

\newcounter{subtestsCounter} % licznik podzadań w tabelce
\newcounter{sumPointSubtask} % suma punktów do zdobycia w zadaniu

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Obsługa plików: inf, err
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\chardef\inffile=15 % plik wejsciowy (np. testy)
\chardef\errfile=14 % plik wyjsciowy
\chardef\tmpfile=13 % plik tymczasowy

% \infoutput{<tekst>} --- wyprowadza do pliku informacyjnego
\newcommand{\infoutput}[1]{%
  \immediate\write\inffile{#1}
}

% \erroutput{<tekst>} --- wyprowadza do pliku z bledami
\newcommand{\erroutput}[1]{%
  \immediate\write\errfile{#1}
  \global\sinolerrorstrue
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Czynności przed i po - otwiera pliki inf err
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AtBeginDocument{%
  \immediate\openout\inffile \jobname.inf
  \immediate\openout\errfile \jobname.err
}

\AtEndDocument{%
  \ifsinolerrors
    \immediate\write16{SINOL: znaleziono bledy (zob. \jobname.err) !}
  \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Definicje
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\ucase#1{\expandafter\uppercase\expandafter{#1}}
\def\lcase#1{\expandafter\lowercase\expandafter{#1}}

\def\?#1{
  [[#1]]
}

\def\ifundef#1#2#3{%
  \expandafter%
  \ifx\csname#1\endcsname\relax%
    #2%
  \else%
    #3%
  \fi%
}

\def\ifeq#1#2#3{%
  \edef\@tempeqa{#1}%
  \edef\@tempeqb{#2}%
  \ifx\@tempeqa\@tempeqb#3\fi%
}

\def\ifneq#1#2#3{%
  \edef\@tempeqa{#1}%
  \edef\@tempeqb{#2}%
  \ifx\@tempeqa\@tempeqb\else#3\fi%
}

\newcommand{\iffileexists}[3]{%
  \immediate\openin\tmpfile#1\par%
  \ifeof\tmpfile%
    \immediate\closein\tmpfile%
    #3%
  \else%
    \immediate\closein\tmpfile%
    #2%
  \fi%
}

\NewDocumentCommand{\twocol}{ O{0.5} O{0} O{t} m m }{%
  \noindent%
  \begin{minipage}[#3]{#1\textwidth}%
    #4%
  \end{minipage}%
  \hfill%
  \begin{minipage}[#3]{\dimexpr\textwidth-#1\textwidth-#2\textwidth}%
    #5%
  \end{minipage}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\LOGO{
  \leavevmode
  \hbox{
    \vbox to 0pt{
      \vss
      \hbox{
        \includegraphics[height=1.143cm,bb=0 0 900 300]{\sinolContestLogoPath}%
      }
    }
  }
}

\def\tophugetitle{%
  \begin{minipage}[t]{0.75\textwidth}
    \color{talentBlue}
    \fontfamily{ptm}
    \huge
    \textbf{\sinolTitle}
  \end{minipage}
}

\def\topinformationbar{}

% uruchamiane po przeczytaniu deklaracji
\newcommand{\concludedecls}{
  % Sprawdzanie istnienia definicji
  \ifundef{ID}{
    \erroutput{brak 3-literowego identyfikatora (klauzula \string\id)}
    \def\ID{XXX}
  }{}
  \ifundef{sinolTitle}{
    \erroutput{brak tytułu (klauzula \string\title)}
    \def\sinolTitle{\?{brak tytułu}}
  }{}
}

% uruchamiane po przeczytaniu tekstu
\newcommand{\concludetext}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Przypisanie stałych przez użytkownika
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\id}[1]{
  \edef\ID{#1}
}

\renewcommand{\title}[1]{
  \def\sinolTitle{#1}
}

\newcommand{\konkurs}[1]{
  \def\sinolKonkurs{#1}
  \global\konkursdefedtrue
}

\renewcommand{\day}[1]{
  \def\sinolDay{#1}
  \global\daydefedtrue
}

\newcommand{\group}[1]{
  \def\sinolGroup{#1}
  \global\groupdefedtrue
}

\newcommand{\Memory}[1]{
  \def\sinolMemory{#1}
  \global\Memorydefedtrue
}

\newcommand{\Time}[1]{
  \def\sinolTime{#1}
  \global\timedefedtrue
}

\newcommand{\iomode}[1]{
  \ifeq{#1}{files}{
    \gdef\sinolExampleInputText{Dla pliku wejściowego {\ttfamily\ID.in}:}
    \gdef\sinolExampleOutputText{poprawnym wynikiem jest plik wyjściowy {\ttfamily\ID.out}:}    
  }
  \ifeq{#1}{stdin}{
    \gdef\sinolExampleInputText{{\color{talentBlue}\bf \sinolInputText:}}
    \gdef\sinolExampleOutputText{{\color{talentBlue}\bf \sinolOutputText:}}    
  }
}
\iomode{stdin}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nazwy wyświetlane (zmiana języka, narazie tu ręcznie)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\sinolSNameOpis{Opis rozwiązania}
\def\sinolSNameOpracowanie{Opracowanie}

\def\sinolTitleZadanie{Zadanie}
\def\sinolGroupText{Grupa}
\def\sinolDayText{}
\def\sinolKonkursText{}
\def\sinolMemoryText{Pamięć}
\def\sinolTimeText{Czas}
\def\sinolInputText{Wejście}
\def\sinolOutputText{Wyjście} 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Opcje talentTex
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareOption{zad}{
  \renewcommand{\topinformationbar}{%
    \hbox{%
      \bf%
      \fontfamily{ptm}%
      \color{talentBlue}%
      \ifkonkursdefed
        \ifneq{\sinolKonkurs}{}{\sinolKonkursText\sinolKonkurs.\hspace{5pt}}%
      \fi
      \ifdaydefed
        \ifneq{\sinolDay}{}{\sinolDayText\sinolDay.\hspace{5pt}}%
      \fi
      \ifgroupdefed
        \ifneq{\sinolGroup}{}{\sinolGroupText:\,\sinolGroup.\hspace{5pt}}%
      \fi
      \ifMemorydefed
        \ifneq{\sinolMemory}{}{\sinolMemoryText:\,\sinolMemory\,MB.\hspace{5pt}}%
      \fi
      \iftimedefed
        \ifneq{\sinolTime}{}{\sinolTimeText:\,\sinolTime\,s.\hspace{5pt}}%
      \fi
      \hfill
    }
  }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareOption{opi}{
  \renewcommand{\topinformationbar}{
    \hbox{%
      \bf%
      \fontfamily{ptm}%
      \color{talentBlue}%
      \Large%
      \sinolSNameOpis%
      \hfill%
    }
  }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareOption{opr}{
  \renewcommand{\topinformationbar}{
    \hbox{%
      \bf%
      \fontfamily{ptm}%
      \color{talentBlue}%
      \Large%
      \sinolSNameOpracowanie%
      \hfill%
    }
  }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\PassOptionsToClass{a4paper}{article}
\LoadClass{article}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% rozmiar papieru
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setlength{\textwidth}{168mm} % {180mm}
\setlength{\textheight}{265mm} % {257mm}
\setlength{\oddsidemargin}{0pt}
\setlength{\hoffset}{-4mm} % this means 1in-15mm
\setlength{\voffset}{-30mm} % this means 1in-15mm
\setlength{\topmargin}{0pt}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0.4pt}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Wygląd dokumentu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\pagestyle{fancy}
\lfoot{Stowarzyszenie Talent (talent.edu.pl)}
\rfoot{\begin{minipage}[t]{0.45\textwidth}\raggedleft\sinolTitle\ - \ID\end{minipage}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Definicja przestrzeni dokumentu: 'tasktext'
\newenvironment{tasktext}{
  \concludedecls
  % Tytuł
  \leftline{%
    \tophugetitle%
  }
  % Logo
  \rightline{
    \hbox to\hsize{\hfil\LOGO}
  }
  \smallskip
  % Linia
  {
    \color{talentBrown}
    \hrule height 2pt \relax
  }
  \smallskip
  \topinformationbar
  \bigskip
}{
  \concludetext
  \closeout\inffile
  \closeout\errfile
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Komendy dostępne w klasie talentTex
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Pokazywanie testów wstępnych

\newcommand{\includefile}[1]{
\vspace{-0.9em}
\verbatiminput{#1}
}

\newcommand{\exampleinput}[1]{
  \noindent\sinolExampleInputText
  \iffileexists{\sinolTestInPath/\ID0#1.in}{
    \includefile{\sinolTestInPath/\ID0#1.in}
  }{
    \smallskip
    \?{brak pliku {\ttfamily\ID0#1.in}}\par
    \erroutput{brak pliku '\ID0#1.in' w scieżce '\sinolTestInPath'}
    \smallskip
  }
}

\newcommand{\exampleoutput}[1]{
  \noindent\sinolExampleOutputText
  \iffileexists{\sinolTestOutPath/\ID0#1.out}{
    \includefile{\sinolTestOutPath/\ID0#1.out}
  }{
    \smallskip
    \?{brak pliku {\ttfamily\ID0#1.out}}\par
    \erroutput{brak pliku '\ID0#1.out' w scieżce '\sinolTestOutPath'}
    \smallskip
  }
}

\newcommand{\makestandardexample}[1]{%
  \vspace{5pt}
  \exampleinput{#1}%
  \exampleoutput{#1}%
}

\newcommand{\makecompactexample}[1]{%
  \vspace{-5pt}%
  \begin{center}%
    \twocol{\exampleinput{#1}}{\exampleoutput{#1}}%
  \end{center}%
}

% Początek i koniec dokumentu

\newcommand{\start}{
  \begin{document}
  \begin{tasktext}
}

\newcommand{\finish}{
  \end{tasktext}
  \end{document}
}

% obsługa zdjeć

\newlength{\imgwidth}

% podpis pod/nad obrazkiem
\newcommand{\imgcaption}[1]{
  \def\capwidth{\textwidth}
  \addtolength\capwidth{-1cm}
  \centerline{\begin{minipage}{\capwidth}\footnotesize #1\end{minipage}}
}

% rysunek #1-plik, #2-podpis, #3-gdzie podpis (t-na gorze, b-na dole)
\newcommand{\img}[3]{
  \def\tmpargthree{#3}
  \def\tmpb{b}
  \setlength\imgwidth{\textwidth}
  \addtolength\imgwidth{-2cm}
  \begin{center}
  \begin{minipage}{\imgwidth}
  \ifx\tmpargthree\tmpb
    $$\includegraphics[width=1\imgwidth]{#1}$$
    \hrule
    \smallskip
    \imgcaption{#2}
  \else
    \imgcaption{#2}
    \smallskip
    \hrule
    \smallskip
    $$\includegraphics[width=1\imgwidth]{#1}$$
  \fi
  \end{minipage}\end{center}
}

\newcommand{\timg}[2]{\img{#1}{#2}{t}}
\newcommand{\bimg}[2]{\img{#1}{#2}{b}}
\newcommand{\plainimg}[1]{$$\includegraphics{#1}$$}

% Sekcje w dokumencie

\newcommand{\tSection}[1]{
  \tCustomSection{#1}{15pt}
}

\newcommand{\tsection}[1]{
  \tSection{#1}
}

\newcommand{\tSmallSection}[1]{
  \par\vspace{5pt}
  {
    \setlength\parindent{0pt}
    \fontfamily{ptm}
    \color{talentBlue}
    \textbf{#1}
  }
  \par\vspace{2pt}
}

\newcommand{\tCustomSection}[2]{
  \par\vspace{#2}
  {
    \setlength\parindent{0pt}
    \fontfamily{ptm}
    \color{talentBlue}
    \Large
    \textbf{#1}
  }
  \par\vspace{2pt}
}

% Talentowy kolor do zaznaczania zmiennych

\newcommand{\tc}[1]{%
  \ifmmode
    \StrLen{#1}[\textLength]
    \ifnum\textLength=1
      \textcolor{talentBlue}{\textbf{\fontfamily{ptm}\selectfont #1}}%
    \else
      \textcolor{talentBlue}{\mathbf{{\fontfamily{ptm}\selectfont #1}}}%
    \fi
  \else
    \textcolor{talentBlue}{\textbf{\fontfamily{ptm}\selectfont #1}}%
  \fi
}

% Testy ocen 

\newcommand{\ocen}[1]{
  \begin{enumerate}
  \setlength\itemindent{-13pt}
  \fontfamily{ptm}
  #1
  \end{enumerate}
}

\newcommand{\testOcen}[2]{
  \item[] \textbf{\color{talentBlue}\ID#1: \ }{#2}
}

% Tabelka z podzadaniami

\newcommand{\ocenTable}[2][100]{
  \setcounter{subtestsCounter}{0}
  \setcounter{sumPointSubtask}{0}
  \begin{center}
    \begin{tabular}
      {|c|l|c|} \hline
      \tc{Nr} & \tc{Ograniczenia} & \tc{Punkty} \\ \hline
      #2
    \end{tabular}
  \end{center}
  \ifneq{\arabic{sumPointSubtask}}{#1}{%
    Uwaga! W tyma zadaniu suma punktów do zdobycia wynosi \arabic{sumPointSubtask} punktów.%
    \erroutput{Suma punktow jest niewlasciwa}%
  }
}

\newcommand{\ocenRow}[2]{
  \stepcounter{subtestsCounter}%
  \addtocounter{sumPointSubtask}{#1}%
  \arabic{subtestsCounter} & \begin{tabular}{@{}l@{}} #2 \end{tabular} & #1 \\ \hline
}
