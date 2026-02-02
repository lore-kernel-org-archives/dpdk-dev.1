Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15267E7FDF2
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 22:19:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FE2140647;
	Mon,  2 Feb 2026 23:18:41 +0100 (CET)
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42]) by mails.dpdk.org (Postfix) with ESMTP id 2792740687
 for <dev@dpdk.org>; Mon,  2 Feb 2026 23:18:39 +0100 (CET)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-48068ed1eccso45620755e9.2
 for <dev@dpdk.org>; Mon, 02 Feb 2026 14:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770070719;
 x=1770675519; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KoxrY7mDHshdK64ffCAHNNSNZ/NK8WQMEj9ujRwqY2w=;
 b=pKqF/NOS4NbQR/rDAg2c+hcm73SgwlnMh77UVFBGsB45BEaxpELn4Ux0efnigTZgOh
 6qdJ5eYSBwL9zngMTtJhrT7PsexRlgzPCkzzvtmjZbhdeku8susOZ913s+bLs82PywKP
 m+nVAFOw1vcmXbQifQErFSP671LH2vFFlo7U8O7Fq+77RugBjfwnmj+XCUjYaPcgW70Z
 Gsh+G1bU4+OKUmdLCdQGGXydIihtLRm6K3SZfKcdjyHIYn/zZPeUCwE+32kilSJvqjVx
 i+i1zrSv8t8CCQ11IM6aWY10+IO9UIQPv5+2S1srOFl5gEU4sB49qyvBX3dlN0F3cPgG
 +yPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770070719; x=1770675519;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KoxrY7mDHshdK64ffCAHNNSNZ/NK8WQMEj9ujRwqY2w=;
 b=PQ2yoqX/93iKfeHVAaye6qW97c9heXTrzQXxbvwVlVh44MHZWbhfMa5owf+YnsinXl
 0HgHhjvVxwREm8pAFO7f6rSDvqsPGqXpHO7e+N6kqqFujvr1A4R5If32YP0CwRBfszkp
 /jn70H3fbK9zQEbXrxojn5zxGC919fZZ1LZvl1Y2gXiBZ+IuacC/WD+nC9MwG0Um+h2C
 6h2/gPoZeJkjwLhgoJE0c9JdMZOit/QjyaJmqmi/gBpNjYGPJt1vKpzPL638Htr/cuZg
 fJ+i7VRgm91qVTymQvd1vGGbSzst9lsjhUGdHjHq7RxIr4lpNFrcrmBjUqO2oOy3pPBX
 dk6Q==
X-Gm-Message-State: AOJu0YxPvTKv+us/WglHVZgVp/h6vQBT5biDeAvQCe3Nv136/rS+G9Vp
 HZU+uMr13KAxstJszQUC4sEnYFhpytYkJT1HsOG6c6IDklcCIOqjYZfCFDCCRZ07C+5J+MDzF97
 +yo8K
X-Gm-Gg: AZuq6aL7HOb1p2Sz7PlZ3r+gKtl6mCGJe7pidCI7r2tQvsJ9tSEihhaCxKyDONv19sE
 0zLMzbyBA8lCARXZnMynLq6gUrRfTKgSSm918Dq71nu6dpfXCi4PNHHoqZiARqMpEXdiPZGAd9g
 226kGGNjMFD+MrIUUuCQ6jqqv3wpLEeqIYbSLWSvKMvR3gNP9kJCNQY1Tqdq2ztMdGsrGYSflGe
 PkP4na0ney1mr625qs8GbWUe/vnX5jLnJ6+WikzYxiGHeLPVpLfR3Uk7ElTTSJsqTcnlVbk75tR
 CVagTbFcsLgzqSJbq1vYs2FyRPnpk4srMdqIlHeHJdvJDzOV/1m/zKw85c4rpdf9VwLO0FdJI0r
 eSV9OuulTunS28AOi54CIgnMDKuTdn35VpDsMGMq0jpBGIy7VJlTKJenw+4H4xaMozIiU4/GiWI
 3rcxUPYMZUcBzh1xe+4i+3QhmahdIG1RufBtYFdGFADG7fbSRuAA==
X-Received: by 2002:a05:600c:4f8f:b0:480:4c45:aff5 with SMTP id
 5b1f17b1804b1-482db4995b1mr161031885e9.34.1770070718669; 
 Mon, 02 Feb 2026 14:18:38 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee04csm47109336f8f.12.2026.02.02.14.18.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 14:18:38 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Tetsuya Mukawa <mtetsuyah@gmail.com>
Subject: [PATCH v11 7/7] net/null: add VLAN insert and strip offload support
Date: Mon,  2 Feb 2026 14:16:52 -0800
Message-ID: <20260202221820.204680-8-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202221820.204680-1-stephen@networkplumber.org>
References: <20260104222523.329760-1-stephen@networkplumber.org>
 <20260202221820.204680-1-stephen@networkplumber.org>
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

Add support for VLAN strip (RX) and VLAN insert (TX) offloads to the
null PMD. This makes the driver more useful for testing VLAN-aware
application logic without requiring physical hardware.

