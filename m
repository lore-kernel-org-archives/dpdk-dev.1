Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F3AFC3600C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 08:31:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5819540E68;
	Tue,  8 Apr 2025 10:31:06 +0200 (CEST)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mails.dpdk.org (Postfix) with ESMTP id 5B06640A89
 for <dev@dpdk.org>; Tue,  8 Apr 2025 10:31:04 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4ZWznp5zFTz27hRP;
 Tue,  8 Apr 2025 16:31:42 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 926E41402C1;
 Tue,  8 Apr 2025 16:31:02 +0800 (CST)
Received: from localhost.huawei.com (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 8 Apr 2025 16:31:02 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <haijie1@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH 2/7] net/hns3: fix memory leakage in failure path
Date: Tue, 8 Apr 2025 16:30:55 +0800
Message-ID: <20250408083100.2845040-3-huangdengdui@huawei.com>
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

When the hns3_dfx_reg_fetch_data() function returns from processing
failure, cmd_descs is not freed, which leads to leakage.
This patch fit it.

By the way, this patch uses calloc to apply for heap memory instead
of hugepage memory.

Fixes: ef1fbd355451 ("net/hns3: add more registers to dump")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 drivers/net/hns3/hns3_regs.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/hns3/hns3_regs.c b/drivers/net/hns3/hns3_regs.c
index 8a6ddbfe8c..5c74f9ae2e 100644
--- a/drivers/net/hns3/hns3_regs.c
+++ b/drivers/net/hns3/hns3_regs.c
@@ -1270,7 +1270,7 @@ hns3_get_dfx_regs(struct hns3_hw *hw, struct rte_dev_reg_info *regs, uint32_t mo
 	for (i = 0; i < opcode_num; i++)
 		max_bd_num = RTE_MAX(bd_num_list[i], max_bd_num);
 
-	cmd_descs = rte_zmalloc(NULL, sizeof(*cmd_descs) * max_bd_num, 0);
+	cmd_descs = calloc(max_bd_num, sizeof(*cmd_descs));
 	if (cmd_descs == NULL)
 		return -ENOMEM;
 
@@ -1290,13 +1290,14 @@ hns3_get_dfx_regs(struct hns3_hw *hw, struct rte_dev_reg_info *regs, uint32_t mo
 		if (regs_num !=  hns3_reg_lists[i].entry_num) {
 			hns3_err(hw, "Query register number differ from the list for module %s!",
 				 hns3_get_name_by_module(i));
+			free(cmd_descs);
 			return -EINVAL;
 		}
 		hns3_fill_dfx_regs_name(hw, regs, hns3_reg_lists[i].reg_list, regs_num);
 		regs->length += regs_num;
 		data += regs_num;
 	}
-	rte_free(cmd_descs);
+	free(cmd_descs);
 
 	return ret;
 }
-- 
2.33.0

