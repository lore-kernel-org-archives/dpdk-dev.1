Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7CC2F99C73
	for <dpdk-dev@archiver.kernel.org>; Sat, 18 Apr 2026 09:56:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0C054402D9;
	Sat, 18 Apr 2026 11:56:47 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5A4FD402C5
 for <dev@dpdk.org>; Sat, 18 Apr 2026 11:56:45 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 31F5820778;
 Sat, 18 Apr 2026 11:56:44 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Sat, 18 Apr 2026 11:56:41 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org,
	Bruce Richardson <bruce.richardson@intel.com>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH] net/intel: do not bypass mbuf lib for mbuf fast-free
Date: Sat, 18 Apr 2026 09:56:38 +0000
Message-ID: <20260418095639.10003-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 18 Apr 2026 09:56:41.0498 (UTC)
 FILETIME=[A80F4FA0:01DCCF19]
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

Freeing mbufs directly into the mempool meant that mbuf instrumentation,
including mbuf history marking, was omitted.
The mbufs are now freed via the rte_mbuf_raw_free_bulk() function instead.

Added a static_assert to ensure that type casting the array of struct
ci_tx_entry_vec to an array of rte_mbuf pointers remains sound.

Performance note:
The (n & 31) condition was not removed.
For the default tx_rs_thresh value (32), the condition will be true.
And due to inlining, the rte_mbuf_raw_free_bulk() ends up in an
rte_memcpy(), where the optimizer takes advantage of knowing that the
lower bits are not set.
This should compensate somewhat for removing the handcoded optimization of
copying in chunks of 32 mbufs.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 doc/guides/rel_notes/release_26_07.rst |  4 +++
 drivers/net/intel/common/tx.h          | 36 +++-----------------------
 2 files changed, 7 insertions(+), 33 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 060b26ff61..9367d38b13 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -24,6 +24,10 @@ DPDK Release 26.07
 New Features
 ------------
 
+* **Updated Intel common driver.**
+
+  * Added missing mbuf history marking to vectorized Tx path for MBUF_FAST_FREE.
+
 .. This section should contain new features added in this release.
    Sample format:
 
diff --git a/drivers/net/intel/common/tx.h b/drivers/net/intel/common/tx.h
index 283bd58d5d..4a201da83c 100644
--- a/drivers/net/intel/common/tx.h
+++ b/drivers/net/intel/common/tx.h
@@ -285,42 +285,12 @@ ci_tx_free_bufs_vec(struct ci_tx_queue *txq, ci_desc_done_fn desc_done, bool ctx
 			(txq->fast_free_mp = txep[0].mbuf->pool);
 
 	if (mp != NULL && (n & 31) == 0) {
-		void **cache_objs;
-		struct rte_mempool_cache *cache = rte_mempool_default_cache(mp, rte_lcore_id());
-
-		if (cache == NULL)
-			goto normal;
-
-		cache_objs = &cache->objs[cache->len];
-
-		if (n > RTE_MEMPOOL_CACHE_MAX_SIZE) {
-			rte_mempool_ops_enqueue_bulk(mp, (void *)txep, n);
-			goto done;
-		}
-
-		/* The cache follows the following algorithm
-		 *   1. Add the objects to the cache
-		 *   2. Anything greater than the cache min value (if it
-		 *   crosses the cache flush threshold) is flushed to the ring.
-		 */
-		/* Add elements back into the cache */
-		uint32_t copied = 0;
-		/* n is multiple of 32 */
-		while (copied < n) {
-			memcpy(&cache_objs[copied], &txep[copied], 32 * sizeof(void *));
-			copied += 32;
-		}
-		cache->len += n;
-
-		if (cache->len >= cache->flushthresh) {
-			rte_mempool_ops_enqueue_bulk(mp, &cache->objs[cache->size],
-					cache->len - cache->size);
-			cache->len = cache->size;
-		}
+		static_assert(sizeof(*txep) == sizeof(struct rte_mbuf *),
+				"txep array is not similar to an array of rte_mbuf pointers");
+		rte_mbuf_raw_free_bulk(mp, (void *)txep, n);
 		goto done;
 	}
 
-normal:
 	m = rte_pktmbuf_prefree_seg(txep[0].mbuf);
 	if (likely(m)) {
 		free[0] = m;
-- 
2.43.0

