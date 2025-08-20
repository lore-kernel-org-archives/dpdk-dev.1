Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 055BECA0EFD
	for <dpdk-dev@archiver.kernel.org>; Wed, 20 Aug 2025 08:47:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE025402E4;
	Wed, 20 Aug 2025 10:46:59 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2053.outbound.protection.outlook.com [40.107.223.53])
 by mails.dpdk.org (Postfix) with ESMTP id EF05F40292;
 Wed, 20 Aug 2025 10:46:57 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Prr8agzNRWaqjjklmjxruDx0eUu62Qrq7zpGab5erdc1HH9vD7oiiiFSU6AaKwW8xDl11S45N9tNZt8ZpL4Rapuwqozwj6MDfh+1IjOf3CYwguJPK7BDmawoJWk8sEOe5k7baeaKqOOfBZea8/UBcW/1FMU2WdGKRv06sjviHlDDscv+DeGX0wC4XKVLQ186y6P/vVWwudeHDmV2ZxwWgCF46PJZvAwHOATZ4FkKFAT3yrGhsF4TY/i7z9S42wU0N+vqZEOgORrDwN2E6kKU6IKY9Odfs55RtB64PakSafPRXYEW+ufD/pQm11qcc3Vcfg/HXy+89u9SqiyxqMJB3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=evo+dpII8zSTpNxa1NIaGgwN8RJJHASSFuaQAPeJ17s=;
 b=LxYMUaDABvjCdWWqdTbBMRo+zSQrw5/vYeYTJ6de7huqA8wYOt/7XUMg8fVtRyZttFQkbVO0h4Jva2M3skxMgtBtTrxVIIaYOMFPzw88Tv4wOApJCurLuk3KRHo02w9hLErLHM4po/HRh5HVt7Udmb9LmauGiSm+rhUbQ+u5jxs+95P7td8VzB3QvY0Zl6UKSmn/CDLOAo8kRBSTodwJGAMbY2fSgJQp8DoSkbyGE0kXnOmolAQ5R7y8nHJLCZf6SKha93AFCDQCvAC3g58kcfWZu6I5x+x03ov0Uq9cbfrpn6eWPlr0jNzdMtfx6KhYZG9aouE75/ck4Do1XleGyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=evo+dpII8zSTpNxa1NIaGgwN8RJJHASSFuaQAPeJ17s=;
 b=hZHW1SrVsEfpfO5y9nmOv8H03kTG+3mxB2YbZ2lFQN5gUuLfg0LiUkwKrRqXwjlHY53EjUpiNCq7DNUiphjiCD/27VtrHlVpO5ermEs7bb+JdY5sZpgWh6s/F3+D5Rz0KsZ3jdqYkovNlkzROxcv7JVV10/J6mXnXXjRSXc/9DPx3feynTNhOJ/bcR3xvdif9yjP2YQ+4YfPF7JfFpWIkY/G3sUo0ZljyZZ51mDf3R8N+wgz9beKQ3XE29+Qfp4Dwy7utS9X5XNRWZhnBtQwhDpYc1LzHUgNqybLozNbOzpOtYa2UJFdsvqVTwhVdBoqXyhe5Qnz1mzSPsTOwl33vg==
Received: from DM6PR02CA0090.namprd02.prod.outlook.com (2603:10b6:5:1f4::31)
 by MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.24; Wed, 20 Aug
 2025 08:46:54 +0000
