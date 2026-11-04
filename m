Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6BBF606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=ZYidt+Lf
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E23104060F;
	Wed,  4 Nov 2026 15:26:04 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
 by mails.dpdk.org (Postfix) with ESMTPS id 7AE9140281
 for <dev@dpdk.org>; Wed,  4 Nov 2026 15:26:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1793802364; x=1825338364;
 h=from:to:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=2s3gbi1sRp3RL/zuX324eLqhUurqKuumVTAmRXb4Lsc=;
 b=ZYidt+Lf/5lzj4lrzTtR6bnnT8GZHqBOTfiPXu3RDHvkRuJWRgBK69r7
 UIiAd4P7l96jhUU37wHnQVy+mc4DCQPD0EIqZhRKOPPjutqX0uzGwaoDD
 D+kCGVENsMn/fvzLp0A0gcBcDUvFZVKw5cT+NCLgBuhG5YWh2kSb5AsEW
 VieCuuUrLV6m5T7e/EM1WERHA4diU3VcKXbHFXsk18D9yhgyIwYaieqq6
 AzyexYgV7rlaTWizjSRM/V7MjXF25LxnJj05zC+yIHVUSo8DjJEH9eNPJ
 Qm5P7F2z878U6Zgx3joU3i7zh8/Uqtq/a95WPmvqAnutN4JOc47H7dye6 g==;
X-CSE-ConnectionGUID: fPIoVkO3QveU/lRGDJdqvQ==
X-CSE-MsgGUID: 6nfB8eJfSjyJStn9M/5cnA==
X-IronPort-AV: E=McAfee;i="6800,10657,11955"; a="2589195"
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="2589195"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 04 Nov 2026 06:26:01 -0800
X-CSE-ConnectionGUID: mNsT9fhqRoCI6wMzdv1HZA==
X-CSE-MsgGUID: Du60zzFSTGWUfvHv8VbUDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,195,1787036400"; 
   d="scan'208";a="7050192"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa008.fm.intel.com with ESMTP; 04 Nov 2026 06:26:00 -0800
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v1 1/1] net/iavf: allow flow validation without engine callback
Date: Wed,  4 Nov 2026 14:25:57 +0000
Message-ID: <aaa8fe49c638adcc493263de206dc5c9f9c22803.1793802348.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Some engines do not implement a validation callback. Rejecting these
engines after successful pattern and action parsing prevents their flows
from passing validation.

Fix the validation function to treat successful parsing as sufficient when
no validation callback is provided.

Fixes: fae5ce5de601 ("net/iavf: fix false success on flow validation")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_generic_flow.c | 13 +++----------
 1 file changed, 3 insertions(+), 10 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_generic_flow.c b/drivers/net/intel/iavf/iavf_generic_flow.c
index be7ddf5db63..1ebab3ddefe 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.c
+++ b/drivers/net/intel/iavf/iavf_generic_flow.c
@@ -2148,16 +2148,9 @@ iavf_parse_engine_validate(struct iavf_adapter *ad,
 			continue;
 
 		engine = parser_node->parser->engine;
-		if (engine->validation == NULL) {
-			rte_free(meta);
-			meta = NULL;
-			rte_flow_error_set(error, EINVAL,
-				RTE_FLOW_ERROR_TYPE_HANDLE,
-				NULL, "Validation not support");
-			continue;
-		}
-
-		ret = engine->validation(ad, flow, meta, error);
+		ret = 0;
+		if (engine->validation != NULL)
+			ret = engine->validation(ad, flow, meta, error);
 		rte_free(meta);
 		meta = NULL;
 		if (ret != 0) {
-- 
2.52.0

