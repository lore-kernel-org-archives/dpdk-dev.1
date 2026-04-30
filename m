Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12E5FFF8875
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 11:16:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BCAED40DCA;
	Thu, 30 Apr 2026 13:15:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id CCFB540BA6
 for <dev@dpdk.org>; Thu, 30 Apr 2026 13:15:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777547713; x=1809083713;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Q9Jd+Pd5O70HbjsBUWL7dpHnDANq7QOs7jcVtyfxTSc=;
 b=kw1z/tSWBd60aJhbkuqGY9iaReJc1z/rZXAbzlZDfq7K78cmaJDICAl9
 BIPGYBGMiSEQIzegbhD/TSsWXXj5Ltt4XM6aomSGfUIPPlBOcWM67uE9A
 ltWY2JAZuzjsCEYoypIfTta4UKZnSLD8d5gi9NcH9L8AjG9XPxXgcnUHx
 4Kd4hrDxPVRgu54JzjvfJBkRCOmFCIYEPHoI5j6uAsRmY1jLWsdHqTJLa
 mceC+GpJbbniqdVSRqQVEwBkzyxwNCS+LsrQ7lv0tLJAiQU+jW31tRSNg
 Q9zL1mQdhBFRU6ERHpyybHvkMyDNIOcwqB9TnAhiNaiJoqeMq4Jb03eFf w==;
X-CSE-ConnectionGUID: rkPWYSqaQaiXccTSyt2mhQ==
X-CSE-MsgGUID: WH5dHbe0Tfu4L/bgUTrtrg==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="78482304"
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="78482304"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 04:15:12 -0700
X-CSE-ConnectionGUID: 4XZ3g/5tRV6D78Djliyh2A==
X-CSE-MsgGUID: Zq0DVoGDSbGiZGxv66l9Fg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,208,1770624000"; d="scan'208";a="234444859"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa008.jf.intel.com with ESMTP; 30 Apr 2026 04:15:12 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 15/15] net/ixgbe: refactor flow creation
Date: Thu, 30 Apr 2026 12:14:44 +0100
Message-ID: <1e5d7b965bdd5296dee49eb898473ca09c758816.1777547413.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1777547413.git.anatoly.burakov@intel.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

For FDIR, the flow creation process is very complex and tangled in global
state updates. To simplify the code, refactor global state handling and
move it out of the main flow create function.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ixgbe/ixgbe_flow.c | 243 ++++++++++++++++-----------
 1 file changed, 144 insertions(+), 99 deletions(-)

diff --git a/drivers/net/intel/ixgbe/ixgbe_flow.c b/drivers/net/intel/ixgbe/ixgbe_flow.c
index cda2e95d22..7c0cdf8b74 100644
--- a/drivers/net/intel/ixgbe/ixgbe_flow.c
+++ b/drivers/net/intel/ixgbe/ixgbe_flow.c
@@ -2828,16 +2828,14 @@ ixgbe_parse_fdir_filter_tunnel(const struct rte_flow_attr *attr,
 
 static int
 ixgbe_parse_fdir_filter(struct rte_eth_dev *dev,
-			const struct rte_flow_attr *attr,
-			const struct rte_flow_item pattern[],
-			const struct rte_flow_action actions[],
-			struct ixgbe_fdir_rule *rule,
-			struct rte_flow_error *error)
+		const struct rte_flow_attr *attr,
+		const struct rte_flow_item pattern[],
+		const struct rte_flow_action actions[],
+		struct ixgbe_fdir_rule *rule,
+		struct rte_flow_error *error)
 {
 	int ret;
 	struct ixgbe_hw *hw = IXGBE_DEV_PRIVATE_TO_HW(dev->data->dev_private);
-	struct ixgbe_adapter *adapter = IXGBE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
-	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
 
 	if (hw->mac.type != ixgbe_mac_82599EB &&
 		hw->mac.type != ixgbe_mac_X540 &&
@@ -2849,36 +2847,131 @@ ixgbe_parse_fdir_filter(struct rte_eth_dev *dev,
 
 	ret = ixgbe_parse_fdir_filter_normal(dev, attr, pattern,
 					actions, rule, error);
-
 	if (!ret)
-		goto step_next;
+		return 0;
 
-	ret = ixgbe_parse_fdir_filter_tunnel(attr, pattern,
+	return ixgbe_parse_fdir_filter_tunnel(attr, pattern,
 					actions, rule, error);
+}
 
+static int
+ixgbe_fdir_process_rule(struct ixgbe_adapter *adapter,
+		struct ixgbe_hw_fdir_info *fdir_info,
+		struct ixgbe_fdir_rule *fdir_rule,
+		bool *first_mask,
+		struct rte_flow_error *error)
+{
+	bool flex_byte_offset_changed;
+	int ret;
+
+	/* rule must have a spec to be valid */
+	if (!fdir_rule->b_spec)
+		return rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+			NULL, "No filter spec");
+
+	/* if rule doesn't have a mask, nothing to be done */
+	if (!fdir_rule->b_mask)
+		return 0;
+
+	/* if we already have a mask, check if it's compatible */
+	if (fdir_info->mask_added) {
+		ret = memcmp(&fdir_info->mask, &fdir_rule->mask,
+				sizeof(struct ixgbe_hw_fdir_mask));
+		if (ret)
+			return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+				NULL, "Mask mismatch");
+
+		if (fdir_rule->mask.flex_bytes_mask &&
+		    fdir_info->flex_bytes_offset !=
+		    fdir_rule->flex_bytes_offset)
+			return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+				NULL, "Flex bytes offset mismatch");
+
+		/* success */
+		return 0;
+	}
+
+	/* we don't have a mask yet, so set it up based on this rule */
+	flex_byte_offset_changed =
+			fdir_info->flex_bytes_offset !=
+			fdir_rule->flex_bytes_offset;
+
+	if (fdir_rule->mask.flex_bytes_mask != 0 && flex_byte_offset_changed) {
+		ret = ixgbe_fdir_set_flexbytes_offset(adapter,
+				fdir_rule->flex_bytes_offset);
+		if (ret)
+			return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+				NULL,
+				"Failed to set flex bytes offset");
+	}
+
+	ret = ixgbe_fdir_set_input_mask(adapter, &fdir_rule->mask,
+			fdir_rule->mode);
 	if (ret)
