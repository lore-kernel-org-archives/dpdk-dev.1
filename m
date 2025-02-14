Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 804CAC021A4
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 02:09:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 906BB402E7;
	Fri, 14 Feb 2025 03:09:02 +0100 (CET)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
 by mails.dpdk.org (Postfix) with ESMTP id CF6A74028E
 for <dev@dpdk.org>; Fri, 14 Feb 2025 03:08:59 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.162.254])
 by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4YvFlH141fzRmZG;
 Fri, 14 Feb 2025 10:06:03 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
 by mail.maildlp.com (Postfix) with ESMTPS id EBF1A180101;
 Fri, 14 Feb 2025 10:08:57 +0800 (CST)
Received: from localhost.localdomain (10.28.79.22) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Feb 2025 10:08:57 +0800
From: Jie Hai <haijie1@huawei.com>
To: <dev@dpdk.org>, <thomas@monjalon.net>, <ferruh.yigit@amd.com>,
 <aman.deep.singh@intel.com>
CC: <lihuisong@huawei.com>, <fengchengwen@huawei.com>, <haijie1@huawei.com>,
 <huangdengdui@huawei.com>
Subject: [PATCH v3 1/2] net: add ptype parse for tunnel packets
Date: Fri, 14 Feb 2025 09:56:37 +0800
Message-ID: <20250214015638.29983-2-haijie1@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20250214015638.29983-1-haijie1@huawei.com>
References: <20250108024632.12152-1-haijie1@huawei.com>
 <20250214015638.29983-1-haijie1@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.28.79.22]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
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

Add packet types parse for vxlan/vxlan-gpe/gtp/geneve packets.

Signed-off-by: Jie Hai <haijie1@huawei.com>
---
 lib/net/rte_net.c | 110 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 102 insertions(+), 8 deletions(-)

diff --git a/lib/net/rte_net.c b/lib/net/rte_net.c
index d680accc1631..45b63eafc7c6 100644
--- a/lib/net/rte_net.c
+++ b/lib/net/rte_net.c
@@ -14,6 +14,9 @@
 #include <rte_sctp.h>
 #include <rte_gre.h>
 #include <rte_mpls.h>
+#include <rte_geneve.h>
+#include <rte_vxlan.h>
+#include <rte_gtp.h>
 #include <rte_net.h>
 #include <rte_os_shim.h>
 
@@ -126,7 +129,7 @@ ptype_inner_l4(uint8_t proto)
 
 /* get the tunnel packet type if any, update proto and off. */
 static uint32_t
