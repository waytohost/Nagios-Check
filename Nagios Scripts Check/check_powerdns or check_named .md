# Nagios NRPE Check for PowerDNS (pdns) and BIND (named)

## What are PowerDNS and BIND?

* **PowerDNS (pdns)** is an authoritative DNS server used to manage and serve DNS records.
* **BIND (named)** is a DNS server that provides authoritative and recursive DNS services.

The check verifies that port 53 is listening and confirms that either the PowerDNS (`pdns`) or BIND (`named`) service is running.

---

## Verify Existing NRPE Checks

Run the following commands:

```bash
/usr/local/nagios/libexec/check_nrpe -H localhost -c check_powerdns
/usr/local/nagios/libexec/check_nrpe -H localhost -c check_named
```

### Expected Result

You should receive a response similar to:

```text
PowerDNS (pdns) is running. Skipping.
```

or

```text
BIND (named) is running. Skipping.
```

### If You Receive

```text
NRPE: Command 'check_powerdns' not defined
```

or

```text
NRPE: Command 'check_named' not defined
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
wget https://raw.githubusercontent.com/waytohost/Nagios-Check/main/scripts/check_port53.sh
```

Make it executable:

```bash
chmod +x /usr/local/nagios/libexec/check_port53.sh
```

---

## Add NRPE Commands

Edit the commands configuration file:

```bash
vim /usr/local/nagios/etc/commands.cfg
```

Add the following entries:

```text
# DNS Checks

command[check_powerdns]=/usr/bin/sudo /usr/local/nagios/libexec/check_port53.sh
command[check_named]=/usr/bin/sudo /usr/local/nagios/libexec/check_port53.sh
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
systemctl status 
```

---

## Test Again

Run the checks again:

```bash
/usr/local/nagios/libexec/check_nrpe -H localhost -c check_powerdns
```

```bash
/usr/local/nagios/libexec/check_nrpe -H localhost -c check_named
```

If configured correctly, the command should return the status of the active DNS service instead of an NRPE command definition error.
