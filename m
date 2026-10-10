Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEC7BCA9EBE
	for <dpdk-dev@archiver.kernel.org>; Sat, 10 Oct 2026 14:46:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 327D34069D;
	Sat, 10 Oct 2026 16:45:25 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.220])
 by mails.dpdk.org (Postfix) with ESMTP id 8FCB3402D4
 for <dev@dpdk.org>; Sat, 10 Oct 2026 16:45:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=t3NKxNqnpYuNz3tgDLEmQ9G2PTuM9raGo49vZqEGPHs=;
 b=KOZtLsD+Dxmo86pA5Y+HRN1mcflEMbT5/Oh6USpsdYgE+IQv6SlXR3GZNyzvZC
 STjeYvbI64LOESZjs1wS41lRG41EPW2+m7IAmeawxsjSvST/hkEKJAB6DQU/7YL3
 wrg7t4ePccB2g4nNrwVMXmZkHbte5dLDyp4DtLldICIKk=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v1 07/17] net/hinic3: convert cmdq ops to static global
 variables
Date: Sat, 10 Oct 2026 22:44:58 +0800
Message-ID: <20261010144509.2731-8-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261010144509.2731-1-yejiacheng4@h-partners.com>
References: <20261010144509.2731-1-yejiacheng4@h-partners.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID: As8vCgDX70B4T8pqMdk9Aw--.440S9
X-Coremail-Antispam: 1Uf129KBjvAXoW3Cry7Zr45JFykKr18Jr1fWFg_yoW8Jw1xXo
 WfJryFyF1ftry8GF9xKFnYkay7X3srJFZ8Jan5Kr9rXa9rJFy7XF9xXw4F9a4YvayrAanr
 AayxJ3Wqga4xXw18n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU2SdgDUUUU
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiNxxASmrKT3wxhAAA3H
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

Cmdq ops are currently allocated dynamically, so when the driver is loaded=
=0D
with both a primary and a secondary process the copies overwrite each other=
=0D
and cause a core dump. Convert them to const global tables so every process=
=0D
references the same static structures.=0D
=0D
Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>=0D
---=0D
 drivers/net/hinic3/base/hinic3_nic_cfg.c      |  7 ++--=0D
 drivers/net/hinic3/hinic3_ethdev.c            | 34 ++++++++++---------=0D
 drivers/net/hinic3/hinic3_ethdev.h            |  1 -=0D
 drivers/net/hinic3/hinic3_nic_io.c            | 11 +++---=0D
 drivers/net/hinic3/hinic3_nic_io.h            | 14 ++++++++=0D
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.c    | 21 +++++-------=0D
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.h    |  6 ++--=0D
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.c    | 23 +++++--------=0D
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.h    |  6 ++--=0D
 9 files changed, 65 insertions(+), 58 deletions(-)=0D
=0D
diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.c b/drivers/net/hinic3/=
base/hinic3_nic_cfg.c=0D
index 2241908004..235b36dcce 100644=0D
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.c=0D
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c=0D
@@ -1212,7 +1212,7 @@ hinic3_rss_get_indir_tbl(struct hinic3_hwdev *hwdev, =
uint32_t *indir_table)=0D
 	cmd_buf->size =3D sizeof(struct nic_rss_indirect_tbl);=0D
 	nic_dev =3D (struct hinic3_nic_dev *)hwdev->dev_handle;=0D
 =0D
-	cmd =3D nic_dev->cmdq_ops->prepare_cmd_buf_get_rss_indir_table(nic_dev, c=
md_buf);=0D
+	cmd =3D hinic3_cmdq_get_ops(nic_dev)->prepare_cmd_buf_get_rss_indir_table=
(nic_dev, cmd_buf);=0D
 	err =3D hinic3_cmdq_detail_resp(hwdev, HINIC3_MOD_L2NIC, cmd, cmd_buf, cm=
d_buf, 0);=0D
 	if (err) {=0D
 		PMD_DRV_LOG(ERR, "Get rss indir table failed");=0D
@@ -1220,7 +1220,7 @@ hinic3_rss_get_indir_tbl(struct hinic3_hwdev *hwdev, =
uint32_t *indir_table)=0D
 		return err;=0D
 	}=0D
 =0D
