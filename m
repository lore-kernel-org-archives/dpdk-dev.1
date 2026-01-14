Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB83ED37E56
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Jan 2026 15:45:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D92C14067E;
	Wed, 14 Jan 2026 16:45:00 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 14EFC400D6
 for <dev@dpdk.org>; Wed, 14 Jan 2026 16:44:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1768405500; x=1799941500;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=DKOwlvEJCPVE39cFPK0bEYkjfSxGx+z3QnLeZLILFc0=;
 b=JvzgrW0Th2xoUToFQZ3vgSpL3CzZFVbtr9CGQehdur6cI/D+Nw6caLSv
 BIt54pidsWPUdkDP1i0M/z83KDuc35bp5YSxpe+lxjvvnHwzG3FgU+ewZ
 PcwvsFBdW0t3If6igLcL0pc1bUX1ziImL/FJnhQ3DqDnQLUixqtjjgEOS
 QbzmQiuFnJH3t22N3QfGvtTqM7SdUN8O+onTBg5moNRDJQdByKuOHRRXK
 iGVJY43igBcW/E6hK76bpqdwV7u97Kb/T+o0PnQcEsiDfXDymKIoVMdlZ
 BpL0aaJl/195UnYLOwL+9sr5pawKECXCzDIOSxLNZ+eZnYvqxEDzdpiH3 g==;
X-CSE-ConnectionGUID: A9BpMX73Tq6U/jGxZBq2rQ==
X-CSE-MsgGUID: ZKKwY1z6ScyehDKbct48wA==
X-IronPort-AV: E=McAfee;i="6800,10657,11671"; a="69870764"
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="69870764"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Jan 2026 07:44:59 -0800
X-CSE-ConnectionGUID: fWECvoegRgK3RcbjWLwRSA==
X-CSE-MsgGUID: Dr7ZjBLtTyej9MiMkqKw5w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,225,1763452800"; d="scan'208";a="203924870"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 14 Jan 2026 07:44:57 -0800
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 00/31] build DPDK with Wshadow flag
Date: Wed, 14 Jan 2026 15:44:14 +0000
Message-ID: <20260114154450.2969716-1-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251106140948.2894678-1-bruce.richardson@intel.com>
References: <20251106140948.2894678-1-bruce.richardson@intel.com>
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

As flagged in bugs #1742, #1743 and others, much of DPDK fails to build
when -Wshadow flag is passed to the build. This patchset fixes many issues
of this nature, but not all, in the hopes we can move towards enabling that
warning flag for all components for DPDK in future. This patchset fixes the
following components in DPDK:

* all libraries
* Intel net drivers
* all apps in the "app" folder

For the rest of the drivers and example applications, any component which
does not build successfully with the shadow warning enabled has it
explicitly disabled via cflags. Then the last patch adds -Wshadow to the
global DPDK build, which should prevent any regressions in components which
are already working.

At that point, we should not have any regressions and we can, over time,
reduce the number of components needing the -Wno-shadow flag.

V4:
* Updates follow AI review:
  - improve variable naming in min/max fns
  - remove extra blank line
* rebase on latest main

v3:
* rebase on 25.11 release.

RFC v2:
* take patch from Stephen for RTE_MIN/MAX fixes
* add additional fixes to clear clang warnings - it's a lot stricter than
  gcc in this regard, and flags more issues.
* extend app cleanup to all apps, not just testpmd
* add per-component disabling, and add global enable flag at the end.

