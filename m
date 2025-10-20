Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C0FBCCD19F
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:44:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EB0F54068E;
	Mon, 20 Oct 2025 18:43:49 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 5CB3640654
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:43:44 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11023077.outbound.protection.outlook.com [40.107.159.77])
 by mx-outbound11-211.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:43:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MIw3632CNiFwhhDFgcki+U9LpnGErybOy5amog0lVDJ246TNov6LgIyhMNZlB4TlkQh55S8GjDXFFWEryQmasQJiA2Hdk03Pm4chPgq2fdth46AjGf1iReVLWINuI87riVvb/sM+5frM/+2AD5UnEOLGRbgMC6c8YTBAWq+MPQQzysS1ado7f2zV8uY6pUaIUwI+wYQGcgZH8hLkyUTN0V0KGIS1VtriYZId+7CnVJbCCquaCDrSpcwIFbUiFseuaSUnujPky8EIjDBqBXtug3WhMMjIt1FP2aIFXQYEh7rY5E5m4I60PNakrErGV7Ixb7Ux93COxuz1CChYstiS6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3f0ImIvIL1zM8ztmkKM1e5PGxMyLdf0raP9fXwPyOk=;
 b=wK6rvOaZxI2gq7dg41FDKMtN2/Dlyiwbvmcf9ZDbByAiwg6PIyLvsnZP/QnVSbNuZIDNjXefOTKDS+ho+ZizYMMh+BtjnOf6R9ZO/0jMo2tUoj6x/INgQSZ9M9ddRqItI8qYSnmXAS9V8/YYQhyPz5WS/xlsaL3waxOb6kk8eOV+d2kLiXSjriTzBp9rIf7EO3Wehzv8UAAKEi4w76SrUaq6FBVyNFHaL9b5I0/+YTdIXDrT+Z6+/wWrqVcmVw9WwCI/HNMTYAXw8G9u3bPAVcKAKoc87qXKtyYDagXPK317la/4ZXexyj4U0sLe2dB+sN5r3Jpx2OzUiLiH+hsSzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3f0ImIvIL1zM8ztmkKM1e5PGxMyLdf0raP9fXwPyOk=;
 b=fViR0qzX5wF977FHdGn8UqIRx03qW0EzX72ywX40U13d0yrza+N/79d/hi+F4/FyD6GA9FUBa//EpzHfSFrKIBKjChRG8gr6gC9DBRdjt8tCT894cbxgthNBIM7mdUly+HQGUIvc22gRZdqwUIsG8nEMSOA61ruBDX7gXeRcAcU=
Received: from DUZPR01CA0026.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:46b::20) by DB9P190MB1147.EURP190.PROD.OUTLOOK.COM
 (2603:10a6:10:1fe::15) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.11; Mon, 20 Oct
 2025 16:43:42 +0000
