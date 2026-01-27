Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1141AD2FEF3
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 22:18:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0A13640F1A;
	Tue, 27 Jan 2026 23:18:14 +0100 (CET)
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51]) by mails.dpdk.org (Postfix) with ESMTP id 94B3040E21
 for <dev@dpdk.org>; Tue, 27 Jan 2026 23:18:12 +0100 (CET)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-47ee974e230so53837895e9.2
 for <dev@dpdk.org>; Tue, 27 Jan 2026 14:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769552292;
 x=1770157092; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a6wQXyiF57OGFx4S/vGOmz/qa+z9Z8+qB7g1CRMtV6I=;
 b=Qf/7iYoT/iys5PcLTOMKj0Fj21yRIJY3gmcrFm33OYiw5kG5d2/sYMuGjfwMU2HscY
 FWGj2u5E1yadbgSuJYgvK2LhRRSdxDD0nQJ3zfyqmR2q60TqW1tq0vr/fIgXwfVKMrcF
 w7hWIBGJ9gN9sYFzkVSt9t/8LrqL32qZG8Bo0XyBo3gaaPJqTC5ByvYt2jEa2FNJm5Q3
 G1adDQUOVJYVnaBrmbz3HKTXH1MpfypuxvqOX6FfgJw8ZL98nAmrnCG/JZ8D+wI3HZk8
 RFJE/SrXIlROC0h78n/ubakJEeZfHWZR0h4BwnslPHOk+oqQdEHOlZSEVk/cGGA81fd5
 seEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769552292; x=1770157092;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a6wQXyiF57OGFx4S/vGOmz/qa+z9Z8+qB7g1CRMtV6I=;
 b=u2rTlenkukitQLI0HfOsYOfQXK9RP8fM45o5VczeOUM28b29kFKQreuKUR3Wuwkj7F
 EWPPwyrjJK+NLv81JEXPOhATnUuWQV8OxIuL+ggSg0NkBiK0rZysfhRRDifFTuofrwQx
 A+nh7vqPKe8VVkcidQ401zyxZRSsWfZP3I3j6kLa9Rq1+jagB2y2FKs1zMJFBNNyr33q
 nFm03UIiMKm7ej6p18j2q1B4zW4Ks88v/RFpdTF3p+Ze8n4j8PIcgAAQq3ojBI3AH17e
 2HABIFfSy++Sn1+6qV8qGCda1opSPeVzbSgYBxCZsC7fYeb/PF9hu3pLLEuYXCPOxeUv
 ecJw==
X-Gm-Message-State: AOJu0YwIS56xSm8EvuvT4N1WG5yGP66MtPVBijhn4uBL+aRgWLyGQMBR
 PncFKQqM/K7s96a2Jir4memdS99vVXMbBBxAl2L1pmqticzhteAbxNnguOzSImbOV5M=
X-Gm-Gg: AZuq6aJzaynQhyCvP7PWDZNsnNPKDjE/kCl/qumWwLR1i96q9maWa+cfB7Ad5b6OqUd
 VTJh7PCZeelBmxu8BYCn0os9nzigWow1gT8qz44gIqmwNmTXTIFsACREfBC4QrRGbyq3OW3e05u
 tgbVN7BzYhRlfxGO2lD80JpoOog/fCEYIWYSldEcxSyxio583fXgJdCzI9l+LjlDwyarD0MvFSh
 eRTzWk3t71Srgzq5c4qov1ybar4JVTg1CEMWwc93LKBv3I53AO2ja9kUnPq8LaeYgd4Q+qUpd9d
 yJipw6MYyCZVE9VkEyZaF3k+KAVY/F26fxhat2xGg4wRjpnFYT6lmgRQB8wwwnyS/4ZhwMqUbTu
 QhMRFwwJyzgc/R0FjJfBVbWvuHP5sCie7Jypt+YbSJwyo+uvGkFsMC2+qcuqhoGMCZBcz6l4eDx
 Fd6UEyBaOYjCeq+BEJBrfOZfqB5lVBREaxLXcXy/csA//Cs1xVvxCR
X-Received: by 2002:a05:600c:3b96:b0:46e:4e6d:79f4 with SMTP id
 5b1f17b1804b1-48069c353ffmr50453185e9.15.1769552291757; 
 Tue, 27 Jan 2026 14:18:11 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48066c4f3edsm84945485e9.15.2026.01.27.14.18.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 14:18:11 -0800 (PST)
Date: Tue, 27 Jan 2026 14:18:05 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukas Sismis <sismis@dyna-nic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v6 0/6] flow_parser: add shared parser library
Message-ID: <20260127141805.2ca41224@phoenix.local>
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

Automated review is now happy, and the bot is certainly pickier than me :-)
The word fixes in changelog tends to be treated special by check-git-log,
checkpatches and the AGENTS file.

