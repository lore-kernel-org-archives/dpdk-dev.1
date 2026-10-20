Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB534606A31E
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 Oct 2026 09:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=VUr6/KKi
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A27940A87;
	Tue, 20 Oct 2026 11:11:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id 9C88B406BA
 for <dev@dpdk.org>; Tue, 20 Oct 2026 11:11:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1792487512; x=1824023512;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=4fSedA4qDvJdIRYAqvaV6mFCIo2Cbl4PleFjwg4mz0I=;
 b=VUr6/KKi6h7Y3kKcgzSa56uI7zpPJkK+smt9BxciQb8lWMdNjFAZJINq
 5OLH/3XvIBAItPlnosdLiaAflUslmAlh47KxSVaTs7sxryTtGUlhIoKc4
 nwAf8TqcXo1ibKm+5KH+LLlWhkU22mW3AkZhbBKbFU3MJnll5DE+TVnOH
 Cw1XXV9DoTK/+YgST8d+EwgiDQmSoxFy1cJWCtj83lBZDNFE4v6OcYKhG
 tObFNOdZEwk5OScKAB3qG09ACCaO+67hV7UJ3JtDZSLqeBXvILaryFvFa
 m3MvXbRTwNd/QxcFfdPMb6hkSxaLzuYCz4b32+C5Z8EMPMSdxBHIOysB2 A==;
X-CSE-ConnectionGUID: opvS8CjoRwWKQGi16H9Org==
X-CSE-MsgGUID: pRkYXd3ZSNWANegIrtfqPg==
X-IronPort-AV: E=McAfee;i="6800,10657,11940"; a="1286822"
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="1286822"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 Oct 2026 02:11:52 -0700
X-CSE-ConnectionGUID: pjaiCRBQQZW9eBiPREYefA==
X-CSE-MsgGUID: ejK9ZHb4Ruqy8m99YIBBNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,168,1787036400"; 
   d="scan'208";a="2879474"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa002.fm.intel.com with ESMTP; 20 Oct 2026 02:11:50 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org, Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
 Abhijit Sinha <abhijit.sinha@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>, Radu Nicolau <radu.nicolau@intel.com>,
 Declan Doherty <declan.doherty@intel.com>
Subject: [PATCH v3 10/10] net/iavf: fix IPsec flow metadata leaks
Date: Tue, 20 Oct 2026 10:11:33 +0100
Message-ID: <604dfd252f6979b9cdeb205175e5891b6e9fd665.1792487374.git.anatoly.burakov@intel.com>
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

IPsec flow parsing leaves the pattern-match item allocated after
extracting its metadata. It also leaves the parsed flow item allocated
when no metadata output is requested.

Free the pattern-match item after parsing and free the parsed flow item
when it cannot be returned to the caller. Propagate pattern-match failure
and report a parsing error when no flow item was produced.

Fixes: 6bc987ecb860 ("net/iavf: support IPsec inline crypto")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_ipsec_crypto.c | 28 +++++++++++++++-------
 1 file changed, 20 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ipsec_crypto.c b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
index f7e391a74a..be0a0d0df6 100644
--- a/drivers/net/intel/iavf/iavf_ipsec_crypto.c
+++ b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
@@ -1942,6 +1942,7 @@ iavf_ipsec_flow_parse(struct iavf_adapter *ad,
 		.max_actions = 1,
 	};
 	struct iavf_pattern_match_item *item = NULL;
+	struct iavf_ipsec_flow_item *fi = NULL;
 	int ret = -1;
 
 	ret = ci_flow_check_attr(attr, NULL, error);
@@ -1953,17 +1954,28 @@ iavf_ipsec_flow_parse(struct iavf_adapter *ad,
 		return ret;
 
 	item = iavf_search_pattern_match_item(pattern, array, array_len, error);
-	if (item && item->meta) {
+	if (item == NULL)
+		return -rte_errno;
+
+	if (item->meta != NULL) {
 		const struct rte_security_session *session = parsed_actions.actions[0]->conf;
 		uint32_t type = (uint64_t)(item->meta);
-		struct iavf_ipsec_flow_item *fi =
-				iavf_ipsec_flow_item_parse(ad, pattern, session, type);
-		if (fi && meta) {
-			*meta = fi;
-			ret = 0;
-		}
+
+		fi = iavf_ipsec_flow_item_parse(ad, pattern, session, type);
 	}
-	return ret;
+	rte_free(item);
+
+	if (fi == NULL)
+		return rte_flow_error_set(error, EINVAL,
+				RTE_FLOW_ERROR_TYPE_ACTION, NULL,
+				"Invalid IPsec flow.");
+
+	if (meta != NULL)
+		*meta = fi;
+	else
+		rte_free(fi);
+
+	return 0;
 }
 
 /*
-- 
2.52.0

