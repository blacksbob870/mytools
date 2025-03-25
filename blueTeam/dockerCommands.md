Albatta! Quyida **Docker uchun eng muhim buyruqlar (commandlar)** toifalarga bo‘lingan holda keltirilgan. Bu buyruqlar yordamida **Docker imijlar (images), konteynerlar (containers), tarmoqlar (networks), hajmlar (volumes)** va boshqa muhim jarayonlarni boshqarishingiz mumkin.  

---

# **🔥 Docker Asosiy Buyruqlari (Commands)**  

## **📌 1. Docker versiya va ma’lumotlarini tekshirish**  
```bash
docker --version       # Docker versiyasini ko‘rish
docker info            # Docker tizimi haqida umumiy ma’lumot
docker system df       # Docker hajmini tekshirish
```

---

## **📌 2. Docker Image-lar bilan ishlash**  

**🔍 Imijlar ro‘yxatini ko‘rish**  
```bash
docker images          # Mahalliy saqlangan imijlar ro‘yxati
docker image ls        # Imijlar ro‘yxatini ko‘rsatish (alternativ)
```

**📥 Docker Hub’dan yangi imij yuklab olish**  
```bash
docker pull nginx          # Nginx imijini yuklab olish
docker pull ubuntu:20.04   # Muayyan versiyadagi imijni yuklab olish
```

**🗑 Docker imijni o‘chirish**  
```bash
docker rmi nginx           # Nginx imijini o‘chirish
docker image rm ubuntu     # Ubuntu imijini o‘chirish
```

**🛠 Yangi Docker imij yaratish**  
```bash
docker build -t myapp .    # Joriy katalogdan Docker imij yaratish
```

---

## **📌 3. Docker konteynerlar bilan ishlash**  

**🚀 Yangi konteyner yaratish va ishga tushirish**  
```bash
docker run -d --name mynginx -p 8080:80 nginx  
```
✏️ **Tushuntirish**:  
- `-d` – Background (fon rejimida) ishlaydi  
- `--name mynginx` – Konteyner nomi  
- `-p 8080:80` – Tashqi port 8080, ichki port 80  

**📜 Ishlayotgan konteynerlarni ko‘rish**  
```bash
docker ps                 # Ishlayotgan konteynerlar ro‘yxati
docker ps -a              # Hamma konteynerlar ro‘yxati (o‘chganlar ham)
```

**⏸ Konteynerni to‘xtatish/yurgizish/qayta ishga tushirish**  
```bash
docker stop mynginx       # Konteynerni to‘xtatish
docker start mynginx      # Konteynerni qayta ishga tushirish
docker restart mynginx    # Konteynerni restart qilish
```

**❌ Konteynerni o‘chirish**  
```bash
docker rm mynginx         # Konteynerni o‘chirish
docker rm -f mynginx      # Majburan o‘chirish
docker rm $(docker ps -aq)  # Hamma konteynerlarni o‘chirish
```

**🔍 Konteyner ichiga kirish**  
```bash
docker exec -it mynginx bash   # Konteyner ichiga kirish
docker attach mynginx          # Konteyner ichiga ulanib, loglarni ko‘rish
```

---

## **📌 4. Docker log va monitoring qilish**  

**📜 Konteyner loglarini ko‘rish**  
```bash
docker logs mynginx      # Konteyner loglarini ko‘rish
docker logs -f mynginx   # Real vaqt rejimida loglarni kuzatish
```

**📊 Konteyner resurslaridan foydalanishni ko‘rish**  
```bash
docker stats            # Ishlayotgan konteynerlarning RAM, CPU, I/O ma’lumotlari
docker top mynginx      # Konteyner ichida qaysi jarayonlar ishlayotganini ko‘rish
```

---

## **📌 5. Docker Network (tarmoq) buyruqlari**  

**📜 Docker tarmoqlarini ko‘rish**  
```bash
docker network ls      # Hamma tarmoqlar ro‘yxati
```

**🛠 Yangi tarmoq yaratish**  
```bash
docker network create mynetwork  
```

**🔗 Konteynerni mavjud tarmoqqa ulash**  
```bash
docker network connect mynetwork mynginx  
```

