Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB48CCD19A
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 09:20:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D896942DD1;
	Fri, 17 Oct 2025 11:19:48 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id AB21942D0B
 for <dev@dpdk.org>; Fri, 17 Oct 2025 11:19:36 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 914501A0E24;
 Fri, 17 Oct 2025 11:19:36 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 659B41A32FF;
 Fri, 17 Oct 2025 11:19:36 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id DD5BB180009C;
 Fri, 17 Oct 2025 17:19:35 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org, Gagandeep Singh <g.singh@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [v2 11/12] net/enetc: Add MAC and VLAN filter support
Date: Fri, 17 Oct 2025 14:49:28 +0530
Message-Id: <20251017091929.2723044-12-vanshika.shukla@nxp.com>
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

Introduces support for:

- Up to 4 MAC addresses filtering
- Up to 4 VLAN filters

Enhances packet filtering capabilities for ENETC4 PMD.

Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/nics/features/enetc4.ini |   2 +
 drivers/net/enetc/base/enetc4_hw.h  |   3 +
 drivers/net/enetc/enetc.h           |  11 ++
 drivers/net/enetc/enetc4_vf.c       | 229 +++++++++++++++++++++++++++-
 4 files changed, 244 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/features/enetc4.ini b/doc/guides/nics/features/enetc4.ini
index 31a1955215..87425f45c9 100644
--- a/doc/guides/nics/features/enetc4.ini
+++ b/doc/guides/nics/features/enetc4.ini
@@ -9,6 +9,8 @@ Speed capabilities   = Y
 Link status          = Y
 Promiscuous mode     = Y
 Allmulticast mode    = Y
+Unicast MAC filter   = Y
+VLAN filter          = Y
 RSS hash             = Y
 Packet type parsing  = Y
 Basic stats          = Y
