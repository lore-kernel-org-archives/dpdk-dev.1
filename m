Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09A2ECFC536
	for <dpdk-dev@archiver.kernel.org>; Sat, 22 Nov 2025 15:52:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 782B3402F0;
	Sat, 22 Nov 2025 16:52:21 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010027.outbound.protection.outlook.com [52.101.56.27])
 by mails.dpdk.org (Postfix) with ESMTP id D4032400EF;
 Sat, 22 Nov 2025 16:52:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hxB80aof2uw9AcBOtOvvC+PwhqRol/M/0/Chloss6DmzJVI7Qq9Vvdl2y0wcUIk0mLLt9IkGhM6rTl8+dWY7di9MbIphqY1f1xQs3ebSXPeS+w434YiHa4EiylYqGT1RhJjkS8EzqNf8ZkXvJ0dkjXrxPjUThmDsKvvuntlnawFViiT+B9QaKBln4qGQ+OhhCGMKaG1pMRdZVxRm6UwqJ/2vWQ1uQ0RaX8xvvd2MkOjbto6+WFaAiFqHROJjoX0xm7+fQYkdjpRaDb2+MEkrxke9JC3opR4WdHVs309/pVbEVs8tTksLEoqcJvfk2Z3W7Mtyam6+BkDo0ZV7C9n6PQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uydowgLaD+08VA2B/0XKE1xrMTtF53GHcT+kmXhtYMo=;
 b=im+sPEXDrg1/uTGTlSaT9kq02uxR7KjBtkZBh/xCX3n/++GdOn3og+ucGPJMZ9c9i8iwxoQ6/b8Kly2a2jWLPbLpv/+P+LiS4IBMBA9JXkF6cVwZejSwUaN7NBmiR7ja0IZnY8oHV5DlDFI7F8ZIix60JxRDgEz3MlJz38oFBHxLpEz+l75sXhe0yjC+HVo3kLxzdU7do9rc+90udf0CSOW7dxAfHLx46yePuLgrTrwMxj5f7GAmfZbxUKgbThEq6EUnPW4lI3AgQul2sf3RYyi/uJBmBy2btnmVdGdoXF3OGBvLChxm5OUWSeUPnx1iAev/W+Z2xxrWeAAmvNAsoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=monjalon.net smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uydowgLaD+08VA2B/0XKE1xrMTtF53GHcT+kmXhtYMo=;
 b=dVknYTY00xjzdavscdF7weOqCgfCEU80KzMdL0F5BgY0IyfEZb5FAnh7xGqp/OSNlgJBuS2D3jBdj5wJ864MYsuyv6qCELlvw0GIunmVXUaiH0QbuxH9idqX44fLojmSx/E7RveZ4WmESisZ4jM/JflaNEokfI2CoLlO/b+/ysU=
