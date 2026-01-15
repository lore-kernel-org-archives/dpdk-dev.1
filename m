Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F401FD41143
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Jan 2026 09:01:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E85C5406BC;
	Thu, 15 Jan 2026 10:01:29 +0100 (CET)
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46]) by mails.dpdk.org (Postfix) with ESMTP id 2D9494003C
 for <dev@dpdk.org>; Thu, 15 Jan 2026 10:01:28 +0100 (CET)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-6505d3b84bcso938723a12.3
 for <dev@dpdk.org>; Thu, 15 Jan 2026 01:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=dyna-nic.com; s=google; t=1768467688; x=1769072488; darn=dpdk.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=RQpm8ySto0gP91hXeHOg1cQyuGqH4UViMLzpJOsLxKA=;
 b=jltlnFCen/hzxTHXKE3oyBMyoU8XfkwN5iD2HzesWTBRPKbuTDcYraZxgaOFc/aBsV
 JsEeR2+WOhtggJXUUpFof2O5usnDdClo1vBtfJwF351zoXa1uDrwTGEVEO2offcWc2WE
 /zfs78qyRcXrFI1LIYur0pLp7h07F7J9qK1K2oW0O9+/HzNDVNLTeWG2tgi5TCmfz1GO
 Z37gFhvAIPDoIzJgPb9mmzBwVfryZmymY46IRKZiQkY2/5SJ76uMtN95hM0T0Pg40mT1
 O9eyuXLVWgUxZCC73m410MbVKf6f+IF8jzq1om4pphkWx7EMeNDtx7G5rCRJwCjAiSqr
 POZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768467688; x=1769072488;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RQpm8ySto0gP91hXeHOg1cQyuGqH4UViMLzpJOsLxKA=;
 b=JLhY7TuH3OegD59AEFo37oqNJRWvex1XWVggBeZlypsJRjrl3H7VAwc11tE5Nw2TKJ
 HjXw8nc/2XUlJNsLo+KpcbZW6EWeQsrAcV7uvlJV0/kXviOs0lOodbMV6TJBBBthEkmi
 T4txDI/pfymfi5HB3qsL+q22q0s/SXQMus0DRBsCKED40VRi8lk5VpmrPtYK2x8whSD6
 Rfi2mTG8dm74r46o8M+Qfs/jNKFwxZD3CIoPvW2S+s1LNADTYJBKUe19oFV6c1Ea/YQa
 wYttatUWBphbf+3XrKRYnkrUvpGKVdtmiQk5Hah1slKRrK6BtBS/eCtELC8YLa66D5zy
 dM7A==
X-Gm-Message-State: AOJu0YzDvMP/cnsBd4G1ThR2+qANKtNwOleVDyXsLlMCFISeVN3zUtqW
 pu6ZRNLkCR7YbsG74QUiNssuxcFHQCXKC01C5G+4ONopxNq2HorxxwS+9Xog2VduIsfuWuaMSFf
 smLYDgsV8Uni5i4UeHcTCX7RDnwcwI1krAhsOdNDjt1boBBDPL5TZ
X-Gm-Gg: AY/fxX5XM0krAtWhzUEEDaJhnUesotWi+qP6vWE+ru+nZOTDfBOMLGdxRKQVV7bnekW
 mOVIwjb4HnauXcQjm8vQr5rBEETF4qXMXGxOQQCePtPB8fOEaX52HgOUz0vhNMsF9yif8gD/Uub
 MhJrNfqV29+VUoNcr35pxSJaT1X16nEvtuPoYOeOfGW6E+aQTddtuHmKIQtPbCs+Z90Qa8JPdIv
 DsBP2tefXAa8MUOPP6pi4bD86Rrw/AIc0Mm7gYFkShPC5gTG5yxzEyUK5abaBNnaZB7Wg==
X-Received: by 2002:a05:6402:5255:b0:649:9159:2432 with SMTP id
 4fb4d7f45d1cf-653ee14cb74mr4429728a12.3.1768467686947; Thu, 15 Jan 2026
 01:01:26 -0800 (PST)
MIME-Version: 1.0
References: <20260106153838.398033-1-sismis@dyna-nic.com>
 <20260113094619.14ab23ce@phoenix.local>
