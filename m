Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11AB6C61CE8
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 13:06:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CB38140ED8;
	Mon,  9 Jun 2025 15:06:56 +0200 (CEST)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mails.dpdk.org (Postfix) with ESMTP id 87865400EF
 for <dev@dpdk.org>; Mon,  9 Jun 2025 15:06:55 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.163])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bGBzj0SZCz2wB8T;
 Mon,  9 Jun 2025 21:07:45 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id C9AC9180043;
 Mon,  9 Jun 2025 21:06:52 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 9 Jun 2025 21:06:52 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH 2/3] net/hns3: fix can't use vector for Tx when not set fast
 free
Date: Mon, 9 Jun 2025 21:06:50 +0800
Message-ID: <20250609130651.2752977-3-huangdengdui@huawei.com>
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

Currently, select Tx vector algorithm only when tx_offload is
RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE. Actually, this algorithm
already supported the case that tx_offload isn't fast free.

Fixes: e31f123db06b ("net/hns3: support NEON Tx")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 drivers/net/hns3/hns3_rxtx_vec.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/hns3/hns3_rxtx_vec.c b/drivers/net/hns3/hns3_rxtx_vec.c
index bf37ce51b1..9fb66ea2de 100644
--- a/drivers/net/hns3/hns3_rxtx_vec.c
+++ b/drivers/net/hns3/hns3_rxtx_vec.c
@@ -16,11 +16,11 @@
 int
 hns3_tx_check_vec_support(struct rte_eth_dev *dev)
 {
-	struct rte_eth_txmode *txmode = &dev->data->dev_conf.txmode;
+	uint64_t tx_offloads = dev->data->dev_conf.txmode.offloads;
 	struct rte_eth_rxmode *rxmode = &dev->data->dev_conf.rxmode;
 
-	/* Only support RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE */
-	if (txmode->offloads != RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE)
+	/* Only support when Tx offloads is RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE or 0. */
+	if (tx_offloads != RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE && tx_offloads != 0)
 		return -ENOTSUP;
 
 	/*
-- 
2.33.0

