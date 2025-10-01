Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E6EECAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 15:11:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7B3C40E1E;
	Wed,  1 Oct 2025 17:10:32 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 9146440E1B
 for <dev@dpdk.org>; Wed,  1 Oct 2025 17:10:30 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11023115.outbound.protection.outlook.com [52.101.72.115])
 by mx-outbound40-101.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 01 Oct 2025 15:10:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E0yss6zheSxD2YSKdnzUEvv9b2jf2JW4a+oY2DXq91T+MIUVBAkgPxGesjxRFGCPwhI9ACYUgj7nmLM6Jr9NukGPJTzTX89KFJ4T1m/FjQOrjKTI6Md4EEiow5ZMTFKQ/Oig2flLXvd/USvsmCQQ01qFCZ2qffunwNFPisVCUGco8XGk+u/6MUSXSaUoqzZbMlPR4qymzw5QiCR7whAp3dKixc/DZhIwSssYmnPteloickqyqoqGTIS+zx93Ei1uJtYIGzgDt34MLWuBpq5ZeVtZrIt6IwKbYLI/EY/+5HdA4uYMtQ810/j3RjCrzctWzprQ8v2rNW/1wlKDR00wBQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SPUgpG1AIJLMHXU8KQLhh+71EG9EpwJsYAeq4+9AGw0=;
 b=G6tyGFxIyZXR5X2kDwCktgXXMThy4qTOlPhXeGC9TQLl++6nSDa0/3V4ax5o6jCQm36vChI7jVLMQ6k8r57xaDg5DqBxnUpPSUEgn+bxvpJXLRrjUpfmsICJP1TReLjgZakx08SM38Lwl6Lmvyf1dW3QWoOzG2vkMDoColuI1q2gjiTjBXg4LeL0WO1EmCjOLizWqnDiyEuTMGjVcHVncSILonO9oy3qmu7Z/GRGMY630qR9ZKgyZgm2SWtYcuQ8ri0wL++85tWBVdqhsJELt3iBX/vzeXjJd2y06q8b13FeiwotxNv2El4zxpunQmQHUPjax3AB3zo3Yn85aIz/3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SPUgpG1AIJLMHXU8KQLhh+71EG9EpwJsYAeq4+9AGw0=;
 b=AR7MkVn9p4Z5WuFErqAcaxYBCE8xpj5nh7y17KhhyZI/JaRnp3JB0GdAP6+LGAhfAkS7eZuDwaQyqrVPAGM9uk7Wg5EPMYkLuhIxn5WMO5ismiM3QcVEHJCJEXB2QFY6MHOe/DOCH7W1CrPfIbMslyFoXpx/Ve+wTco6/y+B6qw=
