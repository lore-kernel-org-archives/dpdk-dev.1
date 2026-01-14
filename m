Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA2DDD38FEF
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 17:02:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A8A84064E;
	Wed, 14 Jan 2026 18:02:14 +0100 (CET)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50]) by mails.dpdk.org (Postfix) with ESMTP id AC2D04027D
 for <dev@dpdk.org>; Wed, 14 Jan 2026 18:02:12 +0100 (CET)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-47edffe5540so696595e9.0
 for <dev@dpdk.org>; Wed, 14 Jan 2026 09:02:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768410132;
 x=1769014932; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=si5JhZpu78lTxzzT290pHiSvQ+0ShNxSAhtqxxromgM=;
 b=UCs+24CJwqbGewuMT/JP1gVgAb1e+8YXKifRlOKORi1N5af74RV3SWlgv1jEFTtqxQ
 hmcfKnOgfbKuOOB/Ag6TSn/pgQxwQtEsVpTpdtWAfk8TU3z+44ay8eGmDjwOBd+srVZQ
 u1PoAouHV5TN5RRGhniCgxv9OemNSMdOFQO1oZmNbGgwN1FtdBfPCSSljYLxskP90Vbv
 In6xU2P1PkrPqPtSncst6TLXSXL8RqxUlTh4Krt/MQWZBFM+7thvVMeG4Y9hhyMwipAC
 gJeBGlg4lVANQXyTftrZJp9xLA+f919EjN5cHYcqA5xB8xAeHaw5f1CRrYVSKinb9T9C
 0Dbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768410132; x=1769014932;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=si5JhZpu78lTxzzT290pHiSvQ+0ShNxSAhtqxxromgM=;
 b=uSbeMj7Q50jlTim6pCEUtRpO0vZaZNpJyZJS6cLCBNKxNsFiS0StqWEUfMQjwdKnPr
 oFTh85qfMdfrrDxo9NVJ7XpGdYlY69UfvLQlKg3YbOCrjGoGewYp9cs+HiT+duY0MXIE
 5DXtJCWlA9Y/HohISm8tfG5MhPLy3mYfnuO5254ibEDKylH7tt0FvMRYizJvJkI4PX+A
 0EGw9tDhBsEfdWaFxl7oUI6yujVwkHI9yFlHzY3MY+A0PlLqmnjDmKogeHyWLWboxZMf
 hdUoXZO/JtKUfEsAZl0lN1Uvobm6qkDhmxsGrGzNgp7z/OoQ6ArurM+PQXfjyrWo3GD1
 tfmw==
X-Gm-Message-State: AOJu0YxB3NkhucfsFeHuTmD2NgGVRffN5cKZU8RNxpx0Vchg/MQZJyUN
 ulTdV0e809F7geKuQVcHPosONiu6gwAFYdOGb3QxUwTGHZsLOpyDlJXSd+rS66+Hr4E=
X-Gm-Gg: AY/fxX4NgN/Q/27DifqUrw5630p9kTNsivvBWwCP+/upQdgrc+Fxp7NyY4AWU/NhWHE
 wlr3hgGvq4b5ANTdL37kZaQBVv/zwtFuFz788tEKItmY6E5TJ8xqk5kDTy5K8ScFp/zV4V4XUdi
 TH6Y0Jlxw4Y89fEw8GQcKaj8IIyzM6E+cD2SfYrJaB0xyiB1t+dE8oN+F2cN4ggqZlekZN3/s4i
 6O1XtDZYRFNkR3xJRjwNC+Xf/uk6r/o7wcjZszty4oVNOxcIrI2/z7r9BsZcAHFTO0B+5UXx/Bl
 olNFhkZjQ5gxH6t4t5MFUgYW+Tx7IQTC3sFSoJTp0hmYPR6pasUD0jkyrFE/ZpwFrrf4ezbe7OJ
 dgKLlqCQt8HfNKlydW3FMGvvV2w3Lvpxm8dddiYECjc2dX3nnWEHZq7whErCImW1dfmDsimcsfy
 UrFCheZs7Rgy4jUqSnhVZ91ERUBOgeRiKx7vaRImDIomU+ToDDUVD+
