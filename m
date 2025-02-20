Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3EA6C021B3
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:07:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E3C3040E0F;
	Thu, 20 Feb 2025 23:04:52 +0100 (CET)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 2530840E01
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:38 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02lp2236.outbound.protection.outlook.com [104.47.11.236]) by
 mx-outbound46-229.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NW/waaAuFWNeMALBS89Jv/+2imRmvB+Z79gv/75mHpRly4MI2jRKV2kQO6v8FHVfaLq8BsbaBKSV/5SzQePEXxo+vwV96+lT3Pv6BSZrPG7a2LAAw9TeMMPhdmCxHxF/6cJQmBlez4yP8APeW13JpB143zTTdI6aVy7JRYPcmTRn5x9Yq55nFN1C7UaW6eKzb4e+Jjq3RvfBAi1yA45THwCm1CH1V92BS8WoHAg+8qRVYtnab58CGEb9VYdq4sYTV9xFqCy+88NuLglKR2TbfMNXmuy/ULra4TKm09Ef/r9FbV7NVW5LO/hMql+Th7WHlC+1e8zv9GrRvY8sO1CTdw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pzOtsUS+VaZ82/52CXQUKC0hEgIIC4bQMQz/1yrqeV4=;
 b=bJvho0IMn/KDjEKL90eUsd2AZgGOfeRl+BMP+sp1Br2pcYEZkZyBSTlAE0b1eyWCv37M/7kHGlbrFM3yF2Nr2Yxs3cLCq4dPFS4v8DEPuf/vtJCuXQWQOGMgyauVlNxdJLgsBJpXq2sqeH5c35FjSsGY0A7I4dzpbg6P+VGdThPhzQ4JZlCHJS73Hjnjhb3AiOeNHP5O1SiYE4jhq43AsHAl0u/B6VRsdxrzypSo32nOIZr9YM81KR4lW/FdrTMroPDk28hx992ahZ4fWGDwuTz76MBlf6IcjcTodKB5uObKQi64GqBBbuiB0dKX2Ns9mbGRVgnJgZKBf8yEfHi+Zg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pzOtsUS+VaZ82/52CXQUKC0hEgIIC4bQMQz/1yrqeV4=;
 b=dD0uYHjRCNu/p1HDNdZTA+hKkf/GrhFGeAz7NcUV7u8P/F7HNBPWSBzlwZxRB1oTSOcluT3DICXSQHh6LStkVsDBhTZuJQ9ItE2dU/RgVgMDmiG3h7y/5k0YOwNmFcMzR4aEc5jfbtTd3YD0zhWP91EJjf4/qeHqVFlyngoyNfM=
Received: from CWLP265CA0506.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::19)
 by GVXP190MB2204.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:1fa::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 22:04:34 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::b2) by CWLP265CA0506.outlook.office365.com
 (2603:10a6:400:18b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 22:04:33 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:33 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 27/32] net/ntnic: add pca init
