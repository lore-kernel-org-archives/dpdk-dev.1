Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36E6FCCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 15:11:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2CB240E5A;
	Wed,  1 Oct 2025 17:10:38 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 001D540E2D
 for <dev@dpdk.org>; Wed,  1 Oct 2025 17:10:35 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11020077.outbound.protection.outlook.com [52.101.84.77])
 by mx-outbound22-252.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 01 Oct 2025 15:10:32 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aoA1JYzEJbMYRHv15W9Zse/CqIZ9QY+Y+fgLIdclGhLwd/7RID29v8N9J4Ni0Yvp1FNt4WMMxEd4srQTTNlaf+gDz8mL7gDGDppjvxI1SLKr7iZANa6FIjk3xqfJEWyQErabZ5lGOdL1zA3NGU3EdgGcw7wqdy2vBU16sQzPSR+67+rIjcrS9HzD1ZPjTFZ9i73mIT8Kc6Sk9T2mCB4OIDyGNmNCxbXSJSKyJJkXIqF1YzgpRfBC7npkWrSIfhqkSyLUSvYSI4UY0NIL6PFC38f4JHahc5buAvAUNEkfetRCxEik0n+yia1SFdV2ycOhNeLPkc/HBIy9AFNkO8bqhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qfIuqlzGyEB7ZKeEtuoFeXC37nJjgOMmS1pX4Zes3cE=;
 b=eHjYP+xuhLdnqq7bhbosGc28QY12GiR03lBn7NoVEDLrFwQ189zKuysRyjkspeakpcfvY4SKajHCGJnLPk18gNncH1MWduXrmlD0HAYNyM/onTv0A3A0gmJbwBNrFzD8+Beee+2ZA2wZPKJNfCoYjBl+JSqlzc3/VL+C5BJ/Kln5GeYeAMX9G0MGZ1K5US730bSelbhYFb+Rtjyk80lwG+ECVoIhIpDjcDESqdLKdMgmOvXgTkMgF9WPrO7djN/6I5y1kPyXEkcz1KGO26CUU2UzPjCLA1YQiolaUW0JfGq0j8ln3449gUFaLUhu+6cpCERPIhNGoETcC9+zD1pI5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qfIuqlzGyEB7ZKeEtuoFeXC37nJjgOMmS1pX4Zes3cE=;
 b=WiksaK+OpGEsj7LA5H7JvZuCTrpU5HYm6YRaRkPjBtfpr7e6yICq1Ek91HFdgriho1kJcxmljFIvTeEWBaGAWNu4Metm8y+hCN8HbP4y79L5lUfYSGnWeNwSndt6PHvrDlbIZqao9oCyCIQ4FbspvYJ4RL/pdY0FO0Ry7F3Tr4E=
