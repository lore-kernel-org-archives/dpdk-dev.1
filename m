Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 488E4CA0FF0
	for <dpdk-dev@archiver.kernel.org>; Mon,  1 Sep 2025 15:44:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4ED59402EB;
	Mon,  1 Sep 2025 17:44:29 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2057.outbound.protection.outlook.com [40.107.92.57])
 by mails.dpdk.org (Postfix) with ESMTP id 9CA49402A2;
 Mon,  1 Sep 2025 17:44:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uJ2RbtTitEmKJwphgQ/jNZks+OMWE2FZpB0EIYyEqvd6p9njrZZDubQMCX6hHsNvKIxFIyxoeVN96Ravol7ZZma5QsLNe+a2C6R81xFjZI8+GcNFYU+enVKE68QvT95XY2U3j6C+Nv5Ubht1bQed/NDt8Y36RK8pUbLj/kD6NEwz5iWNVVjOJ0RDZq1zQWxAXtBJqFq0pBYeK3Tr5VvCg65QXAUxRD7lgGEnpTBxk8cnfW3GfHUyz2JJGmkYngMyWI5JyGdJCRuom/GFs98PQSzv0mw2LKgEYrscaES+CCCbTfYlvz+evNlccOHt/ljA9yz/FAToGn0RLek6V0N5/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uydowgLaD+08VA2B/0XKE1xrMTtF53GHcT+kmXhtYMo=;
 b=JA9pcGqaHoX8ZS76VBvH0+NJmCQMaNuWuRuSGiDx43T5FhFRQE525L99/esy7Ygf3HBHXZhDQcAkH7Xv90fBv4bUsi1ys6q2UymQ8I+dUDzxjotplqsOC71D5p6a6OiLImOVFLgQ1bUE1+E9bJi0omq9gw4dIRGCPZNRi0ED6FMbmV+3UihWqAFQf5YF4VBsdQTgfGuYh4B8WUS15MzFNFuAa7C1/Y/uU1GUJG+y8bQTMA44QP8838jclsHZls8QxlonqnecgsLyQ6F4Cl+RfXdd6Rvsj454qheBfToMpdTGnkoiyPSiGLuqJfUuHGevKSBw7Z+EFy4K7ysdc9/lEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=marvell.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uydowgLaD+08VA2B/0XKE1xrMTtF53GHcT+kmXhtYMo=;
 b=enDapJzQGpVIkcLAK5UpcO+cffnNg6Fgg7e2ZYvL4pj2mU+2cXsoIy2TLGb3lqkj0BJz+XkyhTlxbtdDNU6j9OGFTCHVjRFurQMmA9oC6TAgcYzwgCic88ZZrvTaG3cU/+1Tp4LcUN5PxKMbGpMAlbIO5p5StSWBtIBNagPKVS0=
