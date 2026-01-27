Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DA65D2FEC0
	for <dpdk-dev@archiver.kernel.org>; Tue, 27 Jan 2026 17:45:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B0E08411F3;
	Tue, 27 Jan 2026 18:45:28 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010061.outbound.protection.outlook.com [52.101.201.61])
 by mails.dpdk.org (Postfix) with ESMTP id CFAEA4161A
 for <dev@dpdk.org>; Tue, 27 Jan 2026 18:45:27 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Eb9W4FN+YiNtti3abetXf/8y313KkKQeMrydQlBX/854SICrZ3Gi07aSJ/LeBaQK4VcWDhS0Km38h9fHtZKQ83f5Ojjt6EjgZ/00AONL3gyidpJ27cuqf6EkYOqzQhSdEiQROnbNFiQ8f+Dwr85INPIqYNQyKxqklgh06h+vYJfwUzo8JGp+1NdjzUbfyTk4w0mc0pmaTzSqm7udLjvifOwJ14EwAfuSqA5Pd7kzoBMrII2t+uDn+x+PvTFB1YLNvxFCZMibS0ByEcgTcptTGjlYdHyMjOgn9Z3HbiMPeP52koJL+8+4QrEHqDnRjgJ9hBGD8IUxkuniu54QRPvxPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9wVNYjDc+zQ3XVQrNK7QYfmnn4aGZOtX6m3DtQrE/Q=;
 b=e3e6PfwnhN42WvDtERDHtJXSTzOugdMZFwV0VwdLhgE3KOKtBuRKyCdN8bGHFJrJsXq1kv3c3cTEY4UharGhgxyKOu4bI4cyi5Izi6/JUy8nuK3ZfKOf3ui4pNncbrhr6URan/4CzmJLDoaV9e/XuzYSjCRtffN+wzNHmnuv7+MBJuNGKAHxEZeWIwN+fZGWMMdS7ox5nmEs1r+5UFbXEmZAuBsZqUQNvHEiq2GvdzjTPQHEvWtbhYX4f15Z3dav5OvlJ8vduff6+r1hwVtFyheVmjOpFJc5K6L3SlOnx5FImU5+IgLVaD70U0C+dyfziScfwGTrAVNlEVtRX4oRhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9wVNYjDc+zQ3XVQrNK7QYfmnn4aGZOtX6m3DtQrE/Q=;
 b=amrzxbmJcVbQBwcE8pG6oJtS7uljThqrghZapffISv2Hrv3BTopUCJSLIpBepAvuO5aBs+RVmmwpyv5PsIeJh1In7bzZAS6ZjDRqLFH4rvyNwfrfcJ8dQfvJnCbCn8CfKqR9asdux9pdzb0SlG/iEHK9h1gFdBiaz12xAaqzWPTCczhB2wSCy1pGB+iGA0wcbQXxhH3Fq0KyFJnftCQ+WCa2YKu7NG0NLmIVHfZbBPzyxHRXDBfw0kiH4PCi5+K8kASQx9zVCNgxcY6a/O7hvWxn66YTqzn8TY2DORaAYi7t4lzzy82uc4K3IM9qEXq+N2oMGg9YPfqGegmDS8FZbw==
Received: from DS7P220CA0066.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::17) by
 BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9542.16; Tue, 27 Jan
 2026 17:45:22 +0000