Date: Thu, 20 Feb 2025 23:03:51 +0100
Message-ID: <20250220220406.3925597-28-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|GVXP190MB2204:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 786ee6e0-25a6-41fb-ac11-08dd51fa8eec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?PbKzh1A1VriF+V0T8Dtjw19vgXGQ0uP5tQsqnVCNrrQkRqaMXWt9DQGZ4atM?=
 =?us-ascii?Q?/gIRn/6Ehg+Ga7+1NLpHwcxXxeOj8EP8Zkvo3ub+HSxXJLMDcAmG60TTLQJy?=
 =?us-ascii?Q?XFFIioxliO3BWo6tvAqzBJmET/31XES5nl1mP9LAg8mFQnAMv92aEGcyS9uA?=
 =?us-ascii?Q?5skCg36F10lpd+4ntLkl9aIQh3jv4VpptE/I7KE9s9JEEcGvuPGPPCOvQuCk?=
 =?us-ascii?Q?rC7LYnlG349RdAznlOubWGm2idJZx57ioSABUYvIqczSheB7K3bCBjqnyByX?=
 =?us-ascii?Q?ddo4GVAlWyu3+QiUEfv5YckaUqJHO3c/gwBACxa3TzRofGMWaWLo9Pgh/mvR?=
 =?us-ascii?Q?M131elGFrob+9YDqHvuxQnuIqPFcy+wjkNfecjTQ+tJAXVVAmCS8wVfOWOIA?=
 =?us-ascii?Q?VapfElEBv4Ncjw7zM2Eih0WMGS5DzNcwpyAT/UzgN6Fx1ScCdF/NWPl1NMwj?=
 =?us-ascii?Q?d6Qr40z5Oola4bULdRacsUC7cf5dxLWNr/TPrivlRuSiY5dx1DkigCFRuq0y?=
 =?us-ascii?Q?p6TnArErnEYxQES9ydECcHK5jvwjzCoZKt+tiSLQtUiIVySZq+S76Om9KmJm?=
 =?us-ascii?Q?zgzRYtdaqe0BsZgjyJDpPSGA4Hum8mxPUVENsRttOKU0u/xYUMuoz+UywFPm?=
 =?us-ascii?Q?+lCRpUijfvLnZlAYnk60KqaARYtBvli+RjD+g/lwT3NRH6CUJQL/jSDq/prR?=
 =?us-ascii?Q?A6laLekGRI9kSDGH/lux96raCuZLqd5f5paJJldzqy4OJ6EpNd7OIvXmicGn?=
 =?us-ascii?Q?jAdEdelsAjGakGRO7iX3IrxD5NLIRxzV2dlPaxWp/tKrYWKAAc2N7xDdJuTc?=
 =?us-ascii?Q?LUj9QE/NxcGdXUyKmOPRYeU+8TqVDwzN8rt37hFcfO8yHp4W0bENnx3714PY?=
 =?us-ascii?Q?1qOOrUM+e07CJ4plUg/dipkh3Uq1I8Xd8HN4+jIIt9NsEGUK5WgDEaIw3Iei?=
 =?us-ascii?Q?OOVppVl7Ks303DlO7l/VHfzcSUTvDZTq1ESUxdkiiYrwyNDWI1WeSmUIguLD?=
 =?us-ascii?Q?JHc7oEWiOmzUCfLZ7IgI7hMtAvRXHldxFTBQM6H4aqpAbA5mWDlmxM174Akg?=
 =?us-ascii?Q?A+HQUuzXhmAw+F/4Cu3EFsiHZ7hhHNx1zbmJ9ImgfoC4OuoxR3YTly12PDZ+?=
 =?us-ascii?Q?gPA5Qwe7BClctsybtLbPKQ2Kv6q2UqSeqYxyx3PisvxrLPACRxWMhrSZjmzQ?=
 =?us-ascii?Q?aJa9SyH46nK1NkMvZ/5iI30oAlGUF1Mfo+BvZOV7p1kPd+xhV/BNXE8M3pB7?=
 =?us-ascii?Q?XJhcvRFlLz8FuiWp1LjRizN3cjioYRSYsF9E/KCiSSTGghOg/OmJYc/gFhoL?=
 =?us-ascii?Q?dvkDSx42GJ6nTRACondNRDxrU5rcwjhR/78qfxuR5Sh2rL8BsTVD035Nai2o?=
 =?us-ascii?Q?TKI4jU3kXk+65mfvaEhulSL+Luuswqlu0Mx65WN8m+sb4g5Sint0DoSqaNNj?=
 =?us-ascii?Q?BkRVyJYjDr7PvO8zfQspRbmkfsrxe+FpaOgAx0OvQTeUPIDoNFjPjw=3D=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: XRAoYcas/S1fTmdGd4XJ0KdeZoElo1ycC88/wjk/+AF7T5RhMX3O7O46zF8sLbYPsPR/91TrXShTOc6Ga3I6i82ypZvonrXh1FWYjmRurjcfHTFL15OstjKMlVoZb7DYPixcXXs8pDtb7VDDoGazdeXJPxHVj78PgbMBk252Sut30dsgOoaLzhw7u0Y/SMzZoatghWla51PtElc4rEGa+5ncp1LlxCQ/RxomPoKnDQEu8Amwt76hyb3s3EsW1PwLQoQ/x3/4R8IiX04xx+kPdBc9sH8FomW5YMpNHbbhk56+uk/xKiWm05J5Ry6M7L8/hMHY//hxKGAWLQObUFs9Tv/33WSuDtkLFh50G8pN458Es6i+iGVQ3KnK1ecM/cHbf2n3RdmgDJZHMoHzjdQcqK/HoBlMMOSZ7JV9wGxgrUWz6buzBB+6Voj0pQyNFn4VM+xBykwGf0y2hKkfEDoWyFqDqK6VRFv/DHMdiQ5dVZp+T/C/N90Zcmu4njzUfS4fDAUVhxf1oU8YRflObktjjh4HDA3tYMhqf6Hj76/KIQUyhZZ1/HnwgMcH5Cui8EMNfkTwHcx3srUZwSZcwcp20UShDeOSpuk2MICNgrSc0aPyeyhJLw5XDPIoFzb45BzrP8Ex4kBWdIchvaXVgpXGOMCK9y+EwRp+W5m7pztnplg=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:33.6933 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 786ee6e0-25a6-41fb-ac11-08dd51fa8eec
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP190MB2204
X-BESS-ID: 1740089077-312005-29065-14101-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.11.236
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKViZmxiZAVgZQMNHSNNnEwizJMj
 HZ1CDZwDgxzSAt1cAiNTXVMC3R2MxQqTYWADDQcFVBAAAA
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

