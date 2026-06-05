Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23566CD6E7B
	for <dpdk-dev@archiver.kernel.org>; Fri,  5 Jun 2026 23:35:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5359A40672;
	Sat,  6 Jun 2026 01:35:15 +0200 (CEST)
Received: from fhigh-a4-smtp.messagingengine.com
 (fhigh-a4-smtp.messagingengine.com [103.168.172.155])
 by mails.dpdk.org (Postfix) with ESMTP id 5533A40670
 for <dev@dpdk.org>; Sat,  6 Jun 2026 01:35:14 +0200 (CEST)
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.phl.internal (Postfix) with ESMTP id 05321140012B;
 Fri,  5 Jun 2026 19:35:14 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Fri, 05 Jun 2026 19:35:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monjalon.net; h=
 cc:cc:content-transfer-encoding:content-type:date:date:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to; s=fm1; t=1780702514; x=
 1780788914; bh=L/Pyz4nwaCM1K5MoCKF7fyh/vyyF5USZtHBWYzOUIgU=; b=X
 +eIwqw3yOQRIMmbu+nH4WQl/KZJ9xm9zDYHe6ELiU8ia/vgwtmBhbDPfVPFD5KhS
 sHwnXVVevPBnYWrER1nRmvl1D4T/Unk/TgcyZN+E0CqtaCfB6kfFR81rFXv0sRPY
 SKQnv5WdLjWyBSyAbkOCc1NM1LAKbo8dIa9FfHeov3h6dSYtSmcLmblQWA8WqxdL
 tgWBDWmD/gJD5qJxcZsBPNIm+sr33DeUBNrNa56nJbs+LMah7gr+U/5piunmJ4UI
 C8FUJ9XQwgDekvJB9vA+XTLJhowNw9wX7YQjp/6gf3f8hN5zD2ZAZgxDqwzLekfr
 aqGNVecNvJyDOvsLuh1dQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:date:date:feedback-id:feedback-id:from:from
 :in-reply-to:in-reply-to:message-id:mime-version:references
 :reply-to:subject:subject:to:to:x-me-proxy:x-me-sender
 :x-me-sender:x-sasl-enc; s=fm1; t=1780702514; x=1780788914; bh=L
 /Pyz4nwaCM1K5MoCKF7fyh/vyyF5USZtHBWYzOUIgU=; b=W6dpyZ7Wb0clQFjp0
 qGaJLkr0Lnu5uLF1J9Bkg848jne5VUVufxfQWJgpuiiGtucquHi+MmBgLmIXMF2c
 +3xDcczgx8UuN9hWe+5ZjB8gOS1DbUCN5BlmjdtIaxsmE4QMuuZfkDCGUPe+x8JA
 5J+jET2kYzcWejCI3UdzjdKUnp5uKuZvNnF2TlxG1iWlnqnfrLdZhi6Koo2DjO+K
 fP2+IUmpkkCHKs94mp7fW/eOXoMXzs3WrRyuz18kqfY+vJy8V717/yqLjaUidk9h
 RGhIwwDO1lIh1JzKfSGHmJyB/Ic3/kyw9kFIlpL450lM8len/WFieGb1fyef0PyB
 BeA1Q==
X-ME-Sender: <xms:MV0jag21SrBw5Ed0s7hSIUv9X0CU9GoVCm1JUzGptvE_TXDGp6Bkgw>
 <xme:MV0jarNFBmdfnknqJu99VGUzs9BbfA1GzpMZO7y3cZfKolx8uqrt0Z110KH3mZcM1
 dJ0TVUoHmaVbwsab6lkezj2-LcH9uVvUAxQGeWqfLNT5YXi0ztVSg>
