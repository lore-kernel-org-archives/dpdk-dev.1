Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21858D116F1
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Dec 2025 12:45:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D74364029C;
	Mon,  1 Dec 2025 13:45:36 +0100 (CET)
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
 by mails.dpdk.org (Postfix) with ESMTP id 9652A40261
 for <dev@dpdk.org>; Mon,  1 Dec 2025 13:45:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
 s=s201512; t=1764593131;
 bh=tiMu2pW1LmMcU+58yuPQNRoCXPM6YgAqzsZx4MPnJbs=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=BYsrVudBPhn5j1qKvqak1NrtPpj9mh5Ono/ygjoq/tzoGz/5WlCcKvb/8AVjRzhCz
 u7vo9fmZvv41nSnx6KLHl7mKsRUteEo2jHoZXsOeWF3baHjEWLGpfQusxMq3v9/2Fz
 Y2RGGapNto87Med+N91eqoMqS8XD+f5u8EWvUO+s=
X-QQ-mid: zesmtpsz3t1764593129t0f533708
X-QQ-Originating-IP: GSe2ODfsVv9UgO/8Yhv+7ddCkBLPLxrMFcxjaJDetjI=
Received: from wyfs.. ( [11.176.19.22]) by bizesmtp.qq.com (ESMTP) with 
 id ; Mon, 01 Dec 2025 20:45:22 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 3376244554986283192
From: "=?gb18030?B?bWFubnl3YW5nKM3108C35Sk=?=" <mannywang@tencent.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org,
	YongFeng Wang <mannywang@tencent.com>
Subject: [PATCH v5] acl: support custom memory allocators in rte_acl_build
Date: Mon,  1 Dec 2025 12:45:17 +0000
Message-ID: <2AAF65CF8F892CB1+20251201124518.122734-1-mannywang@tencent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <db4d85aea29e4549b04750288db649c3@huawei.com>
References: <db4d85aea29e4549b04750288db649c3@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:tencent.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NnvXaJ5yySl8b90qOc6qEx4V1RsWtE+OSNnIxuINLOXHhgff6sMrbGh/
 oNZLnfhMI4F2xzLJekmsXCkkLjYMjLWhAED57FxsYMN9Qv15NjJzmEzVzOoOotWOgw6PE8G
 FXwT0oEdZSS2OGdRi+4SN8hXgy8HEuigqTEJkB+fWNp8QvkR+hfCAVS9+SG9G7Nhcws4d11
 VqH/90b+WU9DSILWIKWa/2N2Co4twoNcRbxVAEQxDsGf7omS/wRbDH7HCnsyleHmvj2TpoP
 opOEWs+sdXMs5deNWjrV8dzZztkFBOpyB31ZCfN0TTWKYd6lWmqgj/YegXe1wvNE6JAsxoe
 NbHhpJ92SFb9Yjv0cGGbvaLkoLND/+3PeUxF4Ar0908iqxRhNziIpaGdV/jFcsYfbAIbBWR
 BSGN3caoaasAgfba/41jpHosUqr3qK2NnS76T+NcmCvSIdEeOsXO9Lu0hzyd84B8Sdw+kc4
 f64nALwNSHhfYUUy3gMbZ9MSeG8qCEol0wEG1CTljsWrDSjknjgssDoX/f3RrgAm/0oc92/
 Yh4W/9W9+6sJoddvJNcz41Abwy5KF24JOsMkIsAk1KlDI5CXzh9v6//pn3GWmVtGyL2pgtm
 rpeETuPF3B13MQCOgnG8+R+l/gM6ntxJG1ZWmr3lG25yIX8FUZQVcoyDuVFkjfJeQVmGbYi
 AEiUv46yN+uRXLTCRNnHif6nkhWHvWhgj3u4ifySq0F5C/lPvaIx1phAQ2ExI3e3kTz6bsb
 R104UN3yQWmtXau7a3y13OhWTcyOQ3bqoavcGT9qRqWnCNzTIHVMOcWT1062ODCB24OiFVA
 J38bJq6wy84024x7FK7uMUln735cBwTEEYNXpeG+hJCAC86Gz6wQzSrK2BHRs8FKekEZdTz
 CrYMfRYK/ZSQyhaD4HvKBk3IE3sODNwddqYOfN6TrB7B3gJKKknz5k2eEcKrDLUtdwxrc/t
 YXq2rXZo8pZEiVgiYFOz8Y9ycYem18rhYECPKbYDETWA9ytOdUEIWLbxKijav15ii6KvZqs
 clD6EK+P9ckjgxy3vzqzrvG0Zq2k09D2YoI5XAxA==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
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
memory allocation callbacks for runtime memory in rte_acl_ctx, via
struct rte_acl_mem_cb.

