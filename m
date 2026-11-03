Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F3F0606A785
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=nyjdoWLO
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3F67E410FC;
	Tue,  3 Nov 2026 15:55:04 +0100 (CET)
Received: from mta1.migadu.com (out-194.mta1.migadu.com [95.215.58.194])
 by mails.dpdk.org (Postfix) with ESMTPS id 77DA64275C
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:55:02 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=84OoYHUpUJZhAvDNX5FBG7zx6iJIo05Q+JhvM3oS/J4=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717702; v=1; x=1794322502;
 b=nyjdoWLOUaQutQXSK68AnXRywSBVnTrnMnqZstE6RTn+GIjSwISWBhhJ93Nrh2HAmWAb4S92
 YSTOZtD9ydTwcVal/PARqBCzgTVC6jFEWcTpVjoev+ekLaw2uO1ufUcuiE2VyMXsCXC57eCJLGI
 eR9aEe3fzFvUCF7Spq+6/LWQ=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 8c40545820bf6346;
 Tue, 03 Nov 2026 14:55:02 +0000
X-Mizu-Trace-ID: 8c40545820bf6346
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 013/227] acl: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:31 +0800
Message-ID: <20261103145306.487255-14-chengwen.feng@linux.dev>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261103145306.487255-1-chengwen.feng@linux.dev>
References: <20261103145306.487255-1-chengwen.feng@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Chengwen Feng <fengchengwen@huawei.com>

Rename the numa_id field of rte_acl_param (was socket_id),
keeping socket_id as a deprecated union alias, and update
in-tree users accordingly.

Also rename socket_id parameters, the internal context field,
memory hook callback parameter, log messages and comments to
the NUMA node terminology, and switch internal calls to
rte_zmalloc_numa(), rte_numa_id() and RTE_NUMA_ID_ANY.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-acl/main.c |  6 +++---
 lib/acl/acl.h       |  4 ++--
 lib/acl/acl_gen.c   | 10 +++++-----
 lib/acl/rte_acl.c   | 14 +++++++-------
 lib/acl/rte_acl.h   | 14 +++++++++++---
 5 files changed, 28 insertions(+), 20 deletions(-)

diff --git a/app/test-acl/main.c b/app/test-acl/main.c
index ad0bc89644..605a8b81bd 100644
--- a/app/test-acl/main.c
+++ b/app/test-acl/main.c
@@ -138,7 +138,7 @@ static struct {
 
 static struct rte_acl_param prm = {
 	.name = APP_NAME,
-	.socket_id = SOCKET_ID_ANY,
+	.numa_id = RTE_NUMA_ID_ANY,
 };
 
 /*
@@ -546,8 +546,8 @@ tracef_init(void)
 	struct ipv6_5tuple *w;
 
 	sz = config.nb_traces * (config.ipv6 ? sizeof(*w) : sizeof(*v));
-	config.traces = rte_zmalloc_socket(name, sz, RTE_CACHE_LINE_SIZE,
-			SOCKET_ID_ANY);
+	config.traces = rte_zmalloc_numa(name, sz, RTE_CACHE_LINE_SIZE,
+			RTE_NUMA_ID_ANY);
 	if (config.traces == NULL)
 		rte_exit(EXIT_FAILURE, "Cannot allocate %zu bytes for "
 			"requested %u number of trace records\n",
diff --git a/lib/acl/acl.h b/lib/acl/acl.h
index e1ecd1567b..33d7aeac34 100644
--- a/lib/acl/acl.h
+++ b/lib/acl/acl.h
@@ -166,8 +166,8 @@ struct rte_acl_bld_trie {
 struct rte_acl_ctx {
 	char                name[RTE_ACL_NAMESIZE];
 	/** Name of the ACL context. */
-	int32_t             socket_id;
-	/** Socket ID to allocate memory from. */
+	int32_t             numa_id;
+	/** NUMA node ID to allocate memory from. */
 	enum rte_acl_classify_alg alg;
 	uint32_t           first_load_sz;
 	void               *rules;
diff --git a/lib/acl/acl_gen.c b/lib/acl/acl_gen.c
index 77f19dd13a..83ace1b0f5 100644
--- a/lib/acl/acl_gen.c
+++ b/lib/acl/acl_gen.c
@@ -38,14 +38,14 @@ acl_gen_log_stats(const struct rte_acl_ctx *ctx,
 	size_t max_size)
 {
 	RTE_LOG(DEBUG, ACL, "Gen phase for ACL \"%s\":\n"
-		"runtime memory footprint on socket %d:\n"
+		"runtime memory footprint on NUMA node %d:\n"
 		"single nodes/bytes used: %d/%zu\n"
 		"quad nodes/vectors/bytes used: %d/%d/%zu\n"
 		"DFA nodes/group64/bytes used: %d/%d/%zu\n"
 		"match nodes/bytes used: %d/%zu\n"
 		"total: %zu bytes\n"
 		"max limit: %zu bytes\n",
-		ctx->name, ctx->socket_id,
+		ctx->name, ctx->numa_id,
 		counts->single, counts->single * sizeof(uint64_t),
 		counts->quad, counts->quad_vectors,
 		(indices->quad_index - indices->dfa_index) * sizeof(uint64_t),
@@ -479,11 +479,11 @@ rte_acl_gen(struct rte_acl_ctx *ctx, struct rte_acl_trie *trie,
 	}
 
 	mem = ctx->mem_hook.zalloc(ctx->name, total_size,
-			RTE_CACHE_LINE_SIZE, ctx->socket_id, ctx->mem_hook.udata);
+			RTE_CACHE_LINE_SIZE, ctx->numa_id, ctx->mem_hook.udata);
 	if (mem == NULL) {
 		ACL_LOG(ERR,
-			"allocation of %zu bytes on socket %d for %s failed",
-			total_size, ctx->socket_id, ctx->name);
+			"allocation of %zu bytes on NUMA node %d for %s failed",
+			total_size, ctx->numa_id, ctx->name);
 		return -ENOMEM;
 	}
 
diff --git a/lib/acl/rte_acl.c b/lib/acl/rte_acl.c
index f87435c49a..74b37bac68 100644
--- a/lib/acl/rte_acl.c
+++ b/lib/acl/rte_acl.c
@@ -299,10 +299,10 @@ acl_get_best_alg(void)
 }
 
 static void *
