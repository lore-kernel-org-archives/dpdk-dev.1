Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16BA2C83030
	for <dpdk-dev@archiver.kernel.org>; Thu,  3 Jul 2025 09:30:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EC76B402A3;
	Thu,  3 Jul 2025 11:30:32 +0200 (CEST)
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
 by mails.dpdk.org (Postfix) with ESMTP id BCA51402A3
 for <dev@dpdk.org>; Thu,  3 Jul 2025 11:30:30 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.162.112])
 by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4bXs311b5zz2TS5q;
 Thu,  3 Jul 2025 17:31:25 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id 987801401F3;
 Thu,  3 Jul 2025 17:30:28 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 3 Jul 2025 17:30:28 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <jasvinder.singh@intel.com>,
 <thomas@monjalon.net>, <aman.deep.singh@intel.com>, <lihuisong@huawei.com>,
 <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH] net: support VLAN stacking packet type parsing
Date: Thu, 3 Jul 2025 17:30:27 +0800
Message-ID: <20250703093027.1259459-1-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.165.33]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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

The current rte_net_get_ptype() only supports parsing packets with
one 0x8100 VLAN tag or two 0x88a8 VLAN tags. This patch extends it
to support parsing packets with two 0x8100 VLAN tags.

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 lib/net/rte_net.c | 34 ++++++++++++++++++++++------------
 lib/net/rte_net.h |  2 ++
 2 files changed, 24 insertions(+), 12 deletions(-)

diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index 44fb6c0f51..fa8d023ca7 100644
--- a/lib/net/rte_net.c
+++ b/lib/net/rte_net.c
@@ -352,14 +352,19 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
 	if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN)) {
 		const struct rte_vlan_hdr *vh;
 		struct rte_vlan_hdr vh_copy;
+		uint8_t vlan_num = 1;
 
 		pkt_type = RTE_PTYPE_L2_ETHER_VLAN;
-		vh = rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
-		if (unlikely(vh == NULL))
-			return pkt_type;
-		off += sizeof(*vh);
-		hdr_lens->l2_len += sizeof(*vh);
-		proto = vh->eth_proto;
+		while (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) &&
+		       vlan_num <= MAX_VLAN_STACKING_TAGS) {
+			vh = rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
+			if (unlikely(vh == NULL))
+				return pkt_type;
+			off += sizeof(*vh);
+			hdr_lens->l2_len += sizeof(*vh);
+			proto = vh->eth_proto;
+			vlan_num++;
+		}
 	} else if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
 		const struct rte_vlan_hdr *vh;
 		struct rte_vlan_hdr vh_copy;
@@ -504,15 +509,20 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
 	if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN)) {
 		const struct rte_vlan_hdr *vh;
 		struct rte_vlan_hdr vh_copy;
+		uint8_t vlan_num = 1;
 
 		pkt_type &= ~RTE_PTYPE_INNER_L2_MASK;
 		pkt_type |= RTE_PTYPE_INNER_L2_ETHER_VLAN;
-		vh = rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
-		if (unlikely(vh == NULL))
-			return pkt_type;
-		off += sizeof(*vh);
-		hdr_lens->inner_l2_len += sizeof(*vh);
-		proto = vh->eth_proto;
+		while (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN) &&
+		       vlan_num <= MAX_VLAN_STACKING_TAGS) {
+			vh = rte_pktmbuf_read(m, off, sizeof(*vh), &vh_copy);
+			if (unlikely(vh == NULL))
+				return pkt_type;
+			off += sizeof(*vh);
+			hdr_lens->inner_l2_len += sizeof(*vh);
+			proto = vh->eth_proto;
+			vlan_num++;
+		}
 	} else if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_QINQ)) {
 		const struct rte_vlan_hdr *vh;
 		struct rte_vlan_hdr vh_copy;
diff --git a/lib/net/rte_net.h b/lib/net/rte_net.h
index 65d724b84b..fdd55d57c8 100644
--- a/lib/net/rte_net.h
+++ b/lib/net/rte_net.h
@@ -13,6 +13,8 @@
 extern "C" {
 #endif
 
+#define MAX_VLAN_STACKING_TAGS	2
+
 /**
  * Structure containing header lengths associated to a packet, filled
  * by rte_net_get_ptype().
-- 
2.33.0

