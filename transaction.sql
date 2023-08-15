DROP PROCEDURE IF EXISTS TRANSACTION_ROSE;

# Create a stored procedure routine named TRANSACTION_ROSE which will include TCL commands like COMMIT and ROLLBACK.
# Scenario: Let’s buy Rose a pair of Boots from ShoeShop. So we have to update the Rose balance as well as the ShoeShop balance 
# in the BankAccounts table. Then we also have to update Boots stock in the ShoeShop table. After Boots, let’s also attempt 
# to buy Rose a pair of Trainers.
DELIMITER //

CREATE PROCEDURE TRANSACTION_ROSE()

BEGIN
  
   DECLARE EXIT HANDLER FOR SQLEXCEPTION
   BEGIN
       ROLLBACK;
       RESIGNAL;
   END;                
     
     START TRANSACTION;
       UPDATE BankAccounts
       SET Balance = Balance-200
       WHERE AccountName = 'Rose';
       
       UPDATE BankAccounts
       SET Balance = Balance+200
       WHERE AccountName = 'Shoe Shop';
       
       UPDATE ShoeShop
       SET Stock = Stock-1
       WHERE Product = 'Boots';
       
       #UPDATE BankAccounts
       #SET Balance = Balance-300
       #WHERE AccountName = 'Rose';

       COMMIT;    
   
END //

DELIMITER ; 

CALL TRANSACTION_ROSE; 
SELECT * FROM BankAccounts;
SELECT * FROM ShoeShop;

# Create a stored procedure TRANSACTION_JAMES to execute a transaction based on the following scenario: 
# First buy James 4 pairs of Trainers from ShoeShop. Update his balance as well as the balance of ShoeShop. 
# Also, update the stock of Trainers at ShoeShop. Then attempt to buy James a pair of Brogues from ShoeShop. 
# If any of the UPDATE statements fail, the whole transaction fails. You will roll back the transaction. 
# Commit the transaction only if the whole transaction is successful.
DELIMITER //

CREATE PROCEDURE TRANSACTION_JAMES()                         

BEGIN

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
    END;           
        START TRANSACTION;
        UPDATE BankAccounts
        SET Balance = Balance-1200
        WHERE AccountName = 'James';
        
        UPDATE BankAccounts
        SET Balance = Balance+1200
        WHERE AccountName = 'Shoe Shop';
        
        UPDATE ShoeShop
        SET Stock = Stock-4
        WHERE Product = 'Trainers';
        
        UPDATE BankAccounts
        SET Balance = Balance-150
        WHERE AccountName = 'James';

		COMMIT;
        
END //

DELIMITER ; 

CALL TRANSACTION_JAMES; 
SELECT * FROM BankAccounts;
SELECT * FROM ShoeShop;
