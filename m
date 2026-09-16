Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28250C88E5C
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Sep 2026 12:28:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8F2B742EFE;
	Wed, 16 Sep 2026 14:27:52 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
 by mails.dpdk.org (Postfix) with ESMTP id 64D4D42EEB
 for <dev@dpdk.org>; Wed, 16 Sep 2026 14:27:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789561671; x=1821097671;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=WpWtixSRB3Tyfq2ygwc88Wg+Qs4nZ3RH3TkV+zGXKMM=;
 b=cGiAZ+yqinoOKkMfgZWmQfl87bo18+ApgKBXKrucJa/YjNT5cg3zrSs6
 heavSPESwYG6q7IQkFTQ3eMKLLSOyB5AukK0qC4BOpmccNqoy14Q31H0T
 oHalMM0PpIOM9lstAvpLmCHA6jpjiQfd+uKOobrH1yDjBSVIlbQnNMrQz
 eFPgy9xC8GLR00pzxwsKBYkIb118JiL5ajs9d4bG5xOln9MOw+efipQQ4
 rYpHyc/vSJtNb+MiB4hd4KtFDwSizbyj5bM8sx7xXtE6TxaDZLzXgDEZb
 WddAAaTafIyMWPBqZSYIEF9lIEYmTA/ZKByNU92TLpMPN2rbH7oX/Ui4m g==;
X-CSE-ConnectionGUID: Mb6u3OElT06vM81a3ytAIQ==
X-CSE-MsgGUID: xsiwG4McSS6b3MleCXQOzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="107305486"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="107305486"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
 by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Sep 2026 05:27:51 -0700
X-CSE-ConnectionGUID: H+QHteayTlSh05CZr+zAkA==
X-CSE-MsgGUID: C/YjZgjmRXuUEX0f++i3lw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; d="scan'208";a="270693929"
Received: from unknown (HELO gnrd02..) ([10.190.212.69])
 by fmviesa008.fm.intel.com with ESMTP; 16 Sep 2026 05:27:49 -0700
From: Prudvi Deti <prudvi.deti@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, Ori Kam <orika@nvidia.com>,
 Aman Singh <aman.deep.singh@intel.com>, Nirint Shah <nirint.shah@intel.com>
Subject: [RFC v3 2/7] regex/hs: add device configure and queue pair setup
Date: Wed, 16 Sep 2026 17:56:59 +0530
Message-ID: <20260916122738.2176589-3-prudvi.deti@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260916122738.2176589-1-prudvi.deti@intel.com>
References: <20260910080136.1790851-1-prudvi.deti@intel.com>
 <20260916122738.2176589-1-prudvi.deti@intel.com>
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
 drivers/regex/hs/hs_regex.c | 182 ++++++++++++++++++++++++++++++++++++
 1 file changed, 182 insertions(+)

diff --git a/drivers/regex/hs/hs_regex.c b/drivers/regex/hs/hs_regex.c
index 081e4b3..2e0a215 100644
--- a/drivers/regex/hs/hs_regex.c
+++ b/drivers/regex/hs/hs_regex.c
@@ -60,6 +60,186 @@ hs_regex_info_get(struct rte_regexdev *dev __rte_unused,
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
+	if (cfg->dev_cfg_flags != 0) {
+		HS_LOG(ERR, "Unsupported device configuration flags 0x%x",
+		       cfg->dev_cfg_flags);
+		return -EINVAL;
+	}
+
+	if (cfg->nb_queue_pairs > HS_REGEX_MAX_QUEUE_PAIRS) {
+		HS_LOG(ERR, "Requested %u queue pairs exceeds max %u",
+		       cfg->nb_queue_pairs, HS_REGEX_MAX_QUEUE_PAIRS);
+		return -EINVAL;
+	}
+
+	/* Reconfigure replaces rules, database, and queue resources. */
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
+		uint16_t i;
+
+		for (i = 0; i < priv->nb_queue_pairs; i++) {
+			if (priv->qps[i].scratch)
+				hs_free_scratch(priv->qps[i].scratch);
+			rte_free(priv->qps[i].ops);
+		}
+		rte_free(priv->qps);
+		priv->qps = NULL;
+	}
+
+	priv->nb_queue_pairs = cfg->nb_queue_pairs;
+	priv->max_matches = cfg->nb_max_matches ? cfg->nb_max_matches :
+						  UINT16_MAX;
+	priv->nb_groups = cfg->nb_groups ? cfg->nb_groups : 1;
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
+	/* nb_queue_pairs is only meaningful once qps is allocated. */
+	if (priv->qps == NULL) {
+		HS_LOG(ERR, "qp %u: queue pairs not allocated", qp_id);
+		return -EINVAL;
+	}
+
+	if (qp_id >= priv->nb_queue_pairs) {
+		HS_LOG(ERR, "Invalid qp_id %u (max %u)", qp_id,
+		       priv->nb_queue_pairs);
+		return -EINVAL;
+	}
+	if (qp_conf && qp_conf->qp_conf_flags != 0) {
+		HS_LOG(ERR, "QP %u: unsupported configuration flags 0x%x",
+		       qp_id, qp_conf->qp_conf_flags);
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
+		if (aligned > HS_REGEX_MAX_NB_DESC) {
+			HS_LOG(WARNING,
+			       "QP %u: nb_desc %u exceeds max %u, capping "
+			       "(next power of 2 would be %u)",
+			       qp_id, orig, HS_REGEX_MAX_NB_DESC, aligned);
+			aligned = HS_REGEX_MAX_NB_DESC;
+		} else {
+			HS_LOG(WARNING, "QP %u: nb_desc %u rounded up to %u (power of 2)",
+			       qp_id, orig, aligned);
+		}
+		nb_desc = aligned;
+	}
+
+	if (qp->ops) {
+		rte_free(qp->ops);
+		qp->ops = NULL;
+	}
+
+	/*
+	 * Scratch is recreated on re-setup here if a database already
+	 * exists; otherwise compile_activate()/import() populate it
+	 * for every queue pair once a database becomes available.
+	 */
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
@@ -82,6 +262,8 @@ hs_regex_dequeue_burst(struct rte_regexdev *dev __rte_unused,
 
 static const struct rte_regexdev_ops hs_regexdev_ops = {
 	.dev_info_get = hs_regex_info_get,
+	.dev_configure = hs_regex_configure,
+	.dev_qp_setup = hs_regex_qp_setup,
 };
 
 /* Device Lifecycle */
-- 
2.43.0

