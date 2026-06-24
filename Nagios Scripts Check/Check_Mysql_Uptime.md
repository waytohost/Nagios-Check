# Nagios NRPE Check for MySQL Uptime

## What is MySQL Uptime?

**MySQL uptime** is the amount of time the MySQL service has been running since its last restart.

The check verifies that the MySQL service is running and returns its current uptime.

---

## Verify Existing NRPE Check

Run the following command:

```bash
/usr/local/nagios/libexec/check_nrpe -H localhost -c check_mysql_uptime
```

### Expected Result

You should receive a response similar to:

```text
MYSQL OK - Uptime: 15 days 4 hours 22 minutes
```

### If You Receive

```text
NRPE: Command 'check_mysql_uptime' not defined
```

then the NRPE command definition has not been added or is not being included from:

```bash
/usr/local/nagios/etc/commands.cfg
```

---

## Install the Check Script

Change to the Nagios plugins directory:

```bash
cd /usr/local/nagios/libexec/
```

Download the script:

```bash
wget https://raw.githubusercontent.com/waytohost/Nagios-Check/main/scripts/check_mysql_uptime.sh
```

Make it executable:

```bash
chmod +x /usr/local/nagios/libexec/check_mysql_uptime.sh
```

---

## Add NRPE Command

Edit the commands configuration file:

```bash
vim /usr/local/nagios/etc/commands.cfg
```

Add the following entry:

```text
# MySQL Checks

command[check_mysql_uptime]=/usr/bin/sudo /usr/local/nagios/libexec/check_mysql_uptime.sh
```

Save and exit the file.

---

## Restart NRPE

```bash
systemctl restart nrpe.service
```

Verify that NRPE is running:

```bash
systemctl status nrpe.service
```

---

## Test Again

Run the check again:

```bash
/usr/local/nagios/libexec/check_nrpe -H localhost -c check_mysql_uptime
```

If configured correctly, the command will return the current MySQL uptime instead of an NRPE command definition error.
