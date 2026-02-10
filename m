Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41CB9EA811A
	for <dpdk-dev@archiver.kernel.org>; Tue, 10 Feb 2026 14:06:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 62CB1400D7;
	Tue, 10 Feb 2026 15:06:49 +0100 (CET)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011016.outbound.protection.outlook.com
 [40.93.194.16]) by mails.dpdk.org (Postfix) with ESMTP id 5B54E400D6
 for <dev@dpdk.org>; Tue, 10 Feb 2026 15:06:48 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PlKRxx4e/PGxAkkbyRnAdvJ2LxaUP7GQCwwaDHKFYzFgT5eC931qfHLclt8q97d1TTM1ONJF4ZPzcVFi3DZMSlhXPNoJ0Y2LYuTQih2t+jgkniebUtHNyxOjtU554/krZ54ULgzsEqKlAx7N8WUWgka1xlXfCdvyKovAKwfxpmDO6AFve7oQxedERzj8o2pvbYcKL7E+1MiILSondgPVp5vn+GT4dLYHGx1Yxa+aPI0HfciXr3Soqn1e6R4ZL5QwrdYU+8148Xn7+HEMePud5YFgsqJMb9SK/WrlngHtU1QsDUcNlmZ2wb81TviRMYTwjU+7uy8630dQR/w/6TJYOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9xQ4r8YcnYnaaBS/C4GBPwEH8NRDUogWPNxMtLot/z4=;
 b=O3cd50Slrte8JE32uOgU3IOVf3wzB/nm0xQu5uDKZprNSSojVwDwAKD0xww+Bpxj8kpZQvYi9moWVXx6XnfFHbNFW7Sg/iNxLoHt4/0FPf3wrQF0okor6zAcNAkysvKMikttefgWI4ce75cTmQ8lQ5o1wtd/K3L1diFjZpv84ccOL2kySIqbzqepq1kLoQekFh0lUaaT2Y+75MjIbSy6iWLstcDpHAjTQf4JBHTbj1T/va/5HcGkZlhj47JONXvbbIdULJtiztur0SDpSzcHyy9vZn1xWp2Fc4+7fjAduSDI2+ng8opoKNDKioRBNi6KHgJdRMcm8Q6MbF3hpX8t2g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9xQ4r8YcnYnaaBS/C4GBPwEH8NRDUogWPNxMtLot/z4=;
 b=fjDS4LhfvHR0aV9k555ioxV/HpNzer+YNDyh6WQBphlv8plYpUfDUA4vPbEjGqlG9oyG1Uw1hWAMlzagHjo7Heh5Nsp+MaK+hODPueKNn4/8vKnCOpo9ChSMZFqvnjeH2smZh3NRqj15eOwtJmselBzsDxpzMdOhlTi7WWbgML62HBdNlmuT1UEyksYGbEIhzK2nFm4aFw9neGV7L0YjyufWuFyPx9X8+rhPaSc+IA/6eCy2qVPXp3WiY6oEDrs8OwAXLLV+04lE+voYIlp03oPmNhFMNDHbLv/kQR3Sb9pvUgohfX+adAcXzcDgitXxLfl6qiTKeHo8tRWJJ3SMMQ==
