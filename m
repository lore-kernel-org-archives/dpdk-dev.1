Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 043E0C3600C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 08:31:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BF7F40FDE;
	Tue,  8 Apr 2025 10:31:12 +0200 (CEST)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by mails.dpdk.org (Postfix) with ESMTP id 9BAB040E6E
 for <dev@dpdk.org>; Tue,  8 Apr 2025 10:31:05 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4ZWzj92LnRzHrMd;
 Tue,  8 Apr 2025 16:27:41 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 48FA31800E4;
 Tue,  8 Apr 2025 16:31:04 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Apr 2025 16:31:03 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <haijie1@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH 7/7] net/hns3: fix unrelease some resources on reset case
Date: Tue, 8 Apr 2025 16:31:00 +0800
Message-ID: <20250408083100.2845040-8-huangdengdui@huawei.com>
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

Some resources, like, unmapping Rx interrupt, doesn't perform
when execute dev_stop on reset. This will lead to other issues.

Fixes: 2790c6464725 ("net/hns3: support device reset")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 drivers/net/hns3/hns3_ethdev.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/net/hns3/hns3_ethdev.c b/drivers/net/hns3/hns3_ethdev.c
index 2d4e348442..9f99525e70 100644
--- a/drivers/net/hns3/hns3_ethdev.c
+++ b/drivers/net/hns3/hns3_ethdev.c
@@ -5219,20 +5219,23 @@ hns3_dev_stop(struct rte_eth_dev *dev)
 	struct hns3_hw *hw = &hns->hw;
 
 	PMD_INIT_FUNC_TRACE();
+	if (rte_atomic_load_explicit(&hw->reset.resetting, rte_memory_order_relaxed) != 0) {
+		hns3_warn(hw, "device is resetting, stop operation is not allowed.");
+		return -EBUSY;
+	}
+
 	dev->data->dev_started = 0;
 
 	hw->adapter_state = HNS3_NIC_STOPPING;
 	hns3_stop_rxtx_datapath(dev);
 
 	rte_spinlock_lock(&hw->lock);
-	if (rte_atomic_load_explicit(&hw->reset.resetting, rte_memory_order_relaxed) == 0) {
-		hns3_tm_dev_stop_proc(hw);
-		hns3_config_mac_tnl_int(hw, false);
-		hns3_stop_tqps(hw);
-		hns3_do_stop(hns);
-		hns3_unmap_rx_interrupt(dev);
-		hw->adapter_state = HNS3_NIC_CONFIGURED;
-	}
+	hns3_tm_dev_stop_proc(hw);
+	hns3_config_mac_tnl_int(hw, false);
+	hns3_stop_tqps(hw);
+	hns3_do_stop(hns);
+	hns3_unmap_rx_interrupt(dev);
+	hw->adapter_state = HNS3_NIC_CONFIGURED;
 	hns3_rx_scattered_reset(dev);
 	rte_eal_alarm_cancel(hns3_service_handler, dev);
 	hns3_stop_report_lse(dev);
-- 
2.33.0

