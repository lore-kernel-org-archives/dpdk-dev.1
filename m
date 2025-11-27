Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56849CFD2F6
	for <dpdk-dev@archiver.kernel.org>; Thu, 27 Nov 2025 11:29:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 266CB40E0B;
	Thu, 27 Nov 2025 12:29:48 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012041.outbound.protection.outlook.com
 [40.93.195.41]) by mails.dpdk.org (Postfix) with ESMTP id 0913640DF8
 for <dev@dpdk.org>; Thu, 27 Nov 2025 12:29:46 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=luh1yVvZzRZIR6CU2MWGkwF4LUkbfTKT731io5Wcz9SVX5jo3lSUjUYPoFhX+FWQYhHH0+5fX7gPvPYFp0c4pIg0VJIoTTOZIuy8xCRl1lwk5hxKI43RS0M5lF00NEjnYZj9IX1g2xplALdPtr5hIUAI7gRp4cGcju5pao66tiqQ58KNkonxrkoHd+2I4LxYth2P8XUdNH8YHG5mWtPt9L3qWvflLMKuIyKn7Osm7uERGna/qFiDtbPxiYRaUFyrEXKsJl7gdT1axBeYzmwbmipCx2JwnLsICqCxxakjIgCLSzGuidRoRYZ27/bzaAfPkVG+0JBYdHvndxmipgiNvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xQ4r8YcnYnaaBS/C4GBPwEH8NRDUogWPNxMtLot/z4=;
 b=UCqdLFhN3zMTjvjZNtNDzr3Iy+pR2ZSOPuDkdLVIg7VeZPsc4z7TfNFseHrW+9qlG5+LGVQUFLuF6YEK4S/sy2fx0o7pAsjNk4ZOG9Bk7G9Rs9x6zsiE70VC9ATtpxBQWwqqe8oFsuf+K0bqfYGf9DLfhT7/vvTDjsD6bebxHET05/lbkuYjx6R85tpZLdkPGwbdZVPr0gNmmvi/td/Pv/WkrcR+G29a+INbBERNQfEZpVkS/0eaqbCXhQovc+mo0V/MxCaY4xr5N0+o2Bu2Aq9rFLwxsVbCshnkLvOEV0gcWyNv1oArpg+rLr19DLxOFRST5PcIa5cGoGlAnhD5Tw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xQ4r8YcnYnaaBS/C4GBPwEH8NRDUogWPNxMtLot/z4=;
 b=lB/HOtQ3OPQlkL6mF+tZG8p8SxToJX30eM5tjna6Z9qqADY6C2hDSzbfW0NDyWWdX5JC9tCvbRKgqmR4aYSlkBH5NKNzqlZQJSnrnqAmoYfSTm3P7wIzXcHATqvG79zJOTMQULQ8ErF4RYdAX8M4tHRa21OyXZzRomvvk00OSfqQQmluRmIa0yTHjxFcKXvr5XWKtbDzp5hgc9ryRwZsk9mGEdZlK8LanXLKrDFURbY8hXeSgucuWoNKqIDM4M4NNCcbCgrw0U2+iH+HjzOoZLwZP/kDzTFDhvmuYGwykvULKJBvKzjwHuwpq0F9d/kJYE5RhT9uWV7MJU6ZvTIPFg==
Received: from SN7PR04CA0109.namprd04.prod.outlook.com (2603:10b6:806:122::24)
 by DS4PR12MB9635.namprd12.prod.outlook.com (2603:10b6:8:281::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9343.17; Thu, 27 Nov
 2025 11:29:39 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:122:cafe::44) by SN7PR04CA0109.outlook.office365.com
 (2603:10b6:806:122::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9366.12 via Frontend Transport; Thu,
 27 Nov 2025 11:29:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9366.7 via Frontend Transport; Thu, 27 Nov 2025 11:29:38 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 27 Nov
 2025 03:29:29 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 27 Nov
 2025 03:29:29 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 27 Nov 2025 03:29:26 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH 1/2] common/mlx5: add mlx5 prefix to remaining internal
 functions