In-Reply-To: <20260113094619.14ab23ce@phoenix.local>
From: =?UTF-8?B?THVrw6HFoSDFoGnFoW1pxaE=?= <sismis@dyna-nic.com>
Date: Thu, 15 Jan 2026 10:01:15 +0100
X-Gm-Features: AZwV_QifVjXCW_LEs4ZQXRWa8JrAGY8UypNNFF0DFQqSNfGGnA-phlko_hlcw7o
Message-ID: <CAPQRu6G2YVBuD-R2VPNMXw9UH8do7acC2ohkWdRug65uWDxDXg@mail.gmail.com>
Subject: Re: [RFC PATCH v2 0/7] flow_parser: add shared parser library
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Content-Type: multipart/alternative; boundary="00000000000047127a06486978eb"
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

--00000000000047127a06486978eb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Stephen,

Thanks for the current and earlier feedback. I'll adjust accordingly and
send the patches back.

Lukas

On Tue, Jan 13, 2026, 18:46 Stephen Hemminger <stephen@networkplumber.org>
wrote:

> On Tue,  6 Jan 2026 16:38:30 +0100
> Lukas Sismis <sismis@dyna-nic.com> wrote:
>
> > This series extracts the testpmd flow CLI parser into a reusable librar=
y,
> > enabling external applications to parse rte_flow rules using testpmd
> syntax.
> >
> > Motivation
> > ----------
> > External applications like Suricata IDS [1] need to express hardware
> filtering
> > rules in a consistent, human-readable format. Rather than inventing
> custom
> > syntax, reusing testpmd's well-tested flow grammar provides immediate
> > compatibility with existing documentation and user knowledge.
> >
> > Note: This library provides only one way to create rte_flow structures.
> > Applications can also construct rte_flow_attr, rte_flow_item[], and
> > rte_flow_action[] directly in C code.
> >
> > Design
> > ------
> > The library (librte_flow_parser) exposes:
> > - rte_flow_parser_parse(): Parse command strings into structured output
> > - rte_flow_parser_parse_attr_str(): Parse attributes only
> > - rte_flow_parser_parse_pattern_str(): Parse patterns only
> > - rte_flow_parser_parse_actions_str(): Parse actions only
> >
> > Testpmd is updated to use the shared library, ensuring a single
> > maintained parser implementation.
> >
> > Testing
> > -------
> > - Unit tests: flow_parser_autotest, flow_parser_helpers_autotest
> > - Example application: examples/flow_parsing
> > - All existing testpmd flow commands work unchanged
> >
> >
> >
> > [1] https://github.com/OISF/suricata/pull/13950
> >
> > Lukas Sismis (7):
> >   flow_parser: add shared parser library
> >   app/testpmd: integrate shared flow parser library
> >   examples/flow_parsing: add flow parser demo
> >   test: add flow parser unit tests
> >   doc: add flow parser library maintainers
> >   dts: fix invalid f-string syntax in testpmd API
> >   cmdline: include stddef.h before defining offsetof
> >
> >  .mailmap                                      |     2 +-
> >  MAINTAINERS                                   |     3 +
> >  app/test-pmd/cmd_flex_item.c                  |    41 +-
> >  app/test-pmd/cmdline.c                        |   254 +-
> >  app/test-pmd/config.c                         |   112 +-
> >  app/test-pmd/flow_parser.c                    |   406 +
> >  app/test-pmd/flow_parser.h                    |     8 +
> >  app/test-pmd/flow_parser_cli.c                |   149 +
> >  app/test-pmd/meson.build                      |     5 +-
> >  app/test-pmd/testpmd.c                        |     4 +
> >  app/test-pmd/testpmd.h                        |   126 +-
> >  app/test/meson.build                          |     1 +
> >  app/test/test_flow_parser.c                   |   226 +
> >  doc/guides/prog_guide/flow_parser_lib.rst     |   140 +
> >  doc/guides/prog_guide/index.rst               |     1 +
> >  doc/guides/rel_notes/release_26_03.rst        |     9 +
> >  dts/api/testpmd/__init__.py                   |     8 +-
> >  examples/flow_parsing/main.c                  |   345 +
> >  examples/flow_parsing/meson.build             |    11 +
> >  examples/meson.build                          |     1 +
> >  lib/cmdline/cmdline_parse.h                   |     2 +
> >  lib/ethdev/rte_ethdev.c                       |   107 +
> >  lib/ethdev/rte_ethdev.h                       |    60 +
> >  lib/flow_parser/meson.build                   |     6 +
> >  .../flow_parser/rte_flow_parser.c             | 10774 ++++++++--------
> >  lib/flow_parser/rte_flow_parser.h             |  1304 ++
> >  lib/meson.build                               |     2 +
> >  27 files changed, 8600 insertions(+), 5507 deletions(-)
> >  create mode 100644 app/test-pmd/flow_parser.c
> >  create mode 100644 app/test-pmd/flow_parser.h
> >  create mode 100644 app/test-pmd/flow_parser_cli.c
> >  create mode 100644 app/test/test_flow_parser.c
> >  create mode 100644 doc/guides/prog_guide/flow_parser_lib.rst
> >  create mode 100644 examples/flow_parsing/main.c
> >  create mode 100644 examples/flow_parsing/meson.build
> >  create mode 100644 lib/flow_parser/meson.build
> >  rename app/test-pmd/cmdline_flow.c =3D> lib/flow_parser/rte_flow_parse=
r.c
> (57%)
> >  create mode 100644 lib/flow_parser/rte_flow_parser.h
> >
>
> Looks OK to me, so asked AI for second opinion.
> It saw some things that do need to be fixed.
>
>
> # DPDK Patch Review: Flow Parser Library (v2)
>
> **Series:** `[PATCH v2 0/7]` flow_parser: add shared parser library
> **Author:** Lukas Sismis <sismis@dyna-nic.com>
> **Date:** Tue, 6 Jan 2026
> **Reviewer:** AI Code Review Tool
>
> ---
>
> ## Series Overview
>
> This patch series introduces `librte_flow_parser` as an optional,
> experimental library that exposes the testpmd flow CLI parser as a reusab=
le
> component. The series is well-structured:
>
> | Patch | Description |
> |-------|-------------|
> | 1/7 | Core library implementation (~15K lines) |
> | 2/7 | testpmd integration - removes embedded parser, uses library |
> | 3/7 | Example application demonstrating library usage |
> | 4/7 | Unit tests for the parser |
> | 5/7 | MAINTAINERS and .mailmap updates |
> | 6/7 | DTS f-string syntax fix (tangential bugfix) |
> | 7/7 | cmdline stddef.h include fix (tangential bugfix) |
>
> ---
>
> ## Errors (Must Fix)
>
> ### 1. Missing Copyright Lines in New Files
>
> **Severity:** Error
> **Rule:** SPDX license identifier must be followed by copyright notice
> **Location:** Multiple files
>
> Per DPDK guidelines, every source file must have SPDX identifier followed
> by copyright:
>
> **`lib/flow_parser/rte_flow_parser.h`** (Patch 1):
> ```c
> /* SPDX-License-Identifier: BSD-3-Clause */
> #ifndef RTE_FLOW_PARSER_H
> ```
> Missing: `Copyright(c) 2026 Dyna-NIC` line after SPDX
>
> **`app/test/test_flow_parser.c`** (Patch 4):
> ```c
> /* SPDX-License-Identifier: BSD-3-Clause */
>
> #include <stdint.h>
> ```
> Missing: Copyright line after SPDX
>
> **Recommended fix:**
> ```c
> /* SPDX-License-Identifier: BSD-3-Clause
>  * Copyright(c) 2026 Dyna-NIC
>  */
> ```
>
> ---
>
> ### 2. Subject Lines Exceed 60 Characters
>
> **Severity:** Error
> **Rule:** Subject line maximum 60 characters
> **Location:** Patches 2 and 7
>
> | Patch | Length | Subject |
> |-------|--------|---------|
> | 2/7 | **64** | `[PATCH v2 2/7] app/testpmd: integrate shared flow parse=
r
> library` |
> | 7/7 | **65** | `[PATCH v2 7/7] cmdline: include stddef.h before definin=
g
> offsetof` |
>
> **Recommended fixes:**
> - Patch 2: `app/testpmd: use shared flow parser library` (47 chars with
> prefix)
> - Patch 7: `cmdline: include stddef.h for offsetof` (54 chars with prefix=
)
>
> ---
>
> ## Warnings (Should Fix)
>
> ### 3. Implicit Pointer/Integer Comparisons
>
> **Severity:** Warning
> **Rule:** Compare pointers explicitly with NULL, integers with zero
> **Location:** `lib/flow_parser/rte_flow_parser.c`
>
> Multiple instances use `!ptr` instead of `ptr =3D=3D NULL`:
>
> ```c
> // Current (non-compliant):
> if (!data)
> if (!ipv4->version_ihl)
> if (!ops || !ops->port_validate)
> if (!conf->select_ipv4)
>
> // Should be:
> if (data =3D=3D NULL)
> if (ipv4->version_ihl =3D=3D 0)
> if (ops =3D=3D NULL || ops->port_validate =3D=3D NULL)
> if (conf->select_ipv4 =3D=3D 0)
> ```
>
> Affected locations include lines: 767, 783, 943, 999, 1012, 1053, 1091,
> 1104, 1167, 1381, 1390, 1393, 1658, 1668, 1678, 1688, 1699, 1709, 1720,
> 1730, and many more.
>
> ---
>
> ### 4. Missing Newline at End of File (Cross-Patch Fix)
>
> **Severity:** Warning
> **Rule:** Files must end with a newline
> **Location:** `app/test-pmd/flow_parser.h`
>
> Patch 2 creates this file without a trailing newline:
> ```
> -#endif /* _TESTPMD_FLOW_PARSER_H_ */
> \ No newline at end of file
> ```
>
> Patch 3 fixes it, but each commit should compile independently. The fix
> should be in Patch 2.
>
> ---
>
> ### 5. MAINTAINERS Entry Missing Explicit Maintainer
>
> **Severity:** Warning
> **Rule:** New subsystems should have release notes and maintainer entries
> **Location:** `MAINTAINERS`
>
> The update adds files to the Flow API section:
> ```
> F: lib/flow_parser/
> F: app/test-pmd/flow_parser.c
> F: doc/guides/prog_guide/flow_parser_lib.rst
> ```
>
> However, no explicit `M:` (maintainer) entry is added. Consider adding:
> ```
> Flow Parser Library
> M: Lukas Sismis <sismis@dyna-nic.com>
> F: lib/flow_parser/
> F: doc/guides/prog_guide/flow_parser_lib.rst
> ```
>
> ---
>
> ## Info (Consider)
>
> ### 6. Unrelated Fixes Bundled in Series
>
> Patches 6/7 and 7/7 fix issues unrelated to the flow parser:
> - Patch 6: DTS f-string syntax fix
> - Patch 7: cmdline stddef.h include
>
> These should ideally be separate patch submissions with their own `Fixes:=
`
> tags if they address regressions. If they're prerequisites for the flow
> parser, this should be documented.
>
> ---
>
> ### 7. Code Structure Positive Notes
>
> The series demonstrates good practices:
>
> =E2=9C=93 New APIs marked as `__rte_experimental` (correctly on separate =
lines in
> headers)
> =E2=9C=93 Release notes updated (`doc/guides/rel_notes/release_26_03.rst`=
)
> =E2=9C=93 Documentation added (`doc/guides/prog_guide/flow_parser_lib.rst=
`)
> =E2=9C=93 Unit tests added (`app/test/test_flow_parser.c`)
> =E2=9C=93 Example application provided (`examples/flow_parsing/`)
> =E2=9C=93 Proper use of `RTE_EXPORT_EXPERIMENTAL_SYMBOL`
> =E2=9C=93 Thread-local storage for helper functions
> =E2=9C=93 Commit messages don't start with "It"
>
> ---
>
> ## Checklist Summary
>
> | Category | Status |
> |----------|--------|
> | SPDX + Copyright | =E2=9D=8C Missing copyright in 2 files |
> | Subject line =E2=89=A460 chars | =E2=9D=8C 2 patches exceed limit |
> | Subject lowercase (except acronyms) | =E2=9C=93 |
> | Correct component prefix | =E2=9C=93 |
> | Body =E2=89=A475 chars | =E2=9C=93 |
> | Signed-off-by present | =E2=9C=93 |
> | __rte_experimental placement | =E2=9C=93 |
> | New APIs experimental | =E2=9C=93 |
> | Release notes | =E2=9C=93 |
> | Documentation | =E2=9C=93 |
> | Tests added | =E2=9C=93 |
> | Explicit comparisons | =E2=9D=8C Multiple implicit comparisons |
> | Each commit compiles | =E2=9A=A0=EF=B8=8F Missing newline issue |
>
> ---
>
> ## Recommended Actions for v3
>
> 1. **Add copyright lines** to `rte_flow_parser.h` and `test_flow_parser.c=
`
> 2. **Shorten subject lines** for patches 2 and 7
> 3. **Fix newline** at end of `flow_parser.h` in patch 2 (not patch 3)
> 4. **Consider** adding explicit `M:` entry in MAINTAINERS
> 5. **Consider** splitting patches 6-7 into separate series or adding
> dependency notes
> 6. **Consider** converting implicit comparisons to explicit style (lower
> priority, many occurrences)
>
> ---
>
> *Review generated based on DPDK AGENTS.md guidelines*
>
>
>

