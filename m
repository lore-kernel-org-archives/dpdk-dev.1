Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F407CD6E6D
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 16:20:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C28C140678;
	Thu,  4 Jun 2026 18:19:46 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by mails.dpdk.org (Postfix) with ESMTP id 2D18140651
 for <dev@dpdk.org>; Thu,  4 Jun 2026 18:19:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1780589983; x=1812125983;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=XBhS60oBAaetEu9NnK3q24Vfnkpz+yj8m/POp8BdyPA=;
 b=QGE4s3NDQGwFMeqc5+ngV45h0zz5rdxMoMepgeNa0ky4AFkTHQXL/iZ3
 HYVfAa/ZnS3xsdfrcTY5C8JQh4D7RLnsbGL26cJ60Xd+E4ldngsdtr02U
 ebvM8sTgizny7WfOGLQ+E13kdiTbInIidl5IQTMsRbwRL1Y500F0AfqJV
 BDyB0shjbKVWc5g+TH8fc1R4NqSPcS8Cwvj6LWrG3ZyoS33Ssz+uReNrM
 6WazbCAUlbRI0klfNZwiFdhNx6l0AqLmImt1firxNJCJ6kYpgkegwV84W
 yyzMm6ByPsDep69tJ+q/AW+lot+uvNWVkZtQD8q0Q2yxytNQaA6LuA7yJ Q==;
X-CSE-ConnectionGUID: SQyCcRFPRWGEmnlnvbALsA==
X-CSE-MsgGUID: MgtWcOeUSGqOLizgvcXPDA==
X-IronPort-AV: E=McAfee;i="6800,10657,11807"; a="85045113"
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; d="scan'208";a="85045113"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Jun 2026 09:19:43 -0700
X-CSE-ConnectionGUID: eeJieouLTIOzpyrR81VNyQ==
X-CSE-MsgGUID: G3k14Y4rSl6UF6FLdYOuRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,187,1774335600"; d="scan'208";a="240403960"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 04 Jun 2026 09:19:42 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v7 04/27] net/intel/common: add common flow attr validation
Date: Thu,  4 Jun 2026 17:19:08 +0100
Message-ID: <3c82256d5e201a7cd60b1d4ef84152f9bf371341.1780589914.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1780589913.git.anatoly.burakov@intel.com>
 <cover.1780589913.git.anatoly.burakov@intel.com>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/intel/common/flow_check.h | 70 +++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/net/intel/common/flow_check.h b/drivers/net/intel/common/flow_check.h
index 075c86e61e..b143adb8d3 100644
--- a/drivers/net/intel/common/flow_check.h
+++ b/drivers/net/intel/common/flow_check.h
@@ -57,6 +57,7 @@ ci_flow_action_type_in_list(const enum rte_flow_action_type type,
 /* Forward declarations */
 struct ci_flow_actions;
 struct ci_flow_actions_check_param;
+struct ci_flow_attr_check_param;
 
 static inline const char *
 ci_flow_action_type_to_str(enum rte_flow_action_type type)
@@ -277,6 +278,75 @@ ci_flow_check_actions(const struct rte_flow_action *actions,
 	return 0;
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

