Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E2D0C71135
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Jun 2025 08:27:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7C45040A87;
	Mon, 16 Jun 2025 10:27:08 +0200 (CEST)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
 by mails.dpdk.org (Postfix) with ESMTP id AF9E440615
 for <dev@dpdk.org>; Mon, 16 Jun 2025 10:27:05 +0200 (CEST)
Received: from mail.maildlp.com (unknown [172.19.88.234])
 by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4bLNNx39pzz1g2mX;
 Mon, 16 Jun 2025 16:25:37 +0800 (CST)
Received: from kwepemo500011.china.huawei.com (unknown [7.202.195.194])
 by mail.maildlp.com (Postfix) with ESMTPS id BEAA31400D2;
 Mon, 16 Jun 2025 16:27:03 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemo500011.china.huawei.com (7.202.195.194) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 16 Jun 2025 16:27:03 +0800
From: Dengdui Huang <huangdengdui@huawei.com>
To: <dev@dpdk.org>
CC: <thomas@monjalon.net>, <jasvinder.singh@intel.com>,
 <stephen@networkplumber.org>, <aman.deep.singh@intel.com>,
 <lihuisong@huawei.com>, <fengchengwen@huawei.com>, <liuyonglong@huawei.com>
Subject: [PATCH 1/2] net: fix parse the tunnel length of tunnel with UDP
Date: Mon, 16 Jun 2025 16:27:01 +0800
Message-ID: <20250616082702.3422034-2-huangdengdui@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20250616082702.3422034-1-huangdengdui@huawei.com>
References: <20250616082702.3422034-1-huangdengdui@huawei.com>
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

Currently, the tunnel length info is not available when
get the tunnel packet type with UDP port. This patch
adds the parsing of the tunnel length info.

Additionally, adding comments for the inner_l2_len field
and the tunnel_len field would help in understanding their.

Fixes: 64ed7f854cf4 ("net: add tunnel packet type parsing")
Cc: stable@dpdk.org

Signed-off-by: Dengdui Huang <huangdengdui@huawei.com>
---
 lib/net/rte_net.c | 4 ++++
 lib/net/rte_net.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index 098999e71e..44fb6c0f51 100644
--- a/lib/net/rte_net.c
+++ b/lib/net/rte_net.c
@@ -197,6 +197,7 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
 	switch (port_no) {
 	case RTE_VXLAN_DEFAULT_PORT: {
 		*off += sizeof(struct rte_vxlan_hdr);
+		hdr_lens->tunnel_len = sizeof(struct rte_vxlan_hdr);
 		hdr_lens->inner_l2_len = RTE_ETHER_VXLAN_HLEN;
 		*proto = RTE_VXLAN_GPE_TYPE_ETH; /* just for eth header parse. */
 		return RTE_PTYPE_TUNNEL_VXLAN;
@@ -208,6 +209,7 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
 		if (unlikely(vgh == NULL))
 			return 0;
 		*off += sizeof(struct rte_vxlan_gpe_hdr);
+		hdr_lens->tunnel_len = sizeof(struct rte_vxlan_gpe_hdr);
 		hdr_lens->inner_l2_len = RTE_ETHER_VXLAN_GPE_HLEN;
 		*proto = vgh->proto;
 
@@ -243,6 +245,7 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
 		}
 		*off += gtp_len;
 		hdr_lens->inner_l2_len = gtp_len + sizeof(struct rte_udp_hdr);
+		hdr_lens->tunnel_len = gtp_len;
 		if (port_no == RTE_GTPC_UDP_PORT)
 			return RTE_PTYPE_TUNNEL_GTPC;
 		else if (port_no == RTE_GTPU_UDP_PORT)
@@ -258,6 +261,7 @@ ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
 			return 0;
 		geneve_len = sizeof(*gnh) + gnh->opt_len * 4;
 		*off += geneve_len;
+		hdr_lens->tunnel_len = geneve_len;
 		hdr_lens->inner_l2_len = sizeof(struct rte_udp_hdr) + geneve_len;
 		*proto = gnh->proto;
 		if (gnh->proto == 0)
diff --git a/lib/net/rte_net.h b/lib/net/rte_net.h
index 40ad6a71a1..65d724b84b 100644
--- a/lib/net/rte_net.h
+++ b/lib/net/rte_net.h
@@ -19,9 +19,11 @@ extern "C" {
  */
 struct rte_net_hdr_lens {
 	uint8_t l2_len;
+	/* Outer_L4_len + ... + inner L2_len for tunneling pkt. */
 	uint8_t inner_l2_len;
 	uint16_t l3_len;
 	uint16_t inner_l3_len;
+	/* Protocol header of tunnel packets */
 	uint16_t tunnel_len;
 	uint8_t l4_len;
 	uint8_t inner_l4_len;
-- 
2.33.0

