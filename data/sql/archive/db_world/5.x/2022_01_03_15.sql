-- DB update 2022_01_03_14 -> 2022_01_03_15
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_03_14';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_03_14 2022_01_03_15 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1640238214916352424'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1640238214916352424');

-- loot
DELETE FROM `creature_loot_template` WHERE `Item` = 4305;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_03_15' WHERE sql_rev = '1640238214916352424';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
