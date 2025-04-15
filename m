Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4674C369AB
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 12:11:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 123B640669;
	Tue, 15 Apr 2025 14:11:44 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com
 [67.231.156.173])
 by mails.dpdk.org (Postfix) with ESMTP id 57C844066A
 for <dev@dpdk.org>; Tue, 15 Apr 2025 14:11:42 +0200 (CEST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
 by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53F9dxcn000819;
 Tue, 15 Apr 2025 05:11:41 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=P
 94dJGzYkW+i30m1PkNOWllL5hNZmlBmGvQHdVY0954=; b=hWEdwmtHBN/p8ywm2
 qcvoZbmkbOb19IGueULzkbyDwExed6FH+42kJrpmTIhNStU/c+9rfqD4xWZcbwBZ
 uxPPQiXNbOOt4Dhzd86Ftx5kT8GG7BGNuRbvV9Z5NOCtgALAk0P5/1d+gl42hB8M
 zHm4xAE5shrwn4cZwujKgZe6Yh1J2aM5txBAEtFQ3gnKGYEQ4LoU0vTmmaCz0y82
 hPu/ta4gv+ZWGpXD8rMivc5/JXhejYIcj4PY2IkY8cg+LMji4l5DC2ebp/+QK1Qh
 1QqirTelmLdE1TRuF1jid38aqBYxCsu+eUrq30WuPC8RtRcrSd+lZUgjUt24OBHx
 2XvMw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
 by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 45yqpjeea1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 15 Apr 2025 05:11:41 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 15 Apr 2025 05:11:40 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Tue, 15 Apr 2025 05:11:40 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id 74CA467398;
 Tue, 15 Apr 2025 05:11:37 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v1 04/12] node: add process callback for IP4 FIB
Date: Tue, 15 Apr 2025 17:40:44 +0530
Message-ID: <20250415121052.1497155-5-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250415121052.1497155-1-adwivedi@marvell.com>
References: <20250415121052.1497155-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: VxB_IXAYLiPkdp94V_bHDNJNwkdLS0sl
X-Authority-Analysis: v=2.4 cv=ZOvXmW7b c=1 sm=1 tr=0 ts=67fe4cfd cx=c_pps
 a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17
 a=XR8D0OoHHMoA:10 a=M5GUcnROAAAA:8 a=uwveK1UN9aJxG0m9DPUA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-GUID: VxB_IXAYLiPkdp94V_bHDNJNwkdLS0sl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-15_05,2025-04-10_01,2024-11-22_01
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

Adds the process callback function for ip4_lookup_fib node.

Signed-off-by: Ankur Dwivedi <adwivedi@marvell.com>
---
 lib/node/ip4_lookup_fib.c | 164 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 164 insertions(+)

diff --git a/lib/node/ip4_lookup_fib.c b/lib/node/ip4_lookup_fib.c
index e87864e672..c535b191f8 100644
--- a/lib/node/ip4_lookup_fib.c
+++ b/lib/node/ip4_lookup_fib.c
@@ -40,6 +40,169 @@ static struct ip4_lookup_fib_node_main ip4_lookup_fib_nm;
 #define IP4_LOOKUP_NODE_PRIV1_OFF(ctx) \
 	(((struct ip4_lookup_fib_node_ctx *)ctx)->mbuf_priv1_off)
 
