Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7F7BFF8867
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Apr 2026 11:46:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0BFCC4066C;
	Wed, 29 Apr 2026 13:46:12 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 42EF7402AC
 for <dev@dpdk.org>; Wed, 29 Apr 2026 13:46:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777463168;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tmAN24qCu4npkrE2v7OBgfrp6PpDssiuKvktXyUdxcA=;
 b=VUlNh+OQwc6VgfMciR52VRc0laiFst9FkW9zU1wko2UMw6Z64y6HcFaSdQ5/c/3y0Tr++3
 ga9tBj2xMoI1vnetPGkn5jJNpEBOmj6LhipmYpm5Jwlv1B5QE390894cRs81EwRao3nZhu
 tlfyMpzGXMLvech3pGgXRwn51OF22h4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-441-Fl9jHTrOOnawXhSXtbkVjg-1; Wed,
 29 Apr 2026 07:46:03 -0400
X-MC-Unique: Fl9jHTrOOnawXhSXtbkVjg-1
X-Mimecast-MFC-AGG-ID: Fl9jHTrOOnawXhSXtbkVjg_1777463158
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CF1DA1800370; Wed, 29 Apr 2026 11:45:57 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.207])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 90AF519560AB; Wed, 29 Apr 2026 11:45:43 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, stephen@networkplumber.org,
 bruce.richardson@intel.com, Nicolas Chautru <nicolas.chautru@intel.com>,
 Parav Pandit <parav@nvidia.com>, Xueming Li <xuemingl@nvidia.com>,
 Nipun Gupta <nipun.gupta@amd.com>, Nikhil Agarwal <nikhil.agarwal@amd.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Rosen Xu <rosen.xu@altera.com>,
 Chenbo Xia <chenbox@nvidia.com>, Tomasz Duszynski <tduszynski@marvell.com>,
 Chengwen Feng <fengchengwen@huawei.com>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>,
 Bing Zhao <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>,
 Ashish Gupta <ashishg@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Ankur Dwivedi <adwivedi@marvell.com>, Anoob Joseph <anoobj@marvell.com>,
 Tejasree Kondoj <ktejasree@marvell.com>, Gagandeep Singh <g.singh@nxp.com>,
 Pavan Nikhilesh <pbhagavatula@marvell.com>,
 Shijith Thotton <sthotton@marvell.com>,
 Tirthendu Sarkar <tirthendu.sarkar@intel.com>,
 Jerin Jacob <jerinj@marvell.com>,
 Selwin Sebastian <selwin.sebastian@amd.com>,
 Julien Aube <julien_dpdk@jaube.fr>,
 Kishore Padmanabha <kishore.padmanabha@broadcom.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Chas Williams <3chas3@gmail.com>, "Min Hu (Connor)" <humin29@huawei.com>,
 Jeroen de Borst <jeroendb@google.com>,
 Joshua Washington <joshwash@google.com>,
 Xingui Yang <yangxingui@huawei.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Long Li <longli@microsoft.com>,
 Wei Hu <weh@microsoft.com>, Devendra Singh Rawat <dsinghrawat@marvell.com>,
 Alok Prasad <palok@marvell.com>, Wenbo Cao <caowenbo@mucse.com>
Subject: [PATCH 06/23] bus: add bus conversion macros
Date: Wed, 29 Apr 2026 13:44:39 +0200
Message-ID: <20260429114503.932575-7-david.marchand@redhat.com>
In-Reply-To: <20260429114503.932575-1-david.marchand@redhat.com>
References: <20260429114503.932575-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g0c6Lcnia4DDte04N3V3AdBqvvSnfIB4xDk-RHHUx48_1777463158
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

Introduce two generic macros to replace all bus-specific device and
driver conversion macros:

- RTE_BUS_DEVICE(dev, bus_dev_type): Converts a generic rte_device
  pointer to a bus-specific device structure using typeof() to infer
  the correct type. The second parameter can be either a struct type
  (e.g., struct rte_pci_device) or a dereferenced pointer variable
  (e.g., *pdev) for automatic type inference.

- RTE_BUS_DRIVER(drv, bus_drv_type): Converts a generic rte_driver
  pointer to a bus-specific driver structure using the same approach.

All bus drivers and device class drivers have been updated to use
these generic macros instead of their bus-specific conversion macros
(RTE_DEV_TO_*, DEV_TO_*) or direct container_of() calls.

Ethernet device convenience macros (RTE_ETH_DEV_TO_*) have been updated
to use RTE_BUS_DEVICE internally.

Usage patterns:
- For pre-existing variables: pdev = RTE_BUS_DEVICE(dev, *pdev);
- For new declarations:
  struct rte_pci_device *pdev = RTE_BUS_DEVICE(dev, *pdev);
- For inline conversions: foo(RTE_BUS_DEVICE(dev, struct rte_pci_device));
- For const conversions: RTE_BUS_DEVICE(dev, const struct rte_pci_device);

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/baseband/acc/rte_acc100_pmd.c         |  4 +--
 drivers/baseband/acc/rte_vrb_pmd.c            |  2 +-
 .../fpga_5gnr_fec/rte_fpga_5gnr_fec.c         |  4 +--
 drivers/baseband/fpga_lte_fec/fpga_lte_fec.c  |  2 +-
 drivers/bus/auxiliary/auxiliary_common.c      | 10 +++----
 drivers/bus/auxiliary/bus_auxiliary_driver.h  | 13 ++------
 drivers/bus/cdx/bus_cdx_driver.h              | 10 -------
 drivers/bus/cdx/cdx.c                         |  6 ++--
 drivers/bus/dpaa/bus_dpaa_driver.h            |  7 +----
 drivers/bus/dpaa/dpaa_bus.c                   |  4 +--
 drivers/bus/fslmc/bus_fslmc_driver.h          |  4 +--
 drivers/bus/fslmc/fslmc_bus.c                 | 10 +++----
 drivers/bus/ifpga/bus_ifpga_driver.h          |  8 +----
 drivers/bus/ifpga/ifpga_bus.c                 |  4 +--
 drivers/bus/pci/bus_pci_driver.h              | 13 ++------
 drivers/bus/pci/pci_common.c                  | 12 ++++----
 drivers/bus/pci/pci_params.c                  |  2 +-
 drivers/bus/platform/bus_platform_driver.h    | 10 -------
 drivers/bus/platform/platform.c               | 17 +++++++----
 drivers/bus/uacce/bus_uacce_driver.h          | 10 -------
 drivers/bus/uacce/uacce.c                     |  6 ++--
 drivers/bus/vdev/bus_vdev_driver.h            | 14 ++-------
 drivers/bus/vdev/vdev.c                       | 24 ++++++---------
 drivers/common/mlx5/linux/mlx5_common_os.c    |  5 ++--
 drivers/common/mlx5/mlx5_common.c             |  2 +-
 drivers/common/mlx5/mlx5_common_pci.c         |  2 +-
 drivers/common/mlx5/windows/mlx5_common_os.c  |  2 +-
 drivers/compress/octeontx/otx_zip.c           |  2 +-
 drivers/crypto/cnxk/cnxk_cryptodev_ops.c      |  2 +-
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c   |  2 +-
 drivers/crypto/octeontx/otx_cryptodev_ops.c   |  4 +--
 drivers/event/cnxk/cnxk_eventdev.c            |  2 +-
 drivers/event/dlb2/pf/dlb2_pf.c               |  2 +-
 drivers/event/skeleton/skeleton_eventdev.c    |  2 +-
 drivers/net/axgbe/axgbe_ethdev.c              |  4 +--
 drivers/net/bnx2x/bnx2x_ethdev.c              |  2 +-
 drivers/net/bnxt/bnxt_ethdev.c                |  2 +-
 drivers/net/bnxt/tf_ulp/bnxt_ulp.c            |  4 +--
 drivers/net/bonding/rte_eth_bond_args.c       |  2 +-
 drivers/net/dpaa/dpaa_ethdev.c                | 13 ++++----
 drivers/net/dpaa2/dpaa2_ethdev.c              |  6 ++--
 drivers/net/dpaa2/dpaa2_recycle.c             |  6 ++--
 drivers/net/gve/gve_ethdev.c                  |  2 +-
 drivers/net/hns3/hns3_ethdev.c                |  4 +--
 drivers/net/hns3/hns3_rxtx.c                  |  2 +-
 drivers/net/intel/cpfl/cpfl_ethdev.c          |  4 +--
 drivers/net/intel/cpfl/cpfl_ethdev.h          |  2 +-
 drivers/net/intel/i40e/i40e_ethdev.h          |  2 +-
 drivers/net/intel/ice/ice_ethdev.c            |  4 +--
 drivers/net/intel/ice/ice_ethdev.h            |  2 +-
 drivers/net/intel/idpf/idpf_ethdev.h          |  2 +-
 drivers/net/intel/ipn3ke/ipn3ke_ethdev.h      | 12 +-------
 drivers/net/mlx5/linux/mlx5_os.c              |  9 +++---
 drivers/net/mlx5/windows/mlx5_os.c            |  4 +--
 drivers/net/netvsc/hn_ethdev.c                |  2 +-
 drivers/net/qede/qede_ethdev.c                |  2 +-
 drivers/net/rnp/rnp_ethdev.c                  |  6 ++--
 drivers/raw/ifpga/afu_pmd_n3000.c             |  4 +--
 lib/eal/include/bus_driver.h                  | 30 +++++++++++++++++++
 59 files changed, 152 insertions(+), 203 deletions(-)

diff --git a/drivers/baseband/acc/rte_acc100_pmd.c b/drivers/baseband/acc/rte_acc100_pmd.c
index b7f02f56e1..061f595a98 100644
--- a/drivers/baseband/acc/rte_acc100_pmd.c
+++ b/drivers/baseband/acc/rte_acc100_pmd.c
@@ -3993,7 +3993,7 @@ acc100_dequeue_ldpc_dec(struct rte_bbdev_queue_data *q_data,
 static void
 acc100_bbdev_init(struct rte_bbdev *dev, struct rte_pci_driver *drv)
 {
-	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(dev->device);
+	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(dev->device, *pci_dev);
 
 	dev->dev_ops = &acc100_bbdev_ops;
 	dev->enqueue_enc_ops = acc100_enqueue_enc;
@@ -4646,7 +4646,7 @@ rte_acc_configure(const char *dev_name, struct rte_acc_conf *conf)
 				dev_name);
 		return -ENODEV;
 	}
