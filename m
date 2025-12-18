Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A50BD6E2BD
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Dec 2025 17:11:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5C4B040615;
	Thu, 18 Dec 2025 18:11:14 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id E9E104060A
 for <dev@dpdk.org>; Thu, 18 Dec 2025 18:11:12 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.150])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dXHHS3vj9zHnGdq
 for <dev@dpdk.org>; Fri, 19 Dec 2025 01:10:44 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 1BADE4056A
 for <dev@dpdk.org>; Fri, 19 Dec 2025 01:11:12 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 18 Dec 2025 18:11:11 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: <dev@dpdk.org>, Konstantin Ananyev <konstantin.ananyev@huawei.com>
Subject: [PATCH v2 2/2] bpf: dump additional instructions
Date: Thu, 18 Dec 2025 17:09:13 +0000
Message-ID: <20251218170914.7737-3-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251218170914.7737-1-marat.khalili@huawei.com>
References: <20251217172037.59170-1-marat.khalili@huawei.com>
 <20251218170914.7737-1-marat.khalili@huawei.com>
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

Fix issues with rte_bpf_dump not supporting or printing incorrectly some
instructions that lib/bpf supports, and add warnings when it doesn't:

* Conditional jump with condition between two registers was incorrectly
  printed by rte_bpf_dump as one with condition between register and
  immediate. Add missing handling of BPF_X flag.

* Call instruction was printed by rte_bpf_dump as conditional jump. Add
  explicit handling for it.

* We only support stx and ldx instructions in BPF_MEM mode, but were not
  checking the mode in rte_bpf_dump. Check for mode and only print
  mnemonic if the mode is BPF_MEM, otherwise print an error.

* Atomic instructions were not previously supported by rte_bpf_dump. Add
  necessary handling.

* Some instructions have variations with previously unused src_reg or
  offset fields set to non-zero value. We do not support any of these
  variations yet, and were printing them as a standard instruction.
  Print small note after such instructions warning the user that this is
  a variation.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/bpf/bpf_dump.c | 69 ++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 57 insertions(+), 12 deletions(-)

diff --git a/lib/bpf/bpf_dump.c b/lib/bpf/bpf_dump.c
index 6ee0e32b43..91bc7c0a7a 100644
--- a/lib/bpf/bpf_dump.c
+++ b/lib/bpf/bpf_dump.c
@@ -44,6 +44,19 @@ static const char *const jump_tbl[16] = {
 	[EBPF_CALL >> 4] = "call", [EBPF_EXIT >> 4] = "exit",
 };
 
