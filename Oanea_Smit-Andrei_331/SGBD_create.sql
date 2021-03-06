

-------------------------------------------Partea 1: Crearea tabelelor-------------------------------------------
CREATE TABLE sala
( 
    id_sala number(10) PRIMARY KEY,
    --sala nu are foreign key
    
    adresa varchar2(50) NOT NULL,
    capacitate numeric(10) NOT NULL
  
);


CREATE TABLE club_sportiv
( 
    id_club number(10) PRIMARY KEY,
    sala_id numeric(10),--foreign key, poate fi null
    
    nume_club varchar2(50) NOT NULL,
  
    
    --am sters asta, am facut legatura de la cealalta tabela:
    --CONSTRAINT fk_antrenor--la foreign key antrenor nu punem UNIQUE, avem relatie 1 to M
    --    FOREIGN KEY (antrenor_id)
    --    REFERENCES antrenor(id_antrenor),
    
    CONSTRAINT sala_unique UNIQUE (sala_id),--pentru ca avem relatie 1 la 1 intre club sportiv si sala
    CONSTRAINT fk_sala
        FOREIGN KEY (sala_id)
        REFERENCES sala(id_sala)
  
);

CREATE TABLE masina
( 
    id_masina number(10) PRIMARY KEY,
    --masina nu are foreign key
    
    firma varchar2(50) NOT NULL,
    model_masina varchar2(50) NOT NULL
  
);

CREATE TABLE antrenor
( 
    id_antrenor number(10) PRIMARY KEY,
    masina_id number(10),--foreign key
    club_id number(10),--foreign key
    
    nume_antrenor varchar2(50) NOT NULL,
    varsta NUMBER(3) NOT NULL CHECK (varsta < 50 and varsta > 18),
    
    CONSTRAINT masina_unique UNIQUE (masina_id),--pentru ca avem relatie 1 la 1
    CONSTRAINT fk_masina
        FOREIGN KEY (masina_id)
        REFERENCES masina(id_masina),
    
    --nu punem UNIQUE pentru club_id, pentru ca mai multi antrenori pot lucra la acelasi club
    CONSTRAINT fk_club--dar punem cheie straina
        FOREIGN KEY (club_id)
        REFERENCES club_sportiv(id_club)
  
);

CREATE TABLE competitie
( 
    id_competitie number(10) PRIMARY KEY,
    --competitia nu are foreign key
    
    nume varchar2(50) NOT NULL,
    ziua  date NOT NULL
  
);


--Un club sportiv poate organiza mai multe competitii
--O competitie poate fi organizata de mai multe cluburi



CREATE TABLE club_organizeaza_competitie(
club_id NUMBER(10),
competitie_id NUMBER(10),

PRIMARY KEY (club_id, competitie_id),

FOREIGN KEY (club_id) REFERENCES club_sportiv(id_club),
FOREIGN KEY (competitie_id) REFERENCES competitie(id_competitie)
);


CREATE TABLE elev
( 
    id_elev number(10) PRIMARY KEY,
    --Elev nu are foreign key
    
    nume varchar2(50) NOT NULL,
    centura  varchar2(50),--centura poate fi NULL, la elevii incepatori(fara centura)
    varsta NUMBER(3) NOT NULL CHECK (varsta > 3),
    sex varchar2(50) NOT NULL CHECK (sex LIKE 'F' OR SEX LIKE 'M')
  
);

CREATE TABLE antrenor_instruieste_elev(
antrenor_id NUMBER(10),
elev_id NUMBER(10),

PRIMARY KEY (antrenor_id, elev_id),

FOREIGN KEY (antrenor_id) REFERENCES antrenor(id_antrenor),
FOREIGN KEY (elev_id) REFERENCES elev(id_elev)
);



-------------------------------------------Partea 2: Introducem date in tabele-------------------------------------------


--------Inserez masini--------
INSERT INTO masina
(id_masina, firma, model_masina)
VALUES
(1, 'Ford', 'Focus');

INSERT INTO masina
(id_masina, firma, model_masina)
VALUES
(2, 'Ford', 'Fiesta');

INSERT INTO masina
(id_masina, firma, model_masina)
VALUES
(3, 'Porche', 'X');

INSERT INTO masina
(id_masina, firma, model_masina)
VALUES
(4, 'BMW', 'X5');

INSERT INTO masina
(id_masina, firma, model_masina)
VALUES
(5, 'Dacia', 'Logan');

INSERT INTO masina
(id_masina, firma, model_masina)
VALUES
(6, 'Dacia', 'Logan');

INSERT INTO masina
(id_masina, firma, model_masina)
VALUES
(7, 'Masina', 'Speciala');
--exista doua Dacia Logan cu id-uri diferite

--------Inserez sali--------
INSERT INTO sala
(id_sala, adresa, capacitate)
VALUES
(1, 'Strada Lalelelor', 40);

INSERT INTO sala
(id_sala, adresa, capacitate)
VALUES
(2, 'Strada DN24A', 60);

