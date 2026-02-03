Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF075E8B36B
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Feb 2026 22:29:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E1B7340288;
	Tue,  3 Feb 2026 23:29:36 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010044.outbound.protection.outlook.com [52.101.56.44])
 by mails.dpdk.org (Postfix) with ESMTP id 5B5C040649
 for <dev@dpdk.org>; Tue,  3 Feb 2026 23:29:35 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DF+9Ydop0VJMHEpHGUFYte9fpXup/lGXcBEbc8ZzXPmdBSw0DUjAwxKv8zHk0wuzWLcIzfB+ofDl3/nSZ5OVlcImOYVv2gqfRJKtwpqluTHc91ZZLbu6LhMXJrTE8JXUrN58cWVFDyddSrO9vVdOEQdys+wyjzaPrUXHYG05fZPUcidXOYHKtkXdfItDEk0ftguAlonSnAR0xBhvQVl7oHBb+6ixNpbMXTlMo2BUj/o5huA/DnDTSzwzj0q1GBk9GsiAxhwtUB0VUY1Dy608l1vVkOP4IqUgmefXR/fWRTCvtS5YoP4qJ9fqwtbQvLC7fOSbOI1g+ccv2RxYgIft/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rGhOiwe3bsaNCdu8DSl7lA9wc8wV3saf1ALvRCg/iaA=;
 b=OprICt1eqJpPf77njmTMdl98s3p3iFUZ1/MAgs4R6fdv7a2Fi+8meHE/XVTBV6A+5S4qFSysqWDrLZgRepoOAxE0VnIzp64xzGnuQe9j0DdX789CCZf6DFZONZ0z1LUBuOw6N6VRPIW3hx01n6hGK422aw67ckTZ2r/ygYo3humrW7NtkHOTRUTuyDKSVRyCTPvyAQtZoG+DjCSsPMcBrlvHzVvU5P5YKS3s+TPGlLgwdfWTa/VdTulK5m8dKzrS/NMEQpLreSLZ0zz/0EdpYNFPJKF277C2qE0AayKVoKmyH6oN33O8FIBdIMPxzQcsA3HnSs61pumvlLb0ze7PvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rGhOiwe3bsaNCdu8DSl7lA9wc8wV3saf1ALvRCg/iaA=;
 b=CT5OMzkH0Y7xlEEtS/PkhyDx9fc8ogBvwhbaFVRLY/whI9kuUfRUu+RwKuQ0Mva6kKs8E+w4ybgg9qeoYwQlzXa8pI3xac5zgaKIi8D9AqNIeCxJbH3VBh6lXYo3btpAIbCG7CeAxxZNqBigILcFj2ZVP55qbldxzSUOoaBHS3x13K+atvyMybFeNMzRhUcF8Edoco1IwcgCQPmAj49svjri/mMk2xq1XdbSGqTS7ibGKsJE7tB+ZpQFbMdD4x5bWQGmOg8R3uKSyyU4balsNNc2sHsAg6PI2couWwq34v7mUPfSCNSTFRoSjbS0nTz74QE1hK0LI1wt1MJsBw3TUQ==
