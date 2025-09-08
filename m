Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14B2BCA1013
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 11:06:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DBE340662;
	Mon,  8 Sep 2025 13:05:23 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 1CA3A40647
 for <dev@dpdk.org>; Mon,  8 Sep 2025 13:05:19 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11020119.outbound.protection.outlook.com
 [52.101.84.119]) by mx-outbound46-194.eu-central-1c.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 08 Sep 2025 11:05:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8rbuD9IGsjqj4CDLYmn5PAhShikLT2WVzhQlDrhcDXrn3qfZ9iDGi+F9SX8lpwklNkmG9kJGEhXuysV5mqvwKY3UNAGlh7lHCl2u9SY6hat89BuE/jB0bDypmlDPBozIj/bhkpls1fwYSSgoucdglo426AHmZOWTUZJ2jS8XYqY2NVfEIvsXx2lmo4y5j4QbdZwWp8xtygTUOP7/V7dt2MphV9tP9Un43nI2rP0y3khHGIolcwgrOv6BBQ+uRzQGopmYQr2wFt/RnMRQxeKPKR6+X1932Ua8+JuOpMHVsph79gS87SHY1j891oa7uIzFBo0TvrCj0ml5EJhz5SL0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BO6OUAEr4TkJS+jCwxt6Swrvhs3gascSHLxN19sRxxM=;
 b=lliehEkfFxbPlFq1YFOQkTZYWE6A/6a2NkRm5+x7kSoonBHbmoHy07gZ43aJmHcvMUvM4+0r46OyzqwE0iCurRz82AOgvciFy/6jEIzXHhlzPXn86nHH0vgylti2AyxOAq6hUshUojLTx8GaR7T2W+ulVHlxTSsoJsfIFIiKEQbPIlmSaRriwrUbIQk51NB1K0E4g2jv+k84435JGoMzm4m/oaC+ZPu38KC6Tw8mZINycBRihjMSFn+5xalgNf/NKKl4yYxt4kXg7kNBt4ROt5KnRaliKepvoATQZ6Vk0b4E+TMaxhqhjJPlkqHMHr4pM8mMKLFKQVgdSvpJXPLDjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BO6OUAEr4TkJS+jCwxt6Swrvhs3gascSHLxN19sRxxM=;
 b=UBWTReY+8hhHmzhPzwWzdWV07suDVRpeTtyoSBaVNytHETcF4fQccYBUmM9XD88y+z6iZ6Uda9qUvwa91OUajrl5KFcjUYLK9hEZhd1h7J+Pa+05B8FGQ6955VbVWeM4ziFLI6QqfJRaisFmwrVc+fEFGSjDYDKS+uwPymrRDek=
Received: from DU2PR04CA0359.eurprd04.prod.outlook.com (2603:10a6:10:2b4::26)
 by VI0P190MB2308.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:2bc::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 11:05:14 +0000
