Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24A6DD46BEB
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 18:10:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4388F4026F;
	Wed, 28 Jan 2026 19:10:13 +0100 (CET)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48]) by mails.dpdk.org (Postfix) with ESMTP id 678204003C
 for <dev@dpdk.org>; Wed, 28 Jan 2026 19:10:11 +0100 (CET)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-4327555464cso131147f8f.1
 for <dev@dpdk.org>; Wed, 28 Jan 2026 10:10:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769623811;
 x=1770228611; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1HbmpBjMx7DiGe6fI6yEERzOyHUHCthVEYnbsJfS4+c=;
 b=v4rJnd17HVuShxzbCAemuRp4EmGfm22wXH5ywGS+ab0gAutcKKEJLCso3b1voafTpo
 n4on+idqeCH/iNwC2q0VzulzM/9cONVFsUDHeBUya4+JK14yQTK5NXWqZbCgCUBPkrt8
 Ov58eobNLcnkUlTnZkr9vGMu8zgB3+frNLYm5Dlv5/dDumNhLtFPCIzMGHX5frHv68cY
 Qbvtdg7C8GoUs9N5sITMkgCG+XVEK5QMSrWsYig8R4riCesITt4Fpv4MDGaShMEOufNP
 vW8vj7unnbPop5CrDn/myxdTcUbMS7lHLgO5Zj00tduAqkxOwxPYj/50IA87T7smFATn
 an+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769623811; x=1770228611;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1HbmpBjMx7DiGe6fI6yEERzOyHUHCthVEYnbsJfS4+c=;
 b=ibg80R8tRH3F6wFG7H6rFdjDsFcPtZysnJcYYySD7XpiG/Omdb/YbxYjN31U65irUx
 DR55PMoR4OljIFpddlcN/UHu5igIEEG1PrWhpqLaN8zSUpxcMI9ggIlsnuNgsIN7mg6I
 D8BYJuVRtJEGuk39YGwAVax/tnDP9CxXNaLLykHhoyynKyXsy9oXqv6Kmwwj2Ia+RVPU
 /c0ekbo9jMcJOkmHZZr1qkC4toUW8//p0t9HfvGv2XGpq+bZtpAONPLCe+Tgm4ONz4E2
 OKCnDdLcCa9BeFr1HCAo3mQVuEOrI8oPXZh4lOWtZLOi0A/QW55va0DSdEbq8bSEAkHI
 eBSA==
X-Gm-Message-State: AOJu0Yw6o4MBAvkoAeauP7sJ6yTAZyXFOlCfnYWPUTYY/S+4VrCAeKsT
 zHsT85nii4e0loInOymsOYpTcOtgxPC3hDcjFcm/CErNRuM5zmwxOL/YJWV3cv6f3NDHVxkREme
 BmkWt
X-Gm-Gg: AZuq6aKi8r+l29klqi+FdYOOSiU7b7lKRCuTznZ98dWZnFqWjh4I/qsdJTbiB63KcU9
 7V3tk1vNmvtuR/TmaTfr2aqa8dZ8SfAORHpSga2r6yFflNy9pMC9uJCnjn0qPsnjeGgww97ivDf
 cSzSZCJwVYW73xEVLMhIJaISv/qRKCLUxN+OgdKEWn9BD1oJLyecmsjgKGo3wCDGR5jzudkrpqC
 gfK1vSSsteUrtuXzhbWsyPVX8AAWGa1ymAWyF9BQCUeOE20VrSDvrrtr+BqfW1ZffiiUXY20Lxm
 2PgYluCe4arIta+EQuA556Zp9uZjAOzuuzoOtc82ojORe+ekkeLrTrdRTNICiL/RRaZ2Q2kFxxN
 +5vOi/qR5Yc4/YOtUxVHvrV3vE0iDL/eqctshcS05Lj4TbQuP5CheX7f6FJGmBX5y91kornVb1e
 ZyC+AdRqRYwCKsWr/Lob/3gRfzcIc38HRl9YcS0KVumbve+OmX02ya
