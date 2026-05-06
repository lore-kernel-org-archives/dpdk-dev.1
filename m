Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 206DDCD3439
	for <dpdk-dev@archiver.kernel.org>; Wed,  6 May 2026 17:23:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68F6F40676;
	Wed,  6 May 2026 19:22:52 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id D0AF740278
 for <dev@dpdk.org>; Wed,  6 May 2026 19:22:49 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4g9hyw1lqQzJ467m;
 Thu,  7 May 2026 01:22:32 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id A81964058D;
 Thu,  7 May 2026 01:22:49 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 6 May 2026 19:22:49 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>
CC: <dev@dpdk.org>
Subject: [PATCH 03/10] bpf: support up to 5 arguments
Date: Wed, 6 May 2026 18:22:00 +0100
Message-ID: <20260506172209.6805-4-marat.khalili@huawei.com>
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

When using rte_bpf_load_ex allow up to 5 arguments for a BPF program.
Particularly useful for call-backs and other internal functions.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/bpf/bpf.c           |  32 +++++++++--
 lib/bpf/bpf_exec.c      | 116 +++++++++++++++++++++++++++++++++++++++
 lib/bpf/bpf_impl.h      |   2 +-
 lib/bpf/bpf_jit_arm64.c |   2 +-
 lib/bpf/bpf_jit_x86.c   |   2 +-
 lib/bpf/bpf_load.c      |   6 ++-
 lib/bpf/bpf_validate.c  |  45 ++++++++++++----
 lib/bpf/rte_bpf.h       | 117 ++++++++++++++++++++++++++++++++++++++--
 8 files changed, 299 insertions(+), 23 deletions(-)

diff --git a/lib/bpf/bpf.c b/lib/bpf/bpf.c
index 5239b3e11e0e..67dededd9ae8 100644
--- a/lib/bpf/bpf.c
+++ b/lib/bpf/bpf.c
@@ -16,8 +16,8 @@ void
 rte_bpf_destroy(struct rte_bpf *bpf)
 {
 	if (bpf != NULL) {
-		if (bpf->jit.func != NULL)
-			munmap(bpf->jit.func, bpf->jit.sz);
+		if (bpf->jit.raw != NULL)
+			munmap(bpf->jit.raw, bpf->jit.sz);
 		munmap(bpf, bpf->sz);
 	}
 }
@@ -29,7 +29,33 @@ rte_bpf_get_jit(const struct rte_bpf *bpf, struct rte_bpf_jit *jit)
 	if (bpf == NULL || jit == NULL)
 		return -EINVAL;
 
-	jit[0] = bpf->jit;
+	if (bpf->prm.nb_prog_arg != 1) {
+		RTE_BPF_LOG_LINE(ERR,
+			"this program takes %d arguments, use rte_bpf_get_jit_ex",
+			bpf->prm.nb_prog_arg);
+		return -EINVAL;
+	}
+
+	*jit = (struct rte_bpf_jit) {
+		.func = bpf->jit.raw,
+		.sz = bpf->jit.sz,
+	};
+	return 0;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_get_jit_ex, 26.11)
+int
+rte_bpf_get_jit_ex(const struct rte_bpf *bpf, struct rte_bpf_jit_ex *jit)
+{
+	if (bpf == NULL || jit == NULL)
+		return -EINVAL;
+
+	if (bpf->jit.raw == NULL) {
+		RTE_BPF_LOG_LINE(ERR, "no JIT-compiled version");
+		return -ENOENT;
+	}
+
+	*jit = bpf->jit;
 	return 0;
 }
 
