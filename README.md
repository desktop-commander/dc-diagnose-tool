# Desktop Commander Windows Diagnose Tool

This repository contains a small Windows diagnose tool for Desktop Commander.

The tool adds an inbound Windows Firewall allow rule for:

```text
C:\Program Files\Desktop Commander\Desktop Commander.exe
```

The rule is created with these settings:

- Rule name: `Desktop Commander`
- Direction: inbound
- Action: allow
- Protocol: any
- Profiles: public and domain

## Diagnose Script

The main script is:

```text
allow-desktop-commander-firewall.cmd
```

It is intended to be run on Windows with Administrator permission. When launched, it:

1. Shows a Desktop Commander Diagnose Tool banner and version.
2. Explains the firewall rule it is about to apply.
3. Verifies that the script is running as Administrator.
4. Asks the user to confirm before making changes.
5. Replaces any matching existing firewall rule to avoid duplicates.
6. Adds the Desktop Commander firewall rule with `netsh.exe`.

If the script is not run as Administrator, it shows an error and tells the user to run it with elevated permissions.

Current script version: `v1.0`

## Download Page

The `docs` folder contains a static download page:

```text
docs/index.html
```

The page provides a Desktop Commander styled experience with a button that downloads:

```text
docs/desktop-commander-diagnose-tool.cmd
```

The downloadable script in `docs` should stay in sync with the root script.

## Running The Tool

On Windows:

1. Download `desktop-commander-diagnose-tool.cmd`.
2. Right-click the file.
3. Choose **Run as administrator**.
4. Press `Y` when asked to confirm the firewall change.

Administrator permission is required because Windows Firewall rules can only be changed by elevated processes.
