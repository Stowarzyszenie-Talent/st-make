% Latex style for Talent (https://talent.edu.pl) statemnts
% 
% Copyright (c) Stanisław Czech 2024
% Copyright (c) Jakub Rożek 2024
% Provided under MIT licence 
%
% Inspired by sinol.cls made by OI

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Formalności
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
\def\codeVersion{0.0.6}
\ProvidesClass{talentTex}[2024/05/21 Stowarzyszenie Talent \codeVersion]

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
\RequirePackage{lmodern}

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
% Definicje techniczne
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

\NewDocumentCommand{\tworow}{ O{10} m m }{%
  \begin{center}%
    \begin{minipage}{\textwidth}%
      #2%
    \end{minipage}%
    \par\vspace{#1pt}\par%
    \begin{minipage}{\textwidth}%
      #3%
    \end{minipage}%
  \end{center}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Definicje nagłówka
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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

\newcommand{\Header}{%
  \noindent%
  \begin{minipage}[b]{0.75\textwidth}%
    \huge\tc{\taskTitle}%
  \end{minipage}%
  \hfill%
  \begin{minipage}[b]{0.22\textwidth}%
    \hfill\raisebox{-4pt}{\includegraphics[width=\textwidth]{\pathContestLogo}}%
  \end{minipage}%
  \smallskip%
  {\color{talentBrown}\hrule height 1.75pt}%
  \smallskip%
  \topInformationBar%
  \bigskip%
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
\def\textNr{Nr}

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareOption{opi}{
  \renewcommand{\topInformationBarText}{
    \Large%
    \textSolutionDescription%
  }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareOption{opr}{
  \renewcommand{\topInformationBarText}{
    \Large%
    \textDocumentation%
  }
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\PassOptionsToClass{a4paper}{article}
\LoadClass{article}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Wygląd  dokumentu (papier, stopka, tasktext)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% rozmiar papieru
\setlength{\textwidth}{168mm} % {180mm}
\setlength{\textheight}{265mm} % {257mm}
\setlength{\oddsidemargin}{0pt}
\setlength{\hoffset}{-4mm} % this means 1in-15mm
\setlength{\voffset}{-30mm} % this means 1in-15mm
\setlength{\topmargin}{0pt}
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0.4pt}

% stopka
\pagestyle{fancy}
\lfoot{Stowarzyszenie Talent (talent.edu.pl)}
\rfoot{\begin{minipage}[t]{0.45\textwidth}\raggedleft\taskTitle\ - \taskID\end{minipage}}

% Przestrzeń tasktext
\newenvironment{tasktext}{\Header}{}

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
% Komendy dostępne w klasie talentTex
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Początek i koniec tasktext

\newcommand{\start}{%
  \ifDocumentHasSet\else\begin{document}\DocumentHasSetfalse\fi%
  \begin{tasktext}%
}

\newcommand{\finish}{%
  \end{tasktext}%
  \ifDocumentHasSet\else\end{document}\fi%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Pokazywanie testów wstępnych

\newcommand{\includefile}[1]{
\vspace{-0.9em}
\verbatiminput{#1}
}

\newcommand{\exampleinput}[1]{
  \noindent{\color{talentBlue}\bf\textInput:}\par
  \iffileexists{\pathTestIn/\taskID0#1.in}{
    \includefile{\pathTestIn/\taskID0#1.in}
  }{
    \color{red}{No file {\ttfamily\pathTestIn/\taskID0#1.in}}
  }\par
}

\newcommand{\exampleoutput}[1]{
  \noindent{\color{talentBlue}\bf\textOutput:}\par
  \iffileexists{\pathTestOut/\taskID0#1.out}{
    \includefile{\pathTestOut/\taskID0#1.out}
  }{
    \color{red}{No file {\ttfamily\pathTestOut/\taskID0#1.out}}
  }\par
}

\newcommand{\example}[2][h]{%
  \ifUseExample\vspace{3pt}\else\vspace{-8pt}\UseExampletrue\fi
  \ifeq{#1}{h}{\twocol{\exampleinput{#2}}{\exampleoutput{#2}}}%
  \ifeq{#1}{v}{\tworow[10]{\exampleinput{#2}}{\exampleoutput{#2}}}%
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% obsługa zdjeć

% \img[szerokosć][opis][t/b]{plik} (t-na gorze, b-na dole)
\NewDocumentCommand{\img}{ O{0.8} o O{b} m }{%
  \begin{center}%
    \begin{minipage}{#1\textwidth}%
      \IfValueT{#2}{\ifeq{#3}{t}{\footnotesize#2\smallskip\hrule\smallskip}}%
      \includegraphics[width=\textwidth]{#4}%
      \IfValueT{#2}{\ifeq{#3}{b}{\smallskip\hrule\smallskip\footnotesize#2}}%
    \end{minipage}%
  \end{center}%
}

\newcommand{\imgt}[3][0.8]{\img[#1][#3][t]{#2}}
\newcommand{\imgb}[3][0.8]{\img[#1][#3][b]{#2}}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Sekcje w dokumencie

\newcommand{\tSection}[1]{%
  \tCustomSection{#1}{15pt}%
}
\let\tsection\tSection

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Tabelka z podzadaniami

\newcommand{\subtaskTable}[2][100]{
  \setcounter{subtasksCounter}{0}
  \setcounter{subtasksPiontSum}{0}
  \begin{center}
    \begin{tabular}{|c|l|c|} \hline
      \tc{\textNr} & \tc{\textTestCasess} & \tc{\textPoints} \\ \hline
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
