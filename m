Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FDBCA1015
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Sep 2025 12:09:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 47A4140E68;
	Thu,  4 Sep 2025 14:09:47 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id EE8A540E68
 for <dev@dpdk.org>; Thu,  4 Sep 2025 14:09:45 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4cHdYW3FgXztTY2;
 Thu,  4 Sep 2025 20:08:47 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 9D7A2180080;
 Thu,  4 Sep 2025 20:09:43 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 4 Sep 2025 20:09:43 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>
Subject: [PATCH] mempool: hide zero value items when dump cache
Date: Thu, 4 Sep 2025 20:09:42 +0800
Message-ID: <20250904120942.51729-1-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemk500009.china.huawei.com (7.202.194.94)
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

Hide zero value items when dump mempool cache.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 lib/mempool/rte_mempool.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/mempool/rte_mempool.c b/lib/mempool/rte_mempool.c
index 1021ede0c2..3042d94c14 100644
--- a/lib/mempool/rte_mempool.c
+++ b/lib/mempool/rte_mempool.c
@@ -1057,7 +1057,7 @@ rte_mempool_dump_cache(FILE *f, const struct rte_mempool *mp)
 	unsigned count = 0;
 	unsigned cache_count;
 
-	fprintf(f, "  internal cache infos:\n");
+	fprintf(f, "  internal cache infos (hide zero value items):\n");
 	fprintf(f, "    cache_size=%"PRIu32"\n", mp->cache_size);
 
 	if (mp->cache_size == 0)
@@ -1065,6 +1065,8 @@ rte_mempool_dump_cache(FILE *f, const struct rte_mempool *mp)
 
 	for (lcore_id = 0; lcore_id < RTE_MAX_LCORE; lcore_id++) {
 		cache_count = mp->local_cache[lcore_id].len;
+		if (cache_count == 0)
+			continue;
 		fprintf(f, "    cache_count[%u]=%"PRIu32"\n",
 			lcore_id, cache_count);
 		count += cache_count;
-- 
2.17.1