-		return ret;
+		return rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+			NULL, "Failed to set fdir mask");
 
-step_next:
+	/* let the caller know that we've installed a mask */
+	*first_mask = true;
 
+	return 0;
+}
+
+static int
+ixgbe_fdir_flow_program(struct rte_eth_dev *dev,
+		struct ixgbe_adapter *adapter,
+		struct ixgbe_fdir_rule *fdir_rule,
+		bool *first_mask,
+		struct rte_flow_error *error)
+{
+	struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
+	struct rte_eth_fdir_conf local_fdir_conf = *fdir_conf;
+	struct ixgbe_hw_fdir_info *fdir_info =
+			IXGBE_DEV_PRIVATE_TO_FDIR_INFO(adapter);
+	int ret;
+
+	if (fdir_rule->queue >= dev->data->nb_rx_queues) {
+		return rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_ACTION,
+			NULL, "queue id > max number of queues");
+	}
+
+	local_fdir_conf.mode = fdir_rule->mode;
+
+	/* Configure FDIR mode if this is the first filter */
 	if (fdir_conf->mode == RTE_FDIR_MODE_NONE) {
-		struct rte_eth_fdir_conf fc = *fdir_conf;
-
-		fc.mode = rule->mode;
-		ret = ixgbe_fdir_configure(adapter, &fc, &rule->mask);
+		ret = ixgbe_fdir_configure(adapter, &local_fdir_conf, &fdir_rule->mask);
 		if (ret) {
-			fdir_conf->mode = RTE_FDIR_MODE_NONE;
-			return ret;
+			return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+				NULL, "Failed to configure fdir mode");
 		}
-		fdir_conf->mode = rule->mode;
-	} else if (fdir_conf->mode != rule->mode) {
-		return -ENOTSUP;
+	} else if (fdir_conf->mode != fdir_rule->mode) {
+		return rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+			NULL, "Conflict with existing fdir mode");
 	}
 
-	if (rule->queue >= dev->data->nb_rx_queues)
-		return -ENOTSUP;
+	/* Process and validate rule spec and mask */
+	ret = ixgbe_fdir_process_rule(adapter, fdir_info, fdir_rule,
+		first_mask, error);
+	if (ret)
+		return ret;
 
-	return ret;
+	/* Program the filter */
+	ret = ixgbe_fdir_filter_program(adapter, &local_fdir_conf,
+			fdir_rule, FALSE, FALSE);
+	if (ret)
+		return rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
+			NULL, "Failed to add fdir filter");
+
+	return 0;
 }
 
 static int
@@ -3066,7 +3159,6 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	struct ixgbe_fdir_rule_ele *fdir_rule_ptr;
 	struct ixgbe_rss_conf_ele *rss_filter_ptr;
 	struct ixgbe_flow_mem *ixgbe_flow_mem_ptr;
