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
\def\codeVersion{0.0.6}
\ProvidesClass{talentTex}[Stowarzyszenie Talent \codeVersion]

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
\RequirePackage{environ}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pliki w paczce
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\pathTestIn{../in}
\def\pathTestOut{../out}
\def\pathContestLogo{logo.jpg}

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
\newif\ifDocumentHasSet \DocumentHasSetfalse % czy samodzielnie użytp \begin{document}
\newif\ifUseExample \UseExamplefalse % czy stworzono przykład
\newif\ifContestDefed \ContestDefedfalse  % czy podano konkurs
\newif\ifDayDefed \DayDefedfalse  % czy podano dzień
\newif\ifRoundDefed \RoundDefedfalse  % czy podano runde
\newif\ifGroupDefed \GroupDefedfalse  % czy podano grupę
\newif\ifMemoryDefed \MemoryDefedfalse  % czy podano dostępną pamięć
\newif\ifTimeDefed \TimeDefedfalse % czy podano czas działania

\newcounter{subtasksCounter} % licznik podzadań w tabelce
\newcounter{subtasksPiontSum} % suma punktów do zdobycia w zadaniu

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Czynności przed i po dokumencie
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\AtBeginDocument{%
  \DocumentHasSettrue%
  \ifundef{taskID}{%
    \errmessage{brak id (\string\id{})}%
  }{}
  \ifundef{taskTitle}{%
    \errmessage{brak title (\string\title{})}%
  }{}
}

\AtEndDocument{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Definicje techniczne
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\?#1{[[#1]]}

\def\ifundef#1#2#3{%
  \ifcsname#1\endcsname%
    #3%
  \else%
    #2%
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
  \immediate\openin\@inputcheck=#1
  \ifeof\@inputcheck%
    \immediate\closein\@inputcheck%
    #3%
  \else%
    \immediate\closein\@inputcheck%
    #2%
  \fi
}

