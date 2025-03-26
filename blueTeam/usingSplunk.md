Blue Team bo‘yicha musobaqalarda **Splunk** muhim vositalardan biri hisoblanadi. Quyida **Splunk Search Processing Language (SPL)** dan foydalanib, turli **xavfsizlik tahlillari va tahdidlarga qarshi qidiruv buyruqlari** bilan tanishasiz.  

---

## **📌 1. SSH Brute-Force Hujumlarini Aniqlash**  
🔹 **Ko‘p noto‘g‘ri parol urinishlarini topish:**  
```spl
index=* sourcetype=linux_secure "Failed password" | stats count by src_ip | where count > 5
```
📌 **5 martadan ko‘p xato login urinishlari bo‘lgan IP-larni topadi.**  

🔹 **Muayyan foydalanuvchiga nisbatan brute-force hujumini topish:**  
```spl
index=* sourcetype=linux_secure "Failed password for root" | stats count by src_ip | where count > 3
```
📌 **Root foydalanuvchisiga nisbatan 3 martadan ortiq noto‘g‘ri urinishlar bo‘lsa, ularni topadi.**  

🔹 **Ushbu hujumlarni amalga oshirgan IP-larni bloklash uchun Linux'da avtomatlashtirish:**  
```bash
for ip in $(splunk search 'index=* sourcetype=linux_secure "Failed password" | stats count by src_ip | where count > 5' -auth admin:password -output raw); do sudo iptables -A INPUT -s $ip -j DROP; done
```
📌 **Bu buyruq orqali Splunk qidiruv natijasidan foydalangan holda, tajovuzkor IP-larni avtomatik bloklash mumkin.**  

---

## **🔎 2. Port Skanerlash Hujumlarini Aniqlash**  
🔹 **Bitta IP-manzildan turli portlarga ko‘p bog‘lanishlarni topish:**  
```spl
index=firewall | stats dc(dest_port) as unique_ports by src_ip | where unique_ports > 10
```
📌 **10 dan ortiq turli portlarga bog‘langan IP-larni topadi (Port Scanning hujumlari).**  

🔹 **Nmap yoki shunga o‘xshash skanerlash hujumlarini aniqlash:**  
```spl
index=firewall (useragent="*nmap*" OR useragent="*masscan*") | stats count by src_ip
```
📌 **Nmap yoki Masscan skanerlari orqali hujumlarni topadi.**  

---

## **💀 3. DoS va DDoS Hujumlarini Aniqlash**  
🔹 **Bitta IP-dan 1 soniyada juda ko‘p so‘rovlar bo‘lishi:**  
```spl
index=firewall | stats count by src_ip, _time | where count > 100
```
📌 **Agar bitta IP bir soniyada 100 dan ortiq so‘rov yuborsa, uni DoS/DDoS tahdidi deb hisoblash mumkin.**  

🔹 **Eng ko‘p bog‘langan IP-larni topish:**  
```spl
index=firewall | stats count by src_ip | sort -count
```
📌 **DDoS hujumini amalga oshirayotgan eng faol IP-manzillarni aniqlaydi.**  

---

## **🛑 4. Bloklangan IP-larni Kuzatish**  
🔹 **Firewall tomonidan bloklangan IP-lar ro‘yxati:**  
```spl
index=firewall action=blocked | stats count by src_ip
```
📌 **Firewall tomonidan bloklangan IP-larni sanaydi.**  

🔹 **Eng ko‘p bloklangan IP-larni topish:**  
```spl
index=firewall action=blocked | top src_ip
```
📌 **Eng ko‘p blokka tushgan IP-larni saralab chiqaradi.**  

---

## **🔍 5. Xavfli Foydalanuvchi Faoliyatini Kuzatish**  
🔹 **Administrator foydalanuvchisi bilan tizimga kirganlar:**  
```spl
index=windows EventCode=4624 Account_Name="Administrator"
```
📌 **Administrator foydalanuvchisi bilan tizimga kirishlarni topadi.**  

