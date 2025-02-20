Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54998C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:06:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2C0040E01;
	Thu, 20 Feb 2025 23:04:38 +0100 (CET)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 9F35A40B9A
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:28 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2113.outbound.protection.outlook.com [104.47.17.113]) by
 mx-outbound8-89.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wRuyKXGyLUwPX1FFTSWpdA/aV8no5MfBMRVutnBAjAUCa6hOf6/lPMl6KgKO0tUZAxDGI33Z/3vICRFvzVhK8/Hko+klMyZL1S0ecVT6mcLqXhQSP80CMOeeKMULwkyTKatoSSiQ8Zr+1xeC+nKS7mAgDgZvjW7M84DsWdq2+cAmFeCY5dtjbIXgKbzPhdzX0jM6SeO1rAt5Ur5RxnA7ofdmmKeK1fpbzSsURzu05UPIxt5VussrBFLLPLL2piJ4khpO+MwbFi1Ugqp0GW/9Ib9Km6nJUwqwFD85723wM1dzzqcC663Fi3dQtF9c5luRSFp2UYONbSAQQnnCvB3+iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n3zHgU5m0XeeQMhtR335N3NcmYbf4mcmJ/E3VGJdFJQ=;
 b=o5eql3eSgwLskZleQexmMRRzc3kV5pxUHSo3ug0R5rk/SGwMZlPTit0lKjT2bVCUPQxGnnzvnMwCSF6Z0VXr4DafSZUUIdqDKjIbcHg0DJ7RJY9h6iHZxqvGwCAh0L9g1XnqptOB2O7/0sLsbdtUVkYc4ewYuOOp+XVLskG/O2FZmUnc+eVAx1fh0ypODUH52j8bfPRl4QlQVrgHrCKKGCu5RYY++yy9nJwnau2GLrhZlAhw/joCm5OxVC+0kjnbGKXdmfh6rENvP+JYXjoEtL2Rzpo69h+oTSBVBm2U8Jm9xyf9/5UlmGm+/zTdjms7EhspskDNw8IbbuM1yYwfEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n3zHgU5m0XeeQMhtR335N3NcmYbf4mcmJ/E3VGJdFJQ=;
 b=bhX4edazDcbIkGUcVuZJ8Xlre6Wlb81p5ZQTsXcAzzLjsIkZncbhw2MHT16Qp+ezQxZNr7ipuLc0YUCXHD4nxnc6dT2kZYMPB89fjMHQLp+H030kJnpY4YNFL9151JcOxwPOlBOSVXceFnsBVL0yqTNHS22K3Gppn6tG4PYMhOE=
Received: from CWLP265CA0502.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::16)
 by AM0P190MB0708.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:198::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Thu, 20 Feb
 2025 22:04:26 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::23) by CWLP265CA0502.outlook.office365.com
 (2603:10a6:400:18b::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 22:04:26 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:26 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 18/32] net/ntnic: add DDR calibration to reset stage
