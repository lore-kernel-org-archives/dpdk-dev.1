Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 563DBFCA187
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Mar 2026 21:02:47 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76F4D40269;
	Mon,  9 Mar 2026 22:02:46 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013035.outbound.protection.outlook.com [40.107.159.35])
 by mails.dpdk.org (Postfix) with ESMTP id 4AD2740261
 for <dev@dpdk.org>; Mon,  9 Mar 2026 22:02:44 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j7uesOHxzktzt3ZdpIYSpl9EjKYY3ZlM8yuMPh43u+ndz9RTlwsFUv77CrR0v1flYl3uO2sCI1yGWdpZuHJX+s7p2saIivv0M0C+XNist1hg4bVhwM1ypDIPTE/ECVxPaAYkmUNQymzr68YctFP0q2z0yABMXexxx4hfIRFiYyhF0SEoLNRZcS99+k45rnVlw6+iR7k0nWruZYWICcXrDRneL3sV+KjrPV3JQOq2O+mxnJ3/ESlshrA8hUdeNLoswxsnjI9aAvfxm3XRjQoynRx3njE0syHVH3W2FDWwBf3l5tScuZ8Z5N0p5cuOnhtaHJwj/GfrIGV2Qw8sPLcsEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=juvVUGtZytyFokge3WptvNggK9GMdSxOilgOCDIt5jM=;
 b=lU6dkxilFU7mdQ3rtECe2clcJNyL2Y7PpKIqyZUc3R7rlFxzXrMZ6EwOjUu9+4QYMgA+pO3UVVFZnJysluvEgIDkdAmh+B6K2AyNAXO1kfBGu0X+lr5fNMWZ8UCIBQdhtzcZLpsioZbI8BEAXCxejoy51sjwk7hp7EnFuG9g4iitf2IxfZ3wJbIZ79PpEZbzhkKZ/Vw85MBYxJFUv1sF/L8ghbXowa7eNjXy9rz7y5OgdnJLUqwDnf387vqQIiY86PqOD4XkeSWkbb3y401hlrav8whdsRo2U5wrdOFbVZ7BvZNFoHR6aS2X92zoCRE+g/fDlbDapaVHI/qzoWstjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=juvVUGtZytyFokge3WptvNggK9GMdSxOilgOCDIt5jM=;
 b=GsGiNTifDG5+sqpo5LTngLzy6cqrN1Ugb4wWeO110l3/3NqDtHdct8ynklVmuXG3iBaIL31KK9K03EfoaWNEh/Qkae3ny/oTUhreo9DuaH7UDiTgWIQL0pZo/lK/kOWI3Q9xabRxyGYXkZT4L+oomW+W2DylkYrqP1ch5TWzUcTujoYMumsvNym2QaHMUpZrigZhAqZgGPrNPmzGOKTgkuCRDO1lD0GZ/qyYtka/piZ3q3P1cDT1tPvcqvIm3n49Ii9mPEdAPUwM49DQlbmKEIfkYcbKeMpnprbgGZ93wxpqN7En+7JjcZk0cC/60WY8X2SALf4quM2fUXKqxJenSw==
