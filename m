Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4181BC3ABBC
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 May 2025 06:46:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE6454060A;
	Fri,  9 May 2025 08:46:07 +0200 (CEST)
Received: from mx0a-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id 071CB4065C
 for <dev@dpdk.org>; Fri,  9 May 2025 08:46:05 +0200 (CEST)
Received: from pps.filterd (m0431384.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5492iUaa030980;
 Thu, 8 May 2025 23:46:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=Z
 fyE3uuSbhwxlY15Wlw5aPbWQpf1ZHJhXj7OEptQIrU=; b=X7NdcqxuUvpfPF05d
 Y+Rp1CMz4tC7EldGBBDurjmnKbj1LxxoJGvahb5MASiMnAzWLtv1U9lxnXawYI4/
 aQSpvMdXpsjHDrs74UaNRQ16G6FfSDTofqC0xuAyP1jzCHIBqZ4DOoJmuzx1p2Ct
 jQBRaLStTRYOkgANwBGJln15xHs10QGspz5YDW6ChKFVCW1qOub3Dx6uldHUI941
 4r+6WyTb5VZUmDM1dYfiPE/7LvJUr7yCq2+gDxW6SbjetnFVWtQOoQsvWvaNTlCm
 mpNbToro6QT4PndzD8iZ9cQzZhHvVXn/UXp4wttInR7O8MevrEPZ2Jue9E2C5XFi
 9zojg==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 46h96c0cke-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 23:46:05 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 8 May 2025 23:46:04 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 8 May 2025 23:46:04 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id 5A9183F7066;
 Thu,  8 May 2025 23:46:01 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>, <nsaxena@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v2 11/13] node: add process callback for IP6 FIB
Date: Fri, 9 May 2025 12:14:46 +0530
Message-ID: <20250509064448.724019-12-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250509064448.724019-1-adwivedi@marvell.com>
References: <20250415121052.1497155-1-adwivedi@marvell.com>
 <20250509064448.724019-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA5MDA2MyBTYWx0ZWRfX1MZpzF2yqrYN
 to69A9U55uzJ2uHKt83f14j+6t92a5v0iQ2sPB2BBuYnLJReY/qM96xcpGSHiG58HqEshB5Xh+Z
 GFiMYQ8Gpuu9mFpNyqKmJ18Q64IsDhhW0LYZelakQ0fAoId21OyOdgJJX145Ux9EyBGhHdWPD9I
 oFhUYX8laAGHPFkoSR/ZtThNIMUhoJHoEZMsIO2x3DDY0MSdG3Ez6HGAsur2KeNTZjkcVuV+MVM
 a4vgG0951WR84/9G64kf2RrkZ/NHWKx0JpXF438gaXSB3JpH0KOIsmxZ12PDrlNe60s9kYUuRFQ
 yTPpMUkY3q/X0XrIfEv5r35N35RqQFFqB4nepzVVpU/OffnhchVN/ahIQl0kxmu3aXCgkmWWxwV
 itJC9z97EkilnShYwISCmml4mZC7iTYVceXmspb4mbDtt51JEAOYwgEbIHAbbKQXxL8LkJW/
X-Proofpoint-GUID: O-cMIeuIOkGWUxwXX024NaDOi_8HVSFv
X-Proofpoint-ORIG-GUID: O-cMIeuIOkGWUxwXX024NaDOi_8HVSFv
X-Authority-Analysis: v=2.4 cv=dpXbC0g4 c=1 sm=1 tr=0 ts=681da4ad cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=dt9VzEwgFbYA:10 a=M5GUcnROAAAA:8 a=HgU-b89uhFXLxWSzcvEA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-09_02,2025-05-08_04,2025-02-21_01
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

Adds the process callback function for ip6_lookup_fib node.

Signed-off-by: Ankur Dwivedi <adwivedi@marvell.com>
---
 lib/node/ip6_lookup_fib.c | 148 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 148 insertions(+)

diff --git a/lib/node/ip6_lookup_fib.c b/lib/node/ip6_lookup_fib.c
index b510452ad8..3df61890e9 100644
--- a/lib/node/ip6_lookup_fib.c
+++ b/lib/node/ip6_lookup_fib.c
@@ -40,6 +40,153 @@ static struct ip6_lookup_fib_node_main ip6_lookup_fib_nm;
 #define IP6_LOOKUP_FIB_NODE_PRIV1_OFF(ctx) \
 	(((struct ip6_lookup_fib_node_ctx *)ctx)->mbuf_priv1_off)
 
