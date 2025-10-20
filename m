Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0730ECCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 04:12:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1065242E56;
	Mon, 20 Oct 2025 06:11:25 +0200 (CEST)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id CD19E402D8
 for <dev@dpdk.org>; Mon, 20 Oct 2025 06:11:15 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=UK6UF0HCDLFVIrx+Y6zfUnQSGa4Hsmz7zwktm344/zo=;
 b=KSi16mQGngr6nBJtVrTgPQBlmsEO55zGNqMBeEz5as/CNtSFbbL3Mu6vi98D6+z1+pDikT0oD
 3PIugfFExWMx8dsgPNZF89NAcysqRj4iNhz/PW4Nn2CFXim/QYUfx+k8v/7LKJi91zknqzZxasR
 kXYIC43RU/xL0ipR4NDO1qo=
Received: from mail.maildlp.com (unknown [172.19.163.48])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4cqhmH5BZNz1T4FV;
 Mon, 20 Oct 2025 12:10:23 +0800 (CST)
Received: from kwepemk500009.china.huawei.com (unknown [7.202.194.94])
 by mail.maildlp.com (Postfix) with ESMTPS id CDFE818006C;
 Mon, 20 Oct 2025 12:11:14 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemk500009.china.huawei.com (7.202.194.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Oct 2025 12:11:14 +0800
From: Chengwen Feng <fengchengwen@huawei.com>
To: <thomas@monjalon.net>, <honest.jiang@foxmail.com>
CC: <dev@dpdk.org>, <liuyonglong@huawei.com>, <vattunuru@marvell.com>
Subject: [PATCH v4 11/14] app/dma-perf: fix segment fault with large size
Date: Mon, 20 Oct 2025 12:11:02 +0800
Message-ID: <20251020041105.1590-12-fengchengwen@huawei.com>
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

When the buf-size is too large, the test will show:

  Case process killed by signal 11

The root cause is that rte_pktmbuf_pool_create() will truncate the
buf-size to uint16 type.

This commit add a friendly error trace when encounter such case.

Fixes: 623dc9364dc6 ("app/dma-perf: introduce DMA performance test")
Cc: stable@dpdk.org

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
---
 app/test-dma-perf/benchmark.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/app/test-dma-perf/benchmark.c b/app/test-dma-perf/benchmark.c
index 694ad25cbe..6643ccc95f 100644
--- a/app/test-dma-perf/benchmark.c
+++ b/app/test-dma-perf/benchmark.c
@@ -525,6 +525,11 @@ setup_memory_env(struct test_configure *cfg, uint32_t nr_buf,
 		return -1;
 	}
 
+	if (buf_size > UINT16_MAX) {
+		PRINT_ERR("Error: Invalid buf size: %u\n", cur_buf_size);
+		return -1;
+	}
+
 	src_pool = rte_pktmbuf_pool_create("Benchmark_DMA_SRC",
 			nr_buf,
 			0,
-- 
2.17.1