Date: Thu, 27 Nov 2025 13:29:17 +0200
Message-ID: <20251127112919.53710-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|DS4PR12MB9635:EE_
X-MS-Office365-Filtering-Correlation-Id: 9eebd7a6-35f8-47a5-349c-08de2da84035
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ghtf1ew6soNU3I8Mn1CUQZkYnz1f2yxSZmE22R4jZCimcFD993cPBh70/hUS?=
 =?us-ascii?Q?psFq4CjgtOmDUZgNYCTdh9E1ekqDBOrC2S92KOWueYvQ/vj/5ckjm8gPW+Rx?=
 =?us-ascii?Q?yCTHuRTjQx1PeyREOy7gDxcT/j+vvtCD5hayrpLBYHNSotfvgIo5N+ZOzaHt?=
 =?us-ascii?Q?8jc4fwf6xx3R8nWtqLUW1CIBN2OKzR5eueDE5W9U9mL/JTmQWyHEqHOeXs1D?=
 =?us-ascii?Q?DYdovOvqt2dMl31JW6WQW069H5KaufGhkenqKxGeAAQ2+16T+e/JQfg2kQr4?=
 =?us-ascii?Q?kn9rgXZqcMWubkFWn/sfFTKhy0SRSj6ugr6DUrsp5y9IVxo/H6MGGhaN6SJn?=
 =?us-ascii?Q?19YVaWelYS1qh9ezVuYaD+nlDHiwYpEs9Y2f77b0XJW/FyZrY8PgPJsfRgbU?=
 =?us-ascii?Q?I6O9kJ/EvvQGtNL7TjzF5hBoZWjGgvhpnSM+JBtdg4WQxdvKy40W2H9n2cqL?=
 =?us-ascii?Q?dZwN4O4BGLhvi5/+Oxm5wGgiCTncCHZj06b7JmL4Y0p9yEHqFQA/taVouEjl?=
 =?us-ascii?Q?NWCq5HMMQIjewB4qufR8sLU2IXKIds+ElATwymYLCtu2GZKEKKPw/tPC2eXp?=
 =?us-ascii?Q?tOcd0NJ+b88/z4iO/tXD/2laLUVSGoWEoZvNQXzag2R1BT9JKMJw9ZSr26+C?=
 =?us-ascii?Q?qDCpeFo6EHcz2xPRVDrUsKTz8rUXwCU34B2HSwZEojcxOmeYPGqpRCj11nlF?=
 =?us-ascii?Q?kODq70ntMxR1sYZdtSD4JdAWmX0I5fhhvUtPTlJRvayGVJA7O1cgHv0Qu/sL?=
 =?us-ascii?Q?cG+sMzYQqBdupsR48It3gtUmauQLog/7s320kz3hlV9U9396xyhu8wqaN7C5?=
 =?us-ascii?Q?fdtyBThaLYLBc+BPC6as2jphv4DxHPdLl+XpsE+DuNXH4xPs58QKEIgc/RM5?=
 =?us-ascii?Q?cOuZhk1ags1gMye+yF28C5+x2Rflp0uxBhGseJu69Epd5z4re8FHmpghNCqt?=
 =?us-ascii?Q?3buS5hCtKIEMI9xGzV1esD9oWP3o9R4k5dxzepnLwnywZE+CCVjmk2hdWCWr?=
 =?us-ascii?Q?mtwJesBWz0r3QhUL5LgD2BprlBvlkzUHfF/er8I3ScMy3YCL+e7q2BUQIpuV?=
 =?us-ascii?Q?8cx/g6vQIg/1AYrbAY61wdkP0g5Hk7LY+e+M0Ia6bNq0935WrVAem+uhFXWG?=
 =?us-ascii?Q?mM15E/5tCSAzOXBnyiMqvguZqQf0xoxAbovhFaafGlC2DbHHtGAHpdBdUxDr?=
 =?us-ascii?Q?nfVQUgyRvDCpbH0yX32J0qiy4Ez6r/KQJuIILTRaEDszp9hFQ29W7PF9PXID?=
 =?us-ascii?Q?3a/6BgFzykD05FiZ/eCR+40fjVbwB8r0rv5+6y6SVAXV94wYmX8tKhZmknyL?=
 =?us-ascii?Q?9DI+gofAUEBnNMwFuFTlg/GATYEa+heiVO2gFFub7Fvjdwhl/owjjUAeBB8h?=
 =?us-ascii?Q?82eGlysg+vYR57dw1owPFbGOBqDbDbZJYETAoVHgTSu5ArcxK0HCN7xXGpnC?=
 =?us-ascii?Q?vfuLMiOl5Jr58yt/UKnKh9FycwjEh6XWkmVigIcLouvlv62AasF0W2k+u3UD?=
 =?us-ascii?Q?Vmm/buAP1ruDIk31izTJo9IoRl/Fu0v/FU4Y652guf6dtiU+rHQhkePeOPAK?=
 =?us-ascii?Q?OkPsr+r877Awor0L+tg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Nov 2025 11:29:38.6791 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9eebd7a6-35f8-47a5-349c-08de2da84035
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9635
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

