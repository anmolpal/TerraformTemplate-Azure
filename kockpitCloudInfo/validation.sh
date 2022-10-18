
echo '
import smtplib
 
# list of email_id to send the mail
li = ["anmolpal99@gmail.com", "anmolpal9@outlook.com"]
 
for dest in li:
    s = smtplib.SMTP('smtp.gmail.com', 587)
    s.starttls()
    s.login("alert@kockpit.in", "alert@123")
    message = "$USER is trying to create a VM"
    s.sendmail("sender_email_id", dest, message)
    s.quit() ' > python.py