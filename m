Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE72DCCF9E3
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Nov 2025 15:31:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B579A40430;
	Mon, 10 Nov 2025 16:31:31 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 2DAD340430
 for <dev@dpdk.org>; Mon, 10 Nov 2025 16:31:30 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.186.231])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4d4tt95PbVzHnH71;
 Mon, 10 Nov 2025 23:31:13 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 26971140446;
 Mon, 10 Nov 2025 23:31:29 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Nov 2025 16:31:28 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: Stephen Hemminger <stephen@networkplumber.org>, <dev@dpdk.org>
Subject: [PATCH 1/3] bpf: fix signed shift overflows in ARM JIT
Date: Mon, 10 Nov 2025 15:30:44 +0000
Message-ID: <20251110153046.63518-2-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251110153046.63518-1-marat.khalili@huawei.com>
References: <20251110153046.63518-1-marat.khalili@huawei.com>
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

Left shifts of integer literals and bool values overwriting the sign bit
were used multiple times in bpf_jit_arm64.c. E.g.:

    insn = (!!is64) << 31;

where is64 has type bool (double bang is a no-op here). The operand of
left shift was promoted to type int, which when 32-bit wide cannot
represent the result. Similarly literal integers have int type by
default.  Sanitizer produced the following diagnostic during runtime
(for various lines):

    lib/bpf/bpf_jit_arm64.c:241:18: runtime error: left shift of 1 by 31
    places cannot be represented in type 'int'

To fix the issue use RTE_BIT32 and similar macros instead.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/bpf/bpf_jit_arm64.c | 188 +++++++++++++++++++++++-----------------
 1 file changed, 107 insertions(+), 81 deletions(-)

diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
index 96b8cd2e03..5f43db0170 100644
--- a/lib/bpf/bpf_jit_arm64.c
+++ b/lib/bpf/bpf_jit_arm64.c
@@ -28,7 +28,33 @@
 #define A64_ZR			31
 
 #define check_imm(n, val) (((val) >= 0) ? !!((val) >> (n)) : !!((~val) >> (n)))
