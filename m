Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EAAE606EE8A
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Nov 2026 09:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=lxKIyrg3
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 65B98402BC;
	Mon,  9 Nov 2026 10:24:14 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012069.outbound.protection.outlook.com
 [40.93.195.69])
 by mails.dpdk.org (Postfix) with ESMTPS id 62B1A40294;
 Mon,  9 Nov 2026 10:24:13 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ISqpgd6eyjTSf/Hcblxt7uuCGyzyww5hzsYlZ5Gpez/w3VSYKoiJ3uxYzZxbgiLxr16WCp81MmlR/NOmJ1w60dWgQdJ+EsouJEsWu2F3M1tf6s3KmXa+ZaBBIZ+4f9q4kN76etGRo8ovGbPIxTUDTqnSoUDhZuWdOhJ0Fu9DO4yF/R1PAkxGCkydrxhHQNn72cWJ6+3d34QOfluaj/4BARqr2oOBj7tZ1dbvaMB8Ua5gIoKTe026VIj+ubjJBTnMFgI9AN+dOeX6kgTRNQP/ClJI0rvAg0Sk6XpjmlKjV91cy3iAqHLHpsGwlEJ4VDaPh0ci7oHMX2FUisGIfgx8Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYkjVbp+ZSOy9fLYR9bNhRyaYTriKK+OKcb0F4KtUYI=;
 b=D8u3JD6J3Tkk0xYsU5J7jI+C0ICsq5025TLnE9T5rsVLSl0rLYL4hskVlvEa31QBSAe7Ge1CEDwlYAzY9PXtZlbIiWxZ64aRN0srRl4PmaP5wVaoUGizpgeGnaTZrKnCQCgTe+gheAX5/SoVEi8gxmff4iRzmBf61h8slyNfHhivKfXP06yuGuO5YN0L6ZWgpxGxpod6w91ksrMnNRYtGkP4mALBm809SdhF6df4iCylJOSQeKFoDtU9sCRzPVmCPV4khPVRa7yBuldPFvkoHpx6JJHWMnp6E3tDASFBD45gDZfpFplVwnMjpGabruzjtxprr8qeyyixjtMBs1jugg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYkjVbp+ZSOy9fLYR9bNhRyaYTriKK+OKcb0F4KtUYI=;
 b=lxKIyrg31Pa7mdlDH7bykrpHbGzv3aRGcS/RdvvK3AHcZTd9PdpmYmlWzMm2QiAOJHQeNFcWrjCqEckI//HDYuRBLaxEJov9hg/BywaI0yy24EfYu3eGsgLJLc/C+he3oJoZG9wyLHoKAPdm0WwiEUldhRYAKQjLdgxOPhp/V8auJdVerq/58cNGDW8XLCZhmZH5U4N14sdhhx9Pxj5IE/exOOD8EdS6lVhpHRkx9H+85JFzE6KNlUyHVmIJO5jOD+BSE7fz8gDipY5Dyq/OdduB63T0BVvHQIB681sDawB+emGPdt9HvjY2Xu41x6NWubAXBn+I+Bcm0XlnJ4HxTg==
