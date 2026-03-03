Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0611EC1427
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Mar 2026 11:02:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B1584402B0;
	Tue,  3 Mar 2026 12:02:00 +0100 (CET)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012054.outbound.protection.outlook.com [52.101.66.54])
 by mails.dpdk.org (Postfix) with ESMTP id CFA6740268;
 Tue,  3 Mar 2026 12:01:58 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OPpKpsqLdkWdJ/97R9OGFv+tA/18Ja9dxqhQPaTLGrcefPxYfRqNGg2565ebqt2HTLF0opBlIcBgIuprYWYWgFoSLe3JPBh23DZnEDfaDMA8bMWf7dTxTiyjWHm7IYg6rY/GT7zXYFT7bd7nxG2+gOBh5iH5SF42ioPeGEbuB6xgxokDuzZoHREi8yb3s58j3uHyRLEB3hM4MxK9O67ucvA59vELWDfAB/BFkKaM1aGmqxKGuoz2OrXPSweKASOw3i5iVxEqisoU3flpmiDg2zbV+vcznxxhoR9xEXdrctvskXbWn8tq1Gvj8gQS0qn6uwmh1kS2M2yd71RBiQQ90A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dU1B+OGetfTKmWiQYS+loLaEMMbyHA5pjs51NP3L3c0=;
 b=GROFPJIttLoogVAunIejr1zsPeup+6ypF1V1uW/qg1wT8t/iEPIe48c5bfCG0R/foV3dsOuLNdMfaKcgyplPSooIqnWzE3bW/oWD9k9mfE9WTnqOxd1EkkK7YsqHfyMCb2hSm33zfxRCAnlsxZX0Q3saLDBQdc3H+Ya57McAPiPjzZjfvaJr6nEd4+jrf9QFAWM304hV+y3iiQ+erVfvC60BKsw1Cs+X/l1nQK3uzsEJRExi7ZyvxB+IUSr4UTJgJI8LnoqG1RuHagiFm9vbn1ZSo6R2xB8P5HFVf8l5Dv44fbVg6jhODH1hUftQxl2+AYhN3SxjUZKy4Dr+XLkJnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=amd.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dU1B+OGetfTKmWiQYS+loLaEMMbyHA5pjs51NP3L3c0=;
 b=EpCpDlLL4xM0YVUCvvRX50Gb1bASTt6W0mp2YXrQbtwTILnYNZIGAjavMb+Hh8K3gO85LZTBavqf+am/zcgoKQV7/Bfwly/nwCFr9mbLHcIVXnfbl03llwF5e4B5G6o9HRdKnd858jy6BvlvHqSo5myyztzIA3qhT/YdngecZ9oRKoQ+kvwUHEeD0JijjDInyudKszDT1kN/6Ss9KNV6JSX6BiR0kygMv6xFkebfj9L4YtB6/GtFz8S+OfYhA5VRpl348WmAbWLx7XJqQ84+mk1Ogl2lyVxxEkG5VcsQJkJOQo+/B60tZ+iqsCui62BOeVJmbWC+mujMG+HyPfYguA==
Received: from DB3PR06CA0021.eurprd06.prod.outlook.com (2603:10a6:8:1::34) by
 AM9PR07MB7282.eurprd07.prod.outlook.com (2603:10a6:20b:2c6::9) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.22; Tue, 3 Mar 2026 11:01:57 +0000
