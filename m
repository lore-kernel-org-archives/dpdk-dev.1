Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73EEFFD4F04
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 16:16:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5DE18410FA;
	Tue, 10 Mar 2026 17:14:28 +0100 (CET)
Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com
 [209.85.210.42]) by mails.dpdk.org (Postfix) with ESMTP id 90743410D4
 for <dev@dpdk.org>; Tue, 10 Mar 2026 17:14:24 +0100 (CET)
Received: by mail-ot1-f42.google.com with SMTP id
 46e09a7af769-7d556c1a79eso14169585a34.3
 for <dev@dpdk.org>; Tue, 10 Mar 2026 09:14:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773159264;
 x=1773764064; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oeV2bxEkqrRZ6PPa8mAPu2WttXcVRva81pMmeDAwRgg=;
 b=0vUX5g3OEEBfRxRMv7tVdqmTGeCNCF9JG7QT9TI4yJmVMGkq0L7lhMExBdiKHEtbah
 kYzmmg2+YADj6P9ZPhIraMNXwe+BuHThbqfKHvBQo9nrno6eH8lZzxwciC8yneKKyo0g
 iikLbFnfPipr4rGtRRMy1zuVoB1+F2LAc1yZstzfx8zvEiB92Y+ZOcIuPOdvgkWNYmpD
 U9/jL6++44p4IxCFn5My0QZMXD8nHhpO5VKcN8mq4zOsym96HhI6y2qli7PbGHFg7MXH
 h9ZbNHnSJxHeRrjN98fdoVuOyq2rYvTG9yPAn1TrF43GiDZA/1EZRT7osIglTW5SLS8r
 BR6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773159264; x=1773764064;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oeV2bxEkqrRZ6PPa8mAPu2WttXcVRva81pMmeDAwRgg=;
 b=fXWh6rtEyM/rjNBtRyxukBcpWlhEVUTFZcurQ8Hf9vWzx7KHJzGl9lzmD/jU18wABB
 AOLtp41EfpYvSj8HwdH8vmd7ben7uOV1GPti8HCb1xO/7phayGAzl2PibLzCa4xnNMM8
 RElxWAkPfv6S1F+q1lhIOHipDkdeSNu2ANPlTNZ+JYaP8zvPE/oiNJPdAQmUuo5hD15b
 YPb0vBIQQd3jMZ1uv8BrX2x0l/dLV0fHh8P6YcMoZoCtqk5vZmk7FNrzIBDOR9yWnvHZ
 BYwe0DEFW2xREhulFe4GZAQSyY3WR11VWrL3AcfTQTbIQnv03/vVBZjE+r+DN+UaHeDS
 rEXA==
X-Gm-Message-State: AOJu0YzmcmHOynSv2kYIuuGoLPM0s6UPVruRZFLS2fbIma7FweA2PVFB
 IShbnmtPGwk+Lymju7QdGbC151Kx31qvdAQdW6j7t73t/py68KMVt/3xGKpQpF3nUw8SCu0wTpe
 ZYVXc//A=
X-Gm-Gg: ATEYQzyH+xuTJ1mZjINfdrAz1umWB/7LUh2KDRq0jX/UYy7juTtGZSVVItIlhqSLR88
 e2+rUATsh8f/KiDwBM8vsPu9xQttKmczaSbFiVZyMAwwz4qokuOoODAoDgnHWdIv/2Ca7PnDZv5
 sQP4kik3njjHGzXMTnDHdmqIm4Xbz/7NR/s4JNwhPmH5aL4vzpqzItYxmIgy/K1eTwFtIPrDrQ7
 0DR/HRzvaOBh+rGhkS+6eGDIeznan5ahC0ySR4C2XSLsdqhKqsAqc2TJvtURXbdjeb2OcP6GfNE
 arIjYrnnAeCe8p4shJVELK8nPYzRz6F2XghyukKo3XjxQF4eBwZ4QVphAOrFBSNi9NOtSmSDyeU
 RZFFPnZGB2KVJ0k2YCSJAyBNl6NF7+xSEF7ynpBryc7yEVgawzKnnLJh002HGilqybAUuo0JElg
 lw0XfjiyqzJ3lXFkeF+VBraV/E1YIxFKYb
X-Received: by 2002:a05:6830:369b:b0:7cf:d150:a245 with SMTP id
 46e09a7af769-7d726e73c69mr10168267a34.5.1773159263867; 
 Tue, 10 Mar 2026 09:14:23 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d738e3f421sm7304004a34.25.2026.03.10.09.14.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Mar 2026 09:14:23 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v20 21/25] net/pcap: add Rx scatter offload
Date: Tue, 10 Mar 2026 09:09:59 -0700
Message-ID: <20260310161356.194553-22-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310161356.194553-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310161356.194553-1-stephen@networkplumber.org>
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

Add RTE_ETH_RX_OFFLOAD_SCATTER to the advertised receive offload
capabilities. Validate in rx_queue_setup that the mbuf pool data
room is large enough when scatter is not enabled, following the
same pattern as the virtio driver.