Several internal functions in the mlx5 driver were missing
the mlx5_ prefix, which could lead to symbol conflicts when linking.
This patch adds the proper prefix to all remaining global symbols
in common mlx5.

The following function categories were updated:
haswell_broadwell_cpu->mlx5_haswell_broadwell_cpu

Global variable:
atomic_sn is now static.

Bugzilla ID: 1794
Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/common/mlx5/linux/mlx5_common_os.c    |  2 +-
 drivers/common/mlx5/linux/mlx5_common_verbs.c |  2 +-
 drivers/common/mlx5/linux/mlx5_nl.c           |  2 +-
 drivers/common/mlx5/mlx5_common.c             | 14 +++++++-------
 drivers/common/mlx5/mlx5_common.h             |  2 +-
 drivers/common/mlx5/windows/mlx5_common_os.c  |  2 +-
 6 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/common/mlx5/linux/mlx5_common_os.c b/drivers/common/mlx5/linux/mlx5_common_os.c
index 2867e216188..7d0c9492524 100644
--- a/drivers/common/mlx5/linux/mlx5_common_os.c
+++ b/drivers/common/mlx5/linux/mlx5_common_os.c
@@ -994,7 +994,7 @@ mlx5_os_wrapped_mkey_create(void *ctx, void *pd, uint32_t pdn, void *addr,
 	struct mlx5_devx_obj *mkey;
 	struct ibv_mr *ibv_mr = mlx5_glue->reg_mr(pd, addr, length,
 						  IBV_ACCESS_LOCAL_WRITE |
-						  (haswell_broadwell_cpu ? 0 :
+						  (mlx5_haswell_broadwell_cpu ? 0 :
 						  IBV_ACCESS_RELAXED_ORDERING));
 
 	if (!ibv_mr) {
diff --git a/drivers/common/mlx5/linux/mlx5_common_verbs.c b/drivers/common/mlx5/linux/mlx5_common_verbs.c
index 98260df4707..2322d9d0335 100644
--- a/drivers/common/mlx5/linux/mlx5_common_verbs.c
+++ b/drivers/common/mlx5/linux/mlx5_common_verbs.c
@@ -115,7 +115,7 @@ mlx5_common_verbs_reg_mr(void *pd, void *addr, size_t length,
 
 	ibv_mr = mlx5_glue->reg_mr(pd, addr, length,
 				   IBV_ACCESS_LOCAL_WRITE |
-				   (haswell_broadwell_cpu ? 0 :
+				   (mlx5_haswell_broadwell_cpu ? 0 :
 				   IBV_ACCESS_RELAXED_ORDERING));
 	if (!ibv_mr)
 		return -1;
diff --git a/drivers/common/mlx5/linux/mlx5_nl.c b/drivers/common/mlx5/linux/mlx5_nl.c
index d53543a1132..4fbb67af21d 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.c
+++ b/drivers/common/mlx5/linux/mlx5_nl.c
@@ -176,7 +176,7 @@ struct mlx5_nl_mac_addr {
 	int mac_n; /**< Number of addresses in the array. */
 };
 
-RTE_ATOMIC(uint32_t) atomic_sn;
+static RTE_ATOMIC(uint32_t) atomic_sn;
 
 /* Generate Netlink sequence number. */
 #define MLX5_NL_SN_GENERATE (rte_atomic_fetch_add_explicit(&atomic_sn, 1, \
diff --git a/drivers/common/mlx5/mlx5_common.c b/drivers/common/mlx5/mlx5_common.c
index 84a93e7dbde..f71dbe46378 100644
--- a/drivers/common/mlx5/mlx5_common.c
+++ b/drivers/common/mlx5/mlx5_common.c
@@ -21,8 +21,8 @@
 #include "mlx5_common_defs.h"
 #include "mlx5_common_private.h"
 
-RTE_EXPORT_INTERNAL_SYMBOL(haswell_broadwell_cpu)
-uint8_t haswell_broadwell_cpu;
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_haswell_broadwell_cpu)
+uint8_t mlx5_haswell_broadwell_cpu;
 
 /* Driver type key for new device global syntax. */
 #define MLX5_DRIVER_KEY "driver"
@@ -1273,7 +1273,7 @@ mlx5_common_init(void)
 
 /**
  * This function is responsible of initializing the variable
- *  haswell_broadwell_cpu by checking if the cpu is intel
+ *  mlx5_haswell_broadwell_cpu by checking if the cpu is intel
  *  and reading the data returned from mlx5_cpu_id().
  *  since haswell and broadwell cpus don't have improved performance
  *  when using relaxed ordering we want to check the cpu type before
@@ -1299,7 +1299,7 @@ RTE_INIT_PRIO(mlx5_is_haswell_broadwell_cpu, LOG)
 	vendor = ebx;
 	max_level = eax;
 	if (max_level < 1) {
-		haswell_broadwell_cpu = 0;
+		mlx5_haswell_broadwell_cpu = 0;
 		return;
 	}
 	mlx5_cpu_id(1, &eax, &ebx, &ecx, &edx);
@@ -1314,18 +1314,18 @@ RTE_INIT_PRIO(mlx5_is_haswell_broadwell_cpu, LOG)
 		if (brand_id == 0 && family == 0x6) {
 			for (i = 0; i < RTE_DIM(broadwell_models); i++)
 				if (model == broadwell_models[i]) {
-					haswell_broadwell_cpu = 1;
+					mlx5_haswell_broadwell_cpu = 1;
 					return;
 				}
 			for (i = 0; i < RTE_DIM(haswell_models); i++)
 				if (model == haswell_models[i]) {
-					haswell_broadwell_cpu = 1;
+					mlx5_haswell_broadwell_cpu = 1;
 					return;
 				}
 		}
 	}
 #endif
-	haswell_broadwell_cpu = 0;
+	mlx5_haswell_broadwell_cpu = 0;
 }
 
 /**
diff --git a/drivers/common/mlx5/mlx5_common.h b/drivers/common/mlx5/mlx5_common.h
index 9403385195d..311e862f05a 100644
--- a/drivers/common/mlx5/mlx5_common.h
+++ b/drivers/common/mlx5/mlx5_common.h
@@ -477,7 +477,7 @@ __rte_internal
 void mlx5_translate_port_name(const char *port_name_in,
 			      struct mlx5_switch_info *port_info_out);
 void mlx5_glue_constructor(void);
-extern uint8_t haswell_broadwell_cpu;
+extern uint8_t mlx5_haswell_broadwell_cpu;
 
 __rte_internal
 void mlx5_common_init(void);
diff --git a/drivers/common/mlx5/windows/mlx5_common_os.c b/drivers/common/mlx5/windows/mlx5_common_os.c
index 7fac361460b..16fcc5f9fcc 100644
--- a/drivers/common/mlx5/windows/mlx5_common_os.c
+++ b/drivers/common/mlx5/windows/mlx5_common_os.c
@@ -402,7 +402,7 @@ mlx5_os_reg_mr(void *pd,
 	mkey_attr.size = length;
 	mkey_attr.umem_id = ((struct mlx5_devx_umem *)(obj))->umem_id;
 	mkey_attr.pd = mlx5_pd->pdn;
-	if (!haswell_broadwell_cpu) {
+	if (!mlx5_haswell_broadwell_cpu) {
 		mkey_attr.relaxed_ordering_write = attr.relaxed_ordering_write;
 		mkey_attr.relaxed_ordering_read = attr.relaxed_ordering_read;
 	}
-- 
2.21.0