🔹 **Shubhali vaqt oralig‘ida tizimga kirgan foydalanuvchilar:**  
```spl
index=windows EventCode=4624 earliest=-1d latest=now | stats count by Account_Name, _time
```
📌 **Oxirgi 24 soatda tizimga kirgan administratorlarni tekshiradi.**  

---

## **📧 6. Phishing Xabarlarini Tahlil Qilish**  
🔹 **Urgent (shoshilinch) so‘zini o‘z ichiga olgan phishing xabarlar:**  
```spl
index=email "Subject=*urgent*" OR "From=*unknown.com*" | stats count by from
```
📌 **Noma’lum domenlardan kelgan shubhali elektron xabarlarni topadi.**  

🔹 **Zararli ilovalar bilan kelgan elektron pochta xabarlarini qidirish:**  
```spl
index=email attachment="*.exe" OR attachment="*.vbs" OR attachment="*.js"
```
📌 **Zararli dasturlarni yuklab olishga undovchi phishing xabarlarni topadi.**  

---

## **🔦 7. Web Server Loglarini Tahlil Qilish**  
🔹 **500 xato qaytargan sahifalarni aniqlash:**  
```spl
index=web sourcetype=access_combined status=500 | stats count by uri_path
```
📌 **Serverdagi ichki xatolarni ko‘rsatadi.**  

🔹 **Shubhali User-Agent orqali kirganlar:**  
```spl
index=web sourcetype=access_combined useragent="*curl*" OR useragent="*python*"
```
📌 **Botlar yoki avtomatlashtirilgan skriptlar orqali kelgan so‘rovlarni topadi.**  

---

## **🕵️ 8. Foydalanuvchi Faoliyatini Kuzatish**  
🔹 **Oxirgi 24 soatda eng ko‘p login qilgan foydalanuvchilar:**  
```spl
index=* earliest=-24h latest=now | stats count by user | sort -count
```
📌 **Eng ko‘p tizimga kirgan foydalanuvchilarni topadi.**  

🔹 **Barcha administrator harakatlarini ko‘rish:**  
```spl
index=* sourcetype=security | search user="admin"
```
📌 **Administrator bilan bog‘liq barcha harakatlarni topadi.**  

---

## **🚨 9. Splunk-da Real-Time Monitoring uchun So‘rovlar**  
🔹 **Hozirgi vaqtda kiritilgan loglarni kuzatish:**  
```spl
index=* | head 10
```
📌 **So‘nggi 10 ta logni qaytaradi.**  

🔹 **Oxirgi 5 daqiqada kelgan so‘rovlarni ko‘rish:**  
```spl
index=* earliest=-5m latest=now | stats count by src_ip
```
📌 **So‘nggi 5 daqiqada tizimga bog‘langan IP-manzillarni tekshiradi.**  

---

## **✅ Xulosa**
| **SPL Buyruq** | **Vazifasi** |
|----------------|-------------|
| SSH Brute-force hujumlarini aniqlash | Ko‘p xato login urinishlarini tekshiradi |
| Port scanning hujumlarini aniqlash | Ko‘p portlarga bog‘langan IP-larni topadi |
| DoS/DDoS hujumlarini aniqlash | Juda ko‘p so‘rov yuborayotgan IP-larni topadi |
| Phishing xabarlarni tahlil qilish | Shubhali elektron pochta xabarlarini topadi |
| Web server loglarini tekshirish | 500 xato va botlarni aniqlaydi |
| Real-time monitoring | Hozirgi vaqtdagi loglarni ko‘rsatadi |

🚀 **Splunk orqali yana qanday qidiruvlar yoki avtomatlashtirilgan xavfsizlik tahlillari kerak?** 😊




Splunk orqali **ko‘proq avtomatlashtirilgan xavfsizlik tahlillari** qilish uchun **real-time monitoring, anomal faoliyatlarni aniqlash, zararli dasturlarni topish va hujumlarni oldindan bashorat qilish** bo‘yicha qidiruvlarni kengaytirish mumkin. Quyida **ilg‘or Splunk qidiruv so‘rovlari** berilgan.  

