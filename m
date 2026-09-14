Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA9ECC88E72
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Sep 2026 14:56:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E2C7640EE3;
	Mon, 14 Sep 2026 16:56:28 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 3560D40E64
 for <dev@dpdk.org>; Mon, 14 Sep 2026 16:56:24 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=sgrMmuXqVOPa4pJKM74EWZdRqlFh7TGdyqViEUSILiM=;
 b=HPlumgSocG8YE8beCnv37pQ4JNVAM5Ju20n0GRX8gGfCqyYNKZjoq+zdD3Iya9B1KkDA2EgyO
 webI2Z+1pwR4iq+FNJ/ykB1+G4LXGm4Yn4n1WrqwAGikUV+R1TXNdSnQ2ZqWdZ4GhgTqZPsvaRb
 VzhbhTh9vm1ZzLtOPqHqQFg=
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4hk7Wb2Sz1zHnGgs
 for <dev@dpdk.org>; Mon, 14 Sep 2026 22:56:11 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 10CE040575
 for <dev@dpdk.org>; Mon, 14 Sep 2026 22:56:22 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.46; Mon, 14 Sep 2026 16:56:21 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>
Subject: [PATCH v2 6/7] app/test: add test for bpf validate debug events
Date: Mon, 14 Sep 2026 15:54:16 +0100
Message-ID: <20260914145418.37353-7-marat.khalili@huawei.com>
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

Add a test that verifies that eBPF validator generates callbacks with
the number, order and program counter specified in the documentation.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test_bpf_validate.c | 341 ++++++++++++++++++++++++++++++++++-
 1 file changed, 337 insertions(+), 4 deletions(-)

diff --git a/app/test/test_bpf_validate.c b/app/test/test_bpf_validate.c
index 066f1fa156ae..ea4621b257f4 100644
--- a/app/test/test_bpf_validate.c
+++ b/app/test/test_bpf_validate.c
@@ -9,10 +9,6 @@
 #include <rte_bpf_validate_debug.h>
 #include <rte_errno.h>
 
-/*
- * Tests of BPF validation.
- */
-
 extern int test_bpf_validate_logtype;
 #define RTE_LOGTYPE_TEST_BPF_VALIDATE test_bpf_validate_logtype
 #define TEST_LOG_LINE(level, ...) \
@@ -26,6 +22,343 @@ RTE_LOG_REGISTER(test_bpf_validate_logtype, test.bpf_validate, NOTICE);
 /* Special value indicating that register variable is not being used. */
 #define NO_REGISTER UINT8_MAX
 
