Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38BD8C3600C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 08:31:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 43B0540E5E;
	Tue,  8 Apr 2025 10:31:05 +0200 (CEST)
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
 by mails.dpdk.org (Postfix) with ESMTP id 48D5F4027F
 for <dev@dpdk.org>; Tue,  8 Apr 2025 10:31:04 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4ZWzj81kqNz2CdKK;
 Tue,  8 Apr 2025 16:27:40 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id EBD131402C1;
 Tue,  8 Apr 2025 16:31:02 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Apr 2025 16:31:02 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <haijie1@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH 3/7] net/hns3: fix extra waiting for link up
Date: Tue, 8 Apr 2025 16:30:56 +0800
Message-ID: <20250408083100.2845040-4-huangdengdui@huawei.com>
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

If the link auto-negotiation of the NIC is disabled,
or the flow control auto-negotiation is not supported,
it's unnecessary to wait for link establishment.

Fixes: 1f411e31a826 ("net/hns3: support flow control autoneg for copper port")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 drivers/net/hns3/hns3_ethdev.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/hns3/hns3_ethdev.c b/drivers/net/hns3/hns3_ethdev.c
index 9f7119b734..20ad249b8b 100644
--- a/drivers/net/hns3/hns3_ethdev.c
+++ b/drivers/net/hns3/hns3_ethdev.c
@@ -5308,12 +5308,6 @@ hns3_get_current_fc_mode(struct rte_eth_dev *dev)
 	struct hns3_pf *pf = HNS3_DEV_PRIVATE_TO_PF(dev->data->dev_private);
 	struct hns3_mac *mac = &hw->mac;
 
-	/*
-	 * When the flow control mode is obtained, the device may not complete
-	 * auto-negotiation. It is necessary to wait for link establishment.
-	 */
-	(void)hns3_dev_link_update(dev, 1);
-
 	/*
 	 * If the link auto-negotiation of the nic is disabled, or the flow
 	 * control auto-negotiation is not supported, the forced flow control
@@ -5322,6 +5316,12 @@ hns3_get_current_fc_mode(struct rte_eth_dev *dev)
 	if (mac->link_autoneg == 0 || !pf->support_fc_autoneg)
 		return hw->requested_fc_mode;
 
+	/*
+	 * When the flow control mode is obtained, the device may not complete
+	 * auto-negotiation. It is necessary to wait for link establishment.
+	 */
+	(void)hns3_dev_link_update(dev, 1);
+
 	return hns3_get_autoneg_fc_mode(hw);
 }
 
-- 
2.33.0

