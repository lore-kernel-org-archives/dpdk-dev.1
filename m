Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A3B9C369B1
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Apr 2025 06:12:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 96D89406B8;
	Wed, 16 Apr 2025 08:12:39 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id E4F7340279
 for <dev@dpdk.org>; Wed, 16 Apr 2025 08:12:37 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744783957;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=S1HgBlSUv7AK8C0dr3BLxOA+o071+pL7coWkCm/bZh0=;
 b=OKUaEYRv7BvcqAa3ujTR7htYdVKva3kklUrSBsc8FwQNkN6wt5uKuTuLxLh+jOpr0DwM++
 qgZxYBUGVEUSkVANdCY0gHYynWBzS9yPSI5jZtfFMGT29+vkJXkQXIwXYDx8lztZaS38B4
 W7izo/zyBWU/h3Dm6Lcr2BTt8ACV/is=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-467-IDapRocQP3KaM6foKN-sAA-1; Wed,
 16 Apr 2025 02:12:31 -0400
X-MC-Unique: IDapRocQP3KaM6foKN-sAA-1
X-Mimecast-MFC-AGG-ID: IDapRocQP3KaM6foKN-sAA_1744783950
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A237C1800446; Wed, 16 Apr 2025 06:12:29 +0000 (UTC)
Received: from dmarchan.lan (unknown [10.44.33.15])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id A7E7519560A3; Wed, 16 Apr 2025 06:12:25 +0000 (UTC)
From: David Marchand <david.marchand@redhat.com>
To: dev@dpdk.org
Cc: joshwash@google.com, Chengwen Feng <fengchengwen@huawei.com>,
 Ajit Khaparde <ajit.khaparde@broadcom.com>,
 Somnath Kotur <somnath.kotur@broadcom.com>,
 Potnuri Bharat Teja <bharat@chelsio.com>, Jie Hai <haijie1@huawei.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Chenbo Xia <chenbox@nvidia.com>,
 Gaetan Rivet <grive@u256.net>
Subject: [PATCH] pci: define more standard register offsets
Date: Wed, 16 Apr 2025 08:10:34 +0200
Message-ID: <20250416061034.649607-1-david.marchand@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: B2kQvxHHHe5WHxgmVqON5U-4RTxOE31QNjlA4yiyzSE_1744783950
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

The PCI standard defines registers for:
- subsystem id,
- revision id,
- status of the device,
- vital product data,

Add them to rte_pci.h and use in existing drivers.

Signed-off-by: David Marchand <david.marchand@redhat.com>
---
 drivers/dma/hisilicon/hisi_dmadev.c |  3 +--
 drivers/dma/hisilicon/hisi_dmadev.h |  1 -
 drivers/net/bnxt/bnxt_ethdev.c      |  8 ++++----
 drivers/net/bnxt/bnxt_util.h        |  2 --
 drivers/net/cxgbe/base/adapter.h    | 17 +++++++++--------
 drivers/net/hns3/hns3_common.c      |  5 ++---
 drivers/net/hns3/hns3_ethdev.h      |  5 +----
 drivers/net/intel/e1000/em_rxtx.c   | 17 ++++++-----------
 drivers/raw/ntb/ntb_hw_intel.c      |  5 ++---
 drivers/raw/ntb/ntb_hw_intel.h      |  3 ---
 lib/pci/rte_pci.h                   | 10 ++++++++++
 11 files changed, 35 insertions(+), 41 deletions(-)