X-Received: by 2002:a05:600c:1f89:b0:47d:3ffa:5c75 with SMTP id
 5b1f17b1804b1-47ee335157dmr38453695e9.20.1768410132138; 
 Wed, 14 Jan 2026 09:02:12 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47f429071a2sm993735e9.11.2026.01.14.09.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 09:02:11 -0800 (PST)
Date: Wed, 14 Jan 2026 09:02:06 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v4 00/31] build DPDK with Wshadow flag
Message-ID: <20260114090206.5fe70564@phoenix.local>
In-Reply-To: <20260114154450.2969716-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
 <20260114154450.2969716-1-bruce.richardson@intel.com>
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

On Wed, 14 Jan 2026 15:44:14 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> As flagged in bugs #1742, #1743 and others, much of DPDK fails to build
> when -Wshadow flag is passed to the build. This patchset fixes many issues
> of this nature, but not all, in the hopes we can move towards enabling th=
at
> warning flag for all components for DPDK in future. This patchset fixes t=
he
> following components in DPDK:
>=20
> * all libraries
> * Intel net drivers
> * all apps in the "app" folder
>=20
> For the rest of the drivers and example applications, any component which
> does not build successfully with the shadow warning enabled has it
> explicitly disabled via cflags. Then the last patch adds -Wshadow to the
> global DPDK build, which should prevent any regressions in components whi=
ch
> are already working.
>=20
> At that point, we should not have any regressions and we can, over time,
> reduce the number of components needing the -Wno-shadow flag.
>=20
> V4:
> * Updates follow AI review:
>   - improve variable naming in min/max fns
>   - remove extra blank line
> * rebase on latest main
>=20
> v3:
> * rebase on 25.11 release.
>=20
> RFC v2:
> * take patch from Stephen for RTE_MIN/MAX fixes
> * add additional fixes to clear clang warnings - it's a lot stricter than
>   gcc in this regard, and flags more issues.
> * extend app cleanup to all apps, not just testpmd
> * add per-component disabling, and add global enable flag at the end.
>=20
> Bruce Richardson (30):
>   eal: fix variable shadowing
>   ethdev: fix variable shadowing issues
>   eventdev: fix variable shadowing issues
>   net: remove shadowed variable
>   pipeline: fix variable shadowing
>   table: fix issues with variable shadowing
>   power: rename variable to eliminate shadowing
>   pcapng: rename variable to fix shadowing
>   bbdev: fix variable shadowing
>   bus/pci: remove shadowed variables
>   net/intel: rename function param to avoid shadow warnings
>   net/e1000: fix build with shadow warnings enabled
>   net/i40e: fix build with shadow warnings enabled
>   net/ice: fix build with shadow warnings enabled
>   net/cpfl: fix build with shadow warnings enabled
>   net/ixgbe: fix build with shadow warnings enabled
>   app/testpmd: fix build with shadow warnings enabled
>   app/graph: fix build with shadow warnings enabled
>   app/pdump: fix warning about shadowed variable
>   app/test-bbdev: remove shadow warning from next max calls
>   app/test-compress-perf: rename local vars to fix shadowing
>   app/test-crypto-perf: rename local vars to fix shadowing
>   app/test-eventdev: fix build with shadow warnings enabled
>   app/test-flow-perf: remove unneeded variable
>   app/test-security-perf: fix build with shadow warnings
>   app/test-pipeline: remove unnecessary variable
>   drivers: disable variable shadowing warnings for drivers
>   app/test: disable shadowing warnings for unit tests
>   examples: ignore variable shadowing warnings
>   build: enable shadowed variable warnings
>=20
> Stephen Hemminger (1):
>   eal: add more min/max helpers
>=20
>  app/graph/conn.c                              | 134 +++++++++---------
>  app/pdump/main.c                              |  12 +-
>  app/test-bbdev/test_bbdev_perf.c              |   7 +-
>  app/test-compress-perf/main.c                 | 122 ++++++++--------
>  .../cperf_test_pmd_cyclecount.c               |   6 +-
>  app/test-eventdev/evt_main.c                  |   6 +-
>  app/test-eventdev/test_atomic_queue.c         |   6 +-
>  app/test-eventdev/test_perf_common.c          |   4 +-
>  app/test-flow-perf/main.c                     |   1 -
>  app/test-pipeline/main.c                      |   1 -
>  app/test-pmd/cmdline_flow.c                   |  42 +++---
>  app/test-pmd/config.c                         |  15 +-
>  app/test-pmd/parameters.c                     |  38 +++--
>  app/test-pmd/testpmd.c                        |   2 +-
>  app/test-security-perf/test_security_perf.c   |  42 +++---
>  app/test/meson.build                          |   1 +
>  app/test/test_cryptodev_security_ipsec.c      |  13 +-
>  config/meson.build                            |   6 +
>  drivers/baseband/fpga_5gnr_fec/meson.build    |   2 +
>  drivers/bus/fslmc/meson.build                 |   2 +
>  drivers/bus/pci/linux/pci.c                   |   1 -
>  drivers/bus/pci/linux/pci_vfio.c              |   2 +-
>  drivers/bus/pci/windows/pci.c                 |   1 -
>  drivers/common/cnxk/meson.build               |   1 +
>  drivers/common/qat/meson.build                |   1 +
>  drivers/compress/nitrox/meson.build           |   2 +
>  drivers/crypto/cnxk/meson.build               |   1 +
>  drivers/crypto/octeontx/meson.build           |   1 +
>  drivers/crypto/openssl/meson.build            |   1 +
>  drivers/crypto/scheduler/meson.build          |   1 +
>  drivers/dma/dpaa2/meson.build                 |   2 +
>  drivers/event/cnxk/meson.build                |   1 +
>  drivers/event/dlb2/meson.build                |   2 +
>  drivers/event/sw/meson.build                  |   1 +
>  drivers/net/axgbe/meson.build                 |   2 +-
>  drivers/net/bnxt/meson.build                  |   1 +
>  drivers/net/bonding/meson.build               |   1 +
>  drivers/net/cnxk/meson.build                  |   1 +
>  drivers/net/cxgbe/meson.build                 |   1 +
>  drivers/net/dpaa/meson.build                  |   1 +
>  drivers/net/dpaa2/meson.build                 |   1 +
>  drivers/net/ena/meson.build                   |   2 +
>  drivers/net/enetfec/meson.build               |   2 +
>  drivers/net/enic/meson.build                  |   2 +
>  drivers/net/failsafe/meson.build              |   1 +
>  drivers/net/intel/common/rx.h                 |   6 +-
>  drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c |   2 -
>  drivers/net/intel/cpfl/cpfl_flow_parser.c     |   6 +-
>  drivers/net/intel/cpfl/cpfl_fxp_rule.h        |   2 -
>  drivers/net/intel/cpfl/cpfl_representor.h     |   2 +-
>  drivers/net/intel/e1000/igc_ethdev.c          |   6 +-
>  drivers/net/intel/i40e/i40e_ethdev.h          |  10 +-
>  drivers/net/intel/ice/ice_ethdev.c            |   6 +-
>  drivers/net/intel/ixgbe/ixgbe_fdir.c          |   7 +-
>  drivers/net/mlx5/meson.build                  |   1 +
>  drivers/net/ntnic/meson.build                 |   3 +
>  drivers/net/pfe/meson.build                   |   3 +
>  drivers/net/qede/meson.build                  |   3 +
>  drivers/net/txgbe/meson.build                 |   1 +
>  drivers/net/zxdh/meson.build                  |   3 +
>  drivers/raw/ifpga/meson.build                 |   2 +
>  drivers/vdpa/mlx5/meson.build                 |   1 +
>  examples/bbdev_app/meson.build                |   1 +
>  examples/bond/meson.build                     |   1 +
>  examples/dma/meson.build                      |   1 +
>  examples/ethtool/meson.build                  |   1 +
>  examples/eventdev_pipeline/meson.build        |   1 +
>  examples/flow_filtering/meson.build           |   1 +
>  examples/ip_pipeline/meson.build              |   1 +
>  examples/ipsec-secgw/meson.build              |   1 +
>  examples/l2fwd-crypto/meson.build             |   1 +
>  examples/l2fwd-event/meson.build              |   1 +
>  examples/l2fwd-jobstats/meson.build           |   1 +
>  examples/l2fwd-keepalive/meson.build          |   1 +
>  examples/l3fwd-graph/meson.build              |   1 +
>  examples/l3fwd-power/meson.build              |   1 +
>  examples/l3fwd/meson.build                    |   1 +
>  .../client_server_mp/mp_server/meson.build    |   1 +
>  examples/packet_ordering/meson.build          |   1 +
>  examples/ptpclient/meson.build                |   1 +
>  examples/qos_sched/meson.build                |   1 +
>  .../server_node_efd/efd_server/meson.build    |   1 +
>  examples/vhost/meson.build                    |   1 +
>  .../vm_power_manager/guest_cli/meson.build    |   1 +
>  examples/vm_power_manager/meson.build         |   1 +
>  examples/vmdq/meson.build                     |   1 +
>  lib/bbdev/rte_bbdev.c                         |   2 +-
>  lib/eal/common/eal_common_options.c           |  22 +--
>  lib/eal/common/eal_common_trace.c             |  89 ++++++------
>  lib/eal/common/malloc_heap.c                  |   2 +-
>  lib/eal/include/rte_common.h                  |  38 ++++-
>  lib/ethdev/ethdev_driver.c                    |   6 +-
>  lib/ethdev/rte_ethdev.c                       |   1 -
>  lib/eventdev/rte_event_eth_rx_adapter.c       |   5 +-
>  lib/eventdev/rte_event_eth_tx_adapter.c       |   8 +-
>  lib/net/net_crc_avx512.c                      |   4 +-
>  lib/pcapng/rte_pcapng.c                       |   7 +-
>  lib/pipeline/rte_swx_ctl.c                    |  11 +-
>  lib/pipeline/rte_swx_pipeline.c               |  21 ++-
>  lib/pipeline/rte_swx_pipeline_internal.h      |  10 +-
>  lib/power/rte_power_pmd_mgmt.c                |   6 +-
>  lib/table/rte_lru.h                           |  38 ++---
>  lib/table/rte_lru_arm64.h                     |  14 +-
>  lib/table/rte_lru_x86.h                       |   4 +-
>  lib/table/rte_swx_table_em.c                  |   2 -
>  lib/table/rte_swx_table_learner.c             |   4 +-
>  lib/table/rte_table_hash_key16.c              |   4 +-
>  lib/table/rte_table_hash_key32.c              |   4 +-
>  lib/table/rte_table_hash_key8.c               |   4 +-
>  109 files changed, 477 insertions(+), 412 deletions(-)
>=20
> --
> 2.51.0
>=20

