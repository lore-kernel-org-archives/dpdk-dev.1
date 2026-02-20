Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E32CC54EFC
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Feb 2026 05:50:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B477440DC9;
	Fri, 20 Feb 2026 06:49:05 +0100 (CET)
Received: from mail-qk1-f172.google.com (mail-qk1-f172.google.com
 [209.85.222.172])
 by mails.dpdk.org (Postfix) with ESMTP id 3DED140A8A
 for <dev@dpdk.org>; Fri, 20 Feb 2026 06:49:00 +0100 (CET)
Received: by mail-qk1-f172.google.com with SMTP id
 af79cd13be357-8cb38e6d164so189416085a.3
 for <dev@dpdk.org>; Thu, 19 Feb 2026 21:49:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1771566539;
 x=1772171339; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EQ0os5EAP7HN2kjSnDZ78AA9imG/hYOUHi3K+MIC/54=;
 b=knFrrjXLGm12kDktdB0+/QOc7w0OBo1KvXZlo3tv8/O2b5qsAJpQNm7vkdj0gjCrNo
 V21hPA+aiTPX3bKy2j5l7q+5lGox1v5rhLvErpkVhIC/b6wzLsNitLFcDpHJtIJiCqO3
 PYUeehuFzF7fpt4Ev/gGOe7rfnp2vl6EPcRNtYlwpANmkEMHIi5pAgek1dQ5Qz+gbD7d
 A26wezNEgvzC4U2+lwamCwg5avkBCLUpe6313/Z9LtBDIAAyQ8gB/WjrY6B3A/EgNFX5
 hxWDD/sYgFyMRpVC6VL8hPoOT5blWukhKH+EbvRmxPE3ql3zkrEGY41gvC28KDZIHA2C
 PwJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771566539; x=1772171339;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EQ0os5EAP7HN2kjSnDZ78AA9imG/hYOUHi3K+MIC/54=;
 b=lIxDxcGzpq2UZMUvMRxsRsMLdQL2WBOnc4tB9BQtRSSh8QwDlh4vLXPmtmWv99aQ1a
 ZQ7iMTcYWFsVZOXUXfdf8bQFbMu+40cLER/PyDgLNsYLCb3GLXY+fYkXREVj4sKmWMiW
 rnLaLtM6OnMCFEqS+eOFTGpQExvbPn0bTNlK/apuX5rhnAlIanCyrIxRK734k/HxlI6h
 K1RRsjQOnjLfkxpLmVClMt8z1XiVYPCzsQS2Y9Ol0wPiZczMM2H+MRYCAfYuCXXShCdW
 Zg4o+ZSU/seOdt0U9STuna8MiRVvDXqcsgrsIWvLRgIGPrcba/IiiAr2GaADSjhSR43m
 uHwg==
X-Gm-Message-State: AOJu0YxhSKOkBBYJXPgxYqMzDvUXVMV/XcFIqndnM9K+YdRTGBWBxG5n
 VG6SN59qs+ZP36XQY0Sp0+X+nJ/NRqYCI0jJfxQHmadHthtbaZrcOSNFwyXUy0wAIhOd6jMNMSx
 rV98p
X-Gm-Gg: AZuq6aKpJGC5jSRuQH0hMsg1m5QhDAsJtK7dHfYGPFKBmxJWHKOB0TS5+AYdtjdZB9Z
 EtFQvLF4OCs1oYnDTnnAJZd7QPi7/hbyQJeqiSNIfojZcTF/Tb1nTpRKKuRxlHBIrgQjo5CphZ1
 5ouD3aev8B/xEjsIaqV8+C6Uxhb14kIjNs9RXHXeKn3B355uhxm5dEE2TM9zHgD/D8RY1bCD0eL
 L6w1sF9XfBS2G+DzCudERo7T1PiFnmPShw+9oSi6EGkBsJgRd3SZsUuGIPsPw54G92yI0SFp8z6
 cuhoJWCmBgwKjpaAm8Ky7LmEeSwt5u2XLXAT/vv4wai5Kr0N8WzAaQau+Y283gqezUN+BIAXGyx
 dFEbauXXxvwt0iQDAN/F6tZRT2ky/ynmzK+k69tDOy1QFIHDN/KKkFaIR6BBvU5dRlonO3Xp7zt
 jKFe7s932hb6RQxmlszODeZ64mNqn4+ifYuqpBN1GCtK3TwEAlIVdf2VaLvgsHKA==
