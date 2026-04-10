Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A49AF4485A
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Apr 2026 13:23:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5AD34067D;
	Fri, 10 Apr 2026 15:22:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
 by mails.dpdk.org (Postfix) with ESMTP id 49FFC402AF
 for <dev@dpdk.org>; Fri, 10 Apr 2026 15:22:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1775827375; x=1807363375;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=7CQlA6yVDRsP3i9IF1aZwkbMRrC4Yaa2EZ1eo7iTYfE=;
 b=dOMqubzV/IbrcNVauFIkme/LdoRknfFEyEht3BY1dmjZ5ZqTMAh/yvWi
 +7rYeYkN+XBaALXuuWqktrLAF5YZrx0+gscr1u0nhuMnpXZ+N3AlOtV5/
 e2ZgDA8dIUw5I1OjykwcUsjVPk/gH7j3IvUlgotzinmuGRcJrj0Lzn83P
 nM0MpmO9hKE2lTVJwlWCK/iBF0At4BFlq6K6zwbpC1xTxlDMWpVVYMLNA
 j+6zeuI90/RSolU8/bW1PaawqkfZN4nXKHB+gjf0lIUw0EQLFi74aUBEj
 PeO5pjV4hJX4V1v4E1tKvAFyyWGwV4jRgIEjRTkLyGSc1D2wzlOTbTrFy w==;
X-CSE-ConnectionGUID: C0w+Qt49Qo+8Uw5Kmnp68w==
X-CSE-MsgGUID: yRdX4ZvGTmihplV1ePDwvw==
X-IronPort-AV: E=McAfee;i="6800,10657,11754"; a="76753665"
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="76753665"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Apr 2026 06:22:53 -0700
X-CSE-ConnectionGUID: G2HroQbXQEKv8ApcFKcbFA==
X-CSE-MsgGUID: sgMjGRXgSzWh2KWMbXf5dQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,171,1770624000"; d="scan'208";a="252451107"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa001.fm.intel.com with ESMTP; 10 Apr 2026 06:22:52 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v3 24/29] net/iavf: use common action checks for flow query
Date: Fri, 10 Apr 2026 14:22:44 +0100
Message-ID: <5bfd67c8b4514ca2843525196eab734b29ef04af.1775826526.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cover.1775826526.git.anatoly.burakov@intel.com>
 <cover.1775826526.git.anatoly.burakov@intel.com>
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
 drivers/net/intel/iavf/iavf_generic_flow.c | 31 +++++++++++-----------
 1 file changed, 15 insertions(+), 16 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_generic_flow.c b/drivers/net/intel/iavf/iavf_generic_flow.c
index 022caf5fe2..8925449a5e 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.c
+++ b/drivers/net/intel/iavf/iavf_generic_flow.c
@@ -17,6 +17,7 @@
 
 #include "iavf.h"
 #include "iavf_generic_flow.h"
+#include "../common/flow_check.h"
 
 static struct iavf_engine_list engine_list =
 		TAILQ_HEAD_INITIALIZER(engine_list);
@@ -2332,10 +2333,18 @@ iavf_flow_query(struct rte_eth_dev *dev,
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
+	int ret;
 
 	if (!iavf_flow_is_valid(flow) || !flow->engine->query_count) {
 		rte_flow_error_set(error, EINVAL,
@@ -2344,19 +2353,9 @@ iavf_flow_query(struct rte_eth_dev *dev,
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
+	ret = ci_flow_check_actions(actions, &param, &parsed_actions, error);
+	if (ret < 0)
+		return ret;
+
+	return flow->engine->query_count(ad, flow, count, error);
 }
-- 
2.47.3

