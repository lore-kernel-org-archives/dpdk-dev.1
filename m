Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA76CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:42:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E67DD40B8D;
	Wed, 24 Sep 2025 16:42:11 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 570AC40A6E
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:42:04 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11023138.outbound.protection.outlook.com
 [40.107.159.138]) by mx-outbound22-32.eu-central-1b.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Sep 2025 14:42:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=itnsphglq0MkUpcRAuNGYbnPF0FzkFjPbYwNy1h4IZ1bGD/POmb3BiUXYSbSEZY28WuSNSq0YraKbwGYYpCxRvUkrjy247jW3mRm+XMg7rSaXDvgMruzbd8hiN0390VD8lGxdez0otLfOinXh/kSwjcCaRlkzpEUCFmicVbnfg5dqOBDniiTxt/jlYfG+QGBuidpUEvXTs1J+7oDc2oFaIYRyge1owd5WCOitVzQF0DU3Plb+ErECba0HFZ3M0PINM3fANVOkf+H4THauZdUSqZpLMZCYdBqoXru7pDz6lqyHpB5FtS9sc+XXylO75329hN89zNGFTcxVcIhkwG24Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xRN7x++kI2XgC/c6uvGyR4i3R1LkUg/QKm3V1H2fz4=;
 b=hAR/iJFJoW814BAfZwb7H5IP6cCfTEnB9AALiHclYsApqZSHhEFDjKRCH/O4JcbvPCcC6/ro4pbEksPFK7r5s8fuNCCEvfSKjKjyJZtd8uLyUnU6OQs69U4FhqySfqBTsFu7bby3bMsibDHj2VTFf5MGo/drYyV4cGyMKzpDU5No49v5/Df3ug6Kq3xzDlsBQ+KCzV2KKs8HXac66wHKky/F/ip1ALjKhcFgzI53iN6FsyM0Qs5kE4lccGypkgYuHWPBxGn8c1e1koDdvEEwGPuNoDcEayMagjS3nHvdjjSBxE+KFNrJby3cHM1xVAeoVAGfpC2hlzVqFNoHzNu4Hw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xRN7x++kI2XgC/c6uvGyR4i3R1LkUg/QKm3V1H2fz4=;
 b=NjPbRm3QomvbMlLo1YED9RBdRCEjgAhFG3x+r4JrISE6RGkmXN0SZSDNXJTZOCz3vYDL3CEkQW/5fsomLEBpvMorSGg/w1nBOYuhrZvaWkvo2vjqLldCDVG+PbbseXpk6+MN6eRJ8TKypm/LoLQ9jvphxGwt0sAuyLc/8nVmMp8=
