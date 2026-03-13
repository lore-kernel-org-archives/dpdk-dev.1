Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 792A1105F781
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Mar 2026 09:11:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 52CD740279;
	Fri, 13 Mar 2026 10:11:03 +0100 (CET)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11013060.outbound.protection.outlook.com
 [40.107.162.60]) by mails.dpdk.org (Postfix) with ESMTP id BC5C74026C
 for <dev@dpdk.org>; Fri, 13 Mar 2026 10:11:01 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fL09bEr08y6G53GwE5lA5hvSedjUu8qC51dLjWDgMQsRaBEf3QpxLZADBDkU1nsF9wk9ihdm04lf58rGbhuSEwZy09dmO2vk2QoGYVeRWRqw9Y6FaMGuvCxMpFOs5lCYPGtXHYr+7ZFLc64rj4YAjNdUQOSZvDF+vslJ9My234SvGyHQIjTnpNYHPy9uE4+kdS8K24d4Bkym/VAh3v0YN2EzbOb+aj/jAWGb4n9n85XSuuI8pvRYh40x1ZGUzPabOzhNtZv0dJLBtbnlJV40YqwAmvHeoXUNZtcFJ2dqih40sR+dZzISYY7CWbUkMMwMkZahekUZvhZqS/pgzGfpEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yB4unrvKkeWTmPydmTeSJE7WWWwGkvTRPVDDOx4CuhY=;
 b=IjuYYABwQgwtxoau4Q2US2r6HLA8wNDcrwHxqg7G3vy4opsZfF9Eha81l1F2q/4EuSM9mCaIP+DNKj09ixDE5BWd8d8umblG2WEcTm//YLbsRjvZwTHg6dwATeGuxSgI6gUbbEfwNnj02p35l4Mz1HQEjbwTwN1JsZ5h3L0ovrtyhDuYl0RlBf80KtWWvj2dhmVIlI+j3T9x1LJRP8x85dNW04Miui/fajo/qyD2CzfVjaKFCyorTCX55Q9mpXEvfTNEexHhEug/tZRDTY36KjCnIlVrCvgboc8PFe3miHxsi3JBvtWY7fc984p2aNW+Qtazkz06RH3PkVVFKXYyOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yB4unrvKkeWTmPydmTeSJE7WWWwGkvTRPVDDOx4CuhY=;
 b=jd/YAq4Bz3VTgywCB12fYesw+Zud3S4XAHUiq0Fkfm1q4SMEz/U4jZ500BhRUjtJqwFMmmvyakgGE2UXnUpZoEkdC4BecbisL0lsWUbBW3yOhfukITv9XHRvDpT2SXomusd4g0dBYzUsxP2xko1ZEOpzXjmLYZ7CNwvgyuVx8XXDp3klZZCLTmDOwMe9VcgzIfddlc0BCth8MAgUYJ6/u1BVWlNAID9zxwC9nWeuluTVfzTp51jhev+lOeLv1NLn3l3rvhE0Rpruk87GsTGQzClUzv9Y//IgM52Is6r+zpCfIQqkrxBtru+kYBqoJxsm1q7TWUAHUUDiK/duXwAEtA==
