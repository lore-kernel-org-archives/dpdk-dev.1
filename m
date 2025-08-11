Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3380DC87FDB
	for <dpdk-dev@archiver.kernel.org>; Mon, 11 Aug 2025 11:28:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 535344042E;
	Mon, 11 Aug 2025 13:28:09 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 9FFA84013F
 for <dev@dpdk.org>; Mon, 11 Aug 2025 13:28:07 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4c0sh71sL3z6L5Wk;
 Mon, 11 Aug 2025 19:23:19 +0800 (CST)
Received: from frapeml500003.china.huawei.com (unknown [7.182.85.28])
 by mail.maildlp.com (Postfix) with ESMTPS id 0C3BC140275;
 Mon, 11 Aug 2025 19:28:06 +0800 (CST)
Received: from frapeml500002.china.huawei.com (7.182.85.205) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Aug 2025 13:28:05 +0200
Received: from frapeml500002.china.huawei.com ([7.182.85.205]) by
 frapeml500002.china.huawei.com ([7.182.85.205]) with mapi id 15.01.2507.039;
 Mon, 11 Aug 2025 13:28:05 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Bruce Richardson <bruce.richardson@intel.com>, "dev@dpdk.org"
 <dev@dpdk.org>
Subject: RE: [PATCH v2 1/2] devtools/mailmap_ctl: script to work with mailmap
Thread-Topic: [PATCH v2 1/2] devtools/mailmap_ctl: script to work with mailmap
Thread-Index: AQHcCKioRR9MOUhB5UGAq9ClxV+/OrRdTR1g
Date: Mon, 11 Aug 2025 11:28:05 +0000
Message-ID: <993dc8b5fb3f42cf8ce5433c9aadceb6@huawei.com>
References: <20250808142721.408998-1-bruce.richardson@intel.com>
 <20250808210837.518507-1-bruce.richardson@intel.com>
 <20250808210837.518507-2-bruce.richardson@intel.com>
In-Reply-To: <20250808210837.518507-2-bruce.richardson@intel.com>
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

LGTM

