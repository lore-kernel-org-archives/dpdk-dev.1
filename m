Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45267C61DC6
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Aug 2026 15:10:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0DF5B40150;
	Thu, 27 Aug 2026 17:10:19 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
 by mails.dpdk.org (Postfix) with ESMTP id 91AB04003C
 for <dev@dpdk.org>; Thu, 27 Aug 2026 17:10:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1787843417; x=1819379417;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=G7cMKLFQL3mNXMMz+wOOCF8z2N60GCzywf3cehbOzZM=;
 b=WTUOev6EGuTQtn9gM6KK2ks7vn4RCMsYMXNyKHoIbj484k+qeOYEDNxM
 8WHzsdqtVZZfPlzUdWKxkliEOeLCKxlnhC54nFpHLQCpO80TAU3R3IQ/c
 K2Wteg+h1hJ6i0sLPU2NsQQZ405oCHlicAD+3/5vkuqimehxwE12lh7Xh
 ZfzE75fUCXJDplOGgU8ZYes+U7I8JV9yUr1v3jC9ejKKn/8KdQRozYVUo
 rQwbdu1fBEWnuoTApL0xouVCpaZJNIIu7IPYQkX11t1WtI5MJcTrpYLEd
 FQePY++/QUkFgVNEVw81sFKZ5+yNXq/Xml0v5nSWqzFqCpJv9TVkLw2GP g==;
X-CSE-ConnectionGUID: nDD3PnQFSJe6v4Z4e3V+WQ==
X-CSE-MsgGUID: vtKP6NI2Q36ff9VYbK1/cw==
X-IronPort-AV: E=McAfee;i="6800,10657,11888"; a="75886659"
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="75886659"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
 by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 27 Aug 2026 08:10:16 -0700
X-CSE-ConnectionGUID: cxLS2C/fQYeIMCa5b0IcNg==
X-CSE-MsgGUID: EfpMzisQTXSpU6bhNyx2Iw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,246,1779174000"; d="scan'208";a="271420895"
Received: from silpixa00400465.ir.intel.com ([10.20.224.190])
 by orviesa003.jf.intel.com with ESMTP; 27 Aug 2026 08:10:15 -0700
From: Kai Ji <kai.ji@intel.com>
To: dev@dpdk.org
Cc: Kai Ji <kai.ji@intel.com>, Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Jie Liu <liujie5@linkdatatechnology.com>
Subject: [dpdk-dev v2] net/sxe2: replace private mempool cache bypass with
 rte_mbuf_raw_free_bulk
Date: Thu, 27 Aug 2026 15:10:10 +0000
Message-ID: <20260827151011.2122104-1-kai.ji@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260820155008.1989965-1-kai.ji@intel.com>
References: <20260820155008.1989965-1-kai.ji@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The AVX-512 TX completion path directly manipulated the mempool cache
internals (cache->objs, cache->len, cache->flushthresh) instead of using
the mempool API.  This pattern is the same private bypass that existed in
the Intel common TX library before it was removed by commit 062d6fe5d0e4
("net/intel: do not bypass mbuf lib for buffer fast-free") for the same
reason: it omits mbuf instrumentation (history marking) and contains
dead flush code that accesses cache->objs[cache->size], which is one
past the end of the array when cache_size == RTE_MEMPOOL_CACHE_MAX_SIZE.

Replace with a single rte_mbuf_raw_free_bulk() call, matching the Intel
common library.  The MBUF_FAST_FREE offload guarantee (single pool,
refcnt == 1) makes this correct and the compiler inlines the bulk-free
call to eliminate the overhead difference.

Signed-off-by: Kai Ji <kai.ji@intel.com>
---
 drivers/net/sxe2/sxe2_txrx_vec_avx512.c | 38 ++-----------------------
 1 file changed, 3 insertions(+), 35 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_txrx_vec_avx512.c b/drivers/net/sxe2/sxe2_txrx_vec_avx512.c
index a830c7a33b..7311c9d35a 100644
--- a/drivers/net/sxe2/sxe2_txrx_vec_avx512.c
+++ b/drivers/net/sxe2/sxe2_txrx_vec_avx512.c
@@ -18,9 +18,6 @@ static __rte_always_inline int32_t sxe2_tx_bufs_free_vec_avx512(struct sxe2_tx_q
 	struct rte_mbuf *mbuf;
 	struct rte_mbuf *mbuf_free_arr[SXE2_TX_FREE_BUFFER_SIZE_MAX_VEC];
 	struct rte_mempool *mp;
-	struct rte_mempool_cache *cache;
-	void **cache_objs;
-	uint32_t copied;
 	uint32_t i;
 	int32_t ret;
 	uint16_t rs_thresh;
@@ -41,41 +38,12 @@ static __rte_always_inline int32_t sxe2_tx_bufs_free_vec_avx512(struct sxe2_tx_q
 	if ((txq->offloads & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE) &&
 			(rs_thresh & 31) == 0) {
 		mp = buffer[0].mbuf->pool;
-		cache = rte_mempool_default_cache(mp, rte_lcore_id());
-
-		if (cache == NULL || cache->len)
-			goto normal;
-
-		if (rs_thresh > RTE_MEMPOOL_CACHE_MAX_SIZE) {
-			(void)rte_mempool_ops_enqueue_bulk(mp, (void *)buffer, rs_thresh);
-			goto done;
-		}
-		cache_objs = &cache->objs[cache->len];
-
-		copied = 0;
-		while (copied < rs_thresh) {
-			const __m512i objs0 = _mm512_loadu_si512(&buffer[copied]);
-			const __m512i objs1 = _mm512_loadu_si512(&buffer[copied + 8]);
-			const __m512i objs2 = _mm512_loadu_si512(&buffer[copied + 16]);
-			const __m512i objs3 = _mm512_loadu_si512(&buffer[copied + 24]);
-
-			_mm512_storeu_si512(&cache_objs[copied], objs0);
-			_mm512_storeu_si512(&cache_objs[copied + 8], objs1);
-			_mm512_storeu_si512(&cache_objs[copied + 16], objs2);
-			_mm512_storeu_si512(&cache_objs[copied + 24], objs3);
-			copied += 32;
-		}
-		cache->len += rs_thresh;
-
-		if (cache->len >= cache->flushthresh) {
-			(void)rte_mempool_ops_enqueue_bulk(mp,
-					&cache->objs[cache->size], cache->len - cache->size);
-			cache->len = cache->size;
-		}
+		static_assert(sizeof(buffer[0]) == sizeof(struct rte_mbuf *),
+			"sxe2_tx_buffer_vec must be pointer-sized for bulk free cast");
+		rte_mbuf_raw_free_bulk(mp, (void *)buffer, rs_thresh);
 		goto done;
 	}
 
-normal:
 	mbuf = rte_pktmbuf_prefree_seg(buffer[0].mbuf);
 
 	if (likely(mbuf)) {
-- 
2.43.0