X-Received: by 2002:a05:620a:1928:b0:8c7:b6f:bf4a with SMTP id
 af79cd13be357-8cb4c025ae4mr2513151385a.62.1771566539411; 
 Thu, 19 Feb 2026 21:48:59 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8971cdad6c1sm229078096d6.39.2026.02.19.21.48.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 19 Feb 2026 21:48:59 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v17 20/23] net/pcap: add snapshot length devarg
Date: Thu, 19 Feb 2026 21:45:55 -0800
Message-ID: <20260220054834.1632201-21-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260220054834.1632201-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260220054834.1632201-1-stephen@networkplumber.org>
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
 doc/guides/nics/pcap.rst               |  15 ++
 doc/guides/rel_notes/release_26_03.rst |   1 +
 drivers/net/pcap/pcap_ethdev.c         | 237 ++++++++++++++++---------
 3 files changed, 167 insertions(+), 86 deletions(-)

diff --git a/doc/guides/nics/pcap.rst b/doc/guides/nics/pcap.rst
index 2709c6d017..f241069ebb 100644
--- a/doc/guides/nics/pcap.rst
+++ b/doc/guides/nics/pcap.rst
@@ -162,6 +162,21 @@ Runtime Config Options
 
   In this case, one dummy Rx queue is created for each Tx queue argument passed.
 
+* Set the snapshot length for packet capture
+
+  The snapshot length controls the maximum number of bytes captured per packet.
+  This affects both interface capture and pcap file output.  The default value is
+  65535 bytes, which captures complete packets up to the maximum Ethernet jumbo
+  frame size.  Reducing this value can improve performance when only packet headers
+  are needed.  This can be done with the ``snaplen`` devarg, for example::
+
+     --vdev 'net_pcap0,iface=eth0,snaplen=1518'
+     --vdev 'net_pcap0,rx_pcap=in.pcap,tx_pcap=out.pcap,snaplen=9000'
+
+  The snapshot length also determines the reported ``max_rx_pktlen``
+  and ``max_mtu`` in device info.
+
+
 Examples of Usage
 ~~~~~~~~~~~~~~~~~
 
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 9602e0b907..526e157dd4 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -112,6 +112,7 @@ New Features
   * Added support for reporting link state and speed in ``iface`` mode.
   * Receive timestamp offload is only done if offload flag set.
   * Receive timestamps support nanosecond precision.
+  * Added ``snaplen`` devarg to configure packet capture snapshot length.
 
 
 Removed Items
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 27373ec8e8..1ddd0c36d1 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -13,6 +13,8 @@
 #include <errno.h>
 #include <sys/time.h>
 #include <sys/types.h>
+#include <unistd.h>
+
 #include <pcap.h>
 
 #include <rte_cycles.h>
@@ -31,8 +33,6 @@
 
 #include "pcap_osdep.h"
 
-#define RTE_ETH_PCAP_SNAPSHOT_LEN 65535
-
 #define ETH_PCAP_RX_PCAP_ARG  "rx_pcap"
 #define ETH_PCAP_TX_PCAP_ARG  "tx_pcap"
 #define ETH_PCAP_RX_IFACE_ARG "rx_iface"
@@ -41,6 +41,12 @@
 #define ETH_PCAP_IFACE_ARG    "iface"
 #define ETH_PCAP_PHY_MAC_ARG  "phy_mac"
 #define ETH_PCAP_INFINITE_RX_ARG  "infinite_rx"
+#define ETH_PCAP_SNAPSHOT_LEN_ARG "snaplen"
+
+#define ETH_PCAP_SNAPSHOT_LEN_DEFAULT 65535
+
+/* This is defined in libpcap but not exposed in headers */
+#define ETH_PCAP_MAXIMUM_SNAPLEN      262144
 
 #define ETH_PCAP_ARG_MAXLEN	64
 
