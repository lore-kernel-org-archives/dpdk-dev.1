Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE28CCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 04:11:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2076242D87;
	Mon, 20 Oct 2025 06:11:17 +0200 (CEST)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id 19AC64013F
 for <dev@dpdk.org>; Mon, 20 Oct 2025 06:11:13 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=ijPvY75+0tN8cT5cmEBNg8KDHQNn7wGWeDQcWgV0wew=;
 b=hIULKi15lmI+BUI68pyQ7EPuP8lhicOYgi1QmZJXyZ98VO6jrgyPGM3cK/mWhXD9TRNxX2Wed
 YILotwBQmTiMlWsYvZElcelc/Qzhgi+XHqnIXwK9bqxtxihaIqqufcZjNXGOZ2fZ5ve17tcGMZj
 iMPJ4GrdsL/rmX44OG0VrlA=
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4cqhmm4rMwzRhRT;
 Mon, 20 Oct 2025 12:10:48 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id 23776180B4A;
 Mon, 20 Oct 2025 12:11:12 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Oct 2025 12:11:11 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <honest.jiang@foxmail.com>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>, <vattunuru@marvell.com>
Subject: [PATCH v4 01/14] app/dma-perf: fix use-after-free
Date: Mon, 20 Oct 2025 12:10:52 +0800
Message-ID: <20251020041105.1590-2-fengchengwen@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20251020041105.1590-1-fengchengwen@huawei.com>
References: <20250811105430.55791-1-fengchengwen@huawei.com>
 <20251020041105.1590-1-fengchengwen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

The test_case->eal_args was pointer the entry of cfgfile, it will be
used later, but the cfgfile was closed in load_configs(). This commit
fix it by using strdup.

Fixes: 623dc9364dc6 ("app/dma-perf: introduce DMA performance test")
Cc: stable@dpdk.org

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Acked-by: Vamsi Attunuru <vattunuru@marvell.com>
---
 app/test-dma-perf/main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/app/test-dma-perf/main.c b/app/test-dma-perf/main.c
index 4201cc02a0..64057788c3 100644
--- a/app/test-dma-perf/main.c
+++ b/app/test-dma-perf/main.c
@@ -489,6 +489,8 @@ load_configs(const char *path)
 					section_name, "test_seconds"));
 
 		test_case->eal_args = rte_cfgfile_get_entry(cfgfile, section_name, "eal_args");
+		if (test_case->eal_args != NULL)
+			test_case->eal_args = strdup(test_case->eal_args);
 		test_case->is_valid = true;
 	}
 
-- 
2.17.1

