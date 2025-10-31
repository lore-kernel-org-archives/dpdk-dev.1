Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93F93CCF9F0
	for <dpdk-dev@archiver.kernel.org>; Fri, 31 Oct 2025 02:52:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5EF6040270;
	Fri, 31 Oct 2025 03:52:13 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
 by mails.dpdk.org (Postfix) with ESMTP id 32E124026F
 for <dev@dpdk.org>; Fri, 31 Oct 2025 03:52:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZJ+CjFcg2oLG8HloYuatIABbuXJyA57mHErzBu/YrPCcp8uebQr/L+WddOfms2VWXht35Rwub5N4zk11oWHEwTtdEU4iziTFoafiPNQzO77ii9y3akADViC8+yOoLMrUsHplGeaTJHAG1yrM3MOaGjyNuiGAV2FqyowvJx96whUb1/HV1QhDE+NBG1wcNjqKTpcGP1r1Ulnm8r7YqlT5EdfVRrTlEy7KccT0LOB9lOzbe5EIW5rkd0SoYxZboprjV75WIrw+W1V4g9uOZd6tvB1o1SApxZfRd1k87v0rKgQyBE+oknBvcRKmd97lWNh8hCFn3L1aJ14+2/gDyLZo3Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SD3plQzFJYG+nVek8FdQOefkSnmKRupJdt4hGDlAPD4=;
 b=LqxkSUgRFR9Gxe6jT9lXRq13MgMZDz8D86jMqT1Vvk1vJ9IB3e3VZjSq1j8rLNYZ+2zJmE5GAKRQNTt7/6AkXHZ+7329pBuQhSfG0CSwELqBi+1LCYePvgZo+fV7SBOM16TQmNhNSWHYRZxYDHk4tNSH898iB37t0QeyOk7MY0mrAwj82BwwtsY0eFwcE94944j/aA7LzQ+HZq7yxACwMM6SfHdcpH/cUE+4KWzMo6INWkA4Dmv43lycUJPswsd9mDxmH4xk2+915kl2JR9+lbkxjf9AVLJZQqLJhDpxnbRxfMzUvwdKaF5+4HzV26Fh3QGbeceaXxg3wHG+AXyGuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SD3plQzFJYG+nVek8FdQOefkSnmKRupJdt4hGDlAPD4=;
 b=ZctzvTHR9/Xl/FqvizGVuP2gYjrhPaLH8E3C+H7lINTFcZwPT7kuqOKXpzNbdFndxs39bepIxbYqzrw9AndyE7mhw1mii0kYSSAerN6AqoxihPKibxTZe/zpkUaSnYGuPU2P+/eeV5KKo0vzOc6yVrHEBVIMuQ37V2vvPROnBbkDB8EpUncDpKJwR4qRJ8Wrtg/3WYi7BhbLmeCuRbbHfC9mUVMpvtv6wrg49XK9NS2EkYnRZqZg8KKxh09hzvAjmn7ZktW8BdJ/amCXAkHFz6G8QwnBrWJMkhgm3nq3TPeIvGStKvkZCIq9wZw80NNnQm23BmM4HjRTKnf9IZ9FWQ==
Received: from CH2PR10CA0006.namprd10.prod.outlook.com (2603:10b6:610:4c::16)
 by DM4PR12MB5962.namprd12.prod.outlook.com (2603:10b6:8:69::7) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.14; Fri, 31 Oct 2025 02:52:05 +0000
