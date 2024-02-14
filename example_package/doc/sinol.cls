% Plik stylu treści talentowej
%
% Based on sinol.cls made by:
% Grzegorz Jakacki, Tomasz Waleń, Marcin Kubica, Jakub Pawlewicz
% Adam Iwanicki, Szymon Acedanski, Tomasz Idziaszek, Jakub Radoszewski

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\NeedsTeXFormat{LaTeX2e}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\sinolVersion{0.0.1}
\ProvidesClass{sinol}[Stowarzyszenie Talent \sinolVersion]
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\RequirePackage[T1]{fontenc}
\usepackage{lmodern}
\RequirePackage{epsf}
\RequirePackage{graphicx}
\RequirePackage{ifpdf}
\RequirePackage{fancyhdr}
\RequirePackage[english,polish]{babel}
\RequirePackage[latin2,utf8]{inputenc}
\RequirePackage{verbatim}
\RequirePackage{xcolor}
% \RequirePackage{titlesec}
% \raggedbottom
% \RequirePackage{auto-pst-pdf}
% \RequirePackage{titlesec}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Opcje dotyczace kodowania
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\sinolInputEncoding{utf8}
\frenchspacing

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% rozmiar papieru
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% zmienne logiczne
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newif\ifsinolshortages \sinolshortagesfalse % niedoprecyzowania
\newif\ifsinolerrors  \sinolerrorsfalse % bledy
\newif\ifmetric  \metrictrue  % czy drukowac metryke
\newif\ifzawodnik \zawodnikfalse  % czy wersja dla zawodnika
\newif\ifsignaturedefed \signaturedefedfalse % czy zdefiniowano sygnature
\newif\ifdatedefed \datedefedfalse  % czy podano date
\newif\ifetapdefed \etapdefedfalse  % czy podano etap
\newif\ifkonkursdefed \konkursdefedfalse  % czy podano konkurs
\newif\ifdaydefed \daydefedfalse  % czy podano dzien
\newif\ifgroupdefed \groupdefedfalse  % czy podano dzien
\newif\ifRAMdefed \RAMdefedfalse  % czy podano dost�pn� pami��
\newif\iftimedefed \timedefedfalse % czy podano czas dzia�ania
\newif\ifDocVersiondefed % czy zdefiniowano wersj� dokumentu
\DocVersiondefedfalse    % (domy�lnie nie)
\newif\ifCountrydefed \Countrydefedfalse % Czy zdefiniowano kraj
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


