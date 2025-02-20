Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34EF9C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:06:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8AB1640DF8;
	Thu, 20 Feb 2025 23:04:37 +0100 (CET)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id E8AE640A84
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:27 +0100 (CET)
Received: from EUR02-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur02lp2045.outbound.protection.outlook.com [104.47.11.45]) by
 mx-outbound46-229.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aXMVHxplbM10lyjwMj0P1EVGn38lyOSMDKj2UEbHdYHCDxKH3x6hx5miIGe+dEkNqkZS6SxVcfL98xir5u0Oxl8DGMp0rLplaWJI+0He2/N/JiP0B4kLmygHotPOmjhZUasljrQrR+p4pK/KmNj2q1KiiSRe5uyfEBLMUJ/+gvZE4ds+s+ligcLnwOaM4GT42o2O8pUqBTxZmxlmRnK0I81WBUNfwqgYUhrWTaOj862begJAP/EfYdtPShSSkLkc1fR9VLpPyvKq4yPj/drFnp3oolQriIYSULTRI8eefyST/v+IUXKaYQrJmmFbueayoVcCuZ1sEN+Do2P6Bd+g5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2XIyK2oun5lgSqJPqRsyoFHCPA9JoSIMcCEcIe8kfpE=;
 b=a+1fFpkwZ5on0FMiVKb777MOLkRHCHeck9E1KtY6eJtphGkezSzDdBRSyrSprZsE4Qy8eGlqODT386/43GZeUuxiqMzs7oDbtDh53LXRDnv2WTpspc/ue22nTvzb121lERP+KyAOzAVEC0op3EMr1/DComNu7w8i4IqXpafXeyKpu9CGwkkGwRwab6HJ5sENgaBiGhhc1KkTOEja0xvIOrMwFatHNb6DX3Y76byHIuKZwNo16rNuAmB06oke0mV/w64aMM0zp/TICdLbjtoE19hdfpHM+qk2GB4fs6gGFA7aeBX/M+XwKInh89n9BaqqprRPC17vToQRqocQbl5CEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2XIyK2oun5lgSqJPqRsyoFHCPA9JoSIMcCEcIe8kfpE=;
 b=lPxakjVmLFATF49g7N/Gpek6iLsImKKUDFFsf7ZTi07Rzr6tOEKE49bfk5jP8nyQbvuF6aCj2yVYtxNeStZH2b+U2XrGsRpaGPyC9ZteuSQcS5P8You0iVi5bnWi10bySWvMqfql8NJjHDEcxIMKMiDF7ay0UzbjwobuEyQWRWk=
Received: from CWLP265CA0506.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::19)
 by AM8P190MB0865.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:1d6::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 22:04:25 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::19) by CWLP265CA0506.outlook.office365.com
 (2603:10a6:400:18b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 22:04:25 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:25 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 17/32] net/ntnic: add default reset setting for NT400D13
