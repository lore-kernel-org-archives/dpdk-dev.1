Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAC80CA5FE6
	for <dpdk-dev@archiver.kernel.org>; Sat, 17 Jan 2026 22:01:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9828342F59;
	Sat, 17 Jan 2026 23:00:54 +0100 (CET)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54]) by mails.dpdk.org (Postfix) with ESMTP id 35D8142F57
 for <dev@dpdk.org>; Sat, 17 Jan 2026 23:00:53 +0100 (CET)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-42fb0fc5aa4so2637572f8f.1
 for <dev@dpdk.org>; Sat, 17 Jan 2026 14:00:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=networkplumber-org.20230601.gappssmtp.com; s=20230601; t=1768687253;
 x=1769292053; darn=dpdk.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=maU7BfBVo8ZnmMAw3KTe+A0JXXaJoclF54oMjGMy0Jw=;
 b=CtHu1RwlICY7XEYkJS+9gQFfwHskhAANX3X5WxLGecFR1UNbXdrlSWx1nEQLLIv4om
 N38+t7VnxkdgPKiMkULjOZre0i1hd5RjuQHmpyHhmYYrY9w3WQKPyiA85lTO5EKTgCAq
 UpuAFShgT5TXl05a2ACu7FtfpXLb6rol9FmRRMuuK36fNxTajdWPCXMyidzcp21HsfbF
 GCuooj80bcG9Ief1HNQEeeaWCpItM0BhcFvNLN6PfHm3q3578w4sx73B3fiL3CCnI56y
 EuQG7VNQL6/HA0+C5C0bAmo7nuMeaG13nqxH5d0P9u4M/6FwBgkzWhDLidRbNxn/TuoA
 sGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768687253; x=1769292053;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=maU7BfBVo8ZnmMAw3KTe+A0JXXaJoclF54oMjGMy0Jw=;
 b=hPyQpKZ7NpOaedMj2DM0oanxd7cXfEoWQ6Vjy5E5HYiWf8PmRBaXFcI5cj+pjlVnyf
 UKnJJK6312dbahvoAj7rLBgoFbkYbKyV1IrAthdne3IZO2SP50Cz/DKExyBJjLagSvQT
 tCvIEl6NJvCDpUK1Wpqv413ymABjwnfMTvPoVgV2lFf3lYUoa7ZN0Rd81DJMSngPs2mn
 KhA8BIg3n9C+S1oWcHXGXji5Opok3FgRyCDvSQoUSW8R/e6aep1JaLupeUFEfHAPtnlH
 IHvq3SvHxL/dcl6ORxDLdte29TVlB5nk+tQYbjb6Tw/3rrW0gFrjrX5GxrOEb4K5DhIY
 Y0Ig==
X-Gm-Message-State: AOJu0Yykn2ne46aSXuxB/UrZrL2IRq186oCZeGj2t1g496lAZb6vTl3I
 TBRixNgzsq+h+lxPDD+iVXnrbO4sEKTtVW8LwDVsHswgyswommg90zoJ+nopv3/45xujQIb/6so
 w73Qv
X-Gm-Gg: AY/fxX4RtPbaKYt3PhORsQ+nc3/MXqdDwojrP7Ok4M6nyaHO4Iz+zXCGs+MJfT28fNr
 y/U8w8QeSJ4IGdAue3i4mSWVRAtMMwo1jSyCgYTcpVFTtUVq44WpTKoOAVPiXtqAODYnvZlXPk9
 s+5jBh7MEjl2AmUMlkTFlTwFMOt1x3NGTzhad0fmdzUHHcSBJzUxi88a7G/sIL7FtXZSqeJAVUN
 vAOL73Y0VWQXyrhTBXNinXNiFiQQiDQxQ9HsQUAjSbSNsPWIPo/fura5nT3AmSLrkFYuQFqjeuf
 3oIduRDXanQs3sfne0q5NBOquw7EgFsmOoXS03TdRzId9E1R42jrAeAb4eSRvcpjVWY7g7anEWT
 2obyBO3nkuNhjWFS4o6KhhsGAiILCNCC36HKQf0nGTKIJ4KGQjXlh9hnNKvJG+i9Lk2G6689hbJ
 8uqmsI6YYFnmMzfObZUe/BqEb1TOEdppZazlGUfYSH8Z7sBOienA==
X-Received: by 2002:a5d:5f49:0:b0:432:5bac:391c with SMTP id
 ffacd0b85a97d-4356a08307cmr9920615f8f.52.1768687252786; 
 Sat, 17 Jan 2026 14:00:52 -0800 (PST)
Received: from phoenix.lan (204-195-96-226.wavecable.com. [204.195.96.226])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356992681esm13309352f8f.11.2026.01.17.14.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 17 Jan 2026 14:00:51 -0800 (PST)
From: Stephen Hemminger <stephen@networkplumber.org>
To: dev@dpdk.org
Cc: Stephen Hemminger <stephen@networkplumber.org>
Subject: [PATCH v4 06/11] net/pcap: support VLAN offloads
Date: Sat, 17 Jan 2026 13:57:05 -0800
Message-ID: <20260117220030.273471-7-stephen@networkplumber.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260117220030.273471-1-stephen@networkplumber.org>
References: <20260106182823.192350-1-stephen@networkplumber.org>
 <20260117220030.273471-1-stephen@networkplumber.org>
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
index e75bf03051..7a1420a2eb 100644
--- a/doc/guides/nics/features/pcap.ini
+++ b/doc/guides/nics/features/pcap.ini
@@ -10,6 +10,7 @@ Scattered Rx         = Y
 Rx Timestamp         = Y
 Basic stats          = Y
 Stats per queue      = Y
+VLAN offload         = Y
 Multiprocess aware   = Y
 FreeBSD              = Y
 Linux                = Y
diff --git a/drivers/net/pcap/pcap_ethdev.c b/drivers/net/pcap/pcap_ethdev.c
index 62f073e214..19d4ed94e1 100644
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
@@ -414,6 +420,13 @@ eth_pcap_tx_dumper(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
@@ -494,6 +507,13 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
@@ -506,7 +526,6 @@ eth_pcap_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		} else {
 			++tx_queue->tx_stat.err_pkts;
 		}
-
 	}
 
 	tx_queue->tx_stat.pkts += num_tx;
@@ -734,8 +753,13 @@ eth_dev_stop(struct rte_eth_dev *dev)
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
 
@@ -753,7 +777,9 @@ eth_dev_info(struct rte_eth_dev *dev,
 	dev_info->min_rx_bufsize = 0;
 	dev_info->min_mtu = RTE_ETHER_MIN_LEN - RTE_ETHER_HDR_LEN - RTE_ETHER_CRC_LEN;
 	dev_info->max_mtu = RTE_ETH_PCAP_SNAPLEN;
-	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS;
+	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
+		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
+	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP;
 
 	return 0;
 }
@@ -900,6 +926,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 	pcap_q->mb_pool = mb_pool;
 	pcap_q->port_id = dev->data->port_id;
 	pcap_q->queue_id = rx_queue_id;
+	pcap_q->vlan_strip = internals->vlan_strip;
 	dev->data->rx_queues[rx_queue_id] = pcap_q;
 
 	if (internals->infinite_rx) {
-- 
2.51.0

