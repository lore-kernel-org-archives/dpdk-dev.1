Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB314606A31D
	for <dpdk-dev@archiver.kernel.org>; Fri, 23 Oct 2026 09:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=lU3+SMts
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8614840696;
	Fri, 23 Oct 2026 11:32:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id 5093840678
 for <dev@dpdk.org>; Fri, 23 Oct 2026 11:32:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792747966; x=1824283966;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=f/vpZ4FvWxVNd2wf8xe4f2mQIQ7x0aPorh+pwziDg7s=;
 b=lU3+SMtsgoEMpQ5O/tL4+bgW8wBjrGi70KRTszYARiJHmUuYJEwKW6l0
 XCnkjEkHRI9It0msWz4RsifTvLzKFclnUrr0+cymz5gVmrptbd+2gW6Kd
 Heu7Z2Po5lw8XnIa3Q0F3kzuBWLgQwDH2y5yxN/l6h/F0f8LwzMvV1jcW
 KRjXWoYRS/moeSPICuwANbdZz7a+uA/oKgEdv4V/RGzxD/TFReR0n4XMM
 kE5471vKGPp/3CAtgSkBk7xxVqLbJQuDknsmIi5cpcA9QIdiRYp5alWd0
 CKmCMv65bKzij+jkqGETyQmIeyIQbIH0M+2XPavtAGTQRz/P0J2wEEIfd g==;
X-CSE-ConnectionGUID: OMd8Nt4NRNCsixNk433x0g==
X-CSE-MsgGUID: 2vL3lSXbTEWquAzfRCH0AA==
X-IronPort-AV: E=McAfee;i="6800,10657,11943"; a="1498276"
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="1498276"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 23 Oct 2026 02:32:45 -0700
X-CSE-ConnectionGUID: XKtwfCWRQT2u6VD+S0h2lg==
X-CSE-MsgGUID: KdqV37GJRFqtrNH3XCoouw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,174,1787036400"; 
   d="scan'208";a="3509475"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa003.jf.intel.com with ESMTP; 23 Oct 2026 02:32:44 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Qi Zhang <qi.z.zhang@intel.com>, Qiming Yang <qiming.yang@intel.com>
Subject: [PATCH v5 05/10] net/iavf: fix generic flow error-path leaks
Date: Fri, 23 Oct 2026 10:32:25 +0100
Message-ID: <e573f90a7fe1c880d29e04ac7b35b524b0665da1.1792747917.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <cover.1792747916.git.anatoly.burakov@intel.com>
 <cover.1792747916.git.anatoly.burakov@intel.com>
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
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
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

