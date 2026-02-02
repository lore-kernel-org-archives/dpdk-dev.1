Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473AFE7FDE0
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Feb 2026 23:14:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 071E64065E;
	Tue,  3 Feb 2026 00:13:28 +0100 (CET)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48]) by mails.dpdk.org (Postfix) with ESMTP id E8AE640A72
 for <dev@dpdk.org>; Tue,  3 Feb 2026 00:13:25 +0100 (CET)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-47edd6111b4so53107195e9.1
 for <dev@dpdk.org>; Mon, 02 Feb 2026 15:13:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1770074005;
 x=1770678805; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dkL0ByJK5clME/5mt1EXTjvGpQWBFJ+zC35uvsHrzB8=;
 b=1ihhRUP7OM/BoGk7RX+J838I6Ui6PLTJvdYprcZU8Wv8BSyIjRu+W70phAwXuKXZXX
 KH/WmwTq1bgGz3ssh4LeWkUu+g7Q2ZmdpuiqAXhaqXykbxarMlBbn/jFQpngQQ2fLfeW
 4tcL93k5oav3hw20HFkzgghFR2cGLQH+AckHgYeJToUnlInxCBuuspMBw+12U1wq4ixs
 yVUagkG2uerHlJ9IhHOhqa3PqC/34FtmxSv/D7yf8osZQyNMs4D/57DeAxXA2Q12dBc1
 GCp5C0+5Er+0zNs9tUQkNyYyW1yxKU7i7haCxIXPhuP7hdOdHF/91WUUfuTRmtxcD52m
 mW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770074005; x=1770678805;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dkL0ByJK5clME/5mt1EXTjvGpQWBFJ+zC35uvsHrzB8=;
 b=gApYfWHVUt15Fj4J6FH2tYtCCKrIKKAmb5c6hoXkrdMKuTTb2DxacNpNpSPoaQbbhv
 x6JLZzjHFEvcOQ/JBv3gNv+8U23/2TdwlhMyQarPr54LJzAYB7ZU0xHcb/xtI3mQGxfw
 atOLYpYY0RnvhG7uSEe5FqASEDjN5fjar4yUs0wp/zAtpbtPBSfbmrWZPDmVzf+HgK34
 o2LGa/ZChfB4neDwdY23uXU9Za/OL2igIUXQaZnFlGqFRU6ZHKpsbtuKoPMRPrbbljVl
 yFVUpt/yHVo2jaHKsjIDqRCaUPw0+Jud7BimyVy+qC3Eg+/3mN8QO8hhCPA5xFmP5JPI
 R2Sg==
X-Gm-Message-State: AOJu0YyeTIRD1Ss4FxnmrOQoqKIxj0ZbVq+IsLK93TlZ+2WmBJ+UWfZV
 HQGWaxOdDsLGCJKw1tQtZsSRt4Jf1+mB7+Fk7Jr5bruapQzmlES4h3nmZNd3fGB3Z+a+bEjvJna
 ADpsz
X-Gm-Gg: AZuq6aIM/RjpfZcG3QoqQ9GhMW7+51rDO1EM0prjLhEA8oa+yR9phywdHGv9Mz84FXi
 vHZLIIK9VnAqDkQR5UNiem+St6xci7iYTM58hHc6hrQaZ3G9GcQvIVViQn4Jlozw+5MoDC5orz9
 j9iKvTKsBmMs+4yCzm4icJfg42s7Cc514i08RboGruPpR9xIUEFfRlxS9PTL0/bNFwEChx2Me75
 uYs8WeV+Xq2MdJuDa6h7OFQpz85TJvTrQ57s+R/twCP/A2nPArCOQEmm+b2MrJf7hZG/nRlH5Vs
 3W2HuXj0l08fy9LkJvimjM7e6LcSmGkUSkioRR7ph6eAyVoKz10tkhyW15hUqX2mKePQrYhpKpM
 5otTR3pkQ4sisIWLKsaGl3mf02TCX/b4LtvskHAwGUcJIavtwK7ooXWy+RRmYYzOc3tUIKzeFdh
 ZIDO+oDcLnZqRjgKMrHiamaJGXdA6vSFLen6WjMIu2G8N4h5m+lGG833vkcjuF
