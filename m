Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F82DCFC536
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Nov 2025 15:52:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 67DFA402E4;
	Sat, 22 Nov 2025 16:52:20 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011025.outbound.protection.outlook.com [52.101.62.25])
 by mails.dpdk.org (Postfix) with ESMTP id 5322040269;
 Sat, 22 Nov 2025 16:52:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RpAg3BwZH7qxiBsXoWe5c2ulzKK0eQFoAmqCFWq58Ufvd3nLngQYiT73tS2JGUyZGHUVUKBFy4txP6nOwrb3Ytn6t69/to5VeGax3ntODbHtNz5I54VRQuTHbYwmr5vd4oGAyZKJsq1FsbRIXaMAIrXmmiJ7/FUSU2KiIsmgoX9bV5Q9QmiA0kgAnQbSOs6848fGj5FpQiESUTHh9JPc9EYS7aqsVHee1L+er/WiEn9OQrvKpIGAETtLbjDBZWL6u4bO87q76tzudqYsDdP+t5o8ZGgPbZHgpS1DyTBlo7IkeQC4QKpmtPF5enQs4B2KaM2pn1CcZxe6rFZHPaM/eA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qYK4j9KPbCoJRf0zhsP0e+42DkHqC3xBssYu/BPGFpA=;
 b=sskq9RMlyurSXjjiOJzK+iJr9BdnCM5n0dW9wOdlsiAcOk5KWPORwKfbb0SA31hQlhTp4CplVkStbTTgzJR+tuUXaHfQ6h9Go3ZrP++ljOvdFHWBCzNuf7/ePFuHJ/odPIguWaPwpH/14dp/9dhr8hpw019oy9rtd4cWC4CsJKLrgL9d6dheEpH+S7Iv3+KM3qtAP5P1owh8OO8k8ynL4BqrFXxdI7GlhNvpsgz3sDTn1BFpDcFS++baNlUI3HGk0M5s1A3ukSbysjAchx573w/xhXQghPcGKhgQbfe2h11h/vyImPEQns5lA7asBu1gzjsdzz23FH7zCm1Hxjqrzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=monjalon.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qYK4j9KPbCoJRf0zhsP0e+42DkHqC3xBssYu/BPGFpA=;
 b=A4qbdAIq7Hegw0ceRfWOf4zeyLwW+Ud7NYQAa5O2dAJ2sTa58SOP+jc4ylP2OFwUPeoVtD3CUlsVmsqUw01xFWS1zbtq2wmwe+yC17xrB+HQ1oiDsTGhTTrkUVMDX6TniuIPHGT1W5DFd5L/aoheclGZQz2rdV4ySlrdmGavl3k=
Received: from BYAPR08CA0024.namprd08.prod.outlook.com (2603:10b6:a03:100::37)
 by DM4PR12MB6373.namprd12.prod.outlook.com (2603:10b6:8:a4::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.15; Sat, 22 Nov 2025 15:52:13 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:a03:100:cafe::6f) by BYAPR08CA0024.outlook.office365.com
 (2603:10b6:a03:100::37) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.15 via Frontend Transport; Sat,
 22 Nov 2025 15:52:12 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.0 via Frontend Transport; Sat, 22 Nov 2025 15:52:13 +0000
Received: from epycpwr02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 22 Nov
 2025 09:52:08 -0600
From: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>, <ndabilpuram@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v2 2/5] examples/l3fwd: remove redundant Tx queue limit
Date: Sat, 22 Nov 2025 15:51:53 +0000
Message-ID: <20251122155156.1385975-2-sivaprasad.tummala@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251122155156.1385975-1-sivaprasad.tummala@amd.com>
References: <20250901154400.2333310-1-sivaprasad.tummala@amd.com>
 <20251122155156.1385975-1-sivaprasad.tummala@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|DM4PR12MB6373:EE_
