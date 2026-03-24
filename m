Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8EBEF54ACF
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 16:30:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5853402BE;
	Tue, 24 Mar 2026 17:30:01 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013004.outbound.protection.outlook.com [40.107.159.4])
 by mails.dpdk.org (Postfix) with ESMTP id DE6454025F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 17:29:59 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c/b5HJXku7oFCdnKoXnak43l5ZXZi2FZgsfnME1CxuwfWrEvhIEY9WbAZYbBac7U2yVWb+VlDiTW6B00YMiY1UvMuN0bZxLZV0Gn6awqJvNXw+JM4OltihErKFQIhHzgW1DIMdafNWhlafMKubluHGDC4ipPJandfglDT40LRh9CdLxEhatdcObCLUh+fJniyj0v1TaLzkO/vhTNDsYl1qrcbkEk1C5qoAtMqUVmKR4RIdKbatB9daDdj9SYLFl/yO5s7qTn/EKUGRlE9BkjxHhjN2YRoatSRXmu27E70/oYRcWKtapvbm85pO899dlUGfTkkmh41064h/TMkBY1+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hnRNtqeXfryk21DrNaoVphNg/22nmFfGConQsWFe+fo=;
 b=F6qBfg7jV7+ilkAQZwoRw30V0Wx1vqR6cVFQL2iEwrWU6DVNEL2OiAYp0jhEWqiu7A7CA6QG2659aSHCM3WfQwhTgmLPU5vTRPB5GYXgEVQ0nnM0FWNVmmB7ooSOlEmvQ8PS5K0O7X/N/HkScH+LmqKQm4gpujIRZE4Qte+JZggZ6+knRjkVJZ6W4CO2wQmqVnaCh61jxlVxNbPQMkU/8sLFB/kTaw3Nn/EOsrdgerFEUa25Zf3LdGH4QXbkxkkwKLXAu4g35yjJEblm952ixUQcVOtnFIOQq3qU6rWAIBnKnEXDMKF7fI3T/qvhiIzI8kHG400EFR/bYAHQ/0wmYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hnRNtqeXfryk21DrNaoVphNg/22nmFfGConQsWFe+fo=;
 b=Rw2Dx3yz6LRch5ggHWSsiHnsxRlWsDAbJmtRT1EacNusddFRAjk2KN5CpQQYt6zSWUrC2eOUFF1e2bTS0bu18yvmt7QsGD0m/UOrgdvVWnuEl+HDqgKKM9z1K5jQS7t15pCXlMpYMGelAFQrLpoQB8bTKA0RFha29pci6fV0Tau945yu0B/SwWASb76q++qrxJp6uRuWkC/wYze4jLfYsM8PrTnZ/JV1LfPJXubO7ndlW+Pb8/WM8cxWCXwmPCA5XwexuUi0wXEt1h4uM5ZuItfJq4XkAtAYq/zQhfGgVY+9k4J39XHFHifNRrYwIln0T+fcqfn6IW2Tj/BGXRiKXA==
