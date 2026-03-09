Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACF37FCC9D7
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 07:42:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 837E5402B8;
	Tue, 10 Mar 2026 08:42:40 +0100 (CET)
Received: from zg8tmtyylji0my4xnjeumjiw.icoremail.net
 (zg8tmtyylji0my4xnjeumjiw.icoremail.net [162.243.161.220])
 by mails.dpdk.org (Postfix) with ESMTP id 6C10240261
 for <dev@dpdk.org>; Mon,  9 Mar 2026 13:28:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=whu.edu.cn; s=dkim; h=Received:Received:From:To:Cc:Subject:
 Date:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding; bh=ji06/6GYtaLFhfi0mPo+EAGOVLFKyjbSoO
 kcrtcmpww=; b=hNcVPwDon+qFR5gLw8Ffqyzqows2fkzfmBXo3Vm372YZT05qXK
 jXwo1xqFf8H5YGm5LtEP/OkBH41F/UNj4xj0Wpjt+FDcaom1R1j0eximVWIFWlAi
 a0nuiZY5YnA8uAJZXw6OLjbR4JthMFMjUsNp78Xfd2BH2cXkQW+VlxhfA=
Received: from whu.edu.cn (unknown [10.1.14.9])
 by app1 (Coremail) with SMTP id Bg4BCgBHWDLwvK5pDigPAg--.42260S2;
 Mon, 09 Mar 2026 20:28:32 +0800 (CST)
Received: from localhost.localdomain (unknown [210.73.43.101])
 by mtasvr (Coremail) with SMTP id _____wB3GIjlvK5p8NQMAA--.6002S2;
 Mon, 09 Mar 2026 20:28:31 +0800 (CST)
From: P1erreCashon <2022302111412@whu.edu.cn>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 =?UTF-8?q?Stanis=C5=82aw=20Kardach?= <stanislaw.kardach@gmail.com>,
 Sun Yuechi <sunyuechi@iscas.ac.cn>
Cc: dev@dpdk.org, Tang ShiHao <2022302111412@whu.edu.cn>,
 gong-flying <gongxiaofei24@iscas.ac.cn>
Subject: [PATCH] acl: classify with RISC-V vector extension
Date: Mon,  9 Mar 2026 20:28:16 +0800
Message-ID: <20260309122818.661741-1-2022302111412@whu.edu.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: Bg4BCgBHWDLwvK5pDigPAg--.42260S2
Authentication-Results: app1; spf=neutral smtp.mail=2022302111412@whu. edu.cn;
X-Coremail-Antispam: 1UD129KBjvAXoWfJw13Jr43KryxAr4ftw18Zrb_yoW8JF4kGo
 Wfur4rZa18Wr17ZFn2vw4UJFy7XFWq9w4xZanYyrWF9a1xZF1jyF42qwn8ta1fXF1rtF1a
 vrZ7Xa1xJr42qr97n29KB7ZKAUJUUUU8529EdanIXcx71UUUUU7v73VFW2AGmfu7bjvjm3
 AaLaJ3UjIYCTnIWjp_UUUY87k0a2IF6w1UM7kC6x804xWl1xkIjI8I6I8E6xAIw20EY4v2
 0xvaj40_Wr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xvwVC0I7
 IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVWxJVW8Jr1l84ACjcxK
 6I8E87Iv67AKxVW0oVCq3wA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_GcCE3s1lnxkEFVAIw2
 0F6cxK64vIFxWle2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44I2
 7wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E74AGY7Cv6cx26r4xMcvjeVCFs4IE7xkEbV
 WUJVW8JwACjcxG0xvY0x0EwIxGrwCY02Avz4vE-syl42xK82IYc2Ij64vIr41l42xK82IY
 6x8ErcxFaVAv8VW8CwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r
 18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64vI
 r41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr
 1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0xvE
 x4A2jsIEc7CjxVAFwI0_Jr0_GrUvcSsGvfC2KfnxnUUI43ZEXa7IUUFoGJUUUUU==
X-CM-SenderInfo: qsqsjjyqsriiqursq4lkxovvfxof0/
X-Mailman-Approved-At: Tue, 10 Mar 2026 08:42:39 +0100
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

From: Tang ShiHao <2022302111412@whu.edu.cn>

Implement rte acl classify function for RISC-V architecture
using RISC-V Vector Extension instruction set
Verified with testacl and acl_autotest applications on riscv architecture.

Performance improvements measured with dpdk-test-acl:

- 100 rules / 100 traces: 57.3 → 48.6 cycles/pkt (~1.18x)
- 1k rules / 1k traces: 13.6 → 8.3 cycles/pkt (~1.64x)
- 10k rules / 1M traces: 36.6 → 27.7 cycles/pkt (~1.32x)

Throughput improvement up to ~64%.

This patch is co-developed with Gong Xiaofei.

Signed-off-by: gong-flying <gongxiaofei24@iscas.ac.cn>
Signed-off-by: Tang ShiHao <2022302111412@whu.edu.cn>
---
 app/test-acl/main.c   |   4 +
 lib/acl/acl.h         |   4 +
 lib/acl/acl_run_rvv.c |  19 ++++
 lib/acl/acl_run_rvv.h | 210 ++++++++++++++++++++++++++++++++++++++++++
 lib/acl/meson.build   |   4 +-
 lib/acl/rte_acl.c     |  43 +++++++++
 lib/acl/rte_acl.h     |   1 +
 7 files changed, 284 insertions(+), 1 deletion(-)
 create mode 100644 lib/acl/acl_run_rvv.c
 create mode 100644 lib/acl/acl_run_rvv.h

diff --git a/app/test-acl/main.c b/app/test-acl/main.c
index 3a791b3ccf..ad0bc89644 100644
--- a/app/test-acl/main.c
+++ b/app/test-acl/main.c
@@ -97,6 +97,10 @@ static const struct acl_alg acl_alg[] = {
 		.name = "avx512x32",
 		.alg = RTE_ACL_CLASSIFY_AVX512X32,
 	},
+	{
+		.name = "rvv",
+		.alg = RTE_ACL_CLASSIFY_RVV,
+	},
 };
 
 static struct {
diff --git a/lib/acl/acl.h b/lib/acl/acl.h
index 9c85a3d58a..af202a84ed 100644
--- a/lib/acl/acl.h
+++ b/lib/acl/acl.h
@@ -226,6 +226,10 @@ int
 rte_acl_classify_altivec(const struct rte_acl_ctx *ctx, const uint8_t **data,
 	uint32_t *results, uint32_t num, uint32_t categories);
 
+int
+rte_acl_classify_rvv(const struct rte_acl_ctx *ctx, const uint8_t **data,
+	uint32_t *results, uint32_t num, uint32_t categories);
+
 #ifdef __cplusplus
 }
 #endif /* __cplusplus */
