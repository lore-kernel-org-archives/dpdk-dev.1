Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59E3FC3ABA9
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 13:51:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 71D5F40BA0;
	Wed, 30 Apr 2025 15:49:37 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 7149C4065F
 for <dev@dpdk.org>; Wed, 30 Apr 2025 15:49:25 +0200 (CEST)
Received: from EUR02-DB5-obe.outbound.protection.outlook.com
 (mail-db5eur02lp2104.outbound.protection.outlook.com [104.47.11.104]) by
 mx-outbound12-177.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Apr 2025 13:49:21 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HO0Uo0i5rZLoDTLIY5Fck7+DyduDJomi/Fsh1HXoDqpW5Y8Yc80sQjWhcZ2qonoMSyVTHXFlrRKfd2Pak2SlOT88QKvkYSw4Si5zV8W/6ahSjYfo2WbJANOhnBf4hRmnKyKcpEYPtXrJ+hMlr99m6voMhHSAakZy/x+QgEA19LD0Z8MWOzs7V1lGb4h/hQyikzp0hg99kMlCN8PHFXl+krFDyW+J2zdhG9TomYigi+aFEj2EHIUdm/2zXMx6VN9fjLW/zkWb9UPkZhW2If1foGjiCYiBoq7EZ3j4vaxdfLgnTMCTRhVK6JfkuzyjDKcrIXUkZ2StU/hfNxuBCUXeXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5W43BOKGIOibUscTbxJirEqbhWq1wapcOMO4vCPlMAo=;
 b=veMd0ek75AQyhytoVR/hjGdfMBlSFraPsNrmSGK1HjHd6Ja0ezPjmXWYp9WOc2Vf6swDLAhis0hLAPgih6CHGRW5mVBtW1cHDgKwI/ZxBq5JQYt53OsFDXY7DYygRYj/TalhYxce/obwTq27Ltov7SAfWaAfdY5rHwJmLa99XYLHdIgPNOP92TvnEUb9IcDvC+JcoU74EFL+dR4XHGz+C1Wr5G8xgMY6EWQPw6aT75gi8tC1LYBc/JfDgTK0BpFl3nBfZvl2A+VZlrEZYr7+qnkFiBMIq1ur96K1jkGf7Qsf7PhCMv0GznykemDmHM2bQt7XhcpcSA1gWuIYyIbjOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5W43BOKGIOibUscTbxJirEqbhWq1wapcOMO4vCPlMAo=;
 b=DH+TP2UvHBezDRsI+rOnnlo7ujN01v2ma8jWmwp7/y/lcH4BC5lL4tooPlLIyvxqfQkwdVLtnJ6ok04V7VQWLok7RBHni8gs7bR6uM+Bme5j6MP3VNjaEx9o2XHEjobNefmmbdzfw1EwcRCLEe5zd2VWdA+oF0T3epQhM5XhL6k=
Received: from AM9P193CA0003.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::8)
 by DB9P190MB1083.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:227::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.33; Wed, 30 Apr
 2025 13:49:19 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::ad) by AM9P193CA0003.outlook.office365.com
 (2603:10a6:20b:21e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.41 via Frontend Transport; Wed,
 30 Apr 2025 13:49:19 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025
 13:49:19 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net,
 Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 18/25] net/ntnic: remove redundant assignments and branching
