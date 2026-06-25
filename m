Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A226CDE000
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 17:33:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 865BA40684;
	Thu, 25 Jun 2026 19:32:51 +0200 (CEST)
Received: from mail-dl1-f48.google.com (mail-dl1-f48.google.com [74.125.82.48])
 by mails.dpdk.org (Postfix) with ESMTP id C737140651
 for <dev@dpdk.org>; Thu, 25 Jun 2026 19:32:42 +0200 (CEST)
Received: by mail-dl1-f48.google.com with SMTP id
 a92af1059eb24-139986373b8so196582c88.0
 for <dev@dpdk.org>; Thu, 25 Jun 2026 10:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782408762;
 x=1783013562; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ScGfGwQ33ZhILAXnORX6aQ5T/X3sLrrvqTXqzwH43rM=;
 b=UjEbt0ftFGznjAGRkh/TdzS+AScNX2HYPGggu8HIpF1g9zjHwrTpuZ9GoRnWAp4d99
 Ga/009dwPS8/BuQSdi8QvLhodulm8a8PLgathHwkrBrqzVkR9K786pVyjZP6lgE86W5P
 j65vh8Y2T26b+WqEkqjAKu70FqwSaXVxoG5q54o501xuvW9rqCP3Tn4Ji+TO54XUBvf5
 UI7ukT1h/PIFsMGL/A9YdODbakGV69WaalCzLAjTFoaed6Bg3He/8A5ARVvKDmiODIwg
 uNvfyTvlqZR2DV2tiOGwBaNcde8pA3XYXsRNH9WLzVd4r79ga8A6YX6PkIGqG53x/8uI
 5dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782408762; x=1783013562;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ScGfGwQ33ZhILAXnORX6aQ5T/X3sLrrvqTXqzwH43rM=;
 b=ZW4p4rBjciwQmjaCY/368kkzGmyeZHQS9ZoFaC5TOlTDhgluXAGgbikwhqtjxbMCyi
 ycD7gjmLtT6rpE50mpBcjCVbZHIsoGpHPUJ3UCT4bWAFViRoqw0ZHD9XIRnajS+I0Udu
 jTVj96YMEhsPs4dJDWDibX/QBTNBl5fgqvEOyKQ/jcxFn0tWa/3txQ18TkN815tafJ7X
 aVVZ2yXlcnDSaqngsJvaUD3YKVObELpDeeYxC2iMmF/Sw9fKR76l6rOwc3XXo2VX0g0+
 VtLQc0PJhcqyp417k1Zo2sOkuJkidJM2nRBv2u+CO/H3tP4zZS1ewtl2d28dnNzw+Fw8
 luUQ==
X-Gm-Message-State: AOJu0YzBexCi9O22O6YJpBlz9tqc4Kv82wkDp77tpVHXUQ8OT8O+Pqn3
 IrYNBxm59tEFjHfmLSa6HacPD+3YgSSjpj9nEeQPHmwjuP1iB4eTms+Smtqi+IRmIqSNio4NmmW
 QIpBt
X-Gm-Gg: AfdE7clI+VoWhz4G+Yf5n7MBmgsijj44iY6FQBPzvw19FVe1nvbn65IdYdrvtFpM8BZ
 bs7gjMK80KN9rVywur8qo8k9lTJlPit1cchEySZWCNExWOuwKGrFyTe7j3qa/vdr+JjBctDbjqJ
 hmeUk/k+FqZx6unqILxohXJCIaMmhF+QdjXWZ2O88DEkzvotCgx97EIl+MEYCAicf/K66xlCIj4
 2bPz2qTqUD6nNmtQ+korDroy36MHqyh/VlKpy5nCiBzpWNxeeI0DS/5SamDei6fVClp/TDJI52w
 hKFPwVmbywKE3+AaUv/VPfh9n8u0+uqcaykMixpgkFlDqVqNI5DscaAYMJ3f49oFYb5tO1ywuD/
 89RZlHDlKENnXefvDj0sDyqwInnxVp3YivPSVova3BRvuPAjiQ6FJRo/VQ/ToIi/tcpyfz+K45e
 Zr7QBGdkq9AKVKRG1vzYvCpQwYvFDE5h1go+D0lsFdpmskP5Knqsg=
X-Received: by 2002:a05:701b:4554:20b0:139:879c:dba1 with SMTP id
 a92af1059eb24-139dbb1937emr2175696c88.5.1782408761575; 
 Thu, 25 Jun 2026 10:32:41 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-139d8f6acf9sm10218165c88.6.2026.06.25.10.32.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 10:32:41 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v6 7/9] bpf/arm64: add BPF_ABS/BPF_IND packet load support
Date: Thu, 25 Jun 2026 10:30:17 -0700
Message-ID: <20260625173231.216074-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260625173231.216074-1-stephen@networkplumber.org>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260625173231.216074-1-stephen@networkplumber.org>
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

