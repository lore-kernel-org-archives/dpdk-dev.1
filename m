Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 107E4C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:06:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4328740E26;
	Thu, 20 Feb 2025 23:04:43 +0100 (CET)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 97FB040B9E
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:32 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2106.outbound.protection.outlook.com [104.47.17.106]) by
 mx-outbound21-132.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oLQcHFr9KB832XyfIRcjPYco/0xxjPEpTQ3MMMOezeNgqXO3vPgVTQKkmXwkeWIkN06rktIsU7MnqkVCbRkgzT1bTMwBM+4e1jXCHXlCO7FXZkc41t+tiKfMDV/P7kkFI2jI7puKhYbs24OvMbjpDaMqIw97WqMeGQo4Dav2V0WrxSKLszwdu4czhHhQU/MHpCe051G5kJjhDyPT8OTMaz6QuPaL4oPYqDsMIT/McdWdbRi7ULt4vSI8fpv+/FcskgXItUB5ihvKqbgtfbyXuoTBODDEA+IGnDw2jqZHM+vMKvcukWtbQ9Vd95LbY4AXPip6agwhXvAqHMwDZwW8Mw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rvJ6L1GMo5c2LZbBYrPcap/i20vaRl8aCoLd8VEatXU=;
 b=Y2TCes8AzvcTA1HxjGOnNsvVvw33FNZIy3w33kqPLLXiAQYyw1eauyWoc8HlPNJ2J6ml2RseroHPAsTOpJToNsNZmGGyHD1Ww2VeCDJDd1ej956oS25uZ1zOGF9I/NAiRZHjt85twQU89Rp4A2ULGJ1QlH4i3k+dzTrjsiUojAtcp5m6ZdJ8ci/T1F4dD+MayV34JofQnxdKsQa6slypN/8DSVaNsRIwGvLgzA0ipnYGhqAa8WcnqcucRxUbJezcgv1WYhWTQTIqB16byhTmS87E7J60e4un9AJkb9jtJLYMgdNWXwEJbjvVlWsoOTbrusol2K/NF9aOTv7LvSAsug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rvJ6L1GMo5c2LZbBYrPcap/i20vaRl8aCoLd8VEatXU=;
 b=Os4CR9WucYFFBJD7ohl8vZsf28nGfi2av7wW2PCuvpBdjVjQvMLfxtH423yH3+7P3R+3aLXp5mievVJj4on8kFDuxZSkHBD5DDIfrOM5j6wDfeK/100Mei1hjVNIbvCgUIN6R1iCnZotZaEKrHUCr9n0rG/Ca+nuNshLT8mfqUk=
Received: from CWLP265CA0496.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::17)
 by DU4P190MB2173.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:577::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.20; Thu, 20 Feb
 2025 22:04:30 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::2a) by CWLP265CA0496.outlook.office365.com
 (2603:10a6:400:18b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 22:04:30 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:30 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 23/32] net/ntnic: add nt400d13 PRM module init