-	uint8_t first_mask = FALSE;
 
 	flow = rte_zmalloc("ixgbe_rte_flow", sizeof(struct rte_flow), 0);
 	if (!flow) {
@@ -3166,82 +3258,35 @@ ixgbe_flow_create(struct rte_eth_dev *dev,
 	ret = ixgbe_parse_fdir_filter(dev, attr, pattern,
 				actions, &fdir_rule, error);
 	if (!ret) {
-		/* A mask cannot be deleted. */
-		if (fdir_rule.b_mask) {
-			if (!fdir_info->mask_added) {
-				bool flex_byte_offset_changed =
-					fdir_info->flex_bytes_offset !=
-					fdir_rule.flex_bytes_offset;
-
-				if (fdir_rule.mask.flex_bytes_mask &&
-				    flex_byte_offset_changed) {
-					ret = ixgbe_fdir_set_flexbytes_offset(adapter,
-						fdir_rule.flex_bytes_offset);
-					if (ret)
-						goto out;
-				}
-				ret = ixgbe_fdir_set_input_mask(adapter,
-						&fdir_rule.mask, fdir_rule.mode);
-				if (ret)
-					goto out;
-
-				fdir_info->mask = fdir_rule.mask;
-				fdir_info->flex_bytes_offset =
-					fdir_rule.flex_bytes_offset;
-				fdir_info->mask_added = TRUE;
-				first_mask = TRUE;
-			} else {
-				/**
-				 * Only support one global mask,
-				 * all the masks should be the same.
-				 */
-				ret = memcmp(&fdir_info->mask,
-					&fdir_rule.mask,
-					sizeof(struct ixgbe_hw_fdir_mask));
-				if (ret)
-					goto out;
-
-				if (fdir_rule.mask.flex_bytes_mask &&
-				    fdir_info->flex_bytes_offset !=
-				    fdir_rule.flex_bytes_offset)
-					goto out;
-			}
+		struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
+		bool first_mask = false;
+
+		ret = ixgbe_fdir_flow_program(dev, adapter, &fdir_rule,
+			&first_mask, error);
+		if (ret)
+			goto out;
+
+		fdir_rule_ptr = rte_zmalloc("ixgbe_fdir_filter",
+				sizeof(struct ixgbe_fdir_rule_ele), 0);
+		if (!fdir_rule_ptr) {
+			PMD_DRV_LOG(ERR, "failed to allocate memory");
+			goto out;
 		}
-
-		if (fdir_rule.b_spec) {
-			struct rte_eth_fdir_conf *fdir_conf = IXGBE_DEV_FDIR_CONF(dev);
-
-			ret = ixgbe_fdir_filter_program(adapter, fdir_conf,
-					&fdir_rule, FALSE, FALSE);
-			if (!ret) {
-				fdir_rule_ptr = rte_zmalloc("ixgbe_fdir_filter",
-					sizeof(struct ixgbe_fdir_rule_ele), 0);
-				if (!fdir_rule_ptr) {
-					PMD_DRV_LOG(ERR, "failed to allocate memory");
-					goto out;
-				}
-				rte_memcpy(&fdir_rule_ptr->filter_info,
-					&fdir_rule,
-					sizeof(struct ixgbe_fdir_rule));
-				flow->rule = fdir_rule_ptr;
-				flow->filter_type = RTE_ETH_FILTER_FDIR;
-				fdir_info->n_flows++;
-
-				return flow;
-			}
-
-			if (ret) {
-				/**
-				 * clean the mask_added flag if fail to
-				 * program
-				 **/
-				if (first_mask)
-					fdir_info->mask_added = FALSE;
-				goto out;
-			}
+		/* update global state */
+		if (first_mask) {
+			fdir_info->mask_added = TRUE;
+			fdir_info->mask = fdir_rule.mask;
+			fdir_info->flex_bytes_offset = fdir_rule.flex_bytes_offset;
 		}
-
-		goto out;
+		fdir_info->n_flows++;
+		fdir_conf->mode = fdir_rule.mode;
+
+		rte_memcpy(&fdir_rule_ptr->filter_info,
+			&fdir_rule,
+			sizeof(struct ixgbe_fdir_rule));
+		flow->rule = fdir_rule_ptr;
+		flow->filter_type = RTE_ETH_FILTER_FDIR;
+		return flow;
 	}
 
 	memset(&l2_tn_filter, 0, sizeof(struct ixgbe_l2_tunnel_conf));
-- 
2.47.3

