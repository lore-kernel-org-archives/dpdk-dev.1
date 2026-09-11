Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA704C88E4A
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 10:41:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D572C42DD3;
	Fri, 11 Sep 2026 12:41:21 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 55380427C2
 for <dev@dpdk.org>; Fri, 11 Sep 2026 12:41:18 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=XPmCsCGW+zKxrmqeF2xzcayQ31Rf9YpfitlOT0lYBvc=;
 b=xpCkEclylBy8USqfsEJA3q7TzjVemAnPPRv8QfwREo192u3d10t9mnHKfHi+c4iz4EoT6zLjW
 rGOG/XJnOxpGlvg/xEuA8OzbXvhRcI4kJYMSH8lD2zg7AITZx+htcZ8MzqTIrP0d6Ty6uFabJEU
 mCoq+TaEyBB1VaMT31uTipw=
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hh9zz0pzJzJ468D
 for <dev@dpdk.org>; Fri, 11 Sep 2026 18:40:31 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 3726C40570
 for <dev@dpdk.org>; Fri, 11 Sep 2026 18:41:17 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Fri, 11 Sep 2026 12:41:16 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>
Subject: [PATCH 2/7] bpf/validate: refactor internal step function
Date: Fri, 11 Sep 2026 11:40:00 +0100
Message-ID: <20260911104006.34364-3-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260911104006.34364-1-marat.khalili@huawei.com>
References: <20260911104006.34364-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500005.china.huawei.com (7.182.19.99) To
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

Rename `__rte_bpf_validate_debug_evaluate_step` to
`__rte_bpf_validate_debug_evaluate_update` to better reflect planned
usage, and make it accept a bitmask of events instead of a single event.

Step event is still implicitly triggered for now.

No functional changes.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/bpf/bpf_validate.c       | 17 ++++++++---------
 lib/bpf/bpf_validate_debug.c | 20 +++++++++++---------
 lib/bpf/bpf_validate_debug.h | 11 ++++++-----
 3 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index f9960088a285..b317abb81172 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -2989,10 +2989,9 @@ evaluate(struct bpf_verifier *bvf)
 				break;
 			}
 
-			rc = __rte_bpf_validate_debug_evaluate_step(debug, idx,
+			rc = __rte_bpf_validate_debug_evaluate_update(debug, idx,
 				prev_nb_edge > 1 ?
-					RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_ENTER :
-					RTE_BPF_VALIDATE_DEBUG_EVENT_STEP);
+					RTE_BIT64(RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_ENTER) : 0);
 			if (rc < 0)
 				break;
 
