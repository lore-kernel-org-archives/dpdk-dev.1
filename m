Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6167DD148B7
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 07:32:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BAF364028C;
	Thu,  8 Jan 2026 08:32:09 +0100 (CET)
Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
 by mails.dpdk.org (Postfix) with ESMTP id D22A140261;
 Thu,  8 Jan 2026 08:32:06 +0100 (CET)
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
 by mailgw1.hygon.cn (Postfix) with ESMTP id 4dmxS40JsLzrbqS;
 Thu,  8 Jan 2026 15:32:04 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
 by mailgw1.hygon.cn (Postfix) with ESMTP id 4dmxS33CWQzrbqS;
 Thu,  8 Jan 2026 15:32:03 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
 by maildlp1.hygon.cn (Postfix) with ESMTPS id 4C59B4B7C;
 Thu,  8 Jan 2026 15:32:03 +0800 (CST)
Received: from kk5.hygon.cn (172.19.22.47) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 8 Jan
 2026 15:32:03 +0800
From: Liangxing Wang <wangliangxing@hygon.cn>
To: <dev@dpdk.org>
CC: Liangxing Wang <wangliangxing@hygon.cn>, <stable@dpdk.org>
Subject: [PATCH v2 3/3] app/test: extend NUMA nodes limit beyond 2
Date: Thu, 8 Jan 2026 07:31:35 +0000
Message-ID: <20260108073135.1279814-1-wangliangxing@hygon.cn>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.19.22.47]
X-ClientProxiedBy: cncheex06.Hygon.cn (172.23.18.116) To cncheex04.Hygon.cn
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

Use RTE_MAX_NUMA_NODES instead of hardcoded 2 to extend NUMA nodes
limit for pmd_perf_autotest.

Cc: stable@dpdk.org

Signed-off-by: Liangxing Wang <wangliangxing@hygon.cn>
---
 app/test/test_pmd_perf.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/app/test/test_pmd_perf.c b/app/test/test_pmd_perf.c
index 995b0a6f20..a547a33a1c 100644
--- a/app/test/test_pmd_perf.c
+++ b/app/test/test_pmd_perf.c
@@ -15,7 +15,7 @@
 #include "test.h"
 
 #define NB_ETHPORTS_USED                (1)
-#define NB_SOCKETS                      (2)
+#define NB_SOCKETS                      RTE_MAX_NUMA_NODES
 #define MEMPOOL_CACHE_SIZE 250
 #define MAX_PKT_BURST                   (32)
 #define RX_DESC_DEFAULT        (1024)
-- 
2.43.0


