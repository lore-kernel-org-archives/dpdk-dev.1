Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FFE8CCD185
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 11:17:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59D9340A6F;
	Thu,  9 Oct 2025 13:16:50 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 3344840654
 for <dev@dpdk.org>; Thu,  9 Oct 2025 13:16:40 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 185EC203F4A;
 Thu,  9 Oct 2025 13:16:40 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D69AC203F53;
 Thu,  9 Oct 2025 13:16:39 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 59BD31800089;
 Thu,  9 Oct 2025 19:16:39 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org, Gagandeep Singh <g.singh@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [v1 11/12] net/enetc: Add link status notification support
Date: Thu,  9 Oct 2025 16:46:32 +0530
Message-Id: <20251009111633.3585957-12-vanshika.shukla@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251009111633.3585957-1-vanshika.shukla@nxp.com>
References: <20251009111633.3585957-1-vanshika.shukla@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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

From: Vanshika Shukla <vanshika.shukla@nxp.com>

This patch supports link event notifications for ENETC4 PMD, enabling:

- Link up/down event notifications
- Notification of link speed changes

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
---
 doc/guides/nics/features/enetc4.ini |   1 +
 drivers/net/enetc/base/enetc4_hw.h  |   9 +-
 drivers/net/enetc/enetc.h           |   3 +
 drivers/net/enetc/enetc4_ethdev.c   |  16 ++-
 drivers/net/enetc/enetc4_vf.c       | 215 +++++++++++++++++++++++++++-
 5 files changed, 239 insertions(+), 5 deletions(-)

diff --git a/doc/guides/nics/features/enetc4.ini b/doc/guides/nics/features/enetc4.ini
index 78b06e9841..31a1955215 100644
--- a/doc/guides/nics/features/enetc4.ini
+++ b/doc/guides/nics/features/enetc4.ini
@@ -4,6 +4,7 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+Link status event    = Y
 Speed capabilities   = Y
 Link status          = Y
 Promiscuous mode     = Y
