Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69001EFB7F9
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Feb 2026 09:28:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3804C402DF;
	Tue, 24 Feb 2026 10:28:14 +0100 (CET)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 73A994027F
 for <dev@dpdk.org>; Tue, 24 Feb 2026 10:28:12 +0100 (CET)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 4314E206CD;
 Tue, 24 Feb 2026 10:28:12 +0100 (CET)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Tue, 24 Feb 2026 10:28:09 +0100
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Stephen Hemminger <stephen@networkplumber.org>, dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v2] mempool: introduce statistics reset function
Date: Tue, 24 Feb 2026 09:28:02 +0000
Message-ID: <20260224092802.359592-1-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260223102054.336350-1-mb@smartsharesystems.com>
References: <20260223102054.336350-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 24 Feb 2026 09:28:09.0085 (UTC)
 FILETIME=[E37D12D0:01DCA56F]
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

Populating a mempool with objects is accounted for in the statistics.
When analyzing mempool cache statistics, this may distort the data.
In order to simplify mempool cache statistics analysis, a mempool
statistics reset function was added.

Furthermore, details about average burst sizes and mempool cache miss
rates were added to the statistics shown when dumping a mempool.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
---
v2:
* Added detailed usage instructions to the function description. (Andrew)
* Added DEBUG log message to the function. (Andrew)
---
 lib/mempool/mempool_trace.h        |  7 ++++
 lib/mempool/mempool_trace_points.c |  4 +++
 lib/mempool/rte_mempool.c          | 51 ++++++++++++++++++++++++++++--
 lib/mempool/rte_mempool.h          | 29 +++++++++++++++++
 4 files changed, 89 insertions(+), 2 deletions(-)

diff --git a/lib/mempool/mempool_trace.h b/lib/mempool/mempool_trace.h
index c595a3116b..23cda1473c 100644
--- a/lib/mempool/mempool_trace.h
+++ b/lib/mempool/mempool_trace.h
@@ -104,6 +104,13 @@ RTE_TRACE_POINT(
 	rte_trace_point_emit_string(mempool->name);
 )
 
