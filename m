Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C58C98330
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Jan 2026 18:57:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2DACF40661;
	Sat, 17 Jan 2026 19:57:34 +0100 (CET)
Received: from mail-ed1-f66.google.com (mail-ed1-f66.google.com
 [209.85.208.66]) by mails.dpdk.org (Postfix) with ESMTP id B83544025E
 for <dev@dpdk.org>; Sat, 17 Jan 2026 19:57:33 +0100 (CET)
Received: by mail-ed1-f66.google.com with SMTP id
 4fb4d7f45d1cf-655ae329d6bso3265805a12.0
 for <dev@dpdk.org>; Sat, 17 Jan 2026 10:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768676253;
 x=1769281053; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=igVoPT7lnGa7EKJA/lebGpMRyB2ZEFHElRPpAcTqebU=;
 b=KZmUexPeU1Fp6S8+CNIqYtMDHqpCguNQoQ7Cva3yJIuXwAmb48OVwM39aPiVhhzWM6
 3oCSfOFWDYIMEGcGywPeYj9rzroGk47kCCwh4+8t53uT4J7GNalrz5l0Cnc8x29eIJnZ
 XxoJ1uUCSlV2+iTCJafJxrOIO1cTShgJDTEF1GXgzire/to5Sck/yM0LVvTgIL83CxlZ
 3PCck7qqj8005YLyDQh2QiguUokc7IFAAxIdCUUcrc8fw/zZWxdkRySFTGr+ALcZPPlf
 W/YC6RdDIprEtgjfo4Aw6yNaICYDwrbFYLOxK+VQ5cC2AJjlm38OnethDr+z399Drz4V
 pGHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768676253; x=1769281053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=igVoPT7lnGa7EKJA/lebGpMRyB2ZEFHElRPpAcTqebU=;
 b=V09DEAXRCYCF5RHbKZXSfTHbKnggYJYXrpQ5M4YP9Oe3XC/We0fZoTVjfLbaMO7lWs
 cXSWOeUEFtOypcbUXLFRJPQW1xinc5krSRIgaZe83KveRMab8sl6VuEhSHNQgzlxaTO/
 Fg8m9TKvmNZJaC2D+VMOjFMqm3oFRtc0Wyp1CByeuuX/gRasF2Buc7JiGuRlgjAraE2X
 Q/MuGPhVPJIu4P8/c43WuHnfL5JhiFNpCWcJnhE70nGVnWdUr/Q4lLMDw+YvvA0c0xgK
 RWmD3E6Ljg53oWW6zA7aOgTOFCDMcGBIrHqf2XLphHuHeIXrpOjDGLTUmQePXGLRRF1B
 gUPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQbBquyrdEg6k2dgsBABsZr4Ne4LHA/JAnG9fkmSCbBrirpCaNDy3uGlDy/M43RmxvP8I=@dpdk.org
X-Gm-Message-State: AOJu0Yz1f5uaTwQfjVY/vJtDA7f87ZLFpbcxfpyLn5iPJWn7z2U0hwhu
 mg/gDAMX83HoJoio4fW0czuBrfrjnBOOSnMYOQvyDJOrr0CdLWCk3LISstRz9eGHHaE=
X-Gm-Gg: AY/fxX6XH8aLtA8fCSjU9O4Ji1Tizvn2z62gmedCkbWm3BOlmjrm53qbRLAwLiy2GiR
 /N7xTPw4xTc+v2VecJz8JXLN/2obHqR4LGedOzi8/sFqHJpyYORH3TW5a7lfDOjTGG9CiPyVoQd
 I62s/lyQVe2BvuXZpx85JD2w/7wrXQyZwr5lDKYqcv+BweuE6VVsmi6/hCHw1xHBupceiNDVsPr
 HjZAaHh7SG9+mYM6Ljoo4XhLjoB31TxgAK9NXMpxk7AvqkZJd22G74CQy48+ND/coRkd9CCywyQ
 eyYGP9/tSLmO94CNWUR5DGvKK6kTWNOxFpzlmqCS5ncmyjUShsqzRYSjectRpEVGNwsqw4RCO9n
 IlIg5ETjLYzEJ1YccNEf7jQSn94avIpE/OOkDU8juJ9pNNboLwrZ2d43vr0EPsytxzEzw0LvmEq
 YLWmTclUaCme0soDyrfpyJaaTFcr8J1O2VdVDYJHBgs4AiHnsvleRb
