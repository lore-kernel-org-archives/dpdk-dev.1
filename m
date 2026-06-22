Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D691BCDB46B
	for <dpdk-dev@archiver.kernel.org>; Mon, 22 Jun 2026 07:54:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A2E8E4021F;
	Mon, 22 Jun 2026 09:54:54 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011050.outbound.protection.outlook.com [52.101.57.50])
 by mails.dpdk.org (Postfix) with ESMTP id DD2E040150
 for <dev@dpdk.org>; Mon, 22 Jun 2026 09:54:52 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TzntEifGHuIBkST3SHEmsffJJ8xzU1AqFRxsPKB59IS4UemzD4AGolA5uzmBgrpiQdrF2s7GcoQVInmZ44bTxGlppVaCDaGe1oq/SfRttRFLnHnRTiPlwFAFBWCLpR4aEa6ZhVALr1YSJzWQVwPgmjcf3YMKpXhFGsJ2Jupg9zTHmVf15ll8xDS2hzZgRNsjrVjInNRtV5QenOMlgudTFRX080GqGfB15TgMSKB1xhARweN0RBWITyjdWlI4s7NeQlpkcpnDIR6WCgfx/w2u7UEJjLwyeZqBugr4KROSDU5iSpNcs4VfBJ2DOELrmIuZkSzI+KSUCEDsDThCX6xXKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qlacIX2HJ/zoYuhW5Sgb5wFMy5Pt5B+NqbvcbFV6gQc=;
 b=Q60GmEafnGZW0LdgOb0qTfo8YP1fkXb6Il23L9L5Sd87FJc+zrr4vlCIR9ZN0M5jq2tYf+5Uec41ojRqy7g3JnsJPdni3Gs1MplLBvNT8nvq3BaG4e8ME7UKDnErsSGZOIEm7gllTezxXvWrZZo1PGmu8JtD/poOsiLrLdKyu7bORmdN+OMa02iTHPMPYsRJ5eismXXqK2rzdKTmPlQystvTKD9AC2eVcpF40AW+k4j3+ELkRn6Ye6DJA8dZ8P6AqjivLf4u4EUTrdh8RnwIsQlTRfGr4YNTQgeITopl737aAdB0y6+HzrA+3gUerA3XHWFZ+AguWEuZ0ElADeVk3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qlacIX2HJ/zoYuhW5Sgb5wFMy5Pt5B+NqbvcbFV6gQc=;
 b=i67aU/A5/+iz0xRYl3J4gzjseXO8reBpXpAQXTz12oVKANZek4IkXaLP47+yrPBQti7cbm0WmH6ZrHt6HPu9mooy7S4Mqi+3tmurLEEMTt8mTT4BMmYHxU2wbIqSPChe6SRHcX287b3kU9DhSkdMncRZZbX9FywpSJuNIx6OAtEx0RtIasRJpuX1Ybp/EOtgtufrCmCl8Ne19b2GKB5P40K6FFh9aBSLJR41ClET8PzbKFYl2WtU0QJadJXNVSd4BsyUe1d4s7U09BhZuWBTUBJ6un4sAkqo2oxRyl8PI4vpzY6UZWxguD2bgJ8ZZnSNhuyGz4Ofkq3R7cf3+IShGA==
