Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B61E5C28B20
	for <dpdk-dev@archiver.kernel.org>; Fri, 28 Mar 2025 05:55:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E97D540273;
	Fri, 28 Mar 2025 06:55:17 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2075.outbound.protection.outlook.com [40.107.22.75])
 by mails.dpdk.org (Postfix) with ESMTP id 7ED7340261
 for <dev@dpdk.org>; Fri, 28 Mar 2025 06:55:16 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jNwX+BbF+ZGkAfwFtIwkS+yu62QvKTqwUGF0u7hz+Qtn/hwlMnB1gM+ukm3jwLWeH2+agN67Hh+S+o6JOlOOciEdOOJUdfkKn+JxCGEXc5UCNprdjPlqid/AgnZO8eK7ZKPETuInSKgXbQxxqk8x/Xeh2ETt+fJmaUsP85EbjGdDxM99yYtHQmDM2gMvmg2Qo5AbSQ44NbSMFv3cjZfJzgi0xKDco1nW4blrdzj18jGOyjojFIiPLzhh9pu4ixX//jZ/qPfC/8BQK9RKZFGCyAbjC9ykW9du7Ln9erDNNqVCl1wKgU+zyyXJ9XqTo1q5NeqtZyY6OBzkQCBO4dFi5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fSAb4vCrA/2O+k7gUPyPjSho24Q7cyW8/Q6Hr4lmzb4=;
 b=uwldVQwbStw5xCe478P62ckiWBtPdwwl1hiAYeIIjA2VsgcIWX6wSp5NjgWacOLRfhg0KVPkljQYnH+80S/6xfC6/0mCyDtLz3OBsJgU3ucXHyr+goFLktJ5XfozwoHdOQ6q1jOqh2CR3zeJ0HhfYL5GhgeAA2VKyzts0JqxVJVx+sm1knEr+3klo19RnQILIJXrO8CmU73Uv8LNFId0zTa/AZNSPth++ziETgmXAcDJd5940zeNg6FGRqcO2A3C1ypGSecq3FEkAv7boid6R+aRaGGQ5cLxjEcY/+0dYIZYliPjfarqi7XvG7lW/m40lU97V+1vIJ1ynuDd6GVpyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fSAb4vCrA/2O+k7gUPyPjSho24Q7cyW8/Q6Hr4lmzb4=;
 b=AkpIMLIV4xoR912JJ1iOqQVQ/dws3oCksmEtmIKm/xwGIMhuuSu1MO06ZNSRAa2Yc4U63d7S4MwU1qK/5gMbvn/Qx9sGcspm5aXK6sYFAVuPYLAN6TcQ3F78WlP2DYfESBhliafcagKgoJYnJGCgV4vk2Zc0kkl01+S5lrStaUEFysk4dK3WpgIkII+iy9PBPI42BCkBEigSwbzSA6fyYsTl8cej8CyLDqCPNO6Dl3VfoBZNJQ6+LHv7Bit8KAGtWBBv8Qc4mox5Q5fXQiNwjiOZa7kl9hctu/xzMvNhbUFc3XkESnCfeVSdKndmLm6v8POycTFlLR9CIEw2Dlfz7g==
