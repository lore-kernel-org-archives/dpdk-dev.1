Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF834CD98DA
	for <dpdk-dev@archiver.kernel.org>; Tue, 16 Jun 2026 12:24:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EFEED4060B;
	Tue, 16 Jun 2026 14:24:20 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010019.outbound.protection.outlook.com [52.101.56.19])
 by mails.dpdk.org (Postfix) with ESMTP id DE44240289
 for <dev@dpdk.org>; Tue, 16 Jun 2026 14:24:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OWihbvraHh2uHoYeoe7+Sn6B5CVZkeoXov7+HLoyaGFNDekgtAMRRCxyW8OnJo3AKJ2jV6qE6G5KQyb2R7BRaZQFTail1MKg5Qe6q6LWYXy4IkmfvJRO2JdPm3ApaPN34UnuwubQ946K5qcEy5TYKoMtEX5FEEkVnOAsEIy2ld/oCSscRbZG4F95q+ji3NSz2z8j5GnJvgiG72s9aCtuj836x2nKRP/sKltVz/1LRZHqBAjHO4h7Ec255fkGXcGWDyBXfqPN4a+oMaHTPhcRvpHVvO+ITzyIT83Ra/GlVbNni5s2jEOWzOZ9t56Es3fHN8m8VtUJDNKTJQD0EvWlUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BnOZwExPW/hwf8rEgw/OpuaYA6oL8WD9xjAs1cAL0Ug=;
 b=LHA1i14CjKHVztJB4KvWF+cZOyF/kN3qprJ+IqWjMcR2pvkGn8Bk8wG44QTJlBr4J+2vh+WxiTPzQYehJ64VDSCz2IwcNLdDIFjS2zqyAAtexGIWHbnOzrrtWTzh+loxbuFwalYR5hgu3+R4tCP9U/+thbLywi3xzocJ7tIon7r2HnsrmwuaW7G8AUvGGZ2kriKDfubD7Ef+VE80W1V23HIoiM4rvinzklVP49yVAEjDfX/jtHkoos1bs69Uvj+OFiQ2Ck8+o33DOOTJnIy73CMSmHOL160Qny694KYoKUjeGB/3HeMvQioou7qRJJnu/hB5a6W8sY3QODkRYsDtEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BnOZwExPW/hwf8rEgw/OpuaYA6oL8WD9xjAs1cAL0Ug=;
 b=B4yv76ycfd+S2OG8oN9bEGusBHNnujSwfcLxehnRVvWCDb5IuO8d4pLbiRL/UoY7h/mHz1vKXW1nYXcYq9TtneHvgfEXQeSal1piRvHtV0dYYW/Jva2m6CFByCev+D+scSkAnMr+TRFl5/xR+ntgCzcpjskdpCB9oqQ2++s1Qy2103kT44D6c2mHHO4EJsPyqSO6jt96DX2LHDsX2XQvKvwsa07kOl0vitXiKKQ0fHvZROs//9OdsD+oY2VTa6/7XyTkh48xpAk70iN6P0K0JmRo/9nm3eqfpPBvx+Qm5C5ukrVmjM59RAGiongnKRHVxt6tPoVvoxLwE98dJm4uTQ==
