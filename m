Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AC3C88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 17:21:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5994642DE4;
	Thu, 17 Sep 2026 19:21:22 +0200 (CEST)
Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com
 [74.125.228.41]) by mails.dpdk.org (Postfix) with ESMTP id 5C270402D3
 for <dev@dpdk.org>; Thu, 17 Sep 2026 19:21:20 +0200 (CEST)
Received: by mail-pz2-f41.google.com with SMTP id
 d2e1a72fcca58-85469e25400so916649b3a.0
 for <dev@dpdk.org>; Thu, 17 Sep 2026 10:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1789665679;
 x=1790270479; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7tahXxxXl2Ntf1kaw6qcK0CqtTDubceGRlNufIR6cYA=;
 b=koXagqm96SYJAWwwiQCs2Ag86MbQ+TNEHMr53KaCOCsT6Z9WTexNxIkSowxSnZyFh/
 5SBE+rH3ohRzTEvT4T2iBVjJa/t1ewST7B+N+JZuIplxWYxfseQxu/ecDPuAaYR6Br83
 nP1Ru5qmSOlawqPHXE6hYGAwf9j12HeHS/HPYeuQnr2ulwoEJzcR9x/t2iqU+LF/L1FL
 UamXdP0c495JoJFvTxXrnutaJJbVR4akoqerfN1Jfwmoj/nxMe2ZVjlK8Pv0c/ZfajXe
 kV3draE3ipe71zi12PCAh8idHA/pYDo6s3aSGJnF0ukv/oAXXg2b6PvABOzpizEzbSe+
 SWjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789665679; x=1790270479;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7tahXxxXl2Ntf1kaw6qcK0CqtTDubceGRlNufIR6cYA=;
 b=ta0Z/X8ykI7w82RFRJNQqK78t5583wqEWnkePuMulwoZU2E0tmNak9WqxDAO/3P0iZ
 xRWcwi4g5z2mXyoJlT7FHMZ/i1NvaU0Swm94JwcmGiHVOPcANP9XPA+qwhJ+TJX5zLrq
 c0voTfKqFYiK5Utu+eCG7Df7/YOCC324zo8zICP2Ee6pPL8gFhpWUEXayWZbidDVatzd
 b9WEOk9Xkb3zyaqESRTA9zfKubuhykeDxk2Ef3WhLGvz5znnnh4+uj/qwpiYPanOEfeD
 tjNq2do6qO1Vpds22MVqXHlCWZaDB9OjHh/StrzICz3cDwKna29CLes/jApBMYQZG82T
 n3bA==
X-Gm-Message-State: AFuF++k5DKoQY81TAR33VRDfUlSRrMwONuVsfKViimWzP+p3l9pPT2nh
 ii3rj082UvSBHRd4KRSCFBRPVknBzd9zhzLnByK+7Dxet30iojUco5iLrKvIig/UAqw2TKCb3Jd
 V1Q3r
X-Gm-Gg: AYBFou1r883QVTmPwS96HCXEVjSAQCS6LjnbmJeHfhTgJqlDMxgyebd3Yo0WxkqDCs6
 qz24y9PLT4oM74ollnTFRjtjbFqCmWWQdN5iLVOUl9a0ikR/HJlFckxrb5e+YRvwh4b2kO0UZzL
 lYvKFu2U1hB1zfIjgCXe4gC7RCNBdLi6QU2SRtcX4VhCEV+yVW8NlO2JHiRZrUNsQFIMKG7DWGT
 lQrIOww7+uF3LfswBzvBXWYdK+dUNiwC2pUHR3nOfcsSXDZy/HaF9c6ePo4KOFO/7k6cfFD0Nq3
 jX1SKOGeKtfudeFk1vd6WdLulFDunm8Venm3zhUcU7npzLBRTbHE7/sqdWUPgSQuzqMZzMuJfA4
 GxiLstpXswGNQgh5aRHl8wNFdwOEI+EhDs5ASGCyfS/1AOOxWtEflx/V4hE2Rm2aN3oMwoiPWsa
 msg23RvNylIXWvubCm2XVg4TPNE0X3RRS73CuAnOVYTnwFvzhq7hRSfydrIH6Pq7UHqLEL2dJXl
 KIIrfUSouFlvRSq2G9jy8Kwjiqh6BYCJr0CTw==
