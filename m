Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3BB2CA601D
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Oct 2026 15:11:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 98A25402D5;
	Fri,  9 Oct 2026 17:11:06 +0200 (CEST)
Received: from smtp06-ext.udag.de (smtp06-ext.udag.de [62.146.106.76])
 by mails.dpdk.org (Postfix) with ESMTP id 82D234025A
 for <dev@dpdk.org>; Fri,  9 Oct 2026 17:11:04 +0200 (CEST)
Received: from machine (unknown [37.228.233.98])
 by smtp06-ext.udag.de (Postfix) with ESMTPA id B2894E0265;
 Fri,  9 Oct 2026 17:11:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dressler.pro;
 s=uddkim-202310; t=1791558664;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=n7mVep3dx6XOsHXScUPZ4+9fnJV/b+W1uDRvMhkXsOQ=;
 b=Il1U+fJkJJ+vdKmrtvEv7U6qaY7rxKzr3Yngs+8+ph8JduxFNKKzJ5KIukmrjoks0DZ6pc
 5QJB/tOvB5lXm1DSCKY5KrT2kK8zSZicbOogP9FwICYu8cB4GtQvGFTfVWR7JCFWvxZH3H
 UeRL9B+zCR5IM0eTdEquW3D99JGuA0Te7XdH6E9t2CXUK+Vln3kGtsextY6ZNGbcrj0o35
 Eb5bqfTQT0TFdsRGJs94miAB4Bg8Cw/G8mPY911D9HT2cWBkcW/KuYHXSOvLnh47qEvim4
 R/lXMrOocb1ecXTm5/U3s/WdGDPSIeEf7WYXgls+kL696eZowwtpjjoNZ1TCig==
Authentication-Results: smtp06-ext.udag.de;
 auth=pass smtp.auth=dressler-pro-0001 smtp.mailfrom=frank@dressler.pro
From: Frank Dressler <frank@dressler.pro>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: dev@dpdk.org
Subject: [PATCH v5 1/3] net/af_packet: filter Rx of outgoing packets in the PMD
Date: Fri,  9 Oct 2026 16:10:13 +0100
Message-ID: <20261009151015.742011-2-frank@dressler.pro>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261009151015.742011-1-frank@dressler.pro>
References: <20261005002809.1676723-1-frank@dressler.pro>
 <20261009151015.742011-1-frank@dressler.pro>
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

In contrast to other PMDs, the AF_PACKET PMD does not only return
incoming but also outgoing packets from rte_eth_rx_burst(). This is
fine for applications similar to tcpdump which usually want to see
both.

But this is not always the desired behavior. For example, the
AF_PACKET PMD might be used in a testing environment in which no
regular ethernet PMD is available. In that testing environment, the
PMD must behave like a regular one, i.e. not return sent packets
from rte_eth_rx_burst().

For this reason, this change adds the ignore_outgoing=<0|1> devarg.
When set, the PMD ensures that rte_eth_rx_burst() only returns
incoming traffic. The default is 0 so that existing software works
as before.

Signed-off-by: Frank Dressler <frank@dressler.pro>
---
 .mailmap                                  |   1 +
 app/test/test_pmd_af_packet.c             | 150 ++++++++++++++++++++++
 doc/guides/nics/af_packet.rst             |   2 +
 doc/guides/rel_notes/release_26_11.rst    |   5 +
 drivers/net/af_packet/rte_eth_af_packet.c |  25 +++-
 5 files changed, 182 insertions(+), 1 deletion(-)

diff --git a/.mailmap b/.mailmap
index 2e348c3bce..a04fc553d4 100644
--- a/.mailmap
+++ b/.mailmap
@@ -505,6 +505,7 @@ Francis Kelly <fkelly@nvidia.com> <fkelly@mellanox.com>
 Francis Racicot <francis.racicot@intel.com>
 Franck Lenormand <franck.lenormand@nxp.com>
 François-Frédéric Ozog <ff@ozog.com>
+Frank Dressler <frank@dressler.pro>
 Frank Du <frank.du@intel.com>
 Frank Zhao <frank.zhao@starfivetech.com>
 Frederico Cadete <frederico.cadete-ext@oneaccess-net.com>
diff --git a/app/test/test_pmd_af_packet.c b/app/test/test_pmd_af_packet.c
index b668ca5b81..5dd72c35cf 100644
--- a/app/test/test_pmd_af_packet.c
+++ b/app/test/test_pmd_af_packet.c
@@ -1083,6 +1083,153 @@ test_af_packet_multithread(void)
 	return TEST_SUCCESS;
 }
 