Received: from AS9PR06CA0020.eurprd06.prod.outlook.com (2603:10a6:20b:462::24)
 by AS1PR07MB8784.eurprd07.prod.outlook.com (2603:10a6:20b:47c::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9700.12; Fri, 13 Mar
 2026 09:10:55 +0000
Received: from AM3PEPF0000A792.eurprd04.prod.outlook.com
 (2603:10a6:20b:462:cafe::47) by AS9PR06CA0020.outlook.office365.com
 (2603:10a6:20b:462::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.28 via Frontend Transport; Fri,
 13 Mar 2026 09:10:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM3PEPF0000A792.mail.protection.outlook.com (10.167.16.121) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Fri, 13 Mar 2026 09:10:55 +0000
Received: from seliius19697.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Fri, 13 Mar 2026 10:10:55 +0100
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19697.seli.gic.ericsson.se (Postfix) with ESMTP id 001B14020B41;
 Fri, 13 Mar 2026 10:10:54 +0100 (CET)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id D75326178C1B; Fri, 13 Mar 2026 10:10:54 +0100 (CET)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <xavier.guillaume@ovhcloud.com>,
 <robin.l.lin@ericsson.com>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>
Subject: [PATCH v4] net/af_packet: add multi-segment mbuf support for jumbo
 frames
Date: Fri, 13 Mar 2026 10:10:53 +0100
Message-ID: <20260313091053.787521-1-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260312073403.4018157-1-sriram.yagnaraman@ericsson.com>
References: <20260312073403.4018157-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A792:EE_|AS1PR07MB8784:EE_
X-MS-Office365-Filtering-Correlation-Id: 039bd1d0-ba65-44cd-134d-08de80e06f0c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: o9hTdXxae2Z/rrkWmckiQAnVdqhHVnmyYygli+PnwfJsKsKgFE/rC41vWgsmjB1AJBLbnuNmAZefMQyJNQB30buGGSXKJH0VaHTLLrsBjLQwq0SGLkhecHIpkkiiyxgzYw2w44MlyE23d9hV8WyvqVzY5K8xDnoYSSQMpKS5av1EApISkTQwlDeAHHpxtj/Ilfc2xLZGe055SVQzYz+kt6QhRIKGrasK4YIZWqWxxlk7YIJjXTywP9ozCaiVYQbidWLlDZcEzv5Qo3iUl60L08FEQkSvrhMUZTYvIdFT3nYT14JKV2vHfEN6U1XMwHZsrtopwrPtsF4ompGYe+52Wjbz5B980uPEEOIG049wWP3Dk1E7wwBgeAi1u9ynbbc6pstZaF8enCQlZQlKcLZfhf8OeJdLnaqZL8qaBZ3IruVVZ1Yk7gqVlYQIgEMyuS1ufTOxefx6QBG/D4KA2Ey/wOm3U2I8Ziq1QnvBiBFwAkrcfP4JEVRrzVCBEp0N5VLMpg9vP1E/OUxlwDW8LO2PslIN/qMtZpiEtosT1SBGYQ2Q8JCxDOy9oC8rqX1Nlb2a/UB4HwbFrvSX7n0oQeMJHqAV/d2cb8rQRftZ7+tjRU+XQGzrECyWWawYRVT0sESBuO5U/dJgkEwaUzcwZAGpg4NXHIgJBUdG+GR0TXhUGWb7ARwTuA8pz2RhGX+6VZwBHtzXcVEDIgvia23ix9KhusD+cjQStvIcauzEnp2hnbRYhhl0t5qWfe12Jaji0g7+KkRs72gRHSiGF5BHJ7cCng==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fHQyBGrYj+wFMFWikQZsHM5slPACfv5xlmql1s1mFo1K6O+AwJWEXoJ5modswWXXkDKJit++rSB8i5PTkB1XH5wSm5EUWDO+xJ53WTL49lMKcBH69LOcj/unazkPuk5yb2x0IFRWN/vkLprE/SOPPFCMw/3VeM0Y1+E6gxbHh+dXb3ba78xj4Ij3q3TnI6PfT0lfCG59ghI7kJdi6BfVwCl6bV9IqeYPeLCEJdgnIOZklWQXtpufwks2oWVBp0aMaoE9uSfjJHnI82Nwetxau7HTBzbeoECaLgY68rA/JCq8qDR98CICKwNZ4Iin0z2TzU5ZbGlqhWKCZDxR00YD7x2eDQ7VhAhj74S6bLRwo9xgCEccGkj8yu++y1TmNl7liroxiMFP0gfZ1m2kwyxkySvKeh2QvuIhhkhrp+332D7S8SGDlqdh0N70XR+/gpqy
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Mar 2026 09:10:55.6665 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 039bd1d0-ba65-44cd-134d-08de80e06f0c
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A792.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1PR07MB8784
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

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 doc/guides/rel_notes/release_26_03.rst    |  5 ++
 drivers/net/af_packet/rte_eth_af_packet.c | 79 +++++++++++++++++------
 2 files changed, 63 insertions(+), 21 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 9649185133..1048a6b595 100644
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
index e132dc387b..13daa02fe0 100644
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
@@ -154,20 +156,49 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			break;
 		}
 
-		/* drop packets that won't fit in the mbuf */
-		if (ppd->tp_snaplen > rte_pktmbuf_tailroom(mbuf)) {
+		pkt_len = ppd->tp_snaplen;
+		pbuf = (uint8_t *)ppd + ppd->tp_mac;
+
+		/* drop packets that won't fit in single mbuf if scatter not enabled */
+		if (!pkt_q->scatter_enabled && pkt_len > rte_pktmbuf_tailroom(mbuf)) {
 			rte_pktmbuf_free(mbuf);
-			ppd->tp_status = TP_STATUS_KERNEL;
-			if (++framenum >= framecount)
-				framenum = 0;
 			pkt_q->rx_dropped_pkts++;
-			continue;
+			goto release_frame;
+		}
+
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
+				pkt_q->rx_dropped_pkts++;
+				goto release_frame;
+			}
+
+			/* Remove headroom to maximize data space in chained segments */
+			rte_pktmbuf_prepend(seg, rte_pktmbuf_headroom(seg));
+
+			data_len = RTE_MIN(remaining, rte_pktmbuf_tailroom(seg));
+			memcpy(rte_pktmbuf_mtod(seg, void *), pbuf, data_len);
+			rte_pktmbuf_data_len(seg) = data_len;
+			pbuf += data_len;
+			remaining -= data_len;
+
+			prev->next = seg;
+			prev = seg;
+			mbuf->nb_segs++;
 		}
 