+static uint16_t
+ip4_lookup_fib_node_process(struct rte_graph *graph, struct rte_node *node, void **objs,
+			    uint16_t nb_objs)
+{
+	struct rte_mbuf *mbuf0, *mbuf1, *mbuf2, *mbuf3, **pkts;
+	struct rte_fib *fib = IP4_LOOKUP_NODE_FIB(node->ctx);
+	const int dyn = IP4_LOOKUP_NODE_PRIV1_OFF(node->ctx);
+	struct rte_ipv4_hdr *ipv4_hdr;
+	uint64_t next_hop[nb_objs];
+	uint16_t lookup_err = 0;
+	void **to_next, **from;
+	uint16_t last_spec = 0;
+	rte_edge_t next_index;
+	uint16_t n_left_from;
+	uint32_t ip[nb_objs];
+	uint16_t held = 0;
+	uint32_t drop_nh;
+	uint16_t next;
+	int i, rc;
+
+	/* Speculative next */
+	next_index = RTE_NODE_IP4_LOOKUP_NEXT_REWRITE;
+	/* Drop node */
+	drop_nh = ((uint32_t)RTE_NODE_IP4_LOOKUP_NEXT_PKT_DROP) << 16;
+
+	pkts = (struct rte_mbuf **)objs;
+	from = objs;
+	n_left_from = nb_objs;
+
+	/* Get stream for the speculated next node */
+	to_next = rte_node_next_stream_get(graph, node, next_index, nb_objs);
+
+	for (i = OBJS_PER_CLINE; i < RTE_GRAPH_BURST_SIZE; i += OBJS_PER_CLINE)
+		rte_prefetch0(&objs[i]);
+
+#if RTE_GRAPH_BURST_SIZE > 64
+	for (i = 0; i < 4 && i < n_left_from; i++) {
+		rte_prefetch0(pkts[i]);
+		rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[i], void *,
+					sizeof(struct rte_ether_hdr)));
+	}
+#endif
+
+	i = 0;
+	while (n_left_from >= 4) {
+#if RTE_GRAPH_BURST_SIZE > 64
+		if (likely(n_left_from > 7)) {
+			rte_prefetch0(pkts[4]);
+			rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[4], void *,
+					sizeof(struct rte_ether_hdr)));
+			rte_prefetch0(pkts[5]);
+			rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[5], void *,
+					sizeof(struct rte_ether_hdr)));
+			rte_prefetch0(pkts[6]);
+			rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[6], void *,
+					sizeof(struct rte_ether_hdr)));
+			rte_prefetch0(pkts[7]);
+			rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[7], void *,
+					sizeof(struct rte_ether_hdr)));
+		}
+#endif
+
+		mbuf0 = pkts[0];
+		mbuf1 = pkts[1];
+		mbuf2 = pkts[2];
+		mbuf3 = pkts[3];
+		pkts += 4;
+		n_left_from -= 4;
+		/* Extract DIP of mbuf0 */
+		ipv4_hdr = rte_pktmbuf_mtod_offset(mbuf0, struct rte_ipv4_hdr *,
+				sizeof(struct rte_ether_hdr));
+		/* Extract cksum, ttl as ipv4 hdr is in cache */
+		node_mbuf_priv1(mbuf0, dyn)->cksum = ipv4_hdr->hdr_checksum;
+		node_mbuf_priv1(mbuf0, dyn)->ttl = ipv4_hdr->time_to_live;
+
+		ip[i++] = rte_be_to_cpu_32(ipv4_hdr->dst_addr);
+
+		/* Extract DIP of mbuf1 */
+		ipv4_hdr = rte_pktmbuf_mtod_offset(mbuf1, struct rte_ipv4_hdr *,
+				sizeof(struct rte_ether_hdr));
+		/* Extract cksum, ttl as ipv4 hdr is in cache */
+		node_mbuf_priv1(mbuf1, dyn)->cksum = ipv4_hdr->hdr_checksum;
+		node_mbuf_priv1(mbuf1, dyn)->ttl = ipv4_hdr->time_to_live;
+
+		ip[i++] = rte_be_to_cpu_32(ipv4_hdr->dst_addr);
+
+		/* Extract DIP of mbuf2 */
+		ipv4_hdr = rte_pktmbuf_mtod_offset(mbuf2, struct rte_ipv4_hdr *,
+				sizeof(struct rte_ether_hdr));
+		/* Extract cksum, ttl as ipv4 hdr is in cache */
+		node_mbuf_priv1(mbuf2, dyn)->cksum = ipv4_hdr->hdr_checksum;
+		node_mbuf_priv1(mbuf2, dyn)->ttl = ipv4_hdr->time_to_live;
+
+		ip[i++] = rte_be_to_cpu_32(ipv4_hdr->dst_addr);
+
+		/* Extract DIP of mbuf3 */
+		ipv4_hdr = rte_pktmbuf_mtod_offset(mbuf3, struct rte_ipv4_hdr *,
+				sizeof(struct rte_ether_hdr));
+
+		/* Extract cksum, ttl as ipv4 hdr is in cache */
+		node_mbuf_priv1(mbuf3, dyn)->cksum = ipv4_hdr->hdr_checksum;
+		node_mbuf_priv1(mbuf3, dyn)->ttl = ipv4_hdr->time_to_live;
+
+		ip[i++] = rte_be_to_cpu_32(ipv4_hdr->dst_addr);
+	}
+	while (n_left_from > 0) {
+		mbuf0 = pkts[0];
+		pkts += 1;
+		n_left_from -= 1;
+
+		/* Extract DIP of mbuf0 */
+		ipv4_hdr = rte_pktmbuf_mtod_offset(mbuf0, struct rte_ipv4_hdr *,
+				sizeof(struct rte_ether_hdr));
+		/* Extract cksum, ttl as ipv4 hdr is in cache */
+		node_mbuf_priv1(mbuf0, dyn)->cksum = ipv4_hdr->hdr_checksum;
+		node_mbuf_priv1(mbuf0, dyn)->ttl = ipv4_hdr->time_to_live;
+
+		ip[i++] = rte_be_to_cpu_32(ipv4_hdr->dst_addr);
+	}
+
+	rc = rte_fib_lookup_bulk(fib, ip, next_hop, nb_objs);
+	if (unlikely(rc != 0))
+		return 0;
+
+	for (i = 0; i < nb_objs; i++) {
+		if (unlikely(next_hop[i] == FIB_DEFAULT_NH)) {
+			next_hop[i] = drop_nh;
+			lookup_err += 1;
+		}
+
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
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip4_fib_route_add, 25.07)
 int
 rte_node_ip4_fib_route_add(uint32_t ip, uint8_t depth, uint16_t next_hop,
@@ -147,6 +310,7 @@ static struct rte_node_xstats ip4_lookup_fib_xstats = {
 };
 
 static struct rte_node_register ip4_lookup_fib_node = {
+	.process = ip4_lookup_fib_node_process,
 	.name = "ip4_lookup_fib",
 
 	.init = ip4_lookup_fib_node_init,
-- 
2.25.1

