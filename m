Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E89ECCD195
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 09:20:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 99B8142DCA;
	Fri, 17 Oct 2025 11:19:46 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id CC7B042D0B
 for <dev@dpdk.org>; Fri, 17 Oct 2025 11:19:35 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AF5991A3325;
 Fri, 17 Oct 2025 11:19:35 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8477B1A32FF;
 Fri, 17 Oct 2025 11:19:35 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 08E2D18000A0;
 Fri, 17 Oct 2025 17:19:34 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org, Gagandeep Singh <g.singh@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [v2 09/12] net/enetc: Add link speed and status support
Date: Fri, 17 Oct 2025 14:49:26 +0530
Message-Id: <20251017091929.2723044-10-vanshika.shukla@nxp.com>
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

This patch add support for link update operation.

Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/nics/features/enetc4.ini |   2 +
 drivers/net/enetc/base/enetc4_hw.h  |   9 ++
 drivers/net/enetc/enetc.h           |  25 ++++
 drivers/net/enetc/enetc4_ethdev.c   |  44 ++++++
 drivers/net/enetc/enetc4_vf.c       | 216 ++++++++++++++++++++++++++++
 5 files changed, 296 insertions(+)

diff --git a/doc/guides/nics/features/enetc4.ini b/doc/guides/nics/features/enetc4.ini
index 36d536d1f2..78b06e9841 100644
--- a/doc/guides/nics/features/enetc4.ini
+++ b/doc/guides/nics/features/enetc4.ini
@@ -4,6 +4,8 @@
 ; Refer to default.ini for the full list of available PMD features.
 ;
 [Features]
+Speed capabilities   = Y
+Link status          = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
 RSS hash             = Y
