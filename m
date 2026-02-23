Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F98AEC1127
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Feb 2026 19:35:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3B59D4025E;
	Mon, 23 Feb 2026 20:35:28 +0100 (CET)
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
 by mails.dpdk.org (Postfix) with ESMTP id 5EDAB400EF
 for <dev@dpdk.org>; Mon, 23 Feb 2026 20:35:27 +0100 (CET)
Received: by mail-dl1-f49.google.com with SMTP id
 a92af1059eb24-1271195d2a7so381170c88.0
 for <dev@dpdk.org>; Mon, 23 Feb 2026 11:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771875326;
 x=1772480126; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=VUK4uGhH6J2x/kwJf1Jn4hIcSUa7wchQQdY7DGuRGTw=;
 b=fl+c5m45+lCY914Mh/RE/BRD7GcArDlM0iijmAzniXmMnYL2PMxiYAkbNSzhp4Q+ZK
 tMqSOGPZxnLaC4OFCsCoLp7PSv9DKeuWA964ss1z3iusbGJXYTg1lkAOgkER7cNMooaF
 NgmzxBeaDMkghV29qBhb3pxpNMC5zzj09P4Ue5mK9lXQuafookEU/g8WZAbh9pIEVy3L
 psBMVQSp0ifXl1+l7E8UsW/0/hy23pvzvZqfwCMxxBsnaJQDlwnMpkHBTVw9obSHCt+y
 lr1drM1w6pLkSZxJWNmMupgttKkFxd14A/hfMk0oWhDC7x/Sf7yMpx13qphwsJavPOgd
 gvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771875326; x=1772480126;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VUK4uGhH6J2x/kwJf1Jn4hIcSUa7wchQQdY7DGuRGTw=;
 b=ZeO3T+xR5jIHWm8700TiA7MVePg3Th9HflTsmRSiutN/l3s1QMpW+KvM0xFCeBHsJd
 STVwa1fjmfKElllE2Wi9ZJygeCH1JaWGWMOWj4PKtG2rSLBAEWpgJ+xU4E4YNRGZcei2
 XW5PTJFl0QQ/+wjRZG1hbCl7yKQjvZ617GKB400jBmv+g0kD+1iMiUo/G94sCbodDCt5
 76SHdrUodjfmyDgMQP+4MvUO8jgYSmUjbgeuDZjte6olSQtyE8Fo+uu0NFGABBT/O9Z4
 WXJpIJv07BqcDUfhzVWqyeaeofLyr7bs6lOOXLUCiJDHFdp/tFhWAjovViH6mrn5GEDT
 oyuw==
X-Gm-Message-State: AOJu0YzbwVxIw0zjD+Qe1Aaj4/cpZLlNbUTzZ2xPH5FNZDE1TJqThoRp
 PBCFQudPuGYaRswS2AtgiKBI5eyD4Ef00vHFg/7pmXnYKpGCL2ZDtoqYCLpHCKvQ3ED01vgiFgf
 FiOCU
X-Gm-Gg: AZuq6aLi3t70r6cZZwoTMqykLB1CwHt3lnr5dmDxjrp8UCVwQhxMARDEuncN1qlLKL4
 gJFJEsiH0mfGiV8QfubZTG0scAP5qXElDyDTzcFSve+liiLzkksE4KJilA6KgVNohyvE6fvf2JQ
 knaNj43kyGc8aBoqbMmctuZfXesj5to8qTfxaJKQs3tLnzkaHe47HuQLtd146k1AlDU85DorPdm
 N0qGMHFtG6bbsHa+kzZWrxlAO6VQ3XaDkvpY6znNji21h0gZb6dvfGhq+26BuCefVaJgXkYnIZp
 z53pukO+L67R96flr5Rg4Te06+JxwVfH5BvSihxHN4CQ6Q6+jqTMR6FMnkrke4fOgn8I00JOq9Q
 7rrnMjoukhcn9XP4o86si8NMCKa4Fotpvg6tmaUdyXP43ddC6Onw04id8kPnsETBc5QR32pgcOD
 V1lrYtt9qNwXOcqGpuC6zPSjZ9Z0YpZuRWfJKaaHa1pfzIbR+tGbeRlAm8jAWvRw==
