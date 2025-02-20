Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C8BCC021B3
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:06:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7A87440DF5;
	Thu, 20 Feb 2025 23:04:36 +0100 (CET)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 56DD840B97
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:27 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02lp2049.outbound.protection.outlook.com [104.47.11.49]) by
 mx-outbound46-229.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDBZ9gaBUfs1i44q/CC/A72gTwFewDcPFaL1u8cXwbAutg8VFmzkR7OuuJ2DEpK6QYYph2Y501+7krnw2w/haZrqyfjvmMqvAyvxFXOnZMsPE2N3sHezS11Vh5hH2V1lehI51wkIgsflXvX681Ii6W+YHqHj2C5nf6+nAmnjhJx4pIsrmqSOt2C13ibSefZUjExZYVQPp197Z/NcZ/4W1Gy9W0ycDhIN8YRPujuN0KN9srxtAc2b+0TfoXTvhSUMxrv3evMgphbyCYrGsBny1QLnxmC08sPw4seXhT83slmJnmFYwOfKpUQAH69CiyAvj261+0aa1MVvQ5l8YkkvBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3iuy7bA/jDDsCI1G7kHPxr4iKq8AW9EvUEmprAGgZZQ=;
 b=GMwOZ49ZB0OJ0lmD92q0LCVQd5W3m9s5kJzorrSHCm+F+fLy2FEhsQha6uvrPr3tVppUtcNjywuGYGE0LcKkCVomP+XGjMViAcs9n3+ZpJYDXXYYFeZsM6yF6+KHD/llZ8qGmTchaRR/gSMSCgDjqfvI8r9mFdnBaVedPdr4nS66j4wWq09nyKr274ReA+p7+sW5p324V3Y3vfGtiBNl32Dnqa/mB5XYfCc844JJD28qaONFTD61jx5oi08T0vFnFrmY8NRn/2THJbWBpoXS/O7rfIlS5zBONFo6uDfvHpE0eIpF7CPJ1v0wfGj9AbeecOrnX9WM42Ry0bab5GEpUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3iuy7bA/jDDsCI1G7kHPxr4iKq8AW9EvUEmprAGgZZQ=;
 b=UHZO4Iz6euxKmEzyADBzL51Ay6R8qBBAXaUsKfBZuMJQ97k1IO1lp4e3Zgfzzmbij/SOVcE/J4B/A03mGW26MfTb+Rad2EmXgEkxz92sjjfZULO7mZT19v5OMG9yBkjBtpLqJ97d745N/6/mpZbv40nwXsP8jLF8dY2ha5qgsLQ=
Received: from CWLP265CA0496.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::17)
 by AS1P190MB1823.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:4a3::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 22:04:24 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::a0) by CWLP265CA0496.outlook.office365.com
 (2603:10a6:400:18b::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.15 via Frontend Transport; Thu,
 20 Feb 2025 22:04:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:24 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 16/32] net/ntnic: add setup for fpga reset
