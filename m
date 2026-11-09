Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E8F606A32A
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 16:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=gBMEQouY
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 111B940ED2;
	Mon,  9 Nov 2026 17:21:06 +0100 (CET)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.222])
 by mails.dpdk.org (Postfix) with ESMTPS id 8DD814028F
 for <dev@dpdk.org>; Mon,  9 Nov 2026 17:20:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=46hAx/WQwFuhd54jelSyhzkUaoUVUtAgaziI+O7FVtI=;
 b=gBMEQouYR0rIMpQKtu79B9uHR1RPPwLPJ0xPmrQ01Q0vICg/qeMBUqEM22dIoH
 oD2g66SRPvC4/vgV/qdx5WENBJCn1cgcTSsjoTYDEKxaB+3IvwHHnFvNG9JYgfZF
 Y02eHaBbMDyUOyaDz1RSEo4khqWD0BD+S4WXHCmK8g4FQ=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v6 12/28] net/hinic3: add CIR drop statistics and VF LAG
 support
Date: Tue, 10 Nov 2026 00:20:16 +0800
Message-ID: <20261109162033.1144-13-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261109162033.1144-1-yejiacheng4@h-partners.com>
References: <20261030144733.2120-1-yejiacheng4@h-partners.com>
 <20261109162033.1144-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgDHX3Hg8vFqjqUoBQ--.4058S14
X-Coremail-Antispam: 1Uf129KBjvJXoW3CFy8WF18Jr47Kw15WryUZFb_yoWktw4fpF
 W5J39rArWDXF48Xwn0g3yUua45Kwn3A347K34xGF90kFn5Xrs8Zay5trWjvr1aqrZrAFy7
 ZayFyrWDGa4jgaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07ULzV8UUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNwYNF2rx8uYPRQAA3u
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Expose the CIR drop counter through the per-port extended statistics and
select the queue COS from the VF LAG bitmap when a VF runs on an
aggregated link.

The CIR drop counter is only available on SP620, so it is added to the
xstats name list there. For an even queue of a VF that is in the LAG
group, the driver flips the COS so the queue egresses through the peer
port; other queues keep the default COS.

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 doc/guides/rel_notes/release_26_11.rst   |  4 ++
 drivers/net/hinic3/base/hinic3_cmd.h     |  2 +
 drivers/net/hinic3/base/hinic3_nic_cfg.c | 62 +++++++++++++++++++
 drivers/net/hinic3/base/hinic3_nic_cfg.h | 45 +++++++++++++-
 drivers/net/hinic3/hinic3_ethdev.c       | 76 +++++++++++++++++++++++-
 drivers/net/hinic3/hinic3_ethdev.h       |  3 +
 6 files changed, 189 insertions(+), 3 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 8ca8379cc6..e0c0e700a7 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -163,6 +163,10 @@ New Features
   * Advertised ``RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP`` capability,
     as flow rules were already kept across device restart.
 
+* **Updated Huawei hinic3 ethernet driver.**
+
+  * Added CIR drop statistics and VF link aggregation (LAG) support.
+
 * **Updated Intel iavf driver.**
 
   * Runtime Rx/Tx queue setup is now automatically disabled
diff --git a/drivers/net/hinic3/base/hinic3_cmd.h b/drivers/net/hinic3/base/hinic3_cmd.h
index f2d5d47522..ecce94690e 100644
--- a/drivers/net/hinic3/base/hinic3_cmd.h
+++ b/drivers/net/hinic3/base/hinic3_cmd.h
@@ -94,6 +94,8 @@ enum hinic3_nic_cmd {
 	/* PORT CFG */
 	HINIC3_NIC_CMD_CFG_PAUSE_INFO			= 101,
 	HINIC3_NIC_CMD_VF_COS				= 104,
+	HINIC3_NIC_CMD_GET_CIR_DROP			= 115,
+	HINIC3_NIC_CMD_CFG_VF_LAG			= 243,
 };
 
 /* COMM commands between driver to MPU. */
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.c b/drivers/net/hinic3/base/hinic3_nic_cfg.c
index fb9b6d4d19..853ca0a41b 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.c
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c
@@ -601,6 +601,33 @@ hinic3_get_pause_info(struct hinic3_hwdev *hwdev, struct nic_pause_config *nic_p
 	return hinic3_cfg_hw_pause(hwdev, HINIC3_CMD_OP_GET, nic_pause);
 }
 
