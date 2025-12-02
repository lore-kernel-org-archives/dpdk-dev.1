Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8BEFCFD2F6
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Dec 2025 09:25:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CEBC040268;
	Tue,  2 Dec 2025 10:25:16 +0100 (CET)
Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
 by mails.dpdk.org (Postfix) with ESMTP id 072BD400D5
 for <dev@dpdk.org>; Tue,  2 Dec 2025 10:25:13 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
 s=s201512; t=1764667510;
 bh=jsfRRNvY1tRUaCZ3eHsNv/B6nuWNrPmywtsptWYk4GU=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=vLX2JjHsFH3eFpo6++I05BdLHTw1nowTh4P2r8brcLtqVNqDo5/zBol1quRM64BUO
 ehCltHa3DGESpPhaSEM+zuvHu3aSRcndmxtVIAQXN3ebwI/ygGHduFk24GPVEbr9hz
 jpJcEQDVcU7aYujLpxjtUQbhBObkkjVJFAd1kIss=
X-QQ-mid: esmtpgz11t1764667507t4833a531
X-QQ-Originating-IP: 6Ly6xRhf93C7nTZEi1LTvAe8ICxVu1uLYiOTMtOQUr4=
Received: from wyfs.. ( [11.176.19.22]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 02 Dec 2025 17:25:05 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8223132572772222185
From: "=?gb18030?B?bWFubnl3YW5nKM3108C35Sk=?=" <mannywang@tencent.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org,
	YongFeng Wang <mannywang@tencent.com>
Subject: [PATCH v6] acl: support custom memory allocators
Date: Tue,  2 Dec 2025 09:25:02 +0000
Message-ID: <BFA8D0B9488D3A67+20251202092502.165081-1-mannywang@tencent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <58cca566-08bd-469e-b244-1800e0456cb0@huawei.com>
References: <58cca566-08bd-469e-b244-1800e0456cb0@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:tencent.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Noqpd7YRZnx107lYqpjNKXmaJVZLOZ49RK6II2NvxMW33scdEatYvqyD
 mTs6FXWStr1Ff+q6RmXluZ+Ib8B88SA2kTTsxNojxsO9QAM8HXeekMEdrzrxROF0iLZjFpe
 tcu8VbnmrpLAeSFv+fY52VXAOIXvkhxaddE4MK9FUrYBZGZhZIBmOqVxqLXRJqDXk0u7BvI
 uqpDdZP4fac3RsmYp5nLGqDNtwBPrAom7dWG/tQzs81HDGkiAXQS47SS057HjdSFBb9sQZw
 ekVatT6Tmznhc18IcjQKeUcacpD7GjjHuLK3ToElochDGFQk47uVWQHyVrvaCs0obuTwNOe
 sz0n4nQowef0X403V+J8bJX1puZz0+YdN48Jmf5MqgcvKn3dRmptj9F5YVuUZ6byR5Au2Wf
 ifRWigPu+4QfAOlFjUS2WLqoe124xBImmWC6oE1dE82OzwExvyzcxkhzUbQX8TrrgdQyu8r
 JxY+I6j+5ShVax9ezvBWrZifagBylpKp+rOAbLZrsCel/YnHtlFaxCb5Atogh/L2kwLYaSz
 iZ+CrHIbskXNOnEEivajgPPiVi0JFFE9uNRpu6zT6W6ug+BtUI/QPk+HiOayjYBl7Hd8WvA
 VJuFzcQAD0dOb7+u2zXRPCtv0q7X9gPNB/3HhERNQTr9tGB4aohxRIhTZE7k/fHXPQZ753e
 wVQUuYpR3lZBfoa0tbUShcM9VBILOvvGx6sz6MGtnwoo/4Iqe8u920PqGJqQmaJKTpBuZJr
 JrAmPgQPqVNYdzUoG1MUT6UJ4yBtnI7++mob3sB0g682+lUEltNyF+KoxmumnKJ+gXuIYJy
 Zlkmv83/rgQmQ6kYuHYYlMgoMhl04/4CRvxuLVSsZSdVj1vM98+wHoi/8yjsHOP3JFOAVdv
 jZLWGf5DyUUoIKjh/ESz1Ed6e4VA2aa4lE5jj91CkYco4jC62spZueq4v7VZahXRHSAPf9Y
 UORbpiMFFtXglH1ngrMfhyrMlBuhEFphJ2vA=
X-QQ-XMRINFO: NyFYKkN4Ny6FSmKK/uo/jdU=
X-QQ-RECHKSPAM: 0
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

Allow users to provide custom
memory allocation hooks for runtime memory in rte_acl_ctx, via
struct rte_acl_mem_hook.

Key changes:
- Added struct rte_acl_mem_hook with zalloc, free, and udata.
- Added rte_acl_set_mem_hook / rte_acl_get_mem_hook to set/get callbacks.
- Default allocation uses existing rte_zmalloc_socket/rte_free.
- Modified ACL code to call callbacks for runtime allocations instead
  of rte_zmalloc_socket/rte_free directly.

v5:
- Remove temporary memory allocation callback for build stage.
- Introduce new API (rte_acl_set_mem_hook / rte_acl_get_mem_hook)
  instead of modifying existing rte_acl_config to preserve
  ABI compatibility.

v6:
- Reworked API to meet consistency and naming conventions.
- Adjusted parameter order for better readability and alignment.
- Renamed internal variables for clarity and code consistency.

Signed-off-by: YongFeng Wang <mannywang@tencent.com>
---
 app/test/test_acl.c                           | 121 ++++++++++++++++++
 .../prog_guide/packet_classif_access_ctrl.rst |  31 +++++
 lib/acl/acl.h                                 |   1 +
 lib/acl/acl_bld.c                             |   2 +-
 lib/acl/acl_gen.c                             |   4 +-
 lib/acl/rte_acl.c                             |  45 ++++++-
 lib/acl/rte_acl.h                             |  47 +++++++
 7 files changed, 247 insertions(+), 4 deletions(-)

diff --git a/app/test/test_acl.c b/app/test/test_acl.c
index 43d13b5b0f..3c9a0cb8c0 100644
--- a/app/test/test_acl.c
+++ b/app/test/test_acl.c
@@ -1721,6 +1721,125 @@ test_u32_range(void)
 	return rc;
 }
 
