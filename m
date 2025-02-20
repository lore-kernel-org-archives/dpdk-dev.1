Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40499C021B3
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:05:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3D66C40BA6;
	Thu, 20 Feb 2025 23:04:35 +0100 (CET)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id B71F640A8A
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:26 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03lp2238.outbound.protection.outlook.com [104.47.51.238]) by
 mx-outbound46-229.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rLRZs0WfeV2oTypp17/uDoLz6IwpIoa5atpIA5V8Y5MjMWbteQp9x4MP+jktervySOf5vjAMU9+egnAL/7bNIew1B+S9IkYh4P47p6yvyzSZv61K0yg9UNHUhOxEKubFZ1+BcShdTzJpPA3MzU7I9NKEAl04zatQZPmj+Y7Y5O02rI8vONwmZ9YxWUoH1mR5BxCbfGBqmDZi5DHGsDxymxB5MkJ1CO7kLPXqWik8lUKOhMhgjWTG8SWT2BCpUpnUD7SWgRW9Awg4KIVL2x2kJQuy6lthzPSOndM7tpZxHMYuY5GAW83dF1ynmf2hTZjNOYDaMBvHRd++sCCofYjxTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jywiHrakrcdCnte0caqbaG/VXTugZ/dv4NCel4rq1pk=;
 b=FTeKaj1dUXB3S8lDJfq0faKB3FK6H1p014tIqWnTHetLTozWNqkNbH7wNtqujtkFU03nh8OisTALyrBUCy46/xsI0s2T8ATqCeFPSmWvYiRcEGyqdBu0xTlM2Od1UjoV6F7xbAsnAoy9dXu2ITz/oZKlAuImuu/+daotpIhRLvWKXFsQJWlf/oOx4F6D5/dCGaAeNfXN1R2ybDLRimC1iyTndlJbqfNgHuzVR8sz7Ga9UJZQBsJMJmZB90pWr8xUAWWZGMFaFAG5310pFDasK1EKtSJJrJclkX9KwaRXLELvZan7EVyeNhob7tkCEmhqSZxfG3WpAiL0lHiB2YzZng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jywiHrakrcdCnte0caqbaG/VXTugZ/dv4NCel4rq1pk=;
 b=O1wU7WMNWdDNbFB7yedX7tWjijxRraV75g2fcsRzliazUIMgwFCFVx8O4QzC1ebKC0qGiLPpgquFim2kqNQStfMkp1mmQFsDPOrBtT1RWNSHL5uHX3Ctp74rDtKkKRxoF6vm0tVouRluKpL6LFig7P0fKNT78MUBHW9KyxU0ILQ=
Received: from CWLP265CA0510.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::10)
 by VE1P190MB0864.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1a4::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 22:04:21 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::f6) by CWLP265CA0510.outlook.office365.com
 (2603:10a6:400:18b::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 22:04:21 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:21 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 13/32] net/ntnic: add minimal initialization new NIC
 NT400D13
