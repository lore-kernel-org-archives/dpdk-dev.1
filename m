Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12ABCCCFA1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 07:48:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 22F064060B;
	Wed, 12 Nov 2025 08:48:20 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012053.outbound.protection.outlook.com [52.101.48.53])
 by mails.dpdk.org (Postfix) with ESMTP id 064A44026A
 for <dev@dpdk.org>; Wed, 12 Nov 2025 08:48:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v/QgtLG8TkdtwJK9J07dXxTTJJyGkHc2qPYsRgyGCLYxfj07WzBQcXVuADrHXu29j2SGEKtJBS5nT575TPPJQVF/4dSMbWfrPqZYz857DAUKtlMsalTNEuxWlTqckk+O5kTVaAHouVDuBeCX47XzIZ6zZDLwc+H4H9y/iSNvJXmq8x1ReDZ9x0NM8NMutAyd7jv1xd7pvuiuoncQNl0XY3RvvasIS4SlRXQoWrIsr4MlS0g8+b9aSEVMINpOSEWZGCDGA5MVOB5FPTDl1PC/1Ijh06QZd2FE9DwRyB+xiblqMKftkG4GB6Q+jYNTy76H18UbaKJxxbTxMKNNQrL11Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/UzfHrVG8N7wfTgMj9jc6Y8arRjkDucoLcSBsFs1cJw=;
 b=wHQG0BbB+MVVlrcGqRKGreBqswGy+uIHAEXAuOMRjD/8VFlK2Fy0Gq5QT57MObWV8s+/3xUvOZ5U+JDETNSaxcUb5FEA2qPrCiqTpFhpjogYYCzOy+uly252AGN2gnc5Wze0A4brRP/xcDBb5bd4hrPX199JlHWcVkFmPa87EaMpDOMdsUIuPOke8r9iNZ0YVLCOHNQZon1s/Rbp41Bxxvga7otCF7oDeMgjb7X6IZvDzYJKwO5ygobtWibBjBoaSgHGRHC4LjyejzdDWZQ1YdpfZMoNNlT/Na2tLidcbDokNLVgBecZOsTV2+Hm8sF7uqtBSkKofQ2LPvQTl+reFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/UzfHrVG8N7wfTgMj9jc6Y8arRjkDucoLcSBsFs1cJw=;
 b=kE4+9HruAqCL2eCxrmJCke+tdbCRt34VRt+c67d2a+iLsqDy2roV6mpMogHHGXt9ujL38NgY5O5y1RpAxav9i2JRQzO4sQR3lAfKAav1tixiyzrz321rQUHVz0yl1MFLrP0jM/84BAoLuaBixrofMU/NW7a5/ua/TfU27zhQtHqA6Q/l1xk0Jvd8SAtyGXTx4jKLCK1ZwuZn3HwG/LHYng63QaFiCUxjcLnYMYs0bOv++OnpjwBa55CKBLn+kisytCndiILuWmtlXQWxDvROP0spqrc8ydWzU1CjHS3y7HQYKoplFS+QNbCUs3MZ3RBlfU757zpQ5QV9AFoWWLZdog==
