Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36262C61CE7
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 08:19:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 18E4F402F0;
	Wed, 11 Jun 2025 10:19:06 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id 6F938402C5
 for <dev@dpdk.org>; Wed, 11 Jun 2025 10:19:04 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.163.252])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bHJNn6rzbzRk6M;
 Wed, 11 Jun 2025 16:14:49 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 2688E180B61;
 Wed, 11 Jun 2025 16:19:03 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 11 Jun 2025 16:19:02 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH 4/6] net/hns3: VF support parse max TC number
Date: Wed, 11 Jun 2025 16:18:58 +0800
Message-ID: <20250611081900.3658421-5-huangdengdui@huawei.com>
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

The mailbox message HNS3_MBX_GET_BASIC_INFO can obtain the maximum
number of TCs of the device. The VF does not support multiple TCs,
therefore, this field is not saved.

Now the VF needs to support multiple TCs, therefore, this field needs
to be saved.

This commit also support dump the TC info.

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 drivers/net/hns3/hns3_dump.c      | 2 ++
 drivers/net/hns3/hns3_ethdev_vf.c | 1 +
 drivers/net/hns3/hns3_mbx.h       | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hns3/hns3_dump.c b/drivers/net/hns3/hns3_dump.c
index 6c43ec486e..63c6b4ef2c 100644
--- a/drivers/net/hns3/hns3_dump.c
+++ b/drivers/net/hns3/hns3_dump.c
@@ -209,6 +209,7 @@ hns3_get_device_basic_info(FILE *file, struct rte_eth_dev *dev)
 		"  - Device Base Info:\n"
 		"\t  -- name: %s\n"
 		"\t  -- adapter_state=%s\n"
+		"\t  -- tc_max=%u tc_num=%u\n"
 		"\t  -- nb_rx_queues=%u nb_tx_queues=%u\n"
 		"\t  -- total_tqps_num=%u tqps_num=%u intr_tqps_num=%u\n"
 		"\t  -- rss_size_max=%u alloc_rss_size=%u tx_qnum_per_tc=%u\n"
@@ -221,6 +222,7 @@ hns3_get_device_basic_info(FILE *file, struct rte_eth_dev *dev)
 		"\t  -- intr_conf: lsc=%u rxq=%u\n",
 		dev->data->name,
 		hns3_get_adapter_state_name(hw->adapter_state),
+		hw->dcb_info.tc_max, hw->dcb_info.num_tc,
 		dev->data->nb_rx_queues, dev->data->nb_tx_queues,
 		hw->total_tqps_num, hw->tqps_num, hw->intr_tqps_num,
 		hw->rss_size_max, hw->alloc_rss_size, hw->tx_qnum_per_tc,
diff --git a/drivers/net/hns3/hns3_ethdev_vf.c b/drivers/net/hns3/hns3_ethdev_vf.c
index 1cb8a9ccc1..632409c5d0 100644
--- a/drivers/net/hns3/hns3_ethdev_vf.c
+++ b/drivers/net/hns3/hns3_ethdev_vf.c
@@ -853,6 +853,7 @@ hns3vf_get_basic_info(struct hns3_hw *hw)
 	}
 
 	basic_info = (struct hns3_basic_info *)resp_msg;
+	hw->dcb_info.tc_max = basic_info->tc_max;
 	hw->dcb_info.hw_tc_map = basic_info->hw_tc_map;
 	hw->dcb_info.num_tc = hns3vf_get_num_tc(hw);
 	hw->pf_vf_if_version = basic_info->pf_vf_if_version;
diff --git a/drivers/net/hns3/hns3_mbx.h b/drivers/net/hns3/hns3_mbx.h
index c73f34fb32..651c6b9023 100644
--- a/drivers/net/hns3/hns3_mbx.h
+++ b/drivers/net/hns3/hns3_mbx.h
@@ -53,7 +53,7 @@ enum HNS3_MBX_OPCODE {
 
 struct hns3_basic_info {
 	uint8_t hw_tc_map;
-	uint8_t rsv;
+	uint8_t tc_max;
 	uint16_t pf_vf_if_version;
 	/* capabilities of VF dependent on PF */
 	uint32_t caps;
-- 
2.33.0