+struct acl_ctx_wrapper {
+	struct rte_acl_ctx *ctx;
+	void *running_buf;
+	bool running_buf_using;
+};
+
+#define ACL_RUNNING_BUF_SIZE (10 * 1024 * 1024)
+
+static void *running_alloc(char *name, size_t size,
+	size_t align, int32_t socket_id, void *udata)
+{
+	RTE_SET_USED(align);
+	RTE_SET_USED(name);
+	RTE_SET_USED(socket_id);
+	if (size > ACL_RUNNING_BUF_SIZE)
+		return NULL;
+	struct acl_ctx_wrapper *acl_ctx = (struct acl_ctx_wrapper *)udata;
+	if (acl_ctx->running_buf_using)
+		return NULL;
+	printf("running memory alloc for acl context, size=%zu, pointer=%p\n",
+		size,
+		acl_ctx->running_buf);
+	memset(acl_ctx->running_buf, 0, size);
+	acl_ctx->running_buf_using = true;
+	return acl_ctx->running_buf;
+}
+
+static void running_free(void *ptr, void *udata)
+{
+	if (!ptr)
+		return;
+	struct acl_ctx_wrapper *acl_ctx = (struct acl_ctx_wrapper *)udata;
+	printf("running memory free, pointer=%p\n", ptr);
+	acl_ctx->running_buf_using = false;
+}
+
+static int
+test_mem_hook(void)
+{
+	int i, ret;
+	struct acl_ctx_wrapper acl_ctx_wrapper = {0};
+	acl_ctx_wrapper.ctx = rte_acl_create(&acl_param);
+	if (acl_ctx_wrapper.ctx == NULL) {
+		printf("Line %i: Error creating ACL context!\n", __LINE__);
+		return -1;
+	}
+	acl_ctx_wrapper.running_buf = rte_zmalloc_socket(
+		"test_acl",
+		ACL_RUNNING_BUF_SIZE,
+		RTE_CACHE_LINE_SIZE,
+		SOCKET_ID_ANY);
+	if (!acl_ctx_wrapper.running_buf) {
+		rte_acl_free(acl_ctx_wrapper.ctx);
+		printf("Line %i: Error allocing running buf for acl context!\n", __LINE__);
+		return 1;
+	}
+	acl_ctx_wrapper.running_buf_using = false;
+
+	struct rte_acl_mem_hook mhook = {
+		.zalloc = running_alloc,
+		.free = running_free,
+		.udata = &acl_ctx_wrapper
+	};
+	ret = rte_acl_set_mem_hook(acl_ctx_wrapper.ctx, &mhook);
+	if (ret != 0) {
+		printf("Line %i: Error set mem hook for acl context!\n", __LINE__);
+		rte_acl_free(acl_ctx_wrapper.ctx);
+		rte_free(acl_ctx_wrapper.running_buf);
+		return 1;
+	}
+	struct rte_acl_mem_hook new_hook;
+	memset(&new_hook, 0, sizeof(struct rte_acl_mem_hook));
+	if (rte_acl_get_mem_hook(acl_ctx_wrapper.ctx, &new_hook) != 0
+		|| memcmp(&mhook, &new_hook, sizeof(struct rte_acl_mem_hook)) != 0) {
+		printf("Line %i: Error get mem hook for acl context!\n", __LINE__);
+		rte_acl_free(acl_ctx_wrapper.ctx);
+		rte_free(acl_ctx_wrapper.running_buf);
+		return 1;
+	}
+	ret = 0;
+	for (i = 0; i < TEST_CLASSIFY_ITER; i++) {
+
+		if ((i & 1) == 0)
+			rte_acl_reset(acl_ctx_wrapper.ctx);
+		else
+			rte_acl_reset_rules(acl_ctx_wrapper.ctx);
+
+		ret = test_classify_buid(acl_ctx_wrapper.ctx, acl_test_rules,
+			RTE_DIM(acl_test_rules));
+		if (ret != 0) {
+			printf("Line %i, iter: %d: Adding rules to ACL context failed!\n",
+				__LINE__, i);
+			break;
+		}
+
+		ret = test_classify_run(acl_ctx_wrapper.ctx, acl_test_data,
+			RTE_DIM(acl_test_data));
+		if (ret != 0) {
+			printf("Line %i, iter: %d: %s failed!\n",
+				__LINE__, i, __func__);
+			break;
+		}
+
+		/* reset rules and make sure that classify still works ok. */
+		rte_acl_reset_rules(acl_ctx_wrapper.ctx);
+		ret = test_classify_run(acl_ctx_wrapper.ctx, acl_test_data,
+			RTE_DIM(acl_test_data));
+		if (ret != 0) {
+			printf("Line %i, iter: %d: %s failed!\n",
+				__LINE__, i, __func__);
+			break;
+		}
+	}
+
+	rte_acl_free(acl_ctx_wrapper.ctx);
+	rte_free(acl_ctx_wrapper.running_buf);
+	return ret;
+}
+
 static int
 test_acl(void)
 {
@@ -1742,6 +1861,8 @@ test_acl(void)
 		return -1;
 	if (test_u32_range() < 0)
 		return -1;
+	if (test_mem_hook() < 0)
+		return -1;
 
 	return 0;
 }
