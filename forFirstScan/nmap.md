✅  **Nmap yordamida ko‘plab portlarni skanerlash** va **firewall (WAF yoki IDS) bor holatlarda stealth scan** cheat-sheet:

---

## 🟢 **1️⃣ Juda ko‘p portlarni skanerlash (Top 10000, All ports)**

### 🔵 **Top 10000 port scan:**
nmap -p- --top-ports 10000 <target>

### 🔵 **Barcha 65535 portlarni skanerlash:**

nmap -p- <target>

Yoki:

nmap -p1-65535 <target>


## 🟢 **2️⃣ Service va version detection bilan keng qamrovli skan**


nmap -p- -sV -sC <target>

- **-p-** : barcha portlar.
- **-sV** : service version aniqlash.
- **-sC** : default scriptlar (default NSE script pack).


## 🟢 **3️⃣ UDP + TCP parallel scan**

nmap -sS -sU -p U:1-1000,T:1-65535 <target>

- **-sS** : TCP SYN Scan.
- **-sU** : UDP Scan.
- **U:1-1000** : UDP ning 1000 porti.
- **T:1-65535** : TCP ning to‘liq portlarini tekshiradi.

## 🔴 **Firewall, IDS yoki WAF mavjud bo‘lsa (Stealth bypass uchun)**

### 🔵 **4️⃣ Slow scan (IDS trigger qilmaslik uchun)**


nmap -p- -T1 <target>

- **-T1** : paranoid/super slow scan (kam shubhali).

### 🔵 **5️⃣ Fragmentation (Firewall/IPS bypass)**


nmap -p- -f <target>

- **-f** : paketlarni fragment qilib yuboradi.

### 🔵 **6️⃣ Source port spoofing (Firewall bypass)**


nmap -p- --source-port 53 <target>

- DNS trafikga o‘xshatib 53-port orqali so‘rov yuboradi.

### 🔵 **7️⃣ Decoy (anti-IDS/WAF)**

nmap -p- -D RND:10 <target>

- **-D** : decoy IP lar qo‘shib IDS ni chalg‘itadi.

### 🔵 **8️⃣ TTL manipulation**


nmap -p- --ttl 5 <target>

- Paketning TTL qiymatini kamaytirib, IDSlarni ataylab chalg‘itish.

### 🔵 **9️⃣ Null, Xmas, FIN Scan (Stealth Scan)**


nmap -p- -sN <target>   # Null Scan
nmap -p- -sX <target>   # Xmas Scan
nmap -p- -sF <target>   # FIN Scan

> 🔔 Firewall va IDS’lar ushbu low-level skanlarni ko‘p hollarda aniqlamasligi mumkin.

## 🧠 **Qo‘shimcha kombinatsiyalar**

### **Firewall + IDS bypass uchun qulay kombinatsiya:**


nmap -p- -sS -T2 -f --source-port 443 -D RND:5 <target>

### **UDP + Stealth TCP mix:**


nmap -sS -sU -T2 --top-ports 1000 --data-length 50 <target>


🔥 **PRO TIP**:
- WAF yoki IDS bor joylarda **-T1 yoki -T2** profiling bilan birga ishlating.
- **nmap -v** yoki **-vv** rejimida verbose holatda ma’lumotlarni real vaqt tahlil qilish qulay.
- **Firewall’lar** odatda UDP’ni ko‘proq bloklaydi, lekin TCP SYN va **-f fragmentation** orqali ba’zan teshik topiladi.




**🧨 2️⃣ hping3 + firewalk Cheat-Sheet (Firewall fingerprinting)**
**🔵 hping3 firewall bypass va mapping**

hping3 -S -p 80 --flood <target>
hping3 -S -p 443 --data 50 <target>

**🔵 ICMP Firewall Detection**
hping3 -1 -c 10 -d 120 -S <target>

**🔵 Source port spoof + fragment**
hping3 -S -p 80 --frag --spoof 1.2.3.4 <target>

**🔵 firewalk (firewall routing analysis)**
firewalk -S 1-65535 -i eth0 -n -r 10 -p TCP <target> <gateway>
firewalk sizga firewall qanday portlarga ruxsat berayotganini ko‘rsatib beradi.



**🔥 PRO TIP:**

hping3 firewall’ni fragmentlash orqali ko‘p teshik topish imkonini beradi.

firewalk esa ACL’larni aniqlashda va yo‘nalishlarni tahlil qilishda foydali.



nmap -sCV -A -p- -T5 -Pn -O -v 10.10.196.90  
