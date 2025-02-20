Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DD31C021B4
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:06:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70CD940E2B;
	Thu, 20 Feb 2025 23:04:45 +0100 (CET)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 285BD40B97
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:33 +0100 (CET)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2170.outbound.protection.outlook.com [104.47.17.170]) by
 mx-outbound21-132.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sYglSab0UavZaWV3UhHDPF24QzVZJFi5FnEmO96apvR6kkRZ1dH6vS+MY5GvnFywLCzBlvzk/91brujMkXkGZP5Eff4wOmJZWbFAdDTV3939Wd4sSGDahzZI3kqZoj7u4VhaBVe+a5UbK2UsU/Y++f1RLLeU46rWfHUB7S8ITbhRsPONfyfed2FpdYrnP1G++acoDTvdlGmwPH5SKJ8tPmbM98vC6eofZMtVhbg6hcOKJz81RQNaXMr0a/mdybs/kKcSiKJmCGbcUhDdGXsKtLjQZTHxjpbnBhDI8bvm8f1Q/mURnT4shXluLt+HFwWCKaPsXRXVckh5TNEz0IPIuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KJeVxRj64KKwZQ15ywUXHgXr6w7vzh//scgzs0D+bP8=;
 b=brBEpNHyDSzGz4ZqIQCmY0ESdlAoiVq0gY/EVZHIGkDfzxTzJ+oNFbsAoc2WYwt16LPptYx7wi8u8Bj2j2aS6bk0Z8ImXLubn8z1kFb4D9j9oIt8rQKMr8/FJUXRVNTolfqhmNokN9zT/Mc3rWq6WRVrtXf9g2jb/z/vuptGIbH0AeErRFyheiw6kYmWSAgE+YxdA8ZoQkMOuQ5ORVJLRd336ZjnKyNp8+jvIbMcbohLQ1etSsgnPcE3LwwX/z42dByOtDnAUln7C8zlGvniBc07JV7nptQrxbpymAtzZmadKG1Mufuop4NJ6ugmNBOOML1J9zKKJ1n/cOIx11UBkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KJeVxRj64KKwZQ15ywUXHgXr6w7vzh//scgzs0D+bP8=;
 b=jK8j4hxir2bz0SalgJ3FQ8oR1q6kwpaGA7JKT059boIQ/XWVksJC8J2iV8bf7M+wSYRr9EA56Cosz02JbC+q636F79xhZPKFB0IDpAvLD8OdX/WQUnqSCogzszHrKVMldCKzVt1Epz7PXl7lqkQ3POL3pGrY9BPQvmB6DTnXR50=
Received: from CWLP265CA0501.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::22)
 by GVXP190MB2076.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:149::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.16; Thu, 20 Feb
 2025 22:04:28 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::30) by CWLP265CA0501.outlook.office365.com
 (2603:10a6:400:18b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 22:04:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:28 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 21/32] net/ntnic: add nt400d13 pcm init