Received: from DB5PEPF00014B97.eurprd02.prod.outlook.com
 (2603:10a6:10:2b4:cafe::c3) by DU2PR04CA0359.outlook.office365.com
 (2603:10a6:10:2b4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 11:05:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DB5PEPF00014B97.mail.protection.outlook.com (10.167.8.235) with Microsoft
 SMTP Server id 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 11:05:13
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 5/7] net/ntnic: migrate adapter mon thread to service
Date: Mon,  8 Sep 2025 13:04:43 +0200
Message-ID: <20250908110446.1071964-6-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250908110446.1071964-1-sil-plv@napatech.com>
References: <20250908110446.1071964-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B97:EE_|VI0P190MB2308:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bbda5c13-b804-4e06-28cb-08ddeec79608
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9+nREW3UlLIhrIsGUrhdA+BeYF1Ri612sej0yEeOgCHTTfTNKQagB0agGz/w?=
 =?us-ascii?Q?XXToISxF+x3jJ4UL17lzK3Hq1VPqgixkMrpMlZKoagpAwGfcX2xCgQJ4/4B8?=
 =?us-ascii?Q?Pz8DIOl3GxXkAf0roxKgtdZQ4uRS4dY6bAENdUOSKNBmSbJmqEWm7c5SobCT?=
 =?us-ascii?Q?3JP/gFEmFoiR9jMbvYxj5qFI9/dfsR3TTK/NaOqSWY0LPFR37Z9fHkcgTOfw?=
 =?us-ascii?Q?fkk78r3aAC9EyoCbcKhhpmWb7Il4Np39b8D3kuoj1GFs82GrauX5b+qK7Jgz?=
 =?us-ascii?Q?epW4sfeTi0UwtHjGJlSOBC0uirojQwdx4YIfBL9SqthK80Bpu2kAjliSs50W?=
 =?us-ascii?Q?etVecPsNqTnYmHGnQb7YdZAu/hmjTzht/J7I+1jlLNqmH63oySFSphlaHs7I?=
 =?us-ascii?Q?Zk3KSe7AvdKZBY78lzyz+Lsgrf1k+g9xpnybbvvBYLoe1YnvA0HCWhxMaQiU?=
 =?us-ascii?Q?bivb+Z6x9P/1YPL1wC8W3hVIhLLTiss/bmh0CO7orWMH9GIikmXz+GOG3i1k?=
 =?us-ascii?Q?6jVgY5SjJCW3c/M1hEi27brwPQr/BoBf6TKgEWIJoAfa9y83s7d1zxidtozP?=
 =?us-ascii?Q?zX03YQVzYgfRGHH1A+CvqYgRID8UKiFhkGZ+W+m6C+cMVDzWt7ZvK0IBxgIV?=
 =?us-ascii?Q?hmDm+tzbMillDoHbWkoBxots/CBI06VOpyJJKP+1KIr3x972w0pjtMHxYSG3?=
 =?us-ascii?Q?xjgZZCYDK3ROk5gzkbpxgsn4KxAXcTUf+psAWbK2PC1PDyzsnDlxuCNbCmF4?=
 =?us-ascii?Q?orrE3g2TyDU7HKtajzuWoeL/KNBV6WT3tqA1Mj/cp/+VpBudxHvg+mOBCnZ8?=
 =?us-ascii?Q?PVf1WSc2rZOop2npd7HRqpVLltLdU/xLnZYASAq0PZolsBM/jU/jXlChbjRS?=
 =?us-ascii?Q?LsmU7PmwFxTwIyNVM48+iK9LNYK/VSaGQsMlFCHerg2p6k98oWJNG5BrlLYo?=
 =?us-ascii?Q?9A8UXnln135M28fXvEqHXCZTNrzhFtkF1X90nssJB33d32/gKqml2TbAKzMB?=
 =?us-ascii?Q?Qgs7+aKlUHrjJp0986x4O6tqSuAmKTtHQZsimJzKdeNugQGwSgRXscbrojyH?=
 =?us-ascii?Q?zCuXbpZbGKzwdX7/TWR710s27vNdvS2YXT0Ht6XNiB70E3TICO0J8iH2cCno?=
 =?us-ascii?Q?hDWDWCDkXDECksOrc3qXVWbI464IzY9b7yPT6oYpuv0X7I6ykM/kC+o/cHPg?=
 =?us-ascii?Q?cat/wGRTgUO52b7xn1AjYrhEcuGyNUVrCxldlfbZw8G+xQ/NGBy+NnUqh5qe?=
 =?us-ascii?Q?qprClvbFzJTBqxlXFVgXT3enmlT56nE6DGvyJz+FKz/qFGfuxUj4wgwLti4Y?=
 =?us-ascii?Q?AILdVzY8b2IPvOFDipEt8IjT6g4Pzw0CBJKndIR4kV6nG0uajBS6bMU1ushV?=
 =?us-ascii?Q?gCaeL59PtTvYr8thmMDpAOSq+2P/jxnNRuFoSZimThEuJ+9k2ersjY/ChZwD?=
 =?us-ascii?Q?Cot0d7s1zvML0N+vVJmmb/g35C+h0z0bceH+fB5P5VZp3X9/2a8UY72CElg8?=
 =?us-ascii?Q?3awUbHjdEvObJxK1CmuaLEzJNTBfnIwFgu3s?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 0ffwaVPGOKb35qApOlZ01hMx3qaIBppcN4zUPW2Y4cikzG5q3hWd4uMr432r5691iz4Ke3DTBSj4MlJ6/vBFgIt6NQPMLeSYl4WNdYh/pphOtCohi9llcA5LAtN2Cnski3to/bPWSJrgpQC+o0beiuRMsO/bs7gc0x99VTInLHUpOrRVA+22I6Gkoq6bd7+guB67OasoNHx/Eq9GWvldKfHfQRK7NPUh/NJNbH55D4oIV1BBdWgaUGdJuDUTpZXBzvrNfq520HJMqE8DpesI0FGLN1fb1jV44wXa5mQMcxRWl/qSTxN4F4Idta9FxGe+rG/Tsym1Ubo4mRdBWcuIWvbjtsfD9DNvVxFhC/tv4DU12XLnzMFrO/Of2sXPW7w0c3NSQw1Y++2NkmI2E+HTwkeQPXYVXCOrD6PJ/cRM9xaPF83/XRTnfuQkmyfXJX6QD+ptP6b6HOKW+qD+K+wAB/XMvPQE2/LcfQDaebQclIpStRAUTtTzheP87RZpymY+h620wjlrdDtEQayWj8cd3b2QVFNQUGEWbi+cFeuB7mX0Uqvc7jKgZqKHbQc6kAz5yw6yGp5+oIMifrxI0S2auGaPCj2u1jv8023BeV0AxqjstGyyCgDZ087N3BXVvxNtaDyZjkNE8ZRIMQjt/Ttmqw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:05:13.8083 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bbda5c13-b804-4e06-28cb-08ddeec79608
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0P190MB2308
X-BESS-ID: 1757329516-311970-7674-3969-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.84.119
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaWRhaWQGYGUNTCyMTczMw4Nd
 XE0MTQ0tzEJNHIODkpzdAgJSktxcjCQqk2FgBeFZrMQgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267333 [from 
 cloudscan13-237.eu-central-1a.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.50 BSF_RULE7568M          META: Custom Rule 7568M 
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

The adapter monitor service is responsible for link state management.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/adapter/nt4ga_adapter.c     |  25 +-
 .../net/ntnic/include/common_adapter_defs.h   |  15 -
 drivers/net/ntnic/include/nt4ga_adapter.h     |   3 -
 drivers/net/ntnic/include/ntnic_stat.h        |   2 +-
 drivers/net/ntnic/include/ntos_drv.h          |   2 +-
 .../link_mgmt/link_100g/nt4ga_link_100g.c     | 303 +++++++++--------
 .../link_agx_100g/nt4ga_agx_link_100g.c       | 306 ++++++++++--------
 drivers/net/ntnic/ntutil/nt_service.c         |   6 +
 drivers/net/ntnic/rte_pmd_ntnic.h             |   1 +
 9 files changed, 334 insertions(+), 329 deletions(-)
 delete mode 100644 drivers/net/ntnic/include/common_adapter_defs.h

diff --git a/drivers/net/ntnic/adapter/nt4ga_adapter.c b/drivers/net/ntnic/adapter/nt4ga_adapter.c
index 526ecc8089..363874c85f 100644
--- a/drivers/net/ntnic/adapter/nt4ga_adapter.c
+++ b/drivers/net/ntnic/adapter/nt4ga_adapter.c
@@ -5,6 +5,7 @@
 
 #include <rte_thread.h>
 
+#include "nt_service.h"
 #include "ntlog.h"
 #include "nthw_fpga.h"
 #include "ntnic_mod_reg.h"
@@ -12,28 +13,6 @@
 /*
  * Global variables shared by NT adapter types
  */
-rte_thread_t monitor_tasks[NUM_ADAPTER_MAX];
-volatile int monitor_task_is_running[NUM_ADAPTER_MAX];
-
-/*
- * Signal-handler to stop all monitor threads
- */
-static void stop_monitor_tasks(int signum)
-{
-	const size_t N = ARRAY_SIZE(monitor_task_is_running);
-	size_t i;
-
-	/* Stop all monitor tasks */
-	for (i = 0; i < N; i++) {
-		const int is_running = monitor_task_is_running[i];
-		monitor_task_is_running[i] = 0;
-
-		if (signum == -1 && is_running != 0) {
-			rte_thread_join(monitor_tasks[i], NULL);
-			memset(&monitor_tasks[i], 0, sizeof(monitor_tasks[0]));
-		}
-	}
-}
 
 static int nt4ga_adapter_show_info(struct adapter_info_s *p_adapter_info, FILE *pfh)
 {
@@ -255,7 +234,7 @@ static int nt4ga_adapter_deinit(struct adapter_info_s *p_adapter_info)
 	int i;
 	int res = -1;
 
-	stop_monitor_tasks(-1);
+	nthw_service_del(RTE_NTNIC_SERVICE_ADAPTER_MON);
 
 	/* Nt4ga Deinit Filter */
 	nt4ga_filter_t *p_filter = &p_adapter_info->nt4ga_filter;
diff --git a/drivers/net/ntnic/include/common_adapter_defs.h b/drivers/net/ntnic/include/common_adapter_defs.h
deleted file mode 100644
index 6ed9121f0f..0000000000
--- a/drivers/net/ntnic/include/common_adapter_defs.h
+++ /dev/null
@@ -1,15 +0,0 @@
-/*
- * SPDX-License-Identifier: BSD-3-Clause
- * Copyright(c) 2023 Napatech A/S
- */
-
-#ifndef _COMMON_ADAPTER_DEFS_H_
-#define _COMMON_ADAPTER_DEFS_H_
-
-/*
- * Declarations shared by NT adapter types.
- */
-#define NUM_ADAPTER_MAX (8)
-#define NUM_ADAPTER_PORTS_MAX (128)
-
-#endif	/* _COMMON_ADAPTER_DEFS_H_ */
diff --git a/drivers/net/ntnic/include/nt4ga_adapter.h b/drivers/net/ntnic/include/nt4ga_adapter.h
index 7396b8ab65..6c701b601f 100644
--- a/drivers/net/ntnic/include/nt4ga_adapter.h
+++ b/drivers/net/ntnic/include/nt4ga_adapter.h
@@ -47,8 +47,5 @@ typedef struct adapter_info_s {
 	int n_tx_host_buffers;
 } adapter_info_t;
 
-extern rte_thread_t monitor_tasks[NUM_ADAPTER_MAX];
-extern volatile int monitor_task_is_running[NUM_ADAPTER_MAX];
-
 
 #endif	/* _NT4GA_ADAPTER_H_ */
diff --git a/drivers/net/ntnic/include/ntnic_stat.h b/drivers/net/ntnic/include/ntnic_stat.h
index 1b53f6c347..928c629fb2 100644
--- a/drivers/net/ntnic/include/ntnic_stat.h
+++ b/drivers/net/ntnic/include/ntnic_stat.h
@@ -6,7 +6,7 @@
 #ifndef NTNIC_STAT_H_
 #define NTNIC_STAT_H_
 
-#include "common_adapter_defs.h"
+#include "ntos_drv.h"
 #include "nthw_rmc.h"
 #include "nthw_rpf.h"
 #include "nthw_fpga_model.h"
diff --git a/drivers/net/ntnic/include/ntos_drv.h b/drivers/net/ntnic/include/ntos_drv.h
index e6e46f8cc1..f353a5eca8 100644
--- a/drivers/net/ntnic/include/ntos_drv.h
+++ b/drivers/net/ntnic/include/ntos_drv.h
@@ -20,7 +20,7 @@
 #define NUM_MAC_ADDRS_PER_PORT (16U)
 #define NUM_MULTICAST_ADDRS_PER_PORT (16U)
 
-#define NUM_ADAPTER_MAX (8)
+#define NUM_ADAPTER_MAX (1)
 #define NUM_ADAPTER_PORTS_MAX (2)
 
 
diff --git a/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c b/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
index adb187d322..21e95d84bd 100644
--- a/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
@@ -9,6 +9,7 @@
 #include "ntlog.h"
 #include "i2c_nim.h"
 #include "ntnic_mod_reg.h"
+#include "nt_service.h"
 
 /*
  * Swap tx/rx polarity
@@ -478,170 +479,178 @@ static int _port_init(adapter_info_t *drv, nthw_fpga_t *fpga, int port)
  */
 static int _common_ptp_nim_state_machine(void *data)
 {
-	adapter_info_t *drv = (adapter_info_t *)data;
-	fpga_info_t *fpga_info = &drv->fpga_info;
-	nt4ga_link_t *link_info = &drv->nt4ga_link;
-	nthw_fpga_t *fpga = fpga_info->mp_fpga;
-	const int adapter_no = drv->adapter_no;
-	const int nb_ports = fpga_info->n_phy_ports;
-	uint32_t last_lpbk_mode[NUM_ADAPTER_PORTS_MAX];
+	static adapter_info_t *drv;
+	static nt4ga_link_t *link_info;
+	static nthw_fpga_t *fpga;
+	static int nb_ports;
+	static nim_i2c_ctx_t *nim_ctx;
+	static link_state_t *link_state;
+	static nthw_mac_pcs_t *mac_pcs;
+	static nthw_gpio_phy_t *gpio_phy;
+	static uint32_t last_lpbk_mode[NUM_ADAPTER_PORTS_MAX];
+
+	struct nt_service *adapter_mon_srv = nthw_service_get_info(RTE_NTNIC_SERVICE_ADAPTER_MON);
+	RTE_ASSERT(adapter_mon_srv != NULL);
+
+	if (!NT_SERVICE_GET_STATE(adapter_mon_srv)) {
+		drv = (adapter_info_t *)data;
+		RTE_ASSERT(drv != NULL);
+
+		fpga_info_t *fpga_info = &drv->fpga_info;
+		int adapter_no = drv->adapter_no;
+
+		link_info = &drv->nt4ga_link;
+		fpga = fpga_info->mp_fpga;
+		nb_ports = fpga_info->n_phy_ports;
+
+		if (!fpga) {
+			NT_LOG(ERR, NTNIC, "%s: fpga is NULL", drv->mp_adapter_id_str);
+			return -1;
+		}
 
-	nim_i2c_ctx_t *nim_ctx;
-	link_state_t *link_state;
-	nthw_mac_pcs_t *mac_pcs;
-	nthw_gpio_phy_t *gpio_phy;
+		RTE_ASSERT(adapter_no >= 0 && adapter_no < NUM_ADAPTER_MAX);
+		nim_ctx = link_info->u.var100g.nim_ctx;
+		link_state = link_info->link_state;
+		mac_pcs = link_info->u.var100g.mac_pcs100g;
+		gpio_phy = link_info->u.var100g.gpio_phy;
 
-	if (!fpga) {
-		NT_LOG(ERR, NTNIC, "%s: fpga is NULL", drv->mp_adapter_id_str);
-		goto NT4GA_LINK_100G_MON_EXIT;
-	}
+		memset(last_lpbk_mode, 0, sizeof(last_lpbk_mode));
 
-	RTE_ASSERT(adapter_no >= 0 && adapter_no < NUM_ADAPTER_MAX);
-	nim_ctx = link_info->u.var100g.nim_ctx;
-	link_state = link_info->link_state;
-	mac_pcs = link_info->u.var100g.mac_pcs100g;
-	gpio_phy = link_info->u.var100g.gpio_phy;
+		NT_LOG(DBG, NTNIC, "%s: link state machine running...", drv->mp_adapter_id_str);
 
-	monitor_task_is_running[adapter_no] = 1;
-	memset(last_lpbk_mode, 0, sizeof(last_lpbk_mode));
+		NT_LOG(INF, NTNIC, "Adapter monitor service started on lcore %i", rte_lcore_id());
+		adapter_mon_srv->lcore = rte_lcore_id();
+		NT_SERVICE_SET_STATE(adapter_mon_srv, true);
+		return 0;
+	}
 
-	if (monitor_task_is_running[adapter_no])
-		NT_LOG(DBG, NTNIC, "%s: link state machine running...", drv->mp_adapter_id_str);
+	int i;
+	static bool reported_link[NUM_ADAPTER_PORTS_MAX] = { false };
 
-	while (monitor_task_is_running[adapter_no]) {
-		int i;
-		static bool reported_link[NUM_ADAPTER_PORTS_MAX] = { false };
+	for (i = 0; i < nb_ports; i++) {
+		link_state_t new_link_state;
+		const bool is_port_disabled = link_info->port_action[i].port_disable;
+		const bool was_port_disabled = link_state[i].link_disabled;
+		const bool disable_port = is_port_disabled && !was_port_disabled;
+		const bool enable_port = !is_port_disabled && was_port_disabled;
 
-		for (i = 0; i < nb_ports; i++) {
-			link_state_t new_link_state;
-			const bool is_port_disabled = link_info->port_action[i].port_disable;
-			const bool was_port_disabled = link_state[i].link_disabled;
-			const bool disable_port = is_port_disabled && !was_port_disabled;
-			const bool enable_port = !is_port_disabled && was_port_disabled;
+		if (!rte_service_runstate_get(adapter_mon_srv->id))	/* stop quickly */
+			break;
 
-			if (!monitor_task_is_running[adapter_no])	/* stop quickly */
-				break;
+		/* Has the administrative port state changed? */
+		RTE_ASSERT(!(disable_port && enable_port));
+
+		if (disable_port) {
+			memset(&link_state[i], 0, sizeof(link_state[i]));
+			link_info->link_info[i].link_speed = NT_LINK_SPEED_UNKNOWN;
+			link_state[i].link_disabled = true;
+			reported_link[i] = false;
+			/* Turn off laser and LED, etc. */
+			(void)_create_nim(drv, i, false);
+			NT_LOG(DBG, NTNIC, "%s: Port %i is disabled",
+				drv->mp_port_id_str[i], i);
+			continue;
+		}
 
-			/* Has the administrative port state changed? */
-			RTE_ASSERT(!(disable_port && enable_port));
-
-			if (disable_port) {
-				memset(&link_state[i], 0, sizeof(link_state[i]));
-				link_info->link_info[i].link_speed = NT_LINK_SPEED_UNKNOWN;
-				link_state[i].link_disabled = true;
-				reported_link[i] = false;
-				/* Turn off laser and LED, etc. */
-				(void)_create_nim(drv, i, false);
-				NT_LOG(DBG, NTNIC, "%s: Port %i is disabled",
-					drv->mp_port_id_str[i], i);
-				continue;
-			}
+		if (enable_port) {
+			link_state[i].link_disabled = false;
+			NT_LOG(DBG, NTNIC, "%s: Port %i is enabled",
+				drv->mp_port_id_str[i], i);
+		}
 
-			if (enable_port) {
-				link_state[i].link_disabled = false;
-				NT_LOG(DBG, NTNIC, "%s: Port %i is enabled",
-					drv->mp_port_id_str[i], i);
+		if (is_port_disabled)
+			continue;
+
+		if (link_info->port_action[i].port_lpbk_mode != last_lpbk_mode[i]) {
+			/* Loopback mode has changed. Do something */
+			if (!_nim_is_present(&gpio_phy[i], (uint8_t)i)) {
+				/*
+				 * If there is no Nim present, we need to initialize the
+				 * port anyway
+				 */
+				_port_init(drv, fpga, i);
 			}
 
-			if (is_port_disabled)
-				continue;
+			NT_LOG(INF, NTNIC, "%s: Loopback mode changed=%u",
+				drv->mp_port_id_str[i],
+				link_info->port_action[i].port_lpbk_mode);
+			_set_loopback(drv,
+				&mac_pcs[i],
+				i,
+				link_info->port_action[i].port_lpbk_mode,
+				last_lpbk_mode[i]);
 
-			if (link_info->port_action[i].port_lpbk_mode != last_lpbk_mode[i]) {
-				/* Loopback mode has changed. Do something */
-				if (!_nim_is_present(&gpio_phy[i], (uint8_t)i)) {
-					/*
-					 * If there is no Nim present, we need to initialize the
-					 * port anyway
-					 */
-					_port_init(drv, fpga, i);
-				}
-
-				NT_LOG(INF, NTNIC, "%s: Loopback mode changed=%u",
-					drv->mp_port_id_str[i],
-					link_info->port_action[i].port_lpbk_mode);
-				_set_loopback(drv,
-					&mac_pcs[i],
-					i,
-					link_info->port_action[i].port_lpbk_mode,
-					last_lpbk_mode[i]);
-
-				if (link_info->port_action[i].port_lpbk_mode == 1)
-					link_state[i].link_up = true;
-
-				last_lpbk_mode[i] = link_info->port_action[i].port_lpbk_mode;
-				continue;
-			}
+			if (link_info->port_action[i].port_lpbk_mode == 1)
+				link_state[i].link_up = true;
 
-			(void)_link_state_build(drv, &mac_pcs[i], &gpio_phy[i], i, &new_link_state,
-				is_port_disabled);
+			last_lpbk_mode[i] = link_info->port_action[i].port_lpbk_mode;
+			continue;
+		}
 
-			if (!new_link_state.nim_present) {
-				if (link_state[i].nim_present) {
-					NT_LOG(INF, NTNIC, "%s: NIM module removed",
-						drv->mp_port_id_str[i]);
-				}
+		(void)_link_state_build(drv, &mac_pcs[i], &gpio_phy[i], i, &new_link_state,
+			is_port_disabled);
 
-				link_state[i] = new_link_state;
-				continue;
+		if (!new_link_state.nim_present) {
+			if (link_state[i].nim_present) {
+				NT_LOG(INF, NTNIC, "%s: NIM module removed",
+					drv->mp_port_id_str[i]);
 			}
 
-			/* NIM module is present */
-			if (new_link_state.lh_nim_absent || !link_state[i].nim_present) {
-				sfp_nim_state_t new_state;
+			link_state[i] = new_link_state;
+			continue;
+		}
 
-				NT_LOG(DBG, NTNIC, "%s: NIM module inserted",
-					drv->mp_port_id_str[i]);
+		/* NIM module is present */
+		if (new_link_state.lh_nim_absent || !link_state[i].nim_present) {
+			sfp_nim_state_t new_state;
+
+			NT_LOG(DBG, NTNIC, "%s: NIM module inserted",
+				drv->mp_port_id_str[i]);
 
-				if (_port_init(drv, fpga, i)) {
-					NT_LOG(ERR, NTNIC,
-						"%s: Failed to initialize NIM module",
-						drv->mp_port_id_str[i]);
-					continue;
-				}
-
-				if (nthw_nim_state_build(&nim_ctx[i], &new_state)) {
-					NT_LOG(ERR, NTNIC, "%s: Cannot read basic NIM data",
-						drv->mp_port_id_str[i]);
-					continue;
-				}
-
-				RTE_ASSERT(new_state.br); /* Cannot be zero if NIM is present */
-				NT_LOG(DBG, NTNIC,
-					"%s: NIM id = %u (%s), br = %u, vendor = '%s', pn = '%s', sn='%s'",
-					drv->mp_port_id_str[i], nim_ctx->nim_id,
-					nthw_nim_id_to_text(nim_ctx->nim_id),
-					(unsigned int)new_state.br, nim_ctx->vendor_name,
-					nim_ctx->prod_no, nim_ctx->serial_no);
-
-				(void)_link_state_build(drv, &mac_pcs[i], &gpio_phy[i], i,
-					&link_state[i], is_port_disabled);
-
-				NT_LOG(DBG, NTNIC, "%s: NIM module initialized",
+			if (_port_init(drv, fpga, i)) {
+				NT_LOG(ERR, NTNIC,
+					"%s: Failed to initialize NIM module",
 					drv->mp_port_id_str[i]);
 				continue;
 			}
 
-			if (reported_link[i] != new_link_state.link_up) {
-				NT_LOG(INF, NTNIC, "%s: link is %s", drv->mp_port_id_str[i],
-					(new_link_state.link_up ? "up" : "down"));
-				link_info->link_info[i].link_speed =
-					(new_link_state.link_up ? NT_LINK_SPEED_100G
-						: NT_LINK_SPEED_UNKNOWN);
-				link_state[i].link_up = new_link_state.link_up;
-				reported_link[i] = new_link_state.link_up;
+			if (nthw_nim_state_build(&nim_ctx[i], &new_state)) {
+				NT_LOG(ERR, NTNIC, "%s: Cannot read basic NIM data",
+					drv->mp_port_id_str[i]);
+				continue;
 			}
 
-			check_link_state(drv, &mac_pcs[i]);
-		}	/* end-for */
+			RTE_ASSERT(new_state.br); /* Cannot be zero if NIM is present */
+			NT_LOG(DBG, NTNIC,
+				"%s: NIM id = %u (%s), br = %u, vendor = '%s', pn = '%s', sn='%s'",
+				drv->mp_port_id_str[i], nim_ctx->nim_id,
+				nthw_nim_id_to_text(nim_ctx->nim_id),
+				(unsigned int)new_state.br, nim_ctx->vendor_name,
+				nim_ctx->prod_no, nim_ctx->serial_no);
 
-		if (monitor_task_is_running[adapter_no])
-			nt_os_wait_usec(5 * 100000U);	/* 5 x 0.1s = 0.5s */
-	}
+			(void)_link_state_build(drv, &mac_pcs[i], &gpio_phy[i], i,
+				&link_state[i], is_port_disabled);
 
-NT4GA_LINK_100G_MON_EXIT:
+			NT_LOG(DBG, NTNIC, "%s: NIM module initialized",
+				drv->mp_port_id_str[i]);
+			continue;
+		}
 
-	NT_LOG(DBG, NTNIC, "%s: Stopped NT4GA 100 Gbps link monitoring thread.",
-		drv->mp_adapter_id_str);
+		if (reported_link[i] != new_link_state.link_up) {
+			NT_LOG(INF, NTNIC, "%s: link is %s", drv->mp_port_id_str[i],
+				(new_link_state.link_up ? "up" : "down"));
+			link_info->link_info[i].link_speed =
+				(new_link_state.link_up ? NT_LINK_SPEED_100G
+					: NT_LINK_SPEED_UNKNOWN);
+			link_state[i].link_up = new_link_state.link_up;
+			reported_link[i] = new_link_state.link_up;
+		}
+
+		check_link_state(drv, &mac_pcs[i]);
+	}	/* end-for */
+
+	if (rte_service_runstate_get(adapter_mon_srv->id))
+		nt_os_wait_usec(5 * 100000U);	/* 5 x 0.1s = 0.5s */
 
 	return 0;
 }
@@ -649,11 +658,9 @@ static int _common_ptp_nim_state_machine(void *data)
 /*
  * Userland NIM state machine
  */
-static uint32_t nt4ga_link_100g_mon(void *data)
+static int nt4ga_link_100g_mon(void *data)
 {
-	(void)_common_ptp_nim_state_machine(data);
-
-	return 0;
+	return _common_ptp_nim_state_machine(data);
 }
 
 /*
@@ -710,11 +717,21 @@ static int nt4ga_link_100g_ports_init(struct adapter_info_s *p_adapter_info, nth
 		}
 	}
 
-	/* Create state-machine thread */
+	/* Create state-machine service */
 	if (res == 0) {
-		if (!monitor_task_is_running[adapter_no]) {
-			res = rte_thread_create(&monitor_tasks[adapter_no], NULL,
-					nt4ga_link_100g_mon, p_adapter_info);
+		struct rte_service_spec adapter_monitor_service = {
+			.name = "ntnic-adapter-monitor",
+			.callback = nt4ga_link_100g_mon,
+			.socket_id = SOCKET_ID_ANY,
+			.capabilities = RTE_SERVICE_CAP_MT_SAFE,
+			.callback_userdata = p_adapter_info,
+		};
+
+		res = nthw_service_add(&adapter_monitor_service, RTE_NTNIC_SERVICE_ADAPTER_MON);
+		if (res) {
+			NT_LOG(ERR, NTNIC, "%s: Failed to create adapter monitor service",
+				p_adapter_info->mp_adapter_id_str);
+			return res;
 		}
 	}
 
diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index 75a7504510..c8b7912e26 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -13,6 +13,7 @@
 #include "nim_defines.h"
 #include "nthw_gfg.h"
 #include "nthw_phy_tile.h"
+#include "nt_service.h"
 
 typedef enum {
 	LOOPBACK_HOST_NONE,
@@ -768,179 +769,186 @@ static int _port_init(adapter_info_t *p_info, nthw_fpga_t *fpga, int port)
 /*
  * Link state machine
  */
-static void *_common_ptp_nim_state_machine(void *data)
+static int _common_ptp_nim_state_machine(void *data)
 {
-	adapter_info_t *drv = (adapter_info_t *)data;
-	fpga_info_t *fpga_info = &drv->fpga_info;
-	nt4ga_link_t *link_info = &drv->nt4ga_link;
-	nthw_fpga_t *fpga = fpga_info->mp_fpga;
-	const int adapter_no = drv->adapter_no;
-	const int nb_ports = fpga_info->n_phy_ports;
-	uint32_t last_lpbk_mode[NUM_ADAPTER_PORTS_MAX];
-	/* link_state_t new_link_state; */
-
-	link_state_t *link_state = link_info->link_state;
-	nim_i2c_ctx_t *nim_ctx = link_info->u.var_a100g.nim_ctx;
+	static adapter_info_t *drv;
+	static nt4ga_link_t *link_info;
+	static nthw_fpga_t *fpga;
+	static int nb_ports;
+	static link_state_t *link_state;
+	static nim_i2c_ctx_t *nim_ctx;
+	static uint32_t last_lpbk_mode[NUM_ADAPTER_PORTS_MAX];
+
+	struct nt_service *adapter_mon_srv = nthw_service_get_info(RTE_NTNIC_SERVICE_ADAPTER_MON);
+	RTE_ASSERT(adapter_mon_srv != NULL);
+
+	if (!NT_SERVICE_GET_STATE(adapter_mon_srv)) {
+		drv = (adapter_info_t *)data;
+		RTE_ASSERT(drv != NULL);
+
+		fpga_info_t *fpga_info = &drv->fpga_info;
+		link_info = &drv->nt4ga_link;
+		fpga = fpga_info->mp_fpga;
+		int adapter_no = drv->adapter_no;
+
+		nb_ports = fpga_info->n_phy_ports;
+		link_state = link_info->link_state;
+		nim_ctx = link_info->u.var_a100g.nim_ctx;
+
+		if (!fpga) {
+			NT_LOG(ERR, NTNIC, "%s: fpga is NULL", drv->mp_adapter_id_str);
+			return -1;
+		}
 
-	if (!fpga) {
-		NT_LOG(ERR, NTNIC, "%s: fpga is NULL", drv->mp_adapter_id_str);
-		goto NT4GA_LINK_100G_MON_EXIT;
-	}
+		RTE_ASSERT(adapter_no >= 0 && adapter_no < NUM_ADAPTER_MAX);
 
-	RTE_ASSERT(adapter_no >= 0 && adapter_no < NUM_ADAPTER_MAX);
+		memset(last_lpbk_mode, 0, sizeof(last_lpbk_mode));
 
-	monitor_task_is_running[adapter_no] = 1;
-	memset(last_lpbk_mode, 0, sizeof(last_lpbk_mode));
+		/* Initialize link state */
+		for (int i = 0; i < nb_ports; i++) {
+			link_state[i].link_disabled = true;
+			link_state[i].nim_present = false;
+			link_state[i].lh_nim_absent = true;
+			link_state[i].link_up = false;
+			link_state[i].link_state = NT_LINK_STATE_UNKNOWN;
+			link_state[i].link_state_latched = NT_LINK_STATE_UNKNOWN;
+		}
 
-	/* Initialize link state */
-	for (int i = 0; i < nb_ports; i++) {
-		link_state[i].link_disabled = true;
-		link_state[i].nim_present = false;
-		link_state[i].lh_nim_absent = true;
-		link_state[i].link_up = false;
-		link_state[i].link_state = NT_LINK_STATE_UNKNOWN;
-		link_state[i].link_state_latched = NT_LINK_STATE_UNKNOWN;
+		NT_LOG(INF, NTNIC, "Adapter monitor service started on lcore %i", rte_lcore_id());
+		adapter_mon_srv->lcore = rte_lcore_id();
+		NT_SERVICE_SET_STATE(adapter_mon_srv, true);
+		return 0;
 	}
 
-	if (monitor_task_is_running[adapter_no])
-		NT_LOG(DBG, NTNIC, "%s: link state machine running...", drv->mp_adapter_id_str);
+	int i;
+	static bool reported_link[NUM_ADAPTER_PORTS_MAX] = { false };
 
-	while (monitor_task_is_running[adapter_no]) {
-		int i;
-		static bool reported_link[NUM_ADAPTER_PORTS_MAX] = { false };
+	for (i = 0; i < nb_ports; i++) {
+		const bool is_port_disabled = link_info->port_action[i].port_disable;
+		const bool was_port_disabled = link_state[i].link_disabled;
+		const bool disable_port = is_port_disabled && !was_port_disabled;
+		const bool enable_port = !is_port_disabled && was_port_disabled;
 
-		for (i = 0; i < nb_ports; i++) {
-			const bool is_port_disabled = link_info->port_action[i].port_disable;
-			const bool was_port_disabled = link_state[i].link_disabled;
-			const bool disable_port = is_port_disabled && !was_port_disabled;
-			const bool enable_port = !is_port_disabled && was_port_disabled;
-
-			if (!monitor_task_is_running[adapter_no])
-				break;
-
-			/*
-			 * Has the administrative port state changed?
-			 */
-			RTE_ASSERT(!(disable_port && enable_port));
-
-			if (disable_port) {
-				memset(&link_state[i], 0, sizeof(link_state[i]));
-				link_state[i].link_disabled = true;
-				link_state[i].lh_nim_absent = true;
-				reported_link[i] = false;
-				port_disable(drv, i);
-				NT_LOG(INF, NTNIC, "%s: Port %i is disabled",
-					drv->mp_port_id_str[i], i);
-				continue;
-			}
+		if (!rte_service_runstate_get(adapter_mon_srv->id))
+			break;
 
-			if (enable_port) {
-				link_state[i].link_disabled = false;
-				NT_LOG(DBG, NTNIC, "%s: Port %i is enabled",
-					drv->mp_port_id_str[i], i);
-			}
+		/*
+		 * Has the administrative port state changed?
+		 */
+		RTE_ASSERT(!(disable_port && enable_port));
+
+		if (disable_port) {
+			memset(&link_state[i], 0, sizeof(link_state[i]));
+			link_state[i].link_disabled = true;
+			link_state[i].lh_nim_absent = true;
+			reported_link[i] = false;
+			port_disable(drv, i);
+			NT_LOG(INF, NTNIC, "%s: Port %i is disabled",
+				drv->mp_port_id_str[i], i);
+			continue;
+		}
 
-			if (is_port_disabled)
-				continue;
+		if (enable_port) {
+			link_state[i].link_disabled = false;
+			NT_LOG(DBG, NTNIC, "%s: Port %i is enabled",
+				drv->mp_port_id_str[i], i);
+		}
 
-			if (link_info->port_action[i].port_lpbk_mode != last_lpbk_mode[i]) {
-				/* Loopback mode has changed. Do something */
-				if (!nim_is_present(&nim_ctx[i], i)) {
-					/*
-					 * If there is no Nim present, we need to initialize the
-					 * port  anyway
-					 */
-					_port_init(drv, fpga, i);
-				}
-
-				set_loopback(drv,
-					i,
-					link_info->port_action[i].port_lpbk_mode,
-					last_lpbk_mode[i]);
-
-				if (link_info->port_action[i].port_lpbk_mode == 1)
-					link_state[i].link_up = true;
-
-				last_lpbk_mode[i] = link_info->port_action[i].port_lpbk_mode;
-				continue;
+		if (is_port_disabled)
+			continue;
+
+		if (link_info->port_action[i].port_lpbk_mode != last_lpbk_mode[i]) {
+			/* Loopback mode has changed. Do something */
+			if (!nim_is_present(&nim_ctx[i], i)) {
+				/*
+				 * If there is no Nim present, we need to initialize the
+				 * port  anyway
+				 */
+				_port_init(drv, fpga, i);
 			}
 
-			get_link_state(drv, nim_ctx, &link_state[i], i);
-			link_state[i].link_disabled = is_port_disabled;
+			set_loopback(drv,
+				i,
+				link_info->port_action[i].port_lpbk_mode,
+				last_lpbk_mode[i]);
 
-			if (!link_state[i].nim_present) {
-				if (!link_state[i].lh_nim_absent) {
-					NT_LOG(INF, NTNIC, "%s: NIM module removed",
-						drv->mp_port_id_str[i]);
-					reported_link[i] = false;
-					link_state[i].link_up = false;
-					link_state[i].lh_nim_absent = true;
+			if (link_info->port_action[i].port_lpbk_mode == 1)
+				link_state[i].link_up = true;
 
-				} else {
-					NT_LOG(DBG, NTNIC, "%s: No NIM module, skip",
-						drv->mp_port_id_str[i]);
-				}
+			last_lpbk_mode[i] = link_info->port_action[i].port_lpbk_mode;
+			continue;
+		}
 
-				continue;
-			}
+		get_link_state(drv, nim_ctx, &link_state[i], i);
+		link_state[i].link_disabled = is_port_disabled;
 
-			/*
-			 * NIM module is present
-			 */
-			if (link_state[i].lh_nim_absent && link_state[i].nim_present) {
-				sfp_nim_state_t new_state;
-				NT_LOG(INF, NTNIC, "%s: NIM module inserted",
+		if (!link_state[i].nim_present) {
+			if (!link_state[i].lh_nim_absent) {
+				NT_LOG(INF, NTNIC, "%s: NIM module removed",
 					drv->mp_port_id_str[i]);
+				reported_link[i] = false;
+				link_state[i].link_up = false;
+				link_state[i].lh_nim_absent = true;
 
-				if (_port_init(drv, fpga, i)) {
-					NT_LOG(ERR, NTNIC,
-						"%s: Failed to initialize NIM module",
-						drv->mp_port_id_str[i]);
-					continue;
-				}
+			} else {
+				NT_LOG(DBG, NTNIC, "%s: No NIM module, skip",
+					drv->mp_port_id_str[i]);
+			}
 
-				if (nthw_nim_state_build(&nim_ctx[i], &new_state)) {
-					NT_LOG(ERR, NTNIC, "%s: Cannot read basic NIM data",
-						drv->mp_port_id_str[i]);
-					continue;
-				}
+			continue;
+		}
 
-				RTE_ASSERT(new_state.br); /* Cannot be zero if NIM is present */
-				NT_LOG(DBG, NTNIC,
-					"%s: NIM id = %u (%s), br = %u, vendor = '%s', pn = '%s', sn='%s'",
-					drv->mp_port_id_str[i], nim_ctx[i].nim_id,
-					nthw_nim_id_to_text(nim_ctx[i].nim_id),
-					(unsigned int)new_state.br, nim_ctx[i].vendor_name,
-					nim_ctx[i].prod_no, nim_ctx[i].serial_no);
-				link_state[i].lh_nim_absent = false;
-				NT_LOG(DBG, NTNIC, "%s: NIM module initialized",
+		/*
+		 * NIM module is present
+		 */
+		if (link_state[i].lh_nim_absent && link_state[i].nim_present) {
+			sfp_nim_state_t new_state;
+			NT_LOG(INF, NTNIC, "%s: NIM module inserted",
+				drv->mp_port_id_str[i]);
+
+			if (_port_init(drv, fpga, i)) {
+				NT_LOG(ERR, NTNIC,
+					"%s: Failed to initialize NIM module",
 					drv->mp_port_id_str[i]);
 				continue;
 			}
 
-			if (reported_link[i] != link_state[i].link_up) {
-				NT_LOG(INF, NTNIC, "%s: link is %s", drv->mp_port_id_str[i],
-					(link_state[i].link_up ? "up" : "down"));
-				reported_link[i] = link_state[i].link_up;
-				set_link_state(drv, nim_ctx, &link_state[i], i);
+			if (nthw_nim_state_build(&nim_ctx[i], &new_state)) {
+				NT_LOG(ERR, NTNIC, "%s: Cannot read basic NIM data",
+					drv->mp_port_id_str[i]);
+				continue;
 			}
+
+			RTE_ASSERT(new_state.br); /* Cannot be zero if NIM is present */
+			NT_LOG(DBG, NTNIC,
+				"%s: NIM id = %u (%s), br = %u, vendor = '%s', pn = '%s', sn='%s'",
+				drv->mp_port_id_str[i], nim_ctx[i].nim_id,
+				nthw_nim_id_to_text(nim_ctx[i].nim_id),
+				(unsigned int)new_state.br, nim_ctx[i].vendor_name,
+				nim_ctx[i].prod_no, nim_ctx[i].serial_no);
+			link_state[i].lh_nim_absent = false;
+			NT_LOG(DBG, NTNIC, "%s: NIM module initialized",
+				drv->mp_port_id_str[i]);
+			continue;
 		}
 
-		if (monitor_task_is_running[adapter_no])
-			nt_os_wait_usec(5 * 100000U);	/*  5 x 0.1s = 0.5s */
+		if (reported_link[i] != link_state[i].link_up) {
+			NT_LOG(INF, NTNIC, "%s: link is %s", drv->mp_port_id_str[i],
+				(link_state[i].link_up ? "up" : "down"));
+			reported_link[i] = link_state[i].link_up;
+			set_link_state(drv, nim_ctx, &link_state[i], i);
+		}
 	}
 
-NT4GA_LINK_100G_MON_EXIT:
-	NT_LOG(DBG, NTNIC, "%s: Stopped NT4GA 100 Gbps link monitoring thread.",
-		drv->mp_adapter_id_str);
-	return NULL;
+	if (rte_service_runstate_get(adapter_mon_srv->id))
+		nt_os_wait_usec(5 * 100000U);	/*  5 x 0.1s = 0.5s */
+
+	return 0;
 }
 
-static uint32_t nt4ga_agx_link_100g_mon(void *data)
+static int nt4ga_agx_link_100g_mon(void *data)
 {
-	(void)_common_ptp_nim_state_machine(data);
-
-	return 0;
+	return _common_ptp_nim_state_machine(data);
 }
 
 /*
@@ -1009,12 +1017,24 @@ int nt4ga_agx_link_100g_ports_init(struct adapter_info_s *p_adapter_info, nthw_f
 	}
 
 	/*
-	 * Create state-machine thread
+	 * Create state-machine service
 	 */
 
-	if (!monitor_task_is_running[adapter_no]) {
-		res = rte_thread_create(&monitor_tasks[adapter_no], NULL,
-				nt4ga_agx_link_100g_mon, p_adapter_info);
+	if (res == 0) {
+		struct rte_service_spec adapter_monitor_service = {
+						.name = "ntnic-adapter_agx-monitor",
+						.callback = nt4ga_agx_link_100g_mon,
+						.socket_id = SOCKET_ID_ANY,
+						.capabilities = RTE_SERVICE_CAP_MT_SAFE,
+						.callback_userdata = p_adapter_info,
+		};
+
+		res = nthw_service_add(&adapter_monitor_service, RTE_NTNIC_SERVICE_ADAPTER_MON);
+		if (res) {
+			NT_LOG(ERR, NTNIC, "%s: Failed to create adapter monitor service",
+				p_adapter_info->mp_adapter_id_str);
+			return res;
+		}
 	}
 
 	return res;
diff --git a/drivers/net/ntnic/ntutil/nt_service.c b/drivers/net/ntnic/ntutil/nt_service.c
index 9f22ee2bba..c39771acc2 100644
--- a/drivers/net/ntnic/ntutil/nt_service.c
+++ b/drivers/net/ntnic/ntutil/nt_service.c
@@ -36,6 +36,12 @@ static struct nt_service g_nt_services[RTE_NTNIC_SERVICE_MAX] = {
 		.lcore = RTE_MAX_LCORE,
 		.initialized = false,
 	},
+	[RTE_NTNIC_SERVICE_ADAPTER_MON] = {
+		.tag = RTE_NTNIC_SERVICE_ADAPTER_MON,
+		.id = NT_SERVICE_UNKNOWN_ID,
+		.lcore = RTE_MAX_LCORE,
+		.initialized = false,
+	},
 };
 
 inline struct nt_service *nthw_service_get_info(const enum rte_ntnic_service_tag tag)
diff --git a/drivers/net/ntnic/rte_pmd_ntnic.h b/drivers/net/ntnic/rte_pmd_ntnic.h
index 1a68cb8e37..08e7958acd 100644
--- a/drivers/net/ntnic/rte_pmd_ntnic.h
+++ b/drivers/net/ntnic/rte_pmd_ntnic.h
@@ -45,6 +45,7 @@ enum rte_ntnic_service_tag {
 	RTE_NTNIC_SERVICE_STAT = 1,
 	RTE_NTNIC_SERVICE_PORT_0_EVENT = 2,
 	RTE_NTNIC_SERVICE_PORT_1_EVENT = 3,
+	RTE_NTNIC_SERVICE_ADAPTER_MON = 4,
 	RTE_NTNIC_SERVICE_MAX
 };
 
-- 
2.45.0

