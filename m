Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C46C2F8D765
	for <dpdk-dev@archiver.kernel.org>; Thu, 16 Apr 2026 18:53:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E879F40E39;
	Thu, 16 Apr 2026 20:52:13 +0200 (CEST)
Received: from mail-dl1-f50.google.com (mail-dl1-f50.google.com [74.125.82.50])
 by mails.dpdk.org (Postfix) with ESMTP id DD63440E21
 for <dev@dpdk.org>; Thu, 16 Apr 2026 20:52:09 +0200 (CEST)
Received: by mail-dl1-f50.google.com with SMTP id
 a92af1059eb24-12c6df0b9bbso123060c88.1
 for <dev@dpdk.org>; Thu, 16 Apr 2026 11:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20251104.gappssmtp.com; s=20251104; t=1776365529;
 x=1776970329; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ptgpR4n6Cp7PgN9ERmAHbIMLx9/65nDPjgF5NnCQJr8=;
 b=RNfj0bwCBzO9fYZklkew3GqZQB0amgRiy0zQanuqzs7jIK7x2g/YrgCcKpCnV13C61
 MDhmKtsTPShr5EVnt0weM1E5Ef47aJVxVXef8qg/mVAIB06vwZSG2dSor8eitUHWhWmG
 SdJ4MVBriepx03AopJ+DC9mm6QEL0fVlMTZxN5TvWkJWWhbLuJVR4fRmpx7nf7DaqMiE
 fAWJ2iBus5a9JaZ3YJW50nouP95jA9bBfKs+l9aNafYLiHCxnzPHEp0qE/BLgLDyyS7D
 ZZohcbCQRLsHTAMjLXJrujG+BiQG9pnYHmU1MCl9e3VIliUvafpGHvFhR+4Q/OCs7IQH
 LaVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776365529; x=1776970329;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ptgpR4n6Cp7PgN9ERmAHbIMLx9/65nDPjgF5NnCQJr8=;
 b=ORic+R0SLVj3ufTZnfPUGqk01GhEva91TpgYz0vK/S+Ho4xP+6RpfQxGrPNADdgSBa
 YfP94bkmle+eZhfAwKHxInLVMHQXNDKn6gy/EnVEl2Q0azaeY1BXF9WhVlw2U0D1lRGp
 JQJ6R5S9QA2X75RVKcKIxqcDsbWEIyqvQBUWwDnh0dkVu5BfqDomZheP7htTG0ujzvgb
 wtbUm8Fp3Z+T2pKkKRoHM4wQ6Fl4CrXvhm1PCRNtBp/ZuPHxQHsQjoDEPH/xow1oTNGD
 ISzhsEkd2eblamIAkxmC4tXF+Nf8k8n5yhI8Rv0CTQD2Ze4jKtQSi3hbJhK+ebTPBmiT
 S2ZQ==
X-Gm-Message-State: AOJu0YxuYJiWgGNEHgI5WrbHvDmJP9nJI89dT8pyYcOa4+YKIcWG2VtH
 K2wLtQgm64ix4cDjOY5XDD7z8GMPfJ422u6Hh1Jv1XZIDJt+QwdLVJjdvAnFcoGc4EkjX64JzNN
 NpheZ
X-Gm-Gg: AeBDievLCIoKJkIPW2pY4F7JE2WLoF5kMdGNQcnLV++R4MoCFpUqLHZlCdFKKr2dTmK
 WUz84DJhvtzoWms2JFY/cjme6oK/1U/jOLBnsoNMGzrgdLQDJAoXMprUwXYFCQtwnsjjE5Ju6lf
 SMjio8Vr8X/arXkiQPsBnEHby/MGR/U091NFiGsMaiR0vVFsh47nfXLEeGHdBRkkT6jqHn48em8
 mVNLD843+YlOmWewByuxYAIs6euD2PCmMFV227uLKxs0kjNYZB4Z5MIjWP1LAQPGhILa4/cA3kj
 KBMKzeTydnla8+55R5auZMxSNx6p0qYb/awDg1yfoi06SKeAMNogUm4UTv2ck2GZYf+njntOuVK
 ubg8H38xh3mYWQgU9KoyjPBFX5gV5qU5U6YZXXSKEe140y0Zc/4DRr6C5mxi/cP9VYH3hqi47kf
 7Z223wKsPifRuq7vdo3LdTS693dWE2ZRAPKhHCO189g2w=
X-Received: by 2002:a05:7300:6ca5:b0:2d9:6373:ad10 with SMTP id
 5a478bee46e88-2e2e43558damr283551eec.7.1776365528943; 
 Thu, 16 Apr 2026 11:52:08 -0700 (PDT)
Received: from phoenix.lan ([104.202.41.210]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2de8f6615d5sm10602510eec.24.2026.04.16.11.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:52:08 -0700 (PDT)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>,
 Bruce Richardson <bruce.richardson@intel.com>
Subject: [PATCH v24 21/24] net/pcap: add Rx scatter offload
Date: Thu, 16 Apr 2026 11:48:38 -0700
Message-ID: <20260416185144.1359260-22-stephen@networkplumber.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260416185144.1359260-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260416185144.1359260-1-stephen@networkplumber.org>
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

