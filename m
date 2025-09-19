Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90B2FCAC592
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 09:21:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C631240DCA;
	Fri, 19 Sep 2025 11:20:33 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 0D4D3406BC
 for <dev@dpdk.org>; Fri, 19 Sep 2025 11:20:26 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11020086.outbound.protection.outlook.com [52.101.69.86])
 by mx-outbound16-38.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 19 Sep 2025 09:20:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=W0YehtEgJWWJslejzGWTyWXkwHp61O8EP/jabRJ0mDgkSwG4m/3hQF0D/88Luy1Lo9G6SF1j/LIT+SnxbcIPvvTUbzMiGnuF3m0DmMBpl3+e5IHBf6z7fhE37hMKlNl6+gLHxU/LlYumtN2ritggQRChKFhCp/YF1Csy1ttOSqmhmj2COgWB0fRi9TrXAZALpTzJAE9uhqDKJ9/kCDXoNWELHTDa42aEnQ/eQh5E/Ov3PENiUy+JIEI5Cqec7xqDt2GfgkJJdamNhpW02loW/BFd0lvXhnUdKUcyScENL0lmIVlnE1uxIprIoLq4rb16x5myVDhZEiQuCrV1s/jxSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MXiI46OtNaaZdWrslOcAuved9nHv6jnMMjx/bxmgnig=;
 b=ZxSAenluD/wTDdn12iNwwkU3XbIU+UEDX7LVquBfjGapXjQInwYycADrN9g7Li615vknrYAN/UhAqxeS+nFTlWKiT9No2jSl7i9KNg41Kg7woxqJ4/8AZFCsh+S8P1fUrXFHluXm+exjEoTeXFm44tsBhUAFJAS7ngw2ca5taMtrNTWi2S2RpeW/mxN8ZDUV4G/upe83cyX0EapqzAiOAMiEROLOLWNNQLVSQW3qVgyeo+KplhW7b1jCKu7O5nhEpv4jvm0kgcdAMxCkdx2rV8gDS+dYez4NW+jWr7AuO7ngPwSMzh4HSE8RQLsuXwnDIeiiiCl1FdQwX9rLtUOLmA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MXiI46OtNaaZdWrslOcAuved9nHv6jnMMjx/bxmgnig=;
 b=KVQzb1dPNsuTYtkOiZp4BalU5TIbktm0NUyGzH3ZvcasTHRzitBiyrPAiE0pYrgeu8LMslB61nJckSFf01kk3SvMplrirqxOLApQShsTndiCB/G+eV+JwFOAwWUpUR6f21U1oRIbFYKfChbr32lx/ON5QE4xjIaCAdAkHnTOREA=
Received: from DU2PR04CA0356.eurprd04.prod.outlook.com (2603:10a6:10:2b4::14)
 by AS8P190MB1031.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2b5::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9115.22; Fri, 19 Sep
 2025 09:20:22 +0000
Received: from DU2PEPF00028D0E.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::59) by DU2PR04CA0356.outlook.office365.com
 (2603:10a6:10:2b4::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.13 via Frontend Transport; Fri,
 19 Sep 2025 09:20:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D0E.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server id 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025
 09:20:21 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 12/16] net/ntnic: rename register ops function
