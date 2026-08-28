Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA997C61DB9
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Aug 2026 05:37:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E4814067C;
	Fri, 28 Aug 2026 07:37:14 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
 by mails.dpdk.org (Postfix) with ESMTP id 1604A40150
 for <dev@dpdk.org>; Fri, 28 Aug 2026 07:37:11 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787895432; x=1819431432;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=v/XR8FDdPgQotdS01sQFG3tm8rce+PUuf/bqNr4ZvGg=;
 b=kpEPdV8YcxKsqIFWKP8w7kMxUbRn8xtG4jau7iy7o+th0J3EYne4GaH3
 aWvPzxO6+a4F8ohODSDrNZjiy7Y5yeHtHkW4TDDw1CgkXds7LF17op6Qz
 4UfWojK/0qDLP4CH4EhuWLbry75dbGleZi/IDSK/6y4HEdCBMzdpYaQXk
 4/qdHc2c4bmkvpLmWdR1hWp7EuCKBEWYIiwr8QG8LAX2Jxm13CzTIbykq
 U/n82m0Nbo3VcklZd8sFNBFtxwLn+UmX5LHfkaHmgH1negd0Ele/fHjnc
 6nZoEFTkI5F3v1HOxc1S9dVM6frlMAuO7Nnhg6f+IvY27Y8ruABOv4xPH A==;
X-CSE-ConnectionGUID: clMaFlPURnCYgtheAExK+g==
X-CSE-MsgGUID: VUYZqJYVSeeKn7Q+eyIcSw==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="88425730"
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="88425730"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 22:37:12 -0700
X-CSE-ConnectionGUID: B9CldWDQQXmKaYQ5k4QyEQ==
X-CSE-MsgGUID: UL3mAU8kSESwX6UeKo1tNA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,248,1779174000"; d="scan'208";a="267477153"
Received: from unknown (HELO gnrd02..) ([10.190.212.69])
 by orviesa008.jf.intel.com with ESMTP; 27 Aug 2026 22:37:10 -0700
From: Prudvi Deti <prudvi.deti@intel.com>
To: dev@dpdk.org
Cc: bruce.richardson@intel.com, orika@nvidia.com, nirint.shah@intel.com,
 prudvi.deti@intel.com
Subject: [RFC 4/7] regex/hs: add enqueue and dequeue burst paths
Date: Fri, 28 Aug 2026 11:05:53 +0530
Message-ID: <20260828053629.1224611-5-prudvi.deti@intel.com>
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

Implement fast-path enqueue and dequeue burst functions.

Enqueue calls hs_scan() synchronously per operation using per-QP
scratch space. Multi-segment mbufs are linearized before scanning.
Completed ops are stored in a bounded ring for dequeue.

Thread-safety: single-producer/single-consumer per queue pair.
Each QP must be used by exactly one lcore.

Signed-off-by: Prudvi Deti <prudvi.deti@intel.com>
---
 drivers/regex/hs/hs_regex.c | 247 ++++++++++++++++++++++++++++++++++--
 1 file changed, 234 insertions(+), 13 deletions(-)

diff --git a/drivers/regex/hs/hs_regex.c b/drivers/regex/hs/hs_regex.c
index 116aff9..e84259e 100644
--- a/drivers/regex/hs/hs_regex.c
+++ b/drivers/regex/hs/hs_regex.c
@@ -39,15 +39,60 @@ RTE_LOG_REGISTER_DEFAULT(hs_regex_logtype, NOTICE);
 #define HS_LOG(level, ...) \
 	RTE_LOG_LINE(level, HS_REGEX, __VA_ARGS__)
 
+/* Match callback context */
+struct hs_match_ctx {
+	struct rte_regex_ops *op;
+	uint16_t max_matches;
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
+	op->nb_actual_matches++;
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
+	return 0;
+}
+
 /* Device Info */
 static int