X-Received: by 2002:a05:6a00:9a5:b0:84e:e741:174f with SMTP id
 d2e1a72fcca58-872369eada2mr13909554b3a.7.1789665679116; 
 Thu, 17 Sep 2026 10:21:19 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-87379a2e079sm1447408b3a.31.2026.09.17.10.21.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 10:21:18 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 0/6] provide a complete set of BSD list macros
Date: Thu, 17 Sep 2026 10:19:38 -0700
Message-ID: <20260917172116.660120-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
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

DPDK uses the BSD <sys/queue.h> macros everywhere, but what you get
depends on the platform: FreeBSD has the full set, glibc has a subset,
musl and Windows have no such header.

The big gap is _FOREACH_SAFE, which glibc lacks. So it can't be used in
common code, and workarounds have spread: RTE_TAILQ_FOREACH_SAFE in
rte_tailq.h, plus ten files with private copies of LIST_, SLIST_,
STAILQ_ or TAILQ_FOREACH_SAFE. The RTE_TAILQ_*/RTE_STAILQ_* wrappers
exist only because Windows had no <sys/queue.h> to alias to.

Windows already carries a copy of the FreeBSD header. Move it to
lib/eal/include/rte_queue.h, use it on all platforms, and drop the
workarounds.

Patch 3 has to be one step. rte_queue.h deliberately uses the same
include guard as <sys/queue.h> so that the two suppress each other
instead of redefining macros. That means a single leftover include of
<sys/queue.h>, direct or via another header, turns rte_queue.h into a
no-op for that translation unit. Patch 6 adds a checkpatch test to keep
them from coming back.

Patch 1 is an unrelated use after free, found when the macros became
visible to the compiler and it reported -Wuse-after-free. Marked for
stable, independent of the rest.

Patch 5 converts the RTE_TAILQ_*/RTE_STAILQ_* wrappers to the plain
names but keeps them as deprecated aliases, scheduled for removal in
27.11: out of tree code on Windows had no alternative until now.

