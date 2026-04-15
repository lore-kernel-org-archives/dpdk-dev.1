Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C750F43830
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 14:50:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FDE940DD6;
	Wed, 15 Apr 2026 16:48:34 +0200 (CEST)
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com
 [209.85.167.180])
 by mails.dpdk.org (Postfix) with ESMTP id 5AB7940A89
 for <dev@dpdk.org>; Wed, 15 Apr 2026 16:48:33 +0200 (CEST)
Received: by mail-oi1-f180.google.com with SMTP id
 5614622812f47-4648447e29bso1996890b6e.0
 for <dev@dpdk.org>; Wed, 15 Apr 2026 07:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776264512;
 x=1776869312; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IycBN11Mvm5sExXv8Zs2hHi5nNk+OPmYanl6ZZ8SENU=;
 b=H6QKl7fP05kN1J9HyMtRaDZsL6E59ZKOENrhR+5aW6aIlbFkQ2XcUhiidmO/588Afk
 hoDTllHYxNMuItFrjK1RPW2J//psZevy7wSpRiuzJLbMUDggjajT4vztaTZb9IMJxHem
 s3f67Ow9KLSQ18aMZ/wNh0o7rzTmHKJf1S5UgdXGoepDSgSvMpOlQhhRtpGoL2XpecIO
 20KT9Fk5iJbJnw9whcwyMQt1OUbbdn99c2A5Jtcl4Q6t2xoJ7eKD1UeVt4I5XLVw1ADf
 3KOcpFIZHPw6/AMEFPf/Yyo+ckzSC849IMRXLGftekRWnd9ysazh+eIwqL8P85hP176f
 g8OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776264512; x=1776869312;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=IycBN11Mvm5sExXv8Zs2hHi5nNk+OPmYanl6ZZ8SENU=;
 b=cHDEezGbDbtA14hKk/i43jho4PhX4dAqza20aCEQBrg92qS4kMOofYxbYj41QmfjYx
 MJb/m3Qx2ItSSvy9MJ3U9uX6Xz6ohhC4j0YZW1QXa8d1DB4VuXY09T/woFMpWXjwckcy
 SdNa4a1lSdBpAxRvyt03GmT9N/GhlAA1zzER5y4KAFbdhhEIHw5OfUZ4eDAhaQreqi0y
 roXN1fOZdEO/hd8lUAfpAUdU7EC7rJ3BanzQ2h7o/qaRzfU99GNkTTn/U9SwJht5exxc
 l3X1Ph9RIBTPhJxTh8SvHGBPI4V2cigsa1FII+3za90k1X+VloA/gmUWgBGwKnSNCZRc
 D61w==
X-Gm-Message-State: AOJu0YwRhdfTEyWUGhzd750NCG2BfriS6G01S2bSc3Z/FzM0VvI2h7x7
 8r87Gfr3o0JhOwKa5mOp/rhiJln9jpWlvNKYudGvPs0YoTEhYLy0J/3svsZ7V8bz6H0+JZjrVTo
 rkDnM
X-Gm-Gg: AeBDiesiLuhYDJhijO3k8HB1VXTo6MiwuTeHouWqhDz+WdYxyFOmOqZ4TMDlr2vJK9k
 RjOV7eIFU1iucpUo7ZRAKYlzKnUXx/CsvTAqYklHxBy0K5/ozPVQnEGVjC/6Zpq+lg4HH00O0AK
 rslZ7n+mmCitYmce5uu+yDGSZOQgheHNcCoI1ifxZNY4pzvWbCzjJZkw0K56el7uoGlvTQtYNi3
 v1iVLK3gLdQDedE1uEMnIErAPZ2fY8HdiIlS7vncjXRTgbQoJOTwQEiewgDT3vhNO+/SZ8oWPz8
 JIbj410bO8SAKZv6dg9gJoOI8ifWlyiUyazt43NSrJBPScUmr0V2jnxbq45VDZqepsxg4QSTj3B
 LfSGjBdWLtJiU+omJzRiX4Mzk5OCuzahc29vp63TRHBXEExxlZEnAl10z/2GepTCUQaXgsh5XGw
 dQTjYvvfOmUrJeQDGbJO/zfyUS0W9x4j0/LHRK/USv2zs=
X-Received: by 2002:a05:6808:10ca:b0:466:eeac:bdda with SMTP id
 5614622812f47-4789c6450cfmr10456675b6e.5.1776264512446; 
 Wed, 15 Apr 2026 07:48:32 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4797a53b1fesm945798b6e.16.2026.04.15.07.48.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 07:48:32 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v23 20/24] net/pcap: add snapshot length devarg