**❌ Tarmoqni o‘chirish**  
```bash
docker network rm mynetwork  
```

---

## **📌 6. Docker Volume (hajm) buyruqlari**  

**📜 Mavjud volume’larni ko‘rish**  
```bash
docker volume ls  
```

**🛠 Yangi volume yaratish**  
```bash
docker volume create myvolume  
```

**🔗 Konteynerga volume ulash**  
```bash
docker run -d --name myapp -v myvolume:/app nginx  
```

**❌ Volume’ni o‘chirish**  
```bash
docker volume rm myvolume  
```

---

## **📌 7. Docker Compose buyruqlari**  

**📜 Docker Compose yordamida konteynerlarni ishga tushirish**  
```bash
docker-compose up -d       # Compose fayldan barcha konteynerlarni ishga tushirish
```

**❌ Barcha konteynerlarni to‘xtatish**  
```bash
docker-compose down        # Barcha konteynerlarni o‘chirish
```

**📜 Docker Compose loglarini ko‘rish**  
```bash
docker-compose logs -f  
```

---

## **📌 8. Docker System Cleanup (tozalash) buyruqlari**  

**🗑 Keraksiz konteynerlarni, image va tarmoqni o‘chirish**  
```bash
docker system prune  
docker system prune -a  
```

**🗑 Keraksiz imijlarni o‘chirish**  
```bash
docker image prune  
```

**🗑 Keraksiz konteynerlarni o‘chirish**  
```bash
docker container prune  
```

**🗑 Keraksiz volume’larni o‘chirish**  
```bash
docker volume prune  
```





# **🔥 Docker orqali zararli hujumlar va IP-lardan himoyalanish buyruqlari**  

Agar Docker konteynerlarining xavfsizligini ta’minlamasangiz, hujumchilar **Docker API zaifligi, privilege escalation, network hujumlari** orqali tizimingizga zarar yetkazishi mumkin. Quyida **Docker xavfsizligini mustahkamlash va zararli hujumlardan himoyalanish** uchun eng muhim buyruqlarni ko‘rib chiqamiz.  

---

## **📌 1. Docker API hujumlaridan himoyalanish**  

**📜 Ochiq API portlarini tekshirish**  
```bash
netstat -tulnp | grep docker
ss -tulnp | grep 2375
```
**❌ Agar natija chiqsa, demak Docker API ochiq!**  

**🛡 Docker API-ni yopish (2375 va 2376 portlarini bloklash)**  
```bash
iptables -A INPUT -p tcp --dport 2375 -j DROP
iptables -A INPUT -p tcp --dport 2376 -j DROP
```
👉 **Barcha API so‘rovlarini bloklash uchun Docker daemon konfiguratsiyasini o‘zgartiring:**  
```bash
sudo nano /etc/docker/daemon.json
```
```json
{
  "hosts": ["unix:///var/run/docker.sock"]
}
```
**🔄 O‘zgarishlarni qo‘llash uchun Docker-ni qayta ishga tushirish:**  
```bash
sudo systemctl restart docker
```

---

## **📌 2. Noqonuniy IP-larni bloklash**  

**📜 Docker konteyneringizga kimlar ulanayotganini tekshirish**  
```bash
docker logs mycontainer | grep "Accepted connection"
```

**🛡 Muayyan zararli IP-ni bloklash (masalan, 192.168.1.100)**  
```bash
iptables -A INPUT -s 192.168.1.100 -j DROP
```

**🛡 Bir nechta IP-larni bloklash**  
```bash
iptables -A INPUT -s 192.168.1.101 -j DROP
iptables -A INPUT -s 203.0.113.50 -j DROP
```

**📜 Docker konteynerga ulanishlarni kuzatish va avtomatik bloklash uchun Fail2Ban sozlash**  
1️⃣ **Fail2Ban o‘rnatish**  
```bash
sudo apt install fail2ban -y
```
2️⃣ **Docker loglarini kuzatish uchun yangi qoidalarni qo‘shish**  
```bash
sudo nano /etc/fail2ban/jail.local
```
```ini
[docker]
enabled = true
filter = docker
logpath = /var/log/syslog
maxretry = 3
bantime = 3600
```
3️⃣ **Fail2Ban xizmatini ishga tushirish**  
```bash
sudo systemctl restart fail2ban
fail2ban-client status docker
```