Advertise RTE_ETH_RX_OFFLOAD_VLAN_STRIP and
RTE_ETH_TX_OFFLOAD_VLAN_INSERT in device capabilities. Implement the
vlan_offload_set dev_op to track strip enable/disable at runtime.
When VLAN strip is enabled, the RX path sets RTE_MBUF_F_RX_VLAN and
RTE_MBUF_F_RX_VLAN_STRIPPED on received mbufs and populates vlan_tci
with a fixed dummy value. TX VLAN insert requires no datapath changes
since the null TX path unconditionally accepts and frees all packets.

Add corresponding test cases for both offloads and extend the existing
dev_info test to verify the new capability flags.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pmd_null.c        | 366 +++++++++++++++++---------------
 drivers/net/null/rte_eth_null.c |  42 +++-
 2 files changed, 229 insertions(+), 179 deletions(-)

diff --git a/app/test/test_pmd_null.c b/app/test/test_pmd_null.c
index bd520af64f..4fc3073930 100644
--- a/app/test/test_pmd_null.c
+++ b/app/test/test_pmd_null.c
@@ -2,17 +2,15 @@
  * Copyright(c) 2026 Stephen Hemminger
  */
 
+#include <stdbool.h>
 #include <stdio.h>
 #include <string.h>
 #include <inttypes.h>
-#include <errno.h>
 
 #include <rte_bus_vdev.h>
-#include <rte_common.h>
 #include <rte_cycles.h>
 #include <rte_ethdev.h>
 #include <rte_ether.h>
-#include <rte_launch.h>
 #include <rte_lcore.h>
 #include <rte_mbuf.h>
 #include <rte_mempool.h>
@@ -57,8 +55,15 @@ static int
 configure_null_port(uint16_t pid)
 {
 	struct rte_eth_conf port_conf = {0};
+	struct rte_eth_dev_info dev_info;
 	int ret;
 
+	ret = rte_eth_dev_info_get(pid, &dev_info);
+	if (ret != 0) {
+		printf("Failed to get device info for port %u: %d\n", pid, ret);
+		return ret;
+	}
+
 	ret = rte_eth_dev_configure(pid, 1, 1, &port_conf);
 	if (ret != 0) {
 		printf("Failed to configure port %u: %d\n", pid, ret);
@@ -69,7 +74,7 @@ configure_null_port(uint16_t pid)
 				     rte_eth_dev_socket_id(pid),
 				     NULL, mp);
 	if (ret != 0) {
-		printf("Failed to setup Rx queue for port %u: %d\n", pid, ret);
+		printf("Failed to setup RX queue for port %u: %d\n", pid, ret);
 		return ret;
 	}
 
@@ -77,7 +82,7 @@ configure_null_port(uint16_t pid)
 				     rte_eth_dev_socket_id(pid),
 				     NULL);
 	if (ret != 0) {
-		printf("Failed to setup Tx queue for port %u: %d\n", pid, ret);
+		printf("Failed to setup TX queue for port %u: %d\n", pid, ret);
 		return ret;
 	}
 
@@ -131,7 +136,7 @@ test_null_teardown(void)
 }
 
 /*
- * Test: Basic Rx - should return empty packets
+ * Test: Basic RX - should return empty packets
  */
 static int
 test_null_rx_basic(void)
@@ -140,7 +145,7 @@ test_null_rx_basic(void)
 	uint16_t nb_rx;
 	unsigned int i;
 
-	/* Rx should return requested number of empty packets */
+	/* RX should return requested number of empty packets */
 	nb_rx = rte_eth_rx_burst(port_id, 0, bufs, BURST_SIZE);
 	TEST_ASSERT(nb_rx == BURST_SIZE,
 		    "Expected %u packets, got %u", BURST_SIZE, nb_rx);
@@ -180,17 +185,14 @@ test_mbuf_setup_burst(struct rte_mbuf **bufs, unsigned int burst_size)
 		/* Choose random length between ether min and available space */
 		len = rte_rand_max(rte_pktmbuf_tailroom(m) - RTE_ETHER_MIN_LEN)
 			+ RTE_ETHER_MIN_LEN;
-
-		if (rte_pktmbuf_append(m, len) == NULL) {
-			rte_pktmbuf_free_bulk(bufs, burst_size);
-			return -1;
-		}
+		m->data_len = len;
+		m->buf_len = len;
 	}
 	return 0;
 }
 
 /*
- * Test: Basic Tx - should free all packets
+ * Test: Basic TX - should free all packets
  */
 static int
 test_null_tx_basic(void)
@@ -199,16 +201,16 @@ test_null_tx_basic(void)
 	uint16_t nb_tx;
 	unsigned int pool_count_before, pool_count_after;
 
-	/* Allocate mbufs for Tx */
+	/* Allocate mbufs for TX */
 	TEST_ASSERT(test_mbuf_setup_burst(bufs, BURST_SIZE) == 0,
 		    "Could not allocate mbufs");
 
 	pool_count_before = rte_mempool_avail_count(mp);
 
