Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E13CA5FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Oct 2026 00:28:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7192E402B5;
	Mon,  5 Oct 2026 02:28:20 +0200 (CEST)
Received: from smtp06-ext.udag.de (smtp06-ext.udag.de [62.146.106.76])
 by mails.dpdk.org (Postfix) with ESMTP id 688E040290
 for <dev@dpdk.org>; Mon,  5 Oct 2026 02:28:19 +0200 (CEST)
Received: from machine (unknown [37.228.233.98])
 by smtp06-ext.udag.de (Postfix) with ESMTPA id 822FFE02CB;
 Mon,  5 Oct 2026 02:28:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dressler.pro;
 s=uddkim-202310; t=1791160098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2mrkQMC8AlsXSfM5dzv9t/i9RKRRL09TTQA/iwPcWmc=;
 b=hIdThXX9KnS7t67/9x9EtU2mr361vkpj34fTmd0/XDYtrEz9APdMjaB2N12mV3rdXUyl/c
 ORm2uwN6TmWvt+534oeFgwaF4K1QrhdYIMWu2G+QcvGBpwCOVqyVpnk3TIG6B1hwdA5mQv
 x10W79XlOqVpgNCVr53YOaXji/HWJI0SmjZULIVZW9yUYFAWJ+ZXEhXsFephNej0oSet7m
 KZOgPgxTg/2Ep7v7kGXc9ww16Sh3+8oFSzPfrtldpLXp8DRTpyYGyt1RElk1yeW9TF3cCg
 pKXueNovlsTvNnb1+T2X3s0Ayqn10mHRiWLYIS0HpOPKJEaezyGvjpvacrT54Q==
Authentication-Results: smtp06-ext.udag.de;
 auth=pass smtp.auth=dressler-pro-0001 smtp.mailfrom=frank@dressler.pro
From: Frank Dressler <frank@dressler.pro>
To: dev@dpdk.org
Cc: Thomas Monjalon <thomas@monjalon.net>,
 Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v2] net/af_packet: add option to ignore outgoing packets
Date: Mon,  5 Oct 2026 01:28:09 +0100
Message-ID: <20261005002809.1676723-1-frank@dressler.pro>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261004042255.1517316-1-frank@dressler.pro>
References: <20261004042255.1517316-1-frank@dressler.pro>
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

By default, AF_PACKET delivers both incoming and outgoing packets.
This might surprise applications that expect rte_eth_rx_burst() to
return only incoming traffic.

This patch adds the option ignore_outgoing=<0|1> to enable
PACKET_IGNORE_OUTGOING (Linux 4.20+). When set, the kernel drops
outgoing frames. The default is 0 to keep the existing behavior.

Signed-off-by: Frank Dressler <frank@dressler.pro>
---
v2:
- use PACKET_IGNORE_OUTGOING / ignore_outgoing= instead of capture_dir

 .mailmap                                  |  1 +
 app/test/test_pmd_af_packet.c             | 97 +++++++++++++++++++++++
 doc/guides/nics/af_packet.rst             |  3 +
 doc/guides/rel_notes/release_26_11.rst    |  6 ++
 drivers/net/af_packet/rte_eth_af_packet.c | 27 ++++++-
 5 files changed, 133 insertions(+), 1 deletion(-)

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
index b668ca5b81..ee4a54d86a 100644
--- a/app/test/test_pmd_af_packet.c
+++ b/app/test/test_pmd_af_packet.c
@@ -913,6 +913,102 @@ test_af_packet_qdisc_bypass(void)
 	return TEST_SUCCESS;
 }
 
