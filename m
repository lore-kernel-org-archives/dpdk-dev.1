Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78624CD342C
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 17:22:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5100E40285;
	Wed,  6 May 2026 19:22:50 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 9345940278
 for <dev@dpdk.org>; Wed,  6 May 2026 19:22:49 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.83])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g9hyv2QsyzJ46DS;
 Thu,  7 May 2026 01:22:31 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id BFFB540569;
 Thu,  7 May 2026 01:22:48 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 19:22:48 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>
CC: <dev@dpdk.org>
Subject: [PATCH 01/10] bpf: make logging prefixes more consistent
Date: Wed, 6 May 2026 18:21:58 +0100
Message-ID: <20260506172209.6805-2-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506172209.6805-1-marat.khalili@huawei.com>
References: <20260506172209.6805-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapema500001.china.huawei.com (7.182.19.243) To
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

Logging in lib/bpf is inconsistent: some places use `%s()`, other just
`%s` for `__func__`.

Introduce new macro for logging prefixed with function name and use it
everywhere function name without arguments is prefixed to the log line.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/bpf/bpf_convert.c   | 18 +++++++++---------
 lib/bpf/bpf_impl.h      |  3 +++
 lib/bpf/bpf_jit_arm64.c |  4 ++--
 lib/bpf/bpf_load.c      |  2 +-
 lib/bpf/bpf_load_elf.c  |  2 +-
 lib/bpf/bpf_stub.c      |  6 ++----
 lib/bpf/bpf_validate.c  | 25 ++++++++++++-------------
 7 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/lib/bpf/bpf_convert.c b/lib/bpf/bpf_convert.c
