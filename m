Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2130FEA838
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 09:08:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C881F4028F;
	Wed, 25 Mar 2026 10:08:35 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011063.outbound.protection.outlook.com [52.101.62.63])
 by mails.dpdk.org (Postfix) with ESMTP id A4A694028E
 for <dev@dpdk.org>; Wed, 25 Mar 2026 10:08:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LqtMYUFOb6LffgoUV+ZNnEvwNp6dkbGBwvwATHXLrj74tQ0UJre1bKNwkuekjSCbejIvUV0NEWgDpqIs8ZBjszkoxe6FDfUNu9LibSBWr1AU9Ly5eNWoZ/AXCL5UHKA5M3uvTx9WcJ1iBBnzPgnE0Lt71QcS3sTw1TG9PqJHMKRxYk/ZDojWihfmsanK5pEfvUsDX7MAbnFdsONpaQ65PtVMGHA8wH1gK3jcw6r52NxhBNLCFgPnRjN6xH+H+EY7Ybm8p2hYyME3ky/wejdjLBtHOViVO+tLQiEAb93YxIQs1NCHsHxJBLiIJC2uaKc4qLlZmQLpDjcXeulc2V4GtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hMfU3OpQgOsoWmiYkSuBC19mVzlNztvTN1J9kPGwq14=;
 b=keR4KIGoFA55W9CQrtegM2gFticELwNM8v7T/ScA0KX4P3x8mtAhnI03c6nL6/tyjXYu9lcqZx4dLkaZqWykDmWwUrz+ES6UTi8XH8UsTof2HMq2ug4ihDvFmChwHQ/jYh03p0CPTn0e0+Nl/CyCjLyC0Q1uUbNkvkmtH08zj+iuQJl8HdiSznIGv6wC2z1wXgfq9sOlXe9KV8ThDD/mr8FUR/BFooPzGuX3Aeu72PAdOlk3i/0x0RyDvV6Uv7s2NkxOoEN9R6Ux0lk5oX7X9dFp3OYuoeD83dbA9m+ERHYc2HAe9HJEfDkVj/1HpgJKHqVVVddYZtC+4dQIiUSCCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hMfU3OpQgOsoWmiYkSuBC19mVzlNztvTN1J9kPGwq14=;
 b=Tvc3ctYMsIfsoqcHtvXHve0WmH0ckJJ1hd+oUJVwEkW6fVaMUODPWtGCuE3qMdiGcETjQHMrae4lhfvRR5GMBOs+3G5jnDmShdaqTUTfalaaGwO/Tb0+2i+HHxLhamT9+9HSexjoruFcQUxXemKqSo9X5AtgawdBTJqePdbkhg4uxqJ8O5yDf/H5/SJkcg80LwkkMzKh/yQLvXTZeC8qY6NmPsy69XSgMoSJUWfKdPXg9asyLLAH0V2Iixb2p1kI6DllLrpSpGpwjXOG9s7SQ2MJdOjCNAH4QkfsVIxZdthzeMjR7nTpvrBKIuLdq7c/XGpHtoVoPIcFSXcjZTSB9g==