Key changes:
- Added struct rte_acl_mem_cb with zalloc, free, and udata.
- Added rte_acl_set_mem_cb() / rte_acl_get_mem_cb() to set/get callbacks.
- Default allocation uses existing rte_zmalloc_socket/rte_free.
- Modified ACL code to call callbacks for runtime allocations instead
  of rte_zmalloc_socket/rte_free directly.

v5:
- Remove temporary memory allocation callback for build stage.
- Introduce new API (rte_acl_set_mem_cb / rte_acl_get_mem_cb) instead of
  modifying existing rte_acl_config to preserve ABI compatibility.

Signed-off-by: YongFeng Wang <mannywang@tencent.com>
---
 app/test/test_acl.c | 121 ++++++++++++++++++++++++++++++++++++++++++++
 lib/acl/acl.h       |   1 +
 lib/acl/acl_bld.c   |   2 +-
 lib/acl/acl_gen.c   |   4 +-
 lib/acl/rte_acl.c   |  45 +++++++++++++++-
 lib/acl/rte_acl.h   |  42 +++++++++++++++
 6 files changed, 211 insertions(+), 4 deletions(-)

diff --git a/app/test/test_acl.c b/app/test/test_acl.c
index 43d13b5b0f..930fdf8362 100644
--- a/app/test/test_acl.c
+++ b/app/test/test_acl.c
@@ -1721,6 +1721,125 @@ test_u32_range(void)
 	return rc;
 }
 
+struct acl_ctx_wrapper_t {
+	struct rte_acl_ctx *ctx;
+	void *running_buf;
+	bool running_buf_using;
+};
+
+#define ACL_RUNNING_BUF_SIZE (10 * 1024 * 1024)
+
+static void *running_alloc(void *udata, char *name, size_t size,
+	size_t align, int32_t socket_id)
+{
+	(void)align;
+	(void)name;
+	(void)socket_id;
+	if (size > ACL_RUNNING_BUF_SIZE)
+		return NULL;
+	struct acl_ctx_wrapper_t *gwlb_acl_ctx = (struct acl_ctx_wrapper_t *)udata;
+	if (gwlb_acl_ctx->running_buf_using)
+		return NULL;
+	printf("running memory alloc for acl context, size=%zu, pointer=%p\n",
+		size,
+		gwlb_acl_ctx->running_buf);
+	memset(gwlb_acl_ctx->running_buf, 0, size);
+	gwlb_acl_ctx->running_buf_using = true;
+	return gwlb_acl_ctx->running_buf;
+}
+
+static void running_free(void *udata, void *ptr)
+{
+	if (!ptr)
+		return;
+	struct acl_ctx_wrapper_t *gwlb_acl_ctx = (struct acl_ctx_wrapper_t *)udata;
+	printf("running memory free, pointer=%p\n", ptr);
+	gwlb_acl_ctx->running_buf_using = false;
+}
+
+static int
+test_mem_cb(void)
+{
+	int i, ret;
+	struct acl_ctx_wrapper_t g_acl_ctx_wrapper;
+	g_acl_ctx_wrapper.ctx = rte_acl_create(&acl_param);
+	if (g_acl_ctx_wrapper.ctx == NULL) {
+		printf("Line %i: Error creating ACL context!\n", __LINE__);
+		return -1;
+	}
+	g_acl_ctx_wrapper.running_buf = rte_zmalloc_socket(
+		"test_acl",
+		ACL_RUNNING_BUF_SIZE,
+		RTE_CACHE_LINE_SIZE,
+		SOCKET_ID_ANY);
+	if (!g_acl_ctx_wrapper.running_buf) {
+		printf("Line %i: Error allocing running buf for acl context!\n", __LINE__);
+		return 1;
+	}
+	g_acl_ctx_wrapper.running_buf_using = false;
+
+	struct rte_acl_mem_cb mcb = {
+		.zalloc = running_alloc,
+		.free = running_free,
+		.udata = &g_acl_ctx_wrapper
+	};
+	ret = rte_acl_set_mem_cb(g_acl_ctx_wrapper.ctx, &mcb);
+	if (ret) {
+		printf("Line %i: Error set mem cb for acl context!\n", __LINE__);
+		return 1;
+	}
+	struct rte_acl_mem_cb new_mcb;
+	memset(&new_mcb, 0, sizeof(struct rte_acl_mem_cb));
+	ret = rte_acl_get_mem_cb(g_acl_ctx_wrapper.ctx, &new_mcb);
+	if (ret) {
+		printf("Line %i: Error get mem cb for acl context!\n", __LINE__);
+		return 1;
+	}
+	if (memcmp(&mcb, &new_mcb, sizeof(struct rte_acl_mem_cb)) != 0) {
+		printf("Line %i: Error get mem cb for acl context!\n", __LINE__);
+		return 1;
+	}
+	ret = 0;
+	for (i = 0; i != TEST_CLASSIFY_ITER; i++) {
+
+		if ((i & 1) == 0)
+			rte_acl_reset(g_acl_ctx_wrapper.ctx);
+		else
+			rte_acl_reset_rules(g_acl_ctx_wrapper.ctx);
+
+		ret = test_classify_buid(g_acl_ctx_wrapper.ctx, acl_test_rules,
+			RTE_DIM(acl_test_rules));
+		if (ret != 0) {
+			printf("Line %i, iter: %d: "
+				"Adding rules to ACL context failed!\n",
+				__LINE__, i);
+			break;
+		}
+
+		ret = test_classify_run(g_acl_ctx_wrapper.ctx, acl_test_data,
+			RTE_DIM(acl_test_data));
+		if (ret != 0) {
+			printf("Line %i, iter: %d: %s failed!\n",
+				__LINE__, i, __func__);
+			break;
+		}
+
+		/* reset rules and make sure that classify still works ok. */
+		rte_acl_reset_rules(g_acl_ctx_wrapper.ctx);
+		ret = test_classify_run(g_acl_ctx_wrapper.ctx, acl_test_data,
+			RTE_DIM(acl_test_data));
+		if (ret != 0) {
+			printf("Line %i, iter: %d: %s failed!\n",
+				__LINE__, i, __func__);
+			break;
+		}
+	}
+
+	rte_acl_free(g_acl_ctx_wrapper.ctx);
+	rte_free(g_acl_ctx_wrapper.running_buf);
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
+	if (test_mem_cb() < 0)
+		return -1;
 
 	return 0;
 }
