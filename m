Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57AAAC021B3
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:04:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE8E0406B7;
	Thu, 20 Feb 2025 23:04:20 +0100 (CET)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id EFC0D40691
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:17 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2111.outbound.protection.outlook.com [104.47.18.111]) by
 mx-outbound46-229.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:16 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QzSJzJYfIqMkbWuLXaUDJPJvsBQbIHkQlLOVW+MVoRxHnz9YdHcsv4YnPtiZ+Cn68pwV2uvZnOHQhKBVBU9W9wKN6V795n7mTlLCN31nrOFSrIOkZQsS9Zn6q66oaVOq0v0eq3+xmqQCbaAtnT+ljyfp+VZ0c5ppNqlnC4304wVAhFrmIe1Ji90gwzlLai0ezr3Txy8FxDLVc5tQsNcydLjzJAJqJDrm/9KSVOoPtCSIZzGq3/HTif+j1SSvIFJ57NoBDOHVH/16AAWTXU4V4vn4BNS5MKLQHG7PABJFbE5jTmcqAG+PhoHQ8C27XJM2GBFhf4KuPCRNzTrVFICldA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z3K+GLwXcX8IUbBlOxGHrWnlrCTFpawvsFk10+Ln+Vo=;
 b=mGb+sJM1vXrwGh5y7iRQyb7NpqofWtpjuvWK03yOEcu73H5Qtmcr77egcHpl6daIJ2rFQivMy6x0J1PXIOVJurigGU6yyaM7y0mAX6su7PI7de16kCjwIunj2GzFpsyx13TLgx/BpBdc7z0yxpfjoT3b/9uXkM9L7N1hkmgZGDxhgxsCOt0rJJPvY+OJBWsp3AhbMMU36c1Y45h4lTQmVRwT578eq5KZQdMVpoZL0LcF4DYnKBxvPJFHrdUn0bfTQbA+lu4QpN3d/YMSAyJzyPcCQgxUYhGgymc+WNOVOr3hqppNN9yBKtqYt2ScswWQMrL39Ye7xF5FbJimbXL2Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z3K+GLwXcX8IUbBlOxGHrWnlrCTFpawvsFk10+Ln+Vo=;
 b=bCGLEst7rpGnP3v1OdtUUj3rYXBVtQBsnBCvMZTAx/gyzd7kTtoJigDFJgnMauUcVBHIo4651AIzR/d35sRKTMKaeMro82b4O1CDqwJ21/DG3Rsjl6NDkA9qEdwvfmUvALWnKXkG2xLrjbpkImkSXjfMJ7qQbmnGDZtQRO0UEU4=
Received: from CWLP265CA0497.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::15)
 by PA2P190MB2103.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:40a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 22:04:14 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::68) by CWLP265CA0497.outlook.office365.com
 (2603:10a6:400:18b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 22:04:13 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:13 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 03/32] net/ntnic: add rpf and gfg init
