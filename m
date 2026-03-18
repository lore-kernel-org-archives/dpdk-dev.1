Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1431C10854DB
	for <dpdk-dev@archiver.kernel.org>; Wed, 18 Mar 2026 09:47:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 30FB2402A0;
	Wed, 18 Mar 2026 10:47:32 +0100 (CET)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013060.outbound.protection.outlook.com [52.101.72.60])
 by mails.dpdk.org (Postfix) with ESMTP id 8802A4026F
 for <dev@dpdk.org>; Wed, 18 Mar 2026 10:47:31 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VoBFnUdYmpOz/kUCGlFr9fPhbyN3MYVSeHASIFXdRvt+rF0q/rOtiXFLkhpwr1jqe1TWy178pGeILO0Ip/RjxlpxeXGvupfD0IdpbP1dlxbS+3Oen9lQ52EFDSY3lxt+aS1W0E2YkW8+HTT6xy9aPljGyXV8ce06tTMAODkkB6ki0eRw/On0NtodGu7wIGmSuDxfIlOA813bo0QXtnDwULKj4WIU7kKJU2fQMEwypxxSaGub7rnEoE2BUJqGwkFK2RzD8AyQs/Pb46hNnmET+qOsoIJMWagnMdzCuFlozXohoucsWhprUog8jdKwyMsH8JBNfvviJCtsLQEHtbqFgQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MgJ8G2qp5IRjA8ShOSXpVy37PaZKOx7Zjkp+Hj0G1fQ=;
 b=Dtnq8+vlMKF7oTMD1PUUmZ5xs1UBSF6Lvls0TEuzob6v1OH3AfjhmhMzDFsM7uNLzz1FkLxb3ZOa84bmu9m/89zUCZeq/A9wvu4042Et8NzTvSOcEMp+kUm6KnS8/OwDLHcnQYBT708Ec4W6sEwAvComl15mJLdXDqAwsOtyhG+MdhJCPO8lfyPLF9/lImBnRuAxPcU1O7RqJnfXWhE6QTPCQ3TBX7uxseQLUyuiK5w8/ALS36ijT4DOTE1A6k7ZVPsH/2K/6T9dQFZnuaA6jx421HAQljhSl9LGjnZ5B68GH9+QiLlS3YOsBm5819Kn4tuL+O9Dnr0DgIhxr0Gxlg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MgJ8G2qp5IRjA8ShOSXpVy37PaZKOx7Zjkp+Hj0G1fQ=;
 b=vWnOEG9VbsDBfUfziaLyDj7wrWk8BnPneN8kHq+E1GH+01xfOnZg5kni3mAtQE23ScQGVyCGAJX/vGvB5YcxwHsjZOCdAcxZKW0VcOz+RQ5G03okEtffjATVo1JKkWTqAvI26uFZD1IFen7Sf37iBE1nmItXbuQ15nfPKYL8uhNIOYXfq/Ufmp8xedWmyScoOBvA42urMoHehjAUkvwZLxNVtnj9H1avwT5krOcrSKOw3tFx9eUhMfZnv7gk+ZBNHINf7uYxbugYayDqBl8Lq6hIvcFfnyruYmy/0zgbYLrmQZRGNsQjReW9r7onLQJJ9WLnA3m+vn3DjSD0VLfZAQ==
