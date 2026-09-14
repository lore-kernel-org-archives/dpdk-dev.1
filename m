Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7D87C88E75
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 14:56:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 131FB410DF;
	Mon, 14 Sep 2026 16:56:31 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 44B7840E8A
 for <dev@dpdk.org>; Mon, 14 Sep 2026 16:56:24 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=RnIQeMtz3L2sZSNsIgaPZriMzpus/Pt2OAplATYmii4=;
 b=nxDr2AiESet8J9WURk1t0xUlBuvZGwk5slfS17svGBkZEQxj3fV6boUfGHc6gxbPllIUjZZIR
 N9vYKux+cM4ZeolZdV4eCFSI54OZDsIoQcnCn2ILwPZGpRkHd8C5lxMk/IcPpnZjzFFhUPDj9js
 H9zotarSeBTRoatv7TEHolI=
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hk7Vn4pDbzJ46ZJ
 for <dev@dpdk.org>; Mon, 14 Sep 2026 22:55:29 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 0F9ED40575
 for <dev@dpdk.org>; Mon, 14 Sep 2026 22:56:21 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 16:56:20 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>
Subject: [PATCH v2 4/7] bpf/validate: add jump notification events
Date: Mon, 14 Sep 2026 15:54:14 +0100
Message-ID: <20260914145418.37353-5-marat.khalili@huawei.com>
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

Add events notifying validate debug client of instructions that may
change program counter. This is particularly useful to an interactive
debugger to track conditional and unconditional jumps without trying to
parse the program and interpret instructions independently.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/bpf/bpf_validate.c           | 10 ++++++++--
 lib/bpf/bpf_validate_debug.c     |  2 ++
 lib/bpf/rte_bpf_validate_debug.h |  5 +++++
 3 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index f4258c2fb54f..d503db836105 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -2899,13 +2899,19 @@ is_branch_start(const struct inst_node *node)
 }
 
 static uint64_t
-step_events(const struct inst_node *node)
+step_events(const struct inst_node *node, uint8_t op)
 {
 	uint64_t events = RTE_BIT64(RTE_BPF_VALIDATE_DEBUG_EVENT_STEP);
 
 	if (is_branch_start(node))
 		events |= RTE_BIT64(RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_ENTER);
 
+	if (op == (BPF_JMP | BPF_JA))
+		events |= RTE_BIT64(RTE_BPF_VALIDATE_DEBUG_EVENT_JUMP_ALWAYS);
+
+	if (node->nb_edge > 1)
+		events |= RTE_BIT64(RTE_BPF_VALIDATE_DEBUG_EVENT_JUMP_CONDITIONAL);
+
 	return events;
 }
 
@@ -3005,7 +3011,7 @@ evaluate(struct bpf_verifier *bvf)
 			}
 
 			rc = __rte_bpf_validate_debug_evaluate_update(debug, idx,
-				step_events(node));
+				step_events(node, op));
 			if (rc < 0)
 				break;
 
diff --git a/lib/bpf/bpf_validate_debug.c b/lib/bpf/bpf_validate_debug.c
index db6d13f9cb22..098a88026d6d 100644
--- a/lib/bpf/bpf_validate_debug.c
+++ b/lib/bpf/bpf_validate_debug.c
@@ -600,6 +600,8 @@ __rte_bpf_validate_debug_evaluate_update(struct rte_bpf_validate_debug *debug,
 		RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_PRUNE,
 		RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_RETURN,
 		RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_UNREACHABLE,
+		RTE_BPF_VALIDATE_DEBUG_EVENT_JUMP_ALWAYS,
+		RTE_BPF_VALIDATE_DEBUG_EVENT_JUMP_CONDITIONAL,
 		RTE_BPF_VALIDATE_DEBUG_EVENT_STEP,
 		RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_SUCCESS,
 		RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_FAILURE,
diff --git a/lib/bpf/rte_bpf_validate_debug.h b/lib/bpf/rte_bpf_validate_debug.h
index b3fedd5428bc..f1ee8769d06a 100644
--- a/lib/bpf/rte_bpf_validate_debug.h
+++ b/lib/bpf/rte_bpf_validate_debug.h
@@ -35,6 +35,7 @@ extern "C" {
  * At any given evaluation step, callbacks are fired in the following order:
  * - Validation start event;
  * - Branching and invalid-state events (can be interleaved);
+ * - Jump-instruction events (before evaluating jump instruction);
  * - Instruction breakpoints (before evaluating instruction);
  * - Step (before evaluating instruction) or validation result (if done) event;
  */
@@ -57,6 +58,10 @@ enum rte_bpf_validate_debug_event {
 	RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_RETURN,
 	/* Pruning branch as dynamically unreachable (pc points to branch start). */
 	RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_UNREACHABLE,
+	/* Program counter points to a jump-always instruction. */
+	RTE_BPF_VALIDATE_DEBUG_EVENT_JUMP_ALWAYS,
+	/* Program counter points to a conditional jump instruction. */
+	RTE_BPF_VALIDATE_DEBUG_EVENT_JUMP_CONDITIONAL,
 	/* Number of valid event values. */
 	RTE_BPF_VALIDATE_DEBUG_EVENT_END,
 };
-- 
2.43.0