Received: from SJ0PR05CA0096.namprd05.prod.outlook.com (2603:10b6:a03:334::11)
 by CH2PR12MB4168.namprd12.prod.outlook.com (2603:10b6:610:a8::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.20; Mon, 22 Jun
 2026 07:54:43 +0000
Received: from SJ5PEPF000001C9.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::26) by SJ0PR05CA0096.outlook.office365.com
 (2603:10b6:a03:334::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.11 via Frontend Transport; Mon,
 22 Jun 2026 07:54:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SJ5PEPF000001C9.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Mon, 22 Jun 2026 07:54:25 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 22 Jun
 2026 00:54:17 -0700
Received: from drhqmail201.nvidia.com (10.126.190.180) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 22 Jun 2026 00:54:16 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.180)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 22 Jun 2026 00:54:14 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v3] drivers: update relaxed ordering policy for mlx5 mkeys
Date: Mon, 22 Jun 2026 10:54:10 +0300
Message-ID: <20260622075410.38103-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20260616122355.39114-1-mkashani@nvidia.com>
References: <20260616122355.39114-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C9:EE_|CH2PR12MB4168:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f07728f-9198-4e7f-684c-08ded0337aa8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|6133799003|22082099003|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: obOpfArMmTxp9eQNhryQN/Gi9pFgQSgtLd/LU+iDX2WgrX6qCRJW6IkOd5zkKvXOKLlFqcCFmACaz+nuCsCTJBDkKX5u23A4peQoGf+9E9I4OHZTfEcYM23GET5vpRXAE8MTYZ3EQeronVAdqlehY4RhHKD1xyn+fI8y5sCuVKUeqIebp6168ZcecZFDBHi2klM6TsbUY7SMfXx/fiKw93xMAyh07JZFGv0OvU7+wKU0WLuGgSbpKNuG+jAsEWLcoGubiaM6UFj1fkzRrg7d+ygolp5YnsE+46RZCQYK103Zl0x/wvoRSPUyyEzYcOSFvA3ZoSQs7nE2thAPycKpFrcxxtW90ibmMgGQDBl10oqzUC8J/FvgpACq6wHolymj3y2phaf+OcPn0RCIb/++Hw6dEIgj8FcsGOj5YyBLgctgx4mbRCvbS82w7YLQEeyRuNPP/upilqLcgH3PqbGd+PZX8KCm92wjAcbbMCBZKrAYgrc8eOP4Mv9ooQJCGTnAoBCDRjuWiCBIWTkwBuK1ud6Be5v6EklxVfXB0IZtqB+Eb2TW+jNa2J9hPn7Lyc3c6uwH00yv9iVtrbJcX69qpkgQtt9W2f3KQTHTjeQmvWl0gSB6P24c2GAMRq/cJY9OyWp+w+vbMVnebRW4yEaFB3juolY6nGbTg/F01+DXzzurgISeN8SBiZ50FI3elQwS5ouKDy1f2ubIwMaPV7jeHg==
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(6133799003)(22082099003)(18002099003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: DlhOk48S4PqtOQf6uX6hsT8YVBG0ch4pq++JjFEkaY+ws4XLWnBebxXhMYdNv2AteY05HLOsZjDWpv6oAlZvdXU2Lerybfd0D/tm5IO6k2RjWsg745kx+UfjF2qZL+Abe1n+dSebzLHEZzeGz8b/NhsK7GgaADhD1tlFhedysVJZXgAjnHdzxBrXR9+AqnCwhduU3v38hcwC6xpeOOTmeH9QPshsLC6rggPvdFOU8uHr5J08tNabCrEvb+TOvz+6RoyWz9oO2D+5wUHQmcpU/geGumzuubkskXeoWTEDDUxghBxeYsRWDFsFA3+QFwyRFpRHdCdblCepFWTx9yd51oc/NLOiTtbB7ERxFXiEzwkYHbJEOyRJIjPoOB5d0TZIFNGRgPOv/rJfN5S20FL350d80Do3X3oC3T8RoLEOOK4eGIfsGyOrbNUtvhItfYTF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jun 2026 07:54:25.2736 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f07728f-9198-4e7f-684c-08ded0337aa8
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4168
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

New adapters expose additional ordering capabilities.
Query the new caps and apply them when creating DevX mkeys via
mlx5_devx_mkey_attr_set_ordering(), which sets PCI relaxed ordering
and RAW=RO when relaxed order is supported.
Use this helper on Windows (still gated by Haswell/Broadwell) and for
Linux wrapped mkeys and crypto/regex/vdpa indirect mkeys when
relaxed order only flag is set.
Linux wrapped mkeys continue to use the legacy Haswell/Broadwell rule for
IBV_ACCESS_RELAXED_ORDERING on the verbs MR.
Upcoming FW will requires setting the correct ordering attributes,
otherwise it fails to create the memory key.

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/common/mlx5/linux/mlx5_common_os.c   | 10 +++++++
 drivers/common/mlx5/mlx5_devx_cmds.c         | 31 ++++++++++++++++++++
 drivers/common/mlx5/mlx5_devx_cmds.h         |  9 ++++++
 drivers/common/mlx5/mlx5_prm.h               | 18 ++++++++++--
 drivers/common/mlx5/windows/mlx5_common_os.c |  8 ++---
 drivers/crypto/mlx5/mlx5_crypto.c            |  4 +++
 drivers/regex/mlx5/mlx5_regex_fastpath.c     |  5 ++++
 drivers/regex/mlx5/mlx5_rxp.c                |  4 +++
 drivers/vdpa/mlx5/mlx5_vdpa_mem.c            |  4 +++
 9 files changed, 85 insertions(+), 8 deletions(-)

diff --git a/drivers/common/mlx5/linux/mlx5_common_os.c b/drivers/common/mlx5/linux/mlx5_common_os.c
index e3db6c41245..3e9cd86062f 100644
--- a/drivers/common/mlx5/linux/mlx5_common_os.c
+++ b/drivers/common/mlx5/linux/mlx5_common_os.c
@@ -997,6 +997,7 @@ int
 mlx5_os_wrapped_mkey_create(void *ctx, void *pd, uint32_t pdn, void *addr,
 			    size_t length, struct mlx5_pmd_wrapped_mr *pmd_mr)
 {
+	struct mlx5_hca_attr hca_attr = { 0 };
 	struct mlx5_klm klm = {
 		.byte_count = length,
 		.address = (uintptr_t)addr,
@@ -1007,6 +1008,7 @@ mlx5_os_wrapped_mkey_create(void *ctx, void *pd, uint32_t pdn, void *addr,
 		.klm_num = 1,
 	};
 	struct mlx5_devx_obj *mkey;
+	int ret;
 	struct ibv_mr *ibv_mr = mlx5_glue->reg_mr(pd, addr, length,
 						  IBV_ACCESS_LOCAL_WRITE |
 						  (mlx5_haswell_broadwell_cpu ? 0 :
@@ -1019,6 +1021,14 @@ mlx5_os_wrapped_mkey_create(void *ctx, void *pd, uint32_t pdn, void *addr,
 	klm.mkey = ibv_mr->lkey;
 	mkey_attr.addr = (uintptr_t)addr;
 	mkey_attr.size = length;
+	ret = mlx5_devx_cmd_query_hca_attr(ctx, &hca_attr);
+	if (ret != 0) {
+		claim_zero(mlx5_glue->dereg_mr(ibv_mr));
+		return ret;
+	}
+	/* Apply MKC ordering when FW requires relaxed-order-only mode. */
+	if (hca_attr.mkc_order_write_after_write_ro_only)
+		mlx5_devx_mkey_attr_set_ordering(&mkey_attr, &hca_attr);
 	mkey = mlx5_devx_cmd_mkey_create(ctx, &mkey_attr);
 	if (!mkey) {
 		claim_zero(mlx5_glue->dereg_mr(ibv_mr));
diff --git a/drivers/common/mlx5/mlx5_devx_cmds.c b/drivers/common/mlx5/mlx5_devx_cmds.c
index c4ac2aaceed..140b057ab47 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.c
+++ b/drivers/common/mlx5/mlx5_devx_cmds.c
@@ -331,6 +331,29 @@ mlx5_devx_cmd_flow_counter_query(struct mlx5_devx_obj *dcs,
 	return 0;
 }
 
+/**
+ * Apply PCI relaxed-ordering and read-after-write ordering to mkey attributes.
+ *
+ * @param[in, out] mkey_attr
+ *   Mkey attributes to update.
+ * @param[in] hca_attr
+ *   HCA capabilities from mlx5_devx_cmd_query_hca_attr().
+ */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_devx_mkey_attr_set_ordering)
+void
+mlx5_devx_mkey_attr_set_ordering(struct mlx5_devx_mkey_attr *mkey_attr,
+				 const struct mlx5_hca_attr *hca_attr)
+{
+	if (!mkey_attr || !hca_attr)
+		return;
+
+	mkey_attr->relaxed_ordering_write = hca_attr->relaxed_ordering_write;
+	mkey_attr->relaxed_ordering_read =
+		hca_attr->relaxed_ordering_read || hca_attr->pci_relaxed_ordered_read;
+	if (hca_attr->mkc_order_read_after_write)
+		mkey_attr->read_after_write_ordering = MLX5_MKC_RAW_ORDERING_RO;
+}
+
 /**
  * Create a new mkey.
  *
@@ -417,6 +440,8 @@ mlx5_devx_cmd_mkey_create(void *ctx,
 	MLX5_SET(mkc, mkc, relaxed_ordering_write,
 		 attr->relaxed_ordering_write);
 	MLX5_SET(mkc, mkc, relaxed_ordering_read, attr->relaxed_ordering_read);
+	MLX5_SET(mkc, mkc, order_read_after_write,
+		 attr->read_after_write_ordering);
 	MLX5_SET64(mkc, mkc, start_addr, attr->addr);
 	MLX5_SET64(mkc, mkc, len, attr->size);
 	MLX5_SET(mkc, mkc, crypto_en, attr->crypto_en);
@@ -1003,6 +1028,12 @@ mlx5_devx_cmd_query_hca_attr(void *ctx,
 						relaxed_ordering_write);
 	attr->relaxed_ordering_read = MLX5_GET(cmd_hca_cap, hcattr,
 					       relaxed_ordering_read);
+	attr->pci_relaxed_ordered_read = MLX5_GET(cmd_hca_cap, hcattr,
+						  pci_relaxed_ordered_read);
+	attr->mkc_order_read_after_write = MLX5_GET(cmd_hca_cap, hcattr,
+						    mkc_order_read_after_write);
+	attr->mkc_order_write_after_write_ro_only = MLX5_GET(cmd_hca_cap, hcattr,
+							     mkc_order_write_after_write_ro_only);
 	attr->access_register_user = MLX5_GET(cmd_hca_cap, hcattr,
 					      access_register_user);
 	attr->eth_net_offloads = MLX5_GET(cmd_hca_cap, hcattr,
diff --git a/drivers/common/mlx5/mlx5_devx_cmds.h b/drivers/common/mlx5/mlx5_devx_cmds.h
index 82d949972bb..90beb2e9e6c 100644
--- a/drivers/common/mlx5/mlx5_devx_cmds.h
+++ b/drivers/common/mlx5/mlx5_devx_cmds.h
@@ -34,6 +34,7 @@ struct mlx5_devx_mkey_attr {
 	uint32_t pg_access:1;
 	uint32_t relaxed_ordering_write:1;
 	uint32_t relaxed_ordering_read:1;
+	uint32_t read_after_write_ordering:2;
 	uint32_t umr_en:1;
 	uint32_t crypto_en:2;
 	uint32_t set_remote_rw:1;
@@ -237,6 +238,9 @@ struct mlx5_hca_attr {
 	uint32_t vhca_id:16;
 	uint32_t relaxed_ordering_write:1;
 	uint32_t relaxed_ordering_read:1;
+	uint32_t pci_relaxed_ordered_read:1;
+	uint32_t mkc_order_read_after_write:1;
+	uint32_t mkc_order_write_after_write_ro_only:1;
 	uint32_t access_register_user:1;
 	uint32_t wqe_index_ignore:1;
 	uint32_t cross_channel:1;
@@ -748,6 +752,11 @@ int mlx5_devx_cmd_query_hca_attr(void *ctx,
 __rte_internal
 struct mlx5_devx_obj *mlx5_devx_cmd_mkey_create(void *ctx,
 					      struct mlx5_devx_mkey_attr *attr);
+
+__rte_internal
+void
+mlx5_devx_mkey_attr_set_ordering(struct mlx5_devx_mkey_attr *mkey_attr,
+				 const struct mlx5_hca_attr *hca_attr);
 __rte_internal
 int mlx5_devx_get_out_command_status(void *out);
 __rte_internal
diff --git a/drivers/common/mlx5/mlx5_prm.h b/drivers/common/mlx5/mlx5_prm.h
index 3bb072a7fec..c2810194f8e 100644
--- a/drivers/common/mlx5/mlx5_prm.h
+++ b/drivers/common/mlx5/mlx5_prm.h
@@ -1463,7 +1463,9 @@ struct mlx5_ifc_mkc_bits {
 	u8 bsf_octword_size[0x20];
 	u8 reserved_at_120[0x80];
 	u8 translations_octword_size[0x20];
-	u8 reserved_at_1c0[0x19];
+	u8 reserved_at_1c0[0x16];
+	u8 order_read_after_write[0x2];
+	u8 reserved_at_1d8[0x1];
 	u8 relaxed_ordering_read[0x1];
 	u8 reserved_at_1da[0x1];
 	u8 log_page_size[0x5];
@@ -1478,6 +1480,13 @@ enum {
 	MLX5_MKEY_CRYPTO_ENABLED = 0x1,
 };
 
+/* MKC read_after_write_ordering field (2-bit, dword 0x38 bits 9:8). */
+enum mlx5_mkc_raw_ordering {
+	MLX5_MKC_RAW_ORDERING_SO = 0x0,
+	MLX5_MKC_RAW_ORDERING_SAO = 0x1,
+	MLX5_MKC_RAW_ORDERING_RO = 0x2,
+};
+
 struct mlx5_ifc_create_mkey_out_bits {
 	u8 status[0x8];
 	u8 reserved_at_8[0x18];
@@ -1827,7 +1836,8 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8 log_max_mcg[0x8];
 	u8 reserved_at_320[0x3];
 	u8 log_max_transport_domain[0x5];
-	u8 reserved_at_328[0x3];
+	u8 reserved_at_328[0x2];
+	u8 pci_relaxed_ordered_read[0x1];
 	u8 log_max_pd[0x5];
 	u8 reserved_at_330[0xb];
 	u8 log_max_xrcd[0x5];
@@ -1860,7 +1870,9 @@ struct mlx5_ifc_cmd_hca_cap_bits {
 	u8 ext_stride_num_range[0x1];
 	u8 reserved_at_3a1[0x2];
 	u8 log_max_stride_sz_rq[0x5];
-	u8 reserved_at_3a8[0x3];
+	u8 mkc_order_read_after_write[0x1];
+	u8 mkc_order_write_after_write_ro_only[0x1];
+	u8 reserved_at_3aa[0x1];
 	u8 log_min_stride_sz_rq[0x5];
 	u8 reserved_at_3b0[0x3];
 	u8 log_max_stride_sz_sq[0x5];
diff --git a/drivers/common/mlx5/windows/mlx5_common_os.c b/drivers/common/mlx5/windows/mlx5_common_os.c
index c790c9a4aeb..bdafb95df98 100644
--- a/drivers/common/mlx5/windows/mlx5_common_os.c
+++ b/drivers/common/mlx5/windows/mlx5_common_os.c
@@ -384,7 +384,7 @@ mlx5_os_reg_mr(void *pd,
 {
 	struct mlx5_devx_mkey_attr mkey_attr;
 	struct mlx5_pd *mlx5_pd = (struct mlx5_pd *)pd;
-	struct mlx5_hca_attr attr;
+	struct mlx5_hca_attr attr = { 0 };
 	struct mlx5_devx_obj *mkey;
 	void *obj;
 
@@ -403,10 +403,8 @@ mlx5_os_reg_mr(void *pd,
 	mkey_attr.size = length;
 	mkey_attr.umem_id = ((struct mlx5_devx_umem *)(obj))->umem_id;
 	mkey_attr.pd = mlx5_pd->pdn;
-	if (!mlx5_haswell_broadwell_cpu) {
-		mkey_attr.relaxed_ordering_write = attr.relaxed_ordering_write;
-		mkey_attr.relaxed_ordering_read = attr.relaxed_ordering_read;
-	}
+	if (!mlx5_haswell_broadwell_cpu)
+		mlx5_devx_mkey_attr_set_ordering(&mkey_attr, &attr);
 	mkey = mlx5_devx_cmd_mkey_create(mlx5_pd->devx_ctx, &mkey_attr);
 	if (!mkey) {
 		claim_zero(mlx5_os_umem_dereg(obj));
diff --git a/drivers/crypto/mlx5/mlx5_crypto.c b/drivers/crypto/mlx5/mlx5_crypto.c
index dd0aabb6d75..448dd0c5a4e 100644
--- a/drivers/crypto/mlx5/mlx5_crypto.c
+++ b/drivers/crypto/mlx5/mlx5_crypto.c
@@ -97,7 +97,11 @@ mlx5_crypto_indirect_mkeys_prepare(struct mlx5_crypto_priv *priv,
 				   mlx5_crypto_mkey_update_t update_cb)
 {
 	uint32_t i;
+	struct mlx5_hca_attr *hca_attr = &priv->cdev->config.hca_attr;
 
+	/* If only relaxed order is allowed. */
+	if (hca_attr->mkc_order_write_after_write_ro_only)
+		mlx5_devx_mkey_attr_set_ordering(attr, hca_attr);
 	for (i = 0; i < qp->entries_n; i++) {
 		attr->klm_array = update_cb(priv, qp, i);
 		qp->mkey[i] = mlx5_devx_cmd_mkey_create(priv->cdev->ctx, attr);
diff --git a/drivers/regex/mlx5/mlx5_regex_fastpath.c b/drivers/regex/mlx5/mlx5_regex_fastpath.c
index 3207bcbc603..55f7411593a 100644
--- a/drivers/regex/mlx5/mlx5_regex_fastpath.c
+++ b/drivers/regex/mlx5/mlx5_regex_fastpath.c
@@ -755,9 +755,14 @@ mlx5_regexdev_setup_fastpath(struct mlx5_regex_priv *priv, uint32_t qp_id)
 	setup_qps(priv, qp);
 
 	if (priv->has_umr) {
+		struct mlx5_hca_attr *hca_attr = &priv->cdev->config.hca_attr;
+
 #ifdef HAVE_IBV_FLOW_DV_SUPPORT
 		attr.pd = priv->cdev->pdn;
 #endif
+		/* If only relaxed order is allowed. */
+		if (hca_attr->mkc_order_write_after_write_ro_only)
+			mlx5_devx_mkey_attr_set_ordering(&attr, hca_attr);
 		for (i = 0; i < qp->nb_desc; i++) {
 			attr.klm_num = MLX5_REGEX_MAX_KLM_NUM;
 			attr.klm_array = qp->jobs[i].imkey_array;
diff --git a/drivers/regex/mlx5/mlx5_rxp.c b/drivers/regex/mlx5/mlx5_rxp.c
index dda4a7fdb0b..b865c08b53c 100644
--- a/drivers/regex/mlx5/mlx5_rxp.c
+++ b/drivers/regex/mlx5/mlx5_rxp.c
@@ -54,6 +54,7 @@ rxp_create_mkey(struct mlx5_regex_priv *priv, void *ptr, size_t size,
 	uint32_t access, struct mlx5_regex_mkey *mkey)
 {
 	struct mlx5_devx_mkey_attr mkey_attr;
+	struct mlx5_hca_attr *hca_attr = &priv->cdev->config.hca_attr;
 
 	/* Register the memory. */
 	mkey->umem = mlx5_glue->devx_umem_reg(priv->cdev->ctx, ptr, size, access);
@@ -72,6 +73,9 @@ rxp_create_mkey(struct mlx5_regex_priv *priv, void *ptr, size_t size,
 #ifdef HAVE_IBV_FLOW_DV_SUPPORT
 	mkey_attr.pd = priv->cdev->pdn;
 #endif
+	/* If only relaxed order is allowed. */
+	if (hca_attr->mkc_order_write_after_write_ro_only)
+		mlx5_devx_mkey_attr_set_ordering(&mkey_attr, hca_attr);
 	mkey->mkey = mlx5_devx_cmd_mkey_create(priv->cdev->ctx, &mkey_attr);
 	if (!mkey->mkey) {
 		DRV_LOG(ERR, "Failed to create direct mkey!");
diff --git a/drivers/vdpa/mlx5/mlx5_vdpa_mem.c b/drivers/vdpa/mlx5/mlx5_vdpa_mem.c
index 4dfe800b8fc..8c9d169d2a8 100644
--- a/drivers/vdpa/mlx5/mlx5_vdpa_mem.c
+++ b/drivers/vdpa/mlx5/mlx5_vdpa_mem.c
@@ -179,6 +179,7 @@ static int
 mlx5_vdpa_create_indirect_mkey(struct mlx5_vdpa_priv *priv)
 {
 	struct mlx5_devx_mkey_attr mkey_attr;
+	struct mlx5_hca_attr *hca_attr = &priv->cdev->config.hca_attr;
 	struct mlx5_vdpa_query_mr *mrs =
 		(struct mlx5_vdpa_query_mr *)priv->mrs;
 	struct mlx5_vdpa_query_mr *entry;
@@ -242,6 +243,9 @@ mlx5_vdpa_create_indirect_mkey(struct mlx5_vdpa_priv *priv)
 	mkey_attr.pg_access = 0;
 	mkey_attr.klm_array = klm_array;
 	mkey_attr.klm_num = klm_index;
+	/* If only relaxed order is allowed. */
+	if (hca_attr->mkc_order_write_after_write_ro_only)
+		mlx5_devx_mkey_attr_set_ordering(&mkey_attr, hca_attr);
 	entry = &mrs[mem->nregions];
 	entry->mkey = mlx5_devx_cmd_mkey_create(priv->cdev->ctx, &mkey_attr);
 	if (!entry->mkey) {
-- 
2.21.0

