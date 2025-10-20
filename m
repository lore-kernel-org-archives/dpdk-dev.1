Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C580CCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:43:54 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C6B8C40A82;
	Mon, 20 Oct 2025 18:43:48 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id E511A4065C
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:43:43 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11021113.outbound.protection.outlook.com [52.101.70.113])
 by mx-outbound47-33.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:43:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iNrO8DzvXVYZmujD8+vfa7yTd+0tAC7z1R4iYRPAToRel+lTjxGkvuvicHARtp3Faj2MjvfOpZSHhaX13tYPRsVBA3HgbJaMha2QrGB5UZxZ4GnOrhdY8UB1JwBPNN9NhbbNXL4IqHVJo2I9jZQqlcxxxGFZaunzHDr01cKmGtWFDfRkEgFr2hTcUGaMcTm4WwYvIE6mFetebF6cPUMCn+dshLbDA//cFPniYVcsZMeNLNiZCxIESkJcj0yd6L/eZ7NoEDWyr7wlnM8eanVcX2nNXWS1rsmsXdHkz4uiLS+3Oxp5yoUyg2PjS4sY92PSvPW0kGYXnBIDnaOIjC/GUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jehF2W3peIwFRqCuwS4PEVKPoAo7U6Ib2p8d42vYKBQ=;
 b=NXJNJs/lmn4n58D0mAHZlyXc4fhC1VJRRCGeo5ySM1rarlCT0I/MkD2UmXwZJjITmae5ZH23w2/Jz3TDOrvk+foB2DmvAZ8eLKxd6spoJA7KlOeRgpDv2/RqIBUGgdwaaciPXb8HGDoiGDdK+Z9lini80uMbz4df6IrT6VuT6qgqS/Nopi2xubFsBfyRo791wECobpUhnIQ3cgUtSAa8DqSO7uqtA8hLlg47YL48MR/V86uCvhNewg20vrqbyviwKvHEJhH80RTGqVb0hQhkNvYc9MK7lfY6hzRsPmS6imD5AL8Cy9Y5FZHYDnmou0/ie6JDODLpKYvHUHHYCeeH/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jehF2W3peIwFRqCuwS4PEVKPoAo7U6Ib2p8d42vYKBQ=;
 b=R064QPfR2WSLNzMkEUc0OlkDZdExgeh8tIXMby67ZZKoITZlq8v70DY33f3y1HeHfHD96ZPSbpMpG5EmS8xat/v7wgn3mhp2oUgIAqYqCslCURi7q+exQa5hcB+OhT2OChtCCH4A1BMFOrirnsDpSwaMuoAzETEoADL6kMPsfCA=