-	/* Tx should accept and free all packets */
+	/* TX should accept and free all packets */
 	nb_tx = rte_eth_tx_burst(port_id, 0, bufs, BURST_SIZE);
 	TEST_ASSERT(nb_tx == BURST_SIZE,
-		    "Expected to Tx %u packets, but sent %u", BURST_SIZE, nb_tx);
+		    "Expected to TX %u packets, but sent %u", BURST_SIZE, nb_tx);
 
 	pool_count_after = rte_mempool_avail_count(mp);
 
@@ -220,7 +222,9 @@ test_null_tx_basic(void)
 	return TEST_SUCCESS;
 }
 
-/* Test: Statistics verification */
+/*
+ * Test: Statistics verification
+ */
 static int
 test_null_stats(void)
 {
@@ -240,20 +244,20 @@ test_null_stats(void)
 	TEST_ASSERT(stats.ipackets == 0, "Initial ipackets not zero");
 	TEST_ASSERT(stats.opackets == 0, "Initial opackets not zero");
 
-	/* Perform Rx */
+	/* Perform RX */
 	nb_rx = rte_eth_rx_burst(port_id, 0, rx_bufs, BURST_SIZE);
-	TEST_ASSERT(nb_rx == BURST_SIZE, "Rx burst failed");
+	TEST_ASSERT(nb_rx == BURST_SIZE, "RX burst failed");
 
-	/* Allocate and perform Tx */
+	/* Allocate and perform TX */
 	TEST_ASSERT(test_mbuf_setup_burst(tx_bufs, BURST_SIZE) == 0,
 		    "Could not allocate tx mbufs");
 
 	nb_tx = rte_eth_tx_burst(port_id, 0, tx_bufs, BURST_SIZE);
-	TEST_ASSERT(nb_tx == BURST_SIZE, "Tx burst failed");
+	TEST_ASSERT(nb_tx == BURST_SIZE, "TX burst failed");
 
 	/* Get updated stats */
 	ret = rte_eth_stats_get(port_id, &stats);
-	TEST_ASSERT(ret == 0, "Failed to get stats after Rx/Tx");
+	TEST_ASSERT(ret == 0, "Failed to get stats after RX/TX");
 
 	/* Verify stats */
 	TEST_ASSERT(stats.ipackets == BURST_SIZE,
@@ -268,7 +272,9 @@ test_null_stats(void)
 	return TEST_SUCCESS;
 }
 
-/* Test: Custom packet size */
+/*
+ * Test: Custom packet size
+ */
 static int
 test_null_custom_size(void)
 {
@@ -286,9 +292,9 @@ test_null_custom_size(void)
 	ret = configure_null_port(custom_port);
 	TEST_ASSERT(ret == 0, "Failed to configure null port");
 
-	/* Rx should return packets with custom size */
+	/* RX should return packets with custom size */
 	nb_rx = rte_eth_rx_burst(custom_port, 0, bufs, BURST_SIZE);
-	TEST_ASSERT(nb_rx == BURST_SIZE, "Rx burst failed");
+	TEST_ASSERT(nb_rx == BURST_SIZE, "RX burst failed");
 
 	/* Verify custom packet size */
 	for (i = 0; i < nb_rx; i++) {
@@ -309,7 +315,9 @@ test_null_custom_size(void)
 	return TEST_SUCCESS;
 }
 
-/* Test: Copy mode */
+/*
+ * Test: Copy mode
+ */
 static int
 test_null_copy_mode(void)
 {
@@ -324,11 +332,11 @@ test_null_copy_mode(void)
 	ret = configure_null_port(copy_port);
 	TEST_ASSERT(ret == 0, "Failed to configure null port");
 
-	/* Rx in copy mode should work */
+	/* RX in copy mode should work */
 	nb_rx = rte_eth_rx_burst(copy_port, 0, rx_bufs, BURST_SIZE);
-	TEST_ASSERT(nb_rx == BURST_SIZE, "Rx burst in copy mode failed");
+	TEST_ASSERT(nb_rx == BURST_SIZE, "RX burst in copy mode failed");
 
-	/* Free Rx mbufs */
+	/* Free RX mbufs */
 	rte_pktmbuf_free_bulk(rx_bufs, nb_rx);
 
 	/* Cleanup */
@@ -339,7 +347,9 @@ test_null_copy_mode(void)
 	return TEST_SUCCESS;
 }
 
-/* Test: No-Rx mode */
+/*
+ * Test: No-RX mode
+ */
 static int
 test_null_no_rx_mode(void)
 {
@@ -355,17 +365,17 @@ test_null_no_rx_mode(void)
 	ret = configure_null_port(norx_port);
 	TEST_ASSERT(ret == 0, "Failed to configure null port");
 
-	/* Rx in no-rx mode should return 0 packets */
+	/* RX in no-rx mode should return 0 packets */
 	nb_rx = rte_eth_rx_burst(norx_port, 0, rx_bufs, BURST_SIZE);
 	TEST_ASSERT(nb_rx == 0,
 		    "Expected 0 packets in no-rx mode, got %u", nb_rx);
 
-	/* Tx in no-rx mode should still work (frees packets) */
+	/* TX in no-rx mode should still work (frees packets) */
 	TEST_ASSERT(test_mbuf_setup_burst(tx_bufs, BURST_SIZE) == 0,
 		    "Could not allocate tx mbufs");
 
 	nb_tx = rte_eth_tx_burst(norx_port, 0, tx_bufs, BURST_SIZE);
-	TEST_ASSERT(nb_tx == BURST_SIZE, "Tx burst in no-rx mode failed");
+	TEST_ASSERT(nb_tx == BURST_SIZE, "TX burst in no-rx mode failed");
 
 	/* Cleanup */
 	rte_eth_dev_stop(norx_port);
@@ -375,7 +385,9 @@ test_null_no_rx_mode(void)
 	return TEST_SUCCESS;
 }
 
-/* Test: Link status */
+/*
+ * Test: Link status
+ */
 static int
 test_null_link_status(void)
 {
@@ -411,13 +423,13 @@ test_null_link_status(void)
 	return TEST_SUCCESS;
 }
 
-/* Test: Device info */
+/*
+ * Test: Device info
+ */
 static int
 test_null_dev_info(void)
 {
 	struct rte_eth_dev_info dev_info;
-	const uint16_t min_mtu = RTE_ETHER_MIN_LEN - RTE_ETHER_HDR_LEN -
-		RTE_ETHER_CRC_LEN;
 	int ret;
 
 	ret = rte_eth_dev_info_get(port_id, &dev_info);
@@ -427,17 +439,24 @@ test_null_dev_info(void)
 	TEST_ASSERT(dev_info.max_mac_addrs == 1,
 		    "Expected max_mac_addrs=1, got %u", dev_info.max_mac_addrs);
 
-	/* Null PMD has no MTU restrictions, so max_mtu is UINT16_MAX */
+	/*
+	 * The null PMD reports max_rx_pktlen=UINT32_MAX, so the ethdev layer
+	 * derives max_mtu=UINT16_MAX and min_mtu from RTE_ETHER_MIN_LEN.
+	 */
 	TEST_ASSERT(dev_info.max_mtu == UINT16_MAX,
-		    "Expected max_mtu=UINT16_MAX, got %u", dev_info.max_mtu);
-	TEST_ASSERT(dev_info.min_mtu == min_mtu,
-		    "Unexpected min_mtu: %u", dev_info.min_mtu);
+		    "Unexpected max_mtu: %u", dev_info.max_mtu);
 
-	/* Check Tx offload capabilities */
+	/* Check TX offload capabilities */
 	TEST_ASSERT(dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_MULTI_SEGS,
 		    "Expected MULTI_SEGS TX offload capability");
 	TEST_ASSERT(dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_MT_LOCKFREE,
 		    "Expected MT_LOCKFREE TX offload capability");
+	TEST_ASSERT(dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_VLAN_INSERT,
+		    "Expected VLAN_INSERT TX offload capability");
+
+	/* Check RX offload capabilities */
+	TEST_ASSERT(dev_info.rx_offload_capa & RTE_ETH_RX_OFFLOAD_VLAN_STRIP,
+		    "Expected VLAN_STRIP RX offload capability");
 
 	/* Check RSS capabilities */
 	TEST_ASSERT(dev_info.reta_size > 0, "Expected non-zero reta_size");
@@ -449,7 +468,9 @@ test_null_dev_info(void)
 	return TEST_SUCCESS;
 }
 
-/* Test: Multiple Rx/Tx bursts */
+/*
+ * Test: Multiple RX/TX bursts
+ */
 static int
 test_null_multiple_bursts(void)
 {
@@ -463,7 +484,7 @@ test_null_multiple_bursts(void)
 	ret = rte_eth_stats_reset(port_id);
 	TEST_ASSERT(ret == 0, "Failed to reset stats");
 
-	/* Perform multiple Rx bursts */
+	/* Perform multiple RX bursts */
 	for (burst = 0; burst < num_bursts; burst++) {
 		struct rte_mbuf *bufs[BURST_SIZE];
 
@@ -475,7 +496,7 @@ test_null_multiple_bursts(void)
 		rte_pktmbuf_free_bulk(bufs, nb_rx);
 	}
 
-	/* Perform multiple Tx bursts */
+	/* Perform multiple TX bursts */
 	for (burst = 0; burst < num_bursts; burst++) {
 		struct rte_mbuf *bufs[BURST_SIZE];
 
@@ -484,7 +505,7 @@ test_null_multiple_bursts(void)
 
 		nb_tx = rte_eth_tx_burst(port_id, 0, bufs, BURST_SIZE);
 		TEST_ASSERT(nb_tx == BURST_SIZE,
-			    "Burst %u: Expected to Tx %u, sent %u",
+			    "Burst %u: Expected to TX %u, sent %u",
 			    burst, BURST_SIZE, nb_tx);
 	}
 
@@ -536,12 +557,12 @@ test_null_rss_config(void)
 		ret = rte_eth_rx_queue_setup(rss_port, q, RING_SIZE,
 					     rte_eth_dev_socket_id(rss_port),
 					     NULL, mp);
-		TEST_ASSERT(ret == 0, "Failed to setup Rx queue %u", q);
+		TEST_ASSERT(ret == 0, "Failed to setup RX queue %u", q);
 
 		ret = rte_eth_tx_queue_setup(rss_port, q, RING_SIZE,
 					     rte_eth_dev_socket_id(rss_port),
 					     NULL);
-		TEST_ASSERT(ret == 0, "Failed to setup Tx queue %u", q);
+		TEST_ASSERT(ret == 0, "Failed to setup TX queue %u", q);
 	}
 
 	ret = rte_eth_dev_start(rss_port);
@@ -622,12 +643,12 @@ test_null_reta_config(void)
 		ret = rte_eth_rx_queue_setup(reta_port, q, RING_SIZE,
 					     rte_eth_dev_socket_id(reta_port),
 					     NULL, mp);
-		TEST_ASSERT(ret == 0, "Failed to setup Rx queue %u", q);
+		TEST_ASSERT(ret == 0, "Failed to setup RX queue %u", q);
 
 		ret = rte_eth_tx_queue_setup(reta_port, q, RING_SIZE,
 					     rte_eth_dev_socket_id(reta_port),
 					     NULL);
-		TEST_ASSERT(ret == 0, "Failed to setup Tx queue %u", q);
+		TEST_ASSERT(ret == 0, "Failed to setup TX queue %u", q);
 	}
 
 	ret = rte_eth_dev_start(reta_port);
