Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15F13F9EDD1
	for <dpdk-dev@archiver.kernel.org>; Wed, 22 Apr 2026 13:36:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 093C240651;
	Wed, 22 Apr 2026 15:36:35 +0200 (CEST)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by mails.dpdk.org (Postfix) with ESMTP id 2BDBF402E0
 for <dev@dpdk.org>; Wed, 22 Apr 2026 15:36:33 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776864992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=WWNFpjV4KOM4y/KglW3nG9I3qcpMCrPOrNMeuUD49qM=;
 b=Ki7e91pM+LIbvyDC+TQ8iJtJbcex9e+ZRRKV3f2s5kPhXQHSv1qhV4XTsLYuBAlbefvCQZ
 gjmMORotJzf4GjrMOonGTPjMqdrXFXLIeUoKK00ePksF1+MqQgrBaJFDJu3XhBcwHqNLVj
 v3KmpckkImrCqIFjIzNSyYHp7WbbRKQ=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-xBj4l5bVP5eNfySoGTpNFg-1; Wed,
 22 Apr 2026 09:36:29 -0400
X-MC-Unique: xBj4l5bVP5eNfySoGTpNFg-1
X-Mimecast-MFC-AGG-ID: xBj4l5bVP5eNfySoGTpNFg_1776864987
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A5CDE1800581; Wed, 22 Apr 2026 13:36:27 +0000 (UTC)
Received: from ringo.home (unknown [10.44.32.51])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 66E4719560AB; Wed, 22 Apr 2026 13:36:26 +0000 (UTC)
From: Robin Jarry <rjarry@redhat.com>
To: dev@dpdk.org,
	Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH dpdk] net/tap: use offsets provided by rte_net_get_ptype
Date: Wed, 22 Apr 2026 15:36:16 +0200
Message-ID: <20260422133615.680318-2-rjarry@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vNnXn4kANZPaRN2N4FAnCbSmfT6RBEvyzEc92g6PvQE_1776864987
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
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

Instead of guessing what are the proper header lengths, pass
a rte_net_hdr_lens struct to rte_net_get_ptype and use it to get the
proper header lengths/offsets in tap_verify_csum.

Signed-off-by: Robin Jarry <rjarry@redhat.com>
---
 drivers/net/tap/rte_eth_tap.c | 62 ++++++++++-------------------------
 1 file changed, 17 insertions(+), 45 deletions(-)

diff --git a/drivers/net/tap/rte_eth_tap.c b/drivers/net/tap/rte_eth_tap.c
index a5d460a0b3cb..bb25d03ff786 100644
--- a/drivers/net/tap/rte_eth_tap.c
+++ b/drivers/net/tap/rte_eth_tap.c
@@ -327,55 +327,26 @@ tun_alloc(struct pmd_internals *pmd, int is_keepalive, int persistent)
 }
 
 static void