+static uint16_t
+ip6_lookup_fib_node_process(struct rte_graph *graph, struct rte_node *node, void **objs,
+			    uint16_t nb_objs)
+{
+	struct rte_mbuf *mbuf0, *mbuf1, *mbuf2, *mbuf3, **pkts;
+	const int dyn = IP6_LOOKUP_FIB_NODE_PRIV1_OFF(node->ctx);
+	struct rte_fib6 *fib = IP6_LOOKUP_FIB_NODE(node->ctx);
+	struct rte_ipv6_addr ip[RTE_GRAPH_BURST_SIZE] = { 0 };
+	uint64_t next_hop[RTE_GRAPH_BURST_SIZE];
+	struct rte_ipv6_hdr *ipv6_hdr;
+	uint16_t lookup_err = 0;
+	void **to_next, **from;
+	uint16_t last_spec = 0;
+	rte_edge_t next_index;
+	uint16_t n_left_from;
+	uint16_t held = 0;
+	uint16_t next;
+	int i;
+
+	/* Speculative next */
+	next_index = RTE_NODE_IP6_LOOKUP_NEXT_REWRITE;
+
+	pkts = (struct rte_mbuf **)objs;
+	from = objs;
+	n_left_from = nb_objs;
+
+	/* Get stream for the speculated next node */
+	to_next = rte_node_next_stream_get(graph, node, next_index, nb_objs);
+
+	for (i = 0; i < 4 && i < n_left_from; i++)
+		rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[i], void *,
+					sizeof(struct rte_ether_hdr)));
+
+	i = 0;
+	while (n_left_from >= 4) {
+		if (likely(n_left_from > 7)) {
+
+			/* Prefetch next-next mbufs */
+			if (likely(n_left_from > 11)) {
+				rte_prefetch0(pkts[8]);
+				rte_prefetch0(pkts[9]);
+				rte_prefetch0(pkts[10]);
+				rte_prefetch0(pkts[11]);
+			}
+
+			/* Prefetch next mbuf data */
+			rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[4], void *,
+					sizeof(struct rte_ether_hdr)));
+			rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[5], void *,
+					sizeof(struct rte_ether_hdr)));
+			rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[6], void *,
+					sizeof(struct rte_ether_hdr)));
+			rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[7], void *,
+					sizeof(struct rte_ether_hdr)));
+		}
+
+		mbuf0 = pkts[0];
+		mbuf1 = pkts[1];
+		mbuf2 = pkts[2];
+		mbuf3 = pkts[3];
+		pkts += 4;
+		n_left_from -= 4;
+		/* Extract DIP of mbuf0 */
+		ipv6_hdr = rte_pktmbuf_mtod_offset(mbuf0, struct rte_ipv6_hdr *,
+				sizeof(struct rte_ether_hdr));
+		/* Extract hop_limits as ipv6 hdr is in cache */
+		node_mbuf_priv1(mbuf0, dyn)->ttl = ipv6_hdr->hop_limits;
+
+		ip[i++] = ipv6_hdr->dst_addr;
+
+		/* Extract DIP of mbuf1 */
+		ipv6_hdr = rte_pktmbuf_mtod_offset(mbuf1, struct rte_ipv6_hdr *,
+				sizeof(struct rte_ether_hdr));
+		/* Extract hop_limits as ipv6 hdr is in cache */
+		node_mbuf_priv1(mbuf1, dyn)->ttl = ipv6_hdr->hop_limits;
+
+		ip[i++] = ipv6_hdr->dst_addr;
+
+		/* Extract DIP of mbuf2 */
+		ipv6_hdr = rte_pktmbuf_mtod_offset(mbuf2, struct rte_ipv6_hdr *,
+				sizeof(struct rte_ether_hdr));
+		/* Extract hop_limits as ipv6 hdr is in cache */
+		node_mbuf_priv1(mbuf2, dyn)->ttl = ipv6_hdr->hop_limits;
+
+		ip[i++] = ipv6_hdr->dst_addr;
+
+		/* Extract DIP of mbuf3 */
+		ipv6_hdr = rte_pktmbuf_mtod_offset(mbuf3, struct rte_ipv6_hdr *,
+				sizeof(struct rte_ether_hdr));
+		/* Extract hop_limits as ipv6 hdr is in cache */
+		node_mbuf_priv1(mbuf3, dyn)->ttl = ipv6_hdr->hop_limits;
+
+		ip[i++] = ipv6_hdr->dst_addr;
+	}
+	while (n_left_from > 0) {
+		mbuf0 = pkts[0];
+		pkts += 1;
+		n_left_from -= 1;
+
+		/* Extract DIP of mbuf0 */
+		ipv6_hdr = rte_pktmbuf_mtod_offset(mbuf0, struct rte_ipv6_hdr *,
+				sizeof(struct rte_ether_hdr));
+		/* Extract hop_limits as ipv6 hdr is in cache */
+		node_mbuf_priv1(mbuf0, dyn)->ttl = ipv6_hdr->hop_limits;
+
+		ip[i++] = ipv6_hdr->dst_addr;
+	}
+
+	rte_fib6_lookup_bulk(fib, ip, next_hop, nb_objs);
+
+	for (i = 0; i < nb_objs; i++) {
+		mbuf0 = (struct rte_mbuf *)objs[i];
+		node_mbuf_priv1(mbuf0, dyn)->nh = (uint16_t)next_hop[i];
+		next = (uint16_t)(next_hop[i] >> 16);
+
+		if (unlikely(next_index ^ next)) {
+			/* Copy things successfully speculated till now */
+			rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
+			from += last_spec;
+			to_next += last_spec;
+			held += last_spec;
+			last_spec = 0;
+
+			rte_node_enqueue_x1(graph, node, next, from[0]);
+			from += 1;
+		} else {
+			last_spec += 1;
+		}
+
+		if (unlikely(next_hop[i] == FIB6_DEFAULT_NH))
+			lookup_err += 1;
+	}
+
+	/* !!! Home run !!! */
+	if (likely(last_spec == nb_objs)) {
+		rte_node_next_stream_move(graph, node, next_index);
+		return nb_objs;
+	}
+
+	NODE_INCREMENT_XSTAT_ID(node, 0, lookup_err != 0, lookup_err);
+	held += last_spec;
+	rte_memcpy(to_next, from, last_spec * sizeof(from[0]));
+	rte_node_next_stream_put(graph, node, next_index, held);
+
+	return nb_objs;
+}
+
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip6_fib_create, 25.07)
 int
 rte_node_ip6_fib_create(int socket, struct rte_fib6_conf *conf)
@@ -159,6 +306,7 @@ static struct rte_node_xstats ip6_lookup_fib_xstats = {
 };
 
 static struct rte_node_register ip6_lookup_fib_node = {
+	.process = ip6_lookup_fib_node_process,
 	.name = "ip6_lookup_fib",
 
 	.init = ip6_lookup_fib_node_init,
-- 
2.25.1

