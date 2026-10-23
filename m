Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BE4606A31B
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:46:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1485540B8D;
	Fri, 23 Oct 2026 15:44:25 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 855C640DDE
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:16 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 46A1E1A0038;
 Fri, 23 Oct 2026 15:44:16 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 314AB1A000A;
 Fri, 23 Oct 2026 15:44:15 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7875B18000B1;
 Fri, 23 Oct 2026 21:44:13 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 21/65] net/dpaa2: rework flow with per-table profile and
 group types
Date: Fri, 23 Oct 2026 19:13:01 +0530
Message-ID: <20261023134346.37727-22-prashant.gupta_3@nxp.com>
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

The dpaa2 PMD flow engine was built around a device-wide extract_s
blob (qos_key_extract + tc_key_extract[MAX_TCS]) and a single
dpaa2_dev_flow object that carried QoS and FS state side by side
(qos_rule / fs_rule, qos_key_addr / fs_key_addr, ...). Growing new
features onto that layout had become painful:

- There was no clean way to express a "QoS only", "FS only" or
  "RSS" flow; everything flowed through the same code path.
- IP src/dst and L4 src/dst extracts were open-coded with
  ip_addr_type / ip_addr_extract_pos / l4_src_port_pos state
  that was easy to desync when rules were added or removed.
- There was no bookkeeping of which hardware entries were in use,
  no runtime "clean invalid extract" step, and no way to update
  the action on an existing rule or set per-group miss actions.
- Protocol parsers were a long series of
  dpaa2_configure_flow_<proto>() clones that each had their own
  tunnel/raw/soft-parser branches and FAF handling.
- QoS and FS table setup, default action programming and
  entry/update/remove were all duplicated.

Reimplement the flow engine around a per-table profile and a
per-type generic flow:

Core data model (dpaa2_ethdev.h):

- Replace struct extract_s and the two parallel dpaa2_key_extract
  arrays with struct dpaa2_flow_profile, which holds a
  dpaa2_flow_tbl_profile for the single QoS table and one per TC
  for FS/RSS. Each tbl_profile owns its dpkg extract param DMA
  buffer, dpni_qos_tbl_cfg / dpni_rx_dist_cfg config, default
  action (default_drop / default_jump / default_queue), rss_flow
  pointer, and an entry_map bitmap tracking used indices.
- Replace the open-coded IP/L4 extract state with
  struct dpaa2_ip_addr_extract ip_addr[2] and
  struct dpaa2_l4_port_extract l4_port[DPAA2_L4_PORT_NUM], plus
  a key_profile that is just dpkg + prot_field[] with
  (type, prot, key_field, key_offset, key_size) per extract.
- Delete the old DPAA2_FAFE_PSR_OFFSET / enum dpaa2_rx_faf_offset
  constants: FAF/PSR bit offsets are now obtained from the parser
  decode helpers (dpaa2_protocol_psr_bit_offset).

Add new DPAA2_QOS_FLOW_TABLE_MISS_FLOW_ACTION_MC_REV
(10.39.109) gating for QoS miss-flow-id action, and
DPAA2_QOS_ONLY_FLOW_STEER_FLAG to force a device into
QoS-only mode.

Flow object model (dpaa2_flow.c):

- Introduce struct dpaa2_generic_flow carrying one steering flow:
  type (QOS/FS/RSS), rule_cfg, key_addr/mask_addr, rule_size,
  entry_index, ip_key/ip_src/ip_dst, tc_id, action_type and an
  embedded dpaa2_dev_fs_action (dpni_fs_action_cfg + per-redir
  dst_name[]). A dpaa2_dev_flow now just references up to three
  dpaa2_generic_flow objects (qos_flow / fs_flow / rss_flow),
  allowing a user flow to be any combination.
- Add generic flow lifecycle helpers (init / deinit / add rule /
  remove rule / verify entry) plus entry_map get/set so that
  conflicting entries are detected before HW programming.

Extract/rule insertion helpers:

- Centralize all extract-set operations into:
  dpaa2_profile_insert_ipaddr_extract(),
  dpaa2_profile_insert_no_ipaddr_extract(),
  dpaa2_dpkg_insert_extract(),
  dpaa2_flow_rule_insert_hole() /
  _dpaa2_flow_rule_insert_hole().
  These are the only places that touch key_offset / key_size and
  move trailing extracts when a new field is inserted.
- Build dpaa2_flow_extract_add_hdr / _add_soft_psr / _add_faf_psr
  / _add_raw on top of them, and corresponding
  dpaa2_flow_add_hdr_extract_rule / _add_ipaddr_extract_rule /
  _add_soft_psr_extract_rule / _faf_add_rule to attach actual
  key/mask bytes.

Protocol handling:

- Replace the per-protocol dpaa2_configure_flow_<proto>() set
  with a single dispatch table s_dpaa2_flow_proto_handle[] indexed
  by rte_flow_item_type. Each entry declares the item's mask,
  fields[], field_offset[], field_size[], its parser protocol id,
  tunnel protocol id and the two callbacks (normal and tunnel).
  New callbacks cover eth, vlan, ipv4, ipv6, icmp, udp, tcp, esp,
  ah, sctp, gre, gtp, vxlan, ecpri, geneve and raw with shared
  logic in dpaa2_flow_general_extract_rule_set() and the
  _tunnel_* variants; eCPRI uses the parser decode helpers.
- IPv4 fragment is matched by setting the IP-frag FAF rather than
  the open-coded fragment_offset extract.

Table and action handling:

- dpaa2_flow_qos_table_config() / dpaa2_flow_tc_table_config()
  (re)program dpkg, set/clear RSS, write default (drop / jump /
  queue) action, and re-add existing rules via
  dpaa2_flow_add_all_steering_rule(). Default actions are gated
  on MC rev via DPAA2_QOS_FLOW_TABLE_SET_V3_MC_REV and
  DPAA2_QOS_FLOW_TABLE_MISS_FLOW_ACTION_MC_REV.
- dpaa2_flow_add_steering_rule() handles add vs update
  (DPNI_FS_OPT_UPDATE_IF_EXISTS / DPNI_QOS_OPT_UPDATE_IF_EXISTS)
  and uses dpni_add_fs_entry_legacy for MC revs before
  DPAA2_FLOW_FRM_REPLICATION_ACTION_MC_REV.
- Actions are converted uniformly in
  dpaa2_flow_action_rxq_convert() (QUEUE),
  dpaa2_flow_action_tx_port_convert() (PORT_ID /
  REPRESENTED_PORT, with multi-redirect via
  DPNI_FS_OPT_REDIRECT_TO_MULTIPLE_DPNI_TX gated on
  DPNI_OPT_V8_HAS_REPLICATION), DROP (DPNI_FS_OPT_DISCARD) and
  JUMP (sets flow->tc_id). FS actions carry a dst_name[] array
  for logging.

New flow APIs and group types:

- Add RTE_DPAA2_FLAT_GROUP_FLOW / RTE_DPAA2_QOS_GROUP_FLOW /
  RTE_DPAA2_FS_GROUP_FLOW and the macros
  RTE_DPAA2_FLOW_GROUP_TYPE_SET /
  RTE_DPAA2_FLOW_GROUP_TYPE_GET /
  RTE_DPAA2_FLOW_GROUP_ID_GET so that callers can request a
  QoS-only or FS-only rule inside the standard rte_flow API by
  encoding the type in the high bits of attr->group.
- Expose rte_dpaa2_flow_create() wrapper and
  rte_dpaa2_flow_group_set_miss_actions() so apps can set
  per-group default (drop / jump / queue) actions via
  rte_flow_group_set_miss_actions().
  Expose rte_dpaa2_flow_validate() wrapper for apps to validate
  before calling rte_dpaa2_flow_create().
- dpaa2_flow_create() now:
  - RSS-only when actions[0]==RSS,
  - QoS-only when the port is QoS-only or group type is
    RTE_DPAA2_QOS_GROUP_FLOW or the action is JUMP,
  - otherwise programs a QoS entry (synthesized JUMP to the FS
    TC) plus an FS entry, so one user flow transparently covers
    QoS->FS redirection on multi-TC devices.
- Implement flow actions_update by walking the three
  sub-flows and calling dpaa2_flow_steering_flow_action_update()
  / dpaa2_flow_rss_action_update() as appropriate.
- Implement group_set_miss_actions() backed by
  dpaa2_flow_qos_table_set_default() /
  dpaa2_flow_fs_table_set_default() with full validation of
  the (drop / jump / queue) combination.
- Replace the stub dpaa2_flow_query() with a dpni_dump_table()
  based implementation that locates the user flow's QoS and FS
  entries by matching key/mask against the HW dump.
- Add rte_pmd_dpaa2_flow_table_query() experimental API that
  dumps every QoS and FS entry currently programmed in HW and
  cross-checks it against the PMD's software flow list.
- dpaa2_flow_clean() now takes (tc_id, type) and selectively
  removes QoS-only, FS-only or RSS-only rules of a given TC, so
  that creating an FS rule in a TC automatically evicts a stale
  RSS rule in the same TC and vice versa.

Dynamic reconfiguration and validation:

- dpaa2_flow_remove_invalid_extract() walks the current extract
  set, drops extracts no longer referenced by any rule
  (including the IP-address pair and L4 port pair), shrinks each
  rule's key/mask buffer accordingly, recomputes key_max_size
  and ip_addr sizes based on each rule's ip_key (IPv4 vs IPv6),
  and triggers a table re-program via dpaa2_flow_table_update().
  This runs on every flow destroy so the HW table stays as small
  as possible.
- dpaa2_flow_verify_patterns(), dpaa2_flow_verify_flow_action(),
  dpaa2_flow_verify_steering_attr() and
  dpaa2_flow_check_actions_support() are reorganized around the
  split dpaa2_supported_fs_action_type /
  dpaa2_supported_qos_action_type arrays (FS now explicitly adds
  DROP; QoS adds JUMP) and the new group-type encoding.

Debug/log:

- Add DPAA2_FLOW_DUMP() going to stderr (independent of rte_log
  so multi-line dumps are not interleaved), controlled by env
  DPAA2_FLOW_CONTROL_LOG. Replace the old
  dpaa2_flow_qos_extracts_log / dpaa2_flow_fs_extracts_log /
  dpaa2_flow_qos_entry_log / dpaa2_flow_fs_entry_log quartet
  with a shared dpaa2_flow_extracts_log(),
  dpaa2_flow_steering_entry_log() and dpaa2_dump_extract_map()
  that work for QoS and FS uniformly and also decode the chosen
  action (receive to flow / redirect to port(s) / drop / jump).
- Replace the hand-rolled dpaa2_prot_field_string() if/else chain
  with a static descriptor table dpaa2_hw_prot_field_support[]
  covering eth, vlan, ip, tcp, udp, sctp, icmp, gre, gtp, esp
  and ah, and add dpaa2_dump_dpkg() for human-readable extract
  dumps.

Init / close (dpaa2_ethdev.c):

- dpaa2_dev_init() now allocates extract_param and entry_map for
  every tbl_profile (QoS + MAX_TCS FS tables), stamps the
  default drop/jump/queue destinations, and primes
  tc_cfg.dist_size / key_cfg_iova per TC.
- dpaa2_dev_close() frees the per-table extract_param and
  entry_map and calls dpaa2_flow_clean(dev, MAX_TCS,
  DPAA2_FLOW_ALL_TYPE) to tear down all flows.

Parser decode (dpaa2_parser_decode.h):

- Add DPAA2_PARSER_NULL_ID so dispatch-table slots for items that
  have no corresponding FAF (eCPRI/VXLAN inner, raw) can be
  tagged explicitly instead of leaving a magic 0.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 doc/guides/nics/dpaa2.rst               |    8 +
 drivers/net/dpaa2/dpaa2_ethdev.c        |   96 +-
 drivers/net/dpaa2/dpaa2_ethdev.h        |  583 +-
 drivers/net/dpaa2/dpaa2_flow.c          | 8107 ++++++++++-------------
 drivers/net/dpaa2/dpaa2_parser_decode.h |    9 +
 drivers/net/dpaa2/rte_pmd_dpaa2.h       |   59 +
 6 files changed, 4209 insertions(+), 4653 deletions(-)

diff --git a/doc/guides/nics/dpaa2.rst b/doc/guides/nics/dpaa2.rst
index 4480a5f652..6c67a76f12 100644
--- a/doc/guides/nics/dpaa2.rst
+++ b/doc/guides/nics/dpaa2.rst
@@ -495,6 +495,14 @@ Refer to the document :doc:`build_and_test` for details.
   parser result of every received packet (debug only, hurts Rx performance).
   e.g. ``fslmc:dpni.1,drv_rx_print_parser_result=1``
 
+* Use dev arg option ``drv_qos_flow_only_steer=1`` to steer ingress traffic
+  using the QoS table only.
+  e.g. ``fslmc:dpni.1,drv_qos_flow_only_steer=1``
+
+* Use dev arg option ``drv_flow_api_debug=1`` to enable debug logs for the flow
+  create, destroy and update operations.
+  e.g. ``fslmc:dpni.1,drv_flow_api_debug=1``
+
 * Use dev arg option  ``drv_error_queue=1`` to enable Packets in Error queue.
   DPAA2 hardware drops the error packet in hardware. This option enables the
   hardware to not drop the error packet and let the driver dump the error
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 5dcdc6fa76..9ad4494ab0 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -81,6 +81,16 @@ dpaa2_dev_args_parser_offset_en(void *vdev,
 	priv->psr_dynfield_offset = ret | DPAA2_PSR_DYNFIELD_OFFSET_EN;
 }
 
+static void
+dpaa2_dev_args_qos_entries_per_tc(void *vdev,
+	const struct rte_kvargs_pair *pair)
+{
+	struct rte_eth_dev *dev = vdev;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+
+	priv->qos_entries_per_tc = atoi(pair->value);
+}
+
 /* Single source of truth for dpaa2 devargs:
  *   ENTRY(key-string, handle, flag-bit)
  * handle is an optional per-arg callback (NULL if the arg only sets a flag).
@@ -98,7 +108,11 @@ dpaa2_dev_args_parser_offset_en(void *vdev,
 	ENTRY("drv_err_queue", NULL, DPAA2_RX_ERROR_QUEUE_FLAG) \
 	ENTRY("drv_no_taildrop", NULL, DPAA2_RX_TAILDROP_OFF) \
 	ENTRY("drv_no_data_stashing", NULL, DPAA2_RX_DATA_STASHING_OFF_FLAG) \
-	ENTRY("drv_parse_protocol_offset", dpaa2_dev_args_parser_offset_en, 0)
+	ENTRY("drv_parse_protocol_offset", dpaa2_dev_args_parser_offset_en, 0) \
+	ENTRY("drv_qos_entries_per_tc", dpaa2_dev_args_qos_entries_per_tc, \
+		DPAA2_QOS_ENTRIES_PER_TC_FLAG) \
+	ENTRY("drv_qos_flow_only_steer", NULL, DPAA2_QOS_FLOW_ONLY_STEER_FLAG) \
+	ENTRY("drv_flow_api_debug", NULL, DPAA2_FLOW_API_DEBUG_FLAG)
 
 #define CHECK_INTERVAL         100  /* 100ms */
 #define MAX_REPEAT_TIME        90   /* 9s (90 * 100ms) in total */
@@ -1833,6 +1847,7 @@ dpaa2_dev_close(struct rte_eth_dev *dev)
 	struct fsl_mc_io *dpni = dev->process_private;
 	int i, ret;
 	struct rte_eth_link link;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -1845,7 +1860,7 @@ dpaa2_dev_close(struct rte_eth_dev *dev)
 	}
 
 	dpaa2_tm_deinit(dev);
-	dpaa2_flow_clean(dev);
+	dpaa2_flow_clean(dev, MAX_TCS, DPAA2_FLOW_ALL_TYPE);
 	/* Clean the device first */
 	ret = dpni_reset(dpni, CMD_PRI_LOW, priv->token);
 	if (ret) {
@@ -1869,20 +1884,24 @@ dpaa2_dev_close(struct rte_eth_dev *dev)
 	}
 	/* Close the device at underlying layer*/
 	ret = dpni_close(dpni, CMD_PRI_LOW, priv->token);
-	if (ret) {
-		DPAA2_PMD_ERR("Failure closing dpni device with err code %d",
-			ret);
-	}
+	if (ret)
+		DPAA2_PMD_ERR("Failure closing dpni device with err code %d", ret);
 
 	/* Free the allocated memory for ethernet private data and dpni*/
 	priv->hw = NULL;
 	dev->process_private = NULL;
 	rte_free(dpni);
 
-	for (i = 0; i < MAX_TCS; i++)
-		rte_free(priv->extract.tc_extract_param[i]);
-
-	rte_free(priv->extract.qos_extract_param);
+	for (i = 0; i < (MAX_TCS + 1); i++) {
+		if (i < MAX_TCS)
+			tbl_profile = &priv->flow_profile.tc_profile[i];
+		else
+			tbl_profile = &priv->flow_profile.qos_profile;
+		rte_free(tbl_profile->extract_param);
+		tbl_profile->extract_param = NULL;
+		rte_free(tbl_profile->entry_map);
+		tbl_profile->entry_map = NULL;
+	}
 
 	rte_free(priv->cnt_idx_dma_mem);
 	rte_free(priv->cnt_values_dma_mem);
@@ -3555,8 +3574,10 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	struct dpni_attr attr;
 	struct dpaa2_dev_priv *priv = eth_dev->data->dev_private;
 	struct dpni_buffer_layout layout;
-	int ret, hw_id, i;
+	int ret, hw_id, i, entry_num;
 	uint16_t num_q_per_tc, max_q_per_tc;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
+	uint64_t iova;
 
 	PMD_INIT_FUNC_TRACE();
 
@@ -3635,6 +3656,11 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	priv->channel_inuse = 0;
 	rte_spinlock_init(&priv->lpbk_qp_lock);
 
+	if (priv->qos_entries_per_tc * priv->num_rx_tc > priv->qos_entries) {
+		DPAA2_PMD_WARN("QoS entries per TC(%d) x tc num(%d) > total entries(%d)",
+			priv->qos_entries_per_tc, priv->num_rx_tc, priv->qos_entries);
+	}
+
 	/* only if the custom CG is enabled */
 	if (attr.options & DPNI_OPT_CUSTOM_CG) {
 		priv->max_cgs = attr.num_cgs;
@@ -3754,26 +3780,42 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	}
 
 	/* Init fields w.r.t. classification */
-	memset(&priv->extract.qos_key_extract, 0,
-		sizeof(struct dpaa2_key_extract));
-	priv->extract.qos_extract_param = rte_zmalloc(NULL,
-		DPAA2_EXTRACT_PARAM_MAX_SIZE,
-		RTE_CACHE_LINE_SIZE);
-	if (!priv->extract.qos_extract_param) {
-		DPAA2_PMD_ERR("Memory alloc failed");
-		goto init_err;
-	}
-
-	for (i = 0; i < MAX_TCS; i++) {
-		memset(&priv->extract.tc_key_extract[i], 0,
-			sizeof(struct dpaa2_key_extract));
-		priv->extract.tc_extract_param[i] = rte_zmalloc(NULL,
+	for (i = 0; i < (MAX_TCS + 1); i++) {
+		if (i < MAX_TCS) {
+			tbl_profile = &priv->flow_profile.tc_profile[i];
+			entry_num = priv->fs_entries;
+		} else {
+			tbl_profile = &priv->flow_profile.qos_profile;
+			entry_num = priv->qos_entries;
+		}
+		memset(tbl_profile, 0, sizeof(struct dpaa2_flow_tbl_profile));
+		tbl_profile->extract_param = rte_zmalloc(NULL,
 			DPAA2_EXTRACT_PARAM_MAX_SIZE,
 			RTE_CACHE_LINE_SIZE);
-		if (!priv->extract.tc_extract_param[i]) {
-			DPAA2_PMD_ERR("Memory alloc failed");
+		if (!tbl_profile->extract_param)
 			goto init_err;
+		iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(tbl_profile->extract_param,
+			DPAA2_EXTRACT_PARAM_MAX_SIZE);
+		tbl_profile->default_drop = false;
+		if (i < MAX_TCS) {
+			tbl_profile->tc_cfg.dist_size = priv->dist_queues;
+			tbl_profile->tc_cfg.key_cfg_iova = iova;
+			tbl_profile->tc_cfg.tc = i;
+			/** First flow of TC as default flow, otherwise, may be dropped.*/
+			tbl_profile->default_queue.index = priv->dist_queues * i;
+		} else {
+			tbl_profile->qos_cfg.key_cfg_iova = iova;
+			tbl_profile->qos_cfg.keep_entries = true;
+			/** First TC as default TC, otherwise, may be dropped.*/
+			tbl_profile->default_jump.group = 0;
 		}
+		if (!entry_num)
+			continue;
+
+		tbl_profile->entry_map = rte_zmalloc(NULL, entry_num / 8 + 1, 0);
+		if (!tbl_profile->entry_map)
+			goto init_err;
+		tbl_profile->entry_map_size = entry_num / 8 + 1;
 	}
 
 	ret = dpni_set_max_frame_length(dpni_dev, CMD_PRI_LOW, priv->token,
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index e2d9d5de36..e3fb3f8920 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -109,6 +109,12 @@
 
 #define DPAA2_IEEE1588_RX_TS_FLAG RTE_BIT32(13)
 
+#define DPAA2_QOS_ENTRIES_PER_TC_FLAG RTE_BIT32(14)
+
+#define DPAA2_QOS_FLOW_ONLY_STEER_FLAG RTE_BIT32(15)
+
+#define DPAA2_FLOW_API_DEBUG_FLAG RTE_BIT32(16)
+
 /* DPDMUX index for DPMAC */
 #define DPAA2_DPDMUX_DPMAC_IDX 0
 
@@ -206,6 +212,7 @@
 
 #define DPAA2_FLOW_FRM_REPLICATION_ACTION_MC_REV RTE_FSL_MC_REV(10, 39, 106)
 #define DPAA2_QOS_FLOW_TABLE_SET_V3_MC_REV RTE_FSL_MC_REV(10, 39, 109)
+#define DPAA2_QOS_FLOW_TABLE_MISS_FLOW_ACTION_MC_REV RTE_FSL_MC_REV(10, 39, 109)
 #define DPAA2_MAC_XSTATS_MC_REV RTE_FSL_MC_REV(10, 39, 109)
 
 /* mac counters */
@@ -256,124 +263,15 @@ struct dpaa2_dyn_rx_protocol_pos {
 #define DPAA2_FS_FLC_FLOW_OFFSET \
 	(DPAA2_FS_FLC_TC_OFFSET + DPAA2_FS_FLC_TC_BIT_SIZE)
 
-#define DPAA2_FAPR_SIZE \
-	(sizeof(struct dpaa2_annot_hdr) - \
-	offsetof(struct dpaa2_annot_hdr, word3))
-
-#define DPAA2_PR_NXTHDR_OFFSET 0
-
-#define DPAA2_FAFE_PSR_OFFSET 2
-#define DPAA2_FAFE_PSR_SIZE 2
-
-#define DPAA2_FAF_PSR_OFFSET 4
-#define DPAA2_FAF_PSR_SIZE 12
-
-#define DPAA2_FAF_TOTAL_SIZE \
-	(DPAA2_FAFE_PSR_SIZE + DPAA2_FAF_PSR_SIZE)
-
-/* Just most popular Frame attribute flags (FAF) here.*/
-enum dpaa2_rx_faf_offset {
-	/* Set by SP start*/
-	FAFE_VXLAN_IN_VLAN_FRAM = 0,
-	FAFE_VXLAN_IN_IPV4_FRAM = 1,
-	FAFE_VXLAN_IN_IPV6_FRAM = 2,
-	FAFE_VXLAN_IN_UDP_FRAM = 3,
-	FAFE_VXLAN_IN_TCP_FRAM = 4,
-
-	FAFE_ECPRI_FRAM = 7,
-	/* Set by SP end*/
-
-	FAF_GTP_PRIMED_FRAM = 1 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_PTP_FRAM = 3 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_VXLAN_FRAM = 4 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_ETH_FRAM = 10 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_LLC_SNAP_FRAM = 18 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_VLAN_FRAM = 21 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_PPPOE_PPP_FRAM = 25 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_MPLS_FRAM = 27 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_ARP_FRAM = 30 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_IPV4_FRAM = 34 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_IPV6_FRAM = 42 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_IP_FRAM = 48 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_IP_FRAG_FRAM = 50 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_ICMP_FRAM = 57 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_IGMP_FRAM = 58 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_GRE_FRAM = 65 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_UDP_FRAM = 70 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_TCP_FRAM = 72 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_IPSEC_FRAM = 77 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_IPSEC_ESP_FRAM = 78 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_IPSEC_AH_FRAM = 79 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_SCTP_FRAM = 81 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_DCCP_FRAM = 83 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_GTP_FRAM = 87 + DPAA2_FAFE_PSR_SIZE * 8,
-	FAF_ESP_FRAM = 89 + DPAA2_FAFE_PSR_SIZE * 8,
-};
-
-enum dpaa2_ecpri_fafe_type {
-	ECPRI_FAFE_TYPE_0 = (8 - FAFE_ECPRI_FRAM),
-	ECPRI_FAFE_TYPE_1 = (8 - FAFE_ECPRI_FRAM) | (1 << 1),
-	ECPRI_FAFE_TYPE_2 = (8 - FAFE_ECPRI_FRAM) | (2 << 1),
-	ECPRI_FAFE_TYPE_3 = (8 - FAFE_ECPRI_FRAM) | (3 << 1),
-	ECPRI_FAFE_TYPE_4 = (8 - FAFE_ECPRI_FRAM) | (4 << 1),
-	ECPRI_FAFE_TYPE_5 = (8 - FAFE_ECPRI_FRAM) | (5 << 1),
-	ECPRI_FAFE_TYPE_6 = (8 - FAFE_ECPRI_FRAM) | (6 << 1),
-	ECPRI_FAFE_TYPE_7 = (8 - FAFE_ECPRI_FRAM) | (7 << 1)
-};
-
-#define DPAA2_PR_ETH_OFF_OFFSET 19
-#define DPAA2_PR_TCI_OFF_OFFSET 21
-#define DPAA2_PR_LAST_ETYPE_OFFSET 23
-#define DPAA2_PR_L3_OFF_OFFSET 27
-#define DPAA2_PR_L4_OFF_OFFSET 30
-#define DPAA2_PR_L5_OFF_OFFSET 31
-#define DPAA2_PR_NXTHDR_OFF_OFFSET 34
-
 #define DPAA2_ECPRI_MAX_EXTRACT_NB 8
 
-struct ipv4_sd_addr_extract_rule {
-	uint32_t ipv4_src;
-	uint32_t ipv4_dst;
-};
-
-struct ipv6_sd_addr_extract_rule {
-	uint8_t ipv6_src[NH_FLD_IPV6_ADDR_SIZE];
-	uint8_t ipv6_dst[NH_FLD_IPV6_ADDR_SIZE];
-};
-
-struct ipv4_ds_addr_extract_rule {
-	uint32_t ipv4_dst;
-	uint32_t ipv4_src;
-};
-
-struct ipv6_ds_addr_extract_rule {
-	uint8_t ipv6_dst[NH_FLD_IPV6_ADDR_SIZE];
-	uint8_t ipv6_src[NH_FLD_IPV6_ADDR_SIZE];
-};
-
-union ip_addr_extract_rule {
-	struct ipv4_sd_addr_extract_rule ipv4_sd_addr;
-	struct ipv6_sd_addr_extract_rule ipv6_sd_addr;
-	struct ipv4_ds_addr_extract_rule ipv4_ds_addr;
-	struct ipv6_ds_addr_extract_rule ipv6_ds_addr;
-};
-
-union ip_src_addr_extract_rule {
-	uint32_t ipv4_src;
-	uint8_t ipv6_src[NH_FLD_IPV6_ADDR_SIZE];
-};
-
-union ip_dst_addr_extract_rule {
-	uint32_t ipv4_dst;
-	uint8_t ipv6_dst[NH_FLD_IPV6_ADDR_SIZE];
-};
-
-enum ip_addr_extract_type {
-	IP_NONE_ADDR_EXTRACT,
-	IP_SRC_EXTRACT,
-	IP_DST_EXTRACT,
-	IP_SRC_DST_EXTRACT,
-	IP_DST_SRC_EXTRACT
+enum dpaa2_flow_dist_type {
+	DPAA2_FLOW_NULL_TYPE = 0,
+	DPAA2_FLOW_QOS_TYPE = 1 << 0,
+	DPAA2_FLOW_FS_TYPE = 1 << 1,
+	DPAA2_FLOW_RSS_TYPE = 1 << 2,
+	DPAA2_FLOW_ALL_TYPE = (DPAA2_FLOW_QOS_TYPE | DPAA2_FLOW_FS_TYPE |
+		DPAA2_FLOW_RSS_TYPE)
 };
 
 enum key_prot_type {
@@ -389,47 +287,61 @@ struct key_prot_field {
 	enum key_prot_type type;
 	enum net_prot prot;
 	uint32_t key_field;
+	uint8_t key_offset;
+	uint8_t key_size;
+};
+
+struct dpaa2_ip_addr_extract {
+	uint32_t field;
+	uint8_t max_size;
+	uint8_t extract_idx;
 };
 
-struct dpaa2_raw_region {
-	uint8_t raw_start;
-	uint8_t raw_size;
+struct dpaa2_l4_port_extract {
+	uint8_t present;
+	uint8_t extract_idx;
+	uint8_t key_offset;
+};
+
+enum dpaa2_l4_port_type {
+	DPAA2_L4_SRC_PORT,
+	DPAA2_L4_DST_PORT,
+	DPAA2_L4_PORT_NUM
 };
 
 struct dpaa2_key_profile {
-	uint8_t num;
-	uint8_t key_offset[DPKG_MAX_NUM_OF_EXTRACTS];
-	uint8_t key_size[DPKG_MAX_NUM_OF_EXTRACTS];
-
-	enum ip_addr_extract_type ip_addr_type;
-	uint8_t ip_addr_extract_pos;
-	uint8_t ip_addr_extract_off;
-
-	uint8_t raw_extract_pos;
-	uint8_t raw_extract_off;
-	uint8_t raw_extract_num;
-
-	uint8_t l4_src_port_present;
-	uint8_t l4_src_port_pos;
-	uint8_t l4_src_port_offset;
-	uint8_t l4_dst_port_present;
-	uint8_t l4_dst_port_pos;
-	uint8_t l4_dst_port_offset;
+	struct dpkg_profile_cfg dpkg;
+	struct dpaa2_ip_addr_extract ip_addr[2];
+	struct dpaa2_l4_port_extract l4_port[DPAA2_L4_PORT_NUM];
+	uint8_t ip_addr_offset;
 	struct key_prot_field prot_field[DPKG_MAX_NUM_OF_EXTRACTS];
 	uint16_t key_max_size;
-	struct dpaa2_raw_region raw_region;
 };
 
-struct dpaa2_key_extract {
-	struct dpkg_profile_cfg dpkg;
+struct dpaa2_flow_tbl_profile {
 	struct dpaa2_key_profile key_profile;
+	uint8_t *extract_param;
+	uint16_t entry_num;
+	uint16_t entry_map_size;
+	uint8_t *entry_map;
+	int enabled;
+	void *rss_flow;
+	union {
+		struct dpni_qos_tbl_cfg qos_cfg;
+		struct dpni_rx_dist_cfg tc_cfg;
+	};
+	int default_drop;
+	union {
+		struct rte_flow_action_jump default_jump;
+		struct rte_flow_action_queue default_queue;
+	};
 };
 
-struct extract_s {
-	struct dpaa2_key_extract qos_key_extract;
-	struct dpaa2_key_extract tc_key_extract[MAX_TCS];
-	uint8_t *qos_extract_param;
-	uint8_t *tc_extract_param[MAX_TCS];
+struct dpaa2_flow_profile {
+	struct dpaa2_flow_tbl_profile qos_profile;
+	struct dpaa2_flow_tbl_profile tc_profile[MAX_TCS];
+	void *mempool[MAX_TCS];
+	uint8_t bp_idx[MAX_TCS];
 };
 
 enum dpaa2_tx_conf_type {
@@ -460,6 +372,20 @@ struct dpaa2_dev_priv {
 	uint8_t num_rx_tc;
 	uint8_t num_tx_tc;
 	uint16_t qos_entries;
+	/* Number of QoS table entries allocated per RX traffic class (TC).
+	 * This field can be configured by devargs "drv_qos_entries_per_tc=x",
+	 * Recommend values:
+	 *   1) qos_entries / num_rx_tc
+	 *        Entries are split evenly across TCs. A QoS entry's priority
+	 *        is determined by the TC it directs traffic to.
+	 *   2) 0
+	 *        Priority is not tied to a TC; the user sets the priority of
+	 *        each QoS entry explicitly.
+	 *   3) fs_entries
+	 *        Enables a two-level table. The action of a QoS entry is to
+	 *        jump to the specified FS (flow-steering) table.
+	 */
+	uint16_t qos_entries_per_tc;
 	uint16_t fs_entries;
 	uint8_t dist_queues;
 	uint8_t num_channels;
@@ -483,7 +409,7 @@ struct dpaa2_dev_priv {
 	uint16_t ep_object_id;                 /**< Endpoint DPAA2 Object ID */
 	char ep_name[RTE_DEV_NAME_MAX_LEN];
 
-	struct extract_s extract;
+	struct dpaa2_flow_profile flow_profile;
 
 	uint16_t ss_offset;
 	uint64_t ss_iova;
@@ -522,7 +448,6 @@ struct dpaa2_dev_priv {
 	 */
 	union dpni_statistics pg_xstats[DPNI_MAX_STATISTICS_PAGE_ID][DPNI_STAT_MAX_PARAM];
 
-	struct dpaa2_dev_flow *curr;
 	LIST_HEAD(, dpaa2_dev_flow) flows;
 	LIST_HEAD(nodes, dpaa2_tm_node) nodes;
 	LIST_HEAD(shaper_profiles, dpaa2_tm_shaper_profile) shaper_profiles;
@@ -590,6 +515,367 @@ dpaa2_timestamp_debug(struct dpaa2_dev_priv *priv,
 		prefix, timestamp, (int64_t)ts.tv_sec, (int64_t)ts.tv_nsec);
 }
 
+#define DPAA2_FLOW_DUMP dpaa2_dump_print
+
+#define DPAA2_PROT_FIELD_MAX_NUM 10
+struct dpaa2_prot_field_desc {
+	uint32_t prot;
+	const char *prot_nm;
+	uint8_t field_num;
+	uint32_t field[DPAA2_PROT_FIELD_MAX_NUM];
+	const char *field_nm[DPAA2_PROT_FIELD_MAX_NUM];
+};
+
+static inline uint32_t
+dpaa2_prot_field_string(uint32_t prot, uint32_t field, char *string)
+{
+	uint32_t i = 0, j = 0, offset;
+	const struct dpaa2_prot_field_desc dpaa2_hw_prot_field_support[] = {
+		{
+			NET_PROT_ETH, "eth", 3,
+			.field = {NH_FLD_ETH_DA, NH_FLD_ETH_SA, NH_FLD_ETH_TYPE},
+			.field_nm = {"dst", "src", "type"}
+		},
+		{
+			NET_PROT_VLAN, "vlan", 1,
+			.field = {NH_FLD_VLAN_TCI},
+			.field_nm = {"tci"}
+		},
+		{
+			NET_PROT_IP, "ip", 3,
+			.field = {NH_FLD_IP_DST, NH_FLD_IP_SRC, NH_FLD_IP_PROTO},
+			.field_nm = {"dst", "src", "protocol"}
+		},
+		{
+			NET_PROT_TCP, "tcp", 2,
+			.field = {NH_FLD_TCP_PORT_DST, NH_FLD_TCP_PORT_SRC},
+			.field_nm = {"dst", "src"}
+		},
+		{
+			NET_PROT_UDP, "udp", 2,
+			.field = {NH_FLD_UDP_PORT_DST, NH_FLD_UDP_PORT_SRC},
+			.field_nm = {"dst", "src"}
+		},
+		{
+			NET_PROT_SCTP, "sctp", 2,
+			.field = {NH_FLD_SCTP_PORT_DST, NH_FLD_SCTP_PORT_SRC},
+			.field_nm = {"dst", "src"}
+		},
+		{
+			NET_PROT_ICMP, "icmp", 2,
+			.field = {NH_FLD_ICMP_TYPE, NH_FLD_ICMP_CODE},
+			.field_nm = {"type", "code"}
+		},
+		{
+			NET_PROT_GRE, "gre", 1,
+			.field = {NH_FLD_GRE_TYPE},
+			.field_nm = {"type"}
+		},
+		{
+			NET_PROT_GTP, "gtp", 1,
+			.field = {NH_FLD_GTP_TEID},
+			.field_nm = {"teid"}
+		},
+		{
+			NET_PROT_IPSEC_ESP, "esp", 2,
+			.field = {NH_FLD_IPSEC_ESP_SPI, NH_FLD_IPSEC_ESP_SEQUENCE_NUM},
+			.field_nm = {"spi", "seq"}
+		},
+		{
+			NET_PROT_IPSEC_AH, "esp", 1,
+			.field = {NH_FLD_IPSEC_AH_SPI},
+			.field_nm = {"spi"}
+		}
+	};
+
+	for (i = 0; i < RTE_DIM(dpaa2_hw_prot_field_support); i++) {
+		if (prot != dpaa2_hw_prot_field_support[i].prot)
+			continue;
+		for (j = 0; j < dpaa2_hw_prot_field_support[i].field_num; j++) {
+			if (field == dpaa2_hw_prot_field_support[i].field[j])
+				break;
+		}
+		break;
+	}
+
+	if (i == RTE_DIM(dpaa2_hw_prot_field_support))
+		return sprintf(string, "unknown protocol(%d)", prot);
+
+	offset = sprintf(string, "%s.", dpaa2_hw_prot_field_support[i].prot_nm);
+	if (j == dpaa2_hw_prot_field_support[i].field_num) {
+		offset += sprintf(&string[offset], "unknown field(%d)",
+			field);
+	} else {
+		offset += sprintf(&string[offset], "%s",
+			dpaa2_hw_prot_field_support[i].field_nm[j]);
+	}
+	return offset;
+}
+
+static inline void
+dpaa2_dump_dpkg(const struct dpkg_profile_cfg *dpkg)
+{
+	int idx;
+	char string[1024];
+	const struct dpkg_extract *extract;
+	enum dpkg_extract_type type;
+	enum net_prot prot;
+	uint32_t field;
+
+	for (idx = 0; idx < dpkg->num_extracts; idx++) {
+		extract = &dpkg->extracts[idx];
+		type = extract->type;
+		if (type == DPKG_EXTRACT_FROM_HDR) {
+			prot = extract->extract.from_hdr.prot;
+			field = extract->extract.from_hdr.field;
+			dpaa2_prot_field_string(prot, field, string);
+			DPAA2_FLOW_DUMP("%s", string);
+		} else if (type == DPKG_EXTRACT_FROM_DATA) {
+			DPAA2_FLOW_DUMP("raw offset/len: %d/%d",
+				extract->extract.from_data.offset,
+				extract->extract.from_data.size);
+		} else if (type == DPKG_EXTRACT_FROM_PARSE) {
+			DPAA2_FLOW_DUMP("parse offset/len: %d/%d",
+				extract->extract.from_parse.offset,
+				extract->extract.from_parse.size);
+		}
+		if ((idx + 1) < dpkg->num_extracts)
+			DPAA2_FLOW_DUMP(" / ");
+	}
+	DPAA2_FLOW_DUMP("\n");
+}
+
+static inline int
+dpaa2_extract_last_none_ip_addr_idx(const struct dpaa2_key_profile *profile)
+{
+	if (!profile->dpkg.num_extracts)
+		return -ENXIO;
+	if (profile->ip_addr[0].field)
+		return (int)profile->ip_addr[0].extract_idx - 1;
+	return profile->dpkg.num_extracts - 1;
+}
+
+static inline int
+dpaa2_extract_ip_convert(enum net_prot *prot, uint32_t *field)
+{
+	if (*prot == NET_PROT_IPV4) {
+		if (*field != NH_FLD_IPV4_SRC_IP && *field != NH_FLD_IPV4_DST_IP)
+			return -EINVAL;
+
+		*prot = NET_PROT_IP;
+		*field = *field == NH_FLD_IPV4_SRC_IP ? NH_FLD_IP_SRC : NH_FLD_IP_DST;
+	} else if (*prot == NET_PROT_IPV6) {
+		if (*field != NH_FLD_IPV6_SRC_IP &&
+			*field != NH_FLD_IPV6_DST_IP)
+			return -EINVAL;
+
+		*prot = NET_PROT_IP;
+		*field = *field == NH_FLD_IPV4_SRC_IP ? NH_FLD_IP_SRC : NH_FLD_IP_DST;
+	} else if (*prot == NET_PROT_IP) {
+		if (*field != NH_FLD_IP_SRC && *field != NH_FLD_IP_DST)
+			return -EINVAL;
+	} else {
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static inline uint8_t
+dpaa2_extract_ip_addr_size(const struct dpaa2_ip_addr_extract *ip_addr)
+{
+	uint8_t i, ip_addr_size = 0;
+
+	for (i = 0; i < 2; i++) {
+		if (ip_addr[i].field)
+			ip_addr_size += ip_addr[i].max_size;
+	}
+
+	return ip_addr_size;
+}
+
+static inline int
+dpaa2_extract_ip_addr_add(struct dpaa2_key_profile *key_profile,
+	uint32_t field, uint8_t size, int *update, int last_nipa_idx)
+{
+	struct dpaa2_ip_addr_extract *ip_addr;
+	uint8_t i = 0;
+	char log_buf[128];
+
+	if (field != NH_FLD_IP_SRC && field != NH_FLD_IP_DST)
+		return -EINVAL;
+
+	ip_addr = key_profile->ip_addr;
+	key_profile->key_max_size -= dpaa2_extract_ip_addr_size(ip_addr);
+	while (i < 2) {
+		if (ip_addr[i].field == field) {
+			if (size > ip_addr[i].max_size)
+				ip_addr[i].max_size = size;
+			break;
+		}
+		if (!ip_addr[i].field) {
+			ip_addr[i].field = field;
+			ip_addr[i].max_size = size;
+			if (update)
+				*update = 1;
+			break;
+		}
+		i++;
+	}
+	if (i > 1) {
+		sprintf(log_buf,
+			"field[0](%d)/size[0](%d)/idx[0](%d)/field[1](%d)/size[1](%d)/idx[1](%d)",
+			ip_addr[0].field, ip_addr[0].max_size, ip_addr[1].extract_idx,
+			ip_addr[0].field, ip_addr[0].max_size, ip_addr[1].extract_idx);
+		fprintf(stderr, "Invalid IP address extracts:%s\n", log_buf);
+		return -EINVAL;
+	}
+	ip_addr[i].extract_idx = last_nipa_idx < 0 ? i : (last_nipa_idx + 1) + i;
+
+	key_profile->key_max_size += dpaa2_extract_ip_addr_size(ip_addr);
+
+	return i;
+}
+
+static inline int
+dpaa2_profile_insert_ipaddr_extract(struct dpaa2_key_profile *profile,
+	enum net_prot prot, uint32_t field, uint8_t *key_addr, uint8_t *mask_addr,
+	const void *key, const void *mask, int size, uint8_t *rule_size, int *recfg)
+{
+	int update = 0, ret, last_nipa_idx = 0, ip_idx;
+	struct key_prot_field *last_nipa_key = NULL;
+	uint8_t num;
+	uint8_t ip_addr_offset = 0;
+
+	ret = dpaa2_extract_ip_convert(&prot, &field);
+	if (ret) {
+		dpaa2_dump_print("Invalid IP protocol/field");
+		return -EINVAL;
+	}
+
+	num = profile->dpkg.num_extracts;
+
+	if (num >= DPKG_MAX_NUM_OF_EXTRACTS) {
+		dpaa2_dump_print("Number of extracts overflows");
+		return -EINVAL;
+	}
+
+	last_nipa_idx = dpaa2_extract_last_none_ip_addr_idx(profile);
+	if (last_nipa_idx >= 0) {
+		last_nipa_key = &profile->prot_field[last_nipa_idx];
+		ip_addr_offset = last_nipa_key->key_offset + last_nipa_key->key_size;
+	}
+
+	ip_idx = dpaa2_extract_ip_addr_add(profile, field, size, &update, last_nipa_idx);
+	if (ip_idx < 0) {
+		dpaa2_dump_print("Failed(%d) to add IP address extract", ip_idx);
+		return ip_idx;
+	}
+	if (ip_idx > 1) {
+		dpaa2_dump_print("Invalid IP address extract index(%d)", ip_idx);
+		return -EINVAL;
+	}
+	if (update) {
+		profile->prot_field[num].type = DPAA2_NET_PROT_KEY;
+		profile->prot_field[num].prot = prot;
+		profile->prot_field[num].key_field = field;
+
+		profile->dpkg.extracts[num].type = DPKG_EXTRACT_FROM_HDR;
+		profile->dpkg.extracts[num].extract.from_hdr.prot = prot;
+		profile->dpkg.extracts[num].extract.from_hdr.field = field;
+		profile->dpkg.extracts[num].extract.from_hdr.type = DPKG_FULL_FIELD;
+		profile->dpkg.num_extracts++;
+
+		if (recfg)
+			*recfg = true;
+	}
+
+	if (key_addr && mask_addr) {
+		key_addr += ip_addr_offset;
+		mask_addr += ip_addr_offset;
+		if (ip_idx > 0) {
+			key_addr += size;
+			mask_addr += size;
+		}
+		rte_memcpy(key_addr, key, size);
+		rte_memcpy(mask_addr, mask, size);
+	}
+	if (rule_size)
+		*rule_size = ip_addr_offset + size * (ip_idx + 1);
+
+	profile->ip_addr_offset = ip_addr_offset;
+
+	return 0;
+}
+
+static inline uint8_t
+dpaa2_profile_insert_no_ipaddr_extract(struct dpaa2_key_profile *profile,
+	uint8_t size, uint8_t *poffset, int *ppos, const struct key_prot_field *insert)
+{
+	uint8_t idx, ip_addr_num = 0, offset = 0xff;
+	struct key_prot_field *key = profile->prot_field;
+
+	if (profile->ip_addr[0].field && profile->ip_addr[1].field)
+		ip_addr_num = 2;
+	else if (profile->ip_addr[0].field)
+		ip_addr_num = 1;
+
+	idx = profile->dpkg.num_extracts - ip_addr_num;
+
+	if (ip_addr_num && idx > 0)
+		offset = key[idx - 1].key_offset + key[idx - 1].key_size;
+	else if (ip_addr_num)
+		offset = 0;
+
+	if (idx > 0)
+		key[idx].key_offset = key[idx - 1].key_offset + key[idx - 1].key_size;
+	else
+		key[idx].key_offset = 0;
+	if (ppos)
+		*ppos = key[idx].key_offset;
+	key[idx].key_size = size;
+	profile->key_max_size += size;
+
+	memmove(&key[idx + 1], &key[idx], sizeof(struct key_prot_field) * ip_addr_num);
+
+	if (poffset)
+		*poffset = offset;
+
+	if (insert) {
+		key[idx].type = insert->type;
+		key[idx].prot = insert->prot;
+		key[idx].key_field = insert->key_field;
+	}
+
+	if (ip_addr_num) {
+		if (profile->ip_addr[0].field)
+			profile->ip_addr[0].extract_idx++;
+		if (profile->ip_addr[1].field)
+			profile->ip_addr[1].extract_idx++;
+		profile->ip_addr_offset += size;
+	}
+
+	return idx;
+}
+
+static inline void
+dpaa2_dpkg_insert_extract(struct dpkg_profile_cfg *kg_cfg,
+	int idx, const struct dpkg_extract *extract)
+{
+	int i;
+
+	if (idx != kg_cfg->num_extracts) {
+		/* Not the last extract index, must have IP address extract.*/
+		for (i = kg_cfg->num_extracts - 1; i >= idx; i--) {
+			rte_memcpy(&kg_cfg->extracts[i + 1],
+				&kg_cfg->extracts[i], sizeof(struct dpkg_extract));
+		}
+	}
+
+	rte_memcpy(&kg_cfg->extracts[idx], extract, sizeof(struct dpkg_extract));
+	kg_cfg->num_extracts++;
+}
+
 int dpaa2_distset_to_dpkg_profile_cfg(uint64_t req_dist_set,
 				      struct dpkg_profile_cfg *kg_cfg);
 
@@ -649,7 +935,8 @@ uint16_t dpaa2_dev_tx_multi_txq_ordered(void **queue,
 		struct rte_mbuf **bufs, uint16_t nb_pkts);
 
 void dpaa2_dev_free_eqresp_buf(uint16_t eqresp_ci, struct dpaa2_queue *dpaa2_q);
-void dpaa2_flow_clean(struct rte_eth_dev *dev);
+void dpaa2_flow_clean(struct rte_eth_dev *dev, uint8_t tc_id,
+	enum dpaa2_flow_dist_type type);
 uint16_t dpaa2_dev_tx_conf(void *txq, int drain);
 
 void
diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index 72958c0f93..a22af4f33b 100644
--- a/drivers/net/dpaa2/dpaa2_flow.c
+++ b/drivers/net/dpaa2/dpaa2_flow.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2018-2026 NXP
+ * Copyright 2018-2022, 2026 NXP
  */
 
 #include <sys/queue.h>
@@ -16,6 +16,7 @@
 #include <rte_flow_driver.h>
 #include <rte_tailq.h>
 
+#include <eal_export.h>
 #include <fsl_dpni.h>
 #include <fsl_dpkg.h>
 
@@ -23,46 +24,53 @@
 #include <dpaa2_pmd_logs.h>
 #include "dpaa2_parser_decode.h"
 
-static char *dpaa2_flow_control_log;
-
 /* Default size of a key */
-#define DPNI_DEFAULT_KEY_SIZE 24
+#define DPNI_DEFAULT_KEY_SIZE                   24
 
 enum dpaa2_flow_entry_size {
 	DPAA2_FLOW_ENTRY_MIN_SIZE = DPNI_DEFAULT_KEY_SIZE,
 	DPAA2_FLOW_ENTRY_MAX_SIZE = DPNI_MAX_KEY_SIZE
 };
 
-enum dpaa2_flow_dist_type {
-	DPAA2_FLOW_QOS_TYPE = 1 << 0,
-	DPAA2_FLOW_FS_TYPE = 1 << 1
-};
-
 #define DPAA2_FLOW_RAW_OFFSET_FIELD_SHIFT	16
 #define DPAA2_FLOW_MAX_KEY_SIZE			16
-#define DPAA2_PROT_FIELD_STRING_SIZE		16
+
 #define VXLAN_HF_VNI 0x08
+#define DPAA2_MAX_ACTION_PER_FLOW_NUM 4
+
+struct dpaa2_dev_fs_action {
+	struct dpni_fs_action_cfg action_cfg;
+	char dst_name[DPNI_FS_REDIR_MAX_NUM][RTE_ETH_NAME_MAX_LEN];
+};
+
+struct dpaa2_generic_flow {
+	enum dpaa2_flow_dist_type type;
+	struct dpni_rule_cfg rule_cfg;
+	uint8_t *key_addr;
+	uint8_t *mask_addr;
+	uint8_t rule_size;
+	uint16_t entry_index;
+	/** This flow has IPv4 or IPv6 extracts.*/
+	enum net_prot ip_key;
+	/** This flow has IPv4 or IPv6 source extract.*/
+	enum net_prot ip_src;
+	/** This flow has IPv4 or IPv6 destination extract.*/
+	enum net_prot ip_dst;
+	struct dpaa2_dev_priv *priv;
+	uint8_t tc_id;
+	enum rte_flow_action_type action_type;
+	struct dpaa2_dev_fs_action fs_action;
+};
 
 struct dpaa2_dev_flow {
 	LIST_ENTRY(dpaa2_dev_flow) next;
-	struct dpni_rule_cfg qos_rule;
-	uint8_t *qos_key_addr;
-	uint8_t *qos_mask_addr;
-	uint16_t qos_rule_size;
-	struct dpni_rule_cfg fs_rule;
-	uint8_t qos_real_key_size;
-	uint8_t fs_real_key_size;
-	uint8_t *fs_key_addr;
-	uint8_t *fs_mask_addr;
-	uint16_t fs_rule_size;
-	uint8_t tc_id; /** Traffic Class ID. */
-	uint8_t tc_index; /** index within this Traffic Class. */
-	enum rte_flow_action_type action_type;
-	struct dpni_fs_action_cfg fs_action_cfg;
+	struct dpaa2_generic_flow *qos_flow;
+	struct dpaa2_generic_flow *fs_flow;
+	struct dpaa2_generic_flow *rss_flow;
 };
 
-struct rte_dpaa2_flow_item {
-	struct rte_flow_item generic_item;
+struct dpaa2_flow_item {
+	struct rte_flow_item item;
 	int in_tunnel;
 };
 
@@ -81,48 +89,80 @@ enum rte_flow_item_type dpaa2_hp_supported_pattern_type[] = {
 	RTE_FLOW_ITEM_TYPE_GTP,
 	RTE_FLOW_ITEM_TYPE_ESP,
 	RTE_FLOW_ITEM_TYPE_AH,
+	RTE_FLOW_ITEM_TYPE_RAW,
 	RTE_FLOW_ITEM_TYPE_MPLS,
 	RTE_FLOW_ITEM_TYPE_PPPOES,
-	RTE_FLOW_ITEM_TYPE_RAW
+	/** Hardware parser supports vlan protocol only.*/
+	RTE_FLOW_ITEM_TYPE_VXLAN
 };
 
 static const
 enum rte_flow_item_type dpaa2_sp_supported_pattern_type[] = {
-	RTE_FLOW_ITEM_TYPE_VXLAN,
-	RTE_FLOW_ITEM_TYPE_ECPRI
+	RTE_FLOW_ITEM_TYPE_ECPRI,
+	RTE_FLOW_ITEM_TYPE_GENEVE
 };
 
-static const
-enum rte_flow_action_type dpaa2_supported_action_type[] = {
-	RTE_FLOW_ACTION_TYPE_END,
-	RTE_FLOW_ACTION_TYPE_QUEUE,
-	RTE_FLOW_ACTION_TYPE_PORT_ID,
-	RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT,
-	RTE_FLOW_ACTION_TYPE_RSS,
+#define DPAA2_SUPPORTED_FLOW_ACTION_TYPE \
+	RTE_FLOW_ACTION_TYPE_QUEUE, \
+	RTE_FLOW_ACTION_TYPE_PORT_ID, \
+	RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT, \
+	RTE_FLOW_ACTION_TYPE_RSS, \
 	RTE_FLOW_ACTION_TYPE_DROP
+
+static const enum rte_flow_action_type dpaa2_supported_fs_action_type[] = {
+	DPAA2_SUPPORTED_FLOW_ACTION_TYPE
+};
+
+static const enum rte_flow_action_type dpaa2_supported_qos_action_type[] = {
+	DPAA2_SUPPORTED_FLOW_ACTION_TYPE,
+	RTE_FLOW_ACTION_TYPE_JUMP
 };
 
+#define DPAA2_FLOW_HDR_HEX_DUMP_SIZE \
+	(RTE_MAX(sizeof(struct rte_flow_item_eth), \
+	RTE_MAX(sizeof(struct rte_flow_item_vlan), \
+	RTE_MAX(sizeof(struct rte_flow_item_ipv4), \
+	RTE_MAX(sizeof(struct rte_flow_item_ipv6), \
+	RTE_MAX(sizeof(struct rte_flow_item_icmp), \
+	RTE_MAX(sizeof(struct rte_flow_item_udp), \
+	RTE_MAX(sizeof(struct rte_flow_item_tcp), \
+	RTE_MAX(sizeof(struct rte_flow_item_sctp), \
+	RTE_MAX(sizeof(struct rte_flow_item_gre), \
+	RTE_MAX(sizeof(struct rte_flow_item_ah), \
+	RTE_MAX(sizeof(struct rte_flow_item_esp), \
+	RTE_MAX(sizeof(struct rte_flow_item_vxlan), \
+	RTE_MAX(sizeof(struct rte_flow_item_ecpri), \
+	sizeof(struct rte_flow_item_gtp)))))))))))))) * 10)
+
 #ifndef __cplusplus
 static const struct rte_flow_item_eth dpaa2_flow_item_eth_mask = {
-	.hdr.dst_addr.addr_bytes = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff },
-	.hdr.src_addr.addr_bytes = { 0xff, 0xff, 0xff, 0xff, 0xff, 0xff },
-	.hdr.ether_type = RTE_BE16(0xffff),
+	.dst.addr_bytes = "\xff\xff\xff\xff\xff\xff",
+	.src.addr_bytes = "\xff\xff\xff\xff\xff\xff",
+	.type = RTE_BE16(0xffff),
 };
 
 static const struct rte_flow_item_vlan dpaa2_flow_item_vlan_mask = {
-	.hdr.vlan_tci = RTE_BE16(0xffff),
+	.tci = RTE_BE16(0xffff),
 };
 
 static const struct rte_flow_item_ipv4 dpaa2_flow_item_ipv4_mask = {
 	.hdr.src_addr = RTE_BE32(0xffffffff),
 	.hdr.dst_addr = RTE_BE32(0xffffffff),
 	.hdr.next_proto_id = 0xff,
+	.hdr.packet_id = 0xffff,
+	.hdr.fragment_offset = 0xffff,
 };
 
 static const struct rte_flow_item_ipv6 dpaa2_flow_item_ipv6_mask = {
 	.hdr = {
-		.src_addr = RTE_IPV6_MASK_FULL,
-		.dst_addr = RTE_IPV6_MASK_FULL,
+		.src_addr = {
+			"\xff\xff\xff\xff\xff\xff\xff\xff"
+			"\xff\xff\xff\xff\xff\xff\xff\xff"
+		},
+		.dst_addr = {
+			"\xff\xff\xff\xff\xff\xff\xff\xff"
+			"\xff\xff\xff\xff\xff\xff\xff\xff"
+		},
 		.proto = 0xff
 	},
 };
@@ -170,7 +210,12 @@ static const struct rte_flow_item_gre dpaa2_flow_item_gre_mask = {
 
 static const struct rte_flow_item_vxlan dpaa2_flow_item_vxlan_mask = {
 	.flags = 0xff,
-	.vni = { 0xff, 0xff, 0xff },
+	.vni = "\xff\xff\xff",
+};
+
+static const struct rte_flow_item_geneve dpaa2_flow_item_geneve_mask = {
+	.protocol = RTE_BE16(0xffff),
+	.vni = "\xff\xff\xff",
 };
 
 static const struct rte_flow_item_ecpri dpaa2_flow_item_ecpri_mask = {
@@ -185,643 +230,606 @@ static const struct rte_flow_item_gtp dpaa2_flow_item_gtp_mask = {
 };
 
 static const struct rte_flow_item_mpls dpaa2_flow_item_mpls_mask = {
-	.label_tc_s = { 0xff, 0xff, 0xff },
+	.label_tc_s = {0xff, 0xff, 0xff},
 };
 
 static const struct rte_flow_item_pppoe dpaa2_flow_item_pppoe_mask = {
+	.code = 0xff,
 	.session_id = RTE_BE16(0xffff),
 };
-
 #endif
 
-
-#define DPAA2_FLOW_DUMP dpaa2_dump_print
-
-static inline void
-dpaa2_prot_field_string(uint32_t prot, uint32_t field,
-	char *string)
+static int
+dpaa2_flow_attr_group_convert(struct dpaa2_dev_priv *priv,
+	const struct rte_flow_attr *c_attr, struct rte_flow_attr *attr)
 {
-	if (!dpaa2_flow_control_log)
-		return;
+	enum rte_dpaa2_flow_type group_type;
+	uint32_t group_id;
 
-	if (prot == NET_PROT_ETH) {
-		strcpy(string, "eth");
-		if (field == NH_FLD_ETH_DA)
-			strcat(string, ".dst");
-		else if (field == NH_FLD_ETH_SA)
-			strcat(string, ".src");
-		else if (field == NH_FLD_ETH_TYPE)
-			strcat(string, ".type");
-		else
-			strcat(string, ".unknown field");
-	} else if (prot == NET_PROT_VLAN) {
-		strcpy(string, "vlan");
-		if (field == NH_FLD_VLAN_TCI)
-			strcat(string, ".tci");
-		else
-			strcat(string, ".unknown field");
-	} else if (prot == NET_PROT_IP) {
-		strcpy(string, "ip");
-		if (field == NH_FLD_IP_SRC)
-			strcat(string, ".src");
-		else if (field == NH_FLD_IP_DST)
-			strcat(string, ".dst");
-		else if (field == NH_FLD_IP_PROTO)
-			strcat(string, ".proto");
-		else
-			strcat(string, ".unknown field");
-	} else if (prot == NET_PROT_TCP) {
-		strcpy(string, "tcp");
-		if (field == NH_FLD_TCP_PORT_SRC)
-			strcat(string, ".src");
-		else if (field == NH_FLD_TCP_PORT_DST)
-			strcat(string, ".dst");
-		else
-			strcat(string, ".unknown field");
-	} else if (prot == NET_PROT_UDP) {
-		strcpy(string, "udp");
-		if (field == NH_FLD_UDP_PORT_SRC)
-			strcat(string, ".src");
-		else if (field == NH_FLD_UDP_PORT_DST)
-			strcat(string, ".dst");
-		else
-			strcat(string, ".unknown field");
-	} else if (prot == NET_PROT_ICMP) {
-		strcpy(string, "icmp");
-		if (field == NH_FLD_ICMP_TYPE)
-			strcat(string, ".type");
-		else if (field == NH_FLD_ICMP_CODE)
-			strcat(string, ".code");
-		else
-			strcat(string, ".unknown field");
-	} else if (prot == NET_PROT_SCTP) {
-		strcpy(string, "sctp");
-		if (field == NH_FLD_SCTP_PORT_SRC)
-			strcat(string, ".src");
-		else if (field == NH_FLD_SCTP_PORT_DST)
-			strcat(string, ".dst");
-		else
-			strcat(string, ".unknown field");
-	} else if (prot == NET_PROT_GRE) {
-		strcpy(string, "gre");
-		if (field == NH_FLD_GRE_TYPE)
-			strcat(string, ".type");
-		else
-			strcat(string, ".unknown field");
-	} else if (prot == NET_PROT_GTP) {
-		rte_strscpy(string, "gtp", DPAA2_PROT_FIELD_STRING_SIZE);
-		if (field == NH_FLD_GTP_TEID)
-			strcat(string, ".teid");
-		else
-			strcat(string, ".unknown field");
-	} else if (prot == NET_PROT_IPSEC_ESP) {
-		rte_strscpy(string, "esp", DPAA2_PROT_FIELD_STRING_SIZE);
-		if (field == NH_FLD_IPSEC_ESP_SPI)
-			strcat(string, ".spi");
-		else if (field == NH_FLD_IPSEC_ESP_SEQUENCE_NUM)
-			strcat(string, ".seq");
-		else
-			strcat(string, ".unknown field");
-	} else {
-		sprintf(string, "unknown protocol(%d)", prot);
+	group_type = RTE_DPAA2_FLOW_GROUP_TYPE_GET(c_attr->group);
+	group_id = RTE_DPAA2_FLOW_GROUP_ID_GET(c_attr->group);
+	if (group_id >= priv->num_rx_tc) {
+		group_id = 0;
+		group_type = RTE_DPAA2_QOS_GROUP_FLOW;
 	}
+	if (group_type > RTE_DPAA2_MIX_GROUP_FLOW)
+		return -EINVAL;
+	rte_memcpy(attr, c_attr, sizeof(struct rte_flow_attr));
+	attr->group = group_id;
+	RTE_DPAA2_FLOW_GROUP_TYPE_SET(attr->group, group_type);
+
+	return 0;
 }
 
-static inline void
-dpaa2_flow_qos_extracts_log(const struct dpaa2_dev_priv *priv)
+static int
+dpaa2_flow_extract_support(const uint8_t *mask_src, const uint8_t *mask_support,
+	uint8_t size)
 {
-	int idx;
-	char string[32];
-	const struct dpkg_profile_cfg *dpkg =
-		&priv->extract.qos_key_extract.dpkg;
-	const struct dpkg_extract *extract;
-	enum dpkg_extract_type type;
-	enum net_prot prot;
-	uint32_t field;
+	uint8_t mask[64], i;
 
-	if (!dpaa2_flow_control_log)
-		return;
+	rte_memcpy(mask, mask_support, size);
 
-	DPAA2_FLOW_DUMP("QoS table: %d extracts\r\n",
-		dpkg->num_extracts);
-	for (idx = 0; idx < dpkg->num_extracts; idx++) {
-		extract = &dpkg->extracts[idx];
-		type = extract->type;
-		if (type == DPKG_EXTRACT_FROM_HDR) {
-			prot = extract->extract.from_hdr.prot;
-			field = extract->extract.from_hdr.field;
-			dpaa2_prot_field_string(prot, field,
-				string);
-		} else if (type == DPKG_EXTRACT_FROM_DATA) {
-			sprintf(string, "raw offset/len: %d/%d",
-				extract->extract.from_data.offset,
-				extract->extract.from_data.size);
-		} else if (type == DPKG_EXTRACT_FROM_PARSE) {
-			sprintf(string, "parse offset/len: %d/%d",
-				extract->extract.from_parse.offset,
-				extract->extract.from_parse.size);
-		}
-		DPAA2_FLOW_DUMP("%s", string);
-		if ((idx + 1) < dpkg->num_extracts)
-			DPAA2_FLOW_DUMP(" / ");
+	for (i = 0; i < size; i++)
+		mask[i] = (mask[i] | mask_src[i]);
+
+	if (memcmp(mask, mask_support, size)) {
+		dpaa2_dump_print("Unsupported extracts with mask:");
+		dpaa2_dump_hex_print(mask, size);
+		return -ENOTSUP;
 	}
-	DPAA2_FLOW_DUMP("\r\n");
+
+	return 0;
 }
 
-static inline void
-dpaa2_flow_fs_extracts_log(const struct dpaa2_dev_priv *priv,
-	int tc_id)
-{
-	int idx;
-	char string[32];
-	const struct dpkg_profile_cfg *dpkg =
-		&priv->extract.tc_key_extract[tc_id].dpkg;
-	const struct dpkg_extract *extract;
-	enum dpkg_extract_type type;
+#define DPAA2_FLOW_EXTRACT_MAX_FIELDS 8
+struct dpaa2_flow_proto_handle {
+	const char *name;
+	int (*cb)(struct dpaa2_generic_flow *flow,
+		const struct rte_flow_item *pattern,
+		const struct dpaa2_flow_proto_handle *hd,
+		int *ecfg);
+	int (*tunnel)(struct dpaa2_generic_flow *flow,
+		const struct rte_flow_item *pattern,
+		const struct dpaa2_flow_proto_handle *hd,
+		int *ecfg);
+	enum dpaa2_parser_protocol_id protocol_id;
+	enum dpaa2_parser_protocol_id tunnel_id;
+	enum rte_flow_item_type item_type;
+	const void *mask_support;
+	uint32_t hdr_size;
+	int force_psr;
 	enum net_prot prot;
-	uint32_t field;
-
-	if (!dpaa2_flow_control_log)
-		return;
+	uint8_t fields_num;
+	uint32_t fields[DPAA2_FLOW_EXTRACT_MAX_FIELDS];
+	uint16_t field_offset[DPAA2_FLOW_EXTRACT_MAX_FIELDS];
+	uint16_t field_size[DPAA2_FLOW_EXTRACT_MAX_FIELDS];
+};
 
-	DPAA2_FLOW_DUMP("FS table: %d extracts in TC[%d]\r\n",
-		dpkg->num_extracts, tc_id);
-	for (idx = 0; idx < dpkg->num_extracts; idx++) {
-		extract = &dpkg->extracts[idx];
-		type = extract->type;
-		if (type == DPKG_EXTRACT_FROM_HDR) {
-			prot = extract->extract.from_hdr.prot;
-			field = extract->extract.from_hdr.field;
-			dpaa2_prot_field_string(prot, field,
-				string);
-		} else if (type == DPKG_EXTRACT_FROM_DATA) {
-			sprintf(string, "raw offset/len: %d/%d",
-				extract->extract.from_data.offset,
-				extract->extract.from_data.size);
-		} else if (type == DPKG_EXTRACT_FROM_PARSE) {
-			sprintf(string, "parse offset/len: %d/%d",
-				extract->extract.from_parse.offset,
-				extract->extract.from_parse.size);
-		}
-		DPAA2_FLOW_DUMP("%s", string);
-		if ((idx + 1) < dpkg->num_extracts)
-			DPAA2_FLOW_DUMP(" / ");
-	}
-	DPAA2_FLOW_DUMP("\r\n");
+static inline struct dpaa2_flow_tbl_profile *
+dpaa2_flow_table_profile(struct dpaa2_generic_flow *flow)
+{
+	if (flow->type == DPAA2_FLOW_QOS_TYPE)
+		return &flow->priv->flow_profile.qos_profile;
+	return &flow->priv->flow_profile.tc_profile[flow->tc_id];
 }
 
-static inline void
-dpaa2_flow_qos_entry_log(const char *log_info,
-	const struct dpaa2_dev_flow *flow, int qos_index)
+static inline struct dpaa2_key_profile *
+dpaa2_flow_key_profile(struct dpaa2_generic_flow *flow)
 {
-	int idx;
-	uint8_t *key, *mask;
+	struct dpaa2_flow_tbl_profile *tbl_profile = dpaa2_flow_table_profile(flow);
 
-	if (!dpaa2_flow_control_log)
-		return;
+	return &tbl_profile->key_profile;
+}
 
-	if (qos_index >= 0) {
-		DPAA2_FLOW_DUMP("%s QoS entry[%d](size %d/%d) for TC[%d]\r\n",
-			log_info, qos_index, flow->qos_rule_size,
-			flow->qos_rule.key_size,
-			flow->tc_id);
-	} else {
-		DPAA2_FLOW_DUMP("%s QoS entry(size %d/%d) for TC[%d]\r\n",
-			log_info, flow->qos_rule_size,
-			flow->qos_rule.key_size,
-			flow->tc_id);
+static int
+dpaa2_flow_l4_port_extract(const struct dpkg_extract *l4_port_search)
+{
+	if (l4_port_search->type != DPKG_EXTRACT_FROM_HDR)
+		return -ENXIO;
+	if (l4_port_search->extract.from_hdr.prot == NET_PROT_TCP) {
+		if (l4_port_search->extract.from_hdr.field == NH_FLD_TCP_PORT_SRC)
+			return DPAA2_L4_SRC_PORT;
+		if (l4_port_search->extract.from_hdr.field == NH_FLD_TCP_PORT_DST)
+			return DPAA2_L4_DST_PORT;
+	} else if (l4_port_search->extract.from_hdr.prot == NET_PROT_UDP) {
+		if (l4_port_search->extract.from_hdr.field == NH_FLD_UDP_PORT_SRC)
+			return DPAA2_L4_SRC_PORT;
+		if (l4_port_search->extract.from_hdr.field == NH_FLD_UDP_PORT_DST)
+			return DPAA2_L4_DST_PORT;
+	} else if (l4_port_search->extract.from_hdr.prot == NET_PROT_SCTP) {
+		if (l4_port_search->extract.from_hdr.field == NH_FLD_SCTP_PORT_SRC)
+			return DPAA2_L4_SRC_PORT;
+		if (l4_port_search->extract.from_hdr.field == NH_FLD_SCTP_PORT_DST)
+			return DPAA2_L4_DST_PORT;
 	}
 
-	key = flow->qos_key_addr;
-	mask = flow->qos_mask_addr;
+	return -ENXIO;
+}
 
-	DPAA2_FLOW_DUMP("key:\r\n");
-	for (idx = 0; idx < flow->qos_rule_size; idx++)
-		DPAA2_FLOW_DUMP("%02x ", key[idx]);
+static inline struct dpaa2_generic_flow *
+dpaa2_flow_generic_flow(struct dpaa2_dev_flow *dev_flow,
+	enum dpaa2_flow_dist_type type, uint8_t tc_id)
+{
+	if (type == DPAA2_FLOW_QOS_TYPE)
+		return dev_flow->qos_flow;
+	if (type == DPAA2_FLOW_FS_TYPE && dev_flow->fs_flow &&
+		(dev_flow->fs_flow->tc_id == tc_id || tc_id >= MAX_TCS)) {
+		return dev_flow->fs_flow;
+	}
+	if (type == DPAA2_FLOW_RSS_TYPE && dev_flow->rss_flow &&
+		(dev_flow->rss_flow->tc_id == tc_id || tc_id >= MAX_TCS)) {
+		return dev_flow->rss_flow;
+	}
 
-	DPAA2_FLOW_DUMP("\r\nmask:\r\n");
-	for (idx = 0; idx < flow->qos_rule_size; idx++)
-		DPAA2_FLOW_DUMP("%02x ", mask[idx]);
-	DPAA2_FLOW_DUMP("\r\n");
+	return NULL;
 }
 
-static inline void
-dpaa2_flow_fs_entry_log(const char *log_info,
-	const struct dpaa2_dev_flow *flow)
+static inline int
+dpaa2_flow_extract_search(const struct dpaa2_key_profile *key_profile,
+	enum key_prot_type type, enum net_prot prot, uint32_t key_field)
 {
-	int idx;
-	uint8_t *key, *mask;
+	int extract_idx, l4_idx;
+	const struct key_prot_field *prot_field;
+	struct dpkg_extract l4_port_search;
 
-	if (!dpaa2_flow_control_log)
-		return;
+	prot_field = key_profile->prot_field;
+	for (extract_idx = 0; extract_idx < key_profile->dpkg.num_extracts; extract_idx++) {
+		if (type == DPAA2_NET_PROT_KEY &&
+			prot_field[extract_idx].prot == prot &&
+			prot_field[extract_idx].key_field == key_field &&
+			prot_field[extract_idx].type == type)
+			return extract_idx;
+		else if (type == DPAA2_FAF_KEY &&
+			prot_field[extract_idx].key_field == key_field &&
+			prot_field[extract_idx].type == type)
+			return extract_idx;
+		else if (type == DPAA2_PR_KEY &&
+			prot_field[extract_idx].key_field == key_field &&
+			prot_field[extract_idx].type == type)
+			return extract_idx;
+	}
 
-	DPAA2_FLOW_DUMP("%s FS/TC entry[%d](size %d/%d) of TC[%d]\r\n",
-		log_info, flow->tc_index,
-		flow->fs_rule_size, flow->fs_rule.key_size,
-		flow->tc_id);
+	if (type != DPAA2_NET_PROT_KEY)
+		return -ENXIO;
 
-	key = flow->fs_key_addr;
-	mask = flow->fs_mask_addr;
+	l4_port_search.type = DPKG_EXTRACT_FROM_HDR;
+	l4_port_search.extract.from_hdr.prot = prot;
+	l4_port_search.extract.from_hdr.field = key_field;
 
-	DPAA2_FLOW_DUMP("key:\r\n");
-	for (idx = 0; idx < flow->fs_rule_size; idx++)
-		DPAA2_FLOW_DUMP("%02x ", key[idx]);
+	l4_idx = dpaa2_flow_l4_port_extract(&l4_port_search);
+	if (l4_idx < 0)
+		return -ENXIO;
+	if (key_profile->l4_port[l4_idx].present)
+		return key_profile->l4_port[l4_idx].extract_idx;
 
-	DPAA2_FLOW_DUMP("\r\nmask:\r\n");
-	for (idx = 0; idx < flow->fs_rule_size; idx++)
-		DPAA2_FLOW_DUMP("%02x ", mask[idx]);
-	DPAA2_FLOW_DUMP("\r\n");
+	return -ENXIO;
 }
 
-static int
-dpaa2_flow_ip_address_extract(enum net_prot prot,
-	uint32_t field)
+static void
+_dpaa2_flow_rule_insert_hole(struct dpaa2_generic_flow *flow,
+	int offset, int size)
 {
-	if (prot == NET_PROT_IPV4 &&
-		(field == NH_FLD_IPV4_SRC_IP ||
-		field == NH_FLD_IPV4_DST_IP))
-		return true;
-	else if (prot == NET_PROT_IPV6 &&
-		(field == NH_FLD_IPV6_SRC_IP ||
-		field == NH_FLD_IPV6_DST_IP))
-		return true;
-	else if (prot == NET_PROT_IP &&
-		(field == NH_FLD_IP_SRC ||
-		field == NH_FLD_IP_DST))
-		return true;
+	uint8_t *src, *dst;
+	uint8_t move_len;
 
-	return false;
+	if (!flow->key_addr || !flow->mask_addr)
+		return;
+	if (offset < flow->rule_size) {
+		src = flow->key_addr + offset;
+		dst = src + size;
+		move_len = flow->rule_size - offset;
+		memmove(dst, src, move_len);
+		memset(src, 0, size);
+
+		src = flow->mask_addr + offset;
+		dst = src + size;
+		memmove(dst, src, move_len);
+		memset(src, 0, size);
+		flow->rule_size += size;
+	} else {
+		flow->rule_size = offset + size;
+	}
 }
 
-static int
-dpaa2_flow_l4_src_port_extract(enum net_prot prot,
-	uint32_t field)
+static void
+dpaa2_flow_rule_insert_hole(struct dpaa2_generic_flow *curr,
+	int offset, int size)
 {
-	if (prot == NET_PROT_TCP &&
-		field == NH_FLD_TCP_PORT_SRC)
-		return true;
-	else if (prot == NET_PROT_UDP &&
-		field == NH_FLD_UDP_PORT_SRC)
-		return true;
-	else if (prot == NET_PROT_SCTP &&
-		field == NH_FLD_SCTP_PORT_SRC)
-		return true;
-
-	return false;
-}
+	struct dpaa2_dev_priv *priv = curr->priv;
+	struct dpaa2_dev_flow *flow;
+	struct dpaa2_generic_flow *steering_flow;
 
-static int
-dpaa2_flow_l4_dst_port_extract(enum net_prot prot,
-	uint32_t field)
-{
-	if (prot == NET_PROT_TCP &&
-		field == NH_FLD_TCP_PORT_DST)
-		return true;
-	else if (prot == NET_PROT_UDP &&
-		field == NH_FLD_UDP_PORT_DST)
-		return true;
-	else if (prot == NET_PROT_SCTP &&
-		field == NH_FLD_SCTP_PORT_DST)
-		return true;
+	if (curr)
+		_dpaa2_flow_rule_insert_hole(curr, offset, size);
 
-	return false;
+	flow = LIST_FIRST(&priv->flows);
+	while (flow) {
+		steering_flow = dpaa2_flow_generic_flow(flow, curr->type, curr->tc_id);
+		flow = LIST_NEXT(flow, next);
+		if (!steering_flow || (!steering_flow->ip_src && !steering_flow->ip_dst))
+			continue;
+		_dpaa2_flow_rule_insert_hole(steering_flow, offset, size);
+	}
 }
 
 static int
-dpaa2_flow_add_qos_rule(struct dpaa2_dev_priv *priv,
-	struct dpaa2_dev_flow *flow)
+dpaa2_flow_faf_advance(struct dpaa2_generic_flow *flow,
+	int faf_byte, int *insert_offset)
 {
-	uint16_t qos_index;
-	int ret;
-	struct fsl_mc_io *dpni = priv->hw;
-
-	if (priv->num_rx_tc <= 1 &&
-		flow->action_type != RTE_FLOW_ACTION_TYPE_RSS) {
-		DPAA2_PMD_WARN("No QoS Table for FS");
-		return -EINVAL;
-	}
+	struct dpaa2_key_profile *key_profile = dpaa2_flow_key_profile(flow);
+	uint8_t idx, offset = 0xff;
+	struct key_prot_field prot = {0};
 
-	/* QoS entry added is only effective for multiple TCs.*/
-	qos_index = flow->tc_id * priv->fs_entries + flow->tc_index;
-	if (qos_index >= priv->qos_entries) {
-		DPAA2_PMD_ERR("QoS table full(%d >= %d)",
-			qos_index, priv->qos_entries);
+	if (key_profile->dpkg.num_extracts >= DPKG_MAX_NUM_OF_EXTRACTS) {
+		DPAA2_PMD_ERR("Number of extracts overflows");
 		return -EINVAL;
 	}
 
-	dpaa2_flow_qos_entry_log("Start add", flow, qos_index);
-
-	ret = dpni_add_qos_entry(dpni, CMD_PRI_LOW,
-			priv->token, &flow->qos_rule,
-			flow->tc_id, qos_index,
-			0, 0);
-	if (ret < 0) {
-		DPAA2_PMD_ERR("Add entry(%d) to table(%d) failed",
-			qos_index, flow->tc_id);
-		return ret;
-	}
+	prot.type = DPAA2_FAF_KEY;
+	prot.key_field = faf_byte;
+	idx = dpaa2_profile_insert_no_ipaddr_extract(key_profile,
+		1, &offset, insert_offset, &prot);
+	dpaa2_flow_rule_insert_hole(flow, offset, 1);
 
-	return 0;
+	return idx;
 }
 
 static int
-dpaa2_flow_add_fs_rule(struct dpaa2_dev_priv *priv,
-	struct dpaa2_dev_flow *flow)
+dpaa2_flow_extract_add_faf_psr(struct dpaa2_generic_flow *flow,
+	int faf_byte, int *insert_offset)
 {
-	int ret;
-	struct fsl_mc_io *dpni = priv->hw;
+	int extract_idx;
+	struct dpaa2_key_profile *key_profile = dpaa2_flow_key_profile(flow);
+	struct dpkg_extract extract;
 
-	if (flow->tc_index >= priv->fs_entries) {
-		DPAA2_PMD_ERR("FS table full(%d >= %d)",
-			flow->tc_index, priv->fs_entries);
+	if (key_profile->dpkg.num_extracts >= DPKG_MAX_NUM_OF_EXTRACTS) {
+		DPAA2_PMD_ERR("Number of extracts overflows");
 		return -EINVAL;
 	}
 
-	dpaa2_flow_fs_entry_log("Start add", flow);
+	extract_idx = dpaa2_flow_faf_advance(flow, faf_byte, insert_offset);
+	if (extract_idx < 0)
+		return extract_idx;
 
-	if (priv->mc_rev >= DPAA2_FLOW_FRM_REPLICATION_ACTION_MC_REV) {
-		ret = dpni_add_fs_entry(dpni, CMD_PRI_LOW,
-				priv->token, flow->tc_id,
-				flow->tc_index, &flow->fs_rule,
-				&flow->fs_action_cfg);
-	} else {
-		ret = dpni_add_fs_entry_legacy(dpni, CMD_PRI_LOW,
-				priv->token, flow->tc_id,
-				flow->tc_index, &flow->fs_rule,
-				&flow->fs_action_cfg);
-	}
-	if (ret < 0) {
-		DPAA2_PMD_ERR("Add rule(%d) to FS table(%d) failed",
-			flow->tc_index, flow->tc_id);
-		return ret;
-	}
+	memset(&extract, 0, sizeof(extract));
+	extract.type = DPKG_EXTRACT_FROM_PARSE;
+	extract.extract.from_parse.offset = faf_byte;
+	extract.extract.from_parse.size = 1;
+	dpaa2_dpkg_insert_extract(&key_profile->dpkg, extract_idx, &extract);
 
 	return 0;
 }
 
+static inline int
+dpaa2_flow_extract_key_offset(struct dpaa2_key_profile *key_profile,
+	enum key_prot_type type, enum net_prot prot, uint32_t key_field)
+{
+	int i;
+
+	i = dpaa2_flow_extract_search(key_profile, type, prot, key_field);
+	if (i >= 0)
+		return key_profile->prot_field[i].key_offset;
+	else
+		return i;
+}
+
 static int
-dpaa2_flow_rule_insert_hole(struct dpaa2_dev_flow *flow,
-	int offset, int size,
-	enum dpaa2_flow_dist_type dist_type)
+dpaa2_flow_faf_add_rule(struct dpaa2_generic_flow *flow, uint32_t faf_bit_off)
 {
-	if (dist_type & DPAA2_FLOW_QOS_TYPE) {
-		if (offset < flow->qos_rule_size) {
-			memmove(flow->qos_key_addr + offset + size,
-					flow->qos_key_addr + offset,
-					flow->qos_rule_size - offset);
-			memset(flow->qos_key_addr + offset,
-					0, size);
-
-			memmove(flow->qos_mask_addr + offset + size,
-					flow->qos_mask_addr + offset,
-					flow->qos_rule_size - offset);
-			memset(flow->qos_mask_addr + offset,
-					0, size);
-			flow->qos_rule_size += size;
-		} else {
-			flow->qos_rule_size = offset + size;
-		}
-	}
+	int offset;
+	uint8_t *key_addr, *mask_addr;
+	struct dpaa2_key_profile *key_profile = dpaa2_flow_key_profile(flow);
+	uint8_t faf_byte = faf_bit_off / 8;
+	uint8_t faf_bit_in_byte = faf_bit_off % 8;
 
-	if (dist_type & DPAA2_FLOW_FS_TYPE) {
-		if (offset < flow->fs_rule_size) {
-			memmove(flow->fs_key_addr + offset + size,
-					flow->fs_key_addr + offset,
-					flow->fs_rule_size - offset);
-			memset(flow->fs_key_addr + offset,
-					0, size);
-
-			memmove(flow->fs_mask_addr + offset + size,
-					flow->fs_mask_addr + offset,
-					flow->fs_rule_size - offset);
-			memset(flow->fs_mask_addr + offset,
-					0, size);
-			flow->fs_rule_size += size;
-		} else {
-			flow->fs_rule_size = offset + size;
-		}
+	faf_bit_in_byte = 7 - faf_bit_in_byte;
+	offset = dpaa2_flow_extract_key_offset(key_profile,
+			DPAA2_FAF_KEY, NET_PROT_NONE, faf_byte);
+	if (offset < 0) {
+		DPAA2_PMD_ERR("Failed(%d) to extract FAF offset", offset);
+		return offset;
 	}
+	if (!flow->key_addr || !flow->mask_addr)
+		return 0;
+
+	key_addr = flow->key_addr + offset;
+	mask_addr = flow->mask_addr + offset;
+
+	if (!(*key_addr) && !(flow->ip_src || flow->ip_dst) &&
+		offset >= flow->rule_size)
+		flow->rule_size = offset + sizeof(uint8_t);
+
+	*key_addr |=  (1 << faf_bit_in_byte);
+	*mask_addr |=  (1 << faf_bit_in_byte);
 
 	return 0;
 }
 
 static int
-dpaa2_flow_rule_add_all(struct dpaa2_dev_priv *priv,
-	enum dpaa2_flow_dist_type dist_type,
-	uint16_t entry_size, uint8_t tc_id)
+dpaa2_flow_identify_by_faf(struct dpaa2_generic_flow *flow,
+	uint32_t faf_bit_off, int *recfg)
 {
-	struct dpaa2_dev_flow *curr = LIST_FIRST(&priv->flows);
-	int ret;
+	int ret, index;
+	struct dpaa2_key_profile *key_profile = dpaa2_flow_key_profile(flow);
+	uint8_t faf_byte = faf_bit_off / 8;
 
-	while (curr) {
-		if (dist_type & DPAA2_FLOW_QOS_TYPE) {
-			if (priv->num_rx_tc > 1 ||
-				curr->action_type ==
-				RTE_FLOW_ACTION_TYPE_RSS) {
-				curr->qos_rule.key_size = entry_size;
-				ret = dpaa2_flow_add_qos_rule(priv, curr);
-				if (ret)
-					return ret;
-			}
-		}
-		if (dist_type & DPAA2_FLOW_FS_TYPE &&
-			curr->tc_id == tc_id) {
-			curr->fs_rule.key_size = entry_size;
-			ret = dpaa2_flow_add_fs_rule(priv, curr);
-			if (ret)
-				return ret;
+	index = dpaa2_flow_extract_search(key_profile, DPAA2_FAF_KEY,
+		NET_PROT_NONE, faf_byte);
+	if (index < 0) {
+		ret = dpaa2_flow_extract_add_faf_psr(flow, faf_byte, NULL);
+		if (ret) {
+			DPAA2_PMD_ERR("Failed(%d) to add %s faf extract",
+				ret, flow->type == DPAA2_FLOW_QOS_TYPE ? "QoS" : "TC");
+
+			return ret;
 		}
-		curr = LIST_NEXT(curr, next);
+		if (recfg)
+			*recfg = true;
+	}
+	ret = dpaa2_flow_faf_add_rule(flow, faf_bit_off);
+	if (ret) {
+		DPAA2_PMD_ERR("Failed(%d) to add %s faf rule",
+			ret, flow->type == DPAA2_FLOW_QOS_TYPE ? "QoS" : "TC");
+		return ret;
 	}
 
 	return 0;
 }
 
 static int
-dpaa2_flow_qos_rule_insert_hole(struct dpaa2_dev_priv *priv,
-	int offset, int size)
+dpaa2_flow_general_tunnel_extract_rule_set(struct dpaa2_generic_flow *flow,
+	const struct rte_flow_item *pattern,
+	const struct dpaa2_flow_proto_handle *hd, int *ecfg)
 {
-	struct dpaa2_dev_flow *curr;
-	int ret;
+	int ret = 0;
+	uint32_t bit_offset;
 
-	curr = priv->curr;
-	if (!curr) {
-		DPAA2_PMD_ERR("Current qos flow insert hole failed.");
-		return -EINVAL;
-	} else {
-		ret = dpaa2_flow_rule_insert_hole(curr, offset, size,
-				DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
+	if (pattern->spec) {
+		DPAA2_PMD_ERR("Tunnel distribution not support");
+		return -ENOTSUP;
 	}
 
-	curr = LIST_FIRST(&priv->flows);
-	while (curr) {
-		ret = dpaa2_flow_rule_insert_hole(curr, offset, size,
-				DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-		curr = LIST_NEXT(curr, next);
-	}
+	ret = dpaa2_protocol_psr_bit_offset(&bit_offset, hd->tunnel_id);
+	if (ret)
+		return ret;
 
-	return 0;
+	return dpaa2_flow_identify_by_faf(flow, bit_offset, ecfg);
 }
 
 static int
-dpaa2_flow_fs_rule_insert_hole(struct dpaa2_dev_priv *priv,
-	int offset, int size, int tc_id)
+dpaa2_flow_soft_psr_advance(struct dpaa2_generic_flow *flow,
+	uint32_t pr_offset, uint32_t pr_size, int *insert_offset)
 {
-	struct dpaa2_dev_flow *curr;
-	int ret;
+	struct dpaa2_key_profile *key_profile = dpaa2_flow_key_profile(flow);
+	uint8_t idx, offset = 0xff;
+	struct key_prot_field prot = {0};
 
-	curr = priv->curr;
-	if (!curr || curr->tc_id != tc_id) {
-		DPAA2_PMD_ERR("Current flow insert hole failed.");
+	if (key_profile->dpkg.num_extracts >= DPKG_MAX_NUM_OF_EXTRACTS) {
+		DPAA2_PMD_ERR("Number of extracts overflows");
 		return -EINVAL;
-	} else {
-		ret = dpaa2_flow_rule_insert_hole(curr, offset, size,
-				DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
 	}
 
-	curr = LIST_FIRST(&priv->flows);
-
-	while (curr) {
-		if (curr->tc_id != tc_id) {
-			curr = LIST_NEXT(curr, next);
-			continue;
-		}
-		ret = dpaa2_flow_rule_insert_hole(curr, offset, size,
-				DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
-		curr = LIST_NEXT(curr, next);
-	}
+	prot.type = DPAA2_PR_KEY;
+	prot.key_field = (pr_offset << 16) | pr_size;
+	idx = dpaa2_profile_insert_no_ipaddr_extract(key_profile,
+		pr_size, &offset, insert_offset, &prot);
+	dpaa2_flow_rule_insert_hole(flow, offset, pr_size);
 
-	return 0;
+	return idx;
 }
 
 static int
-dpaa2_flow_faf_advance(struct dpaa2_dev_priv *priv,
-	int faf_byte, enum dpaa2_flow_dist_type dist_type, int tc_id,
-	int *insert_offset)
+dpaa2_flow_extract_add_soft_psr(struct dpaa2_generic_flow *flow,
+	uint32_t pr_offset, uint32_t pr_size, int *insert_offset)
 {
-	int offset, ret;
-	struct dpaa2_key_profile *key_profile;
-	int num, pos;
+	int extract_idx;
+	struct dpaa2_key_profile *key_profile = dpaa2_flow_key_profile(flow);
+	struct dpkg_extract extract;
 
-	if (dist_type == DPAA2_FLOW_QOS_TYPE)
-		key_profile = &priv->extract.qos_key_extract.key_profile;
-	else
-		key_profile = &priv->extract.tc_key_extract[tc_id].key_profile;
-
-	num = key_profile->num;
+	if ((pr_offset + pr_size) > DPAA2_PSR_RESULT_SIZE) {
+		DPAA2_PMD_ERR("PR extracts(%d:%d) overflow",
+			pr_offset, pr_size);
+		return -EINVAL;
+	}
 
-	if (num >= DPKG_MAX_NUM_OF_EXTRACTS) {
+	if (key_profile->dpkg.num_extracts >= DPKG_MAX_NUM_OF_EXTRACTS) {
 		DPAA2_PMD_ERR("Number of extracts overflows");
 		return -EINVAL;
 	}
 
-	if (key_profile->ip_addr_type != IP_NONE_ADDR_EXTRACT) {
-		offset = key_profile->ip_addr_extract_off;
-		pos = key_profile->ip_addr_extract_pos;
-		key_profile->ip_addr_extract_pos++;
-		key_profile->ip_addr_extract_off++;
-		if (dist_type == DPAA2_FLOW_QOS_TYPE) {
-			ret = dpaa2_flow_qos_rule_insert_hole(priv,
-					offset, 1);
-		} else {
-			ret = dpaa2_flow_fs_rule_insert_hole(priv,
-				offset, 1, tc_id);
-		}
-		if (ret)
-			return ret;
-	} else {
-		pos = num;
-	}
+	extract_idx = dpaa2_flow_soft_psr_advance(flow, pr_offset, pr_size, insert_offset);
+	if (extract_idx < 0)
+		return extract_idx;
 
-	if (pos > 0) {
-		key_profile->key_offset[pos] =
-			key_profile->key_offset[pos - 1] +
-			key_profile->key_size[pos - 1];
-	} else {
-		key_profile->key_offset[pos] = 0;
-	}
+	memset(&extract, 0, sizeof(extract));
+	extract.type = DPKG_EXTRACT_FROM_PARSE;
+	extract.extract.from_parse.offset = pr_offset;
+	extract.extract.from_parse.size = pr_size;
+	dpaa2_dpkg_insert_extract(&key_profile->dpkg, extract_idx, &extract);
 
-	key_profile->key_size[pos] = 1;
-	key_profile->prot_field[pos].type = DPAA2_FAF_KEY;
-	key_profile->prot_field[pos].key_field = faf_byte;
-	key_profile->num++;
+	return 0;
+}
 
-	if (insert_offset)
-		*insert_offset = key_profile->key_offset[pos];
+static inline int
+dpaa2_flow_pr_rule_data_set(struct dpaa2_generic_flow *flow,
+	uint32_t pr_offset, uint32_t pr_size, const void *key, const void *mask,
+	enum dpaa2_flow_dist_type dist_type)
+{
+	struct dpaa2_key_profile *key_profile = dpaa2_flow_key_profile(flow);
+	int offset;
+	uint32_t pr_field = pr_offset << 16 | pr_size;
+	char offset_info[64], size_info[64], rule_size_info[64];
 
-	key_profile->key_max_size++;
+	offset = dpaa2_flow_extract_key_offset(key_profile,
+			DPAA2_PR_KEY, NET_PROT_NONE, pr_field);
+	if (offset < 0) {
+		DPAA2_PMD_ERR("PR off(%d)/size(%d) does not exist!",
+			pr_offset, pr_size);
+		return offset;
+	}
+	snprintf(offset_info, 64, "offset(%d)", offset);
+	snprintf(size_info, 64, "size(%d)", pr_size);
+
+	snprintf(rule_size_info, 64, "%s rule size(%d)",
+		dist_type == DPAA2_FLOW_QOS_TYPE ?
+		"QoS" : "FS", flow->rule_size);
+	memcpy((flow->key_addr + offset), key, pr_size);
+	memcpy((flow->mask_addr + offset), mask, pr_size);
+	if (!(flow->ip_src || flow->ip_dst)) {
+		if (offset >= flow->rule_size) {
+			flow->rule_size = offset + pr_size;
+		} else if ((offset + pr_size) > flow->rule_size) {
+			DPAA2_PMD_ERR("%s < %s, but %s + %s > %s",
+			offset_info, rule_size_info,
+			offset_info, size_info,
+			rule_size_info);
+			return -EINVAL;
+		}
+	}
 
-	return pos;
+	return 0;
 }
 
 static int
-dpaa2_flow_pr_advance(struct dpaa2_dev_priv *priv,
-	uint32_t pr_offset, uint32_t pr_size,
-	enum dpaa2_flow_dist_type dist_type, int tc_id,
-	int *insert_offset)
+dpaa2_flow_add_soft_psr_extract_rule(struct dpaa2_generic_flow *flow,
+	uint32_t pr_offset, uint32_t pr_size, const void *key,
+	const void *mask, int *recfg)
 {
-	int offset, ret;
-	struct dpaa2_key_profile *key_profile;
-	int num, pos;
+	int index, ret;
+	struct dpaa2_key_profile *key_profile = dpaa2_flow_key_profile(flow);
+	uint32_t pr_field = pr_offset << 16 | pr_size;
 
-	if (dist_type == DPAA2_FLOW_QOS_TYPE)
-		key_profile = &priv->extract.qos_key_extract.key_profile;
-	else
-		key_profile = &priv->extract.tc_key_extract[tc_id].key_profile;
+	index = dpaa2_flow_extract_search(key_profile, DPAA2_PR_KEY, NET_PROT_NONE, pr_field);
+	if (index < 0) {
+		ret = dpaa2_flow_extract_add_soft_psr(flow, pr_offset, pr_size, NULL);
+		if (ret) {
+			DPAA2_PMD_ERR("Failed(%d) to add off(%d)/size(%d) of PSR",
+				ret, pr_offset, pr_size);
 
-	num = key_profile->num;
+			return ret;
+		}
+		if (recfg)
+			*recfg = true;
+	}
 
-	if (num >= DPKG_MAX_NUM_OF_EXTRACTS) {
-		DPAA2_PMD_ERR("Number of extracts overflows");
-		return -EINVAL;
+	if (!flow->key_addr || !flow->mask_addr)
+		return 0;
+
+	return dpaa2_flow_pr_rule_data_set(flow, pr_offset, pr_size, key, mask, flow->type);
+}
+
+static int
+dpaa2_flow_tunnel_eth_extract_rule_set(struct dpaa2_generic_flow *flow,
+	const struct rte_flow_item *pattern,
+	const struct dpaa2_flow_proto_handle *hd, int *ecfg)
+{
+	int ret;
+	uint32_t i;
+	const struct rte_flow_item_eth *spec, *mask;
+	const void *_mask;
+	const char zero_cmp[RTE_ETHER_ADDR_LEN] = {0};
+	const uint32_t src_eth_offset[] = {
+		DPAA2_VXLAN_IN_SADDR0_OFFSET,
+		DPAA2_VXLAN_IN_SADDR1_OFFSET,
+		DPAA2_VXLAN_IN_SADDR2_OFFSET,
+		DPAA2_VXLAN_IN_SADDR3_OFFSET,
+		DPAA2_VXLAN_IN_SADDR4_OFFSET,
+		DPAA2_VXLAN_IN_SADDR5_OFFSET
+	};
+	const uint32_t dst_eth_offset[] = {
+		DPAA2_VXLAN_IN_DADDR0_OFFSET,
+		DPAA2_VXLAN_IN_DADDR1_OFFSET,
+		DPAA2_VXLAN_IN_DADDR2_OFFSET,
+		DPAA2_VXLAN_IN_DADDR3_OFFSET,
+		DPAA2_VXLAN_IN_DADDR4_OFFSET,
+		DPAA2_VXLAN_IN_DADDR5_OFFSET
+	};
+
+	if (!pattern->spec)
+		return 0;
+
+	/* Parse pattern list to get the matching parameters */
+	spec = pattern->spec;
+	mask = pattern->mask ? pattern->mask : hd->mask_support;
+	_mask = mask;
+
+	ret = dpaa2_flow_extract_support(_mask, hd->mask_support, hd->hdr_size);
+	if (ret)
+		return ret;
+
+	if (memcmp((const char *)&mask->src, zero_cmp, RTE_ETHER_ADDR_LEN)) {
+		for (i = 0; i < RTE_DIM(src_eth_offset); i++) {
+			ret = dpaa2_flow_add_soft_psr_extract_rule(flow,
+				src_eth_offset[i], 1, &spec->src.addr_bytes[i],
+				&mask->src.addr_bytes[i], ecfg);
+			if (ret)
+				return ret;
+		}
 	}
 
-	if (key_profile->ip_addr_type != IP_NONE_ADDR_EXTRACT) {
-		offset = key_profile->ip_addr_extract_off;
-		pos = key_profile->ip_addr_extract_pos;
-		key_profile->ip_addr_extract_pos++;
-		key_profile->ip_addr_extract_off += pr_size;
-		if (dist_type == DPAA2_FLOW_QOS_TYPE) {
-			ret = dpaa2_flow_qos_rule_insert_hole(priv,
-					offset, pr_size);
-		} else {
-			ret = dpaa2_flow_fs_rule_insert_hole(priv,
-				offset, pr_size, tc_id);
+	if (memcmp((const char *)&mask->dst, zero_cmp, RTE_ETHER_ADDR_LEN)) {
+		for (i = 0; i < RTE_DIM(dst_eth_offset); i++) {
+			ret = dpaa2_flow_add_soft_psr_extract_rule(flow,
+				dst_eth_offset[i], 1, &spec->dst.addr_bytes[i],
+				&mask->dst.addr_bytes[i], ecfg);
+			if (ret)
+				return ret;
 		}
+	}
+
+	if (memcmp((const char *)&mask->type, zero_cmp, sizeof(rte_be16_t))) {
+		ret = dpaa2_flow_add_soft_psr_extract_rule(flow,
+			DPAA2_VXLAN_IN_TYPE_OFFSET, sizeof(rte_be16_t),
+			&spec->type, &mask->type, ecfg);
 		if (ret)
 			return ret;
-	} else {
-		pos = num;
 	}
 
-	if (pos > 0) {
-		key_profile->key_offset[pos] =
-			key_profile->key_offset[pos - 1] +
-			key_profile->key_size[pos - 1];
-	} else {
-		key_profile->key_offset[pos] = 0;
+	return 0;
+}
+
+static int
+dpaa2_flow_tunnel_vlan_extract_rule_set(struct dpaa2_generic_flow *flow,
+	const struct rte_flow_item *pattern,
+	const struct dpaa2_flow_proto_handle *hd, int *ecfg)
+{
+	int ret;
+	const struct rte_flow_item_vlan *spec, *mask;
+	const void *_mask;
+	uint32_t bit_offset;
+
+	spec = pattern->spec;
+	mask = pattern->mask ? pattern->mask : hd->mask_support;
+	_mask = mask;
+
+	if (!spec) {
+		ret = dpaa2_protocol_psr_bit_offset(&bit_offset, hd->tunnel_id);
+		if (ret)
+			return ret;
+
+		return dpaa2_flow_identify_by_faf(flow, bit_offset, ecfg);
 	}
 
-	key_profile->key_size[pos] = pr_size;
-	key_profile->prot_field[pos].type = DPAA2_PR_KEY;
-	key_profile->prot_field[pos].key_field =
-		(pr_offset << 16) | pr_size;
-	key_profile->num++;
+	ret = dpaa2_flow_extract_support(_mask, hd->mask_support, hd->hdr_size);
+	if (ret)
+		return ret;
 
-	if (insert_offset)
-		*insert_offset = key_profile->key_offset[pos];
+	if (!mask->tci)
+		return 0;
 
-	key_profile->key_max_size += pr_size;
+	return dpaa2_flow_add_soft_psr_extract_rule(flow,
+			DPAA2_VXLAN_IN_TCI_OFFSET, sizeof(rte_be16_t),
+			&spec->tci, &mask->tci, ecfg);
+}
 
-	return pos;
+static int
+dpaa2_flow_add_ipaddr_extract_rule(struct dpaa2_generic_flow *flow,
+	enum net_prot prot, uint32_t field,
+	const void *key, const void *mask, int size, int *recfg)
+{
+	return dpaa2_profile_insert_ipaddr_extract(dpaa2_flow_key_profile(flow),
+		prot, field, flow->key_addr, flow->mask_addr, key, mask, size,
+		&flow->rule_size, recfg);
 }
 
 /* Move IPv4/IPv6 addresses to fill new extract previous IP address.
@@ -830,262 +838,154 @@ dpaa2_flow_pr_advance(struct dpaa2_dev_priv *priv,
  * the extracts position following them can't be identified.
  */
 static int
-dpaa2_flow_key_profile_advance(enum net_prot prot,
-	uint32_t field, uint8_t field_size,
-	struct dpaa2_dev_priv *priv,
-	enum dpaa2_flow_dist_type dist_type, int tc_id,
-	int *insert_offset)
+dpaa2_flow_key_profile_advance(struct dpaa2_generic_flow *flow,
+	enum net_prot prot, uint32_t field, uint8_t field_size, int *insert_offset)
 {
-	int offset, ret;
-	struct dpaa2_key_profile *key_profile;
-	int num, pos;
-
-	if (dpaa2_flow_ip_address_extract(prot, field)) {
-		DPAA2_PMD_ERR("%s only for none IP address extract",
-			__func__);
-		return -EINVAL;
-	}
-
-	if (dist_type == DPAA2_FLOW_QOS_TYPE)
-		key_profile = &priv->extract.qos_key_extract.key_profile;
-	else
-		key_profile = &priv->extract.tc_key_extract[tc_id].key_profile;
-
-	num = key_profile->num;
+	struct dpaa2_key_profile *key_profile = dpaa2_flow_key_profile(flow);
+	struct dpkg_extract l4_port_search;
+	uint8_t idx, offset = 0xff;
+	int l4_idx;
+	struct key_prot_field prot_field;
 
-	if (num >= DPKG_MAX_NUM_OF_EXTRACTS) {
+	if (key_profile->dpkg.num_extracts >= DPKG_MAX_NUM_OF_EXTRACTS) {
 		DPAA2_PMD_ERR("Number of extracts overflows");
 		return -EINVAL;
 	}
 
-	if (key_profile->ip_addr_type != IP_NONE_ADDR_EXTRACT) {
-		offset = key_profile->ip_addr_extract_off;
-		pos = key_profile->ip_addr_extract_pos;
-		key_profile->ip_addr_extract_pos++;
-		key_profile->ip_addr_extract_off += field_size;
-		if (dist_type == DPAA2_FLOW_QOS_TYPE) {
-			ret = dpaa2_flow_qos_rule_insert_hole(priv,
-					offset, field_size);
-		} else {
-			ret = dpaa2_flow_fs_rule_insert_hole(priv,
-				offset, field_size, tc_id);
-		}
-		if (ret)
-			return ret;
-	} else {
-		pos = num;
-	}
-
-	if (pos > 0) {
-		key_profile->key_offset[pos] =
-			key_profile->key_offset[pos - 1] +
-			key_profile->key_size[pos - 1];
-	} else {
-		key_profile->key_offset[pos] = 0;
-	}
-
-	key_profile->key_size[pos] = field_size;
-	key_profile->prot_field[pos].type = DPAA2_NET_PROT_KEY;
-	key_profile->prot_field[pos].prot = prot;
-	key_profile->prot_field[pos].key_field = field;
-	key_profile->num++;
+	prot_field.type = DPAA2_NET_PROT_KEY;
+	prot_field.prot = prot;
+	prot_field.key_field = field;
+	idx = dpaa2_profile_insert_no_ipaddr_extract(key_profile,
+		field_size, &offset, insert_offset, &prot_field);
+	if (offset != 0xff)
+		dpaa2_flow_rule_insert_hole(flow, offset, field_size);
 
-	if (insert_offset)
-		*insert_offset = key_profile->key_offset[pos];
-
-	if (dpaa2_flow_l4_src_port_extract(prot, field)) {
-		key_profile->l4_src_port_present = 1;
-		key_profile->l4_src_port_pos = pos;
-		key_profile->l4_src_port_offset =
-			key_profile->key_offset[pos];
-	} else if (dpaa2_flow_l4_dst_port_extract(prot, field)) {
-		key_profile->l4_dst_port_present = 1;
-		key_profile->l4_dst_port_pos = pos;
-		key_profile->l4_dst_port_offset =
-			key_profile->key_offset[pos];
+	l4_port_search.type = DPKG_EXTRACT_FROM_HDR;
+	l4_port_search.extract.from_hdr.prot = prot;
+	l4_port_search.extract.from_hdr.field = field;
+	l4_idx = dpaa2_flow_l4_port_extract(&l4_port_search);
+	if (l4_idx >= 0) {
+		key_profile->l4_port[l4_idx].present = true;
+		key_profile->l4_port[l4_idx].extract_idx = idx;
+		key_profile->l4_port[l4_idx].key_offset = key_profile->prot_field[idx].key_offset;
 	}
-	key_profile->key_max_size += field_size;
 
-	return pos;
+	return idx;
 }
 
 static int
-dpaa2_flow_faf_add_hdr(int faf_byte,
-	struct dpaa2_dev_priv *priv,
-	enum dpaa2_flow_dist_type dist_type, int tc_id,
-	int *insert_offset)
+dpaa2_flow_extract_add_hdr(struct dpaa2_generic_flow *flow,
+	enum net_prot prot, uint32_t field, uint8_t field_size, int *insert_offset)
 {
-	int pos, i, offset;
-	struct dpaa2_key_extract *key_extract;
-	struct dpkg_profile_cfg *dpkg;
-	struct dpkg_extract *extracts;
-
-	if (dist_type == DPAA2_FLOW_QOS_TYPE)
-		key_extract = &priv->extract.qos_key_extract;
-	else
-		key_extract = &priv->extract.tc_key_extract[tc_id];
-
-	dpkg = &key_extract->dpkg;
-	extracts = dpkg->extracts;
+	int extract_idx;
+	struct dpaa2_key_profile *key_profile = dpaa2_flow_key_profile(flow);
+	struct dpkg_extract extract;
 
-	if (dpkg->num_extracts >= DPKG_MAX_NUM_OF_EXTRACTS) {
+	if (key_profile->dpkg.num_extracts >= DPKG_MAX_NUM_OF_EXTRACTS) {
 		DPAA2_PMD_ERR("Number of extracts overflows");
 		return -EINVAL;
 	}
 
-	pos = dpaa2_flow_faf_advance(priv,
-			faf_byte, dist_type, tc_id,
-			insert_offset);
-	if (pos < 0)
-		return pos;
-
-	if (pos != dpkg->num_extracts) {
-		/* Not the last pos, must have IP address extract.*/
-		for (i = dpkg->num_extracts - 1; i >= pos; i--) {
-			extracts[i + 1] = extracts[i];
-		}
-	}
-
-	offset = DPAA2_FAFE_PSR_OFFSET + faf_byte;
+	extract_idx = dpaa2_flow_key_profile_advance(flow, prot,
+		field, field_size, insert_offset);
+	if (extract_idx < 0)
+		return extract_idx;
 
-	extracts[pos].type = DPKG_EXTRACT_FROM_PARSE;
-	extracts[pos].extract.from_parse.offset = offset;
-	extracts[pos].extract.from_parse.size = 1;
-
-	dpkg->num_extracts++;
+	memset(&extract, 0, sizeof(extract));
+	extract.type = DPKG_EXTRACT_FROM_HDR;
+	extract.extract.from_hdr.prot = prot;
+	extract.extract.from_hdr.type = DPKG_FULL_FIELD;
+	extract.extract.from_hdr.field = field;
+	dpaa2_dpkg_insert_extract(&key_profile->dpkg, extract_idx, &extract);
 
 	return 0;
 }
 
-static int
-dpaa2_flow_pr_add_hdr(uint32_t pr_offset,
-	uint32_t pr_size, struct dpaa2_dev_priv *priv,
-	enum dpaa2_flow_dist_type dist_type, int tc_id,
-	int *insert_offset)
+static inline int
+dpaa2_flow_hdr_rule_data_set(struct dpaa2_generic_flow *flow,
+	enum net_prot prot, uint32_t field, int size,
+	const void *key, const void *mask)
 {
-	int pos, i;
-	struct dpaa2_key_extract *key_extract;
-	struct dpkg_profile_cfg *dpkg;
-	struct dpkg_extract *extracts;
+	struct dpaa2_key_profile *key_profile = dpaa2_flow_key_profile(flow);
+	int offset, i;
+	char offset_info[64], size_info[64], rule_size_info[64];
 
-	if ((pr_offset + pr_size) > DPAA2_FAPR_SIZE) {
-		DPAA2_PMD_ERR("PR extracts(%d:%d) overflow",
-			pr_offset, pr_size);
+	offset = dpaa2_flow_extract_key_offset(key_profile,
+			DPAA2_NET_PROT_KEY, prot, field);
+	if (offset < 0) {
+		DPAA2_PMD_ERR("P(%d)/F(%d) does not exist!",
+			prot, field);
 		return -EINVAL;
 	}
+	snprintf(offset_info, 64, "offset(%d)", offset);
+	snprintf(size_info, 64, "size(%d)", size);
 
-	if (dist_type == DPAA2_FLOW_QOS_TYPE)
-		key_extract = &priv->extract.qos_key_extract;
-	else
-		key_extract = &priv->extract.tc_key_extract[tc_id];
-
-	dpkg = &key_extract->dpkg;
-	extracts = dpkg->extracts;
+	snprintf(rule_size_info, 64, "%s rule size(%d)",
+		flow->type == DPAA2_FLOW_QOS_TYPE ? "QoS" : "FS",
+		flow->rule_size);
 
-	if (dpkg->num_extracts >= DPKG_MAX_NUM_OF_EXTRACTS) {
-		DPAA2_PMD_ERR("Number of extracts overflows");
-		return -EINVAL;
+	for (i = 0; i < size; i++) {
+		*(flow->key_addr + offset + i) |= *((const uint8_t *)key + i);
+		*(flow->mask_addr + offset + i) |= *((const uint8_t *)mask + i);
 	}
-
-	pos = dpaa2_flow_pr_advance(priv,
-			pr_offset, pr_size, dist_type, tc_id,
-			insert_offset);
-	if (pos < 0)
-		return pos;
-
-	if (pos != dpkg->num_extracts) {
-		/* Not the last pos, must have IP address extract.*/
-		for (i = dpkg->num_extracts - 1; i >= pos; i--) {
-			extracts[i + 1] = extracts[i];
+	if (!(flow->ip_src || flow->ip_dst)) {
+		if (offset >= flow->rule_size) {
+			flow->rule_size = offset + size;
+		} else if ((offset + size) > flow->rule_size) {
+			DPAA2_PMD_ERR("%s: %s < %s, but %s + %s > %s",
+				__func__, offset_info, rule_size_info,
+				offset_info, size_info, rule_size_info);
+			return -EINVAL;
 		}
 	}
 
-	extracts[pos].type = DPKG_EXTRACT_FROM_PARSE;
-	extracts[pos].extract.from_parse.offset = pr_offset;
-	extracts[pos].extract.from_parse.size = pr_size;
-
-	dpkg->num_extracts++;
-
 	return 0;
 }
 
 static int
-dpaa2_flow_extract_add_hdr(enum net_prot prot,
-	uint32_t field, uint8_t field_size,
-	struct dpaa2_dev_priv *priv,
-	enum dpaa2_flow_dist_type dist_type, int tc_id,
-	int *insert_offset)
+dpaa2_flow_add_hdr_extract_rule(struct dpaa2_generic_flow *flow,
+	enum net_prot prot, uint32_t field,
+	const void *key, const void *mask, int size, int *recfg)
 {
-	int pos, i;
-	struct dpaa2_key_extract *key_extract;
-	struct dpkg_profile_cfg *dpkg;
-	struct dpkg_extract *extracts;
-
-	if (dist_type == DPAA2_FLOW_QOS_TYPE)
-		key_extract = &priv->extract.qos_key_extract;
-	else
-		key_extract = &priv->extract.tc_key_extract[tc_id];
+	int index, ret = 0;
+	struct dpaa2_key_profile *key_profile = dpaa2_flow_key_profile(flow);
 
-	dpkg = &key_extract->dpkg;
-	extracts = dpkg->extracts;
+	index = dpaa2_flow_extract_search(key_profile, DPAA2_NET_PROT_KEY, prot, field);
+	if (index < 0) {
+		ret = dpaa2_flow_extract_add_hdr(flow, prot, field, size, NULL);
+		if (ret) {
+			DPAA2_PMD_ERR("QoS Extract P(%d)/F(%d) failed", prot, field);
 
-	if (dpaa2_flow_ip_address_extract(prot, field)) {
-		DPAA2_PMD_ERR("%s only for none IP address extract",
-			__func__);
-		return -EINVAL;
+			return ret;
+		}
+		if (recfg)
+			(*recfg) = true;
 	}
 
-	if (dpkg->num_extracts >= DPKG_MAX_NUM_OF_EXTRACTS) {
-		DPAA2_PMD_ERR("Number of extracts overflows");
-		return -EINVAL;
+	if (!flow->key_addr || !flow->mask_addr) {
+		/** None steering flow, no rule data specified.*/
+		return 0;
 	}
 
-	pos = dpaa2_flow_key_profile_advance(prot,
-			field, field_size, priv,
-			dist_type, tc_id,
-			insert_offset);
-	if (pos < 0)
-		return pos;
-
-	if (pos != dpkg->num_extracts) {
-		/* Not the last pos, must have IP address extract.*/
-		for (i = dpkg->num_extracts - 1; i >= pos; i--) {
-			extracts[i + 1] = extracts[i];
-		}
+	ret = dpaa2_flow_hdr_rule_data_set(flow, prot, field, size, key, mask);
+	if (ret) {
+		DPAA2_PMD_ERR("%s P(%d)/F(%d) rule data set failed",
+			flow->type == DPAA2_FLOW_QOS_TYPE ? "QoS" : "FS",
+			prot, field);
 	}
 
-	extracts[pos].type = DPKG_EXTRACT_FROM_HDR;
-	extracts[pos].extract.from_hdr.prot = prot;
-	extracts[pos].extract.from_hdr.type = DPKG_FULL_FIELD;
-	extracts[pos].extract.from_hdr.field = field;
-
-	dpkg->num_extracts++;
-
-	return 0;
+	return ret;
 }
 
 static int
-dpaa2_flow_extract_new_raw(struct dpaa2_dev_priv *priv,
-	int offset, int size,
-	enum dpaa2_flow_dist_type dist_type, int tc_id)
+_dpaa2_flow_extract_add_raw(struct dpaa2_generic_flow *flow,
+	int offset, int size)
 {
-	struct dpaa2_key_extract *key_extract;
-	struct dpkg_profile_cfg *dpkg;
-	struct dpaa2_key_profile *key_profile;
-	int last_extract_size, index, pos, item_size;
+	struct dpaa2_key_profile *key_profile = dpaa2_flow_key_profile(flow);
+	int last_extract_size, index, raw_idx, item_size;
 	uint8_t num_extracts;
 	uint32_t field;
-
-	if (dist_type == DPAA2_FLOW_QOS_TYPE)
-		key_extract = &priv->extract.qos_key_extract;
-	else
-		key_extract = &priv->extract.tc_key_extract[tc_id];
-
-	dpkg = &key_extract->dpkg;
-	key_profile = &key_extract->key_profile;
-
-	key_profile->raw_region.raw_start = 0;
-	key_profile->raw_region.raw_size = 0;
+	int ret;
 
 	last_extract_size = (size % DPAA2_FLOW_MAX_KEY_SIZE);
 	num_extracts = (size / DPAA2_FLOW_MAX_KEY_SIZE);
@@ -1094,6 +994,11 @@ dpaa2_flow_extract_new_raw(struct dpaa2_dev_priv *priv,
 	else
 		last_extract_size = DPAA2_FLOW_MAX_KEY_SIZE;
 
+	if ((key_profile->dpkg.num_extracts + num_extracts) > DPKG_MAX_NUM_OF_EXTRACTS) {
+		DPAA2_PMD_ERR("Failed to expand raw extracts");
+		return -EINVAL;
+	}
+
 	for (index = 0; index < num_extracts; index++) {
 		if (index == num_extracts - 1)
 			item_size = last_extract_size;
@@ -1102,531 +1007,366 @@ dpaa2_flow_extract_new_raw(struct dpaa2_dev_priv *priv,
 		field = offset << DPAA2_FLOW_RAW_OFFSET_FIELD_SHIFT;
 		field |= item_size;
 
-		pos = dpaa2_flow_key_profile_advance(NET_PROT_PAYLOAD,
-				field, item_size, priv, dist_type,
-				tc_id, NULL);
-		if (pos < 0)
-			return pos;
-
-		dpkg->extracts[pos].type = DPKG_EXTRACT_FROM_DATA;
-		dpkg->extracts[pos].extract.from_data.size = item_size;
-		dpkg->extracts[pos].extract.from_data.offset = offset;
-
-		if (index == 0) {
-			key_profile->raw_extract_pos = pos;
-			key_profile->raw_extract_off =
-				key_profile->key_offset[pos];
-			key_profile->raw_region.raw_start = offset;
+		ret = dpaa2_flow_extract_search(key_profile,
+			DPAA2_NET_PROT_KEY, NET_PROT_PAYLOAD, field);
+		if (ret >= 0) {
+			offset += item_size;
+			continue;
 		}
-		key_profile->raw_extract_num++;
-		key_profile->raw_region.raw_size +=
-			key_profile->key_size[pos];
+
+		raw_idx = dpaa2_flow_key_profile_advance(flow, NET_PROT_PAYLOAD,
+			field, item_size, NULL);
+		if (raw_idx < 0)
+			return raw_idx;
+
+		key_profile->dpkg.extracts[raw_idx].type = DPKG_EXTRACT_FROM_DATA;
+		key_profile->dpkg.extracts[raw_idx].extract.from_data.size = item_size;
+		key_profile->dpkg.extracts[raw_idx].extract.from_data.offset = offset;
 
 		offset += item_size;
-		dpkg->num_extracts++;
+		key_profile->dpkg.num_extracts++;
 	}
 
 	return 0;
 }
 
 static int
-dpaa2_flow_extract_add_raw(struct dpaa2_dev_priv *priv,
-	int offset, int size, enum dpaa2_flow_dist_type dist_type,
-	int tc_id, int *recfg)
+dpaa2_flow_extract_add_raw(struct dpaa2_generic_flow *flow,
+	int offset, int size, int *recfg)
 {
-	struct dpaa2_key_profile *key_profile;
-	struct dpaa2_raw_region *raw_region;
-	int end = offset + size, ret = 0, extract_extended, sz_extend;
-	int start_cmp, end_cmp, new_size, index, pos, end_pos;
-	int last_extract_size, item_size, num_extracts, bk_num = 0;
-	struct dpkg_extract extract_bk[DPKG_MAX_NUM_OF_EXTRACTS];
-	uint8_t key_offset_bk[DPKG_MAX_NUM_OF_EXTRACTS];
-	uint8_t key_size_bk[DPKG_MAX_NUM_OF_EXTRACTS];
-	struct key_prot_field prot_field_bk[DPKG_MAX_NUM_OF_EXTRACTS];
-	struct dpaa2_raw_region raw_hole;
-	struct dpkg_profile_cfg *dpkg;
-	enum net_prot prot;
-	uint32_t field;
+	int ret;
 
-	if (dist_type == DPAA2_FLOW_QOS_TYPE) {
-		key_profile = &priv->extract.qos_key_extract.key_profile;
-		dpkg = &priv->extract.qos_key_extract.dpkg;
+	ret = _dpaa2_flow_extract_add_raw(flow, offset, size);
+	if (!ret && recfg)
+		(*recfg) |= true;
+
+	return ret;
+}
+
+static int
+dpaa2_flow_ip_fields_extract_rule_set(struct dpaa2_generic_flow *flow,
+	const struct dpaa2_flow_proto_handle *hd, uint8_t idx,
+	const uint8_t *spec_u8, const uint8_t *mask_u8, int *ecfg)
+{
+	int ret;
+	uint32_t bit_offset;
+	const char zero_cmp[128] = {0};
+	const uint8_t ipv4_src_offset = offsetof(struct rte_flow_item_ipv4, hdr.src_addr);
+	const uint8_t ipv4_dst_offset = offsetof(struct rte_flow_item_ipv4, hdr.dst_addr);
+	const uint8_t ipv6_src_offset = offsetof(struct rte_flow_item_ipv6, hdr.src_addr);
+	const uint8_t ipv6_dst_offset = offsetof(struct rte_flow_item_ipv6, hdr.dst_addr);
+	const uint8_t ipv4_frag_offset = offsetof(struct rte_flow_item_ipv4, hdr.fragment_offset);
+
+	if ((hd->item_type == RTE_FLOW_ITEM_TYPE_IPV4 &&
+		(hd->field_offset[idx] == ipv4_src_offset ||
+		hd->field_offset[idx] == ipv4_dst_offset)) ||
+		(hd->item_type == RTE_FLOW_ITEM_TYPE_IPV6 &&
+		(hd->field_offset[idx] == ipv6_src_offset ||
+		hd->field_offset[idx] == ipv6_dst_offset))) {
+		ret = dpaa2_flow_add_ipaddr_extract_rule(flow, hd->prot, hd->fields[idx],
+			spec_u8 + hd->field_offset[idx], mask_u8 + hd->field_offset[idx],
+			hd->field_size[idx], ecfg);
+		if (ret)
+			return ret;
+		if ((hd->item_type == RTE_FLOW_ITEM_TYPE_IPV4 &&
+			hd->field_offset[idx] == ipv4_src_offset) ||
+			(hd->item_type == RTE_FLOW_ITEM_TYPE_IPV6 &&
+			hd->field_offset[idx] == ipv6_src_offset))
+			flow->ip_src = NET_PROT_IPV4;
+		else
+			flow->ip_dst = NET_PROT_IPV4;
+	} else if (hd->item_type == RTE_FLOW_ITEM_TYPE_IPV4 &&
+		hd->field_offset[idx] == ipv4_frag_offset) {
+		if (memcmp(spec_u8 + hd->field_offset[idx], zero_cmp, hd->field_size[idx]))
+			DPAA2_PMD_WARN("Unsupport Extract of frag offset");
+		ret = dpaa2_protocol_psr_bit_offset(&bit_offset, DPAA2_PARSER_IP_FRAG_ID);
+		if (ret)
+			return ret;
+
+		ret = dpaa2_flow_identify_by_faf(flow, bit_offset, ecfg);
+		if (ret)
+			return ret;
 	} else {
-		key_profile = &priv->extract.tc_key_extract[tc_id].key_profile;
-		dpkg = &priv->extract.tc_key_extract[tc_id].dpkg;
+		ret = dpaa2_flow_add_hdr_extract_rule(flow, hd->prot,
+			hd->fields[idx], spec_u8 + hd->field_offset[idx],
+			mask_u8 + hd->field_offset[idx], hd->field_size[idx], ecfg);
+		if (ret)
+			return ret;
 	}
 
-	raw_region = &key_profile->raw_region;
-	if (!raw_region->raw_size) {
-		/* New RAW region*/
-		ret = dpaa2_flow_extract_new_raw(priv, offset, size,
-			dist_type, tc_id);
-		if (!ret && recfg)
-			(*recfg) |= dist_type;
+	return 0;
+}
+
+static int
+dpaa2_flow_ip_extract_rule_set(struct dpaa2_generic_flow *flow,
+	const struct rte_flow_item *pattern,
+	const struct dpaa2_flow_proto_handle *hd, int *ecfg)
+{
+	int ret, i;
+	uint32_t bit_offset;
+	const void *spec, *mask;
+	const uint8_t *mask_u8;
+	const char zero_cmp[128] = {0};
+
+	spec = pattern->spec;
+	mask = pattern->mask ? pattern->mask : hd->mask_support;
 
+	ret = dpaa2_protocol_psr_bit_offset(&bit_offset, hd->protocol_id);
+	if (ret)
 		return ret;
-	}
-	start_cmp = raw_region->raw_start;
-	end_cmp = raw_region->raw_start + raw_region->raw_size;
 
-	if (offset >= start_cmp && end <= end_cmp)
-		return 0;
+	ret = dpaa2_flow_identify_by_faf(flow, bit_offset, ecfg);
+	if (ret)
+		return ret;
 
-	sz_extend = 0;
-	new_size = raw_region->raw_size;
-	if (offset < start_cmp) {
-		sz_extend += start_cmp - offset;
-		new_size += (start_cmp - offset);
-	}
-	if (end > end_cmp) {
-		sz_extend += end - end_cmp;
-		new_size += (end - end_cmp);
-	}
+	if (!spec)
+		goto skip_parse_spec;
 
-	last_extract_size = (new_size % DPAA2_FLOW_MAX_KEY_SIZE);
-	num_extracts = (new_size / DPAA2_FLOW_MAX_KEY_SIZE);
-	if (last_extract_size)
-		num_extracts++;
-	else
-		last_extract_size = DPAA2_FLOW_MAX_KEY_SIZE;
+	ret = dpaa2_flow_extract_support(mask, hd->mask_support, hd->hdr_size);
+	if (ret)
+		return ret;
 
-	if ((key_profile->num + num_extracts -
-		key_profile->raw_extract_num) >=
-		DPKG_MAX_NUM_OF_EXTRACTS) {
-		DPAA2_PMD_ERR("%s Failed to expand raw extracts",
-			__func__);
-		return -EINVAL;
+	mask_u8 = mask;
+	for (i = 0; i < hd->fields_num; i++) {
+		if (!memcmp(mask_u8 + hd->field_offset[i], zero_cmp, hd->field_size[i]))
+			continue;
+		ret = dpaa2_flow_ip_fields_extract_rule_set(flow, hd, i, spec, mask, ecfg);
+		if (ret)
+			return ret;
 	}
 
-	if (offset < start_cmp) {
-		raw_hole.raw_start = key_profile->raw_extract_off;
-		raw_hole.raw_size = start_cmp - offset;
-		raw_region->raw_start = offset;
-		raw_region->raw_size += start_cmp - offset;
+skip_parse_spec:
+	if (hd->item_type == RTE_FLOW_ITEM_TYPE_IPV4)
+		flow->ip_key = NET_PROT_IPV4;
+	else
+		flow->ip_key = NET_PROT_IPV6;
 
-		if (dist_type & DPAA2_FLOW_QOS_TYPE) {
-			ret = dpaa2_flow_qos_rule_insert_hole(priv,
-					raw_hole.raw_start,
-					raw_hole.raw_size);
-			if (ret)
-				return ret;
-		}
-		if (dist_type & DPAA2_FLOW_FS_TYPE) {
-			ret = dpaa2_flow_fs_rule_insert_hole(priv,
-					raw_hole.raw_start,
-					raw_hole.raw_size, tc_id);
-			if (ret)
-				return ret;
-		}
-	}
+	return 0;
+}
 
-	if (end > end_cmp) {
-		raw_hole.raw_start =
-			key_profile->raw_extract_off +
-			raw_region->raw_size;
-		raw_hole.raw_size = end - end_cmp;
-		raw_region->raw_size += end - end_cmp;
+static int
+dpaa2_flow_vxlan_extract_rule_set(struct dpaa2_generic_flow *flow,
+	const struct rte_flow_item *pattern,
+	const struct dpaa2_flow_proto_handle *hd, int *ecfg)
+{
+	int ret;
+	uint32_t bit_offset;
+	const struct rte_flow_item_vxlan *spec, *mask;
+	const void *_mask;
+	struct dpaa2_dev_priv *priv = flow->priv;
 
-		if (dist_type & DPAA2_FLOW_QOS_TYPE) {
-			ret = dpaa2_flow_qos_rule_insert_hole(priv,
-					raw_hole.raw_start,
-					raw_hole.raw_size);
-			if (ret)
-				return ret;
-		}
-		if (dist_type & DPAA2_FLOW_FS_TYPE) {
-			ret = dpaa2_flow_fs_rule_insert_hole(priv,
-					raw_hole.raw_start,
-					raw_hole.raw_size, tc_id);
-			if (ret)
-				return ret;
-		}
-	}
+	/* Parse pattern list to get the matching parameters */
+	spec = pattern->spec;
+	mask = pattern->mask ? pattern->mask : hd->mask_support;
+	_mask = mask;
 
-	end_pos = key_profile->raw_extract_pos +
-		key_profile->raw_extract_num;
-	if (key_profile->num > end_pos) {
-		bk_num = key_profile->num - end_pos;
-		memcpy(extract_bk, &dpkg->extracts[end_pos],
-			bk_num * sizeof(struct dpkg_extract));
-		memcpy(key_offset_bk, &key_profile->key_offset[end_pos],
-			bk_num * sizeof(uint8_t));
-		memcpy(key_size_bk, &key_profile->key_size[end_pos],
-			bk_num * sizeof(uint8_t));
-		memcpy(prot_field_bk, &key_profile->prot_field[end_pos],
-			bk_num * sizeof(struct key_prot_field));
-
-		for (index = 0; index < bk_num; index++) {
-			key_offset_bk[index] += sz_extend;
-			prot = prot_field_bk[index].prot;
-			field = prot_field_bk[index].key_field;
-			if (dpaa2_flow_l4_src_port_extract(prot,
-				field)) {
-				key_profile->l4_src_port_present = 1;
-				key_profile->l4_src_port_pos = end_pos + index;
-				key_profile->l4_src_port_offset =
-					key_offset_bk[index];
-			} else if (dpaa2_flow_l4_dst_port_extract(prot,
-				field)) {
-				key_profile->l4_dst_port_present = 1;
-				key_profile->l4_dst_port_pos = end_pos + index;
-				key_profile->l4_dst_port_offset =
-					key_offset_bk[index];
-			}
-		}
-	}
+	ret = dpaa2_protocol_psr_bit_offset(&bit_offset, hd->protocol_id);
+	if (ret)
+		return ret;
 
-	pos = key_profile->raw_extract_pos;
+	ret = dpaa2_flow_identify_by_faf(flow, bit_offset, ecfg);
+	if (ret)
+		return ret;
 
-	for (index = 0; index < num_extracts; index++) {
-		if (index == num_extracts - 1)
-			item_size = last_extract_size;
-		else
-			item_size = DPAA2_FLOW_MAX_KEY_SIZE;
-		field = offset << DPAA2_FLOW_RAW_OFFSET_FIELD_SHIFT;
-		field |= item_size;
+	if (!spec)
+		return 0;
 
-		if (pos > 0) {
-			key_profile->key_offset[pos] =
-				key_profile->key_offset[pos - 1] +
-				key_profile->key_size[pos - 1];
-		} else {
-			key_profile->key_offset[pos] = 0;
-		}
-		key_profile->key_size[pos] = item_size;
-		key_profile->prot_field[pos].type = DPAA2_NET_PROT_KEY;
-		key_profile->prot_field[pos].prot = NET_PROT_PAYLOAD;
-		key_profile->prot_field[pos].key_field = field;
-
-		dpkg->extracts[pos].type = DPKG_EXTRACT_FROM_DATA;
-		dpkg->extracts[pos].extract.from_data.size = item_size;
-		dpkg->extracts[pos].extract.from_data.offset = offset;
-		offset += item_size;
-		pos++;
+	if (!priv->sp_protocol) {
+		DPAA2_PMD_ERR("vXLAN flow with spec is not supported without SP.");
+		return -ENOTSUP;
 	}
 
-	if (bk_num) {
-		memcpy(&dpkg->extracts[pos], extract_bk,
-			bk_num * sizeof(struct dpkg_extract));
-		memcpy(&key_profile->key_offset[end_pos],
-			key_offset_bk, bk_num * sizeof(uint8_t));
-		memcpy(&key_profile->key_size[end_pos],
-			key_size_bk, bk_num * sizeof(uint8_t));
-		memcpy(&key_profile->prot_field[end_pos],
-			prot_field_bk, bk_num * sizeof(struct key_prot_field));
-	}
+	ret = dpaa2_flow_extract_support(_mask, hd->mask_support, hd->hdr_size);
+	if (ret)
+		return ret;
 
-	extract_extended = num_extracts - key_profile->raw_extract_num;
-	if (key_profile->ip_addr_type != IP_NONE_ADDR_EXTRACT) {
-		key_profile->ip_addr_extract_pos += extract_extended;
-		key_profile->ip_addr_extract_off += sz_extend;
+	if (mask->flags) {
+		if (spec->flags != VXLAN_HF_VNI) {
+			DPAA2_PMD_ERR("vxlan flag(0x%02x) must be 0x%02x.",
+				spec->flags, VXLAN_HF_VNI);
+			return -EINVAL;
+		}
+		if (mask->flags != 0xff) {
+			DPAA2_PMD_ERR("Not support to extract vxlan flag.");
+			return -EINVAL;
+		}
 	}
-	key_profile->raw_extract_num = num_extracts;
-	key_profile->num += extract_extended;
-	key_profile->key_max_size += sz_extend;
 
-	dpkg->num_extracts += extract_extended;
-	if (!ret && recfg)
-		(*recfg) |= dist_type;
+	if (mask->vni[0] || mask->vni[1] || mask->vni[2]) {
+		ret = dpaa2_flow_add_soft_psr_extract_rule(flow,
+			DPAA2_VXLAN_VNI_OFFSET, sizeof(mask->vni),
+			spec->vni, mask->vni, ecfg);
+		if (ret)
+			return ret;
+	}
 
-	return ret;
+	return 0;
 }
 
-static inline int
-dpaa2_flow_extract_search(struct dpaa2_key_profile *key_profile,
-	enum key_prot_type type, enum net_prot prot, uint32_t key_field)
+static int
+dpaa2_flow_ecpri_extract_rule_set(struct dpaa2_generic_flow *flow,
+	const struct rte_flow_item *pattern,
+	const struct dpaa2_flow_proto_handle *hd, int *ecfg)
 {
-	int pos;
-	struct key_prot_field *prot_field;
-
-	if (dpaa2_flow_ip_address_extract(prot, key_field)) {
-		DPAA2_PMD_ERR("%s only for none IP address extract",
-			__func__);
-		return -EINVAL;
-	}
+	int ret;
+	uint32_t bit_offset;
+	const struct rte_flow_item_ecpri *spec, *mask;
+	const void *_mask;
+	struct rte_flow_item_ecpri local_mask;
+	struct dpaa2_dev_priv *priv = flow->priv;
+	int extract_nb, i;
+	uint64_t rule_data[DPAA2_ECPRI_MAX_EXTRACT_NB];
+	uint64_t mask_data[DPAA2_ECPRI_MAX_EXTRACT_NB];
+	uint8_t extract_size[DPAA2_ECPRI_MAX_EXTRACT_NB];
+	uint8_t extract_off[DPAA2_ECPRI_MAX_EXTRACT_NB];
+	union dpaa2_sp_fafe_parse fafe;
 
-	prot_field = key_profile->prot_field;
-	for (pos = 0; pos < key_profile->num; pos++) {
-		if (type == DPAA2_NET_PROT_KEY &&
-			prot_field[pos].prot == prot &&
-			prot_field[pos].key_field == key_field &&
-			prot_field[pos].type == type)
-			return pos;
-		else if (type == DPAA2_FAF_KEY &&
-			prot_field[pos].key_field == key_field &&
-			prot_field[pos].type == type)
-			return pos;
-		else if (type == DPAA2_PR_KEY &&
-			prot_field[pos].key_field == key_field &&
-			prot_field[pos].type == type)
-			return pos;
+	if (!priv->sp_protocol) {
+		DPAA2_PMD_ERR("eCPRI flow is not supported without SP.");
+		return -ENOTSUP;
 	}
 
-	if (type == DPAA2_NET_PROT_KEY &&
-		dpaa2_flow_l4_src_port_extract(prot, key_field)) {
-		if (key_profile->l4_src_port_present)
-			return key_profile->l4_src_port_pos;
-	} else if (type == DPAA2_NET_PROT_KEY &&
-		dpaa2_flow_l4_dst_port_extract(prot, key_field)) {
-		if (key_profile->l4_dst_port_present)
-			return key_profile->l4_dst_port_pos;
+	/* Parse pattern list to get the matching parameters */
+	spec = pattern->spec;
+	if (pattern->mask) {
+		memcpy(&local_mask, pattern->mask, sizeof(struct rte_flow_item_ecpri));
+		local_mask.hdr.common.u32 = rte_be_to_cpu_32(local_mask.hdr.common.u32);
+		mask = &local_mask;
+	} else {
+		mask = hd->mask_support;
 	}
+	_mask = mask;
 
-	return -ENXIO;
-}
-
-static inline int
-dpaa2_flow_extract_key_offset(struct dpaa2_key_profile *key_profile,
-	enum key_prot_type type, enum net_prot prot, uint32_t key_field)
-{
-	int i;
-
-	i = dpaa2_flow_extract_search(key_profile, type, prot, key_field);
-	if (i >= 0)
-		return key_profile->key_offset[i];
-	else
-		return i;
-}
-
-static int
-dpaa2_flow_faf_add_rule(struct dpaa2_dev_priv *priv,
-	struct dpaa2_dev_flow *flow,
-	enum dpaa2_rx_faf_offset faf_bit_off,
-	int group,
-	enum dpaa2_flow_dist_type dist_type)
-{
-	int offset;
-	uint8_t *key_addr;
-	uint8_t *mask_addr;
-	struct dpaa2_key_extract *key_extract;
-	struct dpaa2_key_profile *key_profile;
-	uint8_t faf_byte = faf_bit_off / 8;
-	uint8_t faf_bit_in_byte = faf_bit_off % 8;
+	ret = dpaa2_protocol_psr_bit_offset(&bit_offset, hd->protocol_id);
+	if (ret)
+		return ret;
 
-	faf_bit_in_byte = 7 - faf_bit_in_byte;
+	ret = dpaa2_flow_identify_by_faf(flow, bit_offset, ecfg);
+	if (ret)
+		return ret;
 
-	if (dist_type & DPAA2_FLOW_QOS_TYPE) {
-		key_extract = &priv->extract.qos_key_extract;
-		key_profile = &key_extract->key_profile;
+	if (!spec)
+		return 0;
 
-		offset = dpaa2_flow_extract_key_offset(key_profile,
-				DPAA2_FAF_KEY, NET_PROT_NONE, faf_byte);
-		if (offset < 0) {
-			DPAA2_PMD_ERR("%s QoS key extract failed", __func__);
-			return -EINVAL;
-		}
-		key_addr = flow->qos_key_addr + offset;
-		mask_addr = flow->qos_mask_addr + offset;
+	ret = dpaa2_flow_extract_support(_mask, hd->mask_support, hd->hdr_size);
+	if (ret)
+		return ret;
 
-		if (!(*key_addr) &&
-			key_profile->ip_addr_type == IP_NONE_ADDR_EXTRACT &&
-			offset >= flow->qos_rule_size)
-			flow->qos_rule_size = offset + sizeof(uint8_t);
+	memset(&fafe, 0, sizeof(union dpaa2_sp_fafe_parse));
+	extract_nb = dpaa2_parser_ecpri_extract(spec, mask,
+		rule_data, mask_data, extract_size, extract_off,
+		&fafe, DPAA2_ECPRI_MAX_EXTRACT_NB);
+	if (extract_nb < 0) {
+		DPAA2_PMD_ERR("Extract eCPRI from spec/mask failed(%d)", extract_nb);
 
-		*key_addr |=  (1 << faf_bit_in_byte);
-		*mask_addr |=  (1 << faf_bit_in_byte);
+		return extract_nb;
 	}
 
-	if (dist_type & DPAA2_FLOW_FS_TYPE) {
-		key_extract = &priv->extract.tc_key_extract[group];
-		key_profile = &key_extract->key_profile;
-
-		offset = dpaa2_flow_extract_key_offset(key_profile,
-				DPAA2_FAF_KEY, NET_PROT_NONE, faf_byte);
-		if (offset < 0) {
-			DPAA2_PMD_ERR("%s TC[%d] key extract failed",
-				__func__, group);
-			return -EINVAL;
-		}
-		key_addr = flow->fs_key_addr + offset;
-		mask_addr = flow->fs_mask_addr + offset;
-
-		if (!(*key_addr) &&
-			key_profile->ip_addr_type == IP_NONE_ADDR_EXTRACT &&
-			offset >= flow->fs_rule_size)
-			flow->fs_rule_size = offset + sizeof(uint8_t);
-
-		*key_addr |=  (1 << faf_bit_in_byte);
-		*mask_addr |=  (1 << faf_bit_in_byte);
+	for (i = 0; i < extract_nb; i++) {
+		ret = dpaa2_flow_add_soft_psr_extract_rule(flow,
+			extract_off[i], extract_size[i],
+			&rule_data[i], &mask_data[i], ecfg);
+		if (ret)
+			return ret;
 	}
 
 	return 0;
 }
 
 static inline int
-dpaa2_flow_pr_rule_data_set(struct dpaa2_dev_flow *flow,
-	struct dpaa2_key_profile *key_profile,
-	uint32_t pr_offset, uint32_t pr_size,
-	const void *key, const void *mask,
-	enum dpaa2_flow_dist_type dist_type)
+dpaa2_flow_raw_rule_data_set(struct dpaa2_generic_flow *flow,
+	uint32_t extract_offset, int size, const void *key, const void *mask)
 {
-	int offset;
-	uint32_t pr_field = pr_offset << 16 | pr_size;
+	struct dpaa2_key_profile *key_profile = dpaa2_flow_key_profile(flow);
+	int extract_size = size > DPAA2_FLOW_MAX_KEY_SIZE ?
+		DPAA2_FLOW_MAX_KEY_SIZE : size;
+	int offset, field;
 	char offset_info[64], size_info[64], rule_size_info[64];
 
+	field = extract_offset << DPAA2_FLOW_RAW_OFFSET_FIELD_SHIFT;
+	field |= extract_size;
 	offset = dpaa2_flow_extract_key_offset(key_profile,
-			DPAA2_PR_KEY, NET_PROT_NONE, pr_field);
+			DPAA2_NET_PROT_KEY, NET_PROT_PAYLOAD, field);
 	if (offset < 0) {
-		DPAA2_PMD_ERR("PR off(%d)/size(%d) does not exist!",
-			pr_offset, pr_size);
+		DPAA2_PMD_ERR("offset(%d)/size(%d) raw extract failed",
+			extract_offset, size);
 		return -EINVAL;
 	}
-	sprintf(offset_info, "offset(%d)", offset);
-	sprintf(size_info, "size(%d)", pr_size);
-
-	if (dist_type & DPAA2_FLOW_QOS_TYPE) {
-		sprintf(rule_size_info, "qos rule size(%d)",
-			flow->qos_rule_size);
-		memcpy((flow->qos_key_addr + offset), key, pr_size);
-		memcpy((flow->qos_mask_addr + offset), mask, pr_size);
-		if (key_profile->ip_addr_type == IP_NONE_ADDR_EXTRACT) {
-			if (offset >= flow->qos_rule_size) {
-				flow->qos_rule_size = offset + pr_size;
-			} else if ((offset + pr_size) > flow->qos_rule_size) {
-				DPAA2_PMD_ERR("%s < %s, but %s + %s > %s",
-					offset_info, rule_size_info,
-					offset_info, size_info,
-					rule_size_info);
-				return -EINVAL;
-			}
-		}
-	}
-
-	if (dist_type & DPAA2_FLOW_FS_TYPE) {
-		sprintf(rule_size_info, "fs rule size(%d)",
-			flow->fs_rule_size);
-		memcpy((flow->fs_key_addr + offset), key, pr_size);
-		memcpy((flow->fs_mask_addr + offset), mask, pr_size);
-		if (key_profile->ip_addr_type == IP_NONE_ADDR_EXTRACT) {
-			if (offset >= flow->fs_rule_size) {
-				flow->fs_rule_size = offset + pr_size;
-			} else if ((offset + pr_size) > flow->fs_rule_size) {
-				DPAA2_PMD_ERR("%s < %s, but %s + %s > %s",
-					offset_info, rule_size_info,
-					offset_info, size_info,
-					rule_size_info);
-				return -EINVAL;
-			}
-		}
+	snprintf(offset_info, 64, "offset(%d)", offset);
+	snprintf(size_info, 64, "size(%d)", size);
+
+	snprintf(rule_size_info, 64, "%s rule size(%d)",
+		flow->type == DPAA2_FLOW_QOS_TYPE ?
+		"QoS" : "FS", flow->rule_size);
+
+	memcpy((flow->key_addr + offset), key, size);
+	memcpy((flow->mask_addr + offset), mask, size);
+	if (offset >= flow->rule_size) {
+		flow->rule_size = offset + size;
+	} else if ((offset + size) > flow->rule_size) {
+		DPAA2_PMD_ERR("%s: %s < %s, but %s + %s > %s",
+			__func__, offset_info, rule_size_info,
+			offset_info, size_info, rule_size_info);
+		return -EINVAL;
 	}
 
 	return 0;
 }
 
-static inline int
-dpaa2_flow_hdr_rule_data_set(struct dpaa2_dev_flow *flow,
-	struct dpaa2_key_profile *key_profile,
-	enum net_prot prot, uint32_t field, int size,
-	const void *key, const void *mask,
-	enum dpaa2_flow_dist_type dist_type)
+static int
+dpaa2_flow_raw_extract_rule_set(struct dpaa2_generic_flow *flow,
+	const struct rte_flow_item *pattern,
+	const struct dpaa2_flow_proto_handle *hd, int *ecfg)
 {
-	int offset;
-	char offset_info[64], size_info[64], rule_size_info[64];
+	int ret;
+	const struct rte_flow_item_raw *spec = pattern->spec;
+	const struct rte_flow_item_raw *mask = pattern->mask;
 
-	if (dpaa2_flow_ip_address_extract(prot, field)) {
-		DPAA2_PMD_ERR("%s only for none IP address extract",
-			__func__);
-		return -EINVAL;
-	}
+	RTE_SET_USED(hd);
 
-	offset = dpaa2_flow_extract_key_offset(key_profile,
-			DPAA2_NET_PROT_KEY, prot, field);
-	if (offset < 0) {
-		DPAA2_PMD_ERR("P(%d)/F(%d) does not exist!",
-			prot, field);
+	/* Need both spec and mask */
+	if (!spec || !mask) {
+		DPAA2_PMD_ERR("spec or mask not present.");
 		return -EINVAL;
 	}
-	sprintf(offset_info, "offset(%d)", offset);
-	sprintf(size_info, "size(%d)", size);
 
-	if (dist_type & DPAA2_FLOW_QOS_TYPE) {
-		sprintf(rule_size_info, "qos rule size(%d)",
-			flow->qos_rule_size);
-		memcpy((flow->qos_key_addr + offset), key, size);
-		memcpy((flow->qos_mask_addr + offset), mask, size);
-		if (key_profile->ip_addr_type == IP_NONE_ADDR_EXTRACT) {
-			if (offset >= flow->qos_rule_size) {
-				flow->qos_rule_size = offset + size;
-			} else if ((offset + size) > flow->qos_rule_size) {
-				DPAA2_PMD_ERR("%s: %s < %s, but %s + %s > %s",
-					__func__, offset_info, rule_size_info,
-					offset_info, size_info, rule_size_info);
-				return -EINVAL;
-			}
-		}
+	if (spec->relative) {
+		/* TBD: relative offset support.
+		 * To support relative offset of previous L3 protocol item,
+		 * extracts should be expanded to identify if the frame is:
+		 * vlan or none-vlan.
+		 *
+		 * To support relative offset of previous L4 protocol item,
+		 * extracts should be expanded to identify if the frame is:
+		 * vlan/IPv4 or vlan/IPv6 or none-vlan/IPv4 or none-vlan/IPv6.
+		 */
+		DPAA2_PMD_ERR("relative not supported.");
+		return -EINVAL;
 	}
 
-	if (dist_type & DPAA2_FLOW_FS_TYPE) {
-		sprintf(rule_size_info, "fs rule size(%d)",
-			flow->fs_rule_size);
-		memcpy((flow->fs_key_addr + offset), key, size);
-		memcpy((flow->fs_mask_addr + offset), mask, size);
-		if (key_profile->ip_addr_type == IP_NONE_ADDR_EXTRACT) {
-			if (offset >= flow->fs_rule_size) {
-				flow->fs_rule_size = offset + size;
-			} else if ((offset + size) > flow->fs_rule_size) {
-				DPAA2_PMD_ERR("%s: %s < %s, but %s + %s > %s",
-					__func__, offset_info, rule_size_info,
-					offset_info, size_info, rule_size_info);
-				return -EINVAL;
-			}
-		}
+	if (spec->search) {
+		DPAA2_PMD_ERR("search not supported.");
+		return -EINVAL;
 	}
 
-	return 0;
-}
-
-static inline int
-dpaa2_flow_raw_rule_data_set(struct dpaa2_dev_flow *flow,
-	struct dpaa2_key_profile *key_profile,
-	uint32_t extract_offset, int size,
-	const void *key, const void *mask,
-	enum dpaa2_flow_dist_type dist_type)
-{
-	int extract_size = size > DPAA2_FLOW_MAX_KEY_SIZE ?
-		DPAA2_FLOW_MAX_KEY_SIZE : size;
-	int offset, field;
-	char offset_info[64], size_info[64], rule_size_info[64];
-
-	field = extract_offset << DPAA2_FLOW_RAW_OFFSET_FIELD_SHIFT;
-	field |= extract_size;
-	offset = dpaa2_flow_extract_key_offset(key_profile,
-			DPAA2_NET_PROT_KEY, NET_PROT_PAYLOAD, field);
-	if (offset < 0) {
-		DPAA2_PMD_ERR("offset(%d)/size(%d) raw extract failed",
-			extract_offset, size);
+	/* Spec len and mask len should be same */
+	if (spec->length != mask->length) {
+		DPAA2_PMD_ERR("Spec len and mask len mismatch.");
 		return -EINVAL;
 	}
-	sprintf(offset_info, "offset(%d)", offset);
-	sprintf(size_info, "size(%d)", size);
 
-	if (dist_type & DPAA2_FLOW_QOS_TYPE) {
-		sprintf(rule_size_info, "qos rule size(%d)",
-			flow->qos_rule_size);
-		memcpy((flow->qos_key_addr + offset), key, size);
-		memcpy((flow->qos_mask_addr + offset), mask, size);
-		if (offset >= flow->qos_rule_size) {
-			flow->qos_rule_size = offset + size;
-		} else if ((offset + size) > flow->qos_rule_size) {
-			DPAA2_PMD_ERR("%s: %s < %s, but %s + %s > %s",
-				__func__, offset_info, rule_size_info,
-				offset_info, size_info, rule_size_info);
-			return -EINVAL;
-		}
+	ret = dpaa2_flow_extract_add_raw(flow, spec->offset, spec->length, ecfg);
+	if (ret) {
+		DPAA2_PMD_ERR("QoS Extract RAW add failed(%d).", ret);
+		return ret;
 	}
 
-	if (dist_type & DPAA2_FLOW_FS_TYPE) {
-		sprintf(rule_size_info, "fs rule size(%d)",
-			flow->fs_rule_size);
-		memcpy((flow->fs_key_addr + offset), key, size);
-		memcpy((flow->fs_mask_addr + offset), mask, size);
-		if (offset >= flow->fs_rule_size) {
-			flow->fs_rule_size = offset + size;
-		} else if ((offset + size) > flow->fs_rule_size) {
-			DPAA2_PMD_ERR("%s: %s < %s, but %s + %s > %s",
-				__func__, offset_info, rule_size_info,
-				offset_info, size_info, rule_size_info);
-			return -EINVAL;
+	if (flow->type == DPAA2_FLOW_QOS_TYPE || flow->type == DPAA2_FLOW_FS_TYPE) {
+		ret = dpaa2_flow_raw_rule_data_set(flow, spec->offset, spec->length,
+			spec->pattern, mask->pattern);
+		if (ret) {
+			DPAA2_PMD_ERR("QoS RAW rule data set failed(%d)", ret);
+			return ret;
 		}
 	}
 
@@ -1634,3774 +1374,3158 @@ dpaa2_flow_raw_rule_data_set(struct dpaa2_dev_flow *flow,
 }
 
 static int
-dpaa2_flow_extract_support(const uint8_t *mask_src,
-	enum rte_flow_item_type type)
+dpaa2_flow_geneve_extract_rule_set(struct dpaa2_generic_flow *flow,
+	const struct rte_flow_item *pattern,
+	const struct dpaa2_flow_proto_handle *hd, int *ecfg)
 {
-	char mask[64];
-	int i, size = 0;
-	const char *mask_support = 0;
-
-	switch (type) {
-	case RTE_FLOW_ITEM_TYPE_ETH:
-		mask_support = (const char *)&dpaa2_flow_item_eth_mask;
-		size = sizeof(struct rte_flow_item_eth);
-		break;
-	case RTE_FLOW_ITEM_TYPE_VLAN:
-		mask_support = (const char *)&dpaa2_flow_item_vlan_mask;
-		size = sizeof(struct rte_flow_item_vlan);
-		break;
-	case RTE_FLOW_ITEM_TYPE_IPV4:
-		mask_support = (const char *)&dpaa2_flow_item_ipv4_mask;
-		size = sizeof(struct rte_flow_item_ipv4);
-		break;
-	case RTE_FLOW_ITEM_TYPE_IPV6:
-		mask_support = (const char *)&dpaa2_flow_item_ipv6_mask;
-		size = sizeof(struct rte_flow_item_ipv6);
-		break;
-	case RTE_FLOW_ITEM_TYPE_ICMP:
-		mask_support = (const char *)&dpaa2_flow_item_icmp_mask;
-		size = sizeof(struct rte_flow_item_icmp);
-		break;
-	case RTE_FLOW_ITEM_TYPE_UDP:
-		mask_support = (const char *)&dpaa2_flow_item_udp_mask;
-		size = sizeof(struct rte_flow_item_udp);
-		break;
-	case RTE_FLOW_ITEM_TYPE_TCP:
-		mask_support = (const char *)&dpaa2_flow_item_tcp_mask;
-		size = sizeof(struct rte_flow_item_tcp);
-		break;
-	case RTE_FLOW_ITEM_TYPE_ESP:
-		mask_support = (const char *)&dpaa2_flow_item_esp_mask;
-		size = sizeof(struct rte_flow_item_esp);
-		break;
-	case RTE_FLOW_ITEM_TYPE_AH:
-		mask_support = (const char *)&dpaa2_flow_item_ah_mask;
-		size = sizeof(struct rte_flow_item_ah);
-		break;
-	case RTE_FLOW_ITEM_TYPE_SCTP:
-		mask_support = (const char *)&dpaa2_flow_item_sctp_mask;
-		size = sizeof(struct rte_flow_item_sctp);
-		break;
-	case RTE_FLOW_ITEM_TYPE_GRE:
-		mask_support = (const char *)&dpaa2_flow_item_gre_mask;
-		size = sizeof(struct rte_flow_item_gre);
-		break;
-	case RTE_FLOW_ITEM_TYPE_VXLAN:
-		mask_support = (const char *)&dpaa2_flow_item_vxlan_mask;
-		size = sizeof(struct rte_flow_item_vxlan);
-		break;
-	case RTE_FLOW_ITEM_TYPE_ECPRI:
-		mask_support = (const char *)&dpaa2_flow_item_ecpri_mask;
-		size = sizeof(struct rte_flow_item_ecpri);
-		break;
-	case RTE_FLOW_ITEM_TYPE_GTP:
-		mask_support = (const char *)&dpaa2_flow_item_gtp_mask;
-		size = sizeof(struct rte_flow_item_gtp);
-		break;
-	case RTE_FLOW_ITEM_TYPE_MPLS:
-		mask_support = (const char *)&dpaa2_flow_item_mpls_mask;
-		size = sizeof(struct rte_flow_item_mpls);
-		break;
-	case RTE_FLOW_ITEM_TYPE_PPPOES:
-		mask_support = (const char *)&dpaa2_flow_item_pppoe_mask;
-		size = sizeof(struct rte_flow_item_pppoe);
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	memcpy(mask, mask_support, size);
-
-	for (i = 0; i < size; i++)
-		mask[i] = (mask[i] | mask_src[i]);
+	int ret;
+	const struct rte_flow_item_geneve *spec = NULL, *mask = NULL;
+	struct dpaa2_dev_priv *priv = flow->priv;
 
-	if (memcmp(mask, mask_support, size))
+	if (!priv->sp_protocol) {
+		DPAA2_PMD_ERR("GENEVE flow is not supported without SP.");
 		return -ENOTSUP;
+	}
 
-	return 0;
-}
-
-static int
-dpaa2_flow_identify_by_faf(struct dpaa2_dev_priv *priv,
-	struct dpaa2_dev_flow *flow,
-	enum dpaa2_rx_faf_offset faf_off,
-	enum dpaa2_flow_dist_type dist_type,
-	int group, int *recfg)
-{
-	int ret, index, local_cfg = 0;
-	struct dpaa2_key_extract *extract;
-	struct dpaa2_key_profile *key_profile;
-	uint8_t faf_byte = faf_off / 8;
-
-	if (dist_type & DPAA2_FLOW_QOS_TYPE) {
-		extract = &priv->extract.qos_key_extract;
-		key_profile = &extract->key_profile;
-
-		index = dpaa2_flow_extract_search(key_profile,
-				DPAA2_FAF_KEY, NET_PROT_NONE, faf_byte);
-		if (index < 0) {
-			ret = dpaa2_flow_faf_add_hdr(faf_byte,
-					priv, DPAA2_FLOW_QOS_TYPE, group,
-					NULL);
-			if (ret) {
-				DPAA2_PMD_ERR("QOS faf extract add failed");
+	spec = pattern->spec;
+	mask = pattern->mask ? pattern->mask : hd->mask_support;
 
-				return -EINVAL;
-			}
-			local_cfg |= DPAA2_FLOW_QOS_TYPE;
-		}
+	if (!spec || !mask)
+		return 0;
 
-		ret = dpaa2_flow_faf_add_rule(priv, flow, faf_off, group,
-				DPAA2_FLOW_QOS_TYPE);
-		if (ret) {
-			DPAA2_PMD_ERR("QoS faf rule set failed");
-			return -EINVAL;
-		}
+	if (mask->protocol && mask->protocol != 0xffff) {
+		DPAA2_PMD_ERR("Not support to extract geneve protocol.");
+		return -EINVAL;
 	}
 
-	if (dist_type & DPAA2_FLOW_FS_TYPE) {
-		extract = &priv->extract.tc_key_extract[group];
-		key_profile = &extract->key_profile;
-
-		index = dpaa2_flow_extract_search(key_profile,
-				DPAA2_FAF_KEY, NET_PROT_NONE, faf_byte);
-		if (index < 0) {
-			ret = dpaa2_flow_faf_add_hdr(faf_byte,
-					priv, DPAA2_FLOW_FS_TYPE, group,
-					NULL);
-			if (ret) {
-				DPAA2_PMD_ERR("FS[%d] faf extract add failed",
-					group);
-
-				return -EINVAL;
-			}
-			local_cfg |= DPAA2_FLOW_FS_TYPE;
-		}
-
-		ret = dpaa2_flow_faf_add_rule(priv, flow, faf_off, group,
-				DPAA2_FLOW_FS_TYPE);
-		if (ret) {
-			DPAA2_PMD_ERR("FS[%d] faf rule set failed",
-				group);
-			return -EINVAL;
-		}
+	if (mask->protocol) {
+		ret = dpaa2_flow_add_soft_psr_extract_rule(flow,
+			DPAA2_GENEVE_PROTOCOL_OFFSET,
+			sizeof(mask->protocol), &spec->protocol,
+			&mask->protocol, ecfg);
+		if (ret)
+			return ret;
 	}
 
-	if (recfg)
-		*recfg |= local_cfg;
+	if (mask->vni[0] || mask->vni[1] || mask->vni[2]) {
+		ret = dpaa2_flow_add_soft_psr_extract_rule(flow,
+			DPAA2_GENEVE_VNI_OFFSET, sizeof(mask->vni),
+			spec->vni, mask->vni, ecfg);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
 
 static int
-dpaa2_flow_add_pr_extract_rule(struct dpaa2_dev_flow *flow,
-	uint32_t pr_offset, uint32_t pr_size,
-	const void *key, const void *mask,
-	struct dpaa2_dev_priv *priv, int tc_id, int *recfg,
-	enum dpaa2_flow_dist_type dist_type)
+dpaa2_flow_general_extract_rule_set(struct dpaa2_generic_flow *flow,
+	const struct rte_flow_item *pattern,
+	const struct dpaa2_flow_proto_handle *hd, int *ecfg)
 {
-	int index, ret, local_cfg = 0;
-	struct dpaa2_key_extract *key_extract;
-	struct dpaa2_key_profile *key_profile;
-	uint32_t pr_field = pr_offset << 16 | pr_size;
-
-	if (dist_type == DPAA2_FLOW_QOS_TYPE)
-		key_extract = &priv->extract.qos_key_extract;
-	else
-		key_extract = &priv->extract.tc_key_extract[tc_id];
+	int ret, i;
+	uint32_t bit_offset;
+	const uint8_t *spec_u8 = pattern->spec, *mask_u8 = pattern->mask;
+	const char zero_cmp[128] = {0};
 
-	key_profile = &key_extract->key_profile;
-
-	index = dpaa2_flow_extract_search(key_profile,
-			DPAA2_PR_KEY, NET_PROT_NONE, pr_field);
-	if (index < 0) {
-		ret = dpaa2_flow_pr_add_hdr(pr_offset,
-				pr_size, priv,
-				dist_type, tc_id, NULL);
-		if (ret) {
-			DPAA2_PMD_ERR("PR add off(%d)/size(%d) failed",
-				pr_offset, pr_size);
+	if (hd->force_psr || !spec_u8) {
+		ret = dpaa2_protocol_psr_bit_offset(&bit_offset, hd->protocol_id);
+		if (ret)
+			return ret;
 
+		ret = dpaa2_flow_identify_by_faf(flow, bit_offset, ecfg);
+		if (ret)
 			return ret;
-		}
-		local_cfg |= dist_type;
 	}
 
-	ret = dpaa2_flow_pr_rule_data_set(flow, key_profile,
-			pr_offset, pr_size, key, mask, dist_type);
-	if (ret) {
-		DPAA2_PMD_ERR("PR off(%d)/size(%d) rule data set failed",
-			pr_offset, pr_size);
+	if (!spec_u8)
+		return 0;
+
+	if (!mask_u8)
+		mask_u8 = hd->mask_support;
 
+	ret = dpaa2_flow_extract_support(mask_u8, hd->mask_support, hd->hdr_size);
+	if (ret)
 		return ret;
-	}
 
-	if (recfg)
-		*recfg |= local_cfg;
+	for (i = 0; i < hd->fields_num; i++) {
+		if (!memcmp(mask_u8 + hd->field_offset[i], zero_cmp, hd->field_size[i]))
+			continue;
+
+		ret = dpaa2_flow_add_hdr_extract_rule(flow, hd->prot,
+			hd->fields[i], spec_u8 + hd->field_offset[i],
+			mask_u8 + hd->field_offset[i], hd->field_size[i], ecfg);
+		if (ret)
+			return ret;
+	}
 
 	return 0;
 }
 
-static int
-dpaa2_flow_add_hdr_extract_rule(struct dpaa2_dev_flow *flow,
-	enum net_prot prot, uint32_t field,
-	const void *key, const void *mask, int size,
-	struct dpaa2_dev_priv *priv, int tc_id, int *recfg,
-	enum dpaa2_flow_dist_type dist_type)
-{
-	int index, ret, local_cfg = 0;
-	struct dpaa2_key_extract *key_extract;
-	struct dpaa2_key_profile *key_profile;
-
-	if (dpaa2_flow_ip_address_extract(prot, field))
-		return -EINVAL;
-
-	if (dist_type == DPAA2_FLOW_QOS_TYPE)
-		key_extract = &priv->extract.qos_key_extract;
-	else
-		key_extract = &priv->extract.tc_key_extract[tc_id];
-
-	key_profile = &key_extract->key_profile;
-
-	index = dpaa2_flow_extract_search(key_profile,
-			DPAA2_NET_PROT_KEY, prot, field);
-	if (index < 0) {
-		ret = dpaa2_flow_extract_add_hdr(prot,
-				field, size, priv,
-				dist_type, tc_id, NULL);
-		if (ret) {
-			DPAA2_PMD_ERR("QoS Extract P(%d)/F(%d) failed",
-				prot, field);
-
-			return ret;
+/** Make sure DPAA2_RTE_FLOW_ITEM_MAX > max of enum rte_flow_item_type.*/
+#define DPAA2_RTE_FLOW_ITEM_MAX 64
+static const struct dpaa2_flow_proto_handle s_dpaa2_flow_proto_handle[DPAA2_RTE_FLOW_ITEM_MAX] = {
+	[RTE_FLOW_ITEM_TYPE_ETH] = {
+		"eth",
+		dpaa2_flow_general_extract_rule_set,
+		dpaa2_flow_tunnel_eth_extract_rule_set,
+		DPAA2_PARSER_MAC_ID, DPAA2_PARSER_NULL_ID, RTE_FLOW_ITEM_TYPE_ETH,
+		&dpaa2_flow_item_eth_mask, sizeof(struct rte_flow_item_eth),
+		false, NET_PROT_ETH, 3,
+		.fields = {
+			NH_FLD_ETH_SA, NH_FLD_ETH_DA, NH_FLD_ETH_TYPE
+		},
+		.field_offset = {
+			offsetof(struct rte_flow_item_eth, src),
+			offsetof(struct rte_flow_item_eth, dst),
+			offsetof(struct rte_flow_item_eth, type)
+		},
+		.field_size = {
+			RTE_ETHER_ADDR_LEN, RTE_ETHER_ADDR_LEN, sizeof(rte_be16_t)
 		}
-		local_cfg |= dist_type;
-	}
-
-	ret = dpaa2_flow_hdr_rule_data_set(flow, key_profile,
-			prot, field, size, key, mask, dist_type);
-	if (ret) {
-		DPAA2_PMD_ERR("QoS P(%d)/F(%d) rule data set failed",
-			prot, field);
-
-		return ret;
-	}
-
-	if (recfg)
-		*recfg |= local_cfg;
-
-	return 0;
-}
-
-static int
-dpaa2_flow_add_ipaddr_extract_rule(struct dpaa2_dev_flow *flow,
-	enum net_prot prot, uint32_t field,
-	const void *key, const void *mask, int size,
-	struct dpaa2_dev_priv *priv, int tc_id, int *recfg,
-	enum dpaa2_flow_dist_type dist_type)
-{
-	int local_cfg = 0, num, ipaddr_extract_len = 0;
-	struct dpaa2_key_extract *key_extract;
-	struct dpaa2_key_profile *key_profile;
-	struct dpkg_profile_cfg *dpkg;
-	uint8_t *key_addr, *mask_addr;
-	union ip_addr_extract_rule *ip_addr_data;
-	union ip_addr_extract_rule *ip_addr_mask;
-	enum net_prot orig_prot;
-	uint32_t orig_field;
-
-	if (prot != NET_PROT_IPV4 && prot != NET_PROT_IPV6)
-		return -EINVAL;
-
-	if (prot == NET_PROT_IPV4 && field != NH_FLD_IPV4_SRC_IP &&
-		field != NH_FLD_IPV4_DST_IP) {
-		return -EINVAL;
-	}
-
-	if (prot == NET_PROT_IPV6 && field != NH_FLD_IPV6_SRC_IP &&
-		field != NH_FLD_IPV6_DST_IP) {
-		return -EINVAL;
-	}
-
-	orig_prot = prot;
-	orig_field = field;
-
-	if (prot == NET_PROT_IPV4 &&
-		field == NH_FLD_IPV4_SRC_IP) {
-		prot = NET_PROT_IP;
-		field = NH_FLD_IP_SRC;
-	} else if (prot == NET_PROT_IPV4 &&
-		field == NH_FLD_IPV4_DST_IP) {
-		prot = NET_PROT_IP;
-		field = NH_FLD_IP_DST;
-	} else if (prot == NET_PROT_IPV6 &&
-		field == NH_FLD_IPV6_SRC_IP) {
-		prot = NET_PROT_IP;
-		field = NH_FLD_IP_SRC;
-	} else if (prot == NET_PROT_IPV6 &&
-		field == NH_FLD_IPV6_DST_IP) {
-		prot = NET_PROT_IP;
-		field = NH_FLD_IP_DST;
-	} else {
-		DPAA2_PMD_ERR("Inval P(%d)/F(%d) to extract ip address",
-			prot, field);
-		return -EINVAL;
-	}
-
-	if (dist_type == DPAA2_FLOW_QOS_TYPE) {
-		key_extract = &priv->extract.qos_key_extract;
-		key_profile = &key_extract->key_profile;
-		dpkg = &key_extract->dpkg;
-		num = key_profile->num;
-		key_addr = flow->qos_key_addr;
-		mask_addr = flow->qos_mask_addr;
-	} else {
-		key_extract = &priv->extract.tc_key_extract[tc_id];
-		key_profile = &key_extract->key_profile;
-		dpkg = &key_extract->dpkg;
-		num = key_profile->num;
-		key_addr = flow->fs_key_addr;
-		mask_addr = flow->fs_mask_addr;
-	}
-
-	if (num >= DPKG_MAX_NUM_OF_EXTRACTS) {
-		DPAA2_PMD_ERR("Number of extracts overflows");
-		return -EINVAL;
-	}
-
-	if (key_profile->ip_addr_type == IP_NONE_ADDR_EXTRACT) {
-		if (field == NH_FLD_IP_SRC)
-			key_profile->ip_addr_type = IP_SRC_EXTRACT;
-		else
-			key_profile->ip_addr_type = IP_DST_EXTRACT;
-		ipaddr_extract_len = size;
-
-		key_profile->ip_addr_extract_pos = num;
-		if (num > 0) {
-			key_profile->ip_addr_extract_off =
-				key_profile->key_offset[num - 1] +
-				key_profile->key_size[num - 1];
-		} else {
-			key_profile->ip_addr_extract_off = 0;
+	},
+	[RTE_FLOW_ITEM_TYPE_VLAN] = {
+		"vlan",
+		dpaa2_flow_general_extract_rule_set,
+		dpaa2_flow_tunnel_vlan_extract_rule_set,
+		DPAA2_PARSER_VLAN_ID, DPAA2_PARSER_NULL_ID, RTE_FLOW_ITEM_TYPE_VLAN,
+		&dpaa2_flow_item_vlan_mask, sizeof(struct rte_flow_item_vlan),
+		false, NET_PROT_VLAN, 1,
+		.fields = {
+			NH_FLD_VLAN_TCI
+		},
+		.field_offset = {
+			offsetof(struct rte_flow_item_vlan, tci)
+		},
+		.field_size = {
+			sizeof(rte_be16_t)
 		}
-		key_profile->key_max_size += NH_FLD_IPV6_ADDR_SIZE;
-	} else if (key_profile->ip_addr_type == IP_SRC_EXTRACT) {
-		if (field == NH_FLD_IP_SRC) {
-			ipaddr_extract_len = size;
-			goto rule_configure;
+	},
+	[RTE_FLOW_ITEM_TYPE_ICMP] = {
+		"icmp",
+		dpaa2_flow_general_extract_rule_set,
+		NULL,
+		DPAA2_PARSER_ICMP_ID, DPAA2_PARSER_NULL_ID, RTE_FLOW_ITEM_TYPE_ICMP,
+		&dpaa2_flow_item_icmp_mask, sizeof(struct rte_flow_item_icmp),
+		false, NET_PROT_ICMP, 2,
+		.fields = {
+			NH_FLD_ICMP_TYPE, NH_FLD_ICMP_CODE
+		},
+		.field_offset = {
+			offsetof(struct rte_flow_item_icmp, hdr.icmp_type),
+			offsetof(struct rte_flow_item_icmp, hdr.icmp_code)
+		},
+		.field_size = {
+			sizeof(uint8_t), sizeof(uint8_t)
 		}
-		key_profile->ip_addr_type = IP_SRC_DST_EXTRACT;
-		ipaddr_extract_len = size * 2;
-		key_profile->key_max_size += NH_FLD_IPV6_ADDR_SIZE;
-	} else if (key_profile->ip_addr_type == IP_DST_EXTRACT) {
-		if (field == NH_FLD_IP_DST) {
-			ipaddr_extract_len = size;
-			goto rule_configure;
+	},
+	[RTE_FLOW_ITEM_TYPE_UDP] = {
+		"udp",
+		dpaa2_flow_general_extract_rule_set,
+		dpaa2_flow_general_tunnel_extract_rule_set,
+		DPAA2_PARSER_UDP_ID, DPAA2_PARSER_TUNNEL_UDP_ID, RTE_FLOW_ITEM_TYPE_UDP,
+		&dpaa2_flow_item_udp_mask, sizeof(struct rte_flow_item_udp),
+		true, NET_PROT_UDP, 2,
+		.fields = {
+			NH_FLD_UDP_PORT_SRC, NH_FLD_UDP_PORT_DST
+		},
+		.field_offset = {
+			offsetof(struct rte_flow_item_udp, hdr.src_port),
+			offsetof(struct rte_flow_item_udp, hdr.dst_port)
+		},
+		.field_size = {
+			sizeof(rte_be16_t), sizeof(rte_be16_t)
 		}
-		key_profile->ip_addr_type = IP_DST_SRC_EXTRACT;
-		ipaddr_extract_len = size * 2;
-		key_profile->key_max_size += NH_FLD_IPV6_ADDR_SIZE;
-	}
-	key_profile->num++;
-	key_profile->prot_field[num].type = DPAA2_NET_PROT_KEY;
-
-	dpkg->extracts[num].extract.from_hdr.prot = prot;
-	dpkg->extracts[num].extract.from_hdr.field = field;
-	dpkg->extracts[num].extract.from_hdr.type = DPKG_FULL_FIELD;
-	dpkg->num_extracts++;
-
-	if (dist_type == DPAA2_FLOW_QOS_TYPE)
-		local_cfg = DPAA2_FLOW_QOS_TYPE;
-	else
-		local_cfg = DPAA2_FLOW_FS_TYPE;
-
-rule_configure:
-	key_addr += key_profile->ip_addr_extract_off;
-	ip_addr_data = (union ip_addr_extract_rule *)key_addr;
-	mask_addr += key_profile->ip_addr_extract_off;
-	ip_addr_mask = (union ip_addr_extract_rule *)mask_addr;
-
-	if (orig_prot == NET_PROT_IPV4 &&
-		orig_field == NH_FLD_IPV4_SRC_IP) {
-		if (key_profile->ip_addr_type == IP_SRC_EXTRACT ||
-			key_profile->ip_addr_type == IP_SRC_DST_EXTRACT) {
-			memcpy(&ip_addr_data->ipv4_sd_addr.ipv4_src,
-				key, size);
-			memcpy(&ip_addr_mask->ipv4_sd_addr.ipv4_src,
-				mask, size);
-		} else {
-			memcpy(&ip_addr_data->ipv4_ds_addr.ipv4_src,
-				key, size);
-			memcpy(&ip_addr_mask->ipv4_ds_addr.ipv4_src,
-				mask, size);
+	},
+	[RTE_FLOW_ITEM_TYPE_TCP] = {
+		"tcp",
+		dpaa2_flow_general_extract_rule_set,
+		dpaa2_flow_general_tunnel_extract_rule_set,
+		DPAA2_PARSER_TCP_ID, DPAA2_PARSER_TUNNEL_TCP_ID, RTE_FLOW_ITEM_TYPE_TCP,
+		&dpaa2_flow_item_tcp_mask, sizeof(struct rte_flow_item_tcp),
+		true, NET_PROT_TCP, 2,
+		.fields = {
+			NH_FLD_TCP_PORT_SRC, NH_FLD_TCP_PORT_DST
+		},
+		.field_offset = {
+			offsetof(struct rte_flow_item_tcp, hdr.src_port),
+			offsetof(struct rte_flow_item_tcp, hdr.dst_port)
+		},
+		.field_size = {
+			sizeof(rte_be16_t), sizeof(rte_be16_t)
 		}
-	} else if (orig_prot == NET_PROT_IPV4 &&
-		orig_field == NH_FLD_IPV4_DST_IP) {
-		if (key_profile->ip_addr_type == IP_DST_EXTRACT ||
-			key_profile->ip_addr_type == IP_DST_SRC_EXTRACT) {
-			memcpy(&ip_addr_data->ipv4_ds_addr.ipv4_dst,
-				key, size);
-			memcpy(&ip_addr_mask->ipv4_ds_addr.ipv4_dst,
-				mask, size);
-		} else {
-			memcpy(&ip_addr_data->ipv4_sd_addr.ipv4_dst,
-				key, size);
-			memcpy(&ip_addr_mask->ipv4_sd_addr.ipv4_dst,
-				mask, size);
+	},
+	[RTE_FLOW_ITEM_TYPE_ESP] = {
+		"esp",
+		dpaa2_flow_general_extract_rule_set,
+		NULL,
+		DPAA2_PARSER_IPSEC_ESP_ID, DPAA2_PARSER_NULL_ID, RTE_FLOW_ITEM_TYPE_ESP,
+		&dpaa2_flow_item_esp_mask, sizeof(struct rte_flow_item_esp),
+		true, NET_PROT_IPSEC_ESP, 2,
+		.fields = {
+			NH_FLD_IPSEC_ESP_SPI, NH_FLD_IPSEC_ESP_SEQUENCE_NUM
+		},
+		.field_offset = {
+			offsetof(struct rte_flow_item_esp, hdr.spi),
+			offsetof(struct rte_flow_item_esp, hdr.seq)
+		},
+		.field_size = {
+			sizeof(rte_be32_t), sizeof(rte_be32_t)
 		}
-	} else if (orig_prot == NET_PROT_IPV6 &&
-		orig_field == NH_FLD_IPV6_SRC_IP) {
-		if (key_profile->ip_addr_type == IP_SRC_EXTRACT ||
-			key_profile->ip_addr_type == IP_SRC_DST_EXTRACT) {
-			memcpy(ip_addr_data->ipv6_sd_addr.ipv6_src,
-				key, size);
-			memcpy(ip_addr_mask->ipv6_sd_addr.ipv6_src,
-				mask, size);
-		} else {
-			memcpy(ip_addr_data->ipv6_ds_addr.ipv6_src,
-				key, size);
-			memcpy(ip_addr_mask->ipv6_ds_addr.ipv6_src,
-				mask, size);
+	},
+	[RTE_FLOW_ITEM_TYPE_AH] = {
+		"ah",
+		dpaa2_flow_general_extract_rule_set,
+		NULL,
+		DPAA2_PARSER_IPSEC_AH_ID, DPAA2_PARSER_NULL_ID, RTE_FLOW_ITEM_TYPE_AH,
+		&dpaa2_flow_item_ah_mask, sizeof(struct rte_flow_item_ah),
+		true, NET_PROT_IPSEC_AH, 1,
+		.fields = {
+			NH_FLD_IPSEC_AH_SPI
+		},
+		.field_offset = {
+			offsetof(struct rte_flow_item_ah, spi)
+		},
+		.field_size = {
+			sizeof(rte_be32_t)
 		}
-	} else if (orig_prot == NET_PROT_IPV6 &&
-		orig_field == NH_FLD_IPV6_DST_IP) {
-		if (key_profile->ip_addr_type == IP_DST_EXTRACT ||
-			key_profile->ip_addr_type == IP_DST_SRC_EXTRACT) {
-			memcpy(ip_addr_data->ipv6_ds_addr.ipv6_dst,
-				key, size);
-			memcpy(ip_addr_mask->ipv6_ds_addr.ipv6_dst,
-				mask, size);
-		} else {
-			memcpy(ip_addr_data->ipv6_sd_addr.ipv6_dst,
-				key, size);
-			memcpy(ip_addr_mask->ipv6_sd_addr.ipv6_dst,
-				mask, size);
+	},
+	[RTE_FLOW_ITEM_TYPE_SCTP] = {
+		"sctp",
+		dpaa2_flow_general_extract_rule_set,
+		NULL,
+		DPAA2_PARSER_SCTP_ID, DPAA2_PARSER_NULL_ID, RTE_FLOW_ITEM_TYPE_SCTP,
+		&dpaa2_flow_item_sctp_mask, sizeof(struct rte_flow_item_sctp),
+		true, NET_PROT_SCTP, 2,
+		.fields = {
+			NH_FLD_SCTP_PORT_SRC, NH_FLD_SCTP_PORT_DST
+		},
+		.field_offset = {
+			offsetof(struct rte_flow_item_sctp, hdr.src_port),
+			offsetof(struct rte_flow_item_sctp, hdr.dst_port),
+		},
+		.field_size = {
+			sizeof(rte_be16_t), sizeof(rte_be16_t)
 		}
-	}
-
-	if (dist_type == DPAA2_FLOW_QOS_TYPE) {
-		flow->qos_rule_size =
-			key_profile->ip_addr_extract_off + ipaddr_extract_len;
-	} else {
-		flow->fs_rule_size =
-			key_profile->ip_addr_extract_off + ipaddr_extract_len;
-	}
-
-	if (recfg)
-		*recfg |= local_cfg;
-
-	return 0;
-}
-
-static int
-dpaa2_configure_flow_tunnel_eth(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
-	const struct rte_flow_attr *attr,
-	const struct rte_flow_item *pattern,
-	int *device_configured)
-{
-	int ret, local_cfg = 0;
-	uint32_t group;
-	const struct rte_flow_item_eth *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	const char zero_cmp[RTE_ETHER_ADDR_LEN] = {0};
-
-	group = attr->group;
-
-	/* Parse pattern list to get the matching parameters */
-	spec = pattern->spec;
-	mask = pattern->mask ?
-			pattern->mask : &dpaa2_flow_item_eth_mask;
-
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
-	if (!spec)
-		return 0;
-
-	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
-		RTE_FLOW_ITEM_TYPE_ETH);
-	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of ethernet failed");
-
-		return ret;
-	}
-
-	if (memcmp((const char *)&mask->src,
-		zero_cmp, RTE_ETHER_ADDR_LEN)) {
-		/*SRC[0:1]*/
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_SADDR0_OFFSET,
-			1, &spec->src.addr_bytes[0],
-			&mask->src.addr_bytes[0],
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-		/*SRC[1:2]*/
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_SADDR1_OFFSET,
-			2, &spec->src.addr_bytes[1],
-			&mask->src.addr_bytes[1],
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-		/*SRC[3:1]*/
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_SADDR3_OFFSET,
-			1, &spec->src.addr_bytes[3],
-			&mask->src.addr_bytes[3],
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-		/*SRC[4:2]*/
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_SADDR4_OFFSET,
-			2, &spec->src.addr_bytes[4],
-			&mask->src.addr_bytes[4],
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		/*SRC[0:1]*/
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_SADDR0_OFFSET,
-			1, &spec->src.addr_bytes[0],
-			&mask->src.addr_bytes[0],
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
-		/*SRC[1:2]*/
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_SADDR1_OFFSET,
-			2, &spec->src.addr_bytes[1],
-			&mask->src.addr_bytes[1],
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
-		/*SRC[3:1]*/
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_SADDR3_OFFSET,
-			1, &spec->src.addr_bytes[3],
-			&mask->src.addr_bytes[3],
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
-		/*SRC[4:2]*/
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_SADDR4_OFFSET,
-			2, &spec->src.addr_bytes[4],
-			&mask->src.addr_bytes[4],
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
-	}
-
-	if (memcmp((const char *)&mask->dst,
-		zero_cmp, RTE_ETHER_ADDR_LEN)) {
-		/*DST[0:1]*/
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_DADDR0_OFFSET,
-			1, &spec->dst.addr_bytes[0],
-			&mask->dst.addr_bytes[0],
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-		/*DST[1:1]*/
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_DADDR1_OFFSET,
-			1, &spec->dst.addr_bytes[1],
-			&mask->dst.addr_bytes[1],
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-		/*DST[2:3]*/
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_DADDR2_OFFSET,
-			3, &spec->dst.addr_bytes[2],
-			&mask->dst.addr_bytes[2],
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-		/*DST[5:1]*/
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_DADDR5_OFFSET,
-			1, &spec->dst.addr_bytes[5],
-			&mask->dst.addr_bytes[5],
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		/*DST[0:1]*/
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_DADDR0_OFFSET,
-			1, &spec->dst.addr_bytes[0],
-			&mask->dst.addr_bytes[0],
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
-		/*DST[1:1]*/
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_DADDR1_OFFSET,
-			1, &spec->dst.addr_bytes[1],
-			&mask->dst.addr_bytes[1],
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
-		/*DST[2:3]*/
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_DADDR2_OFFSET,
-			3, &spec->dst.addr_bytes[2],
-			&mask->dst.addr_bytes[2],
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
-		/*DST[5:1]*/
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_DADDR5_OFFSET,
-			1, &spec->dst.addr_bytes[5],
-			&mask->dst.addr_bytes[5],
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
-	}
-
-	if (memcmp((const char *)&mask->type,
-		zero_cmp, sizeof(rte_be16_t))) {
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_TYPE_OFFSET,
-			sizeof(rte_be16_t), &spec->type, &mask->type,
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_TYPE_OFFSET,
-			sizeof(rte_be16_t), &spec->type, &mask->type,
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
-	}
-
-	(*device_configured) |= local_cfg;
-
-	return 0;
-}
-
-static int
-dpaa2_configure_flow_eth(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
-	const struct rte_flow_attr *attr,
-	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
-{
-	int ret, local_cfg = 0;
-	uint32_t group;
-	const struct rte_flow_item_eth *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	const char zero_cmp[RTE_ETHER_ADDR_LEN] = {0};
-	const struct rte_flow_item *pattern =
-		&dpaa2_pattern->generic_item;
-
-	if (dpaa2_pattern->in_tunnel) {
-		return dpaa2_configure_flow_tunnel_eth(flow,
-				dev, attr, pattern, device_configured);
-	}
-
-	group = attr->group;
-
-	/* Parse pattern list to get the matching parameters */
-	spec = pattern->spec;
-	mask = pattern->mask ?
-			pattern->mask : &dpaa2_flow_item_eth_mask;
-
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
-	if (!spec) {
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_ETH_FRAM, DPAA2_FLOW_QOS_TYPE,
-				group, &local_cfg);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_ETH_FRAM, DPAA2_FLOW_FS_TYPE,
-				group, &local_cfg);
-		if (ret)
-			return ret;
-
-		(*device_configured) |= local_cfg;
-		return 0;
-	}
-
-	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
-		RTE_FLOW_ITEM_TYPE_ETH);
-	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of ethernet failed");
-
-		return ret;
-	}
-
-	if (memcmp((const char *)&mask->src,
-		zero_cmp, RTE_ETHER_ADDR_LEN)) {
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_ETH,
-			NH_FLD_ETH_SA, &spec->src.addr_bytes,
-			&mask->src.addr_bytes, RTE_ETHER_ADDR_LEN,
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_ETH,
-			NH_FLD_ETH_SA, &spec->src.addr_bytes,
-			&mask->src.addr_bytes, RTE_ETHER_ADDR_LEN,
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
-	}
-
-	if (memcmp((const char *)&mask->dst,
-		zero_cmp, RTE_ETHER_ADDR_LEN)) {
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_ETH,
-			NH_FLD_ETH_DA, &spec->dst.addr_bytes,
-			&mask->dst.addr_bytes, RTE_ETHER_ADDR_LEN,
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_ETH,
-			NH_FLD_ETH_DA, &spec->dst.addr_bytes,
-			&mask->dst.addr_bytes, RTE_ETHER_ADDR_LEN,
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
-	}
-
-	if (memcmp((const char *)&mask->type,
-		zero_cmp, sizeof(rte_be16_t))) {
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_ETH,
-			NH_FLD_ETH_TYPE, &spec->type,
-			&mask->type, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_ETH,
-			NH_FLD_ETH_TYPE, &spec->type,
-			&mask->type, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
-	}
-
-	(*device_configured) |= local_cfg;
-
-	return 0;
-}
-
-static int
-dpaa2_configure_flow_tunnel_vlan(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
-	const struct rte_flow_attr *attr,
-	const struct rte_flow_item *pattern,
-	int *device_configured)
-{
-	int ret, local_cfg = 0;
-	uint32_t group;
-	const struct rte_flow_item_vlan *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-
-	group = attr->group;
-
-	/* Parse pattern list to get the matching parameters */
-	spec = pattern->spec;
-	mask = pattern->mask ?
-		pattern->mask : &dpaa2_flow_item_vlan_mask;
-
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
-	if (!spec) {
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAFE_VXLAN_IN_VLAN_FRAM,
-				DPAA2_FLOW_QOS_TYPE,
-				group, &local_cfg);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAFE_VXLAN_IN_VLAN_FRAM,
-				DPAA2_FLOW_FS_TYPE,
-				group, &local_cfg);
-		if (ret)
-			return ret;
-
-		(*device_configured) |= local_cfg;
-		return 0;
-	}
-
-	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
-		RTE_FLOW_ITEM_TYPE_VLAN);
-	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of vlan not support.");
-
-		return ret;
-	}
-
-	if (!mask->tci)
-		return 0;
-
-	ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_TCI_OFFSET,
-			sizeof(rte_be16_t), &spec->tci, &mask->tci,
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-	if (ret)
-		return ret;
-
-	ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_IN_TCI_OFFSET,
-			sizeof(rte_be16_t), &spec->tci, &mask->tci,
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-	if (ret)
-		return ret;
-
-	(*device_configured) |= local_cfg;
-
-	return 0;
-}
-
-static int
-dpaa2_configure_flow_vlan(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
-	const struct rte_flow_attr *attr,
-	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
-{
-	int ret, local_cfg = 0;
-	uint32_t group;
-	const struct rte_flow_item_vlan *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	const struct rte_flow_item *pattern =
-		&dpaa2_pattern->generic_item;
-
-	if (dpaa2_pattern->in_tunnel) {
-		return dpaa2_configure_flow_tunnel_vlan(flow,
-				dev, attr, pattern, device_configured);
-	}
-
-	group = attr->group;
-
-	/* Parse pattern list to get the matching parameters */
-	spec = pattern->spec;
-	mask = pattern->mask ? pattern->mask : &dpaa2_flow_item_vlan_mask;
-
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
-	if (!spec) {
-		ret = dpaa2_flow_identify_by_faf(priv, flow, FAF_VLAN_FRAM,
-				DPAA2_FLOW_QOS_TYPE, group,
-				&local_cfg);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_identify_by_faf(priv, flow, FAF_VLAN_FRAM,
-				DPAA2_FLOW_FS_TYPE, group,
-				&local_cfg);
-		if (ret)
-			return ret;
-
-		(*device_configured) |= local_cfg;
-		return 0;
-	}
-
-	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
-			RTE_FLOW_ITEM_TYPE_VLAN);
-	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of vlan not support.");
-		return ret;
-	}
-
-	if (!mask->tci)
-		return 0;
-
-	ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_VLAN,
-			NH_FLD_VLAN_TCI, &spec->tci,
-			&mask->tci, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-	if (ret)
-		return ret;
-
-	ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_VLAN,
-			NH_FLD_VLAN_TCI, &spec->tci,
-			&mask->tci, sizeof(rte_be16_t),
-			priv, group, &local_cfg,
-			DPAA2_FLOW_FS_TYPE);
-	if (ret)
-		return ret;
-
-	(*device_configured) |= local_cfg;
-	return 0;
-}
-
-static int
-dpaa2_configure_flow_ipv4(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
-	const struct rte_flow_attr *attr,
-	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
-{
-	int ret, local_cfg = 0;
-	uint32_t group;
-	const struct rte_flow_item_ipv4 *spec_ipv4 = 0, *mask_ipv4 = 0;
-	const void *key, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	int size;
-	const struct rte_flow_item *pattern = &dpaa2_pattern->generic_item;
-
-	group = attr->group;
-
-	/* Parse pattern list to get the matching parameters */
-	spec_ipv4 = pattern->spec;
-	mask_ipv4 = pattern->mask ?
-		    pattern->mask : &dpaa2_flow_item_ipv4_mask;
-
-	if (dpaa2_pattern->in_tunnel) {
-		if (spec_ipv4) {
-			DPAA2_PMD_ERR("Tunnel-IPv4 distribution not support");
-			return -ENOTSUP;
+	},
+	[RTE_FLOW_ITEM_TYPE_GRE] = {
+		"gre",
+		dpaa2_flow_general_extract_rule_set,
+		NULL,
+		DPAA2_PARSER_GRE_ID, DPAA2_PARSER_NULL_ID, RTE_FLOW_ITEM_TYPE_GRE,
+		&dpaa2_flow_item_gre_mask, sizeof(struct rte_flow_item_gre),
+		false, NET_PROT_GRE, 1,
+		.fields = {
+			NH_FLD_GRE_TYPE
+		},
+		.field_offset = {
+			offsetof(struct rte_flow_item_gre, protocol)
+		},
+		.field_size = {
+			sizeof(rte_be16_t)
 		}
-
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAFE_VXLAN_IN_IPV4_FRAM,
-				DPAA2_FLOW_QOS_TYPE, group,
-				&local_cfg);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAFE_VXLAN_IN_IPV4_FRAM,
-				DPAA2_FLOW_FS_TYPE, group,
-				&local_cfg);
-		return ret;
-	}
-
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
-	ret = dpaa2_flow_identify_by_faf(priv, flow, FAF_IPV4_FRAM,
-			DPAA2_FLOW_QOS_TYPE, group,
-			&local_cfg);
-	if (ret)
-		return ret;
-
-	ret = dpaa2_flow_identify_by_faf(priv, flow, FAF_IPV4_FRAM,
-			DPAA2_FLOW_FS_TYPE, group, &local_cfg);
-	if (ret)
-		return ret;
-
-	if (!spec_ipv4) {
-		(*device_configured) |= local_cfg;
-		return 0;
-	}
-
-	ret = dpaa2_flow_extract_support((const uint8_t *)mask_ipv4,
-			RTE_FLOW_ITEM_TYPE_IPV4);
-	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of IPv4 not support.");
-		return ret;
-	}
-
-	if (mask_ipv4->hdr.src_addr) {
-		key = &spec_ipv4->hdr.src_addr;
-		mask = &mask_ipv4->hdr.src_addr;
-		size = sizeof(rte_be32_t);
-
-		ret = dpaa2_flow_add_ipaddr_extract_rule(flow, NET_PROT_IPV4,
-				NH_FLD_IPV4_SRC_IP,
-				key, mask, size, priv,
-				group, &local_cfg,
-				DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_ipaddr_extract_rule(flow, NET_PROT_IPV4,
-				NH_FLD_IPV4_SRC_IP,
-				key, mask, size, priv,
-				group, &local_cfg,
-				DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
-	}
-
-	if (mask_ipv4->hdr.dst_addr) {
-		key = &spec_ipv4->hdr.dst_addr;
-		mask = &mask_ipv4->hdr.dst_addr;
-		size = sizeof(rte_be32_t);
-
-		ret = dpaa2_flow_add_ipaddr_extract_rule(flow, NET_PROT_IPV4,
-				NH_FLD_IPV4_DST_IP,
-				key, mask, size, priv,
-				group, &local_cfg,
-				DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-		ret = dpaa2_flow_add_ipaddr_extract_rule(flow, NET_PROT_IPV4,
-				NH_FLD_IPV4_DST_IP,
-				key, mask, size, priv,
-				group, &local_cfg,
-				DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
-	}
-
-	if (mask_ipv4->hdr.next_proto_id) {
-		key = &spec_ipv4->hdr.next_proto_id;
-		mask = &mask_ipv4->hdr.next_proto_id;
-		size = sizeof(uint8_t);
-
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_IP,
-				NH_FLD_IP_PROTO, key,
-				mask, size, priv, group,
-				&local_cfg,
-				DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_IP,
-				NH_FLD_IP_PROTO, key,
-				mask, size, priv, group,
-				&local_cfg,
-				DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
-	}
-
-	(*device_configured) |= local_cfg;
-	return 0;
-}
-
-static int
-dpaa2_configure_flow_ipv6(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
-	const struct rte_flow_attr *attr,
-	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
-{
-	int ret, local_cfg = 0;
-	uint32_t group;
-	const struct rte_flow_item_ipv6 *spec_ipv6 = 0, *mask_ipv6 = 0;
-	const void *key, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	const char zero_cmp[NH_FLD_IPV6_ADDR_SIZE] = {0};
-	int size;
-	const struct rte_flow_item *pattern = &dpaa2_pattern->generic_item;
-
-	group = attr->group;
-
-	/* Parse pattern list to get the matching parameters */
-	spec_ipv6 = pattern->spec;
-	mask_ipv6 = pattern->mask ? pattern->mask : &dpaa2_flow_item_ipv6_mask;
-
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
-	if (dpaa2_pattern->in_tunnel) {
-		if (spec_ipv6) {
-			DPAA2_PMD_ERR("Tunnel-IPv6 distribution not support");
-			return -ENOTSUP;
+	},
+	[RTE_FLOW_ITEM_TYPE_GTP] = {
+		"gtp",
+		dpaa2_flow_general_extract_rule_set,
+		NULL,
+		DPAA2_PARSER_GTP_ID, DPAA2_PARSER_NULL_ID, RTE_FLOW_ITEM_TYPE_GTP,
+		&dpaa2_flow_item_gtp_mask, sizeof(struct rte_flow_item_gtp),
+		false, NET_PROT_GTP, 1,
+		.fields = {
+			NH_FLD_GTP_TEID
+		},
+		.field_offset = {
+			offsetof(struct rte_flow_item_gtp, teid)
+		},
+		.field_size = {
+			sizeof(rte_be32_t)
 		}
-
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAFE_VXLAN_IN_IPV6_FRAM,
-				DPAA2_FLOW_QOS_TYPE, group,
-				&local_cfg);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAFE_VXLAN_IN_IPV6_FRAM,
-				DPAA2_FLOW_FS_TYPE, group,
-				&local_cfg);
-		return ret;
-	}
-
-	ret = dpaa2_flow_identify_by_faf(priv, flow, FAF_IPV6_FRAM,
-			DPAA2_FLOW_QOS_TYPE, group,
-			&local_cfg);
-	if (ret)
-		return ret;
-
-	ret = dpaa2_flow_identify_by_faf(priv, flow, FAF_IPV6_FRAM,
-			DPAA2_FLOW_FS_TYPE, group, &local_cfg);
-	if (ret)
-		return ret;
-
-	if (!spec_ipv6) {
-		(*device_configured) |= local_cfg;
-		return 0;
-	}
-
-	ret = dpaa2_flow_extract_support((const uint8_t *)mask_ipv6,
-			RTE_FLOW_ITEM_TYPE_IPV6);
-	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of IPv6 not support.");
-		return ret;
-	}
-
-	if (memcmp((const char *)&mask_ipv6->hdr.src_addr, zero_cmp, NH_FLD_IPV6_ADDR_SIZE)) {
-		key = &spec_ipv6->hdr.src_addr;
-		mask = &mask_ipv6->hdr.src_addr;
-		size = NH_FLD_IPV6_ADDR_SIZE;
-
-		ret = dpaa2_flow_add_ipaddr_extract_rule(flow, NET_PROT_IPV6,
-				NH_FLD_IPV6_SRC_IP,
-				key, mask, size, priv,
-				group, &local_cfg,
-				DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_ipaddr_extract_rule(flow, NET_PROT_IPV6,
-				NH_FLD_IPV6_SRC_IP,
-				key, mask, size, priv,
-				group, &local_cfg,
-				DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
+	},
+	[RTE_FLOW_ITEM_TYPE_MPLS] = {
+		"mpls",
+		dpaa2_flow_general_extract_rule_set,
+		NULL,
+		DPAA2_PARSER_MPLS_ID, DPAA2_PARSER_NULL_ID, RTE_FLOW_ITEM_TYPE_MPLS,
+		&dpaa2_flow_item_mpls_mask, sizeof(struct rte_flow_item_mpls),
+		false, NET_PROT_MPLS, 1,
+		.fields = {
+			NH_FLD_MPLS_MPLSL_1
+		},
+		.field_offset = {
+			offsetof(struct rte_flow_item_mpls, label_tc_s[0])
+		},
+		.field_size = {
+			sizeof(uint8_t) * 3
+		}
+	},
+	[RTE_FLOW_ITEM_TYPE_PPPOES] = {
+		"pppoes",
+		dpaa2_flow_general_extract_rule_set,
+		NULL,
+		DPAA2_PARSER_MPLS_ID, DPAA2_PARSER_NULL_ID, RTE_FLOW_ITEM_TYPE_PPPOES,
+		&dpaa2_flow_item_pppoe_mask, sizeof(struct rte_flow_item_pppoe),
+		false, NET_PROT_PPPOE, 1,
+		.fields = {
+			NH_FLD_PPPOE_CODE, NH_FLD_PPPOE_SID
+		},
+		.field_offset = {
+			offsetof(struct rte_flow_item_pppoe, code),
+			offsetof(struct rte_flow_item_pppoe, session_id)
+		},
+		.field_size = {
+			sizeof(uint8_t), sizeof(rte_be16_t)
+		}
+	},
+	[RTE_FLOW_ITEM_TYPE_IPV4] = {
+		"ipv4",
+		dpaa2_flow_ip_extract_rule_set,
+		dpaa2_flow_general_tunnel_extract_rule_set,
+		DPAA2_PARSER_IPV4_ID, DPAA2_PARSER_TUNNEL_IPV4_ID, RTE_FLOW_ITEM_TYPE_IPV4,
+		&dpaa2_flow_item_ipv4_mask, sizeof(struct rte_flow_item_ipv4),
+		true, NET_PROT_IP, 4,
+		.fields = {
+			NH_FLD_IP_SRC, NH_FLD_IP_DST, NH_FLD_IP_PROTO, NH_OPT_IP_FRAG
+		},
+		.field_offset = {
+			offsetof(struct rte_flow_item_ipv4, hdr.src_addr),
+			offsetof(struct rte_flow_item_ipv4, hdr.dst_addr),
+			offsetof(struct rte_flow_item_ipv4, hdr.next_proto_id),
+			offsetof(struct rte_flow_item_ipv4, hdr.fragment_offset),
+		},
+		.field_size = {
+			sizeof(rte_be32_t), sizeof(rte_be32_t), sizeof(uint8_t), sizeof(uint8_t)
+		}
+	},
+	[RTE_FLOW_ITEM_TYPE_IPV6] = {
+		"ipv6",
+		dpaa2_flow_ip_extract_rule_set,
+		dpaa2_flow_general_tunnel_extract_rule_set,
+		DPAA2_PARSER_IPV6_ID, DPAA2_PARSER_TUNNEL_IPV6_ID, RTE_FLOW_ITEM_TYPE_IPV6,
+		&dpaa2_flow_item_ipv6_mask, sizeof(struct rte_flow_item_ipv6),
+		true, NET_PROT_IP, 3,
+		.fields = {
+			NH_FLD_IP_SRC, NH_FLD_IP_DST, NH_FLD_IP_PROTO
+		},
+		.field_offset = {
+			offsetof(struct rte_flow_item_ipv6, hdr.src_addr),
+			offsetof(struct rte_flow_item_ipv6, hdr.dst_addr),
+			offsetof(struct rte_flow_item_ipv6, hdr.proto),
+		},
+		.field_size = {
+			RTE_IPV6_ADDR_SIZE, RTE_IPV6_ADDR_SIZE, sizeof(uint8_t)
+		}
+	},
+	[RTE_FLOW_ITEM_TYPE_VXLAN] = {
+		"vxlan",
+		dpaa2_flow_vxlan_extract_rule_set,
+		NULL,
+		DPAA2_PARSER_VXLAN_ID, DPAA2_PARSER_NULL_ID, RTE_FLOW_ITEM_TYPE_VXLAN,
+		&dpaa2_flow_item_vxlan_mask, sizeof(struct rte_flow_item_vxlan),
+	},
+	[RTE_FLOW_ITEM_TYPE_ECPRI] = {
+		"ecpri",
+		dpaa2_flow_ecpri_extract_rule_set,
+		NULL,
+		DPAA2_PARSER_ECPRI_ID, DPAA2_PARSER_NULL_ID, RTE_FLOW_ITEM_TYPE_ECPRI,
+		&dpaa2_flow_item_ecpri_mask, sizeof(struct rte_flow_item_ecpri),
+	},
+	[RTE_FLOW_ITEM_TYPE_GENEVE] = {
+		"geneve",
+		dpaa2_flow_geneve_extract_rule_set,
+		NULL,
+		DPAA2_PARSER_GENEVE_ID, DPAA2_PARSER_NULL_ID, RTE_FLOW_ITEM_TYPE_GENEVE,
+		&dpaa2_flow_item_geneve_mask, sizeof(struct rte_flow_item_geneve),
+	},
+	[RTE_FLOW_ITEM_TYPE_RAW] = {
+		"raw",
+		dpaa2_flow_raw_extract_rule_set,
+		NULL,
+		DPAA2_PARSER_NULL_ID, DPAA2_PARSER_NULL_ID, RTE_FLOW_ITEM_TYPE_RAW
 	}
+};
 
-	if (memcmp((const char *)&mask_ipv6->hdr.dst_addr, zero_cmp, NH_FLD_IPV6_ADDR_SIZE)) {
-		key = &spec_ipv6->hdr.dst_addr;
-		mask = &mask_ipv6->hdr.dst_addr;
-		size = NH_FLD_IPV6_ADDR_SIZE;
-
-		ret = dpaa2_flow_add_ipaddr_extract_rule(flow, NET_PROT_IPV6,
-				NH_FLD_IPV6_DST_IP,
-				key, mask, size, priv,
-				group, &local_cfg,
-				DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
+static inline bool
+dpaa2_flow_is_qos_flow_only(struct dpaa2_dev_priv *priv,
+	uint32_t group)
+{
+	if ((priv->flags & DPAA2_QOS_FLOW_ONLY_STEER_FLAG) || !priv->fs_entries ||
+		RTE_DPAA2_FLOW_GROUP_TYPE_GET(group) == RTE_DPAA2_QOS_GROUP_FLOW)
+		return true;
 
-		ret = dpaa2_flow_add_ipaddr_extract_rule(flow, NET_PROT_IPV6,
-				NH_FLD_IPV6_DST_IP,
-				key, mask, size, priv,
-				group, &local_cfg,
-				DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
-	}
+	return false;
+}
 
-	if (mask_ipv6->hdr.proto) {
-		key = &spec_ipv6->hdr.proto;
-		mask = &mask_ipv6->hdr.proto;
-		size = sizeof(uint8_t);
+static inline uint8_t
+dpaa2_flow_entry_map_get(const uint8_t *entry_map, uint16_t index)
+{
+	uint16_t byte_pos = index / 8;
+	uint16_t bit_pos = index % 8;
 
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_IP,
-				NH_FLD_IP_PROTO, key,
-				mask, size, priv, group,
-				&local_cfg,
-				DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
+	return entry_map[byte_pos] & (1 << bit_pos);
+}
 
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_IP,
-				NH_FLD_IP_PROTO, key,
-				mask, size, priv, group,
-				&local_cfg,
-				DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
-	}
+static inline void
+dpaa2_flow_entry_map_set(uint8_t *entry_map,
+	uint16_t index, int set)
+{
+	uint16_t byte_pos = index / 8;
+	uint16_t bit_pos = index % 8;
 
-	(*device_configured) |= local_cfg;
-	return 0;
+	if (set)
+		entry_map[byte_pos] |= (1 << bit_pos);
+	else
+		entry_map[byte_pos] &= ~(((uint8_t)1) << bit_pos);
 }
 
-static int
-dpaa2_configure_flow_icmp(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
-	const struct rte_flow_attr *attr,
-	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+static void
+dpaa2_flow_generic_flow_deinit(struct dpaa2_generic_flow *flow)
 {
-	int ret, local_cfg = 0;
-	uint32_t group;
-	const struct rte_flow_item_icmp *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	const struct rte_flow_item *pattern = &dpaa2_pattern->generic_item;
-
-	group = attr->group;
+	if (!flow)
+		return;
 
-	/* Parse pattern list to get the matching parameters */
-	spec = pattern->spec;
-	mask = pattern->mask ?
-		pattern->mask : &dpaa2_flow_item_icmp_mask;
+	if (flow->key_addr)
+		rte_free(flow->key_addr);
+	if (flow->mask_addr)
+		rte_free(flow->mask_addr);
+	rte_free(flow);
+}
 
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
+static struct dpaa2_generic_flow *
+dpaa2_flow_generic_flow_init(struct dpaa2_dev_priv *priv, uint16_t idx, int no_key,
+	enum dpaa2_flow_dist_type type, uint8_t tc_id)
+{
+	struct dpaa2_generic_flow *flow = NULL;
+	uint64_t iova;
 
-	if (dpaa2_pattern->in_tunnel) {
-		DPAA2_PMD_ERR("Tunnel-ICMP distribution not support");
-		return -ENOTSUP;
+	flow = rte_zmalloc(NULL, sizeof(struct dpaa2_generic_flow),
+			RTE_CACHE_LINE_SIZE);
+	if (!flow) {
+		DPAA2_PMD_ERR("Failure to allocate flow memory");
+		goto mem_failure;
 	}
+	flow->type = type;
+	flow->tc_id = tc_id;
+	flow->priv = priv;
 
-	if (!spec) {
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_ICMP_FRAM, DPAA2_FLOW_QOS_TYPE,
-				group, &local_cfg);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_ICMP_FRAM, DPAA2_FLOW_FS_TYPE,
-				group, &local_cfg);
-		if (ret)
-			return ret;
+	if (no_key)
+		return flow;
 
-		(*device_configured) |= local_cfg;
-		return 0;
+	/* Allocate DMA'ble memory to write the qos rules */
+	flow->key_addr = rte_zmalloc(NULL, DPAA2_EXTRACT_ALLOC_KEY_MAX_SIZE, 0);
+	if (!flow->key_addr) {
+		DPAA2_PMD_ERR("Failure to allocate flow key memory");
+		goto mem_failure;
 	}
-
-	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
-		RTE_FLOW_ITEM_TYPE_ICMP);
-	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of ICMP not support.");
-
-		return ret;
+	iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(flow->key_addr,
+			DPAA2_EXTRACT_ALLOC_KEY_MAX_SIZE);
+	if (iova == RTE_BAD_IOVA) {
+		DPAA2_PMD_ERR("Failure to map for key(%p)", flow->key_addr);
+		goto mem_failure;
 	}
+	flow->rule_cfg.key_iova = iova;
 
-	if (mask->hdr.icmp_type) {
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_ICMP,
-			NH_FLD_ICMP_TYPE, &spec->hdr.icmp_type,
-			&mask->hdr.icmp_type, sizeof(uint8_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_ICMP,
-			NH_FLD_ICMP_TYPE, &spec->hdr.icmp_type,
-			&mask->hdr.icmp_type, sizeof(uint8_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
+	flow->mask_addr = rte_zmalloc(NULL, DPAA2_EXTRACT_ALLOC_KEY_MAX_SIZE, 0);
+	if (!flow->mask_addr) {
+		DPAA2_PMD_ERR("Failure to allocate flow mask memory");
+		goto mem_failure;
 	}
-
-	if (mask->hdr.icmp_code) {
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_ICMP,
-			NH_FLD_ICMP_CODE, &spec->hdr.icmp_code,
-			&mask->hdr.icmp_code, sizeof(uint8_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_ICMP,
-			NH_FLD_ICMP_CODE, &spec->hdr.icmp_code,
-			&mask->hdr.icmp_code, sizeof(uint8_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
+	iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(flow->mask_addr,
+			DPAA2_EXTRACT_ALLOC_KEY_MAX_SIZE);
+	if (iova == RTE_BAD_IOVA) {
+		DPAA2_PMD_ERR("Failure to map for mask(%p)", flow->mask_addr);
+		goto mem_failure;
 	}
+	flow->rule_cfg.mask_iova = iova;
+	flow->ip_key = NET_PROT_NONE;
+	flow->entry_index = idx;
 
-	(*device_configured) |= local_cfg;
+	return flow;
 
-	return 0;
+mem_failure:
+	dpaa2_flow_generic_flow_deinit(flow);
+
+	return NULL;
 }
 
-static int
-dpaa2_configure_flow_udp(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
-	const struct rte_flow_attr *attr,
-	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_dpaa2_flow_group_set_miss_actions, 23.11)
+int
+rte_dpaa2_flow_group_set_miss_actions(uint16_t port_id,
+	uint32_t group_id, uint32_t type, const struct rte_flow_group_attr *attr,
+	const struct rte_flow_action actions[], struct rte_flow_error *error)
 {
-	int ret, local_cfg = 0;
-	uint32_t group;
-	const struct rte_flow_item_udp *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	const struct rte_flow_item *pattern = &dpaa2_pattern->generic_item;
-
-	group = attr->group;
-
-	/* Parse pattern list to get the matching parameters */
-	spec = pattern->spec;
-	mask = pattern->mask ?
-		pattern->mask : &dpaa2_flow_item_udp_mask;
-
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
-	if (dpaa2_pattern->in_tunnel) {
-		if (spec) {
-			DPAA2_PMD_ERR("Tunnel-UDP distribution not support");
-			return -ENOTSUP;
-		}
-
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAFE_VXLAN_IN_UDP_FRAM,
-				DPAA2_FLOW_QOS_TYPE, group,
-				&local_cfg);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAFE_VXLAN_IN_UDP_FRAM,
-				DPAA2_FLOW_FS_TYPE, group,
-				&local_cfg);
-		return ret;
-	}
-
-	ret = dpaa2_flow_identify_by_faf(priv, flow,
-			FAF_UDP_FRAM, DPAA2_FLOW_QOS_TYPE,
-			group, &local_cfg);
-	if (ret)
-		return ret;
-
-	ret = dpaa2_flow_identify_by_faf(priv, flow,
-			FAF_UDP_FRAM, DPAA2_FLOW_FS_TYPE,
-			group, &local_cfg);
-	if (ret)
-		return ret;
-
-	if (!spec) {
-		(*device_configured) |= local_cfg;
-		return 0;
-	}
-
-	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
-		RTE_FLOW_ITEM_TYPE_UDP);
-	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of UDP not support.");
-
-		return ret;
-	}
-
-	if (mask->hdr.src_port) {
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_UDP,
-			NH_FLD_UDP_PORT_SRC, &spec->hdr.src_port,
-			&mask->hdr.src_port, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
+	RTE_DPAA2_FLOW_GROUP_TYPE_SET(group_id, type);
+	return rte_flow_group_set_miss_actions(port_id,
+		group_id, attr, actions, error);
+}
 
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_UDP,
-			NH_FLD_UDP_PORT_SRC, &spec->hdr.src_port,
-			&mask->hdr.src_port, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
-	}
+static inline void
+dpaa2_flow_extracts_log(const struct dpaa2_dev_priv *priv,
+	const char *prefix, uint8_t tc_id)
+{
+	const struct dpaa2_flow_tbl_profile *tbl_profile;
+	const struct dpaa2_key_profile *key_profile;
 
-	if (mask->hdr.dst_port) {
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_UDP,
-			NH_FLD_UDP_PORT_DST, &spec->hdr.dst_port,
-			&mask->hdr.dst_port, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
+	if (!(priv->flags & DPAA2_FLOW_API_DEBUG_FLAG))
+		return;
 
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_UDP,
-			NH_FLD_UDP_PORT_DST, &spec->hdr.dst_port,
-			&mask->hdr.dst_port, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
-	}
+	tbl_profile = tc_id >= MAX_TCS ?
+		&priv->flow_profile.qos_profile : &priv->flow_profile.tc_profile[tc_id];
+	key_profile = &tbl_profile->key_profile;
 
-	(*device_configured) |= local_cfg;
+	DPAA2_FLOW_DUMP("%s %s's", prefix, priv->eth_dev->data->name);
+	if (tc_id >= MAX_TCS)
+		DPAA2_FLOW_DUMP(" QoS");
+	else
+		DPAA2_FLOW_DUMP(" FS[%d]", tc_id);
 
-	return 0;
+	DPAA2_FLOW_DUMP(" table: %d extracts/%d entries\n",
+		key_profile->dpkg.num_extracts, tbl_profile->entry_num);
+	dpaa2_dump_dpkg(&key_profile->dpkg);
 }
 
-static int
-dpaa2_configure_flow_tcp(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
-	const struct rte_flow_attr *attr,
-	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+static inline void
+dpaa2_flow_steering_entry_log(const char *log_info,
+	const struct dpaa2_generic_flow *flow)
 {
-	int ret, local_cfg = 0;
-	uint32_t group;
-	const struct rte_flow_item_tcp *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	const struct rte_flow_item *pattern = &dpaa2_pattern->generic_item;
-
-	group = attr->group;
-
-	/* Parse pattern list to get the matching parameters */
-	spec = pattern->spec;
-	mask = pattern->mask ?
-		pattern->mask : &dpaa2_flow_item_tcp_mask;
+	int idx;
+	struct rte_eth_dev *dev = flow->priv->eth_dev;
+	const struct dpaa2_dev_fs_action *fs_action = &flow->fs_action;
+	const struct dpni_fs_action_cfg *fs_cfg = &fs_action->action_cfg;
 
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
+	if (!(flow->priv->flags & DPAA2_FLOW_API_DEBUG_FLAG))
+		return;
 
-	if (dpaa2_pattern->in_tunnel) {
-		if (spec) {
-			DPAA2_PMD_ERR("Tunnel-TCP distribution not support");
-			return -ENOTSUP;
+	if (flow->type == DPAA2_FLOW_QOS_TYPE) {
+		DPAA2_FLOW_DUMP("%s: %s QoS entry[%d](size %d/%d) to select TC[%d]",
+			dev->data->name, log_info, flow->entry_index, flow->rule_size,
+			flow->rule_cfg.key_size, flow->tc_id);
+	} else {
+		DPAA2_FLOW_DUMP("%s: %s FS[%d]/entry[%d](size %d/%d)",
+			dev->data->name, log_info, flow->tc_id,
+			flow->entry_index, flow->rule_size,
+			flow->rule_cfg.key_size);
+	}
+
+	DPAA2_FLOW_DUMP("\nkey: ");
+	for (idx = 0; idx < flow->rule_size; idx++)
+		DPAA2_FLOW_DUMP("%02x ", flow->key_addr[idx]);
+	if (flow->rule_size > 0)
+		DPAA2_FLOW_DUMP("\n");
+
+	DPAA2_FLOW_DUMP("mask:");
+	for (idx = 0; idx < flow->rule_size; idx++)
+		DPAA2_FLOW_DUMP("%02x ", flow->mask_addr[idx]);
+	if (flow->rule_size > 0)
+		DPAA2_FLOW_DUMP("\n");
+	DPAA2_FLOW_DUMP("Action: ");
+	if (flow->type == DPAA2_FLOW_QOS_TYPE) {
+		if (flow->action_type == RTE_FLOW_ACTION_TYPE_QUEUE)
+			DPAA2_FLOW_DUMP("Receive to flow%d", fs_cfg->flow_id);
+		else if (flow->action_type == RTE_FLOW_ACTION_TYPE_JUMP)
+			DPAA2_FLOW_DUMP("Jump to TC%d", flow->tc_id);
+		else
+			DPAA2_FLOW_DUMP("Un-supported QoS action type(%d)", flow->action_type);
+	} else {
+		if (flow->action_type == RTE_FLOW_ACTION_TYPE_QUEUE) {
+			DPAA2_FLOW_DUMP("Receive to flow%d", fs_cfg->flow_id);
+		} else if (flow->action_type == RTE_FLOW_ACTION_TYPE_PORT_ID ||
+			flow->action_type == RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT) {
+			DPAA2_FLOW_DUMP("Re-direct to port(s): ");
+			for (idx = 0; idx < fs_cfg->num_tokens; idx++) {
+				DPAA2_FLOW_DUMP("%s", fs_action->dst_name[idx]);
+				if ((idx + 1) < fs_action->action_cfg.num_tokens)
+					DPAA2_FLOW_DUMP(", ");
+			}
+		} else if (flow->action_type == RTE_FLOW_ACTION_TYPE_DROP) {
+			DPAA2_FLOW_DUMP("Drop");
+		} else {
+			DPAA2_FLOW_DUMP("Un-supported FS action type(%d)", flow->action_type);
 		}
-
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAFE_VXLAN_IN_TCP_FRAM,
-				DPAA2_FLOW_QOS_TYPE, group,
-				&local_cfg);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-						 FAFE_VXLAN_IN_TCP_FRAM,
-						 DPAA2_FLOW_FS_TYPE, group,
-						 &local_cfg);
-		return ret;
 	}
+	DPAA2_FLOW_DUMP("\n");
+}
 
-	ret = dpaa2_flow_identify_by_faf(priv, flow,
-			FAF_TCP_FRAM, DPAA2_FLOW_QOS_TYPE,
-			group, &local_cfg);
-	if (ret)
-		return ret;
+static inline void
+dpaa2_dump_extract_map(const struct dpaa2_dev_priv *priv,
+	const char *prefix, enum dpaa2_flow_dist_type dist_type,
+	uint8_t group)
+{
+	int idx, avail, end = 0;
+	const struct dpaa2_flow_tbl_profile *tbl_profile;
 
-	ret = dpaa2_flow_identify_by_faf(priv, flow,
-			FAF_TCP_FRAM, DPAA2_FLOW_FS_TYPE,
-			group, &local_cfg);
-	if (ret)
-		return ret;
+	if (!(priv->flags & DPAA2_FLOW_API_DEBUG_FLAG))
+		return;
 
-	if (!spec) {
-		(*device_configured) |= local_cfg;
-		return 0;
-	}
+	DPAA2_FLOW_DUMP("%s: %s\n", priv->eth_dev->data->name, prefix);
 
-	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
-		RTE_FLOW_ITEM_TYPE_TCP);
-	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of TCP not support.");
+	if (dist_type == DPAA2_FLOW_QOS_TYPE) {
+		tbl_profile = &priv->flow_profile.qos_profile;
+		DPAA2_FLOW_DUMP("QoS entry map:");
+		if (!tbl_profile->entry_num) {
+			DPAA2_FLOW_DUMP(" empty\n");
+			goto qos_dump_end;
+		}
+		DPAA2_FLOW_DUMP("\n");
+		for (idx = 0; idx < priv->qos_entries; idx++) {
+			avail = 0;
+			end = 0;
+			if (dpaa2_flow_entry_map_get(tbl_profile->entry_map, idx))
+				avail = 1;
+			DPAA2_FLOW_DUMP("%d ", avail);
+			if (!((idx + 1) % 16) || (idx + 1) == priv->qos_entries) {
+				end = 1;
+				DPAA2_FLOW_DUMP("\n");
+			}
+		}
 
-		return ret;
+qos_dump_end:
+		goto flush_string;
 	}
 
-	if (mask->hdr.src_port) {
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_TCP,
-			NH_FLD_TCP_PORT_SRC, &spec->hdr.src_port,
-			&mask->hdr.src_port, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_TCP,
-			NH_FLD_TCP_PORT_SRC, &spec->hdr.src_port,
-			&mask->hdr.src_port, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
+	tbl_profile = &priv->flow_profile.tc_profile[group];
+	if (!tbl_profile->entry_num) {
+		DPAA2_FLOW_DUMP("FS[%d] table is empty\n", group);
+		return;
 	}
 
-	if (mask->hdr.dst_port) {
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_TCP,
-			NH_FLD_TCP_PORT_DST, &spec->hdr.dst_port,
-			&mask->hdr.dst_port, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_TCP,
-			NH_FLD_TCP_PORT_DST, &spec->hdr.dst_port,
-			&mask->hdr.dst_port, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
+	DPAA2_FLOW_DUMP("FS[%d] %d entries:\n", group, tbl_profile->entry_num);
+	for (idx = 0; idx < priv->fs_entries; idx++) {
+		avail = 0;
+		end = 0;
+		if (dpaa2_flow_entry_map_get(tbl_profile->entry_map, idx))
+			avail = 1;
+		DPAA2_FLOW_DUMP("%d ", avail);
+		if (!((idx + 1) % 16) || (idx + 1) == priv->fs_entries) {
+				end = 1;
+				DPAA2_FLOW_DUMP("\n");
+			}
 	}
-
-	(*device_configured) |= local_cfg;
-
-	return 0;
+flush_string:
+	if (!end)
+		DPAA2_FLOW_DUMP("\n");
 }
 
 static int
-dpaa2_configure_flow_esp(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
-	const struct rte_flow_attr *attr,
-	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+dpaa2_flow_rss_conf_to_item(uint64_t req_dist_set,
+	struct rte_flow_item *items, uint8_t *spec_buf,
+	uint32_t buf_max)
 {
-	int ret, local_cfg = 0;
-	uint32_t group;
-	const struct rte_flow_item_esp *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	const struct rte_flow_item *pattern =
-		&dpaa2_pattern->generic_item;
-
-	group = attr->group;
-
-	/* Parse pattern list to get the matching parameters */
-	spec = pattern->spec;
-	mask = pattern->mask ?
-		pattern->mask : &dpaa2_flow_item_esp_mask;
-
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
-	if (dpaa2_pattern->in_tunnel) {
-		DPAA2_PMD_ERR("Tunnel-ESP distribution not support");
+	uint32_t i = 0, offset = 0;
+	uint64_t l2_mask, vlan_mask, ipv4_mask, ipv6_mask;
+	uint64_t dist_supported, udp_mask, tcp_mask, sctp_mask;
+	struct rte_flow_item_eth *eth = NULL;
+	struct rte_flow_item_pppoe *pppoe = NULL;
+	struct rte_flow_item_esp *esp = NULL;
+	struct rte_flow_item_ah *ah = NULL;
+	struct rte_flow_item_vlan *vlan = NULL;
+	struct rte_flow_item_mpls *mpls = NULL;
+	struct rte_flow_item_gtp *gtpu = NULL;
+	struct rte_flow_item_udp *udp = NULL;
+	struct rte_flow_item_tcp *tcp = NULL;
+	struct rte_flow_item_sctp *sctp = NULL;
+	struct rte_flow_item_ipv4 *ipv4 = NULL;
+
+	l2_mask = RTE_ETH_RSS_L2_PAYLOAD | RTE_ETH_RSS_ETH;
+	vlan_mask = RTE_ETH_RSS_C_VLAN | RTE_ETH_RSS_S_VLAN;
+	ipv4_mask = RTE_ETH_RSS_IPV4 | RTE_ETH_RSS_FRAG_IPV4 |
+		RTE_ETH_RSS_NONFRAG_IPV4_OTHER;
+	ipv6_mask = RTE_ETH_RSS_IPV6 | RTE_ETH_RSS_FRAG_IPV6 |
+		RTE_ETH_RSS_IPV6_EX| RTE_ETH_RSS_NONFRAG_IPV6_OTHER;
+	udp_mask = RTE_ETH_RSS_NONFRAG_IPV4_UDP |
+		RTE_ETH_RSS_NONFRAG_IPV6_UDP |
+		RTE_ETH_RSS_IPV6_UDP_EX;
+	tcp_mask = RTE_ETH_RSS_NONFRAG_IPV4_TCP |
+		RTE_ETH_RSS_NONFRAG_IPV6_TCP |
+		RTE_ETH_RSS_IPV6_TCP_EX;
+	sctp_mask = RTE_ETH_RSS_NONFRAG_IPV4_SCTP |
+		RTE_ETH_RSS_NONFRAG_IPV6_SCTP;
+	dist_supported = l2_mask | vlan_mask | ipv4_mask |
+		ipv6_mask | udp_mask | tcp_mask | sctp_mask |
+		RTE_ETH_RSS_GTPU | RTE_ETH_RSS_PPPOE |
+		RTE_ETH_RSS_ESP | RTE_ETH_RSS_AH | RTE_ETH_RSS_MPLS;
+	if ((~dist_supported) & req_dist_set) {
+		DPAA2_PMD_ERR("%s: Unsupported dist type:0x%lx",
+			__func__, (~dist_supported) & req_dist_set);
 		return -ENOTSUP;
 	}
 
-	ret = dpaa2_flow_identify_by_faf(priv, flow,
-			FAF_IPSEC_ESP_FRAM, DPAA2_FLOW_QOS_TYPE,
-			group, &local_cfg);
-	if (ret)
-		return ret;
-
-	ret = dpaa2_flow_identify_by_faf(priv, flow,
-			FAF_IPSEC_ESP_FRAM, DPAA2_FLOW_FS_TYPE,
-			group, &local_cfg);
-	if (ret)
-		return ret;
-
-	if (!spec) {
-		(*device_configured) |= local_cfg;
-		return 0;
-	}
-
-	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
-		RTE_FLOW_ITEM_TYPE_ESP);
-	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of ESP not support.");
-
-		return ret;
-	}
-
-	if (mask->hdr.spi) {
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_IPSEC_ESP,
-			NH_FLD_IPSEC_ESP_SPI, &spec->hdr.spi,
-			&mask->hdr.spi, sizeof(rte_be32_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_IPSEC_ESP,
-			NH_FLD_IPSEC_ESP_SPI, &spec->hdr.spi,
-			&mask->hdr.spi, sizeof(rte_be32_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
+	if (req_dist_set & l2_mask) {
+		items[i].type = RTE_FLOW_ITEM_TYPE_ETH;
+		eth = (void *)(spec_buf + offset);
+		memset(eth, 0, sizeof(struct rte_flow_item_eth));
+		memset(eth->dst.addr_bytes, 0xff, RTE_ETHER_ADDR_LEN);
+		memset(eth->src.addr_bytes, 0xff, RTE_ETHER_ADDR_LEN);
+		eth->type = RTE_BE16(0xffff);
+		items[i].spec = eth;
+		items[i].mask = eth;
+		i++;
+		offset += sizeof(struct rte_flow_item_eth);
+		offset = RTE_CACHE_LINE_ROUNDUP(offset);
+		if (offset > buf_max)
+			return -ENOMEM;
+	}
+
+	if (req_dist_set & RTE_ETH_RSS_PPPOE) {
+		items[i].type = RTE_FLOW_ITEM_TYPE_PPPOES;
+		pppoe = (void *)(spec_buf + offset);
+		memset(pppoe, 0, sizeof(struct rte_flow_item_pppoe));
+		pppoe->session_id = RTE_BE16(0xffff);
+		items[i].spec = pppoe;
+		items[i].mask = pppoe;
+		i++;
+		offset += sizeof(struct rte_flow_item_pppoe);
+		offset = RTE_CACHE_LINE_ROUNDUP(offset);
+		if (offset > buf_max)
+			return -ENOMEM;
+	}
+
+	if (req_dist_set & RTE_ETH_RSS_ESP) {
+		items[i].type = RTE_FLOW_ITEM_TYPE_ESP;
+		esp = (void *)(spec_buf + offset);
+		memset(esp, 0, sizeof(struct rte_flow_item_esp));
+		esp->hdr.spi = RTE_BE32(0xffffffff);
+		items[i].spec = esp;
+		items[i].mask = esp;
+		i++;
+		offset += sizeof(struct rte_flow_item_esp);
+		offset = RTE_CACHE_LINE_ROUNDUP(offset);
+		if (offset > buf_max)
+			return -ENOMEM;
+	}
+
+	if (req_dist_set & RTE_ETH_RSS_AH) {
+		items[i].type = RTE_FLOW_ITEM_TYPE_AH;
+		ah = (void *)(spec_buf + offset);
+		memset(ah, 0, sizeof(struct rte_flow_item_ah));
+		ah->spi = RTE_BE32(0xffffffff);
+		items[i].spec = ah;
+		items[i].mask = ah;
+		i++;
+		offset += sizeof(struct rte_flow_item_ah);
+		offset = RTE_CACHE_LINE_ROUNDUP(offset);
+		if (offset > buf_max)
+			return -ENOMEM;
+	}
+
+	if (req_dist_set & vlan_mask) {
+		items[i].type = RTE_FLOW_ITEM_TYPE_VLAN;
+		vlan = (void *)(spec_buf + offset);
+		memset(vlan, 0, sizeof(struct rte_flow_item_vlan));
+		vlan->tci = RTE_BE16(0xffff);
+		items[i].spec = vlan;
+		items[i].mask = vlan;
+		i++;
+		offset += sizeof(struct rte_flow_item_vlan);
+		offset = RTE_CACHE_LINE_ROUNDUP(offset);
+		if (offset > buf_max)
+			return -ENOMEM;
+	}
+
+	if (req_dist_set & RTE_ETH_RSS_MPLS) {
+		items[i].type = RTE_FLOW_ITEM_TYPE_MPLS;
+		mpls = (void *)(spec_buf + offset);
+		memset(mpls, 0, sizeof(struct rte_flow_item_mpls));
+		memset(mpls->label_tc_s, 0xff, 3);
+		items[i].spec = mpls;
+		items[i].mask = mpls;
+		i++;
+		offset += sizeof(struct rte_flow_item_mpls);
+		offset = RTE_CACHE_LINE_ROUNDUP(offset);
+		if (offset > buf_max)
+			return -ENOMEM;
+	}
+
+	if (req_dist_set & RTE_ETH_RSS_GTPU) {
+		items[i].type = RTE_FLOW_ITEM_TYPE_GTPU;
+		gtpu = (void *)(spec_buf + offset);
+		memset(gtpu, 0, sizeof(struct rte_flow_item_gtp));
+		gtpu->teid = RTE_BE32(0xffffffff);
+		items[i].spec = gtpu;
+		items[i].mask = gtpu;
+		i++;
+		offset += sizeof(struct rte_flow_item_gtp);
+		offset = RTE_CACHE_LINE_ROUNDUP(offset);
+		if (offset > buf_max)
+			return -ENOMEM;
+	}
+
+	if (req_dist_set & udp_mask) {
+		items[i].type = RTE_FLOW_ITEM_TYPE_UDP;
+		udp = (void *)(spec_buf + offset);
+		memset(udp, 0, sizeof(struct rte_flow_item_udp));
+		udp->hdr.src_port = RTE_BE16(0xffff);
+		udp->hdr.dst_port = RTE_BE16(0xffff);
+		items[i].spec = udp;
+		items[i].mask = udp;
+		i++;
+		offset += sizeof(struct rte_flow_item_udp);
+		offset = RTE_CACHE_LINE_ROUNDUP(offset);
+		if (offset > buf_max)
+			return -ENOMEM;
+	}
+
+	if (req_dist_set & tcp_mask) {
+		items[i].type = RTE_FLOW_ITEM_TYPE_TCP;
+		tcp = (void *)(spec_buf + offset);
+		memset(tcp, 0, sizeof(struct rte_flow_item_tcp));
+		tcp->hdr.src_port = RTE_BE16(0xffff);
+		tcp->hdr.dst_port = RTE_BE16(0xffff);
+		items[i].spec = tcp;
+		items[i].mask = tcp;
+		i++;
+		offset += sizeof(struct rte_flow_item_tcp);
+		offset = RTE_CACHE_LINE_ROUNDUP(offset);
+		if (offset > buf_max)
+			return -ENOMEM;
+	}
+
+	if (req_dist_set & sctp_mask) {
+		items[i].type = RTE_FLOW_ITEM_TYPE_SCTP;
+		sctp = (void *)(spec_buf + offset);
+		memset(sctp, 0, sizeof(struct rte_flow_item_sctp));
+		sctp->hdr.src_port = RTE_BE16(0xffff);
+		sctp->hdr.dst_port = RTE_BE16(0xffff);
+		items[i].spec = sctp;
+		items[i].mask = sctp;
+		i++;
+		offset += sizeof(struct rte_flow_item_sctp);
+		offset = RTE_CACHE_LINE_ROUNDUP(offset);
+		if (offset > buf_max)
+			return -ENOMEM;
+	}
+
+	if (req_dist_set & ipv4_mask) {
+		items[i].type = RTE_FLOW_ITEM_TYPE_IPV4;
+		ipv4 = (void *)(spec_buf + offset);
+		memset(ipv4, 0, sizeof(struct rte_flow_item_ipv4));
+		ipv4->hdr.src_addr = RTE_BE32(0xffffffff);
+		ipv4->hdr.dst_addr = RTE_BE32(0xffffffff);
+		ipv4->hdr.next_proto_id = 0xff;
+		items[i].spec = ipv4;
+		items[i].mask = ipv4;
+		i++;
+		offset += sizeof(struct rte_flow_item_ipv4);
+		offset = RTE_CACHE_LINE_ROUNDUP(offset);
+		if (offset > buf_max)
+			return -ENOMEM;
 	}
 
-	if (mask->hdr.seq) {
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_IPSEC_ESP,
-			NH_FLD_IPSEC_ESP_SEQUENCE_NUM, &spec->hdr.seq,
-			&mask->hdr.seq, sizeof(rte_be32_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_IPSEC_ESP,
-			NH_FLD_IPSEC_ESP_SEQUENCE_NUM, &spec->hdr.seq,
-			&mask->hdr.seq, sizeof(rte_be32_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
-	}
+	items[i].type = RTE_FLOW_ITEM_TYPE_END;
 
-	(*device_configured) |= local_cfg;
+	return i;
+}
 
-	return 0;
+static inline int
+dpaa2_flow_is_steering_flow(struct dpaa2_generic_flow *flow)
+{
+	if (flow->type & (DPAA2_FLOW_QOS_TYPE | DPAA2_FLOW_FS_TYPE))
+		return true;
+	return false;
 }
 
 static int
-dpaa2_configure_flow_ah(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
-	const struct rte_flow_attr *attr,
-	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+dpaa2_flow_add_steering_rule(struct dpaa2_generic_flow *flow, int update)
 {
-	int ret, local_cfg = 0;
-	uint32_t group;
-	const struct rte_flow_item_ah *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	const struct rte_flow_item *pattern =
-		&dpaa2_pattern->generic_item;
-
-	group = attr->group;
+	struct dpaa2_dev_priv *priv = flow->priv;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
+	int ret;
+	struct fsl_mc_io *dpni = priv->hw;
+	uint8_t flags = DPNI_QOS_OPT_SET_TC_ONLY;
+	struct dpni_fs_action_cfg action_cfg;
 
-	/* Parse pattern list to get the matching parameters */
-	spec = pattern->spec;
-	mask = pattern->mask ?
-		pattern->mask : &dpaa2_flow_item_ah_mask;
+	if (!dpaa2_flow_is_steering_flow(flow)) {
+		DPAA2_PMD_ERR("%s: flow(type=%x) is not steering flow",
+			__func__, flow->type);
+		return -EINVAL;
+	}
 
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
+	rte_memcpy(&action_cfg, &flow->fs_action, sizeof(action_cfg));
+	if (update) {
+		flags |= DPNI_QOS_OPT_UPDATE_IF_EXISTS;
+		action_cfg.options |= DPNI_FS_OPT_UPDATE_IF_EXISTS;
+	}
 
-	if (dpaa2_pattern->in_tunnel) {
-		DPAA2_PMD_ERR("Tunnel-AH distribution not support");
-		return -ENOTSUP;
+	if (!update) {
+		if (flow->type == DPAA2_FLOW_QOS_TYPE)
+			tbl_profile = &priv->flow_profile.qos_profile;
+		else
+			tbl_profile = &priv->flow_profile.tc_profile[flow->tc_id];
+		if (dpaa2_flow_entry_map_get(tbl_profile->entry_map, flow->entry_index)) {
+			DPAA2_PMD_ERR("%s table's rule(%d) exists.",
+				flow->type == DPAA2_FLOW_QOS_TYPE ? "QoS" : "FS",
+				flow->entry_index);
+			dpaa2_dump_extract_map(priv, "Entry conflicts!", flow->type, flow->tc_id);
+			return -EINVAL;
+		}
 	}
 
-	ret = dpaa2_flow_identify_by_faf(priv, flow,
-			FAF_IPSEC_AH_FRAM, DPAA2_FLOW_QOS_TYPE,
-			group, &local_cfg);
-	if (ret)
-		return ret;
+	dpaa2_flow_steering_entry_log(update ? "Update" : "Add", flow);
 
-	ret = dpaa2_flow_identify_by_faf(priv, flow,
-			FAF_IPSEC_AH_FRAM, DPAA2_FLOW_FS_TYPE,
-			group, &local_cfg);
-	if (ret)
+	if (flow->type == DPAA2_FLOW_QOS_TYPE) {
+		if (flow->action_type == RTE_FLOW_ACTION_TYPE_QUEUE)
+			flags |= DPNI_QOS_OPT_SET_FLOW_ID;
+		ret = dpni_add_qos_entry(dpni, CMD_PRI_LOW,
+			priv->token, &flow->rule_cfg, flow->tc_id,
+			flow->entry_index, flags, action_cfg.flow_id);
+	} else if (priv->mc_rev >= DPAA2_FLOW_FRM_REPLICATION_ACTION_MC_REV) {
+		ret = dpni_add_fs_entry(dpni, CMD_PRI_LOW,
+			priv->token, flow->tc_id, flow->entry_index,
+			&flow->rule_cfg, &action_cfg);
+	} else {
+		ret = dpni_add_fs_entry_legacy(dpni, CMD_PRI_LOW,
+			priv->token, flow->tc_id, flow->entry_index,
+			&flow->rule_cfg, &action_cfg);
+	}
+	if (ret) {
+		DPAA2_PMD_ERR("Failed(%d) to %s rule(%d) to %s table",
+			ret, update ? "Update" : "Add", flow->entry_index,
+			flow->type == DPAA2_FLOW_QOS_TYPE ? "QoS" : "FS");
 		return ret;
+	}
 
-	if (!spec) {
-		(*device_configured) |= local_cfg;
-		return 0;
+	if (!update) {
+		dpaa2_flow_entry_map_set(tbl_profile->entry_map, flow->entry_index, 1);
+		tbl_profile->entry_num++;
 	}
 
-	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
-		RTE_FLOW_ITEM_TYPE_AH);
-	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of AH not support.");
+	return 0;
+}
 
-		return ret;
-	}
+static int
+dpaa2_flow_add_all_steering_rule(struct dpaa2_dev_priv *priv,
+	enum dpaa2_flow_dist_type dist_type, uint16_t entry_size, uint8_t tc_id)
+{
+	struct dpaa2_dev_flow *curr = LIST_FIRST(&priv->flows);
+	struct dpaa2_generic_flow *flow;
+	int ret;
 
-	if (mask->spi) {
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_IPSEC_AH,
-			NH_FLD_IPSEC_AH_SPI, &spec->spi,
-			&mask->spi, sizeof(rte_be32_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
+	if (dist_type != DPAA2_FLOW_QOS_TYPE && dist_type != DPAA2_FLOW_FS_TYPE)
+		return -EINVAL;
 
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_IPSEC_AH,
-			NH_FLD_IPSEC_AH_SPI, &spec->spi,
-			&mask->spi, sizeof(rte_be32_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+	while (curr) {
+		flow = dpaa2_flow_generic_flow(curr, dist_type, tc_id);
+		if (!flow)
+			goto next_flow;
+		flow->rule_cfg.key_size = entry_size;
+		ret = dpaa2_flow_add_steering_rule(flow, false);
 		if (ret)
 			return ret;
+next_flow:
+		curr = LIST_NEXT(curr, next);
 	}
 
-	if (mask->seq_num) {
-		DPAA2_PMD_ERR("AH seq distribution not support");
-		return -ENOTSUP;
-	}
+	return 0;
+}
+
+static inline int
+dpaa2_flow_verify_steering_entry(struct dpaa2_dev_priv *priv,
+	uint16_t tc, uint16_t entry_idx, enum dpaa2_flow_dist_type dist_type)
+{
+	struct dpaa2_dev_flow *curr = LIST_FIRST(&priv->flows);
+	struct dpaa2_generic_flow *flow;
 
-	(*device_configured) |= local_cfg;
+	while (curr) {
+		flow = dpaa2_flow_generic_flow(curr, dist_type, tc);
+		if (flow && flow->entry_index == entry_idx) {
+			if (dist_type == DPAA2_FLOW_QOS_TYPE)
+				DPAA2_PMD_ERR("Flow QoS.entry[%d] exists", entry_idx);
+			else if (dist_type == DPAA2_FLOW_FS_TYPE)
+				DPAA2_PMD_ERR("Flow TC[%d].entry[%d] exists", tc, entry_idx);
+			else
+				DPAA2_PMD_ERR("It is not steering flow(type=%x)", dist_type);
+			return -EEXIST;
+		}
+		curr = LIST_NEXT(curr, next);
+	}
 
 	return 0;
 }
 
-static int
-dpaa2_configure_flow_sctp(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
-	const struct rte_flow_attr *attr,
-	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+static inline struct rte_eth_dev *
+dpaa2_flow_redirect_dev(struct dpaa2_dev_priv *priv,
+	const struct rte_flow_action *action)
 {
-	int ret, local_cfg = 0;
-	uint32_t group;
-	const struct rte_flow_item_sctp *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	const struct rte_flow_item *pattern = &dpaa2_pattern->generic_item;
+	const struct rte_flow_action_port_id *port_id;
+	const struct rte_flow_action_ethdev *ethdev;
+	int idx = -1;
+	struct rte_eth_dev *dest_dev;
 
-	group = attr->group;
+	if (action->type == RTE_FLOW_ACTION_TYPE_PORT_ID) {
+		port_id = action->conf;
+		if (!port_id->original)
+			idx = port_id->id;
+	} else if (action->type == RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT) {
+		ethdev = action->conf;
+		idx = ethdev->port_id;
+	} else {
+		return NULL;
+	}
 
-	/* Parse pattern list to get the matching parameters */
-	spec = pattern->spec;
-	mask = pattern->mask ?
-		pattern->mask : &dpaa2_flow_item_sctp_mask;
+	if (idx >= 0) {
+		if (!rte_eth_dev_is_valid_port(idx))
+			return NULL;
+		if (!rte_pmd_dpaa2_dev_is_dpaa2(idx))
+			return NULL;
+		dest_dev = &rte_eth_devices[idx];
+	} else {
+		dest_dev = priv->eth_dev;
+	}
 
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
+	return dest_dev;
+}
 
-	if (dpaa2_pattern->in_tunnel) {
-		DPAA2_PMD_ERR("Tunnel-SCTP distribution not support");
-		return -ENOTSUP;
-	}
+static inline int
+dpaa2_flow_verify_flow_action(struct dpaa2_dev_priv *priv,
+	const struct rte_flow_attr *attr,
+	const struct rte_flow_action actions[])
+{
+	int end_of_list = 0, i, j = 0;
+	const struct rte_flow_action_queue *dest_queue;
+	const struct rte_flow_action_rss *rss_conf;
+	const struct rte_flow_action_jump *jump_tc;
+	struct dpaa2_queue *rxq;
 
-	ret = dpaa2_flow_identify_by_faf(priv, flow,
-			FAF_SCTP_FRAM, DPAA2_FLOW_QOS_TYPE,
-			group, &local_cfg);
-	if (ret)
-		return ret;
+	while (!end_of_list) {
+		switch (actions[j].type) {
+		case RTE_FLOW_ACTION_TYPE_QUEUE:
+			dest_queue = actions[j].conf;
+			if (dest_queue->index >= MAX_RX_QUEUES ||
+				!priv->rx_vq[dest_queue->index]) {
+				DPAA2_PMD_ERR("Invalid FSQ index(%d)",
+					dest_queue->index);
 
-	ret = dpaa2_flow_identify_by_faf(priv, flow,
-			FAF_SCTP_FRAM, DPAA2_FLOW_FS_TYPE,
-			group, &local_cfg);
-	if (ret)
-		return ret;
+				return -EINVAL;
+			}
+			rxq = priv->rx_vq[dest_queue->index];
+			if (attr->group != rxq->tc_index) {
+				DPAA2_PMD_ERR("FSQ(%d.%d) not in TC[%d]",
+					rxq->tc_index, rxq->flow_id,
+					attr->group);
 
-	if (!spec) {
-		(*device_configured) |= local_cfg;
-		return 0;
+				return -EINVAL;
+			}
+			break;
+		case RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT:
+		case RTE_FLOW_ACTION_TYPE_PORT_ID:
+			if (!dpaa2_flow_redirect_dev(priv, &actions[j])) {
+				DPAA2_PMD_ERR("Invalid port id of action");
+				return -EINVAL;
+			}
+			break;
+		case RTE_FLOW_ACTION_TYPE_JUMP:
+			jump_tc = actions[j].conf;
+			if (jump_tc->group >= priv->num_rx_tc) {
+				DPAA2_PMD_ERR("Invalid tc(%d) > %d to jump",
+					jump_tc->group, priv->num_rx_tc);
+				return -EINVAL;
+			}
+			break;
+		case RTE_FLOW_ACTION_TYPE_RSS:
+			rss_conf = actions[j].conf;
+			if (rss_conf->queue_num > priv->dist_queues) {
+				DPAA2_PMD_ERR("RSS number too large");
+				return -EINVAL;
+			}
+			if (rss_conf->queue) {
+				for (i = 0; i < (int)rss_conf->queue_num; i++) {
+					if (rss_conf->queue[i] >= priv->nb_rx_queues) {
+						DPAA2_PMD_ERR("RSS queue not in range");
+						return -EINVAL;
+					}
+					rxq = priv->rx_vq[rss_conf->queue[i]];
+					if (rxq->tc_index != attr->group) {
+						DPAA2_PMD_ERR("RSS queue not in group");
+						return -EINVAL;
+					}
+				}
+			}
+
+			break;
+		case RTE_FLOW_ACTION_TYPE_PF:
+			/* Skip this action, have to add for vxlan*/
+		case RTE_FLOW_ACTION_TYPE_DROP:
+			break;
+		case RTE_FLOW_ACTION_TYPE_END:
+			end_of_list = 1;
+			break;
+		default:
+			DPAA2_PMD_ERR("Invalid action[%d] type(%d)", j, actions[j].type);
+			return -EINVAL;
+		}
+		j++;
 	}
 
-	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
-		RTE_FLOW_ITEM_TYPE_SCTP);
-	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of SCTP not support.");
+	return 0;
+}
 
-		return ret;
-	}
+static int
+dpaa2_flow_action_rxq_convert(struct dpaa2_generic_flow *flow,
+	const struct rte_flow_action *rte_action)
+{
+	struct dpaa2_dev_priv *priv = flow->priv;
+	struct dpaa2_dev_fs_action *action = &flow->fs_action;
+	const struct rte_flow_action_queue *dest_queue;
+	struct dpaa2_queue *dest_q;
+	uint64_t flc = 0;
 
-	if (mask->hdr.src_port) {
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_SCTP,
-			NH_FLD_SCTP_PORT_SRC, &spec->hdr.src_port,
-			&mask->hdr.src_port, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
+	dest_queue = rte_action->conf;
+	if (dest_queue->index >= MAX_RX_QUEUES || !priv->rx_vq[dest_queue->index]) {
+		DPAA2_PMD_ERR("Invalid rxq index(%d)", dest_queue->index);
 
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_SCTP,
-			NH_FLD_SCTP_PORT_SRC, &spec->hdr.src_port,
-			&mask->hdr.src_port, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
+		return -EINVAL;
 	}
+	dest_q = priv->rx_vq[dest_queue->index];
+	if (dest_q->tc_index != flow->tc_id && flow->type == DPAA2_FLOW_FS_TYPE) {
+		DPAA2_PMD_ERR("rxq index(%d)'s TC(%d) conflicts with FS flow's TC(%d)",
+			dest_queue->index, dest_q->tc_index, flow->tc_id);
 
-	if (mask->hdr.dst_port) {
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_SCTP,
-			NH_FLD_SCTP_PORT_DST, &spec->hdr.dst_port,
-			&mask->hdr.dst_port, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_SCTP,
-			NH_FLD_SCTP_PORT_DST, &spec->hdr.dst_port,
-			&mask->hdr.dst_port, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
+		return -EINVAL;
 	}
 
-	(*device_configured) |= local_cfg;
+	flow->tc_id = dest_q->tc_index;
+	flow->action_type = RTE_FLOW_ACTION_TYPE_QUEUE;
+	action->action_cfg.options = DPNI_FS_OPT_SET_FLC | DPNI_FS_OPT_SET_STASH_CONTROL;
+	if (dest_q->data_stashing_off)
+		dpaa2_flc_stashing_set(DPAA2_FLC_DATA_STASHING, 0, &flc);
+	else
+		dpaa2_flc_stashing_set(DPAA2_FLC_DATA_STASHING, 1, &flc);
+
+	if ((dpaa2_svr_family & 0xffff0000) != SVR_LX2160A)
+		dpaa2_flc_stashing_set(DPAA2_FLC_ANNO_STASHING, 1, &flc);
+
+	flc |= ((uint64_t)1) << DPAA2_FS_FLC_FS_MARK_OFFSET;
+	flc |= ((uint64_t)dest_q->tc_index) << DPAA2_FS_FLC_TC_OFFSET;
+	flc |= ((uint64_t)dest_q->flow_id) << DPAA2_FS_FLC_FLOW_OFFSET;
+	action->action_cfg.flc = flc;
+	action->action_cfg.flow_id = dest_q->flow_id;
 
 	return 0;
 }
 
 static int
-dpaa2_configure_flow_gre(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
-	const struct rte_flow_attr *attr,
-	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+dpaa2_flow_action_tx_port_convert(struct dpaa2_generic_flow *flow,
+	const struct rte_flow_action *rte_action)
 {
-	int ret, local_cfg = 0;
-	uint32_t group;
-	const struct rte_flow_item_gre *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	const struct rte_flow_item *pattern = &dpaa2_pattern->generic_item;
+	struct dpaa2_dev_priv *priv = flow->priv;
+	struct dpaa2_dev_fs_action *action = &flow->fs_action;
+	struct rte_eth_dev *dest_dev;
+	struct dpaa2_dev_priv *dest_priv;
+	uint16_t num_tokens;
 
-	group = attr->group;
+	if (flow->action_type != RTE_FLOW_ACTION_TYPE_END &&
+		!(priv->options & DPNI_OPT_V8_HAS_REPLICATION)) {
+		DPAA2_PMD_ERR("Single tx port action support only.");
+		return -ENOTSUP;
+	}
+	num_tokens = action->action_cfg.num_tokens;
+	if (num_tokens >= DPNI_FS_REDIR_MAX_NUM)
+		return -EINVAL;
 
-	/* Parse pattern list to get the matching parameters */
-	spec = pattern->spec;
-	mask = pattern->mask ?
-		pattern->mask : &dpaa2_flow_item_gre_mask;
+	dest_dev = dpaa2_flow_redirect_dev(priv, rte_action);
+	if (!dest_dev) {
+		DPAA2_PMD_ERR("Invalid device to redirect");
+		return -EINVAL;
+	}
 
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
+	flow->action_type = rte_action->type;
 
-	if (dpaa2_pattern->in_tunnel) {
-		DPAA2_PMD_ERR("Tunnel-GRE distribution not support");
-		return -ENOTSUP;
-	}
+	dest_priv = dest_dev->data->dev_private;
+	action->action_cfg.redir_tokens[num_tokens] = dest_priv->token;
+	rte_strscpy(action->dst_name[num_tokens], dest_priv->eth_dev->data->name,
+		RTE_ETH_NAME_MAX_LEN);
+	action->action_cfg.num_tokens++;
+	if (action->action_cfg.num_tokens > 1)
+		action->action_cfg.options = DPNI_FS_OPT_REDIRECT_TO_MULTIPLE_DPNI_TX;
+	else
+		action->action_cfg.options = DPNI_FS_OPT_REDIRECT_TO_DPNI_TX;
 
-	if (!spec) {
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_GRE_FRAM, DPAA2_FLOW_QOS_TYPE,
-				group, &local_cfg);
-		if (ret)
-			return ret;
+	return 0;
+}
 
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_GRE_FRAM, DPAA2_FLOW_FS_TYPE,
-				group, &local_cfg);
-		if (ret)
-			return ret;
+static inline uint16_t
+dpaa2_flow_entry_size(uint16_t key_max_size)
+{
+	if (key_max_size > DPAA2_FLOW_ENTRY_MAX_SIZE) {
+		DPAA2_PMD_ERR("Key size(%d) > max(%d)",
+			key_max_size,
+			DPAA2_FLOW_ENTRY_MAX_SIZE);
 
-		(*device_configured) |= local_cfg;
 		return 0;
 	}
 
-	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
-		RTE_FLOW_ITEM_TYPE_GRE);
-	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of GRE not support.");
+	if (key_max_size > DPAA2_FLOW_ENTRY_MIN_SIZE)
+		return DPAA2_FLOW_ENTRY_MAX_SIZE;
 
-		return ret;
-	}
+	return DPAA2_FLOW_ENTRY_MIN_SIZE;
+}
 
-	if (!mask->protocol)
+static int
+dpaa2_flow_fs_table_set_default(struct dpaa2_dev_priv *priv,
+	uint8_t tc_id, int discard, uint16_t default_queue)
+{
+	int ret;
+	struct dpni_rx_dist_cfg *tc_cfg;
+	struct fsl_mc_io *dpni = priv->hw;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
+	struct dpaa2_queue *queue;
+	char mc_rev[1024];
+
+	tbl_profile = &priv->flow_profile.tc_profile[tc_id];
+	snprintf(mc_rev, 1024, "MC rev(%d.%d.%d)",
+		RTE_FSL_MC_REV_MAJOR(priv->mc_rev),
+		RTE_FSL_MC_REV_MINOR(priv->mc_rev),
+		RTE_FSL_MC_REV_REVISION(priv->mc_rev));
+	if (!tbl_profile->key_profile.dpkg.num_extracts &&
+		priv->mc_rev < DPAA2_QOS_FLOW_TABLE_SET_V3_MC_REV) {
+		DPAA2_PMD_DEBUG("%s can't set miss action of FS table indepentently.",
+			mc_rev);
 		return 0;
+	}
+	tc_cfg = &tbl_profile->tc_cfg;
+	tc_cfg->enable = true;
+	if (discard) {
+		tbl_profile->default_drop = true;
+		tc_cfg->fs_miss_flow_id = DPNI_FS_MISS_ACTION_DROP;
+	} else {
+		if (default_queue >= MAX_RX_QUEUES || !priv->rx_vq[default_queue]) {
+			DPAA2_PMD_ERR("Invalid default queue index(%d)", default_queue);
 
-	ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_GRE,
-			NH_FLD_GRE_TYPE, &spec->protocol,
-			&mask->protocol, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-	if (ret)
-		return ret;
-
-	ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_GRE,
-			NH_FLD_GRE_TYPE, &spec->protocol,
-			&mask->protocol, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-	if (ret)
+			return -EINVAL;
+		}
+		queue = priv->rx_vq[default_queue];
+		if (queue->tc_index != tc_id) {
+			DPAA2_PMD_ERR("RXQ[%d](%d.%d) not in TC[%d]",
+				default_queue, queue->tc_index, queue->flow_id, tc_id);
+			return -EINVAL;
+		}
+		tbl_profile->default_drop = false;
+		tbl_profile->default_queue.index = default_queue;
+		tc_cfg->fs_miss_flow_id = queue->flow_id;
+	}
+	ret = dpni_set_rx_fs_dist(dpni, CMD_PRI_LOW, priv->token, tc_cfg);
+	if (ret < 0) {
+		DPAA2_PMD_ERR("%s: Failed(%d) to set default action of TC[%d]",
+			__func__, ret, tc_id);
 		return ret;
-
-	(*device_configured) |= local_cfg;
+	}
 
 	return 0;
 }
 
 static int
-dpaa2_configure_flow_vxlan(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
-	const struct rte_flow_attr *attr,
-	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+dpaa2_flow_tc_table_config(struct dpaa2_dev_priv *priv,
+	uint8_t tc_id, int rss_dist, int enable)
 {
-	int ret, local_cfg = 0;
-	uint32_t group;
-	const struct rte_flow_item_vxlan *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	const struct rte_flow_item *pattern = &dpaa2_pattern->generic_item;
-
-	group = attr->group;
-
-	/* Parse pattern list to get the matching parameters */
-	spec = pattern->spec;
-	mask = pattern->mask ?
-		pattern->mask : &dpaa2_flow_item_vxlan_mask;
-
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
-	if (dpaa2_pattern->in_tunnel) {
-		DPAA2_PMD_ERR("Tunnel-VXLAN distribution not support");
-		return -ENOTSUP;
-	}
+	struct dpaa2_flow_tbl_profile *tbl_profile;
+	struct dpaa2_key_profile *key_profile;
+	int ret;
+	struct dpni_rx_dist_cfg *tc_cfg;
+	struct fsl_mc_io *dpni = priv->hw;
+	uint16_t entry_size;
+	struct dpaa2_queue *queue;
 
-	if (!spec) {
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_VXLAN_FRAM, DPAA2_FLOW_QOS_TYPE,
-				group, &local_cfg);
-		if (ret)
+	tbl_profile = &priv->flow_profile.tc_profile[tc_id];
+	if (tbl_profile->entry_num) {
+		ret = dpni_clear_fs_entries(dpni, CMD_PRI_LOW, priv->token, tc_id);
+		if (ret) {
+			DPAA2_PMD_ERR("Failed(%d) to clear FS of TC[%d]", ret, tc_id);
 			return ret;
+		}
+	}
 
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_VXLAN_FRAM, DPAA2_FLOW_FS_TYPE,
-				group, &local_cfg);
-		if (ret)
-			return ret;
+	tbl_profile = &priv->flow_profile.tc_profile[tc_id];
+	tbl_profile->entry_num = 0;
+	memset(tbl_profile->entry_map, 0, tbl_profile->entry_map_size);
+	key_profile = &tbl_profile->key_profile;
+	entry_size = dpaa2_flow_entry_size(key_profile->key_max_size);
+	if (!key_profile->dpkg.num_extracts) {
+		enable = false;
+		goto table_set;
+	}
 
-		(*device_configured) |= local_cfg;
-		return 0;
+	dpaa2_flow_extracts_log(priv, "Configure", tc_id);
+	ret = dpkg_prepare_key_cfg(&key_profile->dpkg, tbl_profile->extract_param);
+	if (ret < 0) {
+		DPAA2_PMD_ERR("TC[%d] prepare key failed", tc_id);
+		return ret;
 	}
 
-	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
-		RTE_FLOW_ITEM_TYPE_VXLAN);
+table_set:
+	tc_cfg = &tbl_profile->tc_cfg;
+	if (rss_dist)
+		tc_cfg->enable = enable;
+	else
+		tc_cfg->enable = false;
+	ret = dpni_set_rx_hash_dist(dpni, CMD_PRI_LOW, priv->token, tc_cfg);
 	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of VXLAN not support.");
+		DPAA2_PMD_ERR("Failed(%d) to %s RSS of TC[%d]",
+			ret, rss_dist ? "configure" : "clear", tc_id);
 
 		return ret;
 	}
+	if (rss_dist)
+		goto successful_config;
+
+	tc_cfg->enable = enable;
+	if (tbl_profile->default_drop) {
+		tc_cfg->fs_miss_flow_id = DPNI_FS_MISS_ACTION_DROP;
+	} else {
+		if (tbl_profile->default_queue.index >= MAX_RX_QUEUES ||
+			!priv->rx_vq[tbl_profile->default_queue.index]) {
+			DPAA2_PMD_ERR("Invalid default queue index(%d)",
+				tbl_profile->default_queue.index);
 
-	if (mask->flags) {
-		if (spec->flags != VXLAN_HF_VNI) {
-			DPAA2_PMD_ERR("vxlan flag(0x%02x) must be 0x%02x.",
-				spec->flags, VXLAN_HF_VNI);
 			return -EINVAL;
 		}
-		if (mask->flags != 0xff) {
-			DPAA2_PMD_ERR("Not support to extract vxlan flag.");
+		queue = priv->rx_vq[tbl_profile->default_queue.index];
+		if (queue->tc_index != tc_id) {
+			DPAA2_PMD_ERR("RXQ[%d](%d.%d) not in TC[%d]",
+				tbl_profile->default_queue.index, queue->tc_index,
+				queue->flow_id, tc_id);
 			return -EINVAL;
 		}
+		tc_cfg->fs_miss_flow_id = queue->flow_id;
 	}
-
-	if (mask->vni[0] || mask->vni[1] || mask->vni[2]) {
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_VNI_OFFSET,
-			sizeof(mask->vni), spec->vni,
-			mask->vni,
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			DPAA2_VXLAN_VNI_OFFSET,
-			sizeof(mask->vni), spec->vni,
-			mask->vni,
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
+	ret = dpni_set_rx_fs_dist(dpni, CMD_PRI_LOW, priv->token, tc_cfg);
+	if (ret < 0) {
+		DPAA2_PMD_ERR("TC[%d] FS configured failed", tc_id);
+		return ret;
 	}
 
-	(*device_configured) |= local_cfg;
+	ret = dpaa2_flow_add_all_steering_rule(priv, DPAA2_FLOW_FS_TYPE, entry_size, tc_id);
+	if (ret)
+		return ret;
+
+successful_config:
+	tbl_profile->enabled = true;
 
 	return 0;
 }
 
 static int
-dpaa2_configure_flow_ecpri(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
-	const struct rte_flow_attr *attr,
-	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+dpaa2_flow_qos_table_set_default(struct dpaa2_dev_priv *priv,
+	int discard, uint8_t default_tc, uint16_t default_flow)
 {
-	int ret, local_cfg = 0;
-	uint32_t group;
-	const struct rte_flow_item_ecpri *spec, *mask;
-	struct rte_flow_item_ecpri local_mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	const struct rte_flow_item *pattern =
-		&dpaa2_pattern->generic_item;
-	uint8_t extract_nb = 0, i;
-	uint64_t rule_data[DPAA2_ECPRI_MAX_EXTRACT_NB];
-	uint64_t mask_data[DPAA2_ECPRI_MAX_EXTRACT_NB];
-	uint8_t extract_size[DPAA2_ECPRI_MAX_EXTRACT_NB];
-	uint8_t extract_off[DPAA2_ECPRI_MAX_EXTRACT_NB];
+	int ret;
+	struct dpni_qos_tbl_cfg qos_cfg;
+	struct fsl_mc_io *dpni = priv->hw;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
+	char mc_rev[1024];
+
+	tbl_profile = &priv->flow_profile.qos_profile;
+	snprintf(mc_rev, 1024, "MC rev(%d.%d.%d)",
+		RTE_FSL_MC_REV_MAJOR(priv->mc_rev),
+		RTE_FSL_MC_REV_MINOR(priv->mc_rev),
+		RTE_FSL_MC_REV_REVISION(priv->mc_rev));
+	if (!tbl_profile->key_profile.dpkg.num_extracts &&
+		priv->mc_rev < DPAA2_QOS_FLOW_TABLE_SET_V3_MC_REV) {
+		DPAA2_PMD_DEBUG("%s can't set miss action of QoS table indepentently.",
+			mc_rev);
+		return 0;
+	}
+	if (default_flow < priv->dist_queues &&
+		priv->mc_rev < DPAA2_QOS_FLOW_TABLE_MISS_FLOW_ACTION_MC_REV) {
+		DPAA2_PMD_WARN("%s can't direct miss traffic to TC%d-flow%d by QoS table only.",
+			mc_rev, default_tc, default_flow);
+		return 0;
+	}
 
-	group = attr->group;
+	rte_memcpy(&qos_cfg, &tbl_profile->qos_cfg, sizeof(struct dpni_qos_tbl_cfg));
+	qos_cfg.key_cfg_iova = 0;
+	qos_cfg.default_tc = default_tc;
+	qos_cfg.default_flow_id = default_flow;
+	qos_cfg.discard_on_miss = discard ? true : false;
+	qos_cfg.set_default_flow_id = default_flow < priv->dist_queues ? true : false;
 
-	/* Parse pattern list to get the matching parameters */
-	spec = pattern->spec;
-	if (pattern->mask) {
-		memcpy(&local_mask, pattern->mask,
-			sizeof(struct rte_flow_item_ecpri));
-		local_mask.hdr.common.u32 =
-			rte_be_to_cpu_32(local_mask.hdr.common.u32);
-		mask = &local_mask;
+	ret = dpni_set_qos_table(dpni, CMD_PRI_LOW, priv->token, &qos_cfg);
+	if (ret < 0) {
+		DPAA2_PMD_ERR("%s: Failed(%d) to set default action of QoS",
+			__func__, ret);
+		return ret;
+	}
+	if (discard) {
+		tbl_profile->default_drop = true;
 	} else {
-		mask = &dpaa2_flow_item_ecpri_mask;
+		tbl_profile->default_drop = false;
+		tbl_profile->default_jump.group = default_tc;
 	}
+	rte_memcpy(&tbl_profile->qos_cfg.discard_on_miss,
+		&qos_cfg.discard_on_miss,
+		sizeof(struct dpni_qos_tbl_cfg) -
+		offsetof(struct dpni_qos_tbl_cfg, discard_on_miss));
 
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
+	return 0;
+}
 
-	if (dpaa2_pattern->in_tunnel) {
-		DPAA2_PMD_ERR("Tunnel-ECPRI distribution not support");
-		return -ENOTSUP;
-	}
+static int
+dpaa2_flow_qos_table_config(struct dpaa2_dev_priv *priv,
+	int rss_dist)
+{
+	struct dpaa2_flow_tbl_profile *tbl_profile;
+	uint8_t *key_cfg_buf;
+	int ret;
+	struct dpni_qos_tbl_cfg *qos_cfg;
+	struct fsl_mc_io *dpni = priv->hw;
+	uint16_t entry_size;
+	uint16_t key_max_size;
+	struct dpaa2_dev_flow *flow;
 
-	if (!spec) {
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-			FAFE_ECPRI_FRAM, DPAA2_FLOW_QOS_TYPE,
-			group, &local_cfg);
-		if (ret)
-			return ret;
+	if (!rss_dist && priv->num_rx_tc <= 1) {
+		/* QoS table is effecitive for FS multiple TCs or RSS.*/
+		return 0;
+	}
 
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-			FAFE_ECPRI_FRAM, DPAA2_FLOW_FS_TYPE,
-			group, &local_cfg);
-		if (ret)
+	tbl_profile = &priv->flow_profile.qos_profile;
+	flow = LIST_FIRST(&priv->flows);
+	while (flow) {
+		if (!flow->qos_flow) {
+			flow = LIST_NEXT(flow, next);
+			continue;
+		}
+		/** Clear existing QoS table if there is qos flow configured.*/
+		ret = dpni_clear_qos_table(dpni, CMD_PRI_LOW, priv->token);
+		if (ret < 0) {
+			DPAA2_PMD_ERR("QoS table clear failed(%d)", ret);
 			return ret;
-
-		(*device_configured) |= local_cfg;
-		return 0;
+		}
+		tbl_profile->entry_num = 0;
+		memset(tbl_profile->entry_map, 0, tbl_profile->entry_map_size);
+		break;
 	}
 
-	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
-		RTE_FLOW_ITEM_TYPE_ECPRI);
-	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of ECPRI not support.");
+	if (!tbl_profile->key_profile.dpkg.num_extracts)
+		return 0;
 
-		return ret;
-	}
+	key_cfg_buf = tbl_profile->extract_param;
+	key_max_size = tbl_profile->key_profile.key_max_size;
+	entry_size = dpaa2_flow_entry_size(key_max_size);
 
-	if (mask->hdr.common.type != 0xff) {
-		DPAA2_PMD_WARN("ECPRI header type not specified.");
+	dpaa2_flow_extracts_log(priv, "Configure", MAX_TCS);
 
-		return -EINVAL;
+	ret = dpkg_prepare_key_cfg(&tbl_profile->key_profile.dpkg, key_cfg_buf);
+	if (ret < 0) {
+		DPAA2_PMD_ERR("QoS prepare extract failed");
+		return ret;
 	}
-
-	if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_IQ_DATA) {
-		rule_data[extract_nb] = ECPRI_FAFE_TYPE_0;
-		mask_data[extract_nb] = 0xff;
-		extract_size[extract_nb] = sizeof(uint8_t);
-		extract_off[extract_nb] = DPAA2_FAFE_PSR_OFFSET;
-		extract_nb++;
-
-		if (mask->hdr.type0.pc_id) {
-			rule_data[extract_nb] = spec->hdr.type0.pc_id;
-			mask_data[extract_nb] = mask->hdr.type0.pc_id;
-			extract_size[extract_nb] = sizeof(rte_be16_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_iq_data, pc_id);
-			extract_nb++;
-		}
-		if (mask->hdr.type0.seq_id) {
-			rule_data[extract_nb] = spec->hdr.type0.seq_id;
-			mask_data[extract_nb] = mask->hdr.type0.seq_id;
-			extract_size[extract_nb] = sizeof(rte_be16_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_iq_data, seq_id);
-			extract_nb++;
-		}
-	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_BIT_SEQ) {
-		rule_data[extract_nb] = ECPRI_FAFE_TYPE_1;
-		mask_data[extract_nb] = 0xff;
-		extract_size[extract_nb] = sizeof(uint8_t);
-		extract_off[extract_nb] = DPAA2_FAFE_PSR_OFFSET;
-		extract_nb++;
-
-		if (mask->hdr.type1.pc_id) {
-			rule_data[extract_nb] = spec->hdr.type1.pc_id;
-			mask_data[extract_nb] = mask->hdr.type1.pc_id;
-			extract_size[extract_nb] = sizeof(rte_be16_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_bit_seq, pc_id);
-			extract_nb++;
-		}
-		if (mask->hdr.type1.seq_id) {
-			rule_data[extract_nb] = spec->hdr.type1.seq_id;
-			mask_data[extract_nb] = mask->hdr.type1.seq_id;
-			extract_size[extract_nb] = sizeof(rte_be16_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_bit_seq, seq_id);
-			extract_nb++;
-		}
-	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_RTC_CTRL) {
-		rule_data[extract_nb] = ECPRI_FAFE_TYPE_2;
-		mask_data[extract_nb] = 0xff;
-		extract_size[extract_nb] = sizeof(uint8_t);
-		extract_off[extract_nb] = DPAA2_FAFE_PSR_OFFSET;
-		extract_nb++;
-
-		if (mask->hdr.type2.rtc_id) {
-			rule_data[extract_nb] = spec->hdr.type2.rtc_id;
-			mask_data[extract_nb] = mask->hdr.type2.rtc_id;
-			extract_size[extract_nb] = sizeof(rte_be16_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_rtc_ctrl, rtc_id);
-			extract_nb++;
-		}
-		if (mask->hdr.type2.seq_id) {
-			rule_data[extract_nb] = spec->hdr.type2.seq_id;
-			mask_data[extract_nb] = mask->hdr.type2.seq_id;
-			extract_size[extract_nb] = sizeof(rte_be16_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_rtc_ctrl, seq_id);
-			extract_nb++;
-		}
-	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_GEN_DATA) {
-		rule_data[extract_nb] = ECPRI_FAFE_TYPE_3;
-		mask_data[extract_nb] = 0xff;
-		extract_size[extract_nb] = sizeof(uint8_t);
-		extract_off[extract_nb] = DPAA2_FAFE_PSR_OFFSET;
-		extract_nb++;
-
-		if (mask->hdr.type3.pc_id || mask->hdr.type3.seq_id)
-			DPAA2_PMD_WARN("Extract type3 msg not support.");
-	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_RM_ACC) {
-		rule_data[extract_nb] = ECPRI_FAFE_TYPE_4;
-		mask_data[extract_nb] = 0xff;
-		extract_size[extract_nb] = sizeof(uint8_t);
-		extract_off[extract_nb] = DPAA2_FAFE_PSR_OFFSET;
-		extract_nb++;
-
-		if (mask->hdr.type4.rma_id) {
-			rule_data[extract_nb] = spec->hdr.type4.rma_id;
-			mask_data[extract_nb] = mask->hdr.type4.rma_id;
-			extract_size[extract_nb] = sizeof(uint8_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET + 0;
-				/** Compiler not support to take address
-				 * of bit-field
-				 * offsetof(struct rte_ecpri_msg_rm_access,
-				 * rma_id);
-				 */
-			extract_nb++;
-		}
-		if (mask->hdr.type4.ele_id) {
-			rule_data[extract_nb] = spec->hdr.type4.ele_id;
-			mask_data[extract_nb] = mask->hdr.type4.ele_id;
-			extract_size[extract_nb] = sizeof(rte_be16_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET + 2;
-				/** Compiler not support to take address
-				 * of bit-field
-				 * offsetof(struct rte_ecpri_msg_rm_access,
-				 * ele_id);
-				 */
-			extract_nb++;
-		}
-	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_DLY_MSR) {
-		rule_data[extract_nb] = ECPRI_FAFE_TYPE_5;
-		mask_data[extract_nb] = 0xff;
-		extract_size[extract_nb] = sizeof(uint8_t);
-		extract_off[extract_nb] = DPAA2_FAFE_PSR_OFFSET;
-		extract_nb++;
-
-		if (mask->hdr.type5.msr_id) {
-			rule_data[extract_nb] = spec->hdr.type5.msr_id;
-			mask_data[extract_nb] = mask->hdr.type5.msr_id;
-			extract_size[extract_nb] = sizeof(uint8_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_delay_measure,
-					msr_id);
-			extract_nb++;
-		}
-		if (mask->hdr.type5.act_type) {
-			rule_data[extract_nb] = spec->hdr.type5.act_type;
-			mask_data[extract_nb] = mask->hdr.type5.act_type;
-			extract_size[extract_nb] = sizeof(uint8_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_delay_measure,
-					act_type);
-			extract_nb++;
-		}
-	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_RMT_RST) {
-		rule_data[extract_nb] = ECPRI_FAFE_TYPE_6;
-		mask_data[extract_nb] = 0xff;
-		extract_size[extract_nb] = sizeof(uint8_t);
-		extract_off[extract_nb] = DPAA2_FAFE_PSR_OFFSET;
-		extract_nb++;
-
-		if (mask->hdr.type6.rst_id) {
-			rule_data[extract_nb] = spec->hdr.type6.rst_id;
-			mask_data[extract_nb] = mask->hdr.type6.rst_id;
-			extract_size[extract_nb] = sizeof(rte_be16_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_remote_reset,
-					rst_id);
-			extract_nb++;
-		}
-		if (mask->hdr.type6.rst_op) {
-			rule_data[extract_nb] = spec->hdr.type6.rst_op;
-			mask_data[extract_nb] = mask->hdr.type6.rst_op;
-			extract_size[extract_nb] = sizeof(uint8_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_remote_reset,
-					rst_op);
-			extract_nb++;
-		}
-	} else if (spec->hdr.common.type == RTE_ECPRI_MSG_TYPE_EVT_IND) {
-		rule_data[extract_nb] = ECPRI_FAFE_TYPE_7;
-		mask_data[extract_nb] = 0xff;
-		extract_size[extract_nb] = sizeof(uint8_t);
-		extract_off[extract_nb] = DPAA2_FAFE_PSR_OFFSET;
-		extract_nb++;
-
-		if (mask->hdr.type7.evt_id) {
-			rule_data[extract_nb] = spec->hdr.type7.evt_id;
-			mask_data[extract_nb] = mask->hdr.type7.evt_id;
-			extract_size[extract_nb] = sizeof(uint8_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_event_ind,
-					evt_id);
-			extract_nb++;
-		}
-		if (mask->hdr.type7.evt_type) {
-			rule_data[extract_nb] = spec->hdr.type7.evt_type;
-			mask_data[extract_nb] = mask->hdr.type7.evt_type;
-			extract_size[extract_nb] = sizeof(uint8_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_event_ind,
-					evt_type);
-			extract_nb++;
-		}
-		if (mask->hdr.type7.seq) {
-			rule_data[extract_nb] = spec->hdr.type7.seq;
-			mask_data[extract_nb] = mask->hdr.type7.seq;
-			extract_size[extract_nb] = sizeof(uint8_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_event_ind,
-					seq);
-			extract_nb++;
-		}
-		if (mask->hdr.type7.number) {
-			rule_data[extract_nb] = spec->hdr.type7.number;
-			mask_data[extract_nb] = mask->hdr.type7.number;
-			extract_size[extract_nb] = sizeof(uint8_t);
-			extract_off[extract_nb] =
-				DPAA2_ECPRI_MSG_OFFSET +
-				offsetof(struct rte_ecpri_msg_event_ind,
-					number);
-			extract_nb++;
-		}
+	qos_cfg = &tbl_profile->qos_cfg;
+	if (rss_dist) {
+		qos_cfg->discard_on_miss = true;
 	} else {
-		DPAA2_PMD_ERR("Invalid ecpri header type(%d)",
-				spec->hdr.common.type);
-		return -EINVAL;
+		qos_cfg->default_tc = tbl_profile->default_jump.group;
+		if (tbl_profile->default_drop)
+			qos_cfg->discard_on_miss = true;
+		else
+			qos_cfg->discard_on_miss = false;
 	}
 
-	for (i = 0; i < extract_nb; i++) {
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			extract_off[i],
-			extract_size[i], &rule_data[i], &mask_data[i],
-			priv, group,
-			device_configured,
-			DPAA2_FLOW_QOS_TYPE);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_add_pr_extract_rule(flow,
-			extract_off[i],
-			extract_size[i], &rule_data[i], &mask_data[i],
-			priv, group,
-			device_configured,
-			DPAA2_FLOW_FS_TYPE);
-		if (ret)
-			return ret;
+	if (priv->mc_rev < DPAA2_QOS_FLOW_TABLE_SET_V3_MC_REV)
+		ret = dpni_set_qos_table_v2(dpni, CMD_PRI_LOW, priv->token, qos_cfg);
+	else
+		ret = dpni_set_qos_table(dpni, CMD_PRI_LOW, priv->token, qos_cfg);
+	if (ret < 0) {
+		DPAA2_PMD_ERR("QoS table set failed(%d)", ret);
+		return ret;
 	}
+	tbl_profile->enabled = true;
 
-	(*device_configured) |= local_cfg;
+	ret = dpaa2_flow_add_all_steering_rule(priv, DPAA2_FLOW_QOS_TYPE, entry_size, 0);
+	if (ret)
+		return ret;
 
 	return 0;
 }
 
 static int
-dpaa2_configure_flow_gtp(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
-	const struct rte_flow_attr *attr,
-	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+dpaa2_flow_item_convert(const struct rte_flow_item pattern[],
+	struct dpaa2_flow_item **dpaa2_pattern, int sp_protocol)
 {
-	int ret, local_cfg = 0;
-	uint32_t group;
-	const struct rte_flow_item_gtp *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	const struct rte_flow_item *pattern =
-		&dpaa2_pattern->generic_item;
+	struct dpaa2_flow_item *new_pattern;
+	int num = 0, tunnel_start = 0;
 
-	group = attr->group;
+	while (1) {
+		num++;
+		if (pattern[num].type == RTE_FLOW_ITEM_TYPE_END)
+			break;
+	}
 
-	/* Parse pattern list to get the matching parameters */
-	spec = pattern->spec;
-	mask = pattern->mask ?
-		pattern->mask : &dpaa2_flow_item_gtp_mask;
+	new_pattern = rte_malloc(NULL, sizeof(struct dpaa2_flow_item) * num,
+			RTE_CACHE_LINE_SIZE);
+	if (!new_pattern) {
+		DPAA2_PMD_ERR("Failed to alloc %d flow items", num);
+		return -ENOMEM;
+	}
 
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
+	num = 0;
+	while (pattern[num].type != RTE_FLOW_ITEM_TYPE_END) {
+		rte_memcpy(&new_pattern[num].item, &pattern[num],
+			sizeof(struct rte_flow_item));
+		new_pattern[num].in_tunnel = 0;
 
-	if (dpaa2_pattern->in_tunnel) {
-		DPAA2_PMD_ERR("Tunnel-GTP distribution not support");
-		return -ENOTSUP;
+		if (pattern[num].type == RTE_FLOW_ITEM_TYPE_VXLAN)
+			tunnel_start = 1;
+		else if (tunnel_start && sp_protocol)
+			new_pattern[num].in_tunnel = 1;
+		num++;
 	}
 
-	if (!spec) {
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_GTP_FRAM, DPAA2_FLOW_QOS_TYPE,
-				group, &local_cfg);
-		if (ret)
-			return ret;
+	new_pattern[num].item.type = RTE_FLOW_ITEM_TYPE_END;
+	*dpaa2_pattern = new_pattern;
 
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_GTP_FRAM, DPAA2_FLOW_FS_TYPE,
-				group, &local_cfg);
-		if (ret)
-			return ret;
+	return 0;
+}
 
-		(*device_configured) |= local_cfg;
-		return 0;
+static int
+dpaa2_flow_table_update(struct dpaa2_dev_priv *priv,
+	enum dpaa2_flow_dist_type dist_type, uint8_t tc_id, int is_rss)
+{
+	int ret;
+
+	if (dist_type == DPAA2_FLOW_FS_TYPE || dist_type == DPAA2_FLOW_RSS_TYPE) {
+		ret = dpaa2_flow_tc_table_config(priv, tc_id, is_rss, true);
+	} else if (dist_type == DPAA2_FLOW_QOS_TYPE) {
+		ret = dpaa2_flow_qos_table_config(priv, false);
+	} else {
+		DPAA2_PMD_ERR("Invalid dist type(%d)!", dist_type);
+		ret = -EINVAL;
 	}
 
-	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
-		RTE_FLOW_ITEM_TYPE_GTP);
-	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of GTP not support.");
+	return ret;
+}
 
-		return ret;
-	}
+static int
+dpaa2_flow_steering_action_convert(struct dpaa2_generic_flow *flow,
+	const struct rte_flow_action actions[])
+{
+	int end_of_list = 0, ret = 0, i = 0;
+	const struct rte_flow_action_jump *jump;
 
-	if (!mask->teid)
-		return 0;
+	if (!dpaa2_flow_is_steering_flow(flow)) {
+		DPAA2_PMD_ERR("%s: flow(type=%x) is not steering flow",
+			__func__, flow->type);
+		return -EINVAL;
+	}
 
-	ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_GTP,
-			NH_FLD_GTP_TEID, &spec->teid,
-			&mask->teid, sizeof(rte_be32_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-	if (ret)
-		return ret;
+	while (!end_of_list) {
+		switch (actions[i].type) {
+		case RTE_FLOW_ACTION_TYPE_QUEUE:
+			ret = dpaa2_flow_action_rxq_convert(flow, &actions[i]);
+			if (ret)
+				goto end_action_set;
+			break;
+		case RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT:
+		case RTE_FLOW_ACTION_TYPE_PORT_ID:
+			ret = dpaa2_flow_action_tx_port_convert(flow, &actions[i]);
+			if (ret)
+				goto end_action_set;
+			break;
+		case RTE_FLOW_ACTION_TYPE_DROP:
+			flow->action_type = actions[i].type;
+			flow->fs_action.action_cfg.options = DPNI_FS_OPT_DISCARD;
+			break;
+		case RTE_FLOW_ACTION_TYPE_JUMP:
+			flow->action_type = actions[i].type;
+			jump = actions[i].conf;
+			flow->tc_id = jump->group;
+			break;
+		case RTE_FLOW_ACTION_TYPE_PF:
+			/* Skip this action, have to add for vxlan*/
+			break;
+		case RTE_FLOW_ACTION_TYPE_END:
+			end_of_list = 1;
+			break;
+		default:
+			DPAA2_PMD_ERR("Invalid action[%d]'s type(%d)", i, actions[i].type);
+			ret = -ENOTSUP;
+			goto end_action_set;
+		}
+		i++;
+	}
 
-	ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_GTP,
-			NH_FLD_GTP_TEID, &spec->teid,
-			&mask->teid, sizeof(rte_be32_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+end_action_set:
 	if (ret)
 		return ret;
 
-	(*device_configured) |= local_cfg;
+	if (i < 1) {
+		DPAA2_PMD_ERR("No action is set!");
+		return -EINVAL;
+	}
 
 	return 0;
 }
 
 static int
-dpaa2_configure_flow_mpls(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
-	const struct rte_flow_attr *attr,
-	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+dpaa2_flow_generic_extract_rule_set(struct dpaa2_generic_flow *flow,
+	const struct rte_flow_item pattern[], int *ecfg)
 {
-	int ret, local_cfg = 0;
-	uint32_t group;
-	const struct rte_flow_item_mpls *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	const struct rte_flow_item *pattern =
-		&dpaa2_pattern->generic_item;
+	int ret, i = 0, index;
+	struct dpaa2_key_profile *key_profile = dpaa2_flow_key_profile(flow);
+	struct dpaa2_flow_item *dpaa2_pattern = NULL;
+	const struct dpaa2_flow_proto_handle *hd = s_dpaa2_flow_proto_handle;
+
+	ret = dpaa2_flow_item_convert(pattern, &dpaa2_pattern, flow->priv->sp_protocol);
+	if (ret)
+		return ret;
 
-	group = attr->group;
+	flow->ip_key = NET_PROT_NONE;
+	flow->ip_src = NET_PROT_NONE;
+	flow->ip_dst = NET_PROT_NONE;
 
 	/* Parse pattern list to get the matching parameters */
-	spec = pattern->spec;
-	mask = pattern->mask ?
-		pattern->mask : &dpaa2_flow_item_mpls_mask;
+	while (pattern[i].type != RTE_FLOW_ITEM_TYPE_END) {
+		index = pattern[i].type;
+		if (!hd[index].name) {
+			DPAA2_PMD_ERR("Flow item[%d]'s type(%d) is not supported",
+				i, pattern[i].type);
+			ret = -ENOTSUP;
+			goto end_extract_set;
+		}
+		if (dpaa2_pattern[i].in_tunnel) {
+			if (hd[index].tunnel)
+				ret = hd[index].tunnel(flow, &dpaa2_pattern[i].item, &hd[index], ecfg);
+			else
+				ret = -ENOTSUP;
+			if (ret)
+				goto end_extract_set;
+		}
+		if (!hd[index].cb) {
+			DPAA2_PMD_ERR("No callback to configure %s flow", hd[index].name);
+			ret = -ENOTSUP;
+			goto end_extract_set;
+		}
+		ret = hd[index].cb(flow, &dpaa2_pattern[i].item, &hd[index], ecfg);
+		if (ret) {
+			DPAA2_PMD_ERR("Failed(%d) to configure %s flow", ret, hd[index].name);
+			goto end_extract_set;
+		}
+		i++;
+	}
 
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
+	flow->rule_cfg.key_size = dpaa2_flow_entry_size(key_profile->key_max_size);
 
-	if (dpaa2_pattern->in_tunnel) {
-		DPAA2_PMD_ERR("Tunnel-MPLS distribution not support");
-		return -ENOTSUP;
+end_extract_set:
+	if (dpaa2_pattern)
+		rte_free(dpaa2_pattern);
+
+	return ret;
+}
+
+static int
+dpaa2_flow_get_flow_index(struct dpaa2_dev_priv *priv,
+	const struct rte_flow_attr *attr, enum dpaa2_flow_dist_type dist_type,
+	uint16_t *index)
+{
+	uint16_t idx, id = RTE_DPAA2_FLOW_GROUP_ID_GET(attr->group);
+
+	if (dist_type == DPAA2_FLOW_QOS_TYPE) {
+		if (priv->flags & DPAA2_QOS_ENTRIES_PER_TC_FLAG)
+			idx = attr->group * priv->qos_entries_per_tc + attr->priority;
+		else
+			idx = id * priv->fs_entries + attr->priority;
+
+		if (idx >= priv->qos_entries) {
+			DPAA2_PMD_ERR("QoS flow index(%d) >= max(%d)", idx, priv->qos_entries);
+			return -ENOSPC;
+		}
+	} else {
+		if (attr->priority >= priv->fs_entries) {
+			DPAA2_PMD_ERR("FS[%d].entry(%d) >= max(%d)",
+				attr->group, attr->priority, priv->fs_entries);
+			return -ENOSPC;
+		}
+		idx = attr->priority;
 	}
 
-	if (!spec) {
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_MPLS_FRAM, DPAA2_FLOW_QOS_TYPE,
-				group, &local_cfg);
-		if (ret)
-			return ret;
+	if (index)
+		*index = idx;
+
+	return 0;
+}
+
+static inline int
+dpaa2_flow_verify_steering_attr(struct dpaa2_dev_priv *priv,
+	const struct rte_flow_attr *attr, enum dpaa2_flow_dist_type *pdist_type)
+{
+	int ret = 0;
+	enum dpaa2_flow_dist_type dist_type;
+
+	if (dpaa2_flow_is_qos_flow_only(priv, attr->group))
+		dist_type = DPAA2_FLOW_QOS_TYPE;
+	else if (RTE_DPAA2_FLOW_GROUP_TYPE_GET(attr->group) == RTE_DPAA2_FS_GROUP_FLOW)
+		dist_type = DPAA2_FLOW_FS_TYPE;
+	else
+		dist_type = DPAA2_FLOW_QOS_TYPE | DPAA2_FLOW_FS_TYPE;
 
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_MPLS_FRAM, DPAA2_FLOW_FS_TYPE,
-				group, &local_cfg);
+	if (dist_type & DPAA2_FLOW_QOS_TYPE) {
+		ret = dpaa2_flow_get_flow_index(priv, attr, DPAA2_FLOW_QOS_TYPE, NULL);
 		if (ret)
 			return ret;
-
-		(*device_configured) |= local_cfg;
-		return 0;
 	}
+	if (dist_type & DPAA2_FLOW_FS_TYPE)
+		ret = dpaa2_flow_get_flow_index(priv, attr, DPAA2_FLOW_FS_TYPE, NULL);
 
-	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
-		RTE_FLOW_ITEM_TYPE_MPLS);
-	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of MPLS not support.");
-		return ret;
-	}
+	if (!ret && pdist_type)
+		*pdist_type = dist_type;
 
-	if (!mask->label_tc_s[0] && !mask->label_tc_s[1] &&
-		!mask->label_tc_s[2])
-		return 0;
+	return ret;
+}
 
-	ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_MPLS,
-			NH_FLD_MPLS_MPLSL_1, spec,
-			mask, sizeof(*mask),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-	if (ret)
-		return ret;
+static inline int
+dpaa2_flow_verify_patterns(const struct rte_flow_item pattern[],
+	int sp_support)
+{
+	unsigned int i, j, is_found = 0;
+	int ret = 0;
+	const enum rte_flow_item_type *hp_supported;
+	const enum rte_flow_item_type *sp_supported;
+	uint64_t hp_supported_num, sp_supported_num;
 
-	ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_MPLS,
-			NH_FLD_MPLS_MPLSL_1, spec,
-			mask, sizeof(*mask),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-	if (ret)
-		return ret;
+	hp_supported = dpaa2_hp_supported_pattern_type;
+	hp_supported_num = RTE_DIM(dpaa2_hp_supported_pattern_type);
+
+	sp_supported = dpaa2_sp_supported_pattern_type;
+	sp_supported_num = RTE_DIM(dpaa2_sp_supported_pattern_type);
 
-	(*device_configured) |= local_cfg;
+	for (j = 0; pattern[j].type != RTE_FLOW_ITEM_TYPE_END; j++) {
+		is_found = 0;
+		for (i = 0; i < hp_supported_num; i++) {
+			if (hp_supported[i] == pattern[j].type) {
+				is_found = 1;
+				break;
+			}
+		}
+		if (is_found)
+			continue;
+		if (sp_support) {
+			for (i = 0; i < sp_supported_num; i++) {
+				if (sp_supported[i] == pattern[j].type) {
+					is_found = 1;
+					break;
+				}
+			}
+		}
+		if (!is_found) {
+			DPAA2_PMD_WARN("Flow type(%d) not supported",
+				pattern[j].type);
+			ret = -ENOTSUP;
+			break;
+		}
+	}
 
-	return 0;
+	return ret;
 }
 
-static int
-dpaa2_configure_flow_pppoe(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
-	const struct rte_flow_attr *attr,
-	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+static inline uint16_t
+dpaa2_flow_check_actions_support(const struct rte_flow_action actions[],
+	const enum rte_flow_action_type supported[], uint16_t len,
+	struct rte_flow_action actions_get[])
 {
-	int ret, local_cfg = 0;
-	uint32_t group;
-	const struct rte_flow_item_pppoe *spec, *mask;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	const struct rte_flow_item *pattern =
-		&dpaa2_pattern->generic_item;
-
-	group = attr->group;
-
-	/* Parse pattern list to get the matching parameters */
-	spec = pattern->spec;
-	mask = pattern->mask ?
-		pattern->mask : &dpaa2_flow_item_pppoe_mask;
-
-	/* Get traffic class index and flow id to be configured */
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
-	if (dpaa2_pattern->in_tunnel) {
-		DPAA2_PMD_ERR("Tunnel-PPPoE distribution not support");
-		return -ENOTSUP;
-	}
-
-	if (!spec) {
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_PPPOE_PPP_FRAM, DPAA2_FLOW_QOS_TYPE,
-				group, &local_cfg);
-		if (ret)
-			return ret;
-
-		ret = dpaa2_flow_identify_by_faf(priv, flow,
-				FAF_PPPOE_PPP_FRAM, DPAA2_FLOW_FS_TYPE,
-				group, &local_cfg);
-		if (ret)
-			return ret;
-
-		(*device_configured) |= local_cfg;
-		return 0;
-	}
-
-	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
-		RTE_FLOW_ITEM_TYPE_PPPOES);
-	if (ret) {
-		DPAA2_PMD_WARN("Extract field(s) of PPPoE not support.");
-		return ret;
+	uint16_t i, j, num = 0;
+
+	for (i = 0; actions[i].type != RTE_FLOW_ACTION_TYPE_END; i++) {
+		for (j = 0; j < len; j++) {
+			if (supported[j] == actions[i].type) {
+				if (actions_get) {
+					actions_get[num].type = actions[i].type;
+					actions_get[num].conf = actions[i].conf;
+				}
+				num++;
+			}
+		}
 	}
-
-	if (!mask->session_id)
+	if (!num)
 		return 0;
+	if (actions_get)
+		actions_get[num].type = RTE_FLOW_ACTION_TYPE_END;
 
-	ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_PPPOE,
-			NH_FLD_PPPOE_SID, &spec->session_id,
-			&mask->session_id, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
-	if (ret)
-		return ret;
-
-	ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_PPPOE,
-			NH_FLD_PPPOE_SID, &spec->session_id,
-			&mask->session_id, sizeof(rte_be16_t),
-			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
-	if (ret)
-		return ret;
-
-	(*device_configured) |= local_cfg;
-
-	return 0;
+	return num;
 }
 
 static int
-dpaa2_configure_flow_raw(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
-	const struct rte_flow_attr *attr,
-	const struct rte_dpaa2_flow_item *dpaa2_pattern,
-	const struct rte_flow_action actions[] __rte_unused,
-	struct rte_flow_error *error __rte_unused,
-	int *device_configured)
+dpaa2_flow_validate(struct rte_eth_dev *dev,
+	const struct rte_flow_attr *flow_attr,
+	const struct rte_flow_item pattern[],
+	const struct rte_flow_action actions[],
+	struct rte_flow_error *error)
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	int local_cfg = 0, ret;
-	uint32_t group;
-	struct dpaa2_key_extract *qos_key_extract;
-	struct dpaa2_key_extract *tc_key_extract;
-	const struct rte_flow_item *pattern = &dpaa2_pattern->generic_item;
-	const struct rte_flow_item_raw *spec = pattern->spec;
-	const struct rte_flow_item_raw *mask = pattern->mask;
-
-	/* Need both spec and mask */
-	if (!spec || !mask) {
-		DPAA2_PMD_ERR("spec or mask not present.");
-		return -EINVAL;
-	}
-
-	if (spec->relative) {
-		/* TBD: relative offset support.
-		 * To support relative offset of previous L3 protocol item,
-		 * extracts should be expanded to identify if the frame is:
-		 * vlan or none-vlan.
-		 *
-		 * To support relative offset of previous L4 protocol item,
-		 * extracts should be expanded to identify if the frame is:
-		 * vlan/IPv4 or vlan/IPv6 or none-vlan/IPv4 or none-vlan/IPv6.
-		 */
-		DPAA2_PMD_ERR("relative not supported.");
-		return -EINVAL;
+	struct rte_flow_attr attr;
+	uint16_t action_num;
+	int ret = 0;
+	enum rte_flow_action_type supported;
+	const char *err_str = NULL;
+	const void *cause = NULL;
+	enum dpaa2_flow_dist_type dist_type = DPAA2_FLOW_NULL_TYPE;
+	enum rte_flow_error_type err_type = RTE_FLOW_ERROR_TYPE_NONE;
+
+	if (!flow_attr) {
+		err_str = "No attribute specifiec.";
+		cause = flow_attr;
+		err_type = RTE_FLOW_ERROR_TYPE_ATTR;
+		ret = -EPERM;
+		goto invalid_params;
+	}
+	if (!actions) {
+		err_str = "No action specifiec.";
+		cause = flow_attr;
+		err_type = RTE_FLOW_ERROR_TYPE_ACTION;
+		ret = -EPERM;
+		goto invalid_params;
+	}
+
+	ret = dpaa2_flow_attr_group_convert(priv, flow_attr, &attr);
+	if (ret) {
+		err_str = "Failure to convert attribute!";
+		cause = flow_attr;
+		err_type = RTE_FLOW_ERROR_TYPE_ATTR_GROUP;
+		goto invalid_params;
 	}
 
-	if (spec->search) {
-		DPAA2_PMD_ERR("search not supported.");
-		return -EINVAL;
+	supported = RTE_FLOW_ACTION_TYPE_RSS;
+	action_num = dpaa2_flow_check_actions_support(actions, &supported, 1, NULL);
+	if (action_num) {
+		DPAA2_PMD_DEBUG("This is rss flow.");
+		goto rss_check;
 	}
+	goto verify_attr;
 
-	/* Spec len and mask len should be same */
-	if (spec->length != mask->length) {
-		DPAA2_PMD_ERR("Spec len and mask len mismatch.");
-		return -EINVAL;
+rss_check:
+	if (action_num > 1) {
+		err_str = "Multiple flow's action.";
+		cause = actions;
+		err_type = RTE_FLOW_ERROR_TYPE_ACTION_NUM;
+		ret = -EPERM;
+		goto invalid_params;
 	}
 
-	/* Get traffic class index and flow id to be configured */
-	group = attr->group;
-	flow->tc_id = group;
-	flow->tc_index = attr->priority;
-
-	qos_key_extract = &priv->extract.qos_key_extract;
-	tc_key_extract = &priv->extract.tc_key_extract[group];
-
-	ret = dpaa2_flow_extract_add_raw(priv,
-			spec->offset, spec->length,
-			DPAA2_FLOW_QOS_TYPE, 0, &local_cfg);
+verify_attr:
+	/* Verify input attributes */
+	ret = dpaa2_flow_verify_steering_attr(priv, &attr, &dist_type);
 	if (ret) {
-		DPAA2_PMD_ERR("QoS Extract RAW add failed.");
-		return -EINVAL;
+		err_str = "Invalid attributes are given";
+		cause = flow_attr;
+		err_type = RTE_FLOW_ERROR_TYPE_ATTR;
+		goto invalid_params;
 	}
 
-	ret = dpaa2_flow_extract_add_raw(priv,
-			spec->offset, spec->length,
-			DPAA2_FLOW_FS_TYPE, group, &local_cfg);
-	if (ret) {
-		DPAA2_PMD_ERR("FS[%d] Extract RAW add failed.",
-			group);
-		return -EINVAL;
+	if (pattern) {
+		/* Verify input pattern list */
+		ret = dpaa2_flow_verify_patterns(pattern, priv->sp_protocol);
+		if (ret) {
+			err_str = "Invalid pattern list is given";
+			cause = pattern;
+			err_type = RTE_FLOW_ERROR_TYPE_ITEM;
+			goto invalid_params;
+		}
 	}
 
-	ret = dpaa2_flow_raw_rule_data_set(flow,
-			&qos_key_extract->key_profile,
-			spec->offset, spec->length,
-			spec->pattern, mask->pattern,
-			DPAA2_FLOW_QOS_TYPE);
-	if (ret) {
-		DPAA2_PMD_ERR("QoS RAW rule data set failed");
-		return -EINVAL;
+	/* Verify input action list */
+	if (dist_type & DPAA2_FLOW_FS_TYPE) {
+		if (!dpaa2_flow_check_actions_support(actions,
+			dpaa2_supported_fs_action_type,
+			RTE_DIM(dpaa2_supported_fs_action_type), NULL)) {
+			err_str = "Invalid FS action list is given";
+			cause = actions;
+			err_type = RTE_FLOW_ERROR_TYPE_ACTION;
+			ret = -ENOTSUP;
+			goto invalid_params;
+		}
 	}
-
-	ret = dpaa2_flow_raw_rule_data_set(flow,
-			&tc_key_extract->key_profile,
-			spec->offset, spec->length,
-			spec->pattern, mask->pattern,
-			DPAA2_FLOW_FS_TYPE);
-	if (ret) {
-		DPAA2_PMD_ERR("FS RAW rule data set failed");
-		return -EINVAL;
+	if (dist_type & DPAA2_FLOW_QOS_TYPE) {
+		if (!dpaa2_flow_check_actions_support(actions,
+			dpaa2_supported_qos_action_type,
+			RTE_DIM(dpaa2_supported_qos_action_type), NULL)) {
+			err_str = "Invalid QoS action list is given";
+			cause = actions;
+			err_type = RTE_FLOW_ERROR_TYPE_ACTION;
+			ret = -ENOTSUP;
+			goto invalid_params;
+		}
 	}
 
-	(*device_configured) |= local_cfg;
+invalid_params:
+	if (err_str)
+		DPAA2_PMD_ERR("%s: %s", __func__, err_str);
+	rte_flow_error_set(error, -ret, err_type, cause, err_str);
 
-	return 0;
+	return ret;
 }
 
-static inline int
-dpaa2_flow_verify_attr(struct dpaa2_dev_priv *priv,
-	const struct rte_flow_attr *attr)
+static uint32_t
+dpaa2_flow_is_ip_addr_extract(const struct dpkg_extract *extract)
 {
-	struct dpaa2_dev_flow *curr = LIST_FIRST(&priv->flows);
+	enum dpkg_extract_type type = extract->type;
+	enum net_prot prot = extract->extract.from_hdr.prot;
+	uint32_t field = extract->extract.from_hdr.field;
 
-	while (curr) {
-		if (curr->tc_id == attr->group &&
-			curr->tc_index == attr->priority) {
-			DPAA2_PMD_ERR("Flow(TC[%d].entry[%d] exists",
-				attr->group, attr->priority);
-
-			return -EINVAL;
-		}
-		curr = LIST_NEXT(curr, next);
-	}
+	if (type == DPKG_EXTRACT_FROM_HDR && prot == NET_PROT_IP &&
+		(field == NH_FLD_IP_SRC || field == NH_FLD_IP_DST))
+		return field;
 
 	return 0;
 }
 
-static inline struct rte_eth_dev *
-dpaa2_flow_redirect_dev(struct dpaa2_dev_priv *priv,
-	const struct rte_flow_action *action)
+static void
+dpaa2_flow_key_offset_size(struct dpaa2_key_profile *key_profile,
+	uint8_t idx, uint8_t *offset, uint8_t *size)
 {
-	const struct rte_flow_action_port_id *port_id;
-	const struct rte_flow_action_ethdev *ethdev;
-	int idx = -1;
-	struct rte_eth_dev *dest_dev;
-
-	if (action->type == RTE_FLOW_ACTION_TYPE_PORT_ID) {
-		port_id = action->conf;
-		if (!port_id->original)
-			idx = port_id->id;
-	} else if (action->type == RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT) {
-		ethdev = action->conf;
-		idx = ethdev->port_id;
-	} else {
-		return NULL;
-	}
-
-	if (idx >= 0) {
-		if (!rte_eth_dev_is_valid_port(idx))
-			return NULL;
-		if (!rte_pmd_dpaa2_dev_is_dpaa2(idx))
-			return NULL;
-		dest_dev = &rte_eth_devices[idx];
+	uint8_t ip_addr_size = 0;
+
+	if (key_profile->ip_addr[0].field &&
+		key_profile->ip_addr[0].extract_idx == idx) {
+		ip_addr_size = key_profile->ip_addr[0].max_size;
+		*offset = key_profile->ip_addr_offset;
+		*size = ip_addr_size;
+	} else if (key_profile->ip_addr[1].field &&
+		key_profile->ip_addr[1].extract_idx == idx) {
+		ip_addr_size = key_profile->ip_addr[1].max_size;
+		*offset = key_profile->ip_addr_offset + ip_addr_size;
+		*size = ip_addr_size;
 	} else {
-		dest_dev = priv->eth_dev;
+		*offset = key_profile->prot_field[idx].key_offset;
+		*size = key_profile->prot_field[idx].key_size;
 	}
-
-	return dest_dev;
 }
 
-static inline int
-dpaa2_flow_verify_action(struct dpaa2_dev_priv *priv,
-	const struct rte_flow_attr *attr,
-	const struct rte_flow_action actions[])
+static int
+dpaa2_flow_rule_data_valid(struct dpaa2_generic_flow *flow,
+	uint8_t key_offset, uint8_t key_size)
 {
-	int end_of_list = 0, i, j = 0;
-	const struct rte_flow_action_queue *dest_queue;
-	const struct rte_flow_action_rss *rss_conf;
-	struct dpaa2_queue *rxq;
-
-	while (!end_of_list) {
-		switch (actions[j].type) {
-		case RTE_FLOW_ACTION_TYPE_QUEUE:
-			dest_queue = actions[j].conf;
-			if (dest_queue->index >= MAX_RX_QUEUES ||
-				!priv->rx_vq[dest_queue->index]) {
-				DPAA2_PMD_ERR("Invalid FSQ index(%d)",
-					dest_queue->index);
-
-				return -EINVAL;
-			}
-			rxq = priv->rx_vq[dest_queue->index];
-			if (attr->group != rxq->tc_index) {
-				DPAA2_PMD_ERR("FSQ(%d.%d) not in TC[%d]",
-					rxq->tc_index, rxq->flow_id,
-					attr->group);
+	uint8_t i;
+	int valid = false;
 
-				return -ENOTSUP;
-			}
-			break;
-		case RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT:
-		case RTE_FLOW_ACTION_TYPE_PORT_ID:
-			if (!dpaa2_flow_redirect_dev(priv, &actions[j])) {
-				DPAA2_PMD_ERR("Invalid port id of action");
-				return -ENOTSUP;
-			}
-			break;
-		case RTE_FLOW_ACTION_TYPE_RSS:
-			rss_conf = (const struct rte_flow_action_rss *)
-					(actions[j].conf);
-			if (rss_conf->queue_num > priv->dist_queues) {
-				DPAA2_PMD_ERR("RSS number too large");
-				return -ENOTSUP;
-			}
-			for (i = 0; i < (int)rss_conf->queue_num; i++) {
-				if (rss_conf->queue[i] >= priv->nb_rx_queues) {
-					DPAA2_PMD_ERR("RSS queue not in range");
-					return -ENOTSUP;
-				}
-				rxq = priv->rx_vq[rss_conf->queue[i]];
-				if (rxq->tc_index != attr->group) {
-					DPAA2_PMD_ERR("RSS queue not in group");
-					return -ENOTSUP;
-				}
-			}
+	if (!flow->mask_addr)
+		return valid;
 
+	for (i = 0; i < key_size; i++) {
+		if (flow->mask_addr[key_offset + i]) {
+			valid = true;
 			break;
-		case RTE_FLOW_ACTION_TYPE_PF:
-			/* Skip this action, have to add for vxlan */
-		case RTE_FLOW_ACTION_TYPE_DROP:
-			break;
-		case RTE_FLOW_ACTION_TYPE_END:
-			end_of_list = 1;
-			break;
-		default:
-			DPAA2_PMD_ERR("Invalid action type");
-			return -ENOTSUP;
 		}
-		j++;
 	}
 
-	return 0;
+	return valid;
 }
 
-static int
-dpaa2_configure_flow_fs_action(struct dpaa2_dev_priv *priv,
-	struct dpaa2_dev_flow *flow,
-	const struct rte_flow_action *rte_action)
+static void
+dpaa2_flow_remove_invalid_rule_data(struct dpaa2_dev_priv *priv,
+	enum dpaa2_flow_dist_type type, uint8_t tc_id,
+	uint8_t key_offset, uint8_t key_size)
 {
-	struct rte_eth_dev *dest_dev;
-	struct dpaa2_dev_priv *dest_priv;
-	const struct rte_flow_action_queue *dest_queue;
-	struct dpaa2_queue *dest_q;
-	uint64_t flc = 0;
-
-	memset(&flow->fs_action_cfg, 0,
-		sizeof(struct dpni_fs_action_cfg));
-	flow->action_type = rte_action->type;
+	struct dpaa2_dev_flow *dev_flow, *next_flow;
+	struct dpaa2_generic_flow *flow;
+	uint8_t *src, *dst, size;
+
+	dev_flow = LIST_FIRST(&priv->flows);
+	while (dev_flow) {
+		next_flow = LIST_NEXT(dev_flow, next);
+		flow = dpaa2_flow_generic_flow(dev_flow, type, tc_id);
+		if (!flow || !flow->key_addr || !flow->mask_addr)
+			goto skip_update;
+
+		if (key_offset < flow->rule_size) {
+			src = flow->key_addr + key_offset + key_size;
+			dst = src - key_size;
+			size = flow->rule_size - (key_offset + key_size);
+			memmove(dst, src, size);
+
+			src = flow->mask_addr + key_offset + key_size;
+			dst = src - key_size;
+			memmove(dst, src, size);
+			flow->rule_size -= key_size;
+		}
+		if (flow->rule_cfg.key_size > flow->rule_size) {
+			memset(flow->key_addr + flow->rule_size, 0,
+				flow->rule_cfg.key_size - flow->rule_size);
+			memset(flow->mask_addr + flow->rule_size, 0,
+				flow->rule_cfg.key_size - flow->rule_size);
+		}
 
-	if (flow->action_type == RTE_FLOW_ACTION_TYPE_QUEUE) {
-		dest_queue = rte_action->conf;
-		if (dest_queue->index >= MAX_RX_QUEUES ||
-			!priv->rx_vq[dest_queue->index]) {
-			DPAA2_PMD_ERR("Invalid FSQ index(%d)",
-				dest_queue->index);
+skip_update:
+		dev_flow = next_flow;
+	}
+}
 
-			return -EINVAL;
+static int
+dpaa2_flow_remove_invalid_extract(struct rte_eth_dev *dev,
+	enum dpaa2_flow_dist_type type, uint8_t tc_id)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_flow *dev_flow, *next_flow;
+	uint8_t i, key_offset, key_size, j, remove_conut = 0;
+	struct dpaa2_key_profile *key_profile;
+	struct dpaa2_ip_addr_extract *ip_addr;
+	struct dpaa2_l4_port_extract *l4_port;
+	int valid[DPKG_MAX_NUM_OF_EXTRACTS], update = 0, l4_idx;
+	uint32_t start, end, size;
+	uint32_t ip_src_size, ip_dst_size, ip_addr_size = 0, is_ip;
+	struct dpaa2_generic_flow *flow;
+	void *src, *dst;
+
+	key_profile = type == DPAA2_FLOW_QOS_TYPE ?
+		&priv->flow_profile.qos_profile.key_profile :
+		&priv->flow_profile.tc_profile[tc_id].key_profile;
+
+	ip_addr = key_profile->ip_addr;
+	l4_port = key_profile->l4_port;
+	ip_addr_size = dpaa2_extract_ip_addr_size(ip_addr);
+	for (i = 0; i < key_profile->dpkg.num_extracts; i++) {
+		valid[i] = 0;
+		dev_flow = LIST_FIRST(&priv->flows);
+		dpaa2_flow_key_offset_size(key_profile, i, &key_offset, &key_size);
+		while (dev_flow) {
+			next_flow = LIST_NEXT(dev_flow, next);
+			flow = dpaa2_flow_generic_flow(dev_flow, type, tc_id);
+			if (!flow)
+				goto skip_validation;
+
+			if (dpaa2_flow_rule_data_valid(flow, key_offset, key_size)) {
+				valid[i] = 1;
+				break;
+			}
+skip_validation:
+			dev_flow = next_flow;
 		}
-		dest_q = priv->rx_vq[dest_queue->index];
-		if (flow->tc_id != dest_q->tc_index) {
-			DPAA2_PMD_ERR("RXQ[%d](%d.%d) not in TC[%d]",
-				dest_queue->index,
-				dest_q->tc_index, dest_q->flow_id,
-				flow->tc_id);
+		if (!valid[i])
+			remove_conut++;
+	}
 
-			return -EINVAL;
-		}
-		flow->fs_action_cfg.options =
-			DPNI_FS_OPT_SET_FLC | DPNI_FS_OPT_SET_STASH_CONTROL;
+	if (remove_conut > 0) {
+		if (type == DPAA2_FLOW_QOS_TYPE)
+			dpaa2_flow_extracts_log(priv, "Before removing extract(s)", MAX_TCS);
+		else
+			dpaa2_flow_extracts_log(priv, "Before removing extract(s)", tc_id);
+	} else {
+		return 0;
+	}
 
-		if (dest_q->data_stashing_off) {
-			dpaa2_flc_stashing_set(DPAA2_FLC_DATA_STASHING,
-				0, &flc);
-		} else {
-			dpaa2_flc_stashing_set(DPAA2_FLC_DATA_STASHING,
-				1, &flc);
+	i = key_profile->dpkg.num_extracts - 1;
+	while (remove_conut) {
+		if (valid[i]) {
+			if (i == 0) {
+				DPAA2_PMD_ERR("Fatal: %d key(s) not removed!", remove_conut);
+				return -EINVAL;
+			}
+			i--;
+			continue;
 		}
-		if ((dpaa2_svr_family & 0xffff0000) != SVR_LX2160A) {
-			dpaa2_flc_stashing_set(DPAA2_FLC_ANNO_STASHING,
-				1, &flc);
+		is_ip = false;
+		for (j = 0; j < 2; j++) {
+			if (key_profile->prot_field[i].type == DPAA2_NET_PROT_KEY &&
+				key_profile->prot_field[i].prot == NET_PROT_IP &&
+				key_profile->prot_field[i].key_field ==
+					key_profile->ip_addr[j].field) {
+				key_size = key_profile->ip_addr[j].max_size;
+				key_offset = key_profile->ip_addr_offset + j * key_size;
+				is_ip = true;
+				break;
+			}
 		}
-
-		flc |= ((uint64_t)1) << DPAA2_FS_FLC_FS_MARK_OFFSET;
-		flc |= ((uint64_t)dest_q->tc_index) << DPAA2_FS_FLC_TC_OFFSET;
-		flc |= ((uint64_t)dest_q->flow_id) << DPAA2_FS_FLC_FLOW_OFFSET;
-		flow->fs_action_cfg.flc = flc;
-		flow->fs_action_cfg.flow_id = dest_q->flow_id;
-	} else if (flow->action_type == RTE_FLOW_ACTION_TYPE_PORT_ID ||
-		   flow->action_type == RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT) {
-		dest_dev = dpaa2_flow_redirect_dev(priv, rte_action);
-		if (!dest_dev) {
-			DPAA2_PMD_ERR("Invalid device to redirect");
-			return -EINVAL;
+		if (!is_ip) {
+			key_size = key_profile->prot_field[i].key_size;
+			key_offset = key_profile->prot_field[i].key_offset;
 		}
 
-		dest_priv = dest_dev->data->dev_private;
-		dest_q = dest_priv->tx_vq[0];
-		flow->fs_action_cfg.options =
-			DPNI_FS_OPT_REDIRECT_TO_DPNI_TX;
-		flow->fs_action_cfg.num_tokens = 1;
-		flow->fs_action_cfg.redir_tokens[0] = dest_priv->token;
-		flow->fs_action_cfg.flow_id = dest_q->flow_id;
-	} else if (flow->action_type == RTE_FLOW_ACTION_TYPE_DROP) {
-		flow->fs_action_cfg.options = DPNI_FS_OPT_DISCARD;
-	}
+		for (j = i + 1; j < key_profile->dpkg.num_extracts; j++)
+			key_profile->prot_field[j].key_offset -= key_size;
 
-	return 0;
-}
+		if (!dpaa2_flow_is_ip_addr_extract(&key_profile->dpkg.extracts[i]))
+			update += key_size;
 
-static inline uint16_t
-dpaa2_flow_entry_size(struct dpaa2_dev_priv *priv, uint16_t key_max_size)
-{
-	if (key_max_size > DPAA2_FLOW_ENTRY_MAX_SIZE) {
-		DPAA2_PMD_ERR("Key size(%d) > max(%d)",
-			key_max_size,
-			DPAA2_FLOW_ENTRY_MAX_SIZE);
+		if ((i + 1) < key_profile->dpkg.num_extracts) {
+			src = &key_profile->prot_field[i + 1];
+			dst = &key_profile->prot_field[i];
+			size = (key_profile->dpkg.num_extracts - i - 1) *
+				sizeof(struct key_prot_field);
+			memmove(dst, src, size);
 
-		return 0;
-	}
+			src = &key_profile->dpkg.extracts[i + 1];
+			dst = &key_profile->dpkg.extracts[i];
+			size = (key_profile->dpkg.num_extracts - i - 1) *
+				sizeof(struct dpkg_extract);
+			memmove(dst, src, size);
+		}
 
-	if (key_max_size > DPAA2_FLOW_ENTRY_MIN_SIZE ||
-			dpaa2_dev_cmp_dpni_ver(priv, 8, 7) < 0)
-		return DPAA2_FLOW_ENTRY_MAX_SIZE;
+		dpaa2_flow_remove_invalid_rule_data(priv, type, tc_id, key_offset, key_size);
 
-	return DPAA2_FLOW_ENTRY_MIN_SIZE;
-}
+		key_profile->dpkg.num_extracts--;
+		i--;
+		remove_conut--;
+	};
 
-static inline int
-dpaa2_flow_clear_fs_table(struct dpaa2_dev_priv *priv,
-	uint8_t tc_id)
-{
-	struct dpaa2_dev_flow *curr = LIST_FIRST(&priv->flows);
-	int need_clear = 0, ret;
-	struct fsl_mc_io *dpni = priv->hw;
+	key_profile->key_max_size -= update;
+	key_profile->key_max_size -= ip_addr_size;
 
-	while (curr) {
-		if (curr->tc_id == tc_id) {
-			need_clear = 1;
-			break;
+	memset(ip_addr, 0, sizeof(struct dpaa2_ip_addr_extract) * 2);
+	memset(l4_port, 0, sizeof(struct dpaa2_l4_port_extract) * DPAA2_L4_PORT_NUM);
+
+	if (key_profile->dpkg.num_extracts >= 2)
+		start = key_profile->dpkg.num_extracts - 2;
+	else if (key_profile->dpkg.num_extracts >= 1)
+		start = key_profile->dpkg.num_extracts - 1;
+	else
+		goto skip_ip_addr_extract;
+	end = key_profile->dpkg.num_extracts;
+
+	j = 0;
+	for (i = start; i < end; i++) {
+		if (dpaa2_flow_is_ip_addr_extract(&key_profile->dpkg.extracts[i])) {
+			ip_addr[j].field = key_profile->dpkg.extracts[i].extract.from_hdr.field;
+			ip_addr[j].max_size = sizeof(rte_be32_t);
+			ip_addr[j].extract_idx = i;
+			j++;
 		}
-		curr = LIST_NEXT(curr, next);
 	}
 
-	if (need_clear) {
-		ret = dpni_clear_fs_entries(dpni, CMD_PRI_LOW,
-				priv->token, tc_id);
-		if (ret) {
-			DPAA2_PMD_ERR("TC[%d] clear failed", tc_id);
-			return ret;
+	ip_src_size = sizeof(rte_be32_t);
+	ip_dst_size = sizeof(rte_be32_t);
+	dev_flow = LIST_FIRST(&priv->flows);
+	while (dev_flow) {
+		next_flow = LIST_NEXT(dev_flow, next);
+		flow = dpaa2_flow_generic_flow(dev_flow, type, tc_id);
+		if (!flow)
+			goto skip_ip_addr_size_update;
+
+		if (flow->ip_key == NET_PROT_IPV6) {
+			if (flow->ip_src == NET_PROT_IPV6)
+				ip_src_size = NH_FLD_IPV6_ADDR_SIZE;
+			if (flow->ip_dst == NET_PROT_IPV6)
+				ip_dst_size = NH_FLD_IPV6_ADDR_SIZE;
+		}
+
+skip_ip_addr_size_update:
+		dev_flow = next_flow;
+	}
+	for (i = 0; i < 2; i++) {
+		if (ip_addr[i].field == NH_FLD_IP_SRC) {
+			ip_addr[i].max_size = ip_src_size;
+			key_profile->key_max_size += ip_src_size;
+		} else if (ip_addr[i].field == NH_FLD_IP_DST) {
+			ip_addr[i].max_size = ip_dst_size;
+			key_profile->key_max_size += ip_dst_size;
+		}
+	}
+
+skip_ip_addr_extract:
+	for (i = 0; i < key_profile->dpkg.num_extracts; i++) {
+		l4_idx = dpaa2_flow_l4_port_extract(&key_profile->dpkg.extracts[i]);
+		if (l4_idx < 0)
+			continue;
+		if (key_profile->l4_port[l4_idx].present) {
+			DPAA2_PMD_WARN("Multiple L4 port[%d] extracts:%d/%d",
+				l4_idx, key_profile->l4_port[l4_idx].extract_idx, i);
 		}
+		key_profile->l4_port[l4_idx].present = true;
+		key_profile->l4_port[l4_idx].extract_idx = i;
+		key_profile->l4_port[l4_idx].key_offset = key_profile->prot_field[i].key_offset;
 	}
 
-	return 0;
+	if (type == DPAA2_FLOW_QOS_TYPE)
+		dpaa2_flow_extracts_log(priv, "After removing extract(s)", MAX_TCS);
+	else
+		dpaa2_flow_extracts_log(priv, "After removing extract(s)", tc_id);
+
+	return update;
 }
 
 static int
-dpaa2_configure_fs_rss_table(struct dpaa2_dev_priv *priv,
-	uint8_t tc_id, uint16_t dist_size, int rss_dist)
+dpaa2_flow_remove_steering_entry(struct rte_eth_dev *dev,
+	struct dpaa2_generic_flow *flow, enum dpaa2_flow_dist_type type)
 {
-	struct dpaa2_key_extract *tc_extract;
-	uint8_t *key_cfg_buf;
-	uint64_t key_cfg_iova;
-	int ret;
-	struct dpni_rx_dist_cfg tc_cfg;
+	int ret = 0;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	struct fsl_mc_io *dpni = priv->hw;
-	uint16_t entry_size;
-	uint16_t key_max_size;
+	struct dpaa2_flow_tbl_profile *tbl_profile;
 
-	ret = dpaa2_flow_clear_fs_table(priv, tc_id);
-	if (ret < 0) {
-		DPAA2_PMD_ERR("TC[%d] clear failed", tc_id);
-		return ret;
+	if (!dpaa2_flow_is_steering_flow(flow)) {
+		DPAA2_PMD_ERR("%s: flow(type=%x) is not steering flow",
+			__func__, flow->type);
+		return -EINVAL;
 	}
 
-	tc_extract = &priv->extract.tc_key_extract[tc_id];
-	key_cfg_buf = priv->extract.tc_extract_param[tc_id];
-	key_cfg_iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(key_cfg_buf,
-		DPAA2_EXTRACT_PARAM_MAX_SIZE);
-	if (key_cfg_iova == RTE_BAD_IOVA) {
-		DPAA2_PMD_ERR("%s: No IOMMU map for key cfg(%p)",
-			__func__, key_cfg_buf);
-
-		return -ENOBUFS;
+	if (type == DPAA2_FLOW_QOS_TYPE) {
+		tbl_profile = &priv->flow_profile.qos_profile;
+		ret = dpni_remove_qos_entry(dpni, CMD_PRI_LOW,
+			priv->token, &flow->rule_cfg);
+	} else {
+		tbl_profile = &priv->flow_profile.tc_profile[flow->tc_id];
+		ret = dpni_remove_fs_entry(dpni, CMD_PRI_LOW,
+			priv->token, flow->tc_id, &flow->rule_cfg);
+	}
+	dpaa2_flow_steering_entry_log(ret ? "Remove failure" : "Remove success", flow);
+	if (!ret) {
+		tbl_profile->entry_num--;
+		dpaa2_flow_entry_map_set(tbl_profile->entry_map, flow->entry_index, 0);
 	}
 
-	key_max_size = tc_extract->key_profile.key_max_size;
-	entry_size = dpaa2_flow_entry_size(priv, key_max_size);
+	return ret;
+}
 
-	dpaa2_flow_fs_extracts_log(priv, tc_id);
-	ret = dpkg_prepare_key_cfg(&tc_extract->dpkg,
-			key_cfg_buf);
+static int
+dpaa2_flow_rss_action_update(struct rte_eth_dev *dev,
+	struct dpaa2_generic_flow *flow,
+	const struct rte_flow_item pattern[],
+	const struct rte_flow_action actions[],
+	struct rte_flow_error *error)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_flow_tbl_profile *tbl_profile = NULL;
+	int ret = 0, err_code = 0, i = 0;
+	const struct rte_flow_action_rss *rss_conf;
+	struct rte_flow_item items[DPKG_MAX_NUM_OF_EXTRACTS + 1];
+	uint8_t spec_buf[1024], tc_id;
+	struct rte_flow_attr attr;
+	enum rte_flow_error_type error_type = RTE_FLOW_ERROR_TYPE_NONE;
+	const char *err_str = NULL;
+	uint64_t rss_dist;
+
+	tc_id = flow->tc_id;
+	tbl_profile = &priv->flow_profile.tc_profile[tc_id];
+	rss_conf = actions[0].conf;
+	if (pattern) {
+		while (i < (DPKG_MAX_NUM_OF_EXTRACTS + 1)) {
+			rte_memcpy(&items[i], &pattern[i], sizeof(struct rte_flow_item));
+			if (pattern[i].type == RTE_FLOW_ITEM_TYPE_END)
+				break;
+			i++;
+		}
+		if (items[i - 1].type != RTE_FLOW_ITEM_TYPE_END) {
+			error_type = RTE_FLOW_ERROR_TYPE_ITEM_NUM;
+			err_str = "Too many patterns for RSS";
+			err_code = -EINVAL;
+			goto quit;
+		}
+		goto set_extract;
+	}
+	rss_dist = rss_conf->types;
+	ret = dpaa2_flow_rss_conf_to_item(rss_dist, items, spec_buf, 1024);
 	if (ret < 0) {
-		DPAA2_PMD_ERR("TC[%d] prepare key failed", tc_id);
-		return ret;
+		DPAA2_PMD_ERR("Failed(%d) to convert TC.%d's rss distribution", ret, tc_id);
+		error_type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+		err_str = "Failed to gen rss items in flow action update!";
+		err_code = ret;
+		goto quit;
+	} else if (!ret) {
+		DPAA2_PMD_ERR("No item is generated by rss dist(0x%lx)", rss_dist);
+		error_type = RTE_FLOW_ERROR_TYPE_ITEM;
+		err_str = "No item is generated by rss type!";
+		err_code = -ENOTSUP;
+		goto quit;
+	}
+
+set_extract:
+	memset(&attr, 0, sizeof(attr));
+	attr.group = tc_id;
+	attr.ingress = 1;
+	tbl_profile->tc_cfg.dist_size = rss_conf->queue_num;
+	flow->rule_size = 0;
+	flow->ip_key = NET_PROT_NONE;
+	flow->ip_src = NET_PROT_NONE;
+	flow->ip_dst = NET_PROT_NONE;
+	ret = dpaa2_flow_generic_extract_rule_set(flow, items, NULL);
+	if (ret) {
+		error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+		err_str = "RSS extracts update failed!";
+		err_code = ret;
+		goto quit;
+	}
+	ret = dpaa2_flow_table_update(priv, DPAA2_FLOW_RSS_TYPE, attr.group, true);
+	if (ret) {
+		error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+		err_str = "RSS table update failed!";
+		err_code = ret;
 	}
 
-	memset(&tc_cfg, 0, sizeof(struct dpni_rx_dist_cfg));
-	tc_cfg.dist_size = dist_size;
-	tc_cfg.key_cfg_iova = key_cfg_iova;
-	if (rss_dist)
-		tc_cfg.enable = true;
-	else
-		tc_cfg.enable = false;
-	tc_cfg.tc = tc_id;
-	ret = dpni_set_rx_hash_dist(dpni, CMD_PRI_LOW,
-			priv->token, &tc_cfg);
-	if (ret < 0) {
-		if (rss_dist) {
-			DPAA2_PMD_ERR("RSS TC[%d] set failed",
-				tc_id);
-		} else {
-			DPAA2_PMD_ERR("FS TC[%d] hash disable failed",
-				tc_id);
-		}
+quit:
+	if (err_str)
+		DPAA2_PMD_ERR("%s: %s", __func__, err_str);
+	return rte_flow_error_set(error, -err_code, error_type, NULL, err_str);
+}
 
-		return ret;
-	}
+static int
+dpaa2_flow_destroy_steering_flow(struct rte_eth_dev *dev,
+	struct dpaa2_generic_flow *flow)
+{
+	int ret = 0, update;
+	uint8_t tc_id = 0;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 
-	if (rss_dist)
+	if (!flow)
 		return 0;
 
-	uint16_t nb_rxq = priv->eth_dev->data->nb_rx_queues;
-	uint16_t first = tc_id * dist_size;
-
-	tc_cfg.enable = true;
-	tc_cfg.fs_miss_flow_id = nb_rxq > first ?
-		RTE_MIN(dist_size, nb_rxq - first) - 1 : 0;
-	ret = dpni_set_rx_fs_dist(dpni, CMD_PRI_LOW,
-			priv->token, &tc_cfg);
-	if (ret < 0) {
-		DPAA2_PMD_ERR("TC[%d] FS configured failed", tc_id);
-		return ret;
+	if (!dpaa2_flow_is_steering_flow(flow)) {
+		DPAA2_PMD_ERR("%s: flow(type=%x) is not steering flow",
+			__func__, flow->type);
+		return -EINVAL;
 	}
 
-	ret = dpaa2_flow_rule_add_all(priv, DPAA2_FLOW_FS_TYPE,
-			entry_size, tc_id);
+	dpaa2_dump_extract_map(priv, "Start destroying flow", flow->type,
+		flow->type == DPAA2_FLOW_FS_TYPE ? flow->tc_id : 0);
+
+	ret = dpaa2_flow_remove_steering_entry(dev, flow, flow->type);
 	if (ret)
 		return ret;
 
-	return 0;
+	update = dpaa2_flow_remove_invalid_extract(dev, flow->type, flow->tc_id);
+	if (update > 0)
+		ret = dpaa2_flow_table_update(priv, flow->type, flow->tc_id, false);
+
+	if (!ret) {
+		dpaa2_dump_extract_map(priv, "End destroying flow", flow->type, tc_id);
+		dpaa2_flow_generic_flow_deinit(flow);
+	}
+
+	return ret;
 }
 
 static int
-dpaa2_configure_qos_table(struct dpaa2_dev_priv *priv,
-	int rss_dist)
+dpaa2_flow_destroy_rss_flow(struct rte_eth_dev *dev,
+	struct dpaa2_generic_flow *flow)
 {
-	struct dpaa2_key_extract *qos_extract;
-	uint8_t *key_cfg_buf;
-	uint64_t key_cfg_iova;
-	int ret;
-	struct dpni_qos_tbl_cfg qos_cfg;
-	struct fsl_mc_io *dpni = priv->hw;
-	uint16_t entry_size;
-	uint16_t key_max_size;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	int update, ret;
 
-	if (!rss_dist && priv->num_rx_tc <= 1) {
-		/* QoS table is effecitive for FS multiple TCs or RSS.*/
+	if (!flow)
 		return 0;
-	}
 
-	if (LIST_FIRST(&priv->flows)) {
-		ret = dpni_clear_qos_table(dpni, CMD_PRI_LOW,
-				priv->token);
-		if (ret < 0) {
-			DPAA2_PMD_ERR("QoS table clear failed");
-			return ret;
+	update = dpaa2_flow_remove_invalid_extract(dev, flow->type, flow->tc_id);
+	if (update > 0) {
+		ret = dpaa2_flow_table_update(priv, flow->type, flow->tc_id, true);
+	} else {
+		if (!update) {
+			DPAA2_PMD_ERR("No TC.%d's RSS flow was found", flow->tc_id);
+			ret = -EINVAL;
+		} else {
+			ret = update;
 		}
 	}
 
-	qos_extract = &priv->extract.qos_key_extract;
-	key_cfg_buf = priv->extract.qos_extract_param;
-	key_cfg_iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(key_cfg_buf,
-		DPAA2_EXTRACT_PARAM_MAX_SIZE);
-	if (key_cfg_iova == RTE_BAD_IOVA) {
-		DPAA2_PMD_ERR("%s: No IOMMU map for key cfg(%p)",
-			__func__, key_cfg_buf);
-
-		return -ENOBUFS;
+	if (!ret) {
+		priv->flow_profile.tc_profile[flow->tc_id].rss_flow = NULL;
+		dpaa2_flow_generic_flow_deinit(flow);
 	}
 
-	key_max_size = qos_extract->key_profile.key_max_size;
-	entry_size = dpaa2_flow_entry_size(priv, key_max_size);
+	return ret;
+}
 
-	dpaa2_flow_qos_extracts_log(priv);
+static struct dpaa2_generic_flow *
+dpaa2_flow_create_steering_flow(struct rte_eth_dev *dev,
+	const struct rte_flow_attr *attr,
+	const struct rte_flow_item pattern[],
+	const struct rte_flow_action actions[],
+	struct rte_flow_error *error,
+	enum dpaa2_flow_dist_type dist_type)
+{
+	struct dpaa2_generic_flow *flow = NULL;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	int ret, extract_cfg = 0;
+	uint16_t idx;
 
-	ret = dpkg_prepare_key_cfg(&qos_extract->dpkg,
-			key_cfg_buf);
-	if (ret < 0) {
-		DPAA2_PMD_ERR("QoS prepare extract failed");
-		return ret;
-	}
-	memset(&qos_cfg, 0, sizeof(struct dpni_qos_tbl_cfg));
-	qos_cfg.keep_entries = true;
-	qos_cfg.key_cfg_iova = key_cfg_iova;
-	if (rss_dist) {
-		qos_cfg.discard_on_miss = true;
-	} else {
-		qos_cfg.discard_on_miss = false;
-		qos_cfg.default_tc = 0;
-	}
+	ret = dpaa2_flow_get_flow_index(priv, attr, dist_type, &idx);
+	if (ret)
+		return NULL;
 
-	if (priv->mc_rev < DPAA2_QOS_FLOW_TABLE_SET_V3_MC_REV)
-		ret = dpni_set_qos_table_v2(dpni, CMD_PRI_LOW,
-				priv->token, &qos_cfg);
-	else
-		ret = dpni_set_qos_table(dpni, CMD_PRI_LOW,
-				priv->token, &qos_cfg);
-	if (ret < 0) {
-		DPAA2_PMD_ERR("QoS table set failed");
-		return ret;
-	}
+	ret = dpaa2_flow_verify_flow_action(priv, attr, actions);
+	if (ret)
+		return NULL;
 
-	ret = dpaa2_flow_rule_add_all(priv, DPAA2_FLOW_QOS_TYPE,
-			entry_size, 0);
+	ret = dpaa2_flow_verify_steering_entry(priv, attr->group, idx, dist_type);
 	if (ret)
-		return ret;
+		return NULL;
 
-	return 0;
-}
+	dpaa2_dump_extract_map(priv, "Start creating flow", dist_type, attr->group);
 
-static int
-dpaa2_flow_item_convert(const struct rte_flow_item pattern[],
-	struct rte_dpaa2_flow_item **dpaa2_pattern, int sp_protocol)
-{
-	struct rte_dpaa2_flow_item *new_pattern;
-	int num = 0, tunnel_start = 0;
+	flow = dpaa2_flow_generic_flow_init(priv, idx, false, dist_type, attr->group);
+	if (!flow)
+		return NULL;
 
-	while (1) {
-		num++;
-		if (pattern[num].type == RTE_FLOW_ITEM_TYPE_END)
-			break;
-	}
+	if (dist_type == DPAA2_FLOW_FS_TYPE)
+		dpaa2_flow_clean(dev, flow->tc_id, DPAA2_FLOW_RSS_TYPE);
 
-	new_pattern = rte_malloc(NULL, sizeof(struct rte_dpaa2_flow_item) * num,
-			RTE_CACHE_LINE_SIZE);
-	if (!new_pattern) {
-		DPAA2_PMD_ERR("Failed to alloc %d flow items", num);
-		return -ENOMEM;
+	ret = dpaa2_flow_generic_extract_rule_set(flow, pattern, &extract_cfg);
+	if (ret < 0) {
+		if (error && error->type > RTE_FLOW_ERROR_TYPE_ACTION) {
+			rte_flow_error_set(error, EPERM,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+				attr, "unknown");
+		}
+		DPAA2_PMD_ERR("Failed(%d) to create FS flow.", ret);
+		goto creation_error;
+	}
+	if (extract_cfg) {
+		ret = dpaa2_flow_table_update(priv, dist_type, attr->group, false);
+		if (ret)
+			goto creation_error;
 	}
 
-	num = 0;
-	while (pattern[num].type != RTE_FLOW_ITEM_TYPE_END) {
-		rte_memcpy(&new_pattern[num].generic_item, &pattern[num],
-			sizeof(struct rte_flow_item));
-		new_pattern[num].in_tunnel = 0;
+	ret = dpaa2_flow_steering_action_convert(flow, actions);
+	if (ret)
+		goto creation_error;
 
-		if (pattern[num].type == RTE_FLOW_ITEM_TYPE_VXLAN)
-			tunnel_start = 1;
-		else if (tunnel_start && sp_protocol)
-			new_pattern[num].in_tunnel = 1;
-		num++;
-	}
+	ret = dpaa2_flow_add_steering_rule(flow, false);
+	if (ret)
+		goto creation_error;
 
-	new_pattern[num].generic_item.type = RTE_FLOW_ITEM_TYPE_END;
-	*dpaa2_pattern = new_pattern;
+	dpaa2_dump_extract_map(priv, "Complete creating flow", dist_type, attr->group);
 
-	return 0;
+	return flow;
+
+creation_error:
+	dpaa2_flow_generic_flow_deinit(flow);
+
+	return NULL;
 }
 
-static int
-dpaa2_generic_flow_set(struct dpaa2_dev_flow *flow,
-	struct rte_eth_dev *dev,
+static struct dpaa2_generic_flow *
+dpaa2_flow_create_rss_flow(struct rte_eth_dev *dev,
 	const struct rte_flow_attr *attr,
 	const struct rte_flow_item pattern[],
 	const struct rte_flow_action actions[],
 	struct rte_flow_error *error)
 {
-	const struct rte_flow_action_rss *rss_conf;
-	int is_keycfg_configured = 0, end_of_list = 0;
-	int ret = 0, i = 0, j = 0;
+	struct dpaa2_generic_flow *flow = NULL;
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	struct dpaa2_dev_flow *curr = LIST_FIRST(&priv->flows);
-	uint16_t dist_size, key_size;
-	struct dpaa2_key_extract *qos_key_extract;
-	struct dpaa2_key_extract *tc_key_extract;
-	struct rte_dpaa2_flow_item *dpaa2_pattern = NULL;
+	int ret, tc = RTE_DPAA2_FLOW_GROUP_ID_GET(attr->group);
 
-	ret = dpaa2_flow_verify_attr(priv, attr);
-	if (ret)
-		return ret;
+	if (tc >= priv->num_rx_tc) {
+		DPAA2_PMD_ERR("Flow group(%d) >= max(%d)",
+			attr->group, priv->num_rx_tc);
+		return NULL;
+	}
 
-	ret = dpaa2_flow_verify_action(priv, attr, actions);
+	ret = dpaa2_flow_verify_flow_action(priv, attr, actions);
 	if (ret)
-		return ret;
+		return NULL;
+
+	dpaa2_flow_clean(dev, tc, DPAA2_FLOW_FS_TYPE);
 
-	ret = dpaa2_flow_item_convert(pattern, &dpaa2_pattern,
-		priv->sp_protocol);
+	flow = dpaa2_flow_generic_flow_init(priv, 0, true,
+		DPAA2_FLOW_RSS_TYPE, tc);
+	if (!flow)
+		return NULL;
+	ret = dpaa2_flow_rss_action_update(dev, flow, pattern, actions, error);
 	if (ret)
-		return ret;
+		goto creation_error;
 
-	/* Parse pattern list to get the matching parameters */
-	while (!end_of_list) {
-		switch (pattern[i].type) {
-		case RTE_FLOW_ITEM_TYPE_ETH:
-			ret = dpaa2_configure_flow_eth(flow, dev, attr,
-					&dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
-			if (ret) {
-				DPAA2_PMD_ERR("ETH flow config failed!");
-				goto end_flow_set;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_VLAN:
-			ret = dpaa2_configure_flow_vlan(flow, dev, attr,
-					&dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
-			if (ret) {
-				DPAA2_PMD_ERR("vLan flow config failed!");
-				goto end_flow_set;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_IPV4:
-			ret = dpaa2_configure_flow_ipv4(flow, dev, attr,
-					&dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
-			if (ret) {
-				DPAA2_PMD_ERR("IPV4 flow config failed!");
-				goto end_flow_set;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_IPV6:
-			ret = dpaa2_configure_flow_ipv6(flow, dev, attr,
-					&dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
-			if (ret) {
-				DPAA2_PMD_ERR("IPV6 flow config failed!");
-				goto end_flow_set;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_ICMP:
-			ret = dpaa2_configure_flow_icmp(flow, dev, attr,
-					&dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
-			if (ret) {
-				DPAA2_PMD_ERR("ICMP flow config failed!");
-				goto end_flow_set;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_UDP:
-			ret = dpaa2_configure_flow_udp(flow, dev, attr,
-					&dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
-			if (ret) {
-				DPAA2_PMD_ERR("UDP flow config failed!");
-				goto end_flow_set;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_TCP:
-			ret = dpaa2_configure_flow_tcp(flow, dev, attr,
-					&dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
-			if (ret) {
-				DPAA2_PMD_ERR("TCP flow config failed!");
-				goto end_flow_set;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_SCTP:
-			ret = dpaa2_configure_flow_sctp(flow, dev, attr,
-					&dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
-			if (ret) {
-				DPAA2_PMD_ERR("SCTP flow config failed!");
-				goto end_flow_set;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_ESP:
-			ret = dpaa2_configure_flow_esp(flow,
-					dev, attr, &dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
-			if (ret) {
-				DPAA2_PMD_ERR("ESP flow config failed!");
-				goto end_flow_set;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_AH:
-			ret = dpaa2_configure_flow_ah(flow,
-					dev, attr, &dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
-			if (ret) {
-				DPAA2_PMD_ERR("AH flow config failed!");
-				goto end_flow_set;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_GRE:
-			ret = dpaa2_configure_flow_gre(flow, dev, attr,
-					&dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
-			if (ret) {
-				DPAA2_PMD_ERR("GRE flow config failed!");
-				goto end_flow_set;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_VXLAN:
-			ret = dpaa2_configure_flow_vxlan(flow, dev, attr,
-					&dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
-			if (ret) {
-				DPAA2_PMD_ERR("VXLAN flow config failed!");
-				goto end_flow_set;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_ECPRI:
-			ret = dpaa2_configure_flow_ecpri(flow,
-					dev, attr, &dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
-			if (ret) {
-				DPAA2_PMD_ERR("ECPRI flow config failed!");
-				goto end_flow_set;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_GTP:
-			ret = dpaa2_configure_flow_gtp(flow,
-					dev, attr, &dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
-			if (ret) {
-				DPAA2_PMD_ERR("GTP flow config failed!");
-				goto end_flow_set;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_MPLS:
-			ret = dpaa2_configure_flow_mpls(flow,
-					dev, attr, &dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
-			if (ret) {
-				DPAA2_PMD_ERR("MPLS flow config failed!");
-				goto end_flow_set;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_PPPOES:
-			ret = dpaa2_configure_flow_pppoe(flow,
-					dev, attr, &dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
-			if (ret) {
-				DPAA2_PMD_ERR("PPPoE flow config failed!");
-				goto end_flow_set;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_RAW:
-			ret = dpaa2_configure_flow_raw(flow, dev, attr,
-					&dpaa2_pattern[i],
-					actions, error,
-					&is_keycfg_configured);
-			if (ret) {
-				DPAA2_PMD_ERR("RAW flow config failed!");
-				goto end_flow_set;
-			}
-			break;
-		case RTE_FLOW_ITEM_TYPE_END:
-			end_of_list = 1;
-			break; /*End of List*/
-		default:
-			DPAA2_PMD_ERR("Invalid flow item[%d] type(%d)",
-				i, pattern[i].type);
-			ret = -ENOTSUP;
-			break;
+	priv->flow_profile.tc_profile[tc].rss_flow = flow;
+
+	return flow;
+
+creation_error:
+	dpaa2_flow_generic_flow_deinit(flow);
+
+	return NULL;
+}
+
+static struct rte_flow *
+dpaa2_flow_create(struct rte_eth_dev *dev,
+	const struct rte_flow_attr *pattr,
+	const struct rte_flow_item pattern[],
+	const struct rte_flow_action actions[],
+	struct rte_flow_error *error)
+{
+	struct dpaa2_dev_flow *flow = NULL, *curr;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct rte_flow_attr attr;
+	struct rte_flow_action jump_actions[2];
+	struct rte_flow_action_jump jump_tc;
+	const struct rte_flow_action *qos_actions;
+	uint8_t fs_action_idx = 0;
+	int ret, err_code = 0;
+	struct dpaa2_generic_flow *rss_flow = NULL;
+	struct dpaa2_generic_flow *qos_flow = NULL;
+	struct dpaa2_generic_flow *fs_flow = NULL;
+	enum rte_flow_error_type error_type = RTE_FLOW_ERROR_TYPE_NONE;
+	const char *err_str = NULL;
+
+	ret = dpaa2_flow_attr_group_convert(priv, pattr, &attr);
+	if (ret) {
+		err_str = "Failure to convert attribute!";
+		error_type = RTE_FLOW_ERROR_TYPE_ATTR_GROUP;
+		err_code = ret;
+		goto flow_failure;
+	}
+
+	flow = rte_zmalloc(NULL, sizeof(struct dpaa2_dev_flow),
+		RTE_CACHE_LINE_SIZE);
+	if (!flow) {
+		err_str = "Failure to allocate memory for flow!";
+		error_type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+		err_code = -ENOMEM;
+		goto flow_failure;
+	}
+	if (actions && actions[0].type == RTE_FLOW_ACTION_TYPE_RSS) {
+		rss_flow = dpaa2_flow_create_rss_flow(dev, &attr, pattern, actions, error);
+		if (!rss_flow) {
+			err_str = "Failure to create RSS flow!";
+			error_type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+			err_code = -EINVAL;
+			goto flow_failure;
 		}
-		i++;
+		flow->rss_flow = rss_flow;
+		goto insert_flow;
 	}
 
-	qos_key_extract = &priv->extract.qos_key_extract;
-	key_size = qos_key_extract->key_profile.key_max_size;
-	flow->qos_rule.key_size = dpaa2_flow_entry_size(priv, key_size);
+	if (dpaa2_flow_is_qos_flow_only(priv, attr.group) ||
+		(actions && actions[0].type == RTE_FLOW_ACTION_TYPE_JUMP &&
+		actions[1].type == RTE_FLOW_ACTION_TYPE_END)) {
+		qos_actions = actions;
+		goto qos_flow_create;
+	}
 
-	tc_key_extract = &priv->extract.tc_key_extract[flow->tc_id];
-	key_size = tc_key_extract->key_profile.key_max_size;
-	flow->fs_rule.key_size = dpaa2_flow_entry_size(priv, key_size);
+	if (RTE_DPAA2_FLOW_GROUP_TYPE_GET(attr.group) == RTE_DPAA2_FS_GROUP_FLOW)
+		goto fs_flow_create;
 
-	/* Let's parse action on matching traffic */
-	end_of_list = 0;
-	while (!end_of_list) {
-		switch (actions[j].type) {
-		case RTE_FLOW_ACTION_TYPE_QUEUE:
-		case RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT:
-		case RTE_FLOW_ACTION_TYPE_PORT_ID:
-		case RTE_FLOW_ACTION_TYPE_DROP:
-			ret = dpaa2_configure_flow_fs_action(priv, flow,
-							     &actions[j]);
-			if (ret)
-				goto end_flow_set;
-
-			/* Configure FS table first*/
-			dist_size = priv->nb_rx_queues / priv->num_rx_tc;
-			if (is_keycfg_configured & DPAA2_FLOW_FS_TYPE) {
-				ret = dpaa2_configure_fs_rss_table(priv,
-								   flow->tc_id,
-								   dist_size,
-								   false);
-				if (ret)
-					goto end_flow_set;
-			}
+	jump_actions[0].type = RTE_FLOW_ACTION_TYPE_JUMP;
+	if (actions[0].type == RTE_FLOW_ACTION_TYPE_JUMP) {
+		jump_actions[0].conf = actions[0].conf;
+		fs_action_idx++;
+	} else {
+		jump_tc.group = attr.group;
+		jump_actions[0].conf = &jump_tc;
+	}
+	jump_actions[1].type = RTE_FLOW_ACTION_TYPE_END;
+	qos_actions = jump_actions;
+
+qos_flow_create:
+	if (!priv->qos_entries) {
+		err_str = "No QoS entry available!";
+		error_type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+		err_code = -EINVAL;
+		goto flow_failure;
+	}
+	qos_flow = dpaa2_flow_create_steering_flow(dev, &attr, pattern,
+		qos_actions, error, DPAA2_FLOW_QOS_TYPE);
+	if (!qos_flow) {
+		err_str = "QoS flow create failed!";
+		error_type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+		err_code = -EINVAL;
+		goto flow_failure;
+	}
+	flow->qos_flow = qos_flow;
+	if (dpaa2_flow_is_qos_flow_only(priv, attr.group))
+		goto insert_flow;
+
+fs_flow_create:
+	if (!priv->fs_entries) {
+		err_str = "No FS entry available!";
+		error_type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+		err_code = -EINVAL;
+		goto flow_failure;
+	}
+
+	fs_flow = dpaa2_flow_create_steering_flow(dev, &attr, pattern,
+		&actions[fs_action_idx], error, DPAA2_FLOW_FS_TYPE);
+	if (!fs_flow) {
+		err_str = "FS flow create failed!";
+		error_type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+		err_code = -EINVAL;
+		goto flow_failure;
+	}
+	flow->fs_flow = fs_flow;
+
+insert_flow:
+	/* New rules are inserted. */
+	curr = LIST_FIRST(&priv->flows);
+	if (!curr) {
+		LIST_INSERT_HEAD(&priv->flows, flow, next);
+	} else {
+		while (LIST_NEXT(curr, next))
+			curr = LIST_NEXT(curr, next);
+		LIST_INSERT_AFTER(curr, flow, next);
+	}
 
-			/* Configure QoS table then.*/
-			if (is_keycfg_configured & DPAA2_FLOW_QOS_TYPE) {
-				ret = dpaa2_configure_qos_table(priv, false);
-				if (ret)
-					goto end_flow_set;
-			}
+	return (struct rte_flow *)flow;
 
-			if (priv->num_rx_tc > 1) {
-				ret = dpaa2_flow_add_qos_rule(priv, flow);
-				if (ret)
-					goto end_flow_set;
-			}
+flow_failure:
+	if (!flow)
+		goto err_quit;
 
-			if (flow->tc_index >= priv->fs_entries) {
-				DPAA2_PMD_ERR("FS table with %d entries full",
-					priv->fs_entries);
-				return -1;
-			}
+	ret = dpaa2_flow_destroy_steering_flow(dev, flow->qos_flow);
+	if (ret)
+		DPAA2_PMD_ERR("%s: Failed(%d) to destroy QoS flow", __func__, ret);
+	ret = dpaa2_flow_destroy_steering_flow(dev, flow->fs_flow);
+	if (ret)
+		DPAA2_PMD_ERR("%s: Failed(%d) to destroy FS flow", __func__, ret);
+	ret = dpaa2_flow_destroy_rss_flow(dev, flow->rss_flow);
+	if (ret)
+		DPAA2_PMD_ERR("%s: Failed(%d) to destroy RSS flow", __func__, ret);
 
-			ret = dpaa2_flow_add_fs_rule(priv, flow);
-			if (ret)
-				goto end_flow_set;
+	rte_free(flow);
 
-			break;
-		case RTE_FLOW_ACTION_TYPE_RSS:
-			rss_conf = actions[j].conf;
-			flow->action_type = RTE_FLOW_ACTION_TYPE_RSS;
-
-			ret = dpaa2_distset_to_dpkg_profile_cfg(rss_conf->types,
-					&tc_key_extract->dpkg);
-			if (ret < 0) {
-				DPAA2_PMD_ERR("TC[%d] distset RSS failed",
-					      flow->tc_id);
-				goto end_flow_set;
-			}
+err_quit:
+	if (err_str)
+		DPAA2_PMD_ERR("%s: %s", __func__, err_str);
+	rte_flow_error_set(error, -err_code, error_type, NULL, err_str);
 
-			dist_size = rss_conf->queue_num;
-			if (is_keycfg_configured & DPAA2_FLOW_FS_TYPE) {
-				ret = dpaa2_configure_fs_rss_table(priv,
-								   flow->tc_id,
-								   dist_size,
-								   true);
-				if (ret)
-					goto end_flow_set;
-			}
+	return NULL;
+}
 
-			if (is_keycfg_configured & DPAA2_FLOW_QOS_TYPE) {
-				ret = dpaa2_configure_qos_table(priv, true);
-				if (ret)
-					goto end_flow_set;
-			}
+static int
+dpaa2_flow_destroy(struct rte_eth_dev *dev,
+	struct rte_flow *_flow, struct rte_flow_error *error)
+{
+	int ret = 0;
+	struct dpaa2_dev_flow *flow;
+
+	RTE_SET_USED(error);
+
+	flow = (struct dpaa2_dev_flow *)_flow;
+	LIST_REMOVE(flow, next);
+	ret |= dpaa2_flow_destroy_rss_flow(dev, flow->rss_flow);
+	ret |= dpaa2_flow_destroy_steering_flow(dev, flow->qos_flow);
+	ret |= dpaa2_flow_destroy_steering_flow(dev, flow->fs_flow);
+	if (!ret)
+		rte_free(flow);
 
-			ret = dpaa2_flow_add_qos_rule(priv, flow);
-			if (ret)
-				goto end_flow_set;
+	return ret;
+}
 
-			ret = dpaa2_flow_add_fs_rule(priv, flow);
-			if (ret)
-				goto end_flow_set;
+static int
+dpaa2_flow_set_miss_actions(struct rte_eth_dev *dev,
+	uint32_t group, const struct rte_flow_group_attr *attr,
+	const struct rte_flow_action actions[], struct rte_flow_error *err)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	enum dpaa2_flow_dist_type dist_type = DPAA2_FLOW_NULL_TYPE;
+	int end_of_list = 0, i = 0, discard = false, err_code = 0;
+	int qos_flow_only;
+	const struct rte_flow_action_jump *action_jump = NULL;
+	const struct rte_flow_action_queue *dest_queue = NULL;
+	uint32_t group_id = 0;
+	enum rte_flow_error_type error_type = RTE_FLOW_ERROR_TYPE_NONE;
+	const char *err_str = NULL;
+	struct dpaa2_queue *miss_rxq = NULL;
+	uint8_t qos_tc = 0xff;
+	uint16_t qos_flow = 0xffff;
+
+	RTE_SET_USED(attr);
+
+	qos_flow_only = dpaa2_flow_is_qos_flow_only(priv, group);
+	group_id = RTE_DPAA2_FLOW_GROUP_ID_GET(group);
+
+	if (group >= priv->num_rx_tc) {
+		if (!priv->qos_entries) {
+			error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+			err_code = -EINVAL;
+			err_str = "No QoS table available!";
+			goto failure_to_set_miss_actions;
+		}
+		dist_type = DPAA2_FLOW_QOS_TYPE;
+	} else {
+		if (qos_flow_only) {
+			error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+			err_code = -EINVAL;
+			err_str = "No TC table available!";
+			goto failure_to_set_miss_actions;
+		}
+		dist_type = DPAA2_FLOW_FS_TYPE;
+	}
 
+	while (!end_of_list) {
+		switch (actions[i].type) {
+		case RTE_FLOW_ACTION_TYPE_QUEUE:
+			dest_queue = actions[i].conf;
+			if (dest_queue->index >= dev->data->nb_rx_queues) {
+				error_type = RTE_FLOW_ERROR_TYPE_ACTION_CONF;
+				err_code = -EINVAL;
+				err_str = "Queue index overflows";
+				goto failure_to_set_miss_actions;
+			}
+			miss_rxq = priv->rx_vq[dest_queue->index];
 			break;
-		case RTE_FLOW_ACTION_TYPE_PF:
-			/* Skip this action, have to add for vxlan */
+		case RTE_FLOW_ACTION_TYPE_JUMP:
+			action_jump = actions[i].conf;
+			break;
+		case RTE_FLOW_ACTION_TYPE_DROP:
+			discard = true;
 			break;
 		case RTE_FLOW_ACTION_TYPE_END:
 			end_of_list = 1;
 			break;
 		default:
-			DPAA2_PMD_ERR("Invalid action type");
-			ret = -ENOTSUP;
+			DPAA2_PMD_WARN("Invalid default action type[%d]:(%d)",
+				i, actions[i].type);
 			break;
 		}
-		j++;
+		i++;
 	}
 
-end_flow_set:
-	if (!ret) {
-		/* New rules are inserted. */
-		if (!curr) {
-			LIST_INSERT_HEAD(&priv->flows, flow, next);
-		} else {
-			while (LIST_NEXT(curr, next))
-				curr = LIST_NEXT(curr, next);
-			LIST_INSERT_AFTER(curr, flow, next);
+	if (dist_type == DPAA2_FLOW_QOS_TYPE) {
+		if (action_jump && miss_rxq) {
+			if (action_jump->group != miss_rxq->tc_index) {
+				error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+				err_code = -EINVAL;
+				err_str = "Jump group conflicts to miss queue's TC";
+				goto failure_to_set_miss_actions;
+			}
+		}
+		if (action_jump)
+			qos_tc = action_jump->group;
+		if (miss_rxq) {
+			qos_tc = miss_rxq->tc_index;
+			qos_flow = miss_rxq->flow_id;
+		}
+		if ((!discard && qos_tc == 0xff) ||
+			(discard && qos_tc != 0xff)) {
+			error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+			err_code = -EINVAL;
+			err_str = "Invalid miss action set for QoS table";
+			goto failure_to_set_miss_actions;
+		}
+		err_code = dpaa2_flow_qos_table_set_default(priv, discard, qos_tc, qos_flow);
+		if (err_code) {
+			error_type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+			err_str = "Failed to set miss action for QoS table";
+			goto failure_to_set_miss_actions;
 		}
-	}
-
-	rte_free(dpaa2_pattern);
-
-	return ret;
-}
-
-static inline int
-dpaa2_dev_verify_attr(struct dpni_attr *dpni_attr,
-	const struct rte_flow_attr *attr)
-{
-	int ret = 0;
 
-	if (unlikely(attr->group >= dpni_attr->num_rx_tcs)) {
-		DPAA2_PMD_ERR("Group/TC(%d) is out of range(%d)",
-			attr->group, dpni_attr->num_rx_tcs);
-		ret = -ENOTSUP;
+		return 0;
 	}
-	if (unlikely(attr->priority >= dpni_attr->fs_entries)) {
-		DPAA2_PMD_ERR("Priority(%d) within group is out of range(%d)",
-			attr->priority, dpni_attr->fs_entries);
-		ret = -ENOTSUP;
+
+	if (!discard && !miss_rxq) {
+		error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+		err_code = -EINVAL;
+		err_str = "Invalid miss action set for FS table";
+		goto failure_to_set_miss_actions;
 	}
-	if (unlikely(attr->egress)) {
-		DPAA2_PMD_ERR("Egress flow configuration is not supported");
-		ret = -ENOTSUP;
+	if (miss_rxq && miss_rxq->tc_index != group_id) {
+		error_type = RTE_FLOW_ERROR_TYPE_ATTR_GROUP;
+		err_code = -EINVAL;
+		err_str = "Group conflicts with dest queue's TC ID";
+		goto failure_to_set_miss_actions;
 	}
-	if (unlikely(!attr->ingress)) {
-		DPAA2_PMD_ERR("Ingress flag must be configured");
-		ret = -EINVAL;
+	err_code = dpaa2_flow_fs_table_set_default(priv, group_id, discard,
+		dest_queue ? dest_queue->index : 0);
+	if (err_code) {
+		error_type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+		err_str = "Failed to set miss action for FS table";
 	}
-	return ret;
+
+failure_to_set_miss_actions:
+	if (err_str)
+		DPAA2_PMD_ERR("%s: %s", __func__, err_str);
+	rte_flow_error_set(err, -err_code, error_type, NULL, err_str);
+
+	return err_code;
 }
 
-static inline int
-dpaa2_dev_verify_patterns(const struct rte_flow_item pattern[],
-	int sp_support)
+static int
+dpaa2_flow_steering_flow_action_update(struct rte_eth_dev *dev,
+	struct dpaa2_generic_flow *flow,
+	const struct rte_flow_action actions[],
+	struct rte_flow_error *error,
+	enum dpaa2_flow_dist_type dist_type)
 {
-	uint32_t i, j, is_found = 0;
-	int ret = 0;
-	const enum rte_flow_item_type *hp_supported;
-	const enum rte_flow_item_type *sp_supported;
-	uint64_t hp_supported_num, sp_supported_num;
+	int err_code = 0;
+	enum rte_flow_error_type error_type = RTE_FLOW_ERROR_TYPE_NONE;
+	const char *err_str = NULL;
 
-	hp_supported = dpaa2_hp_supported_pattern_type;
-	hp_supported_num = RTE_DIM(dpaa2_hp_supported_pattern_type);
+	RTE_SET_USED(dev);
 
-	sp_supported = dpaa2_sp_supported_pattern_type;
-	sp_supported_num = RTE_DIM(dpaa2_sp_supported_pattern_type);
+	err_code = dpaa2_flow_steering_action_convert(flow, actions);
+	if (err_code) {
+		DPAA2_PMD_ERR("%s: steering action update failed(%d)",
+			__func__, err_code);
+		error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+		err_str = "Failed to QoS action update!";
 
-	for (j = 0; pattern[j].type != RTE_FLOW_ITEM_TYPE_END; j++) {
-		is_found = 0;
-		for (i = 0; i < hp_supported_num; i++) {
-			if (hp_supported[i] == pattern[j].type) {
-				is_found = 1;
-				break;
-			}
-		}
-		if (is_found)
-			continue;
-		if (sp_support) {
-			for (i = 0; i < sp_supported_num; i++) {
-				if (sp_supported[i] == pattern[j].type) {
-					is_found = 1;
-					break;
-				}
-			}
-		}
-		if (!is_found) {
-			DPAA2_PMD_WARN("Flow type(%d) not supported", pattern[j].type);
-			ret = -ENOTSUP;
-			break;
-		}
+		goto quit;
 	}
 
-	return ret;
+	err_code = dpaa2_flow_add_steering_rule(flow, true);
+	if (err_code) {
+		DPAA2_PMD_ERR("Failed(%d) to update %s flow entry",
+			err_code, dist_type == DPAA2_FLOW_QOS_TYPE ? "QoS" : "FS");
+		error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+		err_str = "Failed to update action of entry to HW!";
+	}
+
+quit:
+	if (err_str)
+		DPAA2_PMD_ERR("%s: %s", __func__, err_str);
+	return rte_flow_error_set(error, -err_code, error_type, NULL, err_str);
 }
 
-static inline int
-dpaa2_dev_verify_actions(const struct rte_flow_action actions[])
+static int
+dpaa2_flow_actions_update(struct rte_eth_dev *dev,
+	struct rte_flow *_flow,
+	const struct rte_flow_action actions[],
+	struct rte_flow_error *error)
 {
-	unsigned int i, j, is_found = 0;
-	int ret = 0;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_flow *flow;
+	int found = false, err_code = 0;
+	uint16_t update_num;
+	enum rte_flow_error_type error_type = RTE_FLOW_ERROR_TYPE_NONE;
+	const char *err_str = NULL;
+	enum rte_flow_action_type supported;
+	struct rte_flow_action actions_update[DPAA2_MAX_ACTION_PER_FLOW_NUM];
+
+	LIST_FOREACH(flow, &priv->flows, next) {
+		if ((struct rte_flow *)flow == _flow) {
+			found = true;
+			break;
+		}
+	}
+	if (!found) {
+		DPAA2_PMD_ERR("%s: Flow(%p) is not in %s's flow list",
+			__func__, flow, dev->data->name);
+		error_type = RTE_FLOW_ERROR_TYPE_UNSPECIFIED;
+		err_str = "Invalid flow for action update!";
+		err_code = -EINVAL;
+		goto quit;
+	}
+
+	/* check for the valid flow */
+	flow = (void *)_flow;
+
+	supported = RTE_FLOW_ACTION_TYPE_RSS;
+	update_num = dpaa2_flow_check_actions_support(actions,
+		&supported, 1, actions_update);
+	if (flow->rss_flow && update_num) {
+		err_code = dpaa2_flow_rss_action_update(dev, flow->rss_flow, NULL, actions, error);
+		if (err_code) {
+			error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+			err_str = "Failed to update rss action!";
+			goto quit;
+		}
+	}
 
-	for (j = 0; actions[j].type != RTE_FLOW_ACTION_TYPE_END; j++) {
-		for (i = 0; i < RTE_DIM(dpaa2_supported_action_type); i++) {
-			if (dpaa2_supported_action_type[i] == actions[j].type) {
-				is_found = 1;
-				break;
-			}
+	supported = RTE_FLOW_ACTION_TYPE_JUMP;
+	update_num = dpaa2_flow_check_actions_support(actions,
+		&supported, 1, actions_update);
+	if (flow->qos_flow && flow->fs_flow && update_num) {
+		err_code = dpaa2_flow_steering_flow_action_update(dev, flow->qos_flow,
+			actions_update, error, DPAA2_FLOW_QOS_TYPE);
+		if (err_code) {
+			error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+			err_str = "Failed to update qos action!";
+			goto quit;
 		}
-		if (!is_found) {
-			ret = -ENOTSUP;
-			break;
+	}
+
+	update_num = dpaa2_flow_check_actions_support(actions,
+		dpaa2_supported_qos_action_type,
+		RTE_DIM(dpaa2_supported_qos_action_type),
+		actions_update);
+	if (flow->qos_flow && !flow->fs_flow && update_num) {
+		err_code = dpaa2_flow_steering_flow_action_update(dev, flow->qos_flow,
+			actions_update, error, DPAA2_FLOW_QOS_TYPE);
+		if (err_code) {
+			error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+			err_str = "Failed to update qos action!";
+			goto quit;
 		}
 	}
-	for (j = 0; actions[j].type != RTE_FLOW_ACTION_TYPE_END; j++) {
-		if (actions[j].type != RTE_FLOW_ACTION_TYPE_DROP &&
-		    !actions[j].conf)
-			ret = -EINVAL;
+
+	update_num = dpaa2_flow_check_actions_support(actions,
+		dpaa2_supported_fs_action_type,
+		RTE_DIM(dpaa2_supported_fs_action_type),
+		actions_update);
+	if (flow->fs_flow && update_num) {
+		err_code = dpaa2_flow_steering_flow_action_update(dev, flow->qos_flow,
+			actions_update, error, DPAA2_FLOW_FS_TYPE);
+		if (err_code) {
+			error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+			err_str = "Failed to update fs action!";
+			goto quit;
+		}
 	}
-	return ret;
+
+quit:
+	if (err_str)
+		DPAA2_PMD_ERR("%s: %s", __func__, err_str);
+	return rte_flow_error_set(error, -err_code, error_type, NULL, err_str);
 }
 
+/**
+ * Destroy user-configured flow rules.
+ *
+ * This function skips internal flows rules.
+ *
+ * @see rte_flow_flush()
+ * @see rte_flow_ops
+ */
 static int
-dpaa2_flow_validate(struct rte_eth_dev *dev,
-	const struct rte_flow_attr *flow_attr,
-	const struct rte_flow_item pattern[],
-	const struct rte_flow_action actions[],
-	struct rte_flow_error *error)
+dpaa2_flow_flush(struct rte_eth_dev *dev,
+		struct rte_flow_error *error)
 {
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	struct dpni_attr dpni_attr;
-	struct fsl_mc_io *dpni = (struct fsl_mc_io *)priv->hw;
-	uint16_t token = priv->token;
+	struct dpaa2_dev_flow *flow = LIST_FIRST(&priv->flows);
 	int ret = 0;
 
-	memset(&dpni_attr, 0, sizeof(struct dpni_attr));
-	ret = dpni_get_attributes(dpni, CMD_PRI_LOW, token, &dpni_attr);
-	if (ret < 0) {
-		DPAA2_PMD_ERR("Get dpni@%d attribute failed(%d)",
-			priv->hw_id, ret);
-		rte_flow_error_set(error, EPERM,
-			RTE_FLOW_ERROR_TYPE_ATTR,
-			flow_attr, "invalid");
-		return ret;
-	}
+	while (flow) {
+		struct dpaa2_dev_flow *next = LIST_NEXT(flow, next);
 
-	/* Verify input attributes */
-	ret = dpaa2_dev_verify_attr(&dpni_attr, flow_attr);
-	if (ret < 0) {
-		DPAA2_PMD_ERR("Invalid attributes are given");
-		rte_flow_error_set(error, EPERM,
-			RTE_FLOW_ERROR_TYPE_ATTR,
-			flow_attr, "invalid");
-		goto not_valid_params;
-	}
-	/* Verify input pattern list */
-	ret = dpaa2_dev_verify_patterns(pattern, priv->sp_protocol);
-	if (ret < 0) {
-		DPAA2_PMD_ERR("Invalid pattern list is given");
-		rte_flow_error_set(error, EPERM,
-			RTE_FLOW_ERROR_TYPE_ITEM,
-			pattern, "invalid");
-		goto not_valid_params;
-	}
-	/* Verify input action list */
-	ret = dpaa2_dev_verify_actions(actions);
-	if (ret < 0) {
-		DPAA2_PMD_ERR("Invalid action list is given");
-		rte_flow_error_set(error, EPERM,
-			RTE_FLOW_ERROR_TYPE_ACTION,
-			actions, "invalid");
-		goto not_valid_params;
+		ret = dpaa2_flow_destroy(dev, (struct rte_flow *)flow, error);
+		if (ret) {
+			DPAA2_PMD_ERR("%s: Remove flow failed(%d)",
+				__func__, ret);
+		}
+
+		flow = next;
 	}
-not_valid_params:
+
 	return ret;
 }
 
-static struct rte_flow *
-dpaa2_flow_create(struct rte_eth_dev *dev, const struct rte_flow_attr *attr,
-		  const struct rte_flow_item pattern[],
-		  const struct rte_flow_action actions[],
-		  struct rte_flow_error *error)
+static int
+dpaa2_flow_query(struct rte_eth_dev *dev,
+	struct rte_flow *_flow, const struct rte_flow_action *actions,
+	void *data, struct rte_flow_error *error)
 {
-	struct dpaa2_dev_flow *flow = NULL;
+	struct dpaa2_dev_flow *flow;
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	int ret;
-	uint64_t iova;
-
-	dpaa2_flow_control_log =
-		getenv("DPAA2_FLOW_CONTROL_LOG");
-
-	flow = rte_zmalloc(NULL, sizeof(struct dpaa2_dev_flow),
-			   RTE_CACHE_LINE_SIZE);
-	if (!flow) {
-		DPAA2_PMD_ERR("Failure to allocate memory for flow");
-		goto mem_failure;
-	}
+	uint16_t num = 0, num_rsp, i, tc_id = 0;
+	int ret = 0, found = false;
+	size_t size, iova;
+	struct dpni_dump_table_rsp *rsp = NULL;
 
-	/* Allocate DMA'ble memory to write the qos rules */
-	flow->qos_key_addr = rte_zmalloc(NULL,
-		DPAA2_EXTRACT_ALLOC_KEY_MAX_SIZE, RTE_CACHE_LINE_SIZE);
-	if (!flow->qos_key_addr) {
-		DPAA2_PMD_ERR("Memory allocation failed");
-		goto mem_failure;
-	}
-	iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(flow->qos_key_addr,
-			DPAA2_EXTRACT_ALLOC_KEY_MAX_SIZE);
-	if (iova == RTE_BAD_IOVA) {
-		DPAA2_PMD_ERR("%s: No IOMMU map for qos key(%p)",
-			__func__, flow->qos_key_addr);
-		goto mem_failure;
-	}
-	flow->qos_rule.key_iova = iova;
+	RTE_SET_USED(actions);
+	RTE_SET_USED(data);
+	RTE_SET_USED(error);
 
-	flow->qos_mask_addr = rte_zmalloc(NULL,
-		DPAA2_EXTRACT_ALLOC_KEY_MAX_SIZE, RTE_CACHE_LINE_SIZE);
-	if (!flow->qos_mask_addr) {
-		DPAA2_PMD_ERR("Memory allocation failed");
-		goto mem_failure;
-	}
-	iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(flow->qos_mask_addr,
-			DPAA2_EXTRACT_ALLOC_KEY_MAX_SIZE);
+	flow = LIST_FIRST(&priv->flows);
+	while (flow) {
+		num++;
+		if (flow == (struct dpaa2_dev_flow *)_flow)
+			found = true;
+		flow = LIST_NEXT(flow, next);
+	}
+	if (!num || found == false)
+		return -ENXIO;
+	num = num * 2;/** Max: FS entry + QoS entry.*/
+	flow = (void *)_flow;
+	size = sizeof(struct dpni_dump_table_header) +
+		num * sizeof(struct dpni_dump_table_entry);
+	rsp = rte_zmalloc(NULL, size, RTE_CACHE_LINE_SIZE);
+	if (!rsp)
+		return -ENOMEM;
+	iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(rsp, size);
 	if (iova == RTE_BAD_IOVA) {
-		DPAA2_PMD_ERR("%s: No IOMMU map for qos mask(%p)",
-			__func__, flow->qos_mask_addr);
-		goto mem_failure;
+		DPAA2_PMD_ERR("%s: No IOMMU map for dump table result!",
+			__func__);
+		ret = -EIO;
+		goto quit;
 	}
-	flow->qos_rule.mask_iova = iova;
 
-	/* Allocate DMA'ble memory to write the FS rules */
-	flow->fs_key_addr = rte_zmalloc(NULL,
-		DPAA2_EXTRACT_ALLOC_KEY_MAX_SIZE, RTE_CACHE_LINE_SIZE);
-	if (!flow->fs_key_addr) {
-		DPAA2_PMD_ERR("Memory allocation failed");
-		goto mem_failure;
-	}
-	iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(flow->fs_key_addr,
-			DPAA2_EXTRACT_ALLOC_KEY_MAX_SIZE);
-	if (iova == RTE_BAD_IOVA) {
-		DPAA2_PMD_ERR("%s: No IOMMU map for fs key(%p)",
-			__func__, flow->fs_key_addr);
-		goto mem_failure;
-	}
-	flow->fs_rule.key_iova = iova;
+	if (priv->num_rx_tc <= 1)
+		goto dump_fs;
 
-	flow->fs_mask_addr = rte_zmalloc(NULL,
-		DPAA2_EXTRACT_ALLOC_KEY_MAX_SIZE, RTE_CACHE_LINE_SIZE);
-	if (!flow->fs_mask_addr) {
-		DPAA2_PMD_ERR("Memory allocation failed");
-		goto mem_failure;
-	}
-	iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(flow->fs_mask_addr,
-		DPAA2_EXTRACT_ALLOC_KEY_MAX_SIZE);
-	if (iova == RTE_BAD_IOVA) {
-		DPAA2_PMD_ERR("%s: No IOMMU map for fs mask(%p)",
-			__func__, flow->fs_mask_addr);
-		goto mem_failure;
+	ret = dpni_dump_table(priv->hw, CMD_PRI_LOW,
+		priv->token, DPNI_QOS_TABLE, 0/**Any*/,
+		iova, size, &num_rsp);
+	if (ret) {
+		DPAA2_PMD_ERR("dump %s's QoS table failed(%d)",
+			dev->data->name, ret);
+		goto quit;
 	}
-	flow->fs_rule.mask_iova = iova;
 
-	priv->curr = flow;
+	if (!flow->qos_flow)
+		goto dump_fs;
 
-	ret = dpaa2_generic_flow_set(flow, dev, attr, pattern, actions, error);
-	if (ret < 0) {
-		if (error && error->type > RTE_FLOW_ERROR_TYPE_ACTION)
-			rte_flow_error_set(error, EPERM,
-					   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-					   attr, "unknown");
-		DPAA2_PMD_ERR("Create flow failed (%d)", ret);
-		goto creation_error;
+	for (i = 0; i < num_rsp; i++) {
+		if (!memcmp(rsp->entry[i].key, flow->qos_flow->key_addr,
+			flow->qos_flow->rule_size) &&
+			!memcmp(rsp->entry[i].mask,
+			flow->qos_flow->mask_addr, flow->qos_flow->rule_size))
+			break;
 	}
 
-	priv->curr = NULL;
-	return (struct rte_flow *)flow;
-
-mem_failure:
-	rte_flow_error_set(error, EPERM, RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
-			   "memory alloc");
+dump_fs:
+	if (!flow->fs_flow)
+		goto quit;
 
-creation_error:
-	if (flow) {
-		rte_free(flow->qos_key_addr);
-		rte_free(flow->qos_mask_addr);
-		rte_free(flow->fs_key_addr);
-		rte_free(flow->fs_mask_addr);
-		rte_free(flow);
+	tc_id = flow->fs_flow->tc_id;
+	ret = dpni_dump_table(priv->hw, CMD_PRI_LOW,
+		priv->token, DPNI_FS_TABLE, tc_id,
+		iova, size, &num_rsp);
+	if (ret) {
+		DPAA2_PMD_ERR("dump %s's FS%d table failed(%d)",
+			dev->data->name, tc_id, ret);
+		goto quit;
+	}
+	for (i = 0; i < num_rsp; i++) {
+		if (!memcmp(rsp->entry[i].key, flow->fs_flow->key_addr,
+			flow->fs_flow->rule_size) &&
+			!memcmp(rsp->entry[i].mask,
+			flow->fs_flow->mask_addr, flow->fs_flow->rule_size)) {
+			break;
+		}
 	}
-	priv->curr = NULL;
 
-	return NULL;
+quit:
+	if (rsp)
+		rte_free(rsp);
+
+	return ret;
 }
 
 static int
-dpaa2_flow_destroy(struct rte_eth_dev *dev, struct rte_flow *_flow,
-		   struct rte_flow_error *error)
+dpaa2_flow_table_dump_check(struct dpni_dump_table_rsp *rsp,
+	uint16_t num_rsp, char *dump_str, uint32_t str_size, int type,
+	struct dpaa2_dev_flow *_flow, uint16_t size)
 {
-	int ret = 0;
+	uint16_t i, j, off = 0;
+	int found, ret = 0;
+	uint8_t *key, *mask;
 	struct dpaa2_dev_flow *flow;
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	struct fsl_mc_io *dpni = priv->hw;
 
-	flow = (struct dpaa2_dev_flow *)_flow;
-
-	switch (flow->action_type) {
-	case RTE_FLOW_ACTION_TYPE_QUEUE:
-	case RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT:
-	case RTE_FLOW_ACTION_TYPE_PORT_ID:
-	case RTE_FLOW_ACTION_TYPE_DROP:
-		if (priv->num_rx_tc > 1) {
-			/* Remove entry from QoS table first */
-			ret = dpni_remove_qos_entry(dpni, CMD_PRI_LOW,
-						    priv->token,
-						    &flow->qos_rule);
-			if (ret < 0) {
-				DPAA2_PMD_ERR("Remove FS QoS entry failed");
-				dpaa2_flow_qos_entry_log("Delete failed", flow,
-							 -1);
-				abort();
-				goto error;
-			}
+	for (i = 0; i < num_rsp; i++) {
+		off += snprintf(&dump_str[off], str_size - off,
+			"entry%d: idx(%d):action(%d)\nkey:\n",
+			i, rsp->entry[i].rule_index,
+			rsp->entry[i].key_action);
+		for (j = 0; j < size; j++) {
+			off += snprintf(&dump_str[off], str_size - off, "%02x ",
+				rsp->entry[i].key[j]);
 		}
-
-		/* Then remove entry from FS table */
-		ret = dpni_remove_fs_entry(dpni, CMD_PRI_LOW, priv->token,
-					   flow->tc_id, &flow->fs_rule);
-		if (ret < 0) {
-			DPAA2_PMD_ERR("Remove entry from FS[%d] failed",
-				      flow->tc_id);
-			goto error;
+		off += snprintf(&dump_str[off], str_size - off, "\nmask:\n");
+		for (j = 0; j < size; j++) {
+			off += snprintf(&dump_str[off], str_size - off, "%02x ",
+				rsp->entry[i].mask[j]);
 		}
-		break;
-	case RTE_FLOW_ACTION_TYPE_RSS:
-		if (priv->num_rx_tc > 1) {
-			ret = dpni_remove_qos_entry(dpni, CMD_PRI_LOW,
-						    priv->token,
-						    &flow->qos_rule);
-			if (ret < 0) {
-				DPAA2_PMD_ERR("Remove RSS QoS entry failed");
-				goto error;
+		off += snprintf(&dump_str[off], str_size - off, "\n");
+		found = false;
+		flow = _flow;
+		while (flow) {
+			if (type == DPAA2_FLOW_QOS_TYPE) {
+				key = flow->qos_flow->key_addr;
+				mask = flow->qos_flow->mask_addr;
+			} else {
+				key = flow->fs_flow->key_addr;
+				mask = flow->fs_flow->mask_addr;
+			}
+			if (!memcmp(rsp->entry[i].key, key, size) &&
+				!memcmp(rsp->entry[i].mask, mask, size)) {
+				found = true;
+				break;
 			}
+			flow = LIST_NEXT(flow, next);
+		}
+		if (!found) {
+			off += snprintf(&dump_str[off], str_size - off,
+				"This entry not found in flow list\n");
+			ret = -ENXIO;
 		}
-		break;
-	default:
-		DPAA2_PMD_ERR("Action(%d) not supported", flow->action_type);
-		ret = -ENOTSUP;
-		break;
 	}
 
-	LIST_REMOVE(flow, next);
-	rte_free(flow->qos_key_addr);
-	rte_free(flow->qos_mask_addr);
-	rte_free(flow->fs_key_addr);
-	rte_free(flow->fs_mask_addr);
-	/* Now free the flow */
-	rte_free(flow);
-
-error:
-	if (ret)
-		rte_flow_error_set(error, EPERM,
-				   RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
-				   NULL, "unknown");
 	return ret;
 }
 
-/**
- * Destroy user-configured flow rules.
- *
- * This function skips internal flows rules.
- *
- * @see rte_flow_flush()
- * @see rte_flow_ops
- */
-static int
-dpaa2_flow_flush(struct rte_eth_dev *dev,
-		struct rte_flow_error *error)
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dpaa2_flow_table_query, 24.11)
+int
+rte_pmd_dpaa2_flow_table_query(uint16_t portid)
 {
-	struct dpaa2_dev_priv *priv = dev->data->dev_private;
-	struct dpaa2_dev_flow *flow = LIST_FIRST(&priv->flows);
+	struct rte_eth_dev *dev;
+	struct dpaa2_dev_flow *flow;
+	struct dpaa2_dev_priv *priv;
+	uint16_t num = 0, num_rsp, tc_id = 0;
+	int ret = 0, fs_enable[MAX_TCS];
+	size_t size, iova;
+	struct dpni_dump_table_rsp *rsp = NULL;
+	char *dump_str = NULL;
+	uint16_t fs_rule_size[MAX_TCS], qos_rule_size;
+	struct dpaa2_generic_flow *_flow;
+
+	if (!rte_pmd_dpaa2_dev_is_dpaa2(portid))
+		return -EINVAL;
 
-	while (flow) {
-		struct dpaa2_dev_flow *next = LIST_NEXT(flow, next);
+	dev = &rte_eth_devices[portid];
+	priv = dev->data->dev_private;
 
-		dpaa2_flow_destroy(dev, (struct rte_flow *)flow, error);
-		flow = next;
+	memset(fs_enable, 0, sizeof(fs_enable));
+	memset(fs_rule_size, 0, sizeof(fs_rule_size));
+	qos_rule_size = 0;
+	flow = LIST_FIRST(&priv->flows);
+	while (flow) {
+		if (!flow->fs_flow)
+			goto next_flow;
+		_flow = flow->fs_flow;
+		fs_enable[_flow->tc_id]++;
+		if (fs_rule_size[_flow->tc_id] < _flow->rule_size)
+			fs_rule_size[_flow->tc_id] = _flow->rule_size;
+		if (qos_rule_size < _flow->rule_size)
+			qos_rule_size = _flow->rule_size;
+		num++;
+next_flow:
+		flow = LIST_NEXT(flow, next);
+	}
+	if (!num)
+		return -ENXIO;
+	size = sizeof(struct dpni_dump_table_header) +
+		num * sizeof(struct dpni_dump_table_entry);
+	rsp = rte_zmalloc(NULL, size, RTE_CACHE_LINE_SIZE);
+	if (!rsp)
+		return -ENOMEM;
+	dump_str = rte_zmalloc(NULL, num * 1024, 0);
+	if (!dump_str)
+		goto quit;
+	iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(rsp, size);
+	if (iova == RTE_BAD_IOVA) {
+		DPAA2_PMD_ERR("%s: No IOMMU map for dump table result!",
+			__func__);
+		goto quit;
 	}
-	return 0;
-}
 
-static int
-dpaa2_flow_query(struct rte_eth_dev *dev __rte_unused,
-	struct rte_flow *_flow __rte_unused,
-	const struct rte_flow_action *actions __rte_unused,
-	void *data __rte_unused,
-	struct rte_flow_error *error __rte_unused)
-{
-	return 0;
+	if (priv->num_rx_tc <= 1)
+		goto dump_fs;
+
+	ret = dpni_dump_table(priv->hw, CMD_PRI_LOW,
+		priv->token, DPNI_QOS_TABLE, 0/**Any*/,
+		iova, size, &num_rsp);
+	if (ret) {
+		DPAA2_PMD_ERR("dump %s's QoS table failed(%d)",
+			dev->data->name, ret);
+		goto quit;
+	}
+	DPAA2_PMD_INFO("dump %s's QoS table: type(%d):num(%d-%d):max(%d)",
+		dev->data->name,
+		rte_be_to_cpu_16(rsp->hdr.table_type), num_rsp,
+		rte_be_to_cpu_16(rsp->hdr.table_num_entries),
+		rte_be_to_cpu_16(rsp->hdr.table_max_entries));
+	ret = dpaa2_flow_table_dump_check(rsp, num_rsp,
+		dump_str, num * 1024, DPAA2_FLOW_QOS_TYPE,
+		LIST_FIRST(&priv->flows), qos_rule_size);
+	DPAA2_PMD_INFO("%s", dump_str);
+	if (ret)
+		goto quit;
+
+dump_fs:
+	if (!fs_enable[tc_id])
+		goto dump_next_fs;
+	ret = dpni_dump_table(priv->hw, CMD_PRI_LOW,
+		priv->token, DPNI_FS_TABLE, tc_id,
+		iova, size, &num_rsp);
+	if (ret) {
+		DPAA2_PMD_ERR("dump %s's FS%d table failed(%d)",
+			dev->data->name, tc_id, ret);
+		goto dump_next_fs;
+	}
+	DPAA2_PMD_INFO("dump %s's FS%d table: type(%d):num(%d-%d):max(%d)",
+		dev->data->name, tc_id,
+		rte_be_to_cpu_16(rsp->hdr.table_type), num_rsp,
+		rte_be_to_cpu_16(rsp->hdr.table_num_entries),
+		rte_be_to_cpu_16(rsp->hdr.table_max_entries));
+	ret = dpaa2_flow_table_dump_check(rsp, num_rsp,
+		dump_str, num * 1024, DPAA2_FLOW_FS_TYPE,
+		LIST_FIRST(&priv->flows), fs_rule_size[tc_id]);
+	DPAA2_PMD_INFO("%s", dump_str);
+	if (ret)
+		goto quit;
+dump_next_fs:
+	tc_id++;
+	if (tc_id < MAX_TCS)
+		goto dump_fs;
+
+quit:
+	if (rsp)
+		rte_free(rsp);
+	if (dump_str)
+		rte_free(dump_str);
+
+	return ret;
 }
 
 /**
@@ -5414,19 +4538,46 @@ dpaa2_flow_query(struct rte_eth_dev *dev __rte_unused,
  *   Pointer to private structure.
  */
 void
-dpaa2_flow_clean(struct rte_eth_dev *dev)
+dpaa2_flow_clean(struct rte_eth_dev *dev, uint8_t tc_id,
+	enum dpaa2_flow_dist_type type)
 {
-	struct dpaa2_dev_flow *flow;
+	struct dpaa2_dev_flow *flow, *next_flow;
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	int ret;
 
-	while ((flow = LIST_FIRST(&priv->flows)))
-		dpaa2_flow_destroy(dev, (struct rte_flow *)flow, NULL);
+	flow = LIST_FIRST(&priv->flows);
+	if (tc_id >= MAX_TCS)
+		goto clean_all;
+	while (flow) {
+		next_flow = LIST_NEXT(flow, next);
+		if (((type & DPAA2_FLOW_QOS_TYPE) && flow->qos_flow) ||
+			((type & DPAA2_FLOW_FS_TYPE) && flow->fs_flow &&
+			flow->fs_flow->tc_id == tc_id) ||
+			((type & DPAA2_FLOW_RSS_TYPE) && flow->rss_flow &&
+			flow->rss_flow->tc_id == tc_id)) {
+			ret = dpaa2_flow_destroy(dev, (struct rte_flow *)flow, NULL);
+			if (ret)
+				DPAA2_PMD_ERR("Failed(%d) to remove flow(type=%x)", ret, type);
+		}
+		flow = next_flow;
+	}
+	return;
+
+clean_all:
+	while (flow) {
+		ret = dpaa2_flow_destroy(dev, (struct rte_flow *)flow, NULL);
+		if (ret)
+			DPAA2_PMD_ERR("Failed(%d) to remove flow", ret);
+		flow = LIST_FIRST(&priv->flows);
+	}
 }
 
 const struct rte_flow_ops dpaa2_flow_ops = {
 	.create	= dpaa2_flow_create,
 	.validate = dpaa2_flow_validate,
 	.destroy = dpaa2_flow_destroy,
+	.group_set_miss_actions = dpaa2_flow_set_miss_actions,
+	.actions_update = dpaa2_flow_actions_update,
 	.flush	= dpaa2_flow_flush,
 	.query	= dpaa2_flow_query,
 };
diff --git a/drivers/net/dpaa2/dpaa2_parser_decode.h b/drivers/net/dpaa2/dpaa2_parser_decode.h
index f07a70a826..7baf471ac0 100644
--- a/drivers/net/dpaa2/dpaa2_parser_decode.h
+++ b/drivers/net/dpaa2/dpaa2_parser_decode.h
@@ -14,6 +14,7 @@
 #define ROCEV2_DEST_QP_SIZE	3
 
 enum dpaa2_parser_protocol_id {
+	DPAA2_PARSER_NULL_ID,
 	DPAA2_PARSER_MAC_ID,
 	DPAA2_PARSER_VLAN_ID,
 	DPAA2_PARSER_ICMP_ID,
@@ -26,6 +27,8 @@ enum dpaa2_parser_protocol_id {
 	DPAA2_PARSER_TCP_ID,
 	DPAA2_PARSER_SCTP_ID,
 	DPAA2_PARSER_GTP_ID,
+	DPAA2_PARSER_MPLS_ID,
+	DPAA2_PARSER_PPPOE_ID,
 	DPAA2_PARSER_IPSEC_AH_ID,
 	DPAA2_PARSER_IPSEC_ESP_ID,
 	DPAA2_PARSER_VXLAN_ID,
@@ -718,6 +721,12 @@ dpaa2_protocol_psr_bit_offset(uint32_t *bit_offset,
 	} else if (protocol == DPAA2_PARSER_GTP_ID) {
 		faf_h.gtp = 1;
 		*bit_offset = dpaa2_psr_faf_h_bit_offset(&faf_h);
+	} else if (protocol == DPAA2_PARSER_MPLS_ID) {
+		faf_l.mpls_1 = 1;
+		*bit_offset = dpaa2_psr_faf_l_bit_offset(&faf_l);
+	} else if (protocol == DPAA2_PARSER_PPPOE_ID) {
+		faf_l.pppoe_ppp = 1;
+		*bit_offset = dpaa2_psr_faf_l_bit_offset(&faf_l);
 	} else if (protocol == DPAA2_PARSER_IPSEC_ESP_ID) {
 		faf_h.ipsec_esp = 1;
 		*bit_offset = dpaa2_psr_faf_h_bit_offset(&faf_h);
diff --git a/drivers/net/dpaa2/rte_pmd_dpaa2.h b/drivers/net/dpaa2/rte_pmd_dpaa2.h
index a6441eed65..f8718db0dc 100644
--- a/drivers/net/dpaa2/rte_pmd_dpaa2.h
+++ b/drivers/net/dpaa2/rte_pmd_dpaa2.h
@@ -146,6 +146,65 @@ const char *
 rte_pmd_dpaa2_ep_name(uint32_t eth_id);
 __rte_experimental
 int
+rte_pmd_dpaa2_flow_table_query(uint16_t port_id);
+__rte_experimental
+int
 rte_pmd_dpaa2_rx_get_offset(uint16_t port_id, struct rte_mbuf *m,
 	uint8_t *l3_off, uint8_t *l4_off, uint8_t *l5_off);
+
+/** RTE_DPAA2_MIX_GROUP_FLOW has same behavio as RTE_DPAA2_FLAT_GROUP_FLOW*/
+enum rte_dpaa2_flow_type {
+	RTE_DPAA2_FLAT_GROUP_FLOW,
+	RTE_DPAA2_QOS_GROUP_FLOW = 1 << 0,
+	RTE_DPAA2_FS_GROUP_FLOW = 1 << 1,
+	RTE_DPAA2_MIX_GROUP_FLOW =
+		(RTE_DPAA2_QOS_GROUP_FLOW | RTE_DPAA2_FS_GROUP_FLOW)
+};
+
+#define RTE_PMD_DPAA2_FLOW_GROUP_TYPE_OFFSET 8
+#define RTE_PMD_DPAA2_FLOW_GROUP_ID_MASK \
+	((((uint32_t)1) << RTE_PMD_DPAA2_FLOW_GROUP_TYPE_OFFSET) - 1)
+
+#define RTE_DPAA2_FLOW_GROUP_TYPE_SET(group, type) \
+	((group) |= ((type) << RTE_PMD_DPAA2_FLOW_GROUP_TYPE_OFFSET))
+
+#define RTE_DPAA2_FLOW_GROUP_TYPE_GET(group) \
+	((group) >> RTE_PMD_DPAA2_FLOW_GROUP_TYPE_OFFSET)
+
+#define RTE_DPAA2_FLOW_GROUP_ID_GET(group) \
+	((group) & RTE_PMD_DPAA2_FLOW_GROUP_ID_MASK)
+
+static inline struct rte_flow *
+rte_dpaa2_flow_create(uint16_t port_id,
+	const struct rte_flow_attr *attr,
+	const struct rte_flow_item pattern[],
+	const struct rte_flow_action actions[],
+	struct rte_flow_error *error, enum rte_dpaa2_flow_type type)
+{
+	struct rte_flow_attr _attr;
+
+	rte_memcpy(&_attr, attr, sizeof(struct rte_flow_attr));
+	RTE_DPAA2_FLOW_GROUP_TYPE_SET(_attr.group, type);
+	return rte_flow_create(port_id, &_attr, pattern, actions, error);
+}
+
+static inline int
+rte_dpaa2_flow_validate(uint16_t port_id,
+	const struct rte_flow_attr *attr,
+	const struct rte_flow_item pattern[],
+	const struct rte_flow_action actions[],
+	struct rte_flow_error *error, enum rte_dpaa2_flow_type type)
+{
+	struct rte_flow_attr _attr;
+
+	rte_memcpy(&_attr, attr, sizeof(struct rte_flow_attr));
+	RTE_DPAA2_FLOW_GROUP_TYPE_SET(_attr.group, type);
+	return rte_flow_validate(port_id, &_attr, pattern, actions, error);
+}
+
+__rte_experimental
+int
+rte_dpaa2_flow_group_set_miss_actions(uint16_t port_id,
+	uint32_t group_id, uint32_t type, const struct rte_flow_group_attr *attr,
+	const struct rte_flow_action actions[], struct rte_flow_error *error);
 #endif /* _RTE_PMD_DPAA2_H */
-- 
2.43.0

