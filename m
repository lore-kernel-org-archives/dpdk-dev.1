Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDFCDC2A072
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 Jan 2026 07:06:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 880C44026F;
	Mon,  5 Jan 2026 08:06:39 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012043.outbound.protection.outlook.com
 [40.107.200.43])
 by mails.dpdk.org (Postfix) with ESMTP id 1036840267;
 Mon,  5 Jan 2026 08:06:38 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TUyiDjOqNvFlb+KEI54RFfl3OiCyRK5wTs7qGUL3uWT66SxTHTixX+O66/ogMgge6XuKr09Rl27SSTGWY2P4R2uN/WtzYfiyN4Trm9V+HMZbpNrbeEXZzM877Ilg0xiuianXnRsI3SOomrJOIb67NwafhRpZRofPgS8/W0s5/rw2t1dLS1S+Pr7v65PopcTzGr/4FIvDIpAOnMU5TxkFonHtwiCUARVAxMyTq1snHckWRO1hWvN643BHkl548klVtamz4IMW04/PNCLIc39V6/jy/3azzz8GGDc+hdVoQVzsAXRDuhoJUTc12z1/lPWQKhKV/6xGb3kvkYix8Z8k6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UJeExyXhWrKuQGzU37l+DCY2zL4hYwa/5ToE08X99uM=;
 b=WUPhiyIOtd/tKL6sEsAc5pM9tjaGuO4w3zd70C8wrNXfIx/TD29DIinZ3G8Miz2/t32dyy88ck+GtXq4OIRET46oYoEdWqkWe4UF+o3djuFTGTq/sIQc4M09BG6W1310Zt5rdX0Gv00Kd5H91k9+YMwKjJn8lpeIPxUphmV31A2VwdXscLhTBI36nlcCV6VHECPas/5CtblZuODTj0LxD10U26g40cKQ2wUFTui0PZ/NxNqryatAi9RWiwO/u5BR8zfzRlSvfwWEprq2Tj/w7yhIE5NcjkEiORSS/hiVTg3drYyOp/bz1rMs6KJn62uzvn5/dmnf77/t3xqaoenfmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UJeExyXhWrKuQGzU37l+DCY2zL4hYwa/5ToE08X99uM=;
 b=IEi0zWoCghaTxTDVlr2gxD+kPondX20LIfOqtZdypr61rV4Ep6NPZs6mRums30g+zuJjNnIeJyQJ6oJ8+JO/VoLbbttOGo6GZ5muvKVQDD7rw3iDjh6TogcE0qHT4DNn8fg3AuK7DAakBg5z/DYef80yAK/zBXwyRlJcOxm7JzFtv4HJX7KxWtbiYg3GhDEuO5vni/tAE4x1MCtnl4NThDR39esoWrCWmR9fCHdOyXp7cCvskRcnYeWk5gUdD8DC2j4sNgSDnwI2p60zFJyEz81rwnOWMheuIdS0N9ZPzrnQZD+fMPkPPs0UCGcCgSqY918PdLf82uPD0WUri9yNig==