diff --git a/lib/acl/acl.h b/lib/acl/acl.h
index c8e4e72fab..3acfc0cb9f 100644
--- a/lib/acl/acl.h
+++ b/lib/acl/acl.h
@@ -174,6 +174,7 @@ struct rte_acl_ctx {
 	uint32_t            max_rules;
 	uint32_t            rule_sz;
 	uint32_t            num_rules;
+	struct rte_acl_mem_cb mem_cb;
 	uint32_t            num_categories;
 	uint32_t            num_tries;
 	uint32_t            match_index;
diff --git a/lib/acl/acl_bld.c b/lib/acl/acl_bld.c
index 7056b1c117..e3d342bd79 100644
--- a/lib/acl/acl_bld.c
+++ b/lib/acl/acl_bld.c
@@ -779,7 +779,7 @@ acl_merge_trie(struct acl_build_context *context,
 static void
 acl_build_reset(struct rte_acl_ctx *ctx)
 {
-	rte_free(ctx->mem);
+	ctx->mem_cb.free(ctx->mem_cb.udata, ctx->mem);
 	memset(&ctx->num_categories, 0,
 		sizeof(*ctx) - offsetof(struct rte_acl_ctx, num_categories));
 }
diff --git a/lib/acl/acl_gen.c b/lib/acl/acl_gen.c
index 3c53d24056..f482317884 100644
--- a/lib/acl/acl_gen.c
+++ b/lib/acl/acl_gen.c
@@ -478,8 +478,8 @@ rte_acl_gen(struct rte_acl_ctx *ctx, struct rte_acl_trie *trie,
 		return -ERANGE;
 	}
 
-	mem = rte_zmalloc_socket(ctx->name, total_size, RTE_CACHE_LINE_SIZE,
-			ctx->socket_id);
+	mem = ctx->mem_cb.zalloc(ctx->mem_cb.udata, ctx->name, total_size,
+			RTE_CACHE_LINE_SIZE, ctx->socket_id);
 	if (mem == NULL) {
 		ACL_LOG(ERR,
 			"allocation of %zu bytes on socket %d for %s failed",
diff --git a/lib/acl/rte_acl.c b/lib/acl/rte_acl.c
index 8c0ca29618..3c1a118c46 100644
--- a/lib/acl/rte_acl.c
+++ b/lib/acl/rte_acl.c
@@ -264,6 +264,20 @@ acl_get_best_alg(void)
 	return alg[i];
 }
 
+static void *
+zalloc_dft(void *udata, char *name, size_t size, size_t align, int32_t socket_id)
+{
+	(void)udata;
+	return rte_zmalloc_socket(name, size, align, socket_id);
+}
+
+static void
+free_dft(void *udata, void *ptr)
+{
+	(void)udata;
+	rte_free(ptr);
+}
+
 RTE_EXPORT_SYMBOL(rte_acl_set_ctx_classify)
 extern int
 rte_acl_set_ctx_classify(struct rte_acl_ctx *ctx, enum rte_acl_classify_alg alg)
@@ -362,7 +376,7 @@ rte_acl_free(struct rte_acl_ctx *ctx)
 
 	rte_mcfg_tailq_write_unlock();
 
-	rte_free(ctx->mem);
+	ctx->mem_cb.free(ctx->mem_cb.udata, ctx->mem);
 	rte_free(ctx);
 	rte_free(te);
 }
@@ -425,6 +439,9 @@ rte_acl_create(const struct rte_acl_param *param)
 		ctx->rule_sz = param->rule_size;
 		ctx->socket_id = param->socket_id;
 		ctx->alg = acl_get_best_alg();
+		ctx->mem_cb.zalloc = zalloc_dft;
+		ctx->mem_cb.free = free_dft;
+		ctx->mem_cb.udata = NULL;
 		strlcpy(ctx->name, param->name, sizeof(ctx->name));
 
 		te->data = (void *) ctx;
@@ -555,3 +572,29 @@ rte_acl_list_dump(void)
 	}
 	rte_mcfg_tailq_read_unlock();
 }
