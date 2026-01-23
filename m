Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1104BD715EE
	for <dpdk-dev@archiver.kernel.org>; Sat, 24 Jan 2026 17:09:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F3B840289;
	Sat, 24 Jan 2026 18:09:11 +0100 (CET)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com
 [209.85.128.41]) by mails.dpdk.org (Postfix) with ESMTP id 580A340274
 for <dev@dpdk.org>; Sat, 24 Jan 2026 18:09:10 +0100 (CET)
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-4801d98cf39so23647815e9.1
 for <dev@dpdk.org>; Sat, 24 Jan 2026 09:09:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769274550;
 x=1769879350; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CvnkcR5iKuVDGStKeLigM6juFeC+rnwQqoluauF8S1s=;
 b=UBK3QPpsA+lRHEcJzVLChhpexFDPhrZHOQ22yI119oXzSNIUFTI1iHjMwPACzfhrsu
 /+xsTJlj/ObTX1O9pHAUpmHS7LpG3hHB7coPpKEQgiomQPhu5QAAG7wmiIEH+Q1Fa4d7
 XnsIpSibIJk13Nch7t+JlqfBJWGCzRbO590jtuz3BYpqjhQR1lYnByktX23nDw6+Iqpo
 1D631VemKxkLVVLm5QI4OVmj4dV5q3HVZFB4pjZzX4D9bw+GZDkIBvryJFUSFFdB02zK
 fiNNhI5Tb9J4C1N5AFz9LBUdzdc6PH8Q8PEEVMETKH7sfJSgqe7UfR2PUwHSlShGZJd5
 TrNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769274550; x=1769879350;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=CvnkcR5iKuVDGStKeLigM6juFeC+rnwQqoluauF8S1s=;
 b=BaEqRmKkhbP4es0PbAGs/W1ui0eh0u+Q7UtqzKCTriYkScuyL6nQEl8bDkCxhtTQuN
 ZYthxOKz0S+MYNhnbp98+2EyJDsomAqjgRY2GHbdjjucNIvagJKX7/k8i6YM5ncH/MZC
 8BqkKAM3feXAmsEwi2Ex2NxwUn0PWJHioXMA/FW9CynoFSV4GzYZC8PtYBxRwIl+u3bj
 p95FEQkuoFvzmH8djpGGbKPc9/hk4rO4k2ZiKa3Zvmj7FL4KL56WrEsiiBAO180p3/xB
 Zqft4GRT11MqoDN3y5SK8p4/tNQaAo5o/tNEizh/qzfHGhtKCxRAR7d0hpJgEGTF6Kys
 xVSg==
X-Gm-Message-State: AOJu0YzF4PfAyntgZyu/mXJwbBzx4NDwG3fFhPq69tZH8PmoXkzpy2CX
 oRiql7c6p9a2wyYbtmH7T/6d94xPoSIPSKG5u4LhSioo8Xakr6mi87YTTAZ4tkTgcLQ=
X-Gm-Gg: AZuq6aLHLaRYZoVDfKfRrBbrJsVCMHvFmME6p7t/6MFtcnTP4110yaaArbCTTQpMO+X
 QC8Y/x2a3SkMHmsd6oGtbFjtN83qQN1cXbjpYlJPeS3imBpOa0RSLRg3O52U/+Z9Rqvq8EkbudW
 y/6SxlDxPFf3OELF0MFYLiihDzjTyLUzGUdU2cxUJ+rtcW3cW2g0LQrqllPfnHj8+/ZrhGcEve7
 CyFrd1fAVe/b/1gJVrFzJCZqBcjO72Kc7d7rBRO3P5Y23SMti4RGDUWq1hQomBF1YDLXmr4Ct0q
 sS9JJteTNcZS/Qq6I0n1gzxH28xIOS9hUV/3lrg4dNaCrwF1D77Mi9eI7rqHYCyEHOga1iaQ8BS
 MaDDR2+oOZElc12SdaeccznkVsZ4kePY9IVBUSnpfrq6hf0stvqoKYNvMyKcFI81zmvpczUfxiL
 Wl3yiKduMtQ2yBZJKkvQHgN32ckDo/nubKsFMY2ofTjsMJEnEZGpls
X-Received: by 2002:a05:600c:3b9d:b0:480:1c53:2085 with SMTP id
 5b1f17b1804b1-4804c9b0008mr104263085e9.19.1769274549496; 
 Sat, 24 Jan 2026 09:09:09 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4804d8a5b2dsm147493255e9.9.2026.01.24.09.09.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 24 Jan 2026 09:09:08 -0800 (PST)