diff --git a/doc/guides/prog_guide/packet_classif_access_ctrl.rst b/doc/guides/prog_guide/packet_classif_access_ctrl.rst
index 172f443f6e..55b2018db9 100644
--- a/doc/guides/prog_guide/packet_classif_access_ctrl.rst
+++ b/doc/guides/prog_guide/packet_classif_access_ctrl.rst
@@ -359,7 +359,38 @@ For example:
         ret = rte_acl_build(acx, &cfg);
      }
 
+Custom Memory Hooks
+~~~~~~~~~~~~~~~~~~~~
+
+The ACL library supports custom memory allocation for runtime structures.
+Applications can supply their own memory hooks through:
+
+.. code-block:: c
+
+    int rte_acl_set_mem_hook(struct rte_acl_ctx *ctx,
+                           const struct rte_acl_mem_hook *mhook);
+
+    int rte_acl_get_mem_hook(const struct rte_acl_ctx *ctx,
+                           struct rte_acl_mem_hook *mhook);
+
+The ``rte_acl_mem_hook`` structure defines memory hooks:
+
+.. code-block:: c
+
+    struct rte_acl_mem_hook {
+        /** Allocate zero-initialized memory used during runtime. */
+        void *(*zalloc)(char *name, size_t size, size_t align, int32_t socket_id, void *udata);
+
+        /** Free memory previously allocated by zalloc(). */
+        void (*free)(void *ptr, void *udata);
+
+        /** User-provided context passed to allocation/free hooks. */
+        void *udata;
+    };
+
+Applications may use these hooks to allocate memory from custom pools or pre-allocated buffers.
 