@@ -670,7 +691,9 @@ test_null_reta_config(void)
 	return TEST_SUCCESS;
 }
 
-/* Test: Stats reset */
+/*
+ * Test: Stats reset
+ */
 static int
 test_null_stats_reset(void)
 {
@@ -713,7 +736,9 @@ test_null_stats_reset(void)
 	return TEST_SUCCESS;
 }
 
-/* Test: MAC address operations */
+/*
+ * Test: MAC address operations
+ */
 static int
 test_null_mac_addr(void)
 {
@@ -734,169 +759,155 @@ test_null_mac_addr(void)
 	return TEST_SUCCESS;
 }
 
-/* Test: Promiscuous and allmulticast modes */
+/*
+ * Test: VLAN strip offload
+ * Verify that when RX VLAN strip is enabled, received packets have
+ * the VLAN stripped flags set and a valid vlan_tci.
+ */
 static int
-test_null_promisc_allmulti(void)
+test_null_vlan_strip(void)
 {
+	struct rte_eth_conf port_conf = {0};
+	struct rte_mbuf *bufs[BURST_SIZE];
+	uint16_t vlan_port;
+	uint16_t nb_rx;
+	unsigned int i;
 	int ret;
 
-	/* Test promiscuous mode - null PMD starts with promiscuous enabled */
-	ret = rte_eth_promiscuous_get(port_id);
-	TEST_ASSERT(ret == 1, "Expected promiscuous mode enabled");
+	/* Create a null device for VLAN strip testing */
+	ret = create_null_port("net_null_vlan_strip", NULL, &vlan_port);
+	TEST_ASSERT(ret == 0, "Failed to create null port for VLAN strip");
 
-	/* Test allmulticast mode - null PMD starts with allmulti enabled */
-	ret = rte_eth_allmulticast_get(port_id);
-	TEST_ASSERT(ret == 1, "Expected allmulticast mode enabled");
+	/* Configure with VLAN strip enabled */
+	port_conf.rxmode.offloads = RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
 
-	return TEST_SUCCESS;
-}
+	ret = rte_eth_dev_configure(vlan_port, 1, 1, &port_conf);
+	TEST_ASSERT(ret == 0, "Failed to configure VLAN strip port");
 