Received: from DU2PR04CA0169.eurprd04.prod.outlook.com (2603:10a6:10:2b0::24)
 by PAWPR07MB10047.eurprd07.prod.outlook.com (2603:10a6:102:382::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8583.28; Fri, 28 Mar
 2025 05:55:14 +0000
Received: from DB1PEPF000509F2.eurprd02.prod.outlook.com
 (2603:10a6:10:2b0:cafe::f8) by DU2PR04CA0169.outlook.office365.com
 (2603:10a6:10:2b0::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.44 via Frontend Transport; Fri,
 28 Mar 2025 05:55:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DB1PEPF000509F2.mail.protection.outlook.com (10.167.242.148) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Fri, 28 Mar 2025 05:55:13 +0000
Received: from seliicinfr00049.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.61) with Microsoft SMTP Server
 id 15.2.1544.14; Fri, 28 Mar 2025 06:55:13 +0100
Received: from breslau.. (seliicwb00002.seli.gic.ericsson.se [10.156.25.100])
 by seliicinfr00049.seli.gic.ericsson.se (Postfix) with ESMTP id
 1A7B6380070; Fri, 28 Mar 2025 06:55:13 +0100 (CET)
From: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>
To: <dev@dpdk.org>
CC: =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <hofors@lysator.liu.se>, "Naga Harish
 K S V" <s.v.naga.harish.k@intel.com>, Jerin Jacob <jerinj@marvell.com>,
 =?UTF-8?q?Mattias=20R=C3=B6nnblom?= <mattias.ronnblom@ericsson.com>, "Peter
 Nilsson" <peter.j.nilsson@ericsson.com>
Subject: [PATCH] event/eth_tx: prefetch mbuf headers
Date: Fri, 28 Mar 2025 06:43:39 +0100
Message-ID: <20250328054339.489914-1-mattias.ronnblom@ericsson.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509F2:EE_|PAWPR07MB10047:EE_
X-MS-Office365-Filtering-Correlation-Id: d5eb97c2-3a36-4996-7f0a-08dd6dbd1bb7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?MVVSUEZJN1RFVGhSdWdaVkdPSUlJOStUbGFNdmdTWTlmRzV5cktvY1lJdHBi?=
 =?utf-8?B?OUJEVWVsUkt1amRKK3NmS3VRS3VYOW1aYUtGWW1LQ1ZwM3RuQTNYNUQvSDQw?=
 =?utf-8?B?WTFkS3dDaE5NODN1QW5yRmtwdVdGbC82Nm5aalN6UW9nbnoya3N0a25HaW12?=
 =?utf-8?B?LzZubklQRHBjekNTTVQ3SjF1bFBMWWxvRjJ4RHkvMEFqclF3cTJMQnd1YWlY?=
 =?utf-8?B?ZUgyUzc2RStSbXFXWFFzcmZGU0ZZTTF3TVUvOEh3SjhuUHRnS3pBdzFpaGVU?=
 =?utf-8?B?UEZaRkw1bG5iaS93OVhQOC8vTTNpbFdRV3JOSDRvVGliTG1VZGh5TGlnL3Qz?=
 =?utf-8?B?Y28vV0VnMjR0cExabktSTXlRQUgxdzNVUDVGMW1zcTNNNVlNcDkwMTUxSHlv?=
 =?utf-8?B?aG1vaWMwRGpCMkt2dGxmYk05NlF2dXBIaVBmemNZYldVUWo0aGhINEl2UDlo?=
 =?utf-8?B?dkFMMUpPOGNDbzdsZ1ZEOUlCODBnSENIb2R2d0JoT3FzRXprTGdNUVhEVmI1?=
 =?utf-8?B?WFhoRjdjWllicnhSRDVDd1lhT05HV0xhUVZwZnJaQjZNU1g5ZEtvREFnaU1V?=
 =?utf-8?B?ZXlmK1l6WnFYSmt6T1QvUXZpMzRVNFBCZzBxTWdNcklNVWZmakpNK3ZiMG1W?=
 =?utf-8?B?dUtPS0lZVEF1NGxNOU5KNE1TaE02VmRJR2hQNUZWQzgzT0JKYjZsdktLKzBV?=
 =?utf-8?B?RnVCUjdoQUxPNmVuTnBmeWJqdXlxWkhmWkdPemoxWnFMU210NTNxcWwrUHBu?=
 =?utf-8?B?WG5VbVl4bDBzV2l1N0JhM2picFpZT3NwMUR5NTN1L1pRVjZPVGpaUTlTdUJS?=
 =?utf-8?B?bW4zZkVZTGRTMDdiampZV3JuZEYyRkh4ekk2anZaNS9ad29yRE9vUDFWTU5Q?=
 =?utf-8?B?OWx5K2JFUFYwMllqWDEyNkFQYWZyZWcybjJzZUhqelR0UUdhR2lFY0RhRE9a?=
 =?utf-8?B?ZHBjZlgycmRzYUVhNkhuaDV3QjB1Tmp3MnJSN0xFYXNRTGpULzJKdzVERklG?=
 =?utf-8?B?RXdaWEtRY2lSUmNubFVpMWY5MTRHbVA3bU1pYlE4VGllRG9kQmxKWEVHQVJj?=
 =?utf-8?B?YzZnZUpPSVFyTHI1dVpoamxXalByTmJpWE9ycHhUUEZoanZXS3lYQVRqWTMy?=
 =?utf-8?B?NmNvak1wdTAwdjlZZlpCY0MrQjFWZnRhdzBTOEtaejIrK2tyOUZaSDFWb2hl?=
 =?utf-8?B?eGZZT3gxc1lNWDRmVFl5OGRCV2gzN21tTjJKZ2h4MW1pVThZbnVoajM2OFdl?=
 =?utf-8?B?dTB4OTVCSVZMMlo3RXhUWHEwRGZXay9NaFFQSDdiODlma1VRU3cySjNneEFY?=
 =?utf-8?B?Tm5GUno5Y28yL0pkNDJGd2gzYVUxMzNkS2ZCYkxaa2FSWmlVRVNYc2M5ZDd5?=
 =?utf-8?B?bE1iNHBGNDBlbFRRRy9Xa1BHYTBNaWsvS3NuVEUrRkhGQWNzMnJNN3dDaTM0?=
 =?utf-8?B?S0RnQ1RqeGRTU1hyV0kxTnh5U1h0aDlGeFFXWlRrRiszbENSeXRNbGY2QTdW?=
 =?utf-8?B?MXNYSkdtLzlZQmt0YmhpUEVqQ3FZaHFVa0trcW1ZOCtrbkkwNFdaT0tZUzZQ?=
 =?utf-8?B?NXZxb2ZPWW9yQ1BaREI1ZUhheEg3T1RJL1ZYQ2d3NXpYNXJqcXR4cGpxM0Fk?=
 =?utf-8?B?b1dBcjA0NEM4UktzZ3RyNHhDR1NBQmJTeWlWaW1QZW51d1hSeS8rMEwzb3Yy?=
 =?utf-8?B?dFh3MDltNEgyUzRZem9ERmpMQm9VOGNUR2ZTYVJPOERpQnpQSXl2S25Nblhx?=
 =?utf-8?B?YjZyNE9iWVZFL0YzZDVUQ2NOZXRkSS9EWSs3dTNwelM5T1dSN0ROSzlld1NZ?=
 =?utf-8?B?WDlRaE5Mc1ZicnphSUNXUmhoZnRzWTVtSTdRSy9kTWVkclFjKytFTFg4alRi?=
 =?utf-8?B?ejhsU2lhQzEyd3RiM3RXZXZpSDJBUEczV3BsZjRlbEc5RTFtSzJSbWwySnRZ?=
 =?utf-8?B?ZWdYY1R5K0plSHhtVlBTdCtOMjZhL0p6RVBTZ2VBTURwRVY3UXhlVnVnMHhU?=
 =?utf-8?B?eGJBYThiZWNLZTBBSHBXN1pMTXV5VUdYdFdWUktqUENFYUxnckdYUkZVejVC?=
 =?utf-8?Q?7vavWA?=
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2025 05:55:13.6954 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d5eb97c2-3a36-4996-7f0a-08dd6dbd1bb7
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DB1PEPF000509F2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAWPR07MB10047
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

Prefetch mbuf headers, resulting in ~10% throughput improvement when
the Ethernet RX and TX Adapters are hosted on the same core (likely
~2x in case a dedicated TX core is used).

Signed-off-by: Mattias Rönnblom <mattias.ronnblom@ericsson.com>
Tested-by: Peter Nilsson <peter.j.nilsson@ericsson.com>
---
 lib/eventdev/rte_event_eth_tx_adapter.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/lib/eventdev/rte_event_eth_tx_adapter.c b/lib/eventdev/rte_event_eth_tx_adapter.c
index 67fff8b7d6..d740ae00f9 100644
--- a/lib/eventdev/rte_event_eth_tx_adapter.c
+++ b/lib/eventdev/rte_event_eth_tx_adapter.c
@@ -598,6 +598,12 @@ txa_process_event_vector(struct txa_service_data *txa,
 	return nb_tx;
 }
 
+static inline void
+txa_prefetch_mbuf(struct rte_mbuf *mbuf)
+{
+	rte_mbuf_prefetch_part1(mbuf);
+}
+
 static void
 txa_service_tx(struct txa_service_data *txa, struct rte_event *ev,
 	uint32_t n)
@@ -608,6 +614,20 @@ txa_service_tx(struct txa_service_data *txa, struct rte_event *ev,
 
 	stats = &txa->stats;
 
+	for (i = 0; i < n; i++) {
+		struct rte_event *event = &ev[i];
+
+		if (unlikely(event->event_type & RTE_EVENT_TYPE_VECTOR)) {
+			struct rte_event_vector *vec = event->vec;
+			struct rte_mbuf **mbufs = vec->mbufs;
+			uint32_t k;
+
+			for (k = 0; k < vec->nb_elem; k++)
+				txa_prefetch_mbuf(mbufs[k]);
+		} else
+			txa_prefetch_mbuf(event->mbuf);
+	}
+
 	nb_tx = 0;
 	for (i = 0; i < n; i++) {
 		uint16_t port;
-- 
2.43.0

