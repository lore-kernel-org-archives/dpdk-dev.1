Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A770103A9A0
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 02:42:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D028410E8;
	Wed, 25 Mar 2026 03:40:51 +0100 (CET)
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com
 [74.125.82.182]) by mails.dpdk.org (Postfix) with ESMTP id 0811440ECF
 for <dev@dpdk.org>; Wed, 25 Mar 2026 03:40:47 +0100 (CET)
Received: by mail-dy1-f182.google.com with SMTP id
 5a478bee46e88-2c160cb021cso295780eec.1
 for <dev@dpdk.org>; Tue, 24 Mar 2026 19:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1774406446;
 x=1775011246; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1z/C5Jnm6cJ15wucK+o25bgGKuQzKDp1v8YkWf7gRlE=;
 b=r4aUa4fsR0AfBLPv0iDwZA+WjcTUODkA0M6L4Q2xIgU3ePxG9N/XTF4Zn0bHclP+Mb
 KUt7kJTuO4vcfvQ16PhE1/Lv/q44xqitH8jl9oBkC69CWndToxsLdjqgOZYAELHCqm8j
 8UyFBIbQ6/mHn00Y+7p8qIK0G3Z9kofauJ+2iCkE/FMxzyxu/ROJeoFs1z1w0S0Q62eh
 V6TQCYd4XCIXxyDiS1mZYRkN3pTza9W2kFCDfpeREAuqc9osZQaZf0YNrJMR84AKt200
 LFy/IzLalvJwg2PeydqbcZxXPxeUUVs/ehLz0cqZRJ4bTw24o7RygVBzHWvU7RmIWoUU
 1Liw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774406446; x=1775011246;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1z/C5Jnm6cJ15wucK+o25bgGKuQzKDp1v8YkWf7gRlE=;
 b=WK6cT/DANf6AP9ARxqnJ6nda+t34LQX/RmF+XdmwQwOWzgb88+3sfxlrTIjDN4MFcO
 M1Oa+BbW1ID3dB19ZfiXCtX6EZLy84lIS0ANsNYctguRYePsjHBe3Okcg+hlAAFRkI1k
 zuA3MS5ODNHDWMZwYAy4HduEfwCarrP3FktnYNEbL+h+Qsa7fxnhRmQIq6V6D0KrF/tV
 SC/wQYCMBA2TNw3n81RD8jOS6PUcv5tV2K5RKx8MSOmCVDnO4wROQPzYvKw3RR+7hfp0
 rljahNy5To7/yF7FAZZVw+8UlhEMzGr89ecpenw5yypkx/8nU6tx5gFYvIx8W4IwGYXi
 +iMA==
X-Gm-Message-State: AOJu0Yyat+qLNMzpFlpadMcIOFdAdd6p4wH1+qZZgxUl7MwJkTRirGov
 hN1eHatEvX7foCyrVtkNqVmxQppw1mTJtUMJWCvra7R1RmtIDH8dBsOgEzbtu5vmTqvYl9wN9+C
 GJQqS
X-Gm-Gg: ATEYQzxlqeSp6OVmD7HsAZnWJi+Xb8zQdz9wbXkD7ur5ZbCmb5AEhAai2pytJMKcWIj
 eKD68a9VivJGKIRMv4G2Vgu8jJDLQZC1OaX8BKSqJCwFGG3Mv9NkHNugWVqkXH/sURAjHXwvApg
 /59pcaEgtpTgruKgu0gaLPKrwi7Uz64irPd9M5UEbkWLrtHxBmKMOwicgydsBICxX1awkeVHwsJ
 krwsT5p5gcFxNDUk5DVCEWb6XaBY2cLeliD7LCKhcP+jrbNW9zdC7NiY/hAfhuG5A+SP4bZpD2p
 m7OWCjgmR2/zGCBQJzQvrd46CwTT3WHfyTTvb5dQZNuyZXdg/73b+w/kqHTLcYJXF4JKgsaBgBf
 9KPIS0k9C5fWQrmLODjLb+O0IxGb3VqPyIPiaG/yD6UAtZ2X5+LxulHMHSUd++ndIKJvE78Y8X8
 a0tQrWL6fHZ12wDvJx1kwfC1yKyBUI9jmg
X-Received: by 2002:a05:7301:2b83:b0:2be:6b70:da06 with SMTP id
 5a478bee46e88-2c15d46c6b4mr853886eec.25.1774406445967; 
 Tue, 24 Mar 2026 19:40:45 -0700 (PDT)
Received: from phoenix.lan ([104.202.29.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2c10b29b447sm17209452eec.16.2026.03.24.19.40.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Mar 2026 19:40:45 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v21 22/25] net/pcap: add Rx scatter offload
Date: Tue, 24 Mar 2026 19:37:53 -0700
Message-ID: <20260325024018.1275209-23-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260325024018.1275209-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260325024018.1275209-1-stephen@networkplumber.org>
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
capabilities if not using infinite_rx mode.

Validate in rx_queue_setup that the mbuf pool data room is
large enough when scatter is not enabled, following the
same pattern as the virtio driver.

Gate the multi-segment receive path on the scatter offload flag
and drop oversized packets when scatter is disabled.
Reject scatter with infinite_rx mode since the ring-based replay
path does not support multi-segment mbufs.

Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
Acked-by: Bruce Richardson <bruce.richardson@intel.com>
---
 drivers/net/pcap/pcap_ethdev.c | 47 ++++++++++++++++++++++++++++++++--
 1 file changed, 45 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 2de9c85124..9b1fbdba3d 100644
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
@@ -904,6 +911,7 @@ eth_dev_configure(struct rte_eth_dev *dev)
 	const struct rte_eth_rxmode *rxmode = &dev_conf->rxmode;
 
 	internals->vlan_strip = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP);
+	internals->rx_scatter = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_SCATTER);
 	internals->timestamp_offloading = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP);
 
 	if (internals->timestamp_offloading && timestamp_rx_dynflag == 0) {
@@ -936,6 +944,9 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
 		RTE_ETH_RX_OFFLOAD_TIMESTAMP;
 
+	if (!internals->infinite_rx)
+		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_SCATTER;
+
 	return 0;
 }
 
@@ -1095,11 +1106,37 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
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
 
@@ -1112,6 +1149,12 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
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
2.53.0

