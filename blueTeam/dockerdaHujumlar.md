Hujumchilar Docker tizimiga har xil usullar bilan hujum qilishi mumkin. **Men hozir real misollar bilan 5 ta keng tarqalgan Docker hujumlarini va ularning oldini olish usullarini ko‘rib chiqaman.**  

---

# **🔥 Docker’ga qarshi 5 xil xavfli hujum va ularning oldini olish usullari**  

| **Hujum turi** | **Tavsif** | **Himoyalanish usuli** |
|---------------|------------|------------------------|
| **1. Container Escape (Docker’dan chiqish)** | Hujumchi konteyner ichidan butun tizimni egallaydi | **Seccomp, AppArmor, Read-only mode** |
| **2. Privilege Escalation (Root huquqini olish)** | Hujumchi root bo‘lib, barcha fayllarga kirish imkoniyatiga ega bo‘ladi | **Root user o‘rniga oddiy user ishlatish** |
| **3. Supply Chain Attack (Zararli Docker Image)** | Hujumchi zararli Docker image yaratib, tizimga kiritadi | **Rasmiy image va image signing ishlatish** |
| **4. Network Attack (Tarmoq orqali hujum qilish)** | Hujumchi Docker tarmog‘iga kira oladi va boshqa konteynerlarga hujum qiladi | **Isolated Network, Firewall qoidalari** |
| **5. Ransomware Attack (Docker orqali tizimni shifrlash)** | Hujumchi fayllarni shifrlab, pul talab qiladi | **Read-only volumes, Backup siyosati** |

---  

## **🔥 1. Container Escape (Docker’dan chiqib butun tizimni egallash)**  

### **🛑 Hujum qanday amalga oshiriladi?**  
Hujumchi konteyner ichida ishlayotgan ekan, u:  
- `--privileged` rejimda ishlayotgan konteynerni exploit qiladi  
- `/proc` orqali **host tizimga kira oladi**  
- `cgroup` va `docker.sock` orqali butun tizimni egallaydi  

### **🔍 Hujumni aniqlash**  
```bash
docker exec -it nginx ls /root
```
👉 **Agar konteyner ichida `/root` katalogi ko‘rinib tursa**, hujumchi Docker’dan tashqariga chiqishga muvaffaq bo‘lgan.  

### **🛡 Himoyalanish usullari**  
✅ **Docker konteynerni root bo‘lmagan userda ishga tushirish**  
```bash
docker run --user 1001 -d nginx
```  
✅ **`--privileged` rejimni ishlatmaslik**  
```bash
docker run --privileged=false -d nginx
```  
✅ **Seccomp va AppArmor bilan xavfsizlikni oshirish**  
```bash
docker run --security-opt seccomp=default.json -d nginx
```
✅ **Docker tarmog‘ini izolyatsiya qilish**  
```bash
docker network create --driver bridge secure_network
docker run --network secure_network -d nginx
```

---

## **🔥 2. Privilege Escalation (Root huquqini olish)**  

### **🛑 Hujum qanday amalga oshiriladi?**  
Agar konteyner root userda ishlayotgan bo‘lsa, hujumchi:  
- `sudo su` orqali root bo‘ladi  
- Konteyner ichidan host tizimdagi fayllarni tahrirlashi mumkin  

### **🔍 Hujumni aniqlash**  
```bash
docker exec -it nginx whoami
```
👉 **Agar natija `root` bo‘lsa, konteyner xavfli bo‘lishi mumkin!**  

### **🛡 Himoyalanish usullari**  
✅ **Root user o‘rniga oddiy user ishlatish**  
```bash
docker run --user 1001 -d nginx
```  
✅ **Root huquqlarni cheklash**  
```bash
docker run --security-opt no-new-privileges:true -d nginx
```

---

## **🔥 3. Supply Chain Attack (Zararli Docker Image orqali hujum qilish)**  

### **🛑 Hujum qanday amalga oshiriladi?**  
Hujumchi:  
- **Zararli Docker image yaratadi** va uni **DockerHub** yoki **private registry** ga yuklaydi  
- Siz esa ushbu image’ni yuklab, o‘z tizimingizda ishga tushirasiz  

### **🔍 Hujumni aniqlash**  
```bash
docker images | grep "nginx"
```
👉 **Agar shubhali `nginx` image bo‘lsa, tekshirish kerak!**  

### **🛡 Himoyalanish usullari**  
✅ **Docker image’larni imzolash (`Docker Content Trust`)**  
```bash
export DOCKER_CONTENT_TRUST=1
```  
✅ **`FROM` komandasida faqat rasmiy image ishlatish**  
```dockerfile
FROM nginx:latest
```  
✅ **Docker image’larni skanerlash (`Trivy`, `Clair`)**  
```bash
trivy image nginx
```

---

## **🔥 4. Network Attack (Tarmoq orqali hujum qilish)**  

### **🛑 Hujum qanday amalga oshiriladi?**  
- Hujumchi Docker tarmog‘iga ulanib, **boshqa konteynerlarga hujum qiladi**  
- `MITM Attack` yoki `Packet Sniffing` ishlatishi mumkin  

### **🔍 Hujumni aniqlash**  
```bash
docker network inspect bridge
```
👉 **Agar ko‘p sonli noma’lum IP-lar bo‘lsa, tarmoq xavf ostida!**  

### **🛡 Himoyalanish usullari**  
✅ **Docker tarmog‘ini izolyatsiya qilish**  
```bash
docker network create --driver bridge secure_network
docker run --network secure_network -d nginx
```
✅ **Firewall qoidalari o‘rnatish (`iptables`)**  
```bash
iptables -A INPUT -p tcp --dport 3306 -s 192.168.1.0/24 -j ACCEPT
iptables -A INPUT -p tcp --dport 3306 -j DROP
```
✅ **Suricata yoki Snort bilan monitoring qo‘shish**  
```bash
suricata -c /etc/suricata/suricata.yaml -i docker0
```

---

## **🔥 5. Ransomware Attack (Docker orqali tizimni shifrlash)**  

### **🛑 Hujum qanday amalga oshiriladi?**  
- Hujumchi Docker konteyner ichiga kirib, fayllarni shifrlaydi  
- `rm -rf /` yoki `chattr +i` kabi buyruqlar bilan fayllarni o‘chiradi  

### **🔍 Hujumni aniqlash**  
```bash
ls -l /var/lib/docker/volumes/
```
👉 **Agar fayllar shifrlangan bo‘lsa, ransomware bo‘lishi mumkin!**  

### **🛡 Himoyalanish usullari**  
✅ **Read-only rejimni yoqish**  
```bash
docker run --read-only -d nginx
```
✅ **Muhim ma’lumotlarni backup qilish**  
```bash
rsync -av --delete /var/lib/docker/volumes/ backup-server:/backups/
```
✅ **Docker konteynerlarga faqat kerakli huquqlarni berish (`seccomp`)**  
```bash
docker run --security-opt seccomp=default.json -d nginx
```

---

## **🔥 Yakuniy Xulosa**  
✅ **Docker’ni xavfsiz ishlatish uchun:**  
- **Root user’dan foydalanmang**  
- **Zararli Docker image yuklamang**  
- **Docker tarmog‘ini izolyatsiya qiling**  
- **Docker loglarini SIEM orqali nazorat qiling**  

🚀 **Endi siz Docker tizimini Blue Team sifatida himoya qilishni chuqurroq tushundingiz!**  

📌 **Keyingi qadam:**  
**Docker-da real-time monitoring va avtomatik hujum oldini olishni o‘rganmoqchimisiz?** 😊
