--------------------------------Exercitiile 6-12--------------------------------



----------------Exercitiul 6----------------
CREATE OR REPLACE PROCEDURE EXERCITIU_6 IS
   CURSOR c_club is 
      select nume_club from club_sportiv; 
   TYPE c_list IS TABLE of club_sportiv.nume_club%type INDEX BY binary_integer; 
   name_list c_list; 
   counter number :=0; 
BEGIN 
   FOR n IN c_club LOOP 
      counter := counter +1; 
      name_list(counter) := n.nume_club; 
      dbms_output.put_line('Client('||counter||'):'||name_list(counter)); 
   END LOOP; 
dbms_output.put_line('Numarul total de cluburi sportive din federatie: ');
dbms_output.put_line(name_list.count);
END; 
/
BEGIN
EXERCITIU_6;
END;
/


----------------Exercitiul 7----------------
CREATE OR REPLACE PROCEDURE EXERCITIU_7 IS
   c_id club_sportiv.id_club%type; 
   c_name club_sportiv.nume_club%type; 
   CURSOR c_club is 
      SELECT id_club, nume_club FROM club_sportiv; 
BEGIN 
   OPEN c_club; 
   LOOP 
   FETCH c_club into c_id, c_name;
      EXIT WHEN c_club%notfound; 
      dbms_output.put_line(c_id || ' ' || c_name); 
   END LOOP; 
   CLOSE c_club; 
END; 
/

BEGIN
EXERCITIU_7;
END;
/


select competitie.nume from ((club_sportiv join club_organizeaza_competitie on club_sportiv.id_club = club_organizeaza_competitie.club_id) 
      join competitie on club_organizeaza_competitie.competitie_id=competitie.id_competitie) where club_sportiv.id_club = 2;


--de sters asta
select competitie.nume from ((club_sportiv join club_organizeaza_competitie on club_sportiv.id_club = club_organizeaza_competitie.club_id) 
      join competitie on club_organizeaza_competitie.competitie_id=competitie.id_competitie) where club_sportiv.id_club = 1;

----------------Exercitiul 8----------------
--returneaza competitiile organizate de clubul dat ca parametru(id-ul este dat ca parametru). Daca nu exista id-ul are loc o exceptie
CREATE OR REPLACE FUNCTION EXERCITIU_8_NOU3
(id_cerut IN club_sportiv.id_club%type)
return competitie.nume%type
IS

    c_club1 club_sportiv.nume_club%type; 
   c_comp competitie.nume%type; 
   CURSOR c_join is 
      select competitie.nume from ((club_sportiv join club_organizeaza_competitie on club_sportiv.id_club = club_organizeaza_competitie.club_id) 
      join competitie on club_organizeaza_competitie.competitie_id=competitie.id_competitie) where club_sportiv.id_club = 1;
    lista_competitii competitie.nume%type;


    c_id club_sportiv.id_club%type; 
    c_name club_sportiv.nume_club%type; 
    CURSOR c_club is 
        SELECT id_club, nume_club FROM club_sportiv; 
      
    
BEGIN
    select competitie.nume into c_comp from ((club_sportiv join club_organizeaza_competitie on club_sportiv.id_club = club_organizeaza_competitie.club_id) 
      join competitie on club_organizeaza_competitie.competitie_id=competitie.id_competitie) where club_sportiv.id_club = id_cerut; 
   
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No such competition!'); 
    WHEN OTHERS THEN
        dbms_output.put_line('Eroare 2!'); 
   
END; 
/

DECLARE
    v_result competitie.nume%type := EXERCITIU_8_NOU3(1);
BEGIN
    IF v_result IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('  Exercitiul 8 returneaza: ' || 
                              chr(13) || chr(10) || v_result);
    END IF;
END;
/
--------------------------------
--returneaza competitiile organizate de clubul dat ca parametru(id-ul este dat ca parametru). Daca nu exista id-ul are loc o exceptie
CREATE OR REPLACE FUNCTION EXERCITIU__8
(id_cerut IN club_sportiv.id_club%type)
RETURN SYS_REFCURSOR
IS

  c SYS_REFCURSOR;
      
    
BEGIN
    OPEN c FOR
  select competitie.nume from ((club_sportiv join club_organizeaza_competitie on club_sportiv.id_club = club_organizeaza_competitie.club_id) 
      join competitie on club_organizeaza_competitie.competitie_id=competitie.id_competitie) where club_sportiv.id_club = (id_cerut/(id_cerut-1));
  RETURN  c;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        dbms_output.put_line('No such competition!'); 
    WHEN OTHERS THEN
        dbms_output.put_line('Alta eroare!'); 
   
END; 
/

DECLARE
    c_name competitie.nume%type; 
    --c_variabila SYS_REFCURSOR := EXERCITIU_8_NOU4(1);
    c_variabila SYS_REFCURSOR := EXERCITIU__8(2);