Date: Fri, 19 Sep 2025 11:14:57 +0200
Message-ID: <20250919091504.1548351-13-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250919091504.1548351-1-sil-plv@napatech.com>
References: <20250919091504.1548351-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0E:EE_|AS8P190MB1031:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 4db2938d-7b43-4c07-7a5f-08ddf75dc24d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?fOWMg/iv3tjhoSPIX4oIlDimlrsu+MrYzfXs57dOZMd+dzsdhmfm6VN2GqeX?=
 =?us-ascii?Q?54VnYbEaxbeliJmTWjv/tW/z08p8ogcBAnoS8jkPWvuU0be+qtjyxcLacKmY?=
 =?us-ascii?Q?ft0Xvs2z1wn7Vzi8tN56VP3gqEhoXTielhLaxLTLHQibpr9x61FqdJvtdnQ1?=
 =?us-ascii?Q?unZ6oc30PeVolffBaF3JFtn4vrE32Z3FOHSbkHM9MstP5n37+oXc+M2F74E3?=
 =?us-ascii?Q?DODdd+0eih77Vnh3y26epKItDq5AyurqU3zNWL3EkbapXZh+cCpyEFXhYavt?=
 =?us-ascii?Q?HSPS6n9av8gBbQHFu5xDdVc6CwtBdcTtHKAkjP2VJhJYow2W1Jfi/Ykb3ZrF?=
 =?us-ascii?Q?8U0ZZteszYD2zBnMrbiudve5OzVr0BeQpbjvpBtofkSuPzvYgTJa8s+jySTc?=
 =?us-ascii?Q?/vOA1IjzD29F61SwbmZy6L3l9YiQ5GTSn2JKW4tZcee2nUJTtkpue9HvgpaN?=
 =?us-ascii?Q?9D/LNJjZvAwyKoVUVi2mTJoCvSPA5ZFA9+WW35WRdvpTVNPV01Tvrmg1Q3aY?=
 =?us-ascii?Q?2N6cc7BctTN9CBdOZA7B/blfFm+XPME5dRSRvouMrC8RQx63H5QaXTNy/9Ar?=
 =?us-ascii?Q?rHtQ7zfejuNaWI/kTubptSsCir9Fb61tdzACSh9ZiW3Jj7NvTLtTX6gpeqDm?=
 =?us-ascii?Q?/7foGDqXamXQ2oECWBZF5Vy1HLoRQFfGRavHMdFVpORH5z0ffIcyGPyFy4rk?=
 =?us-ascii?Q?4JDYUkSKXMPVLxC+/kD6033uUFd/7M8hZu9jJLqg6Wetg/xqoXA/e1QlW6/x?=
 =?us-ascii?Q?5KztBr8TtAc13l7SfXEJQIw/iAdp2EkUnZQ+HrLG1zZxl9wYby/T4WeAD6nP?=
 =?us-ascii?Q?nUgWG5Y3lW6yLBMzqjwfVbpYyfEVJhHAE1R0ZS855m85zp48gmrYFWhw9yle?=
 =?us-ascii?Q?gf8026zcd4nTonUeUbUwN3bA8Fw/f4kiZKrlfvfCMSmCg3T1/vUFCC01ywGD?=
 =?us-ascii?Q?ZW82+DwbdV7th7TLI4cMN1Ps9CeljY9McOPGBVIGs+UUmlzNAwsmwPOXjLqv?=
 =?us-ascii?Q?RK1t/Xmskc5q5vtgwbaTqGgC31sNTC7lVrHdWtJqga8HaIT0h5SgQQCt2efa?=
 =?us-ascii?Q?xgD0dLPYQYX28u3PzbHm3MJ31M1ba8zIolbgidJkM7lZVIqwctP/ZWkl6df2?=
 =?us-ascii?Q?LFXWH0Q7xYdMWvjeWrSR2/+GnSIZPJd5U5/cXtOdkOhjHCZ4IkL6+3meUe3Q?=
 =?us-ascii?Q?qpQVxrEQWvDzmFkxtYGgiq5LnQcnUwL56ejmSCJBqj5JaPgVfBZG+vtGDKMi?=
 =?us-ascii?Q?+umCYC3iokYyqylCVgHMKmntyQTH1iqBZCup9J4mXChSri7XsvJV+XP5xU65?=
 =?us-ascii?Q?bFPWemZdTTZQdP3JN9FerWnD8lys9D3zswJUvgj52TMstWG9BzBgs71b1Hzs?=
 =?us-ascii?Q?SvUYldyw8tVKmTRKvdeDDKL9EoAvP3buhUcBvPh5mfM0890K4rW92Vq7FioW?=
 =?us-ascii?Q?YhGS50l4FaA3omcquy6qkdfUjXzSFSMOAi8VMsIuUsRPf0uCe0Ktxs8AsgUu?=
 =?us-ascii?Q?GUz0wy9j/xgYGN069tETl1C49AA9QjSzwmz4?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: phsnCTFTeOVb6EvGWJw6qCKn+AaK7lqDjP8N2+QMwHpAsI7Bk+MaJhR9tHIB+JmX3UHhelX+lkuV+rhLDHC3XRBop4Yio1ErmFdFx66M8Zwz0vKrl27MBUU7BqtYkaxVuAKKFxhryDotKfyfTdGIuCw0haOcZuXpBwkhbP3rydXXo3cmlypIbLgXJ6o479E18nb+S49jzLegzLw0byI+jZ9pcFnrY69IJ5RhGiUPhRmurNr1UHPZAJqfJiWekzzsHkXYfshtmPFXgm4/YAzLslVbQsYBWOWAQWpIRn+qyS4JAj7kxXelT4yiLG35/x8zcmzL6048lOOqTAyrF5vbM6k+JUHGpL+CxSNVWn89xhWD/PzQfNgxLUEJp3NvL1bXIYTO6emFmQtkas7vwbG3F7aYJvTX0cpkVJXrCpiFYMvTx7pCNSecN3ymALk29Tv6VeMP8MKPStUoxKPse2yXzbxF7z2zpvrdcbrX12vggwkVG0B6TOxqBynfMN2MS9tTH3mTtC7qxCPcfTuZq8DMrc81p0r7u1g7SW5Iktl+gKQ9Tm+EtNfUROClKK5NPtloWg5X+Y2iiOo968hmBU1bt3f15ymQ8AuzUxXIHbnwFKcjfpD6pw55b7wvOQuY6WzeJgDdXptx5lUks1bE26xjmg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 09:20:21.8858 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4db2938d-7b43-4c07-7a5f-08ddf75dc24d
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1031
X-BESS-ID: 1758273623-304134-7644-1098-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.69.86
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkbGlqaWQGYGUDQ51cLC3CDJNN
 k40dTSKMnYMs3UJDHJ1Cg1LdE4JS0pWak2FgAcZcadQgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267598 [from 
 cloudscan22-120.eu-central-1b.ess.aws.cudaops.com]
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

