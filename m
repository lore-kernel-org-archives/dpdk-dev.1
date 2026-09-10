Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED7BEC79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 13:56:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA68E42E9F;
	Thu, 10 Sep 2026 15:52:57 +0200 (CEST)
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
 by mails.dpdk.org (Postfix) with ESMTP id 7C25C42E6E
 for <dev@dpdk.org>; Thu, 10 Sep 2026 15:52:45 +0200 (CEST)
Received: from inva021.nxp.com (localhost [127.0.0.1])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 614A82003F6;
 Thu, 10 Sep 2026 15:52:45 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com
 (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
 by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2BA7D200035;
 Thu, 10 Sep 2026 15:52:45 +0200 (CEST)
Received: from lsv031405.swis.in-blr01.nxp.com
 (lsv031405.swis.in-blr01.nxp.com [92.120.147.93])
 by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 24B531800068;
 Thu, 10 Sep 2026 21:52:43 +0800 (+08)
From: Prashant Gupta <prashant.gupta_3@nxp.com>
To: stephen@networkplumber.org,
	dev@dpdk.org
Cc: Hemant Agrawal <hemant.agrawal@nxp.com>
Subject: [PATCH v2 37/47] net/dpaa2: support GENEVE flow item
Date: Thu, 10 Sep 2026 19:21:48 +0530
Message-ID: <20260910135158.2181141-38-prashant.gupta_3@nxp.com>
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

Add GENEVE flow item support to the dpaa2 flow engine. The GENEVE
protocol and VNI fields are matched through the soft parser, so the
item is only accepted when the soft parser is loaded.

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/dpaa2/dpaa2_flow.c | 102 ++++++++++++++++++++++++++++++++-
 1 file changed, 101 insertions(+), 1 deletion(-)

diff --git a/drivers/net/dpaa2/dpaa2_flow.c b/drivers/net/dpaa2/dpaa2_flow.c
index e52b796a64..f86e1c0acc 100644
--- a/drivers/net/dpaa2/dpaa2_flow.c
+++ b/drivers/net/dpaa2/dpaa2_flow.c
@@ -140,7 +140,8 @@ enum rte_flow_item_type dpaa2_hp_supported_pattern_type[] = {
 
 static const
 enum rte_flow_item_type dpaa2_sp_supported_pattern_type[] = {
-	RTE_FLOW_ITEM_TYPE_ECPRI
+	RTE_FLOW_ITEM_TYPE_ECPRI,
+	RTE_FLOW_ITEM_TYPE_GENEVE
 };
 
 static const enum rte_flow_action_type dpaa2_supported_fs_action_type[] = {
@@ -248,6 +249,10 @@ static const struct rte_flow_item_vxlan dpaa2_flow_item_vxlan_mask = {
 	.vni = {0xff, 0xff, 0xff},
 };
 
+static const struct rte_flow_item_geneve dpaa2_flow_item_geneve_mask = {
+	.protocol = RTE_BE16(0xffff),
+	.vni = {0xff, 0xff, 0xff},
+};
 
 static const struct rte_flow_item_ecpri dpaa2_flow_item_ecpri_mask = {
 	.hdr.common.type = 0xff,
@@ -1573,6 +1578,10 @@ dpaa2_flow_extract_support(const uint8_t *mask_src,
 		mask_support = (const char *)&dpaa2_flow_item_gtp_mask;
 		size = sizeof(struct rte_flow_item_gtp);
 		break;
+	case RTE_FLOW_ITEM_TYPE_GENEVE:
+		mask_support = (const char *)&dpaa2_flow_item_geneve_mask;
+		size = sizeof(struct rte_flow_item_geneve);
+		break;
 	default:
 		return -EINVAL;
 	}
@@ -3371,6 +3380,89 @@ dpaa2_flow_raw_extract_rule_set(struct dpaa2_generic_flow *flow,
 	return 0;
 }
 
+static int
+dpaa2_flow_geneve_extract_rule_set(struct dpaa2_generic_flow *flow,
+	const struct rte_flow_attr *attr,
+	const struct rte_dpaa2_flow_item *dpaa2_pattern,
+	int *extract_cfg, enum dpaa2_flow_dist_type dist_type)
+{
+	int ret, local_cfg = 0;
+	uint32_t bit_offset;
+	const struct rte_flow_item_geneve *spec, *mask;
+	struct dpaa2_dev_priv *priv = flow->priv;
+	const struct rte_flow_item *pattern = &dpaa2_pattern->generic_item;
+	char hex_dump[DPAA2_FLOW_HDR_HEX_DUMP_SIZE];
+
+	if (!priv->sp_protocol) {
+		DPAA2_PMD_ERR("GENEVE flow is not supported without SP.");
+		return -ENOTSUP;
+	}
+
+	/* Parse pattern list to get the matching parameters */
+	spec = pattern->spec;
+	mask = pattern->mask ?
+		pattern->mask : &dpaa2_flow_item_geneve_mask;
+
+	if (dpaa2_pattern->in_tunnel) {
+		DPAA2_PMD_ERR("Tunnel-GENEVE distribution not support");
+		return -ENOTSUP;
+	}
+
+	ret = dpaa2_protocol_psr_bit_offset(&bit_offset,
+		DPAA2_PARSER_GENEVE_ID);
+	if (ret)
+		return ret;
+
+	ret = dpaa2_flow_identify_by_faf(priv, flow,
+		bit_offset, dist_type, attr->group, &local_cfg);
+	if (ret)
+		return ret;
+
+	if (!spec)
+		goto quit;
+
+	ret = dpaa2_flow_extract_support((const uint8_t *)mask,
+		RTE_FLOW_ITEM_TYPE_GENEVE);
+	if (ret) {
+		dpaa2_flow_hdr_hexdump(hex_dump, sizeof(hex_dump), (const uint8_t *)mask,
+			sizeof(struct rte_flow_item_geneve));
+		DPAA2_PMD_ERR("Extract GENEVE(%s) failed(%d)",
+			hex_dump, ret);
+
+		return ret;
+	}
+
+	if (mask->protocol && mask->protocol != 0xffff) {
+		DPAA2_PMD_ERR("Not support to extract geneve protocol.");
+		return -EINVAL;
+	}
+
+	if (mask->protocol) {
+		ret = dpaa2_flow_add_pr_extract_rule(flow,
+			DPAA2_GENEVE_PROTOCOL_OFFSET,
+			sizeof(mask->protocol), &spec->protocol,
+			&mask->protocol, priv, attr->group, &local_cfg,
+			dist_type);
+		if (ret)
+			return ret;
+	}
+
+	if (mask->vni[0] || mask->vni[1] || mask->vni[2]) {
+		ret = dpaa2_flow_add_pr_extract_rule(flow,
+			DPAA2_GENEVE_VNI_OFFSET,
+			sizeof(mask->vni), spec->vni,
+			mask->vni,
+			priv, attr->group, &local_cfg, dist_type);
+		if (ret)
+			return ret;
+	}
+
+quit:
+	if (extract_cfg)
+		(*extract_cfg) |= local_cfg;
+
+	return 0;
+}
 
 static inline int
 dpaa2_flow_verify_entry(struct dpaa2_dev_priv *priv,
@@ -4236,6 +4328,14 @@ dpaa2_flow_generic_extract_rule_set(struct dpaa2_generic_flow *flow,
 				goto end_extract_set;
 			}
 			break;
+		case RTE_FLOW_ITEM_TYPE_GENEVE:
+			ret = dpaa2_flow_geneve_extract_rule_set(flow, attr,
+				&dpaa2_pattern[i], &extract_cfg, dist_type);
+			if (ret) {
+				DPAA2_PMD_ERR("GENEVE flow config failed!");
+				goto end_extract_set;
+			}
+			break;
 		case RTE_FLOW_ITEM_TYPE_RAW:
 			ret = dpaa2_flow_raw_extract_rule_set(flow, attr,
 				&dpaa2_pattern[i], &extract_cfg, dist_type);
-- 
2.43.0

