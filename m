Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ED8C021A4
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Feb 2025 02:09:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27ED740651;
	Fri, 14 Feb 2025 03:09:05 +0100 (CET)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
 by mails.dpdk.org (Postfix) with ESMTP id 1C2EA402B9
 for <dev@dpdk.org>; Fri, 14 Feb 2025 03:09:00 +0100 (CET)
Received: from mail.maildlp.com (unknown [172.19.163.17])
 by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4YvFkG4vJrz1ltYJ;
 Fri, 14 Feb 2025 10:05:10 +0800 (CST)
Received: from kwepemf500004.china.huawei.com (unknown [7.202.181.242])
 by mail.maildlp.com (Postfix) with ESMTPS id 724621A0188;
 Fri, 14 Feb 2025 10:08:58 +0800 (CST)
Received: from localhost.localdomain (10.28.79.22) by
 kwepemf500004.china.huawei.com (7.202.181.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 14 Feb 2025 10:08:57 +0800
From: Jie Hai <haijie1@huawei.com>
To: <dev@dpdk.org>, <thomas@monjalon.net>, <ferruh.yigit@amd.com>,
 <aman.deep.singh@intel.com>
CC: <lihuisong@huawei.com>, <fengchengwen@huawei.com>, <haijie1@huawei.com>,
 <huangdengdui@huawei.com>
Subject: [PATCH v3 2/2] app/test-pmd: use ptype API parse packets
Date: Fri, 14 Feb 2025 09:56:38 +0800
Message-ID: <20250214015638.29983-3-haijie1@huawei.com>
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

1. Use rte_net_get_ptype() to parse packets instead.
2. Support TSO for packets with ipv6 extension header.

Signed-off-by: Jie Hai <haijie1@huawei.com>
---
 app/test-pmd/csumonly.c | 522 ++++++++++------------------------------
 1 file changed, 128 insertions(+), 394 deletions(-)

diff --git a/app/test-pmd/csumonly.c b/app/test-pmd/csumonly.c
index d77a140641f3..5b906eaa5318 100644
--- a/app/test-pmd/csumonly.c
+++ b/app/test-pmd/csumonly.c
@@ -46,6 +46,7 @@
 #include <rte_gso.h>
 #endif
 #include <rte_geneve.h>
+#include <rte_net.h>
 
 #include "testpmd.h"
 
@@ -104,88 +105,6 @@ get_udptcp_checksum(struct rte_mbuf *m, void *l3_hdr, uint16_t l4_off,
 		return rte_ipv6_udptcp_cksum_mbuf(m, l3_hdr, l4_off);
 }
 
-/* Parse an IPv4 header to fill l3_len, l4_len, and l4_proto */
-static void
-parse_ipv4(struct rte_ipv4_hdr *ipv4_hdr, struct testpmd_offload_info *info)
-{
-	struct rte_tcp_hdr *tcp_hdr;
-
-	info->l3_len = rte_ipv4_hdr_len(ipv4_hdr);
-	info->l4_proto = ipv4_hdr->next_proto_id;
-
-	/* only fill l4_len for TCP, it's useful for TSO */
-	if (info->l4_proto == IPPROTO_TCP) {
-		tcp_hdr = (struct rte_tcp_hdr *)
-			((char *)ipv4_hdr + info->l3_len);
-		info->l4_len = (tcp_hdr->data_off & 0xf0) >> 2;
-	} else if (info->l4_proto == IPPROTO_UDP)
-		info->l4_len = sizeof(struct rte_udp_hdr);
-	else
-		info->l4_len = 0;
-}
-
-/* Parse an IPv6 header to fill l3_len, l4_len, and l4_proto */
-static void
-parse_ipv6(struct rte_ipv6_hdr *ipv6_hdr, struct testpmd_offload_info *info)
-{
-	struct rte_tcp_hdr *tcp_hdr;
-
-	info->l3_len = sizeof(struct rte_ipv6_hdr);
-	info->l4_proto = ipv6_hdr->proto;
-
-	/* only fill l4_len for TCP, it's useful for TSO */
-	if (info->l4_proto == IPPROTO_TCP) {
-		tcp_hdr = (struct rte_tcp_hdr *)
-			((char *)ipv6_hdr + info->l3_len);
-		info->l4_len = (tcp_hdr->data_off & 0xf0) >> 2;
-	} else if (info->l4_proto == IPPROTO_UDP)
-		info->l4_len = sizeof(struct rte_udp_hdr);
-	else
-		info->l4_len = 0;
-}
-
-/*
- * Parse an ethernet header to fill the ethertype, l2_len, l3_len and
- * ipproto. This function is able to recognize IPv4/IPv6 with optional VLAN
- * headers. The l4_len argument is only set in case of TCP (useful for TSO).
- */
-static void
-parse_ethernet(struct rte_ether_hdr *eth_hdr, struct testpmd_offload_info *info)
-{
-	struct rte_ipv4_hdr *ipv4_hdr;
-	struct rte_ipv6_hdr *ipv6_hdr;
-	struct rte_vlan_hdr *vlan_hdr;
-
-	info->l2_len = sizeof(struct rte_ether_hdr);
-	info->ethertype = eth_hdr->ether_type;
-
-	while (info->ethertype == _htons(RTE_ETHER_TYPE_VLAN) ||
-	       info->ethertype == _htons(RTE_ETHER_TYPE_QINQ)) {
-		vlan_hdr = (struct rte_vlan_hdr *)
-			((char *)eth_hdr + info->l2_len);
-		info->l2_len  += sizeof(struct rte_vlan_hdr);
-		info->ethertype = vlan_hdr->eth_proto;
-	}
-
-	switch (info->ethertype) {
-	case _htons(RTE_ETHER_TYPE_IPV4):
-		ipv4_hdr = (struct rte_ipv4_hdr *)
-			((char *)eth_hdr + info->l2_len);
-		parse_ipv4(ipv4_hdr, info);
-		break;
-	case _htons(RTE_ETHER_TYPE_IPV6):
-		ipv6_hdr = (struct rte_ipv6_hdr *)
-			((char *)eth_hdr + info->l2_len);
-		parse_ipv6(ipv6_hdr, info);
-		break;
-	default:
-		info->l4_len = 0;
-		info->l3_len = 0;
-		info->l4_proto = 0;
-		break;
-	}
-}
-
 /* Fill in outer layers length */
 static void
 update_tunnel_outer(struct testpmd_offload_info *info)
@@ -195,262 +114,7 @@ update_tunnel_outer(struct testpmd_offload_info *info)
 	info->outer_l2_len = info->l2_len;
 	info->outer_l3_len = info->l3_len;
 	info->outer_l4_proto = info->l4_proto;
-}
-
-/*
- * Parse a GTP protocol header.
- * No optional fields and next extension header type.
- */
-static void
-parse_gtp(struct rte_udp_hdr *udp_hdr,
-	  struct testpmd_offload_info *info)
-{
-	struct rte_ipv4_hdr *ipv4_hdr;
-	struct rte_ipv6_hdr *ipv6_hdr;
-	struct rte_gtp_hdr *gtp_hdr;
-	uint8_t gtp_len = sizeof(*gtp_hdr);
-	uint8_t ip_ver;
-
-	/* Check udp destination port. */
-	if (udp_hdr->dst_port != _htons(RTE_GTPC_UDP_PORT) &&
-	    udp_hdr->src_port != _htons(RTE_GTPC_UDP_PORT) &&
-	    udp_hdr->dst_port != _htons(RTE_GTPU_UDP_PORT))
-		return;
-
-	update_tunnel_outer(info);
-	info->l2_len = 0;
-
-	gtp_hdr = (struct rte_gtp_hdr *)((char *)udp_hdr +
-		  sizeof(struct rte_udp_hdr));
-	if (gtp_hdr->e || gtp_hdr->s || gtp_hdr->pn)
-		gtp_len += sizeof(struct rte_gtp_hdr_ext_word);
-	/*
-	 * Check message type. If message type is 0xff, it is
-	 * a GTP data packet. If not, it is a GTP control packet
-	 */
-	if (gtp_hdr->msg_type == 0xff) {
-		ip_ver = *(uint8_t *)((char *)gtp_hdr + gtp_len);
-		ip_ver = (ip_ver) & 0xf0;
-
-		if (ip_ver == RTE_GTP_TYPE_IPV4) {
-			ipv4_hdr = (struct rte_ipv4_hdr *)((char *)gtp_hdr +
-				   gtp_len);
-			info->ethertype = _htons(RTE_ETHER_TYPE_IPV4);
-			parse_ipv4(ipv4_hdr, info);
-		} else if (ip_ver == RTE_GTP_TYPE_IPV6) {
-			ipv6_hdr = (struct rte_ipv6_hdr *)((char *)gtp_hdr +
-				   gtp_len);
-			info->ethertype = _htons(RTE_ETHER_TYPE_IPV6);
-			parse_ipv6(ipv6_hdr, info);
-		}
-	} else {
-		info->ethertype = 0;
-		info->l4_len = 0;
-		info->l3_len = 0;
-		info->l4_proto = 0;
-	}
-
-	info->l2_len += gtp_len + sizeof(*udp_hdr);
-}
-
-/* Parse a vxlan header */
-static void
-parse_vxlan(struct rte_udp_hdr *udp_hdr,
-	    struct testpmd_offload_info *info)
-{
-	struct rte_ether_hdr *eth_hdr;
-
-	/* check udp destination port, RTE_VXLAN_DEFAULT_PORT (4789) is the
-	 * default vxlan port (rfc7348) or that the rx offload flag is set
-	 * (i40e only currently)
-	 */
-	if (udp_hdr->dst_port != _htons(RTE_VXLAN_DEFAULT_PORT))
-		return;
-
-	update_tunnel_outer(info);
-
-	eth_hdr = (struct rte_ether_hdr *)((char *)udp_hdr +
-		sizeof(struct rte_udp_hdr) +
-		sizeof(struct rte_vxlan_hdr));
-
-	parse_ethernet(eth_hdr, info);
-	info->l2_len += RTE_ETHER_VXLAN_HLEN; /* add udp + vxlan */
-}
-
-/* Parse a vxlan-gpe header */
-static void
-parse_vxlan_gpe(struct rte_udp_hdr *udp_hdr,
-	    struct testpmd_offload_info *info)
-{
-	struct rte_ether_hdr *eth_hdr;
-	struct rte_ipv4_hdr *ipv4_hdr;
-	struct rte_ipv6_hdr *ipv6_hdr;
-	struct rte_vxlan_gpe_hdr *vxlan_gpe_hdr;
-	uint8_t vxlan_gpe_len = sizeof(*vxlan_gpe_hdr);
-
-	/* Check udp destination port. */
-	if (udp_hdr->dst_port != _htons(vxlan_gpe_udp_port))
-		return;
-
-	vxlan_gpe_hdr = (struct rte_vxlan_gpe_hdr *)((char *)udp_hdr +
-				sizeof(struct rte_udp_hdr));
-
-	if (!vxlan_gpe_hdr->proto || vxlan_gpe_hdr->proto ==
-	    RTE_VXLAN_GPE_TYPE_IPV4) {
-		update_tunnel_outer(info);
-
-		ipv4_hdr = (struct rte_ipv4_hdr *)((char *)vxlan_gpe_hdr +
-			   vxlan_gpe_len);
-
-		parse_ipv4(ipv4_hdr, info);
-		info->ethertype = _htons(RTE_ETHER_TYPE_IPV4);
-		info->l2_len = 0;
-
-	} else if (vxlan_gpe_hdr->proto == RTE_VXLAN_GPE_TYPE_IPV6) {
-		update_tunnel_outer(info);
-
-		ipv6_hdr = (struct rte_ipv6_hdr *)((char *)vxlan_gpe_hdr +
-			   vxlan_gpe_len);
-
-		info->ethertype = _htons(RTE_ETHER_TYPE_IPV6);
-		parse_ipv6(ipv6_hdr, info);
-		info->l2_len = 0;
-
-	} else if (vxlan_gpe_hdr->proto == RTE_VXLAN_GPE_TYPE_ETH) {
-		update_tunnel_outer(info);
-
-		eth_hdr = (struct rte_ether_hdr *)((char *)vxlan_gpe_hdr +
-			  vxlan_gpe_len);
-
-		parse_ethernet(eth_hdr, info);
-	} else
-		return;
-
-	info->l2_len += RTE_ETHER_VXLAN_GPE_HLEN;
-}
-
-/* Parse a geneve header */
-static void
-parse_geneve(struct rte_udp_hdr *udp_hdr,
-	    struct testpmd_offload_info *info)
-{
-	struct rte_ether_hdr *eth_hdr;
-	struct rte_ipv4_hdr *ipv4_hdr;
-	struct rte_ipv6_hdr *ipv6_hdr;
-	struct rte_geneve_hdr *geneve_hdr;
-	uint16_t geneve_len;
-
-	/* Check udp destination port. */
-	if (udp_hdr->dst_port != _htons(geneve_udp_port))
-		return;
-
-	geneve_hdr = (struct rte_geneve_hdr *)((char *)udp_hdr +
-				sizeof(struct rte_udp_hdr));
-	geneve_len = sizeof(struct rte_geneve_hdr) + geneve_hdr->opt_len * 4;
-	if (!geneve_hdr->proto || geneve_hdr->proto ==
-	    _htons(RTE_ETHER_TYPE_IPV4)) {
-		update_tunnel_outer(info);
-		ipv4_hdr = (struct rte_ipv4_hdr *)((char *)geneve_hdr +
-			   geneve_len);
-		parse_ipv4(ipv4_hdr, info);
-		info->ethertype = _htons(RTE_ETHER_TYPE_IPV4);
-		info->l2_len = 0;
-	} else if (geneve_hdr->proto == _htons(RTE_ETHER_TYPE_IPV6)) {
-		update_tunnel_outer(info);
-		ipv6_hdr = (struct rte_ipv6_hdr *)((char *)geneve_hdr +
-			   geneve_len);
-		info->ethertype = _htons(RTE_ETHER_TYPE_IPV6);
-		parse_ipv6(ipv6_hdr, info);
-		info->l2_len = 0;
-
-	} else if (geneve_hdr->proto == _htons(RTE_GENEVE_TYPE_ETH)) {
-		update_tunnel_outer(info);
-		eth_hdr = (struct rte_ether_hdr *)((char *)geneve_hdr +
-			  geneve_len);
-		parse_ethernet(eth_hdr, info);
-	} else
-		return;
-
-	info->l2_len +=
-		(sizeof(struct rte_udp_hdr) + sizeof(struct rte_geneve_hdr) +
-		((struct rte_geneve_hdr *)geneve_hdr)->opt_len * 4);
-}
-
-/* Parse a gre header */
-static void
-parse_gre(struct simple_gre_hdr *gre_hdr, struct testpmd_offload_info *info)
-{
-	struct rte_ether_hdr *eth_hdr;
-	struct rte_ipv4_hdr *ipv4_hdr;
-	struct rte_ipv6_hdr *ipv6_hdr;
-	uint8_t gre_len = 0;
-
-	gre_len += sizeof(struct simple_gre_hdr);
-
-	if (gre_hdr->flags & _htons(GRE_KEY_PRESENT))
-		gre_len += GRE_EXT_LEN;
-	if (gre_hdr->flags & _htons(GRE_SEQUENCE_PRESENT))
-		gre_len += GRE_EXT_LEN;
-	if (gre_hdr->flags & _htons(GRE_CHECKSUM_PRESENT))
-		gre_len += GRE_EXT_LEN;
-
-	if (gre_hdr->proto == _htons(RTE_ETHER_TYPE_IPV4)) {
-		update_tunnel_outer(info);
-
-		ipv4_hdr = (struct rte_ipv4_hdr *)((char *)gre_hdr + gre_len);
-
-		parse_ipv4(ipv4_hdr, info);
-		info->ethertype = _htons(RTE_ETHER_TYPE_IPV4);
-		info->l2_len = 0;
-
-	} else if (gre_hdr->proto == _htons(RTE_ETHER_TYPE_IPV6)) {
-		update_tunnel_outer(info);
-
-		ipv6_hdr = (struct rte_ipv6_hdr *)((char *)gre_hdr + gre_len);
-
-		info->ethertype = _htons(RTE_ETHER_TYPE_IPV6);
-		parse_ipv6(ipv6_hdr, info);
-		info->l2_len = 0;
-
-	} else if (gre_hdr->proto == _htons(RTE_ETHER_TYPE_TEB)) {
-		update_tunnel_outer(info);
-
-		eth_hdr = (struct rte_ether_hdr *)((char *)gre_hdr + gre_len);
-
-		parse_ethernet(eth_hdr, info);
-	} else
-		return;
-
-	info->l2_len += gre_len;
-}
-
-
-/* Parse an encapsulated ip or ipv6 header */
-static void
-parse_encap_ip(void *encap_ip, struct testpmd_offload_info *info)
-{
-	struct rte_ipv4_hdr *ipv4_hdr = encap_ip;
-	struct rte_ipv6_hdr *ipv6_hdr = encap_ip;
-	uint8_t ip_version;
-
-	ip_version = (ipv4_hdr->version_ihl & 0xf0) >> 4;
-
-	if (ip_version != 4 && ip_version != 6)
-		return;
-
-	info->is_tunnel = 1;
-	info->outer_ethertype = info->ethertype;
-	info->outer_l2_len = info->l2_len;
-	info->outer_l3_len = info->l3_len;
-
-	if (ip_version == 4) {
-		parse_ipv4(ipv4_hdr, info);
-		info->ethertype = _htons(RTE_ETHER_TYPE_IPV4);
-	} else {
-		parse_ipv6(ipv6_hdr, info);
-		info->ethertype = _htons(RTE_ETHER_TYPE_IPV6);
-	}
-	info->l2_len = 0;
+	info->l4_proto = 0;
 }
 
 /* if possible, calculate the checksum of a packet in hw or sw,
@@ -799,6 +463,109 @@ pkts_ip_csum_recalc(struct rte_mbuf **pkts_burst, const uint16_t nb_pkts, uint64
 }
 #endif
 
+static uint32_t
+get_ethertype_by_ptype(struct rte_ether_hdr *eth_hdr, uint32_t ptype)
+{
+	struct rte_vlan_hdr *vlan_hdr;
+	uint16_t ethertype;
+
+	switch (ptype) {
+	case RTE_PTYPE_L3_IPV4:
+	case RTE_PTYPE_L3_IPV4_EXT:
+	case RTE_PTYPE_L3_IPV4_EXT_UNKNOWN:
+	case RTE_PTYPE_INNER_L3_IPV4:
+	case RTE_PTYPE_INNER_L3_IPV4_EXT:
+	case RTE_PTYPE_INNER_L3_IPV4_EXT_UNKNOWN:
+		return _htons(RTE_ETHER_TYPE_IPV4);
+	case RTE_PTYPE_L3_IPV6:
+	case RTE_PTYPE_L3_IPV6_EXT:
+	case RTE_PTYPE_L3_IPV6_EXT_UNKNOWN:
+	case RTE_PTYPE_INNER_L3_IPV6:
+	case RTE_PTYPE_INNER_L3_IPV6_EXT:
+	case RTE_PTYPE_INNER_L3_IPV6_EXT_UNKNOWN:
+		return _htons(RTE_ETHER_TYPE_IPV6);
+	default:
+		ethertype = eth_hdr->ether_type;
+		while (eth_hdr->ether_type == _htons(RTE_ETHER_TYPE_VLAN) ||
+			eth_hdr->ether_type == _htons(RTE_ETHER_TYPE_QINQ)) {
+			vlan_hdr = (struct rte_vlan_hdr *)
+				((char *)eth_hdr + sizeof(*eth_hdr));
+			ethertype = vlan_hdr->eth_proto;
+		}
+		return ethertype;
+	}
+}
+
+static uint64_t
+get_tunnel_ol_flags_by_ptype(uint32_t ptype)
+{
+	switch ((ptype & RTE_PTYPE_TUNNEL_MASK)) {
+	case RTE_PTYPE_TUNNEL_GTPC:
+	case RTE_PTYPE_TUNNEL_GTPU:
+		return RTE_MBUF_F_TX_TUNNEL_GTP;
+	case RTE_PTYPE_TUNNEL_VXLAN_GPE:
+		return RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE;
+	case RTE_PTYPE_TUNNEL_VXLAN:
+		return RTE_MBUF_F_TX_TUNNEL_VXLAN;
+	case RTE_PTYPE_TUNNEL_GENEVE:
+		return RTE_MBUF_F_TX_TUNNEL_GENEVE;
+	case RTE_PTYPE_TUNNEL_NVGRE:
+	case RTE_PTYPE_TUNNEL_GRE:
+		return RTE_MBUF_F_TX_TUNNEL_GRE;
+	case RTE_PTYPE_TUNNEL_IP:
+		return RTE_MBUF_F_TX_TUNNEL_IPIP;
+	default:
+		printf("unrecognized tunnel ptype: %x\n",
+			(ptype & RTE_PTYPE_TUNNEL_MASK));
+		return 0;
+	}
+}
+
+static void
+parse_inner_l4_proto(void *outer_l3_hdr,
+			struct testpmd_offload_info *info)
+{
+	struct rte_ipv4_hdr *ipv4_hdr = outer_l3_hdr;
+	struct rte_ipv6_hdr *ipv6_hdr = outer_l3_hdr;
+	if (info->ethertype == _htons(RTE_ETHER_TYPE_IPV4))
+		info->l4_proto = ipv4_hdr->next_proto_id;
+	else
+		info->l4_proto = ipv6_hdr->proto;
+}
+
+static uint8_t
+parse_l4_proto(const struct rte_mbuf *m, uint32_t off, uint32_t ptype)
+{
+	int frag = 0, ret;
+
+	if (RTE_ETH_IS_IPV4_HDR(ptype)) {
+		const struct rte_ipv4_hdr *ip4h;
+		struct rte_ipv4_hdr ip4h_copy;
+		ip4h = rte_pktmbuf_read(m, off, sizeof(*ip4h), &ip4h_copy);
+		if (unlikely(ip4h == NULL))
+			return 0;
+
+		return ip4h->next_proto_id;
+	} else if (RTE_ETH_IS_IPV6_HDR(ptype)) {
+		const struct rte_ipv6_hdr *ip6h;
+		struct rte_ipv6_hdr ip6h_copy;
+		ip6h = rte_pktmbuf_read(m, off, sizeof(*ip6h), &ip6h_copy);
+		if (unlikely(ip6h == NULL))
+			return 0;
+
+		if ((ptype & RTE_PTYPE_INNER_L3_MASK) ==
+				RTE_PTYPE_INNER_L3_IPV6_EXT) {
+			ret = rte_net_skip_ip6_ext(ip6h->proto, m, &off, &frag);
+			if (ret < 0)
+				return 0;
+			return ret;
+		}
+
+		return ip6h->proto;
+	}
+	return 0;
+}
+
 /*
  * Receive a burst of packets, and for each packet:
  *  - parse packet, and try to recognize a supported packet type (1)
@@ -856,6 +623,8 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
 	uint32_t rx_bad_outer_l4_csum;
 	uint32_t rx_bad_outer_ip_csum;
 	struct testpmd_offload_info info;
+	struct rte_net_hdr_lens hdr_lens = {0};
+	uint32_t ptype;
 
 	/* receive a burst of packet */
 	nb_rx = common_fwd_stream_receive(fs, pkts_burst, nb_pkt_per_burst);