Received: from DB9PR02CA0014.eurprd02.prod.outlook.com (2603:10a6:10:1d9::19)
 by AM0P190MB0610.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:197::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.16; Wed, 1 Oct
 2025 15:10:28 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::39) by DB9PR02CA0014.outlook.office365.com
 (2603:10a6:10:1d9::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Wed,
 1 Oct 2025 15:10:28 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D02.mail.protection.outlook.com (10.167.242.186) with Microsoft
 SMTP Server id 15.20.9182.15 via Frontend Transport; Wed, 1 Oct 2025 15:10:28
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 07/20] net/ntnic: add reset init stage 5 for NT400D11
Date: Wed,  1 Oct 2025 17:09:49 +0200
Message-ID: <20251001151018.250671-8-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251001151018.250671-1-sil-plv@napatech.com>
References: <20251001151018.250671-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D02:EE_|AM0P190MB0610:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: b691c550-a9e9-4ec6-3b82-08de00fca7f9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uO9AWI4n7PsiwCCprpU1DKAAYfHxmRWaamDpsjSjcyj1lJIGJtf9Y+ff0yvA?=
 =?us-ascii?Q?Kj7xLQONErVEqSZF05wsqjACoZRkm25uFTNnhcNCpzA5xxsk3Ih7vY5o4ywr?=
 =?us-ascii?Q?7E7dF83jzyiUybXyrLB86vB8xJUBSi3NqJUY4ruFI5l5nfWD7XVBIql6K01N?=
 =?us-ascii?Q?q1QmtxkhIRMNIDVo0b4GdOFg8Lh3oSKSWk8vgpFv2k27x/qVgzHOpFbv/MZB?=
 =?us-ascii?Q?2YxhnBc2Pt2UfNC4L+T5dGwHs9KyUAtgqq8zAuRO+6PpFhemF8KbmzDN7kWO?=
 =?us-ascii?Q?8+TI1Vfuwzyf4BupuSh0aG4l0l8GcaMPjsNQnRNSKhYHMO/bwCVCwicPmGyX?=
 =?us-ascii?Q?kIMiwcQsxUy+Ff8LysFdbSjVMdEcP5zIFgx82MINGoBw7zlsPUBT6jPyFJx1?=
 =?us-ascii?Q?r5mR1iWxGxxWO4zWrWgKPgpkIQQ7KXuY7yzrNcz/oBJwmITQc811ifunBfmU?=
 =?us-ascii?Q?IGASFWQ+d+E67S0RBt5SsdJ0csYcBm8TK0JCKRSqZwfZABa7uAT+8Z265MEG?=
 =?us-ascii?Q?dFG+f2p9F3B0FMgZcp3Arys9ZrTdXHbDLDWEpPREYpYY4b9NaSnJGj2ozznd?=
 =?us-ascii?Q?7t8Mi39JPBW0GweP58PxdWfVaWuWmLSdrgA0nwEiH/iLJYzNMJE/hGzWQ0LO?=
 =?us-ascii?Q?I12jk90Vuuj8u34GxtIf3PrRQaaUXLwScS7hkr3ch80IsZZ/5bHA3B8N7xTQ?=
 =?us-ascii?Q?MHJLKvpeJRx+hhqqC9CQHP+Im5PNAPVRL7b/GrnPLdTgk2gMINCz8CNiTu66?=
 =?us-ascii?Q?WjUUNlVg/LdPurzKWEzeR1SzS0P/n6kW1r7pj+JtbZldohddWmYnimbNYHbD?=
 =?us-ascii?Q?wwN0HfLxaNj5sOz+goHq8NZ6dsH4/6+ziEGi1EqmCveamkNpL4/DQsEksZKU?=
 =?us-ascii?Q?E189pYp49ru6/Mk1XZaNQp2yDC1TCzU43bb68TaVRzRgnx6MIPfOfzEXExWv?=
 =?us-ascii?Q?SVWdzr9XeQWliDZwoFbtklykzS16gJ8NV0SdPsN++VD2OppD/4IjM2AGMznx?=
 =?us-ascii?Q?QBrsWQbTsL8EaG/7dOTVbsXodKucDfvbVYi1CFnOsTCSjUhO7AjYDlYthKjw?=
 =?us-ascii?Q?UPxZb1peAkrtrIHDtQZTU2Ru+72HNONXkYg3Fb4lSrm/bkZETnoJGVQYYP4L?=
 =?us-ascii?Q?zc/Bkxrm0EGmAW4XgzrC8cuaNe+bvXZlKEs6sdF8DzAfv0eoq78hgbdRkb6B?=
 =?us-ascii?Q?FgPm1aRHaNL24bqWdb93qndOFX7W4n2Gf2c17p/zLJy7rndcUe9KFaHoJqkn?=
 =?us-ascii?Q?4HvC4EfQ9Sw+YWo0M6gEWrPg5SWhSswdcSB/V9q5614O9jZF8C5wUKUrqAv1?=
 =?us-ascii?Q?HSS9kS235SYeibPge4tr/ncptXic3dBJgkTlOYXWcCOCRgU0t8d2ga9OhSSJ?=
 =?us-ascii?Q?JmcYDZnIvHbot8oZMv6qhwh8IQpwS1CgfAGGrtA92bJOqXNjfNIA/Nzek0EM?=
 =?us-ascii?Q?/XT7fP49lOFad1a2B4hIbXvVtAxvDuW53VYyQfOclRmhpjnMMeWe90YRYIke?=
 =?us-ascii?Q?9Pxn5cbamHr3rU26Pru4I+QFgePBkGKb3JjB9plFuhKrS4QI4Xzo08Rr2OHp?=
 =?us-ascii?Q?u/n680P1Q7Mc9LzBxtA=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(36860700013)(376014)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: BJCKS7bg6GDL/lrBzFWoaNuAlCqxUKW9cFqyGcTAEM8jZQYFmwT9+LgS2QVlmJNpfqKxlZu5WGsn+eUcwpSoANhaXOYlUUsEYB+mv8QxF87VkOEH/VJhCYrROFY7914xempHMUv3l5v5PwLjvu6DGIjfpCodWAxVU0LYrIjAaU+Yxpnt2+5niWWyVLydRjPon25u+E85TIfcaJkqBnCER4OArZoNxSaamCtKbUUk5Pm1Ed6zIUgZCQ+hkGkB3llXN0muf1d43ynuE+lx5XaHWT8ec+w0nl1dMavm1InmnCtd8Y87/j3lN/bDLHkuX0PS6UIgVynOgU0K7/QOpXXa09f1InVByb0MFIqL7zrYvjHbNtd+jsGhiV3atRTcyuO57ov5AZtdu/r3lVOqlcgxCQyCWOnp/lGRHlZdL1eu1oX7vB1i2sJObdgv0EcNBXQXZpirfAM4UhLINBkeq7iGWoXlGiBTvdrBeY/m7U0QIPWsthfyq2ZJVkpFX5ayHxuXnrIhG63LJL059aK5fouj+6zN2ilKNUmFIVTcQ929ZVuIhhTv/gTinZFqLGIF29zP9I6+3pgiL+p+ygWdiHgVEuTwHt2UXWI+JwAFpEtS+M9Hfh/b1EdkdgMC35tzQ8tSz85VueB6GM1NgGOKiXFjkA==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:10:28.0723 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b691c550-a9e9-4ec6-3b82-08de00fca7f9
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P190MB0610
X-BESS-ID: 1759331429-310341-7706-4264-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 52.101.72.115
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsbGRsZAVgZQMNU00cQgNdnEKD
 E52SQ1zTDN2MjUyNgk2TjR2MLYKMVCqTYWAIB5tq9BAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267892 [from 
 cloudscan18-113.eu-central-1b.ess.aws.cudaops.com]
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