Received: from DU6PEPF0000B61F.eurprd02.prod.outlook.com
 (2603:10a6:10:46b:cafe::4e) by DUZPR01CA0026.outlook.office365.com
 (2603:10a6:10:46b::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.17 via Frontend Transport; Mon,
 20 Oct 2025 16:44:01 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF0000B61F.mail.protection.outlook.com (10.167.8.134) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:43:42
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 03/21] net/ntnic: add reset initi stage 0 for NT400D11
Date: Mon, 20 Oct 2025 18:43:12 +0200
Message-ID: <20251020164336.283664-4-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020164336.283664-1-sil-plv@napatech.com>
References: <20251001151018.250671-21-sil-plv@napatech.com>
 <20251020164336.283664-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000B61F:EE_|DB9P190MB1147:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 7dc244f5-7ae1-4934-4f87-08de0ff7d402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/nZssSTEXKdR5CxEoyTRNhvK6R384taI15QD3JR6idJ85YcSXN7g37xi6lhb?=
 =?us-ascii?Q?bJ4sVM/CBJpKPdZZP+lK0rKDVXDac/KtenVSXtSKgx+KBnnEv4TA/Pfa/oqg?=
 =?us-ascii?Q?LBVfqedJcaMTAJ4Gr9ojo1V7VjWabJRN7xsFTmw/IpoybcfU9oS4IlkdBduo?=
 =?us-ascii?Q?x9pxQQgDOKPsS1bqdRXE0oXc6mIe+SOTdWYgNj+DX//E9SIixlypOK7nAIgU?=
 =?us-ascii?Q?VjRzBbxN2DiDphvbUpJ00spYQC3nt1bXchNC7Hew1n5TRJbACPa3o7zXClbl?=
 =?us-ascii?Q?2J85iwedlKB9nlY6e3WYvVtiFo2TwHdhogFsjkBlRm6mvvWmGgYLdRr8DrJj?=
 =?us-ascii?Q?LRd45HdV5i5BDV43Fbp1usPlcGA7JgqK65Dyd9y/2XqpNlOVO6cxi/4wcPd6?=
 =?us-ascii?Q?vWJChgFvVQw8Ji1akSzha1M2Ml37+X1XbDG6yHT0oawBNHokFRJv/ChNHuEc?=
 =?us-ascii?Q?+HtXeHCd7IZEEfivMvkN9nGdLzT8lsIJaSvclyl6KCxE/w7LiMwxgWoDDpdD?=
 =?us-ascii?Q?3hdibRNoFXxTNM5ChAZuxgI0S3M6/jfLMa0bgfaSRCLh9ALZJ12ZHSKOGiPn?=
 =?us-ascii?Q?QQe2RqhZ1FokyblCqk9l6FiBi1HXLkf2ipE2T+Y2BzpailNtdePW2wsW1nb7?=
 =?us-ascii?Q?kXTAk8SN/O3cYgDCXC9OnCG0NHXfu0OvfmsUamKtqQ97AuJ3KAoviW+ai/7f?=
 =?us-ascii?Q?rIc4JhIQE1FkwjWgLcDfk+ibjU+iniiwgvwmxNRU1MwClulF5YQBSrATh86h?=
 =?us-ascii?Q?6O/k3uKumnOKa0Um9VbVjLb1CSc/AYMQYKCqDMX9FIS1SqJ4CsIovnymV91D?=
 =?us-ascii?Q?63L2hsTomjWZiiU0Nsn82iMGOLA8wtPjhlX/BOAIVCBT9JaZKIkTopKKjWa3?=
 =?us-ascii?Q?82hXSNFfmJYDWa70Fz7DhMHu92WrOPieWS5QM1ND9AnZcVdBuQbJv+x+Rb1n?=
 =?us-ascii?Q?K5z/FELSKlSHcriN+NzUS3N/0vlk6GU5RAqQDHmQjXE9Y4UmBLvr5sCmKt6i?=
 =?us-ascii?Q?dLolQC6AkHN0nTKNkkKVpej+tkdo7wJxsaeuN0aL9Ajo13a+zid0FdXSF2Ia?=
 =?us-ascii?Q?MkzGxw927joAmaSCsMb2W6K04KyKTgIla4/K43JCUlV08yTD4+Hs5g1O5qpS?=
 =?us-ascii?Q?+KZWvU1i+JI/di+07J7oPKGfDjob0Bbl8rQowWVc/A+GGD5k5tWzRmUIjzdm?=
 =?us-ascii?Q?FPBuPdjF2gbcfvTQiS/QihOz/WTVPBMVlujjor5jbBvyLiZpSrwqH70COzZX?=
 =?us-ascii?Q?z+s5ULkTxKJ9meR2nWyrVuYsOh3oUxZxyhuo9krsDeQcm7nFo+aooqGPvDqX?=
 =?us-ascii?Q?Y1Sv40VMML8U8vQMUyQvkrAcAQttjKGgLXeQdJSI9lLgcY7FsaP0dhnOmJhH?=
 =?us-ascii?Q?+nMd1u3B9IhG6WZu2DgT7EFHN8i52L4Pyk0v+QBwalOBZrqNFcWdUrM+Ylga?=
 =?us-ascii?Q?xXRle6YZYIjV/UU36RlBKmPONw99qbWsFXyDy8/n9sSV3eHzSXEZ68HWHdVH?=
 =?us-ascii?Q?8AxEtTaabV8nynwitnYFLGlEobY+wwSriu9NeZ98Da93ayfv9joJDKQmCZs8?=
 =?us-ascii?Q?LBAii51UTNRFHu1AKoM=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: yOOEPOyJj5Nv3+tqhwhX72Nz8VvXuS0cGkfqbowVvr6/n/b9qZ2lXNQf+qr/KertuVHk8kebpRRYAi7A7m4Sgg1haY+3D1numySKoIB8i2GytcuFtaK1/fYdBx8rAxKH2HoJzsbEMQap/8VBlwH0Cwj9B75TDB2csuYj5hY2j7VWgxWci9/T49YRHQTB4ihKAdtKKNhaH3fLQoSXQEa4KrQ3IzgUVmzr2XsHY/6ZjHLaWCBFl43EYxSEZPgzNGGgLWmaKPH4gAF7aKs1JrhAf9F/RjsEcZ5ZuFjcLAbbMpd9nzG2OC/oMaT5BEjCgeWTXC0Kiy7j8fqwkqvcFKoCLIv/kxsFmT4YS0r4tYf7z6LMgbHcp8ECaHXHJS/JfhVUH+F1Plii5C2sjXH0OH3wIxp1M1GQlenv1qinmjmy9iEq9fmBkZ/zSftbPr2YF47ZDBkSmaN0q1BQNBK7VmR3o7uu5ZRQWp7laIIbxnU/uWHXWecHsOvz1HzezqLyCFSTkAbDKyf6QuikdVl9Gu2RYoiha14ktuaGBa7AAmReq+p971kGKjZTc4fjbhF4SF6Kd4uLiOfN1kJW8WMW7tBc6Ei/Kw6iPyezF15fQr7VDMulNQrm4d+fe7sF2CJL0Xw5pK1YCPl+nGNiQEvBLrV7V9fLtZDdSJLi/ICvFgiPzCw=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:43:42.0004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dc244f5-7ae1-4934-4f87-08de0ff7d402
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000B61F.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P190MB1147
X-BESS-ID: 1760978623-303027-28482-63640-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 40.107.159.77
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsbGBuZAVgZQMNUwNS3N1MzSKN
 nEODElxdwwLSXZJMXcxDLV0MDAIjVZqTYWAMeP/e1BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan22-181.eu-central-1b.ess.aws.cudaops.com]
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

