const winston = require('winston');
const DailyRotateFile = require('winston-daily-rotate-file');
const path = require('path');
const os = require('os');

// 获取日志目录路径
function getLogPath() {
    const platform = os.platform();
    const homeDir = os.homedir();
    
    switch (platform) {
        case 'win32':
            return path.join(homeDir, 'AppData', 'Local', 'ClawCloud', 'logs');
        case 'darwin':
            return path.join(homeDir, 'Library', 'Logs', 'ClawCloud');
        default:
            return path.join(homeDir, '.local', 'share', 'clawcloud', 'logs');
    }
}

const logDir = getLogPath();

// 创建日志格式
const logFormat = winston.format.combine(
    winston.format.timestamp({ format: 'YYYY-MM-DD HH:mm:ss' }),
    winston.format.printf(({ timestamp, level, message }) => {
        return `[${timestamp}] ${level.toUpperCase()}: ${message}`;
    })
);

// 创建日志记录器
const logger = winston.createLogger({
    level: 'info',
    format: logFormat,
    transports: [
        // 控制台输出
        new winston.transports.Console({
            format: winston.format.combine(
                winston.format.colorize(),
                logFormat
            )
        }),
        // 普通日志文件
        new DailyRotateFile({
            dirname: logDir,
            filename: 'app-%DATE%.log',
            datePattern: 'YYYY-MM-DD',
            maxFiles: '14d',
            maxSize: '20m'
        }),
        // 错误日志文件
        new DailyRotateFile({
            dirname: logDir,
            filename: 'error-%DATE%.log',
            datePattern: 'YYYY-MM-DD',
            maxFiles: '14d',
            maxSize: '20m',
            level: 'error'
        })
    ]
});

module.exports = logger; 