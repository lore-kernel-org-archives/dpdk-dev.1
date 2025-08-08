Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB0A3C87FDA
	for <dpdk-dev@archiver.kernel.org>; Fri,  8 Aug 2025 16:44:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 852C6402AB;
	Fri,  8 Aug 2025 18:44:07 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 5CA0F4028B
 for <dev@dpdk.org>; Fri,  8 Aug 2025 18:44:05 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.216])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bz8rC5sdKz6L50R;
 Sat,  9 Aug 2025 00:39:23 +0800 (CST)
Received: from frapeml100004.china.huawei.com (unknown [7.182.85.167])
 by mail.maildlp.com (Postfix) with ESMTPS id 20455140371;
 Sat,  9 Aug 2025 00:44:03 +0800 (CST)
Received: from frapeml500002.china.huawei.com (7.182.85.205) by
 frapeml100004.china.huawei.com (7.182.85.167) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 8 Aug 2025 18:44:02 +0200
Received: from frapeml500002.china.huawei.com ([7.182.85.205]) by
 frapeml500002.china.huawei.com ([7.182.85.205]) with mapi id 15.01.2507.039;
 Fri, 8 Aug 2025 18:44:02 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Bruce Richardson <bruce.richardson@intel.com>
CC: "dev@dpdk.org" <dev@dpdk.org>
Subject: RE: [PATCH 1/2] devtools/mailmap_ctl: script to work with mailmap
Thread-Topic: [PATCH 1/2] devtools/mailmap_ctl: script to work with mailmap
Thread-Index: AQHcCHCxZwBeQq40yUCMVd+jdHwXXrRY6BYA
Date: Fri, 8 Aug 2025 16:44:02 +0000
Message-ID: <2b31ddbcc8174ff89b5c4a063e55003c@huawei.com>
References: <20250808142721.408998-1-bruce.richardson@intel.com>
 <20250808142721.408998-2-bruce.richardson@intel.com>
In-Reply-To: <20250808142721.408998-2-bruce.richardson@intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.206.137.70]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
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

Thank you for doing this! Very cool script, see couple of nits below.

