Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0268C79FB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 08:02:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2914F42796;
	Thu, 10 Sep 2026 10:02:18 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 9305B42796
 for <dev@dpdk.org>; Thu, 10 Sep 2026 10:02:16 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789027337; x=1820563337;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=RIGhfwXn6lYNM50/ik9PHeYp7vYJQDhW/I8YszdaU2Q=;
 b=WkuimArEQsKVgPoAO+iLPlyZZArYtq14K19nzqSuJJEFBy6Ox9DIt+JL
 rem9BVJHtV/gEyEZdQeL37dzABhW8Y6nWKv+FV7Wb74qMZevfKUzUfJXp
 G+tnoI4d76TFNlYG9ZybouwfPDjvRABwOHYdeYOVxHLlYM4ab9f83VtB8
 HWpdx/O/hGrGq1efntrcMMhRCIYXZPijvXO7spWHqVDwRyDh0s3j7eyzw
 qut0UYFeULzCN6jb+VXUfkoyXgIEV+AS8tRSTV/5UUcUlw3g6oOLZTwjC
 PHfghy/ZGQ2GiQcpj2V0hdg4aZ+J4t5v1Bf+vLknPAmgQyCqM/nH+th7w A==;
X-CSE-ConnectionGUID: EYKh+9OlQ7KNHfM0s/qEiw==
X-CSE-MsgGUID: jT3HkyCYRk2xpF8VVsmRHg==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="100989548"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="100989548"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 01:02:16 -0700
X-CSE-ConnectionGUID: 9LwGVqDQTviYbn/jAJq2mw==
X-CSE-MsgGUID: XT3YXO8aQAW9kqXh/7uIXg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="267272145"
Received: from unknown (HELO gnrd02..) ([10.190.212.69])
 by fmviesa006.fm.intel.com with ESMTP; 10 Sep 2026 01:02:14 -0700
From: Prudvi Deti <prudvi.deti@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, Ori Kam <orika@nvidia.com>,
 Aman Deep Singh <aman.deep.singh@intel.com>,
 Nirint Shah <nirint.shah@intel.com>, Prudvi Deti <prudvi.deti@intel.com>
Subject: [RFC v2 6/7] regex/hs: add start stop close and device dump
Date: Thu, 10 Sep 2026 13:30:45 +0530
Message-ID: <20260910080136.1790851-7-prudvi.deti@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260910080136.1790851-1-prudvi.deti@intel.com>
References: <20260828053629.1224611-1-prudvi.deti@intel.com>
 <20260910080136.1790851-1-prudvi.deti@intel.com>
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

Add device lifecycle state machine with validation: start requires
a compiled database, stop resets QP ring pointers, close releases
all resources and may be called without explicit stop.

Add dev_dump printing driver state, Hyperscan version, rule list,
and aggregated per-QP statistics.

Signed-off-by: Prudvi Deti <prudvi.deti@intel.com>
---
 doc/guides/regexdevs/hs.rst |   5 +
 drivers/regex/hs/hs_regex.c | 193 ++++++++++++++++++++++++++++++++++++
 drivers/regex/hs/hs_regex.h |   2 +
 3 files changed, 200 insertions(+)

diff --git a/doc/guides/regexdevs/hs.rst b/doc/guides/regexdevs/hs.rst
index c99cf11..b638ecc 100644
--- a/doc/guides/regexdevs/hs.rst
+++ b/doc/guides/regexdevs/hs.rst
@@ -205,6 +205,11 @@ Limitations
 - Multi-process mode is not supported.
 - Each queue pair must be used by exactly one lcore
   (single-producer/single-consumer model).
+- Control-plane calls (``configure``, ``queue_pair_setup``,
+  ``start``, ``stop``, ``close``) must not be called concurrently
+  with ``enqueue_burst``/``dequeue_burst`` on any queue pair, or with
+  each other. The application must quiesce the datapath before
+  invoking any control-plane function.
 
 Debugging Options
 -----------------
diff --git a/drivers/regex/hs/hs_regex.c b/drivers/regex/hs/hs_regex.c
index 580a837..395cf84 100644
--- a/drivers/regex/hs/hs_regex.c
+++ b/drivers/regex/hs/hs_regex.c
@@ -785,6 +785,191 @@ hs_regex_rule_db_export(struct rte_regexdev *dev, char *rule_db)
 	return 0;
 }
 