+static inline const char *
+atomic_op(int32_t imm)
+{
+	switch (imm) {
+	case BPF_ATOMIC_ADD:
+		return "xadd";
+	case BPF_ATOMIC_XCHG:
+		return "xchg";
+	default:
+		return NULL;
+	}
+}
+
 RTE_EXPORT_SYMBOL(rte_bpf_dump)
 void rte_bpf_dump(FILE *f, const struct ebpf_insn *buf, uint32_t len)
 {
@@ -52,7 +65,7 @@ void rte_bpf_dump(FILE *f, const struct ebpf_insn *buf, uint32_t len)
 	for (i = 0; i < len; ++i) {
 		const struct ebpf_insn *ins = buf + i;
 		uint8_t cls = BPF_CLASS(ins->code);
-		const char *op, *postfix = "";
+		const char *op, *postfix = "", *warning = "";
 
 		fprintf(f, " L%u:\t", i);
 
@@ -66,12 +79,15 @@ void rte_bpf_dump(FILE *f, const struct ebpf_insn *buf, uint32_t len)
 			/* fall through */
 		case EBPF_ALU64:
 			op = alu_op_tbl[BPF_OP_INDEX(ins->code)];
+			if (ins->off != 0)
+				/* Not yet supported variation with non-zero offset. */
+				warning = ", off != 0";
 			if (BPF_SRC(ins->code) == BPF_X)
-				fprintf(f, "%s%s r%u, r%u\n", op, postfix, ins->dst_reg,
-					ins->src_reg);
+				fprintf(f, "%s%s r%u, r%u%s\n", op, postfix, ins->dst_reg,
+					ins->src_reg, warning);
 			else
-				fprintf(f, "%s%s r%u, #0x%x\n", op, postfix,
-					ins->dst_reg, ins->imm);
+				fprintf(f, "%s%s r%u, #0x%x%s\n", op, postfix,
+					ins->dst_reg, ins->imm, warning);
 			break;
 		case BPF_LD:
 			op = "ld";
@@ -79,10 +95,13 @@ void rte_bpf_dump(FILE *f, const struct ebpf_insn *buf, uint32_t len)
 			if (ins->code == (BPF_LD | BPF_IMM | EBPF_DW)) {
 				uint64_t val;
 
+				if (ins->src_reg != 0)
+					/* Not yet supported variation with non-zero src. */
+					warning = ", src != 0";
 				val = (uint32_t)ins[0].imm |
 					(uint64_t)(uint32_t)ins[1].imm << 32;
-				fprintf(f, "%s%s r%d, #0x%"PRIx64"\n",
-					op, postfix, ins->dst_reg, val);
+				fprintf(f, "%s%s r%d, #0x%"PRIx64"%s\n",
+					op, postfix, ins->dst_reg, val, warning);
 				i++;
 			} else if (BPF_MODE(ins->code) == BPF_IMM)
 				fprintf(f, "%s%s r%d, #0x%x\n", op, postfix,
@@ -100,8 +119,12 @@ void rte_bpf_dump(FILE *f, const struct ebpf_insn *buf, uint32_t len)
 		case BPF_LDX:
 			op = "ldx";
 			postfix = size_tbl[BPF_SIZE_INDEX(ins->code)];
-			fprintf(f, "%s%s r%d, [r%u + %d]\n", op, postfix, ins->dst_reg,
-				ins->src_reg, ins->off);
+			if (BPF_MODE(ins->code) == BPF_MEM)
+				fprintf(f, "%s%s r%d, [r%u + %d]\n", op, postfix, ins->dst_reg,
+					ins->src_reg, ins->off);
+			else
+				fprintf(f, "// BUG: LDX opcode 0x%02x in eBPF insns\n",
+					ins->code);
 			break;
 		case BPF_ST:
 			op = "st";
@@ -114,7 +137,20 @@ void rte_bpf_dump(FILE *f, const struct ebpf_insn *buf, uint32_t len)
 					ins->code);
 			break;
 		case BPF_STX:
-			op = "stx";
+			if (BPF_MODE(ins->code) == BPF_MEM)
+				op = "stx";
+			else if (BPF_MODE(ins->code) == EBPF_ATOMIC) {
+				op = atomic_op(ins->imm);
+				if (op == NULL) {
+					fprintf(f, "// BUG: ATOMIC operation 0x%x in eBPF insns\n",
+						ins->imm);
+					break;
+				}
+			} else {
+				fprintf(f, "// BUG: STX opcode 0x%02x in eBPF insns\n",
+					ins->code);
+				break;
+			}
 			postfix = size_tbl[BPF_SIZE_INDEX(ins->code)];
 			fprintf(f, "%s%s [r%d + %d], r%u\n", op, postfix,
 				ins->dst_reg, ins->off, ins->src_reg);
@@ -122,12 +158,21 @@ void rte_bpf_dump(FILE *f, const struct ebpf_insn *buf, uint32_t len)
 #define L(pc, off) ((int)(pc) + 1 + (off))
 		case BPF_JMP:
 			op = jump_tbl[BPF_OP_INDEX(ins->code)];
+			if (ins->src_reg != 0)
+				/* Not yet supported variation with non-zero src w/o condition. */
+				warning = ", src != 0";
 			if (op == NULL)
 				fprintf(f, "invalid jump opcode: %#x\n", ins->code);
 			else if (BPF_OP(ins->code) == BPF_JA)
-				fprintf(f, "%s L%d\n", op, L(i, ins->off));
+				fprintf(f, "%s L%d%s\n", op, L(i, ins->off), warning);
+			else if (BPF_OP(ins->code) == EBPF_CALL)
+				/* Call of helper function with index in immediate. */
+				fprintf(f, "%s #%u%s\n", op, ins->imm, warning);
 			else if (BPF_OP(ins->code) == EBPF_EXIT)
-				fprintf(f, "%s\n", op);
+				fprintf(f, "%s%s\n", op, warning);
+			else if (BPF_SRC(ins->code) == BPF_X)
+				fprintf(f, "%s r%u, r%u, L%d\n", op, ins->dst_reg,
+					ins->src_reg, L(i, ins->off));
 			else
 				fprintf(f, "%s r%u, #0x%x, L%d\n", op, ins->dst_reg,
 					ins->imm, L(i, ins->off));
-- 
2.43.0

