Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E7ECC28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 09:56:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C39DE402CE;
	Wed, 12 Mar 2025 10:56:06 +0100 (CET)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2070.outbound.protection.outlook.com [40.107.92.70])
 by mails.dpdk.org (Postfix) with ESMTP id 5C97A40265;
 Wed, 12 Mar 2025 10:56:05 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=J0IVzJZ5PrYODxKEOFd3jw5cRqd45BDZNNvUA06dwlfG9lSS3QLcjixOdnVdpfjMlKgstbFUXC3LK0/rzo7eVD6Rzt0d0ximWTDj3K42XpUEkPYlUelBaMxVmKFDXkAqqSSAAuCuYk3gdokDdeL56BM3UpebUSJn9BD2XSfSvPrsRyeTPU2FK63F/R2aJsvDzhbfcmNHIklpqY77Dbbtyq+bOEgGW0Rb7XrcrBRNUOIY0OxR6rDuYaxFD/cCOZofEvs1GYrsrNa9P1QcmFhgO8aKMdM+Pj7sHwTaf97+CaMTUyXqcDTTvcts9LPxpSsFmfhEgtMxgrsNvvFtjoAzKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=neC8qJgml6NQLdbRhfJPiWY21aXV/6ojtcXVY3qkFpY=;
 b=GgDqSXItCLsjFxdDeRz9Itc1Xp+kua1T1wKbN566g6+8ZeXacXE6KPuYvrodZuGR914x5LNyMu3NVvURIYSLxjckrQ+YV6ONTTOFX9FU5GTfHoF0bSWqBMtVQ6VOcsKG3Ledxrb9B3mOw6NjA+Sp7zXlxTX9wDEv5jzsMIExCeF+ZmfyYaV+DSOxdSkwx+mmCf4T9NzthpgnOa+l3B0m/QfltSYCMPHkCXey4zsVqjdmz+C/2H9ZTim/JEL1ouG+DohP7z7oIcyH3plAPEWExZ2YGl2e1sMyVsme8a5SxR0A1T/ih7bXgCIEDnkwWk5gK6UzQfhLBrbaGt1dhukj+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=neC8qJgml6NQLdbRhfJPiWY21aXV/6ojtcXVY3qkFpY=;
 b=VH0aY2ddiO5ao/3J8ZbKllQia5RPZibhD3+vhvYg7AxmE709YHwbO/ScwhpzHNVARa5DrJf8JbaTT3zRic/cBCIuU3SUYHpTrbQosdeD3OdsKvQH3AHfyG/+0LFkguRs4NKh7XvP008Xhkld36CkpAut4LjplMy0D0wUGMJwlXkA5VCGAsNuKwG0vjoJFH9sS+WNEiTJtTRxlGcoU3B2uChdiaALtgG0Nf/gOpKT1ySqsPODeS/9HMhyEG/PMU7UFfiuiEwNRSI8XDjymbusFLTjMSd2XlICRU3fcGkuL6ATPIMKyFXcxP7fiNsLRx6a+Zg8zae2PDId/nokh7VkXQ==