diff --git a/lib/bpf/bpf_exec.c b/lib/bpf/bpf_exec.c
index e4668ba10b64..d77c59991632 100644
--- a/lib/bpf/bpf_exec.c
+++ b/lib/bpf/bpf_exec.c
@@ -502,6 +502,10 @@ rte_bpf_exec_burst(const struct rte_bpf *bpf, void *ctx[], uint64_t rc[],
 	uint64_t reg[EBPF_REG_NUM];
 	uint64_t stack[MAX_BPF_STACK_SIZE / sizeof(uint64_t)];
 
+	if (bpf->prm.nb_prog_arg != 1)
+		/* Use rte_bpf_exec_burst_ex with this program. */
+		return -EINVAL;
+
 	for (i = 0; i != num; i++) {
 
 		reg[EBPF_REG_1] = (uintptr_t)ctx[i];
@@ -513,6 +517,107 @@ rte_bpf_exec_burst(const struct rte_bpf *bpf, void *ctx[], uint64_t rc[],
 	return i;
 }
 
+static uint32_t
+exec_vm_burst_ex(const struct rte_bpf *bpf, const struct rte_bpf_prog_ctx *ctx,
+	uint64_t rc[], uint32_t num)
+{
+	uint32_t i;
+	uint64_t reg[EBPF_REG_NUM];
+	uint64_t stack[MAX_BPF_STACK_SIZE / sizeof(uint64_t)];
+
+	for (i = 0; i != num; i++) {
+		const union rte_bpf_func_arg *const arg = ctx[i].arg;
+
+		switch (bpf->prm.nb_prog_arg) {
+		case 5:
+			reg[EBPF_REG_5] = arg[4].u64;
+			/* FALLTHROUGH */
+		case 4:
+			reg[EBPF_REG_4] = arg[3].u64;
+			/* FALLTHROUGH */
+		case 3:
+			reg[EBPF_REG_3] = arg[2].u64;
+			/* FALLTHROUGH */
+		case 2:
+			reg[EBPF_REG_2] = arg[1].u64;
+			/* FALLTHROUGH */
+		case 1:
+			reg[EBPF_REG_1] = arg[0].u64;
+			/* FALLTHROUGH */
+		case 0:
+			break;
+		}
+
+		reg[EBPF_REG_10] = (uintptr_t)(stack + RTE_DIM(stack));
+
+		rc[i] = bpf_exec(bpf, reg);
+	}
+
+	return i;
+}
+
+static uint32_t
+exec_jit_burst_ex(const struct rte_bpf *bpf, const struct rte_bpf_prog_ctx *ctx,
+	uint64_t rc[], uint32_t num)
+{
+	uint32_t i;
+	const struct rte_bpf_jit_ex jit = bpf->jit;
+
+	switch (bpf->prm.nb_prog_arg) {
+	case 0:
+		for (i = 0; i != num; i++)
+			rc[i] = jit.func0();
+		break;
+	case 1:
+		for (i = 0; i != num; i++) {
+			const union rte_bpf_func_arg *const arg = ctx[i].arg;
+			rc[i] = jit.func1(arg[0]);
+		}
+		break;
+	case 2:
+		for (i = 0; i != num; i++) {
+			const union rte_bpf_func_arg *const arg = ctx[i].arg;
+			rc[i] = jit.func2(arg[0], arg[1]);
+		}
+		break;
+	case 3:
+		for (i = 0; i != num; i++) {
+			const union rte_bpf_func_arg *const arg = ctx[i].arg;
+			rc[i] = jit.func3(arg[0], arg[1], arg[2]);
+		}
+		break;
+	case 4:
+		for (i = 0; i != num; i++) {
+			const union rte_bpf_func_arg *const arg = ctx[i].arg;
+			rc[i] = jit.func4(arg[0], arg[1], arg[2], arg[3]);
+		}
+		break;
+	case 5:
+		for (i = 0; i != num; i++) {
+			const union rte_bpf_func_arg *const arg = ctx[i].arg;
+			rc[i] = jit.func5(arg[0], arg[1], arg[2], arg[3], arg[4]);
+		}
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return i;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_exec_burst_ex, 26.11)
+uint32_t
+rte_bpf_exec_burst_ex(const struct rte_bpf *bpf, const struct rte_bpf_prog_ctx *ctx,
+	uint64_t rc[], uint32_t num, uint64_t flags)
+{
+	if ((flags & ~RTE_BPF_EXEC_FLAG_MASK) != 0)
+		return -EINVAL;
+
+	return (flags & RTE_BPF_EXEC_FLAG_JIT) != 0 ?
+		exec_jit_burst_ex(bpf, ctx, rc, num) :
+		exec_vm_burst_ex(bpf, ctx, rc, num);
+}
+
 RTE_EXPORT_SYMBOL(rte_bpf_exec)
 uint64_t
 rte_bpf_exec(const struct rte_bpf *bpf, void *ctx)
@@ -522,3 +627,14 @@ rte_bpf_exec(const struct rte_bpf *bpf, void *ctx)
 	rte_bpf_exec_burst(bpf, &ctx, &rc, 1);
 	return rc;
 }
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_exec_ex, 26.11)
+uint64_t
+rte_bpf_exec_ex(const struct rte_bpf *bpf, const struct rte_bpf_prog_ctx *ctx,
+		uint64_t flags)
+{
+	uint64_t rc;
+
+	rte_bpf_exec_burst_ex(bpf, ctx, &rc, 1, flags);
+	return rc;
+}
diff --git a/lib/bpf/bpf_impl.h b/lib/bpf/bpf_impl.h
index 1cee109bc98a..4a98b3373067 100644
--- a/lib/bpf/bpf_impl.h
+++ b/lib/bpf/bpf_impl.h
@@ -12,7 +12,7 @@
 
 struct rte_bpf {
 	struct rte_bpf_prm_ex prm;
-	struct rte_bpf_jit jit;
+	struct rte_bpf_jit_ex jit;
 	size_t sz;
 	uint32_t stack_sz;
 };
diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
index 9e5e142c13ba..ba7ae4d680c5 100644
--- a/lib/bpf/bpf_jit_arm64.c
+++ b/lib/bpf/bpf_jit_arm64.c
@@ -1471,7 +1471,7 @@ __rte_bpf_jit_arm64(struct rte_bpf *bpf)
 	/* Flush the icache */
 	__builtin___clear_cache((char *)ctx.ins, (char *)(ctx.ins + ctx.idx));
 
-	bpf->jit.func = (void *)ctx.ins;
+	bpf->jit.raw = ctx.ins;
 	bpf->jit.sz = size;
 
 	goto finish;
diff --git a/lib/bpf/bpf_jit_x86.c b/lib/bpf/bpf_jit_x86.c
index 6f4235d43499..54eb279643b9 100644
--- a/lib/bpf/bpf_jit_x86.c
+++ b/lib/bpf/bpf_jit_x86.c
@@ -1568,7 +1568,7 @@ __rte_bpf_jit_x86(struct rte_bpf *bpf)
 	if (rc != 0)
 		munmap(st.ins, st.sz);
 	else {
-		bpf->jit.func = (void *)st.ins;
+		bpf->jit.raw = st.ins;
 		bpf->jit.sz = st.sz;
 	}
 
diff --git a/lib/bpf/bpf_load.c b/lib/bpf/bpf_load.c
index 650184167609..c9cbaf6ded7e 100644
--- a/lib/bpf/bpf_load.c
+++ b/lib/bpf/bpf_load.c
@@ -144,7 +144,8 @@ rte_bpf_load(const struct rte_bpf_prm *prm)
 			.raw.nb_ins = prm->nb_ins,
 			.xsym = prm->xsym,
 			.nb_xsym = prm->nb_xsym,
-			.prog_arg = prm->prog_arg,
+			.prog_arg[0] = prm->prog_arg,
+			.nb_prog_arg = 1,
 		});
 }
 