Date: Thu, 20 Feb 2025 23:03:40 +0100
Message-ID: <20250220220406.3925597-17-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|AS1P190MB1823:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3be816b0-3c99-41f7-ac98-08dd51fa897e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?SXWKj296JVavLMU3hGIIoXf8yqQ+HeuOO7LIVh04UoSzb3CQsneFncB+6U+0?=
 =?us-ascii?Q?Wof76XdjIZvGej34Sp5qPS5BLyPzjrmNvlebsfkSEgxjlLGCsjvt3bntqOOv?=
 =?us-ascii?Q?HCVkbgmmMo0K4p510HfL9Ve8ieWDWeQ2mcG68TnXoYVLcGkNaXTGG89hp2ZG?=
 =?us-ascii?Q?a+wyXZ8OlA++sgflxqojy+E/lipn7tT7LCSLebsvLWUfUW/gQ+o8lvwNcMPZ?=
 =?us-ascii?Q?Y8yJ8lG5WRMuRm/Vq2074srD4ifCWKEsVUv2EsQaztJgibeN6LedtYFt707F?=
 =?us-ascii?Q?FmE4yUyE97t4HMqVX9kfhGTcGHMNI0i1UPi3t7gNGq++b8GG5NLjRK9+b/Lo?=
 =?us-ascii?Q?W3dsOc8VrHSut6uaiYEmoPnN5oP1Zcq2bc2uPnMdwCyQ7Q5eURDr9oFwqgCV?=
 =?us-ascii?Q?17capxxA82IlARmyWbVXgLfK6ejh52RzDXbxaf+MeVvhZlmJEWv1a2vvCHb+?=
 =?us-ascii?Q?g5yIbWK/mCzB5zUU99sgHuoUhnmrwg85vUd4LvtZ8ScIgKgWS1YYkPHtewz5?=
 =?us-ascii?Q?sbviExKtnhhB3vRS0+2HRUWzBfEsQr1tnoAlc5cKCd3v2qUctvR7dbW9ZcDp?=
 =?us-ascii?Q?To1dkUPFzrKejHr2f7/ApUZFPgUV1krU+fU03AgTBf6YE8z1sBftWGfpV4Hu?=
 =?us-ascii?Q?aQjHERmWWQTI0Sy6ALjJKARFYLUz8NYynFcANMatDDd8he5LWzNsi3m+YtPy?=
 =?us-ascii?Q?o59WaNnNERQG21oxj82F+HoGVSzxskwD1BjGEyETIaZOcBVDHpa0fkU5KWG0?=
 =?us-ascii?Q?QYcWXv5FSKnQWsz7Y1CdhI1A+PPzU4F+mYZlEq4Wqb/dXn9La6aaCn2ar15Q?=
 =?us-ascii?Q?L6exQO1pDWySE22pbyoLYStxFYUWdZz1q0AtvNbte4U3iE7TD19o9L6i2+Sa?=
 =?us-ascii?Q?rCswhx5RFUwlpkYHrtmXjPpkFWMtyvqpFbopvfexEh8rlFJ0UFxLufzJIOSu?=
 =?us-ascii?Q?Z7SyXwCJW1X75wmzpVVXZ+ZsBXgrFUlurkv6ojUsEcFogTbeqoiTq1J+B5+m?=
 =?us-ascii?Q?mxpSK8plRyf58bjaOYqSDZipSE5vUBcx52n8bAOXbEpfs+o0N+eE0yleQuww?=
 =?us-ascii?Q?WFp/b28QrdLZsML2RpB2TuoxbA5YAo/dp3lquS1jmB8KgNebUvww1dK/NEPe?=
 =?us-ascii?Q?bYpzhJo6WIPSE2zaT51R8mqp/7Wuz5DSLuWJ7FWGdE+WpPlHzbTAOAQcfayA?=
 =?us-ascii?Q?6LN3LB6dpZOv8zisbLqnvF7ASFNib1qTpJM8cFsrSrw7tVQ1PhdwvIUVw9RZ?=
 =?us-ascii?Q?CP1IrUbKTHXdLQnKWbKrDpNeCckrMXqnYSwgvI4eMXMt/i2VOOlzf2xMpI6T?=
 =?us-ascii?Q?AzM9CUhYmfzk813HGGMmmw5hEkyFBKtxg5t+JtERF4bZ8H+6v4vIhYDCuIn6?=
 =?us-ascii?Q?LOqihPEUzlO37aJ6YFz3MmpeMJcH5GknAp3Z3hWV7sz3AkCOwDYw4gEACTJl?=
 =?us-ascii?Q?zBB6pv5p31K5sAU6bvn51s1arwywoj2ZXHuSHU5WPYaDcSZcaLgFtw=3D=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: cS2bNwo1pObfe0VscjO4nmE8RrKiYPyvYOryt19Smz+rD51IMwxXxwVhb2YPOktyOey6KSKz+MNtFP67fD0XbqcmMWBO/bm3MENue/uVtZiGIWqvPAE52uY86RNY3s5HJWwYfeq/+Ydz9SZACpJnOC3Gj5ScbGSwH8Tw0qp2q4PHyWreklqozb1UQGQV/rXXCLmtWUIgcITVjbJfYEKfgqbFN3oYHgb8LTg2a5waUkohCmTUwbzZf66uVJWrZ14NCFGXz/Adyl51wlMb7Xls07ljUYZmtRthoyK2xDYARAg+wqWoZVQIFL5OVMV/yyWgqGEbDt+iGqcnG8HwAliQ296UNRw67DBDXLpZFfYindrBldqFMbN3+nzb19+j5HQwImgw22z44rxjB3PAKoieGl527IdkcQAKKztxx5hHaSdM4/nhu0nNp2zqmzAmx2kAUkvyNNBE2ZPG0fTyc5v1lhy/VlgJck97mtmCV5SvUFRWbdMbdoGrLxESbUd7/+76RdxypohAPIN0b7MUBStblcjPVzgNwIiZUIzL5b7Nhd/ZQdb/QMQl5h57iB8tA+it9DW7H92FePJm9WoAzx28QFaxpIH4B9wOqsrvE6MHOu1Nh/G66TKfXtgjnsHKNfNuX84d3kXOxmOb79cX5nj5gaObfe/+ZJAHR4dtaIlEQbk=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:24.5838 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3be816b0-3c99-41f7-ac98-08dd51fa897e
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS1P190MB1823
X-BESS-ID: 1740089066-312005-29067-14094-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.11.49
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYWFpZAVgZQMNk42cAw0dAsKc
 koJTnR3MA4MTnJzNjUwMDQwNDS0jBFqTYWAGsja4lBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262653 [from 
 cloudscan10-185.eu-central-1a.ess.aws.cudaops.com]
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