BEGIN

   LOOP 
       FETCH c_variabila into c_name;
          EXIT WHEN c_variabila%notfound; 
          dbms_output.put_line('Competitie gasita: ' || c_name); 
   END LOOP; 
   CLOSE c_variabila; 
    
END;
/



select competitie.nume from ((( ((club_sportiv join club_organizeaza_competitie on club_sportiv.id_club = club_organizeaza_competitie.club_id) 
      join competitie on club_organizeaza_competitie.competitie_id=competitie.id_competitie) join  antrenor on antrenor.club_id=club_sportiv.id_club) 
      join antrenor_instruieste_elev on  antrenor_instruieste_elev.antrenor_id=antrenor.id_antrenor)  
      join elev on antrenor_instruieste_elev.elev_id=elev.id_elev )
      where elev.id_elev = 120;




----------------------------------------------------Exercitiul 9----------------------------------------------------
--returnez competitia la care a participat acest elev
CREATE OR REPLACE PROCEDURE EXERCITIUL_9
    (id_elev_cerut elev.id_elev%type)
IS
    v_competitii_returnate competitie.nume%TYPE;
BEGIN
    select competitie.nume into v_competitii_returnate from ((( ((club_sportiv join club_organizeaza_competitie on club_sportiv.id_club = club_organizeaza_competitie.club_id) 
      join competitie on club_organizeaza_competitie.competitie_id=competitie.id_competitie) join  antrenor on antrenor.club_id=club_sportiv.id_club) 
      join antrenor_instruieste_elev on  antrenor_instruieste_elev.antrenor_id=antrenor.id_antrenor)  
      join elev on antrenor_instruieste_elev.elev_id=elev.id_elev )
      where elev.id_elev = id_elev_cerut;
    
    
    DBMS_OUTPUT.PUT_LINE('Elevul a praticipat la competitia: ' ||  v_competitii_returnate);
EXCEPTION
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE(' ' || chr(13) || chr(10) || ' Nu exista competitii la care elevul sa fi participat.');
    WHEN TOO_MANY_ROWS THEN 
        DBMS_OUTPUT.PUT_LINE(' ' || chr(13) || chr(10) || 'Exista mai multe competitii');
    WHEN OTHERS THEN 
        DBMS_OUTPUT.PUT_LINE(' ' || chr(13) || chr(10) || 'Alta eroare!');
END;
/
BEGIN
    EXERCITIUL_9(33);
END;
/


----------------------------------------------------Exercitiul 10----------------------------------------------------

CREATE OR REPLACE TRIGGER trigger_modificare_competitii
    BEFORE INSERT OR DELETE OR UPDATE on competitie
    
--DECLARE
--v_zi VARCHAR2;

BEGIN
--SELECT TO_CHAR(date '1982-03-09', 'DAY') day into v_zi FROM dual;
    IF trim(TO_CHAR(SYSDATE, 'DAY')) <> 'MONDAY'
    THEN
        
        RAISE_APPLICATION_ERROR(-20007, 'Sunt permise operatii asupra competitie doar in zilele de Luni.');
        
    END IF;
END;
/


UPDATE competitie
SET nume = 'nume nou'
WHERE nume = 'Bucharest summer open 2020';





----------------------------------------------------Exercitiul 11----------------------------------------------------
CREATE OR REPLACE TRIGGER antrenorVarsta
BEFORE UPDATE OF varsta ON antrenor
FOR EACH ROW
BEGIN
    IF :NEW.varsta <:OLD.varsta THEN
        RAISE_APPLICATION_ERROR(-20002,'Varsta nu poate scadea');
    END IF;
END;
/ 

UPDATE antrenor
SET varsta = 26
WHERE varsta = 25;

----------------------------------------------------Exercitiul 12----------------------------------------------------

CREATE TABLE audit_schema
    (oper_date TIMESTAMP(1),
     db_name VARCHAR2(30),
     user_name VARCHAR2(20),
     oper_name VARCHAR2(20),
     obj_type VARCHAR2(30),
     obj_name VARCHAR2(30)
    );

CREATE OR REPLACE TRIGGER tr_audit_schema
    AFTER CREATE OR DROP OR ALTER ON SCHEMA
BEGIN
    --INSERT INTO audit_schema
    --VALUES (SYSTIMESTAMP(1), SYS.DATABASE_NAME, SYS.LOGIN_USER, SYS.SYSEVENT, SYS.DICTIONARY_OBJ_TYPE, SYS.DICTIONARY_OBJ_NAME);
    dbms_output.put_line('Trigger declansat!');

END;
/

CREATE TABLE dummy_table2
    (col_1 NUMBER(2)
    );
ALTER TABLE dummy_table2
ADD (col_2 NUMBER(2)
    );
INSERT INTO dummy_table2
VALUES (1, 2
       );
SELECT * FROM audit_schema;


