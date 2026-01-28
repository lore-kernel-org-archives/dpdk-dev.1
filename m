Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9A40D46BEE
	for <dpdk-dev@archiver.kernel.org>; Wed, 28 Jan 2026 18:43:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 81F6E40B9B;
	Wed, 28 Jan 2026 19:42:09 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id B97E9402E7
 for <dev@dpdk.org>; Wed, 28 Jan 2026 19:42:00 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-4806bf03573so955865e9.2
 for <dev@dpdk.org>; Wed, 28 Jan 2026 10:42:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769625720;
 x=1770230520; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i8DVL7qDUJtl8JBMG0wlZ1fCkLPt5JLmNf5ZtRa2DQ8=;
 b=LmxpXz1iQMu3JqQgChYviexcN5J5LOMU7ccMDyayQMTv4GnwJdvrihq89G+jqT4buD
 bD1me/JfYpuGDmmRAEg6AKLGHrD1wpg7dBR0DrdGuGqsReOARJP3/PcMMOaJDa6zG+5h
 12as6wqJfIb0+FqEquKpsDS+i62Vf/5LkHka9nbbvQF3S4pLvahtgtx33MxSCwNYT4fD
 UPA0xRvzjr5DhQP5n5X3N0SZZU8zaGnURUOdrOlrHFQveLG1FsE+phHgesmdndRom/Sy
 bE/dFI11CrSJTG0sfYYIjEvhHJsfu8j/u49fGMKRepLGVYZbQOHUeLwxHlaDe2iPrl/+
 dHkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769625720; x=1770230520;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i8DVL7qDUJtl8JBMG0wlZ1fCkLPt5JLmNf5ZtRa2DQ8=;
 b=bLiHpMKYjzOZ89xnH+SWDSn548s3DZhuoIKSp0546vc0Dl+7XXNOifc4N1R095yNum
 hRjrM/aHOhcADeUjD9fCKf4GwgpWhfaPbVz52RQETURp9AAl27zP4ru45w9dhlx5htC7
 MkCJedt6ASVl7znNlSVIk1+gSQfPcaNFgG7zRTrY0U5KlFdyLVyYuBHgic0Ui34bJuN5
 oXmR3ogKFdIVkKiseIxHMkFr1JQurxODNgxZv59KO3xp50YWnWHu1kKwzcSAz/OBL/hZ
 zQMpeVhFuelApW8gymLfhrraCUFDQ8dLe4W76rxk8CpR+a+upWRbI4MM9C5VnXa9Uq6z
 xG8g==
X-Gm-Message-State: AOJu0YyYKdyB+S3ulcMi3yx3sE0o1bVBXrFDXndR6M+XAe1wu+A5FC6H
 kVpP3rXUtEl3jF+ARlSAmNrceEjDQYcCag/QGi3wFQ5Wz33lY8Bldb0qrhnpLFTZW0RGs4Sflxy
 Z5oMW
X-Gm-Gg: AZuq6aI/KZeMej22BEMXGrlk3CafQCgEPo/kz3aHf5Fbk1HQHEMsFp80uvnkMFLanWX
 AmvbkbrSskb18O/35SBbuMghvXnUN4hRiA5aVU/pNNKoFUOULVAr+HeTzQ3okl8vHqVplS0CzYI
 LEfpEPjjj85rjpRJyAMh1mF48xFy83C9JqTzcrFECV88p36x9ZTz4bBEPDiWyX5uXPGI4u2+Qkb
 QuwEDwinQa77XxJDq2loKbnOutke2mDEJpUDn0W3kw9uyAQ1xgZgBWEzGNqSW9tsAWBgpzuNAyj
 FsiY6C/fvTw4VxSnzPEyT5PbO0VTlMFKpD7iu2MEXGMgCsX/TIXHW9WOIRIx7+7K289wsfy+J1h
 BjtDF+9tacUqSAMKlUZ5kCmsVKlI3I5aWSxZsmD5wMHpTJB7jtXRhN4hGGZd2+9i8wG0Gqns/MN
 xjfanJNueboeKqsCT9d56A2hXa4jPnaJbgKsPqba3wdPVos1yi3A==
X-Received: by 2002:a5d:5f86:0:b0:430:f58d:40e5 with SMTP id
 ffacd0b85a97d-435dd1bd7f1mr8575625f8f.30.1769625720188; 
 Wed, 28 Jan 2026 10:42:00 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10ee562sm9015430f8f.18.2026.01.28.10.41.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 10:41:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v9 15/15] net/pcap: add snapshot length devarg