Received: from CH1PEPF0000A34C.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::15) by CH2PR10CA0006.outlook.office365.com
 (2603:10b6:610:4c::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Fri,
 31 Oct 2025 02:51:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A34C.mail.protection.outlook.com (10.167.244.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Fri, 31 Oct 2025 02:52:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 30 Oct
 2025 19:51:56 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 19:51:53 -0700
From: Rongwei Liu <rongweil@nvidia.com>
To: <dev@dpdk.org>, <matan@nvidia.com>, <viacheslavo@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <thomas@monjalon.net>
CC: <rongweil@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>
Subject: [PATCH v2] net/mlx5: remove counter alignment
Date: Fri, 31 Oct 2025 04:50:38 +0200
Message-ID: <20251031025038.62100-1-rongweil@nvidia.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20251028101427.7swzqvc5o3ofzdxg@ds-vm-debian.local>
References: <20251028101427.7swzqvc5o3ofzdxg@ds-vm-debian.local>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34C:EE_|DM4PR12MB5962:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f13feff-0fc7-4467-7d71-08de18287a02
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Bo4FsMRJ3Z3PcEPfdLj/0pm7MjXAXHcJEDLWRY+i0cqHLmjcOOxC3+pSl4Jx?=
 =?us-ascii?Q?k9F6iLOV1k0RchO9Pt8Z7EQv1IiAdob5m0ohk/a2FZWU2Bh5jR6ZFQ7H0kGC?=
 =?us-ascii?Q?0Jn735ba22Ge39/PIIt463CQkfPiC9f09xoKznEJH05e8dnpLsjH+Q7HtTJF?=
 =?us-ascii?Q?jtjXDhxfLuCAlvom8s5H7sYOZxLkLw9Qbg642kSDABGRpw6nbl71HkCypG/P?=
 =?us-ascii?Q?LRSUNbq0VWt+SFlS7g4eYgArCTRROaO7w33GPYs71TQSKQokjJxuuQdv/8Nm?=
 =?us-ascii?Q?wL/B/h8HDMzOmKbhmZ6UPYMLuEVDOhFub2hNbXLCcD5kfJRCPROlAIRrgmbA?=
 =?us-ascii?Q?cRzYxCfKtzv2pbkUHSqFoYLWwm8FFIJksdLZAzRLnU/82WxZurrtRJDFhYrD?=
 =?us-ascii?Q?8ovgeJnOFjJ3zr7FQ0wsnQUwFYhmAM6JlL+G8sxXfVVjnikfu/z4aC09tgAN?=
 =?us-ascii?Q?pGiJyyHCiXHbpd6Bj6DYY4bdrJHSoodEEO7nyL8RKrpSWKy+tjR3mh7Dwdns?=
 =?us-ascii?Q?8bMBy5QjLcCvDdYqriCIOBz13MzZ7ctt4GV2LgRqUHIL0DqpCu6ov7Gyn0k0?=
 =?us-ascii?Q?lgm/Ymtd2JiuESb4WZySX2p+vof53s5eTAmnmgG9g1EKtQAwQpYLUvGc2zt1?=
 =?us-ascii?Q?xo6zrOeW2bXh5rD8RrGOhjxbq5VDKMSqq91+Oq6PYBKOXFTCSP67y4JR5ahj?=
 =?us-ascii?Q?NvQDFoqDoXnvA0F6fnWvf+/KmOsnZIdUEB4rp+wHXoPH89BJKZBWT30mDQng?=
 =?us-ascii?Q?K8m+imDmMiMxkByMCDTJ4+nMuT1h0dTOBjh7rUx0irN0V4a12PQWhss2O+ed?=
 =?us-ascii?Q?H84iMFvGbCullEfrkhiiQKnW6PDSscZUhAWLGznPSgoAhuqSTwTqW9xwCDoX?=
 =?us-ascii?Q?WqHgi6YmfMFT8kdyMGWIKzwAtsjUHI2xUCKfHbkDX8n/VGqz7pyLoo64NGzC?=
 =?us-ascii?Q?2STyCLx1roM03AOuc4u9aQ7pPCwBcP4fNaPxX6XILaidjeB4w+CxO1bGWENS?=
 =?us-ascii?Q?ME8VGr0pLm5I/vvGdqJ/AEfoDQA7a/Cz5/A+I2l0liwFYNyHDx5hrKUvxQ5R?=
 =?us-ascii?Q?fhmCg1N59Q/oz894BVRoVe+BOSidZS1Ui4AQN8IEikposoVXvdVe8JpzOiw3?=
 =?us-ascii?Q?jMfI0llQNy94PAf609bGS9/wYVoXL4xN0BsQbgscREcrAkn1aVtWJkyw/RsA?=
 =?us-ascii?Q?cmj9IZ96NtwkaNU0RJBLO/YY1btxjEZ2Mqa6nlpg+/0HVPjp5x3fGWbN8VvA?=
 =?us-ascii?Q?Fc0ME4ptMe1dn/mdomGG4YzOt+CveJgpoUsAYZY18gmMbrIVnQByFOQvdxkj?=
 =?us-ascii?Q?BohnzceN720kBA0gVo4HSXFJa6aelHq9iIMrETMjfw4Qp3oiMRxfKRIKu+5V?=
 =?us-ascii?Q?vKWPxs51RoLj++23n2D04G69NshCin3t1DhREXhOalDDmcPfGAATyA77JTPn?=
 =?us-ascii?Q?4WZZi6YyxTXk/qiPay7jcUfszo9E4q8bazhXOsVKMRQATF1KY/KWlyvBXlmj?=
 =?us-ascii?Q?3wKHgxVIleSCSOB6on5fRrPXS/4CLLf1gK8Xkt7A0MHyH+v/PRkaJ5bk5TZT?=
 =?us-ascii?Q?TK/V+ml9I2sgqnoUShQ=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Oct 2025 02:52:05.6640 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f13feff-0fc7-4467-7d71-08de18287a02
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5962
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

The memory footprint was increased due to the alignment.

Fixes: 820ca7361bb7fa4 ("net/mlx5: fix flow aging race condition")
Cc: rongweil@nvidia.com

Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
---
 drivers/net/mlx5/mlx5_hws_cnt.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_hws_cnt.h b/drivers/net/mlx5/mlx5_hws_cnt.h
index f5b7e8f643..8d7a9d34df 100644
--- a/drivers/net/mlx5/mlx5_hws_cnt.h
+++ b/drivers/net/mlx5/mlx5_hws_cnt.h
@@ -43,7 +43,7 @@ struct mlx5_hws_cnt_dcs_mng {
 };
 
 union mlx5_hws_cnt_state {
-	alignas(RTE_CACHE_LINE_SIZE) RTE_ATOMIC(uint32_t)data;
+	RTE_ATOMIC(uint32_t) data;
 	struct {
 		uint32_t in_used:1;
 		/* Indicator whether this counter in used or in pool. */
@@ -64,7 +64,7 @@ struct mlx5_hws_cnt {
 	struct flow_counter_stats reset;
 	union mlx5_hws_cnt_state cnt_state;
 	/* This struct is only meaningful when user own this counter. */
-	alignas(RTE_CACHE_LINE_SIZE) RTE_ATOMIC(uint32_t)query_gen_when_free;
+	RTE_ATOMIC(uint32_t) query_gen_when_free;
 	/*
 	 * When PMD own this counter (user put back counter to PMD
 	 * counter pool, i.e), this field recorded value of counter
-- 
2.27.0

