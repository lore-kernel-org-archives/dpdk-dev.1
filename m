Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93BFBCAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 15:11:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E92F340E24;
	Wed,  1 Oct 2025 17:10:31 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 2B3B940B8D
 for <dev@dpdk.org>; Wed,  1 Oct 2025 17:10:28 +0200 (CEST)
Received: from PA4PR04CU001.outbound.protection.outlook.com
 (mail-francecentralazon11023103.outbound.protection.outlook.com
 [40.107.162.103]) by mx-outbound13-239.eu-central-1a.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 01 Oct 2025 15:10:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLdpk6u9vcvU6YqYVIvlWv/hRA1OlArUZAUTNAYAPsnXSBoV9QO/LyLy9baGxeyD2prTdOVXsPGLAg7KUth5FrJBLQpykDxarCuo7HSQ/f091cXGu3SXywhq8IbKDy8ccrIhAMJMgmJZYjH5WXv1G48p2CPKLUHr6Ue84TOiDI0iEjZHtYCiCScsuzMoNydBR+29JavacUlAftzyMV7S2+wn62+0jaStB4EBGDCmJOXhZ2jxMqSWX1nB0R2A+7IKESbgJvnWVYBFRMMhAMGmkjrt838HiCjkaocbvNTRj4w41BHR+5iKuSWDzm4+lyuqH7drggwc70Y/ijhMAK0a7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D3f0ImIvIL1zM8ztmkKM1e5PGxMyLdf0raP9fXwPyOk=;
 b=BoeP9LAYGhC2G7wODtmjKwx/z8MHx1t2n01xAl7jcUslzssMCcekyo0eXczzKbgQlYPzMTicJY2auaS02Bp2ugRG/LYfmpnkAPP5q+ij/GRT3G6+bMJOY0s2agkh3ZBZhVvNes+jzhbfcfzvmv7fQPA8MX8GPRAxbJ8P1HLaWY9bdA7sFXqm6f1PaSDCR8f/mqPrvxVeBgIuIyDCAXzFGz/sX0g3JjpQI/V5nUO2a/LFIcEUo8FLCntfP3SFatGZn0LnwCG5RV7NOaO/65YAUbl0hxKBX8udRa3/pg68ZPgqahQi7b5HZyWbvXoDoevs6mnetvaeJMUhgnKzFx1knA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D3f0ImIvIL1zM8ztmkKM1e5PGxMyLdf0raP9fXwPyOk=;
 b=UaEE/LtopVkXl1/MXfqGW0nIw/GN12+VuO7hDCAfsn/yyBGy70v8LhgdrbjrxYZHCR+rjFnjIosrLPEv595UMkyeC1KSD24nhypnyffL8gwIWAYvM2DVkKi0H+EvZVd4fMUN4vg/hPEMmeU2z++lSeo9UuDeFmBMBtOEbchyeFA=
