Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4EC6ECD6EE
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Feb 2026 22:22:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A01840684;
	Wed, 11 Feb 2026 23:21:53 +0100 (CET)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com
 [209.85.128.44]) by mails.dpdk.org (Postfix) with ESMTP id 507A440673
 for <dev@dpdk.org>; Wed, 11 Feb 2026 23:21:52 +0100 (CET)
Received: by mail-wm1-f44.google.com with SMTP id
 5b1f17b1804b1-47ee07570deso53833465e9.1
 for <dev@dpdk.org>; Wed, 11 Feb 2026 14:21:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770848512;
 x=1771453312; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gefcbVnVlZlhWjdgRtKdmetpBX5lyuIZJv028ErtfhY=;
 b=eeLDartLsdsqSrI1J7usZ2QiHqkZidyTwpwxwVY8cnOm2fIBIFG9KnrvWETDew2qN0
 nMl8FbaOBiSffytEwTdKpkcEMWpNjrMGGS7tW3br4oUuVqzvg2eXPr8CfwV+HPH/dnFi
 wu8ekBrg6q8sC3LwnCCRlnzwdlREDWqGE220uOujsIbrkN3l613uZmNy0BmYJf0xLKDV
 LGfCFg97fX+YCeV778qs+gs/fhQR86q8LKYXwQBdQr7dEMbXgdCWLuGR/C8hdOhz1lji
 2CvRvHhuAL6upXsAhzqGgEII1z0H9Bf3DC814fb2DzanYvW0NiIpnqYn7YtOY6P7iSfe
 G0rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770848512; x=1771453312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gefcbVnVlZlhWjdgRtKdmetpBX5lyuIZJv028ErtfhY=;
 b=gJhts7MOJfCjBW2fLJSTUxSEEdW48VHoV5P17Qgvg/5w1UZ+m9px3KGGrUkvnSIifq
 whRGTuRGWL5wZ3p3LIGgnEGNgw4t+Qe055H/YDfr7CBQJSXq2oYensBfFJZ4mxGSL9ev
 dvXLE6/N+FiUWSGATx9NO2k09o2QBC/YVvX/XpRuhuAQMu8x6/Sfuk++mkcfEoAM4Abb
 NCxRcRLctJe0nD7hNYlSU+ewnyTCArcAJZrf/guBSmwWkhq1P9lQkajg8zvHHL4nlQtK
 Da8dxJjejMcYY6Y3QJCjWS+Tp/uXpRq6q12kD4Kv9QU/6M8XZ2K1vG8ipPkHIsqHELXn
 NHYQ==
X-Gm-Message-State: AOJu0Yxc1Ip6JYvZrl1i3KME+ioHzL7uum9f2j/vC0ubWTrvweSxgH+m
 54o6g/eeF2eGRaVoigOGFc+K8pem/S9Ynu1eL9eZj9r402wjI749Vf6wx3aYUV9ZUYAYnIbawh0
 6tCKf
X-Gm-Gg: AZuq6aKt4GPUmxnuU8slTNemu3QYf2adSArtqHt9BYgKAXm6iqXNz8At5tVPqiWwUD/
 s++piodQYMhW1RQgyahhunLgXKmtYvkfQ9/KYZEtFVnNV4wc3QbfQaYKKXd/MtBkqhxcamulsNH
 HtaGM5mh3QtHWrdqM0ZoM6jh3+cc69GwvMWCb4um4pcwbYnHPS7AupHP6CNgKepBiPFGG4y+Msu
 wtbyUE9tCHxIK4wYPi0e5/xEdJMe5zIg/JRdI+ue+k+8/Mk+8rS2ZzGPNi1yutYkC+a2ivO5cfG
 BPL4DhyYhOIWhnaFHtMQAhmpRMklNhg8EbiPsjAgzZ7sVZUuuZVQcxlPP+6GafzuYXG00MXnROy
 lbeqzzsRzk+7w+vunhHnNQYl/e+BJdpHWZBQ8O7ZSVnV4NwmiKJmaQU5N2m+9Gm2ZXiB7stT+5x
 LXFJ0R1WxtgDWTfByVRhjCOHHmQwGaZ4rol4MKSnuJnigXNWExacduCDAOsPF7QA==
