-- DB update 2021_10_31_00 -> 2021_10_31_01
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2021_10_31_00';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2021_10_31_00 2021_10_31_01 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1634467700982963900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1634467700982963900');

SET @ENTRY := 1021;
DELETE FROM `smart_scripts` WHERE `source_type` = 0 AND `entryOrGuid` = @ENTRY;
UPDATE `creature_template` SET `AIName` = 'SmartAI' WHERE `entry` = @ENTRY;
INSERT INTO `smart_scripts` (`entryorguid`, `source_type`, `id`, `link`, `event_type`, `event_phase_mask`, `event_chance`, `event_flags`, `event_param1`, `event_param2`, `event_param3`, `event_param4`, `action_type`, `action_param1`, `action_param2`, `action_param3`, `action_param4`, `action_param5`, `action_param6`, `target_type`, `target_param1`, `target_param2`, `target_param3`, `target_x`, `target_y`, `target_z`, `target_o`, `comment`) VALUES
(@ENTRY, 0, 0, 1, 2, 0, 100, 1, 0, 30, 0, 0, 39, 20, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mottled Screecher - When health between 0%-30% (check once) - Self: Call for help within 20 yards'),
(@ENTRY, 0, 1, 0, 61, 0, 100, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 1, 0, 0, 0, 0, 0, 0, 0, 'Mottled Screecher - When health between 0%-30% (check once) - Self: Talk 0 to invoker');

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2021_10_31_01' WHERE sql_rev = '1634467700982963900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
