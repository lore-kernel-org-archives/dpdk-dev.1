Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F62FCAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 15:10:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8823940DDA;
	Wed,  1 Oct 2025 17:10:27 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id A5894400D5
 for <dev@dpdk.org>; Wed,  1 Oct 2025 17:10:25 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11023094.outbound.protection.outlook.com [52.101.72.94])
 by mx-outbound13-239.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 01 Oct 2025 15:10:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PE9ZKfoXXDvssnE0LO1/r0wAjqoFmkm+fT+yaM2/H9WKfbsGPZfs/L9HgBBx9VqwJnle2OXt48voJ1jQ2110B8oyqzHrMq80Zm0a5uCPG4D1I/t4AxzEwIJjZPWeO+4Yr3obhNuDhjg8YdlF5W32L0/4Pod7pMkApX5m+SSSOJ86y3l5gYeDhxbo1wqaFjc6yKf0wTwc/qj4l1z3s2R8QRithOmHYMFTRo+Bt2MlEkouSHf12+z17vzKJIUtENqI+mbCfQB6jgcrkt1nRh1iDAaOjBUz1y/zitVlGdZwqIgjDIg6MTqm8TWkHIhnTovWN/zsLBSdtszC9+ZnDw/qdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2dXc25lljN6+l4itacgZAQl9fOAV4GYy7u3jBMuOnns=;
 b=fliaclKSuIQIPqZGgJUkKinIy1o+C2Czijd71o1vj2nT5yg4EguA+vW0iq5zcFg51tJ2Phi138c41PV8qE0i2WVxqt9NHNYkUcMGcHBGnYX7Slz8J0thgJ7hYSjxP5+rdRFmudHmwOrY/gD2nXtekkHiCXCPe74ZNvaVowjvdPJA67HFzU0xCTVCM9uL86dMtGjRqVzKWmLvyybDxrH/xKvdjFdM/aNN55EqA3MdH91rJkDHbm5TuOhu2yhga4KzzVmXwoiphRiUCuazX+VXRAgsgs8PsN66aSDZxotnIfaiH/fnFeFdUATsiA/K3PvctuRQrR9GJtKirsD4ySlIFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2dXc25lljN6+l4itacgZAQl9fOAV4GYy7u3jBMuOnns=;
 b=Fp5Dt0WqLAAXfWCRBtO5hhg8zB+T//z2WSYXhnX3Mdw9m5r/1IwFiA3WZIbqunXY/rsE+wjT2W8mzoTlciewdPcYPJS27hGoufNN4m3ecQaZZNWnqT/zH77FpaDMwsVUZGPm9nUAKinYGTKo5orRz9bhVhTuIyx5Hbv3eQ6fKc8=
