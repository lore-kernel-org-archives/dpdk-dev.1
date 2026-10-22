Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70AE606A319
	for <dpdk-dev@archiver.kernel.org>; Thu, 22 Oct 2026 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eTbNO9pJ
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1CF840264;
	Thu, 22 Oct 2026 09:30:51 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012044.outbound.protection.outlook.com [52.101.53.44])
 by mails.dpdk.org (Postfix) with ESMTP id 0B3BE4003C;
 Thu, 22 Oct 2026 09:30:50 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DiLzQJX9VNW6Gz65RJvPNZAy5PWNOeMNInZesq9JTuo1AH6JAVEUmxcncJ7aXzrOH5pU+tuNRnVbUwZ+I3xqM2J4FH5D3K0B2tIdHNpFLMQFs5jweMGFEGvm7mVVILCuTIz+6ZhJuqOwh6jjZ8mTfGTVk0nEVocoJWw4WNMUsCSDiclPgthWPWva91atkOniwVWEqA7xk7SM2r1hyQ6hQnqKnNtkfoH5xPhpdm9achyc9j4kBdc747swGPOil2lhRc0FY5TApBqj4Qi2ijzbU10qeqmRpavfDKplA5WQfTFYZYCUS58r0fo1h8AFlkr16tPqVSgA1yTsFs7L9yYeHA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nAB1AZFDPE9nSuDDowdwmHGvTytb+xAqhofq09WUKDY=;
 b=UDbbBDKRxDYVmnf9xWOeaWUFi5Jk9Gk6L97+hGj10tnvoI7y3qqEOVZ97ccuK9tdpWoUpWWhMA2U/SFhavxiWSHqjk1bjsSoW4bEtD37trG8qoo7ykXSwdEEycqCEecWcokGoOwQljZHBtqx04Jf5W/mZxtke654yXdM5DmOJP0n325OThghD5xm/8eHwr3rqbGvq+N9Gq4JUr2ItwW75u5DQ04nvg/UIPONyDIJmAkN2tR3zQI/MsiFZWykmS1mtI7CFi8RToEnmSDlMF8eFhA8Gle5ZIajpE8L38mH/5BE6wm0QUnUIDUkzrlvA5pncT9GsBYVGjLGlEjzzbXpyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nAB1AZFDPE9nSuDDowdwmHGvTytb+xAqhofq09WUKDY=;
 b=eTbNO9pJngH58QVLB/zZWjfYKqa7O64+La/7h3A7lkV4C/cFTfj6OHJzxyO7sQKedZNZF+phWpiWKyCUJHsk/itqT79WGlwuzjrLTmyyrlVD9mgrppnn58DmQc5U62yreiAeCVZ8jnBYE+glpCdVs8rMMySeMmMiQiSBzM4+0W/rciJ1TzkH9wSwKi+4SdEsv+M0mwVkHTILbsBoNhVxw3m1BRaTdZKmxtu2WOA612OD6+OEn/uyCZPRJTwcwHoPvVzbHtXkKYfCuU8QDR9m812knWFXyrbpQHnTOdT2uEKX50bW+2sfktrfEDrqBQLHWkPRedIiwIpbBe+SCLcQKg==
