Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D66CD342C
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 17:39:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B8294069F;
	Wed,  6 May 2026 19:39:21 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id CE35A40285
 for <dev@dpdk.org>; Wed,  6 May 2026 19:39:16 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g9jKv1bMgzJ46Q7
 for <dev@dpdk.org>; Thu,  7 May 2026 01:38:59 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 9D34940571
 for <dev@dpdk.org>; Thu,  7 May 2026 01:39:15 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 19:39:15 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>
Subject: [PATCH 02/25] bpf: add format instruction function
Date: Wed, 6 May 2026 18:38:20 +0100
Message-ID: <20260506173846.64914-3-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506173846.64914-1-marat.khalili@huawei.com>
References: <20260506173846.64914-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500008.china.huawei.com (7.182.19.65) To
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

BPF library already contains BPF instruction formatting functions, but
they could only be used via `rte_bpf_dump` to dump result into file. Add
new function `rte_bpf_format` to format instruction in various way
(hexadecimal, disassembly) into a user-provided buffer, as well as a
service function `rte_bpf_insn_is_wide` to detect wide instructions.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/bpf/bpf_dump.c | 290 +++++++++++++++++++++++++++------------------
 lib/bpf/rte_bpf.h  |  51 ++++++++
 2 files changed, 226 insertions(+), 115 deletions(-)

diff --git a/lib/bpf/bpf_dump.c b/lib/bpf/bpf_dump.c
index 0abaeef8ae98..4fd67ad5a1df 100644
--- a/lib/bpf/bpf_dump.c
+++ b/lib/bpf/bpf_dump.c
@@ -46,6 +46,38 @@ static const char *const jump_tbl[16] = {
 	[EBPF_JSLT >> 4] = "jslt", [EBPF_JSLE >> 4] = "jsle",
 };
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_insn_is_wide, 26.07)
+bool
+rte_bpf_insn_is_wide(const struct ebpf_insn *ins)
+{
+	return ins->code == (BPF_LD | BPF_IMM | EBPF_DW);
+}
+
+
+/* Format one (possibly wide) eBPF command as hexadecimal in objdump format. */
+static int
+format_hexadecimal(char *buffer, size_t bufsz, const struct ebpf_insn *ins,
+	uint32_t flags)
+{
+	const char *const b = (const char *)ins;
+
+	RTE_ASSERT((flags & RTE_BPF_FORMAT_FLAG_HEXADECIMAL) != 0);
+
+	RTE_BUILD_BUG_ON(sizeof(*ins) != 8);
+
+	if ((flags & RTE_BPF_FORMAT_FLAG_NEVER_WIDE) == 0 && rte_bpf_insn_is_wide(ins))
+		return snprintf(buffer, bufsz,
+			"%02hhx %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx "
+			"%02hhx %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx",
+			b[0], b[1], b[2], b[3], b[4], b[5], b[6], b[7],
+			b[8], b[9], b[10], b[11], b[12], b[13], b[14], b[15]);
+	else
+		return snprintf(buffer, bufsz,
+			"%02hhx %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx %02hhx",
+			b[0], b[1], b[2], b[3], b[4], b[5], b[6], b[7]);
+}
+
+/* Return atomic subcommand mnemonic based on BPF_STX immediate. */
 static inline const char *
 atomic_op(int32_t imm)
 {
@@ -59,130 +91,158 @@ atomic_op(int32_t imm)
 	}
 }
 
