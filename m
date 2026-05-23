Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96FB6CD5BB8
	for <dpdk-dev@archiver.kernel.org>; Sat, 23 May 2026 19:56:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7ABF4402A3;
	Sat, 23 May 2026 21:56:10 +0200 (CEST)
Received: from mail-dy1-f178.google.com (mail-dy1-f178.google.com
 [74.125.82.178]) by mails.dpdk.org (Postfix) with ESMTP id D95FD40265
 for <dev@dpdk.org>; Sat, 23 May 2026 21:56:08 +0200 (CEST)
Received: by mail-dy1-f178.google.com with SMTP id
 5a478bee46e88-3042a388168so2042609eec.1
 for <dev@dpdk.org>; Sat, 23 May 2026 12:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779566168;
 x=1780170968; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S7T8mue8+gLDLVb2pxiw7/oA0sv/nsWy9a/viSHqdyA=;
 b=yyh2jEmp6SJJFJsWC2y7DTG3mRxt9LRKFGLS0okGQIiZbx0IqRcIxhEtsZkGcKf2pw
 pmPnGk3Vdhk7cTL2le1klbIbXQwS++VuAWC5jSIa2XBQGCSW8cbJ+Ua0VRIXcBml673Y
 n6L9Cdv47HTvPchzjBEM+JxrKPexLib1vIDJSdBE8Dd22LzHtQsf8KNVkaTdFJOZNfHh
 Tc756Se55Qh//OOCjPOB/XURXsPRMD6e69Q+mDx2dWt3b+/9rPaEOgKoJWreQ7NHMxs+
 VyhP3k4e5kTT/0+BL/pM8MQJBbnmH+POaeqwbh2Cc+cgGOcjvLF9uTk4+k0XTaVoiHSF
 VIAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779566168; x=1780170968;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=S7T8mue8+gLDLVb2pxiw7/oA0sv/nsWy9a/viSHqdyA=;
 b=ar3UrQj1kYAr44D7CiOewqcHm9AYojXJkTOGD3QkxCXBLPaMIs0/Yq3Z1RjI8Gi/P/
 ZsrPyT50ySYq1DKdPx68Jsgf9Zi05F6w07bVs7+QmdJqbblnWZRCIN/oBQkTuWqlXxtF
 +EsLX5ti0syTzqEdtSPyqoKuYXrqvn/qXk5aJapGCgnARVWyo23a2NaqpAtiHOjCCbhQ
 4ms2UP7fvT7051Q8uANeBMGJpcv7XdVyHkhQ06PAIvPDnv1i7M6VYsN9NxISkMJsNIrH
 mDZIZ0ymbpGrUrYaMimxYFgmVYnUvyqmI9kl5sI3hpSnlaSdZp+JumFHoexOiNe+hQoO
 6Uyg==
X-Gm-Message-State: AOJu0YyP0qnWImd+JafuXEglqPBR4RVot0QTMLv6jlTZ8yqjnxw1Rn+F
 VZAImtXYf1ZapdtgUE1wolWOLJXlVk0oi8JAHdr8mNIEYJjhtUFc70b0N24kayaZiKaUZL0NIEq
 BNUG2
X-Gm-Gg: Acq92OHbtHa+Hrx575I79N+iH2zK81K0EMyXxBhpIYnknyC2lxtAqMT+i3DPLGirXT0
 zvHpueclxU693XEbHe4Hd0mm5FjZrZYwaDwHzt6CRj0/EGCP+OwtjWpHH+QcIIO1yokvzKPYenS
 dS9g+0g+suWgsMlauCwaK98lk58HkxoC1Iyg0nB5gKj2HR9wvR/J+boDD8C8i/OT/yMYnwUgoaJ
 XxVrqkbtY7ZvroV5iT6XZgX1CGgDPFkpiLVej8gwqOIzM6YqyGEr8vRxvR6o3qwXBhWFXnaUpfb
 eykYO++qTkoi3hfI1HmvflaNvBOcS3T3rJbv1XpleKAGvAd/iwWd5cVW6NXdhNO+Th8ZXIshn0o
 exkhBs0wNeDHMIvGlZ3kACFfJRX9PcEoJx0hCVf1XgD/Wz0gEhHoT7PBtXSVfriKem38KmXk7qP
 waD2YsWH+lXr9/HPHNWGcSKYpXnKxDJNTyWArIHEdJ9zRjlGMtxh5+ibuBithQZw==
X-Received: by 2002:a05:693c:68d6:b0:304:6822:2cb2 with SMTP id
 5a478bee46e88-3046822519bmr659864eec.11.1779566167430; 
 Sat, 23 May 2026 12:56:07 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30451f3feadsm5257271eec.13.2026.05.23.12.56.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 23 May 2026 12:56:06 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v3 00/27] deprecate rte_atomicNN family