+int
+hinic3_get_cir_drop(void *hwdev, struct hinic3_cir_drop *stats)
+{
+	struct hinic3_port_stats_info stats_info = { 0 };
+	struct hinic3_cmd_get_dp_info_resp vport_stats = { 0 };
+	uint16_t out_size = sizeof(vport_stats);
+	int err;
+
+	if (!hwdev || !stats)
+		return -EINVAL;
+
+	stats_info.func_id = hinic3_global_func_id(hwdev);
+	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC,
+				      HINIC3_NIC_CMD_GET_CIR_DROP,
+				      &stats_info, sizeof(stats_info),
+				      &vport_stats, &out_size);
+	if (err || !out_size || vport_stats.msg_head.status) {
+		PMD_DRV_LOG(ERR, "Get port stats failed, err: %d, status: 0x%x, out size: 0x%x",
+			    err, vport_stats.msg_head.status, out_size);
+		return -EIO;
+	}
+
+	memcpy(stats, vport_stats.value, sizeof(*stats));
+
+	return 0;
+}
+
 int
 hinic3_get_vport_stats(struct hinic3_hwdev *hwdev, struct hinic3_vport_stats *stats)
 {
@@ -1725,3 +1752,38 @@ hinic3_set_link_status_follow(struct hinic3_hwdev *hwdev,
 
 	return follow.head.status;
 }
+
+bool
+hinic3_cmd_vf_lag(void *hwdev, uint16_t func_id, uint8_t opcode)
+{
+	struct hinic3_vf_lag_cmd vf_lag_info = { 0 };
+	uint16_t out_size = sizeof(struct hinic3_vf_lag_cmd);
+	int err;
+
+	if (!hwdev || func_id >= MAX_FUNCTION_NUM)
+		return false;
+	vf_lag_info.func_id = func_id;
+	vf_lag_info.opcode = opcode;
+	vf_lag_info.en_flag = 0;
+
+	err = hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC,
+				      HINIC3_NIC_CMD_CFG_VF_LAG,
+				      &vf_lag_info, sizeof(vf_lag_info),
+				      &vf_lag_info, &out_size);
+	if (vf_lag_info.msg_head.status == HINIC3_MGMT_CMD_UNSUPPORTED)
+		return false;
+
+	if (err || vf_lag_info.msg_head.status || !out_size) {
+		PMD_DRV_LOG(ERR,
+			    "Get vf_lag failed, err: %d, status: 0x%x, out size: 0x%x",
+			    err, vf_lag_info.msg_head.status, out_size);
+		return false;
+	}
+
+	if (opcode == HINIC3_CMD_OPCODE_GET) {
+		return !!(vf_lag_info.vf_lag_bitmap.vf_bit_map[func_id / VF_LAG_VF_NUM_PER_GROUP] &
+			  RTE_BIT32(func_id % VF_LAG_VF_NUM_PER_GROUP));
+	}
+
+	return false;
+}
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.h b/drivers/net/hinic3/base/hinic3_nic_cfg.h
index 6d3eb433bd..6fb56fff4f 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.h
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.h
@@ -17,6 +17,7 @@
 #define HINIC3_DCB_UP_MAX		0x8
 
 #define HINIC3_MAX_NUM_RQ		256
+#define MAX_FUNCTION_NUM		4096
 
 #define HINIC3_MAX_MTU_SIZE		9600
 #define HINIC3_MIN_MTU_SIZE		256
@@ -371,6 +372,18 @@ struct hinic3_port_stats_info {
 	uint16_t rsvd1;
 };
 
