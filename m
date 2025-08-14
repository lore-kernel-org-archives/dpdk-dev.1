Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE8E7CA0EDC
	for <dpdk-dev@archiver.kernel.org>; Thu, 14 Aug 2025 13:22:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ACF77410E4;
	Thu, 14 Aug 2025 15:22:13 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2077.outbound.protection.outlook.com [40.107.244.77])
 by mails.dpdk.org (Postfix) with ESMTP id 6B366402CA;
 Thu, 14 Aug 2025 15:22:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zU4GCKCv+tzsELKJjEaNwH61Q7ITq2nmbk1uJCd3PuouEWze0fvrNLnUojOcEL+6jdYahOUYr/YrcX+iuW4ttMiBvpQq/5CG5W6kau9L6ikCmtzC/Qpz5s2+9Wl9lokohhpxqAy+VlrnY8YfJ+O2g0jXnxJ7pFro9o8fbm2bvStwwauyj46PJTUxXSmRCO2o+TQYu7OGCBqUUvuF08e+kzdc/hx5fg+0noyr4ytUX6zz0uGpZxcNVNGXGdL7q6ibFqK+cUwBfZbViSrFuPI2jJala4lWQ7vFmLR2VsiWOT0o3WSNA7nUtzt4C/mdrMj3ulSLrZAOI/rf35HnZQ1EWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RIFgkhleLeGPgpS4zJFEqqPwnEeEI33zZiobS7yRrc4=;
 b=UNxu7fmuvtBvoZdwa+DKBgDatPMD61UKukeFQR+MQ5EadGEvsTU6Yaygdt9hDCCa+nHUe4Nd8uG/8/tv0axcJTkn0z0s7ws9erCBEdFLrzJY48GiJaWfmVIourN5GRmWMuTpBT+KfdfiTS3Y+ho9Ij3sY8aNNDMOwIzAL1z0De583jXeHyHSvAoqaDmtloyyqdJx6x71vjMv1HZK7QY+ND2W0urg/EkUqdZJ55OdGuglqyG7N/JZhOysaoQonKWv1WxUiClQUz7IHGJu5EEm++vCzenY5E9l8Yo0w3DsX1q9n0i48/zfJsqZwK7xku+7ki1BZWODd8J/OJUMZh3SrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RIFgkhleLeGPgpS4zJFEqqPwnEeEI33zZiobS7yRrc4=;
 b=HklzsvciHL7zyDK0+U7TsJekTuCc621RPWSqjVAB7znPoXHFZ4GuOz0dZRyBu7ik3D9ka9PL5qQWDrPifF31+5pDssJoK6NKyYlxjavf4JxzC5sLQTu+DWPqJDGuOcAf5H0juEL64KxSa/N1eiIMKQyPJwuSCTZQc2f5eXGrwFHExaEet2VSwa3rNhg2ZYeCAigcICmdliWujJoTZF11mKsLbmSOqbHWE+lKCrZ9Kr3ZjKZTWOwSnrjOxGU27nNxw9tKiCLnBJd7PWbTNKX6URjyZ5g5Xo45ks3LolFgn1Az2i6Y4cDqUm2US81xFkewx1b4ntAaVM8eDgjgYhAc2w==
