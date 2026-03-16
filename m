Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8C70F4644A
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 10:55:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 02B8140B9E;
	Mon, 16 Mar 2026 11:53:24 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id DCF9840A79
 for <dev@dpdk.org>; Mon, 16 Mar 2026 11:53:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773658399; x=1805194399;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=9sp3XSLf1E5vdAuuNIlUubyj5fZB1ihhHWtVVufG3i4=;
 b=PSqeLqw57KVf364TADPHvQHaIe3sdYcFkophs4UQmi0vByb7g06pnoAv
 a88tH01Rzc9A0w9KiP1EyBjZ5KTxZgELIKB/j23iEnQIraDwEMzc9HW8R
 k2UGnQY98a4wTb59k9EafiZRFa20GAluZxqOqZ8kGqbDRUsKHdG8dGFOf
 n655hWyTcGyfpKNKWAbG5NKhKChbzCwEtgBGALGtqOYMspSCVbYQ8+jl9
 8gC0//VKPEVZJm7jvuYhJx0RSp5QX8DNRh9jeCFGaJK0OjM5QeJRo7Osk
 Z1MIN6oMKFvZOMXQFxQX+6dYbN9BVfelPD0ifM+ajF7ECaudkLEPZCYhB A==;
X-CSE-ConnectionGUID: rSDQRC9kQGeMQhoYRFY0RQ==
X-CSE-MsgGUID: ybcgarvxT6WIHIutFPvclA==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="62237439"
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="62237439"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 03:53:19 -0700
X-CSE-ConnectionGUID: IPycw7S7Qu2qyB33YmG0aw==
X-CSE-MsgGUID: p0h67MV+QRmXCWsGrhEOaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,124,1770624000"; d="scan'208";a="221826796"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa009.jf.intel.com with ESMTP; 16 Mar 2026 03:53:18 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v2 20/25] net/iavf: use common action checks for flow query
Date: Mon, 16 Mar 2026 10:52:45 +0000
Message-ID: <180c85801955430ffef665f5b33d3882b117e53b.1773658290.git.anatoly.burakov@intel.com>
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

Use the common flow parsing infrastructure to validate query actions.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_generic_flow.c | 29 ++++++++++------------
 1 file changed, 13 insertions(+), 16 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_generic_flow.c b/drivers/net/intel/iavf/iavf_generic_flow.c
index 022caf5fe2..9fc19576cd 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.c
+++ b/drivers/net/intel/iavf/iavf_generic_flow.c
@@ -17,6 +17,7 @@
 
 #include "iavf.h"
 #include "iavf_generic_flow.h"
+#include "../common/flow_check.h"
 
 static struct iavf_engine_list engine_list =
 		TAILQ_HEAD_INITIALIZER(engine_list);
@@ -2332,7 +2333,14 @@ iavf_flow_query(struct rte_eth_dev *dev,
 		void *data,
 		struct rte_flow_error *error)
 {
-	int ret = -EINVAL;
+	struct ci_flow_actions parsed_actions = {0};
+	struct ci_flow_actions_check_param param = {
+		.allowed_types = (enum rte_flow_action_type[]) {
+			RTE_FLOW_ACTION_TYPE_COUNT,
+			RTE_FLOW_ACTION_TYPE_END
+		},
+		.max_actions = 1
+	};
 	struct iavf_adapter *ad =
 		IAVF_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
 	struct rte_flow_query_count *count = data;
@@ -2344,19 +2352,8 @@ iavf_flow_query(struct rte_eth_dev *dev,
 		return -rte_errno;
 	}
 
-	for (; actions->type != RTE_FLOW_ACTION_TYPE_END; actions++) {
-		switch (actions->type) {
-		case RTE_FLOW_ACTION_TYPE_VOID:
-			break;
-		case RTE_FLOW_ACTION_TYPE_COUNT:
-			ret = flow->engine->query_count(ad, flow, count, error);
-			break;
-		default:
-			return rte_flow_error_set(error, ENOTSUP,
-					RTE_FLOW_ERROR_TYPE_ACTION,
-					actions,
-					"action not supported");
-		}
-	}
-	return ret;
+	if (ci_flow_check_actions(actions, &param, &parsed_actions, error) < 0)
+		return -rte_errno;
+
+	return flow->engine->query_count(ad, flow, count, error);
 }
-- 
2.47.3

