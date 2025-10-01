Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37519CAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Oct 2025 15:11:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5A18840E37;
	Wed,  1 Oct 2025 17:10:35 +0200 (CEST)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id C3F7E40DFD
 for <dev@dpdk.org>; Wed,  1 Oct 2025 17:10:31 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11021139.outbound.protection.outlook.com
 [40.107.130.139]) by mx-outbound13-239.eu-central-1a.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 01 Oct 2025 15:10:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ijXzXLCuVy/8COylqxbRxU/NEuEL3slEaJ/1cNcEoBDyZoPwITXSUd3G8eplGZ5djryBfUUVRYHmKWHQblK27TLww05jCHp4cvjqMuiseDQhIyzfhS0k1ssKNYVjujhr/ELRp6t1wFT5QuSLu1ouZdj7nlUqFJUmIA0x2OpkxLV6sTq7dCKv3/sPEz3Rz6V1L0VldLVVImnBZbLAuCFGeLzAbOaC2Yc1iF0U1IAE7rW7CyewEvULD/PjK0NA1WmHZ+3zb+t7qHgG7/PXuWRZhbQ/lAdcgPCdje8gSGf6vcFoe0t+hA5cESl20vEMFCr59Kt7A9JUekcPD3tcvM4GCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xCJHWB0jxyba3MCD0AeNfx4ynSg6Uo3M8hd3lHkp/Ic=;
 b=eBIL02vYV0jbK6kBYFfEmZuUjaWCRjyovDzrTfT595FoWg6gXrA7VkqUo587Tn0MdCSaMzWhw9LoT2wEZfACfzQ+ekc3haVQpC2TXq1Sps+QZkYd1mbRfYjsGyhvtce2mvth63Y2jTZVVCLbWSdtZAny79mcnDh4xWnhv09xNS40+lV8cpmq4kRpK2S/iROpZ2e16SMgzQW+EJyCri3nSHw7q6rxnthRXCJ6LmSZEWJ3oj54W7wKEkw2OHZbLvyafo0BVbGUH9ftK9Yb8JUC0dggv56cWDfYKjt1kiYJHDeaqJJXVq2AWfGOQqs1TmO49NFo83DIZ2LkdEE501YVUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xCJHWB0jxyba3MCD0AeNfx4ynSg6Uo3M8hd3lHkp/Ic=;
 b=eYzirHlog9Em8K+evU5y7UnWpLsAyfRl7nOur2ggt0s2G6M7pGyVHOt2iAQzU7+Vi+njCjjn5dECKAMrzt9+sNmzzphXba8ntlXvGevNNV9+NM/vYghYX70ubYvX1V5pvyJkcLfU119wiSymtXA4bCo8OaESCzqyAx2qq9jHCpI=
Received: from DB9PR02CA0011.eurprd02.prod.outlook.com (2603:10a6:10:1d9::16)
 by AS8P190MB1912.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:508::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9160.18; Wed, 1 Oct
 2025 15:10:29 +0000
