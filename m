Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC102EC0461
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 09:18:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6184402B0;
	Tue,  3 Mar 2026 10:18:31 +0100 (CET)
Received: from mailgw2.hygon.cn (unknown [101.204.27.37])
 by mails.dpdk.org (Postfix) with ESMTP id 9BFDF40268;
 Tue,  3 Mar 2026 10:18:30 +0100 (CET)
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
 by mailgw2.hygon.cn (Postfix) with ESMTP id 4fQ9Fv29lsz1YHN2y;
 Tue,  3 Mar 2026 17:18:27 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
 by mailgw2.hygon.cn (Postfix) with ESMTP id 4fQ9Fr5GDYz1YHN2y;
 Tue,  3 Mar 2026 17:18:24 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
 by maildlp1.hygon.cn (Postfix) with ESMTPS id D06204B7C;
 Tue,  3 Mar 2026 17:18:19 +0800 (CST)
Received: from kk5.hygon.cn (172.19.22.47) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Tue, 3 Mar
 2026 17:18:23 +0800
From: Liangxing Wang <wangliangxing@hygon.cn>
To: <honest.jiang@foxmail.com>, <fengchengwen@huawei.com>
CC: <dev@dpdk.org>, <vipin.varghese@amd.com>, Liangxing Wang
 <wangliangxing@hygon.cn>, <stable@dpdk.org>
Subject: [PATCH] app/test-dma-perf: fix reversed src and dst for memcpy
Date: Tue, 3 Mar 2026 09:18:04 +0000
Message-ID: <20260303091804.41761-1-wangliangxing@hygon.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.22.47]
X-ClientProxiedBy: cncheex05.Hygon.cn (172.23.18.115) To cncheex04.Hygon.cn
 (172.23.18.114)
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

Fixes: 2f2f7af66791 ("app/dma-perf: fix crash with IOVA as physical address")
Cc: stable@dpdk.org

Signed-off-by: Liangxing Wang <wangliangxing@hygon.cn>
---
 app/test-dma-perf/benchmark.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/app/test-dma-perf/benchmark.c b/app/test-dma-perf/benchmark.c
index b6125d86f9..5f6c022ad7 100644
--- a/app/test-dma-perf/benchmark.c
+++ b/app/test-dma-perf/benchmark.c
@@ -520,8 +520,8 @@ do_cpu_mem_copy(void *p)
 
 	while (1) {
 		for (i = 0; i < nr_buf; i++) {
-			const void *src = rte_pktmbuf_mtod(dsts[i], void *);
-			void *dst = rte_pktmbuf_mtod(srcs[i], void *);
+			const void *src = rte_pktmbuf_mtod(srcs[i], void *);
+			void *dst = rte_pktmbuf_mtod(dsts[i], void *);
 
 			/* copy buffer form src to dst */
 			rte_memcpy(dst, src, (size_t)buf_size);
-- 
2.43.0