Date: Thu, 22 Jan 2026 22:26:33 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 00/36] combine multiple Intel scalar Tx paths
Message-ID: <20260122222053.55cb8cbf@phoenix.local>
In-Reply-To: <20260113151505.1871271-1-bruce.richardson@intel.com>
References: <20251219172548.2660777-1-bruce.richardson@intel.com>
 <20260113151505.1871271-1-bruce.richardson@intel.com>
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

On Tue, 13 Jan 2026 15:14:24 +0000
Bruce Richardson <bruce.richardson@intel.com> wrote:

> The scalar Tx paths, with support for offloads and multiple mbufs
> per packet, are almost identical across drivers ice, i40e, iavf and
> the single-queue mode of idpf. Therefore, we can do some rework to
> combine these code paths into a single function which is parameterized
> by compile-time constants, allowing code saving to give us a single
> path to optimize and maintain - apart from edge cases like IPSec
> support in iavf.
>=20
> The ixgbe driver has a number of similarities too, which we take
> advantage of where we can, but the overall descriptor format is
> sufficiently different that its main scalar code path is kept
> separate.
>=20
> Once merged, we can then optimize the drivers a bit to improve
> performance, and also easily extend some drivers to use additional
> paths for better performance, e.g. add the "simple scalar" path
> to IDPF driver for better performance on platforms without AVX.
>=20
> V2:
>  - reworked the simple-scalar path as well as full scalar one
>  - added simple scalar path support to idpf driver
>  - small cleanups, e.g. issues flagged by checkpatch
>=20
> Bruce Richardson (36):
>   net/intel: create common Tx descriptor structure
>   net/intel: use common Tx ring structure
>   net/intel: create common post-Tx cleanup function
>   net/intel: consolidate definitions for Tx desc fields
>   net/intel: create separate header for Tx scalar fns
>   net/intel: add common fn to calculate needed descriptors
>   net/ice: refactor context descriptor handling
>   net/i40e: refactor context descriptor handling
>   net/idpf: refactor context descriptor handling
>   net/intel: consolidate checksum mask definition
>   net/intel: create common checksum Tx offload function
>   net/intel: create a common scalar Tx function
>   net/i40e: use common scalar Tx function
>   net/intel: add IPsec hooks to common Tx function
>   net/intel: support configurable VLAN tag insertion on Tx
>   net/iavf: use common scalar Tx function
>   net/i40e: document requirement for QinQ support
>   net/idpf: use common scalar Tx function
>   net/intel: avoid writing the final pkt descriptor twice
>   eal: add macro for marking assumed alignment
>   net/intel: write descriptors using non-volatile pointers
>   net/intel: remove unnecessary flag clearing
>   net/intel: mark mid-burst ring cleanup as unlikely
>   net/intel: add special handling for single desc packets
>   net/intel: use separate array for desc status tracking
>   net/ixgbe: use separate array for desc status tracking
>   net/intel: drop unused Tx queue used count
>   net/intel: remove index for tracking end of packet
>   net/intel: merge ring writes in simple Tx for ice and i40e
>   net/intel: consolidate ice and i40e buffer free function
>   net/intel: complete merging simple Tx paths
>   net/intel: use non-volatile stores in simple Tx function
>   net/intel: align scalar simple Tx path with vector logic
>   net/intel: use vector SW ring entry for simple path
>   net/intel: use vector mbuf cleanup from simple scalar path
>   net/idpf: enable simple Tx function
>=20
>  doc/guides/nics/i40e.rst                      |  18 +
>  drivers/net/intel/common/tx.h                 | 116 ++-
>  drivers/net/intel/common/tx_scalar_fns.h      | 595 ++++++++++++++
>  drivers/net/intel/cpfl/cpfl_rxtx.c            |   8 +-
>  drivers/net/intel/i40e/i40e_fdir.c            |  34 +-
>  drivers/net/intel/i40e/i40e_rxtx.c            | 670 +++-------------
>  drivers/net/intel/i40e/i40e_rxtx.h            |  16 -
>  .../net/intel/i40e/i40e_rxtx_vec_altivec.c    |  25 +-
>  drivers/net/intel/i40e/i40e_rxtx_vec_avx2.c   |  36 +-
>  drivers/net/intel/i40e/i40e_rxtx_vec_avx512.c |  52 +-
>  drivers/net/intel/i40e/i40e_rxtx_vec_common.h |   6 +-
>  drivers/net/intel/i40e/i40e_rxtx_vec_neon.c   |  25 +-
>  drivers/net/intel/iavf/iavf_rxtx.c            | 642 ++++-----------
>  drivers/net/intel/iavf/iavf_rxtx.h            |  30 +-
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx2.c   |  55 +-
>  drivers/net/intel/iavf/iavf_rxtx_vec_avx512.c | 104 +--
>  drivers/net/intel/iavf/iavf_rxtx_vec_common.h |  36 +-
>  drivers/net/intel/ice/ice_dcf_ethdev.c        |  10 +-
>  drivers/net/intel/ice/ice_rxtx.c              | 737 ++++--------------
>  drivers/net/intel/ice/ice_rxtx.h              |  15 -
>  drivers/net/intel/ice/ice_rxtx_vec_avx2.c     |  55 +-
>  drivers/net/intel/ice/ice_rxtx_vec_avx512.c   |  53 +-
>  drivers/net/intel/ice/ice_rxtx_vec_common.h   |  43 +-
>  drivers/net/intel/idpf/idpf_common_device.h   |   2 +
>  drivers/net/intel/idpf/idpf_common_rxtx.c     | 315 ++------
>  drivers/net/intel/idpf/idpf_common_rxtx.h     |  24 +-
>  .../net/intel/idpf/idpf_common_rxtx_avx2.c    |  53 +-
>  .../net/intel/idpf/idpf_common_rxtx_avx512.c  |  55 +-
>  drivers/net/intel/idpf/idpf_rxtx.c            |  43 +-
>  drivers/net/intel/idpf/idpf_rxtx_vec_common.h |   6 +-
>  drivers/net/intel/ixgbe/ixgbe_rxtx.c          | 103 ++-
>  .../net/intel/ixgbe/ixgbe_rxtx_vec_common.c   |   3 +-
>  lib/eal/include/rte_common.h                  |   6 +
>  33 files changed, 1565 insertions(+), 2426 deletions(-)
>  create mode 100644 drivers/net/intel/common/tx_scalar_fns.h
>=20