X-Received: by 2002:a05:7022:f83:b0:11a:3a1c:6c5c with SMTP id
 a92af1059eb24-1276acb316cmr4771931c88.3.1771875325933; 
 Mon, 23 Feb 2026 11:35:25 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1276af102d9sm7821624c88.1.2026.02.23.11.35.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 23 Feb 2026 11:35:25 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [RFC] bpf/arm64: add BPF_ABS/BPF_IND packet load support
Date: Mon, 23 Feb 2026 11:34:34 -0800
Message-ID: <20260223193522.323100-1-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
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

Use AI to generate the missing BPF_LD | BPF_ABS and BPF_LD | BPF_IND
instruction support to the arm64 JIT. These are needed for packet
data access in programs produced by rte_bpf_convert().
Without this the JIT rejects converted cBPF programs with "invalid opcode 0x30".

Uses a fast path for single-segment mbufs and falls back to
__rte_pktmbuf_read() for multi-segment packets, matching the
approach used by the x86 JIT.

Bugzilla ID: 1427

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/bpf_jit_arm64.c | 301 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 301 insertions(+)

diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
index a04ef33a9c..dff101dbba 100644
--- a/lib/bpf/bpf_jit_arm64.c
+++ b/lib/bpf/bpf_jit_arm64.c
@@ -3,11 +3,13 @@
  */
 
 #include <errno.h>
+#include <stddef.h>
 #include <stdbool.h>
 #include <stdlib.h>
 
 #include <rte_common.h>
 #include <rte_byteorder.h>
+#include <rte_mbuf.h>
 
 #include "bpf_impl.h"
 
@@ -43,6 +45,7 @@ struct a64_jit_ctx {
 	uint32_t program_start;   /* Program index, Just after prologue */
 	uint32_t program_sz;      /* Program size. Found in first pass */
 	uint8_t foundcall;        /* Found EBPF_CALL class code in eBPF pgm */
+	uint8_t foundldmbuf;      /* Found BPF_ABS/BPF_IND in eBPF pgm */
 };
 
 static int
@@ -1137,12 +1140,293 @@ check_program_has_call(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
 		switch (op) {
 		/* Call imm */
 		case (BPF_JMP | EBPF_CALL):
+		/*
+		 * BPF_ABS/BPF_IND instructions may need to call
+		 * __rte_pktmbuf_read() in the slow path, so treat
+		 * them as having a call for register save purposes.
+		 */
+		case (BPF_LD | BPF_ABS | BPF_B):
+		case (BPF_LD | BPF_ABS | BPF_H):
+		case (BPF_LD | BPF_ABS | BPF_W):
+		case (BPF_LD | BPF_IND | BPF_B):
+		case (BPF_LD | BPF_IND | BPF_H):
+		case (BPF_LD | BPF_IND | BPF_W):
 			ctx->foundcall = 1;
+			ctx->foundldmbuf = 1;
 			return;
 		}
 	}
 }
 
