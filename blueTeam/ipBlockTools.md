IP-manzillarni bloklash va trafikni boshqarish uchun **iptables** dan tashqari ham bir nechta samarali usullar va vositalar mavjud. Quyida **alternativ firewall va xavfsizlik vositalari** haqida ma’lumot beraman.  

---

## **1️⃣ Iptables ga Alternativ Firewall va Tarmoq Himoya Vositalari**  

### **🔥 1. nftables (Linux Kernel Firewall)**
**iptables** ning o‘rniga Linux yadrosi (kernel) tomonidan **rivojlantirilgan zamonaviy firewall tizimi**.  
✔️ **Tezroq ishlaydi, optimallashtirilgan va kamroq tizim resurslari talab qiladi.**  
✔️ **iptables sintaksisidan soddaroq va kuchliroq**.  

✅ **IP-manzilni bloklash uchun nftables ishlatish:**  
```bash
nft add table ip filter
nft add chain ip filter input { type filter hook input priority 0 \; }
nft add rule ip filter input ip saddr 192.168.1.100 drop
```
📌 **Bu qoidalar 192.168.1.100 IP-manzildan kelayotgan trafikni bloklaydi.**  

✅ **Barcha kelayotgan bog‘lanishlarni bloklash (iptables alternative)**  
```bash
nft add rule ip filter input drop
```

---

### **🛡️ 2. UFW (Uncomplicated Firewall)**
UFW – Ubuntu va Debian tizimlarida foydalanish uchun **sodda va kuchli firewall**.  

✅ **UFW’ni o‘rnatish va yoqish**  
```bash
sudo apt install ufw
sudo ufw enable
```

✅ **Muayyan IP-manzilni bloklash**  
```bash
sudo ufw deny from 192.168.1.100
```

✅ **Muayyan portni bloklash (masalan, 22-SSH portini)**  
```bash
sudo ufw deny 22
```

✅ **Barcha kelayotgan bog‘lanishlarni bloklash va faqat kerakli portlarga ruxsat berish:**  
```bash
sudo ufw default deny incoming
sudo ufw allow 80  # HTTP ruxsat berish
sudo ufw allow 443  # HTTPS ruxsat berish
```

---

### **⚡ 3. firewalld (RedHat va CentOS uchun)**
**firewalld** – RHEL/CentOS/Fedora tizimlarida **iptables o‘rniga** foydalaniladigan dinamik firewall.  

✅ **Firewalld-ni yoqish:**  
```bash
sudo systemctl start firewalld
sudo systemctl enable firewalld
```

✅ **Muayyan IP-manzilni bloklash:**  
```bash
sudo firewall-cmd --permanent --add-rich-rule='rule family="ipv4" source address="192.168.1.100" drop'
sudo firewall-cmd --reload
```

✅ **Muayyan portni bloklash:**  
```bash
sudo firewall-cmd --permanent --remove-service=ssh
sudo firewall-cmd --reload
```

---

## **2️⃣ Avtomatlashtirilgan Hujumlarga Qarshi Himoya Vositalari**  

### **🚨 4. Fail2Ban (Brute-force hujumlardan himoya)**
**Fail2Ban** avtomatik ravishda **ssh, apache, nginx va boshqa xizmatlarga hujum qilayotgan IP-larni bloklaydi**.  

✅ **Fail2Ban o‘rnatish:**  
```bash
sudo apt install fail2ban
```

✅ **SSH-ga hujum qilayotgan IP-manzillarni bloklash:**  
```bash
sudo nano /etc/fail2ban/jail.local
```
📌 **jail.local faylida quyidagilarni qo‘shing:**  
```
[sshd]
enabled = true
port = ssh
filter = sshd
logpath = /var/log/auth.log
maxretry = 3
bantime = 600
```
✅ **Fail2Ban xizmatini ishga tushirish:**  
```bash
sudo systemctl restart fail2ban
sudo fail2ban-client status sshd
```
📌 **Bu SSH serverga hujum qilayotgan IP-larni avtomatik bloklaydi!**  

---

### **🌍 5. CrowdSec (Sun’iy intellekt yordamida xavfsizlik)**
CrowdSec **Fail2Ban’ga o‘xshash, lekin AI va global threat intelligence yordamida ishlaydi**.  

✅ **CrowdSec o‘rnatish:**  
```bash
curl -s https://packagecloud.io/install/repositories/crowdsec/crowdsec/script.deb.sh | sudo bash
sudo apt install crowdsec
```

✅ **Bloklangan IP-larni ko‘rish:**  
```bash
sudo cscli decisions list
```

✅ **Muayyan IP-manzilni qo‘lda bloklash:**  
```bash
sudo cscli decisions add --ip 192.168.1.100 --duration 1h
```

📌 **CrowdSec foydalanuvchilar tarmog‘i orqali doimiy ravishda yangilanib turadi va yangi tahdidlarni avtomatik bloklaydi.**  

---

### **🚀 6. Suricata (IDS/IPS tarmoq monitoring vositasi)**
**Suricata** – an’anaviy firewall’lardan farqli o‘laroq **real vaqt rejimida tarmoq trafikini tahlil qilib, zararli urinishlarni bloklaydi.**  

✅ **Suricata o‘rnatish:**  
```bash
sudo apt install suricata
```

✅ **Suricata’ni IDS rejimida ishga tushirish:**  
```bash
sudo suricata -c /etc/suricata/suricata.yaml -i eth0
```
📌 **IDS rejimida hujumlarni kuzatish va logga yozish, IPS rejimida esa avtomatik bloklash mumkin.**  

✅ **Tarmoqdagi shubhali harakatlarni tekshirish:**  
```bash
sudo tail -f /var/log/suricata/fast.log
```

---

### **🛑 7. IPSet (Massiv IP-manzillarni bloklash)**
Agar siz **katta miqdordagi IP-manzillarni bloklashni** istasangiz, **ipset** ishlatish yaxshi natija beradi.  

✅ **ipset o‘rnatish:**  
```bash
sudo apt install ipset
```

✅ **Bloklangan IP-lar uchun yangi ro‘yxat yaratish:**  
```bash
sudo ipset create blocklist hash:ip
```

✅ **Muayyan IP-manzillarni bloklash:**  
```bash
sudo ipset add blocklist 192.168.1.100
```

✅ **iptables bilan birga ishlatish:**  
```bash
sudo iptables -A INPUT -m set --match-set blocklist src -j DROP
```

📌 **ipset juda katta IP ro‘yxatlarini bloklashda samarali ishlaydi (millionlab IP-larni boshqarish mumkin).**  

---

## **📌 Xulosa**
| **Vosita**        | **Asosiy vazifasi** |
|------------------|-----------------|
| **nftables**      | iptables ning tezroq va samaraliroq versiyasi |
| **UFW**          | Oddiy va sodda firewall (Debian/Ubuntu) |
| **firewalld**    | Dinamik firewall (RedHat/CentOS) |
| **Fail2Ban**     | Brute-force hujumlarga qarshi avtomatik bloklash |
| **CrowdSec**     | AI va global threat intelligence bilan ishlaydigan xavfsizlik tizimi |
| **Suricata**     | Real vaqt rejimida IDS/IPS tarmoq monitoringi |
| **IPSet**        | Katta miqdordagi IP-manzillarni bloklash uchun maxsus vosita |

🚀 **Siz qaysi usul yoki vositalarni ishlatmoqchisiz? Qo‘shimcha amaliy misollar kerak bo‘lsa, ayting!** 😊
