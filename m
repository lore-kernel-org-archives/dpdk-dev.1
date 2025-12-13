Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0912D59F5F
	for <dpdk-dev@archiver.kernel.org>; Sat, 13 Dec 2025 01:27:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 78C054027D;
	Sat, 13 Dec 2025 02:27:49 +0100 (CET)
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
 by mails.dpdk.org (Postfix) with ESMTP id 878F640268
 for <dev@dpdk.org>; Sat, 13 Dec 2025 02:27:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
 s=s201512; t=1765589264;
 bh=AeyK0Z64E7Vl+zG5sYlWegW06a09Sx6tLgqRre/1so0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=RIh3FFQRqGKCkpfCcnzeq/mCzNYlCBcqK2jJl7OX+uQua52M/HvoyDinFJ2vgnJjl
 9FPi0PkGS0uhHOQdEp60mV4Wsty/MjgRqRtwO3BCf3W4J7Ku0ZhWFe6qlQA5oSiesg
 g3U0S6WoeZBBrJ13ZNNLTFnzmFWDHEBjO0J84+LI=
X-QQ-mid: zesmtpgz1t1765589262t8be70a01
X-QQ-Originating-IP: 9DAbMtB5qJxn5Z0UNFWgGZvwV1djJ3Cv2Gwqrl/5G5Y=
Received: from wyfs.. ( [11.176.19.22]) by bizesmtp.qq.com (ESMTP) with 
 id ; Sat, 13 Dec 2025 09:27:38 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17282639801634809784
From: "=?gb18030?B?bWFubnl3YW5nKM3108C35Sk=?=" <mannywang@tencent.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org,
	YongFeng Wang <mannywang@tencent.com>
Subject: [PATCH v10] acl: support custom memory allocators
Date: Sat, 13 Dec 2025 01:27:35 +0000
Message-ID: <052877E03EF66856+20251213012735.34054-1-mannywang@tencent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <531B109557B40560+20251209125236.27095-1-mannywang@tencent.com>
References: <531B109557B40560+20251209125236.27095-1-mannywang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:tencent.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: NVWg0TDWOKpel8zycj0OG3UM+yPydFmrSS+MR0fUFuce2tCd3TY1QUX9
 wKpXCid7cCzYC5NEMadE6oPZ0Qjj3HrtonCMa/iEvrtrZiNFX0zCvEJNYX3trpTYonaIf33
 gNz3SxVwNM7XTGWkBIt1re8XowzC0cYDu0fiI2L8LkGtt9hvozguyHAlhkIRAmvNLZnePCS
 Yg/ADa4V7qRh99261z8LWNepJ+r1KVzIDad10o2JDQFB0WH9vS16ZI+hQ4LHyqE3m2YE2P4
 5fA1CEXvWUdpo7mA/AUWygknthk2WrKUJB9ZFmi+V/aTmcnajLFdbNomLO8SqQZVh6py0K9
 2C5t2MAzmECBLGwyqYmy4UY/605iCjzaufSsAPCt8WQbe7jS/hsJHFAqHWlbmNWGKU4utuJ
 bqF6gJ+QL6T65F/EQjJAm48gXvg4Z3nXSyUcS8i2VqIBSwaS9noaOeb15TC8Y8BDHAxaKVj
 Y1WdY8YfV0aJoCkPN4BPlVvJAnjUAutSgVAvI19uaPM5+a6ZhcX2kePtFgKe/DSUtia75R2
 l3ZpLrPKTM659aNc8szAHnPxoGQkEOEoQwYtWb6kQq4yM2fb2sAjj+BIrjnvBhwe6+nn2Tg
 drEoKC1JeF34reysYQTieCVd4HizDo5Y9c5qpbAWQoryietvGvVqpJlhZcXU85janIDdKIv
 6Z4AP4+CXPgLdsIkb3fhfYfP5i7Bd0Dc1yzV0np5VzFSmwOgv+g8OB36zYkc/iZrAMcDMXr
 IplFd3nqSiVC/zyqnMhdUmA3JLcyZO3o800Bz5VbMQVcOk4YgxwObWmVt1iuAlv3wg8KB/u
 ECftZVwDADwZHjT+YJnODht6qsk3DlT7WiU0fW8vQj8cs4Pfh2HqBopqeB6fdWJbd6zxDz8
 pM26uBJM+p/APHM5bduFS5B5SDVTm+MXpLv2I2BMBGbPNYV2tzToM5wAYL3M3yXzVrc3Pxr
 Wm8UB77DjzBAlr0rQ6kM1RlzC4ay7tZWRSszimwIV55j5WeA7gr21Fq1jFUoi3v9GJLva0N
 U/HTF3Bw==
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
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

v7:
- Switch the UT to use malloc/free.
- Update the documentation to clarify that rte_acl_set_mem_hook
  must be called before rte_acl_build.

v8:
- Fix UT code per review.

v9:
- Fix UT code per review.

v10:
- Fix memory allocation alignment issue in UT code

