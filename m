Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 257E5108E1F2
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 11:45:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E29FF402F0;
	Thu, 19 Mar 2026 12:45:41 +0100 (CET)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 532BE402EF
 for <dev@dpdk.org>; Thu, 19 Mar 2026 12:45:40 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773920739;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VNcoulNxUhe3crE/GRE7A7+7hKq97P5Ds32Ente+rnY=;
 b=OS/h5R4IS1XpbHlGtRmQfK6DHArHrrLcCTN4gbQlJdOHqfMZ6uhY0+Q5WVfa9FOC1EIjwc
 sDpDNzWocpx3eCZiykn9c2H5fK2LJ3HugtESCUCj/jdWoUQapeBBwxu+N47hfz7ceL8kgg
 89WQC+VMV5/hx784wkP8PyYpuwoUcqs=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-611-qmRQU1nHP1mTyVwd1I3D_Q-1; Thu,
 19 Mar 2026 07:45:38 -0400
X-MC-Unique: qmRQU1nHP1mTyVwd1I3D_Q-1
X-Mimecast-MFC-AGG-ID: qmRQU1nHP1mTyVwd1I3D_Q_1773920737
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4D8B119560A1; Thu, 19 Mar 2026 11:45:37 +0000 (UTC)
Received: from fedora-linux-42 (unknown [10.44.32.235])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 988C81800576; Thu, 19 Mar 2026 11:45:35 +0000 (UTC)
From: Christophe Fontaine <cfontain@redhat.com>
To: dev@dpdk.org
Cc: Christophe Fontaine <cfontain@redhat.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Marat Khalili <marat.khalili@huawei.com>,
 Wathsala Vithanage <wathsala.vithanage@arm.com>
Subject: [PATCH v2 2/2] bpf/arm64: support packet data load instructions
Date: Thu, 19 Mar 2026 12:44:09 +0100
Message-ID: <20260319114500.9757-3-cfontain@redhat.com>
In-Reply-To: <20260319114500.9757-1-cfontain@redhat.com>
References: <20260310122045.4057836-1-cfontain@redhat.com>
 <20260319114500.9757-1-cfontain@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: bL2rf-suOfcGRUiy_hmeg9RLQEjoEp3Uw_Nx-D1WwkI_1773920737
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

Both 'fast path' and 'slow path' are implemented, similar to
the x86_64 JIT, where we call '__rte_pktmbuf_read' if the
requested data is not in the first segment.

Added unit test which focuses only on BPF_LD | BPF_ABS/BPF_IND and
a BPF_LD | BPF_ABS slow path call.

