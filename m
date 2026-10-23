Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5E0606A31A
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:45:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4459A40DD2;
	Fri, 23 Oct 2026 15:44:16 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 7A8DC40695
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:09 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 59B6D1A0038;
 Fri, 23 Oct 2026 15:44:09 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id E9DD01A000A;
 Fri, 23 Oct 2026 15:44:08 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id DFCE91800068;
 Fri, 23 Oct 2026 21:44:07 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 16/65] net/dpaa2: support multi-DPNI FS redirect and QoS
 table v3
Date: Fri, 23 Oct 2026 19:12:56 +0530
Message-ID: <20261023134346.37727-17-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261023134346.37727-1-prashant.gupta_3@nxp.com>
References: <20260915120208.4185877-1-prashant.gupta_3@nxp.com>
 <20261023134346.37727-1-prashant.gupta_3@nxp.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Jun Yang <jun.yang@nxp.com>

Pick up the newer MC command versions for the DPNI flow-steering and
QoS table APIs, and expose the multi-DPNI redirect feature they add,
while keeping the driver working against older MC firmwares.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.h    |  3 +
 drivers/net/dpaa2/dpaa2_flow.c      | 27 +++++---
 drivers/net/dpaa2/mc/dpni.c         | 73 +++++++++++++++++-----
 drivers/net/dpaa2/mc/fsl_dpni.h     | 95 +++++++++++++++++++++++++++--
 drivers/net/dpaa2/mc/fsl_dpni_cmd.h | 30 +++++----
 5 files changed, 189 insertions(+), 39 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index ddc205c2d4..cc0292cd9c 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -204,6 +204,9 @@
 #define DPAA2_PKT_TYPE_VLAN \
 	(DPAA2_PKT_TYPE_VLAN_1 | DPAA2_PKT_TYPE_VLAN_2)
 
+#define DPAA2_FLOW_FRM_REPLICATION_ACTION_MC_REV RTE_FSL_MC_REV(10, 39, 106)
+#define DPAA2_QOS_FLOW_TABLE_SET_V3_MC_REV RTE_FSL_MC_REV(10, 39, 109)
+
 /* mac counters */
 #define DPAA2_MAC_NUM_STATS            (DPMAC_CNT_EGR_CONTROL_FRAME + 1)
 #define DPAA2_MAC_STATS_INDEX_DMA_SIZE (DPAA2_MAC_NUM_STATS * sizeof(uint32_t))
diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index 8e65faf75d..72958c0f93 100644
--- a/drivers/net/dpaa2/dpaa2_flow.c
+++ b/drivers/net/dpaa2/dpaa2_flow.c
@@ -539,10 +539,17 @@ dpaa2_flow_add_fs_rule(struct dpaa2_dev_priv *priv,
 
 	dpaa2_flow_fs_entry_log("Start add", flow);
 
-	ret = dpni_add_fs_entry(dpni, CMD_PRI_LOW,
-			priv->token, flow->tc_id,
-			flow->tc_index, &flow->fs_rule,
-			&flow->fs_action_cfg);
+	if (priv->mc_rev >= DPAA2_FLOW_FRM_REPLICATION_ACTION_MC_REV) {
+		ret = dpni_add_fs_entry(dpni, CMD_PRI_LOW,
+				priv->token, flow->tc_id,
+				flow->tc_index, &flow->fs_rule,
+				&flow->fs_action_cfg);
+	} else {
+		ret = dpni_add_fs_entry_legacy(dpni, CMD_PRI_LOW,
+				priv->token, flow->tc_id,
+				flow->tc_index, &flow->fs_rule,
+				&flow->fs_action_cfg);
+	}
 	if (ret < 0) {
 		DPAA2_PMD_ERR("Add rule(%d) to FS table(%d) failed",
 			flow->tc_index, flow->tc_id);
@@ -4424,8 +4431,8 @@ dpaa2_configure_flow_fs_action(struct dpaa2_dev_priv *priv,
 		dest_q = dest_priv->tx_vq[0];
 		flow->fs_action_cfg.options =
 			DPNI_FS_OPT_REDIRECT_TO_DPNI_TX;
-		flow->fs_action_cfg.redirect_obj_token =
-			dest_priv->token;
+		flow->fs_action_cfg.num_tokens = 1;
+		flow->fs_action_cfg.redir_tokens[0] = dest_priv->token;
 		flow->fs_action_cfg.flow_id = dest_q->flow_id;
 	} else if (flow->action_type == RTE_FLOW_ACTION_TYPE_DROP) {
 		flow->fs_action_cfg.options = DPNI_FS_OPT_DISCARD;
@@ -4626,8 +4633,12 @@ dpaa2_configure_qos_table(struct dpaa2_dev_priv *priv,
 		qos_cfg.default_tc = 0;
 	}
 
-	ret = dpni_set_qos_table(dpni, CMD_PRI_LOW,
-			priv->token, &qos_cfg);
+	if (priv->mc_rev < DPAA2_QOS_FLOW_TABLE_SET_V3_MC_REV)
+		ret = dpni_set_qos_table_v2(dpni, CMD_PRI_LOW,
+				priv->token, &qos_cfg);
+	else
+		ret = dpni_set_qos_table(dpni, CMD_PRI_LOW,
+				priv->token, &qos_cfg);
 	if (ret < 0) {
 		DPAA2_PMD_ERR("QoS table set failed");
 		return ret;
diff --git a/drivers/net/dpaa2/mc/dpni.c b/drivers/net/dpaa2/mc/dpni.c
index 17275b7195..54df66416a 100644
--- a/drivers/net/dpaa2/mc/dpni.c
+++ b/drivers/net/dpaa2/mc/dpni.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2016-2025 NXP
+ * Copyright 2016-2026 NXP
  *
  */
 #include <fsl_mc_sys.h>
@@ -1937,32 +1937,43 @@ int dpni_get_queue_tx_confirmation_mode(struct fsl_mc_io *mc_io,
  *
  * Return:	'0' on Success; Error code otherwise.
  */
-int dpni_set_qos_table(struct fsl_mc_io *mc_io,
-		       uint32_t cmd_flags,
-		       uint16_t token,
-		       const struct dpni_qos_tbl_cfg *cfg)
+static int
+_dpni_set_qos_table(struct fsl_mc_io *mc_io, uint32_t cmd_flags,
+	uint16_t token, const struct dpni_qos_tbl_cfg *cfg, uint16_t cmd_id)
 {
 	struct dpni_cmd_set_qos_table *cmd_params;
 	struct mc_command cmd = { 0 };
 
 	/* prepare command */
-	cmd.header = mc_encode_cmd_header(DPNI_CMDID_SET_QOS_TBL,
-					  cmd_flags,
-					  token);
-	cmd_params = (struct dpni_cmd_set_qos_table *)cmd.params;
+	cmd.header = mc_encode_cmd_header(cmd_id, cmd_flags, token);
+	cmd_params = (void *)cmd.params;
 	cmd_params->default_tc = cfg->default_tc;
 	cmd_params->key_cfg_iova = cpu_to_le64(cfg->key_cfg_iova);
-	dpni_set_field(cmd_params->discard_on_miss,
-		       ENABLE,
-		       cfg->discard_on_miss);
-	dpni_set_field(cmd_params->discard_on_miss,
-					KEEP_QOS_ENTRIES,
-			       cfg->keep_entries);
+	if (DPNI_CMD_VER(cmd_id) > DPNI_CMD_VERSION_2)
+		cmd_params->default_flow_id = cpu_to_le16(cfg->default_flow_id);
+	dpni_set_field(cmd_params->flags, DISCARD_ON_MISS, cfg->discard_on_miss);
+	dpni_set_field(cmd_params->flags, KEEP_QOS_ENTRIES, cfg->keep_entries);
+	if (DPNI_CMD_VER(cmd_id) > DPNI_CMD_VERSION_2)
+		dpni_set_field(cmd_params->flags, SET_DEFAULT_FLOW_ID, cfg->set_default_flow_id);
 
 	/* send command to mc*/
 	return mc_send_command(mc_io, &cmd);
 }
 
+int
+dpni_set_qos_table(struct fsl_mc_io *mc_io, uint32_t cmd_flags,
+	uint16_t token, const struct dpni_qos_tbl_cfg *cfg)
+{
+	return _dpni_set_qos_table(mc_io, cmd_flags, token, cfg, DPNI_CMDID_SET_QOS_TBL);
+}
+
+int
+dpni_set_qos_table_v2(struct fsl_mc_io *mc_io, uint32_t cmd_flags,
+	uint16_t token, const struct dpni_qos_tbl_cfg *cfg)
+{
+	return _dpni_set_qos_table(mc_io, cmd_flags, token, cfg, DPNI_CMDID_SET_QOS_TBL_V2);
+}
+
 /**
  * dpni_add_qos_entry() - Add QoS mapping entry (to select a traffic class)
  * @mc_io:	Pointer to MC portal's I/O object
@@ -2086,6 +2097,7 @@ int dpni_add_fs_entry(struct fsl_mc_io *mc_io,
 {
 	struct dpni_cmd_add_fs_entry *cmd_params;
 	struct mc_command cmd = { 0 };
+	int i;
 
 	/* prepare command */
 	cmd.header = mc_encode_cmd_header(DPNI_CMDID_ADD_FS_ENT,
@@ -2100,7 +2112,36 @@ int dpni_add_fs_entry(struct fsl_mc_io *mc_io,
 	cmd_params->options = cpu_to_le16(action->options);
 	cmd_params->flow_id = cpu_to_le16(action->flow_id);
 	cmd_params->flc = cpu_to_le64(action->flc);
-	cmd_params->redir_token = cpu_to_le16(action->redirect_obj_token);
+	cmd_params->token_num = action->num_tokens;
+	for (i = 0; i < DPNI_FS_REDIR_MAX_NUM; i++)
+		cmd_params->redir_tokens[i] = cpu_to_le16(action->redir_tokens[i]);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+int dpni_add_fs_entry_legacy(struct fsl_mc_io *mc_io,
+	uint32_t cmd_flags, uint16_t token,
+	uint8_t tc_id, uint16_t index,
+	const struct dpni_rule_cfg *cfg,
+	const struct dpni_fs_action_cfg *action)
+{
+	struct dpni_cmd_add_fs_entry *cmd_params;
+	struct mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPNI_CMDID_ADD_FS_ENT_LEGACY,
+		cmd_flags, token);
+	cmd_params = (struct dpni_cmd_add_fs_entry *)cmd.params;
+	cmd_params->tc_id = tc_id;
+	cmd_params->key_size = cfg->key_size;
+	cmd_params->index = cpu_to_le16(index);
+	cmd_params->key_iova = cpu_to_le64(cfg->key_iova);
+	cmd_params->mask_iova = cpu_to_le64(cfg->mask_iova);
+	cmd_params->options = cpu_to_le16(action->options);
+	cmd_params->flow_id = cpu_to_le16(action->flow_id);
+	cmd_params->flc = cpu_to_le64(action->flc);
+	cmd_params->redir_tokens[0] = cpu_to_le16(action->redir_tokens[0]);
 
 	/* send command to mc*/
 	return mc_send_command(mc_io, &cmd);
diff --git a/drivers/net/dpaa2/mc/fsl_dpni.h b/drivers/net/dpaa2/mc/fsl_dpni.h
index 8913b408e7..f47f383a9b 100644
--- a/drivers/net/dpaa2/mc/fsl_dpni.h
+++ b/drivers/net/dpaa2/mc/fsl_dpni.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2016-2025 NXP
+ * Copyright 2016-2026 NXP
  *
  */
 #ifndef __FSL_DPNI_H
@@ -121,6 +121,9 @@ struct fsl_mc_io;
  * The stashing is enabled by default.
  */
 #define DPNI_OPT_STASHING_DIS			0x002000
+
+#define DPNI_OPT_V8_HAS_REPLICATION		0x00004000
+
 /*
  * PFDR in PEB mode (v1 layout).
  * The total number of Rx descriptors is limited to 11264 in this mode.
@@ -1539,6 +1542,8 @@ struct dpni_qos_tbl_cfg {
 	int discard_on_miss;
 	int keep_entries;
 	uint8_t default_tc;
+	int set_default_flow_id;
+	uint16_t default_flow_id;
 };
 
 int dpni_set_qos_table(struct fsl_mc_io *mc_io,
@@ -1546,6 +1551,11 @@ int dpni_set_qos_table(struct fsl_mc_io *mc_io,
 		       uint16_t token,
 		       const struct dpni_qos_tbl_cfg *cfg);
 
+int dpni_set_qos_table_v2(struct fsl_mc_io *mc_io,
+		       uint32_t cmd_flags,
+		       uint16_t token,
+		       const struct dpni_qos_tbl_cfg *cfg);
+
 /**
  * struct dpni_rule_cfg - Rule configuration for table lookup
  * @key_iova: I/O virtual address of the key (must be in DMA-able memory)
@@ -1558,6 +1568,10 @@ struct dpni_rule_cfg {
 	uint8_t key_size;
 };
 
+#define DPNI_QOS_OPT_SET_TC_ONLY 0x0
+#define DPNI_QOS_OPT_SET_FLOW_ID 0x1
+#define DPNI_QOS_OPT_UPDATE_IF_EXISTS 0x2
+
 int dpni_add_qos_entry(struct fsl_mc_io *mc_io,
 		       uint32_t cmd_flags,
 		       uint16_t token,
@@ -1618,6 +1632,22 @@ int dpni_clear_qos_table(struct fsl_mc_io *mc_io,
  */
 #define DPNI_FS_OPT_REDIRECT_TO_DPNI_TX		0x10
 
+/**
+ * Redirect matching traffic into multiple Tx queues of other dpni objects.
+ * The frame will be transmitted directly
+ */
+#define DPNI_FS_OPT_REDIRECT_TO_MULTIPLE_DPNI_TX	0x20
+
+/**
+ * In case the FS rule already exists (key and mask), update its action.
+ * Cannot be used with the actions which redirect the frame towards other DPNIs.
+ */
+#define DPNI_FS_OPT_UPDATE_IF_EXISTS	0x40
+
+#ifndef DPNI_FS_REDIR_MAX_NUM
+#define DPNI_FS_REDIR_MAX_NUM 8
+#endif
+
 /**
  * struct dpni_fs_action_cfg - Action configuration for table look-up
  * @flc: FLC value for traffic matching this rule.  Please check the Frame
@@ -1635,12 +1665,38 @@ int dpni_clear_qos_table(struct fsl_mc_io *mc_io,
  * - if DPNI_FS_OPT_DISCARD is cleared the frame will be enqueued in queue with
  *   index provided in flow_id parameter.
  * @options: Any combination of DPNI_FS_OPT_ values.
+ * @token_num: Number of tokens supplied. For DPNI_FS_OPT_REDIRECT_TO_DPNI_RX
+ *	 or DPNI_FS_OPT_REDIRECT_TO_DPNI_TX, the token_num must be 1 since there is
+ *	 only one token which is necessary. Accepted values are in the
+ *	 [1-8] range in case a REDIRECT option is requested.
+ * @redir_tokens: Array of tokens that identify the object where frame is redirected
+ *	 when this rule is hit. This parameter is used only when one
+ *	 of the flags DPNI_FS_OPT_REDIRECT_TO_DPNI_RX,
+ *	 DPNI_FS_OPT_REDIRECT_TO_DPNI_TX or
+ *	 DPNI_FS_OPT_REDIRECT_TO_MULTIPLE_DPNI_TX is set. The tokens
+ *	 are obtained using dpni_open() API call. The objects must
+ *	 stay open during the operation to ensure the fact that
+ *	 application has access on them.
+ *	 If the object is destroyed of closed, the following actions
+ *	 will take place:
+ *	 - In case of DPNI_FS_OPT_REDIRECT_TO_DPNI_TX and
+ *	 DPNI_FS_OPT_REDIRECT_TO_DPNI_RX:
+ *			 + if DPNI_FS_OPT_DISCARD is set the frame will be
+ *			 discarded by current dpni
+ *			 + if DPNI_FS_OPT_DISCARD is cleared the frame will be
+ *			 enqueued in queue with index provided in flow_id
+ *			 parameter.
+ *	 - In case of DPNI_FS_OPT_REDIRECT_TO_MULTIPLE_DPNI_TX, the
+ *	 frame will be redirected to the remaining opened target
+ *	 DPNIs. If there are no more opened target DPNIs, the frame
+ *	 will be discarded.
  */
 struct dpni_fs_action_cfg {
 	uint64_t flc;
 	uint16_t flow_id;
-	uint16_t redirect_obj_token;
 	uint16_t options;
+	uint16_t num_tokens;
+	uint16_t redir_tokens[DPNI_FS_REDIR_MAX_NUM];
 };
 
 int dpni_add_fs_entry(struct fsl_mc_io *mc_io,
@@ -1651,6 +1707,14 @@ int dpni_add_fs_entry(struct fsl_mc_io *mc_io,
 		      const struct dpni_rule_cfg *cfg,
 		      const struct dpni_fs_action_cfg *action);
 
+int dpni_add_fs_entry_legacy(struct fsl_mc_io *mc_io,
+		      uint32_t cmd_flags,
+		      uint16_t token,
+		      uint8_t tc_id,
+		      uint16_t index,
+		      const struct dpni_rule_cfg *cfg,
+		      const struct dpni_fs_action_cfg *action);
+
 int dpni_remove_fs_entry(struct fsl_mc_io *mc_io,
 			 uint32_t cmd_flags,
 			 uint16_t token,
@@ -1913,7 +1977,7 @@ void dpni_extract_sw_sequence_layout(struct dpni_sw_sequence_layout *layout,
  * When used for queue_idx in function dpni_set_rx_dist_default_queue will signal to dpni
  * to drop all unclassified frames
  */
-#define DPNI_FS_MISS_DROP		((uint16_t)-1)
+#define DPNI_FS_MISS_ACTION_DROP		((uint16_t)-1)
 
 /**
  * struct dpni_rx_dist_cfg - distribution configuration
@@ -1926,7 +1990,7 @@ void dpni_extract_sw_sequence_layout(struct dpni_sw_sequence_layout *layout,
  * @enable: enable/disable the distribution.
  * @tc: TC id for which distribution is set
  * @fs_miss_flow_id: when packet misses all rules from flow steering table and hash is
- *		disabled it will be put into this queue id; use DPNI_FS_MISS_DROP to drop
+ *		disabled it will be put into this queue id; use DPNI_FS_MISS_ACTION_DROP to drop
  *		frames. The value of this field is used only when flow steering distribution
  *		is enabled and hash distribution is disabled
  */
@@ -2020,6 +2084,29 @@ enum dpni_table_type {
 	DPNI_VLAN_TABLE = 4,
 };
 
+struct __rte_packed_begin dpni_dump_table_header {
+	uint16_t table_type;
+	uint16_t table_num_entries;
+	uint16_t table_max_entries;
+	uint8_t default_action;
+	uint8_t match_type;
+	uint8_t reserved[24];
+} __rte_packed_end;
+
+struct __rte_packed_begin dpni_dump_table_entry {
+	uint8_t key[DPNI_MAX_KEY_SIZE];
+	uint8_t mask[DPNI_MAX_KEY_SIZE];
+	uint8_t key_action;
+	uint16_t result[3];
+	uint16_t rule_index;
+	uint8_t reserved[19];
+} __rte_packed_end;
+
+struct __rte_packed_begin dpni_dump_table_rsp {
+	struct dpni_dump_table_header hdr;
+	struct dpni_dump_table_entry entry[];
+} __rte_packed_end;
+
 int dpni_dump_table(struct fsl_mc_io *mc_io,
 			 uint32_t cmd_flags,
 			 uint16_t token,
diff --git a/drivers/net/dpaa2/mc/fsl_dpni_cmd.h b/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
index 6b396ca7cc..36e4aacc3a 100644
--- a/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
+++ b/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause OR GPL-2.0
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2016-2025 NXP
+ * Copyright 2016-2026 NXP
  *
  */
 #ifndef _FSL_DPNI_CMD_H
@@ -20,6 +20,7 @@
 #define DPNI_CMD_VERSION_7			7
 #define DPNI_CMD_ID_OFFSET			4
 
+#define DPNI_CMD_VER(cmd_id) ((cmd_id) & ((1 << DPNI_CMD_ID_OFFSET) - 1))
 #define DPNI_CMD(id)	(((id) << DPNI_CMD_ID_OFFSET) | DPNI_CMD_BASE_VERSION)
 #define DPNI_CMD_V2(id)	(((id) << DPNI_CMD_ID_OFFSET) | DPNI_CMD_VERSION_2)
 #define DPNI_CMD_V3(id)	(((id) << DPNI_CMD_ID_OFFSET) | DPNI_CMD_VERSION_3)
@@ -77,13 +78,16 @@
 
 #define DPNI_CMDID_SET_RX_TC_DIST		DPNI_CMD_V4(0x235)
 
-#define DPNI_CMDID_SET_RX_TC_POLICING		DPNI_CMD(0x23E)
+#define DPNI_CMDID_SET_RX_TC_POLICING_V1	DPNI_CMD(0x23E)
+#define DPNI_CMDID_SET_RX_TC_POLICING		DPNI_CMD_V2(0x23E)
 
-#define DPNI_CMDID_SET_QOS_TBL			DPNI_CMD_V2(0x240)
+#define DPNI_CMDID_SET_QOS_TBL			DPNI_CMD_V3(0x240)
+#define DPNI_CMDID_SET_QOS_TBL_V2		DPNI_CMD_V2(0x240)
 #define DPNI_CMDID_ADD_QOS_ENT			DPNI_CMD_V2(0x241)
 #define DPNI_CMDID_REMOVE_QOS_ENT		DPNI_CMD(0x242)
 #define DPNI_CMDID_CLR_QOS_TBL			DPNI_CMD(0x243)
-#define DPNI_CMDID_ADD_FS_ENT			DPNI_CMD_V2(0x244)
+#define DPNI_CMDID_ADD_FS_ENT_LEGACY	DPNI_CMD_V2(0x244)
+#define DPNI_CMDID_ADD_FS_ENT			DPNI_CMD_V3(0x244)
 #define DPNI_CMDID_REMOVE_FS_ENT		DPNI_CMD(0x245)
 #define DPNI_CMDID_CLR_FS_ENT			DPNI_CMD(0x246)
 
@@ -584,19 +588,18 @@ struct dpni_cmd_set_queue {
 #define DPNI_DISCARD_ON_MISS_SIZE	1
 #define DPNI_KEEP_QOS_ENTRIES_SHIFT		1
 #define DPNI_KEEP_QOS_ENTRIES_SIZE		1
+#define DPNI_SET_DEFAULT_FLOW_ID_SHIFT  2
+#define DPNI_SET_DEFAULT_FLOW_ID_SIZE   1
 
 struct dpni_cmd_set_qos_table {
-	uint32_t pad;
+	uint16_t pad;
+	uint16_t default_flow_id;
 	uint8_t default_tc;
-	/* only the LSB */
-	uint8_t discard_on_miss;
+	uint8_t flags;
 	uint16_t pad1[21];
 	uint64_t key_cfg_iova;
 };
 
-#define DPNI_QOS_OPT_SET_TC_ONLY 0x0
-#define DPNI_QOS_OPT_SET_FLOW_ID 0x1
-
 struct dpni_cmd_add_qos_entry {
 	uint8_t flags;
 	uint8_t flow_id;
@@ -616,6 +619,10 @@ struct dpni_cmd_remove_qos_entry {
 	uint64_t mask_iova;
 };
 
+#ifndef DPNI_FS_REDIR_MAX_NUM
+#define DPNI_FS_REDIR_MAX_NUM 8
+#endif
+
 struct dpni_cmd_add_fs_entry {
 	uint16_t options;
 	uint8_t tc_id;
@@ -625,7 +632,8 @@ struct dpni_cmd_add_fs_entry {
 	uint64_t key_iova;
 	uint64_t mask_iova;
 	uint64_t flc;
-	uint16_t redir_token;
+	uint16_t redir_tokens[DPNI_FS_REDIR_MAX_NUM];
+	uint8_t token_num;
 };
 
 struct dpni_cmd_remove_fs_entry {
-- 
2.43.0

