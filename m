Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2888E606A324
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 13:35:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=eLubTPaA
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2992140297;
	Wed, 11 Nov 2026 14:35:46 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012024.outbound.protection.outlook.com [52.101.48.24])
 by mails.dpdk.org (Postfix) with ESMTPS id 8D92E4026A;
 Wed, 11 Nov 2026 14:35:44 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FPGU/DpwkLCLTJVJcNIHRBi7XfrLNUuDLdd9/6FGzZNtTeZL6nRUjvPBSMabzYJ1+X8T761gjuy3K5hNhX9n7xLAF/u9P+NdW7/PXtR+WJIUYWsH/7CeGq6sQYzCHvnkrXaADUXK6OOrKq7Cr9wDlR4FtsClWFUYM1Qigyvnz/jxKSYNcbJhhRvjKf8b47IJ4iwuNe1XV74dRWmjNMWhN2Iv4Cs8A/3XaUKjUoFLNiuoRr4443+wC+gQWASyGyyXUz99QMbRH+opwq6G1WifBxPsdlhUuoiqtQYjDwsaO1Pv1iPuQpizjZQMouozv/gy5OlRqkfMzE8yx9nO1nmdpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBpOlaZBCByPLb8aD3uVqMncvyNvBAZmsuVkUh6eYFw=;
 b=GQVZnxhYg5NQx3cwq+PNnSNY6DFeRiGjiiBbnmkb6Ay4gqOS5/yx43FGsxiKGbTHY3jBQc1fiPLQ3rKTiKyNij92Jxhsg5WCePvLmwv7GhcCO4zynNjdM4GZr84sHnq/IaVHOya0/lQW2f5EbceKt5QulI9HvP4UYT2Utq2TZf/35f3cAAUsWu6iKvy2Q1l+nGnXkbD3U9q2sj+KV3hhbWEyauyAzbBap1n4110kuanWTc4krVtDimjzu0+9pXr4nLwQFHJPJFDpKAGx+BAaFCeDqTCXVpFBwM5yhBGzxa/8UycbM5f40BTSFsNxGGUQzGHhGSl/VwSTSCwUCQ8Okg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBpOlaZBCByPLb8aD3uVqMncvyNvBAZmsuVkUh6eYFw=;
 b=eLubTPaAZsIaoAGjmR//W4JC31cByNOZVqmThNgntjn/XVSztcSEJklqTs1L/jJPNYGWn/OrxVPJVD51r4Vtk1eVT+4bc9sqw0AIVvP43KFmUxmcD8BnxvKtVTgxRELopiJze1t+X5L9dPPnEjzQVlHmBX0Lr43HljAQvkiJCf3o1BCOcR+BnitcxwGUFE2wCxpHE4dRnsEt+OxJdBgEqB/AUFTdG+mI21XtBsyEL3UBGX6vnx0c6cWttSZRsW+k9C0d5FsF4SNU2+HxExtgjlKWalBXR4Oql+/tV//VVCidNZTJn6KxbNT0xcSKMLk8TLHVCatqyOFU79c1PxLyfg==
Received: from DS7PR03CA0126.namprd03.prod.outlook.com (2603:10b6:5:3b4::11)
 by CH1PPF7A6EE32B1.namprd12.prod.outlook.com (2603:10b6:61f:fc00::616) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 13:35:36 +0000