Received: from SJ0PR03CA0113.namprd03.prod.outlook.com (2603:10b6:a03:333::28)
 by PH7PR12MB9203.namprd12.prod.outlook.com (2603:10b6:510:2f2::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.17; Thu, 14 Aug
 2025 13:22:07 +0000
Received: from BY1PEPF0001AE1B.namprd04.prod.outlook.com
 (2603:10b6:a03:333:cafe::86) by SJ0PR03CA0113.outlook.office365.com
 (2603:10b6:a03:333::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9031.17 via Frontend Transport; Thu,
 14 Aug 2025 13:22:07 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BY1PEPF0001AE1B.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9031.11 via Frontend Transport; Thu, 14 Aug 2025 13:22:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 14 Aug
 2025 06:21:47 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 14 Aug
 2025 06:21:45 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Alex Vesker
 <valex@nvidia.com>, Erez Shitrit <erezsh@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5/hws: fix TIR action support in FDB
Date: Thu, 14 Aug 2025 15:20:02 +0200
Message-ID: <20250814132002.799724-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1B:EE_|PH7PR12MB9203:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e684f0d-0e4a-43a2-64f7-08dddb359140
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?99rzcD6o5z9+W64wL89SsKF+pPK9kBH5loy0l8ALsqJbXm4c1KqvN7UnIxRy?=
 =?us-ascii?Q?uYrTa1yBn9g4e60gsoQBNxVmc7/awJt6IsgAJti7cWE6hfnFvlbHyNGt4KDy?=
 =?us-ascii?Q?TqJ6Ji8p6WqAYhlL16KYb2jBcVzvYPCpBTVhXKHX6/swQobL8ZAApWpgYVST?=
 =?us-ascii?Q?7wyvGHSDEFHik8vGkj3r1iROytMlNcqTsshIKq6bxEUtCrjWAls4mqmmwtOL?=
 =?us-ascii?Q?kPWLBXmdL/LuUpoxX+lPRaZ39SFQDNCiW+mWHSsKYOsvNUv7+axmcjG0Qaj7?=
 =?us-ascii?Q?03ItPKl1MNltLmHlYpMaUNYxS1prTGs9E2LRVec4m54ib5XzkCHkDD8otVOE?=
 =?us-ascii?Q?jrM/chN5o++kOyPA8qDcwKTnDU0r63jz+Jq9EB6jUzbaEjqwOo1a2m4JlSTr?=
 =?us-ascii?Q?Vfj8A6tyUI773ee21poAFMx4OIur5ndRiQJDEC2WQnnCxz8peHTQl+hvY1pb?=
 =?us-ascii?Q?/i4k4ZhvA3G+E4dU73oV1ffARvTK+JIHBmN296c1IGtbYo12fIZeL34e4gV0?=
 =?us-ascii?Q?3vjhk8urxBIF82hy2HDFih1xiOskeRcdaAP98XTO97ZCmKh0JMSOThHT0xhq?=
 =?us-ascii?Q?TBmuAbs+GWDHH7IGFFYp/BpWxlWaRR91gqdYa6DTqVlRFq95gvpHuzcO690t?=
 =?us-ascii?Q?C3USQ6EcrTwey7Vdb26dxQK8kp3g3ZF6VZ/GLtIpsHfJhMFPeF7lEOtK4w5F?=
 =?us-ascii?Q?UyzBVudwX/Xxj6h3euBEfKaSZgfAni8wU63dq9EU/RXGHgifk6AeeBPuE7Qt?=
 =?us-ascii?Q?rZVElffokAagjyS2O4Ub94tQS5Pj/UZXAf7Fm523gm/zeqjxMsENKaAZcHwU?=
 =?us-ascii?Q?PrQvDyF5Oe+y1Ts0CEW3NVVf1FMcaGC0I/knmcix1hY1EgS2GM2bpTix7Fzk?=
 =?us-ascii?Q?i2VNWEZQJU1VAGNvgdFPCCHR9/MXn2jyTSZ8t9aQ/AQxcabALppPXqHrbvIr?=
 =?us-ascii?Q?I/FdP2hCeJs4oCqFbSHlj8XF7UMWc0OwN2f3MdE88K2x3OquznUh8wlC6DxB?=
 =?us-ascii?Q?GmCVXOmidMiBIrRwyaqU4lMYBPQH1PLud4rC4Hgm+5iEHzk/qD0YA/R0I397?=
 =?us-ascii?Q?MGsRxG+j21h+3UX0utvGCPU+dxm1ZCR+gyyK6JmHkeivj8J08I8BxlVNQks0?=
 =?us-ascii?Q?QKIRTUciXDohENP+P2NrW/NrObOez+gGzy376B+Fp7HWWZbEpnx/VSCm5Nf+?=
 =?us-ascii?Q?UZ6n3BgWMnZiKTAJg1hZQyxkWHYOJm0/OSNlTKpz8YEVVb94nbKp9NL8jCEC?=
 =?us-ascii?Q?PuEZHKJ3tlrxBdNHxsPU7rSZlim9bUh4kkICo3shX9nonAU16Ncdc7Wg7Ii8?=
 =?us-ascii?Q?opPShFGQTzYXKFOyTqqaIJS/xlFr7N/CEFpHbV+BB0s8dUSPkZfjN7AWqZh4?=
 =?us-ascii?Q?h/lf61fk3+MnVfU3CunyjZ8AnYFedbOYAFlkanCFQlNAaB3+NUl8qrQU/hVn?=
 =?us-ascii?Q?RcJfZx2BhkoKFyv2YB3fxbAE+8qIPu87PHUC6zWCiCcUlyZpv2r7Tzs3Lid5?=
 =?us-ascii?Q?taT/wLsOq+aqraG+PXoGCrsaJm5bnbKX5Y55?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Aug 2025 13:22:07.2892 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e684f0d-0e4a-43a2-64f7-08dddb359140
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9203
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

TIR action was not added as an allowed action in FDB domain.
This prevented the usage of RSS flow action in transfer flow rules
with HW Steering flow engine.

Fixes: 1f8fc88d4d31 ("net/mlx5/hws: allow jump to TIR over FDB")
Cc: valex@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
Acked-by: Suanming Mou <suanmingm@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr_action.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mlx5/hws/mlx5dr_action.c b/drivers/net/mlx5/hws/mlx5dr_action.c
index c1c6d28ac4..d765d57a8f 100644
--- a/drivers/net/mlx5/hws/mlx5dr_action.c
+++ b/drivers/net/mlx5/hws/mlx5dr_action.c
@@ -94,6 +94,7 @@ static const uint32_t action_order_arr[MLX5DR_TABLE_TYPE_MAX][MLX5DR_ACTION_TYP_
 		BIT(MLX5DR_ACTION_TYP_REFORMAT_L2_TO_TNL_L3),
 		BIT(MLX5DR_ACTION_TYP_TBL) |
 		BIT(MLX5DR_ACTION_TYP_MISS) |
+		BIT(MLX5DR_ACTION_TYP_TIR) |
 		BIT(MLX5DR_ACTION_TYP_VPORT) |
 		BIT(MLX5DR_ACTION_TYP_DROP) |
 		BIT(MLX5DR_ACTION_TYP_DEST_ROOT) |
-- 
2.39.5

