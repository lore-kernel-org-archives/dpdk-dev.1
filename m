Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D849C021B3
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:05:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EE47B40DDC;
	Thu, 20 Feb 2025 23:04:33 +0100 (CET)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 20A8140A8A
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:26 +0100 (CET)
Received: from EUR03-DBA-obe.outbound.protection.outlook.com
 (mail-dbaeur03lp2174.outbound.protection.outlook.com [104.47.51.174]) by
 mx-outbound8-89.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:25 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXR9KJkg//Sqtk3CcAfFQeUHXg01m5gMPmBR5Jj5Z8uPUTHF42oL6CXaylQRhTlhfhkyKgwbOej0roVSqoZxk2O03hYvmM0iz6RooVkzaJ6Z3g+KBje3na8ai/hkxJvz7fU7IT/1voxa+NF4kXiWCIfDpPtFc8f+93NKfQDAk4U76YiKTdPF5P/AwBD/mEpsnEOnxMQszZIE/dUDm+hu7DQCYOGvpf1d2eXryML03AgREXrJg00WDkfuDafSEnkABlXavj57vIDPeE1BMDLRV725nSRo2stdwS6ZN2a+sxdJraIU/1rjbu7Mssqt/1PzHTF2ev8NicOSCHUzSWhjqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LkaIBbu5ubakQWYA6B5PMLznoR2OHdAMe0BWfWCteNg=;
 b=L6gj62YCp74IVpofZMLt6NyXZR8XPlxV6z9aSVndf0Q+lVmSetQHuE19JriKTKjdPlfhcMFyjDI6FKx2WvP3S7/V+Etu6ufQTo0+LTWSjsau76QwTUlgZXj/cqINaEuIBHVeQ6uQgCGWRHlGMWJxJE+jPVrp81W0jeP6kKqSG2qdFZS6mPpl26q7fBW0tMbsm6kIgpHAB/I89erpTPzcp5aSPgtiRFSPmE2yEhiAt/ssaGJJa/wPjNFL2gxiUaNekC77KnRCr8lPh4G0yDYc9asBUv32Pqc7/WIlD+N2yeYLdPItnZl3x3BrH6JKzPUU/UR+Sida0dKPLEkbtxrwww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LkaIBbu5ubakQWYA6B5PMLznoR2OHdAMe0BWfWCteNg=;
 b=Vj9R4YtxUxsbktLEVJpP6ZFNerer06ATvHwRxfLa0RRV/iG6ZWL3zBsH66dVDFtt8cay+B5OnqfZ79R8dxz5Fhz5ltZNA/R2D84Lmy8H0MRnbwaD2egcEx3il/A6SksEYhM/RTDvKcVMLGa6PokGDu41XT0T+oFL4A24MZiPq9M=
Received: from CWLP265CA0502.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::16)
 by DB9P190MB1289.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:22a::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 22:04:23 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::a8) by CWLP265CA0502.outlook.office365.com
 (2603:10a6:400:18b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 22:04:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:23 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 14/32] net/ntnic: add minimal reset FPGA