Received: from DU2PEPF00028D13.eurprd03.prod.outlook.com
 (2603:10a6:8:1:cafe::c0) by DB3PR06CA0021.outlook.office365.com
 (2603:10a6:8:1::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9654.21 via Frontend Transport; Tue,
 3 Mar 2026 11:01:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DU2PEPF00028D13.mail.protection.outlook.com (10.167.242.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Tue, 3 Mar 2026 11:01:57 +0000
Received: from seliius19697.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.60) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Tue, 3 Mar 2026 12:01:56 +0100
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19697.seli.gic.ericsson.se (Postfix) with ESMTP id 792394020B42;
 Tue,  3 Mar 2026 12:01:55 +0100 (CET)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id 621656088854; Tue,  3 Mar 2026 12:01:55 +0100 (CET)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: <jgrajcia@cisco.com>, <ferruh.yigit@amd.com>, <stable@dpdk.org>,
 <mattias.ronnblom@ericsson.com>, <heng.wang@ericsson.com>,
 <ravi.kumar.chennaparapu@ericsson.com>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>
Subject: [PATCH] net/memif: fix descriptor flags corruption in multi-segment TX
Date: Tue, 3 Mar 2026 12:01:52 +0100
Message-ID: <20260303110152.276344-1-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D13:EE_|AM9PR07MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: fb1a26a6-b334-407c-9555-08de791449b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: EJaF/bVCMcpg8bsL6K/UfcmCX95DlG7R4SiteB4eGIGsNt9vwLqc/5WYDAdXyuhM3BU7pffe9KNpxOGQjTEO9FoNknvA/bzYrkxjyLHcPj9543Lt0sjKkJnfCfBqW5u/D3lgYgWKQU30K9RsPTVWfcl/mBwcaTMPViCyLQ/l0uvPP0C/UV8wDz/L0aUXLayFOh02qmj2TMvGEnkXhRETyQ3XU42xxFbpFIvm/uwGICWcdu02DW3/MUW5ifU2MfsXPwVhqOmIPNwrQGdu5si47+ZZ+VdSR8W1e2THABHsLltQUDL3JfEPrBvtC7Cl2nqYUtBzz7/209iL0iYN6XtHEQ/8fDTA5/8M1CSWqm5MS6UeWLixlXHM8fHj9lh6nCdmd5m6lrfKLCKZwUberoaP3qEJ6aMFHS1EivE5is46dbXBA94smk8g7CzM8lUSQnZhSaJNsPwv05vuD9yxoCvTlaUWXMP8cm1/J7ppCXEItrQ5WiYXPno5/UUv4AO1HxwHU2KqatYiCI9lSytC6fFZbnF+t0CiynHijYHIgwcv0XrloeFaTcB5Z3zHZimBaxRCZf36koVDaxmK50DeW6+maDqqKLQDffUdgeT/hZV0p8QDhCLKThTYZ6SyCoEwHcep+O0sYkffkN7xE9Ltz9BVTX8bol06H43vaBzI9WwGHYWSA22IGEDuO+f5ocJXkl353PQMvAKnYdojt+LwBHjMr/3sHJbFc9GSHjoX+mXJntQKCOs4sIOZ8d4TYM3N67NPD2VRAmydHB0nau5BeMKQ97tr43f8ICoVUycwAs6zt7KC82exEnJ7KbRDvnFTtiBTpFkFZ3iB1ZpOzDPmIQ3+SQ==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: uCKlf5e/BJMHWJJjU+gkKOXb07ur0xBMTb/s8VGcbRcF2kr+FkDP0oW+xHVAkky6g2XbvqWB3wYU3s/AA6Fgd7AZuhWF2yA/Nsu92tag4G2JlcNy887qlw6TlincvP6jJpwCdozrZDQ36nvz/nSgOnMXqc02W0wPa5Z/Jk2ickvoEZ973yVYw6FvGHE7qtTjjfkKbUDsrm4HcPtvLOKYJ+mC3haccCDjS1D31o9jcpyVYcyCV5DF98QYAsU0vfYZU5h1NS3YPZ6AaK2cZT2Oh26UiaiJmBXGFY6S08ANtV+BBeH0Uqi/hOCCXqnbc8OR+BTmgey+PyzjNhzZlGjjR0ks3UxmVmuh/v7xedtxV8+9nJZA1BD0cF59Qyc/p4G/VHQvZsqRXzr9/qUB2PbO3hJTVrzg4twf4Eju6pf/0nkGkV8oDhuJjaf8sA7Uo8d1
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2026 11:01:57.5054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fb1a26a6-b334-407c-9555-08de791449b0
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D13.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR07MB7282
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

The memif TX path was using |= to set descriptor flags, which could
leave stale flag bits from previous ring iterations. This caused
descriptor corruption when the ring wrapped around, leading to
malformed packet chains and RX failures.

Initialize d0->flags to 0 before setting MEMIF_DESC_FLAG_NEXT to
ensure clean descriptor state on each transmission.

Fixes: 43b815d88188 ("net/memif: support zero-copy slave")
Cc: stable@dpdk.org

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 drivers/net/memif/rte_eth_memif.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index 8d7060cd7c..effcee3721 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -714,6 +714,7 @@ eth_memif_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 next_in_chain1:
 			d0 = &ring->desc[slot & mask];
+			d0->flags = 0;
 			cp_len = rte_pktmbuf_data_len(mbuf);
 
 			rte_memcpy((uint8_t *)memif_get_buffer(proc_private, d0),
@@ -726,7 +727,7 @@ eth_memif_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 			if (--nb_segs > 0) {
 				if (n_free) {
-					d0->flags |= MEMIF_DESC_FLAG_NEXT;
+					d0->flags = MEMIF_DESC_FLAG_NEXT;
 					mbuf = mbuf->next;
 					goto next_in_chain1;
 				} else {
@@ -747,6 +748,7 @@ eth_memif_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 			saved_slot = slot;
 			d0 = &ring->desc[slot & mask];
+			d0->flags = 0;
 			dst_off = 0;
 			dst_len = (type == MEMIF_RING_C2S) ?
 				pmd->run.pkt_buffer_size : d0->length;
@@ -760,12 +762,12 @@ eth_memif_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 					if (n_free) {
 						slot++;
 						n_free--;
-						d0->flags |= MEMIF_DESC_FLAG_NEXT;
+						d0->flags = MEMIF_DESC_FLAG_NEXT;
 						d0 = &ring->desc[slot & mask];
+						d0->flags = 0;
 						dst_off = 0;
 						dst_len = (type == MEMIF_RING_C2S) ?
 						    pmd->run.pkt_buffer_size : d0->length;
-						d0->flags = 0;
 					} else {
 						slot = saved_slot;
 						goto no_free_slots;
-- 
2.43.7

