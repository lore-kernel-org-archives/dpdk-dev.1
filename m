Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40E41CAC5A5
	for <dpdk-dev@archiver.kernel.org>; Wed, 24 Sep 2025 14:45:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 180EA40E4D;
	Wed, 24 Sep 2025 16:42:42 +0200 (CEST)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 5BB7040DDC
 for <dev@dpdk.org>; Wed, 24 Sep 2025 16:42:22 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11021089.outbound.protection.outlook.com
 [40.107.130.89]) by mx-outbound42-195.eu-central-1c.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 24 Sep 2025 14:42:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zJUyGgGcJtW3mFeIVipaDeufnq8vc2u0M4o10Rpp0+/Nc8Cr3jM+REecNTL2uhTMZ6FGtYOa8o7LnVmm7gBNidhakHr9JfhXrZb0CvwZhVdFPtYTXegdt0PODQmgsR7AirX820PMqCkMG3qyC93LPX1+b53Wi9Dd66Q72wf1Bb/tJWeYQpayT60QoJ5NFVBzpyfrbfG01L7aA4P6sHgLVP58SgoY155ZlowuefKEk4zmOiErp34DhQLMjPtjtkDHwx020V6T8SIgReXZgrghys78/S54MSNKfOj07w4c2GXsEMGpleezhJBBVj/mU1N7ti9CFo2L+nRE84hrlHYj1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXxbKbN1hoQIdQKywNuyv2AooPim27ylMC5LjrVycOU=;
 b=bmniWojAVJ6Vvif6ls6DFoh3+BYufBkch/fF+c0tmIHYJcSS3NSTR8V/dz4MhACDPQ0rW+vleQEzzVDoK4JGj/IDApdpf3f48vPKsEt15RfoGdliTU+S+4CHCCixd23U8YeT2tp++AzI5+UKc510HWlrHSxuo3pudehjoMVvS2ySUYrtsAJps7gHCmLIyD6nasLPtsCd8m/XVqQY/bpTcTjwj0k5Z8solkFX/qax9uL7S1JR+DH5OgTyKlyhJWRatAUA1c9j3P1fXJfj2M1oqrACk+xnNUy0e8GumD6S+xQuUM6Dny1BvipmJLLdZki3FN8vt83dQTGtvaVKUrVT+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXxbKbN1hoQIdQKywNuyv2AooPim27ylMC5LjrVycOU=;
 b=kM0ko+GX4bPgF6AvYLWih6QJqExMvEcaZIQfRKoXgpcbhvfKZ563Ivm/B+lWekPRiAyay9DfcDcEdUZj6omfs8euqUpbXYiu5SoJAFmTew+gi3HpKt31t5GiWw3BEDFHbppZNayybgpSDbA7a+A7RdyrOxZCSxL0EWbZ7vZia10=
