Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E5E7CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Thu,  2 Oct 2025 08:07:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 068F940DD3;
	Thu,  2 Oct 2025 10:07:51 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id EC0EE400D6
 for <dev@dpdk.org>; Thu,  2 Oct 2025 10:07:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759392466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/t1wGKTtmSAfeV0XwSFxZrtdbrohlAUULmlL4M6768U=;
 b=JFG/G2Tzp5ccioai+khRtv7rafOceUbjHwtL/npzqgPXjoIM3e/HjWszCZAxtgNvN+0K3E
 vlgYdi8/17Hvk08B+rK26OYbP5+39avzonjJs/2+UkdVa0GVBal6d7nGE9ObPtjZa6jSVL
 gzdoyPfGNJFI+WzCObJp3Hrgpntqwbw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-ujSo39xBMvST4MDWdQKdmg-1; Thu, 02 Oct 2025 04:07:42 -0400
X-MC-Unique: ujSo39xBMvST4MDWdQKdmg-1
X-Mimecast-MFC-AGG-ID: ujSo39xBMvST4MDWdQKdmg_1759392461
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3f3c118cbb3so961121f8f.3
 for <dev@dpdk.org>; Thu, 02 Oct 2025 01:07:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759392461; x=1759997261;
 h=in-reply-to:references:user-agent:to:from:cc:subject:message-id
 :date:content-transfer-encoding:mime-version:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/t1wGKTtmSAfeV0XwSFxZrtdbrohlAUULmlL4M6768U=;
 b=GekWmlNiCOHPyifw3jULX5zKyBKr3m9p8mt22t57PDCJ9355UDBczSDQtijf5VU23C
 5NFejJ54C/KdXkvcWhQX8V8nNDrnUtxB7GCfglnaCO8IxfKJAFjqLJQrg/lhEUIEePl0
 5ffYBwjrGTJrc7Yt60r6JltlONKg0a97MhRsnZFpzXoY7Fw+rpcrkX3A1aOQzFYfZ9uy
 77xai8mM2CZBrYf2EGCumBNzHpHp0mdSsS015ciT+QOimaVWaYfXdHTAIjAQq32VTN7v
 COFajxAIEyyWYCZxBLXNx91HlspfpX1SnruUpbFdmFv6JvmjPzuwCtql5AvfDJj35Apn
 aWUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWsARTVib/bYfPW1TR6+K+4PRU1eKk/43t2aitqCknaJ8x8vKXYJclC3xaXpL9URoH8Mak=@dpdk.org
X-Gm-Message-State: AOJu0YxxqSIBOMQtVm+Rt7WTc5NSgfTQZ6whBuMUQz04uJ0028mofFam
 R0V4oTTFj8zJFt9OhkwncsSu3+8eql13UhN+PE/JQlsWuqa5+TWPAHGl5T3wSG3ZvIw0IBIDgA+
 pwl1BgDuh9+owY5R0FOCQsjvt2M7cx78CSYH1b1Cy8Q3H
X-Gm-Gg: ASbGncsy9ZMm/9kb/aC6wIhBF9jHkCT8YiXSdzF03KYqpnkTBBl4TPGgfPPmng25r/H
 Mw1MRRnkL4vlZEph+wG0i7+cREAIiFCUowGEoUYPNFtcsabYwTCAEZphnp5D0XhME/rshLqNsgi
 Ikb+Lcs1D2OVw9jaS6Ii/UTieK71zNV1j3xKgUF4ogclM3aFCiAOmH90LVZ7mFV1wfPSE38EeEV
 MeQcb62YmQPHcZLVQXdKMvmWxtE2WzdWUjtaqArTrB6zBdKrCHCDeYxMkOIxW0M4prJ7gNSlvL+
 Ay9j4WOyxtXKL2LORi6GveITQAx3Wx1KayOrzZ32K4septgi1+INAoT7nMxsHE3vaHKLZkCOA3g
 4tedLmmwLifKNo2BKmBnra6I0AGr2
X-Received: by 2002:a05:6000:1845:b0:3eb:2428:4a05 with SMTP id
 ffacd0b85a97d-425577e4a41mr5142210f8f.3.1759392461024; 
 Thu, 02 Oct 2025 01:07:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCkANglSmp/ox1iRqVrj8qoOmjAO9sinHVfpv4iylaHIxKZTFb8h7OzvNM7o02O86wMX5Hjg==
X-Received: by 2002:a05:6000:1845:b0:3eb:2428:4a05 with SMTP id
 ffacd0b85a97d-425577e4a41mr5142164f8f.3.1759392460496; 
 Thu, 02 Oct 2025 01:07:40 -0700 (PDT)
Received: from localhost (2a01cb00021ec000b06e6b63494bd4c5.ipv6.abo.wanadoo.fr.
 [2a01:cb00:21e:c000:b06e:6b63:494b:d4c5])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4255d8f011bsm2552126f8f.46.2025.10.02.01.07.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 01:07:39 -0700 (PDT)
