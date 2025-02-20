Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 322A1C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:07:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 15BBC40E4A;
	Thu, 20 Feb 2025 23:04:54 +0100 (CET)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 9E39D40E03
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:38 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2112.outbound.protection.outlook.com [104.47.18.112]) by
 mx-outbound46-229.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZ5s/cU6ETcdQq/Bn/RIkpQRSt2KLDRc+0wODOzoXs1lHmDwWDjFhlOc3lqHFmmfHTjePeTeiZX8mgn0RRskOPIkgQO4cfbGrb18/RNC67+0GZIYrFa5y39/iMau7QyoliKP533e/kuiHVUmMDXaOoG/VoQcjI0IVEnvRKBRNtTPvh1jeendMJ2eqT1sI9EVGOT9O8bmaOKLS1jxpkgpWSr9Iz0jaI7PtSkpsgVEU4rySstqVK07BFvxKyIU5igWCVXFehTgDeWvEqxRR5Sb7PHrZVKgeoXnsTZldBOMkGo6EL4p0DsA2s8yrztQKEOemHLVTAYUv7bofIY6/FI41g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UfDbBIgERvnXEvWiAbuaOcs14nB4r1BjvLqNzYXAbPM=;
 b=DJgjLsQ75RfxcTcdlRf3UFJuOIAx8uDP9av8aInBrgsXExwNnI5cHpAYFU34OcRZAI95mT8UFHOG5Q+1rPQ8rB9A5Sc5VOK6Pz4D5zSWYGv8J0pfPdKDQrOjnsl3VSFN6eVC2orjdbbAExAa5+icVAckAna8gwJneWCY2eV5eiPAMPGL6NC22LOYBN6wsjWpEN/GkOlMmhnB1ewmwqaP3VVbrvTasinlW/FQda3rEVM9PRwL+FQ2p18vXBeZ31nDnN3Yu9Y632tNpr+0yu2y2YlyYk85Kug/qn1Zo0JXFMgaLOiTcd5kWxiFLNqP0MEjIg+F/IQIdexWSSpvS+2+IA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UfDbBIgERvnXEvWiAbuaOcs14nB4r1BjvLqNzYXAbPM=;
 b=LgQVl3iQ4LUONrFU03rhYrvABcOyifGjlS2Ka5W0ET8gQQqv6E3hlX/1ER8WJkDxVSuIG4gn1qqyPcWgUF/JW0XQ8HOkuPqzX3Pedswrq1Gu6BHLcXXHu44yfTpqkTbRp5odEF7Pm+FlqTLxhFgSOvT1Zq2aC79DuRgObU51tFQ=
Received: from CWLP265CA0508.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::6)
 by AM7P190MB0647.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:115::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 22:04:36 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::1c) by CWLP265CA0508.outlook.office365.com
 (2603:10a6:400:18b::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 22:04:36 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:36 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 30/32] net/ntnic: add igam module init
