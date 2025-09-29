Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 521C0CAC5BE
	for <dpdk-dev@archiver.kernel.org>; Mon, 29 Sep 2025 11:36:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B584D406BA;
	Mon, 29 Sep 2025 13:36:02 +0200 (CEST)
Received: from canpmsgout08.his.huawei.com (canpmsgout08.his.huawei.com
 [113.46.200.223])
 by mails.dpdk.org (Postfix) with ESMTP id 3E97640669
 for <dev@dpdk.org>; Mon, 29 Sep 2025 13:35:58 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=9w2/414w7XxSua05sHn5HLExj4KSE095WhsjLdfcbnE=;
 b=daMwUO5sojvAJbfZFyDjeupqsn3MSK+AyFwV3eLwI0MyNglnW5Rxs66wGy9y7q0LGbSdpCIRJ
 9FU1AxP0zkpVf6rPjnAyY4xeZwLTxkwdDook8TKHfRgXztEzVY/KmJgAKOddMD1RksdqEMV9UW8
 ROmoxh0iO0zUcXRMFcXBE58=
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by canpmsgout08.his.huawei.com (SkyGuard) with ESMTPS id 4cZzdt0BqTzmV7l;
 Mon, 29 Sep 2025 19:35:46 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
 by mail.maildlp.com (Postfix) with ESMTPS id 816F9140143;
 Mon, 29 Sep 2025 19:35:56 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 29 Sep 2025 19:35:55 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <david.marchand@redhat.com>,
 <liuyonglong@huawei.com>, <kangfenglong@huawei.com>,
 <fengchengwen@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH 2/2] net/hns3: print invalid MAC address from firmware
Date: Mon, 29 Sep 2025 19:35:54 +0800
Message-ID: <20250929113554.2443832-3-yangxingui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250929113554.2443832-1-yangxingui@huawei.com>
References: <20250929113554.2443832-1-yangxingui@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.31.46]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemj100018.china.huawei.com (7.202.194.12)
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

The default MAC address from the firmware is usually valid. Print the
default MAC address when it's invalid to locate the problem.

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
 drivers/net/hns3/hns3_common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/hns3/hns3_common.c b/drivers/net/hns3/hns3_common.c
index 6709d7a70b..28d7e94ffb 100644
--- a/drivers/net/hns3/hns3_common.c
+++ b/drivers/net/hns3/hns3_common.c
@@ -723,12 +723,12 @@ hns3_init_mac_addrs(struct rte_eth_dev *dev)
 	eth_addr = (struct rte_ether_addr *)hw->mac.mac_addr;
 	if (!hns->is_vf) {
 		if (!rte_is_valid_assigned_ether_addr(eth_addr)) {
+			hns3_warn(hw, "MAC address " RTE_ETHER_ADDR_PRT_FMT " from firmware is invalid",
+				  RTE_ETHER_ADDR_BYTES(eth_addr));
 			rte_eth_random_addr(hw->mac.mac_addr);
 			hns3_ether_format_addr(mac_str, RTE_ETHER_ADDR_FMT_SIZE,
 				(struct rte_ether_addr *)hw->mac.mac_addr);
-			hns3_warn(hw, "default mac_addr from firmware is an invalid "
-				  "unicast address, using random MAC address %s",
-				  mac_str);
+			hns3_warn(hw, "using random MAC address %s", mac_str);
 		}
 	} else {
 		/*
-- 
2.33.0