Add prefix nthw_ to register ops function to follow naming convention.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/adapter/nt4ga_adapter.c     |  2 +-
 .../net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c |  2 +-
 drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c |  2 +-
 .../link_mgmt/link_100g/nt4ga_link_100g.c     |  2 +-
 .../link_agx_100g/nt4ga_agx_link_100g.c       |  2 +-
 drivers/net/ntnic/link_mgmt/nt4ga_link.c      |  2 +-
 .../net/ntnic/nthw/core/include/nthw_fpga.h   |  4 +-
 .../clock_profiles/nthw_fpga_clk9563.c        |  2 +-
 .../nthw/core/nt200a0x/nthw_fpga_nt200a0x.c   |  2 +-
 .../core/nt200a0x/reset/nthw_fpga_rst9563.c   |  2 +-
 .../nt200a0x/reset/nthw_fpga_rst_nt200a0x.c   |  2 +-
 .../nthw/core/nt400dxx/nthw_fpga_nt400dxx.c   |  2 +-
 .../core/nt400dxx/reset/nthw_fpga_rst9574.c   |  2 +-
 .../nt400dxx/reset/nthw_fpga_rst_nt400dxx.c   |  2 +-
 drivers/net/ntnic/nthw/core/nthw_fpga.c       |  4 +-
 drivers/net/ntnic/nthw/flow_api/flow_api.c    |  2 +-
 .../nthw/flow_api/flow_backend/flow_backend.c |  2 +-
 .../profile_inline/flow_api_profile_inline.c  |  2 +-
 .../net/ntnic/nthw/ntnic_meter/ntnic_meter.c  |  2 +-
 drivers/net/ntnic/ntnic_filter/ntnic_filter.c |  6 +--
 drivers/net/ntnic/ntnic_mod_reg.c             | 38 +++++++++----------
 drivers/net/ntnic/ntnic_mod_reg.h             | 38 +++++++++----------
 drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c |  2 +-
 23 files changed, 63 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ntnic/adapter/nt4ga_adapter.c b/drivers/net/ntnic/adapter/nt4ga_adapter.c