AI review gives thumbs up on this...



## DPDK Patch Series Review: Shadow Warning Fixes (v4)

### Series Overview

| Aspect | Details |
|--------|---------|
| **Series** | [PATCH v4 01-31/31] Shadow warning fixes |
| **Submitter** | Bruce Richardson (Intel) |
| **Original Author (Patch 1)** | Stephen Hemminger |
| **Purpose** | Enable `-Wshadow` compiler warning globally |

---

## Patch-by-Patch Evaluation

### Patch 01/31: eal: add more min/max helpers

**Commit Message:**
| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=93 | "eal: add more min/max helpers" (=
27 chars) |
| Correct prefix | =E2=9C=93 | `eal:` is correct for lib/eal |
| Lowercase after colon | =E2=9C=93 | |
| Imperative mood | =E2=9C=93 | "add" |
| No trailing period | =E2=9C=93 | |
| Signed-off-by present | =E2=9C=93 | Stephen Hemminger + Bruce Richardson |
| Body does not start with "It" | =E2=9C=93 | |

**Code Review:**
- **Logic**: Adds `RTE_MIN3()` and `RTE_MAX3()` macros, and renames interna=
l variables (`_a`=E2=86=92`_a_min`, etc.) to avoid shadow conflicts when ne=
sting MIN/MAX calls. Sound approach.