Stephen Hemminger (6):
  net/bnxt: fix use after free when freeing filters
  eal: add rte_queue.h with full set of list macros
  build: use rte_queue.h instead of sys/queue.h
  build: remove private FOREACH_SAFE definitions
  eal: deprecate RTE_TAILQ and RTE_STAILQ macro wrappers
  devtools: forbid direct use of sys/queue.h

 app/dumpcap/main.c                            |   2 +-
 app/proc-info/main.c                          |   2 +-
 app/test-bbdev/main.h                         |   2 +-
 app/test-cmdline/cmdline_test.c               |   2 +-
 app/test-eventdev/evt_test.c                  |   2 +-
 app/test-eventdev/evt_test.h                  |   2 +-
 app/test-mldev/ml_test.h                      |   2 +-
 app/test-pipeline/config.c                    |   2 +-
 app/test-pipeline/init.c                      |   2 +-
 app/test-pipeline/main.c                      |   2 +-
 app/test-pipeline/runtime.c                   |   2 +-
 app/test-pmd/5tswap.c                         |   2 +-
 app/test-pmd/cmdline.c                        |   2 +-
 app/test-pmd/config.c                         |   2 +-
 app/test-pmd/csumonly.c                       |   2 +-
 app/test-pmd/flowgen.c                        |   2 +-
 app/test-pmd/hairpin.c                        |   2 +-
 app/test-pmd/icmpecho.c                       |   2 +-
 app/test-pmd/iofwd.c                          |   2 +-
 app/test-pmd/macfwd.c                         |   2 +-
 app/test-pmd/macswap.c                        |   2 +-
 app/test-pmd/noisy_vnf.c                      |   2 +-
 app/test-pmd/parameters.c                     |   2 +-
 app/test-pmd/rxonly.c                         |   2 +-
 app/test-pmd/testpmd.c                        |   2 +-
 app/test-pmd/testpmd.h                        |   2 +-
 app/test-pmd/txonly.c                         |   2 +-
 app/test/commands.c                           |   2 +-
 app/test/test.c                               |   2 +-
 app/test/test.h                               |   2 +-
 app/test/test_atomic.c                        |   2 +-
 app/test/test_cmdline_lib.c                   |   2 +-
 app/test/test_func_reentrancy.c               |   2 +-
 app/test/test_hash.c                          |   2 +-
 app/test/test_hash_functions.c                |   2 +-
 app/test/test_link_bonding.c                  |   2 +-
 app/test/test_link_bonding_mode4.c            |   2 +-
 app/test/test_link_bonding_rssconf.c          |   2 +-
 app/test/test_logs.c                          |   2 +-
 app/test/test_malloc.c                        |   2 +-
 app/test/test_mbuf.c                          |   2 +-
 app/test/test_mcslock.c                       |   2 +-
 app/test/test_mempool.c                       |   2 +-
 app/test/test_mempool_perf.c                  |   2 +-
 app/test/test_memzone.c                       |   2 +-
 app/test/test_mp_secondary.c                  |   2 +-
 app/test/test_per_lcore.c                     |   2 +-
 app/test/test_pflock.c                        |   2 +-
 app/test/test_ring.c                          |   2 +-
 app/test/test_rwlock.c                        |   2 +-
 app/test/test_soring.c                        |   2 +-
 app/test/test_spinlock.c                      |   2 +-
 app/test/test_tailq.c                         |   2 +-
 app/test/test_ticketlock.c                    |   2 +-
 app/test/test_timer.c                         |   2 +-
 devtools/checkpatches.sh                      |   9 +
 doc/guides/contributing/coding_style.rst      |   5 +-
 doc/guides/rel_notes/deprecation.rst          |   8 +
 doc/guides/rel_notes/release_26_11.rst        |  15 ++
 drivers/bus/auxiliary/auxiliary_common.c      |   2 +-
 drivers/bus/auxiliary/private.h               |   2 +-
 drivers/bus/fslmc/bus_fslmc_driver.h          |   2 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      |   9 +-
 drivers/bus/ifpga/ifpga_bus.c                 |   2 +-
 drivers/bus/pci/bsd/pci.c                     |   2 +-
 drivers/bus/pci/pci_common.c                  |   2 +-
 drivers/bus/pci/pci_params.c                  |   2 +-
 drivers/bus/pci/windows/pci.c                 |   2 +-
 drivers/bus/pci/windows/pci_netuio.c          |   2 +-
 drivers/bus/platform/platform.c               |   2 +-
 drivers/bus/vdev/vdev.c                       |   4 +-
 drivers/bus/vmbus/vmbus_common.c              |   2 +-
 drivers/common/cnxk/roc_bphy_irq.c            |   1 -
 drivers/common/cnxk/roc_npc.h                 |   2 -
 drivers/common/cnxk/roc_platform.h            |   3 +-
 drivers/common/mlx5/mlx5_common_mr.h          |   2 +-
 drivers/common/sxe2/sxe2_osal.h               |   8 +-
 drivers/crypto/bcmfs/bcmfs_device.c           |   2 +-
 drivers/crypto/bcmfs/bcmfs_device.h           |   2 +-
 drivers/crypto/ccp/ccp_crypto.c               |   2 +-
 drivers/crypto/ccp/ccp_dev.c                  |   2 +-
 drivers/event/dlb2/dlb2_selftest.c            |   2 +-
 drivers/event/opdl/opdl_test.c                |   2 +-
 drivers/event/sw/sw_evdev_selftest.c          |   2 +-
 drivers/net/axgbe/axgbe_common.h              |   2 +-
 drivers/net/bnx2x/bnx2x_ethdev.h              |   2 +-
 drivers/net/bnxt/bnxt.h                       |   2 +-
 drivers/net/bnxt/bnxt_filter.c                |   9 +-
 drivers/net/bnxt/bnxt_flow.c                  |   2 +-
 drivers/net/bnxt/bnxt_vnic.h                  |   2 +-
 drivers/net/bnxt/tf_ulp/bnxt_ulp.c            |   4 +-
 drivers/net/bnxt/tf_ulp/bnxt_ulp.h            |   2 +-
 drivers/net/bnxt/tf_ulp/bnxt_ulp_meter.c      |   2 +-
 drivers/net/bonding/eth_bond_private.h        |   2 +-
 drivers/net/bonding/rte_eth_bond_flow.c       |   4 +-
 drivers/net/cnxk/cnxk_eswitch_flow.c          |   2 +-
 drivers/net/cnxk/cnxk_ethdev.c                |   6 +-
 drivers/net/cnxk/cnxk_ethdev_sec_telemetry.c  |   8 +-
 drivers/net/cxgbe/cxgbe_ethdev.c              |   2 +-
 drivers/net/cxgbe/cxgbe_main.c                |   2 +-
 drivers/net/cxgbe/sge.c                       |   2 +-
 drivers/net/dpaa2/dpaa2_flow.c                |   2 +-
 drivers/net/dpaa2/dpaa2_mux.c                 |   2 +-
 drivers/net/dpaa2/dpaa2_ptp.c                 |   2 +-
 drivers/net/enic/enic.h                       |   2 +-
 drivers/net/failsafe/failsafe_flow.c          |   4 +-
 drivers/net/failsafe/failsafe_private.h       |   2 +-
 drivers/net/intel/cpfl/cpfl_flow.c            |   8 +-
 drivers/net/intel/cpfl/cpfl_flow_engine_fxp.c |   2 +-
 drivers/net/intel/e1000/e1000_ethdev.h        |   2 +-
 drivers/net/intel/e1000/em_ethdev.c           |   2 +-
 drivers/net/intel/e1000/em_rxtx.c             |   2 +-
 drivers/net/intel/e1000/igb_ethdev.c          |   2 +-
 drivers/net/intel/e1000/igb_flow.c            |   2 +-
 drivers/net/intel/e1000/igb_rxtx.c            |   2 +-
 drivers/net/intel/i40e/i40e_ethdev.c          |  10 +-
 drivers/net/intel/i40e/i40e_ethdev.h          |   2 +-
 drivers/net/intel/i40e/i40e_fdir.c            |   2 +-
 drivers/net/intel/i40e/i40e_flow.c            |   8 +-
 drivers/net/intel/i40e/i40e_hash.c            |   4 +-
 drivers/net/intel/i40e/i40e_pf.c              |   2 +-
 drivers/net/intel/i40e/i40e_rxtx.c            |   2 +-
 drivers/net/intel/i40e/rte_pmd_i40e.c         |   6 +-
 drivers/net/intel/iavf/iavf.h                 |   2 +-
 drivers/net/intel/iavf/iavf_ethdev.c          |   2 +-
 drivers/net/intel/iavf/iavf_fdir.c            |   2 +-
 drivers/net/intel/iavf/iavf_fsub.c            |   2 +-
 drivers/net/intel/iavf/iavf_generic_flow.c    |  18 +-
 drivers/net/intel/iavf/iavf_hash.c            |   2 +-
 drivers/net/intel/iavf/iavf_rxtx.c            |   2 +-
 drivers/net/intel/iavf/iavf_vchnl.c           |   8 +-
 drivers/net/intel/ice/base/ice_osdep.h        |   2 +-
 drivers/net/intel/ice/ice_acl_filter.c        |   2 +-
 drivers/net/intel/ice/ice_dcf.c               |   2 +-
 drivers/net/intel/ice/ice_dcf_ethdev.c        |   2 +-
 drivers/net/intel/ice/ice_ethdev.c            |   4 +-
 drivers/net/intel/ice/ice_generic_flow.c      |  10 +-
 drivers/net/intel/ice/ice_hash.c              |   2 +-
 drivers/net/intel/ice/ice_switch_filter.c     |   2 +-
 drivers/net/intel/idpf/base/idpf_osdep.h      |   9 +-
 drivers/net/intel/ipn3ke/ipn3ke_ethdev.h      |   2 +-
 drivers/net/intel/ipn3ke/ipn3ke_flow.c        |   4 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |   2 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.h        |   2 +-
 drivers/net/intel/ixgbe/ixgbe_fdir.c          |   2 +-
 drivers/net/intel/ixgbe/ixgbe_flow.c          |   4 +-
 drivers/net/intel/ixgbe/ixgbe_rxtx.c          |   2 +-
 drivers/net/memif/memif_socket.h              |   2 +-
 drivers/net/memif/rte_eth_memif.h             |   2 +-
 drivers/net/mlx4/mlx4.h                       |   2 +-
 drivers/net/mlx4/mlx4_flow.c                  |   2 +-
 drivers/net/mlx4/mlx4_flow.h                  |   2 +-
 drivers/net/mlx4/mlx4_mr.h                    |   2 +-
 drivers/net/mlx4/mlx4_rxtx.h                  |   2 +-
 drivers/net/mlx5/hws/mlx5dr_internal.h        |   2 +-
 drivers/net/mlx5/linux/mlx5_verbs.c           |   2 +-
 drivers/net/mlx5/mlx5.h                       |   2 +-
 drivers/net/mlx5/mlx5_devx.c                  |   2 +-
 drivers/net/mlx5/mlx5_driver_event.c          |   2 +-
 drivers/net/mlx5/mlx5_flow.c                  |   2 +-
 drivers/net/mlx5/mlx5_flow.h                  |   2 +-
 drivers/net/mlx5/mlx5_flow_dv.c               |   4 +-
 drivers/net/mlx5/mlx5_flow_meter.c            |   2 +-
 drivers/net/mlx5/mlx5_flow_verbs.c            |   2 +-
 drivers/net/mlx5/mlx5_rx.h                    |   2 +-
 drivers/net/mlx5/mlx5_rxq.c                   |   2 +-
 drivers/net/mlx5/mlx5_rxtx.h                  |   2 +-
 drivers/net/mlx5/mlx5_tx.h                    |   2 +-
 drivers/net/nbl/nbl_common/nbl_userdev.c      |   4 +-
 drivers/net/netvsc/hn_ethdev.c                |   8 +-
 drivers/net/nfb/nfb_ethdev.c                  |   4 +-
 drivers/net/nfp/nfp_mtr.c                     |   8 +-
 drivers/net/ngbe/ngbe_ethdev_vf.c             |   2 +-
 drivers/net/ngbe/ngbe_rxtx.c                  |   2 +-
 drivers/net/ntnic/ntnic_ethdev.c              |   2 +-
 drivers/net/qede/qede_ethdev.h                |   2 +-
 drivers/net/qede/qede_filter.c                |   8 +-
 drivers/net/sfc/sfc_dp.c                      |   2 +-
 drivers/net/sfc/sfc_dp.h                      |   2 +-
 drivers/net/sfc/sfc_flow.c                    |   4 +-
 .../net/softnic/rte_eth_softnic_internals.h   |   2 +-
 drivers/net/softnic/rte_eth_softnic_swq.c     |   2 +-
 drivers/net/sxe2/sxe2_dump.c                  |   6 +-
 drivers/net/sxe2/sxe2_filter.c                |  22 +-
 drivers/net/sxe2/sxe2_flow.c                  |   2 +-
 drivers/net/sxe2/sxe2_vsi.c                   |   2 +-
 drivers/net/tap/rte_eth_tap.h                 |   2 +-
 drivers/net/tap/tap_flow.c                    |   2 +-
 drivers/net/thunderx/base/nicvf_bsvf.h        |   2 +-
 drivers/net/thunderx/nicvf_ethdev.c           |   2 +-
 drivers/net/txgbe/txgbe_ethdev_vf.c           |   2 +-
 drivers/net/txgbe/txgbe_fdir.c                |   2 +-
 drivers/net/txgbe/txgbe_flow.c                |   2 +-
 drivers/net/txgbe/txgbe_rxtx.c                |   2 +-
 drivers/net/vdev_netvsc/vdev_netvsc.c         |   2 +-
 drivers/net/vmxnet3/vmxnet3_ethdev.c          |   2 +-
 drivers/net/vmxnet3/vmxnet3_rxtx.c            |   2 +-
 drivers/net/zxdh/zxdh_flow.c                  |   4 +-
 drivers/net/zxdh/zxdh_flow.h                  |   2 +-
 drivers/net/zxdh/zxdh_mtr.c                   |   6 +-
 drivers/net/zxdh/zxdh_mtr.h                   |   2 +-
 drivers/raw/ifpga/base/opae_hw_api.h          |   2 +-
 drivers/raw/ifpga/base/opae_intel_max10.c     |   8 +-
 drivers/vdpa/mlx5/mlx5_vdpa.h                 |   2 +-
 drivers/vdpa/sfc/sfc_vdpa.c                   |   2 +-
 drivers/vdpa/sfc/sfc_vdpa.h                   |   2 +-
 examples/bbdev_app/main.c                     |   2 +-
 examples/bond/main.c                          |   2 +-
 examples/cmdline/main.c                       |   2 +-
 examples/cmdline/parse_obj_list.h             |   2 +-
 examples/flow_filtering/main.c                |   2 +-
 examples/helloworld/main.c                    |   2 +-
 examples/ip_fragmentation/main.c              |   2 +-
 examples/ip_pipeline/action.h                 |   2 +-
 examples/ip_pipeline/cryptodev.h              |   2 +-
 examples/ip_pipeline/link.h                   |   2 +-
 examples/ip_pipeline/mempool.h                |   2 +-
 examples/ip_pipeline/pipeline.h               |   2 +-
 examples/ip_pipeline/swq.h                    |   2 +-
 examples/ip_pipeline/tap.h                    |   2 +-
 examples/ip_pipeline/tmgr.h                   |   2 +-
 examples/ip_reassembly/main.c                 |   2 +-
 examples/ipsec-secgw/ipsec-secgw.c            |   2 +-
 examples/ipv4_multicast/main.c                |   2 +-
 examples/l2fwd-crypto/main.c                  |   2 +-
 examples/l2fwd-event/l2fwd_common.h           |   2 +-
 examples/l2fwd-keepalive/ka-agent/main.c      |   2 +-
 examples/l2fwd-keepalive/main.c               |   2 +-
 examples/l2fwd-macsec/main.c                  |   2 +-
 examples/l2fwd/main.c                         |   2 +-
 examples/l3fwd-graph/main.c                   |   2 +-
 examples/l3fwd-power/main.c                   |   2 +-
 examples/l3fwd/l3fwd_em.c                     |   2 +-
 examples/l3fwd/l3fwd_lpm.c                    |   2 +-
 examples/l3fwd/main.c                         |   2 +-
 examples/link_status_interrupt/main.c         |   2 +-
 .../client_server_mp/mp_client/client.c       |   2 +-
 .../client_server_mp/mp_server/init.c         |   2 +-
 .../client_server_mp/mp_server/main.c         |   2 +-
 examples/multi_process/hotplug_mp/main.c      |   2 +-
 examples/multi_process/simple_mp/main.c       |   2 +-
 examples/multi_process/symmetric_mp/main.c    |   2 +-
 examples/server_node_efd/efd_node/node.c      |   2 +-
 examples/server_node_efd/efd_server/init.c    |   2 +-
 examples/server_node_efd/efd_server/main.c    |   2 +-
 examples/service_cores/main.c                 |   2 +-
 examples/timer/main.c                         |   2 +-
 examples/vhost/main.h                         |   2 +-
 examples/vm_power_manager/channel_manager.c   |  10 +-
 examples/vm_power_manager/channel_monitor.c   |   2 +-
 examples/vm_power_manager/main.c              |   2 +-
 examples/vmdq/main.c                          |   2 +-
 examples/vmdq_dcb/main.c                      |   2 +-
 lib/acl/rte_acl_osdep.h                       |   2 +-
 lib/bbdev/rte_bbdev.c                         |   2 +-
 lib/bbdev/rte_bbdev.h                         |   2 +-
 lib/bpf/bpf_load_elf.c                        |   2 +-
 lib/bpf/bpf_pkt.c                             |   2 +-
 lib/bpf/bpf_validate_debug.c                  |   9 +-
 lib/cryptodev/cryptodev_pmd.c                 |   2 +-
 lib/cryptodev/cryptodev_pmd.h                 |   2 +-
 lib/cryptodev/rte_cryptodev.c                 |   2 +-
 lib/cryptodev/rte_cryptodev.h                 |   2 +-
 lib/distributor/rte_distributor.c             |   2 +-
 lib/distributor/rte_distributor_single.c      |   2 +-
 lib/eal/common/eal_common_bus.c               |   2 +-
 lib/eal/common/eal_common_class.c             |   2 +-
 lib/eal/common/eal_common_dev.c               |   2 +-
 lib/eal/common/eal_common_devargs.c           |   4 +-
 lib/eal/common/eal_common_options.c           |   4 +-
 lib/eal/common/eal_common_proc.c              |   2 +-
 lib/eal/common/eal_common_tailqs.c            |   2 +-
 lib/eal/common/eal_common_trace.c             |   2 +-
 lib/eal/common/eal_private.h                  |   2 +-
 lib/eal/common/malloc_elem.c                  |   2 +-
 lib/eal/common/malloc_heap.c                  |   2 +-
 lib/eal/common/malloc_heap.h                  |   2 +-
 lib/eal/common/rte_malloc.c                   |   2 +-
 lib/eal/freebsd/eal.c                         |   2 +-
 lib/eal/freebsd/eal_interrupts.c              |   2 +-
 lib/eal/freebsd/eal_thread.c                  |   2 +-
 lib/eal/freebsd/include/rte_os.h              |  14 +-
 lib/eal/include/bus_driver.h                  |   8 +-
 lib/eal/include/dev_driver.h                  |   4 +-
 lib/eal/include/meson.build                   |   1 +
 lib/eal/include/rte_class.h                   |   4 +-
 lib/eal/include/rte_devargs.h                 |   2 +-
 .../sys/queue.h => include/rte_queue.h}       | 235 ++++--------------
 lib/eal/include/rte_tailq.h                   |  35 ++-
 lib/eal/linux/eal_alarm.c                     |   2 +-
 lib/eal/linux/eal_interrupts.c                |   2 +-
 lib/eal/linux/include/rte_os.h                |  14 +-
 lib/eal/windows/eal_alarm.c                   |   2 +-
 lib/eal/windows/include/rte_os.h              |  31 +--
 lib/efd/rte_efd.c                             |   4 +-
 lib/ethdev/ethdev_private.h                   |   2 +-
 lib/ethdev/rte_ethdev.c                       |   2 +-
 lib/ethdev/rte_ethdev_core.h                  |   2 +-
 lib/eventdev/rte_event_vector_adapter.c       |   2 +-
 lib/fib/rte_fib.c                             |   2 +-
 lib/fib/rte_fib6.c                            |   2 +-
 lib/gpudev/gpudev.c                           |   6 +-
 lib/gpudev/gpudev_driver.h                    |   2 +-
 lib/graph/graph_private.h                     |   2 +-
 lib/hash/rte_cuckoo_hash.c                    |   2 +-
 lib/hash/rte_fbk_hash.c                       |   2 +-
 lib/hash/rte_thash.c                          |   2 +-
 lib/ip_frag/ip_frag_common.h                  |   2 +-
 lib/ip_frag/ip_reassembly.h                   |   4 +-
 lib/ip_frag/rte_ip_frag_common.c              |   2 +-
 lib/log/log.c                                 |   2 +-
 lib/lpm/rte_lpm.c                             |   2 +-
 lib/lpm/rte_lpm6.c                            |   2 +-
 lib/mbuf/rte_mbuf_dyn.c                       |   2 +-
 lib/mempool/rte_mempool.c                     |   6 +-
 lib/mempool/rte_mempool.h                     |   8 +-
 lib/pipeline/rte_swx_ctl.c                    |   2 +-
 lib/pipeline/rte_swx_pipeline_internal.h      |   2 +-
 lib/pmu/pmu.c                                 |   4 +-
 lib/power/power_cpufreq.h                     |   2 +-
 lib/power/power_uncore_ops.h                  |   2 +-
 lib/power/rte_power_cpufreq.c                 |   8 +-
 lib/power/rte_power_uncore.c                  |   6 +-
 lib/reorder/rte_reorder.c                     |   2 +-
 lib/rib/rte_rib.c                             |   2 +-
 lib/rib/rte_rib6.c                            |   2 +-
 lib/ring/rte_ring.c                           |   2 +-
 lib/stack/rte_stack.c                         |   2 +-
 lib/table/rte_swx_table.h                     |   4 +-
 lib/table/rte_swx_table_selector.h            |   4 +-
 lib/vhost/fd_man.h                            |   2 +-
 lib/vhost/iotlb.c                             |  14 +-
 lib/vhost/socket.c                            |   2 +-
 lib/vhost/vdpa.c                              |   4 +-
 lib/vhost/vdpa_driver.h                       |   2 +-
 lib/vhost/vhost.h                             |   2 +-
 336 files changed, 540 insertions(+), 725 deletions(-)
 rename lib/eal/{windows/include/sys/queue.h => include/rte_queue.h} (76%)

-- 
2.53.0

