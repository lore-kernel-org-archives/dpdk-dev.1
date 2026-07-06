Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBD76C44502
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 13:21:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D597140697;
	Mon,  6 Jul 2026 15:20:59 +0200 (CEST)
Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com
 [113.46.200.221])
 by mails.dpdk.org (Postfix) with ESMTP id 28684402C3
 for <dev@dpdk.org>; Mon,  6 Jul 2026 15:20:57 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=BMA1J1Eb5Outvf4dSeB+9EYGp2kZuCWB9/QJtu2bfow=;
 b=GUHaEHEOdvgTARQEiAYF9Qwi7rsqBybzbR5lUHmWqtIsSXJ3zI/eFqiXz99bXiDE5Ip2qhhxR
 mCX+kPGhHbRwH01LnxvGZJoThAxsB/eFaT6Ae1xUpRzPRcSgatoUJiMEZ27NT1uEIrNrOwXdnv0
 OK7W+3YJ6jxR/xRNAUD5wDI=
Received: from mail.maildlp.com (unknown [172.19.162.223])
 by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4gv4WJ0Pg0zRhQg;
 Mon,  6 Jul 2026 21:11:40 +0800 (CST)
Received: from kwepemj100018.china.huawei.com (unknown [7.202.194.12])
 by mail.maildlp.com (Postfix) with ESMTPS id A49CB40575;
 Mon,  6 Jul 2026 21:20:51 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 kwepemj100018.china.huawei.com (7.202.194.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 6 Jul 2026 21:20:51 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <david.marchand@redhat.com>,
 <aman.deep.singh@intel.com>, <fengchengwen@huawei.com>,
 <lihuisong@huawei.com>, <liuyonglong@huawei.com>, <kangfenglong@huawei.com>
Subject: [PATCH v3] app/testpmd: support runt and ultra-small frames in txonly
Date: Mon, 6 Jul 2026 21:20:50 +0800
Message-ID: <20260706132050.3054235-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

Allow set txpkts to accept packet lengths as small as one byte,
enabling generation of runt frames and ultra-small packets for
testing NIC padding logic and undersized frame handling.

The txonly engine handles three ranges: normal (>= 42 bytes) with
full Ethernet/IPv4/UDP headers, runt (14-41 bytes) with truncated
headers, and ultra-small (< 14 bytes) filled with a repeating
pattern. Checksum offloads are disabled when headers are incomplete.

Minimum length validation in set_tx_pkt_segments() is relaxed from
42 to 1 byte. Random split and multi-flow still require the full
header stack in the first segment, as enforced by tx_only_begin().

Signed-off-by: Xingui Yang <yangxingui@huawei.com>
Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test-pmd/config.c                       | 18 +++--
 app/test-pmd/txonly.c                       | 79 ++++++++++++++++++---
 doc/guides/rel_notes/release_26_07.rst      |  5 +-
 doc/guides/testpmd_app_ug/testpmd_funcs.rst | 21 ++++++
 4 files changed, 104 insertions(+), 19 deletions(-)

diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index 3df7412ef6..31b33d3956 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -6327,9 +6327,9 @@ set_tx_pkt_segments(unsigned int *seg_lengths, unsigned int nb_segs)
 	/*
 	 * Check that each segment length is greater or equal than
 	 * the mbuf data size.
-	 * Check also that the total packet length is greater or equal than the
-	 * size of an empty UDP/IP packet (sizeof(struct rte_ether_hdr) +
-	 * 20 + 8).
+	 * The total packet length may be as small as one byte, this allows
+	 * generating runt frames and ultra-small packets for testing NIC
+	 * padding logic and undersized frame handling.
 	 */
 	tx_pkt_len = 0;
 	for (i = 0; i < nb_segs; i++) {
@@ -6341,12 +6341,16 @@ set_tx_pkt_segments(unsigned int *seg_lengths, unsigned int nb_segs)
 		}
 		tx_pkt_len = (uint16_t)(tx_pkt_len + seg_lengths[i]);
 	}
