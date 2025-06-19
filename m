Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192C3C7115B
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 22:31:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6B384013F;
	Fri, 20 Jun 2025 00:31:56 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
 by mails.dpdk.org (Postfix) with ESMTP id F2118400D7;
 Fri, 20 Jun 2025 00:31:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1750372315; x=1781908315;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=L9yJ5lgrDRMM8Nyukc6fooH7H0Ea7VXRA76FZYjnRkE=;
 b=n372WsSt5Umd1PLp8lEJy8g0KBmRvUdDQ9zCrmURvQr/gGnN8eNKD0gG
 wrOQIJnfTG3z1tiFnwXMBd9cItl87YmxzULjjntnK2B7fLLuV8dpxw+sK
 C9kBBnV0Vept4eC5Rbu7rzjZeKVw4O9A6fJ/mpdrf2wIGHQFA9nbM2Fm+
 wqoVaDBO/ihKBreayCN9VGmWJuTKv9zKhlbeTXSyhEB4PUVvxZZ/jV/it
 pMTKv+04R2L8cQ8GfUexoY/W5K1w9Nooh1xikBHzB9CPJNEaaOMn1oDH9
 YGiKfCI4vegr9VP6FLSgBIWPks7tFa8rINanGYQx25UwICOTT5o1iLUIN g==;
X-CSE-ConnectionGUID: DuDhnhq9SUmYUr+qK0XXkg==
X-CSE-MsgGUID: wRLTZfKRQ2OJEb4J6wgiMg==
X-IronPort-AV: E=McAfee;i="6800,10657,11469"; a="63985774"
X-IronPort-AV: E=Sophos;i="6.16,249,1744095600"; d="scan'208";a="63985774"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
 by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 Jun 2025 15:31:54 -0700
X-CSE-ConnectionGUID: 6tGJP2zQQO2za7VYJCXOIQ==
X-CSE-MsgGUID: suoyy4AUT3i7bvmYLpbhyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,249,1744095600"; d="scan'208";a="181615589"
Received: from txanpdk02.an.intel.com ([10.123.117.76])
 by fmviesa001.fm.intel.com with ESMTP; 19 Jun 2025 15:31:53 -0700
From: Pravin Pathak <pravin.pathak@intel.com>
To: dev@dpdk.org
Cc: jerinj@marvell.com, mike.ximing.chen@intel.com, bruce.richardson@intel.com,
 thomas@monjalon.net, david.marchand@redhat.com, nipun.gupta@amd.com,
 chenbox@nvidia.com, tirthendu.sarkar@intel.com,
 Pravin Pathak <pravin.pathak@intel.com>, stable@dpdk.org
Subject: [PATCH v1] event/dlb2: fixes names of DLB2 token pop enums
Date: Thu, 19 Jun 2025 17:31:50 -0500
Message-Id: <20250619223150.346724-1-pravin.pathak@intel.com>
X-Mailer: git-send-email 2.39.1
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

added RTE_PMD_DLB2_ prefix to dlb2 token pop mode enmus
to avoid name comflict. These enums are passed to public
API rte_pmd_dlb2_set_token_pop_mode().

Fixes: c667583d82f4 ("event/dlb2: add token pop API")
Cc: stable@dpdk.org

Signed-off-by: Pravin Pathak <pravin.pathak@intel.com>
---
 drivers/event/dlb2/dlb2.c          | 28 +++++++++++++++-------------
 drivers/event/dlb2/dlb2_priv.h     |  2 +-
 drivers/event/dlb2/dlb2_selftest.c |  6 +++---
 drivers/event/dlb2/rte_pmd_dlb2.c  |  4 ++--
 drivers/event/dlb2/rte_pmd_dlb2.h  | 23 ++++++++++++-----------
 5 files changed, 33 insertions(+), 30 deletions(-)

