Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A590CD5BB3
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 15:14:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A91C840665;
	Fri, 22 May 2026 17:14:50 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 83F284003C
 for <dev@dpdk.org>; Fri, 22 May 2026 17:14:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779462887; x=1810998887;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=+GfNBtQX5rHgwl4jjoy4Lkz+f8hh39EsuL7HQE0iroo=;
 b=TGcyUqy/FUuJmpsBA1FwtJv6uc4tElqDD6iKWi1gcp5e8TmH07ysHYOK
 7tVmcGhmo27OC7JHokyRUSkJKy5Bh3w/c1oyi3Avax9XGOV0rpVBJhUS9
 7MixWzjpLnbs8XjaDvImQEc8o+RI97NK+QNXwoyBZTWh+qzU4KoEUIsUd
 4aJ2Dxoln05jlUGfA4dCWChTTfSX7weoIoF7PnVkxdebJQ90eQnvqYxlO
 aBS8vcpSEl8U6GOhgdZXkN3OiYaGB0yxffMwFrlQ5CIJ8Kb4vHoG3i+FY
 P/p9MSAYLqfS3W1Us9W9oQLnCc8FzbhVEvzwezX8uV2JSBeuEnPHTfWj2 Q==;
X-CSE-ConnectionGUID: xBYu++uZT6iTtps09pWmNw==
X-CSE-MsgGUID: Z6ugeD/TSfex1FVQf488Lg==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="97969150"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="97969150"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 08:14:45 -0700
X-CSE-ConnectionGUID: jX/+tvNJQQ+b+Hur/r5Peg==
X-CSE-MsgGUID: Naf6EdpDSbSePKpuUXXAbw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="245213924"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 22 May 2026 08:14:45 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v4 02/26] net/intel/common: add common flow action parsing
Date: Fri, 22 May 2026 16:14:11 +0100
Message-ID: <00d686796ef0440ca63220d468ed3d15ccf4894a.1779462699.git.anatoly.burakov@intel.com>
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

While we're at it, also add logging infrastructure for Intel common code,
using the new component name defines that are automatically passed to each
DPDK driver as it is being built.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/common/flow_check.h | 278 ++++++++++++++++++++++++++
 drivers/net/intel/common/log.h        |  40 ++++
 2 files changed, 318 insertions(+)
 create mode 100644 drivers/net/intel/common/flow_check.h
 create mode 100644 drivers/net/intel/common/log.h

diff --git a/drivers/net/intel/common/flow_check.h b/drivers/net/intel/common/flow_check.h
new file mode 100644
index 0000000000..74fb28ae3d
--- /dev/null
+++ b/drivers/net/intel/common/flow_check.h
@@ -0,0 +1,278 @@
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
+#include "log.h"
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
+static inline const char *
+ci_flow_action_type_to_str(enum rte_flow_action_type type)
+{
+	const char *name = NULL;
+	int ret;
+
+	ret = rte_flow_conv(RTE_FLOW_CONV_OP_ACTION_NAME_PTR,
+			&name, sizeof(name), (const void *)(uintptr_t)type, NULL);
+	if (ret < 0 || name == NULL)
+		return "UNKNOWN";
+
+	return name;
+}
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
+typedef int (*ci_flow_actions_check_fn)(const struct ci_flow_actions *actions,
+		const struct ci_flow_actions_check_param *param,
+		struct rte_flow_error *error);
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
+ * Parameters for action list validation. Any element can be NULL/0 as checks are only performed
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
+	bool rss_queues_contig;             /**< If true, RSS queues must be contiguous. */
+};
+
+static inline int
+__flow_action_check_rss(const struct rte_flow_action_rss *rss,
+		const struct ci_flow_actions_check_param *param,
+		struct rte_flow_error *error)
+{
+	uint32_t qnum, q;
+
+	qnum = rss->queue_num;
+
+	/* either we have both queues and queue number, or we have neither */
+	if ((qnum == 0) != (rss->queue == NULL)) {
+		return rte_flow_error_set(error, EINVAL,
+			RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
+			"If queue number is specified, queue array must also be specified");
+	}
+	/* check if queues are monotonic */
+	for (q = 1; q < qnum; q++) {
+		if (rss->queue[q] < rss->queue[q - 1]) {
+			return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
+				"RSS queues must be in ascending order");
+		}
+		/* if user has requested contiguousness, check that as well */
+		if (param == NULL || !param->rss_queues_contig)
+			continue;
+		if (rss->queue[q] != rss->queue[0] + q) {
+			return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION_CONF, rss,
+				"RSS queues must be contiguous");
+		}
+	}
+	/* if user has requested to check for queue contiguousness, do it */
+	if (param != NULL && param->rss_queues_contig) {
+	}
+
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
+		int ret;
+
+		ret = __flow_action_check_rss(rss, param, error);
+		if (ret < 0)
+			return ret;
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
+static inline int
+ci_flow_check_actions(const struct rte_flow_action *actions,
+	const struct ci_flow_actions_check_param *param,
+	struct ci_flow_actions *parsed_actions,
+	struct rte_flow_error *error)
+{
+	size_t i = 0;
+	int ret;
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
+		ret = __flow_action_check_generic(action, param, error);
+		if (ret < 0)
+			return ret;
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
+		CI_DRV_LOG(DEBUG, "Parsed action %u: type=%s", parsed_actions->count,
+			   ci_flow_action_type_to_str(action->type));
+		parsed_actions->actions[parsed_actions->count++] = action;
+	}
+
+	/* now, call into user validation if specified */
+	if (param != NULL && param->check != NULL) {
+		ret = param->check(parsed_actions, param, error);
+		if (ret < 0)
+			return ret;
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
diff --git a/drivers/net/intel/common/log.h b/drivers/net/intel/common/log.h
new file mode 100644
index 0000000000..d99e4d1a37
--- /dev/null
+++ b/drivers/net/intel/common/log.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Intel Corporation
+ */
+
+#ifndef _COMMON_INTEL_LOG_H_
+#define _COMMON_INTEL_LOG_H_
+
+#include <rte_log.h>
+
+/*
+ * Common logging for shared Intel driver code.
+ *
+ * This header must only be included from driver translation units, where the
+ * build system has already defined RTE_COMPONENT_NAME (e.g. "iavf"). It uses
+ * that token to reference the per-driver logtype variable that every Intel
+ * driver registers (e.g. iavf_logtype_driver), so no additional setup is
+ * needed beyond what each driver already provides.
+ *
+ * Usage: CI_DRV_LOG(DEBUG, "format %s", arg);
+ */
+
+#ifndef RTE_COMPONENT_NAME
+/* CI_DRV_LOG is a no-op when included outside a driver build context. */
+#define CI_DRV_LOG(level, fmt, ...) do { } while (0)
+#else /* RTE_COMPONENT_NAME */
+
+/* Resolves to the per-driver logtype variable, e.g. iavf_logtype_driver. */
+#define CI_DRV_LOGTYPE RTE_CONCAT(RTE_COMPONENT_NAME, _logtype_driver)
+
+/* Forward-declare the logtype so shared headers need not include driver headers. */
+extern int CI_DRV_LOGTYPE;
+
+#define CI_DRV_LOG(level, fmt, ...) \
+	rte_log(RTE_LOG_##level, CI_DRV_LOGTYPE, \
+		"PMD_INTEL_COMMON: %s(): " fmt "\n", \
+		__func__, ##__VA_ARGS__)
+
+#endif /* RTE_COMPONENT_NAME */
+
+#endif /* _COMMON_INTEL_LOG_H_ */
-- 
2.47.3