Received: from DU2PR04CA0077.eurprd04.prod.outlook.com (2603:10a6:10:232::22)
 by VI0PR07MB11372.eurprd07.prod.outlook.com (2603:10a6:800:30c::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.31; Tue, 24 Mar
 2026 16:29:53 +0000
Received: from DB5PEPF00014B89.eurprd02.prod.outlook.com
 (2603:10a6:10:232:cafe::86) by DU2PR04CA0077.outlook.office365.com
 (2603:10a6:10:232::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 16:29:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB5PEPF00014B89.mail.protection.outlook.com (10.167.8.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 16:29:53 +0000
Received: from seliius19697.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.67) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 24 Mar 2026 17:29:53 +0100
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19697.seli.gic.ericsson.se (Postfix) with ESMTP id C68E04020B42;
 Tue, 24 Mar 2026 17:29:52 +0100 (CET)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id AD0B261B06BC; Tue, 24 Mar 2026 17:29:52 +0100 (CET)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <xavier.guillaume@ovhcloud.com>,
 <robin.l.lin@ericsson.com>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>
Subject: [PATCH v6] net/af_packet: add Rx scatter for jumbo frames
Date: Tue, 24 Mar 2026 17:29:52 +0100
Message-ID: <20260324162952.2827453-1-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260318094726.1284454-1-sriram.yagnaraman@ericsson.com>
References: <20260318094726.1284454-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B89:EE_|VI0PR07MB11372:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a6aea7f-6131-4c92-2359-08de89c29447
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: Wmkf8bVCm01nnWFljEOALFc4Au5iK5/CDNGXXlc+jIAZNvOop5ieu+HdbI7N54d66+UdvSGYHXO3hxX07a3KUeGTN1DCmPoKK/vSGYqErfpefcazhqbIi2GVdvaykBw3W6HIYJnlx7gBlRt0jqYYOdiH3A/T1RY5Q6+FYr8+mpJmLZ79rGAbJ4OkxC+cwxBgnQg+ozYONb+sHr2Bc+LuLL6X41S5GfmD5Ha4nj57ssLjVlyKlO7YxPKZU+0ZwEH39Mr2Vjl1NKsfA18GMybAf7/udhbrLENUYo6dOaZQFKb+y7PH+iQP1e+eu5bEt5vfIPtc+o8CAoiwvaiA24zYcQ7REYdJSrQX/KcIFJ3HuPZCpJCvsgKb60kRsM77GGBKpK7SO/1qK5IVq80afkkbxlUmm7Fz6ZpTdAIWFFDY8i1f5YwtwVHC+CDnEiLqfB7GQ430HsxqBzHUL9xtrqK++PdQUAC08KMljPwYu5ElMKS9Ea6goZmJGl1TGk36n96DQO3hRlMYB68tqeBTL9ecMbojHhiwne8m+yN07JWpUGC9RHP8Bj2oGXUYRhoNufmsCqZ3ACkdjFA60pA9xd82bM6n5j6tF58Rv92VGb5nWyg1qzkVqQCvjT+YCm8ngurnOOSv6XEDuVN8ibE39wLAFrG4j9CU6l7WzDdwu16nUukwGzY+MQ1MSFfCTMhpZYO4iBDI6A/u/QX//Ha0alAD2siK4krykF1SmXxrpXzM1KrDkY9muZbYlXijWwd0V11oh++aJZtotVhAl91jxYWxLQ==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nF6wOXBm6A4ZGaJP85z3XtoYai+19f5oF6oMUaJ/3eyfKDtb3IwcUb4UsdGPV6MRzTCSHGuWwX3AzD8VW0R5c80xVU4sxrxfTD3aQO6l3N8Ug+/1hEjW6vtLQX0NJicIbpAgJ+vh+IizePP67Aj9BQh76hSO7YqoA9gfuAaXZAh24TBvQDo475UWD/oocertw9BUJxWnXUoinQ5IZcAPomk502gAaxYoRVi2muDuVLP5VV8A0WbHsgub7VCsE+07aq0U/ssDfBIps59YdsSxIAjaeI8AkmxwMv5LoRVRSLO1fy22ol2koAHjG4evCPKfeCbuna76954l1H3F11JQsywwWeF02you9ALxT3wCzqwxaciUuB5336R872LiSRtGmXED80NbTHhIzYvk/kIXN5vAEQrA9S+W/vFUMAz4epiwqzSZ/Htka788IwhGLeeo
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 16:29:53.6748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a6aea7f-6131-4c92-2359-08de89c29447
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B89.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR07MB11372
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
requested. Packets exceeding single mbuf size are dropped if
scatter is not enabled. Allocation failures during chaining
increment rx_nombuf. Oversized drops increment rx_dropped_pkts.

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
v6:
- Use uint32_t for pkt_len and scatter data_len to match tp_snaplen
  type __u32. (Stephen Hemminger)
- Increment rx_nombuf on scatter alloc failure instead of
  rx_dropped_pkts. (Stephen Hemminger)
- Set m->data_off = 0 directly instead of rte_pktmbuf_prepend
  sequence for chained segments. (Stephen Hemminger)

v5:
- Rebased on main (26.03-rc2), removed Depends-on
- Extracted scatter into eth_af_packet_rx_scatter() helper

v4:
- Added scatter validation in rx_queue_setup
- Fixed control flow: goto instead of continue in scatter loop
- Moved frame release to common label to prevent use-after-free

v3:
- Conditional scatter based on RTE_ETH_RX_OFFLOAD_SCATTER
- Removed headroom from chained segments

v2:
- Fixed goto label to properly exit outer loop on alloc failure
- Changed bufs indexing from [i] to [num_rx]
 doc/guides/rel_notes/release_26_03.rst    |  5 ++
 drivers/net/af_packet/rte_eth_af_packet.c | 95 ++++++++++++++++++-----
 2 files changed, 80 insertions(+), 20 deletions(-)

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
index e132dc387b..0ee94e71ea 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -56,6 +56,7 @@ struct __rte_cache_aligned pkt_rx_queue {
 	uint16_t in_port;
 	uint8_t vlan_strip;
 	uint8_t timestamp_offloading;
+	uint8_t scatter_enabled;
 
 	volatile unsigned long rx_pkts;
 	volatile unsigned long rx_bytes;
@@ -120,6 +121,44 @@ RTE_LOG_REGISTER_DEFAULT(af_packet_logtype, NOTICE);
 	RTE_LOG_LINE(level, AFPACKET, "%s(): " fmt ":%s", __func__, \
 		## __VA_ARGS__, strerror(errno))
 
+/*
+ * Copy packet data into chained mbufs when it exceeds single mbuf tailroom.
+ * Returns 0 on success, -1 on mbuf allocation failure.
+ */
+static int
+eth_af_packet_rx_scatter(struct rte_mempool *mb_pool, struct rte_mbuf *mbuf,
+		const uint8_t *data, uint32_t data_len)
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
+		m->data_off = 0;
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
@@ -131,6 +170,7 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 	uint16_t num_rx = 0;
 	unsigned long num_rx_bytes = 0;
 	unsigned int framecount, framenum;
+	uint32_t pkt_len;
 
 	if (unlikely(nb_pkts == 0))
 		return 0;
@@ -154,20 +194,29 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
+				pkt_q->rx_nombuf++;
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
@@ -188,16 +237,18 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
@@ -412,7 +463,8 @@ eth_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
-		RTE_ETH_RX_OFFLOAD_TIMESTAMP;
+		RTE_ETH_RX_OFFLOAD_TIMESTAMP |
+		RTE_ETH_RX_OFFLOAD_SCATTER;
 
 	return 0;
 }
@@ -579,26 +631,29 @@ eth_rx_queue_setup(struct rte_eth_dev *dev,
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

