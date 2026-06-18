Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38DA5CD98ED
	for <dpdk-dev@archiver.kernel.org>; Thu, 18 Jun 2026 21:01:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B45440679;
	Thu, 18 Jun 2026 23:00:45 +0200 (CEST)
Received: from mail-dy1-f172.google.com (mail-dy1-f172.google.com
 [74.125.82.172]) by mails.dpdk.org (Postfix) with ESMTP id B2A6C4028F
 for <dev@dpdk.org>; Thu, 18 Jun 2026 23:00:39 +0200 (CEST)
Received: by mail-dy1-f172.google.com with SMTP id
 5a478bee46e88-30bb7d20ad9so2092228eec.1
 for <dev@dpdk.org>; Thu, 18 Jun 2026 14:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1781816439;
 x=1782421239; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=A2dOx4jjpoyjHjF1nlYPvjqlz6WambqZdxrCH0U193c=;
 b=mEqh3VvnWiI7OhMupNGlGqC85cqmbloKpVoLqq9+tQspKD5ubwcINGY1trojgdPnYQ
 fGbnYfFRTu60dbrCCrEGs+agFIWiEaVCdybtQP/oAd/5SVFrNEkooLAicKWQgPugqvPw
 apBYo/XGP/3OuD1L4c1PqNL2LibnOSRn2j8c3LggRaoM+zYLRsiWLl4bj8m8Z3uEimEl
 JYCMCplz7WGkY2Ld0zzdrRoEJ/QTUiDu7ysX8/OZOgbDV3T2QAO/VKG3TcfdaPhXf/G2
 ygXhdISkyzq65WrpPUKzNiDMZzzOxLcCfjqN4SadVU9SsGiQkD3GSPhUXvBHos+VZ37i
 SIog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781816439; x=1782421239;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=A2dOx4jjpoyjHjF1nlYPvjqlz6WambqZdxrCH0U193c=;
 b=QrdQwREWOb5q4N7BsE8ppQA5z5eQuSTPvqIlXSULr0OUC4MzgCB3qF3A23+RF9shSV
 SgW71jTsYErF4GMnC1inKrj6UP/oN20mlqAWtO75qSz5T+slXYJ1vjuVl+XuuYWPZWJp
 87UCbRN9+BJrbmp1YJNvv6DjVdBLXDTFv952xiJIp6Fa6FtonaH4Cdi0Q/wgPuqRyWUR
 aU/XO9HxDnXNnwxMEQDrWNSIbJ7zQnhO8A8BA+MsPhyduVpL7z9/d11qGxgvZThxpGQE
 Pnyd6XXHMBqzRPFN2UyYwZa4Q1G0yJmTRSvpf9fFTqjXQaVvo6m/RiJxrBAZJmI18apK
 4aCg==
X-Gm-Message-State: AOJu0YyD3Ci9ZiohHzPh6TKdjPb7sTbWeYmbgIRRfmwJdupGcAMrGATp
 KW3+8ODDN9stxPY8t+0KYPLG71vt9/Yn0bsUNnobZiwLFbRp1o056XUIF65WszG5TlkeG1U0BmX
 zxk8b
X-Gm-Gg: AfdE7ckGRqDd0KZKcey4rBcHpWjzP3vTZ7a9YtrJY5cGwCahIC91OZJIl4KoC/lk0Eo
 EM44O0115DV+DrGCCPxb5EFDJ0ughDkBiWThDmMnqH2Xn0s+V/pGiiUDGlV7YP7YHkL/MqdoXkG
 3twtSxTQtpZ66//0FJWdYmGj7d+OWR8FzipRAlcYU7Gnk1DP8oRS/yqn0wXrc+lru0JMQVPLrN3
 6JkSQ71RE2NFTexTuLuVEHsHbXL9Ei37BEpGX6Y3eHZKUX6m7UtJ2PLzyTNiio+Z4vYGbnVj77r
 h03QP13UF4nRL77YLzzSS+RgziHLbYe8VMu9d64zOzV+b6Ro4nDnwF7dH7NqZIW3k+Vo+YfGLX2
 Zzm6jhhNVUp2wlaNHYSwdAmW7fgPdeiFwFpidfT9xOY7nKlY3VLg+SZYwF1gPs5b7wCzuNVdK0P
 3iGL8Lu5F554k6Yiz5Iw+G5LYosVBkKveRiMY+3y0z/4r6dw12otU=
X-Received: by 2002:a05:7300:6ca7:b0:304:ab8:f87c with SMTP id
 5a478bee46e88-30c06fff418mr851541eec.12.1781816438468; 
 Thu, 18 Jun 2026 14:00:38 -0700 (PDT)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c06d6766fsm863387eec.29.2026.06.18.14.00.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 18 Jun 2026 14:00:37 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>
Subject: [PATCH v2 5/6] bpf/arm64: add BPF_ABS/BPF_IND packet load support
Date: Thu, 18 Jun 2026 13:47:09 -0700
Message-ID: <20260618210026.430288-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260618210026.430288-1-stephen@networkplumber.org>
References: <20260608203322.1116296-1-stephen@networkplumber.org>
 <20260618210026.430288-1-stephen@networkplumber.org>
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
index 67e42015de..3fc16fd984 100644
--- a/lib/bpf/bpf_jit_arm64.c
+++ b/lib/bpf/bpf_jit_arm64.c
@@ -1125,6 +1125,135 @@ emit_branch(struct a64_jit_ctx *ctx, uint8_t op, uint32_t i, int16_t off)
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
@@ -1137,8 +1266,17 @@ check_program_has_call(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
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
@@ -1340,6 +1478,15 @@ emit(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
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

