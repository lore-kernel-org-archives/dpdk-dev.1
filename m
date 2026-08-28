Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0ECDC61DBD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 05:37:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5CB2C40613;
	Fri, 28 Aug 2026 07:37:17 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 6A1C140695
 for <dev@dpdk.org>; Fri, 28 Aug 2026 07:37:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787895436; x=1819431436;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=8bvBu4ZiW4MipwkPJBhyKVFCOu0X3oaIiV4ewFVQJ9Y=;
 b=NUz/fosuBw7fdwNySEND6RN5fnrV+McOB0geALhvQPNSY8WanfjaIH2L
 Qykpt64PD5VlnJcsgGpg+VQtgzg6s3zdRD/eAn00VVkGGWbQa797pdbTA
 rNhEbJ//onPhhqdPcSfegE2aIqBNZpgULEo1bnc/nj6/o6UwWxDzGCOfx
 mBK9b3CIvYClY9S1Rn7krnY8H6rj+qkOwMou9+z9oOuob3WJW9eRyS/Qa
 j/zp59g0bu6E+8aCbnxVOdAZO9fA4r9kXm6+/pZhGxhVBUi1ddJYFXVJY
 WHGIyB81dttcKTx/PujWaH+gWW3VO/6hoa/2PR7OGMosVorK8T2Nw2Akc w==;
X-CSE-ConnectionGUID: FAdI+OXcRmeOnCshWyQoRg==
X-CSE-MsgGUID: PDu9abL8TmOVZ5nEoDuyww==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88425733"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="88425733"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 22:37:15 -0700
X-CSE-ConnectionGUID: 14PhPGeRSpy7L5bHxrwUgA==
X-CSE-MsgGUID: 78aY6lkWRKGeR9sF5OC0Ow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="267477167"
Received: from unknown (HELO gnrd02..) ([10.190.212.69])
 by orviesa008.jf.intel.com with ESMTP; 27 Aug 2026 22:37:13 -0700
From: Prudvi Deti <prudvi.deti@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, orika@nvidia.com, nirint.shah@intel.com,
 prudvi.deti@intel.com
Subject: [RFC 5/7] regex/hs: add per-queue-pair extended statistics
Date: Fri, 28 Aug 2026 11:05:54 +0530
Message-ID: <20260828053629.1224611-6-prudvi.deti@intel.com>
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

Add xstats support with three per-QP counters: enqueued, dequeued,
and matches. Implement xstats_names_get, xstats_get, and
xstats_reset with support for bulk and selective reset by stat id.

Signed-off-by: Prudvi Deti <prudvi.deti@intel.com>
---
 doc/guides/regexdevs/hs.rst |   9 ++
 drivers/regex/hs/hs_regex.c | 159 ++++++++++++++++++++++++++++++++++++
 2 files changed, 168 insertions(+)

diff --git a/doc/guides/regexdevs/hs.rst b/doc/guides/regexdevs/hs.rst
index e94466a..9c5f666 100644
--- a/doc/guides/regexdevs/hs.rst
+++ b/doc/guides/regexdevs/hs.rst
@@ -20,7 +20,16 @@ Features
 - Up to 64 queue pairs, each with up to 32768 descriptors
 - Up to 1,000,000 rules per device, with O(1) duplicate rule_id
   detection backed by ``rte_hash``
+- Up to 65,535 matches per scan operation (API field width limit);
+  cumulative totals are tracked via per-queue-pair xstats
 - Per-rule extended match parameters (minimum/maximum start offset)
+- Hyperscan block-mode engine supports scan buffers up to 4 GB
+  (library capability)
+- Through the current ``rte_regexdev`` API, this PMD advertises
+  ``max_payload_size = 65,535`` bytes (``uint16_t`` field width), so
+  ``dpdk-test-regex`` validation is limited to about 64 KB per op
+- Hyperscan uses x86 vectorized instructions (SSSE3/AVX2/AVX-512)
+  for high throughput
 - Per-queue-pair statistics via xstats
 
 In the RegEx driver feature matrix, this PMD reports:
diff --git a/drivers/regex/hs/hs_regex.c b/drivers/regex/hs/hs_regex.c
index e84259e..7841a83 100644
--- a/drivers/regex/hs/hs_regex.c
+++ b/drivers/regex/hs/hs_regex.c
@@ -849,6 +849,161 @@ hs_regex_dequeue_burst(struct rte_regexdev *dev, uint16_t qp_id,
 	return i;
 }
 