+#define HINIC3_CMD_MAX_DP_DATA_NUM 50
+struct hinic3_cir_drop {
+	uint64_t rx_discard_phy;
+};
+
+struct hinic3_cmd_get_dp_info_resp {
+	struct mgmt_msg_head msg_head;
+	uint16_t length;
+	uint16_t rsvd;
+	uint64_t value[HINIC3_CMD_MAX_DP_DATA_NUM];
+};
+
 struct hinic3_vport_stats {
 	uint64_t tx_unicast_pkts_vport;
 	uint64_t tx_unicast_bytes_vport;
@@ -390,6 +403,8 @@ struct hinic3_vport_stats {
 	uint64_t rx_discard_vport;
 	uint64_t tx_err_vport;
 	uint64_t rx_err_vport;
+	uint64_t rx_mtu_err_vport;
+	uint64_t rx_out_of_buffer; /* fw: rx_nowqe */
 };
 
 struct hinic3_cmd_vport_stats {
@@ -398,7 +413,7 @@ struct hinic3_cmd_vport_stats {
 	uint32_t stats_size;
 	uint32_t rsvd1;
 	struct hinic3_vport_stats stats;
-	uint64_t rsvd2[6];
+	uint64_t rsvd2[4];
 };
 
 struct hinic3_phy_port_stats {
@@ -1540,4 +1555,32 @@ int hinic3_set_feature_to_hw(struct hinic3_hwdev *hwdev, uint64_t *s_feature, ui
 
 int hinic3_set_link_status_follow(struct hinic3_hwdev *hwdev,
 				  enum hinic3_link_follow_status status);
+
+/* VF LAG definitions */
+#define VF_LAG_VF_NUM_GROUP_NUM 128
+#define VF_LAG_VF_NUM_PER_GROUP 32
+#define HINIC3_CMD_OPCODE_SET 0
+#define HINIC3_CMD_OPCODE_GET 1
+
+typedef struct hinic3_vf_lag_bitmap_s {
+	uint32_t vf_bit_map[VF_LAG_VF_NUM_GROUP_NUM];
+} hinic3_vf_lag_bitmap;
+
+struct hinic3_vf_lag_cmd {
+	struct mgmt_msg_head msg_head;
+
+	uint16_t func_id;
+	uint8_t opcode; /* 0 -> set, 1 -> get */
+	uint8_t en_flag; /* 0 -> disable, 1 -> enable  */
+	uint8_t bond_active_num;
+	uint8_t bond_active_bitmap;
+	uint8_t mac_sync_flag;
+	uint8_t rsvd;
+	hinic3_vf_lag_bitmap vf_lag_bitmap;
+};
+
+int hinic3_get_cir_drop(void *hwdev, struct hinic3_cir_drop *stats);
+
+bool hinic3_cmd_vf_lag(void *hwdev, uint16_t func_id, uint8_t opcode);
+
 #endif /* _HINIC3_NIC_CFG_H_ */
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 61ea3172fc..46cc19613a 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -80,12 +80,25 @@ struct hinic3_xstats_name_off {
 	uint32_t offset;
 };
 
+#define HINIC3_CIR_DROP_STAT(_stat_item)                                   \
+	{                                                                  \
+		.name = #_stat_item,                                       \
+		.offset = offsetof(struct hinic3_cir_drop, _stat_item),    \
+	}
+
 #define HINIC3_FUNC_STAT(_stat_item)                                       \
 	{                                                                  \
 		.name = #_stat_item,                                       \
 		.offset = offsetof(struct hinic3_vport_stats, _stat_item), \
 	}
 
+
+static struct hinic3_xstats_name_off hinic3_cir_drop_stats_strings[] = {
+	HINIC3_CIR_DROP_STAT(rx_discard_phy),
+};
+
+#define HINIC3_CIR_DROP_XSTATS_NUM  RTE_DIM(hinic3_cir_drop_stats_strings)
+
 static const struct hinic3_xstats_name_off hinic3_vport_stats_strings[] = {
 	HINIC3_FUNC_STAT(tx_unicast_pkts_vport),
 	HINIC3_FUNC_STAT(tx_unicast_bytes_vport),
@@ -105,6 +118,8 @@ static const struct hinic3_xstats_name_off hinic3_vport_stats_strings[] = {
 	HINIC3_FUNC_STAT(rx_discard_vport),
 	HINIC3_FUNC_STAT(tx_err_vport),
 	HINIC3_FUNC_STAT(rx_err_vport),
+	HINIC3_FUNC_STAT(rx_mtu_err_vport),
+	HINIC3_FUNC_STAT(rx_out_of_buffer),
 };
 
 #define HINIC3_VPORT_XSTATS_NUM RTE_DIM(hinic3_vport_stats_strings)
@@ -284,12 +299,16 @@ static const struct hinic3_xstats_name_off hinic3_txq_stats_strings[] = {
 static uint32_t
 hinic3_xstats_calc_num(struct hinic3_nic_dev *nic_dev)
 {
+	uint32_t cir_drop_num = HINIC3_IS_SP620_NIC(nic_dev) ?
+				HINIC3_CIR_DROP_XSTATS_NUM : 0;
+
 	if (HINIC3_IS_VF(nic_dev->hwdev)) {
-		return (HINIC3_VPORT_XSTATS_NUM +
+		return (HINIC3_VPORT_XSTATS_NUM + cir_drop_num +
 			HINIC3_RXQ_XSTATS_NUM * nic_dev->num_rqs +
 			HINIC3_TXQ_XSTATS_NUM * nic_dev->num_sqs);
 	} else {
 		return (HINIC3_VPORT_XSTATS_NUM + HINIC3_PHYPORT_XSTATS_NUM +
+			cir_drop_num +
 			HINIC3_RXQ_XSTATS_NUM * nic_dev->num_rqs +
 			HINIC3_TXQ_XSTATS_NUM * nic_dev->num_sqs);
 	}
@@ -1271,7 +1290,14 @@ hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint16_t qid, uint16_t nb_desc,
 	txq->wqebb_size = (uint16_t)RTE_BIT32(txq->wqebb_shift);
 	txq->tx_free_thresh = tx_free_thresh;
 	txq->owner = 1;
-	txq->cos = nic_dev->default_cos;
+
+	if (!ODD_NUMBER_QUEUE_ID(qid) &&
+		hinic3_cmd_vf_lag(nic_dev->hwdev, hinic3_global_func_id(nic_dev->hwdev),
+				  HINIC3_CMD_OPCODE_GET))
+		txq->cos = SELECT_OTHER_COS_ID(nic_dev->default_cos);
+	else
+		txq->cos = nic_dev->default_cos;
+
 	txq->tx_deferred_start = tx_conf->tx_deferred_start;
 	txq->tx_wqe_compact_task = HINIC3_SUPPORT_TX_WQE_COMPACT_TASK(nic_dev);
 
@@ -2913,6 +2939,38 @@ hinic3_dev_stats_reset(struct rte_eth_dev *dev)
 	return 0;
 }
 
+static uint16_t
+get_port_cir_drop(struct hinic3_nic_dev *nic_dev,
+		  struct rte_eth_xstat *xstats, uint32_t base)
+{
+	struct hinic3_cir_drop port_stats;
+	uint16_t i;
+	int err;
+
+	memset(&port_stats, 0, sizeof(port_stats));
+
+	err = hinic3_get_cir_drop(nic_dev->hwdev, &port_stats);
+	if (err) {
+		PMD_DRV_LOG(ERR, "Failed to get CPB cir drops from fw.");
+
+		for (i = 0; i < RTE_DIM(hinic3_cir_drop_stats_strings); i++) {
+			xstats[i].value = 0;
+			xstats[i].id = base + i;
+		}
+
+		return RTE_DIM(hinic3_cir_drop_stats_strings);
+	}
+
+	for (i = 0; i < RTE_DIM(hinic3_cir_drop_stats_strings); i++) {
+		memcpy(&xstats[i].value,
+		       (const char *)&port_stats + hinic3_cir_drop_stats_strings[i].offset,
+		       sizeof(uint64_t));
+		xstats[i].id = base + i;
+	}
+
+	return RTE_DIM(hinic3_cir_drop_stats_strings);
+}
+
 /**
  * Get device extended statistics.
  *
@@ -3001,6 +3059,10 @@ hinic3_dev_xstats_get(struct rte_eth_dev *dev, struct rte_eth_xstat *xstats,
 		count++;
 	}
 
+	/* Get stats from cir drop stats structure */
+	if (HINIC3_IS_SP620_NIC(nic_dev))
+		count += get_port_cir_drop(nic_dev, &xstats[count], count);
+
 	if (HINIC3_IS_VF(nic_dev->hwdev))
 		return count;
 
@@ -3101,6 +3163,16 @@ hinic3_dev_xstats_get_names(struct rte_eth_dev *dev,
 		count++;
 	}
 
+	/* Get cir drop stats name. */
+	if (HINIC3_IS_SP620_NIC(nic_dev)) {
+		for (i = 0; i < HINIC3_CIR_DROP_XSTATS_NUM; i++) {
+			strlcpy(xstats_names[count].name,
+				hinic3_cir_drop_stats_strings[i].name,
+				sizeof(xstats_names[count].name));
+			count++;
+		}
+	}
+
 	if (HINIC3_IS_VF(nic_dev->hwdev))
 		return count;
 
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
index f4d8c16640..c3384e5fd0 100644
--- a/drivers/net/hinic3/hinic3_ethdev.h
+++ b/drivers/net/hinic3/hinic3_ethdev.h
@@ -162,6 +162,9 @@ struct hinic3_nic_dev {
 
 };
 
+#define SELECT_OTHER_COS_ID(cos_id) ((cos_id) ^ 4)
+#define ODD_NUMBER_QUEUE_ID(q_id) ((q_id) & 1)
+
 #define HINIC3_IS_SP620_NIC(nic_dev) ((nic_dev)->nic_type == NIC_SP620)
 #define HINIC3_IS_SP230_NIC(nic_dev) ((nic_dev)->nic_type == NIC_SP230)
 
-- 
2.33.0

