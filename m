Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CE1606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 14:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=RNwnH8Rg
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D84F6406BC;
	Wed, 21 Oct 2026 16:26:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
 by mails.dpdk.org (Postfix) with ESMTP id 3065840679
 for <dev@dpdk.org>; Wed, 21 Oct 2026 16:26:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792592777; x=1824128777;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=t2Y2UFEEEhG43/GO3bh94zPuiBry+oJaxVkLIOHTrdk=;
 b=RNwnH8Rg/u9+78xboBEK6rSffMtdJJbgtFKV8CPPpXpFUsk07gS6nP3y
 H5Nl5ihF7wpFDH8YamFDOuJJmaZvy2Nr7npyPQaG7wmuphRbvcXrzsImt
 2KigF6esI/m+Uh9BEnTPwUEqTs71xz2aLC40NzyijqMRp47IPabaT7NVk
 xG+d4XHmKbgG3b5FFk3sguS+idWgi2KY8B2Qu8YdD8gnA/tu1qe/9RTo/
 bT2+EutZazR4Tcxvv0yZ2HVQGUpJ31zaax5gO7Pk05h2nm8fdVwnybVE1
 ZgR8BrJM13nj54udbpPqhNzx8BXcewhhYGxJiS6QyfUljBjgCZ2H8p1ak Q==;
X-CSE-ConnectionGUID: H253tfSqRFOskAbdELzfKA==
X-CSE-MsgGUID: RlzLPA2GQSmNc6jhtZnCdw==
X-IronPort-AV: E=McAfee;i="6800,10657,11942"; a="1192932"
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="1192932"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
 by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Oct 2026 07:26:16 -0700
X-CSE-ConnectionGUID: mNaIma8gSlqy+P5OEpfT7A==
X-CSE-MsgGUID: E3L2s8GOQrq/41SBS6hHaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,170,1787036400"; 
   d="scan'208";a="3570531"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa010.fm.intel.com with ESMTP; 21 Oct 2026 07:26:15 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>, Qiming Yang <qiming.yang@intel.com>
Subject: [PATCH v4 05/10] net/iavf: fix generic flow error-path leaks
Date: Wed, 21 Oct 2026 15:25:45 +0100
Message-ID: <d3514bf9087c4d9477937c885cb5c4352de642ec.1792592724.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792592724.git.anatoly.burakov@intel.com>
 <cover.1792592724.git.anatoly.burakov@intel.com>
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
index 14242e6ebbb..cd4d4a012b1 100644
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

