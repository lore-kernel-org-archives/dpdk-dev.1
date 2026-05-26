Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3671CD5BD5
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 May 2026 23:25:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99CFF4027D;
	Wed, 27 May 2026 01:25:47 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id 996FE4021F
 for <dev@dpdk.org>; Wed, 27 May 2026 01:25:46 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-3045c195251so4410697eec.1
 for <dev@dpdk.org>; Tue, 26 May 2026 16:25:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1779837945;
 x=1780442745; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+FtIrqOhhhfRSbVUqvWAxiNBuXXXnDy/etyBnGyZ+4Q=;
 b=b/5DZJrTAElxtuxeVqy7eK8V+Cjq5vwb6VIewT1ByjZWrAAl4NzXztt72nq8lyygv+
 JnpLyfBDzXP17UUMjLFzh8fTECMYKF/TFrBuvhoWUdnFx5auwF0a1PCqxKjm0c/EIcfg
 qQyJ1CFlm01wpEswZ5TalrYI1CJOVUyGMXx95+6Yz2N8naFamD2Y+fc7XCulvoUOCYMC
 H/K/FKZJemS1eI393XOyr9sHuEajtnM4MTfMZxSnHOQ77iOMlWe6aLV9YN9OA4+temPU
 hs2AxbcUQM4Zduw1DBSuJbJOkut4s72s8R1MHVa887m6DQhvdXwx3HxQesKfx6aUdrpa
 gXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779837945; x=1780442745;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+FtIrqOhhhfRSbVUqvWAxiNBuXXXnDy/etyBnGyZ+4Q=;
 b=TSO8kOkd+ZH/Zij0LpEiQyNiscsT+llT8wFDTsKs/40+VyCmzOK33xaK5DNlm5lycy
 I8xw/uVCIoPL0FK82imebYYFAbf0lwBKlT7BnuZROMGetPwEkSE6zv/WzeMVDo00gtnb
 hF6TE1Kw3LZFSd74hupKgZ9vTk6UwaCN0sWhsnVmjgsMbRLOgeYZ+j3KWR6XA3e02n00
 eTVZm6dr0uqm3967dGFKk0lNuvTDp+YGJuwaOo6DTP1kZqW8O4lfvLSBkNPxERxEsyDP
 GA3Tf9JrfpNUCSp50rf0APiMZU4YO9miEy+nmtT7VDkw2MoyF9yUaNUJymSZ9Ql+i5AU
 I7lw==
X-Gm-Message-State: AOJu0YxZB5I+bagHfn75xw0PGcSUQsovLy21PNneJU/UgKJH0etWCc35
 HYAfnYH+RlhChakVJqJBAEG0r4oG0PU2bYZZtS6SOT17mocaqtvfz34W/vaW39TnKwOEGzxhJD8
 uy7Vn
X-Gm-Gg: Acq92OFTBty6pL3YmNBYtFHEU0YdmgJeQmhv+i8BvAr27Y1XZmwarg/POSjUoKw6fu5
 666wAjm0pdrGuJ+SajcO8CHhghXMLubs8itgo/lU/u8nUSCaRB7q4/gk1n+AY5g4MITA73OK8l4
 zy2VhovyT/4CwBEfmuijaSNnFKPllmgJYYfRkyakoOK1Pje2cQDhMh4VeAym6H6Lj0Kyj7YQV+l
 DAeoRb7IIw0hcM1ybepm2Lkl+OlWoF0xIHj6QkMKu/YK+fQv8HLFXopBAZE3JyxUUZwsYNybkAh
 i0IkVqwThy93xuE2ZMkvqWprSUJ93joXigJ457BjyOpbfju8BGCa4NbS0MaGFFgIliYv7ncEG01
 Lc9MZdlZU1VtnRwkaKKr5L5q/sr6X0ifmkZOzr1RkwFoLizVYGvRN6gwtKl6mmtsT8WPIK/1Dk6
 3Bn1GkoDrsY/DrIQ7N56rEvUYR++qx18CyWhLYWZfgtuZkg+rrd0ClMzAxmUpcsuDpuc/fY8Nrz
 WbcPfgybcs=
