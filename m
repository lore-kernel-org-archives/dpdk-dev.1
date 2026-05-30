Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1358CD4F54
	for <dpdk-dev@archiver.kernel.org>; Sat, 30 May 2026 07:52:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 89DE540262;
	Sat, 30 May 2026 09:52:24 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id A5037400D6
 for <dev@dpdk.org>; Sat, 30 May 2026 09:52:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780127542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zqD/ARhYXlZ6rB4/G6lYudfYuDf5hfrzLSqkcHsVKHg=;
 b=RHJDqQ5iQl8XqxqQPiNG+CistVuuu9/OmqrMvvQsTXn1Le95b/qyflc3Ga0C/R07UuDTn0
 7wWWx2aliqSYvA+BhJzYUBSjLTK/c7mLWYae46glcR8kjuVFlx8obuakPlPF7yqJvbk7bd
 k/ZF3uXK4ls6vfA+N2FsSWGKZhrBejY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-379-flxeZ5RnM0yiE_paep-Ymg-1; Sat,
 30 May 2026 03:52:15 -0400
X-MC-Unique: flxeZ5RnM0yiE_paep-Ymg-1
X-Mimecast-MFC-AGG-ID: flxeZ5RnM0yiE_paep-Ymg_1780127535
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F3CF19560AA; Sat, 30 May 2026 07:52:14 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.49.40])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 799C01800347; Sat, 30 May 2026 07:52:12 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org, bruce.richardson@intel.com
Subject: [PATCH v5 00/25] Consolidate bus driver infrastructure
Date: Sat, 30 May 2026 09:51:30 +0200
Message-ID: <20260530075201.869606-1-david.marchand@redhat.com>
In-Reply-To: <20260429114503.932575-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: O5EotFaugI0gmVdc84PJUVRbdzEi9wwQsP8d0L7KHUU_1780127535
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

This is a continuation of the work I started on the bus infrastructure,
but this time, a lot of the changes were done by a AI "friend".
It is still an unfinished topic as the current series focuses on probing
only. The detaching/cleanup aspect is postponed to another release/time.

My AI "friend" really *sucked* at git and at separating unrelated changes,
so it required quite a lot of massage/polishing afterwards.
But it seems good enough now for upstream submission.

I would like to see this series merged in 26.07, so that we have enough
time to stabilize it before the next LTS.
And seeing how it affects drivers, it is probably better to merge it
the sooner possible (so Thomas does not have to solve too many conflicts
when pulling next-* subtrees after, especially wrt the last patch).


This series refactors the DPDK bus infrastructure to consolidate common
operations and reduce code duplication across all bus drivers.
Currently, each bus implements its own specific device/driver lists,
probe logic, and lookup functions.
This series moves these common patterns into the EAL bus layer,
providing generic helpers that all buses can use.

The refactoring removes approximately 1,400 lines of duplicated code across
the codebase while maintaining full functional equivalence.

Key changes:
- Factorize device and driver lists into struct rte_bus
- Implement generic probe, device/driver lookup, and iteration helpers in EAL
- Introduce conversion macros (RTE_BUS_DEVICE, RTE_BUS_DRIVER, RTE_CLASS_TO_BUS_DEVICE)
  to safely convert between generic and bus-specific types
- Remove bus-specific device/driver types from most driver code
- Move probe logic from individual buses to rte_bus_generic_probe()
- Separate NXP-specific metadata from generic bus structures

Benefits:
- Significant code reduction (~1,400 lines removed)
- Consistent behavior across all bus types
- Simplified bus driver implementation
- Easier maintenance and future enhancements

The series is structured as a progressive refactoring:
- Remove redundant checks and helpers, fix existing bugs (patches 1-7)
- Add conversion macros and factorize lists (patches 8-10)
- Consolidate device/driver lookup and iteration (patches 11-13)
- Refactor probe logic (patches 14-17)
- Remove bus-specific types from drivers (patches 18-25)