Date: Thu, 20 Feb 2025 23:03:42 +0100
Message-ID: <20250220220406.3925597-19-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|AM0P190MB0708:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 8d623ba1-487d-4eaa-ca69-08dd51fa8a5e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?gMgSqqcUIJqvm1FE5rjPNnT8QFlFES356/XlJl33v3b3FmBw/je6L/mFlsZI?=
 =?us-ascii?Q?x22IrvmQIXKJXcGiV9y2NiLr/Nw9EeiAdH/Em1kfmMszzuY4ewEKwUt/JcJ0?=
 =?us-ascii?Q?/YC8xr9/va+oLgmvWPxsMiGqy3S0l3pmPXo9OG+lGtwi4pk/isDPdWVlSQls?=
 =?us-ascii?Q?cKhF44JTThPB9n4fDywlL8GXVHuchUW7z4gyNtHqrbsQLZFQ2iYrjeZGk5gt?=
 =?us-ascii?Q?IeRysUDjT+xt4WF9otOTY2/ZuY1D7cXj5BipgsSXRbSZENCl0mmO6D+h+wMs?=
 =?us-ascii?Q?5IcigSzZcuQSl88JRC0lWaQjNDhrhUfZvO6Kq+u8sBhk0LGZkXpjR7++e30G?=
 =?us-ascii?Q?sC7/uH+tJmzsi9W44s2nFi0d2r1N1XLeYbQKBRn4ESEEJ61aVkJQP1ZSuv2N?=
 =?us-ascii?Q?JFY4BQxccLdIx2bJoZNZqoUATsSsV9ZLldjb+K9mJdb93UNK0ibKZARh0uK0?=
 =?us-ascii?Q?HCvjsevLo9+Sk88fXTUlM1QqNmuaP7dfX/yc82aO7bYFmC6jsdSpKZiT3tYb?=
 =?us-ascii?Q?bipO5CsuLjoZtAGi48wLuFdrQ5oZwEm2/FPe4Q7pjw/AtXh4i5Rau/cs3u4U?=
 =?us-ascii?Q?WmhIUg+U3QOFICXDHtlTyUV6sevll5oppSMfO8YOdKNjy7ZRhAEayoVJ80uA?=
 =?us-ascii?Q?t383Tt8XTOY+RxJ3XdYHWbO9CU+yMHym1aWs9l3aHPX3z8q+75u+l+BwgbF6?=
 =?us-ascii?Q?oNax7PYYGpOykw0AR1/Kxa+vINLQen6fm8ExoQPPbhdzlGDsSfcNpR5VNQLI?=
 =?us-ascii?Q?Rx5kyV50ZBTRT/fGT/qEGRvcSlrd6OhFs2oxWaVRMvrGTP/+d8Wvb6vEEIhq?=
 =?us-ascii?Q?V/w9Oc+KRjcdP6zmufYjyt3u6K0HubpmslHXwRs0i4EMopjA8L7ubbPiqwtU?=
 =?us-ascii?Q?N3c8GIFJeLtYw2JfmmFfC4Fot/hFDdbRDXmfFBgZA95H6h6eVGyWZDFThNrs?=
 =?us-ascii?Q?N7eEYKR6yl7yn15eT3ILGbQU19dDL2c8voLwgN3VlhAcywTrHDfVnWgwKG1b?=
 =?us-ascii?Q?R3anWU4LdpIjINDZoaiZW+i+cCuGa6emYpOwyOOWUDGBdcL2Zr8EQX8yRzlh?=
 =?us-ascii?Q?24p162UNMLyqelIouMMb5lX+C0c+VDTnnGGfRxQm3CaMQUin0KmWP3Ki12gB?=
 =?us-ascii?Q?Nr+41rGnnju1VBTXHaroTlZM3yRoREzkPJM9GnQBTMhpDy9+A2z3US5/HEqs?=
 =?us-ascii?Q?CCFZh/6xTiL17vZMHG/5WScx8T0Ec5/phdsAVVqa5Syz7j75+mR49gpRszLX?=
 =?us-ascii?Q?3LTo1F/Y21IuI2hK7AMeLB0YcJnMLeQUaMmxXzO2iUyl55K3mCDdF+EfgUt8?=
 =?us-ascii?Q?lre8AVD7dIllkuiEK9+ymHIWWK6CcqCzjCHYqLlCFVGTyHhfixGVczjvpHO7?=
 =?us-ascii?Q?DTO7P0OlfvkBJsq46O/YPbIs3NS6knvPdugUtdgs/bEXVNP6HZlogqwPHfZF?=
 =?us-ascii?Q?h9Oo1X2AkHow45oYiAtajx3vwhVSJDTPW4jo3UYaPuUq7rv2D5LD2Q=3D=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: zl/+2kizkw8Lx7felE+peeJRoLrg68WeyTewJSnD0CBdlrWUVwjSq+gp8V0gWu5tcavhDiR4yc+BwNxFPqqmw5BeaqzuTrZAUx/mz/BEqgPCzhAcKqWDuAYmynBKraa/yWt4j1gktK3g73H9/WAPJaNKXejCkULGu/abPtzHvbxpeHLzwL0DXGZlhPoAv1fB1v8GGb4s8tYrxCfkvfXbJKlNXJnhbGklvP8yvXRbis7ix2f0zDase68+gxhJrbFhmV5CVaHBrCGabN0KW6oVTNFPEFMB/C6Lhubugi7WLutDd/35fpY2hfWbsnqNvQM5kl/m5Ud3xOaLH9AZAMj/xYWzd0PkwUZdWNuqTjlLmiVXohjR2tH0rWqaOxglqWNaA19fEivOyF+TTBEbfTHabftP7ngVHcmGblLhD8IMNYL9NLpRiIb2D25joKVC8Oz/ENasqYAydYVIGG8CE/OgkyQTBMbb8wSfyvDkYx9xK9AXcMPcrXqFZT0fgFiAeZinKdwpMb8lY9w5REYtW5aWwqO5A16GlooViRqP4iDn5SoqhOmErCnexzqU6Mx1Xx1uYL09TIpqRaX5BmBdtC+dNkuzUoMQM0kXCNldB1Tr5IvNb70cy2gZpTRxawEf6VLZcIGaguAkntfjOykzy4BCa7ArFYVqx7SOLQnCekv+Onc=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:26.0526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d623ba1-487d-4eaa-ca69-08dd51fa8a5e
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P190MB0708
X-BESS-ID: 1740089067-302137-23556-14694-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.17.113
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViZGJmZAVgZQ0DzV1NDU1DAxzd
 LQKMnSxDjJKDHJ0izNyNAwySQx2cJYqTYWAHX4XAZBAAAA
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

Add DDR4 reset and calibration functions for FPGA.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../core/nt400dxx/reset/nthw_fpga_rst9574.c   | 95 +++++++++++++++++++
 1 file changed, 95 insertions(+)

diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
index 757ec1b4c6..27d60d1448 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst9574.c
@@ -79,6 +79,72 @@ static void nthw_fpga_rst9574_set_default_rst_values(struct nthw_fpga_rst_nt400d
 	nthw_field_set_val_flush32(p->p_fld_rst_phy_ftile, 1);
 }
 
