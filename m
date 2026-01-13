Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E70CD2F347
	for <dpdk-dev@archiver.kernel.org>; Tue, 13 Jan 2026 17:17:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9AD35402DE;
	Tue, 13 Jan 2026 18:17:30 +0100 (CET)
Received: from mail-ed1-f68.google.com (mail-ed1-f68.google.com
 [209.85.208.68]) by mails.dpdk.org (Postfix) with ESMTP id D7894402D6
 for <dev@dpdk.org>; Tue, 13 Jan 2026 18:17:28 +0100 (CET)
Received: by mail-ed1-f68.google.com with SMTP id
 4fb4d7f45d1cf-653780e9eb3so1090438a12.1
 for <dev@dpdk.org>; Tue, 13 Jan 2026 09:17:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768324648;
 x=1768929448; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PzWgCcO9NMxs97V+uT6GYuvl5qklSDYSAOBWRNHu8Lk=;
 b=RToCpyHM3ouGrUJGiU4XGT2qeiTETr23VV3GtR9aT9k8YdziskDay0mbzLDOohW2Yo
 icwvVo4kwlpSRB+79QSWmDB9tNw192ATVAKtnvoJkRpQ4gQ2Zh/HcUPzQeaV9TDjxOYI
 qmJCwiHuacwIJx/5FZ4V6yCeoq35b4wLM5qYSHJagZMhVRKy3XUJosCwnUp/Sg9xGYOE
 0eniS0EgXnxEwJOyRvdJ5g2MUOg/n5MKgF3cp29FO2OXSf8tegVfYbxOP0gU3SDoPQMg
 80RBHfl6TvCTNEVkrNHErAD/8yAXICehO1vHNqTcYsHRNaPtbaJbt5MZSbK5n4WeHqAa
 SB6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768324648; x=1768929448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PzWgCcO9NMxs97V+uT6GYuvl5qklSDYSAOBWRNHu8Lk=;
 b=rqZIoBwX4EsCa7Og/JkN8LcfxJytvC1d2lflpgX5ymEmaqV+oM7NW0EfOJ8AjHTieo
 xLFTTrzBEVLw6N8iM2JErFzDCNDu6OO72SizXiBlvhj2uFQSpxN66LNtnsEXtWaZYzyO
 VV3VIfT5KkssWC7LdEz9egrPtSzxoiJXUU1FBU44iCDlL81VDpZ8IeebicckK+G4Psbi
 DzDjUV6BA1NHPwnvmMoOaY98CXaYAdFGG8E7YsxMRu45RP1mc5sSe7lsxdW4KU5Vqemh
 J4eNuN4cUc3hxxfw6OMMG7wnGss6PHkHXJn4AtaHU7RROpKNR7Ivpm6vzbHnQw6IUU+M
 ahZA==
X-Gm-Message-State: AOJu0YyxCld9XyadVKCvCthpXrjxzPFP6A5sMnRasIDageVo5Ojv+J27
 gihvGOXXEyHgKU7t2GrvqZ3al4lmUJnba5UNU5lCpnNp3mnIqjh/oJ1xTxR2BFLYJVI=
X-Gm-Gg: AY/fxX5D7Y/sbqSF4wrNZ5BGeFKiDfcWjA2chuhKodxO2/Z1n0HkmKAmcQ2jTy+F4dp
 ggQOD7kkOXCFdtDpAEGNiraErW6OVtLUT3y303cUrP7BQFrpfuQVtI+IoDt26+UuBhh0FHXJeEZ
 kjjmLMn7DQxb40xuE2ex69HLF5/8Ui63x2rJgJDceOOmCxvF+nRQc7Ozx7Y/aFBsIPyPnBzamU7
 cACbPBV/VQDWpuiXqOt2orfJDPzcFRi0EZWnFBGzOh7zKntsBmyEMsGjvNAupSsxKBJb/hIsAZL
 jzY/cULimVQaa9W+ktrFG31Hibt/fSew6BExBhxSX18b2WN+6w+hk50wShWATZ0bW4JmSG+Yia8
 1ekc8+e8zjEO7pzfGtfJ/bGLcFZ8Fugl+Jtf7PLXigNK4qlRrd4Nno5YMT9yj/P0aWQZ6uYyjeb
 UcMNk8jjt6cr5/mAFTJECnKiEm5dmCRTxnY4c2uV1OqIZNUsR+g22N
