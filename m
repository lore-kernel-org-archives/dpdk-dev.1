Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4289BCA0EFA
	for <dpdk-dev@archiver.kernel.org>; Tue, 26 Aug 2025 11:46:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BF025402DA;
	Tue, 26 Aug 2025 13:46:42 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2041.outbound.protection.outlook.com [40.107.237.41])
 by mails.dpdk.org (Postfix) with ESMTP id 43F36402DA
 for <dev@dpdk.org>; Tue, 26 Aug 2025 13:46:41 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BCWY/HXYmqMCZj7HvW3wvsF6wrBtPPnf+C+A/okCCri3MkhN4TQ2RSuaQ560vEhC8QgdlK4ChS3Fx0X16VSm+Dqk9+cnDHdziSbunMc6phIUTt75O7eMkwXBgxRWv0DRiwDlvPjI8R18bSi5p3bHNp6YyYYcRO2OCjg/NrX25tZczD1P3dHdbwmsR2s/E4E40TR0Y1pKuhMqzpbgP2LQluz/u+1B4FQgBOwybiNSUzFNbLsd80KZYqAmlEYhp2vX64u4HxsY+sIEXTmjR7M+gAq5LqFgT9Rp+FrghvJpFHjzmfY3y+sdPvOup0yXXhjj36AV4J7abO2Xp/MuZEDGGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lNE2qq7Y2K+dkKBb+yp79cQLqD19AceaQ0MFx9xRK8=;
 b=NAEXFVGhacw+lF9Kp+uLUpfs2fnByrHFHd0yRKPzdQv/08aZLn5bnIC8Yr5w14I6iEezRceWWlQmWnaAJc6piqT7BsiCPZkKCUIinrfelu5vusH5lopeGzffhgMNGXsOCn0pQ1Lmad0jvqgxTZGSh60YIlbZqWpiigU2RI+IpR1DpuDrp0yyfg5c0WmAS3/YtW2DuDPUU9HqIDkSepysopKwO38Jom8mxIzJOVzZP6gBevErfxGX1GUhU8uy7W8z9uAWFXmiEIImxYKzaR17n+qGdErm5LYpJlEejmhOhN/dSRhikLVx5ndKbsm94S+mQmIfbmcKPj7x3UJMUImKzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lNE2qq7Y2K+dkKBb+yp79cQLqD19AceaQ0MFx9xRK8=;
 b=sz0iZGCDP2PWSgaUCby8imro9ttA16NCU8GB/zq7LfVAXkvqCxvoDNtxOZQKaO7vLHwMfgbLb/EkXU5g/BACqTyY+rKH0+8FOZ3js+ySReI+OQ9PtVo49V45MdTAvfTQW8d+HE8U3pmCcTaBDAygfdRCYOE9A3E3AIevaXdpeuEbJyyqXqD5lq/5PwFpLTdvo7/L4HRsxpbJt67YeTEIwbX/DMZ6Lfpj93PREWaN4eZEIERw+tyUYmanJt6KoH/bZI4Sd+wyECP7HzT+uIyGa0QbnwlHMEAJtGfxw/FJ7T3LOPgE5QGp2dzsYAqFXKzLnkBKIAc/lbZm1kEvLQXy1Q==