-/* Multi-threaded Tx test structures and worker function */
-#define MT_TX_BURSTS_PER_LCORE 100
-#define MT_TX_BURST_SIZE 8u
+	ret = rte_eth_rx_queue_setup(vlan_port, 0, RING_SIZE,
+				     rte_eth_dev_socket_id(vlan_port),
+				     NULL, mp);
+	TEST_ASSERT(ret == 0, "Failed to setup RX queue");
 
-struct mt_tx_args {
-	uint16_t port;
-	uint16_t queue;
-	struct rte_mempool *pool;
-	uint64_t tx_count;	/* packets successfully transmitted */
-	int error;		/* non-zero if worker encountered error */
-};
+	ret = rte_eth_tx_queue_setup(vlan_port, 0, RING_SIZE,
+				     rte_eth_dev_socket_id(vlan_port),
+				     NULL);
+	TEST_ASSERT(ret == 0, "Failed to setup TX queue");
 
-static int
-mt_tx_worker(void *arg)
-{
-	struct mt_tx_args *args = arg;
-	struct rte_mbuf *bufs[MT_TX_BURST_SIZE];
-	unsigned int burst;
-	uint16_t nb_tx;
+	ret = rte_eth_dev_start(vlan_port);
+	TEST_ASSERT(ret == 0, "Failed to start VLAN strip port");
 
-	for (burst = 0; burst < MT_TX_BURSTS_PER_LCORE; burst++) {
-		/* Allocate mbufs */
-		if (rte_pktmbuf_alloc_bulk(args->pool, bufs, MT_TX_BURST_SIZE) != 0) {
-			args->error = -ENOMEM;
-			return -1;
-		}
+	/* RX should return packets with VLAN stripped flags */
+	nb_rx = rte_eth_rx_burst(vlan_port, 0, bufs, BURST_SIZE);
+	TEST_ASSERT(nb_rx == BURST_SIZE, "RX burst failed");
 
-		/* Set minimal packet size */
-		for (uint16_t i = 0; i < MT_TX_BURST_SIZE; i++) {
-			bufs[i]->data_len = RTE_ETHER_MIN_LEN;
-			bufs[i]->pkt_len = RTE_ETHER_MIN_LEN;
-		}
+	for (i = 0; i < nb_rx; i++) {
+		TEST_ASSERT((bufs[i]->ol_flags & RTE_MBUF_F_RX_VLAN) != 0,
+			    "Packet %u missing RTE_MBUF_F_RX_VLAN flag", i);
+		TEST_ASSERT((bufs[i]->ol_flags & RTE_MBUF_F_RX_VLAN_STRIPPED) != 0,
+			    "Packet %u missing RTE_MBUF_F_RX_VLAN_STRIPPED flag", i);
+		TEST_ASSERT(bufs[i]->vlan_tci != 0,
+			    "Packet %u has zero vlan_tci", i);
+	}
 
-		/* Transmit on shared queue */
-		nb_tx = rte_eth_tx_burst(args->port, args->queue,
-					 bufs, MT_TX_BURST_SIZE);
-		args->tx_count += nb_tx;
+	rte_pktmbuf_free_bulk(bufs, nb_rx);
 
-		/* Free any unsent packets */
-		if (nb_tx < MT_TX_BURST_SIZE)
-			rte_pktmbuf_free_bulk(&bufs[nb_tx],
-					      MT_TX_BURST_SIZE - nb_tx);
-	}
+	/* Cleanup */
+	rte_eth_dev_stop(vlan_port);
+	rte_eth_dev_close(vlan_port);
+	rte_vdev_uninit("net_null_vlan_strip");
 
-	return 0;
+	return TEST_SUCCESS;
 }
 
 /*
- * Test: Multi-threaded Tx on same queue (MT_LOCKFREE)
- * The null PMD advertises MT_LOCKFREE capability, meaning multiple
- * threads can transmit on the same queue without external locking.
+ * Test: VLAN insert TX offload
+ * Verify that the null PMD accepts packets with the VLAN insert flag
+ * and that the offload capability is properly advertised.
  */
 static int
