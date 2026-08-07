Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 007A3C5AC7A
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Aug 2026 06:17:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9B8A402D1;
	Fri,  7 Aug 2026 08:17:34 +0200 (CEST)
Received: from canpmsgout09.his.huawei.com (canpmsgout09.his.huawei.com
 [113.46.200.224])
 by mails.dpdk.org (Postfix) with ESMTP id 58BD7402B6
 for <dev@dpdk.org>; Fri,  7 Aug 2026 08:17:33 +0200 (CEST)
dkim-signature: v=1; a=rsa-sha256; d=h-partners.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=bpucSEX0HaDd53b3008E/mdreyWfmGTOQbVXKp4NkUY=;
 b=QjF7PnL7GIEea5XSMfscpfsxymEXGNDDmQ0rpTUaYo2777Hz65F7xMkkmoWxG7VmNAuvuXzTo
 j1dlzXEyesT1BHltnTAd5hhFkKDmtWoK9ZTtiVcpm2F3Db/j5d3mxq4kNY5n/WCBQgyjrSqf36n
 IYv0EhDWDYTouSRuyRNIBUY=
Received: from mail.maildlp.com (unknown [172.19.163.127])
 by canpmsgout09.his.huawei.com (SkyGuard) with ESMTPS id 4hGYZR1SYXz1cyQ2;
 Fri,  7 Aug 2026 14:06:55 +0800 (CST)
Received: from kwepemp200007.china.huawei.com (unknown [7.202.195.46])
 by mail.maildlp.com (Postfix) with ESMTPS id 3CC9F402AB;
 Fri,  7 Aug 2026 14:17:28 +0800 (CST)
Received: from kwepemp500015.china.huawei.com (7.202.195.9) by
 kwepemp200007.china.huawei.com (7.202.195.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 14:17:27 +0800
Received: from localhost.localdomain (10.50.163.32) by
 kwepemp500015.china.huawei.com (7.202.195.9) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.45; Fri, 7 Aug 2026 14:17:27 +0800
From: Xingui Yang <yangxingui@huawei.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <david.marchand@redhat.com>,
 <aman.deep.singh@intel.com>, <fengchengwen@huawei.com>,
 <lihuisong@huawei.com>, <liuyonglong@huawei.com>, <kangfenglong@huawei.com>
Subject: [PATCH v4] app/testpmd: support runt frames in txonly
Date: Fri, 7 Aug 2026 14:17:27 +0800
Message-ID: <20260807061727.1687254-1-yangxingui@huawei.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 kwepemp500015.china.huawei.com (7.202.195.9)
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

Allow setting transmit size to be a small value which has Ethernet
header but no IP or UDP header, since control level protocols can be
very short.

Checksum offloads are disabled when headers are incomplete.
copy_buf_to_pkt_segs stops at the last segment to prevent OOB access.

Suggested-by: Stephen Hemminger <stephen@networkplumber.org>
Signed-off-by: Xingui Yang <yangxingui@huawei.com>
---
Changes in v4:
- Removed ultra-small frame support (< 14 bytes) per Stephen's review.
---
 app/test-pmd/config.c                       | 13 ++++----
 app/test-pmd/txonly.c                       | 36 +++++++++++++++++++--
 doc/guides/rel_notes/release_26_11.rst      |  7 ++++
 doc/guides/testpmd_app_ug/testpmd_funcs.rst | 11 +++++++
 4 files changed, 58 insertions(+), 9 deletions(-)

diff --git a/app/test-pmd/config.c b/app/test-pmd/config.c
index aa03eb99cc..86c794b923 100644
--- a/app/test-pmd/config.c
+++ b/app/test-pmd/config.c
@@ -6333,9 +6333,8 @@ set_tx_pkt_segments(unsigned int *seg_lengths, unsigned int nb_segs)
 	/*
 	 * Check that each segment length is greater or equal than
 	 * the mbuf data size.
-	 * Check also that the total packet length is greater or equal than the
-	 * size of an empty UDP/IP packet (sizeof(struct rte_ether_hdr) +
-	 * 20 + 8).
+	 * The total packet length must be at least the size of an
+	 * Ethernet header.
 	 */
 	tx_pkt_len = 0;
 	for (i = 0; i < nb_segs; i++) {
@@ -6347,10 +6346,10 @@ set_tx_pkt_segments(unsigned int *seg_lengths, unsigned int nb_segs)
 		}
 		tx_pkt_len = (uint16_t)(tx_pkt_len + seg_lengths[i]);
 	}
