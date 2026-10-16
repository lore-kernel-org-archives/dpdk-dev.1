Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4661ECCF2C3
	for <dpdk-dev@archiver.kernel.org>; Fri, 16 Oct 2026 21:19:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9D8C1402E7;
	Fri, 16 Oct 2026 23:19:52 +0200 (CEST)
Received: from smtp05-ext.udag.de (smtp05-ext.udag.de [62.146.106.75])
 by mails.dpdk.org (Postfix) with ESMTP id 4C6674026C
 for <dev@dpdk.org>; Fri, 16 Oct 2026 23:19:49 +0200 (CEST)
Received: from machine (unknown [37.228.233.98])
 by smtp05-ext.udag.de (Postfix) with ESMTPA id C55E4E0285;
 Fri, 16 Oct 2026 23:19:48 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dressler.pro;
 s=uddkim-202310; t=1792185589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AeCdRszfbCGUtJQGsKeUHNbrNARx/rDA1XfPNu4io8s=;
 b=LPGS0K2aSefOF2xQby7F4EG4G6/itcsl+LP+g0K4R0wsh0bF61csfOPSsegduo+e8+Dj9S
 gPx/EX1x05aWs65ENCfIempxC2Y0aGWIo1JJsnzhx+rusjWEJJLif0y9S11LZs1UjlBzIg
 8DUn58Unn1R66swqlA/N+RpLCyfBUOMh+FPSDNtln+MK9khg4Dfppbuh9y8NiCyQUa/i7f
 DAmZ7kr4SgnBvNweMh2nIi1otyTB3LAjfcICHJ4ZgeKkAFbfYhD8aK1iG63FPbOukIhE4z
 qpMRKxeUp96p85SFtRQVecOy1tZdxWIZkYI7PPYhrcWOdKeqxZ1R7hAAySVTZg==
Authentication-Results: smtp05-ext.udag.de;
 auth=pass smtp.auth=dressler-pro-0001 smtp.mailfrom=frank@dressler.pro
From: Frank Dressler <frank@dressler.pro>
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v7 1/4] test/af_packet: ignore stray packets in loopback test
Date: Fri, 16 Oct 2026 22:19:39 +0100
Message-ID: <20261016211942.217041-2-frank@dressler.pro>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261016211942.217041-1-frank@dressler.pro>
References: <20261009151015.742011-1-frank@dressler.pro>
 <20261016211942.217041-1-frank@dressler.pro>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

The loopback test counts looped back frames. But there can be
unexpected frames among them such as IPv6 Neighbor Discovery
packets injected by the kernel which can lead to unexpected results.

Tag sent frames in the source MAC and count only matching ones.

Signed-off-by: Frank Dressler <frank@dressler.pro>
---
 .mailmap                      |  1 +
 app/test/test_pmd_af_packet.c | 58 ++++++++++++++++++++++++++---------
 2 files changed, 44 insertions(+), 15 deletions(-)

diff --git a/.mailmap b/.mailmap
index 6d9e262cfb..cfb3f4a058 100644
--- a/.mailmap
+++ b/.mailmap
@@ -510,6 +510,7 @@ Francis Kelly <fkelly@nvidia.com> <fkelly@mellanox.com>
 Francis Racicot <francis.racicot@intel.com>
 Franck Lenormand <franck.lenormand@nxp.com>
 François-Frédéric Ozog <ff@ozog.com>
+Frank Dressler <frank@dressler.pro>
 Frank Du <frank.du@intel.com>
 Frank Zhao <frank.zhao@starfivetech.com>
 Frederico Cadete <frederico.cadete-ext@oneaccess-net.com>
diff --git a/app/test/test_pmd_af_packet.c b/app/test/test_pmd_af_packet.c
index b668ca5b81..74eb47f1a2 100644
--- a/app/test/test_pmd_af_packet.c
+++ b/app/test/test_pmd_af_packet.c
@@ -44,6 +44,14 @@ test_pmd_af_packet(void)
 #define BURST_SIZE 32
 #define RING_SIZE 256
 
+/* Length of Ethernet frames built by the tests */
+#define TEST_FRAME_LEN (sizeof(struct rte_ether_hdr) + 46)
+
+/* Source MAC used to recognise frames sent by this test */
+static const struct rte_ether_addr DEV_MAC_TAG = {
+	.addr_bytes = { 'P', 'A', 'C', 'K', 'E', 'T' },
+};
+
 /* Polling and timeout constants */
 #define STATS_POLL_INTERVAL_US 100
 #define STATS_POLL_TIMEOUT_US 100000  /* 100ms overall timeout */
@@ -206,23 +214,39 @@ alloc_tx_mbufs(struct rte_mbuf **bufs, unsigned int count)
 
 	for (i = 0; i < count; i++) {
 		struct rte_ether_hdr *eth_hdr;
+
 		eth_hdr = (struct rte_ether_hdr *)rte_pktmbuf_append(bufs[i],
-				sizeof(struct rte_ether_hdr) + 46);
+				TEST_FRAME_LEN);
 		if (eth_hdr == NULL) {
 			/* Free all allocated mbufs on failure */
 			rte_pktmbuf_free_bulk(bufs, count);
 			return 0;
 		}
 
