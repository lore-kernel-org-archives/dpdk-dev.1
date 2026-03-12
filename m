Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5A1FED2DE
	for <dpdk-dev@archiver.kernel.org>; Thu, 12 Mar 2026 07:34:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE4D640430;
	Thu, 12 Mar 2026 08:34:20 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013016.outbound.protection.outlook.com [52.101.72.16])
 by mails.dpdk.org (Postfix) with ESMTP id A70B2402E0
 for <dev@dpdk.org>; Thu, 12 Mar 2026 08:34:19 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iEGrWdCBMQaUFe5D8CbnbW1nheaQqygayx3SKcfps0EKgpGxcXW7mW57vL0W5el2TRZGLBdKvzqpC/LuV2aFlDzB4qXjsK3qfGM9sF5EGPBZz1Jwrew8UuY/yOEI31Goe6/8mxP4fVBhQHMVwExSukEFMPUnghUUdsLEsMWXnqyCAS0T3aW1T9iRaAEqeIXQbkO8ppmVrilaNBvHM5pAMVx+tm3u5zXRyuOQa47GRokFJEq4Wg0VD4Z4gIFerS1YeaFkzZFRHaZRELnx1I1NN15AAbCYgD6dkYH5q/b1v9AM9YWhlF/xW7jqEfDVdvPrDExW5zOR+KfNjFhqi9LkKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=P4JwfJ/Cotmi8yGqSMJCPjCuSF5tK1lGzTQSJtg6yJ0=;
 b=Jhsft4kcg4seMawVtUtztOLZ2P2pz5yZtZvtsoDxOAb6rPsF9HpGgK7HBcWnmHdjiDmYiQG2b46RTs5MUaYapBUzULJzUPpzB4uogRTedWN6a95OLBkLTo8ts/4GlpaPyKiRRSeBfWXtcPuIVoJ522s+a+4Q5Q6EBr6FmTU1AyyiwbBCkYO9PZTbiVLh34lm/mHkrzTTe5lC05g+I8hmGasyniCKxyHTjtjZbnQKXX9PaOKIdnVdStKcwqmvzTlAiveuHADmmKhJ9uF/lOWlxCPPw/nxtbT6APYLoj8jhjpwMvsdPjK6nmg6WLT5C+kn6mh8SgWGXXgecgGAkj8kTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=P4JwfJ/Cotmi8yGqSMJCPjCuSF5tK1lGzTQSJtg6yJ0=;
 b=buHdBgGQxku5Un3lt/LRQfgiD646z3xCcyQ5zXKzRPUlxmZnzz0rGlw1ol90RTvbDYsFS2/cPErG8y78kEwalCDYLaix0F0fgtrvuNiHloZ47lh/7W5m0BqDoWt2raoxwswtMc92KHdLBwlX8MLxOgPQjzUh2rgLSo8WHtwR0/Zs2wD1cAxUwSVb3lP4XMZoTSNKAhRdxHujdqyAYEwoeK80MtYBS62n8InE04p5DsnZNuHuTupFKcloHCTn46u3QQ3S0D/i1QdiOxN2wF9YsPF+qvuhl/3XK/qxE5moU27s55QiIZh9uE6TNW2B72Pl6oQfUZpKcuj2e39gkAGZIg==
