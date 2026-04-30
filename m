Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65933FF8875
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Apr 2026 11:01:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F50140669;
	Thu, 30 Apr 2026 13:00:57 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id BE90E40664
 for <dev@dpdk.org>; Thu, 30 Apr 2026 13:00:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1777546855; x=1809082855;
 h=from:to:subject:date:message-id:in-reply-to:references:
 mime-version:content-transfer-encoding;
 bh=BXMAsUb/ve3BrwI9TIKCQqi8RQRtDN3IDSjOszFn7T8=;
 b=SWG33u5CIX02hCV6iL74PBsNL/+UMXgO5z+rqiXpxNdDNz6avVLJzl4Q
 oGl5/qqJi33FHHNflzzzEQqLzzL6Kro/BSvY1wBZftJJXsMEINViCRTo2
 Pmmms2iQjl4sB5MU8bCOQQ2cKIVsaTbmYpDZheb1WJswY08+/mmbey+Wn
 wha3pL81NpJ1N8zFBGaS13zO5BZ44+buQTU0aR06z9AykpnzhE+JRyZaI
 zpFXq6kjCZTJO+Mq4y+5TpR3TDANvliP01V724aNlYKKZhbppIFBDfst4
 nJKLM7CmmMbjW9Ul8Gzxgvwn8KLcpY+mIFuqsF1d6vhscZeJI/BngRGCf A==;
X-CSE-ConnectionGUID: qBArWZI6QcWVoeyJHq0DcQ==
X-CSE-MsgGUID: JchzUW9hSc+pHFYQWx6Z0g==
X-IronPort-AV: E=McAfee;i="6800,10657,11771"; a="89953115"
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="89953115"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 30 Apr 2026 04:00:54 -0700
X-CSE-ConnectionGUID: ScU+6xH9R0eNmLcRkM71+Q==
X-CSE-MsgGUID: 5m5RN/3DTueXqDMeB17oCg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,207,1770624000"; d="scan'208";a="272671440"
Received: from silpixa00401119.ir.intel.com ([10.20.224.206])
 by orviesa001.jf.intel.com with ESMTP; 30 Apr 2026 04:00:52 -0700
From: Anatoly Burakov <anatoly.burakov@intel.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v2 4/4] net/ice: implement flow dump
Date: Thu, 30 Apr 2026 12:00:47 +0100
Message-ID: <fd0d1c9d3436942e842e5ce81d5ae26c5bd58bca.1777546834.git.anatoly.burakov@intel.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <cc3919f5b33e633d4fea632ac2126eed2b537175.1777546834.git.anatoly.burakov@intel.com>
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

Implement flow dumping API.

Signed-off-by: Anatoly Burakov <anatoly.burakov@intel.com>
---
 drivers/net/intel/ice/ice_acl_filter.c    |  2 +
 drivers/net/intel/ice/ice_fdir_filter.c   |  2 +
 drivers/net/intel/ice/ice_generic_flow.c  | 77 +++++++++++++++++++++++
 drivers/net/intel/ice/ice_generic_flow.h  |  2 +
 drivers/net/intel/ice/ice_hash.c          |  2 +
 drivers/net/intel/ice/ice_switch_filter.c |  2 +
 6 files changed, 87 insertions(+)

diff --git a/drivers/net/intel/ice/ice_acl_filter.c b/drivers/net/intel/ice/ice_acl_filter.c
index 6754a40044..3939579598 100644
--- a/drivers/net/intel/ice/ice_acl_filter.c
+++ b/drivers/net/intel/ice/ice_acl_filter.c
@@ -1099,7 +1099,9 @@ ice_flow_engine ice_acl_engine = {
 	.create = ice_acl_create_filter,
 	.destroy = ice_acl_destroy_filter,
 	.free = ice_acl_filter_free,
+	.name = "acl",
 	.type = ICE_FLOW_ENGINE_ACL,
+	.rule_size = sizeof(struct acl_rule),
 };
 
 struct
diff --git a/drivers/net/intel/ice/ice_fdir_filter.c b/drivers/net/intel/ice/ice_fdir_filter.c
index ce80213429..f2b1a3a841 100644
--- a/drivers/net/intel/ice/ice_fdir_filter.c
+++ b/drivers/net/intel/ice/ice_fdir_filter.c
@@ -1688,7 +1688,9 @@ static struct ice_flow_engine ice_fdir_engine = {
 	.create = ice_fdir_create_filter,
 	.destroy = ice_fdir_destroy_filter,
 	.query_count = ice_fdir_query_count,
+	.name = "fdir",
 	.type = ICE_FLOW_ENGINE_FDIR,
+	.rule_size = sizeof(struct ice_fdir_filter_conf),
 };
 
 static int
diff --git a/drivers/net/intel/ice/ice_generic_flow.c b/drivers/net/intel/ice/ice_generic_flow.c
index 62f0c334a1..924caca94b 100644
--- a/drivers/net/intel/ice/ice_generic_flow.c
+++ b/drivers/net/intel/ice/ice_generic_flow.c
@@ -13,6 +13,7 @@
 
 #include <rte_ether.h>
 #include <ethdev_driver.h>
+#include <rte_hexdump.h>
 #include <rte_malloc.h>
 #include <rte_tailq.h>
 
@@ -46,6 +47,10 @@ static int ice_flow_query(struct rte_eth_dev *dev,
 		const struct rte_flow_action *actions,
 		void *data,
 		struct rte_flow_error *error);