Date: Thu, 20 Feb 2025 23:03:54 +0100
Message-ID: <20250220220406.3925597-31-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|AM7P190MB0647:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 5d496f81-18b9-4c91-8822-08dd51fa906c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?r43o2MEBvbW2UiqfO/fMAkiJgUkpD+6junXojWTKaHDYBXPi5y4kNNM7g+Pd?=
 =?us-ascii?Q?afzrlIcNfqYgFi+Amk5n55m2Ksg0VkwqcnOxOoWu22p2ESNWrydU81/HqaJz?=
 =?us-ascii?Q?2Vb2L4DHqdQo9CSqcfMLJNxAR61upLrnmYCtoIz0GoWwjYmNZHUZqChBFwIU?=
 =?us-ascii?Q?FanlcgeUGLYHZleUDlp9PKoLpZ3Tdl22Kc1GMMfl4Frrm8Lr1LcGQTR1TtpX?=
 =?us-ascii?Q?qB+yoJ/ADAnr8caKj7adeQSwbkDOGa8Gz5pL9mTwpNQ8S9RYMC4leMYB1mYv?=
 =?us-ascii?Q?d4tZ7AnzJqFs/T61zgprmHtMvWtoMr0XzhCawTw73dyM4I0fij+hvC9URLUy?=
 =?us-ascii?Q?G5dgdCg1RRQLMBjHPrKPSVzCyd12m/rIqW6mFjunXG2jkHP8V71q6hVHdPFM?=
 =?us-ascii?Q?40zPtlvAyeZQWdPTNP5db9ICMcpk4RTyYKdTBOzNO/IVCOxT0OnSHxGzSEnF?=
 =?us-ascii?Q?yzHVH5WibRt9xGni/oRpiH5Ci8lCpN5WXQT/AwGKIcwOTvGYyzsh7lZMNO5R?=
 =?us-ascii?Q?9Op2+HAP59oQAgB4Ik1WPmD6g6GlUbOBWPD5H/OZUt2++puMxJOvgzkA3ZU3?=
 =?us-ascii?Q?+/cLAwLavBZyc1oAWZR/CW4Jgp0ekh1u9tDaBxYY7lvL/He+/j2B+Aj0HAy1?=
 =?us-ascii?Q?QTr1MS6OCVtM4EqCwr8OOV4Y5EyHE0s3QY6GbeIaQg1bIt/QZF5naJSfyqlp?=
 =?us-ascii?Q?m24z1HAIVwOzsg3CrJB95Xi9hoBAE1xY1o/Ys4hvi/kizqM7+zo8Cjyt8CWW?=
 =?us-ascii?Q?MSfhraY/b03J6QdhSVKrekfuVIZdlJxNMLylBIwNavuUVWa4fmqf3WbOeNkt?=
 =?us-ascii?Q?eFrB7Dsz078pZ+stwD+L+XhaH/A9LGipckS5RyobAOYDMoZOjlXB8IwZLxqT?=
 =?us-ascii?Q?IxJAGuZGjETWE5JmxiVYJ+HIaWqnNTWN14NUDwspwzwvIDDNL3dEVqwjRyZs?=
 =?us-ascii?Q?yR21O4KjkaXA6k4fpXrS2tRI3OpgYVRQOGWti7Jf4hNfqlPQxC8NR/sil1cv?=
 =?us-ascii?Q?qnluyXctTCe7noZXTb0eSBOQVC3feVKI3Ioy5PTwh+4srTq9W5Da2XT0TU9g?=
 =?us-ascii?Q?mCLp2WHP0qkKrBrwcmSuzkzCwnw5VlbOJcMzsJmrz7F7xHqSH8r5iJ9Wendn?=
 =?us-ascii?Q?yIjIxKVwRfF1qsh+dl5eYJq0GcipBFRpMO3tmvEDTcU0XDY3kt/KjCGhZZcI?=
 =?us-ascii?Q?9gF3exqXDyMBU5nzgftElAC4JSbGudbTAILJoEZ9lCS1vBTgTHfXggzK4a+R?=
 =?us-ascii?Q?4irdpww3xSOIBgkACUJKLmpKEEl7joe0B1r4tg1Z2q2x+judhyjxnPFwXRW5?=
 =?us-ascii?Q?iehrYSh/mmbz9HH62jLn3YaUlKVqLeAqjL69r4yT4hTwU2rZPWmmD5MC2GLb?=
 =?us-ascii?Q?MSI/nsPvymrkWBlr6MM5jJUpVf3yoqZcSzN66ygLxHfoNQH8QZcqQcLYQI10?=
 =?us-ascii?Q?pwwVB88Kql0ipBPUm4AYeVdblcMmDTFovt/jW6JhR7bZG4xR0L1LLYcw0E8N?=
 =?us-ascii?Q?imcAyPssVcF4xyg=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: Jv6T0MpLqIHHS9GnJTkeGmEf7gX4gA8Ueey93/njnQRWW3G2LQhD113/O/SBJFlu9X2RvYdGfsdU49qjFMEuR+CF5TZII0pq27aDKQIGlgRcOsD/R+K6hkZzzqnnwjADa8OPSu1IZunRAsK1m6PlQ7gVx7eYbspctZ0pLlJ7Ptb1yUm7AV3fSfzpaz6fMnYToZuG8D+Pq6oQz02Nj9QbHkgMX+w3VDZlgnZwo+ytICYkE/benyuA33lxuib3pO90m6JXASaTMSFUP0Gy9Xk8Lzx41WsVlK4md9/TutsiPAMMmoIIuujJem7D6TcMJ4j7bsle/zYKz1FAinIXI9SooW+M5JwAtFyT6ddwFstc7BoyRoHzlSpRn7f/ZDfkPYzWOWAkaR67y+05p12dV7bvFpB77+ub5EayhqIaxLhqyOQ0nIXu/vyYxQ57xaYBO0CcFP4npCCDFFrrWzkZmdrIgek0T1+69HzFKaMFqmfatBxpK/r7mV1dtTEHI1emzuIBoqn7sFeQGYvVy/gWdIO8hFV6l0B0MPUsu7+OkYM1UIxx2LW6+aMYdDq9zRhdREkcOb/nGavb01RvZXuDF+VXydzblXW8GpYZsW7ndZ8QkIg9/Wx/RmqaI7+a1/pqRpOs0n5dbFQua7dNwX1LVIRhz99q0qp03p+XQr5ksQJAOOU=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:36.2090 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d496f81-18b9-4c91-8822-08dd51fa906c
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7P190MB0647
X-BESS-ID: 1740089077-312005-29070-14102-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.18.112
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViZm5oZAVgZQ0DjN0Cg5ydQgMT
 XZ3DTZwDTZPMUkKdXCxNTSJNEixcxAqTYWAMTGZeJBAAAA
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