Date: Thu, 20 Feb 2025 23:03:27 +0100
Message-ID: <20250220220406.3925597-4-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|PA2P190MB2103:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ca10c3b2-e856-4f0b-cc3e-08dd51fa830c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Wr3hEm0KPpsX4BEiyAg+Cjb5BBQ6qkcpq/4A883Cugy7bLzq0cp7SnXzf+px?=
 =?us-ascii?Q?hoK/xzapQloaAj1kqQW05E8guSg4lQYsQfTwogE7oTgHBX8KPK3Okry77dHA?=
 =?us-ascii?Q?M2F3J5znjqkuXPKpLf9PsVaI2vh0m8c9265HzBFqose9H9Rhqd5/INKmDiXY?=
 =?us-ascii?Q?urV4Xjjov0OO94FdaX3rdVKqUe+uHm4+i/rRuVu5I9RMecfBOQufXhtkR24k?=
 =?us-ascii?Q?2bnyor/WiGZjUu7zKv+PlQrj6QbIWOhFbpNm3UKQiktTmLO+1i6B1AdzUTHh?=
 =?us-ascii?Q?xr5spLGpQlfjovtfMlJWhwq0+C01nRE/9rGk9zXd8orHt3WCzib8k+9r+pRK?=
 =?us-ascii?Q?scBVWP8+LjOamsU0s77+v6csGR8fTrXh7D4u98kmqweyfoxXwhow45zhoUVq?=
 =?us-ascii?Q?/hQzFMSepcS4gm8WJnmbNUc4YmhmS+cjVLIlcnQf7REU/soedDBh9UCVJWBB?=
 =?us-ascii?Q?GFlTMhG+wTtdTtILburf8zCApEicfJESHberpQqidNB6OoqACZ7wyJD2ynEp?=
 =?us-ascii?Q?fUESN0HhkDiHHRq24kC2JkIqGxs45p1vT7k4zRbhQCJAwvXF2/XgR09i0jII?=
 =?us-ascii?Q?siXm5aPjNp792H7gIkR/cAJV+jI31KHeXpniXXSEx468nqwd3SkjptFsj+dT?=
 =?us-ascii?Q?Za66G1I2v9VShHrGXNjjEwuvh2oHUYusj/ZFVI506tyrcP8pE8UfrTJw6lD+?=
 =?us-ascii?Q?Tuk2K2NUlTPY2lIkhFhzZU1fJqFShsw0zLek2u1pn04nYGs2x8s9P0PVKt5/?=
 =?us-ascii?Q?ewJqRxeC1Y1XZczHImlf2Kq2kAgzlzYbRZsh42V/4BOLy5uR/jxIwEHoQm6C?=
 =?us-ascii?Q?d09VOPY8A46WSOTbXnVAkwYLxlaByTXH2FrwultazHfXCop6SoIYJv/FHzlE?=
 =?us-ascii?Q?EOhkIcX4/cSMHmtWE6uJ9Qj2Q0NRnJeecJhVVQeH1ulfvor0e5tirPuh+ILv?=
 =?us-ascii?Q?MYK1NEgiAqFiihv5zoCRk4rR+Y1OqAEDTsdjItmW+LjwCHpW3OlfkCk7ntHg?=
 =?us-ascii?Q?YSrGtDZt6gNnVC0bsx5F1bg+iY5mSlAadw6+xuGerbbrCMb7A/gozsYkDGXa?=
 =?us-ascii?Q?mB55E9Z6vsqj7mVTVVy65F9TFopTo87UeE1HJr8HMm7VxIfk6/2+WJ1T8vQc?=
 =?us-ascii?Q?TP7NerirGfw1bAL6qzh8EFNU9NoiN9sQhFmylcb46Q1HcrTiUG8zjcQ5h50r?=
 =?us-ascii?Q?6zihET4rwUFXVuxb0ER+MgIvrNQDVBd+tvIQn6Gq0XICLO/MW0gy0hPGVCSP?=
 =?us-ascii?Q?djbN+A0T41CFs1dPBEgdgueVLtPctJ3EoqwdSbPOw3qVNB2H1UkW0XBBFMMH?=
 =?us-ascii?Q?K43n6xiW7OQUvqI/NNV7b4MqNC3EM220hq4YbDBvpSmCe+0JMGRwc/CE+9Zc?=
 =?us-ascii?Q?DIgJHOusSX34HgVLMX4ZxfXBz4ZDQDiCRrEtZfWZr0KDCj6vJXMXgIeYSDhY?=
 =?us-ascii?Q?yW+cg/+SpPNIW/7fEYM99mnx7s7OYWhChqqtzzwG+c8jLzjzNodp1h93VIew?=
 =?us-ascii?Q?PQnacfuvpccExVw=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: o7aKRH1UTdkpQvt8c9qeO3ODuYJlYX8TdamKUhImh4bZXwgDhoizryKmN1ROZ/tm7PM1zvv6KK72c+U4YmJhZoD/pJban4EDalwWjdtac9jcgswzioxR886x5samgGclmgHd4uqdgv3G+ukyHtGE9xfYD8hhaLik0x8bpRo7LBc/Ua/5V0bqT7NEM+nfc14gY4kAdi6loNg6iI6xkroc6Ht71UZGTWEHS1MNmf+rEZkeg/YzCP5orXHhPnR5c61XPNLFdP7Jh/92OJ/VtDJZMeOIS1nCPtrjEJ8JOe6rpAHqIlCwuhuoSywW0YWNbWtrmaw8yz2+CCvlx/aZvoYDCRWa+ZvlqeQtigpQ9Nc8CtAzoTUbD8rAeYAE0zwpia5RRm6tBo/K/0YXc9NqV4p1kBm5mD4W/bgePtMwRXfyMWFshCv9IqIByhbe8cfRaYUTKxnZW5jyKeKjSNK3o4iHs73mSwHjwJueCkxBbKVOsMGJglPdPnh7D59PmD+wN+JRAV39qJIsBCLrIENY/5Yuhdek1cZv58QQj2AMjuaZIaSt7xW39xFNbhJ3LCxvnvf7AHynfX49qZ1hvmxQJGvEb5QrmHWnhhZXKgYuzqIQ8iQTfbNJiXMYLcVwwd9cGRIJpLr+mZCSTmcMUXMc2QY/1K+43HMtTKlE/bhjByuiKRM=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:13.7556 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ca10c3b2-e856-4f0b-cc3e-08dd51fa830c
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2P190MB2103
X-BESS-ID: 1740089056-312005-29061-14085-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.18.111
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZm5qbGQGYGUDQl1dzSxNDYIM
 3I1MDQxMwiNc0g0TQxMS3FzNDSJNHYQKk2FgDs6jGaQgAAAA==
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262653 [from 
 cloudscan19-102.eu-central-1b.ess.aws.cudaops.com]
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