@@ -3024,9 +3023,9 @@ evaluate(struct bpf_verifier *bvf)
 			}
 
 			if (bvf->evst->unreachable) {
-				rc = __rte_bpf_validate_debug_evaluate_step(
+				rc = __rte_bpf_validate_debug_evaluate_update(
 					debug, get_node_idx(bvf, next),
-					RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_UNREACHABLE);
+					RTE_BIT64(RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_UNREACHABLE));
 				if (rc < 0)
 					break;
 
@@ -3038,9 +3037,9 @@ evaluate(struct bpf_verifier *bvf)
 			 */
 			} else if (node->nb_edge > 1 &&
 					prune_eval_state(bvf, node, next) == 0) {
-				rc = __rte_bpf_validate_debug_evaluate_step(
+				rc = __rte_bpf_validate_debug_evaluate_update(
 					debug, get_node_idx(bvf, next),
-					RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_PRUNE);
+					RTE_BIT64(RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_PRUNE));
 				if (rc < 0)
 					break;
 
@@ -3059,9 +3058,9 @@ evaluate(struct bpf_verifier *bvf)
 			 */
 
 			if (prev_nb_edge != 0) {
-				rc = __rte_bpf_validate_debug_evaluate_step(
+				rc = __rte_bpf_validate_debug_evaluate_update(
 					debug, get_node_idx(bvf, node) + 1,
-					RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_RETURN);
+					RTE_BIT64(RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_RETURN));
 				if (rc < 0)
 					break;
 			}
diff --git a/lib/bpf/bpf_validate_debug.c b/lib/bpf/bpf_validate_debug.c
index 9a039766322c..f76303a7fd2a 100644
--- a/lib/bpf/bpf_validate_debug.c
+++ b/lib/bpf/bpf_validate_debug.c
@@ -582,8 +582,8 @@ __rte_bpf_validate_debug_evaluate_start(struct rte_bpf_validate_debug *debug,
 }
 
 int
-__rte_bpf_validate_debug_evaluate_step(struct rte_bpf_validate_debug *debug,
-	uint32_t pc, debug_event_t event)
+__rte_bpf_validate_debug_evaluate_update(struct rte_bpf_validate_debug *debug,
+	uint32_t pc, uint64_t events)
 {
 	int rc;
 
@@ -595,8 +595,7 @@ __rte_bpf_validate_debug_evaluate_step(struct rte_bpf_validate_debug *debug,
 		return -ECHILD;
 	}
 
-	if (pc > debug->bpf_prm->raw.nb_ins || event < 0 ||
-			event >= RTE_BPF_VALIDATE_DEBUG_EVENT_END)
+	if (pc > debug->bpf_prm->raw.nb_ins)
 		return -EINVAL;
 
 	debug->pc = pc;
@@ -606,11 +605,13 @@ __rte_bpf_validate_debug_evaluate_step(struct rte_bpf_validate_debug *debug,
 		rc = debug_send_event(debug,
 			RTE_BPF_VALIDATE_DEBUG_EVENT_INVALID_STATE);
 
-	if (event != RTE_BPF_VALIDATE_DEBUG_EVENT_STEP)
-		rc = rc < 0 ? rc : debug_send_event(debug, event);
+	for (enum rte_bpf_validate_debug_event event = 0;
+			event != RTE_BPF_VALIDATE_DEBUG_EVENT_END; ++event)
+		if (events & RTE_BIT64(event))
+			rc = rc < 0 ? rc : debug_send_event(debug, event);
 
-	if (event == RTE_BPF_VALIDATE_DEBUG_EVENT_STEP ||
-			event == RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_ENTER)
+	if (events == 0 || events == RTE_BIT64(
+			RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_ENTER))
 		/* Stepping into a real instruction to execute. */
 		rc = rc < 0 ? rc : debug_points_call_back(debug,
 			&debug->breakpoint_lists[pc]);
@@ -651,7 +652,8 @@ __rte_bpf_validate_debug_evaluate_finish(struct rte_bpf_validate_debug *debug,
 			event = RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_SUCCESS;
 		}
 
-		rc = __rte_bpf_validate_debug_evaluate_step(debug, pc, event);
+		rc = __rte_bpf_validate_debug_evaluate_update(debug, pc,
+			RTE_BIT64(event));
 	}
 
 	debug_evaluate_close(debug);
diff --git a/lib/bpf/bpf_validate_debug.h b/lib/bpf/bpf_validate_debug.h
index a91f3e9c48b2..2b0c3bb646a7 100644
--- a/lib/bpf/bpf_validate_debug.h
+++ b/lib/bpf/bpf_validate_debug.h
@@ -46,7 +46,7 @@ __rte_bpf_validate_debug_evaluate_start(struct rte_bpf_validate_debug *debug,
 	const struct bpf_verifier *verifier, const struct rte_bpf_prm_ex *bpf_prm);
 
 /*
- * Signal each instruction, branch end, or evaluation end.
+ * Signal evaluation events.
  *
  * Immediately return 0 if debug is NULL.
  *
@@ -54,16 +54,17 @@ __rte_bpf_validate_debug_evaluate_start(struct rte_bpf_validate_debug *debug,
  *   Validate debug instance configured by user, can be NULL.
  * @param pc
  *   Current value of the program counter, or next after last instruction.
- * @param event
- *   Specific evaluation event if any, or RTE_BPF_VALIDATE_DEBUG_EVENT_STEP.
+ * @param events
+ *   Bitmask of events.
+ *   Step bit is always implied and should not be set.
  * @return
  *   Non-negative value: evaluation should continue;
  *   -ECANCELED: evaluation should fail without calling this API again;
  *   Other negative value: evaluation should fail signalling failure;
  */
 int
-__rte_bpf_validate_debug_evaluate_step(struct rte_bpf_validate_debug *debug,
-	uint32_t pc, debug_event_t event);
+__rte_bpf_validate_debug_evaluate_update(struct rte_bpf_validate_debug *debug,
+	uint32_t pc, uint64_t events);
 
 /*
  * Signal end of evaluation process.
-- 
2.43.0

