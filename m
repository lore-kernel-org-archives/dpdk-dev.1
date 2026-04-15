Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3043F43828
	for <dpdk-dev@archiver.kernel.org>; Wed, 15 Apr 2026 14:50:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A213740DDB;
	Wed, 15 Apr 2026 16:48:35 +0200 (CEST)
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com
 [209.85.167.169])
 by mails.dpdk.org (Postfix) with ESMTP id 4B5DA40DD2
 for <dev@dpdk.org>; Wed, 15 Apr 2026 16:48:34 +0200 (CEST)
Received: by mail-oi1-f169.google.com with SMTP id
 5614622812f47-464bc03efd8so3880860b6e.2
 for <dev@dpdk.org>; Wed, 15 Apr 2026 07:48:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776264513;
 x=1776869313; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ptgpR4n6Cp7PgN9ERmAHbIMLx9/65nDPjgF5NnCQJr8=;
 b=U9mKGGiVXmSZRrMnKKh2m8xsJlR3c8H+D5fGbsNreHbvQAaiX08/ulqChg0YjoLaky
 G3BTX4Rf2sWhWI8KOvSFIqm45HhN16ljXAh6Ji9i1uPyV4/sN6x4eSg86QgcEghCyg9a
 C6flkeQdDN1fyYd3fLgR5TUVk1bu7pmsCC5p8H+v0WJzygVL77FxDXpMo0lDVr9IUmVM
 fAuk0j53LcatcZ3PuHKPzD5vGaVZ1MYZBdlA/FfJ5FXU6DsavmFfhWnuOGOzR3GbGYzO
 9r6BfnAhFWHwHcs7AkJ3LfF9McNNOz7lXwgBNC28RtwPJeCc3rzwVy10y6v4MG5YpTJ6
 lksA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776264513; x=1776869313;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ptgpR4n6Cp7PgN9ERmAHbIMLx9/65nDPjgF5NnCQJr8=;
 b=o1NWQBrbelp67/Ul7XeNp18EbS8qXLEt+nuAStm8DGumxDIv36QGVAG3zWsS3kvypD
 ikGOWIex7zdOIboP0DQKFHcYF8yeoZzSVKYqqh89bjdbHnjusYs3HAgTYBHR0hMaRbS4
 eaDynnszH5gS0B5oXDoeROO5hObU8arTYuSH5f0sBIqAOAywW0onxVl3XU3HTgkHl/Ie
 mZvbrfVFrcymmlMqsMPfpKuOTeb2Yk+MJFg7U7zwCIUuaSoQwZvth1CZe7ENd4efFxnr
 VZx4BTtmJ4jciNCVRW98qE6FWGdqAszHaX32wOAh7G6ZYK5lk+FtrP5+jMjoho5ZAAat
 e17Q==
X-Gm-Message-State: AOJu0YyzCwa0gFYZ4L7YYlcYRzKAfAKv5nAiTCFbHuqog/3EtqC2FpI1
 fIdhUNoLCNKBVt9GC+odrMArWQGXUYtNORI+1nljF5jI8nPXDajqXCfdbJHp/rLa6D+k/3ZicuI
 nEgZ/
X-Gm-Gg: AeBDietqbb9FjaPT+gfH8maa0+qHbDWmYOSSrOr7gIkYwI1wiboE8VEnodavwX7mTnn
 /OBelMN+SMThoJZKl3wDTepIrLjk7Nw+jbr9HGEiGvgtfIxbLn3YP3BfDKA2oEeq7hVow4ywqF/
 7FMf6i71UQ1LE0/a28f5AkD4xBcdE65hhe7CrRbfj9z19pSgbpFJKNtR2O1cqzdrc3+nJmCgF7W
 hA+49QPfD8b9DKzuaLo8rKlOqJmquP+pzhRYot5SZluw2T+2M6bPeucqlESW2jl0dyu1WfT21ky
 3KGEyMe2wN0j3m/JrpnNinYraew2e4wn9xoB33mJVMq+h6tTRPzI2l5FiFjx+W+uNhvNq1hzlbm
 orRxoPt3RehdqyXa5meHwotIOQVzC6zSZuwOFwzq7j2/oIMAzcqpvxZC4j7zVcY7hQ0VbThHp8E
 t8QzqP5aQ6SeOGVeyzXBNBw98Zu2gkIL7FO/7MWdcB5X8=
X-Received: by 2002:a05:6808:4fd4:b0:467:133f:ec2d with SMTP id
 5614622812f47-478a0809d97mr11458608b6e.42.1776264513496; 
 Wed, 15 Apr 2026 07:48:33 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5614622812f47-4797a53b1fesm945798b6e.16.2026.04.15.07.48.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 07:48:33 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v23 21/24] net/pcap: add Rx scatter offload
Date: Wed, 15 Apr 2026 07:46:10 -0700
Message-ID: <20260415144717.226161-22-stephen@networkplumber.org>
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