> -----Original Message-----
> From: Bruce Richardson <bruce.richardson@intel.com>
> Sent: Friday 8 August 2025 15:27
> To: dev@dpdk.org
> Cc: Bruce Richardson <bruce.richardson@intel.com>
> Subject: [PATCH 1/2] devtools/mailmap_ctl: script to work with mailmap
>=20
> Add a script to easily add entries to, check and sort the mailmap file.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  devtools/mailmap_ctl.py | 211 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 211 insertions(+)
>  create mode 100755 devtools/mailmap_ctl.py
>=20
> diff --git a/devtools/mailmap_ctl.py b/devtools/mailmap_ctl.py
> new file mode 100755
> index 0000000000..ffb7bcd69b
> --- /dev/null
> +++ b/devtools/mailmap_ctl.py
> @@ -0,0 +1,211 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright(c) 2025 Intel Corporation
> +
> +"""
> +A tool for manipulating the .mailmap file in DPDK repository.
> +
> +This script supports three operations:
> +- add: adds a new entry to the mailmap file in the correct position
> +- check: validates mailmap entries are sorted and correctly formatted
> +- sort: sorts the mailmap entries alphabetically by name
> +"""
> +
> +import sys
> +import os
> +import re
> +import argparse
> +import unicodedata
> +from pathlib import Path
> +from dataclasses import dataclass
> +from typing import List, Optional
> +
> +
> +@dataclass
> +class MailmapEntry:
> +    """Represents a single mailmap entry."""
> +
> +    name: str
> +    name_for_sorting: str
> +    email1: str
> +    email2: Optional[str]
> +    line_number: int
> +
> +    def __str__(self) -> str:
> +        """Format the entry back to mailmap string format."""
> +        return f"{self.name} <{self.email1}>" + (f" <{self.email2}>" if =
self.email2 else "")
> +
> +    @staticmethod
> +    def _get_name_for_sorting(name):
> +        """Normalize a name for sorting purposes."""
> +        # Remove accents/diacritics. Separate accented chars into two - =
so accent is separate,
> +        # then remove the accent.
> +        normalized =3D unicodedata.normalize("NFD", name)
> +        normalized =3D "".join(c for c in normalized if unicodedata.cate=
gory(c) !=3D "Mn")
> +
> +        return normalized.lower()
> +
> +    @classmethod
> +    def parse(cls, line: str, line_number: int) -> Optional["MailmapEntr=
y"]:
> +        """
> +        Parse a mailmap line and create a MailmapEntry instance.
> +
> +        Valid formats:
> +        - Name <email>
> +        - Name <primary_email> <secondary_email>
> +        """
> +        line =3D line.strip()
> +        if not line or line.startswith("#"):
> +            return None
> +
> +        # Pattern to match mailmap entries
> +        # Group 1: Name, Group 2: first email, Group 3: optional second =
email
> +        pattern =3D r"^([^<]+?)\s*<([^>]+)>(?:\s*<([^>]+)>)?$"
> +        match =3D re.match(pattern, line)
> +        if not match:
> +            return None
> +
> +        name =3D match.group(1).strip()
> +        primary_email =3D match.group(2).strip()
> +        secondary_email =3D match.group(3).strip() if match.group(3) els=
e None
> +
> +        return cls(
> +            name=3Dname,
> +            name_for_sorting=3Dcls._get_name_for_sorting(name),
> +            email1=3Dprimary_email,
> +            email2=3Dsecondary_email,
> +            line_number=3Dline_number,
> +        )
> +
> +
> +def read_and_parse_mailmap(mailmap_path: Path) -> List[MailmapEntry]:
> +    """Read and parse a mailmap file, returning entries."""
> +    try:
> +        with open(mailmap_path, "r", encoding=3D"utf-8") as f:
> +            lines =3D f.readlines()
> +    except IOError as e:
> +        print(f"Error reading {mailmap_path}: {e}", file=3Dsys.stderr)
> +        sys.exit(1)
> +
> +    entries =3D []
> +    line_num =3D 0
> +
> +    for line in lines:
> +        line_num +=3D 1

nit: could use `for line_num, line in enumerate(lines, 1)`.

> +        stripped_line =3D line.strip()
> +
> +        # Skip empty lines and comments
> +        if not stripped_line or stripped_line.startswith("#"):
> +            continue
> +
> +        entry =3D MailmapEntry.parse(stripped_line, line_num)
> +        if entry is None:
> +            print(f"Line {line_num}: Invalid format - {stripped_line}", =
file=3Dsys.stderr)
> +            continue

Should we fail here instead of continuing? If the operation is check, the c=
heck should not pass. If the operation is add, we probably don't want to si=
mply remove everything we couldn't parse.

> +
> +        # Check for more than two email addresses
> +        if stripped_line.count("<") > 2:
> +            print(f"Line {line_num}: Too many email addresses - {strippe=
d_line}", file=3Dsys.stderr)

If this is invalid should we perhaps modify regex to disallow it in Mailmap=
Entry.parse so that it affects new records as well?

> +
> +        entries.append(entry)
> +    return entries
> +
> +
> +def write_entries_to_file(mailmap_path: Path, entries: List[MailmapEntry=
]):
> +    """Write entries to mailmap file."""
> +    try:
> +        with open(mailmap_path, "w", encoding=3D"utf-8") as f:
> +            for entry in entries:
> +                f.write(str(entry) + "\n")
> +    except IOError as e:
> +        print(f"Error writing {mailmap_path}: {e}", file=3Dsys.stderr)
> +        sys.exit(1)
> +
> +
> +def check_mailmap(mailmap_path, _):
> +    """Check that mailmap entries are correctly sorted and formatted."""

As noted above, it will not fail if some entries are incorrectly formatted.

Also, we could probably check for duplicates.

> +    entries =3D read_and_parse_mailmap(mailmap_path)
> +
> +    errors =3D 0
> +    for i in range(1, len(entries)):
> +        if entries[i].name_for_sorting < entries[i - 1].name_for_sorting=
:

nit: could use `for entry1, entry2 in itertools.pairwise(entries):`

> +            print(
> +                f"Line {entries[i].line_number}: Entry '{entries[i].name=
}' is incorrectly sorted",
> +                file=3Dsys.stderr,
> +            )
> +            errors +=3D 1
> +
> +    if errors:
> +        sys.exit(1)
> +
> +
> +def sort_mailmap(mailmap_path, _):
> +    """Sort the mailmap entries alphabetically by name."""

