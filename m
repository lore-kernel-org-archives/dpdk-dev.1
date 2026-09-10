Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E96C0C79F9F
	for <dpdk-dev@archiver.kernel.org>; Thu, 10 Sep 2026 08:02:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CA43E415D7;
	Thu, 10 Sep 2026 10:02:10 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 0867A4028F
 for <dev@dpdk.org>; Thu, 10 Sep 2026 10:02:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1789027330; x=1820563330;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=sduvQLpGAFEy+MfwDgw8/8wxFaLQ38ro/BcYL94mDFE=;
 b=WTeSJ7hIJsIDO7zmGTCCr3+1w2kooBNWSC5VoCKvO5YhCXpFfrvMCdLG
 cBtpvxLvZZuC5PzenWaIbJwip2DM1qC8r7lFVrULZJlnBUNuIgeRFpJwO
 RqipDOS0KJQkxzDCjVWQ39gRF8GW9wDHwh682JZmE22GbIduQsJ8Ba2Rf
 gIGMFuba/EdEFmTeuw9M63AAMmx3dROm1lYsFpW4MAwSRs+wD9oAkNNRr
 IfRehe/dUp6/mxgi6FlL7rU3AH2nzv6qqNMXhGj+Wq52GXGyo3tVW2KI+
 6o3ZT2WXpupOqP1UWhGh56LvIclrZXNVvdoGHL94pRwKqnZFXqQ0DDhZU A==;
X-CSE-ConnectionGUID: h0buH5uTQR6aZDzFjH7Ccg==
X-CSE-MsgGUID: flAIS5VRQH6nV/38P04JUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="100989525"
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="100989525"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
 by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Sep 2026 01:02:09 -0700
X-CSE-ConnectionGUID: W8ZY5lH3S5mJk5cmqHLPZw==
X-CSE-MsgGUID: 8qaKtQ1NQjW/+ajYSILGCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,271,1779174000"; d="scan'208";a="267272077"
Received: from unknown (HELO gnrd02..) ([10.190.212.69])
 by fmviesa006.fm.intel.com with ESMTP; 10 Sep 2026 01:02:06 -0700
From: Prudvi Deti <prudvi.deti@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>,
 Stephen Hemminger <stephen@networkplumber.org>, Ori Kam <orika@nvidia.com>,
 Aman Deep Singh <aman.deep.singh@intel.com>,
 Nirint Shah <nirint.shah@intel.com>, Prudvi Deti <prudvi.deti@intel.com>
Subject: [RFC v2 4/7] regex/hs: add enqueue and dequeue burst paths
Date: Thu, 10 Sep 2026 13:30:43 +0530
Message-ID: <20260910080136.1790851-5-prudvi.deti@intel.com>
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

Implement fast-path enqueue and dequeue burst functions.

Enqueue calls hs_scan() synchronously per operation using per-QP
scratch space. Multi-segment mbufs are linearized before scanning.
Completed ops are stored in a bounded ring for dequeue.

Thread-safety: single-producer/single-consumer per queue pair.
Each QP must be used by exactly one lcore.

Signed-off-by: Prudvi Deti <prudvi.deti@intel.com>
---
 drivers/regex/hs/hs_regex.c | 250 ++++++++++++++++++++++++++++++++++--
 1 file changed, 236 insertions(+), 14 deletions(-)

diff --git a/drivers/regex/hs/hs_regex.c b/drivers/regex/hs/hs_regex.c
index 9462d49..f17bae5 100644
--- a/drivers/regex/hs/hs_regex.c
+++ b/drivers/regex/hs/hs_regex.c
@@ -39,17 +39,64 @@ RTE_LOG_REGISTER_DEFAULT(hs_regex_logtype, NOTICE);
 #define HS_LOG(level, ...) \
 	RTE_LOG_LINE(level, HS_REGEX, __VA_ARGS__)
 
+/* Match callback context */
+struct hs_match_ctx {
+	struct rte_regex_ops *op;
+	uint16_t max_matches;
+	uint8_t stop_on_match;
+	uint64_t total_matches; /* 64-bit counter for accurate tracking */
+};
+
 static int
 hs_regex_rule_db_import(struct rte_regexdev *dev, const char *rule_db,
 			uint32_t rule_db_len);
 