Date: Sat, 23 May 2026 12:16:02 -0700
Message-ID: <20260523195604.441947-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521042043.1590536-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The rte_atomicNN_* family was flagged for deprecation in 2021 by
commit 3ec965b6de12 ("doc: update atomic operation deprecation")
but enforcement never landed and in-tree usage continued to grow.
v2 covered the EAL changes, lib/ring, and a starter set of drivers.
This series finishes the job: convert every remaining in-tree
caller to the C11-style rte_atomic_*_explicit() / RTE_ATOMIC()
API, then mark the legacy functions __rte_deprecated so future
in-tree and out-of-tree uses are caught at compile time.

Performance: ran the DPDK perf-tests suite (mempool, hash, stack,
ring, distributor, rcu_qsbr, etc.) on the full series; only
lib/ring showed a regression, addressed by the wrapper in patch 03.

Patch organisation
==================

  01-02  EAL: drop the inline-asm fallback paths now that intrinsics
         work on all platforms; reimplement rte_smp_*mb on top of
         rte_atomic_thread_fence.

  03-04  lib/ring and lib/bpf -- the last legacy callers in lib/.

  05-25  Drivers and selftests, one patch per directory.

  26     Suppress deprecation warnings in app/test/test_atomic.c,
         which exercises the legacy API until it goes away.

  27     Mark rte_atomicNN_* with __rte_deprecated and drop the
         corresponding checkpatch grep; new uses are now caught
         at compile time.

Changes since v2
================

Scope: v2 stopped at crypto/ccp (11 patches). v3 adds:

  04        lib/bpf -- the bpf interpreter's atomic op macro
  13-25     Remaining driver/bus/event/vdpa conversions
  26-27     Test-suite warning suppression and the actual
            __rte_deprecated marking

Substantive changes to patches that were in v2:

  02        Also drop the rte_smp_*mb forbidden-token check from
            devtools/checkpatches.sh, since the API is no longer
            on a deprecation cycle.

  03        lib/ring -- keep most of the original code, introduce wrapper
            for the one performance sensitive CAS. This fixes the
            20-30% drop in ring_perf test on x86 which was observed
            when using atomic_compare_exchange_weak_explicit() with GCC.

Feedback wanted
===============

Series is targeting 26.11 rather than the next release.  The driver
conversions touch many maintainers' code and several are likely to
need cycles of review/respin; a longer review window avoids rushing
contested orderings into an earlier release.

  - vmbus producer commit-order pattern (patch 17)
  - the ring CAS wrapper might be improve performance on other similar
    uses of ring buffers in vmbus and netvsc.
  - Dekker-style seq_cst handshake in net/vhost (patch 24), which
    also closes a pre-existing ordering hole on weakly-ordered ISAs
  - netvsc rndis_pending claim/timeout/clear cmpxchg orderings
    (patch 15)