Received: from SN7PR18CA0028.namprd18.prod.outlook.com (2603:10b6:806:f3::11)
 by CY5PR12MB6202.namprd12.prod.outlook.com (2603:10b6:930:25::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 09:56:02 +0000
Received: from SN1PEPF0002BA52.namprd03.prod.outlook.com
 (2603:10b6:806:f3:cafe::32) by SN7PR18CA0028.outlook.office365.com
 (2603:10b6:806:f3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.27 via Frontend Transport; Wed,
 12 Mar 2025 09:56:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF0002BA52.mail.protection.outlook.com (10.167.242.75) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 09:56:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Mar
 2025 02:55:46 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 12 Mar
 2025 02:55:46 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 12 Mar 2025 02:55:43 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 <stable@dpdk.org>, Bing Zhao <bingz@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Gregory Etelson
 <getelson@nvidia.com>
Subject: [PATCH] net/mlx5: fix failed to match on empty gre on root table
Date: Wed, 12 Mar 2025 11:55:39 +0200
Message-ID: <20250312095539.58555-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002BA52:EE_|CY5PR12MB6202:EE_
X-MS-Office365-Filtering-Correlation-Id: f796be0f-e3c2-4520-babc-08dd614c18f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CujeyEURbuWAWe2N/kVoJrkPVd6Q4E4jKgpokYbbVxmxXxwATAK3hZTbP2dO?=
 =?us-ascii?Q?o1UpMiPCydCseDQIPd+jshldkNz7nDuAW6f8TbvusmF3b7zQYnCwAAkPg1FI?=
 =?us-ascii?Q?Ak8raigXkvyxSqItGRko9Ebp5tgygbwu8h2oy1KszHPJtGdfu/lBnJhxz+rE?=
 =?us-ascii?Q?Zo6CNx0mCQE3AdVgBAeyFLaLz4IMI6NtvoV6O3W6RJgAHC8bDzMyVprp7nRw?=
 =?us-ascii?Q?p6O1mDR0baFNyLcAq9JSKN4KmXt+0I/O857hk9lswB1zK929R6FuzJA52YMR?=
 =?us-ascii?Q?8gxi+fvLiPMsSvBUzA87vrqHYHU5WbwGdr0BlcVdT+xnRkS5GyZTCHUZBVkH?=
 =?us-ascii?Q?PB1e3qe8wiyt12uSWRiBjCdBG6wt+AE7oC4m9dIvORqf6MZjpirucCRG0JZq?=
 =?us-ascii?Q?osJXGS1/cONnNUpQ5KOM0M+25G2vmP66SlP6VQr3mKEJnyRR+bBdGmj7S/TT?=
 =?us-ascii?Q?lyM3b+ejQYWHrcgTTcAzuHWLRJbfZ7yTKDGJB09dB9Iav+9RNzbjlhdLijJ4?=
 =?us-ascii?Q?zTOnwdDxv8vwgd0Uh6UxE4AOvlE3XSgc5fv8/hu9I8faXynjjVWeGUkxg95R?=
 =?us-ascii?Q?aFhAktRj0Ss7GF03DZC9P4miexr4bRkFpuo0yn4IrOxwesg36mJCTFTFysUu?=
 =?us-ascii?Q?dCl0m7yVQRErU8x3C3v5vksKfnOu5ezgw3zov3BXAm/6OjjommSZ4mEkhlNi?=
 =?us-ascii?Q?rwqIEMpHSUeznHUu5nmNWY+RVS/9GgdXfwMlAaXwzqMLCGu1GbPclz2vS3LM?=
 =?us-ascii?Q?1fIbodH7K+YE57gBslyPDbpTCyENr04WsegWGZ3iPXeCZa42akDtR93c6lrz?=
 =?us-ascii?Q?f29Q7+32QRrVIuxdsCTin8f/1f0zUjYr8APj5GpMrRgy7FhL6WSArSoA+6nb?=
 =?us-ascii?Q?Vy4HDW+OBjSjejj/x6u0MwfoiQJegey+POWGI8FcD1GLH9t0QA/bxnkQORAW?=
 =?us-ascii?Q?OtfjH+4vfu/64PCSWGeozHdufPhLA04hBXK3qfBPlL6X8YXH343lMTAi1FN6?=
 =?us-ascii?Q?dANgUtLzh/VYnNV/6TkifCKOP5KLlZCKt1tDOwzkFljeXA7sSypO1iNPJ/Ep?=
 =?us-ascii?Q?wUia494AnobxzDwTLVtEcWjomDrLVUs62QtSJrx7JTEKTwUGVEULOO/W2r1j?=
 =?us-ascii?Q?On9Sm9XA7/qtHiOBs8v/P0YNQvF999MqvrqtI9tf9HdI3twtx+CCcllkYfMQ?=
 =?us-ascii?Q?rjhadWaTkZmLZvoNES8iz7iKN34Tku1JoB4QbtyOHcZQV3LwJFxnWHUBScht?=
 =?us-ascii?Q?bsYwR/9p8WXgm6svV427Ow0sHJNGu91J6L4mltvGl1Qts72EWNmeOyQODlYB?=
 =?us-ascii?Q?FoSoD1/NgvrAC1FbiSAlGoKF+QtATeC142O0N9rEOsZgNyFxVTup+AhqejdR?=
 =?us-ascii?Q?5G2XE5ZEMoEbfiP6y2L4t1EsLNK9wE1yfTlAb4aUCH2rQliYGo/saqEAt96U?=
 =?us-ascii?Q?IQ4UjHVBmbkrgBRUtdpsffN9x22eXkYszH5u+A+CKQtOI+k7Mz+Jsu2Y0ckP?=
 =?us-ascii?Q?1by/1xQ6dpKtAKw=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 09:56:01.8976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f796be0f-e3c2-4520-babc-08dd614c18f1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002BA52.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6202
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

The currnent implementation sets a gre mask with protocol masked in
case the user did not supply the protocol mask.
In template mode, for group 0, the gre translation was called
once with the mask and later with the value.
with gre open matcher(mask/value is null) default values were assigned
gre protocol mask=0xffff and gre protocol value=0.

Therefor gre packet with protocol value not equal zero,
will not match the rule.
Changed the default protocol mask to be zero instead of 0xffff.

In case of empty gre match,
this fix will ignore the protocol field matching,
gre will only be matched by the IP next header field in
previous header in packet.

Fixes: 25ab2cbba31d ("net/mlx5: fix GRE flow item translation for root table")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_dv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index c77041317b4..3473c6f7713 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -9850,7 +9850,7 @@ flow_dv_translate_item_gre(void *key, const struct rte_flow_item *item,
 	/* HWS mask logic only */
 	if (key_type & MLX5_SET_MATCHER_HS_M) {
 		if (!gre_m)
-			gre_m = &rte_flow_item_gre_mask;
+			gre_m = &empty_gre;
 		gre_v = gre_m;
 	} else if (!gre_v) {
 		gre_v = &empty_gre;
-- 
2.21.0

