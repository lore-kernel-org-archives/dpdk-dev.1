Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B699CAC581
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 11:05:53 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F48E4066D;
	Mon,  8 Sep 2025 13:05:21 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id D9C4640655
 for <dev@dpdk.org>; Mon,  8 Sep 2025 13:05:17 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11021136.outbound.protection.outlook.com [52.101.70.136])
 by mx-outbound18-209.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 08 Sep 2025 11:05:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cT18ib1Sn4AjbM+4Ua6hyLkBrOXMHEsXRQMALEB+FP92u48S7wrZbCxgOpjLosFY1IY4BPa27fEDd1Pyp5FCfquRiyfKf1hppIvjTqHCXAFOa26N011qve5xpmHmRuBgvpfKgzJU5Vp5kKHBoJKmIahd+8MSTdH1j/grHYqaB9qcFlj6/2YIrxkPCef28KGBEZSFZJh2adkmxr/mVztWCmx0tKpB860nq9zUC+XhFZEtHCDjApXeLEUFQBqDwtCWOAp3qCyvqftRQFZxItk8PTIB+zXSWuKP93szZiZcwID9koU0TWw+rZ+oeQmSCqNpQnXlTDKz9EKlmvdUrvhUhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIo+Vk31/yLUysNI7HrARQ0CUOfQUWCjS+QYIDO2ORo=;
 b=JeALGmSKy9aK/pPk0A4frse5clB21gkVbmJ0QtBOvrI+NS2Omlv2mmk0b39bgPu4I7CX53+/mVMaXHnVQcU2sbivo81KqM+7zUy5fWeNsgDKrHpF03pVyk0CsokdaOc4DB+rP5ra2PnGy0TJDYEVGcnyrNNHT/x3JvfyWdnhAy6pyo3IIbG+jeKKEfMWtyIERqxs5ta8oLQycQzI4Zui4T8q7XIGliY4fG2pHnArUhgFnC2Lm8Ft8wPPcK4iPX5D4gGrnGaa9GmRhqeDSSMRkk4MjEDM+Jqs54fzWbJ0+ti6kz0t3hKuGiV1quKyH+ANn6bQXkjhok3T8HjGHsTfmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIo+Vk31/yLUysNI7HrARQ0CUOfQUWCjS+QYIDO2ORo=;
 b=FQidEFz2HXliu8QBrFSHAXoW+yE376gPcBIYUGMX9uUIFJnU7PTFqETdRA1LLgCavpetTEXBExef3ZztMlckKBwSXllZFozQR5JrA/45DvQmOBZYGx9tFOZctqluURI9bxgf/wxI5+NFKMXEy25HILFRYNBg0m3OF5gCX2mbrog=
Received: from DU2PR04CA0350.eurprd04.prod.outlook.com (2603:10a6:10:2b4::22)
 by AS8P190MB1159.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2e0::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.22; Mon, 8 Sep
 2025 11:05:15 +0000
