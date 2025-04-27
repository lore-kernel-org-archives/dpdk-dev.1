Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB32AC369D1
	for <dpdk-dev@archiver.kernel.org>; Sun, 27 Apr 2025 11:23:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC3AC40608;
	Sun, 27 Apr 2025 13:23:18 +0200 (CEST)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam12on2083.outbound.protection.outlook.com [40.107.243.83])
 by mails.dpdk.org (Postfix) with ESMTP id 3191940608;
 Sun, 27 Apr 2025 13:23:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xxdZ5odMwMUBUgsrUjIBy04eeTro/BCNHZ/nmRgFT8wCvmXbX0Ap8Pu2QSgEEHV9d5ETlI31jHbWyt2bFweMg9uwlUc6UiWIz95Id6ZQYqyOpMgjhTPs3KRQNFagl1UNsmYYa1Qw89UQontqWLazXzuzWwpa0gqEj8ED2Cp8eZrOIwzzHABSv/U8P1MR4wBpeACHmtruWGB2pNcovs9d7/u1ayvvnOMtoyvDZVIl7F5q/LqNGxtH7mHI94EbCsHUdR6xor1sO2Js4p6X4aPgK+kk77Nj/0Ij/PWXfisZDH2c/JCaWEcLMtel+8UyF6o2SHIufGCsQ7J6OP2NcdkFEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8dPWjyXbghH/FKOI+SnorZGsrJceG6Bi3snCgmUGlRs=;
 b=IuPCc3JfmPHHn0q5mDa1V/0EgGz1ZBnLfCuPzv5xGaGkv4o6yD0jJEfmMQQyFO+Rl+N5+mubqVJLew19ppoUoZ2NHbS8qxorA8HK2t/WNwMs0QrFRVRPsKiIZ2DmLLJpghIjxG4hfgZ9PMhDDXMpCrux5UvtiuyKQQX2HDihuIm8MZuzmNiU8sBCqmglN07G/NJ9hdNI2JGCLQCLkh7g4sUZztqh+jhFY2KCe35MIsDAC6Z/ml6GsVErKs4v689t7HQH0yrB2blIGpI15e8fNbmTM+dIVrtq0kgIkXnSsKWG+CCFxqln2Y6cSjWR9yzsyfhQh58m9Qt2sk1TBKVrBA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8dPWjyXbghH/FKOI+SnorZGsrJceG6Bi3snCgmUGlRs=;
 b=AZMVl/oepX6tuBA0rbAYAzP4kXGg0Q2BPDDB+87hReD9iHFsN//4nPwaBgeURcaaBSRXkeNIUGzpf3Ss0C+K6jd2wVNNZHA6s/OxG0vhvmr3DK0CnHOXoigwsg+K693evVwAEj9lYKB+hGDgi5DNqqjLrWz5uOk7oUWoKYaYRVJ1dzeE3qoZUqQyG+9NQDAB3UQmZkrjKkCqdV/MTlKH9Mq2GL92TSiN/YF4q+d0TU2JEYIKxivkjgj8ekbQH+jrEUhLKcSXCyrFVAo9SSf2LMc/Bwawf+8gLYrRthLbQv9UMjGpEZOUuvPaK7yzfb1aXQZfRPBGcNB2euIWX6SVZA==
