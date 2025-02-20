Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6B67C021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:07:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBBEF40E6E;
	Thu, 20 Feb 2025 23:04:51 +0100 (CET)
Received: from egress-ip11a.ess.de.barracuda.com
 (egress-ip11a.ess.de.barracuda.com [18.184.203.234])
 by mails.dpdk.org (Postfix) with ESMTP id 7DED340E03
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:37 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2108.outbound.protection.outlook.com [104.47.18.108]) by
 mx-outbound8-89.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tMDz29qKs2E3CtvXuVQHhmWpT+kQ4we7e6QRgSjwWaDNPI++mVOD51xYJ9s5wvf0w6gRRtyEpGICuQ5Uskqy6JSAeXM1cY+g/twkq5OYl0E3BKW9IgvUou79aZXeKxIo9PiAg5p/oPSN6HnuvcWZV5z4GO8pYKu2EpZzmuSpWePi9ucNGM1SZwiBV2MJ5wsxp90dCIyNc4bxho7qb4HklpiBqonaFm73Q9JA7xK0JEUfMQvEyIrBA40K+HjqJelefNHnWlBpSe1+WmP6D0EUjG9KQkIVWg/M8jWFWCjnFuZNeaXkyqA6s8DG+Ybr8R7VayU8aTHbb4uFWrIhhVHvUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZeXrW7ULSvI9J8fjqY4pj+12Fdd9G0gHckp8KwcFyFI=;
 b=QSozS4JtDu9fdq+GIrGZdDrY4UUThBhdwidFEmjHJg/9DtNeX2cv7jgvdsp35MglQwJKF5GF1BxWVLzmHy+PUiSsORT8MXj8XhUD3GttvJ/27qMeC3H8oHyBfKF5qcIXsmZ8bZIIsMLIlECqYhThEwo9ptx0ZLBBnIQK1AvHw2p2aK1foaaWcp5IbmFupT8uaehv0plIOOc+wuS9AY9p70sfGrkf6GS/a6LvC8Ytfc1/oT6QF8Ni5UH5uupyjX4oidLPhCeE/K7GgC7Kb1i6XBTfUjgrC28n1VgQpjwsKWPgN5XBN4X/9v4ohnkwt+9pfBNH1XL6aBzo69h26f/q+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZeXrW7ULSvI9J8fjqY4pj+12Fdd9G0gHckp8KwcFyFI=;
 b=lNVJkEFlaKofWCFGX7lbokoZvGsgfYkk5qdelZD7q8j1+t0Tikpjy+9xPVPt5bOK7+RomJwoZ1tUYTgz4pvYFSEm+uR2pRBSq7qrMay5wo6zcnLFDatbTdJLPJFWEMghR9KWLM4XKYkKYc1POKwNfAtG7d1dhHc5YmPXjozZEgg=
Received: from CWLP265CA0495.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::7)
 by AS4P190MB1998.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:519::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 22:04:35 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::62) by CWLP265CA0495.outlook.office365.com
 (2603:10a6:400:18b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 22:04:34 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:34 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 28/32] net/ntnic: add pcal init
