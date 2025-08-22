Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F498CA0EED
	for <dpdk-dev@archiver.kernel.org>; Fri, 22 Aug 2025 06:05:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7D7340664;
	Fri, 22 Aug 2025 08:04:41 +0200 (CEST)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
 by mails.dpdk.org (Postfix) with ESMTP id AFC6C402A2
 for <dev@dpdk.org>; Fri, 22 Aug 2025 08:04:34 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.194])
 by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4c7V136lRpz13NK2;
 Fri, 22 Aug 2025 14:00:55 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 8EFDC1402DB;
 Fri, 22 Aug 2025 14:04:31 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 22 Aug 2025 14:04:31 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <david.marchand@redhat.com>,
 <lihuisong@huawei.com>, <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH v2 4/4] net/hns3: fix overwrite mbuf in vector path
Date: Fri, 22 Aug 2025 14:04:29 +0800
Message-ID: <20250822060429.1799167-5-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250822060429.1799167-1-huangdengdui@huawei.com>
References: <20250813073317.1352274-1-huangdengdui@huawei.com>
 <20250822060429.1799167-1-huangdengdui@huawei.com>
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

The vector path processes multiple descriptors at a time and modifies
the corresponding mbufs accordingly. When the mbufs cannot be applied
for, the previous patch [1] only clears the first descriptor's valid
bit, which is not enough. In this patch, the mbufs points to the
fake_mbuf to prevent overwrite.

[1] 'commit 01843ab2f2fc ("net/hns3: fix crash for NEON and SVE")'

Fixes: a3d4f4d291d7 ("net/hns3: support NEON Rx")
Fixes: 01843ab2f2fc ("net/hns3: fix crash for NEON and SVE")
Cc: stable@dpdk.org

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 drivers/net/hns3/hns3_rxtx_vec.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/hns3/hns3_rxtx_vec.h b/drivers/net/hns3/hns3_rxtx_vec.h
index 9018e79c2f..6afa2fb814 100644
--- a/drivers/net/hns3/hns3_rxtx_vec.h
+++ b/drivers/net/hns3/hns3_rxtx_vec.h
@@ -109,8 +109,12 @@ hns3_rxq_rearm_mbuf(struct hns3_rx_queue *rxq)
 		/*
 		 * Clear VLD bit for the first descriptor rearmed in case
 		 * of going to receive packets later.
+		 * And also point mbufs to fake_mbuf to prevent modification
+		 * of the mbuf field during vector packet receiving.
 		 */
 		rxdp[0].rx.bd_base_info = 0;
+		for (i = 0; i < HNS3_VECTOR_RX_OFFSET_TABLE_LEN; i++)
+			rxep[i].mbuf = &rxq->fake_mbuf;
 		rte_eth_devices[rxq->port_id].data->rx_mbuf_alloc_failed++;
 		return;
 	}
-- 
2.33.0

