# Nagios NRPE Check for Imunify360 and ImunifyAV

## What are Imunify360 and ImunifyAV?

* **Imunify360** is a comprehensive server security suite that provides malware detection, firewall protection, intrusion prevention, and proactive defense.
* **ImunifyAV** is a malware scanner that detects and helps remove malicious files from hosting servers.

The check verifies that either **Imunify360** or **ImunifyAV** is installed and functioning correctly on the server.

---

## Verify Existing NRPE Check

Run the following command:

```bash
/usr/local/nagios/libexec/check_nrpe -H localhost -c check_imunify
```

### Expected Result

You should receive a response similar to:

```text
OK - Imunify360 is installed and active
```

or

```text
OK - ImunifyAV is installed and active
```

### If You Receive

```text
NRPE: Command 'check_imunify' not defined
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
wget https://raw.githubusercontent.com/waytohost/Nagios-Check/main/scripts/check_imunify.sh
```

Make it executable:

```bash
chmod +x /usr/local/nagios/libexec/check_imunify.sh
```

---

## Add NRPE Command

Edit the commands configuration file:

```bash
vim /usr/local/nagios/etc/commands.cfg
```

Add the following entry:

```text
# Imunify Checks

command[check_imunify]=/usr/bin/sudo /usr/local/nagios/libexec/check_imunify.sh
```

Save and exit the file.

---

## Restart NRPE

```bash
systemctl restart nrpe.service
```

or 

```bash
systemctl restart xinetd.service
```


Verify that NRPE is running:

```bash
systemctl status nrpe.service
```

---

## Test Again

Run the check again:

```bash
/usr/local/nagios/libexec/check_nrpe -H localhost -c check_imunify
```

If configured correctly, the command will return the status of the installed Imunify product instead of an NRPE command definition error.

### Possible Outputs

```text
OK - Imunify360 is installed and active
```

```text
OK - ImunifyAV is installed and active
```

```text
CRITICAL - Neither Imunify360 nor ImunifyAV is installed
```
