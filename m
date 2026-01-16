Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7560D4A602
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Jan 2026 06:01:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B94F0427D3;
	Fri, 16 Jan 2026 07:01:29 +0100 (CET)
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45]) by mails.dpdk.org (Postfix) with ESMTP id 6D3C24014F
 for <dev@dpdk.org>; Fri, 16 Jan 2026 07:01:28 +0100 (CET)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-47ee807a4c5so12280455e9.2
 for <dev@dpdk.org>; Thu, 15 Jan 2026 22:01:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768543288;
 x=1769148088; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUNkwChANDDMddHDzLlbq5bGCPEahpKLwF+01yEhfgI=;
 b=vxAmYmitvgUFPrNOXO2C7ql826CqoNDenBHbPEcstyVrkT9lZ9h8lTvHnvKnCCpBYP
 X3AA2CVjt46Y80K2J7AMHStWJn4tmVHEAawPSyQVAEfjaWeug81bm8cr8XC+wfLSSf+Z
 6lKqUr1wLp/cS+/Yn5m5mtWycyryzADh+wJwIcYpHJo5gC5hLPEZVmTkaJFAGvIuMiWi
 QcjXOD6SpJszRO7NBAFC6BJbIgano8Ot2Meg/UbibiitCU1Xwvp8uya5y2Znew/xBG4Q
 JypEsWKSuya9p92Ge5kiu+sKdtoQMDQPkyeCkGXyKj6oGM1mAAZkzA1F4DllRIdlb8XO
 rD8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768543288; x=1769148088;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VUNkwChANDDMddHDzLlbq5bGCPEahpKLwF+01yEhfgI=;
 b=rBBBqrW8DjkMLJT/2hrN748PgD56uWr1EnL25aBiVsbysH+vrnvWMAZikUSnC5BXej
 d/TbKpDgrpWk0j/slOEmwZtJCKIY5VOfpOffGxCao9ydIu9XIwN2thhR2k9wRRLLQYia
 4crPJ6RtqYDeUmzBH+H++ekTIJYSwtXJwf29+AqrNLdnY9bdmFQWRtGL2fuk8CzhBxdk
 Yaons+m8ScAsUEM5K1XCq2Ed1KNbe8XHEJOmTfW8kMBcF2r6jcfkomxP7KicwNnLt27h
 cSV7nB25tUktRL4sEyCp/TmK84nsIwFNnpVfxkZ7gZRoAsZbNw06l41q61rjA5uQ7jws
 t29w==
X-Gm-Message-State: AOJu0YySvTBbRV/GnBNZgCPle9EH0mAGhVKWnExDg4fnyszT0y8HFmu0
 F3bOmX2Yy+CqItbRTr+Oano7m7Y1G0+yqvN5Ogc8Ntrtz/m0B9rmgrbSEoAYrEb0Dyc=
X-Gm-Gg: AY/fxX4w0RRtJHfPZHama0WhQ8GPB3dG4lpGHYg+z1Bfh0br0zOzToO59+1hbSAZRRm
 Udgr30HkG7ciQc3lNQ0g6ELibW86AxU+wLRC4CN5xLsgM/2B/HXwm4No0TcFC5GWbJ/6bm3yGQd
 sJa2j1yPAa82jkBYkNCnqu/mI+JRD6lhV8YHv1mAZiJIJs+dxjkJONrt07krpFwF1D2JPoVRVji
 Q20zcypImu1HyuqdsYTdNUmfmmj/xonILYUvmVEiyDf/qHFC3UjFdQTo16rj+snxLAmgDW9q8dd
 odUKHwCgEEkF9SH3Gk8DmVDC3874znTJwywOGgIXMGnhntUP80chj1Tejmfknvf3ZuKjjDH6erD
 4UQ38wE4Tqx5G0IXNM5IIFY3p1c6TZ0kqxVNFLeIEEynuyRVf+JQ3CG+C1fy2HDE3odwubadYod
 oz5yHHGGJ870xn8odSpiF/YYuS0FqjzqapWDVzLbO+nHiRSmErQGXn
X-Received: by 2002:a05:600c:4e0f:b0:47e:e779:36e with SMTP id
 5b1f17b1804b1-4801eb0375amr15110085e9.19.1768543287788; 
 Thu, 15 Jan 2026 22:01:27 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801fe2c04bsm8829045e9.8.2026.01.15.22.01.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 22:01:27 -0800 (PST)
Date: Thu, 15 Jan 2026 22:01:22 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Lukas Sismis <sismis@dyna-nic.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v3 0/7] flow_parser: add shared parser library
Message-ID: <20260115220122.36e79c67@phoenix.local>
In-Reply-To: <cover.1768518003.git.sismis@dyna-nic.com>
References: <cover.1768518003.git.sismis@dyna-nic.com>
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