-		/* Set broadcast destination and zero source MAC */
+		/* Set broadcast destination and DEV_MAC_TAG source MAC */
 		memset(&eth_hdr->dst_addr, 0xFF, RTE_ETHER_ADDR_LEN);
-		memset(&eth_hdr->src_addr, 0x00, RTE_ETHER_ADDR_LEN);
+		rte_ether_addr_copy(&DEV_MAC_TAG, &eth_hdr->src_addr);
 		eth_hdr->ether_type = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
 	}
 
 	return count;
 }
 
+/*
+ * Helper: Indicates whether the mbuf source MAC is DEV_MAC_TAG.
+ */
+static bool
+is_tagged_mbuf(struct rte_mbuf *buf)
+{
+	struct rte_ether_hdr *eth;
+
+	if (rte_pktmbuf_data_len(buf) < sizeof(*eth))
+		return false;
+
+	eth = rte_pktmbuf_mtod(buf, struct rte_ether_hdr *);
+	return rte_is_same_ether_addr(&eth->src_addr, &DEV_MAC_TAG);
+}
+
 /*
  * Helper: Transmit packets and free unsent mbufs.
  * Returns the number of packets successfully transmitted.
@@ -243,15 +267,22 @@ do_tx_burst(uint16_t pid, uint16_t queue_id, struct rte_mbuf **bufs,
 
 /*
  * Helper: Receive packets and free received mbufs.
+ * If count_tagged is non-NULL, count DEV_MAC_TAG frames in it.
  * Returns the number of packets received.
  */
 static uint16_t
 do_rx_burst(uint16_t pid, uint16_t queue_id, struct rte_mbuf **bufs,
-	    unsigned int count)
+	    unsigned int count, unsigned int *count_tagged)
 {
-	uint16_t nb_rx;
+	uint16_t i, nb_rx;
 
 	nb_rx = rte_eth_rx_burst(pid, queue_id, bufs, count);
+	if (count_tagged != NULL) {
+		for (i = 0; i < nb_rx; i++) {
+			if (is_tagged_mbuf(bufs[i]))
+				(*count_tagged)++;
+		}
+	}
 	rte_pktmbuf_free_bulk(bufs, nb_rx);
 
 	return nb_rx;
@@ -527,7 +558,7 @@ test_af_packet_rx(void)
 	}
 
 	/* Try to receive packets (non-blocking) using helper */
-	do_rx_burst(port_id, 0, bufs, BURST_SIZE);
+	do_rx_burst(port_id, 0, bufs, BURST_SIZE, NULL);
 
 	/* RX from tap interface without external traffic will return 0 */
 	/* This test just verifies the RX path doesn't crash */
@@ -544,7 +575,8 @@ test_af_packet_loopback(void)
 {
 	struct rte_mbuf *tx_bufs[BURST_SIZE];
 	struct rte_mbuf *rx_bufs[BURST_SIZE];
-	uint16_t nb_tx, total_rx = 0;
+	uint16_t nb_tx;
+	unsigned int count_tagged = 0;
 	uint64_t elapsed = 0;
 	unsigned int allocated;
 	char tap_buf[2048];
@@ -588,14 +620,10 @@ test_af_packet_loopback(void)
 		}
 
 		/* Try to receive via af_packet RX */
-		uint16_t nb_rx = rte_eth_rx_burst(port_id, 0, rx_bufs, BURST_SIZE);
-		if (nb_rx > 0) {
-			total_rx += nb_rx;
-			rte_pktmbuf_free_bulk(rx_bufs, nb_rx);
-		}
+		do_rx_burst(port_id, 0, rx_bufs, BURST_SIZE, &count_tagged);
 
 		/* Check if we've received enough */
-		if (total_rx >= nb_tx)
+		if (count_tagged >= nb_tx)
 			break;
 
 		rte_delay_us_block(STATS_POLL_INTERVAL_US);
@@ -609,7 +637,7 @@ test_af_packet_loopback(void)
 	 * Note: We may not receive all packets due to timing, but receiving
 	 * any packets proves the loopback path works.
 	 */
-	printf("Loopback: TX=%u, RX=%u\n", nb_tx, total_rx);
+	printf("Loopback: TX=%u, RX=%u\n", nb_tx, count_tagged);
 
 	return TEST_SUCCESS;
 }
@@ -982,7 +1010,7 @@ test_af_packet_multi_queue(void)
 
 	/* Test RX on different queues */
 	for (q = 0; q < num_queues; q++)
-		do_rx_burst(test_port, q, bufs, BURST_SIZE);
+		do_rx_burst(test_port, q, bufs, BURST_SIZE, NULL);
 
 	/* Cleanup */
 	rte_eth_dev_stop(test_port);
-- 
2.56.0