-#define mask_imm(n, val) ((val) & ((1 << (n)) - 1))
+#define mask_imm(n, val) ((val) & (RTE_BIT32(n) - 1))
+
+/**
+ * Get the uint32_t shifted value.
+ *
+ * Works similarly to RTE_SHIFT_VAL32 but accepts non-literal arguments.
+ * Performs identically to RTE_SHIFT_VAL32 with literal arguments.
+ *
+ * @param val
+ *   The value to be shifted, can be non-literal.
+ * @param nr
+ *   The shift number in range of 0 to (32 - width of val).
+ */
+#define SHIFT_VAR32(val, nr) ((uint32_t)(val) << (nr))
+
+/**
+ * Get the uint64_t shifted value.
+ *
+ * Works similarly to RTE_SHIFT_VAL64 but accepts non-literal arguments.
+ * Performs identically to RTE_SHIFT_VAL64 with literal arguments.
+ *
+ * @param val
+ *   The value to be shifted, can be non-literal.
+ * @param nr
+ *   The shift number in range of 0 to (64 - width of val).
+ */
+#define SHIFT_VAR64(val, nr) ((uint64_t)(val) << (nr))
 
 struct ebpf_a64_map {
 	uint32_t off; /* eBPF to arm64 insn offset mapping for jump */
@@ -238,12 +264,12 @@ emit_add_sub_imm(struct a64_jit_ctx *ctx, bool is64, bool sub, uint8_t rd,
 	uint32_t insn, imm;
 
 	imm = mask_imm(12, imm12);
-	insn = (!!is64) << 31;
-	insn |= (!!sub) << 30;
+	insn = SHIFT_VAR32(is64, 31);
+	insn |= SHIFT_VAR32(sub, 30);
 	insn |= 0x11000000;
 	insn |= rd;
-	insn |= rn << 5;
-	insn |= imm << 10;
+	insn |= SHIFT_VAR32(rn, 5);
+	insn |= SHIFT_VAR32(imm, 10);
 
 	emit_insn(ctx, insn,
 		  check_reg(rd) || check_reg(rn) || check_imm(12, imm12));
@@ -279,16 +305,16 @@ emit_ls_pair_64(struct a64_jit_ctx *ctx, uint8_t rt, uint8_t rt2, uint8_t rn,
 {
 	uint32_t insn;
 
-	insn = (!!load) << 22;
-	insn |= (!!pre_index) << 24;
+	insn = SHIFT_VAR32(load, 22);
+	insn |= SHIFT_VAR32(pre_index, 24);
 	insn |= 0xa8800000;
 	insn |= rt;
-	insn |= rn << 5;
-	insn |= rt2 << 10;
+	insn |= SHIFT_VAR32(rn, 5);
+	insn |= SHIFT_VAR32(rt2, 10);
 	if (push)
-		insn |= 0x7e << 15; /* 0x7e means -2 with imm7 */
+		insn |= SHIFT_VAR32(0x7e, 15); /* 0x7e means -2 with imm7 */
 	else
-		insn |= 0x2 << 15;
+		insn |= SHIFT_VAR32(0x2, 15);
 
 	emit_insn(ctx, insn, check_reg(rn) || check_reg(rt) || check_reg(rt2));
 
@@ -317,11 +343,11 @@ mov_imm(struct a64_jit_ctx *ctx, bool is64, uint8_t rd, uint8_t type,
 {
 	uint32_t insn;
 
-	insn = (!!is64) << 31;
-	insn |= type << 29;
-	insn |= 0x25 << 23;
-	insn |= (shift/16) << 21;
-	insn |= imm16 << 5;
+	insn = SHIFT_VAR32(is64, 31);
+	insn |= SHIFT_VAR32(type, 29);
+	insn |= SHIFT_VAR32(0x25, 23);
+	insn |= SHIFT_VAR32(shift/16, 21);
+	insn |= SHIFT_VAR32(imm16, 5);
 	insn |= rd;
 
 	emit_insn(ctx, insn, check_reg(rd) || check_mov_hw(is64, shift));
@@ -334,7 +360,7 @@ emit_mov_imm32(struct a64_jit_ctx *ctx, bool is64, uint8_t rd, uint32_t val)
 	uint16_t lower = val & 0xffff;
 
 	/* Positive number */
-	if ((val & 1UL << 31) == 0) {
+	if ((val & RTE_BIT32(31)) == 0) {
 		mov_imm(ctx, is64, rd, A64_MOVZ, lower, 0);
 		if (upper)
 			mov_imm(ctx, is64, rd, A64_MOVK, upper, 16);
@@ -393,21 +419,21 @@ emit_ls(struct a64_jit_ctx *ctx, uint8_t sz, uint8_t rt, uint8_t rn, uint8_t rm,
 {
 	uint32_t insn;
 
-	insn = 0x1c1 << 21;
+	insn = SHIFT_VAR32(0x1c1, 21);
 	if (load)
-		insn |= 1 << 22;
+		insn |= RTE_BIT32(22);
 	if (sz == BPF_B)
-		insn |= 0 << 30;
+		insn |= SHIFT_VAR32(0, 30);
 	else if (sz == BPF_H)
-		insn |= 1 << 30;
+		insn |= SHIFT_VAR32(1, 30);
 	else if (sz == BPF_W)
-		insn |= 2 << 30;
+		insn |= SHIFT_VAR32(2, 30);
 	else if (sz == EBPF_DW)
-		insn |= 3 << 30;
+		insn |= SHIFT_VAR32(3, 30);
 
-	insn |= rm << 16;
-	insn |= 0x1a << 10; /* LSL and S = 0 */
-	insn |= rn << 5;
+	insn |= SHIFT_VAR32(rm, 16);
+	insn |= SHIFT_VAR32(0x1a, 10); /* LSL and S = 0 */
+	insn |= SHIFT_VAR32(rn, 5);
 	insn |= rt;
 
 	emit_insn(ctx, insn, check_reg(rt) || check_reg(rn) || check_reg(rm) ||
@@ -436,10 +462,10 @@ emit_add_sub(struct a64_jit_ctx *ctx, bool is64, uint8_t rd, uint8_t rn,
 {
 	uint32_t insn;
 
-	insn = (!!is64) << 31;
-	insn |= op << 21; /* shift == 0 */
-	insn |= rm << 16;
-	insn |= rn << 5;
+	insn = SHIFT_VAR32(is64, 31);
+	insn |= SHIFT_VAR32(op, 21); /* shift == 0 */
+	insn |= SHIFT_VAR32(rm, 16);
+	insn |= SHIFT_VAR32(rn, 5);
 	insn |= rd;
 
 	emit_insn(ctx, insn, check_reg(rd) || check_reg(rm));
@@ -468,11 +494,11 @@ emit_mul(struct a64_jit_ctx *ctx, bool is64, uint8_t rd, uint8_t rm)
 {
 	uint32_t insn;
 
-	insn = (!!is64) << 31;
-	insn |= 0xd8 << 21;
-	insn |= rm << 16;
-	insn |= A64_ZR << 10;
-	insn |= rd << 5;
+	insn = SHIFT_VAR32(is64, 31);
+	insn |= SHIFT_VAR32(0xd8, 21);
+	insn |= SHIFT_VAR32(rm, 16);
+	insn |= SHIFT_VAR32(A64_ZR, 10);
+	insn |= SHIFT_VAR32(rd, 5);
 	insn |= rd;
 
 	emit_insn(ctx, insn, check_reg(rd) || check_reg(rm));
@@ -489,11 +515,11 @@ emit_data_process_two_src(struct a64_jit_ctx *ctx, bool is64, uint8_t rd,
 {
 	uint32_t insn;
 
-	insn = (!!is64) << 31;
-	insn |= 0xd6 << 21;
-	insn |= rm << 16;
-	insn |= op << 10;
-	insn |= rn << 5;
+	insn = SHIFT_VAR32(is64, 31);
+	insn |= SHIFT_VAR32(0xd6, 21);
+	insn |= SHIFT_VAR32(rm, 16);
+	insn |= SHIFT_VAR32(op, 10);
+	insn |= SHIFT_VAR32(rn, 5);
 	insn |= rd;
 
 	emit_insn(ctx, insn, check_reg(rd) || check_reg(rm));
@@ -532,14 +558,14 @@ emit_bitfield(struct a64_jit_ctx *ctx, bool is64, uint8_t rd, uint8_t rn,
 {
 	uint32_t insn;
 
-	insn = (!!is64) << 31;
+	insn = SHIFT_VAR32(is64, 31);
 	if (insn)
-		insn |= 1 << 22; /* Set N bit when is64 is set */
-	insn |= op << 29;
-	insn |= 0x26 << 23;
-	insn |= immr << 16;
-	insn |= imms << 10;
-	insn |= rn << 5;
+		insn |= RTE_BIT32(22); /* Set N bit when is64 is set */
+	insn |= SHIFT_VAR32(op, 29);
+	insn |= SHIFT_VAR32(0x26, 23);
+	insn |= SHIFT_VAR32(immr, 16);
+	insn |= SHIFT_VAR32(imms, 10);
+	insn |= SHIFT_VAR32(rn, 5);
 	insn |= rd;
 
 	emit_insn(ctx, insn, check_reg(rd) || check_reg(rn) ||
@@ -578,11 +604,11 @@ emit_logical(struct a64_jit_ctx *ctx, bool is64, uint8_t rd,
 {
 	uint32_t insn;
 
-	insn = (!!is64) << 31;
-	insn |= op << 29;
-	insn |= 0x50 << 21;
-	insn |= rm << 16;
-	insn |= rd << 5;
+	insn = SHIFT_VAR32(is64, 31);
+	insn |= SHIFT_VAR32(op, 29);
+	insn |= SHIFT_VAR32(0x50, 21);
+	insn |= SHIFT_VAR32(rm, 16);
+	insn |= SHIFT_VAR32(rd, 5);
 	insn |= rd;
 
 	emit_insn(ctx, insn, check_reg(rd) || check_reg(rm));
@@ -612,12 +638,12 @@ emit_msub(struct a64_jit_ctx *ctx, bool is64, uint8_t rd, uint8_t rn,
 {
 	uint32_t insn;
 
-	insn = (!!is64) << 31;
-	insn |= 0xd8 << 21;
-	insn |= rm << 16;
-	insn |= 0x1 << 15;
-	insn |= ra << 10;
-	insn |= rn << 5;
+	insn = SHIFT_VAR32(is64, 31);
+	insn |= SHIFT_VAR32(0xd8, 21);
+	insn |= SHIFT_VAR32(rm, 16);
+	insn |= SHIFT_VAR32(0x1, 15);
+	insn |= SHIFT_VAR32(ra, 10);
+	insn |= SHIFT_VAR32(rn, 5);
 	insn |= rd;
 
 	emit_insn(ctx, insn, check_reg(rd) || check_reg(rn) || check_reg(rm) ||
@@ -638,7 +664,7 @@ emit_blr(struct a64_jit_ctx *ctx, uint8_t rn)
 	uint32_t insn;
 
 	insn = 0xd63f0000;
-	insn |= rn << 5;
+	insn |= SHIFT_VAR32(rn, 5);
 
 	emit_insn(ctx, insn, check_reg(rn));
 }
@@ -669,22 +695,22 @@ emit_rev(struct a64_jit_ctx *ctx, uint8_t rd, int32_t imm)
 	uint32_t insn;
 
 	insn = 0xdac00000;
-	insn |= rd << 5;
+	insn |= SHIFT_VAR32(rd, 5);
 	insn |= rd;
 
 	switch (imm) {
 	case 16:
-		insn |= 1 << 10;
+		insn |= SHIFT_VAR32(1, 10);
 		emit_insn(ctx, insn, check_reg(rd));
 		emit_zero_extend(ctx, rd, 16);
 		break;
 	case 32:
-		insn |= 2 << 10;
+		insn |= SHIFT_VAR32(2, 10);
 		emit_insn(ctx, insn, check_reg(rd));
 		/* Upper 32 bits already cleared */
 		break;
 	case 64:
-		insn |= 3 << 10;
+		insn |= SHIFT_VAR32(3, 10);
 		emit_insn(ctx, insn, check_reg(rd));
 		break;
 	default:
@@ -933,9 +959,9 @@ emit_cbnz(struct a64_jit_ctx *ctx, bool is64, uint8_t rt, int32_t imm19)
 	uint32_t insn, imm;
 
 	imm = mask_imm(19, imm19);
-	insn = (!!is64) << 31;
-	insn |= 0x35 << 24;
-	insn |= imm << 5;
+	insn = SHIFT_VAR32(is64, 31);
+	insn |= SHIFT_VAR32(0x35, 24);
+	insn |= SHIFT_VAR32(imm, 5);
 	insn |= rt;
 
 	emit_insn(ctx, insn, check_reg(rt) || check_imm(19, imm19));
@@ -947,7 +973,7 @@ emit_b(struct a64_jit_ctx *ctx, int32_t imm26)
 	uint32_t insn, imm;
 
 	imm = mask_imm(26, imm26);
-	insn = 0x5 << 26;
+	insn = SHIFT_VAR32(0x5, 26);
 	insn |= imm;
 
 	emit_insn(ctx, insn, check_imm(26, imm26));
@@ -971,9 +997,9 @@ emit_stadd(struct a64_jit_ctx *ctx, bool is64, uint8_t rs, uint8_t rn)
 	uint32_t insn;
 
 	insn = 0xb820001f;
-	insn |= (!!is64) << 30;
-	insn |= rs << 16;
-	insn |= rn << 5;
+	insn |= SHIFT_VAR32(is64, 30);
+	insn |= SHIFT_VAR32(rs, 16);
+	insn |= SHIFT_VAR32(rn, 5);
 
 	emit_insn(ctx, insn, check_reg(rs) || check_reg(rn));
 }
@@ -984,8 +1010,8 @@ emit_ldxr(struct a64_jit_ctx *ctx, bool is64, uint8_t rt, uint8_t rn)
 	uint32_t insn;
 
 	insn = 0x885f7c00;
-	insn |= (!!is64) << 30;
-	insn |= rn << 5;
+	insn |= SHIFT_VAR32(is64, 30);
+	insn |= SHIFT_VAR32(rn, 5);
 	insn |= rt;
 
 	emit_insn(ctx, insn, check_reg(rt) || check_reg(rn));
@@ -998,9 +1024,9 @@ emit_stxr(struct a64_jit_ctx *ctx, bool is64, uint8_t rs, uint8_t rt,
 	uint32_t insn;
 
 	insn = 0x88007c00;
-	insn |= (!!is64) << 30;
-	insn |= rs << 16;
-	insn |= rn << 5;
+	insn |= SHIFT_VAR32(is64, 30);
+	insn |= SHIFT_VAR32(rs, 16);
+	insn |= SHIFT_VAR32(rn, 5);
 	insn |= rt;
 
 	emit_insn(ctx, insn, check_reg(rs) || check_reg(rt) || check_reg(rn));
@@ -1051,9 +1077,9 @@ emit_cmp_tst(struct a64_jit_ctx *ctx, bool is64, uint8_t rn, uint8_t rm,
 	uint32_t insn;
 
 	insn = opc;
-	insn |= (!!is64) << 31;
-	insn |= rm << 16;
-	insn |= rn << 5;
+	insn |= SHIFT_VAR32(is64, 31);
+	insn |= SHIFT_VAR32(rm, 16);
+	insn |= SHIFT_VAR32(rn, 5);
 
 	emit_insn(ctx, insn, check_reg(rn) || check_reg(rm));
 }
@@ -1076,8 +1102,8 @@ emit_b_cond(struct a64_jit_ctx *ctx, uint8_t cond, int32_t imm19)
 	uint32_t insn, imm;
 
 	imm = mask_imm(19, imm19);
-	insn = 0x15 << 26;
-	insn |= imm << 5;
+	insn = SHIFT_VAR32(0x15, 26);
+	insn |= SHIFT_VAR32(imm, 5);
 	insn |= cond;
 
 	emit_insn(ctx, insn, check_cond(cond) || check_imm(19, imm19));
@@ -1301,7 +1327,7 @@ emit(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
 			break;
 		/* dst = imm64 */
 		case (BPF_LD | BPF_IMM | EBPF_DW):
-			u64 = ((uint64_t)ins[1].imm << 32) | (uint32_t)imm;
+			u64 = SHIFT_VAR64(ins[1].imm, 32) | (uint32_t)imm;
 			emit_mov_imm(ctx, 1, dst, u64);
 			i++;
 			break;
-- 
2.43.0

