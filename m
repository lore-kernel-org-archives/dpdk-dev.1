Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968CAD19502
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Jan 2026 18:09:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D946A402DD;
	Mon, 26 Jan 2026 19:08:34 +0100 (CET)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com
 [209.85.221.43]) by mails.dpdk.org (Postfix) with ESMTP id DE16840649
 for <dev@dpdk.org>; Mon, 26 Jan 2026 19:08:24 +0100 (CET)
Received: by mail-wr1-f43.google.com with SMTP id
 ffacd0b85a97d-43596062728so3584720f8f.1
 for <dev@dpdk.org>; Mon, 26 Jan 2026 10:08:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1769450904;
 x=1770055704; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zgeqD2Dz+aoNNQR+aYRJVwf18ljohPnUtlEVDboKkgs=;
 b=aS9UdG1ujoABVPvbkoB5RYM7Mf3HN+LHyXZ+0pCS6lGkEcNshku1mF4axxAd5Hb+eT
 a9XrYQhBRIgpPtEiPw/A3HZd0TWhfTqTNSM9BwojMuT7bUtn+st/8IlTQ0a65TipvPSK
 YKpOWvEs8Dpa29/hm1i36xuNsfsOWM3GsaOlYK1LmDxJnxHU5bjHpuEpI117C5IoplMW
 gfZWSIjb51iWBcSMXZU7svgWiwLe/ZiMCwlFjNfJKu9lUNN+/jTmkHUg55MFuo39KpNr
 8D7rqjT2/v3axdMoF1X4+fZpVB0vwsSS9zsB7RcgVYG5tmYhG7VH33DEYTv7CBiYPbvo
 330w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769450904; x=1770055704;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zgeqD2Dz+aoNNQR+aYRJVwf18ljohPnUtlEVDboKkgs=;
 b=OXyzPfbwaFeoXwCSgLv65j+8k5ZeR4iVl370fsm3/oXu+skAporLrE9xxQj7dJYo2M
 zs83AvRIdguFc6JZXr80xvp+E2hnyZLdjdymIgyLhoHOtr704BlQ8B2PX/OaJvjZozYN
 GV2ZXPLy06WtbEjqSuAwLmbk8YnSzBqr2bky7Dur5Kus3T3Ibm0oNETZ/P0rl0bU5sRs
 8e2brXyI6r28dWwCO16vp9epRFRhKkPq40/sxx1GtJ6Z6oZml7FkZoUqm8SCWrzQvMau
 TwsqyoJ+QTMS0VUW3G9lQjed6AR6BkPzDfZ4zT9zo6LfLofNAYvF0XMuOX0xE+TaXBqM
 /2MQ==
X-Gm-Message-State: AOJu0YxR8PFhhHnxPhH282OLpBk69S4ZLy8DOwW/HaCn2blAuMoSabje
 fprtFgZg+rPah0ZU4CPQM95uxSWU6b8pQjBhOc4cHKGsD0cQKyifKUnTpS4nZ0vql8tMGaCd5fG
 XiEgw
X-Gm-Gg: AZuq6aLk31rQ54IXRaDYkHtoPiFmw6lcCAhQdWAJq6B3BCnPFqYI6LL5amG+z4pD9dF
 sm95fiFtlrsRFjXVVYVESgIT8gzDVx/HpmJD0Yl2cHjNw62bx/kNuJhRU2rwy/9GW148eJHwAhh
 gj8pJSCvEMaCC+7kVnBomOLfPL/pXl9FvtFnx363rUIk1wiLmpWW85jRmQjBhLcvo8bmYHv9Lce
 MzbhBrJ7ud4CKmBrGvpeGiD8e7Qg0OYIYTRsm7H8NHD9OgFIc1OvaFM9yulRnuLVCd1TCj6N3by
 0OgUumjzeaF3v2S1ZR+kwMRR6M05PkN61vxndJHgDk1zPv5TQDeOM+UY+PZfPO1uZ//7ZZQie4K
 huRFVHl/Aeb1X18KruGeRoXdVWzS18QCNmlFIT/MgfgfTEUBXhe2HgUMayVXMsyd3Um/zE4CGJk
 ZVR5BACEBCH+8iF/UT9oKff9KGrNzURcYjOOfNXqktb4x2BI9/LA==
X-Received: by 2002:a05:6000:25c6:b0:432:c03e:a78e with SMTP id
 ffacd0b85a97d-435c9d22f03mr9037010f8f.27.1769450904487; 
 Mon, 26 Jan 2026 10:08:24 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435b1c02c91sm31845864f8f.9.2026.01.26.10.08.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jan 2026 10:08:24 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v7 08/13] net/pcap: support VLAN insert and strip
