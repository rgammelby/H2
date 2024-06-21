USE bogreden;

DROP PROCEDURE IF EXISTS br_book_search;

DELIMITER ¤
CREATE PROCEDURE br_book_search(
IN search VARCHAR(100)
)
BEGIN
	SELECT * from br_book WHERE bk_titel LIKE CONCAT('%', search, '%') OR bk_description LIKE CONCAT('%', search, '%');
END ¤
DELIMITER ;

CALL br_book_search('');