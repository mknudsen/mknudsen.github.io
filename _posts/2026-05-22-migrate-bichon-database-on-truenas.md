---
layout: post
title: "Migrate legacy bichon database on TrueNAS"
date: 2026-05-22
tags: [truenas,bichon]
---

I recently noticed my instance of [bichon](https://github.com/rustmailer/bichon) no longer started on my TrueNAS server. The logs of the failing docker container clearly stated, that the database format was too old and I needed to migrate it to a new format using the bichon-admin command. For whatever reason TrueNAS does not allow rollbacks of app updates for stopped containers, so simply going back to a previous version was not possible.

As the command is unfortunately interactive I needed a running instance of the container to interactively start it from or bichon to operate on the dataset of the container outside of the container. 

Fortunately, bichon offers standalone binaries on [their release page](https://github.com/rustmailer/bichon/releases/). After downloading them to a separate directory you can run `bichon-admin` and point it to `/mnt/.ix-apps/app_mounts/bichon/data/`, assuming "bichon" to be the name of your configured app in TrueNAS. Before doing this, do make sure you have a backup all the data. The tool claims to be non-destructive though.

```bash
BICHON ADMINISTRATIVE TOOL

✔ Select an operation · Migrate Legacy v0.3.7 Storage to v1.0.x

MIGRATION: Bichon v0.3.7 Storage Architecture → v1.0.x
This tool migrates data from the legacy v0.3.7 Tantivy-based storage architecture to the new v1.0.x separated index and Fjall-backed storage format.
Legacy v0.3.7 architecture:
• envelope metadata stored in Tantivy
• message data stored in Tantivy

New v1.0.x architecture:
• mail indexes stored in Tantivy
• attachment indexes stored in Tantivy
• raw message data stored in Fjall
• attachment blobs stored in Fjall

IMPORTANT: The paths below must exactly match what your old bichon server was configured with.
✔ Enter --bichon-root-dir (same value used by the old server) · /mnt/.ix-apps/app_mounts/bichon/data/
✔ Enter --bichon-index-dir (leave blank to use default: /mnt/.ix-apps/app_mounts/bichon/data/envelope) · 
✔ Enter --bichon-data-dir (leave blank to use default: /mnt/.ix-apps/app_mounts/bichon/data/eml) · 

Paths to be migrated:
----------------------------------------
bichon-root-dir      : /mnt/.ix-apps/app_mounts/bichon/data/
bichon-index-dir     : /mnt/.ix-apps/app_mounts/bichon/data/envelope
bichon-data-dir      : /mnt/.ix-apps/app_mounts/bichon/data/eml
----------------------------------------

⌛ Checking legacy v0.x storage layout...
✔ Legacy v0.3.7 Tantivy-based storage detected. Migration to v1.0 is required.

⚠ This migration is non-destructive. Existing v0.x storage files will remain unchanged.
✔ Ready to migrate? · yes
Step 1: Migrating Metadata Entities...
  > Mail Settings             done (1 items)
  > Accounts                  done (2 items)
  > OAuth2 Entities           done (1 items)
  > OAuth2 Pending            done (0 items)
  > OAuth2 Access Tokens      done (1 items)
  > Proxy Settings            done (0 items)
  > User Roles                done (5 items)
  > Users                     done (1 items)
  > Access Tokens             done (1 items)
  > Mailboxes                 done (4 items)
Metadata migration completed successfully.

⌛ Step 2: Migrating email index and blob data...

ℹ Batch size controls memory usage during migration:
  • 1000  — ~500MB RAM  (slower, low memory)
  • 3000  — ~1GB RAM    (recommended)
  • 5000  — ~2GB RAM    (faster, high memory)
  • Note: actual memory usage depends on your average email size.
          If your mailbox contains many large attachments, use a smaller batch size.

✔ Enter batch size (affects memory usage, see notes above) · 3000
✓ Using batch size: 3000

✓ Using batch size: 3000

⌛ EML segments to migrate: 8
⠁ [00:00:18] [----------------------------------------] 0/8 (0s) Segment 1/8 [migrating 2990/84354 3%]                                          Tantivy committing... this may take 2-3 minutes, please wait.

…lots of output here…

attachment merge done: 152.776µs
  [00:10:54] [########################################] 8/8 (0s) Migration finished. Total: 139332, Skipped: 0                        ✔ Migration completed successfully!
```

As I ran the command as root I hat to revert the ownership of the newly created files with `chown -R apps:apps /mnt/.ix-apps/app_mounts/bichon/` to TrueNAS default user for apps. Afterwards the container started without an issue. 

I learned to study the release notes more thoroughly, there was a hint about a breaking change on the [bichon 1.0.0 release page](https://github.com/rustmailer/bichon/releases/tag/1.0.0). TrueNAS not allowing rollbacks for broken applications seems kind of pointless.