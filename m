Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19C59CA5FAE
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 14:04:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B49C4275A;
	Tue, 29 Sep 2026 16:04:14 +0200 (CEST)
Received: from mail-pz2-f39.google.com (mail-pz2-f39.google.com
 [74.125.228.39]) by mails.dpdk.org (Postfix) with ESMTP id 0EB3A400EF
 for <dev@dpdk.org>; Tue, 29 Sep 2026 16:04:13 +0200 (CEST)
Received: by mail-pz2-f39.google.com with SMTP id
 41be03b00d2f7-cc7979d1dedso1272599a12.3
 for <dev@dpdk.org>; Tue, 29 Sep 2026 07:04:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1790690652;
 x=1791295452; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oX4PdFUkb35D3tdLVt+2CjSPXFu8YaIOOVywWMJrSQ0=;
 b=LOoKxtiCGRKqcyPLpTGyiZMbQ2n1+kuujozsCilhbj/AKsJAbkvchKgkD2KtsiDWFY
 XENo0rz7XqGyEc+/pQmwdF33gowvacrHmu5O9X21Gd2DnoMeczZHK7ar4mjg51oFaCfM
 vAX40X8FNZ7ziRtpOZgWizxOofsQtYSDJA4ZA2ZeZZstNuovE8HHJDKFEB0PK7dtgN+s
 bUWLZ/U+FkQ07cRgKlB2znbf0OIcHteu+34223wT02YLhFt0FmqE+ZjLJYwdRLvAfj8+
 mnlw+CpW5KYlHmV/QLe3uDRcPKInapORtl36cwIasUbR/ib+917ij05xBC0ext3mifsB
 OChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790690652; x=1791295452;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oX4PdFUkb35D3tdLVt+2CjSPXFu8YaIOOVywWMJrSQ0=;
 b=uk9wRtWjJpCaTdHbFtW2zbEI6+ufKfWmJanWUCn/DT8SrzKYtSfyB7I7VBCXorOh8t
 BzTldJRAv3qkk4ErNxYDgV7YtEQliwCTyZOKv1izLwA7APBcT1LmBwgCHU+ObSudIp4k
 IcYvHCsItdcecyrOz/P1NuUZRNFPrdi7fFeHtoorytKTCQk3wNNuEMrGTEAcSz03sFOz
 /jc00EDFkBzZJeuv8DE8GCHY1nkFUEct/IQKIBi2kQIIzzpKFmwxj2BbvqTGaIwiZb7c
 4rm4PvD36KdFrjJfc+2Cgr8QQAGDSDYwUim/9zc/vB4YdvwfpT1EXoG/XnIfoN0fmt5O
 uXQw==
X-Gm-Message-State: AFuF++nfz+2KCcR+XsACM9uMoOK/iOdH2v4i/a3MideRVg9hKB67IEEk
 zXRxzuYf/R47drqelpWwHy8AYzjWeIR3/I3OarQGiXUUfVbmeeYB5leUGAbi7cFkTEUrzYpEjr/
 oTyYVmCY=
X-Gm-Gg: AYBFou06Z/lU/lC0ahtsvBmFoRzfdu4qT5zoimVNxhssfgOC4Caqk68IL4wHre6b2fL
 E9ExmlZeGHnF+iRPwggFsUvsOzJ1YPa0n8g/c84QlrnwpYfMxf3gra3BtjxmpLBHwYcnO2Jeqg6
 TmD8SZ7Ol9knNSD3EzskjQE6/rYmcjzrW2PCIoRMNOKqnQItIxvPwwQ1LpHsgJj/KI6M2M9JMjk
 xymTWvihcEBTq+6voxmU5huydarnr/11CDLIiKADO8QKEEfi3SAyF/63fbX28Eu+5Lmg2WExZKC
 ivT4jVhfCV8/P40/3fUlLQH7HtroiMmstbyj8CxQ5StgKHP6d2R0FzbaXDGYRzjXDkuuHsaVtp3
 7suE1VsAib5SxGi7DMY/lNEju/rIW8gFKJmXhT2nP8ahagc1r7u2HqLm0Mz5FsGLsz3VHHOJklv
 ZOwKq/k8PssUILLXMX7ernSGXTanzZhAD1sNRw5nZVFOc9x+M3EjEPHLwF3LNOrbfSnV9GgyvSH
 XqqOhck6LloAkWuFYnKjizikQqJzZIpoglTkQ==
X-Received: by 2002:a05:6a20:7fa3:b0:3de:7701:d15b with SMTP id
 adf61e73a8af0-3de7701d778mr4006374637.49.1790690651785; 
 Tue, 29 Sep 2026 07:04:11 -0700 (PDT)