On Fri, 16 Jan 2026 00:01:06 +0100
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
> The library (librte_flow_parser) exposes, among others, the following API=
s:
> - rte_flow_parser_parse(): Parse command strings into structured output
> - rte_flow_parser_parse_attr_str(): Parse attributes only
> - rte_flow_parser_parse_pattern_str(): Parse patterns only
> - rte_flow_parser_parse_actions_str(): Parse actions only
>=20
> Testpmd is updated to use the shared library, ensuring a single
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
> Lukas Sismis (7):
>   cmdline: include stddef.h for offsetof
>   flow_parser: add shared parser library
>   app/testpmd: use shared flow parser library
>   examples/flow_parsing: add flow parser demo
>   dpdk-test: add flow parser library functional tests
>   mailmap: update a new contributor email
>   dts: fix invalid f-string syntax in testpmd API
>=20
>  .mailmap                                      |     2 +-
>  MAINTAINERS                                   |     6 +-
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
>  app/test/test_flow_parser.c                   |   698 +
>  doc/guides/prog_guide/flow_parser_lib.rst     |   140 +
>  doc/guides/prog_guide/index.rst               |     1 +
>  doc/guides/rel_notes/release_26_03.rst        |     9 +
>  dts/api/testpmd/__init__.py                   |     8 +-
>  examples/flow_parsing/main.c                  |   288 +
>  examples/flow_parsing/meson.build             |    11 +
>  examples/meson.build                          |     1 +
>  lib/cmdline/cmdline_parse.h                   |     2 +
>  lib/ethdev/rte_ethdev.c                       |   107 +
>  lib/ethdev/rte_ethdev.h                       |    60 +
>  lib/flow_parser/meson.build                   |     6 +
>  .../flow_parser/rte_flow_parser.c             | 11320 ++++++++--------
>  lib/flow_parser/rte_flow_parser.h             |  1306 ++
>  lib/meson.build                               |     2 +
>  27 files changed, 9300 insertions(+), 5773 deletions(-)
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
>=20

Overall looks good, some AI comments.


---

## DPDK Patch Review: flow_parser library v3 (7 patches)

### Overview
This series introduces `librte_flow_parser` as an experimental library expo=
sing the testpmd flow CLI parser as a reusable component, along with suppor=
ting changes.

---

## Patch 1/7: `cmdline: include stddef.h for offsetof`

### Commit Message =E2=9C=85
| Criteria | Status | Notes |
|----------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 Pass | 41 characters |
| Lowercase after colon | =E2=9C=85 Pass | "include stddef.h..." |
| Correct prefix | =E2=9C=85 Pass | `cmdline:` is correct for lib/cmdline |
| Imperative mood | =E2=9C=85 Pass | "include" is imperative |
| No trailing period | =E2=9C=85 Pass | |
| Body =E2=89=A475 chars | =E2=9C=85 Pass | |
| Signed-off-by | =E2=9C=85 Pass | Present with valid name/email |

### Code =E2=9C=85
- Simple, correct fix
- No issues identified

**Verdict: PASS** - Ready to merge

---

## Patch 2/7: `flow_parser: add shared parser library`

### Commit Message

| Criteria | Status | Notes |
|----------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 Pass | 38 characters |
| Lowercase after colon | =E2=9C=85 Pass | |
| Correct prefix | =E2=9C=85 Pass | `flow_parser:` for new lib |
| Body =E2=89=A475 chars | =E2=9C=85 Pass | |
| Signed-off-by | =E2=9C=85 Pass | |

**=E2=9A=A0=EF=B8=8F Warning (typo in body):** Line 212 has "Lightweigth" =
=E2=86=92 should be "Lightweight"

### License/Copyright =E2=9C=85

| File | SPDX | Copyright | Blank line |
|------|------|-----------|------------|
| rte_flow_parser.c | =E2=9C=85 BSD-3-Clause | =E2=9C=85 "Copyright 2026 Dy=
na-NIC" | =E2=9C=85 |
| rte_flow_parser.h | =E2=9C=85 BSD-3-Clause | =E2=9C=85 "Copyright(c) 2026=
 Dyna-NIC" | =E2=9C=85 |