X-Received: by 2002:a05:6000:2582:b0:432:851d:35ef with SMTP id
 ffacd0b85a97d-435dd1c1ademr9695529f8f.42.1769623810790; 
 Wed, 28 Jan 2026 10:10:10 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e1322eefsm8470814f8f.30.2026.01.28.10.10.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 10:10:10 -0800 (PST)
Date: Wed, 28 Jan 2026 10:09:53 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukas Sismis <sismis@dyna-nic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v6 0/6] flow_parser: add shared parser library
Message-ID: <20260128100953.7f3ecb46@phoenix.local>
In-Reply-To: <20260127210532.301464-1-sismis@dyna-nic.com>
References: <20260127210532.301464-1-sismis@dyna-nic.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
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

On Tue, 27 Jan 2026 22:05:25 +0100
Lukas Sismis <sismis@dyna-nic.com> wrote:

> This series extracts the testpmd flow CLI parser into a reusable library,
> enabling external applications to parse rte_flow rules using testpmd synt=
ax.
>=20
> Motivation
> ----------
> External applications like Suricata IDS [1] need to express hardware filt=
ering
> rules in a consistent, human-readable format. Rather than inventing custom
> syntax, reusing testpmd's well-tested flow grammar provides immediate
> compatibility with existing documentation and user knowledge.
>=20
> Note: This library provides only one way to create rte_flow structures.
> Applications can also construct rte_flow_attr, rte_flow_item[], and
> rte_flow_action[] directly in C code.
>=20
> Design
> ------
> The library (librte_flow_parser) exposes the following APIs:
> - rte_flow_parser_parse_attr_str(): Parse attributes only
> - rte_flow_parser_parse_pattern_str(): Parse patterns only
> - rte_flow_parser_parse_actions_str(): Parse actions only
>=20
> Testpmd is updated to use the library, ensuring a single
> maintained parser implementation.
>=20
> Testing and Demo
> -------
> - Functional tests in dpdk-test
> - Example application: examples/flow_parsing
>=20
> Changes
> -------
>=20
> v6:
> - Inconsistent Experimental API Version adjusted
> - Fixes Tag added to MSVC build commit
> - Non-Standard Header Guards updated
> - Implicit Pointer Comparison and Return Type issues addressed in many pl=
aces
> - commit message in patch 6 updated
>=20
> v5:
> - removed/replaced (f)printf code from the library=20
> - reverted back to exporting the internal/private API as it is needed by
>   testpmd and cannot be easily split further.
> - adjusted length of certain lines
> - marking port/queue id typedef as experimental
> - updated release rel_notes
> - copyeright adjustments
>=20
>=20
> v4:
> - ethdev changes in separate commit
> - library's public API only exposes attribute, pattern and action parsing,
>   while the full command parsing is kept internal for testpmd usage only.
> - Addressed Stephen's comments from V3
> - dpdk-test now have tests focused on public and internal library functio=
ns
>=20
> v3:
> - Add more functional tests
> - More concise MAINTAINERS updates
> - Updated license headers
> - A thing to note: When playing with flow commands, I figured, some may u=
se
>   non-flow commands, such as raw decap/encap, policy meter and others.
>   Flow parser library itself now supports `set` command to set e.g. the d=
ecap/
>   encap parameters, as the flow syntax only supports defining the index o=
f the
>   encap/decap configs. The library, however, does not support e.g. `creat=
e`
>   command to create policy meters, as that is just an ID and it can be cr=
eated
>   separately using rte_meter APIs.
>=20
> [1] https://github.com/OISF/suricata/pull/13950
>=20
> Lukas Sismis (6):
>   cmdline: include stddef.h for MSVC compatibility
>   ethdev: add RSS type helper APIs
>   flow_parser: add shared parser library
>   app/testpmd: use shared flow parser library
>   examples/flow_parsing: add flow parser demo
>   test: add flow parser library functional tests
>=20
>  MAINTAINERS                                   |     6 +-
>  app/test-pmd/cmd_flex_item.c                  |    41 +-
>  app/test-pmd/cmdline.c                        |   267 +-
>  app/test-pmd/config.c                         |   112 +-
>  app/test-pmd/flow_parser.c                    |   409 +
>  app/test-pmd/flow_parser_cli.c                |   153 +
>  app/test-pmd/meson.build                      |     5 +-
>  app/test-pmd/testpmd.c                        |     4 +
>  app/test-pmd/testpmd.h                        |   126 +-
>  app/test/meson.build                          |     1 +
>  app/test/test_ethdev_api.c                    |    51 +
>  app/test/test_flow_parser.c                   |   923 ++
>  doc/api/doxy-api-index.md                     |     1 +
>  doc/api/doxy-api.conf.in                      |     1 +
>  doc/guides/prog_guide/flow_parser_lib.rst     |   111 +
>  doc/guides/prog_guide/index.rst               |     1 +
>  doc/guides/rel_notes/release_26_03.rst        |    21 +
>  examples/flow_parsing/main.c                  |   291 +
>  examples/flow_parsing/meson.build             |    11 +
>  examples/meson.build                          |     1 +
>  lib/cmdline/cmdline_parse.h                   |     2 +
>  lib/ethdev/rte_ethdev.c                       |   107 +
>  lib/ethdev/rte_ethdev.h                       |    77 +
>  lib/flow_parser/meson.build                   |     7 +
>  .../flow_parser/rte_flow_parser.c             | 11430 ++++++++--------
>  lib/flow_parser/rte_flow_parser.h             |   124 +
>  lib/flow_parser/rte_flow_parser_private.h     |  1247 ++
>  lib/meson.build                               |     2 +
>  28 files changed, 9698 insertions(+), 5834 deletions(-)
>  create mode 100644 app/test-pmd/flow_parser.c
>  create mode 100644 app/test-pmd/flow_parser_cli.c
>  create mode 100644 app/test/test_flow_parser.c
>  create mode 100644 doc/guides/prog_guide/flow_parser_lib.rst
>  create mode 100644 examples/flow_parsing/main.c
>  create mode 100644 examples/flow_parsing/meson.build
>  create mode 100644 lib/flow_parser/meson.build
>  rename app/test-pmd/cmdline_flow.c =3D> lib/flow_parser/rte_flow_parser.=
c (55%)
>  create mode 100644 lib/flow_parser/rte_flow_parser.h
>  create mode 100644 lib/flow_parser/rte_flow_parser_private.h
>=20