X-MS-Office365-Filtering-Correlation-Id: 5acefbf8-5717-4f45-1d51-08de29df1a76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5hPbcP3BX9SAiiJCngnJfPnmaxppWlERL56y6pT4efyCqkgmWG99LFDSKCDw?=
 =?us-ascii?Q?TNXV78Xhex43/fpzHp88tXWHGyPD66yeFsI1GK8gVSd2VKhWz8PnSoo8uzql?=
 =?us-ascii?Q?Hd1K/IBez9Bjull6eklGKkacT9wq8z5uUGIrfNktuvStK5j56KVSTTi0SK8x?=
 =?us-ascii?Q?g0kdz7Gvk4l1mGJvJxoK6d4NBV5S3DNm7qzb5pSNdUuBneNJ6DauN6GlW+JQ?=
 =?us-ascii?Q?Gwliq0JX/XV6HeJKqXwKSjwYNdpnkpJg5HWl7hhPARDGSB8/VQoc+h8izGpH?=
 =?us-ascii?Q?8ONRKpLlOPVhLo3+SF2vS6DANGQV6OGkCMLk7wNYqxywOzjc8MWpiA6LG6jn?=
 =?us-ascii?Q?mtEwbib0s6VsU34cAINfP18DqrMidZv3mOi5GjrYdaP6d68F9kK/Nn7jSnBO?=
 =?us-ascii?Q?Ntl0Sn5AboX9ll4qFsiK4ydQD2ETGQu/NJP1j2IdLQ6BoIBR01iqFWfH6V8f?=
 =?us-ascii?Q?UAdDhVZJw+AQp8qWU5XMnr7SB5bwqzVnQNHnK8Uo2GCHt1YwjL5uqa8pEejr?=
 =?us-ascii?Q?k6N4n/EBxHVp+MkFGO/rb5MGKfzfMS4EZqtqfdes96HS11PnU/M45BwHrAEC?=
 =?us-ascii?Q?mfUYi54oB2IE5XxZXIjxkFK/IxKlLXa2pgzVYLoDs5WzTImbMDuXJRL2qx2P?=
 =?us-ascii?Q?eKZ4XPlPO3LzMQtsycl4xBpoC1wmRNDgDeF/qHqANQBEOeknuMI0ORna76YY?=
 =?us-ascii?Q?ktJJjLSZdGWRQy1esV067MdkgsCwtiOwA5vnBhNLqwSFCjh9jr/k+rGhoWrM?=
 =?us-ascii?Q?oR9Vg8+MBRq0VnGEneeCu69lHecQ+417Ttp95lPP7VClB9cu3DOM3uDgi9m3?=
 =?us-ascii?Q?r1hCh7TwEEGtLJDF0NjAkMKhzdOmZ86yLNChAMp1oSvmdllwVMFvEN86FPIw?=
 =?us-ascii?Q?e1GwvK4lP1AfZB9RxvKAyXRdQTydP1td0PqgTfWv1BYx1SmdfTFizzF/Hq+M?=
 =?us-ascii?Q?qWpLRFcmRLF7IqSrClawc89gXf4o1AvlFJVKZl1a5alCOelte6qgiQpCAGRh?=
 =?us-ascii?Q?/m83z0nRqpQZqfYBER1J/NZO2Ng3rN5YpbGKqa4SFe2puXtvoC25XLCMWh23?=
 =?us-ascii?Q?vMQjBAD6qLsORRzjVq8CZ4XvSGmcSLIJgH/+7WYm0gTYKHaM1QNpx3laA4JB?=
 =?us-ascii?Q?mVUqF+g3/spjo176eiTPXAzf01hRwh9Zm4Rzj1hb7RxA+InWaeG+uqVFQbMw?=
 =?us-ascii?Q?vZAngtKYK+eYoTmmkYd1BikfJR4D2zV6WA8ghgmy27tX7AOwi3tXyRt6lg+Z?=
 =?us-ascii?Q?jWpOS+suFwK9xaFAA05ccCLXgy0PBb6A4Mw+tBMGOJ1ykNH/G0IJTnH8ULAJ?=
 =?us-ascii?Q?PqWH5al/1Mn3w4yUX9hvBwYrnGwVy5LmI4/4p+dnC1AInmzQHu4V+vSXSVbS?=
 =?us-ascii?Q?uHEQjfGFH3B/L9q9z6yaU20Tax1rCWz6Vp/pRLUkCRUbPcQOvXNbwjEKvZa6?=
 =?us-ascii?Q?3Hv3prTC6NTTpFc2WEAoF2S8ULboRVKNpHM/vJjVQanzBCq1BVPaLPetkIcw?=
 =?us-ascii?Q?SHH7/0yWOn66Ow4d/xLlsm3X3NXC2byJrAkW/4b6T90jU848hIaoSf97JsGm?=
 =?us-ascii?Q?3rPggM2Jtfypte32R6o=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 15:52:13.0244 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5acefbf8-5717-4f45-1d51-08de29df1a76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6373
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

In `l3fwd` application, Tx queues are configured per lcore
to enable a lockless design and achieve optimal performance.

The `MAX_TX_QUEUE_PER_PORT` macro, defined as `RTE_MAX_ETHPORTS`,
introduced an artificial constraint on the number of Tx queues
and limited core-scaling performance.

This patch removes the unused `MAX_TX_QUEUE_PER_PORT` macro and
redundant Tx queue check, allowing Tx queues to scale directly
with the no. of lcores.

Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
---
 examples/l3fwd/main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/examples/l3fwd/main.c b/examples/l3fwd/main.c
index ae3b4f6439..bdf59b5399 100644
--- a/examples/l3fwd/main.c
+++ b/examples/l3fwd/main.c
@@ -49,7 +49,6 @@
 #include "l3fwd_event.h"
 #include "l3fwd_route.h"
 
-#define MAX_TX_QUEUE_PER_PORT RTE_MAX_LCORE
 #define MAX_RX_QUEUE_PER_PORT 128
 
 #define MAX_LCORE_PARAMS 1024
@@ -1341,8 +1340,6 @@ l3fwd_poll_resource_setup(void)
 
 		nb_rx_queue = get_port_n_rx_queues(portid);
 		n_tx_queue = nb_lcores;
-		if (n_tx_queue > MAX_TX_QUEUE_PER_PORT)
-			n_tx_queue = MAX_TX_QUEUE_PER_PORT;
 		printf("Creating queues: nb_rxq=%d nb_txq=%u... ",
 			nb_rx_queue, (unsigned)n_tx_queue );
 
-- 
2.43.0