Received: from DUZPR01CA0155.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4bd::11) by DB9PR07MB7116.eurprd07.prod.outlook.com
 (2603:10a6:10:217::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.15; Thu, 12 Mar
 2026 07:34:16 +0000
Received: from DU2PEPF00028D09.eurprd03.prod.outlook.com
 (2603:10a6:10:4bd:cafe::2) by DUZPR01CA0155.outlook.office365.com
 (2603:10a6:10:4bd::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.27 via Frontend Transport; Thu,
 12 Mar 2026 07:34:18 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DU2PEPF00028D09.mail.protection.outlook.com (10.167.242.169) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Thu, 12 Mar 2026 07:34:15 +0000
Received: from seliius19819.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 12 Mar 2026 08:34:05 +0100
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19819.seli.gic.ericsson.se (Postfix) with ESMTP id E7C4C4020B7E;
 Thu, 12 Mar 2026 08:34:04 +0100 (CET)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id CE2CC62B13B6; Thu, 12 Mar 2026 08:34:04 +0100 (CET)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: <xavier.guillaume@ovhcloud.com>, <stephen@networkplumber.org>,
 <robin.l.lin@ericsson.com>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>
Subject: [PATCH v3] net/af_packet: add multi-segment mbuf support for jumbo
 frames
Date: Thu, 12 Mar 2026 08:34:03 +0100
Message-ID: <20260312073403.4018157-1-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D09:EE_|DB9PR07MB7116:EE_
X-MS-Office365-Filtering-Correlation-Id: 916f27df-1db5-4fc9-6209-08de8009c3b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 2ZRvgfLSV119wwYd9nA1rpeGGzXKMbUmQ1AgyIrf1rV8P4xO8u7oto/RnhrQoKQU8pLmYguiLD9N88VlEdESYlDFAvbrYfrn4EgYaHGfqRNBid11EfvRmRQcfeIL77LpWXLuHzn3UeB3M1t3YpRdbOjVzccFMntVc6DzHSZ3+IKXz3ahtGxTVUEfvzKPbn+JIfKJWvA7geobBZ4jljDJjYK0JRZJTvB7r1k+pu0Tznix68Nk4wDpLvhjEIueY7he29uXBgmdvCUKLP2TITv/RKl8J7SKjdHyA2/yGTJu4rGNzt0KT/YEubMEezHM5QaRngCgjJk/ED37MUfw/V8MsHX8uz4HO1qM/+eaveoINjoqH096J/tb414XKRbUGDsR7BlWKz5+TICBbFcK0srwruaG0HVresYRl8RJnxIPKYE/+C9pIaSQ7F6M0OuMBUUq81F1AzJE2GQ68CSKYzQqvsPkeqzWNAQ1K1yZ73GvSbtRYzTTLgaiDxSyny2oTfKTF6Pc0qRgwkCBA8pU2nU/RPcGiaUi/WjDnUBXxVi0Cu7lmFEw7gIch3LUFRiQ1RvkoMl+dia2H/CafPybvvRDuDL7pUP1Hoa479NQQTqysZWWeERQBmaFLdVrZQncx7t1vdl1vmmM5cEx5yn1wJBSlljUnzkzMtgtjBDZd62KukqxV1uYYKZRBCiPMnI0r4/jVyJWVzatJnbeSXz+/EsPQlyHX04maCF8K2SazuKIX3sVUNOIdPAHvMaV5U9SDKHS/2NlIP0vJrFG9ipOjsHhMQ==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: I3iIwg+arVy30Y2SY1Xc2qOX0YCo4EaI3yGH6dn0TOzxVWt4Gv44BmSI4VZ7A++rLBd+1iOU/MM85hboED3eXJdXMrMVL9b+KeqWUHJ5RTP8piVI11H0hwrzziHIZte6t5ZGFllbtnWPHa9jDfddj7dzfYgLb3Hlw5ZfXVQxM555pF2ZfcOsyoNBItJX0lB6rynswCgMgmyjWEhjIv3Cg5tgIuquxoUvdy4x7FOLbahP41XyGvtvS+F2DAYXDVBMFyuaFrRcwPbioopNTX4WYOU/MJvxlfvdECGJt5cR7Eai5XUyNxkTvyds29a2LfHYxNh596sql1ncQYsdhAh5+owZlmwtveMriaeQIogehDAaPcPPyz9uMkpTZGeA+0kpwMTZTqc5g0ckHpu/QeY3Ak+0L/rDlfIj4e+JCAO/S96CrEwDAynunqKeq6McxJxP
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2026 07:34:15.8531 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 916f27df-1db5-4fc9-6209-08de8009c3b0
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D09.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB7116
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

Enable jumbo frame reception with default mbuf data room size by
chaining multiple mbufs when packet exceeds single mbuf tailroom.

Scatter Rx is only enabled when RTE_ETH_RX_OFFLOAD_SCATTER is
requested. Packets are dropped if they exceed single mbuf size
and scatter is not enabled, or if mbuf allocation fails during
chaining. Error counter rx_dropped_pkts tracks all drops.

This allows receiving 9KB jumbo frames using standard 2KB mbufs,
chaining ~5 segments per jumbo packet.
---
 doc/guides/rel_notes/release_26_03.rst    |  5 ++
 drivers/net/af_packet/rte_eth_af_packet.c | 76 +++++++++++++++++++----
 2 files changed, 68 insertions(+), 13 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index fdc880687b..ec627e76c9 100644
--- a/doc/guides/rel_notes/release_26_03.rst
+++ b/doc/guides/rel_notes/release_26_03.rst
@@ -65,6 +65,11 @@ New Features
 
   * Added support for V4000 Krackan2e.
 
+* **Updated AF_PACKET ethernet driver.**
+
+  * Added support for multi-segment mbuf reception to handle jumbo frames
+    with standard mbuf sizes when scatter Rx offload is enabled.
+
 * **Updated CESNET nfb ethernet driver.**
 
   * The timestamp value has been updated to make it usable.
diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index e132dc387b..5d43306c09 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -56,6 +56,7 @@ struct __rte_cache_aligned pkt_rx_queue {
 	uint16_t in_port;
 	uint8_t vlan_strip;
 	uint8_t timestamp_offloading;
+	uint8_t scatter_enabled;
 
 	volatile unsigned long rx_pkts;
 	volatile unsigned long rx_bytes;
@@ -125,12 +126,13 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
 	unsigned i;
 	struct tpacket2_hdr *ppd;
-	struct rte_mbuf *mbuf;
+	struct rte_mbuf *mbuf, *seg, *prev;
 	uint8_t *pbuf;
 	struct pkt_rx_queue *pkt_q = queue;
 	uint16_t num_rx = 0;
 	unsigned long num_rx_bytes = 0;
 	unsigned int framecount, framenum;
+	uint16_t pkt_len, data_len, remaining;
 
 	if (unlikely(nb_pkts == 0))
 		return 0;
@@ -154,8 +156,11 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			break;
 		}
 
-		/* drop packets that won't fit in the mbuf */
-		if (ppd->tp_snaplen > rte_pktmbuf_tailroom(mbuf)) {
+		pkt_len = ppd->tp_snaplen;
+		pbuf = (uint8_t *) ppd + ppd->tp_mac;
+
+		/* drop packets that won't fit in single mbuf if scatter not enabled */
+		if (!pkt_q->scatter_enabled && pkt_len > rte_pktmbuf_tailroom(mbuf)) {
 			rte_pktmbuf_free(mbuf);
 			ppd->tp_status = TP_STATUS_KERNEL;
 			if (++framenum >= framecount)
@@ -164,10 +169,57 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			continue;
 		}
 
-		/* packet will fit in the mbuf, go ahead and receive it */
-		rte_pktmbuf_pkt_len(mbuf) = rte_pktmbuf_data_len(mbuf) = ppd->tp_snaplen;
-		pbuf = (uint8_t *) ppd + ppd->tp_mac;
-		memcpy(rte_pktmbuf_mtod(mbuf, void *), pbuf, rte_pktmbuf_data_len(mbuf));
+		/* copy first segment */
+		data_len = RTE_MIN(pkt_len, rte_pktmbuf_tailroom(mbuf));
+		memcpy(rte_pktmbuf_mtod(mbuf, void *), pbuf, data_len);
+		rte_pktmbuf_data_len(mbuf) = data_len;
+		mbuf->nb_segs = 1;
+		remaining = pkt_len - data_len;
+		pbuf += data_len;
+		prev = mbuf;
+
+		/* chain additional segments if needed */
+		while (remaining > 0) {
+			seg = rte_pktmbuf_alloc(pkt_q->mb_pool);
+			if (unlikely(seg == NULL)) {
+				rte_pktmbuf_free(mbuf);
+				ppd->tp_status = TP_STATUS_KERNEL;
+				if (++framenum >= framecount)
+					framenum = 0;
+				pkt_q->rx_dropped_pkts++;
+				continue;
+			}
+
+			/* Remove headroom to maximize data space in chained segments */
+			rte_pktmbuf_prepend(seg, rte_pktmbuf_headroom(seg));
+
+			data_len = RTE_MIN(remaining, rte_pktmbuf_tailroom(seg));
+			if (unlikely(data_len == 0)) {
+				rte_pktmbuf_free(seg);
+				rte_pktmbuf_free(mbuf);
+				ppd->tp_status = TP_STATUS_KERNEL;
+				if (++framenum >= framecount)
+					framenum = 0;
+				pkt_q->rx_dropped_pkts++;
+				continue;
+			}
+
+			memcpy(rte_pktmbuf_mtod(seg, void *), pbuf, data_len);
+			rte_pktmbuf_data_len(seg) = data_len;
+			pbuf += data_len;
+			remaining -= data_len;
+
+			prev->next = seg;
+			prev = seg;
+			mbuf->nb_segs++;
+		}
+
+		/* release incoming frame and advance ring buffer */
+		ppd->tp_status = TP_STATUS_KERNEL;
+		if (++framenum >= framecount)
+			framenum = 0;
+
+		rte_pktmbuf_pkt_len(mbuf) = pkt_len;
 
 		/* check for vlan info */
 		if (ppd->tp_status & TP_STATUS_VLAN_VALID) {
@@ -188,14 +240,10 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			mbuf->ol_flags |= timestamp_dynflag;
 		}
 
-		/* release incoming frame and advance ring buffer */
-		ppd->tp_status = TP_STATUS_KERNEL;
-		if (++framenum >= framecount)
-			framenum = 0;
 		mbuf->port = pkt_q->in_port;
 
 		/* account for the receive frame */
-		bufs[i] = mbuf;
+		bufs[num_rx] = mbuf;
 		num_rx++;
 		num_rx_bytes += mbuf->pkt_len;
 	}
@@ -412,7 +460,8 @@ eth_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
-		RTE_ETH_RX_OFFLOAD_TIMESTAMP;
+		RTE_ETH_RX_OFFLOAD_TIMESTAMP |
+		RTE_ETH_RX_OFFLOAD_SCATTER;
 
 	return 0;
 }
@@ -599,6 +648,7 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 	pkt_q->in_port = dev->data->port_id;
 	pkt_q->vlan_strip = internals->vlan_strip;
 	pkt_q->timestamp_offloading = internals->timestamp_offloading;
+	pkt_q->scatter_enabled = !!(dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_SCATTER);
 
 	return 0;
 }
-- 
2.43.7