Received: from DB9PR02CA0023.eurprd02.prod.outlook.com (2603:10a6:10:1d9::28)
 by DBAP190MB0886.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:1b0::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.14; Wed, 1 Oct
 2025 15:10:23 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::2e) by DB9PR02CA0023.outlook.office365.com
 (2603:10a6:10:1d9::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.15 via Frontend Transport; Wed,
 1 Oct 2025 15:10:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server id 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 15:10:22
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 01/20] net/ntnic: add stubs for init NT400D11
Date: Wed,  1 Oct 2025 17:09:43 +0200
Message-ID: <20251001151018.250671-2-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251001151018.250671-1-sil-plv@napatech.com>
References: <20251001151018.250671-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D02:EE_|DBAP190MB0886:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 742fa211-8eb2-4ed8-f8c0-08de00fca4d7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cJp8VqbTdKeXK13moDf3iimtOztoHKVBjVyI2Xze5SpodF2L/2sBz+jJXoWL?=
 =?us-ascii?Q?KJU43ScEVoCYFrwP0l/7SC0Ht5Uyhud2+G3n40K/SaVib5Bm4Nu6DbqQHPYm?=
 =?us-ascii?Q?bfTURY6BN6wp+5fsuoaBvY1Ly83nC+thnXnckbxlEBTz0CUO1sNnbCVnBNpK?=
 =?us-ascii?Q?996coTkRNMDvUosMlvq5Kv7IprynINz0g7c/PMKF1/w8dMSlnIDvHLfm2tby?=
 =?us-ascii?Q?qKhLlcpREs2rg9/dYVMsSkrYfM1W4bMEmW9No6eU7kgUjkWZW3apF/9jDtOx?=
 =?us-ascii?Q?rMMleszKvukDkr0JXsTu/NvRyR9gXqx1RcPrh7xz18d4ur0559uKp5jwAu2I?=
 =?us-ascii?Q?mwDdWBaYP9Akm/pCBDmQg3fNlXPB5nhAnh2DU4eejEoQ3oZpUzN18tcJUxlM?=
 =?us-ascii?Q?Qnv7xhYcXoHD+3AqVpmBW9CNf2KYfiETW4g1rBxy5F+mS1TSpCuODRyfcUq2?=
 =?us-ascii?Q?XgozWbno0jxp6S0628bSRr2F57QQiHE5M6qKr/mk2h12pD3Dg4rRIz8nIx+Y?=
 =?us-ascii?Q?Uw6o2s4c5mmGcb0ydHJZ4VHkTkI6CM4tNzCpHQGOPjG/FoIhQbSbCMTlbGX8?=
 =?us-ascii?Q?IdtiNajIB66IcUevg+yabspgOJKQTfJ69Rexn/jGqPrM+B5ocvP7PcH/m9S3?=
 =?us-ascii?Q?Dqo0TwFS7SkQoDKGNS2keiWDMn+sIl/Z0L0QOrSY4siG9VVKtFc9ZlL3dAq0?=
 =?us-ascii?Q?qOnPrkbrD+AKOW/2Ftw0J9BR4FiIp0WbgrT65MDYpEMe2wEqtbjNiy1xxXOW?=
 =?us-ascii?Q?obrLTQLiy8gL18m9VxtKacm2NIfc8ZR6p8IOL3gcyULSeeBneV4VrSp8UsFW?=
 =?us-ascii?Q?+7hHAIDNZMGQfah9ZDMQM224MI13Ymd3QDlEAaS604WbalIysBQtFNRF7g1A?=
 =?us-ascii?Q?5E6eo2lg+6Bi4pXIaL7WpXh6uE4UG0YVjQy0iczx7DR2qfzin6DQ4/K1oPI7?=
 =?us-ascii?Q?cZE68LFkxYf2rkvIJpuLi2OBJ6cmFYyFaBOtE4zcy9lLvs1oaGjjOEMuW+3M?=
 =?us-ascii?Q?BB8h+U7tOugqsLQvTJOJDW81vfW8KcVYryr5m/ER8AKdpfVfdOhcfaqDOAE1?=
 =?us-ascii?Q?i5erBDNuNk1hNTX4uASxlqSuHnOAG/QF0VWtwSYC/n66OVcV6XQBo5o2z0jH?=
 =?us-ascii?Q?gY8mUxZW6hjJE9vgTGTcJZZG4WE2VL4Cs1sXWeEaNzzTP5Ln7VPgZawKTWos?=
 =?us-ascii?Q?EQcHgxzedi101/2zXvyBc8iGnArzlD5poIZwxKjITkbmRNFxUEirKJAjIasr?=
 =?us-ascii?Q?C6IQqkeyQYvW/TKtmTgptF/e4oQc2nRdoaIPH6IeIGQkXEsBLbxg7yJtzy2V?=
 =?us-ascii?Q?Fdrxl8o1xAWgYZm8vED/eoDuNsvkn8mgnIdeC6aQVVvdkS80+dUzPzewnova?=
 =?us-ascii?Q?pdPqYWCtQNCKUUB9IR2ja1eZwZRyKA+u0qsmevzct54z0qJtdmszTmElAuOn?=
 =?us-ascii?Q?rxP/QALy5/lFKquHoHJ07CSyy6akA0jgH2J+Wt7prohHM6M1wIplaFA9/zME?=
 =?us-ascii?Q?dYVlB/WhUZRIaXHGIm8H20pP3xdvqq7PDyQO?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ghAa1Leu2vsmz8SFnmXvxQNJ3Ri2ngUNgl/6KSyM37I6w3tWIjzVDf0An3Q5g1/mfHIxagyJssYxp9H3vxSvM9ZXBC6cp6IkNw5fomxCt/CZAIIYQX+um2wjwUHpHCu8ah2JRji4L3DZRc3FMbXzAMxQ5LwpY3eUq2hf+Pexhk2jjUFZnmMHPEIpN+p3wX8hDWCdMi70r80CK+7tA4zOJRa2/PfJACun9Pgc9q0oEs8HuGO9vefxoA/Kcae0vep2onUD9yNUl2W+hlKdQLaZ6ScTHwf19N/ylYoarWjXunWU6vJrHm4AW+DrxaH6cg5nQCuaqji63/qE5926FJzsPa8iiC9Ij7uyMNvRT4mhogvPZLdBrhDLiaQtt+iXjlGlW4o7mIb7XQ67Icv98VVVuEmORmcSdhwFD1VPZttJ3wV9jyC/u3nRCwv4/TBOGF6L4zcYSobc0ZltPGu+odRMxbsmCP5FZOaWKYV+gL5QMrB1pmeZSt0/8gvRmluwmdtC0XBbx6OTbLy032PWedXFR8iLk45dYsP/NNR3+mTQtz7QXLH/gfY7mWqrq9K4Z0cU6Yxx3tEvCQM5KFuQuJeB39cynpaPyWGWenXzTGCwIt4AsvqRfO0IS+zqN0sarzbAw+dUeFs6x13nluAcZsrONw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:10:22.8213 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 742fa211-8eb2-4ed8-f8c0-08de00fca4d7
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP190MB0886
X-BESS-ID: 1759331424-303567-7603-4422-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.72.94
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpZG5uZAVgZQMMnQzMDc3CzV0s
 LSyNjQxNzYyNLU1CzNDMhISTIytlSqjQUA3fQY5kEAAAA=
