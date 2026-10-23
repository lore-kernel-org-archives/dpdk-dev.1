Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8671606A31D
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 13:46:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D53940E54;
	Fri, 23 Oct 2026 15:44:28 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 2B37C40B9E
 for <dev@dpdk.org>; Fri, 23 Oct 2026 15:44:20 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0B1CA1A0021;
 Fri, 23 Oct 2026 15:44:20 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 9AD731A000A;
 Fri, 23 Oct 2026 15:44:19 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 3F62918000B6;
 Fri, 23 Oct 2026 21:44:18 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4-S3 25/65] net/dpaa2: support rte_mtr and METER rte_flow
 action
Date: Fri, 23 Oct 2026 19:13:05 +0530
Message-ID: <20261023134346.37727-26-prashant.gupta_3@nxp.com>
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

Add a traffic metering/policing path to the DPAA2 PMD that is driven
entirely through the standard DPDK APIs: rte_mtr for profile/policy
/meter object management and rte_flow METER / METER_MARK actions for
binding a meter to a per-TC ingress flow. No DPAA2-specific or
experimental entry points are introduced.

- Add drivers/net/dpaa2/dpaa2_meter.c implementing struct rte_mtr_ops
  (capabilities_get, meter_profile_add/get/delete,
  meter_policy_add/get/delete, create, destroy,
  meter_profile_update, meter_policy_update) on top of the DPNI
  policer. Supported algorithms are RTE_MTR_NONE,
  RTE_MTR_TRTCM_RFC2698 and RTE_MTR_TRTCM_RFC4115, in both byte and
  packet mode, color-aware or blind.
- Hook dpaa2_mtr_ops_get() into dpaa2_ethdev_ops.mtr_ops_get so
  applications reach the implementation via rte_mtr_ops_get() /
  rte_mtr_*(). Register the file in drivers/net/dpaa2/meson.build.
- Extend struct dpaa2_dev_priv with LIST_HEADs for meter profiles,
  policies and meter objects, and a meter_lock spinlock to serialize
  concurrent rte_mtr calls. Add helper structs
  dpaa2_dev_meter_profile / _policy / _meter.
- Extend struct dpaa2_flow_profile with per-TC meter bookkeeping
  (tc_mtr_profile[], mtr_flow[]) and add DPAA2_FLOW_METER_TYPE to
  enum dpaa2_flow_dist_type so the flow cleaner can tear meter
  flows down together with QoS/FS/RSS flows.
- Wire the METER and METER_MARK rte_flow actions into dpaa2_flow.c:
  dpaa2_flow_validate() recognizes them, dpaa2_flow_create() routes
  such rules into a new dpaa2_flow_create_meter_flow() path, and
  dpaa2_flow_actions_update() updates the policer in place via
  dpaa2_flow_meter_action_update(). dpaa2_flow_destroy() /
  dpaa2_flow_clean() tear down meter flows and reset the TC
  policer to DPNI_POLICER_MODE_NONE.
- dpaa2_flow_set_police_action() programs the HW policer via
  dpni_set_rx_tc_policing(), honoring the profile's mode/units/
  CIR/CBS/PIR/PBS, the policy's RED action (drop vs. passthrough),
  and color_mode. Picks the v1 or v2 MC command based on the DPNI
  firmware revision, and preserves counters on update when the
  firmware supports DPNI_POLICER_OPT_DO_NOT_RESET_COUNTERS.
