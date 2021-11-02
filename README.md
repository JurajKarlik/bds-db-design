# bds-db-design
project no.1 for BPC-BDS
Táto databáza reprezentuje internetový obchod. V nej sa nachádza celkovo 13 tabuliek ktoré
slúžia na registráciu a prihlasovanie užívatela, editovanie jeho typu-manažér, zamestnanec
zákazník, admin a inspector. Zamestnanec, manažér, admin a inspector bude môcť prezerať a
kontrolovať všetky objednávky, zákazník môže len prezerať obchod a vytvárať objednávky.
Objednávka bude obsahovať názov produktu, informácie o zákazníkovy, informácie o zľave,
doprave, stave objednávky a celkovú sumu. V dalšej tabulke sa nachádzajú adresy
zaregistrovaných užívatelov, bez nej nebude možné vytvoriť objednávku. Dalej sa dajú
editovať členstvá ako prémium a obyčajné. Ak bude mať užívatel prémium, gold, employee
členstvo tak bude mať na všetky produkty zľavu, standard a none členstvo je bez zliav.
Jednotlivé produky majú svoje kategórie ako sú pohlavie, sezóna a použitie. Taktiež sa dajú
spravovať objednávky zákazníkov, pričom si bude môcť klient vybrať spomedzi viacerých
druhov platby ako napríklad bankový prevod, platba kartou a dobierka, spôsob a dátum
doručenia, miesto– domov, vyzdvihnutie na predajni alebo doručenie na poštu. Pri každej
objednávke musí zákazník zadať svôj email a telefónne číslo. V databáze sa bude dať
skontrolovať, či a kedy bola objednávka zaplatená. 

