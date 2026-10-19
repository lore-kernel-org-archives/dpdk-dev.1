Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADE560A8F40
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 15:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=vip.163.com header.i=@vip.163.com header.a=rsa-sha256 header.s=s110527 header.b=iytQwmJx
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05DF640DDD;
	Mon, 19 Oct 2026 17:20:13 +0200 (CEST)
Received: from mail-m16.vip.163.com (mail-m16.vip.163.com [220.197.30.223])
 by mails.dpdk.org (Postfix) with ESMTP id 11B1840693
 for <dev@dpdk.org>; Mon, 19 Oct 2026 17:19:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vip.163.com; s=s110527; h=From:To:Subject:Date:Message-ID:
 MIME-Version; bh=MoexJm5LCQjlaBID3CxVMYyMTpToJGhbqvREwVJUHvo=;
 b=iytQwmJxzKAjrsbPOkiuztMPe9z2TP6Zo1CNJSCc1WX9CNkF+6sk4WgnkpIFQe
 N/YQCQTYMuCiC/wtqHxWkV329DkqHws7U948PpVXMC8SBMC5MpSUJlMn3KLbZYOy
 kaEOcWRgTGYjbDil4RScSj5wvB7QDfpN+TZ6hWuTOz/UU=
From: Jiacheng Ye <yejiacheng4@h-partners.com>
To: dev@dpdk.org
Cc: Feifei Wang <wangfeifei40@huawei.com>,
 Thomas Monjalon <thomas@monjalon.net>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH 15/27] net/hinic3: convert cmdq ops to static global variables
Date: Mon, 19 Oct 2026 23:19:17 +0800
Message-ID: <20261019151930.1572-16-yejiacheng4@h-partners.com>
X-Mailer: git-send-email 2.53.0.windows.2
In-Reply-To: <20261019151930.1572-1-yejiacheng4@h-partners.com>
References: <20261014150923.838-1-yejiacheng4@h-partners.com>
 <20261019151930.1572-1-yejiacheng4@h-partners.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Ac8vCgCXK5cUNdZqqgUkBA--.15723S17
X-Coremail-Antispam: 1Uf129KBjvAXoW3Cry7Zr45JF45JFW5Xry5urg_yoW8Gry7Co
 WfJr9YyF1ftry8GF9xKFnYkay7X3srJFZ8Jan5Gr9rXasrJFy7WF9xXw4F9a4YvayrAanr
 Aay7J3Wqga4xXw18n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxUzgAwUUUUU
Sender: wff_light@vip.163.com
X-CM-SenderInfo: pziiszhljk3qxylshiywtou0bp/1tbiMh6krmrWNR7MawAA3W
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Replace the per-device dynamically allocated cmdq_ops with static global
instances (hinic3_htn_cmdq_ops and hinic3_stn_cmdq_ops) selected by NIC
type, avoiding per-device allocation and freeing.

Select the ops by NIC type via hinic3_cmdq_get_ops(), falling back to the
STN ops for unknown IDs, instead of the NIC_F_HTN_CMDQ capability bit used
previously.

Dropping the dynamic allocation also removes an init-path leak: the old
code allocated a cmdq_ops block with rte_zmalloc(), then overwrote the
pointer with the static ops instance, leaking the allocation and
rte_free()'ing the static pointer on the error path.

Fixes: 9204b6b7bb1a ("net/hinic3: split new/old command queue operations")

Signed-off-by: Jiacheng Ye <yejiacheng4@h-partners.com>
---
 drivers/net/hinic3/base/hinic3_nic_cfg.c      |  7 ++--
 drivers/net/hinic3/hinic3_ethdev.c            | 37 +++++++++++--------
 drivers/net/hinic3/hinic3_ethdev.h            |  1 -
 drivers/net/hinic3/hinic3_nic_io.c            | 11 +++---
 drivers/net/hinic3/hinic3_nic_io.h            | 11 ++++++
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.c    | 21 ++++-------
 .../net/hinic3/htn_adapt/hinic3_htn_cmdq.h    |  6 +--
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.c    | 23 +++++-------
 .../net/hinic3/stn_adapt/hinic3_stn_cmdq.h    |  6 +--
 9 files changed, 65 insertions(+), 58 deletions(-)

