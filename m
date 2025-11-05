Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19507CCFA0D
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Nov 2025 16:55:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E0B3C40BA6;
	Wed,  5 Nov 2025 17:54:49 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012060.outbound.protection.outlook.com
 [40.93.195.60]) by mails.dpdk.org (Postfix) with ESMTP id C8AE040DD0
 for <dev@dpdk.org>; Wed,  5 Nov 2025 17:54:48 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=c87Gt9uHTm34Hotl2xl1+15czPhf+VBlPC4Jd+YSp+cLl86EYijseSBgBhnXDuej0hdZrmf9Qn7f3QSox2VH6MaOM24sPf4vS/RFCuFEJExGoRGiHnArwZ9HNmceYjTlMV6XwfysMlB1cXuAr7SO1TxR++8eP8SS2K+32DN4aKA+OLpvxeQLpjTVXwtC0BNnwzG67LUxm3zQFw68YN24l/BLCSBZDE2omDeSeomFcTlZOrf/MlH9eG5fo+4fuezNyUcXM49BKIlBFCqUlQpOzCdak6CIP8eS5Pd5jqWxLyCVOfnj5+e31k0rBL44h0sXZyb5YbWUZRUf/KMqqpeLJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xeE3LfNvhRH6NSY8lYtrZbs8TsoOpcasbHObuGvVh/8=;
 b=Te0kUdPFc6c/7YnCgRE8immmvXkCUuNn/FVWLSEkPArRoS4KCwVTPiOcfReMsZHRjA6k2rlRbUz8rcOy2zezwjUkbFyMfbvE4IqzKypVT9ohs9eZpiipxqtw5aaT0nWPw8xAino9UsAol6Oo3ntUYBughGVgRP18p5xzssN5NIqhZjh3n9sozZKltl9wT8mw/QCdz+V1kIZ/c2SUXuOwwN0EYko0+wasFEMBt11hbkvFQUO6j1aEOpeA9H0aoljma2Tg/9eII/HfUIHH7OqCXdzyTexqyFLAoLwVasxb7yLdzPwe3aNel+A7GX/0fF0SryRPebqwX/f1Ml11AI3gqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xeE3LfNvhRH6NSY8lYtrZbs8TsoOpcasbHObuGvVh/8=;
 b=SaYQqBPcgLWDnN1J2+d6j9YmWN0I6JohmqXW8M9MKbLkJ3kOLSAXrkTNc6JlfMslTUpukVemmNOocPH7JbYXs78yEcJ2X9cXMhfiU8O4geCbYPvfA5aoPKB2y1aKqwZSZ5opVYejlU7aUssVamvUIZmGJRQKs/b78D9gebc4vQWc5Mby74AGLDNFaDhYrmfZnEFKgviq8p/ZDXq1DR4iGxO+wrUN2fKrD+Sr016Fu13iwSXNEAt9n9AMh5rfQEGjhjv+0KpB519pND0BjHHdfNx/KSHPr3FH/PExCIDJhvEoYoSrfYQrVnYb/yRXAYcyhTyGAHR3O6htS/Y5IBibWw==
