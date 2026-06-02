Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04CB2CD6E5D
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 21:41:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D0FAC40672;
	Tue,  2 Jun 2026 23:40:51 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 101954065C
 for <dev@dpdk.org>; Tue,  2 Jun 2026 23:40:50 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfout.stl.internal (Postfix) with ESMTP id 899DA1D000C0;
 Tue,  2 Jun 2026 17:40:49 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Tue, 02 Jun 2026 17:40:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780436449; x=
 1780522849; bh=KNqAyCbm+udO/xzduLJ66RZ5TR3yYeRp/7ouA1hRcvE=; b=h
 CzSfS74WNCcExc5HoQAV9m5QEgs3F9/SFtkWQWC9nCVL+lpeTLmqqFtww6SnsuUt
 yz3vGNDH1n4kIdpXLtz+sKdx/O839hyRrdtMh4S1+6G40MW2fvZ7uj4zC/8kmfoT
 0in0vvo3xkCrygdpLJrG9DIMKTA9n68it4VSa7XLktlKtb32qMBL3CfBq6N7d+gK
 mp54T84ApE7K51GnTIMuC83uDGddt3/i/4a4JB0t0uU+JbOU54ib7UHDLNx1369m
 QZvZcGcJvCuX7aNyjm0WucCakBJ46QroUrMeegppPxAldk3zicMFpLBQBJpw4FbA
 qzqLGF+PlPVYYm4chQUnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780436449; x=1780522849; bh=K
 NqAyCbm+udO/xzduLJ66RZ5TR3yYeRp/7ouA1hRcvE=; b=PcnH6EVoNhXloTC2a
 36VIPn79pq5RvAs/PoWMot+YdPx1b7D5RqZD4l4KRz4rROjUh8HSwI46ZiQ7A9jh
 bDHpec7AKmjf3I6a481Ac22iKJ7Z4kEOrfiz8GTSA4GPQxBvhpSK1Jko85aqAUAr
 ODKTeDeyoYUIO5c+ME6uPZVZ5hCsUxLMVuS/prFY9eBQ35dMrixYkRwhPL6y2zQ5
 fkrNbmHjD6z6TtKd6DN2/gIZZpCcf2lEeBoFQYquWTCrfI6tRJT9j5tkaY6+9a9h
 EDMRRDJr1UxM+qmkNbra0jDMvP+JiIfgnoouWkCTVqXzXJdJC9a7WOvfxy3Fub3/
 P1coQ==
X-ME-Sender: <xms:4U0fav5GcwE31vG6A2OjLqreo_AXQGYyOcFuXqeYblPrs5Rh43VESw>
 <xme:4U0falDvlvD2baSaQzVL2JzI3g0iNOrMBAT9wjf7fyfgd8ZBHQ8lxRUvqXpb-cWij
 gTyIrpx3bV11geK1xS1S-TEQXcE-xWoiMVE7e-8CZDFvfwG0uOw3g>
X-ME-Received: <xmr:4U0faubO2HZJ0DwF7eXe9IrUbMzF-zAizi6XyalqntfvQz0WEyAp_0nlVMlzGCQK_afHHeUlHwmgUOB7X6oqzsBuEJHOa3k>
X-ME-Proxy-Cause: dmFkZTGG5QG5Qo2LZmwXqqvuNNhi19An1/OHLJk+jOD2py8sn4MHJ4nPNbpF72I9jcWzu9
 VRXulbNmYCwD6P0ncbx/mcv4YJNui8c/fgayxuJKLu8KViRzeO3nUh6MWQLuXClMzS5Cj8
 rGYRxhOHw1xRA2LiD2IIw/+mInaTwnWkoindQu+nHp7U5jBZaN3J+BFQd3qCMFkOOO1Ca5
 nMIBjlMLIFzcLvRFfxIx3nkf72Y5pOksU189GTlSPd0bT1sX/nBi1/z0aUkYxn4GdUtn1h
 5Qya9RZnaklBolACp5VLIPUz1oq85G1wGWWORjSm0JoyS9m/5i4wZtp1BhN6MlMw37Ebdb
 RYIgPV8gURg43ZVkUg8ydhCxzhq1Em+kvSLo/GGLd+saWpw2zBK262D/d6SmMe3fSN7YLk
 sqWItU5IgfQFTU2kyQ14R67ZjcOo5LO3DcGCUoCkae5+n1vL5cYKZ4n82qbvqX9LuYdyPw
 G6mG2FJZ7iMe0+RBvg4nN0ReHdD5R62EcO4iag6wvbQU/zZlXMPPBS9B7n9+ZOJhabrQpw
 geSxHyqtN98R/bf7HdGWCOVyFCzASIwv9hKq+BINftInnRcDTZsTy+8LqUWl72bQtREwS8
 V1jhMdXPX8YbvQRhfTkP5UeXSDBeIZeOtCfkBGyp0DZe4uE+3AvVBJLtPpaA
