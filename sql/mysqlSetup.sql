-- Wonderland Nightmares Database Setup
CREATE DATABASE IF NOT EXISTS wonderland_nightmares_db;
USE wonderland_nightmares_db;

-- Drop tables if they exist (for easy reset)
DROP TABLE IF EXISTS retailers;
DROP TABLE IF EXISTS players;
DROP TABLE IF EXISTS cards;
DROP TABLE IF EXISTS card_sets;

-- 1. Card Sets (Expansions)
CREATE TABLE card_sets (
    set_id INT AUTO_INCREMENT PRIMARY KEY,
    set_name VARCHAR(100) NOT NULL,
    set_code VARCHAR(20) UNIQUE NOT NULL,
    release_date DATE,
    total_cards INT DEFAULT 0,
    theme VARCHAR(100)
);

-- 2. Cards
CREATE TABLE cards (
    card_id INT AUTO_INCREMENT PRIMARY KEY,
    card_name VARCHAR(100) NOT NULL,
    character_type VARCHAR(50),           -- Hero, Villain, Creature, Weapon, Location
    domain VARCHAR(80),                   -- Vale of Tears, Queensland etc.
    madness_level INT CHECK (madness_level BETWEEN 0 AND 100),
    attack INT DEFAULT 0,
    defense INT DEFAULT 0,
    ability TEXT,
    rarity ENUM('Common', 'Rare', 'Epic', 'Legendary') DEFAULT 'Common',
    market_price DECIMAL(10,2) DEFAULT 0.00,
    image_data LONGBLOB,                  -- for card picture
    file_name VARCHAR(100),
    content_type VARCHAR(50),
    set_id INT,
    FOREIGN KEY (set_id) REFERENCES card_sets(set_id)
);

-- 3. Players (Competitive)
CREATE TABLE players (
    player_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    nationality VARCHAR(60),
    favorite_card_id INT,
    best_achievement VARCHAR(150),
    current_ranking INT DEFAULT 0,
    madness_points INT DEFAULT 0,
    FOREIGN KEY (favorite_card_id) REFERENCES cards(card_id)
);

-- 4. Retailers (Shops)
CREATE TABLE retailers (
    retailer_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    address VARCHAR(200),
    opening_hours VARCHAR(100),
    phone VARCHAR(30),
    status ENUM('Open', 'Closed', 'Online Only') DEFAULT 'Open',
    stock_level INT DEFAULT 0
);

-- Insert sample data
INSERT INTO card_sets (set_name, set_code, release_date, theme) VALUES
('Chapter 1: Down the Rabbit Hole', 'WNR-01', '2025-03-15', 'Classic Wonderland'),
('Chapter 2: The Vale of Tears', 'WNR-02', '2025-06-20', 'Industrial Nightmare');

INSERT INTO cards (card_name, character_type, domain, madness_level, attack, defense, ability, rarity) VALUES
('Mad Alice', 'Hero', 'Vale of Tears', 85, 75, 60, 'Vorpal Blade Strike', 'Legendary'),
('Queen of Hearts', 'Villain', 'Queensland', 95, 90, 70, 'Off With Their Heads', 'Epic'),
('Cheshire Cat', 'Creature', 'Wonderland', 70, 55, 45, 'Teleport and Taunt', 'Rare');

INSERT INTO players (name, nationality, best_achievement, current_ranking, madness_points) VALUES
('Liubov Lykhosherst', 'Ukraine', '1st Place - Wonderland Cup 2025', 12, 2450),
('Conor Francome', 'Ireland', 'Top 8 - Regional Tournament', 45, 980);

INSERT INTO retailers (name, address, opening_hours, phone, status) VALUES
('Wonderland Cards Store', '123 Rabbit Hole Street, Dublin', '10:00-19:00', '+353 123 4567', 'Open'),
('Gothic Games', '45 Madness Lane, Kyiv', '11:00-20:00', '+380 44 555 6677', 'Open');