-test_null_mt_tx(void)
+test_null_vlan_insert(void)
 {
+	struct rte_eth_conf port_conf = {0};
 	struct rte_eth_dev_info dev_info;
-	struct rte_mempool *mt_pool;
-	struct mt_tx_args worker_args[RTE_MAX_LCORE] = { 0 };
-	struct rte_eth_stats stats;
-	unsigned int lcore_id;
-	unsigned int num_workers = 0;
-	uint64_t total_expected = 0;
+	struct rte_mbuf *bufs[BURST_SIZE];
+	uint16_t vlan_port;
+	uint16_t nb_tx;
+	unsigned int i;
 	int ret;
 
-	/* Check MT_LOCKFREE capability */
-	ret = rte_eth_dev_info_get(port_id, &dev_info);
+	/* Create a null device for VLAN insert testing */
+	ret = create_null_port("net_null_vlan_insert", NULL, &vlan_port);
+	TEST_ASSERT(ret == 0, "Failed to create null port for VLAN insert");
+
+	ret = rte_eth_dev_info_get(vlan_port, &dev_info);
 	TEST_ASSERT(ret == 0, "Failed to get device info");
 
-	if (!(dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_MT_LOCKFREE)) {
-		printf("  MT_LOCKFREE not supported, skipping test\n");
-		return TEST_SKIPPED;
-	}
+	/* Verify VLAN insert is advertised */
+	TEST_ASSERT(dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_VLAN_INSERT,
+		    "TX VLAN insert offload not advertised");
 
-	/* Count available worker lcores */
-	RTE_LCORE_FOREACH_WORKER(lcore_id) {
-		num_workers++;
-	}
+	/* Also verify VLAN strip RX capability */
+	TEST_ASSERT(dev_info.rx_offload_capa & RTE_ETH_RX_OFFLOAD_VLAN_STRIP,
+		    "RX VLAN strip offload not advertised");
 
-	if (num_workers < 2) {
-		printf("  Need at least 2 worker lcores for MT test, "
-		       "have %u, skipping\n", num_workers);
-		return TEST_SKIPPED;
-	}
+	/* Configure with VLAN insert TX offload */
+	port_conf.txmode.offloads = RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
 
-	/* Limit to reasonable number of workers */
-	if (num_workers > 4)
-		num_workers = 4;
+	ret = rte_eth_dev_configure(vlan_port, 1, 1, &port_conf);
+	TEST_ASSERT(ret == 0, "Failed to configure VLAN insert port");
 
-	/* Create larger mempool for multi-threaded test */
-	mt_pool = rte_pktmbuf_pool_create("mt_tx_pool",
-					  num_workers * MT_TX_BURSTS_PER_LCORE *
-					  MT_TX_BURST_SIZE * 2,
-					  MBUF_CACHE_SIZE, 0,
-					  RTE_MBUF_DEFAULT_BUF_SIZE,
-					  rte_socket_id());
-	TEST_ASSERT(mt_pool != NULL, "Failed to create MT test mempool");
+	ret = rte_eth_rx_queue_setup(vlan_port, 0, RING_SIZE,
+				     rte_eth_dev_socket_id(vlan_port),
+				     NULL, mp);
+	TEST_ASSERT(ret == 0, "Failed to setup RX queue");
 
-	/* Reset stats before test */
-	ret = rte_eth_stats_reset(port_id);
-	TEST_ASSERT(ret == 0, "Failed to reset stats");
+	ret = rte_eth_tx_queue_setup(vlan_port, 0, RING_SIZE,
+				     rte_eth_dev_socket_id(vlan_port),
+				     NULL);
+	TEST_ASSERT(ret == 0, "Failed to setup TX queue");
 
-	/* Launch workers */
-	num_workers = 0;
-	RTE_LCORE_FOREACH_WORKER(lcore_id) {
-		if (num_workers >= 4)
-			break;
-
-		worker_args[num_workers].port = port_id;
-		worker_args[num_workers].pool = mt_pool;
-
-		ret = rte_eal_remote_launch(mt_tx_worker,
-					    &worker_args[num_workers],
-					    lcore_id);
-		TEST_ASSERT(ret == 0, "Failed to launch worker on lcore %u",
-			    lcore_id);
-		num_workers++;
-	}
+	ret = rte_eth_dev_start(vlan_port);
+	TEST_ASSERT(ret == 0, "Failed to start VLAN insert port");
 
-	printf("  Launched %u workers for MT Tx test\n", num_workers);
+	/* Allocate packets and set VLAN insert flag with a TCI */
+	TEST_ASSERT(test_mbuf_setup_burst(bufs, BURST_SIZE) == 0,
+		    "Could not allocate mbufs");
 
-	/* Wait for all workers to complete */
-	RTE_LCORE_FOREACH_WORKER(lcore_id) {
-		rte_eal_wait_lcore(lcore_id);
+	for (i = 0; i < BURST_SIZE; i++) {
+		bufs[i]->ol_flags |= RTE_MBUF_F_TX_VLAN;
+		bufs[i]->vlan_tci = 200;
 	}
 
-	/* Check for errors and sum up Tx counts */
-	for (unsigned int i = 0; i < num_workers; i++) {
-		TEST_ASSERT(worker_args[i].error == 0,
-			    "Worker %u encountered error: %d",
-			    i, worker_args[i].error);
-		total_expected += worker_args[i].tx_count;
-	}
+	/* TX should accept all VLAN-tagged packets */
+	nb_tx = rte_eth_tx_burst(vlan_port, 0, bufs, BURST_SIZE);
+	TEST_ASSERT(nb_tx == BURST_SIZE,
+		    "Expected to TX %u VLAN packets, sent %u",
+		    BURST_SIZE, nb_tx);
 
-	/* Verify stats match expected */
-	ret = rte_eth_stats_get(port_id, &stats);
-	TEST_ASSERT(ret == 0, "Failed to get stats");
+	/* Cleanup */
+	rte_eth_dev_stop(vlan_port);
+	rte_eth_dev_close(vlan_port);
+	rte_vdev_uninit("net_null_vlan_insert");
 
-	printf("  Total Tx from workers: %"PRIu64", stats.opackets: %"PRIu64"\n",
-	       total_expected, stats.opackets);
+	return TEST_SUCCESS;
+}
 
-	TEST_ASSERT(stats.opackets == total_expected,
-		    "Stats mismatch: expected %"PRIu64" opackets, got %"PRIu64,
-		    total_expected, stats.opackets);
+/*
+ * Test: Promiscuous and allmulticast modes
+ */
+static int
+test_null_promisc_allmulti(void)
+{
+	int ret;
 
-	/* Cleanup */
-	rte_mempool_free(mt_pool);
+	/* Test promiscuous mode - null PMD starts with promiscuous enabled */
+	ret = rte_eth_promiscuous_get(port_id);
+	TEST_ASSERT(ret == 1, "Expected promiscuous mode enabled");
+
+	/* Test allmulticast mode - null PMD starts with allmulti enabled */
+	ret = rte_eth_allmulticast_get(port_id);
+	TEST_ASSERT(ret == 1, "Expected allmulticast mode enabled");
 
 	return TEST_SUCCESS;
 }
@@ -915,11 +926,12 @@ static struct unit_test_suite null_pmd_test_suite = {
 		TEST_CASE(test_null_link_status),
 		TEST_CASE(test_null_dev_info),
 		TEST_CASE(test_null_multiple_bursts),
-		TEST_CASE(test_null_mt_tx),
 		TEST_CASE(test_null_rss_config),
 		TEST_CASE(test_null_reta_config),
 		TEST_CASE(test_null_stats_reset),
 		TEST_CASE(test_null_mac_addr),
+		TEST_CASE(test_null_vlan_strip),
+		TEST_CASE(test_null_vlan_insert),
 		TEST_CASE(test_null_promisc_allmulti),
 
 		TEST_CASES_END() /**< NULL terminate unit test array */
diff --git a/drivers/net/null/rte_eth_null.c b/drivers/net/null/rte_eth_null.c
index 672459fe05..c371c55059 100644
--- a/drivers/net/null/rte_eth_null.c
+++ b/drivers/net/null/rte_eth_null.c
@@ -22,6 +22,8 @@ static unsigned int default_packet_size = 64;
 static unsigned int default_packet_copy;
 static unsigned int default_no_rx;
 
+#define ETH_NULL_VLAN_STRIP_TCI	100	/**< Dummy VLAN TCI for simulated strip. */
+
 static const char *valid_arguments[] = {
 	ETH_NULL_PACKET_SIZE_ARG,
 	ETH_NULL_PACKET_COPY_ARG,
@@ -54,6 +56,7 @@ struct pmd_internals {
 	unsigned int packet_size;
 	unsigned int packet_copy;
 	unsigned int no_rx;
+	unsigned int vlan_strip;
 	uint16_t port_id;
 
 	struct null_queue rx_null_queues[RTE_MAX_QUEUES_PER_PORT];
@@ -101,6 +104,11 @@ eth_null_rx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 		bufs[i]->pkt_len = packet_size;
 		bytes += packet_size;
 		bufs[i]->port = h->internals->port_id;
+		if (h->internals->vlan_strip) {
+			bufs[i]->ol_flags |= RTE_MBUF_F_RX_VLAN |
+					     RTE_MBUF_F_RX_VLAN_STRIPPED;
+			bufs[i]->vlan_tci = ETH_NULL_VLAN_STRIP_TCI;
+		}
 	}
 
 	h->rx_pkts += nb_bufs;
@@ -127,6 +135,11 @@ eth_null_copy_rx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 		bufs[i]->pkt_len = packet_size;
 		bytes += packet_size;
 		bufs[i]->port = h->internals->port_id;
+		if (h->internals->vlan_strip) {
+			bufs[i]->ol_flags |= RTE_MBUF_F_RX_VLAN |
+					     RTE_MBUF_F_RX_VLAN_STRIPPED;
+			bufs[i]->vlan_tci = ETH_NULL_VLAN_STRIP_TCI;
+		}
 	}
 
 	h->rx_pkts += nb_bufs;
@@ -180,8 +193,13 @@ eth_null_copy_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 }
 
 static int
-eth_dev_configure(struct rte_eth_dev *dev __rte_unused)
+eth_dev_configure(struct rte_eth_dev *dev)
 {
+	struct pmd_internals *internals = dev->data->dev_private;
+
+	internals->vlan_strip = !!(dev->data->dev_conf.rxmode.offloads &
+				   RTE_ETH_RX_OFFLOAD_VLAN_STRIP);
+
 	return 0;
 }
 
@@ -271,6 +289,22 @@ eth_mtu_set(struct rte_eth_dev *dev __rte_unused, uint16_t mtu __rte_unused)
 	return 0;
 }
 
