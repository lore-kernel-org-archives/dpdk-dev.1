Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F51E9E30D
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 14:21:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 418274065C;
	Wed, 11 Feb 2026 15:21:01 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id DF93740268
 for <dev@dpdk.org>; Wed, 11 Feb 2026 15:20:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770819659; x=1802355659;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=A/XngHX3AgQgjWE0D+gp6ZyzVE3WXj1vzU2HoQNsvbk=;
 b=Z0mWsj1dF0iUkeaAo3uMW02xkQMcdaqjJIdj8wQrDiqvGqE46iQBncdW
 1ak+RXabWFQY7ZOXzCuU3gwIobZpt+C02QHgFONmAOe6foUy56Wc9X4FR
 BYridqXUPBfeFuqXDQvVVFgdm10lRPkjV3m8pv4r3M3WyayEwLNDfCJWY
 HeljLmALmH8M3TCYJlp+wi/858kaqFfyseSYs0yQymkzP8UOPZsxYpGGx
 Yex+ovyx0c9I4RjAKp/dOoPPm4mBeaFKcpN5YEKe9soUdn25TmwlF6Dqd
 bCaDpgBpCN2rNX6cTsdBt6oMTMnM8DKpmrhwYJy8KgVEwtG9BK1VF4Bqf g==;
X-CSE-ConnectionGUID: IuNVVKFmQ66jTJ59u7aLRw==
X-CSE-MsgGUID: PkgUvtg+Q122hPCrmV0pPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71866720"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71866720"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 06:20:58 -0800
X-CSE-ConnectionGUID: wRo2ec6IS3qO+n9Z+KOFBA==
X-CSE-MsgGUID: xkaHhdcSSvuB5cwhbwubLw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211569091"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 11 Feb 2026 06:20:58 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 01/25] net/intel/common: add common flow action parsing
Date: Wed, 11 Feb 2026 14:20:18 +0000
Message-ID: <bc5881ba9bf765a66d2ca83ee272911a0722a05c.1770819434.git.anatoly.burakov@intel.com>
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

Currently, each driver has their own code for action parsing, which results
in a lot of duplication and subtle mismatches in behavior between drivers.

Add common infrastructure, based on the following assumptions:

- All drivers support at most 4 actions at once, but usually less
- Not every action is supported by all drivers
- We can check a few common things to filter out obviously wrong actions
- Driver performs semantic checks on all valid actions

So, the intention is to reject everything we can reasonably reject at the
outset without knowing anything about the drivers, parametrize what is
trivial to parametrize, and leave the rest for the driver to implement.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/common/flow_check.h | 238 ++++++++++++++++++++++++++
 1 file changed, 238 insertions(+)
 create mode 100644 drivers/net/intel/common/flow_check.h

