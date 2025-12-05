Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78882D2E022
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Dec 2025 07:40:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 91D5140156;
	Fri,  5 Dec 2025 08:40:01 +0100 (CET)
Received: from canpmsgout01.his.huawei.com (canpmsgout01.his.huawei.com
 [113.46.200.216])
 by mails.dpdk.org (Postfix) with ESMTP id 6F38640144
 for <dev@dpdk.org>; Fri,  5 Dec 2025 08:39:59 +0100 (CET)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=b/SELZPLSlPnc2qAAP+hCKFwpBsVv1ePjhRt8yUQxC0=;
 b=BxMzAMu/r/fQZcIusWzvlUY/X18SjtFyceCLYnjZaKeP7CqepWbJB6jKubXjbexz1Vl2GR1hw
 D3JgsF372g/4+XYXR8jhaxYdCx5SB5iWDuUc+dMlCCzA6bJmIkxLLwlrRWiQQpvEmDyW5O/Dplo
 3JpuMG3dHJvDk77MBMc2K30=
Received: from mail.maildlp.com (unknown [172.19.163.174])
 by canpmsgout01.his.huawei.com (SkyGuard) with ESMTPS id 4dN3Bd38YHz1T4JP;
 Fri,  5 Dec 2025 15:38:01 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
 by mail.maildlp.com (Postfix) with ESMTPS id A10FE140158;
 Fri,  5 Dec 2025 15:39:56 +0800 (CST)
Received: from localhost.huawei.com (10.90.31.46) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 5 Dec 2025 15:39:56 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <david.marchand@redhat.com>,
 <fengchengwen@huawei.com>, <lihuisong@huawei.com>, <liuyonglong@huawei.com>,
 <kangfenglong@huawei.com>
Subject: [PATCH] net/hns3: fix outer UDP checksum fail with simple BD
Date: Fri, 5 Dec 2025 15:39:55 +0800
Message-ID: <20251205073955.3225775-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.90.31.46]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

From: Chengwen Feng <fengchengwen@huawei.com>

On the hardware platform that supports simple BD, if outer-ip, outer-udp
and udp checksum offloading are enabled, the hardware incorrectly
processes the ether+ipv6+vxlan+ether+ipv4+udp packet (the incorrect
field is modified).

The root cause is that the simple BD feature does not exclude outer-udp
checksum. This commit add it.

Fixes: 6393fc0b823c ("net/hns3: simplify hardware checksum offloading")
Cc: stable@dpdk.org

Signed-off-by: Chengwen Feng <fengchengwen@huawei.com>
Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
 drivers/net/hns3/hns3_rxtx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/hns3/hns3_rxtx.c b/drivers/net/hns3/hns3_rxtx.c
index 3a99923220..573604b0cd 100644
--- a/drivers/net/hns3/hns3_rxtx.c
+++ b/drivers/net/hns3/hns3_rxtx.c
@@ -3999,8 +3999,9 @@ hns3_handle_simple_bd(struct hns3_tx_queue *txq, struct hns3_desc *desc,
 	if (txq->simple_bd_enable && !(m->ol_flags & RTE_MBUF_F_TX_IP_CKSUM) &&
 	    !(m->ol_flags & RTE_MBUF_F_TX_TCP_SEG) &&
 	    !(m->ol_flags & RTE_MBUF_F_TX_OUTER_IP_CKSUM) &&
+	    !(m->ol_flags & RTE_MBUF_F_TX_OUTER_UDP_CKSUM) &&
 	    ((m->ol_flags & RTE_MBUF_F_TX_L4_MASK) == RTE_MBUF_F_TX_TCP_CKSUM ||
-	    (m->ol_flags & RTE_MBUF_F_TX_L4_MASK) == RTE_MBUF_F_TX_UDP_CKSUM)) {
+	     (m->ol_flags & RTE_MBUF_F_TX_L4_MASK) == RTE_MBUF_F_TX_UDP_CKSUM)) {
 		/* set checksum start and offset, defined in 2 Bytes */
 		hns3_set_field(desc->tx.type_cs_vlan_tso_len,
 			       HNS3_TXD_L4_START_M, HNS3_TXD_L4_START_S,
-- 
2.33.0