X-Received: by 2002:a05:600c:3b08:b0:483:885:f0b0 with SMTP id
 5b1f17b1804b1-4836571fc70mr9311615e9.35.1770848511764; 
 Wed, 11 Feb 2026 14:21:51 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783e0196bsm7877965f8f.23.2026.02.11.14.21.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Feb 2026 14:21:51 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>, stable@dpdk.org,
 Ferruh Yigit <ferruh.yigit@amd.com>,
 David Marchand <david.marchand@redhat.com>
Subject: [PATCH v14 06/18] net/pcap: rework transmit burst handling
Date: Wed, 11 Feb 2026 13:09:39 -0800
Message-ID: <20260211222130.338797-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260211222130.338797-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260211222130.338797-1-stephen@networkplumber.org>
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

Replace the 64K stack-allocated bounce buffer with a per-queue
buffer allocated from hugepages via rte_malloc at queue setup.
This is necessary because the buffer may be used in a secondary
process transmit path where the primary process allocated it.

Fix error accounting: backpressure from pcap_sendpacket() (kernel
socket buffer full) was incorrectly counted as errors. Malformed
multi-segment mbufs where pkt_len exceeds actual data were silently
accepted; they are now detected via rte_pktmbuf_read() failure
and counted as errors.

Add datapath debug logging macros (PMD_RX_LOG, PMD_TX_LOG) gated
on RTE_ETHDEV_DEBUG_RX/TX. Advertise RTE_ETH_TX_OFFLOAD_MULTI_SEGS
in device capabilities since the driver has always supported
multi-segment transmit. Add tx_queue_release to free the bounce
buffer.

Fixes: fbbbf553f268 ("net/pcap: fix concurrent multiseg Tx")
Cc: stable@dpdk.org

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 122 +++++++++++++++++++++------------
 drivers/net/pcap/pcap_osdep.h  |  14 ++++
 2 files changed, 92 insertions(+), 44 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 806451dc99..4761741edd 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -12,6 +12,7 @@
 #include <errno.h>
 #include <sys/time.h>
 #include <sys/types.h>
+#include <unistd.h>
 #include <pcap.h>
 
 #include <rte_cycles.h>
@@ -91,6 +92,9 @@ struct pcap_tx_queue {
 	struct queue_stat tx_stat;
 	char name[PATH_MAX];
 	char type[ETH_PCAP_ARG_MAXLEN];
+
+	/* Temp buffer used for non-linear packets */
+	uint8_t *bounce_buf;
 };
 
 struct pmd_internals {
@@ -385,18 +389,17 @@ static uint16_t
 eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
 	unsigned int i;
-	struct rte_mbuf *mbuf;
 	struct pmd_process_private *pp;
 	struct pcap_tx_queue *dumper_q = queue;
 	uint16_t num_tx = 0;
 	uint32_t tx_bytes = 0;
 	struct pcap_pkthdr header;
 	pcap_dumper_t *dumper;
-	unsigned char temp_data[RTE_ETH_PCAP_SNAPLEN];
-	size_t len, caplen;
+	unsigned char *temp_data;
 
 	pp = rte_eth_devices[dumper_q->port_id].process_private;
 	dumper = pp->tx_dumper[dumper_q->queue_id];
+	temp_data = dumper_q->bounce_buf;
 
 	if (dumper == NULL || nb_pkts == 0)
 		return 0;
@@ -404,25 +407,28 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	/* writes the nb_pkts packets to the previously opened pcap file
 	 * dumper */
 	for (i = 0; i < nb_pkts; i++) {
-		mbuf = bufs[i];
+		struct rte_mbuf *mbuf = bufs[i];
+		uint32_t len, caplen;
+		const uint8_t *data;
+
 		len = caplen = rte_pktmbuf_pkt_len(mbuf);
-		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) &&
-				len > sizeof(temp_data))) {
-			caplen = sizeof(temp_data);
-		}
 
 		calculate_timestamp(&header.ts);
 		header.len = len;
 		header.caplen = caplen;
-		/* rte_pktmbuf_read() returns a pointer to the data directly
-		 * in the mbuf (when the mbuf is contiguous) or, otherwise,
-		 * a pointer to temp_data after copying into it.
-		 */
-		pcap_dump((u_char *)dumper, &header,
-			rte_pktmbuf_read(mbuf, 0, caplen, temp_data));
 
