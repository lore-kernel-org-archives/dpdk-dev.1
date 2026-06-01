Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B361CD6E55
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 18:36:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8ED4340652;
	Mon,  1 Jun 2026 20:36:25 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 3C3BA402DB
 for <dev@dpdk.org>; Mon,  1 Jun 2026 20:36:24 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 0D08320ADF;
 Mon,  1 Jun 2026 20:36:24 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Mon, 1 Jun 2026 20:36:23 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: dev@dpdk.org, Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>,
 Jingjing Wu <jingjing.wu@intel.com>,
 Praveen Shetty <praveen.shetty@intel.com>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@oss.nxp.com>
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v7] mempool/dpaa: update for new mempool cache algorithm
Date: Mon,  1 Jun 2026 18:36:20 +0000
Message-ID: <20260601183621.252920-2-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260601183621.252920-1-mb@smartsharesystems.com>
References: <20260408141315.904381-1-mb@smartsharesystems.com>
 <20260601183621.252920-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Jun 2026 18:36:23.0353 (UTC)
 FILETIME=[8C11CA90:01DCF1F5]
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
v7:
* Rebased.
v6:
* Moved driver changes out as separate patches, for easier review. (Bruce)
---
Depends-on: patch-164745 ("mempool: improve cache behaviour and performance")
---
 drivers/mempool/dpaa/dpaa_mempool.c | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/mempool/dpaa/dpaa_mempool.c b/drivers/mempool/dpaa/dpaa_mempool.c
index 2f9395b3f4..2f8555a026 100644
--- a/drivers/mempool/dpaa/dpaa_mempool.c
+++ b/drivers/mempool/dpaa/dpaa_mempool.c
@@ -58,8 +58,6 @@ dpaa_mbuf_create_pool(struct rte_mempool *mp)
 	struct bman_pool_params params = {
 		.flags = BMAN_POOL_FLAG_DYNAMIC_BPID
 	};
-	unsigned int lcore_id;
-	struct rte_mempool_cache *cache;
 
 	MEMPOOL_INIT_FUNC_TRACE();
 
@@ -129,18 +127,6 @@ dpaa_mbuf_create_pool(struct rte_mempool *mp)
 	rte_memcpy(bp_info, (void *)&rte_dpaa_bpid_info[bpid],
 		   sizeof(struct dpaa_bp_info));
 	mp->pool_data = (void *)bp_info;
-	/* Update per core mempool cache threshold to optimal value which is
-	 * number of buffers that can be released to HW buffer pool in
-	 * a single API call.
-	 */
-	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
-		cache = &mp->local_cache[lcore_id];
-		DPAA_MEMPOOL_DEBUG("lCore %d: cache->flushthresh %d -> %d",
-			lcore_id, cache->flushthresh,
-			(uint32_t)(cache->size + DPAA_MBUF_MAX_ACQ_REL));
-		if (cache->flushthresh)
-			cache->flushthresh = cache->size + DPAA_MBUF_MAX_ACQ_REL;
-	}
 
 	DPAA_MEMPOOL_INFO("BMAN pool created for bpid =%d", bpid);
 	return 0;
-- 
2.43.0