Received: from SJ0PR03CA0370.namprd03.prod.outlook.com (2603:10b6:a03:3a1::15)
 by LV3PR12MB9142.namprd12.prod.outlook.com (2603:10b6:408:198::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.15; Thu, 22 Oct
 2026 07:30:46 +0000
Received: from MW1PEPF00018893.namprd03.prod.outlook.com
 (2603:10b6:a03:3a1:cafe::1b) by SJ0PR03CA0370.outlook.office365.com
 (2603:10b6:a03:3a1::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.16 via Frontend Transport; Thu,
 22 Oct 2026 07:30:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MW1PEPF00018893.mail.protection.outlook.com (10.167.249.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Thu, 22 Oct 2026 07:30:45 +0000
Received: from rnnvmail205.nvidia.com (10.129.68.10) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Thu, 22 Oct
 2026 00:30:21 -0700
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail205.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 22 Oct
 2026 00:30:21 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56 via Frontend
 Transport; Thu, 22 Oct 2026 00:30:18 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>, Bing Zhao
 <bingz@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>,
 Suanming Mou <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH] common/mlx5: fix mkey ordering enum
Date: Thu, 22 Oct 2026 10:30:11 +0300
Message-ID: <20261022073013.72607-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF00018893:EE_|LV3PR12MB9142:EE_
X-MS-Office365-Filtering-Correlation-Id: f5f592cb-1cfd-44b8-1754-08df300e62d2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|261009223027099003|261021123027099003|56012099006|11063799006|10067099003|18002099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: fefAm4uOAfyqB+QpjeZ/PGn8xG1S3pnGe3kpFrEd+srYF/6GEsw255gkHRdNL7gQDmsA5iRXI7jTpGkbwEQlnV37PfYP3yBaFURj4tRXzcWcoX0nQRZTmVlJUq553JI4HVfxHSndx544HtyWgDyzvV5pJmWx3pAW71dYCN622GoRrkrlvLjrysW/0k0YTlL9LH2Ap2vx7Ygvv8GaN0qvIll0MpmF04/3nYSopEIHumETSYOe9VqTjkToz8aMeQyAUF+Ibrzj4ecBTJlLAmoWGxSC+XsWrtafk5a8WR/zeDK5AVtIvNfVXCnlia55hTFR+vSGU9eGpZmiwwlJe69NDdbv2xzfwb5ognlXNaxk/iJ6L10fYyd0oc+EOIv+2kYwxbzvC+Rb4BX+GTnMlNqZlJui4PMXHxXmvMPC+cxxOpKLvxTO/flIyLbQAnzzdHZ8kfolAI1JdbmTYlK55R2Kd0g2pB7PGkAwY4eBlSTP8GvAqqwYx0T3MwAuL6NTFjPOdGZ71Sf9bx04CO5wn+npujBjmvTXgSbJ0SQLmNFPGpTcwD6ouJt7sMg+J87Cyrj+YI+MDLdDV0krxFdUGZpGGlJoBgj6dxe6pQWumJuXuJBGocE9tVTqqIAL+oZZoI4dW1snwWYO0xJWgGjMsumzB7zL0XMwaqCbXYyP+1S2K5DMS8vow+GS2Fv3NRn0U/2sgIldU5nsDppkRfuxw5EXkw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(261009223027099003)(261021123027099003)(56012099006)(11063799006)(10067099003)(18002099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2Ow1FRdE2t5t9qyhlKHrkPbJPNPM0knHLetzI3wOpq8RuXimeb5WutuRMnHDEn5Az/oRWmo/Z9JvuxsVRyByYvRhNJnDc0yZGjG12Uckv1DCBj0XwptqK+0lLiGn9BTmsdkD5XAZ1odk62cWjEDQ7cQPcfS90+Mbfhf47qqrj6zDePIjY/4bwD7suKJ6hDZwm/SJGuKRevAFT6HaVegdhWv8XdCnAJGBCqN1eGtn/ht8udy9i8ZaiWbsgHr3VRXHGtA+B89v5UhmjPYoOoqlxeV9hSAY8XmbWJIGe08g4kMQkXwTXLzBx4EYohxax62NesuF+hUA4WPYW6+cJqy+400ZHK1BGSyQVskWr3bu85i7J3RL+MBwiLJaEx9qb2HVRt6XEDSWqye6rSibjLSJ/GKuTeu/kXPZIX4PIe+dvVoR1UTWrtyoq+RMU+q+G+kE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Oct 2026 07:30:45.3976 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f5f592cb-1cfd-44b8-1754-08df300e62d2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MW1PEPF00018893.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9142
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

The updated device specification defines relaxed ordering as 0x1 and
reserves 0x2. Update the mkey read-after-write ordering values
accordingly.

Fixes: 5003eaab7e4 ("common/mlx5: update relaxed ordering policy for mkeys")

Cc: stable@dpdk.org
Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/common/mlx5/mlx5_prm.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/common/mlx5/mlx5_prm.h b/drivers/common/mlx5/mlx5_prm.h
index c2810194f8e..7ae5ece6c32 100644
--- a/drivers/common/mlx5/mlx5_prm.h
+++ b/drivers/common/mlx5/mlx5_prm.h
@@ -1483,8 +1483,7 @@ enum {
 /* MKC read_after_write_ordering field (2-bit, dword 0x38 bits 9:8). */
 enum mlx5_mkc_raw_ordering {
 	MLX5_MKC_RAW_ORDERING_SO = 0x0,
-	MLX5_MKC_RAW_ORDERING_SAO = 0x1,
-	MLX5_MKC_RAW_ORDERING_RO = 0x2,
+	MLX5_MKC_RAW_ORDERING_RO = 0x1,
 };
 
 struct mlx5_ifc_create_mkey_out_bits {
-- 
2.21.0

