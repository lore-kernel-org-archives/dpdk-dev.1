Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF69BCEFCEB
	for <dpdk-dev@archiver.kernel.org>; Tue,  6 Jan 2026 18:33:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7A7440E19;
	Tue,  6 Jan 2026 19:33:25 +0100 (CET)
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42]) by mails.dpdk.org (Postfix) with ESMTP id B274940E19
 for <dev@dpdk.org>; Tue,  6 Jan 2026 19:33:24 +0100 (CET)
Received: by mail-ed1-f42.google.com with SMTP id
 4fb4d7f45d1cf-64b9dfc146fso221226a12.0
 for <dev@dpdk.org>; Tue, 06 Jan 2026 10:33:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1767724404;
 x=1768329204; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EqIrUUlG1Rue6IYfa9p3mURcBPrA0/anWaMmb5s4VSo=;
 b=FUfCDYzpBFcs6Q47tUPLKq3Cupn2bnaUu0SQtfFrOLsiuyYHtX1jnv5pQZSJ8jyIzS
 nFleU/qen4KW3bCOOCAGIz4dSMeT1+R80FCiD/IPZD0XpNoxtr4uurnn8BXee55Lpe1H
 YJ7wxpe7nhZOqsVZJhphNFCEjiWDOVS7cCBRNEOr5KFaNAKKb0zW0F7K5THnY1uEW99/
 Lm1OBlCTh2wTedXSadgBuIsOLtlNVtJkOtZgq/IKEi3yFDuNAnkvLptlJtp5SpndD1Um
 U/HVDDmfDl0TjKenQR6PLb9HuAkLsTeUWKy91dr+a+ad/3AVoM/CB4l8nt+KlNp1/MF2
 9BzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767724404; x=1768329204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EqIrUUlG1Rue6IYfa9p3mURcBPrA0/anWaMmb5s4VSo=;
 b=GHpSuLDs8mDFeubFEVd49VgBvL7CIe4XZ4DoluWrevYD+wgh6Rk74o+KYhVeWiR+85
 Qq9exQ72I51c0NbBIRMFHoPz4NCr53DhX9bTalUvqzwiSXf+a3SQi0YTH5Z4v9NzKOR0
 +tIZbnfCcu4grNtv84C7MP3Een+P4a5WwJPsswZ16/ZxC9M4cuqvOm0P7cwuDo4u2ZF/
 P+0oRFTEuDygHj/Nd4j1gbKcz6jSeqgJJ3cLQTjHcbxfNBQPJkcyfGZTNITatrIaYW8+
 g033Nq/4l4Enb6EJOHZPISdcA7HyRIrYDMc4vAWPZ/iYAB1U5U6n8XhtJPJfOPXuNv9r
 z3pg==
X-Gm-Message-State: AOJu0Yz2YNT/p9U4vt4F8kWXNHXRNYTKWlO33FY3vC57KshK5HpOZ3HI
 xzw85jC/qrg74YvG6d3edQBsKemvTjls7IrjCSpzY6FNa3tUUPXPONBDTLcy3J5yXxWmeD976hJ
 NMx2A1u8=
X-Gm-Gg: AY/fxX7G8Q3+eXWwzW5xnPovHN0MB72KkQNjJ2U6rHIw4Wsk971BQtp5Zf3PY8WEf3b
 EJQIuVqagSZGTrKJGQ1+8BE3djCXElhn31PLrAwW7xNznkr5iwfL9p1/at6yXLofx59SbVsee/7
 KZJ6lxRcgMhB4uavHYxzrYig9p+r675DZmK40/MoQ8ZE+nCMgo/Z4e7Hvkos5F9WzK7EB8J41fQ
 N2nz+FruK+5EONWv3j3XbcNwyYiNUjvXS7wtXU2Obr48M7+zwQ5ZXQcHHvSRhSAuV2sIlBRaKbS
 WAX5NuI8/XbDyv87UjA5z2CdtE+Yelsrj4g3mt9GAPRdXgGEVR7WQkeARUx82gbt7CeZPQ4APap
 VpO65l/SHxxIF9F2iuB4XcFCVWE5r5A2FZ3KSGl9pTfqz6rHsPO4oGZeu3aB0Yu49zGKQ2PEUcj
 wPN2Ugt6qiCLsOG5b60dgn/K1TjkqsqPbl1EfhIsMqs0Fq3n/O4g==