Date: Thu, 20 Feb 2025 23:03:41 +0100
Message-ID: <20250220220406.3925597-18-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|AM8P190MB0865:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: e4c3b673-3960-4234-0ae1-08dd51fa89de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4VVUjcOBcdGzxHWypiGysxaTOtmfl2P3F2ceqgXqMkBMkfsWKMGhCsR1e7Wf?=
 =?us-ascii?Q?cbqKxd45FX/LC7kbKNWfZmU0LUd8sMD+MfTQucoLg2ApWNMK62i5C/bJcUJ1?=
 =?us-ascii?Q?VJPR7eB2FsxzAo17D8A/iW8+jfr05olZcxQUWDlWgnsTGP2hyGeAhG++q05N?=
 =?us-ascii?Q?vKkMr1+LgV3teQM7tsE5IwNDsfGO7jxxUoFgLqGQ9iMzqlcUS6q8K86IFnIR?=
 =?us-ascii?Q?lTnyu7r0DH/1sbYrfTUwCQmceoAvKpbWnbnylX7OeHpjJhdbBnSV6v99xmd6?=
 =?us-ascii?Q?hvLewPGPRaA21FVicYQWnViPF7TYZN6yTMwwOXGb8vBm+PGaYDimry1bs6C1?=
 =?us-ascii?Q?GZMCYFEoaJOGbl/VFToyZduj7+zsodY3cyoiPG3HmHUJms7APrrsLVSB5cAL?=
 =?us-ascii?Q?VhaMRzh0pzPpDlWJHU/TMLZLeajFJUxOBF0Wyz6erx+nY3ikSGspaPK7onzu?=
 =?us-ascii?Q?Qko40IOn3q3/UxXnom+4+YnE9i3geMTl6hIHIdtphViw72pgR/yhB+DeYzU1?=
 =?us-ascii?Q?egMKw+E+2yOSZReN7DLbhr8s0IdCjd0wqahwuyAz8Gul56w6+S/z2GVSe0p1?=
 =?us-ascii?Q?ZKEpLjVSzkpKEb4bOEavFTG+KQr36sevhFxD+qF6816dxXIWS1x0LYOxABWX?=
 =?us-ascii?Q?OMOfggUyxGe0vsN74mSDDd5qzrbadjQgLflgaCB5D6jgCsqSdeL861EnoXMT?=
 =?us-ascii?Q?ckaUqZI/NmfwTpVma1n8dks8tiofoa4/92LgRSdpblfwv9NizjO3a+10MCYE?=
 =?us-ascii?Q?5xaBYAM3ooXUdvsVEYpFQiLoFfizGyjnd4VeSaPQJHh2CiBYEhr+ne0xAP2M?=
 =?us-ascii?Q?CmivTwxKEnPvpDPBkbQcl6x400ucFKBXGMKpqNvtx80SCRsrbIT/20EJ75P8?=
 =?us-ascii?Q?S84p0ByhanI/BtGkrpgoHQPaweUv7ITsnYxrPCfa8IjSqx2GD2duLI3oF3Mg?=
 =?us-ascii?Q?JD/I2E6AwRr5Y3XVOIfgo31sU6o4NP8xa2ixB0YRh8J3WHRH2n0QgOeBREFE?=
 =?us-ascii?Q?qEFoYCYhKhpvhu2HtaSWsrPIny4YiLomEPQB1B1VFSjw1M3gVcQTjfgTVj44?=
 =?us-ascii?Q?ZO0Px6yyUnAT8VQ5vFwC8CGXxMzaw4jBljJhg9V2kKLzgaFUfEGnlzCE4pbt?=
 =?us-ascii?Q?1teeCrU6fenlnzUPMKJwIpIctE2bQBoxpYW190gMzbhuLoLbF7cj87nIigQf?=
 =?us-ascii?Q?FuFvb7QsiuKXks8sDXC9lcOy4ABdFkdPx+MXsbPrHC48f9+4QI6t416GD84d?=
 =?us-ascii?Q?zjleWdkyR1aelSm0RnNrdjNlge73FrO5d3xu6RSXMuUy+XOekOYec6STE5jC?=
 =?us-ascii?Q?whR1p9oC4nqEPp3+vAT9mOFWiIbFYvoIhWqyPlZnEUvVpQQiVpsgOZp2mSH1?=
 =?us-ascii?Q?NEnVyNZH/Pb4aUog5LmtES3CP1GWDz4YLPMZdl6w3Dap9VxhlyJeDPxPxH+J?=
 =?us-ascii?Q?phnpUcp8EcWVH7CFB4MSvlbMADfgsxNmhS9lRi91NscFU49upOBs8g=3D=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: viKkAg9eAEEXQDze9cGWPXXQVFcU4c1qvxClZesQmBkDS3SekPwf6qigwuC1INDLu5lOOwi9idafdo7J7WWN4cbGdcEU02vK065E4G49qJpBILtYOrL92Nk9DB/9zcbo+NoZ2+sLhjNNReTKE+QH+yE9PpGXPWQt+POp92a8jLQK47o6utjc/uArqw1QeTIFn6+CRZxGjph4dlo4K2TS8srtJXKSXZgX3sQyu7qgPCYYdmU8NppjAAdvTcv5f4FP2wUbaZBY59yVk+fQrq93YEEbt+tCVUsJjWsOuDR/qJhwoM3DlPvDJox84umgvW9Nc/iM5fJudzKznh26fWQKOUqcii7sSun78Dlxa6FVSh9ich/AyHIOmNSoSsG5FNka0Z/iA8qUGgXREz2N+29jQpk9i3TFIyYBzd0V59I0Nawliue8+A/ILdj9syPxMMXi7kfLnwMpa2885v6tyfWF6KKensQt72D8AFP+ZDWRVV6VKZvmNjxLkigqsRHb1A2tlFgQNdc2ksN01pnCuEZFUtsop4E5+j4RCY8NB7tVExcnagf+2lEJMsM59sop4YjQD5STvGvSWNMv4kV96BmxpQVKKrwoy6AzsjZJAWCSor2Fb86Jrt/D4Uu/LZEJCcoMCNpfgDB8ff84I3fhB9faqRFXHwqdMpMKmJOyjUahxCE=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:25.2088 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4c3b673-3960-4234-0ae1-08dd51fa89de
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8P190MB0865
X-BESS-ID: 1740089067-312005-29070-14095-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.11.45
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVobmZoZAVgZQMM3S3MI80Tgxyc
 AyzTzJ3DzRLDkt0dIiLTnNMMkoLc1YqTYWAAPqaFNBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262653 [from 
 cloudscan19-233.eu-central-1b.ess.aws.cudaops.com]
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

