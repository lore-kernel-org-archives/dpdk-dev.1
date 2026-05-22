Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC4B3CD5BB3
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 15:15:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C3F3B40677;
	Fri, 22 May 2026 17:14:51 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 46D6340664
 for <dev@dpdk.org>; Fri, 22 May 2026 17:14:47 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779462887; x=1810998887;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=9r4iT2I9DXxNtbki9p9jt+9sPnzsKI2VGJZ9azRcfHs=;
 b=jHZKK/LuT8YewvWb+blLbNRlvj9cJvOWF51BP2ymQ4pMk6TSxL74cMZ1
 MPZWJ/DloQHMrb5eosFIIeXXDvK5IN9RXSUWApZTSN5gpEByh1L/6QR/E
 ZUCjt06oFDwIkHtMhBRxdlsJCa5hR/EWNq1hy35v0lidJer9jRdM61fDW
 Ot1TGeEcoBRCsKyceAA4YSgyq5XwcoBC2KHYINuXFeC5I94/ivWSJ64He
 zMF8EfH7ILtSaucLQ8IE+HiAmWiNDx3R8qIXDC+42yh/1g2vDVRlYLPvG
 1y79u4nKHqraojDga7WGnwJw5p48xNfYC16u1rAVDdHTL+wL9IJGfbrXh w==;
X-CSE-ConnectionGUID: gFb/VKEFSjaR+m/WCZU1PQ==
X-CSE-MsgGUID: cNH9Fmi+TQOXMKlsnQr+iQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="97969152"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="97969152"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 08:14:46 -0700
X-CSE-ConnectionGUID: MQWrj/ehQpKjt6/BdmHiqg==
X-CSE-MsgGUID: 7CVX69OAQOakN6kTC/GsCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="245213930"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 22 May 2026 08:14:46 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 03/26] net/intel/common: add common flow attr validation
Date: Fri, 22 May 2026 16:14:12 +0100
Message-ID: <d75e9a02b40ccfe8fd2e00977ee99e9be95ca9ad.1779462699.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1779462698.git.anatoly.burakov@intel.com>
 <cover.1779462698.git.anatoly.burakov@intel.com>
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
 drivers/net/intel/common/flow_check.h | 69 +++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/drivers/net/intel/common/flow_check.h b/drivers/net/intel/common/flow_check.h
index 74fb28ae3d..0572028664 100644
--- a/drivers/net/intel/common/flow_check.h
+++ b/drivers/net/intel/common/flow_check.h
@@ -54,6 +54,7 @@ ci_flow_action_type_in_list(const enum rte_flow_action_type type,
 /* Forward declarations */
 struct ci_flow_actions;
 struct ci_flow_actions_check_param;
+struct ci_flow_attr_check_param;
 
 static inline const char *
 ci_flow_action_type_to_str(enum rte_flow_action_type type)
@@ -271,6 +272,74 @@ ci_flow_check_actions(const struct rte_flow_action *actions,
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

