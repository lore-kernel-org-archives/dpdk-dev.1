Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC15AF53D69
	for <dpdk-dev@archiver.kernel.org>; Mon, 16 Mar 2026 15:59:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1C3B14065A;
	Mon, 16 Mar 2026 16:59:25 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012056.outbound.protection.outlook.com [52.101.66.56])
 by mails.dpdk.org (Postfix) with ESMTP id 8FB92400D5;
 Mon, 16 Mar 2026 16:59:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L2w4ZKajHN9Cl7fTEYBAcIsOQKsVhbUmerGlEpvsm+kx4gxUKllcksPf+w8I4QimYX8JxGU/2aoHGpuI/2669ZynR6eRVpMOnd44p74cEGPH7jsWa3SaMvD/YV4A4J+e0IYs8gVZWSdONL9fC5AkdtEGq8syszDu4/jFEHiExmvl35uouZ16Uf88n3dEw+Xr7ymDiu1RefOk75nOrh0F5MYv1w9c2LGvquyYA9nDislhIlpNX6X/hZkPa04IrOFXW88ErzcBYQww6iB28rCXLpq700pdVr4q5DiD//k1H9DZ8N9kWbAVL7WVkXMaYum9IalT6ILnNycaHEo5T5E4Ww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yFOa6P3U1OLHrf8r0Yyc0EHfOofBxB7VToVbhidvs3A=;
 b=Yo0aeXeP6sL+bcOCoPl8deEVZp3DrZP9Nd5ZVEv04bPTFT2VHniTyHPUkBTSJUK2JJGlJcxWhMwFsAcdgxcB57hI2yMYRhsFqw8ezT/VVHgEvTeWcXXJA/2y9FOaK9XWqe8oRVRGL7GB5vKo9p9i8cHBmaS6l4+xzNoYzGobBDPg+00xYGKNwVaKkw0/otSR5DXzNqIfBB6KciZ3cfej6gXB8zvdgFIsliKqYJLTFtXLAKDXmLXrsTV+5W+F7vUPO6HvMPrFz73nW65N4KIvRR5MigMOFcpt963fTwvISeMeNTYZZzfXp+VxEYBx43hsLd9UyTjfTUJYOs0F2MuMaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yFOa6P3U1OLHrf8r0Yyc0EHfOofBxB7VToVbhidvs3A=;
 b=ZmJ2R4ep9D98rAIfNRJq1So4PE8EvQFd0ZNyhFFZa58fzVGkuFzZHXtuwvZWQFyz3MyNQe0SFgMRkH4Fl5HWBaV6fE9FP382TJ7FH4SErW0i6GS1uv1dflaCDrIzBvCQ1ftvyRB5Jluf6To1bYH/5s0ZoXWkXtB7BxQvsAJpP11+RpH2sD+VFUodmzuYjePkVXsRjSx5mdq/dx1D5oirDKp3BLxp4mwVlWCMORjKW9DFwvLj0GaOI7pb6VZTsuSrTLh1ua7Fhdl0xW7ViF/sx+2o9FIxV7xcmsN43hcbpKPBiNdgQVfgO4GZ+7g0q4yNX0gO3lshj/LYlZWj5bUITg==
Received: from DB3PR06CA0026.eurprd06.prod.outlook.com (2603:10a6:8:1::39) by
 DB9PR07MB9366.eurprd07.prod.outlook.com (2603:10a6:10:454::19) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.24; Mon, 16 Mar 2026 15:59:21 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:8:1:cafe::bc) by DB3PR06CA0026.outlook.office365.com
 (2603:10a6:8:1::39) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 15:59:20 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 15:59:21 +0000
Received: from seliius19697.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.64) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Mon, 16 Mar 2026 16:59:20 +0100
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19697.seli.gic.ericsson.se (Postfix) with ESMTP id 6F6A34020B41;
 Mon, 16 Mar 2026 16:59:20 +0100 (CET)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id 55EAA62E096C; Mon, 16 Mar 2026 16:59:20 +0100 (CET)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: <jgrajcia@cisco.com>, <stable@dpdk.org>, <bly454@gmail.com>, "Sriram
 Yagnaraman" <sriram.yagnaraman@ericsson.com>