Date: Thu, 20 Feb 2025 23:03:38 +0100
Message-ID: <20250220220406.3925597-15-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|DB9P190MB1289:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 39cbfa6b-bd6f-4f44-666b-08dd51fa88b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?i1y/E1CgYOPaseVWkhgrGorXYVxMmt6ykbz6HxMVi0VOUbNSjw42c85D9Jvh?=
 =?us-ascii?Q?ZP2lt/EKw60lUHma1bkw3im3MRiGn/1g5w5cZU9BlE61zpcqzmN8bukDv2Nc?=
 =?us-ascii?Q?HXRpBbnrusAYoKP+sCmtLyfSB//eN+dz43vvJt2GGDjtudq3/W/QTeDPyAqG?=
 =?us-ascii?Q?FHOh38QBFyhcUlV1P7hwlbbffj5gcUFMrCpC90xXB1Y4MijQ1wiQw7r0FRLO?=
 =?us-ascii?Q?wyjIY/Xa0QvPxrjQQmKIpikmNwWGVB1sgRoaSfmnRi0hNv4BxH9yuUNzGCjD?=
 =?us-ascii?Q?FvqIBNYtC673tJ5HSDJrcGFtATvV53k93YHpMt1Ak3tE5z9lj9xd7bxQsMuG?=
 =?us-ascii?Q?Nfw42SUI2vLsPV6eN68OLuJoZ/cCouTSgjN2bALL2AUts56n3OzT+xVNY8jo?=
 =?us-ascii?Q?zTUVJncXJUNANzX/rIwbeGAgDYOr/4qM+lGxm+kiNMR3LZKr83KLdU13u9RV?=
 =?us-ascii?Q?QN9+TZBTGo5jzzKqTwAOi6R+SS1Yg2iZhDaA2asle6fSpAdURP1+QAmWVVCv?=
 =?us-ascii?Q?HyiEn9gpsxlCfysOnAnX0Y0dnRZ3llBPMAhomnf7M85NpWyTr1yCaNKtMcL7?=
 =?us-ascii?Q?oBeO7m9LVNS8n2QV6Xe6kwUV91bfuusNKwQnhHC7rJXyjskfhSHde2SXxiLs?=
 =?us-ascii?Q?1XKn0Pl6auPFvhinxXwD6jqk5ve7NUTOMfbPFjE/DzNCz1ZGZrDqjihsk0wf?=
 =?us-ascii?Q?G1kKeI4YcdJBPk8pWo4CCiFaJygcaDDlojTDZTe+/dMafnv9PgUOsOf30Ea4?=
 =?us-ascii?Q?MDeFVi0Igoi5HhREConcaPU7YBmmZ3xW4AyNXBS77Hbuw+1wr95AJXSaHuno?=
 =?us-ascii?Q?EVjg7oDzPYEPeJqiYB20WZFv5ZD9g3GxM/kyuTSA2OTbpaZEKVFfoiMsKIHG?=
 =?us-ascii?Q?/+8nvpVlgsEs0nTjKzPQwUDxEGA5uk6amErITpfn06A184KcICzpcDRU4ye0?=
 =?us-ascii?Q?ZeKbWAAmhkS1dg2p3OLgs3Q042ZFwvmhHVkWF5/qBTGs7q6Lt+Pr9LkkgB5e?=
 =?us-ascii?Q?8D34GM4tgk6ncFtQtXaIS8HXv+D09j5KHyeZ+8sBmAySaAdPsAd3UM5SsNlW?=
 =?us-ascii?Q?oG+rtX5HzzmXOU8g9VDXyF4KCu3jtHZuQIJ/31JO929jf9H8MLWyMKD6qR01?=
 =?us-ascii?Q?YN2wELYjwOETfJB5IXcift1q0Lq3rV669Mh/4Jp47LFym3ye6MvwN3EvqNck?=
 =?us-ascii?Q?dYiLc/Bcvf7mVYM06IkKiSljM1EIRuTKaoVNlG/wv04TQhLSzMFjQXoY7r3D?=
 =?us-ascii?Q?EZLHBy7QykQLWdFWpViW4uOi/hcnFEeX7nEzSyuO329pD/1YXdNsGD6kc2ma?=
 =?us-ascii?Q?8YUEKfjIg6Pd1Vi6oAX0Hxv6zlAU5XhkzI1ujwQuwc6mXkiYYtzx2V/URoSq?=
 =?us-ascii?Q?PdmUaZGKoek3TBYs59wPWgqF84rXm27KBj5hNtcPxugTU6qametFLB59K81B?=
 =?us-ascii?Q?yvr81FExWOTgDY9rUfIm7PC040DHVtopS+mQJs9e+fLSHxEeJ3OGKA2s0PAU?=
 =?us-ascii?Q?C8SpiU8TW5m7qMc=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: napX+CuOqgtKezQoIERd2mZzzJiYk7HOE4EQ0EdTRAHjyFgctLTysohbPd1UCJ8aMsB7a7Kv/m2unRwtcof5rPfT9JMAGbp7fCDjFdIB22P/q+KfKI4tUgywYFrEaFPFcl0BtzJ9bd8jDxiz8hnbi8mChwFhU0AwjoDyTRM/YO3JTU2+oBuzn07fODBB1n6tLQpZAv+2mKRpG5VrVYPKf1cPdNQj/vMLkJCOYhmU5MiqF2rvy5w1HQzpCekd34EF/9DRo7QpOMasoFc4CRRlMCIOd+utLOHsaXGcd73uw3sgtgk4quRzuBTkUaLpk96oCBXhKz5IrUQyOELsAPefKk7+WstSSAOa6jDWA1ynIDkVlgzR8X8Qrx2Nl9ugZAN8X/WlLEmKaD9aUq9Sf8GHhQJgtbdkpowrNRDD/GfPVFY1LkqE1KZJ8GA5OA11j/osPVS/MBBHR/Z5v1lPZXnK1sFlBYa4QcMhwVcms93au9fjL3VS9TA6Xfpa+A9TZerDPy6XGoHaJIkGuFuZNdRMKZCQhv5hQPP3ISP+6ejt86nVDgVkfW+aK0kOgHFEz/QTJKht4zaPQKdVkmx7rTZKGCQ77AIOGH5PKbzF/6Ljnpmp1jFC9Fa09gks/iD42lUCaowD0xNzcQA7BPp9SDQ95DmS/nOzJxBbsTdZM8dUdt0=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:23.2713 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 39cbfa6b-bd6f-4f44-666b-08dd51fa88b6
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1289
X-BESS-ID: 1740089064-302137-23558-14692-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.51.174
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpYWlhZAVgZQ0DI51dTY1NLUwC
 LF0sjYJNk8xdwozczAIDUt2TgtNSlRqTYWAO427cVBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262653 [from 
 cloudscan21-197.eu-central-1b.ess.aws.cudaops.com]
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

