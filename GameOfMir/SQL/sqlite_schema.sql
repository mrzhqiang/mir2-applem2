-- SQLite 数据库 Schema
-- 用于从 DBC2000 迁移到 SQLite3

-- 角色信息表（对应 Hum.DB）
CREATE TABLE IF NOT EXISTS hum_info (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    chr_name TEXT NOT NULL UNIQUE,
    account TEXT NOT NULL,
    deleted INTEGER DEFAULT 0,
    gm_deleted INTEGER DEFAULT 0,
    selected INTEGER DEFAULT 0,
    mod_date REAL,
    count INTEGER DEFAULT 0,
    created_at REAL DEFAULT (julianday('now')),
    updated_at REAL DEFAULT (julianday('now'))
);

CREATE INDEX IF NOT EXISTS idx_hum_info_account ON hum_info(account);
CREATE INDEX IF NOT EXISTS idx_hum_info_chr_name ON hum_info(chr_name);
CREATE INDEX IF NOT EXISTS idx_hum_info_deleted ON hum_info(deleted);

-- 角色数据表（对应 Mir.DB，存储完整的 THumDataInfo 二进制数据）
CREATE TABLE IF NOT EXISTS hum_data (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    chr_name TEXT NOT NULL UNIQUE,
    account TEXT NOT NULL,
    data_blob BLOB NOT NULL,
    data_size INTEGER NOT NULL,
    created_at REAL DEFAULT (julianday('now')),
    updated_at REAL DEFAULT (julianday('now')),
    FOREIGN KEY (chr_name) REFERENCES hum_info(chr_name) ON DELETE CASCADE
);

CREATE INDEX IF NOT EXISTS idx_hum_data_account ON hum_data(account);
CREATE INDEX IF NOT EXISTS idx_hum_data_chr_name ON hum_data(chr_name);

-- 账号表（对应 CDKey 表）
CREATE TABLE IF NOT EXISTS account (
    account TEXT PRIMARY KEY,
    password TEXT NOT NULL,
    card_id INTEGER DEFAULT 0,
    game_gold INTEGER DEFAULT 0,
    user_name TEXT DEFAULT '',
    birth_day TEXT DEFAULT '',
    quiz1 TEXT DEFAULT '',
    answer1 TEXT DEFAULT '',
    quiz2 TEXT DEFAULT '',
    answer2 TEXT DEFAULT '',
    email TEXT DEFAULT '',
    phone TEXT DEFAULT '',
    mobile_phone TEXT DEFAULT '',
    identity_card TEXT DEFAULT '',
    reg_date_time REAL DEFAULT (julianday('now')),
    login_date_time REAL DEFAULT (julianday('now'))
);

CREATE INDEX IF NOT EXISTS idx_account_email ON account(email);

-- 角色名称表（对应 GMAE_CHRNAME）
CREATE TABLE IF NOT EXISTS chr_name (
    chr_name TEXT PRIMARY KEY
);

-- 行会名称表（对应 GMAE_GUILDNAME）
CREATE TABLE IF NOT EXISTS guild_name (
    guild_name TEXT PRIMARY KEY
);

-- 矩阵卡表（对应 MatrixCard）
CREATE TABLE IF NOT EXISTS matrix_card (
    card_no TEXT PRIMARY KEY,
    cdkey_id INTEGER DEFAULT 0,
    apply_time REAL DEFAULT (julianday('now')),
    card_1 INTEGER NOT NULL DEFAULT 0,
    card_2 INTEGER NOT NULL DEFAULT 0,
    card_3 INTEGER NOT NULL DEFAULT 0,
    card_4 INTEGER NOT NULL DEFAULT 0,
    card_5 INTEGER NOT NULL DEFAULT 0,
    card_6 INTEGER NOT NULL DEFAULT 0,
    card_7 INTEGER NOT NULL DEFAULT 0,
    card_8 INTEGER NOT NULL DEFAULT 0,
    card_9 INTEGER NOT NULL DEFAULT 0,
    card_10 INTEGER NOT NULL DEFAULT 0,
    card_11 INTEGER NOT NULL DEFAULT 0,
    card_12 INTEGER NOT NULL DEFAULT 0,
    card_13 INTEGER NOT NULL DEFAULT 0,
    card_14 INTEGER NOT NULL DEFAULT 0,
    card_15 INTEGER NOT NULL DEFAULT 0,
    card_16 INTEGER NOT NULL DEFAULT 0,
    card_17 INTEGER NOT NULL DEFAULT 0,
    card_18 INTEGER NOT NULL DEFAULT 0,
    card_19 INTEGER NOT NULL DEFAULT 0,
    card_20 INTEGER NOT NULL DEFAULT 0,
    card_21 INTEGER NOT NULL DEFAULT 0,
    card_22 INTEGER NOT NULL DEFAULT 0,
    card_23 INTEGER NOT NULL DEFAULT 0,
    card_24 INTEGER NOT NULL DEFAULT 0,
    card_25 INTEGER NOT NULL DEFAULT 0,
    card_26 INTEGER NOT NULL DEFAULT 0,
    card_27 INTEGER NOT NULL DEFAULT 0,
    card_28 INTEGER NOT NULL DEFAULT 0,
    card_29 INTEGER NOT NULL DEFAULT 0,
    card_30 INTEGER NOT NULL DEFAULT 0
);

-- 启用外键约束
PRAGMA foreign_keys = ON;

-- 设置 WAL 模式以提高并发性能
PRAGMA journal_mode = WAL;

-- 设置同步模式（NORMAL 模式在 WAL 模式下是安全的）
PRAGMA synchronous = NORMAL;