@@ -160,7 +161,8 @@ rte_bpf_elf_load(const struct rte_bpf_prm *prm, const char *fname,
 			.elf_file.section = sname,
 			.xsym = prm->xsym,
 			.nb_xsym = prm->nb_xsym,
-			.prog_arg = prm->prog_arg,
+			.prog_arg[0] = prm->prog_arg,
+			.nb_prog_arg = 1,
 		});
 }
 
diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index 5bfc59296d05..bf8a4abb5a5a 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -2425,10 +2425,14 @@ evaluate(struct bpf_verifier *bvf)
 		.s = {.min = MAX_BPF_STACK_SIZE, .max = MAX_BPF_STACK_SIZE},
 	};
 
-	bvf->evst->rv[EBPF_REG_1].v = bvf->prm->prog_arg;
-	bvf->evst->rv[EBPF_REG_1].mask = UINT64_MAX;
-	if (bvf->prm->prog_arg.type == RTE_BPF_ARG_RAW)
-		eval_max_bound(bvf->evst->rv + EBPF_REG_1, UINT64_MAX);
+	for (uint32_t pai = 0; pai != bvf->prm->nb_prog_arg; ++pai) {
+		struct bpf_reg_val *reg = &bvf->evst->rv[EBPF_REG_1 + pai];
+
+		reg->v = bvf->prm->prog_arg[pai];
+		reg->mask = UINT64_MAX;
+		if (reg->v.type == RTE_BPF_ARG_RAW)
+			eval_max_bound(reg, UINT64_MAX);
+	}
 
 	bvf->evst->rv[EBPF_REG_10] = rvfp;
 
@@ -2521,21 +2525,42 @@ evaluate(struct bpf_verifier *bvf)
 	return rc;
 }
 
