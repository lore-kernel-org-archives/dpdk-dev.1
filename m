Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49947CD6E6E
	for <dpdk-dev@archiver.kernel.org>; Thu,  4 Jun 2026 19:33:51 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 63F6640677;
	Thu,  4 Jun 2026 21:33:36 +0200 (CEST)
Received: from fout-a8-smtp.messagingengine.com
 (fout-a8-smtp.messagingengine.com [103.168.172.151])
 by mails.dpdk.org (Postfix) with ESMTP id 93B5940677
 for <dev@dpdk.org>; Thu,  4 Jun 2026 21:33:35 +0200 (CEST)
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
 by mailfout.phl.internal (Postfix) with ESMTP id 2FCF7EC0109;
 Thu,  4 Jun 2026 15:33:35 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-02.internal (MEProxy); Thu, 04 Jun 2026 15:33:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780601615; x=
 1780688015; bh=VSh5neP85azht18n3Uu5RexiWIErJf07Mv2kM/DHijw=; b=f
 UX2twXUMcCogev3nOLNquWeWI+UZ5pL1ajOu7oWJEgBSAf0vaSL8BN1+lnvtUjbI
 yvb/4baSZEWv9ji/YPsEiDZal6c+wokrFwaNGBiWpTW3sNcYdALaFiZk7Bwp7zxo
 oL2djZM13PUf5lYIhxGPIwh/bjp13IzT53AEJsOE8d30dmswu+7+nb7OuQVo3Ab9
 xXyTBm4kJrXL8ygAj7WdkIQzWu6iJwO3NDz9zypUAWyk2fHc3wWBcALsxuOftO8M
 2Jk8WX1TpsOkEGkJ6731RZREydoMhg9dlKSCffTlnj26nLXcfKLoN9n+vBcMUpNX
 gwC3dVl4ExA09MmVBX5TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780601615; x=1780688015; bh=V
 Sh5neP85azht18n3Uu5RexiWIErJf07Mv2kM/DHijw=; b=aiAdAOKjtEIltyDL2
 chu/KLvML+Y/5AwuURZuzKWKRSiLJ3Eh/feXhLXAM7wqdzdSiTiV7I+H9HaL75ma
 U3BY1vVau39AWQ86yJOfjrC4sau8rC/mxqB5U4CbWsT89mHczt8uOZP/hKkG6CV9
 79CU0YgDmh5BPUfab0CYNx0i7HRlFSEXAsndnIXaIQsJ3RcP30NHlv29Vulc1b4o
 oYooGRC2wFCYdDgpzvrDFbiic8lcMEUuWj0OJuGmia8o2Ed/l/7HXnfArEyJb5Y0
 /Lt441Q11rkPDGF0TPwA722vZ5so5GLwZO/LB0qoE0TJQ+MqOohUUbmex1wc23c7
 3YWaA==
X-ME-Sender: <xms:D9Mhaqxwe-_DdAwn7OYYzmlNDx1KVcQx28v76E06UQZEFyjdFLTRNA>
 <xme:D9MhamYC6--fca0cEhUNuM4ZhgQgWmZUWUl0yrN-1-fgvyRnFQQpdnKBYpyQM7ioS
 puFlu3uD1yNLCIiex7UKF2vbPPr2CHrg2hdl07j9W7LolqA-dLa5A>
X-ME-Received: <xmr:D9MhakSzEmNCJCMwluH7dEf80OXsew8CJU5U7bQE_dFXXkHhX4DMBYTgsMJGE9MQfSXiTmVIFkiBpe65yK666QjfrdfI-J0>
X-ME-Proxy-Cause: dmFkZTFBVtFu73v6kEfmvEVYm2wybPSOOTBO2QZQTLxMmhRKicwazOPAhmwg6YOl/udFjG
 9CMckWvsaG3S/jXdOqGQ5YBD4798m4D3rAKVoB8d50ghLHACp09RRpMyKxbxJtg2kE4byq
 Wp+HcF41u2/fePWGB0Uoi0ggfcS2OmIDt7CA/hRM1+p1IN9erhF5steHvQA9oFz66G1z/y
 O12rNKrmv1xf2hrywdgv534RP7gMBVDK99h9nsQJRbuaOBkZo8ScTD2/4XPDewNtPAzPjR
 ComfayxCQpZAQ5JXvsrV1I8vr239TJi7FrAX9RwQ6Hiol1JR4VNExV6vm4spCCRsmuhAHP
 VeoaLzHsMqguEzHI/wXazDW8ffz0KAdc+9Hnod6FHyqvrXuhuK8i0aJg2o5hVmQk9VEnIv
 BbbVPPG18EaFqW4Giyjyiim6tMZk5GrpD0XQFtR2LHjNlig3Z2G18ZfxgZw5tPbin0QSBk
 D3U+HlvGKgEgfz/bdakkXUO96uWD5D8+/peBsiJgTgtNmXU3gCrfT+NCLEsKzviZrWmDwP
 9lPd4A19poODWlk42xvjwpiRU6TVZJ7m0pkGdqMI5/fZIfnO5CW5FyfWl7jiWnpDiJ74BQ
 gUaAh2T4SnxmwijgmSbqLdSqtRDibgNbgIHbmiDP+Vp4GLNOcgMpLVoYuh6Q
