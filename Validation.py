
import smtplib

# list of email_id to send the mail
li = ["anmolpal99@gmail.com", "anmol.pal@kockpit.in"]

for dest in li:
    s = smtplib.SMTP('smtp.gmail.com', 587)
    s.starttls()
    s.login("alert@kockpit.in", "alert@123")
    message = "Message_you_need_to_send"
    s.sendmail("anmol.pal@kockpit.in", dest, message)
    s.quit()