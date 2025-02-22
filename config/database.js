const Database = require('better-sqlite3');
const path = require('path');
const fs = require('fs');
const os = require('os');
const logger = require('./logger');
require('dotenv').config();

// 根据操作系统类型自动设置数据库路径
function getDbPath() {
    const platform = os.platform();
    const homeDir = os.homedir();
    
    switch (platform) {
        case 'win32': // Windows
            return path.join(homeDir, 'AppData', 'Local', 'ClawCloud', 'data.db');
        case 'darwin': // macOS
            return path.join(homeDir, 'Library', 'Application Support', 'ClawCloud', 'data.db');
        default: // Linux 和其他类Unix系统
            return path.join(homeDir, '.local', 'share', 'clawcloud', 'data.db');
    }
}

// 获取数据库路径
const dbPath = process.env.SQLITE_DB_PATH || path.join(
    __dirname,
    '../data/database.sqlite'
);

// 确保数据库目录存在
const dbDir = path.dirname(dbPath);
if (!fs.existsSync(dbDir)) {
    fs.mkdirSync(dbDir, { recursive: true });
    logger.info(`创建数据库目录: ${dbDir}`);
}

logger.info(`数据库路径: ${dbPath}`);

// 创建数据库连接，添加重试机制
let db;
const maxRetries = 3;
let retryCount = 0;

while (retryCount < maxRetries) {
  try {
    db = new Database(dbPath, { 
        verbose: (message) => logger.debug(message),
        fileMustExist: false
    });
    break;
  } catch (error) {
    retryCount++;
    logger.error(`尝试连接数据库失败 (${retryCount}/${maxRetries}):`, error);
    if (retryCount === maxRetries) {
      throw error;
    }
    // 等待一秒后重试
    new Promise(resolve => setTimeout(resolve, 1000));
  }
}
logger.info('数据库连接已创建');

// 初始化数据库表和数据
function initDatabase() {
    try {
        // 创建类别表
        db.exec(`CREATE TABLE IF NOT EXISTS categories (
            id TEXT PRIMARY KEY,
            name TEXT NOT NULL,
            description TEXT,
            sort INTEGER DEFAULT 0
        )`);
        logger.info('categories表创建成功');

        // 创建产品表
        db.exec(`CREATE TABLE IF NOT EXISTS products (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            category_id TEXT,
            config TEXT NOT NULL,
            discount_price TEXT NOT NULL,
            regions TEXT NOT NULL,
            discount TEXT NOT NULL,
            rules TEXT,
            coupon_code TEXT,
            purchase_link TEXT NOT NULL,
            is_limited INTEGER DEFAULT 0,
            created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
            FOREIGN KEY (category_id) REFERENCES categories(id)
        )`);
        logger.info('products表创建成功');
    } catch (error) {
        logger.error('初始化数据库失败:', error);
        throw error;
    }
}

// 初始化数据库
initDatabase();

// 数据库操作方法
function all(sql, params = []) {
    try {
        const stmt = db.prepare(sql);
        const result = stmt.all(params);
        logger.debug(`执行查询: ${sql}, 参数: ${JSON.stringify(params)}`);
        return result;
    } catch (error) {
        logger.error(`查询失败: ${sql}, 参数: ${JSON.stringify(params)}, 错误: ${error.message}`);
        throw error;
    }
}

function get(sql, params = []) {
    try {
        const stmt = db.prepare(sql);
        const result = stmt.get(params);
        logger.debug(`执行查询: ${sql}, 参数: ${JSON.stringify(params)}`);
        return result;
    } catch (error) {
        logger.error(`查询失败: ${sql}, 参数: ${JSON.stringify(params)}, 错误: ${error.message}`);
        throw error;
    }
}

function run(sql, params = []) {
    try {
        const stmt = db.prepare(sql);
        const result = stmt.run(params);
        logger.debug(`执行更新: ${sql}, 参数: ${JSON.stringify(params)}`);
        return result;
    } catch (error) {
        logger.error(`更新失败: ${sql}, 参数: ${JSON.stringify(params)}, 错误: ${error.message}`);
        throw error;
    }
}

module.exports = {
    run,
    get,
    all,
    dbPath
}; 