\newcommand\?[1]{%
% w zaleznosci od wybranego stylu, komentarze moga sie pojawiac
% tuz po niejasnosci, jako przypis lub na koncu
  \def\@tempf{footnote}\def\@tempa{appendix}\def\@tempm{margin}%%
  \edef\@tempcstyle{\cstyle}%
  \if@minipage\def\@tempcstyle{inline}\fi%
  \ifx\@tempcstyle\@tempf%
%%%% uwagi jako przypisy
    \footnote{#1}% 
  \else%
    \ifx\@tempcstyle\@tempm%
%%%% uwagi na marginiesie
       \stepcounter{sinolCommentNumber}%
       $^\thesinolCommentNumber$%
       \marginpar{\raggedright \footnotesize $^\thesinolCommentNumber$#1}%
    \else%
       \ifx\@tempcstyle\@tempa%
%%%% tradycyjna uwaga bezpo�rednio w tek�cie
         \addComment{#1}%
       \else%
         {
         \tt
         [[[#1]]]
         }
       \fi%
    \fi%
  \fi%
  \global\sinolshortagestrue%
}
% komentarze do treści zadań
%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\cstyle{inline}
\newcounter{sinolCommentNumber}
\global\def\comments{}
\newcommand\commentStyle[1]{
  \edef\cstyle{#1}%
}
%
\newcommand\addComment[1]{%
\stepcounter{sinolCommentNumber}%
$^\thesinolCommentNumber$%
\edef\comments{\comments\par $^\thesinolCommentNumber$ #1}
}
% 
\newcommand\showComments{
  \def\@empty{}
  \ifx\comments\@empty\else
    \section{\sinolSNameUwagi}    
    \comments
  \fi
}
% uwaga do tre�ci zadania
\renewcommand\comment[2]{%
  {\it \underline{#1}}
  \?{#2}
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% rozwijajace \uppercase
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\ucase#1{\expandafter\uppercase\expandafter{#1}}
\def\lcase#1{\expandafter\lowercase\expandafter{#1}}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% logo
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\LOGO{
  \leavevmode
  \hbox{
    \vbox to 0pt{
      \vss
      \hbox{
        \includegraphics[height=1.143cm]{\sinolContestLogo}%
      }
    }
  }
}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \ifundef{<makro>}{<jesli tak>}{<jesli nie>}
% --- wykonuje jeden z blokow, w zaleznosci od tego,
%     czy makro jest zdefiniowane
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\ifundef#1#2#3{
  \expandafter
  \ifx\csname #1\endcsname\relax
    #2
  \else
    #3
  \fi
}
\def\ifeq#1#2#3{%
  \edef\@tempeqa{#1}%
  \edef\@tempeqb{#2}%
  \ifx\@tempeqa\@tempeqb
    #3
  \fi
}
\def\ifneq#1#2#3{%
  \edef\@tempeqa{#1}%
  \edef\@tempeqb{#2}%
  \ifx\@tempeqa\@tempeqb\else
    #3
  \fi
}


\definecolor{talentBlue}{RGB}{22, 63, 119} % logo
% \definecolor{talentBlue}{RGB}{31, 101, 157} % środek
% \definecolor{talentBlue}{RGB}{31, 129, 189} % Jasny (SZU)
% \definecolor{talentBlue}{RGB}{31, 73, 125} % Ciemny
\definecolor{talentBrown}{RGB}{97, 31, 30}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% numery plikow
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\chardef\inffile=15 % plik wejsciowy (np. testy)
\chardef\errfile=14 % plik wyjsciowy
\chardef\tmpfile=13 % plik tymczasowy
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% dane do metryki
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\sinolHistory{}
\def\sinolSignature{}
\def\sinolDocVersion{}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \concludedecls --- uruchamiane po przeczytaniu deklaracji
% \concludetext --- uruchamiane po przeczytaniu tekstu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\concludedecls}{}
\newcommand{\concludetext}{}
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% numer rozdzialu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcount\sinolSectionNumber \sinolSectionNumber=0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Footnote-ki indeksowane symbolami, a nie liczbami. 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\def\thefootnote{\fnsymbol{footnote}} 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% \infoutput{<tekst>} --- wyprowadza do pliku informacyjnego
% \erroutput{<tekst>} --- wyprowadza do pliku z bledami
% \erroutputWrongSection{<jest>}{<winno byc>} --- wyprowadza
%   informacje o blednej nazwie rodzialu
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\newcommand{\infoutput}[1]{
  \immediate\write\inffile{#1}
}

\newcommand{\erroutput}[1]{
  \immediate\write\errfile{#1}
  \global\sinolerrorstrue
}

\newcommand{\tSection}[1]{
  {
    \setlength\parindent{0pt}
    \setlength\parskip{15pt}
    \color{talentBlue}
    \Large
    \textbf{#1}
    \color{black}
  }
  \setlength\parskip{2pt}
}

\newcommand{\tSmallSection}[1]{
  {
    \setlength\parindent{0pt}
    \setlength\parskip{5pt}
    \color{talentBlue}
    % \Large
    \textbf{#1}
    \color{black}
  }
  \setlength\parskip{2pt}
}


\newcommand{\noSkiptSection}[1]{
  {
    \setlength\parindent{0pt}
    \setlength\parskip{0pt}
    \color{talentBlue}
    \Large
    \textbf{#1}
    \color{black}
  }
  \setlength\parskip{2pt}
}


\newcommand{\tc}[1]{
  \color{talentBlue}
  \textbf{#1}
  \color{black}
}

\newcommand{\erroutputWrongSection}[2]{%
  \erroutput{bledna nazwa lub lokalizacja rozdzialu '#1', spodziewane '#2'}%
}

\newlength{\imgwidth}
% podpis pod/nad obrazkiem
\newcommand\imgcaption[1]{%
\def\capwidth{\textwidth}%
\addtolength\capwidth{-1cm}%
\centerline{\begin{minipage}{\capwidth}\footnotesize #1\end{minipage}}%
}
%
% rysunek #1-plik, #2-podpis, #3-gdzie podpis (t-na gorze, b-na dole)
\newcommand\img[3]{%
  \def\tmparg{#3}
  \def\tmpb{b}
  \setlength\imgwidth{\textwidth}%
  \addtolength\imgwidth{-2cm}%
  \begin{center}%
  \begin{minipage}{\imgwidth}%
  \ifx\tmparg\tmpb
    $$\includegraphics{#1}$$%
    \hrule%
    \smallskip%
    \imgcaption{#2}%
  \else
    \imgcaption{#2}%
    \smallskip%
    \hrule%
    \smallskip%
    $$\includegraphics{#1}$$%
  \fi
  \end{minipage}\end{center}
}
%
% rysunek z podpisem na gorze
\newcommand\timg[2]{\img{#1}{#2}{t}}
% rysunek z podpisem na dole
\newcommand\bimg[2]{\img{#1}{#2}{b}}
\newcommand\plainimg[1]{$\includegraphics{#1}$}
% tryb dwukolumnowy (kolumny -- #1 i #2) 
\newcommand\twocol[2]{%
  \begin{center}%
  \begin{minipage}[t]{0.5\textwidth}%
  \vspace{0pt}%
  {#1}%
  \end{minipage}\hfill%
  \begin{minipage}[t]{0.5\textwidth}%
  \vspace{0pt}%
  {#2}%
  \end{minipage}%
  \end{center}
}


\let\oldpagestyle\pagestyle
\def\sinolPageStyle{fancy}
\renewcommand{\pagestyle}[1]{%
  \gdef\sinolPageStyle{#1}%
  \oldpagestyle{#1}
}

\newcommand{\signature}[1]{%
  \def\sinolSignature{#1}%
  \infoutput{[signature][#1]}%
  \global\signaturedefedtrue
}

\newcommand{\history}[3]{%
  \edef\sinolHistory{\noindent $\bullet$\ v.\,#3: #1, #2\par\sinolHistory}%
  \infoutput{[history][#1][#2][#3]}%
  \gdef\sinolDocVersion{#3}%
  \DocVersiondefedtrue%
}

\newcommand{\uses}[1]{%
  \infoutput{[uses][#1]}%
}

\renewcommand{\date}[1]{%
  \def\sinolDate{#1}%
  \global\datedefedtrue
}

\newcommand{\etap}[1]{%
  \def\sinolEtap{#1}%
  \global\etapdefedtrue
}

\newcommand{\konkurs}[1]{%
  \def\sinolKonkurs{#1}%
  \global\konkursdefedtrue
}

\renewcommand{\day}[1]{%
  \def\sinolDay{#1}%
  \global\daydefedtrue
}

\newcommand{\group}[1]{
  \def\sinolGroup{#1}%
  \global\groupdefedtrue
}

\newcommand{\RAM}[1]{
  \def\sinolRAM{#1}%
  \global\RAMdefedtrue
}

\newcommand{\Time}[1]{
  \def\sinolTime{#1\,s}%
  \global\timedefedtrue
}

\newcommand{\Country}[1]{
  \def\sinolCountry{#1}%
  \global\Countrydefedtrue
}

\newcommand{\infile}{{\ttfamily XXX.IN}}
\newcommand{\outfile}{{\ttfamily XXX.IN}}

\def\sinolContestLogo{logo.jpg}
\def\sinolLang{polish}

\def\sinolSolNameC{.c}
\def\sinolSolNameCPP{.cpp}
\def\sinolSolNamePAS{.pas}

\def\sinolTitlePomysl{Pomysł}
\def\sinolTitleZadanie{Zadanie}
\def\sinolTitleRecenzja{Recenzja}
\def\sinolTitleSpecyfikacja{Specyfikacja}
\def\sinolTitleOpracowanie{Opracowanie}
\def\sinolTitleWeryfikacja{Weryfikacja}
\def\sinolTitleCountry{Country}

\def\sinolSNamePrzyklad{Przykład}
\def\sinolSNameZadanie{Zadanie}
\def\sinolSNameWejscie{Wejście}
\def\sinolSNameWyjscie{Wyjście}
\def\sinolSNameRozwiazanieWzorcowe{Rozwiązanie wzorcowe}
\def\sinolSNameTesty{Testy}
\def\sinolSNameUwagi{Uwagi}
\def\sinolSNameHistory{HISTORIA}

\def\sinolEtapText{etap}
\def\sinolGroupText{Grupa}
\def\sinolDayText{}
\def\sinolKonkursText{}
\def\sinolSourceText{Plik źródłowy}
\def\sinolRAMText{Pamięć}
\def\sinolTimeText{Czas}

\newcommand{\iomode}[1]{
  \def\sinolIOmode{#1}
  \ifeq{#1}{files}{
    \gdef\sinolExampleInputText{Dla pliku wejściowego \infile:}
    \gdef\sinolExampleOutputText{poprawnym wynikiem jest plik wyjściowy \outfile{}:}    
  }
  \ifeq{#1}{stdin}{
    \gdef\sinolExampleInputText{\color{talentBlue}\bf Wejście:\color{black} }
    \gdef\sinolExampleOutputText{\color{talentBlue}\bf Wyjście:\color{black} }    
  }    
  \ifeq{#1}{outputonly}{
    \gdef\sinolExampleInputText{Wejście:}
    \gdef\sinolExampleOutputText{Wyjście:}    
  }    
  \ifeq{#1}{interactive}{
    % TODO: UPDATE THIS
    \gdef\sinolExampleInputText{Wejście:}
    \gdef\sinolExampleOutputText{Wyjście:}    
  }    
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Angielska wersja napisw                                % 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\DeclareOption{en}{%
\def\sinolLang{english}
%\selectlanguage{english}

\def\sinolTitlePomysl{Idea}
\def\sinolTitleZadanie{Task}
\def\sinolTitleRecenzja{Review}
\def\sinolTitleSpecyfikacja{Specification}
\def\sinolTitleOpracowanie{Analysis}
\def\sinolTitleWeryfikacja{Verification}

\def\sinolSNamePrzyklad{Example}
\def\sinolSNameZadanie{Task}
\def\sinolSNameWejscie{Input}
\def\sinolSNameWyjscie{Output}
\def\sinolSNameUwagi{Comments}
\def\sinolSNameRozwiazanieWzorcowe{Model solution}
\def\sinolSNameTesty{Tests}
\def\sinolSNameHistory{HISTORY}

\def\sinolEtapText{Stage}
\def\sinolKonkursText{}
\def\sinolDayText{}
\def\sinolSourceText{Source file}
\def\sinolRAMText{Available memory}
\def\sinolTimeText{Maximum running time}

\renewcommand{\iomode}[1]{
  \def\sinolIOmode{#1}
  \ifeq{#1}{files}{
    \gdef\sinolExampleInputText{For the input file \infile:}
    \gdef\sinolExampleOutputText{the correct result is the output file \outfile{}:}    
  }
  \ifeq{#1}{stdin}{
    \gdef\sinolExampleInputText{For the input data:}
    \gdef\sinolExampleOutputText{the correct result is:}
  }    
  \ifeq{#1}{outputonly}{
    \gdef\sinolExampleInputText{For the input data:}
    \gdef\sinolExampleOutputText{the correct result is:}
  }    
  \ifeq{#1}{interactive}{
    \gdef\sinolExampleInputText{For the input data:}
    \gdef\sinolExampleOutputText{the correct result is:}
  }    
}
}

\iomode{stdin}

\newcommand{\iffileexists}[3]{%
  \immediate\openin\tmpfile #1\par
  \ifeof\tmpfile
    \immediate\closein\tmpfile
    #3
  \else
    \immediate\closein\tmpfile
    #2
  \fi
}

\AtBeginDocument{
  \immediate\openout\inffile \jobname.inf
  \immediate\openout\errfile \jobname.err
}

\AtEndDocument{
  \ifsinolerrors
    \immediate\write16{SINOL: znaleziono błędy (zob. \jobname.err) !}
  \fi
  \ifsinolshortages
    \immediate\write16{SINOL: znaleziono niedoprecyzowania (występuje '[[[...]]]')}
  \fi
}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

\DeclareOption{pom}{%
  \def\sinolcat{pom}
  \def\xsinolcat{\sinolTitlePomysl}
  \newcommand{\source}[1]{%
    \def\sinolSource{#1}%
    \infoutput{[source][#1]}%
  }
  \renewcommand{\author}[1]{%
    \def\sinolAuthor{#1}%
    \infoutput{[author][#1]}%
  }
  \renewcommand{\title}[1]{%
    \def\sinolTitle{#1}%
    \infoutput{[title][#1]}%
  }
  \newcommand{\makemetric}{%
    {
      \footnotesize
      {\noindent\bfseries \sinolSourceText:}
        \ifundef{sinolSource}{\?{brak}}{\sinolSource}\par
      {\noindent\bfseries \sinolSNameHistory:}\par
      \sinolHistory
    }
  }
  \renewcommand{\concludedecls}{%
    \edef\sinolIdSignature{\sinolSignature}%
  }%
}

\DeclareOption{spe}{%
  \def\sinolcat{spe}
  \def\xsinolcat{\sinolTitleSpecyfikacja}
  \renewcommand{\title}[1]{%
    \def\sinolTitle{#1}%
    \infoutput{[title][#1]}%
  }
  \newcommand{\id}[1]{%
    \edef\ID{#1}%
    \infoutput{[id][#1]}%
  }
  \newcommand{\makemetric}{%
    {
      \footnotesize
      {\noindent\bfseries \sinolSNameHistory:}\par
      \sinolHistory
    }
  }
  \renewcommand{\concludedecls}{%
    \edef\sinolIdSignature{\sinolSignature}%
  }%
}

\newcommand\includefile[1]{
\vspace{-0.7em}
\verbatiminput{#1}
}


\def\sinolCatNameZad{zad}
\DeclareOption{zad}{%
  \def\sinolcat{zad}
  \def\xsinolcat{\sinolTitleZadanie}
  \renewcommand{\title}[1]{%
    \def\sinolTitle{#1}%
    \infoutput{[title][#1]}%
  }
  \newcommand{\id}[1]{%
    \edef\ID{#1}%
    \infoutput{[id][#1]}%
  }

  \newcommand{\exampleinputimg}[1]{%
    \edef\exampleInImg{#1}%
  }

  \newcommand{\exampleoutputimg}[1]{%
    \edef\exampleOutImg{#1}%
  }

  \newcommand{\exampleimg}[1]{%
    \edef\exampleImg{#1}%
  }

  \newcommand{\makemetric}{%
    {
      \footnotesize
      {\noindent\bfseries \sinolSNameHistory:}\par
      \sinolHistory
    }
  }

  \newcommand{\exampleinput}[1]{%
      \iffileexists{\sinolTestIn/\ID0#1.in}{%
          \includefile{\sinolTestIn/\ID0#1.in}
      }{
       \iffileexists{\ID0#1.in}{%
          \includefile{\ID0#1.in}
       }{
         \smallskip
         \?{brak pliku {\ttfamily\ID0#1.in}}\par
         \erroutput{brak pliku '\ID0#1.in'}
         \smallskip
       }
      }
  }

  \newcommand{\exampleoutput}[1]{%
    \iffileexists{\sinolTestOut/\ID0#1.out}{%
      \includefile{\sinolTestOut/\ID0#1.out}
    }{
      \iffileexists{\ID0#1.out}{%
         \includefile{\ID0#1.out}
      }{    
       \smallskip
       \?{brak pliku {\ttfamily\ID0#1.out}}\par
       \erroutput{brak pliku '\ID0#1.out'}
       \smallskip
      }
    }
  }

  \def\sinolTestIn{../in}
  
  \def\sinolTestOut{../out}
  
  \def\@exampleputtogetherh#1#2{\twocol{#1}{#2}}

  \def\@exampleputtogetherv#1#2{#1 #2}

  \newcommand{\makestandardexampleinput}[1]{%
    \noindent\sinolExampleInputText
    \ifundef{exampleInImg}{%
      \exampleinput{#1}
    }{
      \@exampleputtogetherimg{\exampleinput}{\plainimg{\exampleInImg}}
    }
  }

  \newcommand{\makestandardexampleoutput}[1]{%
    \noindent\sinolExampleOutputText
    \ifundef{exampleOutImg}{%
      \exampleoutput{#1}
    }{
      \@exampleputtogetherimg{\exampleoutput}{\plainimg{\exampleOutImg}}
    }
  }

  \newcommand{\loadtestdir}{
    \openin\tmpfile testdir.inp
    \ifeof\tmpfile
% TW, zazwyczaj ten plik nie jest stosowany, wiec komunikat o bledzie nie jest 
%     konieczny
%      \write16{SINOL: brak pliku 'testdir.inp'}
    \else
      \read\tmpfile to\sinolTestIn
      \ifeof\tmpfile
        \write16{SINOL: plik 'testdir.inp' skonczyl sie zbyt wczesnie}
      \else
        \read\tmpfile to\sinolTestOut
      \fi
    \fi
    \closein\tmpfile
  }

  \newcommand{\@makestandardexampletext}[1]{%
    \@exampleputtogethertext{%
      \makestandardexampleinput{#1}
    }{%
      \makestandardexampleoutput{#1}
    }
  }

  \newcommand{\@makeexample}[1]{%
    \loadtestdir   
    \ifundef{exampleImg}{%
      \@makestandardexampletext{#1}
    }{%
      \@exampleputtogetherimg{%
        \@makestandardexampletext{#1}
      }{
        \plainimg{\exampleImg}
      }
    }
  }


  \newcommand{\makestandardexample}[1]{%
    \let\@exampleputtogetherimg=\@exampleputtogetherh
    \let\@exampleputtogethertext=\@exampleputtogetherv
    \@makeexample{#1}
  }

  \newcommand{\makecompactexample}[1]{%
    \setlength\parskip{-15pt}
    \def\@exampleputtogetherimg##1##2{%
      \@exampleputtogetherv{##1}{%
        \begin{center}
          ##2
        \end{center}
      }
    }
    \let\@exampleputtogethertext=\@exampleputtogetherh
    \@makeexample{#1}
    \setlength\parskip{-15pt}
  }

  \renewcommand{\concludedecls}{%
    \ifundef{ID}{%
      \erroutput{brak 3-literowego identyfikatora (klauzula \string\id)}%
      \def\ID{XXX}%
    }{}%
    \def\infile{{\ttfamily \lcase{\ID}.in}}%
    \def\outfile{{\ttfamily \lcase{\ID}.out}}%
    \ifundef{sinolTitle}{%
      \erroutput{brak tytulu (klauzula \string\title)}%
      \def\sinolTitle{\?{brak tytu^^b3u}}%
    }{}%
    \ifzawodnik%
      \def\sinolIdSignature{\ucase{\ID}}%
    \else%
      \def\sinolIdSignature{\ID/\sinolSignature}%
    \fi%
    \let\oldsection\section%
    \renewcommand{\section}[1]{%
      \def\@tmparg{##1}%
      \oldsection*{##1}%
      \ifnum\sinolSectionNumber=0%
        \ifeq{\@tmparg}{\sinolSNameZadanie}{%
          \sinolSectionNumber=1%
        }%
      \fi%
      \ifcase\sinolSectionNumber%
        \ifneq{\@tmparg}{\sinolSNamePrzyklad}{%
          \erroutputWrongSection{\@tmparg}{\sinolSNamePrzyklad}%
        }%
      \or%
        \ifneq{\@tmparg}{\sinolSNameZadanie}{%
          \erroutputWrongSection{##1}{\sinolSNameZadanie}%
        }%
      \or%
        \ifneq{\@tmparg}{\sinolSNameWejscie}{%
          \erroutputWrongSection{##1}{\sinolSNameWejscie}%
        }%
      \or%
        \ifneq{\@tmparg}{\sinolSNameWyjscie}{%
          \erroutputWrongSection{##1}{\sinolSNameWyjscie}%
        }%
      \or%
        \ifneq{\@tmparg}{\sinolSNamePrzyklad}{%
          \erroutputWrongSection{\@tmparg}{\sinolSNamePrzyklad}%
        }%
      \else%
        \ifneq{\@tmparg}{\sinolSNameUwagi}{%
          \erroutput{nadmiarowy rozdzial '##1'}%
        }%
      \fi%
      \advance\sinolSectionNumber+1%
    }%
  }%

  \renewcommand{\concludetext}{
    \ifnum\sinolSectionNumber=5\else
      \erroutput{niewlasciwa liczba rozdzialow}
    \fi
    \ifeq{\cstyle}{appendix}{\showComments}
  }
}

\DeclareOption{rec}{%
  \def\sinolcat{rec}
  \def\xsinolcat{\sinolTitleRecenzja}
  \renewcommand{\title}[1]{%
    \def\sinolTitle{#1}%
    \infoutput{[title][#1]}%
  }
  \newcommand{\id}[1]{%
    \edef\ID{#1}%
    \infoutput{[id][#1]}%
  }
  \newcommand{\makemetric}{%
    {
      \footnotesize
      {\noindent\bfseries \sinolSNameHistory:}\par
      \sinolHistory
    }
  }
  \renewcommand{\title}[1]{%
    \def\sinolTitle{#1}%
    \infoutput{[title][#1]}%
  }

  \renewcommand{\concludedecls}{%
    \ifundef{ID}{%
      \def\ID{XXX}%
    }{}%
    \ifundef{sinolTitle}{%
      \def\sinolTitle{\?{tytu^^b3 zostanie wygenerowany}}%
    }{}%
    \def\sinolIdSignature{\ID/\sinolSignature}%
  }%
}

\DeclareOption{opr}{%
  \def\sinolcat{opr}
  \def\xsinolcat{\sinolTitleOpracowanie}
  \renewcommand{\title}[1]{%
    \def\sinolTitle{#1}%
    \infoutput{[title][#1]}%
  }
  \newcommand{\id}[1]{%
    \edef\ID{#1}%
    \infoutput{[id][#1]}%
  }
  \newcommand{\makemetric}{%
    {
      \footnotesize
      {\noindent\bfseries \sinolSNameHistory:}\par
      \sinolHistory
    }
  }
  \renewcommand{\title}[1]{%
    \def\sinolTitle{#1}%
    \infoutput{[title][#1]}%
  }

  \renewcommand{\concludedecls}{%
    \ifundef{ID}{%
      \def\ID{XXX}%
    }{}%
    \def\infile{{\ttfamily \lcase{\ID}.in}}%
    \def\outfile{{\ttfamily \lcase{\ID}.out}}%
    \ifundef{sinolTitle}{%
      \def\sinolTitle{\?{tytu^^b3 zostanie wygenerowany}}%
    }{}%
    \def\sinolIdSignature{\ucase{\ID}}%
    %
    \newif\ifsectionPresentTesty \sectionPresentTestyfalse%
    \newif\ifsectionPresentRozwiazanieWzorcowe%
         \sectionPresentRozwiazanieWzorcowefalse%
    %
    \let\oldsection\section%
    \renewcommand{\section}[1]{%
      \def\@tmparg{##1}%
      \oldsection{##1}%
      \ifx\@tmparg\sinolSNameTesty%
        \ifsectionPresentTesty%
          \erroutput{powtorzony rozdzial '\@tmparg'}%
        \else%
          \global\sectionPresentTestytrue%
        \fi%
      \fi%
      \ifx\@tmparg\sinolSNameRozwiazanieWzorcowe%
        \ifsectionPresentRozwiazanieWzorcowe%
          \erroutput{powtorzony rozdzial '\@tmparg'}%
        \else%
          \global\sectionPresentRozwiazanieWzorcowetrue%
        \fi%
      \fi%
    }%
  }%

  \renewcommand{\concludetext}{
    \ifidealSolutionPresent\else
      \erroutput{brak odniesienia do rozwiazania optymalnego}
    \fi
    \ifsectionPresentTesty\else
      \erroutput{brak rozdzialu '\sinolSNameTesty'}
    \fi
    \ifsectionPresentRozwiazanieWzorcowe\else
      \erroutput{brak rozdzialu '\sinolSNameRozwiazanieWzorcowe'}
    \fi
  }

  \newif\ifidealSolutionPresent \idealSolutionPresentfalse

  \newcommand{\solution}[1]{%
    \infoutput{[solution][##1]}%
    \infoutput{[uses][prog/##1]}%
    {\ttfamily prog/\ID#1}%
    \def\@tmparg{#1}
    \ifx\@tmparg\sinolSolNameC
      \idealSolutionPresenttrue
    \fi
    \ifx\@tmparg\sinolSolNameCPP
      \idealSolutionPresenttrue
    \fi
    \ifx\@tmparg\sinolSolNamePAS
      \idealSolutionPresenttrue
    \fi
  }

  \newenvironment{tests}{%
    \newcommand{\test}[3]{%
      \item {\ttfamily \ID##1.IN} ($##2$ sek.) ##3\par
      \infoutput{[test][##1]}
      \infoutput{[uses][in/##1.in]}
      \infoutput{[uses][out/##1.in]}
    }
    \begin{itemize}
  }{%
    \end{itemize}
  }
}


\DeclareOption{wer}{%
  \def\sinolcat{wer}
  \def\xsinolcat{\sinolTitleWeryfikacja}
  \renewcommand{\title}[1]{%
    \def\sinolTitle{#1}%
    \infoutput{[title][#1]}%
  }
  \newcommand{\id}[1]{%
    \edef\ID{#1}%
    \infoutput{[id][#1]}%
  }
  \newcommand{\makemetric}{%
    {
      \footnotesize
      {\noindent\bfseries \sinolSNameHistory:}\par
      \sinolHistory
    }
  }
  \renewcommand{\title}[1]{%
    \def\sinolTitle{#1}%
    \infoutput{[title][#1]}%
  }

  \newcommand{\solution}[1]{%
    \infoutput{[solution][##1]}%
    \infoutput{[uses][prog/##1]}%
    {\ttfamily prog/\ID#1}%
    \def\@tmparg{#1}
    \ifx\@tmparg\sinolSolNameC
      \idealSolutionPresenttrue
    \fi
    \ifx\@tmparg\sinolSolNameCPP
      \idealSolutionPresenttrue
    \fi
    \ifx\@tmparg\sinolSolNamePAS
      \idealSolutionPresenttrue
    \fi
  }

  \renewcommand{\concludedecls}{%
    \ifundef{ID}{%
      \def\ID{XXX}%
    }{}%
    \ifundef{sinolTitle}{%
      \def\sinolTitle{\?{tytu^^b3 zostanie wygenerowany}}%
    }{}%
    \def\sinolIdSignature{\ID/\sinolSignature}%
  }%
}

\DeclareOption{zawodnik}{%
  \global\zawodniktrue
  \ifx\sinolcat\sinolCatNameZad
    \global\metricfalse
    \renewcommand{\?}[1]{%
      [[[#1]]]%
      \errmessage{SINOL: przy opcji 'zawodnik' nie wolno uzywac %
        '\string\?\string{...\string}'}
    }
  \else
    \errmessage{SINOL: opcja 'zawodnik' moze wystepowac tylko po opcji 'zad'}
  \fi
}

\DeclareOption*{\PassOptionsToClass{\CurrentOption}{article}}
\ProcessOptions\relax
\PassOptionsToClass{a4paper}{article}
\LoadClass{article}
%% \RequirePackage{polski}

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% rozmiar papieru
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
\setlength{\textwidth}{168mm} %{180mm}
\setlength{\textheight}{265mm} %{257mm}
\setlength{\oddsidemargin}{0pt}
\setlength{\topmargin}{0pt}
\setlength{\hoffset}{-4mm} % this means 1in-15mm
\setlength{\voffset}{-30mm} % this means 1in-15mm
\setlength{\topmargin}{0pt}
\setlength{\parskip}{0pt}
%% w przypadku stylu fancy, trzeba wy��czy� rysowanie linii w nag��wku
%\headrulewidth 0pt
\renewcommand{\headrulewidth}{0pt}
\renewcommand{\footrulewidth}{0.4pt}
\newcommand{\start}{
  \begin{document}
  \begin{tasktext}
}

\newcommand{\finish}{
  \end{tasktext}
  \end{document}
}

\lfoot[L]{Stowarzyszenie Talent (talent.edu.pl)}
\rfoot{\sinolTitle\ifDocVersiondefed\ -\ \ID\fi}

\newenvironment{tasktext}{%

  \expandafter\selectlanguage\expandafter{\sinolLang}%
  \expandafter\inputencoding\expandafter{\sinolInputEncoding}%
 
  {
    \leftline{
      \begin{minipage}[t]{0.8\textwidth}
      \setlength{\parindent}{-4pt}
      \color{talentBlue}
      \sffamily\bfseries
      \LARGE
      \sinolTitle
      
      \end{minipage}
    }
    \rightline{
      \hbox to\hsize{\hfil\LOGO}
    }
  }
  \smallskip
  {
    \color{talentBrown}
    \hrule height 3pt \relax
  }
  \smallskip
  % \concludedecls
  %
  \ifzawodnik
  \color{talentBlue}
  \smallskip
  \hbox to \hsize{
    \begin{minipage}[t]{1\textwidth}
    \setlength{\parindent}{-1pt}
    \def\@tempempty{}
    \bf
    %
    %% Konkurs pokazuje się tylko gdy jest niepusty
    \ifkonkursdefed%
      \ifx\sinolKonkurs\@tempempty\ %
      \else%
        \sinolKonkursText%
        \sinolKonkurs,\ %
      \fi%
    \else\?{brak}\erroutput{brak konkursu}\fi%
    %
    %% Dzień pokazuje się tylko gdy jest niepusty
    \ifdaydefed%
      \ifx\sinolDay\@tempempty.
      \else
        \sinolDayText 
        \sinolDay.
      \fi%
    \else\?{brak}\erroutput{brak dnia}\fi%
    %
    % Grupa
    \ifgroupdefed%
      \ifx\sinolGroup\@tempempty%
      \else%
        \sinolGroupText:\
        \sinolGroup.
      \fi%
    \else\fi%
    %
    % Dostępna pamięć -- pokazuje sie tylko gdy
    % nie jest pusta i jest zdefiniowana
    \ifRAMdefed
      \ifx\sinolRAM\@tempempty
      \else
        \sinolRAMText:\
        \sinolRAM\,MB. 
      \fi
    \else\fi
    % 
    %% Limit czasu -- pokazuje się tylko gdy nie jest pusty i jest zdefiniowany.
    \iftimedefed
      \ifx\sinolTime\@tempempty%
      \else%
        \sinolTimeText:\
        \sinolTime.
      \fi%
    \else\fi%
    \hbox to 0pt {\vbox to 0pt {\begin{itemize} \item[] \end{itemize}\vss}}
    % Powyzsza linijka to smutny hak, ktory wymusza, zeby itemize'y
    % generowaly prawidlowe odstepy. Nie wiem dlaczego to dziala, nie wiem dlaczego
    % bez tego nie dziala. Have fun.
      \hfill
      \ifdatedefed{\it\sinolDate}\else\?{brak daty}\erroutput{brak daty}\fi
    \end{minipage}
    }
    \color{black}
    \bigskip
  % \else
  % % Jeśli to nie jest treść zadania tylko inny dokument: TODO
  %   \vskip1.5pt
  %   {\tiny\rightline{%
  %     dokument systemu SINOL \sinolVersion
  %   }}
  %   \smallskip
  \fi
  \noindent
  \ignorespacesafterend
}{
  \concludetext
  \closeout\inffile
  \closeout\errfile
  % \end{document}
}

% Odstepy w itemize
\def\@listi{\leftmargin\leftmargini
   \parsep 0\p@ \@plus1\p@ \@minus\p@
   \partopsep 3\p@ \@plus1\p@ \@minus\p@
      \topsep 3\p@ \@plus1\p@ \@minus0\p@
      \itemsep 3\p@ \@plus1\p@ \@minus\p@}
\let\@listI\@listi