X-ME-Proxy: <xmx:4U0faoZ8afehkyMhgGWDZZV13mZazgjuYLpFOT5uP-reLtWb9VZVpA>
 <xmx:4U0fat92PIvz2a3KrGBEd0eL9osVgtEMrpGis7L8wfppaiBJIVhqew>
 <xmx:4U0favgEP2ymIkJtXiXizWnC7PiE4UKhmGBLDtoMuezjOtJo6w5Jzw>
 <xmx:4U0falcjLQfdT7z6BbZSfC9htdp3gCZxaWv2P_BJh6G6Xg9aJA5Nsg>
 <xmx:4U0faqdTlP3YnxSt--GevDI3Eahx34WUbU0XRho7CzZLD-H4wl55wDPy>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 17:40:48 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gregory Etelson <getelson@nvidia.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v5 03/10] app/testpmd: support selective Rx
Date: Tue,  2 Jun 2026 23:38:34 +0200
Message-ID: <20260602214036.3606359-4-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602214036.3606359-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260602214036.3606359-1-thomas@monjalon.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Gregory Etelson <getelson@nvidia.com>

Add support for selective Rx using existing rxoffs and rxpkts
command line parameters.

When both rxoffs and rxpkts are specified
on PMDs supporting selective Rx, testpmd automatically:
1. Inserts segments with NULL mempool
   for gaps between configured segments to discard unwanted data.
2. Adds a trailing segment with NULL mempool
   to cover any remaining data up to the max packet length.

Example usage to receive only Ethernet header and a segment at offset 128:

  --rxoffs=0,128 --rxpkts=14,64

This creates segments:
- [0-13]: 14 bytes with mempool (received)
- [14-127]: 114 bytes with NULL mempool (discarded)
- [128-191]: 64 bytes with mempool (received)
- [192-max]: remaining bytes with NULL mempool (discarded)

Note: RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT is required for this feature
and is checked at ethdev API level.
This check is removed from testpmd to allow negative testing of the API.

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
---
 app/test-pmd/testpmd.c                | 71 ++++++++++++++++++++++-----
 doc/guides/testpmd_app_ug/run_app.rst | 20 ++++++++
 2 files changed, 80 insertions(+), 11 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index a9b35f530a..d14341d3ff 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -2731,6 +2731,16 @@ port_is_started(portid_t port_id)
 	return 1;
 }
 
+static struct rte_eth_rxseg_split *
+next_rx_seg(union rte_eth_rxseg *segs, uint16_t *idx)
+{
+	if (*idx >= MAX_SEGS_BUFFER_SPLIT) {
+		fprintf(stderr, "Too many segments (max %u)\n", MAX_SEGS_BUFFER_SPLIT);
+		return NULL;
+	}
+	return &segs[(*idx)++].split;
+}
+
 /* Configure the Rx with optional split. */
 int
 rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
@@ -2744,31 +2754,70 @@ rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 	uint32_t prev_hdrs = 0;
 	int ret;
 
