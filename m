Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C190C3600B
	for <dpdk-dev@archiver.kernel.org>; Mon, 31 Mar 2025 10:03:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19BA140666;
	Mon, 31 Mar 2025 12:03:54 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id C0FCC40650
 for <dev@dpdk.org>; Mon, 31 Mar 2025 12:03:51 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 9A52A2172C;
 Mon, 31 Mar 2025 12:03:51 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Mon, 31 Mar 2025 12:03:51 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v2 1/4] mempool perf test: replace bare unsigned with unsigned
 int
Date: Mon, 31 Mar 2025 10:03:39 +0000
Message-ID: <20250331100343.213430-2-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250331100343.213430-1-mb@smartsharesystems.com>
References: <20250228164858.274204-1-mb@smartsharesystems.com>
 <20250331100343.213430-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 31 Mar 2025 10:03:51.0344 (UTC)
 FILETIME=[340E5B00:01DBA224]
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

Updated old code using bare "unsigned" with "unsigned int".

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
---
 app/test/test_mempool_perf.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/app/test/test_mempool_perf.c b/app/test/test_mempool_perf.c
index 4dd74ef75a..d4271a5ef9 100644
--- a/app/test/test_mempool_perf.c
+++ b/app/test/test_mempool_perf.c
@@ -89,16 +89,16 @@
 	} while (0)
 
 static int use_external_cache;
-static unsigned external_cache_size = RTE_MEMPOOL_CACHE_MAX_SIZE;
+static unsigned int external_cache_size = RTE_MEMPOOL_CACHE_MAX_SIZE;
 
 static RTE_ATOMIC(uint32_t) synchro;
 
 /* number of objects in one bulk operation (get or put) */
-static unsigned n_get_bulk;
-static unsigned n_put_bulk;
+static unsigned int n_get_bulk;
+static unsigned int n_put_bulk;
 
 /* number of objects retrieved from mempool before putting them back */
-static unsigned n_keep;
+static unsigned int n_keep;
 
 /* true if we want to test with constant n_get_bulk and n_put_bulk */
 static int use_constant_values;
@@ -118,7 +118,7 @@ static struct mempool_test_stats stats[RTE_MAX_LCORE];
  */
 static void
 my_obj_init(struct rte_mempool *mp, __rte_unused void *arg,
-	    void *obj, unsigned i)
+	    void *obj, unsigned int i)
 {
 	uint32_t *objnum = obj;
 	memset(obj, 0, mp->elt_size);
@@ -163,7 +163,7 @@ static int
 per_lcore_mempool_test(void *arg)
 {
 	struct rte_mempool *mp = arg;
-	unsigned lcore_id = rte_lcore_id();
+	unsigned int lcore_id = rte_lcore_id();
 	int ret = 0;
 	uint64_t start_cycles, end_cycles;
 	uint64_t time_diff = 0, hz = rte_get_timer_hz();
@@ -246,10 +246,10 @@ per_lcore_mempool_test(void *arg)
 static int
 launch_cores(struct rte_mempool *mp, unsigned int cores)
 {
-	unsigned lcore_id;
+	unsigned int lcore_id;
 	uint64_t rate;
 	int ret;
-	unsigned cores_save = cores;
+	unsigned int cores_save = cores;
 	double hz = rte_get_timer_hz();
 
 	rte_atomic_store_explicit(&synchro, 0, rte_memory_order_relaxed);
@@ -260,7 +260,7 @@ launch_cores(struct rte_mempool *mp, unsigned int cores)
 	printf("mempool_autotest cache=%u cores=%u n_get_bulk=%u "
 	       "n_put_bulk=%u n_keep=%u constant_n=%u ",
 	       use_external_cache ?
-		   external_cache_size : (unsigned) mp->cache_size,
+		   external_cache_size : (unsigned int) mp->cache_size,
 	       cores, n_get_bulk, n_put_bulk, n_keep, use_constant_values);
 
 	if (rte_mempool_avail_count(mp) != MEMPOOL_SIZE) {
@@ -315,9 +315,9 @@ do_one_mempool_test(struct rte_mempool *mp, unsigned int cores, int external_cac
 	unsigned int bulk_tab_put[] = { 1, 4, CACHE_LINE_BURST, 32, 64, 128, 256,
 			RTE_MEMPOOL_CACHE_MAX_SIZE, 0 };
 	unsigned int keep_tab[] = { 32, 128, 512, 2048, 8192, 32768, 0 };
-	unsigned *get_bulk_ptr;
-	unsigned *put_bulk_ptr;
-	unsigned *keep_ptr;
+	unsigned int *get_bulk_ptr;
+	unsigned int *put_bulk_ptr;
+	unsigned int *keep_ptr;
 	int ret;
 
 	for (get_bulk_ptr = bulk_tab_get; *get_bulk_ptr; get_bulk_ptr++) {
-- 
2.43.0

