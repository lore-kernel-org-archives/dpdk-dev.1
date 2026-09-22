Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46890C982F1
	for <dpdk-dev@archiver.kernel.org>; Tue, 22 Sep 2026 09:55:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57FFD42D6A;
	Tue, 22 Sep 2026 11:55:41 +0200 (CEST)
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
 by mails.dpdk.org (Postfix) with ESMTP id 351E6402BA
 for <dev@dpdk.org>; Tue, 22 Sep 2026 11:55:36 +0200 (CEST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 132371A0002;
 Tue, 22 Sep 2026 11:55:36 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id D10831A0007;
 Tue, 22 Sep 2026 11:55:35 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 7425B180006C;
 Tue, 22 Sep 2026 17:55:34 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Gagandeep Singh <g.singh@nxp.com>
Subject: [PATCH v4-S2 04/13] net/dpaa2: support MPLS and PPPoE flow
 distribution
Date: Tue, 22 Sep 2026 15:25:19 +0530
Message-ID: <20260922095528.2469885-5-prashant.gupta_3@nxp.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260922095528.2469885-1-prashant.gupta_3@nxp.com>
References: <20260915113459.4166621-1-prashant.gupta_3@nxp.com>
 <20260922095528.2469885-1-prashant.gupta_3@nxp.com>
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

From: Gagandeep Singh <g.singh@nxp.com>

Add rte_flow pattern support for MPLS and PPPoE items in the dpaa2
PMD flow engine.

For a pattern with no spec/mask, the frame is identified by its Frame
Attribute Flag (FAF_MPLS_FRAM / FAF_PPPOE_PPP_FRAM) for both the QoS
and flow steering tables.  When a spec is present, the MPLS label
(NH_FLD_MPLS_MPLSL_1) or the PPPoE session id (NH_FLD_PPPOE_SID) is
added as a header extract rule for both tables.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/nics/features/dpaa2.ini |   2 +
 drivers/net/dpaa2/dpaa2_flow.c     | 202 ++++++++++++++++++++++++++++-
 2 files changed, 203 insertions(+), 1 deletion(-)

diff --git a/doc/guides/nics/features/dpaa2.ini b/doc/guides/nics/features/dpaa2.ini
index 4788afef8d..49faebcd06 100644
--- a/doc/guides/nics/features/dpaa2.ini
+++ b/doc/guides/nics/features/dpaa2.ini
@@ -43,6 +43,8 @@ gtp                  = Y
 icmp                 = Y
 ipv4                 = Y
 ipv6                 = Y
+mpls                 = Y
+pppoes               = Y
 raw                  = Y
 sctp                 = Y
 tcp                  = Y
diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index 2e44bff766..63bbce0ab7 100644
--- a/drivers/net/dpaa2/dpaa2_flow.c
+++ b/drivers/net/dpaa2/dpaa2_flow.c
@@ -80,6 +80,8 @@ enum rte_flow_item_type dpaa2_hp_supported_pattern_type[] = {
 	RTE_FLOW_ITEM_TYPE_GTP,
 	RTE_FLOW_ITEM_TYPE_ESP,
 	RTE_FLOW_ITEM_TYPE_AH,
+	RTE_FLOW_ITEM_TYPE_MPLS,
+	RTE_FLOW_ITEM_TYPE_PPPOES,
 	RTE_FLOW_ITEM_TYPE_RAW
 };
 
@@ -180,6 +182,14 @@ static const struct rte_flow_item_gtp dpaa2_flow_item_gtp_mask = {
 	.teid = RTE_BE32(0xffffffff),
 };
 
+static const struct rte_flow_item_mpls dpaa2_flow_item_mpls_mask = {
+	.label_tc_s = { 0xff, 0xff, 0xf0 },
+};
+
+static const struct rte_flow_item_pppoe dpaa2_flow_item_pppoe_mask = {
+	.session_id = RTE_BE16(0xffff),
+};
+
 #endif
 
 #define DPAA2_FLOW_DUMP printf
@@ -1764,6 +1774,14 @@ dpaa2_flow_extract_support(const uint8_t *mask_src,
 		mask_support = (const char *)&dpaa2_flow_item_gtp_mask;
 		size = sizeof(struct rte_flow_item_gtp);
 		break;
+	case RTE_FLOW_ITEM_TYPE_MPLS:
+		mask_support = (const char *)&dpaa2_flow_item_mpls_mask;
+		size = sizeof(struct rte_flow_item_mpls);
+		break;
+	case RTE_FLOW_ITEM_TYPE_PPPOES:
+		mask_support = (const char *)&dpaa2_flow_item_pppoe_mask;
+		size = sizeof(struct rte_flow_item_pppoe);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -4041,6 +4059,163 @@ dpaa2_configure_flow_gtp(struct dpaa2_dev_flow *flow,
 	return 0;
 }
 
+static int
+dpaa2_configure_flow_mpls(struct dpaa2_dev_flow *flow,
+	struct rte_eth_dev *dev,
+	const struct rte_flow_attr *attr,
+	const struct rte_dpaa2_flow_item *dpaa2_pattern,
+	const struct rte_flow_action actions[] __rte_unused,
+	struct rte_flow_error *error __rte_unused,
+	int *device_configured)
+{
+	int ret, local_cfg = 0;
+	uint32_t group;
+	const struct rte_flow_item_mpls *spec, *mask;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	const struct rte_flow_item *pattern =
+		&dpaa2_pattern->generic_item;
+
+	group = attr->group;
+
+	/* Parse pattern list to get the matching parameters */
+	spec = pattern->spec;
+	mask = pattern->mask ?
+		pattern->mask : &dpaa2_flow_item_mpls_mask;
+
+	/* Get traffic class index and flow id to be configured */
+	flow->tc_id = group;
+	flow->tc_index = attr->priority;
+
+	if (dpaa2_pattern->in_tunnel) {
+		DPAA2_PMD_ERR("Tunnel-MPLS distribution not support");
+		return -ENOTSUP;
+	}
+
+	if (!spec) {
+		ret = dpaa2_flow_identify_by_faf(priv, flow,
+				FAF_MPLS_FRAM, DPAA2_FLOW_QOS_TYPE,
+				group, &local_cfg);
+		if (ret)
+			return ret;
+
+		ret = dpaa2_flow_identify_by_faf(priv, flow,
+				FAF_MPLS_FRAM, DPAA2_FLOW_FS_TYPE,
+				group, &local_cfg);
+		if (ret)
+			return ret;
+
+		(*device_configured) |= local_cfg;
+		return 0;
+	}
+
+	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
+		RTE_FLOW_ITEM_TYPE_MPLS);
+	if (ret) {
+		DPAA2_PMD_WARN("Extract field(s) of MPLS not support.");
+		return ret;
+	}
+
+	if (!mask->label_tc_s[0] && !mask->label_tc_s[1] &&
+		!mask->label_tc_s[2])
+		return 0;
+
+	ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_MPLS,
+			NH_FLD_MPLS_MPLSL_1, spec->label_tc_s,
+			mask->label_tc_s, sizeof(mask->label_tc_s),
+			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
+	if (ret)
+		return ret;
+
+	ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_MPLS,
+			NH_FLD_MPLS_MPLSL_1, spec->label_tc_s,
+			mask->label_tc_s, sizeof(mask->label_tc_s),
+			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+	if (ret)
+		return ret;
+
+	(*device_configured) |= local_cfg;
+
+	return 0;
+}
+
+static int
+dpaa2_configure_flow_pppoe(struct dpaa2_dev_flow *flow,
+	struct rte_eth_dev *dev,
+	const struct rte_flow_attr *attr,
+	const struct rte_dpaa2_flow_item *dpaa2_pattern,
+	const struct rte_flow_action actions[] __rte_unused,
+	struct rte_flow_error *error __rte_unused,
+	int *device_configured)
+{
+	int ret, local_cfg = 0;
+	uint32_t group;
+	const struct rte_flow_item_pppoe *spec, *mask;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	const struct rte_flow_item *pattern =
+		&dpaa2_pattern->generic_item;
+
+	group = attr->group;
+
+	/* Parse pattern list to get the matching parameters */
+	spec = pattern->spec;
+	mask = pattern->mask ?
+		pattern->mask : &dpaa2_flow_item_pppoe_mask;
+
+	/* Get traffic class index and flow id to be configured */
+	flow->tc_id = group;
+	flow->tc_index = attr->priority;
+
+	if (dpaa2_pattern->in_tunnel) {
+		DPAA2_PMD_ERR("Tunnel-PPPoE distribution not support");
+		return -ENOTSUP;
+	}
+
+	if (!spec) {
+		ret = dpaa2_flow_identify_by_faf(priv, flow,
+				FAF_PPPOE_PPP_FRAM, DPAA2_FLOW_QOS_TYPE,
+				group, &local_cfg);
+		if (ret)
+			return ret;
+
+		ret = dpaa2_flow_identify_by_faf(priv, flow,
+				FAF_PPPOE_PPP_FRAM, DPAA2_FLOW_FS_TYPE,
+				group, &local_cfg);
+		if (ret)
+			return ret;
+
+		(*device_configured) |= local_cfg;
+		return 0;
+	}
+
+	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
+		RTE_FLOW_ITEM_TYPE_PPPOES);
+	if (ret) {
+		DPAA2_PMD_WARN("Extract field(s) of PPPoE not support.");
+		return ret;
+	}
+
+	if (!mask->session_id)
+		return 0;
+
+	ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_PPPOE,
+			NH_FLD_PPPOE_SID, &spec->session_id,
+			&mask->session_id, sizeof(rte_be16_t),
+			priv, group, &local_cfg, DPAA2_FLOW_QOS_TYPE);
+	if (ret)
+		return ret;
+
+	ret = dpaa2_flow_add_hdr_extract_rule(flow, NET_PROT_PPPOE,
+			NH_FLD_PPPOE_SID, &spec->session_id,
+			&mask->session_id, sizeof(rte_be16_t),
+			priv, group, &local_cfg, DPAA2_FLOW_FS_TYPE);
+	if (ret)
+		return ret;
+
+	(*device_configured) |= local_cfg;
+
+	return 0;
+}
+
 static int
 dpaa2_configure_flow_raw(struct dpaa2_dev_flow *flow,
 	struct rte_eth_dev *dev,
@@ -4549,7 +4724,7 @@ dpaa2_generic_flow_set(struct dpaa2_dev_flow *flow,
 {
 	const struct rte_flow_action_rss *rss_conf;
 	int is_keycfg_configured = 0, end_of_list = 0;
-	int ret = 0, i = 0, j = 0;
+	int ret = 0, i = 0, j = 0, mpls_count = 0;
 	struct dpaa2_dev_priv *priv = dev->data->dev_private;
 	struct dpaa2_dev_flow *curr = LIST_FIRST(&priv->flows);
 	uint16_t dist_size, key_size;
@@ -4712,6 +4887,31 @@ dpaa2_generic_flow_set(struct dpaa2_dev_flow *flow,
 				goto end_flow_set;
 			}
 			break;
+		case RTE_FLOW_ITEM_TYPE_MPLS:
+			if (mpls_count > 0) {
+				ret = -ENOTSUP;
+				goto end_flow_set;
+			}
+			ret = dpaa2_configure_flow_mpls(flow,
+					dev, attr, &dpaa2_pattern[i],
+					actions, error,
+					&is_keycfg_configured);
+			if (ret) {
+				DPAA2_PMD_ERR("MPLS flow config failed!");
+				goto end_flow_set;
+			}
+			mpls_count++;
+			break;
+		case RTE_FLOW_ITEM_TYPE_PPPOES:
+			ret = dpaa2_configure_flow_pppoe(flow,
+					dev, attr, &dpaa2_pattern[i],
+					actions, error,
+					&is_keycfg_configured);
+			if (ret) {
+				DPAA2_PMD_ERR("PPPoE flow config failed!");
+				goto end_flow_set;
+			}
+			break;
 		case RTE_FLOW_ITEM_TYPE_RAW:
 			ret = dpaa2_configure_flow_raw(flow, dev, attr,
 					&dpaa2_pattern[i],
-- 
2.43.0

