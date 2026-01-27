Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 337C0D2FEDB
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 19:16:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6B90140F1A;
	Tue, 27 Jan 2026 20:16:09 +0100 (CET)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com
 [209.85.221.42]) by mails.dpdk.org (Postfix) with ESMTP id 0AB9740E21
 for <dev@dpdk.org>; Tue, 27 Jan 2026 20:16:08 +0100 (CET)
Received: by mail-wr1-f42.google.com with SMTP id
 ffacd0b85a97d-4327790c4e9so3935955f8f.2
 for <dev@dpdk.org>; Tue, 27 Jan 2026 11:16:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769541367;
 x=1770146167; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZOPZ/C2w+QxbWM9oFCd/61kNX6gtdUs+dCYGVYw5qK8=;
 b=tXBRNu5rFEp0704mKqWnWek4p0DcelVGlN3qb4pdTB2ICB4IPUwxE2kloVSbcdPVmA
 F4nw11qbPi5XORBd8QKWEIfpmUJHS7GcMMmN3V1h5IfJIECTtnFJZWXV6WRS065ntVIZ
 FlbmNfYNLsw5coMIXWeDm+hE810fLrisy3AuD8HP7LV3lmT985NKjjhlHudAbGgeG1Sf
 NN2AV9rW9JDWFqQ9XSOcllgoJvnEet6XwL6QCvdL1Ty2QRlejVkdIYH8T3cFVwTDWwhs
 2EDwdVmUTwuWSQadWIg5pRtzO46Nl2A1BU/YgNlE/5QaqARh8NGNxJKS3FMxXPvMo5lb
 q/+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769541367; x=1770146167;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZOPZ/C2w+QxbWM9oFCd/61kNX6gtdUs+dCYGVYw5qK8=;
 b=UXmvrcDZkLZwRp10emCWIOg5EVGeCcot0bbfCojKyYayUR2jntJHucUGVzqInIkwe+
 o6YEx1wZJ/jsHVEYq+i0JhbRofZfb5jDr1A0TDRGmsSXMDaE6ffw7lS6Gt6teyrRllcD
 QtOZdE48C6euBCqN76Jdc/DyPSZoT3rwgS6GYBKr9H1/UYQ3/5ciRspWoXwkpobsdTLI
 +MO5D5AnD0VbdzzFLJpIM7UdB4DVlzTstvlFStBbbqajbjHlAkRvEpaa7fO1PMwC2Z0k
 0J/F1rdLuBgwqb41nAhUBAYvOfOgPBSy3Ju8upc6aIKMvlW5r+fVqIRmB1mVySQdgwT2
 iwTw==
X-Gm-Message-State: AOJu0Yz/Kyqzx48pvGwQDN6zW74pMOcIP+PscGY+wffXVtwOatvd5wXy
 5Linb0XRj2JegEoGIohnB1EjX734F+Uj5NY7TNweGCJ0IoaDmNQwrsE+sPCP+1dXPUI=
X-Gm-Gg: AZuq6aK9uz+kkfpTuDjIEQJHEs5ObDqLm3tslgzB22RaO8gvsDRUBQ9D6XShLPYp7ph
 1P1AVQ8H4ygE+lBDR14Nvr0zrt+UU4beExvv37TD41z0lbv4aVFhpHyvx0xDpWddtpfvPyMhhwD
 fPVV2oHBwwW8+DMrDGZ+0R4UqxCymvecC77HBn6/dSTV/P9IW+ayftGFkQd8M1EUNbC15oJk3Fs
 rmVr3+O7+D44YVoypjgl6d0fDNLJlINqKnhb2ovFrMCWeZSagEzP0maERJRNp0MMY3zlF1OMt/a
 +84bjVWKdkscYpzygGlSFy8/YkdmZ4+vxeHHI3+01TgG5wVvilLtTSlkGE9yQqJQ6gMQYFVdAqE
 SwXBBfmT6gCnZNQIcMbYozk4gvRAJQAcE3wxOA6kCcWK2pQVTUvRG8geUlnWP7U3tmA8VKO+rhA
 iupyWrXqrUimaAwWQTfC6FwBEVfCn07Nt+y5r+ual/+kqXtVgDZIiZ
X-Received: by 2002:a05:6000:40cd:b0:435:a594:33dd with SMTP id
 ffacd0b85a97d-435dd1cd445mr4530011f8f.46.1769541367356; 
 Tue, 27 Jan 2026 11:16:07 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10edfccsm914174f8f.17.2026.01.27.11.16.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 11:16:06 -0800 (PST)
Date: Tue, 27 Jan 2026 11:16:01 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukas Sismis <sismis@dyna-nic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v5 0/6] flow_parser: add shared parser library
Message-ID: <20260127111601.71551d47@phoenix.local>
In-Reply-To: <20260127184738.200476-1-sismis@dyna-nic.com>
References: <20260127184738.200476-1-sismis@dyna-nic.com>
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

