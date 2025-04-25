Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D4A9C369D3
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 19:35:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B842B40616;
	Fri, 25 Apr 2025 21:35:52 +0200 (CEST)
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam02on2071.outbound.protection.outlook.com [40.107.96.71])
 by mails.dpdk.org (Postfix) with ESMTP id 5BF2A4021F;
 Fri, 25 Apr 2025 21:35:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fgUxZJ+bEVGsZHd3a57oFDOQ03YUYQW3qbOtlOhXrZ/kua11PTv+dy9MxzDQSevaPQ1lCTzmOV2aPlRzSXpWBTVsfU8s0/lJmXXW6ugspkFyHOZo8b/gTOrXOcoqBTjuQ22XwyNgJWTNh9p5ROfpb1mbvx1KniWXFUC3ko9lILDWZ/9bH4wpZBxU1q8qRVBea5YGCMM2EbRMAJ7NapM+6vU71mj5rNHAiRwZsgluQTMWW6RKjcCDuSWi5+vhO3G1jOnoLYF+POVM283qDWGhroF6AqNm7oXAe1nEHy833AlzkEBJxa4BYqWzwSlKTWhRnnzmy79HKs3hcCgf+6jH2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TD0mVvyf4OZ2bAEPtrWgggZRh9NiTSYIYzYwCSWTqP8=;
 b=DDKeLvg6yTdWGnaAVKAp0pPKmWZsohViwn5p7DM6If/Q2HZRYIy5rdEI9wOkxAixNDj14tJaNRxlKhtJ97eYP9F+bDVnsNkqgUJsvhYj9+iDvxCt38rVopLYZFz5Kh4XhXuZ2ImJqCrzjn6ue/cGLX5zYOtjD1xqBrUh8a9R5saLyeXGwnX6t+wQQB2iMo14mGT0Jd5JBCGKl/Z1llrlEs50O1ZKmmPyNPtfQTGkEQAisB23E8UXYILcBN+xGAiXF1o4gM9MQ+vZBvpJPcgQ/+APwS9E3yzp3iwUD+yaB4i2raZbGAScWME9kjscVbrqVNNoxzPqSpi57eKma0I8rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TD0mVvyf4OZ2bAEPtrWgggZRh9NiTSYIYzYwCSWTqP8=;
 b=qw57GFFslWlZcbXgOQ7d1N+1EhRC6GW9qKhbe6aDVSyIxHyvgfb3gOPArY2ikCnUBsqKfWi7ejQns5dJ7jf1WkwcM9twRI2nGPJGM4pPWUXAdjSpL/h/hrbcqp1MyYrXs2o+2zZVYRNnP2iqEWfJAcMxOXkz2uvgKQcBem3Q5XRuv/sRlPdXy5q6H65WkuUemZZ7cJD5OYFu43F+6qGjWG/2ulVnMDjPi207DHhqiCAnSFD6Ver8WzFAhC0/bOdpM0bQEJtjW9LY2LBPiYvNgMi9GxZRhHLMhtJOx131HlW2+LqsfP9dZcatWAF2m1pQi/ztTSs4GpIGYfl7UPwmAA==