X-Google-Smtp-Source: AGHT+IGSR4dOzkJuq37MDh2wA9ro4FkEORTfnfp21R7SsnwrZOy7rxzRZiM67hizrbw+oQsQxIm3Xg==
X-Received: by 2002:a05:6402:40cf:b0:64d:1ea3:f205 with SMTP id
 4fb4d7f45d1cf-65097b37f6bmr98243a12.3.1767724404133; 
 Tue, 06 Jan 2026 10:33:24 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6507bf6d4acsm2728525a12.30.2026.01.06.10.33.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Jan 2026 10:33:23 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH 05/12] net/pcap: support nanosecond timestamp precision
Date: Tue,  6 Jan 2026 10:26:44 -0800
Message-ID: <20260106182823.192350-6-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260106182823.192350-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
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

Consistently support nanosecond timestamps across all the
variations of pcap PMD receive.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 103 +++++++++++++++++++++++++--------
 1 file changed, 79 insertions(+), 24 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 41c5bc638f..905ca62bd4 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -19,13 +19,12 @@
 #include <rte_mbuf_dyn.h>
 #include <bus_vdev_driver.h>
 #include <rte_os_shim.h>
+#include <rte_time.h>
 
 #include "pcap_osdep.h"
 
 #define RTE_ETH_PCAP_SNAPSHOT_LEN 65535
 #define RTE_ETH_PCAP_SNAPLEN (RTE_ETHER_MAX_JUMBO_FRAME_LEN - RTE_ETHER_CRC_LEN)
-#define RTE_ETH_PCAP_PROMISC 1
-#define RTE_ETH_PCAP_TIMEOUT -1
 
 #define ETH_PCAP_RX_PCAP_ARG  "rx_pcap"
 #define ETH_PCAP_TX_PCAP_ARG  "tx_pcap"
