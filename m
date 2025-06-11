Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 025C8C677C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 08:19:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A6B84066A;
	Wed, 11 Jun 2025 10:19:10 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id 7DAE0402F0
 for <dev@dpdk.org>; Wed, 11 Jun 2025 10:19:04 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4bHJPC05fqz2Cf4C;
 Wed, 11 Jun 2025 16:15:11 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 33AD4140123;
 Wed, 11 Jun 2025 16:19:02 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Jun 2025 16:19:01 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH 1/6] net/hns3: fix VF fail to config queue TC
Date: Wed, 11 Jun 2025 16:18:55 +0800
Message-ID: <20250611081900.3658421-2-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250611081900.3658421-1-huangdengdui@huawei.com>
References: <20250611081900.3658421-1-huangdengdui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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

From: Chengwen Feng <fengchengwen@huawei.com>

The VF cannot configure the mapping of queue to TC by directly writing
the register. Instead, the mapping must be modified by using firmware
command.

Fixes: bba636698316 ("net/hns3: support Rx/Tx and related operations")
Cc: stable@dpdk.org

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 drivers/net/hns3/hns3_cmd.h  |  8 ++++++++
 drivers/net/hns3/hns3_rxtx.c | 26 +++++++++++++++++++++-----
 2 files changed, 29 insertions(+), 5 deletions(-)

diff --git a/drivers/net/hns3/hns3_cmd.h b/drivers/net/hns3/hns3_cmd.h
index 4d707c13b2..e21a2b652f 100644
--- a/drivers/net/hns3/hns3_cmd.h
+++ b/drivers/net/hns3/hns3_cmd.h
@@ -178,6 +178,7 @@ enum hns3_opcode_type {
 
 	/* TQP commands */
 	HNS3_OPC_QUERY_TX_STATUS        = 0x0B03,
+	HNS3_OPC_TQP_TX_QUEUE_TC        = 0x0B04,
 	HNS3_OPC_QUERY_RX_STATUS        = 0x0B13,
 	HNS3_OPC_CFG_COM_TQP_QUEUE      = 0x0B20,
 	HNS3_OPC_RESET_TQP_QUEUE        = 0x0B22,
@@ -970,6 +971,13 @@ struct hns3_reset_tqp_queue_cmd {
 	uint8_t rsv[19];
 };
 
+struct hns3vf_tx_ring_tc_cmd {
+	uint16_t tqp_id;
+	uint16_t rsv1;
+	uint8_t  tc_id;
+	uint8_t  rsv2[19];
+};
+
 #define HNS3_CFG_RESET_MAC_B		3
 #define HNS3_CFG_RESET_FUNC_B		7
 #define HNS3_CFG_RESET_RCB_B		1
diff --git a/drivers/net/hns3/hns3_rxtx.c b/drivers/net/hns3/hns3_rxtx.c
index f9fde3948a..785e06db9c 100644
--- a/drivers/net/hns3/hns3_rxtx.c
+++ b/drivers/net/hns3/hns3_rxtx.c
@@ -1180,12 +1180,14 @@ hns3_init_txq(struct hns3_tx_queue *txq)
 	hns3_init_tx_queue_hw(txq);
 }
 
-static void
+static int
 hns3_init_tx_ring_tc(struct hns3_adapter *hns)
 {
+	struct hns3_cmd_desc desc;
+	struct hns3vf_tx_ring_tc_cmd *req = (struct hns3vf_tx_ring_tc_cmd *)desc.data;
 	struct hns3_hw *hw = &hns->hw;
 	struct hns3_tx_queue *txq;
-	int i, num;
+	int i, num, ret;
 
 	for (i = 0; i < HNS3_MAX_TC_NUM; i++) {
 		struct hns3_tc_queue_info *tc_queue = &hw->tc_queue[i];
@@ -1200,9 +1202,24 @@ hns3_init_tx_ring_tc(struct hns3_adapter *hns)
 			if (txq == NULL)
 				continue;
 
-			hns3_write_dev(txq, HNS3_RING_TX_TC_REG, tc_queue->tc);
+			if (!hns->is_vf) {
+				hns3_write_dev(txq, HNS3_RING_TX_TC_REG, tc_queue->tc);
+				continue;
+			}
+
+			hns3_cmd_setup_basic_desc(&desc, HNS3_OPC_TQP_TX_QUEUE_TC, false);
+			req->tqp_id = rte_cpu_to_le_16(num);
+			req->tc_id  = tc_queue->tc;
+			ret = hns3_cmd_send(hw, &desc, 1);
+			if (ret != 0) {
+				hns3_err(hw, "config Tx queue (%u)'s TC failed! ret = %d.",
+					 num, ret);
+				return ret;
+			}
 		}
 	}
+
+	return 0;
 }
 
 static int
@@ -1278,9 +1295,8 @@ hns3_init_tx_queues(struct hns3_adapter *hns)
 		txq = (struct hns3_tx_queue *)hw->fkq_data.tx_queues[i];
 		hns3_init_txq(txq);
 	}
-	hns3_init_tx_ring_tc(hns);
 
-	return 0;
+	return hns3_init_tx_ring_tc(hns);
 }
 
 /*
-- 
2.33.0