Received: from DB9PR02CA0015.eurprd02.prod.outlook.com (2603:10a6:10:1d9::20)
 by GVXP190MB1848.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:6e::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 15:10:27 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::67) by DB9PR02CA0015.outlook.office365.com
 (2603:10a6:10:1d9::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Wed,
 1 Oct 2025 15:10:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server id 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 15:10:26
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 06/20] net/ntnic: add reset init stage 3 and 4 for NT400D11
Date: Wed,  1 Oct 2025 17:09:48 +0200
Message-ID: <20251001151018.250671-7-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251001151018.250671-1-sil-plv@napatech.com>
References: <20251001151018.250671-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D02:EE_|GVXP190MB1848:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 1d785ca7-28ab-4e34-b963-08de00fca730
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?T3UpfAon8+/x0jTLoAo0fAM9zK99YdBKFmhq/BJpld4AvHIxsxhesDjVkQGk?=
 =?us-ascii?Q?3K0D+yVw3wN3Q+YcUju98SB1mr9yz2uls58axq/NkWqcOsUCQMO1tXTUiFCR?=
 =?us-ascii?Q?14JYOvbnW7BQsxNZzrzoXDB4IlKtvtw+O+sYt/5yR2ezIZORxOj3ik7UDGwj?=
 =?us-ascii?Q?429lppKd4y0UtUyKiFUE/sNRlB6wVOyHYkg0KHxjymRvR4s259g3EDVN1y9S?=
 =?us-ascii?Q?S6ybxvFc8TxN1R3n4YCSQUD5UpQdAs4DVENkL9qnXFbkin/fVz5c9/tXfihl?=
 =?us-ascii?Q?Ejk2J949bOy62gVq3VkjOIzsnkxCXJKbocoAvWoNRPWhkZTJ98rrKRVnNSQo?=
 =?us-ascii?Q?7SQaWlREPQzb96gVYTN2O7yzjjFSl23ZAcznKRNDkQMv/7XCCIZ30IlYjofx?=
 =?us-ascii?Q?SDZ1AXme8VkXlUdVn/s3o7+hzq4/pivuWuIzSu2WJfanQTk/4/pAQlNaKMiP?=
 =?us-ascii?Q?UrQdueNaWHlrVYfpMMbvIa1LaIW+vE624pr8eUq69G9T2iPMCiukAIWruDR/?=
 =?us-ascii?Q?CK1vLMSbYuxknGs7gKKGkSeoaFNsnbDFcr0z/JpzoC3M/ljGP81TErddaxzb?=
 =?us-ascii?Q?zxVAWQGXgfA+C52M9eDwsKYN4nyrEuL/2q5npVjk/DAGr4+bsQ8EfAGGPLuS?=
 =?us-ascii?Q?Az00xKjfitsXz5GLYNoDWQTs0mh0FNjEeB/EdABbwxzgjDjpeWO36EIfvU9L?=
 =?us-ascii?Q?RdHEtwqJkyRKJgHVtlavU2Xg4XNAIiXVa899Gc1TZErFcGEyHmj7mzy4Vc/T?=
 =?us-ascii?Q?3z1QuEVYnYpI1FQHxOhKO+CblEAtcNn6He47A/IDk/o+/n6XMs4nND69OJaR?=
 =?us-ascii?Q?ZinjF2cqdbAK4Fd1wd1N1F6UHEy9f72DGT+bNGb5lbTMpUmFCGp1TDLX6b/L?=
 =?us-ascii?Q?KxIYmxvM61fYrHTaXmxHhaDVvMcz9znfGn6Q04dWKA+o1xEmeYwyFs4gdao1?=
 =?us-ascii?Q?kcg4cetuITT53DUdflDF8CyrvHSzJV8YBUfYZdIGFk6KcyZ2H+Kzqree6TFd?=
 =?us-ascii?Q?HIf7m0UzSkFLUidAFn8vS2Q3OJ11WdRShHzwbVPYUofBuhhEzvorsrjQ0Gd5?=
 =?us-ascii?Q?SZiTz/Q/YPk1Yle8fA+DlWNmKWK/LnfSp9AqoCpTj2x9VG+RYHzRYuOikj3s?=
 =?us-ascii?Q?/T3j67CRalB2ziyA9yYjwMbqgdEKRgWw+IWik+PjnY1AfUfRrn4gnrkI3eMM?=
 =?us-ascii?Q?8SSNHPzkDbtmPQZ3iPF6VXYAMWhrhSVssmJBIpnexd4G0HHdRuGF+tqlOurB?=
 =?us-ascii?Q?EBZK2CmJhgl9jf7vCEFRXVD1GX9Ldk3iVlmDE2toh/3nbDCIf7mRQbc8ZQLS?=
 =?us-ascii?Q?dNHfBopDggAdHXlj5Nz6/4ViXD22lmS1v7aVK6y5KMXZjJz7bcVzUWOQJRWM?=
 =?us-ascii?Q?Uj8Rplu+1g0l5uazKDT6HHbVub3+nISB26j6A7MuzyLcq8yCWrATVslNsNqd?=
 =?us-ascii?Q?1iAv6aAKySYIAFDJHTNNSB/KDsrK1QM8Ta9yBJFKWjCOZDsGUfrBDwZrZtLN?=
 =?us-ascii?Q?gt28o7FqriN2UShWL3X2LCrMYBExMDOB6yWyS+9ncw8tD5iU/EbqyArI2qdc?=
 =?us-ascii?Q?W+fHY15Vhj9hxRWgmoY=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ohAzStqp4CATBOw0mpn7ZewCuPxqm+1TnhXcwqcFl1NVhC/eNSGvw5Yfd/0tWHsoZaSLqJqXDDA04sKQEDVMlfCV7LA51s0iKC2vz/63VYiAk0I8PNPvFeYnHqUxAlVwjz6gZAM6MxHGwCpLPvCbD7HfIXMby3AjZMB6BatQyWQoEJjqvlJXY1emx8Zsxs5BgH14YOpZcd5MqXFD56KzhEUoLZ8GFIXkQkDpn3W8lT7Nvhu7KNf+aCu6xmRymSfWnJgfUSaMPFbHaZIRv/YByjvASi+Xox+lOws4corNPUKYlSQCUJ0ZhmfVmHzTKhWYqh8mcM1Dxyp0qc3CTsMMUe7aOsUTuXHCHCw71flGUnEeJIgm0ijF/FyH/8uNSFMemaPgzODWMl5Nqk2bhswucKvbWLZlc8GymFYU17FAy603BxnWmTUJyRwqYUtVXOj7nGIjhYuo5s9vHNWJBiwLlZW3wZm0zZ62+XfcWD8/nY4YPq41+XPlViUlQIGp8xjkRB3CdGHi/6vRiYG59qsPYa/YR5gK0M0sj7eX6x2/FiT+Nb8bYBcKT5BwV6nMeILVl7wr/LkfQp9LhG7mhMPpiWQDwtcGcK/y+cM1ncTDrYJ9xTtnVYWtdNns4xqt3XROc9dgAsdOlU3TznvSkpVS2g==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:10:26.7580 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d785ca7-28ab-4e34-b963-08de00fca730
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP190MB1848
X-BESS-ID: 1759331432-305884-7639-4377-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.84.77
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYG5kZAVgZQ0MQkydjALM3SJN
 nC0NjQLDk1zTTFItEi1djCzNwyzdhMqTYWAK09FW9BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267892 [from 
 cloudscan21-198.eu-central-1b.ess.aws.cudaops.com]
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

