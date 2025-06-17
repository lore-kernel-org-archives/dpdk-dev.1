Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF2EC71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 15:14:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E1D041109;
	Tue, 17 Jun 2025 17:14:48 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 880FB410FA
 for <dev@dpdk.org>; Tue, 17 Jun 2025 17:14:47 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bM9N410gYz6L5Vc;
 Tue, 17 Jun 2025 23:12:36 +0800 (CST)
Received: from frapeml500002.china.huawei.com (unknown [7.182.85.205])
 by mail.maildlp.com (Postfix) with ESMTPS id 81E101402F7;
 Tue, 17 Jun 2025 23:14:46 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapeml500002.china.huawei.com (7.182.85.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 17 Jun 2025 17:14:46 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan
 <yanzhirun_163@163.com>, Pavan Nikhilesh <pbhagavatula@marvell.com>
CC: <dev@dpdk.org>
Subject: [PATCH v2 2/2] lib/graph: default-align rte_graph_cluster_stats
Date: Tue, 17 Jun 2025 16:13:38 +0100
Message-ID: <20250617151339.28794-2-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250617151339.28794-1-marat.khalili@huawei.com>
References: <20250617151339.28794-1-marat.khalili@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.220.239.45]
X-ClientProxiedBy: frapeml100002.china.huawei.com (7.182.85.26) To
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

To fix the issue remove `__rte_cache_aligned` attribute from struct
rte_graph_cluster_stats and struct rte_graph_cluster_node_stats that it
contains. There is no need to keep them cache-aligned since they are
only used in the slow path.

Fixes: af1ae8b6a32 ("graph: implement stats")

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---

v2: Following the suggestions from Jerin Jacob changed the fix to simply
remove non-default alignment. Although there are many ways to make
alignment work, I personally agree that it is probably better to keep
the code simple as long as performance is not an issue.

Although reducing _actual_ alignment of allocated objects would probably
be a binary compatibility issue, here we are only changing _declared_
alignment to match the actual one, so it will more likely fix things
than break them.

devtools/test-meson-builds.sh completes successfully.

 lib/graph/graph_stats.c | 2 +-
 lib/graph/rte_graph.h   | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/lib/graph/graph_stats.c b/lib/graph/graph_stats.c
index 57cd72e7cc..4324717f33 100644
--- a/lib/graph/graph_stats.c
+++ b/lib/graph/graph_stats.c
@@ -29,7 +29,7 @@ struct cluster_node {
 	struct rte_node *nodes[];
 };
 
-struct __rte_cache_aligned rte_graph_cluster_stats {
+struct rte_graph_cluster_stats {
 	/* Header */
 	rte_graph_cluster_stats_cb_t fn;
 	uint32_t cluster_node_size; /* Size of struct cluster_node */
diff --git a/lib/graph/rte_graph.h b/lib/graph/rte_graph.h
index 097d0dc9d5..826204cad9 100644
--- a/lib/graph/rte_graph.h
+++ b/lib/graph/rte_graph.h
@@ -202,7 +202,7 @@ struct rte_graph_cluster_stats_param {
  *
  * @see struct rte_graph_cluster_stats_param::fn
  */
-struct __rte_cache_aligned rte_graph_cluster_node_stats {
+struct rte_graph_cluster_node_stats {
 	uint64_t ts;	    /**< Current timestamp. */
 	uint64_t calls;	    /**< Current number of calls made. */
 	uint64_t objs;      /**< Current number of objs processed. */
-- 
2.43.0

