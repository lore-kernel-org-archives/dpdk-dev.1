Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A42BCCFA04
	for <dpdk-dev@archiver.kernel.org>; Tue,  4 Nov 2025 17:47:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B357A402DD;
	Tue,  4 Nov 2025 18:47:54 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011043.outbound.protection.outlook.com [40.107.208.43])
 by mails.dpdk.org (Postfix) with ESMTP id 5B64C402B6
 for <dev@dpdk.org>; Tue,  4 Nov 2025 18:47:53 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KwbRpKKY72syNW7y9E1MZxzpoNgZP6Bl2bZWXDWQiXWh1oWtSfh418LKe0ANY8STJ+L3cqbmNSO1fHlrXuRwVIjLjdnMkrQRvdPAK5hM/9nLuAGy1UYY3BQ0OKmzThXx5QY9CC/ePzUVVigRhaqfR3Kt+pV/tPgtihwHB1RNaA09HtWjeJq1Y3uZIO5brmtUEauJyqTnlK15rgBB8mkxqhadzTsYWBRRpABpFGmN8pPh9HQEAUObmtSV7kBA+jO7FpIQ4ISgHhCirkbTLxDz2uIfsIa14+HyFJgqb4qDmYWWc3x6OxEudvLa3aTpk4LEl/keT4mS6jmMasTdwg8Teg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeE3LfNvhRH6NSY8lYtrZbs8TsoOpcasbHObuGvVh/8=;
 b=sCjV6YxezpPYCvkNK4Eexf/oNzJ2es9/50VGQhJzz9kXkiv9kuwP6OsVZ+gCUxwCDlW8yGIneUcLr21Hs/qKK+0omyA9o4TS8Bs+uE6onCaxjw4EpPtKtP8NjB/YtQ5Qcx1tfIdttEW7Qrw5UOC97IJ+0VzhA5zWItZMepG8GgoxqxoBl2YdJW54wtwwM/EGmWRdX4bmwYbQjWDKJWZyVzhe2W6p4Xy/jcBwcrLoqUL9cTDbIMoo6XPyUuNTSz5ADDsX0ChgDNDFgPuKbdxwapeH7tr5Qj/pRMgFlyK7Hw957tGyOQjIZhidm0xKi/EM6iQhngziR8x+yr8xPY9BSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeE3LfNvhRH6NSY8lYtrZbs8TsoOpcasbHObuGvVh/8=;
 b=duA9iZqx4g08KWlSvcA5X4XXju3+b/I+PKf0D9c8L52f9odzA8GdQI8F23I1n3q8YIP0G2k7goBMD6cjlzDkhf+7hY/5Mbdb2m6u58r6rnVelpI9BC1+NVWRbzLVmVNKwMNQmn4VzMkSxN2u1s3Dtp5bJG9Hb5EeaKEV3apeLbVNLScBB3RBi/fZDObJH3SiP94OSnFA7lnoaJGOki/4OoQlqQLArLyZawAQDpifZQlsWx+Gx/wQpZzVlvCFUrpCcgEW/yUsHhcdZt1KL7YEeVBYzuAWOyPU0eZJhRd94eA0aa/JrzapxvV3B6P2v96c4DCFJCjfcVrZN0uiB5zpvw==
Received: from CH2PR17CA0009.namprd17.prod.outlook.com (2603:10b6:610:53::19)
 by MN2PR12MB4207.namprd12.prod.outlook.com (2603:10b6:208:1d9::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Tue, 4 Nov
 2025 17:47:50 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:53:cafe::e) by CH2PR17CA0009.outlook.office365.com
 (2603:10b6:610:53::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Tue, 4
 Nov 2025 17:47:49 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Tue, 4 Nov 2025 17:47:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 09:47:33 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 4 Nov
 2025 09:47:31 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH 1/5] common/mlx5: detect DevX counters support in rdma-core
