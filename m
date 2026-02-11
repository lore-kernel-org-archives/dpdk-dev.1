Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 185C2E9E310
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 14:23:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4D27140E21;
	Wed, 11 Feb 2026 15:21:29 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
 by mails.dpdk.org (Postfix) with ESMTP id 1F39140A7F
 for <dev@dpdk.org>; Wed, 11 Feb 2026 15:21:24 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1770819687; x=1802355687;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=9sp3XSLf1E5vdAuuNIlUubyj5fZB1ihhHWtVVufG3i4=;
 b=hLBfyCEg2PF2p7o98U8afWeci483/5US2L2d0+3WFIo5AhPZkjLSRAJQ
 IMy69d/G9uLTo/EfqeBfRQ+kkXkJUIDsjKOdEgLUmFuEHV11IaH6VpO8R
 I2iMcpOduzjb+RdqdddAmpzUmoS7utheXwieecABJteNLJ53WZAnbJE0q
 mswk96aBFRrrrN8xbsZK0q4jZr8GLEgbPN8ig4t2ib2L6b9sB05cestUf
 nhYzgNyfKUjyjLen2ZYuu0QQzO3dC3ktwCjSVs0B+kTzwvA2ylWGpFwVp
 xv1+urgExCHKCBGuKd/+1+wFNSuXhNLasIJthrGv0Rfr0hu7LFxqPLx3E A==;
X-CSE-ConnectionGUID: 0UiUoVU4SLGNUZqOKfjvEA==
X-CSE-MsgGUID: SeCtucrtSdq8h4M74V++Tg==
X-IronPort-AV: E=McAfee;i="6800,10657,11698"; a="71866789"
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="71866789"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 11 Feb 2026 06:21:23 -0800
X-CSE-ConnectionGUID: 43o3IF7MSo+KiVsxsfBsig==
X-CSE-MsgGUID: vnrcmW4ERfSN0GFYRx00nA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,283,1763452800"; d="scan'208";a="211569227"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa010.jf.intel.com with ESMTP; 11 Feb 2026 06:21:23 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v1 20/25] net/iavf: use common action checks for flow query
Date: Wed, 11 Feb 2026 14:20:37 +0000
Message-ID: <c129e0967eab5126e20f0d0ba7b4c115f3f5898c.1770819434.git.anatoly.burakov@intel.com>
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

