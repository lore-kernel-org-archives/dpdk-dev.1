Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D68F6C28B28
	for <dpdk-dev@archiver.kernel.org>; Fri,  7 Mar 2025 21:52:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 45C2040EAB;
	Fri,  7 Mar 2025 22:52:05 +0100 (CET)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 7410D4025F
 for <dev@dpdk.org>; Fri,  7 Mar 2025 22:52:03 +0100 (CET)
Received: from EUR03-AM7-obe.outbound.protection.outlook.com
 (mail-am7eur03lp2233.outbound.protection.outlook.com [104.47.51.233]) by
 mx-outbound8-45.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 07 Mar 2025 21:52:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x1g6N3OUsvqtH9JvI2hNiFChsC6kp7CpzeGTgYZcuD82oDAZLGHRqxBpPwklzilupPYOChcrWZO/PYOIhDXx093r53TjsvKW6ud5Ko5A40e6tJQXu/XstFMMgQScvFcRNlLj+QuZ2b3RsQiD5m23FkO6xgOAeASOSr7gpiDGBcq1yt03vGqTlTmzR7W3vf10H7uhEFk5I0heyVgRAqBJ4zo7JAnaSw0e1npEBBYqujTzsjtWRc53z+L1vgMTuL8WyRLVoDOWqBXtDoIIvDLv2XBWz9gxFVJNe+q7vj0KpEuAsKYPms08uWEYq9p3eLc4axbKv9VcVPXEBA34Pf0Frg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rkp19kgAJC0YdcKuNKdJ5ryE8EKojpTFf7QthKhEN8o=;
 b=M9JtlYDXLWW6pkbMoR74Dg1ttb2njOox+hYuquAWI4kbh664IFBGslFoQWdwk9whyslIocsAr8dDjPiVvudQNRmj+UhKdOUbs7IIwKpKdET8/+/Rdojq0Y3Czq3pZnhHOzQrrHhRzr0U6WeIMTnee2JTM2m667e2ZvNiizrrgjWyE/8HvckgaoCRZ6B2mDMRmuPu0/6OTL0AVZLgM9dk72l7aLlrNwGD8Y4va7qu7cFeHeCRJ8C0ZL6c6jdQaMmTduGIBi9MlwrA91triKmHr7Pe91P5V2A4aSaJPDJ2bhxnjNat+Tq06YxJ24/YxP4MePYgp6CgaevsKUvusLz6/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rkp19kgAJC0YdcKuNKdJ5ryE8EKojpTFf7QthKhEN8o=;
 b=kyBq3ColG62uF5HdEEZIwQJifDMtZwtX7DCmI8HuVxcnv+dCdQcUXOG9KntHHdKxIH8LBmnlbAf9xq/tZ0V9jmN4zkNwWVzgznlLOyIAXBOqv2me648AH7/aTMbG39jW2leGvtyqzr9X6UMQscshLQpkF8Qn+vSRRXNUa1su74g=
Received: from PR3P191CA0043.EURP191.PROD.OUTLOOK.COM (2603:10a6:102:55::18)
 by PA1P190MB2117.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:45b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8511.20; Fri, 7 Mar
 2025 21:51:59 +0000