add PHY_FTILE reset.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../core/nt400dxx/reset/nthw_fpga_rst9569.c   | 62 ++++++++++++++++++-
 1 file changed, 60 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
index e416e739da..d8c1dc4529 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
@@ -79,11 +79,26 @@ static void nthw_fpga_rst9569_ddr4_rst(struct nthw_fpga_rst_nt400dxx *const p, u
 	nthw_field_set_val_flush32(p->p_fld_rst_ddr4, val);
 }
 
+static bool nthw_fpga_rst9569_get_phy_ftile_rst(struct nthw_fpga_rst_nt400dxx *const p)
+{
+	return nthw_field_get_updated(p->p_fld_rst_phy_ftile) != 0;
+}
+
 static bool nthw_fpga_rst9569_get_ddr4_calib_complete_stat(struct nthw_fpga_rst_nt400dxx *const p)
 {
 	return nthw_field_get_updated(p->p_fld_stat_ddr4_calib_complete) != 0;
 }
 
+static bool nthw_fpga_rst9569_get_phy_ftile_rst_done_stat(struct nthw_fpga_rst_nt400dxx *const p)
+{
+	return nthw_field_get_updated(p->p_fld_stat_phy_ftile_rst_done) != 0;
+}
+
+static bool nthw_fpga_rst9569_get_ddr4_calib_complete_latch(struct nthw_fpga_rst_nt400dxx *const p)
+{
+	return nthw_field_get_updated(p->p_fld_latch_ddr4_calib_complete) != 0;
+}
+
 static void nthw_fpga_rst9569_set_ddr4_calib_complete_latch(struct nthw_fpga_rst_nt400dxx *const p,
 	uint32_t val)
 {
@@ -134,9 +149,33 @@ static int nthw_fpga_rst9569_wait_ddr4_calibration_complete(struct fpga_info_s *
 	return 0;
 }
 
-static bool nthw_fpga_rst9569_get_ddr4_calib_complete_latch(struct nthw_fpga_rst_nt400dxx *const p)
+static int nthw_fpga_rst9569_wait_phy_ftile_rst_done(struct fpga_info_s *p_fpga_info,
+	struct nthw_fpga_rst_nt400dxx *p_rst)
 {
-	return nthw_field_get_updated(p->p_fld_latch_ddr4_calib_complete) != 0;
+	const char *const p_adapter_id_str = p_fpga_info->mp_adapter_id_str;
+	uint32_t complete;
+	uint32_t timeout;
+
+	/* 5: wait until PHY_FTILE reset done */
+	NT_LOG(DBG, NTHW, "%s: %s: PHY FTILE RESET done", p_adapter_id_str, __func__);
+	timeout = 50000;/* initial timeout must be set to 5 sec. */
+
+	do {
+		complete = nthw_fpga_rst9569_get_phy_ftile_rst_done_stat(p_rst);
+
+		if (!complete)
+			nthw_os_wait_usec(100);
+
+		timeout--;
+
+		if (timeout == 0) {
+			NT_LOG(ERR, NTHW, "%s: %s: Timeout waiting for PHY FTILE RESET to be done",
+				p_adapter_id_str, __func__);
+			return -1;
+		}
+	} while (!complete);
+
+	return 0;
 }
 
 static int nthw_fpga_rst9569_product_reset(struct fpga_info_s *p_fpga_info,
@@ -187,6 +226,25 @@ static int nthw_fpga_rst9569_product_reset(struct fpga_info_s *p_fpga_info,
 			p_adapter_id_str, __func__);
 	}
 
+	bool success = true;
+
+	do {
+		/* Only wait for ftile rst done if ftile is indeed in reset. */
+		if (nthw_fpga_rst9569_get_phy_ftile_rst(p_rst)) {
+			/* (5) Wait until PHY_FTILE reset done */
+			NT_LOG_DBGX(DBG, NTHW, "%s: Wait until PHY_FTILE reset done",
+				p_adapter_id_str);
+			res = nthw_fpga_rst9569_wait_phy_ftile_rst_done(p_fpga_info, p_rst);
+
+			if (res) {
+				NT_LOG(ERR, NTHW, "%s: PHY_FTILE reset done failed",
+					p_adapter_id_str);
+				return res;
+			}
+		}
+
+	} while (!success);
+
 
 	return 0;
 }
-- 
2.45.0

