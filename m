Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21AFDEF06E3
	for <dpdk-dev@archiver.kernel.org>; Sun,  8 Feb 2026 14:29:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E157402C6;
	Sun,  8 Feb 2026 15:29:38 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011021.outbound.protection.outlook.com [40.107.208.21])
 by mails.dpdk.org (Postfix) with ESMTP id 0C67B4028C
 for <dev@dpdk.org>; Sun,  8 Feb 2026 15:29:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BrwvCT2fRtjAlVA6gL95SpjQqYcU1tDzFoGmLEql/gOUebUptM+7cRrFX019UBK/I+M8ahbiP6Ffu4nyInvvlS97jhqTLRDlRy8elA72NO7XIPqvjKl9kSyDMvnffHfFwPUeLamgjZO2hLr979J8iojV7SbrAh72Ym1BLz1+6Ua+qnqoYl7v7pVg2qyYYMegSBNyVYXWbGJEkDsqYqVqUMKVk4dnWi0XeEVcXc19Hok8UKFEr/yfTSuO65FsJs+3yRpUtKjg6ztsauIwcCRzF9Auv7yl71pfhetjtPxy2yR5+Cq8jfhxeCjFWO2rOokKfBR7Rhkfm5qMgqdTR81ZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xQ4r8YcnYnaaBS/C4GBPwEH8NRDUogWPNxMtLot/z4=;
 b=U5lWZrmP/VNQsFVPkbdHWA2P4gtA+kJN5tFvMyaIZpy7QfN1dww0vOcioOEENJI+BaKT9pXT3JWtNHXyn0CTRShZpvUHDAYC513NalhoHV9vlWgAPFcxuXMlIFMFEILXRksNs89/YTIcyqVyYNDUP/GyEexqaoqL5fEE5Gp9LhwKqExBhhJdG0mEnJmeH08/VOmqi2xIfMzw2vI6zYHH4espP+Oi5g0nZukvpZ6VMToyVnAzBkuuPkZlFzKG0x64l3yCZ5HWUucm9HC4mM4UqReXrtUcboeaY0MxWdbLxvzUsM4BGbrc12y1WRrT1dfdPsC9LpLJXGD+52RnuqDmYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xQ4r8YcnYnaaBS/C4GBPwEH8NRDUogWPNxMtLot/z4=;
 b=epoJ9y5Lrx0Y0FNHLrZU4KQt3DNSYNmr0okncrIYIj0pbXU14cjw/dlqW323zNztfYF0YU2Du907E0avnZm7a3A2hUpdLRMnlBZkm9wzIpUN0xYhgRu2neOVDZKsz3HwdXQRLgGZnTI+mgbXNzjDEiMbIg86H1PHLLx16b1W2ascqqxaX14g1clj2dIjI2lRy4synfxUuaXr6SGstSvMWXkm4I4HZw8yUehBSkceOHVg9jcJ4GikwXaUR/aauv8/WMp3gb09bm+EAlixvoB3KF4Er/aQe5AylIAMdoQvx6UIpn1yb5pcXirIJO9ryhgWu1LD2O1tW7H1nShHU+9fyA==
