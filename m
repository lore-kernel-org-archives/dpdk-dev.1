Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD52FE9E310
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 14:21:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F09B4066C;
	Wed, 11 Feb 2026 15:21:03 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 7CA9E40655
 for <dev@dpdk.org>; Wed, 11 Feb 2026 15:21:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770819660; x=1802355660;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=DCu7pxOshxO6fR6ZmbWCY8zbtNHlRPJspi9dIdwowx4=;
 b=DdK6FaL0C5sSxHs8POTkqyZe+nV76Fp5EnTTxSorLZdZnQeCC3kkXSbg
 /pwqJxIQkFVPNtm6KpXN79PVXRgUQrHqCcVzeaRCKTu6c0qDOguoUfm5P
 5J1bWMhHO1mk7ZozaIPXLNjP6PotSuH96SYOeB9i6boGWdP9Q+Xa5VZnS
 TuC88c0UtCn1NdZSfzsLjGqfmOm50Jlna4eQPD7GJKcQtlXnt0JanAln9
 qRA5fhTQi7wkiHdxTzJbJgRaDuUErgXV0ZwQpLJ/NoQnDmnbWnc6C5pOR
 Pgkwsci/Eo8LZwf3w2HOZOUNNHC6Cvtju8/pH53ycIfe3wR++31V0BZzv A==;
X-CSE-ConnectionGUID: EXR07Ka9SEqJ6wlJ04ePww==
X-CSE-MsgGUID: Ia58kla0SlubOLIYI55tEQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71866721"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71866721"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 06:20:59 -0800
X-CSE-ConnectionGUID: JXMFUdEDQJ+V14OsDC4Wkg==
X-CSE-MsgGUID: L6X5v3XKSX+iRofU7dCaCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211569097"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 11 Feb 2026 06:20:59 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 02/25] net/intel/common: add common flow attr validation
Date: Wed, 11 Feb 2026 14:20:19 +0000
Message-ID: <31c8d242424eee9f7caff858ab79381c46c31e2a.1770819434.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1770819433.git.anatoly.burakov@intel.com>
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
index 1916ac169c..b7c73fcf7c 100644
--- a/drivers/net/intel/common/flow_check.h
+++ b/drivers/net/intel/common/flow_check.h
@@ -53,6 +53,7 @@ ci_flow_action_type_in_list(const enum rte_flow_action_type type,
 /* Forward declarations */
 struct ci_flow_actions;
 struct ci_flow_actions_check_param;
+struct ci_flow_attr_check_param;
 
 /**
  * Driver-specific action list validation callback.
@@ -231,6 +232,75 @@ ci_flow_check_actions(const struct rte_flow_action *actions,
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

