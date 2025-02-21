const express = require('express');
const path = require('path');
const db = require('./config/database');
const logger = require('./config/logger');
require('dotenv').config();

const app = express();
const port = process.env.PORT || 3000;

// 静态资源请求不记录日志
const skipLogging = (req) => {
    // 跳过静态资源的请求日志
    const staticExtensions = ['.js', '.css', '.png', '.jpg', '.jpeg', '.gif', '.ico', '.webp', '.woff', '.woff2', '.ttf'];
    const ext = path.extname(req.url).toLowerCase();
    return staticExtensions.includes(ext);
};

// 请求日志中间件
app.use((req, res, next) => {
    if (!skipLogging(req)) {
        logger.info(`${req.method} ${req.url}`);
    }
    next();
});

// 静态文件服务 - 将 public 目录设置为静态资源目录
app.use(express.static('public'));

// 允许跨域请求
app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Headers', 'Origin, X-Requested-With, Content-Type, Accept');
    next();
});

// 根路由 - 返回首页
app.get('/', (req, res) => {
    res.sendFile(path.join(__dirname, 'public', 'index.html'));
});

// 获取产品类别接口
app.get('/api/categories', async (req, res) => {
    try {
        const categories = await db.all('SELECT * FROM categories ORDER BY sort ASC');
        res.json(categories);
    } catch (error) {
        logger.error('Error fetching categories:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// 获取产品列表接口
app.get('/api/products/:categoryId', async (req, res) => {
    try {
        const categoryId = req.params.categoryId;
        const products = await db.all(
            'SELECT * FROM products WHERE category_id = ?',
            [categoryId]
        );
        res.json(products);
    } catch (error) {
        console.error('Error fetching products:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// 添加新产品接口
app.post('/api/products', express.json(), async (req, res) => {
    try {
        const {
            category_id,
            config,
            discount_price,
            regions,
            discount,
            rules,
            coupon_code,
            purchase_link,
            is_limited
        } = req.body;

        const result = await db.run(
            `INSERT INTO products 
            (category_id, config, discount_price, regions, discount, rules, coupon_code, purchase_link, is_limited)
            VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)`,
            [category_id, config, discount_price, regions, discount, rules, coupon_code, purchase_link, is_limited]
        );

        res.status(201).json({
            message: 'Product created successfully',
            productId: result.lastID
        });
    } catch (error) {
        console.error('Error creating product:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// 更新产品接口
app.put('/api/products/:id', express.json(), async (req, res) => {
    try {
        const productId = req.params.id;
        const updateData = req.body;
        
        const result = await db.run(
            'UPDATE products SET config = ?, discount_price = ?, regions = ?, discount = ?, rules = ?, coupon_code = ?, purchase_link = ?, is_limited = ? WHERE id = ?',
            [updateData.config, updateData.discount_price, updateData.regions, updateData.discount, updateData.rules, updateData.coupon_code, updateData.purchase_link, updateData.is_limited, productId]
        );

        if (result.changes === 0) {
            return res.status(404).json({ error: 'Product not found' });
        }

        res.json({ message: 'Product updated successfully' });
    } catch (error) {
        console.error('Error updating product:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// 删除产品接口
app.delete('/api/products/:id', async (req, res) => {
    try {
        const productId = req.params.id;
        
        const result = await db.run(
            'DELETE FROM products WHERE id = ?',
            [productId]
        );

        if (result.changes === 0) {
            return res.status(404).json({ error: 'Product not found' });
        }

        res.json({ message: 'Product deleted successfully' });
    } catch (error) {
        console.error('Error deleting product:', error);
        res.status(500).json({ error: 'Internal server error' });
    }
});

// 错误处理中间件
app.use((err, req, res, next) => {
    logger.error('服务器错误:', err);
    res.status(500).json({ error: 'Internal server error' });
});

app.listen(port, () => {
    logger.info(`服务器启动在 http://localhost:${port}`);
}); 