--00000000000047127a06486978eb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Hi Stephen,<div dir=3D"auto"><br></div><div dir=3D"auto">=
Thanks for=C2=A0the current and earlier feedback. I&#39;ll adjust=C2=A0acco=
rdingly and send the patches back.</div><div dir=3D"auto"><br></div><div di=
r=3D"auto">Lukas</div></div><br><div class=3D"gmail_quote gmail_quote_conta=
iner"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, Jan 13, 2026, 18:46 Ste=
phen Hemminger &lt;<a href=3D"mailto:stephen@networkplumber.org">stephen@ne=
tworkplumber.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" =
style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On =
Tue,=C2=A0 6 Jan 2026 16:38:30 +0100<br>
Lukas Sismis &lt;<a href=3D"mailto:sismis@dyna-nic.com" target=3D"_blank" r=
el=3D"noreferrer">sismis@dyna-nic.com</a>&gt; wrote:<br>
<br>
&gt; This series extracts the testpmd flow CLI parser into a reusable libra=
ry,<br>
&gt; enabling external applications to parse rte_flow rules using testpmd s=
yntax.<br>
&gt; <br>
&gt; Motivation<br>
&gt; ----------<br>
&gt; External applications like Suricata IDS [1] need to express hardware f=
iltering<br>
&gt; rules in a consistent, human-readable format. Rather than inventing cu=
stom<br>
&gt; syntax, reusing testpmd&#39;s well-tested flow grammar provides immedi=
ate<br>
&gt; compatibility with existing documentation and user knowledge.<br>
&gt; <br>
&gt; Note: This library provides only one way to create rte_flow structures=
.<br>
&gt; Applications can also construct rte_flow_attr, rte_flow_item[], and<br=
>
&gt; rte_flow_action[] directly in C code.<br>
&gt; <br>
&gt; Design<br>
&gt; ------<br>
&gt; The library (librte_flow_parser) exposes:<br>
&gt; - rte_flow_parser_parse(): Parse command strings into structured outpu=
t<br>
&gt; - rte_flow_parser_parse_attr_str(): Parse attributes only<br>
&gt; - rte_flow_parser_parse_pattern_str(): Parse patterns only<br>
&gt; - rte_flow_parser_parse_actions_str(): Parse actions only<br>
&gt; <br>
&gt; Testpmd is updated to use the shared library, ensuring a single<br>
&gt; maintained parser implementation.<br>
&gt; <br>
&gt; Testing<br>
&gt; -------<br>
&gt; - Unit tests: flow_parser_autotest, flow_parser_helpers_autotest<br>
&gt; - Example application: examples/flow_parsing<br>
&gt; - All existing testpmd flow commands work unchanged<br>
&gt; <br>
&gt; <br>
&gt; <br>
&gt; [1] <a href=3D"https://github.com/OISF/suricata/pull/13950" rel=3D"nor=
eferrer noreferrer" target=3D"_blank">https://github.com/OISF/suricata/pull=
/13950</a><br>
&gt;=C2=A0 <br>
&gt; Lukas Sismis (7):<br>
&gt;=C2=A0 =C2=A0flow_parser: add shared parser library<br>
&gt;=C2=A0 =C2=A0app/testpmd: integrate shared flow parser library<br>
&gt;=C2=A0 =C2=A0examples/flow_parsing: add flow parser demo<br>
&gt;=C2=A0 =C2=A0test: add flow parser unit tests<br>
&gt;=C2=A0 =C2=A0doc: add flow parser library maintainers<br>
&gt;=C2=A0 =C2=A0dts: fix invalid f-string syntax in testpmd API<br>
&gt;=C2=A0 =C2=A0cmdline: include stddef.h before defining offsetof<br>
&gt; <br>
&gt;=C2=A0 .mailmap=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 =C2=A02 +-<br>
&gt;=C2=A0 MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 =C2=A03 +<br>
&gt;=C2=A0 app/test-pmd/cmd_flex_item.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 41 +-<br>
&gt;=C2=A0 app/test-pmd/cmdline.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0254 +-<br>
&gt;=C2=A0 app/test-pmd/config.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0112 +-<br>
&gt;=C2=A0 app/test-pmd/flow_parser.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0406 +<br>
&gt;=C2=A0 app/test-pmd/flow_parser.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A08 +<br>
&gt;=C2=A0 app/test-pmd/flow_parser_cli.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0149 +<br>
&gt;=C2=A0 app/test-pmd/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A05 +-<br>
&gt;=C2=A0 app/test-pmd/testpmd.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A04 +<br>
&gt;=C2=A0 app/test-pmd/testpmd.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0126 +-<br>
&gt;=C2=A0 app/test/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A01 +<b=
r>
&gt;=C2=A0 app/test/test_flow_parser.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0226 +<br>
&gt;=C2=A0 doc/guides/prog_guide/flow_parser_lib.rst=C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0140 +<br>
&gt;=C2=A0 doc/guides/prog_guide/index.rst=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A01 +<br>
&gt;=C2=A0 doc/guides/rel_notes/release_26_03.rst=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 =C2=A09 +<br>
&gt;=C2=A0 dts/api/testpmd/__init__.py=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A08 +-<br>
&gt;=C2=A0 examples/flow_parsing/main.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0345 +<br>
&gt;=C2=A0 examples/flow_parsing/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 11 +<br>
&gt;=C2=A0 examples/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A01 +<b=
r>
&gt;=C2=A0 lib/cmdline/cmdline_parse.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A02 +<br>
&gt;=C2=A0 lib/ethdev/rte_ethdev.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0107 +<br>
&gt;=C2=A0 lib/ethdev/rte_ethdev.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 60 +<br>
&gt;=C2=A0 lib/flow_parser/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 =C2=A06 +<br>
&gt;=C2=A0 .../flow_parser/rte_flow_parser.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0| 10774 ++++++++--------<br>
&gt;=C2=A0 lib/flow_parser/rte_flow_parser.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0|=C2=A0 1304 ++<br>
&gt;=C2=A0 lib/meson.build=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A0 =C2=A02 +<br>
&gt;=C2=A0 27 files changed, 8600 insertions(+), 5507 deletions(-)<br>
&gt;=C2=A0 create mode 100644 app/test-pmd/flow_parser.c<br>
&gt;=C2=A0 create mode 100644 app/test-pmd/flow_parser.h<br>
&gt;=C2=A0 create mode 100644 app/test-pmd/flow_parser_cli.c<br>
&gt;=C2=A0 create mode 100644 app/test/test_flow_parser.c<br>
&gt;=C2=A0 create mode 100644 doc/guides/prog_guide/flow_parser_lib.rst<br>
&gt;=C2=A0 create mode 100644 examples/flow_parsing/main.c<br>
&gt;=C2=A0 create mode 100644 examples/flow_parsing/meson.build<br>
&gt;=C2=A0 create mode 100644 lib/flow_parser/meson.build<br>
&gt;=C2=A0 rename app/test-pmd/cmdline_flow.c =3D&gt; lib/flow_parser/rte_f=
low_parser.c (57%)<br>
&gt;=C2=A0 create mode 100644 lib/flow_parser/rte_flow_parser.h<br>
&gt; <br>
<br>
Looks OK to me, so asked AI for second opinion.<br>
It saw some things that do need to be fixed.<br>
<br>
<br>
# DPDK Patch Review: Flow Parser Library (v2)<br>
<br>
**Series:** `[PATCH v2 0/7]` flow_parser: add shared parser library=C2=A0 <=
br>
**Author:** Lukas Sismis &lt;<a href=3D"mailto:sismis@dyna-nic.com" target=
=3D"_blank" rel=3D"noreferrer">sismis@dyna-nic.com</a>&gt;=C2=A0 <br>
**Date:** Tue, 6 Jan 2026=C2=A0 <br>
**Reviewer:** AI Code Review Tool<br>
<br>
---<br>
<br>
## Series Overview<br>
<br>
This patch series introduces `librte_flow_parser` as an optional, experimen=
tal library that exposes the testpmd flow CLI parser as a reusable componen=
t. The series is well-structured:<br>
<br>
| Patch | Description |<br>
|-------|-------------|<br>
| 1/7 | Core library implementation (~15K lines) |<br>
| 2/7 | testpmd integration - removes embedded parser, uses library |<br>
| 3/7 | Example application demonstrating library usage |<br>
| 4/7 | Unit tests for the parser |<br>
| 5/7 | MAINTAINERS and .mailmap updates |<br>
| 6/7 | DTS f-string syntax fix (tangential bugfix) |<br>
| 7/7 | cmdline stddef.h include fix (tangential bugfix) |<br>
<br>
---<br>
<br>
## Errors (Must Fix)<br>
<br>
### 1. Missing Copyright Lines in New Files<br>
<br>
**Severity:** Error=C2=A0 <br>
**Rule:** SPDX license identifier must be followed by copyright notice=C2=
=A0 <br>
**Location:** Multiple files<br>
<br>
Per DPDK guidelines, every source file must have SPDX identifier followed b=
y copyright:<br>
<br>
**`lib/flow_parser/rte_flow_parser.h`** (Patch 1):<br>
```c<br>
/* SPDX-License-Identifier: BSD-3-Clause */<br>
#ifndef RTE_FLOW_PARSER_H<br>
```<br>
Missing: `Copyright(c) 2026 Dyna-NIC` line after SPDX<br>
<br>
**`app/test/test_flow_parser.c`** (Patch 4):<br>
```c<br>
/* SPDX-License-Identifier: BSD-3-Clause */<br>
<br>
#include &lt;stdint.h&gt;<br>
```<br>
Missing: Copyright line after SPDX<br>
<br>
**Recommended fix:**<br>
```c<br>
/* SPDX-License-Identifier: BSD-3-Clause<br>
=C2=A0* Copyright(c) 2026 Dyna-NIC<br>
=C2=A0*/<br>
```<br>
<br>
---<br>
<br>
### 2. Subject Lines Exceed 60 Characters<br>
<br>
**Severity:** Error=C2=A0 <br>
**Rule:** Subject line maximum 60 characters=C2=A0 <br>
**Location:** Patches 2 and 7<br>
<br>
| Patch | Length | Subject |<br>
|-------|--------|---------|<br>
| 2/7 | **64** | `[PATCH v2 2/7] app/testpmd: integrate shared flow parser =
library` |<br>
| 7/7 | **65** | `[PATCH v2 7/7] cmdline: include stddef.h before defining =
offsetof` |<br>
<br>
**Recommended fixes:**<br>
- Patch 2: `app/testpmd: use shared flow parser library` (47 chars with pre=
fix)<br>
- Patch 7: `cmdline: include stddef.h for offsetof` (54 chars with prefix)<=
br>
<br>
---<br>
<br>
## Warnings (Should Fix)<br>
<br>
### 3. Implicit Pointer/Integer Comparisons<br>
<br>
**Severity:** Warning=C2=A0 <br>
**Rule:** Compare pointers explicitly with NULL, integers with zero=C2=A0 <=
br>
**Location:** `lib/flow_parser/rte_flow_parser.c`<br>
<br>
Multiple instances use `!ptr` instead of `ptr =3D=3D NULL`:<br>
<br>
```c<br>
// Current (non-compliant):<br>
if (!data)<br>
if (!ipv4-&gt;version_ihl)<br>
if (!ops || !ops-&gt;port_validate)<br>
if (!conf-&gt;select_ipv4)<br>
<br>
// Should be:<br>
if (data =3D=3D NULL)<br>
if (ipv4-&gt;version_ihl =3D=3D 0)<br>
if (ops =3D=3D NULL || ops-&gt;port_validate =3D=3D NULL)<br>
if (conf-&gt;select_ipv4 =3D=3D 0)<br>
```<br>
<br>
Affected locations include lines: 767, 783, 943, 999, 1012, 1053, 1091, 110=
4, 1167, 1381, 1390, 1393, 1658, 1668, 1678, 1688, 1699, 1709, 1720, 1730, =
and many more.<br>
<br>
---<br>
<br>
### 4. Missing Newline at End of File (Cross-Patch Fix)<br>
<br>
**Severity:** Warning=C2=A0 <br>
**Rule:** Files must end with a newline=C2=A0 <br>
**Location:** `app/test-pmd/flow_parser.h`<br>
<br>
Patch 2 creates this file without a trailing newline:<br>
```<br>
-#endif /* _TESTPMD_FLOW_PARSER_H_ */<br>
\ No newline at end of file<br>
```<br>
<br>
Patch 3 fixes it, but each commit should compile independently. The fix sho=
uld be in Patch 2.<br>
<br>
---<br>
<br>
### 5. MAINTAINERS Entry Missing Explicit Maintainer<br>
<br>
**Severity:** Warning=C2=A0 <br>
**Rule:** New subsystems should have release notes and maintainer entries=
=C2=A0 <br>
**Location:** `MAINTAINERS`<br>
<br>
The update adds files to the Flow API section:<br>
```<br>
F: lib/flow_parser/<br>
F: app/test-pmd/flow_parser.c<br>
F: doc/guides/prog_guide/flow_parser_lib.rst<br>
```<br>
<br>
However, no explicit `M:` (maintainer) entry is added. Consider adding:<br>
```<br>
Flow Parser Library<br>
M: Lukas Sismis &lt;<a href=3D"mailto:sismis@dyna-nic.com" target=3D"_blank=
" rel=3D"noreferrer">sismis@dyna-nic.com</a>&gt;<br>
F: lib/flow_parser/<br>
F: doc/guides/prog_guide/flow_parser_lib.rst<br>
```<br>
<br>
---<br>
<br>
## Info (Consider)<br>
<br>
### 6. Unrelated Fixes Bundled in Series<br>
<br>
Patches 6/7 and 7/7 fix issues unrelated to the flow parser:<br>
- Patch 6: DTS f-string syntax fix<br>
- Patch 7: cmdline stddef.h include<br>
<br>
These should ideally be separate patch submissions with their own `Fixes:` =
tags if they address regressions. If they&#39;re prerequisites for the flow=
 parser, this should be documented.<br>