Received: from DS3PEPF0000C37C.namprd04.prod.outlook.com
 (2603:10b6:8:224:cafe::5e) by DS7P220CA0066.outlook.office365.com
 (2603:10b6:8:224::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9564.7 via Frontend Transport; Tue,
 27 Jan 2026 17:45:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS3PEPF0000C37C.mail.protection.outlook.com (10.167.23.6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9564.3 via Frontend Transport; Tue, 27 Jan 2026 17:45:19 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 27 Jan
 2026 09:44:59 -0800
Received: from aerial-hp-5g-02.nvidia.com (10.126.230.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 27 Jan 2026 09:44:58 -0800
From: Cliff Burdick <cburdick@nvidia.com>
To: <dev@dpdk.org>
CC: <anatoly.burakov@intel.com>, Dariusz Sosnowski <dsosnowski@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH 2/2] common/mlx5: support dmabuf
Date: Tue, 27 Jan 2026 17:44:09 +0000
Message-ID: <20260127174429.1504288-3-cburdick@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260127174429.1504288-1-cburdick@nvidia.com>
References: <20260127174429.1504288-1-cburdick@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37C:EE_|BY5PR12MB4130:EE_
X-MS-Office365-Filtering-Correlation-Id: 12c2d799-c68b-4138-53b5-08de5dcbd6d3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?MCdhsWPIubwZxJpo3oQLTsQDx9gx6jtswwUq2UX6whkzTRPzCSs3wvkLsauc?=
 =?us-ascii?Q?fv1nEN5u2TbqT48KHkiBemgZ26IbRGzQoR8PSGyP1Py5O+bcDFcSUnV/EHf+?=
 =?us-ascii?Q?O9wJjnpXXh1h6gz5dqGh3mT0X3DsJtNYyPnfDjLHP84KJioc3z6IGOp9eG0s?=
 =?us-ascii?Q?rkmLie9IN+0vPq4HUDdCz+l5U4WJlcjGAvkfHEWp2HzugDutigX1MGtG6H7p?=
 =?us-ascii?Q?nzDF95g7Y82wot3eD9TEs6d9q9C/s54sx1kPKvKCVEPdT1CwPxQhGt/jAeYs?=
 =?us-ascii?Q?eFdlsBa7rsk7FR20rmYd2deYA2iFrBck7CYBJDFnG2W0/KC6KR64AXRx56Uj?=
 =?us-ascii?Q?Ts9r3XMVnQ6OOyiz7NocG43PEuzm9L4ehwZ7rTR0s+/ToyTfZltowg/XVgMu?=
 =?us-ascii?Q?d1sUO5EaxrwiTanGhDWhH54paYCPzJeZLSAFTgA4/Nh6KwnqFOxajIidIkQ0?=
 =?us-ascii?Q?0mLzug8KhOm4iXmlXk7hDF1Fsd8r0IYW9WRcJHfo4p/gmdKaA13kkWhYN9p2?=
 =?us-ascii?Q?qjSCVYC8LyY4z4unNHO6J870F3XLdqd4ej0Pw1NCKKkLJu+H4p06duSKAhMX?=
 =?us-ascii?Q?77k137i2xXNnWdzbDeuTIFm5xHREP+zmiX3fhN9CBDN00+qcnNGzXLTqKP+l?=
 =?us-ascii?Q?nPx/KgdYZybZ5LXNhVik1RsHgbsrGrtLptUMnJupbFoaoPq68wUNSKzuDp7S?=
 =?us-ascii?Q?7kUyQkVcxO2PnKrb2UnVNfRG/AguvYw5Ag+khJWG/6MLHYdsMzcDpWMC6WhY?=
 =?us-ascii?Q?Zb3MGGf/no98I/4meDidltRfxrTN09X1d8X2b5098XXcX1JD3G5hUh3bCM1R?=
 =?us-ascii?Q?K+aW8wRjIKtJG+z2alsoRRHYM2UWTz7WrxCCogD7gYfpkLqSxu7MuwF9eoH6?=
 =?us-ascii?Q?tjiuFBDGHa//CFrDfopapJES8vWYcZbbOcZGwM+QvCNEHKtA+Ek3zzh+2ht2?=
 =?us-ascii?Q?gfO/fzZHuqsCXc/YrKUVw+TnMxQGOucy78fuUDUIk+r8t+emA+Flsd4RNK+R?=
 =?us-ascii?Q?faY2+IzU7y7kW31slLTpJ9RMhzhgIGWPglu/Yr3IaGD4clGaMbBsvXP+1w2e?=
 =?us-ascii?Q?67qrxdzKMCVTY5NG/d5qmF7VXIhRicftrj9em72tFzDUQrR0Eh+Q2uRc8DjR?=
 =?us-ascii?Q?XM2X9RoAiI3QLZMCdJVDJQ2aGoGAjOVx33aXdkuQ0o6kUDTLbHOdo22vUBQu?=
 =?us-ascii?Q?RKbgAgTwLoE/bwf8pGAb021S3Ky2ltUJZG2UpLSNRYPyO7qWGmFC7vY/cZqU?=
 =?us-ascii?Q?10wwwGf6Cu/74tv/6Z/BncE3DVcJxxup1iLfdYSlm92kdQ11RBJFcq+wTuLh?=
 =?us-ascii?Q?xZ1W2NrIXT9312084J0yRpYpz/5SwyKoDCuaiAyeUuYpHpSWRwCixj/ks4rZ?=
 =?us-ascii?Q?4rasb9arZTk+Wx9QT514xOT/sp+hnxj3722Ye4HiXZWY4wFdljnuF0DwqU2b?=
 =?us-ascii?Q?wGVMBa4rznT46P7Ug0J4ZOBhIPPhaGUKKfIVc0hKIFiv1Yhk/qOhtakzqity?=
 =?us-ascii?Q?sg7hp+xi1JHW+ow6onzPmM7CWqnI6h0bLNGv9Y9OIQdDp2aWmZ8zJ5j7zvwK?=
 =?us-ascii?Q?Rn8r/TqnMUt5TIt7te+BNF5lHUn49xLBx829hr6AOi/pf0S6ZaDgx5CTqXWV?=
 =?us-ascii?Q?EGcfvThC7MNBSQKmTxgrYH8UZNcInA0U+olfYT3vBeShChkwstZmZQ4rvnaV?=
 =?us-ascii?Q?vOaUdA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jan 2026 17:45:19.4383 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12c2d799-c68b-4138-53b5-08de5dcbd6d3
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37C.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4130
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

dmabuf is a modern Linux kernel feature to allow DMA transfers between
two drivers. Common examples of usage are streaming video devices and
NIC to GPU transfers. Prior to dmabuf users had to load proprietary
drivers to expose the DMA mappings. With dmabuf the proprietary drivers
are no longer required.

Signed-off-by: Cliff Burdick <cburdick@nvidia.com>
---
 drivers/common/mlx5/linux/meson.build         |   2 +
 drivers/common/mlx5/linux/mlx5_common_verbs.c |  48 +++++++-
 drivers/common/mlx5/linux/mlx5_glue.c         |  19 +++
 drivers/common/mlx5/linux/mlx5_glue.h         |   3 +
 drivers/common/mlx5/mlx5_common.c             |  28 ++++-
 drivers/common/mlx5/mlx5_common_mr.c          | 108 +++++++++++++++++-
 drivers/common/mlx5/mlx5_common_mr.h          |  17 ++-
 drivers/common/mlx5/windows/mlx5_common_os.c  |   8 +-
 drivers/crypto/mlx5/mlx5_crypto.h             |   1 +
 drivers/crypto/mlx5/mlx5_crypto_gcm.c         |   3 +-
 10 files changed, 229 insertions(+), 8 deletions(-)

diff --git a/drivers/common/mlx5/linux/meson.build b/drivers/common/mlx5/linux/meson.build
index 3767e7a69b..8e83104165 100644
--- a/drivers/common/mlx5/linux/meson.build
+++ b/drivers/common/mlx5/linux/meson.build
@@ -203,6 +203,8 @@ has_sym_args = [
             'mlx5dv_dr_domain_allow_duplicate_rules' ],
         [ 'HAVE_MLX5_IBV_REG_MR_IOVA', 'infiniband/verbs.h',
             'ibv_reg_mr_iova' ],
+        [ 'HAVE_IBV_REG_DMABUF_MR', 'infiniband/verbs.h',
+            'ibv_reg_dmabuf_mr' ],
         [ 'HAVE_MLX5_IBV_IMPORT_CTX_PD_AND_MR', 'infiniband/verbs.h',
             'ibv_import_device' ],
         [ 'HAVE_MLX5DV_DR_ACTION_CREATE_DEST_ROOT_TABLE', 'infiniband/mlx5dv.h',
diff --git a/drivers/common/mlx5/linux/mlx5_common_verbs.c b/drivers/common/mlx5/linux/mlx5_common_verbs.c
index 98260df470..f6d18fd5df 100644
--- a/drivers/common/mlx5/linux/mlx5_common_verbs.c
+++ b/drivers/common/mlx5/linux/mlx5_common_verbs.c
@@ -129,6 +129,47 @@ mlx5_common_verbs_reg_mr(void *pd, void *addr, size_t length,
 	return 0;
 }
 
+/**
+ * Register mr for dma-buf backed memory. Given protection domain pointer,
+ * dma-buf fd, offset and length, register the memory region.
+ *
+ * @param[in] pd
+ *   Pointer to protection domain context.
+ * @param[in] offset
+ *   Offset within the dma-buf.
+ * @param[in] length
+ *   Length of the memory to register.
+ * @param[in] fd
+ *   File descriptor of the dma-buf.
+ * @param[out] pmd_mr
+ *   pmd_mr struct set with lkey, address, length and pointer to mr object
+ *
+ * @return
+ *   0 on successful registration, -1 otherwise
+ */
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_common_verbs_reg_dmabuf_mr)
+int
+mlx5_common_verbs_reg_dmabuf_mr(void *pd, uint64_t offset, size_t length,
+				uint64_t iova, int fd,
+				struct mlx5_pmd_mr *pmd_mr)
+{
+	struct ibv_mr *ibv_mr;
+	ibv_mr = mlx5_glue->reg_dmabuf_mr(pd, offset, length, iova, fd,
+					  IBV_ACCESS_LOCAL_WRITE |
+					  (haswell_broadwell_cpu ? 0 :
+					  IBV_ACCESS_RELAXED_ORDERING));
+	if (!ibv_mr)
+		return -1;
+
+	*pmd_mr = (struct mlx5_pmd_mr){
+		.lkey = ibv_mr->lkey,
+		.addr = ibv_mr->addr,
+		.len = ibv_mr->length,
+		.obj = (void *)ibv_mr,
+	};
+	return 0;
+}
+
 /**
  * Deregister mr. Given the mlx5 pmd MR - deregister the MR
  *
@@ -151,13 +192,18 @@ mlx5_common_verbs_dereg_mr(struct mlx5_pmd_mr *pmd_mr)
  *
  * @param[out] reg_mr_cb
  *   Pointer to reg_mr func
+ * @param[out] reg_dmabuf_mr_cb
+ *   Pointer to reg_dmabuf_mr func
  * @param[out] dereg_mr_cb
  *   Pointer to dereg_mr func
  */
 RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_set_reg_mr_cb)
 void
-mlx5_os_set_reg_mr_cb(mlx5_reg_mr_t *reg_mr_cb, mlx5_dereg_mr_t *dereg_mr_cb)
+mlx5_os_set_reg_mr_cb(mlx5_reg_mr_t *reg_mr_cb,
+		      mlx5_reg_dmabuf_mr_t *reg_dmabuf_mr_cb,
+		      mlx5_dereg_mr_t *dereg_mr_cb)
 {
 	*reg_mr_cb = mlx5_common_verbs_reg_mr;
+	*reg_dmabuf_mr_cb = mlx5_common_verbs_reg_dmabuf_mr;
 	*dereg_mr_cb = mlx5_common_verbs_dereg_mr;
 }
diff --git a/drivers/common/mlx5/linux/mlx5_glue.c b/drivers/common/mlx5/linux/mlx5_glue.c
index a91eaa429d..6fac7f2bcd 100644
--- a/drivers/common/mlx5/linux/mlx5_glue.c
+++ b/drivers/common/mlx5/linux/mlx5_glue.c
@@ -291,6 +291,24 @@ mlx5_glue_reg_mr_iova(struct ibv_pd *pd, void *addr, size_t length,
 #endif
 }
 
+static struct ibv_mr *
+mlx5_glue_reg_dmabuf_mr(struct ibv_pd *pd, uint64_t offset, size_t length,
+			uint64_t iova, int fd, int access)
+{
+#ifdef HAVE_IBV_REG_DMABUF_MR
+	return ibv_reg_dmabuf_mr(pd, offset, length, iova, fd, access);
+#else
+	(void)pd;
+	(void)offset;
+	(void)length;
+	(void)iova;
+	(void)fd;
+	(void)access;
+	errno = ENOTSUP;
+	return NULL;
+#endif
+}
+
 static struct ibv_mr *
 mlx5_glue_alloc_null_mr(struct ibv_pd *pd)
 {
@@ -1619,6 +1637,7 @@ const struct mlx5_glue *mlx5_glue = &(const struct mlx5_glue) {
 	.modify_qp = mlx5_glue_modify_qp,
 	.reg_mr = mlx5_glue_reg_mr,
 	.reg_mr_iova = mlx5_glue_reg_mr_iova,
+	.reg_dmabuf_mr = mlx5_glue_reg_dmabuf_mr,
 	.alloc_null_mr = mlx5_glue_alloc_null_mr,
 	.dereg_mr = mlx5_glue_dereg_mr,
 	.create_counter_set = mlx5_glue_create_counter_set,
diff --git a/drivers/common/mlx5/linux/mlx5_glue.h b/drivers/common/mlx5/linux/mlx5_glue.h
index 81d6b0aaf9..66216d1194 100644
--- a/drivers/common/mlx5/linux/mlx5_glue.h
+++ b/drivers/common/mlx5/linux/mlx5_glue.h
@@ -219,6 +219,9 @@ struct mlx5_glue {
 	struct ibv_mr *(*reg_mr_iova)(struct ibv_pd *pd, void *addr,
 				      size_t length, uint64_t iova,
 				      int access);
+	struct ibv_mr *(*reg_dmabuf_mr)(struct ibv_pd *pd, uint64_t offset,
+					size_t length, uint64_t iova,
+					int fd, int access);
 	struct ibv_mr *(*alloc_null_mr)(struct ibv_pd *pd);
 	int (*dereg_mr)(struct ibv_mr *mr);
 	struct ibv_counter_set *(*create_counter_set)
diff --git a/drivers/common/mlx5/mlx5_common.c b/drivers/common/mlx5/mlx5_common.c
index 84a93e7dbd..0ec59b0122 100644
--- a/drivers/common/mlx5/mlx5_common.c
+++ b/drivers/common/mlx5/mlx5_common.c
@@ -13,6 +13,7 @@
 #include <rte_class.h>
 #include <rte_malloc.h>
 #include <rte_eal_paging.h>
+#include <rte_memory.h>
 
 #include "mlx5_common.h"
 #include "mlx5_common_os.h"
@@ -1125,6 +1126,7 @@ mlx5_common_dev_dma_map(struct rte_device *rte_dev, void *addr,
 	struct mlx5_common_device *dev;
 	struct mlx5_mr_btree *bt;
 	struct mlx5_mr *mr;
+	struct rte_memseg_list *msl;
 
 	dev = to_mlx5_device(rte_dev);
 	if (!dev) {
@@ -1134,8 +1136,30 @@ mlx5_common_dev_dma_map(struct rte_device *rte_dev, void *addr,
 		rte_errno = ENODEV;
 		return -1;
 	}
-	mr = mlx5_create_mr_ext(dev->pd, (uintptr_t)addr, len,
-				SOCKET_ID_ANY, dev->mr_scache.reg_mr_cb);
+	/* Check if this is dma-buf backed external memory */
+	msl = rte_mem_virt2memseg_list(addr);
+	if (msl != NULL && msl->external) {
+		int dmabuf_fd = rte_memseg_list_get_dmabuf_fd_thread_unsafe(msl);
+		if (dmabuf_fd >= 0) {
+			uint64_t dmabuf_off;
+			/* Get base offset from memseg list */
+			rte_memseg_list_get_dmabuf_offset_thread_unsafe(msl, &dmabuf_off);
+			/* Calculate offset within dmabuf for this specific address */
+			dmabuf_off += ((uintptr_t)addr - (uintptr_t)msl->base_va);
+			/* Use dma-buf MR registration */
+			mr = mlx5_create_mr_ext_dmabuf(dev->pd, (uintptr_t)addr, len,
+						SOCKET_ID_ANY, dmabuf_fd, dmabuf_off,
+						dev->mr_scache.reg_dmabuf_mr_cb);
+		} else {
+			/* Use regular MR registration */
+			mr = mlx5_create_mr_ext(dev->pd, (uintptr_t)addr, len,
+						SOCKET_ID_ANY, dev->mr_scache.reg_mr_cb);
+		}
+	} else {
+		/* Use regular MR registration */
+		mr = mlx5_create_mr_ext(dev->pd, (uintptr_t)addr, len,
+					SOCKET_ID_ANY, dev->mr_scache.reg_mr_cb);
+	}
 	if (!mr) {
 		DRV_LOG(WARNING, "Device %s unable to DMA map", rte_dev->name);
 		rte_errno = EINVAL;
diff --git a/drivers/common/mlx5/mlx5_common_mr.c b/drivers/common/mlx5/mlx5_common_mr.c
index 8ed988dec9..18b8a6eaa5 100644
--- a/drivers/common/mlx5/mlx5_common_mr.c
+++ b/drivers/common/mlx5/mlx5_common_mr.c
@@ -8,6 +8,7 @@
 #include <rte_eal_memconfig.h>
 #include <rte_eal_paging.h>
 #include <rte_errno.h>
+#include <rte_memory.h>
 #include <rte_mempool.h>
 #include <rte_malloc.h>
 #include <rte_rwlock.h>
@@ -1141,6 +1142,7 @@ mlx5_mr_create_cache(struct mlx5_mr_share_cache *share_cache, int socket)
 {
 	/* Set the reg_mr and dereg_mr callback functions */
 	mlx5_os_set_reg_mr_cb(&share_cache->reg_mr_cb,
+			      &share_cache->reg_dmabuf_mr_cb,
 			      &share_cache->dereg_mr_cb);
 	rte_rwlock_init(&share_cache->rwlock);
 	rte_rwlock_init(&share_cache->mprwlock);
@@ -1221,6 +1223,74 @@ mlx5_create_mr_ext(void *pd, uintptr_t addr, size_t len, int socket_id,
 	return mr;
 }
 
+/**
+ * Creates a memory region for dma-buf backed external memory.
+ *
+ * @param pd
+ *   Pointer to pd of a device (net, regex, vdpa,...).
+ * @param addr
+ *   Starting virtual address of memory (mmap'd address).
+ * @param len
+ *   Length of memory segment being mapped.
+ * @param socket_id
+ *   Socket to allocate heap memory for the control structures.
+ * @param dmabuf_fd
+ *   File descriptor of the dma-buf.
+ * @param dmabuf_offset
+ *   Offset within the dma-buf.
+ * @param reg_dmabuf_mr_cb
+ *   Callback function for dma-buf MR registration.
+ *
+ * @return
+ *   Pointer to MR structure on success, NULL otherwise.
+ */
+struct mlx5_mr *
+mlx5_create_mr_ext_dmabuf(void *pd, uintptr_t addr, size_t len, int socket_id,
+			  int dmabuf_fd, uint64_t dmabuf_offset,
+			  mlx5_reg_dmabuf_mr_t reg_dmabuf_mr_cb)
+{
+	struct mlx5_mr *mr = NULL;
+
+	if (reg_dmabuf_mr_cb == NULL) {
+		DRV_LOG(WARNING, "dma-buf MR registration not supported");
+		rte_errno = ENOTSUP;
+		return NULL;
+	}
+	mr = mlx5_malloc(MLX5_MEM_RTE | MLX5_MEM_ZERO,
+			 RTE_ALIGN_CEIL(sizeof(*mr), RTE_CACHE_LINE_SIZE),
+			 RTE_CACHE_LINE_SIZE, socket_id);
+	if (mr == NULL)
+		return NULL;
+	if (reg_dmabuf_mr_cb(pd, dmabuf_offset, len, addr, dmabuf_fd,
+			     &mr->pmd_mr) < 0) {
+		DRV_LOG(WARNING,
+			"Fail to create dma-buf MR for address (%p) fd=%d",
+			(void *)addr, dmabuf_fd);
+		mlx5_free(mr);
+		return NULL;
+	}
+	mr->msl = NULL; /* Mark it is external memory. */
+	mr->ms_bmp = NULL;
+	mr->ms_n = 1;
+	mr->ms_bmp_n = 1;
+	/*
+	 * For dma-buf MR, the returned addr may be NULL since there's no VA
+	 * in the registration. Store the user-provided addr for cache lookup.
+	 */
+	if (mr->pmd_mr.addr == NULL)
+		mr->pmd_mr.addr = (void *)addr;
+	if (mr->pmd_mr.len == 0)
+		mr->pmd_mr.len = len;
+	DRV_LOG(DEBUG,
+		"MR CREATED (%p) for dma-buf external memory %p (fd=%d):\n"
+		"  [0x%" PRIxPTR ", 0x%" PRIxPTR "),"
+		" lkey=0x%x base_idx=%u ms_n=%u, ms_bmp_n=%u",
+		(void *)mr, (void *)addr, dmabuf_fd,
+		addr, addr + len, rte_cpu_to_be_32(mr->pmd_mr.lkey),
+		mr->ms_base_idx, mr->ms_n, mr->ms_bmp_n);
+	return mr;
+}
+
 /**
  * Callback for memory free event. Iterate freed memsegs and check whether it
  * belongs to an existing MR. If found, clear the bit from bitmap of MR. As a
@@ -1747,9 +1817,43 @@ mlx5_mr_mempool_register_primary(struct mlx5_mr_share_cache *share_cache,
 		struct mlx5_mempool_mr *mr = &new_mpr->mrs[i];
 		const struct mlx5_range *range = &ranges[i];
 		size_t len = range->end - range->start;
+		struct rte_memseg_list *msl;
+		int reg_result;
+
+		/* Check if this is dma-buf backed external memory */
+		msl = rte_mem_virt2memseg_list((void *)range->start);
+		if (msl != NULL && msl->external &&
+		    share_cache->reg_dmabuf_mr_cb != NULL) {
+			int dmabuf_fd = rte_memseg_list_get_dmabuf_fd_thread_unsafe(msl);
+			if (dmabuf_fd >= 0) {
+				uint64_t dmabuf_off;
+				/* Get base offset from memseg list */
+				rte_memseg_list_get_dmabuf_offset_thread_unsafe(msl, &dmabuf_off);
+				/* Calculate offset within dmabuf for this specific range */
+				dmabuf_off += (range->start - (uintptr_t)msl->base_va);
+				/* Use dma-buf MR registration */
+				reg_result = share_cache->reg_dmabuf_mr_cb(pd,
+					dmabuf_off, len, range->start, dmabuf_fd,
+					&mr->pmd_mr);
+				if (reg_result == 0) {
+					/* For dma-buf MR, set addr if not set by driver */
+					if (mr->pmd_mr.addr == NULL)
+						mr->pmd_mr.addr = (void *)range->start;
+					if (mr->pmd_mr.len == 0)
+						mr->pmd_mr.len = len;
+				}
+			} else {
+				/* Use regular MR registration */
+				reg_result = share_cache->reg_mr_cb(pd,
+					(void *)range->start, len, &mr->pmd_mr);
+			}
+		} else {
+			/* Use regular MR registration */
+			reg_result = share_cache->reg_mr_cb(pd,
+				(void *)range->start, len, &mr->pmd_mr);
+		}
 
-		if (share_cache->reg_mr_cb(pd, (void *)range->start, len,
-		    &mr->pmd_mr) < 0) {
+		if (reg_result < 0) {
 			DRV_LOG(ERR,
 				"Failed to create an MR in PD %p for address range "
 				"[0x%" PRIxPTR ", 0x%" PRIxPTR "] (%zu bytes) for mempool %s",
diff --git a/drivers/common/mlx5/mlx5_common_mr.h b/drivers/common/mlx5/mlx5_common_mr.h
index cf7c685e9b..3b967b1323 100644
--- a/drivers/common/mlx5/mlx5_common_mr.h
+++ b/drivers/common/mlx5/mlx5_common_mr.h
@@ -35,6 +35,9 @@ struct mlx5_pmd_mr {
  */
 typedef int (*mlx5_reg_mr_t)(void *pd, void *addr, size_t length,
 			     struct mlx5_pmd_mr *pmd_mr);
+typedef int (*mlx5_reg_dmabuf_mr_t)(void *pd, uint64_t offset, size_t length,
+				    uint64_t iova, int fd,
+				    struct mlx5_pmd_mr *pmd_mr);
 typedef void (*mlx5_dereg_mr_t)(struct mlx5_pmd_mr *pmd_mr);
 
 /* Memory Region object. */
@@ -87,6 +90,7 @@ struct __rte_packed_begin mlx5_mr_share_cache {
 	struct mlx5_mr_list mr_free_list; /* Freed MR list. */
 	struct mlx5_mempool_reg_list mempool_reg_list; /* Mempool database. */
 	mlx5_reg_mr_t reg_mr_cb; /* Callback to reg_mr func */
+	mlx5_reg_dmabuf_mr_t reg_dmabuf_mr_cb; /* Callback to reg_dmabuf_mr func */
 	mlx5_dereg_mr_t dereg_mr_cb; /* Callback to dereg_mr func */
 } __rte_packed_end;
 
@@ -233,6 +237,10 @@ mlx5_mr_lookup_list(struct mlx5_mr_share_cache *share_cache,
 struct mlx5_mr *
 mlx5_create_mr_ext(void *pd, uintptr_t addr, size_t len, int socket_id,
 		   mlx5_reg_mr_t reg_mr_cb);
+struct mlx5_mr *
+mlx5_create_mr_ext_dmabuf(void *pd, uintptr_t addr, size_t len, int socket_id,
+			  int dmabuf_fd, uint64_t dmabuf_offset,
+			  mlx5_reg_dmabuf_mr_t reg_dmabuf_mr_cb);
 void mlx5_mr_free(struct mlx5_mr *mr, mlx5_dereg_mr_t dereg_mr_cb);
 __rte_internal
 uint32_t
@@ -251,12 +259,19 @@ int
 mlx5_common_verbs_reg_mr(void *pd, void *addr, size_t length,
 			 struct mlx5_pmd_mr *pmd_mr);
 __rte_internal
+int
+mlx5_common_verbs_reg_dmabuf_mr(void *pd, uint64_t offset, size_t length,
+				uint64_t iova, int fd,
+				struct mlx5_pmd_mr *pmd_mr);
+__rte_internal
 void
 mlx5_common_verbs_dereg_mr(struct mlx5_pmd_mr *pmd_mr);
 
 __rte_internal
 void
-mlx5_os_set_reg_mr_cb(mlx5_reg_mr_t *reg_mr_cb, mlx5_dereg_mr_t *dereg_mr_cb);
+mlx5_os_set_reg_mr_cb(mlx5_reg_mr_t *reg_mr_cb,
+		      mlx5_reg_dmabuf_mr_t *reg_dmabuf_mr_cb,
+		      mlx5_dereg_mr_t *dereg_mr_cb);
 
 __rte_internal
 int
diff --git a/drivers/common/mlx5/windows/mlx5_common_os.c b/drivers/common/mlx5/windows/mlx5_common_os.c
index 7fac361460..5e284742ab 100644
--- a/drivers/common/mlx5/windows/mlx5_common_os.c
+++ b/drivers/common/mlx5/windows/mlx5_common_os.c
@@ -17,6 +17,7 @@
 #include "mlx5_common.h"
 #include "mlx5_common_os.h"
 #include "mlx5_malloc.h"
+#include "mlx5_common_mr.h"
 
 /**
  * Initialization routine for run-time dependency on external lib.
@@ -442,15 +443,20 @@ mlx5_os_dereg_mr(struct mlx5_pmd_mr *pmd_mr)
  *
  * @param[out] reg_mr_cb
  *   Pointer to reg_mr func
+ * @param[out] reg_dmabuf_mr_cb
+ *   Pointer to reg_dmabuf_mr func (NULL on Windows - not supported)
  * @param[out] dereg_mr_cb
  *   Pointer to dereg_mr func
  *
  */
 RTE_EXPORT_INTERNAL_SYMBOL(mlx5_os_set_reg_mr_cb)
 void
-mlx5_os_set_reg_mr_cb(mlx5_reg_mr_t *reg_mr_cb, mlx5_dereg_mr_t *dereg_mr_cb)
+mlx5_os_set_reg_mr_cb(mlx5_reg_mr_t *reg_mr_cb,
+		      mlx5_reg_dmabuf_mr_t *reg_dmabuf_mr_cb,
+		      mlx5_dereg_mr_t *dereg_mr_cb)
 {
 	*reg_mr_cb = mlx5_os_reg_mr;
+	*reg_dmabuf_mr_cb = NULL; /* dma-buf not supported on Windows */
 	*dereg_mr_cb = mlx5_os_dereg_mr;
 }
 
diff --git a/drivers/crypto/mlx5/mlx5_crypto.h b/drivers/crypto/mlx5/mlx5_crypto.h
index f9f127e9e6..b2712c9a8d 100644
--- a/drivers/crypto/mlx5/mlx5_crypto.h
+++ b/drivers/crypto/mlx5/mlx5_crypto.h
@@ -41,6 +41,7 @@ struct mlx5_crypto_priv {
 	struct mlx5_common_device *cdev; /* Backend mlx5 device. */
 	struct rte_cryptodev *crypto_dev;
 	mlx5_reg_mr_t reg_mr_cb; /* Callback to reg_mr func */
+	mlx5_reg_dmabuf_mr_t reg_dmabuf_mr_cb; /* Callback to reg_dmabuf_mr func */
 	mlx5_dereg_mr_t dereg_mr_cb; /* Callback to dereg_mr func */
 	struct mlx5_uar uar; /* User Access Region. */
 	uint32_t max_segs_num; /* Maximum supported data segs. */
diff --git a/drivers/crypto/mlx5/mlx5_crypto_gcm.c b/drivers/crypto/mlx5/mlx5_crypto_gcm.c
index 89f32c7722..380689cfeb 100644
--- a/drivers/crypto/mlx5/mlx5_crypto_gcm.c
+++ b/drivers/crypto/mlx5/mlx5_crypto_gcm.c
@@ -1186,7 +1186,8 @@ mlx5_crypto_gcm_init(struct mlx5_crypto_priv *priv)
 
 	/* Override AES-GCM specified ops. */
 	dev_ops->sym_session_configure = mlx5_crypto_sym_gcm_session_configure;
-	mlx5_os_set_reg_mr_cb(&priv->reg_mr_cb, &priv->dereg_mr_cb);
+	mlx5_os_set_reg_mr_cb(&priv->reg_mr_cb,  &priv->reg_dmabuf_mr_cb,
+			&priv->dereg_mr_cb);
 	dev_ops->queue_pair_setup = mlx5_crypto_gcm_qp_setup;
 	dev_ops->queue_pair_release = mlx5_crypto_gcm_qp_release;
 	if (mlx5_crypto_is_ipsec_opt(priv)) {
-- 
2.52.0