-	if ((rx_pkt_nb_segs > 1) &&
-	    (rx_conf->offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT)) {
+	if (rx_pkt_nb_segs > 1 || rx_pkt_nb_offs > 0) {
+		struct rte_eth_dev_info dev_info;
+		uint16_t seg_idx = 0;
+		uint16_t next_offset = 0;
+
+		ret = rte_eth_dev_info_get(port_id, &dev_info);
+		if (ret != 0)
+			return ret;
+
 		/* multi-segment configuration */
 		for (i = 0; i < rx_pkt_nb_segs; i++) {
-			struct rte_eth_rxseg_split *rx_seg = &rx_useg[i].split;
-			/*
-			 * Use last valid pool for the segments with number
-			 * exceeding the pool index.
-			 */
+			struct rte_eth_rxseg_split *rx_seg;
+			uint16_t seg_offset;
+
+			if (i < rx_pkt_nb_offs)
+				seg_offset = rx_pkt_seg_offsets[i];
+			else
+				seg_offset = rx_pkt_nb_offs > 0 ? next_offset : 0;
+
+			/* Insert selective Rx discard segment if there's a gap */
+			if (seg_offset > next_offset) {
+				rx_seg = next_rx_seg(rx_useg, &seg_idx);
+				if (rx_seg == NULL)
+					return -EINVAL;
+				rx_seg->offset = next_offset;
+				rx_seg->length = seg_offset - next_offset;
+				rx_seg->mp = NULL;
+				next_offset = seg_offset;
+			}
+
+			rx_seg = next_rx_seg(rx_useg, &seg_idx);
+			if (rx_seg == NULL)
+				return -EINVAL;
 			mp_n = (i >= mbuf_data_size_n) ? mbuf_data_size_n - 1 : i;
 			mpx = mbuf_pool_find(socket_id, mp_n);
-			/* Handle zero as mbuf data buffer size. */
-			rx_seg->offset = i < rx_pkt_nb_offs ?
-					   rx_pkt_seg_offsets[i] : 0;
+			rx_seg->offset = seg_offset;
 			rx_seg->mp = mpx ? mpx : mp;
 			if (rx_pkt_hdr_protos[i] != 0 && rx_pkt_seg_lengths[i] == 0) {
 				rx_seg->proto_hdr = rx_pkt_hdr_protos[i] & ~prev_hdrs;
 				prev_hdrs |= rx_seg->proto_hdr;
+			} else if (rx_pkt_nb_offs > 0 && rx_pkt_seg_lengths[i] == 0) {
+				/* Insert fake discard segment if explicitly requested */
+				rx_seg->mp = NULL;
+				rx_seg->length = 0;
 			} else {
 				rx_seg->length = rx_pkt_seg_lengths[i] ?
 						rx_pkt_seg_lengths[i] :
 						mbuf_data_size[mp_n];
 			}
+
+			next_offset = seg_offset + rx_seg->length;
 		}
-		rx_conf->rx_nseg = rx_pkt_nb_segs;
+
+		/* Add trailing selective Rx discard segment up to max packet length */
+		if (rx_pkt_nb_offs > 0 && next_offset < dev_info.max_rx_pktlen) {
+			struct rte_eth_rxseg_split *rx_seg = next_rx_seg(rx_useg, &seg_idx);
+			if (rx_seg == NULL)
+				return -EINVAL;
+			rx_seg->offset = next_offset;
+			rx_seg->length = dev_info.max_rx_pktlen - next_offset;
+			rx_seg->mp = NULL;
+		}
+
+		rx_conf->rx_nseg = seg_idx;
 		rx_conf->rx_seg = rx_useg;
 		rx_conf->rx_mempools = NULL;
 		rx_conf->rx_nmempool = 0;
diff --git a/doc/guides/testpmd_app_ug/run_app.rst b/doc/guides/testpmd_app_ug/run_app.rst
index 1a4a4b6c12..b59991ed89 100644
--- a/doc/guides/testpmd_app_ug/run_app.rst
+++ b/doc/guides/testpmd_app_ug/run_app.rst
@@ -364,6 +364,11 @@ The command line options are:
     feature is engaged. Affects only the queues configured
     with split offloads (currently BUFFER_SPLIT is supported only).
 
+    When used with ``--rxpkts`` on PMDs supporting selective Rx,
+    enables receiving only specific packet segments and discarding the rest.
+    Gaps between configured segments and any trailing data up to the max packet length
+    are automatically filled with NULL mempool segments (data is discarded).
+
 *   ``--rxpkts=X[,Y]``
 
     Set the length of segments to scatter packets on receiving if split
@@ -373,6 +378,21 @@ The command line options are:
     command line parameter and the mbufs to receive will be allocated
     sequentially from these extra memory pools.
 
+    Note: ``--rxoffs`` is required to enable selective Rx in testpmd.
+    To receive only the first N bytes, use ``--rxoffs=0 --rxpkts=N``.
+
+    To receive only the Ethernet header (14 bytes at offset 0) and
+    a 64-byte segment starting at offset 128, while discarding the rest::
+
+       --rxoffs=0,128 --rxpkts=14,64
+
+    This configuration will:
+
+    * Receive 14 bytes at offset 0 (Ethernet header)
+    * Discard bytes 14-127 (inserted NULL mempool segment)
+    * Receive 64 bytes at offset 128
+    * Discard remaining bytes (inserted NULL mempool segment)
+
 *   ``--txpkts=X[,Y]``
 
     Set TX segment sizes or total packet length. Valid for ``tx-only``
-- 
2.54.0