RPF and GFG modules initialization were added.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/include/nt4ga_link.h        |   2 +
 drivers/net/ntnic/include/nthw_gfg.h          |  33 ++
 .../link_agx_100g/nt4ga_agx_link_100g.c       |  24 ++
 drivers/net/ntnic/meson.build                 |   1 +
 drivers/net/ntnic/nthw/core/nthw_gfg.c        | 340 ++++++++++++++++++
 drivers/net/ntnic/nthw/nthw_drv.h             |  10 +
 6 files changed, 410 insertions(+)
 create mode 100644 drivers/net/ntnic/include/nthw_gfg.h
 create mode 100644 drivers/net/ntnic/nthw/core/nthw_gfg.c

diff --git a/drivers/net/ntnic/include/nt4ga_link.h b/drivers/net/ntnic/include/nt4ga_link.h
index af7ea4a9f2..e3dc3d4d5d 100644
--- a/drivers/net/ntnic/include/nt4ga_link.h
+++ b/drivers/net/ntnic/include/nt4ga_link.h
@@ -8,6 +8,7 @@
 
 #include "ntos_drv.h"
 #include "ntnic_nim.h"
+#include "nthw_gfg.h"
 
 enum nt_link_state_e {
 	NT_LINK_STATE_UNKNOWN = 0,	/* The link state has not been read yet */
@@ -84,6 +85,7 @@ typedef struct adapter_100g_s {
 
 typedef struct adapter_agx_100g_s {
 	nim_i2c_ctx_t nim_ctx[NUM_ADAPTER_PORTS_MAX];	/* should be the first field */
+	nthw_gfg_t gfg[NUM_ADAPTER_PORTS_MAX];
 } adapter_agx_100g_t;
 
 typedef union adapter_var_s {
diff --git a/drivers/net/ntnic/include/nthw_gfg.h b/drivers/net/ntnic/include/nthw_gfg.h
new file mode 100644
index 0000000000..4583fd9ebd
--- /dev/null
+++ b/drivers/net/ntnic/include/nthw_gfg.h
@@ -0,0 +1,33 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2023 Napatech A/S
+ */
+
+#ifndef NTHW_GFG_H_
+#define NTHW_GFG_H_
+
+#include "nthw_fpga_model.h"
+struct nthw_gfg {
+	nthw_fpga_t *mp_fpga;
+	nthw_module_t *mp_mod_gfg;
+	int mn_instance;
+
+	int mn_param_gfg_present;
+
+	nthw_field_t *mpa_fld_ctrl_enable[8];
+	nthw_field_t *mpa_fld_ctrl_mode[8];
+	nthw_field_t *mpa_fld_ctrl_prbs_en[8];
+	nthw_field_t *mpa_fld_ctrl_size[8];
+	nthw_field_t *mpa_fld_stream_id_val[8];
+	nthw_field_t *mpa_fld_run_run[8];
+	nthw_field_t *mpa_fld_size_mask[8];
+	nthw_field_t *mpa_fld_burst_size_val[8];
+};
+
+typedef struct nthw_gfg nthw_gfg_t;
+
+int nthw_gfg_init(nthw_gfg_t *p, nthw_fpga_t *p_fpga, int n_instance);
+
+int nthw_gfg_stop(nthw_gfg_t *p, const int n_intf_no);
+
+#endif	/* NTHW_GFG_H_ */
diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index 369b9b601f..9db32443fc 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -11,6 +11,7 @@
 #include <string.h>
 #include "ntnic_mod_reg.h"
 #include "nim_defines.h"
+#include "nthw_gfg.h"
 
 static int nt4ga_agx_link_100g_ports_init(struct adapter_info_s *p_adapter_info,
 	nthw_fpga_t *fpga);
@@ -134,11 +135,34 @@ static uint32_t nt4ga_agx_link_100g_mon(void *data)
 int nt4ga_agx_link_100g_ports_init(struct adapter_info_s *p_adapter_info, nthw_fpga_t *fpga)
 {
 	(void)fpga;
+	nt4ga_link_t *nt4ga_link = &p_adapter_info->nt4ga_link;
 	const int adapter_no = p_adapter_info->adapter_no;
 	int res = 0;
 
 	NT_LOG(DBG, NTNIC, "%s: Initializing ports", p_adapter_info->mp_adapter_id_str);
 
+	if (!nt4ga_link->variables_initialized) {
+		nthw_gfg_t *gfg_mod = p_adapter_info->nt4ga_link.u.var_a100g.gfg;
+		nthw_agx_t *p_nthw_agx = &p_adapter_info->fpga_info.mp_nthw_agx;
+
+		p_nthw_agx->p_rpf = nthw_rpf_new();
+		res = nthw_rpf_init(p_nthw_agx->p_rpf, fpga, adapter_no);
+
+		if (res != 0) {
+			NT_LOG(ERR, NTNIC, "%s: Failed to initialize RPF module (%u)",
+				p_adapter_info->mp_adapter_id_str, res);
+			return res;
+		}
+
+		res = nthw_gfg_init(&gfg_mod[adapter_no], fpga, 0 /* Only one instance */);
+
+		if (res != 0) {
+			NT_LOG(ERR, NTNIC, "%s: Failed to initialize GFG module (%u)",
+				p_adapter_info->mp_adapter_id_str, res);
+			return res;
+		}
+	}
+
 	/*
 	 * Create state-machine thread
 	 */
diff --git a/drivers/net/ntnic/meson.build b/drivers/net/ntnic/meson.build
index 7e4f47b1e6..68d7fdafd4 100644
--- a/drivers/net/ntnic/meson.build
+++ b/drivers/net/ntnic/meson.build
@@ -47,6 +47,7 @@ sources = files(
         'nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c',
         'nthw/core/nthw_fpga.c',
         'nthw/core/nthw_gmf.c',
+        'nthw/core/nthw_gfg.c',
         'nthw/core/nthw_tsm.c',
         'nthw/core/nthw_gpio_phy.c',
         'nthw/core/nthw_hif.c',
diff --git a/drivers/net/ntnic/nthw/core/nthw_gfg.c b/drivers/net/ntnic/nthw/core/nthw_gfg.c
new file mode 100644
index 0000000000..aa71624457
--- /dev/null
+++ b/drivers/net/ntnic/nthw/core/nthw_gfg.c
@@ -0,0 +1,340 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2023 Napatech A/S
+ */
+
+#include "ntlog.h"
+
+#include "nthw_drv.h"
+#include "nthw_register.h"
+
+#include "nt_util.h"
+#include "nthw_gfg.h"
+
+int nthw_gfg_init(nthw_gfg_t *p, nthw_fpga_t *p_fpga, int n_instance)
+{
+	nthw_module_t *mod = nthw_fpga_query_module(p_fpga, MOD_GFG, n_instance);
+	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
+	nthw_register_t *p_reg;
+
+	if (p == NULL)
+		return mod == NULL ? -1 : 0;
+
+	if (mod == NULL) {
+		NT_LOG(ERR, NTHW, "%s: GFG %d: no such instance", p_adapter_id_str, n_instance);
+		return -1;
+	}
+
+	p->mp_fpga = p_fpga;
+	p->mn_instance = n_instance;
+	p->mp_mod_gfg = mod;
+
+	p->mn_param_gfg_present = nthw_fpga_get_product_param(p_fpga, NT_GFG_PRESENT, 0);
+
+	if (!p->mn_param_gfg_present) {
+		NT_LOG(ERR,
+			NTHW,
+			"%s: %s: GFG %d module found - but logically not present - failing",
+			__func__,
+			p_adapter_id_str,
+			p->mn_instance);
+	}
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_CTRL0);
+
+	if (p_reg) {
+		p->mpa_fld_ctrl_enable[0] = nthw_register_query_field(p_reg, GFG_CTRL0_ENABLE);
+		p->mpa_fld_ctrl_mode[0] = nthw_register_query_field(p_reg, GFG_CTRL0_MODE);
+		p->mpa_fld_ctrl_prbs_en[0] = nthw_register_query_field(p_reg, GFG_CTRL0_PRBS_EN);
+		p->mpa_fld_ctrl_size[0] = nthw_register_query_field(p_reg, GFG_CTRL0_SIZE);
+	}
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_CTRL1);
+
+	if (p_reg) {
+		p->mpa_fld_ctrl_enable[1] = nthw_register_query_field(p_reg, GFG_CTRL1_ENABLE);
+		p->mpa_fld_ctrl_mode[1] = nthw_register_query_field(p_reg, GFG_CTRL1_MODE);
+		p->mpa_fld_ctrl_prbs_en[1] = nthw_register_query_field(p_reg, GFG_CTRL1_PRBS_EN);
+		p->mpa_fld_ctrl_size[1] = nthw_register_query_field(p_reg, GFG_CTRL1_SIZE);
+	}
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_CTRL2);
+
+	if (p_reg) {
+		p->mpa_fld_ctrl_enable[2] = nthw_register_query_field(p_reg, GFG_CTRL2_ENABLE);
+		p->mpa_fld_ctrl_mode[2] = nthw_register_query_field(p_reg, GFG_CTRL2_MODE);
+		p->mpa_fld_ctrl_prbs_en[2] = nthw_register_query_field(p_reg, GFG_CTRL2_PRBS_EN);
+		p->mpa_fld_ctrl_size[2] = nthw_register_query_field(p_reg, GFG_CTRL2_SIZE);
+	}
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_CTRL3);
+
+	if (p_reg) {
+		p->mpa_fld_ctrl_enable[3] = nthw_register_query_field(p_reg, GFG_CTRL3_ENABLE);
+		p->mpa_fld_ctrl_mode[3] = nthw_register_query_field(p_reg, GFG_CTRL3_MODE);
+		p->mpa_fld_ctrl_prbs_en[3] = nthw_register_query_field(p_reg, GFG_CTRL3_PRBS_EN);
+		p->mpa_fld_ctrl_size[3] = nthw_register_query_field(p_reg, GFG_CTRL3_SIZE);
+	}
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_CTRL4);
+
+	if (p_reg) {
+		p->mpa_fld_ctrl_enable[4] = nthw_register_query_field(p_reg, GFG_CTRL4_ENABLE);
+		p->mpa_fld_ctrl_mode[4] = nthw_register_query_field(p_reg, GFG_CTRL4_MODE);
+		p->mpa_fld_ctrl_prbs_en[4] = nthw_register_query_field(p_reg, GFG_CTRL4_PRBS_EN);
+		p->mpa_fld_ctrl_size[4] = nthw_register_query_field(p_reg, GFG_CTRL4_SIZE);
+	}
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_CTRL5);
+
+	if (p_reg) {
+		p->mpa_fld_ctrl_enable[5] = nthw_register_query_field(p_reg, GFG_CTRL5_ENABLE);
+		p->mpa_fld_ctrl_mode[5] = nthw_register_query_field(p_reg, GFG_CTRL5_MODE);
+		p->mpa_fld_ctrl_prbs_en[5] = nthw_register_query_field(p_reg, GFG_CTRL5_PRBS_EN);
+		p->mpa_fld_ctrl_size[5] = nthw_register_query_field(p_reg, GFG_CTRL5_SIZE);
+	}
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_CTRL6);
+
+	if (p_reg) {
+		p->mpa_fld_ctrl_enable[6] = nthw_register_query_field(p_reg, GFG_CTRL6_ENABLE);
+		p->mpa_fld_ctrl_mode[6] = nthw_register_query_field(p_reg, GFG_CTRL6_MODE);
+		p->mpa_fld_ctrl_prbs_en[6] = nthw_register_query_field(p_reg, GFG_CTRL6_PRBS_EN);
+		p->mpa_fld_ctrl_size[6] = nthw_register_query_field(p_reg, GFG_CTRL6_SIZE);
+	}
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_CTRL7);
+
+	if (p_reg) {
+		p->mpa_fld_ctrl_enable[7] = nthw_register_query_field(p_reg, GFG_CTRL7_ENABLE);
+		p->mpa_fld_ctrl_mode[7] = nthw_register_query_field(p_reg, GFG_CTRL7_MODE);
+		p->mpa_fld_ctrl_prbs_en[7] = nthw_register_query_field(p_reg, GFG_CTRL7_PRBS_EN);
+		p->mpa_fld_ctrl_size[7] = nthw_register_query_field(p_reg, GFG_CTRL7_SIZE);
+	}
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_RUN0);
+
+	if (p_reg)
+		p->mpa_fld_run_run[0] = nthw_register_query_field(p_reg, GFG_RUN0_RUN);
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_RUN1);
+
+	if (p_reg)
+		p->mpa_fld_run_run[1] = nthw_register_query_field(p_reg, GFG_RUN1_RUN);
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_RUN2);
+
+	if (p_reg)
+		p->mpa_fld_run_run[2] = nthw_register_query_field(p_reg, GFG_RUN2_RUN);
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_RUN3);
+
+	if (p_reg)
+		p->mpa_fld_run_run[3] = nthw_register_query_field(p_reg, GFG_RUN3_RUN);
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_RUN4);
+
+	if (p_reg)
+		p->mpa_fld_run_run[4] = nthw_register_query_field(p_reg, GFG_RUN4_RUN);
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_RUN5);
+
+	if (p_reg)
+		p->mpa_fld_run_run[5] = nthw_register_query_field(p_reg, GFG_RUN5_RUN);
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_RUN6);
+
+	if (p_reg)
+		p->mpa_fld_run_run[6] = nthw_register_query_field(p_reg, GFG_RUN6_RUN);
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_RUN7);
+
+	if (p_reg)
+		p->mpa_fld_run_run[7] = nthw_register_query_field(p_reg, GFG_RUN7_RUN);
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_STREAMID0);
+
+	if (p_reg)
+		p->mpa_fld_stream_id_val[0] = nthw_register_query_field(p_reg, GFG_STREAMID0_VAL);
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_STREAMID1);
+
+	if (p_reg)
+		p->mpa_fld_stream_id_val[1] = nthw_register_query_field(p_reg, GFG_STREAMID1_VAL);
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_STREAMID2);
+
+	if (p_reg)
+		p->mpa_fld_stream_id_val[2] = nthw_register_query_field(p_reg, GFG_STREAMID2_VAL);
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_STREAMID3);
+
+	if (p_reg)
+		p->mpa_fld_stream_id_val[3] = nthw_register_query_field(p_reg, GFG_STREAMID3_VAL);
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_STREAMID4);
+
+	if (p_reg)
+		p->mpa_fld_stream_id_val[4] = nthw_register_query_field(p_reg, GFG_STREAMID4_VAL);
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_STREAMID5);
+
+	if (p_reg)
+		p->mpa_fld_stream_id_val[5] = nthw_register_query_field(p_reg, GFG_STREAMID5_VAL);
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_STREAMID6);
+
+	if (p_reg)
+		p->mpa_fld_stream_id_val[6] = nthw_register_query_field(p_reg, GFG_STREAMID6_VAL);
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_STREAMID7);
+
+	if (p_reg)
+		p->mpa_fld_stream_id_val[7] = nthw_register_query_field(p_reg, GFG_STREAMID7_VAL);
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_SIZEMASK0);
+
+	if (p_reg)
+		p->mpa_fld_size_mask[0] = nthw_register_query_field(p_reg, GFG_SIZEMASK0_VAL);
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_SIZEMASK1);
+
+	if (p_reg)
+		p->mpa_fld_size_mask[1] = nthw_register_query_field(p_reg, GFG_SIZEMASK1_VAL);
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_SIZEMASK2);
+
+	if (p_reg)
+		p->mpa_fld_size_mask[2] = nthw_register_query_field(p_reg, GFG_SIZEMASK2_VAL);
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_SIZEMASK3);
+
+	if (p_reg)
+		p->mpa_fld_size_mask[3] = nthw_register_query_field(p_reg, GFG_SIZEMASK3_VAL);
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_SIZEMASK4);
+
+	if (p_reg)
+		p->mpa_fld_size_mask[4] = nthw_register_query_field(p_reg, GFG_SIZEMASK4_VAL);
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_SIZEMASK5);
+
+	if (p_reg)
+		p->mpa_fld_size_mask[5] = nthw_register_query_field(p_reg, GFG_SIZEMASK5_VAL);
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_SIZEMASK6);
+
+	if (p_reg)
+		p->mpa_fld_size_mask[6] = nthw_register_query_field(p_reg, GFG_SIZEMASK6_VAL);
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_SIZEMASK7);
+
+	if (p_reg)
+		p->mpa_fld_size_mask[7] = nthw_register_query_field(p_reg, GFG_SIZEMASK7_VAL);
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_BURSTSIZE0);
+
+	if (p_reg) {
+		p->mpa_fld_burst_size_val[0] =
+			nthw_register_query_field(p_reg, GFG_BURSTSIZE0_VAL);
+	}
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_BURSTSIZE1);
+
+	if (p_reg) {
+		p->mpa_fld_burst_size_val[1] =
+			nthw_register_query_field(p_reg, GFG_BURSTSIZE1_VAL);
+	}
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_BURSTSIZE2);
+
+	if (p_reg) {
+		p->mpa_fld_burst_size_val[2] =
+			nthw_register_query_field(p_reg, GFG_BURSTSIZE2_VAL);
+	}
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_BURSTSIZE3);
+
+	if (p_reg) {
+		p->mpa_fld_burst_size_val[3] =
+			nthw_register_query_field(p_reg, GFG_BURSTSIZE3_VAL);
+	}
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_BURSTSIZE4);
+
+	if (p_reg) {
+		p->mpa_fld_burst_size_val[4] =
+			nthw_register_query_field(p_reg, GFG_BURSTSIZE4_VAL);
+	}
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_BURSTSIZE5);
+
+	if (p_reg) {
+		p->mpa_fld_burst_size_val[5] =
+			nthw_register_query_field(p_reg, GFG_BURSTSIZE5_VAL);
+	}
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_BURSTSIZE6);
+
+	if (p_reg) {
+		p->mpa_fld_burst_size_val[6] =
+			nthw_register_query_field(p_reg, GFG_BURSTSIZE6_VAL);
+	}
+
+	p_reg = nthw_module_query_register(p->mp_mod_gfg, GFG_BURSTSIZE7);
+
+	if (p_reg) {
+		p->mpa_fld_burst_size_val[7] =
+			nthw_register_query_field(p_reg, GFG_BURSTSIZE7_VAL);
+	}
+
+	return 0;
+}
+
+static int nthw_gfg_setup(nthw_gfg_t *p,
+	const size_t n_intf_no,
+	const int n_enable,
+	const int n_frame_count,
+	const int n_frame_size,
+	const int n_frame_fill_mode,
+	const int n_frame_stream_id)
+{
+	if ((size_t)n_intf_no >= ARRAY_SIZE(p->mpa_fld_ctrl_enable) ||
+		n_intf_no >= ARRAY_SIZE(p->mpa_fld_ctrl_mode) ||
+		(size_t)n_intf_no >= ARRAY_SIZE(p->mpa_fld_ctrl_size) ||
+		n_intf_no >= ARRAY_SIZE(p->mpa_fld_stream_id_val) ||
+		(size_t)n_intf_no >= ARRAY_SIZE(p->mpa_fld_burst_size_val)) {
+		assert(false);
+		return -1;
+	}
+
+	if (p->mpa_fld_ctrl_enable[n_intf_no] == NULL || p->mpa_fld_ctrl_mode[n_intf_no] == NULL ||
+		p->mpa_fld_ctrl_size[n_intf_no] == NULL ||
+		p->mpa_fld_stream_id_val[n_intf_no] == NULL ||
+		p->mpa_fld_burst_size_val[n_intf_no] == NULL) {
+		assert(false);
+		return -1;
+	}
+
+	nthw_field_set_val_flush32(p->mpa_fld_stream_id_val[n_intf_no], n_frame_stream_id);
+	nthw_field_set_val_flush32(p->mpa_fld_burst_size_val[n_intf_no], n_frame_count);
+
+	if (p->mpa_fld_size_mask[n_intf_no])
+		nthw_field_set_val_flush32(p->mpa_fld_size_mask[n_intf_no], 0);
+
+	nthw_field_set_val32(p->mpa_fld_ctrl_mode[n_intf_no], n_frame_fill_mode);
+	nthw_field_set_val32(p->mpa_fld_ctrl_size[n_intf_no], n_frame_size);
+
+	if (p->mpa_fld_ctrl_prbs_en[n_intf_no])
+		nthw_field_set_val32(p->mpa_fld_ctrl_prbs_en[n_intf_no], 0);
+
+	nthw_field_set_val_flush32(p->mpa_fld_ctrl_enable[n_intf_no],
+		n_enable);	/* write enable and flush */
+
+	return 0;
+}
+
+int nthw_gfg_stop(nthw_gfg_t *p, const int n_intf_no)
+{
+	return nthw_gfg_setup(p, n_intf_no, 0, 1, 0x666, 0, n_intf_no);
+}
diff --git a/drivers/net/ntnic/nthw/nthw_drv.h b/drivers/net/ntnic/nthw/nthw_drv.h
index 69e0360f5f..9dc839c83c 100644
--- a/drivers/net/ntnic/nthw/nthw_drv.h
+++ b/drivers/net/ntnic/nthw/nthw_drv.h
@@ -9,6 +9,15 @@
 #include "nthw_core.h"
 #include "ntnic_dbs.h"
 
+#include "nthw_rpf.h"
+
+/*
+ * Structs for controlling Agilex based NT400DXX adapter
+ */
+typedef struct nthw_agx_s {
+	nthw_rpf_t *p_rpf;
+} nthw_agx_t;
+
 typedef enum nt_meta_port_type_e {
 	PORT_TYPE_PHYSICAL,
 	PORT_TYPE_VIRTUAL,
@@ -88,6 +97,7 @@ typedef struct fpga_info_s {
 
 	nthw_adapter_id_t n_nthw_adapter_id;
 
+	nthw_agx_t mp_nthw_agx;	/* For the Agilex based NT400DXX */
 } fpga_info_t;
 
 
-- 
2.45.0

