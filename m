Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20B16CC6B29
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:19:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE4FA4069F;
	Wed, 14 Oct 2026 17:19:29 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id CDA214069F
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:19:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791991169; x=1823527169;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=ohIVPwS01O50JRfNTuKknd7o4l8OZ0ZCIE5BRfT4gB0=;
 b=Jp2D9Kotihomc7JlLHo9vKvwNxi682zVPFGrLx8rt+egHRZjJHlGls9M
 d6spwm/HRC6xK8AVo1rx4KE7ElorHT8rbY0/wfHnIofuMe76GmmK66Gie
 6rOEeHtJWCAQl1TgVRhjVYLbfbEj3owzvVj9l0sVQ3U8igI4I8dZY10pg
 QbmxRWrNfRQozWzc8Gh+CO+l2nhLXYGsDJg7dTRudalTK2P6m1wLk5TT8
 H0faev1Dz1lRL2Eh0WhqOPcd/xcWaqOgA7ebYAUH0AOw88mRUsvXjUcwz
 h0wmAoX8OHaWivSBmb0LW0EwvGSya2QjvtcKt6qaWHZ7nn6JRW04yRDAg w==;
X-CSE-ConnectionGUID: BUbjC7KLTRabX22wwuPJhQ==
X-CSE-MsgGUID: mdvcSgwCQF6lzDn+1mnZHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="646288"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="646288"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 08:19:01 -0700
X-CSE-ConnectionGUID: z5dmh3C3SHuWZcXFgu+uMg==
X-CSE-MsgGUID: oTP1MXQiQ4ihmjMClxqOCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="3294628"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa011.fm.intel.com with ESMTP; 14 Oct 2026 08:19:00 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 1/7] net/iavf: fix memory leak in flow teardown
Date: Wed, 14 Oct 2026 16:18:44 +0100
Message-ID: <ee874b3725a743b1e1c590228d5c7da4ecd21c18.1791991100.git.anatoly.burakov@intel.com>
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

Flow uninit skips hardware teardown during a PF-initiated reset, but
only the hash engine provides a callback to free its rule. FDIR, flow
subscription and IPsec rules are therefore leaked. Conversely, hash
destroy removes its rule from hardware but frees only the flow handle.

Free the rule alongside the flow handle in the generic destroy and
uninit paths. Remove the engine-specific rule frees and the redundant
free callback, so both paths have the same software ownership.

Fixes: 7be10c3004be ("net/iavf: add RSS configuration for VF")
Fixes: 4dad1a6815d6 ("net/iavf: skip flow flush during PF-initiated reset")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_fdir.c         | 3 ---
 drivers/net/intel/iavf/iavf_fsub.c         | 3 ---
 drivers/net/intel/iavf/iavf_generic_flow.c | 4 ++--
 drivers/net/intel/iavf/iavf_generic_flow.h | 2 --
 drivers/net/intel/iavf/iavf_hash.c         | 9 ---------
 drivers/net/intel/iavf/iavf_ipsec_crypto.c | 1 -
 6 files changed, 2 insertions(+), 20 deletions(-)

diff --git a/drivers/net/intel/iavf/iavf_fdir.c b/drivers/net/intel/iavf/iavf_fdir.c
index 67003183bbd..c3babed947c 100644
--- a/drivers/net/intel/iavf/iavf_fdir.c
+++ b/drivers/net/intel/iavf/iavf_fdir.c
@@ -406,9 +406,6 @@ iavf_fdir_destroy(struct iavf_adapter *ad,
 	if (filter->mark_flag == 1)
 		iavf_fdir_rx_proc_enable(ad, 0);
 
-	flow->rule = NULL;
-	rte_free(filter);
-
 	return 0;
 }
 
diff --git a/drivers/net/intel/iavf/iavf_fsub.c b/drivers/net/intel/iavf/iavf_fsub.c
index 19ae0e2dc2e..4b2e40af3c0 100644
--- a/drivers/net/intel/iavf/iavf_fsub.c
+++ b/drivers/net/intel/iavf/iavf_fsub.c
@@ -120,9 +120,6 @@ iavf_fsub_destroy(struct iavf_adapter *ad, struct rte_flow *flow,
 		return -rte_errno;
 	}
 
-	flow->rule = NULL;
-	rte_free(filter);
-
 	return ret;
 }
 
