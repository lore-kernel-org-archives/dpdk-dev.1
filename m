Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC3A9E94623
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 00:02:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D2AE40A6B;
	Tue, 10 Feb 2026 01:02:19 +0100 (CET)
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52]) by mails.dpdk.org (Postfix) with ESMTP id 8D90640687
 for <dev@dpdk.org>; Tue, 10 Feb 2026 01:02:18 +0100 (CET)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-437711e9195so975652f8f.1
 for <dev@dpdk.org>; Mon, 09 Feb 2026 16:02:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770681738;
 x=1771286538; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XmNMQW8nzIxCecvK83aZY71pK+8U0QKARUKmj0yUhyQ=;
 b=FDj+zw0W2ZZlX4AgIrwZDKvxdivKIPZBG9QaACkcfr23/GxV2d16XDKvoPQUoNRNNc
 oF8f1mU3xwmzImShhQ1fFiDLM2nxXJeUzAYy2OGBhw3h5WOgrh5ffgf8ZVd4VJU5nqpg
 3JArD7nC9xF9GgMH/vfnRdi7R1As3OL9XbCQhhyFqVuEqfj0bxwlDRSNbV60uUnjtC1q
 LPcwAzAUt/xybm9XMqLF8G/GhzR1KDPF1DF/b3gkfcgsLf+yfTEFF4ZrPkHy9vkyUyLM
 pIfCtqN4qEH5AhbeNQsRX7BSJzuaWRg1L81sPKU0fPt0aQsgEsruCnL3U521E3UFZFTn
 cY5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770681738; x=1771286538;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XmNMQW8nzIxCecvK83aZY71pK+8U0QKARUKmj0yUhyQ=;
 b=ATeP1IQ93yyWmj2RAguoM64n7IC9FusdRtanfONs5WlGq/94HPfPjnr+XBwlRU5DfE
 Q1dQU84M9JKyYH2eO9dDr7m7bCm1kW3APyVn7mCvTT7XYm1yDSxffv7b24e5yvbq1feH
 UH5kuay+V5d4CZr+bM7+MqcBo9zNjyitdplj6vn8SZPsMhlyMTzaZJCYGduWzexAAJPV
 LYAz+3yRSE3gXW+UR27OVE05y/0emi6cUH6+htwaEjCTCYXHYYbsPzxnFwihmFkZ2QjR
 ayT8j9mKZkUv38ZTdszNNy7oncEdEbxTjZJds3xi3b2m47+7ZhzqT0xUR7vw4aWKMAdO
 sViQ==
X-Gm-Message-State: AOJu0YyKu4KAhyU76AuxWjYksXAyWxMh9gmJiHHv/YDc+8qXLiIpPh00
 r2ibUKihNI/MFu5In1HYRcF3zZ63QBtQZR0hnlUYSawZ27Cq93clxXihCNmwlZjSkFOGEkLIy8C
 5pKcn
X-Gm-Gg: AZuq6aJW59XkYtTRcu5EiZZNLnn7ToM+qD93wB1BaVCnyeSxWo+9GKa+BOT7PD4epbz
 esjGSOtQat6IAi2vniwugF4O2ulR+Px3I87MKAFcli7vVtCMmx+MFb5VNivcekieMBdoEiEyTnj
 4WK8ukL0NPmazq/pymJSYeZsOzLeF0+bn3RKzl2b9pxS9u8pODfUDunIZOaCtZZ3EAy02N2RHQF
 9YPd9Kt+XjxSOXaBeh8W9frSAGGeIfYRJmxXyzfRT6ZkhJFIPgfEEfpMcgxOW347mQSBEENssqt
 FDD4CWmgtnXxYhCwmsijuhsDZvxtrteuhCb6Bwsi3CDqiYbsykPGeH125vtcpQrxqbF4bpKiGz7
 NidbGY5iJoJnV7zASjisQ5kpW4OxEQUVSXmDQb/v8OudbfHmbx0WpDaRoyLgwRu3LqEuYxuOOTA
 gugOXiojm1e4vqJsJTOtIpOkHESWqE2XtTA8mj2yVYQHz3j2DmsQ==
X-Received: by 2002:a05:6000:220b:b0:436:2fef:fe5c with SMTP id
 ffacd0b85a97d-4377a52eca1mr498142f8f.20.1770681737978; 
 Mon, 09 Feb 2026 16:02:17 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436296bd211sm31529133f8f.13.2026.02.09.16.02.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Feb 2026 16:02:16 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v13 06/16] net/pcap: cleanup transmit burst logic