X-BESS-Outbound-Spam-Score: 0.01
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267892 [from 
 cloudscan15-90.eu-central-1a.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.01 BSF_SC7_SG0146_1       META: Custom rule SG0146_1 
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.01 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_SC7_SG0146_1, BSF_BESS_OUTBOUND
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

Add stubs for NT400D11 init functions.
These stubs will be replaced with actual implementations in future commits.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 doc/guides/nics/ntnic.rst                     |  6 +++
 drivers/net/ntnic/adapter/nt4ga_adapter.c     |  3 +-
 drivers/net/ntnic/meson.build                 |  1 +
 .../nthw/core/nt400dxx/nthw_fpga_nt400dxx.c   | 41 +++++++++++++++++++
 .../core/nt400dxx/reset/nthw_fpga_rst9569.c   | 27 ++++++++++++
 drivers/net/ntnic/nthw/core/nthw_fpga.c       |  1 +
 drivers/net/ntnic/nthw/nthw_platform.c        |  3 ++
 drivers/net/ntnic/nthw/nthw_platform_drv.h    |  2 +
 drivers/net/ntnic/ntnic_ethdev.c              |  1 +
 drivers/net/ntnic/ntnic_mod_reg.c             | 15 +++++++
 drivers/net/ntnic/ntnic_mod_reg.h             |  9 ++++
 11 files changed, 108 insertions(+), 1 deletion(-)
 create mode 100644 drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c

diff --git a/doc/guides/nics/ntnic.rst b/doc/guides/nics/ntnic.rst
index a173eaa2ac..5375d89a2d 100644
--- a/doc/guides/nics/ntnic.rst
+++ b/doc/guides/nics/ntnic.rst
@@ -27,6 +27,10 @@ Supported NICs
 
     - FPGA ID 9563 (Inline Flow Management)
 
+- NT400D11 2x100G SmartNIC
+
+    - FPGA ID 9569 (Inline Flow Management)
+
 - NT400D13 2x100G SmartNIC
 
     - FPGA ID 9574 (Inline Flow Management)
@@ -34,6 +38,8 @@ Supported NICs
 All information about NT200A02 and NT400D13 can be found by links below:
 
 - https://www.napatech.com/products/nt200a02-smartnic-inline/
+- https://www.napatech.com/products/nt400d11-smartnic-programmable/
+- https://www.napatech.com/products/nt400d13-smartnic-programmable/
 - https://www.napatech.com/support/resources/data-sheets/link-inline-software-for-napatech/
 
 
diff --git a/drivers/net/ntnic/adapter/nt4ga_adapter.c b/drivers/net/ntnic/adapter/nt4ga_adapter.c
index 6d8547483f..4599f78e3f 100644
--- a/drivers/net/ntnic/adapter/nt4ga_adapter.c
+++ b/drivers/net/ntnic/adapter/nt4ga_adapter.c
@@ -172,10 +172,11 @@ static int nt4ga_adapter_init(struct adapter_info_s *p_adapter_info)
 
 			res = link_ops->link_init(p_adapter_info, p_fpga);
 			break;
+		case 9569: /* NT400D11 (Intel Agilex FPGA) */
 		case 9574: /* NT400D13 (Intel Agilex FPGA) */
 			link_ops = nthw_get_agx_100g_link_ops();
 			if (link_ops == NULL) {
-				NT_LOG(ERR, NTNIC, "NT400D11 100G link module uninitialized");
+				NT_LOG(ERR, NTNIC, "NT400Dxx 100G link module uninitialized");
 				res = -1;
 				break;
 			}
diff --git a/drivers/net/ntnic/meson.build b/drivers/net/ntnic/meson.build
index 785ac4836d..038c7d90f6 100644
--- a/drivers/net/ntnic/meson.build
+++ b/drivers/net/ntnic/meson.build
@@ -47,6 +47,7 @@ sources = files(
         'nthw/core/nt400dxx/nthw_fpga_nt400dxx.c',
         'nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c',
         'nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c',
+        'nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c',
         'nthw/core/nt200a0x/reset/nthw_fpga_rst_nt200a0x.c',
         'nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c',
         'nthw/core/nthw_fpga.c',
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
index cc4bee9d4d..99b317d916 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
@@ -113,6 +113,7 @@ static int nthw_fpga_nt400dxx_init_sub_systems(struct fpga_info_s *p_fpga_info)
 static int nthw_fpga_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 {
 	RTE_ASSERT(p_fpga_info);
+	struct rst9569_ops *rst9569_ops = NULL;
 	struct rst9574_ops *rst9574_ops = NULL;
 
 	const char *const p_adapter_id_str = p_fpga_info->mp_adapter_id_str;
@@ -123,6 +124,29 @@ static int nthw_fpga_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 	RTE_ASSERT(p_fpga);
 
 	switch (p_fpga_info->n_fpga_prod_id) {
+	case 9569:
+		rst9569_ops = nthw_get_rst9569_ops();
+
+		if (rst9569_ops == NULL) {
+			NT_LOG(ERR, NTHW, "%s: RST 9569 NOT INCLUDED", p_adapter_id_str);
+			return -1;
+		}
+
+		res = rst9569_ops->nthw_fpga_rst9569_setup();
+
+		if (res) {
+			NT_LOG(ERR,
+				NTHW,
+				"%s: %s: FPGA=%04d Failed to create reset module res=%d",
+				p_adapter_id_str,
+				__func__,
+				p_fpga_info->n_fpga_prod_id,
+				res);
+			return res;
+		}
+
+		break;
+
 	case 9574:
 		rst9574_ops = nthw_get_rst9574_ops();
 
@@ -183,6 +207,23 @@ static int nthw_fpga_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 
 		/* reset specific */
 	switch (p_fpga_info->n_fpga_prod_id) {
+	case 9569:
+		if (rst9569_ops)
+			res = rst9569_ops->nthw_fpga_rst9569_init();
+
+		if (res) {
+			NT_LOG(ERR,
+				NTHW,
+				"%s: %s: FPGA=%04d - Failed to reset 9569 modules res=%d",
+				p_adapter_id_str,
+				__func__,
+				p_fpga_info->n_fpga_prod_id,
+				res);
+			return res;
+		}
+
+		break;
+
 	case 9574:
 		res = rst9574_ops->nthw_fpga_rst9574_init(p_fpga_info, &rst);
 
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
new file mode 100644
index 0000000000..3d1c09fe2d
--- /dev/null
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
@@ -0,0 +1,27 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Napatech A/S
+ */
+
+#include "ntnic_mod_reg.h"
+
+
+static int nthw_fpga_rst9569_setup(void)
+{
+	return 0;
+};
+
+static int nthw_fpga_rst9569_init(void)
+{
+	return 0;
+}
+
+static struct rst9569_ops rst9569_ops = {
+	.nthw_fpga_rst9569_init = nthw_fpga_rst9569_init,
+	.nthw_fpga_rst9569_setup = nthw_fpga_rst9569_setup,
+};
+
+void nthw_rst9569_ops_init(void)
+{
+	nthw_reg_rst9569_ops(&rst9569_ops);
+}
diff --git a/drivers/net/ntnic/nthw/core/nthw_fpga.c b/drivers/net/ntnic/nthw/core/nthw_fpga.c
index 24cfb6c284..7ec33aff2d 100644
--- a/drivers/net/ntnic/nthw/core/nthw_fpga.c
+++ b/drivers/net/ntnic/nthw/core/nthw_fpga.c
@@ -440,6 +440,7 @@ int nthw_fpga_init(struct fpga_info_s *p_fpga_info)
 			res = nt200a0x_ops->nthw_fpga_nt200a0x_init(p_fpga_info);
 		break;
 
+	case NT_HW_ADAPTER_ID_NT400D11:
 	case NT_HW_ADAPTER_ID_NT400D13:
 		if (nt400dxx_ops != NULL)
 			res = nt400dxx_ops->nthw_fpga_nt400dxx_init(p_fpga_info);
diff --git a/drivers/net/ntnic/nthw/nthw_platform.c b/drivers/net/ntnic/nthw/nthw_platform.c
index 6f2582d6fe..83e1b38563 100644
--- a/drivers/net/ntnic/nthw/nthw_platform.c
+++ b/drivers/net/ntnic/nthw/nthw_platform.c
@@ -11,6 +11,9 @@ nthw_adapter_id_t nthw_platform_get_adapter_id(const uint16_t n_pci_device_id)
 	case NT_HW_PCI_DEVICE_ID_NT200A02:
 		return NT_HW_ADAPTER_ID_NT200A02;
 
+	case NT_HW_PCI_DEVICE_ID_NT400D11:
+		return NT_HW_ADAPTER_ID_NT400D11;
+
 	case NT_HW_PCI_DEVICE_ID_NT400D13:
 		return NT_HW_ADAPTER_ID_NT400D13;
 
diff --git a/drivers/net/ntnic/nthw/nthw_platform_drv.h b/drivers/net/ntnic/nthw/nthw_platform_drv.h
index db2bc05180..a861c8dd7b 100644
--- a/drivers/net/ntnic/nthw/nthw_platform_drv.h
+++ b/drivers/net/ntnic/nthw/nthw_platform_drv.h
@@ -10,11 +10,13 @@
 
 #define NT_HW_PCI_VENDOR_ID (0x18f4)
 #define NT_HW_PCI_DEVICE_ID_NT200A02 (0x1C5)
+#define NT_HW_PCI_DEVICE_ID_NT400D11 (0x215)
 #define NT_HW_PCI_DEVICE_ID_NT400D13 (0x295)
 
 enum nthw_adapter_id_e {
 	NT_HW_ADAPTER_ID_UNKNOWN = 0,
 	NT_HW_ADAPTER_ID_NT200A02,
+	NT_HW_ADAPTER_ID_NT400D11,
 	NT_HW_ADAPTER_ID_NT400D13,
 };
 
diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 42aa2d4095..01b3fe00ef 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -84,6 +84,7 @@ static const char *const valid_arguments[] = {
 
 static const struct rte_pci_id nthw_pci_id_map[] = {
 	{ RTE_PCI_DEVICE(NT_HW_PCI_VENDOR_ID, NT_HW_PCI_DEVICE_ID_NT200A02) },
+	{ RTE_PCI_DEVICE(NT_HW_PCI_VENDOR_ID, NT_HW_PCI_DEVICE_ID_NT400D11) },
 	{ RTE_PCI_DEVICE(NT_HW_PCI_VENDOR_ID, NT_HW_PCI_DEVICE_ID_NT400D13) },
 	{
 		.vendor_id = 0,
diff --git a/drivers/net/ntnic/ntnic_mod_reg.c b/drivers/net/ntnic/ntnic_mod_reg.c
index 00eb07f848..ab29a2d816 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.c
+++ b/drivers/net/ntnic/ntnic_mod_reg.c
@@ -193,6 +193,21 @@ struct rst9574_ops *nthw_get_rst9574_ops(void)
 	return rst9574_ops;
 }
 
+static struct rst9569_ops *rst9569_ops;
+
+void nthw_reg_rst9569_ops(struct rst9569_ops *ops)
+{
+	rst9569_ops = ops;
+}
+
+struct rst9569_ops *nthw_get_rst9569_ops(void)
+{
+	if (rst9569_ops == NULL)
+		nthw_rst9569_ops_init();
+
+	return rst9569_ops;
+}
+
 static struct rst_nt400dxx_ops *rst_nt400dxx_ops;
 
 void nthw_reg_rst_nt400dxx_ops(struct rst_nt400dxx_ops *ops)
diff --git a/drivers/net/ntnic/ntnic_mod_reg.h b/drivers/net/ntnic/ntnic_mod_reg.h
index b534b09234..62f69d239d 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.h
+++ b/drivers/net/ntnic/ntnic_mod_reg.h
@@ -269,6 +269,15 @@ struct rst9574_ops {
 		struct nthw_fpga_rst_nt400dxx *const p);
 };
 
+struct rst9569_ops {
+	int (*nthw_fpga_rst9569_init)(void);
+	int (*nthw_fpga_rst9569_setup)(void);
+};
+
+void nthw_reg_rst9569_ops(struct rst9569_ops *ops);
+struct rst9569_ops *nthw_get_rst9569_ops(void);
+void nthw_rst9569_ops_init(void);
+
 void nthw_reg_rst9574_ops(struct rst9574_ops *ops);
 struct rst9574_ops *nthw_get_rst9574_ops(void);
 void nthw_rst9574_ops_init(void);
-- 
2.45.0

