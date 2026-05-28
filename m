Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893C2CD4F54
	for <dpdk-dev@archiver.kernel.org>; Thu, 28 May 2026 12:48:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 391454065D;
	Thu, 28 May 2026 14:48:15 +0200 (CEST)
Received: from fhigh-a6-smtp.messagingengine.com
 (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
 by mails.dpdk.org (Postfix) with ESMTP id 3E64C4042F
 for <dev@dpdk.org>; Thu, 28 May 2026 14:48:13 +0200 (CEST)
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
 by mailfhigh.phl.internal (Postfix) with ESMTP id B9BE81400048;
 Thu, 28 May 2026 08:48:12 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-06.internal (MEProxy); Thu, 28 May 2026 08:48:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1779972492; x=
 1780058892; bh=KNqAyCbm+udO/xzduLJ66RZ5TR3yYeRp/7ouA1hRcvE=; b=h
 sp7jIZ1VkBUTYjeyPdkkg7hziRawddj1g/QKsVAJSFu2sNwu/FPKu+iVM9SJFplB
 W2rY3UzaewCW9Ax/5ZkvAtYgdGsPc8i/RoLH2WWe2oExMHZPKn7lhuruKY6c5+QF
 sIWQV2HGRn7jSJ0SdDq0/40bop/vEu5uU1B43qqb0zM6LbujkDzSsDZvvhSHIs/H
 oqUTPhN8U3J1beYKWnyEg0lZt1u5df3fQ7CbnJOTKbKi9xgPG2G5pzTWn1h5JZIR
 sdWiPfDzjgPKc3hdMkjPQ2eOcFWZGxnb+x+owJxkCs8xoPBXZpAO5HabvFTtmqot
 YTDTC0wNGD9oRTdgsBGgg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1779972492; x=1780058892; bh=K
 NqAyCbm+udO/xzduLJ66RZ5TR3yYeRp/7ouA1hRcvE=; b=FW5v1ijKuxpFo9a0H
 D1OB/B2II3h6MRSK7KWuhtk/amUIXS/DVzE3wnIRG6EnpkJt9eXkzfAMb3VlxLsf
 Ku/KJJ2kWuL8L3CPMzqAw2ajVKMs2lW3O8lWgqa/pXpQ3VATLKkWHp/fCwKUdwaF
 am0Jl6F/NHo0F8RKvaH9WG4xoPl9yYfaHEmdsryr1ctpztSjK3Tz5H+YtTWajcmr
 fY5RRqih21jiqncHQR4+kThdOzJI9Z9JNAo8PxdZ8Y5ofBmeX8N6CV7Z4d0GfpjI
 fC36QVkq987dZnZ3lCKbkz/JcUBbF0Mvap9MwE9DWGaxAEizU89ax2B6zIVja+xs
 azFjQ==
X-ME-Sender: <xms:jDkYaok0IAGtu3x5-lHBSWbSMnRCKg1qTefNqxmEn47z_i2IW1OYEg>
 <xme:jDkYan_1xrCbcgvzjU46f7hrpRXg1sxDBND7v1s_NbDzHB0gtslrqpc_A2W_cM-3D
 SYVl2NKmfrFbT9afFOxTAgWaZ_Kgu-okl54Bl8mgbFHhmFyu_uQfqk>
X-ME-Received: <xmr:jDkYaumqLeYcdHE7TKysB4__c-tkWyu3Oc5DxV9ToQcx_1bQbGtLghnhZJ3Aqmk__fKVJgpBcNJ-Af5tUNAJfw5hPGXWIfk>
X-ME-Proxy-Cause: dmFkZTEFn7AQHI48n9AODvJpJqUxdk72sZf0QLbOirQK2oyoi+UcGmNWDkA8MQxq/UNVpS
 kxC5Io4+kU3Fbdr2iWwXxCfnXp+UEUJi+bqAIR0An7WYiX1o8NsYAUQ+pI7oK7Eon+l6Qc
 5smSvBkE8YwlgQX4htbges5IHO+VQGpWCeK47LL9uKaWZSkQ5SQ07Hb2BFZLFyK7uXMXjg
 a1gXgJJv4QvNCyHA6ug7ni4QQm0Rb3dKyMtJ29hsub5yqp48T7fXlGEH0ytXZYMruyvqZu
 mw8vrT/WMNUWiTcH4tjJGnAZ2M5JgoyGW1r2WTRcytlCKxhVBJsOOZMhAqWbv+aQjxKVN9
 RzEp31U4W6p+R3bEEti8HQjE+2ctbOlo6xes8zNhSJM1U0gkW6lFcJYkKdR279NrFbBto1
 70WOL9ev0k62SGZuQ2PluC3TVHTJa2DweHPN07aRho92uSvAiuoB//u1VAd37ymG5v2Ora
 eCbw7BPHlkUmYadRnbaMZ37SBA0xOkGL3uu0eQTW3+uGvntbiEKb1FdBYJPA2poO3oT0W3
 czXjjEc8/t9jG60Rr1ZCKfO/nE7klMZxzDPK2wxfd9QwN9TIJ56/HPWhANiBiplVKKn6FK
 rY/vC3iWUuIlcAgDsYb1S1M+sm1PAbCUbHawDOKNLBG1UQjrELW115/IsrsA
X-ME-Proxy: <xmx:jDkYas3b-QgSkM0RMgnSbveZjbQkEIFd65AvPIGBbjLLtEWC65XsjA>
 <xmx:jDkYahrSwiKEj8q3T2HYwHPTu7g4VRYD90w-ogl4hEns8vf92xAJJA>
 <xmx:jDkYahffzurxTbaTCI-6IYmo5TvkGr8nDkToxJ3FFjlPkmvHncwGkA>
 <xmx:jDkYaorc-B40txMT2hQpe3Ih35O1kDCsUGZDPymIznP8phMDbKTfBg>
 <xmx:jDkYapH8q7SoqXHut19Qdv2BiQWGwwDti76_midhL0hO755OYIdTWG-o>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 28 May 2026 08:48:11 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gregory Etelson <getelson@nvidia.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v3 03/10] app/testpmd: support selective Rx
Date: Thu, 28 May 2026 14:46:30 +0200
Message-ID: <20260528124758.1984528-4-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260528124758.1984528-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260528124758.1984528-1-thomas@monjalon.net>
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

