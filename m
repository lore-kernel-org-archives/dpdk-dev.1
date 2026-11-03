Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F627606A782
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=NKbyrNZj
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68DA54114B;
	Tue,  3 Nov 2026 15:56:05 +0100 (CET)
Received: from mta1.migadu.com (out-38.mta1.migadu.com [95.215.58.38])
 by mails.dpdk.org (Postfix) with ESMTPS id 756EE40430
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:56:04 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=pLyGB8Q56Xy/7Hi0NQs16ipmNdBcYDI1JETYyoea8uQ=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717764; v=1; x=1794322564;
 b=NKbyrNZjXNKL2/Cdqq3I36JvvilxBbXDSwWLC9HGaXcIkleOZrvG+KtiUyAigrBqenwaS6uf
 cP9gNUWsvUItsNVXHFJcS4TL7n0mFSxSn+72P0CxaqG06wcsvEbbDTK442iu5n4ZjMC1nJZ4j5z
 JFD9TCefNjQ6yAZWAYQ+QK6w=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id f01a88f5c8434a2d;
 Tue, 03 Nov 2026 14:56:03 +0000
X-Mizu-Trace-ID: f01a88f5c8434a2d
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 019/227] lpm: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:37 +0800
Message-ID: <20261103145306.487255-20-chengwen.feng@linux.dev>
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

Rename socket_id parameters, internal variables and comments to
the NUMA node terminology, and switch internal calls to
rte_zmalloc_numa(), rte_numa_id() and RTE_NUMA_ID_ANY.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/lpm/rte_lpm.c  | 16 ++++++++--------
 lib/lpm/rte_lpm.h  |  6 +++---
 lib/lpm/rte_lpm6.c | 10 +++++-----
 lib/lpm/rte_lpm6.h |  6 +++---
 4 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/lib/lpm/rte_lpm.c b/lib/lpm/rte_lpm.c
index 0d1afe0ca1..8bee4be101 100644
--- a/lib/lpm/rte_lpm.c
+++ b/lib/lpm/rte_lpm.c
@@ -149,7 +149,7 @@ rte_lpm_find_existing(const char *name)
  */
 RTE_EXPORT_SYMBOL(rte_lpm_create)
 struct rte_lpm *