X-Received: by 2002:a05:6402:1e94:b0:653:9cd7:2004 with SMTP id
 4fb4d7f45d1cf-654bb521e62mr4865908a12.28.1768676252513; 
 Sat, 17 Jan 2026 10:57:32 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654535c52afsm5939807a12.33.2026.01.17.10.57.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 10:57:32 -0800 (PST)
Date: Sat, 17 Jan 2026 10:57:22 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Jan Viktorin <viktorin@cesnet.cz>
Cc: Vipin Varghese <vipin.varghese@amd.com>, <dev@dpdk.org>,
 <roretzla@linux.microsoft.com>, <bruce.richardson@intel.com>,
 <john.mcnamara@intel.com>, <dmitry.kozliuk@gmail.com>,
 <pbhagavatula@marvell.com>, <jerinj@marvell.com>, <ruifeng.wang@arm.com>,
 <mattias.ronnblom@ericsson.com>, <anatoly.burakov@intel.com>,
 <ferruh.yigit@amd.com>, <honnappa.nagarahalli@arm.com>,
 <wathsala.vithanage@arm.com>, <konstantin.ananyev@huawei.com>,
 <mb@smartsharesystems.com>
Subject: Re: [PATCH v4 0/4] Introduce Topology NUMA grouping for lcores
Message-ID: <20260117105722.659fc146@phoenix.local>
In-Reply-To: <20250317144607.118a40b0@coaster.localdomain>
References: <20241105102849.1947-1-vipin.varghese@amd.com>
 <20250317144607.118a40b0@coaster.localdomain>
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

On Mon, 17 Mar 2025 14:46:07 +0100
Jan Viktorin <viktorin@cesnet.cz> wrote:

> Hello Vipin and others,
>=20
> please, will there be any progress or update on this series?
>=20
> I successfully tested those changes on our Intel and AMD machines and
> would like to use it in production soon.
>=20
> The API is a little bit unintuitive, at least for me, but I
> successfully integrated into our software.
>=20
> I am missing a clear relation to the NUMA socket approach used in DPDK.
> E.g. I would like to be able to easily walk over a list of lcores from
> a specific NUMA node grouped by L3 domain. Yes, there is the
> RTE_LCORE_DOMAIN_IO, but would it always match the appropriate socket
> IDs?
>=20
> Also, I do not clearly understand what is the purpose of using domain
> selector like:
>=20
>   RTE_LCORE_DOMAIN_L1 | RTE_LCORE_DOMAIN_L2
>=20
> or even:
>=20
>   RTE_LCORE_DOMAIN_L3 | RTE_LCORE_DOMAIN_L2
>=20
> the documentation does not explain this. I could not spot any kind of
> grouping that would help me in any way. Some "best practices" examples
> would be nice to have to understand the intentions better.
>=20
> I found a little catch when running DPDK with more lcores than there
> are physical or SMT CPU cores. This happens when using e.g. an option
> like --lcores=3D(0-15)@(0-1). The results from the topology API would not
> match the lcores because hwloc is not aware of the lcores concept. This
> might be mentioned somewhere.
>=20
> Anyway, I really appreciate this work and would like to see it upstream.
> Especially for AMD machines, some framework like this is a must.
>=20
> Kind regards,
> Jan
>=20
> On Tue, 5 Nov 2024 15:58:45 +0530
> Vipin Varghese <vipin.varghese@amd.com> wrote:
>=20
> > This patch introduces improvements for NUMA topology awareness in
> > relation to DPDK logical cores. The goal is to expose API which allows
> > users to select optimal logical cores for any application. These
> > logical cores can be selected from various NUMA domains like CPU and
> > I/O.
> >=20
> > Change Summary:
> >  - Introduces the concept of NUMA domain partitioning based on CPU and
> >    I/O topology.
> >  - Adds support for grouping DPDK logical cores within the same Cache
> >    and I/O domain for improved locality.
> >  - Implements topology detection and core grouping logic that
> >    distinguishes between the following NUMA configurations:
> >     * CPU topology & I/O topology (e.g., AMD SoC EPYC, Intel Xeon SPR)
> >     * CPU+I/O topology (e.g., Ampere One with SLC, Intel Xeon SPR
> > with SNC)
> >  - Enhances performance by minimizing lcore dispersion across
> > tiles|compute package with different L2/L3 cache or IO domains.
> >=20
> > Reason:
> >  - Applications using DPDK libraries relies on consistent memory
> > access.
> >  - Lcores being closer to same NUMA domain as IO.
> >  - Lcores sharing same cache.
> >=20
> > Latency is minimized by using lcores that share the same NUMA
> > topology. Memory access is optimized by utilizing cores within the
> > same NUMA domain or tile. Cache coherence is preserved within the
> > same shared cache domain, reducing the remote access from
> > tile|compute package via snooping (local hit in either L2 or L3
> > within same NUMA domain).
> >=20
> > Library dependency: hwloc
> >=20
> > Topology Flags:
> > ---------------
> >  - RTE_LCORE_DOMAIN_L1: to group cores sharing same L1 cache
> >  - RTE_LCORE_DOMAIN_SMT: same as RTE_LCORE_DOMAIN_L1
> >  - RTE_LCORE_DOMAIN_L2: group cores sharing same L2 cache
> >  - RTE_LCORE_DOMAIN_L3: group cores sharing same L3 cache
> >  - RTE_LCORE_DOMAIN_L4: group cores sharing same L4 cache
> >  - RTE_LCORE_DOMAIN_IO: group cores sharing same IO
> >=20
> > < Function: Purpose >
> > ---------------------
> >  - rte_get_domain_count: get domain count based on Topology Flag
> >  - rte_lcore_count_from_domain: get valid lcores count under each
> > domain
> >  - rte_get_lcore_in_domain: valid lcore id based on index
> >  - rte_lcore_cpuset_in_domain: return valid cpuset based on index
> >  - rte_lcore_is_main_in_domain: return true|false if main lcore is
> > present
> >  - rte_get_next_lcore_from_domain: next valid lcore within domain
> >  - rte_get_next_lcore_from_next_domain: next valid lcore from next
> > domain
> >=20
> > Note:
> >  1. Topology is NUMA grouping.
> >  2. Domain is various sub-groups within a specific Topology.
> >=20
> > Topology example: L1, L2, L3, L4, IO
> > Domian example: IO-A, IO-B
> >=20
> > < MACRO: Purpose >
> > ------------------
> >  - RTE_LCORE_FOREACH_DOMAIN: iterate lcores from all domains
> >  - RTE_LCORE_FOREACH_WORKER_DOMAIN: iterate worker lcores from all
> > domains
> >  - RTE_LCORE_FORN_NEXT_DOMAIN: iterate domain select n'th lcore
> >  - RTE_LCORE_FORN_WORKER_NEXT_DOMAIN: iterate domain for worker n'th
> > lcore.
> >=20
> > Future work (after merge):
> > --------------------------
> >  - dma-perf per IO NUMA
> >  - eventdev per L3 NUMA
> >  - pipeline per SMT|L3 NUMA
> >  - distributor per L3 for Port-Queue
> >  - l2fwd-power per SMT
> >  - testpmd option for IO NUMA per port
> >=20
> > Platform tested on:
> > -------------------
> >  - INTEL(R) XEON(R) PLATINUM 8562Y+ (support IO numa 1 & 2)
> >  - AMD EPYC 8534P (supports IO numa 1 & 2)
> >  - AMD EPYC 9554 (supports IO numa 1, 2, 4)
> >=20
> > Logs:
> > -----
> > 1. INTEL(R) XEON(R) PLATINUM 8562Y+:
> >  - SNC=3D1
> >         Domain (IO): at index (0) there are 48 core, with (0) at
> > index 0
> >  - SNC=3D2
> >         Domain (IO): at index (0) there are 24 core, with (0) at
> > index 0 Domain (IO): at index (1) there are 24 core, with (12) at
> > index 0
> >=20
> > 2. AMD EPYC 8534P:
> >  - NPS=3D1:
> >         Domain (IO): at index (0) there are 128 core, with (0) at
> > index 0
> >  - NPS=3D2:
> >         Domain (IO): at index (0) there are 64 core, with (0) at
> > index 0 Domain (IO): at index (1) there are 64 core, with (32) at
> > index 0
> >=20
> > Signed-off-by: Vipin Varghese <vipin.varghese@amd.com>
> >=20
> > Vipin Varghese (4):
> >   eal/lcore: add topology based functions
> >   test/lcore: enable tests for topology
> >   doc: add topology grouping details
> >   examples: update with lcore topology API
> >=20
> >  app/test/test_lcores.c                        | 528 +++++++++++++
> >  config/meson.build                            |  18 +
> >  .../prog_guide/env_abstraction_layer.rst      |  22 +
> >  examples/helloworld/main.c                    | 154 +++-
> >  examples/l2fwd/main.c                         |  56 +-
> >  examples/skeleton/basicfwd.c                  |  22 +
> >  lib/eal/common/eal_common_lcore.c             | 714
> > ++++++++++++++++++ lib/eal/common/eal_private.h                  |
> > 58 ++ lib/eal/freebsd/eal.c                         |  10 +
> >  lib/eal/include/rte_lcore.h                   | 209 +++++
> >  lib/eal/linux/eal.c                           |  11 +
> >  lib/eal/meson.build                           |   4 +
> >  lib/eal/version.map                           |  11 +
> >  lib/eal/windows/eal.c                         |  12 +
> >  14 files changed, 1819 insertions(+), 10 deletions(-)
> >  =20

