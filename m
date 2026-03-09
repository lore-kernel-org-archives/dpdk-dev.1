Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C82DFCA188
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 20:49:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0163340269;
	Mon,  9 Mar 2026 21:49:19 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011039.outbound.protection.outlook.com [52.101.65.39])
 by mails.dpdk.org (Postfix) with ESMTP id 167E440261
 for <dev@dpdk.org>; Mon,  9 Mar 2026 21:49:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VlBOc4Tj+ws+O/2K9DK1KDSLbqx4jGplcxggmTBteJrsw373hG1cqO4jZboDCzRGl9PiDPxDJXcShYxtBSmVpOn+c/aTrj6bJfhiAsRGhUvG78KtY59hCoI4VTiHceNPtvb+tffM2OsDRCDyr8lDYcF2+G6UZPlzl/C+rUKdZ1KuCftrwkY9FQ1B8fAZClEF+MXUGNc9CBPwy2F6jdKiYbn7Jc86U7l6Rkb5lm3j/2B+RZZgFBFLRi3TDG8oGKLI7e+TDEJEGewZmatMblKGH1nWPKAkFEFAJavodqsVwjrDNwyk74dsH8kLTV9bvEyFd32eL9RtmgLD2kQ65XD32Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=X9gWWDewIOFTeXg1gporgtfKZ2t9m3Uupgq/j5fAQ08=;
 b=Sf7bn/Fdba25mFZQH5c/ZBOQvoNgcVd29NR3Rxc9tyDJKY2DRbD9P888K7UvSZorl/+sI9PZW1HR0sYrBmC05h8vZREkaGKPlhvsyqRD/xIX6RJqbSaW/lmAvXb/aAvuIdMnFHUjr4RGgueu2u6CzyayVoGend9zOmK4WbnE/ZZNRslJvBWjG6UPkOA6nE6A1aW0cJ+PKSwjMFp3bHjKJcYAnIm4fy7bqWl4I8d6l2cI/9m5NmWt0hCzneDf9L7MQgpEebxddYd6G886r7qEOdx9SNgL5Cx1oJXHqMVFm059D4hoqpaBMfThSu9YmhPB+8kNjefLCr2Qb1/4FqNoEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=X9gWWDewIOFTeXg1gporgtfKZ2t9m3Uupgq/j5fAQ08=;
 b=SLL64INBCS3A+WkJziMJhzWDcHQII4H4DAcZNjEM2gcRwkmWOGK4e/e63W46oVCw187V9FWOqs3MnEYcWpwY5HYqlOHpmPHTAkG7TjzBYfHgigQGmKT9zSBh7qMkncXO3M57ifcVsgHe8P5HFhAXVKdKGWDIZ2fnc1JHS89Zzu9NCvqInrQERHhqaQ4I1AhhKI1NfeYlV/oF0SscWqpGrs5yCvpONKf1lhlbkG93RQRoMMfKDOk2xofxKfu5mZ/sPmyz+57Swo3eXWCF6CxeAtGVceCju/JIQoYM0sKEhIJdnFlDr2VTCNyAGh+v1VqWjVRx9V4Jq2M296PZfpZ9vg==