-acl_mem_default_zalloc(char *name, size_t size, size_t align, int32_t socket_id, void *udata)
+acl_mem_default_zalloc(char *name, size_t size, size_t align, int32_t numa_id, void *udata)
 {
 	RTE_SET_USED(udata);
-	return rte_zmalloc_socket(name, size, align, socket_id);
+	return rte_zmalloc_numa(name, size, align, numa_id);
 }
 
 static void
@@ -458,12 +458,12 @@ rte_acl_create(const struct rte_acl_param *param)
 			goto exit;
 		}
 
-		ctx = rte_zmalloc_socket(name, sz, RTE_CACHE_LINE_SIZE, param->socket_id);
+		ctx = rte_zmalloc_numa(name, sz, RTE_CACHE_LINE_SIZE, param->numa_id);
 
 		if (ctx == NULL) {
 			ACL_LOG(ERR,
-				"allocation of %zu bytes on socket %d for %s failed",
-				sz, param->socket_id, name);
+				"allocation of %zu bytes on NUMA node %d for %s failed",
+				sz, param->numa_id, name);
 			rte_free(te);
 			goto exit;
 		}
@@ -471,7 +471,7 @@ rte_acl_create(const struct rte_acl_param *param)
 		ctx->rules = ctx + 1;
 		ctx->max_rules = param->max_rule_num;
 		ctx->rule_sz = param->rule_size;
-		ctx->socket_id = param->socket_id;
+		ctx->numa_id = param->numa_id;
 		ctx->alg = acl_get_best_alg();
 		ctx->mem_hook.zalloc = acl_mem_default_zalloc;
 		ctx->mem_hook.free = acl_mem_default_free;
@@ -576,7 +576,7 @@ rte_acl_dump(const struct rte_acl_ctx *ctx)
 	if (!ctx)
 		return;
 	printf("acl context <%s>@%p\n", ctx->name, ctx);
-	printf("  socket_id=%"PRId32"\n", ctx->socket_id);
+	printf("  numa_id=%"PRId32"\n", ctx->numa_id);
 	printf("  alg=%"PRId32"\n", ctx->alg);
 	printf("  first_load_sz=%"PRIu32"\n", ctx->first_load_sz);
 	printf("  max_rules=%"PRIu32"\n", ctx->max_rules);
diff --git a/lib/acl/rte_acl.h b/lib/acl/rte_acl.h
index 8d6a1e2f7e..84559c566c 100644
--- a/lib/acl/rte_acl.h
+++ b/lib/acl/rte_acl.h
@@ -128,7 +128,15 @@ RTE_ACL_RULE_DEF(rte_acl_rule,);
  */
 struct rte_acl_param {
 	const char *name;         /**< Name of the ACL context. */
-	int         socket_id;    /**< Socket ID to allocate memory for. */
+	union {
+		/** NUMA node ID to allocate memory for. */
+		int numa_id;
+		/**
+		 * Deprecated alias of numa_id.
+		 */
+		__rte_deprecated_msg("use numa_id")
+		int socket_id;
+	};
 	uint32_t    rule_size;    /**< Size of each rule. */
 	uint32_t    max_rule_num; /**< Maximum number of rules. */
 };
@@ -141,7 +149,7 @@ struct rte_acl_ctx;
  */
 struct rte_acl_mem_hook {
 	/** Allocate zero-initialized memory used during runtime. */
-	void *(*zalloc)(char *name, size_t size, size_t align, int32_t socket_id, void *udata);
+	void *(*zalloc)(char *name, size_t size, size_t align, int32_t numa_id, void *udata);
 
 	/** Free memory previously allocated by zalloc(). */
 	void (*free)(void *ptr, void *udata);
@@ -156,7 +164,7 @@ struct rte_acl_mem_hook {
  * Applications may use these hooks to allocate memory
  * from custom pools or pre-allocated buffers.
  * If no memory hook is provided,
- * the ACL library uses rte_zmalloc_socket() internally.
+ * the ACL library uses rte_zmalloc_numa() internally.
  *
  * This function must be called **before** rte_acl_build().
  * If the hook needs to be changed after a build,
-- 
2.55.0

