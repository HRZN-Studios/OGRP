CREATE TABLE
    IF NOT EXISTS `0resmon_weed_plants` (
        id INT (11) NOT NULL AUTO_INCREMENT,
        zoneId VARCHAR(64) NOT NULL,
        genetics VARCHAR(6) NOT NULL,
        stage INT (11) NOT NULL DEFAULT 1,
        health INT (11) DEFAULT 100,
        light INT (11) DEFAULT 0,
        water INT (11) DEFAULT 0,
        fertilizer INT (11) DEFAULT 0,
        coords TEXT DEFAULT NULL,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
        updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
        PRIMARY KEY (id)
    ) ENGINE = InnoDB AUTO_INCREMENT = 1;

CREATE TABLE
    IF NOT EXISTS `0resmon_weed_dryers` (
        id INT (11) NOT NULL AUTO_INCREMENT,
        zoneId VARCHAR(64) NOT NULL,
        dryerId VARCHAR(64) DEFAULT "",
        extraDryEffect INT (11) DEFAULT 0,
        items LONGTEXT,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
        updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
        PRIMARY KEY (id)
    ) ENGINE = InnoDB AUTO_INCREMENT = 1;





--     IF NOT EXISTS `0resmon_weed_plants` (
--         id INT (11) NOT NULL AUTO_INCREMENT,
--         zoneId VARCHAR(64) NOT NULL,
--         genetics VARCHAR(6) NOT NULL,
--         stage INT (11) NOT NULL DEFAULT 1,
--         health INT (11) DEFAULT 100,
--         light INT (11) DEFAULT 0,
--         water INT (11) DEFAULT 0,
--         fertilizer INT (11) DEFAULT 0,
--         coords TEXT DEFAULT NULL,
--         created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
--         updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
--         PRIMARY KEY (id)
--     ) ENGINE = InnoDB AUTO_INCREMENT = 1;

-- CREATE TABLE
--     IF NOT EXISTS `0resmon_weed_dryers` (
--         id INT (11) NOT NULL AUTO_INCREMENT,
--         zoneId VARCHAR(64) NOT NULL,
--         dryerId VARCHAR(64) DEFAULT "",
--         extraDryEffect INT (11) DEFAULT 0,
--         items LONGTEXT DEFAULT "{}",
--         created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
--         updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
--         PRIMARY KEY (id)
--     ) ENGINE = InnoDB AUTO_INCREMENT = 1;