Received: from DB5PEPF00014B97.eurprd02.prod.outlook.com
 (2603:10a6:10:2b4:cafe::57) by DU2PR04CA0350.outlook.office365.com
 (2603:10a6:10:2b4::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 11:05:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DB5PEPF00014B97.mail.protection.outlook.com (10.167.8.235) with Microsoft
 SMTP Server id 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 11:05:15
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 7/7] net/ntnic: cleanup using pthreads and rte_thread
Date: Mon,  8 Sep 2025 13:04:45 +0200
Message-ID: <20250908110446.1071964-8-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250908110446.1071964-1-sil-plv@napatech.com>
References: <20250908110446.1071964-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B97:EE_|AS8P190MB1159:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bab3825c-98a3-4da5-5ab1-08ddeec796ca
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?t+5ilA3Er9xQP333ertLxF5yMsHd/Y/Rt3kwxF0QEi3ie4BuTN3cI0dDT6K7?=
 =?us-ascii?Q?4uOJRHkmYqDyJ/UU+H5ziLclb8GbZ15cY99c+BVDdrBEoYG5/WbB/xpwVxhJ?=
 =?us-ascii?Q?G5McS6ZxSkLq/r4PbXCg4BTpQXIUN25VQxLbnz2Lx24Ycb1l7kNMjmpxAQX2?=
 =?us-ascii?Q?rb2qaQ65Sk1EeA+2WGmU8qyn/7lCGNV41W2xOaSEnCXsSzl4Xg6kZ8YdywT2?=
 =?us-ascii?Q?MQtEthvfEvmj7TfykjwPmvjG2Evs2PYziepjoRVwbSFzId/ivkdQyJpHNE7/?=
 =?us-ascii?Q?r/ZUL7Cel4UyWUFBSTx8jOgSvAebjWhttI/zj8iTJE7dOSC+jkuE8AB53zvr?=
 =?us-ascii?Q?qnC+W50NCPatANxIOPbui9kEk9RVP2BvjRrQyPqIW9N+nChF4IF2qSpd0ISA?=
 =?us-ascii?Q?leR39zYQAuOu/2i3wkiZQIW5Z4O9/28CEXUxWH8R6mgeQeb21E1qXcJDjskh?=
 =?us-ascii?Q?SQ/wbzdb9isUGxvG+/Lg8ZwkrhGQ861OkwWlG65Tl3DU5ya/7rLhibzhws2v?=
 =?us-ascii?Q?8Zn+2X1eTfF9PCgzAzdVVcQcF/WbxzF/6iuqASJAlx++OS0KcpHQkoLlgt8X?=
 =?us-ascii?Q?GKXgWFNFdEJHuI3q+nSYbNsIsYEMbx/TeAQbMO4va0VXVnYB4VKXNzPMOKng?=
 =?us-ascii?Q?k507TxjJHOpbnptwW61iJltjZe3zTLxJk/9jk1BPA7WEwez/5t4lcYotg2TP?=
 =?us-ascii?Q?bUXQBOuAHtFPDE0CjymC8IZWpOUk6NIBBywIk1GzJdjoShSEUz+D2/avlrCV?=
 =?us-ascii?Q?uLka7ajpdnuAVYuiGZ8nfry4cvSEsZYepic+PlUzctQNhld+3I6NJ/zncznn?=
 =?us-ascii?Q?IxbnQQzJ9FE2TWpF0Lws4PtZrdtiq/awvj+1XIsx5Y/d32vKRVSTmW1O/IK7?=
 =?us-ascii?Q?yhdQsRj8PfXm9ohQxFJou5lPdLlEb+PC8XEJzpbnzoUc1cBUOB0hIworAtCy?=
 =?us-ascii?Q?aCrcrdSli+RkcrvHvhaNKZya3Oisj2XsBRhfNALfH/um4YgJkniskF0WOklp?=
 =?us-ascii?Q?fi6j1z0GfcDyH9UwXOcpqbYRculA3lNzdE+RGb4m8AuPHnmDYWYWB+uyS4Bj?=
 =?us-ascii?Q?CSkvLCW7XLef2pW2okaRUU9HRQu1r3wv/9aShv0/46ViSEWhQ3BsdWFnvvip?=
 =?us-ascii?Q?dyFq6zRp6rK9C+nxwqUgrgBLkhfc5uzk+o6Op4tbwHMqMwjFqx/X5g6cNYJy?=
 =?us-ascii?Q?N15SyAdv4zo7svIsxz8KTsDOS/qWayA/O02PFqdmHCWD7nxVWbwfjXNF2or1?=
 =?us-ascii?Q?XKVXDO+c3EGr7w52g4h2TkQ+cF9WRYwjFjD7YOEFeCKnMYTL+oYQsu0Vw4PU?=
 =?us-ascii?Q?DBqvk8FpLhL4O8OcntEVHpteng4k2Vxi1vOx1c5MUHkPpN56CVtsZICTTpmj?=
 =?us-ascii?Q?ZzZFA8MKu3FY5S1UpK43BbwC9IQ/qpgnFBNtp5kStLwPpEJuWM6St7heW63s?=
 =?us-ascii?Q?qyWxAzXxKq8BSHry7fasJEz++bYl3rX/flofmwewnAHU+Rvm88HV1Vtcgqy6?=
 =?us-ascii?Q?GQodq3wxUYSdZjBjBp851yqicqwsTfugmrSs?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: L112A+RP4nIQscZFlKrV2R58pPYuDYHxvx3TbDDbWzISA+HFfATgQ5DQ0fYLaT5d/tmnn1l5Xbs70SlzLpWoGZBzEpVxoi1RI0pjTqvWFdX1D3P7Va00qdnpV+1jkHWr85gEDfMQbeE4JPVXd4gBmgXddc3OrtgUopusM0x9Gxs75GqdECzepc0hLTTGhya5jN0KNF+1yetflV2RKlasGGFzFo6n807OU9EoutG4K48ndvdLhUC2GgPjy0co9Sdv88xoWe/6hJ1FMQblWSkhuqB4LJZilE2hmkCZuYJkByHX9CLh4uh/73ayc9/LjE/DDOQQFlbhSWQ7dUOsqhZaRqANY3AcTQ8//Jfc+ARBk7kOsWaCg74vUysnRnSatZvrlbDjN1fqLOSqPdlG9/8RFXpFU+4V+pmWQuJkwzQbxz/PhULWF5AIs0M+gX/xBHnk5dOwXVP3VTQa40SpolqAKnHwDqSEXUAaLvom+vtO/7S9ZQuspMLFSO7CM1Lz10VU0lQs4rfq6qlMVIqy2X0+LhRX4tjTL3KTZCRA9nEXk+0jUQeGXWusOUgBACTgBuwqcQd7ie1fbJMHOB4I+60TJVmIwnNONG9avpgvUN90mdleWWTqTORITT5u+bI5IemNGa+CeAC/x36f22wwGj1I0A==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 11:05:15.0806 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bab3825c-98a3-4da5-5ab1-08ddeec796ca
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DB5PEPF00014B97.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1159
X-BESS-ID: 1757329516-304817-7670-4012-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.70.136
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVubGxgZAVgZQ0NjA0Mjc1CjVLC
 UlKdEsKdU8Ockg2dTM2MjQIDHJzNhCqTYWAO6ACNJBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267333 [from 
 cloudscan17-113.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
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

This patch cleans up the code to use pthreads and rte_thread APIs.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/adapter/nt4ga_adapter.c     |  2 --
 drivers/net/ntnic/include/nt4ga_adapter.h     |  1 -
 drivers/net/ntnic/include/ntdrv_4ga.h         |  1 -
 drivers/net/ntnic/nthw/core/nthw_pca9532.c    |  2 --
 drivers/net/ntnic/nthw/core/nthw_pcal6416a.c  |  1 -
 .../net/ntnic/nthw/core/nthw_si5332_si5156.c  |  1 -
 .../profile_inline/flow_api_profile_inline.c  |  2 +-
 drivers/net/ntnic/ntnic_ethdev.c              | 22 +++++--------------
 drivers/net/ntnic/ntutil/nt_util.c            |  2 +-
 9 files changed, 7 insertions(+), 27 deletions(-)

diff --git a/drivers/net/ntnic/adapter/nt4ga_adapter.c b/drivers/net/ntnic/adapter/nt4ga_adapter.c
index 363874c85f..de4e8707bf 100644
--- a/drivers/net/ntnic/adapter/nt4ga_adapter.c
+++ b/drivers/net/ntnic/adapter/nt4ga_adapter.c
@@ -3,8 +3,6 @@
  * Copyright(c) 2023 Napatech A/S
  */
 
-#include <rte_thread.h>
-
 #include "nt_service.h"
 #include "ntlog.h"
 #include "nthw_fpga.h"
diff --git a/drivers/net/ntnic/include/nt4ga_adapter.h b/drivers/net/ntnic/include/nt4ga_adapter.h
index 6c701b601f..0598e62b7b 100644
--- a/drivers/net/ntnic/include/nt4ga_adapter.h
+++ b/drivers/net/ntnic/include/nt4ga_adapter.h
@@ -40,7 +40,6 @@ typedef struct adapter_info_s {
 	char *mp_port_id_str[NUM_ADAPTER_PORTS_MAX];
 	char *mp_adapter_id_str;
 	char *p_dev_name;
-	volatile bool *pb_shutdown;
 
 	int adapter_no;
 	int n_rx_host_buffers;
diff --git a/drivers/net/ntnic/include/ntdrv_4ga.h b/drivers/net/ntnic/include/ntdrv_4ga.h
index ee0e66c4d4..4ff1f115f4 100644
--- a/drivers/net/ntnic/include/ntdrv_4ga.h
+++ b/drivers/net/ntnic/include/ntdrv_4ga.h
@@ -14,7 +14,6 @@ typedef struct ntdrv_4ga_s {
 	struct adapter_info_s adapter_info;
 	char *p_drv_name;
 
-	volatile bool b_shutdown;
 	rte_spinlock_t stat_lck;
 } ntdrv_4ga_t;
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_pca9532.c b/drivers/net/ntnic/nthw/core/nthw_pca9532.c
index af14cd6d06..805e0275e8 100644
--- a/drivers/net/ntnic/nthw/core/nthw_pca9532.c
+++ b/drivers/net/ntnic/nthw/core/nthw_pca9532.c
@@ -3,8 +3,6 @@
  * Copyright(c) 2023 Napatech A/S
  */
 
-#include <pthread.h>
-
 #include "nt_util.h"
 #include "ntlog.h"
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_pcal6416a.c b/drivers/net/ntnic/nthw/core/nthw_pcal6416a.c
index 2fca469497..f7efc196f4 100644
--- a/drivers/net/ntnic/nthw/core/nthw_pcal6416a.c
+++ b/drivers/net/ntnic/nthw/core/nthw_pcal6416a.c
@@ -2,7 +2,6 @@
  * SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
-#include <pthread.h>
 
 #include "nt_util.h"
 #include "ntlog.h"
diff --git a/drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c b/drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c
index eb11ebc67a..537d58afb7 100644
--- a/drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c
+++ b/drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c
@@ -3,7 +3,6 @@
  * Copyright(c) 2023 Napatech A/S
  */
 
-#include <pthread.h>
 #include "generic/rte_spinlock.h"
 #include "nt_util.h"
 #include "ntlog.h"
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index eaaf681ac6..2291642ca9 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -5276,7 +5276,7 @@ struct flow_handle *flow_async_create_profile_inline(struct flow_eth_dev *dev,
 			} while (status == CELL_STATUS_INITIALIZING);
 
 			/* error handling in case that create_flow_filter() will fail in the other
-			 * thread
+			 * service
 			 */
 			if (status == CELL_STATUS_UNINITIALIZED)
 				goto err_exit;
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 664112f67e..0f70462f3d 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -6,8 +6,6 @@
 #include <stdint.h>
 #include <stdarg.h>
 
-#include <signal.h>
-
 #include <rte_eal.h>
 #include <rte_dev.h>
 #include <rte_vfio.h>
@@ -33,12 +31,6 @@
 #include "rte_pmd_ntnic.h"
 #include "nt_service.h"
 
-const rte_thread_attr_t thread_attr = { .priority = RTE_THREAD_PRIORITY_NORMAL };
-#define THREAD_CREATE(a, b, c) rte_thread_create(a, &thread_attr, b, c)
-#define THREAD_CTRL_CREATE(a, b, c, d) rte_thread_create_internal_control(a, b, c, d)
-#define THREAD_JOIN(a) rte_thread_join(a, NULL)
-#define THREAD_FUNC static uint32_t
-#define THREAD_RETURN (0)
 #define HW_MAX_PKT_LEN (10000)
 #define MAX_MTU (HW_MAX_PKT_LEN - RTE_ETHER_HDR_LEN - RTE_ETHER_CRC_LEN)
 #define MIN_MTU_INLINE 512
@@ -1536,14 +1528,13 @@ drv_deinit(struct drv_s *p_drv)
 	fpga_info_t *fpga_info = &p_nt_drv->adapter_info.fpga_info;
 
 	/*
-	 * Mark the global pdrv for cleared. Used by some threads to terminate.
-	 * 1 second to give the threads a chance to see the termonation.
+	 * Mark the global pdrv for cleared. Used by some services to terminate.
+	 * 1 second to give the services a chance to see the termonation.
 	 */
 	clear_pdrv(p_drv);
 	nt_os_wait_usec(1000000);
 
 	/* stop statistics service */
-	p_drv->ntdrv.b_shutdown = true;
 	nthw_service_del(RTE_NTNIC_SERVICE_STAT);
 
 	if (fpga_info->profile == FPGA_INFO_PROFILE_INLINE) {
@@ -2323,9 +2314,6 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 		p_nt_drv->adapter_info.hw_info.pci_sub_vendor_id,
 		p_nt_drv->adapter_info.hw_info.pci_sub_device_id);
 
-	p_nt_drv->b_shutdown = false;
-	p_nt_drv->adapter_info.pb_shutdown = &p_nt_drv->b_shutdown;
-
 	/* store context */
 	store_pdrv(p_drv);
 
@@ -2366,7 +2354,7 @@ nthw_pci_dev_init(struct rte_pci_device *pci_dev)
 		NT_LOG_DBGX(DBG, NTNIC, "SG module is not initialized");
 	}
 
-	/* Start ctrl, monitor, stat thread only for primary process. */
+	/* Start ctrl, monitor, stat service only for primary process. */
 	if (err == 0) {
 		/* mp_adapter_id_str is initialized after nt4ga_adapter_init(p_nt_drv) */
 		const char *const p_adapter_id_str = p_nt_drv->adapter_info.mp_adapter_id_str;
@@ -2631,7 +2619,7 @@ nthw_pci_dev_deinit(struct rte_eth_dev *eth_dev __rte_unused)
 	fpga_info_t *fpga_info = &p_ntdrv->adapter_info.fpga_info;
 	const int n_phy_ports = fpga_info->n_phy_ports;
 
-	/* let running threads end Rx and Tx activity */
+	/* let running services end Rx and Tx activity */
 	if (sg_ops != NULL) {
 		nt_os_wait_usec(1 * 1000 * 1000);
 
@@ -2706,7 +2694,7 @@ nthw_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 
 	/*
 	 * 1 time calculation of 1 sec stat update rtc cycles to prevent stat poll
-	 * flooding by OVS from multiple virtual port threads - no need to be precise
+	 * flooding by OVS from multiple virtual port services - no need to be precise
 	 */
 	uint64_t now_rtc = rte_get_tsc_cycles();
 	nt_os_wait_usec(10 * 1000);
diff --git a/drivers/net/ntnic/ntutil/nt_util.c b/drivers/net/ntnic/ntutil/nt_util.c
index df382e7a24..a4d30d8ca4 100644
--- a/drivers/net/ntnic/ntutil/nt_util.c
+++ b/drivers/net/ntnic/ntutil/nt_util.c
@@ -16,7 +16,7 @@
 
 static struct nt_util_vfio_impl vfio_cb;
 
-/* uses usleep which schedules out the calling thread */
+/* uses usleep which schedules out the calling service */
 void nt_os_wait_usec(int val)
 {
 	rte_delay_us_sleep(val);
-- 
2.45.0