diff --git a/drivers/net/enetc/base/enetc4_hw.h b/drivers/net/enetc/base/enetc4_hw.h
index d899b82b9c..2da779e351 100644
--- a/drivers/net/enetc/base/enetc4_hw.h
+++ b/drivers/net/enetc/base/enetc4_hw.h
@@ -128,7 +128,14 @@ struct enetc_msg_swbd {
 #define ENETC4_SITFRM0           0x328
 #define ENETC4_SITDFCR           0x340
 
-/* VSI MSG Registers */
+/* Station interface interrupts */
+#define ENETC4_SIMSIVR           0xA30
+#define ENETC4_VSIIER            0xA00
+#define ENETC4_VSIIDR            0xA08
+#define ENETC4_VSIIER_MRIE       BIT(9)
+#define ENETC4_SI_INT_IDX        0
+
+/* VSI Registers */
 #define ENETC4_VSIMSGSR  0x204   /* RO */
 #define ENETC4_VSIMSGSR_MB       BIT(0)
 #define ENETC4_VSIMSGSR_MS       BIT(1)
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index 70510594d7..ef0bcbb018 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -160,6 +160,8 @@ enum enetc_msg_cmd_id {
 	ENETC_CMD_ID_SET_MAC_PROMISCUOUS = 5,
 	ENETC_CMD_ID_SET_VLAN_PROMISCUOUS = 4,
 	ENETC_CMD_ID_GET_LINK_STATUS = 0,
+	ENETC_CMD_ID_REGISTER_LINK_NOTIF = 1,
+	ENETC_CMD_ID_UNREGISTER_LINK_NOTIF = 2,
 	ENETC_CMD_ID_GET_LINK_SPEED = 0
 };
 
@@ -279,6 +281,7 @@ const uint32_t *enetc4_supported_ptypes_get(struct rte_eth_dev *dev __rte_unused
  * enetc4_vf function prototype
  */
 int enetc4_vf_dev_stop(struct rte_eth_dev *dev);
+int enetc4_vf_dev_intr(struct rte_eth_dev *eth_dev, bool enable);
 
 /*
  * RX/TX ENETC function prototypes
diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
index b606714cd6..ac7b913c4c 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -556,10 +556,13 @@ enetc4_dev_close(struct rte_eth_dev *dev)
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return 0;
 
-	if (hw->device_id == ENETC4_DEV_ID_VF)
+	if (hw->device_id == ENETC4_DEV_ID_VF) {
+		if (dev->data->dev_conf.intr_conf.lsc != 0)
+			enetc4_vf_dev_intr(dev, false);
 		ret = enetc4_vf_dev_stop(dev);
-	else
+	} else {
 		ret = enetc4_dev_stop(dev);
+	}
 
 	if (dev->data->nb_rx_queues > 1) {
 		/* Disable RSS */
@@ -670,6 +673,15 @@ enetc4_dev_configure(struct rte_eth_dev *dev)
 
 	enetc4_port_wr(enetc_hw, ENETC4_PARCSCR, checksum);
 
+	/* Enable interrupts */
+	if (hw->device_id == ENETC4_DEV_ID_VF) {
+		if (dev->data->dev_conf.intr_conf.lsc != 0) {
+			ret = enetc4_vf_dev_intr(dev, true);
+			if (ret)
+				ENETC_PMD_WARN("Failed to setup link interrupts");
+		}
+	}
+
 	/* Disable and reset RX and TX rings */
 	for (i = 0; i < dev->data->nb_rx_queues; i++)
 		enetc4_rxbdr_wr(enetc_hw, i, ENETC_RBMR, ENETC_BMR_RESET);
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index 307fabf2c6..22266188ee 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -144,6 +144,69 @@ enetc4_msg_vsi_reply_msg(struct enetc_hw *enetc_hw, struct enetc_psi_reply_msg *
 	reply_msg->status = status;
 }
 
+static void
+enetc4_msg_get_psi_msg(struct enetc_hw *enetc_hw, struct enetc_psi_reply_msg *reply_msg)
+{
+	int vsimsgrr;
+	int8_t class_id = 0;
+	uint8_t status = 0;
+
+	vsimsgrr = enetc_rd(enetc_hw, ENETC4_VSIMSGRR);
+
+	/* Extracting 8 bits of message result in class_id */
+	class_id |= ((ENETC_SIMSGSR_GET_MC(vsimsgrr) >> 8) & 0xff);
+
+	/* Extracting 4 bits of message result in status */
+	status |= ((ENETC_SIMSGSR_GET_MC(vsimsgrr) >> 4) & 0xf);
+
+	reply_msg->class_id = class_id;
+	reply_msg->status = status;
+}
+
+static void
+enetc4_process_psi_msg(struct rte_eth_dev *eth_dev, struct enetc_hw *enetc_hw)
+{
+	struct enetc_psi_reply_msg *msg;
+	struct rte_eth_link link;
+	int ret = 0;
+
+	msg = rte_zmalloc(NULL, sizeof(*msg), RTE_CACHE_LINE_SIZE);
+	if (!msg) {
+		ENETC_PMD_ERR("Failed to alloc memory for msg");
+		return;
+	}
+
+	rte_eth_linkstatus_get(eth_dev, &link);
+	enetc4_msg_get_psi_msg(enetc_hw, msg);
+
+	if (msg->class_id == ENETC_CLASS_ID_LINK_STATUS) {
+		switch (msg->status) {
+		case ENETC_LINK_UP:
+			ENETC_PMD_DEBUG("Link is up");
+			link.link_status = RTE_ETH_LINK_UP;
+			break;
+		case ENETC_LINK_DOWN:
+			ENETC_PMD_DEBUG("Link is down");
+			link.link_status = RTE_ETH_LINK_DOWN;
+			break;
+		default:
+			ENETC_PMD_ERR("Unknown link status 0x%x", msg->status);
+			break;
+		}
+		ret = rte_eth_linkstatus_set(eth_dev, &link);
+		if (!ret)
+			ENETC_PMD_DEBUG("Link status has been changed");
+
+		/* Process user registered callback */
+		rte_eth_dev_callback_process(eth_dev,
+			RTE_ETH_EVENT_INTR_LSC, NULL);
+	} else {
+		ENETC_PMD_ERR("Wrong message 0x%x", msg->class_id);
+	}
+
+	rte_free(msg);
+}
+
 static int
 enetc4_msg_vsi_send(struct enetc_hw *enetc_hw, struct enetc_msg_swbd *msg)
 {
@@ -775,6 +838,55 @@ static int enetc4_vf_vlan_offload_set(struct rte_eth_dev *dev, int mask __rte_un
 	return 0;
 }
 
+static int
+enetc4_vf_link_register_notif(struct rte_eth_dev *dev, bool enable)
+{
+	struct enetc_eth_hw *hw = ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
+	struct enetc_msg_swbd *msg;
+	struct rte_eth_link link;
+	int msg_size;
+	int err = 0;
+	uint8_t cmd;
+
+	PMD_INIT_FUNC_TRACE();
+	memset(&link, 0, sizeof(struct rte_eth_link));
+	msg = rte_zmalloc(NULL, sizeof(*msg), RTE_CACHE_LINE_SIZE);
+	if (!msg) {
+		ENETC_PMD_ERR("Failed to alloc msg");
+		err = -ENOMEM;
+		return err;
+	}
+
+	msg_size = RTE_ALIGN(sizeof(struct enetc_msg_cmd_get_link_status), ENETC_VSI_PSI_MSG_SIZE);
+	msg->vaddr = rte_zmalloc(NULL, msg_size, 0);
+	if (!msg->vaddr) {
+		ENETC_PMD_ERR("Failed to alloc memory for msg");
+		rte_free(msg);
+		return -ENOMEM;
+	}
+
+	msg->dma = rte_mem_virt2iova((const void *)msg->vaddr);
+	msg->size = msg_size;
+	if (enable)
+		cmd = ENETC_CMD_ID_REGISTER_LINK_NOTIF;
+	else
+		cmd = ENETC_CMD_ID_UNREGISTER_LINK_NOTIF;
+	enetc_msg_vf_fill_common_hdr(msg, ENETC_CLASS_ID_LINK_STATUS,
+			cmd, 0, 0, 0);
+
+	/* send the command and wait */
+	err = enetc4_msg_vsi_send(enetc_hw, msg);
+	if (err)
+		ENETC_PMD_ERR("VSI msg error for link status notification");
+
+	/* free memory no longer required */
+	rte_free(msg->vaddr);
+	rte_free(msg);
+
+	return err;
+}
+
 /*
  * The set of PCI devices this driver supports
  */
@@ -866,6 +978,45 @@ enetc4_vf_mac_init(struct enetc_eth_hw *hw, struct rte_eth_dev *eth_dev)
 	return 0;
 }
 
+static void
+enetc_vf_enable_mr_int(struct enetc_hw *hw, bool en)
+{
+	uint32_t val;
+
+	val = enetc_rd(hw, ENETC4_VSIIER);
+	val &= ~ENETC4_VSIIER_MRIE;
+	val |= (en) ? ENETC4_VSIIER_MRIE : 0;
+	enetc_wr(hw, ENETC4_VSIIER, val);
+	ENETC_PMD_DEBUG("Interrupt enable status (VSIIER) = 0x%x", val);
+}
+
+static void
+enetc4_dev_interrupt_handler(void *param)
+{
+	struct rte_eth_dev *eth_dev = (struct rte_eth_dev *)param;
+	struct enetc_eth_hw *hw =
+		ENETC_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
+	uint32_t status;
+
+	/* Disable interrupts before process */
+	enetc_vf_enable_mr_int(enetc_hw, false);
+
+	status = enetc_rd(enetc_hw, ENETC4_VSIIDR);
+	ENETC_PMD_DEBUG("Got INTR VSIIDR status = 0x%0x", status);
+	/* Check for PSI to VSI message interrupt */
+	if (!(status & ENETC4_VSIIER_MRIE)) {
+		ENETC_PMD_ERR("Interrupt is not PSI to VSI");
+		goto intr_clear;
+	}
+
+	enetc4_process_psi_msg(eth_dev, enetc_hw);
+intr_clear:
+	/* Clear Interrupts */
+	enetc_wr(enetc_hw, ENETC4_VSIIDR, 0xffffffff);
+	enetc_vf_enable_mr_int(enetc_hw, true);
+}
+
 static int
 enetc4_vf_dev_init(struct rte_eth_dev *eth_dev)
 {
@@ -913,14 +1064,74 @@ enetc4_vf_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 					     enetc4_vf_dev_init);
 }
 
+int
+enetc4_vf_dev_intr(struct rte_eth_dev *eth_dev, bool enable)
+{
+	struct enetc_eth_hw *hw =
+		ENETC_DEV_PRIVATE_TO_HW(eth_dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
+	struct rte_pci_device *pci_dev = RTE_ETH_DEV_TO_PCI(eth_dev);
+	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
+	int ret = 0;
+
+	PMD_INIT_FUNC_TRACE();
+	if (!(intr_handle && rte_intr_fd_get(intr_handle))) {
+		ENETC_PMD_ERR("No INTR handle");
+		return -1;
+	}
+	if (enable) {
+		/* if the interrupts were configured on this devices*/
+		ret = rte_intr_callback_register(intr_handle,
+				enetc4_dev_interrupt_handler, eth_dev);
+		if (ret) {
+			ENETC_PMD_ERR("Failed to register INTR callback %d", ret);
+			return ret;
+		}
+		/* set one IRQ entry for PSI-to-VSI messaging */
+		/* Vector index 0 */
+		enetc_wr(enetc_hw, ENETC4_SIMSIVR, ENETC4_SI_INT_IDX);
+
+		/* enable uio/vfio intr/eventfd mapping */
+		ret = rte_intr_enable(intr_handle);
+		if (ret) {
+			ENETC_PMD_ERR("Failed to enable INTR %d", ret);
+			goto intr_enable_fail;
+		}
+
+		/* Enable message received interrupt */
+		enetc_vf_enable_mr_int(enetc_hw, true);
+		ret = enetc4_vf_link_register_notif(eth_dev, true);
+		if (ret) {
+			ENETC_PMD_ERR("Failed to register link notifications %d", ret);
+			goto disable;
+		}
+
+		return ret;
+	}
+
+	ret = enetc4_vf_link_register_notif(eth_dev, false);
+	if (ret)
+		ENETC_PMD_WARN("Failed to un-register link notification %d", ret);
+disable:
+	enetc_vf_enable_mr_int(enetc_hw, false);
+	ret = rte_intr_disable(intr_handle);
+	if (ret)
+		ENETC_PMD_WARN("Failed to disable INTR %d", ret);
+intr_enable_fail:
+	rte_intr_callback_unregister(intr_handle,
+			enetc4_dev_interrupt_handler, eth_dev);
+
+	return ret;
+}
+
 static struct rte_pci_driver rte_enetc4_vf_pmd = {
 	.id_table = pci_vf_id_enetc4_map,
-	.drv_flags = RTE_PCI_DRV_NEED_MAPPING,
+	.drv_flags = RTE_PCI_DRV_NEED_MAPPING | RTE_PCI_DRV_INTR_LSC,
 	.probe = enetc4_vf_pci_probe,
 	.remove = enetc4_pci_remove,
 };
 
 RTE_PMD_REGISTER_PCI(net_enetc4_vf, rte_enetc4_vf_pmd);
 RTE_PMD_REGISTER_PCI_TABLE(net_enetc4_vf, pci_vf_id_enetc4_map);
-RTE_PMD_REGISTER_KMOD_DEP(net_enetc4_vf, "* uio_pci_generic");
+RTE_PMD_REGISTER_KMOD_DEP(net_enetc4_vf, "* igb_uio | uio_pci_generic");
 RTE_LOG_REGISTER_DEFAULT(enetc4_vf_logtype_pmd, NOTICE);
-- 
2.25.1

