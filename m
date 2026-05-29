Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F827CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 15:37:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9B93840676;
	Fri, 29 May 2026 17:36:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 7FA2B40663
 for <dev@dpdk.org>; Fri, 29 May 2026 17:36:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780069002; x=1811605002;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=gKDpOa5IUs4VdCX87RzgpE7qzpP41Muh3XzPVC9QA3M=;
 b=AShWg4BqBKJH4pq7rtinmxksxjTEGQpV9/9p65JUa+ks4A07vDzeKkdd
 VAuL9de9KrPfYSwaD8g1if1P+g2vtWYWKlWh+XOYxwPuP7m6Vh1yJ9JBp
 D5CWbcVanKGVBolF/N9Uo0Svg9S0hP3ryfxn9mR8gesc7EVg1JBi3q9pR
 p+p3Nh6e+6bPWUwcJtRIcvUxOHlcCXzM9TErBr6nIOolASlp0AQm1zg8Z
 TTRtao+SaMjChiOpXv4B6/nksNhTTeEg7yt0LaKpJ+U3y8t48PTd55Ma5
 X+XbjMtE0zqxTEOfQZi3kdzzt5vJt0Qx4RxC1vXAQYV9NB8BO/o+6VWFp A==;
X-CSE-ConnectionGUID: GMj5pbHXQwy34RX6M4Ng6A==
X-CSE-MsgGUID: 341iIEJVQqOqJOeKzBVA6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11801"; a="84549774"
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="84549774"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 29 May 2026 08:36:41 -0700
X-CSE-ConnectionGUID: 33dX4f0FT4anDc18ZhhPDw==
X-CSE-MsgGUID: xH3SkLCGRNOPzMAoHOAH6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,175,1774335600"; d="scan'208";a="281001212"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa001.jf.intel.com with ESMTP; 29 May 2026 08:36:41 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v6 04/27] net/intel/common: add common flow attr validation
Date: Fri, 29 May 2026 16:36:06 +0100
Message-ID: <fd336190aad9a3deddb21548e34febb243c883d9.1780068633.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780068633.git.anatoly.burakov@intel.com>
 <cover.1780068633.git.anatoly.burakov@intel.com>
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

There are a lot of commonalities between what kinds of flow attr each Intel
driver supports. Add a helper function that will validate attr based on
common requirements and (optional) parameter checks.

Things we check for:
- Rejecting NULL attr (obviously)
- Ingress/egress according to requested params
- Transfer, group, and priority are not allowed unless requested

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/common/flow_check.h | 70 +++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/net/intel/common/flow_check.h b/drivers/net/intel/common/flow_check.h
index f5cccedf02..3d99dc7c9c 100644
--- a/drivers/net/intel/common/flow_check.h
+++ b/drivers/net/intel/common/flow_check.h
@@ -57,6 +57,7 @@ ci_flow_action_type_in_list(const enum rte_flow_action_type type,
 /* Forward declarations */
 struct ci_flow_actions;
 struct ci_flow_actions_check_param;
+struct ci_flow_attr_check_param;
 
 static inline const char *
 ci_flow_action_type_to_str(enum rte_flow_action_type type)
@@ -272,6 +273,75 @@ ci_flow_check_actions(const struct rte_flow_action *actions,
 	return parsed_actions->count == 0 ? -EINVAL : 0;
 }
 
+/**
+ * Parameter structure for attr check.
+ */
+struct ci_flow_attr_check_param {
+	bool allow_priority; /**< True if priority attribute is allowed. */
+	bool allow_transfer; /**< True if transfer attribute is allowed. */
+	bool allow_group;    /**< True if group attribute is allowed. */
+	bool require_egress;  /**< True if egress attribute is required. */
+};
+
+/**
+ * Validate rte_flow_attr structure against specified constraints.
+ *
+ * @param attr Pointer to rte_flow_attr structure to validate.
+ * @param attr_param Pointer to ci_flow_attr_check_param structure specifying constraints.
+ * @param error Pointer to rte_flow_error structure for error reporting.
+ *
+ * @return 0 on success, negative errno on failure.
+ */
+static inline int
+ci_flow_check_attr(const struct rte_flow_attr *attr,
+		const struct ci_flow_attr_check_param *attr_param,
+		struct rte_flow_error *error)
+{
+	if (attr == NULL) {
+		return rte_flow_error_set(error, EINVAL,
+					  RTE_FLOW_ERROR_TYPE_ATTR, attr,
+					  "NULL attribute");
+	}
+
+	/* a rule can only be ingress or egress, never both or neither. */
+	if (attr_param != NULL && attr_param->require_egress) {
+		if (attr->egress != 1 || attr->ingress != 0) {
+			return rte_flow_error_set(error, EINVAL,
+						  RTE_FLOW_ERROR_TYPE_ATTR_EGRESS, attr,
+						  "Egress attribute is required");
+		}
+	} else {
+		if (attr->ingress != 1 || attr->egress != 0) {
+			return rte_flow_error_set(error, EINVAL,
+						  RTE_FLOW_ERROR_TYPE_ATTR_INGRESS, attr,
+						  "Ingress attribute is required");
+		}
+	}
+
+	/* May not be supported */
+	if (attr->transfer && (attr_param == NULL || !attr_param->allow_transfer)) {
+		return rte_flow_error_set(error, EINVAL,
+					  RTE_FLOW_ERROR_TYPE_ATTR_TRANSFER, attr,
+					  "Transfer not supported");
+	}
+
+	/* May not be supported */
+	if (attr->group && (attr_param == NULL || !attr_param->allow_group)) {
+		return rte_flow_error_set(error, EINVAL,
+					  RTE_FLOW_ERROR_TYPE_ATTR_GROUP, attr,
+					  "Group not supported");
+	}
+
+	/* May not be supported */
+	if (attr->priority && (attr_param == NULL || !attr_param->allow_priority)) {
+		return rte_flow_error_set(error, EINVAL,
+					  RTE_FLOW_ERROR_TYPE_ATTR_PRIORITY, attr,
+					  "Priority not supported");
+	}
+
+	return 0;
+}
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.47.3

