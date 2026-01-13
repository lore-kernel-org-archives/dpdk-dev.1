Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A20D2F347
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 17:46:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F8E7402DE;
	Tue, 13 Jan 2026 18:46:26 +0100 (CET)
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66]) by mails.dpdk.org (Postfix) with ESMTP id 281C2402D6
 for <dev@dpdk.org>; Tue, 13 Jan 2026 18:46:25 +0100 (CET)
Received: by mail-wr1-f66.google.com with SMTP id
 ffacd0b85a97d-42fbc3056afso4548967f8f.2
 for <dev@dpdk.org>; Tue, 13 Jan 2026 09:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768326385;
 x=1768931185; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LB5E8yk0r0v263JhRoEfOFAOrpAetthgB9l/7ZLB53s=;
 b=MfnvUUxUzrsJn90b8B1VKeh9W7uFrSgpERqfQebvTiQhCigceDZyP9m9XUciLkTB0H
 aDhn9F66JZdpyb7uTACxktWXXx4errl51b2aTffN8IQofzcXO+VRfBiMnQwdXBNjL9Dw
 qBz6HkgszkVWwYi7Rjv1Q2VJl228EGLqHTCzEEXXENf6DpMGzgFbAAxug3rgi+kuwpd0
 LRvW/jLj2uH/pYHx+52vl9j8C4iQKOG6gTvk97WLXv15iS44nUvyVXHAxpMjAXBcJuW9
 GK4wnRk4FmjrY7qJDhjWpH9IUNMNK73BWgTL/qSGspK6xcSvlCVz66bI699f57btzhf0
 p1/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768326385; x=1768931185;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=LB5E8yk0r0v263JhRoEfOFAOrpAetthgB9l/7ZLB53s=;
 b=RZCuub7CKC4ZubBdfLXujyrtAp82vwqOoUMX+4PfxchMqHfjc7pbubJJq1kcto8Nd9
 6ib45uWJ21XGCi+riGIEQYLymsSoEWJuMTky6DvcUJCjx67RMLwe1lRWoadswcSLOuc4
 /uLllhX7dNigFwakqrNOSTRN/uheCxf6OLeJr2vwj2Ma0QKanzZa+Q3OwtKD5gyZT6y+
 1bfP3mkoBIKIN+3ayO0VXnO3Bhj0PCbVFtnQ4nhWfLnVpAxuCAq5wEbPojnoYtjwn9uC
 d6/HpDOehNPl1nX0TbRb6z4HROKNHfTFT4o7Rc711jTUqQIwrG1Xumbw9lz/olMohhS2
 Gv+Q==
X-Gm-Message-State: AOJu0YzZJNKbGI6il3NlAcMX0+KbgPopimtoApbsEpS4BUBGO8kDEVoL
 CeOEtTEdiVjaUtEjV8lL408L2nQ0/DhjlbXWp9W70LtikUrrohjCc9NtvW/aXtmU9Fw=
X-Gm-Gg: AY/fxX6Z1tmDRF+LwzN0NJFv8kRHMx/0NmNx7+5pZKsNkjCAKN9IRd26EvXJzvZGPGP
 pYObQFQ1fvER6uTaE1C8lR+8VwHfGaGPEmObVgdi981J0GdvaXBh4VLEWgXXsxHafIG5X6WAA1l
 hfWp+HhaF31NPMmBX2WpFZQCqSh5unQW8W84D0w3nVtg7UT+Ay5QKzI8xM6egEUbaEmhIFQWI8o
 IpJdP5ar0aspGnrCAoASah40OV2AFmhZoK1zXJcIiRvmTZGc4D2XEbpPAYwp7xjJ0byBYR6PNrq
 Dn0S6RDLyqGu5CRzqxCqLSkziTQQsdmYQqL1mx7gJ2wOhVyUGWLGQ8nDjqOHG6AOqraOfVn7ZC9
 h4R3PEYF3MjnVgjYjOoxxfLrtiMQQjIpnxN15YGIXyAb13OrFKnDz6BKFhGL21tpQtDfumVS+Un
 RDA9SevIWSnBUzKtYYB2GkjDbwGnqCx6DQ4bpPjLdsWQMClA7h1Ulo