Received: from DUZPR01CA0026.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::20) by PA4P190MB1328.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:102:109::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.12; Mon, 20 Oct
 2025 16:43:41 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::ae) by DUZPR01CA0026.outlook.office365.com
 (2603:10a6:10:46b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 16:44:00 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:43:41
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 02/21] net/ntnic: add reset setup for NT400D11
Date: Mon, 20 Oct 2025 18:43:11 +0200
Message-ID: <20251020164336.283664-3-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020164336.283664-1-sil-plv@napatech.com>
References: <20251001151018.250671-21-sil-plv@napatech.com>
 <20251020164336.283664-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|PA4P190MB1328:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: cd6b6faa-0268-4631-dcd9-08de0ff7d36c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?isR6aKM1FDy6Sgr8aNRFqe8Ls1nQpsFViVUbYyw0HyyxPoeP3cfG7hR0+bi7?=
 =?us-ascii?Q?Ypq1gsWt6fR5Erx0o5SVFT+WesSkv38izlbyAsq0nfWds6smPriDFXVC/9h4?=
 =?us-ascii?Q?D6XCC84JRATo999MCI8oVEQR8IbXPuL4bKio9jaChC7IKa7t9oCPhGSV6y6a?=
 =?us-ascii?Q?npnhITMcOThLBU9yR9q71o2Uso4fkbSViPWLqPoYTtBj46Al7f8J9++ZzJB6?=
 =?us-ascii?Q?yaym2ZESbCxEgjC6r+NM60618osLpFyotBjbhsQwkXfMTi09bFXnU1NXHbJB?=
 =?us-ascii?Q?OEgtbs6gQjI+qVB7l0EBhQ//5CfMZy6ziXMDXdMERFolb8Dwed15K22Go07h?=
 =?us-ascii?Q?x8Q1vz86OyvbeAjgmdB4NKhc+VrQVcDLl1LlMBdfJC2YunqpvTQY42DhOCFa?=
 =?us-ascii?Q?xbri37LgPys92ou6ejMODZL20U4SdkeoEBW5EMZ9kZEifJfs6bR/ujyj6R+k?=
 =?us-ascii?Q?aaEBwIf/64ZiyKylQiaAtHQ2SaBdTJQNhS9z3Q2fyYc4KSr7xa9mU8u/Ea3f?=
 =?us-ascii?Q?My9+vKonPFoMJa3/dO70zU6m+QN37WtqI04iDQ9TTWRfQ3m5iLaFhzJO/Nxn?=
 =?us-ascii?Q?pen2FDdzfU8gh+CPdXSrXHSK1pXeT3BH1jE6SDg9Qi38DCzv8Kc0v8vGyztm?=
 =?us-ascii?Q?7H2z8Q6dUznwb9VjI8Yl334hepyvM51KnL2VBOTX6yhWkt1+Bs+KfNvuLUaH?=
 =?us-ascii?Q?/y9+Ik29TjZwtowZuYRahs8ebh2RGUm0eAtXs53FaXCN9spK1c9ESBEIkCA/?=
 =?us-ascii?Q?dXBCDkXD3kgZ4tQNkKMTEm+gzsqIZnhFPfPEiwIYZ0puzihxA8mf8hdxWSem?=
 =?us-ascii?Q?HHSap5jk9QhisUZQ5n+eEjsGkfwpAli4KQWFISwhG3UyVXlP0TX2GxJKeQ+u?=
 =?us-ascii?Q?8vhBi2NBXwMoEltRnYF5yZQ6tlj+msjIJd8D0O/d1+rdcb9Cw7VpUxyX2TmX?=
 =?us-ascii?Q?5loZjhmbix0uE29+NRwqFETNdGJVINjK3PfBOMEUFikXxtJGT8z876aKr5qc?=
 =?us-ascii?Q?Gs5leIYhzfNxmTk/UczdL0epmOkNSNe4gtbQ7KHzbN8AXP1rhfshpmncq2L/?=
 =?us-ascii?Q?/vHaLCn909HITpWZ8WkVHOk6PHXh/VQ6TzKdptgwh5wSO+kA+uzE78ZPNquX?=
 =?us-ascii?Q?065gRrFHFPiNRw9cbsBNJmP4lFFjaxLaUdNgnsYCn0Gvauc5MBVSWqRHctpw?=
 =?us-ascii?Q?yVLL8GbbdivE/yWZ04pzUattQoU12Eq92RCRFVBNLsVxG03X7/BGOGEIvSNX?=
 =?us-ascii?Q?GNFXmmFgw8buLj23Wbta+TZuKoZgzhTvw5Xv5F9hiPWmmX9Uy3ls8a8RZgsL?=
 =?us-ascii?Q?dv/kcHMKGsuK0rWCAWp1syGk/Pub9GhdYwGV8VdVGXPLxLWJPsRT1CIZ5qx9?=
 =?us-ascii?Q?g4aanRQv3zpN3dl3kiYG+GhqJD5J7ZlWV4EleHyxBHx3ar8y3Y3Go7+kuE+V?=
 =?us-ascii?Q?pnKJFI/a7vanR5bGn8CzGxt4B3pPxqr97iOUeX+d11+7K7BSloBeYlxkolDh?=
 =?us-ascii?Q?fgBjkBSEw/3ZKL8JlRq/ExLLWwg1n3SmLK0XfwJ5wexAMaacwwTEWVmP6CgS?=
 =?us-ascii?Q?aB/To6yVR73Wu3GEG9c=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: ggXDfbD6QadswVK/0SRDDsmBJiQK858+6itcBCHmfXaaLqR4zNZ242FbVv5/l2klxxEQYaxKyzweztz2sh+XWDY9ioBrxLnHpoYlXDsOXzNpVeCOkxdtDN3pbvDWn+aXHm483TGB/C2zi17F75h+oCvBX37mhpIVJ/Jx3XeLgJn8L+MicwzDx71InB27enAB5nzxEmGdJqXdAVyfHIKVsSjeTbZIXnRF1keuIPnxTSM2oEvfSDSwleuUG7/M6ztmCA8niy1NkHsCT48uDXFmYNBWbqGF2RJOhW9+iEhVU4HVun+zCFj/24jmBbct5QSjyEWxm6xGSeBkIio9c5Yu3OKbmwjiHvMHQ/v/hoEI8CXcglIuefftCpl4cYl4YRwluTU4rm0ciuxBPorkkpyCPpU13lwtLFtJ/Um/gDXz8D7fBzeYAHyjq7WUX727lZWykRJTmB3exHjpDR7RVvHlACf7qzPnB9j77IwiAtA76Q8QdvJlNWB7eBqw4v72DLL8GP8aQP+bbkLvp7J3qwAC3sB5WbZh0qxI356+x2q7p7LyO/ouJbYJAgKUUaspbtCIhgXjs5yJlgEFW42/wd96JG1vH7rgI4UTrC3FuRF8YdK2rQcL/e5y4zcxhLj4eKXTdawQxQCj31ixtaGmrU5aZNxHX6BepMSY4J5IRP/3s+U=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:43:41.0232 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: cd6b6faa-0268-4631-dcd9-08de0ff7d36c
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4P190MB1328
X-BESS-ID: 1760978623-312065-25065-118143-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.70.113
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmZmJhZAVgZQMNkoMTHV2CzJwD
 LZzMIg1czcONnSwsICKJZqZmmZlKxUGwsAob2IsUEAAAA=
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan17-205.eu-central-1b.ess.aws.cudaops.com]
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