+static int
+hs_match_cb(unsigned int id, unsigned long long from,
+	    unsigned long long to, unsigned int flags __rte_unused,
+	    void *context)
+{
+	struct hs_match_ctx *ctx = (struct hs_match_ctx *)context;
+	struct rte_regex_ops *op;
+
+	if (unlikely(ctx == NULL))
+		return 1;
+
+	op = ctx->op;
+	if (unlikely(op == NULL))
+		return 1;
+
+	ctx->total_matches++;
+	if (op->nb_actual_matches < UINT16_MAX)
+		op->nb_actual_matches++;
+	else
+		op->rsp_flags |= RTE_REGEX_OPS_RSP_MAX_MATCH_F;
+
+	if (op->nb_matches < ctx->max_matches) {
+		struct rte_regexdev_match *m = &op->matches[op->nb_matches];
+
+		m->rule_id = id;
+		m->start_offset = (uint16_t)from;
+		m->len = (uint16_t)(to - from);
+		op->nb_matches++;
+
+	} else {
+		/* Match list full; report truncation while keeping actual count. */
+		op->rsp_flags |= RTE_REGEX_OPS_RSP_MAX_MATCH_F;
+	}
+
+	return ctx->stop_on_match ? 1 : 0;
+}
+
 /* Device Info */
 static int
