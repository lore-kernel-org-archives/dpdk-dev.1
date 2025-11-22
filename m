Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08B6BCFC539
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Nov 2025 15:52:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D273D40608;
	Sat, 22 Nov 2025 16:52:23 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012049.outbound.protection.outlook.com [40.107.209.49])
 by mails.dpdk.org (Postfix) with ESMTP id C3AAA4042F;
 Sat, 22 Nov 2025 16:52:22 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gFsrIh0dbDISqs5ISHIXngbiZ4b53dR0Lhc+yn1FsG/92ag7sqZuTSKDDTxXZ8y/mReCdox5LSAWcYi2jOJgZQv+rnxvy8rlYDUQxuBzMWlQbfTMBZzDk5rTbO4dui+FGsQf1MdFDI1Wjgm7kc0OH2v1E5j5ZH3o4yJa21+/sP6O1nAWyjfEJOpdHwP9wMtG/fB7ZQ8zBPn16lQ/8guRzcDjsNH3jmhYDCRM+keaQhPMQYudYtLnyPjxAv7tX9uqoJ3vvtneHKfwsugy9bS3mc74njY+dgSwyOGFpLxFoV3Sy0C0TInEiWqS/5F3kCtzNtg60hiqZXS13IFK0FAY7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2+mQbF8PV5r2PMMlZitdehFmCuKkV1HQQakOaJuSvvE=;
 b=h3MeewXpIlnsJSMOVqUAto/U3WwrQqPIGX7sJOn3zaGkF67gcIOMSyoHyWk3KncDfhwiceUr+HdAs1TID7h0iq7O0tSJituIyJK1ewmKcCJ4qM+PIowLKw4Q115pKwroteldEavMAmaZxmkE7hy7wZxrN4xrx10eWJ5DuFwK1LE0D3pLLUchZ+R5YCPpMn74br0/a6mQDn6ZPP4AqxAxUzuhs4a4HXmbxDeOQ/fQIOrcadu0YCxbosoD88Q/pQMq1XMkLNuqfKs8KuYCJ8IttW7OmmlPia7R7HZBessgiXqtvev8tGW9SEM8le6Z3MpqRW3AIbb0dHCrcSlBcl86Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=monjalon.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2+mQbF8PV5r2PMMlZitdehFmCuKkV1HQQakOaJuSvvE=;
 b=mI3fk+K2B5PQiSQd4XMrZR9uz943YQUoHcVw3LlheRM4QNQ3H0KmACWUzXqZ2Sr5soDaXI7nyyZwSJLN2lYScai4tkmKV1BsWdQF2Je713LCnJ1Qtu+ORslNNqCut9gJCtbcW2gYRoAxTkQPBmzO6TCrBNUUBjRskAg9lPBQ4mo=
