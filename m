Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E71B7C369AB
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 22:32:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BA35740B8F;
	Wed, 16 Apr 2025 00:32:01 +0200 (CEST)
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
 by mails.dpdk.org (Postfix) with ESMTP id 1AAD940655
 for <dev@dpdk.org>; Wed, 16 Apr 2025 00:31:56 +0200 (CEST)
Received: by linux.microsoft.com (Postfix, from userid 1213)
 id 2D734210C452; Tue, 15 Apr 2025 15:31:55 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 2D734210C452
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
 s=default; t=1744756315;
 bh=vsDrvax7s9itEqU0WBJ+QWTAKK5V5MuOQKVN9TTbZxY=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=ciRnOdqnlDoKK19al7l3EfsqSRRP8bZQo0cWtwb6+Msm+hYPJWnX6pVgU5NpQQWA9
 Tx+HyHmxkyNbv5uInS/qkm7QeHKh8XgDtC0kMg1x9tVpzU9Aqk7QaTr+lz6a07EbdY
 6KhcOAynaP4EMEuQL/tv0Gs+fvjcpRSK33IIsIuk=
From: Andre Muezerie <andremue@linux.microsoft.com>
To: andremue@linux.microsoft.com
Cc: dev@dpdk.org
Subject: [PATCH v3 4/4] drivers: use macro to embed information in binaries
Date: Tue, 15 Apr 2025 15:31:37 -0700
Message-Id: <1744756297-21038-5-git-send-email-andremue@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1744756297-21038-1-git-send-email-andremue@linux.microsoft.com>
References: <1744400374-26620-1-git-send-email-andremue@linux.microsoft.com>
 <1744756297-21038-1-git-send-email-andremue@linux.microsoft.com>
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

DPDK uses GCC attribute "used" through macro __rte_used to indicate
that a variable not referenced in the code should be assumed being
used and therefore not be optimized away. This technique is used to embed
information in the binaries, by having crafted information stored in
them.

MSVC offers similar functionality, but it differs significantly: MSVC
requires a pragma to be used to send a command to the linker telling it
explicitly the name of the symbol that should be included (even if not
referenced). As a side-effect, variables called out to be included cannot
be static, otherwise their symbols are not "seen" by the linker. This
restriction requires some DPDK code to be refactored.

Macro RTE_INCLUDE is used in this patch to ensure these special variables
make it to the final binaries.

The elimination of "static" for some of these variables caused name
clashes when __COUNTER__ predefined macro was used. As a workaround,
predefined macro __LINE__ was used instead. However, when __COUNTER__
was used directly from a header file, __LINE__ had to be used from the
.c files, otherwise it would also not result in a unique symbol. This
required a parameter to be added to some macros so that the __LINE__
could be passed from the .c file to the macro defined in the header
(which was originally using __COUNTER__).

Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
---
 drivers/baseband/acc/rte_acc100_pmd.c              |  4 ++--
 drivers/baseband/acc/rte_vrb_pmd.c                 |  4 ++--
 drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c |  4 ++--
 drivers/baseband/fpga_lte_fec/fpga_lte_fec.c       |  4 ++--
 drivers/baseband/la12xx/bbdev_la12xx.c             |  2 +-
 drivers/baseband/null/bbdev_null.c                 |  2 +-
 drivers/baseband/turbo_sw/bbdev_turbo_software.c   |  2 +-
 drivers/bus/auxiliary/bus_auxiliary_driver.h       |  4 ++--
 drivers/bus/cdx/bus_cdx_driver.h                   |  7 +++----
 drivers/bus/dpaa/bus_dpaa_driver.h                 |  4 ++--
 drivers/bus/fslmc/bus_fslmc_driver.h               |  8 ++++----
 drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c           |  2 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpci.c           |  2 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c           |  2 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dprc.c           |  2 +-
 drivers/bus/ifpga/bus_ifpga_driver.h               |  4 ++--
 drivers/bus/pci/bus_pci_driver.h                   |  4 ++--
 drivers/bus/platform/bus_platform_driver.h         |  4 ++--
 drivers/bus/uacce/bus_uacce_driver.h               |  4 ++--
 drivers/bus/vdev/bus_vdev_driver.h                 |  4 ++--
 drivers/bus/vmbus/bus_vmbus_driver.h               |  4 ++--
 drivers/common/mlx5/mlx5_common.c                  |  2 +-
 drivers/common/mlx5/mlx5_common_pci.c              |  2 +-
 drivers/common/nitrox/nitrox_device.c              |  2 +-
 drivers/common/qat/qat_device.c                    |  2 +-
 drivers/common/zsda/zsda_device.c                  |  2 +-
 drivers/compress/isal/isal_compress_pmd.c          |  2 +-
 drivers/compress/mlx5/mlx5_compress.c              |  2 +-
 drivers/compress/octeontx/otx_zip_pmd.c            |  2 +-
 drivers/compress/uadk/uadk_compress_pmd.c          |  2 +-
 drivers/compress/zlib/zlib_pmd.c                   |  2 +-
 drivers/crypto/armv8/rte_armv8_pmd.c               |  2 +-
 drivers/crypto/bcmfs/bcmfs_device.c                |  3 +--
 drivers/crypto/caam_jr/caam_jr.c                   |  2 +-
 drivers/crypto/ccp/rte_ccp_pmd.c                   |  2 +-
 drivers/crypto/cnxk/cn10k_cryptodev.c              |  2 +-
 drivers/crypto/cnxk/cn9k_cryptodev.c               |  2 +-
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c        |  2 +-
 drivers/crypto/dpaa_sec/dpaa_sec.c                 |  2 +-
 drivers/crypto/ionic/ionic_crypto_vdev.c           |  2 +-
 drivers/crypto/ipsec_mb/pmd_aesni_gcm.c            |  3 +--
 drivers/crypto/ipsec_mb/pmd_aesni_mb.c             |  3 +--
 drivers/crypto/ipsec_mb/pmd_chacha_poly.c          |  3 ++-
 drivers/crypto/ipsec_mb/pmd_kasumi.c               |  2 +-
 drivers/crypto/ipsec_mb/pmd_snow3g.c               |  2 +-
 drivers/crypto/ipsec_mb/pmd_zuc.c                  |  2 +-
 drivers/crypto/mlx5/mlx5_crypto.c                  |  2 +-
 drivers/crypto/mvsam/rte_mrvl_pmd.c                |  2 +-
 drivers/crypto/null/null_crypto_pmd.c              |  2 +-
 drivers/crypto/octeontx/otx_cryptodev.c            |  2 +-
 drivers/crypto/openssl/rte_openssl_pmd.c           |  3 +--
 drivers/crypto/scheduler/scheduler_pmd.c           |  3 +--
 drivers/crypto/uadk/uadk_crypto_pmd.c              |  2 +-
 drivers/crypto/virtio/virtio_cryptodev.c           |  2 +-
 drivers/crypto/virtio/virtio_user_cryptodev.c      |  2 +-
 drivers/dma/cnxk/cnxk_dmadev.c                     |  2 +-
 drivers/dma/dpaa/dpaa_qdma.c                       |  2 +-
 drivers/dma/dpaa2/dpaa2_qdma.c                     |  2 +-
 drivers/dma/hisilicon/hisi_dmadev.c                |  2 +-
 drivers/dma/idxd/idxd_pci.c                        |  2 +-
 drivers/dma/ioat/ioat_dmadev.c                     |  2 +-
 drivers/dma/odm/odm_dmadev.c                       |  2 +-
 drivers/dma/skeleton/skeleton_dmadev.c             |  2 +-
 drivers/event/cnxk/cn10k_eventdev.c                |  2 +-
 drivers/event/cnxk/cn20k_eventdev.c                |  2 +-
 drivers/event/cnxk/cn9k_eventdev.c                 |  2 +-
 drivers/event/dlb2/pf/dlb2_pf.c                    |  4 ++--
 drivers/event/dpaa/dpaa_eventdev.c                 |  2 +-
 drivers/event/dpaa2/dpaa2_eventdev.c               |  2 +-
 drivers/event/dpaa2/dpaa2_hw_dpcon.c               |  2 +-
 drivers/event/dsw/dsw_evdev.c                      |  2 +-
 drivers/event/octeontx/ssovf_evdev.c               |  3 ++-
 drivers/event/octeontx/ssovf_probe.c               |  4 ++--
 drivers/event/octeontx/timvf_probe.c               |  2 +-
 drivers/event/opdl/opdl_evdev.c                    |  2 +-
 drivers/event/skeleton/skeleton_eventdev.c         |  4 ++--
 drivers/event/sw/sw_evdev.c                        |  2 +-
 drivers/gpu/cuda/cuda.c                            |  2 +-
 drivers/mempool/cnxk/cnxk_mempool.c                |  2 +-
 drivers/mempool/octeontx/octeontx_fpavf.c          |  2 +-
 drivers/ml/cnxk/cn10k_ml_dev.c                     |  2 +-
 drivers/ml/cnxk/mvtvm_ml_dev.c                     |  2 +-
 drivers/net/af_packet/rte_eth_af_packet.c          |  2 +-
 drivers/net/af_xdp/rte_eth_af_xdp.c                |  2 +-
 drivers/net/ark/ark_ethdev.c                       |  2 +-
 drivers/net/atlantic/atl_ethdev.c                  |  2 +-
 drivers/net/avp/avp_ethdev.c                       |  2 +-
 drivers/net/axgbe/axgbe_ethdev.c                   |  2 +-
 drivers/net/bnx2x/bnx2x_ethdev.c                   |  5 +++--
 drivers/net/bnxt/bnxt_ethdev.c                     |  2 +-
 drivers/net/bonding/rte_eth_bond_pmd.c             |  2 +-
 drivers/net/cnxk/cn10k_ethdev.c                    |  2 +-
 drivers/net/cnxk/cn20k_ethdev.c                    |  2 +-
 drivers/net/cnxk/cn9k_ethdev.c                     |  2 +-
 drivers/net/cnxk/cnxk_eswitch.c                    |  2 +-
 drivers/net/cnxk/cnxk_ethdev_sec.c                 |  2 +-
 drivers/net/cxgbe/cxgbe_ethdev.c                   |  2 +-
 drivers/net/cxgbe/cxgbevf_ethdev.c                 |  2 +-
 drivers/net/dpaa/dpaa_ethdev.c                     |  2 +-
 drivers/net/dpaa2/dpaa2_ethdev.c                   |  2 +-
 drivers/net/dpaa2/dpaa2_mux.c                      |  2 +-
 drivers/net/dpaa2/dpaa2_ptp.c                      |  2 +-
 drivers/net/ena/ena_ethdev.c                       |  2 +-
 drivers/net/enetc/enetc_ethdev.c                   |  2 +-
 drivers/net/enetfec/enet_ethdev.c                  |  2 +-
 drivers/net/enic/enic_ethdev.c                     |  2 +-
 drivers/net/failsafe/failsafe.c                    |  2 +-
 drivers/net/gve/gve_ethdev.c                       |  2 +-
 drivers/net/hinic/hinic_pmd_ethdev.c               |  2 +-
 drivers/net/hns3/hns3_ethdev.c                     |  2 +-
 drivers/net/hns3/hns3_ethdev_vf.c                  |  2 +-
 drivers/net/intel/cpfl/cpfl_ethdev.c               |  2 +-
 drivers/net/intel/e1000/em_ethdev.c                |  2 +-
 drivers/net/intel/e1000/igb_ethdev.c               |  4 ++--
 drivers/net/intel/e1000/igc_ethdev.c               |  2 +-
 drivers/net/intel/fm10k/fm10k_ethdev.c             |  2 +-
 drivers/net/intel/i40e/i40e_ethdev.c               |  2 +-
 drivers/net/intel/iavf/iavf_ethdev.c               |  2 +-
 drivers/net/intel/ice/ice_dcf_ethdev.c             |  2 +-
 drivers/net/intel/ice/ice_ethdev.c                 |  2 +-
 drivers/net/intel/idpf/idpf_ethdev.c               |  2 +-
 drivers/net/intel/ipn3ke/ipn3ke_ethdev.c           |  2 +-
 drivers/net/intel/ixgbe/ixgbe_ethdev.c             |  4 ++--
 drivers/net/ionic/ionic_dev_pci.c                  |  2 +-
 drivers/net/ionic/ionic_dev_vdev.c                 |  3 ++-
 drivers/net/mana/mana.c                            |  2 +-
 drivers/net/memif/rte_eth_memif.c                  |  2 +-
 drivers/net/mlx4/mlx4.c                            |  2 +-
 drivers/net/mlx5/mlx5.c                            |  2 +-
 drivers/net/mvneta/mvneta_ethdev.c                 |  2 +-
 drivers/net/mvpp2/mrvl_ethdev.c                    |  2 +-
 drivers/net/netvsc/hn_ethdev.c                     |  2 +-
 drivers/net/nfb/nfb_ethdev.c                       |  2 +-
 drivers/net/nfp/nfp_ethdev.c                       |  2 +-
 drivers/net/ngbe/ngbe_ethdev.c                     |  2 +-
 drivers/net/ngbe/ngbe_ethdev_vf.c                  |  2 +-
 drivers/net/ntnic/ntnic_ethdev.c                   |  2 +-
 drivers/net/null/rte_eth_null.c                    |  2 +-
 drivers/net/octeon_ep/otx_ep_ethdev.c              |  2 +-
 drivers/net/octeontx/base/octeontx_pkivf.c         |  2 +-
 drivers/net/octeontx/base/octeontx_pkovf.c         |  2 +-
 drivers/net/octeontx/octeontx_ethdev.c             |  3 ++-
 drivers/net/pcap/pcap_ethdev.c                     |  2 +-
 drivers/net/pfe/pfe_ethdev.c                       |  2 +-
 drivers/net/qede/qede_ethdev.c                     |  4 ++--
 drivers/net/r8169/r8169_ethdev.c                   |  2 +-
 drivers/net/ring/rte_eth_ring.c                    |  2 +-
 drivers/net/sfc/sfc_ethdev.c                       |  2 +-
 drivers/net/softnic/rte_eth_softnic.c              |  2 +-
 drivers/net/tap/rte_eth_tap.c                      |  4 ++--
 drivers/net/thunderx/nicvf_ethdev.c                |  2 +-
 drivers/net/txgbe/txgbe_ethdev.c                   |  2 +-
 drivers/net/txgbe/txgbe_ethdev_vf.c                |  2 +-
 drivers/net/vdev_netvsc/vdev_netvsc.c              |  2 +-
 drivers/net/vhost/rte_eth_vhost.c                  |  2 +-
 drivers/net/virtio/virtio_pci_ethdev.c             |  2 +-
 drivers/net/virtio/virtio_user_ethdev.c            |  2 +-
 drivers/net/vmxnet3/vmxnet3_ethdev.c               |  2 +-
 drivers/net/xsc/xsc_ethdev.c                       |  2 +-
 drivers/net/zxdh/zxdh_ethdev.c                     |  2 +-
 drivers/raw/cnxk_bphy/cnxk_bphy.c                  |  2 +-
 drivers/raw/cnxk_bphy/cnxk_bphy_cgx.c              |  2 +-
 drivers/raw/cnxk_gpio/cnxk_gpio.c                  |  2 +-
 drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c              |  2 +-
 drivers/raw/dpaa2_cmdif/dpaa2_cmdif.c              |  2 +-
 drivers/raw/gdtc/gdtc_rawdev.c                     |  2 +-
 drivers/raw/ifpga/afu_pmd_core.c                   |  2 +-
 drivers/raw/ifpga/ifpga_rawdev.c                   |  4 ++--
 drivers/raw/ntb/ntb.c                              |  2 +-
 drivers/raw/skeleton/skeleton_rawdev.c             |  2 +-
 drivers/regex/cn9k/cn9k_regexdev.c                 |  2 +-
 drivers/regex/mlx5/mlx5_regex.c                    |  2 +-
 drivers/vdpa/ifc/ifcvf_vdpa.c                      |  2 +-
 drivers/vdpa/mlx5/mlx5_vdpa.c                      |  2 +-
 drivers/vdpa/sfc/sfc_vdpa.c                        |  2 +-
 lib/eal/include/rte_dev.h                          | 14 +++++---------
 176 files changed, 211 insertions(+), 216 deletions(-)

diff --git a/drivers/baseband/acc/rte_acc100_pmd.c b/drivers/baseband/acc/rte_acc100_pmd.c
index b7f02f56e1..a4cbe6f42f 100644
--- a/drivers/baseband/acc/rte_acc100_pmd.c
+++ b/drivers/baseband/acc/rte_acc100_pmd.c
@@ -4082,9 +4082,9 @@ static struct rte_pci_driver acc100_pci_vf_driver = {
 		.drv_flags = RTE_PCI_DRV_NEED_MAPPING
 };
 
