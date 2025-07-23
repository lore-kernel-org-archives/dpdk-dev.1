Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42CD5C83F17
	for <dpdk-dev@archiver.kernel.org>; Wed, 23 Jul 2025 06:50:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5EBAB402DF;
	Wed, 23 Jul 2025 08:50:14 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2073.outbound.protection.outlook.com [40.107.93.73])
 by mails.dpdk.org (Postfix) with ESMTP id 03636402CA
 for <dev@dpdk.org>; Wed, 23 Jul 2025 08:50:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JafGKg6qoPsfznluFWhMeW4hO/Zb4SfwMZP78Z763Mpyt0gtGZgZs5uIDuVUB8sePoWqIbELdcVaXc79t6dTHnFU2RoKNouflO9utoJUjOaduVek5tDN96N0PWrTw8+S/Wlh84vBJE8q9XcpQcJ9RsB+gq9UbPHijSzlCYX/19WBmye2LJPeLq2GajIuUjk7QpIw3okCD+4sm+LsJCSUMxnaaUez6cITmXMg5Gl108U2RyLxY3C7+MPq4bRLmLxz/8MRG35s/z6lVQuD8NnO3llzDml2Xfcjevkd5xajThzT8n63N3TrKATVNJE5ZMc79Gvy1Dn+l1JpJgx3rLY+EA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x8i4F77lZtLrMdgW3Ojxsh7sE/UZ1MG4Pkuz/byTQWo=;
 b=E8Bos5/uaxEvhJwIlhz8sMVkDkLd8wItY4+AWlGaItsOtwcMEnb/C4AD7TbH+niqXTZ/mv/H358/pU7KZZ5kAFE8psB9icIqQiNHFqT0h1Elgp+PWmcAHSC7U835ZWyx09cbORhN6sk7HwcFy9C3dkzj43UgY8Fd28g2da/zL2ISrZd5XfzLkpZyCq641OmGRbCaE4eZNnsqOp9nafrObXx8ljoPHDffX3Ol8+TqQTYNm5/7o6TI+VtA7ZTEgPNiwfcdu+qypo413huSDjwanOnE3zE9eQ3eErKVGD5QDJAtorw/kGk24DOeTM6P1Izz2odlhrD+sQ7R75KaYsAaaQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x8i4F77lZtLrMdgW3Ojxsh7sE/UZ1MG4Pkuz/byTQWo=;
 b=YfotyM7jkW3JUsQJ5zOp2VHomX1NjCVc0UnDGU0K3AP+WUPpmNdqAPhnbHTSVwPG0M30xFukFMfF4HN8CRySe3DghFo6BRsOhZOteynwh23FpzyhovWWJsHSMKGoeeuJZtWzrnt+3PQpRJSKm1ggvkcC5F/+t0JXbHXnVPyNq3CIMh4tYMz5nQIxtRFWN4+LxY9m+mpwFo3WOUblZ6+vKLi4LJxh3O9hr9wAriVrdWPGv2bvU3Rf10T1cY0b0SiEq+gseyNPffZ6Ihfd77nnSLFvS/B3cedT/uj4bVProKbg7qAIizhlS4V8aA6g75oSjD3PlmCvtHonvWBsUihKGg==
