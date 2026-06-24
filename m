Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787DACDB47F
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Jun 2026 17:59:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F2231406B4;
	Wed, 24 Jun 2026 19:58:34 +0200 (CEST)
Received: from mail-dy1-f181.google.com (mail-dy1-f181.google.com
 [74.125.82.181]) by mails.dpdk.org (Postfix) with ESMTP id F345C40656
 for <dev@dpdk.org>; Wed, 24 Jun 2026 19:58:27 +0200 (CEST)
Received: by mail-dy1-f181.google.com with SMTP id
 5a478bee46e88-30c6836fea9so94096eec.1
 for <dev@dpdk.org>; Wed, 24 Jun 2026 10:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1782323907;
 x=1782928707; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DO0aTcIAhTzDd0V2/51EuThP76x4riXeonZoosBGnuo=;
 b=GR9vb24j4dfpLNbRv18XJhOv3imlCu3XYNTPX8Loj8PlV6c3I1W9j7KKXlExQfpjMP
 /rCjOoCIfWx2TMoD0B5CPo4CJ8tt9j5zNVsWZJMebdbNdfjiX/vdikf4b0+UE4GHrP7H
 8w4D++Jtv/jLGBNZQSeSoXezeaRv1DxHDcB2k+zaWlnI8ZTVhbe7Jjs4zmFCuYAuU9Uh
 WiSS1MNEWW8G1HbEovI7AKEJ2naAULOcv43fpFbpmu8r4kK7yL8aCF/1uEC34DUkNswu
 Rgb1QG8YFa+IDH7G2kcJgp7yTSYu9XM4CiDTyb9wiAtBrwGJwU2HFn9HwVOk8C1AZO6u
 +56A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782323907; x=1782928707;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=DO0aTcIAhTzDd0V2/51EuThP76x4riXeonZoosBGnuo=;
 b=Inby7p4FadUTPO0tWszsY+BVfYx4tG5A7Ky9rNWB0vxxBJzRfF+9dcZz1Q4DpngZ39
 Ld6Rj4aVNYAOjePtiRNM5qvcbR8MGndXVHR0GgjNgUEDw+1UHZDE6ZH8q0C0rkESM3FX
 bXI/UqBp6SvOlKSngXBCVf8TMZgojTRXRTXDBPum3Xio5lC4SNUjxqn5nIZMBNTSVfms
 MJSpDISETguNicWV2Lri+/guCK11CF/w7vz8ed+SSeMb8I3V9u8DtYagsSFJYVdVSwYm
 p8oeIEeZLpuxGYOniPbRay/BlDh4hRkuBOUE1EjdK8N2YIwmg9asqU+hgwWEs7fhHODd
 VJ/w==
X-Gm-Message-State: AOJu0YyaT3TkDjR5rgt1vCB1QtPwE1MicsvwCEeUwUjPx9rRrY2TcRbB
 QXi74vh0JpCOi7qWWpvcCdA3MMtLpqc8o8yqtmDwGc6B9G4Nl6qjkaVyP0oF5Pppo3NeRq12kq8
 VY7J5
X-Gm-Gg: AfdE7cn3we7IeRv60hvP6ZUxbbWXkpLMMgLpmnJaaNl5VKfHieT9gEZjXucEDusvXma
 uw1BicovoeOQw8hn7El8GCz7u3TVwunNnZvGIRlTXOQAYPXmP4x4Zfr1H3YEQwWXYPXXKCRx4zE
 f/V0PU4UkUEmDwqKNLnmRBVQX+bJZqWdupMQlRjD+AM+VDHXxl6QrCRwl405AlAxZD8WZEXz1je
 JtFtq0tGSp+tLC97n4Xz3Z4qTyUFaHrWqy31OZqQWGd0Y7qhbklWuwmtCEJiC/DrkNmvIzkZSki
 PVe5R8MGPdlTjab9QFbXjz31PfgMuWxXs3rstgx40OZ22wMmZ+JtWH/0NkJ86yNXw5Lps8vMP5k
 bigCJoHvgXsNnz+Namx6mEwCwmO2XMbp296HSLBvHu/U0DhH1FYFrZ4lFTasVTQwAwr8P494AEe
 sm0FIlIOr7LIYwRsV3Ynn2YbywmDeBYvazHkpPoSVBCqXzSnDVMPM=
X-Received: by 2002:a05:7300:bc19:b0:2c9:ee15:a0ee with SMTP id
 5a478bee46e88-30c78e5fa37mr900796eec.12.1782323906913; 
 Wed, 24 Jun 2026 10:58:26 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c7cab08c2sm696325eec.29.2026.06.24.10.58.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2026 10:58:26 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v5 7/9] bpf/arm64: add BPF_ABS/BPF_IND packet load support
Date: Wed, 24 Jun 2026 10:55:06 -0700
Message-ID: <20260624175815.673064-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260624175815.673064-1-stephen@networkplumber.org>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260624175815.673064-1-stephen@networkplumber.org>
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

Programs using these opcodes use the call register layout, since the
slow path makes a function call.

Bugzilla ID: 1427

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 lib/bpf/bpf_jit_arm64.c | 149 +++++++++++++++++++++++++++++++++++++++-
 1 file changed, 148 insertions(+), 1 deletion(-)

diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
index 51906c7f0d..62fe5bf0dc 100644
--- a/lib/bpf/bpf_jit_arm64.c
+++ b/lib/bpf/bpf_jit_arm64.c
@@ -1133,6 +1133,135 @@ emit_branch(struct a64_jit_ctx *ctx, uint8_t op, uint32_t i, int16_t off)
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
+ * emit code for BPF_ABS/BPF_IND load.
+ * generates the following construction:
+ * fast_path:
+ *   off = src + imm
+ *   if (mbuf->data_len - off < sz)
+ *      goto slow_path;
+ *   ptr = mbuf->buf_addr + mbuf->data_off + off;
+ *   goto fin_part;
+ * slow_path:
+ *   typeof(sz) buf;  // scratch space reserved on the eBPF stack
+ *   ptr = __rte_pktmbuf_read(mbuf, off, sz, &buf);
+ *   if (ptr == NULL)
+ *      return 0;
+ * fin_part:
+ *   res = *(typeof(sz))ptr;
+ *   res = ntoh(res);
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
@@ -1145,8 +1274,17 @@ check_program_has_call(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
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
@@ -1348,6 +1486,15 @@ emit(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
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

