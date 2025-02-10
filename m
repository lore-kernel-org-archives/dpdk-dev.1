Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 561A7C021A1
	for <dpdk-dev@archiver.kernel.org>; Mon, 10 Feb 2025 03:08:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 07CA740DF6;
	Mon, 10 Feb 2025 04:08:38 +0100 (CET)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mails.dpdk.org (Postfix) with ESMTP id 8E9DA40A7A
 for <dev@dpdk.org>; Mon, 10 Feb 2025 04:08:35 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YrqDy4jc8z1ltYs;
 Mon, 10 Feb 2025 11:04:50 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
 by mail.maildlp.com (Postfix) with ESMTPS id 5AD871402C7;
 Mon, 10 Feb 2025 11:08:33 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 10 Feb 2025 11:08:32 +0800
From: Jie Hai <haijie1@huawei.com>
To: <dev@dpdk.org>, <thomas@monjalon.net>, <ferruh.yigit@amd.com>, "Min Hu
 (Connor)" <humin29@huawei.com>, "Wei Hu (Xavier)" <xavier.huwei@huawei.com>,
 Hao Chen <chenh@yusur.tech>, Ferruh Yigit <ferruh.yigit@intel.com>, Huisong
 Li <lihuisong@huawei.com>
CC: <fengchengwen@huawei.com>, <haijie1@huawei.com>, <huangdengdui@huawei.com>
Subject: [PATCH 2/2] net/hns3: fix possible reset timeout
Date: Mon, 10 Feb 2025 11:01:13 +0800
Message-ID: <20250210030113.1154709-3-haijie1@huawei.com>
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

There is low probability that the driver reset timeout, the root cause is
that the firmware processing take a litter long than normal when process
reset command. This patch fix it by changing the timeout of the reset
command to 100 ms.

Fixes: 737f30e1c3ab ("net/hns3: support command interface with firmware")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 drivers/net/hns3/hns3_cmd.c | 18 ++++++++++++------
 drivers/net/hns3/hns3_cmd.h |  4 ++--
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/net/hns3/hns3_cmd.c b/drivers/net/hns3/hns3_cmd.c
index 146444e2fa99..398b75384ee9 100644
--- a/drivers/net/hns3/hns3_cmd.c
+++ b/drivers/net/hns3/hns3_cmd.c
@@ -304,8 +304,17 @@ hns3_cmd_get_hardware_reply(struct hns3_hw *hw,
 	return hns3_cmd_convert_err_code(desc_ret);
 }
 
-static int hns3_cmd_poll_reply(struct hns3_hw *hw)
+static uint32_t hns3_get_cmd_tx_timeout(uint16_t opcode)
 {
+	if (opcode == HNS3_OPC_CFG_RST_TRIGGER)
+		return HNS3_COMQ_CFG_RST_TIMEOUT;
+
+	return HNS3_CMDQ_TX_TIMEOUT_DEFAULT;
+}
+
+static int hns3_cmd_poll_reply(struct hns3_hw *hw, uint16_t opcode)
+{
+	uint32_t cmdq_tx_timeout = hns3_get_cmd_tx_timeout(opcode);
 	struct hns3_adapter *hns = HNS3_DEV_HW_TO_ADAPTER(hw);
 	uint32_t timeout = 0;
 
@@ -326,7 +335,7 @@ static int hns3_cmd_poll_reply(struct hns3_hw *hw)
 
 		rte_delay_us(1);
 		timeout++;
-	} while (timeout < hw->cmq.tx_timeout);
+	} while (timeout < cmdq_tx_timeout);
 	hns3_err(hw, "Wait for reply timeout");
 	return -ETIME;
 }
@@ -400,7 +409,7 @@ hns3_cmd_send(struct hns3_hw *hw, struct hns3_cmd_desc *desc, int num)
 	 * if multi descriptors to be sent, use the first one to check.
 	 */
 	if (HNS3_CMD_SEND_SYNC(rte_le_to_cpu_16(desc->flag))) {
-		retval = hns3_cmd_poll_reply(hw);
+		retval = hns3_cmd_poll_reply(hw, desc->opcode);
 		if (!retval)
 			retval = hns3_cmd_get_hardware_reply(hw, desc, num,
 							     ntc);
@@ -611,9 +620,6 @@ hns3_cmd_init_queue(struct hns3_hw *hw)
 	hw->cmq.csq.desc_num = HNS3_NIC_CMQ_DESC_NUM;
 	hw->cmq.crq.desc_num = HNS3_NIC_CMQ_DESC_NUM;
 
-	/* Setup Tx write back timeout */
-	hw->cmq.tx_timeout = HNS3_CMDQ_TX_TIMEOUT;
-
 	/* Setup queue rings */
 	ret = hns3_alloc_cmd_queue(hw, HNS3_TYPE_CSQ);
 	if (ret) {
diff --git a/drivers/net/hns3/hns3_cmd.h b/drivers/net/hns3/hns3_cmd.h
index 79a8c1edad56..4d707c13b29b 100644
--- a/drivers/net/hns3/hns3_cmd.h
+++ b/drivers/net/hns3/hns3_cmd.h
@@ -10,7 +10,8 @@
 #include <rte_byteorder.h>
 #include <rte_spinlock.h>
 
-#define HNS3_CMDQ_TX_TIMEOUT		30000
+#define HNS3_CMDQ_TX_TIMEOUT_DEFAULT	30000
+#define HNS3_COMQ_CFG_RST_TIMEOUT	100000
 #define HNS3_CMDQ_CLEAR_WAIT_TIME	200
 #define HNS3_CMDQ_RX_INVLD_B		0
 #define HNS3_CMDQ_RX_OUTVLD_B		1
@@ -62,7 +63,6 @@ enum hns3_cmd_return_status {
 struct hns3_cmq {
 	struct hns3_cmq_ring csq;
 	struct hns3_cmq_ring crq;
-	uint16_t tx_timeout;
 	enum hns3_cmd_return_status last_status;
 };
 
-- 
2.33.0

