Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78F80F53D8B
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 19:12:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 83DC34025E;
	Mon, 16 Mar 2026 20:12:48 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by mails.dpdk.org (Postfix) with ESMTP id 3B74F400D5
 for <dev@dpdk.org>; Mon, 16 Mar 2026 20:12:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773688366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+0DTuhIrcKwUAczl0Pd+mpipTT4PpmRui+GKv1bw2eA=;
 b=elKgTiNKhY/tx7mqjAjbHSw+WW5k2P6gXHyBbu6Ukdn8bcftYvBSalhpnm0cyssL1rEeK6
 FIrEUuICicPBaoyhNRbLpi5PXHWICDD71w28tJ2+ByH+fkhCF37yPEprp+qLYm/bJ8ghCO
 0GcpljssudGkLnjnNAyT3plCTfvyclU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-382-Y1FUfVZdPLi9PA5H_dbYQw-1; Mon,
 16 Mar 2026 15:12:43 -0400
X-MC-Unique: Y1FUfVZdPLi9PA5H_dbYQw-1
X-Mimecast-MFC-AGG-ID: Y1FUfVZdPLi9PA5H_dbYQw_1773688362
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A2CCF195604F; Mon, 16 Mar 2026 19:12:41 +0000 (UTC)
Received: from fedora-linux-42 (unknown [10.44.32.8])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D29AC180075B; Mon, 16 Mar 2026 19:12:39 +0000 (UTC)
From: Christophe Fontaine <cfontain@redhat.com>
To: dev@dpdk.org
Cc: Christophe Fontaine <cfontain@redhat.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH] bpf/arm64: support packet data load instructions
Date: Tue, 10 Mar 2026 13:20:44 +0100
Message-ID: <20260310122045.4057836-1-cfontain@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: g-BanNzfXgF__-0srybTNp0-d-1vLMbDYYdizjQQWgU_1773688362
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

arm64 jit compiler didn't support reading from a packet.
Enable arm64 JIT to generate native code for
(BPF_ABS | <size> | BPF_LD) and (BPF_IND | <size> | BPF_LD)
instructions.

Compared to the x86_64 HIT, only a "slow path" is implemented,
'__rte_pktmbuf_read' is systematically called.

Signed-off-by: Christophe Fontaine <cfontain@redhat.com>
---
 app/test/test_bpf.c     | 42 ++++++++++++++++++++++++++
 lib/bpf/bpf_jit_arm64.c | 65 +++++++++++++++++++++++++++++++++++++++++
 2 files changed, 107 insertions(+)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 093cf5fe1d..8d5c0d6de1 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -2750,6 +2750,30 @@ static const struct rte_bpf_xsym test_call5_xsym[] = {
 	},
 };
 
+/* load mbuf (BPF_ABS/BPF_IND) test-cases */
+static const struct ebpf_insn test_ld_mbuf0_prog[] = {
+	/* BPF_ABS/BPF_IND implicitly expect mbuf ptr in R6 */
+	{
+		.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
+		.dst_reg = EBPF_REG_6,
+		.src_reg = EBPF_REG_1,
+	},
+	/* load IPv4 version and IHL */
+	{
+		.code = (BPF_LD | BPF_ABS | BPF_B),
+		.imm = offsetof(struct rte_ipv4_hdr, version_ihl),
+	},
+	{
+		.code = (BPF_JMP | EBPF_EXIT),
+	},
+};
+
+static int
+test_ld_mbuf0_check(uint64_t rc, const void *arg)
+{
+	return cmp_res(__func__, 0x45, rc, arg, arg, 0);
+}
+
 /* load mbuf (BPF_ABS/BPF_IND) test-cases */
 static const struct ebpf_insn test_ld_mbuf1_prog[] = {
 
@@ -3417,6 +3441,22 @@ static const struct bpf_test tests[] = {
 		/* for now don't support function calls on 32 bit platform */
 		.allow_fail = (sizeof(uint64_t) != sizeof(uintptr_t)),
 	},
+	{
+		.name = "test_ld_mbuf0",
+		.arg_sz = sizeof(struct dummy_mbuf),
+		.prm = {
+			.ins = test_ld_mbuf0_prog,
+			.nb_ins = RTE_DIM(test_ld_mbuf0_prog),
+			.prog_arg = {
+				.type = RTE_BPF_ARG_PTR_MBUF,
+				.buf_size = sizeof(struct dummy_mbuf),
+			},
+		},
+		.prepare = test_ld_mbuf1_prepare,
+		.check_result = test_ld_mbuf0_check,
+		/* mbuf as input argument is not supported on 32 bit platform */
+		.allow_fail = (sizeof(uint64_t) != sizeof(uintptr_t)),
+	},
 	{
 		.name = "test_ld_mbuf1",
 		.arg_sz = sizeof(struct dummy_mbuf),
@@ -3491,6 +3531,7 @@ run_test(const struct bpf_test *tst)
 	if (ret != 0) {
 		printf("%s@%d: check_result(%s) failed, error: %d(%s);\n",
 			__func__, __LINE__, tst->name, ret, strerror(ret));
+		return -1;
 	}
 
 	/* repeat the same test with jit, when possible */
@@ -3506,6 +3547,7 @@ run_test(const struct bpf_test *tst)
 				"error: %d(%s);\n",
 				__func__, __LINE__, tst->name,
 				rv, strerror(rv));
+			return -1;
 		}
 	}
 
diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
index a04ef33a9c..5d5710b876 100644
--- a/lib/bpf/bpf_jit_arm64.c
+++ b/lib/bpf/bpf_jit_arm64.c
@@ -8,6 +8,7 @@
 
 #include <rte_common.h>
 #include <rte_byteorder.h>
+#include <rte_mbuf.h>
 
 #include "bpf_impl.h"
 
@@ -965,6 +966,54 @@ emit_return_zero_if_src_zero(struct a64_jit_ctx *ctx, bool is64, uint8_t src)
 	emit_b(ctx, jump_to_epilogue);
 }
 
+/*
+ * Emit code for BPF_LD | BPF_ABS/IND: load from packet.
+ * Calls __rte_pktmbuf_read(mbuf, off, len, buf).
+ */
+static void
+emit_ld_mbuf(struct a64_jit_ctx *ctx, uint32_t op, uint8_t tmp1, uint8_t tmp2,
+	uint8_t src, uint32_t imm)
+{
+	uint8_t r0 = ebpf_to_a64_reg(ctx, EBPF_REG_0);
+	uint8_t r6 = ebpf_to_a64_reg(ctx, EBPF_REG_6);
+	uint32_t mode = BPF_MODE(op);
+	uint32_t opsz = BPF_SIZE(op);
+	uint32_t sz = bpf_size(opsz);
+	int16_t jump_to_epilogue;
+
+	/* r0 = mbuf (R6) */
+	emit_mov_64(ctx, A64_R(0), r6);
+
+	/* r1 = off: for ABS use imm, for IND use src + imm */
+	if (mode == BPF_ABS) {
+		emit_mov_imm(ctx, 1, A64_R(1), imm);
+	} else {
+		emit_mov_imm(ctx, 1, tmp2, imm);
+		emit_add(ctx, 1, tmp2, src);
+		emit_mov_64(ctx, A64_R(1), tmp2);
+	}
+
+	/* r2 = len */
+	emit_mov_imm(ctx, 1, A64_R(2), sz);
+
+	/* r3 = buf (SP) */
+	emit_mov_64(ctx, A64_R(3), A64_SP);
+
+	/* call __rte_pktmbuf_read */
+	emit_call(ctx, tmp1, __rte_pktmbuf_read);
+	/* check return value of __rte_pktmbuf_read */
+	emit_cbnz(ctx, 1, A64_R(0), 3);
+	emit_mov_imm(ctx, 1, r0, 0);
+	jump_to_epilogue = (ctx->program_start + ctx->program_sz) - ctx->idx;
+	emit_b(ctx, jump_to_epilogue);
+
+	/* r0 points to the data, load 1/2/4 bytes */
+	emit_ldr(ctx, opsz, A64_R(0), A64_R(0), A64_ZR);
+	if (sz != sizeof(uint8_t))
+		emit_be(ctx, A64_R(0), sz * CHAR_BIT);
+	emit_mov_64(ctx, r0, A64_R(0));
+}
+
 static void
 emit_stadd(struct a64_jit_ctx *ctx, bool is64, uint8_t rs, uint8_t rn)
 {
@@ -1137,6 +1186,13 @@ check_program_has_call(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
 		switch (op) {
 		/* Call imm */
 		case (BPF_JMP | EBPF_CALL):
+		/* BPF_LD | BPF_ABS/IND use __rte_pktmbuf_read */
+		case (BPF_LD | BPF_ABS | BPF_B):
+		case (BPF_LD | BPF_ABS | BPF_H):
+		case (BPF_LD | BPF_ABS | BPF_W):
+		case (BPF_LD | BPF_IND | BPF_B):
+		case (BPF_LD | BPF_IND | BPF_H):
+		case (BPF_LD | BPF_IND | BPF_W):
 			ctx->foundcall = 1;
 			return;
 		}
@@ -1338,6 +1394,15 @@ emit(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
 			emit_mov_imm(ctx, 1, dst, u64);
 			i++;
 			break;
+		/* load absolute/indirect from packet */
+		case (BPF_LD | BPF_ABS | BPF_B):
+		case (BPF_LD | BPF_ABS | BPF_H):
+		case (BPF_LD | BPF_ABS | BPF_W):
+		case (BPF_LD | BPF_IND | BPF_B):
+		case (BPF_LD | BPF_IND | BPF_H):
+		case (BPF_LD | BPF_IND | BPF_W):
+			emit_ld_mbuf(ctx, op, tmp1, tmp2, src, imm);
+			break;
 		/* *(size *)(dst + off) = src */
 		case (BPF_STX | BPF_MEM | BPF_B):
 		case (BPF_STX | BPF_MEM | BPF_H):
-- 
2.53.0