Mime-Version: 1.0
Date: Thu, 02 Oct 2025 10:07:39 +0200
Message-Id: <DD7OKPR7WDW0.2R3E8D0GBL86L@redhat.com>
Subject: Re: [PATCH v3 5/5] usertools/mbuf: parse mbuf history dump
Cc: <shperetz@nvidia.com>, <viacheslavo@nvidia.com>,
 <bruce.richardson@intel.com>, <mb@smartsharesystems.com>,
 <stephen@networkplumber.org>
From: "Robin Jarry" <rjarry@redhat.com>
To: "Thomas Monjalon" <thomas@monjalon.net>, <dev@dpdk.org>
User-Agent: aerc/0.21.0-7-g29413dc7833a
References: <20250616072910.113042-1-shperetz@nvidia.com>
 <20250930233828.3999565-1-thomas@monjalon.net>
 <20250930233828.3999565-6-thomas@monjalon.net>
In-Reply-To: <20250930233828.3999565-6-thomas@monjalon.net>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GkB--Cg8pRlA-zLfch0cJHPY3hUqS8fxhDg0TpOxev0_1759392461
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

Hi Thomas, Shani,

Sorry, I had completely forgotten about this patch.

Thomas Monjalon, Oct 01, 2025 at 01:25:
> From: Shani Peretz <shperetz@nvidia.com>
>
> Add a Python script that parses the history dump of mbufs
> generated by rte_mbuf_history_dump() and related functions,
> and presents it in a human-readable format.
>
> If an operation ID is repeated, such as in the case of a double free,
> it will be highlighted in red and listed at the end of the file.
>
> Signed-off-by: Shani Peretz <shperetz@nvidia.com>
> ---
>  usertools/dpdk-mbuf_history_parser.py | 173 ++++++++++++++++++++++++++
>  1 file changed, 173 insertions(+)
>  create mode 100755 usertools/dpdk-mbuf_history_parser.py
>
> diff --git a/usertools/dpdk-mbuf_history_parser.py b/usertools/dpdk-mbuf_=
history_parser.py
> new file mode 100755
> index 0000000000..dfb02d99be
> --- /dev/null
> +++ b/usertools/dpdk-mbuf_history_parser.py
> @@ -0,0 +1,173 @@
> +#!/usr/bin/env python3
> +# SPDX-License-Identifier: BSD-3-Clause
> +# Copyright (c) 2023 NVIDIA Corporation & Affiliates
> +

Could you add a top level docstring to this module? You can probably
copy paste the contents of the commit message here:

"""
Parse the history dump of mbufs generated by rte_mbuf_history_dump() and
related functions, and present it in a human-readable format.
"""

> +import sys
> +import re
> +import os
> +import enum

Imports are not sorted alphabetically. Could you process the file with
black[1] before submitting a respin? That way we have consistent coding
style for new python code.

[1] https://github.com/psf/black