Series-Acked-by: Stephen Hemminger <stephen@networkplumber.org>

Love to see common code and "fix it once"
It was too large for the batch scripts, but here is AI review.
It sees only minor stuff which you could fix (or skip).

# DPDK Patch Review: Intel Tx Consolidation Series

**Series:** [PATCH v2 01-36/36] Intel Tx driver consolidation =20
**Author:** Bruce Richardson <bruce.richardson@intel.com> =20
**Review Date:** 2026-01-22 =20
**Review Against:** AGENTS.md (DPDK Code Review Guidelines)

---

## Executive Summary

This 36-patch series consolidates Tx descriptor handling across Intel netwo=
rk drivers (i40e, iavf, ice, idpf, ixgbe). Overall the patches are **well-s=
tructured** with proper code organization, but there are several **issues r=
equiring attention** before merge.

| Severity | Count | Summary |
|----------|-------|---------|
| **Error** | 1 | Source code line exceeds 100 characters |
| **Warning** | 5 | Commit message style issues, double blank lines |
| **Info** | 2 | Minor style observations |

---

## Detailed Findings

### ERRORS (Must Fix)

#### 1. Source Code Line Length Violation
**Patch 17/36:** `net/i40e: document requirement for QinQ support` =20
**Location:** `drivers/net/intel/i40e/i40e_rxtx.c` =20
**Issue:** Line exceeds 100-character limit (135 characters)

```c
PMD_DRV_LOG(WARNING, "Double VLAN insertion may not work correctly without =
RTE_ETH_RX_OFFLOAD_VLAN_EXTEND set in Rx configuration.");
```

**Fix:** Split the log message across multiple lines or into multiple log c=
alls:
```c
PMD_DRV_LOG(WARNING, "Double VLAN insertion may not work correctly "
            "without RTE_ETH_RX_OFFLOAD_VLAN_EXTEND in Rx config.");
```

---

### WARNINGS (Should Fix)

#### 2. Commit Body Starts with Lowercase
**Patches 08/36 and 09/36**

Per DPDK convention, commit message body should start with a capital letter.

| Patch | Current | Should Be |
|-------|---------|-----------|
| 08/36 `net/i40e: refactor context descriptor handling` | "move all contex=
t..." | "Move all context..." |
| 09/36 `net/idpf: refactor context descriptor handling` | "move all contex=
t..." | "Move all context..." |

---

#### 3. Double Blank Lines in Code
The following patches add consecutive blank lines, which is a minor style v=
iolation:

| Patch | Location | Line |
|-------|----------|------|
| 06/36 `net/intel: add common fn to calculate needed` | tx_scalar_fns.h | =
~line 5093 |
| 07/36 `net/ice: refactor context descriptor handling` | ice_rxtx.c | ~lin=
e 5379 |
| 36/36 `net/idpf: enable simple Tx function` | idpf_common_rxtx.c | After =
`idpf_dp_singleq_xmit_pkts_simple()` |

**Example from Patch 36:**
```c
+uint16_t
+idpf_dp_singleq_xmit_pkts_simple(void *tx_queue, struct rte_mbuf **tx_pkts,
+				   uint16_t nb_pkts)
+{
+	return ci_xmit_pkts_simple(tx_queue, tx_pkts, nb_pkts);
+}
+
+
+/* TX prep functions */   <-- Extra blank line above
```

---

#### 4. "TX" vs "Tx" in Comments
Multiple patches use "TX" in comments rather than the DPDK-preferred "Tx":

- Patch 04: `/* Common TX Descriptor QW1 Field Definitions */`
- Patch 06: `/* Calculate the number of TX descriptors needed for each pkt =
*/`
- Patch 07: `/* TX context descriptor based double VLAN insert */`
- Patch 12: `/* Setup TX Descriptor */`
- And others...

While not strictly an error (comments aren't checked as strictly as commit =
messages), consistency with "Tx" is preferred per `devtools/words-case.txt`.

---

#### 5. EAL Macro Addition Without Release Notes
**Patch 20/36:** `eal: add macro for marking assumed alignment`

Adds `__rte_assume_aligned` macro to `lib/eal/include/rte_common.h`. Consid=
er adding a release notes entry for this new public macro, even though it's=
 primarily for internal optimization use.

---

### INFO (Consider)

#### 6. Subject Line Truncation
**Patch 06/36:** Subject line `net/intel: add common fn to calculate needed=
` appears truncated (missing "descriptors").

While technically within the 60-char limit, the full meaning is lost. Consi=
der:
- `net/intel: add fn to calc needed descriptors` (43 chars)
- Or keep two-line format in cover letter

---

#### 7. New Internal API Properly Tagged
**Patch 36/36** correctly adds `__rte_internal` tag for `idpf_dp_singleq_xm=
it_pkts_simple()` in the header file (not .c file). =E2=9C=93

---

## Compliance Summary

### Commit Message Checks

| Check | Status |
|-------|--------|
| Subject =E2=89=A460 chars | =E2=9C=93 All pass (35-51 chars) |
| Lowercase after prefix | =E2=9C=93 All pass |
| No trailing period | =E2=9C=93 All pass |
| Signed-off-by present | =E2=9C=93 All 36 patches |
| Body =E2=89=A475 chars | =E2=9C=93 All pass |
| Imperative mood | =E2=9C=93 All pass |
| Correct prefix (net/intel, net/ice, etc.) | =E2=9C=93 All pass |
| Body starts with capital | =E2=9C=97 2 failures (patches 8, 9) |

### Code Style Checks

| Check | Status |
|-------|--------|
| Lines =E2=89=A4100 chars | =E2=9C=97 1 failure (patch 17) |
| No trailing whitespace | =E2=9C=93 All pass |
| SPDX headers on new files | =E2=9C=93 Pass (patch 5 new file) |
| `__rte_internal` in headers only | =E2=9C=93 Pass |
| No double blank lines | =E2=9C=97 3 failures |
| Proper Tx/Rx capitalization | =E2=9A=A0 Comments use "TX" |

### License Checks

| Check | Status |
|-------|--------|
| New file has SPDX | =E2=9C=93 `tx_scalar_fns.h` has BSD-3-Clause |
| Copyright follows SPDX | =E2=9C=93 Pass |
| Blank line before code | =E2=9C=93 Pass |

---

## Files Changed Summary

- **22 files** modified in patch 1 alone
- **New file created:** `drivers/net/intel/common/tx_scalar_fns.h`
- **Drivers affected:** i40e, iavf, ice, idpf, cpfl, ixgbe
- **Documentation updated:** `doc/guides/nics/i40e.rst` (patch 17)

---

## Recommendations

1. **Critical:** Fix the 135-char line in patch 17 before merge
2. **Important:** Capitalize "Move" in patches 8 and 9 commit messages
3. **Minor:** Remove extra blank lines in patches 6, 7, and 36
4. **Optional:** Consider release notes entry for new EAL macro
5. **Optional:** Standardize comment style to use "Tx" instead of "TX"

---

## Verdict

**Conditional Accept** - Series is well-designed and the code consolidation=
 is valuable. Fix the error (line length) and warnings (commit message capi=
talization, double blank lines) before merge.