-hs_regex_info_get(struct rte_regexdev *dev __rte_unused,
-		  struct rte_regexdev_info *info)
+hs_regex_info_get(struct rte_regexdev *dev, struct rte_regexdev_info *info)
 {
+	(void)dev;
+
+	if (info == NULL)
+		return -EINVAL;
+
 	info->driver_name = HS_REGEX_DRIVER_NAME;
 	info->dev = NULL;
 	info->max_matches = UINT16_MAX;
@@ -79,6 +124,7 @@ hs_regex_configure(struct rte_regexdev *dev,
 	if (priv == NULL)
 		return -EINVAL;
 
+	/* Reconfigure is not allowed while running. */
 	if (priv->dev_state == HS_REGEX_DEV_STARTED) {
 		HS_LOG(ERR, "Cannot configure while device is started");
 		return -EBUSY;
@@ -95,6 +141,7 @@ hs_regex_configure(struct rte_regexdev *dev,
 						  UINT16_MAX;
 	priv->nb_groups = cfg->nb_groups ? cfg->nb_groups : 1;
 
+	/* Reconfigure replaces rules, database, and queue resources. */
 	if (priv->rules) {
 		uint32_t i;
 		for (i = 0; i < priv->nb_rules; i++)
@@ -133,6 +180,7 @@ hs_regex_configure(struct rte_regexdev *dev,
 	HS_LOG(INFO, "Configured: %u queue pairs, max_matches=%u",
 	       priv->nb_queue_pairs, priv->max_matches);
 
+	/* Configuration complete. */
 	priv->dev_state = HS_REGEX_DEV_CONFIGURED;
 
 	if (cfg->rule_db != NULL && cfg->rule_db_len > 0) {
@@ -140,9 +188,11 @@ hs_regex_configure(struct rte_regexdev *dev,
 					     cfg->rule_db_len);
 		if (ret < 0) {
 			HS_LOG(ERR, "Failed to import rule DB in configure");
+			/* Roll back QP allocation on import failure. */
 			rte_free(priv->qps);
 			priv->qps = NULL;
 			priv->nb_queue_pairs = 0;
+			/* Revert state since configure failed */
 			priv->dev_state = HS_REGEX_DEV_CREATED;
 			return ret;
 		}
@@ -184,6 +234,10 @@ hs_regex_qp_setup(struct rte_regexdev *dev, uint16_t qp_id,
 	nb_desc = (qp_conf && qp_conf->nb_desc) ? qp_conf->nb_desc :
 						   HS_REGEX_DEFAULT_NB_DESC;
 
+	/*
+	 * The ring uses modulo arithmetic on head/tail.
+	 * Keep descriptor count as power-of-two for predictable wrap behavior.
+	 */
 	if (nb_desc == 0 || (nb_desc & (nb_desc - 1)) != 0) {
 		uint16_t orig = nb_desc;
 		uint32_t aligned = rte_align32pow2(nb_desc ? nb_desc : 1);
@@ -195,11 +249,13 @@ hs_regex_qp_setup(struct rte_regexdev *dev, uint16_t qp_id,
 		       qp_id, orig, nb_desc);
 	}
 
+	/* Re-setup replaces previous ring allocation. */
 	if (qp->ops) {
 		rte_free(qp->ops);
 		qp->ops = NULL;
 	}
 
+	/* Scratch is recreated on re-setup. */
 	if (qp->scratch) {
 		hs_free_scratch(qp->scratch);
 		qp->scratch = NULL;
@@ -253,6 +309,7 @@ hs_regex_rule_db_update(struct rte_regexdev *dev,
 	if (nb_rules == 0)
 		return 0;
 
+	/* Lazy-init hash table for O(1) duplicate rule_id detection. */
 	if (!priv->rule_id_hash) {
 		struct rte_hash_parameters hp = {
 			.name = "hs_rule_ids",
@@ -271,6 +328,7 @@ hs_regex_rule_db_update(struct rte_regexdev *dev,
 		if (rules[i].op == RTE_REGEX_RULE_OP_ADD) {
 			uint32_t idx;
 
+			/* Reject empty or NULL patterns. */
 			if (!rules[i].pcre_rule || rules[i].pcre_rule_len == 0) {
 				HS_LOG(ERR, "Rule %u: NULL or empty pattern",
 				       rules[i].rule_id);
@@ -278,6 +336,7 @@ hs_regex_rule_db_update(struct rte_regexdev *dev,
 				return i;
 			}
 
+			/* Keep rule_id unique for deterministic match reporting. */
 			if (priv->rule_id_hash &&
 			    rte_hash_lookup(priv->rule_id_hash,
 					   &rules[i].rule_id) >= 0) {
@@ -437,6 +496,7 @@ hs_regex_rule_db_compile_activate(struct rte_regexdev *dev)
 		if (priv->rules[i].rule_flags & RTE_REGEX_PCRE_RULE_UTF_F)
 			flags[i] |= HS_FLAG_UTF8;
 
+		/* Extended parameters */
 		ext[i].flags = 0;
 		if (priv->rules[i].min_offset) {
 			ext[i].flags |= HS_EXT_FLAG_MIN_OFFSET;
@@ -472,6 +532,7 @@ hs_regex_rule_db_compile_activate(struct rte_regexdev *dev)
 		return -EINVAL;
 	}
 
+	/* Allocate scratch per queue pair for scanning. */
 	for (i = 0; i < priv->nb_queue_pairs; i++) {
 		struct hs_regex_qp *qp = &priv->qps[i];
 
@@ -484,6 +545,7 @@ hs_regex_rule_db_compile_activate(struct rte_regexdev *dev)
 			uint32_t j;
 
 			HS_LOG(ERR, "Scratch alloc failed for qp %u", i);
+			/* Partial failure: unwind previous scratch allocations. */
 			for (j = 0; j < i; j++) {
 				if (priv->qps[j].scratch) {
 					hs_free_scratch(priv->qps[j].scratch);
@@ -502,6 +564,10 @@ hs_regex_rule_db_compile_activate(struct rte_regexdev *dev)
 	return 0;
 }
 
+/*
+ * Import a prebuilt serialized Hyperscan database.
+ * The buffer must be produced by hs_serialize_database().
+ */
 static int
 hs_regex_rule_db_import(struct rte_regexdev *dev, const char *rule_db,
 			uint32_t rule_db_len)
@@ -527,17 +593,20 @@ hs_regex_rule_db_import(struct rte_regexdev *dev, const char *rule_db,
 		return -EINVAL;
 	}
 
+	/* Free existing database */
 	if (priv->db) {
 		hs_free_database(priv->db);
 		priv->db = NULL;
 	}
 
+	/* Deserialize the precompiled database */
 	err = hs_deserialize_database(rule_db, (size_t)rule_db_len, &priv->db);
 	if (err != HS_SUCCESS) {
 		HS_LOG(ERR, "hs_deserialize_database failed (error %d)", err);
 		return -EINVAL;
 	}
 
+	/* Imported DB also requires per-QP scratch. */
 	for (i = 0; i < priv->nb_queue_pairs; i++) {
 		struct hs_regex_qp *qp = &priv->qps[i];
 
@@ -551,6 +620,7 @@ hs_regex_rule_db_import(struct rte_regexdev *dev, const char *rule_db,
 
 			HS_LOG(ERR, "Scratch alloc failed for qp %u"
 			       " after import", i);
+			/* Clean up already allocated scratches */
 			for (j = 0; j < i; j++) {
 				if (priv->qps[j].scratch) {
 					hs_free_scratch(priv->qps[j].scratch);
@@ -569,6 +639,10 @@ hs_regex_rule_db_import(struct rte_regexdev *dev, const char *rule_db,
 	return 0;
 }
 
+/*
+ * Export the compiled Hyperscan database as a serialized blob.
+ * If rule_db is NULL, returns the required buffer size.
+ */
 static int
 hs_regex_rule_db_export(struct rte_regexdev *dev, char *rule_db)
 {
@@ -596,6 +670,7 @@ hs_regex_rule_db_export(struct rte_regexdev *dev, char *rule_db)
 	}
 
 	if (rule_db == NULL) {
+		/* buf allocated by Hyperscan's malloc, not rte_malloc. */
 		free(buf);
 		if (len > INT_MAX) {
 			HS_LOG(ERR, "Serialized DB too large (%zu bytes)", len);
@@ -605,30 +680,176 @@ hs_regex_rule_db_export(struct rte_regexdev *dev, char *rule_db)
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
+		qp->tail = (qp->tail + 1) % qp->nb_desc;
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
+		qp->head = (qp->head + 1) % qp->nb_desc;
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