+/* Start */
+static int
+hs_regex_start(struct rte_regexdev *dev)
+{
+	struct hs_regex_priv *priv;
+
+	if (dev == NULL)
+		return -EINVAL;
+
+	priv = dev->data->dev_private;
+	if (priv == NULL)
+		return -EINVAL;
+
+	/* Start requires configure and a compiled/imported database. */
+	if (priv->dev_state == HS_REGEX_DEV_CREATED) {
+		HS_LOG(ERR, "Cannot start: device not configured");
+		return -EINVAL;
+	}
+	if (priv->dev_state == HS_REGEX_DEV_STARTED) {
+		HS_LOG(ERR, "Device already started");
+		return -EBUSY;
+	}
+
+	if (!priv->db_compiled) {
+		HS_LOG(ERR, "Cannot start: database not compiled/imported");
+		return -EINVAL;
+	}
+
+	priv->dev_state = HS_REGEX_DEV_STARTED;
+	HS_LOG(INFO, "Device started (%u rules, %u queue pairs)",
+	       priv->nb_rules, priv->nb_queue_pairs);
+	return 0;
+}
+
+/* Stop */
+static int
+hs_regex_stop(struct rte_regexdev *dev)
+{
+	struct hs_regex_priv *priv;
+	uint16_t i;
+
+	if (dev == NULL)
+		return -EINVAL;
+
+	priv = dev->data->dev_private;
+	if (priv == NULL)
+		return -EINVAL;
+
+	/* Stop is valid only from STARTED state. */
+	if (priv->dev_state != HS_REGEX_DEV_STARTED) {
+		HS_LOG(ERR, "Device not started, cannot stop");
+		return -EINVAL;
+	}
+
+	if (priv->qps == NULL)
+		goto stopped;
+
+	for (i = 0; i < priv->nb_queue_pairs; i++) {
+		struct hs_regex_qp *qp = &priv->qps[i];
+
+		if (qp->count > 0)
+			HS_LOG(WARNING,
+			       "qp %u: stopping with %u ops still pending "
+			       "(not returned to application)",
+			       i, qp->count);
+		qp->head = 0;
+		qp->tail = 0;
+		qp->count = 0;
+	}
+
+stopped:
+	priv->dev_state = HS_REGEX_DEV_STOPPED;
+	HS_LOG(INFO, "Device stopped");
+	return 0;
+}
+
+/* Close */
+static int
+hs_regex_close(struct rte_regexdev *dev)
+{
+	struct hs_regex_priv *priv;
+	uint32_t i;
+
+	if (dev == NULL)
+		return -EINVAL;
+
+	priv = dev->data->dev_private;
+	if (priv == NULL)
+		return -EINVAL;
+
+	/* Close may be called without an explicit stop. */
+	if (priv->dev_state == HS_REGEX_DEV_STARTED) {
+		HS_LOG(WARNING, "Device still started, stopping before close");
+		hs_regex_stop(dev);
+	}
+
+	if (priv->qps) {
+		for (i = 0; i < priv->nb_queue_pairs; i++) {
+			if (priv->qps[i].scratch)
+				hs_free_scratch(priv->qps[i].scratch);
+			rte_free(priv->qps[i].ops);
+		}
+		rte_free(priv->qps);
+		priv->qps = NULL;
+	}
+
+	if (priv->db) {
+		hs_free_database(priv->db);
+		priv->db = NULL;
+	}
+
+	for (i = 0; i < priv->nb_rules; i++)
+		rte_free(priv->rules[i].pattern);
+	rte_free(priv->rules);
+	priv->rules = NULL;
+	priv->nb_rules = 0;
+	priv->rules_cap = 0;
+	priv->db_compiled = 0;
+
+	if (priv->rule_id_hash) {
+		rte_hash_free(priv->rule_id_hash);
+		priv->rule_id_hash = NULL;
+	}
+
+	/* Return to initial state. */
+	priv->dev_state = HS_REGEX_DEV_CREATED;
+
+	HS_LOG(INFO, "Device closed");
+	return 0;
+}
+
+/* Dump */
+static int
+hs_regex_dump(struct rte_regexdev *dev, FILE *f)
+{
+	struct hs_regex_priv *priv;
+	uint64_t total_enq = 0, total_deq = 0, total_match = 0;
+	uint32_t i;
+
+	if (dev == NULL || f == NULL)
+		return -EINVAL;
+
+	priv = dev->data->dev_private;
+	if (priv == NULL)
+		return -EINVAL;
+
+	if (priv->qps != NULL) {
+		for (i = 0; i < priv->nb_queue_pairs; i++) {
+			total_enq += priv->qps[i].qp_enqueued;
+			total_deq += priv->qps[i].qp_dequeued;
+			total_match += priv->qps[i].qp_matches;
+		}
+	}
+
+	fprintf(f, "=== Hyperscan RegEx PMD ===\n");
+	fprintf(f, "  Driver:      %s\n", HS_REGEX_DRIVER_NAME);
+	fprintf(f, "  HS Version:  %s\n", hs_version());
+	fprintf(f, "  Rules:       %u\n", priv->nb_rules);
+	fprintf(f, "  Compiled:    %s\n", priv->db_compiled ? "yes" : "no");
+	fprintf(f, "  Queue Pairs: %u\n", priv->nb_queue_pairs);
+	fprintf(f, "  Max Matches: %u\n", priv->max_matches);
+	fprintf(f, "  Enqueued:    %" PRIu64 "\n", total_enq);
+	fprintf(f, "  Dequeued:    %" PRIu64 "\n", total_deq);
+	fprintf(f, "  Matches:     %" PRIu64 "\n", total_match);
+
+	if (priv->qps != NULL) {
+		for (i = 0; i < priv->nb_queue_pairs; i++)
+			fprintf(f, "  QP[%u]: enqueued=%" PRIu64
+				" dequeued=%" PRIu64 " matches=%" PRIu64 "\n",
+				i, priv->qps[i].qp_enqueued,
+				priv->qps[i].qp_dequeued,
+				priv->qps[i].qp_matches);
+	}
+
+	for (i = 0; i < priv->nb_rules && i < HS_REGEX_DUMP_MAX_RULES; i++)
+		fprintf(f, "  Rule[%u]: id=%u group=%u pattern=%s\n", i,
+			priv->rules[i].rule_id, priv->rules[i].group_id,
+			priv->rules[i].pattern);
+	if (priv->nb_rules > HS_REGEX_DUMP_MAX_RULES)
+		fprintf(f, "  ... and %u more rules omitted\n",
+			priv->nb_rules - HS_REGEX_DUMP_MAX_RULES);
+
+	return 0;
+}
+
 /*
  * Fast Path
  *
@@ -1111,6 +1296,11 @@ static const struct rte_regexdev_ops hs_regexdev_ops = {
 	.dev_info_get = hs_regex_info_get,
 	.dev_configure = hs_regex_configure,
 	.dev_qp_setup = hs_regex_qp_setup,
+	.dev_start = hs_regex_start,
+	.dev_stop = hs_regex_stop,
+	.dev_close = hs_regex_close,
+	.dev_attr_get = NULL,
+	.dev_attr_set = NULL,
 	.dev_rule_db_update = hs_regex_rule_db_update,
 	.dev_rule_db_compile_activate = hs_regex_rule_db_compile_activate,
 	.dev_db_import = hs_regex_rule_db_import,
@@ -1119,6 +1309,8 @@ static const struct rte_regexdev_ops hs_regexdev_ops = {
 	.dev_xstats_get = hs_regex_xstats_get,
 	.dev_xstats_by_name_get = NULL,
 	.dev_xstats_reset = hs_regex_xstats_reset,
+	.dev_selftest = NULL,
+	.dev_dump = hs_regex_dump,
 };
 
 /* Device Lifecycle */
@@ -1174,6 +1366,7 @@ hs_regex_dev_destroy(const char *name)
 
 	priv = dev->data->dev_private;
 	if (priv) {
+		hs_regex_close(dev);
 		rte_free(priv);
 		dev->data->dev_private = NULL;
 	}
diff --git a/drivers/regex/hs/hs_regex.h b/drivers/regex/hs/hs_regex.h
index e48ac86..07e737b 100644
--- a/drivers/regex/hs/hs_regex.h
+++ b/drivers/regex/hs/hs_regex.h
@@ -16,6 +16,8 @@
 #define HS_REGEX_MAX_RULES 1000000
 #define HS_REGEX_DEFAULT_NB_DESC 1024
 #define HS_REGEX_MAX_NB_DESC 32768
+/* Cap on per-rule lines printed by dev_dump(); large rule counts are summarized. */
+#define HS_REGEX_DUMP_MAX_RULES 32
 /* Sanity cap on imported serialized database size (defense in depth;
  * Hyperscan allocates memory proportional to this size).
  */
-- 
2.43.0

