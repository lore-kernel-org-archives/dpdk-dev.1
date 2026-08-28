Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F991C61DBD
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 05:37:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C55B402D2;
	Fri, 28 Aug 2026 07:37:07 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id DCA55402D2
 for <dev@dpdk.org>; Fri, 28 Aug 2026 07:37:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787895425; x=1819431425;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xcEAZpKFo/beNC7d0aprWnOhI8cqe9EpXryQy1I/N4o=;
 b=VHGdEVKpQjzUv2IVtgv3Jxg10uXULvDND8YHQD/nVS7Dh6Ugo1KhiDrr
 9E6oAs7eGMtRkPM5YX9qIZaL696+25EhXDIUDWXEd0kwsk75DDOOlvf9R
 bpbqhPiA13KTJipPlUdtNe09og9Nvrknp0HejRVojAxGNKCnQ1UJpMDko
 JLmt3jU1XhY7HOP+lb/GqrVCXDIaBq2oHk4idcB/XoOdmFC9kmvejXiL9
 oqxWAB4ldLT02s4GN4Q4C4yKRGcpexd6TKZ8SRAdY4WG98PKHI/7ZWo60
 ajZ9s2dI/yjxCDguvba443oECthebYYeFRROwlGYv4Lzitp5l4Ux9a5GU Q==;
X-CSE-ConnectionGUID: dIbO4oFTQGaxmO/kGJKmmg==
X-CSE-MsgGUID: +xoBkbSNSmytTfe+/ThpdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88425723"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="88425723"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 22:37:05 -0700
X-CSE-ConnectionGUID: rCNPS2FwSu+8EquY10yTOg==
X-CSE-MsgGUID: 8iqDBIWCQRC9Blpes2WaYA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="267477127"
Received: from unknown (HELO gnrd02..) ([10.190.212.69])
 by orviesa008.jf.intel.com with ESMTP; 27 Aug 2026 22:37:03 -0700
From: Prudvi Deti <prudvi.deti@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, orika@nvidia.com, nirint.shah@intel.com,
 prudvi.deti@intel.com
Subject: [RFC 2/7] regex/hs: add device configure and queue pair setup
Date: Fri, 28 Aug 2026 11:05:51 +0530
Message-ID: <20260828053629.1224611-3-prudvi.deti@intel.com>
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

Implement rte_regexdev_configure() and rte_regexdev_queue_pair_setup().

Configure allocates queue pair array and validates parameters.
Queue pair setup allocates a power-of-two descriptor ring and
per-QP Hyperscan scratch space when a database is available.

Signed-off-by: Prudvi Deti <prudvi.deti@intel.com>
---
 drivers/regex/hs/hs_regex.c | 153 ++++++++++++++++++++++++++++++++++++
 1 file changed, 153 insertions(+)

diff --git a/drivers/regex/hs/hs_regex.c b/drivers/regex/hs/hs_regex.c
index 393283b..afe00b5 100644
--- a/drivers/regex/hs/hs_regex.c
+++ b/drivers/regex/hs/hs_regex.c
@@ -60,6 +60,157 @@ hs_regex_info_get(struct rte_regexdev *dev __rte_unused,
 	return 0;
 }
 
