Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E0CCD98E4
	for <dpdk-dev@archiver.kernel.org>; Wed, 17 Jun 2026 14:27:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A19884027F;
	Wed, 17 Jun 2026 16:27:47 +0200 (CEST)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013036.outbound.protection.outlook.com
 [40.93.201.36]) by mails.dpdk.org (Postfix) with ESMTP id 3877A40276
 for <dev@dpdk.org>; Wed, 17 Jun 2026 16:27:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xHqzgMbXWm/Lor0fRay7qdZhtUXyCKJ+Bi2GALJFZG6qYMVY9KFfVZyLK0K9I1r4j69xYHArQs302Y74r86MqfrGIrIAfB1Xe2O/ET2IOED66tdDwxGbhV+M7X2JdG1waMwYkeN1W7rKccZjxbywmtAZw+HWlLjcKA0yDL2fCzHX1Znm+c9CP6FmrA8ZG07G8vFfNQ/SV7cvNavDhdODFmsu2duQpELSl2JHzhlbbBe3lNyqRMHgkhgSKE+N+a+3bFJd6GL/dA9I6ClHKIx0IP2AJcCna48+BrfA72mIMvX+fvWGrrvdw8+Y5HxZG8eJCRU+zKlU7iKamgmk7ccR8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wnlEvZWd3gVSRO2Q3+3xwZ/5J6lQCvAxxJ1/hq393Cc=;
 b=EXPRN6jFUNd4MfjiJh/huwVdzGkWKGbbKTrPe9WQ8Pp3mENzhmGz3ZzbWukilOT+zB7+GCi1z/1TshSc+8KALCcGspqWXVdER6RfU6XQeSn79eNobNaUeDr4QKMt67w8RCIqDG8AyJBaj9TqRQ7uunIv74PhMMbIZRcCN7v2Lx+uv+0ECi7ewFdA9WQox7e1T6hG3RXYWdxaAc0a7xjf1K4vq/OPiy0o3ot5E2Zt/+6fR2IcUAtrTw0yq+nCF7M37W2Nzy+NkRVTt2TDRZsF21hoP4buMi6KQq2Cix6CIzC/3i4t9TnHqCdAO29KQUyCXK8EyDjb1NCAge7RvB2o8A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wnlEvZWd3gVSRO2Q3+3xwZ/5J6lQCvAxxJ1/hq393Cc=;
 b=PMWIyttOvhPDCmg7uYqhnA4/UIwdG9V9zgA1Qtz+Faxs+JxXz3AbC0P15lHe2eRJzRbvBdw94Cg2405yep5BiWRDprPL2dcxsxv9fZXrL2JSxw4JjJvs0PskBHaKybtUZJtxpx7ea4ZVcVtZxMavNw3bawztPidjycSo/zJ8Le89H2gk2hfr3Hz1yQwqXocQUVU3QuoKNFvu78cq5hUO65GzA7VdFLwayihX35+N+niF3ovAubrnGYkEyf9ietPyD6kxo5/9Uag6OuY2yPk9ZECjjRUv/Ct195T2CnTG7hdVTxwp8E/iEPUgFi53VceX/it4BjcFYGBDLQuR1qCIpA==
