Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64423CC6B33
	for <dpdk-dev@archiver.kernel.org>; Thu, 15 Oct 2026 11:15:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA74840659;
	Thu, 15 Oct 2026 13:14:55 +0200 (CEST)
Received: from smtp04-ext3.udag.de (smtp04-ext3.udag.de [62.146.106.41])
 by mails.dpdk.org (Postfix) with ESMTP id 41A50402E4
 for <dev@dpdk.org>; Thu, 15 Oct 2026 13:14:52 +0200 (CEST)
Received: from machine (unknown [37.228.233.98])
 by smtp04-ext3.udag.de (Postfix) with ESMTPA id A3B25E04F0;
 Thu, 15 Oct 2026 13:14:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dressler.pro;
 s=uddkim-202310; t=1792062891;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=D351LUIW3Taqb9wnVzFwTN3MMWBIufr7P/utazKhCvc=;
 b=Mb5Ovl7J/mfezexYii4pxp8yTsuhB7bl2SFECZBXSm21erC8pId/+XL4lC7gdO2REtdhwV
 tRCcZEUrRqkJ+XrL2ts8NXx1/si82r1cx5T+WxNbhAbolrXHdj4QzASk0uBVltUTgNGaBt
 Yy5HZCg79Z8x9zOKvPyS2OY5NFG2wX+XCXCUTBYgWyZZKc5Hty99E0ZTX5OcZEewYPdHPy
 Kd8tpfV7hMi2rGJ+BaxsVGNw0VbtxNvnPZVbS+VfqpXcNCfhCvxHr/AbG9/NVUmHiP4alk
 osRMZst+TIvsxEW+P610kbHGoj5z1kTMoFZ22dsywFfwyXyTQTh0hZzX5/9cLA==
Authentication-Results: smtp04-ext3.udag.de;
 auth=pass smtp.auth=dressler-pro-0001 smtp.mailfrom=frank@dressler.pro
From: Frank Dressler <frank@dressler.pro>
To: stephen@networkplumber.org
Cc: dev@dpdk.org
Subject: [PATCH v6 2/4] net/af_packet: filter Rx of outgoing packets in the PMD
Date: Thu, 15 Oct 2026 12:14:32 +0100
Message-ID: <20261015111434.1470973-3-frank@dressler.pro>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261015111434.1470973-1-frank@dressler.pro>
References: <20261009151015.742011-1-frank@dressler.pro>
 <20261015111434.1470973-1-frank@dressler.pro>
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

In contrast to other PMDs, the AF_PACKET PMD does not only return
incoming but also outgoing packets from rte_eth_rx_burst(). This is
fine for applications similar to tcpdump which usually want to see
both.

But this is not always the desired behavior. For example, the
AF_PACKET PMD might be used in a testing environment in which no
regular ethernet PMD is available. In such an environment, the
PMD must behave like a regular one, i.e. not return sent packets
from rte_eth_rx_burst().

For this reason, this change adds the ignore_outgoing=<0|1> devarg.
When set, the PMD ensures that rte_eth_rx_burst() only returns
incoming traffic. The default is 0 so that existing software works
as before.

Signed-off-by: Frank Dressler <frank@dressler.pro>
---
 app/test/test_pmd_af_packet.c             | 275 ++++++++++++++++++++--
 doc/guides/nics/af_packet.rst             |   2 +
 doc/guides/rel_notes/release_26_11.rst    |   5 +
 drivers/net/af_packet/rte_eth_af_packet.c |  25 +-
 4 files changed, 284 insertions(+), 23 deletions(-)

diff --git a/app/test/test_pmd_af_packet.c b/app/test/test_pmd_af_packet.c
index 74eb47f1a2..6410caffcc 100644
--- a/app/test/test_pmd_af_packet.c
+++ b/app/test/test_pmd_af_packet.c
@@ -47,15 +47,27 @@ test_pmd_af_packet(void)
 /* Length of Ethernet frames built by the tests */
 #define TEST_FRAME_LEN (sizeof(struct rte_ether_hdr) + 46)
 
-/* Source MAC used to recognise frames sent by this test */
+/* Source MAC address used for frames sent by the TAP device */
 static const struct rte_ether_addr DEV_MAC_TAG = {
 	.addr_bytes = { 'P', 'A', 'C', 'K', 'E', 'T' },
 };
 