+/* Configure */
+static int
+hs_regex_configure(struct rte_regexdev *dev,
+		   const struct rte_regexdev_config *cfg)
+{
+	struct hs_regex_priv *priv;
+
+	if (dev == NULL || cfg == NULL)
+		return -EINVAL;
+
+	priv = dev->data->dev_private;
+	if (priv == NULL)
+		return -EINVAL;
+
+	if (priv->dev_state == HS_REGEX_DEV_STARTED) {
+		HS_LOG(ERR, "Cannot configure while device is started");
+		return -EBUSY;
+	}
+
+	if (cfg->nb_queue_pairs > HS_REGEX_MAX_QUEUE_PAIRS) {
+		HS_LOG(ERR, "Requested %u queue pairs exceeds max %u",
+		       cfg->nb_queue_pairs, HS_REGEX_MAX_QUEUE_PAIRS);
+		return -EINVAL;
+	}
+
+	priv->nb_queue_pairs = cfg->nb_queue_pairs;
+	priv->max_matches = cfg->nb_max_matches ? cfg->nb_max_matches :
+						  UINT16_MAX;
+	priv->nb_groups = cfg->nb_groups ? cfg->nb_groups : 1;
+
+	if (priv->rules) {
+		uint32_t i;
+
+		for (i = 0; i < priv->nb_rules; i++)
+			rte_free(priv->rules[i].pattern);
+		rte_free(priv->rules);
+		priv->rules = NULL;
+		priv->nb_rules = 0;
+		priv->rules_cap = 0;
+	}
+	if (priv->db) {
+		hs_free_database(priv->db);
+		priv->db = NULL;
+		priv->db_compiled = 0;
+	}
+
+	if (priv->qps) {
+		rte_free(priv->qps);
+		priv->qps = NULL;
+	}
+
+	priv->qps = rte_zmalloc("hs_regex_qps",
+				sizeof(struct hs_regex_qp) *
+				cfg->nb_queue_pairs,
+				RTE_CACHE_LINE_SIZE);
+	if (!priv->qps) {
+		HS_LOG(ERR, "Failed to allocate queue pairs");
+		/* Keep nb_queue_pairs in sync with the NULL qps array. */
+		priv->nb_queue_pairs = 0;
+		return -ENOMEM;
+	}
+
+	HS_LOG(INFO, "Configured: %u queue pairs, max_matches=%u",
+	       priv->nb_queue_pairs, priv->max_matches);
+
+	priv->dev_state = HS_REGEX_DEV_CONFIGURED;
+	return 0;
+}
+
+/* Queue Pair Setup */
+static int
+hs_regex_qp_setup(struct rte_regexdev *dev, uint16_t qp_id,
+		  const struct rte_regexdev_qp_conf *qp_conf)
+{
+	struct hs_regex_priv *priv;
+	struct hs_regex_qp *qp;
+	uint16_t nb_desc;
+	hs_error_t err;
+
+	if (dev == NULL)
+		return -EINVAL;
+
+	priv = dev->data->dev_private;
+	if (priv == NULL)
+		return -EINVAL;
+
+	if (qp_id >= priv->nb_queue_pairs) {
+		HS_LOG(ERR, "Invalid qp_id %u (max %u)", qp_id,
+		       priv->nb_queue_pairs);
+		return -EINVAL;
+	}
+
+	/* nb_queue_pairs must stay in sync with a live qps array. */
+	if (priv->qps == NULL) {
+		HS_LOG(ERR, "qp %u: queue pairs not allocated", qp_id);
+		return -EINVAL;
+	}
+
+	qp = &priv->qps[qp_id];
+	nb_desc = (qp_conf && qp_conf->nb_desc) ? qp_conf->nb_desc :
+						   HS_REGEX_DEFAULT_NB_DESC;
+
+	if (nb_desc == 0 || (nb_desc & (nb_desc - 1)) != 0) {
+		uint16_t orig = nb_desc;
+		uint32_t aligned = rte_align32pow2(nb_desc ? nb_desc : 1);
+
+		if (aligned > HS_REGEX_MAX_NB_DESC)
+			aligned = HS_REGEX_MAX_NB_DESC;
+		nb_desc = aligned;
+		HS_LOG(WARNING, "QP %u: nb_desc %u rounded up to %u (power of 2)",
+		       qp_id, orig, nb_desc);
+	}
+
+	if (qp->ops) {
+		rte_free(qp->ops);
+		qp->ops = NULL;
+	}
+
+	if (qp->scratch) {
+		hs_free_scratch(qp->scratch);
+		qp->scratch = NULL;
+	}
+
+	qp->ops = rte_zmalloc("hs_regex_qp_ops",
+			      sizeof(struct rte_regex_ops *) * nb_desc,
+			      RTE_CACHE_LINE_SIZE);
+	if (!qp->ops) {
+		HS_LOG(ERR, "Failed to allocate ops ring for qp %u", qp_id);
+		return -ENOMEM;
+	}
+
+	qp->nb_desc = nb_desc;
+	qp->head = 0;
+	qp->tail = 0;
+	qp->count = 0;
+
+	if (priv->db) {
+		err = hs_alloc_scratch(priv->db, &qp->scratch);
+		if (err != HS_SUCCESS) {
+			HS_LOG(ERR, "Failed to alloc scratch for qp %u",
+			       qp_id);
+			rte_free(qp->ops);
+			qp->ops = NULL;
+			return -ENOMEM;
+		}
+	}
+
+	HS_LOG(INFO, "QP %u setup: nb_desc=%u", qp_id, nb_desc);
+	return 0;
+}
+
 /* Fast path stubs replaced by real implementations in later patches. */
 
 static uint16_t
@@ -82,6 +233,8 @@ hs_regex_dequeue_burst(struct rte_regexdev *dev __rte_unused,
 
 static const struct rte_regexdev_ops hs_regexdev_ops = {
 	.dev_info_get = hs_regex_info_get,
+	.dev_configure = hs_regex_configure,
+	.dev_qp_setup = hs_regex_qp_setup,
 };
 
 /* Device Lifecycle */
-- 
2.43.0