-	nic_dev->cmdq_ops->cmd_buf_to_rss_indir_table(cmd_buf, indir_table);=0D
+	hinic3_cmdq_get_ops(nic_dev)->cmd_buf_to_rss_indir_table(cmd_buf, indir_t=
able);=0D
 =0D
 	hinic3_free_cmd_buf(cmd_buf);=0D
 	return 0;=0D
@@ -1245,7 +1245,8 @@ hinic3_rss_set_indir_tbl(struct hinic3_hwdev *hwdev, =
const uint32_t *indir_table=0D
 	}=0D
 =0D
 	nic_dev =3D (struct hinic3_nic_dev *)hwdev->dev_handle;=0D
-	cmd =3D nic_dev->cmdq_ops->prepare_cmd_buf_set_rss_indir_table(nic_dev, i=
ndir_table, cmd_buf);=0D
+	cmd =3D hinic3_cmdq_get_ops(nic_dev)->prepare_cmd_buf_set_rss_indir_table=
(nic_dev,=0D
+		indir_table, cmd_buf);=0D
 	err =3D hinic3_cmdq_direct_resp(hwdev, HINIC3_MOD_L2NIC, cmd, cmd_buf, &o=
ut_param, 0);=0D
 	if (err || out_param !=3D 0) {=0D
 		PMD_DRV_LOG(ERR, "Set rss indir table failed");=0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3=
_ethdev.c=0D
index f4be6cdc06..d7dbd945bc 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.c=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.c=0D
@@ -539,6 +539,24 @@ hinic3_init_default_cos(struct hinic3_nic_dev *nic_dev=
)=0D
 	return 0;=0D
 }=0D
 =0D
+/**=0D
+ * Get cmdq ops for the given NIC device.=0D
+ *=0D
+ * @param[in] nic_dev=0D
+ * Pointer to NIC device structure.=0D
+ *=0D
+ * @return=0D
+ * Pointer to cmdq ops structure.=0D
+ */=0D
+const struct hinic3_nic_cmdq_ops *=0D
+hinic3_cmdq_get_ops(struct hinic3_nic_dev *nic_dev)=0D
+{=0D
+	if (nic_dev->feature_cap & NIC_F_HTN_CMDQ)=0D
+		return &hinic3_htn_cmdq_ops;=0D
+	else=0D
+		return &hinic3_stn_cmdq_ops;=0D
+}=0D
+=0D
 /**=0D
  * Initialize Class of Service (CoS). For PF devices, it also sync the lin=
k=0D
  * status with the physical port.=0D
@@ -3670,13 +3688,6 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)=0D
 		goto alloc_eth_addr_fail;=0D
 	}=0D
 =0D
-	nic_dev->cmdq_ops =3D rte_zmalloc("cmdq_ops", sizeof(struct hinic3_nic_cm=
dq_ops), 0);=0D
-	if (!nic_dev->cmdq_ops) {=0D
-		PMD_DRV_LOG(ERR, "Allocate cmdq_ops memory failed");=0D
-		err =3D -ENOMEM;=0D
-		goto alloc_cmdq_ops_fail;=0D
-	}=0D
-=0D
 	nic_dev->rx_ops =3D rte_zmalloc("rx_ops", sizeof(struct hinic3_nic_rx_ops=
), 0);=0D
 	if (!nic_dev->rx_ops) {=0D
 		PMD_DRV_LOG(ERR, "Allocate rx_ops memory failed");=0D
@@ -3744,11 +3755,6 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)=0D
 		goto get_cap_fail;=0D
 	}=0D
 =0D
-	if (!(nic_dev->feature_cap & NIC_F_HTN_CMDQ))=0D
-		nic_dev->cmdq_ops =3D hinic3_nic_cmdq_get_stn_ops();=0D
-	else=0D
-		nic_dev->cmdq_ops =3D hinic3_nic_cmdq_get_htn_ops();=0D
-=0D
 	hinic3_nic_tx_rx_ops_init(nic_dev);=0D
 =0D
 	err =3D hinic3_init_sw_rxtxqs(nic_dev);=0D
@@ -3847,10 +3853,6 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)=0D
 	nic_dev->rx_ops =3D NULL;=0D
 =0D
 alloc_rx_ops_fail:=0D
-	rte_free(nic_dev->cmdq_ops);=0D
-	nic_dev->cmdq_ops =3D NULL;=0D
-=0D
-alloc_cmdq_ops_fail:=0D
 	rte_free(eth_dev->data->mac_addrs);=0D
 	eth_dev->data->mac_addrs =3D NULL;=0D
 =0D
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3=
_ethdev.h=0D
index 73f47731bf..57f46aa850 100644=0D
--- a/drivers/net/hinic3/hinic3_ethdev.h=0D
+++ b/drivers/net/hinic3/hinic3_ethdev.h=0D
@@ -151,7 +151,6 @@ struct hinic3_nic_dev {=0D
 	struct hinic3_ethertype_filter_list filter_ethertype_list;=0D
 	struct hinic3_fdir_rule_filter_list filter_fdir_rule_list;=0D
 	uint8_t cos_map[HINIC3_COS_NUM_MAX];=0D
-	struct hinic3_nic_cmdq_ops *cmdq_ops;=0D
 	struct hinic3_nic_rx_ops *rx_ops;=0D
 	struct hinic3_nic_tx_ops *tx_ops;=0D
 	uint32_t fec_mode;  /**< Current FEC mode for ethdev. */=0D
