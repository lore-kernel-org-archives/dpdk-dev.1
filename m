Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A8C2CCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:37:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DCD0240695;
	Mon, 20 Oct 2025 18:36:40 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 32C5240651
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:36:34 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11023098.outbound.protection.outlook.com [52.101.72.98])
 by mx-outbound9-130.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:36:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENvUWJ663urA2Oktn2gngscEtDeJdSwIMQFGrEkbznj9p1wEe3mCtoOshqU+SiShSmmq705xdPpkRSsRE+/1EKw0fgYMJhGVRBXM/SwaMqP2LNEOHqLsBItUVNF/ciH8oW8EOM1FFq9G9Fd8T4BNscVJ/2mykLbYWKnJ9GHnchMuNZvjo4bEUp6/X/2JPI4DjO4nPR8bjzrethyRELFuZ+gmN/Ra6GziBfWbty/aDGwedEtJ+tyaf7r16MpB8EaD4/cKkdwLKPT9k6P0UC0FRLgDcn6iJdrA7rFIgqR+q557kRvM2SVyWsMt61zt3S9q1AX5ptCICZLn57KKLkvWjw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8xRN7x++kI2XgC/c6uvGyR4i3R1LkUg/QKm3V1H2fz4=;
 b=Gbney4Pnt83/FKdvg4zGlKCSU8xU8Gq3W/xuM/6UJ3/MlseBsHB21FDvG5tmMWJ0kZzBTA7iINxw/9EW7HDuSvLUPJR/5qngl+C1XxiJvitCDj0O/eOoAHcFMlCjU7q1nqfayJtmz6iQfjPW+ZZ66VEoIgI6Wq8Sg8cvyy+DlG+51tYver1NFZcb3Gwtz8m7HlkCTf94gK+CU0yGiDBESbJ8Hv+YvjEfd8wn/OY99Qj2joMA0CvycT1A6CXRuT7qwzSnfrjDUWjRldFHbPm+p6tgLBSE06/iCrX04Tc4DYEqZtivhMmctrWyW76QbTK7FnPwn5tbFcgRnHnDMBjaYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8xRN7x++kI2XgC/c6uvGyR4i3R1LkUg/QKm3V1H2fz4=;
 b=GVLl1L3WQx7nHZtkfrU/YMDW9SU3wEzrvBF89nnPEO12pO3+Io0WniR7iAC3B5X1iuBwlVlEmm41+UC5/02f+1AyOlgiT0E+HRRSlX/o5fISjONXxTCKNcImfcyHpvuRJHM3sitySQ9/YyLNHPyHmHSxLxusjy4HHQZKB6cZy3c=
