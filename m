Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC0A5C88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 20:11:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6E3E402D3;
	Thu, 17 Sep 2026 22:11:23 +0200 (CEST)
Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com
 [74.125.227.141])
 by mails.dpdk.org (Postfix) with ESMTP id 339E0402AC
 for <dev@dpdk.org>; Thu, 17 Sep 2026 22:11:23 +0200 (CEST)
Received: by mail-pj2-f13.google.com with SMTP id
 d9443c01a7336-2db18fe433fso217705ad.2
 for <dev@dpdk.org>; Thu, 17 Sep 2026 13:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789675882;
 x=1790280682; darn=dpdk.org; 
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=tmBUvbs2Eqk6cLF6eZrSFgrVaBrlTAs9mhG5NNoUJWU=;
 b=Qvehr0HfuP3WZHHltp4w71sIGN84RsfpiPaqDrF6BDTOcmvl/jMRnq0OGCktA5R6Ya
 cRJxiHGE2ypZ1YiZ93nTBbWRm3pWdVQ+E5my8rY8WTz/MRJsmIPCB5MwRP78/0yayRBb
 Hf/56LsiiEo169ghADO+ov1ozmb7JdRHtsrkcc5s1HySov0NrLlpuXjnTBRz4ddiXBGZ
 aJn7E7n7ejrtiXciKw8TPzsteaA6raaG0CL7IulIWEPmbgCWCmPo1wyhZ8Q6Vfb9y70j
 AQCKMSkJN3waGaMCEqheBf4p1PIkCSDwQlq1wukMvgr6eJw4/uIdlhS81JPTsV9A3X7u
 LS7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789675882; x=1790280682;
 h=content-transfer-encoding:content-type:mime-version:references
 :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=tmBUvbs2Eqk6cLF6eZrSFgrVaBrlTAs9mhG5NNoUJWU=;
 b=OseouIUn9AKMsxNShNqfojIvJpHKphI+xbK0PZyFwhFWN3la6j+gmcjZkqO2mqNKpm
 ocVTNr5GfFGR5snZLL6TnCSf3FpoPkkSjUNzTOrgOBvW/WVBMTk2IQyTVPRouo7oTZSs
 BFCswqW6H3P8oi/zJ+8JBxCHgftMm3nGkEzPIJh1hh4baYAGhnvNzcrPgbygy+vjCD0u
 uX2JsAra2TY4xhTviNVt830O4SqmPTvcNNXfKny02XnWikLaGOe9UbkvNh4c0i6PnCYn
 FG0dJ9OQzc+Hbq3q+7h3Ic9Hrx+pCwUtVHPeRv4NTyMkZMIyFk9q/l3sJ3+EbWmAGikB
 ZUMg==
X-Gm-Message-State: AFuF++l0TwFmMk3FG/d9kSqpNOz16ok5Qag1t59pia/04hcr0Yd9VHc9
 izYEVxCGlKgAJTyT6klBSQqP/D5RbjYKYXqR/GudbHCGkK+CyPkHZX4vtR53R+p+AaqLspaE034
 0fRsT
X-Gm-Gg: AYBFou0pXcA0CGYlPBz5MkVkV5h7YSydhXPwoNLkth8aIh1jm1Z0koJDGQydXyaqzXB
 F7wziPH6jnkyS6MXMHsiGWSEJNtie/+HmQJa0MOrKYQm3Jdp70GQa9nsoVzTwKxdrOgPHe4I+F/
 ZmlBWCqF1MDdvyMMfVXzdtgi7VZHV1Crw8F558qVLrhT+ZYIsPrBUWjE+wT5zAQDw9z6aTqCexi
 W8EV2xrNnomOMaNCxuovoo85GdAOkjNg7G2CIhoopFoytWiK1qrnirWYezdLfHtgQYuC/S80NiH
 7H2UWGxyMHOvhjBBDn79Jmz8cNkdJY0pFgRhHlQyZxdSW4kdYfJBtxg1Ten6aISHAuuVjy35J3P
 R0EcHAiCU7EGc2ASezpiEQgy9WEouLQGEPGrbfC/pssIOtc49/oAYsS/FW21wWCKkkr66vdAb2L
 mZy+9EOurhS1rc7P8sMEpRcmeWIcjGqIcaBvLcPPf2/uPolA4oYVuvLu7q2txspiqVw9+wcm7IL
 rpOpsthXFmS5gIVUmCBIPHx5eTlcbAt8BkIUEkZNG1uOUVs
X-Received: by 2002:a17:903:94c:b0:2d9:464f:d45f with SMTP id
 d9443c01a7336-2ddb1ab3b88mr6907275ad.5.1789675881893; 
 Thu, 17 Sep 2026 13:11:21 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2dd89f0870bsm31368345ad.63.2026.09.17.13.11.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 13:11:21 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v8 00/25] remove legacy atomic functions
Date: Thu, 17 Sep 2026 13:10:04 -0700
Message-ID: <20260917201119.2168234-1-stephen@networkplumber.org>
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

Series-acked-by: Morten Brørup <mb@smartsharesystems.com>

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
 68 files changed, 416 insertions(+), 2559 deletions(-)
 delete mode 100644 lib/eal/x86/include/rte_atomic_32.h

-- 
2.53.0

