Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 045F0C87FDA
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 21:08:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 41C3040693;
	Fri,  8 Aug 2025 23:08:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id B4A5840270
 for <dev@dpdk.org>; Fri,  8 Aug 2025 23:08:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1754687325; x=1786223325;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=qiE+gWfGtmgZnT3hpkVO8aEdPk3fESTRiAxm+LgTkXE=;
 b=QB+PTpbyVRCLaW758v1eMPDmDG17xapfAqFtTtqkBdy6wZfAbqzwzUqt
 fKYBmmRaYN8+qd74Qya7Od1eTMLcW65g5BcUVdmKAFbwGbUbWn2Zii+Wt
 09O2EwEfmojzWc3q5449hLUhVxQ2IgzJ+7bA9A2VCsMFy58IOdsZAH4QY
 X+gojg6dEZCxFshbHJARpUuR6tnRhlzuFgR0OEQ9Uu+MgKk+CH6tGLBG2
 sKPwMVFi/OYYp8LG6rYz8v58t32pBX3MLcz/wlJaF1MeQmIRJLV3VIYz0
 +NOKTd4VJO+TScF0p2n2BPzb9hcEQFxQ6lpTxyWEO26aecAqfzc+myvKK A==;
X-CSE-ConnectionGUID: NAFxb05hTZ2+vjKTic5cZw==
X-CSE-MsgGUID: fdTO+wpmRQS22TbJNwA9dQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11515"; a="60887214"
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="60887214"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 08 Aug 2025 14:08:44 -0700
X-CSE-ConnectionGUID: 2GOlSj9UQG6IUxUDDGT6og==
X-CSE-MsgGUID: zSM6PhWLShGwuxgUrrcFQQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,274,1747724400"; d="scan'208";a="165416741"
Received: from silpixa00401385.ir.intel.com ([10.237.214.33])
 by orviesa007.jf.intel.com with ESMTP; 08 Aug 2025 14:08:43 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: marat.khalili@huawei.com,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 1/2] devtools/mailmap_ctl: script to work with mailmap
Date: Fri,  8 Aug 2025 22:08:33 +0100
Message-ID: <20250808210837.518507-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250808210837.518507-1-bruce.richardson@intel.com>
References: <20250808142721.408998-1-bruce.richardson@intel.com>
 <20250808210837.518507-1-bruce.richardson@intel.com>
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
 devtools/mailmap_ctl.py | 212 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 212 insertions(+)
 create mode 100755 devtools/mailmap_ctl.py

diff --git a/devtools/mailmap_ctl.py b/devtools/mailmap_ctl.py
new file mode 100755
index 0000000000..15548c54cd
--- /dev/null
+++ b/devtools/mailmap_ctl.py
@@ -0,0 +1,212 @@
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
+import re
+import argparse
+import itertools
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
+    def _get_name_for_sorting(name) -> str:
+        """Normalize a name for sorting purposes."""
+        # Remove accents/diacritics. Separate accented chars into two - so accent is separate,
+        # then remove the accent.
+        normalized = unicodedata.normalize("NFD", name)
+        normalized = "".join(c for c in normalized if unicodedata.category(c) != "Mn")
+
+        return normalized.lower()
+
+    @classmethod
+    def parse(cls, line: str, line_number: int = 0):
+        """
+        Parse a mailmap line and create a MailmapEntry instance.
+
+        Valid formats:
+        - Name <email>
+        - Name <primary_email> <secondary_email>
+        """
+        # Pattern to match mailmap entries
+        # Group 1: Name, Group 2: first email, Group 3: optional second email
+        pattern = r"^([^<]+?)\s*<([^>]+)>(?:\s*<([^>]+)>)?$"
+        match = re.match(pattern, line.strip())
+        if not match:
+            raise argparse.ArgumentTypeError(f"Invalid entry format: '{line}'")
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
+def read_and_parse_mailmap(mailmap_path: Path, fail_on_err: bool) -> List[MailmapEntry]:
+    """Read and parse a mailmap file, returning entries."""
+    try:
+        with open(mailmap_path, "r", encoding="utf-8") as f:
+            lines = f.readlines()
+    except IOError as e:
+        print(f"Error reading {mailmap_path}: {e}", file=sys.stderr)
+        sys.exit(1)
+
+    entries = []
+    for line_num, line in enumerate(lines, 1):
+        stripped_line = line.strip()
+
+        # Skip empty lines and comments
+        if not stripped_line or stripped_line.startswith("#"):
+            continue
+
+        try:
+            entry = MailmapEntry.parse(stripped_line, line_num)
+        except argparse.ArgumentTypeError as e:
+            print(f"Line {line_num}: {e}", file=sys.stderr)
+            if fail_on_err:
+                sys.exit(1)
+            continue
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
+    entries = read_and_parse_mailmap(mailmap_path, False)
+
+    errors = 0
+    for e1, e2 in itertools.pairwise(entries):
+        if e1.name_for_sorting > e2.name_for_sorting:
+            print(
+                f"Line {e2.line_number}: '{e2.name}' should come before '{e1.name}'",
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
+    entries = read_and_parse_mailmap(mailmap_path, True)
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
+    new_entry = args.entry
+    entries = read_and_parse_mailmap(mailmap_path, True)
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
+            f"Error: Duplicate entry - '{new_entry.name} <{new_entry.email1}>' already exists",
+            file=sys.stderr,
+        )
+        sys.exit(1)
+
+    for n, entry in enumerate(entries):
+        if entry.name_for_sorting > new_entry.name_for_sorting:
+            entries.insert(n, new_entry)
+            break
+    else:
+        entries.append(new_entry)
+    write_entries_to_file(mailmap_path, entries)
+
+
+def main():
+    """Main function."""
+    # ops and functions implementing them
+    operations = {"add": add_entry, "check": check_mailmap, "sort": sort_mailmap}
+
+    parser = argparse.ArgumentParser(
+        description=__doc__,
+        formatter_class=argparse.RawDescriptionHelpFormatter,
+        epilog="NOTE:\n for operations which write .mailmap, any comments or blank lines in the file will be removed",
+    )
+    parser.add_argument("operation", choices=operations.keys(), help="Operation to perform")
+    parser.add_argument("--mailmap", help="Path to .mailmap file (default: search up tree)")
+    parser.add_argument(
+        "entry",
+        nargs="?",
+        type=MailmapEntry.parse,
+        help='Entry to add. Format: "Name <email@domain.com>"',
+    )
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
+    # call appropriate operation
+    operations[args.operation](mailmap_path, args)
+
+
+if __name__ == "__main__":
+    main()
-- 
2.48.1

