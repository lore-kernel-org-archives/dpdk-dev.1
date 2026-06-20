Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B4EECD98F2
	for <dpdk-dev@archiver.kernel.org>; Sat, 20 Jun 2026 02:31:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C5374027F;
	Sat, 20 Jun 2026 04:31:40 +0200 (CEST)
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com
 [74.125.224.44]) by mails.dpdk.org (Postfix) with ESMTP id 3747D4025A
 for <dev@dpdk.org>; Sat, 20 Jun 2026 04:31:39 +0200 (CEST)
Received: by mail-yx1-f44.google.com with SMTP id
 956f58d0204a3-663167a3ba2so204381d50.3
 for <dev@dpdk.org>; Fri, 19 Jun 2026 19:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781922698;
 x=1782527498; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JZD9V63lI5oeC9QKeYbgVKNAJdMIDLHXN4hWVgUMHME=;
 b=t6eOlc9b7LIeECYlwiBSxXIl+jboUN+d2qCGTRo7syFfwjYHRu6Bqhjzq7nqixK8UH
 Eev+wRHcALFvtgIcRZOjw6vG+MGLWY/6c11hyWkGHX+rNtQdUEmC2NPPSbzbMIymwrKd
 wj8KO4wIqSliVkar308ZIyvlfq4zAqI8WPwi0i6HecNS19YaucENERCCkiYSZQN49H+B
 NaGB0sWsLwnx3W/QwyZxrMgEdu7gHP2728uoF7gWUbplBeIgHjrlUuB97AwdinANIk/q
 PGcPhfMZxaSrYYJyspKeOdb15FZBihiH7xDuRTnxJcCj3MgRhjYyUzdYa1qzw+tzhQT5
 h2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781922698; x=1782527498;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=JZD9V63lI5oeC9QKeYbgVKNAJdMIDLHXN4hWVgUMHME=;
 b=Vs+sFBAWz4DqawidtQ71p+v4e2HRPMstbMLhI8m//3RBlX5f1OinYUNkqq6ZCxsLd4
 L9bNjRaitZxlGpIQxay1zhSRNkbtL6fDvHInWtjASVxqr0b4olPRyNdZwgQGzCdky3Iv
 RX5sVK3AhdGJg4h1tIrwq9bWtIeiACI+BAKY4Qh0PuXR3BS2WiamLHtGq5H9g+DWV+Lp
 fyjbnZcr1E5OyF6sUEvpvfiCxp/zDOownYQFrOB6txE7MuzpSOua/TMqGG2PEu63zA9x
 gMjr41Ut1Qb7eInJcT5bOlHHEY8Sgrad7EXPt4BHeWHJT7caabpbyhejroWPYNlrLygF
 9TqQ==
X-Gm-Message-State: AOJu0Yz0Ff1h4mGJ4h8CnlLR5C+J7DgJ5qQSGTo0GqGHBAMMgOU78y9L
 NP8l5nqZGgX9kprkk40zT7R3z2xiyew+Kg7/AycmvvPXjV4wL0WzHpnsiinKBec/rjg8MrHhmN0
 CXrwa
X-Gm-Gg: AfdE7cnpAYkSqwPpDzdofOWCCBIFIRJklseSEwrn6B2NoT6ORQpE7qtwTzHzaHxPLBA
 orIb7N7zbaSkEjCExy4UnCpsDIuy+g806e4S/n9URBMKJPYFCcfSTvzOpxlX1A958W+cpqDx9Zm
 HNzc8e2wpjIjC3DE/gT794N3R+PR1eTgATxv3NQ80xnsDezyWQspeqdtJCQ0zGkdTZK1QuOcw2n
 NMms+NCeLVGp8wQiiynnKVeWxULI/+ooQ9AXUy81m/jbI62A9QIyMjCfyn5nJQVnQ1EBCcZPejB
 9mjrFLG82RDmGEBn6gIxD/JGSG/Phl6hATDYmW3OrAlWnocNiP5A4M7BoOOVbBS2MKCVZUpsSH8
 Jd0XxDTmclcTZ8KvAqMRegcj3EP26WUH4oo/rsTMLV6N9IEmPvox1QhvNCAMhi47OJz7sg0xbAj
 bW0QV8IOpJE+wtJ/jaJQLb9MLa3UeV6qhZtj+/SxikfCLGXJkg2JU=
X-Received: by 2002:a05:690e:1518:b0:660:9441:9e71 with SMTP id
 956f58d0204a3-662ffed6ef0mr6339969d50.37.1781922698035; 
 Fri, 19 Jun 2026 19:31:38 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-8025c96ffd5sm6045897b3.9.2026.06.19.19.31.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 19:31:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 00/24] deprecate rte_atomic functions
Date: Fri, 19 Jun 2026 19:28:25 -0700
Message-ID: <20260620023134.42877-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <https://inbox.dpdk.org/dev/20260521042043.1590536-1-stephen@networkplumber.org>
References: <https://inbox.dpdk.org/dev/20260521042043.1590536-1-stephen@networkplumber.org>
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

v5 - rebase now that ring changes are merged.
   - drop the barrier (rte_smp_mb) patch not required.


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
  eal: deprecate rte_atomicNN functions

 app/test/test_atomic.c                        |  12 +
 devtools/checkpatches.sh                      |   8 -
 doc/guides/rel_notes/deprecation.rst          |   4 +-
 doc/guides/rel_notes/release_26_07.rst        |   5 +
 drivers/bus/dpaa/base/qbman/qman.c            |   9 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c      |  10 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpci.c      |  10 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      |  12 +-
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h       |   8 +-
 drivers/bus/fslmc/qbman/include/compat.h      |  21 +-
 drivers/bus/vmbus/private.h                   |   2 +-
 drivers/bus/vmbus/vmbus_bufring.c             |  39 +--
 drivers/common/dpaax/compat.h                 |  21 +-
 drivers/crypto/ccp/ccp_crypto.c               |  11 +-
 drivers/crypto/ccp/ccp_crypto.h               |   2 +-
 drivers/crypto/ccp/ccp_dev.c                  |  10 +-
 drivers/crypto/ccp/ccp_dev.h                  |   4 +-
 drivers/event/dpaa2/dpaa2_eventdev_selftest.c |  26 +-
 drivers/event/dpaa2/dpaa2_hw_dpcon.c          |  11 +-
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
 66 files changed, 472 insertions(+), 1265 deletions(-)

-- 
2.53.0