+If no memory hook is provided, the ACL library uses rte_zmalloc_socket() internally.
 
 Classification methods
 ~~~~~~~~~~~~~~~~~~~~~~
diff --git a/lib/acl/acl.h b/lib/acl/acl.h
index c8e4e72fab..9c85a3d58a 100644
--- a/lib/acl/acl.h
+++ b/lib/acl/acl.h
@@ -174,6 +174,7 @@ struct rte_acl_ctx {
 	uint32_t            max_rules;
 	uint32_t            rule_sz;
 	uint32_t            num_rules;
+	struct rte_acl_mem_hook mem_hook;
 	uint32_t            num_categories;
 	uint32_t            num_tries;
 	uint32_t            match_index;
diff --git a/lib/acl/acl_bld.c b/lib/acl/acl_bld.c
index 7056b1c117..99d1dbc467 100644
--- a/lib/acl/acl_bld.c
+++ b/lib/acl/acl_bld.c
@@ -779,7 +779,7 @@ acl_merge_trie(struct acl_build_context *context,
 static void
 acl_build_reset(struct rte_acl_ctx *ctx)
 {
-	rte_free(ctx->mem);
+	ctx->mem_hook.free(ctx->mem, ctx->mem_hook.udata);
 	memset(&ctx->num_categories, 0,
 		sizeof(*ctx) - offsetof(struct rte_acl_ctx, num_categories));
 }
diff --git a/lib/acl/acl_gen.c b/lib/acl/acl_gen.c
index 3c53d24056..77f19dd13a 100644
--- a/lib/acl/acl_gen.c
+++ b/lib/acl/acl_gen.c
@@ -478,8 +478,8 @@ rte_acl_gen(struct rte_acl_ctx *ctx, struct rte_acl_trie *trie,
 		return -ERANGE;
 	}
 
-	mem = rte_zmalloc_socket(ctx->name, total_size, RTE_CACHE_LINE_SIZE,
-			ctx->socket_id);
+	mem = ctx->mem_hook.zalloc(ctx->name, total_size,
+			RTE_CACHE_LINE_SIZE, ctx->socket_id, ctx->mem_hook.udata);
 	if (mem == NULL) {
 		ACL_LOG(ERR,
 			"allocation of %zu bytes on socket %d for %s failed",
diff --git a/lib/acl/rte_acl.c b/lib/acl/rte_acl.c
index 8c0ca29618..3f2b194206 100644
--- a/lib/acl/rte_acl.c
+++ b/lib/acl/rte_acl.c
@@ -264,6 +264,20 @@ acl_get_best_alg(void)
 	return alg[i];
 }
 
+static void *
+acl_mem_default_zalloc(char *name, size_t size, size_t align, int32_t socket_id, void *udata)
+{
+	RTE_SET_USED(udata);
+	return rte_zmalloc_socket(name, size, align, socket_id);
+}
+
+static void
+acl_mem_default_free(void *ptr, void *udata)
+{
+	RTE_SET_USED(udata);
+	rte_free(ptr);
+}
+
 RTE_EXPORT_SYMBOL(rte_acl_set_ctx_classify)
 extern int
 rte_acl_set_ctx_classify(struct rte_acl_ctx *ctx, enum rte_acl_classify_alg alg)
@@ -362,7 +376,7 @@ rte_acl_free(struct rte_acl_ctx *ctx)
 
 	rte_mcfg_tailq_write_unlock();
 
-	rte_free(ctx->mem);
+	ctx->mem_hook.free(ctx->mem, ctx->mem_hook.udata);
 	rte_free(ctx);
 	rte_free(te);
 }
@@ -425,6 +439,9 @@ rte_acl_create(const struct rte_acl_param *param)
 		ctx->rule_sz = param->rule_size;
 		ctx->socket_id = param->socket_id;
 		ctx->alg = acl_get_best_alg();
+		ctx->mem_hook.zalloc = acl_mem_default_zalloc;
+		ctx->mem_hook.free = acl_mem_default_free;
+		ctx->mem_hook.udata = NULL;
 		strlcpy(ctx->name, param->name, sizeof(ctx->name));
 
 		te->data = (void *) ctx;
@@ -555,3 +572,29 @@ rte_acl_list_dump(void)
 	}
 	rte_mcfg_tailq_read_unlock();
 }
