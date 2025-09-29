Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B122CAC5B5
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 11:36:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A636640668;
	Mon, 29 Sep 2025 13:35:59 +0200 (CEST)
Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com
 [113.46.200.219])
 by mails.dpdk.org (Postfix) with ESMTP id C7B324028C
 for <dev@dpdk.org>; Mon, 29 Sep 2025 13:35:57 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=BZD/uJ04Rxbiwi7ex1Em33ymVidBU9Id08dvZvWgcjU=;
 b=HAmqk4h2a1jbUzC5fnaZwhIApcEQdQm9J0aq5LWy8x0kA+MMtx2NKYGtFnkub/jtojJTGE+Jl
 hk3I94tcr5LK9p2cqrd1Kr3GZVmlvKjAKh8vUsdkFMyur0pgfuqBJw/Doqtgk/JNo+SRDD/RPge
 IP4Mlx+u5wjrwBwMgwO5hN4=
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4cZzds1gbtz1prQS;
 Mon, 29 Sep 2025 19:35:45 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
 by mail.maildlp.com (Postfix) with ESMTPS id 20EB81402C4;
 Mon, 29 Sep 2025 19:35:56 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Sep 2025 19:35:55 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <david.marchand@redhat.com>,
 <liuyonglong@huawei.com>, <kangfenglong@huawei.com>,
 <fengchengwen@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH 1/2] net/hns3: fix VLAN tag loss for short tunnel frame
Date: Mon, 29 Sep 2025 19:35:53 +0800
Message-ID: <20250929113554.2443832-2-yangxingui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250929113554.2443832-1-yangxingui@huawei.com>
References: <20250929113554.2443832-1-yangxingui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.31.46]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj100018.china.huawei.com (7.202.194.12)
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

When the hardware handles short tunnel frames below 65 bytes, the VLAN tag
will be lost if VLAN insert or QinQ insert is enabled. Therefore, the
packet size of the tunnel frame is padded to 65 bytes to fix this issue.

Fixes: de620754a109 ("net/hns3: fix sending packets less than 60 bytes")
Cc: stable@dpdk.org

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
 drivers/net/hns3/hns3_ethdev.h |  1 +
 drivers/net/hns3/hns3_rxtx.c   | 48 +++++++++++++++++++++++-----------
 2 files changed, 34 insertions(+), 15 deletions(-)

diff --git a/drivers/net/hns3/hns3_ethdev.h b/drivers/net/hns3/hns3_ethdev.h
index f6bb1b5d43..209b042816 100644
--- a/drivers/net/hns3/hns3_ethdev.h
+++ b/drivers/net/hns3/hns3_ethdev.h
@@ -75,6 +75,7 @@
 #define HNS3_DEFAULT_MTU		1500UL
 #define HNS3_DEFAULT_FRAME_LEN		(HNS3_DEFAULT_MTU + HNS3_ETH_OVERHEAD)
 #define HNS3_HIP08_MIN_TX_PKT_LEN	33
+#define HNS3_MIN_TUN_PKT_LEN		65
 
 #define HNS3_BITS_PER_BYTE	8
 
diff --git a/drivers/net/hns3/hns3_rxtx.c b/drivers/net/hns3/hns3_rxtx.c
index aa7ee6f3e8..df703134be 100644
--- a/drivers/net/hns3/hns3_rxtx.c
+++ b/drivers/net/hns3/hns3_rxtx.c
@@ -4219,6 +4219,37 @@ hns3_tx_fill_hw_ring(struct hns3_tx_queue *txq,
 	}
 }
 
+static bool
+hns3_tx_pktmbuf_append(struct hns3_tx_queue *txq,
+		       struct rte_mbuf *tx_pkt)
+{
+	uint16_t add_len = 0;
+	uint32_t ptype;
+	char *appended;
+
+	if (unlikely(tx_pkt->ol_flags & (RTE_MBUF_F_TX_VLAN | RTE_MBUF_F_TX_QINQ) &&
+		rte_pktmbuf_pkt_len(tx_pkt) < HNS3_MIN_TUN_PKT_LEN)) {
+		ptype = rte_net_get_ptype(tx_pkt, NULL, RTE_PTYPE_L2_MASK |
+				RTE_PTYPE_L3_MASK | RTE_PTYPE_L4_MASK |
+				RTE_PTYPE_TUNNEL_MASK);
+		if (ptype & RTE_PTYPE_TUNNEL_MASK)
+			add_len = HNS3_MIN_TUN_PKT_LEN - rte_pktmbuf_pkt_len(tx_pkt);
+	} else if (unlikely(rte_pktmbuf_pkt_len(tx_pkt) < txq->min_tx_pkt_len)) {
+		add_len = txq->min_tx_pkt_len - rte_pktmbuf_pkt_len(tx_pkt);
+	}
+
+	if (unlikely(add_len > 0)) {
+		appended = rte_pktmbuf_append(tx_pkt, add_len);
+		if (appended == NULL) {
+			txq->dfx_stats.pkt_padding_fail_cnt++;
+			return false;
+		}
+		memset(appended, 0, add_len);
+	}
+
+	return true;
+}
+
 uint16_t
 hns3_xmit_pkts_simple(void *tx_queue,
 		      struct rte_mbuf **tx_pkts,
@@ -4296,21 +4327,8 @@ hns3_xmit_pkts(void *tx_queue, struct rte_mbuf **tx_pkts, uint16_t nb_pkts)
 		 * by hardware in Tx direction, driver need to pad it to avoid
 		 * error.
 		 */
-		if (unlikely(rte_pktmbuf_pkt_len(tx_pkt) <
-						txq->min_tx_pkt_len)) {
-			uint16_t add_len;
-			char *appended;
-
-			add_len = txq->min_tx_pkt_len -
-					 rte_pktmbuf_pkt_len(tx_pkt);
-			appended = rte_pktmbuf_append(tx_pkt, add_len);
-			if (appended == NULL) {
-				txq->dfx_stats.pkt_padding_fail_cnt++;
-				break;
-			}
-
-			memset(appended, 0, add_len);
-		}
+		if (!hns3_tx_pktmbuf_append(txq, tx_pkt))
+			break;
 
 		m_seg = tx_pkt;
 
-- 
2.33.0