Received: from SA0PR13CA0006.namprd13.prod.outlook.com (2603:10b6:806:130::11)
 by SN7PR12MB7129.namprd12.prod.outlook.com (2603:10b6:806:2a1::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.139.11; Wed, 17 Jun
 2026 14:27:40 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:130:cafe::79) by SA0PR13CA0006.outlook.office365.com
 (2603:10b6:806:130::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.12 via Frontend Transport; Wed,
 17 Jun 2026 14:27:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Wed, 17 Jun 2026 14:27:40 +0000
Received: from drhqmail203.nvidia.com (10.126.190.182) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 17 Jun
 2026 07:27:17 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail203.nvidia.com (10.126.190.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Wed, 17 Jun 2026 07:27:16 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 17 Jun 2026 07:27:14 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH v2] drivers: update relaxed ordering policy for mlx5 mkeys
Date: Wed, 17 Jun 2026 17:27:08 +0300
Message-ID: <20260617142709.87761-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20260616122355.39114-1-mkashani@nvidia.com>
References: <20260616122355.39114-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|SN7PR12MB7129:EE_
X-MS-Office365-Filtering-Correlation-Id: 7cae6fd4-2ed0-4f22-2154-08decc7c968f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|11063799006|56012099006|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: PSmgG6xe8u5u/6MOwIFCXoRQc2oyV4jnIxI9jBNZ3fCMs46rNCmIlct9IniRV12ymHVYiO+6hRrO9y0t4+Pd0oIFS1lckqqR1Oo5ZZNMBs5UBzYnydpNbwiIrS4zF5qpe8bBOiYMAHtJTo2nR/VhAdjf3fe3mQzJXahpgSGwvtTf1gVyc+pzA0EiyMBIIdRxF8c9WMHGVmVbxTA17UpLtQWMe3xmxOG/8jz+yE5xhWgEGORqrkLUCl6HFd8q3nU5M/6xrSEkLU4cPf+B3hfeYq5wagptrINQNbd91lZR7FjcCnrBFoch+bzU6FnHQGs6ErmH2h8JdKDslzdH7v0isyW2yEfwED7v0zTeVhvnJTGPqSXfn9+eAb1LJw4Pufgu7w07xEmQhargQq6MTjIGyoBdAc6yU6TTlLQBlceADtVAyLXrHzCsz5Fx7KgQH34iq4kaW4AV1N7Y/o8Cz3UJ7pLes9slrY1NtXuK67lTQdXLM3gYq2o9o+mBcNFwBDzB5UvwLzpw61q7KTXdYav3J17gbQLfNbZs+yaKPuQsgCRr9vCLxsJl2AVZdZpkyoRv4+twajgba/M+hWxFIwgJqTegStLscCVpDFFCDXT8NQDsetvk2Wy6/qt5ryvXdknyFaWP3vO0NTC5GkRep6MmFdXKB5kxUOCVuCusDo2o3z9PN3X8c8K5Rh3LwItUvIOdl/Ltm24NGJ6zsJgPOvladJ4m6lT0GLHga2nP+lQoqsE=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(11063799006)(56012099006)(6133799003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ka4t8+yUSZNcFKhGsxQyz6sIk0dH/7UTX9FtxovlslPnicT2as5x5SUGraMFrH8CAzyMzRzGeCcf2YyzoyjFntu9FRdKbJnzLvZ8P6hDUBk66O0TuwUbvC4A4f1vLOzd8/F8UmPJE9bO6KNa9deJZziuoDWF6MuOi0CBubu3LdclA3pL7nP1Eq8NX0J9nlH+sQ/kW9PiD62NepiElAWyIrLo4d1Ch0kzUz8saEbKNJkvpSHRplry+5/JVFjc7TpVSprHEgibEF8SaZttdutrdkfOyqpCdD1NAIJ4rxLEEUhAIKIQWnDw9vPTuU0SiPvBuGnKL6WCtBl0BufGkyD596MbWW6TqGA1VHr30UVZxugYUjsJWsxyf5Tg6/dfPo9FJpiJuWPOVvAJSoK+6vr/zywNp0if5soDFFrGX2zrYek5X8EFlwKm58s5zWyIv5DP
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jun 2026 14:27:40.5913 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7cae6fd4-2ed0-4f22-2154-08decc7c968f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7129
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
 drivers/common/mlx5/linux/mlx5_common_os.c   |  8 +++++
 drivers/common/mlx5/mlx5_devx_cmds.c         | 31 ++++++++++++++++++++
 drivers/common/mlx5/mlx5_devx_cmds.h         |  9 ++++++
 drivers/common/mlx5/mlx5_prm.h               | 18 ++++++++++--
 drivers/common/mlx5/windows/mlx5_common_os.c |  8 ++---
 drivers/crypto/mlx5/mlx5_crypto.c            |  4 +++
 drivers/regex/mlx5/mlx5_regex_fastpath.c     |  5 ++++
 drivers/regex/mlx5/mlx5_rxp.c                |  4 +++
 drivers/vdpa/mlx5/mlx5_vdpa_mem.c            |  4 +++
 9 files changed, 83 insertions(+), 8 deletions(-)

diff --git a/drivers/common/mlx5/linux/mlx5_common_os.c b/drivers/common/mlx5/linux/mlx5_common_os.c
index e3db6c41245..36b7874ce77 100644
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
@@ -1019,6 +1020,13 @@ mlx5_os_wrapped_mkey_create(void *ctx, void *pd, uint32_t pdn, void *addr,
 	klm.mkey = ibv_mr->lkey;
 	mkey_attr.addr = (uintptr_t)addr;
 	mkey_attr.size = length;
+	if (mlx5_devx_cmd_query_hca_attr(ctx, &hca_attr)) {
+		claim_zero(mlx5_glue->dereg_mr(ibv_mr));
+		return -1;
+	}
+	/* If only relaxed order is allowed. */
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