INSERT INTO sala
(id_sala, adresa, capacitate)
VALUES
(3, 'Strada Colentina', 20);

INSERT INTO sala
(id_sala, adresa, capacitate)
VALUES
(4, 'Strada Stefan Cel Mare', 100);

INSERT INTO sala
(id_sala, adresa, capacitate)
VALUES
(5, 'Strada Mare', 60);

--------Insert competitii--------
INSERT INTO competitie
(id_competitie, nume, ziua)
VALUES
(1, 'Bucharest summer open 2020', DATE '2020-07-10');

INSERT INTO competitie
(id_competitie, nume, ziua)
VALUES
(2, 'Romanian nationals 2021', DATE '2021-05-15');

INSERT INTO competitie
(id_competitie, nume, ziua)
VALUES
(3, 'Transilvanian contest 2021', DATE '2021-07-19');

INSERT INTO competitie
(id_competitie, nume, ziua)
VALUES
(4, 'European contest 2021', DATE '2021-09-19');

INSERT INTO competitie
(id_competitie, nume, ziua)
VALUES
(5, 'One Club contest 2021', DATE '2021-04-19');

INSERT INTO competitie
(id_competitie, nume, ziua)
VALUES
(6, 'One Club contest2 2021', DATE '2021-11-11');



--------Insert Cluburi Sportive--------
INSERT INTO club_sportiv
(id_club, sala_id, nume_club)
VALUES
(1, 2, 'Heian Shodan Bucuresti');

INSERT INTO club_sportiv
(id_club, sala_id, nume_club)
VALUES
(2,1, 'Kanku Dai Urziceni');

INSERT INTO club_sportiv
(id_club, sala_id, nume_club)
VALUES
(3, 3, 'Oi Zuki Bacau');

INSERT INTO club_sportiv
(id_club, sala_id, nume_club)
VALUES
(4, 4, 'Todome Cluj');

INSERT INTO club_sportiv
(id_club, sala_id, nume_club)
VALUES
(5, 5, 'AAAA! Bucuresti');


--------Inserez antrenori--------
--Cluburile 1, 2 si 3 au fiecare cate un antrenor
INSERT INTO antrenor
(id_antrenor, masina_id, club_id, nume_antrenor, varsta)
VALUES
(1, 1, 2, 'Victor Eftimiu', 35);

INSERT INTO antrenor
(id_antrenor, masina_id, club_id, nume_antrenor, varsta)
VALUES
(2, 2, 1, 'Ion Popescu', 22);

INSERT INTO antrenor
(id_antrenor, masina_id, club_id, nume_antrenor, varsta)
VALUES
(3, 4, 3, 'Dan Stuparu', 49);

--Clubul 4 are 3 antrenori:
INSERT INTO antrenor
(id_antrenor, masina_id, club_id, nume_antrenor, varsta)
VALUES
(4, 3, 4, 'Roxana Cruher', 45);

INSERT INTO antrenor
(id_antrenor, masina_id, club_id, nume_antrenor, varsta)
VALUES
(5, 5, 4, 'Ionescu Alexandra', 25);

INSERT INTO antrenor
(id_antrenor, masina_id, club_id, nume_antrenor, varsta)
VALUES
(6, 6, 4, 'Oliver Dobre', 40);

INSERT INTO antrenor
(id_antrenor, masina_id, club_id, nume_antrenor, varsta)
VALUES
(7, 7, 5, 'Solomonar Oltean', 25);


--select * from masina join antrenor on antrenor.masina_id = masina.id_masina;

select * from club_sportiv;



--------Insert club_organizaza competitie--------
INSERT INTO club_organizeaza_competitie
(club_id, competitie_id)
VALUES
(1, 1);

INSERT INTO club_organizeaza_competitie
(club_id, competitie_id)
VALUES
(2, 1);

INSERT INTO club_organizeaza_competitie
(club_id, competitie_id)
VALUES
(1, 2);

INSERT INTO club_organizeaza_competitie
(club_id, competitie_id)
VALUES
(2, 2);

INSERT INTO club_organizeaza_competitie
(club_id, competitie_id)
VALUES
(3, 2);

INSERT INTO club_organizeaza_competitie
(club_id, competitie_id)
VALUES
(4, 2);

INSERT INTO club_organizeaza_competitie
(club_id, competitie_id)
VALUES
(1, 3);

INSERT INTO club_organizeaza_competitie
(club_id, competitie_id)
VALUES
(2, 3);

INSERT INTO club_organizeaza_competitie
(club_id, competitie_id)
VALUES
(3, 3);

INSERT INTO club_organizeaza_competitie
(club_id, competitie_id)
VALUES
(4, 3);

INSERT INTO club_organizeaza_competitie
(club_id, competitie_id)
VALUES
(4, 4);

INSERT INTO club_organizeaza_competitie
(club_id, competitie_id)
VALUES
(4, 5);

