DROP TABLE IF EXISTS PETSALE;

CREATE TABLE PETSALE (
    ID INTEGER NOT NULL,
    ANIMAL VARCHAR(20),
    SALEPRICE DECIMAL(6, 2),
    SALEDATE DATE,
    QUANTITY INTEGER,
    PRIMARY KEY (ID)
);

INSERT INTO PETSALE VALUES
(1,'Cat',450.09,'2018-05-29',9),
(2,'Dog',666.66,'2018-06-01',3),
(3,'Parrot',50.00,'2018-06-04',2),
(4,'Hamster',60.60,'2018-06-11',6),
(5,'Goldfish',48.48,'2018-06-14',24);

# Drop the stored procedure routine RETRIEVE_ALL
DROP PROCEDURE RETRIEVE_ALL;

#  The RETRIEVE_ALL routine will contain an SQL query to retrieve all the records from the PETSALE table,
DELIMITER //

CREATE PROCEDURE RETRIEVE_ALL()

BEGIN
  
   SELECT *  FROM PETSALE;
   
END //

DELIMITER ; 

# Call the RETRIEVE_ALL routine
CALL RETRIEVE_ALL;  

# This procedure routine will take animal ID and health conditon as parameters which 
# will be used to update the sale price of animal in the PETSALE table by an 
# amount depending on their health condition
DROP PROCEDURE UPDATE_SALEPRICE;

DELIMITER @
CREATE PROCEDURE UPDATE_SALEPRICE ( 
   IN Animal_ID INTEGER, IN Animal_Health VARCHAR(5) )     
BEGIN 

   IF Animal_Health = 'BAD' THEN                           
       UPDATE PETSALE
       SET SALEPRICE = SALEPRICE - (SALEPRICE * 0.25)
       WHERE ID = Animal_ID;
   
   ELSEIF Animal_Health = 'WORSE' THEN
       UPDATE PETSALE
       SET SALEPRICE = SALEPRICE - (SALEPRICE * 0.5)
       WHERE ID = Animal_ID;
       
   ELSE
       UPDATE PETSALE
       SET SALEPRICE = SALEPRICE
       WHERE ID = Animal_ID;

   END IF;                                                 
   
END @

DELIMITER ;

CALL RETRIEVE_ALL;
CALL UPDATE_SALEPRICE(1, 'BAD');       
CALL RETRIEVE_ALL;

CALL RETRIEVE_ALL;
CALL UPDATE_SALEPRICE(3, 'WORSE');     
CALL RETRIEVE_ALL;
