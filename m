Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5C59CCFA1A
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 07:42:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A659B402D0;
	Wed, 12 Nov 2025 08:42:10 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010009.outbound.protection.outlook.com [52.101.56.9])
 by mails.dpdk.org (Postfix) with ESMTP id 83D0D4026A
 for <dev@dpdk.org>; Wed, 12 Nov 2025 08:42:09 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wqfy0o+yEZ6gD3OPJ6fmxl8qQL/KcZBWuzkyvfkm4r5v1RVZf8d8sghoDpldFdbDmjYOblcTJ0ry2UVO6GtIjl27KI7mpw76/Bikg21sTcQgv6VELVobNAnfeWmUTFKL2SHIjSn3y+kXlWr/Pib/c6OPQWPM2ukA7YnEQxvSVwzy1HlpioSAe/qV9HuFgPPybVk6EhVXIA25oFSkzoJrwaLePcd1gTB4IGdnvx9nUxWpDp63YGdmKTpMMDl/fk+PonHjAat/jMMfJsbB3rIRVZ+kKusqk2l8jT3QTMShzWWbbPUJpcGb6Tr/yuxXLPrvvgZZr7wwdz9zL2qoU9MSiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rD3kajTkqa3yIYCcx7jweiFOC5KhGT66hVLstNHlKaw=;
 b=AkBxxDzCsIwlK/IbegnPScJtIM7edDkjv2q9HSpWBj+R2OtG12aiGKVeIOwujNQf13UuesqJAndY/LQabxdYSpD7PBDe5c1abO60ID+YhtkMfGpWznuTZjpFI6kg6bLTpZWPCgD04pEcRw/MQT6rFsd4YWD/7AFwvQaChm+zDYuSofVS5yCMSguEKlwcjdhAEfOptBDIrcS79BJ2kaqmOE1ykE1YB/I6tFhI0qflNc2iq2IGK7oW6lkV57zNhO4TR5KNd0W7IGy/ML8+xpcJzcgfIS8B7cW5dSqmB27jO3dPgoquZZ97tBuBBhP59zt8FBdC9+n+p6nLI7IuHT/kQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rD3kajTkqa3yIYCcx7jweiFOC5KhGT66hVLstNHlKaw=;
 b=gHNZnwks54euYdPMQijfSbPGmRQm5EwQFOSM5k1cQ0HHBq/5CuPjLTk+NAhpzrL/rvZT9vDz8EHM4T6AUu6lz3/kxY+Bi01W6fgbvnsHrjnoywU3+n6Walrf1wuiTmlOFMroU3TvzSshV5tLDRjl8VPtvR8AZgTe3WKBSNxhAkp8+MpJnuBIv6wS0rq2iHXF+TmN2EMs+RqS6ZztYipARsRrJMrrA5ObJA2QOxn2Ws1DPlEUp8SGvCIfrLuryo67iVB9adVK2fcfu5l4IuuV9S44KUTyG0J2NeOvqWNaPQ/hvfF3tBVDiBZjdJIx+BlyYDKQaLHgnBgo/iMkxYbEIQ==
