Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C21DCCCD187
	for <dpdk-dev@archiver.kernel.org>; Thu,  9 Oct 2025 11:17:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 234F140697;
	Thu,  9 Oct 2025 13:16:47 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 5E19C40277
 for <dev@dpdk.org>; Thu,  9 Oct 2025 13:16:39 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 401091A20B6;
 Thu,  9 Oct 2025 13:16:39 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D94941A3D16;
 Thu,  9 Oct 2025 13:16:38 +0200 (CEST)
Received: from lsv03379.swis.in-blr01.nxp.com (lsv03379.swis.in-blr01.nxp.com
 [92.120.147.188])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 0FC151800089;
 Thu,  9 Oct 2025 19:16:38 +0800 (+08)
From: vanshika.shukla@nxp.com
To: dev@dpdk.org, Gagandeep Singh <g.singh@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>,
 Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [v1 08/12] net/enetc: Add VF to PF messaging support and primary MAC
 setup
Date: Thu,  9 Oct 2025 16:46:29 +0530
Message-Id: <20251009111633.3585957-9-vanshika.shukla@nxp.com>
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

Introduces Virtual Function (VF) to Physical Function (PF) messaging,
enabling VFs to communicate with the Linux PF driver for feature
enablement.

This patch also adds primary MAC address setup capability,
allowing VFs to configure their MAC addresses.

Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/net/enetc/base/enetc4_hw.h |  22 +++
 drivers/net/enetc/enetc.h          |  99 +++++++++++
 drivers/net/enetc/enetc4_vf.c      | 260 +++++++++++++++++++++++++++++
 3 files changed, 381 insertions(+)

diff --git a/drivers/net/enetc/base/enetc4_hw.h b/drivers/net/enetc/base/enetc4_hw.h
index 49446f2cb4..f0b7563d22 100644
--- a/drivers/net/enetc/base/enetc4_hw.h
+++ b/drivers/net/enetc/base/enetc4_hw.h
@@ -14,6 +14,12 @@
 #define ENETC4_DEV_ID_VF	0xef00
 #define PCI_VENDOR_ID_NXP	0x1131
 
+struct enetc_msg_swbd {
+	void *vaddr;
+	uint64_t dma;
+	int size;
+};
+
 /* enetc4 txbd flags */
 #define ENETC4_TXBD_FLAGS_L4CS		BIT(0)
 #define ENETC4_TXBD_FLAGS_L_TX_CKSUM	BIT(3)
@@ -103,6 +109,9 @@
 #define IFMODE_SGMII			5
 #define PM_IF_MODE_ENA			BIT(15)
 
+#define ENETC4_DEF_VSI_WAIT_TIMEOUT_UPDATE     100
+#define ENETC4_DEF_VSI_WAIT_DELAY_UPDATE       2000 /* us */
+
 /* Station interface statistics */
 #define ENETC4_SIROCT0           0x300
 #define ENETC4_SIRFRM0           0x308
@@ -110,6 +119,19 @@
 #define ENETC4_SITFRM0           0x328
 #define ENETC4_SITDFCR           0x340
 
+/* VSI MSG Registers */
+#define ENETC4_VSIMSGSR  0x204   /* RO */
+#define ENETC4_VSIMSGSR_MB       BIT(0)
+#define ENETC4_VSIMSGSR_MS       BIT(1)
+#define ENETC4_VSIMSGSNDAR0      0x210
+#define ENETC4_VSIMSGSNDAR1      0x214
+
+#define ENETC4_VSIMSGRR		 0x208
+#define ENETC4_VSIMSGRR_MR       BIT(0)
+
+#define ENETC_SIMSGSR_SET_MC(val) ((val) << 16)
+#define ENETC_SIMSGSR_GET_MC(val) ((val) >> 16)
+
 /* Control BDR regs */
 #define ENETC4_SICBDRMR		0x800
 #define ENETC4_SICBDRSR		0x804   /* RO */
diff --git a/drivers/net/enetc/enetc.h b/drivers/net/enetc/enetc.h
index ff2ba7dc01..4303a17fe9 100644
--- a/drivers/net/enetc/enetc.h
+++ b/drivers/net/enetc/enetc.h
@@ -41,6 +41,11 @@
 /* eth name size */
 #define ENETC_ETH_NAMESIZE	20
 
+#define ENETC_DEFAULT_MSG_SIZE  1024    /* max size */
+
+/* Message length is in multiple of 32 bytes */
+#define ENETC_VSI_PSI_MSG_SIZE  32
+
 /* size for marking hugepage non-cacheable */
 #define SIZE_2MB	0x200000
 
