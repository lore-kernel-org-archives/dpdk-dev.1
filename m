Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CD3606BA19
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Nov 2026 14:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=Mi5tnrRx
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 002CF41143;
	Tue,  3 Nov 2026 15:53:39 +0100 (CET)
Received: from mta0.migadu.com (out-168.mta0.migadu.com [91.218.175.168])
 by mails.dpdk.org (Postfix) with ESMTPS id A2A1241143
 for <dev@dpdk.org>; Tue,  3 Nov 2026 15:53:38 +0100 (CET)
X-Envelope-To: dev@dpdk.org
DKIM-Signature: a=rsa-sha256; bh=78JI167BgpDC3SmLZ05LX0/mkLpPgRwYZ2y/D5fEa/Q=; 
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1793717618; v=1; x=1794322418;
 b=Mi5tnrRxA2EmWxmZGE8N9NvCcvAZSYZ+YPLnPq5s7HLdpDdt+QK4dqWcfqc9w39JWechssc+
 GSNDxUFL2x6NEBteicT3PJy3q3o2CMUXyLM3ihMWeTRN8vFuhizD5l4BOTCNK9ib9u5xT6l4Tx9
 O9EtX9QqzIBeuog4NP5lR9zY=
X-Envelope-To: dev@dpdk.org
Received: by mta10.migadu.com with ESMTPS id 9d16a1576565817f;
 Tue, 03 Nov 2026 14:53:38 +0000
X-Mizu-Trace-ID: 9d16a1576565817f
X-Migadu-Flow: FLOW_OUT
From: Chengwen Feng <chengwen.feng@linux.dev>
To: thomas@monjalon.net,
	konstantin.v.ananyev@yandex.ru
Cc: dev@dpdk.org,
	Chengwen Feng <fengchengwen@huawei.com>
Subject: [PATCH 003/227] ring: use NUMA node terminology
Date: Tue,  3 Nov 2026 22:49:21 +0800
Message-ID: <20261103145306.487255-4-chengwen.feng@linux.dev>
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

Rename socket_id parameters and comments to numa_id, and update
telemetry keys to the NUMA node terminology.

No functional change.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/ring/rte_ring.c      | 12 ++++++------
 lib/ring/rte_ring.h      |  8 ++++----
 lib/ring/rte_ring_elem.h |  8 ++++----
 3 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/lib/ring/rte_ring.c b/lib/ring/rte_ring.c
