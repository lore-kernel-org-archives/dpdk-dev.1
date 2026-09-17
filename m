Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA809C88E72
	for <dpdk-dev@archiver.kernel.org>; Thu, 17 Sep 2026 14:37:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3AFFF42F1B;
	Thu, 17 Sep 2026 16:36:44 +0200 (CEST)
Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com
 [74.125.228.76]) by mails.dpdk.org (Postfix) with ESMTP id 7223542EA8
 for <dev@dpdk.org>; Thu, 17 Sep 2026 16:36:40 +0200 (CEST)
Received: by mail-ed2-f12.google.com with SMTP id
 4fb4d7f45d1cf-6a64c7cdb46so1567554a12.3
 for <dev@dpdk.org>; Thu, 17 Sep 2026 07:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789655800; x=1790260600; darn=dpdk.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=MU/OJI3xy//44MjkWzmkMVVfk1BkMUzuicxZeV/oLmM=;
 b=nO1ZhGTkxI6ZIm9Lf1DWM5Umu3kk9AyV6r3tqZuL9DsxbTWxsYZW2bpsOggo49eMTm
 zkUbI7JV/UKcQjh50izsDf8ZrYCtJUGaZGuPv7/tb4Z0J6NoCGt19s9jgX+cSISQ1GR4
 gSuhm161qFUCpm9kNKY571s39rR+kNLjlpNEQ0wJ8Mw/Z9o55O5Ybp6xkAnz8+sU6B7P
 lsULeWCe1yyLhISaFNTqsjRQnmt8iTR9C6wRmJAac8jL6G3sa26OZHlwDWncgk2rq4/H
 0zQSOGH8YF2lpeq6DILIplE7YkeeJBOzzlEPuABwyt12M+Ra3sv0wJY9uLeMjnXgCRC4
 onLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789655800; x=1790260600;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=MU/OJI3xy//44MjkWzmkMVVfk1BkMUzuicxZeV/oLmM=;
 b=aNakfy6GMo40wB2FO9gYU1xZeEwgZOSyq4ugYD8m2lCN77GDucnkDrc6YElbNOIoyT
 Mi3fzf5CfboUJmfWx4NoiCf9czhIXXmFVlTGpDru2Ro2xep0/2l109fz0HdRFuBfYZKh
 ZKXY9f6297EiLgWdTFhk2a7yhoMXb7yqxblCsg1BxnqNWNa0SfYi+kP+c7oZKAwRlq3d
 AFQyL1h5TIO113Fn6Z13v4uOlKk+3Z0z0FXhIKnJSdysSvECBsKfYgvSIJJw9Lnoanvx
 yZo47qpH0Jg9w/0Vi/J2i7OwwDPjo4b9FGjS9AExi76O/mGgKl+Rw7uRmlxSt+PcGjOB
 MIpQ==
X-Gm-Message-State: AFuF++m8SzL1CfwwvkZYdq+bMjn3gR6ZRbXVMbQ7sKtpX4DYHq6e0occ
 C05WoJjmvz0iwM+SQRXhByRGO/pAxegIVin58Nz6hy+heJabw9TNdP+r
X-Gm-Gg: AYBFou0TI9eJ0gvKIbx1F2PTNx2zu/GcdJmUBeVzf6PSrAQdJzP8gXEnaPLhWkEMcdN
 FXga3WyV8UPkgDTot5VqFHU9Zd38VczCUQnKeKzfKVwKquZIzJs6SwbXcc9BZJML8gPU8TrQa56
 RBCFzexET9Eh7uDjsnQ/DPnaByaY1c8VCV8RljpnTojKR3At5eZicbM7xEmpy1Sd20Mxftr9Puw
 +Lz2ih7gTk7Y55m2w8tPxiezRdRzBvGsGTlgV/5L+7i5zutKFH0T1hSY5iYLAJwbKuHi4bUPKM2
 evgPkf9JeF/7Xo96Dakjg2rdj5TLdYe+I4awYWagIdZOmPiw666YhHJQ8SRxrWHI+34btocNxGd
 wkS+EuW2T3Ag3G7LBm19db6P5w0p1q8DUp2HSsL2FLAAgH2Qh7sD3WBdBlDuYPTzDdZsPqtPaMw
 51tvsbRdVYi6LKk+RVqaXNYNXh3zJIcBsswlwBrXYzNWmp1qCr6U5jkw4gJno=
X-Received: by 2002:a05:6402:5024:b0:6a6:7d56:7977 with SMTP id
 4fb4d7f45d1cf-6aa2240fc65mr5011088a12.22.1789655799869; 
 Thu, 17 Sep 2026 07:36:39 -0700 (PDT)
Received: from dpdk.lxd ([89.101.57.120]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6aa1d2727bfsm3440986a12.20.2026.09.17.07.36.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 07:36:39 -0700 (PDT)
From: Marat Khalili <qm2k21@gmail.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <qm2k21@gmail.com>
Cc: dev@dpdk.org, Marat Khalili <marat.khalili@huawei.com>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 6/7] app/test: add test for bpf validate debug events
Date: Thu, 17 Sep 2026 14:35:36 +0000
Message-ID: <20260917143539.46951-7-qm2k21@gmail.com>
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

Add a test that verifies that eBPF validator generates callbacks with
the number, order and program counter specified in the documentation.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 app/test/test_bpf_validate.c | 344 ++++++++++++++++++++++++++++++++++-
 1 file changed, 340 insertions(+), 4 deletions(-)

diff --git a/app/test/test_bpf_validate.c b/app/test/test_bpf_validate.c
index 066f1fa156..8b48d8a504 100644
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
@@ -26,6 +22,346 @@ RTE_LOG_REGISTER(test_bpf_validate_logtype, test.bpf_validate, NOTICE);
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
+	 * Numbers without preceding word correspond to evaluated instructions,
+	 * there are 9 of these in total, so 9 step events are expected.
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