@@ -101,6 +107,7 @@ struct pmd_internals {
 	char devargs[ETH_PCAP_ARG_MAXLEN];
 	struct rte_ether_addr eth_addr;
 	int if_index;
+	uint32_t snapshot_len;
 	bool single_iface;
 	bool phy_mac;
 	bool infinite_rx;
@@ -128,6 +135,7 @@ struct pmd_devargs {
 struct pmd_devargs_all {
 	struct pmd_devargs rx_queues;
 	struct pmd_devargs tx_queues;
+	uint32_t snapshot_len;
 	bool single_iface;
 	bool is_tx_pcap;
 	bool is_tx_iface;
@@ -145,11 +153,16 @@ static const char *valid_arguments[] = {
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
@@ -466,20 +479,19 @@ eth_pcap_tx_vlan(struct pcap_tx_queue *tx_queue, struct rte_mbuf **mbuf)
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
@@ -487,14 +499,15 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 	/* writes the nb_pkts packets to the previously opened pcap file dumper */
 	for (i = 0; i < nb_pkts; i++) {
-		uint32_t len, caplen;
 		const uint8_t *data;
 
 		if (eth_pcap_tx_vlan(dumper_q, &bufs[i]) < 0)
 			continue;
 
 		struct rte_mbuf *mbuf = bufs[i];
-		len = caplen = rte_pktmbuf_pkt_len(mbuf);
+		uint32_t len = rte_pktmbuf_pkt_len(mbuf);
+		uint32_t caplen = RTE_MIN(len, snaplen);
+
 		header.len = len;
 		header.caplen = caplen;
 
@@ -562,19 +575,18 @@ eth_tx_drop(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
@@ -585,10 +597,10 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		uint32_t len = rte_pktmbuf_pkt_len(mbuf);
 		const uint8_t *data;
 
-		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) && len > RTE_ETH_PCAP_SNAPSHOT_LEN)) {
+		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) && len > snaplen)) {
 			PMD_TX_LOG(ERR,
 				"Dropping multi segment PCAP packet. Size (%u) > max size (%u).",
-				len, RTE_ETH_PCAP_SNAPSHOT_LEN);
+				len, snaplen);
 			tx_queue->tx_stat.err_pkts++;
 			rte_pktmbuf_free(mbuf);
 			continue;
@@ -625,7 +637,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
  * pcap_open_live wrapper function
  */
 static inline int
-open_iface_live(const char *iface, pcap_t **pcap)
+open_iface_live(const char *iface, pcap_t **pcap, uint32_t snaplen)
 {
 	char errbuf[PCAP_ERRBUF_SIZE];
 	pcap_t *pc;
@@ -642,6 +654,9 @@ open_iface_live(const char *iface, pcap_t **pcap)
 		PMD_LOG(ERR, "%s: Could not set to ns precision: %s",
 			iface, pcap_statustostr(status));
 		goto error;
+	} else if (status > 0) {
+		/* Warning condition - log but continue */
+		PMD_LOG(WARNING, "%s: %s", iface, pcap_statustostr(status));
 	}
 
 	status = pcap_set_immediate_mode(pc, 1);
@@ -654,7 +669,7 @@ open_iface_live(const char *iface, pcap_t **pcap)
 		PMD_LOG(WARNING, "%s: Could not set to promiscuous: %s",
 			iface, pcap_statustostr(status));
 
-	status = pcap_set_snaplen(pc, RTE_ETH_PCAP_SNAPSHOT_LEN);
+	status = pcap_set_snaplen(pc, snaplen);
 	if (status != 0)
 		PMD_LOG(WARNING, "%s: Could not set snapshot length: %s",
 			iface, pcap_statustostr(status));
@@ -668,6 +683,9 @@ open_iface_live(const char *iface, pcap_t **pcap)
 		else
 			PMD_LOG(ERR, "%s: %s (%s)", iface, pcap_statustostr(status), cp);
 		goto error;
+	} else if (status > 0) {
+		/* Warning condition - log but continue */
+		PMD_LOG(WARNING, "%s: %s", iface, pcap_statustostr(status));
 	}
 
 	/*
@@ -696,9 +714,9 @@ open_iface_live(const char *iface, pcap_t **pcap)
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
@@ -707,7 +725,8 @@ open_single_iface(const char *iface, pcap_t **pcap)
 }
 
 static int
-open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
+open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper,
+		    uint32_t snaplen)
 {
 	pcap_t *tx_pcap;
 
@@ -717,7 +736,7 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 	 * pcap holder.
 	 */
 	tx_pcap = pcap_open_dead_with_tstamp_precision(DLT_EN10MB,
-			RTE_ETH_PCAP_SNAPSHOT_LEN, PCAP_TSTAMP_PRECISION_NANO);
+			snaplen, PCAP_TSTAMP_PRECISION_NANO);
 	if (tx_pcap == NULL) {
 		PMD_LOG(ERR, "Couldn't create dead pcap");
 		return -1;
@@ -726,9 +745,9 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
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
 
@@ -778,15 +797,15 @@ eth_dev_start(struct rte_eth_dev *dev)
 	struct pmd_process_private *pp = dev->process_private;
 	struct pcap_tx_queue *tx;
 	struct pcap_rx_queue *rx;
+	uint32_t snaplen = internals->snapshot_len;
 
 	/* Special iface case. Single pcap is open and shared between tx/rx. */
 	if (internals->single_iface) {
 		tx = &internals->tx_queue[0];
 		rx = &internals->rx_queue[0];
 
-		if (!pp->tx_pcap[0] &&
-			strcmp(tx->type, ETH_PCAP_IFACE_ARG) == 0) {
-			if (open_single_iface(tx->name, &pp->tx_pcap[0]) < 0)
+		if (!pp->tx_pcap[0] && strcmp(tx->type, ETH_PCAP_IFACE_ARG) == 0) {
+			if (open_single_iface(tx->name, &pp->tx_pcap[0], snaplen) < 0)
 				return -1;
 			pp->rx_pcap[0] = pp->tx_pcap[0];
 		}
@@ -798,14 +817,11 @@ eth_dev_start(struct rte_eth_dev *dev)
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
@@ -820,9 +836,14 @@ eth_dev_start(struct rte_eth_dev *dev)
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
 
@@ -913,11 +934,11 @@ eth_dev_info(struct rte_eth_dev *dev,
 
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
@@ -1230,7 +1251,7 @@ eth_tx_queue_setup(struct rte_eth_dev *dev,
 
 	pcap_q->port_id = dev->data->port_id;
 	pcap_q->queue_id = tx_queue_id;
-	pcap_q->bounce_buf = rte_malloc_socket(NULL, RTE_ETH_PCAP_SNAPSHOT_LEN,
+	pcap_q->bounce_buf = rte_malloc_socket(NULL, internals->snapshot_len,
 					       RTE_CACHE_LINE_SIZE, socket_id);
 	if (pcap_q->bounce_buf == NULL)
 		return -ENOMEM;
@@ -1360,6 +1381,12 @@ open_rx_pcap(const char *key, const char *value, void *extra_args)
 	struct pmd_devargs *rx = extra_args;
 	pcap_t *pcap = NULL;
 
+	if (access(pcap_filename, R_OK) != 0) {
+		PMD_LOG(ERR, "Cannot read pcap file '%s': %s",
+			pcap_filename, strerror(errno));
+		return -1;
+	}
+
 	if (open_single_rx_pcap(pcap_filename, &pcap) < 0)
 		return -1;
 
@@ -1372,41 +1399,52 @@ open_rx_pcap(const char *key, const char *value, void *extra_args)
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
+	FILE *f;
 
-	if (open_single_tx_pcap(pcap_filename, &dumper) < 0)
+	/* Validate that pcap_filename can be created. */
+	if (strcmp(pcap_filename, "-") == 0) {
+		/* This isn't going to work very well in DPDK - so reject it */
+		PMD_LOG(ERR, "Sending pcap binary data to stdout is not supported");
 		return -1;
+	}
 
-	if (add_queue(dumpers, pcap_filename, key, NULL, dumper) < 0) {
-		pcap_dump_close(dumper);
+	f = fopen(pcap_filename, "wb");
+	if (f == NULL) {
+		PMD_LOG(ERR, "Cannot open '%s' for writing: %s", pcap_filename, strerror(errno));
 		return -1;
 	}
+	fclose(f);
+
+	if (add_queue(dumpers, pcap_filename, key, NULL, NULL) < 0)
+		return -1;
 
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
+	if (osdep_iface_index_get(iface) == 0) {
+		PMD_LOG(ERR, "Interface '%s' not found", iface);
 		return -1;
+	}
 
-	tx->queue[0].pcap = pcap;
+	tx->queue[0].pcap = NULL;
 	tx->queue[0].name = iface;
 	tx->queue[0].type = key;
 
@@ -1428,50 +1466,37 @@ set_iface_direction(const char *iface, pcap_t *pcap,
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
+	if (osdep_iface_index_get(iface) == 0) {
+		PMD_LOG(ERR, "Interface '%s' not found", iface);
 		return -1;
 	}
 
+	if (add_queue(pmd, iface, key, NULL, NULL) < 0)
+		return -1;
+
 	return 0;
 }
 
 /*
- * Opens a NIC for reading packets from it
+ * Store RX interface configuration.
+ * The actual pcap handle is opened and direction set in eth_dev_start().
  */
-static inline int
-open_rx_iface(const char *key, const char *value, void *extra_args)
-{
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
-}
-
 static inline int
 rx_iface_args_process(const char *key, const char *value, void *extra_args)
 {
 	if (strcmp(key, ETH_PCAP_RX_IFACE_ARG) == 0 ||
-			strcmp(key, ETH_PCAP_RX_IFACE_IN_ARG) == 0)
-		return open_rx_iface(key, value, extra_args);
+	    strcmp(key, ETH_PCAP_RX_IFACE_IN_ARG) == 0)
+		return open_iface(key, value, extra_args);
 
 	return 0;
 }
@@ -1503,6 +1528,31 @@ process_bool_flag(const char *key, const char *value, void *extra_args)
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
+	    val < RTE_ETHER_HDR_LEN ||
+	    val > ETH_PCAP_MAXIMUM_SNAPLEN) {
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
@@ -1667,6 +1717,8 @@ eth_from_pcaps(struct rte_vdev_device *vdev,
 	}
 
 	internals->infinite_rx = infinite_rx;
+	internals->snapshot_len = devargs_all->snapshot_len;
+
 	/* Assign rx ops. */
 	if (infinite_rx)
 		eth_dev->rx_pkt_burst = eth_pcap_rx_infinite;
@@ -1727,6 +1779,7 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 	int ret = 0;
 
 	struct pmd_devargs_all devargs_all = {
+		.snapshot_len = ETH_PCAP_SNAPSHOT_LEN_DEFAULT,
 		.single_iface = 0,
 		.is_tx_pcap = 0,
 		.is_tx_iface = 0,
@@ -1774,7 +1827,18 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 	}
 
 	/*
-	 * If iface argument is passed we open the NICs and use them for
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
+	/*
+	 * If iface argument is passed we check that NIC can be used
 	 * reading / writing
 	 */
 	if (rte_kvargs_count(kvlist, ETH_PCAP_IFACE_ARG) == 1) {
@@ -1979,4 +2043,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_pcap,
 	ETH_PCAP_TX_IFACE_ARG "=<ifc> "
 	ETH_PCAP_IFACE_ARG "=<ifc> "
 	ETH_PCAP_PHY_MAC_ARG "=<0|1> "
-	ETH_PCAP_INFINITE_RX_ARG "=<0|1>");
+	ETH_PCAP_INFINITE_RX_ARG "=<0|1> "
+	ETH_PCAP_SNAPSHOT_LEN_ARG "=<int>");
-- 
2.51.0