Received: from SJ0PR03CA0250.namprd03.prod.outlook.com (2603:10b6:a03:3a0::15)
 by BL4PR12MB9723.namprd12.prod.outlook.com (2603:10b6:208:4ed::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 07:48:14 +0000
Received: from SJ1PEPF000023D4.namprd21.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::80) by SJ0PR03CA0250.outlook.office365.com
 (2603:10b6:a03:3a0::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.16 via Frontend Transport; Wed,
 12 Nov 2025 07:48:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023D4.mail.protection.outlook.com (10.167.244.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.0 via Frontend Transport; Wed, 12 Nov 2025 07:48:13 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 23:47:57 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 23:47:54 -0800
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>
CC: <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>, <bingz@nvidia.com>, Nupur Uttarwar
 <nuttarwar@nvidia.com>
Subject: [PATCH 3/4] net/mlx5: fix incorrect buddy mempool init
Date: Wed, 12 Nov 2025 09:47:39 +0200
Message-ID: <20251112074739.8996-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D4:EE_|BL4PR12MB9723:EE_
X-MS-Office365-Filtering-Correlation-Id: 5dd84f48-c475-47bb-f17f-08de21bfd5b8
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wnmyV+nvD5NEE3lV57F+Q/CLkLQqY7S+YMK6FduP1bkfQkXp28MV6eUbcXhq?=
 =?us-ascii?Q?h8uPUDnizLcB8smfzfHt9wVihQjdlTxJqTz8dHNfC1PoTUunwRcFykBMOEIG?=
 =?us-ascii?Q?lZSHRZvjfdiIIyXEM3aRbIpinE9vR+HrvmruLoj9Nm9o2prcYcPqFY8aVTrS?=
 =?us-ascii?Q?sCUBm5BMEeSE3f7HSi8Jwdu2Lu63Gi7cbmvs3jkLLKyGscJJ8D5hzapSgt+B?=
 =?us-ascii?Q?wOjwA4prscbD4HTyv/v3lGOT5IhEH2FuM17NU9dGl8k5GjIp78OaNfGE5eLT?=
 =?us-ascii?Q?rMn20LcCH5cNW/3Y7Dpm3XOtd5tJwUvbBPPRf4+lmTeVnN0PwfggJlCpY0Jk?=
 =?us-ascii?Q?UcmFauv9EFWQZtRFGXiIvgj9N2xHQTl9uIKrteMWhS3QOHK4XB3knA3pUyKR?=
 =?us-ascii?Q?9nvejUfeQupJoTwSxlFfxOBzlYXD9M9m/DnAiJSZKCFnWFarr9CE3uhsbsED?=
 =?us-ascii?Q?A5CNeo2jtACNVD4yFFfdoeyt1YT0RIC5pNavHgRLKgZ8yXzuUVZEzCnWdLZh?=
 =?us-ascii?Q?vPj8YawbuTF9rZ0yu30Z7Jz6XYdL4amqBE5hb/Z9pUqPpr0tK8er0icRCWTk?=
 =?us-ascii?Q?VIcq864VTKEvlPci1yVBRoo3wPFSnAl8I2A+kOVPgzsKbbW4+5mzasATouz8?=
 =?us-ascii?Q?77OF+ruufQwMmUfKadVPZOljAGBLYr2k/hgptOz56OIvrIG36lWqpumMw0Q3?=
 =?us-ascii?Q?qBxd+rmq5oDJeUrMfolaUEb/7LUur/AsHMmyWl4Ih4pkWcOArwZDep/bkFed?=
 =?us-ascii?Q?jhRkuHSDNmJvcq7N/A18JjSKIxJA/pVf0tLPOARZqCVbhlUvuSccdqhfR46W?=
 =?us-ascii?Q?sk9GdcPzhDJcNwRcNZm+runBGhW7a1nV8jyJ/Oawm+KNb8LlhhLPqmPETzaZ?=
 =?us-ascii?Q?ZQAqfZiPhN/RCkG1+TUmL2xo9oXdv9ZTlLSGeRYhQ9b7oLIOE/xg6YhpFI+l?=
 =?us-ascii?Q?QyYWmQQG2yMTPgV8aFSLl4zoJM2KJ3E/3f9xCvNt2ESHa2UEWA/eptfUJ6PN?=
 =?us-ascii?Q?sF5tGoHfICC/RK0P7Q46ex5WRp7UP4OG6DWf/Cr6LtdSmwNmXBGztqM7UR76?=
 =?us-ascii?Q?hCiTmlMCpiCOiXp5CFAd4eADApdWePtVKN/R0DmMxnEuVK7ygKDlNDawuqns?=
 =?us-ascii?Q?7lFgGOVBiwFeb/TswjXoYfDs4wLlQ3HFbLuMyPUni+FdYlZDVXeM6cGwYzpo?=
 =?us-ascii?Q?Q9t90MnuBD1I2Xwulitk9mQYtbOo4VPbRTyIMgk592VFR1d27J+Nyo/KPGBz?=
 =?us-ascii?Q?iOQPwdOPjy6afKv4Rq3krZTuajxPpV9fLFyVTbbvaKLmqWQRm2hUDDoZNuEa?=
 =?us-ascii?Q?AGswnolYJxn91YkCYmsCFnjB3zPu1deTInVph77T5TmPiWNjNu0SJxyJfeoA?=
 =?us-ascii?Q?x0eWcQzukw+RKVoBKFQjfGdqprBz6NYVfw4kq8DXr/BrY5rQbtgjupEN7K+k?=
 =?us-ascii?Q?L5rIphQ2LUDu+r5kZqIIHI+8N07KJWnnQAL5YUoijNMRvIwCFNMLH0kKgBV3?=
 =?us-ascii?Q?s4LKUWnhoHJTThMDESF6jpix8JVqk7qQJURKJvqHu+JIZQpNT1NjMyOZVhj7?=
 =?us-ascii?Q?QmopIegOt2fUpuSHFIs=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 07:48:13.9751 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5dd84f48-c475-47bb-f17f-08de21bfd5b8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D4.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL4PR12MB9723
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

From: Nupur Uttarwar <nuttarwar@nvidia.com>

`buddy` was erroroneously declared as static. When multiple
threads call this routine, they set the same static variable
corrupting pool data and can cause potential double free when
releasing resources.

Fixes: b4dd7bcb0dcb ("net/mlx5/hws: add pool and buddy")

Signed-off-by: Nupur Uttarwar <nuttarwar@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_buddy.c | 1 +
 drivers/net/mlx5/hws/mlx5dr_pool.c  | 3 +--
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr_buddy.c b/drivers/net/mlx5/hws/mlx5dr_buddy.c
index 394ca71217..abfbdf1be5 100644
--- a/drivers/net/mlx5/hws/mlx5dr_buddy.c
+++ b/drivers/net/mlx5/hws/mlx5dr_buddy.c
@@ -147,6 +147,7 @@ void mlx5dr_buddy_cleanup(struct mlx5dr_buddy_mem *buddy)
 
 	simple_free(buddy->num_free);
 	simple_free(buddy->bits);
+	simple_free(buddy);
 }
 
 int mlx5dr_buddy_alloc_mem(struct mlx5dr_buddy_mem *buddy, int order)
diff --git a/drivers/net/mlx5/hws/mlx5dr_pool.c b/drivers/net/mlx5/hws/mlx5dr_pool.c
index 8e3718ac42..e383027d3e 100644
--- a/drivers/net/mlx5/hws/mlx5dr_pool.c
+++ b/drivers/net/mlx5/hws/mlx5dr_pool.c
@@ -167,7 +167,7 @@ static struct mlx5dr_buddy_mem *
 mlx5dr_pool_buddy_get_next_buddy(struct mlx5dr_pool *pool, int idx,
 				 uint32_t order, bool *is_new_buddy)
 {
-	static struct mlx5dr_buddy_mem *buddy;
+	struct mlx5dr_buddy_mem *buddy;
 	uint32_t new_buddy_size;
 
 	buddy = pool->db.buddy_manager->buddies[idx];
@@ -271,7 +271,6 @@ static void mlx5dr_pool_buddy_db_uninit(struct mlx5dr_pool *pool)
 		buddy = pool->db.buddy_manager->buddies[i];
 		if (buddy) {
 			mlx5dr_buddy_cleanup(buddy);
-			simple_free(buddy);
 			pool->db.buddy_manager->buddies[i] = NULL;
 		}
 	}
-- 
2.34.1

