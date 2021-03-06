-- DB update 2021_11_06_03 -> 2021_11_06_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_11_06_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_11_06_03 2021_11_06_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1635951187866923861'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

-- add revision
INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1635951187866923861');

-- add orientation` and delay into existing wp table
ALTER TABLE `waypoints` ADD COLUMN `orientation` FLOAT DEFAULT 0 NOT NULL AFTER `position_z`, ADD COLUMN `delay` INT UNSIGNED DEFAULT 0 NOT NULL AFTER `orientation`;

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_11_06_04' WHERE sql_rev = '1635951187866923861';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