Received: from PH0PR07CA0114.namprd07.prod.outlook.com (2603:10b6:510:4::29)
 by SA1PR12MB7245.namprd12.prod.outlook.com (2603:10b6:806:2bf::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Tue, 3 Feb
 2026 22:29:26 +0000
Received: from CY4PEPF0000FCC4.namprd03.prod.outlook.com
 (2603:10b6:510:4:cafe::e5) by PH0PR07CA0114.outlook.office365.com
 (2603:10b6:510:4::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.12 via Frontend Transport; Tue,
 3 Feb 2026 22:29:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CY4PEPF0000FCC4.mail.protection.outlook.com (10.167.242.106) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Tue, 3 Feb 2026 22:29:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 3 Feb
 2026 14:29:03 -0800
Received: from aerial-hp-5g-02.nvidia.com (10.126.231.35) by
 rnnvmail201.nvidia.com (10.129.68.8) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Tue, 3 Feb 2026 14:29:02 -0800
From: Cliff Burdick <cburdick@nvidia.com>
To: <dev@dpdk.org>
CC: <anatoly.burakov@intel.com>, Thomas Monjalon <thomas@monjalon.net>,
 Dariusz Sosnowski <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH v2 2/2] common/mlx5: support dmabuf
Date: Tue, 3 Feb 2026 22:26:41 +0000
Message-ID: <20260203222836.2862414-3-cburdick@nvidia.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260203222836.2862414-1-cburdick@nvidia.com>
References: <20260127174429.1504288-1-cburdick@nvidia.com>
 <20260203222836.2862414-1-cburdick@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC4:EE_|SA1PR12MB7245:EE_
X-MS-Office365-Filtering-Correlation-Id: fc978a68-2dc5-466e-b505-08de6373b04c
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dKkjyXfeZNuOw6gIUBmxCgD0G9OZkOVFTC8YHIMmOYkwg+S99PqtG8EQX6Fr?=
 =?us-ascii?Q?1zEOPReWVFmTWG/Qug53to/39Hqyg5S3/x88FiKzpjf1vQ/2u0z4IgXuN/zm?=
 =?us-ascii?Q?FtYuwHjLfw7j1VAvMohI1IcHalTOTMbvGWnmds87VPY3jew3JnctdixyFUhH?=
 =?us-ascii?Q?kM3Wjccw/bf3HGMjE/f6rbg/quSbH0mPMKFw1se+5pgAt2jl3fbhgks6PCLb?=
 =?us-ascii?Q?ISR90LaF/8sKTM5P2L7f5n+ANXao6D/Bh5omu0VjqUdEHV76m5JqdoVuMAAs?=
 =?us-ascii?Q?phiR8qbDLn+/xnSCK7dlQ1Nuxk8GAmE6voCs1124W48chPFu8RpZcSRJZuIY?=
 =?us-ascii?Q?Q2yXBErmFn+itgFtUgEe02tubt0KYwg8pdvpE5qOa23fZlSD6wtb/5u3VlLU?=
 =?us-ascii?Q?H7QqcpWLxzSU6DsCb9jSvntFgYpRWEdtaBoq+nPt5AU/lOIqVtrx9jVt7qHz?=
 =?us-ascii?Q?sKgOeHHnvvmojNOSxhWkXmR+4kgF2isLaGtVt/NRAW6mw+Q+akmA9xOsC0/B?=
 =?us-ascii?Q?C6FtsNPuxQ6gGfLL15R5RphBBYZS85oO4LKkfrUv1Q9U5kOYqPtAmWWWxDcf?=
 =?us-ascii?Q?Mcls/JzHRzpYX6JJ3gQl4wwzDADL86whZhDNW4HH9XhVQJaZVjmyQVGxdNKb?=
 =?us-ascii?Q?LQsJCh1YE4a9s5oRlBZUd3EUkGvkNydbHfPr09pEdWokBiiIQoIwmbNBwf/4?=
 =?us-ascii?Q?6WfCwebM2bBrKIbfShpjcdmGe3BB1Hze3zY3syBLLKt19RJSEczrsG2IzCM8?=
 =?us-ascii?Q?T3GKNJdD3N+cETFtah7H3wRfENVUH2EGz8Du+oG9xS2+02dFfrJNKNGkTkYj?=
 =?us-ascii?Q?IFHPh/C4EbZrv9Ur1rCIG/bbZ1JEKOPMC6Hv/AT3pg5yYN1qwFxYZ63V7oqb?=
 =?us-ascii?Q?QKKtrHVNYm0ddKVIkOn3m6xIz602HGHzZOvLEW7gC6qvM7KNigHh5YoYeKJf?=
 =?us-ascii?Q?j37rWy7y0LmBtXkG7XADVSvvMY/hYTQyTKCn3gUxzRKlqBjJsd7LQN+XaBAn?=
 =?us-ascii?Q?Pp0Yj7gfVgNdjV7gQjrmTsRTpUzpYT+o5VCB3X2JgaXcULIZxXoJfGKp3Ym6?=
 =?us-ascii?Q?APURZeMd2Za3BUB+QXltASc91ASMR1MtmTZNv0Gxx11s4weM+YvbUQ8I367n?=
 =?us-ascii?Q?k/dKFq6rrMqoWhpiwyyYeWa/24dWvyzffEfdLEmYMg8aw4NlA/v2tbGPH/Lm?=
 =?us-ascii?Q?Wkgwn5vRfeZXzkWUOrfXDzfsxUwRDF/oaqb5nUjm7fTRbciFixftbBz8wSYL?=
 =?us-ascii?Q?YpnR9k14oy/pSzZ5oD0LHiQxdWcFkwtQHEVENJZooa02WTMfE4iWUeu6BG1N?=
 =?us-ascii?Q?srSnGavhRf4bfq5Nu1AJt2wMlwFzTJQWgeJYZFEcOVC+p9PWCrXeCxBmZS51?=
 =?us-ascii?Q?LYcC+67Mu7TYIGhumdi209dECeNLtXNPfeGNMw52iCHuDUZrHL6aOOUv5LV6?=
 =?us-ascii?Q?eTOD1hxjpOAPwS3fmjhqF3q36jGhhfbVHQUksDXof4vyY/PdQ6jkYfpoEh7j?=
 =?us-ascii?Q?kb5PzP0+2BaoCebjJq6M2rQyJ17O74lRN1gG277h4NoLfFfPyvk2sBXyLIRL?=
 =?us-ascii?Q?4pEPEQsOd07ijxP6RlEpl+yQZySnlL9/LBOSaq/+zIr2GOsUaaIiSthV5Gbp?=
 =?us-ascii?Q?kMx0wv/iXus6SGAS4PNPJD7PtjrKrx/lnn+Eno7tjzZ6NJwy81Zz6WWqclJX?=
 =?us-ascii?Q?+i0+7w=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 03Xh66J7btSZ6HLXaBwuSFax9BG/g1bvT1KTQt7GBAcuVLSQr/mixzN1/mbSlRKWTr6lBmBop3DNqwYEdM0d1R2Ils1IFKtmpfrhkqqmWAFzbHjwDSje6JjW2rBRowgqnPsPLCp402WzJeRSH6xJ1Me8QElqBkvZd3Vtq1C0kcPuyayFvOxuDPsDvi8njDefFKkf3BDZEofhZ70w1XznYeP1umqjIQTCT75pjyD3RlvVwoig0rPmmsuP0bdPD9gb7QNYzu6Gxlm4ly9tZ1Viuje8ZZ9MaPNojIzM9kHEtZDrzyCqes8oPQ6i1VETzk34JCs0lh+RumUOwwhEyUDoOy1A65+MNurAepfXiE2JZaXxiF5sgZntTzc8xnpRJopyxjvLmGa3d54oh57VZgag3fsKWGXCZBgMzwH2nXEWMYei6gmKbof1Jx1VZk6hxZ/4
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Feb 2026 22:29:26.1988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fc978a68-2dc5-466e-b505-08de6373b04c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7245
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
 .mailmap                                      |   2 +-
 drivers/common/mlx5/linux/meson.build         |   2 +
 drivers/common/mlx5/linux/mlx5_common_verbs.c |  48 +++++++-
 drivers/common/mlx5/linux/mlx5_glue.c         |  19 +++
 drivers/common/mlx5/linux/mlx5_glue.h         |   3 +
 drivers/common/mlx5/mlx5_common.c             |  42 ++++++-
 drivers/common/mlx5/mlx5_common_mr.c          | 113 +++++++++++++++++-
 drivers/common/mlx5/mlx5_common_mr.h          |  17 ++-
 drivers/common/mlx5/windows/mlx5_common_os.c  |   8 +-
 drivers/crypto/mlx5/mlx5_crypto.h             |   1 +
 drivers/crypto/mlx5/mlx5_crypto_gcm.c         |   3 +-
 11 files changed, 249 insertions(+), 9 deletions(-)

diff --git a/.mailmap b/.mailmap
index 4c2b2f921d..0a8a67098f 100644
--- a/.mailmap
+++ b/.mailmap
@@ -291,8 +291,8 @@ Cian Ferriter <cian.ferriter@intel.com>
 Ciara Loftus <ciara.loftus@intel.com>
 Ciara Power <ciara.power@intel.com>
 Claire Murphy <claire.k.murphy@intel.com>
-Cliff Burdick <cburdick@nvidia.com>
 Clemens Famulla-Conrad <cfamullaconrad@suse.com>
+Cliff Burdick <cburdick@nvidia.com>
 Cody Doucette <doucette@bu.edu>
 Congwen Zhang <zhang.congwen@zte.com.cn>
 Conor Fogarty <conor.fogarty@intel.com>
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
index 84a93e7dbd..82cf17ca78 100644
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
@@ -1134,8 +1136,44 @@ mlx5_common_dev_dma_map(struct rte_device *rte_dev, void *addr,
 		rte_errno = ENODEV;
 		return -1;
 	}
-	mr = mlx5_create_mr_ext(dev->pd, (uintptr_t)addr, len,
-				SOCKET_ID_ANY, dev->mr_scache.reg_mr_cb);
+	/* Check if this is dma-buf backed external memory */
+	msl = rte_mem_virt2memseg_list(addr);
+	if (msl != NULL && msl->external) {
+		int dmabuf_fd = rte_memseg_list_get_dmabuf_fd(msl);
+		if (dmabuf_fd >= 0) {
+			uint64_t dmabuf_off;
+			/* Get base offset from memseg list */
+			int ret = rte_memseg_list_get_dmabuf_offset(
+				msl, &dmabuf_off);
+			if (ret < 0) {
+				DRV_LOG(ERR,
+					"Failed to get dma-buf offset for memseg list %p",
+					(void *)msl);
+				return -1;
+			}
+			/* Calculate offset within dma-buf address */
+			dmabuf_off += ((uintptr_t)addr - (uintptr_t)msl->base_va);
+			/* Use dma-buf MR registration */
+			mr = mlx5_create_mr_ext_dmabuf(dev->pd,
+						       (uintptr_t)addr,
+						       len,
+						       SOCKET_ID_ANY,
+						       dmabuf_fd,
+						       dmabuf_off,
+						       dev->mr_scache.reg_dmabuf_mr_cb);
+		} else {
+			/* Use regular MR registration */
+			mr = mlx5_create_mr_ext(dev->pd,
+						(uintptr_t)addr,
+						len,
+						SOCKET_ID_ANY,
+						dev->mr_scache.reg_mr_cb);
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
index 8ed988dec9..8f31eaefe8 100644
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
@@ -1747,9 +1817,48 @@ mlx5_mr_mempool_register_primary(struct mlx5_mr_share_cache *share_cache,
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
+			int dmabuf_fd = rte_memseg_list_get_dmabuf_fd(msl);
+			if (dmabuf_fd >= 0) {
+				uint64_t dmabuf_off;
+				/* Get base offset from memseg list */
+				ret = rte_memseg_list_get_dmabuf_offset(msl, &dmabuf_off);
+				if (ret < 0) {
+					DRV_LOG(ERR, "Failed to get dma-buf offset for memseg list %p",
+						(void *)msl);
+					goto exit;
+				}
+				/* Calculate offset within dma-buf for this specific range */
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

