echo "=== COMPREHENSIVE TEST ==="
echo "1. Containers running:"
docker ps

echo "2. WordPress installation:"
docker exec wordpress wp core is-installed --allow-root

echo "3. Database connection:"
docker exec wordpress mysql -h mariadb -u wp_user -p"wp_password" -e "SELECT 1" 2>/dev/null && echo "✅ Database connected" || echo "❌ Database connection failed"

echo "4. WordPress files:"
docker exec wordpress ls -la /var/www/html/wp-config.php && echo "✅ wp-config.php exists" || echo "❌ wp-config.php missing"

echo "5. php-fpm status:"
docker exec wordpress ps aux | grep php-fpm && echo "✅ php-fpm running" || echo "❌ php-fpm not running"

echo "=== ALL TESTS COMPLETED ==="