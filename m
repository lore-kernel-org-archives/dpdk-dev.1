Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F06C19F2E
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Feb 2025 10:27:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71D9240A4B;
	Thu, 27 Feb 2025 11:27:55 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2089.outbound.protection.outlook.com [40.107.92.89])
 by mails.dpdk.org (Postfix) with ESMTP id 7908D40290
 for <dev@dpdk.org>; Thu, 27 Feb 2025 11:27:52 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mucHHHSj+0LHwkGqp8N4ZfaN2p3Icg/OxI6Rv/Nd+lapcuTyoamX18IW8dYdmUmZsaT0VP+PYLMdeeoViwHqnzBVORtA9TJheDuIHmYzaBTqqIfRiT9BTOOr5xOfThcEYS3OiEcB/FkQF3lLEjplejnfXmMGMmSsK50jiDVJcCIX6omoVUIt/1m9OzH9s+5UkQf6Wr25Twr9ZZM8cFXTHpxNb4iCCGPvCj/Ov6S73WwciKmmQ7fQ2QnT8HUp7PtCJRjD8QywtJCyJ07+aYm9FgtuwsCMvp1UQX2gmCZP4M5EL236QAvzBmnkuBJjmIZe6s/0OsBm4WS31WQXc4TFRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xaue8xme2KVeE+oWDQnz7DszCXhIHPzLDk3y3UmC3Fk=;
 b=pxLT+1IcZ/48eI3SmV7w4l3/ABr3B3HaD6ZENLhi0Hvrx/x94ZGxFWurz+Lv+nv1pO60UzBzinnoYIUK5lySvgiKFhFaFpvnd31syi/qEnAGw7pUOWAH+9irc+mxdAtb4FhXd30zUBiRuH350yovHsYqT7DjqXGX8OLGKiAblcNQQurwNP3DVSnFfBDFbGCSeFzDY7A8wbpenR9KGdJc+wfKzcY+YQCge43xt6R2jVvrcLurvlSp3/5b6jL4xJOFkvro5nRYCP5YZHRSOTNQhhSeLZnKoF8TE7JWXGjNtLBJT+FVEXusf+xEcz8wo4ahFC9aeimXQYEEDiSgsj02Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xaue8xme2KVeE+oWDQnz7DszCXhIHPzLDk3y3UmC3Fk=;
 b=bYWUd04eNTG7B7Uljuwd79zP7o87JTYk79GuKT3hW1GDEBJBtV9hCexXvrPic1w5tqQ461mKko5RLGoivbKVk4xO4Ypxflg0W50icBd96R4Kro1eEE7p2AyXdKPVQu4dH1s4bKLYMKCwm4VNtl1hnPYEu7/W4NJ3h2xMydDUY75dwwGSjLDIf87sJgOo/gogTYNaRZD+arud1c2GS9mOIz0/gCLX6T75AstaU398xJrLr351C9Joi4hogIAqMbjv8iFURtP00n2nBrpklH+jKkRdWXhrrv6tRLC9mjwTO5gTJwo0qGYiBWmCGwDavLj4WqjzR8TpoTChLwhhAtCeKA==