@@ -924,70 +693,35 @@ pkt_burst_checksum_forward(struct fwd_stream *fs)
 			rte_ether_addr_copy(&ports[fs->tx_port].eth_addr,
 					    &eth_hdr->src_addr);
 		}
-		parse_ethernet(eth_hdr, &info);
-		l3_hdr = (char *)eth_hdr + info.l2_len;
 
+		ptype = rte_net_get_ptype(m, &hdr_lens, RTE_PTYPE_ALL_MASK);
+		info.l2_len = hdr_lens.l2_len;
+		info.l3_len = hdr_lens.l3_len;
+		info.l4_len = hdr_lens.l4_len;
+		info.ethertype = get_ethertype_by_ptype(eth_hdr,
+					ptype & RTE_PTYPE_L3_MASK);
+		info.l4_proto = parse_l4_proto(m, info.l2_len, ptype);
+
+		l3_hdr = (char *)eth_hdr + info.l2_len;
 		/* check if it's a supported tunnel */
-		if (txp->parse_tunnel) {
-			if (info.l4_proto == IPPROTO_UDP) {
-				struct rte_udp_hdr *udp_hdr;
-
-				udp_hdr = (struct rte_udp_hdr *)
-					((char *)l3_hdr + info.l3_len);
-				parse_gtp(udp_hdr, &info);
-				if (info.is_tunnel) {
-					tx_ol_flags |= RTE_MBUF_F_TX_TUNNEL_GTP;
-					goto tunnel_update;
-				}
-				parse_vxlan_gpe(udp_hdr, &info);
-				if (info.is_tunnel) {
-					tx_ol_flags |=
-						RTE_MBUF_F_TX_TUNNEL_VXLAN_GPE;
-					goto tunnel_update;
-				}
-				parse_vxlan(udp_hdr, &info);
-				if (info.is_tunnel) {
-					tx_ol_flags |=
-						RTE_MBUF_F_TX_TUNNEL_VXLAN;
-					goto tunnel_update;
-				}
-				parse_geneve(udp_hdr, &info);
-				if (info.is_tunnel) {
-					tx_ol_flags |=
-						RTE_MBUF_F_TX_TUNNEL_GENEVE;
-					goto tunnel_update;
-				}
-				/* Always keep last. */
-				if (unlikely(RTE_ETH_IS_TUNNEL_PKT(
-							m->packet_type) != 0)) {
-					TESTPMD_LOG(DEBUG, "Unknown tunnel packet. UDP dst port: %hu",
-						udp_hdr->dst_port);
-				}
-			} else if (info.l4_proto == IPPROTO_GRE) {
-				struct simple_gre_hdr *gre_hdr;
-
-				gre_hdr = (struct simple_gre_hdr *)
-					((char *)l3_hdr + info.l3_len);
-				parse_gre(gre_hdr, &info);
-				if (info.is_tunnel)
-					tx_ol_flags |= RTE_MBUF_F_TX_TUNNEL_GRE;
-			} else if (info.l4_proto == IPPROTO_IPIP) {
-				void *encap_ip_hdr;
-
-				encap_ip_hdr = (char *)l3_hdr + info.l3_len;
-				parse_encap_ip(encap_ip_hdr, &info);
-				if (info.is_tunnel)
-					tx_ol_flags |= RTE_MBUF_F_TX_TUNNEL_IPIP;
-			}
+		if (txp->parse_tunnel && RTE_ETH_IS_TUNNEL_PKT(ptype) != 0) {
+			info.is_tunnel = 1;
+			update_tunnel_outer(&info);
+			info.l2_len = hdr_lens.inner_l2_len + hdr_lens.tunnel_len;
+			info.l3_len = hdr_lens.inner_l3_len;
+			info.l4_len = hdr_lens.inner_l4_len;
+			eth_hdr = (struct rte_ether_hdr *)(char *)l3_hdr +
+					info.outer_l3_len + hdr_lens.tunnel_len;
+			info.ethertype = get_ethertype_by_ptype(eth_hdr,
+						ptype & RTE_PTYPE_INNER_L3_MASK);
+			tx_ol_flags |= get_tunnel_ol_flags_by_ptype(ptype);
 		}
-
-tunnel_update:
 		/* update l3_hdr and outer_l3_hdr if a tunnel was parsed */
 		if (info.is_tunnel) {
 			outer_l3_hdr = l3_hdr;
 			l3_hdr = (char *)l3_hdr + info.outer_l3_len + info.l2_len;
+			parse_inner_l4_proto(l3_hdr, &info);
 		}
-
 		/* step 2: depending on user command line configuration,
 		 * recompute checksum either in software or flag the
 		 * mbuf to offload the calculation to the NIC. If TSO
-- 
2.22.0

