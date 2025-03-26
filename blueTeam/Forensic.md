# **🛠 Volatility Tool: Memory Forensics uchun kuchli vosita**  

**Volatility** — bu **RAM xotirani forensik tahlil qilish uchun** ishlatiladigan ochiq kodli vosita. U **hujumlarni tahlil qilish, zararli dasturlarni (malware) aniqlash, shubhali jarayonlarni tekshirish va xotira nusxalaridan ma'lumot olish** uchun ishlatiladi.  

> 📌 **Asosiy qo‘llanilishi:** Digital Forensics, Incident Response, Malware Analysis  

---

## **📌 Volatility qanday ishlaydi?**
1️⃣ **Xotira nusxasini olish (Memory Dump yaratish)**  
2️⃣ **Shubhali jarayonlar va ularga bog‘liq obyektlarni tekshirish**  
3️⃣ **Xotirada saqlangan maxfiy ma'lumotlar yoki zararli kodlarni tahlil qilish**  
4️⃣ **Rootkitlar, keyloggerlar yoki boshqa zararli dasturlar izlarini topish**  
5️⃣ **O‘chirilgan fayllar yoki tarmoq ulanishlarini tiklash**  

---

## **📥 Volatility’ni yuklab olish**  
🔹 **Rasmiy veb-sayt**: [🔗 Volatility Foundation](https://www.volatilityfoundation.org/)  
🔹 **GitHub repositoriyasi**: [🔗 Volatility GitHub](https://github.com/volatilityfoundation/volatility)  

📌 **Windows, Linux va macOS uchun qo‘llab-quvvatlanadi.**  

**Yuklab olish va o‘rnatish:**  
```bash
git clone https://github.com/volatilityfoundation/volatility.git
cd volatility
python setup.py install
```
👉 **Python 2.7 yoki 3.x kerak bo‘lishi mumkin.**  

---

## **🛠 Volatility orqali asosiy tahlillar**  

### **1️⃣ Xotira nusxasi haqida umumiy ma'lumot olish**  
```bash
volatility -f memory.dmp imageinfo
```
📌 **Tizim versiyasi va yadro (kernel) versiyasini aniqlash**  

---

### **2️⃣ Tizimda ishlayotgan jarayonlarni ko‘rish**  
```bash
volatility -f memory.dmp pslist
```
📌 **Tizimda ishlayotgan barcha jarayonlar ro‘yxatini chiqaradi.**  

```bash
volatility -f memory.dmp pstree
```
📌 **Jarayonlar iyerarxik tuzilishini chiqaradi (parent-child relationships).**  

---

### **3️⃣ Shubhali yoki yashirin jarayonlarni topish**  
```bash
volatility -f memory.dmp psscan
```
📌 **O‘chirilgan yoki yashirin jarayonlarni (stealth processes) topish.**  

```bash
volatility -f memory.dmp dlllist -p 1234
```
📌 **Jarayonlarga yuklangan DLL-fayllarni tekshirish (PID 1234 jarayoni uchun).**  

---

### **4️⃣ Kompyuter tarmoq ulanishlarini tekshirish**  
```bash
volatility -f memory.dmp netscan
```
📌 **Tarmoq orqali bajarilgan ulanishlarni ko‘rish (TCP/UDP portlar).**  

---

### **5️⃣ Xotiradan yozishmalarning nusxasini olish**  
```bash
volatility -f memory.dmp mimikatz
```
📌 **Mimikatz orqali xotiradan foydalanuvchi parollarini olish.**  

```bash
volatility -f memory.dmp hashdump
```
📌 **Xotiradan Windows foydalanuvchilari parol hashlarini chiqarish.**  

---

### **6️⃣ Xotiradagi ochilgan fayllarni tahlil qilish**  
```bash
volatility -f memory.dmp filescan
```
📌 **Xotiradagi ochilgan va ishlatilayotgan fayllarni tekshirish.**  

```bash
volatility -f memory.dmp dumpfiles -Q 0x12345678 -D ./output/
```
📌 **Ma’lum bir faylni xotiradan tiklash.**  

---

### **7️⃣ O‘chirilgan yoki yashirin registry kalitlarini topish**  
```bash
volatility -f memory.dmp hivelist
```
📌 **Xotirada saqlangan Windows registry fayllarining ro‘yxatini chiqarish.**  

```bash
volatility -f memory.dmp printkey -K "Software\Microsoft\Windows\CurrentVersion\Run"
```
📌 **Tizim yuklanishi bilan ishga tushadigan dasturlarni ko‘rish.**  

---

### **🔍 Volatility qaysi hollarda kerak?**  
✅ **Malware Analysis** – Xotirada zararli dasturlar izlarini topish  
✅ **Incident Response** – Kompyuterga buzib kirish bo‘yicha tahlil qilish  
✅ **Memory Forensics** – Xotirada saqlangan shubhali jarayonlarni o‘rganish  
✅ **Data Recovery** – O‘chirilgan ma'lumotlarni tiklash  

---

### **📌 Xulosa**  
✔ **Volatility xotira forensikasi uchun eng kuchli vositalardan biri**  
✔ **Jarayonlar, tarmoq ulanishlari, parollar va zararli kodlarni tahlil qilish imkonini beradi**  
✔ **Windows, Linux va macOS tizimlari bilan ishlaydi**  
✔ **Malware va hujum tahlil qilish uchun juda foydali**  

Agar **Volatility yordamida aniqroq tahlillar yoki amaliy misollar kerak bo‘lsa**, bemalol so‘rashingiz mumkin! 🚀