+/* Source MAC address used for frames sent by the TAP file descriptor */
+static const struct rte_ether_addr FD_MAC_TAG = {
+	.addr_bytes = { 'T', 'E', 'K', 'C', 'A', 'P' },
+};
+
+/* Count of frames with each tag */
+struct tag_count {
+	unsigned int n_dev_tagged;
+	unsigned int n_fd_tagged;
+};
+
 /* Polling and timeout constants */
 #define STATS_POLL_INTERVAL_US 100
 #define STATS_POLL_TIMEOUT_US 100000  /* 100ms overall timeout */
 #define LOOPBACK_TIMEOUT_US 500000    /* 500ms for loopback test */
+#define RX_FLUSH_TIMEOUT_US 100000    /* 100ms to drain queued frames */
 
 /* Multi-threaded test constants */
 #define MT_NUM_PACKETS 100
@@ -198,6 +210,28 @@ configure_af_packet_port(uint16_t pid, uint16_t nb_rx_q, uint16_t nb_tx_q)
 	return 0;
 }
 
+/*
+ * Helper: Fill a minimal Ethernet frame with a broadcast destination and
+ *         the given source MAC.
+ * Returns 0 on success, -1 otherwise.
+ */
+static int
+init_frame(void *frame, size_t len, const struct rte_ether_addr *src)
+{
+	struct rte_ether_hdr *eth = frame;
+
+	if (len < TEST_FRAME_LEN)
+		return -1;
+
+	/* Set broadcast destination and source MAC */
+	memset(frame, 0, TEST_FRAME_LEN);
+	memset(&eth->dst_addr, 0xFF, RTE_ETHER_ADDR_LEN);
+	rte_ether_addr_copy(src, &eth->src_addr);
+	eth->ether_type = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
+
+	return 0;
+}
+
 /*
  * Helper: Allocate and prepare a burst of TX mbufs with minimal Ethernet frames.
  * Returns the number of successfully allocated mbufs.
@@ -213,30 +247,25 @@ alloc_tx_mbufs(struct rte_mbuf **bufs, unsigned int count)
 		return 0;
 
 	for (i = 0; i < count; i++) {
-		struct rte_ether_hdr *eth_hdr;
+		void *hdr;
 
-		eth_hdr = (struct rte_ether_hdr *)rte_pktmbuf_append(bufs[i],
-				TEST_FRAME_LEN);
-		if (eth_hdr == NULL) {
+		hdr = rte_pktmbuf_append(bufs[i], TEST_FRAME_LEN);
+		if (hdr == NULL ||
+		    init_frame(hdr, TEST_FRAME_LEN, &DEV_MAC_TAG) != 0) {
 			/* Free all allocated mbufs on failure */
 			rte_pktmbuf_free_bulk(bufs, count);
 			return 0;
 		}
-
-		/* Set broadcast destination and DEV_MAC_TAG source MAC */
-		memset(&eth_hdr->dst_addr, 0xFF, RTE_ETHER_ADDR_LEN);
-		rte_ether_addr_copy(&DEV_MAC_TAG, &eth_hdr->src_addr);
-		eth_hdr->ether_type = rte_cpu_to_be_16(RTE_ETHER_TYPE_IPV4);
 	}
 
 	return count;
 }
 
 /*
- * Helper: Indicates whether the mbuf source MAC is DEV_MAC_TAG.
+ * Helper: Indicates whether the mbuf source MAC matches tag.
  */
 static bool