+/*
+ * Test: Ignore outgoing packets configuration
+ * TX on the TAP with qdisc_bypass=0 produces PACKET_OUTGOING frames.
+ * A peer with ignore_outgoing=0 should see them; ignore_outgoing=1 must not.
+ */
+static int
+test_af_packet_ignore_outgoing(void)
+{
+	struct rte_mbuf *bufs[BURST_SIZE];
+	uint16_t tx_port, rx_port_ign_out_off, rx_port_ign_out_on, nb_tx;
+	unsigned int rx_off = 0, rx_on = 0, allocated;
+	uint64_t elapsed = 0;
+	const char *err = NULL;
+	int ret;
+
+	if (!tap_created) {
+		printf("SKIPPED: TAP interface not available (need root)\n");
+		return TEST_SKIPPED;
+	}
+
+	ret = create_af_packet_port("net_af_packet_ign_on",
+			"iface=" TAP_DEV_NAME ",ignore_outgoing=1",
+			&rx_port_ign_out_on);
+	if (ret != 0) {
+		printf("SKIPPED: ignore_outgoing may not be supported\n");
+		return TEST_SKIPPED;
+	}
+
+	ret = create_af_packet_port("net_af_packet_ign_off",
+			"iface=" TAP_DEV_NAME ",ignore_outgoing=0",
+			&rx_port_ign_out_off);
+	if (ret != 0) {
+		err = "Failed to create ignore_outgoing=0 port";
+		goto out_rx_port_ign_out_on;
+	}
+
+	/* qdisc_bypass=0 so the kernel TX tap sees the TX packets */
+	ret = create_af_packet_port("net_af_packet_ign_tx",
+			"iface=" TAP_DEV_NAME ",qdisc_bypass=0", &tx_port);
+	if (ret != 0) {
+		err = "Failed to create TX af_packet port";
+		goto out_rx_port_ign_out_off;
+	}
+
+	if (configure_af_packet_port(rx_port_ign_out_on, 1, 1) != 0 ||
+	    configure_af_packet_port(rx_port_ign_out_off, 1, 1) != 0 ||
+	    configure_af_packet_port(tx_port, 1, 1) != 0) {
+		err = "Failed to configure ports";
+		goto out;
+	}
+
+	while (do_rx_burst(rx_port_ign_out_off, 0, bufs, BURST_SIZE) > 0)
+		;
+	while (do_rx_burst(rx_port_ign_out_on, 0, bufs, BURST_SIZE) > 0)
+		;
+
+	allocated = alloc_tx_mbufs(bufs, 4);
+	nb_tx = do_tx_burst(tx_port, 0, bufs, allocated);
+	if (allocated == 0 || nb_tx == 0) {
+		err = "TX setup failed";
+		goto out;
+	}
+
+	while (elapsed < LOOPBACK_TIMEOUT_US) {
+		rx_off += do_rx_burst(rx_port_ign_out_off, 0, bufs, BURST_SIZE);
+		rx_on += do_rx_burst(rx_port_ign_out_on, 0, bufs, BURST_SIZE);
+		if (rx_off >= nb_tx)
+			break;
+		rte_delay_us_block(STATS_POLL_INTERVAL_US);
+		elapsed += STATS_POLL_INTERVAL_US;
+	}
+
+out:
+	rte_eth_dev_stop(tx_port);
+	rte_eth_dev_close(tx_port);
+	rte_vdev_uninit("net_af_packet_ign_tx");
+out_rx_port_ign_out_off:
+	rte_eth_dev_stop(rx_port_ign_out_off);
+	rte_eth_dev_close(rx_port_ign_out_off);
+	rte_vdev_uninit("net_af_packet_ign_off");
+out_rx_port_ign_out_on:
+	rte_eth_dev_stop(rx_port_ign_out_on);
+	rte_eth_dev_close(rx_port_ign_out_on);
+	rte_vdev_uninit("net_af_packet_ign_on");
+
+	TEST_ASSERT(err == NULL, "%s", err);
+	TEST_ASSERT(rx_off > 0, "Expected packets with ignore_outgoing=0");
+	TEST_ASSERT(rx_on == 0, "Expected no packets with ignore_outgoing=1");
+
+	ret = rte_vdev_init("net_af_packet_ign_bad",
+			    "iface=" TAP_DEV_NAME ",ignore_outgoing=2");
+	TEST_ASSERT(ret != 0, "Expected failure with ignore_outgoing=2");
+
+	return TEST_SUCCESS;
+}
+
 /*
  * Test: Multiple queue pairs
  */
@@ -1107,6 +1203,7 @@ static struct unit_test_suite af_packet_test_suite = {
 		TEST_CASE(test_af_packet_invalid_qpairs),
 		TEST_CASE(test_af_packet_frame_config),
 		TEST_CASE(test_af_packet_qdisc_bypass),
+		TEST_CASE(test_af_packet_ignore_outgoing),
 		TEST_CASE(test_af_packet_multi_queue),
 
 		TEST_CASES_END() /**< NULL terminate unit test array */
diff --git a/doc/guides/nics/af_packet.rst b/doc/guides/nics/af_packet.rst
index 1505b98ff7..d1c04908dd 100644
--- a/doc/guides/nics/af_packet.rst
+++ b/doc/guides/nics/af_packet.rst
@@ -25,6 +25,9 @@ Some of these, in turn, will be used to configure the PACKET_MMAP settings.
     disabled by default);
 *   ``fanout_mode`` - set fanout algorithm.
     Possible choices: hash, lb, cpu, rollover, rnd, qm (optional, default hash);
