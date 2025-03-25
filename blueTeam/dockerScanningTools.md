# **🔥 Docker Xavfsizligi: Docker Bench, Trivy va Falco qo‘llanilishi**  

Agar Docker konteynerlaringiz **zaif bo‘lsa, hujumchilar** privilege escalation, image zaharlash, API ekspluatatsiya qilish kabi usullar orqali tizimingizga zarar yetkazishi mumkin.  

Quyida **Docker xavfsizligini ta’minlash** uchun **Docker Bench, Trivy va Falco** vositalaridan qanday foydalanishni ko‘rib chiqamiz.  

---

# **📌 1. Docker Bench for Security – Docker konfiguratsiyasini tekshirish**  

### **Docker Bench nima?**
Docker Bench for Security – bu **Docker-da xavfsizlik zaifliklarini skanerlash va CIS (Center for Internet Security) tavsiyalariga muvofiqligini tekshirish** uchun ishlatiladigan vosita.  

### **🛠 O‘rnatish va ishlatish**  

#### ✅ **1. Docker Bench ni yuklab olish**  
```bash
git clone https://github.com/docker/docker-bench-security.git
cd docker-bench-security
```

#### ✅ **2. Docker Bench skanerini ishga tushirish**  
```bash
sudo sh docker-bench-security.sh
```
**🔎 Natija:**  
Skript Docker tizimingizni tahlil qilib **zaifliklarni** aniqlaydi va **tavsiyalar** beradi.  

#### ✅ **3. Faqat muayyan bo‘limlarni tekshirish**  
Agar faqatgina muayyan bo‘limni tekshirmoqchi bo‘lsangiz, masalan **Docker-da ishlayotgan konteynerlarni tekshirish**, quyidagicha ishga tushiring:  
```bash
sudo sh docker-bench-security.sh -c container
```
**Bo‘limlar:**  
- **host_configuration** – Host konfiguratsiyasini tekshirish  
- **docker_daemon_configuration** – Docker daemon sozlamalari  
- **container_images** – Docker image xavfsizligini tekshirish  
- **container** – Ishlayotgan konteynerlarni tekshirish  

#### ✅ **4. Docker Bench natijalarini JSON formatda olish**  
```bash
sudo sh docker-bench-security.sh --json > result.json
```

---

# **📌 2. Trivy – Docker Image va Container zaifliklarini skanerlash**  

### **Trivy nima?**
Trivy – bu **Docker image va konteynerlardagi xavfsizlik zaifliklarini** aniqlash uchun ishlatiladigan vosita. **CVE (Common Vulnerabilities and Exposures)** bo‘yicha image-larni skanerlash imkoniyatiga ega.  

### **🛠 O‘rnatish va ishlatish**  

#### ✅ **1. Trivy ni o‘rnatish**  
**Ubuntu/Debian:**  
```bash
sudo apt install -y trivy
```
**MacOS:**  
```bash
brew install aquasecurity/trivy/trivy
```

#### ✅ **2. Docker Image zaifliklarini skanerlash**  
```bash
trivy image nginx:latest
```
**🔎 Natija:**  
- Agar image xavfsiz bo‘lsa – **No vulnerabilities detected** deb chiqadi.  
- Agar image-da zaiflik bo‘lsa – **CVE ID va zaiflik darajasi (HIGH, CRITICAL)** ko‘rsatiladi.  

#### ✅ **3. Ishlayotgan konteynerlarni skanerlash**  
```bash
trivy container my_container
```

#### ✅ **4. Mahalliy Docker image-larni tekshirish**  
```bash
docker images
trivy image my_custom_image
```

#### ✅ **5. Trivy natijalarini JSON formatda olish**  
```bash
trivy image --format json nginx:latest > trivy_result.json
```

---

# **📌 3. Falco – Real-Time Docker va Kubernetes xavfsizlik monitoringi**  

### **Falco nima?**
Falco – **Docker va Kubernetes konteynerlari ichida zararli harakatlarni real vaqtda kuzatish** uchun ishlatiladi. Masalan:  
✅ **Root huquqiga ega bo‘lishga urinish**  
✅ **Noqonuniy tarmoq ulanishlari**  
✅ **Muhim fayllarga ruxsatsiz kirish**  

### **🛠 O‘rnatish va ishlatish**  

#### ✅ **1. Falco ni o‘rnatish**  
```bash
curl -fsSL https://falco.org/repo/falcosecurity-packages.asc | sudo tee /usr/share/keyrings/falco-archive-keyring.asc > /dev/null
echo "deb [signed-by=/usr/share/keyrings/falco-archive-keyring.asc] https://download.falco.org/packages/deb stable main" | sudo tee /etc/apt/sources.list.d/falcosecurity.list
sudo apt update -y
sudo apt install -y falco
```

#### ✅ **2. Falco ni ishga tushirish**  
```bash
sudo systemctl start falco
sudo systemctl enable falco
```

#### ✅ **3. Falco loglarini tekshirish**  
```bash
sudo journalctl -u falco -f
```

#### ✅ **4. Faqat muayyan tahdidlarni filtrlash**  
Masalan, faqat root huquqlariga ega jarayonlarni ko‘rish:  
```bash
sudo falco -r /etc/falco/falco_rules.yaml -o json | grep root
```

#### ✅ **5. Docker konteyner ichida tahdidlarni aniqlash**  
```bash
docker run --rm -it alpine sh
```
- **Agar root huquqini olishga urinsangiz, Falco buni log qiladi!**  

#### ✅ **6. Maxsus Falco qoidalarini yaratish**  
```bash
sudo nano /etc/falco/falco_rules.local.yaml
```
Qoida: **Agar foydalanuvchi konteyner ichida `chmod 777` ishlatsa, alert berish**  
```yaml
- rule: Detect chmod 777
  desc: "Konteyner ichida chmod 777 ishlatilmoqda!"
  condition: evt.type = chmod and evt.arg.mode contains "777"
  output: "ALERT: Chmod 777 detected in container (user=%user.name command=%proc.cmdline)"
  priority: WARNING
  tags: [docker]
```

**Falco ni qayta ishga tushirish**  
```bash
sudo systemctl restart falco
```

---

# **🔥 Yakuniy Xulosa**  
**Docker xavfsizligini ta’minlash uchun quyidagi vositalardan foydalanish kerak:**  

🔎 **Docker konfiguratsiyasini tekshirish**  
✅ `Docker Bench for Security` – Docker server konfiguratsiyasini tekshirish  

🔍 **Docker image va konteynerlarni skanerlash**  
✅ `Trivy` – Docker image va konteyner zaifliklarini CVE bo‘yicha skanerlash  

🔴 **Docker konteynerlarni real vaqtda kuzatish**  
✅ `Falco` – Zararli harakatlarni aniqlash va alert berish  

🚀 **Keyingi bosqich:**  
👉 **Docker xavfsizligi bo‘yicha yana qanday mavzularni chuqurroq o‘rganmoqchisiz? SIEM bilan integratsiya? Advanced Firewall?** 😊