Signed-off-by: Christophe Fontaine <cfontain@redhat.com>
---
 app/test/test_bpf.c     | 121 ++++++++++++++++++++++++++++++++++++++++
 lib/bpf/bpf_jit_arm64.c |  86 ++++++++++++++++++++++++++++
 2 files changed, 207 insertions(+)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index dd24722450..799f9d30ca 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -2750,6 +2750,79 @@ static const struct rte_bpf_xsym test_call5_xsym[] = {
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
+/* load mbuf (BPF_ABS/BPF_IND) test-cases */
+static const struct ebpf_insn test_ld_slow_mbuf0_prog[] = {
+	/* BPF_ABS/BPF_IND implicitly expect mbuf ptr in R6 */
+	{
+		.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
+		.dst_reg = EBPF_REG_6,
+		.src_reg = EBPF_REG_1,
+	},
+	/* load from chained mbuf */
+	{
+		.code = (BPF_LD | BPF_ABS | BPF_B),
+		/* 201: second mbuf, built by test_ld_mbuf1_prepare */
+		.imm = 201 + 0x42,
+	},
+	{
+		.code = (BPF_JMP | EBPF_EXIT),
+	},
+};
+
+static const struct ebpf_insn test_ld_ind_mbuf0_prog[] = {
+	/* BPF_ABS/BPF_IND implicitly expect mbuf ptr in R6 */
+	{
+		.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
+		.dst_reg = EBPF_REG_6,
+		.src_reg = EBPF_REG_1,
+	},
+	{
+		/* Set return value to one. */
+		.code = (EBPF_ALU64 | EBPF_MOV | BPF_K),
+		.dst_reg = EBPF_REG_0,
+		.imm = 0,
+	},
+	/* load IPv4 version and IHL */
+	{
+		.code = (BPF_LD | BPF_IND | BPF_B),
+		.src_reg = EBPF_REG_0,
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
+static int
+test_ld_slow_mbuf0_check(uint64_t rc, const void *arg)
+{
+	return cmp_res(__func__, 0x42, rc, arg, arg, 0);
+}
+
 /* load mbuf (BPF_ABS/BPF_IND) test-cases */
 static const struct ebpf_insn test_ld_mbuf1_prog[] = {
 
@@ -3417,6 +3490,54 @@ static const struct bpf_test tests[] = {
 		/* for now don't support function calls on 32 bit platform */
 		.allow_fail = (sizeof(uint64_t) != sizeof(uintptr_t)),
 	},
+	{
+		.name = "test_ld_abs_mbuf0",
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
+	{
+		.name = "test_ld_slow_mbuf0",
+		.arg_sz = sizeof(struct dummy_mbuf),
+		.prm = {
+			.ins = test_ld_slow_mbuf0_prog,
+			.nb_ins = RTE_DIM(test_ld_slow_mbuf0_prog),
+			.prog_arg = {
+				.type = RTE_BPF_ARG_PTR_MBUF,
+				.buf_size = sizeof(struct dummy_mbuf),
+			},
+		},
+		.prepare = test_ld_mbuf1_prepare,
+		.check_result = test_ld_slow_mbuf0_check,
+		/* mbuf as input argument is not supported on 32 bit platform */
+		.allow_fail = (sizeof(uint64_t) != sizeof(uintptr_t)),
+	},
+	{
+		.name = "test_ld_ind_mbuf0",
+		.arg_sz = sizeof(struct dummy_mbuf),
+		.prm = {
+			.ins = test_ld_ind_mbuf0_prog,
+			.nb_ins = RTE_DIM(test_ld_ind_mbuf0_prog),
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
diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
index 099822e9f1..5b3b80cb86 100644
--- a/lib/bpf/bpf_jit_arm64.c
+++ b/lib/bpf/bpf_jit_arm64.c
@@ -8,6 +8,7 @@
 
 #include <rte_common.h>
 #include <rte_byteorder.h>
+#include <rte_mbuf.h>
 
 #include "bpf_impl.h"
 
@@ -1123,6 +1124,75 @@ emit_branch(struct a64_jit_ctx *ctx, uint8_t op, uint32_t i, int16_t off)
 	emit_b_cond(ctx, ebpf_to_a64_cond(op), jump_offset_get(ctx, i, off));
 }
 
+/*
+ * Emit code for BPF_LD | BPF_ABS/IND: load from packet.
+ * Implements both a fast path, which computes the offset and read directly
+ * and a slow path, which calls __rte_pktmbuf_read(mbuf, off, len, buf)
+ * when the data is not in the first segment.
+ */
+static void
+emit_ld_mbuf(struct a64_jit_ctx *ctx, uint32_t op, uint8_t tmp1, uint8_t tmp2,
+	uint8_t src, int32_t imm)
+{
+	uint8_t r0 = ebpf_to_a64_reg(ctx, EBPF_REG_0);
+	uint8_t r6 = ebpf_to_a64_reg(ctx, EBPF_REG_6);
+	uint32_t mode = BPF_MODE(op);
+	uint32_t opsz = BPF_SIZE(op);
+	uint32_t sz = bpf_size(opsz);
+
+	/* r0 = mbuf (R6) */
+	emit_mov_64(ctx, A64_R(0), r6);
+
+	/* r1 = off: for ABS use imm, for IND use src + imm */
+	if (mode == BPF_ABS) {
+		emit_mov_imm(ctx, 0, A64_R(1), imm);
+	} else {
+		emit_mov_imm(ctx, 0, tmp2, imm);
+		emit_add(ctx, 0, tmp2, src);
+		emit_mov_64(ctx, A64_R(1), tmp2);
+	}
+
+	/* r2 = len, 1/2/4 bytes */
+	emit_mov_imm32(ctx, 0, A64_R(2), sz);
+	/* r3 = buf (SP) */
+	emit_mov_64(ctx, A64_R(3), A64_SP);
+
+	/* tmp1 = mbuf->data_len */
+	emit_mov_imm(ctx, 1, tmp1, offsetof(struct rte_mbuf, data_len));
+	emit_ldr(ctx, BPF_W, tmp1, r6, tmp1);
+
+	/* tmp2 = off + sz */
+	emit_add_imm_64(ctx, tmp2, A64_R(1), sz);
+	/* if off+sz > data_len, jump to slow path */
+	emit_cmp(ctx, 1, tmp2, tmp1);
+	emit_b_cond(ctx, A64_HI, 8);
+
+	/* Fast path, read directly, pointer to the data will be in A64_R(0) */
+	/* A64_R(0) = mbuf->buf_addr */
+	emit_mov_imm(ctx, 1, tmp1, offsetof(struct rte_mbuf, buf_addr));
+	emit_ldr(ctx, EBPF_DW, A64_R(0), r6, tmp1);
+	/* tmp2 = * mbuf->data_off */
+	emit_mov_imm(ctx, 1, tmp2, offsetof(struct rte_mbuf, data_off));
+	emit_ldr(ctx, BPF_H, tmp2, r6, tmp2);
+
+	/* A64_R(0) += data_off + off */
+	emit_add(ctx, 1, A64_R(0), tmp2);
+	emit_add(ctx, 1, A64_R(0), A64_R(1));
+
+	/* End of Fast Path, skip slow path */
+	emit_b(ctx, 4);
+
+	/* slow path, call __rte_pktmbuf_read */
+	emit_call(ctx, tmp1, __rte_pktmbuf_read);
+	/* check return value of __rte_pktmbuf_read */
+	emit_return_zero_if_src_zero(ctx, 1, A64_R(0));
+
+	/* A64_R(0) points to the data, load 1/2/4 bytes into r0*/
+	emit_ldr(ctx, opsz, r0, A64_R(0), A64_ZR);
+	if (sz != sizeof(uint8_t))
+		emit_be(ctx, r0, sz * CHAR_BIT);
+}
+
 static void
 check_program_has_call(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
 {
@@ -1137,6 +1207,13 @@ check_program_has_call(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
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
@@ -1338,6 +1415,15 @@ emit(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
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