Create and initialize IGAM module.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/meson.build                 |  1 +
 .../net/ntnic/nthw/core/include/nthw_igam.h   | 37 +++++++++++
 .../nt400dxx/reset/nthw_fpga_rst_nt400dxx.c   |  4 ++
 drivers/net/ntnic/nthw/core/nthw_igam.c       | 62 +++++++++++++++++++
 4 files changed, 104 insertions(+)
 create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_igam.h
 create mode 100644 drivers/net/ntnic/nthw/core/nthw_igam.c

diff --git a/drivers/net/ntnic/meson.build b/drivers/net/ntnic/meson.build
index 7e326a3e1d..30a92130b5 100644
--- a/drivers/net/ntnic/meson.build
+++ b/drivers/net/ntnic/meson.build
@@ -56,6 +56,7 @@ sources = files(
         'nthw/core/nthw_gpio_phy.c',
         'nthw/core/nthw_hif.c',
         'nthw/core/nthw_i2cm.c',
+        'nthw/core/nthw_igam.c',
         'nthw/core/nthw_iic.c',
         'nthw/core/nthw_mac_pcs.c',
         'nthw/core/nthw_pcie3.c',
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_igam.h b/drivers/net/ntnic/nthw/core/include/nthw_igam.h
new file mode 100644
index 0000000000..e78637a331
--- /dev/null
+++ b/drivers/net/ntnic/nthw/core/include/nthw_igam.h
@@ -0,0 +1,37 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2023 Napatech A/S
+ */
+
+#ifndef __NTHW_IGAM_H__
+#define __NTHW_IGAM_H__
+
+#include "nthw_fpga_model.h"
+
+struct nt_igam {
+	nthw_fpga_t *mp_fpga;
+
+	nthw_module_t *mp_mod_igam;
+
+	int mn_igam_instance;
+
+	nthw_register_t *mp_reg_base;
+	nthw_field_t *mp_fld_base_ptr;
+	nthw_field_t *mp_fld_base_busy;
+	nthw_field_t *mp_fld_base_cmd;
+
+	nthw_register_t *mp_reg_data;
+	nthw_field_t *mp_fld_data_data;
+
+	/* CTRL From version 0.1 */
+	nthw_register_t *mp_reg_ctrl;
+	nthw_field_t *mp_fld_ctrl_forward_rst;
+};
+
+typedef struct nt_igam nthw_igam_t;
+typedef struct nt_igam nthw_igam;
+
+nthw_igam_t *nthw_igam_new(void);
+int nthw_igam_init(nthw_igam_t *p, nthw_fpga_t *p_fpga, int mn_igam_instance);
+
+#endif	/*  __NTHW_IGAM_H__ */
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
index 35cbaea81e..95394b9c8f 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
@@ -9,6 +9,7 @@
 #include "nthw_fpga.h"
 #include "nthw_hif.h"
 #include "ntnic_mod_reg.h"
+#include "nthw_igam.h"
 
 static int nthw_fpga_rst_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 {
@@ -198,6 +199,9 @@ static int nthw_fpga_rst_nt400dxx_reset(struct fpga_info_s *p_fpga_info)
 		return -1;
 	}
 
+	nthw_igam_t *p_igam = nthw_igam_new();
+	nthw_igam_init(p_igam, p_fpga, 0);
+
 	return 0;
 }
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_igam.c b/drivers/net/ntnic/nthw/core/nthw_igam.c
new file mode 100644
index 0000000000..5dc7e36c7b
--- /dev/null
+++ b/drivers/net/ntnic/nthw/core/nthw_igam.c
@@ -0,0 +1,62 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2023 Napatech A/S
+ */
+
+#include "nt_util.h"
+#include "ntlog.h"
+
+#include "nthw_drv.h"
+#include "nthw_register.h"
+
+#include "nthw_igam.h"
+
+nthw_igam_t *nthw_igam_new(void)
+{
+	nthw_igam_t *p = malloc(sizeof(nthw_igam_t));
+
+	if (p)
+		memset(p, 0, sizeof(nthw_igam_t));
+
+	return p;
+}
+
+int nthw_igam_init(nthw_igam_t *p, nthw_fpga_t *p_fpga, int mn_igam_instance)
+{
+	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
+	nthw_module_t *mod = nthw_fpga_query_module(p_fpga, MOD_IGAM, mn_igam_instance);
+
+	if (p == NULL)
+		return mod == NULL ? -1 : 0;
+
+	if (mod == NULL) {
+		NT_LOG(ERR, NTHW, "%s: IGAM %d: no such instance", p_adapter_id_str,
+			mn_igam_instance);
+		return -1;
+	}
+
+	p->mp_fpga = p_fpga;
+	p->mn_igam_instance = mn_igam_instance;
+
+	p->mp_mod_igam = mod;
+
+	p->mp_reg_base = nthw_module_get_register(p->mp_mod_igam, IGAM_BASE);
+	p->mp_fld_base_ptr = nthw_register_get_field(p->mp_reg_base, IGAM_BASE_PTR);
+	p->mp_fld_base_busy = nthw_register_get_field(p->mp_reg_base, IGAM_BASE_BUSY);
+	p->mp_fld_base_cmd = nthw_register_get_field(p->mp_reg_base, IGAM_BASE_CMD);
+
+	p->mp_reg_data = nthw_module_get_register(p->mp_mod_igam, IGAM_DATA);
+	p->mp_fld_data_data = nthw_register_get_field(p->mp_reg_data, IGAM_DATA_DATA);
+
+	p->mp_reg_ctrl = nthw_module_query_register(p->mp_mod_igam, IGAM_CTRL);
+
+	if (p->mp_reg_ctrl) {
+		p->mp_fld_ctrl_forward_rst =
+			nthw_register_get_field(p->mp_reg_ctrl, IGAM_CTRL_FORWARD_RST);
+
+	} else {
+		p->mp_fld_ctrl_forward_rst = NULL;
+	}
+
+	return 0;
+}
-- 
2.45.0