Received: from BLAPR03CA0060.namprd03.prod.outlook.com (2603:10b6:208:32d::35)
 by SJ2PR12MB9140.namprd12.prod.outlook.com (2603:10b6:a03:55f::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.17; Tue, 10 Feb
 2026 14:06:44 +0000
Received: from MN1PEPF0000ECD4.namprd02.prod.outlook.com
 (2603:10b6:208:32d:cafe::62) by BLAPR03CA0060.outlook.office365.com
 (2603:10b6:208:32d::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9611.8 via Frontend Transport; Tue,
 10 Feb 2026 14:06:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MN1PEPF0000ECD4.mail.protection.outlook.com (10.167.242.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9611.8 via Frontend Transport; Tue, 10 Feb 2026 14:06:42 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Feb
 2026 06:02:39 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 10 Feb
 2026 06:02:39 -0800
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Tue, 10 Feb 2026 06:02:36 -0800
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <dsosnowski@nvidia.com>, <rasland@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>,
 Ori Kam <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH v3 1/2] common/mlx5: add mlx5 prefix to remaining internal
 functions
Date: Tue, 10 Feb 2026 16:02:31 +0200
Message-ID: <20260210140232.244782-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20251127112919.53710-1-mkashani@nvidia.com>
References: <20251127112919.53710-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD4:EE_|SJ2PR12MB9140:EE_
X-MS-Office365-Filtering-Correlation-Id: a66fa0be-8dc6-46b3-b0dd-08de68ad9e37
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XhyWt70vyp0q4+vnJGW3j+UKM15Mn2cY4w02L6B0H9tcQe/eAdEQkCa6qXJQ?=
 =?us-ascii?Q?YqNAkT2Sw4BAwbaK4AT45ZBYmjiuotsADKqMzMcnIL0KqwhZMAIU8NBtinpA?=
 =?us-ascii?Q?UXAVnGRIVcavQH8RFA2hRLAkP+aDBzaNmadGzdMFAxQw6I3pFv8yY45Rb49F?=
 =?us-ascii?Q?kjT8uVLqmWPBOsrgeasH656lKTqY3qT2mGGYMXk++7fU8cO10ri5STOSGWkG?=
 =?us-ascii?Q?LzGMfgH5JIcaNhBboOkquYpMyj4BV9dWq6TaVQNooIu5Lt55ZzeCKN/Yx0zi?=
 =?us-ascii?Q?/W+nuRBmcDzhqRJLeNNUY528kjnKnh8d8sHkb+pgtlCo0dJZk0cvz7zzNKoY?=
 =?us-ascii?Q?T8PUN9q4aRozZmLOz8tyoHpHrOzf3ui+D9DOTXhP1AEMxpf/hVMA7cyb0Lji?=
 =?us-ascii?Q?dG7m0iQrPFyuVxLvM/5I2LRvIXh3g7Ha9t/BgJ8mKg+ribOZBU3lyN1rPccc?=
 =?us-ascii?Q?57voXOYtopJnKVGAFIJs0XcWeFc6MrVOs8YaNwjdnP1b7h0sv6Ryi4JaTCbY?=
 =?us-ascii?Q?fqIOMN8Yg6OOaOprNVEHcU+N3s+5ItnEIIvVfktRnNbWf39dt8l3khEl4/Kx?=
 =?us-ascii?Q?mGjtUljxSQA5LR9xAxhKMUDJhzmujBn+pHK6aU9elIQew9GtXnv/WjaNxwo2?=
 =?us-ascii?Q?Qwl2/Hx4SpA0r30EuPfxo94pLhurSeX6dj1EJIbbeYo+CpKE1dA28NYUJzZS?=
 =?us-ascii?Q?ln0NUx+4DTQpejWF8A0nL1sTb7zMTe2QytQZbcYhygK/P4qoab9pcwHxnE2D?=
 =?us-ascii?Q?38rA/J+axavvUxDDP9Af9VdFljcuHmDYip8wbft1ORIUGHE9GJJTnN+NDhz7?=
 =?us-ascii?Q?R/2vc8KW0QtGT7n4KqK0ougYsOX2H4HEd+SRxEJf5RgiUO/fbvTsQCJo0YkU?=
 =?us-ascii?Q?wqr4NYreuHkt34KjIJtFR+ndxIZVRrkXEZ2HUPxiGPwzZaLbc9SW//r4W76t?=
 =?us-ascii?Q?IGdTuXDQFXJtX3HpIxsR6OKEniPbdNnERlSVuXJUrHLUPUFTUY6zAaiGABTW?=
 =?us-ascii?Q?v2fMb4vYoc36V/syoNqq24Zrr0YlczIp8FbLMOkVnsCKIWWm5q6iFkdEIaCP?=
 =?us-ascii?Q?U3oWbheXSK3qFH4F6HlwH1ZD5XTModoVKXB8gTtM66pA3nwhDatRI9k3jYa6?=
 =?us-ascii?Q?IIwT6MKZL+oeE3+4EX6dvxuYnhkmSYOOtCO48/ncwidsaP4se4rYiwgxR1ii?=
 =?us-ascii?Q?eb9bDmRO6TKZTUs0ujmbCwrRCI/tGF5jdNIWLd4KyuiWfEYUovIi0M08CGOX?=
 =?us-ascii?Q?7B0rdA3N4vy17UYx+lNc9ZrgbiBqjW+k9neIXh3sV6U9nbn+wacebqjDqS3p?=
 =?us-ascii?Q?uh14hsJmh/vqdwk4qTOCEKLwuUZ3ZF8/PclUUWIIdh4UGNh36uz1j2aWxT0M?=
 =?us-ascii?Q?7JwuYh5p1dFcAPqm5p5jz8ynLscmhwfKXbBNezK4tvgDQ7GEYZ4uF91OQBve?=
 =?us-ascii?Q?gf0b8SNVJwDSaszdBG+f0w3RAFpAcXf1/3SCj8VxZ6MAw9+9C1EK7Eonlvzt?=
 =?us-ascii?Q?2e4Mc1woBemF2KI34ZNiWWQWdTI23+88dDW1gsYBjleWhngcT4f7KSTv4CZ6?=
 =?us-ascii?Q?PMob2FazEQ0f6pSGe2zqUWiMq/4uR9ZdXeaa+IIwZWgnj9Kos9KI0dnlCcto?=
 =?us-ascii?Q?TwHN04DG5KZg75zUCmM0hj7DI4m3kiT0WT6v+Jd+xx73FQIPFd5QbANTbXD3?=
 =?us-ascii?Q?E9lVzA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: XHbbhMWOeG3VKpIDHvXHF0mCHCQbkKOJITB1pM+i7JoTY1XOoG7fBqChuqnp2/Fj6RUnuD8i/Jzji4gZ2gkHWhk089UkGCMspwpEmorixqbQjxaM7n9A3b5yW86RknSyszz8FCZp68f9VcAygMpgSpNWyERAZhz+SDMrEdE+rte6y3BKtuCz7Y7I0fRgvSwZZl26CgKcF+9nPor4dZ3uG6wMxxYpaFmlSmNrPoq7tIoqLXC5hgA2809KN8XwrKf88XHz2I8AoN/GPGihZwn4eJyk6wG5IZMXf1omBEMjqkUKUL96t4Uw7GQ4BNbV3Fl8ydMi0AHhMbzXTfiHwxJ+E9+VyNPPcmQUw6zvIxhFmxCezQrVRl4QA47xnMo/Ljp8rrx/rmxqYbnZ+orZud4Dkmn60viY4tOghckbc8lw7q/YMJ3u0+Q3rWoKqh1sD9Q7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Feb 2026 14:06:42.4296 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a66fa0be-8dc6-46b3-b0dd-08de68ad9e37
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD4.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9140
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