X-Received: by 2002:a5d:64e9:0:b0:435:afa5:c27 with SMTP id
 ffacd0b85a97d-435f3aafcbfmr20942698f8f.52.1770074005457; 
 Mon, 02 Feb 2026 15:13:25 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e10e48a6sm45799474f8f.8.2026.02.02.15.13.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Feb 2026 15:13:24 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v12 18/19] net/pcap: add snapshot length devarg
Date: Mon,  2 Feb 2026 15:09:21 -0800
Message-ID: <20260202231245.216433-19-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260202231245.216433-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260202231245.216433-1-stephen@networkplumber.org>
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
 doc/guides/nics/pcap_ring.rst          |  13 ++
 doc/guides/rel_notes/release_26_03.rst |   1 +
 drivers/net/pcap/pcap_ethdev.c         | 202 +++++++++++++++----------
 3 files changed, 132 insertions(+), 84 deletions(-)

diff --git a/doc/guides/nics/pcap_ring.rst b/doc/guides/nics/pcap_ring.rst
index 5b9ca71b18..7993fc5e09 100644
--- a/doc/guides/nics/pcap_ring.rst
+++ b/doc/guides/nics/pcap_ring.rst
@@ -132,6 +132,19 @@ Runtime Config Options
 
 In this case, one dummy rx queue is created for each tx queue argument passed
 
+- Set the snapshot length for packet capture
+
+ The snapshot length controls the maximum number of bytes captured per packet.
+ This affects both interface capture and pcap file output.  The default value is
+ 65535 bytes, which captures complete packets up to the maximum Ethernet jumbo frame size.
+ Reducing this value can improve performance when only packet headers are needed.
+ This can be done with a ``devarg`` ``snaplen``, for example::
+
+   --vdev 'net_pcap0,iface=eth0,snaplen=1518'
+   --vdev 'net_pcap0,rx_pcap=in.pcap,tx_pcap=out.pcap,snaplen=9000'
+
+ The snapshot length also determines the reported ``max_rx_pktlen`` and ``max_mtu`` in device info.
+
 Examples of Usage
 ^^^^^^^^^^^^^^^^^
 
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 8590dc861b..069bbed807 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -65,6 +65,7 @@ New Features
   * Added support for reporting link state and speed in ``iface`` mode.
   * Receive timestamp offload is only done if offload flag set.
   * Receive timestamps support nanosecond precision.
+  * Added ``snaplen`` devarg to configure packet capture snapshot length.
 
 
 Removed Items
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 35d4f28d50..9cb8bee2cf 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -32,8 +32,6 @@
 
 #include "pcap_osdep.h"
 
-#define RTE_ETH_PCAP_SNAPSHOT_LEN 65535
-
 #define ETH_PCAP_RX_PCAP_ARG  "rx_pcap"
 #define ETH_PCAP_TX_PCAP_ARG  "tx_pcap"
 #define ETH_PCAP_RX_IFACE_ARG "rx_iface"
@@ -42,6 +40,9 @@
 #define ETH_PCAP_IFACE_ARG    "iface"
 #define ETH_PCAP_PHY_MAC_ARG  "phy_mac"
 #define ETH_PCAP_INFINITE_RX_ARG  "infinite_rx"
+#define ETH_PCAP_SNAPSHOT_LEN_ARG "snaplen"
+
+#define ETH_PCAP_SNAPSHOT_LEN_DEFAULT 65535
 
 #define ETH_PCAP_ARG_MAXLEN	64
 
