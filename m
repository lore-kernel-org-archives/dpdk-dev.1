Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51CEC4453A
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Jul 2026 18:34:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DBC840A7D;
	Wed, 22 Jul 2026 20:34:05 +0200 (CEST)
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com
 [209.85.215.172])
 by mails.dpdk.org (Postfix) with ESMTP id AAB9840664
 for <dev@dpdk.org>; Wed, 22 Jul 2026 20:34:02 +0200 (CEST)
Received: by mail-pg1-f172.google.com with SMTP id
 41be03b00d2f7-c9e30214d8fso9170919a12.3
 for <dev@dpdk.org>; Wed, 22 Jul 2026 11:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1784745242;
 x=1785350042; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UMMBypWBfozl+nslaKjcvgkOpR54OHaxFuMMMXCqMtk=;
 b=D0uoIkB6YZjTxMVnoEVwszl6Z/NEPD+f0WpxFEA3SGrV73opCVgDELBeaxel9hngy0
 KB/HRY+Kw2cNbqQZle0unwjgsQ+uDudrrScyMVswj/uWf28WaDD7rJnOikQWdj/YLF8P
 QzKnd7sOBbxBW4SUmkYFpkp/4iRFxsxLhFgP0efM7HdmYCPU/Rva7FQ5Vz48RX/F01+p
 j3IQXwgNdPV+mqPrqXLlcUUbNkKLVf3p0wlVMw7rKiBz2iv+AzydBUelKA9nmnCKBuTD
 j9wmcypFkACjTcK5CdtNjXFtX9Dm363pokY4TedR7AyEbpapa7WxetOJwvChaFkvmOka
 U3pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784745242; x=1785350042;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UMMBypWBfozl+nslaKjcvgkOpR54OHaxFuMMMXCqMtk=;
 b=SZwBR17RDtwvNiSmeZa1gSj5Fl8MOTNbfHacAU9uDdzO/37YFXl/zR/LWCb3VWses/
 Gh98qt7Ef/DXV3zXif5NrnfhkS77BwYSsYIL8aCQFA7GJY3Vys5OFEno4TrE6QtK+k5S
 Qtuw4HSkSppmr6BIp2XcRy85ptqb92SQ0pcBpMoxOdfQDpBRESOthHA7i6ph41vEpSIH
 SucdvKBDEg1j8ufZZGv/Yh4sPfmP6c+FtjymaQYgnB3yrXfr5jRd8a0MDwOtqv3zSEVB
 pzSec013BpYmLatjxPYD01jM555WX333EtuFxvN6ii5C/Ax6jq6RuLorQeOz87Iew8Tm
 YfHw==
X-Gm-Message-State: AOJu0YwgbHx1wooXOZvi+Jy3SBcscM9R8yvwfzTUPukTVv7Bg4Vjl2NT
 dkG+xhRjmeWjoPzYcACjqWsvyBqieaPB8A0a1fQpUg4phBLBsVMkvCuQjavaFRjRLqtShnNLSu1
 Y5BR6
X-Gm-Gg: AR+sD13TjYDnZ8XV+VqVRL3FJE2wJvtGzHa3nxL1FVbGFYJqHkNqd+DhCEvEilQd5xy
 J6DIny/KBApJC3nMg+DeAzoNCy3OAskX6W1P9x/P9hQc86pKOqdxZ8Il8+Pesd11iqehlgFqZP2
 3cTJDSVhSMxCl3fzacbtg2j+//QMIMZuxIvbFj1GEu0n3pOvA8aUsLsSSYJa0UtAWd3d1lXz7aK
 R2XnMtnkxyIalVVi6YzAgyqsx3aaiiuq1DS0Eg2+IL1KRIZxozC2KGfUOgLKq+Kl6FKEW9A+ozT
 HgCO6xVGN+x6vTXXWIffnLjr0fQ4mMWUHqxCY8OfJiRpDqapw0F9os1EnNpCZhjfXWjLsEY/0kp
 mrsycGr1Z/NkkUhwUIXn+IB3VH5WU3W+C46soEu1M5TxG0LlQYnS1UOkAfkT36OIXTpl3qm0+O5
 sS2P1jBLUBnchp5+60ClRgCQ0LLUXspmHsMM2L1mGu
X-Received: by 2002:a05:6a21:a8d:b0:3c3:a3f4:5485 with SMTP id
 adf61e73a8af0-3c3ad79393fmr26042548637.6.1784745241749; 
 Wed, 22 Jul 2026 11:34:01 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3147e1c7ff4sm12227744eec.27.2026.07.22.11.34.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Jul 2026 11:34:01 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH v7 07/10] bpf/arm64: add BPF_ABS/BPF_IND packet load support
