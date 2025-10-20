Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56948CCD193
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 14:08:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0089240609;
	Mon, 20 Oct 2025 16:08:16 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
 by mails.dpdk.org (Postfix) with ESMTP id 7B919400D6
 for <dev@dpdk.org>; Mon, 20 Oct 2025 16:08:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1760969295; x=1792505295;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=VI+uHLv1sHXSwwghv6p2NKIaLunGjx21BOtBx5tuEcU=;
 b=OZEkIvmE5U3/C/CVSiKFODLP3ns1+FuEcB371NMxpmGzWluaAulhQtxG
 me67Oge4tielogYfUd2TIMBnbgfsEB4d22aUXZUyjkRt3eWTUv4qhaayg
 mrpTojoACn8/1erZ389aIje1FLIycDT7zmW7S1OdPErYoz2gBxsGjJmXk
 0z4ueA72cvrudHGh9zTCBolmXInKQ7Gk94kZ0ssUWYBMqa/ZUgx1Ve2Lj
 aCQh1safxl076D4Cgj95Q/8EdnmyknHZI6bxEYejCMzEWLYLvgpBppSg+
 2/8Ipq9xw5I1F2e//ddDm2662kDR9KDjV8CUN54EOaO0S+QCpoJIH1t6L g==;
X-CSE-ConnectionGUID: ifVQYcS3RfWY0IiVf/0/Vg==
X-CSE-MsgGUID: 5tUmppOyS/OVO4cmSfuoEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="63179539"
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="63179539"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2025 07:08:13 -0700
X-CSE-ConnectionGUID: 3JGEqRgETECafravAmQDog==
X-CSE-MsgGUID: aZC1Zbn/R1Oz3FdRmCUnEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,242,1754982000"; d="scan'208";a="220487478"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa001.jf.intel.com with ESMTP; 20 Oct 2025 07:08:11 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Robin Jarry <rjarry@redhat.com>, Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v4 1/2] devtools/mailmap_ctl: script to work with mailmap
Date: Mon, 20 Oct 2025 15:08:01 +0100
Message-ID: <20251020140805.1361249-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20251020140805.1361249-1-bruce.richardson@intel.com>
References: <20250808142721.408998-1-bruce.richardson@intel.com>
 <20251020140805.1361249-1-bruce.richardson@intel.com>
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
Reviewed-by: Robin Jarry <rjarry@redhat.com>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
---
 devtools/mailmap_ctl.py | 209 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 209 insertions(+)
 create mode 100755 devtools/mailmap_ctl.py

diff --git a/devtools/mailmap_ctl.py b/devtools/mailmap_ctl.py
new file mode 100755
index 0000000000..e8f645bfcc
--- /dev/null
+++ b/devtools/mailmap_ctl.py
@@ -0,0 +1,209 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: BSD-3-Clause
+# Copyright(c) 2025 Intel Corporation
+
+"""
+A tool for manipulating the .mailmap file in DPDK repository.
+"""
+
+import argparse
+import itertools
+import re
+import sys
+import unicodedata
+from dataclasses import dataclass
+from pathlib import Path
+
+
+@dataclass
+class MailmapEntry:
+    """Represents a single mailmap entry."""
+
+    name: str
+    name_for_sorting: str
+    email1: str
+    email2: str | None
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
+def read_and_parse_mailmap(mailmap_path: Path, fail_on_err: bool) -> list[MailmapEntry]:
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
+def write_entries_to_file(mailmap_path: Path, entries: list[MailmapEntry]):
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
+def check_mailmap(args):
+    """Check that mailmap entries are correctly sorted and formatted."""
+    entries = read_and_parse_mailmap(args.mailmap, False)
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
+def sort_mailmap(args):
+    """Sort the mailmap entries alphabetically by name."""
+    entries = read_and_parse_mailmap(args.mailmap, True)
+
+    entries.sort(key=lambda x: x.name_for_sorting)
+    write_entries_to_file(args.mailmap, entries)
+
+
+def add_entry(args):
+    """Add a new entry to the mailmap file in the correct alphabetical position."""
+    if not args.entry:
+        print("Error: 'add' operation requires an entry argument", file=sys.stderr)
+        sys.exit(1)
+
+    new_entry = args.entry
+    entries = read_and_parse_mailmap(args.mailmap, True)
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
+    write_entries_to_file(args.mailmap, entries)
+
+
+def main():
+    """Main function."""
+
+    parser = argparse.ArgumentParser(
+        description=__doc__,
+        formatter_class=argparse.RawDescriptionHelpFormatter,
+        epilog="NOTE:\n for operations which write .mailmap, any comments or blank lines in the file will be removed",
+    )
+    parser.add_argument("--mailmap", help="Path to .mailmap file (default: search up tree)")
+    sub = parser.add_subparsers(title="Per-command help", metavar="COMMAND", required=True)
+    add = sub.add_parser("add", description=add_entry.__doc__, help=add_entry.__doc__)
+    add.add_argument(
+        "entry",
+        type=MailmapEntry.parse,
+        help='Entry to add. Format: "Name <email@domain.com>"',
+    )
+    add.set_defaults(callback=add_entry)
+    check = sub.add_parser("check", description=check_mailmap.__doc__, help=check_mailmap.__doc__)
+    check.set_defaults(callback=check_mailmap)
+    sort = sub.add_parser("sort", description=sort_mailmap.__doc__, help=sort_mailmap.__doc__)
+    sort.set_defaults(callback=sort_mailmap)
+
+    args = parser.parse_args()
+
+    if args.mailmap:
+        args.mailmap = Path(args.mailmap)
+    else:
+        # Find mailmap file
+        mailmap_path = Path(".").resolve()
+        while not (mailmap_path / ".mailmap").exists():
+            if mailmap_path == mailmap_path.parent:
+                print("Error: No .mailmap file found", file=sys.stderr)
+                sys.exit(1)
+            mailmap_path = mailmap_path.parent
+        args.mailmap = mailmap_path / ".mailmap"
+
+    # call appropriate operation
+    args.callback(args)
+
+
+if __name__ == "__main__":
+    main()
-- 
2.48.1

