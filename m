Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F003CD37B2
	for <dpdk-dev@archiver.kernel.org>; Sat,  9 May 2026 22:04:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7440540649;
	Sun, 10 May 2026 00:04:31 +0200 (CEST)
Received: from fhigh-b6-smtp.messagingengine.com
 (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
 by mails.dpdk.org (Postfix) with ESMTP id 379DA40649
 for <dev@dpdk.org>; Sun, 10 May 2026 00:04:30 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 9B71A7A0062;
 Sat,  9 May 2026 18:04:29 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-03.internal (MEProxy); Sat, 09 May 2026 18:04:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1778364269; x=
 1778450669; bh=PkRRc7Zh9FRnqX+hHUS8YriQYqeut2F/0LmG5IjGgXQ=; b=b
 67LxpXbecdjbLQ+mONilS+aoBEGObGrEmBZZ+ZAaclPIuiUaTCAT0H2IpWTVLtj/
 1nhEwgNOf0kSZpjcc4a6YJpLvDekhTKjYWzuZl/DcSdhuILTZpqZ7hqsJYxvisG3
 qrAUg0dg5IaL1hC/kyUqTkEj88TmHRAfb0w72y2p03/am8td0jefaeAK0HlSWOex
 ZdainDbylc9a2RonVPxR76Za9aT4mX02Qdx7xel79zmi2BID1mQvLkrsqUEexgiQ
 DxTkbcOE9vYuTWoppl+sATXKFgXpw/5GqtK830yWeqZI4D0oUr8UvJJu9V4fw3f2
 3knl7ANag1fLSLbDSUWSQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1778364269; x=1778450669; bh=P
 kRRc7Zh9FRnqX+hHUS8YriQYqeut2F/0LmG5IjGgXQ=; b=Zk6SlSvCEdd2bokwH
 AyGMLwAtg1Qs89XwzwK8CIPUwG/o9Jv0HhpqhE9Z7BkHbP85HPKV9H0RJICRz47s
 tF2agXg8vyRMvILyUs180f44xr86k1fmF27/kkQwSVaXp++qZSznFey3QM4rAAfe
 RUBpGpksEsyf/gZJtnrDmmexRmnyjY11l7CQnTKQNpGQeKJC96LiR1S0IBmjAxoU
 L+k3BzGN6JWu7GT0Z933R2iJqeF2FuVp0nTJh8YfElS3ZNcjPWkXUX3Gb1SWqUs0
 wE1BlZEUu1fXsPleHTgIySqtXuIQ+WQ2GcQoOs4o5mOGmX9uskE9ZJbvg99giezO
 WH9DQ==
X-ME-Sender: <xms:ba__aWGpQxdrAu1f3vMMAxyRuqKjOGnhquqRmkvoT2Il0do607o0ow>
 <xme:ba__aXfF-f_7nv1qrCQp6-whFcNK37DPpSqOtgwe3T0jt1_GYDfplsPA93dPJqfAL
 KIhrn1CnjIqaek_pd_XVpO26aWv8Za2lUkGCP4wfggToFjnccH4zg>
X-ME-Received: <xmr:ba__aYEHSQ7arZ7lQpPtXNWvnwG6tskSdcGVIOm6PFX87z5aVAceRdYjBlvvNjy8G2WZlle_i1DFHu7qoDSpRE78063CCqo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdduudegfeekucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepvfhhohhmrghs
 ucfoohhnjhgrlhhonhcuoehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtqeenucggtf
 frrghtthgvrhhnpedvjefhudeghedvtdeijeeigeetuedugfejueekieeltdfhteevkeeh
 hfeilefhtdenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
 hmpehthhhomhgrshesmhhonhhjrghlohhnrdhnvghtpdhnsggprhgtphhtthhopeegpdhm
 ohguvgepshhmthhpohhuthdprhgtphhtthhopeguvghvseguphgukhdrohhrghdprhgtph
 htthhopehsthgvphhhvghnsehnvghtfihorhhkphhluhhmsggvrhdrohhrghdprhgtphht
 thhopehgvghtvghlshhonhesnhhvihguihgrrdgtohhmpdhrtghpthhtoheprghmrghnrd
 guvggvphdrshhinhhghhesihhnthgvlhdrtghomh
X-ME-Proxy: <xmx:ba__aYXY8N0HvraYjqg1quMzbt6vj1z-8bBz5C4RMbth023tglQe1A>
 <xmx:ba__aXK8mUD5fWLys4lcFWYORn5CqUu426WsHAN8IG7Rof0jff3R3w>
 <xmx:ba__aY-2-w7JAT_t442qoitZYUSPOXhHu0Q4KtXE6Zog71ZQm4M9cA>
 <xmx:ba__aaJqRoJIdb3LszW15HTcxgV34l-gE05ozXoaoBob29E4H6g6DA>
 <xmx:ba__aakNn-cHrSSMy71ryzxnrNO26Jr3l2_j52ia1y7fXpwsiLy-RO3o>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 9 May 2026 18:04:28 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gregory Etelson <getelson@nvidia.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v2 03/10] app/testpmd: support selective Rx
Date: Sat,  9 May 2026 23:56:54 +0200
Message-ID: <20260509220356.3679114-4-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260509220356.3679114-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260509220356.3679114-1-thomas@monjalon.net>
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
 app/test-pmd/testpmd.c                | 69 ++++++++++++++++++++++-----
 doc/guides/testpmd_app_ug/run_app.rst | 20 ++++++++
 2 files changed, 78 insertions(+), 11 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index e2569d9e30..3ddcfee654 100644
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
@@ -2744,31 +2754,68 @@ rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
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
+			seg_offset = i < rx_pkt_nb_offs ?
+				     rx_pkt_seg_offsets[i] : next_offset;
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

