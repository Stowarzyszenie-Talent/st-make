<!-- Jak nie umiesz otworzyć by łądniej wyglądało, tu jest czytelniej -->
<!-- https://github.com/Stowarzyszenie-Talent/st-make/tree/main/example_package -->

<!-- ---------------------------------------------------------------------- -->
# **Szablon paczki**
Jest to przykładoway szblon paczki, który zalecamy uzywać.
Jedynie dla zadań interaktywnych jest on inny.
(Jeszcze nie zrobiliśmy dla niego szablonu).
W przypadku chęci zrobienia takiego zadania obecnie najlepiej skontaktuj się z kimś kto wie jak to się robi.

Aktualna wersja paczki zawsze znajduje się zawsze
[na githubie](https://github.com/Stowarzyszenie-Talent/st-make/tree/main/example_package).
`st-make init`, pobiera właśnie tą wersję.

# **ogólne informacje**
<details><summary></summary>

1. Do kompilacji paczki używamy skryptu `st-make`.
Jest on dostępny [na githubie](https://github.com/Stowarzyszenie-Talent/st-make).
1. Każde zadanie ma `tag` - jest to najczęściej 3 literowy skrót.
Wszystkie nazwy plików w paczce zaczynamy od niego.
W przykładowej paczce jest to `abc`.

Skrypt `st-make` je potem kompiluje do pdf, tak samo system sio.

Szablony tych dokumentów są dostępne w paczce.

Do tworzenia treści używamy kilku poleceń z `talentTex.cls`:

- tu będą wkrótce wymienione.

</details> <!-- koniec: ogólne informacje -->


<!-- ---------------------------------------------------------------------- -->
# **doc**
<details><summary></summary>

Ten folder zawiera wszystkie pliki tekstowe (pdf, tex, doc, img, ...).
- `{TAG}zad.tex` - treść zadania, (przyjmowane jest też w wordzie).
- `{TAG}opr.tex` - dokument z opracowaniem zadania.
Posiada wszelkie informacje techniczne o zadaniu.
- `{TAG}opi.tex` - dokument z opisem rozwiązania.

</details> <!-- koniec: doc -->


<!-- ---------------------------------------------------------------------- -->
# **prog**
<details><summary></summary>

W tym katalogu będziemy trzymać wszystkie programy.
Ważną rzeczą jest aby programy **nie miały żadnych warningów**.



<!-- ---------------------------------------------------------------------- -->
<details><summary>rozwiązania</summary>

# rozwiązania

Nazewnictwo:
- `{TAG}.` - **wzorcówka**, np. `abc.cpp`.
Ten program jest wzorcowym i to on generuje nam poprawne odpowiedzi.
- `{TAG}{cyfra}{suffix}.` - rozwiązania poprawne, na przykład `zad.cpp`, `zad2.cpp`, `zad3_alternatywna_wzorcowka.cpp`, `zad104.py`,
- `{TAG}s{cyfra}{suffix}.` - rozwiązania wolne, na przykład `zads1.cpp`, `zads3_brute_n_kwadrat.cpp`, `zads13.py`,
- `{TAG}b{cyfra}{suffix}.` - rozwiązania niepoprawne, na przykład `zadb1.cpp`, `zadb3_heura.cpp`, `zadb10.py`,

Każdy program musi mieć inną nazwę po usunięciu rozszerzeń.

Zalecamy nazywać programy kolejnymi cyframi. `abc.cpp`, `abc2.cpp`, `abc3.cpp`, `abcs1.cpp`, `abcs2.cpp`, `abcb1.cpp`, ...

Generalnie rozwiązania poprawne to takie które działają w odpowiedzniej złożoności i dają dobre wyniki (wolny python też tu należy).
Programy wolne to takie co mają gorszą złożoność czasową i dają dobre wyniki.
Programy błędne to takie co co dają złe wyniki.
Na przykład jak mamy wolny program co daje złe wyniki to damy go do grupy błędnych.

Każdy kod w pierwszych liniach powinien mieć komentarz (taki jak w szablone).
Dodatkowo kody powinny być czytelne i najlepiej zaopatrzone w komentarze (zwłaszcza wzorcówka).

</details><!-- koniec ## programy -->

<!-- ---------------------------------------------------------------------- -->
<details><summary>ingen</summary>

# ingen
`{TAG}ingen.cpp`

Słóży do generowanie plików `.in`.

Ingen powinien:
* Po uruchomieniu (bez żadnych argumentów) wygenerować
  w bieżącym katalogu odpowiednie pliki z danymi wejściowymi.
* Używać liczb losowych z pakietu `oi.h`,
* Każdy test (lub grupa testów) powinna mieć osobnego seeda.
* Być w pełni deterministyczny - na przykład można inicjować
  ziarno generatora liczb losowych stałą wartością.
* Idealnie odzwiercziedlać foramt testu padany w treści.
* Na końcu pliku dawań nową linie, a na końcu wiersza **nie** dawać białych znaków.

</details> <!-- koniec ## ingen -->

<!-- ---------------------------------------------------------------------- -->
<details><summary>inwer</summary>

# inwer
`{TAG}inwer.cpp`

Słóży do sprawdzenia czy testy `.in` spełniają założenia z treści.

Inwer powinien:
* Wczytywać pliki wejściowe za pomocą pakietu `oi.h`.
* Zawierać ograniczenia z treści zadania w formie stałych.
  Duże stałe podajemy w sposób czytelny, np. jako iloczyny.
* W przypadku poprawnej weryfikacji ma wypisać `OK`
  oraz, w jednej linii, krótką charakterystykę testu
  (wartości najważniejszych parametrów) i skończyc działanie kodem 0.
  Wypisany komentarz ma na celu upewnienie się, że każda grupa testów
  zawiera testy z wartościami brzegowymi
  (na przykład minimalne i maksymalne ograniczenia na `n`,
  drzewa w postaci ścieżki i gwiazdy, itd).
* Wypisać również numery podzadań, które pasują do tego testu,
  lub nazwy testów ocen, które pasują do tego testu.
  (należy inwerem się upewnić, że testy ocen są dokładnie takie, jak w treści).
* W przypadku błędnej weryfikacji wypisać informację
  o błędzie i kończyć działanie kodem niezerowym.
  Można używać funkcji `assert` a najlepiej `oi_asert` z `oi.h`.
* Sprawdzać, czy dane wejściowe są idealnie zgodne z opisem
  z treści zadania, **z dokładnością do każdego białego znaku**.
  Nie mogą pojawić się żadne zbędne białe znaki.

</details> <!-- koniec ## inwer -->

<!-- ---------------------------------------------------------------------- -->
<details><summary>checkerka</summary>

# checkerka
`abcchk.cpp`

W przypadku zadań z jednoznaczną odpowiedzią, nie dodajemy tego programu. System SIO ma domyślną chekierke, która porównuje odpowiedź z wzorcową.

W przypadku zadań, w których istnieje wiele poprawnych odpowiedzi,
paczka powinno zawierać weryfikator danych wyjściowych.
Należy zwrócić **szczególną** uwagę, aby weryfikator wyjścia działał poprawnie nawet dla bardzo złośliwych danych (np. nie można nic zakładać
o długości ciągów znaków znajdujących się w odpowiedzi zawodnika).
Do każdego komunikatu, który może wypisać weryfikator, powinno istnieć rozwiązanie błędne lub istnieć w programie test jednostkowy, który powoduje wypisanie tego komunikatu.

Weryfikator należy starać się **napisać wydajnie**, gdyż w trakcie zawodów jest on uruchamiany bardzo wiele razy.

Checkerka powinna:
* Być uruchamiane w następujący sposób: `./{TAG}chk wejście wyjście_zawodnika wyjście_wzorcowe`.
* Wczytyać pliki za pomocą pakietu `oi.h`.
* wypisać odpowiedź w następującym formacie:
  * pierwszy wiersz powinien zawierać jedno słowo:
    * `OK` - jeśli odpowiedź jest poprawna, lub
    * `WRONG `-  w przeciwnym przypadku.
  * drugi wiersz (opcjonalnie) powinien zawierać komentarz do
    odpowiedzi zawodnika (np. przyczyny uznania rozwiązania za niepoprawne)
  * trzeci wiersz (opcjonalnie) powinien zawierać jedną liczbę całkowitą
    z przedziału [0, 100] oznaczającą (w procentach) liczbę punktów, którą należy przyznać zawodnikowi za test.
* Pozwala na zbędne białe znaki tylko i wyłącznie na końcu linii i na końcu wyjścia oraz na **brak końca linii na końcu wyjścia** (ważne!).

</details> <!-- koniec ## checkerka -->

<!-- ---------------------------------------------------------------------- -->
<details><summary>oi.h</summary>

# oi.h
Jest to biblioteka ułatwiająca pisanie paczki.
Jednocześnie pozawala uniknąć masy rzeczy.
Jest wymagane by wszystkie operacje robić za jej pomocą.

<!-- ---------------------------------------------------------------------- -->
<details><summary>Scanner (Wczytywanie)</summary>

Są 3 tryby wczytywania danych:

| tryb       | eof              | nl           | destruktor   |
| ---------- | :--------------: | :----------: | :----------: |
| UserOutput | ignoruje nl i ws | ignoruje ws  | wczytuje eof |
| Lax        | ignoruje nl i ws | ignoruje ws  | -            |
| TestInput  | -                | -            | wczytuje eof |

Jak widać służą one do pomijania bądź nie, pustych lini na końcu pliku i białych znaków na końcu lini. 
Oraz czy zostanie na koniec jeszcze wczytany eof.
Uwaga, nadal warto (i zalecamy) wczytywać samemu eof.

Aby móc korzystać z wczytywanie musimy zainicjować scaner:
- ```scaner = oi::Scanner{stdin, oi::Scanner::Mode::[tryb], oi::Lang::[PL/EN]};```
- ```scaner = oi::Scanner(argv[1], oi::Scanner::Mode::[tryb], [scanner_lang]);```

teraz scaner możemy używać jak cin, czyli ```scaner >>```.
Wersje językowe są dostępne tylko te 2, w tych językach będą wypisywane komunikaty związane z wczytywaniem.
Inicjalizowanie skanerów jest już w templatce zakodowane.

Do wywoływania błedów używa on funkcji error(Msg&&... msg)
która, wypisuje błedy podczas wczytywania.
W takim shemacie: ```[mode]Wiersz [last_char_pos.line], [pozycja] [last_char_pos.pos]: [msg]...```

Jego **najważniejszą funkcją jest wczytywanie** i realizuje ją w nasępujący sposób:

- pojedyńczy znak - ```>> 'x' >> ' '``` -
Pozwala wczytać pojedyńczy konkretny znak.
- EOF (koniec pliku) - ```>> oi::eof``` -
Wczytuje koniec pliku zgodnie z trybem pracy.
- EOL (koniec lini) - ```>> oi::nl``` - 
Wczytuje koniec lini zgodnie z trybem pracy.
- ignorowanie znaków białych - ```>> oi::ignore_ws``` -
Pomija wszystkie znaki białe do następnego znaku.
- linia - ```>> oi::Line(a, b)``` -
Wczytuje cały wiersz do ```string a```, który jest nie dłóższy niż ```size_t b```.
- string - ```>> oi::Str(a, b)``` -
Wczytuje string do ```a``` o maksymalnej długości ```b```.
- char - ```>> oi::Char(a, b)``` -
Wczutuje znak do ```char a``` z podanej puli b gdzie b to string lub tablica charów.
- liczba - ```>> oi::Num(a, b, c)``` -
Wczytuje liczbę ```a``` (int, float, ...) która ma być w podanym zakresie od ```b``` do ```c```.

Podawanie zakresu może wydawać się upierdliwe, ale pozwala zapobiec że ktoś poda nieskończenie długi string.
Albo że przegapimy sprawdzenie czy liczba jest w zakresie.

</details> <!-- koniec ### Scanner (Wczytywanie) -->

<!-- ---------------------------------------------------------------------- -->
<details><summary>CheckerVerdict</summary>

oi.h udostępnia nam obiekt ```checker_verdict``` klasy CheckerVerdict.
Używamy go standardowo ```oi::checker_verdict.[coś]```.
Udostępnia nam poniższe funkcje:

- **exit_ok()** -
Kończy sprawdzanie z sukcesem. 
Zwraca ```OK\n\n100\n```.
- **exit_ok_with_score(int score, Msg&&... msg)** - 
Kończy sprawdzanie z sukcesem z podanym wynikiem i wiadomością/ciami.
Zwraca ```OK\n[msg]...[msg]\n[score]\n```
- **set_partial_score(int score, Msg&&... msg)** -
Ustawia wynik częściowy który zostanie zwrócony gdy nastąpi błąd.
Czyli zamiast 0 punktów otrzyma się tyle ile się przypisało z danum komentarzem.
- **exit_wrong(Msg&&... msg)** -
Kończ sprawdzanie z błędem i daje 0 punktów, chyba, że ustawiono partial_score.
Zwraca ```WRONG\n[msg]...[msg]\n0\n``` lub 
```OK\n[partial_score_msg]; [msg]...[msg]\n[partial_score]\n``` lub
jak nie ma partial_score_msg ```OK\n[msg]...[msg]\n[partial_score]\n``` .

</details> <!-- koniec ### CheckerVerdict -->

<!-- ---------------------------------------------------------------------- -->
<details><summary>checker_test</summary>

oi.h udostępnia możliwość pisania testów do chekerki, by upewnić się że zwraca to co powinna.
Te testy są uruchamiane tylko lokalnie.
Istnieją 2 (raczej) intucyjne sposoby pisania ich.
Zostały one przykładowo zaimplementowane w chekierce.

</details> <!-- koniec checker_test -->


<!-- ---------------------------------------------------------------------- -->
<details><summary>InwerVerdict</summary>

oi.h udostępnia nam obiekt ```inwer_verdict``` klasy InwerVerdict.
Używamy go jako strumień wyjścia, a mianowicie:
```oi::inwer_verdict.[coś] << [msg]```.
Gdzie ```msg``` to wiadomość którą chcemy pokazać przed zakończeniem.
Natomiast ```coś``` to jedna z podanych opcji:

- **exit_ok()** - Kończy program pomyślnie.
- **exit_wrong()** - Kończy program z błędem.

My będziemy używać tylko ```oi::inwer_verdict.exit_ok() << [msg]```.
Druga opcja jest używana systemowo i będziemy ją zgłaszać np. przez ```oi::bug(Msg&&... msg)```.

</details> <!-- koniec ### InwerVerdict -->

<!-- ---------------------------------------------------------------------- -->
<details><summary>bug</summary>

Wywołując ```oi::bug(Msg&&... msg)```, program zakończy się niepowodzeniem.
Wyświetli on wtedy podaną wiadomość/ci.

</details> <!-- koniec ### bug -->

<!-- ---------------------------------------------------------------------- -->
<details><summary>oi_assert</summary>

Działa podobnie do zwykłego asserta.
Wywołując ```oi::oi_assert(condition, ...);```, sprawdzi nasze założenie, a jak będzie błędne to poda dokładny komunikat co jest nie tak.
Wypisze on ```[FILE]:[LINE]: [func]: Assertion '[condition]' failed.``` lub
```[FILE]:[LINE]: [func]: Assertion '[condition]' failed: [msg]...```

</details> <!-- koniec ### oi_assert -->

<!-- ---------------------------------------------------------------------- -->
<details><summary>Random</summary>

Służy do losowania wartości i jest wymagane go używać zamiast zwykłego rand.
On zapewnia, że liczby są rzeczywiście (pseudo)losowe.
Klasa ```Random``` udostępnia nam:

- **Random(uint_fast64_t seed = 5489)**
- **void shuffle(T& container)** 
- **operator()(T min, T max)**

Tak więc aby utworzyć obiekt robimy ```rng = oi::Random{seed};```. 
Aby zmienić seed nadpisujemy ```rng = oi::Random(seed);```. 
Aby użyć robimy ```rng(min, max);```. 
Pod wartości min i max podstawiamy zakres z jakiego chcemy wylosowac wartość. Obsługiwane są wszystkie typy numeryczne (int, float, char, ...).
Możemy również pomieszać jakiś kontener robiąc ```rng.shuffle(container)```.

</details> <!-- koniec ### Random -->

</details> <!-- koniec ##oi.h -->
</details> <!-- koniec # prog -->


<!-- ---------------------------------------------------------------------- -->
# **config**
<details><summary></summary>

Wszystkie informacje opisane tu są też opisane w configu.

For more options see: [link to github](https://github.com/sio2project/sinol-make/blob/main/example_package/config.yml).
Or here are some basic ones.


<details><summary>Interactive tasks</summary>

Extra compilation arguments can be defined in `extra_compile_args` key.
Each language can have different extra arguments.
Additional files used in compilation can be defined in `extra_compilation_files` key.
They are copied to the directory where the source code is compiled.
All languages have the same additional files.
```
extra_compilation_args:
   cpp: ['abclib.cpp']

extra_compilation_files: ['abclib.cpp', 'abclib.h']
```

</details> <!-- koniec Interactive tasks -->


<details><summary>Time</summary>

```
time_limit: 1000 # ms

time_limits:
  2: 2000
  5: 7000
```
More precise time limit for each group or test can be defined in `time_limits` key.
The more precise time limit has higher priority (first group, then global time limit).

</details> <!-- koniec Time -->


<details><summary>Memory</summary>

```
memory_limit: 262144 # kB

memory_limits:
  3: 131072
  4: 131072
```
More precise memory limits can be defined in `memory_limits` key.
Same as with time limits, the more precise memory limit has higher priority.

</details> <!-- koniec Memory -->


<details><summary>Title</summary>

```
title: Przykładowy tytuł
```
Task title visible in the system.
If there are Polish characters, they should be written for better readability.

</details> <!-- koniec Title -->


<details><summary>Scores</summary>

```
scores:
  1: 20
  2: 80
```
Number of points for each group can be defined in `scores` key.
If this key is not specified, then all groups have the same number of points.
(if number of groups doesn't divide 100, then the last groups will have the remaining points).
Group 0 always has zero points.

</details> <!-- koniec Scores -->


<details><summary>Task ID</summary>

```
sinol_task_id: abc
```
This key represents the short name (consisting of 3 letters) of the task.
The names of files in `prog/`, `doc/`, `in/` and `out/` directories have to start with this task id.
This key is only used by `st-make`: running `st-make export` creates
an archive with the proper name, which sio2 uses as the task id.

</details> <!-- koniec Task ID -->


<details><summary>Contest type</summary>

```
sinol_contest_type: talent
```
sinol-make can behave differently depending on the value of `sinol_contest_type` key.
Mainly, it affects how points are calculated.
If the key is not specified, then (in st-make) `talent` is used. In sinol-make (OI version) is used 'default'.

</details> <!-- koniec Contest type -->


<details><summary>expected scores</summary>

```
sinol_expected_scores: {}
```
st-make can check if the solutions run as expected when using `run` command.
Key `sinol_expected_scores` defines expected scores for each solution on each tests.
There should be no reason to change this key manually.
It is automatically generated and managed by st-make.

</details> <!-- koniec expected scores -->

</details> <!-- koniec # config -->

# in i out
<details><summary></summary>

Są to foldery, w których znajdują się testy.
Testy nazywamy `{TAG}{grupa}{nr_testu}.{in/out}`.

Grupa:
- 0, ocen - są to testy wstępne, nie liczą się do oceny i uczestnik ma do nich dostęp na zawodach.
- 1,2,... - jest to grupa, punkty za nią dostaniemy jak przejdą wszystkie testy z danej grupy.

nr_testu to kolejne litery alfabetu.
A jak się skończą to dwie: a, ... z, aa, ab, ...

Przykładowe nazwy to: `abc0a.in`, `abc1a.in`, `abc1b.out`, `abc3z.in`, `abc3aa.in`.

Ciekawą formą nazywania jest też `{TAG}{grupa}t{nr}`, np `abc1t1.in`, jednak nie chce się przyjąć.

**Testy ocen** - anomalią od tego są używane kiedyś testy ocen.
Testy opisane jako `{TAG}{liczba}ocen.in` są zaliczne jako **testy wstępne**.
Na przykład `abc1ocen.in`, `abc2ocen.out`.
Obecnie można dawać po prostu `0a`, `0b`, ... `0e`, a w treści dać tylko np a i b.

Testy są tworzone przez `abcingen.cpp`.
Takie testy będą tworzone dopiero na systemie, więc foldery będą najczęściej puste.
Możemy jednak sami dodać testy które nie są generowane i one tu będą się znajdować.

</details> <!-- koniec: in i out -->


# dlazaw
<details><summary></summary>

W tym folderze są trzymane pliki dla zawodników.
Między innymi przydaje się w zadaniach interaktywnych gdzie jest udostępniana nam jakaś biblioteczka.

**Uwaga** testów ocen tu nie dajemy, je uczestnik dostaje automatycznie na zawodach.

</details> <!-- koniec: dlazaw -->