Received: from phoenix.lan (204-195-112-43.wavecable.com. [204.195.112.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-885e1066470sm998330b3a.18.2026.09.29.07.04.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 07:04:11 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v9 00/25] remove legacy atomic functions
Date: Tue, 29 Sep 2026 07:01:46 -0700
Message-ID: <20260929140409.234453-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260521042043.1590536-1-stephen@networkplumber.org>
References: <20260521042043.1590536-1-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
but removal had stalled and usage continued to grow.

This series finishes converting every remaining in-tree caller to
the C11-style rte_atomic_*_explicit() / RTE_ATOMIC() API, then
removes the legacy functions. The deprecation has been out there
long enough so not a big surprise to users.

The eal/ring/smp_mb changes that were part of the earlier RFC and
v1-v5 postings are not in this series; they are being handled
separately since the ring memory model discussion is independent
of removing the legacy API.

Series-acked-by: Morten Brørup <mb@smartsharesystems.com>

v9 - rebase to main
     - enic: remove extra memset
     - failsafe: zmalloc of txq and rxq consistency

v8 - drop unused in_use flag in dpaa
   - consolidate fslmc changes
   - vmbus: use acquire ordering on the wait for the previous
     producer so an earlier producer's data writes are carried by
     this thread's release store (Long Li)
   - collect review tags
   - more AI review comments

v7 - fix some review comments
   - remove unused macros
   - remove ret_atomicNN functions (rather than deprecating them).

v6 - rebase for 26.11
   - address some more AI review comments

Stephen Hemminger (25):
  bpf: use C11 atomics in BPF_ST_ATOMIC_REG
  net/bonding: use stdatomic
  net/nbl: remove unused rte_atomic16 field
  net/ena: replace use of rte_atomicNN
  net/failsafe: convert to stdatomic
  net/enic: do not use deprecated rte_atomic64
  net/pfe: use ethdev linkstatus helpers
  net/sfc: replace rte_atomic with stdatomic
  crypto/ccp: replace use of rte_atomic64 with stdatomic
  bus/dpaa: remove unused in_use field
  bus/dpaa: replace rte_atomic16 with stdatomic
  bus/fslmc: replace rte_atomic with stdatomic
  common/dpaax: remove unused atomic wrappers
  net/netvsc: replace rte_atomic32 with stdatomic
  event/sw: convert from rte_atomic32 to stdatomic
  bus/vmbus: convert from rte_atomic to stdatomic
  net/bnx2x: convert from rte_atomic32 to stdatomic
  drivers/event: replace rte_atomic32 in selftests
  net/hinic: replace rte_atomic32 with stdatomic
  net/txgbe: replace rte_atomic32 with stdatomic
  net/vhost: use stdatomic for state flags
  net/vhost: use stdatomic instead of rte_atomic32
  vdpa/ifc: replace rte_atomic32 with stdatomic
  test/atomic: drop old rte_atomicNN tests
  eal: remove rte_atomicNN functions

 app/test/test_atomic.c                        | 523 +---------
 devtools/checkpatches.sh                      |   8 -
 .../prog_guide/writing_efficient_code.rst     |   9 +-
 doc/guides/rel_notes/deprecation.rst          |   7 -
 doc/guides/rel_notes/release_26_11.rst        |   7 +
 drivers/bus/dpaa/base/qbman/bman.c            |   7 +-
 drivers/bus/dpaa/base/qbman/qman.c            |   9 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c      |  11 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpci.c      |  11 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpcon.c     |  11 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      |  14 +-
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h       |   9 +-
 drivers/bus/fslmc/qbman/include/compat.h      |  18 +-
 drivers/bus/vmbus/private.h                   |   2 +-
 drivers/bus/vmbus/vmbus_bufring.c             |  40 +-
 drivers/common/dpaax/compat.h                 |  14 -
 drivers/crypto/ccp/ccp_crypto.c               |  11 +-
 drivers/crypto/ccp/ccp_crypto.h               |   2 +-
 drivers/crypto/ccp/ccp_dev.c                  |  10 +-
 drivers/crypto/ccp/ccp_dev.h                  |   4 +-
 drivers/event/dpaa2/dpaa2_eventdev_selftest.c |  26 +-
 drivers/event/octeontx/ssovf_evdev_selftest.c |  57 +-
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
 drivers/net/enic/enic_main.c                  |  21 +-
 drivers/net/enic/enic_rxtx.c                  |  14 +-
 drivers/net/enic/enic_rxtx_vec_avx2.c         |   4 +-
 drivers/net/failsafe/failsafe_ops.c           |  16 +-
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
 drivers/net/vhost/rte_eth_vhost.c             |  92 +-
 drivers/vdpa/ifc/ifcvf_vdpa.c                 |  37 +-
 lib/bpf/bpf_exec.c                            |  13 +-
 lib/eal/arm/include/rte_atomic_32.h           |   4 -
 lib/eal/arm/include/rte_atomic_64.h           |   4 -
 lib/eal/include/generic/rte_atomic.h          | 928 ------------------
 lib/eal/loongarch/include/rte_atomic.h        |   4 -
 lib/eal/ppc/include/rte_atomic.h              | 175 ----
 lib/eal/riscv/include/rte_atomic.h            |   4 -
 lib/eal/x86/include/meson.build               |   1 -
 lib/eal/x86/include/rte_atomic.h              | 187 +---
 lib/eal/x86/include/rte_atomic_32.h           | 212 ----
 lib/eal/x86/include/rte_atomic_64.h           | 157 ---
 68 files changed, 415 insertions(+), 2568 deletions(-)
 delete mode 100644 lib/eal/x86/include/rte_atomic_32.h

-- 
2.53.0