@@ -122,6 +127,100 @@ struct enetc_eth_adapter {
 #define ENETC_DEV_PRIVATE_TO_INTR(adapter) \
 	(&((struct enetc_eth_adapter *)adapter)->intr)
 
+/* Class ID for PSI-TO-VSI messages */
+#define ENETC_MSG_CLASS_ID_CMD_SUCCESS          0x1
+#define ENETC_MSG_CLASS_ID_PERMISSION_DENY      0x2
+#define ENETC_MSG_CLASS_ID_CMD_NOT_SUPPORT      0x3
+#define ENETC_MSG_CLASS_ID_PSI_BUSY             0x4
+#define ENETC_MSG_CLASS_ID_CRC_ERROR            0x5
+#define ENETC_MSG_CLASS_ID_PROTO_NOT_SUPPORT    0x6
+#define ENETC_MSG_CLASS_ID_INVALID_MSG_LEN      0x7
+#define ENETC_MSG_CLASS_ID_CMD_TIMEOUT          0x8
+#define ENETC_MSG_CLASS_ID_CMD_DEFERED          0xf
+
+#define ENETC_PROMISC_DISABLE			0x41
+#define ENETC_PROMISC_ENABLE			0x43
+#define ENETC_ALLMULTI_PROMISC_DIS		0x81
+#define ENETC_ALLMULTI_PROMISC_EN		0x83
+
+
+/* Enum for class IDs */
+enum enetc_msg_cmd_class_id {
+	ENETC_CLASS_ID_MAC_FILTER = 0x20,
+};
+
+/* Enum for command IDs */
+enum enetc_msg_cmd_id {
+	ENETC_CMD_ID_SET_PRIMARY_MAC = 0,
+};
+
+enum mac_addr_status {
+	ENETC_INVALID_MAC_ADDR = 0x0,
+	ENETC_DUPLICATE_MAC_ADDR = 0X1,
+	ENETC_MAC_ADDR_NOT_FOUND = 0X2,
+};
+
+/* PSI-VSI command header format */
+struct enetc_msg_cmd_header {
+	uint16_t csum;		/* INET_CHECKSUM */
+	uint8_t class_id;       /* Command class type */
+	uint8_t cmd_id;         /* Denotes the specific required action */
+	uint8_t proto_ver;	/* Supported VSI-PSI command protocol version */
+	uint8_t len;		/* Extended message body length */
+	uint8_t reserved_1;
+	uint8_t cookie;	/* Control command execution asynchronously on PSI side */
+	uint64_t reserved_2;
+};
+
+/* VF-PF set primary MAC address message format */
+struct enetc_msg_cmd_set_primary_mac {
+	struct enetc_msg_cmd_header header;
+	uint8_t count;	/* number of MAC addresses */
+	uint8_t reserved_1;
+	uint16_t reserved_2;
+	struct rte_ether_addr addr;
+};
+
+struct enetc_msg_cmd_set_promisc {
+	struct enetc_msg_cmd_header header;
+	uint8_t op_type;
+};
+
+struct enetc_msg_cmd_get_link_status {
+	struct enetc_msg_cmd_header header;
+};
+
+struct enetc_msg_cmd_get_link_speed {
+	struct enetc_msg_cmd_header header;
+};
+
+struct enetc_msg_cmd_set_vlan_promisc {
+	struct enetc_msg_cmd_header header;
+	uint8_t op;
+	uint8_t reserved;
+};
+
+struct enetc_msg_vlan_exact_filter {
+	struct enetc_msg_cmd_header header;
+	uint8_t vlan_count;
+	uint8_t reserved_1;
+	uint16_t reserved_2;
+	uint16_t vlan_id;
+	uint8_t tpid;
+	uint8_t reserved2;
+};
+
+struct enetc_psi_reply_msg {
+	uint8_t class_id;
+	uint8_t status;
+};
+
+/* msg size encoding: default and max msg value of 1024B encoded as 0 */
+static inline uint32_t enetc_vsi_set_msize(uint32_t size)
+{
+	return size < ENETC_DEFAULT_MSG_SIZE ? size >> 5 : 0;
+}
+
 /*
  * ENETC4 function prototypes
  */
diff --git a/drivers/net/enetc/enetc4_vf.c b/drivers/net/enetc/enetc4_vf.c
index a9fb33c432..6bdd476f0a 100644
--- a/drivers/net/enetc/enetc4_vf.c
+++ b/drivers/net/enetc/enetc4_vf.c
@@ -8,6 +8,51 @@
 #include "enetc_logs.h"
 #include "enetc.h"
 
+#define ENETC_CRC_TABLE_SIZE		256
+#define ENETC_POLY			0x1021
+#define ENETC_CRC_INIT			0xffff
+#define ENETC_BYTE_SIZE			8
+#define ENETC_MSB_BIT			0x8000
+
+uint16_t enetc_crc_table[ENETC_CRC_TABLE_SIZE];
+bool enetc_crc_gen;
+
+static void
+enetc_gen_crc_table(void)
+{
+	uint16_t crc = 0;
+	uint16_t c;
+
+	for (int i = 0; i < ENETC_CRC_TABLE_SIZE; i++) {
+		crc = 0;
+		c = i << ENETC_BYTE_SIZE;
+		for (int j = 0; j < ENETC_BYTE_SIZE; j++) {
+			if ((crc ^ c) & ENETC_MSB_BIT)
+				crc = (crc << 1) ^ ENETC_POLY;
+			else
+				crc = crc << 1;
+			c = c << 1;
+		}
+
+		enetc_crc_table[i] = crc;
+	}
+
+	enetc_crc_gen = true;
+}
+
+static uint16_t
+enetc_crc_calc(uint16_t crc, const uint8_t *buffer, size_t len)
+{
+	uint8_t data;
+
+	while (len--) {
+		data = *buffer;
+		crc = (crc << 8) ^ enetc_crc_table[((crc >> 8) ^ data) & 0xff];
+		buffer++;
+	}
+	return crc;
+}
+
 int
 enetc4_vf_dev_stop(struct rte_eth_dev *dev __rte_unused)
 {
@@ -47,6 +92,217 @@ enetc4_vf_stats_get(struct rte_eth_dev *dev,
 	return 0;
 }
 
+
+static void
+enetc_msg_vf_fill_common_hdr(struct enetc_msg_swbd *msg,
+					uint8_t class_id, uint8_t cmd_id, uint8_t proto_ver,
+					uint8_t len, uint8_t cookie)
+{
+	struct enetc_msg_cmd_header *hdr = msg->vaddr;
+
+	hdr->class_id = class_id;
+	hdr->cmd_id = cmd_id;
+	hdr->proto_ver = proto_ver;
+	hdr->len = len;
+	hdr->cookie = cookie;
+	/* Incrementing msg 2 bytes ahead as the first two bytes are for CRC */
+	hdr->csum = rte_cpu_to_be_16(enetc_crc_calc(ENETC_CRC_INIT,
+				(uint8_t *)msg->vaddr + sizeof(uint16_t),
+				msg->size - sizeof(uint16_t)));
+
+	dcbf(hdr);
+}
+
+/* Messaging */
+static void
+enetc4_msg_vsi_write_msg(struct enetc_hw *hw,
+		struct enetc_msg_swbd *msg)
+{
+	uint32_t val;
+
+	val = enetc_vsi_set_msize(msg->size) | lower_32_bits(msg->dma);
+	enetc_wr(hw, ENETC4_VSIMSGSNDAR1, upper_32_bits(msg->dma));
+	enetc_wr(hw, ENETC4_VSIMSGSNDAR0, val);
+}
+
+static void
+enetc4_msg_vsi_reply_msg(struct enetc_hw *enetc_hw, struct enetc_psi_reply_msg *reply_msg)
+{
+	int vsimsgsr;
+	int8_t class_id = 0;
+	uint8_t status = 0;
+
+	vsimsgsr = enetc_rd(enetc_hw, ENETC4_VSIMSGSR);
+
+	/* Extracting 8 bits of message result in class_id */
+	class_id |= ((ENETC_SIMSGSR_GET_MC(vsimsgsr) >> 8) & 0xff);
+
+	/* Extracting 4 bits of message result in status */
+	status |= ((ENETC_SIMSGSR_GET_MC(vsimsgsr) >> 4) & 0xf);
+
+	reply_msg->class_id = class_id;
+	reply_msg->status = status;
+}
+
+static int
+enetc4_msg_vsi_send(struct enetc_hw *enetc_hw, struct enetc_msg_swbd *msg)
+{
+	int timeout = ENETC4_DEF_VSI_WAIT_TIMEOUT_UPDATE;
+	int delay_us = ENETC4_DEF_VSI_WAIT_DELAY_UPDATE;
+	uint8_t class_id = 0;
+	int err = 0;
+	int vsimsgsr;
+
+	enetc4_msg_vsi_write_msg(enetc_hw, msg);
+
+	do {
+		vsimsgsr = enetc_rd(enetc_hw, ENETC4_VSIMSGSR);
+		if (!(vsimsgsr & ENETC4_VSIMSGSR_MB))
+			break;
+		rte_delay_us(delay_us);
+	} while (--timeout);
+
+	if (!timeout) {
+		ENETC_PMD_ERR("Message not processed by PSI");
+		return -ETIMEDOUT;
+	}
+	/* check for message delivery error */
+	if (vsimsgsr & ENETC4_VSIMSGSR_MS) {
+		ENETC_PMD_ERR("Transfer error when copying the data");
+		return -EIO;
+	}
+
+	class_id |= ((ENETC_SIMSGSR_GET_MC(vsimsgsr) >> 8) & 0xff);
+
+	/* Check the user-defined completion status. */
+	if (class_id != ENETC_MSG_CLASS_ID_CMD_SUCCESS) {
+		switch (class_id) {
+		case ENETC_MSG_CLASS_ID_PERMISSION_DENY:
+			ENETC_PMD_ERR("Permission denied");
+			err = -EACCES;
+			break;
+		case ENETC_MSG_CLASS_ID_CMD_NOT_SUPPORT:
+			ENETC_PMD_ERR("Command not supported");
+			err = -EOPNOTSUPP;
+			break;
+		case ENETC_MSG_CLASS_ID_PSI_BUSY:
+			ENETC_PMD_ERR("PSI Busy");
+			err = -EBUSY;
+			break;
+		case ENETC_MSG_CLASS_ID_CMD_TIMEOUT:
+			ENETC_PMD_ERR("Command timeout");
+			err = -ETIME;
+			break;
+		case ENETC_MSG_CLASS_ID_CRC_ERROR:
+			ENETC_PMD_ERR("CRC error");
+			err = -EIO;
+			break;
+		case ENETC_MSG_CLASS_ID_PROTO_NOT_SUPPORT:
+			ENETC_PMD_ERR("Protocol Version not supported");
+			err = -EOPNOTSUPP;
+			break;
+		case ENETC_MSG_CLASS_ID_INVALID_MSG_LEN:
+			ENETC_PMD_ERR("Invalid message length");
+			err = -EINVAL;
+			break;
+		case ENETC_CLASS_ID_MAC_FILTER:
+			break;
+		default:
+			err = -EIO;
+		}
+	}
+
+	return err;
+}
+
+static int
+enetc4_vf_set_mac_addr(struct rte_eth_dev *dev, struct rte_ether_addr *addr)
+{
+	struct enetc_eth_hw *hw = ENETC_DEV_PRIVATE_TO_HW(dev->data->dev_private);
+	struct enetc_hw *enetc_hw = &hw->hw;
+	struct enetc_msg_cmd_set_primary_mac *cmd;
+	struct enetc_msg_swbd *msg;
+	struct enetc_psi_reply_msg *reply_msg;
+	int msg_size;
+	int err = 0;
+
+	PMD_INIT_FUNC_TRACE();
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
+				ENETC_VSI_PSI_MSG_SIZE);
+	msg->vaddr = rte_zmalloc(NULL, msg_size, 0);
+	if (!msg->vaddr) {
+		ENETC_PMD_ERR("Failed to alloc memory for msg");
+		rte_free(msg);
+		rte_free(reply_msg);
+		return -ENOMEM;
+	}
+
+	msg->dma = rte_mem_virt2iova((const void *)msg->vaddr);
+	msg->size = msg_size;
+
+	cmd = (struct enetc_msg_cmd_set_primary_mac *)msg->vaddr;
+
+	cmd->count = 0;
+	memcpy(&cmd->addr.addr_bytes, addr, sizeof(struct rte_ether_addr));
+
+	enetc_msg_vf_fill_common_hdr(msg, ENETC_CLASS_ID_MAC_FILTER,
+					ENETC_CMD_ID_SET_PRIMARY_MAC, 0, 0, 0);
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
+	rte_ether_addr_copy((struct rte_ether_addr *)&cmd->addr,
+			&dev->data->mac_addrs[0]);
+
+end:
+	/* free memory no longer required */
+	rte_free(msg->vaddr);
+	rte_free(reply_msg);
+	rte_free(msg);
+	return err;
+}
+
 /*
  * The set of PCI devices this driver supports
  */
@@ -63,6 +319,7 @@ static const struct eth_dev_ops enetc4_vf_ops = {
 	.dev_close            = enetc4_dev_close,
 	.dev_infos_get        = enetc4_dev_infos_get,
 	.stats_get            = enetc4_vf_stats_get,
+	.mac_addr_set         = enetc4_vf_set_mac_addr,
 	.rx_queue_setup       = enetc4_rx_queue_setup,
 	.rx_queue_start       = enetc4_rx_queue_start,
 	.rx_queue_stop        = enetc4_rx_queue_stop,
@@ -121,6 +378,9 @@ enetc4_vf_mac_init(struct enetc_eth_hw *hw, struct rte_eth_dev *eth_dev)
 		return -ENOMEM;
 	}
 
+	if (!enetc_crc_gen)
+		enetc_gen_crc_table();
+
 	/* Copy the permanent MAC address */
 	rte_ether_addr_copy((struct rte_ether_addr *)hw->mac.addr,
 			     &eth_dev->data->mac_addrs[0]);
-- 
2.25.1