X-ME-Received: <xmr:MV0jag2JIWlnQbDMDtw16EYVRiHVlIu0yaCffKGHlAYHlZkRmT_-TYJsBAUllCVSPV-q9g9hgjDUTZv3CPYyfWXhe2UEReA>
X-ME-Proxy-Cause: dmFkZTGzqB9VtFI99eOw6BobuLm3hk3TtecrLkwGZnoPzSMqKBIvARG1bnFYZMgW7RR3Sn
 d8HGOh3+U9suVcGhC9wLPD8PQQV+TTrBGhcQOzAVlNb9EhVfRko8hR6bg+arR9FDtyrqr+
 Oh9krPYIKsY3Fo5XJUhCm2g8VmGWg0RNxvEnSTORpivfsWS18goJE4hkGlV2XNc5+hFbCO
 8eWq4kW4BsbPtAXXNwwvez6E5oc/ehQmRYNYqcepTVBdBaZK2+VT6rImCTjVt3/xz9Nhli
 TRIhvLCrzk8cXTHD6P9ytRlAs7G2Brli4KinTp3i+GPPLfVBgJAe5NyVzKzT0yh2P03DqN
 QHtIEtHGL7rFDR8GmaxftKX7JAAUChpP7ESay/PYBvXgnaHCgHGOmqUfbMftaCMlnwo9C4
 3havEFbmSEvHsDOpv6fQQcLGWHDwgPLqvf3z2doYmT4bxwjxU6yINSZwhZvYJn9sznhxhD
 OtT1Zl0MQkg7s7a7yuSdTQN9Rf9HdtuDmUFr/QUKffz8mwrsVNOhHgkQfIQfrMZCh/zk4k
 wOVDEXP9j72SEgCii6PUmjC99RFnTg4GfGrhDf5aJNU0KGbg5+1M7hmckc0Bi2bdr8YYj+
 WS116XBF6uzGaGnGFKtJkAih1bBzPz95Wg6EpIxEQrHvQhgRZgyxfeFPxzDQ
X-ME-Proxy: <xmx:MV0jaiHJk-UeuhZ089tQvxF41TVucinlYA5V8di6mkT_Y7vFzGoHQw>
 <xmx:MV0jat5W9vyYG9yZL4O59K6alkYqF-FAsYNeIRndDgW575dqNaHtEQ>
 <xmx:MV0jaot-tnihy6KvmDlx2BGlTlM1U98JhG3srS-jcpDkisiXBaTSgQ>
 <xmx:MV0jau74yTqSSk2CBF0LrPE3yBmEJFlAepk-v8j8G8tVa_YEKP92hA>
 <xmx:Ml0janVFsGS8je9f6pA5_t6Dz4mRfrDqdww2qkg21WoniLzFQRepy21p>
Feedback-ID: i47234305:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 Jun 2026 19:35:12 -0400 (EDT)
From: Thomas Monjalon <thomas@monjalon.net>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Gregory Etelson <getelson@nvidia.com>,
 Aman Singh <aman.deep.singh@intel.com>
Subject: [PATCH v9 03/10] app/testpmd: support selective Rx
Date: Sat,  6 Jun 2026 01:33:43 +0200
Message-ID: <20260605233456.3017423-4-thomas@monjalon.net>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260605233456.3017423-1-thomas@monjalon.net>
References: <20260202160903.254621-1-getelson@nvidia.com>
 <20260605233456.3017423-1-thomas@monjalon.net>
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

If the first segment has no mempool,
there will be no mempool created with the index 0.
That's why the lookup of the first mempool is now achieved
in the new function mbuf_pool_find_first(socket)
instead of mbuf_pool_find(socket, index 0)

Note: RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT is required for this feature
and is checked at ethdev API level.
This check is removed from testpmd to allow negative testing of the API.

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Signed-off-by: Thomas Monjalon <thomas@monjalon.net>
---
 app/test-pmd/cmdline.c                      |  2 +-
 app/test-pmd/parameters.c                   |  5 +--
 app/test-pmd/testpmd.c                      | 48 +++++++++++++--------
 app/test-pmd/testpmd.h                      | 16 +++++++
 doc/guides/testpmd_app_ug/run_app.rst       | 16 +++++++
 doc/guides/testpmd_app_ug/testpmd_funcs.rst |  3 +-
 6 files changed, 66 insertions(+), 24 deletions(-)