\NewDocumentCommand{\twocol}{ O{0.5} O{0} O{t} m m }{%
  \begin{center}%
    \begin{minipage}[#3]{#1\textwidth}%
      #4%
    \end{minipage}%
    \hfill%
    \begin{minipage}[#3]{\dimexpr\textwidth-#1\textwidth-#2\textwidth}%
      #5%
    \end{minipage}%
  \end{center}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\def\LOGO{
  \leavevmode
  \hbox{
    \vbox to 0pt{
      \vss
      \hbox{
        \includegraphics[height=1.143cm,bb=0 0 900 300]{\pathContestLogo}%
      }
    }
  }
}

\def\topHugeTitle{%
  \begin{minipage}[t]{0.75\textwidth}%
    \huge%
    \fontfamily{ptm}%
    \color{talentBlue}%
    \textbf{\taskTitle}%
  \end{minipage}%
}

\def\topInformationBarText{}

\def\topInformationBar{
  \hbox{%
    \bf%
    \fontfamily{ptm}%
    \color{talentBlue}%
    \topInformationBarText%
    \hfill%
  }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Przypisanie stałych przez użytkownika
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\newcommand{\id}[1]{
  \edef\taskID{#1}
}

\renewcommand{\title}[1]{
  \edef\taskTitle{#1}
}

\newcommand{\contest}[1]{
  \def\taskContest{#1}
  \global\ContestDefedtrue
}

\renewcommand{\day}[1]{
  \def\taskDay{#1}
  \global\DayDefedtrue
}

\newcommand{\round}[1]{
  \def\taskRound{#1}
  \global\RoundDefedtrue
}

\newcommand{\group}[1]{
  \def\taskGroup{#1}
  \global\GroupDefedtrue
}

\newcommand{\Memory}[2][MB]{
  \def\taskMemory{#2}
  \def\taskMemoryUnit{#2\,#1}
  \global\MemoryDefedtrue
}

\newcommand{\Time}[2][s]{
  \def\taskTime{#2}
  \def\taskTimeUnit{#2\,#1}
  \global\TimeDefedtrue
}

\newcommand{\iomode}[1]{
  \ifeq{#1}{files}{
    \gdef\exampleInputText{Dla pliku wejściowego {\ttfamily\taskID.in}:}
    \gdef\exampleOutputText{poprawnym wynikiem jest plik wyjściowy {\ttfamily\taskID.out}:}    
  }
  \ifeq{#1}{stdin}{
    \gdef\exampleInputText{{\color{talentBlue}\bf\textInput:}}
    \gdef\exampleOutputText{{\color{talentBlue}\bf\textOutput:}}    
  }
}
\iomode{stdin}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Nazwy wyświetlane (zmiana języka, narazie tu ręcznie)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\textSolutionDescription{Opis rozwiązania}
\def\textDocumentation{Opracowanie}
\def\textGroup{Grupa}
\def\textDay{Dzień}
\def\textRound{Runda}
\def\textContest{Konkurs}
\def\textMemory{Pamięć}
\def\textTime{Czas}
\def\textInput{Wejście}
\def\textOutput{Wyjście}
\def\textPoints{Punkty}
\def\textTestCasess{Ograniczenia}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Opcje talentTex
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareOption{zad}{
  \renewcommand{\topInformationBarText}{%
    \ifContestDefed
      \ifneq{\taskContest}{}{\taskContest.\hspace{5pt}}%
    \fi
    \ifDayDefed
      \ifneq{\taskDay}{}{\textDay:\,\taskDay.\hspace{5pt}}%
    \fi
    \ifRoundDefed
      \ifneq{\taskRound}{}{\textRound:\,\taskRound.\hspace{5pt}}%
    \fi
    \ifGroupDefed
      \ifneq{\taskGroup}{}{\textGroup:\,\taskGroup.\hspace{5pt}}%
    \fi
    \ifMemoryDefed
      \ifneq{\taskMemory}{}{\textMemory:\,\taskMemoryUnit.\hspace{5pt}}%
    \fi
    \ifTimeDefed
      \ifneq{\taskTime}{}{\textTime:\,\taskTimeUnit.\hspace{5pt}}%
    \fi
  }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareOption{opi}{
  \renewcommand{\topInformationBarText}{
    \Large%
    \textSolutionDescription%
  }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareOption{opr}{
  \renewcommand{\topInformationBarText}{
    \Large%
    \textDocumentation%
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
% Wygląd stopki dokumentu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\pagestyle{fancy}
\lfoot{Stowarzyszenie Talent (talent.edu.pl)}
\rfoot{\begin{minipage}[t]{0.45\textwidth}\raggedleft\taskTitle\ - \taskID\end{minipage}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Definicja przestrzeni dokumentu: 'tasktext'
\newenvironment{tasktext}{
  % Tytuł
  \leftline{%
    \topHugeTitle%
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
  \topInformationBar
  \bigskip
}{}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Komendy dostępne w klasie talentTex
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Pokazywanie testów wstępnych

\newcommand{\includefile}[1]{
\vspace{-0.9em}
\verbatiminput{#1}
}

\newcommand{\exampleinput}[1]{
  \noindent\exampleInputText\par
  \iffileexists{\pathTestIn/\taskID0#1.in}{
    \includefile{\pathTestIn/\taskID0#1.in}
  }{
    \?{brak pliku {\ttfamily\pathTestIn/\taskID0#1.in}}
  }\par
}

\newcommand{\exampleoutput}[1]{
  \noindent\exampleOutputText\par
  \iffileexists{\pathTestOut/\taskID0#1.out}{
    \includefile{\pathTestOut/\taskID0#1.out}
  }{
    \?{brak pliku {\ttfamily\pathTestOut/\taskID0#1.out}}
  }\par
}

\newcommand{\makeVExample}[1]{%
  \noindent%
  \begin{minipage}{\textwidth}%
    \exampleinput{#1}%
    \exampleoutput{#1}%
  \end{minipage}%
}

\newcommand{\makeHExample}[1]{%
  \twocol{\exampleinput{#1}}{\exampleoutput{#1}}%
}

\newcommand{\example}[2][h]{%
  \ifUseExample\vspace{5pt}\else\UseExampletrue\fi
  \vspace{2pt}
  \ifeq{#1}{h}{\makeHExample{#2}}%
  \ifeq{#1}{v}{\makeVExample{#2}}%
}

% Początek i koniec dokumentu

\newcommand{\start}{%
  \ifDocumentHasSet\else\begin{document}\DocumentHasSetfalse\fi%
  \begin{tasktext}%
}

\newcommand{\finish}{%
  \end{tasktext}%
  \ifDocumentHasSet\else\end{document}\fi%
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

\newcommand{\tSection}[1]{%
  \tCustomSection{#1}{15pt}%
}

\newcommand{\tsection}[1]{%
  \tSection{#1}%
}

\newcommand{\tSmallSection}[1]{
  \par\vspace{5pt}%
  \noindent%
  \tc{#1}%
  \par\vspace{2pt}%
}

\newcommand{\tCustomSection}[2]{%
  \par\vspace{#2}%
  \noindent%
  {\Large\tc{#1}}%
  \par\vspace{2pt}%
}

% Talentowy kolor do zaznaczania zmiennych

\newcommand{\tc}[1]{%
  \ifmmode%
    \StrLen{#1}[\@tmpStrLen]%
    \ifnum\@tmpStrLen=1%
      {\fontfamily{ptm}\textcolor{talentBlue}{\textbf{#1}}}%
    \else%
      \textcolor{talentBlue}{\mathbf{#1}}%
    \fi%
  \else%
    {\fontfamily{ptm}\textcolor{talentBlue}{\textbf{#1}}}%
  \fi%
}

% Testy ocen 

\newcommand{\ocen}[1]{%
  \begin{description}%
    \setlength{\itemsep}{2pt}%
    #1%
  \end{description}%
}

\newcommand{\testOcen}[2]{%
  \item[]\tc{\taskID#1:}\hspace{5pt}#2%
}

% Tabelka z podzadaniami

\newcommand{\subtaskTable}[2][100]{
  \setcounter{subtasksCounter}{0}
  \setcounter{subtasksPiontSum}{0}
  \begin{center}
    \begin{tabular}{|c|l|c|} \hline
      \tc{Nr} & \tc{\textTestCasess} & \tc{\textPoints} \\ \hline
      #2
    \end{tabular}
  \end{center}
  \ifneq{\arabic{subtasksPiontSum}}{#1}{%
    \errmessage{Wrong total points (\string\subtaskTable[point]{...})}%
  }
}

\newcommand{\subtask}[2]{
  \stepcounter{subtasksCounter}%
  \addtocounter{subtasksPiontSum}{#1}%
  \arabic{subtasksCounter} & \begin{tabular}{@{}l@{}} #2 \end{tabular} & #1 \\ \hline
}
