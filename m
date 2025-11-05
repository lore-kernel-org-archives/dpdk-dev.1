Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A2A0CCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 12:53:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 51865402A9;
	Wed,  5 Nov 2025 13:53:38 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012011.outbound.protection.outlook.com [52.101.43.11])
 by mails.dpdk.org (Postfix) with ESMTP id D74D74021F;
 Wed,  5 Nov 2025 13:53:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f7SpWuZe5L01kAXjgqJ7Ufh1pfq7gefqbng4rhMMWIq453wIQ2jjkGvYDKOkb6Gz4ycJDbFIBBN38Hci59q/QyidEJuEI2Dvu+fatX9202D+NPWyb4i2tjD/xT5ugmgvaSoMqbvKiWzw8D1dCGYmhAtXo47YMEOI7QWZC+QQdhlhkv5AQQzZlqI59O2ivrLyvCw8NDj+NXiwQkZU0rpF9C3OHbfega3DxSyGVEhnMaQrWqX1JWxeA0tS+1F615ntVCKaEkdt4CEcxtZwtC8rJOaKPQrUr56kBvVnON4Kql4J+beWnKo4aHpn4Jxhhs3fOFMSg9hNngUl9bZ14HO3KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MqKyqQ69ZbrJeE68Bj8lIz2uTy4SkV4n35SFNS+Y6bc=;
 b=zAJ3F+W+FhVVCwiDtSF6Xn4kRpCO3w6hBs7ObOw+QI6GFvIAW3pWGrsSlXPovmTqjQShBtOEUEfnh3msG/p459rxRrdS3ek3nfdg4BNJCp+X0oIWaMChuBYIqCQTwVQfJat0d0a3PdofefdZsznhII3aZ9utykvdirXyW9mM5B0PQP7CLRrfltoBOlBAHMgN/hnF7r0KMbTnmW9w1NJRwN7uAPjtHHTO1FQyLapD4NpvsNiWHkqm7ho/XlW+TUrOQ0pqt3W4jTz5a7PEITIjpbgtXs8m+wpWRJErBi2JblyiFwUSh+TYLLg/eUEVh5HuB0oG1LWKJNbhtsaknTWSRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MqKyqQ69ZbrJeE68Bj8lIz2uTy4SkV4n35SFNS+Y6bc=;
 b=KbRNywtyYALlTEixhzuB6L1Bub+qnx+PqGm6oaEVLHPRP1SzqygKahYTet7ib3t8ULm8a6bbKmGcfN9Q9lW9fwJtr3Yt9GBgPo/QERehIeJS8cSSVKhH35IIDJsEA76e1OaDKsaF0/nQPjg2Fju+7kQRH2SQALZb/XZKuZjyt27xV9I03r6E5HZAZu+E4xG9A1SRN/xNO4/S7Gd/Z7g8fBqsCIh5D4gmS3LsGJwHXLKqOBArkjCaStCK3C+OTjFc/pYTTM8skOKrKKqIMvSn137jbtIkVq3Mh5pX2Rcv5sok6X1IfKttQEhqwSfRrIUogl/v+HKYqsaezwe2jwcALQ==
