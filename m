Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20CD6CCA472
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 15:10:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C20CC40E0C;
	Wed,  1 Oct 2025 17:10:28 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 26CDF40A87
 for <dev@dpdk.org>; Wed,  1 Oct 2025 17:10:27 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11023119.outbound.protection.outlook.com [52.101.72.119])
 by mx-outbound40-101.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 01 Oct 2025 15:10:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nbmPuQ685J3f0eO1OhaDc/aFqnX3J7BbHNozuT+SvkwSP1J0i92XfXSrYwWb9soyoYOrLbRR7CdUkE6JGyX0DMyAczQ3HYA15nRmTrCrxxALvEczNIcrIDyxYwyvl2Y3vHflC8sa/5onquWpj+r9DGiPnj0FDATgqlYLSa4xxR9e/3MEL5RHHidOlx2tMAgqPw/I35wWpdcD026xqqG8QILV/iwxtCJIxSQp57HxFM96eqEyDppiA0Xeby+JE5Ho6HowFgx5BlLEtxCWOQcjuhi7WNXAXFrHIhpyzBl1UeNUSNkaoawaO7GiHId7/31Kc4uvunIzsBPlw5KdisE3pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jehF2W3peIwFRqCuwS4PEVKPoAo7U6Ib2p8d42vYKBQ=;
 b=M+1K6SH7NpLaCUrF2RNkJhemHr/Ok6Nz/yel4qKEymAyDJmxGkaEMug2VFql5tAIUPK+jS7KDGFHXsx/uvCej+mY0hUKUV8rK2iHoA4lZGNtLVcSpeusfpS6fKNEQiRRAMo6gAjj3NOZk/WDqWpTT9NbmKGfpVzwoacYicPczKweloAeOTMbM0ybL5ct+EyDPn41V4l+9OdvUsTm3ptHVMXzHXSA5LnUOj/1LruAsvrPKW0ztZ/0Pu5JEE4OXESl7BTGKVRPwfcE1aD6gaJ9nNna0euLKOQqAb37FR5wp7fQWFD5KdnbRULcgQtCnha8IBj90RIgnIvuBSQd9UWclQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jehF2W3peIwFRqCuwS4PEVKPoAo7U6Ib2p8d42vYKBQ=;
 b=n5LbpCJkaS5oMZCLM1ZhmYPPeFxjZVVikME0F6FYxdEMYynJ630bAXrG3riIXtwQ8PFlExHXfljDWnpDUZ8CsvRS8O8gnspbeHO7SVgX+A/hS7cmjooz/DsEgeO8cA6C2Mrhd2TJlVKBcydTKxG4mIhPgTOicnkYcitrQ/6+/aw=