Bruce Richardson (30):
  eal: fix variable shadowing
  ethdev: fix variable shadowing issues
  eventdev: fix variable shadowing issues
  net: remove shadowed variable
  pipeline: fix variable shadowing
  table: fix issues with variable shadowing
  power: rename variable to eliminate shadowing
  pcapng: rename variable to fix shadowing
  bbdev: fix variable shadowing
  bus/pci: remove shadowed variables
  net/intel: rename function param to avoid shadow warnings
  net/e1000: fix build with shadow warnings enabled
  net/i40e: fix build with shadow warnings enabled
  net/ice: fix build with shadow warnings enabled
  net/cpfl: fix build with shadow warnings enabled
  net/ixgbe: fix build with shadow warnings enabled
  app/testpmd: fix build with shadow warnings enabled
  app/graph: fix build with shadow warnings enabled
  app/pdump: fix warning about shadowed variable
  app/test-bbdev: remove shadow warning from next max calls
  app/test-compress-perf: rename local vars to fix shadowing
  app/test-crypto-perf: rename local vars to fix shadowing
  app/test-eventdev: fix build with shadow warnings enabled
  app/test-flow-perf: remove unneeded variable
  app/test-security-perf: fix build with shadow warnings
  app/test-pipeline: remove unnecessary variable
  drivers: disable variable shadowing warnings for drivers
  app/test: disable shadowing warnings for unit tests
  examples: ignore variable shadowing warnings
  build: enable shadowed variable warnings