From: Danylo Vodopianov <dvo-plv@napatech.com>

Add initialization for I2C mux and LED driver.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../ntnic/nthw/core/include/nthw_pca9532.h    |  3 +++
 .../nthw/core/include/nthw_si5332_si5156.h    |  3 +++
 .../nt400dxx/reset/nthw_fpga_rst_nt400dxx.c   | 23 +++++++++++++++++++
 drivers/net/ntnic/nthw/core/nthw_pca9532.c    | 20 ++++++++++++++++
 .../net/ntnic/nthw/core/nthw_si5332_si5156.c  | 18 +++++++++++++++
 5 files changed, 67 insertions(+)

diff --git a/drivers/net/ntnic/nthw/core/include/nthw_pca9532.h b/drivers/net/ntnic/nthw/core/include/nthw_pca9532.h
index 24da937a18..7cc0008dcb 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_pca9532.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_pca9532.h
@@ -17,6 +17,9 @@ struct nthw_pca9532 {
 
 typedef struct nthw_pca9532 nthw_pca9532_t;
 
+nthw_pca9532_t *nthw_pca9532_new(void);
+int nthw_pca9532_init(nthw_pca9532_t *p, nthw_i2cm_t *p_nt_i2cm, uint8_t dev_address,
+	nthw_pca9849_t *pca9849, uint8_t mux_channel);
 void nthw_pca9532_set_led_on(nthw_pca9532_t *p, uint8_t led_pos, bool state_on);
 
 #endif	/* __NTHW_PCA9532_H__ */
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_si5332_si5156.h b/drivers/net/ntnic/nthw/core/include/nthw_si5332_si5156.h
index 753717ba8a..9eaf8872e3 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_si5332_si5156.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_si5332_si5156.h
@@ -19,6 +19,9 @@ struct nthw_pca9849 {
 
 typedef struct nthw_pca9849 nthw_pca9849_t;
 
+nthw_pca9849_t *nthw_pca9849_new(void);
+int nthw_pca9849_init(nthw_pca9849_t *p, nthw_i2cm_t *p_nt_i2cm, uint8_t dev_address);
+
 int nthw_pca9849_set_channel(nthw_pca9849_t *p, uint8_t channel);
 
 /*
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
index bfc66a97d1..6c5c1cd51e 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
@@ -77,6 +77,29 @@ static int nthw_fpga_rst_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 	if (res != 0)
 		return res;
 
+	/* Create pca9849 i2c mux */
+	p_fpga_info->mp_nthw_agx.p_pca9849 = nthw_pca9849_new();
+	res = nthw_pca9849_init(p_fpga_info->mp_nthw_agx.p_pca9849,
+			p_fpga_info->mp_nthw_agx.p_i2cm,
+			0x71);
+
+	if (res != 0)
+		return res;
+
+	/* Create LED driver */
+	p_fpga_info->mp_nthw_agx.p_pca9532_led = nthw_pca9532_new();
+	res = nthw_pca9532_init(p_fpga_info->mp_nthw_agx.p_pca9532_led,
+			p_fpga_info->mp_nthw_agx.p_i2cm,
+			0x60,
+			p_fpga_info->mp_nthw_agx.p_pca9849,
+			3);
+
+	if (res != 0)
+		return res;
+
+	for (uint8_t i = 0; i < 16; i++)
+		nthw_pca9532_set_led_on(p_fpga_info->mp_nthw_agx.p_pca9532_led, i, false);
+
 	/* Create PCM */
 	p_fpga_info->mp_nthw_agx.p_pcm = nthw_pcm_nt400dxx_new();
 	res = nthw_pcm_nt400dxx_init(p_fpga_info->mp_nthw_agx.p_pcm, p_fpga, 0);
diff --git a/drivers/net/ntnic/nthw/core/nthw_pca9532.c b/drivers/net/ntnic/nthw/core/nthw_pca9532.c
index fcf5463fcb..af14cd6d06 100644
--- a/drivers/net/ntnic/nthw/core/nthw_pca9532.c
+++ b/drivers/net/ntnic/nthw/core/nthw_pca9532.c
@@ -15,6 +15,26 @@
 
 static const uint8_t led_sel_reg[4] = { 6, 7, 8, 9 };
 
+nthw_pca9532_t *nthw_pca9532_new(void)
+{
+	nthw_pca9532_t *p = malloc(sizeof(nthw_pca9532_t));
+
+	if (p)
+		memset(p, 0, sizeof(nthw_pca9532_t));
+
+	return p;
+}
+
+int nthw_pca9532_init(nthw_pca9532_t *p, nthw_i2cm_t *p_nt_i2cm, uint8_t dev_address,
+	nthw_pca9849_t *pca9849, uint8_t mux_channel)
+{
+	p->mp_nt_i2cm = p_nt_i2cm;
+	p->m_dev_address = dev_address;
+	p->mp_ca9849 = pca9849;
+	p->m_mux_channel = mux_channel;
+	return 0;
+}
+
 void nthw_pca9532_set_led_on(nthw_pca9532_t *p, uint8_t led_pos, bool state_on)
 {
 	if (led_pos >= 16) {
diff --git a/drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c b/drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c
index b4a7b57bcb..eb11ebc67a 100644
--- a/drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c
+++ b/drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c
@@ -13,6 +13,24 @@
 
 #include "nthw_si5332_si5156.h"
 
+nthw_pca9849_t *nthw_pca9849_new(void)
+{
+	nthw_pca9849_t *p = malloc(sizeof(nthw_pca9849_t));
+
+	if (p)
+		memset(p, 0, sizeof(nthw_pca9849_t));
+
+	return p;
+}
+
+int nthw_pca9849_init(nthw_pca9849_t *p, nthw_i2cm_t *p_nt_i2cm, uint8_t dev_address)
+{
+	p->mp_nt_i2cm = p_nt_i2cm;
+	p->m_dev_address = dev_address;
+	p->m_current_channel = 0;
+	return 0;
+}
+
 int nthw_pca9849_set_channel(nthw_pca9849_t *p, uint8_t channel)
 {
 	int res;
-- 
2.45.0