Received: from CH0PR08CA0018.namprd08.prod.outlook.com (2603:10b6:610:33::23)
 by SJ2PR12MB8781.namprd12.prod.outlook.com (2603:10b6:a03:4d0::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Wed, 12 Nov
 2025 07:42:06 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:33:cafe::d1) by CH0PR08CA0018.outlook.office365.com
 (2603:10b6:610:33::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 07:42:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 07:42:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 23:41:50 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 11 Nov
 2025 23:41:46 -0800
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>
CC: <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>, <bingz@nvidia.com>, Roi Dayan
 <roid@nvidia.com>, Gregory Etelson <getelson@nvidia.com>
Subject: [PATCH 2/4] common/mlx5: release unused mempool entries
Date: Wed, 12 Nov 2025 09:41:31 +0200
Message-ID: <20251112074131.8929-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|SJ2PR12MB8781:EE_
X-MS-Office365-Filtering-Correlation-Id: 6849755b-f6b4-4b2d-6a9c-08de21befa43
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EXRgm/FaiJ/r22wWf4uPn5tpI7OkkyMuwzZj77ERm316wEzotiVTFUlGh7QP?=
 =?us-ascii?Q?5Gzsc21PQB7hacunYJg8txGLfizW228qldSBs9V5LjVYgtiE3ri8jFTNdeCs?=
 =?us-ascii?Q?zTbbyzA/gtiNG7Z76GPybg9UeYGYD9Z/Obcc61OUtLCzRdBnnp8Eg/YSqSfv?=
 =?us-ascii?Q?I121j7VGN4jbE7E+hzmdwLPGDOUIEboBw1VpBlKwsfL1pvTd8WAPWTWd+TOj?=
 =?us-ascii?Q?rIbuwK3qFj4i24C7+iH/vNdI1Nw4dhUo2djnuDPBfFe1ih9xn+5lzegcSLOf?=
 =?us-ascii?Q?VTGRDsEvU309BgO2Ym4/O9VE9KkgBS+RIQThyUzFBYwnN1XHb7zSz1EHh/lr?=
 =?us-ascii?Q?8JXl5xxKCPfpqjTBmCEnedSZqDJR0LicisVsoKZMtTYEtv7AX6Kf//oFSqQY?=
 =?us-ascii?Q?AseIeLSqkQkZ2XhbHqCqtpKQTFzto+TqdxM251qjQXB2Q3pLON/Gu9db1fql?=
 =?us-ascii?Q?bubkGdpHXs9rQhuSOyUtMhdkngNWio9rrYvwLqyrt+yqjhdcztqqMPMimqGF?=
 =?us-ascii?Q?U4Qezj70zdA4ZN7ftLzNWbVlgQKprHK7vIVZjMGxJx3ly/DlEX/POjgULxEf?=
 =?us-ascii?Q?FilHerMQoG+MBqgISEgNs5q/pmyb+/k0/9uVOSqIZxdkBJpraSAUVlhD1All?=
 =?us-ascii?Q?tLP0kJeGW3KMjWoFOosvIN7TjChcT9dS1WIBNACY42rHWftBbXOa4eIoyEfi?=
 =?us-ascii?Q?ozlpuM7nps0r33PzIPLfyaG7RGHxEor3bK48WxMmvM6ibs+q7noJcrl+BY4x?=
 =?us-ascii?Q?eh5majwYMz5ft30mXqjb5LM7PhJSnniMCr7LYEwNaL7ye7pfy0YNPXp2rJmL?=
 =?us-ascii?Q?o273ll+Jw/yZrADQmy+M5bx0qN8mvJeB0aY6GVanw+AmbWRtjChwHPn7NkY8?=
 =?us-ascii?Q?6dpuvxg0K7PGlMTxU+Et8Qxonv7Mr5cCdmI9zInkoghS5yu+NU8KcYgq9nVA?=
 =?us-ascii?Q?J8+ZoJQFnPtM3/J2wYTRKx7irXeITp/Ig4izaW877DPErURIcuSQJejJDsv/?=
 =?us-ascii?Q?ykFFN0ITdLIZVsTSrF0+Hh/92/Bn7C4n4Y0D8lUYp/6g7QH9nZjJ6TiUI1RZ?=
 =?us-ascii?Q?GfXf5sNo4ebl4AfG34k/syPjiCzD7HQTsLEjgYh0jkVwLR4nA0dRl58a6qYA?=
 =?us-ascii?Q?B9MZb7dv24i1C7tacpA/zjg1ak0aDlXbZv0LH6kiFc0KVAOr60ObS8C323Y6?=
 =?us-ascii?Q?TuPx98BVDPYefsM0/E70hXylUC1fWtHjLxwYpw6ptxjcE58/IxwEyCTT5tqr?=
 =?us-ascii?Q?2Px8THfhS+ozoCu32eQCAiV8XvuSlFZm5XX2/AzSFKMdK6c1869ICaCo4GMN?=
 =?us-ascii?Q?8ZKSq/5HT/vaQkF5nPZFsKoBnhNn+8uLsKghPvrS5RBzgDWgAa/TgZp8WQTI?=
 =?us-ascii?Q?/6ZQw6N7lgf0Vks3W0RLurMkrESSBQAlJ0XddfdrJ1tbtIXvPdzhcC9Cqzy8?=
 =?us-ascii?Q?UZ6jZ32RfHXHYaxxacU85h/mp/e9B7o4ZaEBKKF1nFZvQgQRvxf3LwzVmWaO?=
 =?us-ascii?Q?9dfmEI52lx1Xk+krwsDqncsr1BIP8rUEr+4YS0z+4bNS04z0u70qrkpgwPQG?=
 =?us-ascii?Q?loj5Ch2gjixM1iZ3hKA=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 07:42:05.7908 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6849755b-f6b4-4b2d-6a9c-08de21befa43
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8781
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

From: Roi Dayan <roid@nvidia.com>

When creating a new mempool but assigning a shared entries
from a different mempool need to release the newly unused
allocated entries. Fix it.

Fixes: 8947eebc999e ("common/mlx5: fix shared memory region ranges allocation")
Cc: bingz@nvidia.com

Signed-off-by: Roi Dayan <roid@nvidia.com>
Signed-off-by: Gregory Etelson <getelson@nvidia.com>
---
 drivers/common/mlx5/mlx5_common_mr.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/common/mlx5/mlx5_common_mr.c b/drivers/common/mlx5/mlx5_common_mr.c
index c41ffff2d5..8ed988dec9 100644
--- a/drivers/common/mlx5/mlx5_common_mr.c
+++ b/drivers/common/mlx5/mlx5_common_mr.c
@@ -1717,18 +1717,24 @@ mlx5_mr_mempool_register_primary(struct mlx5_mr_share_cache *share_cache,
 	 * hugepage can be shared across mempools that also fit in it.
 	 */
 	if (share_hugepage) {
+		struct mlx5_mempool_mr *gc_mrs = NULL;
+
 		rte_rwlock_write_lock(&share_cache->rwlock);
 		LIST_FOREACH(mpr, &share_cache->mempool_reg_list, next) {
 			if (mpr->mrs[0].pmd_mr.addr == (void *)ranges[0].start)
 				break;
 		}
 		if (mpr != NULL) {
+			/* Releasing MRs here can create a dead-lock on share_cache->rwlock */
+			gc_mrs = new_mpr->mrs;
 			new_mpr->mrs = mpr->mrs;
 			mlx5_mempool_reg_attach(new_mpr);
 			LIST_INSERT_HEAD(&share_cache->mempool_reg_list,
 					 new_mpr, next);
 		}
 		rte_rwlock_write_unlock(&share_cache->rwlock);
+		if (gc_mrs != NULL)
+			mlx5_free(gc_mrs);
 		if (mpr != NULL) {
 			DRV_LOG(DEBUG, "Shared MR %#x in PD %p for mempool %s with mempool %s",
 				mpr->mrs[0].pmd_mr.lkey, pd, mp->name,
-- 
2.34.1