Received: from BYAPR08CA0001.namprd08.prod.outlook.com (2603:10b6:a03:100::14)
 by BL1PR12MB5993.namprd12.prod.outlook.com (2603:10b6:208:399::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Sat, 22 Nov
 2025 15:52:17 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:a03:100:cafe::c3) by BYAPR08CA0001.outlook.office365.com
 (2603:10b6:a03:100::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.15 via Frontend Transport; Sat,
 22 Nov 2025 15:52:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.0 via Frontend Transport; Sat, 22 Nov 2025 15:52:16 +0000
Received: from epycpwr02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 22 Nov
 2025 09:52:10 -0600
From: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
To: <thomas@monjalon.net>
CC: <dev@dpdk.org>, <ndabilpuram@marvell.com>, <stable@dpdk.org>
Subject: [PATCH v2 5/5] examples/ipv4_multicast: remove redundant Tx queue
 limit
Date: Sat, 22 Nov 2025 15:51:56 +0000
Message-ID: <20251122155156.1385975-5-sivaprasad.tummala@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|BL1PR12MB5993:EE_
X-MS-Office365-Filtering-Correlation-Id: 4800132f-d12d-463b-4acb-08de29df1ca5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pddc9xckLEWLqsFMj8uvsuaharZc6pXLVHZMvrAv2VtTiVfMEeLSli6o8dMp?=
 =?us-ascii?Q?aSJUGkfFOWtYwuh/aUBPfSXBXftWS0/YLOUAYAKdLvKdgOVX64IyrzhEVqGR?=
 =?us-ascii?Q?6Br+c4j6xbLHjdcIV8VF7dcw5mlMI2JZ3doyROZaC8Wn9jWQbxCU1FQRi8bA?=
 =?us-ascii?Q?hr2NRxJXX40yX5+6jb7Cq2vZBD4Tn+9pDLjq3W3br6pcWnaKyJUVVWFHT+5U?=
 =?us-ascii?Q?LTeH40WSplvI6MrT/0lCeluq2UWmzGpziFWkw/505mmqtO5/7Hd/wvW58sJE?=
 =?us-ascii?Q?4bTdQ0IaH3/bwvvpHitNjtKB3s/zbcyV2xP4S3yp+kV3xmX64fpkf09+8AyP?=
 =?us-ascii?Q?PJqeFbcd+kQnSC0o3kZOaSXgWm3sUe7K+E+RLWOADfUuBphza0pb0qNxpSj3?=
 =?us-ascii?Q?F63R6aol68pmboX5HiVlvQCk8N+0s3h501HRNrAJw+RXjQVCXmERfRm7NxvZ?=
 =?us-ascii?Q?PrDTaiX47JXeBLBxh86e9jPNJ4qSIXVsRDmINR6moikIA2hYY2kPq+KMgu3H?=
 =?us-ascii?Q?cwTwuukmOWXOvC/9Kt2bZixVjXhmE0mUgdelXi41SuyiVAT2ZqgQ3RcdlcvD?=
 =?us-ascii?Q?gr4mNgznbtTtArdwNlS6hhooYC6b3de6UsIIBRfhxb1iqYJuKj7BmoLL/RBy?=
 =?us-ascii?Q?AIyN1SjroZsYKLDs/d+ghCrdacatFjZ+vLzYdDN+oWP6nt2DEtm09VTybPxf?=
 =?us-ascii?Q?pYYfC0YVr7aA+/MV5rIbaOI8J4xYxUsTPGoX3uHqF5K27gWZEVRhXI0SDsfp?=
 =?us-ascii?Q?SR4V5y/LJu5H/pt4+E2Et7vpYpSWaNHlkteHDDwfqzr3W4SXBCv88qvD8p8I?=
 =?us-ascii?Q?ZRr5f3j+rcy62Uh1KhU3UR4V3UVGp0V8ArtbINbER84NOSGwN5vnDUtnj+XJ?=
 =?us-ascii?Q?6fo1zWAH1uJXqZ1CbECVXO4y6MRKtvJL1TqlJ2OIZcrZSI9P2LMYdo6S9li7?=
 =?us-ascii?Q?KmPNaaizTPSUa7Z91iT8cW4YV8IaFp1Djd2lEqF4j3GpeCsVgIh6AA1dhYkz?=
 =?us-ascii?Q?F3cVZ6wDFDAYjpF0kkyz2SmHdeZAfn1KUyM/aEpLfjCyvBk/nPbTCQFq+P/u?=
 =?us-ascii?Q?AgiPYTarbEklrG/IZPMIcVJAQH1X5E0Dt11xJQL11FdhYQhZtlErLd8up/57?=
 =?us-ascii?Q?HHF9kehYaVOEPR5kTwYdE8EZnSe0m54bZeBYdoe6Kxq+cpSkhwFseTZKxTXY?=
 =?us-ascii?Q?RIpFBD+JVJo/g84JtwBjiYtdwzqSma4QMZAMXgETYEXRSj/Z43HpiC0I2tid?=
 =?us-ascii?Q?NT97RreOmplmMKPhq07iCBIW9wHXcwrV3iSY2ztavoPvDyb/p/19BUmJEO6z?=
 =?us-ascii?Q?4YSr+XCy2d6xQyQI+/GjIM14eSlnAj1PFQpxKrxLLcLELrc8kAZtAn1u+9Rj?=
 =?us-ascii?Q?ZAKWqgQQAv+UgaD5iyFRqaU40hpUoxDub9DiTbFxmFjbRIf7Qbx7OwjRrn6M?=
 =?us-ascii?Q?jwh3aK460UTaBa4yc0bAwlLqFJ/iliKkXc5KqNjZqSlqt3GNNTs1V2V1neYJ?=
 =?us-ascii?Q?OM8V4nnm4BDWYTrODJvqgjtDWALxcLCKlyzExf47e7GVADsrXe6jYZ9HdtoG?=
 =?us-ascii?Q?RqKdZNohUskElnPHXOU=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 15:52:16.6891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4800132f-d12d-463b-4acb-08de29df1ca5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5993
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

In `ipv4_multicast` application, Tx queues are configured per lcore
to enable a lockless design and achieve optimal performance.

The `MAX_TX_QUEUE_PER_PORT` macro, defined as `RTE_MAX_ETHPORTS`,
introduced an artificial constraint on the number of Tx queues
and limited core-scaling performance.

This patch removes the unused `MAX_TX_QUEUE_PER_PORT` macro and
redundant Tx queue check, allowing Tx queues to scale directly
with the no. of lcores.

Fixes: af75078fece3 ("first public release")
Cc: stable@dpdk.org

Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
---
 examples/ipv4_multicast/main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/examples/ipv4_multicast/main.c b/examples/ipv4_multicast/main.c
index 1eed645d02..b698db21de 100644
--- a/examples/ipv4_multicast/main.c
+++ b/examples/ipv4_multicast/main.c
@@ -97,7 +97,6 @@ struct mbuf_table {
 };
 
 #define MAX_RX_QUEUE_PER_LCORE 16
-#define MAX_TX_QUEUE_PER_PORT 16
 struct __rte_cache_aligned lcore_queue_conf {
 	uint64_t tx_tsc;
 	uint16_t n_rx_queue;
@@ -736,8 +735,6 @@ main(int argc, char **argv)
 		fflush(stdout);
 
 		n_tx_queue = nb_lcores;
-		if (n_tx_queue > MAX_TX_QUEUE_PER_PORT)
-			n_tx_queue = MAX_TX_QUEUE_PER_PORT;
 
 		ret = rte_eth_dev_configure(portid, 1, (uint16_t)n_tx_queue,
 					    &local_port_conf);
-- 
2.43.0

