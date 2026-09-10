Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B6EFC79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:55:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BFC1842E8B;
	Thu, 10 Sep 2026 15:52:54 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 4F31E427C2
 for <dev@dpdk.org>; Thu, 10 Sep 2026 15:52:42 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 31BA120043A;
 Thu, 10 Sep 2026 15:52:42 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id C664C200023;
 Thu, 10 Sep 2026 15:52:41 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 6CE361800068;
 Thu, 10 Sep 2026 21:52:40 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v2 34/47] net/dpaa2: update MC dpni QoS and flow steering API
Date: Thu, 10 Sep 2026 19:21:45 +0530
Message-ID: <20260910135158.2181141-35-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
References: <20260903135353.3358303-1-prashant.gupta_3@nxp.com>
 <20260910135158.2181141-1-prashant.gupta_3@nxp.com>
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

From: Hemant Agrawal <hemant.agrawal@nxp.com>

Update the MC firmware command interface for the QoS and flow steering
(FS) tables ahead of the flow engine rework:

- Version the SET_QOS_TBL / ADD_FS_ENT commands and add
  dpni_set_qos_table_v2() and dpni_add_fs_entry_legacy() wrappers.
- Support a per-entry default flow id in the QoS table configuration.
- Replace the single redirect_obj_token in dpni_fs_action_cfg with a
  redir_tokens[] array plus num_tokens, and program it via the new
  ADD_FS_ENT command.
- Add the dpni dump-table structures.

The existing flow code is updated to populate the new redir_tokens[]
field so behaviour is unchanged.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_flow.c      |   3 +-
 drivers/net/dpaa2/mc/dpni.c         | 127 ++++++++++++++++++++--------
 drivers/net/dpaa2/mc/fsl_dpni.h     | 100 ++++++++++++++++++++--
 drivers/net/dpaa2/mc/fsl_dpni_cmd.h |  30 ++++---
 4 files changed, 206 insertions(+), 54 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index 06ec1a2660..88a639ba89 100644
