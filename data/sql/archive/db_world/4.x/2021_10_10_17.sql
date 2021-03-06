-- DB update 2021_10_10_16 -> 2021_10_10_17
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_10_16';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_10_16 2021_10_10_17 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1633533380570017300'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1633533380570017300');

DELETE FROM `creature_loot_template` WHERE `item`=8846 AND `entry` NOT IN (1808,1812,1813,1851,5481,5485,5490,6509,6510,6511,6512,6517,6518,6519,6521,6527,
6551,6552,6554,6559,7092,7100,7101,7104,7132,7138,7139,7149,8384,8910,8911,9601,9878,9879,11458,11459,11461,11462,11464,11465,11665,12224,13021,13022,13136,
13196,13197,13285,14303,15335);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_10_17' WHERE sql_rev = '1633533380570017300';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
