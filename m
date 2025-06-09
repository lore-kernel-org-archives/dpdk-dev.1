Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E029C61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 13:07:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DF99640FDE;
	Mon,  9 Jun 2025 15:06:59 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id 5563C4060F
 for <dev@dpdk.org>; Mon,  9 Jun 2025 15:06:57 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.105])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bGBxJ34fsztS2Q;
 Mon,  9 Jun 2025 21:05:40 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 6E1161402DA;
 Mon,  9 Jun 2025 21:06:52 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Jun 2025 21:06:52 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH 1/3] net/hns3: fix the hardware GRO function is abnormal
Date: Mon, 9 Jun 2025 21:06:49 +0800
Message-ID: <20250609130651.2752977-2-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250609130651.2752977-1-huangdengdui@huawei.com>
References: <20250609130651.2752977-1-huangdengdui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
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

Currently, the alignment requirements of the data address in mbuf is
64-byte on HIP08 platform. However, the GRO feature will be abnormal
in this case.

Many online applications already use 64-byte aligned. So a check is added
to avoid using the GRO function when 64-byte aligned is used.

Fixes: d14c995b775a ("net/hns3: check Rx DMA address alignmnent")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 drivers/net/hns3/hns3_rxtx.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/hns3/hns3_rxtx.c b/drivers/net/hns3/hns3_rxtx.c
index bde46733b0..b7b9b9e3f2 100644
--- a/drivers/net/hns3/hns3_rxtx.c
+++ b/drivers/net/hns3/hns3_rxtx.c
@@ -281,6 +281,7 @@ hns3_free_all_queues(struct rte_eth_dev *dev)
 static int
 hns3_check_rx_dma_addr(struct hns3_hw *hw, uint64_t dma_addr)
 {
+	uint64_t rx_offload = hw->data->dev_conf.rxmode.offloads;
 	uint64_t rem;
 
 	rem = dma_addr & (hw->rx_dma_addr_align - 1);
@@ -289,6 +290,17 @@ hns3_check_rx_dma_addr(struct hns3_hw *hw, uint64_t dma_addr)
 			 "must be %u-byte aligned", hw->rx_dma_addr_align);
 		return -EINVAL;
 	}
+
+	/*
+	 * This check is for HIP08 network engine. The GRO function will be
+	 * abnormal when mbuf DMA address is 64-byte aligned.
+	 */
+	rem = dma_addr & (HNS3_RX_DMA_ADDR_ALIGN_128 - 1);
+	if ((rx_offload & RTE_ETH_RX_OFFLOAD_TCP_LRO) && rem > 0) {
+		hns3_err(hw, "Hardware GRO is not supported when mbuf DMA "
+			 "address is 64-byte aligned");
+		return -EINVAL;
+	}
 	return 0;
 }
 
-- 
2.33.0