Received: from BYAPR08CA0004.namprd08.prod.outlook.com (2603:10b6:a03:100::17)
 by MN0PR12MB5977.namprd12.prod.outlook.com (2603:10b6:208:37c::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.14; Sat, 22 Nov
 2025 15:52:12 +0000
Received: from CO1PEPF000044FB.namprd21.prod.outlook.com
 (2603:10b6:a03:100:cafe::2e) by BYAPR08CA0004.outlook.office365.com
 (2603:10b6:a03:100::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.14 via Frontend Transport; Sat,
 22 Nov 2025 15:52:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000044FB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9388.0 via Frontend Transport; Sat, 22 Nov 2025 15:52:11 +0000
Received: from epycpwr02.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 22 Nov
 2025 09:52:07 -0600
From: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
To: <thomas@monjalon.net>, Jerin Jacob <jerinj@marvell.com>, Kiran Kumar K
 <kirankumark@marvell.com>, Nithin Dabilpuram <ndabilpuram@marvell.com>,
 Zhirun Yan <yanzhirun_163@163.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH v2 1/5] examples/l3fwd-graph: remove redundant Tx queue limit
Date: Sat, 22 Nov 2025 15:51:52 +0000
Message-ID: <20251122155156.1385975-1-sivaprasad.tummala@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250901154400.2333310-1-sivaprasad.tummala@amd.com>
References: <20250901154400.2333310-1-sivaprasad.tummala@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FB:EE_|MN0PR12MB5977:EE_
X-MS-Office365-Filtering-Correlation-Id: 683e8a19-e3dd-4a55-eaa2-08de29df198a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rIRHifosHodTHR0wTCfEsIfknG51r37eP7aFS5gsdHr4mji3HAAukd/nMVP2?=
 =?us-ascii?Q?vuGicxrazwaPq+5NRBG1WcTjACe7TXWaWYfc/9FcMmkM06o6zsfONOgqBZpL?=
 =?us-ascii?Q?8sMb0SAeKMQgjRanZx2l8CzaVB3eZiII58ias2TgYGCcqecRe2ngYbM1w12o?=
 =?us-ascii?Q?Nvhk+X8SZH/DvukCFArMWWxSkVKgynPaxNoN/2cjhPIw9/av6alIxSUbRJQJ?=
 =?us-ascii?Q?PZQPK3bRr8T8oh40in52hxzB673SoT/Mv19NNDNqgLR8bLWFiV4fwPsEisbo?=
 =?us-ascii?Q?XPHA5JxXD3+lfnGCKzP/QY7YNqFmIb4CDW+NF3AXOJrb3zhUifU8u4KuL5wZ?=
 =?us-ascii?Q?yFz5yU4fkn2zy1ZHdRDB90rGIdQ3VMDZVNHyjMXh3HUiSmMOE/5MyDvp4OEI?=
 =?us-ascii?Q?CxV3nN+g5Tszb3kGOo/6MgDf9JkPTkHjTl1KEQTnPvhfBgVFB208reOPW8aW?=
 =?us-ascii?Q?daJIo2SZwuITAJ8jHUjlb+93fkxvSh8oqEOT/xGOcwPsqZeMiwj27bh9v81K?=
 =?us-ascii?Q?LdqbIfHFtW3tmjdguSJQxfeljACQB+qKv1tM4pyYp1JtmfOejppAhUkmpOVc?=
 =?us-ascii?Q?vgG+N44uOmj4GCnoqefYXoH+qLYsyDl1Og4muPpJpEaVIrBiOBhKJrpRgJTm?=
 =?us-ascii?Q?Ndb3sUIuOBG0f20Pr1ovJv5ZEcYrX60KXyX6VLiVryUeJrvHiWqlv7Sl5kFW?=
 =?us-ascii?Q?2Fw6heCcE3NXFv4PdnfJb6wEbEfs3p+AeHVvQlNQsLfvEUsLAOxTyhKQfxf1?=
 =?us-ascii?Q?O1XWioGVzpiPLDpazQcmWTKIppIFx2OiOyp0dbK6kGV59SHfK9uSYX9eLrJ+?=
 =?us-ascii?Q?fu79fJvTY0R89yPvWl6k4a8QWIdMrdAkHhJbC3mbdbP0NVPGNgaC+HI8BP3E?=
 =?us-ascii?Q?FpeidtVDo4gDqaOw8khrv0cY87D8QLpBMxCR19oQDB0wkWdP/0AKpkbpBgJr?=
 =?us-ascii?Q?7VmZ28PNm1zRw+2TwPC7B3J7ahNgqAXZhhzffj33bGc6yVo3Qf6w9ty9pRE2?=
 =?us-ascii?Q?Z1Mgy/bfRqwIKGqtCq2HpoRr5pIWsqmPHvVYNeVyPagN//2jXTOUXkrdie3l?=
 =?us-ascii?Q?QHEMB9YYWlBcsFo9TYutlmhPDq/Ap170g2G+Vf2/3uKZspyy7JOmEp5PriPQ?=
 =?us-ascii?Q?qWxUEq8gwafd49SYtwb6i/Uw/St4X+B5odSzF/sXc/lraJyg5GU43wf4u3JV?=
 =?us-ascii?Q?Xzn+Yk8n7+LlHsDF/vx0luJDT1odHcd/7A85OFBIX3MmFSmyeyWh2WyNDFlM?=
 =?us-ascii?Q?2syIgEoQuQ7t/DzrWOHGxp9jmShAR9XYx7UgAiziTad4XKTHzuLH17c6mrfx?=
 =?us-ascii?Q?ScrV9ZnLzKKGappN3sCmmAGs88ZGK3pwPWeopRIOriZKSAcBNjRh2aD+ttxX?=
 =?us-ascii?Q?+lVhJExmYqiR8ptAefsM4RoA1VA87F8MZj0T9/RQSYAD8iyv5zVfsAlU3jzY?=
 =?us-ascii?Q?eGz9VBGabDOpy6uF9BNq+cpY7DKxhR7gn1eWM7j92VNrAfAB7Sw8UGYoDmtU?=
 =?us-ascii?Q?VmAMZoh1vWn1j+xA4W/HOnPiNZ9ijMf1tdN9Ewo/8jn4PMjRt52PP5Tfb3px?=
 =?us-ascii?Q?HOj9zJ3JmkJVHmiC7os=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Nov 2025 15:52:11.4832 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 683e8a19-e3dd-4a55-eaa2-08de29df198a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FB.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB5977
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

In `l3fwd-graph` application, Tx queues are configured per lcore
to enable a lockless design and achieve optimal performance.

The `MAX_TX_QUEUE_PER_PORT` macro, defined as `RTE_MAX_ETHPORTS`,
introduced an artificial constraint on the number of Tx queues
and limited core-scaling performance.

This patch removes the unused `MAX_TX_QUEUE_PER_PORT` macro and
redundant Tx queue check, allowing Tx queues to scale directly
with the no. of lcores.

Fixes: 08bd1a174461 ("examples/l3fwd-graph: add graph-based l3fwd skeleton")
Cc: ndabilpuram@marvell.com
Cc: stable@dpdk.org

Signed-off-by: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
---
 examples/l3fwd-graph/main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/examples/l3fwd-graph/main.c b/examples/l3fwd-graph/main.c
index 92cdaa1ebe..12908acbba 100644
--- a/examples/l3fwd-graph/main.c
+++ b/examples/l3fwd-graph/main.c
@@ -49,7 +49,6 @@
 #define RX_DESC_DEFAULT 1024
 #define TX_DESC_DEFAULT 1024
 
-#define MAX_TX_QUEUE_PER_PORT RTE_MAX_ETHPORTS
 #define MAX_RX_QUEUE_PER_PORT 128
 
 #define MAX_RX_QUEUE_PER_LCORE 16
@@ -1076,8 +1075,6 @@ main(int argc, char **argv)
 
 		nb_rx_queue = get_port_n_rx_queues(portid);
 		n_tx_queue = nb_lcores;
-		if (n_tx_queue > MAX_TX_QUEUE_PER_PORT)
-			n_tx_queue = MAX_TX_QUEUE_PER_PORT;
 		printf("Creating queues: nb_rxq=%d nb_txq=%u... ",
 		       nb_rx_queue, n_tx_queue);
 
-- 
2.43.0

