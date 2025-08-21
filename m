Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C448CA0EF8
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 Aug 2025 15:03:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4BC6E40657;
	Thu, 21 Aug 2025 17:02:56 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id DF4B3402ED
 for <dev@dpdk.org>; Thu, 21 Aug 2025 17:02:52 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id B3A24215A1;
 Thu, 21 Aug 2025 17:02:52 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Thu, 21 Aug 2025 17:02:52 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Ivan Malov <ivan.malov@arknetworks.am>,
 Chengwen Feng <fengchengwen@huawei.com>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v5 2/3] promote reinitialized mbuf free and alloc bulk
 functions as stable
Date: Thu, 21 Aug 2025 15:02:49 +0000
Message-ID: <20250821150250.16959-3-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250821150250.16959-1-mb@smartsharesystems.com>
References: <20250821150250.16959-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 21 Aug 2025 15:02:52.0213 (UTC)
 FILETIME=[AAB7F650:01DC12AC]
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

Ethdev drivers should use these APIs for allocating/freeing mbufs instead
of bypassing the mbuf library and accessing the mempool APIs, so they
cannot be experimental anymore.

Also updated the packet mbuf alloc bulk function to use the reinitialized
mbuf (a.k.a. raw mbuf) alloc bulk function, now that it is stable.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
v5:
* Fix compiler warning.
---
 lib/mbuf/rte_mbuf.h | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
index 552cda1ae5..49c93ab356 100644
--- a/lib/mbuf/rte_mbuf.h
+++ b/lib/mbuf/rte_mbuf.h
@@ -635,9 +635,6 @@ static inline struct rte_mbuf *rte_mbuf_raw_alloc(struct rte_mempool *mp)
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: This API may change, or be removed, without prior notice.
- *
  * Allocate a bulk of uninitialized mbufs from mempool *mp*.
  *
  * This function can be used by PMDs (especially in Rx functions)
@@ -661,7 +658,6 @@ static inline struct rte_mbuf *rte_mbuf_raw_alloc(struct rte_mempool *mp)
  *   - 0: Success.
  *   - -ENOENT: Not enough entries in the mempool; no mbufs are retrieved.
  */
-__rte_experimental
 static __rte_always_inline int
 rte_mbuf_raw_alloc_bulk(struct rte_mempool *mp, struct rte_mbuf **mbufs, unsigned int count)
 {
@@ -694,9 +690,6 @@ rte_mbuf_raw_free(struct rte_mbuf *m)
 }
 
 /**
- * @warning
- * @b EXPERIMENTAL: This API may change, or be removed, without prior notice.
- *
  * Put a bulk of mbufs allocated from the same mempool back into the mempool.
  *
  * The caller must ensure that the mbufs come from the specified mempool,
@@ -716,7 +709,6 @@ rte_mbuf_raw_free(struct rte_mbuf *m)
  * @param count
  *   Array size.
  */
-__rte_experimental
 static __rte_always_inline void
 rte_mbuf_raw_free_bulk(struct rte_mempool *mp, struct rte_mbuf **mbufs, unsigned int count)
 {
@@ -1029,7 +1021,7 @@ static inline int rte_pktmbuf_alloc_bulk(struct rte_mempool *pool,
 	unsigned idx = 0;
 	int rc;
 
-	rc = rte_mempool_get_bulk(pool, (void **)mbufs, count);
+	rc = rte_mbuf_raw_alloc_bulk(pool, mbufs, count);
 	if (unlikely(rc))
 		return rc;
 
@@ -1041,22 +1033,18 @@ static inline int rte_pktmbuf_alloc_bulk(struct rte_mempool *pool,
 	switch (count % 4) {
 	case 0:
 		while (idx != count) {
-			__rte_mbuf_raw_sanity_check_mp(mbufs[idx], pool);
 			rte_pktmbuf_reset(mbufs[idx]);
 			idx++;
 			/* fall-through */
 	case 3:
-			__rte_mbuf_raw_sanity_check_mp(mbufs[idx], pool);
 			rte_pktmbuf_reset(mbufs[idx]);
 			idx++;
 			/* fall-through */
 	case 2:
-			__rte_mbuf_raw_sanity_check_mp(mbufs[idx], pool);
 			rte_pktmbuf_reset(mbufs[idx]);
 			idx++;
 			/* fall-through */
 	case 1:
-			__rte_mbuf_raw_sanity_check_mp(mbufs[idx], pool);
 			rte_pktmbuf_reset(mbufs[idx]);
 			idx++;
 			/* fall-through */
-- 
2.43.0

