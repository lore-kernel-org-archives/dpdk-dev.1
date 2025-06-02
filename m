Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 545D9C5B549
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 06:37:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9F9C240609;
	Mon,  2 Jun 2025 08:37:20 +0200 (CEST)
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com
 [67.231.148.174])
 by mails.dpdk.org (Postfix) with ESMTP id EFF99402F1
 for <dev@dpdk.org>; Mon,  2 Jun 2025 08:37:18 +0200 (CEST)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
 by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5523a3Z2020583;
 Sun, 1 Jun 2025 23:37:18 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pfpt0220; bh=B
 wcCesHYb591No8TpfnNncmZkKK4MEvVnVMp0vZwji8=; b=lXfsjbPlhwwW2BXx8
 dN2viBgZ0pAVilpJRawHtdVlFqZSO1Xt4CQgzgtL512HON1dT3j2xzz1+gUosyx0
 U1dpWtNUR/QfY0aMDhxnxKAiNPRgl478g1Ef6LewjUZsYJe/CxSY2j86tVPH7Dwg
 90205gxS9yK52BuwHvdcHClw1cYTSMoshB3DDjKAa7nYY7x2VLK8Kqq+IBEQ1+9q
 lnHCVka99e8ITZpI1EjDdcgv7EyCTZNMscp8v3gQO3i7kpxqxkpm1UdfVKX52Spy
 P+cJJQcKJW2WAJlYLjh0UshAoTCWHotfq6R/hfZ6JwqZZmGoUQ/TWA2FaYNL6TaI
 MQCow==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
 by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47145mg8mn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sun, 01 Jun 2025 23:37:17 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 1 Jun 2025 23:37:16 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 1 Jun 2025 23:37:16 -0700
Received: from localhost.localdomain (unknown [10.28.36.185])
 by maili.marvell.com (Postfix) with ESMTP id 1AFE63F704B;
 Sun,  1 Jun 2025 23:37:12 -0700 (PDT)
From: Ankur Dwivedi <adwivedi@marvell.com>
To: <dev@dpdk.org>
CC: <jerinj@marvell.com>, <vladimir.medvedkin@intel.com>,
 <ndabilpuram@marvell.com>, <pbhagavatula@marvell.com>,
 <skori@marvell.com>, <rkudurumalla@marvell.com>, <nsaxena@marvell.com>,
 Ankur Dwivedi <adwivedi@marvell.com>
Subject: [PATCH v3 04/14] node: add process callback for IP4 FIB
Date: Mon, 2 Jun 2025 12:06:29 +0530
Message-ID: <20250602063639.198550-5-adwivedi@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250602063639.198550-1-adwivedi@marvell.com>
References: <20250509064448.724019-1-adwivedi@marvell.com>
 <20250602063639.198550-1-adwivedi@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: a1HErtox0NUH9H666EYjgvAyrwtPUzMM
X-Proofpoint-ORIG-GUID: a1HErtox0NUH9H666EYjgvAyrwtPUzMM
X-Authority-Analysis: v=2.4 cv=GMAIEvNK c=1 sm=1 tr=0 ts=683d469d cx=c_pps
 a=gIfcoYsirJbf48DBMSPrZA==:117 a=gIfcoYsirJbf48DBMSPrZA==:17
 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=qYUj2gt9vubUHnbZ9DIA:9
 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAyMDA1NSBTYWx0ZWRfX6UbToBG5t8za
 jmJNV+sSFGPeNWT2anf7FREYEtTe/oJQZ95rRMbAszmPMdv2x1x81ob7Qscxw1lcCf3UVaAsaH/
 vrMufoa9/jSBM2RprZXN+mCSsA9dXXw7L2jTiYs7FoSKT7UE+RM6YREbcsgzHhjQda9uP9zCGxE
 1fVtV4R+dn2sxw2fDC2AcSSVCvB4ry/kYW2ADsWpyvo7/cnLCrVf8eLix9BphN/nrph+Jq3O20N
 BfJFuRQoq6Om95cRE2cU96wRsLh8SS2ZaQ0ck8iNhq2Q1V8/wM0xj+D2J+RfzVCQWW6a9Va25Ks
 jV9to51lQNmLacZ/8L2PXokwnOaBW5mi8fo5QZTqkB6ya4Nuyd7rK7bw2aHTM+6OLdxX4Xk8POG
 01dnrr5Y2DNNEKCRsClt84WqBtk2Ah38/CHtB2/zCWHQeQQkBWzlg7C7Z2yMKqAjyIPihsNd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-02_02,2025-05-30_01,2025-03-28_01
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
 lib/node/ip4_lookup_fib.c | 154 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 154 insertions(+)

diff --git a/lib/node/ip4_lookup_fib.c b/lib/node/ip4_lookup_fib.c
index f300266c00..f9a5c5aa5a 100644
--- a/lib/node/ip4_lookup_fib.c
+++ b/lib/node/ip4_lookup_fib.c
@@ -40,6 +40,159 @@ static struct ip4_lookup_fib_node_main ip4_lookup_fib_nm;
 #define IP4_LOOKUP_FIB_NODE_PRIV1_OFF(ctx) \
 	(((struct ip4_lookup_fib_node_ctx *)ctx)->mbuf_priv1_off)
 
+static uint16_t
+ip4_lookup_fib_node_process(struct rte_graph *graph, struct rte_node *node, void **objs,
+			    uint16_t nb_objs)
+{
+	struct rte_mbuf *mbuf0, *mbuf1, *mbuf2, *mbuf3, **pkts;
+	const int dyn = IP4_LOOKUP_FIB_NODE_PRIV1_OFF(node->ctx);
+	struct rte_fib *fib = IP4_LOOKUP_NODE_FIB(node->ctx);
+	uint64_t next_hop[RTE_GRAPH_BURST_SIZE];
+	uint32_t ip[RTE_GRAPH_BURST_SIZE];
+	struct rte_ipv4_hdr *ipv4_hdr;
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
+	next_index = RTE_NODE_IP4_LOOKUP_NEXT_REWRITE;
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
+						sizeof(struct rte_ether_hdr)));
+			rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[5], void *,
+						sizeof(struct rte_ether_hdr)));
+			rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[6], void *,
+						sizeof(struct rte_ether_hdr)));
+			rte_prefetch0(rte_pktmbuf_mtod_offset(pkts[7], void *,
+						sizeof(struct rte_ether_hdr)));
+		}
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
+	rte_fib_lookup_bulk(fib, ip, next_hop, nb_objs);
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
+		if (unlikely(next_hop[i] == FIB_DEFAULT_NH))
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
 RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_node_ip4_fib_create, 25.07)
 int
 rte_node_ip4_fib_create(int socket, struct rte_fib_conf *conf)
@@ -162,6 +315,7 @@ static struct rte_node_xstats ip4_lookup_fib_xstats = {
 };
 
 static struct rte_node_register ip4_lookup_fib_node = {
+	.process = ip4_lookup_fib_node_process,
 	.name = "ip4_lookup_fib",
 
 	.init = ip4_lookup_fib_node_init,
-- 
2.25.1

