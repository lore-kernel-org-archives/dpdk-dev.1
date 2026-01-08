Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED8DD148A3
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 07:29:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D40F4028C;
	Thu,  8 Jan 2026 08:29:57 +0100 (CET)
Received: from mailgw2.hygon.cn (unknown [101.204.27.37])
 by mails.dpdk.org (Postfix) with ESMTP id 56C9540261;
 Thu,  8 Jan 2026 08:29:55 +0100 (CET)
Received: from maildlp1.hygon.cn (unknown [127.0.0.1])
 by mailgw2.hygon.cn (Postfix) with ESMTP id 4dmxPY22xJz1YQpmG;
 Thu,  8 Jan 2026 15:29:53 +0800 (CST)
Received: from maildlp1.hygon.cn (unknown [172.23.18.60])
 by mailgw2.hygon.cn (Postfix) with ESMTP id 4dmxPX1B7cz1YQpmG;
 Thu,  8 Jan 2026 15:29:52 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
 by maildlp1.hygon.cn (Postfix) with ESMTPS id 156964B7C;
 Thu,  8 Jan 2026 15:29:51 +0800 (CST)
Received: from kk5.hygon.cn (172.19.22.47) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 8 Jan
 2026 15:29:51 +0800
From: Liangxing Wang <wangliangxing@hygon.cn>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>
CC: <dev@dpdk.org>, Liangxing Wang <wangliangxing@hygon.cn>, <stable@dpdk.org>
Subject: [PATCH v2 1/3] examples/l3fwd: extend NUMA nodes limit beyond 8
Date: Thu, 8 Jan 2026 07:29:19 +0000
Message-ID: <20260108072919.1279731-1-wangliangxing@hygon.cn>
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

For platforms with more than 8 NUMA nodes, examples l3fwd, l3fwd-graph,
and l3fwd-power fail when using cores on NUMA node 8 or above.

Use RTE_MAX_NUMA_NODES instead of 8 to extend NUMA nodes limit.

Cc: stable@dpdk.org

Signed-off-by: Liangxing Wang <wangliangxing@hygon.cn>
---
 examples/l3fwd-graph/main.c | 2 +-
 examples/l3fwd-power/main.c | 2 +-
 examples/l3fwd/l3fwd.h      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/examples/l3fwd-graph/main.c b/examples/l3fwd-graph/main.c
index 92cdaa1ebe..d77b5f4ef6 100644
--- a/examples/l3fwd-graph/main.c
+++ b/examples/l3fwd-graph/main.c
@@ -56,7 +56,7 @@
 
 #define MAX_LCORE_PARAMS 1024
 
-#define NB_SOCKETS 8
+#define NB_SOCKETS RTE_MAX_NUMA_NODES
 
 /* Graph module */
 #define WORKER_MODEL_RTC "rtc"
diff --git a/examples/l3fwd-power/main.c b/examples/l3fwd-power/main.c
index ec12d1cc0b..534e438d0b 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -115,7 +115,7 @@ RTE_LOG_REGISTER(l3fwd_power_logtype, l3fwd.power, INFO);
 
 #define BURST_TX_DRAIN_US 100 /* TX drain every ~100us */
 
-#define NB_SOCKETS 8
+#define NB_SOCKETS RTE_MAX_NUMA_NODES
 
 /* Configure how many packets ahead to prefetch, when reading packets */
 #define PREFETCH_OFFSET	3
diff --git a/examples/l3fwd/l3fwd.h b/examples/l3fwd/l3fwd.h
index 471e3b488f..ca9d0d2dd0 100644
--- a/examples/l3fwd/l3fwd.h
+++ b/examples/l3fwd/l3fwd.h
@@ -33,7 +33,7 @@
 #define VECTOR_SIZE_DEFAULT   MAX_PKT_BURST
 #define VECTOR_TMO_NS_DEFAULT 1E6 /* 1ms */
 
-#define NB_SOCKETS        8
+#define NB_SOCKETS        RTE_MAX_NUMA_NODES
 
 /* Configure how many packets ahead to prefetch, when reading packets */
 #define PREFETCH_OFFSET	  3
-- 
2.43.0


