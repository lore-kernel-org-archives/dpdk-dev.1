Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E93D609D9
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Dec 2025 18:21:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 13B444060A;
	Tue, 16 Dec 2025 19:21:23 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id C6DBB4060F;
 Tue, 16 Dec 2025 19:21:21 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dW4xK3RJwzJ46CH;
 Wed, 17 Dec 2025 02:20:53 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 962AE40570;
 Wed, 17 Dec 2025 02:21:21 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 16 Dec 2025 19:21:21 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: <stephen@networkplumber.org>, <jerinjacobk@gmail.com>,
 <mb@smartsharesystems.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH v2 3/5] bpf: disallow empty program
Date: Tue, 16 Dec 2025 18:20:33 +0000
Message-ID: <20251216182036.77869-4-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251216182036.77869-1-marat.khalili@huawei.com>
References: <20251110153046.63518-1-marat.khalili@huawei.com>
 <20251216182036.77869-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema100005.china.huawei.com (7.182.19.229) To
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

Add tests for some simple cases:
* Program with no instructions;
* Program with only EXIT instruction but no return value set;
* Program with return value set but no EXIT instruction;
* Minimal valid program with return value set and an EXIT instruction.

Fix found bugs:
* a program with no instructions was accepted;
* a program with no EXIT instruction read outside the buffer.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 app/test/test_bpf.c    | 118 +++++++++++++++++++++++++++++++++++++++++
 lib/bpf/bpf_load.c     |   2 +-
 lib/bpf/bpf_validate.c |  20 +++++--
 3 files changed, 135 insertions(+), 5 deletions(-)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index b7c94ba1c7..6ecc49efff 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -34,6 +34,124 @@ test_bpf(void)
 #include <rte_ip.h>
 
 
