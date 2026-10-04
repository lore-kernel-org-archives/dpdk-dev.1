Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD633CA5FE4
	for <dpdk-dev@archiver.kernel.org>; Sun,  4 Oct 2026 04:23:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 599E14028C;
	Sun,  4 Oct 2026 06:23:12 +0200 (CEST)
Received: from smtp03-ext2.udag.de (smtp03-ext2.udag.de [62.146.106.30])
 by mails.dpdk.org (Postfix) with ESMTP id EFD694027F
 for <dev@dpdk.org>; Sun,  4 Oct 2026 06:23:10 +0200 (CEST)
Received: from machine (unknown [37.228.233.98])
 by smtp03-ext2.udag.de (Postfix) with ESMTPA id 7B5C2E03C3;
 Sun,  4 Oct 2026 06:23:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dressler.pro;
 s=uddkim-202310; t=1791087789;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+GX+FEoGCtatm3IE42PQzAzHjjWruF3skgz19m2imrs=;
 b=dx401cEwjW8EKk1gyvgWYYhNPia+eVRw3f2ANUlwDa3XKlZFluu7Lh7YNSogHYlouwPkJb
 /O6pmnduLOjXDk0T06HKjR6a+KjS//tyWlF+IlO/VKhubJLaToNeBKuLaUKD3ayWgOScj/
 YBaKU4QuRj4rPLdGbs5aeN2zTFoiaQfdvFR81tpRoBVhKnNQsAUzcy26L2c9OXWkYdcWtd
 +jS0QL0Yu07yp/6AfbGZBvLdC0rGs1ARrk8roFZcGIJUqIMBwXz4WFMq4uqlR/jgJpYhIr
 G726zzSTsC1dbEuT9wjFd7H2Amri9ITAfxLfYihbeZ+6KJKNmKZXYCj8LgJb/g==
Authentication-Results: smtp03-ext2.udag.de;
 auth=pass smtp.auth=dressler-pro-0001 smtp.mailfrom=frank@dressler.pro
From: Frank Dressler <frank@dressler.pro>
To: dev@dpdk.org
Cc: Frank Dressler <frank@dressler.pro>, Thomas Monjalon <thomas@monjalon.net>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH] net/af_packet: add capture direction option
Date: Sun,  4 Oct 2026 05:22:54 +0100
Message-ID: <20261004042255.1517316-1-frank@dressler.pro>
X-Mailer: git-send-email 2.56.0
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

By default, AF_PACKET sockets capture both incoming and outgoing
packets. This leads to unexpected behavior in the AF_PACKET PMD
since other PMDs only return actually received packets in
rte_eth_rx_burst() calls.

This patch adds an option capture_dir=<in|out|inout> that controls
which packets are received, similar to tcpdump's -Q option.

The PMD never sees its own TX on RX, but TX from other sources on
the same netdev is still seen. Use inout for tcpdump-like tools and
in for applications that send and receive.

The default is "inout" so that existing software keeps working as
before.

The filter checks the packet type in the struct sockaddr_ll that
comes with each packet. Each TPACKET_V2 packet is laid out as
  struct tpacket2_hdr | struct sockaddr_ll | packet data.
The kernel sets sockaddr_ll::sll_pkttype to skb->pkt_type, which is
PACKET_OUTGOING for outgoing packets (set by dev_queue_xmit_nit())
and a different value otherwise. Libpcap's linux_check_direction()
uses the same check.

A unit test injects OUTGOING traffic from a second port on the same
TAP and checks in/out/inout filtering.

Signed-off-by: Frank Dressler <frank@dressler.pro>
---
 .mailmap                                  |   1 +
 app/test/test_pmd_af_packet.c             | 101 ++++++++++++++++++++++
 doc/guides/nics/af_packet.rst             |   2 +
 doc/guides/rel_notes/release_26_11.rst    |   4 +
 drivers/net/af_packet/rte_eth_af_packet.c |  59 ++++++++++++-
 5 files changed, 166 insertions(+), 1 deletion(-)

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
index b668ca5b81..8c8c8f6612 100644
--- a/app/test/test_pmd_af_packet.c
+++ b/app/test/test_pmd_af_packet.c
@@ -913,6 +913,106 @@ test_af_packet_qdisc_bypass(void)
 	return TEST_SUCCESS;
 }
 