Date: Tue, 4 Nov 2025 18:46:08 +0100
Message-ID: <20251104174612.1341962-2-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251104174612.1341962-1-dsosnowski@nvidia.com>
References: <20251104174612.1341962-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|MN2PR12MB4207:EE_
X-MS-Office365-Filtering-Correlation-Id: d0ccf252-4af7-47dc-8d67-08de1bca461a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?l6bj7exgrdEpZMh6WLmvlSsZH54tRxh2S2ub+hj3q9448q3bZ6TXEBxTXYFV?=
 =?us-ascii?Q?kqET6PiivAqHZd9hjlw6GooMephkAIZi4yh6jVPJgbhHwz/k+lm3XcrueB13?=
 =?us-ascii?Q?H9SSfqvsvjLGJN4ea8SA/WADdVjsrEY67Nj2LHEY9tFM/tN2tp4joUQscesK?=
 =?us-ascii?Q?c3je3dvN4ldMhiKt+oYdI3MVXHEuq/BoTSyccj9RXfy/7hfgDYghby1C4LQK?=
 =?us-ascii?Q?RQf/byctq/Z/6BMtwX1/KTq4Ijo2ZKqQ0WbaGThlqKOIN9XFaqLmjuOloAel?=
 =?us-ascii?Q?2A+9j1V5yeIxOQoTEhnd+zwdCoLDW+3PX3mw7Fs12mRNMiSXVtTe3D2tligO?=
 =?us-ascii?Q?SGiSyCM1mWP5mlLsTNDJ8bSKAc3/oXwOvQM9pHzGbbEq05N5H1kqYtyQk9tQ?=
 =?us-ascii?Q?Q8FSJdW5f6o4S3hc69XyUoAwIpYDRxiXxF12mimP7SGViIEunZvcE8w1TePa?=
 =?us-ascii?Q?j3GL66ZXVs2qezqt2dJ6hOGBZJmIObXNUOM2ESg49FvNY+H3Hz0QpgVDGnFd?=
 =?us-ascii?Q?YrvPeRn8KSKTnOM6terb3QpL1Kb7nzhSXjKCthB/ECfFxDPJxtuPcKPxKXgl?=
 =?us-ascii?Q?WqzjR7ctCgDLVqlLBGNoBUMnLoWr50AoEFXCnDE/PutS3F3phCoB/1u9K11c?=
 =?us-ascii?Q?Rdz3iPiZUn6uINdJW2ULFbU+XRPGe8pZomMn7iEFS/2KbyQrsPTMuLCw1wMx?=
 =?us-ascii?Q?3qWu+kftn6HdU6JkNaohuO5Js8oY4bVRkcjpAYu56pZql7fYU+ou77Hf18kq?=
 =?us-ascii?Q?6YpznPWVVesP9C4ZV3iCJAsALB0B+Y+PLVZXiog5KlOzkG8wWiQI7rLA9YYk?=
 =?us-ascii?Q?59uMIzIBRpzMEMwpV42xrFOkIwVMwfILaUEvllaviebNkkhO+vMujEl5SEV4?=
 =?us-ascii?Q?zzP17rcwYB72pYdjhh7fzeLj9IbG2sVvh/NkSn/U+9m8jHSOZrHxq2GxfVOc?=
 =?us-ascii?Q?mAAAOVJEkISgYSI1z4XsiWgx/WWAfyhSZaoFkiNEUmGbrFBbGtxhXMvs8wNJ?=
 =?us-ascii?Q?I+V7DZ+01NwBAbqL9xcfSLr6ASzevvAHO7tUpXyi2z1DpZB0RCkkXM/bz53r?=
 =?us-ascii?Q?H4Pgsj7PJnvVxF9K+9E349twAbLWAgLKWqptgPgmHJdhjhH8QsUwxEF3Xps5?=
 =?us-ascii?Q?MzferKoLRK5U5d+HvnABR68QZxsG2QExOBE3WfvwmfzPHPflTO0aFueFe9ME?=
 =?us-ascii?Q?ivJoMIRm8akNurpnc8NIBAPxMFad5Ms9jhkeyR5Eby9kXRb5cM1f0VqWP+BQ?=
 =?us-ascii?Q?fGRrlfq237WaAJM+3ky/qtt3n1OSm3YdLF4yN8d07yyMb7owM5HCk7IqOA42?=
 =?us-ascii?Q?jSBYlzuJQvNJol0boZ/El0T+URLc0CBgAMI/DVr7B17JnPs9VQgqfxKsnPuM?=
 =?us-ascii?Q?JNeUttHWYZtjyB0d8cse19MZXvCUjq1VLngqDRvvKJJru0okS6i0/PuzdLp+?=
 =?us-ascii?Q?fQV660ku3TewApCBTMNqiH9A61V9Q11uqE8RyV9NDIak7trtceVXMGx133CK?=
 =?us-ascii?Q?NrHztp+wXuPmSy438ot6DuoXZzcfWdjf/JttoKIfvO42OgUQH/DUAvasK+6o?=
 =?us-ascii?Q?yDwrIEFE2y6NnPVSlwk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2025 17:47:50.5076 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d0ccf252-4af7-47dc-8d67-08de1bca461a
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4207
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

Starting with rdma-core version v60.0, there's a new action type
for mlx5dv_create_flow() which is used to create flow rules
in root table.
This new type allows mlx5 PMD to attach flow counters
from DevX bulks to flow rules in root table.

This patch adds compile time detection of this new action type,
which is used in follow up patches to enable counters
on group 0 support if and only if rdma-core supports that.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/common/mlx5/linux/meson.build | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/common/mlx5/linux/meson.build b/drivers/common/mlx5/linux/meson.build
index 3fe7db7ec4..3767e7a69b 100644
--- a/drivers/common/mlx5/linux/meson.build
+++ b/drivers/common/mlx5/linux/meson.build
@@ -213,6 +213,8 @@ has_sym_args = [
             'ibv_is_fork_initialized'],
         [ 'HAVE_IBV_DEVICE_ATTR_ESW_MGR_REG_C0', 'infiniband/mlx5dv.h',
             'MLX5DV_CONTEXT_MASK_REG_C0' ],
+        [ 'HAVE_MLX5DV_FLOW_ACTION_COUNTERS_DEVX_WITH_OFFSET', 'infiniband/mlx5dv.h',
+            'MLX5DV_FLOW_ACTION_COUNTERS_DEVX_WITH_OFFSET' ],
 ]
 if  libmtcr_ul_found
     has_sym_args += [
-- 
2.39.5

