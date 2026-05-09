Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08352CD343F
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 06:47:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3EE82402AB;
	Sat,  9 May 2026 08:47:59 +0200 (CEST)
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com
 [113.46.200.217])
 by mails.dpdk.org (Postfix) with ESMTP id 679A34026D
 for <dev@dpdk.org>; Sat,  9 May 2026 08:47:57 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=68i6CaVuhFdZpBtZZFrp9KG2D17E32vqZIfzCi0bgVs=;
 b=WldFVMsrUG4jekNyZHEV36EjuRzhN0zk4qalfsxs0DpGFgyix/wamYGf+Fb7xmtGAJycBmI4j
 2R0bqfTlhrxFxZfisKKNQJYAduMhDOs09OinXq5pqtcb6vJkZvJ8+wcYlPuQOGfNiaYw6es9ERw
 d2Sd/rmkSpBlZTjuWyGEJo0=
Received: from mail.maildlp.com (unknown [172.19.163.0])
 by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4gCGZx19yRzcZyn;
 Sat,  9 May 2026 14:40:41 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
 by mail.maildlp.com (Postfix) with ESMTPS id E9F3340561;
 Sat,  9 May 2026 14:47:54 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Sat, 9 May 2026 14:47:54 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <david.marchand@redhat.com>,
 <fengchengwen@huawei.com>, <lihuisong@huawei.com>, <liuyonglong@huawei.com>,
 <kangfenglong@huawei.com>
Subject: [PATCH v2] net/hns3: fix L4 checksum incorrect for tunnel packets
Date: Sat, 9 May 2026 14:47:53 +0800
Message-ID: <20260509064753.3292074-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.31.46]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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

In HIP09 simple BD mode, the driver incorrectly calculates L4_START
position for tunnel packets. The current implementation only uses
l2_len + l3_len without considering outer header lengths (outer_l2_len
and outer_l3_len), causing hardware to calculate checksum from wrong
offset.

For a typical NvGRE tunnel packet with structure:
  Outer Eth(14) + Outer IPv6(40) + NvGRE(8) + Inner Eth(14) +
  Inner IPv6(40) + TCP(20)

Expected L4_START: 116 bytes (from packet start to inner TCP header)
Actual calculation: 62 bytes (missing outer headers)

This results in incorrect TCP/UDP checksum for all tunnel packets when
using simple BD mode, including NvGRE, VxLAN, GRE, GENEVE tunnels.

Fix by adding outer_l2_len and outer_l3_len to L4_START calculation
when RTE_MBUF_F_TX_TUNNEL_MASK flag is set.

Fixes: 6393fc0b823c ("net/hns3: simplify hardware checksum offloading")
Cc: stable@dpdk.org

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
 drivers/net/hns3/hns3_rxtx.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hns3/hns3_rxtx.c b/drivers/net/hns3/hns3_rxtx.c
index 573604b0cd..4d48cbdc11 100644
--- a/drivers/net/hns3/hns3_rxtx.c
+++ b/drivers/net/hns3/hns3_rxtx.c
@@ -3982,6 +3982,7 @@ hns3_handle_simple_bd(struct hns3_tx_queue *txq, struct hns3_desc *desc,
 {
 #define HNS3_TCP_CSUM_OFFSET	16
 #define HNS3_UDP_CSUM_OFFSET	6
+	uint32_t l4_start;
 
 	/*
 	 * In HIP09, NIC HW support Tx simple BD mode that the HW will
@@ -4003,9 +4004,13 @@ hns3_handle_simple_bd(struct hns3_tx_queue *txq, struct hns3_desc *desc,
 	    ((m->ol_flags & RTE_MBUF_F_TX_L4_MASK) == RTE_MBUF_F_TX_TCP_CKSUM ||
 	     (m->ol_flags & RTE_MBUF_F_TX_L4_MASK) == RTE_MBUF_F_TX_UDP_CKSUM)) {
 		/* set checksum start and offset, defined in 2 Bytes */
+		l4_start = m->l2_len + m->l3_len;
+		if (m->ol_flags & RTE_MBUF_F_TX_TUNNEL_MASK)
+			l4_start += m->outer_l2_len + m->outer_l3_len;
+
 		hns3_set_field(desc->tx.type_cs_vlan_tso_len,
 			       HNS3_TXD_L4_START_M, HNS3_TXD_L4_START_S,
-			       (m->l2_len + m->l3_len) >> HNS3_SIMPLE_BD_UNIT);
+			       l4_start >> HNS3_SIMPLE_BD_UNIT);
 		hns3_set_field(desc->tx.ol_type_vlan_len_msec,
 			   HNS3_TXD_L4_CKS_OFFSET_M, HNS3_TXD_L4_CKS_OFFSET_S,
 			   (m->ol_flags & RTE_MBUF_F_TX_L4_MASK) ==
-- 
2.33.0

