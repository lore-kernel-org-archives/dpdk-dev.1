Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81B33C55167
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Jul 2026 04:59:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D61C40262;
	Fri, 31 Jul 2026 06:59:54 +0200 (CEST)
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com
 [209.85.214.170])
 by mails.dpdk.org (Postfix) with ESMTP id CD3EA40151
 for <dev@dpdk.org>; Fri, 31 Jul 2026 06:59:52 +0200 (CEST)
Received: by mail-pl1-f170.google.com with SMTP id
 d9443c01a7336-2caced6038eso4497585ad.0
 for <dev@dpdk.org>; Thu, 30 Jul 2026 21:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1785473992;
 x=1786078792; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=yNtVJTmjT/LfahaOPO9qfvRxJJiJm4kXYxIMqEH9hh0=;
 b=cdlA7TSygZq09A5tiJKX8dCMvzQzoS0fyZRdm9GaVtuYb/QQIA6W86tFNoOvWoTLuO
 09kaWMXd/frWm/b7CQQI5hELjIXgSgO184sZbTmRjstagbiyeJW7NYhlFo133eRfw5F0
 xaHLg6IgCKgCGwhgqMBTXMnAKX8uegREbPBUpRc+cZFHHNV+uXOVeKd7xoZd0bhTg1v1
 gBJO4MpxPJQfznWfuy6ksSLCeKctfQPhiUexqqTPxs5K5UAQhTtao9TXszMIArgWiH47
 Ucjx8Sx+XBXiHOrzmGzvpI8JhZ5572sJEMXqUQ+g4hfYlcE/Wv74oLSJx4L+Z7yFjZGz
 pbQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785473992; x=1786078792;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=yNtVJTmjT/LfahaOPO9qfvRxJJiJm4kXYxIMqEH9hh0=;
 b=d4NMDoYA5+IwEJF5I3SEXbPcNkQsYUK6C13jmxI6qeQJ5K1ouRlzMy1ZgAKRkn48R+
 ghSNqMlkejn7Y+5fa5J6NGDBQ2Kt80vZzv/hpOBbM0FvTwyb7HVMz/vVf0fvCLaJWJf1
 39sRHr/2Vr3MlwKIF6zn+CIwvBwhfJQFFzsmkUl0K9LhaLvxXX0G+S/aH6YAs7V58ORe
 olikpsFRJ3Fz5DRnLuHZNgnlyW28RR4e6xbdW82Dtx6enLoestGAr8MoJDWAEFPO34ux
 ZjeodKytmOL4Xb6ERiEnhhSTOGNg5LWBY3qaoNmXaOSU0KyBf6Ljcr29kYrpUBag0dMY
 MiCg==
X-Gm-Message-State: AOJu0YxAHkbvCE9rv+FfMVijLacO2VKIjf3x+AzdE6x0bbHLLWDDbvS1
 LnIe5lRBYEkFswFnzXmUY1/q8/cWm9el67Pw0uNAeP4FlyaemIUWezBsF7wIGzv4rdz6Qs71tIt
 NlJWz
X-Gm-Gg: AR+sD1003qE5OlWDs2jsCZm+vh9MpbNqaSinf4luN/54Kr1dHZAWevmxkkTntxUqTha
 V7fVhEOjt3gZ4wVDimUtz2EQxM8+NEeQ7mRRrUlvBlHO9KdWiabY2TCibON6O4+2+FFyXQduXz3
 pfiF+CTdW3iZ+/7ix++N7xtaErt1iEgaqfduM3HmJm4KEdu+SyQdHgU0Brca3k7KQnfpfHc5Qk0
 DLmXXkK1aImkhLC4vmAdqmUm9CUb8E0jdexYK1EWkKHtMqjK0wsoy8fIyBbswoM3GIp+idzsM/b
 4A7uZ/Jy2t0AV/iD6EMF7+azFDZpLGIoYh7fL8eojivD2RjDancFlJPhKfqZa1/zWFC3lR2LNXN
 d49Vo8qT754tW46ZHneHU/tIYid61nDLMX20IJh6hRG+ClqpfuJqUfNQT4X/OdQETncQbgFDMrs
 7o4LNrdzZVhPDkP6LxGlFz7IKv3fR+j61Gf63Qj9vzp1RWrAk4HFfzry9izsn/Syx7XOeKot4mz
 UnVpkO693NzqfgF/N59FhPGI310DZ8vhjdAIA==
X-Received: by 2002:a17:903:2a88:b0:2cf:4c37:d955 with SMTP id
 d9443c01a7336-2d047eac04cmr4112335ad.27.1785473991558; 
 Thu, 30 Jul 2026 21:59:51 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3153e06f0f9sm823245eec.23.2026.07.30.21.59.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 21:59:51 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v6 00/24] replace use of rte_atomicNN
Date: Thu, 30 Jul 2026 21:57:38 -0700
Message-ID: <20260731045948.769926-1-stephen@networkplumber.org>
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