X-Google-Smtp-Source: AGHT+IEmdQZr7m4NO/nqDILqKwogx5erLzJQn6PL7JDg0GrOKgMoCIrkUXkCJ6YHslF1lI/UamuNrA==
X-Received: by 2002:a05:6000:438a:b0:432:c0e6:cfc0 with SMTP id
 ffacd0b85a97d-432c3778dd3mr28578840f8f.57.1768326384580; 
 Tue, 13 Jan 2026 09:46:24 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5ee893sm44998597f8f.37.2026.01.13.09.46.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 09:46:24 -0800 (PST)
Date: Tue, 13 Jan 2026 09:46:19 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukas Sismis <sismis@dyna-nic.com>
Cc: dev@dpdk.org
Subject: Re: [RFC PATCH v2 0/7] flow_parser: add shared parser library
Message-ID: <20260113094619.14ab23ce@phoenix.local>
In-Reply-To: <20260106153838.398033-1-sismis@dyna-nic.com>
References: <20260106153838.398033-1-sismis@dyna-nic.com>
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

On Tue,  6 Jan 2026 16:38:30 +0100
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
> The library (librte_flow_parser) exposes:
> - rte_flow_parser_parse(): Parse command strings into structured output
> - rte_flow_parser_parse_attr_str(): Parse attributes only
> - rte_flow_parser_parse_pattern_str(): Parse patterns only
> - rte_flow_parser_parse_actions_str(): Parse actions only
>=20
> Testpmd is updated to use the shared library, ensuring a single
> maintained parser implementation.
>=20
> Testing
> -------
> - Unit tests: flow_parser_autotest, flow_parser_helpers_autotest
> - Example application: examples/flow_parsing
> - All existing testpmd flow commands work unchanged
>=20
>=20
>=20
> [1] https://github.com/OISF/suricata/pull/13950
> =20
> Lukas Sismis (7):
>   flow_parser: add shared parser library
>   app/testpmd: integrate shared flow parser library
>   examples/flow_parsing: add flow parser demo
>   test: add flow parser unit tests
>   doc: add flow parser library maintainers
>   dts: fix invalid f-string syntax in testpmd API
>   cmdline: include stddef.h before defining offsetof
>=20
>  .mailmap                                      |     2 +-
>  MAINTAINERS                                   |     3 +
>  app/test-pmd/cmd_flex_item.c                  |    41 +-
>  app/test-pmd/cmdline.c                        |   254 +-
>  app/test-pmd/config.c                         |   112 +-
>  app/test-pmd/flow_parser.c                    |   406 +
>  app/test-pmd/flow_parser.h                    |     8 +
>  app/test-pmd/flow_parser_cli.c                |   149 +
>  app/test-pmd/meson.build                      |     5 +-
>  app/test-pmd/testpmd.c                        |     4 +
>  app/test-pmd/testpmd.h                        |   126 +-
>  app/test/meson.build                          |     1 +
>  app/test/test_flow_parser.c                   |   226 +
>  doc/guides/prog_guide/flow_parser_lib.rst     |   140 +
>  doc/guides/prog_guide/index.rst               |     1 +
>  doc/guides/rel_notes/release_26_03.rst        |     9 +
>  dts/api/testpmd/__init__.py                   |     8 +-
>  examples/flow_parsing/main.c                  |   345 +
>  examples/flow_parsing/meson.build             |    11 +
>  examples/meson.build                          |     1 +
>  lib/cmdline/cmdline_parse.h                   |     2 +
>  lib/ethdev/rte_ethdev.c                       |   107 +
>  lib/ethdev/rte_ethdev.h                       |    60 +
>  lib/flow_parser/meson.build                   |     6 +
>  .../flow_parser/rte_flow_parser.c             | 10774 ++++++++--------
>  lib/flow_parser/rte_flow_parser.h             |  1304 ++
>  lib/meson.build                               |     2 +
>  27 files changed, 8600 insertions(+), 5507 deletions(-)
>  create mode 100644 app/test-pmd/flow_parser.c
>  create mode 100644 app/test-pmd/flow_parser.h
>  create mode 100644 app/test-pmd/flow_parser_cli.c
>  create mode 100644 app/test/test_flow_parser.c
>  create mode 100644 doc/guides/prog_guide/flow_parser_lib.rst
>  create mode 100644 examples/flow_parsing/main.c
>  create mode 100644 examples/flow_parsing/meson.build
>  create mode 100644 lib/flow_parser/meson.build
>  rename app/test-pmd/cmdline_flow.c =3D> lib/flow_parser/rte_flow_parser.=
c (57%)
>  create mode 100644 lib/flow_parser/rte_flow_parser.h
>=20

