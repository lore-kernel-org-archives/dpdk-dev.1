Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608E7C5B552
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 14:42:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 566A540EE7;
	Mon,  9 Jun 2025 16:42:37 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id EEFC740EDB
 for <dev@dpdk.org>; Mon,  9 Jun 2025 16:42:35 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id AD62620469
 for <dev@dpdk.org>; Mon,  9 Jun 2025 16:42:35 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Mon, 9 Jun 2025 16:42:33 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [RFC PATCH] mempool: Fix some Coverity defects
Date: Mon,  9 Jun 2025 14:42:26 +0000
Message-ID: <20250609144226.232625-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 09 Jun 2025 14:42:33.0327 (UTC)
 FILETIME=[BC0CF7F0:01DBD94C]
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

Coverity reports some issues regarding the mempool library.
I have tried fixing them.
How to test if Coverity is satisfied with these fixes?

Function rte_mem_page_size() returns a negative number.
This seems to be the root cause of the following mempool defects.
And since the function is used elsewhere, it may also be the root cause
of other defects.
Coverity issue: 448869
Coverity issue: 360531

Function get_min_page_size(mp->socket_id) returns a negative number.
Coverity issue: 360532

Truncation due to cast operation on mem_size from 64 to 32 bits:
ret is assigned from mem_size.
Coverity issue: 442155

Calling rte_mempool_ops_dequeue_bulk without checking return value.
Coverity issue: 363744

And an unrelated drive-by fix in eal_mem_set_dump():
When madvise() failed, an incorrect reason was logged.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/eal/unix/eal_unix_memory.c |  9 +++++++--
 lib/mempool/rte_mempool.c      | 14 ++++++++++----
 2 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/lib/eal/unix/eal_unix_memory.c b/lib/eal/unix/eal_unix_memory.c
index c540f1e838..a796a28899 100644
--- a/lib/eal/unix/eal_unix_memory.c
+++ b/lib/eal/unix/eal_unix_memory.c
@@ -85,7 +85,7 @@ eal_mem_set_dump(void *virt, size_t size, bool dump)
 	int ret = madvise(virt, size, flags);
 	if (ret) {
 		EAL_LOG(DEBUG, "madvise(%p, %#zx, %d) failed: %s",
-				virt, size, flags, strerror(rte_errno));
+				virt, size, flags, strerror(errno));
 		rte_errno = errno;
 	}
 	return ret;
@@ -141,8 +141,13 @@ rte_mem_page_size(void)
 {
 	static size_t page_size;
 
-	if (!page_size)
+	if (page_size == 0) {
+		errno = 0; /* man sysconf(3) */
 		page_size = sysconf(_SC_PAGESIZE);
+		if ((ssize_t)page_size < 0)
+			rte_panic("sysconf(_SC_PAGESIZE) failed: %s",
+					errno == 0 ? "Indeterminate" : strerror(errno));
+	}
 
 	return page_size;
 }
diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index 1021ede0c2..d12b5e8a79 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -157,7 +157,7 @@ get_min_page_size(int socket_id)
 
 	rte_memseg_list_walk(find_min_pagesz, &wa);
 
-	return wa.min == SIZE_MAX ? (size_t) rte_mem_page_size() : wa.min;
+	return wa.min == SIZE_MAX ? rte_mem_page_size() : wa.min;
 }
 
 
@@ -238,6 +238,7 @@ rte_mempool_calc_obj_size(uint32_t elt_size, uint32_t flags,
 #endif
 
 	/* element size is 8 bytes-aligned at least */
+	RTE_VERIFY(elt_size <= UINT32_MAX - sizeof(uint64_t));
 	sz->elt_size = RTE_ALIGN_CEIL(elt_size, sizeof(uint64_t));
 
 	/* expand trailer to next cache line */
@@ -257,10 +258,13 @@ rte_mempool_calc_obj_size(uint32_t elt_size, uint32_t flags,
 		unsigned new_size;
 		new_size = arch_mem_object_align
 			    (sz->header_size + sz->elt_size + sz->trailer_size);
+		RTE_VERIFY(new_size >=
+				(uint64_t)sz->header_size + sz->elt_size + sz->trailer_size);
 		sz->trailer_size = new_size - sz->header_size - sz->elt_size;
 	}
 
 	/* this is the size of an object, including header and trailer */
+	RTE_VERIFY((uint64_t)sz->header_size + sz->elt_size + sz->trailer_size <= UINT32_MAX);
 	sz->total_size = sz->header_size + sz->elt_size + sz->trailer_size;
 
 	return sz->total_size;
@@ -280,11 +284,13 @@ static void
 rte_mempool_free_memchunks(struct rte_mempool *mp)
 {
 	struct rte_mempool_memhdr *memhdr;
+	int ret;
 	void *elt;
 
 	while (!STAILQ_EMPTY(&mp->elt_list)) {
-		rte_mempool_ops_dequeue_bulk(mp, &elt, 1);
-		(void)elt;
+		ret = rte_mempool_ops_dequeue_bulk(mp, &elt, 1);
+		RTE_SET_USED(ret);
+		RTE_SET_USED(elt);
 		STAILQ_REMOVE_HEAD(&mp->elt_list, next);
 		mp->populated_size--;
 	}
@@ -565,7 +571,7 @@ rte_mempool_populate_default(struct rte_mempool *mp)
 			mp, n, pg_shift, &min_chunk_size, &align);
 
 		if (mem_size < 0) {
-			ret = mem_size;
+			ret = (int)mem_size;
 			goto fail;
 		}
 
-- 
2.43.0