Received: from AM2PEPF0001C713.eurprd05.prod.outlook.com
 (2603:10a6:102:55:cafe::b) by PR3P191CA0043.outlook.office365.com
 (2603:10a6:102:55::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8511.19 via Frontend Transport; Fri,
 7 Mar 2025 21:51:58 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM2PEPF0001C713.mail.protection.outlook.com (10.167.16.183) with Microsoft
 SMTP Server id 15.20.8511.15 via Frontend Transport; Fri, 7 Mar 2025 21:51:58
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net
Subject: [PATCH v1 2/5] net/ntnic: rename clock registers file
Date: Fri,  7 Mar 2025 22:51:32 +0100
Message-ID: <20250307215136.3110019-3-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250307215136.3110019-1-sil-plv@napatech.com>
References: <20250307215136.3110019-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM2PEPF0001C713:EE_|PA1P190MB2117:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 6db4bf64-67f2-4b07-bbd9-08dd5dc24927
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4ovKvk9BK0eSgyHWzhECeR8XCNGMpkNBFWELAXXGV4QjG5EU9uI3wQYt6mLs?=
 =?us-ascii?Q?ebLOHtDAz2LXeS3J8AF+jSKr/zNNHAGPomMoGMnligmiEIx9xxdHrS1fg9R8?=
 =?us-ascii?Q?+vhtGN8/ycIlM87QJ3sitSn1cVYlFhLYLdVx+XlR2oAvCy2Ch+77mdpD/Max?=
 =?us-ascii?Q?DaEAciniJTo5UiKPopl2UIqGk8XffSRxNs5d7ebwHnohLGQ09PeW747IoiWK?=
 =?us-ascii?Q?SKin+A2VaB8Xe5gdR6eBQal8Lz3g0RfJUTMU01Y9Ies/8P0oFDtlq6dQWELM?=
 =?us-ascii?Q?9MBzHprvVfgN7vs+n1LYLM0rp2GzVAYXaHcjSM3KPRCpG85RRZQt+XoW5w88?=
 =?us-ascii?Q?aSAle61+Re4x/pPr4VYpvwDJgiyV+vuFKwpjVXtgOy9VYFajTyOoIyBss2p5?=
 =?us-ascii?Q?JktYlOTC0AM+whz3LuyBWFKXwk/0p2ahu7KP2FHqU1vO2IzyzLsodQJuP49W?=
 =?us-ascii?Q?81jLy4qgCrmPLf8TPwfHdO9fgIoKh098iaAYteE27YaviykAGtZNmBrSJ5oK?=
 =?us-ascii?Q?AWozwKtHo/NQpQOkTWn5SQpCTGbAosEycM/7SDi/6cSOExTMPeM/BkQiuqyv?=
 =?us-ascii?Q?rDKABYT//ygQ1RhD37Y386iVKYTxbvEW+wqfK93JR/+vMb8XfkRL3PQ3cu0v?=
 =?us-ascii?Q?Bl9m7L4+vl4C6VShcmpkGQlXxye8G9KcddGODFgJOO8xtRpHBFs0mghIWoC6?=
 =?us-ascii?Q?HdJm6BtDtCrtHKggaZSXr4GT3iXFKWvEcM4mZE1P/PfyhuiyB5GJBIYNlVp1?=
 =?us-ascii?Q?kHNleafQTW4FDlxW6byW2pxBK7YmvJwBNRbhHwXjRwhVUjGvAbRRFWHxnnoc?=
 =?us-ascii?Q?z5CGvyTR6fXQ6TeNKOx0WEdDL0QZT2B2rrzNFmP26H0OeKGO+u7Mb92RFRGG?=
 =?us-ascii?Q?w9JCStaTD2+gKrVywaLBmVOee7FRUYsL45RpLya0VUYh5RVsNL690YHil/2a?=
 =?us-ascii?Q?J9D5sdtqiYzX31mOFjmX35H/yLFaCr6fDDSQPLbV9+zmd6H+FuXaAvfK1ykU?=
 =?us-ascii?Q?3vc2bx9zmmtN7xkNi21vdGJhqw72lLV7ooysvtQuMH+e2CtXzsbILEbRqcCo?=
 =?us-ascii?Q?2sD8/MDCXadba+zNzlbL3kBMf8thq4lqXbVYD7QuGU0plvETLEeugZUg8b0i?=
 =?us-ascii?Q?aCLZxnBJKfsjD+UGLTyv1y6BrNnkAVbsSUJHyjkuCntPUt0JnWJUbsU3qeQu?=
 =?us-ascii?Q?K1+lY2vt82mhCpLDtd0Gx4XOGW1/QiTvdEQSQsccSNyZD6eNuC8ZgrJiihyq?=
 =?us-ascii?Q?H5Nu9V1XQx7tAar0ysqYTAdBJLIBhlUoIzDyG74aZYR6M9rF1F7EIuz2VSkE?=
 =?us-ascii?Q?xFms505O8kM7LS1+5L7nb4ancyJK46WoJcGrAswjA60AAV7XOM78hXS6iR0p?=
 =?us-ascii?Q?poo2EGyTv8O/eJ8/SlGpUfB1f5QaDIa86ueAYiy0AGNKLyzQGOjHuHOXoYfK?=
 =?us-ascii?Q?8AHmUs6YCv7eS6tOTItj/y1XKoy2BfxMa32sp5qSD9TwqfKGpMjnVw=3D=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(36860700013)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: YM3+p5mIwgrVE5mZRKCCmslO1ddthVgBDRDH1SL4rU1iG4Y0n8aWqqJPHvHwLbmMVWx0iPsp97sabr8Lgq0FpE1WM4hUllpen2xAsg4FS/VUy9G6635w0rF8icWVUdKbAghhH+uU93Nd8LHWkKnEAfAwdMPBD0+fBvlsuc6vf7AeP/c/gRy2JlWSErW1Kbp08ku1kbCAGOaecgazyichQdZs4TFdLawGkih1/Nomm06KimMjT0uWNeLmjiFgd2xXD9156gARTGPyfXIC4iFUnMlkEetH71UcpDEwjh1PWvu8804ur58RzX+oCSxScq1bY3EY+UJT0gNfrDrtM+LxRX9P+DzgzrqVzZK7CT9vDjnU86SMFTpho+dL4nFj/IbbTAo1K+JReGS/5xxb/MWpT8XUqavhufhzCMJVrTgyJXPz2UNTETEYFWjFnfYzTJrtJDfDAcB4pm2BWrzJccvWq2SOmF6YxVnDxvzjHAoxUNobFN2QGUR/xz5LzPwQ/KPgRi0uIak6Xn6lwhcXSvFA7GnBXGlHfO35uHF7c9+gDJXqZhxPJdtZYO85t7pj1XmQakZtbK5mnvxtWbljKuGFqmCvJuvFFm+13Q4CeK3HB0kYMzxzATn7yl5fD0JQioOBdSmKH4aXt5gNljCgTIy7/Q==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2025 21:51:58.7764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6db4bf64-67f2-4b07-bbd9-08dd5dc24927
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM2PEPF0001C713.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1P190MB2117
X-BESS-ID: 1741384320-302093-7646-43350-1
X-BESS-VER: 2019.1_20250304.2151
X-BESS-Apparent-Source-IP: 104.47.51.233
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaW5oZAVgZQMCXRwMI00cLU2C
 TZPM3cMtk42dQ40czCMsnSzNjSwMBCqTYWAOSqemVBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262990 [from 
 cloudscan18-148.eu-central-1b.ess.aws.cudaops.com]
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

Rename this files to align the file naming

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 ...egisters.h => nt400d13_u62_si5332_gm2_revd_1_v5_registers.h} | 0
 ...0_v5-Registers.h => nt200a02_u23_si5340_adr0_v5_registers.h} | 0
 .../ntnic/nthw/core/nt200a0x/clock_profiles/nthw_fpga_clk9563.c | 2 +-
 drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c       | 2 +-
 4 files changed, 2 insertions(+), 2 deletions(-)
 rename drivers/net/ntnic/nthw/core/include/{NT400D13_U62_Si5332-GM2-RevD-1_V5-Registers.h => nt400d13_u62_si5332_gm2_revd_1_v5_registers.h} (100%)
 rename drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/{NT200A02_U23_Si5340_adr0_v5-Registers.h => nt200a02_u23_si5340_adr0_v5_registers.h} (100%)