Date: Wed, 22 Jul 2026 09:05:19 -0700
Message-ID: <20260722183351.633025-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260722183351.633025-1-stephen@networkplumber.org>
References: <0260608203322.1116296-1-stephen@networkplumber.org>
 <20260722183351.633025-1-stephen@networkplumber.org>
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

The arm64 JIT rejected BPF_LD | BPF_ABS and BPF_LD | BPF_IND with
"invalid opcode", so cBPF programs converted by rte_bpf_convert() could
not be JITed. Add these opcodes, mirroring the x86 JIT: a fast path for
data held in the first mbuf segment, and a __rte_pktmbuf_read() slow
path for everything else.

The forward branches over the call cannot use fixed distances:
emit_call() materializes the helper address with a variable number of
mov/movk instructions, so the block sizes are not known up front. Size
the three blocks (fast path, slow path, common tail) in a dry run, then
emit for real with the branches resolved from the measured offsets.

The effective offset is validated before use: src is a runtime value for
BPF_IND, so a negative offset is routed to the slow path rather than
read from the first segment, and the offset is bounded to UINT32_MAX
before __rte_pktmbuf_read(), whose off argument is uint32_t.

Programs using these opcodes use the call register layout, since the
slow path makes a function call.

For example, BPF_LD | BPF_IND | BPF_W (4-byte indirect load, mbuf in
R6/x19, effective offset kept in x9) emits:

	mov	x9, #imm		// off  = imm
	add	x9, x9, src		// off += src		(BPF_IND)
	cmp	x9, xzr			// reject negative
	b.mi	slow			//   effective offset
	mov	x10, #data_len_ofs
	ldrh	w10, [x19, x10]		// mbuf->data_len
	sub	x10, x10, x9		// data_len - off
	mov	x11, #sz
	cmp	x10, x11
	b.lt	slow			// not in first segment
	mov	x10, #data_off_ofs
	ldrh	w10, [x19, x10]		// mbuf->data_off
	mov	x7, #buf_addr_ofs
	ldr	x7, [x19, x7]		// mbuf->buf_addr
	add	x7, x7, x10
	add	x7, x7, x9		// ptr = buf_addr + data_off + off
	b	load
slow:
	mov	x10, #UINT32_MAX
	cmp	x9, x10
	b.ls	1f			// off fits uint32_t ...
	mov	x7, #0			//   else return 0
	b	epilogue
1:	mov	x1, x9			// __rte_pktmbuf_read(mbuf, off, sz, buf)
	mov	x0, x19
	mov	w2, #sz
	sub	x3, x25, #stack_ofs
	mov	x9, #<helper lo>
	movk	x9, #<helper hi>
	blr	x9
	mov	x7, x0			// ptr = return value
	cbnz	x7, load		// non-NULL -> common tail
	mov	x7, #0			//   else return 0
	b	epilogue
load:
	ldr	w7, [x7, xzr]		// *(uint32_t *)ptr	(size varies)
	rev32	x7, x7			// ntoh	(size varies; omitted for BPF_B)

For BPF_ABS the "add x9, x9, src" is omitted; the final load/byte-swap
vary with the access size.

Bugzilla ID: 1427

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/bpf/bpf_jit_arm64.c | 169 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 168 insertions(+), 1 deletion(-)

diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
index 51906c7f0d..6d531dc83d 100644
--- a/lib/bpf/bpf_jit_arm64.c
+++ b/lib/bpf/bpf_jit_arm64.c
@@ -1133,6 +1133,155 @@ emit_branch(struct a64_jit_ctx *ctx, uint8_t op, uint32_t i, int16_t off)
 	emit_b_cond(ctx, ebpf_to_a64_cond(op), jump_offset_get(ctx, i, off));
 }
 
