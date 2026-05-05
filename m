Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A033FF8855
	for <dpdk-dev@archiver.kernel.org>; Tue,  5 May 2026 18:46:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B119C40616;
	Tue,  5 May 2026 20:46:37 +0200 (CEST)
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54]) by mails.dpdk.org (Postfix) with ESMTP id 41AF940275
 for <dev@dpdk.org>; Tue,  5 May 2026 20:46:36 +0200 (CEST)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-671dad7cac8so6210156a12.0
 for <dev@dpdk.org>; Tue, 05 May 2026 11:46:36 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778006795; cv=none;
 d=google.com; s=arc-20240605;
 b=Uksz1QitrYUMW5zUQebjWJ/hbGaUvv6jXw8/S4E+PyGE36WZTbKEtMzOlQP3AdhDKj
 0RvQaSJeECmty4e7XR384QKxGZ98aettzeFx9X2OOzh/LJlLKJP9kegN8MOoxSjGVweo
 U/V95wqSX0bZaUXDs3iLrSt2JAjUhWShsJjJVfIqObL5unjorIJnVnuRekrHsrNWMrv4
 08/OjwIQcZiKDDw/jIQU1ZBMyi5e4jbjdhDIibPv1adBnoVz30beLgUSvVPQR9uo0sxQ
 oM4+qZmKy1cSONwMReWD9LoSiBV/f8sMREjx8yMxtrS0QnePFQ262ThAlvvGs9yEc4sv
 6Kdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zgwkGxTMLRoPY9cmKS0w896Yz+WXdgPj6fi06eNiMOo=;
 fh=yNsFfEz8yM4W79k8FEvIOeiDU7wocLOmq1bpO87nRkM=;
 b=ajYSiFvI1fT29I0tGgEy/TQuAiAypdzS5YccnvWgYA5vpyLbxSJPCpAKFNmemh86dq
 AycowByknvm4tNdbmtEt5zd7W5e6f3MEO+jq/5bvgY1/obIVgZqiX6baAVJ5zbbcbZgk
 CC5fcNIKLYPpVYSmFvzDXnNcQBHec4psK/1/y2L2axK45yvEDSPL6U6k5KLX2+tgpAcs
 AD/m1WnWcR2Q1yEz6Wdm03aQMyonO2M+b2bzJI3FDf+KI9KuQBWIMNu4fxYaTgU0e5zd
 SjA50DXk2zR+UlqxjxiQc8K1gyEhi+m5zdoDspbRM2VvR0aGFVnxxzL9DNUNiJKhhkHT
 8E/g==; darn=dpdk.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1778006795; x=1778611595; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zgwkGxTMLRoPY9cmKS0w896Yz+WXdgPj6fi06eNiMOo=;
 b=D5t2eE5MhYhH2ZqAZ0kU9HQdDyV0lpKVZr29/TwsJb5th907pNjQbJU9mFsCxjOmfH
 DZzarUPMhaqJWRyti0Jwu2sF6td6JDM/bj6A6i/o8cv48zz7s13Uc0+5ckOhi1c3b2+/
 CYOmngEd3rj/+0fwl4Ng+e4obG0R26pmFW0VTyVsYlkLbFH9CJ+T7Md4o02USbQzT0aK
 0xOuEaY5Mruf7cqXdRsb4CArsDBUHz5vTqpcaZVKVL5cdVXi8JCSR6ofpt++Ab9QQSnv
 vIkxn/MiSlZ2eMTcIie6sxyotaKIbB3kZIXZMgw1R8AQbEHixHIsWSbxQnL55lAglh12
 S1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778006795; x=1778611595;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zgwkGxTMLRoPY9cmKS0w896Yz+WXdgPj6fi06eNiMOo=;
 b=ESMMpgEBKG5IWVRjnREatCDunxI+nXUE0Bn6mg7XpfKjPaJyDrRxWM0a8GuuKA3O+D
 F3TRqz0eQWJYnpo2go1vZrdi8Tr3sz+2pqgSpSbuFWUOVHaimd6UoKAkpNXKsBhAKgbA
 6KTVt/B2K7oCTjUtz0vzhzXXuQTz0bx6Cvubw6j4Mqv5tgldS6AFC+4FMDODppB1hKrp
 XGpKkkzlraBJ0nKFMhxymEeg/K9duUGvDOD2EmOnJqe912kVlArpX6cE9FSOKotIF77R
 KJMXYderA1iwBV/HGuZmqy3z6S2ow5a7Zb44S2dJYzyHj2uhxot/HnM9t2rKbH33FuSg
 0vPQ==
