Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F0F1CAC5A7
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Sep 2025 14:12:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6879B402CB;
	Tue, 23 Sep 2025 16:12:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 1C96D402B3
 for <dev@dpdk.org>; Tue, 23 Sep 2025 16:12:14 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1758636735; x=1790172735;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=mDzfSdJ1RA3uR3xZ4FyrMYoLDhk4/9FS99yNv5d1t00=;
 b=hX+YodKm7CXo9xZ59dzszN30bc+sCp7CrnCfPtFOY96URTGk6fNmnDJX
 4dF8bK8SHz2BaL9ktGL5ms0u4i5U6aDjNklHRYiERvlU60HBucmqni3Ul
 Cb9WktrNVzmKHUIGmwAnHft/qHgV9e1iXmCdzp2TWotylC4tQtAzTxHEQ
 sQBQyekuuf5k31nuDs2mheJuX65axxHX5RMYQ12lLpNJPX1TE4mvAv8iN
 BlzPlBwN8BATIxalOg1Gvih9nCSVXuy/x70bByfRkBy7SNOogvFjEu+T2
 4rs7Yt/Cg0wwjqfr8lcR73lPWVIusvAKufxn8VJOZe2JR+EcNDdJyHQQo g==;
X-CSE-ConnectionGUID: vq/NGwM2ShuluJvRTnvSAw==
X-CSE-MsgGUID: aZzyxLnCTymlyhy3XkHcjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="64554227"
X-IronPort-AV: E=Sophos;i="6.18,288,1751266800"; d="scan'208";a="64554227"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Sep 2025 07:12:14 -0700
X-CSE-ConnectionGUID: XpW23WrhTSqEDyHW9Z3Nkw==
X-CSE-MsgGUID: rRHE8+6DRpamfKjN7s2TyQ==
X-ExtLoop1: 1
Received: from silpixa00401385.ir.intel.com (HELO silpixa00401385..)
 ([10.20.224.226])
 by fmviesa003.fm.intel.com with ESMTP; 23 Sep 2025 07:12:13 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [RFC PATCH 0/6] remove deprecated queue stats
Date: Tue, 23 Sep 2025 15:12:00 +0100
Message-ID: <20250923141207.10403-1-bruce.richardson@intel.com>
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

Since DPDK 20.11 release, the use of queue stats inside the rte_eth_stats
structure has been deprecated with the intention to remove them. Sadly,
despite 5 years passing that has still not been done. This patchset
finally attempts to fix that situation and remove the queue stats fields.

The biggest complication here is the fact that, as part of the deprecation,
a new driver flag was added which caused ethdev to automatically add the
queue stats into xstats. While this was good, in that it allowed quick use
of xstats for getting queue statistics, it now causes lots of problems
because we have 35 drivers (by a rough count using grep) which rely on this
functionality to export their queue stats via xstats. This means that if we
drop the queue stats fields from the regular stats structure, then 35
drivers will lose *all* queue stats reporting functionality! This is not an
acceptable situation IMHO. [And in one patchset trying to change all 35
drivers to directly export via xstats is not feasible either, since adding
extra xstats can be very complicated at times.]

Therefore, we need to make changes that a) removes the queue fields from
the regular stats structure, while also b) continuing to allow the
individual driver stats_get functions return those stats to ethdev for
filling in. I tried a number of approaches here to find one that was most
feasible to implement for large numbers of drivers, so that either scripts
or AI assistants could automate a lot of the changes. The most feasible
approach I found was to define a DPDK-internal queue-stats-only structure,
which would be passed as a 3rd parameter to the drivers' stats_get
functions. When calling stats_get from ethdev, this third parameter would
be NULL, but for gathering xstats, it would be non-NULL for drivers which
have the RTE_ETH_DEV_AUTOFILL_QUEUE_XSTATS flag set.

For this set, I've separated out the driver changes from the ethdev changes
and the app changes, since the driver changes are so numerous, making the
rest hard to review. In order to ensure clean compilation and git history,
patches 3 through 6 should be squashed into a single one on apply.

Beyond these patches, more cleanup should/could be done:
* ensure that any drivers which don't set the AUTOFILL flag have the qstats
  parameter set as __rte_unused.
* For those that do use the AUTOFILL flag, we should ensure that they
  actually do fill in the stats, and not just set them to zero. (First two
  patches here fix that for a couple of Intel drivers)