Received: from SN7PR04CA0025.namprd04.prod.outlook.com (2603:10b6:806:f2::30)
 by PH0PR12MB7470.namprd12.prod.outlook.com (2603:10b6:510:1e9::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Sun, 27 Apr
 2025 11:23:13 +0000
Received: from SN1PEPF000252A3.namprd05.prod.outlook.com
 (2603:10b6:806:f2:cafe::97) by SN7PR04CA0025.outlook.office365.com
 (2603:10b6:806:f2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.37 via Frontend Transport; Sun,
 27 Apr 2025 11:23:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SN1PEPF000252A3.mail.protection.outlook.com (10.167.242.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8678.33 via Frontend Transport; Sun, 27 Apr 2025 11:23:12 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Sun, 27 Apr
 2025 04:23:12 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Sun, 27 Apr 2025 04:23:11 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Sun, 27 Apr 2025 04:23:08 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 <stable@dpdk.org>, Bing Zhao <bingz@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Gregory Etelson
 <getelson@nvidia.com>
Subject: [PATCH 2/2] net/mlx5: fix coverity warning
Date: Sun, 27 Apr 2025 14:22:57 +0300
Message-ID: <20250427112257.108544-2-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20250427112257.108544-1-mkashani@nvidia.com>
References: <20250427112257.108544-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: AnonymousSubmission
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A3:EE_|PH0PR12MB7470:EE_
X-MS-Office365-Filtering-Correlation-Id: ff8adc8f-71ce-4010-0439-08dd857de5d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?24jUfYKKxOGemGSFCX6rBOL3DRXUlWkv0suVJptDqWRhaZU5+f7tRgp7C1to?=
 =?us-ascii?Q?0egvPZDozpHBxYqnHZFTJ71EcsfW+vyckgZKVY9Dxvll3COfhXu4Ziu9yDB8?=
 =?us-ascii?Q?8ECvKaaD91eVSyirmuIO/5MUJ/cFBFMphXUKw0MJjCcy6ZdWEMoWEubloQ1K?=
 =?us-ascii?Q?pzfM+oAgB5jM4TgE78TypcSkc4jBPwYDS4UUNNmez5iGZs0UQ+pjd2zX9PEw?=
 =?us-ascii?Q?KD+5vhEVLll65T2asBgj+ECFl2c6F63Mqix/AfWPX6MJa3K7bkV2473UkURj?=
 =?us-ascii?Q?rjeOxviAEmOloc3RlGhBZq9Xe5hlAEChIfHAzFsEN6/CMhuwSGuQugGYfchK?=
 =?us-ascii?Q?fnKDZl/agVUASprvxkIp0RI0adX3zNqQzdJZwEmBr3fe/8/pmdvuOMnTyxGG?=
 =?us-ascii?Q?vNme61yCvFJQuHQhuqXFJBpLMB3qrqYVgsc3VtaLZ0k69wL8dSRzQqEa1+u/?=
 =?us-ascii?Q?6XXg+/uYMHBhLJAAtDqtqEMFJ7vE4jc3DRoPYhCzHB4Mhc9udCo2PrBhXjKf?=
 =?us-ascii?Q?gqrhhvC0sMDamVKvU4gmAU+dKsXaxGj/Jqw5OJqY9/BbdMkfno1wJBcwVi2m?=
 =?us-ascii?Q?O7FPm8e6J9ctzcnPS54oGb6sDdSh47Lr2F9A8hd+4mLqGmQar6wp6FEgukFK?=
 =?us-ascii?Q?l5hU/hZ7Hc6LsEGcZhP+Ni6OsQXXqGc2AKT0ScWPEZU2edP0Y5USiGLSyDg8?=
 =?us-ascii?Q?NJ8iwLPbQ5/5dKX3kA7jEszJFrx7KWwrxn0byCZ+AeLQQFtG9X6HQqV7ZRfg?=
 =?us-ascii?Q?9wmUZqMyy8W5Up88K05/c6x7KgQn9rkZS2DQ4kPlr2pZl6Ce+npFat9aZr2p?=
 =?us-ascii?Q?WGShclBqCMyfJRDpqmBNGivl9xahgdRzciv8eiO3dwoWNkF+F+ugTVKms+b5?=
 =?us-ascii?Q?NUsmGEppxarO96Um7/gXyoPbCEe7KRmzw1CcjT6HyWf11U3eOWZ3VqxSpcKx?=
 =?us-ascii?Q?mio7ahIjwDav1iDFeFxldI1fnT/sTfh87Qweix2FOjmQpqvDVUUqXUry84mn?=
 =?us-ascii?Q?8+t6FONiZWp8e++LJU3N71AB4skqnU9YpcGLlHtFV9k75nkPbJ0E0g8obUtX?=
 =?us-ascii?Q?n1VFAfl1oZJu4C4eQEISAYHEPTMt2iVJPNqQ6NtCLrdjgCIleFoes32eS2Sq?=
 =?us-ascii?Q?j9y98tWMgppoKMq6fNsmmmIUfOg3jDdFL4AGDxgP8rhxrA8aRbop8D09gp7C?=
 =?us-ascii?Q?+qAOgJHS8vNd3E+29YvU+VAoyGvc4HpA1qczrqsQyYwIKFk1W4FLYGfypLlp?=
 =?us-ascii?Q?RG/2t+SIuGoJefr8bSE2YpAEiaABw6O/LuaavFVBfrBmTVatjxvMToIZCFIo?=
 =?us-ascii?Q?M2jEYo1kKIIlxC+6ti/iYdfI7Z92+LdM0rfUfqIQrwTNLUFnRCmG/88EMerg?=
 =?us-ascii?Q?Q/FrY+kL9Qt7u66K4WiPNvzNIAz2qnFmbZVgA3yJQRhySZ+V74TFH6BGPSAZ?=
 =?us-ascii?Q?Mz2Cxr41zi3/czWsb0XpuoQdfpWtj0kwWBXqcJoMjjxxcBxzWRRW5r/JvzJA?=
 =?us-ascii?Q?5eCEBw5y+ys0gawIPwMR3MQHLzrlIwpNjSw2?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Apr 2025 11:23:12.8758 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff8adc8f-71ce-4010-0439-08dd857de5d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A3.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB7470
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

gre_item was dereferenced w/o checking it's value.
added a check to verify if null before using the pointer.

Fixes: 80c676259a04 ("net/mlx5: validate HWS template items")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow.c b/drivers/net/mlx5/mlx5_flow.c
index e2f4bd8cef1..93ee6f75626 100644
--- a/drivers/net/mlx5/mlx5_flow.c
+++ b/drivers/net/mlx5/mlx5_flow.c
@@ -3333,10 +3333,10 @@ mlx5_flow_validate_item_gre_key(const struct rte_eth_dev *dev,
 		return rte_flow_error_set(error, ENOTSUP,
 					  RTE_FLOW_ERROR_TYPE_ITEM, item,
 					  "GRE key following a wrong item");
-	gre_mask = gre_item->mask;
+	gre_mask = gre_item ? gre_item->mask : NULL;
 	if (!gre_mask)
 		gre_mask = &rte_flow_item_gre_mask;
-	gre_spec = gre_item->spec;
+	gre_spec = gre_item ? gre_item->spec : NULL;
 	if (gre_spec && (gre_mask->c_rsvd0_ver & RTE_BE16(0x2000)) &&
 			 !(gre_spec->c_rsvd0_ver & RTE_BE16(0x2000)))
 		return rte_flow_error_set(error, EINVAL,
@@ -3379,8 +3379,8 @@ mlx5_flow_validate_item_gre_option(struct rte_eth_dev *dev,
 				   const struct rte_flow_item *gre_item,
 				   struct rte_flow_error *error)
 {
-	const struct rte_flow_item_gre *gre_spec = gre_item->spec;
-	const struct rte_flow_item_gre *gre_mask = gre_item->mask;
+	const struct rte_flow_item_gre *gre_spec = gre_item ? gre_item->spec : NULL;
+	const struct rte_flow_item_gre *gre_mask = gre_item ? gre_item->mask : NULL;
 	const struct rte_flow_item_gre_opt *spec = item->spec;
 	const struct rte_flow_item_gre_opt *mask = item->mask;
 	struct mlx5_priv *priv = dev->data->dev_private;
-- 
2.21.0