X-ME-Proxy: <xmx:D9Mhaows5Jl9gogbRVOJRmXLB-2ssAPec3tnJsAi91Ad8kmdya-m_A>
 <xmx:D9Mham3NJm2ulppltsRXLlTuYmsUzr1871Dn15iAyeBtyddoNr5Few>
 <xmx:D9Mham5zsRW0ehXz0amQdL8DmaqqUwbvGsjhG5o8SY1kWz99Jk-y_g>
 <xmx:D9MhapUv7CTDGVeAPAboOTmGtNcSTL0Ak8SvVU4ymMHxzpeRbbUSNQ>
 <xmx:D9MhavxoO5Z3OVGRQ-nc7hAWZl0ntJn-EZJCGXA2W4hKyGNPhKJYnKUn>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 Jun 2026 15:33:34 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gregory Etelson <getelson@nvidia.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v8 3/9] app/testpmd: support selective Rx
Date: Thu,  4 Jun 2026 21:30:55 +0200
Message-ID: <20260604193324.1996141-4-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260604193324.1996141-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260604193324.1996141-1-thomas@monjalon.net>
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

Add support for selective Rx using existing rxpkts and mbuf-size
command line parameters.

When a segment is specified with rxpkts and a matching 0 mbuf-size
on PMDs supporting selective Rx,
testpmd set the mempool of the segment to NULL,
meaning the segment won't be received.

Example usage to receive only Ethernet header and 64 bytes at offset 128:

  --rxpkts=14,114,64,0 --mbuf-size=256,0,256,0

This creates segments:
- [0-13]: 14 bytes with mempool (received)
- [14-127]: 114 bytes with NULL mempool (discarded)
- [128-191]: 64 bytes with mempool (received)
- [192-max]: remaining bytes with NULL mempool (discarded)

Note: RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT is required for this feature
and is checked at ethdev API level.
This check is removed from testpmd to allow negative testing of the API.

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 app/test-pmd/parameters.c                   |  5 ++-
 app/test-pmd/testpmd.c                      | 34 +++++++++++++--------
 doc/guides/testpmd_app_ug/run_app.rst       | 16 ++++++++++
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  3 +-
 4 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/app/test-pmd/parameters.c b/app/test-pmd/parameters.c
index ecbd618f00..337d8fc8ac 100644
--- a/app/test-pmd/parameters.c
+++ b/app/test-pmd/parameters.c
@@ -1170,10 +1170,9 @@ launch_args_parse(int argc, char** argv)
 				rte_exit(EXIT_FAILURE,
 					"bad mbuf-size\n");
 			for (i = 0; i < nb_segs; i++) {
-				if (mb_sz[i] <= 0 || mb_sz[i] > 0xFFFF)
+				if (mb_sz[i] > 0xFFFF)
 					rte_exit(EXIT_FAILURE,
-						"mbuf-size should be "
-						"> 0 and < 65536\n");
+						"mbuf-size should be < 65536\n");
 				mbuf_data_size[i] = (uint16_t) mb_sz[i];
 			}
 			mbuf_data_size_n = nb_segs;
diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index a9b35f530a..7d29a0117c 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -1806,19 +1806,25 @@ init_config(void)
 		uint8_t i, j;
 
 		for (i = 0; i < num_sockets; i++)
-			for (j = 0; j < mbuf_data_size_n; j++)
+			for (j = 0; j < mbuf_data_size_n; j++) {
+				if (mbuf_data_size[j] == 0)
+					continue;
 				mempools[i * MAX_SEGS_BUFFER_SPLIT + j] =
 					mbuf_pool_create(mbuf_data_size[j],
 							  nb_mbuf_per_pool,
 							  socket_ids[i], j);
+			}
 	} else {
 		uint8_t i;
 
-		for (i = 0; i < mbuf_data_size_n; i++)
+		for (i = 0; i < mbuf_data_size_n; i++) {
+			if (mbuf_data_size[i] == 0)
+				continue;
 			mempools[i] = mbuf_pool_create
 					(mbuf_data_size[i],
 					 nb_mbuf_per_pool,
 					 SOCKET_ID_ANY, i);
+		}
 	}
 
 	init_port_config();