Date: Wed, 28 Jan 2026 10:40:44 -0800
Message-ID: <20260128184130.445567-16-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260128184130.445567-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260128184130.445567-1-stephen@networkplumber.org>
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

Add a new devarg 'snaplen' to configure the pcap snapshot length,
which controls the maximum packet size for capture and output.

The snapshot length affects:
- The pcap_set_snaplen() call when capturing from interfaces
- The pcap_open_dead() snapshot parameter for output files
- The reported max_rx_pktlen in device info
- The reported max_mtu in device info (snaplen - ethernet header)

The default value is 65535 bytes, preserving backward compatibility
with previous driver behavior.

Example usage:
  --vdev 'net_pcap0,iface=eth0,snaplen=1518'
  --vdev 'net_pcap0,rx_pcap=in.pcap,tx_pcap=out.pcap,snaplen=9000'

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 app/test/test_pmd_pcap.c               | 194 ++++++++++++++++++++++++-
 doc/guides/nics/pcap_ring.rst          |  17 +++
 doc/guides/rel_notes/release_26_03.rst |   1 +
 drivers/net/pcap/pcap_ethdev.c         | 165 ++++++++++++---------
 4 files changed, 306 insertions(+), 71 deletions(-)

diff --git a/app/test/test_pmd_pcap.c b/app/test/test_pmd_pcap.c
index 8c5d5d76e4..86ec6165f3 100644
--- a/app/test/test_pmd_pcap.c
+++ b/app/test/test_pmd_pcap.c
@@ -447,6 +447,41 @@ get_pcap_packet_sizes(const char *path, uint16_t *sizes, unsigned int max_pkts)
 	return count;
 }
 
+/*
+ * Helper: Verify packets in pcap file are truncated correctly
+ * Returns 0 if all packets have caplen == expected_caplen and len == expected_len
+ */
+static int
+verify_pcap_truncation(const char *path, uint32_t expected_caplen,
+		       uint32_t expected_len, unsigned int *pkt_count)
+{
+	pcap_t *pd;
+	char errbuf[PCAP_ERRBUF_SIZE];
+	struct pcap_pkthdr *hdr;
+	const u_char *data;
+	unsigned int count = 0;
+
+	pd = pcap_open_offline(path, errbuf);
+	if (pd == NULL)
+		return -1;
+
+	while (pcap_next_ex(pd, &hdr, &data) == 1) {
+		if (hdr->caplen != expected_caplen || hdr->len != expected_len) {
+			printf("Packet %u: caplen=%u (expected %u), len=%u (expected %u)\n",
+			       count, hdr->caplen, expected_caplen,
+			       hdr->len, expected_len);
+			pcap_close(pd);
+			return -1;
+		}
+		count++;
+	}
+
+	pcap_close(pd);
+	if (pkt_count)
+		*pkt_count = count;
+	return 0;
+}
+
 /*
  * Helper: Configure and start a pcap ethdev port
  */
@@ -1973,7 +2008,7 @@ test_multi_rx_queue_same_file(void)
  * This test verifies that rte_eth_dev_info_get() returns correct values:
  * 1. max_rx_queues matches the number of rx_pcap files passed
  * 2. max_tx_queues matches the number of tx_pcap files passed
- * 3. min_mtu and max_mtu are set to reasonable values
+ * 3. max_rx_pktlen and max_mtu are based on default snapshot length
  */
 static int
 test_dev_info(void)
@@ -1985,6 +2020,9 @@ test_dev_info(void)
 	uint16_t port_id;
 	int ret;
 	unsigned int i;
+	/* Default snapshot length is 65535 */
+	const uint32_t default_snaplen = 65535;
+	const uint32_t expected_max_mtu = default_snaplen - RTE_ETHER_HDR_LEN;
 
 	printf("Testing device info reporting\n");
 
@@ -2023,8 +2061,8 @@ test_dev_info(void)
 	printf("    driver_name: %s\n", dev_info.driver_name);
 	printf("    max_rx_queues: %u (expected: 3)\n", dev_info.max_rx_queues);
 	printf("    max_tx_queues: %u (expected: 2)\n", dev_info.max_tx_queues);