+RTE_TRACE_POINT(
+	rte_mempool_trace_stats_reset,
+	RTE_TRACE_POINT_ARGS(struct rte_mempool *mempool),
+	rte_trace_point_emit_ptr(mempool);
+	rte_trace_point_emit_string(mempool->name);
+)
+
 RTE_TRACE_POINT(
 	rte_mempool_trace_cache_create,
 	RTE_TRACE_POINT_ARGS(uint32_t size, int socket_id,
diff --git a/lib/mempool/mempool_trace_points.c b/lib/mempool/mempool_trace_points.c
index ec465780f4..8249981502 100644
--- a/lib/mempool/mempool_trace_points.c
+++ b/lib/mempool/mempool_trace_points.c
@@ -60,6 +60,10 @@ RTE_TRACE_POINT_REGISTER(rte_mempool_trace_populate_default,
 RTE_TRACE_POINT_REGISTER(rte_mempool_trace_populate_anon,
 	lib.mempool.populate.anon)
 
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(__rte_mempool_trace_stats_reset, 26.03)
+RTE_TRACE_POINT_REGISTER(rte_mempool_trace_stats_reset,
+	lib.mempool.stats_reset)
+
 RTE_TRACE_POINT_REGISTER(rte_mempool_trace_cache_create,
 	lib.mempool.cache_create)
 
diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index 3042d94c14..d33ea15157 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -1049,6 +1049,29 @@ rte_mempool_in_use_count(const struct rte_mempool *mp)
 	return mp->size - rte_mempool_avail_count(mp);
 }
 
+/* Reset the statistics of a mempool. */
+RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_mempool_stats_reset, 26.03)
+void
+rte_mempool_stats_reset(struct rte_mempool *mp)
+{
+	RTE_ASSERT(mp != NULL);
+
+#ifdef RTE_LIBRTE_MEMPOOL_STATS
+	memset(&mp->stats, 0, sizeof(mp->stats));
+	if (mp->cache_size != 0) {
+		for (unsigned int lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
+			memset(&mp->local_cache[lcore_id].stats, 0,
+					sizeof(mp->local_cache[lcore_id].stats));
+		}
+	}
+
+	RTE_MEMPOOL_LOG(DEBUG, "<%s>@%p: statistics reset", mp->name, mp);
+	rte_mempool_trace_stats_reset(mp);
+#else
+	RTE_SET_USED(mp);
+#endif
+}
+
 /* dump the cache status */
 static unsigned
 rte_mempool_dump_cache(FILE *f, const struct rte_mempool *mp)
@@ -1327,10 +1350,34 @@ rte_mempool_dump(FILE *f, struct rte_mempool *mp)
 	fprintf(f, "    get_fail_bulk=%"PRIu64"\n", sum.get_fail_bulk);
 	fprintf(f, "    get_fail_objs=%"PRIu64"\n", sum.get_fail_objs);
 	if (info.contig_block_size > 0) {
-		fprintf(f, "    get_success_blks=%"PRIu64"\n",
-			sum.get_success_blks);
+		fprintf(f, "    get_success_blks=%"PRIu64"\n", sum.get_success_blks);
 		fprintf(f, "    get_fail_blks=%"PRIu64"\n", sum.get_fail_blks);
 	}
+	fprintf(f, "    avg objs/bulk put=%#Lf, get=%#Lf, get_fail=%#Lf\n",
+			sum.put_bulk != 0 ? (long double)sum.put_objs / sum.put_bulk : 0,
+			sum.get_success_bulk != 0 ?
+			(long double)sum.get_success_objs / sum.get_success_bulk : 0,
+			sum.get_fail_bulk != 0 ?
+			(long double)sum.get_fail_objs / sum.get_fail_bulk : 0);
+	fprintf(f, "    avg common_pool objs/bulk put=%#Lf, get=%#Lf\n",
+			sum.put_common_pool_bulk != 0 ?
+			(long double)sum.put_common_pool_objs / sum.put_common_pool_bulk : 0,
+			sum.get_common_pool_bulk != 0 ?
+			(long double)sum.get_common_pool_objs / sum.get_common_pool_bulk : 0);
+	fprintf(f, "    avg cache miss rate put_objs=%s%#Lf, get_objs=%s%#Lf\n",
+			sum.put_common_pool_objs != 0 ? "1/" : "",
+			sum.put_common_pool_objs != 0 ?
+			(long double)sum.put_objs / sum.put_common_pool_objs : 0,
+			sum.get_common_pool_objs != 0 ? "1/" : "",
+			sum.get_common_pool_objs != 0 ?
+			(long double)sum.get_success_objs / sum.get_common_pool_objs : 0);
+	fprintf(f, "    avg cache miss rate put_bulk=%s%#Lf, get_bulk=%s%#Lf\n",
+			sum.put_common_pool_bulk != 0 ? "1/" : "",
+			sum.put_common_pool_bulk != 0 ?
+			(long double)sum.put_bulk / sum.put_common_pool_bulk : 0,
+			sum.get_common_pool_bulk != 0 ? "1/" : "",
+			sum.get_common_pool_bulk != 0 ?
+			(long double)sum.get_success_bulk / sum.get_common_pool_bulk : 0);
 #else
 	fprintf(f, "  no statistics available\n");
 #endif
diff --git a/lib/mempool/rte_mempool.h b/lib/mempool/rte_mempool.h
index 1144dca58a..0b62837534 100644
--- a/lib/mempool/rte_mempool.h
+++ b/lib/mempool/rte_mempool.h
@@ -1288,6 +1288,35 @@ uint32_t rte_mempool_obj_iter(struct rte_mempool *mp,
 uint32_t rte_mempool_mem_iter(struct rte_mempool *mp,
 	rte_mempool_mem_cb_t *mem_cb, void *mem_cb_arg);
 
+/**
+ * @warning
+ * @b EXPERIMENTAL: This API may change, or be removed, without prior notice.
+ *
+ * Reset the statistics of a mempool.
+ *
+ * This function is intended for use when analyzing mempool statistics
+ * without counting any mempool operations performed during application
+ * initialization.
+ * For example, populating the mempool counts as put operations into the
+ * common pool, and setting up ethdev Rx queues counts as get operations.
+ *
+ * This function should only be called after application initialization,
+ * before the data path is started; otherwise, the mempool statistics may
+ * become inconsistent.
+ *
+ * For a perfectly clean slate, the local caches of the mempools used
+ * during application initialization should be flushed before resetting
+ * the mempool statistics.
+ * For example, mbuf pools used by ethdev Rx queues.
+ *
+ * @see rte_mempool_cache_flush()
+ *
+ * @param mp
+ *   A pointer to the mempool structure.
+ */
+__rte_experimental
+void rte_mempool_stats_reset(struct rte_mempool *mp);
+
 /**
  * Dump the status of the mempool to a file.
  *
-- 
2.43.0

