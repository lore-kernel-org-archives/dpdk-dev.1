Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6D4CC6B1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:20:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AA19A40E18;
	Wed, 14 Oct 2026 17:19:35 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id C6C4940B94
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:19:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791991174; x=1823527174;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=R/8KjR7JL4T/rPkPu+xASjre+rksTF58mpjtAjnTmb4=;
 b=GP8wMLUYk5NIR5Jh3sMQsvfiTsGHB29+dpUz2zk5BBuXJy2VnjN288ry
 Jvvwv7oFLLi8bhZJFx7rs5EAVYyFjX2QfN6S+GTyuQnh7WPEpJCK48Ybm
 +XwWqeSjZq6GDLJjoO77eJjQUYm/aJPlsxKFyyu3M5t0ctEYny/X1cmkg
 bqXwK/lvmKnZHUx1lK6rH2RnDbqblUeA4cn39VmXbEuzirLVySl7S8x6h
 /xcpQKq2FTv15iy0e0uWIBKbihbnKY0W2spl3YrCjHqY319ck7COpyhtK
 FwKUYkRPNX3glfjzY/GOgDJ6M8ViZH1tbthT2mmH7lmHhqUAGewN582mS Q==;
X-CSE-ConnectionGUID: k3OgmtQqQY+AEPzER4GQrw==
X-CSE-MsgGUID: OhYm+JSbRMak9QwHoNk9ZQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="646325"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="646325"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 08:19:09 -0700
X-CSE-ConnectionGUID: XD5dbv3SQSu8dKKn0wnIpg==
X-CSE-MsgGUID: 2yVo5TGjQa+J6uXeci7fpQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="3294666"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa011.fm.intel.com with ESMTP; 14 Oct 2026 08:19:08 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 6/7] net/iavf: fix IPsec flow metadata leaks
Date: Wed, 14 Oct 2026 16:18:49 +0100
Message-ID: <f6c077ac8dede0e14f4f9fc68b31aa275c7cb686.1791991100.git.anatoly.burakov@intel.com>
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

IPsec flow parsing leaves the pattern-match item allocated. Validation
has no callback to release the parsed flow item, and creation leaks it
when adding the security policy fails.

Free the pattern-match item after parsing, add a validation callback
to release the parsed flow item, and free it if policy creation fails.
Report a parsing error when no flow item was produced.

Fixes: 6bc987ecb860 ("net/iavf: support IPsec inline crypto")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_ipsec_crypto.c | 40 +++++++++++++++++-----
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_ipsec_crypto.c b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
index 9fcdc311377..cd13e14ae74 100644
--- a/drivers/net/intel/iavf/iavf_ipsec_crypto.c
+++ b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
@@ -1893,6 +1893,7 @@ iavf_ipsec_flow_create(struct iavf_adapter *ad,
 	}
 
 	if (flow_id < 1) {
+		rte_free(ipsec_flow);
 		rte_flow_error_set(error, EINVAL,
 				RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
 				"Failed to add SA.");
@@ -1923,6 +1924,16 @@ iavf_ipsec_flow_destroy(struct iavf_adapter *ad,
 	return 0;
 }
 
+static int
+iavf_ipsec_flow_validation(__rte_unused struct iavf_adapter *ad,
+		__rte_unused struct rte_flow *flow,
+		void *meta,
+		__rte_unused struct rte_flow_error *error)
+{
+	rte_free(meta);
+	return 0;
+}
+
 static int
 iavf_ipsec_flow_parse(struct iavf_adapter *ad,
 		      struct iavf_pattern_match_item *array,
@@ -1942,6 +1953,7 @@ iavf_ipsec_flow_parse(struct iavf_adapter *ad,
 		.max_actions = 1,
 	};
 	struct iavf_pattern_match_item *item = NULL;
+	struct iavf_ipsec_flow_item *fi = NULL;
 	int ret = -1;
 
 	ret = ci_flow_check_attr(attr, NULL, error);
@@ -1953,17 +1965,28 @@ iavf_ipsec_flow_parse(struct iavf_adapter *ad,
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
-				iavf_ipsec_flow_item_parse(ad->vf.eth_dev, pattern, session, type);
-		if (fi && meta) {
-			*meta = fi;
-			ret = 0;
-		}
+
+		fi = iavf_ipsec_flow_item_parse(ad->vf.eth_dev, pattern, session, type);
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
@@ -2060,6 +2083,7 @@ static struct iavf_flow_engine iavf_ipsec_flow_engine = {
 	.uninit = iavf_ipsec_flow_uninit,
 	.create = iavf_ipsec_flow_create,
 	.destroy = iavf_ipsec_flow_destroy,
+	.validation = iavf_ipsec_flow_validation,
 	.name = "ipsec_crypto",
 	.type = IAVF_FLOW_ENGINE_IPSEC_CRYPTO,
 	.rule_size = sizeof(struct iavf_ipsec_flow_item),
-- 
2.52.0