Received: from BY5PR20CA0002.namprd20.prod.outlook.com (2603:10b6:a03:1f4::15)
 by LV9PR12MB9807.namprd12.prod.outlook.com (2603:10b6:408:2eb::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.21; Tue, 26 Aug
 2025 11:46:39 +0000
Received: from SJ1PEPF000023D7.namprd21.prod.outlook.com
 (2603:10b6:a03:1f4:cafe::8d) by BY5PR20CA0002.outlook.office365.com
 (2603:10b6:a03:1f4::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9052.22 via Frontend Transport; Tue,
 26 Aug 2025 11:46:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ1PEPF000023D7.mail.protection.outlook.com (10.167.244.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9094.0 via Frontend Transport; Tue, 26 Aug 2025 11:46:39 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 26 Aug
 2025 04:46:30 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 26 Aug 2025 04:46:29 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.181)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 26 Aug 2025 04:46:27 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH 2/4] net/mlx5: move eCPRI release function to flex
Date: Tue, 26 Aug 2025 14:45:53 +0300
Message-ID: <20250826114556.10068-3-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20250826114556.10068-1-mkashani@nvidia.com>
References: <20250826114556.10068-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023D7:EE_|LV9PR12MB9807:EE_
X-MS-Office365-Filtering-Correlation-Id: 4139f158-3e03-4c05-85c2-08dde49637f4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?USnwOVkby8j3Yt1cCiOLCUL3fHAGEhgXo8p5W2oNpqGPGxpsloNeVv767BbV?=
 =?us-ascii?Q?rVcq8pJ6psGKgLvi2xVRc73uOUhAUsq6F/0q91Uv4FFG7SfOdS5JinKJsBIm?=
 =?us-ascii?Q?M38Hn+Q5F2SGl7N2Mp9VBapUmuZAQz64ICPdqDNj/7+w7hI6H3ukwrdHtjBi?=
 =?us-ascii?Q?homuTXIoOzH0RpJtjpsaDueBNLjiC45WY7AahPgQyI75tN+rN+YRuixVJot4?=
 =?us-ascii?Q?MAH6PDL9u+XQX9stJOzLKyJT+6eiWIvFMr5N1nMvVJiPEa92MXRlyhbR/Y4S?=
 =?us-ascii?Q?NNcl7gRyxUM9h1eV3Ha9+TrrpdrvJKzWrQtxkDH7nRzLNb7o9eOxvlzM8+pU?=
 =?us-ascii?Q?l3i6GfRnLKNt8e76GWhKnwhJuAb0AaeSBxmE01+thofQVbPtfdIEAElvK1vm?=
 =?us-ascii?Q?ECRm3FVnYvzh8tlL3qTuvMLICT4Ysz8pUbaSs7laD4moQqY8fXVbziqjDUBl?=
 =?us-ascii?Q?QCwsB71iXkRUHMNOJqlAPsa1Pt631KdufVtL8xydo6QrHvH0EZE7XCFKbW0T?=
 =?us-ascii?Q?27LFV2U1v/F7h0ATAlSWTZVxdtZ9ge+wWzmduVU0Bp+76ogCeVWEc1WG8ucF?=
 =?us-ascii?Q?SmTDALGepRhNf50I5TGh5bHvzmXGKPrASvc6d8d879YNuVcYuSu+7HByMzZQ?=
 =?us-ascii?Q?3fw/WNJcjz9+OF/9+U6cSXl7S1hm9qseMz94FtPGFXEgkMrZoj7xnB7+8SiY?=
 =?us-ascii?Q?zb1cFWlwxMf8FrW8wpzkUePj4Ww759rAR4tFCd+iDgsJMEiiJFYRNLGU9Jjs?=
 =?us-ascii?Q?BpfdqVvmLwd/OJ2S1cjF4hDvFcywvDiQ5lIfvdJbVuhKe2cESZw7zOKvNgQC?=
 =?us-ascii?Q?jVCnz9Jz8AR2K9wISoPihU/Vfs2QLtllSZ9RNjas50y7ANimNqAvQ1IInvSZ?=
 =?us-ascii?Q?M924WUwpfx8HQ2eVDXw/bCwCdDermw4ygYC2RYdeaDj88s402ki4dtbG6k+H?=
 =?us-ascii?Q?lx5dQcDBs5mor1CeIICMHjEFsh8+LiqsNrhUayCBY6M+REph9FRIHJOLTsFu?=
 =?us-ascii?Q?Pn1Fr1dHy8W1N3AXA4EAHhmB1UOpYhGhMDJcCdRsTJJL2vVsVoJMsy3/dyhv?=
 =?us-ascii?Q?c5klPuZCnLuniwxhvDTGCLpd/+iMvfY5Bhl4Vmp5qiLhvvYqeA2DdpWY8Dvn?=
 =?us-ascii?Q?qNiM5O2trb+4s1g5co7hQulIQviXJLX15VrTn3i0xg1vZgpMtXZO7YHe2C/K?=
 =?us-ascii?Q?0QCG5Ym4DQCWnep5wnKuUpFRf25d5Qrte7N7vWXpElqTiREgsw0ez49yQSUB?=
 =?us-ascii?Q?+jT1zYv2c63d7cGVm63XAhqzFuD7vjfd9tgLNtk6/y4Cam5KABA6yn4eznku?=
 =?us-ascii?Q?37I7qbLL5Nei8hWyS1QzKFWJGo3gOteQLo4R1j53dIpc0ORgVAV9NssX0lbK?=
 =?us-ascii?Q?czqDZ8fWSZSP2/9V4blOQvM4HyH2Qf0g5kPXJ5cI7ViklESCwB/nIdycGsWf?=
 =?us-ascii?Q?hQpiMIJb5oNLPWZuXdaZeKG4i43tMthGmMYzbkuSFjWWOTJT7csph3SEn98I?=
 =?us-ascii?Q?TDOrPCojTUnuKcqDnVblOPZY0Fxt30xd9/DJ?=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2025 11:46:39.0843 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4139f158-3e03-4c05-85c2-08dde49637f4
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023D7.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV9PR12MB9807
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

From: Dariusz Sosnowski <dsosnowski@nvidia.com>

Move mlx5_flex_parser_ecpri_release() from main source file
to the file dedicated for flex parser logic.
Also, make the function non-static so the function can be used
in flow steering clean up introduced in follow up patches.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5.c           | 18 ------------------
 drivers/net/mlx5/mlx5.h           |  1 +
 drivers/net/mlx5/mlx5_flow_flex.c | 18 ++++++++++++++++++
 3 files changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 1321be779bb..ece29fb2164 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -1044,24 +1044,6 @@ mlx5_flex_parser_ecpri_alloc(struct rte_eth_dev *dev)
 	return (rte_errno == 0) ? -ENODEV : -rte_errno;
 }
 