+*   ``ignore_outgoing`` - set PACKET_IGNORE_OUTGOING so the socket does not
+    receive packets transmitted by the host on the same interface (optional,
+    default 0; requires Linux kernel >= 4.20);
 *   ``blocksz`` - PACKET_MMAP block size (optional, default 4096);
 *   ``framesz`` - PACKET_MMAP frame size (optional, default 2048B; Note: multiple
     of 16B);
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 030bd84cea..a7421cf9d4 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -64,6 +64,12 @@ New Features
 
   Added ``rte_vlan_insert_tpid()`` to the net library.
 
+* **Updated AF_PACKET driver.**
+
+  Added ``ignore_outgoing`` vdev argument to enable ``PACKET_IGNORE_OUTGOING``,
+  so the PMD does not receive packets transmitted by the host on the same
+  interface. Requires Linux kernel >= 4.20.
+
 * **Updated AF_XDP driver.**
 
   * Changed the default device plugin endpoint path used when
diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index a93df97023..efb32ad8a6 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -39,6 +39,7 @@
 #define ETH_AF_PACKET_FRAMECOUNT_ARG	"framecnt"
 #define ETH_AF_PACKET_QDISC_BYPASS_ARG	"qdisc_bypass"
 #define ETH_AF_PACKET_FANOUT_MODE_ARG	"fanout_mode"
+#define ETH_AF_PACKET_IGNORE_OUTGOING_ARG	"ignore_outgoing"
 
 #define DFLT_FRAME_SIZE		(1 << 11)
 #define DFLT_FRAME_COUNT	(1 << 9)
@@ -103,6 +104,7 @@ static const char *valid_arguments[] = {
 	ETH_AF_PACKET_FRAMECOUNT_ARG,
 	ETH_AF_PACKET_QDISC_BYPASS_ARG,
 	ETH_AF_PACKET_FANOUT_MODE_ARG,
+	ETH_AF_PACKET_IGNORE_OUTGOING_ARG,
 	NULL
 };
 
@@ -877,6 +879,7 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 		       unsigned int framecnt,
 		       unsigned int qdisc_bypass,
 		       const char *fanout_mode,
+		       unsigned int ignore_outgoing,
 		       struct pmd_internals **internals,
 		       struct rte_eth_dev **eth_dev,
 		       struct rte_kvargs *kvlist)
@@ -1025,6 +1028,19 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
 #endif
 		}
 
+		if (ignore_outgoing) {
+#if defined(PACKET_IGNORE_OUTGOING)
+			rc = setsockopt(qsockfd, SOL_PACKET, PACKET_IGNORE_OUTGOING,
+					&ignore_outgoing, sizeof(ignore_outgoing));
+			if (rc == -1) {
+				PMD_LOG_ERRNO(ERR,
+					"%s: could not set PACKET_IGNORE_OUTGOING on AF_PACKET socket for %s",
+					name, pair->value);
+				goto error;
+			}
+#endif
+		}
+
 		rc = setsockopt(qsockfd, SOL_PACKET, PACKET_RX_RING, req, sizeof(*req));
 		if (rc == -1) {
 			PMD_LOG_ERRNO(ERR,
@@ -1206,6 +1222,7 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 	unsigned int qpairs = 1;
 	unsigned int qdisc_bypass = 1;
 	const char *fanout_mode = NULL;
+	unsigned int ignore_outgoing = 0;
 
 	/* do some parameter checking */
 	if (*sockfd < 0)
@@ -1272,6 +1289,11 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
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
@@ -1298,12 +1320,14 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
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
@@ -1401,4 +1425,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_af_packet,
 	"framesz=<int> "
 	"framecnt=<int> "
 	"qdisc_bypass=<0|1> "
-	"fanout_mode=<hash|lb|cpu|rollover|rnd|qm>");
+	"fanout_mode=<hash|lb|cpu|rollover|rnd|qm> "
+	"ignore_outgoing=<0|1>");
-- 
2.56.0