Date: Wed, 15 Apr 2026 07:46:09 -0700
Message-ID: <20260415144717.226161-21-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260415144717.226161-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260415144717.226161-1-stephen@networkplumber.org>
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

The snaplen argument is parsed before interface and file arguments
so that its value is available when pcap handles are opened during
device creation.

Example usage:
  --vdev 'net_pcap0,snaplen=1518,iface=eth0'
  --vdev 'net_pcap0,snaplen=9000,rx_pcap=in.pcap,tx_pcap=out.pcap'

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 doc/guides/nics/pcap.rst               |  17 ++
 doc/guides/rel_notes/release_26_07.rst |   1 +
 drivers/net/pcap/pcap_ethdev.c         | 206 ++++++++++++++++---------
 3 files changed, 154 insertions(+), 70 deletions(-)

diff --git a/doc/guides/nics/pcap.rst b/doc/guides/nics/pcap.rst
index 65209c1db4..b66202e125 100644
--- a/doc/guides/nics/pcap.rst
+++ b/doc/guides/nics/pcap.rst
@@ -15,6 +15,23 @@ For more information about the pcap library, see the
    The pcap-based PMD requires the libpcap development files to be installed.
    This applies to all supported operating systems: Linux, FreeBSD, and Windows.
 
+* Set the snapshot length for packet capture
+
+  The snapshot length controls the maximum number of bytes captured per packet.
+  This affects both interface capture and pcap file output.  The default value is
+  65535 bytes, which captures complete packets up to the maximum Ethernet jumbo
+  frame size.  Reducing this value can improve performance when only packet headers
+  are needed.
+
+  The ``snaplen`` argument is used when opening capture handles, so it should
+  be specified before the interface or file arguments.  Example::
+
+     --vdev 'net_pcap0,snaplen=1518,iface=eth0'
+     --vdev 'net_pcap0,snaplen=9000,rx_pcap=in.pcap,tx_pcap=out.pcap'
+
+  The snapshot length also determines the reported ``max_rx_pktlen``
+  and ``max_mtu`` in device info.
+
 
 Using the Driver from the EAL Command Line
 ------------------------------------------
diff --git a/doc/guides/rel_notes/release_26_07.rst b/doc/guides/rel_notes/release_26_07.rst
index 777a9fe680..bbce14e8a4 100644
--- a/doc/guides/rel_notes/release_26_07.rst
+++ b/doc/guides/rel_notes/release_26_07.rst
@@ -68,6 +68,7 @@ New Features
   * Added support for VLAN insertion and stripping.
   * Added support for reporting link state in ``iface`` mode.
   * Receive timestamps support nanosecond precision.
+  * Added ``snaplen`` devarg to configure packet capture snapshot length.
 
 
 
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index ea0293bf39..602b898a72 100644
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
@@ -119,15 +126,18 @@ struct pmd_devargs {
 	bool phy_mac;
 	struct devargs_queue {
 		pcap_dumper_t *dumper;
+		/* pcap and name/type fields... */
 		pcap_t *pcap;
 		const char *name;
 		const char *type;
 	} queue[RTE_PMD_PCAP_MAX_QUEUES];
+	uint32_t snapshot_len;
 };
 
 struct pmd_devargs_all {
 	struct pmd_devargs rx_queues;
 	struct pmd_devargs tx_queues;
+	uint32_t snapshot_len;
 	bool single_iface;
 	bool is_tx_pcap;
 	bool is_tx_iface;
@@ -145,6 +155,7 @@ static const char *valid_arguments[] = {
 	ETH_PCAP_IFACE_ARG,
 	ETH_PCAP_PHY_MAC_ARG,
 	ETH_PCAP_INFINITE_RX_ARG,
+	ETH_PCAP_SNAPSHOT_LEN_ARG,
 	NULL
 };
 
@@ -453,20 +464,19 @@ pcap_tx_vlan_insert(struct rte_mbuf **m)
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
@@ -488,7 +498,7 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		}
 
 		len = rte_pktmbuf_pkt_len(mbuf);
-		caplen = RTE_MIN(len, RTE_ETH_PCAP_SNAPSHOT_LEN);
+		caplen = RTE_MIN(len, snaplen);
 
 		header.len = len;
 		header.caplen = caplen;