+
+/*
+ * Set memory allocation callbacks for a given ACL context.
+ */
+RTE_EXPORT_SYMBOL(rte_acl_set_mem_cb)
+int
+rte_acl_set_mem_cb(struct rte_acl_ctx *acl, const struct rte_acl_mem_cb *mcb)
+{
+	if (!acl || !mcb || !mcb->zalloc || !mcb->free)
+		return -EINVAL;
+	memcpy(&acl->mem_cb, mcb, sizeof(struct rte_acl_mem_cb));
+	return 0;
+}
+
+/*
+ * Retrieve the memory allocation callbacks assigned to the ACL context.
+ */
+RTE_EXPORT_SYMBOL(rte_acl_get_mem_cb)
+int
+rte_acl_get_mem_cb(const struct rte_acl_ctx *acl, struct rte_acl_mem_cb *mcb)
+{
+	if (!acl || !mcb)
+		return -EINVAL;
+	memcpy(mcb, &acl->mem_cb, sizeof(struct rte_acl_mem_cb));
+	return 0;
+}
diff --git a/lib/acl/rte_acl.h b/lib/acl/rte_acl.h
index 95354cabb8..e3273556e2 100644
--- a/lib/acl/rte_acl.h
+++ b/lib/acl/rte_acl.h
@@ -136,6 +136,48 @@ struct rte_acl_param {
 /** @internal opaque ACL handle */
 struct rte_acl_ctx;
 
+/**
+ * Memory allocation callbacks for ACL runtime.
+ */
+struct rte_acl_mem_cb {
+	/** Allocate zero-initialized memory used during runtime. */
+	void *(*zalloc)(void *udata, char *name, size_t size, size_t align, int32_t socket_id);
+
+	/** Free memory previously allocated by zalloc(). */
+	void (*free)(void *udata, void *ptr);
+
+	/** User-provided context passed to allocation/free callbacks. */
+	void *udata;
+};
+
+/**
+ * Set memory allocation callbacks for a given ACL context.
+ *
+ * @param acl
+ *   The ACL context.
+ * @param mcb
+ *   Pointer to the memory callback structure
+ *
+ * @return
+ *   0 on success.
+ *   -EINVAL if parameters are invalid.
+ */
+int rte_acl_set_mem_cb(struct rte_acl_ctx *acl, const struct rte_acl_mem_cb *mcb);
+
+/**
+ * Retrieve the memory allocation callbacks assigned to the ACL context.
+ *
+ * @param acl
+ *   The ACL context.
+ * @param mcb
+ *   Output location for the current memory callback structure
+ *
+ * @return
+ *   0 on success.
+ *   -EINVAL if parameters are invalid.
+ */
+int rte_acl_get_mem_cb(const struct rte_acl_ctx *acl, struct rte_acl_mem_cb *mcb);
+
 /**
  * De-allocate all memory used by ACL context.
  *
-- 
2.43.0