+/*
+ * Emit SUBS (extended register) for comparing with zero-extended halfword.
+ * Used to compare: data_len - offset against size.
+ * CMP (imm): SUBS Xd, Xn, #imm
+ */
+static void
+emit_cmp_imm(struct a64_jit_ctx *ctx, bool is64, uint8_t rn, uint16_t imm12)
+{
+	uint32_t insn, imm;
+	int32_t simm;
+
+	imm = mask_imm(12, imm12);
+	simm = (int32_t)imm12;
+	insn = RTE_SHIFT_VAL32(is64, 31);
+	insn |= RTE_SHIFT_VAL32(1, 30); /* SUB */
+	insn |= RTE_SHIFT_VAL32(1, 29); /* set flags */
+	insn |= UINT32_C(0x11000000);
+	insn |= A64_ZR; /* Rd = ZR for CMP */
+	insn |= RTE_SHIFT_VAL32(rn, 5);
+	insn |= RTE_SHIFT_VAL32(imm, 10);
+
+	emit_insn(ctx, insn, check_reg(rn) || check_imm(12, simm));
+}
+
+/*
+ * Emit a load from [rn + unsigned immediate offset].
+ * LDR (unsigned offset): size determined by sz parameter.
+ */
+static void
+emit_ldr_uimm(struct a64_jit_ctx *ctx, uint8_t sz, uint8_t rt, uint8_t rn,
+	       uint16_t uimm)
+{
+	uint32_t insn, scale, imm;
+	int32_t simm;
+
+	/* Determine scale from BPF size encoding */
+	if (sz == BPF_B)
+		scale = 0;
+	else if (sz == BPF_H)
+		scale = 1;
+	else if (sz == BPF_W)
+		scale = 2;
+	else /* EBPF_DW */
+		scale = 3;
+
+	/* imm12 is the offset divided by the access size */
+	imm = uimm >> scale;
+	simm = (int32_t)imm;
+
+	insn = RTE_SHIFT_VAL32(scale, 30);
+	insn |= UINT32_C(0x39400000); /* LDR (unsigned offset) base */
+	insn |= RTE_SHIFT_VAL32(mask_imm(12, imm), 10);
+	insn |= RTE_SHIFT_VAL32(rn, 5);
+	insn |= rt;
+
+	emit_insn(ctx, insn, check_reg(rt) || check_reg(rn) ||
+		  check_imm(12, simm) || check_ls_sz(sz));
+}
+
+/*
+ * Emit code for BPF_LD | BPF_ABS and BPF_LD | BPF_IND packet loads.
+ *
+ * These instructions load data from the packet referenced by the mbuf
+ * pointer implicitly held in EBPF_REG_6. The algorithm mirrors the
+ * inline rte_pktmbuf_read():
+ *
+ *   fast path (single-segment, contiguous):
+ *     off = imm               (BPF_ABS)
+ *     off = src_reg + imm     (BPF_IND)
+ *     if (off + size <= mbuf->data_len)
+ *         R0 = *(type *)(mbuf->buf_addr + mbuf->data_off + off)
+ *         R0 = bswap(R0)    // network to host byte order
+ *     else goto slow_path
+ *
+ *   slow path (multi-segment or out-of-bounds):
+ *     ptr = __rte_pktmbuf_read(mbuf, off, size, tmp_buf_on_stack)
+ *     if (ptr == NULL) goto exit
+ *     R0 = *(type *)ptr
+ *     R0 = bswap(R0)
+ */
+static void
+emit_ld_mbuf(struct a64_jit_ctx *ctx, uint8_t op, uint8_t src,
+	     int32_t imm, uint8_t tmp1, uint8_t tmp2)
+{
+	uint8_t r0, r6;
+	uint8_t mode, opsz;
+	uint32_t sz;
+	int32_t exit_off;
+
+	r0 = ebpf_to_a64_reg(ctx, EBPF_REG_0);
+	r6 = ebpf_to_a64_reg(ctx, EBPF_REG_6);
+
+	mode = BPF_MODE(op);
+	opsz = BPF_SIZE(op);
+	sz = bpf_size(opsz);
+
+	/*
+	 * Compute the packet offset in tmp1.
+	 * BPF_ABS: off = imm
+	 * BPF_IND: off = src_reg + imm
+	 */
+	emit_mov_imm(ctx, 1, tmp1, imm);
+	if (mode == BPF_IND)
+		emit_add(ctx, 1, tmp1, src);
+
+	/*
+	 * Fast path: check if access is within the first segment.
+	 * Load mbuf->data_len (uint16_t) into tmp2.
+	 */
+	emit_ldr_uimm(ctx, BPF_H, tmp2, r6,
+		       offsetof(struct rte_mbuf, data_len));
+	/* Zero-extend tmp2 to 64-bit (data_len is 16-bit) */
+	emit_bitfield(ctx, 1, tmp2, tmp2, 0, 15, A64_UBFM);
+
+	/* tmp2 = data_len - off */
+	emit_sub(ctx, 1, tmp2, tmp1);
+
+	/*
+	 * If data_len - off < sz, the access extends beyond the first
+	 * segment. Branch to the slow path.
+	 * CMP tmp2, #sz; B.LT slow_path
+	 *
+	 * The slow path is a fixed number of instructions ahead.
+	 * Fast path remaining instructions (counted below):
+	 *   emit_ldr_uimm  (buf_addr)    1
+	 *   emit_ldr_uimm  (data_off)    1
+	 *   emit_bitfield  (zext)        1
+	 *   emit_add       (+ data_off)  1
+	 *   emit_add       (+ off)       1
+	 *   emit_ldr       (load value)  1
+	 *   emit_rev / emit_zero_extend  1 or 2 (max 2)
+	 *   emit_b         (skip slow)   1
+	 * Total fast path after branch: max 9 instructions
+	 *
+	 * We branch forward to the slow path start.
+	 * Calculate as: the b_cond instruction itself is at current idx,
+	 * then 9 instructions of fast path follow, so slow path starts
+	 * at +10 from the b_cond (but b_cond offset is in instructions
+	 * relative to itself, so +10).
+	 *
+	 * Use B.LT for signed comparison: if data_len < off, tmp2 went
+	 * negative so this catches both insufficient length and negative
+	 * offset results.
+	 */
+	emit_cmp_imm(ctx, 1, tmp2, sz);
+	/* Count of fast path instructions to skip: varies by byte-swap */
+	{
+		/*
+		 * For BPF_B: no swap needed, just zero_extend 64 = nop
+		 * For BPF_H: rev16 + zero_extend = 2 insns
+		 * For BPF_W: rev32 = 1 insn
+		 * To simplify, use a fixed forward offset.
+		 * Fast path body: 6 insns (load ptr computation + ldr) +
+		 * swap (0 for B, 2 for H, 1 for W) + 1 branch = 7..9
+		 *
+		 * Use the two-pass approach: first pass calculates offsets,
+		 * second pass emits. We track the instruction index.
+		 */
+		uint32_t fast_start, fast_end, slow_start, slow_end;
+
+		fast_start = ctx->idx;
+
+		/* Placeholder: emit B.LT with a dummy offset (will be fixed) */
+		emit_b_cond(ctx, A64_LT, 0);
+
+		/* === Fast path body === */
+
+		/* Load buf_addr (void *, 8 bytes at offset 0) into r0 */
+		emit_ldr_uimm(ctx, EBPF_DW, r0, r6,
+			       offsetof(struct rte_mbuf, buf_addr));
+
+		/* Load data_off (uint16_t) into tmp2 */
+		emit_ldr_uimm(ctx, BPF_H, tmp2, r6,
+			       offsetof(struct rte_mbuf, data_off));
+		/* Zero-extend data_off to 64-bit */
+		emit_bitfield(ctx, 1, tmp2, tmp2, 0, 15, A64_UBFM);
+
+		/* r0 = buf_addr + data_off */
+		emit_add(ctx, 1, r0, tmp2);
+		/* r0 = buf_addr + data_off + off */
+		emit_add(ctx, 1, r0, tmp1);
+
+		/* Load the actual value: r0 = *(size *)r0 */
+		emit_mov_imm(ctx, 1, tmp2, 0);
+		emit_ldr(ctx, opsz, r0, r0, tmp2);
+
+		/* Byte-swap from network order to host order */
+		if (opsz == BPF_H)
+			emit_rev(ctx, r0, 16);
+		else if (opsz == BPF_W)
+			emit_rev(ctx, r0, 32);
+		/* BPF_B: no swap needed */
+
+		/* Skip the slow path */
+		emit_b(ctx, 0); /* placeholder */
+		fast_end = ctx->idx;
+
+		/* === Slow path === */
+		slow_start = ctx->idx;
+
+		/*
+		 * Call __rte_pktmbuf_read(mbuf, off, len, buf).
+		 * ARM64 calling convention: R0-R3 are arguments.
+		 * R0 = mbuf (EBPF_REG_6)
+		 * R1 = off (tmp1)
+		 * R2 = len (sz)
+		 * R3 = buf (stack pointer, we use current SP as temp buf)
+		 *
+		 * The caller-save EBPF registers R1-R5 are scratch anyway
+		 * for BPF_ABS/BPF_IND instructions per the BPF spec.
+		 */
+
+		/* R0 = mbuf */
+		emit_mov_64(ctx, A64_R(0), r6);
+		/* R1 = off (already in tmp1, move to A64_R(1)) */
+		emit_mov_64(ctx, A64_R(1), tmp1);
+		/* R2 = size */
+		emit_mov_imm(ctx, 0, A64_R(2), sz);
+		/* R3 = address of temp buffer on the stack (use SP) */
+		emit_mov_64(ctx, A64_R(3), A64_SP);
+
+		/* Call __rte_pktmbuf_read */
+		emit_mov_imm(ctx, 1, tmp2, (uint64_t)__rte_pktmbuf_read);
+		emit_blr(ctx, tmp2);
+
+		/* Check return value: if NULL, exit with 0 */
+		/* R0 has the return value (pointer or NULL) */
+		emit_cbnz(ctx, 1, A64_R(0), 3);
+		emit_mov_imm(ctx, 1, r0, 0);
+		exit_off = (ctx->program_start + ctx->program_sz) - ctx->idx;
+		emit_b(ctx, exit_off);
+
+		/* Load value from returned pointer */
+		emit_mov_imm(ctx, 1, tmp2, 0);
+		emit_ldr(ctx, opsz, A64_R(0), A64_R(0), tmp2);
+
+		/* Byte-swap from network order to host order */
+		if (opsz == BPF_H)
+			emit_rev(ctx, A64_R(0), 16);
+		else if (opsz == BPF_W)
+			emit_rev(ctx, A64_R(0), 32);
+		/* BPF_B: no swap needed */
+
+		/* Move result to EBPF R0 register */
+		emit_mov_64(ctx, r0, A64_R(0));
+
+		slow_end = ctx->idx;
+
+		/*
+		 * Now fix up the forward branches that were emitted with
+		 * placeholder offsets. We re-emit them with correct offsets.
+		 *
+		 * The B.LT at fast_start should jump to slow_start.
+		 * The B at fast_end-1 should jump to slow_end.
+		 */
+		if (ctx->ins != NULL) {
+			/* Fix B.LT: offset from fast_start to slow_start */
+			ctx->idx = fast_start;
+			emit_b_cond(ctx, A64_LT,
+				    (int32_t)(slow_start - fast_start));
+
+			/* Fix B: offset from fast_end-1 to slow_end */
+			ctx->idx = fast_end - 1;
+			emit_b(ctx, (int32_t)(slow_end - (fast_end - 1)));
+		}
+		ctx->idx = slow_end;
+	}
+}
+
 /*
  * Walk through eBPF code and translate them to arm64 one.
  */