Received: from DB9PR06CA0023.eurprd06.prod.outlook.com (2603:10a6:10:1db::28)
 by DB9PR07MB9128.eurprd07.prod.outlook.com (2603:10a6:10:3d4::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.23; Mon, 9 Mar
 2026 20:49:13 +0000
Received: from DB1PEPF000509E6.eurprd03.prod.outlook.com
 (2603:10a6:10:1db:cafe::62) by DB9PR06CA0023.outlook.office365.com
 (2603:10a6:10:1db::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.23 via Frontend Transport; Mon,
 9 Mar 2026 20:49:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB1PEPF000509E6.mail.protection.outlook.com (10.167.242.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Mon, 9 Mar 2026 20:49:13 +0000
Received: from seliius19697.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 9 Mar 2026 21:49:12 +0100
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19697.seli.gic.ericsson.se (Postfix) with ESMTP id 7D8E24020B41;
 Mon,  9 Mar 2026 21:49:12 +0100 (CET)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id 6579B616EA2C; Mon,  9 Mar 2026 21:49:12 +0100 (CET)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: <xavier.guillaume@ovhcloud.com>, <stephen@networkplumber.org>, "Sriram
 Yagnaraman" <sriram.yagnaraman@ericsson.com>
Subject: [PATCH] net/af_packet: add multi-segment mbuf support for jumbo frames
Date: Mon, 9 Mar 2026 21:49:10 +0100
Message-ID: <20260309204910.1657193-1-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260309161021.2790684-1-xavier.guillaume@ovhcloud.com>
References: <20260309161021.2790684-1-xavier.guillaume@ovhcloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E6:EE_|DB9PR07MB9128:EE_
X-MS-Office365-Filtering-Correlation-Id: 042caaa8-20ce-4f96-5139-08de7e1d524f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024; 
X-Microsoft-Antispam-Message-Info: 40+gr3fYk+pPlwwX18b877EgkTjGCSYuKyZtjQMwB0nKNAxTbRraY74l1PJTdc9PnLPnTdeWzORmtN2S7UC+Pg30uJFLNPNVT+0hoTGGXI8YAf/98s4gECqkUNlG1pCYsI+c++6W90ZIqSSRL5Ffm5hlJ6GovCAv48vN8VYqgpzb0gCa4DFY3J6hvNe4byWHo1pZ0N0R33MQpQ8BFG3QOAZX2wE2ndNatW/LFW0k+2Hai5Vq17WUOkjLyZVjg/el+itlxBOVka6Zjk7Wza/41JYSyKFtAc+ina6TjhQvosQQbWVNdSZfYz7MRBIgZOHS/XiwooFABrxGFZisGVF6Sg1yKy4lrEOW+8XdxmF+8mPABism3L7Kv2PpVHN12pvuOeRFwBsl5ItGZR4+hgeDNKmShquMffSgrmOQItSDSfDz1ZGegT15BuoV4PRpLh25M4LDqYQzryMigPtNL6P4EOjXxFHe4qfFJHHiPJpknKHJI07F5ga6pawUcQyUyF+a1MCdEyspDWB/xR2sW1JadLWaQs4QD+3g17wXGmQB6dcVzj8Gm/6ar0QBTwnusB7FM3i/OHsnLWhEIF3IbuwLIda5+Fwai6KxdAmhw38XSy1I3bfUmDKaNUKD9TMqN9/c4Chpcj2oX7J7NITdje8+Ze/R1IPRePQxUn1BH/xtFP+x6vcNKjAA0GJUssXi6kTLtlVkVBfhTxJi5bGufltVy5Px8yMx0qMAUoLM9609sn/RIaR+LWmZRYlLc1E1MQRG+kib9tKxOEtPwhcX/650Og==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: VA77Grpuzom4WeSRhkttOdf1y/RFpGrc8fUGj1+OT1B4FG7NdFg8olGnzByaKUl+xZD2X2Sq3FnuOP8zs5JBZ4VoPc801vxT4CZKyazX1bBhYZkSb+d439+oHWdJdKMjC+LX+e+/nG+LwY2JogN2jkfDDc1pMryIkAzQPOtI2I62NH9E5UVPrYnNV1T/ijP7Nipa7rlzv+WgxSLzWOXvSLl6dx/PL0lcKTA6tOeU4gkVJ0TpGG1EM+ezXKX4zYMBkAvBgYybQm9oYm8DZl6jjNSucTw6SOwJXsGUJ73hk6LC5CdfUp1S36ZudS0w6XkJSUUMiCZ4hgox6873xpEFlgtGAXB8aruMJwjYKWh34lzDsuHOM3SjJ5Xjwc0JVVD8Ljo3pe8Q1FhjHAhCdNqiiSyX25WS4DdZASy5gOp77rW0oRT8YyRSGvThJw/Z2zUR
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 20:49:13.2518 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 042caaa8-20ce-4f96-5139-08de7e1d524f
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509E6.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9128
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

The RX path now:
- Copies first segment up to mbuf tailroom
- Allocates and chains additional segments for remaining data
- Properly maintains nb_segs, next pointers, and pkt_len
- Drops packets only on mbuf allocation failure

This allows receiving 9KB jumbo frames using standard 2KB mbufs,
chaining ~5 segments per jumbo packet. No need for custom mbuf
pools with large data room.

Advertises RTE_ETH_RX_OFFLOAD_SCATTER capability.

Depends-on: series-34567 ("net/af_packet: fix MTU handling and add
jumbo frame support")

Note: Implementation generated with AI assistance.

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 drivers/net/af_packet/rte_eth_af_packet.c | 53 ++++++++++++++++++-----
 1 file changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index d9fafd4..a18bc41 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -121,12 +121,13 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
+	uint32_t pkt_len, data_len, remaining;
 
 	if (unlikely(nb_pkts == 0))
 		return 0;
@@ -148,10 +149,36 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		if (unlikely(mbuf == NULL))
 			break;
 
-		/* packet will fit in the mbuf, go ahead and receive it */
-		rte_pktmbuf_pkt_len(mbuf) = rte_pktmbuf_data_len(mbuf) = ppd->tp_snaplen;
+		pkt_len = ppd->tp_snaplen;
 		pbuf = (uint8_t *) ppd + ppd->tp_mac;
-		memcpy(rte_pktmbuf_mtod(mbuf, void *), pbuf, rte_pktmbuf_data_len(mbuf));
+
+		/* copy data to mbuf chain */
+		data_len = RTE_MIN(pkt_len, rte_pktmbuf_tailroom(mbuf));
+		memcpy(rte_pktmbuf_mtod(mbuf, void *), pbuf, data_len);
+		rte_pktmbuf_data_len(mbuf) = data_len;
+		remaining = pkt_len - data_len;
+		pbuf += data_len;
+		prev = mbuf;
+
+		while (remaining > 0) {
+			seg = rte_pktmbuf_alloc(pkt_q->mb_pool);
+			if (unlikely(seg == NULL)) {
+				rte_pktmbuf_free(mbuf);
+				goto drop;
+			}
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
+		}
+
+		rte_pktmbuf_pkt_len(mbuf) = pkt_len;
 
 		/* check for vlan info */
 		if (ppd->tp_status & TP_STATUS_VLAN_VALID) {
@@ -172,16 +199,21 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			mbuf->ol_flags |= timestamp_dynflag;
 		}
 
+drop:
 		/* release incoming frame and advance ring buffer */
 		ppd->tp_status = TP_STATUS_KERNEL;
 		if (++framenum >= framecount)
 			framenum = 0;
-		mbuf->port = pkt_q->in_port;
 
-		/* account for the receive frame */
-		bufs[i] = mbuf;
-		num_rx++;
-		num_rx_bytes += mbuf->pkt_len;
+		if (mbuf != NULL) {
+			mbuf->port = pkt_q->in_port;
+			/* account for the receive frame */
+			bufs[num_rx] = mbuf;
+			num_rx++;
+			num_rx_bytes += mbuf->pkt_len;
+		} else {
+			pkt_q->rx_dropped_pkts++;
+		}
 	}
 	pkt_q->framenum = framenum;
 	pkt_q->rx_pkts += num_rx;
@@ -411,7 +443,8 @@ eth_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 	dev_info->tx_offload_capa = RTE_ETH_TX_OFFLOAD_MULTI_SEGS |
 		RTE_ETH_TX_OFFLOAD_VLAN_INSERT;
 	dev_info->rx_offload_capa = RTE_ETH_RX_OFFLOAD_VLAN_STRIP |
-		RTE_ETH_RX_OFFLOAD_TIMESTAMP;
+		RTE_ETH_RX_OFFLOAD_TIMESTAMP |
+		RTE_ETH_RX_OFFLOAD_SCATTER;
 
 	return 0;
 }
-- 
2.43.7

