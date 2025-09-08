Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D92DCAC586
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Sep 2025 14:18:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15D1440A7A;
	Mon,  8 Sep 2025 16:18:03 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id BC82940671
 for <dev@dpdk.org>; Mon,  8 Sep 2025 16:17:56 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11023111.outbound.protection.outlook.com
 [40.107.162.111]) by mx-outbound8-132.eu-central-1a.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 08 Sep 2025 14:17:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PfsGjaWKMgsfJpXkhClbqTuhcsft6MxE8MYF2Y8je5X8N/JWos/sdQwaD7FR12wIbyvfuf8UEyXuQR4GBCoGviEtxvRGeoijR52p4O5iMFFznulwnV4gAzscjkMJWOzsuBGVlk12CwdFhwLV6DtBnTDVio49UfR60N0jjI4zZzWSe/m6MbixMWJuzv1U0ly0LPnDuuMogn45vO3TnyyaSQqqxWTPZWLQpS1G6eFVeH0axk/hka3nC68Jyhu9OhuDqBFjrIbgr8g0t7dnSDo/KXa/1jhj6onbvRrE3XE4XIUmY3yw8JRretIdDvwd/WMQBJR94tXFYaGHuOqlKFyo0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eIo+Vk31/yLUysNI7HrARQ0CUOfQUWCjS+QYIDO2ORo=;
 b=LNt4+p17QPigNM2MP2kNmtiK++aBE6V2gXddIgIP9NfcfE3gC5/H//Q7by7/7Jq2xToiDqURguySrqJCBxTOPCb9ReJoEEA6qLfMN6rV6iZJd6GycDZZ+1K1htYULZ7Tufv/E7Z9wtyr8GRjEA3Wunz86vM/Tm8UPW+zIvbEqdmdUxvLB9XddVa2XG1ASb2sCiqikQcdt2YEH3GU5abi18L5U3x8ph9Cv6y6P3PWPw7y1aqYRBekdJgtrUECT96e2auE3UwdXY8yaqZJo8MPVHWtbWhp2O08IZjnedwGnlT81w7IPjBRLXZyx4l8Qm6vOz9De9pc99zs46pqyOj+mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eIo+Vk31/yLUysNI7HrARQ0CUOfQUWCjS+QYIDO2ORo=;
 b=Xc7wpFxg52ybTPvFEFefMPlanEIpTj+wxtuSzdWcmnxZOZln2I5RZPzjA0yZrNd1u7rFfHKchG3nQmPSUGUBsOReTWqk2ITzGuTo6lBlXWNE6pCNz/KPiKaRPaJqaajF5OZiwqDbNDzybkVctPta4fjgtvh0IGM/BBpCwlWoqtA=
Received: from AS8PR05CA0015.eurprd05.prod.outlook.com (2603:10a6:20b:311::20)
 by GVXP190MB1869.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:3f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9094.19; Mon, 8 Sep
 2025 14:17:52 +0000
