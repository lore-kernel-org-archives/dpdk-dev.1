Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCCA1CCD192
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Oct 2025 14:21:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80FEA40280;
	Wed, 15 Oct 2025 16:21:04 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 1FA8340273
 for <dev@dpdk.org>; Wed, 15 Oct 2025 16:21:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760538061;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YKXLva3YerRhGaOZsM58tNAseX/RhgQJyaZTI6MbWBI=;
 b=DvCEvwi+Mdnfl17PnRmE36fy3e0s3/fBmvGf+Wau5fzo1vJ5SU1n1lvKAvmGfgCVn/b7Ag
 9TZCWqEQjex4dsQ3zSTzLSJm0eJ+V6pVoaqWnvNg3Epu0Y+RuBhEAtRKgeoQ17xsEQwmM3
 jgxYGjbQjGVYdKbBwJglTZlpR2u4rwc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-61-6zd1cJZUMoGCdth8J-cAPQ-1; Wed, 15 Oct 2025 10:20:59 -0400
X-MC-Unique: 6zd1cJZUMoGCdth8J-cAPQ-1
X-Mimecast-MFC-AGG-ID: 6zd1cJZUMoGCdth8J-cAPQ_1760538059
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3ef9218daf5so1304989f8f.1
 for <dev@dpdk.org>; Wed, 15 Oct 2025 07:20:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760538059; x=1761142859;
 h=in-reply-to:references:user-agent:subject:to:from:cc:message-id
 :date:content-transfer-encoding:mime-version:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F1e9N2VsPkW2ArBqsWgEsvKfjPbyNkhpSjuSRrJTqHI=;
 b=g2XJfyleF9oNVCMeAO6noMxr9rtuBzT+4u+RkGnXxeBVr7CkoGdw3eyqsatJ590MSI
 YGSucmjROC6FzJGvSReR6xFUdGpDyWaaR7NQSAwhXWXfHvNbjYA9uPOWjZJ+ntgXmPdK
 yub+IIwwyT2lwYrZTpg92Xu9eFJmDDfI1LsCqIIG8zG8IG6pmJZ7ZgMxa1Qx1w9EPo8B
 e4pjxCbFpC0XUkcLgCPHNfX55lZDw1AdMaPtte4kBbl7oE8KRsclTJz9fIyGSGchHLRX
 IGEVAGDIQrk7xIG6rKQr/+G6AvAdQU/lJXEOoVdyJpjlINGVU29TzUwTY7WnC1K73ZYk
 boBQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWO+KbT9yKia9MlNbyn/WhyQAP9poc5zEdIcGJS1WEF+8rhNYK/yBsdrH7D2+4cSTVwW4s=@dpdk.org
X-Gm-Message-State: AOJu0YykNQqRI3BpcRGAqVUPN6gOJlwCP7sH0+hzcQkZZ8gLnu+jM+PS
 ybv3P+CPZZokeGr+6oATZQpGzoUPFnctVmH+C+CQBezdvbQeKhyemqJnN343Z70rrxpyiKUa7W4
 raJRcNwjew5MBVMyW7Q1gFesXhQG3uDxVqW/0Yesz14vg
X-Gm-Gg: ASbGncvH9UAw9Kw7xr+C3H/M/2B6FPa+8kQ7AKI3P5vVINm3YK441RKqtXIwjb3N4Bg
 7OPCEVJJHaAgFc3HKGaUihH+pdzwu+ogfhwwkKCGdoE3KYZvUSARViEtOdRIwcQUhPhHVtAIp98
 tXC/opt9bZ0Bwm6pRFB/5nozE1P9+wWf8Rs0PfvkXhh9CfH9tHKo/pPmEIbeiJFFrI2L3Ytj94o
 nEQf98urL7bCxZpyRM5X78GPanZke7V+kaa2lmDoD4Ft56USmXwPpbNJaa8vPT+W4OPddLGBrlj
 XKwRc2F2C23z0skZlSr4iW6lee4yVv5SFJO+jRNtsde9bF1kvRGtoZef30/ffekRFhySUWjzeRK
 IjOaLP/Tdk4ZkNCMedVMAHR8=
X-Received: by 2002:a05:6000:18a4:b0:426:f40a:7185 with SMTP id
 ffacd0b85a97d-426f40a72c9mr3195347f8f.18.1760538058584; 
 Wed, 15 Oct 2025 07:20:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEVf+dR+Eud6hS9TSgSJsZMb5QTqw8ptAK3s6ToriXT2yLPRGWEn1FupWL0fVkopdsajjQMOw==