diff --git a/drivers/net/enetc/base/enetc4_hw.h b/drivers/net/enetc/base/enetc4_hw.h
index e114bcee90..b9dcbf7e59 100644
--- a/drivers/net/enetc/base/enetc4_hw.h
+++ b/drivers/net/enetc/base/enetc4_hw.h
@@ -111,6 +111,15 @@ struct enetc_msg_swbd {
 #define IFMODE_SGMII			5
 #define PM_IF_MODE_ENA			BIT(15)
 
+/* Port MAC 0 Interface Status Register */
+#define ENETC4_PM_IF_STATUS(mac)	(0x5304 + (mac) * 0x400)
+#define ENETC4_LINK_MODE                 0x0000000000080000ULL
+#define ENETC4_LINK_STATUS               0x0000000000010000ULL
+#define ENETC4_LINK_SPEED_MASK           0x0000000000060000ULL
+#define ENETC4_LINK_SPEED_10M            0x0ULL
+#define ENETC4_LINK_SPEED_100M           0x0000000000020000ULL
+#define ENETC4_LINK_SPEED_1G             0x0000000000040000ULL
+
 #define ENETC4_DEF_VSI_WAIT_TIMEOUT_UPDATE     100
 #define ENETC4_DEF_VSI_WAIT_DELAY_UPDATE       2000 /* us */
 
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index f07fcbaa3b..6ee4cabe35 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -150,6 +150,8 @@ struct enetc_eth_adapter {
 enum enetc_msg_cmd_class_id {
 	ENETC_CLASS_ID_MAC_FILTER = 0x20,
 	ENETC_CLASS_ID_VLAN_FILTER = 0x21,
+	ENETC_CLASS_ID_LINK_STATUS = 0x80,
+	ENETC_CLASS_ID_LINK_SPEED = 0x81
 };
 
 /* Enum for command IDs */
@@ -157,6 +159,8 @@ enum enetc_msg_cmd_id {
 	ENETC_CMD_ID_SET_PRIMARY_MAC = 0,
 	ENETC_CMD_ID_SET_MAC_PROMISCUOUS = 5,
 	ENETC_CMD_ID_SET_VLAN_PROMISCUOUS = 4,
+	ENETC_CMD_ID_GET_LINK_STATUS = 0,
+	ENETC_CMD_ID_GET_LINK_SPEED = 0
 };
 
 enum mac_addr_status {
@@ -165,6 +169,27 @@ enum mac_addr_status {
 	ENETC_MAC_ADDR_NOT_FOUND = 0X2,
 };
 
+enum link_status {
+	ENETC_LINK_UP = 0x0,
+	ENETC_LINK_DOWN = 0x1
+};
+
+enum speed {
+	ENETC_SPEED_UNKNOWN = 0x0,
+	ENETC_SPEED_10_HALF_DUPLEX = 0x1,
+	ENETC_SPEED_10_FULL_DUPLEX = 0x2,
+	ENETC_SPEED_100_HALF_DUPLEX = 0x3,
+	ENETC_SPEED_100_FULL_DUPLEX = 0x4,
+	ENETC_SPEED_1000 = 0x5,
+	ENETC_SPEED_2500 = 0x6,
+	ENETC_SPEED_5000 = 0x7,
+	ENETC_SPEED_10G = 0x8,
+	ENETC_SPEED_25G = 0x9,
+	ENETC_SPEED_50G = 0xA,
+	ENETC_SPEED_100G = 0xB,
+	ENETC_SPEED_NOT_SUPPORTED = 0xF
+};
+
 /* PSI-VSI command header format */
 struct enetc_msg_cmd_header {
 	uint16_t csum;		/* INET_CHECKSUM */
diff --git a/drivers/net/enetc/enetc4_ethdev.c b/drivers/net/enetc/enetc4_ethdev.c
index 3e2371ed48..3286b463e7 100644
--- a/drivers/net/enetc/enetc4_ethdev.c
+++ b/drivers/net/enetc/enetc4_ethdev.c
@@ -75,6 +75,49 @@ enetc4_dev_stop(struct rte_eth_dev *dev)
 	return 0;
 }
 
+/* return 0 means link status changed, -1 means not changed */
+static int
+enetc4_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
+{
+	struct enetc_eth_hw *hw =
+		ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
+	struct rte_eth_link link;
+	uint32_t status;
+
+	PMD_INIT_FUNC_TRACE();
+
+	memset(&link, 0, sizeof(link));
+
+	status = enetc4_port_rd(enetc_hw, ENETC4_PM_IF_STATUS(0));
+
+	if (status & ENETC4_LINK_MODE)
+		link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+	else
+		link.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
+
+	if (status & ENETC4_LINK_STATUS)
+		link.link_status = RTE_ETH_LINK_UP;
+	else
+		link.link_status = RTE_ETH_LINK_DOWN;
+
+	switch (status & ENETC4_LINK_SPEED_MASK) {
+	case ENETC4_LINK_SPEED_1G:
+		link.link_speed = RTE_ETH_SPEED_NUM_1G;
+		break;
+
+	case ENETC4_LINK_SPEED_100M:
+		link.link_speed = RTE_ETH_SPEED_NUM_100M;
+		break;
+
+	default:
+	case ENETC4_LINK_SPEED_10M:
+		link.link_speed = RTE_ETH_SPEED_NUM_10M;
+	}
+
+	return rte_eth_linkstatus_set(dev, &link);
+}
+
 static int
 enetc4_mac_init(struct enetc_eth_hw *hw, struct rte_eth_dev *eth_dev)
 {
@@ -819,6 +862,7 @@ static const struct eth_dev_ops enetc4_ops = {
 	.dev_stop             = enetc4_dev_stop,
 	.dev_close            = enetc4_dev_close,
 	.dev_infos_get        = enetc4_dev_infos_get,
+	.link_update          = enetc4_link_update,
 	.stats_get            = enetc4_stats_get,
 	.stats_reset          = enetc4_stats_reset,
 	.promiscuous_enable   = enetc4_promiscuous_enable,
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index b929eddedb..d7de1cc273 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -206,6 +206,8 @@ enetc4_msg_vsi_send(struct enetc_hw *enetc_hw, struct enetc_msg_swbd *msg)
 			err = -EINVAL;
 			break;
 		case ENETC_CLASS_ID_MAC_FILTER:
+		case ENETC_CLASS_ID_LINK_STATUS:
+		case ENETC_CLASS_ID_LINK_SPEED:
 			break;
 		default:
 			err = -EIO;
@@ -479,6 +481,216 @@ enetc4_vf_promisc_disable(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static int
+enetc4_vf_get_link_status(struct rte_eth_dev *dev, struct enetc_psi_reply_msg *reply_msg)
+{
+	struct enetc_eth_hw *hw = ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
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
+	msg_size = RTE_ALIGN(sizeof(struct enetc_msg_cmd_get_link_status),
+			ENETC_VSI_PSI_MSG_SIZE);
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
+	enetc_msg_vf_fill_common_hdr(msg, ENETC_CLASS_ID_LINK_STATUS,
+			ENETC_CMD_ID_GET_LINK_STATUS, 0, 0, 0);
+
+	/* send the command and wait */
+	err = enetc4_msg_vsi_send(enetc_hw, msg);
+	if (err) {
+		ENETC_PMD_ERR("VSI message send error");
+		goto end;
+	}
+
+	enetc4_msg_vsi_reply_msg(enetc_hw, reply_msg);
+end:
+	/* free memory no longer required */
+	rte_free(msg->vaddr);
+	rte_free(msg);
+	return err;
+}
+
+static int
+enetc4_vf_get_link_speed(struct rte_eth_dev *dev, struct enetc_psi_reply_msg *reply_msg)
+{
+	struct enetc_eth_hw *hw = ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
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
+	msg_size = RTE_ALIGN(sizeof(struct enetc_msg_cmd_get_link_speed),
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
+	enetc_msg_vf_fill_common_hdr(msg, ENETC_CLASS_ID_LINK_SPEED,
+			ENETC_CMD_ID_GET_LINK_SPEED, 0, 0, 0);
+
+	/* send the command and wait */
+	err = enetc4_msg_vsi_send(enetc_hw, msg);
+	if (err) {
+		ENETC_PMD_ERR("VSI message send error");
+		goto end;
+	}
+
+	enetc4_msg_vsi_reply_msg(enetc_hw, reply_msg);
+end:
+	/* free memory no longer required */
+	rte_free(msg->vaddr);
+	rte_free(msg);
+	return err;
+}
+
+static int
+enetc4_vf_link_update(struct rte_eth_dev *dev, int wait_to_complete __rte_unused)
+{
+	struct enetc_psi_reply_msg *reply_msg;
+	struct rte_eth_link link;
+	int err;
+
+	PMD_INIT_FUNC_TRACE();
+	reply_msg = rte_zmalloc(NULL, sizeof(*reply_msg), RTE_CACHE_LINE_SIZE);
+	if (!reply_msg) {
+		ENETC_PMD_ERR("Failed to alloc memory for reply_msg");
+		return -ENOMEM;
+	}
+
+	memset(&link, 0, sizeof(struct rte_eth_link));
+
+	err = enetc4_vf_get_link_status(dev, reply_msg);
+	if (err) {
+		ENETC_PMD_ERR("Failed to get link status");
+		rte_free(reply_msg);
+		return err;
+	}
+
+	if (reply_msg->class_id == ENETC_CLASS_ID_LINK_STATUS) {
+		switch (reply_msg->status) {
+		case ENETC_LINK_UP:
+			link.link_status = RTE_ETH_LINK_UP;
+			break;
+		case ENETC_LINK_DOWN:
+			link.link_status = RTE_ETH_LINK_DOWN;
+			break;
+		default:
+			ENETC_PMD_ERR("Unknown link status");
+			break;
+		}
+	} else {
+		ENETC_PMD_ERR("Wrong reply message");
+		return -1;
+	}
+
+	err = enetc4_vf_get_link_speed(dev, reply_msg);
+	if (err) {
+		ENETC_PMD_ERR("Failed to get link speed");
+		rte_free(reply_msg);
+		return err;
+	}
+
+	if (reply_msg->class_id == ENETC_CLASS_ID_LINK_SPEED) {
+		switch (reply_msg->status) {
+		case ENETC_SPEED_UNKNOWN:
+			ENETC_PMD_DEBUG("Speed unknown");
+			link.link_speed = RTE_ETH_SPEED_NUM_NONE;
+			break;
+		case ENETC_SPEED_10_HALF_DUPLEX:
+			link.link_speed = RTE_ETH_SPEED_NUM_10M;
+			link.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
+			break;
+		case ENETC_SPEED_10_FULL_DUPLEX:
+			link.link_speed = RTE_ETH_SPEED_NUM_10M;
+			link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+			break;
+		case ENETC_SPEED_100_HALF_DUPLEX:
+			link.link_speed = RTE_ETH_SPEED_NUM_100M;
+			link.link_duplex = RTE_ETH_LINK_HALF_DUPLEX;
+			break;
+		case ENETC_SPEED_100_FULL_DUPLEX:
+			link.link_speed = RTE_ETH_SPEED_NUM_100M;
+			link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+			break;
+		case ENETC_SPEED_1000:
+			link.link_speed = RTE_ETH_SPEED_NUM_1G;
+			link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+			break;
+		case ENETC_SPEED_2500:
+			link.link_speed = RTE_ETH_SPEED_NUM_2_5G;
+			link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+			break;
+		case ENETC_SPEED_5000:
+			link.link_speed = RTE_ETH_SPEED_NUM_5G;
+			link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+			break;
+		case ENETC_SPEED_10G:
+			link.link_speed = RTE_ETH_SPEED_NUM_10G;
+			link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+			break;
+		case ENETC_SPEED_25G:
+			link.link_speed = RTE_ETH_SPEED_NUM_25G;
+			link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+			break;
+		case ENETC_SPEED_50G:
+			link.link_speed = RTE_ETH_SPEED_NUM_50G;
+			link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+			break;
+		case ENETC_SPEED_100G:
+			link.link_speed = RTE_ETH_SPEED_NUM_100G;
+			link.link_duplex = RTE_ETH_LINK_FULL_DUPLEX;
+			break;
+		case ENETC_SPEED_NOT_SUPPORTED:
+			ENETC_PMD_DEBUG("Speed not supported");
+			link.link_speed = RTE_ETH_SPEED_NUM_UNKNOWN;
+			break;
+		default:
+			ENETC_PMD_ERR("Unknown speed status");
+			break;
+		}
+	} else {
+		ENETC_PMD_ERR("Wrong reply message");
+		return -1;
+	}
+
+	link.link_autoneg = 1;
+
+	rte_eth_linkstatus_set(dev, &link);
+
+	rte_free(reply_msg);
+	return 0;
+}
+
 static int
 enetc4_vf_vlan_promisc(struct rte_eth_dev *dev, bool promisc_en)
 {
@@ -584,6 +796,7 @@ static const struct eth_dev_ops enetc4_vf_ops = {
 	.promiscuous_disable  = enetc4_vf_promisc_disable,
 	.allmulticast_enable  = enetc4_vf_multicast_enable,
 	.allmulticast_disable = enetc4_vf_multicast_disable,
+	.link_update	      = enetc4_vf_link_update,
 	.vlan_offload_set     = enetc4_vf_vlan_offload_set,
 	.rx_queue_setup       = enetc4_rx_queue_setup,
 	.rx_queue_start       = enetc4_rx_queue_start,
@@ -685,6 +898,9 @@ enetc4_vf_dev_init(struct rte_eth_dev *eth_dev)
 	ENETC_PMD_DEBUG("port_id %d vendorID=0x%x deviceID=0x%x",
 			eth_dev->data->port_id, pci_dev->id.vendor_id,
 			pci_dev->id.device_id);
+	/* update link */
+	enetc4_vf_link_update(eth_dev, 0);
+
 	return 0;
 }
 
-- 
2.25.1