* then work to reduce the number of drivers which use the flag to set the
  xstats, with a view to completely removing the queue stats from regular
  stats functions.
* Within ethdev (and testpmd), we should consider what to do with any other
  legacy queue stats related functions, for example, do we still keep the
  queue mappings functions.


Bruce Richardson (6):
  net/ice: don't report empty queue xstats
  net/ipn3ke: drop unsupported per-queue xstats
  ethdev: remove queue stats from ethdev stats structure
  drivers/net: update to remove queue stats from eth stats
  app: remove queue stats from eth stats
  doc: update docs for ethdev changes

 app/proc-info/main.c                          |  16 ---
 app/test-pmd/config.c                         |   6 -
 app/test/virtual_pmd.c                        |   3 +-
 config/rte_config.h                           |   1 -
 doc/guides/rel_notes/deprecation.rst          |   7 -
 doc/guides/rel_notes/release_25_11.rst        |   6 +
 drivers/net/af_packet/rte_eth_af_packet.c     |  13 +-
 drivers/net/af_xdp/rte_eth_af_xdp.c           |  35 +++--
 drivers/net/ark/ark_ethdev.c                  |  36 +++--
 drivers/net/ark/ark_ethdev_rx.c               |  14 +-
 drivers/net/ark/ark_ethdev_rx.h               |   3 +-
 drivers/net/ark/ark_ethdev_tx.c               |  12 +-
 drivers/net/ark/ark_ethdev_tx.h               |   3 +-
 drivers/net/atlantic/atl_ethdev.c             |  19 +--
 drivers/net/atlantic/atl_types.h              |   1 +
 drivers/net/avp/avp_ethdev.c                  |  20 ++-
 drivers/net/axgbe/axgbe_ethdev.c              |  22 +--
 drivers/net/axgbe/axgbe_ethdev.h              |   1 +
 drivers/net/bnx2x/bnx2x_ethdev.c              |   3 +-
 drivers/net/bnxt/bnxt_reps.c                  |  14 +-
 drivers/net/bnxt/bnxt_reps.h                  |   2 +-
 drivers/net/bnxt/bnxt_stats.c                 | 133 ++++++++++--------
 drivers/net/bnxt/bnxt_stats.h                 |   2 +-
 drivers/net/bonding/rte_eth_bond_pmd.c        |  14 +-
 drivers/net/cnxk/cnxk_ethdev.h                |   3 +-
 drivers/net/cnxk/cnxk_rep.h                   |   3 +-
 drivers/net/cnxk/cnxk_rep_ops.c               |  15 +-
 drivers/net/cnxk/cnxk_stats.c                 |  49 ++++---
 drivers/net/cxgbe/cxgbe_ethdev.c              |   3 +-
 drivers/net/cxgbe/cxgbevf_ethdev.c            |   3 +-
 drivers/net/dpaa/dpaa_ethdev.c                |   3 +-
 drivers/net/dpaa2/dpaa2_ethdev.c              |  28 ++--
 drivers/net/ena/ena_ethdev.c                  |  46 +++---
 drivers/net/enetc/enetc_ethdev.c              |   4 +-
 drivers/net/enetfec/enet_ethdev.c             |   3 +-
 drivers/net/enic/enic.h                       |   3 +-
 drivers/net/enic/enic_ethdev.c                |   4 +-
 drivers/net/enic/enic_main.c                  |   3 +-
 drivers/net/enic/enic_vf_representor.c        |   3 +-
 drivers/net/failsafe/failsafe_ether.c         |   9 --
 drivers/net/failsafe/failsafe_ops.c           |   3 +-
 drivers/net/gve/gve_ethdev.c                  |   4 +-
 drivers/net/hinic/hinic_pmd_ethdev.c          |  64 ++++++---
 drivers/net/hns3/hns3_stats.c                 |   4 +-
 drivers/net/hns3/hns3_stats.h                 |   3 +-
 drivers/net/intel/cpfl/cpfl_ethdev.c          |   3 +-
 drivers/net/intel/e1000/em_ethdev.c           |   7 +-
 drivers/net/intel/e1000/igb_ethdev.c          |  14 +-
 drivers/net/intel/e1000/igc_ethdev.c          |  33 +++--
 drivers/net/intel/fm10k/fm10k_ethdev.c        |  27 ++--
 drivers/net/intel/i40e/i40e_ethdev.c          |   5 +-
 drivers/net/intel/i40e/i40e_vf_representor.c  |   2 +-
 drivers/net/intel/iavf/iavf_ethdev.c          |   5 +-
 drivers/net/intel/ice/ice_dcf_ethdev.c        |   3 +-
 drivers/net/intel/ice/ice_ethdev.c            |   7 +-
 drivers/net/intel/idpf/idpf_ethdev.c          |   3 +-
 drivers/net/intel/ipn3ke/ipn3ke_representor.c |  14 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  29 ++--
 drivers/net/ionic/ionic_ethdev.c              |   6 +-
 drivers/net/ionic/ionic_lif.c                 |  35 +++--
 drivers/net/ionic/ionic_lif.h                 |   3 +-
 drivers/net/mana/mana.c                       |  15 +-
 drivers/net/memif/rte_eth_memif.c             |  15 +-
 drivers/net/mlx4/mlx4.h                       |   3 +-
 drivers/net/mlx4/mlx4_ethdev.c                |  17 +--
 drivers/net/mlx5/mlx5.h                       |   3 +-
 drivers/net/mlx5/mlx5_stats.c                 |  17 +--
 drivers/net/mvneta/mvneta_ethdev.c            |   5 +-
 drivers/net/mvpp2/mrvl_ethdev.c               |  23 +--
 drivers/net/netvsc/hn_ethdev.c                |  17 +--
 drivers/net/netvsc/hn_var.h                   |   3 +-
 drivers/net/netvsc/hn_vf.c                    |   3 +-
 drivers/net/nfp/flower/nfp_flower.c           |   8 +-
 .../net/nfp/flower/nfp_flower_representor.c   |  19 +--
 .../net/nfp/flower/nfp_flower_representor.h   |   3 +
 drivers/net/nfp/nfp_net_common.c              |  46 +++---
 drivers/net/nfp/nfp_net_common.h              |   4 +-
 drivers/net/ngbe/ngbe_ethdev.c                |  53 +++----
 drivers/net/ngbe/ngbe_ethdev_vf.c             |   5 +-
 drivers/net/ntnic/ntnic_ethdev.c              |  22 +--
 drivers/net/null/rte_eth_null.c               |  15 +-
 drivers/net/octeon_ep/otx_ep_ethdev.c         |  17 ++-
 drivers/net/octeontx/octeontx_ethdev.c        |   3 +-
 drivers/net/pcap/pcap_ethdev.c                |  23 +--
 drivers/net/pfe/pfe_ethdev.c                  |   3 +-
 drivers/net/qede/qede_ethdev.c                |  23 ++-
 drivers/net/r8169/r8169_ethdev.c              |   6 +-
 drivers/net/ring/rte_eth_ring.c               |  13 +-
 drivers/net/rnp/rnp_ethdev.c                  |  15 +-
 drivers/net/sfc/sfc_ethdev.c                  |   3 +-
 drivers/net/sfc/sfc_repr.c                    |   3 +-
 drivers/net/tap/rte_eth_tap.c                 |  23 +--
 drivers/net/thunderx/nicvf_ethdev.c           |  27 ++--
 drivers/net/txgbe/txgbe_ethdev.c              |  53 +++----
 drivers/net/txgbe/txgbe_ethdev_vf.c           |   5 +-
 drivers/net/vhost/rte_eth_vhost.c             |  26 ++--
 drivers/net/virtio/virtio_ethdev.c            |  23 +--
 drivers/net/vmxnet3/vmxnet3_ethdev.c          |  20 +--
 drivers/net/xsc/xsc_ethdev.c                  |  19 +--
 drivers/net/zxdh/zxdh_ethdev_ops.c            |  39 ++---
 drivers/net/zxdh/zxdh_ethdev_ops.h            |   3 +-
 lib/ethdev/ethdev_driver.h                    |  23 ++-
 lib/ethdev/ethdev_private.c                   |  26 ++++
 lib/ethdev/ethdev_private.h                   |   2 +
 lib/ethdev/rte_ethdev.c                       |  37 ++---
 lib/ethdev/rte_ethdev.h                       |  11 --
 lib/ethdev/rte_ethdev_telemetry.c             |  20 +--
 107 files changed, 898 insertions(+), 706 deletions(-)

--
2.48.1

