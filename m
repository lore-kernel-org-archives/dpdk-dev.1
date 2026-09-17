Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32024C982D6
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 14:36:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE87642E9C;
	Thu, 17 Sep 2026 16:36:39 +0200 (CEST)
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com
 [74.125.228.76]) by mails.dpdk.org (Postfix) with ESMTP id AD23542E88
 for <dev@dpdk.org>; Thu, 17 Sep 2026 16:36:36 +0200 (CEST)
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a996c8adf3so1549522a12.1
 for <dev@dpdk.org>; Thu, 17 Sep 2026 07:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789655796; x=1790260596; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=oaAp0OOtstBKOonsA50H1zuxDnzdZqGwWxk/EGT/RRk=;
 b=XL/418FrF1XTVq1EZ5wCjF+0lNhwCdJJv6BgLTQbdU2l/daC6pv8/8A1yL9BjxKQCS
 zwaXRyRJK7Zb9oCeZc8uvjcvmj2W7AQ59FUaBlM+gCTTFON3iuyceIatdMw2cTaTmxtM
 ecEFMo/ID2O5AFMQcSUKVIychmCwvXl9s6g2pUN2B9PN8GdzYxsa1kk/N8wcE1VspR6C
 +R/CJlTBAcdsQc6yrWyUWDqPYmjoqHEWxRN9Xb08uq2gdPNK9WTFlF8zLNhFqm6S4KH+
 qViZvXXl+1BGSKZs1bDhvbCP9fTB1z+gv73ZfyC6aDuDtWFYRev4U7wSCBHqXmL+Z6LK
 aCSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789655796; x=1790260596;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=oaAp0OOtstBKOonsA50H1zuxDnzdZqGwWxk/EGT/RRk=;
 b=VLWK2o1lwXYTcr3Shc2/n7nsCRZxHuijWXbTY/8VTJx5wVtWvjw6iKUK41AR3K1OTO
 /bYG9tJbK3Dfg3Q7tdeQSm0s1f6Pu37fzNxWPHAdmb9q/KgtcxMHRI8ugDKKi4dn6PZW
 ICQYqUnhsdK/KabuZ2PGt+PrGPKbJ6jBbU19Dky/lY9QHBDBrWhfrRnzUn+HeEhJdsip
 C3OT/vT+6Nd8CntDnfk82uoqhcH1TsyAYQZVOStZXj87doOj7LrYwu1sxGcXoky49baN
 JvuqYV8hA5BH/ONyMgseUkWgJqMAX7XsVKrHiCkX/+LCRCjoMKPXsqSmrnm2KH4nknc6
 y3sg==
X-Gm-Message-State: AFuF++k4bht/WPdBCiZwCDjpsu39rrh8AYpysgRLnaYFvZbHrpqfM56C
 KKPT7OLiM9UJG/eIbzkmnaly8ZFw/2ebSBgFsepH0sjtvhn61OCjLm9h3JQy+ACjLEg=
X-Gm-Gg: AYBFou3HgqCB4aDU4r8wUkSCYCGqP8bo0z2kstn1n9UazA1DVt5jnMAjotP0q4QUBN3
 UabMl/RuOIjuIqmpoEsxk/WLnRcks6AzuAKsroyybcN9vlO/08hAPc98W5oASdOB5Zdn8MYN1Dk
 wSHqUyP9h4r0O473tpFQl0SIUx4ed6jG8ocF+hpXv71z0ZL2MOAtuULgF5oVbwnXUAh9ChhPG4T
 /osLICQMRQyS2vxSvTVh+Zde5kmXespuujciajR8DKcjVwIzVRDVnD7cdyTKCtCFviubNkmwjNL
 Q8jq1Sy0xWn9UxKFAuzMvS90N+1lMJwL2L2ineFLEqwvbD4yE8ev68FaJ+GWN4tcJUX03Khg69h
 orOzGNY/trYNpuh5BeRKgZWfExu9+fFK0ewsPNoEJUXFa5Ak2oOto3sqmgrGZdm0DkhShuwA+h/
 ecONZfE7wvkfS6vu1S6m2jZAN4IamJifuM5kjeCLoQvNwb1idD9OUrpktzCYUXo1z16fDWPA==
X-Received: by 2002:a05:6402:52c4:b0:6a3:ff14:ebc9 with SMTP id
 4fb4d7f45d1cf-6aa22402ed1mr9760951a12.11.1789655795940; 
 Thu, 17 Sep 2026 07:36:35 -0700 (PDT)
Received: from dpdk.lxd ([89.101.57.120]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa1d2727bfsm3440986a12.20.2026.09.17.07.36.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:36:35 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org, Marat Khalili <marat.khalili@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 3/7] bpf/validate: formalize call back requirements
Date: Thu, 17 Sep 2026 14:35:33 +0000
Message-ID: <20260917143539.46951-4-qm2k21@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917143539.46951-1-qm2k21@gmail.com>
References: <20260915192626.48125-1-marat.khalili@huawei.com>
 <20260917143539.46951-1-qm2k21@gmail.com>
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

From: Marat Khalili <marat.khalili@huawei.com>

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
index b317abb811..f4258c2fb5 100644
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
index f76303a7fd..db6d13f9cb 100644
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
index 2b0c3bb646..4603841db2 100644
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
index f30fa926f1..b3fedd5428 100644
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