Received: from BYAPR07CA0070.namprd07.prod.outlook.com (2603:10b6:a03:60::47)
 by SJ0PR12MB5676.namprd12.prod.outlook.com (2603:10b6:a03:42e::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.30; Wed, 23 Jul
 2025 06:50:09 +0000
Received: from SJ5PEPF000001E9.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::ce) by BYAPR07CA0070.outlook.office365.com
 (2603:10b6:a03:60::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8964.21 via Frontend Transport; Wed,
 23 Jul 2025 06:50:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ5PEPF000001E9.mail.protection.outlook.com (10.167.242.197) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8964.20 via Frontend Transport; Wed, 23 Jul 2025 06:50:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 22 Jul
 2025 23:49:47 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 22 Jul
 2025 23:49:43 -0700
From: Rongwei Liu <rongweil@nvidia.com>
To: <matan@nvidia.com>, <viacheslavo@nvidia.com>, <orika@nvidia.com>,
 <thomas@monjalon.net>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Shani Peretz
 <shperetz@nvidia.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>
Subject: [PATCH] net/mlx5: fix ipool memory leak
Date: Wed, 23 Jul 2025 09:49:22 +0300
Message-ID: <20250723064923.1805575-1-rongweil@nvidia.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001E9:EE_|SJ0PR12MB5676:EE_
X-MS-Office365-Filtering-Correlation-Id: e78543b0-277f-4e54-9174-08ddc9b52a1e
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nL47WViQSVTbZagVybIHsOF3lY1tTe4NT2Er0shtqxB7tUUff2mCLCKESh5j?=
 =?us-ascii?Q?v7ZFu0rOQ7KAfeS0neZpvImkx+Ii6e3cHE9jDxhPzqW3XvHJGvx4B1KxyYw5?=
 =?us-ascii?Q?72UgLh5G/gWcr2NQIiC14/N+zWwHs56yRe+z+1P779bKOSggkMZ/IAcLZ1+V?=
 =?us-ascii?Q?ZFbfuyznhXfqng+cNDhmmA3/3uJ/IfrR13K0AwEpnAqYkJ+HMI/Z034jZIK7?=
 =?us-ascii?Q?rpVdZqekxinJnzE0MQamGmfM8v1YY6CmvFnLk5Zqea+o9ZGtzoLbC9vsOvE6?=
 =?us-ascii?Q?6vJ1uMum340lg7bhV7Vkzn52iVBlrgyyl8z11QjoOvzT7zc72TjGgBN2edxE?=
 =?us-ascii?Q?tFPTeRgVYAbj3SW1MebXCNRVGD7XBPG/exKGBqDpgenC6S4oVeUhQp5c/+2p?=
 =?us-ascii?Q?o7M9zMRwJVx7Jf6ux5sgl09SNCsfim1RlV6UXkjgh6btrlzPHoZE8E+oUXk2?=
 =?us-ascii?Q?tUsBCMmgheWIrT+MH/jo4kxuCYhoVOE2rd8M78JRWsTY7Fnq+a467B+jExfN?=
 =?us-ascii?Q?DVXPDmlQ28UdEmCjGJdPgmIOlQxjluPsXfB+J+HWxjZQukr7XYJl/07UjrQ0?=
 =?us-ascii?Q?EseACFZ6BJGdp3LYRV1q8+po2X9KCgKx68g3NzIEhRH008LrLYcHnqP5pIa8?=
 =?us-ascii?Q?3Juh1Fc6GAYeh0h5gfGwWQFJauCYQGuCoi3hgP5NxQnjBvsw8k8t7nRKa68z?=
 =?us-ascii?Q?d/1OlRWdT4nUgcIkk++sjzdj+1VGJR3viCWthk/vS8vK0+FX2mawXeZ5aYox?=
 =?us-ascii?Q?ZFIb/zvTcQz+5SdX6jkDRvGUhOEEt7PMBb2Ar+EneHYl9jp92l4rpjQ20SO+?=
 =?us-ascii?Q?vQiTHiPeXaLVEYZZr9CsiLckXHV5kwitJ651PT+Lrxg6qhlAfn7WTReh1G38?=
 =?us-ascii?Q?EpStV8yl2SKTQGOfDAgF79M5MN6XPmiFPShBPPDTku25VWCOJHt2Tejtd+0N?=
 =?us-ascii?Q?n4ZWDgyOJnBth8uM2oDE6YHI7+ELNaSuYTcuWPRl4YYoh0ZXrGlSH0MSmdtG?=
 =?us-ascii?Q?DhOEu2q4iDiXvY7oBy+duvkofRd3gKs/tWf2idFQD0CRvvF8pJ1OkijBk5xG?=
 =?us-ascii?Q?zBOqfXcj+s3kmZEE9V/9r8SOMwyrsbshMToatH14QjqEx8fImkgly+JbV0jh?=
 =?us-ascii?Q?sBUsy4MxZVJBlDifvW7GHUHWroZTMukqzVcJWKAdL0Plop7WdAntrp8bpOi0?=
 =?us-ascii?Q?kXaAJpxZWbcBVtZcMalaEXlOYf3HiRvz7XdLRmDac7dxaWwQy6vxtU/Ct8OG?=
 =?us-ascii?Q?TmtYcFrH0X9iHXSw2h+LWkmjJ/b8S7jpGgKtLMVtxcO3hyNWkerACF2YVowB?=
 =?us-ascii?Q?S9EkefWXQpxPHx1bublbDKdwgFvJ7tyaVeffPp1XIhdf4LNELA+jZ8oJWfDD?=
 =?us-ascii?Q?NAVE2obgDAlHi6DgiPfIe1uNoZZGOUUHJ8evowvrLxTR5aWjel96khauxI5V?=
 =?us-ascii?Q?XXunvGOKl0yHbyU7kMl3rMbJQZtLkJMr+PwMeouG7Uy2lYEWRhHAJx1ViJqS?=
 =?us-ascii?Q?1/6Mxq9MT6DVTm0ZchhIlLJyQIj5Wocts2Ss?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2025 06:50:08.8054 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e78543b0-277f-4e54-9174-08ddc9b52a1e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001E9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB5676
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

When ipool debug is enabled, there is internal memory
to maintain the ipool cache allocation. Need to free it
when destroying the ipool.

Fixes: 3a2bda363 ("net/mlx5: add ipool debug checks")
Cc: shperetz@nvidia.com
Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/net/mlx5/mlx5_utils.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_utils.c b/drivers/net/mlx5/mlx5_utils.c
index ac218868e6..58249b596f 100644
--- a/drivers/net/mlx5/mlx5_utils.c
+++ b/drivers/net/mlx5/mlx5_utils.c
@@ -871,6 +871,10 @@ mlx5_ipool_destroy(struct mlx5_indexed_pool *pool)
 		pool->cfg.free(trunks);
 	if (gc)
 		pool->cfg.free(gc);
+#ifdef POOL_DEBUG
+	if (pool->cache_validator.bmp_mem)
+		pool->cfg.free(pool->cache_validator.bmp_mem);
+#endif
 	mlx5_ipool_unlock(pool);
 	mlx5_free(pool);
 	return 0;
-- 
2.27.0

