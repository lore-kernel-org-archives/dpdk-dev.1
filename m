Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 609FEC8303F
	for <dpdk-dev@archiver.kernel.org>; Wed, 27 Aug 2025 06:29:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C708540611;
	Wed, 27 Aug 2025 08:29:32 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2078.outbound.protection.outlook.com [40.107.101.78])
 by mails.dpdk.org (Postfix) with ESMTP id BD3D94028E
 for <dev@dpdk.org>; Wed, 27 Aug 2025 08:29:31 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GL9XcYlmQuOMWsH/ZN01qcBSs5iporP/SomZoIrSfcRQ6fvAVDm1JDQrRdHjnjUH0PwOwGdPCVp+tN0x8Tf+AWwnYPyIfI8XzuFk4PQoIPYsUMYR/c0aSlXSooXPBxyWv3pYof+KL+qR40dP0mfpLedXWZ3RQBelt46RyGZcsIoH1uWkuNqYWd2z+1QtLlHWzcP6gA3NK8Z/Xyk+WnEdr1CECLj9WgdmFJbP0UduW8L/LD7cWldHosbr+HTXAc22zchlLtU8/7E6GVdixdclJ12GEOKyFkCJ9i5MSqF6rAL9sWuLnyXKiOO2e2LjbYrMt4WWIVvxQTyrI4IIteUvBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6lNE2qq7Y2K+dkKBb+yp79cQLqD19AceaQ0MFx9xRK8=;
 b=BiUR0JNuwinJyuDvps8JzB/ZMnx4UTbj3sLJOoFgPbqcxC4TC7r7i9yN6ytZ8MNrfpb61JzfGdFX13jGiZ6XJz41D57/HRKhNK/v3Ad15GfkhPu6v3MjCWflXSKoR00hiWbk5rSZJ1kzrhywQefP10rSX8jBydixeS3sRU295pC85A7XQTygcFOCOOlrliNCmbdD/f7K8SP8fCO/de68N6+VsHIHKHxHbCfnDRIogwt76ilQIfvy9Uf8R36NL2oIuGBcfEmfCj4FAHYEWDFgbwkGM7ukISIVR7HGdiBkqLsQwPgzSNe8u+QiaFRVExNNNj87C8wCm7wHA90kYXmWvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6lNE2qq7Y2K+dkKBb+yp79cQLqD19AceaQ0MFx9xRK8=;
 b=qsRHGRWbtPRXRclzWOAgofrsz4SLj1VIpn4ZC6258xJDyy1PThcymEFxaiVJaWHxsO/fsw8GtXcsM8vtlf95pzy+JRC+Rd9lZHHmH1D7Psqz1nvlvpt6zzBN9VSwTUfPBMY3LbUIy4N+cYZlQYM1Tu3wIR+QQjrwhV8M/cu0Ir9fJ01YanNZ7U4HjWYy79ihg+Z5h+iDl+LUkOp9Yo0jPRzZu6mjGpAfJYxmRwG4XdENnUp9KNtxtllpFTxuzR+D9SRKs541ZXrqOd7cwsFG94tgr4wEuYuZ3sdVZql3mHiB9PXnQ0hQ2F5RIpPc3sXj5gA0r4hy7yHaYzy0szEKxQ==
