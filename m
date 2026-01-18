Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36F77C9832F
	for <dpdk-dev@archiver.kernel.org>; Sun, 18 Jan 2026 17:00:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6DF7F40A87;
	Sun, 18 Jan 2026 18:00:05 +0100 (CET)
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53]) by mails.dpdk.org (Postfix) with ESMTP id 3D4E940684
 for <dev@dpdk.org>; Sun, 18 Jan 2026 18:00:02 +0100 (CET)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-47ee76e8656so40815805e9.0
 for <dev@dpdk.org>; Sun, 18 Jan 2026 09:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768755602;
 x=1769360402; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EEdJ5YKbslEg72+5FPBakrQewkkDeEGUUvGqTxwJt+0=;
 b=VsL7mT4+1tsFZXHle6P2vZD6jrO12YXzqzx7L74dOIsN5dIPjr14q+kyaNuL0mk4o6
 V3DISfUWZpL9xsZTsT8YpCPteur/6q3sNK/ycigW2hQIftZpXvZDm8RPhJ4YNH9yGlqJ
 k41WFjqD0BYEOqCbFY5KA6WDcWutQQIqpBP4pjgOat5zErlcLL8TTqblu/M3Siex2j0u
 1apSI32yVV1N5rHi2BWaglhnosI38yf5y2aw5YMYvfq9yG6UXWTHHcu7xK8RYRarzEqJ
 41ZwRJeVELHIDAZl5OKZL8pK5nbZw8sGe1xE/DVuTSaR0KQkF8Emwi/WGKmJsVN/lTXO
 sw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768755602; x=1769360402;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EEdJ5YKbslEg72+5FPBakrQewkkDeEGUUvGqTxwJt+0=;
 b=vKh6zl20ZZ0LwgK3Hu3fkiKS0k7iorLroopkzBMgkyFOpEQjRbZ0t94/BpzGe4E0Ro
 Q7K003D8o3G2pnaTXoEKJBEy4iRw3TidFRMbiRpZ1woY0S/mByMGlblyPQJL/5EWcTzv
 pjRzQpt91nNb63TAbsX30a+9Kf4zwP52pttPv0d+Rmv5B10QBnf704X0WYVKCAgqdf8m
 12AHZR8Je97/B5SSCAGXfrax0LufPrY3ZykESabHgEHC/rBNsqNs1x7Wi6trP9lR0N41
 d1AUzCQ/Qvfxtr2sG7wHxfiOQoHRtwiZmBwD6Gq9o849slKET2dHYBidliggMPS77nCx
 fe/Q==
X-Gm-Message-State: AOJu0Yzz0HeSZdPasToYEtiqorG/Mgcs3Et3aCcvzaPC1VJxk76FcfJV
 pvsiArNAK8HRDw7DC+YKgnTJrR5QQVBF9jRDhEpq67S4N0QOGbbcordpTOuOStsjOOahTMFhWNt
 iZC7Y
X-Gm-Gg: AY/fxX5ShCA/9ozDi2QnzNWzPO/3HKJZZJMhZrsAAmCp0Ia0Ua+nEJGYrskkV2jRwUw
 F2eFFBpMCMKfd5giwqZ5sGdqs5UPqahx5Vxk0h5ibXIEQGdSqzBXSMB6KaJjMc+xT9nw3h7OZQU
 gseD+fdb9LYOHqwS8N8QWwerSKZtqF8n4/WZbhwwpjaoFC0eTFRLwloLE3xhIUOQdn2CZxrZLTt
 5UAlKZNWlaNk5gukXomew5yak4qlREgY64KIThFMeu7ozukLcuYGsZQ/bZNIgV9DtSnNU2rtjnj
 PFbh4QkxSbchMTWbUjk1nTeb6Dn1ogsy0VFrDvOJZ/WkoudKYAJRu1vdR4hTo38HtACtPWSbiu8
 A2+YqE7sNRezWC3OfHdTuzrRkCXdE/rk65UlmuWHwbBg8HLHkVkzbVCC+yyehwhIF6H/ZmJZJVI
 yaAhbgg/z00W074Oh5/stPVbq1OdKq3rPYeqjyWZX3jY1SnnX33Q==