- Add MC-rev gates DPAA2_POLICER_SET_V2_MC_REV and
  DPAA2_POLICER_NOT_RESET_COUNTER_MC_REV so the driver falls back
  to dpni_set_rx_tc_policing_v1() on older firmware.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c |   1 +
 drivers/net/dpaa2/dpaa2_ethdev.h |  39 ++-
 drivers/net/dpaa2/dpaa2_flow.c   | 327 ++++++++++++++++-
 drivers/net/dpaa2/dpaa2_meter.c  | 584 +++++++++++++++++++++++++++++++
 drivers/net/dpaa2/meson.build    |   1 +
 5 files changed, 948 insertions(+), 4 deletions(-)
 create mode 100644 drivers/net/dpaa2/dpaa2_meter.c

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 0de8e5c627..7cd83149dd 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -3678,6 +3678,7 @@ static struct eth_dev_ops dpaa2_ethdev_ops = {
 	.rxq_info_get	      = dpaa2_rxq_info_get,
 	.txq_info_get	      = dpaa2_txq_info_get,
 	.tm_ops_get	      = dpaa2_tm_ops_get,
+	.mtr_ops_get = dpaa2_mtr_ops_get,
 	.timesync_enable      = dpaa2_timesync_enable,
 	.timesync_disable     = dpaa2_timesync_disable,
 	.timesync_read_time   = dpaa2_timesync_read_time,
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 7a65f5e383..0ad237a5cc 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -213,6 +213,8 @@
 #define DPAA2_FLOW_FRM_REPLICATION_ACTION_MC_REV RTE_FSL_MC_REV(10, 39, 106)
 #define DPAA2_QOS_FLOW_TABLE_SET_V3_MC_REV RTE_FSL_MC_REV(10, 39, 109)
 #define DPAA2_QOS_FLOW_TABLE_MISS_FLOW_ACTION_MC_REV RTE_FSL_MC_REV(10, 39, 109)
+#define DPAA2_POLICER_SET_V2_MC_REV RTE_FSL_MC_REV(10, 39, 109)
+#define DPAA2_POLICER_NOT_RESET_COUNTER_MC_REV DPAA2_POLICER_SET_V2_MC_REV
 #define DPAA2_MAC_XSTATS_MC_REV RTE_FSL_MC_REV(10, 39, 109)
 
 /* mac counters */
@@ -270,8 +272,9 @@ enum dpaa2_flow_dist_type {
 	DPAA2_FLOW_QOS_TYPE = 1 << 0,
 	DPAA2_FLOW_FS_TYPE = 1 << 1,
 	DPAA2_FLOW_RSS_TYPE = 1 << 2,
+	DPAA2_FLOW_METER_TYPE = 1 << 3,
 	DPAA2_FLOW_ALL_TYPE = (DPAA2_FLOW_QOS_TYPE | DPAA2_FLOW_FS_TYPE |
-		DPAA2_FLOW_RSS_TYPE)
+		DPAA2_FLOW_RSS_TYPE | DPAA2_FLOW_METER_TYPE)
 };
 
 enum key_prot_type {
@@ -340,6 +343,9 @@ struct dpaa2_flow_tbl_profile {
 struct dpaa2_flow_profile {
 	struct dpaa2_flow_tbl_profile qos_profile;
 	struct dpaa2_flow_tbl_profile tc_profile[MAX_TCS];
+	/** Meter per TC.*/
+	struct dpaa2_dev_meter_profile *tc_mtr_profile[MAX_TCS];
+	void *mtr_flow[MAX_TCS];
 	void *mempool[MAX_TCS];
 	uint8_t bp_idx[MAX_TCS];
 };
@@ -350,6 +356,30 @@ enum dpaa2_tx_conf_type {
 	DPAA2_TX_DYNAMIC_CONF
 };
 
+struct dpaa2_dev_meter_profile {
+	LIST_ENTRY(dpaa2_dev_meter_profile) next;
+	uint32_t profile_id;
+	uint64_t cir;
+	uint64_t cbs;
+	uint64_t pir;
+	uint64_t pbs;
+	enum dpni_policer_mode mode;
+	enum dpni_policer_unit policer_unit;
+};
+
+struct dpaa2_dev_meter_policy {
+	LIST_ENTRY(dpaa2_dev_meter_policy) next;
+	uint32_t policy_id;
+	int red_drop;
+};
+
+struct dpaa2_dev_meter {
+	LIST_ENTRY(dpaa2_dev_meter) next;
+	uint32_t meter_id;
+	uint32_t profile_id;
+	uint32_t policy_id;
+};
+
 struct dpaa2_dev_priv {
 	void *hw;
 	int32_t hw_id;
@@ -395,6 +425,8 @@ struct dpaa2_dev_priv {
 	/** RXQs in same TC share same cgid.*/
 	uint8_t cgid_in_use[MAX_TCS];
 
+	rte_spinlock_t meter_lock;
+
 	uint16_t dpni_ver_major;
 	uint16_t dpni_ver_minor;
 	uint32_t speed_capa;
@@ -443,6 +475,9 @@ struct dpaa2_dev_priv {
 	union dpni_statistics pg_xstats[DPNI_MAX_STATISTICS_PAGE_ID][DPNI_STAT_MAX_PARAM];
 
 	LIST_HEAD(, dpaa2_dev_flow) flows;
+	LIST_HEAD(, dpaa2_dev_meter_profile) profiles;
+	LIST_HEAD(, dpaa2_dev_meter_policy) policies;
+	LIST_HEAD(, dpaa2_dev_meter) meters;
 	LIST_HEAD(nodes, dpaa2_tm_node) nodes;
 	LIST_HEAD(shaper_profiles, dpaa2_tm_shaper_profile) shaper_profiles;
 };
@@ -936,4 +971,6 @@ int dpaa2_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
 
 int dpaa2_dev_recycle_config(struct rte_eth_dev *eth_dev);
 int dpaa2_dev_recycle_deconfig(struct rte_eth_dev *eth_dev);
+
+int dpaa2_mtr_ops_get(struct rte_eth_dev *dev, void *ops);
 #endif /* _DPAA2_ETHDEV_H */
diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index dc2e821d75..920e9edc51 100644
--- a/drivers/net/dpaa2/dpaa2_flow.c
+++ b/drivers/net/dpaa2/dpaa2_flow.c
@@ -67,6 +67,7 @@ struct dpaa2_dev_flow {
 	struct dpaa2_generic_flow *qos_flow;
 	struct dpaa2_generic_flow *fs_flow;
 	struct dpaa2_generic_flow *rss_flow;
+	struct dpaa2_generic_flow *meter_flow;
 };
 
 struct dpaa2_flow_item {
@@ -118,6 +119,11 @@ static const enum rte_flow_action_type dpaa2_supported_qos_action_type[] = {
 	RTE_FLOW_ACTION_TYPE_JUMP
 };
 
+static const enum rte_flow_action_type dpaa2_supported_meter_action_type[] = {
+	RTE_FLOW_ACTION_TYPE_METER_MARK,
+	RTE_FLOW_ACTION_TYPE_METER
+};
+
 #define DPAA2_FLOW_HDR_HEX_DUMP_SIZE \
 	(RTE_MAX(sizeof(struct rte_flow_item_eth), \
 	RTE_MAX(sizeof(struct rte_flow_item_vlan), \
@@ -360,6 +366,10 @@ dpaa2_flow_generic_flow(struct dpaa2_dev_flow *dev_flow,
 		(dev_flow->rss_flow->tc_id == tc_id || tc_id >= MAX_TCS)) {
 		return dev_flow->rss_flow;
 	}
+	if (type == DPAA2_FLOW_METER_TYPE && dev_flow->meter_flow &&
+		(dev_flow->meter_flow->tc_id == tc_id || tc_id >= MAX_TCS)) {
+		return dev_flow->meter_flow;
+	}
 
 	return NULL;
 }
@@ -2446,6 +2456,10 @@ dpaa2_flow_verify_flow_action(struct dpaa2_dev_priv *priv,
 			/* Skip this action, have to add for vxlan*/
 		case RTE_FLOW_ACTION_TYPE_DROP:
 			break;
+		case RTE_FLOW_ACTION_TYPE_METER_MARK:
+			break;
+		case RTE_FLOW_ACTION_TYPE_METER:
+			break;
 		case RTE_FLOW_ACTION_TYPE_END:
 			end_of_list = 1;
 			break;
@@ -2945,6 +2959,141 @@ dpaa2_flow_table_update(struct dpaa2_dev_priv *priv,
 	return ret;
 }
 
+static int
+dpaa2_flow_action_meter_mark_init(struct dpaa2_dev_priv *priv,
+	uint32_t mtr_id, struct rte_flow_action_meter_mark *meter_mark)
+{
+	struct dpaa2_dev_meter *meter;
+	struct dpaa2_dev_meter_profile *profile;
+	struct dpaa2_dev_meter_policy *policy;
+	int found = 0;
+
+	meter = LIST_FIRST(&priv->meters);
+	while (meter) {
+		if (meter->meter_id == mtr_id) {
+			found = 1;
+			break;
+		}
+		meter = LIST_NEXT(meter, next);
+	}
+
+	if (!found) {
+		DPAA2_PMD_ERR("Meter ID(%d) is not found!", mtr_id);
+		return -ENXIO;
+	}
+
+	found = 0;
+	profile = LIST_FIRST(&priv->profiles);
+	while (profile) {
+		if (profile->profile_id == meter->profile_id) {
+			found = 1;
+			break;
+		}
+		profile = LIST_NEXT(profile, next);
+	}
+	if (!found) {
+		DPAA2_PMD_ERR("Meter ID(%d)'s profile(%d) not exist!",
+			mtr_id, meter->profile_id);
+		return -ENXIO;
+	}
+
+	found = 0;
+	policy = LIST_FIRST(&priv->policies);
+	while (policy) {
+		if (policy->policy_id == meter->policy_id) {
+			found = 1;
+			break;
+		}
+		policy = LIST_NEXT(policy, next);
+	}
+	if (!found) {
+		/** Option.*/
+		DPAA2_PMD_WARN("Meter ID(%d)'s policy(%d) not exist!",
+			mtr_id, meter->policy_id);
+		policy = NULL;
+	}
+
+	meter_mark->profile = (void *)profile;
+	meter_mark->policy = (void *)policy;
+	meter_mark->color_mode = 1;
+
+	return 0;
+}
+
+static int
+dpaa2_flow_set_police_action(struct dpaa2_dev_priv *priv,
+	uint8_t tc_id, const struct rte_flow_action_meter_mark *meter_mark)
+{
+	struct dpni_rx_tc_policing_cfg policing_cfg = {0};
+	const struct dpaa2_dev_meter_profile *dpaa2_profile;
+	const struct dpaa2_dev_meter_policy *dpaa2_policy = NULL;
+	int ret;
+
+	if (!(priv->options & DPNI_OPT_HAS_POLICING)) {
+		DPAA2_PMD_ERR("POLICING(0x%08x) was not added in DPNI creating options(0x%08x)",
+			DPNI_OPT_HAS_POLICING, priv->options);
+		return -ENOTSUP;
+	}
+
+	dpaa2_profile = (void *)meter_mark->profile;
+	if (!dpaa2_profile) {
+		DPAA2_PMD_ERR("Meter profile not specified!");
+		return -EINVAL;
+	}
+
+	/** Blind as default.*/
+	policing_cfg.options = 0;
+	if (meter_mark->color_mode)
+		policing_cfg.options = DPNI_POLICER_OPT_COLOR_AWARE;
+	if (meter_mark->policy)
+		dpaa2_policy = (void *)meter_mark->policy;
+	if (dpaa2_policy && dpaa2_policy->red_drop) {
+		policing_cfg.options |= DPNI_POLICER_OPT_DISCARD_RED;
+	} else if (!dpaa2_policy) {
+		/** Default: Red is discarded if no policy specified.*/
+		policing_cfg.options |= DPNI_POLICER_OPT_DISCARD_RED;
+	}
+
+	if (priv->flow_profile.mtr_flow[tc_id]) {
+		/** Update existing policer.*/
+		policing_cfg.options |= DPNI_POLICER_OPT_DO_NOT_RESET_COUNTERS;
+		if (priv->mc_rev < DPAA2_POLICER_NOT_RESET_COUNTER_MC_REV)
+			DPAA2_PMD_WARN("The existing policer's counters will be cleaned.");
+	}
+
+	policing_cfg.mode = dpaa2_profile->mode;
+	if (policing_cfg.mode < DPNI_POLICER_MODE_NONE ||
+		policing_cfg.mode > DPNI_POLICER_MODE_RFC_4115) {
+		DPAA2_PMD_ERR("Invalid policer mode(%d)",
+			policing_cfg.mode);
+		return -EINVAL;
+	}
+	policing_cfg.units = dpaa2_profile->policer_unit;
+	if (policing_cfg.units < DPNI_POLICER_UNIT_BYTES_L3 ||
+		policing_cfg.units > DPNI_POLICER_UNIT_BYTES_L2_WITHOUT_FCS) {
+		DPAA2_PMD_ERR("Invalid policer units(%d)",
+			policing_cfg.units);
+		return -EINVAL;
+	}
+	policing_cfg.cir = dpaa2_profile->cir;
+	policing_cfg.cbs = dpaa2_profile->cbs;
+	policing_cfg.eir = dpaa2_profile->pir;
+	policing_cfg.ebs = dpaa2_profile->pbs;
+
+	if (priv->mc_rev < DPAA2_POLICER_SET_V2_MC_REV) {
+		ret = dpni_set_rx_tc_policing_v1(priv->hw, CMD_PRI_LOW,
+			priv->token, tc_id, &policing_cfg);
+	} else {
+		ret = dpni_set_rx_tc_policing(priv->hw, CMD_PRI_LOW,
+			priv->token, tc_id, &policing_cfg);
+	}
+	DPAA2_PMD_INFO("%s RX TC%d policer configure %s.",
+		priv->eth_dev->data->name, tc_id,
+		ret ? "failed" : "successfully");
+
+	return ret;
+}
+
 static int
 dpaa2_flow_steering_action_convert(struct dpaa2_generic_flow *flow,
 	const struct rte_flow_action actions[])
@@ -3233,15 +3382,25 @@ dpaa2_flow_validate(struct rte_eth_dev *dev,
 		goto invalid_params;
 	}
 
+	action_num = dpaa2_flow_check_actions_support(actions,
+		dpaa2_supported_meter_action_type,
+		RTE_DIM(dpaa2_supported_meter_action_type), NULL);
+	if (action_num) {
+		DPAA2_PMD_DEBUG("This is meter flow.");
+		if (pattern)
+			DPAA2_PMD_WARN("Meter flow ingores flow items!");
+		goto meter_rss_check;
+	}
+
 	supported = RTE_FLOW_ACTION_TYPE_RSS;
 	action_num = dpaa2_flow_check_actions_support(actions, &supported, 1, NULL);
 	if (action_num) {
 		DPAA2_PMD_DEBUG("This is rss flow.");
-		goto rss_check;
+		goto meter_rss_check;
 	}
 	goto verify_attr;
 
-rss_check:
+meter_rss_check:
 	if (action_num > 1) {
 		err_str = "Multiple flow's action.";
 		cause = actions;
@@ -3716,6 +3875,39 @@ dpaa2_flow_destroy_steering_flow(struct rte_eth_dev *dev,
 	return ret;
 }
 
+static int
+dpaa2_flow_destroy_meter_flow(struct rte_eth_dev *dev,
+	struct dpaa2_generic_flow *meter_flow)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpni_rx_tc_policing_cfg cfg;
+	int ret;
+	uint8_t tc_id;
+
+	if (!meter_flow)
+		return 0;
+
+	tc_id = meter_flow->tc_id;
+	RTE_ASSERT(priv->flow_profile.mtr_flow[tc_id] == meter_flow);
+	memset(&cfg, 0, sizeof(cfg));
+	cfg.mode = DPNI_POLICER_MODE_NONE;
+	if (priv->mc_rev < DPAA2_POLICER_SET_V2_MC_REV) {
+		ret = dpni_set_rx_tc_policing_v1(priv->hw, CMD_PRI_LOW,
+			priv->token, tc_id, &cfg);
+	} else {
+		ret = dpni_set_rx_tc_policing(priv->hw, CMD_PRI_LOW,
+			priv->token, tc_id, &cfg);
+	}
+	if (ret)
+		return ret;
+	priv->flow_profile.tc_mtr_profile[tc_id] = NULL;
+	priv->flow_profile.mtr_flow[tc_id] = NULL;
+
+	dpaa2_flow_generic_flow_deinit(meter_flow);
+
+	return 0;
+}
+
 static int
 dpaa2_flow_destroy_rss_flow(struct rte_eth_dev *dev,
 	struct dpaa2_generic_flow *flow)
@@ -3835,7 +4027,7 @@ dpaa2_flow_create_rss_flow(struct rte_eth_dev *dev,
 	if (ret)
 		return NULL;
 
-	dpaa2_flow_clean(dev, tc, DPAA2_FLOW_FS_TYPE);
+	dpaa2_flow_clean(dev, tc, DPAA2_FLOW_FS_TYPE | DPAA2_FLOW_METER_TYPE);
 
 	flow = dpaa2_flow_generic_flow_init(priv, 0, true,
 		DPAA2_FLOW_RSS_TYPE, tc);
@@ -3855,6 +4047,68 @@ dpaa2_flow_create_rss_flow(struct rte_eth_dev *dev,
 	return NULL;
 }
 
+static int
+dpaa2_flow_set_meter_action(struct dpaa2_dev_priv *priv,
+	uint8_t tc, const struct rte_flow_action *meter_action,
+	struct rte_flow_action_meter_mark *meter_mark)
+{
+	const struct rte_flow_action_meter *meter;
+	int ret;
+
+	if (meter_action[0].type == RTE_FLOW_ACTION_TYPE_METER_MARK) {
+		rte_memcpy(meter_mark, meter_action->conf,
+			sizeof(struct rte_flow_action_meter_mark));
+	} else if (meter_action->type == RTE_FLOW_ACTION_TYPE_METER_MARK) {
+		meter = meter_action->conf;
+		ret = dpaa2_flow_action_meter_mark_init(priv, meter->mtr_id, meter_mark);
+		if (ret)
+			return ret;
+	} else {
+		return -EINVAL;
+	}
+	ret = dpaa2_flow_set_police_action(priv, tc, meter_mark);
+
+	return ret;
+}
+
+static struct dpaa2_generic_flow *
+dpaa2_flow_create_meter_flow(struct rte_eth_dev *dev,
+	const struct rte_flow_attr *attr,
+	const struct rte_flow_action meter_action[])
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_generic_flow *flow = NULL;
+	struct rte_flow_action_meter_mark meter_mark;
+	int ret;
+	uint8_t tc;
+
+	if (attr->group >= priv->num_rx_tc)
+		return NULL;
+
+	if (priv->flow_profile.mtr_flow[attr->group])
+		return NULL;
+
+	flow = dpaa2_flow_generic_flow_init(priv, 0, true,
+		DPAA2_FLOW_METER_TYPE, attr->group);
+	if (!flow)
+		return NULL;
+
+	tc = attr->group;
+	ret = dpaa2_flow_set_meter_action(priv, tc, meter_action, &meter_mark);
+	if (ret)
+		goto create_failure;
+
+	priv->flow_profile.tc_mtr_profile[tc] = (void *)meter_mark.profile;
+	priv->flow_profile.mtr_flow[tc] = flow;
+
+	return flow;
+create_failure:
+
+	dpaa2_flow_generic_flow_deinit(flow);
+
+	return NULL;
+}
+
 static struct rte_flow *
 dpaa2_flow_create(struct rte_eth_dev *dev,
 	const struct rte_flow_attr *pattr,
@@ -3873,6 +4127,7 @@ dpaa2_flow_create(struct rte_eth_dev *dev,
 	struct dpaa2_generic_flow *rss_flow = NULL;
 	struct dpaa2_generic_flow *qos_flow = NULL;
 	struct dpaa2_generic_flow *fs_flow = NULL;
+	struct dpaa2_generic_flow *meter_flow = NULL;
 	enum rte_flow_error_type error_type = RTE_FLOW_ERROR_TYPE_NONE;
 	const char *err_str = NULL;
 
@@ -3904,6 +4159,20 @@ dpaa2_flow_create(struct rte_eth_dev *dev,
 		goto insert_flow;
 	}
 
+	if (dpaa2_flow_check_actions_support(actions,
+		dpaa2_supported_meter_action_type,
+		RTE_DIM(dpaa2_supported_meter_action_type), NULL)) {
+		meter_flow = dpaa2_flow_create_meter_flow(dev, &attr, actions);
+		if (!meter_flow) {
+			error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+			err_code = -EINVAL;
+			err_str = "Failed to create meter flow!";
+			goto flow_failure;
+		}
+		flow->meter_flow = meter_flow;
+		goto insert_flow;
+	}
+
 	if (dpaa2_flow_is_qos_flow_only(priv, attr.group) ||
 		(actions && actions[0].type == RTE_FLOW_ACTION_TYPE_JUMP &&
 		actions[1].type == RTE_FLOW_ACTION_TYPE_END)) {
@@ -3988,6 +4257,9 @@ dpaa2_flow_create(struct rte_eth_dev *dev,
 	ret = dpaa2_flow_destroy_rss_flow(dev, flow->rss_flow);
 	if (ret)
 		DPAA2_PMD_ERR("%s: Failed(%d) to destroy RSS flow", __func__, ret);
+	ret = dpaa2_flow_destroy_meter_flow(dev, flow->meter_flow);
+	if (ret)
+		DPAA2_PMD_ERR("%s: Failed(%d) to destroy meter flow", __func__, ret);
 
 	rte_free(flow);
 
@@ -4010,6 +4282,7 @@ dpaa2_flow_destroy(struct rte_eth_dev *dev,
 
 	flow = (struct dpaa2_dev_flow *)_flow;
 	LIST_REMOVE(flow, next);
+	ret |= dpaa2_flow_destroy_meter_flow(dev, flow->meter_flow);
 	ret |= dpaa2_flow_destroy_rss_flow(dev, flow->rss_flow);
 	ret |= dpaa2_flow_destroy_steering_flow(dev, flow->qos_flow);
 	ret |= dpaa2_flow_destroy_steering_flow(dev, flow->fs_flow);
@@ -4148,6 +4421,38 @@ dpaa2_flow_set_miss_actions(struct rte_eth_dev *dev,
 	return err_code;
 }
 
+static int
+dpaa2_flow_meter_action_update(struct rte_eth_dev *dev,
+	struct dpaa2_generic_flow *flow,
+	const struct rte_flow_action actions[],
+	struct rte_flow_error *error)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	int err_code = 0;
+	uint8_t tc_id;
+	struct rte_flow_action_meter_mark meter_mark;
+	enum rte_flow_error_type error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+	const char *err_str = NULL;
+
+	/* check for the valid flow */
+	tc_id = flow->tc_id;
+	if (priv->flow_profile.mtr_flow[tc_id] != flow) {
+		err_str = "The meter flow to update doesn't match!";
+		err_code = -EINVAL;
+		goto quit;
+	}
+	err_code = dpaa2_flow_set_meter_action(priv, tc_id, actions, &meter_mark);
+	if (err_code)
+		err_str = "Failed to update meter action!";
+	else
+		priv->flow_profile.tc_mtr_profile[tc_id] = (void *)meter_mark.profile;
+
+quit:
+	if (err_str)
+		DPAA2_PMD_ERR("%s: %s", __func__, err_str);
+	return rte_flow_error_set(error, -err_code, error_type, NULL, err_str);
+}
+
 static int
 dpaa2_flow_steering_flow_action_update(struct rte_eth_dev *dev,
 	struct dpaa2_generic_flow *flow,
@@ -4218,6 +4523,20 @@ dpaa2_flow_actions_update(struct rte_eth_dev *dev,
 	/* check for the valid flow */
 	flow = (void *)_flow;
 
+	update_num = dpaa2_flow_check_actions_support(actions,
+		dpaa2_supported_meter_action_type,
+		RTE_DIM(dpaa2_supported_meter_action_type),
+		actions_update);
+	if (flow->meter_flow && update_num) {
+		err_code = dpaa2_flow_meter_action_update(dev,
+			flow->meter_flow, actions_update, error);
+		if (err_code) {
+			error_type = RTE_FLOW_ERROR_TYPE_ACTION;
+			err_str = "Failed to update meter action!";
+			goto quit;
+		}
+	}
+
 	supported = RTE_FLOW_ACTION_TYPE_RSS;
 	update_num = dpaa2_flow_check_actions_support(actions,
 		&supported, 1, actions_update);
@@ -4591,6 +4910,8 @@ dpaa2_flow_clean(struct rte_eth_dev *dev, uint8_t tc_id,
 		if (((type & DPAA2_FLOW_QOS_TYPE) && flow->qos_flow) ||
 			((type & DPAA2_FLOW_FS_TYPE) && flow->fs_flow &&
 			flow->fs_flow->tc_id == tc_id) ||
+			((type & DPAA2_FLOW_METER_TYPE) && flow->meter_flow &&
+			flow->meter_flow->tc_id == tc_id) ||
 			((type & DPAA2_FLOW_RSS_TYPE) && flow->rss_flow &&
 			flow->rss_flow->tc_id == tc_id)) {
 			ret = dpaa2_flow_destroy(dev, (struct rte_flow *)flow, NULL);
diff --git a/drivers/net/dpaa2/dpaa2_meter.c b/drivers/net/dpaa2/dpaa2_meter.c
new file mode 100644
index 0000000000..463cc2156e
--- /dev/null
+++ b/drivers/net/dpaa2/dpaa2_meter.c
@@ -0,0 +1,584 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2026 NXP
+ */
+
+#include <sys/queue.h>
+#include <stdio.h>
+#include <errno.h>
+#include <stdint.h>
+#include <string.h>
+#include <unistd.h>
+#include <stdarg.h>
+#include <sys/mman.h>
+
+#include <rte_ethdev.h>
+#include <rte_log.h>
+#include <rte_malloc.h>
+#include <rte_flow_driver.h>
+#include <rte_tailq.h>
+#include <rte_mtr.h>
+#include <rte_mtr_driver.h>
+
+#include <fsl_dpni.h>
+#include <fsl_dpkg.h>
+
+#include <dpaa2_ethdev.h>
+#include <dpaa2_pmd_logs.h>
+
+#define DPAA2_METER_ERR_MSG_LEN 128
+static char s_err_msg[DPAA2_METER_ERR_MSG_LEN];
+
+static void __rte_format_printf(1, 2)
+dpaa2_meter_err_msg(const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	vsnprintf(s_err_msg, DPAA2_METER_ERR_MSG_LEN, fmt, ap);
+	va_end(ap);
+}
+
+static struct rte_mtr_capabilities s_dpaa2_mtr_capa = {
+	.color_aware_trtcm_rfc2698_supported = true,
+	.color_aware_trtcm_rfc4115_supported = true,
+	.trtcm_rfc2698_byte_mode_supported = true,
+	.trtcm_rfc2698_packet_mode_supported = true,
+	.trtcm_rfc4115_byte_mode_supported = true,
+	.trtcm_rfc4115_packet_mode_supported = true
+};
+
+static int
+dpaa2_mtr_capabilities_get(struct rte_eth_dev *dev,
+	struct rte_mtr_capabilities *capa,
+	struct rte_mtr_error *error)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+
+	if (!capa) {
+		return -rte_mtr_error_set(error, EINVAL,
+				RTE_MTR_ERROR_TYPE_MTR_PARAMS, NULL,
+				"NULL input parameter\n");
+	}
+
+	rte_spinlock_lock(&priv->meter_lock);
+	s_dpaa2_mtr_capa.n_max = priv->num_rx_tc;
+	s_dpaa2_mtr_capa.n_shared_max = priv->num_rx_tc;
+	s_dpaa2_mtr_capa.meter_trtcm_rfc2698_n_max = priv->num_rx_tc;
+	s_dpaa2_mtr_capa.meter_trtcm_rfc4115_n_max = priv->num_rx_tc;
+	s_dpaa2_mtr_capa.meter_policy_n_max = priv->num_rx_tc;
+	s_dpaa2_mtr_capa.shared_n_flows_per_mtr_max = priv->fs_entries;
+	rte_spinlock_unlock(&priv->meter_lock);
+
+	*capa = s_dpaa2_mtr_capa;
+
+	return 0;
+}
+
+static int
+dpaa2_mtr_profile_add(struct rte_eth_dev *dev,
+	uint32_t profile_id, struct rte_mtr_meter_profile *profile,
+	struct rte_mtr_error *error)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_meter_profile *dpaa2_profile;
+	struct dpaa2_dev_meter_profile *curr;
+	int ret = 0;
+
+	dpaa2_profile = rte_zmalloc(NULL,
+		sizeof(struct dpaa2_dev_meter_profile), 0);
+	if (!dpaa2_profile) {
+		return -rte_mtr_error_set(error, ENOMEM,
+				RTE_MTR_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Meter profile memory alloc failed!\n");
+	}
+	if (profile->alg == RTE_MTR_NONE) {
+		dpaa2_profile->mode = DPNI_POLICER_MODE_PASS_THROUGH;
+	} else if (profile->alg == RTE_MTR_TRTCM_RFC2698) {
+		dpaa2_profile->mode = DPNI_POLICER_MODE_RFC_2698;
+	} else if (profile->alg == RTE_MTR_TRTCM_RFC4115) {
+		dpaa2_profile->mode = DPNI_POLICER_MODE_RFC_4115;
+	} else {
+		DPAA2_PMD_ERR("Policer profile alg(%d) not supported!",
+			profile->alg);
+		ret = -ENOTSUP;
+		goto err;
+	}
+
+	if (profile->alg == RTE_MTR_TRTCM_RFC2698) {
+		dpaa2_profile->cir = profile->trtcm_rfc2698.cir;
+		dpaa2_profile->cbs = profile->trtcm_rfc2698.cbs;
+		dpaa2_profile->pir = profile->trtcm_rfc2698.pir;
+		dpaa2_profile->pbs = profile->trtcm_rfc2698.pbs;
+	} else if (profile->alg == RTE_MTR_TRTCM_RFC4115) {
+		dpaa2_profile->cir = profile->trtcm_rfc4115.cir;
+		dpaa2_profile->cbs = profile->trtcm_rfc4115.cbs;
+		dpaa2_profile->pir = profile->trtcm_rfc4115.eir;
+		dpaa2_profile->pbs = profile->trtcm_rfc4115.ebs;
+	}
+
+	/** Align with DPNI policy.*/
+	if (!profile->packet_mode)
+		dpaa2_profile->policer_unit = DPNI_POLICER_UNIT_BYTES_L3;
+	else if (profile->packet_mode > DPNI_POLICER_UNIT_FRAMES)
+		dpaa2_profile->policer_unit = DPNI_POLICER_UNIT_BYTES_L2_WITHOUT_FCS;
+	else
+		dpaa2_profile->policer_unit = DPNI_POLICER_UNIT_FRAMES;
+
+	dpaa2_profile->profile_id = profile_id;
+
+	rte_spinlock_lock(&priv->meter_lock);
+	curr = LIST_FIRST(&priv->profiles);
+	if (!curr) {
+		LIST_INSERT_HEAD(&priv->profiles, dpaa2_profile, next);
+	} else {
+		while (LIST_NEXT(curr, next))
+			curr = LIST_NEXT(curr, next);
+		LIST_INSERT_AFTER(curr, dpaa2_profile, next);
+	}
+	rte_spinlock_unlock(&priv->meter_lock);
+
+err:
+	if (ret)
+		rte_free(dpaa2_profile);
+
+	return ret;
+}
+
+static int
+dpaa2_mtr_policy_add(struct rte_eth_dev *dev,
+	uint32_t policy_id, struct rte_mtr_meter_policy_params *policy,
+	struct rte_mtr_error *error)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_meter_policy *dpaa2_policy;
+	struct dpaa2_dev_meter_policy *curr;
+	const struct rte_flow_action *red_action;
+	int red_drop = 0;
+
+	if (policy->actions[RTE_COLOR_GREEN]) {
+		return -rte_mtr_error_set(error, ENOMEM,
+				RTE_MTR_ERROR_TYPE_POLICER_ACTION_GREEN, NULL,
+				"Meter green policy action not supported!\n");
+	}
+	if (policy->actions[RTE_COLOR_YELLOW]) {
+		return -rte_mtr_error_set(error, ENOMEM,
+				RTE_MTR_ERROR_TYPE_POLICER_ACTION_YELLOW, NULL,
+				"Meter yellow policy action not supported!\n");
+	}
+
+	red_action = policy->actions[RTE_COLOR_RED];
+
+	if (red_action) {
+		if (red_action->type == RTE_FLOW_ACTION_TYPE_DROP) {
+			red_drop = 1;
+		} else if (red_action->type != RTE_FLOW_ACTION_TYPE_PASSTHRU) {
+			dpaa2_meter_err_msg("Meter red policy action(%d) NOT supported!\n",
+				red_action->type);
+			return -rte_mtr_error_set(error, ENOMEM,
+				RTE_MTR_ERROR_TYPE_POLICER_ACTION_RED, NULL,
+				s_err_msg);
+		}
+	}
+
+	dpaa2_policy = rte_zmalloc(NULL,
+		sizeof(struct dpaa2_dev_meter_policy), 0);
+	if (!dpaa2_policy) {
+		return -rte_mtr_error_set(error, ENOMEM,
+				RTE_MTR_ERROR_TYPE_UNSPECIFIED, NULL,
+				"Meter profile memory alloc failed!\n");
+	}
+
+	dpaa2_policy->policy_id = policy_id;
+	dpaa2_policy->red_drop = red_drop;
+
+	rte_spinlock_lock(&priv->meter_lock);
+	curr = LIST_FIRST(&priv->policies);
+	if (!curr) {
+		LIST_INSERT_HEAD(&priv->policies, dpaa2_policy, next);
+	} else {
+		while (LIST_NEXT(curr, next))
+			curr = LIST_NEXT(curr, next);
+		LIST_INSERT_AFTER(curr, dpaa2_policy, next);
+	}
+	rte_spinlock_unlock(&priv->meter_lock);
+
+	return 0;
+}
+
+static struct rte_flow_meter_profile *
+dpaa2_mtr_profile_get(struct rte_eth_dev *dev,
+	uint32_t meter_profile_id, struct rte_mtr_error *error)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_meter_profile *dpaa2_profile;
+
+	RTE_SET_USED(error);
+
+	rte_spinlock_lock(&priv->meter_lock);
+	dpaa2_profile = LIST_FIRST(&priv->profiles);
+	while (dpaa2_profile) {
+		if (dpaa2_profile->profile_id == meter_profile_id) {
+			rte_spinlock_unlock(&priv->meter_lock);
+			return (struct rte_flow_meter_profile *)dpaa2_profile;
+		}
+		dpaa2_profile = LIST_NEXT(dpaa2_profile, next);
+	}
+	rte_spinlock_unlock(&priv->meter_lock);
+
+	return NULL;
+}
+
+static struct rte_flow_meter_policy *
+dpaa2_mtr_policy_get(struct rte_eth_dev *dev,
+	uint32_t policy_id, struct rte_mtr_error *error)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_meter_policy *dpaa2_policy;
+
+	RTE_SET_USED(error);
+
+	rte_spinlock_lock(&priv->meter_lock);
+	dpaa2_policy = LIST_FIRST(&priv->policies);
+	while (dpaa2_policy) {
+		if (dpaa2_policy->policy_id == policy_id) {
+			rte_spinlock_unlock(&priv->meter_lock);
+			return (struct rte_flow_meter_policy *)dpaa2_policy;
+		}
+		dpaa2_policy = LIST_NEXT(dpaa2_policy, next);
+	}
+	rte_spinlock_unlock(&priv->meter_lock);
+
+	return NULL;
+}
+
+static int
+dpaa2_mtr_profile_delete(struct rte_eth_dev *dev,
+	uint32_t profile_id, struct rte_mtr_error *error)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_meter_profile *dpaa2_profile = NULL, *curr;
+	struct dpaa2_dev_meter *meter, *tmp;
+
+	rte_spinlock_lock(&priv->meter_lock);
+	curr = LIST_FIRST(&priv->profiles);
+	while (curr) {
+		if (curr->profile_id == profile_id) {
+			dpaa2_profile = curr;
+			break;
+		}
+		curr = LIST_NEXT(curr, next);
+	}
+	if (!dpaa2_profile) {
+		rte_spinlock_unlock(&priv->meter_lock);
+		return -rte_mtr_error_set(error, ENOENT,
+			RTE_MTR_ERROR_TYPE_METER_PROFILE_ID,
+			&profile_id, "Meter profile is invalid.");
+	}
+
+	meter = LIST_FIRST(&priv->meters);
+	while (meter) {
+		if (meter->profile_id == profile_id) {
+			DPAA2_PMD_INFO("Meter(id=%d) with profile(%d) is removed!",
+				meter->meter_id, profile_id);
+			tmp = meter;
+			meter = LIST_NEXT(meter, next);
+			LIST_REMOVE(tmp, next);
+			rte_free(tmp);
+		} else {
+			meter = LIST_NEXT(meter, next);
+		}
+	}
+
+	LIST_REMOVE(dpaa2_profile, next);
+	rte_free(dpaa2_profile);
+	rte_spinlock_unlock(&priv->meter_lock);
+
+	return 0;
+}
+
+static int
+dpaa2_mtr_policy_delete(struct rte_eth_dev *dev,
+	uint32_t policy_id, struct rte_mtr_error *error)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_meter_policy *dpaa2_policy = NULL, *curr;
+	struct dpaa2_dev_meter *meter, *tmp;
+
+	rte_spinlock_lock(&priv->meter_lock);
+	curr = LIST_FIRST(&priv->policies);
+	while (curr) {
+		if (curr->policy_id == policy_id) {
+			dpaa2_policy = curr;
+			break;
+		}
+		curr = LIST_NEXT(curr, next);
+	}
+	if (!dpaa2_policy) {
+		rte_spinlock_unlock(&priv->meter_lock);
+		return -rte_mtr_error_set(error, ENOENT,
+			RTE_MTR_ERROR_TYPE_METER_POLICY_ID,
+			NULL, "Meter policy is invalid.\n");
+	}
+
+	meter = LIST_FIRST(&priv->meters);
+	while (meter) {
+		if (meter->policy_id == policy_id) {
+			DPAA2_PMD_INFO("Meter(id=%d) with policy(%d) is removed!",
+				meter->meter_id, policy_id);
+			tmp = meter;
+			meter = LIST_NEXT(meter, next);
+			LIST_REMOVE(tmp, next);
+			rte_free(tmp);
+		} else {
+			meter = LIST_NEXT(meter, next);
+		}
+	}
+
+	LIST_REMOVE(dpaa2_policy, next);
+	rte_free(dpaa2_policy);
+	rte_spinlock_unlock(&priv->meter_lock);
+
+	return 0;
+}
+
+static int
+dpaa2_mtr_meter_create(struct rte_eth_dev *dev,
+	uint32_t mtr_id, struct rte_mtr_params *params,
+	int shared, struct rte_mtr_error *error)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_meter_profile *profile;
+	struct dpaa2_dev_meter_policy *policy;
+	struct dpaa2_dev_meter *meter, *curr;
+	uint32_t profile_id, policy_id;
+	int found = 0, ret = 0;
+	enum rte_mtr_error_type err_type = RTE_MTR_ERROR_TYPE_NONE;
+
+	RTE_SET_USED(shared);
+	profile_id = params->meter_profile_id;
+	policy_id = params->meter_policy_id;
+
+	rte_spinlock_lock(&priv->meter_lock);
+	profile = LIST_FIRST(&priv->profiles);
+	while (profile) {
+		if (profile->profile_id == profile_id) {
+			found = 1;
+			break;
+		}
+		profile = LIST_NEXT(profile, next);
+	}
+	if (!found) {
+		dpaa2_meter_err_msg("Meter profile ID(%d) not exist!\n", profile_id);
+		ret = ENOENT;
+		err_type = RTE_MTR_ERROR_TYPE_METER_PROFILE_ID;
+		goto quit;
+	}
+
+	found = 0;
+	policy = LIST_FIRST(&priv->policies);
+	while (policy) {
+		if (policy->policy_id == policy_id) {
+			found = 1;
+			break;
+		}
+		policy = LIST_NEXT(policy, next);
+	}
+	if (!found) {
+		dpaa2_meter_err_msg("Meter policy ID(%d) not exist!\n", policy_id);
+		ret = ENOENT;
+		err_type = RTE_MTR_ERROR_TYPE_METER_POLICY_ID;
+		goto quit;
+	}
+
+	meter = LIST_FIRST(&priv->meters);
+	while (meter) {
+		if (meter->meter_id == mtr_id) {
+			dpaa2_meter_err_msg("Meter ID(%d) exist!\n", mtr_id);
+			ret = EEXIST;
+			err_type = RTE_MTR_ERROR_TYPE_MTR_ID;
+			goto quit;
+		} else {
+			meter = LIST_NEXT(meter, next);
+		}
+	}
+	meter = rte_zmalloc(NULL, sizeof(struct dpaa2_dev_meter), 0);
+	if (!meter) {
+		dpaa2_meter_err_msg("Meter memory alloc failed!\n");
+		ret = ENOMEM;
+		err_type = RTE_MTR_ERROR_TYPE_UNSPECIFIED;
+		goto quit;
+	}
+	meter->meter_id = mtr_id;
+	meter->profile_id = profile_id;
+	meter->policy_id = policy_id;
+
+	curr = LIST_FIRST(&priv->meters);
+	if (!curr) {
+		LIST_INSERT_HEAD(&priv->meters, meter, next);
+	} else {
+		while (LIST_NEXT(curr, next))
+			curr = LIST_NEXT(curr, next);
+		LIST_INSERT_AFTER(curr, meter, next);
+	}
+
+quit:
+	rte_spinlock_unlock(&priv->meter_lock);
+	if (ret)
+		return -rte_mtr_error_set(error, ret, err_type, NULL, s_err_msg);
+
+	return 0;
+}
+
+static int
+dpaa2_mtr_meter_destroy(struct rte_eth_dev *dev,
+	uint32_t mtr_id, struct rte_mtr_error *error)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_meter *meter;
+
+	rte_spinlock_lock(&priv->meter_lock);
+	meter = LIST_FIRST(&priv->meters);
+	while (meter) {
+		if (meter->meter_id == mtr_id) {
+			LIST_REMOVE(meter, next);
+			rte_free(meter);
+			rte_spinlock_unlock(&priv->meter_lock);
+
+			return 0;
+		}
+		meter = LIST_NEXT(meter, next);
+	}
+	dpaa2_meter_err_msg("Meter ID(%d) does not exist!\n", mtr_id);
+	rte_spinlock_unlock(&priv->meter_lock);
+	return -rte_mtr_error_set(error, ENOENT,
+		RTE_MTR_ERROR_TYPE_MTR_ID, NULL, s_err_msg);
+}
+
+static int
+dpaa2_mtr_meter_profile_update(struct rte_eth_dev *dev,
+	uint32_t mtr_id, uint32_t profile_id,
+	struct rte_mtr_error *error)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_meter_profile *profile;
+	struct dpaa2_dev_meter *meter;
+	int found = 0, ret = 0;
+	enum rte_mtr_error_type err_type = RTE_MTR_ERROR_TYPE_NONE;
+
+	rte_spinlock_lock(&priv->meter_lock);
+	meter = LIST_FIRST(&priv->meters);
+	while (meter) {
+		if (meter->meter_id == mtr_id) {
+			found = 1;
+			break;
+		}
+		meter = LIST_NEXT(meter, next);
+	}
+	if (!found) {
+		dpaa2_meter_err_msg("Meter ID(%d) not found!\n", mtr_id);
+		ret = ENOENT;
+		err_type = RTE_MTR_ERROR_TYPE_MTR_ID;
+		goto quit;
+	}
+
+	found = 0;
+	profile = LIST_FIRST(&priv->profiles);
+	while (profile) {
+		if (profile->profile_id == profile_id) {
+			found = 1;
+			break;
+		}
+		profile = LIST_NEXT(profile, next);
+	}
+	if (!found) {
+		dpaa2_meter_err_msg("Profile ID(%d) not found!\n", profile_id);
+		ret = ENOENT;
+		err_type = RTE_MTR_ERROR_TYPE_METER_PROFILE_ID;
+		goto quit;
+	}
+	meter->profile_id = profile_id;
+
+quit:
+	rte_spinlock_unlock(&priv->meter_lock);
+	if (ret)
+		return -rte_mtr_error_set(error, ret, err_type, NULL, s_err_msg);
+
+	return 0;
+}
+
+static int
+dpaa2_mtr_meter_policy_update(struct rte_eth_dev *dev,
+	uint32_t mtr_id, uint32_t policy_id,
+	struct rte_mtr_error *error)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	struct dpaa2_dev_meter_policy *policy;
+	struct dpaa2_dev_meter *meter;
+	int found = 0, ret = 0;
+	enum rte_mtr_error_type err_type = RTE_MTR_ERROR_TYPE_NONE;
+
+	rte_spinlock_lock(&priv->meter_lock);
+	meter = LIST_FIRST(&priv->meters);
+	while (meter) {
+		if (meter->meter_id == mtr_id) {
+			found = 1;
+			break;
+		}
+		meter = LIST_NEXT(meter, next);
+	}
+	if (!found) {
+		dpaa2_meter_err_msg("Meter ID(%d) not found!\n", mtr_id);
+		ret = ENOENT;
+		err_type = RTE_MTR_ERROR_TYPE_MTR_ID;
+		goto quit;
+	}
+
+	found = 0;
+	policy = LIST_FIRST(&priv->policies);
+	while (policy) {
+		if (policy->policy_id == policy_id) {
+			found = 1;
+			break;
+		}
+		policy = LIST_NEXT(policy, next);
+	}
+	if (!found) {
+		dpaa2_meter_err_msg("Profile ID(%d) not found!\n", policy_id);
+		ret = ENOENT;
+		err_type = RTE_MTR_ERROR_TYPE_METER_POLICY_ID;
+		goto quit;
+	}
+	meter->policy_id = policy_id;
+
+quit:
+	rte_spinlock_unlock(&priv->meter_lock);
+	if (ret)
+		return -rte_mtr_error_set(error, ret, err_type, NULL, s_err_msg);
+
+	return 0;
+}
+
+static const struct rte_mtr_ops dpaa2_meter_ops = {
+	.capabilities_get = dpaa2_mtr_capabilities_get,
+	.meter_profile_add = dpaa2_mtr_profile_add,
+	.meter_profile_delete = dpaa2_mtr_profile_delete,
+	.meter_policy_add = dpaa2_mtr_policy_add,
+	.meter_policy_delete = dpaa2_mtr_policy_delete,
+	.meter_profile_get = dpaa2_mtr_profile_get,
+	.meter_policy_get = dpaa2_mtr_policy_get,
+	.create = dpaa2_mtr_meter_create,
+	.destroy = dpaa2_mtr_meter_destroy,
+	.meter_profile_update = dpaa2_mtr_meter_profile_update,
+	.meter_policy_update = dpaa2_mtr_meter_policy_update,
+};
+
+int
+dpaa2_mtr_ops_get(struct rte_eth_dev *dev, void *ops)
+{
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+
+	rte_spinlock_init(&priv->meter_lock);
+
+	*(const void **)ops = &dpaa2_meter_ops;
+	return 0;
+}
diff --git a/drivers/net/dpaa2/meson.build b/drivers/net/dpaa2/meson.build
index affcaf8d3a..b5bff519af 100644
--- a/drivers/net/dpaa2/meson.build
+++ b/drivers/net/dpaa2/meson.build
@@ -16,6 +16,7 @@ sources = files(
         'dpaa2_recycle.c',
         'dpaa2_rxtx.c',
         'dpaa2_ptp.c',
+        'dpaa2_meter.c',
         'mc/dprtc.c',
         'mc/dpkg.c',
         'mc/dpdmux.c',
-- 
2.43.0

