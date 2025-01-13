// 汉堡菜单切换
const mobileMenuButton = document.getElementById('mobile-menu-button');
const mobileMenu = document.getElementById('mobile-menu');
mobileMenuButton.addEventListener('click', () => {
    mobileMenu.classList.toggle('hidden');
});


// 复制优惠码功能
function copyCouponCode() {
    const couponCode = document.getElementById('coupon-code').innerText;
    navigator.clipboard.writeText(couponCode).then(() => {
        showNotification('优惠码已复制！');
    }).catch(() => {
        showNotification('复制失败，请手动复制优惠码。', 'red');
    });
}

// 显示侧边提示
function showNotification(message, bgColor = 'yellow') {
    const notification = document.getElementById('copy-notification');
    notification.innerText = message;
    notification.className = `fixed top-4 right-0 bg-${bgColor}-600 text-white px-2 py-1 rounded-md shadow-lg transform translate-x-full transition-transform duration-300`;

    // 显示提示
    setTimeout(() => {
        notification.classList.remove('translate-x-full');
    }, 10);

    // 3秒后隐藏提示
    setTimeout(() => {
        notification.classList.add('translate-x-full');
    }, 3000);
}

// 关闭横幅功能
function setupBannerClose() {
    const closeButton = document.getElementById('close-banner');
    const banner = document.getElementById('top-banner');
    if (closeButton && banner) {
        closeButton.addEventListener('click', () => {
            banner.style.display = 'none'; // 隐藏横幅
        });
    }
}

// 初始化
function init() {
    setupBannerClose();
}

// 页面加载完成后执行初始化
document.addEventListener('DOMContentLoaded', init);