diff --git a/drivers/net/intel/iavf/iavf_generic_flow.c b/drivers/net/intel/iavf/iavf_generic_flow.c
index 92ca20031c0..53a16d13827 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.c
+++ b/drivers/net/intel/iavf/iavf_generic_flow.c
@@ -1851,8 +1851,7 @@ iavf_flow_uninit(struct iavf_adapter *ad)
 	/* Remove all flows */
 	while ((p_flow = TAILQ_FIRST(&vf->flow_list))) {
 		TAILQ_REMOVE(&vf->flow_list, p_flow, node);
-		if (p_flow->engine->free)
-			p_flow->engine->free(p_flow);
+		rte_free(p_flow->rule);
 		rte_free(p_flow);
 	}
 
@@ -2301,6 +2300,7 @@ iavf_flow_destroy(struct rte_eth_dev *dev,
 
 	if (!ret) {
 		TAILQ_REMOVE(&vf->flow_list, flow, node);
+		rte_free(flow->rule);
 		rte_free(flow);
 	} else {
 		PMD_DRV_LOG(ERR, "Failed to destroy flow");
diff --git a/drivers/net/intel/iavf/iavf_generic_flow.h b/drivers/net/intel/iavf/iavf_generic_flow.h
index 6665d688183..3a8f5f92e8b 100644
--- a/drivers/net/intel/iavf/iavf_generic_flow.h
+++ b/drivers/net/intel/iavf/iavf_generic_flow.h
@@ -465,7 +465,6 @@ typedef int (*engine_query_t)(struct iavf_adapter *ad,
 		struct rte_flow *flow,
 		struct rte_flow_query_count *count,
 		struct rte_flow_error *error);
-typedef void (*engine_free_t) (struct rte_flow *flow);
 typedef int (*parse_pattern_action_t)(struct iavf_adapter *ad,
 		struct iavf_pattern_match_item *array,
 		uint32_t array_len,
@@ -494,7 +493,6 @@ struct iavf_flow_engine {
 	engine_create_t create;
 	engine_destroy_t destroy;
 	engine_query_t query_count;
-	engine_free_t free;
 	const char *name;
 	enum iavf_flow_engine_type type;
 	size_t rule_size;
diff --git a/drivers/net/intel/iavf/iavf_hash.c b/drivers/net/intel/iavf/iavf_hash.c
index 95150944025..cef30cd08e1 100644
--- a/drivers/net/intel/iavf/iavf_hash.c
+++ b/drivers/net/intel/iavf/iavf_hash.c
@@ -79,8 +79,6 @@ iavf_hash_destroy(struct iavf_adapter *ad, struct rte_flow *flow,
 		  struct rte_flow_error *error);
 static void
 iavf_hash_uninit_parser(struct iavf_adapter *ad);
-static void
-iavf_hash_free(struct rte_flow *flow);
 static int
 iavf_hash_parse_pattern_action(struct iavf_adapter *ad,
 			       struct iavf_pattern_match_item *array,
@@ -682,7 +680,6 @@ static struct iavf_flow_engine iavf_hash_engine = {
 	.create = iavf_hash_create,
 	.destroy = iavf_hash_destroy,
 	.uninit = iavf_hash_uninit_parser,
-	.free = iavf_hash_free,
 	.name = "hash",
 	.type = IAVF_FLOW_ENGINE_HASH,
 	.rule_size = sizeof(struct virtchnl_rss_cfg),
@@ -1670,9 +1667,3 @@ iavf_hash_uninit(struct iavf_adapter *ad)
 	if (iavf_rss_hash_set(ad, rss_conf->rss_hf, false))
 		PMD_DRV_LOG(ERR, "fail to delete default RSS");
 }
-
-static void
-iavf_hash_free(struct rte_flow *flow)
-{
-	rte_free(flow->rule);
-}
diff --git a/drivers/net/intel/iavf/iavf_ipsec_crypto.c b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
index 06b51b5e622..2478bdc245d 100644
--- a/drivers/net/intel/iavf/iavf_ipsec_crypto.c
+++ b/drivers/net/intel/iavf/iavf_ipsec_crypto.c
@@ -1919,7 +1919,6 @@ iavf_ipsec_flow_destroy(struct iavf_adapter *ad,
 
 	iavf_ipsec_crypto_security_policy_delete(ad,
 			ipsec_flow->is_ipv4, ipsec_flow->id);
-	rte_free(ipsec_flow);
 	return 0;
 }
 
-- 
2.52.0