Date: Thu, 20 Feb 2025 23:03:47 +0100
Message-ID: <20250220220406.3925597-24-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|DU4P190MB2173:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: f95d6d46-b33b-49f4-c412-08dd51fa8cbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DVt1sxej7KD98O/et+Z7lpIK0h1plasdXURyGrduXiOw8EIIEXf5af9AggqY?=
 =?us-ascii?Q?EqbDpA7KcBAXbsSN6MxvgaV0Q1AyQldKqzWwfeUvoUKPGY+TjvyGTVwZSsZ9?=
 =?us-ascii?Q?ibBYBF33ULXbX48WS7/vjQOeahb8qN+BsfaWCOx+lZQp9G7YuPz/pJ2sXvww?=
 =?us-ascii?Q?2qezyZatV9kDxbiTIpiMPNHD1CP2HBfCsS5Nm2DphU6ImzfVJefdWCSXdlvT?=
 =?us-ascii?Q?clq91A1PFToUFTHaOuqGpbeoTiPHTm3G9tObD5PblUPs96zZ+eDj+WUslaeH?=
 =?us-ascii?Q?iX5D2FD+m5BHh0HtJopq5EdcVYpoEOQ/IkyM3d27ohde34zyYzbHAqOQNH91?=
 =?us-ascii?Q?EeyXc5WSPJzPgN2iJGhNgrjuFEjrtQGraL2VQkTS4YJ/LrLRvjT/btYLuVE8?=
 =?us-ascii?Q?5Ja1aZBhhNT0lpGmCDHESyYVtKT5WyekSANP6LvojTd+qzU/Iv+9Q+45zvx1?=
 =?us-ascii?Q?v3twzsSFOF9Iv2S3E3Tq4FmrcQws5XqQEBy6Jp5A5VzTcBcZrZwvdYLDgRqi?=
 =?us-ascii?Q?Rs6mlQbCEdUXmWWBVobHJo4XP4B9ABcwjmwZxaDxWZtKliVDqEZnMyAeL0QG?=
 =?us-ascii?Q?/lHN+ObUpx3iYhBP4ujiY6Up20gzpY1nWWpLgUQ/zZ/Jmz1ulLeBiHiyBxpT?=
 =?us-ascii?Q?P/tB1gDW4/GPvhDt34bHvHuNOO6zTAX68W2jcrfzRxe9yCm3gMsZDtNtxplj?=
 =?us-ascii?Q?CKvhzhvF3tXPAZYEQ5mlsuADqQZgrMOndXOnRxu1zvJLDCx3c6vmiSGYTdbo?=
 =?us-ascii?Q?gNCYtLXDZ2lKIqkhJ2JpnM87gx0pjwBLYbI7KCXaDkFTY+tqMcMytqx08xg6?=
 =?us-ascii?Q?G7avHjIybZVVWLlcG7Q7/+wiyYDtQrghe2eWe4vhEQ73sYzXMHmCxeOciXGS?=
 =?us-ascii?Q?kpH+HjxQVjeuz82E2AC2ZMAGBvuBTmRcS16hkjYJKAeo6uKHB13GiI7R6j9n?=
 =?us-ascii?Q?5JVxx+hD/4NSRZVoojc0aRA8uUKHLpcHu1Ve2UWTLJJtQIszhfP5da/Asc8B?=
 =?us-ascii?Q?oSiITl+pX37rdKue52vpvjhvOG258fpP8wi4S9wF9gkVE2f5tdcS2chUn9sN?=
 =?us-ascii?Q?dI3IloFcTYUNp097bKUUnBBfBeR0ixX19zg9YoChlyb3h0GgIoT6uLMRvjRK?=
 =?us-ascii?Q?187tzI7ANuucKFvLmfrmoL93r+QTyYgQf5X4Ekat4/8IANXaUSIYVDoCt41B?=
 =?us-ascii?Q?0gz9uRTT4da7U+fh6QaIdIHCc666DTk1a0/ip0S4uECsiZ78PslU8Zq8fDoU?=
 =?us-ascii?Q?ObHYWgfvPyGUnPHr/mX6gfA/p8TLabOiN/wE+aQ4WfEBuLk8hIxx78V7REoF?=
 =?us-ascii?Q?TOAHlyo+LqdSQ1ApiG77VWjmgnkkYq1VxJj40n9wuL8c0wPDIS0B/OF8Cp6P?=
 =?us-ascii?Q?TEUAM7b2t4iq6M10VmjeQCZrG22InwIoafBTUAXjGelwZdPL0xKwDhpjLQ6i?=
 =?us-ascii?Q?q33dZ6vCtqE4S2lrvwz6I68GhKzk60ANGbcBPV5wl2o10unbETzmrnNbMQED?=
 =?us-ascii?Q?c7J7nxnoxbeEo0Q=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: kveIRQk6g6D5xXxZSzCmjNis/thxT3f89+N0abHvabcaII8t2FKceVsxOH4/bzcFr1V2jfVXcO8p2ILP2HpjFLMkrrG/EB5EwPiwO81IeZw/aOyo/0fi+AYKMWhobPxF5nBW9FvKSq3GwW6laaLVVFXdEaiH1InR0u/kiMm164uEyQ5Do0jRUfX1RDS2X0lChMRf634rKc8tHaTcYviGwY6HnS8jQ9MS5XzxYAftkXTaPZwtkQnrt4wPKD/EURhXp++MZS8A3co78IyYTwd4h6CoZdyGLFr2fx5SfoTHxA1LkcM/GUO4solvFXlXAfQ/RNeo7KYYhEvorTIPyLt29c5XRtynXGumhclhvZlEJ93Xmc6F7ef0pNwasWy24zaHDultpsYDxfas8K9teybzXKjG70MhdrRvx5l4A4De8SDaqa4LGwPQhUrwwG8yHb5L4ulCzOea1Zo983oUH8+qbQ2usmMfVfPDRToRprWazQe3qKBSsDg8ZPQ3fkuGvPShC45086UMvdEr6JU+JcJkJ/ai57Qop5MwsAsxPQLREKTiiQXDQsQVB0dhMKTBN2hnHszCih9fSRAxj2H6CeBKVC3G1bDuF9gfwwzvkWT0BmZyhYMkFJSGZHB81PoBa+bfZR7Soie1jLrXms0gKc+JXW+m7lZG9wqfVwJUBKJuMRA=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:30.0214 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f95d6d46-b33b-49f4-c412-08dd51fa8cbe
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4P190MB2173
X-BESS-ID: 1740089071-305508-26315-16407-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.17.106
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqYGJiZAVgZQMNHY0MzSMs3U2N
 DCMNXI1MI0xdIoLcU0MSXV2DTFONVMqTYWAIX4i2xBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262653 [from 
 cloudscan15-44.eu-central-1a.ess.aws.cudaops.com]
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