Received: from AM3PEPF0000A798.eurprd04.prod.outlook.com
 (2603:10a6:20b:311:cafe::25) by AS8PR05CA0015.outlook.office365.com
 (2603:10a6:20b:311::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9094.22 via Frontend Transport; Mon,
 8 Sep 2025 14:17:52 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF0000A798.mail.protection.outlook.com (10.167.16.103) with Microsoft
 SMTP Server id 15.20.9115.13 via Frontend Transport; Mon, 8 Sep 2025 14:17:52
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 7/7] net/ntnic: cleanup using pthreads and rte_thread
Date: Mon,  8 Sep 2025 16:17:39 +0200
Message-ID: <20250908141740.1312268-8-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250908141740.1312268-1-sil-plv@napatech.com>
References: <20250908110446.1071964-8-sil-plv@napatech.com>
 <20250908141740.1312268-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF0000A798:EE_|GVXP190MB1869:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cf52275a-2169-4485-e32f-08ddeee27f45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?26QIwAiBBH85sA9j9NS5rSMkokaDcUIS6PQnGnsWLlbAlv8aQPwR2vAEvgwx?=
 =?us-ascii?Q?9875rbB+X/0msgOnNEkS43GqQao0k3YYjWGMoxCb7zQAJYkPG4vQ9LEg5U5N?=
 =?us-ascii?Q?0Y4KQ3nqJ0FK2+tCzSOToBH1WSk4hXt3bCw2YAyiQBeTFQBgzYdlgE8rEmpt?=
 =?us-ascii?Q?Av5C58yV09TYMuqiQuqahBQZKVz4/8cPS6FxnFdLhpaw7Hscpwf2brnvZz8H?=
 =?us-ascii?Q?Tg7EJRc2kAfMz0nNxxhJknLIjnXWTuQjbePVlbNb1jLjJCiRGkClj0zix00H?=
 =?us-ascii?Q?a1XcIuLyfbbrvT7VXXKy5wl4JsPRz4ZmKG/q6xaJXJD5GvUT8sQCbhRH6enq?=
 =?us-ascii?Q?eP992xRivJEjiGpS0zAabCI3ZS8ubS/Dw+tkrdYFW4ha1KzwPN8Xum0qA0E4?=
 =?us-ascii?Q?+WdahqY1anXKIUDA+3tJl5g+T2McLGSsvGRQe2qhFuvvgKmNP7CEyDqxRLoU?=
 =?us-ascii?Q?TiGJ474INjSCjAr2VcNCVyQC64FizsGOSItIjgsW0W7THzK8w7rsRTXraP3j?=
 =?us-ascii?Q?dgSepLfBTMIT+s4azEqn2PLtJWApRnlHf1c7+JBe+hUdQceDu4cUcrhNg1K7?=
 =?us-ascii?Q?DwEx50WmU8jm1a2FcwENCyCRpFcJSC6o9FA80gVE+ePjXrT9OsMlhYgsjgGW?=
 =?us-ascii?Q?gR6k68PB1erOtXJHtcAC5xL0Jcsxb6ftSIBcFdBgJWXmfcbkLFlurXFGnSO2?=
 =?us-ascii?Q?0JNm6L7ZfQ9mF3phn/UQxqHk7/7pOTUfDT4GYhw1Ab6UH3X5xvYOjJeGuDpn?=
 =?us-ascii?Q?qsWV/DOXH17dktXO2kRFVBB/lNzZKCZxgIiulSxsNXThd4qhJmj1t2G5PVGt?=
 =?us-ascii?Q?eJWtYdBKOk3s3bUO+4k5dFxeTTBSZxShrTh2V8J5X0Kk26qttJjS5xu6horU?=
 =?us-ascii?Q?J3kyqD5XV81XyKu7lol44WMUwbFr4ibQQ7xUi6NtxWfTisN4WxVR7VhK13pW?=
 =?us-ascii?Q?9KXeXEXW1rrDZxwNPzQOTlUQWcL28Caff3W+vJwW3hz8eLhrpIbtsUo3CWxF?=
 =?us-ascii?Q?wBeGt+tnP8BkTFKzpJmohuhbo4fyV+X//3/wdGs80XRfVpJWLvEkLHkrzSE+?=
 =?us-ascii?Q?WP3Z0yG6vMbHBJdGK0ucDOa6zzbwaJ/3irkCiAbwReCEd9D3zvxzZyZvXKkj?=
 =?us-ascii?Q?HSnp5VEIPeSZySGL8oDY4EoCA/I8z+yQRpWmQm3riJR7v9jYeD3Su2N60hHW?=
 =?us-ascii?Q?q2mKyP56IqcbAZfA6jwAOSIzWbsZlYSvxR/usB8xHslXmvphpxLvT/yoJRKD?=
 =?us-ascii?Q?H9SQyhoCoUsLDu1jMRKfDrxWvaniqYBBpkwpYuKd47JfkGaDlsyNbnrBkUJZ?=
 =?us-ascii?Q?6N5amW1j8e4vA4U1Zy0wU4iZZ3pp+btlxLDfQEeiaWXBfwlT1bkrv+LRMXFy?=
 =?us-ascii?Q?K/JvWI5+Y51eeCgXhBi0ahliu7AuwWcEBkplLMCAs994alRGc2NU7CyBeKSh?=
 =?us-ascii?Q?9DmG6a3U8E/mijRpCUO9Fnk8atzXGzoTtRCW5qllB81WR0bJ4qun9n6ExuTM?=
 =?us-ascii?Q?SRqW8VnnTrb047UjArlq5qfDfhX1nOWQX3uE?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +WtqNH/eAUEdeTFPHWhFWy2SmbCMsq0dTysaUOlHa7zP6JW86kVgdO4Hhe1Z22EmvDUoWyDn3IMHIZ833ebBbWePHrwRPiucLyH7FwRE8nL76jHdOA+6moScdSuW7nQQ3fKfMgRwYmarCzuV+mWmhvK2NYD9jzn+AEt2DJD40xQpBg25FQBszvN1kSYMlyArOv7VBatYz6UAjkNb9n9dzMYOqn6sqE4445t098rJRiPVgQXUX0h95zTWZxXW4h3ulSiP8jKTz2dnlz/Eckz/CRPdeCfmYKqw8m60klKdOq3FWu3Nl9swnyUxe6M5n6dk7Zogn5x3WmnchaTl4sRyjlpZH8eBB4hxAcAEGJON9twKnsBTrEKIqKZ7DtJqHjbnsstUiyb2rL/+/vogUbnXDEfiOWfDHcOiLpx6hDR/ozxF6b0MwvFyLXVkOJNlOt/MxgP2Vg/6k4RL+9WeFHiHMLuz6hX2UzTk2K1oq9xOnBHFDg6jCXP4bIiutpq9kyM7ACb0zUtgTBmpAJW1iusQaOs2Q0jwhbIZpxJO4CaxDePTGaDaGE9h2Y8XW7y7a1INX83oSAGhFP16z5/MBLTLPr7ccm0DgtOlYUKfr/7goCj7sILgeXT0kF63Aw7hjMKo14CUoVouMfLq+W/zrnjefA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2025 14:17:52.0766 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cf52275a-2169-4485-e32f-08ddeee27f45
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF0000A798.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP190MB1869
X-BESS-ID: 1757341075-302180-817-594-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 40.107.162.111
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVubGxgZAVgZQ0NjA0Mjc1CjVLC
 UlKdEsKdU8Ockg2dTM2MjQIDHJzNhCqTYWAO6ACNJBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267336 [from 
 cloudscan14-17.eu-central-1a.ess.aws.cudaops.com]
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