<br>
---<br>
<br>
### 7. Code Structure Positive Notes<br>
<br>
The series demonstrates good practices:<br>
<br>
=E2=9C=93 New APIs marked as `__rte_experimental` (correctly on separate li=
nes in headers)=C2=A0 <br>
=E2=9C=93 Release notes updated (`doc/guides/rel_notes/release_26_03.rst`)=
=C2=A0 <br>
=E2=9C=93 Documentation added (`doc/guides/prog_guide/flow_parser_lib.rst`)=
=C2=A0 <br>
=E2=9C=93 Unit tests added (`app/test/test_flow_parser.c`)=C2=A0 <br>
=E2=9C=93 Example application provided (`examples/flow_parsing/`)=C2=A0 <br=
>
=E2=9C=93 Proper use of `RTE_EXPORT_EXPERIMENTAL_SYMBOL`=C2=A0 <br>
=E2=9C=93 Thread-local storage for helper functions=C2=A0 <br>
=E2=9C=93 Commit messages don&#39;t start with &quot;It&quot;<br>
<br>
---<br>
<br>
## Checklist Summary<br>
<br>
| Category | Status |<br>
|----------|--------|<br>
| SPDX + Copyright | =E2=9D=8C Missing copyright in 2 files |<br>
| Subject line =E2=89=A460 chars | =E2=9D=8C 2 patches exceed limit |<br>
| Subject lowercase (except acronyms) | =E2=9C=93 |<br>
| Correct component prefix | =E2=9C=93 |<br>
| Body =E2=89=A475 chars | =E2=9C=93 |<br>
| Signed-off-by present | =E2=9C=93 |<br>
| __rte_experimental placement | =E2=9C=93 |<br>
| New APIs experimental | =E2=9C=93 |<br>
| Release notes | =E2=9C=93 |<br>
| Documentation | =E2=9C=93 |<br>
| Tests added | =E2=9C=93 |<br>
| Explicit comparisons | =E2=9D=8C Multiple implicit comparisons |<br>
| Each commit compiles | =E2=9A=A0=EF=B8=8F Missing newline issue |<br>
<br>
---<br>
<br>
## Recommended Actions for v3<br>
<br>
1. **Add copyright lines** to `rte_flow_parser.h` and `test_flow_parser.c`<=
br>
2. **Shorten subject lines** for patches 2 and 7<br>
3. **Fix newline** at end of `flow_parser.h` in patch 2 (not patch 3)<br>
4. **Consider** adding explicit `M:` entry in MAINTAINERS<br>
5. **Consider** splitting patches 6-7 into separate series or adding depend=
ency notes<br>
6. **Consider** converting implicit comparisons to explicit style (lower pr=
iority, many occurrences)<br>
<br>
---<br>
<br>
*Review generated based on DPDK AGENTS.md guidelines*<br>
<br>
<br>
</blockquote></div>

--00000000000047127a06486978eb--