index 86e703299d05..953ca80670c4 100644
--- a/lib/bpf/bpf_convert.c
+++ b/lib/bpf/bpf_convert.c
@@ -247,8 +247,8 @@ static int bpf_convert_filter(const struct bpf_insn *prog, size_t len,
 	uint8_t bpf_src;
 
 	if (len > BPF_MAXINSNS) {
-		RTE_BPF_LOG_LINE(ERR, "%s: cBPF program too long (%zu insns)",
-			    __func__, len);
+		RTE_BPF_LOG_FUNC_LINE(ERR, "cBPF program too long (%zu insns)",
+			    len);
 		return -EINVAL;
 	}
 
@@ -483,8 +483,8 @@ static int bpf_convert_filter(const struct bpf_insn *prog, size_t len,
 
 			/* Unknown instruction. */
 		default:
-			RTE_BPF_LOG_LINE(ERR, "%s: Unknown instruction!: %#x",
-				    __func__, fp->code);
+			RTE_BPF_LOG_FUNC_LINE(ERR, "Unknown instruction!: %#x",
+				    fp->code);
 			goto err;
 		}
 
@@ -528,7 +528,7 @@ rte_bpf_convert(const struct bpf_program *prog)
 	int ret;
 
 	if (prog == NULL) {
-		RTE_BPF_LOG_LINE(ERR, "%s: NULL program", __func__);
+		RTE_BPF_LOG_FUNC_LINE(ERR, "NULL program");
 		rte_errno = EINVAL;
 		return NULL;
 	}
@@ -536,13 +536,13 @@ rte_bpf_convert(const struct bpf_program *prog)
 	/* 1st pass: calculate the eBPF program length */
 	ret = bpf_convert_filter(prog->bf_insns, prog->bf_len, NULL, &ebpf_len);
 	if (ret < 0) {
-		RTE_BPF_LOG_LINE(ERR, "%s: cannot get eBPF length", __func__);
+		RTE_BPF_LOG_FUNC_LINE(ERR, "cannot get eBPF length");
 		rte_errno = -ret;
 		return NULL;
 	}
 
-	RTE_BPF_LOG_LINE(DEBUG, "%s: prog len cBPF=%u -> eBPF=%u",
-		    __func__, prog->bf_len, ebpf_len);
+	RTE_BPF_LOG_FUNC_LINE(DEBUG, "prog len cBPF=%u -> eBPF=%u",
+		    prog->bf_len, ebpf_len);
 
 	prm = rte_zmalloc("bpf_filter",
 			  sizeof(*prm) + ebpf_len * sizeof(*ebpf), 0);
@@ -557,7 +557,7 @@ rte_bpf_convert(const struct bpf_program *prog)
 	/* 2nd pass: remap cBPF to eBPF instructions  */
 	ret = bpf_convert_filter(prog->bf_insns, prog->bf_len, ebpf, &ebpf_len);
 	if (ret < 0) {
-		RTE_BPF_LOG_LINE(ERR, "%s: cannot convert cBPF to eBPF", __func__);
+		RTE_BPF_LOG_FUNC_LINE(ERR, "cannot convert cBPF to eBPF");
 		rte_free(prm);
 		rte_errno = -ret;
 		return NULL;
diff --git a/lib/bpf/bpf_impl.h b/lib/bpf/bpf_impl.h
index f5fa22098489..fb5ec3c4d65f 100644
--- a/lib/bpf/bpf_impl.h
+++ b/lib/bpf/bpf_impl.h
@@ -32,6 +32,9 @@ extern int rte_bpf_logtype;
 #define RTE_BPF_LOG_LINE(lvl, ...) \
 	RTE_LOG_LINE(lvl, BPF, __VA_ARGS__)
 
+#define RTE_BPF_LOG_FUNC_LINE(lvl, fmt, ...) \
+	RTE_LOG_LINE(lvl, BPF, "%s(): " fmt, __func__, ##__VA_ARGS__)
+
 static inline size_t
 bpf_size(uint32_t bpf_op_sz)
 {
diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
index a04ef33a9c88..4bbb97da1b89 100644
--- a/lib/bpf/bpf_jit_arm64.c
+++ b/lib/bpf/bpf_jit_arm64.c
@@ -98,8 +98,8 @@ check_invalid_args(struct a64_jit_ctx *ctx, uint32_t limit)
 
 	for (idx = 0; idx < limit; idx++) {
 		if (rte_le_to_cpu_32(ctx->ins[idx]) == A64_INVALID_OP_CODE) {
-			RTE_BPF_LOG_LINE(ERR,
-				"%s: invalid opcode at %u;", __func__, idx);
+			RTE_BPF_LOG_FUNC_LINE(ERR,
+				"invalid opcode at %u;", idx);
 			return -EINVAL;
 		}
 	}
diff --git a/lib/bpf/bpf_load.c b/lib/bpf/bpf_load.c
index 6983c026af0e..b8a0426fe2ed 100644
--- a/lib/bpf/bpf_load.c
+++ b/lib/bpf/bpf_load.c
@@ -100,7 +100,7 @@ rte_bpf_load(const struct rte_bpf_prm *prm)
 
 	if (rc != 0) {
 		rte_errno = -rc;
-		RTE_BPF_LOG_LINE(ERR, "%s: %d-th xsym is invalid", __func__, i);
+		RTE_BPF_LOG_FUNC_LINE(ERR, "%d-th xsym is invalid", i);
 		return NULL;
 	}
 
diff --git a/lib/bpf/bpf_load_elf.c b/lib/bpf/bpf_load_elf.c
index 1d30ba17e25d..2390823cbf30 100644
--- a/lib/bpf/bpf_load_elf.c
+++ b/lib/bpf/bpf_load_elf.c
@@ -122,7 +122,7 @@ check_elf_header(const Elf64_Ehdr *eh)
 		err = "unexpected machine type";
 
 	if (err != NULL) {
-		RTE_BPF_LOG_LINE(ERR, "%s(): %s", __func__, err);
+		RTE_BPF_LOG_FUNC_LINE(ERR, "%s", err);
 		return -EINVAL;
 	}
 
diff --git a/lib/bpf/bpf_stub.c b/lib/bpf/bpf_stub.c
index dea0d703ca27..e06e820d8327 100644
--- a/lib/bpf/bpf_stub.c
+++ b/lib/bpf/bpf_stub.c
@@ -21,8 +21,7 @@ rte_bpf_elf_load(const struct rte_bpf_prm *prm, const char *fname,
 		return NULL;
 	}
 
-	RTE_BPF_LOG_LINE(ERR, "%s() is not supported, rebuild with libelf installed",
-		__func__);
+	RTE_BPF_LOG_FUNC_LINE(ERR, "not supported, rebuild with libelf installed");
 	rte_errno = ENOTSUP;
 	return NULL;
 }
@@ -38,8 +37,7 @@ rte_bpf_convert(const struct bpf_program *prog)
 		return NULL;
 	}
 
-	RTE_BPF_LOG_LINE(ERR, "%s() is not supported, rebuild with libpcap installed",
-		__func__);
+	RTE_BPF_LOG_FUNC_LINE(ERR, "not supported, rebuild with libpcap installed");
 	rte_errno = ENOTSUP;
 	return NULL;
 }
diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index e8dbec282779..a7f4f576c9d6 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -1838,16 +1838,16 @@ add_edge(struct bpf_verifier *bvf, struct inst_node *node, uint32_t nidx)
 	uint32_t ne;
 
 	if (nidx >= bvf->prm->nb_ins) {
-		RTE_BPF_LOG_LINE(ERR,
-			"%s: program boundary violation at pc: %u, next pc: %u",
-			__func__, get_node_idx(bvf, node), nidx);
+		RTE_BPF_LOG_FUNC_LINE(ERR,
+			"program boundary violation at pc: %u, next pc: %u",
+			get_node_idx(bvf, node), nidx);
 		return -EINVAL;
 	}
 
 	ne = node->nb_edge;
 	if (ne >= RTE_DIM(node->edge_dest)) {
-		RTE_BPF_LOG_LINE(ERR, "%s: internal error at pc: %u",
-			__func__, get_node_idx(bvf, node));
+		RTE_BPF_LOG_FUNC_LINE(ERR, "internal error at pc: %u",
+			get_node_idx(bvf, node));
 		return -EINVAL;
 	}
 
@@ -2005,8 +2005,7 @@ validate(struct bpf_verifier *bvf)
 
 		err = check_syntax(ins);
 		if (err != 0) {
-			RTE_BPF_LOG_LINE(ERR, "%s: %s at pc: %u",
-				__func__, err, i);
+			RTE_BPF_LOG_FUNC_LINE(ERR, "%s at pc: %u", err, i);
 			rc |= -EINVAL;
 		}
 
@@ -2230,9 +2229,9 @@ save_cur_eval_state(struct bpf_verifier *bvf, struct inst_node *node)
 	/* get new eval_state for this node */
 	st = pull_eval_state(&bvf->evst_sr_pool);
 	if (st == NULL) {
-		RTE_BPF_LOG_LINE(ERR,
-			"%s: internal error (out of space) at pc: %u",
-			__func__, get_node_idx(bvf, node));
+		RTE_BPF_LOG_FUNC_LINE(ERR,
+			"internal error (out of space) at pc: %u",
+			get_node_idx(bvf, node));
 		return -ENOMEM;
 	}
 
@@ -2462,8 +2461,8 @@ evaluate(struct bpf_verifier *bvf)
 				err = ins_chk[op].eval(bvf, ins + idx);
 				stats.nb_eval++;
 				if (err != NULL) {
-					RTE_BPF_LOG_LINE(ERR, "%s: %s at pc: %u",
-						__func__, err, idx);
+					RTE_BPF_LOG_FUNC_LINE(ERR,
+						"%s at pc: %u", err, idx);
 					rc = -EINVAL;
 				}
 			}
@@ -2533,7 +2532,7 @@ __rte_bpf_validate(struct rte_bpf *bpf)
 			bpf->prm.prog_arg.type != RTE_BPF_ARG_PTR &&
 			(sizeof(uint64_t) != sizeof(uintptr_t) ||
 			bpf->prm.prog_arg.type != RTE_BPF_ARG_PTR_MBUF)) {
-		RTE_BPF_LOG_LINE(ERR, "%s: unsupported argument type", __func__);
+		RTE_BPF_LOG_FUNC_LINE(ERR, "unsupported argument type");
 		return -ENOTSUP;
 	}
 
-- 
2.43.0