Date: Thu, 20 Feb 2025 23:03:37 +0100
Message-ID: <20250220220406.3925597-14-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|VE1P190MB0864:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6e302d02-64c0-4337-d4d3-08dd51fa87a1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?mWygMhskKwIoxZdz0NsWEsbSacvBAdPKyv5fqL2Dl2a+EoEuo0SKkCmouseB?=
 =?us-ascii?Q?z7Hyge+YgBQUvGSnFTvLWHLKHACyX5cKuNGIqNqBBdr5BNjZZKT6seNbVDkI?=
 =?us-ascii?Q?QbijMHPSgNSPEvUjshHPxv7BXyVmRlZdBN2Zq1CQOBRQdJEDC8OqBeQkLbCt?=
 =?us-ascii?Q?SFmqrwCee/yIQ4yWF/FquxQOf4fhtMxAsSXA09G12sThhOdxINH6YwyTwBN1?=
 =?us-ascii?Q?v2XLOlI52NS5HFA/97NE34jTggcI+yGp4aTDdt3vuE0ZzOB7IVzWZ0H+4X61?=
 =?us-ascii?Q?tE2aPSpuBg2jAB9XPcQA/E39s8kZexjNw9T1sWQuKnP4fTbXm0u12lppEYm4?=
 =?us-ascii?Q?NNd0m4M2g/0kgBARC5wgc8tfOwsHjMVPSz2CIfT+Gd/vtJfdi99VSBy8cK5J?=
 =?us-ascii?Q?FWwOsFvB6R6kROFRrBy2RvipTwlwQ7Qq1VLJt0cRUE4HqXoo9duAF6L0fd3v?=
 =?us-ascii?Q?xkSBsSijoY/85OUSkkq9RiLa3bFn1H1VtKp7p9mtQpz/H0hZEGZp2kgm56fo?=
 =?us-ascii?Q?Pbkvz/NTzOH9PvFFF565xMbTJJdf8qQSNYMapKGQb6f6jcsIS9S54vSC3aDA?=
 =?us-ascii?Q?bvIh4pxpD6Zz1TAGzIrONGdyofuE+fOjNfZ1FmeAJ/Lc1NlL5ic2tpEHPyC1?=
 =?us-ascii?Q?+Ss+B63S3CCJ2UGY+3X6f7RjsLI2M/bfJ9YzFMZLUU+D/FFi/E3iQOGgMrV8?=
 =?us-ascii?Q?DZkCHun8DgPtDsBaoRRXzo/XZAWScFweE3b9BbGIi7oGu+Osa6E48BtqFs8r?=
 =?us-ascii?Q?51xA2r2NGwBGoz0ktA+SPA83OVeGMETMlH6936aPKeqZvQ340Jc65lB4v7MB?=
 =?us-ascii?Q?vZYfwpsvg6kclk/3xJIp1PDkiQiNDD8o/9zEgSRosLNdot4GT8hdatPetW36?=
 =?us-ascii?Q?VmwKu/wkqaL5uKbhgCVsR4Iqa5FzzzAT5A7K3pajPkoi6w4NQbRTeRJiPFP+?=
 =?us-ascii?Q?dQIKGVTLIS1l1j2k8D7AeRzZJLn9APDtfz/CRCz9qLDROMyOmjRHbKZOD1AG?=
 =?us-ascii?Q?1oixCxUad4OnSq+yg7e8kOTF2MOHkL8MeWSNVZ0aj+gszq4AVoJ5gKdwgxda?=
 =?us-ascii?Q?5qjALj5OKqom3AzLjkt5H1sVjftSBC5yjKcp1zDaiv/k/tlPyPDRfDxacrfE?=
 =?us-ascii?Q?cWyTjPZFFnI/bWOdyCiyUWdj3JdPguvu2lag0afjajeR4rB9Geu5FkTqTI8n?=
 =?us-ascii?Q?JDzzlNvRV0gvl0DHv1pz7amSQnmevvw37M/ognCbAo1PP7HRT6CuB3ooXtwD?=
 =?us-ascii?Q?lILhojFXbQtQX+3ZCRuAfMIJG7kniySKgqzFNP6UFjGEIAP6k3kiS9JZfFOt?=
 =?us-ascii?Q?CnEU1gzmsAKhmj7eY8SYDw/qq8Uiahn8FEd0eESziT4LOyUB4+xY1YXENdDh?=
 =?us-ascii?Q?1uwYcrEevXaOEX3CFoXJIxvSHyYOo8nD06yxuCAQM17q3MhNrUG7FyiF1CxI?=
 =?us-ascii?Q?+9xcbCTwKGA=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ZqgMDgs9v7mlaKZrvribQ4dXkf8X7ujfns44Hs3WAMvbQG8bNVA0pkKY3b8lligGOmfxlcL0jQ7OG+37TDyXrLoWBWlBbpCWoHd3zsDRJs/bTrxE9ywIrjTf2nK7bNT1RC4oda6oL/gSv2L+O+72y/8343VDc4Iw1kbnN0Zmpp3CQUcQwxaskcWEm0vExsduRCJLVjrH5wdpISq8YWHpAYf9IFmenKq3ZgsATxN2kLhPCYbdF7yIEEeGj1GdRnqt/dOzDkhZEBvroxLXHgTMJjd9Q0UgN8Ono7cy8CCNLDbgBVw1jaIbnXh2sddeokMR4rk75qS0ZxJ6IdkDiVgQZS0baHEwj3W3kiX7W4X5csOGqJCW27tnkQqfi9ewYXGfV+BSSru7JDDkbYyvyBPHcS2CwtN1FegSVSN+Xt+umifAr+DzZUnuP5yfOoOeoXvJ18Zo577b5MsT1X/11UNu+Fzpslj7W4yAxLsoPb8+nP76HYgQ8kLeC53X81gyK4jmL9WFmkZ4Z9t3hxsbv0kpHWZnGc15Az1phTeBwAxw7fwL8kMkiiZCrMMFMcOuF2npDYSWdbjfFxJNLXIVK0/8x7l9kOnyyX/KDy12P7njPCcVuUlMmoMwLGxpVHUs7gPmTbwwVOZLB7cJHGKBwQS0noPOcKk2uLljoJbAacrpoU4=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:21.4119 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e302d02-64c0-4337-d4d3-08dd51fa87a1
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P190MB0864
X-BESS-ID: 1740089065-312005-29062-14093-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.51.238
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmYW5oZAVgZQ0CwlJTXVPMU40d
 DU0sQiMcnAwDjFONk8ycgsKcnIIiVRqTYWAAomZKlBAAAA
