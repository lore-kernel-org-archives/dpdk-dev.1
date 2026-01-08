Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3DDBD148B7
	for <dpdk-dev@archiver.kernel.org>; Thu,  8 Jan 2026 07:31:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CCDF940658;
	Thu,  8 Jan 2026 08:31:07 +0100 (CET)
Received: from mailgw2.hygon.cn (unknown [101.204.27.37])
 by mails.dpdk.org (Postfix) with ESMTP id 0654E40261;
 Thu,  8 Jan 2026 08:31:04 +0100 (CET)
Received: from maildlp2.hygon.cn (unknown [127.0.0.1])
 by mailgw2.hygon.cn (Postfix) with ESMTP id 4dmxQt389jz1YQpmJ;
 Thu,  8 Jan 2026 15:31:02 +0800 (CST)
Received: from maildlp2.hygon.cn (unknown [172.23.18.61])
 by mailgw2.hygon.cn (Postfix) with ESMTP id 4dmxQr6bFbz1YQpmJ;
 Thu,  8 Jan 2026 15:31:00 +0800 (CST)
Received: from cncheex04.Hygon.cn (unknown [172.23.18.114])
 by maildlp2.hygon.cn (Postfix) with ESMTPS id BFCE830004DE;
 Thu,  8 Jan 2026 15:31:00 +0800 (CST)
Received: from kk5.hygon.cn (172.19.22.47) by cncheex04.Hygon.cn
 (172.23.18.114) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.36; Thu, 8 Jan
 2026 15:31:00 +0800
From: Liangxing Wang <wangliangxing@hygon.cn>
To: <radu.nicolau@intel.com>, <gakhil@marvell.com>
CC: <dev@dpdk.org>, Liangxing Wang <wangliangxing@hygon.cn>, <stable@dpdk.org>
Subject: [PATCH v2 2/3] examples/ipsec-secgw: extend NUMA nodes limit beyond 4
Date: Thu, 8 Jan 2026 07:30:30 +0000
Message-ID: <20260108073030.1279795-1-wangliangxing@hygon.cn>
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

Use RTE_MAX_NUMA_NODES instead of hardcoded 4 to extend NUMA nodes
limit.

Cc: stable@dpdk.org

Signed-off-by: Liangxing Wang <wangliangxing@hygon.cn>
---
 examples/ipsec-secgw/ipsec-secgw.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

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
-- 
2.43.0