-rte_lpm_create(const char *name, int socket_id,
+rte_lpm_create(const char *name, int numa_id,
 		const struct rte_lpm_config *config)
 {
 	char mem_name[RTE_LPM_NAMESIZE + sizeof("LPM_")];
@@ -164,7 +164,7 @@ rte_lpm_create(const char *name, int socket_id,
 	RTE_BUILD_BUG_ON(sizeof(struct rte_lpm_tbl_entry) != 4);
 
 	/* Check user arguments. */
-	if ((name == NULL) || (socket_id < -1) || (config->max_rules == 0)
+	if ((name == NULL) || (numa_id < -1) || (config->max_rules == 0)
 			|| config->number_tbl8s > RTE_LPM_MAX_TBL8_NUM_GROUPS) {
 		rte_errno = EINVAL;
 		return NULL;
@@ -206,8 +206,8 @@ rte_lpm_create(const char *name, int socket_id,
 	}
 
 	/* Allocate memory to store the LPM data structures. */
-	i_lpm = rte_zmalloc_socket(mem_name, mem_size,
-			RTE_CACHE_LINE_SIZE, socket_id);
+	i_lpm = rte_zmalloc_numa(mem_name, mem_size,
+			RTE_CACHE_LINE_SIZE, numa_id);
 	if (i_lpm == NULL) {
 		LPM_LOG(ERR, "LPM memory allocation failed");
 		rte_free(te);
@@ -215,8 +215,8 @@ rte_lpm_create(const char *name, int socket_id,
 		goto exit;
 	}
 
-	i_lpm->rules_tbl = rte_zmalloc_socket(NULL,
-			(size_t)rules_size, RTE_CACHE_LINE_SIZE, socket_id);
+	i_lpm->rules_tbl = rte_zmalloc_numa(NULL,
+			(size_t)rules_size, RTE_CACHE_LINE_SIZE, numa_id);
 
 	if (i_lpm->rules_tbl == NULL) {
 		LPM_LOG(ERR, "LPM rules_tbl memory allocation failed");
@@ -227,8 +227,8 @@ rte_lpm_create(const char *name, int socket_id,
 		goto exit;
 	}
 
-	i_lpm->lpm.tbl8 = rte_zmalloc_socket(NULL,
-			(size_t)tbl8s_size, RTE_CACHE_LINE_SIZE, socket_id);
+	i_lpm->lpm.tbl8 = rte_zmalloc_numa(NULL,
+			(size_t)tbl8s_size, RTE_CACHE_LINE_SIZE, numa_id);
 
 	if (i_lpm->lpm.tbl8 == NULL) {
 		LPM_LOG(ERR, "LPM tbl8 memory allocation failed");
diff --git a/lib/lpm/rte_lpm.h b/lib/lpm/rte_lpm.h
index bcd3da9706..720e944d77 100644
--- a/lib/lpm/rte_lpm.h
+++ b/lib/lpm/rte_lpm.h
@@ -167,8 +167,8 @@ rte_lpm_free(struct rte_lpm *lpm);
  *
  * @param name
  *   LPM object name
- * @param socket_id
- *   NUMA socket ID for LPM table memory allocation
+ * @param numa_id
+ *   NUMA node ID for LPM table memory allocation
  * @param config
  *   Structure containing the configuration
  * @return
@@ -183,7 +183,7 @@ rte_lpm_free(struct rte_lpm *lpm);
  *    - ENAMETOOLONG - LPM object name greater than RTE_LPM_NAMESIZE
  */
 struct rte_lpm *
-rte_lpm_create(const char *name, int socket_id,
+rte_lpm_create(const char *name, int numa_id,
 	       const struct rte_lpm_config *config)
 	__rte_malloc __rte_dealloc(rte_lpm_free, 1);
 
diff --git a/lib/lpm/rte_lpm6.c b/lib/lpm/rte_lpm6.c
index 5eb2f3761d..413ac4d464 100644
--- a/lib/lpm/rte_lpm6.c
+++ b/lib/lpm/rte_lpm6.c
@@ -210,7 +210,7 @@ rebuild_lpm(struct rte_lpm6 *lpm)
  */
 RTE_EXPORT_SYMBOL(rte_lpm6_create)
 struct rte_lpm6 *
-rte_lpm6_create(const char *name, int socket_id,
+rte_lpm6_create(const char *name, int numa_id,
 		const struct rte_lpm6_config *config)
 {
 	char mem_name[RTE_LPM6_NAMESIZE];
@@ -229,7 +229,7 @@ rte_lpm6_create(const char *name, int socket_id,
 		sizeof(uint32_t) != 0);
 
 	/* Check user arguments. */
-	if ((name == NULL) || (socket_id < -1) || (config == NULL) ||
+	if ((name == NULL) || (numa_id < -1) || (config == NULL) ||
 			(config->max_rules == 0) ||
 			config->number_tbl8s > RTE_LPM6_TBL8_MAX_NUM_GROUPS) {
 		rte_errno = EINVAL;
@@ -246,7 +246,7 @@ rte_lpm6_create(const char *name, int socket_id,
 		.hash_func_init_val = 0,
 		.name = mem_name,
 		.reserved = 0,
-		.numa_id = socket_id,
+		.numa_id = numa_id,
 		.extra_flag = 0
 	};
 
@@ -308,8 +308,8 @@ rte_lpm6_create(const char *name, int socket_id,
 	}
 
 	/* Allocate memory to store the LPM data structures. */
-	lpm = rte_zmalloc_socket(mem_name, (size_t)mem_size,
-			RTE_CACHE_LINE_SIZE, socket_id);
+	lpm = rte_zmalloc_numa(mem_name, (size_t)mem_size,
+			RTE_CACHE_LINE_SIZE, numa_id);
 
 	if (lpm == NULL) {
 		LPM_LOG(ERR, "LPM memory allocation failed");
diff --git a/lib/lpm/rte_lpm6.h b/lib/lpm/rte_lpm6.h
index c5928b9d88..91a385b7c1 100644
--- a/lib/lpm/rte_lpm6.h
+++ b/lib/lpm/rte_lpm6.h
@@ -45,8 +45,8 @@ rte_lpm6_free(struct rte_lpm6 *lpm);
  *
  * @param name
  *   LPM object name
- * @param socket_id
- *   NUMA socket ID for LPM table memory allocation
+ * @param numa_id
+ *   NUMA node ID for LPM table memory allocation
  * @param config
  *   Structure containing the configuration
  * @return
@@ -60,7 +60,7 @@ rte_lpm6_free(struct rte_lpm6 *lpm);
  *    - ENOMEM - no appropriate memory area found in which to create memzone
  */
 struct rte_lpm6 *
-rte_lpm6_create(const char *name, int socket_id,
+rte_lpm6_create(const char *name, int numa_id,
 		const struct rte_lpm6_config *config)
 	__rte_malloc __rte_dealloc(rte_lpm6_free, 1);
 
-- 
2.55.0