Series-acked-by: Stephen Hemminger <stephen@networkplumber.org>

---

## DPDK Patch Review: flow_parser v6

### Summary

This is a 6-patch series that extracts the testpmd flow CLI parser into a r=
eusable library (`librte_flow_parser`). Comparing v6 to v5, the changelog c=
laims several fixes were addressed.

---

### Patch 1/6: `cmdline: include stddef.h for MSVC compatibility`

**Commit Message**: =E2=9C=85 Good
- Subject: 49 chars, lowercase, proper `cmdline:` prefix
- Body wrapped correctly, describes the change well
- Has `Signed-off-by`

**Issue (Warning)**: The v6 changelog claims "Fixes Tag added to MSVC build=
 commit", but **no Fixes tag is present** in the commit message. Since this=
 is a preventive compatibility improvement rather than fixing a specific re=
gression, a Fixes tag may not be required. However, the changelog descripti=
on is misleading.

**Code**: =E2=9C=85 Simple, correct change adding `#include <stddef.h>` bef=
ore the fallback `offsetof` macro.

---

### Patch 2/6: `ethdev: add RSS type helper APIs`

**Commit Message**: =E2=9C=85 Good
- Subject: 36 chars, correct prefix
- Has release notes update

**Code**: =E2=9C=85=20
- New APIs properly marked `__rte_experimental`
- Unit tests added in `test_ethdev_api.c`
- Includes `rte_port_id_t` and `rte_queue_id_t` typedefs

---

### Patch 3/6: `flow_parser: add shared parser library`

**Commit Message**: =E2=9C=85 Good
- Subject: 42 chars, correct prefix
- Comprehensive description of the library design
- Has release notes, documentation, and MAINTAINERS update

**Code Review**:

| Check | Status |
|-------|--------|
| SPDX license | =E2=9C=85 Present on all new files |
| Header guards | =E2=9C=85 Standard format (`_RTE_FLOW_PARSER_H_`) |
| `__rte_experimental` markers | =E2=9C=85 All public APIs marked |
| Naming conventions | =E2=9C=85 All public symbols use `rte_` prefix |
| Documentation | =E2=9C=85 `flow_parser_lib.rst` added |

**Minor Observations**:
- Line 16018-16019: Header guards follow DPDK standard style
- Public API is minimal (4 functions) - good design
- Internal/private API properly separated in `rte_flow_parser_private.h`

---

### Patch 4/6: `app/testpmd: use shared flow parser library`

**Commit Message**: =E2=9C=85 Good
- Subject: 45 chars, proper `app/testpmd:` prefix

**Code**: =E2=9C=85
- Properly removes old `cmdline_flow.c` and adds new files
- Updates meson.build to depend on `flow_parser` library

---

### Patch 5/6: `examples/flow_parsing: add flow parser demo`

**Commit Message**: =E2=9C=85 Good
- Subject: 44 chars, proper `examples/flow_parsing:` prefix
- Includes build instructions

**Code**: =E2=9C=85
- SPDX license correct
- meson.build has `allow_experimental_apis =3D true`
- MAINTAINERS entry added

---

### Patch 6/6: `test: add flow parser library functional tests`

**Commit Message**: =E2=9C=85 Good
- Subject: 50 chars, proper `test:` prefix

**Code**: =E2=9C=85 Excellent test coverage
- Uses `TEST_ASSERT` macros as required by AGENTS.md
- Uses `unit_test_suite_runner` infrastructure
- `REGISTER_FAST_TEST` with proper flags
- Tests both public and internal APIs
- Includes invalid input/syntax tests

---

### V5 =E2=86=92 V6 Changes Verification

| Claimed Change | Verified? |
|----------------|-----------|
| "Inconsistent Experimental API Version adjusted" | =E2=9C=85 All `__rte_e=
xperimental` markers appear consistent |
| "Fixes Tag added to MSVC build commit" | =E2=9D=8C **Not present** - misl=
eading changelog |
| "Non-Standard Header Guards updated" | =E2=9C=85 Guards now use standard =
`_RTE_*_H_` format |
| "Implicit Pointer Comparison issues addressed" | =E2=9C=85 Old code had `=
!buf`, new code uses explicit `!=3D NULL` comparisons |

---

### Overall Assessment

**Ready for merge with one minor clarification needed:**

1. **Changelog accuracy** (Info): The v6 cover letter claims "Fixes Tag add=
ed to MSVC build commit" but patch 1/6 has no Fixes tag. The author should =
either add a Fixes tag if one applies, or correct the changelog. Since the =
change is a preventive improvement and not fixing a specific commit's regre=
ssion, no Fixes tag is likely needed - just update the changelog.

The patches are well-structured, follow DPDK coding standards, include prop=
er documentation, release notes, and comprehensive tests. The library desig=
n with a minimal public API and separated private headers is clean.