+/*
+ * Test: capture_dir in/out/inout.
+ * Send packets; "in" must receive none, "out" and "inout" must receive them.
+ */
+static int
+test_af_packet_capture_dir(void)
+{
+	static const char * const modes[] = {"in", "out", "inout"};
+	static const char * const names[] = {
+		"net_af_packet_cap_in",
+		"net_af_packet_cap_out",
+		"net_af_packet_cap_inout",
+	};
+	struct rte_mbuf *bufs[BURST_SIZE];
+	uint16_t tx_port, rx_ports[RTE_DIM(modes)], nb_tx;
+	unsigned int rx[RTE_DIM(modes)] = {0};
+	unsigned int m, i, n_rx = 0, allocated;
+	uint64_t elapsed = 0;
+	const char *err = NULL;
+	char args[128];
+	int ret;
+
+	if (!tap_created) {
+		printf("SKIPPED: TAP interface not available (need root)\n");
+		return TEST_SKIPPED;
+	}
+
+	/* qdisc_bypass=0 so the kernel TX tap sees the TX packets */
+	ret = create_af_packet_port("net_af_packet_cap_tx",
+				    "iface=" TAP_DEV_NAME ",qdisc_bypass=0",
+				    &tx_port);
+	TEST_ASSERT(ret == 0, "Failed to create TX af_packet port");
+	ret = configure_af_packet_port(tx_port, 1, 1);
+	if (ret != 0) {
+		err = "Failed to configure TX af_packet port";
+		goto out;
+	}
+
+	/* Create all three capture_dir variants: in, out, and inout */
+	for (m = 0; m < RTE_DIM(modes); m++) {
+		snprintf(args, sizeof(args), "iface=%s,capture_dir=%s",
+			 TAP_DEV_NAME, modes[m]);
+		ret = create_af_packet_port(names[m], args, &rx_ports[m]);
+		if (ret != 0) {
+			err = "Failed to create capture_dir port";
+			goto out;
+		}
+		n_rx++;
+		ret = configure_af_packet_port(rx_ports[m], 1, 1);
+		if (ret != 0) {
+			err = "Failed to configure capture_dir port";
+			goto out;
+		}
+	}
+
+	/* Drain stale packets */
+	for (m = 0; m < n_rx; m++)
+		while (do_rx_burst(rx_ports[m], 0, bufs, BURST_SIZE) > 0)
+			;
+
+	/* Inject packets */
+	allocated = alloc_tx_mbufs(bufs, 4);
+	nb_tx = do_tx_burst(tx_port, 0, bufs, allocated);
+	if (allocated == 0 || nb_tx == 0) {
+		err = "TX setup failed";
+		goto out;
+	}
+
+	while (elapsed < LOOPBACK_TIMEOUT_US) {
+		for (m = 0; m < n_rx; m++)
+			rx[m] += do_rx_burst(rx_ports[m], 0, bufs, BURST_SIZE);
+		if (rx[1] >= nb_tx && rx[2] >= nb_tx)
+			break;
+		rte_delay_us_block(STATS_POLL_INTERVAL_US);
+		elapsed += STATS_POLL_INTERVAL_US;
+	}
+
+out:
+	for (i = 0; i < n_rx; i++) {
+		rte_eth_dev_stop(rx_ports[i]);
+		rte_eth_dev_close(rx_ports[i]);
+		rte_vdev_uninit(names[i]);
+	}
+	rte_eth_dev_stop(tx_port);
+	rte_eth_dev_close(tx_port);
+	rte_vdev_uninit("net_af_packet_cap_tx");
+
+	TEST_ASSERT(err == NULL, "%s", err);
+
+	TEST_ASSERT(rx[0] == 0, "Expected no packets with capture_dir=in");
+	TEST_ASSERT(rx[1] > 0, "Expected packets with capture_dir=out");
+	TEST_ASSERT(rx[2] > 0, "Expected packets with capture_dir=inout");
+
+	ret = rte_vdev_init("net_af_packet_cap_bad",
+			    "iface=" TAP_DEV_NAME ",capture_dir=bogus");
+	TEST_ASSERT(ret != 0, "Expected failure with capture_dir=bogus");
+
+	return TEST_SUCCESS;
+}
+
 /*
  * Test: Multiple queue pairs
  */
