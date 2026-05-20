Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 972C2CD4F54
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 May 2026 12:50:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3263D40695;
	Wed, 20 May 2026 14:49:59 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 24EE240144
 for <dev@dpdk.org>; Wed, 20 May 2026 14:49:54 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.224.107])
 by frasgout.his.huawei.com (SkyGuard) with ESMTPS id 4gLBFP1hyGzHnGk7;
 Wed, 20 May 2026 20:49:29 +0800 (CST)
Received: from frapema500003.china.huawei.com (unknown [7.182.19.114])
 by mail.maildlp.com (Postfix) with ESMTPS id F3FA140584;
 Wed, 20 May 2026 20:49:52 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapema500003.china.huawei.com (7.182.19.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 May 2026 14:49:52 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>, Wathsala Vithanage
 <wathsala.vithanage@arm.com>
CC: <dev@dpdk.org>
Subject: [PATCH v4 02/11] bpf: introduce extensible load API
Date: Wed, 20 May 2026 13:49:11 +0100
Message-ID: <20260520124922.42445-3-marat.khalili@huawei.com>
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

Introduce new BPF load parameters struct rte_bpf_prm_ex that can be
extended without breaking backward or forward compatibility. Introduce
new function rte_bpf_load_ex consolidating in one code path loading from
both ELF file and raw memory image, with possibility to add more options
in the future.

Some changes in code layout and sequence:
* Both old APIs now only forwarding calls to a new single entry point.
* There is now a centralized cleanup point for all temporary resources
  created during the load process.
* External symbols (xsyms) are now checked for validity just after the
  load started, not after they were already used for relocation.
* File bpf_load_elf.c now only handles opening ELF file and providing
  patched instruction array to the load process. These are left as two
  separate functions to support other ELF sources like memory image in
  the future.
* Function stubs for the case libelf is not available are moved to
  bpf_load_elf.c to make keeping track of them easier (forgetting to
  update stubs is a common problem).

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
Acked-by: Konstantin Ananyev <konstantin.ananyev@huawei.com>
---
 lib/bpf/bpf_exec.c      |  10 +--
 lib/bpf/bpf_impl.h      |  32 ++++++-
 lib/bpf/bpf_jit_arm64.c |  12 +--
 lib/bpf/bpf_jit_x86.c   |   8 +-
 lib/bpf/bpf_load.c      | 195 +++++++++++++++++++++++++++++++++++-----
 lib/bpf/bpf_load_elf.c  | 151 ++++++++++++++++++-------------
 lib/bpf/bpf_stub.c      |  17 ----
 lib/bpf/bpf_validate.c  |  32 +++----
 lib/bpf/meson.build     |   4 +-
 lib/bpf/rte_bpf.h       |  68 +++++++++++++-
 10 files changed, 392 insertions(+), 137 deletions(-)

diff --git a/lib/bpf/bpf_exec.c b/lib/bpf/bpf_exec.c
index 18013753b147..e4668ba10b64 100644
--- a/lib/bpf/bpf_exec.c
+++ b/lib/bpf/bpf_exec.c
@@ -47,7 +47,7 @@
 		RTE_BPF_LOG_LINE(ERR, \
 			"%s(%p): division by 0 at pc: %#zx;", \
 			__func__, bpf, \
-			(uintptr_t)(ins) - (uintptr_t)(bpf)->prm.ins); \
+			(uintptr_t)(ins) - (uintptr_t)(bpf)->prm.raw.ins); \
 		return 0; \
 	} \
 } while (0)
@@ -81,7 +81,7 @@
 		RTE_BPF_LOG_LINE(ERR, \
 			"%s(%p): unsupported atomic operation at pc: %#zx;", \
 			__func__, bpf, \
-			(uintptr_t)(ins) - (uintptr_t)(bpf)->prm.ins); \
+			(uintptr_t)(ins) - (uintptr_t)(bpf)->prm.raw.ins); \
 		return 0; \
 	} \
 } while (0)
@@ -157,7 +157,7 @@ bpf_ld_mbuf(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM],
 		RTE_BPF_LOG_LINE(DEBUG, "%s(bpf=%p, mbuf=%p, ofs=%u, len=%u): "
 			"load beyond packet boundary at pc: %#zx;",
 			__func__, bpf, mb, off, len,
-			(uintptr_t)(ins) - (uintptr_t)(bpf)->prm.ins);
+			(uintptr_t)(ins) - (uintptr_t)(bpf)->prm.raw.ins);
 	return p;
 }
 