-is_tagged_mbuf(struct rte_mbuf *buf)
+is_tagged_mbuf(struct rte_mbuf *buf, const struct rte_ether_addr *tag)
 {
 	struct rte_ether_hdr *eth;
 
@@ -244,7 +273,7 @@ is_tagged_mbuf(struct rte_mbuf *buf)
 		return false;
 
 	eth = rte_pktmbuf_mtod(buf, struct rte_ether_hdr *);
-	return rte_is_same_ether_addr(&eth->src_addr, &DEV_MAC_TAG);
+	return rte_is_same_ether_addr(&eth->src_addr, tag);
 }
 
 /*
@@ -267,20 +296,22 @@ do_tx_burst(uint16_t pid, uint16_t queue_id, struct rte_mbuf **bufs,
 
 /*
  * Helper: Receive packets and free received mbufs.
- * If count_tagged is non-NULL, count DEV_MAC_TAG frames in it.
+ * If tag_count is non-NULL, count tags in it.
  * Returns the number of packets received.
  */
 static uint16_t
 do_rx_burst(uint16_t pid, uint16_t queue_id, struct rte_mbuf **bufs,
-	    unsigned int count, unsigned int *count_tagged)
+	    unsigned int count, struct tag_count *tag_count)
 {
 	uint16_t i, nb_rx;
 
 	nb_rx = rte_eth_rx_burst(pid, queue_id, bufs, count);
-	if (count_tagged != NULL) {
+	if (tag_count != NULL) {
 		for (i = 0; i < nb_rx; i++) {
-			if (is_tagged_mbuf(bufs[i]))
-				(*count_tagged)++;
+			if (is_tagged_mbuf(bufs[i], &DEV_MAC_TAG))
+				tag_count->n_dev_tagged++;
+			else if (is_tagged_mbuf(bufs[i], &FD_MAC_TAG))
+				tag_count->n_fd_tagged++;
 		}
 	}
 	rte_pktmbuf_free_bulk(bufs, nb_rx);
@@ -288,6 +319,46 @@ do_rx_burst(uint16_t pid, uint16_t queue_id, struct rte_mbuf **bufs,
 	return nb_rx;
 }
 
+/*
+ * Helper: Discard frames already queued.
+ */
+static void
+flush_rx_port(uint16_t pid, uint16_t nb_queues)
+{
+	struct rte_mbuf *bufs[BURST_SIZE];
+	uint64_t flush_deadline;
+	uint16_t q;
+
+	flush_deadline = rte_get_timer_cycles() +
+			(rte_get_timer_hz() * RX_FLUSH_TIMEOUT_US) / US_PER_S;
+
+	for (q = 0; q < nb_queues; q++)
+		while (do_rx_burst(pid, q, bufs, BURST_SIZE, NULL) > 0 &&
+				rte_get_timer_cycles() < flush_deadline)
+			;
+}
+
+/*
+ * Helper: Write FD_MAC_TAG frames to the TAP fd so they appear as
+ * incoming packets on the netdev.
+ */
+static int
+do_tap_fd_tx_burst(int fd, unsigned int n)
+{
+	unsigned int i;
+	uint8_t frame[TEST_FRAME_LEN];
+
+	if (init_frame(frame, sizeof(frame), &FD_MAC_TAG) != 0)
+		return -1;
+
+	for (i = 0; i < n; i++) {
+		if (write(fd, frame, sizeof(frame)) != (ssize_t)sizeof(frame))
+			return -1;
+	}
+
+	return 0;
+}
+
 /*
  * Helper: Wait for stats to update by polling at intervals.
  * Returns 0 on success (stats updated), -1 on timeout.
@@ -576,7 +647,7 @@ test_af_packet_loopback(void)
 	struct rte_mbuf *tx_bufs[BURST_SIZE];
 	struct rte_mbuf *rx_bufs[BURST_SIZE];
 	uint16_t nb_tx;
-	unsigned int count_tagged = 0;
+	struct tag_count tag_count = {0};
 	uint64_t elapsed = 0;
 	unsigned int allocated;
 	char tap_buf[2048];
@@ -620,10 +691,10 @@ test_af_packet_loopback(void)
 		}
 
 		/* Try to receive via af_packet RX */
-		do_rx_burst(port_id, 0, rx_bufs, BURST_SIZE, &count_tagged);
+		do_rx_burst(port_id, 0, rx_bufs, BURST_SIZE, &tag_count);
 
 		/* Check if we've received enough */
-		if (count_tagged >= nb_tx)
+		if (tag_count.n_dev_tagged >= nb_tx)
 			break;
 
 		rte_delay_us_block(STATS_POLL_INTERVAL_US);
@@ -637,7 +708,7 @@ test_af_packet_loopback(void)
 	 * Note: We may not receive all packets due to timing, but receiving
 	 * any packets proves the loopback path works.
 	 */
-	printf("Loopback: TX=%u, RX=%u\n", nb_tx, count_tagged);
+	printf("Loopback: TX=%u, RX=%u\n", nb_tx, tag_count.n_dev_tagged);
 
 	return TEST_SUCCESS;
 }
@@ -1111,6 +1182,163 @@ test_af_packet_multithread(void)
 	return TEST_SUCCESS;
 }
 