Looks OK to me, so asked AI for second opinion.
It saw some things that do need to be fixed.


# DPDK Patch Review: Flow Parser Library (v2)

**Series:** `[PATCH v2 0/7]` flow_parser: add shared parser library =20
**Author:** Lukas Sismis <sismis@dyna-nic.com> =20
**Date:** Tue, 6 Jan 2026 =20
**Reviewer:** AI Code Review Tool

---

## Series Overview

This patch series introduces `librte_flow_parser` as an optional, experimen=
tal library that exposes the testpmd flow CLI parser as a reusable componen=
t. The series is well-structured:

| Patch | Description |
|-------|-------------|
| 1/7 | Core library implementation (~15K lines) |
| 2/7 | testpmd integration - removes embedded parser, uses library |
| 3/7 | Example application demonstrating library usage |
| 4/7 | Unit tests for the parser |
| 5/7 | MAINTAINERS and .mailmap updates |
| 6/7 | DTS f-string syntax fix (tangential bugfix) |
| 7/7 | cmdline stddef.h include fix (tangential bugfix) |

---

## Errors (Must Fix)

### 1. Missing Copyright Lines in New Files

**Severity:** Error =20
**Rule:** SPDX license identifier must be followed by copyright notice =20
**Location:** Multiple files

Per DPDK guidelines, every source file must have SPDX identifier followed b=
y copyright:

**`lib/flow_parser/rte_flow_parser.h`** (Patch 1):
```c
/* SPDX-License-Identifier: BSD-3-Clause */
#ifndef RTE_FLOW_PARSER_H
```
Missing: `Copyright(c) 2026 Dyna-NIC` line after SPDX

**`app/test/test_flow_parser.c`** (Patch 4):
```c
/* SPDX-License-Identifier: BSD-3-Clause */

#include <stdint.h>
```
Missing: Copyright line after SPDX

**Recommended fix:**
```c
/* SPDX-License-Identifier: BSD-3-Clause
 * Copyright(c) 2026 Dyna-NIC
 */
```

---

### 2. Subject Lines Exceed 60 Characters

**Severity:** Error =20
**Rule:** Subject line maximum 60 characters =20
**Location:** Patches 2 and 7

| Patch | Length | Subject |
|-------|--------|---------|
| 2/7 | **64** | `[PATCH v2 2/7] app/testpmd: integrate shared flow parser =
library` |
| 7/7 | **65** | `[PATCH v2 7/7] cmdline: include stddef.h before defining =
offsetof` |

**Recommended fixes:**
- Patch 2: `app/testpmd: use shared flow parser library` (47 chars with pre=
fix)
- Patch 7: `cmdline: include stddef.h for offsetof` (54 chars with prefix)

---

## Warnings (Should Fix)

### 3. Implicit Pointer/Integer Comparisons

**Severity:** Warning =20
**Rule:** Compare pointers explicitly with NULL, integers with zero =20
**Location:** `lib/flow_parser/rte_flow_parser.c`

Multiple instances use `!ptr` instead of `ptr =3D=3D NULL`:

```c
// Current (non-compliant):
if (!data)
if (!ipv4->version_ihl)
if (!ops || !ops->port_validate)
if (!conf->select_ipv4)

// Should be:
if (data =3D=3D NULL)
if (ipv4->version_ihl =3D=3D 0)
if (ops =3D=3D NULL || ops->port_validate =3D=3D NULL)
if (conf->select_ipv4 =3D=3D 0)
```

