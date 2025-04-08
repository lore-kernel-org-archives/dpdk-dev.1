Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10F50C3600C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 08:31:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E1444027F;
	Tue,  8 Apr 2025 10:31:07 +0200 (CEST)
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
 by mails.dpdk.org (Postfix) with ESMTP id 6873640E4C
 for <dev@dpdk.org>; Tue,  8 Apr 2025 10:31:04 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4ZWzmG6jZJz1d1Jd;
 Tue,  8 Apr 2025 16:30:22 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 4B576180104;
 Tue,  8 Apr 2025 16:31:02 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Apr 2025 16:31:01 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <haijie1@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH 1/7] net/hns3: fix variable overflow
Date: Tue, 8 Apr 2025 16:30:54 +0800
Message-ID: <20250408083100.2845040-2-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250408083100.2845040-1-huangdengdui@huawei.com>
References: <20250408083100.2845040-1-huangdengdui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

The number of interrupt vector may exceed the range of uint8_t.
So hns3_unmap_rx_interrupt() should use uint16_t for 'vec' variable.

Fixes: 02a7b55657b2 ("net/hns3: support Rx interrupt")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 drivers/net/hns3/hns3_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hns3/hns3_common.c b/drivers/net/hns3/hns3_common.c
index 25a45212be..dc70bf3cff 100644
--- a/drivers/net/hns3/hns3_common.c
+++ b/drivers/net/hns3/hns3_common.c
@@ -882,8 +882,8 @@ hns3_unmap_rx_interrupt(struct rte_eth_dev *dev)
 	struct rte_intr_handle *intr_handle = pci_dev->intr_handle;
 	struct hns3_adapter *hns = dev->data->dev_private;
 	struct hns3_hw *hw = &hns->hw;
-	uint8_t base = RTE_INTR_VEC_ZERO_OFFSET;
-	uint8_t vec = RTE_INTR_VEC_ZERO_OFFSET;
+	uint16_t base = RTE_INTR_VEC_ZERO_OFFSET;
+	uint16_t vec = RTE_INTR_VEC_ZERO_OFFSET;
 	uint16_t q_id;
 
 	if (dev->data->dev_conf.intr_conf.rxq == 0)
-- 
2.33.0