Received: from CWLP123CA0230.GBRP123.PROD.OUTLOOK.COM (2603:10a6:400:19f::15)
 by AS4P190MB1950.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:515::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.20; Wed, 24 Sep
 2025 14:42:16 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:400:19f:cafe::b6) by CWLP123CA0230.outlook.office365.com
 (2603:10a6:400:19f::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.20 via Frontend Transport; Wed,
 24 Sep 2025 14:42:16 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.9160.9 via Frontend Transport; Wed, 24 Sep 2025 14:42:16
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 22/24] net/ntnic: rename ops init functions
Date: Wed, 24 Sep 2025 16:41:45 +0200
Message-ID: <20250924144152.53203-23-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250924144152.53203-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20250924144152.53203-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|AS4P190MB1950:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ffb0530f-0835-440b-68a4-08ddfb788ec9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?y6aSQ471eBy4K3oswR/hojIHoxFPmgXYU86i8+jnJaCgvu6IR+0WZG3ewnmU?=
 =?us-ascii?Q?h4av/71uqBMbEELso99iwaXM86YrpbDcC5UJPVKEXUBRwqg3rLuWM8phDNSx?=
 =?us-ascii?Q?w/dLbd8s7Xa4sdScoi+VtNnZDPXN64GU+/yprHgjEDeJb6OfY5LUT8pqDxfi?=
 =?us-ascii?Q?RHU3+7YO2EU/dILsck7MwDBFmeLCfJneVet/K/XtuTZZ8/In0hFEAs4oepej?=
 =?us-ascii?Q?29rqckfzA7s5KK47lBQR46kc9pn24KsN7yrH0OMuwxINsI0EyGFR9nN8K9hN?=
 =?us-ascii?Q?o0AF1nGYOUL4UDw5jQUGMY+5JK18+NVRVMUET+6s66THEipXFwHBXwFrg35P?=
 =?us-ascii?Q?ArCLDV2MaMyhogeLkORBOsAF+CuWfu1LE0nDeEeH78PZ7t25sWgaLhOSpSj5?=
 =?us-ascii?Q?XGOrWm00HQB73xcfUNsGxcvMLcdY2uuwQoCanE56or4to4L2FzxTiFyz+KwL?=
 =?us-ascii?Q?wLdve1bMmQydgkTpA1xAj3dSwDJTI0Tktz+ZQg0kFVh+66z+fBE/AdtF5uDE?=
 =?us-ascii?Q?4RkXLEagUFqzD9x0HpyBQF+Q7//KUOC34mXfqsAylU30+KvtBk+5eMX3ifgI?=
 =?us-ascii?Q?OaA3z/6jDBFTBbuFbJ3Ato+nG3cFdt5wZowtZGOz72+By7C3OBhRU38KkUFM?=
 =?us-ascii?Q?RCygdx6CcgN/gTOZiUfTGAntvcD1Xl24bgTbqdKVaQSEg6CNr47cXTGa92I1?=
 =?us-ascii?Q?ygLqHxkooxh9ndt0vEzgKDNqftvOQsE50oll36m546+v4ZJaN/oaPa7yKB9S?=
 =?us-ascii?Q?zN3g95zqJV5BhhScxePVAuojes8ZzmkmUAqJjDwyRXF1FL4tyOOlcIdPJiLc?=
 =?us-ascii?Q?mLHpF7j9bmeHoXL42MtVGzBO10p9dPhzDfwsvYcLKvQCNdCRdhqecmaOvNoV?=
 =?us-ascii?Q?cAdO1cquJ58Q7WiEN1z4x9Zonicfu9st8Q6NRM5AFZQBlygYy85Mcud+MDKr?=
 =?us-ascii?Q?pda9SoxCQ+WyjmztiMaQ20xBh53CBP27yLRjj2ieTAkJRnHM/aU0iGGfdB+V?=
 =?us-ascii?Q?ZBmLmDVUwJVTo+y3m+CTDYV7zfZNNMnwM55A2PWibl2tNywyLIXey3TppMhv?=
 =?us-ascii?Q?x2qONWdHeLLTQDjyKgDSPjh6aIRKcVPYT1qZNso2raYsURvBiotvW0Se/Aw9?=
 =?us-ascii?Q?PTckVGaYfgI2f+A3xCsF02El1Rt5NuDFNQ+lTfTZNXRYS3ADSojvCgsTT3QA?=
 =?us-ascii?Q?rvrlfiFOXzoMu7Wn423ryjjOJPx1jk3U9dTS7TMoQvtZQ41mWHNnAsYhWPed?=
 =?us-ascii?Q?BpTYKn2kaWjClRJSMiAlAo+eLICkoAJCdlg0pb5gML2q2mKgZgXWVqYx7OAL?=
 =?us-ascii?Q?1B5LlidEnzBPgiARVZnuA3AD/B6WjdG+5ZHoEPRMHfU5xP0KUxT5yv+PB2fh?=
 =?us-ascii?Q?Ly7xAPh16Da2liU5pMmeXytv655vrJZKB+/VN6W5UsxAt/il/IYz8vOQCBYz?=
 =?us-ascii?Q?bblKd/O5B8s7M+frgLa6vioMhNEevduIdHpQ4md5TlpLWFwo6Gsl6V0QG24d?=
 =?us-ascii?Q?BK5GiDNpTTR45htX1Awal7DzYAmxJgj/RczI?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: QvOHuxfrUS/4pUc5EQYqPN5SDQzEBKFceKMlQxVjCAKZgoW1gELGGr0suri8UzXJf1Llc5IEnEhR42qYtnp+ArChejJ3XtUzYQr7DRnzYWoJ1RWp8eGxE33GTxlvjelHhssCgxZnZRVxdBMWVCSsHORo6mwi8475jRXF2XXvxpB9HzirfO86mE12xP6OJVeF+BkPD9OU/bQ442NL9mw758ANRmpZGNUxZSc8K7mHMcbAJbe9L/nIZoVFVTz1ulCBOidqmDLkilVAs6TekdJFwdeMHcRfg/9X35r2p92DC5Uu2TPMtZI/Al6D/9Pe+os5JC3W34hlItzPhBNZleMzlvirGb8mVhp+qZ1xaFQunH40KJ7MFonRVto5u/OwVJLjQWTa31rxwnS0VSmD8ElvlSpDkoH91Ii5zRackmfr+Khf6N2tY+GNWGOGpbRObdnAG8PxoAZJ7+attHmNS+gQT5yznDgZKK/1jsF49UDo46hW72S4ivPlW7H0Va+DZIun7wBV8fKdShjXfk3i0DB+UAPo/GzHxi3Qo9p/rZAlodj4Ua0Qjoh0kEldyxc9bOUnh9QNpcSzZkWGy/OY93P3Xzr/1UQXbCKWoLp91MN7XiUUNfo52Jp587qlEntMMX1UNnI2L23KHCnuz3LR88/3OA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Sep 2025 14:42:16.5674 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ffb0530f-0835-440b-68a4-08ddfb788ec9
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P190MB1950
X-BESS-ID: 1758724939-310947-7723-8063-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 40.107.130.89
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmJkYGQGYGUNTMwDDZzNLIzD
 DRNC3VwNDQ2DTVKNHcwNjQNMXQ1NQ4Sak2FgDkwaprQgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267723 [from 
 cloudscan8-225.eu-central-1a.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.50 BSF_RULE7568M          META: Custom Rule 7568M 
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
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

Add prefix nthw_ to ops init function to follow the naming convention.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c  |  2 +-
 .../link_agx_100g/nt4ga_agx_link_100g.c        |  2 +-
 .../net/ntnic/nthw/core/include/nthw_fpga.h    |  4 ++--
 .../clock_profiles/nthw_fpga_clk9563.c         |  2 +-
 .../nthw/core/nt200a0x/nthw_fpga_nt200a0x.c    |  2 +-
 .../core/nt200a0x/reset/nthw_fpga_rst9563.c    |  2 +-
 .../nt200a0x/reset/nthw_fpga_rst_nt200a0x.c    |  2 +-
 .../nthw/core/nt400dxx/nthw_fpga_nt400dxx.c    |  2 +-
 .../core/nt400dxx/reset/nthw_fpga_rst9574.c    |  2 +-
 .../nt400dxx/reset/nthw_fpga_rst_nt400dxx.c    |  2 +-
 drivers/net/ntnic/nthw/core/nthw_fpga.c        |  4 ++--
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c  |  2 +-
 drivers/net/ntnic/ntnic_mod_reg.c              | 18 +++++++++---------
 drivers/net/ntnic/ntnic_mod_reg.h              | 18 +++++++++---------
 drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c  |  2 +-
 15 files changed, 33 insertions(+), 33 deletions(-)

diff --git a/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c b/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
index 0f7e1f2b00..57b5b147f8 100644
--- a/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
+++ b/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
@@ -593,7 +593,7 @@ static struct nt4ga_stat_ops ops = {
 	.nt4ga_stat_collect = nt4ga_stat_collect
 };
 
-void nt4ga_stat_ops_init(void)
+void nthw_stat_ops_init(void)
 {
 	NT_LOG_DBGX(DBG, NTNIC, "Stat module was initialized");
 	nthw_reg_nt4ga_stat_ops(&ops);
diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index 1387bb4148..36ecf0d0ec 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -35,7 +35,7 @@ static struct link_ops_s link_agx_100g_ops = {
 	.link_init = nt4ga_agx_link_100g_ports_init,
 };
 
-void link_agx_100g_init(void)
+void nthw_link_agx_100g_ops_init(void)
 {
 	nthw_reg_agx_100g_link_ops(&link_agx_100g_ops);
 }
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_fpga.h b/drivers/net/ntnic/nthw/core/include/nthw_fpga.h
index 9838ad3c07..532d19d6b8 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_fpga.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_fpga.h
@@ -34,7 +34,7 @@ struct nt200a0x_ops {
 
 void nthw_reg_nt200a0x_ops(struct nt200a0x_ops *ops);
 struct nt200a0x_ops *nthw_get_nt200a0x_ops(void);
-void nt200a0x_ops_init(void);
+void nthw_nt200a0x_ops_init(void);
 
 struct nt400dxx_ops {
 	int (*nthw_fpga_nt400dxx_init)(struct fpga_info_s *p_fpga_info);
@@ -42,6 +42,6 @@ struct nt400dxx_ops {
 
 void nthw_reg_nt400dxx_ops(struct nt400dxx_ops *ops);
 struct nt400dxx_ops *nthw_get_nt400dxx_ops(void);
-void nt400dxx_ops_init(void);
+void nthw_nt400dxx_ops_init(void);
 
 #endif	/* __NTHW_FPGA_H__ */
diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/nthw_fpga_clk9563.c b/drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/nthw_fpga_clk9563.c
index eeca816899..91c9795956 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/nthw_fpga_clk9563.c
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/nthw_fpga_clk9563.c
@@ -33,7 +33,7 @@ static struct clk9563_ops ops = { .get_n_data_9563_si5340_nt200a02_u23_v5 =
 			get_p_data_9563_si5340_nt200a02_u23_v5
 };
 
-void clk9563_ops_init(void)
+void nthw_clk9563_ops_init(void)
 {
 	nthw_reg_clk9563_ops(&ops);
 }
diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/nthw_fpga_nt200a0x.c b/drivers/net/ntnic/nthw/core/nt200a0x/nthw_fpga_nt200a0x.c
index 371177c14f..20bacf8988 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/nthw_fpga_nt200a0x.c
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/nthw_fpga_nt200a0x.c
@@ -69,7 +69,7 @@ static int nthw_fpga_nt200a0x_init(struct fpga_info_s *p_fpga_info)
 
 static struct nt200a0x_ops nt200a0x_ops = { .nthw_fpga_nt200a0x_init = nthw_fpga_nt200a0x_init };
 
-void nt200a0x_ops_init(void)
+void nthw_nt200a0x_ops_init(void)
 {
 	NT_LOG(DBG, NTHW, "NT200A0X OPS INIT");
 	nthw_reg_nt200a0x_ops(&nt200a0x_ops);
diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c
index f3a28e801e..c99c9ecbe6 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c
@@ -233,7 +233,7 @@ static int nthw_fpga_rst9563_init(struct fpga_info_s *p_fpga_info,
 
 static struct rst9563_ops rst9563_ops = { .nthw_fpga_rst9563_init = nthw_fpga_rst9563_init };
 
-void rst9563_ops_init(void)
+void nthw_rst9563_ops_init(void)
 {
 	NT_LOG(DBG, NTHW, "RST9563 OPS INIT");
 	nthw_reg_rst9563_ops(&rst9563_ops);
diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c
index 4a2fca5f19..39345369ef 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c
@@ -575,7 +575,7 @@ static struct rst_nt200a0x_ops rst_nt200a0x_ops = { .nthw_fpga_rst_nt200a0x_init
 			nthw_fpga_rst_nt200a0x_reset
 };
 
-void rst_nt200a0x_ops_init(void)
+void nthw_rst_nt200a0x_ops_init(void)
 {
 	NT_LOG(DBG, NTHW, "RST NT200A0X OPS INIT");
 	nthw_reg_rst_nt200a0x_ops(&rst_nt200a0x_ops);
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
index 1f87e36d08..cc4bee9d4d 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
@@ -213,7 +213,7 @@ static int nthw_fpga_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 
 static struct nt400dxx_ops nt400dxx_ops = { .nthw_fpga_nt400dxx_init = nthw_fpga_nt400dxx_init };
 
-void nt400dxx_ops_init(void)
+void nthw_nt400dxx_ops_init(void)
 {
 	nthw_reg_nt400dxx_ops(&nt400dxx_ops);
 }
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
index 36d2c46fc6..38614e9365 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
@@ -371,7 +371,7 @@ static struct rst9574_ops rst9574_ops = {
 	.nthw_fpga_rst9574_setup = nthw_fpga_rst9574_setup,
 };
 
-void rst9574_ops_init(void)
+void nthw_rst9574_ops_init(void)
 {
 	nthw_reg_rst9574_ops(&rst9574_ops);
 }
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
index 67c562627d..90d0680b99 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
@@ -421,7 +421,7 @@ static struct rst_nt400dxx_ops rst_nt400dxx_ops = {
 	.nthw_fpga_rst_nt400dxx_reset = nthw_fpga_rst_nt400dxx_reset
 };
 
-void rst_nt400dxx_ops_init(void)
+void nthw_rst_nt400dxx_ops_init(void)
 {
 	nthw_reg_rst_nt400dxx_ops(&rst_nt400dxx_ops);
 }
diff --git a/drivers/net/ntnic/nthw/core/nthw_fpga.c b/drivers/net/ntnic/nthw/core/nthw_fpga.c
index 0e1f686b4f..24cfb6c284 100644
--- a/drivers/net/ntnic/nthw/core/nthw_fpga.c
+++ b/drivers/net/ntnic/nthw/core/nthw_fpga.c
@@ -565,7 +565,7 @@ void nthw_reg_nt200a0x_ops(struct nt200a0x_ops *ops)
 struct nt200a0x_ops *nthw_get_nt200a0x_ops(void)
 {
 	if (nt200a0x_ops == NULL)
-		nt200a0x_ops_init();
+		nthw_nt200a0x_ops_init();
 	return nt200a0x_ops;
 }
 
@@ -579,6 +579,6 @@ void nthw_reg_nt400dxx_ops(struct nt400dxx_ops *ops)
 struct nt400dxx_ops *nthw_get_nt400dxx_ops(void)
 {
 	if (nt400dxx_ops == NULL)
-		nt400dxx_ops_init();
+		nthw_nt400dxx_ops_init();
 	return nt400dxx_ops;
 }
diff --git a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
index 5a0ef125be..813ac04481 100644
--- a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
+++ b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
@@ -1289,7 +1289,7 @@ static const struct ntnic_filter_ops ntnic_filter_ops = {
 	.poll_statistics = poll_statistics,
 };
 
-void ntnic_filter_init(void)
+void nthw_filter_ops_init(void)
 {
 	nthw_reg_filter_ops(&ntnic_filter_ops);
 }
diff --git a/drivers/net/ntnic/ntnic_mod_reg.c b/drivers/net/ntnic/ntnic_mod_reg.c
index 67ba694e25..00eb07f848 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.c
+++ b/drivers/net/ntnic/ntnic_mod_reg.c
@@ -50,7 +50,7 @@ void nthw_reg_filter_ops(const struct ntnic_filter_ops *ops)
 const struct ntnic_filter_ops *nthw_get_filter_ops(void)
 {
 	if (ntnic_filter_ops == NULL)
-		ntnic_filter_init();
+		nthw_filter_ops_init();
 
 	return ntnic_filter_ops;
 }
@@ -82,7 +82,7 @@ void nthw_reg_agx_100g_link_ops(struct link_ops_s *ops)
 const struct link_ops_s *nthw_get_agx_100g_link_ops(void)
 {
 	if (link_agx_100g_ops == NULL)
-		link_agx_100g_init();
+		nthw_link_agx_100g_ops_init();
 	return link_agx_100g_ops;
 }
 
@@ -110,7 +110,7 @@ void nthw_reg_nt4ga_stat_ops(const struct nt4ga_stat_ops *ops)
 const struct nt4ga_stat_ops *nthw_get_nt4ga_stat_ops(void)
 {
 	if (nt4ga_stat_ops == NULL)
-		nt4ga_stat_ops_init();
+		nthw_stat_ops_init();
 
 	return nt4ga_stat_ops;
 }
@@ -139,7 +139,7 @@ void nthw_reg_clk9563_ops(struct clk9563_ops *ops)
 struct clk9563_ops *nthw_get_clk9563_ops(void)
 {
 	if (clk9563_ops == NULL)
-		clk9563_ops_init();
+		nthw_clk9563_ops_init();
 	return clk9563_ops;
 }
 
@@ -153,7 +153,7 @@ void nthw_reg_rst_nt200a0x_ops(struct rst_nt200a0x_ops *ops)
 struct rst_nt200a0x_ops *nthw_get_rst_nt200a0x_ops(void)
 {
 	if (rst_nt200a0x_ops == NULL)
-		rst_nt200a0x_ops_init();
+		nthw_rst_nt200a0x_ops_init();
 	return rst_nt200a0x_ops;
 }
 
@@ -167,7 +167,7 @@ void nthw_reg_rst9563_ops(struct rst9563_ops *ops)
 struct rst9563_ops *nthw_get_rst9563_ops(void)
 {
 	if (rst9563_ops == NULL)
-		rst9563_ops_init();
+		nthw_rst9563_ops_init();
 	return rst9563_ops;
 }
 
@@ -188,7 +188,7 @@ void nthw_reg_rst9574_ops(struct rst9574_ops *ops)
 struct rst9574_ops *nthw_get_rst9574_ops(void)
 {
 	if (rst9574_ops == NULL)
-		rst9574_ops_init();
+		nthw_rst9574_ops_init();
 
 	return rst9574_ops;
 }
@@ -203,7 +203,7 @@ void nthw_reg_rst_nt400dxx_ops(struct rst_nt400dxx_ops *ops)
 struct rst_nt400dxx_ops *nthw_get_rst_nt400dxx_ops(void)
 {
 	if (rst_nt400dxx_ops == NULL)
-		rst_nt400dxx_ops_init();
+		nthw_rst_nt400dxx_ops_init();
 
 	return rst_nt400dxx_ops;
 }
@@ -286,7 +286,7 @@ void nthw_reg_xstats_ops(struct ntnic_xstats_ops *ops)
 struct ntnic_xstats_ops *nthw_get_xstats_ops(void)
 {
 	if (ntnic_xstats_ops == NULL)
-		ntnic_xstats_ops_init();
+		nthw_xstats_ops_init();
 
 	return ntnic_xstats_ops;
 }
diff --git a/drivers/net/ntnic/ntnic_mod_reg.h b/drivers/net/ntnic/ntnic_mod_reg.h
index 2ed2286911..b534b09234 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.h
+++ b/drivers/net/ntnic/ntnic_mod_reg.h
@@ -141,7 +141,7 @@ struct ntnic_filter_ops {
 
 void nthw_reg_filter_ops(const struct ntnic_filter_ops *ops);
 const struct ntnic_filter_ops *nthw_get_filter_ops(void);
-void ntnic_filter_init(void);
+void nthw_filter_ops_init(void);
 
 struct link_ops_s {
 	int (*link_init)(struct adapter_info_s *p_adapter_info, nthw_fpga_t *p_fpga);
@@ -153,7 +153,7 @@ void nthw_link_100g_init(void);
 
 void nthw_reg_agx_100g_link_ops(struct link_ops_s *ops);
 const struct link_ops_s *nthw_get_agx_100g_link_ops(void);
-void link_agx_100g_init(void);
+void nthw_link_agx_100g_ops_init(void);
 
 struct port_ops {
 	bool (*get_nim_present)(struct adapter_info_s *p, int port);
@@ -220,7 +220,7 @@ struct nt4ga_stat_ops {
 
 void nthw_reg_nt4ga_stat_ops(const struct nt4ga_stat_ops *ops);
 const struct nt4ga_stat_ops *nthw_get_nt4ga_stat_ops(void);
-void nt4ga_stat_ops_init(void);
+void nthw_stat_ops_init(void);
 
 struct adapter_ops {
 	int (*init)(struct adapter_info_s *p_adapter_info);
@@ -240,7 +240,7 @@ struct clk9563_ops {
 
 void nthw_reg_clk9563_ops(struct clk9563_ops *ops);
 struct clk9563_ops *nthw_get_clk9563_ops(void);
-void clk9563_ops_init(void);
+void nthw_clk9563_ops_init(void);
 
 struct rst_nt200a0x_ops {
 	int (*nthw_fpga_rst_nt200a0x_init)(struct fpga_info_s *p_fpga_info,
@@ -251,7 +251,7 @@ struct rst_nt200a0x_ops {
 
 void nthw_reg_rst_nt200a0x_ops(struct rst_nt200a0x_ops *ops);
 struct rst_nt200a0x_ops *nthw_get_rst_nt200a0x_ops(void);
-void rst_nt200a0x_ops_init(void);
+void nthw_rst_nt200a0x_ops_init(void);
 
 struct rst9563_ops {
 	int (*nthw_fpga_rst9563_init)(struct fpga_info_s *p_fpga_info,
@@ -260,7 +260,7 @@ struct rst9563_ops {
 
 void nthw_reg_rst9563_ops(struct rst9563_ops *ops);
 struct rst9563_ops *nthw_get_rst9563_ops(void);
-void rst9563_ops_init(void);
+void nthw_rst9563_ops_init(void);
 
 struct rst9574_ops {
 	int (*nthw_fpga_rst9574_init)(struct fpga_info_s *p_fpga_info,
@@ -271,7 +271,7 @@ struct rst9574_ops {
 
 void nthw_reg_rst9574_ops(struct rst9574_ops *ops);
 struct rst9574_ops *nthw_get_rst9574_ops(void);
-void rst9574_ops_init(void);
+void nthw_rst9574_ops_init(void);
 
 struct rst_nt400dxx_ops {
 	int (*nthw_fpga_rst_nt400dxx_init)(struct fpga_info_s *p_fpga_info);
@@ -280,7 +280,7 @@ struct rst_nt400dxx_ops {
 
 void nthw_reg_rst_nt400dxx_ops(struct rst_nt400dxx_ops *ops);
 struct rst_nt400dxx_ops *nthw_get_rst_nt400dxx_ops(void);
-void rst_nt400dxx_ops_init(void);
+void nthw_rst_nt400dxx_ops_init(void);
 
 struct flow_backend_ops {
 	const struct flow_api_backend_ops *(*nthw_bin_flow_backend_init)(nthw_fpga_t *p_fpga,
@@ -593,6 +593,6 @@ struct ntnic_xstats_ops {
 
 void nthw_reg_xstats_ops(struct ntnic_xstats_ops *ops);
 struct ntnic_xstats_ops *nthw_get_xstats_ops(void);
-void ntnic_xstats_ops_init(void);
+void nthw_xstats_ops_init(void);
 
 #endif	/* __NTNIC_MOD_REG_H__ */
diff --git a/drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c b/drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c
index 1ebf1b8eb5..ab3f144fa2 100644
--- a/drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c
+++ b/drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c
@@ -819,7 +819,7 @@ static struct ntnic_xstats_ops ops = {
 	.nthw_xstats_get_by_id = nthw_xstats_get_by_id
 };
 
-void ntnic_xstats_ops_init(void)
+void nthw_xstats_ops_init(void)
 {
 	NT_LOG_DBGX(DBG, NTNIC, "xstats module was initialized");
 	nthw_reg_xstats_ops(&ops);
-- 
2.45.0