+/* Tests of most simple BPF programs (no instructions, one instruction etc.) */
+
+/*
+ * Try to load a simple bpf program from the instructions array.
+ *
+ * When `expected_errno` is zero, expect it to load successfully.
+ * When `expected_errno` is non-zero, expect it to fail with this `rte_errno`.
+ *
+ * @param nb_ins
+ *   Number of instructions in the `ins` array.
+ * @param ins
+ *   BPF instructions array.
+ * @param expected_errno
+ *   Expected result.
+ * @return
+ *   TEST_SUCCESS on success, error code on failure.
+ */
+static int
+bpf_load_test(uint32_t nb_ins, const struct ebpf_insn *ins, int expected_errno)
+{
+	const struct rte_bpf_prm prm = {
+		.ins = ins,
+		.nb_ins = nb_ins,
+		.prog_arg = {
+			.type = RTE_BPF_ARG_RAW,
+			.size = sizeof(uint64_t),
+		},
+	};
+
+	struct rte_bpf *const bpf = rte_bpf_load(&prm);
+	const int actual_errno = rte_errno;
+	rte_bpf_destroy(bpf);
+
+	if (expected_errno != 0) {
+		RTE_TEST_ASSERT_EQUAL(bpf, NULL,
+			"expect rte_bpf_load() == NULL");
+		RTE_TEST_ASSERT_EQUAL(actual_errno, expected_errno,
+			"expect rte_errno == %d, found %d",
+			expected_errno, actual_errno);
+	} else
+		RTE_TEST_ASSERT_NOT_EQUAL(bpf, NULL,
+			"expect rte_bpf_load() != NULL");
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Try and load completely empty BPF program.
+ * Should fail because there is no EXIT (and also return value is undefined).
+ */
+static int
+test_no_instructions(void)
+{
+	static const struct ebpf_insn ins[] = {};
+	return bpf_load_test(RTE_DIM(ins), ins, EINVAL);
+}
+
+REGISTER_FAST_TEST(bpf_no_instructions_autotest, true, true, test_no_instructions);
+
+/*
+ * Try and load a BPF program comprising single EXIT instruction.
+ * Should fail because the return value is undefined.
+ */
+static int
+test_exit_only(void)
+{
+	static const struct ebpf_insn ins[] = {
+		{
+			.code = (BPF_JMP | EBPF_EXIT),
+		},
+	};
+	return bpf_load_test(RTE_DIM(ins), ins, EINVAL);
+}
+
+REGISTER_FAST_TEST(bpf_exit_only_autotest, true, true, test_exit_only);
+
+/*
+ * Try and load a BPF program with no EXIT instruction.
+ * Should fail because of this.
+ */
+static int
+test_no_exit(void)
+{
+	static const struct ebpf_insn ins[] = {
+		{
+			/* Set return value to the program argument. */
+			.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
+			.src_reg = EBPF_REG_1,
+			.dst_reg = EBPF_REG_0,
+		},
+	};
+	return bpf_load_test(RTE_DIM(ins), ins, EINVAL);
+}
+
+REGISTER_FAST_TEST(bpf_no_exit_autotest, true, true, test_no_exit);
+
+/*
+ * Try and load smallest possible valid BPF program.
+ */
+static int
+test_minimal_working(void)
+{
+	static const struct ebpf_insn ins[] = {
+		{
+			/* Set return value to the program argument. */
+			.code = (EBPF_ALU64 | EBPF_MOV | BPF_X),
+			.src_reg = EBPF_REG_1,
+			.dst_reg = EBPF_REG_0,
+		},
+		{
+			.code = (BPF_JMP | EBPF_EXIT),
+		},
+	};
+	return bpf_load_test(RTE_DIM(ins), ins, 0);
+}
+
+REGISTER_FAST_TEST(bpf_minimal_working_autotest, true, true, test_minimal_working);
+
 /*
  * Basic functional tests for librte_bpf.
  * The main procedure - load eBPF program, execute it and
diff --git a/lib/bpf/bpf_load.c b/lib/bpf/bpf_load.c
index 556e613762..6983c026af 100644
--- a/lib/bpf/bpf_load.c
+++ b/lib/bpf/bpf_load.c
@@ -88,7 +88,7 @@ rte_bpf_load(const struct rte_bpf_prm *prm)
 	int32_t rc;
 	uint32_t i;
 
-	if (prm == NULL || prm->ins == NULL ||
+	if (prm == NULL || prm->ins == NULL || prm->nb_ins == 0 ||
 			(prm->nb_xsym != 0 && prm->xsym == NULL)) {
 		rte_errno = EINVAL;
 		return NULL;
diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index 4f47d6dc7b..23444b3eaa 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -1827,7 +1827,7 @@ add_edge(struct bpf_verifier *bvf, struct inst_node *node, uint32_t nidx)
 {
 	uint32_t ne;
 
-	if (nidx > bvf->prm->nb_ins) {
+	if (nidx >= bvf->prm->nb_ins) {
 		RTE_BPF_LOG_LINE(ERR,
 			"%s: program boundary violation at pc: %u, next pc: %u",
 			__func__, get_node_idx(bvf, node), nidx);
@@ -1886,14 +1886,20 @@ get_prev_node(struct bpf_verifier *bvf, struct inst_node *node)
  * Control Flow Graph (CFG).
  * Information collected at this path would be used later
  * to determine is there any loops, and/or unreachable instructions.
+ * PREREQUISITE: there is at least one node.
  */
 static void
 dfs(struct bpf_verifier *bvf)
 {
 	struct inst_node *next, *node;
 
-	node = bvf->in;
-	while (node != NULL) {
+	RTE_ASSERT(bvf->nb_nodes != 0);
+	/*
+	 * Since there is at least one node, node with index 0 always exists;
+	 * it is our program entry point.
+	 */
+	node = &bvf->in[0];
+	do {
 
 		if (node->colour == WHITE)
 			set_node_colour(bvf, node, GREY);
@@ -1923,7 +1929,7 @@ dfs(struct bpf_verifier *bvf)
 			}
 		} else
 			node = NULL;
-	}
+	} while (node != NULL);
 }
 
 /*
@@ -2062,6 +2068,12 @@ validate(struct bpf_verifier *bvf)
 	if (rc != 0)
 		return rc;
 
+	if (bvf->nb_nodes == 0) {
+		RTE_BPF_LOG_LINE(ERR, "%s(%p) the program is empty",
+			__func__, bvf);
+		return -EINVAL;
+	}
+
 	dfs(bvf);
 
 	RTE_LOG(DEBUG, BPF, "%s(%p) stats:\n"
-- 
2.43.0

