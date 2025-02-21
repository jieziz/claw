-- 创建数据库
CREATE DATABASE IF NOT EXISTS clawcloud_db;
USE clawcloud_db;

-- 创建产品类别表
CREATE TABLE categories (
    id VARCHAR(50) PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    sort INT DEFAULT 0    -- 添加排序字段，默认值为0
);

-- 创建产品表
CREATE TABLE products (
    id INTEGER PRIMARY KEY AUTOINCREMENT,    -- 产品ID，自增主键
    category_id VARCHAR(50),              -- 产品类别ID，关联categories表
    config VARCHAR(255) NOT NULL,         -- 产品配置信息(CPU/内存/硬盘等)
    discount_price VARCHAR(50) NOT NULL,  -- 折扣价格
    regions TEXT NOT NULL,                -- 可用区域
    discount VARCHAR(50) NOT NULL,        -- 折扣信息
    rules TEXT,                          -- 使用规则
    coupon_code VARCHAR(50),             -- 优惠码
    purchase_link TEXT NOT NULL,          -- 购买链接
    is_limited BOOLEAN DEFAULT FALSE,     -- 是否限量商品
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,  -- 创建时间
    FOREIGN KEY (category_id) REFERENCES categories(id)  -- 外键约束，关联categories表
);

-- 插入示例数据（添加sort值）
INSERT INTO categories (id, name, description, sort) VALUES
('Cloud-VPS', 'Cloud-VPS', '强大且灵活的VPS，折扣价实惠', 100),
('Cloud-VDS', 'Cloud-VDS', '高性能VPS，独享CPU内存存储资源', 90),
('Cloud-WIN', 'Cloud-WIN', 'Windows VPS，灵活易用', 80),
('China-Optimized', 'China Optimized', '专为中国优化的VPS', 70),
('Flash-Sale', 'Flash Sale', '限时抢购，折扣力度大', 60),
('Special-Offers', 'Special Offers', '特别优惠，限时抢购', 50);




INSERT INTO products (category_id, config, discount_price, regions, discount, rules, coupon_code, purchase_link, is_limited) VALUES
('Cloud-VPS', '1C/1G/20G/0.5T', '$3.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/kORV4M', false),
('Cloud-VPS', '2C/4G/60G/1T', '$8.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/GKDoyr', false),
('Cloud-VPS', '4C/8G/100G/2T', '$18.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/Xm1oe4', false),
('Cloud-VPS', '8C/16G/240G/4T', '$38.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/qz29rL', false),

('Cloud-VDS', '2C/8G/100G/2T', '$14.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/Qj6LV3', false),
('Cloud-VDS', '4C/16G/200G/4T', '$30.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/4GdM9n', false),
('Cloud-VDS', '8C/32G/360G/6T', '$54.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/N9NELV', false),
('Cloud-VDS', '16C/64G/480G/10T', '$102.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/e1AXdz', false),
('Cloud-VDS', '32C/128G/960G/15T', '$204.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/GKZJrL', false),
('Cloud-VDS', '64C/256G/1200G/20T', '$386.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/gOWBy9', false),

('Cloud-WIN', '2C/4G/80G/1T', '$16.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/yqroM3', false),
('Cloud-WIN', '2C/8G/120G/2T', '$20.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/6ygLBG', false),
('Cloud-WIN', '4C/8G/160G/4T', '$28.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/RG6q4b', false),
('Cloud-WIN', '4C/16G/240G/4T', '$36.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/YRdKeP', false),
('Cloud-WIN', '8C/16G/300G/5T', '$48.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/yqmAnW', false),
('Cloud-WIN', '8C/32G/400G/6T', '$66.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/7abKPg', false),

('China-Optimized', '2C/1G/40G/1T', '$6.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/DyKAVq', false),
('China-Optimized', '2C/2G/40G/1T', '$10.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/JKmXgE', false),
('China-Optimized', '2C/4G/60G/1T', '$20.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/mOn1MM', false),
('China-Optimized', '2C/4G/80G/1T', '$14.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/Bn2aDq', false),
('China-Optimized', '2C/8G/80G/2T', '$28.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/mOgo9D', false),
('China-Optimized', '2C/8G/100G/2T', '$20.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/RGyRxb', false),
('China-Optimized', '4C/8G/100G/4T', '$48.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/qzgoMY', false),
('China-Optimized', '4C/8G/200G/2T', '$30.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/xLnoM1', false),
('China-Optimized', '4C/16G/200G/6T', '$92.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/ra2K4v', false),
('China-Optimized', '4C/16G/400G/2T', '$56.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/aOWo1R', false),
('China-Optimized', '8C/16G/400G/6T', '$110.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/JKm6rq', false),
('China-Optimized', '8C/16G/600G/4T', '$80.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/DyLao2', false),
('China-Optimized', '16C/32G/1000G/8T', '$200.00 USD', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '', '', '', 'https://clawcloudsingaporeprivatelimited.sjv.io/gOWnbA', false);




INSERT INTO products (category_id, config, discount_price, regions, discount, rules, coupon_code, purchase_link, is_limited) VALUES
('Special-Offers', '1C/1G/20G/0.5T/200M', '$12.6/年', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦','65% OFF', '循环优惠', 'W8A0EKAA41', 'https://clawcloudsingaporeprivatelimited.sjv.io/yqmKkB', true),
('Special-Offers', '2C/2G/40G/1T/200M', '$25.2/年', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '65% OFF', '循环优惠', 'L204UYZHE7', 'https://clawcloudsingaporeprivatelimited.sjv.io/jeO7mM', true),
('Special-Offers', '4C/8G/80G/2T/200M', '$15/年', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦', '65% OFF', '循环优惠', 'PKA7FOY4G7', 'https://clawcloudsingaporeprivatelimited.sjv.io/19WYPD', true);




INSERT INTO products (category_id, config, discount_price, regions, discount, rules, coupon_code, purchase_link, is_limited) VALUES

('Flash-Sale', 'Cloud VDS-2C/4G/80G/1T/200M', '$4.2/月', '香港/日本/新加坡/法兰克福/北弗吉尼亚/北加利福尼亚/印度尼西亚-雅加达/英国-伦敦','65% OFF', '循环优惠 - 每日下午11点更新库存，每日限10台 ', 'CLAWVDSflash', 'https://clawcloudsingaporeprivatelimited.sjv.io/kOoKk3', true),
('Flash-Sale', 'China Optimized-2C/1G/40G/1T/1000M', '$4.2/月', '香港/日本/新加坡','30% OFF', '循环优惠 - 每日上午11点更新库存，每日限10台
', '4CLAWflash', 'https://clawcloudsingaporeprivatelimited.sjv.io/YRye1r', true);