@@ -2744,31 +2750,35 @@ rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 	uint32_t prev_hdrs = 0;
 	int ret;
 
-	if ((rx_pkt_nb_segs > 1) &&
-	    (rx_conf->offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT)) {
+	if (multi_rx_mempool == 0 &&
+	    (rx_pkt_nb_segs > 1 || mbuf_data_size_n > 1)) {
+		unsigned int nb_segs = RTE_MAX(rx_pkt_nb_segs, (uint8_t)mbuf_data_size_n);
+
 		/* multi-segment configuration */
-		for (i = 0; i < rx_pkt_nb_segs; i++) {
+		for (i = 0; i < nb_segs; i++) {
 			struct rte_eth_rxseg_split *rx_seg = &rx_useg[i].split;
 			/*
 			 * Use last valid pool for the segments with number
 			 * exceeding the pool index.
 			 */
 			mp_n = (i >= mbuf_data_size_n) ? mbuf_data_size_n - 1 : i;
-			mpx = mbuf_pool_find(socket_id, mp_n);
-			/* Handle zero as mbuf data buffer size. */
 			rx_seg->offset = i < rx_pkt_nb_offs ?
 					   rx_pkt_seg_offsets[i] : 0;
-			rx_seg->mp = mpx ? mpx : mp;
+			if (mbuf_data_size[mp_n] == 0) {
+				rx_seg->mp = NULL;
+			} else {
+				mpx = mbuf_pool_find(socket_id, mp_n);
+				rx_seg->mp = mpx ? mpx : mp;
+			}
 			if (rx_pkt_hdr_protos[i] != 0 && rx_pkt_seg_lengths[i] == 0) {
 				rx_seg->proto_hdr = rx_pkt_hdr_protos[i] & ~prev_hdrs;
 				prev_hdrs |= rx_seg->proto_hdr;
 			} else {
-				rx_seg->length = rx_pkt_seg_lengths[i] ?
-						rx_pkt_seg_lengths[i] :
-						mbuf_data_size[mp_n];
+				rx_seg->length = i < rx_pkt_nb_segs ?
+						rx_pkt_seg_lengths[i] : 0;
 			}
 		}
-		rx_conf->rx_nseg = rx_pkt_nb_segs;
+		rx_conf->rx_nseg = nb_segs;
 		rx_conf->rx_seg = rx_useg;
 		rx_conf->rx_mempools = NULL;
 		rx_conf->rx_nmempool = 0;
diff --git a/doc/guides/testpmd_app_ug/run_app.rst b/doc/guides/testpmd_app_ug/run_app.rst
index 1a4a4b6c12..d654484546 100644
--- a/doc/guides/testpmd_app_ug/run_app.rst
+++ b/doc/guides/testpmd_app_ug/run_app.rst
@@ -127,6 +127,7 @@ The command line options are:
     The default value is 2048. If multiple mbuf-size values are specified the
     extra memory pools will be created for allocating mbufs to receive packets
     with buffer splitting features.
+    A value of 0 indicates a discarded segment in buffer split.
 
 *   ``--total-num-mbufs=N``
 
@@ -372,6 +373,21 @@ The command line options are:
     Optionally the multiple memory pools can be specified with --mbuf-size
     command line parameter and the mbufs to receive will be allocated
     sequentially from these extra memory pools.
+    A length of 0 means maximum length: rest of the segment
+    or all remaining packet data in case of a discard segment.
+
+    To receive only the Ethernet header (14 bytes)
+    and a 64-byte segment starting at offset 128,
+    while discarding the rest::
+
+       --rxpkts=14,114,64,0 --mbuf-size=256,0,256,0
+
+    This configuration will:
+
+    * Receive 14 bytes (Ethernet header)
+    * Discard 114 bytes (NULL mempool segment)
+    * Receive 64 bytes
+    * Discard remaining bytes (NULL mempool segment, length=0)
 
 *   ``--txpkts=X[,Y]``
 
diff --git a/doc/guides/testpmd_app_ug/testpmd_funcs.rst b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
index d50921258a..f0f2b0758b 100644
--- a/doc/guides/testpmd_app_ug/testpmd_funcs.rst
+++ b/doc/guides/testpmd_app_ug/testpmd_funcs.rst
@@ -850,7 +850,8 @@ mbuf for remaining segments will be allocated from the last valid pool).
    testpmd> set rxpkts (x[,y]*)
 
 Where x[,y]* represents a CSV list of values, without white space. Zero value
-means to use the corresponding memory pool data buffer size.
+means to use the corresponding memory pool data buffer size,
+or to discard all remaining packet data for a discard segment (mbuf-size=0).
 
 set rxhdrs
 ~~~~~~~~~~
-- 
2.54.0