Received: from IA4P221CA0005.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:559::10)
 by SA1PR12MB8699.namprd12.prod.outlook.com (2603:10b6:806:389::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Sun, 8 Feb
 2026 14:29:32 +0000
Received: from BL02EPF0002992C.namprd02.prod.outlook.com
 (2603:10b6:208:559:cafe::ce) by IA4P221CA0005.outlook.office365.com
 (2603:10b6:208:559::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Sun,
 8 Feb 2026 14:29:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0002992C.mail.protection.outlook.com (10.167.249.57) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Sun, 8 Feb 2026 14:29:32 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 06:29:15 -0800
Received: from rnnvmail203.nvidia.com (10.129.68.9) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 8 Feb
 2026 06:29:15 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 8 Feb 2026 06:29:13 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH v2 1/2] common/mlx5: add mlx5 prefix to remaining internal
 functions
Date: Sun, 8 Feb 2026 16:29:07 +0200
Message-ID: <20260208142909.134443-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20251127112919.53710-1-mkashani@nvidia.com>
References: <20251127112919.53710-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992C:EE_|SA1PR12MB8699:EE_
X-MS-Office365-Filtering-Correlation-Id: d8d5eb6e-118d-415b-5e70-08de671e79c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rnrAobWiywsuPwC03QwrWmKIy25Dx/osHvLl/pz2enub4A6HqO6SHTI6DFt3?=
 =?us-ascii?Q?h9vr7jW6ZvN+eQZE2yu5HeNcXVb8+QjjQ95EXdZ2Y9aT660UU+jz2lV2gLYs?=
 =?us-ascii?Q?4N+JBxOerXvBlPB1ZkcnhK3Qy6TZRofOG4egY7a79tafex0g2MSSeyeinSHd?=
 =?us-ascii?Q?2TGzPT/E3SCZW+yaCZundCJu2FFreKIrqmz6D+4TKk9YHbXDcxncs9RLyQDw?=
 =?us-ascii?Q?AMgqy02bn4wD2gUANuFdc8jQ9ypUf/PAgU1r2taGoSE5BJpb/Sgb1VKBh2JF?=
 =?us-ascii?Q?NeLoQ1t5IoNDe5hAUliRUu8bba8MOtdk6KZXRrluAC3HkJIFRpRkweKkUjcZ?=
 =?us-ascii?Q?alj1cWTdontUsRxL0AfZTuCeYlhA7qf59VcDRT7sGgYucjwK9kUfay3oH3HK?=
 =?us-ascii?Q?fHbTL0qAByborDXkfL7w32dwMhjXM8vLsbbi22WBCbN9W6U3EdXdKmk9r0vv?=
 =?us-ascii?Q?NnGwunVg2Gi04xqOh+pvD4ZTffWYM7rHa3jHV3cSlb+HQS5Lg3fuP5nUrZ5o?=
 =?us-ascii?Q?wQzx5hRA7+FyJE5ZppJK3tGYBRCBUhbj6znP0RTyEnYmv6Hz4ed8vOFblE7s?=
 =?us-ascii?Q?i+D9j+61FkbAAdnQKs5Rw3DZNW2hg1BGNsO6ZvFCGl+H2NAg6/GC+cYtzVHz?=
 =?us-ascii?Q?DwFQso87td6nTOipgVBhXJlcEWQFZTfF8zRXW0H677i4YoJEMmhhJI2IwjCz?=
 =?us-ascii?Q?WcKAMUPHYQEL3QcpiakkmmXf6vLDcqt3G6O1CauVe63jc+f1qwQHtiWf4AyB?=
 =?us-ascii?Q?kV4CifSI0zs571MXcu7wJLRm4EUZdQBXZcxzDrC+B9aHOtDoA/XdqYohZ4Pq?=
 =?us-ascii?Q?OrIuQtmWHIa0iVQzeAjhs02KFHyHsb52BphPwcndqNvPmRfkCeqlg9cIhso9?=
 =?us-ascii?Q?9xQ8uvvCFocJWABLKy6zzmRj7pGCRV+arZTy+mOn6P4i6CtQH/CcttNOY7BU?=
 =?us-ascii?Q?CcC8HQR5X6pYeEw4dWtke+BvURDBWbbNU0JEUMylvTtk4LoBJsXNBJwBLXQH?=
 =?us-ascii?Q?5VnYUuMyRkozCLYYjknkxvz4m8Yh8j+kTw6Yy9a1eXHkBvs3dAeq6QP5mSkf?=
 =?us-ascii?Q?WRFbi/sEgYBLVPB8fvDyNNX3uBjq7oSJG5zpuA7IxRFLTsupZFQKXE/4oY2i?=
 =?us-ascii?Q?9fLx94H6xh9O0q3gVHjYXiLSiBTOq1E9EYdXQEaPSvEqxtIMzI9T4W3Oy37b?=
 =?us-ascii?Q?d8OMNqV28zslh3Scz/L25kDI+93j+iQ8SPFkkEQg8tIQZiTiAOLmjPJupLNM?=
 =?us-ascii?Q?CnwP/aF8Q43pXt46EF8hnk1uCXIc/DdfINb6cY3d5UA90DsWQv6sm3EzqUkW?=
 =?us-ascii?Q?gDQ3b+UqmPSI1rCnE7VaM2CxcFgGTUeJ782QJ3vazTKoyM8PuyiFhLLQI0dG?=
 =?us-ascii?Q?xkiZOe9Pgcu+7OjiKi0lbGWo68epqAT5KRaJz43jiZIk+jvLbeMV9mLKcVle?=
 =?us-ascii?Q?2JR3VBHnTlRUx15we7VTqfxO4a0UTBx+LQ5C1DfXsUhhVuTcQTnOXcuG8xF4?=
 =?us-ascii?Q?4fk1WS1AREL5F5M7rWqcVetwqYFe/oEA+XihSWBu09vLtFVJ9Wlt12QJZ/xi?=
 =?us-ascii?Q?LKNoDlEd+Y1OTvuAK1hhtSMIVkUSKrVuYzUpI7S/BG8v7W/48skCk3t7bzBn?=
 =?us-ascii?Q?x4lDhSXpQUUW9+P+/BJ7dUX8fCvTS2vFPJ0Z9DsAa/LYZuuMp5J5vHT2IQMa?=
 =?us-ascii?Q?S0EIMg=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ttzcnBPkvhffez2ZQef2JP9D3GTchPJ/wMu+S7sAzYT0NmujIK6uuQ2mRcbsfv0MsLv59mqVU15TXfixMre55WfrQ/682Oy6QvYP+zDgHRwiR1nYaJD4plPMWe3lcafLMcG8qg4Ss0f20wHI371VMLM1Yjd9JjMt8WDnRBJRcnRUi5lUIy099BujzFzd8EzOYm6O0hUcKeQRJTd2z15dMjWJkZK5AfKuU1f8+WeBv4tjw0jckYuSJgCyvkQSVcJm4PCuQc3S8ThMkrI2XgUlOg7nkvYV483UolKn/VSdMHtDtceZvSM5BV+nHuFIm3WhcHZaiVq1QvKDxgb+u7WiA3S/EdXjYPPmJgscTmuh7SoLDbO5ky2ymHNBjO3byqUZ7hs6P+iqH60XiHJnqb7MDBTKM8cM12spiSwOFYwIjOOA5QepVDzPwv8XxZV4kwFi
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2026 14:29:32.1015 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d8d5eb6e-118d-415b-5e70-08de671e79c6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8699
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