This patch series does not apply cleanly to current DPDK main branch.
Please rebase and resubmit.

AI patch review had the following insights:

# DPDK Patch Series Review: Topology-based Lcore Functions (v4)

**Series**: [PATCH v4 1-4/4] eal/lcore: add topology based functions =20
**Date**: November 5, 2024 =20
**Author**: Vipin Varghese <vipin.varghese@amd.com>

---

## Executive Summary

This 4-patch series adds topology-aware lcore mapping to DPDK's lcore API, =
allowing cores to be grouped by chiplet locality (L1-L4 cache, IO). The ser=
ies includes API additions, tests, documentation, and example updates.

**Overall Assessment**: The patches have several issues that need to be add=
ressed before acceptance.

---

## Patch 1/4: eal/lcore: add topology based functions

### Commit Message Review

#### =E2=9C=85 PASS: Subject Line Format
- Length: 45 characters (within 60 char limit)
- Format: `eal/lcore: add topology based functions`
- Proper prefix, lowercase, imperative mood, no trailing period

#### =E2=9A=A0=EF=B8=8F WARNING: Commit Body Issues

**Line Length Violations** (must be =E2=89=A475 characters):
- Line 147: "Using hwloc library, the dpdk available lcores can be grouped"=
 - appears OK
- Line 148: "into various groups nameley L1, L2, L3, L4 and IO. This patch"=
 - OK
- However, several lines approach the limit

**Typo**: "nameley" should be "namely" (line 147)

**Body Structure**: The commit message starts appropriately but could be mo=
re detailed about the problem being solved and why this change is needed.

#### =E2=9D=8C ERROR: Missing Required Tags

The patch is missing:
- `Signed-off-by:` tag - This is **MANDATORY** per AGENTS.md line 116

The version history (v4 changes) is good and appropriately placed but shoul=
d be separated from the main commit message by a `---` line before the diff.

### Code Review

#### License Headers

Need to check if new files have proper SPDX headers. From the visible diff,=
 additions to existing files should maintain their existing headers.

#### Naming Conventions

**=E2=9C=85 PASS**: External API functions properly prefixed with `rte_`:
- `rte_get_domain_count`
- `rte_get_lcore_in_domain`
- `rte_get_next_lcore_from_domain`
- `rte_get_next_lcore_from_next_domain`
- `rte_lcore_count_from_domain`
- `rte_lcore_cpuset_in_domain`
- `rte_lcore_is_main_in_domain`

**=E2=9A=A0=EF=B8=8F INFO**: Internal functions lack `rte_` prefix, which i=
s appropriate for internal APIs:
- `get_domain_lcore_count`
- `get_domain_lcore_mapping`
- `rte_eal_topology_init`
- `rte_eal_topology_release`

However, the last two (`rte_eal_topology_*`) have `rte_` prefix despite bei=
ng listed as internal - verify if these should be marked as `__rte_internal=
`.

#### Code Style Issues

=46rom the visible diffs:

**Line Length**: Need to verify all code lines are =E2=89=A4100 characters

**Type Usage**:
- Good: Conversion of `l3_count` & `io_count` to `uint16_t` (mentioned in v=
4 changes)

**Memory Management**:
- Good: Removed unnecessary NULL checks before free (mentioned in v4 change=
s)
- Good: Removed unnecessary malloc casting (mentioned in v4 changes)

**Comments**: Would need to see full code to verify comment formatting

#### API Design Issues

**=E2=9A=A0=EF=B8=8F WARNING: Experimental APIs**
All new external APIs should be marked with `__rte_experimental` per AGENTS=
.md line 766. The commit message mentions "External Experimental API" but n=
eed to verify in the actual header file that each function has the `__rte_e=
xperimental` attribute on its own line.