> -----Original Message-----
> From: Bruce Richardson <bruce.richardson@intel.com>
> Sent: Friday 8 August 2025 22:09
> To: dev@dpdk.org
> Cc: Marat Khalili <marat.khalili@huawei.com>; Bruce Richardson <bruce.ric=
hardson@intel.com>
> Subject: [PATCH v2 1/2] devtools/mailmap_ctl: script to work with mailmap
>=20
> Add a script to easily add entries to, check and sort the mailmap file.
>=20
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  devtools/mailmap_ctl.py | 212 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 212 insertions(+)
>  create mode 100755 devtools/mailmap_ctl.py
>=20
> diff --git a/devtools/mailmap_ctl.py b/devtools/mailmap_ctl.py
> new file mode 100755
> index 0000000000..15548c54cd
> --- /dev/null
> +++ b/devtools/mailmap_ctl.py
> @@ -0,0 +1,212 @@
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
> +import re
> +import argparse
> +import itertools
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
> +    def _get_name_for_sorting(name) -> str:
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
> +    def parse(cls, line: str, line_number: int =3D 0):
> +        """
> +        Parse a mailmap line and create a MailmapEntry instance.
> +
> +        Valid formats:
> +        - Name <email>
> +        - Name <primary_email> <secondary_email>
> +        """
> +        # Pattern to match mailmap entries
> +        # Group 1: Name, Group 2: first email, Group 3: optional second =
email
> +        pattern =3D r"^([^<]+?)\s*<([^>]+)>(?:\s*<([^>]+)>)?$"
> +        match =3D re.match(pattern, line.strip())
> +        if not match:
> +            raise argparse.ArgumentTypeError(f"Invalid entry format: '{l=
ine}'")
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
> +def read_and_parse_mailmap(mailmap_path: Path, fail_on_err: bool) -> Lis=
t[MailmapEntry]:
> +    """Read and parse a mailmap file, returning entries."""
> +    try:
> +        with open(mailmap_path, "r", encoding=3D"utf-8") as f:
> +            lines =3D f.readlines()
> +    except IOError as e:
> +        print(f"Error reading {mailmap_path}: {e}", file=3Dsys.stderr)
> +        sys.exit(1)
> +
> +    entries =3D []
> +    for line_num, line in enumerate(lines, 1):
> +        stripped_line =3D line.strip()
> +
> +        # Skip empty lines and comments
> +        if not stripped_line or stripped_line.startswith("#"):
> +            continue
> +
> +        try:
> +            entry =3D MailmapEntry.parse(stripped_line, line_num)
> +        except argparse.ArgumentTypeError as e:
> +            print(f"Line {line_num}: {e}", file=3Dsys.stderr)
> +            if fail_on_err:
> +                sys.exit(1)
> +            continue
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
> +    entries =3D read_and_parse_mailmap(mailmap_path, False)
> +
> +    errors =3D 0
> +    for e1, e2 in itertools.pairwise(entries):
> +        if e1.name_for_sorting > e2.name_for_sorting:
> +            print(
> +                f"Line {e2.line_number}: '{e2.name}' should come before =
'{e1.name}'",
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
> +    entries =3D read_and_parse_mailmap(mailmap_path, True)
> +
> +    entries.sort(key=3Dlambda x: x.name_for_sorting)
> +    write_entries_to_file(mailmap_path, entries)
> +
> +
> +def add_entry(mailmap_path, args):
> +    """Add a new entry to the mailmap file in the correct alphabetical p=
osition."""
> +    if not args.entry:
> +        print("Error: 'add' operation requires an entry argument", file=
=3Dsys.stderr)
> +        sys.exit(1)
> +
> +    new_entry =3D args.entry
> +    entries =3D read_and_parse_mailmap(mailmap_path, True)
> +
> +    # Check if entry already exists, checking email2 only if it's specif=
ied
> +    if (
> +        not new_entry.email2
> +        and any(e.name =3D=3D new_entry.name and e.email1 =3D=3D new_ent=
ry.email1 for e in entries)
> +    ) or any(
> +        e.name =3D=3D new_entry.name and e.email1 =3D=3D new_entry.email=
1 and e.email2 =3D=3D new_entry.email2
> +        for e in entries
> +    ):
> +        print(
> +            f"Error: Duplicate entry - '{new_entry.name} <{new_entry.ema=
il1}>' already exists",
> +            file=3Dsys.stderr,
> +        )
> +        sys.exit(1)
> +
> +    for n, entry in enumerate(entries):
> +        if entry.name_for_sorting > new_entry.name_for_sorting:
> +            entries.insert(n, new_entry)
> +            break
> +    else:
> +        entries.append(new_entry)
> +    write_entries_to_file(mailmap_path, entries)
> +
> +
> +def main():
> +    """Main function."""
> +    # ops and functions implementing them
> +    operations =3D {"add": add_entry, "check": check_mailmap, "sort": so=
rt_mailmap}
> +
> +    parser =3D argparse.ArgumentParser(
> +        description=3D__doc__,
> +        formatter_class=3Dargparse.RawDescriptionHelpFormatter,
> +        epilog=3D"NOTE:\n for operations which write .mailmap, any comme=
nts or blank lines in the file will be
> removed",
> +    )
> +    parser.add_argument("operation", choices=3Doperations.keys(), help=
=3D"Operation to perform")
> +    parser.add_argument("--mailmap", help=3D"Path to .mailmap file (defa=
ult: search up tree)")
> +    parser.add_argument(
> +        "entry",
> +        nargs=3D"?",
> +        type=3DMailmapEntry.parse,
> +        help=3D'Entry to add. Format: "Name <email@domain.com>"',
> +    )
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
> +    # call appropriate operation
> +    operations[args.operation](mailmap_path, args)
> +
> +
> +if __name__ =3D=3D "__main__":
> +    main()
> --
> 2.48.1
>=20

Acked-by: Marat Khalili <marat.khalili@huawei.com>
