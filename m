Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AECC608340E
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=bhd2jYOR
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D4A7D40A70;
	Mon, 19 Oct 2026 17:06:45 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
 by mails.dpdk.org (Postfix) with ESMTP id C484940698
 for <dev@dpdk.org>; Mon, 19 Oct 2026 17:06:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792422401; x=1823958401;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=z+SJtEwss+FaqfSNLsPu6z+KCT9z743Yiq6Kr/iL3Qk=;
 b=bhd2jYORNbrR0mbrHRc2Uhd7EENuR7j68dt57jWrzLPZuoim8g0z3qgc
 vL2vxeS1sdBmmAHCmnVCED9JEhJPGLFUSSa9dJacbQDSsYUZcboFbqEO5
 Yf8NGOXNuG5Ebng3bORDPjkNTG/unwyqqU5hFkaGwqsy5SEI1d1TMS9Wn
 q/F+Kmd74DE/N+ptCF2OGuU9uzwQa6gytugxmnMSn2fpMt7uf7T54wfMC
 zoyV7vy8wDgDUE5ayOXxRltqH7mW9CsoH1liA5NEGEuE9P1SrlPpMctBC
 gcIx4z2dxYjQ53FSCOgNyYp8M92FnY6tYvd3trtu26syL96D749aqtQue A==;
X-CSE-ConnectionGUID: zW9RiEg9RyuCT/01W0YPYA==
X-CSE-MsgGUID: 5+QKotL9Rv+o8RhptBJ+LA==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1132177"
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="1132177"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
 by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Oct 2026 08:06:41 -0700
X-CSE-ConnectionGUID: CgRKz6Y/SnC1yCW9dzZRhQ==
X-CSE-MsgGUID: Snkx25ubRiSPJJHf4NPxZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,167,1787036400"; 
   d="scan'208";a="4319748"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa012.fm.intel.com with ESMTP; 19 Oct 2026 08:06:39 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Qiming Yang <qiming.yang@intel.com>, Qi Zhang <qi.z.zhang@intel.com>
Subject: [PATCH v2 6/9] net/iavf: fix generic flow error-path leaks
Date: Mon, 19 Oct 2026 16:06:25 +0100
Message-ID: <311a35563ce7cc8bbd5561398c1e429f80081b82.1792422213.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792422213.git.anatoly.burakov@intel.com>
 <cover.1792422213.git.anatoly.burakov@intel.com>
References: 
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
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_BLOCKED,RCVD_IN_ZEN_BLOCKED_OPENDNS,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
index 14242e6ebb..cd4d4a012b 100644
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
@@ -2047,6 +2052,7 @@ iavf_search_pattern_match_item(const struct rte_flow_item pattern[],
 	if (!pattern_match_item) {
 		rte_flow_error_set(error, ENOMEM, RTE_FLOW_ERROR_TYPE_HANDLE,
 				   NULL, "Failed to allocate memory.");
+		rte_free(items);
 		return NULL;
 	}
 
-- 
2.52.0

