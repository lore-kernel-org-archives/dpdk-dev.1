Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2DFAC71136
	for <dpdk-dev@archiver.kernel.org>; Tue, 17 Jun 2025 10:52:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACC4D40A73;
	Tue, 17 Jun 2025 12:52:51 +0200 (CEST)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com
 [185.176.79.56]) by mails.dpdk.org (Postfix) with ESMTP id 12B4240609
 for <dev@dpdk.org>; Tue, 17 Jun 2025 12:52:49 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.18.186.31])
 by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4bM3Yq1cq2z6L5KJ;
 Tue, 17 Jun 2025 18:50:39 +0800 (CST)
Received: from frapeml500002.china.huawei.com (unknown [7.182.85.205])
 by mail.maildlp.com (Postfix) with ESMTPS id 196C4140136;
 Tue, 17 Jun 2025 18:52:49 +0800 (CST)
Received: from localhost.localdomain (10.220.239.45) by
 frapeml500002.china.huawei.com (7.182.85.205) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 17 Jun 2025 12:52:48 +0200
From: Marat Khalili <marat.khalili@huawei.com>
To: Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K <kirankumark@marvell.com>, 
 Nithin Dabilpuram <ndabilpuram@marvell.com>, Zhirun Yan
 <yanzhirun_163@163.com>
CC: <dev@dpdk.org>
Subject: [PATCH 1/2] lib/graph: avoid memset(NULL, 0, 0)
Date: Tue, 17 Jun 2025 11:52:07 +0100
Message-ID: <20250617105209.50526-1-marat.khalili@huawei.com>
X-Mailer: git-send-email 2.43.0
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

This was flagged by undefined behaviour sanitizer: memset should not be
called with NULL first argument. (memset requires first argument to be
pointer to a memory object, so passing NULL may result in an undefined
behaviour including among other things optimizer potentially removing
code paths depending on stat->xstat_count being NULL.)

Sanitizer message:

    lib/graph/graph_stats.c:473:2: runtime error: null pointer passed as
    argument 1, which is declared to never be null

To fix the issue add a check that stat->xstat_count is not NULL before
the call.

Signed-off-by: Marat Khalili <marat.khalili@huawei.com>
---
 lib/graph/graph_stats.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/graph/graph_stats.c b/lib/graph/graph_stats.c
index eac73cbf71..57cd72e7cc 100644
--- a/lib/graph/graph_stats.c
+++ b/lib/graph/graph_stats.c
@@ -470,7 +470,9 @@ cluster_node_arregate_stats(struct cluster_node *cluster, bool dispatch)
 	uint64_t *xstat;
 	uint8_t i;
 
-	memset(stat->xstat_count, 0, sizeof(uint64_t) * stat->xstat_cntrs);
+	if (stat->xstat_count != NULL)
+		memset(stat->xstat_count, 0,
+			sizeof(uint64_t) * stat->xstat_cntrs);
 	for (count = 0; count < cluster->nb_nodes; count++) {
 		node = cluster->nodes[count];
 
-- 
2.43.0

