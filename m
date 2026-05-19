Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 072DCCD4851
	for <dpdk-dev@archiver.kernel.org>; Tue, 19 May 2026 09:32:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CE74406B4;
	Tue, 19 May 2026 11:32:04 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 6F1A440649
 for <dev@dpdk.org>; Tue, 19 May 2026 11:31:55 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gKTvT5g7TzHnGdy
 for <dev@dpdk.org>; Tue, 19 May 2026 17:31:33 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 4857140575
 for <dev@dpdk.org>; Tue, 19 May 2026 17:31:55 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 19 May 2026 11:31:54 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: 
CC: <dev@dpdk.org>, Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v2 09/25] test/bpf_validate: add harness for pointer tests
Date: Tue, 19 May 2026 10:31:12 +0100
Message-ID: <20260519093131.52022-10-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519093131.52022-1-marat.khalili@huawei.com>
References: <20260506173846.64914-1-marat.khalili@huawei.com>
 <20260519093131.52022-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500002.china.huawei.com (7.182.19.148) To
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

Add necessary harness for testing pointer values in the registers and
add basic tests for adding pointers and scalars in various combinations.
These tests cover previously introduced fixes for BPF_ADD and BPF_LDX.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
Depends-on: series-38149 ("bpf: introduce extensible load API")
 app/test/test_bpf_validate.c | 311 +++++++++++++++++++++++++++++++++--
 1 file changed, 297 insertions(+), 14 deletions(-)

diff --git a/app/test/test_bpf_validate.c b/app/test/test_bpf_validate.c
index 350847d07a..f05f8a2482 100644
--- a/app/test/test_bpf_validate.c
+++ b/app/test/test_bpf_validate.c
@@ -51,9 +51,12 @@ struct unsigned_interval {
  * parameters (instruction is not accessing corresponding register).
  * It's not the same as `unknown` domain which describes register that is being
  * used but can hold any value.
+ *
+ * Flag `is_pointer` tells if the interval is relative to some memory area base.
  */
 struct domain {
 	bool is_defined;
+	bool is_pointer;
 	struct signed_interval s;
 	struct unsigned_interval u;
 };
@@ -149,7 +152,16 @@ make_unsigned_domain(uint64_t min, uint64_t max)
 	};
 }
 