@@ -554,19 +564,18 @@ eth_tx_drop(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 static uint16_t
 eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
-	unsigned int i;
-	struct pmd_process_private *pp;
 	struct pcap_tx_queue *tx_queue = queue;
+	struct rte_eth_dev *dev = &rte_eth_devices[tx_queue->port_id];
+	struct pmd_process_private *pp = dev->process_private;
+	struct pmd_internals *internals = dev->data->dev_private;
+	uint32_t snaplen = internals->snapshot_len;
+	pcap_t *pcap = pp->tx_pcap[tx_queue->queue_id];
+	unsigned char *temp_data = tx_queue->bounce_buf;
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
@@ -585,13 +594,15 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 		len = rte_pktmbuf_pkt_len(mbuf);
 
-		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) &&
-				len > RTE_ETH_PCAP_SNAPSHOT_LEN)) {
-			PMD_TX_LOG(ERR,
-				"Dropping multi segment PCAP packet. Size (%u) > max size (%u).",
-				len, RTE_ETH_PCAP_SNAPSHOT_LEN);
-			tx_queue->tx_stat.err_pkts++;
+		/*
+		 * multi-segment transmit that has to go through bounce buffer.
+		 * Make sure it fits; don't want to truncate the packet.
+		 */
+		if (unlikely(!rte_pktmbuf_is_contiguous(mbuf) && len > snaplen)) {
+			PMD_TX_LOG(ERR, "Multi segment len (%u) > snaplen (%u)",
+				   len, snaplen);
 			rte_pktmbuf_free(mbuf);
+			tx_queue->tx_stat.err_pkts++;
 			continue;
 		}
 
@@ -618,7 +629,7 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
  * pcap_open_live wrapper function
  */
 static inline int
-open_iface_live(const char *iface, pcap_t **pcap)
+open_iface_live(const char *iface, pcap_t **pcap, uint32_t snaplen)
 {
 	char errbuf[PCAP_ERRBUF_SIZE];
 	pcap_t *pc;
@@ -647,7 +658,7 @@ open_iface_live(const char *iface, pcap_t **pcap)
 		PMD_LOG(WARNING, "%s: Could not set to promiscuous: %s",
 			iface, pcap_statustostr(status));
 
-	status = pcap_set_snaplen(pc, RTE_ETH_PCAP_SNAPSHOT_LEN);
+	status = pcap_set_snaplen(pc, snaplen);
 	if (status != 0)
 		PMD_LOG(WARNING, "%s: Could not set snapshot length: %s",
 			iface, pcap_statustostr(status));
@@ -661,6 +672,9 @@ open_iface_live(const char *iface, pcap_t **pcap)
 		else
 			PMD_LOG(ERR, "%s: %s (%s)", iface, pcap_statustostr(status), cp);
 		goto error;
+	} else if (status > 0) {
+		/* Warning condition - log but continue */
+		PMD_LOG(WARNING, "%s: %s", iface, pcap_statustostr(status));
 	}
 
 	/*
@@ -689,9 +703,9 @@ open_iface_live(const char *iface, pcap_t **pcap)
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
@@ -700,7 +714,8 @@ open_single_iface(const char *iface, pcap_t **pcap)
 }
 
 static int
-open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
+open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper,
+		    uint32_t snaplen)
 {
 	pcap_t *tx_pcap;
 
@@ -710,7 +725,7 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 	 * pcap holder.
 	 */
 	tx_pcap = pcap_open_dead_with_tstamp_precision(DLT_EN10MB,
-			RTE_ETH_PCAP_SNAPSHOT_LEN, PCAP_TSTAMP_PRECISION_NANO);
+			snaplen, PCAP_TSTAMP_PRECISION_NANO);
 	if (tx_pcap == NULL) {
 		PMD_LOG(ERR, "Couldn't create dead pcap");
 		return -1;
@@ -719,9 +734,9 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
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
 
@@ -763,6 +778,21 @@ count_packets_in_pcap(pcap_t **pcap, struct pcap_rx_queue *pcap_q)
 	return pcap_pkt_count;
 }
 