diff --git a/drivers/dma/hisilicon/hisi_dmadev.c b/drivers/dma/hisilicon/hisi_dmadev.c
index fdd2fa225f..019c4a8189 100644
--- a/drivers/dma/hisilicon/hisi_dmadev.c
+++ b/drivers/dma/hisilicon/hisi_dmadev.c
@@ -883,8 +883,7 @@ hisi_dma_check_revision(struct rte_pci_device *pci_dev, const char *name,
 	uint8_t revision;
 	int ret;
 
-	ret = rte_pci_read_config(pci_dev, &revision, 1,
-				  HISI_DMA_PCI_REVISION_ID_REG);
+	ret = rte_pci_read_config(pci_dev, &revision, 1, RTE_PCI_REVISION_ID);
 	if (ret != 1) {
 		HISI_DMA_LOG(ERR, "%s read PCI revision failed!", name);
 		return -EINVAL;
diff --git a/drivers/dma/hisilicon/hisi_dmadev.h b/drivers/dma/hisilicon/hisi_dmadev.h
index 786fe3cc0e..90301e6b00 100644
--- a/drivers/dma/hisilicon/hisi_dmadev.h
+++ b/drivers/dma/hisilicon/hisi_dmadev.h
@@ -24,7 +24,6 @@
 
 #define PCI_VENDOR_ID_HUAWEI			0x19e5
 #define HISI_DMA_DEVICE_ID			0xA122
-#define HISI_DMA_PCI_REVISION_ID_REG		0x08
 #define HISI_DMA_REVISION_HIP08B		0x21
 
 #define HISI_DMA_MAX_HW_QUEUES			4
diff --git a/drivers/net/bnxt/bnxt_ethdev.c b/drivers/net/bnxt/bnxt_ethdev.c
index 2f37f5aa10..8213ff9e4b 100644
--- a/drivers/net/bnxt/bnxt_ethdev.c
+++ b/drivers/net/bnxt/bnxt_ethdev.c
@@ -4585,10 +4585,10 @@ bnxt_check_fw_reset_done(struct bnxt *bp)
 	int rc;
 
 	do {
-		rc = rte_pci_read_config(bp->pdev, &val, sizeof(val), PCI_SUBSYSTEM_ID_OFFSET);
+		rc = rte_pci_read_config(bp->pdev, &val, sizeof(val), RTE_PCI_SUBSYSTEM_ID);
 		if (rc < 0) {
 			PMD_DRV_LOG_LINE(ERR, "Failed to read PCI offset 0x%x",
-				PCI_SUBSYSTEM_ID_OFFSET);
+				RTE_PCI_SUBSYSTEM_ID);
 			return rc;
 		}
 		if (val != 0xffff)
@@ -4823,10 +4823,10 @@ void bnxt_dev_reset_and_resume(void *arg)
 	 * we can poll this config register immediately for the value to revert.
 	 */
 	if (bp->flags & BNXT_FLAG_FATAL_ERROR) {
-		rc = rte_pci_read_config(bp->pdev, &val, sizeof(val), PCI_SUBSYSTEM_ID_OFFSET);
+		rc = rte_pci_read_config(bp->pdev, &val, sizeof(val), RTE_PCI_SUBSYSTEM_ID);
 		if (rc < 0) {
 			PMD_DRV_LOG_LINE(ERR, "Failed to read PCI offset 0x%x",
-				PCI_SUBSYSTEM_ID_OFFSET);
+				RTE_PCI_SUBSYSTEM_ID);
 			return;
 		}
 		if (val == 0xffff) {
diff --git a/drivers/net/bnxt/bnxt_util.h b/drivers/net/bnxt/bnxt_util.h
index b265f5841b..416a6a2609 100644
--- a/drivers/net/bnxt/bnxt_util.h
+++ b/drivers/net/bnxt/bnxt_util.h
@@ -13,8 +13,6 @@
 #define BIT_MASK(len) (BIT(len) - 1)
 #endif /* BIT_MASK */
 
-#define PCI_SUBSYSTEM_ID_OFFSET	0x2e
-
 int bnxt_check_zero_bytes(const uint8_t *bytes, int len);
 void bnxt_eth_hw_addr_random(uint8_t *mac_addr);
 uint8_t hweight32(uint32_t word32);
diff --git a/drivers/net/cxgbe/base/adapter.h b/drivers/net/cxgbe/base/adapter.h
index d490c6f158..207f3ecb88 100644
--- a/drivers/net/cxgbe/base/adapter.h
+++ b/drivers/net/cxgbe/base/adapter.h
@@ -512,14 +512,15 @@ static inline void t4_write_reg64(struct adapter *adapter, u32 reg_addr,
 }
 
 #define PCI_CAP_ID_EXP          RTE_PCI_CAP_ID_EXP
-#define PCI_EXP_DEVCTL          0x0008  /* Device control */
-#define PCI_EXP_DEVCTL2         40      /* Device Control 2 */
-#define PCI_EXP_DEVCTL_EXT_TAG  0x0100  /* Extended Tag Field Enable */
-#define PCI_EXP_DEVCTL_PAYLOAD  0x00E0  /* Max payload */
-#define PCI_CAP_ID_VPD          0x03    /* Vital Product Data */
-#define PCI_VPD_ADDR            2       /* Address to access (15 bits!) */
-#define PCI_VPD_ADDR_F          0x8000  /* Write 0, 1 indicates completion */
-#define PCI_VPD_DATA            4       /* 32-bits of data returned here */
+#define PCI_EXP_DEVCTL          RTE_PCI_EXP_DEVCTL
+#define PCI_EXP_DEVCTL_EXT_TAG  RTE_PCI_EXP_DEVCTL_EXT_TAG
+#define PCI_EXP_DEVCTL_PAYLOAD  RTE_PCI_EXP_DEVCTL_PAYLOAD
+#define PCI_EXP_DEVCTL2         RTE_PCI_EXP_DEVCTL2
+
+#define PCI_CAP_ID_VPD          RTE_PCI_CAP_ID_VPD
+#define PCI_VPD_ADDR            RTE_PCI_VPD_ADDR
+#define PCI_VPD_ADDR_F          RTE_PCI_VPD_ADDR_F
+#define PCI_VPD_DATA            RTE_PCI_VPD_DATA
 
 /**
  * t4_os_pci_write_cfg4 - 32-bit write to PCI config space
diff --git a/drivers/net/hns3/hns3_common.c b/drivers/net/hns3/hns3_common.c
index 25a45212be..1ad04444d0 100644
--- a/drivers/net/hns3/hns3_common.c
+++ b/drivers/net/hns3/hns3_common.c
@@ -944,9 +944,8 @@ hns3_get_pci_revision_id(struct hns3_hw *hw, uint8_t *revision_id)
 
 	eth_dev = &rte_eth_devices[hw->data->port_id];
 	pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
-	ret = rte_pci_read_config(pci_dev, &revision, HNS3_PCI_REVISION_ID_LEN,
-				  HNS3_PCI_REVISION_ID);
-	if (ret != HNS3_PCI_REVISION_ID_LEN) {
+	ret = rte_pci_read_config(pci_dev, &revision, 1, RTE_PCI_REVISION_ID);
+	if (ret != 1) {
 		hns3_err(hw, "failed to read pci revision id, ret = %d", ret);
 		return -EIO;
 	}
diff --git a/drivers/net/hns3/hns3_ethdev.h b/drivers/net/hns3/hns3_ethdev.h
index 7824503bb8..085a83773f 100644
--- a/drivers/net/hns3/hns3_ethdev.h
+++ b/drivers/net/hns3/hns3_ethdev.h
@@ -32,10 +32,7 @@
 #define HNS3_DEV_ID_100G_VF			0xA22E
 #define HNS3_DEV_ID_100G_RDMA_PFC_VF		0xA22F
 
-/* PCI Config offsets */
-#define HNS3_PCI_REVISION_ID			0x08
-#define HNS3_PCI_REVISION_ID_LEN		1
-
+/* Revision IDs */
 #define PCI_REVISION_ID_HIP08_B			0x21
 #define PCI_REVISION_ID_HIP09_A			0x30
 
diff --git a/drivers/net/intel/e1000/em_rxtx.c b/drivers/net/intel/e1000/em_rxtx.c
index df5fbb7823..e3d8967a5c 100644
--- a/drivers/net/intel/e1000/em_rxtx.c
+++ b/drivers/net/intel/e1000/em_rxtx.c
@@ -59,11 +59,6 @@
 #define E1000_TX_OFFLOAD_NOTSUP_MASK \
 		(RTE_MBUF_F_TX_OFFLOAD_MASK ^ E1000_TX_OFFLOAD_MASK)
 
-/* PCI offset for querying configuration status register */
-#define PCI_CFG_STATUS_REG                 0x06
-#define FLUSH_DESC_REQUIRED               0x100
-
-
 /**
  * Structure associated with each descriptor of the RX ring of a RX queue.
  */
@@ -2107,26 +2102,26 @@ em_flush_desc_rings(struct rte_eth_dev *dev)
 			fextnvm11 | E1000_FEXTNVM11_DISABLE_MULR_FIX);
 	tdlen = E1000_READ_REG(hw, E1000_TDLEN(0));
 	ret = rte_pci_read_config(pci_dev, &pci_cfg_status,
-		   sizeof(pci_cfg_status), PCI_CFG_STATUS_REG);
+		   sizeof(pci_cfg_status), RTE_PCI_STATUS);
 	if (ret < 0) {
 		PMD_DRV_LOG(ERR, "Failed to read PCI offset 0x%x",
-			    PCI_CFG_STATUS_REG);
+			    RTE_PCI_STATUS);
 		return;
 	}
 
 	/* do nothing if we're not in faulty state, or if the queue is empty */