-/* Return true if domain is a singleton. */
+/* Create domain from signed interval. */
+static struct domain
+make_pointer_domain(int64_t min, int64_t max)
+{
+	struct domain result = make_signed_domain(min, max);
+	result.is_pointer = true;
+	return result;
+}
+
+/* Return true if domain is a scalar or pointer singleton. */
 static bool
 domain_is_singleton(const struct domain *domain)
 {
@@ -195,7 +207,8 @@ format_domain(char *buffer, size_t bufsz, const struct domain *domain)
 
 	const int rc = !domain->is_defined ?
 		snprintf(buffer, bufsz, "UNDEFINED") :
-		snprintf(buffer, bufsz, "%s INTERSECT %s",
+		snprintf(buffer, bufsz, "%s %s INTERSECT %s",
+			domain->is_pointer ? "pointer" : "scalar",
 			format_interval(signed_buffer, sizeof(signed_buffer), 'd',
 				domain->s.min, domain->s.max),
 			format_interval(unsigned_buffer, sizeof(unsigned_buffer), 'x',
@@ -228,7 +241,7 @@ may_jump(const struct rte_bpf_validate_debug *debug,
 	return (result & RTE_BPF_VALIDATE_DEBUG_MAY_BE_TRUE) != 0;
 }
 
-/* Check interval of the register interpreted as signed. */
+/* Check interval of the register interpreted as signed scalar. */
 static int
 check_signed_interval(struct rte_bpf_validate_debug *debug,
 	uint8_t reg, struct signed_interval interval)
@@ -274,7 +287,7 @@ check_signed_interval(struct rte_bpf_validate_debug *debug,
 	return TEST_SUCCESS;
 }
 
-/* Check interval of the register interpreted as unsigned. */
+/* Check interval of the register interpreted as unsigned scalar. */
 static int
 check_unsigned_interval(struct rte_bpf_validate_debug *debug,
 	uint8_t reg, struct unsigned_interval interval)
@@ -320,18 +333,154 @@ check_unsigned_interval(struct rte_bpf_validate_debug *debug,
 	return TEST_SUCCESS;
 }
 
-/* Check domain of the register interpreted as value. */
+/* Check interval of the register relative to the base register. */
+static int
+check_relative_interval(struct rte_bpf_validate_debug *debug,
+	uint8_t reg, struct signed_interval interval, uint8_t base_reg)
+{
+	char buffer[VALUE_FORMAT_BUFFER_SIZE];
+
+	TEST_ASSERT_EQUAL(may_jump(debug,
+		&(struct ebpf_insn){
+			.code = (BPF_JMP | EBPF_JLT | BPF_X),
+			.dst_reg = reg,
+			.src_reg = base_reg,
+		}, interval.min),
+		false,
+		"r%hhu u< r%hhu + %s is impossible", reg, base_reg,
+		format_value(buffer, sizeof(buffer), 'd', interval.min));
+
+	TEST_ASSERT_EQUAL(may_jump(debug,
+		&(struct ebpf_insn){
+			.code = (BPF_JMP | BPF_JEQ | BPF_X),
+			.dst_reg = reg,
+			.src_reg = base_reg,
+		}, interval.min),
+		true,
+		"r%hhu == r%hhu + %s is possible", reg, base_reg,
+		format_value(buffer, sizeof(buffer), 'd', interval.min));
+
+	TEST_ASSERT_EQUAL(may_jump(debug,
+		&(struct ebpf_insn){
+			.code = (BPF_JMP | BPF_JEQ | BPF_X),
+			.dst_reg = reg,
+			.src_reg = base_reg,
+		}, interval.max),
+		true,
+		"r%hhu == r%hhu + %s is possible", reg, base_reg,
+		format_value(buffer, sizeof(buffer), 'd', interval.max));
+
+	TEST_ASSERT_EQUAL(may_jump(debug,
+		&(struct ebpf_insn){
+			.code = (BPF_JMP | BPF_JGT | BPF_X),
+			.dst_reg = reg,
+			.src_reg = base_reg,
+		}, interval.max),
+		false,
+		"r%hhu u> r%hhu + %s is impossible", reg, base_reg,
+		format_value(buffer, sizeof(buffer), 'd', interval.max));
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Check access of the register interpreted as pointer.
+ *
+ * Unlike other similar functions, min > max is not a problem here,
+ * so either signed or unsigned pair can be passed without any issues.
+ *
+ * This is the reason we are not using signed_interval or unsigned_interval here
+ * to avoid confusion.
+ */
 static int
-check_domain_impl(struct rte_bpf_validate_debug *debug, uint8_t reg,
+check_pointer_access(struct rte_bpf_validate_debug *debug, uint8_t reg,
+	uint64_t min, uint64_t max, size_t area_size)
+{
+	char buffer[VALUE_FORMAT_BUFFER_SIZE];
+
+	/* Start and end of the valid offsets window (unless empty). */
+	const uint64_t window_begin = -min;
+	const uint64_t window_end = area_size - max;
+
+	/* Only have accessible bytes if the interval is smaller than the area. */
+	const uint64_t interval_size = max - min;
+	const bool window_empty = (interval_size >= area_size);
+
+	TEST_ASSERT_EQUAL(rte_bpf_validate_debug_can_access(debug,
+		&(struct ebpf_insn){
+			.code = (BPF_LDX | BPF_B | BPF_MEM),
+			.src_reg = reg
+		}, window_begin - 1),
+		false,
+		"r%hhu + %s (before window begin) dereference is invalid", reg,
+		format_value(buffer, sizeof(buffer), 'd', window_begin - 1));
+
+	TEST_ASSERT_EQUAL(rte_bpf_validate_debug_can_access(debug,
+		&(struct ebpf_insn){
+			.code = (BPF_LDX | BPF_B | BPF_MEM),
+			.src_reg = reg
+		}, window_begin),
+		!window_empty,
+		"r%hhu + %s (after window begin) dereference is %s", reg,
+		format_value(buffer, sizeof(buffer), 'd', window_begin),
+		window_empty ? "invalid for empty window" : "valid");
+
+	TEST_ASSERT_EQUAL(rte_bpf_validate_debug_can_access(debug,
+		&(struct ebpf_insn){
+			.code = (BPF_LDX | BPF_B | BPF_MEM),
+			.src_reg = reg
+		}, window_end - 1),
+		!window_empty,
+		"r%hhu + %s (before window end) dereference is %s", reg,
+		format_value(buffer, sizeof(buffer), 'd', window_end - 1),
+		window_empty ? "invalid for empty window" : "valid");
+
+	TEST_ASSERT_EQUAL(rte_bpf_validate_debug_can_access(debug,
+		&(struct ebpf_insn){
+			.code = (BPF_LDX | BPF_B | BPF_MEM),
+			.src_reg = reg
+		}, window_end),
+		false,
+		"r%hhu + %s (after window end) dereference is invalid", reg,
+		format_value(buffer, sizeof(buffer), 'd', window_end));
+
+	return TEST_SUCCESS;
+}
+
+/* Check domain of the register interpreted as absolute value. */
+static int
+check_scalar_domain(struct rte_bpf_validate_debug *debug, uint8_t reg,
 	const struct domain *domain)
 {
 	TEST_ASSERT_SUCCESS(
 		check_signed_interval(debug, reg, domain->s),
-		"signed interval check");
+		"absolute signed interval check");
 
 	TEST_ASSERT_SUCCESS(
 		check_unsigned_interval(debug, reg, domain->u),
-		"unsigned interval check");
+		"absolute unsigned interval check");
+
+	return TEST_SUCCESS;
+}
+
+/* Check domain of the register interpreted as relative pointer. */
+static int
+check_pointer_domain(struct rte_bpf_validate_debug *debug, uint8_t reg,
+	const struct domain *domain, uint8_t base_reg, size_t area_size)
+{
+	TEST_ASSERT_SUCCESS(
+		check_relative_interval(debug, reg, domain->s, base_reg),
+		"relative interval check");
+
+	TEST_ASSERT_SUCCESS(
+		check_pointer_access(debug, reg, domain->s.min, domain->s.max,
+			area_size),
+		"pointer signed access check");
+
+	TEST_ASSERT_SUCCESS(
+		check_pointer_access(debug, reg, domain->u.min, domain->u.max,
+			area_size),
+		"pointer unsigned access check");
 
 	return TEST_SUCCESS;
 }
@@ -339,11 +488,13 @@ check_domain_impl(struct rte_bpf_validate_debug *debug, uint8_t reg,
 /* Check domain of the register and format the values in case of an error. */
 static int
 check_domain(struct rte_bpf_validate_debug *debug, uint8_t reg,
-	const struct domain *domain)
+	const struct domain *domain, uint8_t base_reg, size_t area_size)
 {
 	char buffer[REGISTER_FORMAT_BUFFER_SIZE];
 
-	const int rc = check_domain_impl(debug, reg, domain);
+	const int rc = domain->is_pointer ?
+		check_pointer_domain(debug, reg, domain, base_reg, area_size) :
+		check_scalar_domain(debug, reg, domain);
 
 	if (rc != TEST_SUCCESS) {
 		TEST_LOG_LINE(WARNING, "\tExpected: r%hhu = %s", reg,
@@ -419,13 +570,13 @@ compare_and_jump(struct ebpf_insn **ins, uint8_t op, uint8_t reg,
 }
 
 /*
- * Prepare register to be in the specified domain.
+ * Prepare register to be in the specified scalar domain.
  *
  * Unless singleton, load unknown value into it and clamp it with conditional jumps.
  * (Jump offsets are not filled and should be patched in by the caller.)
  */
 static void
-prepare_domain(struct ebpf_insn **ins, uint8_t reg,
+prepare_scalar_domain(struct ebpf_insn **ins, uint8_t reg,
 	const struct domain *domain, uint8_t base_reg, int *service_cell_count,
 	uint8_t tmp_reg)
 {
@@ -460,6 +611,28 @@ prepare_domain(struct ebpf_insn **ins, uint8_t reg,
 		compare_and_jump(ins, EBPF_JSGT, reg, domain->s.max, tmp_reg);
 }
 
+/*
+ * Prepare register to be in the specified scalar or pointer domain, if any.
+ *
+ * If `domain` is NULL, do nothing. Otherwise prepare scalar domain,
+ * and then add base register to it to convert it to a pointer, if needed.
+ */
+static void
+prepare_domain(struct ebpf_insn **ins, uint8_t reg,
+	const struct domain *domain, uint8_t base_reg, int *service_cell_count,
+	uint8_t tmp_reg)
+{
+	prepare_scalar_domain(ins, reg, domain, base_reg, service_cell_count, tmp_reg);
+
+	if (domain->is_pointer)
+		/* Add base_reg to convert resulting scalar into a pointer. */
+		*(*ins)++ = (struct ebpf_insn){
+			.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
+			.dst_reg = reg,
+			.src_reg = base_reg,
+		};
+}
+
 static void
 fill_verify_instruction_defaults(struct verify_instruction_param *prm)
 {
@@ -645,7 +818,8 @@ point_callback(struct rte_bpf_validate_debug *debug, const struct verify_instruc
 
 		if (state->dst.is_defined) {
 			TEST_ASSERT_SUCCESS(
-				check_domain(debug, ctx->dst_reg, &state->dst),
+				check_domain(debug, ctx->dst_reg, &state->dst,
+					ctx->base_reg, ctx->prm.area_size),
 				"dst domain check");
 			TEST_LOG_LINE(DEBUG, "Successfully checked r%hhu.", ctx->dst_reg);
 		} else
@@ -658,7 +832,8 @@ point_callback(struct rte_bpf_validate_debug *debug, const struct verify_instruc
 
 		if (state->src.is_defined) {
 			TEST_ASSERT_SUCCESS(
-				check_domain(debug, ctx->src_reg, &state->src),
+				check_domain(debug, ctx->src_reg, &state->src,
+					ctx->base_reg, ctx->prm.area_size),
 				"src domain check");
 			TEST_LOG_LINE(DEBUG, "Successfully checked r%hhu.", ctx->src_reg);
 		} else
@@ -889,6 +1064,96 @@ test_alu64_add_k(void)
 REGISTER_FAST_TEST(bpf_validate_alu64_add_k_autotest, NOHUGE_OK, ASAN_OK,
 	test_alu64_add_k);
 
+/* 64-bit addition of immediate to a pointer range. */
+static int
+test_alu64_add_k_pointer(void)
+{
+	return verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (EBPF_ALU64 | BPF_ADD | BPF_K),
+			.imm = 17,
+		},
+		.area_size = 256,
+		.pre.dst = make_pointer_domain(11, 29),
+		.post.dst = make_pointer_domain(11 + 17, 29 + 17),
+	});
+}
+
+REGISTER_FAST_TEST(bpf_validate_alu64_add_k_pointer_autotest, NOHUGE_OK, ASAN_OK,
+	test_alu64_add_k_pointer);
+
+/* 64-bit addition of pointer to a pointer. */
+static int
+test_alu64_add_x_pointer_pointer(void)
+{
+	return verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
+		},
+		.area_size = 256,
+		.pre.dst = make_pointer_domain(11, 29),
+		.pre.src = make_pointer_domain(17, 23),
+		.post.dst = unknown,
+	});
+}
+
+REGISTER_FAST_TEST(bpf_validate_alu64_add_x_pointer_pointer_autotest, NOHUGE_OK, ASAN_OK,
+	test_alu64_add_x_pointer_pointer);
+
+/* 64-bit addition of scalar to a pointer. */
+static int
+test_alu64_add_x_pointer_scalar(void)
+{
+	return verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
+		},
+		.area_size = 256,
+		.pre.dst = make_pointer_domain(11, 29),
+		.pre.src = make_signed_domain(17, 23),
+		.post.dst = make_pointer_domain(11 + 17, 29 + 23),
+	});
+}
+
+REGISTER_FAST_TEST(bpf_validate_alu64_add_x_pointer_scalar_autotest, NOHUGE_OK, ASAN_OK,
+	test_alu64_add_x_pointer_scalar);
+
+/* 64-bit addition of pointer to a scalar. */
+static int
+test_alu64_add_x_scalar_pointer(void)
+{
+	return verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
+		},
+		.area_size = 256,
+		.pre.dst = make_signed_domain(11, 29),
+		.pre.src = make_pointer_domain(17, 23),
+		.post.dst = make_pointer_domain(11 + 17, 29 + 23),
+	});
+}
+
+REGISTER_FAST_TEST(bpf_validate_alu64_add_x_scalar_pointer_autotest, NOHUGE_OK, ASAN_OK,
+	test_alu64_add_x_scalar_pointer);
+
+/* 64-bit addition of scalar to a scalar. */
+static int
+test_alu64_add_x_scalar_scalar(void)
+{
+	return verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
+		},
+		.area_size = 256,
+		.pre.dst = make_signed_domain(11, 29),
+		.pre.src = make_signed_domain(17, 23),
+		.post.dst = make_signed_domain(11 + 17, 29 + 23),
+	});
+}
+
+REGISTER_FAST_TEST(bpf_validate_alu64_add_x_scalar_scalar_autotest, NOHUGE_OK, ASAN_OK,
+	test_alu64_add_x_scalar_scalar);
+
 /* Jump if greater than immediate. */
 static int
 test_jmp64_jeq_k(void)
@@ -906,3 +1171,21 @@ test_jmp64_jeq_k(void)
 
 REGISTER_FAST_TEST(bpf_validate_jmp64_jeq_k_autotest, NOHUGE_OK, ASAN_OK,
 	test_jmp64_jeq_k);
+
+/* 64-bit load from heap (should be set to unknown). */
+static int
+test_mem_ldx_dw_heap(void)
+{
+	return verify_instruction((struct verify_instruction_param){
+		.tested_instruction = {
+			.code = (BPF_MEM | BPF_LDX | EBPF_DW),
+			.off = 16,
+		},
+		.area_size = 24,
+		.pre.src = make_pointer_domain(0, 0),
+		.post.dst = unknown,
+	});
+}
+
+REGISTER_FAST_TEST(bpf_validate_mem_ldx_dw_heap_autotest, NOHUGE_OK, ASAN_OK,
+	test_mem_ldx_dw_heap);
-- 
2.43.0

