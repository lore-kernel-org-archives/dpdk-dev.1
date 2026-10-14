Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CB13CC6B1D
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 15:19:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1C9B40B91;
	Wed, 14 Oct 2026 17:19:33 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
 by mails.dpdk.org (Postfix) with ESMTP id BED4C40A89
 for <dev@dpdk.org>; Wed, 14 Oct 2026 17:19:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1791991172; x=1823527172;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=Etbokk+T31Yn2BHkP5lRO3O/fUpsej07x+M5kghRKus=;
 b=MmPZ4SOk9otZsE7AKC7o2DfdFTpCIdzj1dMcvTYbcDaL1wpBJQKhGBAZ
 17YeC6eiIqYHn8FBj28h7vPixfXxRWxRroe+7rJWSGhrOZ9zPZss779j+
 94jrIbXoO1X1/QVUYC2TFEOxjN0o4bMJZwlyy0d63nAD5/T+OsJVXb7d+
 TOLNvhzel2K7IcD2h+b4MyLpbQaitugoNnetPVpsEbxBKIPt2RW6o/5OF
 IBR93imQTe2HcAVyss8cCsXJJV9gr/6pTRw6ufUpXYbxvjSz+6pPA5Gla
 Pi/1WeC/kf/xfjSILqBXKn7izNG3VOcFyTTBTDTXBxSrO0D2oaXndl3ya A==;
X-CSE-ConnectionGUID: 5NTDM8IJRKymoC8/pZu98g==
X-CSE-MsgGUID: vwJSKGWQSSm1+jCHFDpYuw==
X-IronPort-AV: E=McAfee;i="6800,10657,11935"; a="646316"
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="646316"
Received: from fmviesa011.fm.intel.com ([10.60.135.151])
 by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 14 Oct 2026 08:19:08 -0700
X-CSE-ConnectionGUID: V+MBSUjHSD+nkfUr2HZm3Q==
X-CSE-MsgGUID: Pr8+0MxZTty3RZoo18tPIg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,158,1787036400"; 
   d="scan'208";a="3294659"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by fmviesa011.fm.intel.com with ESMTP; 14 Oct 2026 08:19:06 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org
Subject: [PATCH v1 5/7] net/iavf: fix hash flow metadata leaks
Date: Wed, 14 Oct 2026 16:18:48 +0100
Message-ID: <60442096f221bf2ccd30dcc2d19a7f9819a9a2c2.1791991100.git.anatoly.burakov@intel.com>
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

Hash flow parsing allocates RSS metadata, but validation has no callback
to release it. Creation also leaks the metadata if rule allocation or
the request to add the RSS rule fails.

Add a validation callback to release the parsed metadata, and free it
on both creation failure paths. Parsing already checks the RSS inputs;
validation does not add or remove a rule.

Fixes: 7be10c3004be ("net/iavf: add RSS configuration for VF")
Fixes: 215a247b5f33 ("net/iavf: refactor hash flow")
Cc: stable@dpdk.org

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/iavf/iavf_hash.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/intel/iavf/iavf_hash.c b/drivers/net/intel/iavf/iavf_hash.c
index cef30cd08e1..6787a380f8e 100644
--- a/drivers/net/intel/iavf/iavf_hash.c
+++ b/drivers/net/intel/iavf/iavf_hash.c
@@ -80,6 +80,9 @@ iavf_hash_destroy(struct iavf_adapter *ad, struct rte_flow *flow,
 static void
 iavf_hash_uninit_parser(struct iavf_adapter *ad);
 static int
+iavf_hash_validation(struct iavf_adapter *ad, struct rte_flow *flow,
+		     void *meta, struct rte_flow_error *error);
+static int
 iavf_hash_parse_pattern_action(struct iavf_adapter *ad,
 			       struct iavf_pattern_match_item *array,
 			       uint32_t array_len,
@@ -680,6 +683,7 @@ static struct iavf_flow_engine iavf_hash_engine = {
 	.create = iavf_hash_create,
 	.destroy = iavf_hash_destroy,
 	.uninit = iavf_hash_uninit_parser,
+	.validation = iavf_hash_validation,
 	.name = "hash",
 	.type = IAVF_FLOW_ENGINE_HASH,
 	.rule_size = sizeof(struct virtchnl_rss_cfg),
@@ -1579,6 +1583,15 @@ iavf_hash_parse_pattern_action(struct iavf_adapter *ad,
 	return ret;
 }
 
+static int
+iavf_hash_validation(__rte_unused struct iavf_adapter *ad,
+		     __rte_unused struct rte_flow *flow, void *meta,
+		     __rte_unused struct rte_flow_error *error)
+{
+	rte_free(meta);
+	return 0;
+}
+
 static int
 iavf_hash_create(__rte_unused struct iavf_adapter *ad,
 		 __rte_unused struct rte_flow *flow, void *meta,
@@ -1594,6 +1607,7 @@ iavf_hash_create(__rte_unused struct iavf_adapter *ad,
 		rte_flow_error_set(error, EINVAL,
 				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
 				   "No memory for rss rule");
+		rte_free(meta);
 		return -ENOMEM;
 	}
 
@@ -1609,6 +1623,7 @@ iavf_hash_create(__rte_unused struct iavf_adapter *ad,
 				   RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
 				   "Failed to add rss rule.");
 		rte_free(rss_cfg);
+		rte_free(meta);
 		return -rte_errno;
 	}
 
-- 
2.52.0