Should we warn user somewhere that all comments are going to be deleted?
Should we allow comments at all if this is what we do?

> +    entries =3D read_and_parse_mailmap(mailmap_path)
> +
> +    entries.sort(key=3Dlambda x: x.name_for_sorting)
> +    write_entries_to_file(mailmap_path, entries)
> +
> +
> +def add_entry(mailmap_path, args):
> +    """Add a new entry to the mailmap file in the correct alphabetical p=
osition."""
> +    if not args.entry:

nit: it is possible to make argparse check it using subparsers or groups.

> +        print("Error: 'add' operation requires an entry argument", file=
=3Dsys.stderr)
> +        sys.exit(1)
> +
> +    new_entry =3D MailmapEntry.parse(args.entry, 0)
> +    if new_entry is None:

nit: it is possible to make argparse convert argument to MailmapEntry and r=
eport error to the user in a standard way if it fails, but it will require =
some redesign of MailmapEntry so maybe not worth it.

> +        print(f"Error: Invalid entry format: {args.entry}", file=3Dsys.s=
tderr)
> +        sys.exit(1)
> +
> +    entries =3D read_and_parse_mailmap(mailmap_path)
> +
> +    # Check if entry already exists, checking email2 only if it's specif=
ied
> +    if (
> +        not new_entry.email2
> +        and any(e.name =3D=3D new_entry.name and e.email1 =3D=3D new_ent=
ry.email1 for e in entries)
> +    ) or any(

This will usually trigger even when `not new_entry.email2`.=20

> +        e.name =3D=3D new_entry.name and e.email1 =3D=3D new_entry.email=
1 and e.email2 =3D=3D new_entry.email2
> +        for e in entries
> +    ):
> +        print(
> +            f"Warning: Duplicate entry for '{new_entry.name} <{new_entry=
.email1}>' already exists",

Probably not a "Warning" if we exit with error code right after.

Also the error message is slightly misleading when the second any returns t=
rue. I'd split this into two independent checks each with own error message=
, and select between them depending on the presence of new_entry.email2.

> +            file=3Dsys.stderr,
> +        )
> +        sys.exit(1)
> +
> +    entries.append(new_entry)
> +    entries.sort(key=3Dlambda x: x.name_for_sorting)
> +    write_entries_to_file(mailmap_path, entries)
> +
> +
> +def main():
> +    """Main function."""
> +    parser =3D argparse.ArgumentParser(
> +        description=3D__doc__, formatter_class=3Dargparse.RawDescription=
HelpFormatter
> +    )
> +    parser.add_argument("operation", choices=3D["check", "add", "sort"],=
 help=3D"Operation to perform")

Can we build choices from keys of operations dict?

> +    parser.add_argument("--mailmap", help=3D"Path to .mailmap file (defa=
ult: search up tree)")
> +    parser.add_argument("entry", nargs=3D"?", help=3D'Entry to add. Form=
at: "Name <email@domain.com>"')

Secondary email is not mentioned. Actually, if I want to add a secondary em=
ail when I already have primary, what do I do?

> +
> +    args =3D parser.parse_args()
> +
> +    if args.mailmap:
> +        mailmap_path =3D Path(args.mailmap)
> +    else:
> +        # Find mailmap file
> +        mailmap_path =3D Path(".").resolve()
> +        while not (mailmap_path / ".mailmap").exists():
> +            if mailmap_path =3D=3D mailmap_path.parent:
> +                print("Error: No .mailmap file found", file=3Dsys.stderr=
)
> +                sys.exit(1)
> +            mailmap_path =3D mailmap_path.parent
> +        mailmap_path =3D mailmap_path / ".mailmap"
> +
> +    # Handle operations
> +    operations =3D {"add": add_entry, "check": check_mailmap, "sort": so=
rt_mailmap}
> +    operations[args.operation](mailmap_path, args)
> +
> +
> +if __name__ =3D=3D "__main__":
> +    main()
> --
> 2.48.1

