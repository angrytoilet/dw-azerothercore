-- DB update 2022_02_11_00 -> 2022_02_11_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_02_11_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_02_11_00 2022_02_11_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1643488846042207300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1643488846042207300');

SET @LEADERGUID1 := 84519;
SET @LEADERGUID2 := 84520;

DELETE FROM `creature_formations` WHERE `memberGUID` IN (@LEADERGUID1, @LEADERGUID2, 84521, 84522, 84523, 84524, 84525, 84526, 84527, 84528, 84529, 84530, 84531, 84532);
INSERT INTO `creature_formations` (`leaderGUID`, `memberGUID`, `dist`, `angle`, `groupAI`) VALUES
(@LEADERGUID1, @LEADERGUID1, 0, 0, 3),
(@LEADERGUID1, 84523, 0, 0, 3),
(@LEADERGUID1, 84524, 0, 0, 3),
(@LEADERGUID1, 84525, 0, 0, 3),
(@LEADERGUID1, 84526, 0, 0, 3),
(@LEADERGUID1, 84531, 0, 0, 3),
(@LEADERGUID1, 84532, 0, 0, 3),

(@LEADERGUID2, @LEADERGUID2, 0, 0, 3),
(@LEADERGUID2, 84521, 0, 0, 3),
(@LEADERGUID2, 84522, 0, 0, 3),
(@LEADERGUID2, 84527, 0, 0, 3),
(@LEADERGUID2, 84528, 0, 0, 3),
(@LEADERGUID2, 84529, 0, 0, 3),
(@LEADERGUID2, 84530, 0, 0, 3);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_02_11_01' WHERE sql_rev = '1643488846042207300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
