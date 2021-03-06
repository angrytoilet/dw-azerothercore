-- DB update 2022_04_24_01 -> 2022_04_24_02
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_04_24_01';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_04_24_01 2022_04_24_02 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1650806711221200500'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1650806711221200500');

UPDATE `version` SET `db_version`='ACDB 335.7-dev', `cache_id`=7 LIMIT 1;
UPDATE `updates` SET `state`='ARCHIVED';

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_04_24_02' WHERE sql_rev = '1650806711221200500';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
