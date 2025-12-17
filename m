Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521FED66B80
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Dec 2025 18:03:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D8624065D;
	Wed, 17 Dec 2025 19:03:19 +0100 (CET)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56])
 by mails.dpdk.org (Postfix) with ESMTP id C746B40669;
 Wed, 17 Dec 2025 19:03:17 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4dWhTz6LKQzJ4682;
 Thu, 18 Dec 2025 02:02:47 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id 9B02640086;
 Thu, 18 Dec 2025 02:03:17 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 17 Dec 2025 19:03:17 +0100
From: Marat Khalili <marat.khalili@huawei.com>
To: <stephen@networkplumber.org>, <jerinjacobk@gmail.com>,
 <mb@smartsharesystems.com>, Konstantin Ananyev
 <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH v3 5/6] bpf: make add/subtract one program validate
Date: Wed, 17 Dec 2025 18:01:38 +0000
Message-ID: <20251217180141.60227-6-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251217180141.60227-1-marat.khalili@huawei.com>
References: <20251216182036.77869-1-marat.khalili@huawei.com>
 <20251217180141.60227-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500006.china.huawei.com (7.182.19.102) To
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

Add tests loading simple BPF programs adding or subtracting one to its
argument and fix triggered signed integer overflow undefined behaviours:

    lib/bpf/bpf_validate.c:324:24: runtime error: signed integer
    overflow: 1 + 9223372036854775807 cannot be represented in type
    'long int'

    lib/bpf/bpf_validate.c:352:24: runtime error: signed integer
    overflow: -9223372036854775808 - 1 cannot be represented in type
    'long int'

As a minimal possible fix perform operation on unsigned integers where
overflow is well-defined, which was probably the original intent.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 app/test/test_bpf.c    | 56 ++++++++++++++++++++++++++++++++++++++++++
 lib/bpf/bpf_validate.c |  8 +++---
 2 files changed, 60 insertions(+), 4 deletions(-)

diff --git a/app/test/test_bpf.c b/app/test/test_bpf.c
index 6ecc49efff..c25f5a6f4d 100644
--- a/app/test/test_bpf.c
+++ b/app/test/test_bpf.c
@@ -152,6 +152,62 @@ test_minimal_working(void)
 
 REGISTER_FAST_TEST(bpf_minimal_working_autotest, true, true, test_minimal_working);
 
+/*
+ * Try and load valid BPF program adding one to the argument.
+ */
+static int
+test_add_one(void)
+{
+	static const struct ebpf_insn ins[] = {
+		{
+			/* Set return value to one. */
+			.code = (EBPF_ALU64 | EBPF_MOV | BPF_K),
+			.dst_reg = EBPF_REG_0,
+			.imm = 1,
+		},
+		{
+			/* Add program argument to the return value. */
+			.code = (EBPF_ALU64 | BPF_ADD | BPF_X),
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
+REGISTER_FAST_TEST(bpf_add_one_autotest, true, true, test_add_one);
+
+/*
+ * Try and load valid BPF program subtracting one from the argument.
+ */
+static int
+test_subtract_one(void)
+{
+	static const struct ebpf_insn ins[] = {
+		{
+			/* Subtract one from the program argument. */
+			.code = (EBPF_ALU64 | BPF_SUB | BPF_K),
+			.dst_reg = EBPF_REG_1,
+			.imm = 1,
+		},
+		{
+			/* Set return value to the result. */
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
+REGISTER_FAST_TEST(bpf_subtract_one_autotest, true, true, test_subtract_one);
+
 /*
  * Basic functional tests for librte_bpf.
  * The main procedure - load eBPF program, execute it and
diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index 23444b3eaa..47ad6fef0f 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -243,8 +243,8 @@ eval_add(struct bpf_reg_val *rd, const struct bpf_reg_val *rs, uint64_t msk)
 
 	rv.u.min = (rd->u.min + rs->u.min) & msk;
 	rv.u.max = (rd->u.max + rs->u.max) & msk;
-	rv.s.min = (rd->s.min + rs->s.min) & msk;
-	rv.s.max = (rd->s.max + rs->s.max) & msk;
+	rv.s.min = ((uint64_t)rd->s.min + (uint64_t)rs->s.min) & msk;
+	rv.s.max = ((uint64_t)rd->s.max + (uint64_t)rs->s.max) & msk;
 
 	/*
 	 * if at least one of the operands is not constant,
@@ -272,8 +272,8 @@ eval_sub(struct bpf_reg_val *rd, const struct bpf_reg_val *rs, uint64_t msk)
 
 	rv.u.min = (rd->u.min - rs->u.max) & msk;
 	rv.u.max = (rd->u.max - rs->u.min) & msk;
-	rv.s.min = (rd->s.min - rs->s.max) & msk;
-	rv.s.max = (rd->s.max - rs->s.min) & msk;
+	rv.s.min = ((uint64_t)rd->s.min - (uint64_t)rs->s.max) & msk;
+	rv.s.max = ((uint64_t)rd->s.max - (uint64_t)rs->s.min) & msk;
 
 	/*
 	 * if at least one of the operands is not constant,
-- 
2.43.0