X-BESS-Outbound-Spam-Score: 1.01
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262653 [from 
 cloudscan19-102.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.50 BSF_RULE7568M          META: Custom Rule 7568M 
 0.50 BSF_RULE_7582B         META: Custom Rule 7582B 
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
 0.01 BSF_SC7_SG0146_1       META: Custom rule SG0146_1 
X-BESS-Outbound-Spam-Status: SCORE=1.01 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_RULE_7582B, BSF_BESS_OUTBOUND,
 BSF_SC7_SG0146_1
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

Add function and structures required to init the new NIC NT400D13

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 doc/guides/nics/ntnic.rst                     |  7 +++++-
 doc/guides/rel_notes/release_25_03.rst        |  4 ++++
 drivers/net/ntnic/meson.build                 |  1 +
 .../net/ntnic/nthw/core/include/nthw_fpga.h   |  8 +++++++
 .../nthw/core/nt400dxx/nthw_fpga_nt400dxx.c   | 23 +++++++++++++++++++
 drivers/net/ntnic/nthw/core/nthw_fpga.c       | 20 ++++++++++++++++
 drivers/net/ntnic/nthw/nthw_platform.c        |  3 +++
 drivers/net/ntnic/nthw/nthw_platform_drv.h    |  2 ++
 drivers/net/ntnic/ntnic_ethdev.c              |  1 +
 9 files changed, 68 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c

diff --git a/doc/guides/nics/ntnic.rst b/doc/guides/nics/ntnic.rst
index f186822504..f519a9f083 100644
--- a/doc/guides/nics/ntnic.rst
+++ b/doc/guides/nics/ntnic.rst
@@ -27,8 +27,13 @@ Supported NICs
 
     - FPGA ID 9563 (Inline Flow Management)
 
-All information about NT200A02 can be found by link below:
+- NT400D13 2x100G SmartNIC
+
+    - FPGA ID 9574 (Inline Flow Management)
+
+All information about NT200A02 and NT400D13 can be found by links below:
 https://www.napatech.com/products/nt200a02-smartnic-inline/
+https://www.napatech.com/support/resources/data-sheets/link-inline-software-for-napatech/
 
 
 Features
diff --git a/doc/guides/rel_notes/release_25_03.rst b/doc/guides/rel_notes/release_25_03.rst
index 8867a4bd74..8064a2e688 100644
--- a/doc/guides/rel_notes/release_25_03.rst
+++ b/doc/guides/rel_notes/release_25_03.rst
@@ -123,6 +123,10 @@ New Features
     This feature enhances the efficiency of probing VF/SFs on a large scale
     by significantly reducing the probing time.
 
+* **Updated Napatech ntnic driver.**
+
+  * Added support for the NT400D13 adapter.
+
 * **Updated Wangxun ngbe driver.**
 
   * Added support for virtual function (VF).
diff --git a/drivers/net/ntnic/meson.build b/drivers/net/ntnic/meson.build
index 92aad6f94d..d56e85dd66 100644
--- a/drivers/net/ntnic/meson.build
+++ b/drivers/net/ntnic/meson.build
@@ -43,6 +43,7 @@ sources = files(
         'nthw/supported/nthw_fpga_mod_str_map.c',
         'nthw/core/nt200a0x/clock_profiles/nthw_fpga_clk9563.c',
         'nthw/core/nt200a0x/nthw_fpga_nt200a0x.c',
+        'nthw/core/nt400dxx/nthw_fpga_nt400dxx.c',
         'nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c',
         'nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c',
         'nthw/core/nthw_fpga.c',
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_fpga.h b/drivers/net/ntnic/nthw/core/include/nthw_fpga.h
index cee1d23090..8b1d548a25 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_fpga.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_fpga.h
@@ -36,4 +36,12 @@ void register_nt200a0x_ops(struct nt200a0x_ops *ops);
 struct nt200a0x_ops *get_nt200a0x_ops(void);
 void nt200a0x_ops_init(void);
 
+struct nt400dxx_ops {
+	int (*nthw_fpga_nt400dxx_init)(struct fpga_info_s *p_fpga_info);
+};
+
+void register_nt400dxx_ops(struct nt400dxx_ops *ops);
+struct nt400dxx_ops *get_nt400dxx_ops(void);
+void nt400dxx_ops_init(void);
+
 #endif	/* __NTHW_FPGA_H__ */
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
new file mode 100644
index 0000000000..3f86843ff3
--- /dev/null
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
@@ -0,0 +1,23 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2023 Napatech A/S
+ */
+
+#include "nthw_fpga.h"
+#include "ntnic_mod_reg.h"
+
+
+static int nthw_fpga_nt400dxx_init(struct fpga_info_s *p_fpga_info)
+{
+	assert(p_fpga_info);
+	int res = -1;
+
+	return res;
+}
+
+static struct nt400dxx_ops nt400dxx_ops = { .nthw_fpga_nt400dxx_init = nthw_fpga_nt400dxx_init };
+
+void nt400dxx_ops_init(void)
+{
+	register_nt400dxx_ops(&nt400dxx_ops);
+}
diff --git a/drivers/net/ntnic/nthw/core/nthw_fpga.c b/drivers/net/ntnic/nthw/core/nthw_fpga.c
index 5ca186209a..e54a210c9f 100644
--- a/drivers/net/ntnic/nthw/core/nthw_fpga.c
+++ b/drivers/net/ntnic/nthw/core/nthw_fpga.c
@@ -266,6 +266,7 @@ int nthw_fpga_init(struct fpga_info_s *p_fpga_info)
 	p_fpga_info->mp_nthw_rac = p_nthw_rac;
 
 	struct nt200a0x_ops *nt200a0x_ops = get_nt200a0x_ops();
+	struct nt400dxx_ops *nt400dxx_ops = get_nt400dxx_ops();
 
 	switch (p_fpga_info->n_nthw_adapter_id) {
 	case NT_HW_ADAPTER_ID_NT200A02:
@@ -273,6 +274,11 @@ int nthw_fpga_init(struct fpga_info_s *p_fpga_info)
 			res = nt200a0x_ops->nthw_fpga_nt200a0x_init(p_fpga_info);
 		break;
 
+	case NT_HW_ADAPTER_ID_NT400D13:
+		if (nt400dxx_ops != NULL)
+			res = nt400dxx_ops->nthw_fpga_nt400dxx_init(p_fpga_info);
+		break;
+
 	default:
 		NT_LOG(ERR, NTHW, "%s: Unsupported HW product id: %d", p_adapter_id_str,
 			p_fpga_info->n_nthw_adapter_id);
@@ -398,3 +404,17 @@ struct nt200a0x_ops *get_nt200a0x_ops(void)
 		nt200a0x_ops_init();
 	return nt200a0x_ops;
 }
+
+static struct nt400dxx_ops *nt400dxx_ops;
+
+void register_nt400dxx_ops(struct nt400dxx_ops *ops)
+{
+	nt400dxx_ops = ops;
+}
+
+struct nt400dxx_ops *get_nt400dxx_ops(void)
+{
+	if (nt400dxx_ops == NULL)
+		nt400dxx_ops_init();
+	return nt400dxx_ops;
+}
diff --git a/drivers/net/ntnic/nthw/nthw_platform.c b/drivers/net/ntnic/nthw/nthw_platform.c
index 33e18e549f..80063c9d25 100644
--- a/drivers/net/ntnic/nthw/nthw_platform.c
+++ b/drivers/net/ntnic/nthw/nthw_platform.c
@@ -11,6 +11,9 @@ nthw_adapter_id_t nthw_platform_get_nthw_adapter_id(const uint16_t n_pci_device_
 	case NT_HW_PCI_DEVICE_ID_NT200A02:
 		return NT_HW_ADAPTER_ID_NT200A02;
 
+	case NT_HW_PCI_DEVICE_ID_NT400D13:
+		return NT_HW_ADAPTER_ID_NT400D13;
+
 	default:
 		return NT_HW_ADAPTER_ID_UNKNOWN;
 	}
diff --git a/drivers/net/ntnic/nthw/nthw_platform_drv.h b/drivers/net/ntnic/nthw/nthw_platform_drv.h
index 42eb0b8b05..df54dcead0 100644
--- a/drivers/net/ntnic/nthw/nthw_platform_drv.h
+++ b/drivers/net/ntnic/nthw/nthw_platform_drv.h
@@ -10,10 +10,12 @@
 
 #define NT_HW_PCI_VENDOR_ID (0x18f4)
 #define NT_HW_PCI_DEVICE_ID_NT200A02 (0x1C5)
+#define NT_HW_PCI_DEVICE_ID_NT400D13 (0x295)
 
 enum nthw_adapter_id_e {
 	NT_HW_ADAPTER_ID_UNKNOWN = 0,
 	NT_HW_ADAPTER_ID_NT200A02,
+	NT_HW_ADAPTER_ID_NT400D13,
 };
 
 typedef enum nthw_adapter_id_e nthw_adapter_id_t;
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 1b6b222c9d..88f6b6af6b 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -91,6 +91,7 @@ static const char *const valid_arguments[] = {
 
 static const struct rte_pci_id nthw_pci_id_map[] = {
 	{ RTE_PCI_DEVICE(NT_HW_PCI_VENDOR_ID, NT_HW_PCI_DEVICE_ID_NT200A02) },
+	{ RTE_PCI_DEVICE(NT_HW_PCI_VENDOR_ID, NT_HW_PCI_DEVICE_ID_NT400D13) },
 	{
 		.vendor_id = 0,
 	},	/* sentinel */
-- 
2.45.0

