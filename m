Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEBDDEA71A1
	for <dpdk-dev@archiver.kernel.org>; Sun, 19 Apr 2026 16:13:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED9A740DD0;
	Sun, 19 Apr 2026 18:11:36 +0200 (CEST)
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com
 [209.85.160.45]) by mails.dpdk.org (Postfix) with ESMTP id D96C1409FA
 for <dev@dpdk.org>; Sun, 19 Apr 2026 18:11:34 +0200 (CEST)
Received: by mail-oa1-f45.google.com with SMTP id
 586e51a60fabf-4042fe53946so941710fac.3
 for <dev@dpdk.org>; Sun, 19 Apr 2026 09:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776615094;
 x=1777219894; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ptgpR4n6Cp7PgN9ERmAHbIMLx9/65nDPjgF5NnCQJr8=;
 b=Bglw8PaH8yb//P8ZmYwkf79kmcDW3z97GbSGaHt0kgat0v82DKup98rwyUwA19Sw0g
 tOgFEGd4EJmviDfBmx+Lt3LiLMU/M5NZCq82u6ci4RgnD+3OadipsmFK5PgyWaIaSLlC
 rWYKxfaN8Dz+wNJttUurJ990AR7bX+8EzgBfIb3Af1gthBpX2LG7vgo04CHrVQN9bHc0
 rp35F5KsJZoEDYNpzMkbnAXkxY067+TtZr0oGUU28R3RCkS0Fi/8D4tAFoCvC6EyABGd
 HhL2LR2Xi4XiSALixSUjNF34Wv7FT5SryltOXeh3yK91Ap7EJ8y8VfLbgMzWrdLKqh3r
 Jqzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776615094; x=1777219894;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ptgpR4n6Cp7PgN9ERmAHbIMLx9/65nDPjgF5NnCQJr8=;
 b=hnwDTAZACqnipTJg7gJmQBEea88gOsAJ3tJIhVYaky2WVmNCQkKGme1s8EXS2pU3xa
 +jLx4CKyeSw6WLJQSBYzHjeq6GWBKxavbF+7NP/Rtav9QNesxfxVyymamlNYScDQQ5AW
 Z7LiUv/tfZ+McwfBYZ6NMxIFVFTnUuGkLT+b2dsgZEOsWTaWsOvYwGOz86Ms1BN3UDRY
 GpjQY3vnRmqyAZSW943kyy5yNjNF5FXuDMMaWP7jPcgXzz8ErHnoJ4i3sX6GOAispz9O
 AuuVoHXZs+CijOrUduZ47MX3ckD9+mNCps6Lub3i3bpOxZUxZa66fuyVc0JrZkMMkjVk
 JAAg==
X-Gm-Message-State: AOJu0Yzao/4IukNU0NOx+Pp3wN/ot0VloqPe6WpSfPHPaSiEXZvcOyTA
 8fBdoH0PVBVNF3XrxABekP4mWVTLboH1+W99sobbI6ekh5rjdJsbuWJ/YIz2ccO6WxDdfXyn0Re
 q/w0i
X-Gm-Gg: AeBDieuod/m4zOHk/ehcf1rBPN6a6A4IvZsD7IqWtMapkT4C4uanKI2YpOXttae0rFQ
 xiF+Go+nwYT/o6jjJRli1bT3Jbaj0eSI/+V4bkPzXyrdICv7PsLTLj+d6BAKdlhuguTx/cq9yGc
 LqtE9tgaCjZcineUTYB4Asa7HdhUwk6LzEYzblUZuZzFvvmMYK6MlMgzLBU8guJtIZi6UwvqEvQ
 c0bVWH7P8Gg6Oiv/8Sq/FS6TpyE1TE9eQIfkap+j6ePErxwbjgmWz/y7TDqzmVfJBvtuIijeIDA
 pq4ZXDzhg5J6ulZVhUdylY+DYcQkDZnBsMbXarSdpW8sQ/9fU6kUbd2KmxLUCuWd8cShsY0coL9
 HQP5orAcEESVeOPZRjrRv7f2JarfzhAsnesAZHXriVz5VK8vkVv3e81CKxTBVn9nupx2iZNCoyH
 tZK29vNhkGooNzWpo3zuRDMl/5UoG17nkHDogL/e67jVw=
X-Received: by 2002:a05:6820:178a:b0:687:3c81:c36 with SMTP id
 006d021491bc7-69462e80f2bmr5564209eaf.25.1776615094183; 
 Sun, 19 Apr 2026 09:11:34 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-42b930bca47sm5970632fac.7.2026.04.19.09.11.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 19 Apr 2026 09:11:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v25 21/24] net/pcap: add Rx scatter offload
Date: Sun, 19 Apr 2026 09:09:54 -0700
Message-ID: <20260419161059.205954-22-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260419161059.205954-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260419161059.205954-1-stephen@networkplumber.org>
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
index 602b898a72..c2dec9167d 100644
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
@@ -926,6 +933,7 @@ eth_dev_configure(struct rte_eth_dev *dev)
 	const struct rte_eth_rxmode *rxmode = &dev_conf->rxmode;
 
 	internals->vlan_strip = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_VLAN_STRIP);
+	internals->rx_scatter = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_SCATTER);
 	internals->timestamp_offloading = !!(rxmode->offloads & RTE_ETH_RX_OFFLOAD_TIMESTAMP);
 
 	if (internals->timestamp_offloading && timestamp_rx_dynflag == 0) {
@@ -958,6 +966,9 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
 		RTE_ETH_RX_OFFLOAD_TIMESTAMP;
 
+	if (!internals->infinite_rx)
+		dev_info->rx_offload_capa |= RTE_ETH_RX_OFFLOAD_SCATTER;
+
 	return 0;
 }
 
@@ -1117,11 +1128,37 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
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
 
@@ -1134,6 +1171,12 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
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