-	if ((pci_cfg_status & FLUSH_DESC_REQUIRED) && tdlen) {
+	if ((pci_cfg_status & RTE_PCI_STATUS_PARITY) && tdlen) {
 		/* flush desc ring */
 		e1000_flush_tx_ring(dev);
 		ret = rte_pci_read_config(pci_dev, &pci_cfg_status,
-				sizeof(pci_cfg_status), PCI_CFG_STATUS_REG);
+				sizeof(pci_cfg_status), RTE_PCI_STATUS);
 		if (ret < 0) {
 			PMD_DRV_LOG(ERR, "Failed to read PCI offset 0x%x",
-					PCI_CFG_STATUS_REG);
+					RTE_PCI_STATUS);
 			return;
 		}
 
-		if (pci_cfg_status & FLUSH_DESC_REQUIRED)
+		if (pci_cfg_status & RTE_PCI_STATUS_PARITY)
 			e1000_flush_rx_ring(dev);
 	}
 }
diff --git a/drivers/raw/ntb/ntb_hw_intel.c b/drivers/raw/ntb/ntb_hw_intel.c
index 9b4465176a..956f411ea3 100644
--- a/drivers/raw/ntb/ntb_hw_intel.c
+++ b/drivers/raw/ntb/ntb_hw_intel.c
@@ -145,9 +145,8 @@ intel_ntb4_check_ppd(struct ntb_hw *hw)
 	int ret;
 
 	ret = rte_pci_read_config(hw->pci_dev, &revision_id,
-				  NTB_PCI_DEV_REVISION_ID_LEN,
-				  NTB_PCI_DEV_REVISION_ID_REG);
-	if (ret != NTB_PCI_DEV_REVISION_ID_LEN) {
+				  1, RTE_PCI_REVISION_ID);
+	if (ret != 1) {
 		NTB_LOG(ERR, "Cannot get NTB PCI Device Revision ID.");
 		return -EIO;
 	}
