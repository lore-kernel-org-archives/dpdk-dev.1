Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265CBC88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 14:56:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFC2440E6E;
	Mon, 14 Sep 2026 16:56:27 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 3ECB440E6E
 for <dev@dpdk.org>; Mon, 14 Sep 2026 16:56:24 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=JgXrJ+AS0mExqTQsNXzOAFUm70X1/3w1N37MP1qxhOQ=;
 b=WC8w4pVOv9yUIZFmW7TqAbEtGuAzrLDSoyZuJflO/yHf3R4j/3B5fr8fJsZ87L5jbXQXIrmvN
 LuMS7uejV68kHYPGMuT76T3LpzK+yNa0Sqb14oRb91kfW9ApmYLZJtfUdAEin7oNY3Xqhwru6bq
 Lax6rLwYKfS0nTdoFcuaW+8=
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hk7Vn2M2DzJ46Z6
 for <dev@dpdk.org>; Mon, 14 Sep 2026 22:55:29 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id AF39840576
 for <dev@dpdk.org>; Mon, 14 Sep 2026 22:56:20 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 16:56:20 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>
Subject: [PATCH v2 3/7] bpf/validate: formalize call back requirements
Date: Mon, 14 Sep 2026 15:54:13 +0100
Message-ID: <20260914145418.37353-4-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260914145418.37353-1-marat.khalili@huawei.com>
References: <20260911104006.34364-1-marat.khalili@huawei.com>
 <20260914145418.37353-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100006.china.huawei.com (7.182.19.111) To
 frapema500003.china.huawei.com (7.182.19.114)
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

Formalize requirements to evaluation events in documentation and adjust
their handling in the actual code to match.

Particularly, specify more precisely:
* conditions for each catchpoint callback;
* relative order of callbacks within the step;
* expected value of the program counter;

Behaviour changes:
* one branch-return event is now generated for each branch-enter event
  (previously multiple branch-return events could be coalesced);
* branch-return event now points to the corresponding conditional jump
  (previously past the end of the last branch);
* step event is now only generated before an actual instruction
  evaluation (previously also for branching and finishing events);
* program counter is no longer allowed to point past the program end;

These changes should simplify branch tracking of the validator by tests
and interactive applications. E.g. branch-enter and branch-return events
can now be used to push and pop branching points to/from some stack.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/bpf/bpf_validate.c           | 28 +++++++++----
 lib/bpf/bpf_validate_debug.c     | 72 +++++++++++++++++++-------------
 lib/bpf/bpf_validate_debug.h     |  3 +-
 lib/bpf/rte_bpf_validate_debug.h | 24 +++++++----
 4 files changed, 78 insertions(+), 49 deletions(-)

diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index b317abb81172..f4258c2fb54f 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -2892,6 +2892,23 @@ prune_eval_state(struct bpf_verifier *bvf, const struct inst_node *node,
 	return rc;
 }
 
+static bool
+is_branch_start(const struct inst_node *node)
+{
+	return node->prev_node != NULL && node->prev_node->nb_edge > 1;
+}
+
+static uint64_t
+step_events(const struct inst_node *node)
+{
+	uint64_t events = RTE_BIT64(RTE_BPF_VALIDATE_DEBUG_EVENT_STEP);
+
+	if (is_branch_start(node))
+		events |= RTE_BIT64(RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_ENTER);
+
+	return events;
+}
+
 /* Do second pass through CFG and try to evaluate instructions
  * via each possible path. The verifier will try all paths, tracking types of
  * registers used as input to instructions, and updating resulting type via
@@ -2918,7 +2935,6 @@ evaluate(struct bpf_verifier *bvf)
 	const char *err;
 	const struct ebpf_insn *ins;
 	struct inst_node *next, *node;
-	int prev_nb_edge;  /* branching number of the previous instruction */
 	int rc, debug_rc;
 	struct rte_bpf_validate_debug *const debug = bvf->prm->debug;
 
@@ -2954,7 +2970,6 @@ evaluate(struct bpf_verifier *bvf)
 	ins = bvf->prm->raw.ins;
 	node = bvf->in;
 	next = node;
-	prev_nb_edge = 1;
 
 	memset(&stats, 0, sizeof(stats));
 
@@ -2990,8 +3005,7 @@ evaluate(struct bpf_verifier *bvf)
 			}
 
 			rc = __rte_bpf_validate_debug_evaluate_update(debug, idx,
-				prev_nb_edge > 1 ?
-					RTE_BIT64(RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_ENTER) : 0);
+				step_events(node));
 			if (rc < 0)
 				break;
 
