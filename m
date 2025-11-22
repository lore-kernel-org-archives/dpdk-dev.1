Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8793CCFC539
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Nov 2025 15:52:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 771B940655;
	Sat, 22 Nov 2025 16:52:25 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
 by mails.dpdk.org (Postfix) with ESMTP id F23904060B;
 Sat, 22 Nov 2025 16:52:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HSwJxcQGxDLFhkULnN/udmMCGSQw3FAo/Nw9fFln/h9vYyFDgdjRS337SC3+oV0Vq9Sxb5y6hGN3g1zReTl9dTWkfoH16f7nWrh825gyYMpz4uRSKs+1ffCs3KpEV2dQut3trQCdcaFGSmHJnXp77RyhGFQAPjItGcPZVEK/PUtPKUcTO5Jp/hp6APlOHyaFSZgecRjfigR9GTeVUWP6fFFpEndfaAIi0coSjA1f6o54cqV4dpd8fiiRLsv2lt1PN9mVXa0+prDIT7CP2BxwwqPWWnxdckwAZqEf1L2DkiWRU73vdBM3V80X7lh71hO5rcId4YMEz28+utB+aqgH3w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mQ8ZXQXppztyuFaxeMx21s5EiSLy7b48Et9+wzIk9pU=;
 b=j3bP+11BbuLn+FWb7tf8IMdDtrfPgUQFk0rspam03onCsyjL420dnM82YouZ+BYyXZJZIsrjIiK4LZ4em1X2lc/fwMh0gyUsBA+J49EEMI6DvmfOpni7o7QiqD460M90H0ctfKknica0lQIv97a2s1H9dsUOGzttPk2IyXHTS14Iquo8lGXcAnoY68adruEKDF37gKv9tO2xUm13ZQKvuE1Brqp/KoGBUvLTEydeNgS5PhzEMpk2p3ByeLCuV8IyfNDeRFZm2juQ5ykD6CWRxeCuJlaumvwfGte1+Z6gYGVzQiVhl6zUYkHvwJhXJn/RTikTNLNpMhsSm3JoyzOUEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=monjalon.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mQ8ZXQXppztyuFaxeMx21s5EiSLy7b48Et9+wzIk9pU=;
 b=sb6spsqn8KOZhKQuXCoLfiC2lXo6HVPr6Nd8bHFVAruPJ30w4mAbknZceRPpIUeTlYAHOuB1FTU+A4qBs9l/aA3vv7y4v69eu4xjlDykK2hKqaj8OfoTuKYm7nc9w+VwrmK+yK4t6UKAcXY8t+rRNqxM2R7KufNuHd09bwcwr6M=