Received: from DB9PR02CA0010.eurprd02.prod.outlook.com (2603:10a6:10:1d9::15)
 by VI1P190MB0653.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:11d::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Wed, 1 Oct
 2025 15:10:24 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::b3) by DB9PR02CA0010.outlook.office365.com
 (2603:10a6:10:1d9::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Wed,
 1 Oct 2025 15:10:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server id 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 15:10:24
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 03/20] net/ntnic: add reset init stage 0 for NT400D11
Date: Wed,  1 Oct 2025 17:09:45 +0200
Message-ID: <20251001151018.250671-4-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251001151018.250671-1-sil-plv@napatech.com>
References: <20251001151018.250671-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D02:EE_|VI1P190MB0653:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: df4c3486-a0b3-47f9-6b7a-08de00fca59e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?588D9DZZVceM9wORP2V45bn4WyZ44Z8guEys5CKCTCAkqRg+vIO1NFm5b+gY?=
 =?us-ascii?Q?B2ap0BCDycJlSAN0dSizfYOhWeyCX8dTdD/r/8WVOjmasrYBAHiCs77Ojhc6?=
 =?us-ascii?Q?Wp0/GKKirSGXCkCz9nyAEs4fPPQXNJXqAPZlwBw7vHBKmSOZ4qQ24bDhQGle?=
 =?us-ascii?Q?Mpdm4ngX8BRMyBJCxVzJYAcsYsOQw1TeF3FFyglPX00qP0cAYuLhlqLYE2O/?=
 =?us-ascii?Q?IE3C1kYU+ZQ+o/3ECka/Jxg/3Ra1Os41qZu6bPuO27PmCz0FEvUhePhPd+gp?=
 =?us-ascii?Q?tU47cOsF+/afP4vJR4Ot/8WDv6EdwCy+WRtuzWDX6w+j9dborqom2B1agghH?=
 =?us-ascii?Q?fMoLElZavisv9aT/U87tkajzCGCRz7kJ7FSNct51XBdbhCMiCZF4jsJIwMQq?=
 =?us-ascii?Q?l9q7zBGlfguGXNn7S0fk4+dANDRhiaw3dbtDZDuueZjlrtir7wo2BFW8Y7HB?=
 =?us-ascii?Q?yrbX3/HDiE+AZMdTy/MG1EjwuEN40d1jjSOorjvXwR21EmlRD7wSMJK4iAqQ?=
 =?us-ascii?Q?B7e7D/Ztapotk6pr1g+0VSHfbv1eqiQChAer+pm8vKzW04xVKZIKBVguNRtl?=
 =?us-ascii?Q?8aODfMbEwDQotoeHXw+PXOSA9rKAxZjEKZz8z2O9XeebmaBBzm3NefQeQLfW?=
 =?us-ascii?Q?Y0+B/kfSo86E1BBqyHve8lW7zRmli6l36MSypAFA7ayBpAGowL9i/Rda2Fym?=
 =?us-ascii?Q?dAzs2B0gkFHxP4o4zQjOJlw1kYlEuIh+X2498HVkRP1Fdfd3PNcVyl4Sh3OJ?=
 =?us-ascii?Q?iAgA/LvtWlhQCs3cmOQp96gngSiRFJEeF01qU0638Og8h3bvehlNlfK44L3d?=
 =?us-ascii?Q?OaKU+FOF85utVaGI4xFvNbQFUfxntyNXijdHef1rHdWCylrHp3ylx81GqHLm?=
 =?us-ascii?Q?9qBCyk21GnCxjjuaG9gJkP1DbXSGk+Nu0VTBI/c3i09vui1pSPUQ5Wfv0xRR?=
 =?us-ascii?Q?tjFZ9ha9R700JOJybcboKx+doj6nmRU/9CCecy6+k3rbYpq+kDcMusdgTpmP?=
 =?us-ascii?Q?Zp5CD95SbBaYjxh3YiddXTkXSfDXgcZbxjdp+vfAdhoypwDFIa3za7wlTP6O?=
 =?us-ascii?Q?fg+Es2wTylYlUxwhPTfvVqkm/d7rkO4mj7sOoHD/pXsykt2PgGrJWYC/v6wZ?=
 =?us-ascii?Q?YmBwB4uG3zqphgUzSiObhl2uKqpYC3867tXurwGdZP798vR1OsrDpelM8VAs?=
 =?us-ascii?Q?dTo+CFL5yq91qFa2v7OVcpbSAPfSkRHwPeedCRQPGRTX5/GaaivetR4XA8+8?=
 =?us-ascii?Q?cNceCZ+tR0JKD+LyiesCnJek72xgNJ1NyY7MnVe0yBVOq3YN0D1x3jmxJ5N0?=
 =?us-ascii?Q?TZmFteWNPzBmf6sY6LTByguj9ymtEOSHTPkqKwdYcX5vwN5oQ4k2skfPObWD?=
 =?us-ascii?Q?p7Mcu5BrR5XH9XB5U6fhSqgb5FSpGU0JZ+E6hvbdrwI5U8RiJiJodOUFPcw3?=
 =?us-ascii?Q?CzQUmJg1tGmwyZzVvppAcyZVVoe+Ir+zXaD2SwWdFljTWieACme1TooGb+t2?=
 =?us-ascii?Q?mSq9NDf2DFgcMpiWdplPasEDfe3XilxZGD5ejdb10N8GcdilCaN3Avddwp/o?=
 =?us-ascii?Q?WyOxK0+1UCFK0C2EicQ=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: fZpak3jX9LIrWsGNa/cvW5kG4LgTqH/lx5PUfJGLRyXmYKEk19x5M++OCTPphV3Ei+Cz17JU8LR6zjT3SOowvSJ/qspqRUAHwNzSp/Lm0a4IuPJ9h6b/yiknC68EFQlhAkqlOHxYiAkJTuSoYrRsRknW6GnvXRsvYif0vLTEsIHiBO4alKfvCgTwUclUbOpCO/BTFdFh6lOD1OOPZDGzQhDITmlZQPfya2JI28Ripb0tdOvyxvUJk3Dy3UyI2bIpe8v5fu2J4e7GBuBqCrfQaGqiayjDwnjfTm/4/3pHp0JbgFEchztd5STOJpKr5E2miJYXnTnz1lWDHbLrL0BYBJ/gyT1erbbo9Z6nbhrct/C86bhDzYxfLuQpel0u/2YCISsnJTX/aFCcWIbOonvHuk7ZxtHaQzE+LPssnVl9xuiXBQrspKjUEASL8Ly9iyVOkBpXoWnSq0lA1eqkXmtHD1uVDouud8H9oDpno+fTR/brxicIC2nDJIwdvKER65VatZz7NwRqVzsemgcZbBPQ/3HKQSdPX2TloUt14iA4Jqyu0CEO5ToKLy/742D+vp5pmkN6yxay2BBOFUhCYtcDv+e2YTAmPHKaz5AxWWRfBcy5T9ZFtZM7PKWCKY3/1E82ETRp7TEYE3ob3s8OotcRBQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:10:24.1223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: df4c3486-a0b3-47f9-6b7a-08de00fca59e
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1P190MB0653
X-BESS-ID: 1759331427-303567-7620-4425-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 40.107.162.103
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsbGBuZAVgZQMNUwNS3N1MzSKN
 nEODElxdwwLSXZJMXcxDLV0MDAIjVZqTYWAMeP/e1BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267892 [from 
 cloudscan19-185.eu-central-1b.ess.aws.cudaops.com]
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