Received: from CYZPR19CA0008.namprd19.prod.outlook.com (2603:10b6:930:8e::15)
 by SA1PR12MB7271.namprd12.prod.outlook.com (2603:10b6:806:2b8::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9031.19; Wed, 27 Aug
 2025 06:29:27 +0000
Received: from CY4PEPF0000E9D1.namprd03.prod.outlook.com
 (2603:10b6:930:8e:cafe::36) by CYZPR19CA0008.outlook.office365.com
 (2603:10b6:930:8e::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.15 via Frontend Transport; Wed,
 27 Aug 2025 06:29:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 CY4PEPF0000E9D1.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Wed, 27 Aug 2025 06:29:26 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 26 Aug
 2025 23:29:13 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.14; Tue, 26 Aug 2025 23:29:13 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14 via Frontend
 Transport; Tue, 26 Aug 2025 23:29:10 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH 2/4] net/mlx5: move eCPRI release function to flex
Date: Wed, 27 Aug 2025 09:28:54 +0300
Message-ID: <20250827062859.55086-3-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20250827062859.55086-1-mkashani@nvidia.com>
References: <20250827062859.55086-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D1:EE_|SA1PR12MB7271:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f978485-4c05-4a65-0236-08dde5331252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?p1zJPq3mwwDOd7Eo2e/o2BizNGkmQ+hdRJa3wBVEYC93xuHB28GiIhhWnxt2?=
 =?us-ascii?Q?H57nUtl/qSwS5L9zs4g2tJKJ2a/Y0yeJemaZ47kRvEvj3vFOd5chy8EMAzBO?=
 =?us-ascii?Q?Ep6x+UamjjbZlCuhY41c9mKGU2+tT+iB/iKoWcemL5yVlvHpnVF8ss0dWoiJ?=
 =?us-ascii?Q?C5r139KexGK9/X6igFLMqW1eMDo3IeyyNsdBD70SYFHlG5g00XwTgMilWRsA?=
 =?us-ascii?Q?QcuSambthfSQAorlZ5rR5X5WZjQY5oU6gAmIsQZT5JAXCLAa6RMaJO5QKdAu?=
 =?us-ascii?Q?i6Vm2wc33B3Jo542pRvJJJ4x2x39nS+younBZuKlCyookxrCWM1j9pJpp87z?=
 =?us-ascii?Q?gHcel6wqdzA4OiY4t5o1Hr3Ph7lCDypnRV5e4A7SI690TYW6kb++9IuPsfCu?=
 =?us-ascii?Q?sMzdcKtUgZ0EKq9b9bvbvrAZZ55v6TIw+A+rZTs/exVbB9gQf/pRVptRJLTc?=
 =?us-ascii?Q?wQ1VQfyKkFSAdS9fYGeT+y8GjNUlCeWu3U7lF+wDEto/xPEudiZolEou3kXD?=
 =?us-ascii?Q?Y0kV/U0WTXjhJFm9jHL33BYxyialiUa/xy026I58Hkp1jZsvEymdAtPFKT2A?=
 =?us-ascii?Q?QeRxkKBAfeLP9iiMkHwVxdsfPyTM+1YP7nwZImjCXuobS/YE1R/FF9biLacF?=
 =?us-ascii?Q?jmh4kJo8g7ktsF68sPvUE60nWcdC2KdBncPS5ZE1VtO3HXTyZkvgXd/1N2VL?=
 =?us-ascii?Q?ucUHBtgLT3KdTU9E9F2sUNdEFmOfv+UYa3xnklE23JAtWv3iVvjhXD3uUsz4?=
 =?us-ascii?Q?h0FPpR9QOa/qYzBvDq+oEiXarSSHVgsX3noK2w/NKpZXQcnoVEeDYD68rZNf?=
 =?us-ascii?Q?fJoAq/0rK9YmEt/ciWahbb1Feik8FhlMEMZfdH15KzV3du1A3LShdnp/3MGt?=
 =?us-ascii?Q?S4sUvvZyQL7oOgBup2egfMetO4UBOGPXojmmLnjzyNkGEeZOaDh6I4ccVLUT?=
 =?us-ascii?Q?HpcWGqcSFUMXPrmFOiME4JlN/rvz6L9UnMYRAPujTkXPUgq46P2FH13RRkFh?=
 =?us-ascii?Q?PoMS7kTn3iTgqtRB1pe/2YnrgUHi5VJAvjP6+Nj3OObD9XuQQEbbSZKtfJGR?=
 =?us-ascii?Q?DB4gcNn2OlOjWDljmEQNAO1GOySIJVjC6hq9K83HO/dvn2jq4MPBnMWeSVVb?=
 =?us-ascii?Q?STxuCs85fueaS+B9GSkakONb0u3BKf2ecQScQaX94iFSdhMd4g/r4M9/IXTL?=
 =?us-ascii?Q?3n/71tw3ihgLC2jWT1yQlDqpsL5DaIx+tk2Ke/WdDrAwUan1ibL65ps5D1pd?=
 =?us-ascii?Q?PXARRX5qA8iJlWHwTcMK7tzvX3h0YWtO1P6dyDzST8a3f9tX+j3tQfwV45Tb?=
 =?us-ascii?Q?fMWwrgBg0AJzmqHCHQCmyrs3dhV+L/ueMRXi+u11a8haid0CEJ4eSZ3pjAlO?=
 =?us-ascii?Q?AiEHWzIAZ0nlbYPxVGxKmdYVdSutPnSGiX9DdnwVAkQ2iscOwiu3+ZQqb/qw?=
 =?us-ascii?Q?TeHiHG+PPRUcN7Tb3Foq6mnCtlC5W2MsxTTYzDMgsgycHguL8oDS0/4GmQv3?=
 =?us-ascii?Q?hkwHEei/df7l3Da9CXMAufMrKlQat4a2SkM9?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2025 06:29:26.9399 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f978485-4c05-4a65-0236-08dde5331252
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7271
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

