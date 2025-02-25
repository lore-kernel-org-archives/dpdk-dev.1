Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E8F8C021B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Feb 2025 12:03:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2A3DE427C5;
	Tue, 25 Feb 2025 13:03:35 +0100 (CET)
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2071.outbound.protection.outlook.com [40.107.236.71])
 by mails.dpdk.org (Postfix) with ESMTP id 125EF41101
 for <dev@dpdk.org>; Tue, 25 Feb 2025 13:03:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=id1Of30qS46IFbxcNmAXCshWGpHxl6ZYif5m57AIbUMGa8ZC9PdaBzyeo+MSR1yJK+Z2umfsyrMvN1dhkF5vBrzIju5X1pJbaxwXryO8hM8+Ujsh3p+W1zDyL9RFy4rM2Q6xgVNnjrRfCMfqhLpn63lKqAUVhWSdllgCMYEt1cMSPor/UrVFe92hlM2ksZ85YuGnjsOPq7BX38twiVa6eWjbm9LbNcX4gNneJdfV20Os4LgQhC6CiXRgLm4pgPZ5Pk2kp/T2fR6hszveQbpPqDTC6p0Rkoi8IIK43lp+At73Q6w/Dzj/XE+8YSZzSr+C1aINqbVLWknzM2wMiCM2WQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bX/ySaCGRQ+T++mx1ZVU0Od1arQgeHFWlitqz71L8KE=;
 b=oqn4sxchIpUxEbUogLKDkB3R3z5XtiC9Z8MvFUQr/0JshL1QxEoAGT+uvakS5VomlEygLbl2OFDtf+aPtmZGS4vdBsQL/NB6/GbOv6BkRfpkTRcBSH7VNX/6VV5pxSYxjVlkVrwmknm7bbVxkpUKjbObA2IXfxPBhTIH+91XY4NgbjgReUppILjpLj7jh8XNT+v7Q9JFMBBTYOdAEDFkfDAnq1undvxe3rlBY/p6yTPd5717h9xPNLbrCOO5NyBLizFP1t//wHy4Zz/MarS0fJfZKGCIbu6poR6vJrmWWW5pTqPl+N0dyKlkfQLqLbqhk7XupjZ6q/BqW0LFFecJTg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bX/ySaCGRQ+T++mx1ZVU0Od1arQgeHFWlitqz71L8KE=;
 b=Q6cvduZslH1w8SzouARR1TJrMVAhlOxm5ZX4G169K9pbFQvT7dCFOZba33MMnGc8lRQpq/+2ARP2f0/jhGo5NUNZR1uSYiQwquH/iBwnLC4xSljBrL+VmKiXHYq0/dbNA+6XygAkkSHCP3Lq9zU7VUNUhCgX9S0cQSzLOukzuxYfkFloqldMCPtCB5UqqBfT/RAiIwkwWdGRGjHwvwNge2FzK65gnSA753BOyka+TbcqE8GQSktwdR0/zntTlT0Dq/sVgysAKvi5hOFywXEyPus14PqGa5dyzDZIVNiYSmRffPRQODhDMW/sRbmFQjwuz6/1wkWd5gdFeKyiEr5ObQ==