@@ -1107,6 +1207,7 @@ static struct unit_test_suite af_packet_test_suite = {
 		TEST_CASE(test_af_packet_invalid_qpairs),
 		TEST_CASE(test_af_packet_frame_config),
 		TEST_CASE(test_af_packet_qdisc_bypass),
+		TEST_CASE(test_af_packet_capture_dir),
 		TEST_CASE(test_af_packet_multi_queue),
 
 		TEST_CASES_END() /**< NULL terminate unit test array */
diff --git a/doc/guides/nics/af_packet.rst b/doc/guides/nics/af_packet.rst
index 1505b98ff7..a10927e6e6 100644
--- a/doc/guides/nics/af_packet.rst
+++ b/doc/guides/nics/af_packet.rst
@@ -25,6 +25,8 @@ Some of these, in turn, will be used to configure the PACKET_MMAP settings.
     disabled by default);
 *   ``fanout_mode`` - set fanout algorithm.
     Possible choices: hash, lb, cpu, rollover, rnd, qm (optional, default hash);
+*   ``capture_dir`` - select which packet directions to receive.
+    Possible choices: in, out, inout (optional, default inout);
 *   ``blocksz`` - PACKET_MMAP block size (optional, default 4096);
 *   ``framesz`` - PACKET_MMAP frame size (optional, default 2048B; Note: multiple
     of 16B);
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 030bd84cea..769f55337c 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -64,6 +64,10 @@ New Features
 
   Added ``rte_vlan_insert_tpid()`` to the net library.
 
+* **Updated af_packet net driver.**
+
+  * Added ``capture_dir`` option to select ingress, egress, or both.
+
 * **Updated AF_XDP driver.**
 
   * Changed the default device plugin endpoint path used when
diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index a93df97023..88cdca61f9 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -39,10 +39,18 @@
 #define ETH_AF_PACKET_FRAMECOUNT_ARG	"framecnt"
 #define ETH_AF_PACKET_QDISC_BYPASS_ARG	"qdisc_bypass"
 #define ETH_AF_PACKET_FANOUT_MODE_ARG	"fanout_mode"
+#define ETH_AF_PACKET_CAPTURE_DIR_ARG	"capture_dir"
 
 #define DFLT_FRAME_SIZE		(1 << 11)
 #define DFLT_FRAME_COUNT	(1 << 9)
 
+enum rte_af_packet_capture_dir {
+	RTE_AF_PACKET_CAPTURE_DIR_INVALID = -1,
+	RTE_AF_PACKET_CAPTURE_DIR_IN,
+	RTE_AF_PACKET_CAPTURE_DIR_OUT,
+	RTE_AF_PACKET_CAPTURE_DIR_INOUT,
+};
+
 static uint64_t timestamp_dynflag;
 static int timestamp_dynfield_offset = -1;
 