Date: Mon, 26 Jan 2026 10:06:45 -0800
Message-ID: <20260126180807.100891-9-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260126180807.100891-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260126180807.100891-1-stephen@networkplumber.org>
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

Driver can easily insert VLAN tag strip and insertion similar
to how it is handled in virtio and af_packet.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 doc/guides/nics/features/pcap.ini      |  1 +
 doc/guides/rel_notes/release_26_03.rst |  1 +
 drivers/net/pcap/pcap_ethdev.c         | 30 ++++++++++++++++++++++++--
 3 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index b0dac3cca7..814bc2119f 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -10,6 +10,7 @@ Scattered Rx         = Y
 Timestamp offload    = Y
 Basic stats          = Y
 Stats per queue      = Y
+VLAN offload         = Y
 Multiprocess aware   = Y
 FreeBSD              = Y
 Linux                = Y
diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 76d81ac524..3d25626adb 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -59,6 +59,7 @@ New Features
 
   * Changed transmit burst to always return the number of packets requested.
     Failed sends are counted as transmit errors.
+  * Added support for VLAN insertion and stripping.
 
 
 Removed Items
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 641d345df4..810f9c6f82 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -76,6 +76,7 @@ struct queue_missed_stat {
 struct pcap_rx_queue {
 	uint16_t port_id;
 	uint16_t queue_id;
+	bool vlan_strip;
 	struct rte_mempool *mb_pool;
 	struct queue_stat rx_stat;
 	struct queue_missed_stat missed_stat;
@@ -103,6 +104,7 @@ struct pmd_internals {
 	bool single_iface;
 	bool phy_mac;
 	bool infinite_rx;
+	bool vlan_strip;
 };
 
 struct pmd_process_private {
@@ -333,6 +335,10 @@ eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		}
 
 		mbuf->pkt_len = len;
+
+		if (pcap_q->vlan_strip)
+			rte_vlan_strip(mbuf);
+
 		uint64_t us = (uint64_t)header->ts.tv_sec * US_PER_S + header->ts.tv_usec;
 
 		*RTE_MBUF_DYNFIELD(mbuf, timestamp_dynfield_offset, rte_mbuf_timestamp_t *) = us;
@@ -421,6 +427,12 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		void *temp = NULL;
 		const uint8_t *data;
 
+		if (mbuf->ol_flags & RTE_MBUF_F_TX_VLAN) {
+			/* if vlan insert fails treat it as error */
+			if (unlikely(rte_vlan_insert(&mbuf) != 0))
+				continue;
+		}
+
 		calculate_timestamp(&header.ts);
 		header.len = len;
 		header.caplen = len;
@@ -498,6 +510,12 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		void *temp = NULL;
 		const uint8_t *data;
 
+		if (mbuf->ol_flags & RTE_MBUF_F_TX_VLAN) {
+			/* if vlan insert fails treat it as error */
+			if (unlikely(rte_vlan_insert(&mbuf) != 0))
+				continue;
+		}
+
 		data = pcap_pktmbuf_read(mbuf, 0, len, &temp);
 		if (likely(data != NULL &&
 		    pcap_sendpacket(pcap, data, len) == 0)) {
@@ -732,8 +750,13 @@ eth_dev_stop(struct rte_eth_dev *dev)
 }
 
 static int
-eth_dev_configure(struct rte_eth_dev *dev __rte_unused)
+eth_dev_configure(struct rte_eth_dev *dev)
 {
+	struct pmd_internals *internals = dev->data->dev_private;
+	struct rte_eth_conf *dev_conf = &dev->data->dev_conf;
+	const struct rte_eth_rxmode *rxmode = &dev_conf->rxmode;
+
+	internals->vlan_strip = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP);
 	return 0;
 }
 
@@ -749,7 +772,9 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->max_rx_queues = dev->data->nb_rx_queues;
 	dev_info->max_tx_queues = dev->data->nb_tx_queues;
 	dev_info->min_rx_bufsize = 0;
-	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
+		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
+	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
 
 	return 0;
 }
@@ -896,6 +921,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 	pcap_q->mb_pool = mb_pool;
 	pcap_q->port_id = dev->data->port_id;
 	pcap_q->queue_id = rx_queue_id;
+	pcap_q->vlan_strip = internals->vlan_strip;
 	dev->data->rx_queues[rx_queue_id] = pcap_q;
 
 	if (internals->infinite_rx) {
-- 
2.51.0