+/*
+ * Test: Ignore outgoing configuration
+ */
+static int
+test_af_packet_ignore_outgoing_queues(uint16_t nb_queues, bool ignore_outgoing)
+{
+	struct rte_mbuf *bufs[BURST_SIZE];
+	uint16_t tx_port, rx_port, nb_tx, q;
+	unsigned int rx_pkts = 0, allocated;
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
+	/* qdisc_bypass=0 so the kernel TX path sees the TX packets */
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
+	/* flush the RX port */
+	for (q = 0; q < nb_queues; q++)
+		while (do_rx_burst(rx_port, q, bufs, BURST_SIZE) > 0)
+			;
+
+	/* send packets */
+	allocated = alloc_tx_mbufs(bufs, 4);
+	nb_tx = do_tx_burst(tx_port, 0, bufs, allocated);
+	if (allocated == 0 || nb_tx == 0) {
+		err = "TX setup failed";
+		goto out;
+	}
+
+	/* receive packets */
+	while (elapsed < LOOPBACK_TIMEOUT_US) {
+		for (q = 0; q < nb_queues; q++)
+			rx_pkts += do_rx_burst(rx_port, q, bufs, BURST_SIZE);
+		if (ignore_outgoing) {
+			if (rx_pkts != 0)
+				break;
+		} else if (rx_pkts >= nb_tx)
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
+	if (ignore_outgoing)
+		TEST_ASSERT(rx_pkts == 0,
+			"ignore_outgoing port with %u queues saw outgoing packets",
+			nb_queues);
+	else
+		TEST_ASSERT(rx_pkts > 0,
+			"port with %u queues and ignore_outgoing=0 saw no packets",
+			nb_queues);
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
+test_af_packet_ignore_outgoing(void)
+{
+	int ret;
+
+	ret = test_af_packet_ignore_outgoing_queues(1, true);
+	if (ret != TEST_SUCCESS)
+		return ret;
+
+	return test_af_packet_ignore_outgoing_queues(1, false);
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
+	ret = test_af_packet_ignore_outgoing_queues(2, true);
+	if (ret != TEST_SUCCESS)
+		return ret;
+
+	return test_af_packet_ignore_outgoing_queues(2, false);
+}
+
 static struct unit_test_suite af_packet_test_suite = {
 	.suite_name = "AF_PACKET PMD Unit Test Suite",
 	.setup = test_af_packet_setup,
@@ -1108,6 +1255,9 @@ static struct unit_test_suite af_packet_test_suite = {
 		TEST_CASE(test_af_packet_frame_config),
 		TEST_CASE(test_af_packet_qdisc_bypass),
 		TEST_CASE(test_af_packet_multi_queue),
+		TEST_CASE(test_af_packet_invalid_ignore_outgoing),
+		TEST_CASE(test_af_packet_ignore_outgoing),
+		TEST_CASE(test_af_packet_ignore_outgoing_multi_queue),
 
 		TEST_CASES_END() /**< NULL terminate unit test array */
 	}
diff --git a/doc/guides/nics/af_packet.rst b/doc/guides/nics/af_packet.rst
index 1505b98ff7..fe42180d4e 100644
--- a/doc/guides/nics/af_packet.rst
+++ b/doc/guides/nics/af_packet.rst
@@ -25,6 +25,8 @@ Some of these, in turn, will be used to configure the PACKET_MMAP settings.
     disabled by default);
 *   ``fanout_mode`` - set fanout algorithm.
     Possible choices: hash, lb, cpu, rollover, rnd, qm (optional, default hash);
+*   ``ignore_outgoing`` - prevent `rte_eth_rx_burst()` from returning transmitted
+    packets (optional, disabled by default);
 *   ``blocksz`` - PACKET_MMAP block size (optional, default 4096);
 *   ``framesz`` - PACKET_MMAP frame size (optional, default 2048B; Note: multiple
     of 16B);
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 030bd84cea..daf5603a41 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -64,6 +64,11 @@ New Features
 
   Added ``rte_vlan_insert_tpid()`` to the net library.
 
+* **Updated AF_PACKET driver.**
+
+  Added ``ignore_outgoing`` vdev argument to prevent `rte_eth_rx_burst()` from
+  returning transmitted packets.
+
 * **Updated AF_XDP driver.**
 
   * Changed the default device plugin endpoint path used when
diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index a93df97023..837da9a3af 100644
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