-ptype_tunnel(uint16_t *proto, const struct rte_mbuf *m,
+ptype_tunnel_without_udp(uint16_t *proto, const struct rte_mbuf *m,
 	uint32_t *off)
 {
 	switch (*proto) {
@@ -172,6 +175,92 @@ ptype_tunnel(uint16_t *proto, const struct rte_mbuf *m,
 	}
 }
 
+
+/* get the tunnel packet type with udp port if any, update proto and off. */
+static uint32_t
+ptype_tunnel_with_udp(uint16_t *proto, const struct rte_mbuf *m,
+			uint32_t *off, struct rte_net_hdr_lens *hdr_lens)
+{
+	const struct rte_udp_hdr *uh;
+	struct rte_udp_hdr uh_copy;
+	uint16_t port_no;
+
+	uh = rte_pktmbuf_read(m, *off, sizeof(*uh), &uh_copy);
+	if (unlikely(uh == NULL))
+		return 0;
+
+	*off += sizeof(*uh);
+	if (rte_be_to_cpu_16(uh->src_port) == RTE_GTPC_UDP_PORT)
+		port_no = rte_be_to_cpu_16(uh->src_port);
+	else
+		port_no = rte_be_to_cpu_16(uh->dst_port);
+	switch (port_no) {
+	case RTE_VXLAN_DEFAULT_PORT: {
+		*off += sizeof(struct rte_vxlan_hdr);
+		hdr_lens->inner_l2_len = RTE_ETHER_VXLAN_HLEN;
+		*proto = RTE_VXLAN_GPE_TYPE_ETH; /* just for eth header parse. */
+		return RTE_PTYPE_TUNNEL_VXLAN;
+	}
+	case RTE_VXLAN_GPE_DEFAULT_PORT: {
+		const struct rte_vxlan_gpe_hdr *vgh;
+		struct rte_vxlan_gpe_hdr vgh_copy;
+		vgh = rte_pktmbuf_read(m, *off, sizeof(*vgh), &vgh_copy);
+		if (unlikely(vgh == NULL))
+			return 0;
+		*off += sizeof(struct rte_vxlan_gpe_hdr);
+		hdr_lens->inner_l2_len = RTE_ETHER_VXLAN_GPE_HLEN;
+		*proto = vgh->proto;
+
+		return RTE_PTYPE_TUNNEL_VXLAN_GPE;
+	}
+	case RTE_GTPC_UDP_PORT:
+	case RTE_GTPU_UDP_PORT: {
+		const struct rte_gtp_hdr *gh;
+		struct rte_gtp_hdr gh_copy;
+		uint8_t gtp_len;
+		uint8_t ip_ver;
+		gh = rte_pktmbuf_read(m, *off, sizeof(*gh), &gh_copy);
+		if (unlikely(gh == NULL))
+			return 0;
+		gtp_len = sizeof(*gh);
+		if (gh->e || gh->s || gh->pn)
+			gtp_len += sizeof(struct rte_gtp_hdr_ext_word);
+		/*
+		 * Check message type. If message type is 0xff, it is
+		 * a GTP data packet. If not, it is a GTP control packet
+		 */
+		if (gh->msg_type == 0xff) {
+			ip_ver = *(const uint8_t *)((const char *)gh + gtp_len);
+			*proto = (ip_ver) & 0xf0;
+		} else {
+			*proto = 0;
+		}
+		*off += gtp_len;
+		hdr_lens->inner_l2_len = gtp_len + sizeof(struct rte_udp_hdr);
+		if (port_no == RTE_GTPC_UDP_PORT)
+			return RTE_PTYPE_TUNNEL_GTPC;
+		else if (port_no == RTE_GTPU_UDP_PORT)
+			return RTE_PTYPE_TUNNEL_GTPU;
+		return 0;
+	}
+	case RTE_GENEVE_DEFAULT_PORT: {
+		const struct rte_geneve_hdr *gnh;
+		struct rte_geneve_hdr gnh_copy;
+		uint16_t geneve_len;
+		gnh = rte_pktmbuf_read(m, *off, sizeof(*gnh), &gnh_copy);
+		if (unlikely(gnh == NULL))
+			return 0;
+		geneve_len = sizeof(*gnh) + gnh->opt_len * 4;
+		*off = geneve_len;
+		*proto = gnh->proto;
+		if (gnh->proto == 0)
+			*proto = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
+		return RTE_PTYPE_TUNNEL_GENEVE;
+	}
+	default:
+		return 0;
+	}
+}
 /* parse ipv6 extended headers, update offset and return next proto */
 int
 rte_net_skip_ip6_ext(uint16_t proto, const struct rte_mbuf *m, uint32_t *off,
@@ -352,7 +441,9 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
 
 	if ((pkt_type & RTE_PTYPE_L4_MASK) == RTE_PTYPE_L4_UDP) {
 		hdr_lens->l4_len = sizeof(struct rte_udp_hdr);
-		return pkt_type;
+		if ((layers & RTE_PTYPE_TUNNEL_MASK) == 0)
+			return pkt_type;
+		pkt_type |= ptype_tunnel_with_udp(&proto, m, &off, hdr_lens);
 	} else if ((pkt_type & RTE_PTYPE_L4_MASK) == RTE_PTYPE_L4_TCP) {
 		const struct rte_tcp_hdr *th;
 		struct rte_tcp_hdr th_copy;
@@ -374,7 +465,7 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
 		if ((layers & RTE_PTYPE_TUNNEL_MASK) == 0)
 			return pkt_type;
 
-		pkt_type |= ptype_tunnel(&proto, m, &off);
+		pkt_type |= ptype_tunnel_without_udp(&proto, m, &off);
 		hdr_lens->tunnel_len = off - prev_off;
 	}
 
@@ -384,15 +475,16 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
 	if ((layers & RTE_PTYPE_INNER_L2_MASK) == 0)
 		return pkt_type;
 
-	hdr_lens->inner_l2_len = 0;
-	if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_TEB)) {
+	if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_TEB) ||
+		proto == rte_cpu_to_be_16(RTE_GENEVE_TYPE_ETH) ||
+		proto == RTE_VXLAN_GPE_TYPE_ETH) {
 		eh = rte_pktmbuf_read(m, off, sizeof(*eh), &eh_copy);
 		if (unlikely(eh == NULL))
 			return pkt_type;
 		pkt_type |= RTE_PTYPE_INNER_L2_ETHER;
 		proto = eh->ether_type;
 		off += sizeof(*eh);
-		hdr_lens->inner_l2_len = sizeof(*eh);
+		hdr_lens->inner_l2_len += sizeof(*eh);
 	}
 
 	if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_VLAN)) {
@@ -425,7 +517,8 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
 	if ((layers & RTE_PTYPE_INNER_L3_MASK) == 0)
 		return pkt_type;
 
-	if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4)) {
+	if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4) ||
+		proto == RTE_VXLAN_GPE_TYPE_IPV4) {
 		const struct rte_ipv4_hdr *ip4h;
 		struct rte_ipv4_hdr ip4h_copy;
 
@@ -448,7 +541,8 @@ uint32_t rte_net_get_ptype(const struct rte_mbuf *m,
 		}
 		proto = ip4h->next_proto_id;
 		pkt_type |= ptype_inner_l4(proto);
-	} else if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV6)) {
+	} else if (proto == rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV6) ||
+			proto == RTE_VXLAN_GPE_TYPE_IPV6) {
 		const struct rte_ipv6_hdr *ip6h;
 		struct rte_ipv6_hdr ip6h_copy;
 		int frag = 0;
-- 
2.22.0