+/*
+ * Test: Ignore outgoing configuration
+ *
+ * By default an AF_PACKET socket sees frames sent by other sockets on
+ * the same interface. ignore_outgoing filters those out. This test
+ * uses a second vdev to generate outgoing traffic. It also writes to
+ * the TAP fd to generate incoming traffic, so that a dead RX port can
+ * be distinguished from one which filtered the outgoing frames.
+ */
+static int
+test_af_packet_ignore_outgoing(uint16_t nb_queues, bool ignore_outgoing)
+{
+	struct rte_mbuf *bufs[BURST_SIZE];
+	uint16_t tx_port, rx_port, nb_tx, q;
+	struct tag_count tag_count = {0};
+	unsigned int allocated;
+	const unsigned int n_inject = 4;
+	uint64_t elapsed = 0;
+	const char *err = NULL;
+	bool have_rx = false;
+	bool have_tx = false;
+	char args[128];
+	int ret;
+
+	if (!tap_created) {
+		printf("SKIPPED: TAP interface not available (need root)\n");
+		return TEST_SKIPPED;
+	}
+
+	snprintf(args, sizeof(args),
+		 "iface=%s,qpairs=%u,ignore_outgoing=%u",
+		 TAP_DEV_NAME, nb_queues, ignore_outgoing ? 1 : 0);
+	ret = create_af_packet_port("net_af_packet_ign_rx", args, &rx_port);
+	if (ret != 0) {
+		err = "Failed to create RX af_packet port";
+		goto out;
+	}
+	have_rx = true;
+
+	/* qdisc_bypass=0 so other AF_PACKET sockets see this TX */
+	ret = create_af_packet_port("net_af_packet_ign_tx",
+			"iface=" TAP_DEV_NAME ",qdisc_bypass=0", &tx_port);
+	if (ret != 0) {
+		err = "Failed to create TX af_packet port";
+		goto out;
+	}
+	have_tx = true;
+
+	if (configure_af_packet_port(rx_port, nb_queues, nb_queues) != 0 ||
+	    configure_af_packet_port(tx_port, 1, 1) != 0) {
+		err = "Failed to configure ports";
+		goto out;
+	}
+
+	flush_rx_port(rx_port, nb_queues);
+
+	/* send outgoing packets from the TX af_packet port */
+	allocated = alloc_tx_mbufs(bufs, 4);
+	nb_tx = do_tx_burst(tx_port, 0, bufs, allocated);
+	if (allocated == 0 || nb_tx == 0) {
+		err = "TX setup failed";
+		goto out;
+	}
+
+	/* inject incoming packets on the TAP */
+	if (do_tap_fd_tx_burst(tap_fd, n_inject) != 0) {
+		err = "TAP inject failed";
+		goto out;
+	}
+
+	/* wait long enough for frames to arrive */
+	while (elapsed < LOOPBACK_TIMEOUT_US) {
+		for (q = 0; q < nb_queues; q++)
+			do_rx_burst(rx_port, q, bufs, BURST_SIZE, &tag_count);
+		if (!ignore_outgoing &&
+		    tag_count.n_dev_tagged >= nb_tx &&
+		    tag_count.n_fd_tagged > 0)
+			break;
+		rte_delay_us_block(STATS_POLL_INTERVAL_US);
+		elapsed += STATS_POLL_INTERVAL_US;
+	}
+
+out:
+	if (have_tx) {
+		rte_eth_dev_stop(tx_port);
+		rte_eth_dev_close(tx_port);
+		rte_vdev_uninit("net_af_packet_ign_tx");
+	}
+	if (have_rx) {
+		rte_eth_dev_stop(rx_port);
+		rte_eth_dev_close(rx_port);
+		rte_vdev_uninit("net_af_packet_ign_rx");
+	}
+
+	TEST_ASSERT(err == NULL, "%s", err);
+	TEST_ASSERT(tag_count.n_fd_tagged > 0,
+		"Expected frames written to the TAP fd");
+	if (ignore_outgoing)
+		TEST_ASSERT(tag_count.n_dev_tagged == 0,
+			"Expected no outgoing frames with ignore_outgoing");
+	else
+		TEST_ASSERT(tag_count.n_dev_tagged > 0,
+			"Expected outgoing frames with ignore_outgoing=0");
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test: invalid ignore_outgoing value
+ */
+static int
+test_af_packet_invalid_ignore_outgoing(void)
+{
+	int ret;
+
+	if (!tap_created) {
+		printf("SKIPPED: TAP interface not available (need root)\n");
+		return TEST_SKIPPED;
+	}
+
+	ret = rte_vdev_init("net_af_packet_ign_bad",
+			    "iface=" TAP_DEV_NAME ",ignore_outgoing=2");
+	TEST_ASSERT(ret != 0, "Expected failure with ignore_outgoing=2");
+
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test: Ignore outgoing for one queue
+ */
+static int
+test_af_packet_ignore_outgoing_single_queue(void)
+{
+	int ret;
+
+	ret = test_af_packet_ignore_outgoing(1, true);
+	if (ret != TEST_SUCCESS)
+		return ret;
+
+	return test_af_packet_ignore_outgoing(1, false);
+}
+
+/*
+ * Test: Ignore outgoing for multiple queues
+ */
+static int
+test_af_packet_ignore_outgoing_multi_queue(void)
+{
+	int ret;
+
+	ret = test_af_packet_ignore_outgoing(2, true);
+	if (ret != TEST_SUCCESS)
+		return ret;
+
+	return test_af_packet_ignore_outgoing(2, false);
+}
+
 static struct unit_test_suite af_packet_test_suite = {
 	.suite_name = "AF_PACKET PMD Unit Test Suite",
 	.setup = test_af_packet_setup,
@@ -1136,6 +1364,9 @@ static struct unit_test_suite af_packet_test_suite = {
 		TEST_CASE(test_af_packet_frame_config),
 		TEST_CASE(test_af_packet_qdisc_bypass),
 		TEST_CASE(test_af_packet_multi_queue),
+		TEST_CASE(test_af_packet_invalid_ignore_outgoing),
+		TEST_CASE(test_af_packet_ignore_outgoing_single_queue),
+		TEST_CASE(test_af_packet_ignore_outgoing_multi_queue),
 
 		TEST_CASES_END() /**< NULL terminate unit test array */
 	}
diff --git a/doc/guides/nics/af_packet.rst b/doc/guides/nics/af_packet.rst
index 1505b98ff7..45adbbf8b2 100644
--- a/doc/guides/nics/af_packet.rst
+++ b/doc/guides/nics/af_packet.rst
@@ -25,6 +25,8 @@ Some of these, in turn, will be used to configure the PACKET_MMAP settings.
     disabled by default);
 *   ``fanout_mode`` - set fanout algorithm.
     Possible choices: hash, lb, cpu, rollover, rnd, qm (optional, default hash);
+*   ``ignore_outgoing`` - ``rte_eth_rx_burst()`` returns only incoming
+    packets (optional, disabled by default);
 *   ``blocksz`` - PACKET_MMAP block size (optional, default 4096);
 *   ``framesz`` - PACKET_MMAP frame size (optional, default 2048B; Note: multiple
     of 16B);
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 207df3eca2..4bbb3333ce 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -114,6 +114,11 @@ New Features
   Added internal ``flow_graph`` API in ethdev
   for PMD drivers to build graph-based flow pattern parsers.
 
+* **Updated AF_PACKET driver.**
+
+  Added ``ignore_outgoing`` so ``rte_eth_rx_burst()`` returns only incoming
+  packets.
+
 * **Updated AF_XDP driver.**
 
   * Changed the default device plugin endpoint path used when
diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index ef57719803..b744305e00 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -39,6 +39,7 @@
 #define ETH_AF_PACKET_FRAMECOUNT_ARG	"framecnt"
 #define ETH_AF_PACKET_QDISC_BYPASS_ARG	"qdisc_bypass"
 #define ETH_AF_PACKET_FANOUT_MODE_ARG	"fanout_mode"
+#define ETH_AF_PACKET_IGNORE_OUTGOING_ARG	"ignore_outgoing"
 
 #define DFLT_FRAME_SIZE		(1 << 11)
 #define DFLT_FRAME_COUNT	(1 << 9)
@@ -59,6 +60,7 @@ struct __rte_cache_aligned pkt_rx_queue {
 	uint8_t vlan_strip;
 	uint8_t timestamp_offloading;
 	uint8_t scatter_enabled;
+	uint8_t ignore_outgoing;
 
 	volatile unsigned long rx_pkts;
 	volatile unsigned long rx_bytes;
@@ -103,6 +105,7 @@ static const char *valid_arguments[] = {
 	ETH_AF_PACKET_FRAMECOUNT_ARG,
 	ETH_AF_PACKET_QDISC_BYPASS_ARG,
 	ETH_AF_PACKET_FANOUT_MODE_ARG,
+	ETH_AF_PACKET_IGNORE_OUTGOING_ARG,
 	NULL
 };
 
@@ -166,6 +169,7 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
 	unsigned i;
 	struct tpacket2_hdr *ppd;
+	struct sockaddr_ll *sll;
 	struct rte_mbuf *mbuf;
 	uint8_t *pbuf;
 	struct pkt_rx_queue *pkt_q = queue;
@@ -189,6 +193,14 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		if ((ppd->tp_status & TP_STATUS_USER) == 0)
 			break;
 
+		/* skip outgoing frames if ignore_outgoing is set */
+		if (pkt_q->ignore_outgoing != 0) {
+			sll = (struct sockaddr_ll *)((uint8_t *)ppd +
+					TPACKET_ALIGN(sizeof(*ppd)));
+			if (sll->sll_pkttype == PACKET_OUTGOING)
+				goto release_frame;
+		}
+
 		/* allocate the next mbuf */
 		mbuf = rte_pktmbuf_alloc(pkt_q->mb_pool);
 		if (unlikely(mbuf == NULL)) {
@@ -877,6 +889,7 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 		       unsigned int framecnt,
 		       unsigned int qdisc_bypass,
 		       const char *fanout_mode,
+		       unsigned int ignore_outgoing,
 		       struct pmd_internals **internals,
 		       struct rte_eth_dev **eth_dev,
 		       struct rte_kvargs *kvlist)
@@ -1043,6 +1056,7 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 
 		rx_queue = &((*internals)->rx_queue[q]);
 		rx_queue->framecount = req->tp_frame_nr;
+		rx_queue->ignore_outgoing = ignore_outgoing != 0;
 
 		rx_queue->map = mmap(NULL, 2 * req->tp_block_size * req->tp_block_nr,
 				    PROT_READ | PROT_WRITE, MAP_SHARED | MAP_LOCKED,
@@ -1206,6 +1220,7 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 	unsigned int qpairs = 1;
 	unsigned int qdisc_bypass = 1;
 	const char *fanout_mode = NULL;
+	unsigned int ignore_outgoing = 0;
 
 	/* do some parameter checking */
 	if (*sockfd < 0)
@@ -1272,6 +1287,11 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 			fanout_mode = pair->value;
 			continue;
 		}
+		if (strstr(pair->key, ETH_AF_PACKET_IGNORE_OUTGOING_ARG) != NULL) {
+			if (parse_uint(pair->key, pair->value, &ignore_outgoing, 1) < 0)
+				return -1;
+			continue;
+		}
 	}
 
 	if (framesize > blocksize) {
@@ -1298,12 +1318,14 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 		PMD_LOG(DEBUG, "%s:\tfanout mode %s", name, fanout_mode);
 	else
 		PMD_LOG(DEBUG, "%s:\tfanout mode %s", name, "default PACKET_FANOUT_HASH");
+	PMD_LOG(DEBUG, "%s:\tignore outgoing %d", name, ignore_outgoing);
 
 	if (rte_pmd_init_internals(dev, *sockfd, qpairs,
 				   blocksize, blockcount,
 				   framesize, framecount,
 				   qdisc_bypass,
 				   fanout_mode,
+				   ignore_outgoing,
 				   &internals, &eth_dev,
 				   kvlist) < 0)
 		return -1;
@@ -1401,4 +1423,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_af_packet,
 	"framesz=<int> "
 	"framecnt=<int> "
 	"qdisc_bypass=<0|1> "
-	"fanout_mode=<hash|lb|cpu|rollover|rnd|qm>");
+	"fanout_mode=<hash|lb|cpu|rollover|rnd|qm> "
+	"ignore_outgoing=<0|1>");
-- 
2.56.0

