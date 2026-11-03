Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA88A606A789
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Q9q4cjgv
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15B9842790;
	Tue,  3 Nov 2026 15:57:37 +0100 (CET)
Received: from mta0.migadu.com (out-33.mta0.migadu.com [91.218.175.33])
 by mails.dpdk.org (Postfix) with ESMTPS id 3A83B41143
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:57:36 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=njfQ3TR0qyno94ltigmj4BQRZW7sDn+PJh5MB6I5J2w=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717856; v=1; x=1794322656;
 b=Q9q4cjgv0+lRxyR05Olm8Adr5rRjVyETvoZO7khDfPU5BUZn6lLJCbhD+OKHbfhkIbOZXKyS
 8ITkSeTa/EvWMWT5jcp72oJEYJi3/4br9GqoAAFc7QIc8iqT1y9Vt9QFWwkuIvHQdE1Wzw3HP3r
 Ky8AiLM16CZQcxzPuv112LJ8=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 16280cb648f98fa0;
 Tue, 03 Nov 2026 14:57:36 +0000
X-Mizu-Trace-ID: 16280cb648f98fa0
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 028/227] mbuf: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:46 +0800
Message-ID: <20261103145306.487255-29-chengwen.feng@linux.dev>
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
 lib/mbuf/rte_mbuf.c          | 12 ++++++------
 lib/mbuf/rte_mbuf.h          | 18 +++++++++---------
 lib/mbuf/rte_mbuf_dyn.c      |  2 +-
 lib/mbuf/rte_mbuf_pool_ops.c |  4 ++--
 4 files changed, 18 insertions(+), 18 deletions(-)

diff --git a/lib/mbuf/rte_mbuf.c b/lib/mbuf/rte_mbuf.c
index ac6f3e1a3a..76c3f4b2fe 100644
--- a/lib/mbuf/rte_mbuf.c
+++ b/lib/mbuf/rte_mbuf.c
@@ -229,7 +229,7 @@ RTE_EXPORT_SYMBOL(rte_pktmbuf_pool_create_by_ops)
 struct rte_mempool *
 rte_pktmbuf_pool_create_by_ops(const char *name, unsigned int n,
 	unsigned int cache_size, uint16_t priv_size, uint16_t data_room_size,
-	int socket_id, const char *ops_name)
+	int numa_id, const char *ops_name)
 {
 	struct rte_mempool *mp;
 	struct rte_pktmbuf_pool_private mbp_priv;
@@ -250,7 +250,7 @@ rte_pktmbuf_pool_create_by_ops(const char *name, unsigned int n,
 	mbp_priv.mbuf_priv_size = priv_size;
 
 	mp = rte_mempool_create_empty(name, n, elt_size, cache_size,
-		 sizeof(struct rte_pktmbuf_pool_private), socket_id, 0);
+		 sizeof(struct rte_pktmbuf_pool_private), numa_id, 0);
 	if (mp == NULL)
 		return NULL;
 
@@ -282,10 +282,10 @@ RTE_EXPORT_SYMBOL(rte_pktmbuf_pool_create)
 struct rte_mempool *
 rte_pktmbuf_pool_create(const char *name, unsigned int n,
 	unsigned int cache_size, uint16_t priv_size, uint16_t data_room_size,
-	int socket_id)
+	int numa_id)
 {
 	return rte_pktmbuf_pool_create_by_ops(name, n, cache_size, priv_size,
-			data_room_size, socket_id, NULL);
+			data_room_size, numa_id, NULL);
 }
 
 /* Helper to create a mbuf pool with pinned external data buffers. */