Signed-off-by: YongFeng Wang <mannywang@tencent.com>
---
 app/test/test_acl.c                           | 106 ++++++++++++++++++
 .../prog_guide/packet_classif_access_ctrl.rst |  31 +++++
 lib/acl/acl.h                                 |   1 +
 lib/acl/acl_bld.c                             |   2 +-
 lib/acl/acl_gen.c                             |   4 +-
 lib/acl/rte_acl.c                             |  45 +++++++-
 lib/acl/rte_acl.h                             |  53 +++++++++
 7 files changed, 238 insertions(+), 4 deletions(-)

diff --git a/app/test/test_acl.c b/app/test/test_acl.c
index 43d13b5b0f..a0dafc15fc 100644
--- a/app/test/test_acl.c
+++ b/app/test/test_acl.c
@@ -1721,6 +1721,110 @@ test_u32_range(void)
 	return rc;
 }
 
+static struct rte_acl_ctx *acl_ctx;
+
+static void *running_alloc(char *name, size_t size,
+	size_t align, int32_t socket_id, void *udata)
+{
+	size_t aligned_size = (size + align - 1) & ~(align - 1);
+	RTE_SET_USED(name);
+	RTE_SET_USED(socket_id);
+
+	if (udata != acl_ctx) {
+		printf("%s#%i udata mismatch!\n",
+			__func__, __LINE__);
+		return NULL;
+	}
+	void *addr = aligned_alloc(align, aligned_size);
+	if (addr == NULL) {
+		printf("%s#%i alloc memory failed!\n",
+			__func__, __LINE__);
+	}
+	return addr;
+}
+
+static void running_free(void *ptr, void *udata)
+{
+	if (udata != acl_ctx) {
+		printf("%s#%i udata mismatch!\n",
+			__func__, __LINE__);
+		return;
+	}
+	free(ptr);
+}
+
+static int
+test_mem_hook(void)
+{
+	int i, ret;
+	struct rte_acl_mem_hook new_hook;
+
+	acl_ctx = rte_acl_create(&acl_param);
+	if (acl_ctx == NULL) {
+		printf("Line %i: Error creating ACL context!\n", __LINE__);
+		return -1;
+	}
+
+	struct rte_acl_mem_hook mhook = {
+		.zalloc = running_alloc,
+		.free = running_free,
+		.udata = acl_ctx
+	};
+
+	ret = rte_acl_set_mem_hook(acl_ctx, &mhook);
+	if (ret != 0) {
+		printf("Line %i: Error set mem hook for acl context!\n", __LINE__);
+		rte_acl_free(acl_ctx);
+		return -1;
+	}
+
+	memset(&new_hook, 0, sizeof(struct rte_acl_mem_hook));
+	if (rte_acl_get_mem_hook(acl_ctx, &new_hook) != 0
+		|| memcmp(&mhook, &new_hook, sizeof(struct rte_acl_mem_hook)) != 0) {
+		printf("Line %i: Error get mem hook for acl context!\n", __LINE__);
+		rte_acl_free(acl_ctx);
+		return -1;
+	}
+
+	ret = 0;
+	for (i = 0; i < TEST_CLASSIFY_ITER; i++) {
+		if ((i & 1) == 0)
+			rte_acl_reset(acl_ctx);
+		else
+			rte_acl_reset_rules(acl_ctx);
+
+		ret = test_classify_buid(acl_ctx, acl_test_rules,
+			RTE_DIM(acl_test_rules));
+		if (ret != 0) {
+			printf("Line %i, iter: %d: Adding rules to ACL context failed!\n",
+				__LINE__, i);
+			break;
+		}
+
+		ret = test_classify_run(acl_ctx, acl_test_data,
+			RTE_DIM(acl_test_data));
+		if (ret != 0) {
+			printf("Line %i, iter: %d: %s failed!\n",
+				__LINE__, i, __func__);
+			break;
+		}
+
+		/* reset rules and make sure that classify still works ok. */
+		rte_acl_reset_rules(acl_ctx);
+		ret = test_classify_run(acl_ctx, acl_test_data,
+			RTE_DIM(acl_test_data));
+		if (ret != 0) {
+			printf("Line %i, iter: %d: %s failed!\n",
+				__LINE__, i, __func__);
+			break;
+		}
+	}
+
+	rte_acl_free(acl_ctx);
+	acl_ctx = NULL;
+	return ret;
+}
+
 static int
 test_acl(void)
 {
@@ -1742,6 +1846,8 @@ test_acl(void)
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
index 95354cabb8..18ac30889b 100644
--- a/lib/acl/rte_acl.h
+++ b/lib/acl/rte_acl.h
@@ -136,6 +136,59 @@ struct rte_acl_param {
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
+ * Applications may use these hooks to allocate memory from custom pools or
+ * pre-allocated buffers. If no memory hook is provided, the ACL library uses
+ * rte_zmalloc_socket() internally.
+ *
+ * This function must be called **before** rte_acl_build().
+ * If the hook needs to be changed after a build, the ACL context must be reset
+ * first by invoking rte_acl_reset(), and only then can the memory hook be
+ * updated followed by another call to rte_acl_build().
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

