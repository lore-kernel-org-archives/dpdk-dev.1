Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 012A2CD4F28
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 07:18:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E28C940672;
	Thu, 13 Nov 2025 08:18:18 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
 by mails.dpdk.org (Postfix) with ESMTP id 8FA044003C
 for <dev@dpdk.org>; Thu, 13 Nov 2025 08:18:17 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Evhs0mJjpA7TA65jYssGaUPOWYm92dzwGBeH9ePgv7xDCj1d6E9aK22RfAZFiLAiV8Vn64FOCm0UhecS1PQ3bHp9sfHPaVltPBy597u6nAUCWK4tPQqg1jVcRUpS0MlNhT/483Nn0OA5gY76/ROdBWo+qW+6Z/Rzn8vr0qliHeSmU1UWdyWV2GHwOnPNnW0qWo7yvBshYnTOUoRG4QPk/lXPs1E4NE1VBaCd5J/Z4oKSx/LTjMTSYQN2xsSVRlXLxqxhlWtWipB2h3jb4djdgQV0AUdCwvdOkPTK424hsgfQImOYv9JsS9mdRiHkW1pK77mHAa1eGmt0vFpLDsMeBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9lUlBPnq+RkizVuW0ih5DD0tH3JcL/LXjIrXMb1voDs=;
 b=w0I1lQNAgvCjmgic7OIAd7G8hijyGksc5ornxqfNrYHI7Tx5pDDgP/A6g8tbI3ekjWaf7R6J+/Zc7kz5X0ModQk5BjYStAlgoaBI2v4aauohGYaYfAKs31/2N/fOTb9gtkWMPQinJxWDmbJ/cVYG/Mc9mUnJ/ZBNLED+3uZ/t0/xz7+Sc0U8gxQR8k+ifZ+YrhE6SARJ63jZij38091JVXRVS3fMz+N5qcqpodFZA9u5Y4R5nHqDSMQEW0UAflJySU8X3erXW5qLmtZQ+GY9iVFmLulp/uch8HtfvcL8ZAc4BDBWVEMN3t7kNq0ZgxBG1zpvG0aX7kPLx9pr77n0Xg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9lUlBPnq+RkizVuW0ih5DD0tH3JcL/LXjIrXMb1voDs=;
 b=lVjKQCm5YM47lN1qSN36wDEJBpwhF3fY/QV6OQYUgAVRO/6Hhb+DvGLDqIy/ryNyPKdePm/ljFuxiJBwl1v8s5B3xo+nOfL80AETjS0yJni8vh5X3NOfkc/CDtRt4Rl2n8TSK9WgcM+CCeh5WwMyPuyiQ824J9QG1HHTjRKWP0VLIdspBVCfbkRJqCKp1RyfVTZxLP+3nb6TF8TJV1n34EvmDz1Dj/iet9Y3vIWqyMr01lpjrciUEuZ1Lj/Ym6ffwB2AuKx8qRO1hJkfZI9sp6Q7IQ/acq/4apzAW2RSCAXm1ymqv+OaAXQKWa7Yy5fjZLZ8jDweJjwrNONeKm5mcw==
