Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B00BC87FD3
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 14:27:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D79684065E;
	Fri,  8 Aug 2025 16:27:31 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
 by mails.dpdk.org (Postfix) with ESMTP id C0FF24028B
 for <dev@dpdk.org>; Fri,  8 Aug 2025 16:27:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754663250; x=1786199250;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=mEwVR+PQwAhs5D9OIMuMCH+09XeGF5zfP3l/zLGrqCE=;
 b=nd5OIG6MAfTvIDmr1QSds4cR4TPEUkavmBFlhQRqHg4aoKtcqXm+3ADK
 Mkzu3NABLNV7WU9XMdW0HTdbCE+UvC9LrqT3aqORpgrrJABLLwY6uwIxh
 gdYbDr9lve38Mpdoc43aXXsZZwU0CEWjO6mDESytlu+iJRKu4PlGHE3vm
 NhIv+4xrr4qJ/TXDa3nqH2PirDwi03L472Wo+SW25UjdxO/oYGpBL/yQr
 1VRTlgx+KlFooCwkLSByaFcU5qhciaK5/rjGLsSaWmiPCP3kL+/95HHhG
 D/XOfyVKBZJ4gTyfphGGePSXlx+f3Ig5s51Yz5INJjntbNojDm/G6SEHo Q==;
X-CSE-ConnectionGUID: bbOfDw/jQQKYXlE9IKYcng==
X-CSE-MsgGUID: Oh01gas7RyCeljfwWkP1CQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="67601904"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="67601904"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
 by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2025 07:27:28 -0700
X-CSE-ConnectionGUID: p1WQoGqbTFOmnL9OcsErlw==
X-CSE-MsgGUID: LcSOO89XQs2Cl9Pdn00opg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="165715887"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by fmviesa009.fm.intel.com with ESMTP; 08 Aug 2025 07:27:28 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH 1/2] devtools/mailmap_ctl: script to work with mailmap
Date: Fri,  8 Aug 2025 15:27:19 +0100
Message-ID: <20250808142721.408998-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250808142721.408998-1-bruce.richardson@intel.com>
References: <20250808142721.408998-1-bruce.richardson@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

Add a script to easily add entries to, check and sort the mailmap file.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 devtools/mailmap_ctl.py | 211 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 211 insertions(+)
 create mode 100755 devtools/mailmap_ctl.py