diff --git a/drivers/net/hinic3/base/hinic3_nic_cfg.c b/drivers/net/hinic3/base/hinic3_nic_cfg.c
index 6dc6a564d6..25fee0801c 100644
--- a/drivers/net/hinic3/base/hinic3_nic_cfg.c
+++ b/drivers/net/hinic3/base/hinic3_nic_cfg.c
@@ -1214,7 +1214,7 @@ hinic3_rss_get_indir_tbl(struct hinic3_hwdev *hwdev, uint32_t *indir_table)
 	cmd_buf->size = sizeof(struct nic_rss_indirect_tbl);
 	nic_dev = (struct hinic3_nic_dev *)hwdev->dev_handle;
 
-	cmd = nic_dev->cmdq_ops->prepare_cmd_buf_get_rss_indir_table(nic_dev, cmd_buf);
+	cmd = hinic3_cmdq_get_ops(nic_dev)->prepare_cmd_buf_get_rss_indir_table(nic_dev, cmd_buf);
 	err = hinic3_cmdq_detail_resp(hwdev, HINIC3_MOD_L2NIC, cmd, cmd_buf, cmd_buf, 0);
 	if (err) {
 		PMD_DRV_LOG(ERR, "Get rss indir table failed");
@@ -1222,7 +1222,7 @@ hinic3_rss_get_indir_tbl(struct hinic3_hwdev *hwdev, uint32_t *indir_table)
 		return err;
 	}
 
-	nic_dev->cmdq_ops->cmd_buf_to_rss_indir_table(cmd_buf, indir_table);
+	hinic3_cmdq_get_ops(nic_dev)->cmd_buf_to_rss_indir_table(cmd_buf, indir_table);
 
 	hinic3_free_cmd_buf(cmd_buf);
 	return 0;
@@ -1247,7 +1247,8 @@ hinic3_rss_set_indir_tbl(struct hinic3_hwdev *hwdev, const uint32_t *indir_table
 	}
 
 	nic_dev = (struct hinic3_nic_dev *)hwdev->dev_handle;
-	cmd = nic_dev->cmdq_ops->prepare_cmd_buf_set_rss_indir_table(nic_dev, indir_table, cmd_buf);
+	cmd = hinic3_cmdq_get_ops(nic_dev)->prepare_cmd_buf_set_rss_indir_table(nic_dev,
+		indir_table, cmd_buf);
 	err = hinic3_cmdq_direct_resp(hwdev, HINIC3_MOD_L2NIC, cmd, cmd_buf, &out_param, 0);
 	if (err || out_param != 0) {
 		PMD_DRV_LOG(ERR, "Set rss indir table failed");
diff --git a/drivers/net/hinic3/hinic3_ethdev.c b/drivers/net/hinic3/hinic3_ethdev.c
index 9903bbaf5f..f4495d40b1 100644
--- a/drivers/net/hinic3/hinic3_ethdev.c
+++ b/drivers/net/hinic3/hinic3_ethdev.c
@@ -556,6 +556,27 @@ hinic3_get_nic_type(struct rte_pci_device *pci_dev)
 	}
 }
 