@@ -1162,6 +1446,13 @@ emit(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
 	ctx->idx = 0;
 	/* arm64 SP must be aligned to 16 */
 	ctx->stack_sz = RTE_ALIGN_MUL_CEIL(bpf->stack_sz, 16);
+	/*
+	 * BPF_ABS/BPF_IND instructions need a temporary buffer on the
+	 * stack for __rte_pktmbuf_read(). Reserve at least 16 bytes
+	 * (aligned) below the BPF stack for this purpose.
+	 */
+	if (ctx->foundldmbuf && ctx->stack_sz == 0)
+		ctx->stack_sz = 16;
 	tmp1 = ebpf_to_a64_reg(ctx, TMP_REG_1);
 	tmp2 = ebpf_to_a64_reg(ctx, TMP_REG_2);
 	tmp3 = ebpf_to_a64_reg(ctx, TMP_REG_3);
@@ -1338,6 +1629,16 @@ emit(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
 			emit_mov_imm(ctx, 1, dst, u64);
 			i++;
 			break;
+		/* R0 = ntoh(*(size *)(mbuf->pkt_data + imm)) */
+		case (BPF_LD | BPF_ABS | BPF_B):
+		case (BPF_LD | BPF_ABS | BPF_H):
+		case (BPF_LD | BPF_ABS | BPF_W):
+		/* R0 = ntoh(*(size *)(mbuf->pkt_data + src + imm)) */
+		case (BPF_LD | BPF_IND | BPF_B):
+		case (BPF_LD | BPF_IND | BPF_H):
+		case (BPF_LD | BPF_IND | BPF_W):
+			emit_ld_mbuf(ctx, op, src, imm, tmp1, tmp2);
+			break;
 		/* *(size *)(dst + off) = src */
 		case (BPF_STX | BPF_MEM | BPF_B):
 		case (BPF_STX | BPF_MEM | BPF_H):
-- 
2.51.0

