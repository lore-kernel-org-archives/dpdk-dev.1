Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56892CD6E4A
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 13:35:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BACC2402EE;
	Fri, 29 May 2026 15:35:37 +0200 (CEST)
Received: from fhigh-b8-smtp.messagingengine.com
 (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
 by mails.dpdk.org (Postfix) with ESMTP id B3F6940651
 for <dev@dpdk.org>; Fri, 29 May 2026 15:35:35 +0200 (CEST)
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 369247A00C2;
 Fri, 29 May 2026 09:35:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-03.internal (MEProxy); Fri, 29 May 2026 09:35:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm3; t=1780061735; x=
 1780148135; bh=KNqAyCbm+udO/xzduLJ66RZ5TR3yYeRp/7ouA1hRcvE=; b=J
 pbpxyI8SQ5h7DeWN2lPCZkPnZ0DdiOMicLVM/s76HeZhpxNOMd3ytKlpkgZMsnRQ
 j6SlA/PSE7KSli61H7tVkmkjYr0pTS2ktnJDg3pieHFS66CkkDnM236xw06zutox
 2xtS9vN9wrrrRvrE9FFnw4AlLbbk154EX1Kd1fuWOdAtIHohBuMMghv9KaxMMJ3l
 kpjzaRRdekhICg45Ru1E0jEeHAwoAwONq1GM/Fip++jVEC099KoRgdrzvrQ6WkA0
 PipoLAaq/j4sPqhfQXs9V+WbmLQmHBteEJW9QvxtqJrAWOSpUU+gPl1649jx0sGs
 07riFPWcRm7xA+CFKc6+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm3; t=1780061735; x=1780148135; bh=K
 NqAyCbm+udO/xzduLJ66RZ5TR3yYeRp/7ouA1hRcvE=; b=LlF/bf0pjM2QuNP68
 lRHZmF3sC1YzEbJBKsFpbxyPitqvr7FtjGbNBqGDYBcITi6Z534fULJRjlWNLeTf
 Ly/dmS8wBDmJsYro1bRy63ufPKZkmylIpGCjtAQPRsQTVvOvxFGsqsjq4BSJl7Qg
 0OGJLN4fBJm7aJPCreLr8PGWphrB/Z1DRHH8CqmVTD78OsRjAsOcZp7CxtwfCFF5
 3xp6y+NT3OizAR4ZsEtYMNeMcyRnPGNcID7aU5DDzLHIxIRUowZIX+1Yo/4hXDTl
 0HGm8sm0l2kIAxS9HvSA3/THUhGXAFTAV8QNuP9WslMZTiqpu+O1xwhQnE6I3tWK
 dqgnA==
X-ME-Sender: <xms:J5YZaub6ofnN6MzUc3N2XltEqQ4Gn_ZLgYvk-HMm4KHyuFPib0pssQ>
 <xme:J5YZahj5-5tz-ZVF6htKOTH1CfpxAOYaykK8Af1c0fslp4fwTZBu4XdfOqPUEaXI6
 FhNIjInvbhpK__gyM47CuG0uuiK1T5rQN_rF3HzNOyN-OPowRNltQ>
X-ME-Received: <xmr:J5YZag6pB6wMk_fiG4uIEDOmIbr6CccVlLkXbLYJBGMGDcfbJll20IY0cnKKugJsPWaQ86FaZBjI0OPz574js045vRjrjGE>
X-ME-Proxy-Cause: dmFkZTEk/7PqDlJdl6ckDo/S+y1UlGhUOsoYVeyQ6cppvl2Bugt8YwlEDeJUlkckDpKtn9
 zObDwCSCodpgk4qzP2geVzjoc9IMYKZ2+ew171m1n632KSRTNVsRETqA5I198x6wdFBS8Q
 GAt3T2B0yjs/hxhf4KPqm+gcClmRV55UrZxPPOf1rKKjcrpl0BBIKq1IC7o2RxApmLP5QF
 E5YItMy747P7FPeJNOvEoxomzOSflmh/Oyaop98SXTJQP/8t3O1s3IEkZcNBjrN6DAEdmT
 r9TixXZQs7g7WmJRJwlRrkqnwObicRLZ/SSgOQj1f+LHSfn1maID32hX+mbS4RZOC+GaEg
 CWA4W0M5RWjNw//hS+nIh0+dctrU8iQ4QrUMKfd8d+HzAYaqCYAqSOTQno6WpNPGIWRvhP
 kxmkXXYeI2Y8Dv52b8DZWnpCAcxyeCLwp15fNagBPkqT0BUSWQfSLp6Q0nfcI7XJmjR3LA
 ro8XOuXLFS+i7IkxgLiuwzqXLtyf1PL3YiEMh9QFhcgn+Mj9t4YNwcLDkCaOuOfTBeV+gy
 v3s3kYT3y+N+KGxMLPovHdIT2BD1YtGBO0llDFmGkTAHFKNkbisoOaJ11pDCxecMfiRCHa
 85GMkIr/+595J7t00iFRskkFRPi+k6WVrLswolmSz83sbzJm+GMDvKZimb2A
X-ME-Proxy: <xmx:J5YZao5PPIGw04YwoG6ErGGHE8a_XWhkCq--C0gw6Jt-hBf6qmLc7w>
 <xmx:J5YZakeB-R7YAC2bft54M3vbheSPcUqlgUQEokjephYd_ZkqRhsHFA>
 <xmx:J5YZakDj9fKvtAOt8sk5C3TqEO6nGYVVQgeAws1MPdCm5cH1-WUrrA>
 <xmx:J5YZav93HglRwmNu16qRisY-EqEhvAIApkoLrOzdNbMq8vKjnoqpjA>
 <xmx:J5YZai8A0dyFtA1fzXAJ5bC2udjfToYW7ZbD08qZojJuGmh8p3Nmub5Z>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 29 May 2026 09:35:34 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gregory Etelson <getelson@nvidia.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v4 03/10] app/testpmd: support selective Rx
Date: Fri, 29 May 2026 15:33:57 +0200
Message-ID: <20260529133522.2646044-4-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260529133522.2646044-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260529133522.2646044-1-thomas@monjalon.net>
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