+static void nthw_fpga_rst9574_ddr4_rst(struct nthw_fpga_rst_nt400dxx *const p, uint32_t val)
+{
+	nthw_field_update_register(p->p_fld_rst_ddr4);
+	nthw_field_set_val_flush32(p->p_fld_rst_ddr4, val);
+}
+
+static bool nthw_fpga_rst9574_get_ddr4_calib_complete_stat(struct nthw_fpga_rst_nt400dxx *const p)
+{
+	return nthw_field_get_updated(p->p_fld_stat_ddr4_calib_complete) != 0;
+}
+
+static bool nthw_fpga_rst9574_get_ddr4_calib_complete_latch(struct nthw_fpga_rst_nt400dxx *const p)
+{
+	return nthw_field_get_updated(p->p_fld_latch_ddr4_calib_complete) != 0;
+}
+
+static void nthw_fpga_rst9574_set_ddr4_calib_complete_latch(struct nthw_fpga_rst_nt400dxx *const p,
+	uint32_t val)
+{
+	nthw_field_update_register(p->p_fld_latch_ddr4_calib_complete);
+	nthw_field_set_val_flush32(p->p_fld_latch_ddr4_calib_complete, val);
+}
+
+static int nthw_fpga_rst9574_wait_ddr4_calibration_complete(struct fpga_info_s *p_fpga_info,
+	struct nthw_fpga_rst_nt400dxx *p_rst)
+{
+	const char *const p_adapter_id_str = p_fpga_info->mp_adapter_id_str;
+	uint32_t complete;
+	uint32_t retrycount;
+	uint32_t timeout;
+
+	/* 3: wait until DDR4 CALIB COMPLETE */
+	NT_LOG(DBG, NTHW, "%s: %s: DDR4 CALIB COMPLETE wait complete", p_adapter_id_str, __func__);
+	/*
+	 * The following retry count gives a total timeout of 1 * 5 + 5 * 8 = 45sec
+	 * It has been observed that at least 21sec can be necessary
+	 */
+	retrycount = 1;
+	timeout = 50000;/* initial timeout must be set to 5 sec. */
+
+	do {
+		complete = nthw_fpga_rst9574_get_ddr4_calib_complete_stat(p_rst);
+
+		if (!complete)
+			nt_os_wait_usec(100);
+
+		timeout--;
+
+		if (timeout == 0) {
+			if (retrycount == 0) {
+				NT_LOG(ERR, NTHW,
+					"%s: %s: Timeout waiting for DDR4 CALIB COMPLETE to be complete",
+					p_adapter_id_str, __func__);
+				return -1;
+			}
+
+			nthw_fpga_rst9574_ddr4_rst(p_rst, 1);	/* Reset DDR4 */
+			nthw_fpga_rst9574_ddr4_rst(p_rst, 0);
+			retrycount--;
+			timeout = 90000;/* Increase timeout for second attempt to 8 sec. */
+		}
+	} while (!complete);
+
+	return 0;
+}
+
 static int nthw_fpga_rst9574_product_reset(struct fpga_info_s *p_fpga_info,
 	struct nthw_fpga_rst_nt400dxx *p_rst)
 {
@@ -86,6 +152,7 @@ static int nthw_fpga_rst9574_product_reset(struct fpga_info_s *p_fpga_info,
 	assert(p_rst);
 
 	const char *const p_adapter_id_str = p_fpga_info->mp_adapter_id_str;
+	int res = -1;
 
 	/* (0) Reset all domains / modules except peripherals: */
 	NT_LOG(DBG, NTHW, "%s: %s: RST defaults", p_adapter_id_str, __func__);
@@ -96,6 +163,34 @@ static int nthw_fpga_rst9574_product_reset(struct fpga_info_s *p_fpga_info,
 	 */
 	nt_os_wait_usec(2000);
 
+	/* (1) De-assert DDR4 reset: */
+	NT_LOG(DBG, NTHW, "%s: %s: De-asserting DDR4 reset", p_adapter_id_str, __func__);
+	nthw_fpga_rst9574_ddr4_rst(p_rst, 0);
+
+	/*
+	 * Wait a while before waiting for calibration complete, since calibration complete
+	 * is true while ddr4 is in reset
+	 */
+	nt_os_wait_usec(2000);
+
+	/* (2) Wait until DDR4 calibration complete */
+	res = nthw_fpga_rst9574_wait_ddr4_calibration_complete(p_fpga_info, p_rst);
+
+	if (res)
+		return res;
+
+	/* (3) Set DDR4 calib complete latched bits: */
+	nthw_fpga_rst9574_set_ddr4_calib_complete_latch(p_rst, 1);
+
+	/* Wait for phy to settle.*/
+	nt_os_wait_usec(20000);
+
+	/* (4) Ensure all latched status bits are still set: */
+	if (!nthw_fpga_rst9574_get_ddr4_calib_complete_latch(p_rst)) {
+		NT_LOG(ERR, NTHW, "%s: %s: DDR4 calibration complete has toggled",
+			p_adapter_id_str, __func__);
+	}
+
 
 	return 0;
 }
-- 
2.45.0

