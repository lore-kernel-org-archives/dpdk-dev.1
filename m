Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8088F4644B
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 10:53:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44FFB4064E;
	Mon, 16 Mar 2026 11:53:02 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id EB2CE4025E
 for <dev@dpdk.org>; Mon, 16 Mar 2026 11:52:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773658380; x=1805194380;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=TZtENQQY5YFQxrWzjylYdnr9ZdRYkzh76DBHsY1s2GU=;
 b=ZDY06xN0j9th87OCzMprW7a3HDlaohVUdQcnAsL7FbfI4OaTd7NrxBwT
 J5a/QyaPGEdOzPX7DKndViReTPCx6nZXsdwDl/IVlP/ZRoxcJSFc+jGwF
 6RFFwiJVCIqUiTuBPmalAm2NwFUPGGq+sCAwVHa2RMz8pf8wc4zSRQ0aY
 xCF1e3Ey6Z3Dw8d2dv9K10iuPzb4CSU/MPSRn0Pg1qIqTql4rNIf4FAz2
 WzX/q1H9vwMT47WDp1uLXMnZ9BtqGASG2APZuxVIjt9XJ4o6emPclUvaQ
 JZi2vuH4UZ68ipoHrpfnXF0eN7giIVzuUg0qIQ/bpcI4jKzNMymb5Xtzl g==;
X-CSE-ConnectionGUID: zNXZpm/aSjK5oONngiS3eQ==
X-CSE-MsgGUID: c+aY7cMCTI6uzDL47flhcA==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="62237411"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="62237411"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 03:53:00 -0700
X-CSE-ConnectionGUID: JpYlrYq0QfqjEFzHH59fhQ==
X-CSE-MsgGUID: l7de1F97T06TijJLkwBzYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221826550"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 16 Mar 2026 03:52:59 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 02/25] net/intel/common: add common flow attr validation
Date: Mon, 16 Mar 2026 10:52:27 +0000
Message-ID: <b5e47cdf400c34b72ec272f20d051164cf6f88b2.1773658289.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1773658289.git.anatoly.burakov@intel.com>
 <cover.1773658289.git.anatoly.burakov@intel.com>
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
- Default to ingress flows
- Transfer, group, priority, and egress are not allowed unless requested

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/common/flow_check.h | 70 +++++++++++++++++++++++++++
 1 file changed, 70 insertions(+)

diff --git a/drivers/net/intel/common/flow_check.h b/drivers/net/intel/common/flow_check.h
index 69b1b60ffc..9df7c39a7e 100644
--- a/drivers/net/intel/common/flow_check.h
+++ b/drivers/net/intel/common/flow_check.h
@@ -53,6 +53,7 @@ ci_flow_action_type_in_list(const enum rte_flow_action_type type,
 /* Forward declarations */
 struct ci_flow_actions;
 struct ci_flow_actions_check_param;
+struct ci_flow_attr_check_param;
 
 /**
  * Driver-specific action list validation callback.
@@ -230,6 +231,75 @@ ci_flow_check_actions(const struct rte_flow_action *actions,
 	return parsed_actions->count == 0 ? -EINVAL : 0;
 }
 
+/**
+ * Parameter structure for attr check.
+ */
+struct ci_flow_attr_check_param {
+	bool allow_priority; /**< True if priority attribute is allowed. */
+	bool allow_transfer; /**< True if transfer attribute is allowed. */
+	bool allow_group;    /**< True if group attribute is allowed. */
+	bool expect_egress;  /**< True if egress attribute is expected. */
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
+__rte_internal
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
+	/* Direction must be either ingress or egress */
+	if (attr->ingress == attr->egress) {
+		return rte_flow_error_set(error, EINVAL,
+					  RTE_FLOW_ERROR_TYPE_ATTR, attr,
+					  "Either ingress or egress must be set");
+	}
+
+	/* Expect ingress by default */
+	if (attr->egress && (attr_param == NULL || !attr_param->expect_egress)) {
+		return rte_flow_error_set(error, EINVAL,
+					  RTE_FLOW_ERROR_TYPE_ATTR_EGRESS, attr,
+					  "Egress not supported");
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