From: Danylo Vodopianov <dvo-plv@napatech.com>

Initialize RAB0 and create PRM for FPGA.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/meson.build                 |  1 +
 .../nthw/core/include/nthw_prm_nt400dxx.h     | 30 +++++++++++++
 .../nt400dxx/reset/nthw_fpga_rst_nt400dxx.c   | 11 +++++
 .../net/ntnic/nthw/core/nthw_prm_nt400dxx.c   | 43 +++++++++++++++++++
 drivers/net/ntnic/nthw/nthw_drv.h             |  2 +
 5 files changed, 87 insertions(+)
 create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_prm_nt400dxx.h
 create mode 100644 drivers/net/ntnic/nthw/core/nthw_prm_nt400dxx.c

diff --git a/drivers/net/ntnic/meson.build b/drivers/net/ntnic/meson.build
index b9ac069bcc..9885d4efbf 100644
--- a/drivers/net/ntnic/meson.build
+++ b/drivers/net/ntnic/meson.build
@@ -63,6 +63,7 @@ sources = files(
         'nthw/core/nthw_pcal6416a.c',
         'nthw/core/nthw_pcm_nt400dxx.c',
         'nthw/core/nthw_phy_tile.c',
+        'nthw/core/nthw_prm_nt400dxx.c',
         'nthw/core/nthw_si5332_si5156.c',
         'nthw/core/nthw_rpf.c',
         'nthw/core/nthw_rmc.c',
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_prm_nt400dxx.h b/drivers/net/ntnic/nthw/core/include/nthw_prm_nt400dxx.h
new file mode 100644
index 0000000000..09bfd79249
--- /dev/null
+++ b/drivers/net/ntnic/nthw/core/include/nthw_prm_nt400dxx.h
@@ -0,0 +1,30 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2023 Napatech A/S
+ */
+
+#ifndef NTHW_PRM_NT400DXX_H_
+#define NTHW_PRM_NT400DXX_H_
+
+#include <stdint.h>
+
+#include "nthw_fpga_model.h"
+
+struct nt_prm_nt400dxx {
+	nthw_fpga_t *mp_fpga;
+	nthw_module_t *mp_mod_prm;
+
+	int mn_instance;
+
+	nthw_register_t *mp_reg_rst;
+	nthw_field_t *mp_fld_rst_periph;
+	nthw_field_t *mp_fld_rst_platform;
+};
+
+typedef struct nt_prm_nt400dxx nthw_prm_nt400dxx_t;
+typedef struct nt_prm_nt400dxx nt_prm_nt400dxx;
+
+nthw_prm_nt400dxx_t *nthw_prm_nt400dxx_new(void);
+int nthw_prm_nt400dxx_init(nthw_prm_nt400dxx_t *p, nthw_fpga_t *p_fpga, int n_instance);
+
+#endif	/* NTHW_PRM_NT400DXX_H_ */
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
index 60e7714283..4d74db88de 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
@@ -44,6 +44,17 @@ static int nthw_fpga_rst_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 
 	nthw_hif_delete(p_nthw_hif);
 
+	/* (b) Init RAB0 */
+	nthw_rac_rab_init(p_fpga_info->mp_nthw_rac, 0x7);
+	nthw_rac_rab_init(p_fpga_info->mp_nthw_rac, 0x6);
+
+	/* Create PRM */
+	p_fpga_info->mp_nthw_agx.p_prm = nthw_prm_nt400dxx_new();
+	res = nthw_prm_nt400dxx_init(p_fpga_info->mp_nthw_agx.p_prm, p_fpga, 0);
+
+	if (res != 0)
+		return res;
+
 	/* Create PCM */
 	p_fpga_info->mp_nthw_agx.p_pcm = nthw_pcm_nt400dxx_new();
 	res = nthw_pcm_nt400dxx_init(p_fpga_info->mp_nthw_agx.p_pcm, p_fpga, 0);
diff --git a/drivers/net/ntnic/nthw/core/nthw_prm_nt400dxx.c b/drivers/net/ntnic/nthw/core/nthw_prm_nt400dxx.c
new file mode 100644
index 0000000000..b1910fdbd5
--- /dev/null
+++ b/drivers/net/ntnic/nthw/core/nthw_prm_nt400dxx.c
@@ -0,0 +1,43 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2023 Napatech A/S
+ */
+
+#include "ntlog.h"
+#include "nthw_drv.h"
+#include "nthw_register.h"
+#include "nthw_prm_nt400dxx.h"
+
+nthw_prm_nt400dxx_t *nthw_prm_nt400dxx_new(void)
+{
+	nthw_prm_nt400dxx_t *p = malloc(sizeof(nthw_prm_nt400dxx_t));
+
+	if (p)
+		memset(p, 0, sizeof(nthw_prm_nt400dxx_t));
+
+	return p;
+}
+
+int nthw_prm_nt400dxx_init(nthw_prm_nt400dxx_t *p, nthw_fpga_t *p_fpga, int n_instance)
+{
+	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_PRM_NT400DXX, n_instance);
+
+	if (p == NULL)
+		return p_mod == NULL ? -1 : 0;
+
+	if (p_mod == NULL) {
+		NT_LOG(ERR, NTHW, "%s: PRM_NT400DXX %d: no such instance",
+			p->mp_fpga->p_fpga_info->mp_adapter_id_str, p->mn_instance);
+		return -1;
+	}
+
+	p->mp_mod_prm = p_mod;
+
+	p->mp_fpga = p_fpga;
+	p->mn_instance = n_instance;
+
+	p->mp_reg_rst = nthw_module_get_register(p->mp_mod_prm, PRM_NT400DXX_RST);
+	p->mp_fld_rst_periph = nthw_register_get_field(p->mp_reg_rst, PRM_NT400DXX_RST_PERIPH);
+	p->mp_fld_rst_platform = nthw_register_get_field(p->mp_reg_rst, PRM_NT400DXX_RST_PLATFORM);
+	return 0;
+}
diff --git a/drivers/net/ntnic/nthw/nthw_drv.h b/drivers/net/ntnic/nthw/nthw_drv.h
index 955d0a37b0..ecd3bb9cc4 100644
--- a/drivers/net/ntnic/nthw/nthw_drv.h
+++ b/drivers/net/ntnic/nthw/nthw_drv.h
@@ -15,6 +15,7 @@
 #include "nthw_rpf.h"
 #include "nthw_pcm_nt400dxx.h"
 #include "nthw_phy_tile.h"
+#include "nthw_prm_nt400dxx.h"
 #include "nthw_pcm_nt400dxx.h"
 
 /*
@@ -27,6 +28,7 @@ typedef struct nthw_agx_s {
 	nthw_pca9532_t *p_pca9532_led;
 	nthw_si5332_t *p_si5332;
 	nthw_si5156_t *p_si5156;
+	nthw_prm_nt400dxx_t *p_prm;
 	nthw_pcm_nt400dxx_t *p_pcm;
 	nthw_phy_tile_t *p_phy_tile;
 	nthw_rpf_t *p_rpf;
-- 
2.45.0

