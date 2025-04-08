Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7599C3600C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 08:31:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E25A40EF1;
	Tue,  8 Apr 2025 10:31:11 +0200 (CEST)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mails.dpdk.org (Postfix) with ESMTP id 63AD940E68
 for <dev@dpdk.org>; Tue,  8 Apr 2025 10:31:05 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4ZWzkt3rwtz1R7gQ;
 Tue,  8 Apr 2025 16:29:10 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 94FBC1402C1;
 Tue,  8 Apr 2025 16:31:03 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Apr 2025 16:31:03 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <haijie1@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH 5/7] net/hns3: fix incorrect failed rollback
Date: Tue, 8 Apr 2025 16:30:58 +0800
Message-ID: <20250408083100.2845040-6-huangdengdui@huawei.com>
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

When the port is started, if the Tx queue fails to be started,
the map interrupt should be rolled back.

Fixes: fdfde7a4a0f8 ("net/hns3: fix mbuf leakage")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 drivers/net/hns3/hns3_ethdev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hns3/hns3_ethdev.c b/drivers/net/hns3/hns3_ethdev.c
index 20ad249b8b..2b56b6e44e 100644
--- a/drivers/net/hns3/hns3_ethdev.c
+++ b/drivers/net/hns3/hns3_ethdev.c
@@ -5122,7 +5122,7 @@ hns3_dev_start(struct rte_eth_dev *dev)
 	 */
 	ret = hns3_start_all_txqs(dev);
 	if (ret)
-		goto map_rx_inter_err;
+		goto start_all_txqs_fail;
 
 	ret = hns3_start_all_rxqs(dev);
 	if (ret)
@@ -5155,6 +5155,8 @@ hns3_dev_start(struct rte_eth_dev *dev)
 
 start_all_rxqs_fail:
 	hns3_stop_all_txqs(dev);
+start_all_txqs_fail:
+	hns3_unmap_rx_interrupt(dev);
 map_rx_inter_err:
 	(void)hns3_do_stop(hns);
 do_start_fail:
-- 
2.33.0