Received: from CH0PR13CA0012.namprd13.prod.outlook.com (2603:10b6:610:b1::17)
 by CH2PR12MB4245.namprd12.prod.outlook.com (2603:10b6:610:af::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9478.4; Mon, 5 Jan
 2026 07:06:34 +0000
Received: from CH1PEPF0000A347.namprd04.prod.outlook.com
 (2603:10b6:610:b1:cafe::c2) by CH0PR13CA0012.outlook.office365.com
 (2603:10b6:610:b1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.1 via Frontend Transport; Mon, 5
 Jan 2026 07:06:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000A347.mail.protection.outlook.com (10.167.244.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9499.1 via Frontend Transport; Mon, 5 Jan 2026 07:06:33 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 4 Jan
 2026 23:06:16 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 4 Jan
 2026 23:06:12 -0800
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>
CC: <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>, <shperetz@nvidia.com>,
 <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix the counters resource leak
Date: Mon, 5 Jan 2026 09:05:58 +0200
Message-ID: <20260105070558.71556-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A347:EE_|CH2PR12MB4245:EE_
X-MS-Office365-Filtering-Correlation-Id: 4f9ac14e-7b99-4e6b-131f-08de4c28f5dc
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?N96BdgBL3sTmVyv65Z6yOqUCqQGliYyOuecV8QaLyYKcYpZQ4CnZoaZkZRrq?=
 =?us-ascii?Q?CWUqV0Fb+BQIah6LO+zKwYhaRZtisqU8/9h/DbxLy1BOHYxXGl0eXvdhVoBc?=
 =?us-ascii?Q?/y2eZ88DR22Sx/0uHAZ8qzBmUanO4AAXG3fUDUYT2HwE3CQxVdTTH7NkJkaD?=
 =?us-ascii?Q?4nAzm04NaaESW+Gmy2ZbUyF2/MSjhGm3RoowxAeP6wpTsKZOjzivt55gL5wR?=
 =?us-ascii?Q?zAoPPvtX0IMMpNx7r9L59/YhilDZiqF7EQFGOoqsnPSdMTky7mJP2ayFX7bp?=
 =?us-ascii?Q?rofzLgLJt/85NWcGO5fG7et/diQw2yTariDt0ziJRsId0CFLATguei4NeOd/?=
 =?us-ascii?Q?g4JLBOLowuogqMIzSZc2/pObuKSZsoLBaggRbYFJLVKLzLU/yFMDfp+cc4Cf?=
 =?us-ascii?Q?wP1IBNCnpT/rQehiHT5rivapGX+aCVDpiufURdJrKPoC3HUByAtAEIueB4pu?=
 =?us-ascii?Q?Pd7DswcDTcarIObzsLUA6Ep5YGnO/6rvCQojQOHn6Px78BPO+5RBQ8+dnyaN?=
 =?us-ascii?Q?z+WZLl3lYnV1cdOvWpTRhW9S7IrozEh06ViFA3cHvSy1Akw36LuxxsCRM5IG?=
 =?us-ascii?Q?mFZ0vw14FnMEdzR7imPJR4L/B8H3lY2YI7284CfFiliBG65dW4+c5/Iw8ole?=
 =?us-ascii?Q?BpZ3Rh9hCsQvKfAd81RDjb4lAROZTmdezZX+g+F6yLjQ7YTDbSzWF44MLjal?=
 =?us-ascii?Q?auABBZ4VJQHQzgtT77PYepG0OFz/ex6565MY/cuL7bVFoxh5AxXEa9RTyydI?=
 =?us-ascii?Q?57ESO4TDG+33+Ct9jZD+sfavYCWwBuSJBEuqriqtlgioM+ZKtznVTT8taWti?=
 =?us-ascii?Q?7TgSUdAFPyC/0lUgGaIQ7I5f2DM8v00x6M9J2vtHWPasF4rFetrLpJQFRdk2?=
 =?us-ascii?Q?xc0wpy4j9ti5RXOgh3VEW2OMRcH3k9DSHC5b8Lovs8fH3Wrd6SqX9S2A/6UN?=
 =?us-ascii?Q?U/jhIfiyYMUmmgDogFv3oO634JRjNyLj8RzoHktEDADnHKwYV1Dgt2YqzoBg?=
 =?us-ascii?Q?tlFSwKXduvvXxrkLbhDldZ1oM6xwUvzgnFgD4lj8Zwat4htxIWfluJBPZArS?=
 =?us-ascii?Q?TvjSQX2rl/AplFuDtQxGLb7NO5n+jN8/afOH7whWyRELySM1LJcALmR5tWuY?=
 =?us-ascii?Q?U3k/NZXG/tTl0/7ZPfNlZ3kukk0uwouAC0ejE6tnIOQuRgXvucJuC1Ej3KwY?=
 =?us-ascii?Q?Cq8C9q8hJC5O8JPwGLRCWzunEK+bKZ1g5jub6X/zxm12T0+2wCYoASkLDKyH?=
 =?us-ascii?Q?vRYYEvii0LC2zyWH3UdcqhR0kQXO28wicq/Hl0eC/YK2AOnMqB6HlETA4rpP?=
 =?us-ascii?Q?mN74+Xp7F4Sbdp+Dy2y9uw9ykqrH6a9EANE+/FQMt9U4O/PO3W7TsIq1HGBD?=
 =?us-ascii?Q?JFMyBc8wTT04WhJNX8LRNOfDSM0EYMiAESRTXv2IxRECxLMzDUhFwB2IGgYA?=
 =?us-ascii?Q?OfwtI/QRBFFaW6aF5ib2lOSzy0aa6om39b1ivjurxQcYfNfhzZPAw6ITnl0L?=
 =?us-ascii?Q?a6BsmHwrCxqK7yQQvYQ60AkJUevQi1pgjPa9eKMuh4O1ruwpA3S+/dG2xpj0?=
 =?us-ascii?Q?kmmxzWGCmpU7JDa3FuU=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2026 07:06:33.9087 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4f9ac14e-7b99-4e6b-131f-08de4c28f5dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A347.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4245
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

The counters that are used to record the dropped packets (including
hairpin) are created firstly. Then the counter objects are provided
to the command to create the Rx queues, and they are used for the
global drop and hairpin queues drop statistics. One counter can be
associated with more than one queue in hairpin case.

So the reference count of a counter will be increased once attached
to a queue. When closing the device, the queues and counters should
be destroyed in the reverse order. The queues should be destroyed
firstly in order to decrease the reference count of attached counter
properlly. Then the counter can be recycled successfully. Or else the
resource will be leaked before the application quits when doing port
attach / detach rerepeatedly.

Fixes: f0c0731b6d40 ("net/mlx5: add counters for hairpin drop")
Cc: shperetz@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Bing Zhao <bingz@nvidia.com>
Acked-by: Suanming Mou <suanmingm@nvidia.com>
---
 drivers/net/mlx5/mlx5.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index decf540c51..bde4d01e48 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -2404,7 +2404,6 @@ mlx5_dev_close(struct rte_eth_dev *dev)
 		priv->ptype_rss_groups = NULL;
 	}
 #endif
-	mlx5_q_counters_destroy(dev);
 	if (priv->rxq_privs != NULL) {
 		/* XXX race condition if mlx5_rx_burst() is still running. */
 		rte_delay_us_sleep(1000);
@@ -2425,6 +2424,7 @@ mlx5_dev_close(struct rte_eth_dev *dev)
 	mlx5_proc_priv_uninit(dev);
 	if (priv->drop_queue.hrxq)
 		mlx5_drop_action_destroy(dev);
+	mlx5_q_counters_destroy(dev);
 	mlx5_mprq_free_mp(dev);
 	mlx5_os_free_shared_dr(priv);
 #ifdef HAVE_MLX5_HWS_SUPPORT
-- 
2.34.1

