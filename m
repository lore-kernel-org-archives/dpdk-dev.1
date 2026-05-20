Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7DB7CD4F3C
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 12:50:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B4D7040B91;
	Wed, 20 May 2026 14:50:05 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 9F82F40674
 for <dev@dpdk.org>; Wed, 20 May 2026 14:49:56 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gLBF82F1RzJ46Bp
 for <dev@dpdk.org>; Wed, 20 May 2026 20:49:16 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 6FCD54058B
 for <dev@dpdk.org>; Wed, 20 May 2026 20:49:56 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 May 2026 14:49:56 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>
Subject: [PATCH v4 11/11] test/bpf: add tests for error handling contracts
Date: Wed, 20 May 2026 13:49:20 +0100
Message-ID: <20260520124922.42445-12-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260520124922.42445-1-marat.khalili@huawei.com>
References: <20260518084912.57006-1-marat.khalili@huawei.com>
 <20260520124922.42445-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500008.china.huawei.com (7.182.19.65) To
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

Verify NULL parameter rejection in load APIs, graceful failure on
argument/flag mismatch in burst execution APIs, and safe return of the
libpcap stub.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 app/test/test_bpf.c | 128 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 127 insertions(+), 1 deletion(-)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 026ba18b754a..6422bae6fe5f 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -3514,6 +3514,121 @@ run_test(const struct bpf_test *tst)
 
 }
 