diff --git a/devtools/mailmap_ctl.py b/devtools/mailmap_ctl.py
new file mode 100755
index 0000000000..ffb7bcd69b
--- /dev/null
+++ b/devtools/mailmap_ctl.py
@@ -0,0 +1,211 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 Intel Corporation
+
+"""
+A tool for manipulating the .mailmap file in DPDK repository.
+
+This script supports three operations:
+- add: adds a new entry to the mailmap file in the correct position
+- check: validates mailmap entries are sorted and correctly formatted
+- sort: sorts the mailmap entries alphabetically by name
+"""
+
+import sys
+import os
+import re
+import argparse
+import unicodedata
+from pathlib import Path
+from dataclasses import dataclass
+from typing import List, Optional
+
+
+@dataclass
+class MailmapEntry:
+    """Represents a single mailmap entry."""
+
+    name: str
+    name_for_sorting: str
+    email1: str
+    email2: Optional[str]
+    line_number: int
+
+    def __str__(self) -> str:
+        """Format the entry back to mailmap string format."""
+        return f"{self.name} <{self.email1}>" + (f" <{self.email2}>" if self.email2 else "")
+
+    @staticmethod
+    def _get_name_for_sorting(name):
+        """Normalize a name for sorting purposes."""
+        # Remove accents/diacritics. Separate accented chars into two - so accent is separate,
+        # then remove the accent.
+        normalized = unicodedata.normalize("NFD", name)
+        normalized = "".join(c for c in normalized if unicodedata.category(c) != "Mn")
+
+        return normalized.lower()
+
+    @classmethod
+    def parse(cls, line: str, line_number: int) -> Optional["MailmapEntry"]:
+        """
+        Parse a mailmap line and create a MailmapEntry instance.
+
+        Valid formats:
+        - Name <email>
+        - Name <primary_email> <secondary_email>
+        """
+        line = line.strip()
+        if not line or line.startswith("#"):
+            return None
+
+        # Pattern to match mailmap entries
+        # Group 1: Name, Group 2: first email, Group 3: optional second email
+        pattern = r"^([^<]+?)\s*<([^>]+)>(?:\s*<([^>]+)>)?$"
+        match = re.match(pattern, line)
+        if not match:
+            return None
+
+        name = match.group(1).strip()
+        primary_email = match.group(2).strip()
+        secondary_email = match.group(3).strip() if match.group(3) else None
+
+        return cls(
+            name=name,
+            name_for_sorting=cls._get_name_for_sorting(name),
+            email1=primary_email,
+            email2=secondary_email,
+            line_number=line_number,
+        )
+
+
+def read_and_parse_mailmap(mailmap_path: Path) -> List[MailmapEntry]:
+    """Read and parse a mailmap file, returning entries."""
+    try:
+        with open(mailmap_path, "r", encoding="utf-8") as f:
+            lines = f.readlines()
+    except IOError as e:
+        print(f"Error reading {mailmap_path}: {e}", file=sys.stderr)
+        sys.exit(1)
+
+    entries = []
+    line_num = 0
+
+    for line in lines:
+        line_num += 1
+        stripped_line = line.strip()
+
+        # Skip empty lines and comments
+        if not stripped_line or stripped_line.startswith("#"):
+            continue
+
+        entry = MailmapEntry.parse(stripped_line, line_num)
+        if entry is None:
+            print(f"Line {line_num}: Invalid format - {stripped_line}", file=sys.stderr)
+            continue
+
+        # Check for more than two email addresses
+        if stripped_line.count("<") > 2:
+            print(f"Line {line_num}: Too many email addresses - {stripped_line}", file=sys.stderr)
+
+        entries.append(entry)
+    return entries
+
+
+def write_entries_to_file(mailmap_path: Path, entries: List[MailmapEntry]):
+    """Write entries to mailmap file."""
+    try:
+        with open(mailmap_path, "w", encoding="utf-8") as f:
+            for entry in entries:
+                f.write(str(entry) + "\n")
+    except IOError as e:
+        print(f"Error writing {mailmap_path}: {e}", file=sys.stderr)
+        sys.exit(1)
+
+
+def check_mailmap(mailmap_path, _):
+    """Check that mailmap entries are correctly sorted and formatted."""
+    entries = read_and_parse_mailmap(mailmap_path)
+
+    errors = 0
+    for i in range(1, len(entries)):
+        if entries[i].name_for_sorting < entries[i - 1].name_for_sorting:
+            print(
+                f"Line {entries[i].line_number}: Entry '{entries[i].name}' is incorrectly sorted",
+                file=sys.stderr,
+            )
+            errors += 1
+
+    if errors:
+        sys.exit(1)
+
+
+def sort_mailmap(mailmap_path, _):
+    """Sort the mailmap entries alphabetically by name."""
+    entries = read_and_parse_mailmap(mailmap_path)
+
+    entries.sort(key=lambda x: x.name_for_sorting)
+    write_entries_to_file(mailmap_path, entries)
+
+
+def add_entry(mailmap_path, args):
+    """Add a new entry to the mailmap file in the correct alphabetical position."""
+    if not args.entry:
+        print("Error: 'add' operation requires an entry argument", file=sys.stderr)
+        sys.exit(1)
+
+    new_entry = MailmapEntry.parse(args.entry, 0)
+    if new_entry is None:
+        print(f"Error: Invalid entry format: {args.entry}", file=sys.stderr)
+        sys.exit(1)
+
+    entries = read_and_parse_mailmap(mailmap_path)
+
+    # Check if entry already exists, checking email2 only if it's specified
+    if (
+        not new_entry.email2
+        and any(e.name == new_entry.name and e.email1 == new_entry.email1 for e in entries)
+    ) or any(
+        e.name == new_entry.name and e.email1 == new_entry.email1 and e.email2 == new_entry.email2
+        for e in entries
+    ):
+        print(
+            f"Warning: Duplicate entry for '{new_entry.name} <{new_entry.email1}>' already exists",
+            file=sys.stderr,
+        )
+        sys.exit(1)
+
+    entries.append(new_entry)
+    entries.sort(key=lambda x: x.name_for_sorting)
+    write_entries_to_file(mailmap_path, entries)
+
+
+def main():
+    """Main function."""
+    parser = argparse.ArgumentParser(
+        description=__doc__, formatter_class=argparse.RawDescriptionHelpFormatter
+    )
+    parser.add_argument("operation", choices=["check", "add", "sort"], help="Operation to perform")
+    parser.add_argument("--mailmap", help="Path to .mailmap file (default: search up tree)")
+    parser.add_argument("entry", nargs="?", help='Entry to add. Format: "Name <email@domain.com>"')
+
+    args = parser.parse_args()
+
+    if args.mailmap:
+        mailmap_path = Path(args.mailmap)
+    else:
+        # Find mailmap file
+        mailmap_path = Path(".").resolve()
+        while not (mailmap_path / ".mailmap").exists():
+            if mailmap_path == mailmap_path.parent:
+                print("Error: No .mailmap file found", file=sys.stderr)
+                sys.exit(1)
+            mailmap_path = mailmap_path.parent
+        mailmap_path = mailmap_path / ".mailmap"
+
+    # Handle operations
+    operations = {"add": add_entry, "check": check_mailmap, "sort": sort_mailmap}
+    operations[args.operation](mailmap_path, args)
+
+
+if __name__ == "__main__":
+    main()
-- 
2.48.1