Received: from AS4P195CA0006.EURP195.PROD.OUTLOOK.COM (2603:10a6:20b:5e2::11)
 by DU4PR07MB10298.eurprd07.prod.outlook.com (2603:10a6:10:5ee::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9678.24; Mon, 9 Mar
 2026 21:02:41 +0000
Received: from AM1PEPF000252DA.eurprd07.prod.outlook.com
 (2603:10a6:20b:5e2:cafe::2b) by AS4P195CA0006.outlook.office365.com
 (2603:10a6:20b:5e2::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9678.25 via Frontend Transport; Mon,
 9 Mar 2026 21:02:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 AM1PEPF000252DA.mail.protection.outlook.com (10.167.16.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9678.18 via Frontend Transport; Mon, 9 Mar 2026 21:02:41 +0000
Received: from seliius19819.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.62) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 9 Mar 2026 22:02:41 +0100
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19819.seli.gic.ericsson.se (Postfix) with ESMTP id C71D04020AB6;
 Mon,  9 Mar 2026 22:02:40 +0100 (CET)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id ADE8C62B1399; Mon,  9 Mar 2026 22:02:40 +0100 (CET)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: <xavier.guillaume@ovhcloud.com>, <stephen@networkplumber.org>, "Sriram
 Yagnaraman" <sriram.yagnaraman@ericsson.com>
Subject: [PATCH v2] net/af_packet: add multi-segment mbuf support for jumbo
 frames
Date: Mon, 9 Mar 2026 22:02:10 +0100
Message-ID: <20260309210210.1665888-1-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260309204910.1657193-1-sriram.yagnaraman@ericsson.com>
References: <20260309204910.1657193-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM1PEPF000252DA:EE_|DU4PR07MB10298:EE_
X-MS-Office365-Filtering-Correlation-Id: ec69cd50-8dd3-4ff2-d23e-08de7e1f341f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700016; 
X-Microsoft-Antispam-Message-Info: 7+vB5I9B4uXizcf7yN7hJu1hCVaaBxMqumUaQMkdTKfSILuwsCOzOcYUVCV0Xp3CWcrsgC/j93wA0yksp/gqizUKEspH2SYmTy/2FBkSE9OCfMka5tVgoEw0RQTr0FHr3kpV/XfEWhuFYTfRFJjiZldtkbF3/7EENG8TVXzY50SkfZfnhBEqi+vvywl+sOkW4ArmbACuXppWWvfEOoa+e1VyyxFwwruvP/9xg625l0H49bkTUYUKWlUv/HaqARQ5nReYUB3mer89OIiTk4bVC3JAOj3saNx0lV7P5jOWwSfp+6lglgsZEmeDduXT0kmteW2aONKPEErpUsXK+eIVqrljvN4NaC+xga+K6iBYNjVjhwte/hpH+ONapZn9pZR3uX+8QgXD4mrOKf1vEAKmlsvXXn1TuF7Jict/s474XHZWwV1gXjP46HpJFDdeck5fCemQKK/nbZ5QjCXCs0sc0eDmhfH0EALn1lKfzQtWwHEEPMt7W7+mkXzOMArO3P/QHXYzKck2zc240PiVm2TQ9hf1YUF+giH5xY+nVZ/gHRowkfUv/opWZIZ6r8psgXrLdKyge9+Oipk2lq19LZf5sotw2Lq9saF383PZvukms4j4Qxisnu8++oZfSIYPoM9kw2+pupLAwsRQ+zOrcXQBbM27FYVl4BO0Pzdlm/dPCLXnnTBS5nNvozxX5nMCE98OXqTWiTaChJOP8onemWSDRZDMuA6vLmybTPSgLq4L/soEbK6dla/XW/47PemtvSodhlhATjv2m6Vf4MPAL134tA==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(82310400026)(36860700016);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: AkeEa2VT+W+LKci2iFafMDXw3g//pwQ+Gb+geqLBniMzuRHp6q6Y9go+5800LpwzdLrLJA3nx75vyajHtL5m0yudILKRjISJi27v8TthDTjwQIC2nfYi6XWw8wVBD5NMzTe7L68IA9XIegu3HeZCPLhWgM7b+WtaY0Fu/42aXeaUyXFkUXy1F8G5K8krT6SOYFaal0f57XHQVow5zP/dYRHiVurZm5OC7q6btJud1V+z8SHbl2nhoZFGbiLevPIGXNVkdSj03K3Ijx3Y9SbTwfTGeMLotKvq+4uYyfr8MfjBbvOBPPPQE90EqGmj9aCFYR10ZK42Fm/s522dPy3iyrUS2jhcX4bzoMDkjBrf690xzBqS34bVo0ecXQ6+wkIT4BmLSPxxP361gx+afvURuw5MT+FcccNfSEsoyluLsmM4U5/fyYThWOA/pOXmAL5M
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2026 21:02:41.6223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec69cd50-8dd3-4ff2-d23e-08de7e1f341f
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: AM1PEPF000252DA.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR07MB10298
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
- Silently drops packets on mbuf allocation failure

This allows receiving 9KB jumbo frames using standard 2KB mbufs,
chaining ~5 segments per jumbo packet. No need for custom mbuf
pools with large data room.

Advertises RTE_ETH_RX_OFFLOAD_SCATTER capability.

Depends-on: series-34567 ("net/af_packet: fix MTU handling and add
jumbo frame support")

Note: Implementation generated with AI assistance.

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 drivers/net/af_packet/rte_eth_af_packet.c | 55 ++++++++++++++++++-----
 1 file changed, 45 insertions(+), 10 deletions(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index d9fafd4..184d2c1 100644
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
@@ -148,10 +149,45 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
+				/* release frame and break from outer loop */
+				ppd->tp_status = TP_STATUS_KERNEL;
+				if (++framenum >= framecount)
+					framenum = 0;
+				goto next_pkt;
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
+		/* release incoming frame and advance ring buffer */
+		ppd->tp_status = TP_STATUS_KERNEL;
+		if (++framenum >= framecount)
+			framenum = 0;
+
+		rte_pktmbuf_pkt_len(mbuf) = pkt_len;
 
 		/* check for vlan info */
 		if (ppd->tp_status & TP_STATUS_VLAN_VALID) {
@@ -172,16 +208,14 @@ eth_af_packet_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
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
+next_pkt:
+		;
 	}
 	pkt_q->framenum = framenum;
 	pkt_q->rx_pkts += num_rx;
@@ -411,7 +445,8 @@ eth_dev_info(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
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

