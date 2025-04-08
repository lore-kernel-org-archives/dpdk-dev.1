Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F217C369A1
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 08:31:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8563C40EDC;
	Tue,  8 Apr 2025 10:31:09 +0200 (CEST)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mails.dpdk.org (Postfix) with ESMTP id 3F8C540A89
 for <dev@dpdk.org>; Tue,  8 Apr 2025 10:31:05 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.44])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZWzgM3Tz2z1f1n5;
 Tue,  8 Apr 2025 16:26:07 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id E79C8140145;
 Tue,  8 Apr 2025 16:31:03 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Apr 2025 16:31:03 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <haijie1@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH 6/7] net/hns3: fix divide by zero
Date: Tue, 8 Apr 2025 16:30:59 +0800
Message-ID: <20250408083100.2845040-7-huangdengdui@huawei.com>
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

Driver may encounter divide-by-zero if the total_tqps_num
and rss_size_max in hw structure from firmware are zero.
So add some verification to them.

Fixes: d51867db65c1 ("net/hns3: add initialization")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 drivers/net/hns3/hns3_ethdev.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/hns3/hns3_ethdev.c b/drivers/net/hns3/hns3_ethdev.c
index 2b56b6e44e..2d4e348442 100644
--- a/drivers/net/hns3/hns3_ethdev.c
+++ b/drivers/net/hns3/hns3_ethdev.c
@@ -2544,6 +2544,10 @@ hns3_query_pf_resource(struct hns3_hw *hw)
 	req = (struct hns3_pf_res_cmd *)desc.data;
 	hw->total_tqps_num = rte_le_to_cpu_16(req->tqp_num) +
 			     rte_le_to_cpu_16(req->ext_tqp_num);
+	if (hw->total_tqps_num == 0) {
+		PMD_INIT_LOG(ERR, "the total tqp number of the port is 0.");
+		return -EINVAL;
+	}
 	ret = hns3_get_pf_max_tqp_num(hw);
 	if (ret)
 		return ret;
@@ -2795,6 +2799,7 @@ hns3_check_media_type(struct hns3_hw *hw, uint8_t media_type)
 static int
 hns3_get_board_configuration(struct hns3_hw *hw)
 {
+#define HNS3_RSS_SIZE_MAX_DEFAULT	64
 	struct hns3_adapter *hns = HNS3_DEV_HW_TO_ADAPTER(hw);
 	struct hns3_pf *pf = &hns->pf;
 	struct hns3_cfg cfg;
@@ -2813,6 +2818,11 @@ hns3_get_board_configuration(struct hns3_hw *hw)
 
 	hw->mac.media_type = cfg.media_type;
 	hw->rss_size_max = cfg.rss_size_max;
+	if (hw->rss_size_max == 0) {
+		PMD_INIT_LOG(WARNING, "rss_size_max is 0, already adjust to %u.",
+			     HNS3_RSS_SIZE_MAX_DEFAULT);
+		hw->rss_size_max = HNS3_RSS_SIZE_MAX_DEFAULT;
+	}
 	memcpy(hw->mac.mac_addr, cfg.mac_addr, RTE_ETHER_ADDR_LEN);
 	hw->mac.phy_addr = cfg.phy_addr;
 	hw->dcb_info.num_pg = 1;
-- 
2.33.0

