Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43DF4C28B28
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Mar 2025 11:24:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D604402CE;
	Wed, 12 Mar 2025 12:24:10 +0100 (CET)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2082.outbound.protection.outlook.com [40.107.93.82])
 by mails.dpdk.org (Postfix) with ESMTP id 43C1940265;
 Wed, 12 Mar 2025 12:24:09 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FxguhRXpCCenQCk313TAXSbsOSsA2XURHh8Cxpww5Zhz59iDY98i1OCSlqOMaNfgNJ5gS2zXG/5rNhfUEBR4Erzc/WosbKNlUD1qiOZFqKFU+nxx7I+QylkFZuKLKf/slbfXsgjGdlcco9okBcxGGlQf+no9Pv4t1yf4UO9qLMuvQ+UwVB56d3YhWaSGOcPEWk1pbsfQMoB7n/A3GqodERAaBuEkGCFu57JdzdgC5W5yp66cLGQpVKQiG8wjxCPl71+y0WfDKkLaKpOz7BkpJ/K3Aq3dChFmJSs47vdphG1imu4rpCyZC60rKQw/29a9B0D5q07A3VDWN/sx8NY+fw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mp7TBz2MUga53TdpHSCsKOM3aA1iiudK6HzKksjOWhc=;
 b=VvtH9KV6nTKAW9mgndDygh+lxy1pQEekAhRmVBF0mXhj4zJJuT1++DJuiBOZkZ9+YQKjRURwyVGIrcv6QEOWu0ICOMuBYbdviEZyXcuBvJf945WZFymoc6j7bFfnFqLKpu5Ut1wGwu3RERjJOu5F8CUI/sSdNX3MqeQZ7+7iSSy7UFQn1XvTiPjVgL7skB00+HEZGnk+E9z6Xua7JfdhxKMWUByqBzuoNinVayQB/99eU/4MsXS524lpx1AIuUooSQtUvfJVAMLWDYcfGfVO4vggEorAL/2GSvKEt9N/ihUy/ebwpYP7ok5e0fzb4OS55sYjwFZA0XtDTlek/xjtAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mp7TBz2MUga53TdpHSCsKOM3aA1iiudK6HzKksjOWhc=;
 b=Fyqbl2Uj2jt8KZl5Dv7kh1zGk60Ep8HA2M4NpXmsIZL5gMpi1UNXuyG8kRbmVdKmJWv6OkKN8dE/CubfMY+eGlIu/bQ3efCH6jrfA5Ot64N3T7g18w7GWZA2gBNNxtCgj+oK22Lok6lWIK1xFAAPQI2BXV0ClKw5J86a1l7+ZtYrW4HmIYi4hRwMbgrpiFi5FJJioFqfepK8JVphL2AUFhF3qzeZU7wLmtAQKWecbenYDrC/NOAMxzGEXJphSyyo811G9zWc4Q/50pwqysUCXIV1aXfuD0aKTXxxfZ1F7iMKYUvpai46Iae8eXNn9Yf6qw+jIji3C/AqmivJZL3RKQ==