index 10b52dc679..c566592027 100644
--- a/lib/ring/rte_ring.c
+++ b/lib/ring/rte_ring.c
@@ -256,7 +256,7 @@ rte_ring_init(struct rte_ring *r, const char *name, unsigned int count,
 RTE_EXPORT_SYMBOL(rte_ring_create_elem)
 struct rte_ring *
 rte_ring_create_elem(const char *name, unsigned int esize, unsigned int count,
-		int socket_id, unsigned int flags)
+		int numa_id, unsigned int flags)
 {
 	char mz_name[RTE_MEMZONE_NAMESIZE];
 	struct rte_ring *r;
@@ -300,7 +300,7 @@ rte_ring_create_elem(const char *name, unsigned int esize, unsigned int count,
 	 * we are secondary process, the memzone_reserve function will set
 	 * rte_errno for us appropriately - hence no check in this function
 	 */
-	mz = rte_memzone_reserve_aligned(mz_name, ring_size, socket_id,
+	mz = rte_memzone_reserve_aligned(mz_name, ring_size, numa_id,
 					 mz_flags, alignof(typeof(*r)));
 	if (mz != NULL) {
 		r = mz->addr;
@@ -325,10 +325,10 @@ rte_ring_create_elem(const char *name, unsigned int esize, unsigned int count,
 /* create the ring */
 RTE_EXPORT_SYMBOL(rte_ring_create)
 struct rte_ring *
-rte_ring_create(const char *name, unsigned int count, int socket_id,
+rte_ring_create(const char *name, unsigned int count, int numa_id,
 		unsigned int flags)
 {
-	return rte_ring_create_elem(name, sizeof(void *), count, socket_id,
+	return rte_ring_create_elem(name, sizeof(void *), count, numa_id,
 		flags);
 }
 
@@ -605,7 +605,7 @@ ring_info_cb(struct rte_ring *r, void *arg)
 		return;
 
 	rte_tel_data_add_dict_string(d, "name", r->name);
-	rte_tel_data_add_dict_int(d, "socket", r->memzone->socket_id);
+	rte_tel_data_add_dict_int(d, "numa_id", r->memzone->socket_id);
 	rte_tel_data_add_dict_int(d, "flags", r->flags);
 	rte_tel_data_add_dict_string(d, "producer_type",
 		ring_prod_sync_type_to_name(r));
@@ -622,7 +622,7 @@ ring_info_cb(struct rte_ring *r, void *arg)
 	rte_tel_data_add_dict_string(d, "mz_name", mz->name);
 	rte_tel_data_add_dict_uint(d, "mz_len", mz->len);
 	rte_tel_data_add_dict_uint(d, "mz_hugepage_sz", mz->hugepage_sz);
-	rte_tel_data_add_dict_int(d, "mz_socket_id", mz->socket_id);
+	rte_tel_data_add_dict_int(d, "mz_numa_id", mz->socket_id);
 	rte_tel_data_add_dict_uint_hex(d, "mz_flags", mz->flags, 0);
 }
 
diff --git a/lib/ring/rte_ring.h b/lib/ring/rte_ring.h
index 3382a8e2f2..ff1f4ae90a 100644
--- a/lib/ring/rte_ring.h
+++ b/lib/ring/rte_ring.h
@@ -146,9 +146,9 @@ void rte_ring_free(struct rte_ring *r);
  * @param count
  *   The size of the ring (must be a power of 2,
  *   unless RING_F_EXACT_SZ is set in flags).
- * @param socket_id
- *   The *socket_id* argument is the socket identifier in case of
- *   NUMA. The value can be *SOCKET_ID_ANY* if there is no NUMA
+ * @param numa_id
+ *   The *numa_id* argument is the NUMA node ID in case of
+ *   NUMA. The value can be *RTE_NUMA_ID_ANY* if there is no NUMA
  *   constraint for the reserved zone.
  * @param flags
  *   An OR of the following:
@@ -193,7 +193,7 @@ void rte_ring_free(struct rte_ring *r);
  *    - ENOMEM - no appropriate memory area found in which to create memzone
  */
 struct rte_ring *rte_ring_create(const char *name, unsigned int count,
-				 int socket_id, unsigned int flags)
+				 int numa_id, unsigned int flags)
 	__rte_malloc __rte_dealloc(rte_ring_free, 1);
 
 /**
diff --git a/lib/ring/rte_ring_elem.h b/lib/ring/rte_ring_elem.h
index b96bfc003f..9397183538 100644
--- a/lib/ring/rte_ring_elem.h
+++ b/lib/ring/rte_ring_elem.h
@@ -58,9 +58,9 @@ ssize_t rte_ring_get_memsize_elem(unsigned int esize, unsigned int count);
  *   The size of ring element, in bytes. It must be a multiple of 4.
  * @param count
  *   The number of elements in the ring (must be a power of 2).
- * @param socket_id
- *   The *socket_id* argument is the socket identifier in case of
- *   NUMA. The value can be *SOCKET_ID_ANY* if there is no NUMA
+ * @param numa_id
+ *   The *numa_id* argument is the NUMA node ID in case of
+ *   NUMA. The value can be *RTE_NUMA_ID_ANY* if there is no NUMA
  *   constraint for the reserved zone.
  * @param flags
  *   An OR of the following:
@@ -99,7 +99,7 @@ ssize_t rte_ring_get_memsize_elem(unsigned int esize, unsigned int count);
  *    - ENOMEM - no appropriate memory area found in which to create memzone
  */
 struct rte_ring *rte_ring_create_elem(const char *name, unsigned int esize,
-			unsigned int count, int socket_id, unsigned int flags);
+			unsigned int count, int numa_id, unsigned int flags);
 
 /**
  * Enqueue several objects on the ring (multi-producers safe).
-- 
2.55.0