diff --git a/lib/acl/acl_run_rvv.c b/lib/acl/acl_run_rvv.c
new file mode 100644
index 0000000000..2b53e28213
--- /dev/null
+++ b/lib/acl/acl_run_rvv.c
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2026 Institute of Software Chinese Academy of Sciences (ISCAS)
+ */
+
+#if defined(RTE_ARCH_RISCV) && defined(RTE_RISCV_FEATURE_V)
+
+#include "acl_run_rvv.h"
+
+int
+rte_acl_classify_rvv(const struct rte_acl_ctx *ctx, const uint8_t **data,
+		      uint32_t *results, uint32_t num, uint32_t categories)
+{
+	if (num >= 4)
+		return search_rvv_4(ctx, data, results, num, categories);
+	else
+		return rte_acl_classify_scalar(ctx, data, results, num, categories);
+}
+
+#endif
diff --git a/lib/acl/acl_run_rvv.h b/lib/acl/acl_run_rvv.h
new file mode 100644
index 0000000000..ed21ce2ba6
--- /dev/null
+++ b/lib/acl/acl_run_rvv.h
@@ -0,0 +1,210 @@
+#include <stdalign.h>
+
+#include "acl_run.h"
+
+#include <riscv_vector.h>
+
+
+static const uint8_t idx_const[16] = {
+	0, 0, 0, 0, 4, 4, 4, 4,
+	8, 8, 8, 8, 12, 12, 12, 12
+};
+
+/*
+ * Resolve priority for multiple results (scalar version).
+ * This consists comparing the priority of the current traversal with the
+ * running set of results for the packet.
+ * For each result, keep a running array of the result (rule number) and
+ * its priority for each category.
+ */
+static inline void
+resolve_priority_rvv(uint64_t transition, int n,
+						const struct rte_acl_ctx *ctx,
+						struct parms *parms,
+						const struct rte_acl_match_results *p,
+						uint32_t categories)
+{
+	uint32_t x;
+
+	for (x = 0; x < categories; x += RTE_ACL_RESULTS_MULTIPLIER) {
+
+		int32_t *saved_results  = (int32_t *)&parms[n].cmplt->results[x];
+		int32_t *saved_priority = (int32_t *)&parms[n].cmplt->priority[x];
+
+		const int32_t *cur_results  = (const int32_t *)&p[transition].results[x];
+		const int32_t *cur_priority = (const int32_t *)&p[transition].priority[x];
+
+		size_t vl = __riscv_vsetvl_e32m1(RTE_ACL_RESULTS_MULTIPLIER);
+
+		/* load current trie results / priority */
+		vint32m1_t v_results  = __riscv_vle32_v_i32m1(cur_results, vl);
+		vint32m1_t v_priority = __riscv_vle32_v_i32m1(cur_priority, vl);
+
+		if (parms[n].cmplt->count != ctx->num_tries) {
+
+			/* load running best */
+			vint32m1_t v_results1  = __riscv_vle32_v_i32m1(saved_results, vl);
+			vint32m1_t v_priority1 = __riscv_vle32_v_i32m1(saved_priority, vl);
+
+			/* selector = priority1 > priority */
+			vbool32_t mask = __riscv_vmsgt_vv_i32m1_b32(v_priority1, v_priority, vl);
+
+			/* results = mask ? results1 : results */
+			v_results  = __riscv_vmerge_vvm_i32m1(v_results, v_results1, mask, vl);
+			v_priority = __riscv_vmerge_vvm_i32m1(v_priority, v_priority1, mask, vl);
+		}
+
+		/* store back running best */
+		__riscv_vse32_v_i32m1(saved_results,  v_results,  vl);
+		__riscv_vse32_v_i32m1(saved_priority, v_priority, vl);
+	}
+}
+
+vuint32m1_t
+transition4_rvv(vuint32m1_t next_input,
+				const uint64_t *trans,
+				uint64_t transitions[4])
+{
+	size_t vl = 4;
+
+	vuint64m2_t vtr = __riscv_vle64_v_u64m2(transitions, vl);
+
+	vuint32m1_t lo = __riscv_vnsrl_wx_u32m1(vtr, 0, vl);
+	vuint32m1_t hi = __riscv_vnsrl_wx_u32m1(vtr, 32, vl);
+
+	vuint32m1_t addr =
+		__riscv_vxor_vv_u32m1(lo, __riscv_vand_vx_u32m1(lo, ~RTE_ACL_NODE_INDEX, vl), vl);
+
+	vuint32m1_t node_type =
+		__riscv_vand_vx_u32m1(lo, ~RTE_ACL_NODE_INDEX, vl);
+
+	vbool32_t m_dfa =
+		__riscv_vmseq_vx_u32m1_b32(node_type, 0, vl);
+
+	vuint32m1_t input =
+		__riscv_vand_vx_u32m1(next_input, 0xff, vl);
+
+	/* ---------------- DFA ---------------- */
+
+	vuint32m1_t grp =
+		__riscv_vsrl_vx_u32m1(input, 6, vl);
+
+	vuint32m1_t shift =
+		__riscv_vmul_vx_u32m1(grp, RTE_ACL_DFA_GR64_BIT, vl);
+
+	vuint32m1_t dfa_base =
+		__riscv_vsrl_vv_u32m1(hi, shift, vl);
+
+	vuint32m1_t dfa_x =
+		__riscv_vsub_vv_u32m1(input,
+			__riscv_vand_vx_u32m1(dfa_base, UINT8_MAX, vl),
+			vl);
+
+	/* ---------------- QRANGE ---------------- */
+	vuint8m1_t mask = __riscv_vle8_v_u8m1(idx_const, 16);
+
+	vuint8m1_t in =
+		__riscv_vrgather_vv_u8m1(
+			__riscv_vreinterpret_v_u32m1_u8m1(next_input),
+			mask,
+			16);
+
+	vint8m1_t in_s8 =
+		__riscv_vreinterpret_v_u8m1_i8m1(in);
+
+	vuint8m1_t ranges_u8 =
+		__riscv_vreinterpret_v_u32m1_u8m1(hi);
+
+	vint8m1_t ranges_s8 =
+		__riscv_vreinterpret_v_u8m1_i8m1(ranges_u8);
+
+	vbool8_t cmp =
+		__riscv_vmsgt_vv_i8m1_b8(in_s8, ranges_s8, 16);
+	int32_t q_1 = __riscv_vcpop_m_b8(cmp, 4);
+	int32_t q_2 = __riscv_vcpop_m_b8(cmp, 8);
+	int32_t q_3 = __riscv_vcpop_m_b8(cmp, 12);
+	int32_t q_4 = __riscv_vcpop_m_b8(cmp, 16);
+	uint32_t q_scalar[4] = {q_1, q_2 - q_1, q_3 - q_2, q_4 - q_3};
+	vuint32m1_t q_x = __riscv_vle32_v_u32m1(q_scalar, 4);
+
+
+	vuint32m1_t x =
+		__riscv_vmerge_vvm_u32m1(q_x, dfa_x, m_dfa, vl);
+
+	addr = __riscv_vadd_vv_u32m1(addr, x, vl);
+
+	vuint64m2_t addr64 =
+		__riscv_vwmulu_vx_u64m2(addr, sizeof(uint64_t), vl);
+	vuint64m2_t next =
+		__riscv_vloxei64_v_u64m2(trans, addr64, vl);
+
+	__riscv_vse64_v_u64m2(transitions, next, vl);
+
+	return __riscv_vsrl_vx_u32m1(next_input, 8, vl);
+}
+
+/*
+ * Check for any match in 4 transitions
+ */
+static __rte_always_inline uint32_t
+check_any_match_x4(uint64_t val[])
+{
+	return (val[0] | val[1] | val[2] | val[3]) & RTE_ACL_NODE_MATCH;
+}
+
+static __rte_always_inline void
+acl_match_check_x4(int slot, const struct rte_acl_ctx *ctx, struct parms *parms,
+			struct acl_flow_data *flows, uint64_t transitions[])
+{
+	while (check_any_match_x4(transitions)) {
+		transitions[0] = acl_match_check(transitions[0], slot, ctx,
+			parms, flows, resolve_priority_rvv);
+		transitions[1] = acl_match_check(transitions[1], slot + 1, ctx,
+			parms, flows, resolve_priority_rvv);
+		transitions[2] = acl_match_check(transitions[2], slot + 2, ctx,
+			parms, flows, resolve_priority_rvv);
+		transitions[3] = acl_match_check(transitions[3], slot + 3, ctx,
+			parms, flows, resolve_priority_rvv);
+	}
+}
+
+static inline int
+search_rvv_4(const struct rte_acl_ctx *ctx,
+			const uint8_t **data,
+			uint32_t *results,
+			int total_packets,
+			uint32_t categories)
+{
+	struct acl_flow_data flows;
+	uint64_t index_array[4];
+	struct completion cmplt[4];
+	struct parms parms[4];
+	vuint32m1_t input;
+
+	acl_set_flow(&flows, cmplt, RTE_DIM(cmplt), data,
+				results, total_packets,
+				categories, ctx->trans_table);
+
+	for (int i = 0; i < 4; i++)
+		index_array[i] =
+			acl_start_next_trie(&flows, parms, i, ctx);
+
+	acl_match_check_x4(0, ctx, parms, &flows, index_array);
+
+	while (flows.started > 0) {
+		input = __riscv_vmv_v_x_u32m1(GET_NEXT_4BYTES(parms, 0), 4);
+		input = __riscv_vslide1down_vx_u32m1(
+				input, GET_NEXT_4BYTES(parms, 1), 4);
+		input = __riscv_vslide1down_vx_u32m1(
+				input, GET_NEXT_4BYTES(parms, 2), 4);
+		input = __riscv_vslide1down_vx_u32m1(
+				input, GET_NEXT_4BYTES(parms, 3), 4);
+
+		input = transition4_rvv(input, flows.trans, index_array);
+		input = transition4_rvv(input, flows.trans, index_array);
+		input = transition4_rvv(input, flows.trans, index_array);
+		input = transition4_rvv(input, flows.trans, index_array);
+		acl_match_check_x4(0, ctx, parms, &flows, index_array);
+	}
+	return 0;
+}
diff --git a/lib/acl/meson.build b/lib/acl/meson.build
index 87e9f25f8e..2d2b8d46c6 100644
--- a/lib/acl/meson.build
+++ b/lib/acl/meson.build
@@ -25,4 +25,6 @@ elif dpdk_conf.has('RTE_ARCH_ARM')
     sources += files('acl_run_neon.c')
 elif dpdk_conf.has('RTE_ARCH_PPC_64')
     sources += files('acl_run_altivec.c')
