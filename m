Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD34FEFD206
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 08:06:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D00A2402EB;
	Wed, 25 Feb 2026 09:06:19 +0100 (CET)
Received: from mailgw1.hygon.cn (unknown [101.204.27.37])
 by mails.dpdk.org (Postfix) with ESMTP id 6364D400D6;
 Wed, 25 Feb 2026 09:06:18 +0100 (CET)
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
 by mailgw1.hygon.cn (Postfix) with ESMTP id 4fLRxN69whzwpqs;
 Wed, 25 Feb 2026 16:06:16 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
 by mailgw1.hygon.cn (Postfix) with ESMTP id 4fLRxM039fzwpqs;
 Wed, 25 Feb 2026 16:06:15 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
 by maildlp2.hygon.cn (Postfix) with ESMTPS id AA3BB30A6425;
 Wed, 25 Feb 2026 16:05:17 +0800 (CST)
Received: from kk5.hygon.cn (172.19.22.47) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Wed, 25 Feb
 2026 16:06:14 +0800
From: Liangxing Wang <wangliangxing@hygon.cn>
To: <thomas@monjalon.net>, <stephen@networkplumber.org>,
 <fengchengwen@huawei.com>
CC: <dev@dpdk.org>, Liangxing Wang <wangliangxing@hygon.cn>, <stable@dpdk.org>
Subject: [PATCH v3 1/2] examples: extend NUMA nodes limit
Date: Wed, 25 Feb 2026 08:05:10 +0000
Message-ID: <20260225080510.727493-1-wangliangxing@hygon.cn>
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

Use RTE_MAX_NUMA_NODES instead of hardcoded values to extend NUMA nodes
limit for l3fwd, ipsec-secgw, and vhost_crypto examples.

Remove unused NB_SOCKETS macro in ip_reassembly.

Cc: stable@dpdk.org

Signed-off-by: Liangxing Wang <wangliangxing@hygon.cn>
---
 examples/ip_reassembly/main.c      | 2 --
 examples/ipsec-secgw/ipsec-secgw.h | 2 +-
 examples/l3fwd-graph/main.c        | 2 +-
 examples/l3fwd-power/main.c        | 2 +-
 examples/l3fwd/l3fwd.h             | 2 +-
 examples/vhost_crypto/main.c       | 2 +-
 6 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/examples/ip_reassembly/main.c b/examples/ip_reassembly/main.c
index 520fbea1c2..d26a0fb468 100644
--- a/examples/ip_reassembly/main.c
+++ b/examples/ip_reassembly/main.c
@@ -78,8 +78,6 @@ static uint32_t max_flow_ttl = DEF_FLOW_TTL;
 
 #define BURST_TX_DRAIN_US 100 /* TX drain every ~100us */
 
-#define NB_SOCKETS 8
-
 /* Configure how many packets ahead to prefetch, when reading packets */
 #define PREFETCH_OFFSET	3
 
diff --git a/examples/ipsec-secgw/ipsec-secgw.h b/examples/ipsec-secgw/ipsec-secgw.h
index b4ef4b6d04..88d74654b2 100644
--- a/examples/ipsec-secgw/ipsec-secgw.h
+++ b/examples/ipsec-secgw/ipsec-secgw.h
@@ -9,7 +9,7 @@
 
 #define MAX_RX_QUEUE_PER_LCORE 16
 
-#define NB_SOCKETS 4
+#define NB_SOCKETS RTE_MAX_NUMA_NODES
 
 #define MAX_PKT_BURST 32
 #define MAX_PKT_BURST_VEC 256
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
index 02ec17d799..ed98a60365 100644
--- a/examples/l3fwd-power/main.c
+++ b/examples/l3fwd-power/main.c
@@ -114,7 +114,7 @@ RTE_LOG_REGISTER(l3fwd_power_logtype, l3fwd.power, INFO);
 
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
diff --git a/examples/vhost_crypto/main.c b/examples/vhost_crypto/main.c
index 8bdfc40c4b..ab39baaf47 100644
--- a/examples/vhost_crypto/main.c
+++ b/examples/vhost_crypto/main.c
@@ -31,7 +31,7 @@
 #define SESSION_MAP_ENTRIES		(1024)
 #define REFRESH_TIME_SEC		(3)
 
-#define MAX_NB_SOCKETS			(4)
+#define MAX_NB_SOCKETS			RTE_MAX_NUMA_NODES
 #define MAX_NB_WORKER_CORES		(16)
 
 struct lcore_option {
-- 
2.43.0