Date: Thu, 20 Feb 2025 23:03:45 +0100
Message-ID: <20250220220406.3925597-22-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|GVXP190MB2076:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6be9c872-573d-400e-1e2b-08dd51fa8bb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Gi58407ovv+S+wSnYWl8+zUeqnl7oJBEYafoUJiOzYS7dPvCxCigwj3JHpsy?=
 =?us-ascii?Q?6zYwA02Bjrr5dwHgwQ+jqtAkC0fbwvDU/dnU0+NRDL39M3o6iD5BTjRlafY2?=
 =?us-ascii?Q?VfVqjaLJ9A8D/9v5eXPyf0AmIABp9d953UbyYeittpWsry0RH2b3k3tD0OO6?=
 =?us-ascii?Q?4cuQvnpK8+6vYO6s0QgZTWRY1S/MqW9oiedoDEKpc6MGesJP2C9l/aFQhFsm?=
 =?us-ascii?Q?9/cFU5x5njvTB7klsvxkOMU19K5JkRqsjJ7gCFsx5LwHMOoD+kwr3ZuHFS5/?=
 =?us-ascii?Q?gAywva5Mv/FYXox+hQ7uzC1iJt8jCONYLbpBlcex/M7OWq63GyYT2dKsu5lP?=
 =?us-ascii?Q?AOj7Rm3Jdlq88j5iaFUgucuXHImHA/MEDzWlwvI1g22VfHb0Miilr2sL5ngP?=
 =?us-ascii?Q?BDQtdvuMQdUmmdU8qd7RVOFux7COc6hS257nWrfdax3SoSEhKkTQfZebAymn?=
 =?us-ascii?Q?aijhePiJ+0LKxmjNwzA4E/rVRkbq0Usj1khYkMSXb0neglJi3mtua+L4k2Mf?=
 =?us-ascii?Q?RPX3KruviM9yfvRKZaOzb6dNkZvTNQUFaJmtIlH6YbPJvkqxxg5dwJnYxH+b?=
 =?us-ascii?Q?Lz74sDLG2L8JNOzCuuh7cv/jPUXIsylbfUAxwCWw1kgQnqPxnzyX6u8YMWkF?=
 =?us-ascii?Q?zEaTa1pq7s8Rz2RG0+HGaywizbrvxw89hMDx6x8b50ZVHNkSOsRhtuOSsGQP?=
 =?us-ascii?Q?6hOTBMnCz/36YOJ17hhwtZgSbqLUCsYXhoBe3EHVXshPX6osxC8w3OqWMsb+?=
 =?us-ascii?Q?Yo+WAcJ1mUfXlm1Akr0NNxKBpqiqYQJ/d6SoF5DW+xb8Cwjohx9T4sg5YXeQ?=
 =?us-ascii?Q?QBxJY/Q4/7p47wMdYnVtRngDBG6fZvDwiYaJuoe4zA5KIWGRBvh5hwrRFEMP?=
 =?us-ascii?Q?nVvv7FmQ7J+Wk2hGLYHKZkN/B8A8Fv2OiA7GqGxpu/BEz25RtgMPVhrh8B0W?=
 =?us-ascii?Q?pA7680wNk2nHTFUvXMZH/etuma7CEGkx/dT6KquWHMyHahk5MGIjxCN5LZpv?=
 =?us-ascii?Q?7RLEo137c0PiYWuvcFq3wzVFGyyl7Af0rt7I9TCwYp2i8f/o11XXFD76Vf8a?=
 =?us-ascii?Q?1a8XNqUjzoME6iNBwxYLVGSTr1e3KW7WZSzgP4iUeldsFiLs3GojjSp2EiU6?=
 =?us-ascii?Q?7cbg1axeIWEWCo1mM33wZo1geSyMmt/DO4yd3VkXeFCatw7mJCtYYM3ihKz8?=
 =?us-ascii?Q?Ki9aDd0qOdK/wFnvgfGGkc+rgOR6uILhdu7sL97Dd6Lg5qrtA30YHAlAvPt0?=
 =?us-ascii?Q?6dRcCiDj932hj+rxWnGmWASWiYwMdsKhDHxSuhwTAmyL/3nSBk569N2npah7?=
 =?us-ascii?Q?D8TwfrhWqCR72nqjtiLyUMscXXnhOzNoU5SYBYz4TqKuO4EXmDf4EAMougxc?=
 =?us-ascii?Q?eubAyq4MvH9WAY7NXlIYFg+ePa6mQDAAEbR+1shK2sO3KWDGOBOYiINUVziI?=
 =?us-ascii?Q?L9yP9/WHJAwrHQXUlFiU91705fWoP/ASLlRpF965I67LwkIlY2JgTV7ioYsv?=
 =?us-ascii?Q?PoCmfPNYr8qszEo=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: t23dVKsps/nXY4btWX67qIigc6qxDlYKl3V57suqSU39e0d4FTjHV79kQIMywYsdPzm87xBKmYJ1PEUtqhUrGSkvNptRMENZsFrMViPmKvMqRC62gO0SOGAWYeHaxN4EwsuXfvywMRGsNwfc8vk8yYpHr4kcgb9W5CbLeuc50zqB7hWl06HtMtAV/+42TEj54yJLmdljfgo37p/D4ZTF1YuIJCdOodntJ884HAQrDAziGoNPCcnp/t/Tm0qzGeYQ/VuQd49chuK1j8PC5Lr7hCaUFp4pqxuegxVsqPDO6ZJcu3KjtgJaH91Vzgd6Dx8Q3UvAhh/HDCkUofP4Wwu9ribXQgXMyeSUvXXFkWr5+dbwB9BJf3PTkrCOyxOrvVW3G3ZMjcM6j1y/Ianrq08vj6IdhpCeqx8O4hbhjHnRYrJGxrQm1l2eeekg745wuqzDn7lRqYKtNvXjyMC1iumcFqQZ9oGKAJFQp3eNZEjYyeEhFFVaw7u5DHSQfUrAZ5hyRrj6NtCxw+RhY3TQOy/W2Fd7fsMzsRphNOJopAPxpeor4IQCHbjpUZZSsPZBN4+xZBjg2Ybc3h5qb6Jhznr/+v/0xTmqnv1Kkklf0WrpuAJDf/QIszGb+Bk8kh6zuKz5wCxaySivsalWPgy//vIQmL+dogLsUzox+ZfIzwh7w0Y=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:28.2870 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6be9c872-573d-400e-1e2b-08dd51fa8bb6
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP190MB2076
X-BESS-ID: 1740089072-305508-25332-16464-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.17.170
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqamxpZAVgZQ0MwoycTQ2CAp1d
 DSyMLSyCDRKMnCINE8ySQpOcnY1DBRqTYWAFkQN79BAAAA
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