X-Received: by 2002:a05:6000:18a4:b0:426:f40a:7185 with SMTP id
 ffacd0b85a97d-426f40a72c9mr3195324f8f.18.1760538057990; 
 Wed, 15 Oct 2025 07:20:57 -0700 (PDT)
Received: from localhost (2a01cb00021ec000b06e6b63494bd4c5.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:b06e:6b63:494b:d4c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426ce57cc0esm29619649f8f.6.2025.10.15.07.20.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Oct 2025 07:20:57 -0700 (PDT)
Mime-Version: 1.0
Date: Wed, 15 Oct 2025 16:20:57 +0200
Message-Id: <DDIYNM2UVM02.I4Z8DDUEEU68@redhat.com>
Cc: <marat.khalili@huawei.com>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Bruce Richardson" <bruce.richardson@intel.com>, <dev@dpdk.org>
Subject: Re: [PATCH v2 1/2] devtools/mailmap_ctl: script to work with mailmap
User-Agent: aerc/0.21.0-9-ga57e783008e9
References: <20250808142721.408998-1-bruce.richardson@intel.com>
 <20250808210837.518507-1-bruce.richardson@intel.com>
 <20250808210837.518507-2-bruce.richardson@intel.com>
In-Reply-To: <20250808210837.518507-2-bruce.richardson@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: AFXtpLnnpMd-15cCZ579rPmPvBb8YLTj2jaVLwtkTOc_1760538059
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
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

Hi Bruce, see my comments inline.

Bruce Richardson, Aug 08, 2025 at 23:08:
> Add a script to easily add entries to, check and sort the mailmap file.
>
> Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
> ---
>  devtools/mailmap_ctl.py | 212 ++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 212 insertions(+)
>  create mode 100755 devtools/mailmap_ctl.py
>
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

You can remove the second paragraph and the bullet points. See at the
end.

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

That's a matter of preference, but for such a small script I prefer to
only import top level modules, e.g.:

import pathlib
import dataclasses

By the way, since python 3.10, you can use the builtin symbols instead
of importing typing symbols. See below for more details.

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

Replace with python 3.10 syntax:

=09email2: str | None

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

Replace with python 3.9 builtin list and use pathlib module directly:

def read_and_parse_mailmap(mailmap_path: pathlib.Path, fail_on_err: bool) -=
> list[MailmapEntry]:

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

Same:

def write_entries_to_file(mailmap_path: pathlib.Path, entries: list[Mailmap=
Entry]):

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
nts or blank lines in the file will be removed",
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

Here you can use sub parsers instead:

=09parser =3D argparse.ArgumentParser(
=09=09description=3D__doc__,
=09=09epilog=3D"NOTE: for operations which write .mailmap, any comments or =
blank lines in the file will be removed",
=09)
=09parser.add_argument("--mailmap", help=3D"Path to .mailmap file (default:=
 search up tree)")
=09sub =3D parser.add_subparsers(title=3D"sub-command help", metavar=3D"SUB=
_COMMAND")
=09sub.required =3D True
=09add =3D sub.add_parser("add", description=3Dadd_entry.__doc__, help=3Dad=
d_entry.__doc__)
=09add.add_argument(
=09=09"entry",
=09=09type=3DMailmapEntry.parse,
=09=09help=3D'Entry to add. Format: "Name <email@domain.com>"',
=09)
=09add.set_defaults(callback=3Dadd_entry)
=09check =3D sub.add_parser("check", description=3Dcheck_mailmap.__doc__, h=
elp=3Dcheck_mailmap.__doc__)
=09check.set_defaults(callback=3Dcheck_mailmap)
=09sort =3D sub.add_parser("sort", description=3Dsort_mailmap.__doc__, help=
=3Dsort_mailmap.__doc__)
=09sort.set_defaults(callback=3Dsort_mailmap)

> +
> +    args =3D parser.parse_args()
> +
> +    if args.mailmap:
> +        mailmap_path =3D Path(args.mailmap)

=09args.mailmap =3D pathlib.Path(args.mailmap)

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

=09args.mailmap =3D mailmap_path / ".mailmap"
> +
> +    # call appropriate operation
> +    operations[args.operation](mailmap_path, args)

And there (you'll need to adjust all callbacks to take a single args
parameter):

=09args.callback(args)

> +
> +
> +if __name__ =3D=3D "__main__":
> +    main()


--=20
Robin

> Do not use or store near heat or open flame.