+/* Test all eBPF load APIs with prm set to NULL. */
+static int
+test_bpf_load_null(void)
+{
+	struct rte_bpf *bpf;
+	int saved_errno;
+
+	rte_errno = 0;
+	bpf = rte_bpf_load(NULL);
+	saved_errno = rte_errno;
+	rte_bpf_destroy(bpf);
+	RTE_TEST_ASSERT_NULL(bpf, "rte_bpf_load(NULL) did not return NULL\n");
+	RTE_TEST_ASSERT_EQUAL(saved_errno, EINVAL,
+		"rte_bpf_load(NULL) did not set rte_errno to EINVAL\n");
+
+	rte_errno = 0;
+	bpf = rte_bpf_elf_load(NULL, "a", "b");
+	saved_errno = rte_errno;
+	rte_bpf_destroy(bpf);
+	RTE_TEST_ASSERT_NULL(bpf, "rte_bpf_elf_load(NULL, \"a\", \"b\") did not return NULL\n");
+	RTE_TEST_ASSERT_EQUAL(saved_errno, EINVAL,
+		"rte_bpf_elf_load(NULL, \"a\", \"b\") did not set rte_errno to EINVAL\n");
+
+	rte_errno = 0;
+	bpf = rte_bpf_load_ex(NULL);
+	saved_errno = rte_errno;
+	rte_bpf_destroy(bpf);
+	RTE_TEST_ASSERT_NULL(bpf, "rte_bpf_load_ex(NULL) did not return NULL\n");
+	RTE_TEST_ASSERT_EQUAL(saved_errno, EINVAL,
+		"rte_bpf_load_ex(NULL) did not set rte_errno to EINVAL\n");
+
+	return 0;
+}
+REGISTER_FAST_TEST(bpf_load_null_autotest, NOHUGE_OK, ASAN_OK, test_bpf_load_null);
+
+/* Test calling wrong API for execution of a multi-argument eBPF program. */
+static int
+test_bpf_exec_wrong_nb_prog_arg(void)
+{
+	static const struct ebpf_insn ins[] = {
+		{ .code = (EBPF_ALU64 | EBPF_MOV | BPF_K), .dst_reg = EBPF_REG_0, .imm = 0 },
+		{ .code = (BPF_JMP | EBPF_EXIT), }
+	};
+	static const struct rte_bpf_prm_ex prm = {
+		.sz = sizeof(struct rte_bpf_prm_ex),
+		.origin = RTE_BPF_ORIGIN_RAW,
+		.raw.ins = ins,
+		.raw.nb_ins = RTE_DIM(ins),
+		.prog_arg = {
+			{ .type = RTE_BPF_ARG_RAW, .size = sizeof(uint64_t) },
+			{ .type = RTE_BPF_ARG_RAW, .size = sizeof(uint64_t) },
+		},
+		.nb_prog_arg = 2, /* Intentionally mismatched: expects 2, burst gives 1 */
+	};
+
+	struct rte_bpf *bpf;
+	uint64_t rc[1];
+	void *ctx[1] = {NULL};
+	uint32_t result;
+	int saved_errno;
+
+	bpf = rte_bpf_load_ex(&prm);
+	RTE_TEST_ASSERT_NOT_NULL(bpf, "rte_bpf_load_ex failed\n");
+
+	rte_errno = 0;
+	result = rte_bpf_exec_burst(bpf, ctx, rc, 1);
+	saved_errno = rte_errno;
+	rte_bpf_destroy(bpf);
+	RTE_TEST_ASSERT_EQUAL(result, 0, "rte_bpf_exec_burst did not return 0\n");
+	RTE_TEST_ASSERT_EQUAL(saved_errno, EINVAL,
+		"rte_bpf_exec_burst did not set rte_errno to EINVAL\n");
+
+	return 0;
+}
+REGISTER_FAST_TEST(bpf_exec_wrong_nb_prog_arg_autotest, NOHUGE_OK, ASAN_OK,
+		test_bpf_exec_wrong_nb_prog_arg);
+
+/* Test passing unsupported flags when executing an eBPF program. */
+static int
+test_bpf_exec_wrong_flags(void)
+{
+	static const struct ebpf_insn ins[] = {
+		{ .code = (EBPF_ALU64 | EBPF_MOV | BPF_K), .dst_reg = EBPF_REG_0, .imm = 0 },
+		{ .code = (BPF_JMP | EBPF_EXIT), }
+	};
+	static const struct rte_bpf_prm_ex prm = {
+		.sz = sizeof(struct rte_bpf_prm_ex),
+		.origin = RTE_BPF_ORIGIN_RAW,
+		.raw.ins = ins,
+		.raw.nb_ins = RTE_DIM(ins),
+		.prog_arg = { { .type = RTE_BPF_ARG_RAW, .size = sizeof(uint64_t) } },
+		.nb_prog_arg = 1,
+	};
+
+	struct rte_bpf *bpf;
+	uint64_t rc[1];
+	struct rte_bpf_prog_ctx ctx_ex[1] = {};
+	uint32_t result;
+	int saved_errno;
+
+	bpf = rte_bpf_load_ex(&prm);
+	RTE_TEST_ASSERT_NOT_NULL(bpf, "rte_bpf_load_ex failed\n");
+
+	rte_errno = 0;
+	result = rte_bpf_exec_burst_ex(bpf, ctx_ex, rc, 1, UINT64_MAX);
+	saved_errno = rte_errno;
+	rte_bpf_destroy(bpf);
+	RTE_TEST_ASSERT_EQUAL(result, 0, "rte_bpf_exec_burst_ex did not return 0\n");
+	RTE_TEST_ASSERT_EQUAL(saved_errno, EINVAL,
+		"rte_bpf_exec_burst_ex did not set rte_errno to EINVAL\n");
+
+	return 0;
+}
+REGISTER_FAST_TEST(bpf_exec_wrong_flags_autotest, NOHUGE_OK, ASAN_OK, test_bpf_exec_wrong_flags);
+
 static int
 test_bpf(void)
 {
@@ -4444,7 +4559,18 @@ REGISTER_FAST_TEST(bpf_elf_autotest, NOHUGE_OK, ASAN_OK, test_bpf_elf);
 static int
 test_bpf_convert(void)
 {
-	printf("BPF convert RTE_HAS_LIBPCAP is undefined, skipping test\n");
+	int dummy = 0;
+	struct rte_bpf_prm *prm;
+
+	prm = rte_bpf_convert(NULL);
+	rte_free(prm);
+	RTE_TEST_ASSERT_NULL(prm, "rte_bpf_convert(NULL) without libpcap did not return NULL\n");
+
+	prm = rte_bpf_convert((const struct bpf_program *)&dummy);
+	rte_free(prm);
+	RTE_TEST_ASSERT_NULL(prm, "rte_bpf_convert(&dummy) without libpcap did not return NULL\n");
+
+	printf("BPF convert RTE_HAS_LIBPCAP is undefined, skipping full test\n");
 	return TEST_SKIPPED;
 }
 
-- 
2.43.0