**Warning - Minor style issue in RTE_MIN3:**
```c
		_a_min3 < _b_min3 ? \
			(_a_min3 < _c_min3 ? _a_min3 : _c_min3) : \
		        (_b_min3 < _c_min3 ? _b_min3 : _c_min3);  \
```
Line 3 has inconsistent indentation (spaces vs tabs for alignment) and a tr=
ailing double-space before the backslash. The same issue exists in `RTE_MAX=
3`.

---

### Patch 02/31: eal: fix variable shadowing

**Commit Message:**
| Check | Status | Notes |
|-------|--------|-------|
| Subject =E2=89=A460 chars | =E2=9C=93 | 26 chars |
| Bugzilla ID present | =E2=9C=93 | IDs 1742 and 1743 |
| Fixes: tags | =E2=9C=93 | 3 Fixes with 12-char SHA and exact subjects |
| Cc: stable@dpdk.org | =E2=9C=93 | Present for bug fix |
| Tag order | =E2=9C=93 | Bugzilla ID =E2=86=92 Fixes =E2=86=92 Cc =E2=86=
=92 Signed-off-by =E2=86=92 Acked-by |

**Code Review:** Clean refactoring - renames `trace` to `t` for local varia=
bles, renames `args` to `out_args`, removes redundant `aligned_end` redefin=
ition.