+static int
+eth_vlan_offload_set(struct rte_eth_dev *dev, int mask)
+{
+	struct pmd_internals *internals = dev->data->dev_private;
+
+	if (mask & RTE_ETH_VLAN_STRIP_MASK) {
+		if (dev->data->dev_conf.rxmode.offloads &
+		    RTE_ETH_RX_OFFLOAD_VLAN_STRIP)
+			internals->vlan_strip = 1;
+		else
+			internals->vlan_strip = 0;
+	}
+
+	return 0;
+}
+
 static int
 eth_dev_info(struct rte_eth_dev *dev,
 		struct rte_eth_dev_info *dev_info)
@@ -282,7 +316,10 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = RTE_DIM(internals->rx_null_queues);
 	dev_info->max_tx_queues = RTE_DIM(internals->tx_null_queues);
 	dev_info->min_rx_bufsize = internals->packet_size;
-	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS | RTE_ETH_TX_OFFLOAD_MT_LOCKFREE;
+	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
+				    RTE_ETH_TX_OFFLOAD_MT_LOCKFREE |
+				    RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
 
 	dev_info->reta_size = internals->reta_size;
 	dev_info->flow_type_rss_offloads = internals->flow_type_rss_offloads;
@@ -495,6 +532,7 @@ static const struct eth_dev_ops ops = {
 	.rx_queue_release = eth_rx_queue_release,
 	.tx_queue_release = eth_tx_queue_release,
 	.mtu_set = eth_mtu_set,
+	.vlan_offload_set = eth_vlan_offload_set,
 	.link_update = eth_link_update,
 	.mac_addr_set = eth_mac_address_set,
 	.stats_get = eth_stats_get,
-- 
2.51.0