Affected locations include lines: 767, 783, 943, 999, 1012, 1053, 1091, 110=
4, 1167, 1381, 1390, 1393, 1658, 1668, 1678, 1688, 1699, 1709, 1720, 1730, =
and many more.

---

### 4. Missing Newline at End of File (Cross-Patch Fix)

**Severity:** Warning =20
**Rule:** Files must end with a newline =20
**Location:** `app/test-pmd/flow_parser.h`

Patch 2 creates this file without a trailing newline:
```
-#endif /* _TESTPMD_FLOW_PARSER_H_ */
\ No newline at end of file
```

Patch 3 fixes it, but each commit should compile independently. The fix sho=
uld be in Patch 2.

---

### 5. MAINTAINERS Entry Missing Explicit Maintainer

**Severity:** Warning =20
**Rule:** New subsystems should have release notes and maintainer entries =
=20
**Location:** `MAINTAINERS`

The update adds files to the Flow API section:
```
F: lib/flow_parser/
F: app/test-pmd/flow_parser.c
F: doc/guides/prog_guide/flow_parser_lib.rst
```

However, no explicit `M:` (maintainer) entry is added. Consider adding:
```
Flow Parser Library
M: Lukas Sismis <sismis@dyna-nic.com>
F: lib/flow_parser/
F: doc/guides/prog_guide/flow_parser_lib.rst
```

---

## Info (Consider)

### 6. Unrelated Fixes Bundled in Series

Patches 6/7 and 7/7 fix issues unrelated to the flow parser:
- Patch 6: DTS f-string syntax fix
- Patch 7: cmdline stddef.h include

These should ideally be separate patch submissions with their own `Fixes:` =
tags if they address regressions. If they're prerequisites for the flow par=
ser, this should be documented.

---

### 7. Code Structure Positive Notes

The series demonstrates good practices:

=E2=9C=93 New APIs marked as `__rte_experimental` (correctly on separate li=
nes in headers) =20
=E2=9C=93 Release notes updated (`doc/guides/rel_notes/release_26_03.rst`) =
=20
=E2=9C=93 Documentation added (`doc/guides/prog_guide/flow_parser_lib.rst`)=
 =20
=E2=9C=93 Unit tests added (`app/test/test_flow_parser.c`) =20
=E2=9C=93 Example application provided (`examples/flow_parsing/`) =20
=E2=9C=93 Proper use of `RTE_EXPORT_EXPERIMENTAL_SYMBOL` =20
=E2=9C=93 Thread-local storage for helper functions =20
=E2=9C=93 Commit messages don't start with "It"

---

## Checklist Summary

| Category | Status |
|----------|--------|
| SPDX + Copyright | =E2=9D=8C Missing copyright in 2 files |
| Subject line =E2=89=A460 chars | =E2=9D=8C 2 patches exceed limit |
| Subject lowercase (except acronyms) | =E2=9C=93 |
| Correct component prefix | =E2=9C=93 |
| Body =E2=89=A475 chars | =E2=9C=93 |
| Signed-off-by present | =E2=9C=93 |
| __rte_experimental placement | =E2=9C=93 |
| New APIs experimental | =E2=9C=93 |
| Release notes | =E2=9C=93 |
| Documentation | =E2=9C=93 |
| Tests added | =E2=9C=93 |
| Explicit comparisons | =E2=9D=8C Multiple implicit comparisons |
| Each commit compiles | =E2=9A=A0=EF=B8=8F Missing newline issue |

---

## Recommended Actions for v3

1. **Add copyright lines** to `rte_flow_parser.h` and `test_flow_parser.c`
2. **Shorten subject lines** for patches 2 and 7
3. **Fix newline** at end of `flow_parser.h` in patch 2 (not patch 3)
4. **Consider** adding explicit `M:` entry in MAINTAINERS
5. **Consider** splitting patches 6-7 into separate series or adding depend=
ency notes
6. **Consider** converting implicit comparisons to explicit style (lower pr=
iority, many occurrences)

---

*Review generated based on DPDK AGENTS.md guidelines*