Received: from PH8PR21CA0008.namprd21.prod.outlook.com (2603:10b6:510:2ce::29)
 by PH0PR12MB7078.namprd12.prod.outlook.com (2603:10b6:510:21d::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Mon, 9 Nov
 2026 09:24:06 +0000
Received: from BY1PEPF000264B3.namprd02.prod.outlook.com
 (2603:10b6:510:2ce:cafe::98) by PH8PR21CA0008.outlook.office365.com
 (2603:10b6:510:2ce::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0 via Frontend Transport; Mon, 9
 Nov 2026 09:24:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF000264B3.mail.protection.outlook.com (10.167.242.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Mon, 9 Nov 2026 09:24:05 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 01:23:51 -0800
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 9 Nov
 2026 01:23:50 -0800
Received: from nvidia.com (10.127.8.11) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server id 15.2.2562.56 via Frontend Transport;
 Mon, 9 Nov 2026 01:23:48 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <dsosnowski@nvidia.com>, <viacheslavo@nvidia.com>, <bingz@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>, "Maayan
 Kashani" <mkashani@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix external egress group translation
Date: Mon, 9 Nov 2026 11:23:47 +0200
Message-ID: <20261109092347.3975686-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.25.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B3:EE_|PH0PR12MB7078:EE_
X-MS-Office365-Filtering-Correlation-Id: a9ba1b1e-41d6-4c38-2f9a-08df3e433348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|10067099003|11063799006|261102123227099003|56012099006|261021121427099003|261021123027099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: o8adgOzL8UlJ+R6oPO5eu3rtNRRmTrZ2Shja9Eqy/uVwrGCQEaqHAegIQSg8CF6UgUi2SE+UCfS7BR+BI8peIQmR0408AK0TLTkyO7wtNd62fc2JLYlauvG3v+qduNBDlIC/xtpnrS0cdN+2AWdccNns9ZxZCiVdg7NagU01CUZvhtCenKEgEI7CxjvEIiqDPTPdD79FgmWAUe79IxlwEgy4mo3rUsQPex6yxyeqwD6j7UuLIZD6JzMtM/qWFOWpsOU5X4Ip7lvBMe7TE351QnGs3i82juYWsiIsHjR32kfCOkY4SDvsmfTilt85VCpYtkejugnopj3RLPKqowJn9mT9YdhoLV3ZysjhTIkZ8V6JQMTmxKBjj/ytTEbYrz6OFEwEEghRyHqbBklx4FwRSwoA1RjpilwZqxrptzvlmf3PxR2BuOMmHB9LtMSJ1y5E/jeAo1fVVFl9+URi3H0uqYhM1VDcETwx3Lm61R2FGn4sttQbpxoxcFn2e+5ckyaQhYzZhv1CVI09BawcQKQLp3R4ZMWM8oIpfRp+DVug21iz1IyiiOzvLRwJezmAN22AQp1pvJCZmVd/D9BB2b+9YLw1v0nRBP8j+FJBWcNVmg/4zrHxVrgeEfiD6jSK+A/4pTZh7ySf6yQA4bh2nyml+bE/rAkhbYr47TnFsvDSK0tMmR9UMiOxCVu+SdC7WVpd0YGbLZvysvDQZi8YOwfsJA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(10067099003)(11063799006)(261102123227099003)(56012099006)(261021121427099003)(261021123027099003)(261026121527099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jejNfRgbeIJm5g2YxEIBV+GGmJEjhmaClVH8HIoRi7+bbY4R09k5ScCz7MZNb33rDMxbs1C+uxxTgWRGzgLaV2hmy2xOCDkwD68V4fgdJYNUd73p9zbT7Jja63aPs+nkSuG7enjg/j/IF3FMLQrWIAwhhSKhz9AgiaBa+kVPqEEvwmQtK2g7p98RBTnZaJB6LuKvBpvgfOYuuy0TLKzgrABFxi7d3hTzWFM33n/37/5LsRRvYNr419u0b7tPyg9LOyO9GdB86xOQeGWAeEkezqoR6/ngLg/jcQVlUaVis2aoSOnLi33ovQCK6gEl3pxOyot6Vu++T4i23F2LJ4buBHfV5JI8JMppHDaXGyBow8cy2TWT/bn5zbtS+bS15BWKyvAEUdBSIucR8A4jU/3/sdHDOu1m/P3P48R80eJIMploGmhW22XUqQPuHWBfm5bZ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Nov 2026 09:24:05.3756 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a9ba1b1e-41d6-4c38-2f9a-08df3e433348
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF000264B3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7078
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Representor matching is always enabled on an E-Switch port, and the PMD
reserves egress group 0 for the default SQ tagging rule. Removing
repr_matching_en left the user group shift enabled only for extended
metadata mode. With any other dv_xmeta_en value, an external egress
group 0 rule is installed on the root table, where a jump to a non-root
group matches but does not continue.

Shift every external egress group when the E-Switch is enabled.
This restores the previous repr_matching_en=1 behavior.

Fixes: c41f621786ff ("net/mlx5: remove representor matching devarg")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 8dabf21b768..4b30befa2d1 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -5591,7 +5591,6 @@ __translate_group(struct rte_eth_dev *dev,
 						  "group index not supported");
 		*table_group = group + 1;
 	} else if (config->dv_esw_en &&
-		   config->dv_xmeta_en == MLX5_XMETA_MODE_META32_HWS &&
 		   external &&
 		   flow_attr->egress) {
 		/*
@@ -5600,9 +5599,8 @@ __translate_group(struct rte_eth_dev *dev,
 		 * These flow rules are inserted in group 0 and this group is reserved by PMD
 		 * for these purposes.
 		 *
-		 * As a result, if representor matching or extended metadata mode is enabled,
-		 * group provided by the user must be incremented to avoid inserting flow rules
-		 * in group 0.
+		 * Representor matching is always enabled, so the group provided by the user
+		 * must be incremented to avoid inserting flow rules in group 0.
 		 */
 		if (group > MLX5_HW_MAX_EGRESS_GROUP)
 			return rte_flow_error_set(error, EINVAL,
-- 
2.25.1