+static int ice_flow_dev_dump(struct rte_eth_dev *dev,
+		struct rte_flow *flow,
+		FILE *file,
+		struct rte_flow_error *error);
 
 const struct rte_flow_ops ice_flow_ops = {
 	.validate = ice_flow_validate,
@@ -53,6 +58,7 @@ const struct rte_flow_ops ice_flow_ops = {
 	.destroy = ice_flow_destroy,
 	.flush = ice_flow_flush,
 	.query = ice_flow_query,
+	.dev_dump = ice_flow_dev_dump,
 };
 
 /* empty */
@@ -2649,6 +2655,77 @@ ice_flow_query(struct rte_eth_dev *dev,
 	return ret;
 }
 
+#define ICE_FLOW_DUMP_CHUNK_BYTES 32
+
+static void
+ice_flow_dump_blob(FILE *file, const char *engine,
+		   const void *data, size_t data_len)
+{
+	const uint8_t *raw = (const uint8_t *)data;
+	const size_t nchunks =
+		(data_len + ICE_FLOW_DUMP_CHUNK_BYTES - 1) /
+		ICE_FLOW_DUMP_CHUNK_BYTES;
+	char title[64];
+	size_t ci;
+
+	fprintf(file, "FLOW DUMP: driver=ice engine=%s\n", engine);
+	fprintf(file, "FLOW DUMP: DATA size=%zu chunks=%zu chunk_bytes=%d\n",
+		data_len, nchunks, ICE_FLOW_DUMP_CHUNK_BYTES);
+
+	for (ci = 0; ci < nchunks; ci++) {
+		const size_t off = ci * ICE_FLOW_DUMP_CHUNK_BYTES;
+		const size_t clen =
+			RTE_MIN((size_t)ICE_FLOW_DUMP_CHUNK_BYTES, data_len - off);
+
+		snprintf(title, sizeof(title), "FLOW DUMP: chunk %03zu/%03zu",
+			 ci + 1, nchunks);
+		rte_memdump(file, title, raw + off, clen);
+	}
+}
+
+static int
+ice_flow_dev_dump(struct rte_eth_dev *dev,
+		  struct rte_flow *flow,
+		  FILE *file,
+		  struct rte_flow_error *error)
+{
+	struct ice_adapter *ad =
+		ICE_DEV_PRIVATE_TO_ADAPTER(dev->data->dev_private);
+	struct ice_pf *pf = &ad->pf;
+	struct rte_flow *p_flow;
+	bool found = false;
+
+	rte_spinlock_lock(&pf->flow_ops_lock);
+	TAILQ_FOREACH(p_flow, &pf->flow_list, node) {
+		size_t rule_size = 0;
+		const void *rule_data = NULL;
+
+		if (flow != NULL && p_flow != flow)
+			continue;
+
+		found = true;
+		if (p_flow->engine != NULL) {
+			rule_size = p_flow->engine->rule_size;
+			if (p_flow->rule != NULL)
+				rule_data = p_flow->rule;
+		}
+
+		if (p_flow->engine != NULL)
+			ice_flow_dump_blob(file,
+				p_flow->engine->name != NULL ?
+				p_flow->engine->name : "unknown",
+				rule_data, rule_size);
+	}
+	rte_spinlock_unlock(&pf->flow_ops_lock);
+
+	if (flow != NULL && !found)
+		return rte_flow_error_set(error, ENOENT,
+			RTE_FLOW_ERROR_TYPE_HANDLE, NULL,
+			"Flow not found");
+
+	return 0;
+}
+
 int
 ice_flow_redirect(struct ice_adapter *ad,
 		  struct ice_flow_redirect *rd)
diff --git a/drivers/net/intel/ice/ice_generic_flow.h b/drivers/net/intel/ice/ice_generic_flow.h
index c0eed84610..dbb21c47ab 100644
--- a/drivers/net/intel/ice/ice_generic_flow.h
+++ b/drivers/net/intel/ice/ice_generic_flow.h
@@ -539,7 +539,9 @@ struct ice_flow_engine {
 	engine_query_t query_count;
 	engine_redirect_t redirect;
 	engine_free_t free;
+	const char *name;
 	enum ice_flow_engine_type type;
+	size_t rule_size;
 };
 TAILQ_HEAD(ice_engine_list, ice_flow_engine);
 
diff --git a/drivers/net/intel/ice/ice_hash.c b/drivers/net/intel/ice/ice_hash.c
index 77829e607b..835f113e82 100644
--- a/drivers/net/intel/ice/ice_hash.c
+++ b/drivers/net/intel/ice/ice_hash.c
@@ -589,7 +589,9 @@ static struct ice_flow_engine ice_hash_engine = {
 	.destroy = ice_hash_destroy,
 	.uninit = ice_hash_uninit,
 	.free = ice_hash_free,
+	.name = "hash",
 	.type = ICE_FLOW_ENGINE_HASH,
+	.rule_size = sizeof(struct ice_hash_flow_cfg),
 };
 
 /* Register parser for os package. */
diff --git a/drivers/net/intel/ice/ice_switch_filter.c b/drivers/net/intel/ice/ice_switch_filter.c
index b25e5eaad3..2da8c5c3c8 100644
--- a/drivers/net/intel/ice/ice_switch_filter.c
+++ b/drivers/net/intel/ice/ice_switch_filter.c
@@ -2070,7 +2070,9 @@ ice_flow_engine ice_switch_engine = {
 	.query_count = ice_switch_query,
 	.redirect = ice_switch_redirect,
 	.free = ice_switch_filter_rule_free,
+	.name = "switch",
 	.type = ICE_FLOW_ENGINE_SWITCH,
+	.rule_size = sizeof(struct ice_switch_filter_conf),
 };
 
 struct
-- 
2.47.3