+/**
+ * Get cmdq ops for the given NIC device.
+ *
+ * @param[in] nic_dev
+ * Pointer to NIC device structure.
+ *
+ * @return
+ * Pointer to cmdq ops structure.
+ */
+const struct hinic3_nic_cmdq_ops *
+hinic3_cmdq_get_ops(struct hinic3_nic_dev *nic_dev)
+{
+	static const struct hinic3_nic_cmdq_ops *cmdq_ops[] = {
+		[NIC_SP620]   = &hinic3_stn_cmdq_ops,
+		[NIC_SP230]   = &hinic3_htn_cmdq_ops,
+		[NIC_UNKNOWN] = &hinic3_stn_cmdq_ops,
+	};
+
+	return cmdq_ops[nic_dev->nic_type];
+}
+
 /**
  * Initialize Class of Service (CoS). For PF devices, it also sync the link
  * status with the physical port.
@@ -3741,13 +3762,6 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)
 		goto alloc_eth_addr_fail;
 	}
 
-	nic_dev->cmdq_ops = rte_zmalloc("cmdq_ops", sizeof(struct hinic3_nic_cmdq_ops), 0);
-	if (!nic_dev->cmdq_ops) {
-		PMD_DRV_LOG(ERR, "Allocate cmdq_ops memory failed");
-		err = -ENOMEM;
-		goto alloc_cmdq_ops_fail;
-	}
-
 	nic_dev->rx_ops = rte_zmalloc("rx_ops", sizeof(struct hinic3_nic_rx_ops), 0);
 	if (!nic_dev->rx_ops) {
 		PMD_DRV_LOG(ERR, "Allocate rx_ops memory failed");
@@ -3815,11 +3829,6 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)
 		goto get_cap_fail;
 	}
 
-	if (!(nic_dev->feature_cap & NIC_F_HTN_CMDQ))
-		nic_dev->cmdq_ops = hinic3_nic_cmdq_get_stn_ops();
-	else
-		nic_dev->cmdq_ops = hinic3_nic_cmdq_get_htn_ops();
-
 	hinic3_nic_tx_rx_ops_init(nic_dev);
 
 	err = hinic3_init_sw_rxtxqs(nic_dev);
@@ -3918,10 +3927,6 @@ hinic3_func_init(struct rte_eth_dev *eth_dev)
 	nic_dev->rx_ops = NULL;
 
 alloc_rx_ops_fail:
-	rte_free(nic_dev->cmdq_ops);
-	nic_dev->cmdq_ops = NULL;
-
-alloc_cmdq_ops_fail:
 	rte_free(eth_dev->data->mac_addrs);
 	eth_dev->data->mac_addrs = NULL;
 
diff --git a/drivers/net/hinic3/hinic3_ethdev.h b/drivers/net/hinic3/hinic3_ethdev.h
index ea1da11295..ec5daf523b 100644
--- a/drivers/net/hinic3/hinic3_ethdev.h
+++ b/drivers/net/hinic3/hinic3_ethdev.h
@@ -157,7 +157,6 @@ struct hinic3_nic_dev {
 	struct hinic3_ethertype_filter_list filter_ethertype_list;
 	struct hinic3_fdir_rule_filter_list filter_fdir_rule_list;
 	uint8_t cos_map[HINIC3_COS_NUM_MAX];
-	struct hinic3_nic_cmdq_ops *cmdq_ops;
 	struct hinic3_nic_rx_ops *rx_ops;
 	struct hinic3_nic_tx_ops *tx_ops;
 	enum nic_type nic_type; /**< NIC type. */
diff --git a/drivers/net/hinic3/hinic3_nic_io.c b/drivers/net/hinic3/hinic3_nic_io.c
index 9203dcce40..361586868e 100644
--- a/drivers/net/hinic3/hinic3_nic_io.c
+++ b/drivers/net/hinic3/hinic3_nic_io.c
@@ -391,8 +391,8 @@ init_sq_ctxts(struct hinic3_nic_dev *nic_dev)
 		max_ctxts = (nic_dev->num_sqs - q_id) > HINIC3_Q_CTXT_MAX
 				    ? HINIC3_Q_CTXT_MAX
 				    : (nic_dev->num_sqs - q_id);
-		cmd = nic_dev->cmdq_ops->prepare_cmd_buf_qp_context_multi_store(nic_dev, cmd_buf,
-			HINIC3_QP_CTXT_TYPE_SQ, q_id, max_ctxts);
+		cmd = hinic3_cmdq_get_ops(nic_dev)->prepare_cmd_buf_qp_context_multi_store(nic_dev,
+			cmd_buf, HINIC3_QP_CTXT_TYPE_SQ, q_id, max_ctxts);
 		rte_atomic_thread_fence(rte_memory_order_seq_cst);
 		err = hinic3_cmdq_direct_resp(nic_dev->hwdev, HINIC3_MOD_L2NIC,
 					      cmd, cmd_buf, &out_param, 0);
@@ -443,8 +443,8 @@ init_rq_ctxts(struct hinic3_nic_dev *nic_dev)
 		max_ctxts = (nic_dev->num_rqs - q_id) > HINIC3_Q_CTXT_MAX
 				    ? HINIC3_Q_CTXT_MAX
 				    : (nic_dev->num_rqs - q_id);
