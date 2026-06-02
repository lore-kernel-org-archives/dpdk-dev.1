Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB914CD6E5D
	for <dpdk-dev@archiver.kernel.org>; Tue,  2 Jun 2026 21:50:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8435640685;
	Tue,  2 Jun 2026 23:50:41 +0200 (CEST)
Received: from fout-b2-smtp.messagingengine.com
 (fout-b2-smtp.messagingengine.com [202.12.124.145])
 by mails.dpdk.org (Postfix) with ESMTP id 5C0B240678
 for <dev@dpdk.org>; Tue,  2 Jun 2026 23:50:39 +0200 (CEST)
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id CF4781D0006B;
 Tue,  2 Jun 2026 17:50:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Tue, 02 Jun 2026 17:50:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780437038; x=
 1780523438; bh=KNqAyCbm+udO/xzduLJ66RZ5TR3yYeRp/7ouA1hRcvE=; b=M
 wVXxXOAFvIQVYk28f8c2kz9HyCV3HyGDw6fMN45R3Y+s6YxcksqbwbsUpdjLiQ5a
 kMJqYAO45h6j+XIIXYQI/7oG1WI58fNtQjYL+Gxud4UvShbLm363xPxVmpExYtv9
 lrrKIsRgxs20i9RP0fmaJ/TvKOeqd5bsfyEyhnx1VSM791ybR6vRsEf/NTkMLx2s
 Jt/h0/VKeS7+xCq6OYFfZXeMeurIRYe+faUXECrTmnO5dWEE1QRRP4vb2TJYLD2P
 m0/rm1b+M+6OMJBDl3vc9d9ennNh12nzRn9961RLd3kfu0/H7skkDl8gFeY5SRX/
 xtajpJIS4loMX94Trr0pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780437038; x=1780523438; bh=K
 NqAyCbm+udO/xzduLJ66RZ5TR3yYeRp/7ouA1hRcvE=; b=cU+9vDrAL7gKnB/Oe
 1v5OAr+ZkNF0YZnpW6L3p8I3J4dOQSfoEHKQNCH2vmBPC4b4buRhzGd59wWDk+1s
 RDtsBW+E3i5t1wES9mzpH4wYq3OaMu8ze9CpFMu6OWi7ZlfTuPTjah+9GnSygz7h
 N9RmP4K8UmKEqa/0fQOEzUiZCqPG6wc/vt8B0vtub82ocHsbLshvLuCT3/OQZGyz
 3hhoCCjStqH7YiVrZcl2CFJuLtAs3SPw4brQHo5vxuvAgRppYSdY6qFAYdWycl0I
 +eKH64Luf5uw4v+DA1Q7xN4UZzPM4hLa+nf/jiRlZUqA7Hzo73W32ZmD3DoNXAWk
 jB3VA==
X-ME-Sender: <xms:LlAfajLEZXEShAJAy4ILqbeFyrD9eZop3ysEkgQsDUoHKJ7fR-8omg>
 <xme:LlAfanT2QvscgdkpgScUwNPywlpq5WHn6FpM3XtpTRSfmD4uh0ZKrZ2odrQwxvnyK
 2gz6VGTuEu7RNC1LVXLBFcVx91sfoW5S65Hmbo1Uwja-j3rvW6oPQ>
X-ME-Received: <xmr:LlAfajoxsl2FU9qDb4jBb_eNhWYCzv3Vvm0W-17MRo2ReeADYjeu_u9AwlMDIV8_D_dXQnn7NBNIf9xcXeF3vngHlQ8xJww>
X-ME-Proxy-Cause: dmFkZTGLViGudKsDyOQu7nlm3XZoPyesT9J8ZxOjQv8yq/MS1wAtj7j/V43Ic8lLIHpkM6
 u24csRGGOkjs/xNroLPu8HoNMq3e+8KP1NdqdSASIoO1axjHcjiZOnVqcJ07F1Hjk3y36h
 cOeSppG+igu2yT5H7V4wx+FFyjv+hJThrxxIWnTfg+f53qnusY+JeNkBxIBphEIWRawUW8
 ZOckHyfoXvSira7ocBEEgW0JlZI/VwLw1KxI16ukL54AOtHUKBt6rrwo13xrAhPxd4duBh
 nuMJPl5ZZJ3y7Z1atoozu4BpCMZ49HNleOgNEFAuqdsKfKkox402xD1lavnWn5WRw4/fGL
 Pa3p6sJIA6/z8dnIqoeEOT6J6e9HJy2gZRwzX88SfONumpaqQNEeSaSRjUb+/VZK0w3YyG
 z7Mg3OsyBhHEJsehHPBhPy4WxIWJTVqqeP54U1vu/zlr+bxhTr8bqm6emF2783ZU4IDoCz
 OLkhwKkFKX1hjkmBbZse8Jbk3Xj4v39whhWB2awCklZxSQPRtkLqa0tDtHa+uk2nnHmfV2
 5q33UbxNRp/0DJa7xPnee2mlWR9Z8oSJgBqschyE2HhYU3Tw5YTCTXrAgSGayCuHygwlfL
 hgSCbVRGb6K+HQhq3aSLdJvpfoUtGHZJuTyQvRe/AaRjC2c+Ie8Thq+ydA5Q
X-ME-Proxy: <xmx:LlAfakrSvw0HlSPMC_FrW1jT7Y-OTjtJRgIc32izfXdHQLGSxQL36A>
 <xmx:LlAfalMTvaeQcLYSE8DUDBagNzMDYmbbSodb20P_kU6np1n916BHcg>
 <xmx:LlAfalzage6GEkhMfsx4FiI9esQjS6lelIRDBZkfsIa4-8ybsyGqbA>
 <xmx:LlAfauvWiflDcVSnAgX_MZMOIR9-LyMTaYjXAq4XfjVujNyOnJBJHA>
 <xmx:LlAfahJrI2MZbdGnNgTzPtO36nWXCFW-pLsB3J1uYMQBRj8FhBlO13js>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Jun 2026 17:50:37 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gregory Etelson <getelson@nvidia.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v6 03/10] app/testpmd: support selective Rx
Date: Tue,  2 Jun 2026 23:49:15 +0200
Message-ID: <20260602215022.3698662-4-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260602215022.3698662-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260602215022.3698662-1-thomas@monjalon.net>
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