Received: from CY8PEPF00000055.namprd05.prod.outlook.com
 (2603:10b6:5:3b4:cafe::1e) by DS7PR03CA0126.outlook.office365.com
 (2603:10b6:5:3b4::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 13:35:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY8PEPF00000055.mail.protection.outlook.com (10.167.247.56) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 13:35:35 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 05:35:14 -0800
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 11 Nov
 2026 05:35:10 -0800
From: Bing Zhao <bingz@nvidia.com>
To: <dev@dpdk.org>
CC: Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Li Zhang <lizh@nvidia.com>, Shun Hao <shunh@nvidia.com>,
 Michael Baum <michaelba@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: destroy DR domains after ASO close
Date: Wed, 11 Nov 2026 15:34:52 +0200
Message-ID: <20261111133456.49554-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY8PEPF00000055:EE_|CH1PPF7A6EE32B1:EE_
X-MS-Office365-Filtering-Correlation-Id: 1dc2fca1-bef6-43ae-8bb0-08df3ff8aab3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|23010399003|82310400026|36860700016|10067099003|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261022105027099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: LpCiCJh2SkUJAE1Z3udrkkcp+kbD8GsvQMm1llZ+wBcJh1mJsuTq2sTbSuhWbcbnmkhYfN7wXGZycagu31/yOUCrb+fPhyZF3c9e6/QxKmvCIixJlMhm1KCGPymssnLYZYOYBxtFF87QtRDNyPgo12BO/nj3iI13TDqkey6bKNbx7bnZ/wn7OzR3YkpWNhQFkexM0/nYCWfMjpCZj2R3/JPB24CyuM091eRMqpHpqTFZGsEfcffReQvpQILsVZ42fmi6Fiab2xXoer0vhdKNf3NWMAmnfxhkuxVjxxMRn+/dkJ4G1XU8e8IwPsYjmw05t/OIRvTgmf5cgiqwGR6eiCAsNj/ZrMnevhDS0HFN+IhI15I5F5sigOKErxrA1GY8C/kU2/JElCoPS7LEMc8ZfE3ygZ/PJoh8PFWtQv3aUpo5Xxp4tyYQmz/v70qoJ5MMlnxP0r5p3PxWqX1KCk7++9xNYKFg2WW7QDjLNu0aJIw9CNDZoGeC7BsLAZpddPa29BozTnpedRjJ/p+Q0/+8G80UwUCydqUDvQgfjA1r3hi+lgYCUTCbEXJBdT4U1N2sBcXvAGkkNhsX8NOTtFkM+66fwOW/Tl+GmRESU2uliEepDOtKSgqWZY9nfw1QcSTZ+s3npUK72vS9ZpiZSoa22J6dlFiU5K4aaTswRf02kDwkQRMY08008/wRltUY3ZgIc9WOc20KAlP14rJ/GKr0MA==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(23010399003)(82310400026)(36860700016)(10067099003)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261022105027099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: V47MABVsx0beVmAEy7V1CGqy2RGVqQeizja9+fKgaGFEU/edRjuoct7D5cZ/60pmOMCZwoCauumeyeUS9LxEwbw/d/OwX62fi19ZXQsOozLCjOv1Msb4RqEprLzLsLTF22Y/KIB66QcEpOv+rfl6UDC411CWjywRsVojYKSUcCA305GmxQRT1zo7ohtlEctMldSFlUUuV4YfvDTipyGlL7B9QgaMqCOybxaW83bF4P2Oabgr6C5XE6Xb7NWZMLyL2aosIEzeKukt29+S3LljOmVX9/WEEluG498G/5dBiCTijLeunjD6FOQcE0LuJfNQUd70tHSoLJPq/n3FReh6kTDWzB65ex3XfuD6rZB/0jN6L6Dy741Ln9bq7nTSVdZ5S/vS6lWavpLF1zoXH8T+1H37f9Es0zSuay4SYE4u7Ij6G9yRMT/2ZCo2y6h4uEv9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 13:35:35.7300 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1dc2fca1-bef6-43ae-8bb0-08df3ff8aab3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY8PEPF00000055.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF7A6EE32B1
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

ASO age, meter and connection tracking actions are created in the
shared DR domains and released only when the ASO management is
closed. That close runs in mlx5_free_shared_dev_ctx(), while the
domains are destroyed earlier in mlx5_os_free_shared_dr(). Freeing
a domain-bound action after the domain is gone crashes on close.

The domains belong to the shared context, as the ASO managers do.
Destroy them in mlx5_free_shared_dev_ctx() after the ASO managers.
One port close then cannot drop them while another port still uses
the shared context.

Fixes: f935ed4b645a ("net/mlx5: support flow hit action for aging")
Fixes: c99b4f8bc2f1 ("net/mlx5: support ASO meter action")
Fixes: ce12974cce72 ("net/mlx5: fix ASO CT object release")
Cc: stable@dpdk.org

Suggested-by: Matan Azrad <matan@nvidia.com>
Signed-off-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_os.c   | 51 ++++++++++++++++--------------
 drivers/net/mlx5/mlx5.c            |  6 ++++
 drivers/net/mlx5/mlx5.h            |  1 +
 drivers/net/mlx5/windows/mlx5_os.c | 13 ++++++++
 4 files changed, 47 insertions(+), 24 deletions(-)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 4c35737292..fb4a5a6fa2 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -689,18 +689,7 @@ mlx5_alloc_shared_dr(struct rte_eth_dev *eth_dev)
 	return 0;
 error:
 	/* Rollback the created objects. */
-	if (sh->rx_domain) {
-		mlx5_glue->dr_destroy_domain(sh->rx_domain);
-		sh->rx_domain = NULL;
-	}
-	if (sh->tx_domain) {
-		mlx5_glue->dr_destroy_domain(sh->tx_domain);
-		sh->tx_domain = NULL;
-	}
-	if (sh->fdb_domain) {
-		mlx5_glue->dr_destroy_domain(sh->fdb_domain);
-		sh->fdb_domain = NULL;
-	}
+	mlx5_os_free_shared_domains(sh);
 	if (sh->dr_drop_action) {
 		mlx5_glue->destroy_flow_action(sh->dr_drop_action);
 		sh->dr_drop_action = NULL;
@@ -774,6 +763,32 @@ mlx5_destroy_send_to_kernel_action(struct mlx5_dev_ctx_shared *sh)
 }
 #endif /* HAVE_MLX5DV_DR */
 
+/**
+ * Destroy the shared DR domains.
+ *
+ * The domains are per shared context. ASO steering actions are created in
+ * them, so callers must release those actions before calling this.
+ *
+ * @param[in] sh
+ *   Pointer to the shared device context.
+ */
+void
+mlx5_os_free_shared_domains(struct mlx5_dev_ctx_shared *sh)
+{
+	if (sh->rx_domain != NULL) {
+		claim_zero(mlx5_glue->dr_destroy_domain(sh->rx_domain));
+		sh->rx_domain = NULL;
+	}
+	if (sh->tx_domain != NULL) {
+		claim_zero(mlx5_glue->dr_destroy_domain(sh->tx_domain));
+		sh->tx_domain = NULL;
+	}
+	if (sh->fdb_domain != NULL) {
+		claim_zero(mlx5_glue->dr_destroy_domain(sh->fdb_domain));
+		sh->fdb_domain = NULL;
+	}
+}
+
 /**
  * Destroy DR related data within private structure.
  *
@@ -801,19 +816,7 @@ mlx5_os_free_shared_dr(struct mlx5_priv *priv)
 	MLX5_ASSERT(LIST_EMPTY(&sh->shared_rxqs));
 #ifdef HAVE_MLX5DV_DR
 	mlx5_destroy_send_to_kernel_action(sh);
-	if (sh->rx_domain) {
-		mlx5_glue->dr_destroy_domain(sh->rx_domain);
-		sh->rx_domain = NULL;
-	}
-	if (sh->tx_domain) {
-		mlx5_glue->dr_destroy_domain(sh->tx_domain);
-		sh->tx_domain = NULL;
-	}
 #ifdef HAVE_MLX5DV_DR_ESWITCH
-	if (sh->fdb_domain) {
-		mlx5_glue->dr_destroy_domain(sh->fdb_domain);
-		sh->fdb_domain = NULL;
-	}
 	if (sh->dr_drop_action) {
 		mlx5_glue->destroy_flow_action(sh->dr_drop_action);
 		sh->dr_drop_action = NULL;
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index e2dbd2977b..4168d62039 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -2130,6 +2130,12 @@ mlx5_free_shared_dev_ctx(struct mlx5_dev_ctx_shared *sh)
 	}
 	if (sh->mtrmng)
 		mlx5_aso_flow_mtrs_mng_close(sh);
+	/*
+	 * DR domains belong to the shared context, as the ASO managers do.
+	 * ASO steering actions are created in these domains, so destroy the
+	 * domains only after those actions are released.
+	 */
+	mlx5_os_free_shared_domains(sh);
 	mlx5_flow_ipool_destroy(sh);
 	mlx5_os_dev_shared_handler_uninstall(sh);
 	mlx5_rxtx_uars_release(sh);
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index 7923125c5c..9b6d7a0403 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -2644,6 +2644,7 @@ uint32_t mlx5_flow_mtr_max_get(struct mlx5_priv *priv);
 struct rte_pci_driver;
 int mlx5_os_capabilities_prepare(struct mlx5_dev_ctx_shared *sh);
 void mlx5_os_free_shared_dr(struct mlx5_priv *priv);
+void mlx5_os_free_shared_domains(struct mlx5_dev_ctx_shared *sh);
 int mlx5_os_net_probe(struct mlx5_common_device *cdev,
 		      struct mlx5_kvargs_ctrl *mkvlist);
 void mlx5_os_dev_shared_handler_install(struct mlx5_dev_ctx_shared *sh);
diff --git a/drivers/net/mlx5/windows/mlx5_os.c b/drivers/net/mlx5/windows/mlx5_os.c
index cc60f07e17..1117cee1de 100644
--- a/drivers/net/mlx5/windows/mlx5_os.c
+++ b/drivers/net/mlx5/windows/mlx5_os.c
@@ -310,6 +310,19 @@ mlx5_os_free_shared_dr(struct mlx5_priv *priv)
 	mlx5_free_table_hash_list(priv);
 }
 
+/**
+ * Destroy shared DR domains.
+ * Windows has no DR domains.
+ *
+ * @param[in] sh
+ *   Pointer to the shared device context.
+ */
+void
+mlx5_os_free_shared_domains(struct mlx5_dev_ctx_shared *sh)
+{
+	RTE_SET_USED(sh);
+}
+
 /**
  * Set the completion channel file descriptor interrupt as non-blocking.
  * Currently it has no support under Windows.
-- 
2.43.0