diff --git a/drivers/net/enetc/base/enetc4_hw.h b/drivers/net/enetc/base/enetc4_hw.h
index f2c5d6069e..9685e7e1e5 100644
--- a/drivers/net/enetc/base/enetc4_hw.h
+++ b/drivers/net/enetc/base/enetc4_hw.h
@@ -73,6 +73,9 @@ struct enetc_msg_swbd {
  */
 #define ENETC4_MAC_MAXFRM_SIZE  2000
 
+/* Number of MAC Address Filter table entries */
+#define ENETC4_MAC_ENTRIES      4
+
 /* Port MAC 0/1 Maximum Frame Length Register */
 #define ENETC4_PM_MAXFRM(mac)		(0x5014 + (mac) * 0x400)
 
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index 4382d76484..09168c90db 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -157,7 +157,10 @@ enum enetc_msg_cmd_class_id {
 /* Enum for command IDs */
 enum enetc_msg_cmd_id {
 	ENETC_CMD_ID_SET_PRIMARY_MAC = 0,
+	ENETC_MSG_ADD_EXACT_MAC_ENTRIES = 1,
 	ENETC_CMD_ID_SET_MAC_PROMISCUOUS = 5,
+	ENETC_MSG_ADD_EXACT_VLAN_ENTRIES = 0,
+	ENETC_MSG_REMOVE_EXACT_VLAN_ENTRIES = 1,
 	ENETC_CMD_ID_SET_VLAN_PROMISCUOUS = 4,
 	ENETC_CMD_ID_GET_LINK_STATUS = 0,
 	ENETC_CMD_ID_REGISTER_LINK_NOTIF = 1,
@@ -169,6 +172,14 @@ enum mac_addr_status {
 	ENETC_INVALID_MAC_ADDR = 0x0,
 	ENETC_DUPLICATE_MAC_ADDR = 0X1,
 	ENETC_MAC_ADDR_NOT_FOUND = 0X2,
+	ENETC_MAC_FILTER_NO_RESOURCE = 0x3
+};
+
+enum vlan_status {
+	ENETC_INVALID_VLAN_ENTRY = 0x0,
+	ENETC_DUPLICATE_VLAN_ENTRY = 0X1,
+	ENETC_VLAN_ENTRY_NOT_FOUND = 0x2,
+	ENETC_VLAN_NO_RESOURCE = 0x3
 };
 
 enum link_status {
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index a6b411468a..376e2a3a76 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -17,6 +17,10 @@
 uint16_t enetc_crc_table[ENETC_CRC_TABLE_SIZE];
 bool enetc_crc_gen;
 
+/* Supported Rx offloads */
+static uint64_t dev_vf_rx_offloads_sup =
+	RTE_ETH_RX_OFFLOAD_VLAN_FILTER;
+
 static void
 enetc_gen_crc_table(void)
 {
@@ -53,6 +57,25 @@ enetc_crc_calc(uint16_t crc, const uint8_t *buffer, size_t len)
 	return crc;
 }
 
+static int
+enetc4_vf_dev_infos_get(struct rte_eth_dev *dev,
+			struct rte_eth_dev_info *dev_info)
+{
+	int ret = 0;
+
+	PMD_INIT_FUNC_TRACE();
+
+	ret = enetc4_dev_infos_get(dev, dev_info);
+	if (ret)
+		return ret;
+
+	dev_info->max_mtu = dev_info->max_rx_pktlen - (RTE_ETHER_HDR_LEN + RTE_ETHER_CRC_LEN);
+	dev_info->max_mac_addrs = ENETC4_MAC_ENTRIES;
+	dev_info->rx_offload_capa |= dev_vf_rx_offloads_sup;
+
+	return 0;
+}
+
 int
 enetc4_vf_dev_stop(struct rte_eth_dev *dev __rte_unused)
 {
@@ -810,6 +833,201 @@ enetc4_vf_vlan_promisc(struct rte_eth_dev *dev, bool promisc_en)
 	return err;
 }
 
+static int
+enetc4_vf_mac_addr_add(struct rte_eth_dev *dev, struct rte_ether_addr *addr,
+			uint32_t index __rte_unused, uint32_t pool __rte_unused)
+{
+	struct enetc_eth_hw *hw = ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
+	struct enetc_msg_cmd_set_primary_mac *cmd;
+	struct enetc_msg_swbd *msg;
+	struct enetc_psi_reply_msg *reply_msg;
+	uint32_t msg_size;
+	int err = 0;
+
+	PMD_INIT_FUNC_TRACE();
+
+	if (!rte_is_valid_assigned_ether_addr(addr))
+		return -EINVAL;
+
+	reply_msg = rte_zmalloc(NULL, sizeof(*reply_msg), RTE_CACHE_LINE_SIZE);
+	if (!reply_msg) {
+		ENETC_PMD_ERR("Failed to alloc memory for reply_msg");
+		return -ENOMEM;
+	}
+
+	msg = rte_zmalloc(NULL, sizeof(*msg), RTE_CACHE_LINE_SIZE);
+	if (!msg) {
+		ENETC_PMD_ERR("Failed to alloc msg");
+		err = -ENOMEM;
+		rte_free(reply_msg);
+		return err;
+	}
+
+	msg_size = RTE_ALIGN(sizeof(struct enetc_msg_cmd_set_primary_mac),
+			ENETC_VSI_PSI_MSG_SIZE);
+	msg->vaddr = rte_zmalloc(NULL, msg_size, 0);
+	if (!msg->vaddr) {
+		ENETC_PMD_ERR("Failed to alloc memory for msg");
+		rte_free(msg);
+		rte_free(reply_msg);
+		return -ENOMEM;
+	}
+	msg->dma = rte_mem_virt2iova((const void *)msg->vaddr);
+	msg->size = msg_size;
+	cmd = (struct enetc_msg_cmd_set_primary_mac *)msg->vaddr;
+	memcpy(&cmd->addr.addr_bytes, addr, sizeof(struct rte_ether_addr));
+	cmd->count = 1;
+
+	enetc_msg_vf_fill_common_hdr(msg, ENETC_CLASS_ID_MAC_FILTER,
+			ENETC_MSG_ADD_EXACT_MAC_ENTRIES, 0, 0, 0);
+
+	/* send the command and wait */
+	err = enetc4_msg_vsi_send(enetc_hw, msg);
+	if (err) {
+		ENETC_PMD_ERR("VSI message send error");
+		goto end;
+	}
+
+	enetc4_msg_vsi_reply_msg(enetc_hw, reply_msg);
+
+	if (reply_msg->class_id == ENETC_CLASS_ID_MAC_FILTER) {
+		switch (reply_msg->status) {
+		case ENETC_INVALID_MAC_ADDR:
+			ENETC_PMD_ERR("Invalid MAC address");
+			err = -EINVAL;
+			break;
+		case ENETC_DUPLICATE_MAC_ADDR:
+			ENETC_PMD_ERR("Duplicate MAC address");
+			err = -EINVAL;
+			break;
+		case ENETC_MAC_FILTER_NO_RESOURCE:
+			ENETC_PMD_ERR("Not enough exact-match entries available");
+			err = -EINVAL;
+			break;
+		default:
+			err = -EINVAL;
+			break;
+		}
+	}
+
+	if (err) {
+		ENETC_PMD_ERR("VSI command execute error!");
+		goto end;
+	}
+
+end:
+	/* free memory no longer required */
+	rte_free(msg->vaddr);
+	rte_free(reply_msg);
+	rte_free(msg);
+	return err;
+}
+
+static int enetc4_vf_vlan_filter_set(struct rte_eth_dev *dev, uint16_t vlan_id, int on)
+{
+	struct enetc_eth_hw *hw = ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
+	struct enetc_msg_vlan_exact_filter *cmd;
+	struct enetc_msg_swbd *msg;
+	struct enetc_psi_reply_msg *reply_msg;
+	uint32_t msg_size;
+	int err = 0;
+
+	PMD_INIT_FUNC_TRACE();
+
+	reply_msg = rte_zmalloc(NULL, sizeof(*reply_msg), RTE_CACHE_LINE_SIZE);
+	if (!reply_msg) {
+		ENETC_PMD_ERR("Failed to alloc memory for reply_msg");
+		return -ENOMEM;
+	}
+
+	msg = rte_zmalloc(NULL, sizeof(*msg), RTE_CACHE_LINE_SIZE);
+	if (!msg) {
+		ENETC_PMD_ERR("Failed to alloc msg");
+		err = -ENOMEM;
+		rte_free(reply_msg);
+		return err;
+	}
+
+	msg_size = RTE_ALIGN(sizeof(struct enetc_msg_vlan_exact_filter),
+			ENETC_VSI_PSI_MSG_SIZE);
+	msg->vaddr = rte_zmalloc(NULL, msg_size, 0);
+	if (!msg->vaddr) {
+		ENETC_PMD_ERR("Failed to alloc memory for msg");
+		rte_free(msg);
+		rte_free(reply_msg);
+		return -ENOMEM;
+	}
+	msg->dma = rte_mem_virt2iova((const void *)msg->vaddr);
+	msg->size = msg_size;
+	cmd = (struct enetc_msg_vlan_exact_filter *)msg->vaddr;
+	cmd->vlan_count = 1;
+	cmd->vlan_id = vlan_id;
+
+	/* TPID 2-bit encoding value is taken from the H/W block guide:
+	 *	00b Standard C-VLAN 0x8100
+	 *	01b Standard S-VLAN 0x88A8
+	 *	10b Custom VLAN as defined by CVLANR1[ETYPE]
+	 *	11b Custom VLAN as defined by CVLANR2[ETYPE]
+	 * Currently Standard C-VLAN is supported. To support others in future.
+	 */
+	cmd->tpid = 0;
+
+	if (on) {
+		enetc_msg_vf_fill_common_hdr(msg, ENETC_CLASS_ID_VLAN_FILTER,
+				ENETC_MSG_ADD_EXACT_VLAN_ENTRIES, 0, 0, 0);
+	} else {
+		enetc_msg_vf_fill_common_hdr(msg, ENETC_CLASS_ID_VLAN_FILTER,
+				ENETC_MSG_REMOVE_EXACT_VLAN_ENTRIES, 0, 0, 0);
+	}
+
+	/* send the command and wait */
+	err = enetc4_msg_vsi_send(enetc_hw, msg);
+	if (err) {
+		ENETC_PMD_ERR("VSI message send error");
+		goto end;
+	}
+
+	enetc4_msg_vsi_reply_msg(enetc_hw, reply_msg);
+
+	if (reply_msg->class_id == ENETC_CLASS_ID_VLAN_FILTER) {
+		switch (reply_msg->status) {
+		case ENETC_INVALID_VLAN_ENTRY:
+			ENETC_PMD_ERR("VLAN entry not valid");
+			err = -EINVAL;
+			break;
+		case ENETC_DUPLICATE_VLAN_ENTRY:
+			ENETC_PMD_ERR("Duplicated VLAN entry");
+			err = -EINVAL;
+			break;
+		case ENETC_VLAN_ENTRY_NOT_FOUND:
+			ENETC_PMD_ERR("VLAN entry not found");
+			err = -EINVAL;
+			break;
+		case ENETC_VLAN_NO_RESOURCE:
+			ENETC_PMD_ERR("Not enough exact-match entries available");
+			err = -EINVAL;
+			break;
+		default:
+			err = -EINVAL;
+			break;
+		}
+	}
+
+	if (err) {
+		ENETC_PMD_ERR("VSI command execute error!");
+		goto end;
+	}
+
+end:
+	/* free memory no longer required */
+	rte_free(msg->vaddr);
+	rte_free(reply_msg);
+	rte_free(msg);
+	return err;
+}
+
 static int enetc4_vf_vlan_offload_set(struct rte_eth_dev *dev, int mask __rte_unused)
 {
 	int err = 0;
@@ -838,6 +1056,12 @@ static int enetc4_vf_vlan_offload_set(struct rte_eth_dev *dev, int mask __rte_un
 	return 0;
 }
 
+static int
+enetc4_vf_mtu_set(struct rte_eth_dev *dev __rte_unused, uint16_t mtu __rte_unused)
+{
+	return 0;
+}
+
 static int
 enetc4_vf_link_register_notif(struct rte_eth_dev *dev, bool enable)
 {
@@ -901,14 +1125,17 @@ static const struct eth_dev_ops enetc4_vf_ops = {
 	.dev_start            = enetc4_vf_dev_start,
 	.dev_stop             = enetc4_vf_dev_stop,
 	.dev_close            = enetc4_dev_close,
-	.dev_infos_get        = enetc4_dev_infos_get,
 	.stats_get            = enetc4_vf_stats_get,
+	.dev_infos_get        = enetc4_vf_dev_infos_get,
+	.mtu_set              = enetc4_vf_mtu_set,
 	.mac_addr_set         = enetc4_vf_set_mac_addr,
+	.mac_addr_add	      = enetc4_vf_mac_addr_add,
 	.promiscuous_enable   = enetc4_vf_promisc_enable,
 	.promiscuous_disable  = enetc4_vf_promisc_disable,
 	.allmulticast_enable  = enetc4_vf_multicast_enable,
 	.allmulticast_disable = enetc4_vf_multicast_disable,
 	.link_update	      = enetc4_vf_link_update,
+	.vlan_filter_set      = enetc4_vf_vlan_filter_set,
 	.vlan_offload_set     = enetc4_vf_vlan_offload_set,
 	.rx_queue_setup       = enetc4_rx_queue_setup,
 	.rx_queue_start       = enetc4_rx_queue_start,
-- 
2.25.1