-		num_tx++;
-		tx_bytes += caplen;
+		data = rte_pktmbuf_read(mbuf, 0, caplen, temp_data);
+		if (unlikely(data == NULL)) {
+			/* This only happens if mbuf is bogus pkt_len > data_len */
+			PMD_TX_LOG(ERR, "rte_pktmbuf_read failed");
+			dumper_q->tx_stat.err_pkts++;
+		} else {
+			pcap_dump((u_char *)dumper, &header, data);
+
+			num_tx++;
+			tx_bytes += caplen;
+		}
+
 		rte_pktmbuf_free(mbuf);
 	}
 
@@ -449,9 +455,6 @@ eth_tx_drop(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	uint32_t tx_bytes = 0;
 	struct pcap_tx_queue *tx_queue = queue;
 
-	if (unlikely(nb_pkts == 0))
-		return 0;
-
 	for (i = 0; i < nb_pkts; i++) {
 		tx_bytes += bufs[i]->pkt_len;
 		rte_pktmbuf_free(bufs[i]);
@@ -460,60 +463,74 @@ eth_tx_drop(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	tx_queue->tx_stat.pkts += nb_pkts;
 	tx_queue->tx_stat.bytes += tx_bytes;
 
-	return i;
+	return nb_pkts;
 }
 
 /*
- * Callback to handle sending packets through a real NIC.
+ * Send a burst of packets to a pcap device.
+ *
+ * On Linux, pcap_sendpacket() calls send() on a blocking PF_PACKET
+ * socket with default kernel buffer sizes and no TX ring (PACKET_TX_RING).
+ * The send() call only blocks when the kernel socket send buffer is full,
+ * providing limited backpressure.
+ *
+ * On error, pcap_sendpacket() returns non-zero and the loop breaks,
+ * leaving remaining packets unsent.
+ *
+ * Bottom line: backpressure is not an error.
  */
 static uint16_t
 eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
 	unsigned int i;
-	int ret;
-	struct rte_mbuf *mbuf;
 	struct pmd_process_private *pp;
 	struct pcap_tx_queue *tx_queue = queue;
 	uint16_t num_tx = 0;
 	uint32_t tx_bytes = 0;
 	pcap_t *pcap;
-	unsigned char temp_data[RTE_ETH_PCAP_SNAPLEN];
-	size_t len;
+	unsigned char *temp_data;
 
 	pp = rte_eth_devices[tx_queue->port_id].process_private;
 	pcap = pp->tx_pcap[tx_queue->queue_id];
+	temp_data = tx_queue->bounce_buf;
 
 	if (unlikely(nb_pkts == 0 || pcap == NULL))
 		return 0;
 
 	for (i = 0; i < nb_pkts; i++) {
-		mbuf = bufs[i];
-		len = rte_pktmbuf_pkt_len(mbuf);
-		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) &&
-				len > sizeof(temp_data))) {
-			PMD_LOG(ERR,
-				"Dropping multi segment PCAP packet. Size (%zd) > max size (%zd).",
-				len, sizeof(temp_data));
+		struct rte_mbuf *mbuf = bufs[i];
+		uint32_t len = rte_pktmbuf_pkt_len(mbuf);
+		const uint8_t *data;
+
+		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) && len > RTE_ETH_PCAP_SNAPSHOT_LEN)) {
+			PMD_TX_LOG(ERR,
+				"Dropping multi segment PCAP packet. Size (%u) > max size (%u).",
+				len, RTE_ETH_PCAP_SNAPSHOT_LEN);
+			tx_queue->tx_stat.err_pkts++;
 			rte_pktmbuf_free(mbuf);
 			continue;
 		}
 
