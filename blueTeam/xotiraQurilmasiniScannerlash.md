# **🛡️ Xotira Qurilma Nusxasini (USB, HDD, SSD) Xavfsiz Skanerlash**  

Xotira qurilmalarining nusxalarini skanerlash **malware, rootkit, va zararli kodlarni aniqlash** uchun muhim. Ishonchsiz tashqi qurilmalarni tekshirmasdan tizimga ulash **ma'lumotlar buzilishi** va **kiberhujumlarga yo‘l ochishi** mumkin.  

---

## **📌 1. Xotira qurilma nusxalarini xavfsiz skanerlash tartibi**  
1️⃣ **Xotira nusxasini yozuvdan himoya qilish (read-only mode)**  
2️⃣ **Antivirus va malware skanerlari orqali tahlil qilish**  
3️⃣ **Forensik analiz uchun avtomatik yoki qo‘lda skanerlash**  
4️⃣ **Shubhali fayllarni sandbox muhitida tekshirish**  

---

## **✅ 2.1. Qurilmalarni "read-only" rejimida ulash (Himoyalash)**  
**Ma’lumotlar buzilishining oldini olish uchun** qurilmani faqat o‘qish rejimida (read-only) ulash kerak.  

📌 **Linux tizimida read-only ulash:**  
```bash
sudo mount -o ro /dev/sdb1 /mnt/usb
```
📌 **Windows-da faqat o‘qish rejimiga o‘tish (diskpart):**  
```powershell
diskpart
list volume
select volume X
attributes volume set readonly
```
✅ **Bu zararli kodning tizimga yozilishiga yo‘l qo‘ymaydi.**  

---

## **✅ 2.2. Antivirus orqali xotira qurilma nusxalarini skanerlash**  
**📌 ClamAV (Linux & Windows) orqali skanerlash:**  
```bash
clamscan -r /mnt/usb
```
🔹 **-r** → Recursive scan (barcha fayllarni tekshiradi)  
🔹 **--remove** → Topilgan zararli fayllarni o‘chiradi  

📌 **Windows Defender bilan tekshirish (Windows):**  
```powershell
Start-MpScan -ScanPath "D:\" -ScanType FullScan
```

📌 **Yana boshqa antivirus vositalari:**  
✅ **Kaspersky Rescue Disk** – USB va HDD dan zararli fayllarni to‘liq skanerlash  
✅ **Malwarebytes** – Advanced malware tahlil  
✅ **ESET Online Scanner** – Portativ skaner  

---

## **✅ 2.3. Forensik analiz va aniq tahlil qilish**  
Zararli kodlar ba’zan antiviruslar tomonidan topilmasligi mumkin. Shu sabab, **forensik tahlil** va **hash tekshiruvi** kerak bo‘ladi.  

📌 **Xotira nusxasi (disk image) yaratish:**  
```bash
dd if=/dev/sdb of=/mnt/backup/usb_image.dd bs=4M status=progress
```
✅ **Bu butun qurilma nusxasini olib, xavfsiz tahlil qilish imkonini beradi.**  

📌 **Yaratilgan nusxani hash orqali tekshirish:**  
```bash
sha256sum /mnt/backup/usb_image.dd
```
✅ **Hash qiymati o‘zgarsa, zararli o‘zgarish bo‘lishi mumkin.**  

📌 **Forensik analiz vositalari:**  
✅ **Autopsy** – Disk va fayl tahlili uchun GUI forensik vosita  
✅ **Volatility** – Xotira dumplarini tahlil qilish  

---

## **✅ 2.4. Yashirin rootkit va zararli kodlarni aniqlash**  
Ba’zi zararli kodlar **rootkit yoki bootloader** sifatida o‘rnashadi va oddiy skanerlash bilan topilmaydi.  

📌 **Chkrootkit bilan rootkitlarni aniqlash (Linux):**  
```bash
chkrootkit
```
📌 **rkhunter orqali rootkitlarni skanerlash (Linux):**  
```bash
rkhunter --check --sk
```
📌 **Windows uchun RootkitHunter yoki GMER vositalari**  

✅ **Agar rootkit topilsa, butun diskni qayta o‘rnatish tavsiya etiladi!**  

---

## **✅ 2.5. Sandbox muhitida shubhali fayllarni tahlil qilish**  
Agar USB yoki xotira qurilmasida shubhali fayl bo‘lsa, uni **real tizimda ochmasdan sandbox muhitida tekshirish kerak.**  

📌 **Cuckoo Sandbox (Linux) orqali zararli faylni tekshirish:**  
```bash
cuckoo submit /mnt/usb/suspicious.exe
```
📌 **Windows uchun Hybrid Analysis yoki Any.Run platformalaridan foydalanish mumkin.**  

---

# **🔥 Xulosa**  
✅ **Xotira qurilma nusxalarini xavfsiz skanerlash uchun:**  
🔹 **Read-only rejimda ulash** (`mount -o ro`)  
🔹 **Antivirus orqali skanerlash** (`clamscan, Windows Defender, Malwarebytes`)  
🔹 **Forensik tahlil va hash tekshiruvi** (`sha256sum, Autopsy, Volatility`)  
🔹 **Rootkitlarni aniqlash** (`chkrootkit, rkhunter`)  
🔹 **Sandbox muhitida zararli fayllarni tekshirish** (`Cuckoo, Hybrid Analysis`)  

🚀 **Keyingi bosqich:**  
👉 **Siz aynan qaysi hujum turiga qarshi tekshirishni xohlaysiz? USB Malware, Rootkit, yoki boshqa xavfsizlik tekshiruvlari?** 😊



📌 2. Xotira Qurilma Nusxalarini Forensik Tahlil Qilish
Ba’zan oddiy antivirus skanerlash bilan zararli kodlarni topish qiyin bo‘ladi. Forensik tahlil yordamida biz diskdagi yashirin tahdidlarni topishimiz mumkin.

📍 Misol 4: Xotira qurilmasi nusxasini olib, tahlil qilish
📌 Hujum jarayoni:
1️⃣ Shubhali USB fleshka topiladi
2️⃣ USB’ni tizimga ulash xavfli bo‘lishi mumkin
3️⃣ Qurilma nusxasi olinib, izolyatsiyalangan muhitda tahlil qilinadi

✅ Qurilma nusxasini olish (Linux & Mac):

bash
Copy
Edit
dd if=/dev/sdb of=/mnt/backup/usb_image.dd bs=4M status=progress
🔹 Bu butun qurilmadan nusxa yaratadi va to‘g‘ridan-to‘g‘ri tahlil qilish imkonini beradi.

✅ Hash qiymatini tekshirish:

bash
Copy
Edit
sha256sum /mnt/backup/usb_image.dd
🔹 Agar hash o‘zgarsa, demak, ma’lumotlar buzilgan yoki o‘zgartirilgan.

✅ Autopsy orqali xotira tahlil qilish (GUI vosita):

bash
Copy
Edit
autopsy
🔹 Bu vosita forensik tahlil uchun eng yaxshi variantlardan biri.