Add DDR4 reset and calibration completion handling.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../core/nt400dxx/reset/nthw_fpga_rst9574.c   | 29 ++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
index bd38d6b8c8..757ec1b4c6 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
@@ -71,14 +71,41 @@ static int nthw_fpga_rst9574_setup(nthw_fpga_t *p_fpga, struct nthw_fpga_rst_nt4
 	return 0;
 };
 
+static void nthw_fpga_rst9574_set_default_rst_values(struct nthw_fpga_rst_nt400dxx *const p)
+{
+	nthw_field_update_register(p->p_fld_rst_sys);
+	nthw_field_set_all(p->p_fld_rst_sys);
+	nthw_field_set_val32(p->p_fld_rst_ddr4, 1);
+	nthw_field_set_val_flush32(p->p_fld_rst_phy_ftile, 1);
+}
+
+static int nthw_fpga_rst9574_product_reset(struct fpga_info_s *p_fpga_info,
+	struct nthw_fpga_rst_nt400dxx *p_rst)
+{
+	assert(p_fpga_info);
+	assert(p_rst);
 
+	const char *const p_adapter_id_str = p_fpga_info->mp_adapter_id_str;
+
+	/* (0) Reset all domains / modules except peripherals: */
+	NT_LOG(DBG, NTHW, "%s: %s: RST defaults", p_adapter_id_str, __func__);
+	nthw_fpga_rst9574_set_default_rst_values(p_rst);
+
+	/*
+	 * Wait a while before waiting for deasserting ddr4 reset
+	 */
+	nt_os_wait_usec(2000);
+
+
+	return 0;
+}
 
 static int nthw_fpga_rst9574_init(struct fpga_info_s *p_fpga_info,
 	struct nthw_fpga_rst_nt400dxx *p_rst)
 {
 	assert(p_fpga_info);
 	assert(p_rst);
-	int res = -1;
+	int res = nthw_fpga_rst9574_product_reset(p_fpga_info, p_rst);
 
 	return res;
 }
-- 
2.45.0

