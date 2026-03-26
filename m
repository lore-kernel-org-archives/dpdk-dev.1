Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AEC110A62CA
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Mar 2026 13:22:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 58AFB4026A;
	Thu, 26 Mar 2026 14:22:11 +0100 (CET)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
 by mails.dpdk.org (Postfix) with ESMTP id C8343400EF
 for <dev@dpdk.org>; Thu, 26 Mar 2026 14:22:09 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1774531330; x=1806067330;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=MYNERmlnwRzC72e76axt2YtkotQvIk/JBkVW5MMkntg=;
 b=GTvgsuChDeziNyTt2s2X1Ahem6cWzvf4rEPB0PbDtKwIL+3elf5fdRkj
 BUJ6rB0dzxlYproDohVCq0/zvXZ0Z12iFk6WIwQ2QfgfSFX1Tjkn6iUP9
 SDHdzk85ywgKxglrOOPjmqbt5jUETH/FXVANYzfhSJs/qTmpmKsn2xNHl
 9RJFpk+a94R5ddhGp9PNtpcPs3j6m2IHCUcb5mCd5hg32ypoCepgHCVee
 1Bg4/110PKPWbZhLUC7RsVw2JNvCpAeLKLzn+1ndZFfBWH5n7UtyhVIa/
 52stGbpetf/KN5tymDavBGLGdMaRI6kFnsDmQvaJW5GXwk+IalHBfuEni Q==;
X-CSE-ConnectionGUID: xpUsuuJcSZ+tvMRMOj9JVw==
X-CSE-MsgGUID: Qwh6h1nyQkqX6V2CFY8/Qw==
X-IronPort-AV: E=McAfee;i="6800,10657,11740"; a="74616193"
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; d="scan'208";a="74616193"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
 by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 26 Mar 2026 06:22:08 -0700
X-CSE-ConnectionGUID: w/gyI48AR0GVaTT9qN+Hig==
X-CSE-MsgGUID: gVa5l/rZRMyKal64IirHrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,142,1770624000"; d="scan'208";a="224183208"
Received: from silpixa00401385.ir.intel.com ([10.20.224.226])
 by orviesa010.jf.intel.com with ESMTP; 26 Mar 2026 06:22:08 -0700
From: Bruce Richardson <bruce.richardson@intel.com>
To: dev@dpdk.org
Cc: Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH] test/event_eth_rx_intr_adapter: support NICs with fewer int
 vectors
Date: Thu, 26 Mar 2026 13:21:43 +0000
Message-ID: <20260326132142.565979-2-bruce.richardson@intel.com>
X-Mailer: git-send-email 2.51.0
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

Some NICs may not be able to support interrupts on all queues that are
advertised, which will cause the test to fail if the queues supporting
interrupts are fewer than 64. We can work around this by retrying the
NIC configuration multiple times with fewer queues in case of failure.
This allows the test to pass with NICs using ixgbe driver, for example.

Signed-off-by: Bruce Richardson <bruce.richardson@intel.com>
---
 app/test/test_event_eth_rx_adapter.c | 52 +++++++++++++++++-----------
 1 file changed, 32 insertions(+), 20 deletions(-)

diff --git a/app/test/test_event_eth_rx_adapter.c b/app/test/test_event_eth_rx_adapter.c
index ae428b3333..7b38935bec 100644
--- a/app/test/test_event_eth_rx_adapter.c
+++ b/app/test/test_event_eth_rx_adapter.c
@@ -60,6 +60,7 @@ port_init_common(uint16_t port, const struct rte_eth_conf *port_conf,
 {
 	const uint16_t rx_ring_size = 512, tx_ring_size = 512;
 	int retval;
+	bool started = false;
 	uint16_t q;
 	struct rte_eth_dev_info dev_info;
 
@@ -76,32 +77,43 @@ port_init_common(uint16_t port, const struct rte_eth_conf *port_conf,
 					MAX_NUM_RX_QUEUE);
 	default_params.tx_rings = 1;
 
-	/* Configure the Ethernet device. */
-	retval = rte_eth_dev_configure(port, default_params.rx_rings,
+	while (!started) {
+		/* Configure the Ethernet device. */
+		retval = rte_eth_dev_configure(port, default_params.rx_rings,
 				default_params.tx_rings, port_conf);
-	if (retval != 0)
-		return retval;
-
-	for (q = 0; q < default_params.rx_rings; q++) {
-		retval = rte_eth_rx_queue_setup(port, q, rx_ring_size,
-				rte_eth_dev_socket_id(port), NULL, mp);
-		if (retval < 0)
+		if (retval != 0)
 			return retval;
-	}
 
-	/* Allocate and set up 1 TX queue per Ethernet port. */
-	for (q = 0; q < default_params.tx_rings; q++) {
-		retval = rte_eth_tx_queue_setup(port, q, tx_ring_size,
-				rte_eth_dev_socket_id(port), NULL);
-		if (retval < 0)
+		for (q = 0; q < default_params.rx_rings; q++) {
+			retval = rte_eth_rx_queue_setup(port, q, rx_ring_size,
+					rte_eth_dev_socket_id(port), NULL, mp);
+			if (retval < 0)
+				return retval;
+		}
+
+		/* Allocate and set up 1 TX queue per Ethernet port. */
+		for (q = 0; q < default_params.tx_rings; q++) {
+			retval = rte_eth_tx_queue_setup(port, q, tx_ring_size,
+					rte_eth_dev_socket_id(port), NULL);
+			if (retval < 0)
+				return retval;
+		}
+
+		/* Start the Ethernet port. */
+		retval = rte_eth_dev_start(port);
+		if (retval < 0) {
+			/* Some NICs may not support interrupts on all reported queues.
+			 * Therefore try to reconfigure and start with fewer queues
+			 */
+			if (default_params.rx_rings > 2) {
+				default_params.rx_rings /= 2;
+				continue;
+			}
 			return retval;
+		}
+		started = true;
 	}
 
-	/* Start the Ethernet port. */
-	retval = rte_eth_dev_start(port);
-	if (retval < 0)
-		return retval;
-
 	/* Display the port MAC address. */
 	struct rte_ether_addr addr;
 	retval = rte_eth_macaddr_get(port, &addr);
-- 
2.51.0