Date: Wed, 30 Apr 2025 15:48:30 +0200
Message-ID: <20250430134840.402553-19-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430134840.402553-1-okl-plv@napatech.com>
References: <20250430134840.402553-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|DB9P190MB1083:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 03a06260-1684-4f8b-23bb-08dd87edce2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?I7pPPX85nW2LM3nVUbBNVpQ8khUgIGGohtsM5fL7d4dzWuhwlj94dcoZLb6W?=
 =?us-ascii?Q?w+OEACuaiWXrpcf++ONbcmSI1IPoYvvkLXcaN1Kwuh78Mh9bOR6k+HR3JZ2Y?=
 =?us-ascii?Q?xqlgf38Jm348YR6aEbMoN0vTSxumO3th7UWFWkGXU/OqFvjO1CMOZJqJs+ry?=
 =?us-ascii?Q?9AyjARmZbzUC9GWeqT4dRU1Nb6C/L58REsZcRG0Sxa/0PGgzjDzNyVTHrUja?=
 =?us-ascii?Q?cSljJwcD16dhqvipr4A1hniwnaAjqbOlCZ9aBIOHeEMMIGhk8aiFpf6kXbU3?=
 =?us-ascii?Q?XhJSD9S4czqE94kvn7GrqB+9vZOI3eC9IfMHnx32bTl5xcfoCzhg4TUzk/zH?=
 =?us-ascii?Q?oGhIAfB3lldHz40+0o8qWY/qOtWdfnSuifOD7uKZHkykUVpL8r+3zVWSd4Ne?=
 =?us-ascii?Q?Bi2qq6W2EIs4YyAewrSJqElwUU0M3qbIJOmzyzpjyWfC4RYZXE+j3MTd4L3I?=
 =?us-ascii?Q?J769yNsD5AepzlHK6hkIkM6XjQLucClDuHvWGcN+HXR6B3uHf5cVnmPnZXYs?=
 =?us-ascii?Q?MgZF9RmBLJyD3in17gnPmuBQGvTs6iTL9/UZiANomReWq5PpyeoeyRrxe50x?=
 =?us-ascii?Q?TN0AbZJ+ujaK/Lwlsv41CEm8TDjhxJ76dP5VEz2T2TznqepM7LwTA09bt3P+?=
 =?us-ascii?Q?wtcxv9mBT4kIiDZf0wsHlHCAsP9Wfo07AZDVNuO68sexxWtWMFBGT9JPP7LY?=
 =?us-ascii?Q?6tsRj1u0nvR8yWOMskT61f6sjHZ8QMIgKZI0cS/gVbgFkMzSAZWEh5doeUzz?=
 =?us-ascii?Q?9N+RUFKQj39NHfdsN46w5pci8LYwX7FXpH9wOrt2FuxD7f+jhYy7K8F5dlgh?=
 =?us-ascii?Q?dQ7hUTuNPZ8EZvG3bF2kcWogZuSlOCxsem2z4PeFbm3QOZoUt0oUasxsO0h7?=
 =?us-ascii?Q?2mMOXw+t9tIQXJt31Xvc/P7eWwX6P1LWc8OipMIFDep5XyKsy6ORfqjhbMtu?=
 =?us-ascii?Q?T5bBsR4xEn+RWJknvAyL6uQ+fpzTFfHNb7dMpAken8wOvxMXGUlwkNn0B8iY?=
 =?us-ascii?Q?vILdlX4FBVUdImUEFU16CFwjjM4O4Q6V9GmBYTSm7xm+kDsl+4RMeyv6dGoz?=
 =?us-ascii?Q?HU3JAorEK+YEEm28XQgtaOc7odD0jX3VKSMGTGsxvwqkRA0yq+3a0qkL24/P?=
 =?us-ascii?Q?TeAm+1vhEotZZu5rdYlvAT+nqZQF2n5jj0Y1FzV+ufcKtfHcuY3jFo1dUXES?=
 =?us-ascii?Q?nzcas2LytBN0oTed2DODnnU5Ue7GZbFn6NnWCe/jW1lLnoTwu3DGA7mGg31y?=
 =?us-ascii?Q?WRJOmeCMadGDigbROBYlxReLu57csWSicJ9Xn3YTpJRelCOsOfUUmXQVKjwg?=
 =?us-ascii?Q?9DFWpwmV538TIUd1tTuvLYu8NozFisBZc6zd8bD8U0ZLdihjkTnJp9wOj5Yg?=
 =?us-ascii?Q?LpPjJENqeuUPCqLctb0j5UXHQwCbqpDg5WkQoeJpe1SfazHQ4sbhUzk9xeSA?=
 =?us-ascii?Q?bnST4i3+qLYcZWtwv7JwmwL9VVaEYb4qWaMl/Cf8aI8Ljph0XxBYYQhQtLzd?=
 =?us-ascii?Q?yapZxnMkb/8RBxOVpm6siikOgSciQ+aWYH2G?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: f+OlacF/8uAZBvGw48X1CVJWNIQgLQCpVJgVHYUPiWlPNM0rwPD6hectraMQVR0qjDIQiGyJj8e/wznpvdp/Ziqwag1/JqPqDbR+lZEn6ORWeVHyXVGB0zY9dNTxyICYSH7K23HrSTMmCQ3KAkvVMuxx+NAIHZ5AL9ZJbWpFQepHPmrC34YjA2vRDnSSn5qTS+aDY+KUVenHWI9pLBAdXm6+Zi5uKuswFaRiVkyFnV4GKaik/ZmCtJQDM+ZMujgms3wHiImGyC3SDaBhp7pm5njKeMoqsqBs9rUqR+KnlzRn84LaGTf+jyVB2+89AYcKm8vS4zylIgrFLFjk516s/RuJtqoeEpzvoQvM/Cw6Z9jIozolq2pPxDHWwP23M0wOtzYtGwAqJTAAXRIMmtbxySgqDTr5pO9a42Tr7BvWu+o1Nc7XZ7THK23AGL1lrwd6dW8idsXnLDQc3bJdl2LPPnJ86bmcsWUunsWV45ufpT6sn/0NoSNgSKdgBRIprMAYPpHAPyQ7f7CAacKxh+A+B1T20peEp4OqXKDOLLH6r03hsPbzCqBL3ELZw5oVV5+z6/hGn07zARVoJhIqMOzDckUhTydNXAZnPdSo2csOx/W4ZNtuQsi+mcKOyPutVBiR2hBj1iQhDBV5XfK4AAZthA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:49:19.1013 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03a06260-1684-4f8b-23bb-08dd87edce2d
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1083
X-BESS-ID: 1746020961-303249-7652-580-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.11.104
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViZG5uZAVgZQ0MDIxNLAIMUs2T
 zZ0iQx2cLc3NDC0MDc1NwsOTnVIjVFqTYWADyLEINBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264260 [from 
 cloudscan15-77.eu-central-1a.ess.aws.cudaops.com]
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