Date: Mon,  9 Feb 2026 16:00:37 -0800
Message-ID: <20260210000201.295839-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260210000201.295839-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260210000201.295839-1-stephen@networkplumber.org>
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

To handle possible multi segment mbufs, the driver would allocate
a worst case 64k buffer on the stack. Since each Tx queue is
single threaded, better to allocate the buffer from hugepage
with rte_malloc when queue is setup.

The buffer needs to be come from huge pages because the primary
process may start the device but the bounce buffer could be used
in transmit path by secondary process.

Using function rte_pktmbuf_free_bulk is marginally faster here.

Do proper handling of pcap_sendpacket() errors.
The function can return -1 in case of device queue being full.
This should not be counted as an error.

The driver has always handled multi-segment transmit
but the flag was never set in the offload capabilities.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 114 +++++++++++++++++++--------------
 drivers/net/pcap/pcap_osdep.h  |  14 ++++
 2 files changed, 81 insertions(+), 47 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 806451dc99..84da41542b 100644
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
@@ -404,27 +407,24 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
-		rte_pktmbuf_free(mbuf);
+		data = rte_pktmbuf_read(mbuf, 0, caplen, temp_data);
+		if (likely(data != NULL)) {
+			pcap_dump((u_char *)dumper, &header, data);
+			num_tx++;
+			tx_bytes += caplen;
+		}
 	}
+	rte_pktmbuf_free_bulk(bufs, nb_pkts);
 
 	/*
 	 * Since there's no place to hook a callback when the forwarding
@@ -449,71 +449,74 @@ eth_tx_drop(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	uint32_t tx_bytes = 0;
 	struct pcap_tx_queue *tx_queue = queue;
 
-	if (unlikely(nb_pkts == 0))
-		return 0;
-
-	for (i = 0; i < nb_pkts; i++) {
+	for (i = 0; i < nb_pkts; i++)
 		tx_bytes += bufs[i]->pkt_len;
-		rte_pktmbuf_free(bufs[i]);
-	}
+
+	rte_pktmbuf_free_bulk(bufs, nb_pkts);
 
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
-			rte_pktmbuf_free(mbuf);
+		struct rte_mbuf *mbuf = bufs[i];
+		uint32_t len = rte_pktmbuf_pkt_len(mbuf);
+
+		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) && len > RTE_ETH_PCAP_SNAPSHOT_LEN)) {
+			PMD_TX_LOG(ERR,
+				"Dropping multi segment PCAP packet. Size (%u) > max size (%u).",
+				len, RTE_ETH_PCAP_SNAPSHOT_LEN);
+			tx_queue->tx_stat.err_pkts++;
 			continue;
 		}
 
-		/* rte_pktmbuf_read() returns a pointer to the data directly
-		 * in the mbuf (when the mbuf is contiguous) or, otherwise,
-		 * a pointer to temp_data after copying into it.
-		 */
-		ret = pcap_sendpacket(pcap,
-			rte_pktmbuf_read(mbuf, 0, len, temp_data), len);
-		if (unlikely(ret != 0))
+		if (pcap_sendpacket(pcap, rte_pktmbuf_read(mbuf, 0, len, temp_data), len) != 0) {
+			/* Unfortunately, libpcap collapses transient and hard errors. */
+			PMD_TX_LOG(ERR, "pcap_sendpacket() failed: %s", pcap_geterr(pcap));
 			break;
+		}
+
 		num_tx++;
 		tx_bytes += len;
-		rte_pktmbuf_free(mbuf);
 	}
 
+	rte_pktmbuf_free_bulk(bufs, i);
+
 	tx_queue->tx_stat.pkts += num_tx;
 	tx_queue->tx_stat.bytes += tx_bytes;
-	tx_queue->tx_stat.err_pkts += i - num_tx;
 
 	return i;
 }
@@ -753,6 +756,7 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
 
 	return 0;
 }
@@ -965,7 +969,7 @@ static int
 eth_tx_queue_setup(struct rte_eth_dev *dev,
 		uint16_t tx_queue_id,
 		uint16_t nb_tx_desc __rte_unused,
-		unsigned int socket_id __rte_unused,
+		unsigned int socket_id,
 		const struct rte_eth_txconf *tx_conf __rte_unused)
 {
 	struct pmd_internals *internals = dev->data->dev_private;
@@ -973,11 +977,26 @@ eth_tx_queue_setup(struct rte_eth_dev *dev,
 
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
@@ -1018,6 +1037,7 @@ static const struct eth_dev_ops ops = {
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

