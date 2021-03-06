-- DB update 2021_10_20_12 -> 2021_10_20_13
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_20_12';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_20_12 2021_10_20_13 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1634490332525494100'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634490332525494100');

UPDATE `smart_scripts` SET `action_param2` = 0 WHERE `entryorguid` IN (5319, 5317) AND `source_type` = 0 AND `id` IN (0, 1);


--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_20_13' WHERE sql_rev = '1634490332525494100';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
