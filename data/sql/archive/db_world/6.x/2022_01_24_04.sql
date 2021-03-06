-- DB update 2022_01_24_03 -> 2022_01_24_04
DROP PROCEDURE IF EXISTS `updateDb`;
DELIMITER //
CREATE PROCEDURE updateDb ()
proc:BEGIN DECLARE OK VARCHAR(100) DEFAULT 'FALSE';
SELECT COUNT(*) INTO @COLEXISTS
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = DATABASE() AND TABLE_NAME = 'version_db_world' AND COLUMN_NAME = '2022_01_24_03';
IF @COLEXISTS = 0 THEN LEAVE proc; END IF;
START TRANSACTION;
ALTER TABLE version_db_world CHANGE COLUMN 2022_01_24_03 2022_01_24_04 bit;
SELECT sql_rev INTO OK FROM version_db_world WHERE sql_rev = '1639592443028716900'; IF OK <> 'FALSE' THEN LEAVE proc; END IF;
--
-- START UPDATING QUERIES
--

INSERT INTO `version_db_world` (`sql_rev`) VALUES ('1639592443028716900');

UPDATE `spell_proc_event` SET `procPhase`=1 WHERE `entry` IN (-16880,32748,59887,-51521,18820,24389,31794,33299,36032,37214,37601,39530,40442,43819,
44543,44545,59630,65005,67386,67389,67667,67670,67698,67752,69762,70811,71585,71602,71645,72419,74396,75465,75474);
UPDATE `spell_proc_event` SET `procPhase`=3 WHERE `entry` IN (44543,44545);
UPDATE `spell_proc_event` SET `procPhase`=4 WHERE `entry` IN (-59088,-56342,-31571,-19184,-14156,32216,37168,46916,51698,51700,51701,52437);

DELETE FROM `spell_proc_event` WHERE `entry` IN (16166,16188,16246,16886,17116,4341,28200,63280,65007);
INSERT INTO `spell_proc_event` (`entry`,`SchoolMask`,`SpellFamilyName`,`procPhase`) VALUES
(16166,0,0,1),
(16188,8,11,1),
(16246,0,0,1),
(17116,8,7,1),
(4341,0,0,1),
(28200,0,0,1),
(63280,0,11,1),
(65007,0,0,1);

--
-- END UPDATING QUERIES
--
UPDATE version_db_world SET date = '2022_01_24_04' WHERE sql_rev = '1639592443028716900';
COMMIT;
END //
DELIMITER ;
CALL updateDb();
DROP PROCEDURE IF EXISTS `updateDb`;