diff --git a/drivers/event/dlb2/dlb2.c b/drivers/event/dlb2/dlb2.c
index fd8cc70f3c..084875f1c8 100644
--- a/drivers/event/dlb2/dlb2.c
+++ b/drivers/event/dlb2/dlb2.c
@@ -1819,7 +1819,7 @@ dlb2_hw_create_ldb_port(struct dlb2_eventdev *dlb2,
 	/* The default enqueue functions do not include delayed-pop support for
 	 * performance reasons.
 	 */
-	if (qm_port->token_pop_mode == DELAYED_POP) {
+	if (qm_port->token_pop_mode == RTE_PMD_DLB2_DELAYED_POP) {
 		dlb2->event_dev->enqueue_burst =
 			dlb2_event_enqueue_burst_delayed;
 		dlb2->event_dev->enqueue_new_burst =
@@ -2021,7 +2021,7 @@ dlb2_hw_create_dir_port(struct dlb2_eventdev *dlb2,
 	qm_port->dequeue_depth = dequeue_depth;
 
 	/* Directed ports are auto-pop, by default. */
-	qm_port->token_pop_mode = AUTO_POP;
+	qm_port->token_pop_mode = RTE_PMD_DLB2_AUTO_POP;
 	qm_port->owed_tokens = 0;
 	qm_port->issued_releases = 0;
 
@@ -3359,7 +3359,7 @@ __dlb2_event_enqueue_burst_reorder(void *event_port,
 		}
 		}
 
-		if (use_delayed && qm_port->token_pop_mode == DELAYED_POP &&
+		if (use_delayed && qm_port->token_pop_mode == RTE_PMD_DLB2_DELAYED_POP &&
 		    (events[i].op == RTE_EVENT_OP_FORWARD ||
 		     events[i].op == RTE_EVENT_OP_RELEASE) &&
 		    qm_port->issued_releases >= thresh - 1) {
@@ -3468,7 +3468,7 @@ __dlb2_event_enqueue_burst(void *event_port,
 			int ret;
 
 			if (use_delayed &&
-			    qm_port->token_pop_mode == DELAYED_POP &&
+			    qm_port->token_pop_mode == RTE_PMD_DLB2_DELAYED_POP &&
 			    (ev->op == RTE_EVENT_OP_FORWARD ||
 			     ev->op == RTE_EVENT_OP_RELEASE) &&
 			    qm_port->issued_releases >= thresh - 1) {
@@ -3620,7 +3620,7 @@ dlb2_event_release(struct dlb2_eventdev *dlb2,
 		for (; j < DLB2_NUM_QES_PER_CACHE_LINE && (i + j) < n; j++) {
 			int16_t thresh = qm_port->token_pop_thresh;
 
-			if (qm_port->token_pop_mode == DELAYED_POP &&
+			if (qm_port->token_pop_mode == RTE_PMD_DLB2_DELAYED_POP &&
 			    qm_port->issued_releases >= thresh - 1) {
 				/* Insert the token pop QE */
 				dlb2_construct_token_pop_qe(qm_port, j);
@@ -4365,7 +4365,7 @@ dlb2_hw_dequeue_sparse(struct dlb2_eventdev *dlb2,
 	qm_port->owed_tokens += num;
 
 	if (num) {
-		if (qm_port->token_pop_mode == AUTO_POP)
+		if (qm_port->token_pop_mode == RTE_PMD_DLB2_AUTO_POP)
 			dlb2_consume_qe_immediate(qm_port, num);
 
 		ev_port->outstanding_releases += num;
@@ -4495,7 +4495,7 @@ dlb2_hw_dequeue(struct dlb2_eventdev *dlb2,
 	qm_port->owed_tokens += num;
 
 	if (num) {
-		if (qm_port->token_pop_mode == AUTO_POP)
+		if (qm_port->token_pop_mode == RTE_PMD_DLB2_AUTO_POP)
 			dlb2_consume_qe_immediate(qm_port, num);
 
 		ev_port->outstanding_releases += num;
@@ -4540,7 +4540,7 @@ dlb2_event_dequeue_burst(void *event_port, struct rte_event *ev, uint16_t num,
 					order->enq_reorder[i].u64[1] = release_u64;
 
 			__dlb2_event_enqueue_burst_reorder(event_port, NULL, 0,
-						   qm_port->token_pop_mode == DELAYED_POP);
+					qm_port->token_pop_mode == RTE_PMD_DLB2_DELAYED_POP);
 		} else {
 			dlb2_event_release(dlb2, ev_port->id, out_rels);
 		}
@@ -4548,7 +4548,7 @@ dlb2_event_dequeue_burst(void *event_port, struct rte_event *ev, uint16_t num,
 		DLB2_INC_STAT(ev_port->stats.tx_implicit_rel, out_rels);
 	}
 
-	if (qm_port->token_pop_mode == DEFERRED_POP && qm_port->owed_tokens)
+	if (qm_port->token_pop_mode == RTE_PMD_DLB2_DEFERRED_POP && qm_port->owed_tokens)
 		dlb2_consume_qe_immediate(qm_port, qm_port->owed_tokens);
 
 	cnt = dlb2_hw_dequeue(dlb2, ev_port, ev, num, wait);
@@ -4597,7 +4597,8 @@ dlb2_event_dequeue_burst_sparse(void *event_port, struct rte_event *ev,
 					if (num_releases == RTE_DIM(release_burst)) {
 						__dlb2_event_enqueue_burst_reorder(event_port,
 							release_burst, RTE_DIM(release_burst),
-							qm_port->token_pop_mode == DELAYED_POP);
+							qm_port->token_pop_mode ==
+									RTE_PMD_DLB2_DELAYED_POP);
 						num_releases = 0;
 					}
 				}
@@ -4605,7 +4606,8 @@ dlb2_event_dequeue_burst_sparse(void *event_port, struct rte_event *ev,
 
 			if (num_releases)
 				__dlb2_event_enqueue_burst_reorder(event_port, release_burst
-					, num_releases, qm_port->token_pop_mode == DELAYED_POP);
+					, num_releases,
+					qm_port->token_pop_mode == RTE_PMD_DLB2_DELAYED_POP);
 		} else {
 			dlb2_event_release(dlb2, ev_port->id, out_rels);
 		}
@@ -4614,7 +4616,7 @@ dlb2_event_dequeue_burst_sparse(void *event_port, struct rte_event *ev,
 		DLB2_INC_STAT(ev_port->stats.tx_implicit_rel, out_rels);
 	}
 
-	if (qm_port->token_pop_mode == DEFERRED_POP && qm_port->owed_tokens)
+	if (qm_port->token_pop_mode == RTE_PMD_DLB2_DEFERRED_POP && qm_port->owed_tokens)
 		dlb2_consume_qe_immediate(qm_port, qm_port->owed_tokens);
 
 	cnt = dlb2_hw_dequeue_sparse(dlb2, ev_port, ev, num, wait);
@@ -5142,7 +5144,7 @@ dlb2_primary_eventdev_probe(struct rte_eventdev *dev,
 
 	/* Initialize each port's token pop mode */
 	for (i = 0; i < DLB2_MAX_NUM_PORTS(dlb2->version); i++)
-		dlb2->ev_ports[i].qm_port.token_pop_mode = AUTO_POP;
+		dlb2->ev_ports[i].qm_port.token_pop_mode = RTE_PMD_DLB2_AUTO_POP;
 
 	rte_spinlock_init(&dlb2->qm_instance.resource_lock);
 
diff --git a/drivers/event/dlb2/dlb2_priv.h b/drivers/event/dlb2/dlb2_priv.h
index 30d1d5b9ae..7a5cbcca1e 100644
--- a/drivers/event/dlb2/dlb2_priv.h
+++ b/drivers/event/dlb2/dlb2_priv.h
@@ -349,7 +349,7 @@ struct dlb2_port {
 	bool gen_bit;
 	uint16_t dir_credits;
 	uint32_t dequeue_depth;
-	enum dlb2_token_pop_mode token_pop_mode;
+	enum rte_pmd_dlb2_token_pop_mode token_pop_mode;
 	union dlb2_port_config cfg;
 	RTE_ATOMIC(uint32_t) *credit_pool[DLB2_NUM_QUEUE_TYPES];
 	union {
diff --git a/drivers/event/dlb2/dlb2_selftest.c b/drivers/event/dlb2/dlb2_selftest.c
index 62aa11d981..87d98700c9 100644
--- a/drivers/event/dlb2/dlb2_selftest.c
+++ b/drivers/event/dlb2/dlb2_selftest.c
@@ -1105,13 +1105,13 @@ test_deferred_sched(void)
 		return -1;
 	}
 
-	ret = rte_pmd_dlb2_set_token_pop_mode(evdev, 0, DEFERRED_POP);
+	ret = rte_pmd_dlb2_set_token_pop_mode(evdev, 0, RTE_PMD_DLB2_DEFERRED_POP);
 	if (ret < 0) {
 		printf("%d: Error setting deferred scheduling\n", __LINE__);
 		goto err;
 	}
 
-	ret = rte_pmd_dlb2_set_token_pop_mode(evdev, 1, DEFERRED_POP);
+	ret = rte_pmd_dlb2_set_token_pop_mode(evdev, 1, RTE_PMD_DLB2_DEFERRED_POP);
 	if (ret < 0) {
 		printf("%d: Error setting deferred scheduling\n", __LINE__);
 		goto err;
@@ -1257,7 +1257,7 @@ test_delayed_pop(void)
 		return -1;
 	}
 
-	ret = rte_pmd_dlb2_set_token_pop_mode(evdev, 0, DELAYED_POP);
+	ret = rte_pmd_dlb2_set_token_pop_mode(evdev, 0, RTE_PMD_DLB2_DELAYED_POP);
 	if (ret < 0) {
 		printf("%d: Error setting deferred scheduling\n", __LINE__);
 		goto err;
diff --git a/drivers/event/dlb2/rte_pmd_dlb2.c b/drivers/event/dlb2/rte_pmd_dlb2.c
index b75010027d..80186dd07d 100644
--- a/drivers/event/dlb2/rte_pmd_dlb2.c
+++ b/drivers/event/dlb2/rte_pmd_dlb2.c
@@ -14,7 +14,7 @@ RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_pmd_dlb2_set_token_pop_mode, 20.11)
 int
 rte_pmd_dlb2_set_token_pop_mode(uint8_t dev_id,
 				uint8_t port_id,
-				enum dlb2_token_pop_mode mode)
+				enum rte_pmd_dlb2_token_pop_mode mode)
 {
 	struct dlb2_eventdev *dlb2;
 	struct rte_eventdev *dev;
@@ -24,7 +24,7 @@ rte_pmd_dlb2_set_token_pop_mode(uint8_t dev_id,
 
 	dlb2 = dlb2_pmd_priv(dev);
 
-	if (mode >= NUM_TOKEN_POP_MODES)
+	if (mode >= RTE_PMD_DLB2_NUM_TOKEN_POP_MODES)
 		return -EINVAL;
 
 	/* The event device must be configured, but not yet started */
diff --git a/drivers/event/dlb2/rte_pmd_dlb2.h b/drivers/event/dlb2/rte_pmd_dlb2.h
index f58ef2168d..33e741261d 100644
--- a/drivers/event/dlb2/rte_pmd_dlb2.h
+++ b/drivers/event/dlb2/rte_pmd_dlb2.h
@@ -49,18 +49,18 @@ extern "C" {
  *
  * Selects the token pop mode for a DLB2 port.
  */
-enum dlb2_token_pop_mode {
+enum rte_pmd_dlb2_token_pop_mode {
 	/* Pop the CQ tokens immediately after dequeuing. */
-	AUTO_POP,
+	RTE_PMD_DLB2_AUTO_POP,
 	/* Pop CQ tokens after (dequeue_depth - 1) events are released.
 	 * Supported on load-balanced ports only.
 	 */
-	DELAYED_POP,
+	RTE_PMD_DLB2_DELAYED_POP,
 	/* Pop the CQ tokens during next dequeue operation. */
-	DEFERRED_POP,
+	RTE_PMD_DLB2_DEFERRED_POP,
 
 	/* NUM_TOKEN_POP_MODES must be last */
-	NUM_TOKEN_POP_MODES
+	RTE_PMD_DLB2_NUM_TOKEN_POP_MODES
 };
 
 /**
@@ -68,8 +68,9 @@ enum dlb2_token_pop_mode {
  * @b EXPERIMENTAL: this API may change, or be removed, without prior notice
  *
  * Configure the token pop mode for a DLB2 port. By default, all ports use
- * AUTO_POP. This function must be called before calling rte_event_port_setup()
- * for the port, but after calling rte_event_dev_configure().
+ * RTE_PMD_DLB2_AUTO_POP. This function must be called before calling
+ * rte_event_port_setup() for the port, but after calling
+ * rte_event_dev_configure().
  *
  * @param dev_id
  *    The identifier of the event device.
@@ -80,16 +81,16 @@ enum dlb2_token_pop_mode {
  *
  * @return
  * - 0: Success
- * - EINVAL: Invalid dev_id, port_id, or mode
- * - EINVAL: The DLB2 is not configured, is already running, or the port is
- *   already setup
+ * - EINVAL: Invalid parameter dev_id, port_id, or mode
+ * - EINVAL: The DLB2 device is not configured or is already running,
+ *           or the port is already setup
  */
 
 __rte_experimental
 int
 rte_pmd_dlb2_set_token_pop_mode(uint8_t dev_id,
 				uint8_t port_id,
-				enum dlb2_token_pop_mode mode);
+				enum rte_pmd_dlb2_token_pop_mode mode);
 
 /** Set inflight threshold for flow migration */
 #define DLB2_SET_PORT_FLOW_MIGRATION_THRESHOLD RTE_BIT64(0)
-- 
2.39.1