Initialize FPGA reset module and register fields.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../core/nt400dxx/reset/nthw_fpga_rst9574.c   | 54 +++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
index 9ab26583df..bd38d6b8c8 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
@@ -14,6 +14,60 @@ static int nthw_fpga_rst9574_setup(nthw_fpga_t *p_fpga, struct nthw_fpga_rst_nt4
 	assert(p_fpga);
 	assert(p);
 
+	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
+	const int n_fpga_product_id = p_fpga->mn_product_id;
+	const int n_fpga_version = p_fpga->mn_fpga_version;
+	const int n_fpga_revision = p_fpga->mn_fpga_revision;
+
+	nthw_module_t *p_mod_rst;
+	nthw_register_t *p_curr_reg;
+
+	p->n_fpga_product_id = n_fpga_product_id;
+	p->n_fpga_version = n_fpga_version;
+	p->n_fpga_revision = n_fpga_revision;
+
+	NT_LOG(DBG, NTHW, "%s: %s: FPGA reset setup: FPGA %04d-%02d-%02d", p_adapter_id_str,
+		__func__, n_fpga_product_id, n_fpga_version, n_fpga_revision);
+
+	p_mod_rst = nthw_fpga_query_module(p_fpga, MOD_RST9574, 0);
+
+	if (p_mod_rst == NULL) {
+		NT_LOG(ERR, NTHW, "%s: RST %d: no such instance", p_adapter_id_str, 0);
+		return -1;
+	}
+
+	p_mod_rst = nthw_fpga_query_module(p_fpga, MOD_RST9574, 0);
+
+	if (p_mod_rst == NULL) {
+		NT_LOG(ERR, NTHW, "%s: RST %d: no such instance", p_adapter_id_str, 0);
+		return -1;
+	}
+
+	/* RST register field pointers */
+	p_curr_reg = nthw_module_get_register(p_mod_rst, RST9574_RST);
+	p->p_fld_rst_sys = nthw_register_get_field(p_curr_reg, RST9574_RST_SYS);
+	p->p_fld_rst_ddr4 = nthw_register_get_field(p_curr_reg, RST9574_RST_DDR4);
+	p->p_fld_rst_phy_ftile = nthw_register_get_field(p_curr_reg, RST9574_RST_PHY_FTILE);
+	nthw_register_update(p_curr_reg);
+
+	p_curr_reg = nthw_module_get_register(p_mod_rst, RST9574_STAT);
+	p->p_fld_stat_ddr4_calib_complete =
+		nthw_register_get_field(p_curr_reg, RST9574_STAT_DDR4_CALIB_COMPLETE);
+	p->p_fld_stat_phy_ftile_rst_done =
+		nthw_register_get_field(p_curr_reg, RST9574_STAT_PHY_FTILE_RST_DONE);
+	p->p_fld_stat_phy_ftile_rdy =
+		nthw_register_get_field(p_curr_reg, RST9574_STAT_PHY_FTILE_RDY);
+	nthw_register_update(p_curr_reg);
+
+	p_curr_reg = nthw_module_get_register(p_mod_rst, RST9574_LATCH);
+	p->p_fld_latch_ddr4_calib_complete =
+		nthw_register_get_field(p_curr_reg, RST9574_LATCH_DDR4_CALIB_COMPLETE);
+	p->p_fld_latch_phy_ftile_rst_done =
+		nthw_register_get_field(p_curr_reg, RST9574_LATCH_PHY_FTILE_RST_DONE);
+	p->p_fld_latch_phy_ftile_rdy =
+		nthw_register_get_field(p_curr_reg, RST9574_LATCH_PHY_FTILE_RDY);
+	nthw_register_update(p_curr_reg);
+
 	return 0;
 };
 
-- 
2.45.0