-	printf("    min_mtu: %u\n", dev_info.min_mtu);
-	printf("    max_mtu: %u\n", dev_info.max_mtu);
+	printf("    max_rx_pktlen: %u (expected: %u)\n", dev_info.max_rx_pktlen, default_snaplen);
+	printf("    max_mtu: %u (expected: %u)\n", dev_info.max_mtu, expected_max_mtu);
 
 	/* Verify queue counts match number of pcap files */
 	TEST_ASSERT_EQUAL(dev_info.max_rx_queues, 3U,
@@ -2032,6 +2070,16 @@ test_dev_info(void)
 	TEST_ASSERT_EQUAL(dev_info.max_tx_queues, 2U,
 			  "max_tx_queues mismatch: expected 2, got %u", dev_info.max_tx_queues);
 
+	/* Verify max_rx_pktlen equals default snapshot length */
+	TEST_ASSERT_EQUAL(dev_info.max_rx_pktlen, default_snaplen,
+			  "max_rx_pktlen mismatch: expected %u, got %u",
+			  default_snaplen, dev_info.max_rx_pktlen);
+
+	/* Verify max_mtu is snapshot_len minus ethernet header */
+	TEST_ASSERT_EQUAL(dev_info.max_mtu, expected_max_mtu,
+			  "max_mtu mismatch: expected %u, got %u",
+			  expected_max_mtu, dev_info.max_mtu);
+
 	rte_vdev_uninit("net_pcap_devinfo");
 
 	/* Cleanup temp files */
@@ -2044,6 +2092,144 @@ test_dev_info(void)
 	return TEST_SUCCESS;
 }
 