diff --git a/app/test-pmd/cmdline.c b/app/test-pmd/cmdline.c
index cc9c462498..3c39e27aa8 100644
--- a/app/test-pmd/cmdline.c
+++ b/app/test-pmd/cmdline.c
@@ -3076,7 +3076,7 @@ cmd_setup_rxtx_queue_parsed(
 		if (!numa_support || socket_id == NUMA_NO_CONFIG)
 			socket_id = port->socket_id;
 
-		mp = mbuf_pool_find(socket_id, 0);
+		mp = mbuf_pool_find_first(socket_id);
 		if (mp == NULL) {
 			fprintf(stderr,
 				"Failed to setup RX queue: No mempool allocation on the socket %d\n",
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
index a9b35f530a..fcd8a90967 100644
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
@@ -1831,11 +1837,11 @@ init_config(void)
 	 * Records which Mbuf pool to use by each logical core, if needed.
 	 */
 	for (lc_id = 0; lc_id < nb_lcores; lc_id++) {
-		mbp = mbuf_pool_find(
-			rte_lcore_to_socket_id(fwd_lcores_cpuids[lc_id]), 0);
+		mbp = mbuf_pool_find_first(
+			rte_lcore_to_socket_id(fwd_lcores_cpuids[lc_id]));
 
 		if (mbp == NULL)
-			mbp = mbuf_pool_find(0, 0);
+			mbp = mbuf_pool_find_first(0);
 		fwd_lcores[lc_id]->mbp = mbp;
 #ifdef RTE_LIB_GSO
 		/* initialize GSO context */
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
@@ -3126,8 +3136,8 @@ start_port(portid_t pid)
 				if ((numa_support) &&
 					(rxring_numa[pi] != NUMA_NO_CONFIG)) {
 					struct rte_mempool * mp =
-						mbuf_pool_find
-							(rxring_numa[pi], 0);
+						mbuf_pool_find_first
+							(rxring_numa[pi]);
 					if (mp == NULL) {
 						fprintf(stderr,
 							"Failed to setup RX queue: No mempool allocation on the socket %d\n",
@@ -3142,9 +3152,9 @@ start_port(portid_t pid)
 					     mp);
 				} else {
 					struct rte_mempool *mp =
-						mbuf_pool_find
+						mbuf_pool_find_first
 							((numa_support ? port->socket_id :
-							(unsigned int)SOCKET_ID_ANY), 0);
+							(unsigned int)SOCKET_ID_ANY));
 					if (mp == NULL) {
 						fprintf(stderr,
 							"Failed to setup RX queue: No mempool allocation on the socket %d\n",
diff --git a/app/test-pmd/testpmd.h b/app/test-pmd/testpmd.h
index 1a54535470..3d4b36d668 100644
--- a/app/test-pmd/testpmd.h
+++ b/app/test-pmd/testpmd.h
@@ -895,6 +895,22 @@ mbuf_pool_find(unsigned int sock_id, uint16_t idx)
 	return rte_mempool_lookup((const char *)pool_name);
 }
 
+static inline struct rte_mempool *
+mbuf_pool_find_first(unsigned int sock_id)
+{
+	struct rte_mempool *mp;
+	uint16_t idx;
+
+	for (idx = 0; idx < mbuf_data_size_n; idx++) {
+		if (mbuf_data_size[idx] == 0) /* no mempool with this index */
+			continue;
+		mp = mbuf_pool_find(sock_id, idx);
+		if (mp != NULL)
+			return mp;
+	}
+	return NULL;
+}
+
 static inline uint16_t
 common_fwd_stream_receive(struct fwd_stream *fs, struct rte_mbuf **burst,
 	unsigned int nb_pkts)
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

