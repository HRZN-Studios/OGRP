CREATE TABLE
    IF NOT EXISTS `0resmon_apartment_rooms` (
        id INT (11) NOT NULL AUTO_INCREMENT,
        apartment_id INT (11) NOT NULL,
        room_id INT (11) NOT NULL,
        owner VARCHAR(64) NOT NULL,
        owner_name VARCHAR(64) NOT NULL,
        life_time BOOLEAN DEFAULT 0,
        options TEXT,
        permissions MEDIUMTEXT,
        furnitures LONGTEXT,
        indicators MEDIUMTEXT,
        due_date DATETIME NOT NULL,
        created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
        updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
        KEY id (id)
    ) ENGINE = InnoDB AUTO_INCREMENT = 1;

    
    -- IF NOT EXISTS `0resmon_apartment_rooms` (
    --     id INT (11) NOT NULL AUTO_INCREMENT,
    --     apartment_id INT (11) NOT NULL,
    --     room_id INT (11) NOT NULL,
    --     owner VARCHAR(64) NOT NULL,
    --     owner_name VARCHAR(64) NOT NULL,
    --     life_time BOOLEAN DEFAULT 0,
    --     options TEXT DEFAULT "{}",
    --     permissions MEDIUMTEXT DEFAULT "{}",
    --     furnitures LONGTEXT DEFAULT "{}",
    --     indicators MEDIUMTEXT DEFAULT "{}",
    --     due_date DATETIME NOT NULL,
    --     created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP(),
    --     updated_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP() ON UPDATE CURRENT_TIMESTAMP(),
    --     KEY id (id)
    -- ) ENGINE = InnoDB AUTO_INCREMENT = 1;