+/*
+ * Test: Custom snapshot length (snaplen) parameter
+ *
+ * This test verifies that the snaplen devarg works correctly:
+ * 1. max_rx_pktlen reflects the custom snapshot length
+ * 2. max_mtu is calculated as snaplen - ethernet header
+ */
+static int
+test_snaplen(void)
+{
+	struct rte_eth_dev_info dev_info;
+	char devargs[512];
+	char rx_path[PATH_MAX];
+	char tx_path[PATH_MAX];
+	uint16_t port_id;
+	int ret;
+	const uint32_t custom_snaplen = 9000;
+	const uint32_t expected_max_mtu = custom_snaplen - RTE_ETHER_HDR_LEN;
+
+	printf("Testing custom snapshot length parameter\n");
+
+	/* Create temp files */
+	TEST_ASSERT(create_temp_path(rx_path, sizeof(rx_path), "pcap_snaplen_rx") == 0,
+		    "Failed to create RX temp path");
+	TEST_ASSERT(create_test_pcap(rx_path, 1) == 0,
+		    "Failed to create RX pcap");
+	TEST_ASSERT(create_temp_path(tx_path, sizeof(tx_path), "pcap_snaplen_tx") == 0,
+		    "Failed to create TX temp path");
+
+	/* Create device with custom snaplen */
+	snprintf(devargs, sizeof(devargs), "rx_pcap=%s,tx_pcap=%s,snaplen=%u",
+		 rx_path, tx_path, custom_snaplen);
+
+	ret = rte_vdev_init("net_pcap_snaplen", devargs);
+	TEST_ASSERT_SUCCESS(ret, "Failed to create pcap PMD: %s", rte_strerror(-ret));
+
+	ret = rte_eth_dev_get_port_by_name("net_pcap_snaplen", &port_id);
+	TEST_ASSERT_SUCCESS(ret, "Cannot find added pcap device");
+
+	ret = rte_eth_dev_info_get(port_id, &dev_info);
+	TEST_ASSERT_SUCCESS(ret, "Failed to get device info: %s", rte_strerror(-ret));
+
+	printf("  Custom snaplen: %u\n", custom_snaplen);
+	printf("  max_rx_pktlen: %u (expected: %u)\n", dev_info.max_rx_pktlen, custom_snaplen);
+	printf("  max_mtu: %u (expected: %u)\n", dev_info.max_mtu, expected_max_mtu);
+
+	/* Verify max_rx_pktlen equals custom snapshot length */
+	TEST_ASSERT_EQUAL(dev_info.max_rx_pktlen, custom_snaplen,
+			  "max_rx_pktlen mismatch: expected %u, got %u",
+			  custom_snaplen, dev_info.max_rx_pktlen);
+
+	/* Verify max_mtu is snaplen minus ethernet header */
+	TEST_ASSERT_EQUAL(dev_info.max_mtu, expected_max_mtu,
+			  "max_mtu mismatch: expected %u, got %u",
+			  expected_max_mtu, dev_info.max_mtu);
+
+	rte_vdev_uninit("net_pcap_snaplen");
+
+	/* Cleanup temp files */
+	unlink(rx_path);
+	unlink(tx_path);
+
+	printf("Snapshot length test PASSED\n");
+	return TEST_SUCCESS;
+}
+
+/*
+ * Test: Snapshot length truncation behavior
+ *
+ * This test verifies that packets larger than snaplen are properly truncated
+ * when written to pcap files:
+ * 1. caplen in pcap header is limited to snaplen
+ * 2. len in pcap header preserves original packet length
+ * 3. Only snaplen bytes of data are written
+ */
+static int
+test_snaplen_truncation(void)
+{
+	struct rte_mbuf *mbufs[NUM_PACKETS];
+	char devargs[512];
+	char tx_path[PATH_MAX];
+	uint16_t port_id;
+	int ret, nb_tx, nb_gen;
+	unsigned int pkt_count;
+	const uint32_t test_snaplen = 100;
+	const uint8_t pkt_size = 200;
+
+	printf("Testing snaplen truncation behavior\n");
+
+	/* Create temp TX file */
+	TEST_ASSERT(create_temp_path(tx_path, sizeof(tx_path), "pcap_trunc_tx") == 0,
+		    "Failed to create TX temp path");
+
+	/* Create device with small snaplen */
+	snprintf(devargs, sizeof(devargs), "tx_pcap=%s,snaplen=%u",
+		 tx_path, test_snaplen);
+
+	ret = rte_vdev_init("net_pcap_trunc", devargs);
+	TEST_ASSERT_SUCCESS(ret, "Failed to create pcap PMD: %s", rte_strerror(-ret));
+
+	ret = rte_eth_dev_get_port_by_name("net_pcap_trunc", &port_id);
+	TEST_ASSERT_SUCCESS(ret, "Cannot find added pcap device");
+
+	TEST_ASSERT(setup_pcap_port(port_id) == 0, "Failed to setup port");
+
+	/* Generate packets larger than snaplen */
+	nb_gen = generate_test_packets(mp, mbufs, NUM_PACKETS, pkt_size);
+	TEST_ASSERT_EQUAL(nb_gen, NUM_PACKETS,
+			  "Failed to generate packets: got %d, expected %d",
+			  nb_gen, NUM_PACKETS);
+
+	printf("  Sending %d packets of size %u with snaplen=%u\n",
+	       NUM_PACKETS, pkt_size, test_snaplen);
+
+	/* Transmit packets */
+	nb_tx = rte_eth_tx_burst(port_id, 0, mbufs, NUM_PACKETS);
+	TEST_ASSERT_EQUAL(nb_tx, NUM_PACKETS,
+			  "TX burst failed: sent %d/%d", nb_tx, NUM_PACKETS);
+
+	cleanup_pcap_vdev("net_pcap_trunc", port_id);
+
+	/* Verify truncation in output file */
+	ret = verify_pcap_truncation(tx_path, test_snaplen, pkt_size, &pkt_count);
+	TEST_ASSERT_SUCCESS(ret, "Truncation verification failed");
+	TEST_ASSERT_EQUAL(pkt_count, (unsigned int)NUM_PACKETS,
+			  "Packet count mismatch: got %u, expected %d",
+			  pkt_count, NUM_PACKETS);
+
+	printf("  Verified %u packets: caplen=%u, len=%u\n",
+	       pkt_count, test_snaplen, pkt_size);
+
+	/* Cleanup */
+	unlink(tx_path);
+
+	printf("Snaplen truncation test PASSED\n");
+	return TEST_SUCCESS;
+}
+
 /*
  * Test: VLAN Strip on RX
  *
@@ -2322,6 +2508,8 @@ static struct unit_test_suite test_pmd_pcap_suite = {
 		TEST_CASE(test_vlan_strip_rx),
 		TEST_CASE(test_vlan_insert_tx),
 		TEST_CASE(test_vlan_no_strip_rx),
+		TEST_CASE(test_snaplen),
+		TEST_CASE(test_snaplen_truncation),
 		TEST_CASES_END()
 	}
 };
diff --git a/doc/guides/nics/pcap_ring.rst b/doc/guides/nics/pcap_ring.rst
index 6955e91130..f01107841d 100644
--- a/doc/guides/nics/pcap_ring.rst
+++ b/doc/guides/nics/pcap_ring.rst
@@ -94,6 +94,23 @@ The different stream types are:
 
         iface=eth0
 
+*   snaplen: Set snapshot length (maximum capture size)
+
+    The snapshot length limits the maximum size of captured packets. This can be
+    set with the ``snaplen`` devarg, for example::
+
+        snaplen=1518
+
+    This sets the snapshot length to 1518 bytes. The value affects the reported
+    ``max_rx_pktlen`` and ``max_mtu`` in device info. The default value is 65535
+    bytes, matching the default pcap snapshot length.
+
+    When capturing from interfaces, this limits the amount of data captured per
+    packet. For pcap file output, packets larger than the snapshot length are
+    truncated: only the first ``snaplen`` bytes are written, while the original
+    packet length is preserved in the pcap packet header.
+
+
 Runtime Config Options
 ^^^^^^^^^^^^^^^^^^^^^^
 
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index ddcb693166..edb39f2a37 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -60,6 +60,7 @@ New Features
   * Changed transmit burst to always return the number of packets requested.
     Failed sends are counted as transmit errors.
   * Added support for VLAN insertion and stripping.
+  * Added ``snaplen`` devarg to configure packet capture snapshot length.
   * Receive timestamp offload is only done if offload flag set.
   * Receive timestamps support nanosecond precision.
   * Added unit test suite.
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index cc72f7f657..82ead5f136 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -31,8 +31,6 @@
 
 #include "pcap_osdep.h"
 
-#define RTE_ETH_PCAP_SNAPSHOT_LEN 65535
-
 #define ETH_PCAP_RX_PCAP_ARG  "rx_pcap"
 #define ETH_PCAP_TX_PCAP_ARG  "tx_pcap"
 #define ETH_PCAP_RX_IFACE_ARG "rx_iface"
@@ -41,6 +39,9 @@
 #define ETH_PCAP_IFACE_ARG    "iface"
 #define ETH_PCAP_PHY_MAC_ARG  "phy_mac"
 #define ETH_PCAP_INFINITE_RX_ARG  "infinite_rx"
+#define ETH_PCAP_SNAPSHOT_LEN_ARG "snaplen"
+
+#define ETH_PCAP_SNAPSHOT_LEN_DEFAULT 65535
 
 #define ETH_PCAP_ARG_MAXLEN	64
 
@@ -98,6 +99,7 @@ struct pmd_internals {
 	char devargs[ETH_PCAP_ARG_MAXLEN];
 	struct rte_ether_addr eth_addr;
 	int if_index;
+	uint32_t snapshot_len;
 	bool single_iface;
 	bool phy_mac;
 	bool infinite_rx;
@@ -125,6 +127,7 @@ struct pmd_devargs {
 struct pmd_devargs_all {
 	struct pmd_devargs rx_queues;
 	struct pmd_devargs tx_queues;
+	uint32_t snapshot_len;
 	bool single_iface;
 	bool is_tx_pcap;
 	bool is_tx_iface;
@@ -142,11 +145,16 @@ static const char *valid_arguments[] = {
 	ETH_PCAP_IFACE_ARG,
 	ETH_PCAP_PHY_MAC_ARG,
 	ETH_PCAP_INFINITE_RX_ARG,
+	ETH_PCAP_SNAPSHOT_LEN_ARG,
 	NULL
 };
 
 RTE_LOG_REGISTER_DEFAULT(eth_pcap_logtype, NOTICE);
 
+/* Forward declaration */
+static inline int set_iface_direction(const char *iface, pcap_t *pcap,
+				      pcap_direction_t direction);
+
 static struct queue_missed_stat*
 queue_missed_stat_update(struct rte_eth_dev *dev, unsigned int qid)
 {
@@ -406,25 +414,24 @@ pcap_pktmbuf_read(const struct rte_mbuf *m,
 static uint16_t
 eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
-	unsigned int i;
-	struct pmd_process_private *pp;
 	struct pcap_tx_queue *dumper_q = queue;
-	pcap_dumper_t *dumper;
+	struct rte_eth_dev *dev = &rte_eth_devices[dumper_q->port_id];
+	struct pmd_internals *internals = dev->data->dev_private;
+	struct pmd_process_private *pp = dev->process_private;
+	uint32_t snaplen = internals->snapshot_len;
+	pcap_dumper_t *dumper = pp->tx_dumper[dumper_q->queue_id];
 	uint16_t num_tx = 0;
 	uint32_t tx_bytes = 0;
 	struct pcap_pkthdr header;
 
-	pp = rte_eth_devices[dumper_q->port_id].process_private;
-	dumper = pp->tx_dumper[dumper_q->queue_id];
-
-	if (unlikely(dumper == NULL || nb_pkts == 0))
+	if (unlikely(dumper == NULL))
 		return 0;
 
 	/* all packets in burst have same timestamp */
 	calculate_timestamp(&header.ts);
 
 	/* writes the nb_pkts packets to the previously opened pcap file dumper */
-	for (i = 0; i < nb_pkts; i++) {
+	for (uint16_t i = 0; i < nb_pkts; i++) {
 		struct rte_mbuf *mbuf = bufs[i];
 
 		if (mbuf->ol_flags & RTE_MBUF_F_TX_VLAN) {
@@ -434,11 +441,12 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		}
 
 		uint32_t len = rte_pktmbuf_pkt_len(mbuf);
+		uint32_t caplen = RTE_MIN(len, snaplen);
 		header.len = len;
-		header.caplen = len;
+		header.caplen = caplen;
 
 		void *temp = NULL;
-		const uint8_t *data = pcap_pktmbuf_read(mbuf, 0, len, &temp);
+		const uint8_t *data = pcap_pktmbuf_read(mbuf, 0, caplen, &temp);
 		if (likely(data != NULL)) {
 			pcap_dump((u_char *)dumper, &header, data);
 
@@ -537,7 +545,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
  * pcap_open_live wrapper function
  */
 static inline int
-open_iface_live(const char *iface, pcap_t **pcap)
+open_iface_live(const char *iface, pcap_t **pcap, uint32_t snaplen)
 {
 	char errbuf[PCAP_ERRBUF_SIZE];
 	pcap_t *pc;
@@ -564,7 +572,7 @@ open_iface_live(const char *iface, pcap_t **pcap)
 		PMD_LOG(WARNING, "%s: Could not set to promiscuous: %s",
 			iface, pcap_statustostr(status));
 
-	status = pcap_set_snaplen(pc, RTE_ETH_PCAP_SNAPSHOT_LEN);
+	status = pcap_set_snaplen(pc, snaplen);
 	if (status != 0)
 		PMD_LOG(WARNING, "%s: Could not set snapshot length: %s",
 			iface, pcap_statustostr(status));
@@ -595,9 +603,9 @@ open_iface_live(const char *iface, pcap_t **pcap)
 }
 
 static int
-open_single_iface(const char *iface, pcap_t **pcap)
+open_single_iface(const char *iface, pcap_t **pcap, uint32_t snaplen)
 {
-	if (open_iface_live(iface, pcap) < 0) {
+	if (open_iface_live(iface, pcap, snaplen) < 0) {
 		PMD_LOG(ERR, "Couldn't open interface %s", iface);
 		return -1;
 	}
@@ -606,7 +614,8 @@ open_single_iface(const char *iface, pcap_t **pcap)
 }
 
 static int
-open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
+open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper,
+		    uint32_t snaplen)
 {
 	pcap_t *tx_pcap;
 
@@ -616,7 +625,7 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 	 * pcap holder.
 	 */
 	tx_pcap = pcap_open_dead_with_tstamp_precision(DLT_EN10MB,
-			RTE_ETH_PCAP_SNAPSHOT_LEN, PCAP_TSTAMP_PRECISION_NANO);
+			snaplen, PCAP_TSTAMP_PRECISION_NANO);
 	if (tx_pcap == NULL) {
 		PMD_LOG(ERR, "Couldn't create dead pcap");
 		return -1;
@@ -677,6 +686,7 @@ eth_dev_start(struct rte_eth_dev *dev)
 	struct pmd_process_private *pp = dev->process_private;
 	struct pcap_tx_queue *tx;
 	struct pcap_rx_queue *rx;
+	uint32_t snaplen = internals->snapshot_len;
 
 	if (internals->timestamp_offloading) {
 		int ret = rte_mbuf_dyn_rx_timestamp_register(&timestamp_dynfield_offset,
@@ -694,7 +704,7 @@ eth_dev_start(struct rte_eth_dev *dev)
 
 		if (!pp->tx_pcap[0] &&
 			strcmp(tx->type, ETH_PCAP_IFACE_ARG) == 0) {
-			if (open_single_iface(tx->name, &pp->tx_pcap[0]) < 0)
+			if (open_single_iface(tx->name, &pp->tx_pcap[0], snaplen) < 0)
 				return -1;
 			pp->rx_pcap[0] = pp->tx_pcap[0];
 		}
@@ -706,14 +716,11 @@ eth_dev_start(struct rte_eth_dev *dev)
 	for (i = 0; i < dev->data->nb_tx_queues; i++) {
 		tx = &internals->tx_queue[i];
 
-		if (!pp->tx_dumper[i] &&
-				strcmp(tx->type, ETH_PCAP_TX_PCAP_ARG) == 0) {
-			if (open_single_tx_pcap(tx->name,
-				&pp->tx_dumper[i]) < 0)
+		if (!pp->tx_dumper[i] && strcmp(tx->type, ETH_PCAP_TX_PCAP_ARG) == 0) {
+			if (open_single_tx_pcap(tx->name, &pp->tx_dumper[i], snaplen) < 0)
 				return -1;
-		} else if (!pp->tx_pcap[i] &&
-				strcmp(tx->type, ETH_PCAP_TX_IFACE_ARG) == 0) {
-			if (open_single_iface(tx->name, &pp->tx_pcap[i]) < 0)
+		} else if (!pp->tx_pcap[i] && strcmp(tx->type, ETH_PCAP_TX_IFACE_ARG) == 0) {
+			if (open_single_iface(tx->name, &pp->tx_pcap[i], snaplen) < 0)
 				return -1;
 		}
 	}
@@ -728,9 +735,14 @@ eth_dev_start(struct rte_eth_dev *dev)
 		if (strcmp(rx->type, ETH_PCAP_RX_PCAP_ARG) == 0) {
 			if (open_single_rx_pcap(rx->name, &pp->rx_pcap[i]) < 0)
 				return -1;
-		} else if (strcmp(rx->type, ETH_PCAP_RX_IFACE_ARG) == 0) {
-			if (open_single_iface(rx->name, &pp->rx_pcap[i]) < 0)
+		} else if (strcmp(rx->type, ETH_PCAP_RX_IFACE_ARG) == 0 ||
+			   strcmp(rx->type, ETH_PCAP_RX_IFACE_IN_ARG) == 0) {
+			if (open_single_iface(rx->name, &pp->rx_pcap[i], snaplen) < 0)
 				return -1;
+			/* Set direction for rx_iface_in */
+			if (strcmp(rx->type, ETH_PCAP_RX_IFACE_IN_ARG) == 0)
+				set_iface_direction(rx->name, pp->rx_pcap[i],
+						    PCAP_D_IN);
 		}
 	}
 
@@ -821,11 +833,11 @@ eth_dev_info(struct rte_eth_dev *dev,
 
 	dev_info->if_index = internals->if_index;
 	dev_info->max_mac_addrs = 1;
-	dev_info->max_rx_pktlen = RTE_ETH_PCAP_SNAPSHOT_LEN;
+	dev_info->max_rx_pktlen = internals->snapshot_len;
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
-	dev_info->min_rx_bufsize = 0;
-	dev_info->max_mtu = RTE_ETH_PCAP_SNAPSHOT_LEN - RTE_ETHER_HDR_LEN;
+	dev_info->min_rx_bufsize = RTE_ETHER_MIN_LEN;
+	dev_info->max_mtu = internals->snapshot_len - RTE_ETHER_HDR_LEN;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
@@ -1242,41 +1254,32 @@ open_rx_pcap(const char *key, const char *value, void *extra_args)
 }
 
 /*
- * Opens a pcap file for writing and stores a reference to it
- * for use it later on.
+ * Store TX pcap file configuration.
+ * The actual pcap dumper is opened in eth_dev_start().
  */
 static int
 open_tx_pcap(const char *key, const char *value, void *extra_args)
 {
 	const char *pcap_filename = value;
 	struct pmd_devargs *dumpers = extra_args;
-	pcap_dumper_t *dumper;
-
-	if (open_single_tx_pcap(pcap_filename, &dumper) < 0)
-		return -1;
 
-	if (add_queue(dumpers, pcap_filename, key, NULL, dumper) < 0) {
-		pcap_dump_close(dumper);
+	if (add_queue(dumpers, pcap_filename, key, NULL, NULL) < 0)
 		return -1;
-	}
 
 	return 0;
 }
 
 /*
- * Opens an interface for reading and writing
+ * Store interface configuration for reading and writing.
+ * The actual pcap handle is opened in eth_dev_start().
  */
 static inline int
 open_rx_tx_iface(const char *key, const char *value, void *extra_args)
 {
 	const char *iface = value;
 	struct pmd_devargs *tx = extra_args;
-	pcap_t *pcap = NULL;
 
-	if (open_single_iface(iface, &pcap) < 0)
-		return -1;
-
-	tx->queue[0].pcap = pcap;
+	tx->queue[0].pcap = NULL;
 	tx->queue[0].name = iface;
 	tx->queue[0].type = key;
 
@@ -1298,42 +1301,30 @@ set_iface_direction(const char *iface, pcap_t *pcap,
 	return 0;
 }
 
+/*
+ * Store interface configuration.
+ * The actual pcap handle is opened in eth_dev_start().
+ */
 static inline int
 open_iface(const char *key, const char *value, void *extra_args)
 {
 	const char *iface = value;
 	struct pmd_devargs *pmd = extra_args;
-	pcap_t *pcap = NULL;
 
-	if (open_single_iface(iface, &pcap) < 0)
-		return -1;
-	if (add_queue(pmd, iface, key, pcap, NULL) < 0) {
-		pcap_close(pcap);
+	if (add_queue(pmd, iface, key, NULL, NULL) < 0)
 		return -1;
-	}
 
 	return 0;
 }
 
 /*
- * Opens a NIC for reading packets from it
+ * Store RX interface configuration.
+ * The actual pcap handle is opened and direction set in eth_dev_start().
  */
 static inline int
 open_rx_iface(const char *key, const char *value, void *extra_args)
 {
-	int ret = open_iface(key, value, extra_args);
-	if (ret < 0)
-		return ret;
-	if (strcmp(key, ETH_PCAP_RX_IFACE_IN_ARG) == 0) {
-		struct pmd_devargs *pmd = extra_args;
-		unsigned int qid = pmd->num_of_queue - 1;
-
-		set_iface_direction(pmd->queue[qid].name,
-				pmd->queue[qid].pcap,
-				PCAP_D_IN);
-	}
-
-	return 0;
+	return open_iface(key, value, extra_args);
 }
 
 static inline int
@@ -1373,6 +1364,29 @@ process_bool_flag(const char *key, const char *value, void *extra_args)
 	return 0;
 }
 
+static int
+process_snapshot_len(const char *key, const char *value, void *extra_args)
+{
+	uint32_t *snaplen = extra_args;
+	unsigned long val;
+	char *endptr;
+
+	if (value == NULL || *value == '\0') {
+		PMD_LOG(ERR, "Argument '%s' requires a value", key);
+		return -1;
+	}
+
+	errno = 0;
+	val = strtoul(value, &endptr, 10);
+	if (errno != 0 || *endptr != '\0' || val == 0 || val > UINT32_MAX) {
+		PMD_LOG(ERR, "Invalid '%s' value '%s'", key, value);
+		return -1;
+	}
+
+	*snaplen = (uint32_t)val;
+	return 0;
+}
+
 static int
 pmd_init_internals(struct rte_vdev_device *vdev,
 		const unsigned int nb_rx_queues,
@@ -1537,6 +1551,8 @@ eth_from_pcaps(struct rte_vdev_device *vdev,
 	}
 
 	internals->infinite_rx = infinite_rx;
+	internals->snapshot_len = devargs_all->snapshot_len;
+
 	/* Assign rx ops. */
 	if (infinite_rx)
 		eth_dev->rx_pkt_burst = eth_pcap_rx_infinite;
@@ -1597,6 +1613,7 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 	int ret = 0;
 
 	struct pmd_devargs_all devargs_all = {
+		.snapshot_len = ETH_PCAP_SNAPSHOT_LEN_DEFAULT,
 		.single_iface = 0,
 		.is_tx_pcap = 0,
 		.is_tx_iface = 0,
@@ -1632,6 +1649,17 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 			return -1;
 	}
 
+	/*
+	 * Process optional snapshot length argument.
+	 */
+	if (rte_kvargs_count(kvlist, ETH_PCAP_SNAPSHOT_LEN_ARG) == 1) {
+		ret = rte_kvargs_process(kvlist, ETH_PCAP_SNAPSHOT_LEN_ARG,
+					 &process_snapshot_len,
+					 &devargs_all.snapshot_len);
+		if (ret < 0)
+			goto free_kvlist;
+	}
+
 	/*
 	 * If iface argument is passed we open the NICs and use them for
 	 * reading / writing
@@ -1837,5 +1865,6 @@ RTE_PMD_REGISTER_PARAM_STRING(net_pcap,
 	ETH_PCAP_RX_IFACE_IN_ARG "=<ifc> "
 	ETH_PCAP_TX_IFACE_ARG "=<ifc> "
 	ETH_PCAP_IFACE_ARG "=<ifc> "
-	ETH_PCAP_PHY_MAC_ARG "=<int>"
-	ETH_PCAP_INFINITE_RX_ARG "=<0|1>");
+	ETH_PCAP_PHY_MAC_ARG "=<int> "
+	ETH_PCAP_INFINITE_RX_ARG "=<0|1> "
+	ETH_PCAP_SNAPSHOT_LEN_ARG "=<int>");
-- 
2.51.0