**=E2=9A=A0=EF=B8=8F WARNING: Missing Doxygen**
New public APIs must have Doxygen comments (AGENTS.md line 756). Need to ve=
rify full header file.

#### Testing Requirements

**=E2=9A=A0=EF=B8=8F WARNING**: Per AGENTS.md line 698-699:
- New APIs must be used in `/app` test directory
- New device APIs require at least one driver implementation

The series includes patch 2/4 for tests, which is good. Need to verify the =
tests use the `TEST_ASSERT` macros and `unit_test_suite_runner` infrastruct=
ure (AGENTS.md lines 703-743).

### Documentation Requirements

**=E2=9A=A0=EF=B8=8F WARNING**: Per AGENTS.md line 758-762:
- Release notes must be updated in `doc/guides/rel_notes/` for important ch=
anges
- Code and documentation must be updated atomically

The series includes patch 3/4 for documentation, which is good. However, ne=
ed to verify:
- Documentation matches code behavior
- Only the **current release** notes file is updated
- Doxygen comments are present for all public APIs

---

## Patch 2/4: test/lcore: enable tests for topology

### Commit Message Review

#### Subject Line
- Format: `test/lcore: enable tests for topology`
- Length: 37 characters =E2=9C=85
- Proper prefix, lowercase, imperative =E2=9C=85

#### Missing Elements
- =E2=9D=8C **ERROR**: Missing `Signed-off-by:` tag

### Test Code Requirements

**Need to verify**:
- Tests use `TEST_ASSERT` macros (AGENTS.md line 745-752)
- Tests use `unit_test_suite_runner` infrastructure (AGENTS.md line 703-743)
- Tests are properly registered with `REGISTER_FAST_TEST` or similar

---

## Patch 3/4: doc: add topology grouping details

### Commit Message Review

#### Subject Line
- Format: `doc: add topology grouping details`
- Length: 35 characters =E2=9C=85
- Proper prefix, lowercase, imperative =E2=9C=85

#### Missing Elements
- =E2=9D=8C **ERROR**: Missing `Signed-off-by:` tag

### Documentation Requirements

**Need to verify**:
- Documentation matches actual code behavior
- Release notes updated for current release only
- Proper RST formatting
- No passive voice (per DPDK documentation standards)

---

## Patch 4/4: examples: update with lcore topology API

### Commit Message Review

#### Subject Line
- Format: `examples: update with lcore topology API`
- Length: 39 characters =E2=9C=85
- Proper prefix =E2=9C=85

**=E2=9A=A0=EF=B8=8F WARNING: Component Prefix**
Per AGENTS.md line 89, `example:` should be `examples/foo:` with specific e=
xample name.
Should be something like: `examples/helloworld: add topology support`

#### Missing Elements
- =E2=9D=8C **ERROR**: Missing `Signed-off-by:` tag

### Code Review for Examples

=46rom the visible diff in helloworld:

**Line 2608-2609**: Ternary operator formatting
```c
rte_eal_remote_launch((topo_sel =3D=3D USE_NO_TOPOLOGY) ?
    lcore_hello : send_lcore_hello, NULL, lcore_id);
```
This is acceptable but could be more readable. Consider:
```c
lcore_func =3D (topo_sel =3D=3D USE_NO_TOPOLOGY) ? lcore_hello : send_lcore=
_hello;
rte_eal_remote_launch(lcore_func, NULL, lcore_id);
```

**Line 2631-2632**: Comment formatting
```c
+/* select lcores based on ports numa (RTE_LCORE_DOMAIN_IO). */
+static bool select_port_from_io_domain;
```
=E2=9C=85 Good comment style

**L2fwd example changes** (lines 2624-2729):

**Line 2641**: Missing space in comment
```c
+	       "  -t : Enable IO domain lcores mapping to Ports\n"
```
Should probably be: "IO-domain lcore mapping" or "IO domain lcore mapping"

**Line 2670**: Variable type change
```c
-	unsigned lcore_id, rx_lcore_id;
+	uint16_t lcore_id, rx_lcore_id;
```
=E2=9C=85 Good: Using explicit types instead of `unsigned`