The goal of this series is to get driver writers to review and
test each change.

v6 - rebase for 26.11
   - address some more AI review comments

Stephen Hemminger (24):
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
  bus/fslmc: replace rte_atomic16 with stdatomic
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
  eal: deprecate rte_atomicNN functions

 app/test/test_atomic.c                        |  12 +
 devtools/checkpatches.sh                      |   8 -
 doc/guides/rel_notes/deprecation.rst          |   4 +-
 doc/guides/rel_notes/release_26_11.rst        |   5 +
 drivers/bus/dpaa/base/qbman/qman.c            |   9 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c      |  11 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpci.c      |  11 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpcon.c     |  11 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      |  14 +-
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h       |   9 +-
 drivers/bus/fslmc/qbman/include/compat.h      |  21 +-
 drivers/bus/vmbus/private.h                   |   2 +-
 drivers/bus/vmbus/vmbus_bufring.c             |  39 +--
 drivers/common/dpaax/compat.h                 |  25 +-
 drivers/crypto/ccp/ccp_crypto.c               |  11 +-
 drivers/crypto/ccp/ccp_crypto.h               |   2 +-
 drivers/crypto/ccp/ccp_dev.c                  |  10 +-
 drivers/crypto/ccp/ccp_dev.h                  |   4 +-
 drivers/event/dpaa2/dpaa2_eventdev_selftest.c |  26 +-
 drivers/event/octeontx/ssovf_evdev_selftest.c |  61 +++--
 drivers/event/sw/sw_evdev.c                   |   8 +-
 drivers/event/sw/sw_evdev.h                   |   4 +-
 drivers/event/sw/sw_evdev_worker.c            |  16 +-
 drivers/net/bnx2x/bnx2x.c                     |   6 +-
 drivers/net/bnx2x/bnx2x.h                     |   2 +-
 drivers/net/bnx2x/ecore_sp.c                  |   6 +-
 drivers/net/bonding/eth_bond_8023ad_private.h |   6 +-
 drivers/net/bonding/rte_eth_bond_8023ad.c     |  35 +--
 drivers/net/ena/base/ena_plat_dpdk.h          |  14 +-
 drivers/net/ena/ena_ethdev.c                  |  21 +-
 drivers/net/ena/ena_ethdev.h                  |   7 +-
 drivers/net/enic/enic.h                       |   6 +-
 drivers/net/enic/enic_compat.h                |   1 -
 drivers/net/enic/enic_main.c                  |  17 +-
 drivers/net/enic/enic_rxtx.c                  |  14 +-
 drivers/net/enic/enic_rxtx_vec_avx2.c         |   4 +-
 drivers/net/failsafe/failsafe_ops.c           |  12 +-
 drivers/net/failsafe/failsafe_private.h       |  29 ++-
 drivers/net/failsafe/failsafe_rxtx.c          |   2 +-
 drivers/net/hinic/base/hinic_compat.h         |   2 +-
 drivers/net/hinic/base/hinic_pmd_hwdev.c      |  24 +-
 drivers/net/hinic/base/hinic_pmd_hwdev.h      |   4 +-
 drivers/net/nbl/nbl_hw/nbl_resource.h         |   1 -
 drivers/net/netvsc/hn_rndis.c                 |  28 +-
 drivers/net/netvsc/hn_rxtx.c                  |  12 +-
 drivers/net/netvsc/hn_var.h                   |   6 +-
 drivers/net/pfe/pfe_ethdev.c                  |  32 +--
 drivers/net/sfc/sfc.c                         |   9 +-
 drivers/net/sfc/sfc.h                         |   4 +-
 drivers/net/sfc/sfc_port.c                    |   7 +-
 drivers/net/sfc/sfc_stats.h                   |   2 +-
 drivers/net/txgbe/base/txgbe_mng.c            |   4 +-
 drivers/net/txgbe/base/txgbe_type.h           |   2 +-
 drivers/net/vhost/rte_eth_vhost.c             | 103 +++++---
 drivers/vdpa/ifc/ifcvf_vdpa.c                 |  37 +--
 lib/bpf/bpf_exec.c                            |  13 +-
 lib/eal/arm/include/rte_atomic_32.h           |   4 -
 lib/eal/arm/include/rte_atomic_64.h           |   4 -
 lib/eal/include/generic/rte_atomic.h          | 243 +++++-------------
 lib/eal/include/rte_common.h                  |   2 +
 lib/eal/loongarch/include/rte_atomic.h        |   4 -
 lib/eal/ppc/include/rte_atomic.h              | 173 -------------
 lib/eal/riscv/include/rte_atomic.h            |   4 -
 lib/eal/x86/include/rte_atomic.h              | 172 -------------
 lib/eal/x86/include/rte_atomic_32.h           | 188 --------------
 lib/eal/x86/include/rte_atomic_64.h           | 157 -----------
 66 files changed, 482 insertions(+), 1264 deletions(-)

-- 
2.53.0

