Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45892CCD19A
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 09:20:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 90FCA42DBE;
	Fri, 17 Oct 2025 11:19:45 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 6C64A42D26
 for <dev@dpdk.org>; Fri, 17 Oct 2025 11:19:35 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 501B7203631;
 Fri, 17 Oct 2025 11:19:35 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 1BA2C200E78;
 Fri, 17 Oct 2025 11:19:35 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 92221180009C;
 Fri, 17 Oct 2025 17:19:34 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org, Gagandeep Singh <g.singh@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [v2 08/12] net/enetc: Add multicast and promiscuous mode support
Date: Fri, 17 Oct 2025 14:49:25 +0530
Message-Id: <20251017091929.2723044-9-vanshika.shukla@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251017091929.2723044-1-vanshika.shukla@nxp.com>
References: <20251009111633.3585957-1-vanshika.shukla@nxp.com>
 <20251017091929.2723044-1-vanshika.shukla@nxp.com>
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

Enables ENETC4 PMD to handle multicast and promiscuous modes.

Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/nics/features/enetc4.ini |   2 +
 drivers/net/enetc/enetc.h           |   5 +
 drivers/net/enetc/enetc4_ethdev.c   |  40 +++++
 drivers/net/enetc/enetc4_vf.c       | 265 ++++++++++++++++++++++++++++
 4 files changed, 312 insertions(+)