Received: from BYAPR08CA0034.namprd08.prod.outlook.com (2603:10b6:a03:100::47)
 by IA0PPFF4B476A86.namprd12.prod.outlook.com
 (2603:10b6:20f:fc04::bea) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.15; Sat, 22 Nov
 2025 15:52:16 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:a03:100:cafe::8b) by BYAPR08CA0034.outlook.office365.com
 (2603:10b6:a03:100::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.14 via Frontend Transport; Sat,
 22 Nov 2025 15:52:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.0 via Frontend Transport; Sat, 22 Nov 2025 15:52:15 +0000
Received: from epycpwr02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 22 Nov
 2025 09:52:09 -0600
From: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
To: <thomas@monjalon.net>, Konstantin Ananyev <konstantin.ananyev@huawei.com>
CC: <dev@dpdk.org>, <ndabilpuram@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v2 4/5] examples/ip_reassembly: remove redundant Tx queue limit
Date: Sat, 22 Nov 2025 15:51:55 +0000
Message-ID: <20251122155156.1385975-4-sivaprasad.tummala@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|IA0PPFF4B476A86:EE_
X-MS-Office365-Filtering-Correlation-Id: 12e9c9da-5931-4649-293c-08de29df1bde
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NLi4UDtG+IBQEYBrqpDzfqBW/RX4DVucgWPbBcqHaaeDtXatZvHGt8WT4gyf?=
 =?us-ascii?Q?rigH4tKDfd4x+XDLy7JP+pz0EMotmZ0wdqvJ9eUy2fD9cj9n66BJZzM2Y+FK?=
 =?us-ascii?Q?QwxH6Vv3eb5yYavvMhenyAOYn7Z/hsB+hkRVXTXLLZ5CA9sGWBnjgmJHdtXq?=
 =?us-ascii?Q?X1E30i9ppTWz+SqfKReNJaRbN6KViZHXFi5HsXmhi9qK7cqC/310vBr8oCm7?=
 =?us-ascii?Q?EsXxGTJoK9jmRaRPM7E8TyyDFpKjWL7tqo00CL8sAOA/PxfqNVZv4i3IN2e+?=
 =?us-ascii?Q?1g7HJ9Fr9VC9kDZiyAsD8kaDt0Zu5bcZ0Ahk4vwWeXROGetv+i6CM8oy/0vN?=
 =?us-ascii?Q?RdqzMbIQAvmawCYlWVXbeww6XUFuxCV970/HGW3gGatXH2Pev4YixEvlN3Qo?=
 =?us-ascii?Q?NcX6OoqGkDDZ5MGWy7HnjzUBvSAlOS28fCeo96IG5Bs4MdyKYSjlDWVFWyuE?=
 =?us-ascii?Q?2BGtlztxsZUfxb2LRFxjSqVLtSVBRsGmT3hpk8f3pD58jjOVkvFXWP0fY6x6?=
 =?us-ascii?Q?i0fcQZSmDEToDDUc2PEwVKEEuyILy+0elXVq5km9CFH+avneXvX4hVBU2TZN?=
 =?us-ascii?Q?AEe9KBjz48GGwqHPDyF0b3Pju4dvUWRZicjeObNIcqteu9kWg/ZehS94/+gN?=
 =?us-ascii?Q?dzg3g1RehR4Y6KW1VhCYrH9hi3d2EMijXjSETM3rc8txiqtozGYp21dsAKyl?=
 =?us-ascii?Q?DeTo062Kgw2ySKZ0RbAEFfsU2vaQU3C/tIgvonTLEBSBv8B5LFaiZwwLEEWd?=
 =?us-ascii?Q?cagVgXvNAgX3hl7u6nA0oZu+HurLmmLpyIRuQIPGyWwaQZegREgs2JGPsRf/?=
 =?us-ascii?Q?NkHPf6p7PMi52SCcZzI5ngO0tUPHrlBvFuCWriR8lWkTowwDBhwCw0POM7nv?=
 =?us-ascii?Q?j4m5nepn+D+II4lnZTMy0caD2QoO6P3g8C2+QyPirm5duGMMI3PWYyUDHiYA?=
 =?us-ascii?Q?SNHrlolhppp9R6Qt7CESRpRnI8UfvDKxMloycDjZ+CyO9Ho8QeQMn6Qno7J5?=
 =?us-ascii?Q?rq+U15VZSek3VEFjwuImN13MMsxCgR60YjveOJe1rwXP/2nxjKY9FyhjQr4/?=
 =?us-ascii?Q?4wFaLDKQkyaoOvHKauzhYHedIAqj8cIqUMDRAWfRhnaMmjTljwmZVfYhzlMA?=
 =?us-ascii?Q?Dq+yKqERvkoYdpOR0EhuFIWsOjt6Ik0alKovPscG9gXajtuFdqxahIXjZ5G9?=
 =?us-ascii?Q?7nJodHyTpYfKKQk98yhi4A+9LCCZblh+9S7uKy+dyRhM+ZXCkhKJ9hBFKmBA?=
 =?us-ascii?Q?sCL9gYoLVXKpqaYMlRTxz2EFvsQgvCyQyRnOY5a/P33mqEbHoOzBTmwl5KUa?=
 =?us-ascii?Q?Aei5LDk8ScgbuweVpzMMJe4K0pQ6kE1QiVmO5NQC33ft+WCT0QmHNHcDX3CH?=
 =?us-ascii?Q?gNA32Jm+zs37yo6XqxmoW9KjR5Yryp7nxTf/Ag3M4mAHNBEIWy9YUt9OdFas?=
 =?us-ascii?Q?PyzoLP5rh4cmQIVCKCqD09CBmJpPpdVFPStsGozFX8+3TGDiv5S119rlrCK2?=
 =?us-ascii?Q?Uqp/Y9JEzU0YsikGJI87JccG5pJXzy+mtqB895MfQjI8A0c6ua1vEkB76oYq?=
 =?us-ascii?Q?T9t1aCgcePrAlNQCjpI=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 15:52:15.3845 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12e9c9da-5931-4649-293c-08de29df1bde
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PPFF4B476A86
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

In `ip_reassembly` application, Tx queues are configured per lcore
to enable a lockless design and achieve optimal performance.

The `MAX_TX_QUEUE_PER_PORT` macro, defined as `RTE_MAX_ETHPORTS`,
introduced an artificial constraint on the number of Tx queues
and limited core-scaling performance.

This patch removes the unused `MAX_TX_QUEUE_PER_PORT` macro and
redundant Tx queue check, allowing Tx queues to scale directly
with the no. of lcores.

Fixes: cc8f4d020c0b ("examples/ip_reassembly: initial import")
Cc: stable@dpdk.org

Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
---
 examples/ip_reassembly/main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/examples/ip_reassembly/main.c b/examples/ip_reassembly/main.c
index 17ae76d4ba..141a55462f 100644
--- a/examples/ip_reassembly/main.c
+++ b/examples/ip_reassembly/main.c
@@ -145,7 +145,6 @@ struct tx_lcore_stat {
 };
 
 #define MAX_RX_QUEUE_PER_LCORE 16
-#define MAX_TX_QUEUE_PER_PORT 16
 #define MAX_RX_QUEUE_PER_PORT 128
 
 struct __rte_cache_aligned lcore_queue_conf {
@@ -1091,8 +1090,6 @@ main(int argc, char **argv)
 		fflush(stdout);
 
 		n_tx_queue = nb_lcores;
-		if (n_tx_queue > MAX_TX_QUEUE_PER_PORT)
-			n_tx_queue = MAX_TX_QUEUE_PER_PORT;
 		if (dev_info.tx_offload_capa & RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE)
 			local_port_conf.txmode.offloads |=
 				RTE_ETH_TX_OFFLOAD_MBUF_FAST_FREE;
-- 
2.43.0