+static const char *const event_names[RTE_BPF_VALIDATE_DEBUG_EVENT_END] = {
+	[RTE_BPF_VALIDATE_DEBUG_EVENT_STEP] = "step",
+	[RTE_BPF_VALIDATE_DEBUG_EVENT_INVALID_STATE] = "invalid-state",
+	[RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_START] = "validation-start",
+	[RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_SUCCESS] = "validation-success",
+	[RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_FAILURE] = "validation-failure",
+	[RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_ENTER] = "branch-enter",
+	[RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_PRUNE] = "branch-prune",
+	[RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_RETURN] = "branch-return",
+	[RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_UNREACHABLE] = "branch-unreachable",
+	[RTE_BPF_VALIDATE_DEBUG_EVENT_JUMP_ALWAYS] = "jump-always",
+	[RTE_BPF_VALIDATE_DEBUG_EVENT_JUMP_CONDITIONAL] = "jump-conditional",
+};
+
+/*
+ * Self-test of BPF validation debug events.
+ */
+
+#define EVENT_BIT(name) RTE_BIT64(RTE_BPF_VALIDATE_DEBUG_EVENT_ ## name)
+#define EVENT_BITS_ALL RTE_LEN2MASK(RTE_BPF_VALIDATE_DEBUG_EVENT_END, uint64_t)
+
+struct test_events_context {
+	/* Tested program. */
+	const struct ebpf_insn *ins;
+	uint32_t nb_ins;
+	/* Number of times each of the events was encountered. */
+	int event_counts[RTE_BPF_VALIDATE_DEBUG_EVENT_END];
+	/* Events active within the current step. */
+	uint64_t active_events;
+	/* Breakpoint was called within the current step. */
+	bool breakpoint_called;
+	/* Currently active conditional jump pc. */
+	uint32_t branch_pc;
+	/* Program counters of all conditional jumps in the current code path. */
+	uint32_t branch_pc_stack[4];
+	size_t branch_pc_stack_length;
+};
+
+/* Push current branch_pc to stack and clear it. */
+static int
+test_events_branch_pc_push(struct test_events_context *ctx)
+{
+	TEST_ASSERT_NOT_EQUAL(ctx->branch_pc, NO_PROGRAM_COUNTER,
+		"no branch pc to push");
+	TEST_ASSERT(ctx->branch_pc_stack_length < RTE_DIM(ctx->branch_pc_stack),
+		"branch stack overflow");
+	ctx->branch_pc_stack[ctx->branch_pc_stack_length++] = ctx->branch_pc;
+	ctx->branch_pc = NO_PROGRAM_COUNTER;
+	return TEST_SUCCESS;
+}
+
+/* Pop branch_pc from stack. */
+static int
+test_events_branch_pc_pop(struct test_events_context *ctx)
+{
+	TEST_ASSERT(ctx->branch_pc_stack_length > 0, "branch stack underflow");
+	ctx->branch_pc = ctx->branch_pc_stack[--ctx->branch_pc_stack_length];
+	return TEST_SUCCESS;
+}
+
+/* Verify breakpoint, checking that it is only called once and remembering it. */
+static int
+test_events_break_cb(struct rte_bpf_validate_debug *debug, void *void_ctx)
+{
+	struct test_events_context *const ctx = void_ctx;
+	const uint32_t pc = rte_bpf_validate_debug_get_pc(debug);
+
+	TEST_LOG_LINE(DEBUG, "%2u: break", pc);
+
+	TEST_ASSERT(!ctx->breakpoint_called,
+		"breakpoint called again at pc %u", pc);
+	ctx->breakpoint_called = true;
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Verify event, checking that:
+ * - validation-start is called at pc 0;
+ * - branch-return is called at a corresponding conditional jump pc;
+ * - branch-enter and branch-return are correctly paired;
+ * - jump-conditional and jump-always are called for corresponding opcodes;
+ * - jump-conditional and only it is followed by branches events;
+ * - events and breakpoints are correctly ordered;
+ *
+ * Increment event counter to compare against expected counts later.
+ */
+static int
+test_events_catch_cb(struct rte_bpf_validate_debug *debug, void *void_ctx)
+{
+	/* Bitmask of events allowed to precede each given event within the step. */
+	static const uint64_t allowed_preceding_events[] = {
+		[RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_START] = 0,
+		[RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_PRUNE] =
+			EVENT_BIT(BRANCH_PRUNE) |
+			EVENT_BIT(BRANCH_UNREACHABLE) |
+			EVENT_BIT(BRANCH_RETURN),
+		[RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_UNREACHABLE] =
+			EVENT_BIT(BRANCH_PRUNE) |
+			EVENT_BIT(BRANCH_UNREACHABLE) |
+			EVENT_BIT(BRANCH_RETURN),
+		[RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_ENTER] =
+			EVENT_BIT(BRANCH_PRUNE) |
+			EVENT_BIT(BRANCH_UNREACHABLE) |
+			EVENT_BIT(BRANCH_RETURN),
+		[RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_RETURN] =
+			EVENT_BIT(BRANCH_PRUNE) |
+			EVENT_BIT(BRANCH_UNREACHABLE) |
+			EVENT_BIT(BRANCH_RETURN),
+		[RTE_BPF_VALIDATE_DEBUG_EVENT_JUMP_CONDITIONAL] =
+			EVENT_BIT(BRANCH_ENTER) |
+			EVENT_BIT(BRANCH_PRUNE) |
+			EVENT_BIT(BRANCH_UNREACHABLE) |
+			EVENT_BIT(BRANCH_RETURN),
+		[RTE_BPF_VALIDATE_DEBUG_EVENT_JUMP_ALWAYS] =
+			EVENT_BIT(BRANCH_ENTER) |
+			EVENT_BIT(BRANCH_PRUNE) |
+			EVENT_BIT(BRANCH_UNREACHABLE) |
+			EVENT_BIT(BRANCH_RETURN),
+		[RTE_BPF_VALIDATE_DEBUG_EVENT_STEP] =
+			EVENT_BITS_ALL - EVENT_BIT(VALIDATION_SUCCESS),
+		[RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_SUCCESS] =
+			EVENT_BIT(BRANCH_PRUNE) |
+			EVENT_BIT(BRANCH_UNREACHABLE) |
+			EVENT_BIT(BRANCH_RETURN),
+	};
+
+	struct test_events_context *const ctx = void_ctx;
+	const enum rte_bpf_validate_debug_event event =
+		rte_bpf_validate_debug_get_event(debug);
+	const uint32_t pc = rte_bpf_validate_debug_get_pc(debug);
+
+	TEST_LOG_LINE(DEBUG, "%2u: %s", pc, event_names[event]);
+
+	/* Verify event program counter and underlying instruction. */
+	switch (event) {
+	case RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_START:
+		TEST_ASSERT_EQUAL(pc, 0,
+			"event %s called at pc %u",
+			event_names[event], pc);
+		break;
+	case RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_ENTER:
+		TEST_ASSERT_SUCCESS(test_events_branch_pc_push(ctx),
+			"error pushing branch for event %s at pc %u",
+			event_names[event], pc);
+		break;
+	case RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_RETURN:
+		TEST_ASSERT_SUCCESS(test_events_branch_pc_pop(ctx),
+			"error popping branch for event %s at pc %u",
+			event_names[event], pc);
+		TEST_ASSERT_EQUAL(pc, ctx->branch_pc,
+			"event %s called at pc %u after jump pc %u",
+			event_names[event], pc, ctx->branch_pc);
+		break;
+	case RTE_BPF_VALIDATE_DEBUG_EVENT_JUMP_ALWAYS:
+		TEST_ASSERT_EQUAL(BPF_CLASS(ctx->ins[pc].code), BPF_JMP,
+			"event %s called at non-jump pc %u",
+			event_names[event], pc);
+		TEST_ASSERT_EQUAL(BPF_OP(ctx->ins[pc].code), BPF_JA,
+			"event %s called at non-jump-always pc %u",
+			event_names[event], pc);
+		break;
+	case RTE_BPF_VALIDATE_DEBUG_EVENT_JUMP_CONDITIONAL:
+		TEST_ASSERT_EQUAL(BPF_CLASS(ctx->ins[pc].code), BPF_JMP,
+			"event %s called at non-jump pc %u",
+			event_names[event], pc);
+		TEST_ASSERT_NOT_EQUAL(BPF_OP(ctx->ins[pc].code), BPF_JA,
+			"event %s called at jump-always pc %u",
+			event_names[event], pc);
+		break;
+	default:
+		break;
+	}
+
+	/* Verify events order. */
+	TEST_ASSERT_EQUAL(
+		(ctx->active_events & ~allowed_preceding_events[event]), 0,
+		"event %s at pc %u preceded by %#jx",
+		event_names[event], pc, (uintmax_t)ctx->active_events);
+
+	/* Update events for the current step as well as branch program counter. */
+	if (event != RTE_BPF_VALIDATE_DEBUG_EVENT_STEP) {
+		TEST_ASSERT(!ctx->breakpoint_called,
+			"event %s called after a breakpoint at pc %u",
+			event_names[event], pc);
+		ctx->active_events |= RTE_BIT64(event);
+	} else {
+		TEST_ASSERT_EQUAL(ctx->branch_pc, NO_PROGRAM_COUNTER,
+			"no branch-enter between branch- and next instruction");
+
+		if (ctx->active_events & EVENT_BIT(JUMP_CONDITIONAL))
+			/* Remember branch instruction pointer, branches to follow. */
+			ctx->branch_pc = pc;
+
+		TEST_ASSERT(ctx->breakpoint_called,
+			"step called before or without a breakpoint at pc %u", pc);
+
+		/* Prepare for the next step. */
+		ctx->active_events = 0;
+		ctx->breakpoint_called = false;
+	}
+
+	/* Update total event counts. */
+	++ctx->event_counts[event];
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * This test verifies that eBPF validator generates expected numbers of events
+ * of each kind in the expected order (e.g. step after jump after branch).
+ */
+static int
+test_events(void)
+{
+	/*
+	 * Program demonstrating the following properties:
+	 * - prunnable code paths;
+	 * - dynamically unreachable code paths;
+	 * - conditional jumps landing on conditional jumps;
+	 * - conditional jumps landing on unconditional jumps;
+	 */
+	static const struct ebpf_insn ins[] = {
+		/*  0: r0 = 0 */
+		{ .code = (EBPF_ALU64 | EBPF_MOV | BPF_K), .dst_reg = EBPF_REG_0, .imm = 0 },
+		/*  1: if r1 > 0 goto 4 */
+		{ .code = (BPF_JMP | BPF_JGT | BPF_K), .dst_reg = EBPF_REG_1, .imm = 0, .off = 2 },
+		/*  2: r1 = 0 */
+		{ .code = (EBPF_ALU64 | EBPF_MOV | BPF_K), .dst_reg = EBPF_REG_1, .imm = 0 },
+		/*  3: if r0 < 1 goto 8 */
+		{ .code = (BPF_JMP | EBPF_JLT | BPF_K), .dst_reg = EBPF_REG_0, .imm = 1, .off = 4 },
+		/*  4: if r1 > 0 goto 6 */
+		{ .code = (BPF_JMP | BPF_JGT | BPF_K), .dst_reg = EBPF_REG_1, .imm = 0, .off = 1 },
+		/*  5: goto 9 */
+		{ .code = (BPF_JMP | BPF_JA), .off = 3 },
+		/*  6: r1 = 0 */
+		{ .code = (EBPF_ALU64 | EBPF_MOV | BPF_K), .dst_reg = EBPF_REG_1, .imm = 0 },
+		/*  7: if r0 > 0 goto 9 */
+		{ .code = (BPF_JMP | BPF_JGT | BPF_K), .dst_reg = EBPF_REG_0, .imm = 0, .off = 1 },
+		/*  8: goto 10 */
+		{ .code = (BPF_JMP | BPF_JA), .off = 1 },
+		/*  9: r0 = 1 */
+		{ .code = (EBPF_ALU64 | EBPF_MOV | BPF_K), .dst_reg = EBPF_REG_0, .imm = 1 },
+		/* 10: exit */
+		{ .code = (BPF_JMP | EBPF_EXIT) }
+	};
+
+	/*
+	 * Verified code paths (order may vary by library implementation):
+	 *	0 -- 1 -- 4 -- 6 -- 7 -- unreachable 9
+	 *	     |    |         `-- 8 -- 10 -- return 7 -- return 4
+	 *	     |    `-- unreachable 5 -- return 1
+	 *	     `-- 2 -- 3 -- prune 8
+	 *	              `-- unreachable 4 -- return 1 -- success 11
+	 *
+	 * Note that 4 encountered conditional jump instructions generate:
+	 * - 4 pairs of branch-enter/branch-return events;
+	 * - 3 branch-unreachable events;
+	 * - 1 branch-prune event;
+	 * for a total count of 8 (4 instructions * 2 branches/instruction).
+	 */
+	static const int expected_counts[RTE_BPF_VALIDATE_DEBUG_EVENT_END] = {
+		[RTE_BPF_VALIDATE_DEBUG_EVENT_STEP] = 9,
+		[RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_START] = 1,
+		[RTE_BPF_VALIDATE_DEBUG_EVENT_VALIDATION_SUCCESS] = 1,
+		[RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_ENTER] = 4,
+		[RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_PRUNE] = 1,
+		[RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_RETURN] = 4,
+		[RTE_BPF_VALIDATE_DEBUG_EVENT_BRANCH_UNREACHABLE] = 3,
+		[RTE_BPF_VALIDATE_DEBUG_EVENT_JUMP_ALWAYS] = 1,
+		[RTE_BPF_VALIDATE_DEBUG_EVENT_JUMP_CONDITIONAL] = 4,
+	};
+
+	struct test_events_context ctx = {
+		.ins = ins,
+		.nb_ins = RTE_DIM(ins),
+		.branch_pc = NO_PROGRAM_COUNTER,
+	};
+
+	struct rte_bpf_validate_debug *debug = rte_bpf_validate_debug_create();
+	TEST_ASSERT_NOT_NULL(debug, "validate debug create error");
+
+	/* Set breakpoints for all instructions. */
+	for (uint32_t pc = 0; pc != RTE_DIM(ins); ++pc)
+		rte_bpf_validate_debug_break(debug, pc,
+			&(struct rte_bpf_validate_debug_callback){
+				.fn = test_events_break_cb,
+				.ctx = &ctx,
+			});
+
+	/* Set catchpoints for all events except invalid-state. */
+	for (enum rte_bpf_validate_debug_event event = 0;
+			event != RTE_BPF_VALIDATE_DEBUG_EVENT_END; ++event)
+		if (event != RTE_BPF_VALIDATE_DEBUG_EVENT_INVALID_STATE)
+			rte_bpf_validate_debug_catch(debug, event,
+				&(struct rte_bpf_validate_debug_callback){
+					.fn = test_events_catch_cb,
+					.ctx = &ctx,
+				});
+
+	struct rte_bpf *const bpf = rte_bpf_load_ex(&(struct rte_bpf_prm_ex){
+		.sz = sizeof(struct rte_bpf_prm_ex),
+		.origin = RTE_BPF_ORIGIN_RAW,
+		.raw.ins = ins,
+		.raw.nb_ins = RTE_DIM(ins),
+		.prog_arg[0] = { .type = RTE_BPF_ARG_RAW },
+		.nb_prog_arg = 1,
+		.debug = debug,
+	});
+
+	rte_bpf_destroy(bpf);
+	rte_bpf_validate_debug_destroy(debug);
+
+	TEST_ASSERT_NOT_NULL(bpf, "validation failed");
+
+	/* Verify event counts. */
+	for (enum rte_bpf_validate_debug_event event = 0;
+			event != RTE_BPF_VALIDATE_DEBUG_EVENT_END; ++event)
+		TEST_ASSERT_EQUAL(
+			ctx.event_counts[event], expected_counts[event],
+			"expected %d %s events, but got %d",
+			expected_counts[event], event_names[event],
+			ctx.event_counts[event]);
+
+	/* Additionally double-check final stack state. */
+	TEST_ASSERT_EQUAL(ctx.branch_pc_stack_length, 0,
+		"unbalanced branch enters and returns");
+
+	return TEST_SUCCESS;
+}
+
+REGISTER_FAST_TEST(bpf_validate_events_autotest, NOHUGE_OK, ASAN_OK, test_events);
+
+/*
+ * Tests of BPF validation.
+ */
+
 /* Sizes of text buffers used for formatting various debug outputs. */
 #define VALUE_FORMAT_BUFFER_SIZE 32
 #define INTERVAL_FORMAT_BUFFER_SIZE 64
-- 
2.43.0

