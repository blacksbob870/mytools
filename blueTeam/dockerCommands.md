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