> +
> +RED =3D "\033[91m"
> +RESET =3D "\033[0m"
> +ENUM_PATTERN =3D r'enum\s+rte_mbuf_history_op\s*{([^}]+)}'
> +VALUE_PATTERN =3D r'([A-Z_]+)\s*=3D\s*(\d+),\s*(?:/\*\s*(.*?)\s*\*/)?'
> +HEADER_FILE =3D os.path.join(
> +    os.path.dirname(os.path.dirname(__file__)),
> +    'lib/mbuf/rte_mbuf_history.h'
> +)
> +
> +
> +def print_history_sequence(address: str, sequence: list[str]):
> +    max_op_width =3D max(
> +        len(re.sub(r'\x1b\[[0-9;]*m', '', op)) for op in sequence
> +    )
> +    op_width =3D max_op_width
> +    for i in range(0, len(sequence), 4):
> +        chunk =3D sequence[i:i + 4]
> +        formatted_ops =3D [f"{op:<{op_width}}" for op in chunk]
> +        line =3D ""
> +        for j, op in enumerate(formatted_ops):
> +            line +=3D op
> +            if j < len(formatted_ops) - 1:
> +                line +=3D " -> "
> +        if i + 4 < len(sequence):
> +            line +=3D " ->"
> +        print(f"mbuf {address}: " + line)
> +    print()
> +
> +
> +def match_field(match: re.Match) -> tuple[int, str]:
> +    name, value, _ =3D match.groups()
> +    return (int(value), name.replace('RTE_MBUF_', ''))
> +
> +
> +class HistoryEnum:
> +    def __init__(self, ops: enum.Enum):
> +        self.ops =3D ops
> +
> +    @staticmethod
> +    def from_header(header_file: str) -> 'HistoryEnum':
> +        with open(header_file, 'r') as f:
> +            content =3D f.read()
> +
> +        # Extract each enum value and its comment
> +        enum_content =3D re.search(ENUM_PATTERN, content, re.DOTALL).gro=
up(1)
> +        fields =3D map(match_field, re.finditer(VALUE_PATTERN, enum_cont=
ent))
> +        fields =3D dict({v: k for k, v in fields})
> +        return HistoryEnum(enum.Enum('HistoryOps', fields))
> +
> +
> +class HistoryLine:
> +    def __init__(self, address: str, ops: list):
> +        self.address =3D address
> +        self.ops =3D ops
> +
> +    def repeats(self) -> [list[str], str | None]:
> +        repeated =3D None
> +        sequence =3D []
> +        for idx, op in enumerate(self.ops):
> +            if idx > 0 and op =3D=3D self.ops[idx - 1] and op.name !=3D =
'NEVER':
> +                sequence[-1] =3D f"{RED}{op.name}{RESET}"
> +                sequence.append(f"{RED}{op.name}{RESET}")
> +                repeated =3D op.name
> +            else:
> +                sequence.append(op.name)
> +        return sequence, repeated
> +
> +
> +class HistoryMetrics:
> +    def __init__(self, metrics: dict[str, int]):
> +        self.metrics =3D metrics
> +
> +    def max_name_width(self) -> int:
> +        return max(len(name) for name in self.metrics.keys())
> +
> +
> +class HistoryParser:
> +    def __init__(self):
> +        self.history_enum =3D HistoryEnum.from_header(HEADER_FILE)
> +
> +    def parse(
> +        self, dump_file: str
> +    ) -> tuple[list[HistoryLine], 'HistoryMetrics']:
> +        with open(dump_file, 'r') as f:
> +            lines =3D [line for line in f.readlines() if line.strip()]
> +            populated =3D next(line for line in lines if "  populated=3D=
" in line)
> +            metrics_start =3D lines.index(populated)
> +
> +        history_lines =3D lines[3:metrics_start]
> +        metrics_lines =3D lines[metrics_start:-1]
> +        return (
> +            self._parse_history(history_lines),
> +            self._parse_metrics(metrics_lines)
> +        )
> +
> +    def _parse_metrics(self, lines: list[str]) -> HistoryMetrics:
> +        metrics =3D {}
> +        for line in lines:
> +            key, value =3D line.split('=3D', 1)
> +            metrics[key] =3D int(value)
> +        return HistoryMetrics(metrics)
> +
> +    def _parse_history(self, lines: list[str]) -> list[HistoryLine]:
> +        # Parse the format "mbuf 0x1054b9980: 0000000000000065"
> +        history_lines =3D []
> +        for line in lines:
> +            address =3D line.split(':')[0].split('mbuf ')[1]
> +            history =3D line.split(':')[1]
> +            history_lines.append(
> +                HistoryLine(
> +                    address=3Daddress,
> +                    ops=3Dself._parse(int(history, 16))
> +                )
> +            )
> +        return history_lines
> +
> +    def _parse(self, history: int) -> list[str]:
> +        ops =3D []
> +        for _ in range(16):  # 64 bits / 4 bits =3D 16 possible operatio=
ns
> +            op =3D history & 0xF  # Extract lowest 4 bits
> +            if op =3D=3D 0:
> +                break
> +            ops.append(self.history_enum.ops(op))
> +            history >>=3D 4
> +
> +        ops.reverse()
> +        return ops
> +
> +
> +def print_history_lines(history_lines: list[HistoryLine]):
> +    lines =3D [
> +        (line.address, line.repeats()) for line in history_lines
> +    ]
> +
> +    for address, (sequence, _) in lines:
> +        print_history_sequence(address, sequence)
> +
> +    print("=3D=3D=3D Violations =3D=3D=3D")
> +    for address, (sequence, repeated) in lines:
> +        if repeated:
> +            print(f"mbuf {address} has repeated ops: {RED}{repeated}{RES=
ET}")
> +
> +
> +def print_metrics(metrics: HistoryMetrics):
> +    print("=3D=3D=3D Metrics Summary =3D=3D=3D")
> +    for name, value in metrics.metrics.items():
> +        print(f"{name + ':':<{metrics.max_name_width() + 2}} {value}")
> +
> +
> +def main():
> +    if len(sys.argv) !=3D 2:
> +        print("Usage: {} <history_file>".format(sys.argv[0]))
> +        sys.exit(1)

Could you use argparse for this? I know it is a bit overkill but it
takes care of the usage, help and error messages for you.

parser =3D argparse.ArgumentParser(description=3D__doc__)
parser.add_argument("history_file")
args =3D parser.parse_args()

> +
> +    history_parser =3D HistoryParser()
> +    history_lines, metrics =3D history_parser.parse(sys.argv[1])

history_lines, metrics =3D history_parser.parse(args.history_file)

> +
> +    print_history_lines(history_lines)
> +    print()
> +    print_metrics(metrics)
> +
> +
> +if __name__ =3D=3D "__main__":
> +    main()


--=20
Robin

> No motorized vehicles allowed.