-		cmd = nic_dev->cmdq_ops->prepare_cmd_buf_qp_context_multi_store(nic_dev, cmd_buf,
-			HINIC3_QP_CTXT_TYPE_RQ, q_id, max_ctxts);
+		cmd = hinic3_cmdq_get_ops(nic_dev)->prepare_cmd_buf_qp_context_multi_store(nic_dev,
+			cmd_buf, HINIC3_QP_CTXT_TYPE_RQ, q_id, max_ctxts);
 		rte_atomic_thread_fence(rte_memory_order_seq_cst);
 		err = hinic3_cmdq_direct_resp(nic_dev->hwdev, HINIC3_MOD_L2NIC,
 					      cmd, cmd_buf, &out_param, 0);
@@ -491,7 +491,8 @@ clean_queue_offload_ctxt(struct hinic3_nic_dev *nic_dev,
 		return -ENOMEM;
 	}
 
-	cmd = nic_dev->cmdq_ops->prepare_cmd_buf_clean_tso_lro_space(nic_dev, cmd_buf, ctxt_type);
+	cmd = hinic3_cmdq_get_ops(nic_dev)->prepare_cmd_buf_clean_tso_lro_space(nic_dev,
+		cmd_buf, ctxt_type);
 
 	/* Send a command to hardware to clean up queue offload context. */
 	err = hinic3_cmdq_direct_resp(nic_dev->hwdev, HINIC3_MOD_L2NIC,
diff --git a/drivers/net/hinic3/hinic3_nic_io.h b/drivers/net/hinic3/hinic3_nic_io.h
index e1741d1156..d7ec81f2e6 100644
--- a/drivers/net/hinic3/hinic3_nic_io.h
+++ b/drivers/net/hinic3/hinic3_nic_io.h
@@ -79,6 +79,17 @@ struct hinic3_nic_cmdq_ops {
 	cmd_buf_to_rss_indir_table_t			cmd_buf_to_rss_indir_table;
 };
 
+/**
+ * Get cmdq ops for the given NIC device.
+ *
+ * @param[in] nic_dev
+ * Pointer to NIC device structure.
+ *
+ * @return
+ * Pointer to cmdq ops structure.
+ */
+const struct hinic3_nic_cmdq_ops *hinic3_cmdq_get_ops(struct hinic3_nic_dev *nic_dev);
+
 /* Doorbell info. */
 struct hinic3_db {
 	uint32_t db_info;
diff --git a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c
index 634dfe7239..607fe2d0fe 100644
--- a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c
+++ b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.c
@@ -152,16 +152,11 @@ static void cmd_buf_to_rss_indir_table(const struct hinic3_cmd_buf *cmd_buf, uin
 		indir_table[i] = *(indir_tbl + i);
 }
 
-struct hinic3_nic_cmdq_ops *hinic3_nic_cmdq_get_htn_ops(void)
-{
-	static struct hinic3_nic_cmdq_ops cmdq_ops = {
-		.prepare_cmd_buf_clean_tso_lro_space =    prepare_cmd_buf_clean_tso_lro_space,
-		.prepare_cmd_buf_qp_context_multi_store = prepare_cmd_buf_qp_context_multi_store,
-		.prepare_cmd_buf_modify_svlan =           prepare_cmd_buf_modify_svlan,
-		.prepare_cmd_buf_set_rss_indir_table =    prepare_cmd_buf_set_rss_indir_table,
-		.prepare_cmd_buf_get_rss_indir_table =    prepare_cmd_buf_get_rss_indir_table,
-		.cmd_buf_to_rss_indir_table =             cmd_buf_to_rss_indir_table,
-	};
-
-	return &cmdq_ops;
-}
+const struct hinic3_nic_cmdq_ops hinic3_htn_cmdq_ops = {
+	.prepare_cmd_buf_clean_tso_lro_space =    prepare_cmd_buf_clean_tso_lro_space,
+	.prepare_cmd_buf_qp_context_multi_store = prepare_cmd_buf_qp_context_multi_store,
+	.prepare_cmd_buf_modify_svlan =           prepare_cmd_buf_modify_svlan,
+	.prepare_cmd_buf_set_rss_indir_table =    prepare_cmd_buf_set_rss_indir_table,
+	.prepare_cmd_buf_get_rss_indir_table =    prepare_cmd_buf_get_rss_indir_table,
+	.cmd_buf_to_rss_indir_table =             cmd_buf_to_rss_indir_table,
+};
diff --git a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h
index 73f4922734..158cbc5f8e 100644
--- a/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h
+++ b/drivers/net/hinic3/htn_adapt/hinic3_htn_cmdq.h
@@ -53,11 +53,11 @@ struct hinic3_htn_vlan_ctx {
 };
 
 /**
- * Get cmdq ops hardware tile NIC(htn) supported.
+ * Cmdq ops hardware tile NIC(htn) supported.
  *
  * @return
- * Pointer to ops.
+ * Ops.
  */
-struct hinic3_nic_cmdq_ops *hinic3_nic_cmdq_get_htn_ops(void);
+extern const struct hinic3_nic_cmdq_ops hinic3_htn_cmdq_ops;
 
 #endif /* _HINIC3_HTN_CMDQ_H_ */
diff --git a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c
index f41f060d17..23adbc79f4 100644
--- a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c
+++ b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.c
@@ -108,7 +108,7 @@ static uint8_t prepare_cmd_buf_set_rss_indir_table(struct hinic3_nic_dev *nic_de
 
 	for (i = 0; i < HINIC3_RSS_INDIR_SIZE; i++)
 		indir_tbl->entry[i] = (uint16_t)(*(indir_table + i));
-	size = sizeof(indir_tbl->entry) / 4;
+	size = (size_t)sizeof(indir_tbl->entry) / sizeof(uint32_t);
 	temp = (uint32_t *)indir_tbl->entry;
 	for (i = 0; i < size; i++) {
 		rte_atomic_thread_fence(rte_memory_order_seq_cst);
@@ -136,16 +136,11 @@ static void cmd_buf_to_rss_indir_table(const struct hinic3_cmd_buf *cmd_buf, uin
 		indir_table[i] = *(indir_tbl + i);
 }
 
-struct hinic3_nic_cmdq_ops *hinic3_nic_cmdq_get_stn_ops(void)
-{
-	static struct hinic3_nic_cmdq_ops cmdq_ops = {
-		.prepare_cmd_buf_clean_tso_lro_space =    prepare_cmd_buf_clean_tso_lro_space,
-		.prepare_cmd_buf_qp_context_multi_store = prepare_cmd_buf_qp_context_multi_store,
-		.prepare_cmd_buf_modify_svlan =           prepare_cmd_buf_modify_svlan,
-		.prepare_cmd_buf_set_rss_indir_table =    prepare_cmd_buf_set_rss_indir_table,
-		.prepare_cmd_buf_get_rss_indir_table =    prepare_cmd_buf_get_rss_indir_table,
-		.cmd_buf_to_rss_indir_table =             cmd_buf_to_rss_indir_table,
-	};
-
-	return &cmdq_ops;
-}
+const struct hinic3_nic_cmdq_ops hinic3_stn_cmdq_ops = {
+	.prepare_cmd_buf_clean_tso_lro_space =    prepare_cmd_buf_clean_tso_lro_space,
+	.prepare_cmd_buf_qp_context_multi_store = prepare_cmd_buf_qp_context_multi_store,
+	.prepare_cmd_buf_modify_svlan =           prepare_cmd_buf_modify_svlan,
+	.prepare_cmd_buf_set_rss_indir_table =    prepare_cmd_buf_set_rss_indir_table,
+	.prepare_cmd_buf_get_rss_indir_table =    prepare_cmd_buf_get_rss_indir_table,
+	.cmd_buf_to_rss_indir_table =             cmd_buf_to_rss_indir_table,
+};
diff --git a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h
index f1720c29c7..ab1c73a977 100644
--- a/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h
+++ b/drivers/net/hinic3/stn_adapt/hinic3_stn_cmdq.h
@@ -36,11 +36,11 @@ struct hinic3_stn_vlan_ctx {
 };
 
 /**
- * Get cmdq ops software tile NIC(stn) supported.
+ * Cmdq ops software tile NIC(stn) supported.
  *
  * @return
- * Pointer to ops.
+ * Ops.
  */
-struct hinic3_nic_cmdq_ops *hinic3_nic_cmdq_get_stn_ops(void);
+extern const struct hinic3_nic_cmdq_ops hinic3_stn_cmdq_ops;
 
 #endif /* _HINIC3_STN_CMDQ_H_ */
-- 
2.33.0