Define and register FPGA reset operations.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../include/ntnic_nthw_fpga_rst_nt400dxx.h    | 34 +++++++
 drivers/net/ntnic/meson.build                 |  2 +
 .../nthw/core/nt400dxx/nthw_fpga_nt400dxx.c   | 88 ++++++++++++++++++-
 .../core/nt400dxx/reset/nthw_fpga_rst9574.c   | 40 +++++++++
 .../nt400dxx/reset/nthw_fpga_rst_nt400dxx.c   | 33 +++++++
 drivers/net/ntnic/ntnic_mod_reg.c             | 30 +++++++
 drivers/net/ntnic/ntnic_mod_reg.h             | 21 +++++
 7 files changed, 247 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ntnic/include/ntnic_nthw_fpga_rst_nt400dxx.h
 create mode 100644 drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
 create mode 100644 drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c

diff --git a/drivers/net/ntnic/include/ntnic_nthw_fpga_rst_nt400dxx.h b/drivers/net/ntnic/include/ntnic_nthw_fpga_rst_nt400dxx.h
new file mode 100644
index 0000000000..2f04907ac9
--- /dev/null
+++ b/drivers/net/ntnic/include/ntnic_nthw_fpga_rst_nt400dxx.h
@@ -0,0 +1,34 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2024 Napatech A/S
+ */
+
+#ifndef __NTNIC_NTHW_FPGA_RST_NT400DXX_H__
+#define __NTNIC_NTHW_FPGA_RST_NT400DXX_H__
+
+#include "nthw_drv.h"
+#include "nthw_fpga_model.h"
+
+struct nthw_fpga_rst_nt400dxx {
+	int n_fpga_product_id;
+	int n_fpga_version;
+	int n_fpga_revision;
+	int n_hw_id;
+	bool mb_is_nt400d11;
+
+	nthw_field_t *p_fld_rst_sys;
+	nthw_field_t *p_fld_rst_ddr4;
+	nthw_field_t *p_fld_rst_phy_ftile;
+
+	nthw_field_t *p_fld_stat_ddr4_calib_complete;
+	nthw_field_t *p_fld_stat_phy_ftile_rst_done;
+	nthw_field_t *p_fld_stat_phy_ftile_rdy;
+
+	nthw_field_t *p_fld_latch_ddr4_calib_complete;
+	nthw_field_t *p_fld_latch_phy_ftile_rst_done;
+	nthw_field_t *p_fld_latch_phy_ftile_rdy;
+};
+
+typedef struct nthw_fpga_rst_nt400dxx nthw_fpga_rst_nt400dxx_t;
+
+#endif	/* __NTHW_FPGA_RST_NT400DXX_H__ */
diff --git a/drivers/net/ntnic/meson.build b/drivers/net/ntnic/meson.build
index d56e85dd66..5a159f8bc6 100644
--- a/drivers/net/ntnic/meson.build
+++ b/drivers/net/ntnic/meson.build
@@ -45,7 +45,9 @@ sources = files(
         'nthw/core/nt200a0x/nthw_fpga_nt200a0x.c',
         'nthw/core/nt400dxx/nthw_fpga_nt400dxx.c',
         'nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c',
+        'nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c',
         'nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c',
+        'nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c',
         'nthw/core/nthw_fpga.c',
         'nthw/core/nthw_gmf.c',
         'nthw/core/nthw_gfg.c',
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
index 3f86843ff3..0a5add60e0 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
@@ -5,13 +5,99 @@
 
 #include "nthw_fpga.h"
 #include "ntnic_mod_reg.h"
-
+#include "ntlog.h"
 
 static int nthw_fpga_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 {
 	assert(p_fpga_info);
+	struct rst9574_ops *rst9574_ops = NULL;
+
+	const char *const p_adapter_id_str = p_fpga_info->mp_adapter_id_str;
+	struct nthw_fpga_rst_nt400dxx rst;
 	int res = -1;
 
+	nthw_fpga_t *p_fpga = p_fpga_info->mp_fpga;
+	assert(p_fpga);
+
+	switch (p_fpga_info->n_fpga_prod_id) {
+	case 9574:
+		rst9574_ops = get_rst9574_ops();
+
+		if (rst9574_ops == NULL) {
+			NT_LOG(ERR, NTHW, "%s: RST 9574 NOT INCLUDED", p_adapter_id_str);
+			return -1;
+		}
+
+		res = rst9574_ops->nthw_fpga_rst9574_setup(p_fpga, &rst);
+
+		if (res) {
+			NT_LOG(ERR, NTHW,
+				"%s: %s: FPGA=%04d Failed to create reset module res=%d",
+				p_adapter_id_str, __func__, p_fpga_info->n_fpga_prod_id, res);
+			return res;
+		}
+
+		break;
+
+	default:
+		NT_LOG(ERR, NTHW, "%s: Unsupported FPGA product: %04d",
+			p_adapter_id_str, p_fpga_info->n_fpga_prod_id);
+		return -1;
+	}
+
+	struct rst_nt400dxx_ops *rst_nt400dxx_ops = get_rst_nt400dxx_ops();
+
+	if (rst_nt400dxx_ops == NULL) {
+		NT_LOG(ERR, NTHW, "RST NT400DXX NOT INCLUDED");
+		return -1;
+	}
+
+	/* reset common */
+	res = rst_nt400dxx_ops->nthw_fpga_rst_nt400dxx_init(p_fpga_info);
+
+	if (res) {
+		NT_LOG(ERR, NTHW, "%s: %s: FPGA=%04d - Failed to init common modules res=%d",
+			p_adapter_id_str, __func__, p_fpga_info->n_fpga_prod_id, res);
+		return res;
+	}
+
+	res = rst_nt400dxx_ops->nthw_fpga_rst_nt400dxx_reset(p_fpga_info);
+
+	if (res) {
+		NT_LOG(ERR, NTHW,
+			"%s: %s: FPGA=%04d - Failed to reset common modules res=%d",
+			p_adapter_id_str, __func__, p_fpga_info->n_fpga_prod_id, res);
+		return res;
+	}
+
+		/* reset specific */
+	switch (p_fpga_info->n_fpga_prod_id) {
+	case 9574:
+		if (rst9574_ops)
+			res = rst9574_ops->nthw_fpga_rst9574_init(p_fpga_info, &rst);
+
+		if (res) {
+			NT_LOG(ERR, NTHW,
+				"%s: %s: FPGA=%04d - Failed to reset 9574 modules res=%d",
+				p_adapter_id_str, __func__, p_fpga_info->n_fpga_prod_id, res);
+			return res;
+		}
+
+		break;
+
+	default:
+		NT_LOG(ERR, NTHW, "%s: Unsupported FPGA product: %04d",
+			p_adapter_id_str, p_fpga_info->n_fpga_prod_id);
+		res = -1;
+		break;
+	}
+
+	if (res) {
+		NT_LOG(ERR, NTHW, "%s: %s: loc=%u: FPGA=%04d res=%d", p_adapter_id_str,
+			__func__, __LINE__, p_fpga_info->n_fpga_prod_id, res);
+		return res;
+	}
+
 	return res;
 }
 
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
new file mode 100644
index 0000000000..9ab26583df
--- /dev/null
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
@@ -0,0 +1,40 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2023 Napatech A/S
+ */
+#include "nthw_drv.h"
+#include "nthw_register.h"
+#include "nthw_fpga.h"
+
+#include "ntnic_nthw_fpga_rst_nt400dxx.h"
+#include "ntnic_mod_reg.h"
+
+static int nthw_fpga_rst9574_setup(nthw_fpga_t *p_fpga, struct nthw_fpga_rst_nt400dxx *const p)
+{
+	assert(p_fpga);
+	assert(p);
+
+	return 0;
+};
+
+
+
+static int nthw_fpga_rst9574_init(struct fpga_info_s *p_fpga_info,
+	struct nthw_fpga_rst_nt400dxx *p_rst)
+{
+	assert(p_fpga_info);
+	assert(p_rst);
+	int res = -1;
+
+	return res;
+}
+
+static struct rst9574_ops rst9574_ops = {
+	.nthw_fpga_rst9574_init = nthw_fpga_rst9574_init,
+	.nthw_fpga_rst9574_setup = nthw_fpga_rst9574_setup,
+};
+
+void rst9574_ops_init(void)
+{
+	register_rst9574_ops(&rst9574_ops);
+}
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
new file mode 100644
index 0000000000..e0e4bc0861
--- /dev/null
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
@@ -0,0 +1,33 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2023 Napatech A/S
+ */
+
+#include "ntlog.h"
+#include "nthw_drv.h"
+#include "nthw_register.h"
+#include "nthw_fpga.h"
+#include "nthw_hif.h"
+#include "ntnic_mod_reg.h"
+
+static int nthw_fpga_rst_nt400dxx_init(struct fpga_info_s *p_fpga_info)
+{
+	assert(p_fpga_info);
+	return 0;
+}
+
+static int nthw_fpga_rst_nt400dxx_reset(struct fpga_info_s *p_fpga_info)
+{
+	assert(p_fpga_info);
+	return 0;
+}
+
+static struct rst_nt400dxx_ops rst_nt400dxx_ops = {
+	.nthw_fpga_rst_nt400dxx_init = nthw_fpga_rst_nt400dxx_init,
+	.nthw_fpga_rst_nt400dxx_reset = nthw_fpga_rst_nt400dxx_reset
+};
+
+void rst_nt400dxx_ops_init(void)
+{
+	register_rst_nt400dxx_ops(&rst_nt400dxx_ops);
+}
diff --git a/drivers/net/ntnic/ntnic_mod_reg.c b/drivers/net/ntnic/ntnic_mod_reg.c
index 598df08fb7..054b343fe7 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.c
+++ b/drivers/net/ntnic/ntnic_mod_reg.c
@@ -178,6 +178,36 @@ void register_flow_backend_ops(const struct flow_backend_ops *ops)
 	flow_backend_ops = ops;
 }
 