X-Gm-Message-State: AOJu0YwiW/2LJzZvau2ncDIRpoU/7GZnt/4RyPzsIActndVuJFhSQzve
 AnFaU/YdHena1bVCM8HUEMcMoxPxi86dB07X8B3zYIfPS6KiJrak4DQ/zkKydl7lDajKHL2VW1N
 FiQscUYLtQoyO1saAjXjDwa1M1WnLh3ME+FS0PrhpHs56L3dm9Z/BimE=
X-Gm-Gg: AeBDieuhGre+6774U2GCpBtH3rkoMw8RcUsJVtcvE7Azv6hXDNsIletJZ8c1gupPE69
 rNu9gaPkUFsika7mBzeDG1Wo6XoJD0Uslq1ShL3K9OBowoezTaHuJ51tN+sdlOtyG9XpMQdYfgV
 hVn6WpbhpTE2Y3iWu4FGAC2JF75+g859jW7vOY+M9wQF4rqQytnTgdB/1M2fbva/cc9iDfUuWDf
 PnM32skbDlfoJqGUw6d4R9PbWt1Dsnt2nEqBar9VtmKtTggwePwVOKroLhd7WvJuZoOOTNRI3oN
 2Mx1L1s1Msez4G2h+Q==
X-Received: by 2002:a05:6402:2116:b0:670:ef2a:217e with SMTP id
 4fb4d7f45d1cf-67c14dee41cmr7758846a12.0.1778006795392; Tue, 05 May 2026
 11:46:35 -0700 (PDT)
MIME-Version: 1.0
References: <20260505183917.370281-1-sismis@dyna-nic.com>
In-Reply-To: <20260505183917.370281-1-sismis@dyna-nic.com>
From: =?UTF-8?B?THVrw6HFoSDFoGnFoW1pxaE=?= <sismis@dyna-nic.com>
Date: Tue, 5 May 2026 20:46:23 +0200
X-Gm-Features: AVHnY4Lzos-71DOnrdpiLshIF2fc98mfM4vdhN50U3Je5MnGIi2cjBIKMA3egr4
Message-ID: <CAPQRu6HZJV5cf1RNY=-k6MP=P0nXy4Ax89Mwpq0i+-O3mucUGg@mail.gmail.com>
Subject: Re: [PATCH v12 0/6] flow_parser: add shared parser library
To: dev@dpdk.org
Cc: orika@nvidia.com, stephen@networkplumber.org, thomas@monjalon.net
Content-Type: multipart/alternative; boundary="00000000000072b4220651167786"
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

--00000000000072b4220651167786
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=C3=BAt 5. 5. 2026 v 20:39 odes=C3=ADlatel Lukas Sismis <sismis@dyna-nic.co=
m> napsal:

> This series extracts the testpmd flow CLI parser into a reusable library,
> enabling external applications to parse rte_flow rules using testpmd
> syntax.
>
> Motivation
> ----------
> External applications like Suricata IDS [1] need to express hardware
> filtering
> rules in a consistent, human-readable format. Rather than inventing custo=
m
> syntax, reusing testpmd's well-tested flow grammar provides immediate
> compatibility with existing documentation and user knowledge.
>
> Note: This library provides only one way to create rte_flow structures.
> Applications can also construct rte_flow_attr, rte_flow_item[], and
> rte_flow_action[] directly in C code.
>
> Design
> ------
> The library (librte_flow_parser) exposes the following APIs:
> - rte_flow_parser_parse_attr_str(): Parse attributes only
> - rte_flow_parser_parse_pattern_str(): Parse patterns only
> - rte_flow_parser_parse_actions_str(): Parse actions only
>
> Testpmd is updated to use the library, ensuring a single
> maintained parser implementation.
>
> Testing and Demo
> -------
> - Functional tests in dpdk-test
> - Example application: examples/flow_parsing
>
> Changes
> -------
> v12:
> - flipped the ethdev dependency on cmdline, now cmdline depends on ethdev
> - added Bruce's ACK from v11 to the MSVC commit
>
> v11:
> - targetting 26.07 now
> - MAJOR overhaul of the patch set to make every part of the library API
> public
>   and reusable, while only parsing flow testpmd commands.
> - library splitted into a "simple" part and "cmdline" part
> - testpmd changed to use the "cmdline" part of the library, and also to
> handle
>   most of the "set" commands itself, while still using the library to
> parse
>   the parameters of the "set" commands. Previous "operation callbacks" ar=
e
> now
>   replaced by command-codes (enum) and the caller is expected to handle
>   the command execution itself. Likewise, the ownership of helper
> structures,
>   e.g. for vxlan/raw/sample etc. is in the hands of the caller, and the
> library
>   only uses/fills them in with the parsed parameters.
>
> v10:
> - rebased to avoid Github Actions CI build failure
> - merge conflict solved in rel_notes/release_26_03.rst
> - release notes shortened
>
> v9:
> - removed extra new line from the flow parser docs file
>
> v8:
> - rte_port/queue_id_t typedefs removal to be included in a separate patch
> series
> - move of accidental changes of rte_flow parser library from the testpmd
> commit
> - DynaNIC copyright name update
>
> v7:
> - Fixed implicit integer comparison (while (left) -> while (left !=3D 0))
> - NULL checks fixed
> - arpa header removed for Windows compatibility
> - minor comments from the last review addressed
>
> v6:
> - Inconsistent Experimental API Version adjusted
> - Fixes Tag added to MSVC build commit
> - Non-Standard Header Guards updated
> - Implicit Pointer Comparison and Return Type issues addressed in many
> places
> - commit message in patch 6 updated
>
> v5:
> - removed/replaced (f)printf code from the library
> - reverted back to exporting the internal/private API as it is needed by
>   testpmd and cannot be easily split further.
> - adjusted length of certain lines
> - marking port/queue id typedef as experimental
> - updated release rel_notes
> - copyeright adjustments
>
> v4:
> - ethdev changes in separate commit
> - library's public API only exposes attribute, pattern and action parsing=
,
>   while the full command parsing is kept internal for testpmd usage only.
> - Addressed Stephen's comments from V3
> - dpdk-test now have tests focused on public and internal library functio=
ns
>
> v3:
> - Add more functional tests
> - More concise MAINTAINERS updates
> - Updated license headers
> - A thing to note: When playing with flow commands, I figured, some may u=
se
>   non-flow commands, such as raw decap/encap, policy meter and others.
>   Flow parser library itself now supports `set` command to set e.g. the
> decap/
>   encap parameters, as the flow syntax only supports defining the index o=
f
> the
>   encap/decap configs. The library, however, does not support e.g. `creat=
e`
>   command to create policy meters, as that is just an ID and it can be
> created
>   separately using rte_meter APIs.
>
> [1] https://github.com/OISF/suricata/pull/13950
>
> Lukas Sismis (6):
>   cmdline: include stddef.h for MSVC compatibility
>   ethdev: add RSS type helper APIs
>   ethdev: add flow parser library
>   app/testpmd: use flow parser from ethdev
>   examples/flow_parsing: add flow parser demo
>   test: add flow parser functional tests
>
>  MAINTAINERS                                   |     6 +-
>  app/test-pmd/cmd_flex_item.c                  |    47 +-
>  app/test-pmd/cmdline.c                        |   249 +-
>  app/test-pmd/config.c                         |   115 +-
>  app/test-pmd/flow_parser.c                    |   288 +
>  app/test-pmd/flow_parser_cli.c                |   478 +
>  app/test-pmd/meson.build                      |     3 +-
>  app/test-pmd/testpmd.h                        |   135 +-
>  app/test/meson.build                          |     2 +
>  app/test/test_ethdev_api.c                    |    56 +
>  app/test/test_flow_parser.c                   |   790 +
>  app/test/test_flow_parser_simple.c            |   445 +
>  doc/api/doxy-api-index.md                     |     2 +
>  doc/guides/prog_guide/flow_parser_lib.rst     |    99 +
>  doc/guides/prog_guide/index.rst               |     1 +
>  doc/guides/rel_notes/release_26_07.rst        |    11 +
>  doc/guides/sample_app_ug/flow_parsing.rst     |    60 +
>  doc/guides/sample_app_ug/index.rst            |     1 +
>  examples/flow_parsing/main.c                  |   409 +
>  examples/flow_parsing/meson.build             |     8 +
>  examples/meson.build                          |     1 +
>  lib/cmdline/cmdline_parse.h                   |     2 +
>  lib/cmdline/meson.build                       |     8 +-
>  lib/cmdline/rte_flow_parser_cmdline.c         |   138 +
>  lib/cmdline/rte_flow_parser_cmdline.h         |    82 +
>  lib/ethdev/meson.build                        |     3 +
>  lib/ethdev/rte_ethdev.c                       |   109 +
>  lib/ethdev/rte_ethdev.h                       |    60 +
>  .../ethdev/rte_flow_parser.c                  | 12350 ++++++++--------
>  lib/ethdev/rte_flow_parser.h                  |   130 +
>  lib/ethdev/rte_flow_parser_config.h           |   583 +
>  lib/ethdev/rte_flow_parser_internal.h         |   124 +
>  lib/meson.build                               |     4 +-
>  33 files changed, 10157 insertions(+), 6642 deletions(-)
>  create mode 100644 app/test-pmd/flow_parser.c
>  create mode 100644 app/test-pmd/flow_parser_cli.c
>  create mode 100644 app/test/test_flow_parser.c
>  create mode 100644 app/test/test_flow_parser_simple.c
>  create mode 100644 doc/guides/prog_guide/flow_parser_lib.rst
>  create mode 100644 doc/guides/sample_app_ug/flow_parsing.rst
>  create mode 100644 examples/flow_parsing/main.c
>  create mode 100644 examples/flow_parsing/meson.build
>  create mode 100644 lib/cmdline/rte_flow_parser_cmdline.c
>  create mode 100644 lib/cmdline/rte_flow_parser_cmdline.h
>  rename app/test-pmd/cmdline_flow.c =3D> lib/ethdev/rte_flow_parser.c (59=
%)
>  create mode 100644 lib/ethdev/rte_flow_parser.h
>  create mode 100644 lib/ethdev/rte_flow_parser_config.h
>  create mode 100644 lib/ethdev/rte_flow_parser_internal.h
>
> --
> 2.43.7
>
>
Apparently, I missed documenting one field, so GH Actions will fail. But
Stephen, can you please check and decide if this direction is viable? I
didn't make the full parser part of the cmdline part, but now the cmdline
has a dependency on ethdev.
I generally think, no matter the way you look at it, some added dependency
will be present (and likely of cmdline on ethdev).
Thank you.