@@ -68,6 +67,7 @@ struct queue_missed_stat {
 struct pcap_rx_queue {
 	uint16_t port_id;
 	uint16_t queue_id;
+	bool timestamp_offloading;
 	struct rte_mempool *mb_pool;
 	struct queue_stat rx_stat;
 	struct queue_missed_stat missed_stat;
@@ -95,6 +95,7 @@ struct pmd_internals {
 	bool single_iface;
 	bool phy_mac;
 	bool infinite_rx;
+	bool timestamp_offloading;
 };
 
 struct pmd_process_private {
@@ -299,7 +300,6 @@ eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		if (ret != 1) {
 			if (ret == PCAP_ERROR)
 				pcap_q->rx_stat.err_pkts++;
-
 			break;
 		}
 
@@ -325,10 +325,20 @@ eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		}
 
 		mbuf->pkt_len = len;
-		uint64_t us = (uint64_t)header->ts.tv_sec * US_PER_S + header->ts.tv_usec;
 
-		*RTE_MBUF_DYNFIELD(mbuf, timestamp_dynfield_offset, rte_mbuf_timestamp_t *) = us;
-		mbuf->ol_flags |= timestamp_rx_dynflag;
+		if (pcap_q->timestamp_offloading) {
+			/*
+			 * Although time stamp in struct pcap_pkthdr is defined as struct timeval,
+			 * it really is a timespec with nanosecond resolution.
+			 */
+			const struct timespec *ts = (struct timespec *)&header->ts;
+
+			*RTE_MBUF_DYNFIELD(mbuf, timestamp_dynfield_offset,
+					   rte_mbuf_timestamp_t *) = rte_timespec_to_ns(ts);
+
+			mbuf->ol_flags |= timestamp_rx_dynflag;
+		}
+
 		mbuf->port = pcap_q->port_id;
 		bufs[num_rx] = mbuf;
 		num_rx++;
@@ -514,22 +524,57 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
  * pcap_open_live wrapper function
  */
 static inline int
-open_iface_live(const char *iface, pcap_t **pcap) {
-	*pcap = pcap_open_live(iface, RTE_ETH_PCAP_SNAPLEN,
-			RTE_ETH_PCAP_PROMISC, RTE_ETH_PCAP_TIMEOUT, errbuf);
+open_iface_live(const char *iface, pcap_t **pcap)
+{
+	pcap_t *pc = pcap_create(iface, errbuf);
+	if (pc == NULL) {
+		PMD_LOG(ERR, "Couldn't create %s: %s", iface, errbuf);
+		goto error;
+	}
 
-	if (*pcap == NULL) {
-		PMD_LOG(ERR, "Couldn't open %s: %s", iface, errbuf);
-		return -1;
+	int status = pcap_set_tstamp_precision(pc, PCAP_TSTAMP_PRECISION_NANO);
+	if (status != 0)
+		PMD_LOG(WARNING, "%s: Could not set to ns precision: %s",
+			iface, pcap_statustostr(status));
+
+	status = pcap_set_immediate_mode(pc, 1);
+	if (status != 0)
+		PMD_LOG(WARNING, "%s: Could not set to immediate mode: %s",
+			iface, pcap_statustostr(status));
+
+	status = pcap_set_promisc(pc, 1);
+	if (status != 0)
+		PMD_LOG(WARNING, "%s: Could not set to promiscious: %s",
+			iface, pcap_statustostr(status));
+
+	status = pcap_set_snaplen(pc, RTE_ETH_PCAP_SNAPSHOT_LEN);
+	if (status != 0)
+		PMD_LOG(WARNING, "%s: Could not set snapshot length: %s",
+			iface, pcap_statustostr(status));
+
+	status = pcap_activate(pc);
+	if (status < 0) {
+		char *cp = pcap_geterr(pc);
+
+		if (status == PCAP_ERROR)
+			PMD_LOG(ERR, "%s: could not activate: %s", iface, cp);
+		else
+			PMD_LOG(ERR, "%s: %s (%s)", iface, pcap_statustostr(status), cp);
+		goto error;
 	}
 
-	if (pcap_setnonblock(*pcap, 1, errbuf)) {
+	if (pcap_setnonblock(pc, 1, errbuf)) {
 		PMD_LOG(ERR, "Couldn't set non-blocking on %s: %s", iface, errbuf);
-		pcap_close(*pcap);
-		return -1;
+		goto error;
 	}
 
+	*pcap = pc;
 	return 0;
+
+error:
+	if (pc)
+		pcap_close(pc);
+	return -1;
 }
 
 static int
@@ -576,7 +621,8 @@ open_single_tx_pcap(const char *pcap_filename, pcap_dumper_t **dumper)
 static int
 open_single_rx_pcap(const char *pcap_filename, pcap_t **pcap)
 {
-	*pcap = pcap_open_offline(pcap_filename, errbuf);
+	*pcap = pcap_open_offline_with_tstamp_precision(pcap_filename,
+							PCAP_TSTAMP_PRECISION_NANO, errbuf);
 	if (*pcap == NULL) {
 		PMD_LOG(ERR, "Couldn't open %s: %s", pcap_filename,
 			errbuf);
@@ -613,6 +659,15 @@ eth_dev_start(struct rte_eth_dev *dev)
 	struct pcap_tx_queue *tx;
 	struct pcap_rx_queue *rx;
 
+	if (internals->timestamp_offloading) {
+		int ret = rte_mbuf_dyn_rx_timestamp_register(&timestamp_dynfield_offset,
+							     &timestamp_rx_dynflag);
+		if (ret != 0) {
+			PMD_LOG(ERR, "Failed to register Rx timestamp field/flag");
+			return ret;
+		}
+	}
+
 	/* Special iface case. Single pcap is open and shared between tx/rx. */
 	if (internals->single_iface) {
 		tx = &internals->tx_queue[0];
@@ -728,8 +783,13 @@ eth_dev_stop(struct rte_eth_dev *dev)
 }
 
 static int
-eth_dev_configure(struct rte_eth_dev *dev __rte_unused)
+eth_dev_configure(struct rte_eth_dev *dev)
 {
+	struct pmd_internals *internals = dev->data->dev_private;
+	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
+	const struct rte_eth_rxmode *rxmode = &dev_conf->rxmode;
+
+	internals->timestamp_offloading = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP);
 	return 0;
 }
 
@@ -749,6 +809,7 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_mtu = RTE_ETH_PCAP_SNAPLEN;
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
+	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_TIMESTAMP;
 
 	return 0;
 }
@@ -896,6 +957,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 	pcap_q->port_id = dev->data->port_id;
 	pcap_q->queue_id = rx_queue_id;
 	dev->data->rx_queues[rx_queue_id] = pcap_q;
+	pcap_q->timestamp_offloading = internals->timestamp_offloading;
 
 	if (internals->infinite_rx) {
 		struct pmd_process_private *pp;
@@ -1446,13 +1508,6 @@ pmd_pcap_probe(struct rte_vdev_device *dev)
 	start_cycles = rte_get_timer_cycles();
 	hz = rte_get_timer_hz();
 
-	ret = rte_mbuf_dyn_rx_timestamp_register(&timestamp_dynfield_offset,
-			&timestamp_rx_dynflag);
-	if (ret != 0) {
-		PMD_LOG(ERR, "Failed to register Rx timestamp field/flag");
-		return -1;
-	}
-
 	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
 		eth_dev = rte_eth_dev_attach_secondary(name);
 		if (!eth_dev) {
-- 
2.51.0