Received: from DU2PEPF00028D02.eurprd03.prod.outlook.com
 (2603:10a6:10:1d9:cafe::c4) by DB9PR02CA0011.outlook.office365.com
 (2603:10a6:10:1d9::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9160.17 via Frontend Transport; Wed,
 1 Oct 2025 15:10:29 +0000
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
Subject: [PATCH v1 08/20] net/ntnic: add reset init stage 6 for NT400D11
Date: Wed,  1 Oct 2025 17:09:50 +0200
Message-ID: <20251001151018.250671-9-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251001151018.250671-1-sil-plv@napatech.com>
References: <20251001151018.250671-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D02:EE_|AS8P190MB1912:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: adac2f3a-d393-4f38-c913-08de00fca871
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Q804T/s7DtJ4WMcPhVr2IibDsUctGXfwvf5OuwDvgsTgOaurBNDXuLmU+WVe?=
 =?us-ascii?Q?wAMjN9ssm1hyQu7OYkrzFxgKiOjyd8f08AG5koAZcW060MdaYCrLV7QHbLXe?=
 =?us-ascii?Q?bReiTPToV5GqSljQS+/vQe/dYe76tVojQ5K+s5LgaU/XikuIVcjTZz6zrbET?=
 =?us-ascii?Q?6NDd0xrU7l7ucYf2EGjx/uOXElCAO4KX3p4U0ILnnDJrg/BK40AzeLPpEPkY?=
 =?us-ascii?Q?b+qR5GDkJ84Cv+NXjg8+87lnyw43qbxSyoNbWpdIGgfKR2UkGPPSDkfykAaM?=
 =?us-ascii?Q?VcWJz7Aq2sLPghSHpCMlnzzTb3m6pKmjhZfgzzTpvXpOj8biXtD6rbEG3W1b?=
 =?us-ascii?Q?lpqwmSjumZkoA+f/NNK2VECtsEua0T/gDji1sDTyE41WYj8H7YAHi5UT+QXy?=
 =?us-ascii?Q?eGqsPRtbQ+u/9L7xWngaNj1l0U4aYSheZx0onaoZKdPQJSpMzhF1sext6QPW?=
 =?us-ascii?Q?rDyinKuhGv1GDhArPzEHTsnpYWgPWNllTyk05tcWFCuEnZg94e9NnBp+Xvmq?=
 =?us-ascii?Q?1SnJzDeVnneTiKh3AJH/aMFr7zdDmELkUeIiiOR3nQxeHYiMXPdlfwvl9bCD?=
 =?us-ascii?Q?p+1gbQOivPRWeAZ3rPyIpW1UTrOeu9jg12TBwCxPisk95l81JDVA+6gOQR6Z?=
 =?us-ascii?Q?QIVwmt174azamq1QX3G+x5YGPQqCM9wDrbQVJwufam3P3Xrq8120ddoABNBv?=
 =?us-ascii?Q?KUSAK/aw9NUv22O8ax4hYozdJqE2salLrsUG7hDjk1puODNNYotJP7XKvVfs?=
 =?us-ascii?Q?kI0xvcSjOohd5fmDiOGt2WVrwJ8g5ipzNnUpAAGebgldLyoKt0t+W8UkkTuA?=
 =?us-ascii?Q?1NNRWtmhiyAn1OnggyZcZXR5INKb3so6VBy/fg+BOHNxR2vYUUcmaDm5Sew2?=
 =?us-ascii?Q?tr8ARpOREEx/1Vv6DOmQQ4zudZmSXM0A9cfQI55qN9AeMg2X7ytAmha2fZwV?=
 =?us-ascii?Q?7CY4pRziqJXCwkfyM/uncAnJ0LgFyh/bnd3NVxA7nITjh3RsCaKVusqI/py2?=
 =?us-ascii?Q?zImXsQ9mqLcxtxu5E2KeC1MAb00egCOs7x46d9LfFY7Ft2E3/20eHaNGWr+E?=
 =?us-ascii?Q?uOq6W8Fcp54a7xZzCYiQI3qkvHBGlUYPsmlLkFz738eCUd6pMyxCYXfvTwi2?=
 =?us-ascii?Q?y0bOLTkWUgvEUfSg5XdoPGWJ1GxQhjWdQ1lMIxyIvg1Zbg6FF/NotAcQlKo8?=
 =?us-ascii?Q?T2QxcyBmEYFPGwzpe8awL+kpdcDrLbJVbpq3b8W05mzL3nPhn1gjNG3Sogki?=
 =?us-ascii?Q?LAmVWFX88vqB5cx1ixoBUXoWPtzV1ZVevryZ8krvNIVbABQL19OXUFFjAQs+?=
 =?us-ascii?Q?P+vo/RyITM0Xk3majH3jRS0Nx/SYmrl32qRiQFZMx59fCOxeEiof2KNAGO1m?=
 =?us-ascii?Q?4CKECja6ccVGF3kEehkyKJ1yyVOvji2gkZpZr5nYtlyY/w4jftlxQKLO1Ex2?=
 =?us-ascii?Q?vmfAXe/vj0+7qaZN5afWHg+dD/NaZGKAQlec91DapgyCVqqTKPRf5f6ruBCg?=
 =?us-ascii?Q?ScWBdXJWF8sKLeBJjfJR6YRJ78Jl5h+A8pwo2HAxfH9nKBCRjngkIsigFrQv?=
 =?us-ascii?Q?GVIPZrDqmu99un4zmMY=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(82310400026)(376014)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: SNKdPeOQUIhx3tKvRjjp2pTp6LC+i7sZGKxH/coz9XqTDKsOk07XhX8n3i/6S/E7rWosvoq6aN6eYtblvquqcUugVct0KftJxMRmH4X/t5JZuivibkZbLtdsFMJ0d9P20P8/H+ZZ6SvR82KwtRNUMSPu450uo5/A92V40ZcM3hNexbRAN2cvkVHb6ncsTRYEYRrpDstey2BSJvZx/kdfVmmOWfzr6VBdO4z7ZBBEBN6KdGFZ8q0covHsy5E/BxMc/kElD+1nH2A9hhLT9u/Hbnex4HgeqJsgl/8kG69cfZCi87DH2eply7aoeUt56TDeTCGhfuMBdTDrEAjg2/um1PmRQ9GgdwCzCfScC9LOuGEwVqF2Nh//mitHwoyOeOrGgeynRhn3wBMsLPkW9qJ2Zfk/YOVQjm0+t44yt+L9ECDuAMUgX1V/mDqBg//IPyvK4dK64CWXYB7pNduNoRZKY7Jx7p2JBuw2QV6U1GaXWexgZJZFb2vZomH6DP/nRIRdmUqIoQZ6o6tuGWog1oWXB7gMZEfKNzFR5cKd10r6JHZoC7bGZWkkyBqkdpKA4XvYJBFb2W8sxuf6OQYyzmrKzUmG15UYNqSH3rHRpwzTC/LqWyVCTSxl8PXyaMopgVL/ta7D5iuv52sU0OLa+T33Lw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2025 15:10:28.8617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: adac2f3a-d393-4f38-c913-08de00fca871
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D02.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1912
X-BESS-ID: 1759331431-303567-7604-4429-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 40.107.130.139
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYmBmZAVgZQ0DjZwtTCwMAwxd
 IkyTLZLNXS2DzNMNUy1cI4zdAk2dhEqTYWAJCq4HtBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267892 [from 
 cloudscan11-175.eu-central-1a.ess.aws.cudaops.com]
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

add De-assert PHY_FTILE reset.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c    | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
index d8c1dc4529..5ddf0a093e 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9569.c
@@ -79,6 +79,12 @@ static void nthw_fpga_rst9569_ddr4_rst(struct nthw_fpga_rst_nt400dxx *const p, u
 	nthw_field_set_val_flush32(p->p_fld_rst_ddr4, val);
 }
 
+static void nthw_fpga_rst9569_phy_ftile_rst(struct nthw_fpga_rst_nt400dxx *const p, uint32_t val)
+{
+	nthw_field_update_register(p->p_fld_rst_phy_ftile);
+	nthw_field_set_val_flush32(p->p_fld_rst_phy_ftile, val);
+}
+
 static bool nthw_fpga_rst9569_get_phy_ftile_rst(struct nthw_fpga_rst_nt400dxx *const p)
 {
 	return nthw_field_get_updated(p->p_fld_rst_phy_ftile) != 0;
@@ -243,6 +249,13 @@ static int nthw_fpga_rst9569_product_reset(struct fpga_info_s *p_fpga_info,
 			}
 		}
 
+		/* (6) De-assert PHY_FTILE reset: */
+		NT_LOG(DBG, NTHW, "%s: %s: De-asserting PHY_FTILE reset", p_adapter_id_str,
+			__func__);
+		nthw_fpga_rst9569_phy_ftile_rst(p_rst, 0);
+
+		nthw_os_wait_usec(10000);
+
 	} while (!success);
 
 
-- 
2.45.0