-/*
- * Destroy the flex parser node, including the parser itself, input / output
- * arcs and DW samples. Resources could be reused then.
- *
- * @param dev
- *   Pointer to Ethernet device structure.
- */
-static void
-mlx5_flex_parser_ecpri_release(struct rte_eth_dev *dev)
-{
-	struct mlx5_priv *priv = dev->data->dev_private;
-	struct mlx5_ecpri_parser_profile *prf = &priv->sh->ecpri_parser;
-
-	if (prf->obj)
-		mlx5_devx_cmd_destroy(prf->obj);
-	prf->obj = NULL;
-}
-
 /*
  * Allocation of a flex parser for srh. Once refcnt is zero, the resources held
  * by this parser will be freed.
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 53f0a27445a..32f98f969ce 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -2735,6 +2735,7 @@ int mlx5_flex_acquire_index(struct rte_eth_dev *dev,
 			    struct rte_flow_item_flex_handle *handle,
 			    bool acquire);
 int mlx5_flex_release_index(struct rte_eth_dev *dev, int index);
+void mlx5_flex_parser_ecpri_release(struct rte_eth_dev *dev);
 
 /* Flex parser list callbacks. */
 struct mlx5_list_entry *mlx5_flex_parser_create_cb(void *list_ctx, void *ctx);
diff --git a/drivers/net/mlx5/mlx5_flow_flex.c b/drivers/net/mlx5/mlx5_flow_flex.c
index afed16985ac..b1174fe0eda 100644
--- a/drivers/net/mlx5/mlx5_flow_flex.c
+++ b/drivers/net/mlx5/mlx5_flow_flex.c
@@ -1557,3 +1557,21 @@ mlx5_flex_parser_clone_free_cb(void *list_ctx, struct mlx5_list_entry *entry)
 	RTE_SET_USED(list_ctx);
 	mlx5_free(fp);
 }
+
+/*
+ * Destroy the flex parser node, including the parser itself, input / output
+ * arcs and DW samples. Resources could be reused then.
+ *
+ * @param dev
+ *   Pointer to Ethernet device structure.
+ */
+void
+mlx5_flex_parser_ecpri_release(struct rte_eth_dev *dev)
+{
+	struct mlx5_priv *priv = dev->data->dev_private;
+	struct mlx5_ecpri_parser_profile *prf = &priv->sh->ecpri_parser;
+
+	if (prf->obj)
+		mlx5_devx_cmd_destroy(prf->obj);
+	prf->obj = NULL;
+}
-- 
2.21.0