+
+/*
+ * Set memory allocation hooks for a given ACL context.
+ */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_acl_set_mem_hook, 26.03)
+int
+rte_acl_set_mem_hook(struct rte_acl_ctx *acl, const struct rte_acl_mem_hook *mhook)
+{
+	if (acl == NULL || mhook == NULL || mhook->zalloc  == NULL || mhook->free == NULL)
+		return -EINVAL;
+	memcpy(&acl->mem_hook, mhook, sizeof(struct rte_acl_mem_hook));
+	return 0;
+}
+
+/*
+ * Retrieve the memory allocation hooks assigned to the ACL context.
+ */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_acl_get_mem_hook, 26.03)
+int
+rte_acl_get_mem_hook(const struct rte_acl_ctx *acl, struct rte_acl_mem_hook *mhook)
+{
+	if (acl  == NULL || mhook == NULL)
+		return -EINVAL;
+	memcpy(mhook, &acl->mem_hook, sizeof(struct rte_acl_mem_hook));
+	return 0;
+}
diff --git a/lib/acl/rte_acl.h b/lib/acl/rte_acl.h
index 95354cabb8..5cae733a65 100644
--- a/lib/acl/rte_acl.h
+++ b/lib/acl/rte_acl.h
@@ -136,6 +136,53 @@ struct rte_acl_param {
 /** @internal opaque ACL handle */
 struct rte_acl_ctx;
 
+/**
+ * Memory allocation hooks for ACL runtime.
+ */
+struct rte_acl_mem_hook {
+	/** Allocate zero-initialized memory used during runtime. */
+	void *(*zalloc)(char *name, size_t size, size_t align, int32_t socket_id, void *udata);
+
+	/** Free memory previously allocated by zalloc(). */
+	void (*free)(void *ptr, void *udata);
+
+	/** User-provided context passed to allocation/free hooks. */
+	void *udata;
+};
+
+/**
+ * Set memory allocation hooks for a given ACL context.
+ *
+ * Applications may use these hooks to allocate memory from custom pools or pre-allocated buffers.
+ * If no memory hook is provided, the ACL library uses rte_zmalloc_socket() internally.
+ *
+ * @param acl
+ *   The ACL context.
+ * @param mhook
+ *   Pointer to the memory hook structure
+ *
+ * @return
+ *   0 on success.
+ *   -EINVAL if parameters are invalid.
+ */
+__rte_experimental
+int rte_acl_set_mem_hook(struct rte_acl_ctx *acl, const struct rte_acl_mem_hook *mhook);
+
+/**
+ * Retrieve the memory allocation hooks assigned to the ACL context.
+ *
+ * @param acl
+ *   The ACL context.
+ * @param mhook
+ *   Output location for the current memory hook structure
+ *
+ * @return
+ *   0 on success.
+ *   -EINVAL if parameters are invalid.
+ */
+__rte_experimental
+int rte_acl_get_mem_hook(const struct rte_acl_ctx *acl, struct rte_acl_mem_hook *mhook);
+
 /**
  * De-allocate all memory used by ACL context.
  *
-- 
2.43.0

