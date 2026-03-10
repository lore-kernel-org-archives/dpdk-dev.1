Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43BF6FCC9AE
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Mar 2026 02:51:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C426740E21;
	Tue, 10 Mar 2026 03:49:56 +0100 (CET)
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com
 [209.85.210.48]) by mails.dpdk.org (Postfix) with ESMTP id C896440BA4
 for <dev@dpdk.org>; Tue, 10 Mar 2026 03:49:51 +0100 (CET)
Received: by mail-ot1-f48.google.com with SMTP id
 46e09a7af769-7d74aa6bcdbso908349a34.2
 for <dev@dpdk.org>; Mon, 09 Mar 2026 19:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1773110991;
 x=1773715791; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oeV2bxEkqrRZ6PPa8mAPu2WttXcVRva81pMmeDAwRgg=;
 b=lTl2qjYIA0gnhvGlgEO+TZK1J0YM4oKTe50uxvWrLnAxVW1qWwV+Ey6xinNK2o5suD
 sToQgJfRbZR9/uQG5I4Jv5qk7vy0QYsPQi8wV6pCUNSrBo8jHJc5iAtkWPbnHCLpCiLh
 DfSyfL3dtjGzhUMYkQUY7drySWKjgYUAACYd7jk163ZBQtA0vnZozpah/Kr5xmOyvYGp
 eGOQ3NK+HJ/73iaQSUThsJQoyNU7wNhfzjbJJ4YCxJUR07xv4KPJXZSbUxpcdv6vnw+3
 aSe4n/Q1hD5e78VltU26RjqOIpySuui4SYpsPSdY/Qt2t6+kGAU5cTj5o3+31qmPKJ/y
 lipg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773110991; x=1773715791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oeV2bxEkqrRZ6PPa8mAPu2WttXcVRva81pMmeDAwRgg=;
 b=tdj16s6AKzVK8JQv8lbe70EeRP+19ZTEo9pE+C+I1AvJiTLZN2650PzY1Fr23rQHiM
 RLCQxLgKGHe2Juu9UoTbJzGUaN02k04IdQtU7aKJUZXx1wuHNJVbVSn3t5pW+4hiUqsC
 ziKBct8DfyC3UpXq7/f3xUsnV+Gg7e+8tI7JjndmpSY+FhHaStH5YNbITuIi/ijAM7/c
 /XBg0WMHVqPIZMIX0VqLN0ejitYeAD1Z4KMYcOVsJQWDJTXW9rbm+6FOrlst4LM/30mZ
 6SyYmYwuVVOuTnk2/XBuuDqpLPi+DYO1OcV99urXkxQWJM/Ds34DRVcE6TaFoWToYVw6
 PbjA==
X-Gm-Message-State: AOJu0YyGSG0wysIbSp9mg1iNWN4Bu6ksc77KRX7bFSS1kmeedEFDe2iD
 /docoI0jM5uFrNyl1BlRO9CpTz8F+EB+jh62NjiuMLemT3EOp5pbPZMgUa4KQ1cM+9sOefRh3SU
 gvDmHvEw=
X-Gm-Gg: ATEYQzyagSEzXoW8MAVJdSroedDPyLOP1pLoqFU1K8RDY9dHXNEt9015oVKv23jHZWF
 n4LaXOXHy5U7Q0sjTeSjneXO9v9HCdV++vAQB0d/v4tIX9EyrHJaoA72KDU2t+p54m8ktCLGDPk
 bPdFF1dvtE6baKaQIHaZdmbZB09VExItcfzCUFmCJiazRa+klR8Cph5O2Vv3uuKk55ZNL9Jw4pm
 TtU678mN7f/2+t2glVt7fHo+l/2IhzJSmw/wxb9vvqjGZrDIVZQv29ZhO+50Z3MtdjwpuAw7vsp
 KoO/j2M3qcuJhRyHWHhgaQ/di1jkVUJOXJRjejwsqxPyVnMjz45/NKErqNR1OzQpp4D/RN9b6wk
 tcKQtLOn4xxVF1rl5PieqAMDfoUIRf1zeUcgcOTRmhpWToBS0YxAIBIVpslHktE6o3W4WcAlrQo
 3nD085BwmOmzWRBfc1/Ta1KpgET+L3MYb2
X-Received: by 2002:a05:6830:2784:b0:7cf:e57f:df1b with SMTP id
 46e09a7af769-7d726fdbe89mr9012950a34.26.1773110991119; 
 Mon, 09 Mar 2026 19:49:51 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 46e09a7af769-7d728d1238csm7808572a34.15.2026.03.09.19.49.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 19:49:50 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v19 21/25] net/pcap: add Rx scatter offload
Date: Mon,  9 Mar 2026 19:47:56 -0700
Message-ID: <20260310024925.476543-22-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260310024925.476543-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260310024925.476543-1-stephen@networkplumber.org>
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