diff --git a/drivers/net/hinic3/hinic3_nic_io.c b/drivers/net/hinic3/hinic3=
_nic_io.c=0D
index 9203dcce40..361586868e 100644=0D
--- a/drivers/net/hinic3/hinic3_nic_io.c=0D
+++ b/drivers/net/hinic3/hinic3_nic_io.c=0D
@@ -391,8 +391,8 @@ init_sq_ctxts(struct hinic3_nic_dev *nic_dev)=0D
 		max_ctxts =3D (nic_dev->num_sqs - q_id) > HINIC3_Q_CTXT_MAX=0D
 				    ? HINIC3_Q_CTXT_MAX=0D
 				    : (nic_dev->num_sqs - q_id);=0D
-		cmd =3D nic_dev->cmdq_ops->prepare_cmd_buf_qp_context_multi_store(nic_de=
v, cmd_buf,=0D
-			HINIC3_QP_CTXT_TYPE_SQ, q_id, max_ctxts);=0D
+		cmd =3D hinic3_cmdq_get_ops(nic_dev)->prepare_cmd_buf_qp_context_multi_s=
tore(nic_dev,=0D
+			cmd_buf, HINIC3_QP_CTXT_TYPE_SQ, q_id, max_ctxts);=0D
 		rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
 		err =3D hinic3_cmdq_direct_resp(nic_dev->hwdev, HINIC3_MOD_L2NIC,=0D
 					      cmd, cmd_buf, &out_param, 0);=0D
@@ -443,8 +443,8 @@ init_rq_ctxts(struct hinic3_nic_dev *nic_dev)=0D
 		max_ctxts =3D (nic_dev->num_rqs - q_id) > HINIC3_Q_CTXT_MAX=0D
 				    ? HINIC3_Q_CTXT_MAX=0D
 				    : (nic_dev->num_rqs - q_id);=0D
-		cmd =3D nic_dev->cmdq_ops->prepare_cmd_buf_qp_context_multi_store(nic_de=
v, cmd_buf,=0D
-			HINIC3_QP_CTXT_TYPE_RQ, q_id, max_ctxts);=0D
+		cmd =3D hinic3_cmdq_get_ops(nic_dev)->prepare_cmd_buf_qp_context_multi_s=
tore(nic_dev,=0D
+			cmd_buf, HINIC3_QP_CTXT_TYPE_RQ, q_id, max_ctxts);=0D
 		rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
 		err =3D hinic3_cmdq_direct_resp(nic_dev->hwdev, HINIC3_MOD_L2NIC,=0D
 					      cmd, cmd_buf, &out_param, 0);=0D
@@ -491,7 +491,8 @@ clean_queue_offload_ctxt(struct hinic3_nic_dev *nic_dev=
,=0D
 		return -ENOMEM;=0D
 	}=0D
 =0D