add DDR4 calib complete latched bits.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../core/nt400dxx/reset/nthw_fpga_rst9569.c   | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
index 5e127ecc86..e416e739da 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
@@ -84,6 +84,13 @@ static bool nthw_fpga_rst9569_get_ddr4_calib_complete_stat(struct nthw_fpga_rst_
 	return nthw_field_get_updated(p->p_fld_stat_ddr4_calib_complete) != 0;
 }
 
+static void nthw_fpga_rst9569_set_ddr4_calib_complete_latch(struct nthw_fpga_rst_nt400dxx *const p,
+	uint32_t val)
+{
+	nthw_field_update_register(p->p_fld_latch_ddr4_calib_complete);
+	nthw_field_set_val_flush32(p->p_fld_latch_ddr4_calib_complete, val);
+}
+
 static int nthw_fpga_rst9569_wait_ddr4_calibration_complete(struct fpga_info_s *p_fpga_info,
 	struct nthw_fpga_rst_nt400dxx *p_rst)
 {
@@ -127,6 +134,11 @@ static int nthw_fpga_rst9569_wait_ddr4_calibration_complete(struct fpga_info_s *
 	return 0;
 }
 
+static bool nthw_fpga_rst9569_get_ddr4_calib_complete_latch(struct nthw_fpga_rst_nt400dxx *const p)
+{
+	return nthw_field_get_updated(p->p_fld_latch_ddr4_calib_complete) != 0;
+}
+
 static int nthw_fpga_rst9569_product_reset(struct fpga_info_s *p_fpga_info,
 	struct nthw_fpga_rst_nt400dxx *p_rst)
 {
@@ -163,6 +175,18 @@ static int nthw_fpga_rst9569_product_reset(struct fpga_info_s *p_fpga_info,
 		return res;
 	}
 
+	/* (3) Set DDR4 calib complete latched bits: */
+	nthw_fpga_rst9569_set_ddr4_calib_complete_latch(p_rst, 1);
+
+	/* Wait for phy to settle. */
+	nthw_os_wait_usec(20000);
+
+	/* (4) Ensure all latched status bits are still set: */
+	if (!nthw_fpga_rst9569_get_ddr4_calib_complete_latch(p_rst)) {
+		NT_LOG(ERR, NTHW, "%s: %s: DDR4 calibration complete has toggled",
+			p_adapter_id_str, __func__);
+	}
+
 
 	return 0;
 }
-- 
2.45.0