diff --git a/drivers/net/intel/common/flow_check.h b/drivers/net/intel/common/flow_check.h
new file mode 100644
index 0000000000..1916ac169c
--- /dev/null
+++ b/drivers/net/intel/common/flow_check.h
@@ -0,0 +1,238 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Intel Corporation
+ */
+
+#ifndef _COMMON_INTEL_FLOW_CHECK_H_
+#define _COMMON_INTEL_FLOW_CHECK_H_
+
+#include <bus_pci_driver.h>
+#include <ethdev_driver.h>
+
+#ifdef __cplusplus
+extern "C" {
+#endif
+
+/*
+ * Common attr and action validation code for Intel drivers.
+ */
+
+/**
+ * Maximum number of actions that can be stored in a parsed action list.
+ */
+#define CI_FLOW_PARSED_ACTIONS_MAX 4
+
+/* Actions that are reasonably expected to have a conf structure */
+static const enum rte_flow_action_type need_conf[] = {
+	RTE_FLOW_ACTION_TYPE_QUEUE,
+	RTE_FLOW_ACTION_TYPE_RSS,
+	RTE_FLOW_ACTION_TYPE_VF,
+	RTE_FLOW_ACTION_TYPE_PORT_REPRESENTOR,
+	RTE_FLOW_ACTION_TYPE_COUNT,
+	RTE_FLOW_ACTION_TYPE_MARK,
+	RTE_FLOW_ACTION_TYPE_SECURITY,
+	RTE_FLOW_ACTION_TYPE_END
+};
+
+/**
+ * Is action type in this list of action types?
+ */
+__rte_internal
+static inline bool
+ci_flow_action_type_in_list(const enum rte_flow_action_type type,
+		const enum rte_flow_action_type list[])
+{
+	size_t i = 0;
+	while (list[i] != RTE_FLOW_ACTION_TYPE_END) {
+		if (type == list[i])
+			return true;
+		i++;
+	}
+	return false;
+}
+
+/* Forward declarations */
+struct ci_flow_actions;
+struct ci_flow_actions_check_param;
+
+/**
+ * Driver-specific action list validation callback.
+ *
+ * Performs driver-specific validation of action parameter list.
+ * Called after all actions have been parsed and added to the list,
+ * allowing validation based on the complete action set.
+ *
+ * @param actions
+ *   The complete list of parsed actions (for context-dependent validation).
+ * @param driver_ctx
+ *   Opaque driver context (e.g., adapter/queue configuration).
+ * @param error
+ *   Pointer to rte_flow_error for reporting failures.
+ * @return
+ *   0 on success, negative errno on failure.
+ */
+typedef int (*ci_flow_actions_check_fn)(
+	const struct ci_flow_actions *actions,
+	const struct ci_flow_actions_check_param *param,
+	struct rte_flow_error *error);
+
+/**
+ * List of actions that we know we've validated.
+ */
+struct ci_flow_actions {
+	/* Number of actions in the list. */
+	uint8_t count;
+	/* Parsed actions array. */
+	struct rte_flow_action const *actions[CI_FLOW_PARSED_ACTIONS_MAX];
+};
+
+/**
+ * Parameters for action list validation.Any element can be NULL/0 as checks are only performed
+ * against constraints specified.
+ */
+struct ci_flow_actions_check_param {
+	/**
+	 * Driver-specific context pointer (e.g., adapter/queue configuration). Can be NULL.
+	 */
+	void *driver_ctx;
+	/**
+	 * Driver-specific action list validation callback. Can be NULL.
+	 */
+	ci_flow_actions_check_fn check;
+	/**
+	 * Allowed action types for this parse parameter. Must be terminated with
+	 * RTE_FLOW_ACTION_TYPE_END. Can be NULL.
+	 */
+	const enum rte_flow_action_type *allowed_types;
+	size_t max_actions;                 /**< Maximum number of actions allowed. */
+};
+
+static inline int
+__flow_action_check_rss(const struct rte_flow_action_rss *rss, struct rte_flow_error *error)
+{
+	size_t q, q_num = rss->queue_num;
+	if ((q_num == 0) == (rss->queue == NULL)) {
+		return rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
+			"If queue number is specified, queue array must also be specified");
+	}
+	for (q = 1; q < q_num; q++) {
+		uint16_t qi = rss->queue[q];
+		if (rss->queue[q - 1] + 1 != qi) {
+			return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
+				"RSS queues must be contiguous");
+		}
+	}
+	/* either we have both key and key length, or we have neither */
+	if ((rss->key_len == 0) != (rss->key == NULL)) {
+		return rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
+			"If RSS key is specified, key length must also be specified");
+	}
+	return 0;
+}
+
+static inline int
+__flow_action_check_generic(const struct rte_flow_action *action,
+		const struct ci_flow_actions_check_param *param,
+		struct rte_flow_error *error)
+{
+	/* is this action in our allowed list? */
+	if (param != NULL && param->allowed_types != NULL &&
+			!ci_flow_action_type_in_list(action->type, param->allowed_types)) {
+		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+				action, "Unsupported action");
+	}
+	/* do we need to validate presence of conf? */
+	if (ci_flow_action_type_in_list(action->type, need_conf)) {
+		if (action->conf == NULL) {
+			return rte_flow_error_set(error, EINVAL,
+						  RTE_FLOW_ERROR_TYPE_ACTION_CONF, action,
+						  "Action requires configuration");
+		}
+	}
+
+	/* type-specific validation */
+	switch (action->type) {
+	case RTE_FLOW_ACTION_TYPE_RSS:
+	{
+		const struct rte_flow_action_rss *rss =
+				(const struct rte_flow_action_rss *)action->conf;
+		if (__flow_action_check_rss(rss, error) < 0)
+			return -rte_errno;
+		break;
+	}
+	default:
+		/* no specific validation */
+		break;
+	}
+
+	return 0;
+}
+
+/**
+ * Validate and parse a list of rte_flow_action into a parsed action list.
+ *
+ * @param actions pointer to array of rte_flow_action, terminated by RTE_FLOW_ACTION_TYPE_END
+ * @param param pointer to ci_flow_actions_check_param structure (can be NULL)
+ * @param parsed_actions pointer to ci_flow_actions structure to store parsed actions
+ * @param error pointer to rte_flow_error structure for error reporting
+ *
+ * @return 0 on success, negative errno on failure.
+ */
+__rte_internal
+static inline int
+ci_flow_check_actions(const struct rte_flow_action *actions,
+	const struct ci_flow_actions_check_param *param,
+	struct ci_flow_actions *parsed_actions,
+	struct rte_flow_error *error)
+{
+	size_t i = 0;
+
+	if (actions == NULL) {
+		return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+				NULL, "Missing actions");
+	}
+
+	/* reset the list */
+	*parsed_actions = (struct ci_flow_actions){0};
+
+	while (actions[i].type != RTE_FLOW_ACTION_TYPE_END) {
+		const struct rte_flow_action *action = &actions[i++];
+
+		/* skip VOID actions */
+		if (action->type == RTE_FLOW_ACTION_TYPE_VOID)
+			continue;
+
+		/* generic validation for actions - this will check against param as well */
+		if (__flow_action_check_generic(action, param, error) < 0)
+			return -rte_errno;
+
+		/* add action to the list */
+		if (parsed_actions->count >= RTE_DIM(parsed_actions->actions)) {
+			return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+							action, "Too many actions");
+		}
+		/* user may have specified a maximum number of actions */
+		if (param != NULL && param->max_actions != 0 &&
+		    parsed_actions->count >= param->max_actions) {
+			return rte_flow_error_set(error, EINVAL, RTE_FLOW_ERROR_TYPE_ACTION,
+							action, "Too many actions");
+		}
+		parsed_actions->actions[parsed_actions->count++] = action;
+	}
+
+	/* now, call into user validation if specified */
+	if (param != NULL && param->check != NULL) {
+		if (param->check(parsed_actions, param, error) < 0)
+			return -rte_errno;
+	}
+	/* if we didn't parse anything, valid action list is empty */
+	return parsed_actions->count == 0 ? -EINVAL : 0;
+}
+
+#ifdef __cplusplus
+}
+#endif
+
+#endif /* _COMMON_INTEL_FLOW_CHECK_H_ */
-- 
2.47.3

