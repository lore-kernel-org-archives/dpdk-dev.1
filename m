Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29028CCFA03
	for <dpdk-dev@archiver.kernel.org>; Thu,  6 Nov 2025 14:09:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6964E402E7;
	Thu,  6 Nov 2025 15:09:58 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
 by mails.dpdk.org (Postfix) with ESMTP id D52C84013F
 for <dev@dpdk.org>; Thu,  6 Nov 2025 15:09:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1762438197; x=1793974197;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=GGhA8hotdTLg1VJY9wSBbu7QQErNehe3ybQI8ttSVJk=;
 b=BpMAet8/rWrOAuERrn2xR65Rnc5nkXhfgM4l2L0wPNxUswCBVoGMwKmK
 ZeNsLb8RKi4peeQrTJrjiypMWPyAcHAUUqwZHl/t8RCVK8o/rHPGtb1FY
 JDYEES/Zfrebz6RiVLjxTFe7miSUZDYBrcDZNpNcym3OXO7+x2B7+Lq3+
 5TVcvEH0kBTowhOzHtm5/ScVGoXnjubL6wHuLjUYey+AZad7OfmPmOCI7
 ht9/xtZcjNbbrtYx8VnY+g0MRjt4su7q151PZJgbdEWQT45KRCdnubdKe
 MkQOF/aRHEyryiEJw4RdHUtH7xPdR0l64EdB2yoEOpj0LY0I9jHmwW6Um Q==;
X-CSE-ConnectionGUID: aoWWHRNgTmCPcKH6ixevgw==
X-CSE-MsgGUID: CEgfrDjXQXOUiIlosreNtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11604"; a="74864189"
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="74864189"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Nov 2025 06:09:56 -0800
X-CSE-ConnectionGUID: TxrTmpydSDOVUu7lMSRueg==
X-CSE-MsgGUID: TmkI0K9MT9G9iLTXztLtQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,284,1754982000"; d="scan'208";a="187054670"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 06 Nov 2025 06:09:55 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 00/19] Fix building much of DPDK with -Wshadow
Date: Thu,  6 Nov 2025 14:09:29 +0000
Message-ID: <20251106140948.2894678-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.48.1
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

As flagged in bugs #1742, #1743 and others, much of DPDK fails to build
when -Wshadow flag is passed to the build. This patchset fixes many
issues of this nature, but not all, in the hopes we can move towards
enabling that warning flag globally for DPDK in future. This patchset
fixes the following components in DPDK:

* all libraries
* Intel drivers
* testpmd

The following build now works on my system after this set is applied:

  meson setup -Denable_drivers=net/intel/* -Denable_apps=test-pmd --werror -Dc_args=-Wshadow build-shadow && ninja -C build-shadow

Bruce Richardson (19):
  eal: fix variable shadowing
  ethdev: fix variable shadowing issues
  eventdev: fix variable shadowing issues
  net: remove shadowed variable
  graph: fix variable shadowing errors
  pipeline: fix variable shadowing
  table: fix issues with variable shadowing
  power: rename variable to eliminate shadowing
  pcapng: rename variable to fix shadowing
  telemetry: make socket handler typedef private
  bbdev: fix variable shadowing
  bus/pci: remove shadowed variables
  net/intel: rename function param to avoid shadow warnings
  net/e1000: fix build with shadow warnings enabled
  net/i40e: fix build with shadow warnings enabled
  net/ice: fix build with shadow warnings enabled
  net/cpfl: fix build with shadow warnings enabled
  net/ixgbe: fix build with shadow warnings enabled
  app/test-pmd: fix build with shadow warnings enabled

 app/test-pmd/cmdline_flow.c                   | 42 ++++-----
 app/test-pmd/config.c                         | 15 ++--
 app/test-pmd/parameters.c                     |  4 +-
 app/test-pmd/testpmd.c                        |  2 +-
 drivers/bus/pci/linux/pci.c                   |  1 -
 drivers/bus/pci/linux/pci_vfio.c              |  2 +-
 drivers/net/intel/common/rx.h                 |  6 +-
 drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c |  2 -
 drivers/net/intel/cpfl/cpfl_flow_parser.c     |  6 +-
 drivers/net/intel/cpfl/cpfl_fxp_rule.h        |  2 -
 drivers/net/intel/cpfl/cpfl_representor.h     |  2 +-
 drivers/net/intel/e1000/igc_ethdev.c          |  6 +-
 drivers/net/intel/i40e/i40e_ethdev.h          | 10 +--
 drivers/net/intel/ice/ice_ethdev.c            |  6 +-
 drivers/net/intel/ixgbe/ixgbe_fdir.c          |  7 +-
 lib/bbdev/rte_bbdev.c                         |  2 +-
 lib/eal/common/eal_common_options.c           | 12 +--
 lib/eal/common/eal_common_trace.c             | 89 +++++++++----------
 lib/eal/common/malloc_heap.c                  |  2 +-
 lib/ethdev/ethdev_driver.c                    |  6 +-
 lib/ethdev/rte_ethdev.c                       |  1 -
 lib/eventdev/rte_event_eth_rx_adapter.c       |  5 +-
 lib/eventdev/rte_event_eth_tx_adapter.c       |  8 +-
 lib/graph/graph.c                             |  4 +-
 lib/graph/graph_private.h                     |  2 +-
 lib/net/net_crc_avx512.c                      |  4 +-
 lib/pcapng/rte_pcapng.c                       |  7 +-
 lib/pipeline/rte_swx_ctl.c                    | 11 ++-
 lib/pipeline/rte_swx_pipeline.c               | 21 +++--
 lib/pipeline/rte_swx_pipeline_internal.h      | 10 +--
 lib/power/rte_power_pmd_mgmt.c                |  6 +-
 lib/table/rte_lru.h                           | 38 ++++----
 lib/table/rte_lru_arm64.h                     | 14 +--
 lib/table/rte_lru_x86.h                       |  4 +-
 lib/table/rte_swx_table_em.c                  |  2 -
 lib/table/rte_swx_table_learner.c             |  4 +-
 lib/table/rte_table_hash_key16.c              |  4 +-
 lib/table/rte_table_hash_key32.c              |  4 +-
 lib/table/rte_table_hash_key8.c               |  4 +-
 lib/telemetry/rte_telemetry.h                 | 11 ---
 lib/telemetry/telemetry.c                     |  2 +-
 lib/telemetry/telemetry_internal.h            | 11 +++
 42 files changed, 186 insertions(+), 215 deletions(-)

--
2.48.1

