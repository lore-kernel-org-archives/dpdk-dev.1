Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 258DFCA9EBE
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 14:45:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9040B402D5;
	Sat, 10 Oct 2026 16:45:18 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.221])
 by mails.dpdk.org (Postfix) with ESMTP id 6DC7240274
 for <dev@dpdk.org>; Sat, 10 Oct 2026 16:45:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=3McKMq45hvhrkBU4N+aC8lp9RrIzZwJ1ILFzZ9CZGb8=;
 b=V6T685cXCB3b+yZap14NdKrifbxH+7bpS+dqqy7C1qDHrF4zSmu8suwtsfq1Q8
 zO9xwKkHJmMgHRcOsDXwdahgClAcqB+5D5Mz51pI7FJJlhu1L6tCpgmC7+dmyilI
 yEJ8mv5gVNKGE6lwL4jvvNu2vEBfSEkfbtISuSysQCWlE=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v1 02/17] net/hinic3: add CIR drop statistics and VF LAG
 support
Date: Sat, 10 Oct 2026 22:44:53 +0800
Message-ID: <20261010144509.2731-3-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261010144509.2731-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDX70B4T8pqMdk9Aw--.440S4
X-Coremail-Antispam: 1Uf129KBjvJXoW3CryxKFWrWw4UGw4UWF4kJFb_yoWkAry5pF
 W5J3srArWDXF4xXwnIg3y8ua4Yqwn3A34UK34xGF90kFn5Xr4kZa4UtrWjvr1aqrZrAFy7
 ZayYv3yDGa4jgaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
 9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07Utu4UUUUUU=
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMxo-SWrKT3oqwQAA3h
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

Provide CIR drop counters and VF LAG configuration so that packets dropped=
=0D
for exceeding the committed information rate are visible and VFs can select=
=0D
the correct queue on an aggregated link.=0D
=0D
Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>=0D
---=0D
 doc/guides/rel_notes/release_26_11.rst   |  4 ++=0D
 drivers/net/hinic3/base/hinic3_cmd.h     |  2 +=0D
 drivers/net/hinic3/base/hinic3_nic_cfg.c | 63 ++++++++++++++++++++++=0D
 drivers/net/hinic3/base/hinic3_nic_cfg.h | 45 +++++++++++++++-=0D
 drivers/net/hinic3/hinic3_ethdev.c       | 68 +++++++++++++++++++++++-=0D
 drivers/net/hinic3/hinic3_ethdev.h       |  3 ++=0D
 6 files changed, 182 insertions(+), 3 deletions(-)=0D
=0D
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/=
release_26_11.rst=0D
index e282fa5581..0c02cbf67f 100644=0D
--- a/doc/guides/rel_notes/release_26_11.rst=0D
+++ b/doc/guides/rel_notes/release_26_11.rst=0D
@@ -92,6 +92,10 @@ New Features=0D
     ``xdp_meta_rx_ts_valid_mask``.=0D
   * Added ``read_clock`` operation to query the PTP hardware clock.=0D
 =0D
+* **Updated Huawei hinic3 ethernet driver.**=0D
+=0D
+  * Added CIR drop statistics and VF link aggregation (LAG) support.=0D
+=0D
 * **Updated Intel iavf driver.**=0D
 =0D
   * Runtime Rx/Tx queue setup is now automatically disabled=0D
diff --git a/drivers/net/hinic3/base/hinic3_cmd.h b/drivers/net/hinic3/base=
/hinic3_cmd.h=0D
index f2d5d47522..ecce94690e 100644=0D
--- a/drivers/net/hinic3/base/hinic3_cmd.h=0D
+++ b/drivers/net/hinic3/base/hinic3_cmd.h=0D
@@ -94,6 +94,8 @@ enum hinic3_nic_cmd {=0D
 	/* PORT CFG */=0D
 	HINIC3_NIC_CMD_CFG_PAUSE_INFO			=3D 101,=0D
 	HINIC3_NIC_CMD_VF_COS				=3D 104,=0D
+	HINIC3_NIC_CMD_GET_CIR_DROP			=3D 115,=0D
+	HINIC3_NIC_CMD_CFG_VF_LAG			=3D 243,=0D
 };=0D
 =0D
 /* COMM commands between driver to MPU. */=0D
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.c b/drivers/net/hinic3/=
base/hinic3_nic_cfg.c=0D
index bd3c39730f..48dee29750 100644=0D
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.c=0D
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c=0D
@@ -600,6 +600,33 @@ hinic3_get_pause_info(struct hinic3_hwdev *hwdev, stru=
ct nic_pause_config *nic_p=0D
 	return hinic3_cfg_hw_pause(hwdev, HINIC3_CMD_OP_GET, nic_pause);=0D
 }=0D
 =0D
