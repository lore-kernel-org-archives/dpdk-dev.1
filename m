Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB83DC3ABDD
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 May 2025 07:15:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5643C402C5;
	Fri, 16 May 2025 09:15:24 +0200 (CEST)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by mails.dpdk.org (Postfix) with ESMTP id CB5F0400EF
 for <dev@dpdk.org>; Fri, 16 May 2025 09:15:22 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZzJGR6BKBz1d18c;
 Fri, 16 May 2025 15:13:51 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 61BB01400D9;
 Fri, 16 May 2025 15:15:20 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 16 May 2025 15:15:19 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <lihuisong@huawei.com>, <fengchengwen@huawei.com>,
 <stephen@networkplumber.org>
Subject: [PATCH v5 1/2] net/hns3: fix cannot look the CRC data
Date: Fri, 16 May 2025 15:15:18 +0800
Message-ID: <20250516071519.3190805-2-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250516071519.3190805-1-huangdengdui@huawei.com>
References: <20241127100807.683461-1-haijie1@huawei.com>
 <20250516071519.3190805-1-huangdengdui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemo500011.china.huawei.com (7.202.195.194)
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

When the packet is received into a multisegment mbuf and
the last segment contains only CRC data, the driver should
not release this segment. Otherwise, the application cannot
look the CRC data. This patch fixes it.

Fixes: 8973d7c4ca12 ("net/hns3: support keeping CRC")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 drivers/net/hns3/hns3_rxtx.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/drivers/net/hns3/hns3_rxtx.c b/drivers/net/hns3/hns3_rxtx.c
index bb7ffee12c..49b6f16ccd 100644
--- a/drivers/net/hns3/hns3_rxtx.c
+++ b/drivers/net/hns3/hns3_rxtx.c
@@ -2386,18 +2386,16 @@ hns3_rxd_to_vlan_tci(struct hns3_rx_queue *rxq, struct rte_mbuf *mb,
 }
 
 static inline void
-recalculate_data_len(struct rte_mbuf *first_seg, struct rte_mbuf *last_seg,
-		    struct rte_mbuf *rxm, struct hns3_rx_queue *rxq,
-		    uint16_t data_len)
+recalculate_data_len(struct rte_mbuf *last_seg, struct rte_mbuf *rxm,
+		     struct hns3_rx_queue *rxq)
 {
+	uint16_t data_len = rxm->data_len;
 	uint8_t crc_len = rxq->crc_len;
 
 	if (data_len <= crc_len) {
-		rte_pktmbuf_free_seg(rxm);
-		first_seg->nb_segs--;
+		rxm->data_len = 0;
 		last_seg->data_len = (uint16_t)(last_seg->data_len -
 			(crc_len - data_len));
-		last_seg->next = NULL;
 	} else
 		rxm->data_len = (uint16_t)(data_len - crc_len);
 }
@@ -2728,8 +2726,7 @@ hns3_recv_scattered_pkts(void *rx_queue,
 		rxm->next = NULL;
 		if (unlikely(rxq->crc_len > 0)) {
 			first_seg->pkt_len -= rxq->crc_len;
-			recalculate_data_len(first_seg, last_seg, rxm, rxq,
-				rxm->data_len);
+			recalculate_data_len(last_seg, rxm, rxq);
 		}
 
 		first_seg->port = rxq->port_id;
-- 
2.33.0