Received: from MW4PR03CA0321.namprd03.prod.outlook.com (2603:10b6:303:dd::26)
 by SN7PR12MB6931.namprd12.prod.outlook.com (2603:10b6:806:261::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.16; Wed, 5 Nov
 2025 16:54:45 +0000
Received: from CO1PEPF000075F0.namprd03.prod.outlook.com
 (2603:10b6:303:dd:cafe::18) by MW4PR03CA0321.outlook.office365.com
 (2603:10b6:303:dd::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9298.7 via Frontend Transport; Wed, 5
 Nov 2025 16:54:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000075F0.mail.protection.outlook.com (10.167.249.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.6 via Frontend Transport; Wed, 5 Nov 2025 16:54:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 08:54:15 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 5 Nov
 2025 08:54:13 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH v2 2/5] common/mlx5: detect DevX counters support in rdma-core
Date: Wed, 5 Nov 2025 17:52:55 +0100
Message-ID: <20251105165258.1396352-3-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251105165258.1396352-1-dsosnowski@nvidia.com>
References: <20251104174612.1341962-1-dsosnowski@nvidia.com>
 <20251105165258.1396352-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F0:EE_|SN7PR12MB6931:EE_
X-MS-Office365-Filtering-Correlation-Id: 770c177f-a567-4aad-829d-08de1c8c04ac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MzGWnQqprF4OPUUXBu4GnAhzsvV8vQqTq3PoZpjH0jyP4lIE6MC1T8FhnKzM?=
 =?us-ascii?Q?tm4FwJyD91pSGJg4hJoseRRtwf9PiD052Uv+cKCHVgIYP7krm1Ks1HweaOPG?=
 =?us-ascii?Q?8CEoh+bb1qb1cT//g2L1mJkRhdL02vFSagzVprIeEJykwqCCymbO2IHn8pCg?=
 =?us-ascii?Q?8lduw1i4Sys9fdMQxRpyjZ7yLiXVHw8rpyiWLMCdxONOZvPeucXdomaDSEiK?=
 =?us-ascii?Q?RPyRZi6aX8GGEbwhRbKz15EKgDcbNMiuUSBuh/LSkUoaDyMPtiTADObSJ5ZC?=
 =?us-ascii?Q?3z/zLvXpfAvFDOaCWvtSIA+HffHUKoSejJYDE9rlVOPwAZR47IQ24XsyLxDs?=
 =?us-ascii?Q?vw+BNulR5zZ+oW3fZ2u1DZ9XG9XHdwZBs0iT8c8WRb70g0xUqjvdy30r2rgz?=
 =?us-ascii?Q?NnIWpz4Vh60x/Yp9Ive8nrkwQGypPidoECUPL7X/0feGrcne9un8ined99tJ?=
 =?us-ascii?Q?IcfhPX7j0/TbuildMiJqHz3mwzV5rUOLiOwjKyldQTchyNm151jWfzda2tRa?=
 =?us-ascii?Q?xgvovfkWzhbVCy+2GWtYfD3PETQtj9EV5kWSOEoRJAsvz13EsiQMt4YhRMAU?=
 =?us-ascii?Q?O253M6FAE6xaSQOhgyHEdy4bOLceN34ivyuETAx9hVFofccmKIjChI8EC3Yo?=
 =?us-ascii?Q?1JmcPbyLjXNcMl3dTsUHn+M1Ib01jcwnq+yLXL6FDPhiyHvAHhth25CZOFMD?=
 =?us-ascii?Q?oHNHyjE314l2jeQw7/gmJmEqZ2iv7s+nrqixLXJVUdE8PFViSkesH0SPp4y5?=
 =?us-ascii?Q?VS0A+R6SWgpW2uWQ1j2w8oBIS4rUlNyaXGCr1/Ot3Ba69mBVu02WehIUy3ru?=
 =?us-ascii?Q?iNqpHwYHg1S9E1j49z9zg3lK3GM+uGLTJlf7x+DT1yGSGBBxo8VNeO5uXG95?=
 =?us-ascii?Q?0HOF1t1g20x6XXK2lyrlLRvZho7cfwcx+RpYj9MrpB6/hFuwurix6lnUMjG9?=
 =?us-ascii?Q?oqJ8U5bfJ39CaMGAi5UIWFwa7pKxpyKulNCpU8DSBu5sR0FMt8z1iQ+o/JLY?=
 =?us-ascii?Q?X0RqvRtdFq54JNkqZTvWgPxEhiStrZicMA5Q9hnzqQzwIhV+XLT3/YXs7N5+?=
 =?us-ascii?Q?hThRBhRu/SQKglTm9FTZ7skZ5X3ATf2sNcsdPXlUq4+H5/pcsTZHqAt6sj1u?=
 =?us-ascii?Q?lXzTTT1itOuSWiIEYXh3n+JSC5HE2uARye4Jni6/IC/QZoM1v/KJ4nnnvxMi?=
 =?us-ascii?Q?sdvnAV1lCCIe8bsSWM7EWpNx4B/p6EgMi4Hh0DiWXtI/+mV0+dk0SFvwFFgF?=
 =?us-ascii?Q?Uup7XYv45cnvAWk1ToFo/LbW+0nQugPafS0FtgR2hMkym2BtqM39HqrcC5SC?=
 =?us-ascii?Q?uSMsk2t57dqekDlkN+FDmpl9QaQkYUVf3MtK43CkR+TIEwuWnN8jQblm9DFi?=
 =?us-ascii?Q?QUG2zNALLLah/2SWmicCfV6BXII4w/5bw4bl2p+kyelcTT8LQBgmRtO6Bz9p?=
 =?us-ascii?Q?7SFQMNaXqR/dG7rMGCm0t/znFrFC3i6ryNfLDpm+l9I2Qh457fCpkmgvDC0u?=
 =?us-ascii?Q?YVlPJ9LDdxpdQTua4DbEfp6jlNZb4Ct3XAWXMqo7GleqtXWd+H1g1idUKi/x?=
 =?us-ascii?Q?wYBgFHszn8Cvh82Xpyw=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2025 16:54:43.1213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 770c177f-a567-4aad-829d-08de1c8c04ac
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F0.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6931
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