diff --git a/drivers/raw/ntb/ntb_hw_intel.h b/drivers/raw/ntb/ntb_hw_intel.h
index 9587104f80..e6bf4a29d5 100644
--- a/drivers/raw/ntb/ntb_hw_intel.h
+++ b/drivers/raw/ntb/ntb_hw_intel.h
@@ -9,9 +9,6 @@
 #define NTB_PCI_DEV_REVISION_ICX_MIN	0x02
 #define NTB_PCI_DEV_REVISION_ICX_MAX	0x0F
 
-#define NTB_PCI_DEV_REVISION_ID_REG	0x08
-#define NTB_PCI_DEV_REVISION_ID_LEN	1
-
 /* Ntb control and link status */
 #define NTB_CTL_CFG_LOCK		1
 #define NTB_CTL_DISABLE			2
diff --git a/lib/pci/rte_pci.h b/lib/pci/rte_pci.h
index 9a50a12142..9d04978a0f 100644
--- a/lib/pci/rte_pci.h
+++ b/lib/pci/rte_pci.h
@@ -35,7 +35,9 @@ extern "C" {
 #define RTE_PCI_DEVICE_ID	0x02	/* 16 bits */
 #define RTE_PCI_COMMAND		0x04	/* 16 bits */
 #define RTE_PCI_STATUS		0x06	/* 16 bits */
+#define RTE_PCI_REVISION_ID	0x08	/* 8 bits */
 #define RTE_PCI_BASE_ADDRESS_0	0x10	/* 32 bits */
+#define RTE_PCI_SUBSYSTEM_ID	0x2e	/* 32 bits */
 #define RTE_PCI_CAPABILITY_LIST	0x34	/* 32 bits */
 
 /* PCI Command Register (RTE_PCI_COMMAND) */
@@ -45,12 +47,14 @@ extern "C" {
 
 /* PCI Status Register (RTE_PCI_STATUS) */
 #define RTE_PCI_STATUS_CAP_LIST		0x10	/* Support Capability List */
+#define RTE_PCI_STATUS_PARITY		0x100	/* Detected parity error */
 
 /* Base addresses (RTE_PCI_BASE_ADDRESS_*) */
 #define RTE_PCI_BASE_ADDRESS_SPACE_IO	0x01
 
 /* Capability registers (RTE_PCI_CAPABILITY_LIST) */
 #define RTE_PCI_CAP_ID_PM		0x01	/* Power Management */
+#define RTE_PCI_CAP_ID_VPD		0x03	/* Vital Product Data */
 #define RTE_PCI_CAP_ID_MSI		0x05	/* Message Signalled Interrupts */
 #define RTE_PCI_CAP_ID_VNDR		0x09	/* Vendor-Specific */
 #define RTE_PCI_CAP_ID_EXP		0x10	/* PCI Express */
@@ -64,10 +68,16 @@ extern "C" {
 #define RTE_PCI_PM_CTRL_PME_ENABLE	0x0100	/* PME pin enable */
 #define RTE_PCI_PM_CTRL_PME_STATUS	0x8000	/* PME pin status */
 
+/* Vital Product Data (RTE_PCI_CAP_ID_VPD) */
+#define RTE_PCI_VPD_ADDR		2	/* Address to access (15 bits!) */
+#define RTE_PCI_VPD_ADDR_F		0x8000	/* Write 0, 1 indicates completion */
+#define RTE_PCI_VPD_DATA		4	/* 32-bits of data returned here */
+
 /* PCI Express capability registers (RTE_PCI_CAP_ID_EXP) */
 #define RTE_PCI_EXP_TYPE_RC_EC		0xa	/* Root Complex Event Collector */
 #define RTE_PCI_EXP_DEVCTL		0x08	/* Device Control */
 #define RTE_PCI_EXP_DEVCTL_PAYLOAD	0x00e0	/* Max_Payload_Size */
+#define RTE_PCI_EXP_DEVCTL_EXT_TAG	0x0100	/* Extended Tag Field Enable */
 #define RTE_PCI_EXP_DEVCTL_READRQ	0x7000	/* Max_Read_Request_Size */
 #define RTE_PCI_EXP_DEVCTL_BCR_FLR	0x8000	/* Bridge Configuration Retry / FLR */
 #define RTE_PCI_EXP_DEVSTA		0x0a	/* Device Status */
-- 
2.49.0