@@ -3047,7 +3061,6 @@ evaluate(struct bpf_verifier *bvf)
 				stats.nb_prune++;
 			} else {
 				next->prev_node = node;
-				prev_nb_edge = node->nb_edge;
 				node = next;
 			}
 		} else {
@@ -3057,9 +3070,9 @@ evaluate(struct bpf_verifier *bvf)
 			 * and proceed with parent.
 			 */
 
-			if (prev_nb_edge != 0) {
+			if (is_branch_start(node)) {
 				rc = __rte_bpf_validate_debug_evaluate_update(
-					debug, get_node_idx(bvf, node) + 1,
+					debug, get_node_idx(bvf, node->prev_node),
 					RTE_BIT64(RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_RETURN));
 				if (rc < 0)
 					break;
@@ -3067,7 +3080,6 @@ evaluate(struct bpf_verifier *bvf)
 
 			node->cur_edge = 0;
 			save_safe_eval_state(bvf, node);
-			prev_nb_edge = 0;
 			node = node->prev_node;
 
 			/* first node will not have prev, signalling finish */
diff --git a/lib/bpf/bpf_validate_debug.c b/lib/bpf/bpf_validate_debug.c
index f76303a7fd2a..db6d13f9cb22 100644
--- a/lib/bpf/bpf_validate_debug.c
+++ b/lib/bpf/bpf_validate_debug.c
@@ -225,6 +225,13 @@ debug_points_call_back(struct rte_bpf_validate_debug *debug,
 	return rc;
 }
 
+/* Call back all breakpoints for the specified program counter. */
+static int
+debug_trigger_breakpoints(struct rte_bpf_validate_debug *debug, uint32_t pc)
+{
+	return debug_points_call_back(debug, &debug->breakpoint_lists[pc]);
+}
+
 /* Call back all catchpoints for the specified event. */
 static int
 debug_send_event(struct rte_bpf_validate_debug *debug, debug_event_t event)
@@ -585,6 +592,21 @@ int
 __rte_bpf_validate_debug_evaluate_update(struct rte_bpf_validate_debug *debug,
 	uint32_t pc, uint64_t events)
 {
+	/* Required order of sent events according to the documentation. */
+	static const enum rte_bpf_validate_debug_event ordered_events[] = {
+		RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_START,
+		RTE_BPF_VALIDATE_DEBUG_EVENT_INVALID_STATE,
+		RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_ENTER,
+		RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_PRUNE,
+		RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_RETURN,
+		RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_UNREACHABLE,
+		RTE_BPF_VALIDATE_DEBUG_EVENT_STEP,
+		RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_SUCCESS,
+		RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_FAILURE,
+	};
+	RTE_BUILD_BUG_ON(
+		RTE_DIM(ordered_events) != RTE_BPF_VALIDATE_DEBUG_EVENT_END);
+
 	int rc;
 
 	if (debug == NULL)
@@ -595,29 +617,31 @@ __rte_bpf_validate_debug_evaluate_update(struct rte_bpf_validate_debug *debug,
 		return -ECHILD;
 	}
 
-	if (pc > debug->bpf_prm->raw.nb_ins)
+	if (pc >= debug->bpf_prm->raw.nb_ins)
 		return -EINVAL;
 
 	debug->pc = pc;
 
 	rc = __rte_bpf_validate_state_is_valid(debug->verifier);
 	if (rc == 0)
-		rc = debug_send_event(debug,
-			RTE_BPF_VALIDATE_DEBUG_EVENT_INVALID_STATE);
+		events |= RTE_BIT64(RTE_BPF_VALIDATE_DEBUG_EVENT_INVALID_STATE);
+
+	for (uint32_t index = 0; index < RTE_DIM(ordered_events); index++) {
+		const enum rte_bpf_validate_debug_event event =
+			ordered_events[index];
+		if ((events & RTE_BIT64(event)) == 0)
+			continue;
 
-	for (enum rte_bpf_validate_debug_event event = 0;
-			event != RTE_BPF_VALIDATE_DEBUG_EVENT_END; ++event)
-		if (events & RTE_BIT64(event))
-			rc = rc < 0 ? rc : debug_send_event(debug, event);
+		if (event == RTE_BPF_VALIDATE_DEBUG_EVENT_STEP)
+			rc = rc < 0 ? rc : debug_trigger_breakpoints(debug, pc);
 
-	if (events == 0 || events == RTE_BIT64(
-			RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_ENTER))
-		/* Stepping into a real instruction to execute. */
-		rc = rc < 0 ? rc : debug_points_call_back(debug,
-			&debug->breakpoint_lists[pc]);
+		rc = rc < 0 ? rc : debug_send_event(debug, event);
+		events -= RTE_BIT64(event);
+	}
 
-	rc = rc < 0 ? rc : debug_send_event(debug,
-		RTE_BPF_VALIDATE_DEBUG_EVENT_STEP);
+	if (events != 0)
+		/* Received unsupported events. */
+		rc = rc < 0 ? rc : -EINVAL;
 
 	return rc;
 }
@@ -627,8 +651,6 @@ __rte_bpf_validate_debug_evaluate_finish(struct rte_bpf_validate_debug *debug,
 	int result)
 {
 	int rc = 0;
-	uint32_t pc;
-	debug_event_t event;
 
 	if (debug == NULL)
 		return 0;
@@ -641,20 +663,10 @@ __rte_bpf_validate_debug_evaluate_finish(struct rte_bpf_validate_debug *debug,
 	debug->evaluate_finished = true;
 	debug->evaluate_result = result;
 
-	if (result != -ECANCELED) {
-		if (result < 0) {
-			/* Last known pc is the place we failed. */
-			pc = debug->pc;
-			event = RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_FAILURE;
-		} else {
-			/* Show program end, not particular instruction. */
-			pc = debug->bpf_prm->raw.nb_ins;
-			event = RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_SUCCESS;
-		}
-
-		rc = __rte_bpf_validate_debug_evaluate_update(debug, pc,
-			RTE_BIT64(event));
-	}
+	if (result != -ECANCELED)
+		rc = debug_send_event(debug, result < 0 ?
+			RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_FAILURE :
+			RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_SUCCESS);
 
 	debug_evaluate_close(debug);
 
diff --git a/lib/bpf/bpf_validate_debug.h b/lib/bpf/bpf_validate_debug.h
index 2b0c3bb646a7..4603841db2ed 100644
--- a/lib/bpf/bpf_validate_debug.h
+++ b/lib/bpf/bpf_validate_debug.h
@@ -53,10 +53,9 @@ __rte_bpf_validate_debug_evaluate_start(struct rte_bpf_validate_debug *debug,
  * @param debug
  *   Validate debug instance configured by user, can be NULL.
  * @param pc
- *   Current value of the program counter, or next after last instruction.
+ *   Current value of the program counter.
  * @param events
  *   Bitmask of events.
- *   Step bit is always implied and should not be set.
  * @return
  *   Non-negative value: evaluation should continue;
  *   -ECANCELED: evaluation should fail without calling this API again;
diff --git a/lib/bpf/rte_bpf_validate_debug.h b/lib/bpf/rte_bpf_validate_debug.h
index f30fa926f10a..b3fedd5428bc 100644
--- a/lib/bpf/rte_bpf_validate_debug.h
+++ b/lib/bpf/rte_bpf_validate_debug.h
@@ -31,25 +31,31 @@ extern "C" {
  * Supported validate events.
  *
  * Valid events begin from 0 and end before `RTE_BPF_VALIDATE_DEBUG_EVENT_END`.
+ *
+ * At any given evaluation step, callbacks are fired in the following order:
+ * - Validation start event;
+ * - Branching and invalid-state events (can be interleaved);
+ * - Instruction breakpoints (before evaluating instruction);
+ * - Step (before evaluating instruction) or validation result (if done) event;
  */
 enum rte_bpf_validate_debug_event {
-	/* Just before every instruction, at branch or validation end. */
+	/* Just before every evaluated instruction. */
 	RTE_BPF_VALIDATE_DEBUG_EVENT_STEP,
 	/* Validator has failed its internal self-checks. */
 	RTE_BPF_VALIDATE_DEBUG_EVENT_INVALID_STATE,
-	/* Start of validation. */
+	/* Start of validation (pc points to first instruction). */
 	RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_START,
-	/* Successful finish of validation. */
+	/* Successful finish (pc undefined). */
 	RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_SUCCESS,
-	/* Finish of validation with error. */
+	/* Finish of validation with error (pc points at error). */
 	RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_FAILURE,
-	/* Beginning of a branch just after the jump. */
+	/* Beginning of a branch evaluation (pc points to branch start). */
 	RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_ENTER,
-	/* Pruning branch as verified earlier. */
+	/* Pruning branch as verified earlier (pc points to branch start). */
 	RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_PRUNE,
-	/* End of branch verification, after the last verified instruction. */
+	/* End of branch verification (pc points to jump instruction). */
 	RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_RETURN,
-	/* Pruning branch as dynamically unreachable. */
+	/* Pruning branch as dynamically unreachable (pc points to branch start). */
 	RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_UNREACHABLE,
 	/* Number of valid event values. */
 	RTE_BPF_VALIDATE_DEBUG_EVENT_END,
@@ -208,7 +214,7 @@ rte_bpf_validate_debug_get_last_point(const struct rte_bpf_validate_debug *debug
  * @param debug
  *   Debug instance.
  * @return
- *   Current program counter being validated, or one after last.
+ *   Current program counter being validated.
  *   UINT32_MAX if no program is being validated.
  */
 __rte_experimental
-- 
2.43.0

