Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC918CD5BD5
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 May 2026 11:36:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D565940659;
	Wed, 27 May 2026 13:36:53 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id A937040285
 for <dev@dpdk.org>; Wed, 27 May 2026 13:36:51 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 7A42A20C5D;
 Wed, 27 May 2026 13:36:51 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Wed, 27 May 2026 13:36:50 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@oss.nxp.com>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v6] mempool/dpaa2: update for new mempool cache algorithm
Date: Wed, 27 May 2026 11:36:44 +0000
Message-ID: <20260527113644.222538-3-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527113644.222538-1-mb@smartsharesystems.com>
References: <20260408141315.904381-1-mb@smartsharesystems.com>
 <20260527113644.222538-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 27 May 2026 11:36:50.0929 (UTC)
 FILETIME=[1C11F610:01DCEDCD]
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

As a consequence of the improved mempool cache algorithm, the mempool
driver was updated to not modify the mempool cache's flushthresh field,
which is now obsolete, and modifying it has no effect.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
Depends-on: patch-164427 ("mempool: improve cache behaviour and performance")
---
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/mempool/dpaa2/dpaa2_hw_mempool.c b/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
index 02b6741853..ee001d8ce0 100644
--- a/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
+++ b/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
@@ -54,8 +54,6 @@ rte_hw_mbuf_create_pool(struct rte_mempool *mp)
 	struct dpaa2_bp_info *bp_info;
 	struct dpbp_attr dpbp_attr;
 	uint32_t bpid;
-	unsigned int lcore_id;
-	struct rte_mempool_cache *cache;
 	int ret;
 
 	avail_dpbp = dpaa2_alloc_dpbp_dev();
@@ -152,18 +150,6 @@ rte_hw_mbuf_create_pool(struct rte_mempool *mp)
 	DPAA2_MEMPOOL_DEBUG("BP List created for bpid =%d", dpbp_attr.bpid);
 
 	h_bp_list = bp_list;
-	/* Update per core mempool cache threshold to optimal value which is
-	 * number of buffers that can be released to HW buffer pool in
-	 * a single API call.
-	 */
-	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		cache = &mp->local_cache[lcore_id];
-		DPAA2_MEMPOOL_DEBUG("lCore %d: cache->flushthresh %d -> %d",
-			lcore_id, cache->flushthresh,
-			(uint32_t)(cache->size + DPAA2_MBUF_MAX_ACQ_REL));
-		if (cache->flushthresh)
-			cache->flushthresh = cache->size + DPAA2_MBUF_MAX_ACQ_REL;
-	}
 
 	return 0;
 err4:
-- 
2.43.0