-hs_regex_info_get(struct rte_regexdev *dev __rte_unused,
-		  struct rte_regexdev_info *info)
+hs_regex_info_get(struct rte_regexdev *dev, struct rte_regexdev_info *info)
 {
+	if (info == NULL)
+		return -EINVAL;
+
 	info->driver_name = HS_REGEX_DRIVER_NAME;
-	info->dev = NULL;
+	info->dev = dev->device;
 	info->max_matches = UINT16_MAX;
 	info->max_queue_pairs = HS_REGEX_MAX_QUEUE_PAIRS;
 	info->max_payload_size = UINT16_MAX;
@@ -79,6 +126,7 @@ hs_regex_configure(struct rte_regexdev *dev,
 	if (priv == NULL)
 		return -EINVAL;
 
+	/* Reconfigure is not allowed while running. */
 	if (priv->dev_state == HS_REGEX_DEV_STARTED) {
 		HS_LOG(ERR, "Cannot configure while device is started");
 		return -EBUSY;
@@ -146,6 +194,7 @@ hs_regex_configure(struct rte_regexdev *dev,
 	HS_LOG(INFO, "Configured: %u queue pairs, max_matches=%u",
 	       priv->nb_queue_pairs, priv->max_matches);
 
+	/* Configuration complete. */
 	priv->dev_state = HS_REGEX_DEV_CONFIGURED;
 
 	if (cfg->rule_db != NULL && cfg->rule_db_len > 0) {
@@ -153,11 +202,13 @@ hs_regex_configure(struct rte_regexdev *dev,
 					     cfg->rule_db_len);
 		if (ret < 0) {
 			HS_LOG(ERR, "Failed to import rule DB in configure");
+			/* Roll back QP allocation on import failure. */
 			rte_free(priv->qps);
 			priv->qps = NULL;
 			priv->nb_queue_pairs = 0;
 			priv->max_matches = 0;
 			priv->nb_groups = 0;
+			/* Revert state since configure failed */
 			priv->dev_state = HS_REGEX_DEV_CREATED;
 			return ret;
 		}
@@ -204,6 +255,10 @@ hs_regex_qp_setup(struct rte_regexdev *dev, uint16_t qp_id,
 	nb_desc = (qp_conf && qp_conf->nb_desc) ? qp_conf->nb_desc :
 						   HS_REGEX_DEFAULT_NB_DESC;
 
+	/*
+	 * The ring uses modulo arithmetic on head/tail.
+	 * Keep descriptor count as power-of-two for predictable wrap behavior.
+	 */
 	if (nb_desc == 0 || (nb_desc & (nb_desc - 1)) != 0) {
 		uint16_t orig = nb_desc;
 		uint32_t aligned = rte_align32pow2(nb_desc ? nb_desc : 1);
@@ -221,6 +276,7 @@ hs_regex_qp_setup(struct rte_regexdev *dev, uint16_t qp_id,
 		nb_desc = aligned;
 	}
 
+	/* Re-setup replaces previous ring allocation. */
 	if (qp->ops) {
 		rte_free(qp->ops);
 		qp->ops = NULL;
@@ -295,6 +351,7 @@ hs_regex_rule_db_update(struct rte_regexdev *dev,
 	if (nb_rules == 0)
 		return 0;
 
+	/* Lazy-init hash table for O(1) duplicate rule_id detection. */
 	if (!priv->rule_id_hash) {
 		char hash_name[RTE_HASH_NAMESIZE];
 		struct rte_hash_parameters hp = {
@@ -352,6 +409,7 @@ hs_regex_rule_db_update(struct rte_regexdev *dev,
 				return i;
 			}
 
+			/* Keep rule_id unique for deterministic match reporting. */
 			if (priv->rule_id_hash &&
 			    rte_hash_lookup(priv->rule_id_hash,
 					   &rules[i].rule_id) >= 0) {
@@ -531,6 +589,7 @@ hs_regex_rule_db_compile_activate(struct rte_regexdev *dev)
 		if (priv->rules[i].rule_flags & RTE_REGEX_PCRE_RULE_UTF_F)
 			flags[i] |= HS_FLAG_UTF8;
 
+		/* Extended parameters */
 		ext[i].flags = 0;
 		if (priv->rules[i].min_offset) {
 			ext[i].flags |= HS_EXT_FLAG_MIN_OFFSET;
@@ -566,6 +625,7 @@ hs_regex_rule_db_compile_activate(struct rte_regexdev *dev)
 		return -EINVAL;
 	}
 
+	/* Allocate scratch per queue pair for scanning. */
 	for (i = 0; i < priv->nb_queue_pairs; i++) {
 		struct hs_regex_qp *qp = &priv->qps[i];
 
@@ -578,6 +638,7 @@ hs_regex_rule_db_compile_activate(struct rte_regexdev *dev)
 			uint32_t j;
 
 			HS_LOG(ERR, "Scratch alloc failed for qp %u", i);
+			/* Partial failure: unwind previous scratch allocations. */
 			for (j = 0; j < i; j++) {
 				if (priv->qps[j].scratch) {
 					hs_free_scratch(priv->qps[j].scratch);
@@ -596,6 +657,10 @@ hs_regex_rule_db_compile_activate(struct rte_regexdev *dev)
 	return 0;
 }
 
+/*
+ * Import a prebuilt serialized Hyperscan database.
+ * The buffer must be produced by hs_serialize_database().
+ */
 static int
 hs_regex_rule_db_import(struct rte_regexdev *dev, const char *rule_db,
 			uint32_t rule_db_len)
@@ -627,18 +692,21 @@ hs_regex_rule_db_import(struct rte_regexdev *dev, const char *rule_db,
 		return -EINVAL;
 	}
 
+	/* Free existing database */
 	if (priv->db) {
 		hs_free_database(priv->db);
 		priv->db = NULL;
 	}
 	priv->db_compiled = 0;
 
+	/* Deserialize the precompiled database */
 	err = hs_deserialize_database(rule_db, (size_t)rule_db_len, &priv->db);
 	if (err != HS_SUCCESS) {
 		HS_LOG(ERR, "hs_deserialize_database failed (error %d)", err);
 		return -EINVAL;
 	}
 
+	/* Imported DB also requires per-QP scratch. */
 	for (i = 0; i < priv->nb_queue_pairs; i++) {
 		struct hs_regex_qp *qp = &priv->qps[i];
 
@@ -652,6 +720,7 @@ hs_regex_rule_db_import(struct rte_regexdev *dev, const char *rule_db,
 
 			HS_LOG(ERR, "Scratch alloc failed for qp %u"
 			       " after import", i);
+			/* Clean up already allocated scratches */
 			for (j = 0; j < i; j++) {
 				if (priv->qps[j].scratch) {
 					hs_free_scratch(priv->qps[j].scratch);
@@ -670,6 +739,10 @@ hs_regex_rule_db_import(struct rte_regexdev *dev, const char *rule_db,
 	return 0;
 }
 
+/*
+ * Export the compiled Hyperscan database as a serialized blob.
+ * If rule_db is NULL, returns the required buffer size.
+ */
 static int
 hs_regex_rule_db_export(struct rte_regexdev *dev, char *rule_db)
 {
@@ -697,6 +770,7 @@ hs_regex_rule_db_export(struct rte_regexdev *dev, char *rule_db)
 	}
 
 	if (rule_db == NULL) {
+		/* buf allocated by Hyperscan's malloc, not rte_malloc. */
 		free(buf);
 		if (len > INT_MAX) {
 			HS_LOG(ERR, "Serialized DB too large (%zu bytes)", len);
@@ -706,30 +780,178 @@ hs_regex_rule_db_export(struct rte_regexdev *dev, char *rule_db)
 	}
 
 	memcpy(rule_db, buf, len);
+	/* Hyperscan allocates buf internally via malloc, not rte_malloc. */
 	free(buf);
 	return 0;
 }
 
-/* Fast path stubs replaced by real implementations in later patches. */
+/*
+ * Fast Path
+ *
+ * Thread-safety model: single-producer / single-consumer per queue
+ * pair.  Each QP must be used by exactly one thread.  No locking is
+ * performed on ring operations (head/tail/count).  Using the same QP
+ * from multiple threads concurrently causes data races.
+ */
 
 static uint16_t
-hs_regex_enqueue_burst(struct rte_regexdev *dev __rte_unused,
-		       uint16_t qp_id __rte_unused,
-		       struct rte_regex_ops **ops __rte_unused,
-		       uint16_t nb_ops __rte_unused)
+hs_regex_enqueue_burst(struct rte_regexdev *dev, uint16_t qp_id,
+		       struct rte_regex_ops **ops, uint16_t nb_ops)
 {
-	return 0;
+	struct hs_regex_priv *priv;
+	struct hs_regex_qp *qp;
+	uint16_t i;
+	uint16_t free_space;
+
+	if (unlikely(dev == NULL || ops == NULL))
+		return 0;
+
+	priv = dev->data->dev_private;
+	if (unlikely(priv == NULL))
+		return 0;
+
+	/* Validate queue pair index. */
+	if (unlikely(qp_id >= priv->nb_queue_pairs)) {
+		HS_LOG(ERR, "enqueue: invalid qp_id %u (max %u)",
+		       qp_id, priv->nb_queue_pairs);
+		return 0;
+	}
+
+	if (unlikely(priv->dev_state != HS_REGEX_DEV_STARTED)) {
+		HS_LOG(ERR, "enqueue: device not started");
+		return 0;
+	}
+
+	if (unlikely(priv->db == NULL)) {
+		HS_LOG(ERR, "enqueue: no compiled database, dropping burst");
+		return 0;
+	}
+
+	qp = &priv->qps[qp_id];
+
+	if (unlikely(qp->scratch == NULL)) {
+		HS_LOG(ERR, "enqueue: qp %u has no scratch, dropping burst",
+		       qp_id);
+		return 0;
+	}
+
+	/* Bounded ring: accept only free entries. */
+	free_space = qp->nb_desc - qp->count;
+	if (nb_ops > free_space)
+		nb_ops = free_space;
+
+	for (i = 0; i < nb_ops; i++) {
+		struct rte_regex_ops *op = ops[i];
+		struct rte_mbuf *mbuf;
+		const char *data;
+		uint32_t data_len;
+		struct hs_match_ctx ctx = { .total_matches = 0 };
+		hs_error_t err;
+
+		if (unlikely(op == NULL))
+			break;
+
+		mbuf = op->mbuf;
+		if (unlikely(mbuf == NULL)) {
+			op->nb_matches = 0;
+			op->nb_actual_matches = 0;
+			op->rsp_flags = RTE_REGEX_OPS_RSP_RESOURCE_LIMIT_REACHED_F;
+			goto enqueue_op;
+		}
+
+		/* hs_scan requires contiguous data. */
+		if (rte_pktmbuf_linearize(mbuf) != 0) {
+			op->nb_matches = 0;
+			op->nb_actual_matches = 0;
+			op->rsp_flags = RTE_REGEX_OPS_RSP_RESOURCE_LIMIT_REACHED_F;
+			goto enqueue_op;
+		}
+		data = rte_pktmbuf_mtod(mbuf, const char *);
+		data_len = rte_pktmbuf_pkt_len(mbuf);
+
+		if (unlikely(data_len == 0)) {
+			op->nb_matches = 0;
+			op->nb_actual_matches = 0;
+			op->rsp_flags = 0;
+			goto enqueue_op;
+		}
+
+		op->nb_matches = 0;
+		op->nb_actual_matches = 0;
+		op->rsp_flags = 0;
+
+		ctx.op = op;
+		ctx.max_matches = priv->max_matches;
+		ctx.stop_on_match = !!(op->req_flags &
+			RTE_REGEX_OPS_REQ_STOP_ON_MATCH_F);
+		ctx.total_matches = 0;
+
+		err = hs_scan(priv->db, data, data_len, 0,
+			      qp->scratch, hs_match_cb, &ctx);
+
+		if (unlikely(err != HS_SUCCESS &&
+			     err != HS_SCAN_TERMINATED))
+			op->rsp_flags |=
+				RTE_REGEX_OPS_RSP_RESOURCE_LIMIT_REACHED_F;
+
+enqueue_op:
+		/* Keep completed op for dequeue_burst(). */
+		qp->ops[qp->tail] = op;
+		qp->tail = (qp->tail + 1) & (qp->nb_desc - 1);
+		qp->count++;
+
+		qp->qp_matches += ctx.total_matches;
+	}
+
+	qp->qp_enqueued += i;
+	return i;
 }
 
 static uint16_t
-hs_regex_dequeue_burst(struct rte_regexdev *dev __rte_unused,
-		       uint16_t qp_id __rte_unused,
-		       struct rte_regex_ops **ops __rte_unused,
-		       uint16_t nb_ops __rte_unused)
+hs_regex_dequeue_burst(struct rte_regexdev *dev, uint16_t qp_id,
+		       struct rte_regex_ops **ops, uint16_t nb_ops)
 {
-	return 0;
+	struct hs_regex_priv *priv;
+	struct hs_regex_qp *qp;
+	uint16_t i;
+	uint16_t avail;
+
+	if (unlikely(dev == NULL || ops == NULL))
+		return 0;
+
+	priv = dev->data->dev_private;
+	if (unlikely(priv == NULL))
+		return 0;
+
+	/* Validate queue pair index. */
+	if (unlikely(qp_id >= priv->nb_queue_pairs)) {
+		HS_LOG(ERR, "dequeue: invalid qp_id %u (max %u)",
+		       qp_id, priv->nb_queue_pairs);
+		return 0;
+	}
+
+	if (unlikely(priv->qps == NULL))
+		return 0;
+
+	qp = &priv->qps[qp_id];
+
+	/* Return completed ops currently available in the ring. */
+	avail = qp->count;
+	if (nb_ops > avail)
+		nb_ops = avail;
+
+	for (i = 0; i < nb_ops; i++) {
+		ops[i] = qp->ops[qp->head];
+		qp->head = (qp->head + 1) & (qp->nb_desc - 1);
+		qp->count--;
+	}
+
+	/* Device-level stats. */
+	qp->qp_dequeued += i;
+	return i;
 }
 
+/* Operations table */
 static const struct rte_regexdev_ops hs_regexdev_ops = {
 	.dev_info_get = hs_regex_info_get,
 	.dev_configure = hs_regex_configure,
-- 
2.43.0

