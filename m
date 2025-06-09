Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECC13C61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 13:07:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD2AA40EF1;
	Mon,  9 Jun 2025 15:06:58 +0200 (CEST)
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
 by mails.dpdk.org (Postfix) with ESMTP id A93444060F
 for <dev@dpdk.org>; Mon,  9 Jun 2025 15:06:56 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4bGBsr51HvzRk2r;
 Mon,  9 Jun 2025 21:02:40 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 16711180450;
 Mon,  9 Jun 2025 21:06:53 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Jun 2025 21:06:52 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH 3/3] net/hns3: fix can't use vector for Rx when set VLAN filter
Date: Mon, 9 Jun 2025 21:06:51 +0800
Message-ID: <20250609130651.2752977-4-huangdengdui@huawei.com>
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

Currently, When RTE_ETH_RX_OFFLOAD_VLAN_FILTER offload is set,
driver wouldn't select Rx vector algorithm. Actually, this
algorithm support it, so open it.

Fixes: a3d4f4d291d7 ("net/hns3: support NEON Rx")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 drivers/net/hns3/hns3_rxtx_vec.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hns3/hns3_rxtx_vec.c b/drivers/net/hns3/hns3_rxtx_vec.c
index 9fb66ea2de..daadd7e19f 100644
--- a/drivers/net/hns3/hns3_rxtx_vec.c
+++ b/drivers/net/hns3/hns3_rxtx_vec.c
@@ -184,7 +184,9 @@ hns3_rx_check_vec_support(struct rte_eth_dev *dev)
 {
 	struct rte_eth_rxmode *rxmode = &dev->data->dev_conf.rxmode;
 	uint64_t offloads_mask = RTE_ETH_RX_OFFLOAD_TCP_LRO |
-				 RTE_ETH_RX_OFFLOAD_VLAN |
+				 RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
+				 RTE_ETH_RX_OFFLOAD_VLAN_EXTEND |
+				 RTE_ETH_RX_OFFLOAD_QINQ_STRIP |
 				 RTE_ETH_RX_OFFLOAD_TIMESTAMP |
 				 RTE_ETH_RX_OFFLOAD_KEEP_CRC;
 
-- 
2.33.0