Received: from DB9PR02CA0011.eurprd02.prod.outlook.com (2603:10a6:10:1d9::16)
 by AS4P190MB1949.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:514::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.17; Wed, 1 Oct
 2025 15:10:23 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::44) by DB9PR02CA0011.outlook.office365.com
 (2603:10a6:10:1d9::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Wed,
 1 Oct 2025 15:10:23 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server id 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 15:10:23
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 02/20] net/ntnic: add reset setup for NT400D11
Date: Wed,  1 Oct 2025 17:09:44 +0200
Message-ID: <20251001151018.250671-3-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251001151018.250671-1-sil-plv@napatech.com>
References: <20251001151018.250671-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D02:EE_|AS4P190MB1949:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 79c5f585-35f6-44e9-c341-08de00fca532
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?JyKw6h5uXL10XLV3D8vXJ2nk9Vs7gdZFMuzxvdRNJv3XLJNn2mSPjmpCPPl+?=
 =?us-ascii?Q?UIVXYWBW6JfxJl+TZOOL7euRNsM8gsv5KBNi5lYL+yWRAewq73sRnre0iz/S?=
 =?us-ascii?Q?ZBuCNPFCnqifD879p5a3DuxHeLJgUXYlaFlELpLr5Q9kFm0pJ6H1kpUKYLT+?=
 =?us-ascii?Q?42kMxIvox4AxrByp6sPtBeNzs9ggPGM6b43l2DuZb9nfxaE0GsK2N0AeiHCq?=
 =?us-ascii?Q?7qddY1C39jV0hOCfwaIZsGTeAe9NjNcAuvZkQaJUHxDZoAjul8fGtTqbdQGF?=
 =?us-ascii?Q?2OKttnlCilphU18C28qAflHg5VVLXCPp0VMktUZajyrXBldgKmiO1zZ8Kyjj?=
 =?us-ascii?Q?C6mjIYcB2d9ETR+DYB8SqKdBIlCFNoQDE/ycM2xBS2aJNiafIhjaacdUBzEY?=
 =?us-ascii?Q?sglyDDppa2Cs/PuzECwQ4yzKr9TUb548GdVH/eqW41sPP9IGre/8W2SHS/vU?=
 =?us-ascii?Q?LPiGcQA1DtfJJvwy+xI92TUmirVHJXx820McBLl8IwSyx6PCv99G38KkX6du?=
 =?us-ascii?Q?rfkA85e35dzJzrmD8Gbp54wDNfPoe6ExrMFR9D6lL03Zv7ghax92Dn1xpLy5?=
 =?us-ascii?Q?sJQmR88I/VroA2p7qab+i+C002tNhugvIHNh8fidcAP/zgudQjXpGQbrPEd/?=
 =?us-ascii?Q?ClDdCsaEwdaehgje5zgn5jXzYpHGAEoornZxrghYOkqmPKLcLXk9ErvbcuSU?=
 =?us-ascii?Q?+ZZ1i19hxvphqC8NkXGsTJiyW5cnr60gF7kpv7O6shRGPD6DcsLasCEtiWiI?=
 =?us-ascii?Q?ewMQp1bCGHGuaqw9YJBLmLc8HR8vJppoVrXakbz9UghgSaUZDo3IVAxiCszH?=
 =?us-ascii?Q?GMHUB/0bCFUPyCO3JsliDvUHhOFVC69YLvD2nsbdO5l52bVrqh2dGoJsj9UM?=
 =?us-ascii?Q?jmwFUN6G6WhgL0rEGVB/xK5uBujfNao5rqZb1kndbA89VPYbddxSJKKcmhZh?=
 =?us-ascii?Q?UHTP7og/37rcuhxyn1JT68YsYGizY+6IPKkbA7yfZZrsJGOyNEewZfxuMpXn?=
 =?us-ascii?Q?InPCaNo9f4UMc0j+ZG7zzG8va/WytgWSvspFQbiB4YCI2+8QLeOz5dVrHmhp?=
 =?us-ascii?Q?Omkj6SKcVWRmwYXL3afKujUBXeGS7r4KiyQc72RwVaN355qbW7ZI3CC13x/F?=
 =?us-ascii?Q?R/XG/4TUqI3NHTW3a8ILcY35p6fP4mY/aQznFhwcHg7cqjGUQJtFLDw4rPFK?=
 =?us-ascii?Q?v7LwTT+kFNQndxr0wED0xmdfZmiG9WKPBZj9D06AWzXQZnz97crqy78BIRhi?=
 =?us-ascii?Q?NmqFQ2GRLN47vLYT5LnKW9kF90xzdlCewsV7lMg92sS/QstucMSIvbmPcETq?=
 =?us-ascii?Q?vCTXgQsDm+cVWO2PnsTqEseHpVpzNXB9fdWZ+ofrasSq48tYXzR3c8JJNJmS?=
 =?us-ascii?Q?7WDJ7gEhSY/FWh3kFswfo7XkEJlWPbc0qPgdfugApJsSSZxLM45ojIjhPKSm?=
 =?us-ascii?Q?e8Ra0A3uSuV2IUIScs0oWmkKLqXOw8SrEdUVsw4DLWn909yp2cJOER3IiW1L?=
 =?us-ascii?Q?9vudy1Josb5tGdgCZH5FpP1BsDJ/8ldodQQE+6jjxJlZxaaNFkhqMrk+AROd?=
 =?us-ascii?Q?egGc3XJobltrVCeHtds=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: o5nUVImZjqVpCIreLtO3LNPHAsRzGxoakCu8ZEZQfpidIav6trMYWPjl4CrQhHl1Ou08qHjARc43QUO1fvsgSHqx4FbKicHvAFZThWLWDsjcRRlfk13j+SCX8RcztJwH26j2emfzHe9FMLldZDTTRPrex1iflxaY3pUcH/DgplHz9wHcYLVunsF4nvYFnUvZFXFS+VG0CgnsLt6wB/wWuqYZLbCA98AJPmNGyDUNP/sNdGrR359bOSdTe1w//vjKpMJq5y1/cvvc0Km/iuXrHfsMujHgaVs9cVQjgxXNyBoRxjhg3lYwIuk+sLOSu5bQgF2A/juRaonKjuV3HoNZ8RPbhTxJxvZnwdKFE/5dKoAm5aavR+9TMDD+pWDHFiB0D/OpEK3JkiZnn7+iz6x3eQ0WS9kvHKzBNBdylfa3liZgA2USl/SCUbIWs+SINJz1wIdSdJ0bvGskhkEc+BfyX0OwKPdnA0KEtd+CEBieP929BBCowqbklqCawJfxU0Q6L6Mhs/Qk+TACKkg9zDy8POFAsJ73MrYnm67+dP7agPK1KABMlYpVhoXbAGZbskQnVdJopp2hTnZHGOw6YaeO8fpyrkgfWSvKRXjYBT8aBA+lySC4x+nFSaEJYnI5BXzfFXwFdDkgo24Ph91Wt7btmw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:10:23.4169 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 79c5f585-35f6-44e9-c341-08de00fca532
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P190MB1949
X-BESS-ID: 1759331426-310341-7709-4259-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.72.119
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVmZmJhZAVgZQMNkoMTHV2CzJwD
 LZzMIg1czcONnSwsICKJZqZmmZlKxUGwsAob2IsUEAAAA=
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267892 [from 
 cloudscan18-18.eu-central-1b.ess.aws.cudaops.com]
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