Received: from CH2PR10CA0003.namprd10.prod.outlook.com (2603:10b6:610:4c::13)
 by BY5PR12MB4033.namprd12.prod.outlook.com (2603:10b6:a03:213::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.28; Wed, 12 Mar
 2025 11:24:06 +0000
Received: from CH3PEPF0000000E.namprd04.prod.outlook.com
 (2603:10b6:610:4c:cafe::7a) by CH2PR10CA0003.outlook.office365.com
 (2603:10b6:610:4c::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8534.21 via Frontend Transport; Wed,
 12 Mar 2025 11:24:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000E.mail.protection.outlook.com (10.167.244.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8534.20 via Frontend Transport; Wed, 12 Mar 2025 11:24:05 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 12 Mar
 2025 04:23:55 -0700
Received: from rnnvmail201.nvidia.com (10.129.68.8) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 12 Mar
 2025 04:23:54 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Wed, 12 Mar 2025 04:23:52 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 <stable@dpdk.org>, Bing Zhao <bingz@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Gregory Etelson
 <getelson@nvidia.com>
Subject: [PATCH] net/mlx5: fix failed to match on empty gre on root table
Date: Wed, 12 Mar 2025 13:23:48 +0200
Message-ID: <20250312112348.61807-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000E:EE_|BY5PR12MB4033:EE_
X-MS-Office365-Filtering-Correlation-Id: b4ec3144-3b77-48f4-7ee2-08dd61586660
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?H9Vk5i4Lh7Wrpah+Ui4C2XOGWzSIZ0HyAGAm8dECSj6IYLcUcVGrSLhDgJRd?=
 =?us-ascii?Q?4niYeAeUgrTeKVNwvGA+QNU+OBe6zdyFCfYmpznZn+HNmFzhhP0eyVduYRL5?=
 =?us-ascii?Q?HcKYGt//Z4S0PM7WJibe1XV3ErxPezEKPpaiVfNGqLzoh/sqqfBetaR9QP0w?=
 =?us-ascii?Q?dYPCr87fTeSrHySB9qba2Pf9PZMKeuaLd5czq5+dcCIxuFeCRJZ+Rt0aaPip?=
 =?us-ascii?Q?VpQutVWj5Q5EldM6GMHma0bCPXfqYTuJ9e3zbqwqxbfirg4tgjFG/ew9dq7+?=
 =?us-ascii?Q?cCD+EP0FhhSYBjtruXb5peMTGdcCmCyzDLu3gdYycQib99bWVyv3DvJgTvnS?=
 =?us-ascii?Q?5MqdXFbvtPKkFwEcaVmf8SboL8PNCD7g7RcD02wg32lk4FStR/2z9WNV3vmD?=
 =?us-ascii?Q?p3126VwdFy2cfT/4SMsO2s/tkKZLNV4Z8KEvrfBQZLK3RpIHqBW0QGXErKmo?=
 =?us-ascii?Q?TdOp5Jv4y7cAYQrgUXDl2+EXP6GyWy3Krthlii9I1lTkZpCSOlOgPpCnU1gb?=
 =?us-ascii?Q?hl018/w4XUL7vof+sKViNvpTrwvMp7jxEBoPlfaDLfQM1osjnOtdpCxeMXh7?=
 =?us-ascii?Q?2wHIwi0mZl2St0WVlixoxKCxlxyAcSxTwIbtG4oSenCRHxpkXCPh5ipFjbxu?=
 =?us-ascii?Q?X9FrpHyAOFPbCIXXNDMDGgpLHDz22vNY+Bog3nDYD9fAu+cpTHDA4Mf79AYC?=
 =?us-ascii?Q?x2r8y1jFHZ+ZYM7BTwtd/Iy5pt8z+zkidMpCxST4/fVaXn9E7o4AnUwn/1qH?=
 =?us-ascii?Q?7aHTzgk2oppQIyAMF0AqcIoHmWvuKhZxEdAf6yvU315QuUXFCU5wMgW/sryC?=
 =?us-ascii?Q?tYR/i7+yLuLD26FyghZn6A/u78UhF/KXAResFll5e6RXD5ZFMOjyB+INdozC?=
 =?us-ascii?Q?iQq3a1L81cJki2Bo8wnWzdsvUDey8pkyXeGiQvvqR94W5QUiKzk2tJB2Vmt+?=
 =?us-ascii?Q?p8hxE+E/l+focQL6Eiy3NZq22hOfSR8sbnd0xlSz3mEq3uwnJMYKsBXNInK4?=
 =?us-ascii?Q?80ikGJ/x8GfslzVgsM2WGBQZjsDYBKsCpOD8IaOcjhIHrCbbY6pHaFEDeFuC?=
 =?us-ascii?Q?uzGG60s6k+hboLURfi4Pj4qc4DGig8THkKFo5kcrDtRIF9Pg9pP+7ROiPgA3?=
 =?us-ascii?Q?NhKto706ElNXQT+S/Wn4KNxEaMPB7fuISkXg9hpfb0TyCXCiPZtlwBaKfZb3?=
 =?us-ascii?Q?HMVKmcE4Fv5BouUvcNFDInAyHAqjSACwBIXfDJex8st+bBC7vq3ApFDO5ifw?=
 =?us-ascii?Q?gVteuLxXeig8953bZwh25w3JLwYaYajSsZnj/CsZjEl8JUgfMpwNWW/0cN0+?=
 =?us-ascii?Q?i0MY+absiJ9FFmFmk6rso1EbSKG+bbcyx4Cp8vtGh9/t0pX16nIEb6i2CJ9J?=
 =?us-ascii?Q?hp5RtUNNdSLs5rhRKXyIU8MEV7EwCMUU/N5NRnYTdYjJB8M2CcuuvZIllAV5?=
 =?us-ascii?Q?HjZ0T9o36eyhxpPMp/zOAVcmz5nbe+k23pY5X0zHCnk19ruzB/RePJQnoDkz?=
 =?us-ascii?Q?/yT9pZXLdMN6vMY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Mar 2025 11:24:05.7375 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4ec3144-3b77-48f4-7ee2-08dd61586660
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000E.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4033
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

Therefore gre packet with protocol value not equal zero,
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

