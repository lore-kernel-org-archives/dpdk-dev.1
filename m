Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5ED51075280
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Mar 2026 09:13:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C1E494025D;
	Thu, 19 Mar 2026 10:13:03 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 8B9324013F
 for <dev@dpdk.org>; Thu, 19 Mar 2026 10:13:02 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 59ED1205CA;
 Thu, 19 Mar 2026 10:13:02 +0100 (CET)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Thu, 19 Mar 2026 10:13:02 +0100
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org,
	Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH] doc: remove obsolete mempool creation advice
Date: Thu, 19 Mar 2026 09:13:00 +0000
Message-ID: <20260319091300.652853-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 19 Mar 2026 09:13:02.0060 (UTC)
 FILETIME=[965C4AC0:01DCB780]
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

The descriptions for the mempool creation functions contained advice for
choosing the optimum (in terms of memory usage) number of elements and
cache size.
The advice was based on implementation details, which was changed long
ago, making the advice completely irrelevant.

This obsolete advice was removed.

Also fixed a copy-paste bug in the rte_mempool_calc_obj_size() function
description.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
 lib/mbuf/rte_mbuf.h       | 12 +++---------
 lib/mempool/rte_mempool.h | 13 +++----------
 2 files changed, 6 insertions(+), 19 deletions(-)

diff --git a/lib/mbuf/rte_mbuf.h b/lib/mbuf/rte_mbuf.h
index 592af2388c..f571819211 100644
--- a/lib/mbuf/rte_mbuf.h
+++ b/lib/mbuf/rte_mbuf.h
@@ -780,9 +780,7 @@ void rte_pktmbuf_pool_init(struct rte_mempool *mp, void *opaque_arg);
  * @param name
  *   The name of the mbuf pool.
  * @param n
- *   The number of elements in the mbuf pool. The optimum size (in terms
- *   of memory usage) for a mempool is when n is a power of two minus one:
- *   n = (2^q - 1).
+ *   The number of elements in the mbuf pool.
  * @param cache_size
  *   Size of the per-core object cache. See rte_mempool_create() for
  *   details.
@@ -818,9 +816,7 @@ rte_pktmbuf_pool_create(const char *name, unsigned n,
  * @param name
  *   The name of the mbuf pool.
  * @param n
- *   The number of elements in the mbuf pool. The optimum size (in terms
- *   of memory usage) for a mempool is when n is a power of two minus one:
- *   n = (2^q - 1).
+ *   The number of elements in the mbuf pool.
  * @param cache_size
  *   Size of the per-core object cache. See rte_mempool_create() for
  *   details.
@@ -867,9 +863,7 @@ struct rte_pktmbuf_extmem {
  * @param name
  *   The name of the mbuf pool.
  * @param n
- *   The number of elements in the mbuf pool. The optimum size (in terms
- *   of memory usage) for a mempool is when n is a power of two minus one:
- *   n = (2^q - 1).
+ *   The number of elements in the mbuf pool.
  * @param cache_size
  *   Size of the per-core object cache. See rte_mempool_create() for
  *   details.
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index 2fa56464dc..2e54fc4466 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -1040,19 +1040,15 @@ rte_mempool_free(struct rte_mempool *mp);
  * @param name
  *   The name of the mempool.
  * @param n
- *   The number of elements in the mempool. The optimum size (in terms of
- *   memory usage) for a mempool is when n is a power of two minus one:
- *   n = (2^q - 1).
+ *   The number of elements in the mempool.
  * @param elt_size
  *   The size of each element.
  * @param cache_size
  *   If cache_size is non-zero, the rte_mempool library will try to
  *   limit the accesses to the common lockless pool, by maintaining a
  *   per-lcore object cache. This argument must be lower or equal to
- *   RTE_MEMPOOL_CACHE_MAX_SIZE and n / 1.5. It is advised to choose
- *   cache_size to have "n modulo cache_size == 0": if this is
- *   not the case, some elements will always stay in the pool and will
- *   never be used. The access to the per-lcore table is of course
+ *   RTE_MEMPOOL_CACHE_MAX_SIZE and n / 1.5.
+ *   The access to the per-lcore table is of course
  *   faster than the multi-producer/consumer pool. The cache can be
  *   disabled if the cache_size argument is set to 0; it can be useful to
  *   avoid losing objects in cache.
@@ -1130,8 +1126,6 @@ rte_mempool_create(const char *name, unsigned n, unsigned elt_size,
  *   The name of the mempool.
  * @param n
  *   The maximum number of elements that can be added in the mempool.
- *   The optimum size (in terms of memory usage) for a mempool is when n
- *   is a power of two minus one: n = (2^q - 1).
  * @param elt_size
  *   The size of each element.
  * @param cache_size
@@ -1889,7 +1883,6 @@ struct rte_mempool *rte_mempool_lookup(const char *name);
  * @param flags
  *   The flags used for the mempool creation.
  *   Consult rte_mempool_create() for more information about possible values.
- *   The size of each element.
  * @param sz
  *   The calculated detailed size the mempool object. May be NULL.
  * @return
-- 
2.43.0

