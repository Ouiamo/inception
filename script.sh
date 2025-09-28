# 1. Clean setup
make fclean
make re

# 2. Test terminal access
curl -k https://oaoulad-.42.fr | grep -o "<title>.*</title>"

# 3. Open in browser instructions
echo ""
echo "✅ Now open your browser and go to: https://oaoulad-.42.fr"
echo "   Remember to accept the security warning!"
#https://chat.deepseek.com/share/4sxqkpk59n9hnjv6r8