-	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(bbdev->device);
+	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(bbdev->device, *pci_dev);
 	rte_bbdev_log(INFO, "Configure dev id %x", pci_dev->id.device_id);
 	if (pci_dev->id.device_id == ACC100_PF_DEVICE_ID)
 		return acc100_configure(dev_name, conf);
diff --git a/drivers/baseband/acc/rte_vrb_pmd.c b/drivers/baseband/acc/rte_vrb_pmd.c
index c5161e6502..fe23c01b5c 100644
--- a/drivers/baseband/acc/rte_vrb_pmd.c
+++ b/drivers/baseband/acc/rte_vrb_pmd.c
@@ -4353,7 +4353,7 @@ vrb2_dequeue_mldts(struct rte_bbdev_queue_data *q_data,
 static void
 vrb_bbdev_init(struct rte_bbdev *dev, struct rte_pci_driver *drv)
 {
-	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(dev->device);
+	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(dev->device, *pci_dev);
 	struct acc_device *d = dev->data->dev_private;
 
 	dev->dev_ops = &vrb_bbdev_ops;
diff --git a/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c b/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c
index 82cf98da5d..cb805a1732 100644
--- a/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c
+++ b/drivers/baseband/fpga_5gnr_fec/rte_fpga_5gnr_fec.c
@@ -2873,7 +2873,7 @@ fpga_5gnr_dequeue_ldpc_dec(struct rte_bbdev_queue_data *q_data,
 static void
 fpga_5gnr_fec_init(struct rte_bbdev *dev, struct rte_pci_driver *drv)
 {
-	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(dev->device);
+	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(dev->device, *pci_dev);
 
 	dev->dev_ops = &fpga_5gnr_ops;
 	dev->enqueue_ldpc_enc_ops = fpga_5gnr_enqueue_ldpc_enc;
@@ -3376,7 +3376,7 @@ int rte_fpga_5gnr_fec_configure(const char *dev_name, const struct rte_fpga_5gnr
 				dev_name);
 		return -ENODEV;
 	}
-	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(bbdev->device);
+	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(bbdev->device, *pci_dev);
 	rte_bbdev_log(INFO, "Configure dev id %x", pci_dev->id.device_id);
 	if (pci_dev->id.device_id == VC_5GNR_PF_DEVICE_ID)
 		return vc_5gnr_configure(dev_name, conf);
diff --git a/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c b/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c
index 4723a51dcf..d27164c6f4 100644
--- a/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c
+++ b/drivers/baseband/fpga_lte_fec/fpga_lte_fec.c
@@ -2316,7 +2316,7 @@ fpga_dequeue_dec(struct rte_bbdev_queue_data *q_data,
 static void
 fpga_lte_fec_init(struct rte_bbdev *dev, struct rte_pci_driver *drv)
 {
-	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(dev->device);
+	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(dev->device, *pci_dev);
 
 	dev->dev_ops = &fpga_ops;
 	dev->enqueue_enc_ops = fpga_enqueue_enc;
diff --git a/drivers/bus/auxiliary/auxiliary_common.c b/drivers/bus/auxiliary/auxiliary_common.c
index 314361643c..afb4a7ce1b 100644
--- a/drivers/bus/auxiliary/auxiliary_common.c
+++ b/drivers/bus/auxiliary/auxiliary_common.c
@@ -281,7 +281,7 @@ auxiliary_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
 	struct rte_auxiliary_device *adev;
 
 	if (start != NULL) {
-		pstart = RTE_DEV_TO_AUXILIARY_CONST(start);
+		pstart = RTE_BUS_DEVICE(start, *pstart);
 		adev = TAILQ_NEXT(pstart, next);
 	} else {
 		adev = TAILQ_FIRST(&auxiliary_bus.device_list);
@@ -299,13 +299,13 @@ auxiliary_plug(struct rte_device *dev)
 {
 	if (!auxiliary_dev_exists(dev->name))
 		return -ENOENT;
-	return auxiliary_probe_all_drivers(RTE_DEV_TO_AUXILIARY(dev));
+	return auxiliary_probe_all_drivers(RTE_BUS_DEVICE(dev, struct rte_auxiliary_device));
 }
 
 static int
 auxiliary_unplug(struct rte_device *dev)
 {
-	struct rte_auxiliary_device *adev = RTE_DEV_TO_AUXILIARY(dev);
+	struct rte_auxiliary_device *adev = RTE_BUS_DEVICE(dev, *adev);
 	int ret;
 
 	ret = rte_auxiliary_driver_remove_dev(adev);
@@ -342,7 +342,7 @@ auxiliary_cleanup(void)
 static int
 auxiliary_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 {
-	struct rte_auxiliary_device *aux_dev = RTE_DEV_TO_AUXILIARY(dev);
+	struct rte_auxiliary_device *aux_dev = RTE_BUS_DEVICE(dev, *aux_dev);
 
 	if (aux_dev->driver->dma_map == NULL) {
 		rte_errno = ENOTSUP;
@@ -355,7 +355,7 @@ static int
 auxiliary_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova,
 		    size_t len)
 {
-	struct rte_auxiliary_device *aux_dev = RTE_DEV_TO_AUXILIARY(dev);
+	struct rte_auxiliary_device *aux_dev = RTE_BUS_DEVICE(dev, *aux_dev);
 
 	if (aux_dev->driver->dma_unmap == NULL) {
 		rte_errno = ENOTSUP;
diff --git a/drivers/bus/auxiliary/bus_auxiliary_driver.h b/drivers/bus/auxiliary/bus_auxiliary_driver.h
index 8450d56583..5c14592f6f 100644
--- a/drivers/bus/auxiliary/bus_auxiliary_driver.h
+++ b/drivers/bus/auxiliary/bus_auxiliary_driver.h
@@ -22,6 +22,7 @@
 #include <rte_debug.h>
 #include <rte_interrupts.h>
 #include <dev_driver.h>
+#include <bus_driver.h>
 #include <rte_kvargs.h>
 
 #ifdef __cplusplus
@@ -130,18 +131,8 @@ struct rte_auxiliary_driver {
 	uint32_t drv_flags;                   /**< Flags RTE_AUXILIARY_DRV_*. */
 };
 
-/**
- * @internal
- * Helper macro for drivers that need to convert to struct rte_auxiliary_device.
- */
-#define RTE_DEV_TO_AUXILIARY(ptr) \
-	container_of(ptr, struct rte_auxiliary_device, device)
-
-#define RTE_DEV_TO_AUXILIARY_CONST(ptr) \
-	container_of(ptr, const struct rte_auxiliary_device, device)
-
 #define RTE_ETH_DEV_TO_AUXILIARY(eth_dev) \
-	RTE_DEV_TO_AUXILIARY((eth_dev)->device)
+	RTE_BUS_DEVICE((eth_dev)->device, struct rte_auxiliary_device)
 
 /** Device driver needs IOVA as VA and cannot work with IOVA as PA */
 #define RTE_AUXILIARY_DRV_NEED_IOVA_AS_VA 0x002
diff --git a/drivers/bus/cdx/bus_cdx_driver.h b/drivers/bus/cdx/bus_cdx_driver.h
index f0780a84ad..935e37158a 100644
--- a/drivers/bus/cdx/bus_cdx_driver.h
+++ b/drivers/bus/cdx/bus_cdx_driver.h
@@ -63,16 +63,6 @@ struct rte_cdx_device {
 	struct rte_intr_handle *intr_handle;	/**< Interrupt handle */
 };
 
-/**
- * @internal
- * Helper macro for drivers that need to convert to struct rte_cdx_device.
- */
-#define RTE_DEV_TO_CDX_DEV(ptr) \
-	container_of(ptr, struct rte_cdx_device, device)
-
-#define RTE_DEV_TO_CDX_DEV_CONST(ptr) \
-	container_of(ptr, const struct rte_cdx_device, device)
-
 #define RTE_ETH_DEV_TO_CDX_DEV(eth_dev)	RTE_DEV_TO_CDX_DEV((eth_dev)->device)
 
 #ifdef __cplusplus
diff --git a/drivers/bus/cdx/cdx.c b/drivers/bus/cdx/cdx.c
index f498b747e2..267c7598c7 100644
--- a/drivers/bus/cdx/cdx.c
+++ b/drivers/bus/cdx/cdx.c
@@ -474,7 +474,7 @@ cdx_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
 	struct rte_cdx_device *cdx_dev;
 
 	if (start != NULL) {
-		cdx_start = RTE_DEV_TO_CDX_DEV_CONST(start);
+		cdx_start = RTE_BUS_DEVICE(start, *cdx_start);
 		cdx_dev = TAILQ_NEXT(cdx_start, next);
 	} else {
 		cdx_dev = TAILQ_FIRST(&rte_cdx_bus.device_list);
@@ -528,13 +528,13 @@ cdx_detach_dev(struct rte_cdx_device *dev)
 static int
 cdx_plug(struct rte_device *dev)
 {
-	return cdx_probe_all_drivers(RTE_DEV_TO_CDX_DEV(dev));
+	return cdx_probe_all_drivers(RTE_BUS_DEVICE(dev, struct rte_cdx_device));
 }
 
 static int
 cdx_unplug(struct rte_device *dev)
 {
-	struct rte_cdx_device *cdx_dev = RTE_DEV_TO_CDX_DEV(dev);
+	struct rte_cdx_device *cdx_dev = RTE_BUS_DEVICE(dev, *cdx_dev);
 	int ret;
 
 	ret = cdx_detach_dev(cdx_dev);
diff --git a/drivers/bus/dpaa/bus_dpaa_driver.h b/drivers/bus/dpaa/bus_dpaa_driver.h
index cca0543432..64cbfd8e92 100644
--- a/drivers/bus/dpaa/bus_dpaa_driver.h
+++ b/drivers/bus/dpaa/bus_dpaa_driver.h
@@ -8,6 +8,7 @@
 
 #include <rte_compat.h>
 #include <dev_driver.h>
+#include <bus_driver.h>
 #include <rte_mbuf_dyn.h>
 #include <rte_mempool.h>
 
@@ -49,9 +50,6 @@ dpaa_seqn(struct rte_mbuf *mbuf)
 
 #define DPAA_MEMPOOL_OPS_NAME	"dpaa"
 
-#define DEV_TO_DPAA_DEVICE(ptr)	\
-		container_of(ptr, struct rte_dpaa_device, device)
-
 /* DPAA SoC identifier; If this is not available, it can be concluded
  * that board is non-DPAA. Single slot is currently supported.
  */
@@ -65,9 +63,6 @@ dpaa_seqn(struct rte_mbuf *mbuf)
 /** Number of supported QDMA devices */
 #define RTE_DPAA_QDMA_DEVICES  1
 
-#define RTE_DEV_TO_DPAA_CONST(ptr) \
-	container_of(ptr, const struct rte_dpaa_device, device)
-
 struct rte_dpaa_device;
 struct rte_dpaa_driver;
 
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 1bfc44155d..ca6fd06ac0 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -835,7 +835,7 @@ rte_dpaa_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
 	 */
 
 	if (start != NULL) {
-		dstart = RTE_DEV_TO_DPAA_CONST(start);
+		dstart = RTE_BUS_DEVICE(start, *dstart);
 		dev = TAILQ_NEXT(dstart, next);
 	} else {
 		dev = TAILQ_FIRST(&rte_dpaa_bus.device_list);
@@ -908,7 +908,7 @@ dpaa_bus_dev_iterate(const void *start, const char *str,
 	dev_name = dup + strlen("name=");
 
 	if (start != NULL) {
-		dstart = RTE_DEV_TO_DPAA_CONST(start);
+		dstart = RTE_BUS_DEVICE(start, *dstart);
 		dev = TAILQ_NEXT(dstart, next);
 	} else {
 		dev = TAILQ_FIRST(&rte_dpaa_bus.device_list);
diff --git a/drivers/bus/fslmc/bus_fslmc_driver.h b/drivers/bus/fslmc/bus_fslmc_driver.h
index 89abc3c486..51bca8a6ef 100644
--- a/drivers/bus/fslmc/bus_fslmc_driver.h
+++ b/drivers/bus/fslmc/bus_fslmc_driver.h
@@ -25,6 +25,7 @@
 #include <rte_debug.h>
 #include <rte_interrupts.h>
 #include <dev_driver.h>
+#include <bus_driver.h>
 #include <rte_tailq.h>
 #include <rte_devargs.h>
 #include <rte_mbuf.h>
@@ -67,9 +68,6 @@ dpaa2_seqn(struct rte_mbuf *mbuf)
 
 struct rte_dpaa2_driver;
 
-#define RTE_DEV_TO_FSLMC_CONST(ptr) \
-	container_of(ptr, const struct rte_dpaa2_device, device)
-
 enum rte_dpaa2_dev_type {
 	/* Devices backed by DPDK driver */
 	DPAA2_ETH,	/**< DPNI type device*/
diff --git a/drivers/bus/fslmc/fslmc_bus.c b/drivers/bus/fslmc/fslmc_bus.c
index 7e5a3e947e..59c9d85bb8 100644
--- a/drivers/bus/fslmc/fslmc_bus.c
+++ b/drivers/bus/fslmc/fslmc_bus.c
@@ -497,7 +497,7 @@ rte_fslmc_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
 	 */
 
 	if (start != NULL) {
-		dstart = RTE_DEV_TO_FSLMC_CONST(start);
+		dstart = RTE_BUS_DEVICE(start, *dstart);
 		dev = TAILQ_NEXT(dstart, next);
 	} else {
 		dev = TAILQ_FIRST(&rte_fslmc_bus.device_list);
@@ -579,8 +579,7 @@ static int
 fslmc_bus_plug(struct rte_device *rte_dev)
 {
 	int ret = 0;
-	struct rte_dpaa2_device *dev = container_of(rte_dev,
-			struct rte_dpaa2_device, device);
+	struct rte_dpaa2_device *dev = RTE_BUS_DEVICE(rte_dev, *dev);
 	struct rte_dpaa2_driver *drv;
 
 	TAILQ_FOREACH(drv, &rte_fslmc_bus.driver_list, next) {
@@ -615,8 +614,7 @@ fslmc_bus_plug(struct rte_device *rte_dev)
 static int
 fslmc_bus_unplug(struct rte_device *rte_dev)
 {
-	struct rte_dpaa2_device *dev = container_of(rte_dev,
-			struct rte_dpaa2_device, device);
+	struct rte_dpaa2_device *dev = RTE_BUS_DEVICE(rte_dev, *dev);
 	struct rte_dpaa2_driver *drv = dev->driver;
 
 	if (drv->remove != NULL) {
@@ -658,7 +656,7 @@ fslmc_bus_dev_iterate(const void *start, const char *str,
 	dev_name = dup + strlen("name=");
 
 	if (start != NULL) {
-		dstart = RTE_DEV_TO_FSLMC_CONST(start);
+		dstart = RTE_BUS_DEVICE(start, *dstart);
 		dev = TAILQ_NEXT(dstart, next);
 	} else {
 		dev = TAILQ_FIRST(&rte_fslmc_bus.device_list);
diff --git a/drivers/bus/ifpga/bus_ifpga_driver.h b/drivers/bus/ifpga/bus_ifpga_driver.h
index c0f5fb5b85..b0ba8c9e64 100644
--- a/drivers/bus/ifpga/bus_ifpga_driver.h
+++ b/drivers/bus/ifpga/bus_ifpga_driver.h
@@ -13,6 +13,7 @@
 
 #include <rte_compat.h>
 #include <dev_driver.h>
+#include <bus_driver.h>
 #include <rte_pci.h>
 #include <rte_interrupts.h>
 #include <rte_spinlock.h>
@@ -79,13 +80,6 @@ struct rte_afu_device {
 	char path[IFPGA_BUS_BITSTREAM_PATH_MAX_LEN];
 };
 
-/**
- * @internal
- * Helper macro for drivers that need to convert to struct rte_afu_device.
- */
-#define RTE_DEV_TO_AFU(ptr) \
-	container_of(ptr, struct rte_afu_device, device)
-
 /**
  * Initialization function for the driver called during FPGA BUS probing.
  */
diff --git a/drivers/bus/ifpga/ifpga_bus.c b/drivers/bus/ifpga/ifpga_bus.c
index 0f331fa6dd..63f6a01cde 100644
--- a/drivers/bus/ifpga/ifpga_bus.c
+++ b/drivers/bus/ifpga/ifpga_bus.c
@@ -388,13 +388,13 @@ ifpga_cleanup(void)
 static int
 ifpga_plug(struct rte_device *dev)
 {
-	return ifpga_probe_all_drivers(RTE_DEV_TO_AFU(dev));
+	return ifpga_probe_all_drivers(RTE_BUS_DEVICE(dev, struct rte_afu_device));
 }
 
 static int
 ifpga_unplug(struct rte_device *dev)
 {
-	struct rte_afu_device *afu_dev = RTE_DEV_TO_AFU(dev);
+	struct rte_afu_device *afu_dev = RTE_BUS_DEVICE(dev, *afu_dev);
 	int ret;
 
 	ret = afu_dev->driver->remove(afu_dev);
diff --git a/drivers/bus/pci/bus_pci_driver.h b/drivers/bus/pci/bus_pci_driver.h
index 54e25c8c2a..22ab962f05 100644
--- a/drivers/bus/pci/bus_pci_driver.h
+++ b/drivers/bus/pci/bus_pci_driver.h
@@ -8,6 +8,7 @@
 
 #include <rte_bus_pci.h>
 #include <dev_driver.h>
+#include <bus_driver.h>
 #include <rte_compat.h>
 
 #ifdef __cplusplus
@@ -48,16 +49,8 @@ struct rte_pci_device {
 				/**< Handler of VFIO request interrupt */
 };
 
-/**
- * @internal
- * Helper macro for drivers that need to convert to struct rte_pci_device.
- */
-#define RTE_DEV_TO_PCI(ptr) container_of(ptr, struct rte_pci_device, device)
-
-#define RTE_DEV_TO_PCI_CONST(ptr) \
-	container_of(ptr, const struct rte_pci_device, device)
-
-#define RTE_ETH_DEV_TO_PCI(eth_dev)	RTE_DEV_TO_PCI((eth_dev)->device)
+#define RTE_ETH_DEV_TO_PCI(eth_dev) \
+	RTE_BUS_DEVICE((eth_dev)->device, struct rte_pci_device)
 
 #ifdef __cplusplus
 /** C++ macro used to help building up tables of device IDs */
diff --git a/drivers/bus/pci/pci_common.c b/drivers/bus/pci/pci_common.c
index 1385b0c959..f3d7878966 100644
--- a/drivers/bus/pci/pci_common.c
+++ b/drivers/bus/pci/pci_common.c
@@ -542,7 +542,7 @@ pci_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
 	struct rte_pci_device *pdev;
 
 	if (start != NULL) {
-		pstart = RTE_DEV_TO_PCI_CONST(start);
+		pstart = RTE_BUS_DEVICE(start, *pstart);
 		pdev = TAILQ_NEXT(pstart, next);
 	} else {
 		pdev = TAILQ_FIRST(&rte_pci_bus.device_list);
@@ -588,7 +588,7 @@ pci_find_device_by_addr(const void *failure_addr)
 static int
 pci_hot_unplug_handler(struct rte_device *dev)
 {
-	struct rte_pci_device *pdev = RTE_DEV_TO_PCI(dev);
+	struct rte_pci_device *pdev = RTE_BUS_DEVICE(dev, *pdev);
 	int ret = 0;
 
 	switch (pdev->kdrv) {
@@ -642,13 +642,13 @@ pci_sigbus_handler(const void *failure_addr)
 static int
 pci_plug(struct rte_device *dev)
 {
-	return pci_probe_all_drivers(RTE_DEV_TO_PCI(dev));
+	return pci_probe_all_drivers(RTE_BUS_DEVICE(dev, struct rte_pci_device));
 }
 
 static int
 pci_unplug(struct rte_device *dev)
 {
-	struct rte_pci_device *pdev = RTE_DEV_TO_PCI(dev);
+	struct rte_pci_device *pdev = RTE_BUS_DEVICE(dev, *pdev);
 	int ret;
 
 	ret = rte_pci_detach_dev(pdev);
@@ -663,7 +663,7 @@ pci_unplug(struct rte_device *dev)
 static int
 pci_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 {
-	struct rte_pci_device *pdev = RTE_DEV_TO_PCI(dev);
+	struct rte_pci_device *pdev = RTE_BUS_DEVICE(dev, *pdev);
 
 	if (pdev->driver->dma_map != NULL)
 		return pdev->driver->dma_map(pdev, addr, iova, len);
@@ -682,7 +682,7 @@ pci_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 static int
 pci_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 {
-	struct rte_pci_device *pdev = RTE_DEV_TO_PCI(dev);
+	struct rte_pci_device *pdev = RTE_BUS_DEVICE(dev, *pdev);
 
 	if (pdev->driver->dma_unmap != NULL)
 		return pdev->driver->dma_unmap(pdev, addr, iova, len);
diff --git a/drivers/bus/pci/pci_params.c b/drivers/bus/pci/pci_params.c
index 087ec38bb9..d771d8d1ba 100644
--- a/drivers/bus/pci/pci_params.c
+++ b/drivers/bus/pci/pci_params.c
@@ -49,7 +49,7 @@ pci_dev_match(const struct rte_device *dev,
 	if (kvlist == NULL)
 		/* Empty string matches everything. */
 		return 0;
-	pdev = RTE_DEV_TO_PCI_CONST(dev);
+	pdev = RTE_BUS_DEVICE(dev, *pdev);
 	/* if any field does not match. */
 	if (rte_kvargs_process(kvlist, pci_params_keys[RTE_PCI_PARAM_ADDR],
 			       &pci_addr_kv_cmp,
diff --git a/drivers/bus/platform/bus_platform_driver.h b/drivers/bus/platform/bus_platform_driver.h
index 76403043c1..09eb08e347 100644
--- a/drivers/bus/platform/bus_platform_driver.h
+++ b/drivers/bus/platform/bus_platform_driver.h
@@ -119,16 +119,6 @@ struct rte_platform_driver {
 /** Device driver needs IOVA as VA and cannot work with IOVA as PA */
 #define RTE_PLATFORM_DRV_NEED_IOVA_AS_VA 0x0001
 
-/**
- * @internal
- * Helper macros used to convert core device to platform device.
- */
-#define RTE_DEV_TO_PLATFORM_DEV(ptr) \
-	container_of(ptr, struct rte_platform_device, device)
-
-#define RTE_DEV_TO_PLATFORM_DEV_CONST(ptr) \
-	container_of(ptr, const struct rte_platform_device, device)
-
 /** Helper for platform driver registration. */
 #define RTE_PMD_REGISTER_PLATFORM(nm, platform_drv) \
 static const char *pdrvinit_ ## nm ## _alias; \
diff --git a/drivers/bus/platform/platform.c b/drivers/bus/platform/platform.c
index 5cc0d69209..0e57473f25 100644
--- a/drivers/bus/platform/platform.c
+++ b/drivers/bus/platform/platform.c
@@ -441,10 +441,15 @@ platform_bus_probe(void)
 static struct rte_device *
 platform_bus_find_device(const struct rte_device *start, rte_dev_cmp_t cmp, const void *data)
 {
+	const struct rte_platform_device *pstart;
 	struct rte_platform_device *pdev;
 
-	pdev = start ? RTE_TAILQ_NEXT(RTE_DEV_TO_PLATFORM_DEV_CONST(start), next) :
-		       RTE_TAILQ_FIRST(&platform_bus.device_list);
+	if (start != NULL) {
+		pstart = RTE_BUS_DEVICE(start, *pstart);
+		pdev = TAILQ_NEXT(pstart, next);
+	} else {
+		pdev = RTE_TAILQ_FIRST(&platform_bus.device_list);
+	}
 	while (pdev) {
 		if (cmp(&pdev->device, data) == 0)
 			return &pdev->device;
@@ -464,7 +469,7 @@ platform_bus_plug(struct rte_device *dev)
 	if (!dev_is_bound_vfio_platform(dev->name))
 		return -EPERM;
 
-	return device_attach(RTE_DEV_TO_PLATFORM_DEV(dev));
+	return device_attach(RTE_BUS_DEVICE(dev, struct rte_platform_device));
 }
 
 static void
@@ -486,7 +491,7 @@ device_release_driver(struct rte_platform_device *pdev)
 static int
 platform_bus_unplug(struct rte_device *dev)
 {
-	struct rte_platform_device *pdev = RTE_DEV_TO_PLATFORM_DEV(dev);
+	struct rte_platform_device *pdev = RTE_BUS_DEVICE(dev, *pdev);
 
 	device_release_driver(pdev);
 	device_cleanup(pdev);
@@ -519,7 +524,7 @@ platform_bus_parse(const char *name, void *addr)
 static int
 platform_bus_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 {
-	struct rte_platform_device *pdev = RTE_DEV_TO_PLATFORM_DEV(dev);
+	struct rte_platform_device *pdev = RTE_BUS_DEVICE(dev, *pdev);
 
 	if (pdev->driver->dma_map != NULL)
 		return pdev->driver->dma_map(pdev, addr, iova, len);
@@ -530,7 +535,7 @@ platform_bus_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t l
 static int
 platform_bus_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 {
-	struct rte_platform_device *pdev = RTE_DEV_TO_PLATFORM_DEV(dev);
+	struct rte_platform_device *pdev = RTE_BUS_DEVICE(dev, *pdev);
 
 	if (pdev->driver->dma_unmap != NULL)
 		return pdev->driver->dma_unmap(pdev, addr, iova, len);
diff --git a/drivers/bus/uacce/bus_uacce_driver.h b/drivers/bus/uacce/bus_uacce_driver.h
index c7445778a6..476afbc857 100644
--- a/drivers/bus/uacce/bus_uacce_driver.h
+++ b/drivers/bus/uacce/bus_uacce_driver.h
@@ -57,16 +57,6 @@ struct rte_uacce_device {
 	uint32_t qfrt_sz[RTE_UACCE_QFRT_BUTT];   /**< Queue file region type's size. */
 };
 
-/**
- * @internal
- * Helper macro for drivers that need to convert to struct rte_uacce_device.
- */
-#define RTE_DEV_TO_UACCE_DEV(ptr) \
-	container_of(ptr, struct rte_uacce_device, device)
-
-#define RTE_DEV_TO_UACCE_DEV_CONST(ptr) \
-	container_of(ptr, const struct rte_uacce_device, device)
-
 /**
  * A structure describing an ID for a UACCE driver. Each driver provides a
  * table of these IDs for each device that it supports.
diff --git a/drivers/bus/uacce/uacce.c b/drivers/bus/uacce/uacce.c
index d0ea454911..6e1eb73e68 100644
--- a/drivers/bus/uacce/uacce.c
+++ b/drivers/bus/uacce/uacce.c
@@ -477,7 +477,7 @@ uacce_cleanup(void)
 static int
 uacce_plug(struct rte_device *dev)
 {
-	return uacce_probe_all_drivers(RTE_DEV_TO_UACCE_DEV(dev));
+	return uacce_probe_all_drivers(RTE_BUS_DEVICE(dev, struct rte_uacce_device));
 }
 
 static int
@@ -503,7 +503,7 @@ uacce_detach_dev(struct rte_uacce_device *dev)
 static int
 uacce_unplug(struct rte_device *dev)
 {
-	struct rte_uacce_device *uacce_dev = RTE_DEV_TO_UACCE_DEV(dev);
+	struct rte_uacce_device *uacce_dev = RTE_BUS_DEVICE(dev, *uacce_dev);
 	int ret;
 
 	ret = uacce_detach_dev(uacce_dev);
@@ -523,7 +523,7 @@ uacce_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,  const void
 	struct rte_uacce_device *uacce_dev;
 
 	if (start != NULL) {
-		uacce_start = RTE_DEV_TO_UACCE_DEV_CONST(start);
+		uacce_start = RTE_BUS_DEVICE(start, *uacce_start);
 		uacce_dev = TAILQ_NEXT(uacce_start, next);
 	} else {
 		uacce_dev = TAILQ_FIRST(&uacce_bus.device_list);
diff --git a/drivers/bus/vdev/bus_vdev_driver.h b/drivers/bus/vdev/bus_vdev_driver.h
index 17efec51a3..f352daabda 100644
--- a/drivers/bus/vdev/bus_vdev_driver.h
+++ b/drivers/bus/vdev/bus_vdev_driver.h
@@ -8,6 +8,7 @@
 #include <rte_bus_vdev.h>
 #include <rte_compat.h>
 #include <dev_driver.h>
+#include <bus_driver.h>
 #include <rte_devargs.h>
 
 #ifdef __cplusplus
@@ -19,17 +20,8 @@ struct rte_vdev_device {
 	struct rte_device device;               /**< Inherit core device */
 };
 
-/**
- * @internal
- * Helper macro for drivers that need to convert to struct rte_vdev_device.
- */
-#define RTE_DEV_TO_VDEV(ptr) \
-	container_of(ptr, struct rte_vdev_device, device)
-
-#define RTE_DEV_TO_VDEV_CONST(ptr) \
-	container_of(ptr, const struct rte_vdev_device, device)
-
-#define RTE_ETH_DEV_TO_VDEV(eth_dev)	RTE_DEV_TO_VDEV((eth_dev)->device)
+#define RTE_ETH_DEV_TO_VDEV(eth_dev) \
+	RTE_BUS_DEVICE((eth_dev)->device, struct rte_vdev_device)
 
 static inline const char *
 rte_vdev_device_name(const struct rte_vdev_device *dev)
diff --git a/drivers/bus/vdev/vdev.c b/drivers/bus/vdev/vdev.c
index 906e9dbe08..ea81b755e3 100644
--- a/drivers/bus/vdev/vdev.c
+++ b/drivers/bus/vdev/vdev.c
@@ -141,11 +141,8 @@ vdev_parse(const char *name, void *addr)
 static int
 vdev_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 {
-	struct rte_vdev_device *vdev = RTE_DEV_TO_VDEV(dev);
-	const struct rte_vdev_driver *driver;
-
-	driver = container_of(vdev->device.driver, const struct rte_vdev_driver,
-			driver);
+	struct rte_vdev_device *vdev = RTE_BUS_DEVICE(dev, *vdev);
+	const struct rte_vdev_driver *driver = RTE_BUS_DRIVER(vdev->device.driver, *driver);
 
 	if (driver->dma_map != NULL)
 		return driver->dma_map(vdev, addr, iova, len);
@@ -156,11 +153,8 @@ vdev_dma_map(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 static int
 vdev_dma_unmap(struct rte_device *dev, void *addr, uint64_t iova, size_t len)
 {
-	struct rte_vdev_device *vdev = RTE_DEV_TO_VDEV(dev);
-	const struct rte_vdev_driver *driver;
-
-	driver = container_of(vdev->device.driver, const struct rte_vdev_driver,
-			driver);
+	struct rte_vdev_device *vdev = RTE_BUS_DEVICE(dev, *vdev);
+	const struct rte_vdev_driver *driver = RTE_BUS_DRIVER(vdev->device.driver, *driver);
 
 	if (driver->dma_unmap != NULL)
 		return driver->dma_unmap(vdev, addr, iova, len);
@@ -336,8 +330,8 @@ vdev_remove_driver(struct rte_vdev_device *dev)
 		return 1;
 	}
 
-	driver = container_of(dev->device.driver, const struct rte_vdev_driver,
-		driver);
+	driver = RTE_BUS_DRIVER(dev->device.driver, *driver);
+
 	return driver->remove(dev);
 }
 
@@ -572,7 +566,7 @@ vdev_cleanup(void)
 		if (!rte_dev_is_probed(&dev->device))
 			goto free;
 
-		drv = container_of(dev->device.driver, const struct rte_vdev_driver, driver);
+		drv = RTE_BUS_DRIVER(dev->device.driver, *drv);
 
 		if (drv->remove == NULL)
 			goto free;
@@ -599,7 +593,7 @@ rte_vdev_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
 
 	rte_spinlock_recursive_lock(&vdev_device_list_lock);
 	if (start != NULL) {
-		vstart = RTE_DEV_TO_VDEV_CONST(start);
+		vstart = RTE_BUS_DEVICE(start, *vstart);
 		dev = TAILQ_NEXT(vstart, next);
 	} else {
 		dev = TAILQ_FIRST(&vdev_device_list);
@@ -617,7 +611,7 @@ rte_vdev_find_device(const struct rte_device *start, rte_dev_cmp_t cmp,
 static int
 vdev_plug(struct rte_device *dev)
 {
-	return vdev_probe_all_drivers(RTE_DEV_TO_VDEV(dev));
+	return vdev_probe_all_drivers(RTE_BUS_DEVICE(dev, struct rte_vdev_device));
 }
 
 static int
diff --git a/drivers/common/mlx5/linux/mlx5_common_os.c b/drivers/common/mlx5/linux/mlx5_common_os.c
index fc7e9ecddc..e3db6c4124 100644
--- a/drivers/common/mlx5/linux/mlx5_common_os.c
+++ b/drivers/common/mlx5/linux/mlx5_common_os.c
@@ -719,9 +719,10 @@ mlx5_os_get_ibv_dev(const struct rte_device *dev)
 	struct ibv_device *ibv;
 
 	if (mlx5_dev_is_pci(dev))
-		ibv = mlx5_os_get_ibv_device(RTE_DEV_TO_PCI_CONST(dev));
+		ibv = mlx5_os_get_ibv_device(RTE_BUS_DEVICE(dev, const struct rte_pci_device));
 	else
-		ibv = mlx5_get_aux_ibv_device(RTE_DEV_TO_AUXILIARY_CONST(dev));
+		ibv = mlx5_get_aux_ibv_device(RTE_BUS_DEVICE(dev,
+			const struct rte_auxiliary_device));
 	if (ibv == NULL) {
 		rte_errno = ENODEV;
 		DRV_LOG(ERR, "Verbs device not found: %s", dev->name);
diff --git a/drivers/common/mlx5/mlx5_common.c b/drivers/common/mlx5/mlx5_common.c
index f71dbe4637..f87dc9d773 100644
--- a/drivers/common/mlx5/mlx5_common.c
+++ b/drivers/common/mlx5/mlx5_common.c
@@ -491,7 +491,7 @@ mlx5_dev_to_pci_str(const struct rte_device *dev, char *addr, size_t size)
 		return 0;
 	}
 #ifdef RTE_EXEC_ENV_LINUX
-	return mlx5_auxiliary_get_pci_str(RTE_DEV_TO_AUXILIARY_CONST(dev),
+	return mlx5_auxiliary_get_pci_str(RTE_BUS_DEVICE(dev, const struct rte_auxiliary_device),
 			addr, size);
 #else
 	rte_errno = ENODEV;
diff --git a/drivers/common/mlx5/mlx5_common_pci.c b/drivers/common/mlx5/mlx5_common_pci.c
index 8bd43bc166..f99e57f9f6 100644
--- a/drivers/common/mlx5/mlx5_common_pci.c
+++ b/drivers/common/mlx5/mlx5_common_pci.c
@@ -138,7 +138,7 @@ mlx5_dev_pci_match(const struct mlx5_class_driver *drv,
 
 	if (!mlx5_dev_is_pci(dev))
 		return false;
-	pci_dev = RTE_DEV_TO_PCI_CONST(dev);
+	pci_dev = RTE_BUS_DEVICE(dev, *pci_dev);
 	for (id_table = drv->id_table; id_table->vendor_id != 0;
 	     id_table++) {
 		/* Check if device's ids match the class driver's ids. */
diff --git a/drivers/common/mlx5/windows/mlx5_common_os.c b/drivers/common/mlx5/windows/mlx5_common_os.c
index 16fcc5f9fc..a3033f5305 100644
--- a/drivers/common/mlx5/windows/mlx5_common_os.c
+++ b/drivers/common/mlx5/windows/mlx5_common_os.c
@@ -180,7 +180,7 @@ mlx5_os_get_devx_device(struct rte_device *dev,
 			struct devx_device_bdf *devx_list, int n)
 {
 	struct devx_device_bdf *devx_match = NULL;
-	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(dev, *pci_dev);
 	struct rte_pci_addr *addr = &pci_dev->addr;
 
 	while (n-- > 0) {
diff --git a/drivers/compress/octeontx/otx_zip.c b/drivers/compress/octeontx/otx_zip.c
index 331d2d9475..8673561a81 100644
--- a/drivers/compress/octeontx/otx_zip.c
+++ b/drivers/compress/octeontx/otx_zip.c
@@ -142,7 +142,7 @@ zipvf_push_command(struct zipvf_qp *qp, union zip_inst_s *cmd)
 int
 zipvf_create(struct rte_compressdev *compressdev)
 {
-	struct   rte_pci_device *pdev = RTE_DEV_TO_PCI(compressdev->device);
+	struct   rte_pci_device *pdev = RTE_BUS_DEVICE(compressdev->device, *pdev);
 	struct   zip_vf *zipvf = NULL;
 	char     *dev_name = compressdev->data->name;
 	void     *vbar0;
diff --git a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
index 2f9eb322dc..f437350539 100644
--- a/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
+++ b/drivers/crypto/cnxk/cnxk_cryptodev_ops.c
@@ -481,7 +481,7 @@ cnxk_cpt_queue_pair_setup(struct rte_cryptodev *dev, uint16_t qp_id,
 	if (dev->data->queue_pairs[qp_id] != NULL)
 		cnxk_cpt_queue_pair_release(dev, qp_id);
 
-	pci_dev = RTE_DEV_TO_PCI(dev->device);
+	pci_dev = RTE_BUS_DEVICE(dev->device, *pci_dev);
 
 	if (pci_dev->mem_resource[2].addr == NULL) {
 		plt_err("Invalid PCI mem address");
diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index 995e375fb5..d7b53723e7 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -4392,7 +4392,7 @@ dpaa2_sec_dev_init(struct rte_cryptodev *cryptodev)
 	int retcode, hw_id;
 
 	PMD_INIT_FUNC_TRACE();
-	dpaa2_dev = container_of(dev, struct rte_dpaa2_device, device);
+	dpaa2_dev = RTE_BUS_DEVICE(dev, *dpaa2_dev);
 	hw_id = dpaa2_dev->object_id;
 
 	cryptodev->driver_id = cryptodev_driver_id;
diff --git a/drivers/crypto/octeontx/otx_cryptodev_ops.c b/drivers/crypto/octeontx/otx_cryptodev_ops.c
index 88657f49cc..a499c8d0bc 100644
--- a/drivers/crypto/octeontx/otx_cryptodev_ops.c
+++ b/drivers/crypto/octeontx/otx_cryptodev_ops.c
@@ -156,7 +156,7 @@ otx_cpt_que_pair_setup(struct rte_cryptodev *dev,
 			     DEFAULT_CMD_QLEN);
 	}
 
-	pci_dev = RTE_DEV_TO_PCI(dev->device);
+	pci_dev = RTE_BUS_DEVICE(dev->device, *pci_dev);
 
 	if (pci_dev->mem_resource[0].addr == NULL) {
 		CPT_LOG_ERR("PCI mem address null");
@@ -1001,7 +1001,7 @@ static struct rte_cryptodev_ops cptvf_ops = {
 int
 otx_cpt_dev_create(struct rte_cryptodev *c_dev)
 {
-	struct rte_pci_device *pdev = RTE_DEV_TO_PCI(c_dev->device);
+	struct rte_pci_device *pdev = RTE_BUS_DEVICE(c_dev->device, *pdev);
 	struct cpt_vf *cptvf = NULL;
 	void *reg_base;
 	char dev_name[32];
diff --git a/drivers/event/cnxk/cnxk_eventdev.c b/drivers/event/cnxk/cnxk_eventdev.c
index be6a487b59..8eff2ba8e0 100644
--- a/drivers/event/cnxk/cnxk_eventdev.c
+++ b/drivers/event/cnxk/cnxk_eventdev.c
@@ -654,7 +654,7 @@ cnxk_sso_init(struct rte_eventdev *event_dev)
 		return -ENOMEM;
 	}
 
-	pci_dev = container_of(event_dev->dev, struct rte_pci_device, device);
+	pci_dev = RTE_BUS_DEVICE(event_dev->dev, *pci_dev);
 	dev->sso.pci_dev = pci_dev;
 
 	*(uint64_t *)mz->addr = (uint64_t)dev;
diff --git a/drivers/event/dlb2/pf/dlb2_pf.c b/drivers/event/dlb2/pf/dlb2_pf.c
index edcdfb319f..a498ba8c41 100644
--- a/drivers/event/dlb2/pf/dlb2_pf.c
+++ b/drivers/event/dlb2/pf/dlb2_pf.c
@@ -784,7 +784,7 @@ dlb2_eventdev_pci_init(struct rte_eventdev *eventdev)
 
 	dlb2_pf_iface_fn_ptrs_init();
 
-	pci_dev = RTE_DEV_TO_PCI(eventdev->dev);
+	pci_dev = RTE_BUS_DEVICE(eventdev->dev, *pci_dev);
 
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		dlb2 = dlb2_pmd_priv(eventdev); /* rte_zmalloc_socket mem */
diff --git a/drivers/event/skeleton/skeleton_eventdev.c b/drivers/event/skeleton/skeleton_eventdev.c
index 73a1e4e008..e07744d2f1 100644
--- a/drivers/event/skeleton/skeleton_eventdev.c
+++ b/drivers/event/skeleton/skeleton_eventdev.c
@@ -332,7 +332,7 @@ skeleton_eventdev_init(struct rte_eventdev *eventdev)
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return 0;
 
-	pci_dev = RTE_DEV_TO_PCI(eventdev->dev);
+	pci_dev = RTE_BUS_DEVICE(eventdev->dev, *pci_dev);
 
 	skel->reg_base = (uintptr_t)pci_dev->mem_resource[0].addr;
 	if (!skel->reg_base) {
diff --git a/drivers/net/axgbe/axgbe_ethdev.c b/drivers/net/axgbe/axgbe_ethdev.c
index cfcd880961..c14d04a11d 100644
--- a/drivers/net/axgbe/axgbe_ethdev.c
+++ b/drivers/net/axgbe/axgbe_ethdev.c
@@ -2230,7 +2230,7 @@ eth_axgbe_dev_init(struct rte_eth_dev *eth_dev)
 	rte_bit_relaxed_set32(AXGBE_STOPPED, &pdata->dev_state);
 	pdata->eth_dev = eth_dev;
 
-	pci_dev = RTE_DEV_TO_PCI(eth_dev->device);
+	pci_dev = RTE_BUS_DEVICE(eth_dev->device, *pci_dev);
 	pdata->pci_dev = pci_dev;
 
 	pdata->xgmac_regs =
@@ -2453,7 +2453,7 @@ axgbe_dev_close(struct rte_eth_dev *eth_dev)
 		return 0;
 
 	pdata = eth_dev->data->dev_private;
-	pci_dev = RTE_DEV_TO_PCI(eth_dev->device);
+	pci_dev = RTE_BUS_DEVICE(eth_dev->device, *pci_dev);
 	axgbe_dev_clear_queues(eth_dev);
 
 	/* disable uio intr before callback unregister */
diff --git a/drivers/net/bnx2x/bnx2x_ethdev.c b/drivers/net/bnx2x/bnx2x_ethdev.c
index 5e2e555525..7b96e1acee 100644
--- a/drivers/net/bnx2x/bnx2x_ethdev.c
+++ b/drivers/net/bnx2x/bnx2x_ethdev.c
@@ -639,7 +639,7 @@ bnx2x_common_dev_init(struct rte_eth_dev *eth_dev, int is_vf)
 
 	/* Extract key data structures */
 	sc = eth_dev->data->dev_private;
-	pci_dev = RTE_DEV_TO_PCI(eth_dev->device);
+	pci_dev = RTE_BUS_DEVICE(eth_dev->device, *pci_dev);
 	pci_addr = pci_dev->addr;
 
 	snprintf(sc->devinfo.name, NAME_SIZE, PCI_SHORT_PRI_FMT ":dpdk-port-%u",
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index b677f9491d..071093aabc 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -1167,7 +1167,7 @@ uint64_t bnxt_eth_rss_support(struct bnxt *bp)
 static int bnxt_dev_info_get_op(struct rte_eth_dev *eth_dev,
 				struct rte_eth_dev_info *dev_info)
 {
-	struct rte_pci_device *pdev = RTE_DEV_TO_PCI(eth_dev->device);
+	struct rte_pci_device *pdev = RTE_BUS_DEVICE(eth_dev->device, *pdev);
 	struct bnxt *bp = eth_dev->data->dev_private;
 	uint16_t max_vnics, i, j, vpool, vrxq;
 	unsigned int max_rx_rings;
diff --git a/drivers/net/bnxt/tf_ulp/bnxt_ulp.c b/drivers/net/bnxt/tf_ulp/bnxt_ulp.c
index 0c03ae7a83..e1e2c0e878 100644
--- a/drivers/net/bnxt/tf_ulp/bnxt_ulp.c
+++ b/drivers/net/bnxt/tf_ulp/bnxt_ulp.c
@@ -192,7 +192,7 @@ ulp_session_init(struct bnxt *bp,
 	if (!bp)
 		return NULL;
 
-	pci_dev = RTE_DEV_TO_PCI(bp->eth_dev->device);
+	pci_dev = RTE_BUS_DEVICE(bp->eth_dev->device, *pci_dev);
 	pci_addr = &pci_dev->addr;
 
 	pthread_mutex_lock(&bnxt_ulp_global_mutex);
@@ -556,7 +556,7 @@ bnxt_ulp_port_deinit(struct bnxt *bp)
 		     bp->eth_dev->data->port_id);
 
 	/* Get the session details  */
-	pci_dev = RTE_DEV_TO_PCI(bp->eth_dev->device);
+	pci_dev = RTE_BUS_DEVICE(bp->eth_dev->device, *pci_dev);
 	pci_addr = &pci_dev->addr;
 	pthread_mutex_lock(&bnxt_ulp_global_mutex);
 	session = ulp_get_session(bp, pci_addr);
diff --git a/drivers/net/bonding/rte_eth_bond_args.c b/drivers/net/bonding/rte_eth_bond_args.c
index bdec5d61d4..4fbd25cd33 100644
--- a/drivers/net/bonding/rte_eth_bond_args.c
+++ b/drivers/net/bonding/rte_eth_bond_args.c
@@ -26,7 +26,7 @@ const char *pmd_bond_init_valid_arguments[] = {
 static inline int
 bond_pci_addr_cmp(const struct rte_device *dev, const void *_pci_addr)
 {
-	const struct rte_pci_device *pdev = RTE_DEV_TO_PCI_CONST(dev);
+	const struct rte_pci_device *pdev = RTE_BUS_DEVICE(dev, *pdev);
 	const struct rte_pci_addr *paddr = _pci_addr;
 
 	return rte_pci_addr_cmp(&pdev->addr, paddr);
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index dcde3ba2c7..d4b4793f16 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -230,7 +230,7 @@ dpaa_eth_dev_configure(struct rte_eth_dev *dev)
 
 	PMD_INIT_FUNC_TRACE();
 
-	dpaa_dev = container_of(rdev, struct rte_dpaa_device, device);
+	dpaa_dev = RTE_BUS_DEVICE(rdev, *dpaa_dev);
 	intr_handle = dpaa_dev->intr_handle;
 	__fif = container_of(fif, struct __fman_if, __if);
 
@@ -432,7 +432,7 @@ static void dpaa_interrupt_handler(void *param)
 	uint64_t buf;
 	int bytes_read;
 
-	dpaa_dev = container_of(rdev, struct rte_dpaa_device, device);
+	dpaa_dev = RTE_BUS_DEVICE(rdev, *dpaa_dev);
 	intr_handle = dpaa_dev->intr_handle;
 
 	if (rte_intr_fd_get(intr_handle) < 0)
@@ -530,7 +530,7 @@ static int dpaa_eth_dev_close(struct rte_eth_dev *dev)
 		}
 	}
 
-	dpaa_dev = container_of(rdev, struct rte_dpaa_device, device);
+	dpaa_dev = RTE_BUS_DEVICE(rdev, *dpaa_dev);
 	intr_handle = dpaa_dev->intr_handle;
 	__fif = container_of(fif, struct __fman_if, __if);
 
@@ -1269,8 +1269,7 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 			struct rte_dpaa_device *dpaa_dev;
 			struct rte_device *rdev = dev->device;
 
-			dpaa_dev = container_of(rdev, struct rte_dpaa_device,
-				device);
+			dpaa_dev = RTE_BUS_DEVICE(rdev, *dpaa_dev);
 			dev->intr_handle = dpaa_dev->intr_handle;
 			if (rte_intr_vec_list_alloc(dev->intr_handle,
 					NULL, dpaa_push_queue_max_num())) {
@@ -2120,7 +2119,7 @@ dpaa_dev_init_secondary(struct rte_eth_dev *eth_dev)
 
 	PMD_INIT_FUNC_TRACE();
 
-	dpaa_device = DEV_TO_DPAA_DEVICE(eth_dev->device);
+	dpaa_device = RTE_BUS_DEVICE(eth_dev->device, *dpaa_device);
 	dev_id = dpaa_device->id.dev_id;
 	cfg = dpaa_get_eth_port_cfg(dev_id);
 	fman_intf = cfg->fman_if;
@@ -2237,7 +2236,7 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 
 	PMD_INIT_FUNC_TRACE();
 
-	dpaa_device = DEV_TO_DPAA_DEVICE(eth_dev->device);
+	dpaa_device = RTE_BUS_DEVICE(eth_dev->device, *dpaa_device);
 	dev_id = dpaa_device->id.dev_id;
 	dpaa_intf = eth_dev->data->dev_private;
 	cfg = dpaa_get_eth_port_cfg(dev_id);
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 9cc81f7a47..dc9ea700ac 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -1351,7 +1351,7 @@ dpaa2_dev_start(struct rte_eth_dev *dev)
 	int ret, i;
 	struct rte_intr_handle *intr_handle;
 
-	dpaa2_dev = container_of(rdev, struct rte_dpaa2_device, device);
+	dpaa2_dev = RTE_BUS_DEVICE(rdev, *dpaa2_dev);
 	intr_handle = dpaa2_dev->intr_handle;
 
 	PMD_INIT_FUNC_TRACE();
@@ -1463,7 +1463,7 @@ dpaa2_dev_stop(struct rte_eth_dev *dev)
 	struct rte_dpaa2_device *dpaa2_dev;
 	uint16_t i;
 
-	dpaa2_dev = container_of(rdev, struct rte_dpaa2_device, device);
+	dpaa2_dev = RTE_BUS_DEVICE(rdev, *dpaa2_dev);
 	intr_handle = dpaa2_dev->intr_handle;
 
 	PMD_INIT_FUNC_TRACE();
@@ -2918,7 +2918,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		return 0;
 	}
 
-	dpaa2_dev = container_of(dev, struct rte_dpaa2_device, device);
+	dpaa2_dev = RTE_BUS_DEVICE(dev, *dpaa2_dev);
 
 	hw_id = dpaa2_dev->object_id;
 	ret = dpni_open(dpni_dev, CMD_PRI_LOW, hw_id, &priv->token);
diff --git a/drivers/net/dpaa2/dpaa2_recycle.c b/drivers/net/dpaa2/dpaa2_recycle.c
index 1893979748..14416c41d0 100644
--- a/drivers/net/dpaa2/dpaa2_recycle.c
+++ b/drivers/net/dpaa2/dpaa2_recycle.c
@@ -609,8 +609,7 @@ dpaa2_dev_recycle_config(struct rte_eth_dev *eth_dev)
 {
 	struct rte_device *dev = eth_dev->device;
 	struct dpaa2_dev_priv *priv = eth_dev->data->dev_private;
-	struct rte_dpaa2_device *dpaa2_dev =
-			container_of(dev, struct rte_dpaa2_device, device);
+	struct rte_dpaa2_device *dpaa2_dev = RTE_BUS_DEVICE(dev, *dpaa2_dev);
 	struct fsl_mc_io *dpni_dev = eth_dev->process_private;
 	struct dpni_port_cfg port_cfg;
 	int ret;
@@ -677,8 +676,7 @@ dpaa2_dev_recycle_deconfig(struct rte_eth_dev *eth_dev)
 {
 	struct rte_device *dev = eth_dev->device;
 	struct dpaa2_dev_priv *priv = eth_dev->data->dev_private;
-	struct rte_dpaa2_device *dpaa2_dev =
-			container_of(dev, struct rte_dpaa2_device, device);
+	struct rte_dpaa2_device *dpaa2_dev = RTE_BUS_DEVICE(dev, *dpaa2_dev);
 	struct fsl_mc_io *dpni_dev = eth_dev->process_private;
 	struct dpni_port_cfg port_cfg;
 	int ret = 0;
diff --git a/drivers/net/gve/gve_ethdev.c b/drivers/net/gve/gve_ethdev.c
index 6ce3ef3938..73f4935b1f 100644
--- a/drivers/net/gve/gve_ethdev.c
+++ b/drivers/net/gve/gve_ethdev.c
@@ -1410,7 +1410,7 @@ gve_dev_init(struct rte_eth_dev *eth_dev)
 		return 0;
 	}
 
-	pci_dev = RTE_DEV_TO_PCI(eth_dev->device);
+	pci_dev = RTE_BUS_DEVICE(eth_dev->device, *pci_dev);
 
 	reg_bar = pci_dev->mem_resource[GVE_REG_BAR].addr;
 	if (!reg_bar) {
diff --git a/drivers/net/hns3/hns3_ethdev.c b/drivers/net/hns3/hns3_ethdev.c
index b2eab7e1c5..a66fc5d81a 100644
--- a/drivers/net/hns3/hns3_ethdev.c
+++ b/drivers/net/hns3/hns3_ethdev.c
@@ -4527,7 +4527,7 @@ static int
 hns3_init_pf(struct rte_eth_dev *eth_dev)
 {
 	struct rte_device *dev = eth_dev->device;
-	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(dev, *pci_dev);
 	struct hns3_adapter *hns = eth_dev->data->dev_private;
 	struct hns3_hw *hw = &hns->hw;
 	int ret;
@@ -4657,7 +4657,7 @@ hns3_uninit_pf(struct rte_eth_dev *eth_dev)
 {
 	struct hns3_adapter *hns = eth_dev->data->dev_private;
 	struct rte_device *dev = eth_dev->device;
-	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(dev);
+	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(dev, *pci_dev);
 	struct hns3_hw *hw = &hns->hw;
 
 	PMD_INIT_FUNC_TRACE();
diff --git a/drivers/net/hns3/hns3_rxtx.c b/drivers/net/hns3/hns3_rxtx.c
index 573604b0cd..3528fda8a5 100644
--- a/drivers/net/hns3/hns3_rxtx.c
+++ b/drivers/net/hns3/hns3_rxtx.c
@@ -3066,7 +3066,7 @@ hns3_tx_push_get_queue_tail_reg(struct rte_eth_dev *dev, uint16_t queue_id)
 #define HNS3_TX_PUSH_QUICK_DOORBELL_OFFSET	64
 #define HNS3_TX_PUSH_PCI_BAR_INDEX		4
 
-	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(dev->device);
+	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(dev->device, *pci_dev);
 	uint8_t bar_id = HNS3_TX_PUSH_PCI_BAR_INDEX;
 
 	/*
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.c b/drivers/net/intel/cpfl/cpfl_ethdev.c
index 617b823f5a..03599e6432 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.c
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.c
@@ -2764,7 +2764,7 @@ cpfl_dev_vport_init(struct rte_eth_dev *dev, void *init_params)
 	uint8_t p2p_q_vc_out_info[IDPF_DFLT_MBX_BUF_SIZE] = {0};
 	struct cpfl_vport_id vi;
 	struct cpchnl2_vport_id v_id;
-	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(dev->device);
+	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(dev->device, *pci_dev);
 	int ret = 0;
 
 	dev->dev_ops = &cpfl_eth_dev_ops;
@@ -2836,7 +2836,7 @@ cpfl_dev_vport_init(struct rte_eth_dev *dev, void *init_params)
 	}
 	/* get the vport info */
 	if (adapter->base.hw.device_id == IXD_DEV_ID_VCPF) {
-		pci_dev = RTE_DEV_TO_PCI(dev->device);
+		pci_dev = RTE_BUS_DEVICE(dev->device, *pci_dev);
 		vi.func_type = VCPF_CPCHNL2_FTYPE_LAN_VF;
 		vi.pf_id = CPFL_HOST0_CPF_ID;
 		vi.vf_id = pci_dev->addr.function;
diff --git a/drivers/net/intel/cpfl/cpfl_ethdev.h b/drivers/net/intel/cpfl/cpfl_ethdev.h
index e05a0901d5..56f8f39829 100644
--- a/drivers/net/intel/cpfl/cpfl_ethdev.h
+++ b/drivers/net/intel/cpfl/cpfl_ethdev.h
@@ -298,7 +298,7 @@ int vcpf_add_queues(struct cpfl_adapter_ext *adapter);
 int vcpf_del_queues(struct cpfl_adapter_ext *adapter);
 
 #define CPFL_DEV_TO_PCI(eth_dev)		\
-	RTE_DEV_TO_PCI((eth_dev)->device)
+	RTE_BUS_DEVICE((eth_dev)->device, struct rte_pci_device)
 #define CPFL_ADAPTER_TO_EXT(p)					\
 	container_of((p), struct cpfl_adapter_ext, base)
 #define CPFL_DEV_TO_VPORT(dev)					\
diff --git a/drivers/net/intel/i40e/i40e_ethdev.h b/drivers/net/intel/i40e/i40e_ethdev.h
index d57c53f661..dcbdf65047 100644
--- a/drivers/net/intel/i40e/i40e_ethdev.h
+++ b/drivers/net/intel/i40e/i40e_ethdev.h
@@ -1467,7 +1467,7 @@ int i40e_vf_representor_init(struct rte_eth_dev *ethdev, void *init_params);
 int i40e_vf_representor_uninit(struct rte_eth_dev *ethdev);
 
 #define I40E_DEV_TO_PCI(eth_dev) \
-	RTE_DEV_TO_PCI((eth_dev)->device)
+	RTE_BUS_DEVICE((eth_dev)->device, struct rte_pci_device)
 
 /* I40E_DEV_PRIVATE_TO */
 #define I40E_DEV_PRIVATE_TO_PF(adapter) \
diff --git a/drivers/net/intel/ice/ice_ethdev.c b/drivers/net/intel/ice/ice_ethdev.c
index 0f2e7aee14..715d1522f9 100644
--- a/drivers/net/intel/ice/ice_ethdev.c
+++ b/drivers/net/intel/ice/ice_ethdev.c
@@ -2623,7 +2623,7 @@ ice_dev_init(struct rte_eth_dev *dev)
 	}
 
 	ice_set_default_ptype_table(dev);
-	pci_dev = RTE_DEV_TO_PCI(dev->device);
+	pci_dev = RTE_BUS_DEVICE(dev->device, *pci_dev);
 	intr_handle = pci_dev->intr_handle;
 
 	pf->adapter = ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
@@ -4520,7 +4520,7 @@ ice_dev_info_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	struct ice_pf *pf = ICE_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	struct ice_hw *hw = ICE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
 	struct ice_vsi *vsi = pf->main_vsi;
-	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(dev->device);
+	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(dev->device, *pci_dev);
 	bool is_safe_mode = pf->adapter->is_safe_mode;
 	u64 phy_type_low;
 	u64 phy_type_high;
diff --git a/drivers/net/intel/ice/ice_ethdev.h b/drivers/net/intel/ice/ice_ethdev.h
index 4b3718f715..ea73f8bcb3 100644
--- a/drivers/net/intel/ice/ice_ethdev.h
+++ b/drivers/net/intel/ice/ice_ethdev.h
@@ -708,7 +708,7 @@ struct ice_vsi_vlan_pvid_info {
 };
 
 #define ICE_DEV_TO_PCI(eth_dev) \
-	RTE_DEV_TO_PCI((eth_dev)->device)
+	RTE_BUS_DEVICE((eth_dev)->device, struct rte_pci_device)
 
 /* ICE_DEV_PRIVATE_TO */
 #define ICE_DEV_PRIVATE_TO_PF(adapter) \
diff --git a/drivers/net/intel/idpf/idpf_ethdev.h b/drivers/net/intel/idpf/idpf_ethdev.h
index 3c2c932438..5105eea1c5 100644
--- a/drivers/net/intel/idpf/idpf_ethdev.h
+++ b/drivers/net/intel/idpf/idpf_ethdev.h
@@ -85,7 +85,7 @@ struct idpf_adapter_ext {
 TAILQ_HEAD(idpf_adapter_list, idpf_adapter_ext);
 
 #define IDPF_DEV_TO_PCI(eth_dev)		\
-	RTE_DEV_TO_PCI((eth_dev)->device)
+	RTE_BUS_DEVICE((eth_dev)->device, struct rte_pci_device)
 #define IDPF_ADAPTER_TO_EXT(p)					\
 	container_of((p), struct idpf_adapter_ext, base)
 
diff --git a/drivers/net/intel/ipn3ke/ipn3ke_ethdev.h b/drivers/net/intel/ipn3ke/ipn3ke_ethdev.h
index 4b93d2649e..6d531120b8 100644
--- a/drivers/net/intel/ipn3ke/ipn3ke_ethdev.h
+++ b/drivers/net/intel/ipn3ke/ipn3ke_ethdev.h
@@ -310,18 +310,8 @@ struct ipn3ke_hw {
 	uint8_t *hw_addr;
 };
 
-/**
- * @internal
- * Helper macro for drivers that need to convert to struct rte_afu_device.
- */
-#define RTE_DEV_TO_AFU(ptr) \
-	container_of(ptr, struct rte_afu_device, device)
-
-#define RTE_DEV_TO_AFU_CONST(ptr) \
-	container_of(ptr, const struct rte_afu_device, device)
-
 #define RTE_ETH_DEV_TO_AFU(eth_dev) \
-	RTE_DEV_TO_AFU((eth_dev)->device)
+	RTE_BUS_DEVICE((eth_dev)->device, struct rte_afu_device)
 
 /**
  * PCIe MMIO Access
diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index a717191002..d9923e327c 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -171,7 +171,8 @@ mlx5_os_capabilities_prepare(struct mlx5_dev_ctx_shared *sh)
 	}
 	memset(&sh->dev_cap, 0, sizeof(struct mlx5_dev_cap));
 	if (mlx5_dev_is_pci(cdev->dev))
-		sh->dev_cap.vf = mlx5_dev_is_vf_pci(RTE_DEV_TO_PCI(cdev->dev));
+		sh->dev_cap.vf = mlx5_dev_is_vf_pci(RTE_BUS_DEVICE(cdev->dev,
+			struct rte_pci_device));
 	else
 		sh->dev_cap.sf = 1;
 	sh->dev_cap.max_qp_wr = attr_ex.orig_attr.max_qp_wr;
@@ -2504,7 +2505,7 @@ mlx5_os_pci_probe_pf(struct mlx5_common_device *cdev,
 	 *  >= 0 - MPESW device. Value is the port index of the MPESW owner.
 	 */
 	int mpesw = MLX5_MPESW_PORT_INVALID;
-	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(cdev->dev);
+	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(cdev->dev, *pci_dev);
 	struct mlx5_dev_spawn_data *list = NULL;
 	struct rte_eth_devargs eth_da = *req_eth_da;
 	struct rte_pci_addr owner_pci = pci_dev->addr; /* Owner PF. */
@@ -3067,7 +3068,7 @@ static int
 mlx5_os_pci_probe(struct mlx5_common_device *cdev,
 		  struct mlx5_kvargs_ctrl *mkvlist)
 {
-	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(cdev->dev);
+	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(cdev->dev, *pci_dev);
 	struct rte_eth_devargs eth_da = { .nb_ports = 0 };
 	int ret = 0;
 	uint16_t p;
@@ -3109,7 +3110,7 @@ mlx5_os_auxiliary_probe(struct mlx5_common_device *cdev,
 		.mpesw_port = MLX5_MPESW_PORT_INVALID,
 	};
 	struct rte_device *dev = cdev->dev;
-	struct rte_auxiliary_device *adev = RTE_DEV_TO_AUXILIARY(dev);
+	struct rte_auxiliary_device *adev = RTE_BUS_DEVICE(dev, *adev);
 	struct rte_eth_dev *eth_dev;
 	int ret = 0;
 
diff --git a/drivers/net/mlx5/windows/mlx5_os.c b/drivers/net/mlx5/windows/mlx5_os.c
index 4952b674c0..4f3eb2b756 100644
--- a/drivers/net/mlx5/windows/mlx5_os.c
+++ b/drivers/net/mlx5/windows/mlx5_os.c
@@ -168,7 +168,7 @@ mlx5_os_capabilities_prepare(struct mlx5_dev_ctx_shared *sh)
 		return -rte_errno;
 	}
 	memset(&sh->dev_cap, 0, sizeof(struct mlx5_dev_cap));
-	sh->dev_cap.vf = mlx5_dev_is_vf_pci(RTE_DEV_TO_PCI(sh->cdev->dev));
+	sh->dev_cap.vf = mlx5_dev_is_vf_pci(RTE_BUS_DEVICE(sh->cdev->dev), struct rte_pci_device);
 	sh->dev_cap.max_cq = 1 << hca_attr->log_max_cq;
 	sh->dev_cap.max_qp = 1 << hca_attr->log_max_qp;
 	sh->dev_cap.max_qp_wr = 1 << hca_attr->log_max_qp_sz;
@@ -846,7 +846,7 @@ int
 mlx5_os_net_probe(struct mlx5_common_device *cdev,
 		  struct mlx5_kvargs_ctrl *mkvlist)
 {
-	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(cdev->dev);
+	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(cdev->dev, *pci_dev);
 	struct mlx5_dev_spawn_data spawn = {
 		.pf_bond = -1,
 		.max_port = 1,
diff --git a/drivers/net/netvsc/hn_ethdev.c b/drivers/net/netvsc/hn_ethdev.c
index b8880edb4c..fa936cfde7 100644
--- a/drivers/net/netvsc/hn_ethdev.c
+++ b/drivers/net/netvsc/hn_ethdev.c
@@ -1536,7 +1536,7 @@ eth_hn_dev_init(struct rte_eth_dev *eth_dev)
 	rte_spinlock_init(&hv->hotadd_lock);
 	LIST_INIT(&hv->hotadd_list);
 
-	vmbus = container_of(device, struct rte_vmbus_device, device);
+	vmbus = RTE_BUS_DEVICE(device, *vmbus);
 	eth_dev->dev_ops = &hn_eth_dev_ops;
 	eth_dev->rx_queue_count = hn_dev_rx_queue_count;
 	eth_dev->rx_descriptor_status = hn_dev_rx_queue_status;
diff --git a/drivers/net/qede/qede_ethdev.c b/drivers/net/qede/qede_ethdev.c
index e1c28a0ac2..c676c6fa75 100644
--- a/drivers/net/qede/qede_ethdev.c
+++ b/drivers/net/qede/qede_ethdev.c
@@ -1231,7 +1231,7 @@ static int qede_args_check(const char *key, const char *val, void *opaque)
 
 static int qede_args(struct rte_eth_dev *eth_dev)
 {
-	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI(eth_dev->device);
+	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE(eth_dev->device, *pci_dev);
 	struct rte_kvargs *kvlist;
 	struct rte_devargs *devargs;
 	int ret;
diff --git a/drivers/net/rnp/rnp_ethdev.c b/drivers/net/rnp/rnp_ethdev.c
index bb5a0cabb1..15a976ac85 100644
--- a/drivers/net/rnp/rnp_ethdev.c
+++ b/drivers/net/rnp/rnp_ethdev.c
@@ -728,7 +728,7 @@ static int rnp_dev_close(struct rte_eth_dev *eth_dev)
 	if (adapter->intr_registered && adapter->eth_dev == eth_dev)
 		rnp_change_manage_port(adapter);
 	if (adapter->closed_ports == adapter->inited_ports) {
-		struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI((void *)eth_dev->device);
+		struct rte_pci_device *pci_dev = RTE_BUS_DEVICE((void *)eth_dev->device, *pci_dev);
 		if (adapter->intr_registered) {
 			/* disable uio irq before callback unregister */
 			rte_intr_disable(pci_dev->intr_handle);
@@ -1667,7 +1667,7 @@ rnp_rx_reset_pool_setup(struct rnp_eth_adapter *adapter)
 static int
 rnp_eth_dev_init(struct rte_eth_dev *eth_dev)
 {
-	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI((void *)eth_dev->device);
+	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE((void *)eth_dev->device, *pci_dev);
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct rnp_eth_port *port = RNP_DEV_TO_PORT(eth_dev);
 	char name[RTE_ETH_NAME_MAX_LEN] = " ";
@@ -1798,7 +1798,7 @@ rnp_eth_dev_init(struct rte_eth_dev *eth_dev)
 static int
 rnp_eth_dev_uninit(struct rte_eth_dev *eth_dev)
 {
-	struct rte_pci_device *pci_dev = RTE_DEV_TO_PCI((void *)eth_dev->device);
+	struct rte_pci_device *pci_dev = RTE_BUS_DEVICE((void *)eth_dev->device, *pci_dev);
 	uint16_t port_id;
 	int err = 0;
 
diff --git a/drivers/raw/ifpga/afu_pmd_n3000.c b/drivers/raw/ifpga/afu_pmd_n3000.c
index b4c2f0d0a8..f092ee2dec 100644
--- a/drivers/raw/ifpga/afu_pmd_n3000.c
+++ b/drivers/raw/ifpga/afu_pmd_n3000.c
@@ -1467,11 +1467,11 @@ static struct rte_pci_device *n3000_afu_get_pci_dev(struct afu_rawdev *dev)
 	if (!dev || !dev->rawdev || !dev->rawdev->device)
 		return NULL;
 
-	afudev = RTE_DEV_TO_AFU(dev->rawdev->device);
+	afudev = RTE_BUS_DEVICE(dev->rawdev->device, *afudev);
 	if (!afudev->rawdev || !afudev->rawdev->device)
 		return NULL;
 
-	return RTE_DEV_TO_PCI(afudev->rawdev->device);
+	return RTE_BUS_DEVICE(afudev->rawdev->device, struct rte_pci_device);
 }
 
 static int dma_afu_set_irqs(struct afu_rawdev *dev, uint32_t vec_start,
diff --git a/lib/eal/include/bus_driver.h b/lib/eal/include/bus_driver.h
index 72783de59c..71346fb8b2 100644
--- a/lib/eal/include/bus_driver.h
+++ b/lib/eal/include/bus_driver.h
@@ -340,6 +340,36 @@ RTE_INIT_PRIO(businitfn_ ##nm, BUS) \
 __rte_internal
 void rte_bus_unregister(struct rte_bus *bus);
 
+/**
+ * Helper macro to convert a generic device pointer to a bus-specific device type.
+ * Uses typeof to automatically determine the bus-specific type from the second argument.
+ *
+ * @param dev
+ *   Generic rte_device pointer to convert
+ * @param bus_dev_type
+ *   Type expression: either a struct type (e.g., struct rte_pci_device) or
+ *   a dereferenced pointer (e.g., *pdev) for type inference
+ * @return
+ *   Pointer to the bus-specific device structure containing this rte_device
+ */
+#define RTE_BUS_DEVICE(dev, bus_dev_type) \
+	container_of(dev, typeof(bus_dev_type), device)
+
+/**
+ * Helper macro to convert a generic driver pointer to a bus-specific driver type.
+ * Uses typeof to automatically determine the bus-specific type from the second argument.
+ *
+ * @param drv
+ *   Generic rte_driver pointer to convert
+ * @param bus_drv_type
+ *   Type expression: either a struct type (e.g., struct rte_pci_driver) or
+ *   a dereferenced pointer (e.g., *pdrv) for type inference
+ * @return
+ *   Pointer to the bus-specific driver structure containing this rte_driver
+ */
+#define RTE_BUS_DRIVER(drv, bus_drv_type) \
+	container_of(drv, typeof(bus_drv_type), driver)
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.53.0

