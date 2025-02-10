Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0C6FC021A0
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 03:08:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2942E402D1;
	Mon, 10 Feb 2025 04:08:36 +0100 (CET)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id 5702D402A1
 for <dev@dpdk.org>; Mon, 10 Feb 2025 04:08:35 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4YrqD82Ryjz11PxJ;
 Mon, 10 Feb 2025 11:04:08 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
 by mail.maildlp.com (Postfix) with ESMTPS id 9B3921800EB;
 Mon, 10 Feb 2025 11:08:32 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Feb 2025 11:08:32 +0800
From: Jie Hai <haijie1@huawei.com>
To: <dev@dpdk.org>, <thomas@monjalon.net>, <ferruh.yigit@amd.com>, Lijun Ou
 <oulijun@huawei.com>, Huisong Li <lihuisong@huawei.com>
CC: <fengchengwen@huawei.com>, <haijie1@huawei.com>, <huangdengdui@huawei.com>
Subject: [PATCH 1/2] net/hns3: fix possible copper port initialize fail
Date: Mon, 10 Feb 2025 11:01:12 +0800
Message-ID: <20250210030113.1154709-2-haijie1@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250210030113.1154709-1-haijie1@huawei.com>
References: <20250210030113.1154709-1-haijie1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.30.45]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf500004.china.huawei.com (7.202.181.242)
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

From: Dengdui Huang <huangdengdui@huawei.com>

The initialization of copper port contains the following two steps.
1. Configure firmware takeover the PHY. The firmware will start an
   asynchronous task to initialize the PHY chip.
2. Configure work speed and duplex.
In earlier versions of the firmware, when the asynchronous task is not
finished, the firmware will return -ENOTBLK in the second step. And this
will lead to driver failed to initialize. Here add retry for this case.

Fixes: 2e4859f3b362 ("net/hns3: support PF device with copper PHYs")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 drivers/net/hns3/hns3_ethdev.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hns3/hns3_ethdev.c b/drivers/net/hns3/hns3_ethdev.c
index 72d1c30a7b2e..9f7119b734bc 100644
--- a/drivers/net/hns3/hns3_ethdev.c
+++ b/drivers/net/hns3/hns3_ethdev.c
@@ -4852,7 +4852,7 @@ hns3_get_link_duplex(uint32_t link_speeds)
 }
 
 static int
-hns3_set_copper_port_link_speed(struct hns3_hw *hw,
+hns3_copper_port_link_speed_cfg(struct hns3_hw *hw,
 				struct hns3_set_link_speed_cfg *cfg)
 {
 	struct hns3_cmd_desc desc[HNS3_PHY_PARAM_CFG_BD_NUM];
@@ -4886,6 +4886,33 @@ hns3_set_copper_port_link_speed(struct hns3_hw *hw,
 	return hns3_cmd_send(hw, desc, HNS3_PHY_PARAM_CFG_BD_NUM);
 }
 
+static int
+hns3_set_copper_port_link_speed(struct hns3_hw *hw,
+				struct hns3_set_link_speed_cfg *cfg)
+{
+#define HNS3_PHY_PARAM_CFG_RETRY_TIMES		10
+#define HNS3_PHY_PARAM_CFG_RETRY_DELAY_MS	100
+	uint32_t retry_cnt = 0;
+	int ret;
+
+	/*
+	 * The initialization of copper port contains the following two steps.
+	 * 1. Configure firmware takeover the PHY. The firmware will start an
+	 *    asynchronous task to initialize the PHY chip.
+	 * 2. Configure work speed and duplex.
+	 * In earlier versions of the firmware, when the asynchronous task is not
+	 * finished, the firmware will return -ENOTBLK in the second step. And this
+	 * will lead to driver failed to initialize. Here add retry for this case.
+	 */
+	ret = hns3_copper_port_link_speed_cfg(hw, cfg);
+	while (ret == -ENOTBLK && retry_cnt++ < HNS3_PHY_PARAM_CFG_RETRY_TIMES) {
+		rte_delay_ms(HNS3_PHY_PARAM_CFG_RETRY_DELAY_MS);
+		ret = hns3_copper_port_link_speed_cfg(hw, cfg);
+	}
+
+	return ret;
+}
+
 static int
 hns3_set_autoneg(struct hns3_hw *hw, bool enable)
 {
-- 
2.33.0