Received: from BN9PR03CA0299.namprd03.prod.outlook.com (2603:10b6:408:f5::34)
 by DS4PR12MB9563.namprd12.prod.outlook.com (2603:10b6:8:282::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.18; Tue, 16 Jun
 2026 12:24:13 +0000
Received: from BN3PEPF0000B072.namprd04.prod.outlook.com
 (2603:10b6:408:f5:cafe::5b) by BN9PR03CA0299.outlook.office365.com
 (2603:10b6:408:f5::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.113.18 via Frontend Transport; Tue,
 16 Jun 2026 12:24:13 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.232)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN3PEPF0000B072.mail.protection.outlook.com (10.167.243.117) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Tue, 16 Jun 2026 12:24:13 +0000
Received: from drhqmail202.nvidia.com (10.126.190.181) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 16 Jun
 2026 05:24:03 -0700
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail202.nvidia.com (10.126.190.181) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 16 Jun 2026 05:24:03 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 16 Jun 2026 05:24:00 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH] drivers: update relaxed ordering policy for mlx5 mkeys
Date: Tue, 16 Jun 2026 15:23:54 +0300
Message-ID: <20260616122355.39114-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B072:EE_|DS4PR12MB9563:EE_
X-MS-Office365-Filtering-Correlation-Id: d1873a1c-e7bc-4363-8a10-08decba22d17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: s1H+E4gJwwf6DsgVI7ZEOZP6+ztfxrk0YY4oPADCk0vv4btzAfPm3G6E+nAmhJjSwNtoNjZNde7iTBevEspcYXzVzJXICFYdQyU2mQjyvQpY/D+sfyQkHFzJmzAMlJPD4Yde6F25o3yPck185/gTiRLJ9vnO2ezCeDPKWTp4KQwrW7CKeL5gRpItX8dvlO+V4lhq57a7l8PfdwK8boAxvcmziix70RnmnEtxdeSfS/smGBhqSbCDt9IshSv7YVWTAM8l4RTTlg5O7T1CyrMbcHblK4NpHGnj8b5fqTEYnNnJOgTWPVse2eABiEqVK8BFZXgW3jXRWlEYc22IEZb1//HH5dxV+sBoE1UVknLR04FrbJTqqkax0rXkMrBjrAKAi90adqWyqgjKAM8s7YFmXden0oYpn3w9ZYOCw+wh19K+NaF1RvDdDZZEq+bjmE7uo4nNT3eB4W3YTUYCKzxWTTtJYoQcJJqyaZfzFYQEbiFWmbOfRhpfH8p2MRXzBkY8OEQwROkRT8clJ0QAJzBtTyEhjGNiJzpKGqWq9XkNE2Tim20rizdJqw18ArI2yT97iQV30eepEYAJmoLDeT5dcXGIM25KSDgXshlJm9AcIsa1mIOtJvlPssz49MMjlTcj0tyEteHWiLn7SBTryZI+vPx6C/znxPZ7BjcEJwRNp4QjX5Wn6oib+FzgrqLt8i9XeJdGbIAei8WsqngJNeV0TpC6CqinKx9hYDsRvUHg68Q=
X-Forefront-Antispam-Report: CIP:216.228.118.232; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(56012099006)(11063799006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IFaBGh33dnG8nPARwL99F7cC7eI/mAoRyskT1YpuvNxz5RxJVEqbgIETOnehWo+0GIkVNNJKtY1JsOPIktuZQjqeqegwWMHqKcoL+pwBX5uoU/seVKDkmwysuA1d0w6uc+83B+wsNOP4eH4D99fr6vx/OFV+6mPeuLrAdp5ThYtEIfMOPd+wG7gGDHxG9qXkFKgrOf0AsXpNlRdlcpNOq/CeCSxqmYuUqYgzX8Ax0VqQDQQUTzCyIdhIG0RFQYoNkuVCTes/fIDjiq7IIKeva78R8Z9N39jgc4JEIIyJSGhWB2xoTqhmnnWhA4LvsHBtTMs+Cxi+FBTFbljwVV/Zzj3xopPLK502Y2SGbgInrWYVjjsbaKVrDvbsXqE5ZqjZOzR8nGHsNq0hRzznwjrPs7/pGTr473QasWE0Mj2Zmk3ca5eetg28p2ap7YMEDVGx
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jun 2026 12:24:13.2896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d1873a1c-e7bc-4363-8a10-08decba22d17
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.232];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B072.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9563
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
 drivers/common/mlx5/linux/mlx5_common_os.c   |  6 ++++
 drivers/common/mlx5/mlx5_devx_cmds.c         | 31 ++++++++++++++++++++
 drivers/common/mlx5/mlx5_devx_cmds.h         |  9 ++++++
 drivers/common/mlx5/mlx5_prm.h               | 18 ++++++++++--
 drivers/common/mlx5/windows/mlx5_common_os.c |  8 ++---
 drivers/crypto/mlx5/mlx5_crypto.c            |  4 +++
 drivers/regex/mlx5/mlx5_regex_fastpath.c     |  5 ++++
 drivers/regex/mlx5/mlx5_rxp.c                |  4 +++
 drivers/vdpa/mlx5/mlx5_vdpa_mem.c            |  4 +++
 9 files changed, 81 insertions(+), 8 deletions(-)

diff --git a/drivers/common/mlx5/linux/mlx5_common_os.c b/drivers/common/mlx5/linux/mlx5_common_os.c
index e3db6c41245..153709390d9 100644
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
@@ -1019,6 +1020,11 @@ mlx5_os_wrapped_mkey_create(void *ctx, void *pd, uint32_t pdn, void *addr,
 	klm.mkey = ibv_mr->lkey;
 	mkey_attr.addr = (uintptr_t)addr;
 	mkey_attr.size = length;
+	if (mlx5_devx_cmd_query_hca_attr(ctx, &hca_attr))
+		return -1;
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

