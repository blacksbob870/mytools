**PRIVILAGE ESCALATION**

### **Linux (linPEAS o‘rniga) uchun:**

1. **Les (Linux Exploit Suggester)**
   - Exploit yoki yadro zaifliklarini topish uchun ishlatiladi.
   - `linux-exploit-suggester.sh`
   - 🔗 https://github.com/mzet-/linux-exploit-suggester

2. **LinEnum**
   - Kerakli konfiguratsiyalar va noto‘g‘ri sozlangan huquqlarni aniqlaydi.
   🔗 https://github.com/rebootuser/LinEnum

3. **LSE (Linux Smart Enumeration)**
   - Ko‘proq xavfsizlikka yo‘naltirilgan va interaktiv output beradi.
   - Root huquqiga olib borishi mumkin bo‘lgan imkoniyatlarni ko‘rsatadi.
   🔗 https://github.com/diego-treitos/linux-smart-enumeration

4. **bashark**
   - Shell doirasida ishlaydigan va post-exploitation uchun qulay script.
   - Bash tarixlar, konfiguratsiyalar va qoidalarni ko‘rib chiqadi.
🔗 https://github.com/redcode-labs/Bashark
5. **Pspy**
   - "Process Spy" deb ataladi.
   - Real vaqt rejimida root yoki boshqa foydalanuvchilar ishlatayotgan skriptlar yoki cronjob-larni kuzatadi.
🔗 https://github.com/DominicBreuker/pspy
---

### **Windows (winPEAS o‘rniga) uchun:**

1. **PowerUp**
   - Windows post-exploitation va privilege escalation uchun PowerShell script.
   - Misconfigurations va yomon o‘rnatilgan servislarni topadi.
🔗 https://github.com/PowerShellMafia/PowerSploit/tree/master/Privesc

2. **Seatbelt**
   - Windows ma’lumotlarini to‘playdigan yengil tool.
   - `Sharp-Suite` ning bir qismi.
🔗 https://github.com/GhostPack/Seatbelt

3. **Watson**
   - Local privilege escalation zaifliklarini qidiradi va CVE raqamlari bilan ko‘rsatadi.
   - Oldingi patch qilinmagan zaifliklarni aniqlaydi.
🔗 https://github.com/rasta-mouse/Watson

4. **Windows Exploit Suggester – NG**
   - Offline Windows tahlil vositasi.
   - Windows versiyasi va patch darajasiga qarab exploit tavsiyalarini beradi.
🔗 https://github.com/bitsadmin/wesng

5. **PrivescCheck**
   - Windows uchun GUI hamda command-line privilege escalation checker.
   - ACL, servislar va boshqa noto‘g‘ri sozlangan narsalarni tekshiradi.
🔗 https://github.com/itm4n/PrivescCheck
---

### ** Kross-platforma (Linux va Windows uchun):**

- **BeRoot**
  - Windows, Linux va MacOS uchun mavjud.
  - Privilege escalation imkoniyatlarini avtomatik tekshiradi.
🔗 https://github.com/AlessandroZ/BeRoot
---


**ready script for linux**
#!/bin/bash

echo "[*] LinEnum ishga tushirilmoqda..."
git clone https://github.com/rebootuser/LinEnum.git
cd LinEnum && chmod +x LinEnum.sh && ./LinEnum.sh && cd ..

echo "[*] linux-exploit-suggester ishga tushirilmoqda..."
git clone https://github.com/mzet-/linux-exploit-suggester.git
cd linux-exploit-suggester && perl linux-exploit-suggester.pl && cd ..

echo "[*] linux-smart-enumeration ishga tushirilmoqda..."
git clone https://github.com/diego-treitos/linux-smart-enumeration.git
cd linux-smart-enumeration && chmod +x lse.sh && ./lse.sh -l1 && cd ..

echo "[*] pspy ishga tushirilmoqda..."
git clone https://github.com/DominicBreuker/pspy.git
echo "[!] pspy uchun manual run (pspy64 yoki pspy32) => cd pspy && ./pspy64"

echo "[*] Barcha vositalar yuklandi va ishga tushdi."

**ready script for windows**
Write-Host "[*] PowerUp yuklanmoqda..."
git clone https://github.com/PowerShellMafia/PowerSploit.git
cd PowerSploit\Privesc
Import-Module .\PowerUp.ps1
Invoke-AllChecks

Write-Host "[*] Seatbelt yuklanmoqda..."
git clone https://github.com/GhostPack/Seatbelt.git
Write-Host "[!] Seatbelt ni kompilyatsiya qilish kerak yoki release’dan .exe yuklab oling."

Write-Host "[*] Watson yuklanmoqda..."
git clone https://github.com/rasta-mouse/Watson.git
Write-Host "[!] Watson ham kompilyatsiya talab qiladi (C# yordamida) yoki precompiled versiyani ishlating."

Write-Host "[*] PrivescCheck yuklanmoqda..."
git clone https://github.com/itm4n/PrivescCheck.git
cd PrivescCheck
Write-Host "[!] PrivescCheck.exe faylini ishga tushirishga tayyor!"

**Qo‘shimcha tavsiyalar:**
pspy va Seatbelt/Watson kabi vositalar ba’zida .exe yoki pspy64 binar shaklida ishlaydi, shuning uchun manual run qilish kerak.

Windows uchun kompilyatsiyaga ehtiyoji bor tool-lar uchun Visual Studio yoki msbuild kerak bo‘ladi.