diff --git a/drivers/net/ntnic/nthw/core/include/NT400D13_U62_Si5332-GM2-RevD-1_V5-Registers.h b/drivers/net/ntnic/nthw/core/include/nt400d13_u62_si5332_gm2_revd_1_v5_registers.h
similarity index 100%
rename from drivers/net/ntnic/nthw/core/include/NT400D13_U62_Si5332-GM2-RevD-1_V5-Registers.h
rename to drivers/net/ntnic/nthw/core/include/nt400d13_u62_si5332_gm2_revd_1_v5_registers.h
diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/NT200A02_U23_Si5340_adr0_v5-Registers.h b/drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/nt200a02_u23_si5340_adr0_v5_registers.h
similarity index 100%
rename from drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/NT200A02_U23_Si5340_adr0_v5-Registers.h
rename to drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/nt200a02_u23_si5340_adr0_v5_registers.h
diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/nthw_fpga_clk9563.c b/drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/nthw_fpga_clk9563.c
index dc8015ccab..e50094c6fa 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/nthw_fpga_clk9563.c
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/clock_profiles/nthw_fpga_clk9563.c
@@ -10,7 +10,7 @@
  */
 #define si5340_revd_register_t type_9563_si5340_nt200a02_u23_v5
 #define si5340_revd_registers data_9563_si5340_nt200a02_u23_v5
-#include "NT200A02_U23_Si5340_adr0_v5-Registers.h"
+#include "nt200a02_u23_si5340_adr0_v5_registers.h"
 static_assert(sizeof(type_9563_si5340_nt200a02_u23_v5) == sizeof(clk_profile_data_fmt2_t),
 	clk_profile_size_error_msg);
 static const int n_data_9563_si5340_nt200a02_u23_v5 = SI5340_REVD_REG_CONFIG_NUM_REGS;
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
index 24118822c4..121cedbb1f 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
@@ -5,7 +5,7 @@
 #include "ntlog.h"
 #include "nthw_fpga.h"
 #include "ntnic_mod_reg.h"
-#include "NT400D13_U62_Si5332-GM2-RevD-1_V5-Registers.h"
+#include "nt400d13_u62_si5332_gm2_revd_1_v5_registers.h"
 
 static int nthw_fpga_nt400dxx_init_clock_synthesizers(struct fpga_info_s *p_fpga_info)
 {
-- 
2.45.0