-		/* rte_pktmbuf_read() returns a pointer to the data directly
-		 * in the mbuf (when the mbuf is contiguous) or, otherwise,
-		 * a pointer to temp_data after copying into it.
-		 */
-		ret = pcap_sendpacket(pcap,
-			rte_pktmbuf_read(mbuf, 0, len, temp_data), len);
-		if (unlikely(ret != 0))
-			break;
-		num_tx++;
-		tx_bytes += len;
+		data = rte_pktmbuf_read(mbuf, 0, len, temp_data);
+		if (unlikely(data == NULL)) {
+			/* This only happens if mbuf is bogus pkt_len > data_len */
+			PMD_TX_LOG(ERR, "rte_pktmbuf_read failed");
+			tx_queue->tx_stat.err_pkts++;
+		} else {
+			/* Unfortunately, libpcap collapses transient (-EBUSY) and hard errors. */
+			if (pcap_sendpacket(pcap, data, len) != 0) {
+				PMD_TX_LOG(ERR, "pcap_sendpacket() failed: %s", pcap_geterr(pcap));
+				break;
+			}
+			num_tx++;
+			tx_bytes += len;
+		}
+
 		rte_pktmbuf_free(mbuf);
 	}
 
 	tx_queue->tx_stat.pkts += num_tx;
 	tx_queue->tx_stat.bytes += tx_bytes;
-	tx_queue->tx_stat.err_pkts += i - num_tx;
 
 	return i;
 }
@@ -753,6 +770,7 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
 	return 0;
 }
@@ -965,7 +983,7 @@ static int
 eth_tx_queue_setup(struct rte_eth_dev *dev,
 		uint16_t tx_queue_id,
 		uint16_t nb_tx_desc __rte_unused,
-		unsigned int socket_id __rte_unused,
+		unsigned int socket_id,
 		const struct rte_eth_txconf *tx_conf __rte_unused)
 {
 	struct pmd_internals *internals = dev->data->dev_private;
@@ -973,11 +991,26 @@ eth_tx_queue_setup(struct rte_eth_dev *dev,
 
 	pcap_q->port_id = dev->data->port_id;
 	pcap_q->queue_id = tx_queue_id;
+	pcap_q->bounce_buf = rte_malloc_socket(NULL, RTE_ETH_PCAP_SNAPSHOT_LEN,
+					       RTE_CACHE_LINE_SIZE, socket_id);
+	if (pcap_q->bounce_buf == NULL)
+		return -ENOMEM;
+
 	dev->data->tx_queues[tx_queue_id] = pcap_q;
 
 	return 0;
 }
 
+static void
+eth_tx_queue_release(struct rte_eth_dev *dev, uint16_t tx_queue_id)
+{
+	struct pmd_internals *internals = dev->data->dev_private;
+	struct pcap_tx_queue *pcap_q = &internals->tx_queue[tx_queue_id];
+
+	rte_free(pcap_q->bounce_buf);
+	pcap_q->bounce_buf = NULL;
+}
+
 static int
 eth_rx_queue_start(struct rte_eth_dev *dev, uint16_t rx_queue_id)
 {
@@ -1018,6 +1051,7 @@ static const struct eth_dev_ops ops = {
 	.dev_infos_get = eth_dev_info,
 	.rx_queue_setup = eth_rx_queue_setup,
 	.tx_queue_setup = eth_tx_queue_setup,
+	.tx_queue_release = eth_tx_queue_release,
 	.rx_queue_start = eth_rx_queue_start,
 	.tx_queue_start = eth_tx_queue_start,
 	.rx_queue_stop = eth_rx_queue_stop,
diff --git a/drivers/net/pcap/pcap_osdep.h b/drivers/net/pcap/pcap_osdep.h
index a0e2b5ace9..fe7399ff9f 100644
--- a/drivers/net/pcap/pcap_osdep.h
+++ b/drivers/net/pcap/pcap_osdep.h
@@ -13,6 +13,20 @@
 extern int eth_pcap_logtype;
 #define RTE_LOGTYPE_ETH_PCAP eth_pcap_logtype
 
+#ifdef RTE_ETHDEV_DEBUG_RX
+#define PMD_RX_LOG(level, ...) \
+	RTE_LOG_LINE_PREFIX(level, ETH_PCAP, "%s() rx: ", __func__, __VA_ARGS__)
+#else
+#define PMD_RX_LOG(...) do { } while (0)
+#endif
+
+#ifdef RTE_ETHDEV_DEBUG_TX
+#define PMD_TX_LOG(level, ...) \
+	RTE_LOG_LINE_PREFIX(level, ETH_PCAP, "%s() tx: ", __func__, __VA_ARGS__)
+#else
+#define PMD_TX_LOG(...) do { } while (0)
+#endif
+
 int osdep_iface_index_get(const char *name);
 int osdep_iface_mac_get(const char *name, struct rte_ether_addr *mac);
 
-- 
2.51.0