-RTE_EXPORT_SYMBOL(rte_bpf_dump)
-void rte_bpf_dump(FILE *f, const struct ebpf_insn *buf, uint32_t len)
+/* Format one (possibly wide) eBPF command as assembler. */
+static int
+format_disassembly(char *buffer, size_t bufsz, const struct ebpf_insn *ins,
+	uint32_t pc, uint32_t flags)
 {
-	uint32_t i;
+	uint8_t cls = BPF_CLASS(ins->code);
+	const char *op, *postfix = "", *warning = "";
+	char jump[16];
 
-	for (i = 0; i < len; ++i) {
-		const struct ebpf_insn *ins = buf + i;
-		uint8_t cls = BPF_CLASS(ins->code);
-		const char *op, *postfix = "", *warning = "";
+	RTE_ASSERT((flags & RTE_BPF_FORMAT_FLAG_HEXADECIMAL) == 0);
 
-		fprintf(f, " L%u:\t", i);
+	switch (cls) {
+	default:
+		return snprintf(buffer, bufsz, "unimp 0x%x // class: %s",
+			ins->code, class_tbl[cls]);
+	case BPF_ALU:
+		postfix = "32";
+		/* fall through */
+	case EBPF_ALU64:
+		op = alu_op_tbl[BPF_OP_INDEX(ins->code)];
+		if (ins->off != 0)
+			/* Not yet supported variation with non-zero offset. */
+			warning = ", off != 0";
+		if (BPF_SRC(ins->code) == BPF_X)
+			return snprintf(buffer, bufsz, "%s%s r%u, r%u%s", op, postfix, ins->dst_reg,
+				ins->src_reg, warning);
+		else
+			return snprintf(buffer, bufsz, "%s%s r%u, #0x%x%s", op, postfix,
+				ins->dst_reg, ins->imm, warning);
+	case BPF_LD:
+		op = "ld";
+		postfix = size_tbl[BPF_SIZE_INDEX(ins->code)];
+		if (ins->code == (BPF_LD | BPF_IMM | EBPF_DW)) {
+			uint64_t val;
 
-		switch (cls) {
-		default:
-			fprintf(f, "unimp 0x%x // class: %s\n",
-				ins->code, class_tbl[cls]);
-			break;
-		case BPF_ALU:
-			postfix = "32";
-			/* fall through */
-		case EBPF_ALU64:
-			op = alu_op_tbl[BPF_OP_INDEX(ins->code)];
-			if (ins->off != 0)
-				/* Not yet supported variation with non-zero offset. */
-				warning = ", off != 0";
-			if (BPF_SRC(ins->code) == BPF_X)
-				fprintf(f, "%s%s r%u, r%u%s\n", op, postfix, ins->dst_reg,
-					ins->src_reg, warning);
-			else
-				fprintf(f, "%s%s r%u, #0x%x%s\n", op, postfix,
-					ins->dst_reg, ins->imm, warning);
-			break;
-		case BPF_LD:
-			op = "ld";
-			postfix = size_tbl[BPF_SIZE_INDEX(ins->code)];
-			if (ins->code == (BPF_LD | BPF_IMM | EBPF_DW)) {
-				uint64_t val;
-
-				if (ins->src_reg != 0)
-					/* Not yet supported variation with non-zero src. */
-					warning = ", src != 0";
-				val = (uint32_t)ins[0].imm |
-					(uint64_t)(uint32_t)ins[1].imm << 32;
-				fprintf(f, "%s%s r%d, #0x%"PRIx64"%s\n",
-					op, postfix, ins->dst_reg, val, warning);
-				i++;
-			} else if (BPF_MODE(ins->code) == BPF_IMM)
-				fprintf(f, "%s%s r%d, #0x%x\n", op, postfix,
-					ins->dst_reg, ins->imm);
-			else if (BPF_MODE(ins->code) == BPF_ABS)
-				fprintf(f, "%s%s r%d, [%d]\n", op, postfix,
-					ins->dst_reg, ins->imm);
-			else if (BPF_MODE(ins->code) == BPF_IND)
-				fprintf(f, "%s%s r%d, [r%u + %d]\n", op, postfix,
-					ins->dst_reg, ins->src_reg, ins->imm);
-			else
-				fprintf(f, "// BUG: LD opcode 0x%02x in eBPF insns\n",
-					ins->code);
-			break;
-		case BPF_LDX:
-			op = "ldx";
-			postfix = size_tbl[BPF_SIZE_INDEX(ins->code)];
-			if (BPF_MODE(ins->code) == BPF_MEM)
-				fprintf(f, "%s%s r%d, [r%u + %d]\n", op, postfix, ins->dst_reg,
-					ins->src_reg, ins->off);
-			else
-				fprintf(f, "// BUG: LDX opcode 0x%02x in eBPF insns\n",
-					ins->code);
-			break;
-		case BPF_ST:
-			op = "st";
-			postfix = size_tbl[BPF_SIZE_INDEX(ins->code)];
-			if (BPF_MODE(ins->code) == BPF_MEM)
-				fprintf(f, "%s%s [r%d + %d], #0x%x\n", op, postfix,
-					ins->dst_reg, ins->off, ins->imm);
-			else
-				fprintf(f, "// BUG: ST opcode 0x%02x in eBPF insns\n",
-					ins->code);
-			break;
-		case BPF_STX:
-			if (BPF_MODE(ins->code) == BPF_MEM)
-				op = "stx";
-			else if (BPF_MODE(ins->code) == EBPF_ATOMIC) {
-				op = atomic_op(ins->imm);
-				if (op == NULL) {
-					fprintf(f, "// BUG: ATOMIC operation 0x%x in eBPF insns\n",
-						ins->imm);
-					break;
-				}
-			} else {
-				fprintf(f, "// BUG: STX opcode 0x%02x in eBPF insns\n",
-					ins->code);
-				break;
-			}
-			postfix = size_tbl[BPF_SIZE_INDEX(ins->code)];
-			fprintf(f, "%s%s [r%d + %d], r%u\n", op, postfix,
-				ins->dst_reg, ins->off, ins->src_reg);
-			break;
-#define L(pc, off) ((int)(pc) + 1 + (off))
-		case BPF_JMP:
-			op = jump_tbl[BPF_OP_INDEX(ins->code)];
 			if (ins->src_reg != 0)
-				/* Not yet supported variation with non-zero src w/o condition. */
+				/* Not yet supported variation with non-zero src. */
 				warning = ", src != 0";
+			val = (uint32_t)ins[0].imm |
+				(uint64_t)(uint32_t)ins[1].imm << 32;
+			return snprintf(buffer, bufsz, "%s%s r%d, #0x%"PRIx64"%s",
+				op, postfix, ins->dst_reg, val, warning);
+		}
+		switch (BPF_MODE(ins->code)) {
+		case BPF_IMM:
+			return snprintf(buffer, bufsz, "%s%s r%d, #0x%x", op, postfix,
+				ins->dst_reg, ins->imm);
+		case BPF_ABS:
+			return snprintf(buffer, bufsz, "%s%s r%d, [%d]", op, postfix,
+				ins->dst_reg, ins->imm);
+		case BPF_IND:
+			return snprintf(buffer, bufsz, "%s%s r%d, [r%u + %d]", op, postfix,
+				ins->dst_reg, ins->src_reg, ins->imm);
+		default:
+			return snprintf(buffer, bufsz, "// BUG: LD opcode 0x%02x in eBPF insns",
+				ins->code);
+		}
+	case BPF_LDX:
+		op = "ldx";
+		postfix = size_tbl[BPF_SIZE_INDEX(ins->code)];
+		if (BPF_MODE(ins->code) == BPF_MEM)
+			return snprintf(buffer, bufsz, "%s%s r%d, [r%u + %d]", op, postfix,
+				ins->dst_reg, ins->src_reg, ins->off);
+		else
+			return snprintf(buffer, bufsz, "// BUG: LDX opcode 0x%02x in eBPF insns",
+				ins->code);
+	case BPF_ST:
+		op = "st";
+		postfix = size_tbl[BPF_SIZE_INDEX(ins->code)];
+		if (BPF_MODE(ins->code) == BPF_MEM)
+			return snprintf(buffer, bufsz, "%s%s [r%d + %d], #0x%x", op, postfix,
+				ins->dst_reg, ins->off, ins->imm);
+		else
+			return snprintf(buffer, bufsz, "// BUG: ST opcode 0x%02x in eBPF insns",
+				ins->code);
+	case BPF_STX:
+		switch (BPF_MODE(ins->code)) {
+		case BPF_MEM:
+			op = "stx";
+			break;
+		case EBPF_ATOMIC:
+			op = atomic_op(ins->imm);
 			if (op == NULL)
-				fprintf(f, "invalid jump opcode: %#x\n", ins->code);
-			else if (BPF_OP(ins->code) == BPF_JA)
-				fprintf(f, "%s L%d%s\n", op, L(i, ins->off), warning);
-			else if (BPF_OP(ins->code) == EBPF_CALL)
-				/* Call of helper function with index in immediate. */
-				fprintf(f, "%s #%u%s\n", op, ins->imm, warning);
-			else if (BPF_OP(ins->code) == EBPF_EXIT)
-				fprintf(f, "%s%s\n", op, warning);
-			else if (BPF_SRC(ins->code) == BPF_X)
-				fprintf(f, "%s r%u, r%u, L%d\n", op, ins->dst_reg,
-					ins->src_reg, L(i, ins->off));
-			else
-				fprintf(f, "%s r%u, #0x%x, L%d\n", op, ins->dst_reg,
-					ins->imm, L(i, ins->off));
+				return snprintf(buffer, bufsz,
+					"// BUG: ATOMIC operation 0x%x in eBPF insns", ins->imm);
 			break;
-		case BPF_RET:
-			fprintf(f, "// BUG: RET opcode 0x%02x in eBPF insns\n",
+		default:
+			return snprintf(buffer, bufsz, "// BUG: STX opcode 0x%02x in eBPF insns",
 				ins->code);
-			break;
 		}
+		postfix = size_tbl[BPF_SIZE_INDEX(ins->code)];
+		return snprintf(buffer, bufsz, "%s%s [r%d + %d], r%u", op, postfix,
+			ins->dst_reg, ins->off, ins->src_reg);
+	case BPF_JMP:
+		op = jump_tbl[BPF_OP_INDEX(ins->code)];
+		if (op == NULL)
+			return snprintf(buffer, bufsz, "invalid jump opcode: %#x", ins->code);
+
+		if ((flags & RTE_BPF_FORMAT_FLAG_ABSOLUTE_JUMPS) != 0)
+			snprintf(jump, sizeof(jump), "L%d", pc + 1 + ins->off);
+		else
+			snprintf(jump, sizeof(jump), "%+d", (int)ins->off);
+
+		if (ins->src_reg != 0)
+			/* Not yet supported variation with non-zero src w/o condition. */
+			warning = ", src != 0";
+		switch (BPF_OP(ins->code)) {
+		case BPF_JA:
+			return snprintf(buffer, bufsz, "%s %s%s", op, jump, warning);
+		case EBPF_CALL:
+			/* Call of helper function with index in immediate. */
+			return snprintf(buffer, bufsz, "%s #%u%s", op, ins->imm, warning);
+		case EBPF_EXIT:
+			return snprintf(buffer, bufsz, "%s%s", op, warning);
+		}
+
+		if (BPF_SRC(ins->code) == BPF_X)
+			return snprintf(buffer, bufsz, "%s r%u, r%u, %s", op, ins->dst_reg,
+				ins->src_reg, jump);
+		else
+			return snprintf(buffer, bufsz, "%s r%u, #0x%x, %s", op, ins->dst_reg,
+				ins->imm, jump);
+	case BPF_RET:
+		return snprintf(buffer, bufsz, "// BUG: RET opcode 0x%02x in eBPF insns",
+			ins->code);
+	}
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_format, 26.07)
+int
+rte_bpf_format(char *buffer, size_t bufsz, const struct ebpf_insn *ins,
+	uint32_t pc, uint32_t flags)
+{
+	if ((flags & RTE_BPF_FORMAT_FLAG_HEXADECIMAL) != 0)
+		return format_hexadecimal(buffer, bufsz, ins, flags);
+	else
+		return format_disassembly(buffer, bufsz, ins, pc, flags);
+}
+
+RTE_EXPORT_SYMBOL(rte_bpf_dump)
+void rte_bpf_dump(FILE *f, const struct ebpf_insn *buf, uint32_t len)
+{
+	uint32_t i;
+	char buffer[256];
+
+	for (i = 0; i < len; ++i) {
+		const struct ebpf_insn *ins = buf + i;
+
+		format_disassembly(buffer, sizeof(buffer), ins, i,
+			RTE_BPF_FORMAT_FLAG_DISASSEMBLY	|
+			RTE_BPF_FORMAT_FLAG_ABSOLUTE_JUMPS);
+		fprintf(f, " L%u:\t%s\n", i, buffer);
+		i += rte_bpf_insn_is_wide(ins);
 	}
 }
diff --git a/lib/bpf/rte_bpf.h b/lib/bpf/rte_bpf.h
index 3c3848925bdf..944e0b79ac8c 100644
--- a/lib/bpf/rte_bpf.h
+++ b/lib/bpf/rte_bpf.h
@@ -30,6 +30,23 @@ extern "C" {
 /** Mask with all supported `RTE_BPF_EXEC_FLAG_*` flags set. */
 #define RTE_BPF_EXEC_FLAG_MASK  RTE_BPF_EXEC_FLAG_JIT
 
+/* Format instructions as assembler. */
+#define RTE_BPF_FORMAT_FLAG_DISASSEMBLY		0
+/* Format instructions as hexadecimal. */
+#define RTE_BPF_FORMAT_FLAG_HEXADECIMAL		RTE_BIT32(0)
+
+/* Only valid in disassembly mode. */
+/* Format jump offsets relative to the next instruction. */
+#define RTE_BPF_FORMAT_FLAG_RELATIVE_JUMPS	0
+/* Format jump targets relative to the start of the program. */
+#define RTE_BPF_FORMAT_FLAG_ABSOLUTE_JUMPS	RTE_BIT32(1)
+
+/* Only valid in hexadecimal mode. */
+/* Format full hexadecimal representation of wide instructions. */
+#define RTE_BPF_FORMAT_FLAG_AUTO_WIDE		0
+/* Format as hexadecimal only first half of wide instructions. */
+#define RTE_BPF_FORMAT_FLAG_NEVER_WIDE		RTE_BIT32(2)
+
 /**
  * Possible types for function/BPF program arguments.
  */
@@ -387,6 +404,40 @@ __rte_experimental
 int
 rte_bpf_get_jit_ex(const struct rte_bpf *bpf, struct rte_bpf_jit_ex *jit);
 
+/**
+ * Determine instruction width.
+ *
+ * @return
+ *   True if ins points to a wide (128-bit) instruction.
+ */
+__rte_experimental
+bool
+rte_bpf_insn_is_wide(const struct ebpf_insn *ins);
+
+/**
+ * Print eBPF instruction into a buffer.
+ *
+ * Semantics of handling buffer size repeats those of snprintf.
+ *
+ * @param buffer
+ *   Output buffer (may be NULL if bufsz is zero).
+ * @param bufsz
+ *   Output buffer size.
+ * @param ins
+ *   Narrow or wide (depending on opcode) eBPF instruction. That is, when
+ *   `rte_bpf_insn_is_wide` is true `ins[1]` is also accessed.
+ * @param pc
+ *   Current instruction number for displaying absolute jump targets.
+ * @param flags
+ *   Bitwise-OR combination of `RTE_BPF_FORMAT_FLAG_*` values.
+ * @return
+ *   Number of characters to be written excluding terminating zero.
+ */
+__rte_experimental
+int
+rte_bpf_format(char *buffer, size_t bufsz, const struct ebpf_insn *ins,
+	uint32_t pc, uint32_t flags);
+
 /**
  * Dump epf instructions to a file.
  *
-- 
2.43.0