From: Danylo Vodopianov <dvo-plv@napatech.com>

Remove double if statement branching as far as it has the same fillings.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../link_agx_100g/nt4ga_agx_link_100g.c       | 22 ++++++-------------
 .../core/nt200a0x/reset/nthw_fpga_rst9563.c   |  1 -
 drivers/net/ntnic/nthw/nthw_rac.c             |  3 ---
 drivers/net/ntnic/nthw/stat/nthw_stat.c       |  1 -
 4 files changed, 7 insertions(+), 20 deletions(-)

diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index 64db55f6e9..6d1d01d265 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -685,21 +685,13 @@ static int nim_ready_100_gb(adapter_info_t *p_info, int port)
 		return 1;
 	}
 
-	if (port == 0) {
-		/* setTxEqualization(uint8_t intf_no, uint8_t lane, uint32_t pre_tap2,
-		 * uint32_t main_tap, uint32_t pre_tap1, uint32_t post_tap1)
-		 */
-		nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 0, 0, 44, 2, 9);
-		nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 1, 0, 44, 2, 9);
-		nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 2, 0, 44, 2, 9);
-		nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 3, 0, 44, 2, 9);
-
-	} else {
-		nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 0, 0, 44, 2, 9);
-		nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 1, 0, 44, 2, 9);
-		nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 2, 0, 44, 2, 9);
-		nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 3, 0, 44, 2, 9);
-	}
+	/* setTxEqualization(uint8_t intf_no, uint8_t lane, uint32_t pre_tap2,
+	 * uint32_t main_tap, uint32_t pre_tap1, uint32_t post_tap1)
+	 */
+	nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 0, 0, 44, 2, 9);
+	nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 1, 0, 44, 2, 9);
+	nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 2, 0, 44, 2, 9);
+	nthw_phy_tile_set_tx_equalization(p_phy_tile, port, 3, 0, 44, 2, 9);
 
 	/*
 	 * Perform a full reset. If the RX is in reset from the start this sequence will
diff --git a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c
index 7b0c47e9b2..918ac71a43 100644
--- a/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c
+++ b/drivers/net/ntnic/nthw/core/nt200a0x/reset/nthw_fpga_rst9563.c
@@ -59,7 +59,6 @@ static int nthw_fpga_rst9563_setup(nthw_fpga_t *p_fpga, struct nthw_fpga_rst_nt2
 	p->mp_fld_rst_mac_rx = nthw_register_get_field(p_curr_reg, RST9563_RST_MAC_RX);
 	p->mp_fld_rst_mac_tx = NULL;
 	p->mp_fld_rst_ptp = nthw_register_get_field(p_curr_reg, RST9563_RST_PTP);
-	p->mp_fld_rst_ptp = nthw_register_get_field(p_curr_reg, RST9563_RST_PTP);
 	p->mp_fld_rst_ts = nthw_register_get_field(p_curr_reg, RST9563_RST_TS);
 	p->mp_fld_rst_ptp_mmcm = nthw_register_get_field(p_curr_reg, RST9563_RST_PTP_MMCM);
 	p->mp_fld_rst_ts_mmcm = nthw_register_get_field(p_curr_reg, RST9563_RST_TS_MMCM);
diff --git a/drivers/net/ntnic/nthw/nthw_rac.c b/drivers/net/ntnic/nthw/nthw_rac.c
index 13813fe516..33e0caa581 100644
--- a/drivers/net/ntnic/nthw/nthw_rac.c
+++ b/drivers/net/ntnic/nthw/nthw_rac.c
@@ -93,9 +93,6 @@ int nthw_rac_init(nthw_rac_t *p, nthw_fpga_t *p_fpga, struct fpga_info_s *p_fpga
 	if (p->mp_reg_dbg_data)
 		p->mp_fld_dbg_data = nthw_register_query_field(p->mp_reg_dbg_data, RAC_DBG_DATA_D);
 
-	else
-		p->mp_reg_dbg_data = NULL;
-
 	p->mp_reg_rab_ib_data = nthw_module_get_register(p->mp_mod_rac, RAC_RAB_IB_DATA);
 	p->mp_fld_rab_ib_data = nthw_register_get_field(p->mp_reg_rab_ib_data, RAC_RAB_IB_DATA_D);
 
diff --git a/drivers/net/ntnic/nthw/stat/nthw_stat.c b/drivers/net/ntnic/nthw/stat/nthw_stat.c
index ed30173bdc..2ddef052a5 100644
--- a/drivers/net/ntnic/nthw/stat/nthw_stat.c
+++ b/drivers/net/ntnic/nthw/stat/nthw_stat.c
@@ -254,7 +254,6 @@ int nthw_stat_init(nthw_stat_t *p, nthw_fpga_t *p_fpga, int n_instance)
 		p->mn_stat_layout_version = 1;
 
 	} else {
-		p->mn_stat_layout_version = 0;
 		NT_LOG(ERR, NTHW, "%s: unknown module_version 0x%08lX layout=%d",
 			p_adapter_id_str, n_module_version_packed64, p->mn_stat_layout_version);
 	}
-- 
2.47.1