Received: from SJ0PR05CA0057.namprd05.prod.outlook.com (2603:10b6:a03:33f::32)
 by CH3PR12MB8658.namprd12.prod.outlook.com (2603:10b6:610:175::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 12:53:30 +0000
Received: from SJ1PEPF00002320.namprd03.prod.outlook.com
 (2603:10b6:a03:33f:cafe::62) by SJ0PR05CA0057.outlook.office365.com
 (2603:10b6:a03:33f::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 12:53:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00002320.mail.protection.outlook.com (10.167.242.86) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 12:53:29 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 04:53:17 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 04:53:14 -0800
From: Rongwei Liu <rongweil@nvidia.com>
To: <dev@dpdk.org>, <matan@nvidia.com>, <viacheslavo@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <thomas@monjalon.net>
CC: <getelson@nvidia.com>, <stable@dpdk.org>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>
Subject: [PATCH v1] net/mlx5: fix invalid queue index handling
Date: Wed, 5 Nov 2025 14:52:00 +0200
Message-ID: <20251105125200.468312-1-rongweil@nvidia.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00002320:EE_|CH3PR12MB8658:EE_
X-MS-Office365-Filtering-Correlation-Id: 679a5852-6c85-4115-71c8-08de1c6a51e6
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c4EbLtJeu+hxd4N28y1RiwTzs/8/7lmXmVAALa77UhVQehfjbjRRseXIxYf4?=
 =?us-ascii?Q?7kKjaA4PuOuiL4u2UV/TIUG749dUp+qBg4a2kxVNyPdLvlDeguDD8BWgqhdI?=
 =?us-ascii?Q?0iemOKZhJlcP02309tawhsnss0y0H2fh+GUMR+2VyKu0O92lb44HY9WE4WYo?=
 =?us-ascii?Q?9YF4QpXxNhw3mghruUR+QIVsQDtx2jPYAoWR3bHIUXB3xOcQsxo1bYOCKgmm?=
 =?us-ascii?Q?GWxf65bSG43dD6AZrkr7vnF1160a1vcOkNvVwhmLm70mgOh55P3PLtK2uAat?=
 =?us-ascii?Q?OTbnBVp0cquNhxXIWjzRQJz7tWeQF2BMDICKLnxzLU/Kwb68ANWTNUCvphKQ?=
 =?us-ascii?Q?M9g+gLGly2KiHrd5crwfe1iFfnpDZYsVfOVIiMFD1qvDuiprJSFmjFNrLj7m?=
 =?us-ascii?Q?BbiwLqkWnXRhMUiifbpfkd3Cqak9ZN53Hcyx0DlG6MknzKSSvEZIfuDZgiHV?=
 =?us-ascii?Q?eRVHnjHZpVmpt7/+ddXyNaxTV2yvzMxInX3IlEnwqdjNBo90PgTRmK43J9gq?=
 =?us-ascii?Q?Jxoo3qVL3bB9GZuhUi0x2hASSApnRxCGBLaYYnmGoPrTWje+rVf1PvrwAbRg?=
 =?us-ascii?Q?bXpX77R1DdY//L5ogQfExKUbijMbWFo9cK1CVMMyJKgcdXUC1MILNR5LWuXz?=
 =?us-ascii?Q?Qc1o2jF+hUGxvj/YYlq8JuEr4wck5QYjiWeKw3lghX3gI6XPIlNNulln9gEQ?=
 =?us-ascii?Q?7mKT3KX1y13CMowlPVOpjR7bZ+/jnJULIR1ASYdDBgVhXYO36zy0n1SRulrc?=
 =?us-ascii?Q?+UQX8wqrmiA/1v8Hz1D4v5hbbq7wVsboFtaKh0pd+Jnv6AUy56Y+5sNO1+TZ?=
 =?us-ascii?Q?meeeuKD4UKPJSnyN1+qPzVzeaEz9JJNfCxfqXA4SIhlGGE+dSCTsiT5TpOYS?=
 =?us-ascii?Q?JGprwNwamkJylNW/HA5YsNLZlBYmzMIIvd3ZwDSRLhQ14DFczuP0aX0ZCEzm?=
 =?us-ascii?Q?Ent2cxpIqfxkBU6x31Y2N4zuI2p0aMYgtc93E6Bh3Nna2GuWXF6nn4OmmiTF?=
 =?us-ascii?Q?Y+Igw8yOV+aayTb9wZekeCUQyI7uPuItEOZNIBLUrwfUIdm+YSYGLhYgy8bm?=
 =?us-ascii?Q?A2ddQDIndJ61Xj9+7DNkNz2kQAE+bm3w9hZuiPRasHAlUHYUO9I8rNgPV7tQ?=
 =?us-ascii?Q?IebgZ73pfRguPkgPlRDeP96F7cIbSnwGDsPKyKRxz5T5ooyNIBJRdl6ztTaG?=
 =?us-ascii?Q?1Yd27SQl5gwwySrgCMjGZhOrACYUowbWXe9mU6B1/6saCbg1Usi5cnTtaSdf?=
 =?us-ascii?Q?7cjl4/EDRkq0fyoYui4adRjDJqK5pN0n83/4tylm4KdvJxiuebB1M5568BLd?=
 =?us-ascii?Q?TDBQl+QquZlBCDMf5BR69te+HSIcNHetvR4jg6S0jJEl6BvPuqo5CwAFXzg1?=
 =?us-ascii?Q?Jv5rkQSvzEDjygsStEvtY/KdI/TWKWmq59XzkqD6kHv9FHjnthTCVbL82XgM?=
 =?us-ascii?Q?PaV+z3BROAh/Cx0extVsfzFBJWvmqzCoWSkWt4eCMbQwx/p5tiwLFd11yRAY?=
 =?us-ascii?Q?Xr+6ZgGOzQCkA/w/pP6DO8TM/R8WLZcNTlUrMLCTxED4Wa8liYLIUBEa9kdb?=
 =?us-ascii?Q?TJVXTOPfZgpu4CwvYfY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 12:53:29.9099 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 679a5852-6c85-4115-71c8-08de1c6a51e6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00002320.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8658
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

When failing to allocate a meter HW resource,
PMD may use an invalid index to release the job.

Fixes: 4359d9d1f76b ("net/mlx5: fix sync meter processing in HWS")
Cc: getelson@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index ff68483a40..cd11619b26 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -1934,6 +1934,8 @@ flow_hw_meter_mark_compile(struct rte_eth_dev *dev,
 	aso_mtr = flow_hw_meter_mark_alloc(dev, queue, action, job,
 					   true, error);
 	if (!aso_mtr) {
+		if (queue == MLX5_HW_INV_QUEUE)
+			queue = CTRL_QUEUE_ID(priv);
 		flow_hw_job_put(priv, job, queue);
 		return -1;
 	}
-- 
2.27.0