Subject: [PATCH] net/memif: fix multi-segment RX data corruption and truncation
Date: Mon, 16 Mar 2026 16:59:18 +0100
Message-ID: <20260316155918.3756017-1-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|DB9PR07MB9366:EE_
X-MS-Office365-Filtering-Correlation-Id: 9f5813db-9c8e-44f6-1913-08de8374fcc5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: mpyGF6+DvLKNf//Bv3yFCi3YMScfTikGtSGuLzlcFD78OYg6wOYy/sWzbKtibIa8AmxOmESfo8IddfACM/opebvjImao6Hk6pCQclKVYOPUj/GsH9aNTHY+VSZ7NH0Tq+j+zEnALAbS9ovXVMlH5IUtbHuszTaHYvB0X5Y5Bs5RhJ6BoxMoILFEU86HqYJrwqHLu867S5T89rPAHl39VcVPQ7IJNKAyhd2xli44ttD244UNYQNN+a3HPq0iQcMYNMwx/8m7jfXwvsHqu0o0R7mMWgsbuaukA/d/4t5vmW+LTt4Lf+waF4KpnrlYjcCvQT6XS3q4f25/IfYRb7nVPRnhGAexxsNMCgQato4UN4YK44hYI2PbJYeuVrAq+AiQ7zFdg1qoAU9f4HDIHlsFKHwefpwxIzpkaIwnoeZMSCIDeEbPW/8rFdye4CSPJoNiFuTP3Enc9AHH6cU75LvmCQwKN3S0C/F/eWW+thPBJKgtZR99dYzEqNdb14sbuSNyY/Kg5zhJfJqHzXuonPjpE+R28byb5JrFM7abgwwz+ZQHD7xAzC+gQKfh2qW8jNbmNX3pCi5BTNwo2br5j9O2IqPNq/gKFSflaXCgbfHYUoGv1J6Z4cNZv4Nv1FMIiV95Li1FUMACCQzyffyDlQLVON0YWjs/cMjfeXxw6LuE6NNDpwVQn4fKMI5qKfwA6keNjJcSTZ00KoEjsv+ywT0rhYW3+607yYE2keTr7uXu2UWh8NoSszhkhNCc11uJzMnD6gKnOCe0z8xkb2tYwhEceiQ==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nf/2lrZCpBqWDNJeXh0YMquFLGc23EbVf6mWVmnhQxNS1rxKf8/6dj8NBCLhxDMzYo9a/r1scY4a3DrjW9zyfrTrVnMZo7GDaVITx2tl3iQaRwPjN42fut9bhULSa6OvuQejd9XADxkxzXEChfm/8zyrgUeYEx3EvtdpibIAMgc+0GlsyqKZMslGa7c1egDggI2f2XXxLZZ5NqOdLcb51EWiVbIZ0tRETqZKoazwY4ZDRVCPWb1MuON6RUV1/indPFes2rmH5Phl95QGZvVAws9IZTB8d+977byTOCJnjlsGnxaLRJzx7kZYeIcPescWhNrnHXdLuW/yUVhBCG8/tZtiwkju5AfxU1HbN4Gq7HJpCSwYbCauZIvTqeV8rIcsEljrapOu9IlTIRiS6yhMaJhi9FnPef6BfbjNQTe3FVub2lFL9Anow96ufhXcYdaG
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 15:59:21.2542 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9f5813db-9c8e-44f6-1913-08de8374fcc5
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR07MB9366
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

Fix dst_off being reset per-descriptor instead of per-packet in the RX
slow path. When processing chained descriptors (MEMIF_DESC_FLAG_NEXT),
goto next_slot2 reset dst_off to 0, overwriting the beginning of the
current mbuf with data from subsequent descriptors. Move dst_off
initialization before the next_slot2 label so it is only reset once
per packet.

Add boundary check in both RX paths before processing next segment.
If MEMIF_DESC_FLAG_NEXT is set but n_slots is 0, free the incomplete
mbuf chain and exit gracefully to prevent reading beyond available
descriptors.

Bugzilla ID: 1609
Fixes: aa17df860891 ("net/memif: add a Rx fast path")
Cc: stable@dpdk.org

Reported-by: Mike Bly <bly454@gmail.com>
Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 drivers/net/memif/rte_eth_memif.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index 0002e24..cef1b0d 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -376,6 +376,13 @@ eth_memif_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			n_slots--;
 
 			if (d0->flags & MEMIF_DESC_FLAG_NEXT) {
+				if (unlikely(n_slots == 0)) {
+					MIF_LOG(ERR, "Truncated packet: NEXT flag set but no more slots");
+					rte_pktmbuf_free(mbuf_head);
+					rte_pktmbuf_free_bulk(mbufs + rx_pkts,
+							MAX_PKT_BURST - rx_pkts);
+					goto no_free_bufs;
+				}
 				mbuf_tail = mbuf;
 				mbuf = rte_pktmbuf_alloc(mq->mempool);
 				if (unlikely(mbuf == NULL)) {
@@ -414,13 +421,13 @@ eth_memif_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 				goto no_free_bufs;
 			mbuf = mbuf_head;
 			mbuf->port = mq->in_port;
+			dst_off = 0;
 
 next_slot2:
 			s0 = cur_slot & mask;
 			d0 = &ring->desc[s0];
 
 			src_len = d0->length;
-			dst_off = 0;
 			src_off = 0;
 
 			do {
@@ -462,8 +469,14 @@ eth_memif_rx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			cur_slot++;
 			n_slots--;
 
-			if (d0->flags & MEMIF_DESC_FLAG_NEXT)
+			if (d0->flags & MEMIF_DESC_FLAG_NEXT) {
+				if (unlikely(n_slots == 0)) {
+					MIF_LOG(ERR, "Truncated packet: NEXT flag set but no more slots");
+					rte_pktmbuf_free(mbuf_head);
+					goto no_free_bufs;
+				}
 				goto next_slot2;
+			}
 
 			mq->n_bytes += rte_pktmbuf_pkt_len(mbuf_head);
 			*bufs++ = mbuf_head;
-- 
2.43.7