Received: from BY1P220CA0002.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:59d::6)
 by CY1PR12MB9582.namprd12.prod.outlook.com (2603:10b6:930:fe::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9073.21; Mon, 1 Sep
 2025 15:44:25 +0000
Received: from CO1PEPF000044F7.namprd21.prod.outlook.com
 (2603:10b6:a03:59d:cafe::d7) by BY1P220CA0002.outlook.office365.com
 (2603:10b6:a03:59d::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.27 via Frontend Transport; Mon,
 1 Sep 2025 15:44:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F7.mail.protection.outlook.com (10.167.241.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.9115.0 via Frontend Transport; Mon, 1 Sep 2025 15:44:24 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 1 Sep
 2025 10:44:24 -0500
Received: from epycpwr02.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.1748.10; Mon, 1 Sep
 2025 08:44:23 -0700
From: Sivaprasad Tummala <sivaprasad.tummala@amd.com>
To: <jerinj@marvell.com>, <kirankumark@marvell.com>,
 <ndabilpuram@marvell.com>, <yanzhirun_163@163.com>,
 <david.marchand@redhat.com>, <ktraynor@redhat.com>, <thomas@monjalon.net>,
 <konstantin.ananyev@huawei.com>, <konstantin.v.ananyev@yandex.ru>,
 <bruce.richardson@intel.com>, <maxime.coquelin@redhat.com>,
 <aconole@redhat.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] examples/l3fwd-graph: remove redundant Tx queue limit
Date: Mon, 1 Sep 2025 15:44:00 +0000
Message-ID: <20250901154400.2333310-1-sivaprasad.tummala@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: SATLEXMB04.amd.com (10.181.40.145) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F7:EE_|CY1PR12MB9582:EE_
X-MS-Office365-Filtering-Correlation-Id: 1af13aa8-41a9-4a4a-fa08-08dde96e6d8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|7416014|921020; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+fGRnW/Bq72N6LgL0GkYTie68oiTUQxLOKPINdAnlUWD78uVVeIZjk3fFVNo?=
 =?us-ascii?Q?s/70OEmJoHEeAjKDVl6n/x1q67cnkbBN7nGQ8FJ88HjfGZGvpY7oKiJpMB62?=
 =?us-ascii?Q?vHDoYHMFilAtlT2Z+eKvfs+xDrjEW01+LeAPs/lHVjsd5G8OWbkHkzVKs/8Q?=
 =?us-ascii?Q?/WTdrzvBlPLpTb9HPEHrPp/gTjxvWqnG2fvfnTigRO1Do9lqM+mbXYCIYCsA?=
 =?us-ascii?Q?vJGMURFx3/3jtbYRIz4VBth0ecCSv9/igGkwVE6KzkeC+HCnvFeWc+QP+hVG?=
 =?us-ascii?Q?/2QjceeGc17oQks0mc6clMEbqo8qk4lZB9x34FB2DKfNHehUttF6FE1G0ZFR?=
 =?us-ascii?Q?tTPT2ffFNSc3d775VHEzK/yCXJgZ11wyhrsTJsg0907C9oWPGmEceXcj0+lK?=
 =?us-ascii?Q?yiOvxqFlhoSXFu9C2XmBhtA8Jd9k88T5lxU06z8EeYwZDGnHCJL7NdnRgx0W?=
 =?us-ascii?Q?QShpKv0xiBvG+I039F67/yUXJyKWw4AbflAtfU3W/8uRM3NtXrW3z/GFZ9g2?=
 =?us-ascii?Q?m+SU2TKnwN7+ekJFauo6SgAqFswpctN7JOIenitSkHI25GszYQcf+oKafq/t?=
 =?us-ascii?Q?UL1bALZN9bduVn5BpJPBMQVEzKNXd8SuizkOtgSm2l7gv5NzDM7I1umahxAp?=
 =?us-ascii?Q?M39yLwMDSErLS1x7Tf5j5F4Mio/jR6qgcRtxVpyKGYZR73VqUGFUdWXmSS9L?=
 =?us-ascii?Q?i+CL3wm6f0yRcHrfYx7z5CCi4J1uGXcIIoe19Q6S93EOyDlFAiikAuQ+D7FD?=
 =?us-ascii?Q?t31oXAf0MPPZzeu6syxslu/a7h/NOkfI7AhbW+lUPcbU/k7mTPAf9WwRXpeI?=
 =?us-ascii?Q?1bLBaFjNJMv9GW013qXOEeLbgz6x3HUw83ANBd2P+1kHIsRAnG7bS1u536Vl?=
 =?us-ascii?Q?CuseSbWQpRSabVspE7HQinByURVcAQznem0mHJYIKz3DthV8y6lzNmOzZnwF?=
 =?us-ascii?Q?QT5h0ljh+K0jJdAP84u/tMkyp8ulvrTQ9+oK3ijLf8ejjyxLZgdbraU6fIo9?=
 =?us-ascii?Q?n/eSTsgbQCgAx0o6SwtugLIA1zvRdHfMH17b4TBCiHmE0wsJT8D/kH4sX5T6?=
 =?us-ascii?Q?R0JzWqMjKsLtK+cnzEybeE8kxu0u9mwHQ1/lH7FthajkCKRUVcVgGFSq/L2D?=
 =?us-ascii?Q?N6wwYzahtnyOm7mEDY1Tg+c2lN+79FFvg+2vwXMec43Vb+6ZJQ4orEY5M5OG?=
 =?us-ascii?Q?bpA3tG5Jy26bCeOq3sPuscUpU5f3E7ZZd7YlochN2TLh/7g5mYgLH/LwgMw1?=
 =?us-ascii?Q?iV7K0NiPpnkPE7+oOrwBorB/O/s9aLGJPbgJ0tlCrxm+xQ0CP0+0l0iGNnvG?=
 =?us-ascii?Q?mKiQAx27j7FnR0Y+SgNiWkMvm7BG+2vtoG2OqdRYoQOanSgDvxYtTuOm6iGt?=
 =?us-ascii?Q?GZOfBUjfU2ngxUDV7IJAYQtW/pXW+gDh0IYzHieZwGTy9FvpzzRcxSiqJlrn?=
 =?us-ascii?Q?3v7W7q85K5q8ViPMMrCpuHy5gNLaCFReTEvPnWpP8wphbTSFXrbEcDJZ4wuJ?=
 =?us-ascii?Q?2Ez22znEVYG4d5QyNIAGfGsmprCfSX+4/dWEld1IuteZcaJKWSfg/HrGKQ?=
 =?us-ascii?Q?=3D=3D?=
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:CAL; SFV:NSPM; H:SATLEXMB03.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7416014)(921020);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2025 15:44:24.8967 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1af13aa8-41a9-4a4a-fa08-08dde96e6d8f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044F7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY1PR12MB9582
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