index 98725879b9..5295387fa8 100644
--- a/drivers/net/ntnic/adapter/nt4ga_adapter.c
+++ b/drivers/net/ntnic/adapter/nt4ga_adapter.c
@@ -283,5 +283,5 @@ static const struct adapter_ops ops = {
 
 void nthw_adapter_init(void)
 {
-	register_adapter_ops(&ops);
+	nthw_reg_adapter_ops(&ops);
 }
diff --git a/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c b/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
index 9d0d77dcc8..aca88c6635 100644
--- a/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
+++ b/drivers/net/ntnic/adapter/nt4ga_stat/nt4ga_stat.c
@@ -596,5 +596,5 @@ static struct nt4ga_stat_ops ops = {
 void nt4ga_stat_ops_init(void)
 {
 	NT_LOG_DBGX(DBG, NTNIC, "Stat module was initialized");
-	register_nt4ga_stat_ops(&ops);
+	nthw_reg_nt4ga_stat_ops(&ops);
 }
diff --git a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
index 3257233545..0fa597d777 100644
--- a/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
+++ b/drivers/net/ntnic/dbsconfig/ntnic_dbsconfig.c
@@ -1451,5 +1451,5 @@ static struct sg_ops_s sg_ops = {
 void nthw_sg_init(void)
 {
 	NT_LOG(INF, NTNIC, "SG ops initialized");
-	register_sg_ops(&sg_ops);
+	nthw_reg_sg_ops(&sg_ops);
 }
diff --git a/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c b/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
index 2c7a88aed9..914d1c206c 100644
--- a/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_100g/nt4ga_link_100g.c
@@ -747,5 +747,5 @@ static struct link_ops_s link_100g_ops = {
 
 void nthw_link_100g_init(void)
 {
-	register_100g_link_ops(&link_100g_ops);
+	nthw_reg_100g_link_ops(&link_100g_ops);
 }
diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index b700a9e76e..1387bb4148 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -37,7 +37,7 @@ static struct link_ops_s link_agx_100g_ops = {
 
 void link_agx_100g_init(void)
 {
-	register_agx_100g_link_ops(&link_agx_100g_ops);
+	nthw_reg_agx_100g_link_ops(&link_agx_100g_ops);
 }
 
 /*
diff --git a/drivers/net/ntnic/link_mgmt/nt4ga_link.c b/drivers/net/ntnic/link_mgmt/nt4ga_link.c
index 5ddbb9f1fd..5e6be42398 100644
--- a/drivers/net/ntnic/link_mgmt/nt4ga_link.c
+++ b/drivers/net/ntnic/link_mgmt/nt4ga_link.c
@@ -210,5 +210,5 @@ static const struct port_ops ops = {
 
 void nthw_port_init(void)
 {
-	register_port_ops(&ops);
+	nthw_reg_port_ops(&ops);
 }
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_fpga.h b/drivers/net/ntnic/nthw/core/include/nthw_fpga.h
index fb47807a2f..b86865b24f 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_fpga.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_fpga.h
@@ -32,7 +32,7 @@ struct nt200a0x_ops {
 	int (*nthw_fpga_nt200a0x_init)(struct fpga_info_s *p_fpga_info);
 };
 
-void register_nt200a0x_ops(struct nt200a0x_ops *ops);
+void nthw_reg_nt200a0x_ops(struct nt200a0x_ops *ops);
 struct nt200a0x_ops *get_nt200a0x_ops(void);
 void nt200a0x_ops_init(void);
 
@@ -40,7 +40,7 @@ struct nt400dxx_ops {
 	int (*nthw_fpga_nt400dxx_init)(struct fpga_info_s *p_fpga_info);
 };
 
-void register_nt400dxx_ops(struct nt400dxx_ops *ops);
+void nthw_reg_nt400dxx_ops(struct nt400dxx_ops *ops);
 struct nt400dxx_ops *get_nt400dxx_ops(void);
 void nt400dxx_ops_init(void);
 
diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/nthw_fpga_clk9563.c b/drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/nthw_fpga_clk9563.c
index e50094c6fa..eeca816899 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/nthw_fpga_clk9563.c
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/nthw_fpga_clk9563.c
@@ -35,7 +35,7 @@ static struct clk9563_ops ops = { .get_n_data_9563_si5340_nt200a02_u23_v5 =
 
 void clk9563_ops_init(void)
 {
-	register_clk9563_ops(&ops);
+	nthw_reg_clk9563_ops(&ops);
 }
 
 #undef si5340_revd_registers
diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/nthw_fpga_nt200a0x.c b/drivers/net/ntnic/nthw/core/nt200a0x/nthw_fpga_nt200a0x.c
index bf7a2760a4..739b1aab85 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/nthw_fpga_nt200a0x.c
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/nthw_fpga_nt200a0x.c
@@ -72,5 +72,5 @@ static struct nt200a0x_ops nt200a0x_ops = { .nthw_fpga_nt200a0x_init = nthw_fpga
 void nt200a0x_ops_init(void)
 {
 	NT_LOG(DBG, NTHW, "NT200A0X OPS INIT");
-	register_nt200a0x_ops(&nt200a0x_ops);
+	nthw_reg_nt200a0x_ops(&nt200a0x_ops);
 }
diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c
index 918ac71a43..a345f163bb 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c
@@ -236,5 +236,5 @@ static struct rst9563_ops rst9563_ops = { .nthw_fpga_rst9563_init = nthw_fpga_rs
 void rst9563_ops_init(void)
 {
 	NT_LOG(DBG, NTHW, "RST9563 OPS INIT");
-	register_rst9563_ops(&rst9563_ops);
+	nthw_reg_rst9563_ops(&rst9563_ops);
 }
diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c
index 34527b0cca..4a2fca5f19 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c
@@ -578,5 +578,5 @@ static struct rst_nt200a0x_ops rst_nt200a0x_ops = { .nthw_fpga_rst_nt200a0x_init
 void rst_nt200a0x_ops_init(void)
 {
 	NT_LOG(DBG, NTHW, "RST NT200A0X OPS INIT");
-	register_rst_nt200a0x_ops(&rst_nt200a0x_ops);
+	nthw_reg_rst_nt200a0x_ops(&rst_nt200a0x_ops);
 }
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
index e7c9fec10d..234da0da33 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
@@ -215,5 +215,5 @@ static struct nt400dxx_ops nt400dxx_ops = { .nthw_fpga_nt400dxx_init = nthw_fpga
 
 void nt400dxx_ops_init(void)
 {
-	register_nt400dxx_ops(&nt400dxx_ops);
+	nthw_reg_nt400dxx_ops(&nt400dxx_ops);
 }
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
index 28769e3aa5..36d2c46fc6 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
@@ -373,5 +373,5 @@ static struct rst9574_ops rst9574_ops = {
 
 void rst9574_ops_init(void)
 {
-	register_rst9574_ops(&rst9574_ops);
+	nthw_reg_rst9574_ops(&rst9574_ops);
 }
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
index d158135c17..67c562627d 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
@@ -423,5 +423,5 @@ static struct rst_nt400dxx_ops rst_nt400dxx_ops = {
 
 void rst_nt400dxx_ops_init(void)
 {
-	register_rst_nt400dxx_ops(&rst_nt400dxx_ops);
+	nthw_reg_rst_nt400dxx_ops(&rst_nt400dxx_ops);
 }
diff --git a/drivers/net/ntnic/nthw/core/nthw_fpga.c b/drivers/net/ntnic/nthw/core/nthw_fpga.c
index f9ae466383..f18069e492 100644
--- a/drivers/net/ntnic/nthw/core/nthw_fpga.c
+++ b/drivers/net/ntnic/nthw/core/nthw_fpga.c
@@ -557,7 +557,7 @@ int nthw_fpga_shutdown(struct fpga_info_s *p_fpga_info)
 
 static struct nt200a0x_ops *nt200a0x_ops;
 
-void register_nt200a0x_ops(struct nt200a0x_ops *ops)
+void nthw_reg_nt200a0x_ops(struct nt200a0x_ops *ops)
 {
 	nt200a0x_ops = ops;
 }
@@ -571,7 +571,7 @@ struct nt200a0x_ops *get_nt200a0x_ops(void)
 
 static struct nt400dxx_ops *nt400dxx_ops;
 
-void register_nt400dxx_ops(struct nt400dxx_ops *ops)
+void nthw_reg_nt400dxx_ops(struct nt400dxx_ops *ops)
 {
 	nt400dxx_ops = ops;
 }
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_api.c b/drivers/net/ntnic/nthw/flow_api/flow_api.c
index dee2ee137a..b737589e14 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_api.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_api.c
@@ -1283,5 +1283,5 @@ static const struct flow_filter_ops ops = {
 
 void nthw_init_flow_filter(void)
 {
-	register_flow_filter_ops(&ops);
+	nthw_reg_flow_filter_ops(&ops);
 }
diff --git a/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c b/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c
index 8144e25540..567b735f1e 100644
--- a/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c
+++ b/drivers/net/ntnic/nthw/flow_api/flow_backend/flow_backend.c
@@ -2277,5 +2277,5 @@ static const struct flow_backend_ops ops = {
 
 void nthw_flow_backend_init(void)
 {
-	register_flow_backend_ops(&ops);
+	nthw_reg_flow_backend_ops(&ops);
 }
diff --git a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
index a1f9e3addf..3f80e0f945 100644
--- a/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
+++ b/drivers/net/ntnic/nthw/flow_api/profile_inline/flow_api_profile_inline.c
@@ -5446,5 +5446,5 @@ static const struct profile_inline_ops ops = {
 
 void nthw_profile_inline_init(void)
 {
-	register_profile_inline_ops(&ops);
+	nthw_reg_profile_inline_ops(&ops);
 }
diff --git a/drivers/net/ntnic/nthw/ntnic_meter/ntnic_meter.c b/drivers/net/ntnic/nthw/ntnic_meter/ntnic_meter.c
index 303c2cd51a..a2c37774fe 100644
--- a/drivers/net/ntnic/nthw/ntnic_meter/ntnic_meter.c
+++ b/drivers/net/ntnic/nthw/ntnic_meter/ntnic_meter.c
@@ -485,5 +485,5 @@ static struct meter_ops_s meter_ops = {
 void nthw_meter_init(void)
 {
 	NT_LOG(DBG, NTNIC, "Meter ops initialized");
-	register_meter_ops(&meter_ops);
+	nthw_reg_meter_ops(&meter_ops);
 }
diff --git a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
index f498551e8d..2d0d0ea54f 100644
--- a/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
+++ b/drivers/net/ntnic/ntnic_filter/ntnic_filter.c
@@ -1291,7 +1291,7 @@ static const struct ntnic_filter_ops ntnic_filter_ops = {
 
 void ntnic_filter_init(void)
 {
-	register_ntnic_filter_ops(&ntnic_filter_ops);
+	nthw_reg_filter_ops(&ntnic_filter_ops);
 }
 
 static const struct rte_flow_ops dev_flow_ops = {
@@ -1313,7 +1313,7 @@ static const struct rte_flow_ops dev_flow_ops = {
 
 void nthw_dev_flow_init(void)
 {
-	register_dev_flow_ops(&dev_flow_ops);
+	nthw_reg_dev_flow_ops(&dev_flow_ops);
 }
 
 static struct rte_flow_fp_ops async_dev_flow_ops = {
@@ -1323,5 +1323,5 @@ static struct rte_flow_fp_ops async_dev_flow_ops = {
 
 void nthw_dev_fp_flow_init(void)
 {
-	register_dev_fp_flow_ops(&async_dev_flow_ops);
+	nthw_reg_dev_fp_flow_ops(&async_dev_flow_ops);
 }
diff --git a/drivers/net/ntnic/ntnic_mod_reg.c b/drivers/net/ntnic/ntnic_mod_reg.c
index 36aee48818..be872aa090 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.c
+++ b/drivers/net/ntnic/ntnic_mod_reg.c
@@ -7,7 +7,7 @@
 
 static struct sg_ops_s *sg_ops;
 
-void register_sg_ops(struct sg_ops_s *ops)
+void nthw_reg_sg_ops(struct sg_ops_s *ops)
 {
 	sg_ops = ops;
 }
@@ -24,7 +24,7 @@ const struct sg_ops_s *get_sg_ops(void)
  */
 static struct meter_ops_s *meter_ops;
 
-void register_meter_ops(struct meter_ops_s *ops)
+void nthw_reg_meter_ops(struct meter_ops_s *ops)
 {
 	meter_ops = ops;
 }
@@ -42,7 +42,7 @@ const struct meter_ops_s *get_meter_ops(void)
  */
 static const struct ntnic_filter_ops *ntnic_filter_ops;
 
-void register_ntnic_filter_ops(const struct ntnic_filter_ops *ops)
+void nthw_reg_filter_ops(const struct ntnic_filter_ops *ops)
 {
 	ntnic_filter_ops = ops;
 }
@@ -57,7 +57,7 @@ const struct ntnic_filter_ops *get_ntnic_filter_ops(void)
 
 static struct link_ops_s *link_100g_ops;
 
-void register_100g_link_ops(struct link_ops_s *ops)
+void nthw_reg_100g_link_ops(struct link_ops_s *ops)
 {
 	link_100g_ops = ops;
 }
@@ -74,7 +74,7 @@ const struct link_ops_s *get_100g_link_ops(void)
  */
 static struct link_ops_s *link_agx_100g_ops;
 
-void register_agx_100g_link_ops(struct link_ops_s *ops)
+void nthw_reg_agx_100g_link_ops(struct link_ops_s *ops)
 {
 	link_agx_100g_ops = ops;
 }
@@ -88,7 +88,7 @@ const struct link_ops_s *get_agx_100g_link_ops(void)
 
 static const struct port_ops *port_ops;
 
-void register_port_ops(const struct port_ops *ops)
+void nthw_reg_port_ops(const struct port_ops *ops)
 {
 	port_ops = ops;
 }
@@ -102,7 +102,7 @@ const struct port_ops *get_port_ops(void)
 
 static const struct nt4ga_stat_ops *nt4ga_stat_ops;
 
-void register_nt4ga_stat_ops(const struct nt4ga_stat_ops *ops)
+void nthw_reg_nt4ga_stat_ops(const struct nt4ga_stat_ops *ops)
 {
 	nt4ga_stat_ops = ops;
 }
@@ -117,7 +117,7 @@ const struct nt4ga_stat_ops *get_nt4ga_stat_ops(void)
 
 static const struct adapter_ops *adapter_ops;
 
-void register_adapter_ops(const struct adapter_ops *ops)
+void nthw_reg_adapter_ops(const struct adapter_ops *ops)
 {
 	adapter_ops = ops;
 }
@@ -131,7 +131,7 @@ const struct adapter_ops *get_adapter_ops(void)
 
 static struct clk9563_ops *clk9563_ops;
 
-void register_clk9563_ops(struct clk9563_ops *ops)
+void nthw_reg_clk9563_ops(struct clk9563_ops *ops)
 {
 	clk9563_ops = ops;
 }
@@ -145,7 +145,7 @@ struct clk9563_ops *get_clk9563_ops(void)
 
 static struct rst_nt200a0x_ops *rst_nt200a0x_ops;
 
-void register_rst_nt200a0x_ops(struct rst_nt200a0x_ops *ops)
+void nthw_reg_rst_nt200a0x_ops(struct rst_nt200a0x_ops *ops)
 {
 	rst_nt200a0x_ops = ops;
 }
@@ -159,7 +159,7 @@ struct rst_nt200a0x_ops *get_rst_nt200a0x_ops(void)
 
 static struct rst9563_ops *rst9563_ops;
 
-void register_rst9563_ops(struct rst9563_ops *ops)
+void nthw_reg_rst9563_ops(struct rst9563_ops *ops)
 {
 	rst9563_ops = ops;
 }
@@ -173,14 +173,14 @@ struct rst9563_ops *get_rst9563_ops(void)
 
 static const struct flow_backend_ops *flow_backend_ops;
 
-void register_flow_backend_ops(const struct flow_backend_ops *ops)
+void nthw_reg_flow_backend_ops(const struct flow_backend_ops *ops)
 {
 	flow_backend_ops = ops;
 }
 
 static struct rst9574_ops *rst9574_ops;
 
-void register_rst9574_ops(struct rst9574_ops *ops)
+void nthw_reg_rst9574_ops(struct rst9574_ops *ops)
 {
 	rst9574_ops = ops;
 }
@@ -195,7 +195,7 @@ struct rst9574_ops *get_rst9574_ops(void)
 
 static struct rst_nt400dxx_ops *rst_nt400dxx_ops;
 
-void register_rst_nt400dxx_ops(struct rst_nt400dxx_ops *ops)
+void nthw_reg_rst_nt400dxx_ops(struct rst_nt400dxx_ops *ops)
 {
 	rst_nt400dxx_ops = ops;
 }
@@ -218,7 +218,7 @@ const struct flow_backend_ops *get_flow_backend_ops(void)
 
 static const struct profile_inline_ops *profile_inline_ops;
 
-void register_profile_inline_ops(const struct profile_inline_ops *ops)
+void nthw_reg_profile_inline_ops(const struct profile_inline_ops *ops)
 {
 	profile_inline_ops = ops;
 }
@@ -233,7 +233,7 @@ const struct profile_inline_ops *get_profile_inline_ops(void)
 
 static const struct flow_filter_ops *flow_filter_ops;
 
-void register_flow_filter_ops(const struct flow_filter_ops *ops)
+void nthw_reg_flow_filter_ops(const struct flow_filter_ops *ops)
 {
 	flow_filter_ops = ops;
 }
@@ -248,7 +248,7 @@ const struct flow_filter_ops *get_flow_filter_ops(void)
 
 static const struct rte_flow_fp_ops *dev_fp_flow_ops;
 
-void register_dev_fp_flow_ops(const struct rte_flow_fp_ops *ops)
+void nthw_reg_dev_fp_flow_ops(const struct rte_flow_fp_ops *ops)
 {
 	dev_fp_flow_ops = ops;
 }
@@ -263,7 +263,7 @@ const struct rte_flow_fp_ops *get_dev_fp_flow_ops(void)
 
 static const struct rte_flow_ops *dev_flow_ops;
 
-void register_dev_flow_ops(const struct rte_flow_ops *ops)
+void nthw_reg_dev_flow_ops(const struct rte_flow_ops *ops)
 {
 	dev_flow_ops = ops;
 }
@@ -278,7 +278,7 @@ const struct rte_flow_ops *get_dev_flow_ops(void)
 
 static struct ntnic_xstats_ops *ntnic_xstats_ops;
 
-void register_ntnic_xstats_ops(struct ntnic_xstats_ops *ops)
+void nthw_reg_xstats_ops(struct ntnic_xstats_ops *ops)
 {
 	ntnic_xstats_ops = ops;
 }
diff --git a/drivers/net/ntnic/ntnic_mod_reg.h b/drivers/net/ntnic/ntnic_mod_reg.h
index 59eb5ab69f..26c8723afa 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.h
+++ b/drivers/net/ntnic/ntnic_mod_reg.h
@@ -119,7 +119,7 @@ struct sg_ops_s {
 	int (*nthw_virt_queue_init)(struct fpga_info_s *p_fpga_info);
 };
 
-void register_sg_ops(struct sg_ops_s *ops);
+void nthw_reg_sg_ops(struct sg_ops_s *ops);
 const struct sg_ops_s *get_sg_ops(void);
 void nthw_sg_init(void);
 
@@ -128,7 +128,7 @@ struct meter_ops_s {
 	int (*eth_mtr_ops_get)(struct rte_eth_dev *eth_dev, void *ops);
 };
 
-void register_meter_ops(struct meter_ops_s *ops);
+void nthw_reg_meter_ops(struct meter_ops_s *ops);
 const struct meter_ops_s *get_meter_ops(void);
 void nthw_meter_init(void);
 
@@ -139,7 +139,7 @@ struct ntnic_filter_ops {
 	int (*poll_statistics)(struct pmd_internals *internals);
 };
 
-void register_ntnic_filter_ops(const struct ntnic_filter_ops *ops);
+void nthw_reg_filter_ops(const struct ntnic_filter_ops *ops);
 const struct ntnic_filter_ops *get_ntnic_filter_ops(void);
 void ntnic_filter_init(void);
 
@@ -147,11 +147,11 @@ struct link_ops_s {
 	int (*link_init)(struct adapter_info_s *p_adapter_info, nthw_fpga_t *p_fpga);
 };
 
-void register_100g_link_ops(struct link_ops_s *ops);
+void nthw_reg_100g_link_ops(struct link_ops_s *ops);
 const struct link_ops_s *get_100g_link_ops(void);
 void nthw_link_100g_init(void);
 
-void register_agx_100g_link_ops(struct link_ops_s *ops);
+void nthw_reg_agx_100g_link_ops(struct link_ops_s *ops);
 const struct link_ops_s *get_agx_100g_link_ops(void);
 void link_agx_100g_init(void);
 
@@ -207,7 +207,7 @@ struct port_ops {
 	int (*tx_power)(struct adapter_info_s *p, int port, bool disable);
 };
 
-void register_port_ops(const struct port_ops *ops);
+void nthw_reg_port_ops(const struct port_ops *ops);
 const struct port_ops *get_port_ops(void);
 void nthw_port_init(void);
 
@@ -218,7 +218,7 @@ struct nt4ga_stat_ops {
 		nt4ga_stat_t *p_nt4ga_stat);
 };
 
-void register_nt4ga_stat_ops(const struct nt4ga_stat_ops *ops);
+void nthw_reg_nt4ga_stat_ops(const struct nt4ga_stat_ops *ops);
 const struct nt4ga_stat_ops *get_nt4ga_stat_ops(void);
 void nt4ga_stat_ops_init(void);
 
@@ -229,7 +229,7 @@ struct adapter_ops {
 	int (*show_info)(struct adapter_info_s *p_adapter_info, FILE *pfh);
 };
 
-void register_adapter_ops(const struct adapter_ops *ops);
+void nthw_reg_adapter_ops(const struct adapter_ops *ops);
 const struct adapter_ops *get_adapter_ops(void);
 void nthw_adapter_init(void);
 
@@ -238,7 +238,7 @@ struct clk9563_ops {
 	const clk_profile_data_fmt2_t *(*get_p_data_9563_si5340_nt200a02_u23_v5)(void);
 };
 
-void register_clk9563_ops(struct clk9563_ops *ops);
+void nthw_reg_clk9563_ops(struct clk9563_ops *ops);
 struct clk9563_ops *get_clk9563_ops(void);
 void clk9563_ops_init(void);
 
@@ -249,7 +249,7 @@ struct rst_nt200a0x_ops {
 		const struct nthw_fpga_rst_nt200a0x *p);
 };
 
-void register_rst_nt200a0x_ops(struct rst_nt200a0x_ops *ops);
+void nthw_reg_rst_nt200a0x_ops(struct rst_nt200a0x_ops *ops);
 struct rst_nt200a0x_ops *get_rst_nt200a0x_ops(void);
 void rst_nt200a0x_ops_init(void);
 
@@ -258,7 +258,7 @@ struct rst9563_ops {
 		struct nthw_fpga_rst_nt200a0x *const p);
 };
 
-void register_rst9563_ops(struct rst9563_ops *ops);
+void nthw_reg_rst9563_ops(struct rst9563_ops *ops);
 struct rst9563_ops *get_rst9563_ops(void);
 void rst9563_ops_init(void);
 
@@ -269,7 +269,7 @@ struct rst9574_ops {
 		struct nthw_fpga_rst_nt400dxx *const p);
 };
 
-void register_rst9574_ops(struct rst9574_ops *ops);
+void nthw_reg_rst9574_ops(struct rst9574_ops *ops);
 struct rst9574_ops *get_rst9574_ops(void);
 void rst9574_ops_init(void);
 
@@ -278,7 +278,7 @@ struct rst_nt400dxx_ops {
 	int (*nthw_fpga_rst_nt400dxx_reset)(struct fpga_info_s *p_fpga_info);
 };
 
-void register_rst_nt400dxx_ops(struct rst_nt400dxx_ops *ops);
+void nthw_reg_rst_nt400dxx_ops(struct rst_nt400dxx_ops *ops);
 struct rst_nt400dxx_ops *get_rst_nt400dxx_ops(void);
 void rst_nt400dxx_ops_init(void);
 
@@ -288,7 +288,7 @@ struct flow_backend_ops {
 	void (*bin_flow_backend_done)(void *be_dev);
 };
 
-void register_flow_backend_ops(const struct flow_backend_ops *ops);
+void nthw_reg_flow_backend_ops(const struct flow_backend_ops *ops);
 const struct flow_backend_ops *get_flow_backend_ops(void);
 void nthw_flow_backend_init(void);
 
@@ -446,7 +446,7 @@ struct profile_inline_ops {
 	int (*nthw_flow_set_mtu_inline)(struct flow_eth_dev *dev, uint32_t port, uint16_t mtu);
 };
 
-void register_profile_inline_ops(const struct profile_inline_ops *ops);
+void nthw_reg_profile_inline_ops(const struct profile_inline_ops *ops);
 const struct profile_inline_ops *get_profile_inline_ops(void);
 void nthw_profile_inline_init(void);
 
@@ -559,15 +559,15 @@ struct flow_filter_ops {
 		struct rte_flow_error *error);
 };
 