Received: from BN9PR03CA0884.namprd03.prod.outlook.com (2603:10b6:408:13c::19)
 by IA1PR12MB7710.namprd12.prod.outlook.com (2603:10b6:208:422::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Fri, 25 Apr
 2025 19:35:44 +0000
Received: from BN3PEPF0000B06A.namprd21.prod.outlook.com
 (2603:10b6:408:13c:cafe::57) by BN9PR03CA0884.outlook.office365.com
 (2603:10b6:408:13c::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.36 via Frontend Transport; Fri,
 25 Apr 2025 19:35:43 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06A.mail.protection.outlook.com (10.167.243.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.1 via Frontend Transport; Fri, 25 Apr 2025 19:35:43 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Apr
 2025 12:35:24 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Apr
 2025 12:35:22 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: validate GTP PSC QFI width
Date: Fri, 25 Apr 2025 21:35:07 +0200
Message-ID: <20250425193507.39102-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06A:EE_|IA1PR12MB7710:EE_
X-MS-Office365-Filtering-Correlation-Id: 7e632e94-1896-4846-5e3d-08dd84305e95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IJRIwIW9IWxr7/NsFJMkQnq8HtGQ8nianiiAkfU/wBo1ipP+1O30PKhXvP4y?=
 =?us-ascii?Q?II2OMZE9FHrmYE87pVyw85VnGEjOBYyXcYLL2D3B3Bpxpm0tF94TWA9Q8ret?=
 =?us-ascii?Q?RaZnZvGTMEavP9KmS/yhH6cqYokyqPR3ldAf6NIup79bJZ3135+9IX7u7GJC?=
 =?us-ascii?Q?gqFWjXYem79zTyS5ix93KZHwDZ/THHbP9WTkWcffZaGi+X7sfR5Bc+ZLDgK1?=
 =?us-ascii?Q?Mi9J3ifJXQjKgyVKTI/1idEa96QjoJNdju5IAFQXO6wdnWOZ8MrEpMU2ges4?=
 =?us-ascii?Q?7THzqVPjCk0sh65chYIL/S1nEceuKB3PIa1V9p9U4EnsEA/siPebg8lPZJWe?=
 =?us-ascii?Q?LXswzeQ76W3uQCVGY+8mfbWiiPgCIBIq3yWowPLZCNF/6RGFbjBo7w+68pYs?=
 =?us-ascii?Q?F0UMgf5EN7VGHnBOz7b4zBEfDz/e2ddpAIBf539YSEWS59O2keJGUPoYgL3a?=
 =?us-ascii?Q?KpwyHXstI1FM9B9T0H6pWzJvoMAe/Sh+p7w4+ESJwhpomlEO2KQsLE61AvCj?=
 =?us-ascii?Q?JRowZcBjPIc0bzRjamvIyJmRU7AG8KiBgRlLC4UKB7PL2T6U7qlLL7P5AhEk?=
 =?us-ascii?Q?L31kpb+OTMZBZKedbNzqsFoWHYupJ2sA0+NzOR0B3ZDoiaizijf3CXhuhGYO?=
 =?us-ascii?Q?QZd0/epJn2vVpF/433Q27jLXBhYxLL1wc63sqb/BVekfxAiSQFvHxx/CLIqf?=
 =?us-ascii?Q?9ZNF+AJO3HeJW4x9SV5UiUxMft0qiZQYzYby1fh+xWxNA3wBtE0PAiDenBkM?=
 =?us-ascii?Q?rrJngEK98BLWwRQYBmXWy2cdv0os8KbMqnf3daRsJ53klGETZhkhO6ostPBT?=
 =?us-ascii?Q?lDan39ixt7jtxB2CJRtDVPXii3+HZWGANiUNk3aULC1udORi3P4O5/l8EVJE?=
 =?us-ascii?Q?bWv3zfiwNVB8/Hr2AGb5bcbW7/BmWl2RPi5bUvqt2LnWwejVVfOVml+dv9/X?=
 =?us-ascii?Q?yhocyvEgx0DEnnOoOl2MtqY6nTcoHTEeO7rdWWaZUsYwUPI8n+7eLaIQJiBg?=
 =?us-ascii?Q?ujj0w+zTQyM36rDnyZnsMpDY9kK0JGNTrJ632wEHgPZrGVcnKwUf+DSWyh6e?=
 =?us-ascii?Q?2Iso1myxYUyf1HHmyYx3cqY0a4RLvKfvbV+IIJ64G9Y3WDxBub8hlh4iSsnm?=
 =?us-ascii?Q?bmWLCWIk7z7sgJ0txH/AMi0ze2tyYug0WSXwpcZ1H85EvXawO9E0uJzNN4PG?=
 =?us-ascii?Q?Bt4UWofGNpAbAYi07+daA7OjfRPOD9JpLYoYZAoA+72eDMAhUBpYrstNXucL?=
 =?us-ascii?Q?QcTG3sBdnoQXL3Ym5eHWR0fWoAg04fteKOJJdkA/QqUXovZZ1pksXYvKMSjr?=
 =?us-ascii?Q?58xftfP1EuRP2BsMnLvTW0MtRbVqPp5iMkoif+xwWd0DdYxCsyxZ5l4Oz7+m?=
 =?us-ascii?Q?tlAcECFP8vsRKwJJW4O8187/VnOVrH0D4Lu96BvCXSiHeZ9Rf/i7rEYplm2D?=
 =?us-ascii?Q?eZ7Zze5+c4hcNJkT2hKPGGUP2ZHjYhx40uMxZB+ATRsEmEBGMWcxt1lo+ItX?=
 =?us-ascii?Q?lFc09VG+g7Id6drPzVwQu/o5QQlZZXbSvsyx?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 19:35:43.4619 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7e632e94-1896-4846-5e3d-08dd84305e95
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06A.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7710
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

Add missing validation of GTP PSC QFI flow field width for
modify field flow action.

Fixes: 0f4aa72b99da ("net/mlx5: support flow modify field with HWS")
Cc: suanmingm@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_dv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 608c42db1d..c217634d9b 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -1451,6 +1451,8 @@ mlx5_flow_item_field_width(struct rte_eth_dev *dev,
 	case RTE_FLOW_FIELD_META:
 		return (flow_dv_get_metadata_reg(dev, attr, error) == REG_C_0) ?
 			rte_popcount32(priv->sh->dv_meta_mask) : 32;
+	case RTE_FLOW_FIELD_GTP_PSC_QFI:
+		return 6;
 	case RTE_FLOW_FIELD_POINTER:
 	case RTE_FLOW_FIELD_VALUE:
 		return inherit < 0 ? 0 : inherit;
-- 
2.39.5