X-Received: by 2002:a05:600c:8b09:b0:477:5b0a:e616 with SMTP id
 5b1f17b1804b1-4801e2f90efmr114113755e9.5.1768755601802; 
 Sun, 18 Jan 2026 09:00:01 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e86c1b2sm146849365e9.3.2026.01.18.09.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Jan 2026 09:00:01 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v5 06/11] net/pcap: support VLAN offloads
Date: Sun, 18 Jan 2026 08:58:41 -0800
Message-ID: <20260118165944.41374-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118165944.41374-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260118165944.41374-1-stephen@networkplumber.org>
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
 doc/guides/nics/features/pcap.ini |  1 +
 drivers/net/pcap/pcap_ethdev.c    | 33 ++++++++++++++++++++++++++++---
 2 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/doc/guides/nics/features/pcap.ini b/doc/guides/nics/features/pcap.ini
index d2f5ee6039..7043213c5f 100644
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
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 1b3a86cb50..0018e03c06 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -68,6 +68,7 @@ struct queue_missed_stat {
 struct pcap_rx_queue {
 	uint16_t port_id;
 	uint16_t queue_id;
+	bool vlan_strip;
 	struct rte_mempool *mb_pool;
 	struct queue_stat rx_stat;
 	struct queue_missed_stat missed_stat;
@@ -95,6 +96,7 @@ struct pmd_internals {
 	bool single_iface;
 	bool phy_mac;
 	bool infinite_rx;
+	bool vlan_strip;
 };
 
 struct pmd_process_private {
@@ -325,6 +327,10 @@ eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		}
 
 		mbuf->pkt_len = len;
+
+		if (pcap_q->vlan_strip)
+			rte_vlan_strip(mbuf);
+
 		uint64_t us = (uint64_t)header->ts.tv_sec * US_PER_S + header->ts.tv_usec;
 
 		*RTE_MBUF_DYNFIELD(mbuf, timestamp_dynfield_offset, rte_mbuf_timestamp_t *) = us;
@@ -413,6 +419,13 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		void *temp = NULL;
 		const uint8_t *data;
 
+		if (mbuf->ol_flags & RTE_MBUF_F_TX_VLAN) {
+			if (unlikely(rte_vlan_insert(&mbuf) != 0)) {
+				++dumper_q->tx_stat.err_pkts;
+				continue;
+			}
+		}
+
 		calculate_timestamp(&header.ts);
 		header.len = len;
 		header.caplen = len;
@@ -493,6 +506,13 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		void *temp = NULL;
 		const uint8_t *data;
 
+		if (mbuf->ol_flags & RTE_MBUF_F_TX_VLAN) {
+			if (unlikely(rte_vlan_insert(&mbuf) != 0)) {
+				++tx_queue->tx_stat.err_pkts;
+				continue;
+			}
+		}
+
 		data = pcap_pktmbuf_read(mbuf, 0, len, &temp);
 		if (unlikely(data == NULL)) {
 			++tx_queue->tx_stat.err_pkts;
@@ -505,7 +525,6 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		} else {
 			++tx_queue->tx_stat.err_pkts;
 		}
-
 	}
 
 	tx_queue->tx_stat.pkts += num_tx;
@@ -733,8 +752,13 @@ eth_dev_stop(struct rte_eth_dev *dev)
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
 
@@ -752,7 +776,9 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->min_rx_bufsize = 0;
 	dev_info->min_mtu = RTE_ETHER_MIN_LEN - RTE_ETHER_HDR_LEN - RTE_ETHER_CRC_LEN;
 	dev_info->max_mtu = RTE_ETH_PCAP_SNAPLEN;
-	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
+		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
+	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
 
 	return 0;
 }
@@ -899,6 +925,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 	pcap_q->mb_pool = mb_pool;
 	pcap_q->port_id = dev->data->port_id;
 	pcap_q->queue_id = rx_queue_id;
+	pcap_q->vlan_strip = internals->vlan_strip;
 	dev->data->rx_queues[rx_queue_id] = pcap_q;
 
 	if (internals->infinite_rx) {
-- 
2.51.0