Add base register initialization.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../nthw/core/nt400dxx/nthw_fpga_nt400dxx.c   |  2 +-
 .../core/nt400dxx/reset/nthw_fpga_rst9569.c   | 54 ++++++++++++++++++-
 .../ntnic/nthw/supported/nthw_fpga_mod_defs.h |  1 +
 .../ntnic/nthw/supported/nthw_fpga_reg_defs.h |  1 +
 .../supported/nthw_fpga_reg_defs_rst9569.h    | 35 ++++++++++++
 drivers/net/ntnic/ntnic_mod_reg.h             |  3 +-
 6 files changed, 93 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rst9569.h

diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
index 99b317d916..8ae06417b8 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
@@ -132,7 +132,7 @@ static int nthw_fpga_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 			return -1;
 		}
 
-		res = rst9569_ops->nthw_fpga_rst9569_setup();
+		res = rst9569_ops->nthw_fpga_rst9569_setup(p_fpga, &rst);
 
 		if (res) {
 			NT_LOG(ERR,
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
index 3d1c09fe2d..254703bae9 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
@@ -4,10 +4,62 @@
  */
 
 #include "ntnic_mod_reg.h"
+#include "nthw_register.h"
+#include "nthw_drv.h"
 
 
-static int nthw_fpga_rst9569_setup(void)
+static int nthw_fpga_rst9569_setup(nthw_fpga_t *p_fpga, struct nthw_fpga_rst_nt400dxx *const p)
 {
+	RTE_ASSERT(p_fpga);
+	RTE_ASSERT(p);
+
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
+	p_mod_rst = nthw_fpga_query_module(p_fpga, MOD_RST9569, 0);
+
+	if (p_mod_rst == NULL) {
+		NT_LOG(ERR, NTHW, "%s: RST %d: no such instance", p_adapter_id_str, 0);
+		return -1;
+	}
+
+	/* RST register field pointers */
+	p_curr_reg = nthw_module_get_register(p_mod_rst, RST9569_RST);
+	p->p_fld_rst_sys = nthw_register_get_field(p_curr_reg, RST9569_RST_SYS);
+	p->p_fld_rst_ddr4 = nthw_register_get_field(p_curr_reg, RST9569_RST_DDR4);
+	p->p_fld_rst_phy_ftile = nthw_register_get_field(p_curr_reg, RST9569_RST_PHY_FTILE);
+	nthw_register_update(p_curr_reg);
+
+	p_curr_reg = nthw_module_get_register(p_mod_rst, RST9569_STAT);
+	p->p_fld_stat_ddr4_calib_complete =
+		nthw_register_get_field(p_curr_reg, RST9569_STAT_DDR4_CALIB_COMPLETE);
+	p->p_fld_stat_phy_ftile_rst_done =
+		nthw_register_get_field(p_curr_reg, RST9569_STAT_PHY_FTILE_RST_DONE);
+	p->p_fld_stat_phy_ftile_rdy =
+		nthw_register_get_field(p_curr_reg, RST9569_STAT_PHY_FTILE_RDY);
+	nthw_register_update(p_curr_reg);
+
+	p_curr_reg = nthw_module_get_register(p_mod_rst, RST9569_LATCH);
+	p->p_fld_latch_ddr4_calib_complete =
+		nthw_register_get_field(p_curr_reg, RST9569_LATCH_DDR4_CALIB_COMPLETE);
+	p->p_fld_latch_phy_ftile_rst_done =
+		nthw_register_get_field(p_curr_reg, RST9569_LATCH_PHY_FTILE_RST_DONE);
+	p->p_fld_latch_phy_ftile_rdy =
+		nthw_register_get_field(p_curr_reg, RST9569_LATCH_PHY_FTILE_RDY);
+	nthw_register_update(p_curr_reg);
+
 	return 0;
 };
 
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_mod_defs.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_mod_defs.h
index e2a98a737a..8d5837bac1 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_mod_defs.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_mod_defs.h
@@ -51,6 +51,7 @@
 #define MOD_RPF (0x8d30dcddUL)
 #define MOD_RPP_LR (0xba7f945cUL)
 #define MOD_RST9563 (0x385d6d1dUL)
+#define MOD_RST9569 (0xd8888403UL)
 #define MOD_RST9574 (0xbf22c9ffUL)
 #define MOD_SDC (0xd2369530UL)
 #define MOD_SLC (0x1aef1f38UL)
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs.h
index 5b824ef3e5..c16beb5faf 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs.h
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs.h
@@ -50,6 +50,7 @@
 #include "nthw_fpga_reg_defs_rpl.h"
 #include "nthw_fpga_reg_defs_rpp_lr.h"
 #include "nthw_fpga_reg_defs_rst9563.h"
+#include "nthw_fpga_reg_defs_rst9569.h"
 #include "nthw_fpga_reg_defs_rst9574.h"
 #include "nthw_fpga_reg_defs_sdc.h"
 #include "nthw_fpga_reg_defs_tsm.h"
diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rst9569.h b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rst9569.h
new file mode 100644
index 0000000000..27e52b0b85
--- /dev/null
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_reg_defs_rst9569.h
@@ -0,0 +1,35 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2025 Napatech A/S
+ */
+
+/*
+ * nthw_fpga_reg_defs_rst9569.h
+ *
+ * Auto-generated file - do *NOT* edit
+ *
+ */
+
+#ifndef _NTHW_FPGA_REG_DEFS_RST9569_
+#define _NTHW_FPGA_REG_DEFS_RST9569_
+
+/* RST9569 */
+#define NTHW_MOD_RST9569 (0xd8888403UL)
+#define RST9569_LATCH (0x93ac825dUL)
+#define RST9569_LATCH_DDR4_CALIB_COMPLETE (0xf7a3f47eUL)
+#define RST9569_LATCH_PHY_FTILE_RDY (0xf189f59cUL)
+#define RST9569_LATCH_PHY_FTILE_RST_DONE (0x237710edUL)
+#define RST9569_RST (0x7cda32a2UL)
+#define RST9569_RST_DDR4 (0x215e3dadUL)
+#define RST9569_RST_PHY_FTILE (0xd633010bUL)
+#define RST9569_RST_SYS (0x74a18159UL)
+#define RST9569_STAT (0xce6f562UL)
+#define RST9569_STAT_DDR4_CALIB_COMPLETE (0x80a181a3UL)
+#define RST9569_STAT_PHY_FTILE_RDY (0x5bf72501UL)
+#define RST9569_STAT_PHY_FTILE_RST_DONE (0x26325becUL)
+
+#endif  /* _NTHW_FPGA_REG_DEFS_RST9569_ */
+
+/*
+ * Auto-generated file - do *NOT* edit
+ */
diff --git a/drivers/net/ntnic/ntnic_mod_reg.h b/drivers/net/ntnic/ntnic_mod_reg.h
index 62f69d239d..a4ea4f8f76 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.h
+++ b/drivers/net/ntnic/ntnic_mod_reg.h
@@ -271,7 +271,8 @@ struct rst9574_ops {
 
 struct rst9569_ops {
 	int (*nthw_fpga_rst9569_init)(void);
-	int (*nthw_fpga_rst9569_setup)(void);
+	int (*nthw_fpga_rst9569_setup)(nthw_fpga_t *p_fpga,
+		struct nthw_fpga_rst_nt400dxx *const p);
 };
 
 void nthw_reg_rst9569_ops(struct rst9569_ops *ops);
-- 
2.45.0