+static int
+set_iface_direction(const char *iface, pcap_t *pcap,
+		pcap_direction_t direction)
+{
+	const char *direction_str = (direction == PCAP_D_IN) ? "IN" : "OUT";
+	if (pcap_setdirection(pcap, direction) < 0) {
+		PMD_LOG(ERR, "Setting %s pcap direction %s failed - %s",
+				iface, direction_str, pcap_geterr(pcap));
+		return -1;
+	}
+	PMD_LOG(INFO, "Setting %s pcap direction %s",
+			iface, direction_str);
+	return 0;
+}
+
 static int
 eth_dev_start(struct rte_eth_dev *dev)
 {
@@ -771,15 +801,15 @@ eth_dev_start(struct rte_eth_dev *dev)
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
@@ -791,14 +821,11 @@ eth_dev_start(struct rte_eth_dev *dev)
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
@@ -813,9 +840,14 @@ eth_dev_start(struct rte_eth_dev *dev)
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
 
@@ -916,11 +948,11 @@ eth_dev_info(struct rte_eth_dev *dev,
 
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
@@ -1178,7 +1210,7 @@ eth_tx_queue_setup(struct rte_eth_dev *dev,
 
 	pcap_q->port_id = dev->data->port_id;
 	pcap_q->queue_id = tx_queue_id;
-	pcap_q->bounce_buf = rte_malloc_socket(NULL, RTE_ETH_PCAP_SNAPSHOT_LEN,
+	pcap_q->bounce_buf = rte_malloc_socket(NULL, internals->snapshot_len,
 					       RTE_CACHE_LINE_SIZE, socket_id);
 	if (pcap_q->bounce_buf == NULL)
 		return -ENOMEM;
@@ -1330,7 +1362,8 @@ open_tx_pcap(const char *key, const char *value, void *extra_args)
 	struct pmd_devargs *dumpers = extra_args;
 	pcap_dumper_t *dumper;
 
-	if (open_single_tx_pcap(pcap_filename, &dumper) < 0)
+	if (open_single_tx_pcap(pcap_filename, &dumper,
+				dumpers->snapshot_len) < 0)
 		return -1;
 
 	if (add_queue(dumpers, pcap_filename, key, NULL, dumper) < 0) {
@@ -1351,7 +1384,7 @@ open_rx_tx_iface(const char *key, const char *value, void *extra_args)
 	struct pmd_devargs *tx = extra_args;
 	pcap_t *pcap = NULL;
 
-	if (open_single_iface(iface, &pcap) < 0)
+	if (open_single_iface(iface, &pcap, tx->snapshot_len) < 0)
 		return -1;
 
 	tx->queue[0].pcap = pcap;
@@ -1361,21 +1394,6 @@ open_rx_tx_iface(const char *key, const char *value, void *extra_args)
 	return 0;
 }
 
-static inline int
-set_iface_direction(const char *iface, pcap_t *pcap,
-		pcap_direction_t direction)
-{
-	const char *direction_str = (direction == PCAP_D_IN) ? "IN" : "OUT";
-	if (pcap_setdirection(pcap, direction) < 0) {
-		PMD_LOG(ERR, "Setting %s pcap direction %s failed - %s",
-				iface, direction_str, pcap_geterr(pcap));
-		return -1;
-	}
-	PMD_LOG(INFO, "Setting %s pcap direction %s",
-			iface, direction_str);
-	return 0;
-}
-
 static inline int
 open_iface(const char *key, const char *value, void *extra_args)
 {
@@ -1383,7 +1401,7 @@ open_iface(const char *key, const char *value, void *extra_args)
 	struct pmd_devargs *pmd = extra_args;
 	pcap_t *pcap = NULL;
 
-	if (open_single_iface(iface, &pcap) < 0)
+	if (open_single_iface(iface, &pcap, pmd->snapshot_len) < 0)
 		return -1;
 	if (add_queue(pmd, iface, key, pcap, NULL) < 0) {
 		pcap_close(pcap);
@@ -1451,6 +1469,31 @@ process_bool_flag(const char *key, const char *value, void *extra_args)
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
@@ -1614,6 +1657,8 @@ eth_from_pcaps(struct rte_vdev_device *vdev,
 	}
 
 	internals->infinite_rx = infinite_rx;
+	internals->snapshot_len = devargs_all->snapshot_len;
+
 	/* Assign rx ops. */
 	if (infinite_rx)
 		eth_dev->rx_pkt_burst = eth_pcap_rx_infinite;
@@ -1674,6 +1719,7 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 	int ret = 0;
 
 	struct pmd_devargs_all devargs_all = {
+		.snapshot_len = ETH_PCAP_SNAPSHOT_LEN_DEFAULT,
 		.single_iface = 0,
 		.is_tx_pcap = 0,
 		.is_tx_iface = 0,
@@ -1713,6 +1759,25 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 			return -1;
 	}
 
+	/*
+	 * Process optional snapshot length argument first, so the value
+	 * is available when opening pcap handles for files and interfaces.
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
+	 * Propagate snapshot length to per-queue devargs so that
+	 * the open callbacks can access it.
+	 */
+	devargs_all.rx_queues.snapshot_len = devargs_all.snapshot_len;
+	devargs_all.tx_queues.snapshot_len = devargs_all.snapshot_len;
+
 	/*
 	 * If iface argument is passed we open the NICs and use them for
 	 * reading / writing
@@ -1918,4 +1983,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_pcap,
 	ETH_PCAP_TX_IFACE_ARG "=<ifc> "
 	ETH_PCAP_IFACE_ARG "=<ifc> "
 	ETH_PCAP_PHY_MAC_ARG "=<0|1> "
-	ETH_PCAP_INFINITE_RX_ARG "=<0|1>");
+	ETH_PCAP_INFINITE_RX_ARG "=<0|1> "
+	ETH_PCAP_SNAPSHOT_LEN_ARG "=<int>");
-- 
2.53.0