X-Received: by 2002:a05:693c:8303:b0:304:8364:e95c with SMTP id
 5a478bee46e88-3048364fb4cmr2923171eec.15.1779837945214; 
 Tue, 26 May 2026 16:25:45 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30452230f1bsm11296132eec.14.2026.05.26.16.25.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 16:25:44 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 00/27] deprecate rte_atomicNN family
Date: Tue, 26 May 2026 16:23:50 -0700
Message-ID: <20260526232542.620966-1-stephen@networkplumber.org>
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
This series finishes converting every remaining in-tree caller to
the C11-style rte_atomic_*_explicit() / RTE_ATOMIC() API, then
marks the legacy functions __rte_deprecated so future in-tree and
out-of-tree uses are caught at compile time.

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

Changes since v3
================

  - lib/ring: keep the existing C11 element-access code; the
    earlier rewrite regressed ring_perf 20-30% on x86 with GCC's
    handling of atomic_compare_exchange_weak_explicit().  v4
    keeps the original structure and adds a wrapper for the one
    performance-sensitive CAS.

  - lib/bpf: keep the BPF_ST_ATOMIC_REG macro structure rather
    than open-coding the converted callers; the macro body is
    rewritten to use stdatomic.

  - Compilation fixes across the driver conversions caught
    during review (CAS expected-value types, format-string
    specifiers, dpaax HWDEBUG path).

Targeting 26.11 rather than the next release.  The driver
conversions touch many maintainers' code and several are likely
to need cycles of review/respin; a longer review window avoids
rushing contested orderings into an earlier release.

Feedback wanted
===============

  - vmbus producer commit-order pattern (patch 17)
  - the ring CAS GCC bug workaround might be needed on other
    similar uses of ring buffers in vmbus and netvsc.
  - Dekker-style seq_cst handshake in net/vhost (patch 24),
    which also closes a pre-existing ordering hole on
    weakly-ordered ISAs
  - netvsc rndis_pending claim/timeout/clear cmpxchg orderings
    (patch 15)

Stephen Hemminger (27):
  eal: use intrinsics for rte_atomic on all platforms
  eal: reimplement rte_smp_*mb with rte_atomic_thread_fence
  ring: unify memory model on C11, remove atomic32
  bpf: use C11 atomics in BPF_ST_ATOMIC_REG
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
  common/dpaax: use stdatomic instead of rte_atomic
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
 drivers/common/dpaax/compat.h                 |  21 +-
 drivers/crypto/ccp/ccp_crypto.c               |  11 +-
 drivers/crypto/ccp/ccp_crypto.h               |   2 +-
 drivers/crypto/ccp/ccp_dev.c                  |  10 +-
 drivers/crypto/ccp/ccp_dev.h                  |   4 +-
 drivers/event/dpaa2/dpaa2_eventdev_selftest.c |  26 +-
 drivers/event/dpaa2/dpaa2_hw_dpcon.c          |  11 +-
 drivers/event/octeontx/ssovf_evdev_selftest.c |  61 ++--
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
 lib/bpf/bpf_exec.c                            |  13 +-
 lib/eal/arm/include/rte_atomic_32.h           |  10 -
 lib/eal/arm/include/rte_atomic_64.h           |  10 -
 lib/eal/include/generic/rte_atomic.h          | 306 +++++-------------
 lib/eal/include/rte_common.h                  |   2 +
 lib/eal/loongarch/include/rte_atomic.h        |  10 -
 lib/eal/ppc/include/rte_atomic.h              | 179 ----------
 lib/eal/riscv/include/rte_atomic.h            |  10 -
 lib/eal/x86/include/rte_atomic.h              | 205 +-----------
 lib/eal/x86/include/rte_atomic_32.h           | 188 -----------
 lib/eal/x86/include/rte_atomic_64.h           | 157 ---------
 lib/ring/meson.build                          |   2 +-
 lib/ring/rte_ring_c11_pvt.h                   |  75 ++---
 lib/ring/rte_ring_elem_pvt.h                  | 125 ++++++-
 ..._ring_generic_pvt.h => rte_ring_x86_pvt.h} |  61 +---
 lib/ring/soring.c                             |  15 +-
 71 files changed, 667 insertions(+), 1489 deletions(-)
 rename lib/ring/{rte_ring_generic_pvt.h => rte_ring_x86_pvt.h} (60%)

-- 
2.53.0