-tap_verify_csum(struct rte_mbuf *mbuf)
+tap_verify_csum(struct rte_mbuf *mbuf, const struct rte_net_hdr_lens *hlen)
 {
-	uint32_t l2 = mbuf->packet_type & RTE_PTYPE_L2_MASK;
 	uint32_t l3 = mbuf->packet_type & RTE_PTYPE_L3_MASK;
 	uint32_t l4 = mbuf->packet_type & RTE_PTYPE_L4_MASK;
-	unsigned int l2_len = sizeof(struct rte_ether_hdr);
-	unsigned int l3_len;
+	uint32_t l4_off = hlen->l2_len + hlen->l3_len;
+	const void *l3_hdr;
+	const void *l4_hdr;
 	uint16_t cksum = 0;
-	void *l3_hdr;
-	void *l4_hdr;
-	struct rte_udp_hdr *udp_hdr;
 
-	if (l2 == RTE_PTYPE_L2_ETHER_VLAN)
-		l2_len += 4;
-	else if (l2 == RTE_PTYPE_L2_ETHER_QINQ)
-		l2_len += 8;
 	/* Don't verify checksum for packets with discontinuous L2 header */
-	if (unlikely(l2_len + sizeof(struct rte_ipv4_hdr) >
-		     rte_pktmbuf_data_len(mbuf)))
+	if (unlikely(l4_off > rte_pktmbuf_data_len(mbuf)))
 		return;
-	l3_hdr = rte_pktmbuf_mtod_offset(mbuf, void *, l2_len);
+
+	l3_hdr = rte_pktmbuf_mtod_offset(mbuf, void *, hlen->l2_len);
 	if (l3 == RTE_PTYPE_L3_IPV4 || l3 == RTE_PTYPE_L3_IPV4_EXT) {
-		struct rte_ipv4_hdr *iph = l3_hdr;
-
-		l3_len = rte_ipv4_hdr_len(iph);
-		if (unlikely(l2_len + l3_len > rte_pktmbuf_data_len(mbuf)))
-			return;
-		/* check that the total length reported by header is not
-		 * greater than the total received size
-		 */
-		if (l2_len + rte_be_to_cpu_16(iph->total_length) >
-				rte_pktmbuf_data_len(mbuf))
-			return;
-
-		cksum = ~rte_raw_cksum(iph, l3_len);
+		cksum = ~rte_raw_cksum(l3_hdr, hlen->l3_len);
 		mbuf->ol_flags |= cksum ?
 			RTE_MBUF_F_RX_IP_CKSUM_BAD :
 			RTE_MBUF_F_RX_IP_CKSUM_GOOD;
-	} else if (l3 == RTE_PTYPE_L3_IPV6) {
-		struct rte_ipv6_hdr *iph = l3_hdr;
-
-		l3_len = sizeof(struct rte_ipv6_hdr);
-		/* check that the total length reported by header is not
-		 * greater than the total received size
-		 */
-		if (l2_len + l3_len + rte_be_to_cpu_16(iph->payload_len) >
-				rte_pktmbuf_data_len(mbuf))
-			return;
-	} else {
+	} else if (l3 != RTE_PTYPE_L3_IPV6) {
 		/* - RTE_PTYPE_L3_IPV4_EXT_UNKNOWN cannot happen because
 		 *   mbuf->packet_type is filled by rte_net_get_ptype() which
 		 *   never returns this value.
@@ -386,20 +357,19 @@ tap_verify_csum(struct rte_mbuf *mbuf)
 
 	if (l4 == RTE_PTYPE_L4_UDP || l4 == RTE_PTYPE_L4_TCP) {
 		int cksum_ok;
-		const unsigned int l4_min_len = (l4 == RTE_PTYPE_L4_UDP)
-			? sizeof(struct rte_udp_hdr) : sizeof(struct rte_tcp_hdr);
 
 		/* Don't verify checksum if L4 header is truncated */
-		if (l2_len + l3_len + l4_min_len > rte_pktmbuf_data_len(mbuf))
+		if (l4_off + hlen->l4_len > rte_pktmbuf_data_len(mbuf))
 			return;
 
-		l4_hdr = rte_pktmbuf_mtod_offset(mbuf, void *, l2_len + l3_len);
 		/* Don't verify checksum for multi-segment packets. */
 		if (mbuf->nb_segs > 1)
 			return;
+
+		l4_hdr = rte_pktmbuf_mtod_offset(mbuf, void *, l4_off);
 		if (l3 == RTE_PTYPE_L3_IPV4 || l3 == RTE_PTYPE_L3_IPV4_EXT) {
 			if (l4 == RTE_PTYPE_L4_UDP) {
-				udp_hdr = (struct rte_udp_hdr *)l4_hdr;
+				const struct rte_udp_hdr *udp_hdr = l4_hdr;
 				if (udp_hdr->dgram_cksum == 0) {
 					/*
 					 * For IPv4, a zero UDP checksum
@@ -483,6 +453,7 @@ tap_mac_filter_match(struct rx_queue *rxq, struct rte_mbuf *mbuf)
 static uint16_t
 pmd_rx_burst(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
+	struct rte_net_hdr_lens hdr_lens;
 	struct rx_queue *rxq = queue;
 	struct pmd_process_private *process_private;
 	uint16_t num_rx;
@@ -561,10 +532,11 @@ pmd_rx_burst(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			continue;
 		}
 
-		mbuf->packet_type = rte_net_get_ptype(mbuf, NULL,
+		memset(&hdr_lens, 0, sizeof(hdr_lens));
+		mbuf->packet_type = rte_net_get_ptype(mbuf, &hdr_lens,
 						      RTE_PTYPE_ALL_MASK);
 		if (rxq->rxmode->offloads & RTE_ETH_RX_OFFLOAD_CHECKSUM)
-			tap_verify_csum(mbuf);
+			tap_verify_csum(mbuf, &hdr_lens);
 
 		/* account for the receive frame */
 		bufs[num_rx++] = mbuf;
-- 
2.53.0