X-Google-Smtp-Source: AGHT+IFKp/zb4GzpJK1yWTaFHtsV3Ps7IJpJWPk3o06nqxjoqUpPTKE9RJsfY55W6vV0poxLS4+h0A==
X-Received: by 2002:a17:907:2d2b:b0:b87:2f29:206f with SMTP id
 a640c23a62f3a-b872f2938e1mr454794566b.17.1768324648163; 
 Tue, 13 Jan 2026 09:17:28 -0800 (PST)
Received: from phoenix.local (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b842a56c547sm2269323666b.69.2026.01.13.09.17.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Jan 2026 09:17:27 -0800 (PST)
Date: Tue, 13 Jan 2026 09:17:21 -0800
From: Stephen Hemminger <stephen@networkplumber.org>
To: Bruce Richardson <bruce.richardson@intel.com>
Cc: dev@dpdk.org
Subject: Re: [PATCH v2 00/36] combine multiple Intel scalar Tx paths
Message-ID: <20260113091721.4ef71ed6@phoenix.local>
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
> --
> 2.51.0


Series-Acked-by: Stephen Hemminger <stephen@networkplumber.org>

Looks ok to me, asked Claude for second opinion.

Its suggestion about long log message is overblown.
Although, I would suggest being more succinct.=20

# DPDK Patch Review: Intel Tx Consolidation Series (v2)

**Series:** `[PATCH v2 01-36/36]` Intel Tx code consolidation =20
**Author:** Bruce Richardson <bruce.richardson@intel.com> =20
**Patches Reviewed:** 36 =20
**Review Date:** January 13, 2026

---

## Executive Summary

This is a substantial refactoring series that consolidates Tx (transmit) de=
scriptor structures and functions across Intel network drivers (i40e, ice, =
iavf, idpf, ixgbe). The series is well-structured with clear commit message=
s and proper attribution. A few minor issues were identified.

| Severity | Count |
|----------|-------|
| Error    | 1     |
| Warning  | 4     |
| Info     | 2     |

---

## Errors (Must Fix)

### 1. Patch 17/36: Line exceeds 100 characters

**File:** `drivers/net/intel/i40e/i40e_rxtx.c` =20
**Subject:** `net/i40e: document requirement for QinQ support`

```c
PMD_DRV_LOG(WARNING, "Double VLAN insertion may not work correctly without =
RTE_ETH_RX_OFFLOAD_VLAN_EXTEND set in Rx configuration.");
```

**Issue:** Line is 136 characters, exceeding the 100-character limit for so=
urce code.

**Suggested fix:** Split the log message:
```c
PMD_DRV_LOG(WARNING, "Double VLAN insertion may not work correctly "
		"without RTE_ETH_RX_OFFLOAD_VLAN_EXTEND set in Rx configuration.");
```

---

## Warnings (Should Fix)

### 2. Patch 14/36: Implicit pointer comparison

**File:** `drivers/net/intel/common/tx_scalar_fns.h` =20
**Subject:** `net/intel: add IPsec hooks to common Tx function`

```c
md =3D RTE_MBUF_DYNFIELD(mbuf, txq->ipsec_crypto_pkt_md_offset,
			     struct iavf_ipsec_crypto_pkt_metadata *);
if (!md)
```

**Issue:** Pointer comparison uses `!md` instead of explicit `md =3D=3D NUL=
L`.

**Suggested fix:**
```c
if (md =3D=3D NULL)
```

### 3. Patch 16/36: Implicit integer comparison

**File:** `drivers/net/intel/iavf/iavf_rxtx.c` =20
**Subject:** `net/iavf: use common scalar Tx function`

```c
if (!iavf_calc_context_desc(mbuf, iavf_vlan_flag))
```

**Issue:** `iavf_calc_context_desc()` returns `uint16_t`. Comparison should=
 be explicit.

**Suggested fix:**
```c
if (iavf_calc_context_desc(mbuf, iavf_vlan_flag) =3D=3D 0)
```

### 4. Patches 19, 25, 26: Implicit integer comparison with rte_is_power_of=
_2()

**Multiple files across patches**

```c
if (!rte_is_power_of_2(tx_rs_thresh)) {
```

**Issue:** While `rte_is_power_of_2()` acts as a boolean predicate, it retu=
rns `int`. Strictly, the comparison should be explicit.

**Suggested fix:**
```c
if (rte_is_power_of_2(tx_rs_thresh) =3D=3D 0) {
```

*Note: This is a borderline issue as the function is semantically boolean. =
May be acceptable.*

### 5. Patch 36/36: Double blank lines

**File:** `drivers/net/intel/idpf/idpf_common_rxtx.c` =20
**Subject:** `net/idpf: enable simple Tx function`

```c
	return ci_xmit_pkts_simple(tx_queue, tx_pkts, nb_pkts);
}


/* TX prep functions */
```

**Issue:** Two consecutive blank lines after function definition.

**Suggested fix:** Remove one blank line.

---

## Info (Consider)

### 6. Patch 20/36: New EAL macro without release notes

**File:** `lib/eal/include/rte_common.h` =20
**Subject:** `eal: add macro for marking assumed alignment`

The patch adds `__rte_assume_aligned` macro to EAL common header. While thi=
s is an internal optimization helper, significant EAL additions typically w=
arrant a release note entry.

**Suggestion:** Consider adding a brief mention in release notes for the cu=
rrent release cycle.

### 7. Overall: No documentation for new internal APIs

The series adds new internal functions (e.g., `idpf_dp_singleq_xmit_pkts_si=
mple`) marked with `__rte_internal`. While internal APIs don't require Doxy=
gen, brief inline comments explaining their purpose would aid maintainabili=
ty.

---

## Compliance Summary

### Commit Message Checklist

| Check | Status |
|-------|--------|
| Subject lines =E2=89=A460 characters | =E2=9C=85 All pass (max: 51 chars)=
 |
| Lowercase after colon | =E2=9C=85 All pass |
| Correct component prefix | =E2=9C=85 All pass (`net/intel:`, `net/i40e:`,=
 `eal:`, etc.) |
| Imperative mood | =E2=9C=85 All pass |
| No trailing period | =E2=9C=85 All pass |
| Signed-off-by present | =E2=9C=85 All 36 patches |
| Real name and valid email | =E2=9C=85 Bruce Richardson <bruce.richardson@=
intel.com> |
| Body wrapped at 75 chars | =E2=9C=85 All pass |

### Code Style Checklist

| Check | Status |
|-------|--------|
| Lines =E2=89=A4100 characters | =E2=9D=8C 1 violation (Patch 17) |
| No trailing whitespace | =E2=9C=85 Pass |
| `__rte_internal` alone on line | =E2=9C=85 Correct usage |
| Explicit pointer comparisons | =E2=9A=A0=EF=B8=8F 1 violation (Patch 14) |
| Explicit integer comparisons | =E2=9A=A0=EF=B8=8F ~6 instances |
| No double blank lines | =E2=9A=A0=EF=B8=8F 1 violation (Patch 36) |
| No unnecessary void* casts | =E2=9C=85 Pass |
| No forbidden tokens | =E2=9C=85 Pass |

### Structure Checklist

| Check | Status |
|-------|--------|
| Each commit compiles independently | =E2=9C=85 Appears correct |
| Code and docs updated together | =E2=9C=85 Patch 17 adds docs with code |
| New internal APIs marked `__rte_internal` | =E2=9C=85 Correct |
| Release notes updated | =E2=9A=A0=EF=B8=8F Consider for EAL changes |

---

## Technical Assessment

The series accomplishes significant code consolidation:

1. **Common Tx descriptor structure** (`struct ci_tx_desc`) unifies identic=
al 16-byte descriptors across i40e, iavf, ice, and idpf drivers.

2. **Shared scalar Tx function** (`ci_xmit_pkts()`) reduces code duplicatio=
n significantly.

3. **Simple Tx path** optimization enables scalar code to use the more effi=
cient vector SW ring entry format.

4. **New EAL macro** (`__rte_assume_aligned`) provides portable way to mark=
 pointer alignment assumptions for compiler optimization.

The refactoring maintains backward compatibility and should not introduce f=
unctional regressions.

---

## Recommendation

**Acceptable with minor revisions.** Address the Error and consider fixing =
the Warnings before merge.

---

*Review generated according to DPDK AGENTS.md guidelines*