+/* LD_ABS/LD_IND code block offsets (in arm64 instructions) */
+enum {
+	LDMB_FAST_OFS, /* fast path */
+	LDMB_SLOW_OFS, /* slow path */
+	LDMB_FIN_OFS,  /* common tail */
+	LDMB_OFS_NUM
+};
+
+/*
+ * Helper for emit_ld_mbuf(): fast path.
+ * Compute the packet offset; if it lies inside the first segment leave the
+ * data pointer in R0, otherwise branch to the slow path.
+ */
+static void
+emit_ldmb_fast_path(struct a64_jit_ctx *ctx, uint8_t src, uint8_t mode,
+		    uint32_t sz, int32_t imm, const uint32_t ofs[LDMB_OFS_NUM])
+{
+	uint8_t r0 = ebpf_to_a64_reg(ctx, EBPF_REG_0);
+	uint8_t r6 = ebpf_to_a64_reg(ctx, EBPF_REG_6);
+	uint8_t tmp1 = ebpf_to_a64_reg(ctx, TMP_REG_1);
+	uint8_t tmp2 = ebpf_to_a64_reg(ctx, TMP_REG_2);
+	uint8_t tmp3 = ebpf_to_a64_reg(ctx, TMP_REG_3);
+
+	/* off = imm (+ src for BPF_IND) */
+	emit_mov_imm(ctx, 1, tmp1, imm);
+	if (mode == BPF_IND)
+		emit_add(ctx, 1, tmp1, src);
+
+	/*
+	 * A negative effective offset (src can be < 0 for BPF_IND) would pass
+	 * the signed check below and read before the segment, so route it to
+	 * the slow path, which rejects it via the uint32_t bound on off.
+	 */
+	emit_cmp(ctx, 1, tmp1, A64_ZR);
+	emit_b_cond(ctx, A64_MI, (int32_t)(ofs[LDMB_SLOW_OFS] - ctx->idx));
+
+	/* if ((int64_t)(mbuf->data_len - off) < sz) goto slow_path */
+	emit_mov_imm(ctx, 1, tmp2, offsetof(struct rte_mbuf, data_len));
+	emit_ldr(ctx, BPF_H, tmp2, r6, tmp2);
+	emit_sub(ctx, 1, tmp2, tmp1);
+	emit_mov_imm(ctx, 1, tmp3, sz);
+	emit_cmp(ctx, 1, tmp2, tmp3);
+	emit_b_cond(ctx, A64_LT, (int32_t)(ofs[LDMB_SLOW_OFS] - ctx->idx));
+
+	/* R0 = mbuf->buf_addr + mbuf->data_off + off */
+	emit_mov_imm(ctx, 1, tmp2, offsetof(struct rte_mbuf, data_off));
+	emit_ldr(ctx, BPF_H, tmp2, r6, tmp2);
+	emit_mov_imm(ctx, 1, r0, offsetof(struct rte_mbuf, buf_addr));
+	emit_ldr(ctx, EBPF_DW, r0, r6, r0);
+	emit_add(ctx, 1, r0, tmp2);
+	emit_add(ctx, 1, r0, tmp1);
+
+	emit_b(ctx, (int32_t)(ofs[LDMB_FIN_OFS] - ctx->idx));
+}
+
+/*
+ * Helper for emit_ld_mbuf(): slow path.
+ * R0 = __rte_pktmbuf_read(mbuf, off, sz, buf); return 0 if NULL.
+ * The scratch buffer is the space reserved by __rte_bpf_validate() at the
+ * bottom of the eBPF stack frame, i.e. (frame_pointer - stack_ofs).
+ */
+static void
+emit_ldmb_slow_path(struct a64_jit_ctx *ctx, uint32_t sz, uint32_t stack_ofs)
+{
+	uint8_t r0 = ebpf_to_a64_reg(ctx, EBPF_REG_0);
+	uint8_t r6 = ebpf_to_a64_reg(ctx, EBPF_REG_6);
+	uint8_t fp = ebpf_to_a64_reg(ctx, EBPF_FP);
+	uint8_t tmp1 = ebpf_to_a64_reg(ctx, TMP_REG_1);
+	uint8_t tmp2 = ebpf_to_a64_reg(ctx, TMP_REG_2);
+
+	/*
+	 * __rte_pktmbuf_read() takes a uint32_t off, so a 64-bit off that does
+	 * not fit would be silently truncated.  Return 0 if it is out of range;
+	 * this also catches the negative off routed here by the fast path.
+	 */
+	emit_mov_imm(ctx, 1, tmp2, UINT32_MAX);
+	emit_cmp(ctx, 1, tmp1, tmp2);
+	emit_b_cond(ctx, A64_LS, 3);		/* off <= UINT32_MAX: do the call */
+	emit_mov_imm(ctx, 1, r0, 0);
+	emit_b(ctx, (ctx->program_start + ctx->program_sz) - ctx->idx);
+
+	/* arguments of __rte_pktmbuf_read(mbuf, off, len, buf) */
+	emit_mov_64(ctx, A64_R(1), tmp1);		/* off (held in tmp1) */
+	emit_mov_64(ctx, A64_R(0), r6);			/* mbuf */
+	emit_mov_imm(ctx, 0, A64_R(2), sz);		/* len */
+	emit_sub_imm_64(ctx, A64_R(3), fp, stack_ofs);	/* buf */
+
+	emit_call(ctx, tmp1, (void *)(uintptr_t)__rte_pktmbuf_read);
+	emit_return_zero_if_src_zero(ctx, 1, r0);
+}
+
+/*
+ * Helper for emit_ld_mbuf(): common tail.
+ * Load the value pointed to by R0 and convert from network byte order.
+ */
+static void
+emit_ldmb_fin(struct a64_jit_ctx *ctx, uint8_t opsz, uint32_t sz)
+{
+	uint8_t r0 = ebpf_to_a64_reg(ctx, EBPF_REG_0);
+
+	emit_ldr(ctx, opsz, r0, r0, A64_ZR);
+	if (opsz != BPF_B)
+		emit_be(ctx, r0, sz * 8);
+}
+
+/*
+ * Emit code for BPF_LD | BPF_ABS and BPF_LD | BPF_IND packet loads:
+ *
+ *	off = imm (+ src for BPF_IND)
+ *	if (off >= 0 && mbuf->data_len - off >= sz)	    -- fast path
+ *		ptr = mbuf->buf_addr + mbuf->data_off + off;
+ *	else						    -- slow path
+ *		if ((uint64_t)off > UINT32_MAX)
+ *			return 0;
+ *		ptr = __rte_pktmbuf_read(mbuf, off, sz, buf);
+ *		if (ptr == NULL)
+ *			return 0;
+ *	R0 = ntoh(*(size *)ptr);			    -- common tail
+ *
+ * The three blocks are sized in a dry run so the forward branches can be
+ * resolved, then emitted for real (arm64 instructions are fixed width, so
+ * the dry run reproduces the real instruction count exactly).
+ */
+static void
+emit_ld_mbuf(struct a64_jit_ctx *ctx, uint8_t op, uint8_t src, int32_t imm,
+	     uint32_t stack_ofs)
+{
+	uint8_t mode = BPF_MODE(op);
+	uint8_t opsz = BPF_SIZE(op);
+	uint32_t sz = bpf_size(opsz);
+	uint32_t ofs[LDMB_OFS_NUM];
+
+	/* seed offsets so the dry-run branches stay in range */
+	ofs[LDMB_FAST_OFS] = ofs[LDMB_SLOW_OFS] = ofs[LDMB_FIN_OFS] = ctx->idx;
+
+	/* dry run to record block offsets */
+	emit_ldmb_fast_path(ctx, src, mode, sz, imm, ofs);
+	ofs[LDMB_SLOW_OFS] = ctx->idx;
+	emit_ldmb_slow_path(ctx, sz, stack_ofs);
+	ofs[LDMB_FIN_OFS] = ctx->idx;
+	emit_ldmb_fin(ctx, opsz, sz);
+
+	/* rewind and emit for real with resolved offsets */
+	ctx->idx = ofs[LDMB_FAST_OFS];
+	emit_ldmb_fast_path(ctx, src, mode, sz, imm, ofs);
+	emit_ldmb_slow_path(ctx, sz, stack_ofs);
+	emit_ldmb_fin(ctx, opsz, sz);
+}
+
 static void
 check_program_has_call(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
 {
@@ -1145,8 +1294,17 @@ check_program_has_call(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
 		op = ins->code;
 
 		switch (op) {
-		/* Call imm */
+		/*
+		 * BPF_ABS/BPF_IND can fall through to __rte_pktmbuf_read(),
+		 * so they need the call-clobbered register layout as well.
+		 */
 		case (BPF_JMP | EBPF_CALL):
+		case (BPF_LD | BPF_ABS | BPF_B):
+		case (BPF_LD | BPF_ABS | BPF_H):
+		case (BPF_LD | BPF_ABS | BPF_W):
+		case (BPF_LD | BPF_IND | BPF_B):
+		case (BPF_LD | BPF_IND | BPF_H):
+		case (BPF_LD | BPF_IND | BPF_W):
 			ctx->foundcall = 1;
 			return;
 		}
@@ -1348,6 +1506,15 @@ emit(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
 			emit_mov_imm(ctx, 1, dst, u64);
 			i++;
 			break;
+		/* R0 = ntoh(*(size *)(mbuf data + (src) + imm)) */
+		case (BPF_LD | BPF_ABS | BPF_B):
+		case (BPF_LD | BPF_ABS | BPF_H):
+		case (BPF_LD | BPF_ABS | BPF_W):
+		case (BPF_LD | BPF_IND | BPF_B):
+		case (BPF_LD | BPF_IND | BPF_H):
+		case (BPF_LD | BPF_IND | BPF_W):
+			emit_ld_mbuf(ctx, op, src, imm, bpf->stack_sz);
+			break;
 		/* *(size *)(dst + off) = src */
 		case (BPF_STX | BPF_MEM | BPF_B):
 		case (BPF_STX | BPF_MEM | BPF_H):
-- 
2.53.0

