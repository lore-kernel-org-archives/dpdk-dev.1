Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5049DC61DBD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 05:37:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 48F3740696;
	Fri, 28 Aug 2026 07:37:22 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 3D6BB40279
 for <dev@dpdk.org>; Fri, 28 Aug 2026 07:37:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787895440; x=1819431440;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=ZlByxfcBvfwAL/bVNmZ5fQNZCsW8ukdilKAT11gs7xg=;
 b=GIgzlcshi/qbUyBDS6ONB8w/3JkjFrkeOO2TUnKMu8EnVmUU/hjITqtk
 EkmfQqhvTNZ+5i2rfa1bMx+JsTPJkOh1a3ZsvliWDB8V3Pk4DPz2B3E9r
 zSngvIliCUZYbZmcZEhZ5OQuLKmSCB9dyUzj86xUQvAt4w57ZKNfLmxYS
 jJNUBMrH5Ca5Lp7XwXbTKYO7RM2p0gRVVfdU3sh740uA5sSThCOVbJOiE
 4lLZeZ97Jn5+mE7fY5weY7ubVS9BGC3Nps+lJE1R/1uM/FP61o8yJw+QL
 +zItYXheEpD37gZyM2jyRyvw2qUOGaGKg3HaFcMTXIypYBZOWJb/rPKzU w==;
X-CSE-ConnectionGUID: 6CrAf00OS8iSUJLaFMBLRQ==
X-CSE-MsgGUID: pdAwhtS4TPSS/QUbjeBeXA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88425735"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="88425735"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 22:37:20 -0700
X-CSE-ConnectionGUID: CA6QIsMFRBW8XoFgv8HdkA==
X-CSE-MsgGUID: 1i3Tai6xRD+IhcN4TCHwYw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="267477177"
Received: from unknown (HELO gnrd02..) ([10.190.212.69])
 by orviesa008.jf.intel.com with ESMTP; 27 Aug 2026 22:37:18 -0700
From: Prudvi Deti <prudvi.deti@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, orika@nvidia.com, nirint.shah@intel.com,
 prudvi.deti@intel.com
Subject: [RFC 6/7] regex/hs: add start stop close and device dump
Date: Fri, 28 Aug 2026 11:05:55 +0530
Message-ID: <20260828053629.1224611-7-prudvi.deti@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260828053629.1224611-1-prudvi.deti@intel.com>
References: <20260828053629.1224611-1-prudvi.deti@intel.com>
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
 drivers/regex/hs/hs_regex.c | 176 ++++++++++++++++++++++++++++++++++++
 1 file changed, 176 insertions(+)

diff --git a/drivers/regex/hs/hs_regex.c b/drivers/regex/hs/hs_regex.c
index 7841a83..b42f791 100644
--- a/drivers/regex/hs/hs_regex.c
+++ b/drivers/regex/hs/hs_regex.c
@@ -685,6 +685,174 @@ hs_regex_rule_db_export(struct rte_regexdev *dev, char *rule_db)
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
+	for (i = 0; i < priv->nb_rules; i++)
+		fprintf(f, "  Rule[%u]: id=%u group=%u pattern=%s\n", i,
+			priv->rules[i].rule_id, priv->rules[i].group_id,
+			priv->rules[i].pattern);
+
+	return 0;
+}
+
 /*
  * Fast Path
  *
@@ -1009,6 +1177,11 @@ static const struct rte_regexdev_ops hs_regexdev_ops = {
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
@@ -1017,6 +1190,8 @@ static const struct rte_regexdev_ops hs_regexdev_ops = {
 	.dev_xstats_get = hs_regex_xstats_get,
 	.dev_xstats_by_name_get = NULL,
 	.dev_xstats_reset = hs_regex_xstats_reset,
+	.dev_selftest = NULL,
+	.dev_dump = hs_regex_dump,
 };
 
 /* Device Lifecycle */
@@ -1072,6 +1247,7 @@ hs_regex_dev_destroy(const char *name)
 
 	priv = dev->data->dev_private;
 	if (priv) {
+		hs_regex_close(dev);
 		rte_free(priv);
 		dev->data->dev_private = NULL;
 	}
-- 
2.43.0

