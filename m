Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92393C61DB9
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 21:43:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 907364060F;
	Thu, 27 Aug 2026 23:43:16 +0200 (CEST)
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com
 [209.85.214.182])
 by mails.dpdk.org (Postfix) with ESMTP id 7C75D406BC
 for <dev@dpdk.org>; Thu, 27 Aug 2026 23:43:15 +0200 (CEST)
Received: by mail-pl1-f182.google.com with SMTP id
 d9443c01a7336-2d715f4a587so4809745ad.2
 for <dev@dpdk.org>; Thu, 27 Aug 2026 14:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1787866995;
 x=1788471795; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=KJkxyQyZ/0NXEwdND5T+V2O4BPd9buEu2RdwAnMeqws=;
 b=O1hDV632l4v//vhkqP0TAbJhDrzipVNPRZguFfMa6LPlDMXninjB2bOjBFfNUdeJlW
 1O7MfUsZTVCUZiQMnSRqTcRU68Hs7t5awmeoSMXi3bH/s37asj02CI4djyRvpj7niMsZ
 Yr4AOiPjb3ea9hArPJ0h2vHC+KrX/anhHh1BolL+q8rBll73jfgO303WaeRYLoChWAAo
 t0C1TVcqKDe6zYlODWRRzmrgJkO7/hxXtKGktJ/OnzJjqbj0mJhNwySwiI08pomEXHQU
 rPVrpC3D9XubZhJhGEI89Yb14+JNrzu4dW6g6DVtSAoB6JxThNQPxWSmMQ1s7DJIb9Cr
 ZprA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787866995; x=1788471795;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=KJkxyQyZ/0NXEwdND5T+V2O4BPd9buEu2RdwAnMeqws=;
 b=ibalKEp70oZ4qHT5IPuCau9OR5vE9W1cbQcwc9xirhyrIjM0k7vHuJGS15+fU2r3dG
 YDWvHK/h5kGTCCy4fgMR5+rV7NOkpqbSUseVi5pQEcdXEk820wRUpESxBMK23RRhnYNS
 5osctrwJ6xsRDFo+nJhPXXOYhsTGv3VKAMsA5YaCkzyA0irfJ+cYRNyydBhCrCFrhhgg
 NGMLdpxfC5tQvzRl5QYg1rOTeUx3qbVMq4mmjy3i69FIR6Up1wT2gSkimHGAbmeOxjq1
 GRuP0B3NWSrLzwz+BZAjcT9wjmCns78AUJY1wEXcU680uhdoO4wJ2vbmodrNt60ThjbU
 /OUw==
X-Gm-Message-State: AFuF++mTWQBSRb33l8U4TbQ66MP4X5ulCaBIj2ADWDc9+6TRE8vgzP5K
 1N95VondQr7vWz1Qqzg7mMKlQnjNR2wgprJNeTjB7XZ3oJWhKonBJ1h+d0nFti0hxkON4Jbly8x
 TNWgo
X-Gm-Gg: AR+sD139j+D0C/RD9dR7aHBnPNrm/Z4VZBEESrVta3Zkd8jElEv2qAmmkmArW87RosE
 mByW4Cfnxi0j/1VE1Hp/ndaro1wnG2P/2yYkf//5LPglRH4XGYHLQKqHAU/e+VpRPLEftahkHYH
 hZ3pzZqlO6+px04iyGrgo23aMEQnoVq0fFjEjYdF4oWJJoUtIw6GVD88OwJqpNYdbzFAQNVV1TN
 NQ+kFFHY2qnUIB3Ho/BtrMiTVP5ESpyD4VbTorqVvxJ3rY2qzdKPAHwDuJTQXl5dZUPH1oCbR5C
 7FGSh9j/TM4hpoBOvcnJ/5wqfEHv1UA6bqLT5BR+Joy8D+kJQsyyFZfrRwBhk5te3tl+aSGsXnZ
 Ba0jpKIjFgINhTKvJEiWiDmbURhvj8N1IGDcUhxts4oxP7RZWFcYpkB7UtdXhndrI7wPIJLfQfG
 SjcDEKwHgNaYsZjUcSHT+LgR+1g9coTG9H7VzwfBvXYp0CNLQicx4vrC/eC0VA8uLKZIGey6mK4
 m036+VNR1UVfT0a3iBLciZsp+zm
X-Received: by 2002:a17:903:8d0:b0:2d7:4cd4:5a7f with SMTP id
 d9443c01a7336-2d74def6351mr40743955ad.12.1787866994636; 
 Thu, 27 Aug 2026 14:43:14 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3285d1075ddsm9642445eec.29.2026.08.27.14.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Aug 2026 14:43:14 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Marat Khalili <marat.khalili@huawei.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH v8 07/10] Subject: [PATCH 07/10] bpf/arm64: add
 BPF_ABS/BPF_IND packet load support
Date: Thu, 27 Aug 2026 14:41:46 -0700
Message-ID: <20260827214236.1415047-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260827214236.1415047-1-stephen@networkplumber.org>
References: <0260608203322.1116296-1-stephen@networkplumber.org>
 <20260827214236.1415047-1-stephen@networkplumber.org>
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

emit_call() materializes the helper address with a variable number of
instructions, so the block sizes are not known up front. Size the three
blocks in a dry run, then emit for real with the branches resolved.

For BPF_IND the offset is a runtime value, so it is checked for being
negative or too large for the uint32_t off argument of
__rte_pktmbuf_read(). For BPF_ABS the offset is the instruction
immediate, so those checks are dropped and a negative immediate
compiles to a return of zero.