@@ -102,6 +103,7 @@ struct pmd_internals {
 	char devargs[ETH_PCAP_ARG_MAXLEN];
 	struct rte_ether_addr eth_addr;
 	int if_index;
+	uint32_t snapshot_len;
 	bool single_iface;
 	bool phy_mac;
 	bool infinite_rx;
@@ -129,6 +131,7 @@ struct pmd_devargs {
 struct pmd_devargs_all {
 	struct pmd_devargs rx_queues;
 	struct pmd_devargs tx_queues;
+	uint32_t snapshot_len;
 	bool single_iface;
 	bool is_tx_pcap;
 	bool is_tx_iface;
@@ -146,11 +149,16 @@ static const char *valid_arguments[] = {
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
@@ -415,20 +423,19 @@ calculate_timestamp(struct timeval *ts)
 static uint16_t
 eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
-	unsigned int i;
-	struct pmd_process_private *pp;
 	struct pcap_tx_queue *dumper_q = queue;
+	struct rte_eth_dev *dev = &rte_eth_devices[dumper_q->port_id];
+	struct pmd_internals *internals = dev->data->dev_private;
+	struct pmd_process_private *pp = dev->process_private;
+	pcap_dumper_t *dumper = pp->tx_dumper[dumper_q->queue_id];
+	unsigned char *temp_data = dumper_q->bounce_buf;
+	uint32_t snaplen = internals->snapshot_len;
 	uint16_t num_tx = 0;
 	uint32_t tx_bytes = 0;
 	struct pcap_pkthdr header;
-	pcap_dumper_t *dumper;
-	unsigned char *temp_data;
-
-	pp = rte_eth_devices[dumper_q->port_id].process_private;
-	dumper = pp->tx_dumper[dumper_q->queue_id];
-	temp_data = dumper_q->bounce_buf;
+	unsigned int i;
 
-	if (dumper == NULL || nb_pkts == 0)
+	if (unlikely(dumper == NULL))
 		return 0;
 
 	/* all packets in burst have same timestamp */
@@ -446,7 +453,8 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 				continue;
 		}
 
-		len = caplen = rte_pktmbuf_pkt_len(mbuf);
+		len = rte_pktmbuf_pkt_len(mbuf);
+		caplen = RTE_MIN(len, snaplen);
 		header.len = len;
 		header.caplen = caplen;
 
@@ -499,25 +507,22 @@ eth_tx_drop(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 static uint16_t
 eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
-	unsigned int i;
-	struct pmd_process_private *pp;
 	struct pcap_tx_queue *tx_queue = queue;
+	struct rte_eth_dev *dev = &rte_eth_devices[tx_queue->port_id];
+	struct pmd_internals *internals = dev->data->dev_private;
+	struct pmd_process_private *pp = dev->process_private;
+	pcap_t *pcap = pp->tx_pcap[tx_queue->queue_id];
+	unsigned char *temp_data = tx_queue->bounce_buf;
+	uint32_t snaplen = internals->snapshot_len;
 	uint16_t num_tx = 0;
 	uint32_t tx_bytes = 0;
-	pcap_t *pcap;
-	unsigned char *temp_data;
-
-	pp = rte_eth_devices[tx_queue->port_id].process_private;
-	pcap = pp->tx_pcap[tx_queue->queue_id];
-	temp_data = tx_queue->bounce_buf;
+	unsigned int i;
 
-	if (unlikely(nb_pkts == 0 || pcap == NULL))
+	if (unlikely(pcap == NULL))
 		return 0;
 
 	for (i = 0; i < nb_pkts; i++) {
 		struct rte_mbuf *mbuf = bufs[i];
-		uint32_t len = rte_pktmbuf_pkt_len(mbuf);
-		const uint8_t *data;
 
 		if (mbuf->ol_flags & RTE_MBUF_F_TX_VLAN) {
 			/* if vlan insert fails treat it as error */
@@ -525,22 +530,26 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 				continue;
 		}
 
-		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) && len > RTE_ETH_PCAP_SNAPSHOT_LEN)) {
+		uint32_t len = rte_pktmbuf_pkt_len(mbuf);
+		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) && len > snaplen)) {
 			static int warned;
 
 			if (!warned) {
 				PMD_LOG(ERR,
 					"Multi segment PCAP packet. Size (%u) > max size (%u).",
-					len, RTE_ETH_PCAP_SNAPSHOT_LEN);
+					len, snaplen);
 				warned = 1;
 			}
 			continue;
 		}
 