@@ -59,6 +67,7 @@ struct __rte_cache_aligned pkt_rx_queue {
 	uint8_t vlan_strip;
 	uint8_t timestamp_offloading;
 	uint8_t scatter_enabled;
+	uint8_t capture_dir;
 
 	volatile unsigned long rx_pkts;
 	volatile unsigned long rx_bytes;
@@ -103,6 +112,7 @@ static const char *valid_arguments[] = {
 	ETH_AF_PACKET_FRAMECOUNT_ARG,
 	ETH_AF_PACKET_QDISC_BYPASS_ARG,
 	ETH_AF_PACKET_FANOUT_MODE_ARG,
+	ETH_AF_PACKET_CAPTURE_DIR_ARG,
 	NULL
 };
 
@@ -166,6 +176,7 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
 	unsigned i;
 	struct tpacket2_hdr *ppd;
+	struct sockaddr_ll *sll;
 	struct rte_mbuf *mbuf;
 	uint8_t *pbuf;
 	struct pkt_rx_queue *pkt_q = queue;
@@ -189,6 +200,18 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		if ((ppd->tp_status & TP_STATUS_USER) == 0)
 			break;
 
+		/* drop frames that do not match capture_dir */
+		if (pkt_q->capture_dir != RTE_AF_PACKET_CAPTURE_DIR_INOUT) {
+			sll = (struct sockaddr_ll *)((char *)ppd + TPACKET_ALIGN(sizeof(*ppd)));
+			if (sll->sll_pkttype == PACKET_OUTGOING) {
+				if (pkt_q->capture_dir == RTE_AF_PACKET_CAPTURE_DIR_IN)
+					goto release_frame;
+			} else {
+				if (pkt_q->capture_dir == RTE_AF_PACKET_CAPTURE_DIR_OUT)
+					goto release_frame;
+			}
+		}
+
 		/* allocate the next mbuf */
 		mbuf = rte_pktmbuf_alloc(pkt_q->mb_pool);
 		if (unlikely(mbuf == NULL)) {
@@ -867,6 +890,20 @@ get_fanout(const char *fanout_mode, int if_index)
 		return PACKET_FANOUT_INVALID;
 }
 
+static enum rte_af_packet_capture_dir
+get_capture_dir(const char *capture_dir)
+{
+	if (!capture_dir)
+		return RTE_AF_PACKET_CAPTURE_DIR_INOUT;
+	if (!strcmp(capture_dir, "in"))
+		return RTE_AF_PACKET_CAPTURE_DIR_IN;
+	if (!strcmp(capture_dir, "out"))
+		return RTE_AF_PACKET_CAPTURE_DIR_OUT;
+	if (!strcmp(capture_dir, "inout"))
+		return RTE_AF_PACKET_CAPTURE_DIR_INOUT;
+	return RTE_AF_PACKET_CAPTURE_DIR_INVALID;
+}
+
 static int
 rte_pmd_init_internals(struct rte_vdev_device *dev,
 		       const int sockfd,
@@ -877,6 +914,7 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 		       unsigned int framecnt,
 		       unsigned int qdisc_bypass,
 		       const char *fanout_mode,
+		       const char *capture_dir,
 		       struct pmd_internals **internals,
 		       struct rte_eth_dev **eth_dev,
 		       struct rte_kvargs *kvlist)
@@ -896,6 +934,7 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 	int qsockfd = -1;
 	unsigned int i, q, rdsize;
 	int fanout_arg;
+	enum rte_af_packet_capture_dir capture_arg;
 
 	for (k_idx = 0; k_idx < kvlist->count; k_idx++) {
 		pair = &kvlist->pairs[k_idx];
@@ -982,6 +1021,12 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 		goto error;
 	}
 
+	capture_arg = get_capture_dir(capture_dir);
+	if (capture_arg == RTE_AF_PACKET_CAPTURE_DIR_INVALID) {
+		PMD_LOG(ERR, "Invalid capture_dir: %s", capture_dir);
+		goto error;
+	}
+
 	for (q = 0; q < nb_queues; q++) {
 		/* Open an AF_PACKET socket for this queue... */
 		qsockfd = socket(AF_PACKET, SOCK_RAW, 0);
@@ -1043,6 +1088,7 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 
 		rx_queue = &((*internals)->rx_queue[q]);
 		rx_queue->framecount = req->tp_frame_nr;
+		rx_queue->capture_dir = capture_arg;
 
 		rx_queue->map = mmap(NULL, 2 * req->tp_block_size * req->tp_block_nr,
 				    PROT_READ | PROT_WRITE, MAP_SHARED | MAP_LOCKED,
@@ -1206,6 +1252,7 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 	unsigned int qpairs = 1;
 	unsigned int qdisc_bypass = 1;
 	const char *fanout_mode = NULL;
+	const char *capture_dir = NULL;
 
 	/* do some parameter checking */
 	if (*sockfd < 0)
@@ -1272,6 +1319,10 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 			fanout_mode = pair->value;
 			continue;
 		}
+		if (strstr(pair->key, ETH_AF_PACKET_CAPTURE_DIR_ARG) != NULL) {
+			capture_dir = pair->value;
+			continue;
+		}
 	}
 
 	if (framesize > blocksize) {
@@ -1298,12 +1349,17 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 		PMD_LOG(DEBUG, "%s:\tfanout mode %s", name, fanout_mode);
 	else
 		PMD_LOG(DEBUG, "%s:\tfanout mode %s", name, "default PACKET_FANOUT_HASH");
+	if (capture_dir)
+		PMD_LOG(DEBUG, "%s:\tcapture_dir %s", name, capture_dir);
+	else
+		PMD_LOG(DEBUG, "%s:\tcapture_dir %s", name, "default inout");
 
 	if (rte_pmd_init_internals(dev, *sockfd, qpairs,
 				   blocksize, blockcount,
 				   framesize, framecount,
 				   qdisc_bypass,
 				   fanout_mode,
+				   capture_dir,
 				   &internals, &eth_dev,
 				   kvlist) < 0)
 		return -1;
@@ -1401,4 +1457,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_af_packet,
 	"framesz=<int> "
 	"framecnt=<int> "
 	"qdisc_bypass=<0|1> "
-	"fanout_mode=<hash|lb|cpu|rollover|rnd|qm>");
+	"fanout_mode=<hash|lb|cpu|rollover|rnd|qm> "
+	"capture_dir=<in|out|inout>");
-- 
2.56.0