Gate the multi-segment receive path on the scatter offload flag
and drop oversized packets when scatter is disabled.
Reject scatter with infinite_rx mode since the ring-based replay
path does not support multi-segment mbufs.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
---
 drivers/net/pcap/pcap_ethdev.c | 47 +++++++++++++++++++++++++++++++---
 1 file changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 8a2b5c1b4b..d8a924b0cd 100644
--- a/drivers/net/pcap/pcap_ethdev.c
+++ b/drivers/net/pcap/pcap_ethdev.c
@@ -79,6 +79,7 @@ struct pcap_rx_queue {
 	uint16_t port_id;
 	uint16_t queue_id;
 	bool vlan_strip;
+	bool rx_scatter;
 	bool timestamp_offloading;
 	struct rte_mempool *mb_pool;
 	struct queue_stat rx_stat;
@@ -112,6 +113,7 @@ struct pmd_internals {
 	bool phy_mac;
 	bool infinite_rx;
 	bool vlan_strip;
+	bool rx_scatter;
 	bool timestamp_offloading;
 };
 
@@ -342,14 +344,19 @@ eth_pcap_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			/* pcap packet will fit in the mbuf, can copy it */
 			rte_memcpy(rte_pktmbuf_mtod(mbuf, void *), packet, len);
 			mbuf->data_len = len;
-		} else {
-			/* Try read jumbo frame into multi mbufs. */
+		} else if (pcap_q->rx_scatter) {
+			/* Scatter into multi-segment mbufs. */
 			if (unlikely(eth_pcap_rx_jumbo(pcap_q->mb_pool,
 						       mbuf, packet, len) == -1)) {
 				pcap_q->rx_stat.err_pkts++;
 				rte_pktmbuf_free(mbuf);
 				break;
 			}
+		} else {
+			/* Packet too large and scatter not enabled, drop it. */
+			pcap_q->rx_stat.err_pkts++;
+			rte_pktmbuf_free(mbuf);
+			continue;
 		}
 
 		mbuf->pkt_len = len;
@@ -907,6 +914,7 @@ eth_dev_configure(struct rte_eth_dev *dev)
 	const struct rte_eth_rxmode *rxmode = &dev_conf->rxmode;
 
 	internals->vlan_strip = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP);
+	internals->rx_scatter = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_SCATTER);
 	internals->timestamp_offloading = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP);
 	return 0;
 }
@@ -927,7 +935,8 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
-		RTE_ETH_RX_OFFLOAD_TIMESTAMP;
+		RTE_ETH_RX_OFFLOAD_TIMESTAMP |
+		RTE_ETH_RX_OFFLOAD_SCATTER;
 
 	return 0;
 }
@@ -1088,11 +1097,37 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 {
 	struct pmd_internals *internals = dev->data->dev_private;
 	struct pcap_rx_queue *pcap_q = &internals->rx_queue[rx_queue_id];
+	uint16_t buf_size;
+	bool rx_scatter;
+
+	buf_size = rte_pktmbuf_data_room_size(mb_pool) - RTE_PKTMBUF_HEADROOM;
+	rx_scatter = !!(dev->data->dev_conf.rxmode.offloads &
+			RTE_ETH_RX_OFFLOAD_SCATTER);
+
+	/*
+	 * If Rx scatter is not enabled, verify that the mbuf data room
+	 * can hold the largest received packet in a single segment.
+	 * Use the MTU-derived frame size as the expected maximum, not
+	 * snapshot_len which is a capture truncation limit rather than
+	 * an expected packet size.
+	 */
+	if (!rx_scatter) {
+		uint32_t max_rx_pktlen = dev->data->mtu + RTE_ETHER_HDR_LEN;
+
+		if (max_rx_pktlen > buf_size) {
+			PMD_LOG(ERR,
+				"Rx scatter is disabled and RxQ mbuf pool object size is too small "
+				"(buf_size=%u, max_rx_pkt_len=%u)",
+				buf_size, max_rx_pktlen);
+			return -EINVAL;
+		}
+	}
 
 	pcap_q->mb_pool = mb_pool;
 	pcap_q->port_id = dev->data->port_id;
 	pcap_q->queue_id = rx_queue_id;
 	pcap_q->vlan_strip = internals->vlan_strip;
+	pcap_q->rx_scatter = rx_scatter;
 	dev->data->rx_queues[rx_queue_id] = pcap_q;
 	pcap_q->timestamp_offloading = internals->timestamp_offloading;
 
@@ -1105,6 +1140,12 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 		pcap_t **pcap;
 		bool save_vlan_strip;
 
+		if (rx_scatter) {
+			PMD_LOG(ERR,
+				"Rx scatter is not supported with infinite_rx mode");
+			return -EINVAL;
+		}
+
 		pp = rte_eth_devices[pcap_q->port_id].process_private;
 		pcap = &pp->rx_pcap[pcap_q->queue_id];
 
-- 
2.51.0