---

### Patches 03-11: Library Fixes

All follow the same pattern for ethdev, eventdev, net, pipeline, table, pow=
er, pcapng, bbdev, and bus/pci. Each:
- Has proper `Fixes:` tags with 12-char SHA
- Has `Cc: stable@dpdk.org` =20
- Has appropriate Acked-by tags
- Correctly removes shadowed variables by renaming or removing redundant de=
finitions

---

### Patches 12-17: Intel Driver Fixes (net/intel, e1000, i40e, ice, cpfl, i=
xgbe)

**Patch 14 (i40e) - Good macro fix:**
```c
-		struct rte_eth_dev *dev;\
+		struct rte_eth_dev *_dev;\
```
Correctly prefixes macro-internal variables with `_` to avoid shadowing.

**Patch 15 (ice):** Converts nested `RTE_MIN(RTE_MIN(...))` to two separate=
 calls - necessary workaround for the old macro implementation.

---

### Patches 18-27: Application Fixes (testpmd, app/graph, pdump, etc.)

**Patch 18 (testpmd):** Several good fixes:
- Renames `opt` to `geneve_opt`, `gtp_opt`, `gre_opt` for clarity
- Removes unnecessary `rss_hf` intermediate variable
- Renames `optarg` parameter to `event_arg` to avoid shadowing the global `=
optarg` from getopt

**Patch 19 (app/graph):** Renames function parameter `conn` to `c` througho=
ut to avoid shadowing global variable. Good systematic approach.

---

### Patches 28-30: Bulk Disable for Drivers/Tests/Examples

These patches add `cflags +=3D no_shadow_cflag` to meson.build files for co=
mponents that have extensive shadow warnings. This is a pragmatic approach =
for:
- **Drivers**: ~35 drivers that need cleanup later
- **app/test**: Unit tests with many warnings
- **examples**: ~24 example apps

---

### Patch 31/31: Enable -Wshadow globally

Adds `-Wshadow` to the global compiler flags, completing the series.

---

## Overall Assessment

### Errors (Must Fix)
**None found.** All commit messages follow DPDK standards.

### Warnings (Should Fix)

| Issue | Location | Severity |
|-------|----------|----------|
| Inconsistent indentation (spaces vs tabs) | Patch 01, RTE_MIN3/RTE_MAX3 |=
 Warning |
| Trailing double-space before backslash | Patch 01, line endings | Warning=
 |

### Info (Consider)

1. **Patch 01**: The new `RTE_MIN3`/`RTE_MAX3` macros lack `@param` documen=
tation in the Doxygen comment. Consider adding:
   ```c
   /**
    * Macro to return the minimum of three numbers
    * @param a First number
    * @param b Second number =20
    * @param c Third number
    */
   ```

2. **Series organization**: The series is well-structured, fixing core issu=
es first, then building up through libraries, drivers, and apps before enab=
ling the warning globally.

---

## Verdict

**Recommended: Acked-by** with minor style fixes requested for Patch 01.

The series is comprehensive and well-executed. It systematically enables an=
 important compiler warning while maintaining buildability by temporarily d=
isabling it where extensive cleanup would be needed. The approach of fixing=
 core libraries first and deferring driver/example cleanup is pragmatic for=
 a large codebase.