@@ -166,7 +166,7 @@ bpf_exec(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM])
 {
 	const struct ebpf_insn *ins;
 
-	for (ins = bpf->prm.ins; ; ins++) {
+	for (ins = bpf->prm.raw.ins; ; ins++) {
 		switch (ins->code) {
 		/* 32 bit ALU IMM operations */
 		case (BPF_ALU | BPF_ADD | BPF_K):
@@ -483,7 +483,7 @@ bpf_exec(const struct rte_bpf *bpf, uint64_t reg[EBPF_REG_NUM])
 			RTE_BPF_LOG_LINE(ERR,
 				"%s(%p): invalid opcode %#x at pc: %#zx;",
 				__func__, bpf, ins->code,
-				(uintptr_t)ins - (uintptr_t)bpf->prm.ins);
+				(uintptr_t)ins - (uintptr_t)bpf->prm.raw.ins);
 			return 0;
 		}
 	}
diff --git a/lib/bpf/bpf_impl.h b/lib/bpf/bpf_impl.h
index fb5ec3c4d65f..1cee109bc98a 100644
--- a/lib/bpf/bpf_impl.h
+++ b/lib/bpf/bpf_impl.h
@@ -11,17 +11,45 @@
 #define MAX_BPF_STACK_SIZE	0x200
 
 struct rte_bpf {
-	struct rte_bpf_prm prm;
+	struct rte_bpf_prm_ex prm;
 	struct rte_bpf_jit jit;
 	size_t sz;
 	uint32_t stack_sz;
 };
 
+/* Temporary copies etc. used by the load process. */
+struct __rte_bpf_load {
+	struct rte_bpf_prm_ex prm;
+
+	/* Loading ELF and applying relocations. */
+	int elf_fd;  /* ELF fd, must be negative (not zero) by default. */
+	void *elf;  /* Using void to avoid dependency on libelf. */
+
+	/* Value we are going to return, if any. */
+	struct rte_bpf *bpf;
+};
+
 /*
  * Use '__rte' prefix for non-static internal functions
  * to avoid potential name conflict with other libraries.
  */
-int __rte_bpf_validate(struct rte_bpf *bpf);
+
+/* Free temporary resources created by opening ELF. */
+void
+__rte_bpf_load_elf_cleanup(struct __rte_bpf_load *load);
+
+/* Open the ELF file. */
+int
+__rte_bpf_load_elf_file(struct __rte_bpf_load *load);
+
+/* Get code from ELF and apply relocations to it. */
+int
+__rte_bpf_load_elf_code(struct __rte_bpf_load *load);
+
+/* Validate final BPF code and calculate stack size. */
+int
+__rte_bpf_validate(const struct rte_bpf_prm_ex *prm, uint32_t *stack_sz);
+
 int __rte_bpf_jit(struct rte_bpf *bpf);
 int __rte_bpf_jit_x86(struct rte_bpf *bpf);
 int __rte_bpf_jit_arm64(struct rte_bpf *bpf);
diff --git a/lib/bpf/bpf_jit_arm64.c b/lib/bpf/bpf_jit_arm64.c
index 4bbb97da1b89..9e5e142c13ba 100644
--- a/lib/bpf/bpf_jit_arm64.c
+++ b/lib/bpf/bpf_jit_arm64.c
@@ -111,12 +111,12 @@ jump_offset_init(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
 {
 	uint32_t i;
 
-	ctx->map = malloc(bpf->prm.nb_ins * sizeof(ctx->map[0]));
+	ctx->map = malloc(bpf->prm.raw.nb_ins * sizeof(ctx->map[0]));
 	if (ctx->map == NULL)
 		return -ENOMEM;
 
 	/* Fill with fake offsets */
-	for (i = 0; i != bpf->prm.nb_ins; i++) {
+	for (i = 0; i != bpf->prm.raw.nb_ins; i++) {
 		ctx->map[i].off = INT32_MAX;
 		ctx->map[i].off_to_b = 0;
 	}
@@ -1130,8 +1130,8 @@ check_program_has_call(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
 	uint8_t op;
 	uint32_t i;
 
-	for (i = 0; i != bpf->prm.nb_ins; i++) {
-		ins = bpf->prm.ins + i;
+	for (i = 0; i != bpf->prm.raw.nb_ins; i++) {
+		ins = bpf->prm.raw.ins + i;
 		op = ins->code;
 
 		switch (op) {
@@ -1168,10 +1168,10 @@ emit(struct a64_jit_ctx *ctx, struct rte_bpf *bpf)
 
 	emit_prologue(ctx);
 
-	for (i = 0; i != bpf->prm.nb_ins; i++) {
+	for (i = 0; i != bpf->prm.raw.nb_ins; i++) {
 
 		jump_offset_update(ctx, i);
-		ins = bpf->prm.ins + i;
+		ins = bpf->prm.raw.ins + i;
 		op = ins->code;
 		off = ins->off;
 		imm = ins->imm;
diff --git a/lib/bpf/bpf_jit_x86.c b/lib/bpf/bpf_jit_x86.c
index 88b1b5aeab1a..6f4235d43499 100644
--- a/lib/bpf/bpf_jit_x86.c
+++ b/lib/bpf/bpf_jit_x86.c
@@ -1324,12 +1324,12 @@ emit(struct bpf_jit_state *st, const struct rte_bpf *bpf)
 
 	emit_prolog(st, bpf->stack_sz);
 
-	for (i = 0; i != bpf->prm.nb_ins; i++) {
+	for (i = 0; i != bpf->prm.raw.nb_ins; i++) {
 
 		st->idx = i;
 		st->off[i] = st->sz;
 
-		ins = bpf->prm.ins + i;
+		ins = bpf->prm.raw.ins + i;
 
 		dr = ebpf2x86[ins->dst_reg];
 		sr = ebpf2x86[ins->src_reg];
@@ -1532,13 +1532,13 @@ __rte_bpf_jit_x86(struct rte_bpf *bpf)
 
 	/* init state */
 	memset(&st, 0, sizeof(st));
-	st.off = malloc(bpf->prm.nb_ins * sizeof(st.off[0]));
+	st.off = malloc(bpf->prm.raw.nb_ins * sizeof(st.off[0]));
 	if (st.off == NULL)
 		return -ENOMEM;
 
 	/* fill with fake offsets */
 	st.exit.off = INT32_MAX;
-	for (i = 0; i != bpf->prm.nb_ins; i++)
+	for (i = 0; i != bpf->prm.raw.nb_ins; i++)
 		st.off[i] = INT32_MAX;
 
 	/*
diff --git a/lib/bpf/bpf_load.c b/lib/bpf/bpf_load.c
index b8a0426fe2ed..2d9e503d1f7e 100644
--- a/lib/bpf/bpf_load.c
+++ b/lib/bpf/bpf_load.c
@@ -14,14 +14,14 @@
 #include "bpf_impl.h"
 
 static struct rte_bpf *
-bpf_load(const struct rte_bpf_prm *prm)
+bpf_load(const struct rte_bpf_prm_ex *prm)
 {
 	uint8_t *buf;
 	struct rte_bpf *bpf;
 	size_t sz, bsz, insz, xsz;
 
 	xsz =  prm->nb_xsym * sizeof(prm->xsym[0]);
-	insz = prm->nb_ins * sizeof(prm->ins[0]);
+	insz = prm->raw.nb_ins * sizeof(prm->raw.ins[0]);
 	bsz = sizeof(bpf[0]);
 	sz = insz + xsz + bsz;
 
@@ -37,10 +37,10 @@ bpf_load(const struct rte_bpf_prm *prm)
 
 	if (xsz > 0)
 		memcpy(buf + bsz, prm->xsym, xsz);
-	memcpy(buf + bsz + xsz, prm->ins, insz);
+	memcpy(buf + bsz + xsz, prm->raw.ins, insz);
 
 	bpf->prm.xsym = (void *)(buf + bsz);
-	bpf->prm.ins = (void *)(buf + bsz + xsz);
+	bpf->prm.raw.ins = (void *)(buf + bsz + xsz);
 
 	return bpf;
 }
@@ -80,37 +80,44 @@ bpf_check_xsym(const struct rte_bpf_xsym *xsym)
 	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_bpf_load)
-struct rte_bpf *
-rte_bpf_load(const struct rte_bpf_prm *prm)
+static int
+bpf_check_xsyms(const struct rte_bpf_xsym *xsym, uint32_t nb_xsym)
 {
-	struct rte_bpf *bpf;
 	int32_t rc;
 	uint32_t i;
 
-	if (prm == NULL || prm->ins == NULL || prm->nb_ins == 0 ||
-			(prm->nb_xsym != 0 && prm->xsym == NULL)) {
-		rte_errno = EINVAL;
-		return NULL;
-	}
+	if (nb_xsym != 0 && xsym == NULL)
+		return -EINVAL;
 
 	rc = 0;
-	for (i = 0; i != prm->nb_xsym && rc == 0; i++)
-		rc = bpf_check_xsym(prm->xsym + i);
+	for (i = 0; i != nb_xsym && rc == 0; i++)
+		rc = bpf_check_xsym(xsym + i);
 
 	if (rc != 0) {
-		rte_errno = -rc;
 		RTE_BPF_LOG_FUNC_LINE(ERR, "%d-th xsym is invalid", i);
-		return NULL;
+		return rc;
 	}
 
+	return 0;
+}
+
+static int
+bpf_load_raw(struct __rte_bpf_load *load)
+{
+	const struct rte_bpf_prm_ex *const prm = &load->prm;
+	struct rte_bpf *bpf;
+	int32_t rc;
+
+	RTE_ASSERT(prm->origin == RTE_BPF_ORIGIN_RAW);
+
+	if (prm->raw.ins == NULL || prm->raw.nb_ins == 0)
+		return -EINVAL;
+
 	bpf = bpf_load(prm);
-	if (bpf == NULL) {
-		rte_errno = ENOMEM;
-		return NULL;
-	}
+	if (bpf == NULL)
+		return -ENOMEM;
 
-	rc = __rte_bpf_validate(bpf);
+	rc = __rte_bpf_validate(&load->prm, &bpf->stack_sz);
 	if (rc == 0) {
 		__rte_bpf_jit(bpf);
 		if (mprotect(bpf, bpf->sz, PROT_READ) != 0)
@@ -119,9 +126,151 @@ rte_bpf_load(const struct rte_bpf_prm *prm)
 
 	if (rc != 0) {
 		rte_bpf_destroy(bpf);
+		return rc;
+	}
+
+	load->bpf = bpf;
+	return 0;
+}
+
+RTE_EXPORT_SYMBOL(rte_bpf_load)
+struct rte_bpf *
+rte_bpf_load(const struct rte_bpf_prm *prm)
+{
+	if (prm == NULL) {
+		rte_errno = EINVAL;
+		return NULL;
+	}
+
+	return rte_bpf_load_ex(&(struct rte_bpf_prm_ex){
+			.sz = sizeof(struct rte_bpf_prm_ex),
+			.origin = RTE_BPF_ORIGIN_RAW,
+			.raw.ins = prm->ins,
+			.raw.nb_ins = prm->nb_ins,
+			.xsym = prm->xsym,
+			.nb_xsym = prm->nb_xsym,
+			.prog_arg = prm->prog_arg,
+		});
+}
+
+RTE_EXPORT_SYMBOL(rte_bpf_elf_load)
+struct rte_bpf *
+rte_bpf_elf_load(const struct rte_bpf_prm *prm, const char *fname,
+	const char *sname)
+{
+	if (prm == NULL) {
+		rte_errno = EINVAL;
+		return NULL;
+	}
+
+	return rte_bpf_load_ex(&(struct rte_bpf_prm_ex){
+			.sz = sizeof(struct rte_bpf_prm_ex),
+			.origin = RTE_BPF_ORIGIN_ELF_FILE,
+			.elf_file.path = fname,
+			.elf_file.section = sname,
+			.xsym = prm->xsym,
+			.nb_xsym = prm->nb_xsym,
+			.prog_arg = prm->prog_arg,
+		});
+}
+
+/*
+ * Check extensible opts for invalid size or non-zero unsupported members.
+ *
+ * This code provides forward compatibility with applications compiled against
+ * newer version of this library. `opts_sz` is the size of struct `opts` in the
+ * version used for compiling the application, read from the member `sz`;
+ * `type_sz` is the size of same struct in the version used for compiling the
+ * library.
+ *
+ * If new fields were added to the struct in the application version, `opts_sz`
+ * will be greater than `type_sz`. In this case we are making sure all bytes we
+ * don't know how to interpret are zeroes, that is any new features that are
+ * there are not being used.
+ *
+ * This function can be used to check any struct following this convention.
+ */
+static bool
+opts_valid(const void *opts, size_t opts_sz, size_t type_sz)
+{
+	if (opts == NULL)
+		return true;
+
+	if (opts_sz < sizeof(opts_sz))
+		/* Size of the struct is too small even for sz member. */
+		return false;
+
+	/* Verify that all extra bytes are zeroed. */
+	for (size_t offset = type_sz; offset < opts_sz; ++offset)
+		if (((const char *)opts)[offset] != 0)
+			return false;
+
+	return true;
+}
+
+static int
+load_try(struct __rte_bpf_load *load, const struct rte_bpf_prm_ex *app_prm)
+{
+	int rc;
+
+	if (app_prm == NULL || !opts_valid(app_prm, app_prm->sz, sizeof(load->prm)))
+		return -EINVAL;
+
+	/*
+	 * Convert extensible prm of application size to the size known to us.
+	 *
+	 * This code provides compatibility with applications compiled against
+	 * different version of this library. `app_prm->sz` is the size of
+	 * struct `rte_bpf_prm_ex` in the version used for compiling the
+	 * application; `sizeof(load->prm)` is the size of the same struct in
+	 * the version used for compiling the library.
+	 *
+	 * We are copying only the fields known to the application and leave
+	 * the rest filled with zeroes. Any features that not known to the
+	 * application will have backward-compatible default behaviour.
+	 */
+	memcpy(&load->prm, app_prm, RTE_MIN(app_prm->sz, sizeof(load->prm)));
+	load->prm.sz = sizeof(load->prm);
+
+	rc = bpf_check_xsyms(load->prm.xsym, load->prm.nb_xsym);
+
+	/* Convert prm origin to raw unless it already is. */
+	switch (load->prm.origin) {
+	case RTE_BPF_ORIGIN_RAW:
+		break;
+	case RTE_BPF_ORIGIN_ELF_FILE:
+		rc = rc < 0 ? rc : __rte_bpf_load_elf_file(load);
+		rc = rc < 0 ? rc : __rte_bpf_load_elf_code(load);
+		break;
+	default:
+		rc = rc < 0 ? rc : -EINVAL;
+	}
+
+	/* Now that it is raw load it as such. */
+	rc = rc < 0 ? rc : bpf_load_raw(load);
+
+	return rc;
+}
+
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_bpf_load_ex, 26.11)
+struct rte_bpf *
+rte_bpf_load_ex(const struct rte_bpf_prm_ex *prm)
+{
+	struct __rte_bpf_load load = { .elf_fd = -1 };
+
+	const int rc = load_try(&load, prm);
+
+	__rte_bpf_load_elf_cleanup(&load);
+
+	RTE_ASSERT((rc < 0) == (load.bpf == NULL));
+
+	if (rc < 0) {
+		RTE_BPF_LOG_FUNC_LINE(ERR, "failed, error code: %d", -rc);
 		rte_errno = -rc;
 		return NULL;
 	}
 
-	return bpf;
+	RTE_BPF_LOG_FUNC_LINE(INFO, "successfully creates %p(jit={.func=%p,.sz=%zu});",
+		load.bpf, load.bpf->jit.raw, load.bpf->jit.sz);
+	return load.bpf;
 }
diff --git a/lib/bpf/bpf_load_elf.c b/lib/bpf/bpf_load_elf.c
index 2390823cbf30..4ae7492351ae 100644
--- a/lib/bpf/bpf_load_elf.c
+++ b/lib/bpf/bpf_load_elf.c
@@ -2,6 +2,13 @@
  * Copyright(c) 2018 Intel Corporation
  */
 
+#include "bpf_impl.h"
+
+#include <errno.h>
+
+#ifdef RTE_LIBRTE_BPF_ELF
+
+#include <inttypes.h>
 #include <stdarg.h>
 #include <stdio.h>
 #include <string.h>
@@ -26,8 +33,6 @@
 #include <rte_byteorder.h>
 #include <rte_errno.h>
 
-#include "bpf_impl.h"
-
 /* To overcome compatibility issue */
 #ifndef EM_BPF
 #define	EM_BPF	247
@@ -56,7 +61,7 @@ bpf_find_xsym(const char *sn, enum rte_bpf_xtype type,
  */
 static int
 resolve_xsym(const char *sn, size_t ofs, struct ebpf_insn *ins, size_t ins_sz,
-	const struct rte_bpf_prm *prm)
+	const struct rte_bpf_prm_ex *prm)
 {
 	uint32_t idx, fidx;
 	enum rte_bpf_xtype type;
@@ -183,7 +188,7 @@ find_elf_code(Elf *elf, const char *section, Elf_Data **psd, size_t *pidx)
  */
 static int
 process_reloc(Elf *elf, size_t sym_idx, Elf64_Rel *re, size_t re_sz,
-	struct ebpf_insn *ins, size_t ins_sz, const struct rte_bpf_prm *prm)
+	struct ebpf_insn *ins, size_t ins_sz, const struct rte_bpf_prm_ex *prm)
 {
 	int32_t rc;
 	uint32_t i, n;
@@ -232,8 +237,8 @@ process_reloc(Elf *elf, size_t sym_idx, Elf64_Rel *re, size_t re_sz,
  * and update bpf code.
  */
 static int
-elf_reloc_code(Elf *elf, Elf_Data *ed, size_t sidx,
-	const struct rte_bpf_prm *prm)
+elf_reloc_code(Elf *elf, struct ebpf_insn *ins, size_t ins_sz, size_t sidx,
+	const struct rte_bpf_prm_ex *prm)
 {
 	Elf64_Rel *re;
 	Elf_Scn *sc;
@@ -256,7 +261,7 @@ elf_reloc_code(Elf *elf, Elf_Data *ed, size_t sidx,
 					sd->d_size % sizeof(re[0]) != 0)
 				return -EINVAL;
 			rc = process_reloc(elf, sh->sh_link,
-				sd->d_buf, sd->d_size, ed->d_buf, ed->d_size,
+				sd->d_buf, sd->d_size, ins, ins_sz,
 				prm);
 		}
 	}
@@ -264,72 +269,96 @@ elf_reloc_code(Elf *elf, Elf_Data *ed, size_t sidx,
 	return rc;
 }
 
-static struct rte_bpf *
-bpf_load_elf(const struct rte_bpf_prm *prm, int32_t fd, const char *section)
+void
+__rte_bpf_load_elf_cleanup(struct __rte_bpf_load *load)
 {
-	Elf *elf;
-	Elf_Data *sd;
-	size_t sidx;
-	int32_t rc;
-	struct rte_bpf *bpf;
-	struct rte_bpf_prm np;
+	elf_end(load->elf);
 
-	elf_version(EV_CURRENT);
-	elf = elf_begin(fd, ELF_C_READ, NULL);
+	if (load->elf_fd >= 0 && close(load->elf_fd) < 0) {
+		const int close_errno = errno;
+		RTE_BPF_LOG_FUNC_LINE(ERR, "error %d closing: %s",
+			close_errno, strerror(close_errno));
+	}
+}
 
-	rc = find_elf_code(elf, section, &sd, &sidx);
-	if (rc == 0)
-		rc = elf_reloc_code(elf, sd, sidx, prm);
+int
+__rte_bpf_load_elf_file(struct __rte_bpf_load *load)
+{
+	const struct rte_bpf_prm_ex *const prm = &load->prm;
 
-	if (rc == 0) {
-		np = prm[0];
-		np.ins = sd->d_buf;
-		np.nb_ins = sd->d_size / sizeof(struct ebpf_insn);
-		bpf = rte_bpf_load(&np);
-	} else {
-		bpf = NULL;
-		rte_errno = -rc;
+	RTE_ASSERT(prm->origin == RTE_BPF_ORIGIN_ELF_FILE);
+
+	if (prm->elf_file.path == NULL || prm->elf_file.section == NULL)
+		return -EINVAL;
+
+	if (elf_version(EV_CURRENT) == EV_NONE)
+		return -ENOTSUP;
+
+	load->elf_fd = open(prm->elf_file.path, O_RDONLY);
+	if (load->elf_fd < 0) {
+		const int open_errno = errno;
+		RTE_BPF_LOG_FUNC_LINE(ERR, "error %d opening \"%s\": %s",
+			open_errno, prm->elf_file.path, strerror(open_errno));
+		return -open_errno;
+	}
+
+	load->elf = elf_begin(load->elf_fd, ELF_C_READ, NULL);
+	if (load->elf == NULL) {
+		const int rc = elf_errno();
+		RTE_BPF_LOG_FUNC_LINE(ERR, "error %d opening ELF \"%s\": %s",
+			rc, prm->elf_file.path, elf_errmsg(rc));
+		return -EINVAL;
 	}
 
-	elf_end(elf);
-	return bpf;
+	return 0;
 }
 
-RTE_EXPORT_SYMBOL(rte_bpf_elf_load)
-struct rte_bpf *
-rte_bpf_elf_load(const struct rte_bpf_prm *prm, const char *fname,
-	const char *sname)
+int
+__rte_bpf_load_elf_code(struct __rte_bpf_load *load)
 {
-	int32_t fd, rc;
-	struct rte_bpf *bpf;
+	struct rte_bpf_prm_ex *const prm = &load->prm;
+	Elf_Data *sd;
+	size_t sidx;
+	int rc;
 
-	if (prm == NULL || fname == NULL || sname == NULL) {
-		rte_errno = EINVAL;
-		return NULL;
-	}
+	rc = find_elf_code(load->elf, prm->elf_file.section, &sd, &sidx);
+	if (rc < 0)
+		return rc;
 
-	fd = open(fname, O_RDONLY);
-	if (fd < 0) {
-		rc = errno;
-		RTE_BPF_LOG_LINE(ERR, "%s(%s) error code: %d(%s)",
-			__func__, fname, rc, strerror(rc));
-		rte_errno = EINVAL;
-		return NULL;
-	}
+	prm->origin = RTE_BPF_ORIGIN_RAW;
+	prm->raw.ins = sd->d_buf;
+	prm->raw.nb_ins = sd->d_size / sizeof(struct ebpf_insn);
 
-	bpf = bpf_load_elf(prm, fd, sname);
-	close(fd);
+	rc = elf_reloc_code(load->elf, sd->d_buf, sd->d_size, sidx, prm);
+	if (rc < 0)
+		return -EINVAL;
 
-	if (bpf == NULL) {
-		RTE_BPF_LOG_LINE(ERR,
-			"%s(fname=\"%s\", sname=\"%s\") failed, "
-			"error code: %d",
-			__func__, fname, sname, rte_errno);
-		return NULL;
-	}
+	return 0;
+}
+
+#else /* RTE_LIBRTE_BPF_ELF */
+
+void
+__rte_bpf_load_elf_cleanup(struct __rte_bpf_load *load)
+{
+	RTE_ASSERT(load->elf == NULL);
+	RTE_ASSERT(load->elf_fd < 0);
+}
 
-	RTE_BPF_LOG_LINE(INFO, "%s(fname=\"%s\", sname=\"%s\") "
-		"successfully creates %p(jit={.func=%p,.sz=%zu});",
-		__func__, fname, sname, bpf, bpf->jit.func, bpf->jit.sz);
-	return bpf;
+int
+__rte_bpf_load_elf_file(struct __rte_bpf_load *load)
+{
+	RTE_SET_USED(load);
+	RTE_BPF_LOG_FUNC_LINE(ERR, "not supported, rebuild with libelf installed");
+	return -ENOTSUP;
 }
+
+int
+__rte_bpf_load_elf_code(struct __rte_bpf_load *load)
+{
+	RTE_SET_USED(load);
+	RTE_BPF_LOG_FUNC_LINE(ERR, "not supported, rebuild with libelf installed");
+	return -ENOTSUP;
+}
+
+#endif /* RTE_LIBRTE_BPF_ELF */
diff --git a/lib/bpf/bpf_stub.c b/lib/bpf/bpf_stub.c
index e06e820d8327..4c329832c264 100644
--- a/lib/bpf/bpf_stub.c
+++ b/lib/bpf/bpf_stub.c
@@ -10,23 +10,6 @@
  * Contains stubs for unimplemented public API functions
  */
 
-#ifndef RTE_LIBRTE_BPF_ELF
-RTE_EXPORT_SYMBOL(rte_bpf_elf_load)
-struct rte_bpf *
-rte_bpf_elf_load(const struct rte_bpf_prm *prm, const char *fname,
-	const char *sname)
-{
-	if (prm == NULL || fname == NULL || sname == NULL) {
-		rte_errno = EINVAL;
-		return NULL;
-	}
-
-	RTE_BPF_LOG_FUNC_LINE(ERR, "not supported, rebuild with libelf installed");
-	rte_errno = ENOTSUP;
-	return NULL;
-}
-#endif
-
 #ifndef RTE_HAS_LIBPCAP
 RTE_EXPORT_SYMBOL(rte_bpf_convert)
 struct rte_bpf_prm *
diff --git a/lib/bpf/bpf_validate.c b/lib/bpf/bpf_validate.c
index a7f4f576c9d6..5bfc59296d05 100644
--- a/lib/bpf/bpf_validate.c
+++ b/lib/bpf/bpf_validate.c
@@ -80,7 +80,7 @@ struct evst_pool {
 };
 
 struct bpf_verifier {
-	const struct rte_bpf_prm *prm;
+	const struct rte_bpf_prm_ex *prm;
 	struct inst_node *in;
 	uint64_t stack_sz;
 	uint32_t nb_nodes;
@@ -1837,7 +1837,7 @@ add_edge(struct bpf_verifier *bvf, struct inst_node *node, uint32_t nidx)
 {
 	uint32_t ne;
 
-	if (nidx >= bvf->prm->nb_ins) {
+	if (nidx >= bvf->prm->raw.nb_ins) {
 		RTE_BPF_LOG_FUNC_LINE(ERR,
 			"program boundary violation at pc: %u, next pc: %u",
 			get_node_idx(bvf, node), nidx);
@@ -1946,10 +1946,10 @@ log_unreachable(const struct bpf_verifier *bvf)
 	struct inst_node *node;
 	const struct ebpf_insn *ins;
 
-	for (i = 0; i != bvf->prm->nb_ins; i++) {
+	for (i = 0; i != bvf->prm->raw.nb_ins; i++) {
 
 		node = bvf->in + i;
-		ins = bvf->prm->ins + i;
+		ins = bvf->prm->raw.ins + i;
 
 		if (node->colour == WHITE &&
 				ins->code != (BPF_LD | BPF_IMM | EBPF_DW))
@@ -1966,7 +1966,7 @@ log_loop(const struct bpf_verifier *bvf)
 	uint32_t i, j;
 	struct inst_node *node;
 
-	for (i = 0; i != bvf->prm->nb_ins; i++) {
+	for (i = 0; i != bvf->prm->raw.nb_ins; i++) {
 
 		node = bvf->in + i;
 		if (node->colour != BLACK)
@@ -1998,9 +1998,9 @@ validate(struct bpf_verifier *bvf)
 	const char *err;
 
 	rc = 0;
-	for (i = 0; i < bvf->prm->nb_ins; i++) {
+	for (i = 0; i < bvf->prm->raw.nb_ins; i++) {
 
-		ins = bvf->prm->ins + i;
+		ins = bvf->prm->raw.ins + i;
 		node = bvf->in + i;
 
 		err = check_syntax(ins);
@@ -2432,7 +2432,7 @@ evaluate(struct bpf_verifier *bvf)
 
 	bvf->evst->rv[EBPF_REG_10] = rvfp;
 
-	ins = bvf->prm->ins;
+	ins = bvf->prm->raw.ins;
 	node = bvf->in;
 	next = node;
 	rc = 0;
@@ -2522,23 +2522,23 @@ evaluate(struct bpf_verifier *bvf)
 }
 
 int
-__rte_bpf_validate(struct rte_bpf *bpf)
+__rte_bpf_validate(const struct rte_bpf_prm_ex *prm, uint32_t *stack_sz)
 {
 	int32_t rc;
 	struct bpf_verifier bvf;
 
 	/* check input argument type, don't allow mbuf ptr on 32-bit */
-	if (bpf->prm.prog_arg.type != RTE_BPF_ARG_RAW &&
-			bpf->prm.prog_arg.type != RTE_BPF_ARG_PTR &&
+	if (prm->prog_arg.type != RTE_BPF_ARG_RAW &&
+			prm->prog_arg.type != RTE_BPF_ARG_PTR &&
 			(sizeof(uint64_t) != sizeof(uintptr_t) ||
-			bpf->prm.prog_arg.type != RTE_BPF_ARG_PTR_MBUF)) {
+			prm->prog_arg.type != RTE_BPF_ARG_PTR_MBUF)) {
 		RTE_BPF_LOG_FUNC_LINE(ERR, "unsupported argument type");
 		return -ENOTSUP;
 	}
 
 	memset(&bvf, 0, sizeof(bvf));
-	bvf.prm = &bpf->prm;
-	bvf.in = calloc(bpf->prm.nb_ins, sizeof(bvf.in[0]));
+	bvf.prm = prm;
+	bvf.in = calloc(prm->raw.nb_ins, sizeof(bvf.in[0]));
 	if (bvf.in == NULL)
 		return -ENOMEM;
 
@@ -2555,11 +2555,11 @@ __rte_bpf_validate(struct rte_bpf *bpf)
 
 	/* copy collected info */
 	if (rc == 0) {
-		bpf->stack_sz = bvf.stack_sz;
+		*stack_sz = bvf.stack_sz;
 
 		/* for LD_ABS/LD_IND, we'll need extra space on the stack */
 		if (bvf.nb_ldmb_nodes != 0)
-			bpf->stack_sz = RTE_ALIGN_CEIL(bpf->stack_sz +
+			*stack_sz = RTE_ALIGN_CEIL(*stack_sz +
 				sizeof(uint64_t), sizeof(uint64_t));
 	}
 
diff --git a/lib/bpf/meson.build b/lib/bpf/meson.build
index 28df7f469a4c..4901b6ee1463 100644
--- a/lib/bpf/meson.build
+++ b/lib/bpf/meson.build
@@ -19,6 +19,7 @@ sources = files('bpf.c',
         'bpf_dump.c',
         'bpf_exec.c',
         'bpf_load.c',
+        'bpf_load_elf.c',
         'bpf_pkt.c',
         'bpf_stub.c',
         'bpf_validate.c')
@@ -38,10 +39,9 @@ deps += ['mbuf', 'net', 'ethdev']
 dep = dependency('libelf', required: false, method: 'pkg-config')
 if dep.found()
     dpdk_conf.set('RTE_LIBRTE_BPF_ELF', 1)
-    sources += files('bpf_load_elf.c')
     ext_deps += dep
 else
-    warning('libelf is missing, rte_bpf_elf_load API will be disabled')
+    warning('libelf is missing, ELF API will be disabled')
 endif
 
 if dpdk_conf.has('RTE_HAS_LIBPCAP')
diff --git a/lib/bpf/rte_bpf.h b/lib/bpf/rte_bpf.h
index 309d84bc516a..bf58a418191e 100644
--- a/lib/bpf/rte_bpf.h
+++ b/lib/bpf/rte_bpf.h
@@ -86,7 +86,47 @@ struct rte_bpf_xsym {
 };
 
 /**
- * Input parameters for loading eBPF code.
+ * Possible origins of eBPF program code.
+ */
+enum rte_bpf_origin {
+	RTE_BPF_ORIGIN_RAW,		/**< code loaded from raw array */
+	RTE_BPF_ORIGIN_RESERVED,	/**< reserved for cBPF */
+	RTE_BPF_ORIGIN_ELF_FILE,	/**< code loaded from elf_file */
+};
+
+/**
+ * Input parameters for loading eBPF code, extensible version.
+ *
+ * Follows libbpf conventions for extensible structs.
+ */
+struct rte_bpf_prm_ex {
+	size_t sz;  /**< size of this struct for backward compatibility */
+
+	uint32_t flags;  /**< flags controlling eBPF load and other options */
+
+	enum rte_bpf_origin origin;  /**< origin of eBPF program code */
+
+	/** program origin parameters, member in use depends on origin */
+	union {
+		struct {
+			const struct ebpf_insn *ins;  /**< eBPF instructions */
+			uint32_t nb_ins;  /**< number of instructions in ins */
+		} raw;
+		struct {
+			const char *path;  /**< path to the ELF file */
+			const char *section;  /**< ELF section with the code */
+		} elf_file;
+	};
+
+	const struct rte_bpf_xsym *xsym;
+	/**< array of external symbols that eBPF code is allowed to reference */
+	uint32_t nb_xsym;  /**< number of elements in xsym */
+
+	struct rte_bpf_arg prog_arg;  /**< input arg description */
+};
+
+/**
+ * Input parameters for loading eBPF code, legacy version.
  */
 struct rte_bpf_prm {
 	const struct ebpf_insn *ins; /**< array of eBPF instructions */
@@ -116,6 +156,32 @@ struct rte_bpf;
 void
 rte_bpf_destroy(struct rte_bpf *bpf);
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: This API may change, or be removed, without prior notice.
+ *
+ * Create a new eBPF execution context, load code from specified origin into it.
+ *
+ * @param prm
+ *   Parameters used to create and initialise the BPF execution context.
+ *
+ *   Member sz must be set to the struct size as known to the application.
+ *   If it exceeds the size known to the library, and the extra part has
+ *   non-zero bytes, parameter is rejected. If it's smaller than the size known
+ *   to the library, defaults are used for the members that are not present.
+ * @return
+ *   BPF handle that is used in future BPF operations,
+ *   or NULL on error, with error code set in rte_errno.
+ *   Possible rte_errno errors include:
+ *   - EINVAL  - invalid parameter passed to function
+ *   - ENOMEM  - can't reserve enough memory
+ *   - ENOTSUP - requested feature is not supported (e.g. no libelf to load ELF)
+ */
+__rte_experimental
+struct rte_bpf *
+rte_bpf_load_ex(const struct rte_bpf_prm_ex *prm)
+	__rte_malloc __rte_dealloc(rte_bpf_destroy, 1);
+
 /**
  * Create a new eBPF execution context and load given BPF code into it.
  *
-- 
2.43.0