-endif
+elif dpdk_conf.has('RTE_ARCH_RISCV')
+    sources += files('acl_run_rvv.c')
+endif
\ No newline at end of file
diff --git a/lib/acl/rte_acl.c b/lib/acl/rte_acl.c
index 3f2b194206..8fc54e8037 100644
--- a/lib/acl/rte_acl.c
+++ b/lib/acl/rte_acl.c
@@ -8,6 +8,10 @@
 #include <rte_acl.h>
 #include <rte_tailq.h>
 
+#if defined(RTE_ARCH_RISCV) && defined(RTE_RISCV_FEATURE_V)
+#include <riscv_vector.h>
+#endif
+
 #include "acl.h"
 #include "acl_log.h"
 
@@ -94,6 +98,18 @@ rte_acl_classify_altivec(__rte_unused const struct rte_acl_ctx *ctx,
 }
 #endif
 
+#ifndef RTE_ARCH_RISCV
+int
+rte_acl_classify_rvv(__rte_unused const struct rte_acl_ctx *ctx,
+	__rte_unused const uint8_t **data,
+	__rte_unused uint32_t *results,
+	__rte_unused uint32_t num,
+	__rte_unused uint32_t categories)
+{
+	return -ENOTSUP;
+}
+#endif
+
 static const rte_acl_classify_t classify_fns[] = {
 	[RTE_ACL_CLASSIFY_DEFAULT] = rte_acl_classify_scalar,
 	[RTE_ACL_CLASSIFY_SCALAR] = rte_acl_classify_scalar,
@@ -103,6 +119,7 @@ static const rte_acl_classify_t classify_fns[] = {
 	[RTE_ACL_CLASSIFY_ALTIVEC] = rte_acl_classify_altivec,
 	[RTE_ACL_CLASSIFY_AVX512X16] = rte_acl_classify_avx512x16,
 	[RTE_ACL_CLASSIFY_AVX512X32] = rte_acl_classify_avx512x32,
+	[RTE_ACL_CLASSIFY_RVV] = rte_acl_classify_rvv,
 };
 
 /*
@@ -202,6 +219,28 @@ acl_check_alg_x86(enum rte_acl_classify_alg alg)
 	return -EINVAL;
 }
 
+
+/*
+ * Helper function for acl_check_alg.
+ * Check support for RISCV specific classify methods.
+ */
+static int
+acl_check_alg_rvv(enum rte_acl_classify_alg alg)
+{
+	if (alg == RTE_ACL_CLASSIFY_RVV) {
+#if defined(RTE_RISCV_FEATURE_V)
+		if (__riscv_vsetvl_e32m1(RTE_ACL_RESULTS_MULTIPLIER) >=
+				RTE_ACL_RESULTS_MULTIPLIER &&
+				__riscv_vsetvl_e32m1(4) >= 4)
+			return 0;
+#endif
+		return -ENOTSUP;
+	}
+
+	return -EINVAL;
+}
+
+
 /*
  * Check if input alg is supported by given platform/binary.
  * Note that both conditions should be met:
@@ -221,6 +260,8 @@ acl_check_alg(enum rte_acl_classify_alg alg)
 	case RTE_ACL_CLASSIFY_AVX2:
 	case RTE_ACL_CLASSIFY_SSE:
 		return acl_check_alg_x86(alg);
+	case RTE_ACL_CLASSIFY_RVV:
+		return acl_check_alg_rvv(alg);
 	/* scalar method is supported on all platforms */
 	case RTE_ACL_CLASSIFY_SCALAR:
 		return 0;
@@ -249,6 +290,8 @@ acl_get_best_alg(void)
 		RTE_ACL_CLASSIFY_AVX512X16,
 		RTE_ACL_CLASSIFY_AVX2,
 		RTE_ACL_CLASSIFY_SSE,
+#elif defined(RTE_ARCH_RISCV) && defined(RTE_RISCV_FEATURE_V)
+		RTE_ACL_CLASSIFY_RVV,
 #endif
 		RTE_ACL_CLASSIFY_SCALAR,
 	};
diff --git a/lib/acl/rte_acl.h b/lib/acl/rte_acl.h
index 0db4600cbe..0e9d09511d 100644
--- a/lib/acl/rte_acl.h
+++ b/lib/acl/rte_acl.h
@@ -303,6 +303,7 @@ enum rte_acl_classify_alg {
 	RTE_ACL_CLASSIFY_ALTIVEC = 5,    /**< requires ALTIVEC support. */
 	RTE_ACL_CLASSIFY_AVX512X16 = 6,  /**< requires AVX512 support. */
 	RTE_ACL_CLASSIFY_AVX512X32 = 7,  /**< requires AVX512 support. */
+	RTE_ACL_CLASSIFY_RVV = 8,  /**< requires RVV support. */
 };
 
 /**
-- 
2.43.0