+static struct rst9574_ops *rst9574_ops;
+
+void register_rst9574_ops(struct rst9574_ops *ops)
+{
+	rst9574_ops = ops;
+}
+
+struct rst9574_ops *get_rst9574_ops(void)
+{
+	if (rst9574_ops == NULL)
+		rst9574_ops_init();
+
+	return rst9574_ops;
+}
+
+static struct rst_nt400dxx_ops *rst_nt400dxx_ops;
+
+void register_rst_nt400dxx_ops(struct rst_nt400dxx_ops *ops)
+{
+	rst_nt400dxx_ops = ops;
+}
+
+struct rst_nt400dxx_ops *get_rst_nt400dxx_ops(void)
+{
+	if (rst_nt400dxx_ops == NULL)
+		rst_nt400dxx_ops_init();
+
+	return rst_nt400dxx_ops;
+}
+
 const struct flow_backend_ops *get_flow_backend_ops(void)
 {
 	if (flow_backend_ops == NULL)
diff --git a/drivers/net/ntnic/ntnic_mod_reg.h b/drivers/net/ntnic/ntnic_mod_reg.h
index 3e84beaa62..9b3650da89 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.h
+++ b/drivers/net/ntnic/ntnic_mod_reg.h
@@ -19,6 +19,7 @@
 #include "nthw_drv.h"
 #include "nt4ga_adapter.h"
 #include "ntnic_nthw_fpga_rst_nt200a0x.h"
+#include "ntnic_nthw_fpga_rst_nt400dxx.h"
 #include "ntnic_virt_queue.h"
 #include "create_elements.h"
 
@@ -255,6 +256,26 @@ void register_rst9563_ops(struct rst9563_ops *ops);
 struct rst9563_ops *get_rst9563_ops(void);
 void rst9563_ops_init(void);
 
+struct rst9574_ops {
+	int (*nthw_fpga_rst9574_init)(struct fpga_info_s *p_fpga_info,
+		struct nthw_fpga_rst_nt400dxx *const p);
+	int (*nthw_fpga_rst9574_setup)(nthw_fpga_t *p_fpga,
+		struct nthw_fpga_rst_nt400dxx *const p);
+};
+
+void register_rst9574_ops(struct rst9574_ops *ops);
+struct rst9574_ops *get_rst9574_ops(void);
+void rst9574_ops_init(void);
+
+struct rst_nt400dxx_ops {
+	int (*nthw_fpga_rst_nt400dxx_init)(struct fpga_info_s *p_fpga_info);
+	int (*nthw_fpga_rst_nt400dxx_reset)(struct fpga_info_s *p_fpga_info);
+};
+
+void register_rst_nt400dxx_ops(struct rst_nt400dxx_ops *ops);
+struct rst_nt400dxx_ops *get_rst_nt400dxx_ops(void);
+void rst_nt400dxx_ops_init(void);
+
 struct flow_backend_ops {
 	const struct flow_api_backend_ops *(*bin_flow_backend_init)(nthw_fpga_t *p_fpga,
 		void **be_dev);
-- 
2.45.0