-void register_dev_fp_flow_ops(const struct rte_flow_fp_ops *ops);
+void nthw_reg_dev_fp_flow_ops(const struct rte_flow_fp_ops *ops);
 const struct rte_flow_fp_ops *get_dev_fp_flow_ops(void);
 void nthw_dev_fp_flow_init(void);
 
-void register_dev_flow_ops(const struct rte_flow_ops *ops);
+void nthw_reg_dev_flow_ops(const struct rte_flow_ops *ops);
 const struct rte_flow_ops *get_dev_flow_ops(void);
 void nthw_dev_flow_init(void);
 
-void register_flow_filter_ops(const struct flow_filter_ops *ops);
+void nthw_reg_flow_filter_ops(const struct flow_filter_ops *ops);
 const struct flow_filter_ops *get_flow_filter_ops(void);
 void nthw_init_flow_filter(void);
 
@@ -591,7 +591,7 @@ struct ntnic_xstats_ops {
 		uint8_t port);
 };
 
-void register_ntnic_xstats_ops(struct ntnic_xstats_ops *ops);
+void nthw_reg_xstats_ops(struct ntnic_xstats_ops *ops);
 struct ntnic_xstats_ops *get_ntnic_xstats_ops(void);
 void ntnic_xstats_ops_init(void);
 
diff --git a/drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c b/drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c
index a26cf5a07a..1ebf1b8eb5 100644
--- a/drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c
+++ b/drivers/net/ntnic/ntnic_xstats/ntnic_xstats.c
@@ -822,5 +822,5 @@ static struct ntnic_xstats_ops ops = {
 void ntnic_xstats_ops_init(void)
 {
 	NT_LOG_DBGX(DBG, NTNIC, "xstats module was initialized");
-	register_ntnic_xstats_ops(&ops);
+	nthw_reg_xstats_ops(&ops);
 }
-- 
2.45.0