Date: Thu, 20 Feb 2025 23:03:52 +0100
Message-ID: <20250220220406.3925597-29-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|AS4P190MB1998:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 85e2f69d-ec09-482d-6a62-08dd51fa8f8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?1WkJRNg0pJKfsRsXcvNoSZkojmib4NLL47lMhwJHCEA/Ok4H6VaPqgwf9L1E?=
 =?us-ascii?Q?vcU/N1B3Mt3DvXNQEoYr8NAOh/S/P65t/e6XCLUPOsMU0jSFkYUUFko7ZuJq?=
 =?us-ascii?Q?QrQFCzEJJUtDe6y0gLxTmYiI2/AtpwnTnI5l188AzZ/+XhQtEJ2hJHpH+Zil?=
 =?us-ascii?Q?i80vlD98XcKrYLj/4PZ6m8nx43B7jixJ7y/scCarJUJR+nt1UNZxDeB4N/jt?=
 =?us-ascii?Q?KelGO2QIvdVBrAy5pfFVvYjqzXhOProEzrT+HNagEi+YocyLwttf3knykW7R?=
 =?us-ascii?Q?kD3nMJQpZgw+4DqVzJASsnxHPS2c6inI3N9oHPUisDvUntfOz1q39e/WZvih?=
 =?us-ascii?Q?8eniYqV/ZH91jUC6lNxRo7HTRqcMMVT2dJ5iIM+25pfAVVX6QAe3ZE8VQ/i4?=
 =?us-ascii?Q?rJl+4Uc4HGFLc5NrtEXDacOwkAQDXAW/h6FbJ2GMOJqaJTI9FmYvkwDqS8wi?=
 =?us-ascii?Q?K8LlnReLMMc50qaY6hL0WK9CewWanB9xyAYxyiXkC0KUbCln6X1LEJ3t3/ZP?=
 =?us-ascii?Q?otRhW2NWhNygeDzk/3CAj5wTLe3SkV8D5i5Ws4waqBiWbfxhGZUgZ6jBS0ox?=
 =?us-ascii?Q?3/UByjJF++WLS9v2wflSlwIwcNcHTkKQtTpXk0Zub9ZBadLGDxMGVMiqhct2?=
 =?us-ascii?Q?nzBNXLBxv99SLy/ZJPKYPyGreRzBkR1pev41JY+lMgDNRqAhVqS1pVio8UoX?=
 =?us-ascii?Q?IWCh7SesTEBbKIraUMgCZPhH/hxQ84FL2Y1NExSmhomQq9UybGLsWjrlpP1O?=
 =?us-ascii?Q?Iz3n89JBaCQYVtqeGgZdMGn/B+sa7tUd+HGIP7WmTGIt3dlp1ffy9rIAu+qm?=
 =?us-ascii?Q?TYDw8ELbVWVPwGaJ0UTkWpsWGJ6dYA5xCO5NPEqpsdYCcfM59vbTcOITGGzA?=
 =?us-ascii?Q?oQ1mUFDfIHrN2W/XZW+5C2eFRHrIVhZA3Q2TRkrsOTOFT1rrtQKYfRINbej7?=
 =?us-ascii?Q?I/VmtYHOL56qeRtKl3w1YMr+4HeepNVuJFpUlcoAq/8o+Pt2qibKmF520u8d?=
 =?us-ascii?Q?+bQYZqRMlQVrCq4cqT936kDwCUHRIYgYaeqYEejigYOa5hYG/sFshs2zUpgA?=
 =?us-ascii?Q?UXullUhwo4XkbRVh78o0IEV737Z+wFxqzOgEKYYbFhJnryrkBhHRsYY8quni?=
 =?us-ascii?Q?fPvhwHNS42RN15xz66nDcP65HLtPPjX8K3mJbkGP5mqNYpG0Ow7KEqde/+ul?=
 =?us-ascii?Q?uW7zIESFcfKbaWEX7i2n4YdBB3SApsMMYacGAL2YGgBKMSzFA9rEulGOsz1t?=
 =?us-ascii?Q?blTK32PCsHi0ZCGJakE6CdNv5eLIIYmq9d5aFDuUHSyqvbFJ5h2qKEj+surL?=
 =?us-ascii?Q?DLVRUyZg/NByWyx3ECCLahH42umFRz3bgTe1G1mO4fTlhX4rlLgUTjQ73m4Z?=
 =?us-ascii?Q?UtzWZ7UD6ncLEVK7sHAb/YOtPnxaVtrZR/vDLflgUTOX5As+PXu4OH7pG5P6?=
 =?us-ascii?Q?74WKGvvOlaulhzzrxmfhzAbunPpa+tCtrnSz+FShhsgNLJBG5E+bgPLnhA9E?=
 =?us-ascii?Q?01AjatCsXtsBiZ0=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 79y9TGKTFuDE7eUYA05M611ZLPee+/K1oiE0KoftWgW9jILaeZJBySprBIebFUPcvjqjndTsrGCvqXMjd22gE3pyNmASFE3PHp84EwZftrePFJvXv7nOwT4In2lDdaHQTg+53ORd72W7mcPOcgPhVkqgmjjP+RdNqxSDAqiCrVqMBQ+FTEi5AhUQ5KsRadoGY5OeN5Cku8A5l1X9AolMhUz3jvsVKhi6EM2ju8hi0Ek8eGOlbubZbTDqU+fNRtuOFJbAgFmigLjVYvd4fp9DoyaTjknFQ6wmk+hpTh+iXEbTJz78333sDeDp+B6GNqSSwKvJ6S11lcTgNVrrYQlZ6I0mqqwLzr8LngnV1O+Y8ykkVlPtKeezlZS8ZS4HeVSVTed1htXmU8YFpIOa7Js7biaJtHIaEXm5GkcX+sdt+CU+cyHcrPktGPXdqiryiOEYhBS2Hqo/a7RpUHy78YHGZ7bg7y8UztOuNC/BUTfCz2h7u9fhd6nTRRAiDNjkGOBL5kL5YOC3+1dXthrAc4kz0cSGrNsuRD2f7+pxjOFIblSdI8/5Gbo8cvPzZX6j6pV51n4dPKTC0km9G3jgh1ky3DDS8idcbkBv6AImuJHZK7MlSxy5ippxBHLtv2uSAypDySrs0ry4XwkN/C9R2HppKglUmim/Jl00juvZ7eYmAGI=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:34.7402 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 85e2f69d-ec09-482d-6a62-08dd51fa8f8c
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4P190MB1998
X-BESS-ID: 1740089076-302137-23556-14700-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.18.108
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqamJsZAVgZQ0DDFNCXR2NDEIN
 HCwCDJzNg0zSzRzNjSwszU2MTUyDxJqTYWACeujbpBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262653 [from 
 cloudscan19-102.eu-central-1b.ess.aws.cudaops.com]
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