-		/* packet will fit in the mbuf, go ahead and receive it */
-		rte_pktmbuf_pkt_len(mbuf) = rte_pktmbuf_data_len(mbuf) = ppd->tp_snaplen;
-		pbuf = (uint8_t *) ppd + ppd->tp_mac;
-		memcpy(rte_pktmbuf_mtod(mbuf, void *), pbuf, rte_pktmbuf_data_len(mbuf));
+		rte_pktmbuf_pkt_len(mbuf) = pkt_len;
 
 		/* check for vlan info */
 		if (ppd->tp_status & TP_STATUS_VLAN_VALID) {
@@ -188,16 +219,18 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
+
+release_frame:
+		/* release incoming frame and advance ring buffer */
+		ppd->tp_status = TP_STATUS_KERNEL;
+		if (++framenum >= framecount)
+			framenum = 0;
 	}
 	pkt_q->framenum = framenum;
 	pkt_q->rx_pkts += num_rx;
@@ -412,7 +445,8 @@ eth_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
-		RTE_ETH_RX_OFFLOAD_TIMESTAMP;
+		RTE_ETH_RX_OFFLOAD_TIMESTAMP |
+		RTE_ETH_RX_OFFLOAD_SCATTER;
 
 	return 0;
 }
@@ -579,26 +613,29 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
 	struct pmd_internals *internals = dev->data->dev_private;
 	struct pkt_rx_queue *pkt_q = &internals->rx_queue[rx_queue_id];
 	unsigned int buf_size, data_size;
+	bool scatter_enabled;
 
 	pkt_q->mb_pool = mb_pool;
 
-	/* Now get the space available for data in the mbuf */
 	buf_size = rte_pktmbuf_data_room_size(pkt_q->mb_pool) -
 		RTE_PKTMBUF_HEADROOM;
 	data_size = internals->req.tp_frame_size;
 	data_size -= TPACKET2_HDRLEN - sizeof(struct sockaddr_ll);
 
-	if (data_size > buf_size) {
+	scatter_enabled = !!(dev->data->dev_conf.rxmode.offloads & RTE_ETH_RX_OFFLOAD_SCATTER);
+
+	if (!scatter_enabled && data_size > buf_size) {
 		PMD_LOG(ERR,
-			"%s: %d bytes will not fit in mbuf (%d bytes)",
+			"%s: %d bytes will not fit in mbuf (%d bytes), enable scatter offload",
 			dev->device->name, data_size, buf_size);
-		return -ENOMEM;
+		return -EINVAL;
 	}
 
 	dev->data->rx_queues[rx_queue_id] = pkt_q;
 	pkt_q->in_port = dev->data->port_id;
 	pkt_q->vlan_strip = internals->vlan_strip;
 	pkt_q->timestamp_offloading = internals->timestamp_offloading;
+	pkt_q->scatter_enabled = scatter_enabled;
 
 	return 0;
 }
-- 
2.43.7