There are only a couple of minor nits left to keep me from putting this in =
next-net.
There is a check comparing pointer against 0 and the example is using
headers not found on Windows.



### Patch 3/6: flow_parser: add shared parser library

**Error** (must fix):

1. **Incorrect NULL checks in parse helper functions** (lines ~15667 and ~1=
5692):
```c
if (src =3D=3D NULL || pattern =3D=3D NULL || pattern_n =3D=3D 0)  // BUG: =
should be pattern_n =3D=3D NULL
```
```c
if (src =3D=3D NULL || actions =3D=3D NULL || actions_n =3D=3D 0)  // BUG: =
should be actions_n =3D=3D NULL
```
These check if the *count* is zero rather than if the *pointer* is NULL. Th=
is will cause incorrect behavior when passing valid pointers.

**Warning** (should fix):

2. **Thread safety documentation** =E2=80=94 The documentation states "The =
parser is not thread-safe" but the public header doesn't include this warni=
ng in the API docstrings. Add `@warning Not thread-safe` to each public fun=
ction's Doxygen comment.

3. **Missing error return in `rte_flow_parser_init()`** =E2=80=94 The funct=
ion signature shows `int` return but I don't see error handling for double-=
initialization or invalid state.

---

### Patch 5/6: examples/flow_parsing: add example
**Warning**:
- Uses `<arpa/inet.h>` which is not portable to Windows. Consider using DPD=
K's byte order macros or conditional compilation.

---


### Required Fix
```c
// In rte_flow_parser_parse_pattern_str():
-   if (src =3D=3D NULL || pattern =3D=3D NULL || pattern_n =3D=3D 0)
+   if (src =3D=3D NULL || pattern =3D=3D NULL || pattern_n =3D=3D NULL)

// In rte_flow_parser_parse_actions_str(): =20
-   if (src =3D=3D NULL || actions =3D=3D NULL || actions_n =3D=3D 0)
+   if (src =3D=3D NULL || actions =3D=3D NULL || actions_n =3D=3D NULL)
```