From: Danylo Vodopianov <dvo-plv@napatech.com>

Add initialization for I/O expanders and configure TS settings.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../ntnic/nthw/core/include/nthw_pcal6416a.h  |  3 +
 .../nt400dxx/reset/nthw_fpga_rst_nt400dxx.c   | 69 +++++++++++++++++++
 drivers/net/ntnic/nthw/core/nthw_pcal6416a.c  | 23 +++++++
 drivers/net/ntnic/nthw/nthw_drv.h             |  1 +
 4 files changed, 96 insertions(+)

diff --git a/drivers/net/ntnic/nthw/core/include/nthw_pcal6416a.h b/drivers/net/ntnic/nthw/core/include/nthw_pcal6416a.h
index a718b59a29..e3dadcc8e3 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_pcal6416a.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_pcal6416a.h
@@ -24,6 +24,9 @@ struct nthw_pcal6416a {
 
 typedef struct nthw_pcal6416a nthw_pcal6416a_t;
 
+nthw_pcal6416a_t *nthw_pcal6416a_new(void);
+int nthw_pcal6416a_init(nthw_pcal6416a_t *p, nthw_i2cm_t *p_nt_i2cm, uint8_t dev_address,
+	nthw_pca9849_t *pca9849, uint8_t mux_channel);
 void nthw_pcal6416a_write(nthw_pcal6416a_t *p, uint8_t pin, uint8_t value);
 void nthw_pcal6416a_read(nthw_pcal6416a_t *p, uint8_t pin, uint8_t *value);
 
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
index 6c5c1cd51e..c8fd37d0ff 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
@@ -86,6 +86,58 @@ static int nthw_fpga_rst_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 	if (res != 0)
 		return res;
 
+	/* Create PCAL6416A I/O expander for controlling Nim */
+	p_fpga_info->mp_nthw_agx.p_io_nim = nthw_pcal6416a_new();
+	res = nthw_pcal6416a_init(p_fpga_info->mp_nthw_agx.p_io_nim,
+			p_fpga_info->mp_nthw_agx.p_i2cm,
+			0x20,
+			p_fpga_info->mp_nthw_agx.p_pca9849,
+			3);
+
+	if (res != 0)
+		return res;
+
+	/* Create PCAL6416A I/O expander for controlling TS */
+	p_fpga_info->mp_nthw_agx.p_io_ts = nthw_pcal6416a_new();
+	res = nthw_pcal6416a_init(p_fpga_info->mp_nthw_agx.p_io_ts,
+			p_fpga_info->mp_nthw_agx.p_i2cm,
+			0x20,
+			p_fpga_info->mp_nthw_agx.p_pca9849,
+			2);
+
+	if (res != 0)
+		return res;
+
+	/*
+	 * disable pps out
+	 * TS_EXT1_OUT_EN : Low
+	 */
+	nthw_pcal6416a_write(p_fpga_info->mp_nthw_agx.p_io_ts, 0, 0);
+
+	/*
+	 * Enable DC termination
+	 * TS_EXT1_TERM_DC_E : High
+	 */
+	nthw_pcal6416a_write(p_fpga_info->mp_nthw_agx.p_io_ts, 3, 1);
+
+	/*
+	 * enable 50 ohm termination
+	 * TS_EXT1_TERM50_DIS : low
+	 */
+	nthw_pcal6416a_write(p_fpga_info->mp_nthw_agx.p_io_ts, 2, 0);
+
+	/*
+	 * Normal Threshold
+	 * TS_EXT1_LOW_THRESHOLD: Low
+	 */
+	nthw_pcal6416a_write(p_fpga_info->mp_nthw_agx.p_io_ts, 1, 0);
+
+	/*
+	 * Select FPGA I/O - we want to use TSM Bresenham for time adjustments against PPS time
+	 * reference TS_EXT_ZL30733_EnB: High
+	 */
+	nthw_pcal6416a_write(p_fpga_info->mp_nthw_agx.p_io_ts, 8, 1);
+
 	/* Create LED driver */
 	p_fpga_info->mp_nthw_agx.p_pca9532_led = nthw_pca9532_new();
 	res = nthw_pca9532_init(p_fpga_info->mp_nthw_agx.p_pca9532_led,
@@ -100,6 +152,23 @@ static int nthw_fpga_rst_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 	for (uint8_t i = 0; i < 16; i++)
 		nthw_pca9532_set_led_on(p_fpga_info->mp_nthw_agx.p_pca9532_led, i, false);
 
+	/* Enable power supply to NIMs */
+	nthw_pcal6416a_write(p_fpga_info->mp_nthw_agx.p_io_nim, 8, 1);
+	nt_os_wait_usec(100000);/* 100ms */
+
+	/* Check that power supply turned on. Warn if it didn't. */
+	uint8_t port_power_ok;
+	nthw_pcal6416a_read(p_fpga_info->mp_nthw_agx.p_io_nim, 9, &port_power_ok);
+
+	if (port_power_ok != 1) {
+		NT_LOG(ERR,
+			NTHW,
+			"Warning: Power supply for QSFP modules did not turn on - Fuse might be blown.");
+		return -1;
+	}
+
+	NT_LOG(INF, NTHW, "Status of power supply for QSFP modules %u", port_power_ok);
+
 	/* Create PCM */
 	p_fpga_info->mp_nthw_agx.p_pcm = nthw_pcm_nt400dxx_new();
 	res = nthw_pcm_nt400dxx_init(p_fpga_info->mp_nthw_agx.p_pcm, p_fpga, 0);
diff --git a/drivers/net/ntnic/nthw/core/nthw_pcal6416a.c b/drivers/net/ntnic/nthw/core/nthw_pcal6416a.c
index dd803ac66d..2fca469497 100644
--- a/drivers/net/ntnic/nthw/core/nthw_pcal6416a.c
+++ b/drivers/net/ntnic/nthw/core/nthw_pcal6416a.c
@@ -20,6 +20,29 @@ static const uint8_t config_port[2] = { 0x06, 0x07 };
  * PCAL6416A I/O expander class
  */
 
+nthw_pcal6416a_t *nthw_pcal6416a_new(void)
+{
+	nthw_pcal6416a_t *p = malloc(sizeof(nthw_pcal6416a_t));
+
+	if (p) {
+		memset(p, 0, sizeof(nthw_pcal6416a_t));
+		p->m_config_data[0] = 0xFF;
+		p->m_config_data[1] = 0xFF;
+	}
+
+	return p;
+}
+
+int nthw_pcal6416a_init(nthw_pcal6416a_t *p, nthw_i2cm_t *p_nt_i2cm, uint8_t dev_address,
+	nthw_pca9849_t *pca9849, uint8_t mux_channel)
+{
+	p->mp_nt_i2cm = p_nt_i2cm;
+	p->m_dev_address = dev_address;
+	p->mp_ca9849 = pca9849;
+	p->m_mux_channel = mux_channel;
+	return 0;
+}
+
 void nthw_pcal6416a_write(nthw_pcal6416a_t *p, uint8_t pin, uint8_t value)
 {
 	uint8_t port;
diff --git a/drivers/net/ntnic/nthw/nthw_drv.h b/drivers/net/ntnic/nthw/nthw_drv.h
index ecd3bb9cc4..574dd663ea 100644
--- a/drivers/net/ntnic/nthw/nthw_drv.h
+++ b/drivers/net/ntnic/nthw/nthw_drv.h
@@ -24,6 +24,7 @@
 typedef struct nthw_agx_s {
 	nthw_i2cm_t *p_i2cm;
 	nthw_pca9849_t *p_pca9849;
+	nthw_pcal6416a_t *p_io_ts;	/* PCAL6416A I/O expander for controlling TS */
 	nthw_pcal6416a_t *p_io_nim;	/* PCAL6416A I/O expander for controlling TS */
 	nthw_pca9532_t *p_pca9532_led;
 	nthw_si5332_t *p_si5332;
-- 
2.45.0