Stephen Hemminger (1):
  eal: add more min/max helpers

 app/graph/conn.c                              | 134 +++++++++---------
 app/pdump/main.c                              |  12 +-
 app/test-bbdev/test_bbdev_perf.c              |   7 +-
 app/test-compress-perf/main.c                 | 122 ++++++++--------
 .../cperf_test_pmd_cyclecount.c               |   6 +-
 app/test-eventdev/evt_main.c                  |   6 +-
 app/test-eventdev/test_atomic_queue.c         |   6 +-
 app/test-eventdev/test_perf_common.c          |   4 +-
 app/test-flow-perf/main.c                     |   1 -
 app/test-pipeline/main.c                      |   1 -
 app/test-pmd/cmdline_flow.c                   |  42 +++---
 app/test-pmd/config.c                         |  15 +-
 app/test-pmd/parameters.c                     |  38 +++--
 app/test-pmd/testpmd.c                        |   2 +-
 app/test-security-perf/test_security_perf.c   |  42 +++---
 app/test/meson.build                          |   1 +
 app/test/test_cryptodev_security_ipsec.c      |  13 +-
 config/meson.build                            |   6 +
 drivers/baseband/fpga_5gnr_fec/meson.build    |   2 +
 drivers/bus/fslmc/meson.build                 |   2 +
 drivers/bus/pci/linux/pci.c                   |   1 -
 drivers/bus/pci/linux/pci_vfio.c              |   2 +-
 drivers/bus/pci/windows/pci.c                 |   1 -
 drivers/common/cnxk/meson.build               |   1 +
 drivers/common/qat/meson.build                |   1 +
 drivers/compress/nitrox/meson.build           |   2 +
 drivers/crypto/cnxk/meson.build               |   1 +
 drivers/crypto/octeontx/meson.build           |   1 +
 drivers/crypto/openssl/meson.build            |   1 +
 drivers/crypto/scheduler/meson.build          |   1 +
 drivers/dma/dpaa2/meson.build                 |   2 +
 drivers/event/cnxk/meson.build                |   1 +
 drivers/event/dlb2/meson.build                |   2 +
 drivers/event/sw/meson.build                  |   1 +
 drivers/net/axgbe/meson.build                 |   2 +-
 drivers/net/bnxt/meson.build                  |   1 +
 drivers/net/bonding/meson.build               |   1 +
 drivers/net/cnxk/meson.build                  |   1 +
 drivers/net/cxgbe/meson.build                 |   1 +
 drivers/net/dpaa/meson.build                  |   1 +
 drivers/net/dpaa2/meson.build                 |   1 +
 drivers/net/ena/meson.build                   |   2 +
 drivers/net/enetfec/meson.build               |   2 +
 drivers/net/enic/meson.build                  |   2 +
 drivers/net/failsafe/meson.build              |   1 +
 drivers/net/intel/common/rx.h                 |   6 +-
 drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c |   2 -
 drivers/net/intel/cpfl/cpfl_flow_parser.c     |   6 +-
 drivers/net/intel/cpfl/cpfl_fxp_rule.h        |   2 -
 drivers/net/intel/cpfl/cpfl_representor.h     |   2 +-
 drivers/net/intel/e1000/igc_ethdev.c          |   6 +-
 drivers/net/intel/i40e/i40e_ethdev.h          |  10 +-
 drivers/net/intel/ice/ice_ethdev.c            |   6 +-
 drivers/net/intel/ixgbe/ixgbe_fdir.c          |   7 +-
 drivers/net/mlx5/meson.build                  |   1 +
 drivers/net/ntnic/meson.build                 |   3 +
 drivers/net/pfe/meson.build                   |   3 +
 drivers/net/qede/meson.build                  |   3 +
 drivers/net/txgbe/meson.build                 |   1 +
 drivers/net/zxdh/meson.build                  |   3 +
 drivers/raw/ifpga/meson.build                 |   2 +
 drivers/vdpa/mlx5/meson.build                 |   1 +
 examples/bbdev_app/meson.build                |   1 +
 examples/bond/meson.build                     |   1 +
 examples/dma/meson.build                      |   1 +
 examples/ethtool/meson.build                  |   1 +
 examples/eventdev_pipeline/meson.build        |   1 +
 examples/flow_filtering/meson.build           |   1 +
 examples/ip_pipeline/meson.build              |   1 +
 examples/ipsec-secgw/meson.build              |   1 +
 examples/l2fwd-crypto/meson.build             |   1 +
 examples/l2fwd-event/meson.build              |   1 +
 examples/l2fwd-jobstats/meson.build           |   1 +
 examples/l2fwd-keepalive/meson.build          |   1 +
 examples/l3fwd-graph/meson.build              |   1 +
 examples/l3fwd-power/meson.build              |   1 +
 examples/l3fwd/meson.build                    |   1 +
 .../client_server_mp/mp_server/meson.build    |   1 +
 examples/packet_ordering/meson.build          |   1 +
 examples/ptpclient/meson.build                |   1 +
 examples/qos_sched/meson.build                |   1 +
 .../server_node_efd/efd_server/meson.build    |   1 +
 examples/vhost/meson.build                    |   1 +
 .../vm_power_manager/guest_cli/meson.build    |   1 +
 examples/vm_power_manager/meson.build         |   1 +
 examples/vmdq/meson.build                     |   1 +
 lib/bbdev/rte_bbdev.c                         |   2 +-
 lib/eal/common/eal_common_options.c           |  22 +--
 lib/eal/common/eal_common_trace.c             |  89 ++++++------
 lib/eal/common/malloc_heap.c                  |   2 +-
 lib/eal/include/rte_common.h                  |  38 ++++-
 lib/ethdev/ethdev_driver.c                    |   6 +-
 lib/ethdev/rte_ethdev.c                       |   1 -
 lib/eventdev/rte_event_eth_rx_adapter.c       |   5 +-
 lib/eventdev/rte_event_eth_tx_adapter.c       |   8 +-
 lib/net/net_crc_avx512.c                      |   4 +-
 lib/pcapng/rte_pcapng.c                       |   7 +-
 lib/pipeline/rte_swx_ctl.c                    |  11 +-
 lib/pipeline/rte_swx_pipeline.c               |  21 ++-
 lib/pipeline/rte_swx_pipeline_internal.h      |  10 +-
 lib/power/rte_power_pmd_mgmt.c                |   6 +-
 lib/table/rte_lru.h                           |  38 ++---
 lib/table/rte_lru_arm64.h                     |  14 +-
 lib/table/rte_lru_x86.h                       |   4 +-
 lib/table/rte_swx_table_em.c                  |   2 -
 lib/table/rte_swx_table_learner.c             |   4 +-
 lib/table/rte_table_hash_key16.c              |   4 +-
 lib/table/rte_table_hash_key32.c              |   4 +-
 lib/table/rte_table_hash_key8.c               |   4 +-
 109 files changed, 477 insertions(+), 412 deletions(-)

--
2.51.0