-	if (tx_pkt_len < (sizeof(struct rte_ether_hdr) + 20 + 8)) {
-		fprintf(stderr, "total packet length=%u < %d - give up\n",
-				(unsigned) tx_pkt_len,
-				(int)(sizeof(struct rte_ether_hdr) + 20 + 8));
+	if (tx_pkt_len < sizeof(struct rte_ether_hdr)) {
+		fprintf(stderr, "total packet length=%u < %zu - give up\n",
+				(unsigned int) tx_pkt_len,
+				sizeof(struct rte_ether_hdr));
 		return;
 	}
 
diff --git a/app/test-pmd/txonly.c b/app/test-pmd/txonly.c
index a4acb85d29..e90e28a6e6 100644
--- a/app/test-pmd/txonly.c
+++ b/app/test-pmd/txonly.c
@@ -76,6 +76,12 @@ copy_buf_to_pkt_segs(void* buf, unsigned len, struct rte_mbuf *pkt,
 	while (offset >= seg->data_len) {
 		offset -= seg->data_len;
 		seg = seg->next;
+		/*
+		 * The packet may be shorter than the header stack when
+		 * generating runt frames, stop once it runs out of segments.
+		 */
+		if (seg == NULL)
+			return;
 	}
 	copy_len = seg->data_len - offset;
 	seg_buf = rte_pktmbuf_mtod_offset(seg, char *, offset);
@@ -84,6 +90,8 @@ copy_buf_to_pkt_segs(void* buf, unsigned len, struct rte_mbuf *pkt,
 		len -= copy_len;
 		buf = ((char*) buf + copy_len);
 		seg = seg->next;
+		if (seg == NULL)
+			return;
 		seg_buf = rte_pktmbuf_mtod(seg, char *);
 		copy_len = seg->data_len;
 	}
@@ -193,7 +201,6 @@ pkt_burst_prepare(struct rte_mbuf *pkt, struct rte_mempool *mbp,
 	pkt->vlan_tci = vlan_tci;
 	pkt->vlan_tci_outer = vlan_tci_outer;
 	pkt->l2_len = sizeof(struct rte_ether_hdr);
-	pkt->l3_len = sizeof(struct rte_ipv4_hdr);
 
 	pkt_len = pkt->data_len;
 	pkt_seg = pkt;
@@ -204,6 +211,25 @@ pkt_burst_prepare(struct rte_mbuf *pkt, struct rte_mempool *mbp,
 		pkt_len += pkt_seg->data_len;
 	}
 	pkt_seg->next = NULL; /* Last segment of packet. */
+
+	/*
+	 * A runt frame may be too short to carry a full IPv4/UDP header.
+	 * Clamp l3_len and drop any checksum offload whose header is not
+	 * fully present, so the PMD is never asked to checksum bytes that
+	 * are not in the frame. pkt_len is at least sizeof(struct rte_ether_hdr),
+	 * so the subtraction below cannot underflow.
+	 */
+	pkt->l3_len = RTE_MIN(sizeof(struct rte_ipv4_hdr),
+			pkt_len - sizeof(struct rte_ether_hdr));
+	if (pkt_len < sizeof(struct rte_ether_hdr) +
+			sizeof(struct rte_ipv4_hdr))
+		pkt->ol_flags &= ~(RTE_MBUF_F_TX_IP_CKSUM |
+				RTE_MBUF_F_TX_L4_MASK);
+	else if (pkt_len < sizeof(struct rte_ether_hdr) +
+			sizeof(struct rte_ipv4_hdr) +
+			sizeof(struct rte_udp_hdr))
+		pkt->ol_flags &= ~RTE_MBUF_F_TX_L4_MASK;
+
 	/*
 	 * Copy headers in first packet segment(s).
 	 */
@@ -405,7 +431,13 @@ tx_only_begin(portid_t pi)
 	pkt_hdr_len = (uint16_t)(sizeof(struct rte_ether_hdr) +
 				 sizeof(struct rte_ipv4_hdr) +
 				 sizeof(struct rte_udp_hdr));
-	pkt_data_len = tx_pkt_length - pkt_hdr_len;
+	/*
+	 * tx_pkt_length may be smaller than the full header stack when
+	 * generating runt frames, clamp the payload length to zero in
+	 * that case so the IP/UDP length fields stay sane.
+	 */
+	pkt_data_len = tx_pkt_length > pkt_hdr_len ?
+			tx_pkt_length - pkt_hdr_len : 0;
 
 	if ((tx_pkt_split == TX_PKT_SPLIT_RND || txonly_multi_flow) &&
 	    tx_pkt_seg_lengths[0] < pkt_hdr_len) {
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..577b892d57 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,13 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Updated testpmd application.**
+
+  Added support for runt frames in txonly mode. The minimum packet
+  length for ``set txpkts`` is relaxed to the Ethernet header size,
+  since control level protocols can be very short. Checksum offloads
+  are automatically disabled when headers are incomplete.
+
 
 Removed Items
 -------------
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index e65376df54..0edcdd8444 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -874,6 +874,17 @@ Set the length of each segment of the TX-ONLY packets or length of packet for FL
 
 Where x[,y]* represents a CSV list of values, without white space.
 
+The total packet length may be set as small as the Ethernet header
+(``sizeof(struct rte_ether_hdr)``), since control level protocols can
+be very short. This generates runt frames with truncated IPv4/UDP
+headers. Checksum offloads are automatically disabled when the
+corresponding header is not fully present.
+
+Note that random split (``set txsplit rand``) and multi-flow
+(``set txonly-flows``) still require the first segment to hold the full
+Ethernet/IPv4/UDP header stack, so they cannot be combined with runt
+lengths.
+
 set txtimes
 ~~~~~~~~~~~
 
-- 
2.43.0