-		data = rte_pktmbuf_read(mbuf, 0, len, temp_data);
+		const uint8_t *data = rte_pktmbuf_read(mbuf, 0, len, temp_data);
 		if (likely(data != NULL && pcap_sendpacket(pcap, data, len) == 0)) {
 			num_tx++;
 			tx_bytes += len;
+		} else if (data != NULL) {
+			PMD_LOG(DEBUG, "pcap_sendpacket failed: %s",
+				pcap_geterr(pcap));
 		}
 	}
 
@@ -557,7 +566,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
  * pcap_open_live wrapper function
  */
 static inline int
-open_iface_live(const char *iface, pcap_t **pcap)
+open_iface_live(const char *iface, pcap_t **pcap, uint32_t snaplen)
 {
 	char errbuf[PCAP_ERRBUF_SIZE];
 	pcap_t *pc;
@@ -586,7 +595,7 @@ open_iface_live(const char *iface, pcap_t **pcap)
 		PMD_LOG(WARNING, "%s: Could not set to promiscuous: %s",
 			iface, pcap_statustostr(status));
 
-	status = pcap_set_snaplen(pc, RTE_ETH_PCAP_SNAPSHOT_LEN);
+	status = pcap_set_snaplen(pc, snaplen);
 	if (status != 0)
 		PMD_LOG(WARNING, "%s: Could not set snapshot length: %s",
 			iface, pcap_statustostr(status));
@@ -600,6 +609,9 @@ open_iface_live(const char *iface, pcap_t **pcap)
 		else
 			PMD_LOG(ERR, "%s: %s (%s)", iface, pcap_statustostr(status), cp);
 		goto error;
+	} else if (status > 0) {
+		/* Warning condition - log but continue */
+		PMD_LOG(WARNING, "%s: %s", iface, pcap_statustostr(status));
 	}
 
 	/*
@@ -628,9 +640,9 @@ open_iface_live(const char *iface, pcap_t **pcap)
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
@@ -639,7 +651,8 @@ open_single_iface(const char *iface, pcap_t **pcap)
 }
 
 static int
-open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
+open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper,
+		    uint32_t snaplen)
 {
 	pcap_t *tx_pcap;
 
@@ -649,7 +662,7 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 	 * pcap holder.
 	 */
 	tx_pcap = pcap_open_dead_with_tstamp_precision(DLT_EN10MB,
-			RTE_ETH_PCAP_SNAPSHOT_LEN, PCAP_TSTAMP_PRECISION_NANO);
+			snaplen, PCAP_TSTAMP_PRECISION_NANO);
 	if (tx_pcap == NULL) {
 		PMD_LOG(ERR, "Couldn't create dead pcap");
 		return -1;
@@ -658,9 +671,9 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 	/* The dumper is created using the previous pcap_t reference */
 	*dumper = pcap_dump_open(tx_pcap, pcap_filename);
 	if (*dumper == NULL) {
+		PMD_LOG(ERR, "Couldn't open %s for writing: %s",
+			pcap_filename, pcap_geterr(tx_pcap));
 		pcap_close(tx_pcap);
-		PMD_LOG(ERR, "Couldn't open %s for writing.",
-			pcap_filename);
 		return -1;
 	}
 
@@ -710,6 +723,7 @@ eth_dev_start(struct rte_eth_dev *dev)
 	struct pmd_process_private *pp = dev->process_private;
 	struct pcap_tx_queue *tx;
 	struct pcap_rx_queue *rx;
+	uint32_t snaplen = internals->snapshot_len;
 
 	/* Special iface case. Single pcap is open and shared between tx/rx. */
 	if (internals->single_iface) {
@@ -718,7 +732,7 @@ eth_dev_start(struct rte_eth_dev *dev)
 
 		if (!pp->tx_pcap[0] &&
 			strcmp(tx->type, ETH_PCAP_IFACE_ARG) == 0) {
-			if (open_single_iface(tx->name, &pp->tx_pcap[0]) < 0)
+			if (open_single_iface(tx->name, &pp->tx_pcap[0], snaplen) < 0)
 				return -1;
 			pp->rx_pcap[0] = pp->tx_pcap[0];
 		}
@@ -730,14 +744,11 @@ eth_dev_start(struct rte_eth_dev *dev)
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
@@ -752,9 +763,14 @@ eth_dev_start(struct rte_eth_dev *dev)
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
 
@@ -845,11 +861,11 @@ eth_dev_info(struct rte_eth_dev *dev,
 
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
@@ -1162,7 +1178,7 @@ eth_tx_queue_setup(struct rte_eth_dev *dev,
 
 	pcap_q->port_id = dev->data->port_id;
 	pcap_q->queue_id = tx_queue_id;
-	pcap_q->bounce_buf = rte_malloc_socket(NULL, RTE_ETH_PCAP_SNAPSHOT_LEN,
+	pcap_q->bounce_buf = rte_malloc_socket(NULL, internals->snapshot_len,
 					       RTE_CACHE_LINE_SIZE, socket_id);
 	if (pcap_q->bounce_buf == NULL)
 		return -ENOMEM;
@@ -1304,41 +1320,32 @@ open_rx_pcap(const char *key, const char *value, void *extra_args)
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
 
-	if (open_single_tx_pcap(pcap_filename, &dumper) < 0)
+	if (add_queue(dumpers, pcap_filename, key, NULL, NULL) < 0)
 		return -1;
 
-	if (add_queue(dumpers, pcap_filename, key, NULL, dumper) < 0) {
-		pcap_dump_close(dumper);
-		return -1;
-	}
-
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
 
@@ -1360,42 +1367,30 @@ set_iface_direction(const char *iface, pcap_t *pcap,
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
@@ -1435,6 +1430,30 @@ process_bool_flag(const char *key, const char *value, void *extra_args)
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
+	if (errno != 0 || *endptr != '\0' ||
+	    val < RTE_ETHER_HDR_LEN || val > UINT32_MAX) {
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
@@ -1599,6 +1618,8 @@ eth_from_pcaps(struct rte_vdev_device *vdev,
 	}
 
 	internals->infinite_rx = infinite_rx;
+	internals->snapshot_len = devargs_all->snapshot_len;
+
 	/* Assign rx ops. */
 	if (infinite_rx)
 		eth_dev->rx_pkt_burst = eth_pcap_rx_infinite;
@@ -1659,6 +1680,7 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 	int ret = 0;
 
 	struct pmd_devargs_all devargs_all = {
+		.snapshot_len = ETH_PCAP_SNAPSHOT_LEN_DEFAULT,
 		.single_iface = 0,
 		.is_tx_pcap = 0,
 		.is_tx_iface = 0,
@@ -1700,6 +1722,17 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
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
@@ -1906,4 +1939,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_pcap,
 	ETH_PCAP_TX_IFACE_ARG "=<ifc> "
 	ETH_PCAP_IFACE_ARG "=<ifc> "
 	ETH_PCAP_PHY_MAC_ARG "=<0|1> "
-	ETH_PCAP_INFINITE_RX_ARG "=<0|1>");
+	ETH_PCAP_INFINITE_RX_ARG "=<0|1> "
+	ETH_PCAP_SNAPSHOT_LEN_ARG "=<int>");
-- 
2.51.0

