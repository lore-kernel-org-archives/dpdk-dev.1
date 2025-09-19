Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5EBA2CAC59A
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 09:22:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7EBB340DD3;
	Fri, 19 Sep 2025 11:20:35 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 7586B40A6E
 for <dev@dpdk.org>; Fri, 19 Sep 2025 11:20:26 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11022128.outbound.protection.outlook.com
 [52.101.66.128]) by mx-outbound16-38.eu-central-1b.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 19 Sep 2025 09:20:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YoLYktvnH1S5lahxa+mqMBBnwjNMWedU6TWaQwBaM8WeQgJN2BIq454pko0o+++X+iSmv1qw+lRBlBVO+fnpmn2S1NL95+JIqu6Petqwq0Jh0bkO5iqTONnA1+6GCDY4OqEH+EfWXSR2mJ+EwTPg5+H1OLoJPSdCBya10DYtwY00cXc8PNMS8iCRPZeCFFqKsmRNVW5YGr4AKRrnHh9vZ7DIvTflsBPjcH0BrwSAcIzP92LcB28dnaCcvvHixnVmhJ3oCsPQOIK9Wnha3S+7MEPHM6uVIZrgJZ247kgHJtmApLx6aQm06ie8+mVf1i66JiNHrf22/289dFmhgfh2vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AXxbKbN1hoQIdQKywNuyv2AooPim27ylMC5LjrVycOU=;
 b=EDhUqV1rsGVDPLMf1Sta26wiNQ+/8Lszurdp0AGARCdtmECgsUf6zsMv/3y7nncAy1fp/IV06Ruy7sQJhva1u8gBf/e3flYChpXUCv2YUxO+eVdf0Rj5uXkOeY6M77n3ZalCAdrwIQhMB9ZWfNPt62QWQyXB2OOl+HOFfssxZcUIkMD1b6mo5axOCqoq3YrBol1f17RawqAdfxqULszDGozFSc0GT85kcfAw9Baxs4wvk9S0jGG9CSknzu0LWAERjEWhwKpLHoYkuNn+ytEwqqZY/SEZu4YHM2veX6RuMkHbb5l4AtXUjMJdoNNZFFT4ujthQPyFY9sVgnYkG8dyHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AXxbKbN1hoQIdQKywNuyv2AooPim27ylMC5LjrVycOU=;
 b=a9KdP3xzmS+m557iwpNviYysPo/VT7lBN6/NH6SPo5r80nDwxqobcncgw7Sj1RaH5/g0YJ4vRBJvJe082ENjem2+gUwLjtpgkpt7tO9Cs3ADRxDsVyNo8HSou+E42x72JieYuFEMLDsUaqCfUUdIcntKo4xTdqeUI64e2sacmGs=
Received: from DU2PR04CA0351.eurprd04.prod.outlook.com (2603:10a6:10:2b4::10)
 by AS8P190MB1221.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2ee::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.16; Fri, 19 Sep
 2025 09:20:23 +0000
Received: from DU2PEPF00028D0E.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::98) by DU2PR04CA0351.outlook.office365.com
 (2603:10a6:10:2b4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Fri,
 19 Sep 2025 09:20:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D0E.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server id 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025
 09:20:23 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 14/16] net/ntnic: rename ops_init functions
