Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6039FCD5BB3
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 May 2026 15:16:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D0DD40DFB;
	Fri, 22 May 2026 17:15:11 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
 by mails.dpdk.org (Postfix) with ESMTP id 1AE2A40A4B
 for <dev@dpdk.org>; Fri, 22 May 2026 17:15:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779462908; x=1810998908;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=mQ2Ps3uujKk5YW9EpnGTwciVERiqm6hG3AYZmnYnoJw=;
 b=CUMErFr0bx0N7Y5eXah8ZPG75qm3Z17QBqXM50LkjT5feNef6Zreb+2c
 HfalJz3f7MMEo6MKMdA5P6P72tnkMahItqTtSoDGORUs2YnSf8Pd/uze5
 WYTtDNgL49SMIHVkDU/7nyFXqc91NKgYn9tC5fSbibw43hK1KwA4F/j9j
 V+72Psrhrx67jQecGyInuA4tztHchIMgFsszD3CfQqs+rZSMKM6M2GgI1
 YifyUE6epKI6FipOOvMv2S80UnMfPUU1QLUaacDRvR3XsaY8yQ51DEfxN
 aVmKT8sh0Lb+UVEevur9Djwx8/ZPuGMSx59YwkSAkGblYxHtxCsYy7oCS g==;
X-CSE-ConnectionGUID: vamhbKYlQI+yV/drpRFM8Q==
X-CSE-MsgGUID: Zc6I2lDaRDW4wncJQ69eGQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11794"; a="97969179"
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="97969179"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 22 May 2026 08:15:08 -0700
X-CSE-ConnectionGUID: ax1IeSkAT4Op75HzsEGmJA==
X-CSE-MsgGUID: vt/bPlVNT9eFkVF0COeChw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,162,1774335600"; d="scan'208";a="245214052"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa004.jf.intel.com with ESMTP; 22 May 2026 08:15:08 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Subject: [PATCH v4 21/26] net/iavf: use common action checks for flow query
Date: Fri, 22 May 2026 16:14:30 +0100
Message-ID: <26f11c97e87484a5581bc5a4a5f2b66c99de2935.1779462699.git.anatoly.burakov@intel.com>
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

Use the common flow parsing infrastructure to validate query actions.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_generic_flow.c | 33 +++++++++++-----------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_generic_flow.c b/drivers/net/intel/iavf/iavf_generic_flow.c
index 7ebfa70490..8bd874c32a 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.c
+++ b/drivers/net/intel/iavf/iavf_generic_flow.c
@@ -14,10 +14,11 @@
 #include <ethdev_driver.h>
 #include <rte_malloc.h>
 #include <rte_tailq.h>
+#include <rte_hexdump.h>
 
 #include "iavf.h"
 #include "iavf_generic_flow.h"
-#include <rte_hexdump.h>
+#include "../common/flow_check.h"
 
 static struct iavf_engine_list engine_list =
 		TAILQ_HEAD_INITIALIZER(engine_list);
@@ -2338,10 +2339,18 @@ iavf_flow_query(struct rte_eth_dev *dev,
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
@@ -2350,21 +2359,11 @@ iavf_flow_query(struct rte_eth_dev *dev,
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
 
 #define IAVF_FLOW_DUMP_CHUNK_BYTES 32
-- 
2.47.3

