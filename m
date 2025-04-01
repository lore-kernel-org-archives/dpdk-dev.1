Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57E0BC36010
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Apr 2025 15:02:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7F52140E43;
	Tue,  1 Apr 2025 17:02:19 +0200 (CEST)
Received: from dkmailrelay1.smartsharesystems.com
 (smartserver.smartsharesystems.com [77.243.40.215])
 by mails.dpdk.org (Postfix) with ESMTP id 8906140E13
 for <dev@dpdk.org>; Tue,  1 Apr 2025 17:02:16 +0200 (CEST)
Received: from smartserver.smartsharesystems.com
 (smartserver.smartsharesys.local [192.168.4.10])
 by dkmailrelay1.smartsharesystems.com (Postfix) with ESMTP id 6C7A831723;
 Tue,  1 Apr 2025 17:02:16 +0200 (CEST)
Received: from dkrd4.smartsharesys.local ([192.168.4.26]) by
 smartserver.smartsharesystems.com with Microsoft SMTPSVC(6.0.3790.4675); 
 Tue, 1 Apr 2025 17:02:16 +0200
From: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
To: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>,
 Bruce Richardson <bruce.richardson@intel.com>, dev@dpdk.org
Cc: =?UTF-8?q?Morten=20Br=C3=B8rup?= <mb@smartsharesystems.com>
Subject: [PATCH v3 3/4] mempool perf test: improve output readability
Date: Tue,  1 Apr 2025 15:02:13 +0000
Message-ID: <20250401150214.4989-4-mb@smartsharesystems.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250401150214.4989-1-mb@smartsharesystems.com>
References: <20250228164858.274204-1-mb@smartsharesystems.com>
 <20250401150214.4989-1-mb@smartsharesystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Apr 2025 15:02:16.0146 (UTC)
 FILETIME=[0E901320:01DBA317]
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

Improved the output parameter ordering and formatting for readability.

Signed-off-by: Morten Brørup <mb@smartsharesystems.com>
Acked-by: Andrew Rybchenko <andrew.rybchenko@oktetlabs.ru>
---
 app/test/test_mempool_perf.c | 20 +++++++++++---------
 1 file changed, 11 insertions(+), 9 deletions(-)

diff --git a/app/test/test_mempool_perf.c b/app/test/test_mempool_perf.c
index 3594d81888..c252f1968a 100644
--- a/app/test/test_mempool_perf.c
+++ b/app/test/test_mempool_perf.c
@@ -257,11 +257,13 @@ launch_cores(struct rte_mempool *mp, unsigned int cores)
 	/* reset stats */
 	memset(stats, 0, sizeof(stats));
 
-	printf("mempool_autotest cache=%u cores=%u n_get_bulk=%u "
-	       "n_put_bulk=%u n_keep=%u constant_n=%u ",
-	       use_external_cache ?
-		   external_cache_size : (unsigned int) mp->cache_size,
-	       cores, n_get_bulk, n_put_bulk, n_keep, use_constant_values);
+	printf("mempool_autotest cache=%u cores=%u n_keep=%5u ",
+	       use_external_cache ? external_cache_size : (unsigned int) mp->cache_size,
+	       cores,
+	       n_keep);
+	printf("n_get_bulk=%3u n_put_bulk=%3u constant_n=%u ",
+	       n_get_bulk, n_put_bulk,
+	       use_constant_values);
 
 	if (rte_mempool_avail_count(mp) != MEMPOOL_SIZE) {
 		printf("mempool is not full\n");
@@ -301,7 +303,7 @@ launch_cores(struct rte_mempool *mp, unsigned int cores)
 			rate += (double)stats[lcore_id].enq_count * hz /
 					(double)stats[lcore_id].duration_cycles;
 
-	printf("rate_persec=%" PRIu64 "\n", rate);
+	printf("rate_persec=%10" PRIu64 "\n", rate);
 
 	return 0;
 }
@@ -320,9 +322,9 @@ do_one_mempool_test(struct rte_mempool *mp, unsigned int cores, int external_cac
 	unsigned int *keep_ptr;
 	int ret;
 
-	for (get_bulk_ptr = bulk_tab_get; *get_bulk_ptr; get_bulk_ptr++) {
-		for (put_bulk_ptr = bulk_tab_put; *put_bulk_ptr; put_bulk_ptr++) {
-			for (keep_ptr = keep_tab; *keep_ptr; keep_ptr++) {
+	for (keep_ptr = keep_tab; *keep_ptr; keep_ptr++) {
+		for (get_bulk_ptr = bulk_tab_get; *get_bulk_ptr; get_bulk_ptr++) {
+			for (put_bulk_ptr = bulk_tab_put; *put_bulk_ptr; put_bulk_ptr++) {
 
 				if (*keep_ptr < *get_bulk_ptr || *keep_ptr < *put_bulk_ptr)
 					continue;
-- 
2.43.0