diff --git a/doc/guides/nics/features/enetc4.ini b/doc/guides/nics/features/enetc4.ini
index 79430d0018..36d536d1f2 100644
--- a/doc/guides/nics/features/enetc4.ini
+++ b/doc/guides/nics/features/enetc4.ini
@@ -4,6 +4,8 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+Promiscuous mode     = Y
+Allmulticast mode    = Y
 RSS hash             = Y
 Packet type parsing  = Y
 Basic stats          = Y
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index 60634c8526..f07fcbaa3b 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -143,15 +143,20 @@ struct enetc_eth_adapter {
 #define ENETC_ALLMULTI_PROMISC_DIS		0x81
 #define ENETC_ALLMULTI_PROMISC_EN		0x83
 
+#define ENETC_PROMISC_VLAN_DISABLE		0x1
+#define ENETC_PROMISC_VLAN_ENABLE		0x3
 
 /* Enum for class IDs */
 enum enetc_msg_cmd_class_id {
 	ENETC_CLASS_ID_MAC_FILTER = 0x20,
+	ENETC_CLASS_ID_VLAN_FILTER = 0x21,
 };
 
 /* Enum for command IDs */
 enum enetc_msg_cmd_id {
 	ENETC_CMD_ID_SET_PRIMARY_MAC = 0,
+	ENETC_CMD_ID_SET_MAC_PROMISCUOUS = 5,
+	ENETC_CMD_ID_SET_VLAN_PROMISCUOUS = 4,
 };
 
 enum mac_addr_status {
diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
index 2233bc4c0f..3e2371ed48 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -543,6 +543,44 @@ enetc4_dev_close(struct rte_eth_dev *dev)
 	return ret;
 }
 
+static int
+enetc4_promiscuous_enable(struct rte_eth_dev *dev)
+{
+	struct enetc_eth_hw *hw =
+		ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
+	uint32_t psipmr = 0;
+
+	psipmr = enetc4_port_rd(enetc_hw, ENETC4_PSIPMMR);
+
+	/* Setting to enable promiscuous mode for all ports*/
+	psipmr |= PSIPMMR_SI_MAC_UP | PSIPMMR_SI_MAC_MP;
+
+	enetc4_port_wr(enetc_hw, ENETC4_PSIPMMR, psipmr);
+
+	return 0;
+}
+
+static int
+enetc4_promiscuous_disable(struct rte_eth_dev *dev)
+{
+	struct enetc_eth_hw *hw =
+		ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
+	uint32_t psipmr = 0;
+
+	/* Setting to disable promiscuous mode for SI0*/
+	psipmr = enetc4_port_rd(enetc_hw, ENETC4_PSIPMMR);
+	psipmr &= (~PSIPMMR_SI_MAC_UP);
+
+	if (dev->data->all_multicast == 0)
+		psipmr &= (~PSIPMMR_SI_MAC_MP);
+
+	enetc4_port_wr(enetc_hw, ENETC4_PSIPMMR, psipmr);
+
+	return 0;
+}
+
 int
 enetc4_dev_configure(struct rte_eth_dev *dev)
 {
@@ -783,6 +821,8 @@ static const struct eth_dev_ops enetc4_ops = {
 	.dev_infos_get        = enetc4_dev_infos_get,
 	.stats_get            = enetc4_stats_get,
 	.stats_reset          = enetc4_stats_reset,
+	.promiscuous_enable   = enetc4_promiscuous_enable,
+	.promiscuous_disable  = enetc4_promiscuous_disable,
 	.rx_queue_setup       = enetc4_rx_queue_setup,
 	.rx_queue_start       = enetc4_rx_queue_start,
 	.rx_queue_stop        = enetc4_rx_queue_stop,
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index d2a8e1f234..b929eddedb 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -303,6 +303,266 @@ enetc4_vf_set_mac_addr(struct rte_eth_dev *dev, struct rte_ether_addr *addr)
 	return err;
 }
 
+static int
+enetc4_vf_promisc_send_message(struct rte_eth_dev *dev, bool promisc_en)
+{
+	struct enetc_eth_hw *hw = ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
+	struct enetc_msg_cmd_set_promisc *cmd;
+	struct enetc_msg_swbd *msg;
+	uint32_t msg_size;
+	int err = 0;
+
+	msg = rte_zmalloc(NULL, sizeof(*msg), RTE_CACHE_LINE_SIZE);
+	if (!msg) {
+		ENETC_PMD_ERR("Failed to alloc msg");
+		err = -ENOMEM;
+		return err;
+	}
+
+	msg_size = RTE_ALIGN(sizeof(struct enetc_msg_cmd_set_promisc), ENETC_VSI_PSI_MSG_SIZE);
+	msg->vaddr = rte_zmalloc(NULL, msg_size, 0);
+	if (!msg->vaddr) {
+		ENETC_PMD_ERR("Failed to alloc memory for msg");
+		rte_free(msg);
+		return -ENOMEM;
+	}
+
+	msg->dma = rte_mem_virt2iova((const void *)msg->vaddr);
+	msg->size = msg_size;
+
+	cmd = (struct enetc_msg_cmd_set_promisc *)msg->vaddr;
+
+	/* op_type is based on the result of message format
+	 *    7  6      1       0
+	      type   promisc  flush
+	 */
+
+	if (promisc_en)
+		cmd->op_type = ENETC_PROMISC_ENABLE;
+	else
+		cmd->op_type = ENETC_PROMISC_DISABLE;
+
+	enetc_msg_vf_fill_common_hdr(msg, ENETC_CLASS_ID_MAC_FILTER,
+				ENETC_CMD_ID_SET_MAC_PROMISCUOUS, 0, 0, 0);
+
+	/* send the command and wait */
+	err = enetc4_msg_vsi_send(enetc_hw, msg);
+	if (err) {
+		ENETC_PMD_ERR("VSI message send error");
+		goto end;
+	}
+
+end:
+	/* free memory no longer required */
+	rte_free(msg->vaddr);
+	rte_free(msg);
+	return err;
+}
+
+static int
+enetc4_vf_allmulti_send_message(struct rte_eth_dev *dev, bool mc_promisc)
+{
+	struct enetc_eth_hw *hw = ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
+	struct enetc_msg_cmd_set_promisc *cmd;
+	struct enetc_msg_swbd *msg;
+	uint32_t msg_size;
+	int err = 0;
+
+	msg = rte_zmalloc(NULL, sizeof(*msg), RTE_CACHE_LINE_SIZE);
+	if (!msg) {
+		ENETC_PMD_ERR("Failed to alloc msg");
+		err = -ENOMEM;
+		return err;
+	}
+
+	msg_size = RTE_ALIGN(sizeof(struct enetc_msg_cmd_set_promisc),
+				ENETC_VSI_PSI_MSG_SIZE);
+	msg->vaddr = rte_zmalloc(NULL, msg_size, 0);
+	if (!msg->vaddr) {
+		ENETC_PMD_ERR("Failed to alloc memory for msg");
+		rte_free(msg);
+		return -ENOMEM;
+	}
+
+	msg->dma = rte_mem_virt2iova((const void *)msg->vaddr);
+	msg->size = msg_size;
+
+	cmd = (struct enetc_msg_cmd_set_promisc *)msg->vaddr;
+
+	/* op_type is based on the result of message format
+	 *    7  6      1       0
+	      type   promisc  flush
+	 */
+
+	if (mc_promisc)
+		cmd->op_type = ENETC_ALLMULTI_PROMISC_EN;
+	else
+		cmd->op_type = ENETC_ALLMULTI_PROMISC_DIS;
+
+	enetc_msg_vf_fill_common_hdr(msg, ENETC_CLASS_ID_MAC_FILTER,
+				ENETC_CMD_ID_SET_MAC_PROMISCUOUS, 0, 0, 0);
+
+	/* send the command and wait */
+	err = enetc4_msg_vsi_send(enetc_hw, msg);
+	if (err) {
+		ENETC_PMD_ERR("VSI message send error");
+		goto end;
+	}
+
+end:
+	/* free memory no longer required */
+	rte_free(msg->vaddr);
+	rte_free(msg);
+	return err;
+}
+
+
+static int
+enetc4_vf_multicast_enable(struct rte_eth_dev *dev)
+{
+	int err;
+
+	PMD_INIT_FUNC_TRACE();
+	err = enetc4_vf_allmulti_send_message(dev, true);
+	if (err) {
+		ENETC_PMD_ERR("Failed to enable multicast promiscuous mode");
+		return err;
+	}
+
+	return 0;
+}
+
+static int
+enetc4_vf_multicast_disable(struct rte_eth_dev *dev)
+{
+	int err;
+
+	PMD_INIT_FUNC_TRACE();
+	err = enetc4_vf_allmulti_send_message(dev, false);
+	if (err) {
+		ENETC_PMD_ERR("Failed to disable multicast promiscuous mode");
+		return err;
+	}
+
+	return 0;
+}
+
+static int
+enetc4_vf_promisc_enable(struct rte_eth_dev *dev)
+{
+	int err;
+
+	PMD_INIT_FUNC_TRACE();
+	err = enetc4_vf_promisc_send_message(dev, true);
+	if (err) {
+		ENETC_PMD_ERR("Failed to enable promiscuous mode");
+		return err;
+	}
+
+	return 0;
+}
+
+static int
+enetc4_vf_promisc_disable(struct rte_eth_dev *dev)
+{
+	int err;
+
+	PMD_INIT_FUNC_TRACE();
+	err = enetc4_vf_promisc_send_message(dev, false);
+	if (err) {
+		ENETC_PMD_ERR("Failed to disable promiscuous mode");
+		return err;
+	}
+
+	return 0;
+}
+
+static int
+enetc4_vf_vlan_promisc(struct rte_eth_dev *dev, bool promisc_en)
+{
+	struct enetc_eth_hw *hw = ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
+	struct enetc_msg_cmd_set_vlan_promisc *cmd;
+	struct enetc_msg_swbd *msg;
+	uint32_t msg_size;
+	int err = 0;
+
+	msg = rte_zmalloc(NULL, sizeof(*msg), RTE_CACHE_LINE_SIZE);
+	if (!msg) {
+		ENETC_PMD_ERR("Failed to alloc msg");
+		err = -ENOMEM;
+		return err;
+	}
+
+	msg_size = RTE_ALIGN(sizeof(struct enetc_msg_cmd_set_vlan_promisc),
+				ENETC_VSI_PSI_MSG_SIZE);
+	msg->vaddr = rte_zmalloc(NULL, msg_size, 0);
+	if (!msg->vaddr) {
+		ENETC_PMD_ERR("Failed to alloc memory for msg");
+		rte_free(msg);
+		return -ENOMEM;
+	}
+	msg->dma = rte_mem_virt2iova((const void *)msg->vaddr);
+	msg->size = msg_size;
+
+	cmd = (struct enetc_msg_cmd_set_vlan_promisc *)msg->vaddr;
+	/* op is based on the result of message format
+	 *	   1	  0
+	 *	promisc	flush
+	 */
+
+	if (promisc_en)
+		cmd->op = ENETC_PROMISC_VLAN_ENABLE;
+	else
+		cmd->op = ENETC_PROMISC_VLAN_DISABLE;
+
+	enetc_msg_vf_fill_common_hdr(msg, ENETC_CLASS_ID_VLAN_FILTER,
+				ENETC_CMD_ID_SET_VLAN_PROMISCUOUS, 0, 0, 0);
+
+	/* send the command and wait */
+	err = enetc4_msg_vsi_send(enetc_hw, msg);
+	if (err) {
+		ENETC_PMD_ERR("VSI message send error");
+		goto end;
+	}
+
+end:
+	/* free memory no longer required */
+	rte_free(msg->vaddr);
+	rte_free(msg);
+	return err;
+}
+
+static int enetc4_vf_vlan_offload_set(struct rte_eth_dev *dev, int mask __rte_unused)
+{
+	int err = 0;
+
+	PMD_INIT_FUNC_TRACE();
+
+	if (dev->data->dev_conf.rxmode.offloads) {
+		ENETC_PMD_DEBUG("VLAN filter table entry inserted:"
+					"Disabling VLAN promisc mode");
+		err = enetc4_vf_vlan_promisc(dev, false);
+		if (err) {
+			ENETC_PMD_ERR("Added VLAN filter table entry:"
+					"Failed to disable promiscuous mode");
+			return err;
+		}
+	} else {
+		ENETC_PMD_DEBUG("Enabling VLAN promisc mode");
+		err = enetc4_vf_vlan_promisc(dev, true);
+		if (err) {
+			ENETC_PMD_ERR("Vlan filter table empty:"
+					"Failed to enable promiscuous mode");
+			return err;
+		}
+	}
+
+	return 0;
+}
+
 /*
  * The set of PCI devices this driver supports
  */
@@ -320,6 +580,11 @@ static const struct eth_dev_ops enetc4_vf_ops = {
 	.dev_infos_get        = enetc4_dev_infos_get,
 	.stats_get            = enetc4_vf_stats_get,
 	.mac_addr_set         = enetc4_vf_set_mac_addr,
+	.promiscuous_enable   = enetc4_vf_promisc_enable,
+	.promiscuous_disable  = enetc4_vf_promisc_disable,
+	.allmulticast_enable  = enetc4_vf_multicast_enable,
+	.allmulticast_disable = enetc4_vf_multicast_disable,
+	.vlan_offload_set     = enetc4_vf_vlan_offload_set,
 	.rx_queue_setup       = enetc4_rx_queue_setup,
 	.rx_queue_start       = enetc4_rx_queue_start,
 	.rx_queue_stop        = enetc4_rx_queue_stop,
-- 
2.25.1