-	cmd =3D nic_dev->cmdq_ops->prepare_cmd_buf_clean_tso_lro_space(nic_dev, c=
md_buf, ctxt_type);=0D
+	cmd =3D hinic3_cmdq_get_ops(nic_dev)->prepare_cmd_buf_clean_tso_lro_space=
(nic_dev,=0D
+		cmd_buf, ctxt_type);=0D
 =0D
 	/* Send a command to hardware to clean up queue offload context. */=0D
 	err =3D hinic3_cmdq_direct_resp(nic_dev->hwdev, HINIC3_MOD_L2NIC,=0D
diff --git a/drivers/net/hinic3/hinic3_nic_io.h b/drivers/net/hinic3/hinic3=
_nic_io.h=0D
index e1741d1156..c8b33e985d 100644=0D
--- a/drivers/net/hinic3/hinic3_nic_io.h=0D
+++ b/drivers/net/hinic3/hinic3_nic_io.h=0D
@@ -79,6 +79,20 @@ struct hinic3_nic_cmdq_ops {=0D
 	cmd_buf_to_rss_indir_table_t			cmd_buf_to_rss_indir_table;=0D
 };=0D
 =0D
+/* Forward declaration */=0D
+struct hinic3_nic_dev;=0D
+=0D
+/**=0D
+ * Get cmdq ops for the given NIC device.=0D
+ *=0D
+ * @param[in] nic_dev=0D
+ * Pointer to NIC device structure.=0D
+ *=0D
+ * @return=0D
+ * Pointer to cmdq ops structure.=0D
+ */=0D
+const struct hinic3_nic_cmdq_ops *hinic3_cmdq_get_ops(struct hinic3_nic_de=
v *nic_dev);=0D
+=0D
 /* Doorbell info. */=0D
 struct hinic3_db {=0D
 	uint32_t db_info;=0D
diff --git a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c b/drivers/net/h=
inic3/htn_adapt/hinic3_htn_cmdq.c=0D
index 634dfe7239..607fe2d0fe 100644=0D
--- a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c=0D
+++ b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c=0D
@@ -152,16 +152,11 @@ static void cmd_buf_to_rss_indir_table(const struct h=
inic3_cmd_buf *cmd_buf, uin=0D
 		indir_table[i] =3D *(indir_tbl + i);=0D
 }=0D
 =0D
-struct hinic3_nic_cmdq_ops *hinic3_nic_cmdq_get_htn_ops(void)=0D
-{=0D
-	static struct hinic3_nic_cmdq_ops cmdq_ops =3D {=0D
-		.prepare_cmd_buf_clean_tso_lro_space =3D    prepare_cmd_buf_clean_tso_lr=
o_space,=0D
-		.prepare_cmd_buf_qp_context_multi_store =3D prepare_cmd_buf_qp_context_m=
ulti_store,=0D
-		.prepare_cmd_buf_modify_svlan =3D           prepare_cmd_buf_modify_svlan=
,=0D
-		.prepare_cmd_buf_set_rss_indir_table =3D    prepare_cmd_buf_set_rss_indi=
r_table,=0D
-		.prepare_cmd_buf_get_rss_indir_table =3D    prepare_cmd_buf_get_rss_indi=
r_table,=0D
-		.cmd_buf_to_rss_indir_table =3D             cmd_buf_to_rss_indir_table,=
=0D
-	};=0D
-=0D
-	return &cmdq_ops;=0D
-}=0D
+const struct hinic3_nic_cmdq_ops hinic3_htn_cmdq_ops =3D {=0D
+	.prepare_cmd_buf_clean_tso_lro_space =3D    prepare_cmd_buf_clean_tso_lro=
_space,=0D
+	.prepare_cmd_buf_qp_context_multi_store =3D prepare_cmd_buf_qp_context_mu=
lti_store,=0D
+	.prepare_cmd_buf_modify_svlan =3D           prepare_cmd_buf_modify_svlan,=
=0D
+	.prepare_cmd_buf_set_rss_indir_table =3D    prepare_cmd_buf_set_rss_indir=
_table,=0D
+	.prepare_cmd_buf_get_rss_indir_table =3D    prepare_cmd_buf_get_rss_indir=
_table,=0D
+	.cmd_buf_to_rss_indir_table =3D             cmd_buf_to_rss_indir_table,=0D
+};=0D
diff --git a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h b/drivers/net/h=
inic3/htn_adapt/hinic3_htn_cmdq.h=0D
index 73f4922734..158cbc5f8e 100644=0D
--- a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h=0D
+++ b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h=0D
@@ -53,11 +53,11 @@ struct hinic3_htn_vlan_ctx {=0D
 };=0D
 =0D
 /**=0D
- * Get cmdq ops hardware tile NIC(htn) supported.=0D
+ * Cmdq ops hardware tile NIC(htn) supported.=0D
  *=0D
  * @return=0D
- * Pointer to ops.=0D
+ * Ops.=0D
  */=0D
-struct hinic3_nic_cmdq_ops *hinic3_nic_cmdq_get_htn_ops(void);=0D
+extern const struct hinic3_nic_cmdq_ops hinic3_htn_cmdq_ops;=0D
 =0D
 #endif /* _HINIC3_HTN_CMDQ_H_ */=0D
diff --git a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c b/drivers/net/h=
inic3/stn_adapt/hinic3_stn_cmdq.c=0D
index f41f060d17..23adbc79f4 100644=0D
--- a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c=0D
+++ b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c=0D
@@ -108,7 +108,7 @@ static uint8_t prepare_cmd_buf_set_rss_indir_table(stru=
ct hinic3_nic_dev *nic_de=0D
 =0D
 	for (i =3D 0; i < HINIC3_RSS_INDIR_SIZE; i++)=0D
 		indir_tbl->entry[i] =3D (uint16_t)(*(indir_table + i));=0D
-	size =3D sizeof(indir_tbl->entry) / 4;=0D
+	size =3D (size_t)sizeof(indir_tbl->entry) / sizeof(uint32_t);=0D
 	temp =3D (uint32_t *)indir_tbl->entry;=0D
 	for (i =3D 0; i < size; i++) {=0D
 		rte_atomic_thread_fence(rte_memory_order_seq_cst);=0D
@@ -136,16 +136,11 @@ static void cmd_buf_to_rss_indir_table(const struct h=
inic3_cmd_buf *cmd_buf, uin=0D
 		indir_table[i] =3D *(indir_tbl + i);=0D
 }=0D
 =0D
-struct hinic3_nic_cmdq_ops *hinic3_nic_cmdq_get_stn_ops(void)=0D
-{=0D
-	static struct hinic3_nic_cmdq_ops cmdq_ops =3D {=0D
-		.prepare_cmd_buf_clean_tso_lro_space =3D    prepare_cmd_buf_clean_tso_lr=
o_space,=0D
-		.prepare_cmd_buf_qp_context_multi_store =3D prepare_cmd_buf_qp_context_m=
ulti_store,=0D
-		.prepare_cmd_buf_modify_svlan =3D           prepare_cmd_buf_modify_svlan=
,=0D
-		.prepare_cmd_buf_set_rss_indir_table =3D    prepare_cmd_buf_set_rss_indi=
r_table,=0D
-		.prepare_cmd_buf_get_rss_indir_table =3D    prepare_cmd_buf_get_rss_indi=
r_table,=0D
-		.cmd_buf_to_rss_indir_table =3D             cmd_buf_to_rss_indir_table,=
=0D
-	};=0D
-=0D
-	return &cmdq_ops;=0D
-}=0D
+const struct hinic3_nic_cmdq_ops hinic3_stn_cmdq_ops =3D {=0D
+	.prepare_cmd_buf_clean_tso_lro_space =3D    prepare_cmd_buf_clean_tso_lro=
_space,=0D
+	.prepare_cmd_buf_qp_context_multi_store =3D prepare_cmd_buf_qp_context_mu=
lti_store,=0D
+	.prepare_cmd_buf_modify_svlan =3D           prepare_cmd_buf_modify_svlan,=
=0D
+	.prepare_cmd_buf_set_rss_indir_table =3D    prepare_cmd_buf_set_rss_indir=
_table,=0D
+	.prepare_cmd_buf_get_rss_indir_table =3D    prepare_cmd_buf_get_rss_indir=
_table,=0D
+	.cmd_buf_to_rss_indir_table =3D             cmd_buf_to_rss_indir_table,=0D
+};=0D
diff --git a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h b/drivers/net/h=
inic3/stn_adapt/hinic3_stn_cmdq.h=0D
index f1720c29c7..ab1c73a977 100644=0D
--- a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h=0D
+++ b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h=0D
@@ -36,11 +36,11 @@ struct hinic3_stn_vlan_ctx {=0D
 };=0D
 =0D
 /**=0D
- * Get cmdq ops software tile NIC(stn) supported.=0D
+ * Cmdq ops software tile NIC(stn) supported.=0D
  *=0D
  * @return=0D
- * Pointer to ops.=0D
+ * Ops.=0D
  */=0D
-struct hinic3_nic_cmdq_ops *hinic3_nic_cmdq_get_stn_ops(void);=0D
+extern const struct hinic3_nic_cmdq_ops hinic3_stn_cmdq_ops;=0D
 =0D
 #endif /* _HINIC3_STN_CMDQ_H_ */=0D
-- =0D
2.33.0=0D
=0D