-RTE_PMD_REGISTER_PCI(ACC100PF_DRIVER_NAME, acc100_pci_pf_driver);
+RTE_PMD_REGISTER_PCI(ACC100PF_DRIVER_NAME, acc100_pci_pf_driver, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(ACC100PF_DRIVER_NAME, pci_id_acc100_pf_map);
-RTE_PMD_REGISTER_PCI(ACC100VF_DRIVER_NAME, acc100_pci_vf_driver);
+RTE_PMD_REGISTER_PCI(ACC100VF_DRIVER_NAME, acc100_pci_vf_driver, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(ACC100VF_DRIVER_NAME, pci_id_acc100_vf_map);
 
 /*
diff --git a/drivers/baseband/acc/rte_vrb_pmd.c b/drivers/baseband/acc/rte_vrb_pmd.c
index 2c10ef2c94..525130aaa3 100644
--- a/drivers/baseband/acc/rte_vrb_pmd.c
+++ b/drivers/baseband/acc/rte_vrb_pmd.c
@@ -4460,9 +4460,9 @@ static struct rte_pci_driver vrb_pci_vf_driver = {
 		.drv_flags = RTE_PCI_DRV_NEED_MAPPING
 };
 
-RTE_PMD_REGISTER_PCI(VRB_PF_DRIVER_NAME, vrb_pci_pf_driver);
+RTE_PMD_REGISTER_PCI(VRB_PF_DRIVER_NAME, vrb_pci_pf_driver, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(VRB_PF_DRIVER_NAME, pci_id_vrb_pf_map);
-RTE_PMD_REGISTER_PCI(VRB_VF_DRIVER_NAME, vrb_pci_vf_driver);
+RTE_PMD_REGISTER_PCI(VRB_VF_DRIVER_NAME, vrb_pci_vf_driver, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(VRB_VF_DRIVER_NAME, pci_id_vrb_vf_map);
 
 /* Initial configuration of a VRB1 device prior to running configure(). */
diff --git a/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c b/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c
index 82cf98da5d..592e3aafcd 100644
--- a/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c
+++ b/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c
@@ -3424,7 +3424,7 @@ static struct rte_pci_driver fpga_5gnr_fec_pci_vf_driver = {
 };
 
 
-RTE_PMD_REGISTER_PCI(FPGA_5GNR_FEC_PF_DRIVER_NAME, fpga_5gnr_fec_pci_pf_driver);
+RTE_PMD_REGISTER_PCI(FPGA_5GNR_FEC_PF_DRIVER_NAME, fpga_5gnr_fec_pci_pf_driver, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(FPGA_5GNR_FEC_PF_DRIVER_NAME, pci_id_fpga_5gnr_fec_pf_map);
-RTE_PMD_REGISTER_PCI(FPGA_5GNR_FEC_VF_DRIVER_NAME, fpga_5gnr_fec_pci_vf_driver);
+RTE_PMD_REGISTER_PCI(FPGA_5GNR_FEC_VF_DRIVER_NAME, fpga_5gnr_fec_pci_vf_driver, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(FPGA_5GNR_FEC_VF_DRIVER_NAME, pci_id_fpga_5gnr_fec_vf_map);
diff --git a/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c b/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c
index 4723a51dcf..d3e17e93ba 100644
--- a/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c
+++ b/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c
@@ -2664,9 +2664,9 @@ static struct rte_pci_driver fpga_lte_fec_pci_vf_driver = {
 };
 
 
-RTE_PMD_REGISTER_PCI(FPGA_LTE_FEC_PF_DRIVER_NAME, fpga_lte_fec_pci_pf_driver);
+RTE_PMD_REGISTER_PCI(FPGA_LTE_FEC_PF_DRIVER_NAME, fpga_lte_fec_pci_pf_driver, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(FPGA_LTE_FEC_PF_DRIVER_NAME,
 		pci_id_fpga_lte_fec_pf_map);
-RTE_PMD_REGISTER_PCI(FPGA_LTE_FEC_VF_DRIVER_NAME, fpga_lte_fec_pci_vf_driver);
+RTE_PMD_REGISTER_PCI(FPGA_LTE_FEC_VF_DRIVER_NAME, fpga_lte_fec_pci_vf_driver, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(FPGA_LTE_FEC_VF_DRIVER_NAME,
 		pci_id_fpga_lte_fec_vf_map);
diff --git a/drivers/baseband/la12xx/bbdev_la12xx.c b/drivers/baseband/la12xx/bbdev_la12xx.c
index 8928cdd89e..73d856450d 100644
--- a/drivers/baseband/la12xx/bbdev_la12xx.c
+++ b/drivers/baseband/la12xx/bbdev_la12xx.c
@@ -1111,7 +1111,7 @@ static struct rte_vdev_driver bbdev_la12xx_pmd_drv = {
 	.remove = la12xx_bbdev_remove
 };
 
-RTE_PMD_REGISTER_VDEV(DRIVER_NAME, bbdev_la12xx_pmd_drv);
+RTE_PMD_REGISTER_VDEV(DRIVER_NAME, bbdev_la12xx_pmd_drv, __LINE__);
 RTE_PMD_REGISTER_PARAM_STRING(DRIVER_NAME,
 	LA12XX_MAX_NB_QUEUES_ARG"=<int>"
 	LA12XX_VDEV_MODEM_ID_ARG "=<int> ");
diff --git a/drivers/baseband/null/bbdev_null.c b/drivers/baseband/null/bbdev_null.c
index dab416aa41..89a64592d6 100644
--- a/drivers/baseband/null/bbdev_null.c
+++ b/drivers/baseband/null/bbdev_null.c
@@ -349,7 +349,7 @@ static struct rte_vdev_driver bbdev_null_pmd_drv = {
 	.remove = null_bbdev_remove
 };
 
-RTE_PMD_REGISTER_VDEV(DRIVER_NAME, bbdev_null_pmd_drv);
+RTE_PMD_REGISTER_VDEV(DRIVER_NAME, bbdev_null_pmd_drv, __LINE__);
 RTE_PMD_REGISTER_PARAM_STRING(DRIVER_NAME,
 	BBDEV_NULL_MAX_NB_QUEUES_ARG"=<int> "
 	BBDEV_NULL_SOCKET_ID_ARG"=<int>");
diff --git a/drivers/baseband/turbo_sw/bbdev_turbo_software.c b/drivers/baseband/turbo_sw/bbdev_turbo_software.c
index e527008524..63ab7b2ca2 100644
--- a/drivers/baseband/turbo_sw/bbdev_turbo_software.c
+++ b/drivers/baseband/turbo_sw/bbdev_turbo_software.c
@@ -1985,7 +1985,7 @@ static struct rte_vdev_driver bbdev_turbo_sw_pmd_drv = {
 	.remove = turbo_sw_bbdev_remove
 };
 
-RTE_PMD_REGISTER_VDEV(DRIVER_NAME, bbdev_turbo_sw_pmd_drv);
+RTE_PMD_REGISTER_VDEV(DRIVER_NAME, bbdev_turbo_sw_pmd_drv, __LINE__);
 RTE_PMD_REGISTER_PARAM_STRING(DRIVER_NAME,
 	TURBO_SW_MAX_NB_QUEUES_ARG"=<int> "
 	TURBO_SW_SOCKET_ID_ARG"=<int>");
diff --git a/drivers/bus/auxiliary/bus_auxiliary_driver.h b/drivers/bus/auxiliary/bus_auxiliary_driver.h
index 40ab1f0912..c805dceca7 100644
--- a/drivers/bus/auxiliary/bus_auxiliary_driver.h
+++ b/drivers/bus/auxiliary/bus_auxiliary_driver.h
@@ -162,13 +162,13 @@ __rte_internal
 void rte_auxiliary_register(struct rte_auxiliary_driver *driver);
 
 /** Helper for auxiliary device registration from driver instance */
-#define RTE_PMD_REGISTER_AUXILIARY(nm, auxiliary_drv) \
+#define RTE_PMD_REGISTER_AUXILIARY(nm, auxiliary_drv, idx) \
 	RTE_INIT(auxiliaryinitfn_ ##nm) \
 	{ \
 		(auxiliary_drv).driver.name = RTE_STR(nm); \
 		rte_auxiliary_register(&(auxiliary_drv)); \
 	} \
-	RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+	RTE_PMD_EXPORT_NAME(nm, idx)
 
 /**
  * Unregister an auxiliary driver.
diff --git a/drivers/bus/cdx/bus_cdx_driver.h b/drivers/bus/cdx/bus_cdx_driver.h
index d390e7b5a1..0a0c4e6ab9 100644
--- a/drivers/bus/cdx/bus_cdx_driver.h
+++ b/drivers/bus/cdx/bus_cdx_driver.h
@@ -35,8 +35,7 @@ struct rte_cdx_bus;
 #define RTE_CDX_ANY_ID (0xffff)
 
 #define RTE_PMD_REGISTER_CDX_TABLE(name, table) \
-static const char DRV_EXP_TAG(name, cdx_tbl_export)[] __rte_used = \
-RTE_STR(table)
+RTE_INCLUDE(const char, DRV_EXP_TAG(name, cdx_tbl_export))[] = RTE_STR(table)
 
 /** Device needs resource mapping */
 #define RTE_CDX_DRV_NEED_MAPPING 0x0001
@@ -147,13 +146,13 @@ void rte_cdx_register(struct rte_cdx_driver *driver);
 /**
  * Helper for CDX device registration from driver (eth, crypto, raw) instance.
  */
-#define RTE_PMD_REGISTER_CDX(nm, cdx_drv) \
+#define RTE_PMD_REGISTER_CDX(nm, cdx_drv, idx) \
 	RTE_INIT(cdxinitfn_ ##nm) \
 	{\
 		(cdx_drv).driver.name = RTE_STR(nm);\
 		rte_cdx_register(&cdx_drv); \
 	} \
-	RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+	RTE_PMD_EXPORT_NAME(nm, idx)
 
 /**
  * Enables VFIO Interrupts for CDX bus devices.
diff --git a/drivers/bus/dpaa/bus_dpaa_driver.h b/drivers/bus/dpaa/bus_dpaa_driver.h
index 26a83b2cdf..b564dd60c2 100644
--- a/drivers/bus/dpaa/bus_dpaa_driver.h
+++ b/drivers/bus/dpaa/bus_dpaa_driver.h
@@ -239,13 +239,13 @@ int rte_dpaa_portal_fq_close(struct qman_fq *fq);
 void dpaa_portal_finish(void *arg);
 
 /** Helper for DPAA device registration from driver (eth, crypto) instance */
-#define RTE_PMD_REGISTER_DPAA(nm, dpaa_drv) \
+#define RTE_PMD_REGISTER_DPAA(nm, dpaa_drv, idx) \
 RTE_INIT(dpaainitfn_ ##nm) \
 {\
 	(dpaa_drv).driver.name = RTE_STR(nm);\
 	rte_dpaa_driver_register(&dpaa_drv); \
 } \
-RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+RTE_PMD_EXPORT_NAME(nm, idx)
 
 __rte_internal
 struct fm_eth_port_cfg *dpaa_get_eth_port_cfg(int dev_id);
diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus_fslmc_driver.h
index 1d4ce4785f..ba57427f2a 100644
--- a/drivers/bus/fslmc/bus_fslmc_driver.h
+++ b/drivers/bus/fslmc/bus_fslmc_driver.h
@@ -199,13 +199,13 @@ __rte_internal
 void rte_fslmc_driver_unregister(struct rte_dpaa2_driver *driver);
 
 /** Helper for DPAA2 device registration from driver (eth, crypto) instance */
-#define RTE_PMD_REGISTER_DPAA2(nm, dpaa2_drv) \
+#define RTE_PMD_REGISTER_DPAA2(nm, dpaa2_drv, idx) \
 RTE_INIT(dpaa2initfn_ ##nm) \
 {\
 	(dpaa2_drv).driver.name = RTE_STR(nm);\
 	rte_fslmc_driver_register(&dpaa2_drv); \
 } \
-RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+RTE_PMD_EXPORT_NAME(nm, idx)
 
 /**
  * Register a DPAA2 MC Object driver.
@@ -230,13 +230,13 @@ __rte_internal
 uint32_t rte_fslmc_get_device_count(enum rte_dpaa2_dev_type device_type);
 
 /** Helper for DPAA2 object registration */
-#define RTE_PMD_REGISTER_DPAA2_OBJECT(nm, dpaa2_obj) \
+#define RTE_PMD_REGISTER_DPAA2_OBJECT(nm, dpaa2_obj, idx) \
 RTE_INIT(dpaa2objinitfn_ ##nm) \
 {\
 	(dpaa2_obj).name = RTE_STR(nm);\
 	rte_fslmc_object_register(&dpaa2_obj); \
 } \
-RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+RTE_PMD_EXPORT_NAME(nm, idx)
 
 #ifdef __cplusplus
 }
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c
index 925e83e97d..af1ccafb03 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c
@@ -153,4 +153,4 @@ static struct rte_dpaa2_object rte_dpaa2_dpbp_obj = {
 	.close = dpaa2_close_dpbp_device,
 };
 
-RTE_PMD_REGISTER_DPAA2_OBJECT(dpbp, rte_dpaa2_dpbp_obj);
+RTE_PMD_REGISTER_DPAA2_OBJECT(dpbp, rte_dpaa2_dpbp_obj, __LINE__);
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c
index b546da82f6..af443bbb7e 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c
@@ -202,4 +202,4 @@ static struct rte_dpaa2_object rte_dpaa2_dpci_obj = {
 	.close = rte_dpaa2_close_dpci_device,
 };
 
-RTE_PMD_REGISTER_DPAA2_OBJECT(dpci, rte_dpaa2_dpci_obj);
+RTE_PMD_REGISTER_DPAA2_OBJECT(dpci, rte_dpaa2_dpci_obj, __LINE__);
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index bad25a0ec2..75ba8c48ec 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -692,4 +692,4 @@ static struct rte_dpaa2_object rte_dpaa2_dpio_obj = {
 	.close = dpaa2_close_dpio_device,
 };
 
-RTE_PMD_REGISTER_DPAA2_OBJECT(dpio, rte_dpaa2_dpio_obj);
+RTE_PMD_REGISTER_DPAA2_OBJECT(dpio, rte_dpaa2_dpio_obj, __LINE__);
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dprc.c b/drivers/bus/fslmc/portal/dpaa2_hw_dprc.c
index a057cb1309..7d5ee64f3e 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dprc.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dprc.c
@@ -99,4 +99,4 @@ static struct rte_dpaa2_object rte_dpaa2_dprc_obj = {
 	.create = rte_dpaa2_create_dprc_device,
 };
 
-RTE_PMD_REGISTER_DPAA2_OBJECT(dprc, rte_dpaa2_dprc_obj);
+RTE_PMD_REGISTER_DPAA2_OBJECT(dprc, rte_dpaa2_dprc_obj, __LINE__);
diff --git a/drivers/bus/ifpga/bus_ifpga_driver.h b/drivers/bus/ifpga/bus_ifpga_driver.h
index 56ce34c91d..0885d87faf 100644
--- a/drivers/bus/ifpga/bus_ifpga_driver.h
+++ b/drivers/bus/ifpga/bus_ifpga_driver.h
@@ -146,7 +146,7 @@ void rte_ifpga_driver_register(struct rte_afu_driver *driver);
 __rte_internal
 void rte_ifpga_driver_unregister(struct rte_afu_driver *driver);
 
-#define RTE_PMD_REGISTER_AFU(nm, afudrv)\
+#define RTE_PMD_REGISTER_AFU(nm, afudrv, idx)\
 static const char *afudrvinit_ ## nm ## _alias;\
 RTE_INIT(afudrvinitfn_ ##afudrv)\
 {\
@@ -154,7 +154,7 @@ RTE_INIT(afudrvinitfn_ ##afudrv)\
 	(afudrv).driver.alias = afudrvinit_ ## nm ## _alias;\
 	rte_ifpga_driver_register(&afudrv);\
 } \
-RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+RTE_PMD_EXPORT_NAME(nm, idx)
 
 #define RTE_PMD_REGISTER_AFU_ALIAS(nm, alias)\
 static const char *afudrvinit_ ## nm ## _alias = RTE_STR(alias)
diff --git a/drivers/bus/pci/bus_pci_driver.h b/drivers/bus/pci/bus_pci_driver.h
index 2cc1119072..d4cf2f5126 100644
--- a/drivers/bus/pci/bus_pci_driver.h
+++ b/drivers/bus/pci/bus_pci_driver.h
@@ -165,13 +165,13 @@ __rte_internal
 void rte_pci_register(struct rte_pci_driver *driver);
 
 /** Helper for PCI device registration from driver (eth, crypto) instance */
-#define RTE_PMD_REGISTER_PCI(nm, pci_drv) \
+#define RTE_PMD_REGISTER_PCI(nm, pci_drv, idx) \
 RTE_INIT(pciinitfn_ ##nm) \
 {\
 	(pci_drv).driver.name = RTE_STR(nm);\
 	rte_pci_register(&pci_drv); \
 } \
-RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+RTE_PMD_EXPORT_NAME(nm, idx)
 
 /**
  * Unregister a PCI driver.
diff --git a/drivers/bus/platform/bus_platform_driver.h b/drivers/bus/platform/bus_platform_driver.h
index a6f246f7c4..fb2d5e786c 100644
--- a/drivers/bus/platform/bus_platform_driver.h
+++ b/drivers/bus/platform/bus_platform_driver.h
@@ -130,7 +130,7 @@ struct rte_platform_driver {
 	container_of(ptr, const struct rte_platform_device, device)
 
 /** Helper for platform driver registration. */
-#define RTE_PMD_REGISTER_PLATFORM(nm, platform_drv) \
+#define RTE_PMD_REGISTER_PLATFORM(nm, platform_drv, idx) \
 static const char *pdrvinit_ ## nm ## _alias; \
 RTE_INIT(pdrvinitfn_ ##nm) \
 { \
@@ -138,7 +138,7 @@ RTE_INIT(pdrvinitfn_ ##nm) \
 	(platform_drv).driver.alias = pdrvinit_ ## nm ## _alias; \
 	rte_platform_register(&(platform_drv)); \
 } \
-RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+RTE_PMD_EXPORT_NAME(nm, idx)
 
 /** Helper for setting platform driver alias. */
 #define RTE_PMD_REGISTER_ALIAS(nm, alias) \
diff --git a/drivers/bus/uacce/bus_uacce_driver.h b/drivers/bus/uacce/bus_uacce_driver.h
index c8e177d44f..985ded2c90 100644
--- a/drivers/bus/uacce/bus_uacce_driver.h
+++ b/drivers/bus/uacce/bus_uacce_driver.h
@@ -239,13 +239,13 @@ void rte_uacce_unregister(struct rte_uacce_driver *driver);
 /**
  * Helper for UACCE device registration from driver instance.
  */
-#define RTE_PMD_REGISTER_UACCE(nm, uacce_drv) \
+#define RTE_PMD_REGISTER_UACCE(nm, uacce_drv, idx) \
 		RTE_INIT(uacceinitfn_ ##nm) \
 		{\
 			(uacce_drv).driver.name = RTE_STR(nm);\
 			rte_uacce_register(&uacce_drv); \
 		} \
-		RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+		RTE_PMD_EXPORT_NAME(nm, idx)
 
 #ifdef __cplusplus
 }
diff --git a/drivers/bus/vdev/bus_vdev_driver.h b/drivers/bus/vdev/bus_vdev_driver.h
index cba1fb5269..6062805b77 100644
--- a/drivers/bus/vdev/bus_vdev_driver.h
+++ b/drivers/bus/vdev/bus_vdev_driver.h
@@ -131,7 +131,7 @@ void rte_vdev_register(struct rte_vdev_driver *driver);
 __rte_internal
 void rte_vdev_unregister(struct rte_vdev_driver *driver);
 
-#define RTE_PMD_REGISTER_VDEV(nm, vdrv)\
+#define RTE_PMD_REGISTER_VDEV(nm, vdrv, idx)\
 static const char *vdrvinit_ ## nm ## _alias;\
 RTE_INIT(vdrvinitfn_ ##vdrv)\
 {\
@@ -139,7 +139,7 @@ RTE_INIT(vdrvinitfn_ ##vdrv)\
 	(vdrv).driver.alias = vdrvinit_ ## nm ## _alias;\
 	rte_vdev_register(&vdrv);\
 } \
-RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+RTE_PMD_EXPORT_NAME(nm, idx)
 
 #define RTE_PMD_REGISTER_ALIAS(nm, alias)\
 static const char *vdrvinit_ ## nm ## _alias = RTE_STR(alias)
diff --git a/drivers/bus/vmbus/bus_vmbus_driver.h b/drivers/bus/vmbus/bus_vmbus_driver.h
index bc394208de..cd0dcf44f7 100644
--- a/drivers/bus/vmbus/bus_vmbus_driver.h
+++ b/drivers/bus/vmbus/bus_vmbus_driver.h
@@ -91,13 +91,13 @@ __rte_internal
 void rte_vmbus_unregister(struct rte_vmbus_driver *driver);
 
 /** Helper for VMBUS device registration from driver instance */
-#define RTE_PMD_REGISTER_VMBUS(nm, vmbus_drv)		\
+#define RTE_PMD_REGISTER_VMBUS(nm, vmbus_drv, idx)	\
 	RTE_INIT(vmbusinitfn_ ##nm)			\
 	{						\
 		(vmbus_drv).driver.name = RTE_STR(nm);	\
 		rte_vmbus_register(&vmbus_drv);		\
 	}						\
-	RTE_PMD_EXPORT_NAME(nm, __COUNTER__)
+	RTE_PMD_EXPORT_NAME(nm, idx)
 
 #ifdef __cplusplus
 }
diff --git a/drivers/common/mlx5/mlx5_common.c b/drivers/common/mlx5/mlx5_common.c
index 4f25127582..ebe327a950 100644
--- a/drivers/common/mlx5/mlx5_common.c
+++ b/drivers/common/mlx5/mlx5_common.c
@@ -1452,4 +1452,4 @@ mlx5_devx_uar_prepare(struct mlx5_common_device *cdev, struct mlx5_uar *uar)
 	return 0;
 }
 
-RTE_PMD_EXPORT_NAME(mlx5_common_driver, __COUNTER__);
+RTE_PMD_EXPORT_NAME(mlx5_common_driver, __LINE__);
diff --git a/drivers/common/mlx5/mlx5_common_pci.c b/drivers/common/mlx5/mlx5_common_pci.c
index 819b799bb8..22de17ae67 100644
--- a/drivers/common/mlx5/mlx5_common_pci.c
+++ b/drivers/common/mlx5/mlx5_common_pci.c
@@ -245,4 +245,4 @@ RTE_FINI(mlx5_common_pci_finish)
 	}
 }
 
-RTE_PMD_EXPORT_NAME(mlx5_common_pci, __COUNTER__);
+RTE_PMD_EXPORT_NAME(mlx5_common_pci, __LINE__);
diff --git a/drivers/common/nitrox/nitrox_device.c b/drivers/common/nitrox/nitrox_device.c
index 74c7a859a4..1ca786c2f7 100644
--- a/drivers/common/nitrox/nitrox_device.c
+++ b/drivers/common/nitrox/nitrox_device.c
@@ -144,5 +144,5 @@ static struct rte_pci_driver nitrox_pmd = {
 	.remove         = nitrox_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(nitrox, nitrox_pmd);
+RTE_PMD_REGISTER_PCI(nitrox, nitrox_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(nitrox, pci_id_nitrox_map);
diff --git a/drivers/common/qat/qat_device.c b/drivers/common/qat/qat_device.c
index b582e3bf8b..0c3d7f2323 100644
--- a/drivers/common/qat/qat_device.c
+++ b/drivers/common/qat/qat_device.c
@@ -504,6 +504,6 @@ static struct rte_pci_driver rte_qat_pmd = {
 	.remove = qat_pci_remove
 };
 
-RTE_PMD_REGISTER_PCI(QAT_PCI_NAME, rte_qat_pmd);
+RTE_PMD_REGISTER_PCI(QAT_PCI_NAME, rte_qat_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(QAT_PCI_NAME, pci_id_qat_map);
 RTE_PMD_REGISTER_KMOD_DEP(QAT_PCI_NAME, "* igb_uio | uio_pci_generic | vfio-pci");
diff --git a/drivers/common/zsda/zsda_device.c b/drivers/common/zsda/zsda_device.c
index 8a89dc7fc9..e55b8c22f4 100644
--- a/drivers/common/zsda/zsda_device.c
+++ b/drivers/common/zsda/zsda_device.c
@@ -203,7 +203,7 @@ static struct rte_pci_driver rte_zsda_pmd = {
 	.probe = zsda_pci_probe,
 	.remove = zsda_pci_remove };
 
-RTE_PMD_REGISTER_PCI(ZSDA_PCI_NAME, rte_zsda_pmd);
+RTE_PMD_REGISTER_PCI(ZSDA_PCI_NAME, rte_zsda_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(ZSDA_PCI_NAME, pci_id_zsda_map);
 RTE_PMD_REGISTER_KMOD_DEP(ZSDA_PCI_NAME,
 			  "* igb_uio | uio_pci_generic | vfio-pci");
diff --git a/drivers/compress/isal/isal_compress_pmd.c b/drivers/compress/isal/isal_compress_pmd.c
index 0e783243a8..a4af7da56c 100644
--- a/drivers/compress/isal/isal_compress_pmd.c
+++ b/drivers/compress/isal/isal_compress_pmd.c
@@ -751,7 +751,7 @@ static struct rte_vdev_driver compdev_isal_pmd_drv = {
 	.remove = compdev_isal_remove_dev,
 };
 
-RTE_PMD_REGISTER_VDEV(COMPDEV_NAME_ISAL_PMD, compdev_isal_pmd_drv);
+RTE_PMD_REGISTER_VDEV(COMPDEV_NAME_ISAL_PMD, compdev_isal_pmd_drv, __LINE__);
 RTE_PMD_REGISTER_PARAM_STRING(COMPDEV_NAME_ISAL_PMD,
 	"socket_id=<int>");
 RTE_LOG_REGISTER_DEFAULT(isal_logtype_driver, INFO);
diff --git a/drivers/compress/mlx5/mlx5_compress.c b/drivers/compress/mlx5/mlx5_compress.c
index 82105bfebd..17017863a4 100644
--- a/drivers/compress/mlx5/mlx5_compress.c
+++ b/drivers/compress/mlx5/mlx5_compress.c
@@ -937,6 +937,6 @@ RTE_INIT(rte_mlx5_compress_init)
 }
 
 RTE_LOG_REGISTER_DEFAULT(mlx5_compress_logtype, NOTICE)
-RTE_PMD_EXPORT_NAME(MLX5_COMPRESS_DRIVER_NAME, __COUNTER__);
+RTE_PMD_EXPORT_NAME(MLX5_COMPRESS_DRIVER_NAME, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(MLX5_COMPRESS_DRIVER_NAME, mlx5_compress_pci_id_map);
 RTE_PMD_REGISTER_KMOD_DEP(MLX5_COMPRESS_DRIVER_NAME, "* ib_uverbs & mlx5_core & mlx5_ib");
diff --git a/drivers/compress/octeontx/otx_zip_pmd.c b/drivers/compress/octeontx/otx_zip_pmd.c
index c8f456b319..65c669ba3c 100644
--- a/drivers/compress/octeontx/otx_zip_pmd.c
+++ b/drivers/compress/octeontx/otx_zip_pmd.c
@@ -717,6 +717,6 @@ static struct rte_pci_driver octtx_zip_pmd = {
 	.remove      = zip_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(COMPRESSDEV_NAME_ZIP_PMD, octtx_zip_pmd);
+RTE_PMD_REGISTER_PCI(COMPRESSDEV_NAME_ZIP_PMD, octtx_zip_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(COMPRESSDEV_NAME_ZIP_PMD, pci_id_octtx_zipvf_table);
 RTE_LOG_REGISTER_DEFAULT(octtx_zip_logtype_driver, INFO);
diff --git a/drivers/compress/uadk/uadk_compress_pmd.c b/drivers/compress/uadk/uadk_compress_pmd.c
index 1f4c4cfd00..dd6fd53382 100644
--- a/drivers/compress/uadk/uadk_compress_pmd.c
+++ b/drivers/compress/uadk/uadk_compress_pmd.c
@@ -432,5 +432,5 @@ static struct rte_vdev_driver uadk_compress_pmd = {
 };
 
 #define UADK_COMPRESS_DRIVER_NAME compress_uadk
-RTE_PMD_REGISTER_VDEV(UADK_COMPRESS_DRIVER_NAME, uadk_compress_pmd);
+RTE_PMD_REGISTER_VDEV(UADK_COMPRESS_DRIVER_NAME, uadk_compress_pmd, __LINE__);
 RTE_LOG_REGISTER_DEFAULT(uadk_compress_logtype, INFO);
diff --git a/drivers/compress/zlib/zlib_pmd.c b/drivers/compress/zlib/zlib_pmd.c
index 92e808e78c..8e05cabe4a 100644
--- a/drivers/compress/zlib/zlib_pmd.c
+++ b/drivers/compress/zlib/zlib_pmd.c
@@ -425,5 +425,5 @@ static struct rte_vdev_driver zlib_pmd_drv = {
 	.remove = zlib_remove
 };
 
-RTE_PMD_REGISTER_VDEV(COMPRESSDEV_NAME_ZLIB_PMD, zlib_pmd_drv);
+RTE_PMD_REGISTER_VDEV(COMPRESSDEV_NAME_ZLIB_PMD, zlib_pmd_drv, __LINE__);
 RTE_LOG_REGISTER_DEFAULT(zlib_logtype_driver, INFO);
diff --git a/drivers/crypto/armv8/rte_armv8_pmd.c b/drivers/crypto/armv8/rte_armv8_pmd.c
index 320e2d4b3b..ada9ddf1fe 100644
--- a/drivers/crypto/armv8/rte_armv8_pmd.c
+++ b/drivers/crypto/armv8/rte_armv8_pmd.c
@@ -853,7 +853,7 @@ static struct cryptodev_driver armv8_crypto_drv;
 
 RTE_LOG_REGISTER_DEFAULT(crypto_armv8_log_type, ERR);
 
-RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_ARMV8_PMD, armv8_crypto_pmd_drv);
+RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_ARMV8_PMD, armv8_crypto_pmd_drv, __LINE__);
 RTE_PMD_REGISTER_ALIAS(CRYPTODEV_NAME_ARMV8_PMD, cryptodev_armv8_pmd);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_ARMV8_PMD,
 	"max_nb_queue_pairs=<int> "
diff --git a/drivers/crypto/bcmfs/bcmfs_device.c b/drivers/crypto/bcmfs/bcmfs_device.c
index 46522970d5..def4be64cf 100644
--- a/drivers/crypto/bcmfs/bcmfs_device.c
+++ b/drivers/crypto/bcmfs/bcmfs_device.c
@@ -329,5 +329,4 @@ static struct rte_vdev_driver rte_bcmfs_pmd = {
 	.remove = bcmfs_vdev_remove
 };
 
-RTE_PMD_REGISTER_VDEV(bcmfs_pmd,
-		      rte_bcmfs_pmd);
+RTE_PMD_REGISTER_VDEV(bcmfs_pmd, rte_bcmfs_pmd, __LINE__);
diff --git a/drivers/crypto/caam_jr/caam_jr.c b/drivers/crypto/caam_jr/caam_jr.c
index a57dc56b80..e6971605fe 100644
--- a/drivers/crypto/caam_jr/caam_jr.c
+++ b/drivers/crypto/caam_jr/caam_jr.c
@@ -2451,7 +2451,7 @@ static struct rte_vdev_driver cryptodev_caam_jr_drv = {
 
 static struct cryptodev_driver caam_jr_crypto_drv;
 
-RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_CAAM_JR_PMD, cryptodev_caam_jr_drv);
+RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_CAAM_JR_PMD, cryptodev_caam_jr_drv, __LINE__);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_CAAM_JR_PMD,
 	"max_nb_queue_pairs=<int>"
 	"socket_id=<int>");
diff --git a/drivers/crypto/ccp/rte_ccp_pmd.c b/drivers/crypto/ccp/rte_ccp_pmd.c
index 700e141667..13d84f84b4 100644
--- a/drivers/crypto/ccp/rte_ccp_pmd.c
+++ b/drivers/crypto/ccp/rte_ccp_pmd.c
@@ -312,7 +312,7 @@ static struct rte_pci_driver cryptodev_ccp_pmd_drv = {
 
 static struct cryptodev_driver ccp_crypto_drv;
 
-RTE_PMD_REGISTER_PCI(CRYPTODEV_NAME_CCP_PMD, cryptodev_ccp_pmd_drv);
+RTE_PMD_REGISTER_PCI(CRYPTODEV_NAME_CCP_PMD, cryptodev_ccp_pmd_drv, __LINE__);
 RTE_PMD_REGISTER_KMOD_DEP(CRYPTODEV_NAME_CCP_PMD, "* igb_uio | uio_pci_generic | vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_CCP_PMD,
 	"max_nb_queue_pairs=<int> "
diff --git a/drivers/crypto/cnxk/cn10k_cryptodev.c b/drivers/crypto/cnxk/cn10k_cryptodev.c
index 70bef13cda..8e61fb5fd5 100644
--- a/drivers/crypto/cnxk/cn10k_cryptodev.c
+++ b/drivers/crypto/cnxk/cn10k_cryptodev.c
@@ -158,7 +158,7 @@ static struct rte_pci_driver cn10k_cryptodev_pmd = {
 
 static struct cryptodev_driver cn10k_cryptodev_drv;
 
-RTE_PMD_REGISTER_PCI(CRYPTODEV_NAME_CN10K_PMD, cn10k_cryptodev_pmd);
+RTE_PMD_REGISTER_PCI(CRYPTODEV_NAME_CN10K_PMD, cn10k_cryptodev_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(CRYPTODEV_NAME_CN10K_PMD, pci_id_cpt_table);
 RTE_PMD_REGISTER_KMOD_DEP(CRYPTODEV_NAME_CN10K_PMD, "vfio-pci");
 RTE_PMD_REGISTER_CRYPTO_DRIVER(cn10k_cryptodev_drv, cn10k_cryptodev_pmd.driver,
diff --git a/drivers/crypto/cnxk/cn9k_cryptodev.c b/drivers/crypto/cnxk/cn9k_cryptodev.c
index 818458bd6f..0873031388 100644
--- a/drivers/crypto/cnxk/cn9k_cryptodev.c
+++ b/drivers/crypto/cnxk/cn9k_cryptodev.c
@@ -159,7 +159,7 @@ static struct rte_pci_driver cn9k_cryptodev_pmd = {
 
 static struct cryptodev_driver cn9k_cryptodev_drv;
 
-RTE_PMD_REGISTER_PCI(CRYPTODEV_NAME_CN9K_PMD, cn9k_cryptodev_pmd);
+RTE_PMD_REGISTER_PCI(CRYPTODEV_NAME_CN9K_PMD, cn9k_cryptodev_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(CRYPTODEV_NAME_CN9K_PMD, pci_id_cpt_table);
 RTE_PMD_REGISTER_KMOD_DEP(CRYPTODEV_NAME_CN9K_PMD, "vfio-pci");
 RTE_PMD_REGISTER_CRYPTO_DRIVER(cn9k_cryptodev_drv, cn9k_cryptodev_pmd.driver,
diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index 0ccadecff4..c2c6fb3e3d 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -4492,7 +4492,7 @@ static struct rte_dpaa2_driver rte_dpaa2_sec_driver = {
 
 static struct cryptodev_driver dpaa2_sec_crypto_drv;
 
-RTE_PMD_REGISTER_DPAA2(CRYPTODEV_NAME_DPAA2_SEC_PMD, rte_dpaa2_sec_driver);
+RTE_PMD_REGISTER_DPAA2(CRYPTODEV_NAME_DPAA2_SEC_PMD, rte_dpaa2_sec_driver, __LINE__);
 RTE_PMD_REGISTER_CRYPTO_DRIVER(dpaa2_sec_crypto_drv,
 		rte_dpaa2_sec_driver.driver, cryptodev_driver_id);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_DPAA2_SEC_PMD,
diff --git a/drivers/crypto/dpaa_sec/dpaa_sec.c b/drivers/crypto/dpaa_sec/dpaa_sec.c
index bcea4ff3ab..670b04109e 100644
--- a/drivers/crypto/dpaa_sec/dpaa_sec.c
+++ b/drivers/crypto/dpaa_sec/dpaa_sec.c
@@ -3877,7 +3877,7 @@ static struct rte_dpaa_driver rte_dpaa_sec_driver = {
 
 static struct cryptodev_driver dpaa_sec_crypto_drv;
 
-RTE_PMD_REGISTER_DPAA(CRYPTODEV_NAME_DPAA_SEC_PMD, rte_dpaa_sec_driver);
+RTE_PMD_REGISTER_DPAA(CRYPTODEV_NAME_DPAA_SEC_PMD, rte_dpaa_sec_driver, __LINE__);
 RTE_PMD_REGISTER_CRYPTO_DRIVER(dpaa_sec_crypto_drv, rte_dpaa_sec_driver.driver,
 		dpaa_cryptodev_driver_id);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_DPAA_SEC_PMD,
diff --git a/drivers/crypto/ionic/ionic_crypto_vdev.c b/drivers/crypto/ionic/ionic_crypto_vdev.c
index d15acf660a..f0167b6e65 100644
--- a/drivers/crypto/ionic/ionic_crypto_vdev.c
+++ b/drivers/crypto/ionic/ionic_crypto_vdev.c
@@ -123,6 +123,6 @@ static struct rte_vdev_driver rte_vdev_iocpt_pmd = {
 
 static struct cryptodev_driver rte_vdev_iocpt_drv;
 
-RTE_PMD_REGISTER_VDEV(crypto_ionic, rte_vdev_iocpt_pmd);
+RTE_PMD_REGISTER_VDEV(crypto_ionic, rte_vdev_iocpt_pmd, __LINE__);
 RTE_PMD_REGISTER_CRYPTO_DRIVER(rte_vdev_iocpt_drv, rte_vdev_iocpt_pmd.driver,
 		iocpt_vdev_driver_id);
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c b/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
index 8d40bd9169..358789b392 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_gcm.c
@@ -785,8 +785,7 @@ static struct rte_vdev_driver cryptodev_aesni_gcm_pmd_drv = {
 
 static struct cryptodev_driver aesni_gcm_crypto_drv;
 
-RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_AESNI_GCM_PMD,
-		      cryptodev_aesni_gcm_pmd_drv);
+RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_AESNI_GCM_PMD, cryptodev_aesni_gcm_pmd_drv, __LINE__);
 RTE_PMD_REGISTER_ALIAS(CRYPTODEV_NAME_AESNI_GCM_PMD, cryptodev_aesni_gcm_pmd);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_AESNI_GCM_PMD,
 			      "max_nb_queue_pairs=<int> socket_id=<int>");
diff --git a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
index a6c3f09b6f..800c02d4c5 100644
--- a/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
+++ b/drivers/crypto/ipsec_mb/pmd_aesni_mb.c
@@ -2500,8 +2500,7 @@ static struct rte_vdev_driver cryptodev_aesni_mb_pmd_drv = {
 
 static struct cryptodev_driver aesni_mb_crypto_drv;
 
-RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_AESNI_MB_PMD,
-	cryptodev_aesni_mb_pmd_drv);
+RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_AESNI_MB_PMD, cryptodev_aesni_mb_pmd_drv, __LINE__);
 RTE_PMD_REGISTER_ALIAS(CRYPTODEV_NAME_AESNI_MB_PMD, cryptodev_aesni_mb_pmd);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_AESNI_MB_PMD,
 			"max_nb_queue_pairs=<int> socket_id=<int>");
diff --git a/drivers/crypto/ipsec_mb/pmd_chacha_poly.c b/drivers/crypto/ipsec_mb/pmd_chacha_poly.c
index 24488d4921..36ca99499d 100644
--- a/drivers/crypto/ipsec_mb/pmd_chacha_poly.c
+++ b/drivers/crypto/ipsec_mb/pmd_chacha_poly.c
@@ -41,7 +41,8 @@ static struct rte_vdev_driver cryptodev_chacha20_poly1305_pmd_drv = {
 static struct cryptodev_driver chacha20_poly1305_crypto_drv;
 
 RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_CHACHA20_POLY1305_PMD,
-					cryptodev_chacha20_poly1305_pmd_drv);
+		      cryptodev_chacha20_poly1305_pmd_drv,
+		      __LINE__);
 RTE_PMD_REGISTER_ALIAS(CRYPTODEV_NAME_CHACHA20_POLY1305_PMD,
 					cryptodev_chacha20_poly1305_pmd);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_CHACHA20_POLY1305_PMD,
diff --git a/drivers/crypto/ipsec_mb/pmd_kasumi.c b/drivers/crypto/ipsec_mb/pmd_kasumi.c
index f83539232d..622dcfdf86 100644
--- a/drivers/crypto/ipsec_mb/pmd_kasumi.c
+++ b/drivers/crypto/ipsec_mb/pmd_kasumi.c
@@ -46,7 +46,7 @@ static struct rte_vdev_driver cryptodev_kasumi_pmd_drv = {
 
 static struct cryptodev_driver kasumi_crypto_drv;
 
-RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_KASUMI_PMD, cryptodev_kasumi_pmd_drv);
+RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_KASUMI_PMD, cryptodev_kasumi_pmd_drv, __LINE__);
 RTE_PMD_REGISTER_ALIAS(CRYPTODEV_NAME_KASUMI_PMD, cryptodev_kasumi_pmd);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_KASUMI_PMD,
 			       "max_nb_queue_pairs=<int> socket_id=<int>");
diff --git a/drivers/crypto/ipsec_mb/pmd_snow3g.c b/drivers/crypto/ipsec_mb/pmd_snow3g.c
index 65f0e5c568..ac9e472f4b 100644
--- a/drivers/crypto/ipsec_mb/pmd_snow3g.c
+++ b/drivers/crypto/ipsec_mb/pmd_snow3g.c
@@ -571,7 +571,7 @@ static struct rte_vdev_driver cryptodev_snow3g_pmd_drv = {
 
 static struct cryptodev_driver snow3g_crypto_drv;
 
-RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_SNOW3G_PMD, cryptodev_snow3g_pmd_drv);
+RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_SNOW3G_PMD, cryptodev_snow3g_pmd_drv, __LINE__);
 RTE_PMD_REGISTER_ALIAS(CRYPTODEV_NAME_SNOW3G_PMD, cryptodev_snow3g_pmd);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_SNOW3G_PMD,
 			       "max_nb_queue_pairs=<int> socket_id=<int>");
diff --git a/drivers/crypto/ipsec_mb/pmd_zuc.c b/drivers/crypto/ipsec_mb/pmd_zuc.c
index 44781be1d1..92404104b6 100644
--- a/drivers/crypto/ipsec_mb/pmd_zuc.c
+++ b/drivers/crypto/ipsec_mb/pmd_zuc.c
@@ -376,7 +376,7 @@ static struct rte_vdev_driver cryptodev_zuc_pmd_drv = {
 
 static struct cryptodev_driver zuc_crypto_drv;
 
-RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_ZUC_PMD, cryptodev_zuc_pmd_drv);
+RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_ZUC_PMD, cryptodev_zuc_pmd_drv, __LINE__);
 RTE_PMD_REGISTER_ALIAS(CRYPTODEV_NAME_ZUC_PMD, cryptodev_zuc_pmd);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_ZUC_PMD,
 	"max_nb_queue_pairs=<int> socket_id=<int>");
diff --git a/drivers/crypto/mlx5/mlx5_crypto.c b/drivers/crypto/mlx5/mlx5_crypto.c
index 2319c6920d..4fb7060bd0 100644
--- a/drivers/crypto/mlx5/mlx5_crypto.c
+++ b/drivers/crypto/mlx5/mlx5_crypto.c
@@ -514,6 +514,6 @@ RTE_PMD_REGISTER_CRYPTO_DRIVER(mlx5_cryptodev_driver, mlx5_drv,
 			       mlx5_crypto_driver_id);
 
 RTE_LOG_REGISTER_DEFAULT(mlx5_crypto_logtype, NOTICE)
-RTE_PMD_EXPORT_NAME(MLX5_CRYPTO_DRIVER_NAME, __COUNTER__);
+RTE_PMD_EXPORT_NAME(MLX5_CRYPTO_DRIVER_NAME, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(MLX5_CRYPTO_DRIVER_NAME, mlx5_crypto_pci_id_map);
 RTE_PMD_REGISTER_KMOD_DEP(MLX5_CRYPTO_DRIVER_NAME, "* ib_uverbs & mlx5_core & mlx5_ib");
diff --git a/drivers/crypto/mvsam/rte_mrvl_pmd.c b/drivers/crypto/mvsam/rte_mrvl_pmd.c
index a824719fb0..80430bee19 100644
--- a/drivers/crypto/mvsam/rte_mrvl_pmd.c
+++ b/drivers/crypto/mvsam/rte_mrvl_pmd.c
@@ -1281,7 +1281,7 @@ static struct rte_vdev_driver cryptodev_mrvl_pmd_drv = {
 static struct cryptodev_driver mrvl_crypto_drv;
 
 /* Register the driver in constructor. */
-RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_MRVL_PMD, cryptodev_mrvl_pmd_drv);
+RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_MRVL_PMD, cryptodev_mrvl_pmd_drv, __LINE__);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_MRVL_PMD,
 	"max_nb_queue_pairs=<int> "
 	"max_nb_sessions=<int> "
diff --git a/drivers/crypto/null/null_crypto_pmd.c b/drivers/crypto/null/null_crypto_pmd.c
index 8458306556..583d934461 100644
--- a/drivers/crypto/null/null_crypto_pmd.c
+++ b/drivers/crypto/null/null_crypto_pmd.c
@@ -233,7 +233,7 @@ static struct rte_vdev_driver cryptodev_null_pmd_drv = {
 
 static struct cryptodev_driver null_crypto_drv;
 
-RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_NULL_PMD, cryptodev_null_pmd_drv);
+RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_NULL_PMD, cryptodev_null_pmd_drv, __LINE__);
 RTE_PMD_REGISTER_ALIAS(CRYPTODEV_NAME_NULL_PMD, cryptodev_null_pmd);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_NULL_PMD,
 	"max_nb_queue_pairs=<int> "
diff --git a/drivers/crypto/octeontx/otx_cryptodev.c b/drivers/crypto/octeontx/otx_cryptodev.c
index b5ab937c3a..87e3d51893 100644
--- a/drivers/crypto/octeontx/otx_cryptodev.c
+++ b/drivers/crypto/octeontx/otx_cryptodev.c
@@ -114,7 +114,7 @@ static struct rte_pci_driver otx_cryptodev_pmd = {
 
 static struct cryptodev_driver otx_cryptodev_drv;
 
-RTE_PMD_REGISTER_PCI(CRYPTODEV_NAME_OCTEONTX_PMD, otx_cryptodev_pmd);
+RTE_PMD_REGISTER_PCI(CRYPTODEV_NAME_OCTEONTX_PMD, otx_cryptodev_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(CRYPTODEV_NAME_OCTEONTX_PMD, pci_id_cpt_table);
 RTE_PMD_REGISTER_KMOD_DEP(CRYPTODEV_NAME_OCTEONTX_PMD, "vfio-pci");
 RTE_PMD_REGISTER_CRYPTO_DRIVER(otx_cryptodev_drv, otx_cryptodev_pmd.driver,
diff --git a/drivers/crypto/openssl/rte_openssl_pmd.c b/drivers/crypto/openssl/rte_openssl_pmd.c
index 5bfad92b7c..36ae98d82f 100644
--- a/drivers/crypto/openssl/rte_openssl_pmd.c
+++ b/drivers/crypto/openssl/rte_openssl_pmd.c
@@ -3709,8 +3709,7 @@ static struct rte_vdev_driver cryptodev_openssl_pmd_drv = {
 
 static struct cryptodev_driver openssl_crypto_drv;
 
-RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_OPENSSL_PMD,
-	cryptodev_openssl_pmd_drv);
+RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_OPENSSL_PMD, cryptodev_openssl_pmd_drv, __LINE__);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_OPENSSL_PMD,
 	"max_nb_queue_pairs=<int> "
 	"socket_id=<int>");
diff --git a/drivers/crypto/scheduler/scheduler_pmd.c b/drivers/crypto/scheduler/scheduler_pmd.c
index 95ce893f05..4650c4180a 100644
--- a/drivers/crypto/scheduler/scheduler_pmd.c
+++ b/drivers/crypto/scheduler/scheduler_pmd.c
@@ -618,8 +618,7 @@ static struct rte_vdev_driver cryptodev_scheduler_pmd_drv = {
 
 static struct cryptodev_driver scheduler_crypto_drv;
 
-RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_SCHEDULER_PMD,
-	cryptodev_scheduler_pmd_drv);
+RTE_PMD_REGISTER_VDEV(CRYPTODEV_NAME_SCHEDULER_PMD, cryptodev_scheduler_pmd_drv, __LINE__);
 RTE_PMD_REGISTER_PARAM_STRING(CRYPTODEV_NAME_SCHEDULER_PMD,
 	"max_nb_queue_pairs=<int> "
 	"socket_id=<int> "
diff --git a/drivers/crypto/uadk/uadk_crypto_pmd.c b/drivers/crypto/uadk/uadk_crypto_pmd.c
index e4b1a32398..3e389261da 100644
--- a/drivers/crypto/uadk/uadk_crypto_pmd.c
+++ b/drivers/crypto/uadk/uadk_crypto_pmd.c
@@ -1087,7 +1087,7 @@ static struct rte_vdev_driver uadk_crypto_pmd = {
 static struct cryptodev_driver uadk_crypto_drv;
 
 #define UADK_CRYPTO_DRIVER_NAME crypto_uadk
-RTE_PMD_REGISTER_VDEV(UADK_CRYPTO_DRIVER_NAME, uadk_crypto_pmd);
+RTE_PMD_REGISTER_VDEV(UADK_CRYPTO_DRIVER_NAME, uadk_crypto_pmd, __LINE__);
 RTE_PMD_REGISTER_CRYPTO_DRIVER(uadk_crypto_drv, uadk_crypto_pmd.driver,
 			       uadk_cryptodev_driver_id);
 RTE_PMD_REGISTER_PARAM_STRING(UADK_CRYPTO_DRIVER_NAME,
diff --git a/drivers/crypto/virtio/virtio_cryptodev.c b/drivers/crypto/virtio/virtio_cryptodev.c
index bc737f1e68..8a89d0135b 100644
--- a/drivers/crypto/virtio/virtio_cryptodev.c
+++ b/drivers/crypto/virtio/virtio_cryptodev.c
@@ -1718,7 +1718,7 @@ static struct rte_pci_driver rte_virtio_crypto_driver = {
 
 static struct cryptodev_driver virtio_crypto_drv;
 
-RTE_PMD_REGISTER_PCI(CRYPTODEV_NAME_VIRTIO_PMD, rte_virtio_crypto_driver);
+RTE_PMD_REGISTER_PCI(CRYPTODEV_NAME_VIRTIO_PMD, rte_virtio_crypto_driver, __LINE__);
 RTE_PMD_REGISTER_CRYPTO_DRIVER(virtio_crypto_drv,
 	rte_virtio_crypto_driver.driver,
 	cryptodev_virtio_driver_id);
diff --git a/drivers/crypto/virtio/virtio_user_cryptodev.c b/drivers/crypto/virtio/virtio_user_cryptodev.c
index 992e8fb43b..da68e2af28 100644
--- a/drivers/crypto/virtio/virtio_user_cryptodev.c
+++ b/drivers/crypto/virtio/virtio_user_cryptodev.c
@@ -565,7 +565,7 @@ static struct cryptodev_driver virtio_crypto_drv;
 
 uint8_t cryptodev_virtio_user_driver_id;
 
-RTE_PMD_REGISTER_VDEV(crypto_virtio_user, virtio_user_driver);
+RTE_PMD_REGISTER_VDEV(crypto_virtio_user, virtio_user_driver, __LINE__);
 RTE_PMD_REGISTER_CRYPTO_DRIVER(virtio_crypto_drv,
 	virtio_user_driver.driver,
 	cryptodev_virtio_user_driver_id);
diff --git a/drivers/dma/cnxk/cnxk_dmadev.c b/drivers/dma/cnxk/cnxk_dmadev.c
index 90bb69011f..9b46bccf57 100644
--- a/drivers/dma/cnxk/cnxk_dmadev.c
+++ b/drivers/dma/cnxk/cnxk_dmadev.c
@@ -628,6 +628,6 @@ static struct rte_pci_driver cnxk_dmadev = {
 	.remove = cnxk_dmadev_remove,
 };
 
-RTE_PMD_REGISTER_PCI(cnxk_dmadev_pci_driver, cnxk_dmadev);
+RTE_PMD_REGISTER_PCI(cnxk_dmadev_pci_driver, cnxk_dmadev, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(cnxk_dmadev_pci_driver, cnxk_dma_pci_map);
 RTE_PMD_REGISTER_KMOD_DEP(cnxk_dmadev_pci_driver, "vfio-pci");
diff --git a/drivers/dma/dpaa/dpaa_qdma.c b/drivers/dma/dpaa/dpaa_qdma.c
index a541398e48..5e47455699 100644
--- a/drivers/dma/dpaa/dpaa_qdma.c
+++ b/drivers/dma/dpaa/dpaa_qdma.c
@@ -1475,6 +1475,6 @@ static struct rte_dpaa_driver rte_dpaa_qdma_pmd = {
 	.remove = dpaa_qdma_remove,
 };
 
-RTE_PMD_REGISTER_DPAA(dpaa_qdma, rte_dpaa_qdma_pmd);
+RTE_PMD_REGISTER_DPAA(dpaa_qdma, rte_dpaa_qdma_pmd, __LINE__);
 RTE_PMD_REGISTER_PARAM_STRING(dpaa_qdma, DPAA_DMA_ERROR_CHECK "=<int>");
 RTE_LOG_REGISTER_DEFAULT(dpaa_qdma_logtype, INFO);
diff --git a/drivers/dma/dpaa2/dpaa2_qdma.c b/drivers/dma/dpaa2/dpaa2_qdma.c
index 3c9a7b5485..78c74d6855 100644
--- a/drivers/dma/dpaa2/dpaa2_qdma.c
+++ b/drivers/dma/dpaa2/dpaa2_qdma.c
@@ -1752,7 +1752,7 @@ static struct rte_dpaa2_driver rte_dpaa2_qdma_pmd = {
 	.remove = dpaa2_qdma_remove,
 };
 
-RTE_PMD_REGISTER_DPAA2(dpaa2_qdma, rte_dpaa2_qdma_pmd);
+RTE_PMD_REGISTER_DPAA2(dpaa2_qdma, rte_dpaa2_qdma_pmd, __LINE__);
 RTE_PMD_REGISTER_PARAM_STRING(dpaa2_qdma,
 	DPAA2_QDMA_FLE_PRE_POPULATE "=<int>"
 	DPAA2_QDMA_DESC_DEBUG"=<int>"
diff --git a/drivers/dma/hisilicon/hisi_dmadev.c b/drivers/dma/hisilicon/hisi_dmadev.c
index fdd2fa225f..724912dc08 100644
--- a/drivers/dma/hisilicon/hisi_dmadev.c
+++ b/drivers/dma/hisilicon/hisi_dmadev.c
@@ -964,6 +964,6 @@ static struct rte_pci_driver hisi_dma_pmd_drv = {
 	.remove    = hisi_dma_remove,
 };
 
-RTE_PMD_REGISTER_PCI(dma_hisilicon, hisi_dma_pmd_drv);
+RTE_PMD_REGISTER_PCI(dma_hisilicon, hisi_dma_pmd_drv, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(dma_hisilicon, pci_id_hisi_dma_map);
 RTE_PMD_REGISTER_KMOD_DEP(dma_hisilicon, "vfio-pci");
diff --git a/drivers/dma/idxd/idxd_pci.c b/drivers/dma/idxd/idxd_pci.c
index 214f6f22d5..0f7a4fffa1 100644
--- a/drivers/dma/idxd/idxd_pci.c
+++ b/drivers/dma/idxd/idxd_pci.c
@@ -453,7 +453,7 @@ struct rte_pci_driver idxd_pmd_drv_pci = {
 	.remove = idxd_dmadev_remove_pci,
 };
 
-RTE_PMD_REGISTER_PCI(IDXD_PMD_DMADEV_NAME_PCI, idxd_pmd_drv_pci);
+RTE_PMD_REGISTER_PCI(IDXD_PMD_DMADEV_NAME_PCI, idxd_pmd_drv_pci, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(IDXD_PMD_DMADEV_NAME_PCI, pci_id_idxd_map);
 RTE_PMD_REGISTER_KMOD_DEP(IDXD_PMD_DMADEV_NAME_PCI, "vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(dmadev_idxd_pci, "max_queues=0");
diff --git a/drivers/dma/ioat/ioat_dmadev.c b/drivers/dma/ioat/ioat_dmadev.c
index 8b7ff5652f..7461be9663 100644
--- a/drivers/dma/ioat/ioat_dmadev.c
+++ b/drivers/dma/ioat/ioat_dmadev.c
@@ -762,6 +762,6 @@ static struct rte_pci_driver ioat_pmd_drv = {
 	.remove = ioat_dmadev_remove,
 };
 
-RTE_PMD_REGISTER_PCI(IOAT_PMD_NAME, ioat_pmd_drv);
+RTE_PMD_REGISTER_PCI(IOAT_PMD_NAME, ioat_pmd_drv, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(IOAT_PMD_NAME, pci_id_ioat_map);
 RTE_PMD_REGISTER_KMOD_DEP(IOAT_PMD_NAME, "* igb_uio | uio_pci_generic | vfio-pci");
diff --git a/drivers/dma/odm/odm_dmadev.c b/drivers/dma/odm/odm_dmadev.c
index a2f4ed9a8e..2b07706e81 100644
--- a/drivers/dma/odm/odm_dmadev.c
+++ b/drivers/dma/odm/odm_dmadev.c
@@ -711,7 +711,7 @@ static struct rte_pci_driver odm_dmadev = {
 	.remove = odm_dmadev_remove,
 };
 
-RTE_PMD_REGISTER_PCI(PCI_DRIVER_NAME, odm_dmadev);
+RTE_PMD_REGISTER_PCI(PCI_DRIVER_NAME, odm_dmadev, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(PCI_DRIVER_NAME, odm_dma_pci_map);
 RTE_PMD_REGISTER_KMOD_DEP(PCI_DRIVER_NAME, "vfio-pci");
 RTE_LOG_REGISTER_DEFAULT(odm_logtype, NOTICE);
diff --git a/drivers/dma/skeleton/skeleton_dmadev.c b/drivers/dma/skeleton/skeleton_dmadev.c
index e287802eb9..a1108df5de 100644
--- a/drivers/dma/skeleton/skeleton_dmadev.c
+++ b/drivers/dma/skeleton/skeleton_dmadev.c
@@ -729,6 +729,6 @@ static struct rte_vdev_driver skeldma_pmd_drv = {
 	.drv_flags = RTE_VDEV_DRV_NEED_IOVA_AS_VA,
 };
 
-RTE_PMD_REGISTER_VDEV(dma_skeleton, skeldma_pmd_drv);
+RTE_PMD_REGISTER_VDEV(dma_skeleton, skeldma_pmd_drv, __LINE__);
 RTE_PMD_REGISTER_PARAM_STRING(dma_skeleton,
 		SKELDMA_ARG_LCORE "=<uint16> ");
diff --git a/drivers/event/cnxk/cn10k_eventdev.c b/drivers/event/cnxk/cn10k_eventdev.c
index 3832eb7e00..54bb4cfbbd 100644
--- a/drivers/event/cnxk/cn10k_eventdev.c
+++ b/drivers/event/cnxk/cn10k_eventdev.c
@@ -1173,7 +1173,7 @@ static struct rte_pci_driver cn10k_pci_sso = {
 	.remove = cnxk_sso_remove,
 };
 
-RTE_PMD_REGISTER_PCI(event_cn10k, cn10k_pci_sso);
+RTE_PMD_REGISTER_PCI(event_cn10k, cn10k_pci_sso, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(event_cn10k, cn10k_pci_sso_map);
 RTE_PMD_REGISTER_KMOD_DEP(event_cn10k, "vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(event_cn10k, CNXK_SSO_XAE_CNT "=<int>"
diff --git a/drivers/event/cnxk/cn20k_eventdev.c b/drivers/event/cnxk/cn20k_eventdev.c
index 0688cf97e5..cab4947eb5 100644
--- a/drivers/event/cnxk/cn20k_eventdev.c
+++ b/drivers/event/cnxk/cn20k_eventdev.c
@@ -1151,7 +1151,7 @@ static struct rte_pci_driver cn20k_pci_sso = {
 	.remove = cnxk_sso_remove,
 };
 
-RTE_PMD_REGISTER_PCI(event_cn20k, cn20k_pci_sso);
+RTE_PMD_REGISTER_PCI(event_cn20k, cn20k_pci_sso, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(event_cn20k, cn20k_pci_sso_map);
 RTE_PMD_REGISTER_KMOD_DEP(event_cn20k, "vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(event_cn20k,
diff --git a/drivers/event/cnxk/cn9k_eventdev.c b/drivers/event/cnxk/cn9k_eventdev.c
index 5f24366770..5d782d2b38 100644
--- a/drivers/event/cnxk/cn9k_eventdev.c
+++ b/drivers/event/cnxk/cn9k_eventdev.c
@@ -1267,7 +1267,7 @@ static struct rte_pci_driver cn9k_pci_sso = {
 	.remove = cnxk_sso_remove,
 };
 
-RTE_PMD_REGISTER_PCI(event_cn9k, cn9k_pci_sso);
+RTE_PMD_REGISTER_PCI(event_cn9k, cn9k_pci_sso, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(event_cn9k, cn9k_pci_sso_map);
 RTE_PMD_REGISTER_KMOD_DEP(event_cn9k, "vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(event_cn9k, CNXK_SSO_XAE_CNT "=<int>"
diff --git a/drivers/event/dlb2/pf/dlb2_pf.c b/drivers/event/dlb2/pf/dlb2_pf.c
index ed4e6e424c..086262a394 100644
--- a/drivers/event/dlb2/pf/dlb2_pf.c
+++ b/drivers/event/dlb2/pf/dlb2_pf.c
@@ -881,8 +881,8 @@ static struct rte_pci_driver pci_eventdev_dlb2_5_pmd = {
 	.remove = event_dlb2_5_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(event_dlb2_pf, pci_eventdev_dlb2_pmd);
+RTE_PMD_REGISTER_PCI(event_dlb2_pf, pci_eventdev_dlb2_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(event_dlb2_pf, pci_id_dlb2_map);
 
-RTE_PMD_REGISTER_PCI(event_dlb2_5_pf, pci_eventdev_dlb2_5_pmd);
+RTE_PMD_REGISTER_PCI(event_dlb2_5_pf, pci_eventdev_dlb2_5_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(event_dlb2_5_pf, pci_id_dlb2_5_map);
diff --git a/drivers/event/dpaa/dpaa_eventdev.c b/drivers/event/dpaa/dpaa_eventdev.c
index 400e0ecd1c..5f2a063133 100644
--- a/drivers/event/dpaa/dpaa_eventdev.c
+++ b/drivers/event/dpaa/dpaa_eventdev.c
@@ -1050,6 +1050,6 @@ static struct rte_vdev_driver vdev_eventdev_dpaa_pmd = {
 	.remove = dpaa_event_dev_remove
 };
 
-RTE_PMD_REGISTER_VDEV(EVENTDEV_NAME_DPAA_PMD, vdev_eventdev_dpaa_pmd);
+RTE_PMD_REGISTER_VDEV(EVENTDEV_NAME_DPAA_PMD, vdev_eventdev_dpaa_pmd, __LINE__);
 RTE_PMD_REGISTER_PARAM_STRING(EVENTDEV_NAME_DPAA_PMD,
 		DISABLE_INTR_MODE "=<int>");
diff --git a/drivers/event/dpaa2/dpaa2_eventdev.c b/drivers/event/dpaa2/dpaa2_eventdev.c
index 6c8ed3ff6b..7d1bd52bed 100644
--- a/drivers/event/dpaa2/dpaa2_eventdev.c
+++ b/drivers/event/dpaa2/dpaa2_eventdev.c
@@ -1198,5 +1198,5 @@ static struct rte_vdev_driver vdev_eventdev_dpaa2_pmd = {
 	.remove = dpaa2_eventdev_remove
 };
 
-RTE_PMD_REGISTER_VDEV(EVENTDEV_NAME_DPAA2_PMD, vdev_eventdev_dpaa2_pmd);
+RTE_PMD_REGISTER_VDEV(EVENTDEV_NAME_DPAA2_PMD, vdev_eventdev_dpaa2_pmd, __LINE__);
 RTE_LOG_REGISTER_DEFAULT(dpaa2_logtype_event, NOTICE);
diff --git a/drivers/event/dpaa2/dpaa2_hw_dpcon.c b/drivers/event/dpaa2/dpaa2_hw_dpcon.c
index ea5b0d4b85..b56e5362a5 100644
--- a/drivers/event/dpaa2/dpaa2_hw_dpcon.c
+++ b/drivers/event/dpaa2/dpaa2_hw_dpcon.c
@@ -140,4 +140,4 @@ static struct rte_dpaa2_object rte_dpaa2_dpcon_obj = {
 	.close = rte_dpaa2_close_dpcon_device,
 };
 
-RTE_PMD_REGISTER_DPAA2_OBJECT(dpcon, rte_dpaa2_dpcon_obj);
+RTE_PMD_REGISTER_DPAA2_OBJECT(dpcon, rte_dpaa2_dpcon_obj, __LINE__);
diff --git a/drivers/event/dsw/dsw_evdev.c b/drivers/event/dsw/dsw_evdev.c
index e819412639..86f34505d0 100644
--- a/drivers/event/dsw/dsw_evdev.c
+++ b/drivers/event/dsw/dsw_evdev.c
@@ -486,5 +486,5 @@ static struct rte_vdev_driver evdev_dsw_pmd_drv = {
 	.remove = dsw_remove
 };
 
-RTE_PMD_REGISTER_VDEV(EVENTDEV_NAME_DSW_PMD, evdev_dsw_pmd_drv);
+RTE_PMD_REGISTER_VDEV(EVENTDEV_NAME_DSW_PMD, evdev_dsw_pmd_drv, __LINE__);
 RTE_LOG_REGISTER_DEFAULT(event_dsw_logtype, NOTICE);
diff --git a/drivers/event/octeontx/ssovf_evdev.c b/drivers/event/octeontx/ssovf_evdev.c
index 957fcab04e..135a5cd3b8 100644
--- a/drivers/event/octeontx/ssovf_evdev.c
+++ b/drivers/event/octeontx/ssovf_evdev.c
@@ -971,4 +971,5 @@ static struct rte_vdev_driver vdev_ssovf_pmd = {
 	.remove = ssovf_vdev_remove
 };
 
-RTE_PMD_REGISTER_VDEV(EVENTDEV_NAME_OCTEONTX_PMD, vdev_ssovf_pmd);
+/* Blank line to force unique __LINE__ with RTE_PMD_REGISTER_VDEV */
+RTE_PMD_REGISTER_VDEV(EVENTDEV_NAME_OCTEONTX_PMD, vdev_ssovf_pmd, __LINE__);
diff --git a/drivers/event/octeontx/ssovf_probe.c b/drivers/event/octeontx/ssovf_probe.c
index 2c9601a8ff..b55b26158a 100644
--- a/drivers/event/octeontx/ssovf_probe.c
+++ b/drivers/event/octeontx/ssovf_probe.c
@@ -210,7 +210,7 @@ static struct rte_pci_driver pci_ssowvf = {
 	.probe = ssowvf_probe,
 };
 
-RTE_PMD_REGISTER_PCI(octeontx_ssowvf, pci_ssowvf);
+RTE_PMD_REGISTER_PCI(octeontx_ssowvf, pci_ssowvf, __LINE__);
 
 /* SSOVF pcie device aka event queue probe */
 
@@ -286,4 +286,4 @@ static struct rte_pci_driver pci_ssovf = {
 	.probe = ssovf_probe,
 };
 
-RTE_PMD_REGISTER_PCI(octeontx_ssovf, pci_ssovf);
+RTE_PMD_REGISTER_PCI(octeontx_ssovf, pci_ssovf, __LINE__);
diff --git a/drivers/event/octeontx/timvf_probe.c b/drivers/event/octeontx/timvf_probe.c
index 7ce3eddd7e..3523eda05e 100644
--- a/drivers/event/octeontx/timvf_probe.c
+++ b/drivers/event/octeontx/timvf_probe.c
@@ -162,4 +162,4 @@ static struct rte_pci_driver pci_timvf = {
 	.remove = NULL,
 };
 
-RTE_PMD_REGISTER_PCI(octeontx_timvf, pci_timvf);
+RTE_PMD_REGISTER_PCI(octeontx_timvf, pci_timvf, __LINE__);
diff --git a/drivers/event/opdl/opdl_evdev.c b/drivers/event/opdl/opdl_evdev.c
index ffa65ef930..12beb94e71 100644
--- a/drivers/event/opdl/opdl_evdev.c
+++ b/drivers/event/opdl/opdl_evdev.c
@@ -763,6 +763,6 @@ static struct rte_vdev_driver evdev_opdl_pmd_drv = {
 
 RTE_LOG_REGISTER_SUFFIX(opdl_logtype_driver, driver, INFO);
 
-RTE_PMD_REGISTER_VDEV(EVENTDEV_NAME_OPDL_PMD, evdev_opdl_pmd_drv);
+RTE_PMD_REGISTER_VDEV(EVENTDEV_NAME_OPDL_PMD, evdev_opdl_pmd_drv, __LINE__);
 RTE_PMD_REGISTER_PARAM_STRING(event_opdl, NUMA_NODE_ARG "=<int>"
 			      DO_VALIDATION_ARG "=<int>" DO_TEST_ARG "=<int>");
diff --git a/drivers/event/skeleton/skeleton_eventdev.c b/drivers/event/skeleton/skeleton_eventdev.c
index 73a1e4e008..bada61f709 100644
--- a/drivers/event/skeleton/skeleton_eventdev.c
+++ b/drivers/event/skeleton/skeleton_eventdev.c
@@ -395,7 +395,7 @@ static struct rte_pci_driver pci_eventdev_skeleton_pmd = {
 	.remove = event_skeleton_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(event_skeleton_pci, pci_eventdev_skeleton_pmd);
+RTE_PMD_REGISTER_PCI(event_skeleton_pci, pci_eventdev_skeleton_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(event_skeleton_pci, pci_id_skeleton_map);
 
 /* VDEV based event device */
@@ -448,5 +448,5 @@ static struct rte_vdev_driver vdev_eventdev_skeleton_pmd = {
 	.remove = skeleton_eventdev_remove
 };
 
-RTE_PMD_REGISTER_VDEV(EVENTDEV_NAME_SKELETON_PMD, vdev_eventdev_skeleton_pmd);
+RTE_PMD_REGISTER_VDEV(EVENTDEV_NAME_SKELETON_PMD, vdev_eventdev_skeleton_pmd, __LINE__);
 RTE_LOG_REGISTER_DEFAULT(skeleton_eventdev_logtype, INFO);
diff --git a/drivers/event/sw/sw_evdev.c b/drivers/event/sw/sw_evdev.c
index 3ad82e94ac..29eadacc6b 100644
--- a/drivers/event/sw/sw_evdev.c
+++ b/drivers/event/sw/sw_evdev.c
@@ -1142,7 +1142,7 @@ static struct rte_vdev_driver evdev_sw_pmd_drv = {
 	.remove = sw_remove
 };
 
-RTE_PMD_REGISTER_VDEV(EVENTDEV_NAME_SW_PMD, evdev_sw_pmd_drv);
+RTE_PMD_REGISTER_VDEV(EVENTDEV_NAME_SW_PMD, evdev_sw_pmd_drv, __LINE__);
 RTE_PMD_REGISTER_PARAM_STRING(event_sw, NUMA_NODE_ARG "=<int> "
 		SCHED_QUANTA_ARG "=<int>" CREDIT_QUANTA_ARG "=<int>"
 		MIN_BURST_SIZE_ARG "=<int>" DEQ_BURST_SIZE_ARG "=<int>"
diff --git a/drivers/gpu/cuda/cuda.c b/drivers/gpu/cuda/cuda.c
index a552aabeb8..6836715475 100644
--- a/drivers/gpu/cuda/cuda.c
+++ b/drivers/gpu/cuda/cuda.c
@@ -1440,6 +1440,6 @@ static struct rte_pci_driver rte_cuda_driver = {
 	.remove = cuda_gpu_remove,
 };
 
-RTE_PMD_REGISTER_PCI(gpu_cuda, rte_cuda_driver);
+RTE_PMD_REGISTER_PCI(gpu_cuda, rte_cuda_driver, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(gpu_cuda, pci_id_cuda_map);
 RTE_PMD_REGISTER_KMOD_DEP(gpu_cuda, "* nvidia & (nv_peer_mem | nvpeer_mem)");
diff --git a/drivers/mempool/cnxk/cnxk_mempool.c b/drivers/mempool/cnxk/cnxk_mempool.c
index 6ff11d8004..cd84291d46 100644
--- a/drivers/mempool/cnxk/cnxk_mempool.c
+++ b/drivers/mempool/cnxk/cnxk_mempool.c
@@ -197,7 +197,7 @@ static struct rte_pci_driver npa_pci = {
 	.remove = npa_remove,
 };
 
-RTE_PMD_REGISTER_PCI(mempool_cnxk, npa_pci);
+RTE_PMD_REGISTER_PCI(mempool_cnxk, npa_pci, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(mempool_cnxk, npa_pci_map);
 RTE_PMD_REGISTER_KMOD_DEP(mempool_cnxk, "vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(mempool_cnxk,
diff --git a/drivers/mempool/octeontx/octeontx_fpavf.c b/drivers/mempool/octeontx/octeontx_fpavf.c
index 6cd0fc057f..bc6657b166 100644
--- a/drivers/mempool/octeontx/octeontx_fpavf.c
+++ b/drivers/mempool/octeontx/octeontx_fpavf.c
@@ -822,4 +822,4 @@ static struct rte_pci_driver pci_fpavf = {
 	.probe = fpavf_probe,
 };
 
-RTE_PMD_REGISTER_PCI(octeontx_fpavf, pci_fpavf);
+RTE_PMD_REGISTER_PCI(octeontx_fpavf, pci_fpavf, __LINE__);
diff --git a/drivers/ml/cnxk/cn10k_ml_dev.c b/drivers/ml/cnxk/cn10k_ml_dev.c
index c35895dc14..b010b1475b 100644
--- a/drivers/ml/cnxk/cn10k_ml_dev.c
+++ b/drivers/ml/cnxk/cn10k_ml_dev.c
@@ -858,7 +858,7 @@ static struct rte_pci_driver cn10k_mldev_pmd = {
 	.remove = cn10k_ml_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(MLDEV_NAME_CN10K_PMD, cn10k_mldev_pmd);
+RTE_PMD_REGISTER_PCI(MLDEV_NAME_CN10K_PMD, cn10k_mldev_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(MLDEV_NAME_CN10K_PMD, pci_id_ml_table);
 RTE_PMD_REGISTER_KMOD_DEP(MLDEV_NAME_CN10K_PMD, "vfio-pci");
 
diff --git a/drivers/ml/cnxk/mvtvm_ml_dev.c b/drivers/ml/cnxk/mvtvm_ml_dev.c
index 74959a12fc..c4915a7ac0 100644
--- a/drivers/ml/cnxk/mvtvm_ml_dev.c
+++ b/drivers/ml/cnxk/mvtvm_ml_dev.c
@@ -189,7 +189,7 @@ mvtvm_ml_vdev_remove(struct rte_vdev_device *vdev)
 static struct rte_vdev_driver mvtvm_mldev_pmd = {.probe = mvtvm_ml_vdev_probe,
 						 .remove = mvtvm_ml_vdev_remove};
 
-RTE_PMD_REGISTER_VDEV(MLDEV_NAME_MVTVM_PMD, mvtvm_mldev_pmd);
+RTE_PMD_REGISTER_VDEV(MLDEV_NAME_MVTVM_PMD, mvtvm_mldev_pmd, __LINE__);
 
 RTE_PMD_REGISTER_PARAM_STRING(MLDEV_NAME_MVTVM_PMD,
 			      MVTVM_ML_DEV_MAX_QPS "=<int>" MVTVM_ML_DEV_CACHE_MODEL_DATA "=<0|1>");
diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index ab34285ed9..40bad0b525 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -1266,7 +1266,7 @@ static struct rte_vdev_driver pmd_af_packet_drv = {
 	.remove = rte_pmd_af_packet_remove,
 };
 
-RTE_PMD_REGISTER_VDEV(net_af_packet, pmd_af_packet_drv);
+RTE_PMD_REGISTER_VDEV(net_af_packet, pmd_af_packet_drv, __LINE__);
 RTE_PMD_REGISTER_ALIAS(net_af_packet, eth_af_packet);
 RTE_PMD_REGISTER_PARAM_STRING(net_af_packet,
 	"iface=<string> "
diff --git a/drivers/net/af_xdp/rte_eth_af_xdp.c b/drivers/net/af_xdp/rte_eth_af_xdp.c
index 814398ba4b..15086fe44f 100644
--- a/drivers/net/af_xdp/rte_eth_af_xdp.c
+++ b/drivers/net/af_xdp/rte_eth_af_xdp.c
@@ -2559,7 +2559,7 @@ static struct rte_vdev_driver pmd_af_xdp_drv = {
 	.remove = rte_pmd_af_xdp_remove,
 };
 
-RTE_PMD_REGISTER_VDEV(net_af_xdp, pmd_af_xdp_drv);
+RTE_PMD_REGISTER_VDEV(net_af_xdp, pmd_af_xdp_drv, __LINE__);
 RTE_PMD_REGISTER_PARAM_STRING(net_af_xdp,
 			      "iface=<string> "
 			      "start_queue=<int> "
diff --git a/drivers/net/ark/ark_ethdev.c b/drivers/net/ark/ark_ethdev.c
index c029dc46b3..1a3e383a5e 100644
--- a/drivers/net/ark/ark_ethdev.c
+++ b/drivers/net/ark/ark_ethdev.c
@@ -1004,7 +1004,7 @@ eth_ark_check_args(struct ark_adapter *ark, const char *params)
 	return ret;
 }
 
-RTE_PMD_REGISTER_PCI(net_ark, rte_ark_pmd);
+RTE_PMD_REGISTER_PCI(net_ark, rte_ark_pmd, __LINE__);
 RTE_PMD_REGISTER_KMOD_DEP(net_ark, "* igb_uio | uio_pci_generic ");
 RTE_PMD_REGISTER_PCI_TABLE(net_ark, pci_id_ark_map);
 RTE_PMD_REGISTER_PARAM_STRING(net_ark,
diff --git a/drivers/net/atlantic/atl_ethdev.c b/drivers/net/atlantic/atl_ethdev.c
index 9cde935834..7dc2668d91 100644
--- a/drivers/net/atlantic/atl_ethdev.c
+++ b/drivers/net/atlantic/atl_ethdev.c
@@ -1906,7 +1906,7 @@ is_atlantic_supported(struct rte_eth_dev *dev)
 	return is_device_supported(dev, &rte_atl_pmd);
 }
 
-RTE_PMD_REGISTER_PCI(net_atlantic, rte_atl_pmd);
+RTE_PMD_REGISTER_PCI(net_atlantic, rte_atl_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_atlantic, pci_id_atl_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_atlantic, "* igb_uio | uio_pci_generic");
 RTE_LOG_REGISTER_SUFFIX(atl_logtype_init, init, NOTICE);
diff --git a/drivers/net/avp/avp_ethdev.c b/drivers/net/avp/avp_ethdev.c
index ed44c1645d..038ad24328 100644
--- a/drivers/net/avp/avp_ethdev.c
+++ b/drivers/net/avp/avp_ethdev.c
@@ -2305,6 +2305,6 @@ avp_dev_stats_reset(struct rte_eth_dev *eth_dev)
 	return 0;
 }
 
-RTE_PMD_REGISTER_PCI(net_avp, rte_avp_pmd);
+RTE_PMD_REGISTER_PCI(net_avp, rte_avp_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_avp, pci_id_avp_map);
 RTE_LOG_REGISTER_SUFFIX(avp_logtype_driver, driver, NOTICE);
diff --git a/drivers/net/axgbe/axgbe_ethdev.c b/drivers/net/axgbe/axgbe_ethdev.c
index bc73536604..8ae0f19f63 100644
--- a/drivers/net/axgbe/axgbe_ethdev.c
+++ b/drivers/net/axgbe/axgbe_ethdev.c
@@ -2459,7 +2459,7 @@ static struct rte_pci_driver rte_axgbe_pmd = {
 	.remove = eth_axgbe_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(net_axgbe, rte_axgbe_pmd);
+RTE_PMD_REGISTER_PCI(net_axgbe, rte_axgbe_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_axgbe, pci_id_axgbe_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_axgbe, "* igb_uio | uio_pci_generic | vfio-pci");
 RTE_LOG_REGISTER_SUFFIX(axgbe_logtype_init, init, NOTICE);
diff --git a/drivers/net/bnx2x/bnx2x_ethdev.c b/drivers/net/bnx2x/bnx2x_ethdev.c
index 1327cbe912..ea9bf74da9 100644
--- a/drivers/net/bnx2x/bnx2x_ethdev.c
+++ b/drivers/net/bnx2x/bnx2x_ethdev.c
@@ -817,10 +817,11 @@ static struct rte_pci_driver rte_bnx2xvf_pmd = {
 	.remove = eth_bnx2x_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(net_bnx2x, rte_bnx2x_pmd);
+/* Blank line to force unique __LINE__ */
+RTE_PMD_REGISTER_PCI(net_bnx2x, rte_bnx2x_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_bnx2x, pci_id_bnx2x_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_bnx2x, "* igb_uio | uio_pci_generic | vfio-pci");
-RTE_PMD_REGISTER_PCI(net_bnx2xvf, rte_bnx2xvf_pmd);
+RTE_PMD_REGISTER_PCI(net_bnx2xvf, rte_bnx2xvf_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_bnx2xvf, pci_id_bnx2xvf_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_bnx2xvf, "* igb_uio | vfio-pci");
 RTE_LOG_REGISTER_SUFFIX(bnx2x_logtype_init, init, NOTICE);
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 2f37f5aa10..bdf9025217 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -7107,6 +7107,6 @@ static bool bnxt_enable_ulp(struct bnxt *bp)
 }
 
 RTE_LOG_REGISTER_SUFFIX(bnxt_logtype_driver, driver, NOTICE);
-RTE_PMD_REGISTER_PCI(net_bnxt, bnxt_rte_pmd);
+RTE_PMD_REGISTER_PCI(net_bnxt, bnxt_rte_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_bnxt, bnxt_pci_id_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_bnxt, "* igb_uio | uio_pci_generic | vfio-pci");
diff --git a/drivers/net/bonding/rte_eth_bond_pmd.c b/drivers/net/bonding/rte_eth_bond_pmd.c
index b742f538fb..4df426e596 100644
--- a/drivers/net/bonding/rte_eth_bond_pmd.c
+++ b/drivers/net/bonding/rte_eth_bond_pmd.c
@@ -4272,7 +4272,7 @@ struct rte_vdev_driver pmd_bond_drv = {
 	.remove = bond_remove,
 };
 
-RTE_PMD_REGISTER_VDEV(net_bonding, pmd_bond_drv);
+RTE_PMD_REGISTER_VDEV(net_bonding, pmd_bond_drv, __LINE__);
 RTE_PMD_REGISTER_ALIAS(net_bonding, eth_bond);
 
 RTE_PMD_REGISTER_PARAM_STRING(net_bonding,
diff --git a/drivers/net/cnxk/cn10k_ethdev.c b/drivers/net/cnxk/cn10k_ethdev.c
index e491854cb2..e8eb258646 100644
--- a/drivers/net/cnxk/cn10k_ethdev.c
+++ b/drivers/net/cnxk/cn10k_ethdev.c
@@ -1017,6 +1017,6 @@ static struct rte_pci_driver cn10k_pci_nix = {
 	.remove = cn10k_nix_remove,
 };
 
-RTE_PMD_REGISTER_PCI(net_cn10k, cn10k_pci_nix);
+RTE_PMD_REGISTER_PCI(net_cn10k, cn10k_pci_nix, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_cn10k, cn10k_pci_nix_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_cn10k, "vfio-pci");
diff --git a/drivers/net/cnxk/cn20k_ethdev.c b/drivers/net/cnxk/cn20k_ethdev.c
index 740fdb7f76..786082dcef 100644
--- a/drivers/net/cnxk/cn20k_ethdev.c
+++ b/drivers/net/cnxk/cn20k_ethdev.c
@@ -971,6 +971,6 @@ static struct rte_pci_driver cn20k_pci_nix = {
 	.remove = cn20k_nix_remove,
 };
 
-RTE_PMD_REGISTER_PCI(net_cn20k, cn20k_pci_nix);
+RTE_PMD_REGISTER_PCI(net_cn20k, cn20k_pci_nix, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_cn20k, cn20k_pci_nix_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_cn20k, "vfio-pci");
diff --git a/drivers/net/cnxk/cn9k_ethdev.c b/drivers/net/cnxk/cn9k_ethdev.c
index c419593a23..101019b3f6 100644
--- a/drivers/net/cnxk/cn9k_ethdev.c
+++ b/drivers/net/cnxk/cn9k_ethdev.c
@@ -912,6 +912,6 @@ static struct rte_pci_driver cn9k_pci_nix = {
 	.remove = cn9k_nix_remove,
 };
 
-RTE_PMD_REGISTER_PCI(net_cn9k, cn9k_pci_nix);
+RTE_PMD_REGISTER_PCI(net_cn9k, cn9k_pci_nix, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_cn9k, cn9k_pci_nix_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_cn9k, "vfio-pci");
diff --git a/drivers/net/cnxk/cnxk_eswitch.c b/drivers/net/cnxk/cnxk_eswitch.c
index 6b1bfdd476..d8837faf1e 100644
--- a/drivers/net/cnxk/cnxk_eswitch.c
+++ b/drivers/net/cnxk/cnxk_eswitch.c
@@ -795,6 +795,6 @@ static struct rte_pci_driver cnxk_eswitch_pci = {
 	.remove = cnxk_eswitch_dev_remove,
 };
 
-RTE_PMD_REGISTER_PCI(cnxk_eswitch, cnxk_eswitch_pci);
+RTE_PMD_REGISTER_PCI(cnxk_eswitch, cnxk_eswitch_pci, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(cnxk_eswitch, cnxk_eswitch_pci_map);
 RTE_PMD_REGISTER_KMOD_DEP(cnxk_eswitch, "vfio-pci");
diff --git a/drivers/net/cnxk/cnxk_ethdev_sec.c b/drivers/net/cnxk/cnxk_ethdev_sec.c
index 614997bd3d..7531a536f7 100644
--- a/drivers/net/cnxk/cnxk_ethdev_sec.c
+++ b/drivers/net/cnxk/cnxk_ethdev_sec.c
@@ -673,7 +673,7 @@ static struct rte_pci_driver cnxk_nix_inl_pci = {
 	.remove = cnxk_nix_inl_dev_remove,
 };
 
-RTE_PMD_REGISTER_PCI(cnxk_nix_inl, cnxk_nix_inl_pci);
+RTE_PMD_REGISTER_PCI(cnxk_nix_inl, cnxk_nix_inl_pci, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(cnxk_nix_inl, cnxk_nix_inl_pci_map);
 RTE_PMD_REGISTER_KMOD_DEP(cnxk_nix_inl, "vfio-pci");
 
diff --git a/drivers/net/cxgbe/cxgbe_ethdev.c b/drivers/net/cxgbe/cxgbe_ethdev.c
index 9b6a3651f9..e3607d827d 100644
--- a/drivers/net/cxgbe/cxgbe_ethdev.c
+++ b/drivers/net/cxgbe/cxgbe_ethdev.c
@@ -1796,7 +1796,7 @@ static struct rte_pci_driver rte_cxgbe_pmd = {
 	.remove = eth_cxgbe_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(net_cxgbe, rte_cxgbe_pmd);
+RTE_PMD_REGISTER_PCI(net_cxgbe, rte_cxgbe_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_cxgbe, cxgb4_pci_tbl);
 RTE_PMD_REGISTER_KMOD_DEP(net_cxgbe, "* igb_uio | uio_pci_generic | vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(net_cxgbe,
diff --git a/drivers/net/cxgbe/cxgbevf_ethdev.c b/drivers/net/cxgbe/cxgbevf_ethdev.c
index a62c56c2b9..ead3b3a2c9 100644
--- a/drivers/net/cxgbe/cxgbevf_ethdev.c
+++ b/drivers/net/cxgbe/cxgbevf_ethdev.c
@@ -206,7 +206,7 @@ static struct rte_pci_driver rte_cxgbevf_pmd = {
 	.remove = eth_cxgbevf_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(net_cxgbevf, rte_cxgbevf_pmd);
+RTE_PMD_REGISTER_PCI(net_cxgbevf, rte_cxgbevf_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_cxgbevf, cxgb4vf_pci_tbl);
 RTE_PMD_REGISTER_KMOD_DEP(net_cxgbevf, "* igb_uio | vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(net_cxgbevf,
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 00b57cb715..da580d0572 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -2628,7 +2628,7 @@ static struct rte_dpaa_driver rte_dpaa_pmd = {
 	.remove = rte_dpaa_remove,
 };
 
-RTE_PMD_REGISTER_DPAA(net_dpaa, rte_dpaa_pmd);
+RTE_PMD_REGISTER_DPAA(net_dpaa, rte_dpaa_pmd, __LINE__);
 RTE_PMD_REGISTER_PARAM_STRING(net_dpaa,
 		DRIVER_IEEE1588 "=<int>");
 RTE_LOG_REGISTER_DEFAULT(dpaa_logtype_pmd, NOTICE);
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index c53c2d0549..108b59a682 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -3068,7 +3068,7 @@ static struct rte_dpaa2_driver rte_dpaa2_pmd = {
 	.remove = rte_dpaa2_remove,
 };
 
-RTE_PMD_REGISTER_DPAA2(NET_DPAA2_PMD_DRIVER_NAME, rte_dpaa2_pmd);
+RTE_PMD_REGISTER_DPAA2(NET_DPAA2_PMD_DRIVER_NAME, rte_dpaa2_pmd, __LINE__);
 RTE_PMD_REGISTER_PARAM_STRING(NET_DPAA2_PMD_DRIVER_NAME,
 		DRIVER_LOOPBACK_MODE "=<int> "
 		DRIVER_NO_PREFETCH_MODE "=<int>"
diff --git a/drivers/net/dpaa2/dpaa2_mux.c b/drivers/net/dpaa2/dpaa2_mux.c
index a4ac566e26..89da4634e7 100644
--- a/drivers/net/dpaa2/dpaa2_mux.c
+++ b/drivers/net/dpaa2/dpaa2_mux.c
@@ -606,4 +606,4 @@ static struct rte_dpaa2_object rte_dpaa2_dpdmux_obj = {
 	.close = dpaa2_close_dpdmux_device,
 };
 
-RTE_PMD_REGISTER_DPAA2_OBJECT(dpdmux, rte_dpaa2_dpdmux_obj);
+RTE_PMD_REGISTER_DPAA2_OBJECT(dpdmux, rte_dpaa2_dpdmux_obj, __LINE__);
diff --git a/drivers/net/dpaa2/dpaa2_ptp.c b/drivers/net/dpaa2/dpaa2_ptp.c
index 751e558c73..9d1f6f9686 100644
--- a/drivers/net/dpaa2/dpaa2_ptp.c
+++ b/drivers/net/dpaa2/dpaa2_ptp.c
@@ -180,5 +180,5 @@ static struct rte_dpaa2_object rte_dpaa2_dprtc_obj = {
 	.create = dpaa2_create_dprtc_device,
 };
 
-RTE_PMD_REGISTER_DPAA2_OBJECT(dprtc, rte_dpaa2_dprtc_obj);
+RTE_PMD_REGISTER_DPAA2_OBJECT(dprtc, rte_dpaa2_dprtc_obj, __LINE__);
 #endif
diff --git a/drivers/net/ena/ena_ethdev.c b/drivers/net/ena/ena_ethdev.c
index a13506890f..f249be6ca0 100644
--- a/drivers/net/ena/ena_ethdev.c
+++ b/drivers/net/ena/ena_ethdev.c
@@ -4014,7 +4014,7 @@ static struct rte_pci_driver rte_ena_pmd = {
 	.remove = eth_ena_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(net_ena, rte_ena_pmd);
+RTE_PMD_REGISTER_PCI(net_ena, rte_ena_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_ena, pci_id_ena_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_ena, "* igb_uio | uio_pci_generic | vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(net_ena,
diff --git a/drivers/net/enetc/enetc_ethdev.c b/drivers/net/enetc/enetc_ethdev.c
index ffbecc407c..80eeddf39b 100644
--- a/drivers/net/enetc/enetc_ethdev.c
+++ b/drivers/net/enetc/enetc_ethdev.c
@@ -965,7 +965,7 @@ static struct rte_pci_driver rte_enetc_pmd = {
 	.remove = enetc_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(net_enetc, rte_enetc_pmd);
+RTE_PMD_REGISTER_PCI(net_enetc, rte_enetc_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_enetc, pci_id_enetc_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_enetc, "* vfio-pci");
 RTE_LOG_REGISTER_DEFAULT(enetc_logtype_pmd, NOTICE);
diff --git a/drivers/net/enetfec/enet_ethdev.c b/drivers/net/enetfec/enet_ethdev.c
index 7c2926409e..c9aa9a12a5 100644
--- a/drivers/net/enetfec/enet_ethdev.c
+++ b/drivers/net/enetfec/enet_ethdev.c
@@ -689,5 +689,5 @@ static struct rte_vdev_driver pmd_enetfec_drv = {
 	.remove = pmd_enetfec_remove,
 };
 
-RTE_PMD_REGISTER_VDEV(ENETFEC_NAME_PMD, pmd_enetfec_drv);
+RTE_PMD_REGISTER_VDEV(ENETFEC_NAME_PMD, pmd_enetfec_drv, __LINE__);
 RTE_LOG_REGISTER_DEFAULT(enetfec_logtype_pmd, NOTICE);
diff --git a/drivers/net/enic/enic_ethdev.c b/drivers/net/enic/enic_ethdev.c
index c216994766..14014462c0 100644
--- a/drivers/net/enic/enic_ethdev.c
+++ b/drivers/net/enic/enic_ethdev.c
@@ -1425,7 +1425,7 @@ int dev_is_enic(struct rte_eth_dev *dev)
 	return dev->device->driver == &rte_enic_pmd.driver;
 }
 
-RTE_PMD_REGISTER_PCI(net_enic, rte_enic_pmd);
+RTE_PMD_REGISTER_PCI(net_enic, rte_enic_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_enic, pci_id_enic_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_enic, "* igb_uio | uio_pci_generic | vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(net_enic,
diff --git a/drivers/net/failsafe/failsafe.c b/drivers/net/failsafe/failsafe.c
index 3e590d38f7..d7c9fba359 100644
--- a/drivers/net/failsafe/failsafe.c
+++ b/drivers/net/failsafe/failsafe.c
@@ -396,6 +396,6 @@ static struct rte_vdev_driver failsafe_drv = {
 	.remove = rte_pmd_failsafe_remove,
 };
 
-RTE_PMD_REGISTER_VDEV(net_failsafe, failsafe_drv);
+RTE_PMD_REGISTER_VDEV(net_failsafe, failsafe_drv, __LINE__);
 RTE_PMD_REGISTER_PARAM_STRING(net_failsafe, PMD_FAILSAFE_PARAM_STRING);
 RTE_LOG_REGISTER_DEFAULT(failsafe_logtype, NOTICE)
diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index e471a34e61..3d2d6b6677 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -1364,7 +1364,7 @@ static struct rte_pci_driver rte_gve_pmd = {
 	.remove = gve_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(net_gve, rte_gve_pmd);
+RTE_PMD_REGISTER_PCI(net_gve, rte_gve_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_gve, pci_id_gve_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_gve, "* igb_uio | vfio-pci");
 RTE_LOG_REGISTER_SUFFIX(gve_logtype_driver, driver, NOTICE);
diff --git a/drivers/net/hinic/hinic_pmd_ethdev.c b/drivers/net/hinic/hinic_pmd_ethdev.c
index cb5c013b21..84ec87c007 100644
--- a/drivers/net/hinic/hinic_pmd_ethdev.c
+++ b/drivers/net/hinic/hinic_pmd_ethdev.c
@@ -3255,6 +3255,6 @@ static struct rte_pci_driver rte_hinic_pmd = {
 	.remove = hinic_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(net_hinic, rte_hinic_pmd);
+RTE_PMD_REGISTER_PCI(net_hinic, rte_hinic_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_hinic, pci_id_hinic_map);
 RTE_LOG_REGISTER_DEFAULT(hinic_logtype, INFO);
diff --git a/drivers/net/hns3/hns3_ethdev.c b/drivers/net/hns3/hns3_ethdev.c
index 9f7119b734..2bdddc6175 100644
--- a/drivers/net/hns3/hns3_ethdev.c
+++ b/drivers/net/hns3/hns3_ethdev.c
@@ -6688,7 +6688,7 @@ static struct rte_pci_driver rte_hns3_pmd = {
 	.remove = eth_hns3_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(net_hns3, rte_hns3_pmd);
+RTE_PMD_REGISTER_PCI(net_hns3, rte_hns3_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_hns3, pci_id_hns3_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_hns3, "* igb_uio | vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(net_hns3,
diff --git a/drivers/net/hns3/hns3_ethdev_vf.c b/drivers/net/hns3/hns3_ethdev_vf.c
index ea9225cd26..cad8c7af3d 100644
--- a/drivers/net/hns3/hns3_ethdev_vf.c
+++ b/drivers/net/hns3/hns3_ethdev_vf.c
@@ -2360,7 +2360,7 @@ static struct rte_pci_driver rte_hns3vf_pmd = {
 	.remove = eth_hns3vf_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(net_hns3_vf, rte_hns3vf_pmd);
+RTE_PMD_REGISTER_PCI(net_hns3_vf, rte_hns3vf_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_hns3_vf, pci_id_hns3vf_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_hns3_vf, "* igb_uio | vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(net_hns3_vf,
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index 1817221652..7bfaf566ad 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -2876,7 +2876,7 @@ static struct rte_pci_driver rte_cpfl_pmd = {
  * Invoked once at EAL init time.
  * Register itself as the [Poll Mode] Driver of PCI devices.
  */
-RTE_PMD_REGISTER_PCI(net_cpfl, rte_cpfl_pmd);
+RTE_PMD_REGISTER_PCI(net_cpfl, rte_cpfl_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_cpfl, pci_id_cpfl_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_cpfl, "* igb_uio | vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(net_cpfl,
diff --git a/drivers/net/intel/e1000/em_ethdev.c b/drivers/net/intel/e1000/em_ethdev.c
index 39dddf3384..a7fa7ac4e7 100644
--- a/drivers/net/intel/e1000/em_ethdev.c
+++ b/drivers/net/intel/e1000/em_ethdev.c
@@ -1956,6 +1956,6 @@ eth_em_set_mc_addr_list(struct rte_eth_dev *dev,
 	return 0;
 }
 
-RTE_PMD_REGISTER_PCI(net_e1000_em, rte_em_pmd);
+RTE_PMD_REGISTER_PCI(net_e1000_em, rte_em_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_e1000_em, pci_id_em_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_e1000_em, "* igb_uio | uio_pci_generic | vfio-pci");
diff --git a/drivers/net/intel/e1000/igb_ethdev.c b/drivers/net/intel/e1000/igb_ethdev.c
index cbd2f15f5f..b58388f98f 100644
--- a/drivers/net/intel/e1000/igb_ethdev.c
+++ b/drivers/net/intel/e1000/igb_ethdev.c
@@ -5626,9 +5626,9 @@ igb_filter_restore(struct rte_eth_dev *dev)
 	return 0;
 }
 
-RTE_PMD_REGISTER_PCI(net_e1000_igb, rte_igb_pmd);
+RTE_PMD_REGISTER_PCI(net_e1000_igb, rte_igb_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_e1000_igb, pci_id_igb_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_e1000_igb, "* igb_uio | uio_pci_generic | vfio-pci");
-RTE_PMD_REGISTER_PCI(net_e1000_igb_vf, rte_igbvf_pmd);
+RTE_PMD_REGISTER_PCI(net_e1000_igb_vf, rte_igbvf_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_e1000_igb_vf, pci_id_igbvf_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_e1000_igb_vf, "* igb_uio | vfio-pci");
diff --git a/drivers/net/intel/e1000/igc_ethdev.c b/drivers/net/intel/e1000/igc_ethdev.c
index e712cfcf7c..4215a6a692 100644
--- a/drivers/net/intel/e1000/igc_ethdev.c
+++ b/drivers/net/intel/e1000/igc_ethdev.c
@@ -3000,6 +3000,6 @@ static struct rte_pci_driver rte_igc_pmd = {
 	.remove = eth_igc_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(net_igc, rte_igc_pmd);
+RTE_PMD_REGISTER_PCI(net_igc, rte_igc_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_igc, pci_id_igc_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_igc, "* igb_uio | uio_pci_generic | vfio-pci");
diff --git a/drivers/net/intel/fm10k/fm10k_ethdev.c b/drivers/net/intel/fm10k/fm10k_ethdev.c
index 75ce2e19cf..dfd405e01b 100644
--- a/drivers/net/intel/fm10k/fm10k_ethdev.c
+++ b/drivers/net/intel/fm10k/fm10k_ethdev.c
@@ -3313,7 +3313,7 @@ static struct rte_pci_driver rte_pmd_fm10k = {
 	.remove = eth_fm10k_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(net_fm10k, rte_pmd_fm10k);
+RTE_PMD_REGISTER_PCI(net_fm10k, rte_pmd_fm10k, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_fm10k, pci_id_fm10k_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_fm10k, "* igb_uio | uio_pci_generic | vfio-pci");
 RTE_LOG_REGISTER_SUFFIX(fm10k_logtype_init, init, NOTICE);
diff --git a/drivers/net/intel/i40e/i40e_ethdev.c b/drivers/net/intel/i40e/i40e_ethdev.c
index 90eba3419f..8e7da4847b 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.c
+++ b/drivers/net/intel/i40e/i40e_ethdev.c
@@ -756,7 +756,7 @@ i40e_write_global_rx_ctl(struct i40e_hw *hw, uint32_t reg_addr,
 			    dev->device->name, reg_addr, ori_reg_val, reg_val);
 }
 
-RTE_PMD_REGISTER_PCI(net_i40e, rte_i40e_pmd);
+RTE_PMD_REGISTER_PCI(net_i40e, rte_i40e_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_i40e, pci_id_i40e_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_i40e, "* igb_uio | uio_pci_generic | vfio-pci");
 
diff --git a/drivers/net/intel/iavf/iavf_ethdev.c b/drivers/net/intel/iavf/iavf_ethdev.c
index 2335746f04..bcf7534d1f 100644
--- a/drivers/net/intel/iavf/iavf_ethdev.c
+++ b/drivers/net/intel/iavf/iavf_ethdev.c
@@ -3194,7 +3194,7 @@ static struct rte_pci_driver rte_iavf_pmd = {
 	.remove = eth_iavf_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(net_iavf, rte_iavf_pmd);
+RTE_PMD_REGISTER_PCI(net_iavf, rte_iavf_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_iavf, pci_id_iavf_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_iavf, "* igb_uio | vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(net_iavf, "cap=dcf");
diff --git a/drivers/net/intel/ice/ice_dcf_ethdev.c b/drivers/net/intel/ice/ice_dcf_ethdev.c
index efff76afa8..50e48ae2e0 100644
--- a/drivers/net/intel/ice/ice_dcf_ethdev.c
+++ b/drivers/net/intel/ice/ice_dcf_ethdev.c
@@ -2152,7 +2152,7 @@ static struct rte_pci_driver rte_ice_dcf_pmd = {
 	.remove = eth_ice_dcf_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(net_ice_dcf, rte_ice_dcf_pmd);
+RTE_PMD_REGISTER_PCI(net_ice_dcf, rte_ice_dcf_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_ice_dcf, pci_id_ice_dcf_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_ice_dcf, "* igb_uio | vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(net_ice_dcf, "cap=dcf");
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 21d3795954..8e9df36b01 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -7254,7 +7254,7 @@ static struct rte_pci_driver rte_ice_pmd = {
  * Invoked once at EAL init time.
  * Register itself as the [Poll Mode] Driver of PCI devices.
  */
-RTE_PMD_REGISTER_PCI(net_ice, rte_ice_pmd);
+RTE_PMD_REGISTER_PCI(net_ice, rte_ice_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_ice, pci_id_ice_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_ice, "* igb_uio | uio_pci_generic | vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(net_ice,
diff --git a/drivers/net/intel/idpf/idpf_ethdev.c b/drivers/net/intel/idpf/idpf_ethdev.c
index 7718167096..b1e683fc1c 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.c
+++ b/drivers/net/intel/idpf/idpf_ethdev.c
@@ -1477,7 +1477,7 @@ static struct rte_pci_driver rte_idpf_pmd = {
  * Invoked once at EAL init time.
  * Register itself as the [Poll Mode] Driver of PCI devices.
  */
-RTE_PMD_REGISTER_PCI(net_idpf, rte_idpf_pmd);
+RTE_PMD_REGISTER_PCI(net_idpf, rte_idpf_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_idpf, pci_id_idpf_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_idpf, "* igb_uio | vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(net_idpf,
diff --git a/drivers/net/intel/ipn3ke/ipn3ke_ethdev.c b/drivers/net/intel/ipn3ke/ipn3ke_ethdev.c
index 2ee87c94c2..85582f56db 100644
--- a/drivers/net/intel/ipn3ke/ipn3ke_ethdev.c
+++ b/drivers/net/intel/ipn3ke/ipn3ke_ethdev.c
@@ -564,5 +564,5 @@ static struct rte_afu_driver afu_ipn3ke_driver = {
 	.remove = ipn3ke_vswitch_remove,
 };
 
-RTE_PMD_REGISTER_AFU(net_ipn3ke_afu, afu_ipn3ke_driver);
+RTE_PMD_REGISTER_AFU(net_ipn3ke_afu, afu_ipn3ke_driver, __LINE__);
 RTE_LOG_REGISTER_DEFAULT(ipn3ke_afu_logtype, NOTICE);
diff --git a/drivers/net/intel/ixgbe/ixgbe_ethdev.c b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
index 0fa4898aba..1c93769a5e 100644
--- a/drivers/net/intel/ixgbe/ixgbe_ethdev.c
+++ b/drivers/net/intel/ixgbe/ixgbe_ethdev.c
@@ -8607,12 +8607,12 @@ ixgbe_dev_macsec_register_disable(struct rte_eth_dev *dev)
 	ixgbe_enable_sec_tx_path_generic(hw);
 }
 
-RTE_PMD_REGISTER_PCI(net_ixgbe, rte_ixgbe_pmd);
+RTE_PMD_REGISTER_PCI(net_ixgbe, rte_ixgbe_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_ixgbe, pci_id_ixgbe_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_ixgbe, "* igb_uio | uio_pci_generic | vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(net_ixgbe,
 			      IXGBE_DEVARG_FIBER_SDP3_NOT_TX_DISABLE "=<0|1>");
-RTE_PMD_REGISTER_PCI(net_ixgbe_vf, rte_ixgbevf_pmd);
+RTE_PMD_REGISTER_PCI(net_ixgbe_vf, rte_ixgbevf_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_ixgbe_vf, pci_id_ixgbevf_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_ixgbe_vf, "* igb_uio | vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(net_ixgbe_vf,
diff --git a/drivers/net/ionic/ionic_dev_pci.c b/drivers/net/ionic/ionic_dev_pci.c
index 76235cad51..1995bf8e5b 100644
--- a/drivers/net/ionic/ionic_dev_pci.c
+++ b/drivers/net/ionic/ionic_dev_pci.c
@@ -265,7 +265,7 @@ static struct rte_pci_driver rte_pci_ionic_pmd = {
 	.remove = eth_ionic_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(net_ionic_pci, rte_pci_ionic_pmd);
+RTE_PMD_REGISTER_PCI(net_ionic_pci, rte_pci_ionic_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_ionic_pci, pci_id_ionic_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_ionic_pci, "* igb_uio | uio_pci_generic | vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(net_ionic_pci,
diff --git a/drivers/net/ionic/ionic_dev_vdev.c b/drivers/net/ionic/ionic_dev_vdev.c
index 232ee89476..4f08fcc192 100644
--- a/drivers/net/ionic/ionic_dev_vdev.c
+++ b/drivers/net/ionic/ionic_dev_vdev.c
@@ -144,4 +144,5 @@ static struct rte_vdev_driver rte_vdev_ionic_pmd = {
 	.remove = eth_ionic_vdev_remove,
 };
 
-RTE_PMD_REGISTER_VDEV(net_ionic, rte_vdev_ionic_pmd);
+/* Blank line to force unique __LINE__ */
+RTE_PMD_REGISTER_VDEV(net_ionic, rte_vdev_ionic_pmd, __LINE__);
diff --git a/drivers/net/mana/mana.c b/drivers/net/mana/mana.c
index 2934da29f7..c0aea1bcdb 100644
--- a/drivers/net/mana/mana.c
+++ b/drivers/net/mana/mana.c
@@ -1648,7 +1648,7 @@ static struct rte_pci_driver mana_pci_driver = {
 	.drv_flags = RTE_PCI_DRV_INTR_RMV,
 };
 
-RTE_PMD_REGISTER_PCI(net_mana, mana_pci_driver);
+RTE_PMD_REGISTER_PCI(net_mana, mana_pci_driver, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_mana, mana_pci_id_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_mana, "* ib_uverbs & mana_ib");
 RTE_LOG_REGISTER_SUFFIX(mana_logtype_init, init, NOTICE);
diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index f7b04c4f9e..f518d46366 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -2083,7 +2083,7 @@ static struct rte_vdev_driver pmd_memif_drv = {
 	.remove = rte_pmd_memif_remove,
 };
 
-RTE_PMD_REGISTER_VDEV(net_memif, pmd_memif_drv);
+RTE_PMD_REGISTER_VDEV(net_memif, pmd_memif_drv, __LINE__);
 
 RTE_PMD_REGISTER_PARAM_STRING(net_memif,
 			      ETH_MEMIF_ID_ARG "=<int>"
diff --git a/drivers/net/mlx4/mlx4.c b/drivers/net/mlx4/mlx4.c
index 9c2872429f..0e7d8cdd6c 100644
--- a/drivers/net/mlx4/mlx4.c
+++ b/drivers/net/mlx4/mlx4.c
@@ -1385,7 +1385,7 @@ RTE_INIT(rte_mlx4_pmd_init)
 	rte_pci_register(&mlx4_driver);
 }
 
-RTE_PMD_EXPORT_NAME(net_mlx4, __COUNTER__);
+RTE_PMD_EXPORT_NAME(net_mlx4, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_mlx4, mlx4_pci_id_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_mlx4,
 	"* ib_uverbs & mlx4_en & mlx4_core & mlx4_ib");
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index b4bd43aae2..03a75fc0ec 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -3819,6 +3819,6 @@ RTE_INIT(rte_mlx5_pmd_init)
 		mlx5_class_driver_register(&mlx5_net_driver);
 }
 
-RTE_PMD_EXPORT_NAME(MLX5_ETH_DRIVER_NAME, __COUNTER__);
+RTE_PMD_EXPORT_NAME(MLX5_ETH_DRIVER_NAME, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(MLX5_ETH_DRIVER_NAME, mlx5_pci_id_map);
 RTE_PMD_REGISTER_KMOD_DEP(MLX5_ETH_DRIVER_NAME, "* ib_uverbs & mlx5_core & mlx5_ib");
diff --git a/drivers/net/mvneta/mvneta_ethdev.c b/drivers/net/mvneta/mvneta_ethdev.c
index f99f9e6289..5d2f6dd8c0 100644
--- a/drivers/net/mvneta/mvneta_ethdev.c
+++ b/drivers/net/mvneta/mvneta_ethdev.c
@@ -993,6 +993,6 @@ static struct rte_vdev_driver pmd_mvneta_drv = {
 	.remove = rte_pmd_mvneta_remove,
 };
 
-RTE_PMD_REGISTER_VDEV(net_mvneta, pmd_mvneta_drv);
+RTE_PMD_REGISTER_VDEV(net_mvneta, pmd_mvneta_drv, __LINE__);
 RTE_PMD_REGISTER_PARAM_STRING(net_mvneta, "iface=<ifc>");
 RTE_LOG_REGISTER_DEFAULT(mvneta_logtype, NOTICE);
diff --git a/drivers/net/mvpp2/mrvl_ethdev.c b/drivers/net/mvpp2/mrvl_ethdev.c
index 4200c11d46..3530f28933 100644
--- a/drivers/net/mvpp2/mrvl_ethdev.c
+++ b/drivers/net/mvpp2/mrvl_ethdev.c
@@ -3319,6 +3319,6 @@ static struct rte_vdev_driver pmd_mrvl_drv = {
 	.remove = rte_pmd_mrvl_remove,
 };
 
-RTE_PMD_REGISTER_VDEV(net_mvpp2, pmd_mrvl_drv);
+RTE_PMD_REGISTER_VDEV(net_mvpp2, pmd_mrvl_drv, __LINE__);
 RTE_PMD_REGISTER_ALIAS(net_mvpp2, eth_mvpp2);
 RTE_LOG_REGISTER_DEFAULT(mrvl_logtype, NOTICE);
diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index f848157b49..d01c7af64d 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -1485,7 +1485,7 @@ static struct rte_vmbus_driver rte_netvsc_pmd = {
 	.remove = eth_hn_remove,
 };
 
-RTE_PMD_REGISTER_VMBUS(net_netvsc, rte_netvsc_pmd);
+RTE_PMD_REGISTER_VMBUS(net_netvsc, rte_netvsc_pmd, __LINE__);
 RTE_PMD_REGISTER_KMOD_DEP(net_netvsc, "* uio_hv_generic");
 RTE_LOG_REGISTER_SUFFIX(hn_logtype_init, init, NOTICE);
 RTE_LOG_REGISTER_SUFFIX(hn_logtype_driver, driver, NOTICE);
diff --git a/drivers/net/nfb/nfb_ethdev.c b/drivers/net/nfb/nfb_ethdev.c
index 98119d70fd..fc9202c042 100644
--- a/drivers/net/nfb/nfb_ethdev.c
+++ b/drivers/net/nfb/nfb_ethdev.c
@@ -668,7 +668,7 @@ static struct rte_pci_driver nfb_eth_driver = {
 	.remove = nfb_eth_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(RTE_NFB_DRIVER_NAME, nfb_eth_driver);
+RTE_PMD_REGISTER_PCI(RTE_NFB_DRIVER_NAME, nfb_eth_driver, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(RTE_NFB_DRIVER_NAME, nfb_pci_id_table);
 RTE_PMD_REGISTER_KMOD_DEP(RTE_NFB_DRIVER_NAME, "* nfb");
 RTE_LOG_REGISTER_DEFAULT(nfb_logtype, NOTICE);
diff --git a/drivers/net/nfp/nfp_ethdev.c b/drivers/net/nfp/nfp_ethdev.c
index cbd1deffb4..2aef6885ea 100644
--- a/drivers/net/nfp/nfp_ethdev.c
+++ b/drivers/net/nfp/nfp_ethdev.c
@@ -2904,7 +2904,7 @@ static struct rte_pci_driver rte_nfp_net_pf_pmd = {
 	.remove = eth_nfp_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(NFP_PF_DRIVER_NAME, rte_nfp_net_pf_pmd);
+RTE_PMD_REGISTER_PCI(NFP_PF_DRIVER_NAME, rte_nfp_net_pf_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(NFP_PF_DRIVER_NAME, pci_id_nfp_pf_net_map);
 RTE_PMD_REGISTER_KMOD_DEP(NFP_PF_DRIVER_NAME, "* igb_uio | uio_pci_generic | vfio");
 RTE_PMD_REGISTER_PARAM_STRING(NFP_PF_DRIVER_NAME,
diff --git a/drivers/net/ngbe/ngbe_ethdev.c b/drivers/net/ngbe/ngbe_ethdev.c
index 08e87471f6..3386462282 100644
--- a/drivers/net/ngbe/ngbe_ethdev.c
+++ b/drivers/net/ngbe/ngbe_ethdev.c
@@ -3294,7 +3294,7 @@ static const struct eth_dev_ops ngbe_eth_dev_ops = {
 	.tx_done_cleanup            = ngbe_dev_tx_done_cleanup,
 };
 
-RTE_PMD_REGISTER_PCI(net_ngbe, rte_ngbe_pmd);
+RTE_PMD_REGISTER_PCI(net_ngbe, rte_ngbe_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_ngbe, pci_id_ngbe_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_ngbe, "* igb_uio | uio_pci_generic | vfio-pci");
 
diff --git a/drivers/net/ngbe/ngbe_ethdev_vf.c b/drivers/net/ngbe/ngbe_ethdev_vf.c
index 5d68f1602d..0406b40bdf 100644
--- a/drivers/net/ngbe/ngbe_ethdev_vf.c
+++ b/drivers/net/ngbe/ngbe_ethdev_vf.c
@@ -1348,6 +1348,6 @@ static const struct eth_dev_ops ngbevf_eth_dev_ops = {
 	.tx_done_cleanup      = ngbe_dev_tx_done_cleanup,
 };
 
-RTE_PMD_REGISTER_PCI(net_ngbe_vf, rte_ngbevf_pmd);
+RTE_PMD_REGISTER_PCI(net_ngbe_vf, rte_ngbevf_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_ngbe_vf, pci_id_ngbevf_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_ngbe_vf, "* igb_uio | vfio-pci");
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 9a6667b3be..2b87cfef7a 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -2547,7 +2547,7 @@ static struct rte_pci_driver rte_nthw_pmd = {
 	.remove = nthw_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(net_ntnic, rte_nthw_pmd);
+RTE_PMD_REGISTER_PCI(net_ntnic, rte_nthw_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_ntnic, nthw_pci_id_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_ntnic, "* vfio-pci");
 
diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 6764cf2ec1..3428948e65 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -771,7 +771,7 @@ static struct rte_vdev_driver pmd_null_drv = {
 	.remove = rte_pmd_null_remove,
 };
 
-RTE_PMD_REGISTER_VDEV(net_null, pmd_null_drv);
+RTE_PMD_REGISTER_VDEV(net_null, pmd_null_drv, __LINE__);
 RTE_PMD_REGISTER_ALIAS(net_null, eth_null);
 RTE_PMD_REGISTER_PARAM_STRING(net_null,
 	"size=<int> "
diff --git a/drivers/net/octeon_ep/otx_ep_ethdev.c b/drivers/net/octeon_ep/otx_ep_ethdev.c
index 10f2f8a2e0..8cfd4c8283 100644
--- a/drivers/net/octeon_ep/otx_ep_ethdev.c
+++ b/drivers/net/octeon_ep/otx_ep_ethdev.c
@@ -900,7 +900,7 @@ static struct rte_pci_driver rte_otx_ep_pmd = {
 	.remove		= otx_ep_eth_dev_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(net_otx_ep, rte_otx_ep_pmd);
+RTE_PMD_REGISTER_PCI(net_otx_ep, rte_otx_ep_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_otx_ep, pci_id_otx_ep_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_otx_ep, "* igb_uio | vfio-pci");
 RTE_LOG_REGISTER_DEFAULT(otx_net_ep_logtype, NOTICE);
diff --git a/drivers/net/octeontx/base/octeontx_pkivf.c b/drivers/net/octeontx/base/octeontx_pkivf.c
index 6a48a22de6..3954325b68 100644
--- a/drivers/net/octeontx/base/octeontx_pkivf.c
+++ b/drivers/net/octeontx/base/octeontx_pkivf.c
@@ -236,4 +236,4 @@ static struct rte_pci_driver pci_pkivf = {
 	.probe = pkivf_probe,
 };
 
-RTE_PMD_REGISTER_PCI(octeontx_pkivf, pci_pkivf);
+RTE_PMD_REGISTER_PCI(octeontx_pkivf, pci_pkivf, __LINE__);
diff --git a/drivers/net/octeontx/base/octeontx_pkovf.c b/drivers/net/octeontx/base/octeontx_pkovf.c
index 7aec84a813..3ae56a28c0 100644
--- a/drivers/net/octeontx/base/octeontx_pkovf.c
+++ b/drivers/net/octeontx/base/octeontx_pkovf.c
@@ -637,4 +637,4 @@ static struct rte_pci_driver pci_pkovf = {
 	.probe = pkovf_probe,
 };
 
-RTE_PMD_REGISTER_PCI(octeontx_pkovf, pci_pkovf);
+RTE_PMD_REGISTER_PCI(octeontx_pkovf, pci_pkovf, __LINE__);
diff --git a/drivers/net/octeontx/octeontx_ethdev.c b/drivers/net/octeontx/octeontx_ethdev.c
index 9451431144..261c2d4913 100644
--- a/drivers/net/octeontx/octeontx_ethdev.c
+++ b/drivers/net/octeontx/octeontx_ethdev.c
@@ -1899,6 +1899,7 @@ static struct rte_vdev_driver octeontx_pmd_drv = {
 	.remove = octeontx_remove,
 };
 
-RTE_PMD_REGISTER_VDEV(OCTEONTX_PMD, octeontx_pmd_drv);
+/* Blank line to force unique __LINE__ with RTE_PMD_REGISTER_VDEV */
+RTE_PMD_REGISTER_VDEV(OCTEONTX_PMD, octeontx_pmd_drv, __LINE__);
 RTE_PMD_REGISTER_ALIAS(OCTEONTX_PMD, eth_octeontx);
 RTE_PMD_REGISTER_PARAM_STRING(OCTEONTX_PMD, "nr_port=<int> ");
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 728ef85d53..b92afe4ff9 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -1650,7 +1650,7 @@ static struct rte_vdev_driver pmd_pcap_drv = {
 	.remove = pmd_pcap_remove,
 };
 
-RTE_PMD_REGISTER_VDEV(net_pcap, pmd_pcap_drv);
+RTE_PMD_REGISTER_VDEV(net_pcap, pmd_pcap_drv, __LINE__);
 RTE_PMD_REGISTER_ALIAS(net_pcap, eth_pcap);
 RTE_PMD_REGISTER_PARAM_STRING(net_pcap,
 	ETH_PCAP_RX_PCAP_ARG "=<string> "
diff --git a/drivers/net/pfe/pfe_ethdev.c b/drivers/net/pfe/pfe_ethdev.c
index 725ffcb2bc..450ece866f 100644
--- a/drivers/net/pfe/pfe_ethdev.c
+++ b/drivers/net/pfe/pfe_ethdev.c
@@ -1145,6 +1145,6 @@ struct rte_vdev_driver pmd_pfe_drv = {
 	.remove = pmd_pfe_remove,
 };
 
-RTE_PMD_REGISTER_VDEV(PFE_NAME_PMD, pmd_pfe_drv);
+RTE_PMD_REGISTER_VDEV(PFE_NAME_PMD, pmd_pfe_drv, __LINE__);
 RTE_PMD_REGISTER_PARAM_STRING(PFE_NAME_PMD, PFE_VDEV_GEM_ID_ARG "=<int> ");
 RTE_LOG_REGISTER_DEFAULT(pfe_logtype_pmd, NOTICE);
diff --git a/drivers/net/qede/qede_ethdev.c b/drivers/net/qede/qede_ethdev.c
index bee9fa4f60..4096960bdc 100644
--- a/drivers/net/qede/qede_ethdev.c
+++ b/drivers/net/qede/qede_ethdev.c
@@ -2870,10 +2870,10 @@ static struct rte_pci_driver rte_qede_pmd = {
 	.remove = qede_eth_dev_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(net_qede, rte_qede_pmd);
+RTE_PMD_REGISTER_PCI(net_qede, rte_qede_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_qede, pci_id_qede_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_qede, "* igb_uio | uio_pci_generic | vfio-pci");
-RTE_PMD_REGISTER_PCI(net_qede_vf, rte_qedevf_pmd);
+RTE_PMD_REGISTER_PCI(net_qede_vf, rte_qedevf_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_qede_vf, pci_id_qedevf_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_qede_vf, "* igb_uio | vfio-pci");
 RTE_LOG_REGISTER_SUFFIX(qede_logtype_init, init, NOTICE);
diff --git a/drivers/net/r8169/r8169_ethdev.c b/drivers/net/r8169/r8169_ethdev.c
index 4cf5bfb508..82835a35af 100644
--- a/drivers/net/r8169/r8169_ethdev.c
+++ b/drivers/net/r8169/r8169_ethdev.c
@@ -778,7 +778,7 @@ static struct rte_pci_driver rte_r8169_pmd = {
 	.remove    = rtl_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(net_r8169, rte_r8169_pmd);
+RTE_PMD_REGISTER_PCI(net_r8169, rte_r8169_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_r8169, pci_id_r8169_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_r8169, "* igb_uio | uio_pci_generic | vfio-pci");
 
diff --git a/drivers/net/ring/rte_eth_ring.c b/drivers/net/ring/rte_eth_ring.c
index b1085bf390..a5df489ee9 100644
--- a/drivers/net/ring/rte_eth_ring.c
+++ b/drivers/net/ring/rte_eth_ring.c
@@ -823,7 +823,7 @@ static struct rte_vdev_driver pmd_ring_drv = {
 	.remove = rte_pmd_ring_remove,
 };
 
-RTE_PMD_REGISTER_VDEV(net_ring, pmd_ring_drv);
+RTE_PMD_REGISTER_VDEV(net_ring, pmd_ring_drv, __LINE__);
 RTE_PMD_REGISTER_ALIAS(net_ring, eth_ring);
 RTE_PMD_REGISTER_PARAM_STRING(net_ring,
 	ETH_RING_NUMA_NODE_ACTION_ARG "=name:node:action(ATTACH|CREATE)");
diff --git a/drivers/net/sfc/sfc_ethdev.c b/drivers/net/sfc/sfc_ethdev.c
index 82fbdbae9c..5b6bffb4a6 100644
--- a/drivers/net/sfc/sfc_ethdev.c
+++ b/drivers/net/sfc/sfc_ethdev.c
@@ -3614,7 +3614,7 @@ static struct rte_pci_driver sfc_efx_pmd = {
 	.remove = sfc_eth_dev_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(net_sfc_efx, sfc_efx_pmd);
+RTE_PMD_REGISTER_PCI(net_sfc_efx, sfc_efx_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_sfc_efx, pci_id_sfc_efx_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_sfc_efx, "* igb_uio | uio_pci_generic | vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(net_sfc_efx,
diff --git a/drivers/net/softnic/rte_eth_softnic.c b/drivers/net/softnic/rte_eth_softnic.c
index 91a1c3a98e..a546832027 100644
--- a/drivers/net/softnic/rte_eth_softnic.c
+++ b/drivers/net/softnic/rte_eth_softnic.c
@@ -510,7 +510,7 @@ static struct rte_vdev_driver pmd_softnic_drv = {
 	.remove = pmd_remove,
 };
 
-RTE_PMD_REGISTER_VDEV(net_softnic, pmd_softnic_drv);
+RTE_PMD_REGISTER_VDEV(net_softnic, pmd_softnic_drv, __LINE__);
 RTE_PMD_REGISTER_PARAM_STRING(net_softnic,
 	PMD_PARAM_FIRMWARE "=<string> "
 	PMD_PARAM_CONN_PORT "=<uint16> "
diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index 650ddbd706..ed0aeacd5e 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -2565,8 +2565,8 @@ static struct rte_vdev_driver pmd_tap_drv = {
 	.remove = rte_pmd_tap_remove,
 };
 
-RTE_PMD_REGISTER_VDEV(net_tap, pmd_tap_drv);
-RTE_PMD_REGISTER_VDEV(net_tun, pmd_tun_drv);
+RTE_PMD_REGISTER_VDEV(net_tap, pmd_tap_drv, __LINE__);
+RTE_PMD_REGISTER_VDEV(net_tun, pmd_tun_drv, __LINE__);
 RTE_PMD_REGISTER_ALIAS(net_tap, eth_tap);
 RTE_PMD_REGISTER_PARAM_STRING(net_tun,
 			      ETH_TAP_IFACE_ARG "=<string> ");
diff --git a/drivers/net/thunderx/nicvf_ethdev.c b/drivers/net/thunderx/nicvf_ethdev.c
index 4441a90bdf..f5033e25fc 100644
--- a/drivers/net/thunderx/nicvf_ethdev.c
+++ b/drivers/net/thunderx/nicvf_ethdev.c
@@ -2409,7 +2409,7 @@ static struct rte_pci_driver rte_nicvf_pmd = {
 	.remove = nicvf_eth_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(net_thunderx, rte_nicvf_pmd);
+RTE_PMD_REGISTER_PCI(net_thunderx, rte_nicvf_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_thunderx, pci_id_nicvf_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_thunderx, "* igb_uio | uio_pci_generic | vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(net_thunderx, SKIP_DATA_BYTES "=<int>");
diff --git a/drivers/net/txgbe/txgbe_ethdev.c b/drivers/net/txgbe/txgbe_ethdev.c
index ea9faba2c0..d0e7e7a109 100644
--- a/drivers/net/txgbe/txgbe_ethdev.c
+++ b/drivers/net/txgbe/txgbe_ethdev.c
@@ -5665,7 +5665,7 @@ static const struct eth_dev_ops txgbe_eth_dev_ops = {
 	.tx_done_cleanup            = txgbe_dev_tx_done_cleanup,
 };
 
-RTE_PMD_REGISTER_PCI(net_txgbe, rte_txgbe_pmd);
+RTE_PMD_REGISTER_PCI(net_txgbe, rte_txgbe_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_txgbe, pci_id_txgbe_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_txgbe, "* igb_uio | uio_pci_generic | vfio-pci");
 RTE_PMD_REGISTER_PARAM_STRING(net_txgbe,
diff --git a/drivers/net/txgbe/txgbe_ethdev_vf.c b/drivers/net/txgbe/txgbe_ethdev_vf.c
index d075f9d232..b661766839 100644
--- a/drivers/net/txgbe/txgbe_ethdev_vf.c
+++ b/drivers/net/txgbe/txgbe_ethdev_vf.c
@@ -1387,6 +1387,6 @@ static const struct eth_dev_ops txgbevf_eth_dev_ops = {
 	.tx_done_cleanup      = txgbe_dev_tx_done_cleanup,
 };
 
-RTE_PMD_REGISTER_PCI(net_txgbe_vf, rte_txgbevf_pmd);
+RTE_PMD_REGISTER_PCI(net_txgbe_vf, rte_txgbevf_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_txgbe_vf, pci_id_txgbevf_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_txgbe_vf, "* igb_uio | vfio-pci");
diff --git a/drivers/net/vdev_netvsc/vdev_netvsc.c b/drivers/net/vdev_netvsc/vdev_netvsc.c
index f4a84783ce..d36af97e35 100644
--- a/drivers/net/vdev_netvsc/vdev_netvsc.c
+++ b/drivers/net/vdev_netvsc/vdev_netvsc.c
@@ -760,7 +760,7 @@ static struct rte_vdev_driver vdev_netvsc_vdev = {
 	.remove = vdev_netvsc_vdev_remove,
 };
 
-RTE_PMD_REGISTER_VDEV(VDEV_NETVSC_DRIVER, vdev_netvsc_vdev);
+RTE_PMD_REGISTER_VDEV(VDEV_NETVSC_DRIVER, vdev_netvsc_vdev, __LINE__);
 RTE_PMD_REGISTER_ALIAS(VDEV_NETVSC_DRIVER, eth_vdev_netvsc);
 RTE_PMD_REGISTER_PARAM_STRING(net_vdev_netvsc,
 			      VDEV_NETVSC_ARG_IFACE "=<string> "
diff --git a/drivers/net/vhost/rte_eth_vhost.c b/drivers/net/vhost/rte_eth_vhost.c
index 44bf2e3241..0dc54138ab 100644
--- a/drivers/net/vhost/rte_eth_vhost.c
+++ b/drivers/net/vhost/rte_eth_vhost.c
@@ -1772,7 +1772,7 @@ static struct rte_vdev_driver pmd_vhost_drv = {
 	.remove = rte_pmd_vhost_remove,
 };
 
-RTE_PMD_REGISTER_VDEV(net_vhost, pmd_vhost_drv);
+RTE_PMD_REGISTER_VDEV(net_vhost, pmd_vhost_drv, __LINE__);
 RTE_PMD_REGISTER_ALIAS(net_vhost, eth_vhost);
 RTE_PMD_REGISTER_PARAM_STRING(net_vhost,
 	"iface=<ifc> "
diff --git a/drivers/net/virtio/virtio_pci_ethdev.c b/drivers/net/virtio/virtio_pci_ethdev.c
index 9b4b846f8a..a0ba770901 100644
--- a/drivers/net/virtio/virtio_pci_ethdev.c
+++ b/drivers/net/virtio/virtio_pci_ethdev.c
@@ -239,4 +239,4 @@ RTE_INIT(rte_virtio_net_pci_pmd_init)
 
 RTE_PMD_REGISTER_PCI_TABLE(net_virtio, pci_id_virtio_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_virtio, "* igb_uio | uio_pci_generic | vfio-pci");
-RTE_PMD_EXPORT_NAME(net_virtio, __COUNTER__);
+RTE_PMD_EXPORT_NAME(net_virtio, __LINE__);
diff --git a/drivers/net/virtio/virtio_user_ethdev.c b/drivers/net/virtio/virtio_user_ethdev.c
index 747dddeb2e..cb465c5ac3 100644
--- a/drivers/net/virtio/virtio_user_ethdev.c
+++ b/drivers/net/virtio/virtio_user_ethdev.c
@@ -811,7 +811,7 @@ static struct rte_vdev_driver virtio_user_driver = {
 	.dma_unmap = virtio_user_pmd_dma_unmap,
 };
 
-RTE_PMD_REGISTER_VDEV(net_virtio_user, virtio_user_driver);
+RTE_PMD_REGISTER_VDEV(net_virtio_user, virtio_user_driver, __LINE__);
 RTE_PMD_REGISTER_ALIAS(net_virtio_user, virtio_user);
 RTE_PMD_REGISTER_PARAM_STRING(net_virtio_user,
 	"path=<path> "
diff --git a/drivers/net/vmxnet3/vmxnet3_ethdev.c b/drivers/net/vmxnet3/vmxnet3_ethdev.c
index 15ca25b187..e58d5a081b 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethdev.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethdev.c
@@ -1966,7 +1966,7 @@ vmxnet3_dev_rx_queue_intr_disable(struct rte_eth_dev *dev, uint16_t queue_id)
 	return 0;
 }
 
-RTE_PMD_REGISTER_PCI(net_vmxnet3, rte_vmxnet3_pmd);
+RTE_PMD_REGISTER_PCI(net_vmxnet3, rte_vmxnet3_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_vmxnet3, pci_id_vmxnet3_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_vmxnet3, "* igb_uio | uio_pci_generic | vfio-pci");
 RTE_LOG_REGISTER_SUFFIX(vmxnet3_logtype_init, init, NOTICE);
diff --git a/drivers/net/xsc/xsc_ethdev.c b/drivers/net/xsc/xsc_ethdev.c
index 28af9c5d15..fea80febde 100644
--- a/drivers/net/xsc/xsc_ethdev.c
+++ b/drivers/net/xsc/xsc_ethdev.c
@@ -919,7 +919,7 @@ static struct rte_pci_driver xsc_ethdev_pci_driver = {
 	.remove = xsc_ethdev_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(net_xsc, xsc_ethdev_pci_driver);
+RTE_PMD_REGISTER_PCI(net_xsc, xsc_ethdev_pci_driver, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_xsc, xsc_ethdev_pci_id_map);
 RTE_PMD_REGISTER_PARAM_STRING(net_xsc,
 			      XSC_PPH_MODE_ARG "=<x>"
diff --git a/drivers/net/zxdh/zxdh_ethdev.c b/drivers/net/zxdh/zxdh_ethdev.c
index e683cbd616..e24f87a5be 100644
--- a/drivers/net/zxdh/zxdh_ethdev.c
+++ b/drivers/net/zxdh/zxdh_ethdev.c
@@ -2051,7 +2051,7 @@ static struct rte_pci_driver zxdh_pmd = {
 	.remove = zxdh_eth_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(net_zxdh, zxdh_pmd);
+RTE_PMD_REGISTER_PCI(net_zxdh, zxdh_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_zxdh, pci_id_zxdh_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_zxdh, "* vfio-pci");
 RTE_LOG_REGISTER_SUFFIX(zxdh_logtype_driver, driver, NOTICE);
diff --git a/drivers/raw/cnxk_bphy/cnxk_bphy.c b/drivers/raw/cnxk_bphy/cnxk_bphy.c
index 0c26cfbbe6..35610291db 100644
--- a/drivers/raw/cnxk_bphy/cnxk_bphy.c
+++ b/drivers/raw/cnxk_bphy/cnxk_bphy.c
@@ -406,7 +406,7 @@ static struct rte_pci_driver cnxk_bphy_rawdev_pmd = {
 	.remove = bphy_rawdev_remove,
 };
 
-RTE_PMD_REGISTER_PCI(bphy_rawdev_pci_driver, cnxk_bphy_rawdev_pmd);
+RTE_PMD_REGISTER_PCI(bphy_rawdev_pci_driver, cnxk_bphy_rawdev_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(bphy_rawdev_pci_driver, pci_bphy_map);
 RTE_PMD_REGISTER_KMOD_DEP(bphy_rawdev_pci_driver, "vfio-pci");
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_bphy, bphy, INFO);
diff --git a/drivers/raw/cnxk_bphy/cnxk_bphy_cgx.c b/drivers/raw/cnxk_bphy/cnxk_bphy_cgx.c
index c82589baa2..3752e8d83e 100644
--- a/drivers/raw/cnxk_bphy/cnxk_bphy_cgx.c
+++ b/drivers/raw/cnxk_bphy/cnxk_bphy_cgx.c
@@ -379,6 +379,6 @@ static struct rte_pci_driver bphy_cgx_rawdev_pmd = {
 	.remove = cnxk_bphy_cgx_rawdev_remove,
 };
 
-RTE_PMD_REGISTER_PCI(cnxk_bphy_cgx_rawdev_pci_driver, bphy_cgx_rawdev_pmd);
+RTE_PMD_REGISTER_PCI(cnxk_bphy_cgx_rawdev_pci_driver, bphy_cgx_rawdev_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(cnxk_bphy_cgx_rawdev_pci_driver, cnxk_bphy_cgx_map);
 RTE_PMD_REGISTER_KMOD_DEP(cnxk_bphy_cgx_rawdev_pci_driver, "vfio-pci");
diff --git a/drivers/raw/cnxk_gpio/cnxk_gpio.c b/drivers/raw/cnxk_gpio/cnxk_gpio.c
index 329ac28a27..4c2916d3e2 100644
--- a/drivers/raw/cnxk_gpio/cnxk_gpio.c
+++ b/drivers/raw/cnxk_gpio/cnxk_gpio.c
@@ -847,7 +847,7 @@ static struct rte_vdev_driver cnxk_gpio_drv = {
 	.remove = cnxk_gpio_remove,
 };
 
-RTE_PMD_REGISTER_VDEV(cnxk_gpio, cnxk_gpio_drv);
+RTE_PMD_REGISTER_VDEV(cnxk_gpio, cnxk_gpio_drv, __LINE__);
 RTE_PMD_REGISTER_PARAM_STRING(cnxk_gpio,
 		"gpiochip=<int> "
 		"allowlist=<list>");
diff --git a/drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c b/drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c
index 60c2080740..a4f272f029 100644
--- a/drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c
+++ b/drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c
@@ -267,7 +267,7 @@ static struct rte_pci_driver cnxk_rvu_lf_rawdev_pmd = {
 	.remove = rvu_lf_remove,
 };
 
-RTE_PMD_REGISTER_PCI(rvu_lf_rawdev_pci_driver, cnxk_rvu_lf_rawdev_pmd);
+RTE_PMD_REGISTER_PCI(rvu_lf_rawdev_pci_driver, cnxk_rvu_lf_rawdev_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(rvu_lf_rawdev_pci_driver, pci_rvu_lf_map);
 RTE_PMD_REGISTER_KMOD_DEP(rvu_lf_rawdev_pci_driver, "vfio-pci");
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_rvu_lf, rvu_lf, INFO);
diff --git a/drivers/raw/dpaa2_cmdif/dpaa2_cmdif.c b/drivers/raw/dpaa2_cmdif/dpaa2_cmdif.c
index 34a3c4f6af..5051236743 100644
--- a/drivers/raw/dpaa2_cmdif/dpaa2_cmdif.c
+++ b/drivers/raw/dpaa2_cmdif/dpaa2_cmdif.c
@@ -287,5 +287,5 @@ static struct rte_vdev_driver dpaa2_cmdif_drv = {
 	.remove = dpaa2_cmdif_remove
 };
 
-RTE_PMD_REGISTER_VDEV(DPAA2_CMDIF_PMD_NAME, dpaa2_cmdif_drv);
+RTE_PMD_REGISTER_VDEV(DPAA2_CMDIF_PMD_NAME, dpaa2_cmdif_drv, __LINE__);
 RTE_LOG_REGISTER(dpaa2_cmdif_logtype, pmd.raw.dpaa2.cmdif, INFO);
diff --git a/drivers/raw/gdtc/gdtc_rawdev.c b/drivers/raw/gdtc/gdtc_rawdev.c
index ee83a67bad..bcc25f36ac 100644
--- a/drivers/raw/gdtc/gdtc_rawdev.c
+++ b/drivers/raw/gdtc/gdtc_rawdev.c
@@ -913,6 +913,6 @@ static struct rte_pci_driver zxdh_gdma_rawdev_pmd = {
 	.remove = zxdh_gdma_rawdev_remove,
 };
 
-RTE_PMD_REGISTER_PCI(zxdh_gdma_rawdev_pci_driver, zxdh_gdma_rawdev_pmd);
+RTE_PMD_REGISTER_PCI(zxdh_gdma_rawdev_pci_driver, zxdh_gdma_rawdev_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(zxdh_gdma_rawdev_pci_driver, zxdh_gdma_rawdev_map);
 RTE_LOG_REGISTER_DEFAULT(zxdh_gdma_rawdev_logtype, NOTICE);
diff --git a/drivers/raw/ifpga/afu_pmd_core.c b/drivers/raw/ifpga/afu_pmd_core.c
index 3ab1f47ac1..274f19166c 100644
--- a/drivers/raw/ifpga/afu_pmd_core.c
+++ b/drivers/raw/ifpga/afu_pmd_core.c
@@ -391,7 +391,7 @@ static struct rte_afu_driver afu_pmd = {
 	.remove = afu_rawdev_remove
 };
 
-RTE_PMD_REGISTER_AFU(afu_rawdev_driver, afu_pmd);
+RTE_PMD_REGISTER_AFU(afu_rawdev_driver, afu_pmd, __LINE__);
 
 static void update_uuid_map(void)
 {
diff --git a/drivers/raw/ifpga/ifpga_rawdev.c b/drivers/raw/ifpga/ifpga_rawdev.c
index 5b9b596435..cf04fdcd4d 100644
--- a/drivers/raw/ifpga/ifpga_rawdev.c
+++ b/drivers/raw/ifpga/ifpga_rawdev.c
@@ -1687,7 +1687,7 @@ static struct rte_pci_driver rte_ifpga_rawdev_pmd = {
 	.remove    = ifpga_rawdev_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(ifpga_rawdev_pci_driver, rte_ifpga_rawdev_pmd);
+RTE_PMD_REGISTER_PCI(ifpga_rawdev_pci_driver, rte_ifpga_rawdev_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(ifpga_rawdev_pci_driver, rte_ifpga_rawdev_pmd);
 RTE_PMD_REGISTER_KMOD_DEP(ifpga_rawdev_pci_driver, "* igb_uio | uio_pci_generic | vfio-pci");
 RTE_LOG_REGISTER_DEFAULT(ifpga_rawdev_logtype, NOTICE);
@@ -1897,7 +1897,7 @@ static struct rte_vdev_driver ifpga_cfg_driver = {
 	.remove = ifpga_cfg_remove,
 };
 
-RTE_PMD_REGISTER_VDEV(ifpga_rawdev_cfg, ifpga_cfg_driver);
+RTE_PMD_REGISTER_VDEV(ifpga_rawdev_cfg, ifpga_cfg_driver, __LINE__);
 RTE_PMD_REGISTER_ALIAS(ifpga_rawdev_cfg, ifpga_cfg);
 RTE_PMD_REGISTER_PARAM_STRING(ifpga_rawdev_cfg,
 	"ifpga=<string> "
diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index 0ed4c14592..289abbd2d7 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -1550,7 +1550,7 @@ static struct rte_pci_driver rte_ntb_pmd = {
 	.remove = ntb_remove,
 };
 
-RTE_PMD_REGISTER_PCI(raw_ntb, rte_ntb_pmd);
+RTE_PMD_REGISTER_PCI(raw_ntb, rte_ntb_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(raw_ntb, pci_id_ntb_map);
 RTE_PMD_REGISTER_KMOD_DEP(raw_ntb, "* igb_uio | uio_pci_generic | vfio-pci");
 RTE_LOG_REGISTER_DEFAULT(ntb_logtype, INFO);
diff --git a/drivers/raw/skeleton/skeleton_rawdev.c b/drivers/raw/skeleton/skeleton_rawdev.c
index 6e99d35536..2717ce3d06 100644
--- a/drivers/raw/skeleton/skeleton_rawdev.c
+++ b/drivers/raw/skeleton/skeleton_rawdev.c
@@ -774,5 +774,5 @@ static struct rte_vdev_driver skeleton_pmd_drv = {
 	.remove = skeleton_rawdev_remove
 };
 
-RTE_PMD_REGISTER_VDEV(SKELETON_PMD_RAWDEV_NAME, skeleton_pmd_drv);
+RTE_PMD_REGISTER_VDEV(SKELETON_PMD_RAWDEV_NAME, skeleton_pmd_drv, __LINE__);
 RTE_LOG_REGISTER_DEFAULT(skeleton_pmd_logtype, INFO);
diff --git a/drivers/regex/cn9k/cn9k_regexdev.c b/drivers/regex/cn9k/cn9k_regexdev.c
index 5abc7e22bc..3fdfad40dd 100644
--- a/drivers/regex/cn9k/cn9k_regexdev.c
+++ b/drivers/regex/cn9k/cn9k_regexdev.c
@@ -930,5 +930,5 @@ static struct rte_pci_driver cn9k_regexdev_pmd = {
 };
 
 
-RTE_PMD_REGISTER_PCI(REGEXDEV_NAME_CN9K_PMD, cn9k_regexdev_pmd);
+RTE_PMD_REGISTER_PCI(REGEXDEV_NAME_CN9K_PMD, cn9k_regexdev_pmd, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(REGEXDEV_NAME_CN9K_PMD, pci_id_ree_table);
diff --git a/drivers/regex/mlx5/mlx5_regex.c b/drivers/regex/mlx5/mlx5_regex.c
index 4ed62b538b..238676586c 100644
--- a/drivers/regex/mlx5/mlx5_regex.c
+++ b/drivers/regex/mlx5/mlx5_regex.c
@@ -183,6 +183,6 @@ RTE_INIT(rte_mlx5_regex_init)
 }
 
 RTE_LOG_REGISTER_DEFAULT(mlx5_regex_logtype, NOTICE)
-RTE_PMD_EXPORT_NAME(MLX5_REGEX_DRIVER_NAME, __COUNTER__);
+RTE_PMD_EXPORT_NAME(MLX5_REGEX_DRIVER_NAME, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(MLX5_REGEX_DRIVER_NAME, mlx5_regex_pci_id_map);
 RTE_PMD_REGISTER_KMOD_DEP(MLX5_REGEX_DRIVER_NAME, "* ib_uverbs & mlx5_core & mlx5_ib");
diff --git a/drivers/vdpa/ifc/ifcvf_vdpa.c b/drivers/vdpa/ifc/ifcvf_vdpa.c
index 65de383b95..ff2e67ec0c 100644
--- a/drivers/vdpa/ifc/ifcvf_vdpa.c
+++ b/drivers/vdpa/ifc/ifcvf_vdpa.c
@@ -1886,6 +1886,6 @@ static struct rte_pci_driver rte_ifcvf_vdpa = {
 	.remove = ifcvf_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(net_ifcvf, rte_ifcvf_vdpa);
+RTE_PMD_REGISTER_PCI(net_ifcvf, rte_ifcvf_vdpa, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_ifcvf, pci_id_ifcvf_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_ifcvf, "* vfio-pci");
diff --git a/drivers/vdpa/mlx5/mlx5_vdpa.c b/drivers/vdpa/mlx5/mlx5_vdpa.c
index 98c39a5e64..3450634ea9 100644
--- a/drivers/vdpa/mlx5/mlx5_vdpa.c
+++ b/drivers/vdpa/mlx5/mlx5_vdpa.c
@@ -1003,6 +1003,6 @@ RTE_INIT(rte_mlx5_vdpa_init)
 		mlx5_class_driver_register(&mlx5_vdpa_driver);
 }
 
-RTE_PMD_EXPORT_NAME(MLX5_VDPA_DRIVER_NAME, __COUNTER__);
+RTE_PMD_EXPORT_NAME(MLX5_VDPA_DRIVER_NAME, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(MLX5_VDPA_DRIVER_NAME, mlx5_vdpa_pci_id_map);
 RTE_PMD_REGISTER_KMOD_DEP(MLX5_VDPA_DRIVER_NAME, "* ib_uverbs & mlx5_core & mlx5_ib");
diff --git a/drivers/vdpa/sfc/sfc_vdpa.c b/drivers/vdpa/sfc/sfc_vdpa.c
index eda111954f..d8350fa4fb 100644
--- a/drivers/vdpa/sfc/sfc_vdpa.c
+++ b/drivers/vdpa/sfc/sfc_vdpa.c
@@ -358,7 +358,7 @@ static struct rte_pci_driver rte_sfc_vdpa = {
 	.remove = sfc_vdpa_pci_remove,
 };
 
-RTE_PMD_REGISTER_PCI(net_sfc_vdpa, rte_sfc_vdpa);
+RTE_PMD_REGISTER_PCI(net_sfc_vdpa, rte_sfc_vdpa, __LINE__);
 RTE_PMD_REGISTER_PCI_TABLE(net_sfc_vdpa, pci_id_sfc_vdpa_efx_map);
 RTE_PMD_REGISTER_KMOD_DEP(net_sfc_vdpa, "* vfio-pci");
 RTE_LOG_REGISTER_SUFFIX(sfc_vdpa_logtype_driver, driver, NOTICE);
diff --git a/lib/eal/include/rte_dev.h b/lib/eal/include/rte_dev.h
index 738400e8d1..39698f934f 100644
--- a/lib/eal/include/rte_dev.h
+++ b/lib/eal/include/rte_dev.h
@@ -232,21 +232,18 @@ int rte_dev_remove(struct rte_device *dev);
  */
 typedef int (*rte_dev_cmp_t)(const struct rte_device *dev, const void *data);
 
-#define RTE_PMD_EXPORT_NAME_ARRAY(n, idx) n##idx[]
+#define RTE_PMD_COMPOST_NAME(n, idx) n##idx
 
 #define RTE_PMD_EXPORT_NAME(name, idx) \
-static const char RTE_PMD_EXPORT_NAME_ARRAY(this_pmd_name, idx) \
-__rte_used = RTE_STR(name)
+RTE_INCLUDE(const char, RTE_PMD_COMPOST_NAME(this_pmd_name, idx))[] = RTE_STR(name)
 
 #define DRV_EXP_TAG(name, tag) __##name##_##tag
 
 #define RTE_PMD_REGISTER_PCI_TABLE(name, table) \
-static const char DRV_EXP_TAG(name, pci_tbl_export)[] __rte_used = \
-RTE_STR(table)
+RTE_INCLUDE(const char, DRV_EXP_TAG(name, pci_tbl_export))[] = RTE_STR(table)
 
 #define RTE_PMD_REGISTER_PARAM_STRING(name, str) \
-static const char DRV_EXP_TAG(name, param_string_export)[] \
-__rte_used = str
+RTE_INCLUDE(const char, DRV_EXP_TAG(name, param_string_export))[] = str
 
 /**
  * Advertise the list of kernel modules required to run this driver
@@ -270,8 +267,7 @@ __rte_used = str
  * - "* igb_uio | uio_pci_generic | vfio"
  */
 #define RTE_PMD_REGISTER_KMOD_DEP(name, str) \
-static const char DRV_EXP_TAG(name, kmod_dep_export)[] \
-__rte_used = str
+RTE_INCLUDE(const char, DRV_EXP_TAG(name, kmod_dep_export))[] = str
 
 /**
  * Iteration context.
-- 
2.49.0.vfs.0.0