+/* xstats: per-QP statistics */
+
+/* 3 stats per QP: enqueued, dequeued, matches */
+#define HS_XSTATS_PER_QP 3
+
+static const char * const hs_xstat_suffixes[HS_XSTATS_PER_QP] = {
+	"enqueued", "dequeued", "matches"
+};
+
+static int
+hs_regex_xstats_names_get(struct rte_regexdev *dev,
+			  struct rte_regexdev_xstats_map *xstats_map)
+{
+	struct hs_regex_priv *priv;
+	uint16_t nqp;
+	int total;
+	int idx = 0;
+	uint16_t q;
+	int s;
+
+	if (dev == NULL)
+		return -EINVAL;
+
+	priv = dev->data->dev_private;
+	if (priv == NULL)
+		return -EINVAL;
+
+	nqp = priv->nb_queue_pairs;
+	total = nqp * HS_XSTATS_PER_QP;
+
+	if (!xstats_map)
+		return total;
+
+	for (q = 0; q < nqp; q++) {
+		for (s = 0; s < HS_XSTATS_PER_QP; s++) {
+			snprintf(xstats_map[idx].name,
+				 sizeof(xstats_map[idx].name),
+				 "qp%u_%s", q, hs_xstat_suffixes[s]);
+			xstats_map[idx].id = idx;
+			idx++;
+		}
+	}
+	return total;
+}
+
+static int
+hs_regex_xstats_get(struct rte_regexdev *dev,
+		    const uint16_t *ids, uint64_t *values,
+		    uint16_t nb_values)
+{
+	struct hs_regex_priv *priv;
+	uint16_t nqp;
+	int total;
+	uint16_t id, qp_idx, stat_idx;
+	uint16_t i;
+
+	if (dev == NULL)
+		return -EINVAL;
+
+	priv = dev->data->dev_private;
+	if (priv == NULL)
+		return -EINVAL;
+
+	nqp = priv->nb_queue_pairs;
+	total = nqp * HS_XSTATS_PER_QP;
+
+	if (!ids || !values)
+		return total;
+
+	if (priv->qps == NULL)
+		total = 0;
+
+	for (i = 0; i < nb_values; i++) {
+		id = ids[i];
+
+		if (id >= (uint16_t)total) {
+			values[i] = 0;
+			continue;
+		}
+
+		qp_idx = id / HS_XSTATS_PER_QP;
+		stat_idx = id % HS_XSTATS_PER_QP;
+
+		switch (stat_idx) {
+		case 0:
+			values[i] = priv->qps[qp_idx].qp_enqueued;
+			break;
+		case 1:
+			values[i] = priv->qps[qp_idx].qp_dequeued;
+			break;
+		case 2:
+			values[i] = priv->qps[qp_idx].qp_matches;
+			break;
+		}
+	}
+	return nb_values;
+}
+
+static int
+hs_regex_xstats_reset(struct rte_regexdev *dev,
+		      const uint16_t *ids, uint16_t nb_ids)
+{
+	struct hs_regex_priv *priv;
+	uint16_t nqp;
+	int total;
+	uint16_t q, i;
+	uint16_t id, qp_idx, stat_idx;
+
+	if (dev == NULL)
+		return -EINVAL;
+
+	priv = dev->data->dev_private;
+	if (priv == NULL)
+		return -EINVAL;
+
+	nqp = priv->nb_queue_pairs;
+	total = nqp * HS_XSTATS_PER_QP;
+
+	if (priv->qps == NULL)
+		return 0;
+
+	if (!ids || nb_ids == 0) {
+		/* Reset all stats */
+		for (q = 0; q < nqp; q++) {
+			priv->qps[q].qp_enqueued = 0;
+			priv->qps[q].qp_dequeued = 0;
+			priv->qps[q].qp_matches = 0;
+		}
+	} else {
+		/* Reset specific stats by id */
+		for (i = 0; i < nb_ids; i++) {
+			id = ids[i];
+
+			if (id >= (uint16_t)total)
+				continue;
+
+			qp_idx = id / HS_XSTATS_PER_QP;
+			stat_idx = id % HS_XSTATS_PER_QP;
+
+			switch (stat_idx) {
+			case 0:
+				priv->qps[qp_idx].qp_enqueued = 0;
+				break;
+			case 1:
+				priv->qps[qp_idx].qp_dequeued = 0;
+				break;
+			case 2:
+				priv->qps[qp_idx].qp_matches = 0;
+				break;
+			}
+		}
+	}
+	return 0;
+}
+
 /* Operations table */
 static const struct rte_regexdev_ops hs_regexdev_ops = {
 	.dev_info_get = hs_regex_info_get,
@@ -858,6 +1013,10 @@ static const struct rte_regexdev_ops hs_regexdev_ops = {
 	.dev_rule_db_compile_activate = hs_regex_rule_db_compile_activate,
 	.dev_db_import = hs_regex_rule_db_import,
 	.dev_db_export = hs_regex_rule_db_export,
+	.dev_xstats_names_get = hs_regex_xstats_names_get,
+	.dev_xstats_get = hs_regex_xstats_get,
+	.dev_xstats_by_name_get = NULL,
+	.dev_xstats_reset = hs_regex_xstats_reset,
 };
 
 /* Device Lifecycle */
-- 
2.43.0