Received: from CWLP123CA0232.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19f::14)
 by PA4P190MB1101.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:102::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.17; Wed, 24 Sep
 2025 14:42:01 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:400:19f:cafe::ce) by CWLP123CA0232.outlook.office365.com
 (2603:10a6:400:19f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.21 via Frontend Transport; Wed,
 24 Sep 2025 14:42:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 14:42:01
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 07/24] net/ntnic: avoid using thread API
Date: Wed, 24 Sep 2025 16:41:30 +0200
Message-ID: <20250924144152.53203-8-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250924144152.53203-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20250924144152.53203-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|PA4P190MB1101:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: d049e244-9c0c-4434-0cdf-08ddfb7885d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?m/KBPo4w9WIHS5zZTEtu/Inj2PUfa8TZWMOgBAk8eIxQdhgRm6lKudFXRR36?=
 =?us-ascii?Q?lHISlk3N91z9uLzkY9Jh6LFVeSOacDS59+2FADAqIUEZgZr+XRgggSVwTuGb?=
 =?us-ascii?Q?7UmlgG2msU6yv+bUXU8QNe+OOvfJMsLGz6jn73Bse0DvRuJMDSe7w6n1FAMT?=
 =?us-ascii?Q?rwjk25Mf1hllx/XLn9MEIoFl3InGAju4P81IocwWI4fXrqiT9BqWZo1AuXuc?=
 =?us-ascii?Q?p35AkdLp16Nkpz55XYVKCc9DezXzyR0H9jgSgPsw3zlTATGzqEZs807U/yFi?=
 =?us-ascii?Q?IZ52sqL/g3dLHZvuzdRKVitC1aYFqr/48b+l02S81HN+k+o+lTU204wcfuQT?=
 =?us-ascii?Q?ocY1krF5i5R2JD26O50VX83k+9G5LvjIlPD+sSfwsowJZA0p/aWwKZKMgvxz?=
 =?us-ascii?Q?jCqfBa+64XIiN/n4bxwCnV4Vs2sP+RPUHZ0suM8UnwQMZSicawf6Bmp+RLFM?=
 =?us-ascii?Q?2ZUhLKiRn5/QAYZ2GmsBNs0RG7m1SxeD5t2Ra2Awfqg0GVo4io9RvH1EV5tT?=
 =?us-ascii?Q?mGIX2GRYE8qMyzAXcvRjKE/Tu/YhVcGnj2i3xvot/vMrXch5GEkF8xeVNbZD?=
 =?us-ascii?Q?SpE+t4fuKmXlw0pOu60OmZBfEK+W08QaFIIWfjIv+HuMk/35IRJ3cd8UmtXg?=
 =?us-ascii?Q?7pFaz+3R2IAGmiSP2rD7P0QEeB7IriDtmXXYi+go5Yu/G4BsrsH1YjRcmTDQ?=
 =?us-ascii?Q?Ga64eyxJBfTa8k3reyhsMMRqy1rNR/vsJ3hJCaAd3grzxQiyeUeUU0fLuazl?=
 =?us-ascii?Q?9StpvNOtOdHU91JOwV22cxF+Pv9z5Nf3W32VzcJoB9mkFJGIYYT7uN44HHto?=
 =?us-ascii?Q?t8Hpoue1kFh238z6OsXLLUAOhFnXbVBJIBJs9q26O6iEAx28rSHZYCD1o1qe?=
 =?us-ascii?Q?2vSRxF3RB0+ebdOV/07mDLVpBHV63N4gf+uZygAAtsYu2mBh/deGRQSLQGJQ?=
 =?us-ascii?Q?QUWkp8cYhdCuFdVfdQ1i+wYuQtytyD9gIjHK8ButowoDP6s0PlYacO2p2ezS?=
 =?us-ascii?Q?ASK0iggc6u0YFHQmrh8hENUsSod1D2I+TsGjU8vBBH6Zj6BCYdkUkCIHqciq?=
 =?us-ascii?Q?Epn3DZpqVCMW7xHwd3Rgvvyaw1RKAHtWcv9RgenGaazE+mCOasxCZYsnYOgA?=
 =?us-ascii?Q?8nV5LZuuabqZtt03s+/j7LjzVKivs3zDZFMlkU07HArgxCloMxjYWtlMnVZB?=
 =?us-ascii?Q?0sPuklZRDfvXfkrB/gtHX4u2rKN2ywz2jlD7XC8+hZHCm4YqSsN53JCvA55+?=
 =?us-ascii?Q?TEDm8lsd+1na7/5ncoHX/0E8T01QFIhDDRiM35ThfeN6dyBqXxjpZOYq5m4U?=
 =?us-ascii?Q?tk8nf6wU9mEbUrFarS08ak9dt0am+WrsZpq09f5kcWUV0r8JUNloNYMte5bu?=
 =?us-ascii?Q?r893JWehRuVPZLwnLIAetZfbRTAYJN/lnCDDyOJ0S/FNa20IiJnJ1vWt4dbF?=
 =?us-ascii?Q?sGpbZ9EJuWb+wyurCDAmoCrq4bcsILDHxw6zPpN0qQSI3xHvdWzxp72MdbVZ?=
 =?us-ascii?Q?h14h64HGwitQsdq67svkzVykXkkU7LUHoecW?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Np7i+UcGvrxAZbEbEu1cefptywbFSkVy2R7t+NAQpOUgEOnWgBuRUXZjgBtqjDabiirnTYqdn5LmrSiZfjZ+ac6Jv3aZdTUlwTweMAgYXmtPsCxGDqIzVrvNVnR9osr7w4yM1uDYxLbESt/5MQwHyljVw6SPCKtm/1gkvpZYRaJr939AW1lnFh+Pk7zIq5RUGOPi7qAPoPjsZxgF+7IU+Jt+QC8rxX+uc28Ejz4v12YfpRVhyvTV4PNFb/LTQPq85wRyCN39aqQhhqlPq9LH6CwXg3zQsaCiH0bHB6a0WzeaFMFZb6GptHoCXeY+Us55h6fV3Vmyc4CQvyTJ1UBarMErCJ0YHhXUIBr1us4JCM8PzoiCAo3cXPQGVvq0kJ7wkNc4jvad6bEWGrmPVLLzrG+oY9hjyY2AMy+hk6qGO7paMeQcopgxyDPcid15sJQjrm79+raRzDLJdPqi8ZOQfC/7eLjnauwPEG3ePeEFURK5QcDx2netfy6xLzeyCASiwtRw0nByPCc1ZaRRTD0oxZuaVQVqD6IgOfJc6dn0RdMZ7NpFDJoUoGJPtsqIrGyYnitVcrFc7KYY8mYuGRLygm0/QBYITXVM3O4Mrq/eZC0wvjwuVBc0/w1hvIgviY1sEX6quHoLHZZz0F2uN9IRTQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:42:01.5338 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d049e244-9c0c-4434-0cdf-08ddfb7885d4
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P190MB1101
X-BESS-ID: 1758724923-305664-7607-8011-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 40.107.159.138
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVubGZoZAVgZQMNky0cTY3DjVJD
 kpOTnNPNkkLS0tydTA1NQ8NTXN0shQqTYWACFsmFVBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267723 [from 
 cloudscan17-191.eu-central-1b.ess.aws.cudaops.com]
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
Instead it uses service lcore.

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
index 40a8d2b2dc..a867e7b16d 100644
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
@@ -2632,7 +2620,7 @@ nthw_pci_dev_deinit(struct rte_eth_dev *eth_dev __rte_unused)
 	fpga_info_t *fpga_info = &p_ntdrv->adapter_info.fpga_info;
 	const int n_phy_ports = fpga_info->n_phy_ports;
 
-	/* let running threads end Rx and Tx activity */
+	/* let running services end Rx and Tx activity */
 	if (sg_ops != NULL) {
 		nt_os_wait_usec(1 * 1000 * 1000);
 
@@ -2707,7 +2695,7 @@ nthw_pci_probe(struct rte_pci_driver *pci_drv __rte_unused,
 
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