On Tue, 27 Jan 2026 19:47:31 +0100
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
>=20
> Lukas Sismis (6):
>   cmdline: include stddef.h for offsetof
>   ethdev: add RSS type helper APIs
>   flow_parser: add shared parser library
>   app/testpmd: use shared flow parser library
>   examples/flow_parsing: add flow parser demo
>   test: add flow parser library functional tests
>=20
>  MAINTAINERS                                   |     6 +-
>  app/test-pmd/cmd_flex_item.c                  |    41 +-
>  app/test-pmd/cmdline.c                        |   268 +-
>  app/test-pmd/config.c                         |   112 +-
>  app/test-pmd/flow_parser.c                    |   410 +
>  app/test-pmd/flow_parser.h                    |    12 +
>  app/test-pmd/flow_parser_cli.c                |   153 +
>  app/test-pmd/meson.build                      |     5 +-
>  app/test-pmd/testpmd.c                        |     4 +
>  app/test-pmd/testpmd.h                        |   126 +-
>  app/test/meson.build                          |     1 +
>  app/test/test_ethdev_api.c                    |    51 +
>  app/test/test_flow_parser.c                   |   922 ++
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
>  .../flow_parser/rte_flow_parser.c             | 11428 ++++++++--------
>  lib/flow_parser/rte_flow_parser.h             |   124 +
>  lib/flow_parser/rte_flow_parser_private.h     |  1247 ++
>  lib/meson.build                               |     2 +
>  29 files changed, 9710 insertions(+), 5833 deletions(-)
>  create mode 100644 app/test-pmd/flow_parser.c
>  create mode 100644 app/test-pmd/flow_parser.h
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


Semi-automated patch review still sees a few things that need to be fixed:


---

## Patch Series Review: [PATCH v5 1/6] - [PATCH v5 6/6] flow parser library

### Overview
This 6-patch series introduces a reusable flow parser library extracted fro=
m testpmd's cmdline_flow.c, adds RSS type helper APIs to ethdev, and includ=
es documentation, examples, and tests.

---

### **ERRORS** (must fix)

#### 1. Inconsistent Experimental API Version (Patch 3)
**Location:** `lib/flow_parser/rte_flow_parser.c` lines 15708-15730

The flow_parser library exports symbols with version `26.0`:
```c
RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_parser_init, 26.0);
```

But the ethdev patch (2/6) correctly uses `26.03`:
```c
RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_eth_rss_type_info_get, 26.03)
```

**Fix:** Change all `26.0` to `26.03` in the flow_parser exports for consis=
tency with the release version.

---

### **WARNINGS** (should fix)

#### 2. Missing Fixes Tag (Patch 1)
**Location:** Commit message of patch 1/6

The commit describes fixing "macro redefinition warnings when building with=
 MSVC" which sounds like a bug fix for existing code. If this is fixing a r=
egression, it should include:
```
Fixes: <12-char-sha> ("original commit that introduced the issue")
Cc: stable@dpdk.org
```

If it's a new enhancement for MSVC support rather than fixing a regression,=
 consider rewording the commit message to make that clearer.

#### 3. Non-Standard Header Guards (Patch 3)
**Location:** `rte_flow_parser.h` and `rte_flow_parser_private.h`

Current:
```c
#ifndef RTE_FLOW_PARSER_H
#define RTE_FLOW_PARSER_H
```

DPDK convention uses underscore prefix/suffix:
```c
#ifndef _RTE_FLOW_PARSER_H_
#define _RTE_FLOW_PARSER_H_
```

#### 4. Implicit Pointer Comparison (Patch 4)
**Location:** `app/test-pmd/flow_parser.c` (around line 17315)

```c
if (!out->args.vc.pattern || out->args.vc.pattern_n =3D=3D 0)
```

**Fix:** Use explicit comparison per DPDK style:
```c
if (out->args.vc.pattern =3D=3D NULL || out->args.vc.pattern_n =3D=3D 0)
```

---

### **INFO** (consider)

#### 5. Test Function Return Type (Patch 2)
**Location:** `app/test/test_ethdev_api.c` line 236

```c
static int32_t
ethdev_api_rss_type_helpers(void)
```

Using `int32_t` for test return types is unusual; `int` is more standard fo=
r test framework compatibility.

#### 6. Commit Message Style (Patch 6)
The commit body starts with "Tests cover:" which could be clearer. Consider:
```
Add functional tests for the flow parser library covering:
- success cases...
- fail cases...
```

#### 7. Long String Literal (Patch 6)
**Location:** `app/test/test_flow_parser.c` line 35128

One test string is 106 characters. This is acceptable for test data strings=
 that can't easily be split.

---

### **Positive Observations**

- All commit subject lines are well under 60 characters =E2=9C=93
- Commit message bodies properly wrapped at 75 characters =E2=9C=93
- SPDX headers present and correct =E2=9C=93
- Signed-off-by tags present =E2=9C=93
- New APIs properly marked as `__rte_experimental` =E2=9C=93
- Release notes updated in patch 2 and 3 =E2=9C=93
- Documentation added =E2=9C=93
- Tests added using proper TEST_ASSERT macros =E2=9C=93
- Meson build files properly formatted =E2=9C=93
- No printf/fprintf in library code (only in app/examples) =E2=9C=93