+int=0D
+hinic3_get_cir_drop(void *hwdev, struct hinic3_cir_drop *stats)=0D
+{=0D
+	struct hinic3_port_stats_info stats_info =3D { 0 };=0D
+	struct hinic3_cmd_get_dp_info_resp vport_stats =3D { 0 };=0D
+	uint16_t out_size =3D sizeof(vport_stats);=0D
+	int err;=0D
+=0D
+	if (!hwdev || !stats)=0D
+		return -EINVAL;=0D
+=0D
+	stats_info.func_id =3D hinic3_global_func_id(hwdev);=0D
+	err =3D hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC,=0D
+				      HINIC3_NIC_CMD_GET_CIR_DROP,=0D
+				      &stats_info, sizeof(stats_info),=0D
+				      &vport_stats, &out_size);=0D
+	if (err || !out_size || vport_stats.msg_head.status) {=0D
+		PMD_DRV_LOG(ERR, "Get port stats failed, err: %d, status: 0x%x, out size=
: 0x%x",=0D
+			    err, vport_stats.msg_head.status, out_size);=0D
+		return -EIO;=0D
+	}=0D
+=0D
+	memcpy(stats, vport_stats.value, sizeof(*stats));=0D
+=0D
+	return 0;=0D
+}=0D
+=0D
 int=0D
 hinic3_get_vport_stats(struct hinic3_hwdev *hwdev, struct hinic3_vport_sta=
ts *stats)=0D
 {=0D
@@ -1724,3 +1751,39 @@ hinic3_set_link_status_follow(struct hinic3_hwdev *h=
wdev,=0D
 =0D
 	return follow.head.status;=0D
 }=0D
+=0D
+uint8_t=0D
+hinic3_cmd_vf_lag(void *hwdev, uint16_t func_id, uint8_t opcode)=0D
+{=0D
+	struct hinic3_vf_lag_cmd vf_lag_info =3D {0};=0D
+	uint16_t out_size =3D sizeof(struct hinic3_vf_lag_cmd);=0D
+	uint8_t lag_en =3D 0;=0D
+	int err;=0D
+=0D
+	if (!hwdev || func_id >=3D MAX_FUNCTION_NUM)=0D
+		return 0;=0D
+	vf_lag_info.func_id =3D func_id;=0D
+	vf_lag_info.opcode =3D opcode;=0D
+	vf_lag_info.en_flag =3D 0;=0D
+=0D
+	err =3D hinic3_msg_to_mgmt_sync(hwdev, HINIC3_MOD_L2NIC,=0D
+				      HINIC3_NIC_CMD_CFG_VF_LAG,=0D
+				      &vf_lag_info, sizeof(vf_lag_info),=0D
+				      &vf_lag_info, &out_size);=0D
+	if (vf_lag_info.msg_head.status =3D=3D HINIC3_MGMT_CMD_UNSUPPORTED)=0D
+		return 0;=0D
+=0D
+	if (err || vf_lag_info.msg_head.status || !out_size) {=0D
+		PMD_DRV_LOG(ERR,=0D
+			    "Get vf_lag failed, err: %d, status: 0x%x, out size: 0x%x",=0D
+			    err, vf_lag_info.msg_head.status, out_size);=0D
+		return 0;=0D
+	}=0D
+=0D
+	if (opcode =3D=3D HINIC3_CMD_OPCODE_GET) {=0D
+		lag_en =3D (vf_lag_info.vf_lag_bitmap.vf_bit_map[func_id / VF_LAG_VF_NUM=
_PER_GROUP] &=0D
+			 ((0x1ULL) << (func_id % VF_LAG_VF_NUM_PER_GROUP)));=0D
+	}=0D
+=0D
+	return lag_en;=0D
+}=0D
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.h b/drivers/net/hinic3/=
base/hinic3_nic_cfg.h=0D
index 6d3eb433bd..5f08d49a72 100644=0D
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.h=0D
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.h=0D
@@ -17,6 +17,7 @@=0D
 #define HINIC3_DCB_UP_MAX		0x8=0D
 =0D
 #define HINIC3_MAX_NUM_RQ		256=0D
+#define MAX_FUNCTION_NUM		4096=0D
 =0D
 #define HINIC3_MAX_MTU_SIZE		9600=0D
 #define HINIC3_MIN_MTU_SIZE		256=0D
@@ -371,6 +372,18 @@ struct hinic3_port_stats_info {=0D
 	uint16_t rsvd1;=0D
 };=0D
 =0D
+#define HINIC3_CMD_MAX_DP_DATA_NUM 50=0D
+struct hinic3_cir_drop {=0D
+	uint64_t rx_discard_phy;=0D
+};=0D
+=0D
+struct hinic3_cmd_get_dp_info_resp {=0D
+	struct mgmt_msg_head msg_head;=0D
+	uint16_t length;=0D
+	uint16_t rsvd;=0D
+	uint64_t value[HINIC3_CMD_MAX_DP_DATA_NUM];=0D
+};=0D
+=0D
 struct hinic3_vport_stats {=0D
 	uint64_t tx_unicast_pkts_vport;=0D
 	uint64_t tx_unicast_bytes_vport;=0D
@@ -390,6 +403,8 @@ struct hinic3_vport_stats {=0D
 	uint64_t rx_discard_vport;=0D
 	uint64_t tx_err_vport;=0D
 	uint64_t rx_err_vport;=0D
+	uint64_t rx_mtu_err_vport;=0D
+	uint64_t rx_out_of_buffer; /* fw: rx_nowqe */=0D
 };=0D
 =0D
 struct hinic3_cmd_vport_stats {=0D
@@ -398,7 +413,7 @@ struct hinic3_cmd_vport_stats {=0D
 	uint32_t stats_size;=0D
 	uint32_t rsvd1;=0D
 	struct hinic3_vport_stats stats;=0D
-	uint64_t rsvd2[6];=0D
+	uint64_t rsvd2[4];=0D
 };=0D
 =0D
 struct hinic3_phy_port_stats {=0D
@@ -1540,4 +1555,32 @@ int hinic3_set_feature_to_hw(struct hinic3_hwdev *hw=
dev, uint64_t *s_feature, ui=0D
 =0D
 int hinic3_set_link_status_follow(struct hinic3_hwdev *hwdev,=0D
 				  enum hinic3_link_follow_status status);=0D
+=0D
+/* VF LAG definitions */=0D
+#define VF_LAG_VF_NUM_GROUP_NUM 128=0D
+#define VF_LAG_VF_NUM_PER_GROUP 32=0D
+#define HINIC3_CMD_OPCODE_SET 0=0D
+#define HINIC3_CMD_OPCODE_GET 1=0D
+=0D
+typedef struct hinic3_vf_lag_bitmap_s {=0D
+	uint32_t vf_bit_map[VF_LAG_VF_NUM_GROUP_NUM];=0D
+} hinic3_vf_lag_bitmap;=0D
+=0D
+struct hinic3_vf_lag_cmd {=0D
+	struct mgmt_msg_head msg_head;=0D
+=0D
+	uint16_t func_id;=0D
+	uint8_t opcode; /* 0 -> set, 1 -> get */=0D
+	uint8_t en_flag; /* 0 -> disable, 1 -> enable  */=0D
+	uint8_t bond_active_num;=0D
+	uint8_t bond_active_bitmap;=0D
+	uint8_t mac_sync_flag;=0D
+	uint8_t rsvd;=0D
+	hinic3_vf_lag_bitmap vf_lag_bitmap;=0D
+};=0D
+=0D
+int hinic3_get_cir_drop(void *hwdev, struct hinic3_cir_drop *stats);=0D
+=0D
+uint8_t hinic3_cmd_vf_lag(void *hwdev, uint16_t func_id, uint8_t opcode);=
=0D
+=0D
 #endif /* _HINIC3_NIC_CFG_H_ */=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3=
_ethdev.c=0D
index 623c836a3b..ecf7df3ec0 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.c=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.c=0D
@@ -80,12 +80,25 @@ struct hinic3_xstats_name_off {=0D
 	uint32_t offset;=0D
 };=0D
 =0D
+#define HINIC3_CIR_DROP_STAT(_stat_item)                                  =
 \=0D
+	{                                                                  \=0D
+		.name =3D #_stat_item,                                       \=0D
+		.offset =3D offsetof(struct hinic3_cir_drop, _stat_item),    \=0D
+	}=0D
+=0D
 #define HINIC3_FUNC_STAT(_stat_item)                                      =
 \=0D
 	{                                                                  \=0D
 		.name =3D #_stat_item,                                       \=0D
 		.offset =3D offsetof(struct hinic3_vport_stats, _stat_item), \=0D
 	}=0D
 =0D
+=0D
+static struct hinic3_xstats_name_off hinic3_cir_drop_stats_strings[] =3D {=
=0D
+	HINIC3_CIR_DROP_STAT(rx_discard_phy),=0D
+};=0D
+=0D
+#define HINIC3_CIR_DROP_XSTATS_NUM  RTE_DIM(hinic3_cir_drop_stats_strings)=
=0D
+=0D
 static const struct hinic3_xstats_name_off hinic3_vport_stats_strings[] =
=3D {=0D
 	HINIC3_FUNC_STAT(tx_unicast_pkts_vport),=0D
 	HINIC3_FUNC_STAT(tx_unicast_bytes_vport),=0D
@@ -105,6 +118,8 @@ static const struct hinic3_xstats_name_off hinic3_vport=
_stats_strings[] =3D {=0D
 	HINIC3_FUNC_STAT(rx_discard_vport),=0D
 	HINIC3_FUNC_STAT(tx_err_vport),=0D
 	HINIC3_FUNC_STAT(rx_err_vport),=0D
+	HINIC3_FUNC_STAT(rx_mtu_err_vport),=0D
+	HINIC3_FUNC_STAT(rx_out_of_buffer),=0D
 };=0D
 =0D
 #define HINIC3_VPORT_XSTATS_NUM RTE_DIM(hinic3_vport_stats_strings)=0D
@@ -285,11 +300,13 @@ static uint32_t=0D
 hinic3_xstats_calc_num(struct hinic3_nic_dev *nic_dev)=0D
 {=0D
 	if (HINIC3_IS_VF(nic_dev->hwdev)) {=0D
-		return (HINIC3_VPORT_XSTATS_NUM +=0D
+		return (HINIC3_VPORT_XSTATS_NUM + HINIC3_PHYPORT_XSTATS_NUM +=0D
+			HINIC3_CIR_DROP_XSTATS_NUM +=0D
 			HINIC3_RXQ_XSTATS_NUM * nic_dev->num_rqs +=0D
 			HINIC3_TXQ_XSTATS_NUM * nic_dev->num_sqs);=0D
 	} else {=0D
 		return (HINIC3_VPORT_XSTATS_NUM + HINIC3_PHYPORT_XSTATS_NUM +=0D
+			HINIC3_CIR_DROP_XSTATS_NUM +=0D
 			HINIC3_RXQ_XSTATS_NUM * nic_dev->num_rqs +=0D
 			HINIC3_TXQ_XSTATS_NUM * nic_dev->num_sqs);=0D
 	}=0D
@@ -1250,7 +1267,14 @@ hinic3_tx_queue_setup(struct rte_eth_dev *dev, uint1=
6_t qid, uint16_t nb_desc,=0D
 	txq->wqebb_size =3D (uint16_t)RTE_BIT32(txq->wqebb_shift);=0D
 	txq->tx_free_thresh =3D tx_free_thresh;=0D
 	txq->owner =3D 1;=0D
-	txq->cos =3D nic_dev->default_cos;=0D
+=0D
+	if (!ODD_NUMBER_QUEUE_ID(qid) &&=0D
+		hinic3_cmd_vf_lag(nic_dev->hwdev, hinic3_global_func_id(nic_dev->hwdev),=
=0D
+				  HINIC3_CMD_OPCODE_GET) =3D=3D 1)=0D
+		txq->cos =3D SELECT_OTHER_COS_ID(nic_dev->default_cos);=0D
+	else=0D
+		txq->cos =3D nic_dev->default_cos;=0D
+=0D
 	txq->tx_deferred_start =3D tx_conf->tx_deferred_start;=0D
 	txq->tx_wqe_compact_task =3D HINIC3_SUPPORT_TX_WQE_COMPACT_TASK(nic_dev);=
=0D
 =0D
@@ -2850,6 +2874,35 @@ hinic3_dev_stats_reset(struct rte_eth_dev *dev)=0D
 	return 0;=0D
 }=0D
 =0D
+static uint16_t=0D
+get_port_cir_drop(struct hinic3_nic_dev *nic_dev,=0D
+		  struct rte_eth_xstat *xstats)=0D
+{=0D
+	struct hinic3_cir_drop port_stats;=0D
+	uint16_t i;=0D
+	int err =3D 0;=0D
+=0D
+	memset(&port_stats, 0, sizeof(port_stats));=0D
+=0D
+	err =3D hinic3_get_cir_drop(nic_dev->hwdev, &port_stats);=0D
+	if (err) {=0D
+		PMD_DRV_LOG(ERR, "Failed to get CPB cir drops from fw.");=0D
+=0D
+		for (i =3D 0; i < RTE_DIM(hinic3_cir_drop_stats_strings); i++)=0D
+			xstats[i].value =3D 0;=0D
+=0D
+		return RTE_DIM(hinic3_cir_drop_stats_strings);=0D
+	}=0D
+=0D
+	for (i =3D 0; i < RTE_DIM(hinic3_cir_drop_stats_strings); i++) {=0D
+		memcpy(&xstats[i].value,=0D
+		       (const char *)&port_stats + hinic3_cir_drop_stats_strings[i].offs=
et,=0D
+		       sizeof(uint64_t));=0D
+	}=0D
+=0D
+	return RTE_DIM(hinic3_cir_drop_stats_strings);=0D
+}=0D
+=0D
 /**=0D
  * Get device extended statistics.=0D
  *=0D
@@ -2938,6 +2991,9 @@ hinic3_dev_xstats_get(struct rte_eth_dev *dev, struct=
 rte_eth_xstat *xstats,=0D
 		count++;=0D
 	}=0D
 =0D
+	/* Get stats from cir drop stats structure */=0D
+	count +=3D get_port_cir_drop(nic_dev, &xstats[count]);=0D
+=0D
 	if (HINIC3_IS_VF(nic_dev->hwdev))=0D
 		return count;=0D
 =0D
@@ -3038,6 +3094,14 @@ hinic3_dev_xstats_get_names(struct rte_eth_dev *dev,=
=0D
 		count++;=0D
 	}=0D
 =0D
+	/* Get cir drop stats name. */=0D
+	for (i =3D 0; i < HINIC3_CIR_DROP_XSTATS_NUM; i++) {=0D
+		strlcpy(xstats_names[count].name,=0D
+			hinic3_cir_drop_stats_strings[i].name,=0D
+			sizeof(xstats_names[count].name));=0D
+		count++;=0D
+	}=0D
+=0D
 	if (HINIC3_IS_VF(nic_dev->hwdev))=0D
 		return count;=0D
 =0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3=
_ethdev.h=0D
index 9061e2b217..6e21672a4d 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.h=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.h=0D
@@ -155,6 +155,9 @@ struct hinic3_nic_dev {=0D
 =0D
 };=0D
 =0D
+#define SELECT_OTHER_COS_ID(cos_id) ((cos_id) ^ 4)=0D
+#define ODD_NUMBER_QUEUE_ID(q_id) ((q_id) & 1)=0D
+=0D
 extern const struct rte_flow_ops hinic3_flow_ops;=0D
 =0D
 /**=0D
-- =0D
2.33.0=0D
=0D

