Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A0EC982E6
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 15:52:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 486DE40E2B;
	Mon, 21 Sep 2026 17:52:20 +0200 (CEST)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.4])
 by mails.dpdk.org (Postfix) with ESMTP id 9A1E8402B0;
 Mon, 21 Sep 2026 17:52:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1790005939; x=1821541939;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UkPga1itysdXQOngwB3Az6qP5252JDYr558leN3eTaY=;
 b=GEznV5LKFA4hhN8ausFFcGurerqfRwNNiYw/rCjHyrm54Lzyy0jV4tGT
 ip9WQ/u0jK+2yop3u6w6d85rhYqdZktQ2Oqja+PTOcS/+aYzXUDNt434e
 xOlkax4K18/n4s2daoyc+iP/URK8PZ1xGSkro47UidERvaEQm5y7/lJjm
 0AkoUVWQu923HznE6smac+XyVDp6rWntAaZFGZKGZQ72NXbiXe5G3YovH
 yXQJiSPn/qSxNeI3blkFKq5oyKFTfeL7kV/rpcp6AT8nEaIM7H6wQOFDP
 8R36TO2qcWBZ33j+6JH+su2VbYSlsvAaT82ppUZOtIq8wJw9KV3Fjy1ld w==;
X-CSE-ConnectionGUID: /C6bL75KR+yXohFeMgw6mA==
X-CSE-MsgGUID: pcCCZlTGT/e13wDIr3gFhg==
X-IronPort-AV: E=McAfee;i="6800,10657,11912"; a="1040268"
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; 
   d="scan'208";a="1040268"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
 by fmvoesa114.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 21 Sep 2026 08:52:18 -0700
X-CSE-ConnectionGUID: 0yxhzTKcTsKEkmGxpO8byQ==
X-CSE-MsgGUID: IQVOancfSjuFryb0oL6d+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,115,1787036400"; d="scan'208";a="272211670"
Received: from silpixa00401840.ir.intel.com ([10.20.224.243])
 by fmviesa007.fm.intel.com with ESMTP; 21 Sep 2026 08:52:16 -0700
From: Kai Ji <kai.ji@intel.com>
To: dev@dpdk.org
Cc: Kai Ji <kai.ji@intel.com>, stable@dpdk.org,
 Bruce Richardson <bruce.richardson@intel.com>,
 Konstantin Ananyev <konstantin.ananyev@huawei.com>,
 Jie Liu <liujie5@linkdatatechnology.com>
Subject: [PATCH v3] net/sxe2: replace private mempool cache bypass with
 rte_mbuf_raw_free_bulk
Date: Mon, 21 Sep 2026 15:52:13 +0000
Message-Id: <20260921155214.2690954-1-kai.ji@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260827151011.2122104-1-kai.ji@intel.com>
References: <20260827151011.2122104-1-kai.ji@intel.com>
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
the Intel common TX library before it was removed by commit 062d6fe5d00d
("net/intel: do not bypass mbuf lib for buffer fast-free") for the same
reason: it omits mbuf instrumentation (history marking) and reaches
directly into mempool cache internals, including the flushthresh field
that is now obsolete (kept only for API/ABI compatibility), making the
private fast path fragile against mempool cache layout changes.

Replace with a single rte_mbuf_raw_free_bulk() call, matching the Intel
common library.  The RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE contract in
rte_ethdev.h requires the application to guarantee that per-queue all
mbufs come from the same mempool, have refcnt == 1, and are direct;
that documented guarantee, whose @see already points to
rte_mbuf_raw_free_bulk(), is exactly what makes this call correct.  The
compiler inlines the bulk-free call to eliminate the overhead
difference.

Fixes: 0af0bdcdcf83 ("net/sxe2: add AVX512 Rx and Tx")
Cc: stable@dpdk.org

Signed-off-by: Kai Ji <kai.ji@intel.com>
---
 drivers/net/sxe2/sxe2_txrx_vec_avx512.c | 39 +++----------------------
 1 file changed, 4 insertions(+), 35 deletions(-)

diff --git a/drivers/net/sxe2/sxe2_txrx_vec_avx512.c b/drivers/net/sxe2/sxe2_txrx_vec_avx512.c
index a830c7a33b..1a4ebd93c3 100644
--- a/drivers/net/sxe2/sxe2_txrx_vec_avx512.c
+++ b/drivers/net/sxe2/sxe2_txrx_vec_avx512.c
@@ -12,15 +12,15 @@
 #include "sxe2_txrx_vec_common.h"
 #include "sxe2_vsi.h"
 
+static_assert(sizeof(struct sxe2_tx_buffer_vec) == sizeof(struct rte_mbuf *),
+	"sxe2_tx_buffer_vec must be pointer-sized for bulk free cast");
+
 static __rte_always_inline int32_t sxe2_tx_bufs_free_vec_avx512(struct sxe2_tx_queue *txq)
 {
 	struct sxe2_tx_buffer_vec *buffer;
 	struct rte_mbuf *mbuf;
 	struct rte_mbuf *mbuf_free_arr[SXE2_TX_FREE_BUFFER_SIZE_MAX_VEC];
 	struct rte_mempool *mp;
-	struct rte_mempool_cache *cache;
-	void **cache_objs;
-	uint32_t copied;
 	uint32_t i;
 	int32_t ret;
 	uint16_t rs_thresh;
@@ -41,41 +41,10 @@ static __rte_always_inline int32_t sxe2_tx_bufs_free_vec_avx512(struct sxe2_tx_q
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
+		rte_mbuf_raw_free_bulk(mp, (void *)buffer, rs_thresh);
 		goto done;
 	}
 
-normal:
 	mbuf = rte_pktmbuf_prefree_seg(buffer[0].mbuf);
 
 	if (likely(mbuf)) {
-- 
2.34.1