--- a/drivers/net/dpaa2/dpaa2_flow.c
+++ b/drivers/net/dpaa2/dpaa2_flow.c
@@ -4445,7 +4445,8 @@ dpaa2_configure_flow_fs_action(struct dpaa2_dev_priv *priv,
 		dest_q = dest_priv->tx_vq[0];
 		flow->fs_action_cfg.options =
 			DPNI_FS_OPT_REDIRECT_TO_DPNI_TX;
-		flow->fs_action_cfg.redirect_obj_token =
+		flow->fs_action_cfg.num_tokens = 1;
+		flow->fs_action_cfg.redir_tokens[0] =
 			dest_priv->token;
 		flow->fs_action_cfg.flow_id = dest_q->flow_id;
 	} else if (flow->action_type == RTE_FLOW_ACTION_TYPE_DROP) {
diff --git a/drivers/net/dpaa2/mc/dpni.c b/drivers/net/dpaa2/mc/dpni.c
index 17275b7195..8e4114e604 100644
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
@@ -2169,30 +2210,16 @@ int dpni_clear_fs_entries(struct fsl_mc_io *mc_io,
 	return mc_send_command(mc_io, &cmd);
 }
 
-/**
- * dpni_set_rx_tc_policing() - Set Rx traffic class policing configuration
- * @mc_io:	Pointer to MC portal's I/O object
- * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
- * @token:	Token of DPNI object
- * @tc_id:	Traffic class selection (0-7)
- * @cfg:	Traffic class policing configuration
- *
- * Return:	'0' on Success; error code otherwise.
- */
-int dpni_set_rx_tc_policing(struct fsl_mc_io *mc_io,
-			    uint32_t cmd_flags,
-			    uint16_t token,
-			    uint8_t tc_id,
-			    const struct dpni_rx_tc_policing_cfg *cfg)
+static int
+_dpni_set_rx_tc_policing(struct fsl_mc_io *mc_io,
+	uint32_t cmd_flags, uint16_t token, uint8_t tc_id,
+	const struct dpni_rx_tc_policing_cfg *cfg, uint16_t cmd_id)
 {
 	struct dpni_cmd_set_rx_tc_policing *cmd_params;
 	struct mc_command cmd = { 0 };
 
-	/* prepare command */
-	cmd.header = mc_encode_cmd_header(DPNI_CMDID_SET_RX_TC_POLICING,
-					  cmd_flags,
-					  token);
-	cmd_params = (struct dpni_cmd_set_rx_tc_policing *)cmd.params;
+	cmd.header = mc_encode_cmd_header(cmd_id, cmd_flags, token);
+	cmd_params = (void *)cmd.params;
 	dpni_set_field(cmd_params->mode_color, COLOR, cfg->default_color);
 	dpni_set_field(cmd_params->mode_color, MODE, cfg->mode);
 	dpni_set_field(cmd_params->units, UNITS, cfg->units);
@@ -2207,6 +2234,34 @@ int dpni_set_rx_tc_policing(struct fsl_mc_io *mc_io,
 	return mc_send_command(mc_io, &cmd);
 }
 
+/**
+ * dpni_set_rx_tc_policing() - Set Rx traffic class policing configuration
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPNI object
+ * @tc_id:	Traffic class selection (0-7)
+ * @cfg:	Traffic class policing configuration
+ *
+ * Return:	'0' on Success; error code otherwise.
+ */
+int
+dpni_set_rx_tc_policing(struct fsl_mc_io *mc_io,
+	uint32_t cmd_flags, uint16_t token, uint8_t tc_id,
+	const struct dpni_rx_tc_policing_cfg *cfg)
+{
+	return _dpni_set_rx_tc_policing(mc_io, cmd_flags, token, tc_id, cfg,
+		DPNI_CMDID_SET_RX_TC_POLICING);
+}
+
+int
+dpni_set_rx_tc_policing_v1(struct fsl_mc_io *mc_io,
+	uint32_t cmd_flags, uint16_t token, uint8_t tc_id,
+	const struct dpni_rx_tc_policing_cfg *cfg)
+{
+	return _dpni_set_rx_tc_policing(mc_io, cmd_flags, token, tc_id, cfg,
+		DPNI_CMDID_SET_RX_TC_POLICING_V1);
+}
+
 /**
  * dpni_get_rx_tc_policing() - Get Rx traffic class policing configuration
  * @mc_io:	Pointer to MC portal's I/O object
diff --git a/drivers/net/dpaa2/mc/fsl_dpni.h b/drivers/net/dpaa2/mc/fsl_dpni.h
index d227025e01..f315bb7004 100644
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
@@ -1554,6 +1557,8 @@ struct dpni_qos_tbl_cfg {
 	int discard_on_miss;
 	int keep_entries;
 	uint8_t default_tc;
+	int set_default_flow_id;
+	uint16_t default_flow_id;
 };
 
 int dpni_set_qos_table(struct fsl_mc_io *mc_io,
@@ -1561,6 +1566,11 @@ int dpni_set_qos_table(struct fsl_mc_io *mc_io,
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
@@ -1573,6 +1583,10 @@ struct dpni_rule_cfg {
 	uint8_t key_size;
 };
 
+#define DPNI_QOS_OPT_SET_TC_ONLY 0x0
+#define DPNI_QOS_OPT_SET_FLOW_ID 0x1
+#define DPNI_QOS_OPT_UPDATE_IF_EXISTS 0x2
+
 int dpni_add_qos_entry(struct fsl_mc_io *mc_io,
 		       uint32_t cmd_flags,
 		       uint16_t token,
@@ -1633,6 +1647,22 @@ int dpni_clear_qos_table(struct fsl_mc_io *mc_io,
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
@@ -1650,12 +1680,38 @@ int dpni_clear_qos_table(struct fsl_mc_io *mc_io,
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
@@ -1666,6 +1722,14 @@ int dpni_add_fs_entry(struct fsl_mc_io *mc_io,
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
@@ -1928,7 +1992,7 @@ void dpni_extract_sw_sequence_layout(struct dpni_sw_sequence_layout *layout,
  * When used for queue_idx in function dpni_set_rx_dist_default_queue will signal to dpni
  * to drop all unclassified frames
  */
-#define DPNI_FS_MISS_DROP		((uint16_t)-1)
+#define DPNI_FS_MISS_ACTION_DROP		((uint16_t)-1)
 
 /**
  * struct dpni_rx_dist_cfg - distribution configuration
@@ -1941,9 +2005,10 @@ void dpni_extract_sw_sequence_layout(struct dpni_sw_sequence_layout *layout,
  * @enable: enable/disable the distribution.
  * @tc: TC id for which distribution is set
  * @fs_miss_flow_id: when packet misses all rules from flow steering table and hash is
- *		disabled it will be put into this queue id; use DPNI_FS_MISS_DROP to drop
- *		frames. The value of this field is used only when flow steering distribution
- *		is enabled and hash distribution is disabled
+ *		disabled it will be put into this queue id;
+ *		use DPNI_FS_MISS_ACTION_DROP to drop frames.
+ *		The value of this field is used only when flow steering
+ *		distribution is enabled and hash distribution is disabled.
  */
 struct dpni_rx_dist_cfg {
 	uint16_t dist_size;
@@ -2035,6 +2100,29 @@ enum dpni_table_type {
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