add reset all domains stage for nt400d11

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../nthw/core/nt400dxx/nthw_fpga_nt400dxx.c   |  2 +-
 .../core/nt400dxx/reset/nthw_fpga_rst9569.c   | 33 ++++++++++++++++++-
 drivers/net/ntnic/ntnic_mod_reg.h             |  3 +-
 3 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
index 8ae06417b8..47c26b092b 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
@@ -209,7 +209,7 @@ static int nthw_fpga_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 	switch (p_fpga_info->n_fpga_prod_id) {
 	case 9569:
 		if (rst9569_ops)
-			res = rst9569_ops->nthw_fpga_rst9569_init();
+			res = rst9569_ops->nthw_fpga_rst9569_init(p_fpga_info, &rst);
 
 		if (res) {
 			NT_LOG(ERR,
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
index 254703bae9..6a6660cabe 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
@@ -6,6 +6,8 @@
 #include "ntnic_mod_reg.h"
 #include "nthw_register.h"
 #include "nthw_drv.h"
+#include "nt_util.h"
+#include "ntlog.h"
 
 
 static int nthw_fpga_rst9569_setup(nthw_fpga_t *p_fpga, struct nthw_fpga_rst_nt400dxx *const p)
@@ -63,11 +65,40 @@ static int nthw_fpga_rst9569_setup(nthw_fpga_t *p_fpga, struct nthw_fpga_rst_nt4
 	return 0;
 };
 
-static int nthw_fpga_rst9569_init(void)
+static void nthw_fpga_rst9569_set_default_rst_values(struct nthw_fpga_rst_nt400dxx *const p)
 {
+	nthw_field_update_register(p->p_fld_rst_sys);
+	nthw_field_set_all(p->p_fld_rst_sys);
+	nthw_field_set_val32(p->p_fld_rst_ddr4, 1);
+	nthw_field_set_val_flush32(p->p_fld_rst_phy_ftile, 1);
+}
+
+static int nthw_fpga_rst9569_product_reset(struct fpga_info_s *p_fpga_info,
+	struct nthw_fpga_rst_nt400dxx *p_rst)
+{
+	RTE_ASSERT(p_fpga_info);
+	RTE_ASSERT(p_rst);
+
+	const char *const p_adapter_id_str = p_fpga_info->mp_adapter_id_str;
+
+	/* (0) Reset all domains / modules except peripherals: */
+	NT_LOG_DBGX(DBG, NTHW, "%s: RST defaults", p_adapter_id_str);
+	nthw_fpga_rst9569_set_default_rst_values(p_rst);
+
 	return 0;
 }
 
+static int nthw_fpga_rst9569_init(struct fpga_info_s *p_fpga_info,
+	struct nthw_fpga_rst_nt400dxx *p_rst)
+{
+	RTE_ASSERT(p_fpga_info);
+	RTE_ASSERT(p_rst);
+
+	int res = nthw_fpga_rst9569_product_reset(p_fpga_info, p_rst);
+
+	return res;
+}
+
 static struct rst9569_ops rst9569_ops = {
 	.nthw_fpga_rst9569_init = nthw_fpga_rst9569_init,
 	.nthw_fpga_rst9569_setup = nthw_fpga_rst9569_setup,
diff --git a/drivers/net/ntnic/ntnic_mod_reg.h b/drivers/net/ntnic/ntnic_mod_reg.h
index a4ea4f8f76..fa511e78cd 100644
--- a/drivers/net/ntnic/ntnic_mod_reg.h
+++ b/drivers/net/ntnic/ntnic_mod_reg.h
@@ -270,7 +270,8 @@ struct rst9574_ops {
 };
 
 struct rst9569_ops {
-	int (*nthw_fpga_rst9569_init)(void);
+	int (*nthw_fpga_rst9569_init)(struct fpga_info_s *p_fpga_info,
+		struct nthw_fpga_rst_nt400dxx *const p);
 	int (*nthw_fpga_rst9569_setup)(nthw_fpga_t *p_fpga,
 		struct nthw_fpga_rst_nt400dxx *const p);
 };
-- 
2.45.0

