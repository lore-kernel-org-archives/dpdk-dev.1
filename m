Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B887ACD6E55
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Jun 2026 18:36:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77C6340662;
	Mon,  1 Jun 2026 20:36:26 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 4CB67402F1
 for <dev@dpdk.org>; Mon,  1 Jun 2026 20:36:24 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 1499020BBA;
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
Subject: [PATCH v7] net/idpf: update for new mempool cache algorithm
Date: Mon,  1 Jun 2026 18:36:19 +0000
Message-ID: <20260601183621.252920-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260408141315.904381-1-mb@smartsharesystems.com>
References: <20260408141315.904381-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Jun 2026 18:36:23.0150 (UTC)
 FILETIME=[8BF2D0E0:01DCF1F5]
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

As a consequence of the improved mempool cache algorithm, the PMD was
updated regarding how much to backfill the mempool cache in the AVX512
code path.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
v7:
* Rebased.
v6:
* Moved driver changes out as separate patches, for easier review. (Bruce)
---
Depends-on: patch-164745 ("mempool: improve cache behaviour and performance")
---
 .../net/intel/idpf/idpf_common_rxtx_avx512.c  | 52 +++++++++++++++----
 1 file changed, 42 insertions(+), 10 deletions(-)

diff --git a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
index 8db4c64106..5788a009ab 100644
--- a/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
+++ b/drivers/net/intel/idpf/idpf_common_rxtx_avx512.c
@@ -148,15 +148,31 @@ idpf_singleq_rearm(struct idpf_rx_queue *rxq)
 	/* Can this be satisfied from the cache? */
 	if (cache->len < IDPF_RXQ_REARM_THRESH) {
 		/* No. Backfill the cache first, and then fill from it */
-		uint32_t req = IDPF_RXQ_REARM_THRESH + (cache->size -
-							cache->len);
 
-		/* How many do we require i.e. number to fill the cache + the request */
+		/* Backfill would exceed the cache bounce buffer limit? */
+		__rte_assume(cache->size / 2 <= RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
+		if (unlikely(cache->size / 2 < IDPF_RXQ_REARM_THRESH)) {
+			idpf_singleq_rearm_common(rxq);
+			return;
+		}
+
+		/*
+		 * Backfill the cache from the backend;
+		 * move up the hot objects in the cache to the top half of the cache,
+		 * and fetch (size / 2) objects to the bottom of the cache.
+		 */
+		__rte_assume(cache->len < cache->size / 2);
+		rte_memcpy(&cache->objs[cache->size / 2], &cache->objs[0],
+				sizeof(void *) * cache->len);
 		int ret = rte_mempool_ops_dequeue_bulk
-				(rxq->mp, &cache->objs[cache->len], req);
+				(rxq->mp, &cache->objs[0], cache->size / 2);
 		if (ret == 0) {
-			cache->len += req;
+			cache->len += cache->size / 2;
 		} else {
+			/*
+			 * No further action is required for roll back, as the objects moved
+			 * in the cache were actually copied, and the cache remains intact.
+			 */
 			if (rxq->rxrearm_nb + IDPF_RXQ_REARM_THRESH >=
 			    rxq->nb_rx_desc) {
 				__m128i dma_addr0;
@@ -565,15 +581,31 @@ idpf_splitq_rearm(struct idpf_rx_queue *rx_bufq)
 	/* Can this be satisfied from the cache? */
 	if (cache->len < IDPF_RXQ_REARM_THRESH) {
 		/* No. Backfill the cache first, and then fill from it */
-		uint32_t req = IDPF_RXQ_REARM_THRESH + (cache->size -
-							cache->len);
 
-		/* How many do we require i.e. number to fill the cache + the request */
+		/* Backfill would exceed the cache bounce buffer limit? */
+		__rte_assume(cache->size / 2 <= RTE_MEMPOOL_CACHE_MAX_SIZE / 2);
+		if (unlikely(cache->size / 2 < IDPF_RXQ_REARM_THRESH)) {
+			idpf_splitq_rearm_common(rx_bufq);
+			return;
+		}
+
+		/*
+		 * Backfill the cache from the backend;
+		 * move up the hot objects in the cache to the top half of the cache,
+		 * and fetch (size / 2) objects to the bottom of the cache.
+		 */
+		__rte_assume(cache->len < cache->size / 2);
+		rte_memcpy(&cache->objs[cache->size / 2], &cache->objs[0],
+				sizeof(void *) * cache->len);
 		int ret = rte_mempool_ops_dequeue_bulk
-				(rx_bufq->mp, &cache->objs[cache->len], req);
+				(rx_bufq->mp, &cache->objs[0], cache->size / 2);
 		if (ret == 0) {
-			cache->len += req;
+			cache->len += cache->size / 2;
 		} else {
+			/*
+			 * No further action is required for roll back, as the objects moved
+			 * in the cache were actually copied, and the cache remains intact.
+			 */
 			if (rx_bufq->rxrearm_nb + IDPF_RXQ_REARM_THRESH >=
 			    rx_bufq->nb_rx_desc) {
 				__m128i dma_addr0;
-- 
2.43.0