---

## **🚨 1. Anomal Faoliyatlarni Aniqlash (UEBA – User and Entity Behavior Analytics)**  
🔹 **Bitta foydalanuvchi odatdagi vaqtdan tashqari tizimga kirsa (non-business hours login)**  
```spl
index=windows EventCode=4624 | eval hour=strftime(_time, "%H") | search hour<6 OR hour>22 | stats count by user, _time
```
📌 **Tungi vaqtda tizimga kirgan administrator yoki foydalanuvchilarni aniqlaydi.**  

🔹 **Bitta foydalanuvchi odatdagidan juda ko‘p marta login qilsa**  
```spl
index=windows EventCode=4624 | stats count by user | where count > 10
```
📌 **Kun davomida 10 martadan ko‘p login qilgan foydalanuvchilarni topadi.**  

---

## **🦠 2. Zararli Dasturlar va Ransomware Aniqlash**  
🔹 **Windows Task Scheduler orqali shubhali jarayonlar ishga tushirilsa**  
```spl
index=windows EventCode=4688 | search New_Process_Name="*schtasks.exe*"
```
📌 **Windows’ga zararli dasturlar avtomatik ishga tushirish kodlarini joylashtirishni aniqlaydi.**  

🔹 **Ransomware o‘zgarishlarini aniqlash (odatdagi fayl nomlariga o‘xshamagan fayllar yaratish)**  
```spl
index=filesystem | search (file_name="*.lock" OR file_name="*.crypted") | stats count by user, file_name
```
📌 **`*.lock`, `*.crypted` kabi kengaytmalarga ega bo‘lgan fayllarni aniqlaydi.**  

---

## **🔑 3. PowerShell Xavfli Buyruqlarini Aniqlash**  
🔹 **Windows PowerShell orqali kod ijro etilganligini tekshirish:**  
```spl
index=windows EventCode=4104 | search ScriptBlockText="*Invoke-Expression*"
```
📌 **PowerShell orqali `Invoke-Expression` kabi zararli kod ishlatilishini tekshiradi.**  

🔹 **Windows-da yashirin PowerShell sessiyalarini tekshirish:**  
```spl
index=windows EventCode=4103 | search HostApplication="*powershell* -w hidden*"
```
📌 **Ko‘rinmaydigan PowerShell jarayonlarini topadi.**  

---

## **📧 4. Shubhali Email Xabarlarini Tekshirish (Phishing)**  
🔹 **Elektron pochta orqali kelgan zararli ilovalarni aniqlash:**  
```spl
index=email attachment="*.exe" OR attachment="*.vbs" OR attachment="*.js" | stats count by sender, attachment
```
📌 **Shubhali ilovalar bilan kelgan elektron pochta xabarlarini topadi.**  

🔹 **URL-larni tahlil qilish va phishing saytlarni topish:**  
```spl
index=email "http*" | search (url="*.xyz" OR url="*.ru" OR url="*.cn") | stats count by sender, url
```
📌 **Noma’lum yoki shubhali domenlarga bog‘langan elektron pochta xabarlarini aniqlaydi.**  

---

## **🕵️ 5. Insider Threat – Xodimlarning Xavfli Harakatlarini Aniqlash**  
🔹 **Fayl serverdan juda ko‘p fayl yuklab olishlar (Data Exfiltration):**  
```spl
index=filesystem action=download | stats sum(bytes) as total_downloaded by user | where total_downloaded > 500000000
```
📌 **500 MB dan ortiq fayl yuklab olgan xodimlarni tekshiradi.**  

🔹 **USB orqali fayllar o‘tkazilganligini aniqlash:**  
```spl
index=windows EventCode=4663 | search Object_Type="Removable Media"
```
📌 **USB yoki tashqi disk orqali fayllar nusxalanishini tekshiradi.**  

---