Received: from MW4PR03CA0021.namprd03.prod.outlook.com (2603:10b6:303:8f::26)
 by CH3PR12MB8910.namprd12.prod.outlook.com (2603:10b6:610:179::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.21; Thu, 27 Feb
 2025 10:27:48 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:303:8f:cafe::e3) by MW4PR03CA0021.outlook.office365.com
 (2603:10b6:303:8f::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.22 via Frontend Transport; Thu,
 27 Feb 2025 10:27:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8489.16 via Frontend Transport; Thu, 27 Feb 2025 10:27:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 27 Feb
 2025 02:27:35 -0800
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Thu, 27 Feb 2025 02:27:34 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Thu, 27 Feb 2025 02:27:32 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 "Bing Zhao" <bingz@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, "Ori Kam" <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH] doc: add limitation under unified FDB
Date: Thu, 27 Feb 2025 12:27:27 +0200
Message-ID: <20250227102727.92428-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|CH3PR12MB8910:EE_
X-MS-Office365-Filtering-Correlation-Id: ecd71f6b-35dd-4468-215b-08dd571961b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OXMNmPUIkSkX0kWdwPzGCEimMXctmx7DrVQQlPNdsCqwmeJcKCuJNb55kRx3?=
 =?us-ascii?Q?Rjn1K8eYFjhTYfWJh/soPPlmitDrHKg0Nsa+IR2RGaGaneZMrZLOfljawpQa?=
 =?us-ascii?Q?EIPCeYshTB4NJNcTLly4Oq/AIeKXTspXOJ7ph9tEmLJqR6vxVa8Bq3qwJ1SV?=
 =?us-ascii?Q?ArnC92GcM8a9AFKi7s3MySEiE9qib49gnUYqdglMxlYfIKmObZd27gvvh9zv?=
 =?us-ascii?Q?jYKdmSVRyV3K9zMiydsUvhna0n6fbMpxHZMb7hbxaFdw3hGRq3zv1zoSfGmq?=
 =?us-ascii?Q?NmnmXvMqzF8fxklisDqhweqbuhnEMDsfX+9OMKD7GI9zQEHTZy67hiYQ41EC?=
 =?us-ascii?Q?xinYTngeh4crrrDI1l2JXyPUqGFVHpRJKWmvW0L0iMGVEEk0iWVDC5Emh+YN?=
 =?us-ascii?Q?eu8bYgVZsetC2uCDwpmiStVyHFO50zqCAZbikIX2VycvzYbebCmaiMkUH92R?=
 =?us-ascii?Q?FMx2832ZVZMQ5seYqCWm5kwpgXUYbkFgLDETkOc5uHW3mGdz/LHwPDKUBpXO?=
 =?us-ascii?Q?l5rWyVKhOWn2WG1zi0SqGIPGG+bLP8B7tH3LKfbRoP+rEI7ZxaLnkxqnjbEH?=
 =?us-ascii?Q?9sHvYcpymo8FxHhUzP81gCdx6q9Ar5dRfJZ3vZBylrOprdBpofQktqGjTlEc?=
 =?us-ascii?Q?Q08Bh0JtKyKeHTGgSIWeft8UfMj5IA2BCuKsHgH2kl7UwzyZA/UHpd+lGzmA?=
 =?us-ascii?Q?dpF+qLQmUPRAEetLLIh6XqZXOBMNUJoDMT5hjgl5gx93ItJekifT2gHvpLbW?=
 =?us-ascii?Q?QFI0rz/JfAsQD7FS4SW+Of6a2hsy6hqXsd9Nk5LYTCIzK3B7ZYL9PDo0W5h1?=
 =?us-ascii?Q?AwuGDblOc4eJmusqMnxS8ZsiUHnFeHhuNroxzbxfIDeOAh+NJa/KvGgd6M2V?=
 =?us-ascii?Q?9Ag1tPevRshrPXIaMkGnOqVAepMWYj9QINXJ6Irh94ov5EzPAQSdMXOMVE/3?=
 =?us-ascii?Q?1kzTD9ZO1g/z12SkrcS9Cp3prAgUTGKWyenAIUnv6ueO4428EwAAG8I+7+IJ?=
 =?us-ascii?Q?2thmqMQvcDRx9n7iNwQh7XOIhC2Ohvsf0St9vc/H+hlZdEaa90zPJFK0u36Z?=
 =?us-ascii?Q?ADUUEtQmx/b6ii3NAI7AbpEfBHpyhy/HLXLm3L0t9rJeSZLzXrBWBM7lj9ju?=
 =?us-ascii?Q?llZjxtm5alF5VvucWp34SKsVOJ90jpyAHcEDpBD1Z+WCa1TnTf67lSSSW7ba?=
 =?us-ascii?Q?RPFJ8TeVPqvCroWisa+LZWF3dHxbUJoXaN+Mx+Ko/1Rhn4txUroDIh8NlWSv?=
 =?us-ascii?Q?nmhDLA0W+2s7hi6FnYIMXEp9eDPt+Mn0bzLPTu2NPo7JvspoY7pEATjcEWIT?=
 =?us-ascii?Q?Czu7L9SHiVxswcs0+Quzf4nGLxoeNRBzfQf5yfYqfYhGkQN+vOmuQ7t/fRxH?=
 =?us-ascii?Q?W8PBzoNiXHFBVxrxf7naGPCwzKAvYaC8CNrue3OzHRv24mWY+BvVQ+tJawGK?=
 =?us-ascii?Q?LqV/HC5Ro4diCDnvbb+leK1InKkdRftDgNFnNyberf9nrJceBFcylxtdlm3+?=
 =?us-ascii?Q?osr16UsDEcwijNo=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2025 10:27:48.0937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ecd71f6b-35dd-4468-215b-08dd571961b3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8910
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

Add limitation for unified FDB group 0 table creation.

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 doc/guides/nics/mlx5.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 190c58b54d6..efa4c708d51 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -288,6 +288,12 @@ Limitations
     - RTE_FLOW_ITEM_TYPE_MPLS matching is not supported on group 0.
     - mpls_encap and mpls_decap actions support only one level of MPLS.
 
+  - Template table with flags wire_orig/vport_orig cannot be created
+    on group 0 (group 1 in practice), since group 0 is created on startup
+    in UNIFIED_FDB domain.
+
+  - rte_flow_action_mark id is not supported in FDB_TX domain.
+
 - When using Verbs flow engine (``dv_flow_en`` = 0), flow pattern without any
   specific VLAN will match for VLAN packets as well:
 
-- 
2.21.0