---

## **📌 3. Docker konteynerlarini privilege escalation hujumlaridan himoyalash**  

**🚀 🛡 Root huquqlariga ega konteynerlarni bloklash**  
```bash
docker run --user 1001 -d nginx
```

**🛡 Konteynerda yangi privilege olishni bloklash**  
```bash
docker run --security-opt no-new-privileges:true -d nginx
```

**🛡 Konteyner ichidan root huquqini olish imkoniyatini yo‘q qilish**  
```bash
docker run --security-opt seccomp=default.json -d nginx
```

---

## **📌 4. Docker Tarmoq hujumlaridan himoyalanish**  

**📜 Ochiq tarmoq portlarini tekshirish**  
```bash
docker network ls
```
```bash
docker network inspect bridge
```

**🛡 Konteynerlarni faqat o‘z tarmog‘iga ulash (bridge network emas)**  
```bash
docker network create --driver overlay secure_network
docker run --network secure_network -d nginx
```

**🛡 Docker konteyner ichidagi zararli trafikni bloklash**  
```bash
iptables -A FORWARD -s 192.168.1.200 -j DROP
```

**🛡 Docker konteynerga faqat ma’lum tarmoqdan kirishni ruxsat berish**  
```bash
iptables -A INPUT -p tcp --dport 8080 -s 192.168.1.0/24 -j ACCEPT
iptables -A INPUT -p tcp --dport 8080 -j DROP
```

---

## **📌 5. Docker konteynerlarni SELinux yoki AppArmor bilan himoyalash**  

**📜 Docker konteynerda SELinux rejimini yoqish**  
```bash
docker run --security-opt label=type:container_t -d nginx
```

**📜 AppArmor profilini qo‘shish**  
```bash
docker run --security-opt apparmor=docker-default -d nginx
```

**📜 Hamma konteynerlar uchun AppArmor qo‘llash**  
```bash
sudo nano /etc/docker/daemon.json
```
```json
{
  "apparmor": "docker-default"
}
```
```bash
sudo systemctl restart docker
```

---

## **📌 6. Docker konteynerda zaifliklarni skanerlash va audit qilish**  

**📜 Docker Bench for Security bilan audit qilish**  
```bash
git clone https://github.com/docker/docker-bench-security.git
cd docker-bench-security
sudo sh docker-bench-security.sh
```

**📜 Trivy bilan Docker image-larni skanerlash**  
```bash
sudo apt install -y trivy
trivy image nginx:latest
```

**📜 Lynis bilan Docker host tizimini tekshirish**  
```bash
sudo apt install -y lynis
sudo lynis audit system
```

---

## **🔥 Yakuniy xulosa**  

🚀 **Docker xavfsizligini ta’minlash uchun eng muhim chora-tadbirlar**  

✅ **Docker API hujumlaridan himoyalanish**  
- Docker API portlarini **bloklash**  
- Docker API’ni **faqat lokal foydalanishga ruxsat berish**  

✅ **IP va zararli trafikdan himoyalanish**  
- Keraksiz IP-larni **bloklash**  
- **Fail2Ban** yordamida avtomatik bloklash  

✅ **Privilege escalation hujumlarini oldini olish**  
- Root huquqlarini cheklash  
- Konteynerlarni **AppArmor yoki SELinux** bilan himoyalash  

✅ **Tarmoq hujumlaridan himoyalanish**  
- Docker konteynerlarini **faqat maxsus tarmoqda ishlatish**  
- **Iptables qoidalarini sozlash**  

✅ **Docker zaifliklarini oldindan aniqlash**  
- **Docker Bench for Security** bilan audit qilish  
- **Trivy** yordamida Docker image-larni skanerlash  

🚀 **Keyingi bosqich:**  
👉 **Docker Xavfsizligi uchun SIEM, EDR, IDS/IPS tizimlarini qo‘llashni o‘rganmoqchimisiz?** 😊