| meson.build | =E2=9C=85 BSD-3-Clause | N/A (scripts don't require) | =E2=
=9C=85 |

### API Tags =E2=9C=85

- All new APIs correctly marked `__rte_experimental`
- `__rte_experimental` appears alone on line preceding return type (verifie=
d in header)
- Proper `RTE_EXPORT_EXPERIMENTAL_SYMBOL` usage in .c file

### Code Style

| Criteria | Status | Notes |
|----------|--------|-------|
| Lines =E2=89=A4100 chars | =E2=9C=85 Pass | |
| rte_ prefix on symbols | =E2=9C=85 Pass | All external symbols use `rte_f=
low_parser_*` |
| Header guards | =E2=9C=85 Pass | `RTE_FLOW_PARSER_H` |
| Include order | =E2=9C=85 Pass | System, then DPDK, then local |

### Documentation =E2=9C=85

- =E2=9C=85 Programmer's guide added (`doc/guides/prog_guide/flow_parser_li=
b.rst`)
- =E2=9C=85 Release notes updated (`doc/guides/rel_notes/release_26_03.rst`)
- =E2=9C=85 MAINTAINERS updated
- =E2=9C=85 Doxygen comments for public APIs

### Structure Concerns

**=E2=9A=A0=EF=B8=8F Warning:** New ethdev APIs added in this patch:
- `rte_eth_rss_type_info_get()`
- `rte_eth_rss_type_from_str()`
- `rte_eth_rss_type_to_str()`
- New typedefs: `rte_port_id_t`, `rte_queue_id_t`

These ethdev additions should ideally be in a separate patch for easier rev=
iew and bisectability.

**=E2=9A=A0=EF=B8=8F Warning:** The new ethdev APIs (`rte_eth_rss_type_*`) =
are marked experimental but should have testpmd hooks and tests per DPDK gu=
idelines.

### Meson Build =E2=9C=85

```python
# SPDX-License-Identifier: BSD-3-Clause

sources =3D files('rte_flow_parser.c')
headers =3D files('rte_flow_parser.h')

deps +=3D ['cmdline', 'ethdev']
```
- 4-space indentation =E2=9C=85
- Short lists on single line =E2=9C=85

**Verdict: PASS with warnings**

---

## Patch 3/7: `app/testpmd: integrate flow parser library`

### Commit Message =E2=9C=85
| Criteria | Status | Notes |
|----------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 Pass | 43 characters |
| Correct prefix | =E2=9C=85 Pass | `app/testpmd:` |
| Signed-off-by | =E2=9C=85 Pass | |

This is a large refactoring patch that moves code from testpmd to the new l=
ibrary. The changes look appropriate for the integration.

**Verdict: PASS**

---

## Patch 4/7: `examples/flow_parsing: add flow parser demo`

### Commit Message =E2=9C=85
| Criteria | Status | Notes |
|----------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 Pass | 42 characters |
| Correct prefix | =E2=9C=85 Pass | `examples/flow_parsing:` |
| Signed-off-by | =E2=9C=85 Pass | |

### License =E2=9C=85
- SPDX-License-Identifier: BSD-3-Clause on line 1
- Copyright on line 2
- Blank line before code

### Code =E2=9C=85
- Good example demonstrating the API
- Proper include order
- Comments explain the purpose

**Verdict: PASS**

---

## Patch 5/7: Copyright attribution fix

This patch updates copyright attribution in rte_flow_parser.c to include or=
iginal authors (6WIND, Mellanox) since the code derives from testpmd's cmdl=
ine_flow.c.

**Verdict: PASS** - Good practice to maintain attribution

---

## Patch 6/7: `mailmap: update contributor email`

### Commit Message

| Criteria | Status | Notes |
|----------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 Pass | 29 characters |
| Correct prefix | =E2=9C=85 Pass | `mailmap:` |
| Signed-off-by | =E2=9C=85 Pass | |

**=E2=9D=8C Error:** Commit body is empty. Per AGENTS.md guidelines, the bo=
dy should describe the change.

**Recommendation:** Add body text like:
```
Update email address for Lukas Sismis from cesnet.cz to dyna-nic.com.
```

**Verdict: NEEDS WORK** - Add commit body

---

## Patch 7/7: `dts: fix invalid f-string syntax in testpmd API`

### Commit Message =E2=9C=85

| Criteria | Status | Notes |
|----------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=85 Pass | 50 characters |
| Correct prefix | =E2=9C=85 Pass | `dts:` |
| Fixes tag | =E2=9C=85 Pass | Present with 12-char SHA |
| Cc: stable@dpdk.org | =E2=9C=85 Pass | Present for bug fix |
| Tag order | =E2=9C=85 Pass | Fixes, Cc, blank line, Signed-off-by |
| Signed-off-by | =E2=9C=85 Pass | |

### Code =E2=9C=85
The fix changes `""` to `''` inside f-strings, which is correct. Python f-s=
trings require the inner quotes to differ from outer quotes.

**Verdict: PASS**

---

## Summary

| Patch | Status | Issues |
|-------|--------|--------|
| 1/7 cmdline | =E2=9C=85 PASS | None |
| 2/7 flow_parser | =E2=9A=A0=EF=B8=8F PASS | Typo "Lightweigth", ethdev AP=
Is should be separate patch |
| 3/7 testpmd integration | =E2=9C=85 PASS | None |
| 4/7 example | =E2=9C=85 PASS | None |
| 5/7 copyright | =E2=9C=85 PASS | None |
| 6/7 mailmap | =E2=9D=8C NEEDS WORK | Missing commit body |
| 7/7 dts fix | =E2=9C=85 PASS | None |

### Required Fixes
1. **Patch 6/7:** Add commit message body describing the email update

### Recommended Improvements
1. **Patch 2/7:** Fix typo "Lightweigth" =E2=86=92 "Lightweight" in commit =
body
2. **Patch 2/7:** Consider splitting ethdev API additions (`rte_eth_rss_typ=
e_*`, typedefs) into a separate prerequisite patch
3. **Patch 2/7:** Ensure new ethdev APIs have corresponding tests