INSERT INTO club_organizeaza_competitie
(club_id, competitie_id)
VALUES
(5, 6);


--afiseaza tabela asociativa

select club_sportiv.nume_club, competitie.nume from ((club_sportiv join club_organizeaza_competitie on club_sportiv.id_club = club_organizeaza_competitie.club_id) join competitie on club_organizeaza_competitie.competitie_id=competitie.id_competitie);

--------Insert Elevi--------
INSERT INTO elev
(id_elev, nume, centura, varsta, sex)
VALUES
(1, 'Tudor Sarbu', 'Portocalie', 17, 'M');

INSERT INTO elev
(id_elev, nume, centura, varsta, sex)
VALUES
(2, 'Cosmin Roznov', 'Neagra', 20, 'M');

INSERT INTO elev
(id_elev, nume, centura, varsta, sex)
VALUES
(3, 'Ion Gheorghiu', 'Verde', 16, 'M');


INSERT INTO elev
(id_elev, nume, centura, varsta, sex)
VALUES
(4, 'Gheorghe Ioniu', 'Alba', 45, 'M');

INSERT INTO elev
(id_elev, nume, centura, varsta, sex)
VALUES
(5, 'Vladislav Vlad', 'Maro', 30, 'M');

INSERT INTO elev
(id_elev, nume, centura, varsta, sex)
VALUES
(6, 'Tesarul de Lumini', 'Galbena', 9, 'M');


INSERT INTO elev
(id_elev, nume, centura, varsta, sex)
VALUES
(7, 'Ioana Mihailescu', 'Albastra', 29, 'F');

INSERT INTO elev
(id_elev, nume, centura, varsta, sex)
VALUES
(8, 'Tania Romanova', 'Neagra', 30, 'F');

INSERT INTO elev
(id_elev, nume, centura, varsta, sex)
VALUES
(9, 'Tania Staneva', 'Alba', 50, 'F');

INSERT INTO elev
(id_elev, nume, centura, varsta, sex)
VALUES
(10, 'Zimushka Mugnier', 'Verde', 15, 'F');

INSERT INTO elev
(id_elev, nume, centura, varsta, sex)
VALUES
(11, 'Laurentiu Soare', null, 23, 'M');


INSERT INTO elev
(id_elev, nume, centura, varsta, sex)
VALUES
(12, 'Razvan George', null, 5, 'M');

INSERT INTO elev
(id_elev, nume, centura, varsta, sex)
VALUES
(13, 'Edmond Stuparu', null, 45, 'M');



select * from elev;

--------Insert in tabela antrenor_instruieste_elev--------
INSERT INTO antrenor_instruieste_elev
(antrenor_id, elev_id)
VALUES
(1,1);

INSERT INTO antrenor_instruieste_elev
(antrenor_id, elev_id)
VALUES
(1,2);

INSERT INTO antrenor_instruieste_elev
(antrenor_id, elev_id)
VALUES
(1,3);

INSERT INTO antrenor_instruieste_elev
(antrenor_id, elev_id)
VALUES
(1,4);

INSERT INTO antrenor_instruieste_elev
(antrenor_id, elev_id)
VALUES
(2,5);

INSERT INTO antrenor_instruieste_elev
(antrenor_id, elev_id)
VALUES
(2,6);

INSERT INTO antrenor_instruieste_elev
(antrenor_id, elev_id)
VALUES
(3,7);

INSERT INTO antrenor_instruieste_elev
(antrenor_id, elev_id)
VALUES
(3,8);

INSERT INTO antrenor_instruieste_elev
(antrenor_id, elev_id)
VALUES
(3,9);

INSERT INTO antrenor_instruieste_elev
(antrenor_id, elev_id)
VALUES
(4,10);

--elevii 11 si 12 sunt intruiti si de antrenorii 5 si 6, nu doar de antrenorul 4

INSERT INTO antrenor_instruieste_elev
(antrenor_id, elev_id)
VALUES
(4,11);

INSERT INTO antrenor_instruieste_elev
(antrenor_id, elev_id)
VALUES
(5,11);

INSERT INTO antrenor_instruieste_elev
(antrenor_id, elev_id)
VALUES
(6,11);

INSERT INTO antrenor_instruieste_elev
(antrenor_id, elev_id)
VALUES
(4,12);

INSERT INTO antrenor_instruieste_elev
(antrenor_id, elev_id)
VALUES
(5,12);

INSERT INTO antrenor_instruieste_elev
(antrenor_id, elev_id)
VALUES
(6,12);

INSERT INTO antrenor_instruieste_elev
(antrenor_id, elev_id)
VALUES
(7,13);

--select * from masina;

--Daca as vrea sa rulez urmatoarea inserare as primi o eroare, deoarece sala_id este null:
--INSERT INTO club_sportiv
--(id_club, antrenor_id)
--VALUES
--(40, 1);

select * from antrenor_instruieste_elev;

select * from club_sportiv;

select * from elev;