Received: from BYAPR04CA0034.namprd04.prod.outlook.com (2603:10b6:a03:40::47)
 by DS0PR12MB7728.namprd12.prod.outlook.com (2603:10b6:8:13a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8489.18; Tue, 25 Feb
 2025 12:03:29 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::99) by BYAPR04CA0034.outlook.office365.com
 (2603:10b6:a03:40::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.20 via Frontend Transport; Tue,
 25 Feb 2025 12:03:29 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Tue, 25 Feb 2025 12:03:28 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 25 Feb
 2025 04:03:13 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 25 Feb
 2025 04:03:10 -0800
From: Ophir Munk <ophirmu@nvidia.com>
To: Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH V1 1/4] common/mlx5: support FDB unified capability query
Date: Tue, 25 Feb 2025 14:02:10 +0200
Message-ID: <20250225120213.2968616-1-ophirmu@nvidia.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|DS0PR12MB7728:EE_
X-MS-Office365-Filtering-Correlation-Id: c812addd-59b4-45a6-47f5-08dd55946aaa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qENjcEgfUszgqGAzbIhNLovQZlX/KqftK5JZGkTHRfNxlluZ3uGsWzhVuqMD?=
 =?us-ascii?Q?Met+CA0x0moGxCuV0flxSTXRY4cs2H2z7bmApyX6pogfSHudfNxqsIU5iyb9?=
 =?us-ascii?Q?BB6c+T8yWizVj336OTdcIOreGMqnI8LBXMq9FQf+blxiwa8cQOiKt23BXe5t?=
 =?us-ascii?Q?oB3F6504qZXA9ImEAenzGOD4EKxuQyr3TLevhYJdrSQ8L8k+TjNrQYi5dO0I?=
 =?us-ascii?Q?tH/I8KYkqg4Xwo3AbSB9qWMAsBMPYxZ3vwxV/JjpIqgN4QCCSKudryDT18wG?=
 =?us-ascii?Q?Tkv0DA/1elSnzUO0xH8ZElIuW0E8fcmXlrh4GlfEvp7fwm9N23v5EYAImkz5?=
 =?us-ascii?Q?KbXD+cApBHqkozrzWj6ZYdIn2/we3ruxj6KC1ZfRPNnmGvRNTYbjp4MO7Qa2?=
 =?us-ascii?Q?1ZN23ljimfXLz3iQ+OBxQGur9hRobuh4479KGU9cdIpo2ZwtKwhGN9V3n9YL?=
 =?us-ascii?Q?lFMYvwqw8Nq/EuQ+ky8L2TKqqDYmhHKkLQPjkTh23L2r0u3iwk7txhSYFVcg?=
 =?us-ascii?Q?SpYb563v7nIJEEI+Uf+CVQTpSym6ep4s+TvdMg83RJFam3Qnx26jsrcKfVHk?=
 =?us-ascii?Q?IMfrb7bFqMBVszdd7UpmOW/Lctrby0e7HjmRU+HSrfArEwKze3fkvDWaaj4/?=
 =?us-ascii?Q?RJowohSxJVOghjQBvnrmJFWV/5y2iiuT2ph7ZMYQU6/4y2tQHPJgkxcj3El5?=
 =?us-ascii?Q?bad9QrkMfcvrMpwWoT9bVrHQlI2NYsRYFGPmbdGaiWqn4x7Gg7grdgMdZDZv?=
 =?us-ascii?Q?aivvTiG4Rt675Rv4Ul6JzWMLvhhkBRThvxeyBYPEAXbxC35Sn+SEHaEBF4WN?=
 =?us-ascii?Q?jG36t4jYSugmdDhWw1Oq/DJlDDxD40cU1zm/ySGObu+omvGvBq/Ro3FOfu8g?=
 =?us-ascii?Q?RwmZpwDp6BSpxZ0jyH4FfetvHBz/sYxS5ghNBMDNBzJ0XC8X0D6NxPtiO++L?=
 =?us-ascii?Q?ZBnPHMZMhYzeUvWA1CS0l+M5aO5oaPAxcFgNbkfBywyLXZ9YZftAvsY7l3IW?=
 =?us-ascii?Q?T+77FmYI4Di/to6mLrnnQOgW3es0Xt0JZFpJQ7rwcpC2avpeHeb3yFhfAyK4?=
 =?us-ascii?Q?4UsF0A8iCYskStpZRjdrkZJ48A0xSsgDw378yv8q3iK37hxCnhVFXTW0iDwY?=
 =?us-ascii?Q?ATPDb6RAVSuU9OfZ4XozVSj+ccNF2XQ/msteHxfpaqYMuv/47Vo9B8DOy4k7?=
 =?us-ascii?Q?WJdxMtz4MqsA+YAeMYr2WQ/XhrFIRVuFOh+cuAMecIZUmH8Y0jI5/kn3w5MF?=
 =?us-ascii?Q?jxRThcVYsbpazCRISFDp65vxrlnN8q6CAxoFzfsTwmVFy/PKzzBWPaOPMw5n?=
 =?us-ascii?Q?FUGIc1V4b/OsMGwDwW3prosbT+x/IATOSizv6yQGtXEn0et224r4rwj3v/o1?=
 =?us-ascii?Q?5U9WKpKj67Q6WzhMavRpTIGpqsEJUxt5ctCNwdTSRlKwaDUjwT7idFKN6+W5?=
 =?us-ascii?Q?8U0W3INYFs5CVkGqFbtMEe8ljL/1nuyDp6WKD/sxz05oQdtZ52cDXW1gneYI?=
 =?us-ascii?Q?DKxPZ3PiaIbm1fk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2025 12:03:28.8606 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c812addd-59b4-45a6-47f5-08dd55946aaa
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7728
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

This commit queries the FW for the new unified FDB mode and saves it in
mlx5 shared device as fdb_unified_en bit.

Signed-off-by: Ophir Munk <ophirmu@nvidia.com>
---
 drivers/common/mlx5/mlx5_devx_cmds.c | 3 +++
 drivers/common/mlx5/mlx5_devx_cmds.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c b/drivers/common/mlx5/mlx5_devx_cmds.c
index bba00a9..f504b29 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.c
+++ b/drivers/common/mlx5/mlx5_devx_cmds.c
@@ -1349,6 +1349,9 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
 		attr->max_header_modify_pattern_length = MLX5_GET(wqe_based_flow_table_cap,
 								  hcattr,
 								  max_header_modify_pattern_length);
+		attr->fdb_unified_en = MLX5_GET(wqe_based_flow_table_cap,
+						hcattr,
+						fdb_unified_en);
 	}
 	/* Query HCA attribute for ROCE. */
 	if (attr->roce) {
diff --git a/drivers/common/mlx5/mlx5_devx_cmds.h b/drivers/common/mlx5/mlx5_devx_cmds.h
index 38548b4..8de4210 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.h
+++ b/drivers/common/mlx5/mlx5_devx_cmds.h
@@ -325,6 +325,7 @@ struct mlx5_hca_attr {
 	uint32_t cross_vhca:1;
 	uint32_t lag_rx_port_affinity:1;
 	uint32_t wqe_based_flow_table_sup:1;
+	uint32_t fdb_unified_en:1;
 	uint8_t max_header_modify_pattern_length;
 	uint64_t system_image_guid;
 	uint32_t log_max_conn_track_offload:5;
-- 
2.8.4