-	if (tx_pkt_len < (sizeof(struct rte_ether_hdr) + 20 + 8)) {
-		fprintf(stderr, "total packet length=%u < %d - give up\n",
-				(unsigned) tx_pkt_len,
-				(int)(sizeof(struct rte_ether_hdr) + 20 + 8));
+	if (tx_pkt_len == 0) {
+		fprintf(stderr, "total packet length is zero - give up\n");
 		return;
 	}
+	if (tx_pkt_len < (sizeof(struct rte_ether_hdr) + 20 + 8))
+		fprintf(stderr,
+				"Warning: total packet length=%u < %d (full Ether/IP/UDP), "
+				"generating runt or ultra-small frames\n",
+				(unsigned int) tx_pkt_len,
+				(int)(sizeof(struct rte_ether_hdr) + 20 + 8));
 
 	for (i = 0; i < nb_segs; i++)
 		tx_pkt_seg_lengths[i] = (uint16_t) seg_lengths[i];
diff --git a/app/test-pmd/txonly.c b/app/test-pmd/txonly.c
index a4acb85d29..6e102e2447 100644
--- a/app/test-pmd/txonly.c
+++ b/app/test-pmd/txonly.c
@@ -64,6 +64,9 @@ static int32_t timestamp_off; /**< Timestamp dynamic field offset */
 static bool timestamp_enable; /**< Timestamp enable */
 static uint64_t timestamp_initial[RTE_MAX_ETHPORTS];
 
+/* Fill pattern for ultra-small packets too small to hold Ethernet header. */
+static const char pad_pattern[] = "0123456789abcdef";
+
 static void
 copy_buf_to_pkt_segs(void* buf, unsigned len, struct rte_mbuf *pkt,
 		     unsigned offset)
@@ -76,6 +79,12 @@ copy_buf_to_pkt_segs(void* buf, unsigned len, struct rte_mbuf *pkt,
 	while (offset >= seg->data_len) {
 		offset -= seg->data_len;
 		seg = seg->next;
+		/*
+		 * The packet may be shorter than the header stack when
+		 * generating runt frames; stop once it runs out of segments.
+		 */
+		if (seg == NULL)
+			return;
 	}
 	copy_len = seg->data_len - offset;
 	seg_buf = rte_pktmbuf_mtod_offset(seg, char *, offset);
@@ -84,6 +93,8 @@ copy_buf_to_pkt_segs(void* buf, unsigned len, struct rte_mbuf *pkt,
 		len -= copy_len;
 		buf = ((char*) buf + copy_len);
 		seg = seg->next;
+		if (seg == NULL)
+			return;
 		seg_buf = rte_pktmbuf_mtod(seg, char *);
 		copy_len = seg->data_len;
 	}
@@ -192,9 +203,6 @@ pkt_burst_prepare(struct rte_mbuf *pkt, struct rte_mempool *mbp,
 	pkt->ol_flags |= ol_flags;
 	pkt->vlan_tci = vlan_tci;
 	pkt->vlan_tci_outer = vlan_tci_outer;
-	pkt->l2_len = sizeof(struct rte_ether_hdr);
-	pkt->l3_len = sizeof(struct rte_ipv4_hdr);
-
 	pkt_len = pkt->data_len;
 	pkt_seg = pkt;
 	for (i = 1; i < nb_segs; i++) {
@@ -204,15 +212,60 @@ pkt_burst_prepare(struct rte_mbuf *pkt, struct rte_mempool *mbp,
 		pkt_len += pkt_seg->data_len;
 	}
 	pkt_seg->next = NULL; /* Last segment of packet. */
+
 	/*
 	 * Copy headers in first packet segment(s).
+	 * For runt frames (pkt_len < full header stack), headers are
+	 * truncated to fit, copy_buf_to_pkt_segs stops at the last
+	 * segment so no out-of-bounds access occurs. For ultra-small
+	 * packets (pkt_len < Ethernet header), a fill pattern is used
+	 * instead of headers.
 	 */
-	copy_buf_to_pkt(eth_hdr, sizeof(*eth_hdr), pkt, 0);
-	copy_buf_to_pkt(&pkt_ip_hdr, sizeof(pkt_ip_hdr), pkt,
-			sizeof(struct rte_ether_hdr));
-	copy_buf_to_pkt(&pkt_udp_hdr, sizeof(pkt_udp_hdr), pkt,
-			sizeof(struct rte_ether_hdr) +
-			sizeof(struct rte_ipv4_hdr));
+	if (pkt_len >= sizeof(struct rte_ether_hdr)) {
+		/*
+		 * A runt frame may be too short to carry a full IPv4/UDP
+		 * header. Clamp l3_len and drop any checksum offload whose
+		 * header is not fully present, so the PMD is never asked to
+		 * checksum bytes that are not in the frame. pkt_len is at
+		 * least sizeof(rte_ether_hdr), so the subtraction below
+		 * cannot underflow.
+		 */
+		pkt->l2_len = sizeof(struct rte_ether_hdr);
+		pkt->l3_len = RTE_MIN(sizeof(struct rte_ipv4_hdr),
+				pkt_len - sizeof(struct rte_ether_hdr));
+		if (pkt_len < sizeof(struct rte_ether_hdr) +
+				sizeof(struct rte_ipv4_hdr))
+			pkt->ol_flags &= ~(RTE_MBUF_F_TX_IP_CKSUM |
+					RTE_MBUF_F_TX_L4_MASK);
+		else if (pkt_len < sizeof(struct rte_ether_hdr) +
+				sizeof(struct rte_ipv4_hdr) +
+				sizeof(struct rte_udp_hdr))
+			pkt->ol_flags &= ~RTE_MBUF_F_TX_L4_MASK;
+		copy_buf_to_pkt(eth_hdr, sizeof(*eth_hdr), pkt, 0);
+		copy_buf_to_pkt(&pkt_ip_hdr, sizeof(pkt_ip_hdr), pkt,
+				sizeof(struct rte_ether_hdr));
+		copy_buf_to_pkt(&pkt_udp_hdr, sizeof(pkt_udp_hdr), pkt,
+				sizeof(struct rte_ether_hdr) +
+				sizeof(struct rte_ipv4_hdr));
+	} else {
+		struct rte_mbuf *seg;
+		uint32_t j;
+
+		pkt->l2_len = 0;
+		pkt->l3_len = 0;
+		pkt->ol_flags &= ~(RTE_MBUF_F_TX_IP_CKSUM |
+				RTE_MBUF_F_TX_L4_MASK);
+		seg = pkt;
+		while (seg != NULL) {
+			char *data = rte_pktmbuf_mtod(seg, char *);
+
+			for (j = 0; j < seg->data_len; j++)
+				data[j] = pad_pattern[j %
+					(sizeof(pad_pattern) - 1)];
+			seg = seg->next;
+		}
+	}
+
 	if (txonly_multi_flow) {
 		uint16_t src_var = RTE_PER_LCORE(_src_port_var);
 		struct rte_udp_hdr *udp_hdr;
@@ -405,7 +458,13 @@ tx_only_begin(portid_t pi)
 	pkt_hdr_len = (uint16_t)(sizeof(struct rte_ether_hdr) +
 				 sizeof(struct rte_ipv4_hdr) +
 				 sizeof(struct rte_udp_hdr));
-	pkt_data_len = tx_pkt_length - pkt_hdr_len;
+	/*
+	 * tx_pkt_length may be smaller than the full header stack when
+	 * generating runt or ultra-small frames; clamp the payload length
+	 * to zero in that case so the IP/UDP length fields stay sane.
+	 */
+	pkt_data_len = tx_pkt_length > pkt_hdr_len ?
+			tx_pkt_length - pkt_hdr_len : 0;
 
 	if ((tx_pkt_split == TX_PKT_SPLIT_RND || txonly_multi_flow) &&
 	    tx_pkt_seg_lengths[0] < pkt_hdr_len) {
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 8b1bdada1a..3fca990f78 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -242,8 +242,9 @@ New Features
 
 * **Updated testpmd application.**
 
-  Added support for setting VLAN priority and CFI/DEI bits
-  in ``tx_vlan set``/``tx_qinq set`` commands and ``vlan_tci`` parameter.
+  * Added support for setting VLAN priority and CFI/DEI bits
+    in ``tx_vlan set``/``tx_qinq set`` commands and ``vlan_tci`` parameter.
+  * Added support for runt and ultra-small frames in the txonly mode.
 
 * **Added AI review helpers.**
 
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index 364d348372..b69924c5f9 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -876,6 +876,27 @@ Set the length of each segment of the TX-ONLY packets or length of packet for FL
 
 Where x[,y]* represents a CSV list of values, without white space.
 
+The total packet length may be set as small as one byte, which is below
+the size of an empty IPv4/UDP packet. This generates runt frames or
+ultra-small packets, which is useful for testing how a driver handles
+undersized frames and NIC padding logic.
+
+Normal packets (>= 42 bytes)
+   Full Ethernet/IPv4/UDP headers with checksum offloads.
+
+Runt frames (14-41 bytes)
+   Ethernet header with truncated or absent IPv4/UDP header.
+   Checksum offloads are automatically disabled.
+
+Ultra-small packets (< 14 bytes)
+   No standard headers; filled with a repeating pattern.
+   Checksum offloads are automatically disabled.
+
+Note that random split (``set txsplit rand``) and multi-flow
+(``set txonly-flows``) still require the first segment to hold the full
+Ethernet/IPv4/UDP header stack, so they cannot be combined with runt
+or ultra-small lengths.
+
 set txtimes
 ~~~~~~~~~~~
 
-- 
2.43.0