Received: from AS4P191CA0028.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::20)
 by DBAP190MB0950.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:1b0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.9; Mon, 20 Oct
 2025 16:36:31 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::3b) by AS4P191CA0028.outlook.office365.com
 (2603:10a6:20b:5d9::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 16:36:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:36:31
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 07/24] net/ntnic: avoid using thread API
Date: Mon, 20 Oct 2025 18:35:58 +0200
Message-ID: <20251020163620.282312-8-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020163620.282312-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20251020163620.282312-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|DBAP190MB0950:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 29c7224f-f407-41a7-a39c-08de0ff6d377
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zcmMmUOUmn5v/O5lmPcWdzl2hIQtlJICZaHVSS08PI0Vx+IGW1Q7p54E7Aus?=
 =?us-ascii?Q?JEQ98GYyYZjGawCQDknsjy0EOS2FjbjOsVtP9pYQu8InGlaPA9DnZEcKY/rf?=
 =?us-ascii?Q?DVhv+qb88G8e1WDLGXSN71B2pYj7qiVbLQXaiV/zkxhuySVN3PW9yt8PF4yo?=
 =?us-ascii?Q?ZpbQR30WCA5tA5GVocXXkC3sfy9KBNR3m4NW8CgblIXIlyK196BgfCVaQ2S2?=
 =?us-ascii?Q?UWryJUDX7mKGsR882rrlMWMbAiRSWfcNoyjlENlPV+xRSBmT/qWROxigAZ/n?=
 =?us-ascii?Q?ePxzYGihBXZdzju1A5RYzPQW8kofnx6ldBoYw2NMilW1KkQvRq1r0hxbe18n?=
 =?us-ascii?Q?un4CFP05d2cLK3iIpzOO6qLPR4a5bNOnqaMiQTzLliGJOVXsJPMqQOCoWMsi?=
 =?us-ascii?Q?0x2oakO1JcegDOukTqy5b5EB0GL7A8j/OlcG7XsruTCn2Elo4y6DYU6aDaL+?=
 =?us-ascii?Q?uTh62RwYkgNlIMftLMI2KV3E32ZPThMzg79qCwEPx4ypdFP30H7gsdBj43KG?=
 =?us-ascii?Q?QfawLxgNxUKI/Q6bBSnpHMut9PNrd5HZR1GvFqbFpbvPxa+uwe6ktIg113sU?=
 =?us-ascii?Q?biXPor6Uszl8bJUjX/6UKCqC45AVXtpUt7tnepKqj7dhyC/HftMowVP1UqBI?=
 =?us-ascii?Q?+wR+EjNCWWWqJkvnsZr1EguX4W2nV/u4h8IdybF8DOYzOwLc+h9s8pWWyuIl?=
 =?us-ascii?Q?7egJb2VhdKv/o199SODzW2NgOygqqpi/z1p6IowwhjiKbmdRcXn4USVMakLl?=
 =?us-ascii?Q?roI1r0JHg1ZfABdz9zCFDMKccEpnQYp3+TW0PQ2m6V43m7cN2xB2yqJ5o0om?=
 =?us-ascii?Q?246EFSPD2UkDqFZuw5/hMCVPA22OP7fRLwWqfjPDPWgYH7xdWsJ5809hWORy?=
 =?us-ascii?Q?ppwc4K97U3SGhpZXxVJgDuRoI/s+rPpnmj+JpqBwx0RlXiBGf7jSZhRan2nd?=
 =?us-ascii?Q?B4uh8GIGeyzYSqyAUvtIYMjAQEDs/ayltmqxHeEmNJfMpub8XmFXM9WLovDl?=
 =?us-ascii?Q?//3KRei33UELqxbpJjK52XAHuDaJnvH9OGZd3LFuL3XjKf87+MgeaPe9YOGE?=
 =?us-ascii?Q?5CJDAbt0RILQQuQXqI0FBBSxMMFdX2Vfc1G+mn8Nq8M5ejr7ar532azyOimx?=
 =?us-ascii?Q?jtzAF8GZZMT1zK1rVZDExPFqqAqWjGcFA5xcPfehrejpbWa6zOiYmkPx70rz?=
 =?us-ascii?Q?ERlsqZRKrzl3H5i9Ui9dDrJqzL5bW8tA+vuFCREkhTAEci2LpmWp7D5iuH18?=
 =?us-ascii?Q?vXDpFv0tVHRFYmBIoWsgjeyWgSgLw09nlojE/iM3RqNSq2V/s+HqZsXjYW6d?=
 =?us-ascii?Q?VR1nGnRCL8SpBwlZe557DNs0kQr6zoXQnMIcoxvPPxW+R4E1PpZGMMUFLmFq?=
 =?us-ascii?Q?TQAzxyfTjyogiB/+B91aUrv8lXmC8yQCJ2WLyu14F/ga3+kPRTL9sosniRK+?=
 =?us-ascii?Q?lUAFcDLLtGWJX7V0j6iiCJdfZEJj1+berzPgQsrwH0Mk/p2mnV3hMnMK5BPQ?=
 =?us-ascii?Q?XLZ+9iNTIDNgvOSkA6RapHau6WmGMfqgknzHBozjxWZJVPhEAqur9ssoygA3?=
 =?us-ascii?Q?ruva1QFHsR3VIsVQGg8=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 97Qv0nyYRwEidfX8um6YyIxzu5YLJoEDx2rdW2cZeZzF0nEXE+YUX3yRmDJyiptcA6It7JdF6xTJc9fGPx1rTNpTJkregbM6PSYpTh7gZIlgXKLpkLUPnr9tIOUbGzDiF0FubMYdvIWiR64P+o092rPulbOuV9MsSNmWC9sJFEYVOxaamXUjQXDpRK6Vw5K+7QbQ4SyOrErBLmeQkrri59ryX2mn8oyizfHDZME8cAE4F3qA06hfHjSvSHpfQjlBQ6YaxV2DsSQ4aNn8xre8aEoX6j0KNFdARrZR/87vHatrhhhh0KKi/XruRj4dZuSpRPTmRSI8mo5imdr1Mik+MEKo2g+EmgNX+HpmgJysAKi4eGQ/bvrJv5y6RYx2P0Ql/4e6M91Jwa03lxSlRiHZlkQ3o/XL1TvdDlTV5sru6bTkJ3Lx+0h1R+iLc/vHn+9kj/tELGAHBRT8aZq3iwElLaElKCi9lAejolH7q7DAg1lHFtKIZC34GRsVFk/pggGyvTtE/4WhB0QnpGosSViIdPVBXrha03DoVTkye3eJRexfMhlm2F64857LMlPmR2qD2RoG7sMcH0hWPx9qjQ/3bOHxpcBmsYmKMvTkarwbsVrLRb1HAvxKkNpdEpNE0kgLBDviRLfAE3StBeCVaF5SPivBer/IwPfhyTmVZ2Lh80U=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:36:31.6299 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29c7224f-f407-41a7-a39c-08de0ff6d377
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP190MB0950
X-BESS-ID: 1760978193-302434-10211-72804-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.72.98
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVubGZoZAVgZQMNky0cTY3DjVJD
 kpOTnNPNkkLS0tydTA1NQ8NTXN0shQqTYWACFsmFVBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan11-196.eu-central-1a.ess.aws.cudaops.com]
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

