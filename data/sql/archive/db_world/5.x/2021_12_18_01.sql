-- DB update 2021_12_18_00 -> 2021_12_18_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_12_18_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_12_18_00 2021_12_18_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1639429763496903700'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639429763496903700');

DELETE FROM `gossip_menu` WHERE `menuid` IN (5844,5843,5842,5841);
INSERT INTO `gossip_menu` VALUES
(5844,7002),
(5843,7003),
(5842,7004),
(5841,7005);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_12_18_01' WHERE sql_rev = '1639429763496903700';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
