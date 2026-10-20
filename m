Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59102606A31E
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=C831wU8d
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5B6A740696;
	Tue, 20 Oct 2026 11:11:47 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 53D4240609
 for <dev@dpdk.org>; Tue, 20 Oct 2026 11:11:44 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792487505; x=1824023505;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=z+SJtEwss+FaqfSNLsPu6z+KCT9z743Yiq6Kr/iL3Qk=;
 b=C831wU8dFNWhm1YCObgCXSPogpRxuMc+CZLdq0Yup+h5pkJYZQ1oDC/P
 XQCqP6Ra46tOgYXMBGorcXj5FNTJ53FgMEBmTvjsgAuIhhjQhYRrQfMBu
 uQM5HWz9DtSloIzVS/Xf6wnYwWtGQAWoWfjzDhlJ8RbfeJT7TLD9TCZ8M
 F7mp1GMb/UULXKgLRF0OIC0Gsw9t4NEKp6s+6+GE6WJoD8F2L7Dtpx9WM
 po/GADbVUfvhsHd6uJFe0/Pg9PACBIyJjVt/fdfWOR6NyZUYc6ZJQaJb2
 hnpb4gfF2NqCdzGpLeSHFg/Z8x8qwjNYU+IJIEpp1/Cp7w7nKIISfS3Gx A==;
X-CSE-ConnectionGUID: piRKkt6tSQe4EcuzVljJvA==
X-CSE-MsgGUID: W6o5m+G9Sfa1qfpMtwHvSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1286810"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1286810"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 02:11:44 -0700
X-CSE-ConnectionGUID: lbHJjQ2cSbmXIjBJ4X92cw==
X-CSE-MsgGUID: wt0m52wVQfOoOVYOydsBlA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2879455"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa002.fm.intel.com with ESMTP; 20 Oct 2026 02:11:43 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>, Qiming Yang <qiming.yang@intel.com>
Subject: [PATCH v3 05/10] net/iavf: fix generic flow error-path leaks
Date: Tue, 20 Oct 2026 10:11:28 +0100
Message-ID: <c39029e34866c6c4d516429a31aa930aa9c85183.1792487374.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792487374.git.anatoly.burakov@intel.com>
 <cover.1792487374.git.anatoly.burakov@intel.com>
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
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
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

