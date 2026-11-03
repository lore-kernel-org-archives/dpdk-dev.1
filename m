Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7017606A32F
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bNUJCIS8
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A43474161A;
	Tue,  3 Nov 2026 15:55:58 +0100 (CET)
Received: from mta1.migadu.com (out-26.mta1.migadu.com [95.215.58.26])
 by mails.dpdk.org (Postfix) with ESMTPS id C29D040430
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:55:56 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=xt3ZAwgQI0kzG0tIWCbuTooC9jF9nfMXfgdcQzszoJc=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717756; v=1; x=1794322556;
 b=bNUJCIS8tidf9s2iiIB0rvuqnH3ndBRiOdNHIgROjFkHCjyO63EHgim5RJk0d+p5DvCvLB2v
 ASeJtu/Kpd8d1mRt85jxmyJ5NPj+An49kAn04EP6QBGLxTy7+MSVtK65y57U+8oYMapxHCVMjFD
 1YuYVb9HGxv+v/AfVFcHhcjY=
X-Envelope-To: dev@dpdk.org
Received: by mta11.migadu.com with ESMTPS id 08df29b4d640cb2e;
 Tue, 03 Nov 2026 14:55:56 +0000
X-Mizu-Trace-ID: 08df29b4d640cb2e
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 018/227] rib: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:36 +0800
Message-ID: <20261103145306.487255-19-chengwen.feng@linux.dev>
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
 lib/rib/rte_rib.c  | 8 ++++----
 lib/rib/rte_rib.h  | 6 +++---
 lib/rib/rte_rib6.c | 8 ++++----
 lib/rib/rte_rib6.h | 6 +++---
 4 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/lib/rib/rte_rib.c b/lib/rib/rte_rib.c
index 046db131ca..e6cf27b68e 100644
--- a/lib/rib/rte_rib.c
+++ b/lib/rib/rte_rib.c
@@ -410,7 +410,7 @@ rte_rib_set_nh(struct rte_rib_node *node, uint64_t nh)
 
 RTE_EXPORT_SYMBOL(rte_rib_create)
 struct rte_rib *
-rte_rib_create(const char *name, int socket_id, const struct rte_rib_conf *conf)
+rte_rib_create(const char *name, int numa_id, const struct rte_rib_conf *conf)
 {
 	char mem_name[RTE_RIB_NAMESIZE];
 	struct rte_rib *rib = NULL;
@@ -427,7 +427,7 @@ rte_rib_create(const char *name, int socket_id, const struct rte_rib_conf *conf)
 	snprintf(mem_name, sizeof(mem_name), "MP_%s", name);
 	node_pool = rte_mempool_create(mem_name, conf->max_nodes,
 		sizeof(struct rte_rib_node) + conf->ext_sz, 0, 0,
-		NULL, NULL, NULL, NULL, socket_id, 0);
+		NULL, NULL, NULL, NULL, numa_id, 0);
 
 	if (node_pool == NULL) {
 		RIB_LOG(ERR,
@@ -462,8 +462,8 @@ rte_rib_create(const char *name, int socket_id, const struct rte_rib_conf *conf)
 	}
 
 	/* Allocate memory to store the RIB data structures. */
-	rib = rte_zmalloc_socket(mem_name,
-		sizeof(struct rte_rib),	RTE_CACHE_LINE_SIZE, socket_id);
+	rib = rte_zmalloc_numa(mem_name,
+		sizeof(struct rte_rib),	RTE_CACHE_LINE_SIZE, numa_id);
 	if (unlikely(rib == NULL)) {
 		RIB_LOG(ERR, "RIB %s memory allocation failed", name);
 		rte_errno = ENOMEM;
diff --git a/lib/rib/rte_rib.h b/lib/rib/rte_rib.h
index c325b3e361..2d3d965d68 100644
--- a/lib/rib/rte_rib.h
+++ b/lib/rib/rte_rib.h
@@ -246,8 +246,8 @@ rte_rib_free(struct rte_rib *rib);
  *
  * @param name
  *  RIB name
- * @param socket_id
- *  NUMA socket ID for RIB table memory allocation
+ * @param numa_id
+ *  NUMA node ID for RIB table memory allocation
  * @param conf
  *  Structure containing the configuration
  * @return
@@ -255,7 +255,7 @@ rte_rib_free(struct rte_rib *rib);
  *  NULL otherwise with rte_errno indicating reason for failure.
  */
 struct rte_rib *
-rte_rib_create(const char *name, int socket_id,
+rte_rib_create(const char *name, int numa_id,
 	       const struct rte_rib_conf *conf)
 	__rte_malloc __rte_dealloc(rte_rib_free, 1);
 
diff --git a/lib/rib/rte_rib6.c b/lib/rib/rte_rib6.c
index 918ddbdfd3..834ad08dad 100644
--- a/lib/rib/rte_rib6.c
+++ b/lib/rib/rte_rib6.c
@@ -472,7 +472,7 @@ rte_rib6_set_nh(struct rte_rib6_node *node, uint64_t nh)
 
 RTE_EXPORT_SYMBOL(rte_rib6_create)
 struct rte_rib6 *
-rte_rib6_create(const char *name, int socket_id,
+rte_rib6_create(const char *name, int numa_id,
 		const struct rte_rib6_conf *conf)
 {
 	char mem_name[RTE_RIB6_NAMESIZE];
@@ -490,7 +490,7 @@ rte_rib6_create(const char *name, int socket_id,
 	snprintf(mem_name, sizeof(mem_name), "MP_%s", name);
 	node_pool = rte_mempool_create(mem_name, conf->max_nodes,
 		sizeof(struct rte_rib6_node) + conf->ext_sz, 0, 0,
-		NULL, NULL, NULL, NULL, socket_id, 0);
+		NULL, NULL, NULL, NULL, numa_id, 0);
 
 	if (node_pool == NULL) {
 		RIB_LOG(ERR,
@@ -525,8 +525,8 @@ rte_rib6_create(const char *name, int socket_id,
 	}
 
 	/* Allocate memory to store the RIB6 data structures. */
-	rib = rte_zmalloc_socket(mem_name,
-		sizeof(struct rte_rib6), RTE_CACHE_LINE_SIZE, socket_id);
+	rib = rte_zmalloc_numa(mem_name,
+		sizeof(struct rte_rib6), RTE_CACHE_LINE_SIZE, numa_id);
 	if (unlikely(rib == NULL)) {
 		RIB_LOG(ERR, "RIB6 %s memory allocation failed", name);
 		rte_errno = ENOMEM;
diff --git a/lib/rib/rte_rib6.h b/lib/rib/rte_rib6.h
index e3fb464ae6..83ac8aa4a3 100644
--- a/lib/rib/rte_rib6.h
+++ b/lib/rib/rte_rib6.h
@@ -235,8 +235,8 @@ rte_rib6_free(struct rte_rib6 *rib);
  *
  * @param name
  *  RIB name
- * @param socket_id
- *  NUMA socket ID for RIB table memory allocation
+ * @param numa_id
+ *  NUMA node ID for RIB table memory allocation
  * @param conf
  *  Structure containing the configuration
  * @return
@@ -244,7 +244,7 @@ rte_rib6_free(struct rte_rib6 *rib);
  *  NULL otherwise with rte_errno indicating reason for failure.
  */
 struct rte_rib6 *
-rte_rib6_create(const char *name, int socket_id,
+rte_rib6_create(const char *name, int numa_id,
 		const struct rte_rib6_conf *conf)
 	__rte_malloc __rte_dealloc(rte_rib6_free, 1);
 
-- 
2.55.0