Initialize and create PCM for FPGA and HIF modules

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 drivers/net/ntnic/meson.build                 |  1 +
 .../nthw/core/include/nthw_pcm_nt400dxx.h     | 24 +++++++-
 .../nt400dxx/reset/nthw_fpga_rst_nt400dxx.c   | 18 ++++++
 .../net/ntnic/nthw/core/nthw_pcm_nt400dxx.c   | 56 +++++++++++++++++++
 drivers/net/ntnic/nthw/nthw_drv.h             |  1 +
 5 files changed, 99 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ntnic/nthw/core/nthw_pcm_nt400dxx.c

diff --git a/drivers/net/ntnic/meson.build b/drivers/net/ntnic/meson.build
index aec7b52714..b9ac069bcc 100644
--- a/drivers/net/ntnic/meson.build
+++ b/drivers/net/ntnic/meson.build
@@ -61,6 +61,7 @@ sources = files(
         'nthw/core/nthw_pcie3.c',
         'nthw/core/nthw_pca9532.c',
         'nthw/core/nthw_pcal6416a.c',
+        'nthw/core/nthw_pcm_nt400dxx.c',
         'nthw/core/nthw_phy_tile.c',
         'nthw/core/nthw_si5332_si5156.c',
         'nthw/core/nthw_rpf.c',
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_pcm_nt400dxx.h b/drivers/net/ntnic/nthw/core/include/nthw_pcm_nt400dxx.h
index 1e114886ca..23865f466b 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_pcm_nt400dxx.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_pcm_nt400dxx.h
@@ -5,10 +5,32 @@
 #ifndef __NTHW_PCM_NT400DXX_H__
 #define __NTHW_PCM_NT400DXX_H__
 
+#include "nthw_fpga_model.h"
+
 struct nthw_pcm_nt400_dxx {
+	nthw_fpga_t *mp_fpga;
+	nthw_module_t *mp_mod_pcm;
+	int mn_instance;
+
+	int mn_module_major_version;
 	int mn_module_minor_version;
+
+	nthw_register_t *mp_reg_ctrl;
+	nthw_field_t *mp_fld_ctrl_ts_pll_recal;	/* Dunite HW version 3 */
+	nthw_field_t *mp_fld_ctrl_ts_clksel;
+	nthw_field_t *mp_fld_ctrl_ts_pll_rst;
+
+	nthw_register_t *mp_reg_stat;
+	nthw_field_t *mp_fld_stat_ts_pll_locked;
+
+	nthw_register_t *mp_reg_latch;
+	nthw_field_t *mp_fld_latch_ts_pll_locked;
 };
 
 typedef struct nthw_pcm_nt400_dxx nthw_pcm_nt400dxx_t;
+typedef struct nthw_pcm_nt400_dxx nthw_pcm_nt400_dxx;
+
+nthw_pcm_nt400dxx_t *nthw_pcm_nt400dxx_new(void);
+int nthw_pcm_nt400dxx_init(nthw_pcm_nt400dxx_t *p, nthw_fpga_t *p_fpga, int n_instance);
 
-#endif  /* __NTHW_PCM_NT400DXX_H__ */
+#endif	/* __NTHW_PCM_NT400DXX_H__ */
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
index e0e4bc0861..1d93474cff 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
@@ -13,6 +13,24 @@
 static int nthw_fpga_rst_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 {
 	assert(p_fpga_info);
+	int res = -1;
+	nthw_fpga_t *p_fpga = NULL;
+
+	p_fpga = p_fpga_info->mp_fpga;
+
+	nthw_hif_t *p_nthw_hif = nthw_hif_new();
+	res = nthw_hif_init(p_nthw_hif, p_fpga, 0);
+
+	if (res == 0)
+		NT_LOG(DBG, NTHW, "%s: Hif module found", p_fpga_info->mp_adapter_id_str);
+
+	/* Create PCM */
+	p_fpga_info->mp_nthw_agx.p_pcm = nthw_pcm_nt400dxx_new();
+	res = nthw_pcm_nt400dxx_init(p_fpga_info->mp_nthw_agx.p_pcm, p_fpga, 0);
+
+	if (res != 0)
+		return res;
+
 	return 0;
 }
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_pcm_nt400dxx.c b/drivers/net/ntnic/nthw/core/nthw_pcm_nt400dxx.c
new file mode 100644
index 0000000000..f32a277e86
--- /dev/null
+++ b/drivers/net/ntnic/nthw/core/nthw_pcm_nt400dxx.c
@@ -0,0 +1,56 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2023 Napatech A/S
+ */
+#include "ntlog.h"
+#include "nthw_drv.h"
+#include "nthw_register.h"
+#include "nthw_fpga.h"
+
+#include "nthw_pcm_nt400dxx.h"
+
+nthw_pcm_nt400dxx_t *nthw_pcm_nt400dxx_new(void)
+{
+	nthw_pcm_nt400dxx_t *p = malloc(sizeof(nthw_pcm_nt400dxx_t));
+
+	if (p)
+		memset(p, 0, sizeof(nthw_pcm_nt400dxx_t));
+
+	return p;
+}
+
+int nthw_pcm_nt400dxx_init(nthw_pcm_nt400dxx_t *p, nthw_fpga_t *p_fpga, int n_instance)
+{
+	nthw_module_t *p_mod = nthw_fpga_query_module(p_fpga, MOD_PCM_NT400DXX, n_instance);
+
+	if (p == NULL)
+		return p_mod == NULL ? -1 : 0;
+
+	if (p_mod == NULL) {
+		NT_LOG(ERR, NTHW, "%s: PCM_NT400DXX %d: no such instance",
+			p->mp_fpga->p_fpga_info->mp_adapter_id_str, p->mn_instance);
+		return -1;
+	}
+
+	p->mp_mod_pcm = p_mod;
+
+	p->mp_fpga = p_fpga;
+	p->mn_instance = n_instance;
+
+	p->mn_module_major_version = nthw_module_get_major_version(p->mp_mod_pcm);
+	p->mn_module_minor_version = nthw_module_get_minor_version(p->mp_mod_pcm);
+
+	p->mp_reg_ctrl = nthw_module_get_register(p->mp_mod_pcm, PCM_NT400DXX_CTRL);
+	p->mp_fld_ctrl_ts_pll_recal =
+		nthw_register_query_field(p->mp_reg_ctrl, PCM_NT400DXX_CTRL_TS_PLL_RECAL);
+
+	p->mp_reg_stat = nthw_module_get_register(p->mp_mod_pcm, PCM_NT400DXX_STAT);
+	p->mp_fld_stat_ts_pll_locked =
+		nthw_register_get_field(p->mp_reg_stat, PCM_NT400DXX_STAT_TS_PLL_LOCKED);
+
+	p->mp_reg_latch = nthw_module_get_register(p->mp_mod_pcm, PCM_NT400DXX_LATCH);
+	p->mp_fld_latch_ts_pll_locked =
+		nthw_register_get_field(p->mp_reg_latch, PCM_NT400DXX_LATCH_TS_PLL_LOCKED);
+
+	return 0;
+}
diff --git a/drivers/net/ntnic/nthw/nthw_drv.h b/drivers/net/ntnic/nthw/nthw_drv.h
index 1d5b750db9..955d0a37b0 100644
--- a/drivers/net/ntnic/nthw/nthw_drv.h
+++ b/drivers/net/ntnic/nthw/nthw_drv.h
@@ -15,6 +15,7 @@
 #include "nthw_rpf.h"
 #include "nthw_pcm_nt400dxx.h"
 #include "nthw_phy_tile.h"
+#include "nthw_pcm_nt400dxx.h"
 
 /*
  * Structs for controlling Agilex based NT400DXX adapter
-- 
2.45.0