Received: from DB9PR06CA0025.eurprd06.prod.outlook.com (2603:10a6:10:1db::30)
 by FRRPR07MB12201.eurprd07.prod.outlook.com (2603:10a6:d10:1d1::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.19; Wed, 18 Mar
 2026 09:47:29 +0000
Received: from DU2PEPF00028CFD.eurprd03.prod.outlook.com
 (2603:10a6:10:1db:cafe::ef) by DB9PR06CA0025.outlook.office365.com
 (2603:10a6:10:1db::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Wed,
 18 Mar 2026 09:47:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DU2PEPF00028CFD.mail.protection.outlook.com (10.167.242.181) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Wed, 18 Mar 2026 09:47:28 +0000
Received: from seliius19697.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.63) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 18 Mar 2026 10:47:28 +0100
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19697.seli.gic.ericsson.se (Postfix) with ESMTP id 062764020B41;
 Wed, 18 Mar 2026 10:47:27 +0100 (CET)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id E178661B06BA; Wed, 18 Mar 2026 10:47:27 +0100 (CET)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>, <xavier.guillaume@ovhcloud.com>,
 <robin.l.lin@ericsson.com>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>
Subject: [PATCH v5] net/af_packet: add multi-segment mbuf support for jumbo
 frames
Date: Wed, 18 Mar 2026 10:47:26 +0100
Message-ID: <20260318094726.1284454-1-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260313091053.787521-1-sriram.yagnaraman@ericsson.com>
References: <20260313091053.787521-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028CFD:EE_|FRRPR07MB12201:EE_
X-MS-Office365-Filtering-Correlation-Id: 6522b3f3-ba6d-4a18-dd61-08de84d35e69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: eGv6X79yG5KVbfyZN6GU529M+PAPHm1fz72LrZR3cIdVqCk9b8DSfWAVKqgMZwoC8QXI6KwaD5NHvupDC3nNLK5BLU89xNNyr4J4bY9lcAFlTCNEkhPIvToullvaGAv1GXlo9mlowRscDiVwFBkxV66GO+gSVzMbrKe7jc2PDzyvvsCNVYHL66H+E+6WzpNVHEMZFum3j+YEnen0gdkr6Jd/xb+U82+nnC7tsDRJ2DcmYM9JNznEsTSwl28MGswIzqbe31vpwXDincIpdMWoxOX4i74zmqL0UoPJt3R0H9JZCEHc/nhCiKygmE7Bv6AifB7jBYxk3fKp7FHgo33UWGkGsNaaDZi9xVTgA1lzlyd9HKQ4FOnpUWiVBzrx7ELBFj46EvIlWsYhmCxSY3yUnRY+CJWl+rE0W2YzeS5CB/q+z7E7DRU+1N9oTEDpknxOMM8TxRBTzXzjm9q0WeU0PCzdQMhC9g5MKy87M7xzkgW1Q1S2d0Nw3TEpXsSbfxSj9pwuKJFb7cjhs+GUELK305AAXEEG8MeTdRAbp62sBLjzk93S9RfI0TjsGCt3SuW7A9BGF/JMnFGR1PzLGFt3OQg6CU5asB50lqZA/Edo2q5v0uKFRuzu8Osqk0T1mg5cV/boWH6QtSPgvLOLbbTURQNujBvRirEB9xaDm3/uwlbl/OTD8+0gtweJhUGhw7v6X48kig/1f/wzlnTUkp1zg0rT30iSwBfsnmUuHWVUXh5jbnEQLbNjB3tuul+/L82pGnjSNNA3NI1DaXJYIMAHiw==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(56012099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 53M2j0Go/BMuyTmhLqfHi6kV+OUeEgBcoo0xkORPngVrp9MAqLR+vJ5yTNjrnZxhpnEQlM3D6XIkjSE5/nvoJ+8jy5LUfp4XDoq97Sm7pepsVJODuCe8XZJ4KtM1B2LmKgfLBtpxFpg6PPydYmU9kVoPj3/PewUapa0m2J4oCbat4wDUnIh6HVl3rD/G5LC++aU1t/p8KXknSMAAVfBRyCnXMpLssBkVLY+YGCTjw1eRdoFNZJ7Ok+9SOtn1gry7w6S5znzuGVr0SmIElhzBRFB5RZORPFVoeKn2/8Gfvc8LqncIZXBGlK/2gpEQAHvBHYVybz3ibFwFg+l6VlHxDW9MOkCIY5UpnX5uJr1XZS+RpYMwU4kCdYWUCoRu7ALupInXeSvGhCrrLgpLXpq9CSzVs2r2Drg36umKGospw4Z2TUSYdD5g9th7XyHrM1O4
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2026 09:47:28.9356 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6522b3f3-ba6d-4a18-dd61-08de84d35e69
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028CFD.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: FRRPR07MB12201
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
v5:
* Rebased on main (26.03-rc2) now that Xavier's jumbo frame series is merged
* Removed Depends-on (dependency is now in main)
* Extracted scatter copy into eth_af_packet_rx_scatter() helper (matches pcap pattern)

v4:
* Added scatter validation in rx_queue_setup to reject invalid configurations
* Fixed control flow: use goto instead of continue in scatter loop
* Moved frame release to common label to prevent use-after-free
* Ensured VLAN/timestamp extraction happens before releasing frame to kernel

v3:
* Added conditional scatter based on RTE_ETH_RX_OFFLOAD_SCATTER configuration
* Removed headroom from chained segments to maximize data capacity
* Fixed infinite loop risk by removing zero tailroom check (trust mempool config)

v2:
* Fixed goto label to properly exit outer loop on allocation failure
* Changed bufs indexing from [i] to [num_rx] for correct packet placement
---
 doc/guides/rel_notes/release_26_03.rst    |  5 ++
 drivers/net/af_packet/rte_eth_af_packet.c | 97 ++++++++++++++++++-----
 2 files changed, 82 insertions(+), 20 deletions(-)

diff --git a/doc/guides/rel_notes/release_26_03.rst b/doc/guides/rel_notes/release_26_03.rst
index 3d2ed19eb8..54e3bdbcc7 100644
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
index e132dc387b..7db3843610 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -56,6 +56,7 @@ struct __rte_cache_aligned pkt_rx_queue {
 	uint16_t in_port;
 	uint8_t vlan_strip;
 	uint8_t timestamp_offloading;
+	uint8_t scatter_enabled;
 
 	volatile unsigned long rx_pkts;
 	volatile unsigned long rx_bytes;
@@ -120,6 +121,46 @@ RTE_LOG_REGISTER_DEFAULT(af_packet_logtype, NOTICE);
 	RTE_LOG_LINE(level, AFPACKET, "%s(): " fmt ":%s", __func__, \
 		## __VA_ARGS__, strerror(errno))
 
+/*
+ * Copy packet data into chained mbufs when it exceeds single mbuf tailroom.
+ * Returns 0 on success, -1 on mbuf allocation failure.
+ */
+static int
+eth_af_packet_rx_scatter(struct rte_mempool *mb_pool, struct rte_mbuf *mbuf,
+		const uint8_t *data, uint16_t data_len)
+{
+	uint16_t len = rte_pktmbuf_tailroom(mbuf);
+	struct rte_mbuf *m = mbuf;
+
+	memcpy(rte_pktmbuf_mtod(mbuf, void *), data, len);
+	rte_pktmbuf_data_len(mbuf) = len;
+	data_len -= len;
+	data += len;
+
+	while (data_len > 0) {
+		m->next = rte_pktmbuf_alloc(mb_pool);
+		if (unlikely(m->next == NULL))
+			return -1;
+
+		m = m->next;
+
+		/* Headroom is not needed in chained mbufs */
+		rte_pktmbuf_prepend(m, rte_pktmbuf_headroom(m));
+		m->pkt_len = 0;
+		m->data_len = 0;
+
+		len = RTE_MIN(rte_pktmbuf_tailroom(m), data_len);
+		memcpy(rte_pktmbuf_mtod(m, void *), data, len);
+		rte_pktmbuf_data_len(m) = len;
+
+		mbuf->nb_segs++;
+		data_len -= len;
+		data += len;
+	}
+
+	return 0;
+}
+
 static uint16_t
 eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 {
@@ -131,6 +172,7 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	uint16_t num_rx = 0;
 	unsigned long num_rx_bytes = 0;
 	unsigned int framecount, framenum;
+	uint16_t pkt_len;
 
 	if (unlikely(nb_pkts == 0))
 		return 0;
@@ -154,20 +196,29 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			break;
 		}
 
-		/* drop packets that won't fit in the mbuf */
-		if (ppd->tp_snaplen > rte_pktmbuf_tailroom(mbuf)) {
+		pkt_len = ppd->tp_snaplen;
+		pbuf = (uint8_t *)ppd + ppd->tp_mac;
+
+		if (pkt_len <= rte_pktmbuf_tailroom(mbuf)) {
+			/* packet fits in a single mbuf */
+			memcpy(rte_pktmbuf_mtod(mbuf, void *), pbuf, pkt_len);
+			rte_pktmbuf_data_len(mbuf) = pkt_len;
+		} else if (pkt_q->scatter_enabled) {
+			/* scatter into chained mbufs */
+			if (unlikely(eth_af_packet_rx_scatter(pkt_q->mb_pool,
+					mbuf, pbuf, pkt_len) < 0)) {
+				rte_pktmbuf_free(mbuf);
+				pkt_q->rx_dropped_pkts++;
+				goto release_frame;
+			}
+		} else {
+			/* oversized and no scatter - drop */
 			rte_pktmbuf_free(mbuf);
-			ppd->tp_status = TP_STATUS_KERNEL;
-			if (++framenum >= framecount)
-				framenum = 0;
 			pkt_q->rx_dropped_pkts++;
-			continue;
+			goto release_frame;
 		}
 
-		/* packet will fit in the mbuf, go ahead and receive it */
-		rte_pktmbuf_pkt_len(mbuf) = rte_pktmbuf_data_len(mbuf) = ppd->tp_snaplen;
-		pbuf = (uint8_t *) ppd + ppd->tp_mac;
-		memcpy(rte_pktmbuf_mtod(mbuf, void *), pbuf, rte_pktmbuf_data_len(mbuf));
+		rte_pktmbuf_pkt_len(mbuf) = pkt_len;
 
 		/* check for vlan info */
 		if (ppd->tp_status & TP_STATUS_VLAN_VALID) {
@@ -188,16 +239,18 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
@@ -412,7 +465,8 @@ eth_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
-		RTE_ETH_RX_OFFLOAD_TIMESTAMP;
+		RTE_ETH_RX_OFFLOAD_TIMESTAMP |
+		RTE_ETH_RX_OFFLOAD_SCATTER;
 
 	return 0;
 }
@@ -579,26 +633,29 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
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

