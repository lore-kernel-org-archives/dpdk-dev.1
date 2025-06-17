Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 878A6C71157
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 10:52:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B7E3940E30;
	Tue, 17 Jun 2025 12:52:57 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id C990D40E2F
 for <dev@dpdk.org>; Tue, 17 Jun 2025 12:52:56 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bM3W72L2Qz6L5bd;
 Tue, 17 Jun 2025 18:48:19 +0800 (CST)
Received: from frapeml500002.china.huawei.com (unknown [7.182.85.205])
 by mail.maildlp.com (Postfix) with ESMTPS id EF22E1402F5;
 Tue, 17 Jun 2025 18:52:55 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapeml500002.china.huawei.com (7.182.85.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 17 Jun 2025 12:52:55 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan
 <yanzhirun_163@163.com>
CC: <dev@dpdk.org>
Subject: [PATCH 2/2] lib/graph: rte_malloc for cache-aligned structs
Date: Tue, 17 Jun 2025 11:52:08 +0100
Message-ID: <20250617105209.50526-2-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617105209.50526-1-marat.khalili@huawei.com>
References: <20250617105209.50526-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapeml100001.china.huawei.com (7.182.85.63) To
 frapeml500002.china.huawei.com (7.182.85.205)
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

This was flagged by undefined behaviour sanitizer: struct
rte_graph_cluster_stats is declared as `__rte_cache_aligned` but was
allocated using stdlib realloc which caused misaligned allocation. More
than one test needs to be executed in series in order to reproduce the
problem using graph_autotest, e.g:

    app/dpdk-test --no-huge --no-pci -m128 graph_autotest graph_autotest

First sanitizer message  (similar ones follow):

    lib/graph/graph_stats.c:209:13: runtime error: member access within
    misaligned address 0x606000008ea0 for type 'struct
    rte_graph_cluster_stats', which requires 64 byte alignment

To fix the issue replace realloc calls with rte_malloc and rte_realloc
specifying correct alignment, use rte_free to free the result.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/graph/graph_stats.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/lib/graph/graph_stats.c b/lib/graph/graph_stats.c
index 57cd72e7cc..7ae8ee4987 100644
--- a/lib/graph/graph_stats.c
+++ b/lib/graph/graph_stats.c
@@ -203,7 +203,7 @@ stats_mem_init(struct cluster *cluster,
 	cluster_node_size += cluster->nb_graphs * sizeof(struct rte_node *);
 	cluster_node_size = RTE_ALIGN(cluster_node_size, RTE_CACHE_LINE_SIZE);
 
-	stats = realloc(NULL, sz);
+	stats = rte_malloc(NULL, sz, RTE_CACHE_LINE_SIZE);
 	if (stats) {
 		memset(stats, 0, sz);
 		stats->fn = fn;
@@ -248,7 +248,8 @@ stats_mem_populate(struct rte_graph_cluster_stats **stats_in,
 	}
 
 	/* Hey, it is a new node, allocate space for it in the reel */
-	stats = realloc(stats, stats->sz + stats->cluster_node_size);
+	stats = rte_realloc(stats, stats->sz + stats->cluster_node_size,
+		RTE_CACHE_LINE_SIZE);
 	if (stats == NULL)
 		SET_ERR_JMP(ENOMEM, err, "Realloc failed");
 	*stats_in = NULL;
@@ -301,7 +302,7 @@ stats_mem_populate(struct rte_graph_cluster_stats **stats_in,
 
 	return 0;
 free:
-	free(stats);
+	rte_free(stats);
 err:
 	return -rte_errno;
 }
@@ -309,7 +310,7 @@ stats_mem_populate(struct rte_graph_cluster_stats **stats_in,
 static void
 stats_mem_fini(struct rte_graph_cluster_stats *stats)
 {
-	free(stats);
+	rte_free(stats);
 }
 
 static void
-- 
2.43.0