+static bool
+prog_arg_is_valid(const struct rte_bpf_arg *prog_arg)
+{
+	/* check input argument type, don't allow mbuf ptr on 32-bit */
+	if (prog_arg->type != RTE_BPF_ARG_RAW &&
+			prog_arg->type != RTE_BPF_ARG_PTR &&
+			(sizeof(uint64_t) != sizeof(uintptr_t) ||
+			prog_arg->type != RTE_BPF_ARG_PTR_MBUF)) {
+		RTE_BPF_LOG_FUNC_LINE(ERR, "unsupported argument type");
+		return false;
+	}
+
+	return true;
+}
+
 int
 __rte_bpf_validate(const struct rte_bpf_prm_ex *prm, uint32_t *stack_sz)
 {
 	int32_t rc;
 	struct bpf_verifier bvf;
 
-	/* check input argument type, don't allow mbuf ptr on 32-bit */
-	if (prm->prog_arg.type != RTE_BPF_ARG_RAW &&
-			prm->prog_arg.type != RTE_BPF_ARG_PTR &&
-			(sizeof(uint64_t) != sizeof(uintptr_t) ||
-			prm->prog_arg.type != RTE_BPF_ARG_PTR_MBUF)) {
-		RTE_BPF_LOG_FUNC_LINE(ERR, "unsupported argument type");
+	if (prm->nb_prog_arg > EBPF_FUNC_MAX_ARGS) {
+		RTE_BPF_LOG_FUNC_LINE(ERR,
+			"support up to %u arguments, found %u",
+			EBPF_FUNC_MAX_ARGS, prm->nb_prog_arg);
 		return -ENOTSUP;
 	}
 
+	for (uint32_t pai = 0; pai != prm->nb_prog_arg; ++pai)
+		if (!prog_arg_is_valid(&prm->prog_arg[pai])) {
+			RTE_BPF_LOG_FUNC_LINE(ERR,
+				"unsupported argument %d (r%d) type",
+				pai, EBPF_REG_1 + pai);
+			return -ENOTSUP;
+		}
+
 	memset(&bvf, 0, sizeof(bvf));
 	bvf.prm = prm;
 	bvf.in = calloc(prm->raw.nb_ins, sizeof(bvf.in[0]));
diff --git a/lib/bpf/rte_bpf.h b/lib/bpf/rte_bpf.h
index bf58a418191e..751b879bb7fd 100644
--- a/lib/bpf/rte_bpf.h
+++ b/lib/bpf/rte_bpf.h
@@ -25,6 +25,11 @@
 extern "C" {
 #endif
 
+#define RTE_BPF_EXEC_FLAG_JIT	RTE_BIT64(0)	/**< use JIT-compiled version */
+
+/** Mask with all supported `RTE_BPF_EXEC_FLAG_*` flags set. */
+#define RTE_BPF_EXEC_FLAG_MASK  RTE_BPF_EXEC_FLAG_JIT
+
 /**
  * Possible types for function/BPF program arguments.
  */
@@ -122,7 +127,8 @@ struct rte_bpf_prm_ex {
 	/**< array of external symbols that eBPF code is allowed to reference */
 	uint32_t nb_xsym;  /**< number of elements in xsym */
 
-	struct rte_bpf_arg prog_arg;  /**< input arg description */
+	struct rte_bpf_arg prog_arg[EBPF_FUNC_MAX_ARGS];  /**< program arguments */
+	uint32_t nb_prog_arg;  /**< program argument count */
 };
 
 /**
@@ -138,13 +144,49 @@ struct rte_bpf_prm {
 };
 
 /**
- * Information about compiled into native ISA eBPF code.
+ * Information about compiled into native ISA eBPF code accepting 1 argument.
  */
 struct rte_bpf_jit {
 	uint64_t (*func)(void *); /**< JIT-ed native code */
 	size_t sz;                /**< size of JIT-ed code */
 };
 
+union rte_bpf_func_arg {
+	uint64_t u64;
+	void *ptr;
+};
+
+typedef uint64_t (*rte_bpf_jit_func0_t)(void);
+typedef uint64_t (*rte_bpf_jit_func1_t)(union rte_bpf_func_arg);
+typedef uint64_t (*rte_bpf_jit_func2_t)(union rte_bpf_func_arg, union rte_bpf_func_arg);
+typedef uint64_t (*rte_bpf_jit_func3_t)(union rte_bpf_func_arg, union rte_bpf_func_arg,
+	union rte_bpf_func_arg);
+typedef uint64_t (*rte_bpf_jit_func4_t)(union rte_bpf_func_arg, union rte_bpf_func_arg,
+	union rte_bpf_func_arg, union rte_bpf_func_arg);
+typedef uint64_t (*rte_bpf_jit_func5_t)(union rte_bpf_func_arg, union rte_bpf_func_arg,
+	union rte_bpf_func_arg, union rte_bpf_func_arg, union rte_bpf_func_arg);
+
+/**
+ * JIT-ed native code, member depends on number of program arguments.
+ */
+struct rte_bpf_jit_ex {
+	union {
+		void *raw;
+		rte_bpf_jit_func0_t func0;  /* nullary function */
+		rte_bpf_jit_func1_t func1;  /* unary function */
+		rte_bpf_jit_func2_t func2;  /* binary function */
+		rte_bpf_jit_func3_t func3;  /* ternary function */
+		rte_bpf_jit_func4_t func4;  /* quaternary function */
+		rte_bpf_jit_func5_t func5;  /* quinary function */
+	};
+	size_t sz;
+};
+
+/* Tuple of eBPF program arguments. */
+struct rte_bpf_prog_ctx {
+	union rte_bpf_func_arg arg[EBPF_FUNC_MAX_ARGS];
+};
+
 struct rte_bpf;
 
 /**
@@ -224,7 +266,7 @@ rte_bpf_elf_load(const struct rte_bpf_prm *prm, const char *fname,
 	__rte_malloc __rte_dealloc(rte_bpf_destroy, 1);
 
 /**
- * Execute given BPF bytecode.
+ * Execute given BPF bytecode accepting 1 argument.
  *
  * @param bpf
  *   handle for the BPF code to execute.
@@ -237,7 +279,27 @@ uint64_t
 rte_bpf_exec(const struct rte_bpf *bpf, void *ctx);
 
 /**
- * Execute given BPF bytecode over a set of input contexts.
+ * @warning
+ * @b EXPERIMENTAL: This API may change, or be removed, without prior notice.
+ *
+ * Execute given BPF bytecode accepting any number of arguments.
+ *
+ * @param bpf
+ *   handle for the BPF code to execute.
+ * @param ctx
+ *   program arguments tuple.
+ * @param flags
+ *   bitwise OR of `RTE_BPF_EXEC_FLAG_*` values controlling execution.
+ * @return
+ *   BPF execution return value.
+ */
+__rte_experimental
+uint64_t
+rte_bpf_exec_ex(const struct rte_bpf *bpf, const struct rte_bpf_prog_ctx *ctx,
+		uint64_t flags);
+
+/**
+ * Execute given BPF bytecode accepting 1 argument over a set of input contexts.
  *
  * @param bpf
  *   handle for the BPF code to execute.
@@ -255,7 +317,33 @@ rte_bpf_exec_burst(const struct rte_bpf *bpf, void *ctx[], uint64_t rc[],
 		uint32_t num);
 
 /**
- * Provide information about natively compiled code for given BPF handle.
+ * @warning
+ * @b EXPERIMENTAL: This API may change, or be removed, without prior notice.
+ *
+ * Execute given BPF program accepting any number of arguments over a set of
+ * input contexts.
+ *
+ * @param bpf
+ *   handle for the BPF code to execute.
+ * @param ctx
+ *   pointer to array of program argument tuples, can be NULL for nullary programs.
+ * @param rc
+ *   array of return values (one per input).
+ * @param num
+ *   number executions, number of elements in arrays ctx and rc[].
+ * @param flags
+ *   bitwise OR of `RTE_BPF_EXEC_FLAG_*` values controlling execution.
+ * @return
+ *   number of successfully processed inputs.
+ */
+__rte_experimental
+uint32_t
+rte_bpf_exec_burst_ex(const struct rte_bpf *bpf, const struct rte_bpf_prog_ctx *ctx,
+		uint64_t rc[], uint32_t num, uint64_t flags);
+
+/**
+ * Provide information about natively compiled code for given BPF program
+ * accepting 1 argument.
  *
  * @param bpf
  *   handle for the BPF code.
@@ -268,6 +356,25 @@ rte_bpf_exec_burst(const struct rte_bpf *bpf, void *ctx[], uint64_t rc[],
 int
 rte_bpf_get_jit(const struct rte_bpf *bpf, struct rte_bpf_jit *jit);
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: This API may change, or be removed, without prior notice.
+ *
+ * Get function JIT-compiled from the BPF program.
+ *
+ * @param bpf
+ *   handle for the BPF code.
+ * @param jit
+ *   pointer to the struct rte_bpf_jit_ex.
+ * @return
+ *   - -EINVAL if the parameters are invalid.
+ *   - -ENOENT if there is no JIT-compiled version.
+ *   - Zero if operation completed successfully.
+ */
+__rte_experimental
+int
+rte_bpf_get_jit_ex(const struct rte_bpf *bpf, struct rte_bpf_jit_ex *jit);
+
 /**
  * Dump epf instructions to a file.
  *
-- 
2.43.0