@@ -293,7 +293,7 @@ RTE_EXPORT_SYMBOL(rte_pktmbuf_pool_create_extbuf)
 struct rte_mempool *
 rte_pktmbuf_pool_create_extbuf(const char *name, unsigned int n,
 	unsigned int cache_size, uint16_t priv_size,
-	uint16_t data_room_size, int socket_id,
+	uint16_t data_room_size, int numa_id,
 	const struct rte_pktmbuf_extmem *ext_mem,
 	unsigned int ext_num)
 {
@@ -344,7 +344,7 @@ rte_pktmbuf_pool_create_extbuf(const char *name, unsigned int n,
 	mbp_priv.flags = RTE_PKTMBUF_POOL_F_PINNED_EXT_BUF;
 
 	mp = rte_mempool_create_empty(name, n, elt_size, cache_size,
-		 sizeof(struct rte_pktmbuf_pool_private), socket_id, 0);
+		 sizeof(struct rte_pktmbuf_pool_private), numa_id, 0);
 	if (mp == NULL)
 		return NULL;
 
diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
index ad72328136..9b069cfab8 100644
--- a/lib/mbuf/rte_mbuf.h
+++ b/lib/mbuf/rte_mbuf.h
@@ -792,9 +792,9 @@ void rte_pktmbuf_pool_init(struct rte_mempool *mp, void *opaque_arg);
  *   and the data buffer. This value must be aligned to RTE_MBUF_PRIV_ALIGN.
  * @param data_room_size
  *   Size of data buffer in each mbuf, including RTE_PKTMBUF_HEADROOM.
- * @param socket_id
+ * @param numa_id
  *   The socket identifier where the memory should be allocated. The
- *   value can be *SOCKET_ID_ANY* if there is no NUMA constraint for the
+ *   value can be *RTE_NUMA_ID_ANY* if there is no NUMA constraint for the
  *   reserved zone.
  * @return
  *   The pointer to the new allocated mempool, on success. NULL on error
@@ -808,7 +808,7 @@ void rte_pktmbuf_pool_init(struct rte_mempool *mp, void *opaque_arg);
 struct rte_mempool *
 rte_pktmbuf_pool_create(const char *name, unsigned n,
 	unsigned cache_size, uint16_t priv_size, uint16_t data_room_size,
-	int socket_id);
+	int numa_id);
 
 /**
  * Create a mbuf pool with a given mempool ops name
@@ -828,9 +828,9 @@ rte_pktmbuf_pool_create(const char *name, unsigned n,
  *   and the data buffer. This value must be aligned to RTE_MBUF_PRIV_ALIGN.
  * @param data_room_size
  *   Size of data buffer in each mbuf, including RTE_PKTMBUF_HEADROOM.
- * @param socket_id
+ * @param numa_id
  *   The socket identifier where the memory should be allocated. The
- *   value can be *SOCKET_ID_ANY* if there is no NUMA constraint for the
+ *   value can be *RTE_NUMA_ID_ANY* if there is no NUMA constraint for the
  *   reserved zone.
  * @param ops_name
  *   The mempool ops name to be used for this mempool instead of
@@ -847,7 +847,7 @@ rte_pktmbuf_pool_create(const char *name, unsigned n,
 struct rte_mempool *
 rte_pktmbuf_pool_create_by_ops(const char *name, unsigned int n,
 	unsigned int cache_size, uint16_t priv_size, uint16_t data_room_size,
-	int socket_id, const char *ops_name);
+	int numa_id, const char *ops_name);
 
 /** A structure that describes the pinned external buffer segment. */
 struct rte_pktmbuf_extmem {
@@ -875,9 +875,9 @@ struct rte_pktmbuf_extmem {
  *   and the data buffer. This value must be aligned to RTE_MBUF_PRIV_ALIGN.
  * @param data_room_size
  *   Size of data buffer in each mbuf, including RTE_PKTMBUF_HEADROOM.
- * @param socket_id
+ * @param numa_id
  *   The socket identifier where the memory should be allocated. The
- *   value can be *SOCKET_ID_ANY* if there is no NUMA constraint for the
+ *   value can be *RTE_NUMA_ID_ANY* if there is no NUMA constraint for the
  *   reserved zone.
  * @param ext_mem
  *   Pointer to the array of structures describing the external memory
@@ -898,7 +898,7 @@ struct rte_pktmbuf_extmem {
 struct rte_mempool *
 rte_pktmbuf_pool_create_extbuf(const char *name, unsigned int n,
 	unsigned int cache_size, uint16_t priv_size,
-	uint16_t data_room_size, int socket_id,
+	uint16_t data_room_size, int numa_id,
 	const struct rte_pktmbuf_extmem *ext_mem,
 	unsigned int ext_num);
 
diff --git a/lib/mbuf/rte_mbuf_dyn.c b/lib/mbuf/rte_mbuf_dyn.c
index 5987c9dee8..798080d705 100644
--- a/lib/mbuf/rte_mbuf_dyn.c
+++ b/lib/mbuf/rte_mbuf_dyn.c
@@ -114,7 +114,7 @@ init_shared_mem(void)
 	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
 		mz = rte_memzone_reserve_aligned(RTE_MBUF_DYN_MZNAME,
 						sizeof(struct mbuf_dyn_shm),
-						SOCKET_ID_ANY, 0,
+						RTE_NUMA_ID_ANY, 0,
 						RTE_CACHE_LINE_SIZE);
 	} else {
 		mz = rte_memzone_lookup(RTE_MBUF_DYN_MZNAME);
diff --git a/lib/mbuf/rte_mbuf_pool_ops.c b/lib/mbuf/rte_mbuf_pool_ops.c
index 219b364803..d639831ca0 100644
--- a/lib/mbuf/rte_mbuf_pool_ops.c
+++ b/lib/mbuf/rte_mbuf_pool_ops.c
@@ -26,7 +26,7 @@ rte_mbuf_set_platform_mempool_ops(const char *ops_name)
 	mz = rte_memzone_lookup("mbuf_platform_pool_ops");
 	if (mz == NULL) {
 		mz = rte_memzone_reserve("mbuf_platform_pool_ops",
-			RTE_MEMPOOL_OPS_NAMESIZE, SOCKET_ID_ANY, 0);
+			RTE_MEMPOOL_OPS_NAMESIZE, RTE_NUMA_ID_ANY, 0);
 		if (mz == NULL)
 			return -rte_errno;
 		strcpy(mz->addr, ops_name);
@@ -68,7 +68,7 @@ rte_mbuf_set_user_mempool_ops(const char *ops_name)
 	mz = rte_memzone_lookup("mbuf_user_pool_ops");
 	if (mz == NULL) {
 		mz = rte_memzone_reserve("mbuf_user_pool_ops",
-			RTE_MEMPOOL_OPS_NAMESIZE, SOCKET_ID_ANY, 0);
+			RTE_MEMPOOL_OPS_NAMESIZE, RTE_NUMA_ID_ANY, 0);
 		if (mz == NULL)
 			return -rte_errno;
 	}
-- 
2.55.0