--00000000000072b4220651167786
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">=C3=BAt 5. 5. 2=
026 v=C2=A020:39 odes=C3=ADlatel Lukas Sismis &lt;<a href=3D"mailto:sismis@=
dyna-nic.com">sismis@dyna-nic.com</a>&gt; napsal:<br></div><blockquote clas=
s=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid r=
gb(204,204,204);padding-left:1ex">This series extracts the testpmd flow CLI=
 parser into a reusable library,<br>
enabling external applications to parse rte_flow rules using testpmd syntax=
.<br>
<br>
Motivation<br>
----------<br>
External applications like Suricata IDS [1] need to express hardware filter=
ing<br>
rules in a consistent, human-readable format. Rather than inventing custom<=
br>
syntax, reusing testpmd&#39;s well-tested flow grammar provides immediate<b=
r>
compatibility with existing documentation and user knowledge.<br>
<br>
Note: This library provides only one way to create rte_flow structures.<br>
Applications can also construct rte_flow_attr, rte_flow_item[], and<br>
rte_flow_action[] directly in C code.<br>
<br>
Design<br>
------<br>
The library (librte_flow_parser) exposes the following APIs:<br>
- rte_flow_parser_parse_attr_str(): Parse attributes only<br>
- rte_flow_parser_parse_pattern_str(): Parse patterns only<br>
- rte_flow_parser_parse_actions_str(): Parse actions only<br>
<br>
Testpmd is updated to use the library, ensuring a single<br>
maintained parser implementation.<br>
<br>
Testing and Demo<br>
-------<br>
- Functional tests in dpdk-test<br>
- Example application: examples/flow_parsing<br>
<br>
Changes<br>
-------<br>
v12:<br>
- flipped the ethdev dependency on cmdline, now cmdline depends on ethdev<b=
r>
- added Bruce&#39;s ACK from v11 to the MSVC commit<br>
<br>
v11:<br>
- targetting 26.07 now<br>
- MAJOR overhaul of the patch set to make every part of the library API pub=
lic<br>
=C2=A0 and reusable, while only parsing flow testpmd commands.<br>
- library splitted into a &quot;simple&quot; part and &quot;cmdline&quot; p=
art<br>
- testpmd changed to use the &quot;cmdline&quot; part of the library, and a=
lso to handle<br>
=C2=A0 most of the &quot;set&quot; commands itself, while still using the l=
ibrary to parse <br>
=C2=A0 the parameters of the &quot;set&quot; commands. Previous &quot;opera=
tion callbacks&quot; are now<br>
=C2=A0 replaced by command-codes (enum) and the caller is expected to handl=
e <br>
=C2=A0 the command execution itself. Likewise, the ownership of helper stru=
ctures,<br>
=C2=A0 e.g. for vxlan/raw/sample etc. is in the hands of the caller, and th=
e library<br>
=C2=A0 only uses/fills them in with the parsed parameters.<br>
<br>
v10:<br>
- rebased to avoid Github Actions CI build failure<br>
- merge conflict solved in rel_notes/release_26_03.rst<br>
- release notes shortened<br>
<br>
v9:<br>
- removed extra new line from the flow parser docs file<br>
<br>
v8:<br>
- rte_port/queue_id_t typedefs removal to be included in a separate patch s=
eries<br>
- move of accidental changes of rte_flow parser library from the testpmd co=
mmit<br>
- DynaNIC copyright name update<br>
<br>
v7:<br>
- Fixed implicit integer comparison (while (left) -&gt; while (left !=3D 0)=
)<br>
- NULL checks fixed<br>
- arpa header removed for Windows compatibility<br>
- minor comments from the last review addressed<br>
<br>
v6:<br>
- Inconsistent Experimental API Version adjusted<br>
- Fixes Tag added to MSVC build commit<br>
- Non-Standard Header Guards updated<br>
- Implicit Pointer Comparison and Return Type issues addressed in many plac=
es<br>
- commit message in patch 6 updated<br>
<br>
v5:<br>
- removed/replaced (f)printf code from the library <br>
- reverted back to exporting the internal/private API as it is needed by<br=
>
=C2=A0 testpmd and cannot be easily split further.<br>
- adjusted length of certain lines<br>
- marking port/queue id typedef as experimental<br>
- updated release rel_notes<br>
- copyeright adjustments<br>
<br>
v4:<br>
- ethdev changes in separate commit<br>
- library&#39;s public API only exposes attribute, pattern and action parsi=
ng,<br>
=C2=A0 while the full command parsing is kept internal for testpmd usage on=
ly.<br>
- Addressed Stephen&#39;s comments from V3<br>
- dpdk-test now have tests focused on public and internal library functions=
<br>
<br>
v3:<br>
- Add more functional tests<br>
- More concise MAINTAINERS updates<br>
- Updated license headers<br>
- A thing to note: When playing with flow commands, I figured, some may use=
<br>
=C2=A0 non-flow commands, such as raw decap/encap, policy meter and others.=
<br>
=C2=A0 Flow parser library itself now supports `set` command to set e.g. th=
e decap/<br>
=C2=A0 encap parameters, as the flow syntax only supports defining the inde=
x of the<br>
=C2=A0 encap/decap configs. The library, however, does not support e.g. `cr=
eate`<br>
=C2=A0 command to create policy meters, as that is just an ID and it can be=
 created<br>
