Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8AE0D3B7EA
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Dec 2025 12:53:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CDAC40270;
	Tue,  9 Dec 2025 13:53:05 +0100 (CET)
Received: from smtpbg154.qq.com (smtpbg154.qq.com [15.184.224.54])
 by mails.dpdk.org (Postfix) with ESMTP id 453284025F
 for <dev@dpdk.org>; Tue,  9 Dec 2025 13:53:02 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tencent.com;
 s=s201512; t=1765284780;
 bh=Gb1t71sxDJBrtUZhxtwvBqR0Xv55JAuhYkwC9W0utS0=;
 h=From:To:Subject:Date:Message-ID:MIME-Version;
 b=pvWstDnoSJfJR5xdx7s8zIh82H2PoQfj8b3lhO0J+7W+bJmA3cRuMfK2vbzPJzZUx
 vmuUrkPLRawNW//uAL5iRfSXaopgZOtWsF32E1WIV5MMvWZamd4lf0JcXz1vuTK0cT
 OrO4F2vI07kY7z10U3QVtVZ0FgU9EKq4k3rQ7Hlo=
X-QQ-mid: zesmtpsz7t1765284777t81412abd
X-QQ-Originating-IP: WNNFPfvvyrMkMbjXGC21YQfVG1Umw8BafKi/kCnQAn4=
Received: from wyfs.. ( [11.176.19.22]) by bizesmtp.qq.com (ESMTP) with 
 id ; Tue, 09 Dec 2025 20:52:40 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4220033116040818748
From: "=?gb18030?B?bWFubnl3YW5nKM3108C35Sk=?=" <mannywang@tencent.com>
To: Konstantin Ananyev <konstantin.ananyev@huawei.com>
Cc: dev@dpdk.org,
	YongFeng Wang <mannywang@tencent.com>
Subject: [PATCH v8] acl: support custom memory allocators
Date: Tue,  9 Dec 2025 12:52:36 +0000
Message-ID: <531B109557B40560+20251209125236.27095-1-mannywang@tencent.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <68D016D742174F42+20251208125716.19424-1-mannywang@tencent.com>
References: <68D016D742174F42+20251208125716.19424-1-mannywang@tencent.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:tencent.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Of6ml/llp+z5Q5y2e1ZcxlguM7mvU60gAyvC5ISRFTcAJ6nLNTc/LWnS
 wntCsxoYCvPU+AM9C2Ip2XwLZq0BM7haHmJ7pJkjfNl5Y2bwLPR+Kd5DP6PnifqzR/BWQ9V
 bjxgJf4isJon3G3OZfX2l1kFgKR6HFfz8rmsr+/hTWoycON6U9C+ko2yJR2jL/lun7f97OF
 kEURCfq6sAd5eX2FdKne/S88oNFez9L0bTzcffUJumKyR0reIEuLhKtv1k+6GuzPfyegjWS
 l66lvmDxRZnCZ7iDGiLFhJU+1p/AkhBjQUCTRl5Z8///BDOV0u2p5dM9/jChtG2vpFInphn
 gqpAV1WFbzxc7NpOhtieiP7wiz42ddqU1+HCa9bXIrIXl2kH4pY07n1md6dZsgV7iIMAO/h
 xbC7Dln7RZVvPjm33NjOwZNcaC/aBNR1I0UH/HXYyryoVuvHnNKZ6ybtxakkg5fIp7DJS7u
 9UhyVe7R1C+gQ2Lxrt7I3M02MGb67MdiNnkAWQ4/6uu3tceVSBhzeZ5br/Qw6+dKkCpkvk1
 rgiPQNmcARn8UKXpfPZa3otaV1LS7xGOE5E5nnht5WLQhfPdN2DUs5+YBhF2IJwjX6L4zWh
 ADcavstG7A7AtZAZDpC77wfTFy38h/CuzNAfA6Jbmm4vd3Kjq2R9jCPE56OvORnO98RcN6t
 DtXY/4AfG+CHEnCFfYoX7I7VkO0FQ8mvzyRKadWi6zoUq6mZuVSOOV6yjI0vrC5ceFHAZ48
 bOeDSPrYJQpfAWgsjf7KlLxE6kDU9N0vSFoMKl0F4PGJVnL2/eU7ezEVbkfhgAGWHwg6RTX
 NYqhzGQHEmYTY+0VorZXORkWTS3QyehBZQ2wkCmnp741xix0GTfi0gmDvLnH2fwb2JT8N30
 wg4cb/qPs+BzuxUWUbrrkcaorLzcGX0Mdzwk1XtCfiyznZrBv3feH5iVDupzWzxhu8bPdfg
 QRFe4npmyZwh4C+zqXKK9x3lKxwX5D74KTOsapmXnq/frOdAvnRTV2MocYfSp1LJMube64a
 0j9U/4qg==
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

v7:
- Switch the UT to use malloc/free.
- Update the documentation to clarify that rte_acl_set_mem_hook
  must be called before rte_acl_build.

v8:
- Fix UT code per review.

Signed-off-by: YongFeng Wang <mannywang@tencent.com>
---
 app/test/test_acl.c                           | 107 ++++++++++++++++++
 .../prog_guide/packet_classif_access_ctrl.rst |  31 +++++
 lib/acl/acl.h                                 |   1 +
 lib/acl/acl_bld.c                             |   2 +-
 lib/acl/acl_gen.c                             |   4 +-
 lib/acl/rte_acl.c                             |  45 +++++++-
 lib/acl/rte_acl.h                             |  53 +++++++++
 7 files changed, 239 insertions(+), 4 deletions(-)

diff --git a/app/test/test_acl.c b/app/test/test_acl.c
index 43d13b5b0f..d92b95246f 100644
--- a/app/test/test_acl.c
+++ b/app/test/test_acl.c
@@ -1721,6 +1721,111 @@ test_u32_range(void)
 	return rc;
 }
 
+static struct rte_acl_ctx *acl_ctx;
+
+static void *running_alloc(char *name, size_t size,
+	size_t align, int32_t socket_id, void *udata)
+{
+	RTE_SET_USED(name);
+	RTE_SET_USED(socket_id);
+
+	if (udata != acl_ctx) {
+		printf("%s#%i udata mismatch!\n",
+			__func__, __LINE__);
+		return NULL;
+	}
+	void *addr = aligned_alloc(align, size);
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
+	if (!ptr)
+		return;
+	free(ptr);
+}
+
+static int
+test_mem_hook(void)
+{
+	int i, ret;
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
+		return 1;
+	}
+
+	struct rte_acl_mem_hook new_hook;
+	memset(&new_hook, 0, sizeof(struct rte_acl_mem_hook));
+	if (rte_acl_get_mem_hook(acl_ctx, &new_hook) != 0
+		|| memcmp(&mhook, &new_hook, sizeof(struct rte_acl_mem_hook)) != 0) {
+		printf("Line %i: Error get mem hook for acl context!\n", __LINE__);
+		rte_acl_free(acl_ctx);
+		return 1;
+	}
+
+	ret = 0;
+	for (i = 0; i < TEST_CLASSIFY_ITER; i++) {
+
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
+	return ret;
+}
+
 static int
 test_acl(void)
 {
@@ -1742,6 +1847,8 @@ test_acl(void)
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