**Line 2681-2686**: Array initialization
```c
+	uint16_t coreindx_io_domain[RTE_MAX_ETHPORTS] =3D {0};
+	uint16_t lcore_io_domain[RTE_MAX_ETHPORTS] =3D {RTE_MAX_LCORE};
```
**=E2=9A=A0=EF=B8=8F WARNING**: The second initialization is problematic. I=
t only sets the first element to `RTE_MAX_LCORE`, not all elements. Should =
use a loop or memset for initialization:
```c
for (int i =3D 0; i < RTE_MAX_ETHPORTS; i++)
    lcore_io_domain[i] =3D RTE_MAX_LCORE;
```

**Line 2683**: Variable naming issue
```c
+	uint16_t l3_domain_count =3D rte_get_domain_count(RTE_LCORE_DOMAIN_IO);
```
**=E2=9D=8C ERROR**: Variable is named `l3_domain_count` but gets IO domain=
 count. Should be `io_domain_count`.

**Line 2705-2710**: Parentheses in while condition
```c
while ((rte_lcore_is_enabled(rx_lcore_id) =3D=3D 0) ||
       (lcore_queue_conf[rx_lcore_id].n_rx_port =3D=3D
	l2fwd_rx_queue_per_lcore)) {
```
Excessive parentheses - the outer ones around each condition aren't needed.

**Skeleton example changes** (lines 2731-2777):

**Line 2750**: Typo in comment
```c
+	/* get the socekt of each port */
```
Should be "socket", not "socekt"

**Line 2760**: Function usage looks good
```c
+	core_count_from_io =3D rte_lcore_count_from_domain(RTE_LCORE_DOMAIN_IO, s=
el_io_indx);
```

---

## Summary of Critical Issues

### Errors (Must Fix):

1. **All 4 patches missing `Signed-off-by:` tags** - This is mandatory per =
DPDK contribution guidelines
2. **Patch 4**: Variable naming bug - `l3_domain_count` should be `io_domai=
n_count`
3. **Patch 4**: Array initialization bug - `lcore_io_domain` array not full=
y initialized

### Warnings (Should Fix):

4. **Patch 1**: Typo in commit message - "nameley" =E2=86=92 "namely"
5. **Patch 4**: Wrong component prefix - should be `examples/helloworld:` a=
nd `examples/l2fwd:` and `examples/skeleton:`
6. **Patch 4**: Typo in comment - "socekt" =E2=86=92 "socket"
7. **Patch 4**: Unnecessary parentheses in while condition
8. All patches should verify:
   - API functions have `__rte_experimental` markers
   - Doxygen comments present for all public APIs
   - Tests use proper `TEST_ASSERT` infrastructure
   - Release notes updated

### Info (Consider):

9. **Patch 1**: Version history (v4 changes) should be after `---` separato=
r, not in commit body
10. **Patch 4**: Ternary operator could be more readable with intermediate =
variable
11. Verify all code lines are =E2=89=A4100 characters
12. Verify commit body lines are =E2=89=A475 characters

---

## Recommended Actions

1. **Immediate**: Add `Signed-off-by:` tags to all patches with author's re=
al name and email
2. **Immediate**: Fix variable naming bug (`l3_domain_count` =E2=86=92 `io_=
domain_count`)
3. **Immediate**: Fix array initialization bug for `lcore_io_domain`
4. Fix typos: "nameley" =E2=86=92 "namely", "socekt" =E2=86=92 "socket"
5. Update patch 4 subject lines to use specific example names
6. Verify all new APIs are marked `__rte_experimental`
7. Verify all new APIs have Doxygen documentation
8. Move v4 changelog to post-`---` section
9. Run DPDK validation tools:
   - `devtools/check-git-log.sh`
   - `devtools/checkpatches.sh`
   - `devtools/test-meson-builds.sh`

---

## Validation Commands

Before resubmitting, run:

```bash
# Check commit messages
devtools/check-git-log.sh

# Check patch formatting
devtools/checkpatches.sh *.patch

# Verify compilation
devtools/test-meson-builds.sh

# Check maintainers
devtools/get-maintainer.sh *.patch
```

---

## Positive Aspects

=E2=9C=85 Good responsiveness to v4 feedback (removed malloc casting, NULL =
checks, fixed types) =20
=E2=9C=85 Comprehensive series with tests, documentation, and examples =20
=E2=9C=85 Clear API naming with proper `rte_` prefixes =20
=E2=9C=85 Good use of explicit types (`uint16_t`) instead of `unsigned` =20
=E2=9C=85 Appropriate subject line formatting and component prefixes (mostl=
y) =20

The core concept and implementation approach appear sound, but the patches =
need the above corrections before merging.