Received: from MN2PR14CA0008.namprd14.prod.outlook.com (2603:10b6:208:23e::13)
 by DS7PR12MB6166.namprd12.prod.outlook.com (2603:10b6:8:99::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Wed, 25 Mar
 2026 09:08:31 +0000
Received: from BL6PEPF0001AB4A.namprd04.prod.outlook.com
 (2603:10b6:208:23e:cafe::69) by MN2PR14CA0008.outlook.office365.com
 (2603:10b6:208:23e::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 09:08:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BL6PEPF0001AB4A.mail.protection.outlook.com (10.167.242.68) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Wed, 25 Mar 2026 09:08:31 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 02:08:15 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 02:08:13 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>
Subject: [PATCH 26.07 1/5] common/mlx5: query vport VHCA ID
Date: Wed, 25 Mar 2026 10:07:53 +0100
Message-ID: <20260325090758.42403-2-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260325090758.42403-1-dsosnowski@nvidia.com>
References: <20260325090758.42403-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB4A:EE_|DS7PR12MB6166:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fcfcff8-5504-4bf9-8d28-08de8a4e15dc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info: fBkwZv7w4PcVsnfH2avBBLrA7MffI22xIxwX5PI66m8k3YxDREQyh6kACC4OldzQAe+v7QZkBHd/lT3ew9G2A9USW7RR/MMgR7WXKLchDefEPUqmPN7/wObSsT/117lLr7nmsnXhqJa2eVReC8ct9HEjPIBieRKgFXzDu/DVkPnQMwqhnzSh+QZ17DZysKOfQ0lGdeag/jm0sD90R/fshmcc2nOOFJModvf399HlDGECMl0pINblrXMhaNB01jSFJbFRplxr1NU3GM1i2M/7onEq5p06vtlS76dw6EOiWemAT2q1b1zpiyzQPS+FGpIf9Qw4KaHNrpq8Eu+LLCSVHTsFI7Tp/vzeiV15bb6F3TXc7k6QuxTD/I/o+UkGvx5s+MUIhbGmSlRlMjHR9fR47BmG5E5JsWTl3yEAQIKH1KfAi3gwrtY0udm3ppLuF9HUYXErfSC6wkGP1PHvLOcDOOHlHdG9qjRm2jEAQt6tDDY3+4mb+bKk3/aWtgbzOJGFVAeJ0ek4ucRmG8QRryltZYa+wjYXEOLfaLvU64uj8MEl/ZWHo4dplKSFq4d265syv149Xw0ijEyhkWUhZJK0eGQAqUYDnw2aYg2CQEWJwdA8v2HhaADQxR4mEDtmDuXrd1LmdzbLeTom7QZOPeVClblFeq/P9a8ZXNWCdetDbiM6eEZEjEM7LYv/aFkPtYPz0Q/2fIehuAIzHH2ZqF1FL26Lqu987LB18eFiZ88aiijHjIAX7qPuToHWnHej3nzqHieI7z3J+oTLTny7mZmzLg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700016)(18002099003)(22082099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: KvCGOjRpHmZeTMEaWZTzNbM6DAC0s5MiI3e6SEwXW5BiJkED3gqfgrY3p66jv/AaYjz2joSBxLpt31GQYL/EuRaNNhBWt4HRUT79Al8RDdqT66wbZftQefEo0xMzW3oFGqv6Fmb0ChZxDcfOgK5EbCpZhNRG2/nQjHl409KkmF5zP+r0ts8fdmKaPoNUjv3xpAmFYx0cmUDkmeMYPx6MZvOISV50N+dEr6AkIfcv4XR1fQYdPSOVg1MvDYU5kuO/yf94jdny+xVIK5RCIwFVt+FMkl586JbGDIBBYwFpvebOMnkxo580WxMtbqxc7Mk3yEYHgt5x/ost7nL8yoIt+l+Wp6JCEyM5EDgvldS+VBAhEL/EYWc+tK4fx9d51S4cYAVd6ZEUEjzTzYpgnVYj77TKcdgSyjRSLozaMKGHO09Vxrek/OcU7ShRJqrzxuI9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 09:08:31.0104 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fcfcff8-5504-4bf9-8d28-08de8a4e15dc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB4A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB6166
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

Extend port info returned by mlx5_glue_devx_port_query()
with VHCA ID of the device related to the IB port.
This ID will be later used to implement source vport matching
without E-Switch vport metadata enabled.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/common/mlx5/linux/mlx5_glue.c | 4 ++++
 drivers/common/mlx5/linux/mlx5_glue.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/common/mlx5/linux/mlx5_glue.c b/drivers/common/mlx5/linux/mlx5_glue.c
index a91eaa429d..56eaedf0a2 100644
--- a/drivers/common/mlx5/linux/mlx5_glue.c
+++ b/drivers/common/mlx5/linux/mlx5_glue.c
@@ -1263,6 +1263,10 @@ mlx5_glue_devx_port_query(struct ibv_context *ctx,
 		info->vport_id = devx_port.vport;
 		info->query_flags |= MLX5_PORT_QUERY_VPORT;
 	}
+	if (devx_port.flags & MLX5DV_QUERY_PORT_VPORT_VHCA_ID) {
+		info->vport_vhca_id = devx_port.vport_vhca_id;
+		info->query_flags |= MLX5_PORT_QUERY_VPORT_VHCA_ID;
+	}
 	if (devx_port.flags & MLX5DV_QUERY_PORT_ESW_OWNER_VHCA_ID) {
 		info->esw_owner_vhca_id = devx_port.esw_owner_vhca_id;
 		info->query_flags |= MLX5_PORT_QUERY_ESW_OWNER_VHCA_ID;
diff --git a/drivers/common/mlx5/linux/mlx5_glue.h b/drivers/common/mlx5/linux/mlx5_glue.h
index 81d6b0aaf9..0610e7778e 100644
--- a/drivers/common/mlx5/linux/mlx5_glue.h
+++ b/drivers/common/mlx5/linux/mlx5_glue.h
@@ -92,11 +92,13 @@ struct mlx5dv_port;
 #define MLX5_PORT_QUERY_VPORT (1u << 0)
 #define MLX5_PORT_QUERY_REG_C0 (1u << 1)
 #define MLX5_PORT_QUERY_ESW_OWNER_VHCA_ID (1u << 2)
+#define MLX5_PORT_QUERY_VPORT_VHCA_ID (1u << 3)
 
 struct mlx5_port_info {
 	uint16_t query_flags;
 	uint16_t vport_id; /* Associated VF vport index (if any). */
 	uint16_t esw_owner_vhca_id; /* Associated the esw_owner that this VF belongs to. */
+	uint16_t vport_vhca_id; /* VHCA ID of the function associated with the vport. */
 	uint32_t vport_meta_tag; /* Used for vport index match ove VF LAG. */
 	uint32_t vport_meta_mask; /* Used for vport index field match mask. */
 };
-- 
2.47.3

