Zo‘r! Endi **Docker xavfsizligi bo‘yicha ko‘proq real misollar** va **hujumga qarshi kurashish usullari** bilan tushuntirib beraman.  

---  

# **🔥 Scenario 2: Hujumchi Port Scanner ishlatmoqda va SSH Bruteforce qilmoqda**  

## **🛑 1. Hujumni aniqlash (Port Scanning va SSH Bruteforce)**
Siz **Falco yoki Suricata** kabi vositalar orqali tizimni monitoring qilib turibsiz.  
Tizim **ko‘p sonli shubhali ulanishlarni** qayd etdi.  

📌 **Falco loglarida:**  
```
19:05:12 WARNING [Docker Security]: Multiple connection attempts from IP 192.168.1.50 to port 22 (SSH)
```
💡 **Bu nimani anglatadi?**  
Kimdir **SSH portini bruteforce qilishga harakat qilmoqda!**  

📌 **Suricata IDS loglarida:**  
```
ALERT: Potential Port Scanning detected from 192.168.1.50
```
💡 **Bu esa hujumchining port scanning qilayotganini anglatadi.**  

---

## **🔍 2. Hujumni chuqur tekshirish**  

### **✅ 2.1 Docker konteynerlari qanday portlarga ochiq ekanini tekshirish**  
```bash
docker ps --format "table {{.ID}}\t{{.Image}}\t{{.Ports}}"
```
👉 Natija:  
```
CONTAINER ID   IMAGE     PORTS
8f3a2d1b4c9e   nginx     0.0.0.0:80->80/tcp
9b4d2a1c5d2e   mysql     0.0.0.0:3306->3306/tcp
12d3f4a6b7c8   sshd      0.0.0.0:22->22/tcp
```
🚨 **22 (SSH) va 3306 (MySQL) portlari internetga ochiq!**  

---

### **✅ 2.2 Hujumchi qanday buyruqlar yuborayotganini tekshirish**  
Tizim loglarini **auditctl** orqali tekshiramiz:  
```bash
ausearch -m USER_AUTH
```
👉 Natija:  
```
type=USER_AUTH msg=audit(1711454501.425:302): user unknown tries to login via SSH from 192.168.1.50
```
🚨 **Hujumchi SSH parollarni bruteforce qilmoqda!**  

---

## **🛡 3. Hujumni oldini olish (Immediate Response)**  

### **✅ 3.1 Hujumchining IP-manzilini bloklash (iptables)**  
```bash
iptables -A INPUT -s 192.168.1.50 -j DROP
```
🚀 **Endi hujumchi SSH bruteforce qila olmaydi.**  

---

### **✅ 3.2 SSH portini o‘zgartirish**  
```bash
nano /etc/ssh/sshd_config
```
**O‘zgarish kiritamiz:**  
```
Port 2222
```
Keyin SSH xizmatini qayta ishga tushiramiz:  
```bash
systemctl restart ssh
```
🚀 **Hujumchi endi standart 22-port orqali kira olmaydi!**  

---

### **✅ 3.3 Fail2Ban orqali SSH bruteforce hujumlarini bloklash**  
```bash
apt install fail2ban -y
nano /etc/fail2ban/jail.local
```
Qo‘shamiz:  
```
[sshd]
enabled = true
port = 2222
maxretry = 3
bantime = 3600
```
Keyin **Fail2Ban xizmatini ishga tushiramiz:**  
```bash
systemctl restart fail2ban
```
🚀 **Endi kimdir 3 martadan ortiq noto‘g‘ri parol kiritsa, avtomatik bloklanadi!**  

---

## **🔐 4. Uzoq muddatli himoya (Best Practices)**  

### **✅ 4.1 Dockerda tarmoqdan himoyalangan rejimda ishlash (Isolated Network)**  
```bash
docker network create --driver bridge secure_network
docker run --network secure_network -d nginx
```
🚀 **Endi konteyner internetdan bevosita ko‘rinmaydi.**  

---

### **✅ 4.2 SSH uchun Public Key Authentication ni yoqish (Parol o‘rniga kalit orqali kirish)**  
```bash
nano /etc/ssh/sshd_config
```
Qo‘shamiz:  
```
PasswordAuthentication no
PubkeyAuthentication yes
```
🚀 **Endi faqat ssh kalit bilan kirish mumkin bo‘ladi!**  

---

### **✅ 4.3 Suricata orqali real-time monitoring qo‘shish**  
Suricata IDS ni Docker serveriga o‘rnatamiz:  
```bash
apt install suricata -y
```
Keyin **Suricata monitoringni yoqamiz:**  
```bash
suricata -c /etc/suricata/suricata.yaml -i eth0
```
🚀 **Endi hujumlarni oldindan sezib, ogohlantirishlar olamiz.**  

---

### **✅ 4.4 SIEM tizimiga loglarni yuborish (ELK, Splunk, Wazuh)**  
```bash
docker run --log-driver=syslog --log-opt syslog-address=udp://192.168.1.20:514 nginx
```
🚀 **Endi loglar SIEM tizimida real-time kuzatib boriladi.**  

---

## **🔴 Yakuniy Xulosa**  

| **Harakat**  | **Qanday amalga oshirildi?**  |
|--------------|------------------------------|
| SSH bruteforce aniqlash | **Falco, auditctl loglar** orqali |
| SSH hujumchini bloklash | **iptables, Fail2Ban** orqali |
| SSH portini o‘zgartirish | **22 -> 2222 portga almashtirish** |
| Docker tarmog‘ini izolyatsiya qilish | **Docker Bridge Network yaratish** |
| Real-time monitoring | **Suricata IDS, Falco, SIEM** qo‘shish |

