Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC3DCC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:19:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA82E40E09;
	Wed, 14 Oct 2026 17:19:34 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id 0B91940B94
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:19:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791991173; x=1823527173;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=2XXKCo9j0C1SyVORw3YS+H9/QL6Mwoeeb94YFfzu3mM=;
 b=CaYqK7JOg9FJ2a5PhSrcGLycvstInsOKmMCQuMzvl2YeSGB5gMljMaVS
 QSMeHzb9Bb0vCCVUsHp2eAk6pa7npMJSvlkS/HtRIAbbg9Bsz7b/Y1Pvh
 +PbOYBMVpDnTPJiX3LVLL64WiawhgtHhO2iAb76jWHokZulVhUyrt6rAY
 aNpMTa5LopWQNXN3b3DThDWXaWBjSWjfaKEoqTjMzVsXJTIXka6F0PF6J
 GFlXnx7R54N+n08tFWKgtWBUO5oyeetLmuOGCUbCiQB1S2vIDkPcNUYfO
 ucwLp7tKGi9qS9dbcXkRz3JLCzvhhwhVjwsrrA1n6ymNPVSILpLlGVIp0 A==;
X-CSE-ConnectionGUID: owBruZPqSae1GGo+Vias8Q==
X-CSE-MsgGUID: qkK6VJ+LSdCXRImLmtxxsw==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="646299"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="646299"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 08:19:05 -0700
X-CSE-ConnectionGUID: tMtI59rMTZKvm+ovDiR8IQ==
X-CSE-MsgGUID: u+6HXMDFQwyU/E1ZC5ld2Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="3294637"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa011.fm.intel.com with ESMTP; 14 Oct 2026 08:19:03 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 3/7] net/iavf: fix generic flow error-path leaks
Date: Wed, 14 Oct 2026 16:18:46 +0100
Message-ID: <a1eb5386ae5cd5d6dd36dd6f6ff8fdb6a6c60b20.1791991100.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1791991100.git.anatoly.burakov@intel.com>
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

If a flow engine fails to initialize, parsers registered by earlier
engines remain allocated. Pattern matching also leaks its item array
when allocation of the match result fails.

Unwind registered parsers on flow initialization failure and free the
item array on match-result allocation failure.

Fixes: ff2d0c345c3b ("net/iavf: support generic flow API")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_generic_flow.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_generic_flow.c b/drivers/net/intel/iavf/iavf_generic_flow.c
index 5759381b8ff..15ed41db065 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.c
+++ b/drivers/net/intel/iavf/iavf_generic_flow.c
@@ -1821,17 +1821,22 @@ iavf_flow_init(struct iavf_adapter *ad)
 		if (engine->init == NULL) {
 			PMD_INIT_LOG(ERR, "Invalid engine type (%d)",
 				     engine->type);
-			return -ENOTSUP;
+			ret = -ENOTSUP;
+			goto err;
 		}
 
 		ret = engine->init(ad);
 		if (ret && ret != -ENOTSUP) {
 			PMD_INIT_LOG(ERR, "Failed to initialize engine %d",
 				     engine->type);
-			return ret;
+			goto err;
 		}
 	}
 	return 0;
+
+err:
+	iavf_flow_uninit(ad);
+	return ret;
 }
 
 void
@@ -2048,6 +2053,7 @@ iavf_search_pattern_match_item(const struct rte_flow_item pattern[],
 	if (!pattern_match_item) {
 		rte_flow_error_set(error, ENOMEM, RTE_FLOW_ERROR_TYPE_HANDLE,
 				   NULL, "Failed to allocate memory.");
+		rte_free(items);
 		return NULL;
 	}
 
-- 
2.52.0

