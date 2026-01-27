Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E302DD2F000
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 11:51:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 86C7F40ED2;
	Tue, 27 Jan 2026 12:50:42 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id 7153340E49;
 Tue, 27 Jan 2026 12:50:39 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4f0kGz2xlBzJ469b;
 Tue, 27 Jan 2026 19:50:03 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 4A2D040086;
 Tue, 27 Jan 2026 19:50:39 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 27 Jan 2026 12:50:38 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: <dev@dpdk.org>, Konstantin Ananyev <konstantin.ananyev@huawei.com>, Ferruh
 Yigit <ferruh.yigit@amd.com>
CC: <jerinjacobk@gmail.com>, <mb@smartsharesystems.com>,
 <stephen@networkplumber.org>, <stable@dpdk.org>
Subject: [PATCH v4 6/6] bpf: fix validation when conditional jump is first
 instruction
Date: Tue, 27 Jan 2026 11:49:42 +0000
Message-ID: <20260127114944.35993-7-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260127114944.35993-1-marat.khalili@huawei.com>
References: <20251217180141.60227-1-marat.khalili@huawei.com>
 <20260127114944.35993-1-marat.khalili@huawei.com>
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

When the BPF program was starting with a conditional jump only one
(true) execution branch of the program was evaluated. Any instructions
jumped over were not evaluated and could contain invalid operations.
The root cause was using zero instruction index as a signal for ending
evaluation when backtracking.

Switch from using previous instruction index for tracking execution
history to a previous instruction pointer. First instruction will not
have it set, and therefore backtracking _from_ it will end evaluation,
not backtracking _to_ it like before.

Add two tests demonstrating the problem:
* test_jump_over_invalid_first: loads BPF program with
  conditional jump over the invalid operation, should not succeed;
* test_jump_over_invalid_non_first: same program with one extra
  instruction at the start to demonstrate that it is indeed invalid
  (and also guard against another kind of regression);

Fixes: 6e12ec4c4d6d ("bpf: add more checks")
Cc: stable@dpdk.org

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Tested-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Acked-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_bpf.c    | 80 ++++++++++++++++++++++++++++++++++++++++++
 lib/bpf/bpf_validate.c | 20 ++++-------
 2 files changed, 86 insertions(+), 14 deletions(-)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 54603c7c30..9cb4761bd0 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -208,6 +208,86 @@ test_subtract_one(void)
 
 REGISTER_FAST_TEST(bpf_subtract_one_autotest, NOHUGE_OK, ASAN_OK, test_subtract_one);
 
+/*
+ * Conditionally jump over invalid operation as first instruction.
+ */
+static int
+test_jump_over_invalid_first(void)
+{
+	static const struct ebpf_insn ins[] = {
+		{
+			/* Jump over the next instruction for some r1. */
+			.code = (BPF_JMP | BPF_JEQ | BPF_K),
+			.dst_reg = EBPF_REG_1,
+			.imm = 42,
+			.off = 1,
+		},
+		{
+			/* Write 0xDEADBEEF to [r1 + INT16_MIN]. */
+			.code = (BPF_ST | BPF_MEM | EBPF_DW),
+			.dst_reg = EBPF_REG_1,
+			.off = INT16_MIN,
+			.imm = 0xDEADBEEF,
+		},
+		{
+			/* Set return value to the program argument. */
+			.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
+			.src_reg = EBPF_REG_1,
+			.dst_reg = EBPF_REG_0,
+		},
+		{
+			.code = (BPF_JMP | EBPF_EXIT),
+		},
+	};
+	return bpf_load_test(RTE_DIM(ins), ins, EINVAL);
+}
+
+REGISTER_FAST_TEST(bpf_jump_over_invalid_first_autotest, NOHUGE_OK, ASAN_OK,
+	test_jump_over_invalid_first);
+
+/*
+ * Conditionally jump over invalid operation as non-first instruction.
+ */
+static int
+test_jump_over_invalid_non_first(void)
+{
+	static const struct ebpf_insn ins[] = {
+		{
+			/* Set return value to the program argument. */
+			.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
+			.src_reg = EBPF_REG_1,
+			.dst_reg = EBPF_REG_0,
+		},
+		{
+			/* Jump over the next instruction for some r1. */
+			.code = (BPF_JMP | BPF_JEQ | BPF_K),
+			.dst_reg = EBPF_REG_1,
+			.imm = 42,
+			.off = 1,
+		},
+		{
+			/* Write 0xDEADBEEF to [r1 + INT16_MIN]. */
+			.code = (BPF_ST | BPF_MEM | EBPF_DW),
+			.dst_reg = EBPF_REG_1,
+			.off = INT16_MIN,
+			.imm = 0xDEADBEEF,
+		},
+		{
+			/* Set return value to the program argument. */
+			.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
+			.src_reg = EBPF_REG_1,
+			.dst_reg = EBPF_REG_0,
+		},
+		{
+			.code = (BPF_JMP | EBPF_EXIT),
+		},
+	};
+	return bpf_load_test(RTE_DIM(ins), ins, EINVAL);
+}
+
+REGISTER_FAST_TEST(bpf_jump_over_invalid_non_first_autotest, NOHUGE_OK, ASAN_OK,
+	test_jump_over_invalid_non_first);
+
 /*
  * Basic functional tests for librte_bpf.
  * The main procedure - load eBPF program, execute it and
diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index 47ad6fef0f..64a8f227a3 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -64,7 +64,7 @@ struct inst_node {
 	uint8_t cur_edge:4;
 	uint8_t edge_type[MAX_EDGES];
 	uint32_t edge_dest[MAX_EDGES];
-	uint32_t prev_node;
+	struct inst_node *prev_node;
 	struct {
 		struct bpf_eval_state *cur;   /* save/restore for jcc targets */
 		struct bpf_eval_state *start;
@@ -1875,12 +1875,6 @@ set_edge_type(struct bpf_verifier *bvf, struct inst_node *node,
 	bvf->edge_type[type]++;
 }
 
-static struct inst_node *
-get_prev_node(struct bpf_verifier *bvf, struct inst_node *node)
-{
-	return  bvf->in + node->prev_node;
-}
-
 /*
  * Depth-First Search (DFS) through previously constructed
  * Control Flow Graph (CFG).
@@ -1916,7 +1910,7 @@ dfs(struct bpf_verifier *bvf)
 
 			if (next != NULL) {
 				/* proceed with next child */
-				next->prev_node = get_node_idx(bvf, node);
+				next->prev_node = node;
 				node = next;
 			} else {
 				/*
@@ -1925,7 +1919,7 @@ dfs(struct bpf_verifier *bvf)
 				 */
 				set_node_colour(bvf, node, BLACK);
 				node->cur_edge = 0;
-				node = get_prev_node(bvf, node);
+				node = node->prev_node;
 			}
 		} else
 			node = NULL;
@@ -2490,7 +2484,7 @@ evaluate(struct bpf_verifier *bvf)
 				next = NULL;
 				stats.nb_prune++;
 			} else {
-				next->prev_node = get_node_idx(bvf, node);
+				next->prev_node = node;
 				node = next;
 			}
 		} else {
@@ -2501,11 +2495,9 @@ evaluate(struct bpf_verifier *bvf)
 			 */
 			node->cur_edge = 0;
 			save_safe_eval_state(bvf, node);
-			node = get_prev_node(bvf, node);
+			node = node->prev_node;
 
-			/* finished */
-			if (node == bvf->in)
-				node = NULL;
+			/* first node will not have prev, signalling finish */
 		}
 	}
 
-- 
2.34.1