Received: from CH3PEPF00000017.namprd21.prod.outlook.com
 (2603:10b6:5:1f4:cafe::2) by DM6PR02CA0090.outlook.office365.com
 (2603:10b6:5:1f4::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.14 via Frontend Transport; Wed,
 20 Aug 2025 08:46:54 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000017.mail.protection.outlook.com (10.167.244.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.0 via Frontend Transport; Wed, 20 Aug 2025 08:46:54 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 01:46:41 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 20 Aug
 2025 01:46:38 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>, <stable@dpdk.org>, 
 Andre Muezerie <andremue@linux.microsoft.com>
Subject: [PATCH] net/mlx5: fix matcher flags in counter offset detection
Date: Wed, 20 Aug 2025 10:45:21 +0200
Message-ID: <20250820084521.1088620-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000017:EE_|MN2PR12MB4255:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c236619-01d6-4542-2c83-08dddfc61d27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?v8Q5hF2Ll49BMNtncJxkCAgnHkK1z6RCrEeesocvD/8vAAhIPYdrrh5j9CO+?=
 =?us-ascii?Q?oYkQ89cMI2v94RZLLRMDjgpny9ZsxUnvrIFBtrG2gOp3gPpBRO/tvWgtJnSw?=
 =?us-ascii?Q?KZyPQKxuFMoT3lZ+sOaczSf+18TkC34nUOUtcbLk9wIDAulhiP8LTfIZfkhd?=
 =?us-ascii?Q?y2VB6YdQpp9wduifBb6t3RUqSSRcc7ItpzpHNNXo5XLvhaahQJtEt/b+btIe?=
 =?us-ascii?Q?Vf8U2PfqRK9TiJngC5asqP24lFxuvUy9x1WRAY6HXVzmUiOa4CHuq+4WrPO7?=
 =?us-ascii?Q?uWzVKWJ5yCsnUwBmgxAqHrjTTY5N5gMT10VlpARCGbFxrEuFqZoSwf67EQUd?=
 =?us-ascii?Q?SHuVmQboZsFwI7voY9v4CQ1zeXhkaLyXnSSSNuGHwDDGp+kyOPChxnhdXjm/?=
 =?us-ascii?Q?oYXCVfGFkvB6NRwgVVRfa/UftVfYiLwXA/jlx0hq144MER75LEfWDJ6NozMg?=
 =?us-ascii?Q?hveSu/eJX1LNSaLW7b0xHpnM3DM87riVeF2e/uFGrGL6XK5gDnvxRuPZJBIg?=
 =?us-ascii?Q?jp74T83BmQfi4JbcCEpkBZWLAUTDF3GOuFzRN63l4OW6KHYtMzJ7Fw3R/og9?=
 =?us-ascii?Q?aOCioyM3Ub354LeQ5YUBTA5NPvB5ZV3H3UcpU6k0cEoIht2DQTfJiMz9qFJj?=
 =?us-ascii?Q?5WfphisRxwbMPZVTXlq1AB+f0tI11HwcPGpLDS26J5vzDjqu118Gf9q9N0eb?=
 =?us-ascii?Q?fT9dJNwOl/FtH/EGQSuU4vEObJHkqjbA+ql4+vhbG8TugstpWlaB7evLKD1O?=
 =?us-ascii?Q?8JUginD6kPS01SMXkjbiWsPxfRqKgK5EYfr/+HOvZvZWGv/xp6K73Irjg86G?=
 =?us-ascii?Q?wwdMR40cTpWS6VIlBZXqC1U8wpoI1yVggJgKbA7pOxxo4mpOlZSeVVnfCJLQ?=
 =?us-ascii?Q?GL9TAJwHPlhp+aNJr4r/g/UTqtK+nsELYQoZyfBHYZ+X/NR9PGZjjo4Gl/gu?=
 =?us-ascii?Q?N30h2b3X+BPqrzFTOqX11a/oGkFd3HYUS8FwSrqJC4b9LnsnmOv953gbcCIP?=
 =?us-ascii?Q?bLWCEc5XT5sy7Ci00n8i+po4/y7bBSXY5o24VhK1n6ljZZ/bX4BMTWbNu863?=
 =?us-ascii?Q?Ze4JvKk/zkHG98HSz6nPV8JGo3m5MTig7lHBpH8tbG1CIh3btnjAfoR4L4D5?=
 =?us-ascii?Q?Surww/t102BToXggIm1+Lhx9E8juWtPJxL9SBQIYKTe1ISQJba220BRodcea?=
 =?us-ascii?Q?/IdGQz8OuE4ysK0dC37IEvHNWywT/VQsSj/njKm0WLEff1YnPlnQMm6QM3Z7?=
 =?us-ascii?Q?Ww8B91Shaj7QwuiSK55viaZc+AcfF+sCiQ8MZrbAewveGcxTfUa6N/QoJlmb?=
 =?us-ascii?Q?HqjEFINjLFXsC7LCmoY/i0PtKTcwZ1gT7cZbtv9GEyK3gP2XyOla4gEt+xMX?=
 =?us-ascii?Q?4dDzBxFrr19uVO43GoHwcuimMZFMIdRXu88pK6dyy+tE9NJ2ddeHiMahO2YJ?=
 =?us-ascii?Q?COgYMymM8NBUQd1BxXF9B4xKU8cQpCNxoiCiMZ/n8Coq4DFPUvROOmNqzpcv?=
 =?us-ascii?Q?xEkhsxIbYtOS4jMMmOzgcVIezHmPAu2hKmLX?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Aug 2025 08:46:54.0617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c236619-01d6-4542-2c83-08dddfc61d27
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000017.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255
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

This patch fixes a bug in
mlx5_flow_dv_discover_counter_offset_support()
uncovered by a warning reported by MSVC:

    ../drivers/net/mlx5/mlx5_flow_dv.c(19636): warning C5287:
        operands are different enum types 'ibv_flow_attr_type' and
        'ibv_flow_flags';
        use an explicit cast to silence this warning

IBV_FLOW_ATTR_FLAGS_EGRESS was incorrectly passed in to
type field of mlx5dv_flow_matcher_attr struct,
instead of flags field.
As a result counter offset support discovery returned a false positive
result on application with old rdma-core.

Bugzilla ID: 1758
Fixes: 4fd5e1484887 ("net/mlx5: fix counter offset detection")
Cc: suanmingm@nvidia.com
Cc: stable@dpdk.org

Reported-by: Andre Muezerie <andremue@linux.microsoft.com>
Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_dv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 7b9e5018b8..4a6f9d63fb 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -19652,7 +19652,8 @@ mlx5_flow_dv_discover_counter_offset_support(struct rte_eth_dev *dev)
 		.size = sizeof(value.buf),
 	};
 	struct mlx5dv_flow_matcher_attr dv_attr = {
-		.type = IBV_FLOW_ATTR_NORMAL | IBV_FLOW_ATTR_FLAGS_EGRESS,
+		.type = IBV_FLOW_ATTR_NORMAL,
+		.flags = IBV_FLOW_ATTR_FLAGS_EGRESS,
 		.priority = 0,
 		.match_criteria_enable = 0,
 		.match_mask = (void *)&mask,
--
2.39.5

