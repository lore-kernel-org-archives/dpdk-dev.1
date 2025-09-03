Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0859CA1007
	for <dpdk-dev@archiver.kernel.org>; Wed,  3 Sep 2025 02:06:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D8A240693;
	Wed,  3 Sep 2025 04:05:57 +0200 (CEST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mails.dpdk.org (Postfix) with ESMTP id E6E08402BC
 for <dev@dpdk.org>; Wed,  3 Sep 2025 04:05:52 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4cGm8q0YHSz1R9N0;
 Wed,  3 Sep 2025 10:02:51 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 29C99180044;
 Wed,  3 Sep 2025 10:05:50 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 3 Sep 2025 10:05:49 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <david.marchand@redhat.com>,
 <stephen@networkplumber.org>
CC: <dev@dpdk.org>
Subject: [PATCH v5 4/5] drivers: add semicolon when export any symbol
Date: Wed, 3 Sep 2025 10:05:46 +0800
Message-ID: <20250903020547.12347-5-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20250903020547.12347-1-fengchengwen@huawei.com>
References: <20250828025957.30917-1-fengchengwen@huawei.com>
 <20250903020547.12347-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

Currently, the RTE_EXPORT_INTERNAL_SYMBOL, RTE_EXPORT_SYMBOL and
RTE_EXPORT_EXPERIMENTAL_SYMBOL are placed at the beginning of APIs,
but don't end with a semicolon. As a result, some IDEs cannot identify
the APIs and cannot quickly jump to the definition.

A semicolon is added to the end of above RTE_EXPORT_XXX_SYMBOL in this
commit.

And also define RTE_EXPORT_XXX_SYMBOL as "extern int
dummy_rte_export_symbol" to fix CI error: -Werror -Wextra-semi for mlx5
driver.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 drivers/baseband/acc/rte_acc100_pmd.c         |    2 +-
 .../fpga_5gnr_fec/rte_fpga_5gnr_fec.c         |    2 +-
 drivers/baseband/fpga_lte_fec/fpga_lte_fec.c  |    2 +-
 drivers/bus/auxiliary/auxiliary_common.c      |    4 +-
 drivers/bus/cdx/cdx.c                         |    8 +-
 drivers/bus/cdx/cdx_vfio.c                    |    8 +-
 drivers/bus/dpaa/dpaa_bus.c                   |   18 +-
 drivers/bus/dpaa/dpaa_bus_base_symbols.c      |  186 +--
 drivers/bus/fslmc/fslmc_bus.c                 |    8 +-
 drivers/bus/fslmc/fslmc_vfio.c                |   24 +-
 drivers/bus/fslmc/mc/dpbp.c                   |   12 +-
 drivers/bus/fslmc/mc/dpci.c                   |    6 +-
 drivers/bus/fslmc/mc/dpcon.c                  |   12 +-
 drivers/bus/fslmc/mc/dpdmai.c                 |   16 +-
 drivers/bus/fslmc/mc/dpio.c                   |   26 +-
 drivers/bus/fslmc/mc/dpmng.c                  |    4 +-
 drivers/bus/fslmc/mc/mc_sys.c                 |    2 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c      |    6 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpci.c      |    4 +-
 drivers/bus/fslmc/portal/dpaa2_hw_dpio.c      |   22 +-
 drivers/bus/fslmc/qbman/qbman_debug.c         |    4 +-
 drivers/bus/fslmc/qbman/qbman_portal.c        |   82 +-
 drivers/bus/ifpga/ifpga_bus.c                 |    6 +-
 drivers/bus/pci/bsd/pci.c                     |   20 +-
 drivers/bus/pci/linux/pci.c                   |   20 +-
 drivers/bus/pci/pci_common.c                  |   20 +-
 drivers/bus/pci/windows/pci.c                 |   20 +-
 drivers/bus/platform/platform.c               |    4 +-
 drivers/bus/uacce/uacce.c                     |   18 +-
 drivers/bus/vdev/vdev.c                       |   12 +-
 drivers/bus/vmbus/linux/vmbus_bus.c           |   12 +-
 drivers/bus/vmbus/vmbus_channel.c             |   26 +-
 drivers/bus/vmbus/vmbus_common.c              |    6 +-
 drivers/common/cnxk/cnxk_security.c           |   24 +-
 drivers/common/cnxk/cnxk_utils.c              |    2 +-
 drivers/common/cnxk/roc_platform.c            |   36 +-
 .../common/cnxk/roc_platform_base_symbols.c   | 1084 ++++++++---------
 drivers/common/cpt/cpt_fpm_tables.c           |    4 +-
 drivers/common/cpt/cpt_pmd_ops_helper.c       |    6 +-
 drivers/common/dpaax/caamflib.c               |    2 +-
 drivers/common/dpaax/dpaa_of.c                |   24 +-
 drivers/common/dpaax/dpaax_iova_table.c       |   12 +-
 drivers/common/ionic/ionic_common_uio.c       |    8 +-
 .../common/mlx5/linux/mlx5_common_auxiliary.c |    2 +-
 drivers/common/mlx5/linux/mlx5_common_os.c    |   20 +-
 drivers/common/mlx5/linux/mlx5_common_verbs.c |    6 +-
 drivers/common/mlx5/linux/mlx5_glue.c         |    2 +-
 drivers/common/mlx5/linux/mlx5_nl.c           |   42 +-
 drivers/common/mlx5/mlx5_common.c             |   18 +-
 drivers/common/mlx5/mlx5_common_devx.c        |   18 +-
 drivers/common/mlx5/mlx5_common_mp.c          |   16 +-
 drivers/common/mlx5/mlx5_common_mr.c          |   22 +-
 drivers/common/mlx5/mlx5_common_pci.c         |    4 +-
 drivers/common/mlx5/mlx5_common_utils.c       |   22 +-
 drivers/common/mlx5/mlx5_devx_cmds.c          |  102 +-
 drivers/common/mlx5/mlx5_malloc.c             |    8 +-
 drivers/common/mlx5/windows/mlx5_common_os.c  |   12 +-
 drivers/common/mlx5/windows/mlx5_glue.c       |    2 +-
 drivers/common/mvep/mvep_common.c             |    4 +-
 drivers/common/nfp/nfp_common.c               |   14 +-
 drivers/common/nfp/nfp_common_pci.c           |    2 +-
 drivers/common/nfp/nfp_dev.c                  |    2 +-
 drivers/common/nitrox/nitrox_device.c         |    2 +-
 drivers/common/nitrox/nitrox_logs.c           |    2 +-
 drivers/common/nitrox/nitrox_qp.c             |    4 +-
 drivers/common/octeontx/octeontx_mbox.c       |   12 +-
 drivers/common/sfc_efx/sfc_base_symbols.c     |  542 ++++-----
 drivers/common/sfc_efx/sfc_efx.c              |    4 +-
 drivers/common/sfc_efx/sfc_efx_mcdi.c         |    4 +-
 drivers/crypto/cnxk/cn10k_cryptodev_ops.c     |   14 +-
 drivers/crypto/cnxk/cn20k_cryptodev_ops.c     |   12 +-
 drivers/crypto/cnxk/cn9k_cryptodev_ops.c      |    4 +-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c      |   14 +-
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c   |    4 +-
 drivers/crypto/dpaa_sec/dpaa_sec.c            |    4 +-
 drivers/crypto/octeontx/otx_cryptodev_ops.c   |    4 +-
 .../scheduler/rte_cryptodev_scheduler.c       |   20 +-
 drivers/dma/cnxk/cnxk_dmadev_fp.c             |    8 +-
 drivers/event/cnxk/cnxk_worker.c              |    4 +-
 drivers/event/dlb2/rte_pmd_dlb2.c             |    4 +-
 drivers/mempool/cnxk/cn10k_hwpool_ops.c       |    6 +-
 drivers/mempool/dpaa/dpaa_mempool.c           |    4 +-
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c      |   12 +-
 drivers/net/atlantic/rte_pmd_atlantic.c       |   12 +-
 drivers/net/bnxt/rte_pmd_bnxt.c               |   32 +-
 drivers/net/bonding/rte_eth_bond_8023ad.c     |   24 +-
 drivers/net/bonding/rte_eth_bond_api.c        |   30 +-
 drivers/net/cnxk/cnxk_ethdev.c                |    6 +-
 drivers/net/cnxk/cnxk_ethdev_sec.c            |   18 +-
 drivers/net/dpaa/dpaa_ethdev.c                |    6 +-
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c        |    2 +-
 drivers/net/dpaa2/base/dpaa2_tlu_hash.c       |    2 +-
 drivers/net/dpaa2/dpaa2_ethdev.c              |   14 +-
 drivers/net/dpaa2/dpaa2_mux.c                 |    6 +-
 drivers/net/dpaa2/dpaa2_rxtx.c                |    2 +-
 drivers/net/intel/i40e/rte_pmd_i40e.c         |   78 +-
 drivers/net/intel/iavf/iavf_base_symbols.c    |   14 +-
 drivers/net/intel/iavf/iavf_rxtx.c            |   16 +-
 drivers/net/intel/ice/ice_diagnose.c          |    6 +-
 drivers/net/intel/idpf/idpf_common_device.c   |   20 +-
 drivers/net/intel/idpf/idpf_common_rxtx.c     |   46 +-
 .../net/intel/idpf/idpf_common_rxtx_avx2.c    |    4 +-
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  |   10 +-
 drivers/net/intel/idpf/idpf_common_virtchnl.c |   58 +-
 drivers/net/intel/ipn3ke/ipn3ke_ethdev.c      |    2 +-
 drivers/net/intel/ixgbe/rte_pmd_ixgbe.c       |   74 +-
 drivers/net/mlx5/mlx5.c                       |    2 +-
 drivers/net/mlx5/mlx5_flow.c                  |    8 +-
 drivers/net/mlx5/mlx5_rx.c                    |    4 +-
 drivers/net/mlx5/mlx5_rxq.c                   |    4 +-
 drivers/net/mlx5/mlx5_tx.c                    |    2 +-
 drivers/net/mlx5/mlx5_txq.c                   |    6 +-
 drivers/net/octeontx/octeontx_ethdev.c        |    2 +-
 drivers/net/ring/rte_eth_ring.c               |    4 +-
 drivers/net/softnic/rte_eth_softnic.c         |    2 +-
 drivers/net/softnic/rte_eth_softnic_thread.c  |    2 +-
 drivers/net/vhost/rte_eth_vhost.c             |    4 +-
 drivers/power/kvm_vm/guest_channel.c          |    4 +-
 drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c         |   20 +-
 drivers/raw/ifpga/rte_pmd_ifpga.c             |   22 +-
 lib/eal/common/eal_export.h                   |    6 +-
 121 files changed, 1700 insertions(+), 1700 deletions(-)

diff --git a/drivers/baseband/acc/rte_acc100_pmd.c b/drivers/baseband/acc/rte_acc100_pmd.c
index b7f02f56e1..7160a5dc96 100644
--- a/drivers/baseband/acc/rte_acc100_pmd.c
+++ b/drivers/baseband/acc/rte_acc100_pmd.c
@@ -4636,7 +4636,7 @@ acc100_configure(const char *dev_name, struct rte_acc_conf *conf)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_acc_configure, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_acc_configure, 22.11);
 int
 rte_acc_configure(const char *dev_name, struct rte_acc_conf *conf)
 {
diff --git a/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c b/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c
index 82cf98da5d..4bc6acfd9f 100644
--- a/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c
+++ b/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c
@@ -3367,7 +3367,7 @@ static int agx100_configure(const char *dev_name, const struct rte_fpga_5gnr_fec
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fpga_5gnr_fec_configure, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fpga_5gnr_fec_configure, 20.11);
 int rte_fpga_5gnr_fec_configure(const char *dev_name, const struct rte_fpga_5gnr_fec_conf *conf)
 {
 	struct rte_bbdev *bbdev = rte_bbdev_get_named_dev(dev_name);
diff --git a/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c b/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c
index 4723a51dcf..73c98afd9a 100644
--- a/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c
+++ b/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c
@@ -2453,7 +2453,7 @@ set_default_fpga_conf(struct rte_fpga_lte_fec_conf *def_conf)
 }
 
 /* Initial configuration of FPGA LTE FEC device */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fpga_lte_fec_configure, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_fpga_lte_fec_configure, 20.11);
 int
 rte_fpga_lte_fec_configure(const char *dev_name,
 		const struct rte_fpga_lte_fec_conf *conf)
diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index ac766e283e..15f4440061 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -261,7 +261,7 @@ auxiliary_parse(const char *name, void *addr)
 }
 
 /* Register a driver */
-RTE_EXPORT_INTERNAL_SYMBOL(rte_auxiliary_register)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_auxiliary_register);
 void
 rte_auxiliary_register(struct rte_auxiliary_driver *driver)
 {
@@ -269,7 +269,7 @@ rte_auxiliary_register(struct rte_auxiliary_driver *driver)
 }
 
 /* Unregister a driver */
-RTE_EXPORT_INTERNAL_SYMBOL(rte_auxiliary_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_auxiliary_unregister);
 void
 rte_auxiliary_unregister(struct rte_auxiliary_driver *driver)
 {
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index 729d54337c..d492e08931 100644
--- a/drivers/bus/cdx/cdx.c
+++ b/drivers/bus/cdx/cdx.c
@@ -140,13 +140,13 @@ cdx_get_kernel_driver_by_path(const char *filename, char *driver_name,
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_map_device)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_map_device);
 int rte_cdx_map_device(struct rte_cdx_device *dev)
 {
 	return cdx_vfio_map_resource(dev);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_unmap_device)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_unmap_device);
 void rte_cdx_unmap_device(struct rte_cdx_device *dev)
 {
 	cdx_vfio_unmap_resource(dev);
@@ -481,7 +481,7 @@ cdx_parse(const char *name, void *addr)
 }
 
 /* register a driver */
-RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_register)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_register);
 void
 rte_cdx_register(struct rte_cdx_driver *driver)
 {
@@ -490,7 +490,7 @@ rte_cdx_register(struct rte_cdx_driver *driver)
 }
 
 /* unregister a driver */
-RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_unregister);
 void
 rte_cdx_unregister(struct rte_cdx_driver *driver)
 {
diff --git a/drivers/bus/cdx/cdx_vfio.c b/drivers/bus/cdx/cdx_vfio.c
index 37e0c424d4..ef7e33145d 100644
--- a/drivers/bus/cdx/cdx_vfio.c
+++ b/drivers/bus/cdx/cdx_vfio.c
@@ -551,7 +551,7 @@ cdx_vfio_map_resource(struct rte_cdx_device *dev)
 		return cdx_vfio_map_resource_secondary(dev);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_vfio_intr_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_vfio_intr_enable);
 int
 rte_cdx_vfio_intr_enable(const struct rte_intr_handle *intr_handle)
 {
@@ -586,7 +586,7 @@ rte_cdx_vfio_intr_enable(const struct rte_intr_handle *intr_handle)
 }
 
 /* disable MSI interrupts */
-RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_vfio_intr_disable)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_vfio_intr_disable);
 int
 rte_cdx_vfio_intr_disable(const struct rte_intr_handle *intr_handle)
 {
@@ -614,7 +614,7 @@ rte_cdx_vfio_intr_disable(const struct rte_intr_handle *intr_handle)
 }
 
 /* Enable Bus Mastering */
-RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_vfio_bm_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_vfio_bm_enable);
 int
 rte_cdx_vfio_bm_enable(struct rte_cdx_device *dev)
 {
@@ -660,7 +660,7 @@ rte_cdx_vfio_bm_enable(struct rte_cdx_device *dev)
 }
 
 /* Disable Bus Mastering */
-RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_vfio_bm_disable)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_cdx_vfio_bm_disable);
 int
 rte_cdx_vfio_bm_disable(struct rte_cdx_device *dev)
 {
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 5420733019..fd391dbb8e 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -60,19 +60,19 @@ struct netcfg_info *dpaa_netcfg;
 /* define a variable to hold the portal_key, once created.*/
 static pthread_key_t dpaa_portal_key;
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa_svr_family)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_svr_family);
 unsigned int dpaa_svr_family;
 
 #define FSL_DPAA_BUS_NAME	dpaa_bus
 
-RTE_EXPORT_INTERNAL_SYMBOL(per_lcore_dpaa_io)
+RTE_EXPORT_INTERNAL_SYMBOL(per_lcore_dpaa_io);
 RTE_DEFINE_PER_LCORE(struct dpaa_portal *, dpaa_io);
 
 #define DPAA_SEQN_DYNFIELD_NAME "dpaa_seqn_dynfield"
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa_seqn_dynfield_offset)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_seqn_dynfield_offset);
 int dpaa_seqn_dynfield_offset = -1;
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_eth_port_cfg)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_eth_port_cfg);
 struct fm_eth_port_cfg *
 dpaa_get_eth_port_cfg(int dev_id)
 {
@@ -320,7 +320,7 @@ dpaa_clean_device_list(void)
 	}
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa_portal_init)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa_portal_init);
 int rte_dpaa_portal_init(void *arg)
 {
 	static const struct rte_mbuf_dynfield dpaa_seqn_dynfield_desc = {
@@ -399,7 +399,7 @@ int rte_dpaa_portal_init(void *arg)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa_portal_fq_init)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa_portal_fq_init);
 int
 rte_dpaa_portal_fq_init(void *arg, struct qman_fq *fq)
 {
@@ -428,7 +428,7 @@ rte_dpaa_portal_fq_init(void *arg, struct qman_fq *fq)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa_portal_fq_close)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa_portal_fq_close);
 int rte_dpaa_portal_fq_close(struct qman_fq *fq)
 {
 	return fsl_qman_fq_portal_destroy(fq->qp);
@@ -556,7 +556,7 @@ rte_dpaa_bus_scan(void)
 }
 
 /* register a dpaa bus based dpaa driver */
-RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa_driver_register)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa_driver_register);
 void
 rte_dpaa_driver_register(struct rte_dpaa_driver *driver)
 {
@@ -568,7 +568,7 @@ rte_dpaa_driver_register(struct rte_dpaa_driver *driver)
 }
 
 /* un-register a dpaa bus based dpaa driver */
-RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa_driver_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa_driver_unregister);
 void
 rte_dpaa_driver_unregister(struct rte_dpaa_driver *driver)
 {
diff --git a/drivers/bus/dpaa/dpaa_bus_base_symbols.c b/drivers/bus/dpaa/dpaa_bus_base_symbols.c
index 522cdca27e..d829d48381 100644
--- a/drivers/bus/dpaa/dpaa_bus_base_symbols.c
+++ b/drivers/bus/dpaa/dpaa_bus_base_symbols.c
@@ -5,96 +5,96 @@
 #include <eal_export.h>
 
 /* Symbols from the base driver are exported separately below. */
-RTE_EXPORT_INTERNAL_SYMBOL(fman_ip_rev)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_dealloc_bufs_mask_hi)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_dealloc_bufs_mask_lo)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_set_mcast_filter_table)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_reset_mcast_filter_table)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_clear_mac_addr)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_add_mac_addr)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_stats_get)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_stats_get_all)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_stats_reset)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_bmi_stats_enable)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_bmi_stats_disable)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_bmi_stats_get_all)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_bmi_stats_reset)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_promiscuous_enable)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_promiscuous_disable)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_enable_rx)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_disable_rx)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_get_rx_status)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_loopback_enable)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_loopback_disable)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_set_bp)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_get_fc_threshold)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_set_fc_threshold)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_get_fc_quanta)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_set_fc_quanta)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_get_fdoff)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_set_err_fqid)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_set_ic_params)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_set_fdoff)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_set_maxfrm)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_get_maxfrm)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_get_sg_enable)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_set_sg)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_discard_rx_errors)
-RTE_EXPORT_INTERNAL_SYMBOL(fman_if_receive_rx_errors)
-RTE_EXPORT_INTERNAL_SYMBOL(netcfg_acquire)
-RTE_EXPORT_INTERNAL_SYMBOL(netcfg_release)
-RTE_EXPORT_INTERNAL_SYMBOL(bman_new_pool)
-RTE_EXPORT_INTERNAL_SYMBOL(bman_free_pool)
-RTE_EXPORT_INTERNAL_SYMBOL(bman_get_params)
-RTE_EXPORT_INTERNAL_SYMBOL(bman_release)
-RTE_EXPORT_INTERNAL_SYMBOL(bman_acquire)
-RTE_EXPORT_INTERNAL_SYMBOL(bman_query_free_buffers)
-RTE_EXPORT_INTERNAL_SYMBOL(bman_thread_irq)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_fqid_range)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_reserve_fqid_range)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_pool_range)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_cgrid_range)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_release_cgrid_range)
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa_intr_enable)
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa_intr_disable)
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_ioctl_version_number)
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_link_status)
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa_update_link_status)
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa_update_link_speed)
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa_restart_link_autoneg)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_set_fq_lookup_table)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_ern_register_cb)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_ern_poll_free)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_irqsource_add)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_fq_portal_irqsource_add)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_irqsource_remove)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_fq_portal_irqsource_remove)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_portal_poll_rx)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_clear_irq)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_portal_dequeue)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_dequeue)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_dqrr_consume)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_static_dequeue_add)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_dca_index)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_create_fq)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_fq_fqid)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_fq_state)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_init_fq)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_retire_fq)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_oos_fq)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_query_fq_np)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_query_fq_frm_cnt)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_set_vdq)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_volatile_dequeue)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_enqueue)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_enqueue_multi)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_enqueue_multi_fq)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_modify_cgr)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_create_cgr)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_delete_cgr)
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_qm_channel_caam)
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_qm_channel_pool)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_thread_fd)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_thread_irq)
-RTE_EXPORT_INTERNAL_SYMBOL(qman_fq_portal_thread_irq)
-RTE_EXPORT_INTERNAL_SYMBOL(fsl_qman_fq_portal_create)
+RTE_EXPORT_INTERNAL_SYMBOL(fman_ip_rev);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_dealloc_bufs_mask_hi);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_dealloc_bufs_mask_lo);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_set_mcast_filter_table);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_reset_mcast_filter_table);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_clear_mac_addr);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_add_mac_addr);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_stats_get);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_stats_get_all);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_stats_reset);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_bmi_stats_enable);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_bmi_stats_disable);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_bmi_stats_get_all);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_bmi_stats_reset);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_promiscuous_enable);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_promiscuous_disable);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_enable_rx);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_disable_rx);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_get_rx_status);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_loopback_enable);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_loopback_disable);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_set_bp);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_get_fc_threshold);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_set_fc_threshold);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_get_fc_quanta);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_set_fc_quanta);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_get_fdoff);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_set_err_fqid);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_set_ic_params);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_set_fdoff);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_set_maxfrm);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_get_maxfrm);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_get_sg_enable);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_set_sg);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_discard_rx_errors);
+RTE_EXPORT_INTERNAL_SYMBOL(fman_if_receive_rx_errors);
+RTE_EXPORT_INTERNAL_SYMBOL(netcfg_acquire);
+RTE_EXPORT_INTERNAL_SYMBOL(netcfg_release);
+RTE_EXPORT_INTERNAL_SYMBOL(bman_new_pool);
+RTE_EXPORT_INTERNAL_SYMBOL(bman_free_pool);
+RTE_EXPORT_INTERNAL_SYMBOL(bman_get_params);
+RTE_EXPORT_INTERNAL_SYMBOL(bman_release);
+RTE_EXPORT_INTERNAL_SYMBOL(bman_acquire);
+RTE_EXPORT_INTERNAL_SYMBOL(bman_query_free_buffers);
+RTE_EXPORT_INTERNAL_SYMBOL(bman_thread_irq);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_fqid_range);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_reserve_fqid_range);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_pool_range);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_alloc_cgrid_range);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_release_cgrid_range);
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_intr_enable);
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_intr_disable);
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_ioctl_version_number);
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_link_status);
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_update_link_status);
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_update_link_speed);
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_restart_link_autoneg);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_set_fq_lookup_table);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_ern_register_cb);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_ern_poll_free);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_irqsource_add);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_fq_portal_irqsource_add);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_irqsource_remove);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_fq_portal_irqsource_remove);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_portal_poll_rx);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_clear_irq);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_portal_dequeue);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_dequeue);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_dqrr_consume);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_static_dequeue_add);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_dca_index);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_create_fq);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_fq_fqid);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_fq_state);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_init_fq);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_retire_fq);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_oos_fq);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_query_fq_np);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_query_fq_frm_cnt);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_set_vdq);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_volatile_dequeue);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_enqueue);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_enqueue_multi);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_enqueue_multi_fq);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_modify_cgr);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_create_cgr);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_delete_cgr);
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_qm_channel_caam);
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_get_qm_channel_pool);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_thread_fd);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_thread_irq);
+RTE_EXPORT_INTERNAL_SYMBOL(qman_fq_portal_thread_irq);
+RTE_EXPORT_INTERNAL_SYMBOL(fsl_qman_fq_portal_create);
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index ebc0c1fb4f..490193b535 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -30,10 +30,10 @@
 struct rte_fslmc_bus rte_fslmc_bus;
 
 #define DPAA2_SEQN_DYNFIELD_NAME "dpaa2_seqn_dynfield"
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_seqn_dynfield_offset)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_seqn_dynfield_offset);
 int dpaa2_seqn_dynfield_offset = -1;
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_get_device_count)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_get_device_count);
 uint32_t
 rte_fslmc_get_device_count(enum rte_dpaa2_dev_type device_type)
 {
@@ -528,7 +528,7 @@ rte_fslmc_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
 }
 
 /*register a fslmc bus based dpaa2 driver */
-RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_driver_register)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_driver_register);
 void
 rte_fslmc_driver_register(struct rte_dpaa2_driver *driver)
 {
@@ -538,7 +538,7 @@ rte_fslmc_driver_register(struct rte_dpaa2_driver *driver)
 }
 
 /*un-register a fslmc bus based dpaa2 driver */
-RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_driver_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_driver_unregister);
 void
 rte_fslmc_driver_unregister(struct rte_dpaa2_driver *driver)
 {
diff --git a/drivers/bus/fslmc/fslmc_vfio.c b/drivers/bus/fslmc/fslmc_vfio.c
index 68439cbd8c..63c490cb4e 100644
--- a/drivers/bus/fslmc/fslmc_vfio.c
+++ b/drivers/bus/fslmc/fslmc_vfio.c
@@ -84,7 +84,7 @@ enum {
 	FSLMC_VFIO_SOCKET_REQ_MEM
 };
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_get_mcp_ptr)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_get_mcp_ptr);
 void *
 dpaa2_get_mcp_ptr(int portal_idx)
 {
@@ -156,7 +156,7 @@ fslmc_io_virt2phy(const void *virtaddr)
 }
 
 /*register a fslmc bus based dpaa2 driver */
-RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_object_register)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_object_register);
 void
 rte_fslmc_object_register(struct rte_dpaa2_object *object)
 {
@@ -987,7 +987,7 @@ fslmc_unmap_dma(uint64_t vaddr, uint64_t iovaddr, size_t len)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_cold_mem_vaddr_to_iova)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_cold_mem_vaddr_to_iova);
 uint64_t
 rte_fslmc_cold_mem_vaddr_to_iova(void *vaddr,
 	uint64_t size)
@@ -1006,7 +1006,7 @@ rte_fslmc_cold_mem_vaddr_to_iova(void *vaddr,
 	return RTE_BAD_IOVA;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_cold_mem_iova_to_vaddr)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_cold_mem_iova_to_vaddr);
 void *
 rte_fslmc_cold_mem_iova_to_vaddr(uint64_t iova,
 	uint64_t size)
@@ -1023,7 +1023,7 @@ rte_fslmc_cold_mem_iova_to_vaddr(uint64_t iova,
 	return NULL;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_mem_vaddr_to_iova)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_mem_vaddr_to_iova);
 __rte_hot uint64_t
 rte_fslmc_mem_vaddr_to_iova(void *vaddr)
 {
@@ -1033,7 +1033,7 @@ rte_fslmc_mem_vaddr_to_iova(void *vaddr)
 	return rte_fslmc_cold_mem_vaddr_to_iova(vaddr, 0);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_mem_iova_to_vaddr)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_mem_iova_to_vaddr);
 __rte_hot void *
 rte_fslmc_mem_iova_to_vaddr(uint64_t iova)
 {
@@ -1043,7 +1043,7 @@ rte_fslmc_mem_iova_to_vaddr(uint64_t iova)
 	return rte_fslmc_cold_mem_iova_to_vaddr(iova, 0);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_io_vaddr_to_iova)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_io_vaddr_to_iova);
 uint64_t
 rte_fslmc_io_vaddr_to_iova(void *vaddr)
 {
@@ -1059,7 +1059,7 @@ rte_fslmc_io_vaddr_to_iova(void *vaddr)
 	return RTE_BAD_IOVA;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_io_iova_to_vaddr)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_io_iova_to_vaddr);
 void *
 rte_fslmc_io_iova_to_vaddr(uint64_t iova)
 {
@@ -1150,14 +1150,14 @@ fslmc_dmamap_seg(const struct rte_memseg_list *msl __rte_unused,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_fslmc_vfio_mem_dmamap)
+RTE_EXPORT_SYMBOL(rte_fslmc_vfio_mem_dmamap);
 int
 rte_fslmc_vfio_mem_dmamap(uint64_t vaddr, uint64_t iova, uint64_t size)
 {
 	return fslmc_map_dma(vaddr, iova, size);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_vfio_mem_dmaunmap)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_fslmc_vfio_mem_dmaunmap);
 int
 rte_fslmc_vfio_mem_dmaunmap(uint64_t iova, uint64_t size)
 {
@@ -1275,7 +1275,7 @@ static intptr_t vfio_map_mcp_obj(const char *mcp_obj)
 
 #define IRQ_SET_BUF_LEN  (sizeof(struct vfio_irq_set) + sizeof(int))
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_intr_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_intr_enable);
 int rte_dpaa2_intr_enable(struct rte_intr_handle *intr_handle, int index)
 {
 	int len, ret;
@@ -1307,7 +1307,7 @@ int rte_dpaa2_intr_enable(struct rte_intr_handle *intr_handle, int index)
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_intr_disable)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_intr_disable);
 int rte_dpaa2_intr_disable(struct rte_intr_handle *intr_handle, int index)
 {
 	struct vfio_irq_set *irq_set;
diff --git a/drivers/bus/fslmc/mc/dpbp.c b/drivers/bus/fslmc/mc/dpbp.c
index 08f24d33e8..57f05958d3 100644
--- a/drivers/bus/fslmc/mc/dpbp.c
+++ b/drivers/bus/fslmc/mc/dpbp.c
@@ -28,7 +28,7 @@
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpbp_open)
+RTE_EXPORT_INTERNAL_SYMBOL(dpbp_open);
 int dpbp_open(struct fsl_mc_io *mc_io,
 	      uint32_t cmd_flags,
 	      int dpbp_id,
@@ -160,7 +160,7 @@ int dpbp_destroy(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpbp_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(dpbp_enable);
 int dpbp_enable(struct fsl_mc_io *mc_io,
 		uint32_t cmd_flags,
 		uint16_t token)
@@ -183,7 +183,7 @@ int dpbp_enable(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpbp_disable)
+RTE_EXPORT_INTERNAL_SYMBOL(dpbp_disable);
 int dpbp_disable(struct fsl_mc_io *mc_io,
 		 uint32_t cmd_flags,
 		 uint16_t token)
@@ -240,7 +240,7 @@ int dpbp_is_enabled(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpbp_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(dpbp_reset);
 int dpbp_reset(struct fsl_mc_io *mc_io,
 	       uint32_t cmd_flags,
 	       uint16_t token)
@@ -264,7 +264,7 @@ int dpbp_reset(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpbp_get_attributes)
+RTE_EXPORT_INTERNAL_SYMBOL(dpbp_get_attributes);
 int dpbp_get_attributes(struct fsl_mc_io *mc_io,
 			uint32_t cmd_flags,
 			uint16_t token,
@@ -336,7 +336,7 @@ int dpbp_get_api_version(struct fsl_mc_io *mc_io,
  * Return:  '0' on Success; Error code otherwise.
  */
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpbp_get_num_free_bufs)
+RTE_EXPORT_INTERNAL_SYMBOL(dpbp_get_num_free_bufs);
 int dpbp_get_num_free_bufs(struct fsl_mc_io *mc_io,
 			   uint32_t cmd_flags,
 			   uint16_t token,
diff --git a/drivers/bus/fslmc/mc/dpci.c b/drivers/bus/fslmc/mc/dpci.c
index 9df3827f92..288deb82bc 100644
--- a/drivers/bus/fslmc/mc/dpci.c
+++ b/drivers/bus/fslmc/mc/dpci.c
@@ -317,7 +317,7 @@ int dpci_get_attributes(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpci_set_rx_queue)
+RTE_EXPORT_INTERNAL_SYMBOL(dpci_set_rx_queue);
 int dpci_set_rx_queue(struct fsl_mc_io *mc_io,
 		      uint32_t cmd_flags,
 		      uint16_t token,
@@ -480,7 +480,7 @@ int dpci_get_api_version(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpci_set_opr)
+RTE_EXPORT_INTERNAL_SYMBOL(dpci_set_opr);
 int dpci_set_opr(struct fsl_mc_io *mc_io,
 		 uint32_t cmd_flags,
 		 uint16_t token,
@@ -519,7 +519,7 @@ int dpci_set_opr(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpci_get_opr)
+RTE_EXPORT_INTERNAL_SYMBOL(dpci_get_opr);
 int dpci_get_opr(struct fsl_mc_io *mc_io,
 		 uint32_t cmd_flags,
 		 uint16_t token,
diff --git a/drivers/bus/fslmc/mc/dpcon.c b/drivers/bus/fslmc/mc/dpcon.c
index b9f2f50e12..e9441a5dc9 100644
--- a/drivers/bus/fslmc/mc/dpcon.c
+++ b/drivers/bus/fslmc/mc/dpcon.c
@@ -28,7 +28,7 @@
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpcon_open)
+RTE_EXPORT_INTERNAL_SYMBOL(dpcon_open);
 int dpcon_open(struct fsl_mc_io *mc_io,
 	       uint32_t cmd_flags,
 	       int dpcon_id,
@@ -67,7 +67,7 @@ int dpcon_open(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpcon_close)
+RTE_EXPORT_INTERNAL_SYMBOL(dpcon_close);
 int dpcon_close(struct fsl_mc_io *mc_io,
 		uint32_t cmd_flags,
 		uint16_t token)
@@ -168,7 +168,7 @@ int dpcon_destroy(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpcon_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(dpcon_enable);
 int dpcon_enable(struct fsl_mc_io *mc_io,
 		 uint32_t cmd_flags,
 		 uint16_t token)
@@ -192,7 +192,7 @@ int dpcon_enable(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpcon_disable)
+RTE_EXPORT_INTERNAL_SYMBOL(dpcon_disable);
 int dpcon_disable(struct fsl_mc_io *mc_io,
 		  uint32_t cmd_flags,
 		  uint16_t token)
@@ -251,7 +251,7 @@ int dpcon_is_enabled(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpcon_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(dpcon_reset);
 int dpcon_reset(struct fsl_mc_io *mc_io,
 		uint32_t cmd_flags,
 		uint16_t token)
@@ -275,7 +275,7 @@ int dpcon_reset(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpcon_get_attributes)
+RTE_EXPORT_INTERNAL_SYMBOL(dpcon_get_attributes);
 int dpcon_get_attributes(struct fsl_mc_io *mc_io,
 			 uint32_t cmd_flags,
 			 uint16_t token,
diff --git a/drivers/bus/fslmc/mc/dpdmai.c b/drivers/bus/fslmc/mc/dpdmai.c
index 97e90b09f1..24b7e55064 100644
--- a/drivers/bus/fslmc/mc/dpdmai.c
+++ b/drivers/bus/fslmc/mc/dpdmai.c
@@ -26,7 +26,7 @@
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpdmai_open)
+RTE_EXPORT_INTERNAL_SYMBOL(dpdmai_open);
 int dpdmai_open(struct fsl_mc_io *mc_io,
 		uint32_t cmd_flags,
 		int dpdmai_id,
@@ -65,7 +65,7 @@ int dpdmai_open(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpdmai_close)
+RTE_EXPORT_INTERNAL_SYMBOL(dpdmai_close);
 int dpdmai_close(struct fsl_mc_io *mc_io,
 		 uint32_t cmd_flags,
 		 uint16_t token)
@@ -175,7 +175,7 @@ int dpdmai_destroy(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpdmai_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(dpdmai_enable);
 int dpdmai_enable(struct fsl_mc_io *mc_io,
 		  uint32_t cmd_flags,
 		  uint16_t token)
@@ -199,7 +199,7 @@ int dpdmai_enable(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpdmai_disable)
+RTE_EXPORT_INTERNAL_SYMBOL(dpdmai_disable);
 int dpdmai_disable(struct fsl_mc_io *mc_io,
 		   uint32_t cmd_flags,
 		   uint16_t token)
@@ -282,7 +282,7 @@ int dpdmai_reset(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpdmai_get_attributes)
+RTE_EXPORT_INTERNAL_SYMBOL(dpdmai_get_attributes);
 int dpdmai_get_attributes(struct fsl_mc_io *mc_io,
 			  uint32_t cmd_flags,
 			  uint16_t token,
@@ -327,7 +327,7 @@ int dpdmai_get_attributes(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpdmai_set_rx_queue)
+RTE_EXPORT_INTERNAL_SYMBOL(dpdmai_set_rx_queue);
 int dpdmai_set_rx_queue(struct fsl_mc_io *mc_io,
 			uint32_t cmd_flags,
 			uint16_t token,
@@ -370,7 +370,7 @@ int dpdmai_set_rx_queue(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpdmai_get_rx_queue)
+RTE_EXPORT_INTERNAL_SYMBOL(dpdmai_get_rx_queue);
 int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io,
 			uint32_t cmd_flags,
 			uint16_t token,
@@ -421,7 +421,7 @@ int dpdmai_get_rx_queue(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpdmai_get_tx_queue)
+RTE_EXPORT_INTERNAL_SYMBOL(dpdmai_get_tx_queue);
 int dpdmai_get_tx_queue(struct fsl_mc_io *mc_io,
 			uint32_t cmd_flags,
 			uint16_t token,
diff --git a/drivers/bus/fslmc/mc/dpio.c b/drivers/bus/fslmc/mc/dpio.c
index 8cdf8f432a..3937805dcf 100644
--- a/drivers/bus/fslmc/mc/dpio.c
+++ b/drivers/bus/fslmc/mc/dpio.c
@@ -28,7 +28,7 @@
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpio_open)
+RTE_EXPORT_INTERNAL_SYMBOL(dpio_open);
 int dpio_open(struct fsl_mc_io *mc_io,
 	      uint32_t cmd_flags,
 	      int dpio_id,
@@ -64,7 +64,7 @@ int dpio_open(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpio_close)
+RTE_EXPORT_INTERNAL_SYMBOL(dpio_close);
 int dpio_close(struct fsl_mc_io *mc_io,
 	       uint32_t cmd_flags,
 	       uint16_t token)
@@ -177,7 +177,7 @@ int dpio_destroy(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpio_enable)
+RTE_EXPORT_INTERNAL_SYMBOL(dpio_enable);
 int dpio_enable(struct fsl_mc_io *mc_io,
 		uint32_t cmd_flags,
 		uint16_t token)
@@ -201,7 +201,7 @@ int dpio_enable(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpio_disable)
+RTE_EXPORT_INTERNAL_SYMBOL(dpio_disable);
 int dpio_disable(struct fsl_mc_io *mc_io,
 		 uint32_t cmd_flags,
 		 uint16_t token)
@@ -259,7 +259,7 @@ int dpio_is_enabled(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpio_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(dpio_reset);
 int dpio_reset(struct fsl_mc_io *mc_io,
 	       uint32_t cmd_flags,
 	       uint16_t token)
@@ -284,7 +284,7 @@ int dpio_reset(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpio_get_attributes)
+RTE_EXPORT_INTERNAL_SYMBOL(dpio_get_attributes);
 int dpio_get_attributes(struct fsl_mc_io *mc_io,
 			uint32_t cmd_flags,
 			uint16_t token,
@@ -330,7 +330,7 @@ int dpio_get_attributes(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpio_set_stashing_destination)
+RTE_EXPORT_INTERNAL_SYMBOL(dpio_set_stashing_destination);
 int dpio_set_stashing_destination(struct fsl_mc_io *mc_io,
 				  uint32_t cmd_flags,
 				  uint16_t token,
@@ -359,7 +359,7 @@ int dpio_set_stashing_destination(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpio_get_stashing_destination)
+RTE_EXPORT_INTERNAL_SYMBOL(dpio_get_stashing_destination);
 int dpio_get_stashing_destination(struct fsl_mc_io *mc_io,
 				  uint32_t cmd_flags,
 				  uint16_t token,
@@ -396,7 +396,7 @@ int dpio_get_stashing_destination(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpio_set_stashing_destination_by_core_id)
+RTE_EXPORT_INTERNAL_SYMBOL(dpio_set_stashing_destination_by_core_id);
 int dpio_set_stashing_destination_by_core_id(struct fsl_mc_io *mc_io,
 					uint32_t cmd_flags,
 					uint16_t token,
@@ -425,7 +425,7 @@ int dpio_set_stashing_destination_by_core_id(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpio_set_stashing_destination_source)
+RTE_EXPORT_INTERNAL_SYMBOL(dpio_set_stashing_destination_source);
 int dpio_set_stashing_destination_source(struct fsl_mc_io *mc_io,
 				  uint32_t cmd_flags,
 				  uint16_t token,
@@ -454,7 +454,7 @@ int dpio_set_stashing_destination_source(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpio_get_stashing_destination_source)
+RTE_EXPORT_INTERNAL_SYMBOL(dpio_get_stashing_destination_source);
 int dpio_get_stashing_destination_source(struct fsl_mc_io *mc_io,
 				  uint32_t cmd_flags,
 				  uint16_t token,
@@ -491,7 +491,7 @@ int dpio_get_stashing_destination_source(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpio_add_static_dequeue_channel)
+RTE_EXPORT_INTERNAL_SYMBOL(dpio_add_static_dequeue_channel);
 int dpio_add_static_dequeue_channel(struct fsl_mc_io *mc_io,
 				    uint32_t cmd_flags,
 				    uint16_t token,
@@ -531,7 +531,7 @@ int dpio_add_static_dequeue_channel(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpio_remove_static_dequeue_channel)
+RTE_EXPORT_INTERNAL_SYMBOL(dpio_remove_static_dequeue_channel);
 int dpio_remove_static_dequeue_channel(struct fsl_mc_io *mc_io,
 				       uint32_t cmd_flags,
 				       uint16_t token,
diff --git a/drivers/bus/fslmc/mc/dpmng.c b/drivers/bus/fslmc/mc/dpmng.c
index 47c85cd80d..1a468df32f 100644
--- a/drivers/bus/fslmc/mc/dpmng.c
+++ b/drivers/bus/fslmc/mc/dpmng.c
@@ -20,7 +20,7 @@
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mc_get_version)
+RTE_EXPORT_INTERNAL_SYMBOL(mc_get_version);
 int mc_get_version(struct fsl_mc_io *mc_io,
 		   uint32_t cmd_flags,
 		   struct mc_version *mc_ver_info)
@@ -60,7 +60,7 @@ int mc_get_version(struct fsl_mc_io *mc_io,
  *
  * Return:     '0' on Success; Error code otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mc_get_soc_version)
+RTE_EXPORT_INTERNAL_SYMBOL(mc_get_soc_version);
 int mc_get_soc_version(struct fsl_mc_io *mc_io,
 		       uint32_t cmd_flags,
 		       struct mc_soc_version *mc_platform_info)
diff --git a/drivers/bus/fslmc/mc/mc_sys.c b/drivers/bus/fslmc/mc/mc_sys.c
index ef4c8dd3b8..0facfbf1de 100644
--- a/drivers/bus/fslmc/mc/mc_sys.c
+++ b/drivers/bus/fslmc/mc/mc_sys.c
@@ -53,7 +53,7 @@ static int mc_status_to_error(enum mc_cmd_status status)
 	return -EINVAL;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mc_send_command)
+RTE_EXPORT_INTERNAL_SYMBOL(mc_send_command);
 int mc_send_command(struct fsl_mc_io *mc_io, struct mc_command *cmd)
 {
 	enum mc_cmd_status status;
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c
index 925e83e97d..c641709016 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpbp.c
@@ -96,7 +96,7 @@ dpaa2_create_dpbp_device(int vdev_fd __rte_unused,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_alloc_dpbp_dev)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_alloc_dpbp_dev);
 struct dpaa2_dpbp_dev *dpaa2_alloc_dpbp_dev(void)
 {
 	struct dpaa2_dpbp_dev *dpbp_dev = NULL;
@@ -110,7 +110,7 @@ struct dpaa2_dpbp_dev *dpaa2_alloc_dpbp_dev(void)
 	return dpbp_dev;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_free_dpbp_dev)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_free_dpbp_dev);
 void dpaa2_free_dpbp_dev(struct dpaa2_dpbp_dev *dpbp)
 {
 	struct dpaa2_dpbp_dev *dpbp_dev = NULL;
@@ -124,7 +124,7 @@ void dpaa2_free_dpbp_dev(struct dpaa2_dpbp_dev *dpbp)
 	}
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dpbp_supported)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dpbp_supported);
 int dpaa2_dpbp_supported(void)
 {
 	if (TAILQ_EMPTY(&dpbp_dev_list))
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c
index b546da82f6..f99a7a2afa 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpci.c
@@ -152,7 +152,7 @@ rte_dpaa2_create_dpci_device(int vdev_fd __rte_unused,
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_alloc_dpci_dev)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_alloc_dpci_dev);
 struct dpaa2_dpci_dev *rte_dpaa2_alloc_dpci_dev(void)
 {
 	struct dpaa2_dpci_dev *dpci_dev = NULL;
@@ -166,7 +166,7 @@ struct dpaa2_dpci_dev *rte_dpaa2_alloc_dpci_dev(void)
 	return dpci_dev;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_free_dpci_dev)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_free_dpci_dev);
 void rte_dpaa2_free_dpci_dev(struct dpaa2_dpci_dev *dpci)
 {
 	struct dpaa2_dpci_dev *dpci_dev = NULL;
diff --git a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
index e32471d8b5..c777a66e35 100644
--- a/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
+++ b/drivers/bus/fslmc/portal/dpaa2_hw_dpio.c
@@ -48,12 +48,12 @@
 
 #define NUM_HOST_CPUS RTE_MAX_LCORE
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_io_portal)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_io_portal);
 struct dpaa2_io_portal_t dpaa2_io_portal[RTE_MAX_LCORE];
-RTE_EXPORT_INTERNAL_SYMBOL(per_lcore__dpaa2_io)
+RTE_EXPORT_INTERNAL_SYMBOL(per_lcore__dpaa2_io);
 RTE_DEFINE_PER_LCORE(struct dpaa2_io_portal_t, _dpaa2_io);
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_global_active_dqs_list)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_global_active_dqs_list);
 struct swp_active_dqs rte_global_active_dqs_list[NUM_MAX_SWP];
 
 TAILQ_HEAD(dpio_dev_list, dpaa2_dpio_dev);
@@ -62,14 +62,14 @@ static struct dpio_dev_list dpio_dev_list
 static uint32_t io_space_count;
 
 /* Variable to store DPAA2 platform type */
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_svr_family)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_svr_family);
 uint32_t dpaa2_svr_family;
 
 /* Variable to store DPAA2 DQRR size */
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dqrr_size)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dqrr_size);
 uint8_t dpaa2_dqrr_size;
 /* Variable to store DPAA2 EQCR size */
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_eqcr_size)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_eqcr_size);
 uint8_t dpaa2_eqcr_size;
 
 /* Variable to hold the portal_key, once created.*/
@@ -339,7 +339,7 @@ static struct dpaa2_dpio_dev *dpaa2_get_qbman_swp(void)
 	return dpio_dev;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_affine_qbman_swp)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_affine_qbman_swp);
 int
 dpaa2_affine_qbman_swp(void)
 {
@@ -361,7 +361,7 @@ dpaa2_affine_qbman_swp(void)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_affine_qbman_ethrx_swp)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_affine_qbman_ethrx_swp);
 int
 dpaa2_affine_qbman_ethrx_swp(void)
 {
@@ -623,7 +623,7 @@ dpaa2_create_dpio_device(int vdev_fd,
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_free_dq_storage)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_free_dq_storage);
 void
 dpaa2_free_dq_storage(struct queue_storage_info_t *q_storage)
 {
@@ -635,7 +635,7 @@ dpaa2_free_dq_storage(struct queue_storage_info_t *q_storage)
 	}
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_alloc_dq_storage)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_alloc_dq_storage);
 int
 dpaa2_alloc_dq_storage(struct queue_storage_info_t *q_storage)
 {
@@ -658,7 +658,7 @@ dpaa2_alloc_dq_storage(struct queue_storage_info_t *q_storage)
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_free_eq_descriptors)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_free_eq_descriptors);
 uint32_t
 dpaa2_free_eq_descriptors(void)
 {
diff --git a/drivers/bus/fslmc/qbman/qbman_debug.c b/drivers/bus/fslmc/qbman/qbman_debug.c
index f13168dce3..f41a165faa 100644
--- a/drivers/bus/fslmc/qbman/qbman_debug.c
+++ b/drivers/bus/fslmc/qbman/qbman_debug.c
@@ -327,7 +327,7 @@ uint16_t qbman_fq_attr_get_opridsz(struct qbman_fq_query_rslt *r)
 	return r->opridsz;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_fq_query_state)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_fq_query_state);
 int qbman_fq_query_state(struct qbman_swp *s, uint32_t fqid,
 			 struct qbman_fq_query_np_rslt *r)
 {
@@ -385,7 +385,7 @@ int qbman_fq_state_overflow_error(const struct qbman_fq_query_np_rslt *r)
 	return (int)((r->st1 & 0x40) >> 6);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_fq_state_frame_count)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_fq_state_frame_count);
 uint32_t qbman_fq_state_frame_count(const struct qbman_fq_query_np_rslt *r)
 {
 	return (r->frm_cnt & 0x00FFFFFF);
diff --git a/drivers/bus/fslmc/qbman/qbman_portal.c b/drivers/bus/fslmc/qbman/qbman_portal.c
index 84853924e7..a203f02bfb 100644
--- a/drivers/bus/fslmc/qbman/qbman_portal.c
+++ b/drivers/bus/fslmc/qbman/qbman_portal.c
@@ -407,7 +407,7 @@ uint32_t qbman_swp_interrupt_read_status(struct qbman_swp *p)
 	return qbman_cinh_read(&p->sys, QBMAN_CINH_SWP_ISR);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_interrupt_clear_status)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_interrupt_clear_status);
 void qbman_swp_interrupt_clear_status(struct qbman_swp *p, uint32_t mask)
 {
 	qbman_cinh_write(&p->sys, QBMAN_CINH_SWP_ISR, mask);
@@ -609,13 +609,13 @@ enum qb_enqueue_commands {
 #define QB_ENQUEUE_CMD_NLIS_SHIFT            14
 #define QB_ENQUEUE_CMD_IS_NESN_SHIFT         15
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_eq_desc_clear)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_eq_desc_clear);
 void qbman_eq_desc_clear(struct qbman_eq_desc *d)
 {
 	memset(d, 0, sizeof(*d));
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_eq_desc_set_no_orp)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_eq_desc_set_no_orp);
 void qbman_eq_desc_set_no_orp(struct qbman_eq_desc *d, int respond_success)
 {
 	d->eq.verb &= ~(1 << QB_ENQUEUE_CMD_ORP_ENABLE_SHIFT);
@@ -625,7 +625,7 @@ void qbman_eq_desc_set_no_orp(struct qbman_eq_desc *d, int respond_success)
 		d->eq.verb |= enqueue_rejects_to_fq;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_eq_desc_set_orp)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_eq_desc_set_orp);
 void qbman_eq_desc_set_orp(struct qbman_eq_desc *d, int respond_success,
 			   uint16_t opr_id, uint16_t seqnum, int incomplete)
 {
@@ -665,7 +665,7 @@ void qbman_eq_desc_set_orp_nesn(struct qbman_eq_desc *d, uint16_t opr_id,
 	d->eq.seqnum |= 1 << QB_ENQUEUE_CMD_IS_NESN_SHIFT;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_eq_desc_set_response)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_eq_desc_set_response);
 void qbman_eq_desc_set_response(struct qbman_eq_desc *d,
 				dma_addr_t storage_phys,
 				int stash)
@@ -674,20 +674,20 @@ void qbman_eq_desc_set_response(struct qbman_eq_desc *d,
 	d->eq.wae = stash;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_eq_desc_set_token)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_eq_desc_set_token);
 void qbman_eq_desc_set_token(struct qbman_eq_desc *d, uint8_t token)
 {
 	d->eq.rspid = token;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_eq_desc_set_fq)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_eq_desc_set_fq);
 void qbman_eq_desc_set_fq(struct qbman_eq_desc *d, uint32_t fqid)
 {
 	d->eq.verb &= ~(1 << QB_ENQUEUE_CMD_TARGET_TYPE_SHIFT);
 	d->eq.tgtid = fqid;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_eq_desc_set_qd)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_eq_desc_set_qd);
 void qbman_eq_desc_set_qd(struct qbman_eq_desc *d, uint32_t qdid,
 			  uint16_t qd_bin, uint8_t qd_prio)
 {
@@ -705,7 +705,7 @@ void qbman_eq_desc_set_eqdi(struct qbman_eq_desc *d, int enable)
 		d->eq.verb &= ~(1 << QB_ENQUEUE_CMD_IRQ_ON_DISPATCH_SHIFT);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_eq_desc_set_dca)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_eq_desc_set_dca);
 void qbman_eq_desc_set_dca(struct qbman_eq_desc *d, int enable,
 			   uint8_t dqrr_idx, int park)
 {
@@ -1227,7 +1227,7 @@ static int qbman_swp_enqueue_multiple_mem_back(struct qbman_swp *s,
 	return num_enqueued;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_enqueue_multiple)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_enqueue_multiple);
 int qbman_swp_enqueue_multiple(struct qbman_swp *s,
 				      const struct qbman_eq_desc *d,
 				      const struct qbman_fd *fd,
@@ -1502,7 +1502,7 @@ static int qbman_swp_enqueue_multiple_fd_mem_back(struct qbman_swp *s,
 	return num_enqueued;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_enqueue_multiple_fd)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_enqueue_multiple_fd);
 int qbman_swp_enqueue_multiple_fd(struct qbman_swp *s,
 					 const struct qbman_eq_desc *d,
 					 struct qbman_fd **fd,
@@ -1758,7 +1758,7 @@ static int qbman_swp_enqueue_multiple_desc_mem_back(struct qbman_swp *s,
 
 	return num_enqueued;
 }
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_enqueue_multiple_desc)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_enqueue_multiple_desc);
 int qbman_swp_enqueue_multiple_desc(struct qbman_swp *s,
 					   const struct qbman_eq_desc *d,
 					   const struct qbman_fd *fd,
@@ -1785,7 +1785,7 @@ void qbman_swp_push_get(struct qbman_swp *s, uint8_t channel_idx, int *enabled)
 	*enabled = src | (1 << channel_idx);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_push_set)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_push_set);
 void qbman_swp_push_set(struct qbman_swp *s, uint8_t channel_idx, int enable)
 {
 	uint16_t dqsrc;
@@ -1823,13 +1823,13 @@ enum qb_pull_dt_e {
 	qb_pull_dt_framequeue
 };
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_pull_desc_clear)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_pull_desc_clear);
 void qbman_pull_desc_clear(struct qbman_pull_desc *d)
 {
 	memset(d, 0, sizeof(*d));
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_pull_desc_set_storage)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_pull_desc_set_storage);
 void qbman_pull_desc_set_storage(struct qbman_pull_desc *d,
 				 struct qbman_result *storage,
 				 dma_addr_t storage_phys,
@@ -1850,7 +1850,7 @@ void qbman_pull_desc_set_storage(struct qbman_pull_desc *d,
 	d->pull.rsp_addr = storage_phys;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_pull_desc_set_numframes)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_pull_desc_set_numframes);
 void qbman_pull_desc_set_numframes(struct qbman_pull_desc *d,
 				   uint8_t numframes)
 {
@@ -1862,7 +1862,7 @@ void qbman_pull_desc_set_token(struct qbman_pull_desc *d, uint8_t token)
 	d->pull.tok = token;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_pull_desc_set_fq)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_pull_desc_set_fq);
 void qbman_pull_desc_set_fq(struct qbman_pull_desc *d, uint32_t fqid)
 {
 	d->pull.verb |= 1 << QB_VDQCR_VERB_DCT_SHIFT;
@@ -1978,7 +1978,7 @@ static int qbman_swp_pull_mem_back(struct qbman_swp *s,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_pull)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_pull);
 int qbman_swp_pull(struct qbman_swp *s, struct qbman_pull_desc *d)
 {
 	if (!s->stash_off)
@@ -2006,7 +2006,7 @@ int qbman_swp_pull(struct qbman_swp *s, struct qbman_pull_desc *d)
 
 #include <rte_prefetch.h>
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_prefetch_dqrr_next)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_prefetch_dqrr_next);
 void qbman_swp_prefetch_dqrr_next(struct qbman_swp *s)
 {
 	const struct qbman_result *p;
@@ -2020,7 +2020,7 @@ void qbman_swp_prefetch_dqrr_next(struct qbman_swp *s)
  * only once, so repeated calls can return a sequence of DQRR entries, without
  * requiring they be consumed immediately or in any particular order.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_dqrr_next)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_dqrr_next);
 const struct qbman_result *qbman_swp_dqrr_next(struct qbman_swp *s)
 {
 	if (!s->stash_off)
@@ -2224,7 +2224,7 @@ const struct qbman_result *qbman_swp_dqrr_next_mem_back(struct qbman_swp *s)
 }
 
 /* Consume DQRR entries previously returned from qbman_swp_dqrr_next(). */
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_dqrr_consume)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_dqrr_consume);
 void qbman_swp_dqrr_consume(struct qbman_swp *s,
 			    const struct qbman_result *dq)
 {
@@ -2233,7 +2233,7 @@ void qbman_swp_dqrr_consume(struct qbman_swp *s,
 }
 
 /* Consume DQRR entries previously returned from qbman_swp_dqrr_next(). */
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_dqrr_idx_consume)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_dqrr_idx_consume);
 void qbman_swp_dqrr_idx_consume(struct qbman_swp *s,
 			    uint8_t dqrr_index)
 {
@@ -2244,7 +2244,7 @@ void qbman_swp_dqrr_idx_consume(struct qbman_swp *s,
 /* Polling user-provided storage */
 /*********************************/
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_has_new_result)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_has_new_result);
 int qbman_result_has_new_result(struct qbman_swp *s,
 				struct qbman_result *dq)
 {
@@ -2273,7 +2273,7 @@ int qbman_result_has_new_result(struct qbman_swp *s,
 	return 1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_check_new_result)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_check_new_result);
 int qbman_check_new_result(struct qbman_result *dq)
 {
 	if (dq->dq.tok == 0)
@@ -2289,7 +2289,7 @@ int qbman_check_new_result(struct qbman_result *dq)
 	return 1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_check_command_complete)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_check_command_complete);
 int qbman_check_command_complete(struct qbman_result *dq)
 {
 	struct qbman_swp *s;
@@ -2377,19 +2377,19 @@ int qbman_result_is_FQPN(const struct qbman_result *dq)
 
 /* These APIs assume qbman_result_is_DQ() is TRUE */
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_DQ_flags)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_DQ_flags);
 uint8_t qbman_result_DQ_flags(const struct qbman_result *dq)
 {
 	return dq->dq.stat;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_DQ_seqnum)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_DQ_seqnum);
 uint16_t qbman_result_DQ_seqnum(const struct qbman_result *dq)
 {
 	return dq->dq.seqnum;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_DQ_odpid)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_DQ_odpid);
 uint16_t qbman_result_DQ_odpid(const struct qbman_result *dq)
 {
 	return dq->dq.oprid;
@@ -2410,13 +2410,13 @@ uint32_t qbman_result_DQ_frame_count(const struct qbman_result *dq)
 	return dq->dq.fq_frm_cnt;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_DQ_fqd_ctx)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_DQ_fqd_ctx);
 uint64_t qbman_result_DQ_fqd_ctx(const struct qbman_result *dq)
 {
 	return dq->dq.fqd_ctx;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_DQ_fd)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_DQ_fd);
 const struct qbman_fd *qbman_result_DQ_fd(const struct qbman_result *dq)
 {
 	return (const struct qbman_fd *)&dq->dq.fd[0];
@@ -2425,7 +2425,7 @@ const struct qbman_fd *qbman_result_DQ_fd(const struct qbman_result *dq)
 /**************************************/
 /* Parsing state-change notifications */
 /**************************************/
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_SCN_state)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_SCN_state);
 uint8_t qbman_result_SCN_state(const struct qbman_result *scn)
 {
 	return scn->scn.state;
@@ -2485,25 +2485,25 @@ uint64_t qbman_result_cgcu_icnt(const struct qbman_result *scn)
 /********************/
 /* Parsing EQ RESP  */
 /********************/
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_eqresp_fd)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_eqresp_fd);
 struct qbman_fd *qbman_result_eqresp_fd(struct qbman_result *eqresp)
 {
 	return (struct qbman_fd *)&eqresp->eq_resp.fd[0];
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_eqresp_set_rspid)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_eqresp_set_rspid);
 void qbman_result_eqresp_set_rspid(struct qbman_result *eqresp, uint8_t val)
 {
 	eqresp->eq_resp.rspid = val;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_eqresp_rspid)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_eqresp_rspid);
 uint8_t qbman_result_eqresp_rspid(struct qbman_result *eqresp)
 {
 	return eqresp->eq_resp.rspid;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_eqresp_rc)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_result_eqresp_rc);
 uint8_t qbman_result_eqresp_rc(struct qbman_result *eqresp)
 {
 	if (eqresp->eq_resp.rc == 0xE)
@@ -2518,14 +2518,14 @@ uint8_t qbman_result_eqresp_rc(struct qbman_result *eqresp)
 #define QB_BR_RC_VALID_SHIFT  5
 #define QB_BR_RCDI_SHIFT      6
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_release_desc_clear)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_release_desc_clear);
 void qbman_release_desc_clear(struct qbman_release_desc *d)
 {
 	memset(d, 0, sizeof(*d));
 	d->br.verb = 1 << QB_BR_RC_VALID_SHIFT;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_release_desc_set_bpid)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_release_desc_set_bpid);
 void qbman_release_desc_set_bpid(struct qbman_release_desc *d, uint16_t bpid)
 {
 	d->br.bpid = bpid;
@@ -2640,7 +2640,7 @@ static int qbman_swp_release_mem_back(struct qbman_swp *s,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_release)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_release);
 int qbman_swp_release(struct qbman_swp *s,
 			     const struct qbman_release_desc *d,
 			     const uint64_t *buffers,
@@ -2767,7 +2767,7 @@ static int qbman_swp_acquire_cinh_direct(struct qbman_swp *s, uint16_t bpid,
 	return num;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_acquire)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_swp_acquire);
 int qbman_swp_acquire(struct qbman_swp *s, uint16_t bpid, uint64_t *buffers,
 		      unsigned int num_buffers)
 {
@@ -2951,13 +2951,13 @@ int qbman_swp_CDAN_set_context_enable(struct qbman_swp *s, uint16_t channelid,
 				  1, ctx);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_get_dqrr_idx)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_get_dqrr_idx);
 uint8_t qbman_get_dqrr_idx(const struct qbman_result *dqrr)
 {
 	return QBMAN_IDX_FROM_DQRR(dqrr);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(qbman_get_dqrr_from_idx)
+RTE_EXPORT_INTERNAL_SYMBOL(qbman_get_dqrr_from_idx);
 struct qbman_result *qbman_get_dqrr_from_idx(struct qbman_swp *s, uint8_t idx)
 {
 	struct qbman_result *dq;
diff --git a/drivers/bus/ifpga/ifpga_bus.c b/drivers/bus/ifpga/ifpga_bus.c
index ca9e49f548..cd1375af96 100644
--- a/drivers/bus/ifpga/ifpga_bus.c
+++ b/drivers/bus/ifpga/ifpga_bus.c
@@ -45,7 +45,7 @@ static TAILQ_HEAD(, rte_afu_driver) ifpga_afu_drv_list =
 
 
 /* register a ifpga bus based driver */
-RTE_EXPORT_INTERNAL_SYMBOL(rte_ifpga_driver_register)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_ifpga_driver_register);
 void rte_ifpga_driver_register(struct rte_afu_driver *driver)
 {
 	RTE_VERIFY(driver);
@@ -54,7 +54,7 @@ void rte_ifpga_driver_register(struct rte_afu_driver *driver)
 }
 
 /* un-register a fpga bus based driver */
-RTE_EXPORT_INTERNAL_SYMBOL(rte_ifpga_driver_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_ifpga_driver_unregister);
 void rte_ifpga_driver_unregister(struct rte_afu_driver *driver)
 {
 	TAILQ_REMOVE(&ifpga_afu_drv_list, driver, next);
@@ -74,7 +74,7 @@ ifpga_find_afu_dev(const struct rte_rawdev *rdev,
 	return NULL;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_ifpga_find_afu_by_name)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_ifpga_find_afu_by_name);
 struct rte_afu_device *
 rte_ifpga_find_afu_by_name(const char *name)
 {
diff --git a/drivers/bus/pci/bsd/pci.c b/drivers/bus/pci/bsd/pci.c
index 3f13e1d6ac..de48704948 100644
--- a/drivers/bus/pci/bsd/pci.c
+++ b/drivers/bus/pci/bsd/pci.c
@@ -49,7 +49,7 @@
  */
 
 /* Map pci device */
-RTE_EXPORT_SYMBOL(rte_pci_map_device)
+RTE_EXPORT_SYMBOL(rte_pci_map_device);
 int
 rte_pci_map_device(struct rte_pci_device *dev)
 {
@@ -71,7 +71,7 @@ rte_pci_map_device(struct rte_pci_device *dev)
 }
 
 /* Unmap pci device */
-RTE_EXPORT_SYMBOL(rte_pci_unmap_device)
+RTE_EXPORT_SYMBOL(rte_pci_unmap_device);
 void
 rte_pci_unmap_device(struct rte_pci_device *dev)
 {
@@ -413,7 +413,7 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv __rte_unused,
 }
 
 /* Read PCI config space. */
-RTE_EXPORT_SYMBOL(rte_pci_read_config)
+RTE_EXPORT_SYMBOL(rte_pci_read_config);
 int rte_pci_read_config(const struct rte_pci_device *dev,
 		void *buf, size_t len, off_t offset)
 {
@@ -460,7 +460,7 @@ int rte_pci_read_config(const struct rte_pci_device *dev,
 }
 
 /* Write PCI config space. */
-RTE_EXPORT_SYMBOL(rte_pci_write_config)
+RTE_EXPORT_SYMBOL(rte_pci_write_config);
 int rte_pci_write_config(const struct rte_pci_device *dev,
 		const void *buf, size_t len, off_t offset)
 {
@@ -503,7 +503,7 @@ int rte_pci_write_config(const struct rte_pci_device *dev,
 }
 
 /* Read PCI MMIO space. */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_mmio_read, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_mmio_read, 23.07);
 int rte_pci_mmio_read(const struct rte_pci_device *dev, int bar,
 		      void *buf, size_t len, off_t offset)
 {
@@ -515,7 +515,7 @@ int rte_pci_mmio_read(const struct rte_pci_device *dev, int bar,
 }
 
 /* Write PCI MMIO space. */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_mmio_write, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_mmio_write, 23.07);
 int rte_pci_mmio_write(const struct rte_pci_device *dev, int bar,
 		       const void *buf, size_t len, off_t offset)
 {
@@ -526,7 +526,7 @@ int rte_pci_mmio_write(const struct rte_pci_device *dev, int bar,
 	return len;
 }
 
-RTE_EXPORT_SYMBOL(rte_pci_ioport_map)
+RTE_EXPORT_SYMBOL(rte_pci_ioport_map);
 int
 rte_pci_ioport_map(struct rte_pci_device *dev, int bar,
 		struct rte_pci_ioport *p)
@@ -588,7 +588,7 @@ pci_uio_ioport_read(struct rte_pci_ioport *p,
 #endif
 }
 
-RTE_EXPORT_SYMBOL(rte_pci_ioport_read)
+RTE_EXPORT_SYMBOL(rte_pci_ioport_read);
 void
 rte_pci_ioport_read(struct rte_pci_ioport *p,
 		void *data, size_t len, off_t offset)
@@ -631,7 +631,7 @@ pci_uio_ioport_write(struct rte_pci_ioport *p,
 #endif
 }
 
-RTE_EXPORT_SYMBOL(rte_pci_ioport_write)
+RTE_EXPORT_SYMBOL(rte_pci_ioport_write);
 void
 rte_pci_ioport_write(struct rte_pci_ioport *p,
 		const void *data, size_t len, off_t offset)
@@ -645,7 +645,7 @@ rte_pci_ioport_write(struct rte_pci_ioport *p,
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_pci_ioport_unmap)
+RTE_EXPORT_SYMBOL(rte_pci_ioport_unmap);
 int
 rte_pci_ioport_unmap(struct rte_pci_ioport *p)
 {
diff --git a/drivers/bus/pci/linux/pci.c b/drivers/bus/pci/linux/pci.c
index c20d159218..1eb87c8fe6 100644
--- a/drivers/bus/pci/linux/pci.c
+++ b/drivers/bus/pci/linux/pci.c
@@ -55,7 +55,7 @@ pci_get_kernel_driver_by_path(const char *filename, char *dri_name,
 }
 
 /* Map pci device */
-RTE_EXPORT_SYMBOL(rte_pci_map_device)
+RTE_EXPORT_SYMBOL(rte_pci_map_device);
 int
 rte_pci_map_device(struct rte_pci_device *dev)
 {
@@ -86,7 +86,7 @@ rte_pci_map_device(struct rte_pci_device *dev)
 }
 
 /* Unmap pci device */
-RTE_EXPORT_SYMBOL(rte_pci_unmap_device)
+RTE_EXPORT_SYMBOL(rte_pci_unmap_device);
 void
 rte_pci_unmap_device(struct rte_pci_device *dev)
 {
@@ -630,7 +630,7 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv,
 }
 
 /* Read PCI config space. */
-RTE_EXPORT_SYMBOL(rte_pci_read_config)
+RTE_EXPORT_SYMBOL(rte_pci_read_config);
 int rte_pci_read_config(const struct rte_pci_device *device,
 		void *buf, size_t len, off_t offset)
 {
@@ -654,7 +654,7 @@ int rte_pci_read_config(const struct rte_pci_device *device,
 }
 
 /* Write PCI config space. */
-RTE_EXPORT_SYMBOL(rte_pci_write_config)
+RTE_EXPORT_SYMBOL(rte_pci_write_config);
 int rte_pci_write_config(const struct rte_pci_device *device,
 		const void *buf, size_t len, off_t offset)
 {
@@ -678,7 +678,7 @@ int rte_pci_write_config(const struct rte_pci_device *device,
 }
 
 /* Read PCI MMIO space. */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_mmio_read, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_mmio_read, 23.07);
 int rte_pci_mmio_read(const struct rte_pci_device *device, int bar,
 		void *buf, size_t len, off_t offset)
 {
@@ -701,7 +701,7 @@ int rte_pci_mmio_read(const struct rte_pci_device *device, int bar,
 }
 
 /* Write PCI MMIO space. */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_mmio_write, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_mmio_write, 23.07);
 int rte_pci_mmio_write(const struct rte_pci_device *device, int bar,
 		const void *buf, size_t len, off_t offset)
 {
@@ -723,7 +723,7 @@ int rte_pci_mmio_write(const struct rte_pci_device *device, int bar,
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_pci_ioport_map)
+RTE_EXPORT_SYMBOL(rte_pci_ioport_map);
 int
 rte_pci_ioport_map(struct rte_pci_device *dev, int bar,
 		struct rte_pci_ioport *p)
@@ -751,7 +751,7 @@ rte_pci_ioport_map(struct rte_pci_device *dev, int bar,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_pci_ioport_read)
+RTE_EXPORT_SYMBOL(rte_pci_ioport_read);
 void
 rte_pci_ioport_read(struct rte_pci_ioport *p,
 		void *data, size_t len, off_t offset)
@@ -771,7 +771,7 @@ rte_pci_ioport_read(struct rte_pci_ioport *p,
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_pci_ioport_write)
+RTE_EXPORT_SYMBOL(rte_pci_ioport_write);
 void
 rte_pci_ioport_write(struct rte_pci_ioport *p,
 		const void *data, size_t len, off_t offset)
@@ -791,7 +791,7 @@ rte_pci_ioport_write(struct rte_pci_ioport *p,
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_pci_ioport_unmap)
+RTE_EXPORT_SYMBOL(rte_pci_ioport_unmap);
 int
 rte_pci_ioport_unmap(struct rte_pci_ioport *p)
 {
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index c88634f790..39e564c2e9 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -33,7 +33,7 @@
 
 #define SYSFS_PCI_DEVICES "/sys/bus/pci/devices"
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_pci_get_sysfs_path)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pci_get_sysfs_path);
 const char *rte_pci_get_sysfs_path(void)
 {
 	const char *path = NULL;
@@ -479,7 +479,7 @@ pci_dump_one_device(FILE *f, struct rte_pci_device *dev)
 }
 
 /* dump devices on the bus */
-RTE_EXPORT_SYMBOL(rte_pci_dump)
+RTE_EXPORT_SYMBOL(rte_pci_dump);
 void
 rte_pci_dump(FILE *f)
 {
@@ -504,7 +504,7 @@ pci_parse(const char *name, void *addr)
 }
 
 /* register a driver */
-RTE_EXPORT_INTERNAL_SYMBOL(rte_pci_register)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pci_register);
 void
 rte_pci_register(struct rte_pci_driver *driver)
 {
@@ -512,7 +512,7 @@ rte_pci_register(struct rte_pci_driver *driver)
 }
 
 /* unregister a driver */
-RTE_EXPORT_INTERNAL_SYMBOL(rte_pci_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pci_unregister);
 void
 rte_pci_unregister(struct rte_pci_driver *driver)
 {
@@ -800,7 +800,7 @@ rte_pci_get_iommu_class(void)
 	return iova_mode;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_has_capability_list, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_has_capability_list, 23.11);
 bool
 rte_pci_has_capability_list(const struct rte_pci_device *dev)
 {
@@ -812,14 +812,14 @@ rte_pci_has_capability_list(const struct rte_pci_device *dev)
 	return (status & RTE_PCI_STATUS_CAP_LIST) != 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_find_capability, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_find_capability, 23.11);
 off_t
 rte_pci_find_capability(const struct rte_pci_device *dev, uint8_t cap)
 {
 	return rte_pci_find_next_capability(dev, cap, 0);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_find_next_capability, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_find_next_capability, 23.11);
 off_t
 rte_pci_find_next_capability(const struct rte_pci_device *dev, uint8_t cap,
 	off_t offset)
@@ -857,7 +857,7 @@ rte_pci_find_next_capability(const struct rte_pci_device *dev, uint8_t cap,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_find_ext_capability, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_find_ext_capability, 20.11);
 off_t
 rte_pci_find_ext_capability(const struct rte_pci_device *dev, uint32_t cap)
 {
@@ -900,7 +900,7 @@ rte_pci_find_ext_capability(const struct rte_pci_device *dev, uint32_t cap)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_set_bus_master, 21.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_set_bus_master, 21.08);
 int
 rte_pci_set_bus_master(const struct rte_pci_device *dev, bool enable)
 {
@@ -929,7 +929,7 @@ rte_pci_set_bus_master(const struct rte_pci_device *dev, bool enable)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_pci_pasid_set_state)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pci_pasid_set_state);
 int
 rte_pci_pasid_set_state(const struct rte_pci_device *dev,
 		off_t offset, bool enable)
diff --git a/drivers/bus/pci/windows/pci.c b/drivers/bus/pci/windows/pci.c
index e7e449306e..fc899efd3b 100644
--- a/drivers/bus/pci/windows/pci.c
+++ b/drivers/bus/pci/windows/pci.c
@@ -37,7 +37,7 @@ DEFINE_DEVPROPKEY(DEVPKEY_Device_Numa_Node, 0x540b947e, 0x8b40, 0x45bc,
  */
 
 /* Map pci device */
-RTE_EXPORT_SYMBOL(rte_pci_map_device)
+RTE_EXPORT_SYMBOL(rte_pci_map_device);
 int
 rte_pci_map_device(struct rte_pci_device *dev)
 {
@@ -52,7 +52,7 @@ rte_pci_map_device(struct rte_pci_device *dev)
 }
 
 /* Unmap pci device */
-RTE_EXPORT_SYMBOL(rte_pci_unmap_device)
+RTE_EXPORT_SYMBOL(rte_pci_unmap_device);
 void
 rte_pci_unmap_device(struct rte_pci_device *dev __rte_unused)
 {
@@ -64,7 +64,7 @@ rte_pci_unmap_device(struct rte_pci_device *dev __rte_unused)
 }
 
 /* Read PCI config space. */
-RTE_EXPORT_SYMBOL(rte_pci_read_config)
+RTE_EXPORT_SYMBOL(rte_pci_read_config);
 int
 rte_pci_read_config(const struct rte_pci_device *dev __rte_unused,
 	void *buf __rte_unused, size_t len __rte_unused,
@@ -79,7 +79,7 @@ rte_pci_read_config(const struct rte_pci_device *dev __rte_unused,
 }
 
 /* Write PCI config space. */
-RTE_EXPORT_SYMBOL(rte_pci_write_config)
+RTE_EXPORT_SYMBOL(rte_pci_write_config);
 int
 rte_pci_write_config(const struct rte_pci_device *dev __rte_unused,
 	const void *buf __rte_unused, size_t len __rte_unused,
@@ -94,7 +94,7 @@ rte_pci_write_config(const struct rte_pci_device *dev __rte_unused,
 }
 
 /* Read PCI MMIO space. */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_mmio_read, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_mmio_read, 23.07);
 int
 rte_pci_mmio_read(const struct rte_pci_device *dev, int bar,
 		      void *buf, size_t len, off_t offset)
@@ -107,7 +107,7 @@ rte_pci_mmio_read(const struct rte_pci_device *dev, int bar,
 }
 
 /* Write PCI MMIO space. */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_mmio_write, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pci_mmio_write, 23.07);
 int
 rte_pci_mmio_write(const struct rte_pci_device *dev, int bar,
 		       const void *buf, size_t len, off_t offset)
@@ -131,7 +131,7 @@ pci_device_iova_mode(const struct rte_pci_driver *pdrv __rte_unused,
 	return RTE_IOVA_DC;
 }
 
-RTE_EXPORT_SYMBOL(rte_pci_ioport_map)
+RTE_EXPORT_SYMBOL(rte_pci_ioport_map);
 int
 rte_pci_ioport_map(struct rte_pci_device *dev __rte_unused,
 	int bar __rte_unused, struct rte_pci_ioport *p __rte_unused)
@@ -145,7 +145,7 @@ rte_pci_ioport_map(struct rte_pci_device *dev __rte_unused,
 }
 
 
-RTE_EXPORT_SYMBOL(rte_pci_ioport_read)
+RTE_EXPORT_SYMBOL(rte_pci_ioport_read);
 void
 rte_pci_ioport_read(struct rte_pci_ioport *p __rte_unused,
 	void *data __rte_unused, size_t len __rte_unused,
@@ -158,7 +158,7 @@ rte_pci_ioport_read(struct rte_pci_ioport *p __rte_unused,
 	 */
 }
 
-RTE_EXPORT_SYMBOL(rte_pci_ioport_unmap)
+RTE_EXPORT_SYMBOL(rte_pci_ioport_unmap);
 int
 rte_pci_ioport_unmap(struct rte_pci_ioport *p __rte_unused)
 {
@@ -181,7 +181,7 @@ pci_device_iommu_support_va(const struct rte_pci_device *dev __rte_unused)
 	return false;
 }
 
-RTE_EXPORT_SYMBOL(rte_pci_ioport_write)
+RTE_EXPORT_SYMBOL(rte_pci_ioport_write);
 void
 rte_pci_ioport_write(struct rte_pci_ioport *p __rte_unused,
 		const void *data __rte_unused, size_t len __rte_unused,
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 0f50027236..9fdbb29e19 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -29,14 +29,14 @@
 
 #define PLATFORM_BUS_DEVICES_PATH "/sys/bus/platform/devices"
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_platform_register)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_platform_register);
 void
 rte_platform_register(struct rte_platform_driver *pdrv)
 {
 	TAILQ_INSERT_TAIL(&platform_bus.driver_list, pdrv, next);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_platform_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_platform_unregister);
 void
 rte_platform_unregister(struct rte_platform_driver *pdrv)
 {
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index 87e68b3dbf..679738c665 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -583,7 +583,7 @@ uacce_dev_iterate(const void *start, const char *str,
 	return dev;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_avail_queues)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_avail_queues);
 int
 rte_uacce_avail_queues(struct rte_uacce_device *dev)
 {
@@ -597,7 +597,7 @@ rte_uacce_avail_queues(struct rte_uacce_device *dev)
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_queue_alloc)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_queue_alloc);
 int
 rte_uacce_queue_alloc(struct rte_uacce_device *dev, struct rte_uacce_qcontex *qctx)
 {
@@ -612,7 +612,7 @@ rte_uacce_queue_alloc(struct rte_uacce_device *dev, struct rte_uacce_qcontex *qc
 	return -EIO;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_queue_free)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_queue_free);
 void
 rte_uacce_queue_free(struct rte_uacce_qcontex *qctx)
 {
@@ -622,7 +622,7 @@ rte_uacce_queue_free(struct rte_uacce_qcontex *qctx)
 	qctx->fd = -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_queue_start)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_queue_start);
 int
 rte_uacce_queue_start(struct rte_uacce_qcontex *qctx)
 {
@@ -630,7 +630,7 @@ rte_uacce_queue_start(struct rte_uacce_qcontex *qctx)
 	return ioctl(qctx->fd, UACCE_CMD_START_Q);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_queue_ioctl)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_queue_ioctl);
 int
 rte_uacce_queue_ioctl(struct rte_uacce_qcontex *qctx, unsigned long cmd, void *arg)
 {
@@ -640,7 +640,7 @@ rte_uacce_queue_ioctl(struct rte_uacce_qcontex *qctx, unsigned long cmd, void *a
 	return ioctl(qctx->fd, cmd, arg);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_queue_mmap)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_queue_mmap);
 void *
 rte_uacce_queue_mmap(struct rte_uacce_qcontex *qctx, enum rte_uacce_qfrt qfrt)
 {
@@ -666,7 +666,7 @@ rte_uacce_queue_mmap(struct rte_uacce_qcontex *qctx, enum rte_uacce_qfrt qfrt)
 	return addr;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_queue_unmap)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_queue_unmap);
 void
 rte_uacce_queue_unmap(struct rte_uacce_qcontex *qctx, enum rte_uacce_qfrt qfrt)
 {
@@ -676,7 +676,7 @@ rte_uacce_queue_unmap(struct rte_uacce_qcontex *qctx, enum rte_uacce_qfrt qfrt)
 	}
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_register)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_register);
 void
 rte_uacce_register(struct rte_uacce_driver *driver)
 {
@@ -684,7 +684,7 @@ rte_uacce_register(struct rte_uacce_driver *driver)
 	driver->bus = &uacce_bus;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_uacce_unregister);
 void
 rte_uacce_unregister(struct rte_uacce_driver *driver)
 {
diff --git a/drivers/bus/vdev/vdev.c b/drivers/bus/vdev/vdev.c
index be375f63dc..c1c510c448 100644
--- a/drivers/bus/vdev/vdev.c
+++ b/drivers/bus/vdev/vdev.c
@@ -52,7 +52,7 @@ static struct vdev_custom_scans vdev_custom_scans =
 static rte_spinlock_t vdev_custom_scan_lock = RTE_SPINLOCK_INITIALIZER;
 
 /* register a driver */
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vdev_register)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vdev_register);
 void
 rte_vdev_register(struct rte_vdev_driver *driver)
 {
@@ -60,14 +60,14 @@ rte_vdev_register(struct rte_vdev_driver *driver)
 }
 
 /* unregister a driver */
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vdev_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vdev_unregister);
 void
 rte_vdev_unregister(struct rte_vdev_driver *driver)
 {
 	TAILQ_REMOVE(&vdev_driver_list, driver, next);
 }
 
-RTE_EXPORT_SYMBOL(rte_vdev_add_custom_scan)
+RTE_EXPORT_SYMBOL(rte_vdev_add_custom_scan);
 int
 rte_vdev_add_custom_scan(rte_vdev_scan_callback callback, void *user_arg)
 {
@@ -96,7 +96,7 @@ rte_vdev_add_custom_scan(rte_vdev_scan_callback callback, void *user_arg)
 	return (custom_scan == NULL) ? -1 : 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vdev_remove_custom_scan)
+RTE_EXPORT_SYMBOL(rte_vdev_remove_custom_scan);
 int
 rte_vdev_remove_custom_scan(rte_vdev_scan_callback callback, void *user_arg)
 {
@@ -321,7 +321,7 @@ insert_vdev(const char *name, const char *args,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_vdev_init)
+RTE_EXPORT_SYMBOL(rte_vdev_init);
 int
 rte_vdev_init(const char *name, const char *args)
 {
@@ -361,7 +361,7 @@ vdev_remove_driver(struct rte_vdev_device *dev)
 	return driver->remove(dev);
 }
 
-RTE_EXPORT_SYMBOL(rte_vdev_uninit)
+RTE_EXPORT_SYMBOL(rte_vdev_uninit);
 int
 rte_vdev_uninit(const char *name)
 {
diff --git a/drivers/bus/vmbus/linux/vmbus_bus.c b/drivers/bus/vmbus/linux/vmbus_bus.c
index ed18d4da96..67c17b9286 100644
--- a/drivers/bus/vmbus/linux/vmbus_bus.c
+++ b/drivers/bus/vmbus/linux/vmbus_bus.c
@@ -165,7 +165,7 @@ static const char *map_names[VMBUS_MAX_RESOURCE] = {
 
 
 /* map the resources of a vmbus device in virtual memory */
-RTE_EXPORT_SYMBOL(rte_vmbus_map_device)
+RTE_EXPORT_SYMBOL(rte_vmbus_map_device);
 int
 rte_vmbus_map_device(struct rte_vmbus_device *dev)
 {
@@ -224,7 +224,7 @@ rte_vmbus_map_device(struct rte_vmbus_device *dev)
 	return vmbus_uio_map_resource(dev);
 }
 
-RTE_EXPORT_SYMBOL(rte_vmbus_unmap_device)
+RTE_EXPORT_SYMBOL(rte_vmbus_unmap_device);
 void
 rte_vmbus_unmap_device(struct rte_vmbus_device *dev)
 {
@@ -341,7 +341,7 @@ vmbus_scan_one(const char *name)
 /*
  * Scan the content of the vmbus, and the devices in the devices list
  */
-RTE_EXPORT_SYMBOL(rte_vmbus_scan)
+RTE_EXPORT_SYMBOL(rte_vmbus_scan);
 int
 rte_vmbus_scan(void)
 {
@@ -373,19 +373,19 @@ rte_vmbus_scan(void)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_vmbus_irq_mask)
+RTE_EXPORT_SYMBOL(rte_vmbus_irq_mask);
 void rte_vmbus_irq_mask(struct rte_vmbus_device *device)
 {
 	vmbus_uio_irq_control(device, 1);
 }
 
-RTE_EXPORT_SYMBOL(rte_vmbus_irq_unmask)
+RTE_EXPORT_SYMBOL(rte_vmbus_irq_unmask);
 void rte_vmbus_irq_unmask(struct rte_vmbus_device *device)
 {
 	vmbus_uio_irq_control(device, 0);
 }
 
-RTE_EXPORT_SYMBOL(rte_vmbus_irq_read)
+RTE_EXPORT_SYMBOL(rte_vmbus_irq_read);
 int rte_vmbus_irq_read(struct rte_vmbus_device *device)
 {
 	return vmbus_uio_irq_read(device);
diff --git a/drivers/bus/vmbus/vmbus_channel.c b/drivers/bus/vmbus/vmbus_channel.c
index a876c909dd..03820015ae 100644
--- a/drivers/bus/vmbus/vmbus_channel.c
+++ b/drivers/bus/vmbus/vmbus_channel.c
@@ -48,7 +48,7 @@ vmbus_set_event(const struct vmbus_channel *chan)
 /*
  * Set the wait between when hypervisor examines the trigger.
  */
-RTE_EXPORT_SYMBOL(rte_vmbus_set_latency)
+RTE_EXPORT_SYMBOL(rte_vmbus_set_latency);
 void
 rte_vmbus_set_latency(const struct rte_vmbus_device *dev,
 		      const struct vmbus_channel *chan,
@@ -78,7 +78,7 @@ rte_vmbus_set_latency(const struct rte_vmbus_device *dev,
  * Since this in userspace, rely on the monitor page.
  * Can't do a hypercall from userspace.
  */
-RTE_EXPORT_SYMBOL(rte_vmbus_chan_signal_tx)
+RTE_EXPORT_SYMBOL(rte_vmbus_chan_signal_tx);
 void
 rte_vmbus_chan_signal_tx(const struct vmbus_channel *chan)
 {
@@ -96,7 +96,7 @@ rte_vmbus_chan_signal_tx(const struct vmbus_channel *chan)
 
 
 /* Do a simple send directly using transmit ring. */
-RTE_EXPORT_SYMBOL(rte_vmbus_chan_send)
+RTE_EXPORT_SYMBOL(rte_vmbus_chan_send);
 int rte_vmbus_chan_send(struct vmbus_channel *chan, uint16_t type,
 			void *data, uint32_t dlen,
 			uint64_t xactid, uint32_t flags, bool *need_sig)
@@ -140,7 +140,7 @@ int rte_vmbus_chan_send(struct vmbus_channel *chan, uint16_t type,
 }
 
 /* Do a scatter/gather send where the descriptor points to data. */
-RTE_EXPORT_SYMBOL(rte_vmbus_chan_send_sglist)
+RTE_EXPORT_SYMBOL(rte_vmbus_chan_send_sglist);
 int rte_vmbus_chan_send_sglist(struct vmbus_channel *chan,
 			       struct vmbus_gpa sg[], uint32_t sglen,
 			       void *data, uint32_t dlen,
@@ -184,7 +184,7 @@ int rte_vmbus_chan_send_sglist(struct vmbus_channel *chan,
 	return error;
 }
 
-RTE_EXPORT_SYMBOL(rte_vmbus_chan_rx_empty)
+RTE_EXPORT_SYMBOL(rte_vmbus_chan_rx_empty);
 bool rte_vmbus_chan_rx_empty(const struct vmbus_channel *channel)
 {
 	const struct vmbus_br *br = &channel->rxbr;
@@ -194,7 +194,7 @@ bool rte_vmbus_chan_rx_empty(const struct vmbus_channel *channel)
 }
 
 /* Signal host after reading N bytes */
-RTE_EXPORT_SYMBOL(rte_vmbus_chan_signal_read)
+RTE_EXPORT_SYMBOL(rte_vmbus_chan_signal_read);
 void rte_vmbus_chan_signal_read(struct vmbus_channel *chan, uint32_t bytes_read)
 {
 	struct vmbus_br *rbr = &chan->rxbr;
@@ -225,7 +225,7 @@ void rte_vmbus_chan_signal_read(struct vmbus_channel *chan, uint32_t bytes_read)
 	vmbus_set_event(chan);
 }
 
-RTE_EXPORT_SYMBOL(rte_vmbus_chan_recv)
+RTE_EXPORT_SYMBOL(rte_vmbus_chan_recv);
 int rte_vmbus_chan_recv(struct vmbus_channel *chan, void *data, uint32_t *len,
 			uint64_t *request_id)
 {
@@ -273,7 +273,7 @@ int rte_vmbus_chan_recv(struct vmbus_channel *chan, void *data, uint32_t *len,
 }
 
 /* TODO: replace this with inplace ring buffer (no copy) */
-RTE_EXPORT_SYMBOL(rte_vmbus_chan_recv_raw)
+RTE_EXPORT_SYMBOL(rte_vmbus_chan_recv_raw);
 int rte_vmbus_chan_recv_raw(struct vmbus_channel *chan,
 			    void *data, uint32_t *len)
 {
@@ -344,7 +344,7 @@ int vmbus_chan_create(const struct rte_vmbus_device *device,
 }
 
 /* Setup the primary channel */
-RTE_EXPORT_SYMBOL(rte_vmbus_chan_open)
+RTE_EXPORT_SYMBOL(rte_vmbus_chan_open);
 int rte_vmbus_chan_open(struct rte_vmbus_device *device,
 			struct vmbus_channel **new_chan)
 {
@@ -365,7 +365,7 @@ int rte_vmbus_chan_open(struct rte_vmbus_device *device,
 	return err;
 }
 
-RTE_EXPORT_SYMBOL(rte_vmbus_max_channels)
+RTE_EXPORT_SYMBOL(rte_vmbus_max_channels);
 int rte_vmbus_max_channels(const struct rte_vmbus_device *device)
 {
 	if (vmbus_uio_subchannels_supported(device, device->primary))
@@ -375,7 +375,7 @@ int rte_vmbus_max_channels(const struct rte_vmbus_device *device)
 }
 
 /* Setup secondary channel */
-RTE_EXPORT_SYMBOL(rte_vmbus_subchan_open)
+RTE_EXPORT_SYMBOL(rte_vmbus_subchan_open);
 int rte_vmbus_subchan_open(struct vmbus_channel *primary,
 			   struct vmbus_channel **new_chan)
 {
@@ -391,13 +391,13 @@ int rte_vmbus_subchan_open(struct vmbus_channel *primary,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_vmbus_sub_channel_index)
+RTE_EXPORT_SYMBOL(rte_vmbus_sub_channel_index);
 uint16_t rte_vmbus_sub_channel_index(const struct vmbus_channel *chan)
 {
 	return chan->subchannel_id;
 }
 
-RTE_EXPORT_SYMBOL(rte_vmbus_chan_close)
+RTE_EXPORT_SYMBOL(rte_vmbus_chan_close);
 void rte_vmbus_chan_close(struct vmbus_channel *chan)
 {
 	const struct rte_vmbus_device *device = chan->device;
diff --git a/drivers/bus/vmbus/vmbus_common.c b/drivers/bus/vmbus/vmbus_common.c
index a787d8b18d..a567b0755b 100644
--- a/drivers/bus/vmbus/vmbus_common.c
+++ b/drivers/bus/vmbus/vmbus_common.c
@@ -192,7 +192,7 @@ vmbus_ignore_device(struct rte_vmbus_device *dev)
  * all registered drivers that have a matching entry in its id_table
  * for discovered devices.
  */
-RTE_EXPORT_SYMBOL(rte_vmbus_probe)
+RTE_EXPORT_SYMBOL(rte_vmbus_probe);
 int
 rte_vmbus_probe(void)
 {
@@ -282,7 +282,7 @@ vmbus_devargs_lookup(struct rte_vmbus_device *dev)
 }
 
 /* register vmbus driver */
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_register)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_register);
 void
 rte_vmbus_register(struct rte_vmbus_driver *driver)
 {
@@ -293,7 +293,7 @@ rte_vmbus_register(struct rte_vmbus_driver *driver)
 }
 
 /* unregister vmbus driver */
-RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_vmbus_unregister);
 void
 rte_vmbus_unregister(struct rte_vmbus_driver *driver)
 {
diff --git a/drivers/common/cnxk/cnxk_security.c b/drivers/common/cnxk/cnxk_security.c
index 0e6777e6ca..17048c1a7e 100644
--- a/drivers/common/cnxk/cnxk_security.c
+++ b/drivers/common/cnxk/cnxk_security.c
@@ -305,7 +305,7 @@ ot_ipsec_inb_tunnel_hdr_fill(struct roc_ot_ipsec_inb_sa *sa,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ot_ipsec_inb_sa_fill)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ot_ipsec_inb_sa_fill);
 int
 cnxk_ot_ipsec_inb_sa_fill(struct roc_ot_ipsec_inb_sa *sa,
 			  struct rte_security_ipsec_xform *ipsec_xfrm,
@@ -415,7 +415,7 @@ cnxk_ot_ipsec_inb_sa_fill(struct roc_ot_ipsec_inb_sa *sa,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ot_ipsec_outb_sa_fill)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ot_ipsec_outb_sa_fill);
 int
 cnxk_ot_ipsec_outb_sa_fill(struct roc_ot_ipsec_outb_sa *sa,
 			   struct rte_security_ipsec_xform *ipsec_xfrm,
@@ -580,21 +580,21 @@ cnxk_ot_ipsec_outb_sa_fill(struct roc_ot_ipsec_outb_sa *sa,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ot_ipsec_inb_sa_valid)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ot_ipsec_inb_sa_valid);
 bool
 cnxk_ot_ipsec_inb_sa_valid(struct roc_ot_ipsec_inb_sa *sa)
 {
 	return !!sa->w2.s.valid;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ot_ipsec_outb_sa_valid)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ot_ipsec_outb_sa_valid);
 bool
 cnxk_ot_ipsec_outb_sa_valid(struct roc_ot_ipsec_outb_sa *sa)
 {
 	return !!sa->w2.s.valid;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ipsec_ivlen_get)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ipsec_ivlen_get);
 uint8_t
 cnxk_ipsec_ivlen_get(enum rte_crypto_cipher_algorithm c_algo,
 		     enum rte_crypto_auth_algorithm a_algo,
@@ -631,7 +631,7 @@ cnxk_ipsec_ivlen_get(enum rte_crypto_cipher_algorithm c_algo,
 	return ivlen;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ipsec_icvlen_get)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ipsec_icvlen_get);
 uint8_t
 cnxk_ipsec_icvlen_get(enum rte_crypto_cipher_algorithm c_algo,
 		      enum rte_crypto_auth_algorithm a_algo,
@@ -678,7 +678,7 @@ cnxk_ipsec_icvlen_get(enum rte_crypto_cipher_algorithm c_algo,
 	return icv;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ipsec_outb_roundup_byte)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ipsec_outb_roundup_byte);
 uint8_t
 cnxk_ipsec_outb_roundup_byte(enum rte_crypto_cipher_algorithm c_algo,
 			     enum rte_crypto_aead_algorithm aead_algo)
@@ -709,7 +709,7 @@ cnxk_ipsec_outb_roundup_byte(enum rte_crypto_cipher_algorithm c_algo,
 	return roundup_byte;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ipsec_outb_rlens_get)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ipsec_outb_rlens_get);
 int
 cnxk_ipsec_outb_rlens_get(struct cnxk_ipsec_outb_rlens *rlens,
 			  struct rte_security_ipsec_xform *ipsec_xfrm,
@@ -984,7 +984,7 @@ on_fill_ipsec_common_sa(struct rte_security_ipsec_xform *ipsec,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_on_ipsec_outb_sa_create)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_on_ipsec_outb_sa_create);
 int
 cnxk_on_ipsec_outb_sa_create(struct rte_security_ipsec_xform *ipsec,
 			     struct rte_crypto_sym_xform *crypto_xform,
@@ -1130,7 +1130,7 @@ cnxk_on_ipsec_outb_sa_create(struct rte_security_ipsec_xform *ipsec,
 	return ctx_len;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_on_ipsec_inb_sa_create)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_on_ipsec_inb_sa_create);
 int
 cnxk_on_ipsec_inb_sa_create(struct rte_security_ipsec_xform *ipsec,
 			    struct rte_crypto_sym_xform *crypto_xform,
@@ -1484,7 +1484,7 @@ ow_ipsec_inb_tunnel_hdr_fill(struct roc_ow_ipsec_inb_sa *sa,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ow_ipsec_inb_sa_fill)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ow_ipsec_inb_sa_fill);
 int
 cnxk_ow_ipsec_inb_sa_fill(struct roc_ow_ipsec_inb_sa *sa,
 			  struct rte_security_ipsec_xform *ipsec_xfrm,
@@ -1591,7 +1591,7 @@ cnxk_ow_ipsec_inb_sa_fill(struct roc_ow_ipsec_inb_sa *sa,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ow_ipsec_outb_sa_fill)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ow_ipsec_outb_sa_fill);
 int
 cnxk_ow_ipsec_outb_sa_fill(struct roc_ow_ipsec_outb_sa *sa,
 			   struct rte_security_ipsec_xform *ipsec_xfrm,
diff --git a/drivers/common/cnxk/cnxk_utils.c b/drivers/common/cnxk/cnxk_utils.c
index 8ca4664d25..cbd8779ce4 100644
--- a/drivers/common/cnxk/cnxk_utils.c
+++ b/drivers/common/cnxk/cnxk_utils.c
@@ -10,7 +10,7 @@
 
 #include "cnxk_utils.h"
 
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_err_to_rte_err)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_err_to_rte_err);
 int
 roc_nix_tm_err_to_rte_err(int errorcode)
 {
diff --git a/drivers/common/cnxk/roc_platform.c b/drivers/common/cnxk/roc_platform.c
index 88f229163a..b511e2d17e 100644
--- a/drivers/common/cnxk/roc_platform.c
+++ b/drivers/common/cnxk/roc_platform.c
@@ -243,7 +243,7 @@ plt_irq_unregister(struct plt_intr_handle *intr_handle, plt_intr_callback_fn cb,
 static int plt_init_cb_num;
 static roc_plt_init_cb_t plt_init_cbs[PLT_INIT_CB_MAX];
 
-RTE_EXPORT_INTERNAL_SYMBOL(roc_plt_init_cb_register)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_plt_init_cb_register);
 int
 roc_plt_init_cb_register(roc_plt_init_cb_t cb)
 {
@@ -254,7 +254,7 @@ roc_plt_init_cb_register(roc_plt_init_cb_t cb)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(roc_plt_control_lmt_id_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_plt_control_lmt_id_get);
 uint16_t
 roc_plt_control_lmt_id_get(void)
 {
@@ -266,7 +266,7 @@ roc_plt_control_lmt_id_get(void)
 		return ROC_NUM_LMT_LINES - 1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(roc_plt_lmt_validate)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_plt_lmt_validate);
 uint16_t
 roc_plt_lmt_validate(void)
 {
@@ -281,7 +281,7 @@ roc_plt_lmt_validate(void)
 	return 1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(roc_plt_init)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_plt_init);
 int
 roc_plt_init(void)
 {
@@ -321,31 +321,31 @@ roc_plt_init(void)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_base)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_base);
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_base, base, INFO);
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_mbox)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_mbox);
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_mbox, mbox, NOTICE);
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_cpt)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_cpt);
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_cpt, crypto, NOTICE);
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_ml)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_ml);
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_ml, ml, NOTICE);
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_npa)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_npa);
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_npa, mempool, NOTICE);
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_nix)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_nix);
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_nix, nix, NOTICE);
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_npc)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_npc);
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_npc, flow, NOTICE);
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_sso)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_sso);
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_sso, event, NOTICE);
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_tim)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_tim);
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_tim, timer, NOTICE);
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_tm)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_tm);
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_tm, tm, NOTICE);
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_dpi)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_dpi);
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_dpi, dpi, NOTICE);
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_rep)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_rep);
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_rep, rep, NOTICE);
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_esw)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_esw);
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_esw, esw, NOTICE);
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_ree)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_logtype_ree);
 RTE_LOG_REGISTER_SUFFIX(cnxk_logtype_ree, ree, NOTICE);
diff --git a/drivers/common/cnxk/roc_platform_base_symbols.c b/drivers/common/cnxk/roc_platform_base_symbols.c
index 7f0fe601ad..b8d2026dd5 100644
--- a/drivers/common/cnxk/roc_platform_base_symbols.c
+++ b/drivers/common/cnxk/roc_platform_base_symbols.c
@@ -5,545 +5,545 @@
 #include <eal_export.h>
 
 /* Symbols from the base driver are exported separately below. */
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ae_ec_grp_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ae_ec_grp_put)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ae_fpm_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ae_fpm_put)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_aes_xcbc_key_derive)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_aes_hash_key_derive)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_dev_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_dev_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_npa_pf_func_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_sso_pf_func_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_dev_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_dev_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_start_rxtx)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_stop_rxtx)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_set_link_state)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_get_linkinfo)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_set_link_mode)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_intlbk_enable)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_intlbk_disable)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_ptp_rx_enable)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_ptp_rx_disable)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_fec_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_fec_supported_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_cpri_mode_change)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_cpri_mode_tx_control)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_cpri_mode_misc)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_intr_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_intr_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_intr_handler)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_intr_available)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_intr_max_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_intr_clear)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_intr_register)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_inline_ipsec_cfg)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_inline_ipsec_inb_cfg_read)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_inline_ipsec_inb_cfg)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_rxc_time_cfg)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_dev_configure)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_lf_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_dev_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_lf_ctx_flush)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_lf_ctx_reload)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_lf_reset)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_lf_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_dev_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_dev_clear)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_eng_grp_add)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_iq_disable)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_iq_enable)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_lmtline_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_ctx_write)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_int_misc_cb_register)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_int_misc_cb_unregister)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_parse_hdr_dump)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_afs_print)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_lfs_print)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_wait_queue_idle)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_enable)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_disable)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_configure)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_configure_v2)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_dev_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_dev_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_npc_mcam_tx_rule)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_npc_mcam_delete_rule)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_npc_mcam_rx_rule)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_npc_rss_action_configure)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_nix_vlan_tpid_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_nix_process_repte_notify_cb_register)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_nix_process_repte_notify_cb_unregister)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_nix_repte_stats)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_is_repte_pfs_vf)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_hash_md5_gen)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_hash_sha1_gen)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_hash_sha256_gen)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_hash_sha512_gen)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_npa_maxpools_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_npa_maxpools_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_lmt_base_addr_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_num_lmtlines_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_cpt_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_rvu_lf_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_rvu_lf_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_rvu_lf_free)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_mcs_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_mcs_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_mcs_free)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_ring_base_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_nix_list_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_cpt_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_npa_nix_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_nix_inl_meta_aura_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_nix_rx_inject_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_nix_rx_inject_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_nix_rx_chan_base_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_nix_rx_chan_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_nix_inl_dev_pffunc_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ot_ipsec_inb_sa_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ot_ipsec_outb_sa_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ow_ipsec_inb_sa_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ow_reass_inb_sa_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ow_ipsec_outb_sa_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_is_supported)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_hw_info_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_active_lmac_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_lmac_mode_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_pn_threshold_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_ctrl_pkt_rule_alloc)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_ctrl_pkt_rule_free)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_ctrl_pkt_rule_write)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_port_cfg_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_port_cfg_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_custom_tag_cfg_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_intr_configure)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_port_recovery)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_port_reset)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_event_cb_register)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_event_cb_unregister)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_dev_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_dev_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_rsrc_alloc)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_rsrc_free)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_sa_policy_write)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_sa_policy_read)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_pn_table_write)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_pn_table_read)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_rx_sc_cam_write)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_rx_sc_cam_read)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_rx_sc_cam_enable)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_secy_policy_write)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_secy_policy_read)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_rx_sc_sa_map_write)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_rx_sc_sa_map_read)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_tx_sc_sa_map_write)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_tx_sc_sa_map_read)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_flowid_entry_write)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_flowid_entry_read)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_flowid_entry_enable)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_sa_port_map_update)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_flowid_stats_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_secy_stats_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_sc_stats_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_port_stats_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_stats_clear)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_reg_read64)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_reg_write64)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_reg_read32)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_reg_write32)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_reg_save)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_addr_ap2mlip)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_addr_mlip2ap)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_addr_pa_to_offset)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_addr_offset_to_pa)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_scratch_write_job)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_scratch_is_valid_bit_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_scratch_is_done_bit_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_scratch_enqueue)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_scratch_dequeue)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_scratch_queue_reset)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_jcmdq_enqueue_lf)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_jcmdq_enqueue_sl)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_clk_force_on)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_clk_force_off)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_dma_stall_on)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_dma_stall_off)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_mlip_is_enabled)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_mlip_reset)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_dev_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_dev_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_blk_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_blk_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_sso_pf_func_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_model)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_is_lbk)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_is_esw)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_get_base_chan)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_get_rx_chan_cnt)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_get_vwqe_interval)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_is_sdp)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_is_pf)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_get_pf)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_get_vf)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_is_vf_or_sdp)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_get_pf_func)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lf_inl_ipsec_cfg)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_cpt_ctx_cache_sync)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_max_pkt_len)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lf_alloc)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lf_free)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_dev_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_dev_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_max_rep_count)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_level_to_idx)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_stats_to_idx)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_timeunit_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_count_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_alloc)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_free)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_free_all)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_config)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_ena_dis)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_dump)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_pre_color_tbl_setup)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_connect)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_stats_read)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_stats_reset)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_lf_stats_read)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_lf_stats_reset)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lf_get_reg_count)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lf_reg_dump)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_queues_ctx_dump)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_cqe_dump)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_dump)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_cq_dump)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_sq_dump)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_dump)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_dump)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_dump)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_cpt_lfs_dump)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_sq_desc_dump)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_fc_config_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_fc_config_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_fc_mode_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_fc_mode_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_fc_npa_bp_cfg)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_pfc_mode_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_pfc_mode_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_chan_count_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpids_alloc)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpids_free)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rx_chan_cfg_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rx_chan_cfg_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_chan_bpid_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_meta_aura_check)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_lf_base_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_inj_lf_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_sa_base_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_sa_base_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_rx_inject_enable)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_spi_range)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_sa_sz)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_sa_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_reassembly_configure)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_is_probed)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_is_multi_channel)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_is_enabled)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_is_enabled)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_rq_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_rq_put)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_rq_ena_dis)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inb_mode_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_soft_exp_poll_switch)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inb_is_with_inl_dev)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_rq)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_sso_pffunc_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_cb_register)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_cb_unregister)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_tag_update)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_sa_sync)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_ctx_write)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_cpt_lf_stats_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_ts_pkind_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_lock)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_unlock)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_meta_pool_cb_register)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_eng_caps_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_custom_meta_pool_cb_register)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_xaq_realloc)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_qptr_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_stats_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_stats_reset)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_cpt_setup)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_cpt_release)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rx_queue_intr_enable)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rx_queue_intr_disable)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_err_intr_ena_dis)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_ras_intr_ena_dis)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_register_queue_irqs)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_unregister_queue_irqs)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_register_cq_irqs)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_unregister_cq_irqs)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_rxtx_start_stop)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_event_start_stop)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_loopback_enable)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_addr_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_max_entries_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_addr_add)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_addr_del)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_promisc_mode_enable)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_info_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_state_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_info_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_mtu_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_max_rx_len_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_stats_reset)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_cb_register)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_cb_unregister)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_info_get_cb_register)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_info_get_cb_unregister)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mcast_mcam_entry_alloc)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mcast_mcam_entry_free)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mcast_mcam_entry_write)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mcast_mcam_entry_ena_dis)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mcast_list_setup)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mcast_list_free)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_npc_promisc_ena_dis)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_npc_mac_addr_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_npc_mac_addr_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_npc_rx_ena_dis)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_npc_mcast_config)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lso_custom_fmt_setup)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lso_fmt_setup)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lso_fmt_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_switch_hdr_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_eeprom_info_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rx_drop_re_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_ptp_rx_ena_dis)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_ptp_tx_ena_dis)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_ptp_clock_read)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_ptp_sync_time_adjust)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_ptp_info_cb_register)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_ptp_info_cb_unregister)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_ptp_is_enable)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_sq_ena_dis)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_ena_dis)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_is_sso_enable)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_modify)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_cman_config)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_cq_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_cq_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_sq_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_sq_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_cq_head_tail_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_sq_head_tail_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_q_err_cb_register)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_q_err_cb_unregister)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rss_key_default_fill)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rss_key_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rss_key_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rss_reta_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rss_reta_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rss_flowkey_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rss_default_setup)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_num_xstats_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_stats_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_stats_reset)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_stats_queue_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_stats_queue_reset)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_xstats_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_xstats_names_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_sq_flush_spin)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_prepare_rate_limited_tree)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_pfc_prepare_tree)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_mark_config)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_mark_format_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_sq_aura_fc)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_free_resources)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_shaper_profile_add)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_shaper_profile_update)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_shaper_profile_delete)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_add)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_pkt_mode_update)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_name_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_delete)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_smq_flush)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_hierarchy_disable)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_hierarchy_xmit_enable)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_hierarchy_enable)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_suspend_resume)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_prealloc_res)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_shaper_update)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_parent_update)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_pfc_rlimit_sq)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_rlimit_sq)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_rsrc_count)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_rsrc_max)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_root_has_sp)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_egress_link_cfg_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_leaf_cnt)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_lvl)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_next)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_shaper_profile_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_shaper_profile_next)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_stats_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_is_user_hierarchy_enabled)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_tree_type_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_max_prio)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_lvl_is_leaf)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_shaper_default_red_algo)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_lvl_cnt_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_lvl_have_link_access)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_vlan_mcam_entry_read)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_vlan_mcam_entry_write)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_vlan_mcam_entry_alloc_and_write)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_vlan_mcam_entry_free)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_vlan_mcam_entry_ena_dis)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_vlan_strip_vtag_ena_dis)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_vlan_insert_ena_dis)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_vlan_tpid_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_lf_init_cb_register)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_pf_func_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_pool_op_range_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_op_range_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_op_range_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_pool_op_pc_reset)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_drop_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_pool_create)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_create)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_limit_modify)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_pool_destroy)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_destroy)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_pool_range_update_check)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_zero_aura_handle)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_bp_configure)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_dev_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_dev_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_dev_lock)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_dev_unlock)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_ctx_dump)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_dump)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_buf_type_update)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_buf_type_mask)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_buf_type_limit_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mark_actions_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mark_actions_sub_return)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_vtag_actions_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_vtag_actions_sub_return)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_free_counter)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_inl_mcam_read_counter)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_inl_mcam_clear_counter)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_alloc_counter)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_get_free_mcam_entry)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_read_counter)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_get_stats)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_clear_counter)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_free_entry)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_free)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_move)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_free_all_resources)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_alloc_entries)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_enable_all_entries)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_alloc_entry)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_ena_dis_entry)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_write_entry)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_get_low_priority_mcam)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_profile_name_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_kex_capa_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_kex_key_type_config_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_validate_portid_action)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_flow_parse)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_sdp_channel_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_flow_create)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_flow_destroy)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_flow_dump)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_merge_base_steering_rule)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_aged_flow_ctx_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_defrag_mcam_banks)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_get_key_type)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_flow_mcam_dump)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_queues_attach)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_queues_detach)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_msix_offsets_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_config_lf)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_af_reg_read)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_af_reg_write)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_rule_db_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_rule_db_len_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_rule_db_prog)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_qp_get_base)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_err_intr_unregister)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_err_intr_register)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_iq_enable)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_iq_disable)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_dev_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_dev_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_dev_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_dev_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_pf_func_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_msg_id_range_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_msg_id_range_check)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_msg_process)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_irq_register)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_irq_unregister)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_msg_handler_register)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_msg_handler_unregister)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_se_hmac_opad_ipad_gen)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_se_auth_key_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_se_ciph_key_set)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_se_ctx_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hws_base_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_base_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_pf_func_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_ns_to_gw)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hws_link)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hws_unlink)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hws_stats_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hws_gwc_invalidate)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_agq_alloc)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_agq_free)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_agq_release)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_agq_from_tag)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_stats_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_hws_link_status)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_qos_config)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_init_xaq_aura)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_free_xaq_aura)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_alloc_xaq)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_release_xaq)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_set_priority)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_stash_config)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_rsrc_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_rsrc_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_dev_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_dev_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_dump)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_lf_enable)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_lf_disable)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_lf_base_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_lf_config)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_lf_config_hwwqe)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_lf_interval)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_lf_alloc)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_lf_free)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_init)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_error_msg_get)
-RTE_EXPORT_INTERNAL_SYMBOL(roc_clk_freq_get)
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ae_ec_grp_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ae_ec_grp_put);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ae_fpm_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ae_fpm_put);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_aes_xcbc_key_derive);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_aes_hash_key_derive);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_dev_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_dev_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_npa_pf_func_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_sso_pf_func_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_dev_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_dev_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_start_rxtx);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_stop_rxtx);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_set_link_state);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_get_linkinfo);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_set_link_mode);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_intlbk_enable);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_intlbk_disable);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_ptp_rx_enable);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_ptp_rx_disable);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_fec_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_fec_supported_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_cpri_mode_change);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_cpri_mode_tx_control);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_cgx_cpri_mode_misc);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_intr_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_intr_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_intr_handler);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_intr_available);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_intr_max_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_intr_clear);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_bphy_intr_register);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_inline_ipsec_cfg);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_inline_ipsec_inb_cfg_read);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_inline_ipsec_inb_cfg);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_rxc_time_cfg);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_dev_configure);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_lf_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_dev_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_lf_ctx_flush);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_lf_ctx_reload);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_lf_reset);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_lf_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_dev_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_dev_clear);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_eng_grp_add);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_iq_disable);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_iq_enable);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_lmtline_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_ctx_write);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_int_misc_cb_register);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_int_misc_cb_unregister);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_parse_hdr_dump);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_afs_print);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_cpt_lfs_print);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_wait_queue_idle);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_enable);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_disable);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_configure);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_configure_v2);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_dev_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_dpi_dev_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_npc_mcam_tx_rule);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_npc_mcam_delete_rule);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_npc_mcam_rx_rule);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_npc_rss_action_configure);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_nix_vlan_tpid_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_nix_process_repte_notify_cb_register);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_nix_process_repte_notify_cb_unregister);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_nix_repte_stats);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_eswitch_is_repte_pfs_vf);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_hash_md5_gen);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_hash_sha1_gen);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_hash_sha256_gen);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_hash_sha512_gen);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_npa_maxpools_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_npa_maxpools_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_lmt_base_addr_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_num_lmtlines_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_cpt_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_rvu_lf_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_rvu_lf_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_rvu_lf_free);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_mcs_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_mcs_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_mcs_free);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_ring_base_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_nix_list_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_cpt_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_npa_nix_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_nix_inl_meta_aura_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_nix_rx_inject_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_nix_rx_inject_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_nix_rx_chan_base_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_nix_rx_chan_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_idev_nix_inl_dev_pffunc_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ot_ipsec_inb_sa_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ot_ipsec_outb_sa_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ow_ipsec_inb_sa_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ow_reass_inb_sa_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ow_ipsec_outb_sa_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_is_supported);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_hw_info_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_active_lmac_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_lmac_mode_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_pn_threshold_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_ctrl_pkt_rule_alloc);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_ctrl_pkt_rule_free);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_ctrl_pkt_rule_write);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_port_cfg_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_port_cfg_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_custom_tag_cfg_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_intr_configure);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_port_recovery);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_port_reset);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_event_cb_register);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_event_cb_unregister);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_dev_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_dev_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_rsrc_alloc);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_rsrc_free);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_sa_policy_write);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_sa_policy_read);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_pn_table_write);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_pn_table_read);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_rx_sc_cam_write);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_rx_sc_cam_read);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_rx_sc_cam_enable);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_secy_policy_write);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_secy_policy_read);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_rx_sc_sa_map_write);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_rx_sc_sa_map_read);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_tx_sc_sa_map_write);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_tx_sc_sa_map_read);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_flowid_entry_write);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_flowid_entry_read);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_flowid_entry_enable);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_sa_port_map_update);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_flowid_stats_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_secy_stats_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_sc_stats_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_port_stats_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_mcs_stats_clear);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_reg_read64);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_reg_write64);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_reg_read32);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_reg_write32);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_reg_save);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_addr_ap2mlip);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_addr_mlip2ap);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_addr_pa_to_offset);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_addr_offset_to_pa);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_scratch_write_job);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_scratch_is_valid_bit_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_scratch_is_done_bit_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_scratch_enqueue);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_scratch_dequeue);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_scratch_queue_reset);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_jcmdq_enqueue_lf);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_jcmdq_enqueue_sl);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_clk_force_on);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_clk_force_off);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_dma_stall_on);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_dma_stall_off);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_mlip_is_enabled);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_mlip_reset);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_dev_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_dev_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_blk_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_blk_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ml_sso_pf_func_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_model);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_is_lbk);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_is_esw);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_get_base_chan);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_get_rx_chan_cnt);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_get_vwqe_interval);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_is_sdp);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_is_pf);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_get_pf);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_get_vf);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_is_vf_or_sdp);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_get_pf_func);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lf_inl_ipsec_cfg);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_cpt_ctx_cache_sync);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_max_pkt_len);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lf_alloc);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lf_free);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_dev_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_dev_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_max_rep_count);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_level_to_idx);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_stats_to_idx);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_timeunit_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_count_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_alloc);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_free);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_free_all);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_config);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_ena_dis);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_dump);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_pre_color_tbl_setup);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_connect);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_stats_read);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_stats_reset);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_lf_stats_read);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpf_lf_stats_reset);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lf_get_reg_count);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lf_reg_dump);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_queues_ctx_dump);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_cqe_dump);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_dump);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_cq_dump);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_sq_dump);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_dump);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_dump);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_dump);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_cpt_lfs_dump);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_sq_desc_dump);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_fc_config_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_fc_config_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_fc_mode_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_fc_mode_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_fc_npa_bp_cfg);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_pfc_mode_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_pfc_mode_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_chan_count_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpids_alloc);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_bpids_free);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rx_chan_cfg_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rx_chan_cfg_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_chan_bpid_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_meta_aura_check);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_lf_base_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_inj_lf_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_sa_base_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_sa_base_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_rx_inject_enable);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_spi_range);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_sa_sz);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_sa_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_reassembly_configure);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_is_probed);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_is_multi_channel);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_is_enabled);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_is_enabled);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_rq_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_rq_put);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_rq_ena_dis);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inb_mode_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_soft_exp_poll_switch);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inb_is_with_inl_dev);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_rq);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_outb_sso_pffunc_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_cb_register);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_cb_unregister);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_inb_tag_update);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_sa_sync);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_ctx_write);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_cpt_lf_stats_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_ts_pkind_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_lock);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_unlock);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_meta_pool_cb_register);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_eng_caps_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_custom_meta_pool_cb_register);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_xaq_realloc);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_qptr_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_stats_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_stats_reset);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_cpt_setup);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_inl_dev_cpt_release);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rx_queue_intr_enable);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rx_queue_intr_disable);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_err_intr_ena_dis);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_ras_intr_ena_dis);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_register_queue_irqs);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_unregister_queue_irqs);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_register_cq_irqs);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_unregister_cq_irqs);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_rxtx_start_stop);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_event_start_stop);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_loopback_enable);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_addr_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_max_entries_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_addr_add);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_addr_del);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_promisc_mode_enable);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_info_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_state_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_info_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_mtu_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_max_rx_len_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_stats_reset);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_cb_register);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_cb_unregister);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_info_get_cb_register);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mac_link_info_get_cb_unregister);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mcast_mcam_entry_alloc);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mcast_mcam_entry_free);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mcast_mcam_entry_write);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mcast_mcam_entry_ena_dis);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mcast_list_setup);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_mcast_list_free);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_npc_promisc_ena_dis);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_npc_mac_addr_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_npc_mac_addr_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_npc_rx_ena_dis);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_npc_mcast_config);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lso_custom_fmt_setup);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lso_fmt_setup);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_lso_fmt_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_switch_hdr_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_eeprom_info_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rx_drop_re_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_ptp_rx_ena_dis);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_ptp_tx_ena_dis);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_ptp_clock_read);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_ptp_sync_time_adjust);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_ptp_info_cb_register);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_ptp_info_cb_unregister);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_ptp_is_enable);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_sq_ena_dis);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_ena_dis);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_is_sso_enable);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_modify);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_cman_config);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rq_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_cq_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_cq_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_sq_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_sq_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_cq_head_tail_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_sq_head_tail_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_q_err_cb_register);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_q_err_cb_unregister);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rss_key_default_fill);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rss_key_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rss_key_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rss_reta_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rss_reta_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rss_flowkey_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_rss_default_setup);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_num_xstats_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_stats_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_stats_reset);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_stats_queue_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_stats_queue_reset);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_xstats_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_xstats_names_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_sq_flush_spin);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_prepare_rate_limited_tree);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_pfc_prepare_tree);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_mark_config);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_mark_format_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_sq_aura_fc);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_free_resources);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_shaper_profile_add);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_shaper_profile_update);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_shaper_profile_delete);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_add);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_pkt_mode_update);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_name_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_delete);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_smq_flush);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_hierarchy_disable);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_hierarchy_xmit_enable);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_hierarchy_enable);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_suspend_resume);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_prealloc_res);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_shaper_update);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_parent_update);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_pfc_rlimit_sq);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_rlimit_sq);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_rsrc_count);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_rsrc_max);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_root_has_sp);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_egress_link_cfg_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_leaf_cnt);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_lvl);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_next);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_shaper_profile_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_shaper_profile_next);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_node_stats_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_is_user_hierarchy_enabled);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_tree_type_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_max_prio);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_lvl_is_leaf);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_shaper_default_red_algo);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_lvl_cnt_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_tm_lvl_have_link_access);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_vlan_mcam_entry_read);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_vlan_mcam_entry_write);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_vlan_mcam_entry_alloc_and_write);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_vlan_mcam_entry_free);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_vlan_mcam_entry_ena_dis);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_vlan_strip_vtag_ena_dis);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_vlan_insert_ena_dis);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_nix_vlan_tpid_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_lf_init_cb_register);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_pf_func_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_pool_op_range_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_op_range_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_op_range_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_pool_op_pc_reset);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_drop_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_pool_create);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_create);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_limit_modify);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_pool_destroy);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_destroy);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_pool_range_update_check);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_zero_aura_handle);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_aura_bp_configure);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_dev_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_dev_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_dev_lock);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_dev_unlock);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_ctx_dump);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_dump);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_buf_type_update);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_buf_type_mask);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npa_buf_type_limit_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mark_actions_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mark_actions_sub_return);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_vtag_actions_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_vtag_actions_sub_return);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_free_counter);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_inl_mcam_read_counter);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_inl_mcam_clear_counter);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_alloc_counter);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_get_free_mcam_entry);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_read_counter);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_get_stats);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_clear_counter);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_free_entry);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_free);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_move);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_free_all_resources);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_alloc_entries);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_enable_all_entries);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_alloc_entry);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_ena_dis_entry);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_write_entry);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_get_low_priority_mcam);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_profile_name_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_kex_capa_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_kex_key_type_config_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_validate_portid_action);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_flow_parse);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_sdp_channel_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_flow_create);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_flow_destroy);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_flow_dump);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_mcam_merge_base_steering_rule);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_aged_flow_ctx_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_defrag_mcam_banks);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_get_key_type);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_npc_flow_mcam_dump);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_queues_attach);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_queues_detach);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_msix_offsets_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_config_lf);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_af_reg_read);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_af_reg_write);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_rule_db_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_rule_db_len_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_rule_db_prog);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_qp_get_base);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_err_intr_unregister);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_err_intr_register);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_iq_enable);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_iq_disable);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_dev_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_ree_dev_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_dev_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_dev_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_pf_func_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_msg_id_range_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_msg_id_range_check);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_msg_process);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_irq_register);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_irq_unregister);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_msg_handler_register);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_rvu_lf_msg_handler_unregister);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_se_hmac_opad_ipad_gen);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_se_auth_key_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_se_ciph_key_set);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_se_ctx_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hws_base_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_base_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_pf_func_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_ns_to_gw);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hws_link);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hws_unlink);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hws_stats_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hws_gwc_invalidate);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_agq_alloc);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_agq_free);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_agq_release);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_agq_from_tag);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_stats_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_hws_link_status);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_qos_config);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_init_xaq_aura);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_free_xaq_aura);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_alloc_xaq);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_release_xaq);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_set_priority);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_hwgrp_stash_config);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_rsrc_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_rsrc_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_dev_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_dev_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_sso_dump);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_lf_enable);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_lf_disable);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_lf_base_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_lf_config);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_lf_config_hwwqe);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_lf_interval);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_lf_alloc);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_lf_free);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_init);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_tim_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_error_msg_get);
+RTE_EXPORT_INTERNAL_SYMBOL(roc_clk_freq_get);
diff --git a/drivers/common/cpt/cpt_fpm_tables.c b/drivers/common/cpt/cpt_fpm_tables.c
index 0cb14733d9..9216a5de6c 100644
--- a/drivers/common/cpt/cpt_fpm_tables.c
+++ b/drivers/common/cpt/cpt_fpm_tables.c
@@ -1082,7 +1082,7 @@ static rte_spinlock_t lock = RTE_SPINLOCK_INITIALIZER;
 static uint8_t *fpm_table;
 static int nb_devs;
 
-RTE_EXPORT_INTERNAL_SYMBOL(cpt_fpm_init)
+RTE_EXPORT_INTERNAL_SYMBOL(cpt_fpm_init);
 int cpt_fpm_init(uint64_t *fpm_table_iova)
 {
 	int i, len = 0;
@@ -1127,7 +1127,7 @@ int cpt_fpm_init(uint64_t *fpm_table_iova)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cpt_fpm_clear)
+RTE_EXPORT_INTERNAL_SYMBOL(cpt_fpm_clear);
 void cpt_fpm_clear(void)
 {
 	rte_spinlock_lock(&lock);
diff --git a/drivers/common/cpt/cpt_pmd_ops_helper.c b/drivers/common/cpt/cpt_pmd_ops_helper.c
index c7e6f37026..c5d29205f1 100644
--- a/drivers/common/cpt/cpt_pmd_ops_helper.c
+++ b/drivers/common/cpt/cpt_pmd_ops_helper.c
@@ -15,7 +15,7 @@
 #define CPT_MAX_ASYM_OP_NUM_PARAMS 5
 #define CPT_MAX_ASYM_OP_MOD_LEN 1024
 
-RTE_EXPORT_INTERNAL_SYMBOL(cpt_pmd_ops_helper_get_mlen_direct_mode)
+RTE_EXPORT_INTERNAL_SYMBOL(cpt_pmd_ops_helper_get_mlen_direct_mode);
 int32_t
 cpt_pmd_ops_helper_get_mlen_direct_mode(void)
 {
@@ -30,7 +30,7 @@ cpt_pmd_ops_helper_get_mlen_direct_mode(void)
 	return len;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cpt_pmd_ops_helper_get_mlen_sg_mode)
+RTE_EXPORT_INTERNAL_SYMBOL(cpt_pmd_ops_helper_get_mlen_sg_mode);
 int
 cpt_pmd_ops_helper_get_mlen_sg_mode(void)
 {
@@ -46,7 +46,7 @@ cpt_pmd_ops_helper_get_mlen_sg_mode(void)
 	return len;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cpt_pmd_ops_helper_asym_get_mlen)
+RTE_EXPORT_INTERNAL_SYMBOL(cpt_pmd_ops_helper_asym_get_mlen);
 int
 cpt_pmd_ops_helper_asym_get_mlen(void)
 {
diff --git a/drivers/common/dpaax/caamflib.c b/drivers/common/dpaax/caamflib.c
index 82a7413b5f..b5bf48704c 100644
--- a/drivers/common/dpaax/caamflib.c
+++ b/drivers/common/dpaax/caamflib.c
@@ -15,5 +15,5 @@
  * - SEC HW block revision format is "v"
  * - SEC revision format is "x.y"
  */
-RTE_EXPORT_INTERNAL_SYMBOL(rta_sec_era)
+RTE_EXPORT_INTERNAL_SYMBOL(rta_sec_era);
 enum rta_sec_era rta_sec_era;
diff --git a/drivers/common/dpaax/dpaa_of.c b/drivers/common/dpaax/dpaa_of.c
index 23035f530d..b58370dfca 100644
--- a/drivers/common/dpaax/dpaa_of.c
+++ b/drivers/common/dpaax/dpaa_of.c
@@ -214,7 +214,7 @@ linear_dir(struct dt_dir *d)
 	}
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(of_init_path)
+RTE_EXPORT_INTERNAL_SYMBOL(of_init_path);
 int
 of_init_path(const char *dt_path)
 {
@@ -299,7 +299,7 @@ check_compatible(const struct dt_file *f, const char *compatible)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(of_find_compatible_node)
+RTE_EXPORT_INTERNAL_SYMBOL(of_find_compatible_node);
 const struct device_node *
 of_find_compatible_node(const struct device_node *from,
 			const char *type __rte_unused,
@@ -325,7 +325,7 @@ of_find_compatible_node(const struct device_node *from,
 	return NULL;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(of_get_property)
+RTE_EXPORT_INTERNAL_SYMBOL(of_get_property);
 const void *
 of_get_property(const struct device_node *from, const char *name,
 		size_t *lenp)
@@ -345,7 +345,7 @@ of_get_property(const struct device_node *from, const char *name,
 	return NULL;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(of_device_is_available)
+RTE_EXPORT_INTERNAL_SYMBOL(of_device_is_available);
 bool
 of_device_is_available(const struct device_node *dev_node)
 {
@@ -362,7 +362,7 @@ of_device_is_available(const struct device_node *dev_node)
 	return false;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(of_find_node_by_phandle)
+RTE_EXPORT_INTERNAL_SYMBOL(of_find_node_by_phandle);
 const struct device_node *
 of_find_node_by_phandle(uint64_t ph)
 {
@@ -376,7 +376,7 @@ of_find_node_by_phandle(uint64_t ph)
 	return NULL;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(of_get_parent)
+RTE_EXPORT_INTERNAL_SYMBOL(of_get_parent);
 const struct device_node *
 of_get_parent(const struct device_node *dev_node)
 {
@@ -392,7 +392,7 @@ of_get_parent(const struct device_node *dev_node)
 	return &d->parent->node.node;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(of_get_next_child)
+RTE_EXPORT_INTERNAL_SYMBOL(of_get_next_child);
 const struct device_node *
 of_get_next_child(const struct device_node *dev_node,
 		  const struct device_node *prev)
@@ -422,7 +422,7 @@ of_get_next_child(const struct device_node *dev_node,
 	return &c->node.node;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(of_n_addr_cells)
+RTE_EXPORT_INTERNAL_SYMBOL(of_n_addr_cells);
 uint32_t
 of_n_addr_cells(const struct device_node *dev_node)
 {
@@ -467,7 +467,7 @@ of_n_size_cells(const struct device_node *dev_node)
 	return OF_DEFAULT_NS;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(of_get_address)
+RTE_EXPORT_INTERNAL_SYMBOL(of_get_address);
 const uint32_t *
 of_get_address(const struct device_node *dev_node, size_t idx,
 	       uint64_t *size, uint32_t *flags __rte_unused)
@@ -497,7 +497,7 @@ of_get_address(const struct device_node *dev_node, size_t idx,
 	return (const uint32_t *)buf;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(of_translate_address)
+RTE_EXPORT_INTERNAL_SYMBOL(of_translate_address);
 uint64_t
 of_translate_address(const struct device_node *dev_node,
 		     const uint32_t *addr)
@@ -544,7 +544,7 @@ of_translate_address(const struct device_node *dev_node,
 	return phys_addr;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(of_device_is_compatible)
+RTE_EXPORT_INTERNAL_SYMBOL(of_device_is_compatible);
 bool
 of_device_is_compatible(const struct device_node *dev_node,
 			const char *compatible)
@@ -585,7 +585,7 @@ static const void *of_get_mac_addr(const struct device_node *np,
  * this case, the real MAC is in 'local-mac-address', and 'mac-address' exists
  * but is all zeros.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(of_get_mac_address)
+RTE_EXPORT_INTERNAL_SYMBOL(of_get_mac_address);
 const void *of_get_mac_address(const struct device_node *np)
 {
 	const void *addr;
diff --git a/drivers/common/dpaax/dpaax_iova_table.c b/drivers/common/dpaax/dpaax_iova_table.c
index 1220d9654b..59cc65e9d4 100644
--- a/drivers/common/dpaax/dpaax_iova_table.c
+++ b/drivers/common/dpaax/dpaax_iova_table.c
@@ -9,7 +9,7 @@
 #include "dpaax_logs.h"
 
 /* Global table reference */
-RTE_EXPORT_INTERNAL_SYMBOL(dpaax_iova_table_p)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaax_iova_table_p);
 struct dpaax_iova_table *dpaax_iova_table_p;
 
 static int dpaax_handle_memevents(void);
@@ -155,7 +155,7 @@ read_memory_node(unsigned int *count)
 	return nodes;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaax_iova_table_populate)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaax_iova_table_populate);
 int
 dpaax_iova_table_populate(void)
 {
@@ -257,7 +257,7 @@ dpaax_iova_table_populate(void)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaax_iova_table_depopulate)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaax_iova_table_depopulate);
 void
 dpaax_iova_table_depopulate(void)
 {
@@ -267,7 +267,7 @@ dpaax_iova_table_depopulate(void)
 	DPAAX_DEBUG("IOVA Table cleaned");
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaax_iova_table_update)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaax_iova_table_update);
 int
 dpaax_iova_table_update(phys_addr_t paddr, void *vaddr, size_t length)
 {
@@ -354,7 +354,7 @@ dpaax_iova_table_update(phys_addr_t paddr, void *vaddr, size_t length)
  * Dump the table, with its entries, on screen. Only works in Debug Mode
  * Not for weak hearted - the tables can get quite large
  */
-RTE_EXPORT_INTERNAL_SYMBOL(dpaax_iova_table_dump)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaax_iova_table_dump);
 void
 dpaax_iova_table_dump(void)
 {
@@ -467,5 +467,5 @@ dpaax_handle_memevents(void)
 					       dpaax_memevent_cb, NULL);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaax_logger)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaax_logger);
 RTE_LOG_REGISTER_DEFAULT(dpaax_logger, ERR);
diff --git a/drivers/common/ionic/ionic_common_uio.c b/drivers/common/ionic/ionic_common_uio.c
index aaefab918c..b21e24573e 100644
--- a/drivers/common/ionic/ionic_common_uio.c
+++ b/drivers/common/ionic/ionic_common_uio.c
@@ -104,7 +104,7 @@ uio_get_idx_for_devname(struct uio_name *name_cache, char *devname)
 	return -1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(ionic_uio_scan_mnet_devices)
+RTE_EXPORT_INTERNAL_SYMBOL(ionic_uio_scan_mnet_devices);
 void
 ionic_uio_scan_mnet_devices(void)
 {
@@ -148,7 +148,7 @@ ionic_uio_scan_mnet_devices(void)
 	}
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(ionic_uio_scan_mcrypt_devices)
+RTE_EXPORT_INTERNAL_SYMBOL(ionic_uio_scan_mcrypt_devices);
 void
 ionic_uio_scan_mcrypt_devices(void)
 {
@@ -304,7 +304,7 @@ uio_get_map_res_addr(int uio_idx, int size, int res_idx)
 	return addr;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(ionic_uio_get_rsrc)
+RTE_EXPORT_INTERNAL_SYMBOL(ionic_uio_get_rsrc);
 void
 ionic_uio_get_rsrc(const char *name, int idx, struct ionic_dev_bar *bar)
 {
@@ -323,7 +323,7 @@ ionic_uio_get_rsrc(const char *name, int idx, struct ionic_dev_bar *bar)
 	bar->vaddr = ((char *)bar->vaddr) + offs;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(ionic_uio_rel_rsrc)
+RTE_EXPORT_INTERNAL_SYMBOL(ionic_uio_rel_rsrc);
 void
 ionic_uio_rel_rsrc(const char *name, int idx, struct ionic_dev_bar *bar)
 {
diff --git a/drivers/common/mlx5/linux/mlx5_common_auxiliary.c b/drivers/common/mlx5/linux/mlx5_common_auxiliary.c
index 3ee2f4638a..81ff1ded67 100644
--- a/drivers/common/mlx5/linux/mlx5_common_auxiliary.c
+++ b/drivers/common/mlx5/linux/mlx5_common_auxiliary.c
@@ -19,7 +19,7 @@
 #define AUXILIARY_SYSFS_PATH "/sys/bus/auxiliary/devices"
 #define MLX5_AUXILIARY_PREFIX "mlx5_core.sf."
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_auxiliary_get_child_name)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_auxiliary_get_child_name);
 int
 mlx5_auxiliary_get_child_name(const char *dev, const char *node,
 			      char *child, size_t size)
diff --git a/drivers/common/mlx5/linux/mlx5_common_os.c b/drivers/common/mlx5/linux/mlx5_common_os.c
index 2867e21618..d045f77d33 100644
--- a/drivers/common/mlx5/linux/mlx5_common_os.c
+++ b/drivers/common/mlx5/linux/mlx5_common_os.c
@@ -28,11 +28,11 @@
 #include "mlx5_glue.h"
 
 #ifdef MLX5_GLUE
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_glue)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_glue);
 const struct mlx5_glue *mlx5_glue;
 #endif
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_get_pci_addr)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_get_pci_addr);
 int
 mlx5_get_pci_addr(const char *dev_path, struct rte_pci_addr *pci_addr)
 {
@@ -92,7 +92,7 @@ mlx5_get_pci_addr(const char *dev_path, struct rte_pci_addr *pci_addr)
  * @return
  *   port_name field set according to recognized name format.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_translate_port_name)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_translate_port_name);
 void
 mlx5_translate_port_name(const char *port_name_in,
 			 struct mlx5_switch_info *port_info_out)
@@ -159,7 +159,7 @@ mlx5_translate_port_name(const char *port_name_in,
 	port_info_out->name_type = MLX5_PHYS_PORT_NAME_TYPE_UNKNOWN;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_get_ifname_sysfs)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_get_ifname_sysfs);
 int
 mlx5_get_ifname_sysfs(const char *ibdev_path, char *ifname)
 {
@@ -893,7 +893,7 @@ mlx5_os_open_device(struct mlx5_common_device *cdev, uint32_t classes)
  * @return
  *   Pointer to an `ibv_context` on success, or NULL on failure, with `rte_errno` set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_get_physical_device_ctx)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_get_physical_device_ctx);
 void *
 mlx5_os_get_physical_device_ctx(struct mlx5_common_device *cdev)
 {
@@ -931,7 +931,7 @@ mlx5_os_get_physical_device_ctx(struct mlx5_common_device *cdev)
 	return (void *)ctx;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_get_device_guid)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_get_device_guid);
 int
 mlx5_get_device_guid(const struct rte_pci_addr *dev, uint8_t *guid, size_t len)
 {
@@ -977,7 +977,7 @@ mlx5_get_device_guid(const struct rte_pci_addr *dev, uint8_t *guid, size_t len)
  * indirect mkey created by the DevX API.
  * This mkey should be used for DevX commands requesting mkey as a parameter.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_wrapped_mkey_create)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_wrapped_mkey_create);
 int
 mlx5_os_wrapped_mkey_create(void *ctx, void *pd, uint32_t pdn, void *addr,
 			    size_t length, struct mlx5_pmd_wrapped_mr *pmd_mr)
@@ -1017,7 +1017,7 @@ mlx5_os_wrapped_mkey_create(void *ctx, void *pd, uint32_t pdn, void *addr,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_wrapped_mkey_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_wrapped_mkey_destroy);
 void
 mlx5_os_wrapped_mkey_destroy(struct mlx5_pmd_wrapped_mr *pmd_mr)
 {
@@ -1049,7 +1049,7 @@ mlx5_os_wrapped_mkey_destroy(struct mlx5_pmd_wrapped_mr *pmd_mr)
  *  - Interrupt handle on success.
  *  - NULL on failure, with rte_errno set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_interrupt_handler_create)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_interrupt_handler_create);
 struct rte_intr_handle *
 mlx5_os_interrupt_handler_create(int mode, bool set_fd_nonblock, int fd,
 				 rte_intr_callback_fn cb, void *cb_arg)
@@ -1151,7 +1151,7 @@ mlx5_intr_callback_unregister(const struct rte_intr_handle *handle,
  *   Callback argument for cb.
  *
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_interrupt_handler_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_interrupt_handler_destroy);
 void
 mlx5_os_interrupt_handler_destroy(struct rte_intr_handle *intr_handle,
 				  rte_intr_callback_fn cb, void *cb_arg)
diff --git a/drivers/common/mlx5/linux/mlx5_common_verbs.c b/drivers/common/mlx5/linux/mlx5_common_verbs.c
index 98260df470..aba729a80a 100644
--- a/drivers/common/mlx5/linux/mlx5_common_verbs.c
+++ b/drivers/common/mlx5/linux/mlx5_common_verbs.c
@@ -106,7 +106,7 @@ mlx5_set_context_attr(struct rte_device *dev, struct ibv_context *ctx)
  * @return
  *   0 on successful registration, -1 otherwise
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_common_verbs_reg_mr)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_common_verbs_reg_mr);
 int
 mlx5_common_verbs_reg_mr(void *pd, void *addr, size_t length,
 			 struct mlx5_pmd_mr *pmd_mr)
@@ -136,7 +136,7 @@ mlx5_common_verbs_reg_mr(void *pd, void *addr, size_t length,
  *   pmd_mr struct set with lkey, address, length and pointer to mr object
  *
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_common_verbs_dereg_mr)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_common_verbs_dereg_mr);
 void
 mlx5_common_verbs_dereg_mr(struct mlx5_pmd_mr *pmd_mr)
 {
@@ -154,7 +154,7 @@ mlx5_common_verbs_dereg_mr(struct mlx5_pmd_mr *pmd_mr)
  * @param[out] dereg_mr_cb
  *   Pointer to dereg_mr func
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_set_reg_mr_cb)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_set_reg_mr_cb);
 void
 mlx5_os_set_reg_mr_cb(mlx5_reg_mr_t *reg_mr_cb, mlx5_dereg_mr_t *dereg_mr_cb)
 {
diff --git a/drivers/common/mlx5/linux/mlx5_glue.c b/drivers/common/mlx5/linux/mlx5_glue.c
index a91eaa429d..0e35fd91c7 100644
--- a/drivers/common/mlx5/linux/mlx5_glue.c
+++ b/drivers/common/mlx5/linux/mlx5_glue.c
@@ -1580,7 +1580,7 @@ mlx5_glue_dv_destroy_steering_anchor(struct mlx5dv_steering_anchor *sa)
 #endif
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_glue)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_glue);
 alignas(RTE_CACHE_LINE_SIZE)
 const struct mlx5_glue *mlx5_glue = &(const struct mlx5_glue) {
 	.version = MLX5_GLUE_VERSION,
diff --git a/drivers/common/mlx5/linux/mlx5_nl.c b/drivers/common/mlx5/linux/mlx5_nl.c
index 86166e92d0..5810161631 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.c
+++ b/drivers/common/mlx5/linux/mlx5_nl.c
@@ -196,7 +196,7 @@ RTE_ATOMIC(uint32_t) atomic_sn;
  *   A file descriptor on success, a negative errno value otherwise and
  *   rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_init)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_init);
 int
 mlx5_nl_init(int protocol, int groups)
 {
@@ -643,7 +643,7 @@ mlx5_nl_mac_addr_modify(int nlsk_fd, unsigned int iface_idx,
  * @return
  *    0 on success, a negative errno value otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_vf_mac_addr_modify)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_vf_mac_addr_modify);
 int
 mlx5_nl_vf_mac_addr_modify(int nlsk_fd, unsigned int iface_idx,
 			   struct rte_ether_addr *mac, int vf_index)
@@ -731,7 +731,7 @@ mlx5_nl_vf_mac_addr_modify(int nlsk_fd, unsigned int iface_idx,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_mac_addr_add)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_mac_addr_add);
 int
 mlx5_nl_mac_addr_add(int nlsk_fd, unsigned int iface_idx,
 		     uint64_t *mac_own, struct rte_ether_addr *mac,
@@ -769,7 +769,7 @@ mlx5_nl_mac_addr_add(int nlsk_fd, unsigned int iface_idx,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_mac_addr_remove)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_mac_addr_remove);
 int
 mlx5_nl_mac_addr_remove(int nlsk_fd, unsigned int iface_idx, uint64_t *mac_own,
 			struct rte_ether_addr *mac, uint32_t index)
@@ -794,7 +794,7 @@ mlx5_nl_mac_addr_remove(int nlsk_fd, unsigned int iface_idx, uint64_t *mac_own,
  * @param n
  *   @p mac_addrs array size.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_mac_addr_sync)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_mac_addr_sync);
 void
 mlx5_nl_mac_addr_sync(int nlsk_fd, unsigned int iface_idx,
 		      struct rte_ether_addr *mac_addrs, int n)
@@ -851,7 +851,7 @@ mlx5_nl_mac_addr_sync(int nlsk_fd, unsigned int iface_idx,
  * @param mac_own
  *   BITFIELD_DECLARE array to store the mac.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_mac_addr_flush)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_mac_addr_flush);
 void
 mlx5_nl_mac_addr_flush(int nlsk_fd, unsigned int iface_idx,
 		       struct rte_ether_addr *mac_addrs, int n,
@@ -930,7 +930,7 @@ mlx5_nl_device_flags(int nlsk_fd, unsigned int iface_idx, uint32_t flags,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_promisc)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_promisc);
 int
 mlx5_nl_promisc(int nlsk_fd, unsigned int iface_idx, int enable)
 {
@@ -957,7 +957,7 @@ mlx5_nl_promisc(int nlsk_fd, unsigned int iface_idx, int enable)
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_allmulti)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_allmulti);
 int
 mlx5_nl_allmulti(int nlsk_fd, unsigned int iface_idx, int enable)
 {
@@ -1147,7 +1147,7 @@ mlx5_nl_port_info(int nl, uint32_t pindex, struct mlx5_nl_port_info *data)
  *   A valid (nonzero) interface index on success, 0 otherwise and rte_errno
  *   is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_ifindex)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_ifindex);
 unsigned int
 mlx5_nl_ifindex(int nl, const char *name, uint32_t pindex, struct mlx5_dev_info *dev_info)
 {
@@ -1204,7 +1204,7 @@ mlx5_nl_ifindex(int nl, const char *name, uint32_t pindex, struct mlx5_dev_info
  *   Port state (ibv_port_state) on success, negative on error
  *   and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_port_state)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_port_state);
 int
 mlx5_nl_port_state(int nl, const char *name, uint32_t pindex, struct mlx5_dev_info *dev_info)
 {
@@ -1240,7 +1240,7 @@ mlx5_nl_port_state(int nl, const char *name, uint32_t pindex, struct mlx5_dev_in
  *   A valid (nonzero) number of ports on success, 0 otherwise
  *   and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_portnum)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_portnum);
 unsigned int
 mlx5_nl_portnum(int nl, const char *name, struct mlx5_dev_info *dev_info)
 {
@@ -1447,7 +1447,7 @@ mlx5_nl_switch_info_cb(struct nlmsghdr *nh, void *arg)
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_switch_info)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_switch_info);
 int
 mlx5_nl_switch_info(int nl, unsigned int ifindex,
 		    struct mlx5_switch_info *info)
@@ -1498,7 +1498,7 @@ mlx5_nl_switch_info(int nl, unsigned int ifindex,
  * @param[in] ifindex
  *   Interface index of network device to delete.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_vlan_vmwa_delete)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_vlan_vmwa_delete);
 void
 mlx5_nl_vlan_vmwa_delete(struct mlx5_nl_vlan_vmwa_context *vmwa,
 		      uint32_t ifindex)
@@ -1576,7 +1576,7 @@ nl_attr_nest_end(struct nlmsghdr *nlh, struct nlattr *nest)
  * @param[in] tag
  *   VLAN tag for VLAN network device to create.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_vlan_vmwa_create)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_vlan_vmwa_create);
 uint32_t
 mlx5_nl_vlan_vmwa_create(struct mlx5_nl_vlan_vmwa_context *vmwa,
 			 uint32_t ifindex, uint16_t tag)
@@ -1729,7 +1729,7 @@ mlx5_nl_generic_family_id_get(int nlsk_fd, const char *name)
  *   otherwise and rte_errno is set.
  */
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_devlink_family_id_get)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_devlink_family_id_get);
 int
 mlx5_nl_devlink_family_id_get(int nlsk_fd)
 {
@@ -1956,7 +1956,7 @@ mlx5_nl_enable_roce_set(int nlsk_fd, int family_id, const char *pci_addr,
  * @return
  *  0 on success, negative on failure.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_parse_link_status_update)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_parse_link_status_update);
 int
 mlx5_nl_parse_link_status_update(struct nlmsghdr *hdr, uint32_t *ifindex)
 {
@@ -1988,7 +1988,7 @@ mlx5_nl_parse_link_status_update(struct nlmsghdr *hdr, uint32_t *ifindex)
  *  0 on success, including the case when there are no events.
  *  Negative on failure and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_read_events)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_read_events);
 int
 mlx5_nl_read_events(int nlsk_fd, mlx5_nl_event_cb *cb, void *cb_arg)
 {
@@ -2076,7 +2076,7 @@ mlx5_nl_esw_multiport_cb(struct nlmsghdr *nh, void *arg)
 
 #define NL_ESW_MULTIPORT_PARAM "esw_multiport"
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_devlink_esw_multiport_get)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_devlink_esw_multiport_get);
 int
 mlx5_nl_devlink_esw_multiport_get(int nlsk_fd, int family_id, const char *pci_addr, int *enable)
 {
@@ -2115,14 +2115,14 @@ mlx5_nl_devlink_esw_multiport_get(int nlsk_fd, int family_id, const char *pci_ad
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_rdma_monitor_init)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_rdma_monitor_init);
 int
 mlx5_nl_rdma_monitor_init(void)
 {
 	return mlx5_nl_init(NETLINK_RDMA, RDMA_NL_GROUP_NOTIFICATION);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_rdma_monitor_info_get)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_rdma_monitor_info_get);
 void
 mlx5_nl_rdma_monitor_info_get(struct nlmsghdr *hdr, struct mlx5_nl_port_info *data)
 {
@@ -2217,7 +2217,7 @@ mlx5_nl_rdma_monitor_cap_get_cb(struct nlmsghdr *hdr, void *arg)
  * @return
  *   0 on success, negative on error and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_rdma_monitor_cap_get)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_nl_rdma_monitor_cap_get);
 int
 mlx5_nl_rdma_monitor_cap_get(int nl, uint8_t *cap)
 {
diff --git a/drivers/common/mlx5/mlx5_common.c b/drivers/common/mlx5/mlx5_common.c
index 84a93e7dbd..98249c2c9e 100644
--- a/drivers/common/mlx5/mlx5_common.c
+++ b/drivers/common/mlx5/mlx5_common.c
@@ -21,7 +21,7 @@
 #include "mlx5_common_defs.h"
 #include "mlx5_common_private.h"
 
-RTE_EXPORT_INTERNAL_SYMBOL(haswell_broadwell_cpu)
+RTE_EXPORT_INTERNAL_SYMBOL(haswell_broadwell_cpu);
 uint8_t haswell_broadwell_cpu;
 
 /* Driver type key for new device global syntax. */
@@ -138,7 +138,7 @@ driver_get(uint32_t class)
 	return NULL;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_kvargs_process)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_kvargs_process);
 int
 mlx5_kvargs_process(struct mlx5_kvargs_ctrl *mkvlist, const char *const keys[],
 		    arg_handler_t handler, void *opaque_arg)
@@ -475,7 +475,7 @@ to_mlx5_device(const struct rte_device *rte_dev)
 	return NULL;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_dev_to_pci_str)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_dev_to_pci_str);
 int
 mlx5_dev_to_pci_str(const struct rte_device *dev, char *addr, size_t size)
 {
@@ -525,7 +525,7 @@ mlx5_dev_mempool_register(struct mlx5_common_device *cdev,
  * @param mp
  *   Mempool being unregistered.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_dev_mempool_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_dev_mempool_unregister);
 void
 mlx5_dev_mempool_unregister(struct mlx5_common_device *cdev,
 			    struct rte_mempool *mp)
@@ -605,7 +605,7 @@ mlx5_dev_mempool_event_cb(enum rte_mempool_event event, struct rte_mempool *mp,
  * Callbacks addresses are local in each process.
  * Therefore, each process can register private callbacks.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_dev_mempool_subscribe)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_dev_mempool_subscribe);
 int
 mlx5_dev_mempool_subscribe(struct mlx5_common_device *cdev)
 {
@@ -1235,7 +1235,7 @@ mlx5_common_dev_dma_unmap(struct rte_device *rte_dev, void *addr,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_class_driver_register)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_class_driver_register);
 void
 mlx5_class_driver_register(struct mlx5_class_driver *driver)
 {
@@ -1258,7 +1258,7 @@ static bool mlx5_common_initialized;
  * for multiple PMDs. Each mlx5 PMD that depends on mlx5_common module,
  * must invoke in its constructor.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_common_init)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_common_init);
 void
 mlx5_common_init(void)
 {
@@ -1417,7 +1417,7 @@ mlx5_devx_alloc_uar(struct mlx5_common_device *cdev)
 	return uar;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_uar_release)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_uar_release);
 void
 mlx5_devx_uar_release(struct mlx5_uar *uar)
 {
@@ -1426,7 +1426,7 @@ mlx5_devx_uar_release(struct mlx5_uar *uar)
 	memset(uar, 0, sizeof(*uar));
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_uar_prepare)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_uar_prepare);
 int
 mlx5_devx_uar_prepare(struct mlx5_common_device *cdev, struct mlx5_uar *uar)
 {
diff --git a/drivers/common/mlx5/mlx5_common_devx.c b/drivers/common/mlx5/mlx5_common_devx.c
index 18a53769c9..929b794ba7 100644
--- a/drivers/common/mlx5/mlx5_common_devx.c
+++ b/drivers/common/mlx5/mlx5_common_devx.c
@@ -24,7 +24,7 @@
  * @param[in] cq
  *   DevX CQ to destroy.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cq_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cq_destroy);
 void
 mlx5_devx_cq_destroy(struct mlx5_devx_cq *cq)
 {
@@ -81,7 +81,7 @@ mlx5_cq_init(struct mlx5_devx_cq *cq_obj, uint16_t cq_size)
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cq_create)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cq_create);
 int
 mlx5_devx_cq_create(void *ctx, struct mlx5_devx_cq *cq_obj, uint16_t log_desc_n,
 		    struct mlx5_devx_cq_attr *attr, int socket)
@@ -197,7 +197,7 @@ mlx5_devx_cq_create(void *ctx, struct mlx5_devx_cq *cq_obj, uint16_t log_desc_n,
  * @param[in] sq
  *   DevX SQ to destroy.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_sq_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_sq_destroy);
 void
 mlx5_devx_sq_destroy(struct mlx5_devx_sq *sq)
 {
@@ -242,7 +242,7 @@ mlx5_devx_sq_destroy(struct mlx5_devx_sq *sq)
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_sq_create)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_sq_create);
 int
 mlx5_devx_sq_create(void *ctx, struct mlx5_devx_sq *sq_obj, uint16_t log_wqbb_n,
 		    struct mlx5_devx_create_sq_attr *attr, int socket)
@@ -380,7 +380,7 @@ mlx5_devx_rmp_destroy(struct mlx5_devx_rmp *rmp)
  * @param[in] qp
  *   DevX QP to destroy.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_qp_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_qp_destroy);
 void
 mlx5_devx_qp_destroy(struct mlx5_devx_qp *qp)
 {
@@ -419,7 +419,7 @@ mlx5_devx_qp_destroy(struct mlx5_devx_qp *qp)
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_qp_create)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_qp_create);
 int
 mlx5_devx_qp_create(void *ctx, struct mlx5_devx_qp *qp_obj, uint32_t queue_size,
 		    struct mlx5_devx_qp_attr *attr, int socket)
@@ -490,7 +490,7 @@ mlx5_devx_qp_create(void *ctx, struct mlx5_devx_qp *qp_obj, uint32_t queue_size,
  * @param[in] rq
  *   DevX RQ to destroy.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_rq_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_rq_destroy);
 void
 mlx5_devx_rq_destroy(struct mlx5_devx_rq *rq)
 {
@@ -766,7 +766,7 @@ mlx5_devx_rq_shared_create(void *ctx, struct mlx5_devx_rq *rq_obj,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_rq_create)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_rq_create);
 int
 mlx5_devx_rq_create(void *ctx, struct mlx5_devx_rq *rq_obj,
 		    uint32_t wqe_size, uint16_t log_wqbb_n,
@@ -790,7 +790,7 @@ mlx5_devx_rq_create(void *ctx, struct mlx5_devx_rq *rq_obj,
  * @return
  *	 0 on success, a negative errno value otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_qp2rts)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_qp2rts);
 int
 mlx5_devx_qp2rts(struct mlx5_devx_qp *qp, uint32_t remote_qp_id)
 {
diff --git a/drivers/common/mlx5/mlx5_common_mp.c b/drivers/common/mlx5/mlx5_common_mp.c
index 1ff268f348..44ccee4cfa 100644
--- a/drivers/common/mlx5/mlx5_common_mp.c
+++ b/drivers/common/mlx5/mlx5_common_mp.c
@@ -25,7 +25,7 @@
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mp_req_mr_create)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mp_req_mr_create);
 int
 mlx5_mp_req_mr_create(struct mlx5_common_device *cdev, uintptr_t addr)
 {
@@ -65,7 +65,7 @@ mlx5_mp_req_mr_create(struct mlx5_common_device *cdev, uintptr_t addr)
  * @param reg
  *   True to register the mempool, False to unregister.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mp_req_mempool_reg)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mp_req_mempool_reg);
 int
 mlx5_mp_req_mempool_reg(struct mlx5_common_device *cdev,
 			struct rte_mempool *mempool, bool reg,
@@ -116,7 +116,7 @@ mlx5_mp_req_mempool_reg(struct mlx5_common_device *cdev,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mp_req_queue_state_modify)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mp_req_queue_state_modify);
 int
 mlx5_mp_req_queue_state_modify(struct mlx5_mp_id *mp_id,
 			       struct mlx5_mp_arg_queue_state_modify *sm)
@@ -155,7 +155,7 @@ mlx5_mp_req_queue_state_modify(struct mlx5_mp_id *mp_id,
  * @return
  *   fd on success, a negative errno value otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mp_req_verbs_cmd_fd)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mp_req_verbs_cmd_fd);
 int
 mlx5_mp_req_verbs_cmd_fd(struct mlx5_mp_id *mp_id)
 {
@@ -197,7 +197,7 @@ mlx5_mp_req_verbs_cmd_fd(struct mlx5_mp_id *mp_id)
 /**
  * Initialize by primary process.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mp_init_primary)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mp_init_primary);
 int
 mlx5_mp_init_primary(const char *name, const rte_mp_t primary_action)
 {
@@ -215,7 +215,7 @@ mlx5_mp_init_primary(const char *name, const rte_mp_t primary_action)
 /**
  * Un-initialize by primary process.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mp_uninit_primary)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mp_uninit_primary);
 void
 mlx5_mp_uninit_primary(const char *name)
 {
@@ -226,7 +226,7 @@ mlx5_mp_uninit_primary(const char *name)
 /**
  * Initialize by secondary process.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mp_init_secondary)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mp_init_secondary);
 int
 mlx5_mp_init_secondary(const char *name, const rte_mp_t secondary_action)
 {
@@ -237,7 +237,7 @@ mlx5_mp_init_secondary(const char *name, const rte_mp_t secondary_action)
 /**
  * Un-initialize by secondary process.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mp_uninit_secondary)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mp_uninit_secondary);
 void
 mlx5_mp_uninit_secondary(const char *name)
 {
diff --git a/drivers/common/mlx5/mlx5_common_mr.c b/drivers/common/mlx5/mlx5_common_mr.c
index c41ffff2d5..a928515728 100644
--- a/drivers/common/mlx5/mlx5_common_mr.c
+++ b/drivers/common/mlx5/mlx5_common_mr.c
@@ -52,7 +52,7 @@ struct mlx5_mempool_reg {
 	bool is_extmem;
 };
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mprq_buf_free_cb)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mprq_buf_free_cb);
 void
 mlx5_mprq_buf_free_cb(void *addr __rte_unused, void *opaque)
 {
@@ -251,7 +251,7 @@ mlx5_mr_btree_init(struct mlx5_mr_btree *bt, int n, int socket)
  * @param bt
  *   Pointer to B-tree structure.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_btree_free)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_btree_free);
 void
 mlx5_mr_btree_free(struct mlx5_mr_btree *bt)
 {
@@ -302,7 +302,7 @@ mlx5_mr_btree_dump(struct mlx5_mr_btree *bt __rte_unused)
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_ctrl_init)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_ctrl_init);
 int
 mlx5_mr_ctrl_init(struct mlx5_mr_ctrl *mr_ctrl, uint32_t *dev_gen_ptr,
 		  int socket)
@@ -969,7 +969,7 @@ mlx5_mr_create_primary(void *pd,
  * @return
  *   Searched LKey on success, UINT32_MAX on failure and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_create)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_create);
 uint32_t
 mlx5_mr_create(struct mlx5_common_device *cdev,
 	       struct mlx5_mr_share_cache *share_cache,
@@ -1064,7 +1064,7 @@ mr_lookup_caches(struct mlx5_mr_ctrl *mr_ctrl,
  * @return
  *   Searched LKey on success, UINT32_MAX on no match.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_addr2mr_bh)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_addr2mr_bh);
 uint32_t
 mlx5_mr_addr2mr_bh(struct mlx5_mr_ctrl *mr_ctrl, uintptr_t addr)
 {
@@ -1155,7 +1155,7 @@ mlx5_mr_create_cache(struct mlx5_mr_share_cache *share_cache, int socket)
  * @param mr_ctrl
  *   Pointer to per-queue MR local cache.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_flush_local_cache)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_flush_local_cache);
 void
 mlx5_mr_flush_local_cache(struct mlx5_mr_ctrl *mr_ctrl)
 {
@@ -1810,7 +1810,7 @@ mlx5_mr_mempool_register_secondary(struct mlx5_common_device *cdev,
  * @return
  *   0 on success, (-1) on failure and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_mempool_register)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_mempool_register);
 int
 mlx5_mr_mempool_register(struct mlx5_common_device *cdev,
 			 struct rte_mempool *mp, bool is_extmem)
@@ -1876,7 +1876,7 @@ mlx5_mr_mempool_unregister_secondary(struct mlx5_common_device *cdev,
  * @return
  *   0 on success, (-1) on failure and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_mempool_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_mempool_unregister);
 int
 mlx5_mr_mempool_unregister(struct mlx5_common_device *cdev,
 			   struct rte_mempool *mp)
@@ -1988,7 +1988,7 @@ mlx5_lookup_mempool_regs(struct mlx5_mr_ctrl *mr_ctrl,
  * @return
  *  0 on success, (-1) on failure and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_mempool_populate_cache)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_mempool_populate_cache);
 int
 mlx5_mr_mempool_populate_cache(struct mlx5_mr_ctrl *mr_ctrl,
 			       struct rte_mempool *mp)
@@ -2048,7 +2048,7 @@ mlx5_mr_mempool_populate_cache(struct mlx5_mr_ctrl *mr_ctrl,
  * @return
  *   MR lkey on success, UINT32_MAX on failure.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_mempool2mr_bh)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_mempool2mr_bh);
 uint32_t
 mlx5_mr_mempool2mr_bh(struct mlx5_mr_ctrl *mr_ctrl,
 		      struct rte_mempool *mp, uintptr_t addr)
@@ -2075,7 +2075,7 @@ mlx5_mr_mempool2mr_bh(struct mlx5_mr_ctrl *mr_ctrl,
 	return lkey;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_mb2mr_bh)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_mr_mb2mr_bh);
 uint32_t
 mlx5_mr_mb2mr_bh(struct mlx5_mr_ctrl *mr_ctrl, struct rte_mbuf *mb)
 {
diff --git a/drivers/common/mlx5/mlx5_common_pci.c b/drivers/common/mlx5/mlx5_common_pci.c
index 8bd43bc166..10b1c90fa9 100644
--- a/drivers/common/mlx5/mlx5_common_pci.c
+++ b/drivers/common/mlx5/mlx5_common_pci.c
@@ -103,14 +103,14 @@ pci_ids_table_update(const struct rte_pci_id *driver_id_table)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_dev_is_pci)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_dev_is_pci);
 bool
 mlx5_dev_is_pci(const struct rte_device *dev)
 {
 	return strcmp(dev->bus->name, "pci") == 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_dev_is_vf_pci)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_dev_is_vf_pci);
 bool
 mlx5_dev_is_vf_pci(const struct rte_pci_device *pci_dev)
 {
diff --git a/drivers/common/mlx5/mlx5_common_utils.c b/drivers/common/mlx5/mlx5_common_utils.c
index 14056cebcb..88f2d48c2e 100644
--- a/drivers/common/mlx5/mlx5_common_utils.c
+++ b/drivers/common/mlx5/mlx5_common_utils.c
@@ -27,7 +27,7 @@ mlx5_list_init(struct mlx5_list_inconst *l_inconst,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_list_create)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_list_create);
 struct mlx5_list *
 mlx5_list_create(const char *name, void *ctx, bool lcores_share,
 		 mlx5_list_create_cb cb_create,
@@ -122,7 +122,7 @@ _mlx5_list_lookup(struct mlx5_list_inconst *l_inconst,
 	return entry;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_list_lookup)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_list_lookup);
 struct mlx5_list_entry *
 mlx5_list_lookup(struct mlx5_list *list, void *ctx)
 {
@@ -263,7 +263,7 @@ _mlx5_list_register(struct mlx5_list_inconst *l_inconst,
 	return local_entry;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_list_register)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_list_register);
 struct mlx5_list_entry *
 mlx5_list_register(struct mlx5_list *list, void *ctx)
 {
@@ -323,7 +323,7 @@ _mlx5_list_unregister(struct mlx5_list_inconst *l_inconst,
 	return 1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_list_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_list_unregister);
 int
 mlx5_list_unregister(struct mlx5_list *list,
 		      struct mlx5_list_entry *entry)
@@ -371,7 +371,7 @@ mlx5_list_uninit(struct mlx5_list_inconst *l_inconst,
 	}
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_list_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_list_destroy);
 void
 mlx5_list_destroy(struct mlx5_list *list)
 {
@@ -379,7 +379,7 @@ mlx5_list_destroy(struct mlx5_list *list)
 	mlx5_free(list);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_list_get_entry_num)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_list_get_entry_num);
 uint32_t
 mlx5_list_get_entry_num(struct mlx5_list *list)
 {
@@ -389,7 +389,7 @@ mlx5_list_get_entry_num(struct mlx5_list *list)
 
 /********************* Hash List **********************/
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_hlist_create)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_hlist_create);
 struct mlx5_hlist *
 mlx5_hlist_create(const char *name, uint32_t size, bool direct_key,
 		  bool lcores_share, void *ctx, mlx5_list_create_cb cb_create,
@@ -455,7 +455,7 @@ mlx5_hlist_create(const char *name, uint32_t size, bool direct_key,
 }
 
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_hlist_lookup)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_hlist_lookup);
 struct mlx5_list_entry *
 mlx5_hlist_lookup(struct mlx5_hlist *h, uint64_t key, void *ctx)
 {
@@ -468,7 +468,7 @@ mlx5_hlist_lookup(struct mlx5_hlist *h, uint64_t key, void *ctx)
 	return _mlx5_list_lookup(&h->buckets[idx].l, &h->l_const, ctx);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_hlist_register)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_hlist_register);
 struct mlx5_list_entry*
 mlx5_hlist_register(struct mlx5_hlist *h, uint64_t key, void *ctx)
 {
@@ -497,7 +497,7 @@ mlx5_hlist_register(struct mlx5_hlist *h, uint64_t key, void *ctx)
 	return entry;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_hlist_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_hlist_unregister);
 int
 mlx5_hlist_unregister(struct mlx5_hlist *h, struct mlx5_list_entry *entry)
 {
@@ -516,7 +516,7 @@ mlx5_hlist_unregister(struct mlx5_hlist *h, struct mlx5_list_entry *entry)
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_hlist_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_hlist_destroy);
 void
 mlx5_hlist_destroy(struct mlx5_hlist *h)
 {
diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c b/drivers/common/mlx5/mlx5_devx_cmds.c
index cf601254ab..82ba2106a8 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.c
+++ b/drivers/common/mlx5/mlx5_devx_cmds.c
@@ -87,7 +87,7 @@ mlx5_devx_get_hca_cap(void *ctx, uint32_t *in, uint32_t *out,
  * @return
  *   0 on success, a negative value otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_register_read)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_register_read);
 int
 mlx5_devx_cmd_register_read(void *ctx, uint16_t reg_id, uint32_t arg,
 			    uint32_t *data, uint32_t dw_cnt)
@@ -138,7 +138,7 @@ mlx5_devx_cmd_register_read(void *ctx, uint16_t reg_id, uint32_t arg,
  * @return
  *   0 on success, a negative value otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_register_write)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_register_write);
 int
 mlx5_devx_cmd_register_write(void *ctx, uint16_t reg_id, uint32_t arg,
 			     uint32_t *data, uint32_t dw_cnt)
@@ -179,7 +179,7 @@ mlx5_devx_cmd_register_write(void *ctx, uint16_t reg_id, uint32_t arg,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_flow_counter_alloc_general)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_flow_counter_alloc_general);
 struct mlx5_devx_obj *
 mlx5_devx_cmd_flow_counter_alloc_general(void *ctx,
 		struct mlx5_devx_counter_attr *attr)
@@ -229,7 +229,7 @@ mlx5_devx_cmd_flow_counter_alloc_general(void *ctx,
  *   Pointer to counter object on success, a negative value otherwise and
  *   rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_flow_counter_alloc)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_flow_counter_alloc);
 struct mlx5_devx_obj *
 mlx5_devx_cmd_flow_counter_alloc(void *ctx, uint32_t bulk_n_128)
 {
@@ -281,7 +281,7 @@ mlx5_devx_cmd_flow_counter_alloc(void *ctx, uint32_t bulk_n_128)
  * @return
  *   0 on success, a negative value otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_flow_counter_query)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_flow_counter_query);
 int
 mlx5_devx_cmd_flow_counter_query(struct mlx5_devx_obj *dcs,
 				 int clear, uint32_t n_counters,
@@ -343,7 +343,7 @@ mlx5_devx_cmd_flow_counter_query(struct mlx5_devx_obj *dcs,
  *   Pointer to Devx mkey on success, a negative value otherwise and rte_errno
  *   is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_mkey_create)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_mkey_create);
 struct mlx5_devx_obj *
 mlx5_devx_cmd_mkey_create(void *ctx,
 			  struct mlx5_devx_mkey_attr *attr)
@@ -447,7 +447,7 @@ mlx5_devx_cmd_mkey_create(void *ctx,
  * @return
  *   0 on success, non-zero value otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_get_out_command_status)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_get_out_command_status);
 int
 mlx5_devx_get_out_command_status(void *out)
 {
@@ -474,7 +474,7 @@ mlx5_devx_get_out_command_status(void *out)
  * @return
  *   0 on success, a negative value otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_destroy);
 int
 mlx5_devx_cmd_destroy(struct mlx5_devx_obj *obj)
 {
@@ -634,7 +634,7 @@ mlx5_devx_cmd_query_hca_vdpa_attr(void *ctx,
  * @return
  *   0 on success, a negative errno otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_match_sample_info_query)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_match_sample_info_query);
 int
 mlx5_devx_cmd_match_sample_info_query(void *ctx, uint32_t sample_field_id,
 				      struct mlx5_devx_match_sample_info_query_attr *attr)
@@ -672,7 +672,7 @@ mlx5_devx_cmd_match_sample_info_query(void *ctx, uint32_t sample_field_id,
 #endif
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_query_parse_samples)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_query_parse_samples);
 int
 mlx5_devx_cmd_query_parse_samples(struct mlx5_devx_obj *flex_obj,
 				  uint32_t *ids,
@@ -727,7 +727,7 @@ mlx5_devx_cmd_query_parse_samples(struct mlx5_devx_obj *flex_obj,
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_flex_parser)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_flex_parser);
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_flex_parser(void *ctx,
 				 struct mlx5_devx_graph_node_attr *data)
@@ -928,7 +928,7 @@ mlx5_devx_query_pkt_integrity_match(void *hcattr)
  * @return
  *   0 on success, a negative value otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_query_hca_attr)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_query_hca_attr);
 int
 mlx5_devx_cmd_query_hca_attr(void *ctx,
 			     struct mlx5_hca_attr *attr)
@@ -1438,7 +1438,7 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
  * @return
  *   0 on success, a negative value otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_qp_query_tis_td)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_qp_query_tis_td);
 int
 mlx5_devx_cmd_qp_query_tis_td(void *qp, uint32_t tis_num,
 			      uint32_t *tis_td)
@@ -1525,7 +1525,7 @@ devx_cmd_fill_wq_data(void *wq_ctx, struct mlx5_devx_wq_attr *wq_attr)
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_rq)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_rq);
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_rq(void *ctx,
 			struct mlx5_devx_create_rq_attr *rq_attr,
@@ -1584,7 +1584,7 @@ mlx5_devx_cmd_create_rq(void *ctx,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_modify_rq)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_modify_rq);
 int
 mlx5_devx_cmd_modify_rq(struct mlx5_devx_obj *rq,
 			struct mlx5_devx_modify_rq_attr *rq_attr)
@@ -1638,7 +1638,7 @@ mlx5_devx_cmd_modify_rq(struct mlx5_devx_obj *rq,
  * @return
  *   0 if Query successful, else non-zero return value from devx_obj_query API
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_query_rq)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_query_rq);
 int
 mlx5_devx_cmd_query_rq(struct mlx5_devx_obj *rq_obj, void *out, size_t outlen)
 {
@@ -1668,7 +1668,7 @@ mlx5_devx_cmd_query_rq(struct mlx5_devx_obj *rq_obj, void *out, size_t outlen)
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_rmp)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_rmp);
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_rmp(void *ctx,
 			 struct mlx5_devx_create_rmp_attr *rmp_attr,
@@ -1716,7 +1716,7 @@ mlx5_devx_cmd_create_rmp(void *ctx,
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_tir)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_tir);
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_tir(void *ctx,
 			 struct mlx5_devx_tir_attr *tir_attr)
@@ -1785,7 +1785,7 @@ mlx5_devx_cmd_create_tir(void *ctx,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_modify_tir)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_modify_tir);
 int
 mlx5_devx_cmd_modify_tir(struct mlx5_devx_obj *tir,
 			 struct mlx5_devx_modify_tir_attr *modify_tir_attr)
@@ -1870,7 +1870,7 @@ mlx5_devx_cmd_modify_tir(struct mlx5_devx_obj *tir,
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_rqt)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_rqt);
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_rqt(void *ctx,
 			 struct mlx5_devx_rqt_attr *rqt_attr)
@@ -1925,7 +1925,7 @@ mlx5_devx_cmd_create_rqt(void *ctx,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_modify_rqt)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_modify_rqt);
 int
 mlx5_devx_cmd_modify_rqt(struct mlx5_devx_obj *rqt,
 			 struct mlx5_devx_rqt_attr *rqt_attr)
@@ -1974,7 +1974,7 @@ mlx5_devx_cmd_modify_rqt(struct mlx5_devx_obj *rqt,
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  **/
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_sq)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_sq);
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_sq(void *ctx,
 			struct mlx5_devx_create_sq_attr *sq_attr)
@@ -2041,7 +2041,7 @@ mlx5_devx_cmd_create_sq(void *ctx,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_modify_sq)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_modify_sq);
 int
 mlx5_devx_cmd_modify_sq(struct mlx5_devx_obj *sq,
 			struct mlx5_devx_modify_sq_attr *sq_attr)
@@ -2081,7 +2081,7 @@ mlx5_devx_cmd_modify_sq(struct mlx5_devx_obj *sq,
  * @return
  *   0 if Query successful, else non-zero return value from devx_obj_query API
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_query_sq)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_query_sq);
 int
 mlx5_devx_cmd_query_sq(struct mlx5_devx_obj *sq_obj, void *out, size_t outlen)
 {
@@ -2109,7 +2109,7 @@ mlx5_devx_cmd_query_sq(struct mlx5_devx_obj *sq_obj, void *out, size_t outlen)
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_tis)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_tis);
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_tis(void *ctx,
 			 struct mlx5_devx_tis_attr *tis_attr)
@@ -2153,7 +2153,7 @@ mlx5_devx_cmd_create_tis(void *ctx,
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_td)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_td);
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_td(void *ctx)
 {
@@ -2196,7 +2196,7 @@ mlx5_devx_cmd_create_td(void *ctx)
  * @return
  *   0 on success, a negative value otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_flow_dump)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_flow_dump);
 int
 mlx5_devx_cmd_flow_dump(void *fdb_domain __rte_unused,
 			void *rx_domain __rte_unused,
@@ -2222,7 +2222,7 @@ mlx5_devx_cmd_flow_dump(void *fdb_domain __rte_unused,
 	return -ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_flow_single_dump)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_flow_single_dump);
 int
 mlx5_devx_cmd_flow_single_dump(void *rule_info __rte_unused,
 			FILE *file __rte_unused)
@@ -2248,7 +2248,7 @@ mlx5_devx_cmd_flow_single_dump(void *rule_info __rte_unused,
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_cq)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_cq);
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_cq(void *ctx, struct mlx5_devx_cq_attr *attr)
 {
@@ -2317,7 +2317,7 @@ mlx5_devx_cmd_create_cq(void *ctx, struct mlx5_devx_cq_attr *attr)
  * @return
  *   0 if Query successful, else non-zero return value from devx_obj_query API
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_query_cq)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_query_cq);
 int
 mlx5_devx_cmd_query_cq(struct mlx5_devx_obj *cq_obj, void *out, size_t outlen)
 {
@@ -2345,7 +2345,7 @@ mlx5_devx_cmd_query_cq(struct mlx5_devx_obj *cq_obj, void *out, size_t outlen)
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_virtq)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_virtq);
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_virtq(void *ctx,
 			   struct mlx5_devx_virtq_attr *attr)
@@ -2422,7 +2422,7 @@ mlx5_devx_cmd_create_virtq(void *ctx,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_modify_virtq)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_modify_virtq);
 int
 mlx5_devx_cmd_modify_virtq(struct mlx5_devx_obj *virtq_obj,
 			   struct mlx5_devx_virtq_attr *attr)
@@ -2521,7 +2521,7 @@ mlx5_devx_cmd_modify_virtq(struct mlx5_devx_obj *virtq_obj,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_query_virtq)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_query_virtq);
 int
 mlx5_devx_cmd_query_virtq(struct mlx5_devx_obj *virtq_obj,
 			   struct mlx5_devx_virtq_attr *attr)
@@ -2564,7 +2564,7 @@ mlx5_devx_cmd_query_virtq(struct mlx5_devx_obj *virtq_obj,
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_qp)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_qp);
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_qp(void *ctx,
 			struct mlx5_devx_qp_attr *attr)
@@ -2667,7 +2667,7 @@ mlx5_devx_cmd_create_qp(void *ctx,
  * @return
  *   0 on success, a negative errno value otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_modify_qp_state)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_modify_qp_state);
 int
 mlx5_devx_cmd_modify_qp_state(struct mlx5_devx_obj *qp, uint32_t qp_st_mod_op,
 			      uint32_t remote_qp_id)
@@ -2745,7 +2745,7 @@ mlx5_devx_cmd_modify_qp_state(struct mlx5_devx_obj *qp, uint32_t qp_st_mod_op,
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_virtio_q_counters)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_virtio_q_counters);
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_virtio_q_counters(void *ctx)
 {
@@ -2777,7 +2777,7 @@ mlx5_devx_cmd_create_virtio_q_counters(void *ctx)
 	return couners_obj;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_query_virtio_q_counters)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_query_virtio_q_counters);
 int
 mlx5_devx_cmd_query_virtio_q_counters(struct mlx5_devx_obj *couners_obj,
 				   struct mlx5_devx_virtio_q_couners_attr *attr)
@@ -2827,7 +2827,7 @@ mlx5_devx_cmd_query_virtio_q_counters(struct mlx5_devx_obj *couners_obj,
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_flow_hit_aso_obj)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_flow_hit_aso_obj);
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_flow_hit_aso_obj(void *ctx, uint32_t pd)
 {
@@ -2870,7 +2870,7 @@ mlx5_devx_cmd_create_flow_hit_aso_obj(void *ctx, uint32_t pd)
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_alloc_pd)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_alloc_pd);
 struct mlx5_devx_obj *
 mlx5_devx_cmd_alloc_pd(void *ctx)
 {
@@ -2911,7 +2911,7 @@ mlx5_devx_cmd_alloc_pd(void *ctx)
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_flow_meter_aso_obj)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_flow_meter_aso_obj);
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_flow_meter_aso_obj(void *ctx, uint32_t pd,
 						uint32_t log_obj_size)
@@ -2965,7 +2965,7 @@ mlx5_devx_cmd_create_flow_meter_aso_obj(void *ctx, uint32_t pd,
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_conn_track_offload_obj)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_conn_track_offload_obj);
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_conn_track_offload_obj(void *ctx, uint32_t pd,
 					    uint32_t log_obj_size)
@@ -3012,7 +3012,7 @@ mlx5_devx_cmd_create_conn_track_offload_obj(void *ctx, uint32_t pd,
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_geneve_tlv_option)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_geneve_tlv_option);
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_geneve_tlv_option(void *ctx,
 				  struct mlx5_devx_geneve_tlv_option_attr *attr)
@@ -3075,7 +3075,7 @@ mlx5_devx_cmd_create_geneve_tlv_option(void *ctx,
  * @return
  *   0 on success, a negative errno otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_query_geneve_tlv_option)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_query_geneve_tlv_option);
 int
 mlx5_devx_cmd_query_geneve_tlv_option(void *ctx,
 				      struct mlx5_devx_obj *geneve_tlv_opt_obj,
@@ -3113,7 +3113,7 @@ mlx5_devx_cmd_query_geneve_tlv_option(void *ctx,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_wq_query)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_wq_query);
 int
 mlx5_devx_cmd_wq_query(void *wq, uint32_t *counter_set_id)
 {
@@ -3154,7 +3154,7 @@ mlx5_devx_cmd_wq_query(void *wq, uint32_t *counter_set_id)
  *   Pointer to counter object on success, a NULL value otherwise and
  *   rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_queue_counter_alloc)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_queue_counter_alloc);
 struct mlx5_devx_obj *
 mlx5_devx_cmd_queue_counter_alloc(void *ctx, int *syndrome)
 {
@@ -3196,7 +3196,7 @@ mlx5_devx_cmd_queue_counter_alloc(void *ctx, int *syndrome)
  * @return
  *   0 on success, a negative value otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_queue_counter_query)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_queue_counter_query);
 int
 mlx5_devx_cmd_queue_counter_query(struct mlx5_devx_obj *dcs, int clear,
 				  uint32_t *out_of_buffers)
@@ -3232,7 +3232,7 @@ mlx5_devx_cmd_queue_counter_query(struct mlx5_devx_obj *dcs, int clear,
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_dek_obj)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_dek_obj);
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_dek_obj(void *ctx, struct mlx5_devx_dek_attr *attr)
 {
@@ -3283,7 +3283,7 @@ mlx5_devx_cmd_create_dek_obj(void *ctx, struct mlx5_devx_dek_attr *attr)
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_import_kek_obj)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_import_kek_obj);
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_import_kek_obj(void *ctx,
 				    struct mlx5_devx_import_kek_attr *attr)
@@ -3331,7 +3331,7 @@ mlx5_devx_cmd_create_import_kek_obj(void *ctx,
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_credential_obj)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_credential_obj);
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_credential_obj(void *ctx,
 				    struct mlx5_devx_credential_attr *attr)
@@ -3380,7 +3380,7 @@ mlx5_devx_cmd_create_credential_obj(void *ctx,
  * @return
  *   The DevX object created, NULL otherwise and rte_errno is set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_crypto_login_obj)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_create_crypto_login_obj);
 struct mlx5_devx_obj *
 mlx5_devx_cmd_create_crypto_login_obj(void *ctx,
 				      struct mlx5_devx_crypto_login_attr *attr)
@@ -3432,7 +3432,7 @@ mlx5_devx_cmd_create_crypto_login_obj(void *ctx,
  * @return
  *   0 on success, a negative value otherwise.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_query_lag)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_cmd_query_lag);
 int
 mlx5_devx_cmd_query_lag(void *ctx,
 			struct mlx5_devx_lag_context *lag_ctx)
diff --git a/drivers/common/mlx5/mlx5_malloc.c b/drivers/common/mlx5/mlx5_malloc.c
index 28fb19b285..a1077f59d4 100644
--- a/drivers/common/mlx5/mlx5_malloc.c
+++ b/drivers/common/mlx5/mlx5_malloc.c
@@ -169,7 +169,7 @@ mlx5_malloc_socket_internal(size_t size, unsigned int align, int socket, bool ze
 		      rte_malloc_socket(NULL, size, align, socket);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_malloc)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_malloc);
 void *
 mlx5_malloc(uint32_t flags, size_t size, unsigned int align, int socket)
 {
@@ -220,7 +220,7 @@ mlx5_malloc(uint32_t flags, size_t size, unsigned int align, int socket)
 	return addr;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_realloc)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_realloc);
 void *
 mlx5_realloc(void *addr, uint32_t flags, size_t size, unsigned int align,
 	     int socket)
@@ -268,7 +268,7 @@ mlx5_realloc(void *addr, uint32_t flags, size_t size, unsigned int align,
 	return new_addr;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_free)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_free);
 void
 mlx5_free(void *addr)
 {
@@ -289,7 +289,7 @@ mlx5_free(void *addr)
 	}
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_memory_stat_dump)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_memory_stat_dump);
 void
 mlx5_memory_stat_dump(void)
 {
diff --git a/drivers/common/mlx5/windows/mlx5_common_os.c b/drivers/common/mlx5/windows/mlx5_common_os.c
index 7fac361460..3212f13369 100644
--- a/drivers/common/mlx5/windows/mlx5_common_os.c
+++ b/drivers/common/mlx5/windows/mlx5_common_os.c
@@ -282,7 +282,7 @@ mlx5_os_open_device(struct mlx5_common_device *cdev, uint32_t classes)
  * @return
  *   Pointer to an `ibv_context` on success, or NULL on failure, with `rte_errno` set.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_get_physical_device_ctx)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_get_physical_device_ctx);
 void *
 mlx5_os_get_physical_device_ctx(struct mlx5_common_device *cdev)
 {
@@ -314,7 +314,7 @@ mlx5_os_get_physical_device_ctx(struct mlx5_common_device *cdev)
  * @return
  *   umem on successful registration, NULL and errno otherwise
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_umem_reg)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_umem_reg);
 void *
 mlx5_os_umem_reg(void *ctx, void *addr, size_t size, uint32_t access)
 {
@@ -345,7 +345,7 @@ mlx5_os_umem_reg(void *ctx, void *addr, size_t size, uint32_t access)
  * @return
  *   0 on successful release, negative number otherwise
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_umem_dereg)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_umem_dereg);
 int
 mlx5_os_umem_dereg(void *pumem)
 {
@@ -446,7 +446,7 @@ mlx5_os_dereg_mr(struct mlx5_pmd_mr *pmd_mr)
  *   Pointer to dereg_mr func
  *
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_set_reg_mr_cb)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_set_reg_mr_cb);
 void
 mlx5_os_set_reg_mr_cb(mlx5_reg_mr_t *reg_mr_cb, mlx5_dereg_mr_t *dereg_mr_cb)
 {
@@ -458,7 +458,7 @@ mlx5_os_set_reg_mr_cb(mlx5_reg_mr_t *reg_mr_cb, mlx5_dereg_mr_t *dereg_mr_cb)
  * In Windows, no need to wrap the MR, no known issue for it in kernel.
  * Use the regular function to create direct MR.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_wrapped_mkey_create)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_wrapped_mkey_create);
 int
 mlx5_os_wrapped_mkey_create(void *ctx, void *pd, uint32_t pdn, void *addr,
 			    size_t length, struct mlx5_pmd_wrapped_mr *wpmd_mr)
@@ -478,7 +478,7 @@ mlx5_os_wrapped_mkey_create(void *ctx, void *pd, uint32_t pdn, void *addr,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_wrapped_mkey_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_wrapped_mkey_destroy);
 void
 mlx5_os_wrapped_mkey_destroy(struct mlx5_pmd_wrapped_mr *wpmd_mr)
 {
diff --git a/drivers/common/mlx5/windows/mlx5_glue.c b/drivers/common/mlx5/windows/mlx5_glue.c
index 066e2fdce3..9c24d1c941 100644
--- a/drivers/common/mlx5/windows/mlx5_glue.c
+++ b/drivers/common/mlx5/windows/mlx5_glue.c
@@ -410,7 +410,7 @@ mlx5_glue_devx_set_mtu(void *ctx, uint32_t mtu)
 
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(mlx5_glue)
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_glue);
 alignas(RTE_CACHE_LINE_SIZE)
 const struct mlx5_glue *mlx5_glue = &(const struct mlx5_glue){
 	.version = MLX5_GLUE_VERSION,
diff --git a/drivers/common/mvep/mvep_common.c b/drivers/common/mvep/mvep_common.c
index 2035300cce..cede7b9004 100644
--- a/drivers/common/mvep/mvep_common.c
+++ b/drivers/common/mvep/mvep_common.c
@@ -19,7 +19,7 @@ struct mvep {
 
 static struct mvep mvep;
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_mvep_init)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mvep_init);
 int rte_mvep_init(enum mvep_module_type module __rte_unused,
 		  struct rte_kvargs *kvlist __rte_unused)
 {
@@ -36,7 +36,7 @@ int rte_mvep_init(enum mvep_module_type module __rte_unused,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_mvep_deinit)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_mvep_deinit);
 int rte_mvep_deinit(enum mvep_module_type module __rte_unused)
 {
 	mvep.ref_count--;
diff --git a/drivers/common/nfp/nfp_common.c b/drivers/common/nfp/nfp_common.c
index 475f64daab..46254499b9 100644
--- a/drivers/common/nfp/nfp_common.c
+++ b/drivers/common/nfp/nfp_common.c
@@ -15,7 +15,7 @@
  */
 #define NFP_NET_POLL_TIMEOUT    5000
 
-RTE_EXPORT_INTERNAL_SYMBOL(nfp_reconfig_real)
+RTE_EXPORT_INTERNAL_SYMBOL(nfp_reconfig_real);
 int
 nfp_reconfig_real(struct nfp_hw *hw,
 		uint32_t update)
@@ -80,7 +80,7 @@ nfp_reconfig_real(struct nfp_hw *hw,
  *   - (0) if OK to reconfigure the device.
  *   - (-EIO) if I/O err and fail to reconfigure the device.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(nfp_reconfig)
+RTE_EXPORT_INTERNAL_SYMBOL(nfp_reconfig);
 int
 nfp_reconfig(struct nfp_hw *hw,
 		uint32_t ctrl,
@@ -125,7 +125,7 @@ nfp_reconfig(struct nfp_hw *hw,
  *   - (0) if OK to reconfigure the device.
  *   - (-EIO) if I/O err and fail to reconfigure the device.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(nfp_ext_reconfig)
+RTE_EXPORT_INTERNAL_SYMBOL(nfp_ext_reconfig);
 int
 nfp_ext_reconfig(struct nfp_hw *hw,
 		uint32_t ctrl_ext,
@@ -153,7 +153,7 @@ nfp_ext_reconfig(struct nfp_hw *hw,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(nfp_read_mac)
+RTE_EXPORT_INTERNAL_SYMBOL(nfp_read_mac);
 void
 nfp_read_mac(struct nfp_hw *hw)
 {
@@ -166,7 +166,7 @@ nfp_read_mac(struct nfp_hw *hw)
 	memcpy(&hw->mac_addr.addr_bytes[4], &tmp, 2);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(nfp_write_mac)
+RTE_EXPORT_INTERNAL_SYMBOL(nfp_write_mac);
 void
 nfp_write_mac(struct nfp_hw *hw,
 		uint8_t *mac)
@@ -183,7 +183,7 @@ nfp_write_mac(struct nfp_hw *hw,
 			hw->ctrl_bar + NFP_NET_CFG_MACADDR + 6);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(nfp_enable_queues)
+RTE_EXPORT_INTERNAL_SYMBOL(nfp_enable_queues);
 void
 nfp_enable_queues(struct nfp_hw *hw,
 		uint16_t nb_rx_queues,
@@ -207,7 +207,7 @@ nfp_enable_queues(struct nfp_hw *hw,
 	nn_cfg_writeq(hw, NFP_NET_CFG_RXRS_ENABLE, enabled_queues);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(nfp_disable_queues)
+RTE_EXPORT_INTERNAL_SYMBOL(nfp_disable_queues);
 void
 nfp_disable_queues(struct nfp_hw *hw)
 {
diff --git a/drivers/common/nfp/nfp_common_pci.c b/drivers/common/nfp/nfp_common_pci.c
index 4a2fb5e82d..12c17b09b2 100644
--- a/drivers/common/nfp/nfp_common_pci.c
+++ b/drivers/common/nfp/nfp_common_pci.c
@@ -258,7 +258,7 @@ nfp_common_init(void)
 	nfp_common_initialized = true;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(nfp_class_driver_register)
+RTE_EXPORT_INTERNAL_SYMBOL(nfp_class_driver_register);
 void
 nfp_class_driver_register(struct nfp_class_driver *driver)
 {
diff --git a/drivers/common/nfp/nfp_dev.c b/drivers/common/nfp/nfp_dev.c
index 486ed2cdfe..a8eb213e5a 100644
--- a/drivers/common/nfp/nfp_dev.c
+++ b/drivers/common/nfp/nfp_dev.c
@@ -50,7 +50,7 @@ const struct nfp_dev_info nfp_dev_info[NFP_DEV_CNT] = {
 	},
 };
 
-RTE_EXPORT_INTERNAL_SYMBOL(nfp_dev_info_get)
+RTE_EXPORT_INTERNAL_SYMBOL(nfp_dev_info_get);
 const struct nfp_dev_info *
 nfp_dev_info_get(uint16_t device_id)
 {
diff --git a/drivers/common/nitrox/nitrox_device.c b/drivers/common/nitrox/nitrox_device.c
index 74c7a859a4..f1b39deea7 100644
--- a/drivers/common/nitrox/nitrox_device.c
+++ b/drivers/common/nitrox/nitrox_device.c
@@ -65,7 +65,7 @@ ndev_release(struct nitrox_device *ndev)
 TAILQ_HEAD(ndrv_list, nitrox_driver);
 static struct ndrv_list ndrv_list = TAILQ_HEAD_INITIALIZER(ndrv_list);
 
-RTE_EXPORT_INTERNAL_SYMBOL(nitrox_register_driver)
+RTE_EXPORT_INTERNAL_SYMBOL(nitrox_register_driver);
 void
 nitrox_register_driver(struct nitrox_driver *ndrv)
 {
diff --git a/drivers/common/nitrox/nitrox_logs.c b/drivers/common/nitrox/nitrox_logs.c
index e4ebb39ff1..6187452cda 100644
--- a/drivers/common/nitrox/nitrox_logs.c
+++ b/drivers/common/nitrox/nitrox_logs.c
@@ -5,5 +5,5 @@
 #include <eal_export.h>
 #include <rte_log.h>
 
-RTE_EXPORT_INTERNAL_SYMBOL(nitrox_logtype)
+RTE_EXPORT_INTERNAL_SYMBOL(nitrox_logtype);
 RTE_LOG_REGISTER_DEFAULT(nitrox_logtype, NOTICE);
diff --git a/drivers/common/nitrox/nitrox_qp.c b/drivers/common/nitrox/nitrox_qp.c
index 8f481e6876..8084b1421f 100644
--- a/drivers/common/nitrox/nitrox_qp.c
+++ b/drivers/common/nitrox/nitrox_qp.c
@@ -104,7 +104,7 @@ nitrox_release_cmdq(struct nitrox_qp *qp, uint8_t *bar_addr)
 	return rte_memzone_free(qp->cmdq.mz);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(nitrox_qp_setup)
+RTE_EXPORT_INTERNAL_SYMBOL(nitrox_qp_setup);
 int
 nitrox_qp_setup(struct nitrox_qp *qp, uint8_t *bar_addr, const char *dev_name,
 		uint32_t nb_descriptors, uint8_t instr_size, int socket_id)
@@ -147,7 +147,7 @@ nitrox_release_ridq(struct nitrox_qp *qp)
 	rte_free(qp->ridq);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(nitrox_qp_release)
+RTE_EXPORT_INTERNAL_SYMBOL(nitrox_qp_release);
 int
 nitrox_qp_release(struct nitrox_qp *qp, uint8_t *bar_addr)
 {
diff --git a/drivers/common/octeontx/octeontx_mbox.c b/drivers/common/octeontx/octeontx_mbox.c
index 9e0bbf453f..d0018673f8 100644
--- a/drivers/common/octeontx/octeontx_mbox.c
+++ b/drivers/common/octeontx/octeontx_mbox.c
@@ -70,7 +70,7 @@ struct mbox_intf_ver {
 	uint32_t minor:10;
 };
 
-RTE_EXPORT_INTERNAL_SYMBOL(octeontx_logtype_mbox)
+RTE_EXPORT_INTERNAL_SYMBOL(octeontx_logtype_mbox);
 RTE_LOG_REGISTER(octeontx_logtype_mbox, pmd.octeontx.mbox, NOTICE);
 
 static inline void
@@ -194,7 +194,7 @@ mbox_send(struct mbox *m, struct octeontx_mbox_hdr *hdr, const void *txmsg,
 	return res;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(octeontx_mbox_set_ram_mbox_base)
+RTE_EXPORT_INTERNAL_SYMBOL(octeontx_mbox_set_ram_mbox_base);
 int
 octeontx_mbox_set_ram_mbox_base(uint8_t *ram_mbox_base, uint16_t domain)
 {
@@ -219,7 +219,7 @@ octeontx_mbox_set_ram_mbox_base(uint8_t *ram_mbox_base, uint16_t domain)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(octeontx_mbox_set_reg)
+RTE_EXPORT_INTERNAL_SYMBOL(octeontx_mbox_set_reg);
 int
 octeontx_mbox_set_reg(uint8_t *reg, uint16_t domain)
 {
@@ -244,7 +244,7 @@ octeontx_mbox_set_reg(uint8_t *reg, uint16_t domain)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(octeontx_mbox_send)
+RTE_EXPORT_INTERNAL_SYMBOL(octeontx_mbox_send);
 int
 octeontx_mbox_send(struct octeontx_mbox_hdr *hdr, void *txdata,
 				 uint16_t txlen, void *rxdata, uint16_t rxlen)
@@ -309,7 +309,7 @@ octeontx_check_mbox_version(struct mbox_intf_ver *app_intf_ver,
 	return result;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(octeontx_mbox_init)
+RTE_EXPORT_INTERNAL_SYMBOL(octeontx_mbox_init);
 int
 octeontx_mbox_init(void)
 {
@@ -349,7 +349,7 @@ octeontx_mbox_init(void)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(octeontx_get_global_domain)
+RTE_EXPORT_INTERNAL_SYMBOL(octeontx_get_global_domain);
 uint16_t
 octeontx_get_global_domain(void)
 {
diff --git a/drivers/common/sfc_efx/sfc_base_symbols.c b/drivers/common/sfc_efx/sfc_base_symbols.c
index bbb6f39924..1f62696c3b 100644
--- a/drivers/common/sfc_efx/sfc_base_symbols.c
+++ b/drivers/common/sfc_efx/sfc_base_symbols.c
@@ -5,274 +5,274 @@
 #include <eal_export.h>
 
 /* Symbols from the base driver are exported separately below. */
-RTE_EXPORT_INTERNAL_SYMBOL(efx_crc32_calculate)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_init)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_evq_size)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_evq_nbufs)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_qcreate_irq)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_qcreate)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_qdestroy)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_qprime)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_qpending)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_qcreate_check_init_done)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_qpoll)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_qpost)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_usecs_to_ticks)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_qmoderate)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_evb_init)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_evb_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_evb_vswitch_create)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_evb_vport_mac_set)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_evb_vport_vlan_set)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_evb_vport_reset)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_evb_vswitch_destroy)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_evb_vport_stats)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_insert)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_remove)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_restore)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_init)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_supported_filters)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_init_rx)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_init_tx)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_ipv4_local)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_ipv4_full)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_eth_local)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_ether_type)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_uc_def)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_mc_def)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_encap_type)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_vxlan)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_geneve)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_nvgre)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_rss_context)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_hash_dwords)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_hash_bytes)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_hash_bytes)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_init)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_enable)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_disable)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_disable_unlocked)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_trigger)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_status_line)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_status_message)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_fatal)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_pdu_from_sdu)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_pdu_set)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_pdu_get)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_addr_set)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_filter_set)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_filter_get_all_ucast_mcast)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_drain)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_up)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_fcntl_set)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_fcntl_get)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_multicast_list_set)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_filter_default_rxq_set)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_filter_default_rxq_clear)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_include_fcs_set)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_stat_name)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_stats_get_mask)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_stats_clear)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_stats_upload)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_stats_periodic)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_stats_update)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_init)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_get_limits)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_init)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_mport_invalid)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_mport_by_phy_port)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_mport_by_pcie_function)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_mport_by_pcie_mh_function)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_mport_id_by_selector)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_recirc_id_set)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_ct_mark_set)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_mport_by_id)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_field_set)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_field_get)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_bit_set)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_mport_set)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_clone)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_specs_equal)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_is_valid)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_spec_init)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_spec_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_decap)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_vlan_pop)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_set_dst_mac)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_set_src_mac)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_decr_ip_ttl)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_nat)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_vlan_push)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_encap)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_count)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_flag)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_mark)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_mark_reset)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_deliver)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_drop)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_specs_equal)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_specs_class_cmp)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_outer_rule_recirc_id_set)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_outer_rule_do_ct_set)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_outer_rule_insert)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_outer_rule_remove)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_outer_rule_id_set)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_mac_addr_alloc)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_mac_addr_free)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_fill_in_dst_mac_id)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_fill_in_src_mac_id)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_encap_header_alloc)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_encap_header_update)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_encap_header_free)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_fill_in_eh_id)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_alloc)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_get_nb_count)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_fill_in_counter_id)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_clear_fw_rsrc_ids)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_counters_alloc_type)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_counters_alloc)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_counters_free_type)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_counters_free)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_counters_stream_start)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_counters_stream_stop)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_counters_stream_give_credits)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_free)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_rule_insert)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_rule_remove)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_mport_alloc_alias)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_mport_free)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_read_mport_journal)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_replay)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_list_alloc)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_list_free)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_init)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_new_epoch)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_request_start)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_request_poll)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_request_abort)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_get_client_handle)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_get_own_client_handle)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_client_mac_addr_get)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_client_mac_addr_set)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_get_timeout)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_get_proxy_handle)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_reboot)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mon_name)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mon_init)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_mon_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_family)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_family_probe_bar)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_create)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_probe)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_set_drv_limits)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_set_drv_version)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_get_bar_region)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_get_vi_pool)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_init)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_unprobe)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_destroy)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_reset)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_cfg_get)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_get_fw_version)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_get_board_info)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_hw_unavailable)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_set_hw_unavailable)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_loopback_mask)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_calculate_pcie_link_bandwidth)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_get_fw_subvariant)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_set_fw_subvariant)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_check_pcie_link_speed)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_dma_config_add)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_dma_reconfigure)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_dma_map)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_verify)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_adv_cap_get)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_adv_cap_set)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_lane_count_set)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_lp_cap_get)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_oui_get)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_media_type_get)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_module_get_info)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_fec_type_get)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_link_state_get)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_port_init)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_port_poll)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_port_loopback_set)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_loopback_type_name)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_port_vlan_strip_set)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_port_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_init)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_scale_hash_flags_get)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_hash_default_support_get)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_scale_default_support_get)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_scale_context_alloc)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_scale_context_alloc_v2)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_scale_context_free)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_scale_mode_set)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_scale_key_set)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_scale_tbl_set)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_qpost)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_qpush)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_qflush)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_rxq_size)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_rxq_nbufs)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_qenable)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_qcreate)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_qcreate_es_super_buffer)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_qdestroy)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_pseudo_hdr_pkt_length_get)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_pseudo_hdr_hash_get)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_prefix_get_layout)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_prefix_layout_check)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_sram_buf_tbl_set)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_sram_buf_tbl_clear)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_table_list)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_table_supported_num_get)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_table_is_supported)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_table_describe)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_table_entry_insert)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_table_entry_delete)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_tunnel_init)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_tunnel_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_tunnel_config_udp_add)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_tunnel_config_udp_remove)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_tunnel_config_clear)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_tunnel_reconfigure)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_init)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_txq_size)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_txq_nbufs)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qcreate)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qdestroy)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qpost)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qpush)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qpace)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qflush)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qenable)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qpio_enable)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qpio_disable)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qpio_write)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qpio_post)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qdesc_post)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qdesc_dma_create)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qdesc_tso_create)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qdesc_tso2_create)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qdesc_vlantci_create)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qdesc_checksum_create)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_virtio_init)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_virtio_fini)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_virtio_qcreate)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_virtio_qstart)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_virtio_qstop)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_virtio_qdestroy)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_virtio_get_doorbell_offset)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_virtio_get_features)
-RTE_EXPORT_INTERNAL_SYMBOL(efx_virtio_verify_features)
+RTE_EXPORT_INTERNAL_SYMBOL(efx_crc32_calculate);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_init);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_evq_size);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_evq_nbufs);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_qcreate_irq);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_qcreate);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_qdestroy);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_qprime);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_qpending);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_qcreate_check_init_done);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_qpoll);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_qpost);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_usecs_to_ticks);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_ev_qmoderate);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_evb_init);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_evb_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_evb_vswitch_create);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_evb_vport_mac_set);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_evb_vport_vlan_set);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_evb_vport_reset);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_evb_vswitch_destroy);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_evb_vport_stats);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_insert);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_remove);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_restore);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_init);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_supported_filters);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_init_rx);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_init_tx);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_ipv4_local);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_ipv4_full);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_eth_local);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_ether_type);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_uc_def);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_mc_def);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_encap_type);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_vxlan);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_geneve);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_nvgre);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_filter_spec_set_rss_context);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_hash_dwords);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_hash_bytes);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_hash_bytes);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_init);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_enable);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_disable);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_disable_unlocked);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_trigger);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_status_line);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_status_message);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_intr_fatal);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_pdu_from_sdu);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_pdu_set);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_pdu_get);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_addr_set);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_filter_set);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_filter_get_all_ucast_mcast);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_drain);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_up);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_fcntl_set);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_fcntl_get);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_multicast_list_set);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_filter_default_rxq_set);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_filter_default_rxq_clear);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_include_fcs_set);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_stat_name);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_stats_get_mask);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_stats_clear);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_stats_upload);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_stats_periodic);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mac_stats_update);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_init);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_get_limits);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_init);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_mport_invalid);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_mport_by_phy_port);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_mport_by_pcie_function);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_mport_by_pcie_mh_function);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_mport_id_by_selector);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_recirc_id_set);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_ct_mark_set);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_mport_by_id);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_field_set);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_field_get);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_bit_set);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_mport_set);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_clone);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_specs_equal);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_is_valid);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_spec_init);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_spec_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_decap);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_vlan_pop);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_set_dst_mac);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_set_src_mac);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_decr_ip_ttl);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_nat);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_vlan_push);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_encap);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_count);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_flag);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_mark);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_mark_reset);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_deliver);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_populate_drop);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_specs_equal);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_specs_class_cmp);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_outer_rule_recirc_id_set);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_outer_rule_do_ct_set);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_outer_rule_insert);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_outer_rule_remove);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_match_spec_outer_rule_id_set);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_mac_addr_alloc);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_mac_addr_free);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_fill_in_dst_mac_id);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_fill_in_src_mac_id);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_encap_header_alloc);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_encap_header_update);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_encap_header_free);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_fill_in_eh_id);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_alloc);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_get_nb_count);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_fill_in_counter_id);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_clear_fw_rsrc_ids);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_counters_alloc_type);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_counters_alloc);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_counters_free_type);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_counters_free);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_counters_stream_start);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_counters_stream_stop);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_counters_stream_give_credits);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_free);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_rule_insert);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_rule_remove);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_mport_alloc_alias);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_mport_free);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_read_mport_journal);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_replay);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_list_alloc);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mae_action_set_list_free);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_init);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_new_epoch);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_request_start);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_request_poll);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_request_abort);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_get_client_handle);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_get_own_client_handle);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_client_mac_addr_get);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_client_mac_addr_set);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_get_timeout);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_get_proxy_handle);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mcdi_reboot);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mon_name);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mon_init);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_mon_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_family);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_family_probe_bar);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_create);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_probe);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_set_drv_limits);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_set_drv_version);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_get_bar_region);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_get_vi_pool);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_init);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_unprobe);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_destroy);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_reset);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_cfg_get);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_get_fw_version);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_get_board_info);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_hw_unavailable);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_set_hw_unavailable);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_loopback_mask);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_calculate_pcie_link_bandwidth);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_get_fw_subvariant);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_set_fw_subvariant);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_check_pcie_link_speed);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_dma_config_add);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_dma_reconfigure);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_nic_dma_map);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_verify);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_adv_cap_get);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_adv_cap_set);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_lane_count_set);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_lp_cap_get);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_oui_get);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_media_type_get);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_module_get_info);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_fec_type_get);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_phy_link_state_get);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_port_init);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_port_poll);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_port_loopback_set);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_loopback_type_name);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_port_vlan_strip_set);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_port_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_init);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_scale_hash_flags_get);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_hash_default_support_get);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_scale_default_support_get);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_scale_context_alloc);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_scale_context_alloc_v2);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_scale_context_free);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_scale_mode_set);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_scale_key_set);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_scale_tbl_set);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_qpost);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_qpush);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_qflush);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rxq_size);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rxq_nbufs);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_qenable);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_qcreate);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_qcreate_es_super_buffer);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_qdestroy);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_pseudo_hdr_pkt_length_get);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_pseudo_hdr_hash_get);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_prefix_get_layout);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_rx_prefix_layout_check);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_sram_buf_tbl_set);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_sram_buf_tbl_clear);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_table_list);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_table_supported_num_get);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_table_is_supported);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_table_describe);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_table_entry_insert);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_table_entry_delete);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tunnel_init);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tunnel_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tunnel_config_udp_add);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tunnel_config_udp_remove);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tunnel_config_clear);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tunnel_reconfigure);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_init);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_txq_size);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_txq_nbufs);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qcreate);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qdestroy);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qpost);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qpush);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qpace);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qflush);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qenable);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qpio_enable);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qpio_disable);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qpio_write);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qpio_post);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qdesc_post);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qdesc_dma_create);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qdesc_tso_create);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qdesc_tso2_create);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qdesc_vlantci_create);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_tx_qdesc_checksum_create);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_virtio_init);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_virtio_fini);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_virtio_qcreate);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_virtio_qstart);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_virtio_qstop);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_virtio_qdestroy);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_virtio_get_doorbell_offset);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_virtio_get_features);
+RTE_EXPORT_INTERNAL_SYMBOL(efx_virtio_verify_features);
diff --git a/drivers/common/sfc_efx/sfc_efx.c b/drivers/common/sfc_efx/sfc_efx.c
index 60f20ef262..0cde581485 100644
--- a/drivers/common/sfc_efx/sfc_efx.c
+++ b/drivers/common/sfc_efx/sfc_efx.c
@@ -36,7 +36,7 @@ sfc_efx_kvarg_dev_class_handler(__rte_unused const char *key,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(sfc_efx_dev_class_get)
+RTE_EXPORT_INTERNAL_SYMBOL(sfc_efx_dev_class_get);
 enum sfc_efx_dev_class
 sfc_efx_dev_class_get(struct rte_devargs *devargs)
 {
@@ -95,7 +95,7 @@ sfc_efx_pci_config_readd(efsys_pci_config_t *configp, uint32_t offset,
 	return (rc < 0 || rc != sizeof(*edp)) ? EIO : 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(sfc_efx_family)
+RTE_EXPORT_INTERNAL_SYMBOL(sfc_efx_family);
 int
 sfc_efx_family(struct rte_pci_device *pci_dev,
 	       efx_bar_region_t *mem_ebrp, efx_family_t *family)
diff --git a/drivers/common/sfc_efx/sfc_efx_mcdi.c b/drivers/common/sfc_efx/sfc_efx_mcdi.c
index 1fe3515d2d..647108cb45 100644
--- a/drivers/common/sfc_efx/sfc_efx_mcdi.c
+++ b/drivers/common/sfc_efx/sfc_efx_mcdi.c
@@ -265,7 +265,7 @@ sfc_efx_mcdi_ev_proxy_response(void *arg, uint32_t handle, efx_rc_t result)
 	mcdi->proxy_result = result;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(sfc_efx_mcdi_init)
+RTE_EXPORT_INTERNAL_SYMBOL(sfc_efx_mcdi_init);
 int
 sfc_efx_mcdi_init(struct sfc_efx_mcdi *mcdi,
 		  uint32_t logtype, const char *log_prefix, efx_nic_t *nic,
@@ -322,7 +322,7 @@ sfc_efx_mcdi_init(struct sfc_efx_mcdi *mcdi,
 	return rc;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(sfc_efx_mcdi_fini)
+RTE_EXPORT_INTERNAL_SYMBOL(sfc_efx_mcdi_fini);
 void
 sfc_efx_mcdi_fini(struct sfc_efx_mcdi *mcdi)
 {
diff --git a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
index 31ec88c7d6..c0b312ed75 100644
--- a/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn10k_cryptodev_ops.c
@@ -875,14 +875,14 @@ cn10k_cpt_crypto_adapter_enqueue(void *ws, struct rte_event ev[], uint16_t nb_ev
 	return count;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cn10k_cpt_sg_ver1_crypto_adapter_enqueue)
+RTE_EXPORT_INTERNAL_SYMBOL(cn10k_cpt_sg_ver1_crypto_adapter_enqueue);
 uint16_t __rte_hot
 cn10k_cpt_sg_ver1_crypto_adapter_enqueue(void *ws, struct rte_event ev[], uint16_t nb_events)
 {
 	return cn10k_cpt_crypto_adapter_enqueue(ws, ev, nb_events, false);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cn10k_cpt_sg_ver2_crypto_adapter_enqueue)
+RTE_EXPORT_INTERNAL_SYMBOL(cn10k_cpt_sg_ver2_crypto_adapter_enqueue);
 uint16_t __rte_hot
 cn10k_cpt_sg_ver2_crypto_adapter_enqueue(void *ws, struct rte_event ev[], uint16_t nb_events)
 {
@@ -1216,7 +1216,7 @@ cn10k_cpt_dequeue_post_process(struct cnxk_cpt_qp *qp, struct rte_crypto_op *cop
 	}
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cn10k_cpt_crypto_adapter_dequeue)
+RTE_EXPORT_INTERNAL_SYMBOL(cn10k_cpt_crypto_adapter_dequeue);
 uintptr_t
 cn10k_cpt_crypto_adapter_dequeue(uintptr_t get_work1)
 {
@@ -1241,7 +1241,7 @@ cn10k_cpt_crypto_adapter_dequeue(uintptr_t get_work1)
 	return (uintptr_t)cop;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cn10k_cpt_crypto_adapter_vector_dequeue)
+RTE_EXPORT_INTERNAL_SYMBOL(cn10k_cpt_crypto_adapter_vector_dequeue);
 uintptr_t
 cn10k_cpt_crypto_adapter_vector_dequeue(uintptr_t get_work1)
 {
@@ -1345,7 +1345,7 @@ cn10k_cpt_dequeue_burst(void *qptr, struct rte_crypto_op **ops, uint16_t nb_ops)
 }
 
 #if defined(RTE_ARCH_ARM64)
-RTE_EXPORT_INTERNAL_SYMBOL(cn10k_cryptodev_sec_inb_rx_inject)
+RTE_EXPORT_INTERNAL_SYMBOL(cn10k_cryptodev_sec_inb_rx_inject);
 uint16_t __rte_hot
 cn10k_cryptodev_sec_inb_rx_inject(void *dev, struct rte_mbuf **pkts,
 				  struct rte_security_session **sess, uint16_t nb_pkts)
@@ -1489,7 +1489,7 @@ cn10k_cryptodev_sec_inb_rx_inject(void *dev, struct rte_mbuf **pkts,
 	return count + i;
 }
 #else
-RTE_EXPORT_INTERNAL_SYMBOL(cn10k_cryptodev_sec_inb_rx_inject)
+RTE_EXPORT_INTERNAL_SYMBOL(cn10k_cryptodev_sec_inb_rx_inject);
 uint16_t __rte_hot
 cn10k_cryptodev_sec_inb_rx_inject(void *dev, struct rte_mbuf **pkts,
 				  struct rte_security_session **sess, uint16_t nb_pkts)
@@ -1969,7 +1969,7 @@ cn10k_sym_configure_raw_dp_ctx(struct rte_cryptodev *dev, uint16_t qp_id,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cn10k_cryptodev_sec_rx_inject_configure)
+RTE_EXPORT_INTERNAL_SYMBOL(cn10k_cryptodev_sec_rx_inject_configure);
 int
 cn10k_cryptodev_sec_rx_inject_configure(void *device, uint16_t port_id, bool enable)
 {
diff --git a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
index 6ef7c5bb22..40ff647b29 100644
--- a/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn20k_cryptodev_ops.c
@@ -776,7 +776,7 @@ ca_lmtst_burst_submit(struct ops_burst *burst)
 	return i;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cn20k_cpt_crypto_adapter_enqueue)
+RTE_EXPORT_INTERNAL_SYMBOL(cn20k_cpt_crypto_adapter_enqueue);
 uint16_t __rte_hot
 cn20k_cpt_crypto_adapter_enqueue(void *ws, struct rte_event ev[], uint16_t nb_events)
 {
@@ -1167,7 +1167,7 @@ cn20k_cpt_dequeue_post_process(struct cnxk_cpt_qp *qp, struct rte_crypto_op *cop
 	}
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cn20k_cpt_crypto_adapter_dequeue)
+RTE_EXPORT_INTERNAL_SYMBOL(cn20k_cpt_crypto_adapter_dequeue);
 uintptr_t
 cn20k_cpt_crypto_adapter_dequeue(uintptr_t get_work1)
 {
@@ -1192,7 +1192,7 @@ cn20k_cpt_crypto_adapter_dequeue(uintptr_t get_work1)
 	return (uintptr_t)cop;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cn20k_cpt_crypto_adapter_vector_dequeue)
+RTE_EXPORT_INTERNAL_SYMBOL(cn20k_cpt_crypto_adapter_vector_dequeue);
 uintptr_t
 cn20k_cpt_crypto_adapter_vector_dequeue(uintptr_t get_work1)
 {
@@ -1707,7 +1707,7 @@ cn20k_sym_configure_raw_dp_ctx(struct rte_cryptodev *dev, uint16_t qp_id,
 }
 
 #if defined(RTE_ARCH_ARM64)
-RTE_EXPORT_INTERNAL_SYMBOL(cn20k_cryptodev_sec_inb_rx_inject)
+RTE_EXPORT_INTERNAL_SYMBOL(cn20k_cryptodev_sec_inb_rx_inject);
 uint16_t __rte_hot
 cn20k_cryptodev_sec_inb_rx_inject(void *dev, struct rte_mbuf **pkts,
 				  struct rte_security_session **sess, uint16_t nb_pkts)
@@ -1851,7 +1851,7 @@ cn20k_cryptodev_sec_inb_rx_inject(void *dev, struct rte_mbuf **pkts,
 	return count + i;
 }
 #else
-RTE_EXPORT_INTERNAL_SYMBOL(cn20k_cryptodev_sec_inb_rx_inject)
+RTE_EXPORT_INTERNAL_SYMBOL(cn20k_cryptodev_sec_inb_rx_inject);
 uint16_t __rte_hot
 cn20k_cryptodev_sec_inb_rx_inject(void *dev, struct rte_mbuf **pkts,
 				  struct rte_security_session **sess, uint16_t nb_pkts)
@@ -1864,7 +1864,7 @@ cn20k_cryptodev_sec_inb_rx_inject(void *dev, struct rte_mbuf **pkts,
 }
 #endif
 
-RTE_EXPORT_INTERNAL_SYMBOL(cn20k_cryptodev_sec_rx_inject_configure)
+RTE_EXPORT_INTERNAL_SYMBOL(cn20k_cryptodev_sec_rx_inject_configure);
 int
 cn20k_cryptodev_sec_rx_inject_configure(void *device, uint16_t port_id, bool enable)
 {
diff --git a/drivers/crypto/cnxk/cn9k_cryptodev_ops.c b/drivers/crypto/cnxk/cn9k_cryptodev_ops.c
index c94e9e0f92..82e6121954 100644
--- a/drivers/crypto/cnxk/cn9k_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cn9k_cryptodev_ops.c
@@ -407,7 +407,7 @@ cn9k_ca_meta_info_extract(struct rte_crypto_op *op,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cn9k_cpt_crypto_adapter_enqueue)
+RTE_EXPORT_INTERNAL_SYMBOL(cn9k_cpt_crypto_adapter_enqueue);
 uint16_t
 cn9k_cpt_crypto_adapter_enqueue(uintptr_t base, struct rte_crypto_op *op)
 {
@@ -665,7 +665,7 @@ cn9k_cpt_dequeue_post_process(struct cnxk_cpt_qp *qp, struct rte_crypto_op *cop,
 	}
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cn9k_cpt_crypto_adapter_dequeue)
+RTE_EXPORT_INTERNAL_SYMBOL(cn9k_cpt_crypto_adapter_dequeue);
 uintptr_t
 cn9k_cpt_crypto_adapter_dequeue(uintptr_t get_work1)
 {
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index 261e14b418..9894cb51ce 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -979,7 +979,7 @@ cnxk_cpt_queue_pair_event_error_query(struct rte_cryptodev *dev, uint16_t qp_id)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_crypto_qptr_get, 24.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_crypto_qptr_get, 24.03);
 struct rte_pmd_cnxk_crypto_qptr *
 rte_pmd_cnxk_crypto_qptr_get(uint8_t dev_id, uint16_t qp_id)
 {
@@ -1042,7 +1042,7 @@ cnxk_crypto_cn9k_submit(struct rte_pmd_cnxk_crypto_qptr *qptr, void *inst, uint1
 	}
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_crypto_submit, 24.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_crypto_submit, 24.03);
 void
 rte_pmd_cnxk_crypto_submit(struct rte_pmd_cnxk_crypto_qptr *qptr, void *inst, uint16_t nb_inst)
 {
@@ -1054,7 +1054,7 @@ rte_pmd_cnxk_crypto_submit(struct rte_pmd_cnxk_crypto_qptr *qptr, void *inst, ui
 	plt_err("Invalid cnxk model");
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_crypto_cptr_flush, 24.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_crypto_cptr_flush, 24.07);
 int
 rte_pmd_cnxk_crypto_cptr_flush(struct rte_pmd_cnxk_crypto_qptr *qptr,
 			       struct rte_pmd_cnxk_crypto_cptr *cptr, bool invalidate)
@@ -1079,7 +1079,7 @@ rte_pmd_cnxk_crypto_cptr_flush(struct rte_pmd_cnxk_crypto_qptr *qptr,
 	return roc_cpt_lf_ctx_flush(&qp->lf, cptr, invalidate);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_crypto_cptr_get, 24.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_crypto_cptr_get, 24.07);
 struct rte_pmd_cnxk_crypto_cptr *
 rte_pmd_cnxk_crypto_cptr_get(struct rte_pmd_cnxk_crypto_sess *rte_sess)
 {
@@ -1133,7 +1133,7 @@ rte_pmd_cnxk_crypto_cptr_get(struct rte_pmd_cnxk_crypto_sess *rte_sess)
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_crypto_cptr_read, 24.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_crypto_cptr_read, 24.07);
 int
 rte_pmd_cnxk_crypto_cptr_read(struct rte_pmd_cnxk_crypto_qptr *qptr,
 			      struct rte_pmd_cnxk_crypto_cptr *cptr, void *data, uint32_t len)
@@ -1167,7 +1167,7 @@ rte_pmd_cnxk_crypto_cptr_read(struct rte_pmd_cnxk_crypto_qptr *qptr,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_crypto_cptr_write, 24.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_crypto_cptr_write, 24.07);
 int
 rte_pmd_cnxk_crypto_cptr_write(struct rte_pmd_cnxk_crypto_qptr *qptr,
 			       struct rte_pmd_cnxk_crypto_cptr *cptr, void *data, uint32_t len)
@@ -1205,7 +1205,7 @@ rte_pmd_cnxk_crypto_cptr_write(struct rte_pmd_cnxk_crypto_qptr *qptr,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_crypto_qp_stats_get, 24.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_crypto_qp_stats_get, 24.07);
 int
 rte_pmd_cnxk_crypto_qp_stats_get(struct rte_pmd_cnxk_crypto_qptr *qptr,
 				 struct rte_pmd_cnxk_crypto_qp_stats *stats)
diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index ca10d88da7..12ff985e09 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -4161,7 +4161,7 @@ dpaa2_sec_process_ordered_event(struct qbman_swp *swp,
 	ev->event_ptr = crypto_op;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_sec_eventq_attach)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_sec_eventq_attach);
 int
 dpaa2_sec_eventq_attach(const struct rte_cryptodev *dev,
 		int qp_id,
@@ -4242,7 +4242,7 @@ dpaa2_sec_eventq_attach(const struct rte_cryptodev *dev,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_sec_eventq_detach)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_sec_eventq_detach);
 int
 dpaa2_sec_eventq_detach(const struct rte_cryptodev *dev,
 			int qp_id)
diff --git a/drivers/crypto/dpaa_sec/dpaa_sec.c b/drivers/crypto/dpaa_sec/dpaa_sec.c
index 65bbd38b17..921652900a 100644
--- a/drivers/crypto/dpaa_sec/dpaa_sec.c
+++ b/drivers/crypto/dpaa_sec/dpaa_sec.c
@@ -3511,7 +3511,7 @@ dpaa_sec_process_atomic_event(void *event,
 	return qman_cb_dqrr_defer;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa_sec_eventq_attach)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_sec_eventq_attach);
 int
 dpaa_sec_eventq_attach(const struct rte_cryptodev *dev,
 		int qp_id,
@@ -3556,7 +3556,7 @@ dpaa_sec_eventq_attach(const struct rte_cryptodev *dev,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa_sec_eventq_detach)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_sec_eventq_detach);
 int
 dpaa_sec_eventq_detach(const struct rte_cryptodev *dev,
 			int qp_id)
diff --git a/drivers/crypto/octeontx/otx_cryptodev_ops.c b/drivers/crypto/octeontx/otx_cryptodev_ops.c
index 88657f49cc..9a11f5e985 100644
--- a/drivers/crypto/octeontx/otx_cryptodev_ops.c
+++ b/drivers/crypto/octeontx/otx_cryptodev_ops.c
@@ -657,7 +657,7 @@ submit_request_to_sso(struct ssows *ws, uintptr_t req,
 	ssovf_store_pair(add_work, req, ws->grps[rsp_info->queue_id]);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(otx_crypto_adapter_enqueue)
+RTE_EXPORT_INTERNAL_SYMBOL(otx_crypto_adapter_enqueue);
 uint16_t __rte_hot
 otx_crypto_adapter_enqueue(void *port, struct rte_crypto_op *op)
 {
@@ -948,7 +948,7 @@ otx_cpt_dequeue_sym(void *qptr, struct rte_crypto_op **ops, uint16_t nb_ops)
 	return otx_cpt_pkt_dequeue(qptr, ops, nb_ops, OP_TYPE_SYM);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(otx_crypto_adapter_dequeue)
+RTE_EXPORT_INTERNAL_SYMBOL(otx_crypto_adapter_dequeue);
 uintptr_t __rte_hot
 otx_crypto_adapter_dequeue(uintptr_t get_work1)
 {
diff --git a/drivers/crypto/scheduler/rte_cryptodev_scheduler.c b/drivers/crypto/scheduler/rte_cryptodev_scheduler.c
index 1ca8443431..770ef03650 100644
--- a/drivers/crypto/scheduler/rte_cryptodev_scheduler.c
+++ b/drivers/crypto/scheduler/rte_cryptodev_scheduler.c
@@ -358,7 +358,7 @@ update_max_nb_qp(struct scheduler_ctx *sched_ctx)
 }
 
 /** Attach a device to the scheduler. */
-RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_worker_attach)
+RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_worker_attach);
 int
 rte_cryptodev_scheduler_worker_attach(uint8_t scheduler_id, uint8_t worker_id)
 {
@@ -421,7 +421,7 @@ rte_cryptodev_scheduler_worker_attach(uint8_t scheduler_id, uint8_t worker_id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_worker_detach)
+RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_worker_detach);
 int
 rte_cryptodev_scheduler_worker_detach(uint8_t scheduler_id, uint8_t worker_id)
 {
@@ -480,7 +480,7 @@ rte_cryptodev_scheduler_worker_detach(uint8_t scheduler_id, uint8_t worker_id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_mode_set)
+RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_mode_set);
 int
 rte_cryptodev_scheduler_mode_set(uint8_t scheduler_id,
 		enum rte_cryptodev_scheduler_mode mode)
@@ -545,7 +545,7 @@ rte_cryptodev_scheduler_mode_set(uint8_t scheduler_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_mode_get)
+RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_mode_get);
 enum rte_cryptodev_scheduler_mode
 rte_cryptodev_scheduler_mode_get(uint8_t scheduler_id)
 {
@@ -567,7 +567,7 @@ rte_cryptodev_scheduler_mode_get(uint8_t scheduler_id)
 	return sched_ctx->mode;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_ordering_set)
+RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_ordering_set);
 int
 rte_cryptodev_scheduler_ordering_set(uint8_t scheduler_id,
 		uint32_t enable_reorder)
@@ -597,7 +597,7 @@ rte_cryptodev_scheduler_ordering_set(uint8_t scheduler_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_ordering_get)
+RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_ordering_get);
 int
 rte_cryptodev_scheduler_ordering_get(uint8_t scheduler_id)
 {
@@ -619,7 +619,7 @@ rte_cryptodev_scheduler_ordering_get(uint8_t scheduler_id)
 	return (int)sched_ctx->reordering_enabled;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_load_user_scheduler)
+RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_load_user_scheduler);
 int
 rte_cryptodev_scheduler_load_user_scheduler(uint8_t scheduler_id,
 		struct rte_cryptodev_scheduler *scheduler) {
@@ -692,7 +692,7 @@ rte_cryptodev_scheduler_load_user_scheduler(uint8_t scheduler_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_workers_get)
+RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_workers_get);
 int
 rte_cryptodev_scheduler_workers_get(uint8_t scheduler_id, uint8_t *workers)
 {
@@ -724,7 +724,7 @@ rte_cryptodev_scheduler_workers_get(uint8_t scheduler_id, uint8_t *workers)
 	return (int)nb_workers;
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_option_set)
+RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_option_set);
 int
 rte_cryptodev_scheduler_option_set(uint8_t scheduler_id,
 		enum rte_cryptodev_schedule_option_type option_type,
@@ -757,7 +757,7 @@ rte_cryptodev_scheduler_option_set(uint8_t scheduler_id,
 	return sched_ctx->ops.option_set(dev, option_type, option);
 }
 
-RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_option_get)
+RTE_EXPORT_SYMBOL(rte_cryptodev_scheduler_option_get);
 int
 rte_cryptodev_scheduler_option_get(uint8_t scheduler_id,
 		enum rte_cryptodev_schedule_option_type option_type,
diff --git a/drivers/dma/cnxk/cnxk_dmadev_fp.c b/drivers/dma/cnxk/cnxk_dmadev_fp.c
index dea73c5b41..887fc70628 100644
--- a/drivers/dma/cnxk/cnxk_dmadev_fp.c
+++ b/drivers/dma/cnxk/cnxk_dmadev_fp.c
@@ -446,7 +446,7 @@ cnxk_dma_adapter_format_event(uint64_t event)
 	return w0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cn10k_dma_adapter_enqueue)
+RTE_EXPORT_INTERNAL_SYMBOL(cn10k_dma_adapter_enqueue);
 uint16_t
 cn10k_dma_adapter_enqueue(void *ws, struct rte_event ev[], uint16_t nb_events)
 {
@@ -506,7 +506,7 @@ cn10k_dma_adapter_enqueue(void *ws, struct rte_event ev[], uint16_t nb_events)
 	return count;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cn9k_dma_adapter_dual_enqueue)
+RTE_EXPORT_INTERNAL_SYMBOL(cn9k_dma_adapter_dual_enqueue);
 uint16_t
 cn9k_dma_adapter_dual_enqueue(void *ws, struct rte_event ev[], uint16_t nb_events)
 {
@@ -577,7 +577,7 @@ cn9k_dma_adapter_dual_enqueue(void *ws, struct rte_event ev[], uint16_t nb_event
 	return count;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cn9k_dma_adapter_enqueue)
+RTE_EXPORT_INTERNAL_SYMBOL(cn9k_dma_adapter_enqueue);
 uint16_t
 cn9k_dma_adapter_enqueue(void *ws, struct rte_event ev[], uint16_t nb_events)
 {
@@ -645,7 +645,7 @@ cn9k_dma_adapter_enqueue(void *ws, struct rte_event ev[], uint16_t nb_events)
 	return count;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_dma_adapter_dequeue)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_dma_adapter_dequeue);
 uintptr_t
 cnxk_dma_adapter_dequeue(uintptr_t get_work1)
 {
diff --git a/drivers/event/cnxk/cnxk_worker.c b/drivers/event/cnxk/cnxk_worker.c
index 5e5beb6aac..008f4277c1 100644
--- a/drivers/event/cnxk/cnxk_worker.c
+++ b/drivers/event/cnxk/cnxk_worker.c
@@ -13,7 +13,7 @@ struct pwords {
 	uint64_t u[5];
 };
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_eventdev_wait_head, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_eventdev_wait_head, 23.11);
 void
 rte_pmd_cnxk_eventdev_wait_head(uint8_t dev, uint8_t port)
 {
@@ -30,7 +30,7 @@ rte_pmd_cnxk_eventdev_wait_head(uint8_t dev, uint8_t port)
 }
 
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_eventdev_is_head, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_eventdev_is_head, 23.11);
 uint8_t
 rte_pmd_cnxk_eventdev_is_head(uint8_t dev, uint8_t port)
 {
diff --git a/drivers/event/dlb2/rte_pmd_dlb2.c b/drivers/event/dlb2/rte_pmd_dlb2.c
index 80186dd07d..e77a30ff7d 100644
--- a/drivers/event/dlb2/rte_pmd_dlb2.c
+++ b/drivers/event/dlb2/rte_pmd_dlb2.c
@@ -10,7 +10,7 @@
 #include "dlb2_priv.h"
 #include "dlb2_inline_fns.h"
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dlb2_set_token_pop_mode, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dlb2_set_token_pop_mode, 20.11);
 int
 rte_pmd_dlb2_set_token_pop_mode(uint8_t dev_id,
 				uint8_t port_id,
@@ -40,7 +40,7 @@ rte_pmd_dlb2_set_token_pop_mode(uint8_t dev_id,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dlb2_set_port_param, 25.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dlb2_set_port_param, 25.07);
 int
 rte_pmd_dlb2_set_port_param(uint8_t dev_id,
 			    uint8_t port_id,
diff --git a/drivers/mempool/cnxk/cn10k_hwpool_ops.c b/drivers/mempool/cnxk/cn10k_hwpool_ops.c
index e83e872f40..855c60944e 100644
--- a/drivers/mempool/cnxk/cn10k_hwpool_ops.c
+++ b/drivers/mempool/cnxk/cn10k_hwpool_ops.c
@@ -201,7 +201,7 @@ cn10k_hwpool_populate(struct rte_mempool *hp, unsigned int max_objs,
 	return hp->size;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_mempool_mbuf_exchange, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_mempool_mbuf_exchange, 23.07);
 int
 rte_pmd_cnxk_mempool_mbuf_exchange(struct rte_mbuf *m1, struct rte_mbuf *m2)
 {
@@ -229,14 +229,14 @@ rte_pmd_cnxk_mempool_mbuf_exchange(struct rte_mbuf *m1, struct rte_mbuf *m2)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_mempool_is_hwpool, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_mempool_is_hwpool, 23.07);
 int
 rte_pmd_cnxk_mempool_is_hwpool(struct rte_mempool *mp)
 {
 	return !!(CNXK_MEMPOOL_FLAGS(mp) & CNXK_MEMPOOL_F_IS_HWPOOL);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_mempool_range_check_disable, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_mempool_range_check_disable, 23.07);
 int
 rte_pmd_cnxk_mempool_range_check_disable(struct rte_mempool *mp)
 {
diff --git a/drivers/mempool/dpaa/dpaa_mempool.c b/drivers/mempool/dpaa/dpaa_mempool.c
index 7dacaa9513..3b80d2b2a7 100644
--- a/drivers/mempool/dpaa/dpaa_mempool.c
+++ b/drivers/mempool/dpaa/dpaa_mempool.c
@@ -33,11 +33,11 @@
  * is to optimize the PA_to_VA searches until a better mechanism (algo) is
  * available.
  */
-RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa_memsegs)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa_memsegs);
 struct dpaa_memseg_list rte_dpaa_memsegs
 	= TAILQ_HEAD_INITIALIZER(rte_dpaa_memsegs);
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa_bpid_info)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa_bpid_info);
 struct dpaa_bp_info *rte_dpaa_bpid_info;
 
 RTE_LOG_REGISTER_DEFAULT(dpaa_logtype_mempool, NOTICE);
diff --git a/drivers/mempool/dpaa2/dpaa2_hw_mempool.c b/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
index 118eb76db7..4fea1bfd37 100644
--- a/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
+++ b/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
@@ -34,13 +34,13 @@
 
 #include <dpaax_iova_table.h>
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_bpid_info)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_bpid_info);
 struct dpaa2_bp_info *rte_dpaa2_bpid_info;
 static struct dpaa2_bp_list *h_bp_list;
 
 static int16_t s_dpaa2_pool_ops_idx = RTE_MEMPOOL_MAX_OPS_IDX;
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_mpool_get_ops_idx)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_mpool_get_ops_idx);
 int rte_dpaa2_mpool_get_ops_idx(void)
 {
 	return s_dpaa2_pool_ops_idx;
@@ -298,7 +298,7 @@ rte_dpaa2_mbuf_release(struct rte_mempool *pool __rte_unused,
 	}
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_bpid_info_init)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_bpid_info_init);
 int rte_dpaa2_bpid_info_init(struct rte_mempool *mp)
 {
 	struct dpaa2_bp_info *bp_info = mempool_to_bpinfo(mp);
@@ -322,7 +322,7 @@ int rte_dpaa2_bpid_info_init(struct rte_mempool *mp)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_dpaa2_mbuf_pool_bpid)
+RTE_EXPORT_SYMBOL(rte_dpaa2_mbuf_pool_bpid);
 uint16_t
 rte_dpaa2_mbuf_pool_bpid(struct rte_mempool *mp)
 {
@@ -337,7 +337,7 @@ rte_dpaa2_mbuf_pool_bpid(struct rte_mempool *mp)
 	return bp_info->bpid;
 }
 
-RTE_EXPORT_SYMBOL(rte_dpaa2_mbuf_from_buf_addr)
+RTE_EXPORT_SYMBOL(rte_dpaa2_mbuf_from_buf_addr);
 struct rte_mbuf *
 rte_dpaa2_mbuf_from_buf_addr(struct rte_mempool *mp, void *buf_addr)
 {
@@ -353,7 +353,7 @@ rte_dpaa2_mbuf_from_buf_addr(struct rte_mempool *mp, void *buf_addr)
 			bp_info->meta_data_size);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_mbuf_alloc_bulk)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_mbuf_alloc_bulk);
 int
 rte_dpaa2_mbuf_alloc_bulk(struct rte_mempool *pool,
 			  void **obj_table, unsigned int count)
diff --git a/drivers/net/atlantic/rte_pmd_atlantic.c b/drivers/net/atlantic/rte_pmd_atlantic.c
index b5b6ab7d4b..c306bf02d2 100644
--- a/drivers/net/atlantic/rte_pmd_atlantic.c
+++ b/drivers/net/atlantic/rte_pmd_atlantic.c
@@ -9,7 +9,7 @@
 #include "atl_ethdev.h"
 
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_atl_macsec_enable, 19.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_atl_macsec_enable, 19.05);
 int
 rte_pmd_atl_macsec_enable(uint16_t port,
 			  uint8_t encr, uint8_t repl_prot)
@@ -26,7 +26,7 @@ rte_pmd_atl_macsec_enable(uint16_t port,
 	return atl_macsec_enable(dev, encr, repl_prot);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_atl_macsec_disable, 19.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_atl_macsec_disable, 19.05);
 int
 rte_pmd_atl_macsec_disable(uint16_t port)
 {
@@ -42,7 +42,7 @@ rte_pmd_atl_macsec_disable(uint16_t port)
 	return atl_macsec_disable(dev);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_atl_macsec_config_txsc, 19.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_atl_macsec_config_txsc, 19.05);
 int
 rte_pmd_atl_macsec_config_txsc(uint16_t port, uint8_t *mac)
 {
@@ -58,7 +58,7 @@ rte_pmd_atl_macsec_config_txsc(uint16_t port, uint8_t *mac)
 	return atl_macsec_config_txsc(dev, mac);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_atl_macsec_config_rxsc, 19.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_atl_macsec_config_rxsc, 19.05);
 int
 rte_pmd_atl_macsec_config_rxsc(uint16_t port, uint8_t *mac, uint16_t pi)
 {
@@ -74,7 +74,7 @@ rte_pmd_atl_macsec_config_rxsc(uint16_t port, uint8_t *mac, uint16_t pi)
 	return atl_macsec_config_rxsc(dev, mac, pi);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_atl_macsec_select_txsa, 19.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_atl_macsec_select_txsa, 19.05);
 int
 rte_pmd_atl_macsec_select_txsa(uint16_t port, uint8_t idx, uint8_t an,
 				 uint32_t pn, uint8_t *key)
@@ -91,7 +91,7 @@ rte_pmd_atl_macsec_select_txsa(uint16_t port, uint8_t idx, uint8_t an,
 	return atl_macsec_select_txsa(dev, idx, an, pn, key);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_atl_macsec_select_rxsa, 19.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_atl_macsec_select_rxsa, 19.05);
 int
 rte_pmd_atl_macsec_select_rxsa(uint16_t port, uint8_t idx, uint8_t an,
 				 uint32_t pn, uint8_t *key)
diff --git a/drivers/net/bnxt/rte_pmd_bnxt.c b/drivers/net/bnxt/rte_pmd_bnxt.c
index 4974e390e7..8691c8769d 100644
--- a/drivers/net/bnxt/rte_pmd_bnxt.c
+++ b/drivers/net/bnxt/rte_pmd_bnxt.c
@@ -40,7 +40,7 @@ int bnxt_rcv_msg_from_vf(struct bnxt *bp, uint16_t vf_id, void *msg)
 		true : false;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_tx_loopback)
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_tx_loopback);
 int rte_pmd_bnxt_set_tx_loopback(uint16_t port, uint8_t on)
 {
 	struct rte_eth_dev *eth_dev;
@@ -82,7 +82,7 @@ rte_pmd_bnxt_set_all_queues_drop_en_cb(struct bnxt_vnic_info *vnic, void *onptr)
 	vnic->bd_stall = !(*on);
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_all_queues_drop_en)
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_all_queues_drop_en);
 int rte_pmd_bnxt_set_all_queues_drop_en(uint16_t port, uint8_t on)
 {
 	struct rte_eth_dev *eth_dev;
@@ -134,7 +134,7 @@ int rte_pmd_bnxt_set_all_queues_drop_en(uint16_t port, uint8_t on)
 	return rc;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_vf_mac_addr)
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_vf_mac_addr);
 int rte_pmd_bnxt_set_vf_mac_addr(uint16_t port, uint16_t vf,
 				struct rte_ether_addr *mac_addr)
 {
@@ -175,7 +175,7 @@ int rte_pmd_bnxt_set_vf_mac_addr(uint16_t port, uint16_t vf,
 	return rc;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_vf_rate_limit)
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_vf_rate_limit);
 int rte_pmd_bnxt_set_vf_rate_limit(uint16_t port, uint16_t vf,
 				uint32_t tx_rate, uint64_t q_msk)
 {
@@ -233,7 +233,7 @@ int rte_pmd_bnxt_set_vf_rate_limit(uint16_t port, uint16_t vf,
 	return rc;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_vf_mac_anti_spoof)
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_vf_mac_anti_spoof);
 int rte_pmd_bnxt_set_vf_mac_anti_spoof(uint16_t port, uint16_t vf, uint8_t on)
 {
 	struct rte_eth_dev_info dev_info;
@@ -294,7 +294,7 @@ int rte_pmd_bnxt_set_vf_mac_anti_spoof(uint16_t port, uint16_t vf, uint8_t on)
 	return rc;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_vf_vlan_anti_spoof)
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_vf_vlan_anti_spoof);
 int rte_pmd_bnxt_set_vf_vlan_anti_spoof(uint16_t port, uint16_t vf, uint8_t on)
 {
 	struct rte_eth_dev_info dev_info;
@@ -354,7 +354,7 @@ rte_pmd_bnxt_set_vf_vlan_stripq_cb(struct bnxt_vnic_info *vnic, void *onptr)
 	vnic->vlan_strip = *on;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_vf_vlan_stripq)
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_vf_vlan_stripq);
 int
 rte_pmd_bnxt_set_vf_vlan_stripq(uint16_t port, uint16_t vf, uint8_t on)
 {
@@ -398,7 +398,7 @@ rte_pmd_bnxt_set_vf_vlan_stripq(uint16_t port, uint16_t vf, uint8_t on)
 	return rc;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_vf_rxmode)
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_vf_rxmode);
 int rte_pmd_bnxt_set_vf_rxmode(uint16_t port, uint16_t vf,
 				uint16_t rx_mask, uint8_t on)
 {
@@ -497,7 +497,7 @@ static int bnxt_set_vf_table(struct bnxt *bp, uint16_t vf)
 	return rc;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_vf_vlan_filter)
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_vf_vlan_filter);
 int rte_pmd_bnxt_set_vf_vlan_filter(uint16_t port, uint16_t vlan,
 				    uint64_t vf_mask, uint8_t vlan_on)
 {
@@ -593,7 +593,7 @@ int rte_pmd_bnxt_set_vf_vlan_filter(uint16_t port, uint16_t vlan,
 	return rc;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_bnxt_get_vf_stats)
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_get_vf_stats);
 int rte_pmd_bnxt_get_vf_stats(uint16_t port,
 			      uint16_t vf_id,
 			      struct rte_eth_stats *stats)
@@ -631,7 +631,7 @@ int rte_pmd_bnxt_get_vf_stats(uint16_t port,
 				     NULL);
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_bnxt_reset_vf_stats)
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_reset_vf_stats);
 int rte_pmd_bnxt_reset_vf_stats(uint16_t port,
 				uint16_t vf_id)
 {
@@ -667,7 +667,7 @@ int rte_pmd_bnxt_reset_vf_stats(uint16_t port,
 	return bnxt_hwrm_func_clr_stats(bp, bp->pf->first_vf_id + vf_id);
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_bnxt_get_vf_rx_status)
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_get_vf_rx_status);
 int rte_pmd_bnxt_get_vf_rx_status(uint16_t port, uint16_t vf_id)
 {
 	struct rte_eth_dev *dev;
@@ -702,7 +702,7 @@ int rte_pmd_bnxt_get_vf_rx_status(uint16_t port, uint16_t vf_id)
 	return bnxt_vf_vnic_count(bp, vf_id);
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_bnxt_get_vf_tx_drop_count)
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_get_vf_tx_drop_count);
 int rte_pmd_bnxt_get_vf_tx_drop_count(uint16_t port, uint16_t vf_id,
 				      uint64_t *count)
 {
@@ -739,7 +739,7 @@ int rte_pmd_bnxt_get_vf_tx_drop_count(uint16_t port, uint16_t vf_id,
 					     count);
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_bnxt_mac_addr_add)
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_mac_addr_add);
 int rte_pmd_bnxt_mac_addr_add(uint16_t port, struct rte_ether_addr *addr,
 				uint32_t vf_id)
 {
@@ -823,7 +823,7 @@ int rte_pmd_bnxt_mac_addr_add(uint16_t port, struct rte_ether_addr *addr,
 	return rc;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_vf_vlan_insert)
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_vf_vlan_insert);
 int
 rte_pmd_bnxt_set_vf_vlan_insert(uint16_t port, uint16_t vf,
 		uint16_t vlan_id)
@@ -869,7 +869,7 @@ rte_pmd_bnxt_set_vf_vlan_insert(uint16_t port, uint16_t vf,
 	return rc;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_vf_persist_stats)
+RTE_EXPORT_SYMBOL(rte_pmd_bnxt_set_vf_persist_stats);
 int rte_pmd_bnxt_set_vf_persist_stats(uint16_t port, uint16_t vf, uint8_t on)
 {
 	struct rte_eth_dev_info dev_info;
diff --git a/drivers/net/bonding/rte_eth_bond_8023ad.c b/drivers/net/bonding/rte_eth_bond_8023ad.c
index 1677615435..6454805f6e 100644
--- a/drivers/net/bonding/rte_eth_bond_8023ad.c
+++ b/drivers/net/bonding/rte_eth_bond_8023ad.c
@@ -1404,7 +1404,7 @@ bond_mode_8023ad_handle_slow_pkt(struct bond_dev_private *internals,
 	rte_pktmbuf_free(pkt);
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_conf_get)
+RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_conf_get);
 int
 rte_eth_bond_8023ad_conf_get(uint16_t port_id,
 		struct rte_eth_bond_8023ad_conf *conf)
@@ -1422,7 +1422,7 @@ rte_eth_bond_8023ad_conf_get(uint16_t port_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_agg_selection_set)
+RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_agg_selection_set);
 int
 rte_eth_bond_8023ad_agg_selection_set(uint16_t port_id,
 		enum rte_bond_8023ad_agg_selection agg_selection)
@@ -1447,7 +1447,7 @@ rte_eth_bond_8023ad_agg_selection_set(uint16_t port_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_agg_selection_get)
+RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_agg_selection_get);
 int rte_eth_bond_8023ad_agg_selection_get(uint16_t port_id)
 {
 	struct rte_eth_dev *bond_dev;
@@ -1495,7 +1495,7 @@ bond_8023ad_setup_validate(uint16_t port_id,
 }
 
 
-RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_setup)
+RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_setup);
 int
 rte_eth_bond_8023ad_setup(uint16_t port_id,
 		struct rte_eth_bond_8023ad_conf *conf)
@@ -1517,7 +1517,7 @@ rte_eth_bond_8023ad_setup(uint16_t port_id,
 
 
 
-RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_member_info)
+RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_member_info);
 int
 rte_eth_bond_8023ad_member_info(uint16_t port_id, uint16_t member_id,
 		struct rte_eth_bond_8023ad_member_info *info)
@@ -1579,7 +1579,7 @@ bond_8023ad_ext_validate(uint16_t port_id, uint16_t member_id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_ext_collect)
+RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_ext_collect);
 int
 rte_eth_bond_8023ad_ext_collect(uint16_t port_id, uint16_t member_id,
 				int enabled)
@@ -1601,7 +1601,7 @@ rte_eth_bond_8023ad_ext_collect(uint16_t port_id, uint16_t member_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_ext_distrib)
+RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_ext_distrib);
 int
 rte_eth_bond_8023ad_ext_distrib(uint16_t port_id, uint16_t member_id,
 				int enabled)
@@ -1623,7 +1623,7 @@ rte_eth_bond_8023ad_ext_distrib(uint16_t port_id, uint16_t member_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_ext_distrib_get)
+RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_ext_distrib_get);
 int
 rte_eth_bond_8023ad_ext_distrib_get(uint16_t port_id, uint16_t member_id)
 {
@@ -1638,7 +1638,7 @@ rte_eth_bond_8023ad_ext_distrib_get(uint16_t port_id, uint16_t member_id)
 	return ACTOR_STATE(port, DISTRIBUTING);
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_ext_collect_get)
+RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_ext_collect_get);
 int
 rte_eth_bond_8023ad_ext_collect_get(uint16_t port_id, uint16_t member_id)
 {
@@ -1653,7 +1653,7 @@ rte_eth_bond_8023ad_ext_collect_get(uint16_t port_id, uint16_t member_id)
 	return ACTOR_STATE(port, COLLECTING);
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_ext_slowtx)
+RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_ext_slowtx);
 int
 rte_eth_bond_8023ad_ext_slowtx(uint16_t port_id, uint16_t member_id,
 		struct rte_mbuf *lacp_pkt)
@@ -1715,7 +1715,7 @@ bond_mode_8023ad_ext_periodic_cb(void *arg)
 			bond_mode_8023ad_ext_periodic_cb, arg);
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_dedicated_queues_enable)
+RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_dedicated_queues_enable);
 int
 rte_eth_bond_8023ad_dedicated_queues_enable(uint16_t port)
 {
@@ -1742,7 +1742,7 @@ rte_eth_bond_8023ad_dedicated_queues_enable(uint16_t port)
 	return retval;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_dedicated_queues_disable)
+RTE_EXPORT_SYMBOL(rte_eth_bond_8023ad_dedicated_queues_disable);
 int
 rte_eth_bond_8023ad_dedicated_queues_disable(uint16_t port)
 {
diff --git a/drivers/net/bonding/rte_eth_bond_api.c b/drivers/net/bonding/rte_eth_bond_api.c
index 9e5df67c18..25ceb82ce7 100644
--- a/drivers/net/bonding/rte_eth_bond_api.c
+++ b/drivers/net/bonding/rte_eth_bond_api.c
@@ -150,7 +150,7 @@ deactivate_member(struct rte_eth_dev *eth_dev, uint16_t port_id)
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_bond_create)
+RTE_EXPORT_SYMBOL(rte_eth_bond_create);
 int
 rte_eth_bond_create(const char *name, uint8_t mode, uint8_t socket_id)
 {
@@ -189,7 +189,7 @@ rte_eth_bond_create(const char *name, uint8_t mode, uint8_t socket_id)
 	return bond_dev->data->port_id;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_bond_free)
+RTE_EXPORT_SYMBOL(rte_eth_bond_free);
 int
 rte_eth_bond_free(const char *name)
 {
@@ -634,7 +634,7 @@ __eth_bond_member_add_lock_free(uint16_t bonding_port_id, uint16_t member_port_i
 
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_bond_member_add)
+RTE_EXPORT_SYMBOL(rte_eth_bond_member_add);
 int
 rte_eth_bond_member_add(uint16_t bonding_port_id, uint16_t member_port_id)
 {
@@ -773,7 +773,7 @@ __eth_bond_member_remove_lock_free(uint16_t bonding_port_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_bond_member_remove)
+RTE_EXPORT_SYMBOL(rte_eth_bond_member_remove);
 int
 rte_eth_bond_member_remove(uint16_t bonding_port_id, uint16_t member_port_id)
 {
@@ -796,7 +796,7 @@ rte_eth_bond_member_remove(uint16_t bonding_port_id, uint16_t member_port_id)
 	return retval;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_bond_mode_set)
+RTE_EXPORT_SYMBOL(rte_eth_bond_mode_set);
 int
 rte_eth_bond_mode_set(uint16_t bonding_port_id, uint8_t mode)
 {
@@ -814,7 +814,7 @@ rte_eth_bond_mode_set(uint16_t bonding_port_id, uint8_t mode)
 	return bond_ethdev_mode_set(bonding_eth_dev, mode);
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_bond_mode_get)
+RTE_EXPORT_SYMBOL(rte_eth_bond_mode_get);
 int
 rte_eth_bond_mode_get(uint16_t bonding_port_id)
 {
@@ -828,7 +828,7 @@ rte_eth_bond_mode_get(uint16_t bonding_port_id)
 	return internals->mode;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_bond_primary_set)
+RTE_EXPORT_SYMBOL(rte_eth_bond_primary_set);
 int
 rte_eth_bond_primary_set(uint16_t bonding_port_id, uint16_t member_port_id)
 {
@@ -850,7 +850,7 @@ rte_eth_bond_primary_set(uint16_t bonding_port_id, uint16_t member_port_id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_bond_primary_get)
+RTE_EXPORT_SYMBOL(rte_eth_bond_primary_get);
 int
 rte_eth_bond_primary_get(uint16_t bonding_port_id)
 {
@@ -867,7 +867,7 @@ rte_eth_bond_primary_get(uint16_t bonding_port_id)
 	return internals->current_primary_port;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_bond_members_get)
+RTE_EXPORT_SYMBOL(rte_eth_bond_members_get);
 int
 rte_eth_bond_members_get(uint16_t bonding_port_id, uint16_t members[],
 			uint16_t len)
@@ -892,7 +892,7 @@ rte_eth_bond_members_get(uint16_t bonding_port_id, uint16_t members[],
 	return internals->member_count;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_bond_active_members_get)
+RTE_EXPORT_SYMBOL(rte_eth_bond_active_members_get);
 int
 rte_eth_bond_active_members_get(uint16_t bonding_port_id, uint16_t members[],
 		uint16_t len)
@@ -916,7 +916,7 @@ rte_eth_bond_active_members_get(uint16_t bonding_port_id, uint16_t members[],
 	return internals->active_member_count;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_bond_mac_address_set)
+RTE_EXPORT_SYMBOL(rte_eth_bond_mac_address_set);
 int
 rte_eth_bond_mac_address_set(uint16_t bonding_port_id,
 		struct rte_ether_addr *mac_addr)
@@ -943,7 +943,7 @@ rte_eth_bond_mac_address_set(uint16_t bonding_port_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_bond_mac_address_reset)
+RTE_EXPORT_SYMBOL(rte_eth_bond_mac_address_reset);
 int
 rte_eth_bond_mac_address_reset(uint16_t bonding_port_id)
 {
@@ -985,7 +985,7 @@ rte_eth_bond_mac_address_reset(uint16_t bonding_port_id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_bond_xmit_policy_set)
+RTE_EXPORT_SYMBOL(rte_eth_bond_xmit_policy_set);
 int
 rte_eth_bond_xmit_policy_set(uint16_t bonding_port_id, uint8_t policy)
 {
@@ -1016,7 +1016,7 @@ rte_eth_bond_xmit_policy_set(uint16_t bonding_port_id, uint8_t policy)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_bond_xmit_policy_get)
+RTE_EXPORT_SYMBOL(rte_eth_bond_xmit_policy_get);
 int
 rte_eth_bond_xmit_policy_get(uint16_t bonding_port_id)
 {
@@ -1030,7 +1030,7 @@ rte_eth_bond_xmit_policy_get(uint16_t bonding_port_id)
 	return internals->balance_xmit_policy;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_bond_link_monitoring_set)
+RTE_EXPORT_SYMBOL(rte_eth_bond_link_monitoring_set);
 int
 rte_eth_bond_link_monitoring_set(uint16_t bonding_port_id, uint32_t internal_ms)
 {
diff --git a/drivers/net/cnxk/cnxk_ethdev.c b/drivers/net/cnxk/cnxk_ethdev.c
index 6c723c9cec..c87a020adb 100644
--- a/drivers/net/cnxk/cnxk_ethdev.c
+++ b/drivers/net/cnxk/cnxk_ethdev.c
@@ -13,7 +13,7 @@ cnxk_ethdev_rx_offload_cb_t cnxk_ethdev_rx_offload_cb;
 
 #define NIX_TM_DFLT_RR_WT 71
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_model_str_get, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_model_str_get, 23.11);
 const char *
 rte_pmd_cnxk_model_str_get(void)
 {
@@ -89,14 +89,14 @@ nix_inl_cq_sz_clamp_up(struct roc_nix *nix, struct rte_mempool *mp,
 	return nb_desc;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ethdev_rx_offload_cb_register)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_ethdev_rx_offload_cb_register);
 void
 cnxk_ethdev_rx_offload_cb_register(cnxk_ethdev_rx_offload_cb_t cb)
 {
 	cnxk_ethdev_rx_offload_cb = cb;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(cnxk_nix_inb_mode_set)
+RTE_EXPORT_INTERNAL_SYMBOL(cnxk_nix_inb_mode_set);
 int
 cnxk_nix_inb_mode_set(struct cnxk_eth_dev *dev, bool use_inl_dev)
 {
diff --git a/drivers/net/cnxk/cnxk_ethdev_sec.c b/drivers/net/cnxk/cnxk_ethdev_sec.c
index ac6ee79f78..8af31c74f2 100644
--- a/drivers/net/cnxk/cnxk_ethdev_sec.c
+++ b/drivers/net/cnxk/cnxk_ethdev_sec.c
@@ -306,21 +306,21 @@ cnxk_eth_sec_sess_get_by_sess(struct cnxk_eth_dev *dev,
 	return NULL;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_inl_dev_submit, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_inl_dev_submit, 23.11);
 uint16_t
 rte_pmd_cnxk_inl_dev_submit(struct rte_pmd_cnxk_inl_dev_q *qptr, void *inst, uint16_t nb_inst)
 {
 	return cnxk_pmd_ops.inl_dev_submit((struct roc_nix_inl_dev_q *)qptr, inst, nb_inst);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_inl_dev_qptr_get, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_inl_dev_qptr_get, 23.11);
 struct rte_pmd_cnxk_inl_dev_q *
 rte_pmd_cnxk_inl_dev_qptr_get(void)
 {
 	return roc_nix_inl_dev_qptr_get(0);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_cpt_q_stats_get, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_cpt_q_stats_get, 23.11);
 int
 rte_pmd_cnxk_cpt_q_stats_get(uint16_t portid, enum rte_pmd_cnxk_cpt_q_stats_type type,
 			     struct rte_pmd_cnxk_cpt_q_stats *stats, uint16_t idx)
@@ -332,7 +332,7 @@ rte_pmd_cnxk_cpt_q_stats_get(uint16_t portid, enum rte_pmd_cnxk_cpt_q_stats_type
 					    (struct roc_nix_cpt_lf_stats *)stats, idx);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_hw_session_base_get, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_hw_session_base_get, 23.11);
 union rte_pmd_cnxk_ipsec_hw_sa *
 rte_pmd_cnxk_hw_session_base_get(uint16_t portid, bool inb)
 {
@@ -348,7 +348,7 @@ rte_pmd_cnxk_hw_session_base_get(uint16_t portid, bool inb)
 	return (union rte_pmd_cnxk_ipsec_hw_sa *)sa_base;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_sa_flush, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_sa_flush, 23.11);
 int
 rte_pmd_cnxk_sa_flush(uint16_t portid, union rte_pmd_cnxk_ipsec_hw_sa *sess, bool inb)
 {
@@ -375,7 +375,7 @@ rte_pmd_cnxk_sa_flush(uint16_t portid, union rte_pmd_cnxk_ipsec_hw_sa *sess, boo
 	return rc;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_hw_sa_read, 22.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_hw_sa_read, 22.07);
 int
 rte_pmd_cnxk_hw_sa_read(uint16_t portid, void *sess, union rte_pmd_cnxk_ipsec_hw_sa *data,
 			uint32_t len, bool inb)
@@ -421,7 +421,7 @@ rte_pmd_cnxk_hw_sa_read(uint16_t portid, void *sess, union rte_pmd_cnxk_ipsec_hw
 	return rc;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_hw_sa_write, 22.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_hw_sa_write, 22.07);
 int
 rte_pmd_cnxk_hw_sa_write(uint16_t portid, void *sess, union rte_pmd_cnxk_ipsec_hw_sa *data,
 			 uint32_t len, bool inb)
@@ -462,7 +462,7 @@ rte_pmd_cnxk_hw_sa_write(uint16_t portid, void *sess, union rte_pmd_cnxk_ipsec_h
 	return rc;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_inl_ipsec_res, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_inl_ipsec_res, 23.11);
 union rte_pmd_cnxk_cpt_res_s *
 rte_pmd_cnxk_inl_ipsec_res(struct rte_mbuf *mbuf)
 {
@@ -481,7 +481,7 @@ rte_pmd_cnxk_inl_ipsec_res(struct rte_mbuf *mbuf)
 	return (void *)(wqe + 64 + desc_size);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_hw_inline_inb_cfg_set, 23.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_cnxk_hw_inline_inb_cfg_set, 23.11);
 void
 rte_pmd_cnxk_hw_inline_inb_cfg_set(uint16_t portid, struct rte_pmd_cnxk_ipsec_inb_cfg *cfg)
 {
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 00b57cb715..32e34eb272 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -1295,7 +1295,7 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa_eth_eventq_attach)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_eth_eventq_attach);
 int
 dpaa_eth_eventq_attach(const struct rte_eth_dev *dev,
 		int eth_rx_queue_id,
@@ -1361,7 +1361,7 @@ dpaa_eth_eventq_attach(const struct rte_eth_dev *dev,
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa_eth_eventq_detach)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_eth_eventq_detach);
 int
 dpaa_eth_eventq_detach(const struct rte_eth_dev *dev,
 		int eth_rx_queue_id)
@@ -1803,7 +1803,7 @@ is_dpaa_supported(struct rte_eth_dev *dev)
 	return is_device_supported(dev, &rte_dpaa_pmd);
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_dpaa_set_tx_loopback)
+RTE_EXPORT_SYMBOL(rte_pmd_dpaa_set_tx_loopback);
 int
 rte_pmd_dpaa_set_tx_loopback(uint16_t port, uint8_t on)
 {
diff --git a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
index b1d473429a..6cb811597c 100644
--- a/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
+++ b/drivers/net/dpaa2/base/dpaa2_hw_dpni.c
@@ -29,7 +29,7 @@ dpaa2_distset_to_dpkg_profile_cfg(
 		uint64_t req_dist_set,
 		struct dpkg_profile_cfg *kg_cfg);
 
-RTE_EXPORT_SYMBOL(rte_pmd_dpaa2_set_custom_hash)
+RTE_EXPORT_SYMBOL(rte_pmd_dpaa2_set_custom_hash);
 int
 rte_pmd_dpaa2_set_custom_hash(uint16_t port_id,
 	uint16_t offset, uint8_t size)
diff --git a/drivers/net/dpaa2/base/dpaa2_tlu_hash.c b/drivers/net/dpaa2/base/dpaa2_tlu_hash.c
index 8c685120bd..f8ca9a3874 100644
--- a/drivers/net/dpaa2/base/dpaa2_tlu_hash.c
+++ b/drivers/net/dpaa2/base/dpaa2_tlu_hash.c
@@ -144,7 +144,7 @@ static void hash_init(void)
 		}
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_get_tlu_hash, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_get_tlu_hash, 21.11);
 uint32_t rte_pmd_dpaa2_get_tlu_hash(uint8_t *data, int size)
 {
 	static int init;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 998d1e7c53..3e5e8fe407 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -2240,7 +2240,7 @@ dpaa2_dev_rss_hash_conf_get(struct rte_eth_dev *dev,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_eth_eventq_attach)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_eth_eventq_attach);
 int dpaa2_eth_eventq_attach(const struct rte_eth_dev *dev,
 		int eth_rx_queue_id,
 		struct dpaa2_dpcon_dev *dpcon,
@@ -2327,7 +2327,7 @@ int dpaa2_eth_eventq_attach(const struct rte_eth_dev *dev,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_eth_eventq_detach)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_eth_eventq_detach);
 int dpaa2_eth_eventq_detach(const struct rte_eth_dev *dev,
 		int eth_rx_queue_id)
 {
@@ -2413,7 +2413,7 @@ dpaa2_tm_ops_get(struct rte_eth_dev *dev __rte_unused, void *ops)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_thread_init, 21.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_thread_init, 21.08);
 void
 rte_pmd_dpaa2_thread_init(void)
 {
@@ -2853,7 +2853,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	return ret;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_dev_is_dpaa2, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_dev_is_dpaa2, 24.11);
 int
 rte_pmd_dpaa2_dev_is_dpaa2(uint32_t eth_id)
 {
@@ -2869,7 +2869,7 @@ rte_pmd_dpaa2_dev_is_dpaa2(uint32_t eth_id)
 	return dev->device->driver == &rte_dpaa2_pmd.driver;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_ep_name, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_ep_name, 24.11);
 const char *
 rte_pmd_dpaa2_ep_name(uint32_t eth_id)
 {
@@ -2895,7 +2895,7 @@ rte_pmd_dpaa2_ep_name(uint32_t eth_id)
 }
 
 #if defined(RTE_LIBRTE_IEEE1588)
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_get_one_step_ts, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_get_one_step_ts, 24.11);
 int
 rte_pmd_dpaa2_get_one_step_ts(uint16_t port_id, bool mc_query)
 {
@@ -2924,7 +2924,7 @@ rte_pmd_dpaa2_get_one_step_ts(uint16_t port_id, bool mc_query)
 	return priv->ptp_correction_offset;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_set_one_step_ts, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_set_one_step_ts, 24.11);
 int
 rte_pmd_dpaa2_set_one_step_ts(uint16_t port_id, uint16_t offset, uint8_t ch_update)
 {
diff --git a/drivers/net/dpaa2/dpaa2_mux.c b/drivers/net/dpaa2/dpaa2_mux.c
index 1908d1e865..95bd99fe80 100644
--- a/drivers/net/dpaa2/dpaa2_mux.c
+++ b/drivers/net/dpaa2/dpaa2_mux.c
@@ -55,7 +55,7 @@ static struct dpaa2_dpdmux_dev *get_dpdmux_from_id(uint32_t dpdmux_id)
 	return dpdmux_dev;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_dpaa2_mux_flow_create)
+RTE_EXPORT_SYMBOL(rte_pmd_dpaa2_mux_flow_create);
 int
 rte_pmd_dpaa2_mux_flow_create(uint32_t dpdmux_id,
 	struct rte_flow_item pattern[],
@@ -366,7 +366,7 @@ rte_pmd_dpaa2_mux_flow_l2(uint32_t dpdmux_id,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_mux_rx_frame_len, 21.05)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_mux_rx_frame_len, 21.05);
 int
 rte_pmd_dpaa2_mux_rx_frame_len(uint32_t dpdmux_id, uint16_t max_rx_frame_len)
 {
@@ -394,7 +394,7 @@ rte_pmd_dpaa2_mux_rx_frame_len(uint32_t dpdmux_id, uint16_t max_rx_frame_len)
 }
 
 /* dump the status of the dpaa2_mux counters on the console */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_mux_dump_counter, 24.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_mux_dump_counter, 24.11);
 void
 rte_pmd_dpaa2_mux_dump_counter(FILE *f, uint32_t dpdmux_id, int num_if)
 {
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 67d065bb7c..3c76df4c6f 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -1581,7 +1581,7 @@ dpaa2_set_enqueue_descriptor(struct dpaa2_queue *dpaa2_q,
 	*dpaa2_seqn(m) = DPAA2_INVALID_MBUF_SEQN;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dev_tx_multi_txq_ordered)
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa2_dev_tx_multi_txq_ordered);
 uint16_t
 dpaa2_dev_tx_multi_txq_ordered(void **queue,
 		struct rte_mbuf **bufs, uint16_t nb_pkts)
diff --git a/drivers/net/intel/i40e/rte_pmd_i40e.c b/drivers/net/intel/i40e/rte_pmd_i40e.c
index a358f68bc5..19b29b8576 100644
--- a/drivers/net/intel/i40e/rte_pmd_i40e.c
+++ b/drivers/net/intel/i40e/rte_pmd_i40e.c
@@ -14,7 +14,7 @@
 #include "i40e_rxtx.h"
 #include "rte_pmd_i40e.h"
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_ping_vfs)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_ping_vfs);
 int
 rte_pmd_i40e_ping_vfs(uint16_t port, uint16_t vf)
 {
@@ -40,7 +40,7 @@ rte_pmd_i40e_ping_vfs(uint16_t port, uint16_t vf)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_mac_anti_spoof)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_mac_anti_spoof);
 int
 rte_pmd_i40e_set_vf_mac_anti_spoof(uint16_t port, uint16_t vf_id, uint8_t on)
 {
@@ -145,7 +145,7 @@ i40e_add_rm_all_vlan_filter(struct i40e_vsi *vsi, uint8_t add)
 	return I40E_SUCCESS;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_vlan_anti_spoof)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_vlan_anti_spoof);
 int
 rte_pmd_i40e_set_vf_vlan_anti_spoof(uint16_t port, uint16_t vf_id, uint8_t on)
 {
@@ -406,7 +406,7 @@ i40e_vsi_set_tx_loopback(struct i40e_vsi *vsi, uint8_t on)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_tx_loopback)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_tx_loopback);
 int
 rte_pmd_i40e_set_tx_loopback(uint16_t port, uint8_t on)
 {
@@ -450,7 +450,7 @@ rte_pmd_i40e_set_tx_loopback(uint16_t port, uint8_t on)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_unicast_promisc)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_unicast_promisc);
 int
 rte_pmd_i40e_set_vf_unicast_promisc(uint16_t port, uint16_t vf_id, uint8_t on)
 {
@@ -492,7 +492,7 @@ rte_pmd_i40e_set_vf_unicast_promisc(uint16_t port, uint16_t vf_id, uint8_t on)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_multicast_promisc)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_multicast_promisc);
 int
 rte_pmd_i40e_set_vf_multicast_promisc(uint16_t port, uint16_t vf_id, uint8_t on)
 {
@@ -534,7 +534,7 @@ rte_pmd_i40e_set_vf_multicast_promisc(uint16_t port, uint16_t vf_id, uint8_t on)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_mac_addr)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_mac_addr);
 int
 rte_pmd_i40e_set_vf_mac_addr(uint16_t port, uint16_t vf_id,
 			     struct rte_ether_addr *mac_addr)
@@ -625,7 +625,7 @@ rte_pmd_i40e_remove_vf_mac_addr(uint16_t port, uint16_t vf_id,
 }
 
 /* Set vlan strip on/off for specific VF from host */
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_vlan_stripq)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_vlan_stripq);
 int
 rte_pmd_i40e_set_vf_vlan_stripq(uint16_t port, uint16_t vf_id, uint8_t on)
 {
@@ -662,7 +662,7 @@ rte_pmd_i40e_set_vf_vlan_stripq(uint16_t port, uint16_t vf_id, uint8_t on)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_vlan_insert)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_vlan_insert);
 int rte_pmd_i40e_set_vf_vlan_insert(uint16_t port, uint16_t vf_id,
 				    uint16_t vlan_id)
 {
@@ -728,7 +728,7 @@ int rte_pmd_i40e_set_vf_vlan_insert(uint16_t port, uint16_t vf_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_broadcast)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_broadcast);
 int rte_pmd_i40e_set_vf_broadcast(uint16_t port, uint16_t vf_id,
 				  uint8_t on)
 {
@@ -795,7 +795,7 @@ int rte_pmd_i40e_set_vf_broadcast(uint16_t port, uint16_t vf_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_vlan_tag)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_vlan_tag);
 int rte_pmd_i40e_set_vf_vlan_tag(uint16_t port, uint16_t vf_id, uint8_t on)
 {
 	struct rte_eth_dev *dev;
@@ -890,7 +890,7 @@ i40e_vlan_filter_count(struct i40e_vsi *vsi)
 	return count;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_vlan_filter)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_vlan_filter);
 int rte_pmd_i40e_set_vf_vlan_filter(uint16_t port, uint16_t vlan_id,
 				    uint64_t vf_mask, uint8_t on)
 {
@@ -973,7 +973,7 @@ int rte_pmd_i40e_set_vf_vlan_filter(uint16_t port, uint16_t vlan_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_get_vf_stats)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_get_vf_stats);
 int
 rte_pmd_i40e_get_vf_stats(uint16_t port,
 			  uint16_t vf_id,
@@ -1019,7 +1019,7 @@ rte_pmd_i40e_get_vf_stats(uint16_t port,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_reset_vf_stats)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_reset_vf_stats);
 int
 rte_pmd_i40e_reset_vf_stats(uint16_t port,
 			    uint16_t vf_id)
@@ -1054,7 +1054,7 @@ rte_pmd_i40e_reset_vf_stats(uint16_t port,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_max_bw)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_max_bw);
 int
 rte_pmd_i40e_set_vf_max_bw(uint16_t port, uint16_t vf_id, uint32_t bw)
 {
@@ -1144,7 +1144,7 @@ rte_pmd_i40e_set_vf_max_bw(uint16_t port, uint16_t vf_id, uint32_t bw)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_tc_bw_alloc)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_tc_bw_alloc);
 int
 rte_pmd_i40e_set_vf_tc_bw_alloc(uint16_t port, uint16_t vf_id,
 				uint8_t tc_num, uint8_t *bw_weight)
@@ -1259,7 +1259,7 @@ rte_pmd_i40e_set_vf_tc_bw_alloc(uint16_t port, uint16_t vf_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_tc_max_bw)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_vf_tc_max_bw);
 int
 rte_pmd_i40e_set_vf_tc_max_bw(uint16_t port, uint16_t vf_id,
 			      uint8_t tc_no, uint32_t bw)
@@ -1378,7 +1378,7 @@ rte_pmd_i40e_set_vf_tc_max_bw(uint16_t port, uint16_t vf_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_tc_strict_prio)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_set_tc_strict_prio);
 int
 rte_pmd_i40e_set_tc_strict_prio(uint16_t port, uint8_t tc_map)
 {
@@ -1624,7 +1624,7 @@ i40e_check_profile_info(uint16_t port, uint8_t *profile_info_sec)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_process_ddp_package)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_process_ddp_package);
 int
 rte_pmd_i40e_process_ddp_package(uint16_t port, uint8_t *buff,
 				 uint32_t size,
@@ -1809,7 +1809,7 @@ i40e_get_tlv_section_size(struct i40e_profile_section_header *sec)
 	return nb_tlv;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_get_ddp_info)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_get_ddp_info);
 int rte_pmd_i40e_get_ddp_info(uint8_t *pkg_buff, uint32_t pkg_size,
 	uint8_t *info_buff, uint32_t info_size,
 	enum rte_pmd_i40e_package_info type)
@@ -2118,7 +2118,7 @@ int rte_pmd_i40e_get_ddp_info(uint8_t *pkg_buff, uint32_t pkg_size,
 	return -EINVAL;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_get_ddp_list)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_get_ddp_list);
 int
 rte_pmd_i40e_get_ddp_list(uint16_t port, uint8_t *buff, uint32_t size)
 {
@@ -2250,7 +2250,7 @@ static int check_invalid_ptype_mapping(
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_ptype_mapping_update)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_ptype_mapping_update);
 int
 rte_pmd_i40e_ptype_mapping_update(
 			uint16_t port,
@@ -2289,7 +2289,7 @@ rte_pmd_i40e_ptype_mapping_update(
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_ptype_mapping_reset)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_ptype_mapping_reset);
 int rte_pmd_i40e_ptype_mapping_reset(uint16_t port)
 {
 	struct rte_eth_dev *dev;
@@ -2306,7 +2306,7 @@ int rte_pmd_i40e_ptype_mapping_reset(uint16_t port)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_ptype_mapping_get)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_ptype_mapping_get);
 int rte_pmd_i40e_ptype_mapping_get(
 			uint16_t port,
 			struct rte_pmd_i40e_ptype_mapping *mapping_items,
@@ -2342,7 +2342,7 @@ int rte_pmd_i40e_ptype_mapping_get(
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_ptype_mapping_replace)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_ptype_mapping_replace);
 int rte_pmd_i40e_ptype_mapping_replace(uint16_t port,
 				       uint32_t target,
 				       uint8_t mask,
@@ -2381,7 +2381,7 @@ int rte_pmd_i40e_ptype_mapping_replace(uint16_t port,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_add_vf_mac_addr)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_add_vf_mac_addr);
 int
 rte_pmd_i40e_add_vf_mac_addr(uint16_t port, uint16_t vf_id,
 			     struct rte_ether_addr *mac_addr)
@@ -2429,7 +2429,7 @@ rte_pmd_i40e_add_vf_mac_addr(uint16_t port, uint16_t vf_id,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_flow_type_mapping_reset)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_flow_type_mapping_reset);
 int rte_pmd_i40e_flow_type_mapping_reset(uint16_t port)
 {
 	struct rte_eth_dev *dev;
@@ -2446,7 +2446,7 @@ int rte_pmd_i40e_flow_type_mapping_reset(uint16_t port)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_flow_type_mapping_get)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_flow_type_mapping_get);
 int rte_pmd_i40e_flow_type_mapping_get(
 			uint16_t port,
 			struct rte_pmd_i40e_flow_type_mapping *mapping_items)
@@ -2472,7 +2472,7 @@ int rte_pmd_i40e_flow_type_mapping_get(
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_flow_type_mapping_update)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_flow_type_mapping_update);
 int
 rte_pmd_i40e_flow_type_mapping_update(
 			uint16_t port,
@@ -2526,7 +2526,7 @@ rte_pmd_i40e_flow_type_mapping_update(
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_query_vfid_by_mac)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_query_vfid_by_mac);
 int
 rte_pmd_i40e_query_vfid_by_mac(uint16_t port,
 			const struct rte_ether_addr *vf_mac)
@@ -2997,7 +2997,7 @@ i40e_queue_region_get_all_info(struct i40e_pf *pf,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_rss_queue_region_conf)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_rss_queue_region_conf);
 int rte_pmd_i40e_rss_queue_region_conf(uint16_t port_id,
 		enum rte_pmd_i40e_queue_region_op op_type, void *arg)
 {
@@ -3063,7 +3063,7 @@ int rte_pmd_i40e_rss_queue_region_conf(uint16_t port_id,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_flow_add_del_packet_template)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_flow_add_del_packet_template);
 int rte_pmd_i40e_flow_add_del_packet_template(
 			uint16_t port,
 			const struct rte_pmd_i40e_pkt_template_conf *conf,
@@ -3097,7 +3097,7 @@ int rte_pmd_i40e_flow_add_del_packet_template(
 	return i40e_flow_add_del_fdir_filter(dev, &filter_conf, add);
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_inset_get)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_inset_get);
 int
 rte_pmd_i40e_inset_get(uint16_t port, uint8_t pctype,
 		       struct rte_pmd_i40e_inset *inset,
@@ -3170,7 +3170,7 @@ rte_pmd_i40e_inset_get(uint16_t port, uint8_t pctype,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_i40e_inset_set)
+RTE_EXPORT_SYMBOL(rte_pmd_i40e_inset_set);
 int
 rte_pmd_i40e_inset_set(uint16_t port, uint8_t pctype,
 		       struct rte_pmd_i40e_inset *inset,
@@ -3245,7 +3245,7 @@ rte_pmd_i40e_inset_set(uint16_t port, uint8_t pctype,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_i40e_get_fdir_info, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_i40e_get_fdir_info, 20.08);
 int
 rte_pmd_i40e_get_fdir_info(uint16_t port, struct rte_eth_fdir_info *fdir_info)
 {
@@ -3262,7 +3262,7 @@ rte_pmd_i40e_get_fdir_info(uint16_t port, struct rte_eth_fdir_info *fdir_info)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_i40e_get_fdir_stats, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_i40e_get_fdir_stats, 20.08);
 int
 rte_pmd_i40e_get_fdir_stats(uint16_t port, struct rte_eth_fdir_stats *fdir_stat)
 {
@@ -3279,7 +3279,7 @@ rte_pmd_i40e_get_fdir_stats(uint16_t port, struct rte_eth_fdir_stats *fdir_stat)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_i40e_set_gre_key_len, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_i40e_set_gre_key_len, 20.08);
 int
 rte_pmd_i40e_set_gre_key_len(uint16_t port, uint8_t len)
 {
@@ -3299,7 +3299,7 @@ rte_pmd_i40e_set_gre_key_len(uint16_t port, uint8_t len)
 	return i40e_dev_set_gre_key_len(hw, len);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_i40e_set_switch_dev, 19.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_i40e_set_switch_dev, 19.11);
 int
 rte_pmd_i40e_set_switch_dev(uint16_t port_id, struct rte_eth_dev *switch_dev)
 {
@@ -3321,7 +3321,7 @@ rte_pmd_i40e_set_switch_dev(uint16_t port_id, struct rte_eth_dev *switch_dev)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_i40e_set_pf_src_prune, 23.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_i40e_set_pf_src_prune, 23.07);
 int
 rte_pmd_i40e_set_pf_src_prune(uint16_t port, uint8_t on)
 {
diff --git a/drivers/net/intel/iavf/iavf_base_symbols.c b/drivers/net/intel/iavf/iavf_base_symbols.c
index 2111b14aa8..706aa36a92 100644
--- a/drivers/net/intel/iavf/iavf_base_symbols.c
+++ b/drivers/net/intel/iavf/iavf_base_symbols.c
@@ -5,10 +5,10 @@
 #include <eal_export.h>
 
 /* Symbols from the base driver are exported separately below. */
-RTE_EXPORT_INTERNAL_SYMBOL(iavf_init_adminq)
-RTE_EXPORT_INTERNAL_SYMBOL(iavf_shutdown_adminq)
-RTE_EXPORT_INTERNAL_SYMBOL(iavf_clean_arq_element)
-RTE_EXPORT_INTERNAL_SYMBOL(iavf_set_mac_type)
-RTE_EXPORT_INTERNAL_SYMBOL(iavf_aq_send_msg_to_pf)
-RTE_EXPORT_INTERNAL_SYMBOL(iavf_vf_parse_hw_config)
-RTE_EXPORT_INTERNAL_SYMBOL(iavf_vf_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(iavf_init_adminq);
+RTE_EXPORT_INTERNAL_SYMBOL(iavf_shutdown_adminq);
+RTE_EXPORT_INTERNAL_SYMBOL(iavf_clean_arq_element);
+RTE_EXPORT_INTERNAL_SYMBOL(iavf_set_mac_type);
+RTE_EXPORT_INTERNAL_SYMBOL(iavf_aq_send_msg_to_pf);
+RTE_EXPORT_INTERNAL_SYMBOL(iavf_vf_parse_hw_config);
+RTE_EXPORT_INTERNAL_SYMBOL(iavf_vf_reset);
diff --git a/drivers/net/intel/iavf/iavf_rxtx.c b/drivers/net/intel/iavf/iavf_rxtx.c
index 7033a74610..ff298e164b 100644
--- a/drivers/net/intel/iavf/iavf_rxtx.c
+++ b/drivers/net/intel/iavf/iavf_rxtx.c
@@ -75,23 +75,23 @@ struct offload_info {
 };
 
 /* Offset of mbuf dynamic field for protocol extraction's metadata */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ifd_dynfield_proto_xtr_metadata_offs, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ifd_dynfield_proto_xtr_metadata_offs, 20.11);
 int rte_pmd_ifd_dynfield_proto_xtr_metadata_offs = -1;
 
 /* Mask of mbuf dynamic flags for protocol extraction's type */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ifd_dynflag_proto_xtr_vlan_mask, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ifd_dynflag_proto_xtr_vlan_mask, 20.11);
 uint64_t rte_pmd_ifd_dynflag_proto_xtr_vlan_mask;
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ifd_dynflag_proto_xtr_ipv4_mask, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ifd_dynflag_proto_xtr_ipv4_mask, 20.11);
 uint64_t rte_pmd_ifd_dynflag_proto_xtr_ipv4_mask;
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ifd_dynflag_proto_xtr_ipv6_mask, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ifd_dynflag_proto_xtr_ipv6_mask, 20.11);
 uint64_t rte_pmd_ifd_dynflag_proto_xtr_ipv6_mask;
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ifd_dynflag_proto_xtr_ipv6_flow_mask, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ifd_dynflag_proto_xtr_ipv6_flow_mask, 20.11);
 uint64_t rte_pmd_ifd_dynflag_proto_xtr_ipv6_flow_mask;
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ifd_dynflag_proto_xtr_tcp_mask, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ifd_dynflag_proto_xtr_tcp_mask, 20.11);
 uint64_t rte_pmd_ifd_dynflag_proto_xtr_tcp_mask;
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ifd_dynflag_proto_xtr_ip_offset_mask, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ifd_dynflag_proto_xtr_ip_offset_mask, 20.11);
 uint64_t rte_pmd_ifd_dynflag_proto_xtr_ip_offset_mask;
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ifd_dynflag_proto_xtr_ipsec_crypto_said_mask, 21.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ifd_dynflag_proto_xtr_ipsec_crypto_said_mask, 21.11);
 uint64_t rte_pmd_ifd_dynflag_proto_xtr_ipsec_crypto_said_mask;
 
 uint8_t
diff --git a/drivers/net/intel/ice/ice_diagnose.c b/drivers/net/intel/ice/ice_diagnose.c
index 298d1eda5c..db89b793ed 100644
--- a/drivers/net/intel/ice/ice_diagnose.c
+++ b/drivers/net/intel/ice/ice_diagnose.c
@@ -410,7 +410,7 @@ ice_dump_pkg(struct rte_eth_dev *dev, uint8_t **buff, uint32_t *size)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ice_dump_package, 19.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ice_dump_package, 19.11);
 int rte_pmd_ice_dump_package(uint16_t port, uint8_t **buff, uint32_t *size)
 {
 	struct rte_eth_dev *dev;
@@ -499,7 +499,7 @@ ice_dump_switch(struct rte_eth_dev *dev, uint8_t **buff2, uint32_t *size)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ice_dump_switch, 22.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ice_dump_switch, 22.11);
 int rte_pmd_ice_dump_switch(uint16_t port, uint8_t **buff, uint32_t *size)
 {
 	struct rte_eth_dev *dev;
@@ -801,7 +801,7 @@ query_node_recursive(struct ice_hw *hw, struct rte_eth_dev_data *ethdata,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ice_dump_txsched, 24.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ice_dump_txsched, 24.03);
 int
 rte_pmd_ice_dump_txsched(uint16_t port, bool detail, FILE *stream)
 {
diff --git a/drivers/net/intel/idpf/idpf_common_device.c b/drivers/net/intel/idpf/idpf_common_device.c
index ff1fbcd2b4..cdf804e119 100644
--- a/drivers/net/intel/idpf/idpf_common_device.c
+++ b/drivers/net/intel/idpf/idpf_common_device.c
@@ -382,7 +382,7 @@ idpf_get_pkt_type(struct idpf_adapter *adapter)
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_adapter_init)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_adapter_init);
 int
 idpf_adapter_init(struct idpf_adapter *adapter)
 {
@@ -443,7 +443,7 @@ idpf_adapter_init(struct idpf_adapter *adapter)
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_adapter_deinit)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_adapter_deinit);
 int
 idpf_adapter_deinit(struct idpf_adapter *adapter)
 {
@@ -456,7 +456,7 @@ idpf_adapter_deinit(struct idpf_adapter *adapter)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vport_init)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vport_init);
 int
 idpf_vport_init(struct idpf_vport *vport,
 		struct virtchnl2_create_vport *create_vport_info,
@@ -570,7 +570,7 @@ idpf_vport_init(struct idpf_vport *vport,
 err_create_vport:
 	return ret;
 }
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vport_deinit)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vport_deinit);
 int
 idpf_vport_deinit(struct idpf_vport *vport)
 {
@@ -588,7 +588,7 @@ idpf_vport_deinit(struct idpf_vport *vport)
 
 	return 0;
 }
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vport_rss_config)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vport_rss_config);
 int
 idpf_vport_rss_config(struct idpf_vport *vport)
 {
@@ -615,7 +615,7 @@ idpf_vport_rss_config(struct idpf_vport *vport)
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vport_irq_map_config)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vport_irq_map_config);
 int
 idpf_vport_irq_map_config(struct idpf_vport *vport, uint16_t nb_rx_queues)
 {
@@ -691,7 +691,7 @@ idpf_vport_irq_map_config(struct idpf_vport *vport, uint16_t nb_rx_queues)
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vport_irq_map_config_by_qids)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vport_irq_map_config_by_qids);
 int
 idpf_vport_irq_map_config_by_qids(struct idpf_vport *vport, uint32_t *qids, uint16_t nb_rx_queues)
 {
@@ -767,7 +767,7 @@ idpf_vport_irq_map_config_by_qids(struct idpf_vport *vport, uint32_t *qids, uint
 	return ret;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vport_irq_unmap_config)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vport_irq_unmap_config);
 int
 idpf_vport_irq_unmap_config(struct idpf_vport *vport, uint16_t nb_rx_queues)
 {
@@ -779,7 +779,7 @@ idpf_vport_irq_unmap_config(struct idpf_vport *vport, uint16_t nb_rx_queues)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vport_info_init)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vport_info_init);
 int
 idpf_vport_info_init(struct idpf_vport *vport,
 			    struct virtchnl2_create_vport *vport_info)
@@ -816,7 +816,7 @@ idpf_vport_info_init(struct idpf_vport *vport,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vport_stats_update)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vport_stats_update);
 void
 idpf_vport_stats_update(struct virtchnl2_vport_stats *oes, struct virtchnl2_vport_stats *nes)
 {
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx.c b/drivers/net/intel/idpf/idpf_common_rxtx.c
index eb25b091d8..4e6fa28ac2 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx.c
@@ -11,7 +11,7 @@
 int idpf_timestamp_dynfield_offset = -1;
 uint64_t idpf_timestamp_dynflag;
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_rx_thresh_check)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_rx_thresh_check);
 int
 idpf_qc_rx_thresh_check(uint16_t nb_desc, uint16_t thresh)
 {
@@ -27,7 +27,7 @@ idpf_qc_rx_thresh_check(uint16_t nb_desc, uint16_t thresh)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_tx_thresh_check)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_tx_thresh_check);
 int
 idpf_qc_tx_thresh_check(uint16_t nb_desc, uint16_t tx_rs_thresh,
 			uint16_t tx_free_thresh)
@@ -76,7 +76,7 @@ idpf_qc_tx_thresh_check(uint16_t nb_desc, uint16_t tx_rs_thresh,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_rxq_mbufs_release)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_rxq_mbufs_release);
 void
 idpf_qc_rxq_mbufs_release(struct idpf_rx_queue *rxq)
 {
@@ -93,7 +93,7 @@ idpf_qc_rxq_mbufs_release(struct idpf_rx_queue *rxq)
 	}
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_rx_descq_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_rx_descq_reset);
 void
 idpf_qc_split_rx_descq_reset(struct idpf_rx_queue *rxq)
 {
@@ -113,7 +113,7 @@ idpf_qc_split_rx_descq_reset(struct idpf_rx_queue *rxq)
 	rxq->expected_gen_id = 1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_rx_bufq_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_rx_bufq_reset);
 void
 idpf_qc_split_rx_bufq_reset(struct idpf_rx_queue *rxq)
 {
@@ -149,7 +149,7 @@ idpf_qc_split_rx_bufq_reset(struct idpf_rx_queue *rxq)
 	rxq->bufq2 = NULL;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_rx_queue_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_rx_queue_reset);
 void
 idpf_qc_split_rx_queue_reset(struct idpf_rx_queue *rxq)
 {
@@ -158,7 +158,7 @@ idpf_qc_split_rx_queue_reset(struct idpf_rx_queue *rxq)
 	idpf_qc_split_rx_bufq_reset(rxq->bufq2);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_single_rx_queue_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_single_rx_queue_reset);
 void
 idpf_qc_single_rx_queue_reset(struct idpf_rx_queue *rxq)
 {
@@ -190,7 +190,7 @@ idpf_qc_single_rx_queue_reset(struct idpf_rx_queue *rxq)
 	rxq->rxrearm_nb = 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_tx_descq_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_tx_descq_reset);
 void
 idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq)
 {
@@ -229,7 +229,7 @@ idpf_qc_split_tx_descq_reset(struct ci_tx_queue *txq)
 	txq->tx_next_rs = txq->tx_rs_thresh - 1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_tx_complq_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_tx_complq_reset);
 void
 idpf_qc_split_tx_complq_reset(struct ci_tx_queue *cq)
 {
@@ -248,7 +248,7 @@ idpf_qc_split_tx_complq_reset(struct ci_tx_queue *cq)
 	cq->expected_gen_id = 1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_single_tx_queue_reset)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_single_tx_queue_reset);
 void
 idpf_qc_single_tx_queue_reset(struct ci_tx_queue *txq)
 {
@@ -286,7 +286,7 @@ idpf_qc_single_tx_queue_reset(struct ci_tx_queue *txq)
 	txq->tx_next_rs = txq->tx_rs_thresh - 1;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_rx_queue_release)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_rx_queue_release);
 void
 idpf_qc_rx_queue_release(void *rxq)
 {
@@ -317,7 +317,7 @@ idpf_qc_rx_queue_release(void *rxq)
 	rte_free(q);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_tx_queue_release)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_tx_queue_release);
 void
 idpf_qc_tx_queue_release(void *txq)
 {
@@ -337,7 +337,7 @@ idpf_qc_tx_queue_release(void *txq)
 	rte_free(q);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_ts_mbuf_register)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_ts_mbuf_register);
 int
 idpf_qc_ts_mbuf_register(struct idpf_rx_queue *rxq)
 {
@@ -355,7 +355,7 @@ idpf_qc_ts_mbuf_register(struct idpf_rx_queue *rxq)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_single_rxq_mbufs_alloc)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_single_rxq_mbufs_alloc);
 int
 idpf_qc_single_rxq_mbufs_alloc(struct idpf_rx_queue *rxq)
 {
@@ -391,7 +391,7 @@ idpf_qc_single_rxq_mbufs_alloc(struct idpf_rx_queue *rxq)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_rxq_mbufs_alloc)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_split_rxq_mbufs_alloc);
 int
 idpf_qc_split_rxq_mbufs_alloc(struct idpf_rx_queue *rxq)
 {
@@ -615,7 +615,7 @@ idpf_split_rx_bufq_refill(struct idpf_rx_queue *rx_bufq)
 	rx_bufq->rx_tail = next_avail;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_recv_pkts)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_recv_pkts);
 uint16_t
 idpf_dp_splitq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			 uint16_t nb_pkts)
@@ -848,7 +848,7 @@ idpf_set_splitq_tso_ctx(struct rte_mbuf *mbuf,
 				 IDPF_TXD_FLEX_CTX_MSS_RT_M);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_xmit_pkts)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_xmit_pkts);
 uint16_t
 idpf_dp_splitq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			 uint16_t nb_pkts)
@@ -1040,7 +1040,7 @@ idpf_singleq_rx_rss_offload(struct rte_mbuf *mb,
 
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_recv_pkts)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_recv_pkts);
 uint16_t
 idpf_dp_singleq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			  uint16_t nb_pkts)
@@ -1159,7 +1159,7 @@ idpf_dp_singleq_recv_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 	return nb_rx;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_recv_scatter_pkts)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_recv_scatter_pkts);
 uint16_t
 idpf_dp_singleq_recv_scatter_pkts(void *rx_queue, struct rte_mbuf **rx_pkts,
 			       uint16_t nb_pkts)
@@ -1337,7 +1337,7 @@ idpf_xmit_cleanup(struct ci_tx_queue *txq)
 }
 
 /* TX function */
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_xmit_pkts)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_xmit_pkts);
 uint16_t
 idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 			  uint16_t nb_pkts)
@@ -1505,7 +1505,7 @@ idpf_dp_singleq_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts,
 }
 
 /* TX prep functions */
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_prep_pkts)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_prep_pkts);
 uint16_t
 idpf_dp_prep_pkts(__rte_unused void *tx_queue, struct rte_mbuf **tx_pkts,
 		  uint16_t nb_pkts)
@@ -1607,7 +1607,7 @@ idpf_rxq_vec_setup_default(struct idpf_rx_queue *rxq)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_singleq_rx_vec_setup)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_singleq_rx_vec_setup);
 int __rte_cold
 idpf_qc_singleq_rx_vec_setup(struct idpf_rx_queue *rxq)
 {
@@ -1615,7 +1615,7 @@ idpf_qc_singleq_rx_vec_setup(struct idpf_rx_queue *rxq)
 	return idpf_rxq_vec_setup_default(rxq);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_splitq_rx_vec_setup)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_splitq_rx_vec_setup);
 int __rte_cold
 idpf_qc_splitq_rx_vec_setup(struct idpf_rx_queue *rxq)
 {
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
index 1babc5114b..aedee7b046 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx2.c
@@ -475,7 +475,7 @@ _idpf_singleq_recv_raw_pkts_vec_avx2(struct idpf_rx_queue *rxq, struct rte_mbuf
  * Notice:
  * - nb_pkts < IDPF_DESCS_PER_LOOP, just return no packet
  */
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_recv_pkts_avx2)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_recv_pkts_avx2);
 uint16_t
 idpf_dp_singleq_recv_pkts_avx2(void *rx_queue, struct rte_mbuf **rx_pkts, uint16_t nb_pkts)
 {
@@ -618,7 +618,7 @@ idpf_singleq_xmit_fixed_burst_vec_avx2(void *tx_queue, struct rte_mbuf **tx_pkts
 	return nb_pkts;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_xmit_pkts_avx2)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_xmit_pkts_avx2);
 uint16_t
 idpf_dp_singleq_xmit_pkts_avx2(void *tx_queue, struct rte_mbuf **tx_pkts,
 			       uint16_t nb_pkts)
diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index 06e73c8725..c9e7b39de2 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
@@ -532,7 +532,7 @@ _idpf_singleq_recv_raw_pkts_avx512(struct idpf_rx_queue *rxq,
  * Notice:
  * - nb_pkts < IDPF_DESCS_PER_LOOP, just return no packet
  */
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_recv_pkts_avx512)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_recv_pkts_avx512);
 uint16_t
 idpf_dp_singleq_recv_pkts_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
 				 uint16_t nb_pkts)
@@ -990,7 +990,7 @@ _idpf_splitq_recv_raw_pkts_avx512(struct idpf_rx_queue *rxq,
 }
 
 /* only bufq2 can receive pkts */
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_recv_pkts_avx512)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_recv_pkts_avx512);
 uint16_t
 idpf_dp_splitq_recv_pkts_avx512(void *rx_queue, struct rte_mbuf **rx_pkts,
 			     uint16_t nb_pkts)
@@ -1159,7 +1159,7 @@ idpf_singleq_xmit_pkts_vec_avx512_cmn(void *tx_queue, struct rte_mbuf **tx_pkts,
 	return nb_tx;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_xmit_pkts_avx512)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_singleq_xmit_pkts_avx512);
 uint16_t
 idpf_dp_singleq_xmit_pkts_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 				 uint16_t nb_pkts)
@@ -1361,7 +1361,7 @@ idpf_splitq_xmit_pkts_vec_avx512_cmn(void *tx_queue, struct rte_mbuf **tx_pkts,
 	return nb_tx;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_xmit_pkts_avx512)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_dp_splitq_xmit_pkts_avx512);
 uint16_t
 idpf_dp_splitq_xmit_pkts_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 				uint16_t nb_pkts)
@@ -1369,7 +1369,7 @@ idpf_dp_splitq_xmit_pkts_avx512(void *tx_queue, struct rte_mbuf **tx_pkts,
 	return idpf_splitq_xmit_pkts_vec_avx512_cmn(tx_queue, tx_pkts, nb_pkts);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_tx_vec_avx512_setup)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_qc_tx_vec_avx512_setup);
 int __rte_cold
 idpf_qc_tx_vec_avx512_setup(struct ci_tx_queue *txq)
 {
diff --git a/drivers/net/intel/idpf/idpf_common_virtchnl.c b/drivers/net/intel/idpf/idpf_common_virtchnl.c
index bab854e191..871893a9ed 100644
--- a/drivers/net/intel/idpf/idpf_common_virtchnl.c
+++ b/drivers/net/intel/idpf/idpf_common_virtchnl.c
@@ -160,7 +160,7 @@ idpf_read_msg_from_cp(struct idpf_adapter *adapter, uint16_t buf_len,
 #define MAX_TRY_TIMES 200
 #define ASQ_DELAY_MS  10
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_one_msg_read)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_one_msg_read);
 int
 idpf_vc_one_msg_read(struct idpf_adapter *adapter, uint32_t ops, uint16_t buf_len,
 		     uint8_t *buf)
@@ -185,7 +185,7 @@ idpf_vc_one_msg_read(struct idpf_adapter *adapter, uint32_t ops, uint16_t buf_le
 	return err;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_cmd_execute)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_cmd_execute);
 int
 idpf_vc_cmd_execute(struct idpf_adapter *adapter, struct idpf_cmd_info *args)
 {
@@ -235,7 +235,7 @@ idpf_vc_cmd_execute(struct idpf_adapter *adapter, struct idpf_cmd_info *args)
 	return err;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_api_version_check)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_api_version_check);
 int
 idpf_vc_api_version_check(struct idpf_adapter *adapter)
 {
@@ -276,7 +276,7 @@ idpf_vc_api_version_check(struct idpf_adapter *adapter)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_caps_get)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_caps_get);
 int
 idpf_vc_caps_get(struct idpf_adapter *adapter)
 {
@@ -301,7 +301,7 @@ idpf_vc_caps_get(struct idpf_adapter *adapter)
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_vport_create)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_vport_create);
 int
 idpf_vc_vport_create(struct idpf_vport *vport,
 		     struct virtchnl2_create_vport *create_vport_info)
@@ -338,7 +338,7 @@ idpf_vc_vport_create(struct idpf_vport *vport,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_vport_destroy)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_vport_destroy);
 int
 idpf_vc_vport_destroy(struct idpf_vport *vport)
 {
@@ -363,7 +363,7 @@ idpf_vc_vport_destroy(struct idpf_vport *vport)
 	return err;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_queue_grps_add)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_queue_grps_add);
 int
 idpf_vc_queue_grps_add(struct idpf_vport *vport,
 		       struct virtchnl2_add_queue_groups *p2p_queue_grps_info,
@@ -396,7 +396,7 @@ idpf_vc_queue_grps_add(struct idpf_vport *vport,
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_queue_grps_del)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_queue_grps_del);
 int idpf_vc_queue_grps_del(struct idpf_vport *vport,
 			  uint16_t num_q_grps,
 			  struct virtchnl2_queue_group_id *qg_ids)
@@ -431,7 +431,7 @@ int idpf_vc_queue_grps_del(struct idpf_vport *vport,
 	return err;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_rss_key_set)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_rss_key_set);
 int
 idpf_vc_rss_key_set(struct idpf_vport *vport)
 {
@@ -466,7 +466,7 @@ idpf_vc_rss_key_set(struct idpf_vport *vport)
 	return err;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_rss_key_get)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_rss_key_get);
 int idpf_vc_rss_key_get(struct idpf_vport *vport)
 {
 	struct idpf_adapter *adapter = vport->adapter;
@@ -509,7 +509,7 @@ int idpf_vc_rss_key_get(struct idpf_vport *vport)
 	return err;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_rss_lut_set)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_rss_lut_set);
 int
 idpf_vc_rss_lut_set(struct idpf_vport *vport)
 {
@@ -544,7 +544,7 @@ idpf_vc_rss_lut_set(struct idpf_vport *vport)
 	return err;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_rss_lut_get)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_rss_lut_get);
 int
 idpf_vc_rss_lut_get(struct idpf_vport *vport)
 {
@@ -587,7 +587,7 @@ idpf_vc_rss_lut_get(struct idpf_vport *vport)
 	return err;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_rss_hash_get)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_rss_hash_get);
 int
 idpf_vc_rss_hash_get(struct idpf_vport *vport)
 {
@@ -620,7 +620,7 @@ idpf_vc_rss_hash_get(struct idpf_vport *vport)
 	return err;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_rss_hash_set)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_rss_hash_set);
 int
 idpf_vc_rss_hash_set(struct idpf_vport *vport)
 {
@@ -647,7 +647,7 @@ idpf_vc_rss_hash_set(struct idpf_vport *vport)
 	return err;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_irq_map_unmap_config)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_irq_map_unmap_config);
 int
 idpf_vc_irq_map_unmap_config(struct idpf_vport *vport, uint16_t nb_rxq, bool map)
 {
@@ -689,7 +689,7 @@ idpf_vc_irq_map_unmap_config(struct idpf_vport *vport, uint16_t nb_rxq, bool map
 	return err;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_vectors_alloc)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_vectors_alloc);
 int
 idpf_vc_vectors_alloc(struct idpf_vport *vport, uint16_t num_vectors)
 {
@@ -720,7 +720,7 @@ idpf_vc_vectors_alloc(struct idpf_vport *vport, uint16_t num_vectors)
 	return err;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_vectors_dealloc)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_vectors_dealloc);
 int
 idpf_vc_vectors_dealloc(struct idpf_vport *vport)
 {
@@ -748,7 +748,7 @@ idpf_vc_vectors_dealloc(struct idpf_vport *vport)
 	return err;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_ena_dis_one_queue)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_ena_dis_one_queue);
 int
 idpf_vc_ena_dis_one_queue(struct idpf_vport *vport, uint16_t qid,
 			  uint32_t type, bool on)
@@ -787,7 +787,7 @@ idpf_vc_ena_dis_one_queue(struct idpf_vport *vport, uint16_t qid,
 	return err;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_queue_switch)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_queue_switch);
 int
 idpf_vc_queue_switch(struct idpf_vport *vport, uint16_t qid,
 		     bool rx, bool on, uint32_t type)
@@ -828,7 +828,7 @@ idpf_vc_queue_switch(struct idpf_vport *vport, uint16_t qid,
 }
 
 #define IDPF_RXTX_QUEUE_CHUNKS_NUM	2
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_queues_ena_dis)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_queues_ena_dis);
 int
 idpf_vc_queues_ena_dis(struct idpf_vport *vport, bool enable)
 {
@@ -897,7 +897,7 @@ idpf_vc_queues_ena_dis(struct idpf_vport *vport, bool enable)
 	return err;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_vport_ena_dis)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_vport_ena_dis);
 int
 idpf_vc_vport_ena_dis(struct idpf_vport *vport, bool enable)
 {
@@ -923,7 +923,7 @@ idpf_vc_vport_ena_dis(struct idpf_vport *vport, bool enable)
 	return err;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_ptype_info_query)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_ptype_info_query);
 int
 idpf_vc_ptype_info_query(struct idpf_adapter *adapter,
 			 struct virtchnl2_get_ptype_info *req_ptype_info,
@@ -946,7 +946,7 @@ idpf_vc_ptype_info_query(struct idpf_adapter *adapter,
 	return err;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_stats_query)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_stats_query);
 int
 idpf_vc_stats_query(struct idpf_vport *vport,
 		struct virtchnl2_vport_stats **pstats)
@@ -974,7 +974,7 @@ idpf_vc_stats_query(struct idpf_vport *vport,
 }
 
 #define IDPF_RX_BUF_STRIDE		64
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_rxq_config)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_rxq_config);
 int
 idpf_vc_rxq_config(struct idpf_vport *vport, struct idpf_rx_queue *rxq)
 {
@@ -1064,7 +1064,7 @@ idpf_vc_rxq_config(struct idpf_vport *vport, struct idpf_rx_queue *rxq)
 	return err;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_rxq_config_by_info)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_rxq_config_by_info);
 int idpf_vc_rxq_config_by_info(struct idpf_vport *vport, struct virtchnl2_rxq_info *rxq_info,
 			       uint16_t num_qs)
 {
@@ -1100,7 +1100,7 @@ int idpf_vc_rxq_config_by_info(struct idpf_vport *vport, struct virtchnl2_rxq_in
 	return err;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_txq_config)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_txq_config);
 int
 idpf_vc_txq_config(struct idpf_vport *vport, struct ci_tx_queue *txq)
 {
@@ -1172,7 +1172,7 @@ idpf_vc_txq_config(struct idpf_vport *vport, struct ci_tx_queue *txq)
 	return err;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_txq_config_by_info)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_txq_config_by_info);
 int
 idpf_vc_txq_config_by_info(struct idpf_vport *vport, struct virtchnl2_txq_info *txq_info,
 		       uint16_t num_qs)
@@ -1208,7 +1208,7 @@ idpf_vc_txq_config_by_info(struct idpf_vport *vport, struct virtchnl2_txq_info *
 	return err;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_ctlq_recv)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_ctlq_recv);
 int
 idpf_vc_ctlq_recv(struct idpf_ctlq_info *cq, u16 *num_q_msg,
 		  struct idpf_ctlq_msg *q_msg)
@@ -1216,7 +1216,7 @@ idpf_vc_ctlq_recv(struct idpf_ctlq_info *cq, u16 *num_q_msg,
 	return idpf_ctlq_recv(cq, num_q_msg, q_msg);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_ctlq_post_rx_buffs)
+RTE_EXPORT_INTERNAL_SYMBOL(idpf_vc_ctlq_post_rx_buffs);
 int
 idpf_vc_ctlq_post_rx_buffs(struct idpf_hw *hw, struct idpf_ctlq_info *cq,
 			   u16 *buff_count, struct idpf_dma_mem **buffs)
diff --git a/drivers/net/intel/ipn3ke/ipn3ke_ethdev.c b/drivers/net/intel/ipn3ke/ipn3ke_ethdev.c
index 2ee87c94c2..a0b4a2b6a9 100644
--- a/drivers/net/intel/ipn3ke/ipn3ke_ethdev.c
+++ b/drivers/net/intel/ipn3ke/ipn3ke_ethdev.c
@@ -35,7 +35,7 @@ static const struct rte_afu_uuid afu_uuid_ipn3ke_map[] = {
 	{ 0, 0 /* sentinel */ },
 };
 
-RTE_EXPORT_INTERNAL_SYMBOL(ipn3ke_bridge_func)
+RTE_EXPORT_INTERNAL_SYMBOL(ipn3ke_bridge_func);
 struct ipn3ke_pub_func ipn3ke_bridge_func;
 
 static int
diff --git a/drivers/net/intel/ixgbe/rte_pmd_ixgbe.c b/drivers/net/intel/ixgbe/rte_pmd_ixgbe.c
index c2300a8955..c4ffb3d100 100644
--- a/drivers/net/intel/ixgbe/rte_pmd_ixgbe.c
+++ b/drivers/net/intel/ixgbe/rte_pmd_ixgbe.c
@@ -10,7 +10,7 @@
 #include <eal_export.h>
 #include "rte_pmd_ixgbe.h"
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_mac_addr)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_mac_addr);
 int
 rte_pmd_ixgbe_set_vf_mac_addr(uint16_t port, uint16_t vf,
 			      struct rte_ether_addr *mac_addr)
@@ -47,7 +47,7 @@ rte_pmd_ixgbe_set_vf_mac_addr(uint16_t port, uint16_t vf,
 	return -EINVAL;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_ping_vf)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_ping_vf);
 int
 rte_pmd_ixgbe_ping_vf(uint16_t port, uint16_t vf)
 {
@@ -80,7 +80,7 @@ rte_pmd_ixgbe_ping_vf(uint16_t port, uint16_t vf)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_vlan_anti_spoof)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_vlan_anti_spoof);
 int
 rte_pmd_ixgbe_set_vf_vlan_anti_spoof(uint16_t port, uint16_t vf, uint8_t on)
 {
@@ -111,7 +111,7 @@ rte_pmd_ixgbe_set_vf_vlan_anti_spoof(uint16_t port, uint16_t vf, uint8_t on)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_mac_anti_spoof)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_mac_anti_spoof);
 int
 rte_pmd_ixgbe_set_vf_mac_anti_spoof(uint16_t port, uint16_t vf, uint8_t on)
 {
@@ -141,7 +141,7 @@ rte_pmd_ixgbe_set_vf_mac_anti_spoof(uint16_t port, uint16_t vf, uint8_t on)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_vlan_insert)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_vlan_insert);
 int
 rte_pmd_ixgbe_set_vf_vlan_insert(uint16_t port, uint16_t vf, uint16_t vlan_id)
 {
@@ -178,7 +178,7 @@ rte_pmd_ixgbe_set_vf_vlan_insert(uint16_t port, uint16_t vf, uint16_t vlan_id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_tx_loopback)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_tx_loopback);
 int
 rte_pmd_ixgbe_set_tx_loopback(uint16_t port, uint8_t on)
 {
@@ -209,7 +209,7 @@ rte_pmd_ixgbe_set_tx_loopback(uint16_t port, uint8_t on)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_all_queues_drop_en)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_all_queues_drop_en);
 int
 rte_pmd_ixgbe_set_all_queues_drop_en(uint16_t port, uint8_t on)
 {
@@ -240,7 +240,7 @@ rte_pmd_ixgbe_set_all_queues_drop_en(uint16_t port, uint8_t on)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_split_drop_en)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_split_drop_en);
 int
 rte_pmd_ixgbe_set_vf_split_drop_en(uint16_t port, uint16_t vf, uint8_t on)
 {
@@ -276,7 +276,7 @@ rte_pmd_ixgbe_set_vf_split_drop_en(uint16_t port, uint16_t vf, uint8_t on)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_vlan_stripq)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_vlan_stripq);
 int
 rte_pmd_ixgbe_set_vf_vlan_stripq(uint16_t port, uint16_t vf, uint8_t on)
 {
@@ -324,7 +324,7 @@ rte_pmd_ixgbe_set_vf_vlan_stripq(uint16_t port, uint16_t vf, uint8_t on)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_rxmode)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_rxmode);
 int
 rte_pmd_ixgbe_set_vf_rxmode(uint16_t port, uint16_t vf,
 			    uint16_t rx_mask, uint8_t on)
@@ -372,7 +372,7 @@ rte_pmd_ixgbe_set_vf_rxmode(uint16_t port, uint16_t vf,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_rx)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_rx);
 int
 rte_pmd_ixgbe_set_vf_rx(uint16_t port, uint16_t vf, uint8_t on)
 {
@@ -423,7 +423,7 @@ rte_pmd_ixgbe_set_vf_rx(uint16_t port, uint16_t vf, uint8_t on)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_tx)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_tx);
 int
 rte_pmd_ixgbe_set_vf_tx(uint16_t port, uint16_t vf, uint8_t on)
 {
@@ -474,7 +474,7 @@ rte_pmd_ixgbe_set_vf_tx(uint16_t port, uint16_t vf, uint8_t on)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_vlan_filter)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_vlan_filter);
 int
 rte_pmd_ixgbe_set_vf_vlan_filter(uint16_t port, uint16_t vlan,
 				 uint64_t vf_mask, uint8_t vlan_on)
@@ -510,7 +510,7 @@ rte_pmd_ixgbe_set_vf_vlan_filter(uint16_t port, uint16_t vlan,
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_rate_limit)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_vf_rate_limit);
 int
 rte_pmd_ixgbe_set_vf_rate_limit(uint16_t port, uint16_t vf,
 				uint32_t tx_rate, uint64_t q_msk)
@@ -527,7 +527,7 @@ rte_pmd_ixgbe_set_vf_rate_limit(uint16_t port, uint16_t vf,
 	return ixgbe_set_vf_rate_limit(dev, vf, tx_rate, q_msk);
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_macsec_enable)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_macsec_enable);
 int
 rte_pmd_ixgbe_macsec_enable(uint16_t port, uint8_t en, uint8_t rp)
 {
@@ -552,7 +552,7 @@ rte_pmd_ixgbe_macsec_enable(uint16_t port, uint8_t en, uint8_t rp)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_macsec_disable)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_macsec_disable);
 int
 rte_pmd_ixgbe_macsec_disable(uint16_t port)
 {
@@ -572,7 +572,7 @@ rte_pmd_ixgbe_macsec_disable(uint16_t port)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_macsec_config_txsc)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_macsec_config_txsc);
 int
 rte_pmd_ixgbe_macsec_config_txsc(uint16_t port, uint8_t *mac)
 {
@@ -598,7 +598,7 @@ rte_pmd_ixgbe_macsec_config_txsc(uint16_t port, uint8_t *mac)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_macsec_config_rxsc)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_macsec_config_rxsc);
 int
 rte_pmd_ixgbe_macsec_config_rxsc(uint16_t port, uint8_t *mac, uint16_t pi)
 {
@@ -625,7 +625,7 @@ rte_pmd_ixgbe_macsec_config_rxsc(uint16_t port, uint8_t *mac, uint16_t pi)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_macsec_select_txsa)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_macsec_select_txsa);
 int
 rte_pmd_ixgbe_macsec_select_txsa(uint16_t port, uint8_t idx, uint8_t an,
 				 uint32_t pn, uint8_t *key)
@@ -682,7 +682,7 @@ rte_pmd_ixgbe_macsec_select_txsa(uint16_t port, uint8_t idx, uint8_t an,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_macsec_select_rxsa)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_macsec_select_rxsa);
 int
 rte_pmd_ixgbe_macsec_select_rxsa(uint16_t port, uint8_t idx, uint8_t an,
 				 uint32_t pn, uint8_t *key)
@@ -726,7 +726,7 @@ rte_pmd_ixgbe_macsec_select_rxsa(uint16_t port, uint8_t idx, uint8_t an,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_tc_bw_alloc)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_set_tc_bw_alloc);
 int
 rte_pmd_ixgbe_set_tc_bw_alloc(uint16_t port,
 			      uint8_t tc_num,
@@ -800,7 +800,7 @@ rte_pmd_ixgbe_set_tc_bw_alloc(uint16_t port,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_upd_fctrl_sbp)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_upd_fctrl_sbp);
 int
 rte_pmd_ixgbe_upd_fctrl_sbp(uint16_t port, int enable)
 {
@@ -830,7 +830,7 @@ rte_pmd_ixgbe_upd_fctrl_sbp(uint16_t port, int enable)
 }
 
 #ifdef RTE_LIBRTE_IXGBE_BYPASS
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_bypass_init)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_bypass_init);
 int
 rte_pmd_ixgbe_bypass_init(uint16_t port_id)
 {
@@ -846,7 +846,7 @@ rte_pmd_ixgbe_bypass_init(uint16_t port_id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_bypass_state_show)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_bypass_state_show);
 int
 rte_pmd_ixgbe_bypass_state_show(uint16_t port_id, uint32_t *state)
 {
@@ -861,7 +861,7 @@ rte_pmd_ixgbe_bypass_state_show(uint16_t port_id, uint32_t *state)
 	return ixgbe_bypass_state_show(dev, state);
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_bypass_state_set)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_bypass_state_set);
 int
 rte_pmd_ixgbe_bypass_state_set(uint16_t port_id, uint32_t *new_state)
 {
@@ -876,7 +876,7 @@ rte_pmd_ixgbe_bypass_state_set(uint16_t port_id, uint32_t *new_state)
 	return ixgbe_bypass_state_store(dev, new_state);
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_bypass_event_show)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_bypass_event_show);
 int
 rte_pmd_ixgbe_bypass_event_show(uint16_t port_id,
 				uint32_t event,
@@ -893,7 +893,7 @@ rte_pmd_ixgbe_bypass_event_show(uint16_t port_id,
 	return ixgbe_bypass_event_show(dev, event, state);
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_bypass_event_store)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_bypass_event_store);
 int
 rte_pmd_ixgbe_bypass_event_store(uint16_t port_id,
 				 uint32_t event,
@@ -910,7 +910,7 @@ rte_pmd_ixgbe_bypass_event_store(uint16_t port_id,
 	return ixgbe_bypass_event_store(dev, event, state);
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_bypass_wd_timeout_store)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_bypass_wd_timeout_store);
 int
 rte_pmd_ixgbe_bypass_wd_timeout_store(uint16_t port_id, uint32_t timeout)
 {
@@ -925,7 +925,7 @@ rte_pmd_ixgbe_bypass_wd_timeout_store(uint16_t port_id, uint32_t timeout)
 	return ixgbe_bypass_wd_timeout_store(dev, timeout);
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_bypass_ver_show)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_bypass_ver_show);
 int
 rte_pmd_ixgbe_bypass_ver_show(uint16_t port_id, uint32_t *ver)
 {
@@ -940,7 +940,7 @@ rte_pmd_ixgbe_bypass_ver_show(uint16_t port_id, uint32_t *ver)
 	return ixgbe_bypass_ver_show(dev, ver);
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_bypass_wd_timeout_show)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_bypass_wd_timeout_show);
 int
 rte_pmd_ixgbe_bypass_wd_timeout_show(uint16_t port_id, uint32_t *wd_timeout)
 {
@@ -955,7 +955,7 @@ rte_pmd_ixgbe_bypass_wd_timeout_show(uint16_t port_id, uint32_t *wd_timeout)
 	return ixgbe_bypass_wd_timeout_show(dev, wd_timeout);
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_bypass_wd_reset)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_bypass_wd_reset);
 int
 rte_pmd_ixgbe_bypass_wd_reset(uint16_t port_id)
 {
@@ -1024,7 +1024,7 @@ STATIC void rte_pmd_ixgbe_release_swfw(struct ixgbe_hw *hw, u32 mask)
 	ixgbe_release_swfw_semaphore(hw, mask);
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_mdio_lock)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_mdio_lock);
 int
 rte_pmd_ixgbe_mdio_lock(uint16_t port)
 {
@@ -1052,7 +1052,7 @@ rte_pmd_ixgbe_mdio_lock(uint16_t port)
 	return IXGBE_SUCCESS;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_mdio_unlock)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_mdio_unlock);
 int
 rte_pmd_ixgbe_mdio_unlock(uint16_t port)
 {
@@ -1080,7 +1080,7 @@ rte_pmd_ixgbe_mdio_unlock(uint16_t port)
 	return IXGBE_SUCCESS;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_mdio_unlocked_read)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_mdio_unlocked_read);
 int
 rte_pmd_ixgbe_mdio_unlocked_read(uint16_t port, uint32_t reg_addr,
 				 uint32_t dev_type, uint16_t *phy_data)
@@ -1128,7 +1128,7 @@ rte_pmd_ixgbe_mdio_unlocked_read(uint16_t port, uint32_t reg_addr,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_mdio_unlocked_write)
+RTE_EXPORT_SYMBOL(rte_pmd_ixgbe_mdio_unlocked_write);
 int
 rte_pmd_ixgbe_mdio_unlocked_write(uint16_t port, uint32_t reg_addr,
 				  uint32_t dev_type, uint16_t phy_data)
@@ -1176,7 +1176,7 @@ rte_pmd_ixgbe_mdio_unlocked_write(uint16_t port, uint32_t reg_addr,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ixgbe_get_fdir_info, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ixgbe_get_fdir_info, 20.08);
 int
 rte_pmd_ixgbe_get_fdir_info(uint16_t port, struct rte_eth_fdir_info *fdir_info)
 {
@@ -1193,7 +1193,7 @@ rte_pmd_ixgbe_get_fdir_info(uint16_t port, struct rte_eth_fdir_info *fdir_info)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ixgbe_get_fdir_stats, 20.08)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_ixgbe_get_fdir_stats, 20.08);
 int
 rte_pmd_ixgbe_get_fdir_stats(uint16_t port,
 			     struct rte_eth_fdir_stats *fdir_stats)
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 1321be779b..d79bc3d745 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -3379,7 +3379,7 @@ mlx5_set_metadata_mask(struct rte_eth_dev *dev)
 	DRV_LOG(DEBUG, "metadata reg_c0 mask %08X", sh->dv_regc0_mask);
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_get_dyn_flag_names, 20.02)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_get_dyn_flag_names, 20.02);
 int
 rte_pmd_mlx5_get_dyn_flag_names(char *names[], unsigned int n)
 {
diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index 8db372123c..ce4d2246a6 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -7880,7 +7880,7 @@ mlx5_flow_cache_flow_toggle(struct rte_eth_dev *dev, bool orig_prio)
  * @return
  *   Negative value on error, positive on success.
  */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_flow_engine_set_mode, 23.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_flow_engine_set_mode, 23.03);
 int
 rte_pmd_mlx5_flow_engine_set_mode(enum rte_pmd_mlx5_flow_engine_mode mode, uint32_t flags)
 {
@@ -10986,7 +10986,7 @@ mlx5_action_handle_detach(struct rte_eth_dev *dev)
 	(MLX5DV_DR_DOMAIN_SYNC_FLAGS_SW | MLX5DV_DR_DOMAIN_SYNC_FLAGS_HW)
 #endif
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_sync_flow, 20.11)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_sync_flow, 20.11);
 int rte_pmd_mlx5_sync_flow(uint16_t port_id, uint32_t domains)
 {
 	struct rte_eth_dev *dev = &rte_eth_devices[port_id];
@@ -12263,7 +12263,7 @@ mlx5_flow_discover_ipv6_tc_support(struct rte_eth_dev *dev)
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_create_geneve_tlv_parser, 24.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_create_geneve_tlv_parser, 24.03);
 void *
 rte_pmd_mlx5_create_geneve_tlv_parser(uint16_t port_id,
 				      const struct rte_pmd_mlx5_geneve_tlv tlv_list[],
@@ -12281,7 +12281,7 @@ rte_pmd_mlx5_create_geneve_tlv_parser(uint16_t port_id,
 #endif
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_destroy_geneve_tlv_parser, 24.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_destroy_geneve_tlv_parser, 24.03);
 int
 rte_pmd_mlx5_destroy_geneve_tlv_parser(void *handle)
 {
diff --git a/drivers/net/mlx5/mlx5_rx.c b/drivers/net/mlx5/mlx5_rx.c
index 5e8c312d00..cc26c785c0 100644
--- a/drivers/net/mlx5/mlx5_rx.c
+++ b/drivers/net/mlx5/mlx5_rx.c
@@ -1832,7 +1832,7 @@ mlxreg_host_shaper_config(struct rte_eth_dev *dev,
 #endif
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_host_shaper_config, 22.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_host_shaper_config, 22.07);
 int rte_pmd_mlx5_host_shaper_config(int port_id, uint8_t rate,
 				    uint32_t flags)
 {
@@ -1874,7 +1874,7 @@ int rte_pmd_mlx5_host_shaper_config(int port_id, uint8_t rate,
  * @return
  *   0 for Success, non-zero value depending on failure type
  */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_rxq_dump_contexts, 24.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_rxq_dump_contexts, 24.07);
 int rte_pmd_mlx5_rxq_dump_contexts(uint16_t port_id, uint16_t queue_id, const char *filename)
 {
 	struct rte_eth_dev *dev;
diff --git a/drivers/net/mlx5/mlx5_rxq.c b/drivers/net/mlx5/mlx5_rxq.c
index 77c5848c37..9bfef96b5f 100644
--- a/drivers/net/mlx5/mlx5_rxq.c
+++ b/drivers/net/mlx5/mlx5_rxq.c
@@ -3311,7 +3311,7 @@ mlx5_external_rx_queue_get_validate(uint16_t port_id, uint16_t dpdk_idx)
 	return &priv->ext_rxqs[dpdk_idx - RTE_PMD_MLX5_EXTERNAL_RX_QUEUE_ID_MIN];
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_external_rx_queue_id_map, 22.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_external_rx_queue_id_map, 22.03);
 int
 rte_pmd_mlx5_external_rx_queue_id_map(uint16_t port_id, uint16_t dpdk_idx,
 				      uint32_t hw_idx)
@@ -3345,7 +3345,7 @@ rte_pmd_mlx5_external_rx_queue_id_map(uint16_t port_id, uint16_t dpdk_idx,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_external_rx_queue_id_unmap, 22.03)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_external_rx_queue_id_unmap, 22.03);
 int
 rte_pmd_mlx5_external_rx_queue_id_unmap(uint16_t port_id, uint16_t dpdk_idx)
 {
diff --git a/drivers/net/mlx5/mlx5_tx.c b/drivers/net/mlx5/mlx5_tx.c
index fe9da7f8c1..41d427d8c4 100644
--- a/drivers/net/mlx5/mlx5_tx.c
+++ b/drivers/net/mlx5/mlx5_tx.c
@@ -777,7 +777,7 @@ mlx5_tx_burst_mode_get(struct rte_eth_dev *dev,
  *   0 for success, non-zero value depending on failure.
  *
  */
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_txq_dump_contexts, 24.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_txq_dump_contexts, 24.07);
 int rte_pmd_mlx5_txq_dump_contexts(uint16_t port_id, uint16_t queue_id, const char *filename)
 {
 	struct rte_eth_dev *dev;
diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index b090d8274d..565dcf804d 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -1415,7 +1415,7 @@ mlx5_txq_get_sqn(struct mlx5_txq_ctrl *txq)
 	return txq->is_hairpin ? txq->obj->sq->id : txq->obj->sq_obj.sq->id;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_external_sq_enable, 22.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_external_sq_enable, 22.07);
 int
 rte_pmd_mlx5_external_sq_enable(uint16_t port_id, uint32_t sq_num)
 {
@@ -1597,7 +1597,7 @@ mlx5_external_tx_queue_get_validate(uint16_t port_id, uint16_t dpdk_idx)
 	return &priv->ext_txqs[dpdk_idx - MLX5_EXTERNAL_TX_QUEUE_ID_MIN];
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_external_tx_queue_id_map, 24.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_external_tx_queue_id_map, 24.07);
 int
 rte_pmd_mlx5_external_tx_queue_id_map(uint16_t port_id, uint16_t dpdk_idx,
 				      uint32_t hw_idx)
@@ -1631,7 +1631,7 @@ rte_pmd_mlx5_external_tx_queue_id_map(uint16_t port_id, uint16_t dpdk_idx,
 	return 0;
 }
 
-RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_external_tx_queue_id_unmap, 24.07)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_mlx5_external_tx_queue_id_unmap, 24.07);
 int
 rte_pmd_mlx5_external_tx_queue_id_unmap(uint16_t port_id, uint16_t dpdk_idx)
 {
diff --git a/drivers/net/octeontx/octeontx_ethdev.c b/drivers/net/octeontx/octeontx_ethdev.c
index 9451431144..f11ad9251a 100644
--- a/drivers/net/octeontx/octeontx_ethdev.c
+++ b/drivers/net/octeontx/octeontx_ethdev.c
@@ -45,7 +45,7 @@ struct octeontx_vdev_init_params {
 	uint8_t	nr_port;
 };
 
-RTE_EXPORT_SYMBOL(rte_octeontx_pchan_map)
+RTE_EXPORT_SYMBOL(rte_octeontx_pchan_map);
 uint16_t
 rte_octeontx_pchan_map[OCTEONTX_MAX_BGX_PORTS][OCTEONTX_MAX_LMAC_PER_BGX];
 
diff --git a/drivers/net/ring/rte_eth_ring.c b/drivers/net/ring/rte_eth_ring.c
index b1085bf390..962106fa2c 100644
--- a/drivers/net/ring/rte_eth_ring.c
+++ b/drivers/net/ring/rte_eth_ring.c
@@ -457,7 +457,7 @@ do_eth_dev_ring_create(const char *name,
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_from_rings)
+RTE_EXPORT_SYMBOL(rte_eth_from_rings);
 int
 rte_eth_from_rings(const char *name, struct rte_ring *const rx_queues[],
 		const unsigned int nb_rx_queues,
@@ -516,7 +516,7 @@ rte_eth_from_rings(const char *name, struct rte_ring *const rx_queues[],
 	return port_id;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_from_ring)
+RTE_EXPORT_SYMBOL(rte_eth_from_ring);
 int
 rte_eth_from_ring(struct rte_ring *r)
 {
diff --git a/drivers/net/softnic/rte_eth_softnic.c b/drivers/net/softnic/rte_eth_softnic.c
index 91a1c3a98e..40d6e768bc 100644
--- a/drivers/net/softnic/rte_eth_softnic.c
+++ b/drivers/net/softnic/rte_eth_softnic.c
@@ -517,7 +517,7 @@ RTE_PMD_REGISTER_PARAM_STRING(net_softnic,
 	PMD_PARAM_CPU_ID "=<uint32> "
 );
 
-RTE_EXPORT_SYMBOL(rte_pmd_softnic_manage)
+RTE_EXPORT_SYMBOL(rte_pmd_softnic_manage);
 int
 rte_pmd_softnic_manage(uint16_t port_id)
 {
diff --git a/drivers/net/softnic/rte_eth_softnic_thread.c b/drivers/net/softnic/rte_eth_softnic_thread.c
index f72c836199..d18d7cf9e0 100644
--- a/drivers/net/softnic/rte_eth_softnic_thread.c
+++ b/drivers/net/softnic/rte_eth_softnic_thread.c
@@ -555,7 +555,7 @@ rte_pmd_softnic_run_internal(void *arg)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_softnic_run)
+RTE_EXPORT_SYMBOL(rte_pmd_softnic_run);
 int
 rte_pmd_softnic_run(uint16_t port_id)
 {
diff --git a/drivers/net/vhost/rte_eth_vhost.c b/drivers/net/vhost/rte_eth_vhost.c
index 44bf2e3241..cd6698f353 100644
--- a/drivers/net/vhost/rte_eth_vhost.c
+++ b/drivers/net/vhost/rte_eth_vhost.c
@@ -1046,7 +1046,7 @@ vhost_driver_setup(struct rte_eth_dev *eth_dev)
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_vhost_get_queue_event)
+RTE_EXPORT_SYMBOL(rte_eth_vhost_get_queue_event);
 int
 rte_eth_vhost_get_queue_event(uint16_t port_id,
 		struct rte_eth_vhost_queue_event *event)
@@ -1084,7 +1084,7 @@ rte_eth_vhost_get_queue_event(uint16_t port_id,
 	return -1;
 }
 
-RTE_EXPORT_SYMBOL(rte_eth_vhost_get_vid_from_port_id)
+RTE_EXPORT_SYMBOL(rte_eth_vhost_get_vid_from_port_id);
 int
 rte_eth_vhost_get_vid_from_port_id(uint16_t port_id)
 {
diff --git a/drivers/power/kvm_vm/guest_channel.c b/drivers/power/kvm_vm/guest_channel.c
index 42bfcedb56..7abffc2e3c 100644
--- a/drivers/power/kvm_vm/guest_channel.c
+++ b/drivers/power/kvm_vm/guest_channel.c
@@ -152,7 +152,7 @@ guest_channel_send_msg(struct rte_power_channel_packet *pkt,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_power_guest_channel_send_msg)
+RTE_EXPORT_SYMBOL(rte_power_guest_channel_send_msg);
 int rte_power_guest_channel_send_msg(struct rte_power_channel_packet *pkt,
 			unsigned int lcore_id)
 {
@@ -214,7 +214,7 @@ int power_guest_channel_read_msg(void *pkt,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_power_guest_channel_receive_msg)
+RTE_EXPORT_SYMBOL(rte_power_guest_channel_receive_msg);
 int rte_power_guest_channel_receive_msg(void *pkt,
 		size_t pkt_len,
 		unsigned int lcore_id)
diff --git a/drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c b/drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c
index 60c2080740..bcb4373ec7 100644
--- a/drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c
+++ b/drivers/raw/cnxk_rvu_lf/cnxk_rvu_lf.c
@@ -17,7 +17,7 @@
 #include "cnxk_rvu_lf.h"
 #include "cnxk_rvu_lf_driver.h"
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_msg_id_range_set)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_msg_id_range_set);
 int
 rte_pmd_rvu_lf_msg_id_range_set(uint8_t dev_id, uint16_t from, uint16_t to)
 {
@@ -32,7 +32,7 @@ rte_pmd_rvu_lf_msg_id_range_set(uint8_t dev_id, uint16_t from, uint16_t to)
 	return roc_rvu_lf_msg_id_range_set(roc_rvu_lf, from, to);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_msg_process)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_msg_process);
 int
 rte_pmd_rvu_lf_msg_process(uint8_t dev_id, uint16_t vf, uint16_t msg_id,
 			void *req, uint16_t req_len, void *rsp, uint16_t rsp_len)
@@ -48,7 +48,7 @@ rte_pmd_rvu_lf_msg_process(uint8_t dev_id, uint16_t vf, uint16_t msg_id,
 	return roc_rvu_lf_msg_process(roc_rvu_lf, vf, msg_id, req, req_len, rsp, rsp_len);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_msg_handler_register)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_msg_handler_register);
 int
 rte_pmd_rvu_lf_msg_handler_register(uint8_t dev_id, rte_pmd_rvu_lf_msg_handler_cb_fn cb)
 {
@@ -63,7 +63,7 @@ rte_pmd_rvu_lf_msg_handler_register(uint8_t dev_id, rte_pmd_rvu_lf_msg_handler_c
 	return roc_rvu_lf_msg_handler_register(roc_rvu_lf, (roc_rvu_lf_msg_handler_cb_fn)cb);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_msg_handler_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_msg_handler_unregister);
 int
 rte_pmd_rvu_lf_msg_handler_unregister(uint8_t dev_id)
 {
@@ -78,7 +78,7 @@ rte_pmd_rvu_lf_msg_handler_unregister(uint8_t dev_id)
 	return roc_rvu_lf_msg_handler_unregister(roc_rvu_lf);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_irq_register)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_irq_register);
 int
 rte_pmd_rvu_lf_irq_register(uint8_t dev_id, unsigned int irq,
 			    rte_pmd_rvu_lf_intr_callback_fn cb, void *data)
@@ -94,7 +94,7 @@ rte_pmd_rvu_lf_irq_register(uint8_t dev_id, unsigned int irq,
 	return roc_rvu_lf_irq_register(roc_rvu_lf, irq, (roc_rvu_lf_intr_cb_fn)cb, data);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_irq_unregister)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_irq_unregister);
 int
 rte_pmd_rvu_lf_irq_unregister(uint8_t dev_id, unsigned int irq,
 			      rte_pmd_rvu_lf_intr_callback_fn cb, void *data)
@@ -110,7 +110,7 @@ rte_pmd_rvu_lf_irq_unregister(uint8_t dev_id, unsigned int irq,
 	return roc_rvu_lf_irq_unregister(roc_rvu_lf, irq, (roc_rvu_lf_intr_cb_fn)cb, data);
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_bar_get)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_bar_get);
 int
 rte_pmd_rvu_lf_bar_get(uint8_t dev_id, uint8_t bar_num, size_t *va, size_t *mask)
 {
@@ -135,21 +135,21 @@ rte_pmd_rvu_lf_bar_get(uint8_t dev_id, uint8_t bar_num, size_t *va, size_t *mask
 	return 0;
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_npa_pf_func_get)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_npa_pf_func_get);
 uint16_t
 rte_pmd_rvu_lf_npa_pf_func_get(void)
 {
 	return roc_npa_pf_func_get();
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_sso_pf_func_get)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_sso_pf_func_get);
 uint16_t
 rte_pmd_rvu_lf_sso_pf_func_get(void)
 {
 	return roc_sso_pf_func_get();
 }
 
-RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_pf_func_get)
+RTE_EXPORT_INTERNAL_SYMBOL(rte_pmd_rvu_lf_pf_func_get);
 uint16_t
 rte_pmd_rvu_lf_pf_func_get(uint8_t dev_id)
 {
diff --git a/drivers/raw/ifpga/rte_pmd_ifpga.c b/drivers/raw/ifpga/rte_pmd_ifpga.c
index 620b35624b..5b2b634da2 100644
--- a/drivers/raw/ifpga/rte_pmd_ifpga.c
+++ b/drivers/raw/ifpga/rte_pmd_ifpga.c
@@ -13,7 +13,7 @@
 #include "base/ifpga_sec_mgr.h"
 
 
-RTE_EXPORT_SYMBOL(rte_pmd_ifpga_get_dev_id)
+RTE_EXPORT_SYMBOL(rte_pmd_ifpga_get_dev_id);
 int
 rte_pmd_ifpga_get_dev_id(const char *pci_addr, uint16_t *dev_id)
 {
@@ -102,7 +102,7 @@ get_share_data(struct opae_adapter *adapter)
 	return sd;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ifpga_get_rsu_status)
+RTE_EXPORT_SYMBOL(rte_pmd_ifpga_get_rsu_status);
 int
 rte_pmd_ifpga_get_rsu_status(uint16_t dev_id, uint32_t *stat, uint32_t *prog)
 {
@@ -125,7 +125,7 @@ rte_pmd_ifpga_get_rsu_status(uint16_t dev_id, uint32_t *stat, uint32_t *prog)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ifpga_set_rsu_status)
+RTE_EXPORT_SYMBOL(rte_pmd_ifpga_set_rsu_status);
 int
 rte_pmd_ifpga_set_rsu_status(uint16_t dev_id, uint32_t stat, uint32_t prog)
 {
@@ -267,7 +267,7 @@ get_port_property(struct opae_adapter *adapter, uint16_t port,
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ifpga_get_property)
+RTE_EXPORT_SYMBOL(rte_pmd_ifpga_get_property);
 int
 rte_pmd_ifpga_get_property(uint16_t dev_id, rte_pmd_ifpga_prop *prop)
 {
@@ -304,7 +304,7 @@ rte_pmd_ifpga_get_property(uint16_t dev_id, rte_pmd_ifpga_prop *prop)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ifpga_get_phy_info)
+RTE_EXPORT_SYMBOL(rte_pmd_ifpga_get_phy_info);
 int
 rte_pmd_ifpga_get_phy_info(uint16_t dev_id, rte_pmd_ifpga_phy_info *info)
 {
@@ -345,7 +345,7 @@ rte_pmd_ifpga_get_phy_info(uint16_t dev_id, rte_pmd_ifpga_phy_info *info)
 	return ret;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ifpga_update_flash)
+RTE_EXPORT_SYMBOL(rte_pmd_ifpga_update_flash);
 int
 rte_pmd_ifpga_update_flash(uint16_t dev_id, const char *image,
 	uint64_t *status)
@@ -359,7 +359,7 @@ rte_pmd_ifpga_update_flash(uint16_t dev_id, const char *image,
 	return opae_mgr_update_flash(adapter->mgr, image, status);
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ifpga_stop_update)
+RTE_EXPORT_SYMBOL(rte_pmd_ifpga_stop_update);
 int
 rte_pmd_ifpga_stop_update(uint16_t dev_id, int force)
 {
@@ -372,7 +372,7 @@ rte_pmd_ifpga_stop_update(uint16_t dev_id, int force)
 	return opae_mgr_stop_flash_update(adapter->mgr, force);
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ifpga_reboot_try)
+RTE_EXPORT_SYMBOL(rte_pmd_ifpga_reboot_try);
 int
 rte_pmd_ifpga_reboot_try(uint16_t dev_id)
 {
@@ -399,7 +399,7 @@ rte_pmd_ifpga_reboot_try(uint16_t dev_id)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ifpga_reload)
+RTE_EXPORT_SYMBOL(rte_pmd_ifpga_reload);
 int
 rte_pmd_ifpga_reload(uint16_t dev_id, int type, int page)
 {
@@ -412,7 +412,7 @@ rte_pmd_ifpga_reload(uint16_t dev_id, int type, int page)
 	return opae_mgr_reload(adapter->mgr, type, page);
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ifpga_partial_reconfigure)
+RTE_EXPORT_SYMBOL(rte_pmd_ifpga_partial_reconfigure);
 int
 rte_pmd_ifpga_partial_reconfigure(uint16_t dev_id, int port, const char *file)
 {
@@ -427,7 +427,7 @@ rte_pmd_ifpga_partial_reconfigure(uint16_t dev_id, int port, const char *file)
 	return ifpga_rawdev_partial_reconfigure(dev, port, file);
 }
 
-RTE_EXPORT_SYMBOL(rte_pmd_ifpga_cleanup)
+RTE_EXPORT_SYMBOL(rte_pmd_ifpga_cleanup);
 void
 rte_pmd_ifpga_cleanup(void)
 {
diff --git a/lib/eal/common/eal_export.h b/lib/eal/common/eal_export.h
index 7e47d34064..20ae57976f 100644
--- a/lib/eal/common/eal_export.h
+++ b/lib/eal/common/eal_export.h
@@ -11,9 +11,9 @@
  * For RTE_EXPORT_EXPERIMENTAL_SYMBOL, ver indicates the
  * version this symbol was introduced in.
  */
-#define RTE_EXPORT_EXPERIMENTAL_SYMBOL(symbol, ver)
-#define RTE_EXPORT_INTERNAL_SYMBOL(symbol)
-#define RTE_EXPORT_SYMBOL(symbol)
+#define RTE_EXPORT_EXPERIMENTAL_SYMBOL(symbol, ver)	extern int dummy_rte_export_symbol
+#define RTE_EXPORT_INTERNAL_SYMBOL(symbol)		extern int dummy_rte_export_symbol
+#define RTE_EXPORT_SYMBOL(symbol)			extern int dummy_rte_export_symbol
 
 #if !defined(RTE_USE_FUNCTION_VERSIONING) && (defined(RTE_CC_GCC) || defined(RTE_CC_CLANG))
 #define VERSIONING_WARN RTE_PRAGMA_WARNING(Use of function versioning disabled. \
-- 
2.17.1