Stephen Hemminger (27):
  eal: use intrinsics for rte_atomic on all platforms
  eal: reimplement rte_smp_*mb with rte_atomic_thread_fence
  ring: use compare-and-swap wrapper
  bpf: replace atomic op macro with typed helpers
  net/bonding: use stdatomic
  net/nbl: remove unused rte_atomic16 field
  net/ena: replace use of rte_atomicNN
  net/failsafe: convert to stdatomic
  net/enic: do not use deprecated rte_atomic64
  net/pfe: use ethdev linkstatus helpers
  net/sfc: replace rte_atomic with stdatomic
  crypto/ccp: replace use of rte_atomic64 with stdatomic
  bus/dpaa: replace rte_atomic16 with stdatomic
  drivers: replace rte_atomic16 with stdatomic
  net/netvsc: replace rte_atomic32 with stdatomic
  event/sw: convert from rte_atomic32 to stdatomic
  bus/vmbus: convert from rte_atomic to stdatomic
  common/dpaax: remove unused atomic macros
  net/bnx2x: convert from rte_atomic32 to stdatomic
  bus/fslmc: replace rte_atomic32 with stdatomic
  drivers/event: replace rte_atomic32 in selftests
  net/hinic: replace rte_atomic32 with stdatomic
  net/txgbe: replace rte_atomic32 with stdatomic
  net/vhost: use stdatomic instead of rte_atomic32
  vdpa/ifc: replace rte_atomic32 with stdatomic
  test/atomic: suppress deprecation warnings for legacy APIs
  eal: mark rte_atomicNN as deprecated

 app/test/test_atomic.c                        |  12 +
 devtools/checkpatches.sh                      |  16 -
 doc/guides/rel_notes/deprecation.rst          |  12 +-
 doc/guides/rel_notes/release_26_07.rst        |   4 +
 drivers/bus/dpaa/base/qbman/qman.c            |   9 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c      |  10 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpci.c      |  10 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      |  12 +-
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h       |   8 +-
 drivers/bus/fslmc/qbman/include/compat.h      |  21 +-
 drivers/bus/vmbus/private.h                   |   2 +-
 drivers/bus/vmbus/vmbus_bufring.c             |  39 ++-
 drivers/common/dpaax/compat.h                 |  14 -
 drivers/crypto/ccp/ccp_crypto.c               |  11 +-
 drivers/crypto/ccp/ccp_crypto.h               |   2 +-
 drivers/crypto/ccp/ccp_dev.c                  |  10 +-
 drivers/crypto/ccp/ccp_dev.h                  |   4 +-
 drivers/event/dpaa2/dpaa2_eventdev_selftest.c |  26 +-
 drivers/event/dpaa2/dpaa2_hw_dpcon.c          |  11 +-
 drivers/event/octeontx/ssovf_evdev_selftest.c |  58 ++--
 drivers/event/sw/sw_evdev.c                   |   8 +-
 drivers/event/sw/sw_evdev.h                   |   4 +-
 drivers/event/sw/sw_evdev_worker.c            |  16 +-
 drivers/net/bnx2x/bnx2x.c                     |   6 +-
 drivers/net/bnx2x/bnx2x.h                     |   2 +-
 drivers/net/bnx2x/ecore_sp.c                  |   6 +-
 drivers/net/bonding/eth_bond_8023ad_private.h |   6 +-
 drivers/net/bonding/rte_eth_bond_8023ad.c     |  35 +-
 drivers/net/ena/base/ena_plat_dpdk.h          |  14 +-
 drivers/net/ena/ena_ethdev.c                  |  21 +-
 drivers/net/ena/ena_ethdev.h                  |   7 +-
 drivers/net/enic/enic.h                       |   6 +-
 drivers/net/enic/enic_compat.h                |   1 -
 drivers/net/enic/enic_main.c                  |  17 +-
 drivers/net/enic/enic_rxtx.c                  |  14 +-
 drivers/net/enic/enic_rxtx_vec_avx2.c         |   4 +-
 drivers/net/failsafe/failsafe_ops.c           |  12 +-
 drivers/net/failsafe/failsafe_private.h       |  29 +-
 drivers/net/failsafe/failsafe_rxtx.c          |   2 +-
 drivers/net/hinic/base/hinic_compat.h         |   2 +-
 drivers/net/hinic/base/hinic_pmd_hwdev.c      |  24 +-
 drivers/net/hinic/base/hinic_pmd_hwdev.h      |   4 +-
 drivers/net/nbl/nbl_hw/nbl_resource.h         |   1 -
 drivers/net/netvsc/hn_rndis.c                 |  28 +-
 drivers/net/netvsc/hn_rxtx.c                  |  12 +-
 drivers/net/netvsc/hn_var.h                   |   6 +-
 drivers/net/pfe/pfe_ethdev.c                  |  32 +-
 drivers/net/sfc/sfc.c                         |   9 +-
 drivers/net/sfc/sfc.h                         |   4 +-
 drivers/net/sfc/sfc_port.c                    |   7 +-
 drivers/net/sfc/sfc_stats.h                   |   2 +-
 drivers/net/txgbe/base/txgbe_mng.c            |   4 +-
 drivers/net/txgbe/base/txgbe_type.h           |   2 +-
 drivers/net/vhost/rte_eth_vhost.c             | 103 +++---
 drivers/vdpa/ifc/ifcvf_vdpa.c                 |  37 +--
 lib/bpf/bpf_exec.c                            |  91 ++++--
 lib/eal/arm/include/rte_atomic_32.h           |  10 -
 lib/eal/arm/include/rte_atomic_64.h           |  10 -
 lib/eal/include/generic/rte_atomic.h          | 305 +++++-------------
 lib/eal/loongarch/include/rte_atomic.h        |  10 -
 lib/eal/ppc/include/rte_atomic.h              | 179 ----------
 lib/eal/riscv/include/rte_atomic.h            |  10 -
 lib/eal/x86/include/rte_atomic.h              | 205 +-----------
 lib/eal/x86/include/rte_atomic_32.h           | 188 -----------
 lib/eal/x86/include/rte_atomic_64.h           | 157 ---------
 lib/ring/rte_ring_generic_pvt.h               |  32 +-
 66 files changed, 585 insertions(+), 1390 deletions(-)

-- 
2.53.0