=C2=A0 separately using rte_meter APIs.<br>
<br>
[1] <a href=3D"https://github.com/OISF/suricata/pull/13950" rel=3D"noreferr=
er" target=3D"_blank">https://github.com/OISF/suricata/pull/13950</a><br>
<br>
Lukas Sismis (6):<br>
=C2=A0 cmdline: include stddef.h for MSVC compatibility<br>
=C2=A0 ethdev: add RSS type helper APIs<br>
=C2=A0 ethdev: add flow parser library<br>
=C2=A0 app/testpmd: use flow parser from ethdev<br>
=C2=A0 examples/flow_parsing: add flow parser demo<br>
=C2=A0 test: add flow parser functional tests<br>
<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A0 =C2=A06 +-<br>
=C2=A0app/test-pmd/cmd_flex_item.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 47 +-<br>
=C2=A0app/test-pmd/cmdline.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0249 +-<br>
=C2=A0app/test-pmd/config.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0115 +-<br>
=C2=A0app/test-pmd/flow_parser.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0288 +<br>
=C2=A0app/test-pmd/flow_parser_cli.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0478 +<br>
=C2=A0app/test-pmd/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A03 +-<br>
=C2=A0app/test-pmd/testpmd.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0135 +-<br>
=C2=A0app/test/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A02 +<br>
=C2=A0app/test/test_ethdev_api.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 56 +<br>
=C2=A0app/test/test_flow_parser.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0790 +<br>
=C2=A0app/test/test_flow_parser_simple.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A0445 +<br>
=C2=A0doc/api/doxy-api-index.md=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A02 +<br>
=C2=A0doc/guides/prog_guide/flow_parser_lib.rst=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A0 99 +<br>
=C2=A0doc/guides/prog_guide/index.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A01 +<br>
=C2=A0doc/guides/rel_notes/release_26_07.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 11 +<br>
=C2=A0doc/guides/sample_app_ug/flow_parsing.rst=C2=A0 =C2=A0 =C2=A0|=C2=A0 =
=C2=A0 60 +<br>
=C2=A0doc/guides/sample_app_ug/index.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 |=C2=A0 =C2=A0 =C2=A01 +<br>
=C2=A0examples/flow_parsing/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0409 +<br>
=C2=A0examples/flow_parsing/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A08 +<br>
=C2=A0examples/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A01 +<br>
=C2=A0lib/cmdline/cmdline_parse.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A02 +<br>
=C2=A0lib/cmdline/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A08 +-<br>
=C2=A0lib/cmdline/rte_flow_parser_cmdline.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0138 +<br>
=C2=A0lib/cmdline/rte_flow_parser_cmdline.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0 82 +<br>
=C2=A0lib/ethdev/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A03 +<br>
=C2=A0lib/ethdev/rte_ethdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0109 +<br>
=C2=A0lib/ethdev/rte_ethdev.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 60 +<br>
=C2=A0.../ethdev/rte_flow_parser.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 | 12350 ++++++++--------<br>
=C2=A0lib/ethdev/rte_flow_parser.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0130 +<br>
=C2=A0lib/ethdev/rte_flow_parser_config.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0|=C2=A0 =C2=A0583 +<br>
=C2=A0lib/ethdev/rte_flow_parser_internal.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0|=C2=A0 =C2=A0124 +<br>
=C2=A0lib/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =
=C2=A04 +-<br>
=C2=A033 files changed, 10157 insertions(+), 6642 deletions(-)<br>
=C2=A0create mode 100644 app/test-pmd/flow_parser.c<br>
=C2=A0create mode 100644 app/test-pmd/flow_parser_cli.c<br>
=C2=A0create mode 100644 app/test/test_flow_parser.c<br>
=C2=A0create mode 100644 app/test/test_flow_parser_simple.c<br>
=C2=A0create mode 100644 doc/guides/prog_guide/flow_parser_lib.rst<br>
=C2=A0create mode 100644 doc/guides/sample_app_ug/flow_parsing.rst<br>
=C2=A0create mode 100644 examples/flow_parsing/main.c<br>
=C2=A0create mode 100644 examples/flow_parsing/meson.build<br>
=C2=A0create mode 100644 lib/cmdline/rte_flow_parser_cmdline.c<br>
=C2=A0create mode 100644 lib/cmdline/rte_flow_parser_cmdline.h<br>
=C2=A0rename app/test-pmd/cmdline_flow.c =3D&gt; lib/ethdev/rte_flow_parser=
.c (59%)<br>
=C2=A0create mode 100644 lib/ethdev/rte_flow_parser.h<br>
=C2=A0create mode 100644 lib/ethdev/rte_flow_parser_config.h<br>
=C2=A0create mode 100644 lib/ethdev/rte_flow_parser_internal.h<br>
<br>
-- <br>
2.43.7<br>
<br></blockquote><div><br></div><div>Apparently, I missed documenting one f=
ield, so=C2=A0GH Actions will fail. But Stephen, can you please check and d=
ecide if this direction is viable? I didn&#39;t make the full parser part o=
f the cmdline part, but now the cmdline has a dependency on ethdev.</div><d=
iv>I generally think, no matter the=C2=A0way you=C2=A0look at it, some adde=
d dependency will be present (and likely <span aria-invalid=3D"grammar" cla=
ss=3D"Lm ng" style=3D"border-style:none;background:none">of cmdline</span> =
on ethdev).</div><div>Thank you.</div></div></div>

--00000000000072b4220651167786--