Date: Fri, 19 Sep 2025 11:14:59 +0200
Message-ID: <20250919091504.1548351-15-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250919091504.1548351-1-sil-plv@napatech.com>
References: <20250919091504.1548351-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0E:EE_|AS8P190MB1221:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e9ab002a-927b-4eb4-dcf4-08ddf75dc353
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Dc7RvDsDHZL2Wk6pB42QGWDoDjq1zP7fAPbM8+mXPpIIBmNrkDzG58O9F9N2?=
 =?us-ascii?Q?ATQsVOkATiMg3dLqhXpf+pOuRArhokS2CR5Cr5Su9TlF6XnmAv5ByIDzFoL+?=
 =?us-ascii?Q?qnUyVJgYeV3BpGJuy/jEAXrVNHhGN9k2Ng6QhXGTIPv+pu5+vhhsY/3/oE5v?=
 =?us-ascii?Q?ZCSgBdpsID83aIbz+nWUHMYr/CxSqopt2EV2PblH1lo4WAsfDcZBsNedrT0E?=
 =?us-ascii?Q?bFgoJn7DX8CPIa3zceqdf0fA1tH65MfYg0S+d7Qw9BotEAPS+Q9Yxr7YLoDQ?=
 =?us-ascii?Q?3Ii3JifxpVoUZcbgjpOkgiIqA62520QTfMf/HPpY3h8O10/fpRC/ghfL7VIR?=
 =?us-ascii?Q?WFyf43qnhCpVCHzxl6ZTed3VHQWxngvAGrXlKF6R1hZJJpalTKaMuNSfkPWe?=
 =?us-ascii?Q?PdGo4MGWklsJRrZYOvxGcZ/20ke3hLDT+D0iENjXQNLpQms0ZXwNDOPsc7yP?=
 =?us-ascii?Q?ZHnjFHAAZ/2eKBJXktklp3CqiODciF0Sg55phVR/aWIqIDbVTd6jL0duRag1?=
 =?us-ascii?Q?gMR6+UFcQ8Is6CXtKYIOnvkIeZODcaSXKcOIwYawzkaOkw5SwoouIDg3cjqU?=
 =?us-ascii?Q?2EzzcKv8PaaXzekOqZy5g4glusvQVvobVlPuP4ZPjN7FVZWG53fJ1YBmc7uX?=
 =?us-ascii?Q?ZRupoj/SkEESCAwWpQkXdjEDQP25cSwN/9xTs7fmYe0AI9AXV+mjNrkEkBgd?=
 =?us-ascii?Q?Yz4qOgr/ioDl+HW83mrjz4TEr2rjp73uZi9gWZNZW9Dr85LjXGFqWJDjg3zP?=
 =?us-ascii?Q?IMu9BIMwvAi66iAHPSlTL/8bxGjm9Kv3dYApOleHfWwHq6zTeDakLVZ1Y6bI?=
 =?us-ascii?Q?DOyTOWbdDTu/LH9rSIc5FnFfL6t3oBYhTaE2VaciX9unjdK1NtG8RwIUiCio?=
 =?us-ascii?Q?VIRbpLsnwFINKrQAH4oZfrX80Ardu1NaRFaPhDWM5lSeHLSUZ3ZANYrSP+Vc?=
 =?us-ascii?Q?Jg9R80PKvTZXsc1CQyfgk2tELfxlGIh6bqg5FHMlyC9hzOLjDn2djjg6c0c9?=
 =?us-ascii?Q?Jhw6uS1zqhl/VPilewNTA5CSSrshJaacefhkOAIHz+AOE1+ViWJX5EqaAUIc?=
 =?us-ascii?Q?r03b6bQpa5jKVZHRvecZzxvdV19IRnMSb7HQSHcFV1Ctk9uUot6P9GN+OMZF?=
 =?us-ascii?Q?OZcceHNpndXXUe5OM7vQv3Hl8CNHqLyZMCvabBdRwRpJIrK8Wcc5sac2bq5e?=
 =?us-ascii?Q?J3ojpgzq5e2jGqSxO5C3Wo/DcbODQamL5y/R+NkW0eW6WDOEHHRXcALeamzc?=
 =?us-ascii?Q?jKw6sg3VbM7GoPz8Kor1Nc98ai6k7qJa1vdHNpYB++qk+5e/XT32+5JvqzVY?=
 =?us-ascii?Q?9ThaMYsQIdjWRn3LSXyW2H8gZjqjyE5zrC07PThyG4YCa5bV/e7PNbERoAsr?=
 =?us-ascii?Q?FxotzZmOkqCAuib96D7pX/b7AChz/ygpu7/jfoV2NbBj9l85vWTPKwdhjIju?=
 =?us-ascii?Q?EL6miSNUjxve4UKpiw54cbMQMyMjvOt413hovoOnu9pxLF2VKD5MWoRJWH0o?=
 =?us-ascii?Q?ygNvT0bCN6d0e7fzB+UOEgNQVEQHwi9iMFVg?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: e04o5gGXxcHUd2C4vmbZiy43NkdLj9d/u3Z2OSOKa+gsN2LOVmIL6k6gnYQF5DwKuG9nz/ggKC38ASBEn6yEMX4mPwm6M0o80cnyx1pUnPv8LZ/St7zjl4SVFBBYH+ZXH1KBrXvlRuod6renUM8uX4TqlbFFxVCYGxTi+PXTjVw3xnQPxAX3ST1niQsWmmxTQXYInw0M3FqKKy6w15MdBwgsvZlIL8PaN3WepJD0y/0/8WRE/19Bph2qLD8eZhUBQLCf9lfwHkpi/jKa4WjjyA9cZNGcKrleTze8PsHDXMNPrOadVCB6xBcqVFZ28Wl8dYZECjVZS6az1QMB9WrpD54r8CQKsBvxh0ZorG8z7fKy8/YvAobVddN6dGyt0U8c3ezkIOBoWk1I97G7Pmnw71aWoZ+SWKJx1HOGw4KWJ8qx/OGSDyxCxjvrkDbaDnteocKfBQMCH9vrdLPIUpznWByQkl/UbqXk9MYbTd8gDZA+1HRWnG8aW3Dk/l4oqvl1kI0/Gb0btdiJ00s3PwcCq/NqXV55X5uEB1kUBTe5jkMEGGsJnXsiIVOSY6ASLR0JLxTmcttpk+mk1/YxNuys0kuNr6OodRY3wTehJXJxIK34OWs3Wa8dgLetH6UrmT4FzSh706+4YgpSUF4OYm4b7w==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 09:20:23.6047 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e9ab002a-927b-4eb4-dcf4-08ddf75dc353
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1221
X-BESS-ID: 1758273624-304134-7641-1099-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.66.128
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmJkYGQGYGUNTMwDDZzNLIzD
 DRNC3VwNDQ2DTVKNHcwNjQNMXQ1NQ4Sak2FgDkwaprQgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267598 [from 
 cloudscan23-127.eu-central-1b.ess.aws.cudaops.com]
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