## **🔥 6. Zero-Day Hujumlarni Aniqlash (MITRE ATT&CK Modeli Bo‘yicha)**  
🔹 **Windows-da LSASS (Local Security Authority Subsystem) hujumlarini aniqlash:**  
```spl
index=windows EventCode=4688 | search New_Process_Name="*mimikatz.exe*" OR New_Process_Name="*procdump.exe*"
```
📌 **Mimikatz yoki boshqa credential dumping vositalari ishlatilganligini tekshiradi.**  

🔹 **Tizimda yangi administrator akkauntlari yaratilganligini tekshirish:**  
```spl
index=windows EventCode=4720 | stats count by user, _time
```
📌 **Administrator huquqlari bilan yangi foydalanuvchi yaratilganligini aniqlaydi.**  

---

## **📡 7. Tarmoqda Shubhali Harakatlarni Kuzatish**  
🔹 **DNS Tunneling yoki ma’lumot chiqarish hujumlarini aniqlash:**  

index=dns | stats count by query | where count > 1000

📌 **1 kunda 1000 dan ortiq DNS so‘rov yuborayotgan IP-larni topadi.**  

🔹 **Dark Web yoki shubhali saytlar bilan bog‘langan IP-larni topish:**  

index=network dest_ip="*.onion" OR dest_ip="*.tor" | stats count by src_ip

📌 **Dark Web yoki TOR tarmoqlariga ulanayotgan kompyuterlarni aniqlaydi.**  



## **📍 8. Eng Ko‘p Qidirilgan Real-Time Monitoring Buyruqlari**  
🔹 **Tizimda administrator huquqlari bilan kirishlar:**  

index=* EventCode=4624 user="admin" OR user="Administrator" | stats count by user, src_ip

📌 **Administrator huquqlari bilan tizimga kirgan foydalanuvchilarni topadi.**  

🔹 **So‘nggi 5 daqiqada qilingan barcha harakatlar:**  

index=* earliest=-5m latest=now

📌 **Oxirgi 5 daqiqadagi barcha loglarni chiqaradi.**  

---

📌 3. VirusTotal yoki Yara bilan Integratsiya Qilish
Zararli dastur hashlarini VirusTotal API yoki Yara qoidalari bilan tekshirish mumkin.

🔹 VirusTotal API orqali hashni tekshirish:

| rest uri="https://www.virustotal.com/api/v3/files/{HASH_VALUE}" | table data.attributes.last_analysis_stats
📌 VirusTotal bazasidan zararli hashlar bo‘yicha ma’lumot olish.
✔️ **Ransomware**, **malware**, **data exfiltration**, **PowerShell exploitation** kabi tahdidlarga qarshi qidiruv buyruqlari.  


🔹 Muayyan zararli dasturlarni hash bo‘yicha qidirish (MD5 yoki SHA256 orqali):

index=sysmon EventCode=1 Hashes="*d41d8cd98f00b204e9800998ecf8427e*"


1. MD5 Hashni Splunk orqali olish (Sysmon yoki Linux Loglaridan)
Agar Sysmon yoki Linux audit loglari o‘rnatilgan bo‘lsa, hash qiymatlarini Splunk orqali topish mumkin.

Windows (Sysmon) orqali MD5 hashni qidirish:

index=sysmon EventCode=1 | table Image, Hashes | search Hashes="MD5=*"
📌 Bu buyruq barcha ishlatilgan executable fayllarning MD5 hashlarini chiqaradi.

Agar fayl nomi yoki yo‘li ma’lum bo‘lsa, aniqroq qidiruv:


index=sysmon EventCode=1 Image="C:\\Users\\Public\\malware.exe" | table Image, Hashes
📌 Ma’lum fayl uchun hash qiymatini chiqaradi.

Linux tizimida MD5 hashni olish (auditd loglari):

index=linux_logs "audit.log" | search execve="*/mnt/data/executable*" | table file_path, md5_hash
📌 Tizimda ishlatilgan yoki yuklangan executable fayllarning MD5 hashini ko‘rsatadi.