Programs using these opcodes use the call register layout, since the
slow path makes a function call.

Bugzilla ID: 1427

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/bpf/bpf_jit_arm64.c | 188 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 187 insertions(+), 1 deletion(-)

diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
index 51906c7f0d..fc922006eb 100644
--- a/lib/bpf/bpf_jit_arm64.c
+++ b/lib/bpf/bpf_jit_arm64.c
@@ -8,6 +8,7 @@
 
 #include <rte_common.h>
 #include <rte_byteorder.h>
+#include <rte_debug.h>
 
 #include "bpf_impl.h"
 
@@ -1133,6 +1134,173 @@ emit_branch(struct a64_jit_ctx *ctx, uint8_t op, uint32_t i, int16_t off)
 	emit_b_cond(ctx, ebpf_to_a64_cond(op), jump_offset_get(ctx, i, off));
 }
 
+/* LD_ABS/LD_IND code block offsets (in arm64 instructions) */
+enum {
+	LDMB_FAST_OFS, /* fast path */
+	LDMB_SLOW_OFS, /* slow path */
+	LDMB_FIN_OFS,  /* common tail */
+	LDMB_OFS_NUM
+};
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
+	emit_mov_imm(ctx, 1, tmp1, imm);
+
+	if (mode == BPF_IND) {
+		/* off = imm + src */
+		emit_add(ctx, 1, tmp1, src);
+
+		/*
+		 * src is a runtime value, so off may be negative.
+		 * That would pass the signed check below and read before the segment,
+		 * so route it to the slow path which rejects it.
+		 */
+		emit_cmp(ctx, 1, tmp1, A64_ZR);
+		emit_b_cond(ctx, A64_MI, (int32_t)(ofs[LDMB_SLOW_OFS] - ctx->idx));
+	}
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
+ * Helper for emit_ld_mbuf(): slow path.
+ * R0 = __rte_pktmbuf_read(mbuf, off, sz, buf); return 0 if NULL.
+ * The scratch buffer is the space reserved by __rte_bpf_validate() at the
+ * bottom of the eBPF stack frame, i.e. (frame_pointer - stack_ofs).
+ */
+static void
+emit_ldmb_slow_path(struct a64_jit_ctx *ctx, uint8_t mode, uint32_t sz,
+		    uint32_t stack_ofs)
+{
+	uint8_t r0 = ebpf_to_a64_reg(ctx, EBPF_REG_0);
+	uint8_t r6 = ebpf_to_a64_reg(ctx, EBPF_REG_6);
+	uint8_t fp = ebpf_to_a64_reg(ctx, EBPF_FP);
+	uint8_t tmp1 = ebpf_to_a64_reg(ctx, TMP_REG_1);
+	uint8_t tmp2 = ebpf_to_a64_reg(ctx, TMP_REG_2);
+
+	if (mode == BPF_IND) {
+		/*
+		 * __rte_pktmbuf_read() takes a uint32_t off, so a 64-bit off
+		 * that does not fit would be silently truncated.  Return 0 if
+		 * out of range; this also catches the negative off routed here
+		 * by the fast path.
+		 */
+		emit_mov_imm(ctx, 1, tmp2, UINT32_MAX);
+		emit_cmp(ctx, 1, tmp1, tmp2);
+		emit_b_cond(ctx, A64_LS, 3);	/* in range: do the call */
+		emit_mov_imm(ctx, 1, r0, 0);
+		emit_b(ctx, (ctx->program_start + ctx->program_sz) - ctx->idx);
+	}
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
+ * For BPF_ABS the offset is a constant, so the range checks on off are only
+ * emitted for BPF_IND.
+ *
+ * The three blocks are sized in a dry run so the forward branches can be
+ * resolved, then emitted for real.  Both runs see the same immediates, so
+ * they emit the same instructions; the recorded offsets are only valid
+ * while that holds, hence the checks.
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
+	/* a constant negative offset is never inside the packet */
+	if (mode == BPF_ABS && imm < 0) {
+		emit_mov_imm(ctx, 1, ebpf_to_a64_reg(ctx, EBPF_REG_0), 0);
+		emit_b(ctx, (ctx->program_start + ctx->program_sz) - ctx->idx);
+		return;
+	}
+
+	/* seed offsets so the dry-run branches stay in range */
+	ofs[LDMB_FAST_OFS] = ofs[LDMB_SLOW_OFS] = ofs[LDMB_FIN_OFS] = ctx->idx;
+
+	/* dry run to record block offsets */
+	emit_ldmb_fast_path(ctx, src, mode, sz, imm, ofs);
+	ofs[LDMB_SLOW_OFS] = ctx->idx;
+	emit_ldmb_slow_path(ctx, mode, sz, stack_ofs);
+	ofs[LDMB_FIN_OFS] = ctx->idx;
+	emit_ldmb_fin(ctx, opsz, sz);
+
+	/* rewind and emit for real with resolved offsets */
+	ctx->idx = ofs[LDMB_FAST_OFS];
+	emit_ldmb_fast_path(ctx, src, mode, sz, imm, ofs);
+	RTE_VERIFY(ctx->idx == ofs[LDMB_SLOW_OFS]);
+	emit_ldmb_slow_path(ctx, mode, sz, stack_ofs);
+	RTE_VERIFY(ctx->idx == ofs[LDMB_FIN_OFS]);
+	emit_ldmb_fin(ctx, opsz, sz);
+}
+
 static void
 check_program_has_call(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
 {
@@ -1145,8 +1313,17 @@ check_program_has_call(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
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
@@ -1348,6 +1525,15 @@ emit(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
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