Note on ABI:
This series breaks the ABI for drivers (changes to rte_pci_device,
rte_pci_driver, and similar structures for other buses). However, the DPDK
ABI policy does not provide guarantees for driver-level interfaces.


-- 
David Marchand

Changes since v4:
- fixed patch 15 (transient bug for bus != pci),
- rebased (conflict on net/ixgbe),

Changes since v3:
- rebased for recently merged net/sxe2,

Changes since v2:
- fixed dma/idxd probing as reported by Bruce,
- moved api_ver setting (from match to scan) in bus/uacce,
- fixed transient bug in the vdev code (in the middle of the series).
  tl;dr the high level difference for bus/vdev between v2 and v3 == 0,
- fixed doxygen,
- enhanced API description,

Changes since v1:
- fix typo in Windows code for net/mlx5,


David Marchand (25):
  bus/ifpga: remove unused AFU lookup helper
  bus/uacce: set API version during scan
  crypto/octeontx: remove check on driver in remove
  dma/idxd: clear device at scan
  bus: remove device and driver checks in DMA map/unmap
  drivers/bus: remove device and driver checks in unplug
  drivers/bus: remove device and driver checks in plug
  bus: add bus conversion macros
  bus: factorize driver list
  bus: factorize device list
  bus: consolidate device lookup
  bus: consolidate device iteration
  bus: factorize driver lookup
  bus: refactor device probe
  bus: support multiple probe
  drivers/bus: initialize NXP bus specifics in scan
  bus: implement probe in EAL
  bus: factorize driver reference
  drivers: rely on generic driver
  drivers/bus: remove bus-specific driver references
  dma/idxd: remove specific bus type
  drivers/bus: separate specific bus metadata for NXP drivers
  drivers/bus: remove specific bus types
  eventdev: rename dev field to device
  bus: add class device conversion macro

 app/test/test_vdev.c                          |   6 +-
 drivers/baseband/acc/rte_acc100_pmd.c         |   4 +-
 drivers/baseband/acc/rte_vrb_pmd.c            |   2 +-
 .../fpga_5gnr_fec/rte_fpga_5gnr_fec.c         |   4 +-
 drivers/baseband/fpga_lte_fec/fpga_lte_fec.c  |   2 +-
 drivers/bus/auxiliary/auxiliary_common.c      | 256 +++-----------
 drivers/bus/auxiliary/auxiliary_params.c      |  65 ----
 drivers/bus/auxiliary/bus_auxiliary_driver.h  |  17 +-
 drivers/bus/auxiliary/linux/auxiliary.c       |  11 +-
 drivers/bus/auxiliary/meson.build             |   5 +-
 drivers/bus/auxiliary/private.h               |  45 +--
 drivers/bus/cdx/bus_cdx_driver.h              |  17 -
 drivers/bus/cdx/cdx.c                         | 259 +++-----------
 drivers/bus/cdx/private.h                     |   9 -
 drivers/bus/dpaa/bus_dpaa_driver.h            |  10 +-
 drivers/bus/dpaa/dpaa_bus.c                   | 317 ++++++-----------
 drivers/bus/fslmc/bus_fslmc_driver.h          |   7 +-
 drivers/bus/fslmc/fslmc_bus.c                 | 330 ++++++-----------
 drivers/bus/fslmc/fslmc_vfio.c                |  55 ++-
 drivers/bus/fslmc/portal/dpaa2_hw_dprc.c      |   4 +-
 drivers/bus/fslmc/private.h                   |  15 +-
 drivers/bus/ifpga/bus_ifpga_driver.h          |  32 +-
 drivers/bus/ifpga/ifpga_bus.c                 | 188 ++--------
 drivers/bus/pci/bsd/pci.c                     |  14 +-
 drivers/bus/pci/bus_pci_driver.h              |  15 +-
 drivers/bus/pci/linux/pci.c                   |  11 +-
 drivers/bus/pci/linux/pci_uio.c               |   6 +-
 drivers/bus/pci/pci_common.c                  | 331 +++++-------------
 drivers/bus/pci/pci_params.c                  |   9 +-
 drivers/bus/pci/private.h                     |  64 +---
 drivers/bus/pci/windows/pci.c                 |  11 +-
 drivers/bus/platform/bus_platform_driver.h    |  14 -
 drivers/bus/platform/meson.build              |   5 +-
 drivers/bus/platform/platform.c               | 191 +++-------
 drivers/bus/platform/platform_params.c        |  72 ----
 drivers/bus/platform/private.h                |  25 --
 drivers/bus/uacce/bus_uacce_driver.h          |  14 -
 drivers/bus/uacce/uacce.c                     | 286 ++++-----------
 drivers/bus/vdev/bus_vdev_driver.h            |  15 +-
 drivers/bus/vdev/meson.build                  |   5 +-
 drivers/bus/vdev/vdev.c                       | 213 +++++------
 drivers/bus/vdev/vdev_logs.h                  |  16 -
 drivers/bus/vdev/vdev_params.c                |  64 ----
 drivers/bus/vdev/vdev_private.h               |  28 --
 drivers/bus/vmbus/bus_vmbus_driver.h          |   3 -
 drivers/bus/vmbus/linux/vmbus_bus.c           |  11 +-
 drivers/bus/vmbus/private.h                   |  23 +-
 drivers/bus/vmbus/vmbus_common.c              | 190 +++-------
 drivers/common/mlx5/linux/mlx5_common_os.c    |   5 +-
 drivers/common/mlx5/mlx5_common.c             |   2 +-
 drivers/common/mlx5/mlx5_common_pci.c         |   2 +-
 drivers/common/mlx5/windows/mlx5_common_os.c  |   2 +-
 drivers/common/qat/qat_qp.c                   |   4 +-
 drivers/common/sxe2/sxe2_common.c             |   4 +-
 drivers/common/zsda/zsda_qp.c                 |   4 +-
 drivers/compress/octeontx/otx_zip.c           |   2 +-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c      |   2 +-
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c   |   3 +-
 drivers/crypto/octeontx/otx_cryptodev.c       |   3 -
 drivers/crypto/octeontx/otx_cryptodev_ops.c   |   4 +-
 drivers/dma/idxd/idxd_bus.c                   | 116 ++----
 drivers/event/cnxk/cn10k_eventdev.c           |   8 +-
 drivers/event/cnxk/cn20k_eventdev.c           |   8 +-
 drivers/event/cnxk/cn9k_eventdev.c            |   6 +-
 drivers/event/cnxk/cnxk_eventdev.c            |   2 +-
 drivers/event/dlb2/pf/dlb2_pf.c               |   2 +-
 drivers/event/skeleton/skeleton_eventdev.c    |   2 +-
 drivers/net/ark/ark_ethdev.c                  |   2 +-
 drivers/net/atlantic/atl_ethdev.c             |  12 +-
 drivers/net/avp/avp_ethdev.c                  |  22 +-
 drivers/net/axgbe/axgbe_ethdev.c              |   4 +-
 drivers/net/bnx2x/bnx2x_ethdev.c              |   2 +-
 drivers/net/bnxt/bnxt_ethdev.c                |  12 +-
 drivers/net/bnxt/tf_ulp/bnxt_ulp.c            |   4 +-
 drivers/net/bonding/rte_eth_bond_args.c       |   4 +-
 drivers/net/cnxk/cnxk_ethdev.c                |   2 +-
 drivers/net/cnxk/cnxk_ethdev_ops.c            |   2 +-
 drivers/net/cxgbe/cxgbe_ethdev.c              |   4 +-
 drivers/net/cxgbe/cxgbevf_ethdev.c            |   4 +-
 drivers/net/dpaa/dpaa_ethdev.c                |  17 +-
 drivers/net/dpaa2/dpaa2_ethdev.c              |   8 +-
 drivers/net/dpaa2/dpaa2_recycle.c             |   8 +-
 drivers/net/ena/ena_ethdev.c                  |  10 +-
 drivers/net/enetc/enetc4_ethdev.c             |   4 +-
 drivers/net/enetc/enetc4_vf.c                 |   4 +-
 drivers/net/enetc/enetc_ethdev.c              |   2 +-
 drivers/net/enic/enic_ethdev.c                |   4 +-
 drivers/net/enic/enic_fm_flow.c               |   6 +-
 drivers/net/enic/enic_vf_representor.c        |   2 +-
 drivers/net/gve/gve_ethdev.c                  |   2 +-
 drivers/net/hinic/hinic_pmd_ethdev.c          |   8 +-
 drivers/net/hinic3/base/hinic3_hwdev.c        |   7 +-
 drivers/net/hinic3/hinic3_ethdev.c            |  16 +-
 drivers/net/hns3/hns3_cmd.c                   |   2 +-
 drivers/net/hns3/hns3_common.c                |   8 +-
 drivers/net/hns3/hns3_ethdev.c                |   6 +-
 drivers/net/hns3/hns3_ethdev_vf.c             |   6 +-
 drivers/net/hns3/hns3_rxtx.c                  |   4 +-
 drivers/net/intel/cpfl/cpfl_ethdev.c          |   4 +-
 drivers/net/intel/cpfl/cpfl_ethdev.h          |   2 +-
 drivers/net/intel/e1000/em_ethdev.c           |  12 +-
 drivers/net/intel/e1000/em_rxtx.c             |   2 +-
 drivers/net/intel/e1000/igb_ethdev.c          |  30 +-
 drivers/net/intel/e1000/igb_pf.c              |   2 +-
 drivers/net/intel/e1000/igc_ethdev.c          |  22 +-
 drivers/net/intel/fm10k/fm10k_ethdev.c        |  16 +-
 drivers/net/intel/i40e/i40e_ethdev.c          |  28 +-
 drivers/net/intel/i40e/i40e_ethdev.h          |   2 +-
 drivers/net/intel/iavf/iavf_ethdev.c          |   8 +-
 drivers/net/intel/ice/ice_dcf.c               |   6 +-
 drivers/net/intel/ice/ice_ethdev.c            |   6 +-
 drivers/net/intel/ice/ice_ethdev.h            |   2 +-
 drivers/net/intel/idpf/idpf_ethdev.h          |   2 +-
 drivers/net/intel/ipn3ke/ipn3ke_ethdev.h      |  13 -
 drivers/net/intel/ipn3ke/ipn3ke_representor.c |   6 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.c        |  40 +--
 drivers/net/intel/ixgbe/ixgbe_pf.c            |   2 +-
 drivers/net/intel/ixgbe/ixgbe_tm.c            |   2 +-
 .../net/intel/ixgbe/ixgbe_vf_representor.c    |   2 +-
 drivers/net/intel/ixgbe/rte_pmd_ixgbe.c       |  20 +-
 drivers/net/mlx5/linux/mlx5_os.c              |   9 +-
 drivers/net/mlx5/windows/mlx5_os.c            |   4 +-
 drivers/net/nbl/nbl_core.c                    |   2 +-
 drivers/net/nbl/nbl_dev/nbl_dev.c             |   6 +-
 drivers/net/netvsc/hn_ethdev.c                |   3 +-
 drivers/net/nfp/nfp_ethdev.c                  |   8 +-
 drivers/net/nfp/nfp_ethdev_vf.c               |   6 +-
 drivers/net/nfp/nfp_net_common.c              |   8 +-
 drivers/net/ngbe/ngbe_ethdev.c                |  20 +-
 drivers/net/ngbe/ngbe_ethdev_vf.c             |  16 +-
 drivers/net/ngbe/ngbe_pf.c                    |   2 +-
 drivers/net/ntnic/ntnic_ethdev.c              |   8 +-
 drivers/net/octeon_ep/otx_ep_ethdev.c         |   2 +-
 drivers/net/octeon_ep/otx_ep_mbox.c           |   6 +-
 drivers/net/qede/qede_ethdev.c                |   6 +-
 drivers/net/r8169/r8169_ethdev.c              |   6 +-
 drivers/net/rnp/rnp_ethdev.c                  |   6 +-
 drivers/net/sfc/sfc.c                         |   4 +-
 drivers/net/sfc/sfc_ethdev.c                  |   2 +-
 drivers/net/sfc/sfc_intr.c                    |  10 +-
 drivers/net/sfc/sfc_rx.c                      |   3 +-
 drivers/net/sfc/sfc_sriov.c                   |   2 +-
 drivers/net/sfc/sfc_tx.c                      |   3 +-
 drivers/net/sxe2/sxe2_ethdev.c                |   8 +-
 drivers/net/sxe2/sxe2_ethdev.h                |   3 -
 drivers/net/thunderx/nicvf_ethdev.c           |   4 +-
 drivers/net/txgbe/txgbe_ethdev.c              |  26 +-
 drivers/net/txgbe/txgbe_ethdev_vf.c           |  16 +-
 drivers/net/txgbe/txgbe_flow.c                |   4 +-
 drivers/net/txgbe/txgbe_pf.c                  |   2 +-
 drivers/net/txgbe/txgbe_tm.c                  |   2 +-
 drivers/net/vdev_netvsc/vdev_netvsc.c         |   2 +-
 drivers/net/virtio/virtio_pci_ethdev.c        |  11 +-
 drivers/net/vmxnet3/vmxnet3_ethdev.c          |   4 +-
 drivers/net/xsc/xsc_ethdev.c                  |   2 +-
 drivers/net/zxdh/zxdh_ethdev.c                |   8 +-
 drivers/raw/cnxk_bphy/cnxk_bphy.c             |   2 +-
 drivers/raw/cnxk_bphy/cnxk_bphy_cgx.c         |   2 +-
 drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c         |   2 +-
 drivers/raw/ifpga/afu_pmd_core.c              |   2 +-
 drivers/raw/ifpga/afu_pmd_n3000.c             |   4 +-
 drivers/raw/ifpga/ifpga_rawdev.c              |   4 +-
 drivers/raw/ntb/ntb.c                         |   2 +-
 lib/eal/common/eal_common_bus.c               | 186 +++++++++-
 lib/eal/common/eal_common_dev.c               |  45 ++-
 lib/eal/common/hotplug_mp.c                   |   4 +-
 lib/eal/include/bus_driver.h                  | 307 +++++++++++++++-
 lib/eal/include/dev_driver.h                  |   1 +
 lib/eal/linux/eal_dev.c                       |   3 +-
 lib/ethdev/ethdev_pci.h                       |   7 +-
 lib/ethdev/rte_ethdev.c                       |   2 +-
 lib/eventdev/eventdev_pmd.h                   |   2 +-
 lib/eventdev/eventdev_pmd_pci.h               |   4 +-
 lib/eventdev/eventdev_pmd_vdev.h              |   2 +-
 lib/eventdev/rte_eventdev.c                   |  14 +-
 175 files changed, 1687 insertions(+), 3046 deletions(-)
 delete mode 100644 drivers/bus/auxiliary/auxiliary_params.c
 delete mode 100644 drivers/bus/platform/platform_params.c
 delete mode 100644 drivers/bus/vdev/vdev_logs.h
 delete mode 100644 drivers/bus/vdev/vdev_params.c
 delete mode 100644 drivers/bus/vdev/vdev_private.h

-- 
2.53.0