Received: from SJ0PR03CA0067.namprd03.prod.outlook.com (2603:10b6:a03:331::12)
 by CYYPR12MB8990.namprd12.prod.outlook.com (2603:10b6:930:ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Thu, 13 Nov
 2025 07:18:14 +0000
Received: from SJ1PEPF00001CE0.namprd05.prod.outlook.com
 (2603:10b6:a03:331:cafe::44) by SJ0PR03CA0067.outlook.office365.com
 (2603:10b6:a03:331::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.17 via Frontend Transport; Thu,
 13 Nov 2025 07:18:14 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF00001CE0.mail.protection.outlook.com (10.167.242.8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Thu, 13 Nov 2025 07:18:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 23:18:02 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 23:17:59 -0800
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH] net/mlx5: fix cross GVMI metadata match for E-Switch setup
Date: Thu, 13 Nov 2025 09:17:45 +0200
Message-ID: <20251113071746.434067-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE0:EE_|CYYPR12MB8990:EE_
X-MS-Office365-Filtering-Correlation-Id: 0edfb324-2886-4780-12b4-08de2284cf73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?titKIX7J3sxbCAVzYMmenY2MNSm8XVzP6GfFlatoh85qORW3DpAdVVFoVu31?=
 =?us-ascii?Q?GjgmGlMtXm3hg9SJr8A0lKWqaWds8878DzUF28nLuaArAGck9vcU+U+LXYhb?=
 =?us-ascii?Q?5lgNlV2CbsejmwlDLqncpWa5Vm/0ZtcRpWfP+9ydVvR06XoSknfKh/xzlhvx?=
 =?us-ascii?Q?JtsB4gxWij5tMZ9n/F21/VhsfFgKvxJz9Fq5EJawN1F4N5Vi6CXggC8W/qZK?=
 =?us-ascii?Q?Sz7fYiByUnMLNsbqbJucPaYxggJHgc8JzwMMfBk399IBOUAZgmBfYBDhP1U4?=
 =?us-ascii?Q?wARCqlvz2z//qj3PjOdONn0vDltX6fjuo8ifGT+rWygjtaEoJgDKOU8ET9Kl?=
 =?us-ascii?Q?uBhi3iSvw3ZEcK57g5R4XqvOkygtAr28RbdBhxtuzuLPFV5mLSfGI8Df+zd0?=
 =?us-ascii?Q?MnbtXXYO4Nk2tcG7GZ/QJA1XE/eVvhOcK4kjs5RcJF10fedHzYEGomKP4FTf?=
 =?us-ascii?Q?Jbb557SURykKwqbJDeQKY72RNjARtuYEBOQIrS3awat1cC5q/6jNuvtcvDYl?=
 =?us-ascii?Q?vUwRH5Aw4O4ZqUcT2mpV7xGesJMHJdCiiaktsUEUNv41ZzmueLX1OjdTr0bz?=
 =?us-ascii?Q?qyiW+ZCCH7smcTiGZRDOT6486LZo6TlpH+1XwsaAecFzZ62z18b7BsfaDszw?=
 =?us-ascii?Q?gJF6Sb5wgK15Ky7bQekmk0ZHRbjuUcVPfCsTTadIiid4IYfmT5Ha/5fElfKX?=
 =?us-ascii?Q?LEm2GA1lXr/LwNBGEO0Gjd5D9t2puH5TsWRCER1IJO09OkA7drH4lWSpkHNw?=
 =?us-ascii?Q?3YSEmQWt5oKn9icU8S2RmUbuJLc2FfGlSUuZLCuaJllO1gsry7gZPZQ/He/s?=
 =?us-ascii?Q?Ilj8B3aOuDwUbu/nM7Y8gHwBs1W5iEs+sS7Hbz5xSdDZykLCZ3UiIne/P47p?=
 =?us-ascii?Q?v9K1sYMM5JBWnV77TMx/iG97SV5svBz7ELs1kqQy9a/9fqoGwGMdvkoYqCZj?=
 =?us-ascii?Q?Pg1XgwPkZRRdG6nrSIaewDwLbND0U3lHPCQu6ITVVL8i3MV+ggrT1iqv1/87?=
 =?us-ascii?Q?UISIcX7AaN8zOebNIgUhH9JwV4J4G1vREIDBW0+TtNcGcvi1uxR5qu8zdOZQ?=
 =?us-ascii?Q?Iut/DY4dS0WgdpaT2yKhoFRTK4NN4h1eZNGCcHZb0KBEdalXeBQtVU0wVxhq?=
 =?us-ascii?Q?ON9e1IPxerf3Xd68h8WlvGYhdnP3LzgIaAOvwn6FzqnUfpFGSgxnS7zi8OZ4?=
 =?us-ascii?Q?V9Kb9PlHyjznxy+Kup6HfyzG0EF5Fww3nMMRf7AbACxr2/U+AxlLk/G/Xbbu?=
 =?us-ascii?Q?Qlv5OnOE7zL+H2njlZ0JPe6Y104Lm0EG3472LYw9CJT03d8E8AHWsl0vBMWw?=
 =?us-ascii?Q?RV8q6PldDJZvqmiVgKN3q+D9/ujRkqNGrSnjVjKso6P4MMuse2kgyffbzZgZ?=
 =?us-ascii?Q?CTCl2xkI4EdpY9blnA44HE3KJ7YsMlCJwVV7rbQzbNHepREDSoU+GTzhhrOg?=
 =?us-ascii?Q?T7mM8nRafosqcDbV3WyqZ8l7lsAH+mqbNMGodRqg4EPt5DMLvDaumI6oR+r4?=
 =?us-ascii?Q?23yApQPZK6hHrUyG4arZYp5iivfnOYs1+A6NXPUv0lUV8CoifDkhQyPNik3i?=
 =?us-ascii?Q?tjgCBdxYnF5OOUFzbPI=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 07:18:14.4344 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0edfb324-2886-4780-12b4-08de2284cf73
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE0.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYYPR12MB8990
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

The metadata flow item did not check for cross GVMI support.

Fixes: a78425ba3793 ("net/mlx5: support flow metadata exchange between E-Switch and VM")

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index e8b298dd1d..2f070d9d97 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -1807,7 +1807,8 @@ flow_hw_get_reg_id_by_domain(struct rte_eth_dev *dev,
 	switch (type) {
 	case RTE_FLOW_ITEM_TYPE_META:
 		if (sh->config.dv_esw_en &&
-		    sh->config.dv_xmeta_en == MLX5_XMETA_MODE_META32_HWS) {
+		    (sh->config.dv_xmeta_en == MLX5_XMETA_MODE_META32_HWS ||
+		     mlx5_esw_metadata_passing_enabled(sh))) {
 			return REG_C_1;
 		}
 		if ((mlx5_vport_rx_metadata_passing_enabled(sh) &&
-- 
2.51.0

