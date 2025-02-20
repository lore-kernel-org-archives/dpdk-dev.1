Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B6ABC021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:06:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D393140E18;
	Thu, 20 Feb 2025 23:04:39 +0100 (CET)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id EB1C340DD1
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:30 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02lp2232.outbound.protection.outlook.com [104.47.11.232]) by
 mx-outbound46-229.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MiGZ9AoFOH3SyoJKkuASVQsY3YmRFU82FXzsILB6qXLlvqi09ng5xNCemlKff8IeEzcQKXrEbp1rxFusNEC3PekKYkakg8s2AJ06dq8YjQuAeSOmdMnPAI8VOEGqBU5/E8/i0OyLo6LmmXHFGutlTfXZUOo7gMlaAqqo4WE2LLwGvC4WBYBwuEo875yL8o3UH7DlR4HKiYaCLTbg3HnpgPS9eC/BytP5yEJEtk/R+6ENB4M9NuQqqWlioQw6idtjoCsDjNdCtwwITIHsFdZE5ZcvbAuOaaRKCkNMyXwHU8W/SlBc2iQOIUEdt9gXwZthExtnIZcKL1gIa2e5Qz9iRA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gWWdVPz+SR/CpyqqiKpF9v7RUN17Ngmazg4b+FMd+Ng=;
 b=CEunpnMy/8w4fOSeGhbCbfZmzncByyY/rKqqHI6o1sjECMc1efEVt/eqNbV+SeN8M6e/rw5W0cFGiPWPpp3X2n2lG+HO/opi6KpF0ptYa6+cfB2sxr1OK2qrYaFgiEotdejB7Bmo5iMcZqXY9d4o/4S/siUoWtwBOkmeNvB1C7CJLLfsf/i4m7QI3EJuqOsATobP+8baxOAog3Hq3G/eKea3PbgYtAg8wsJ2DIsls+NNTO1u3+iYwmGdw7fGKzvFXBYXqcGhnkt9VP2CN2b207xOQRILOOejAbB4lGPGuLy8AyBLqfxEu1kQAzkA03X6WlDfk/O/7Y6QJT2ZouZ4Bg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gWWdVPz+SR/CpyqqiKpF9v7RUN17Ngmazg4b+FMd+Ng=;
 b=BhCiXFSZdZqHh2JdOGlWkUaCTGoIdLWfZHtumn/zV1xJaJx8d7sVNwSYIroGlzYV7d1UTOvaHqmwO35O0DIYrS0Cxt8XW9WyEb0oDJGkhiPR4Uu0EFDTI10NAO8ThKTikQm61SNJXJO5IUBWAzmM1+vJ+u8GWnV5U+Wnz/wncsk=
Received: from CWLP265CA0499.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::18)
 by PR3P190MB0844.EURP190.PROD.OUTLOOK.COM (2603:10a6:102:88::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 22:04:27 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::c1) by CWLP265CA0499.outlook.office365.com
 (2603:10a6:400:18b::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 22:04:27 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:27 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 20/32] net/ntnic: add clock init
Date: Thu, 20 Feb 2025 23:03:44 +0100
Message-ID: <20250220220406.3925597-21-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|PR3P190MB0844:EE_
X-MS-Office365-Filtering-Correlation-Id: b0066d06-478f-4244-21fe-08dd51fa8b59
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?aEZCbTZUKzJsQldhNzY1MzJMK1F0WXR0VEFnMThiSStneGNlNjV3bERpWERG?=
 =?utf-8?B?dk9tUlpWOW40em9GcWtTN0k3QmMyNFFHRXBPbU5yOS93K1ZzdHN1QlZPMnN2?=
 =?utf-8?B?UDU1Nk5aOTVid1pkN0t6YkFQaWw1TVI3ZHFmalhuQUJFNi9VNHFiSlc3L0lt?=
 =?utf-8?B?Wm5KZXc0UUR5L2t5KytGYmFQb2lUN0RGbC9DMEh5L1k1eVNuaGJUbVNxR2Ry?=
 =?utf-8?B?SGtEMXAwYXc1dVZQL21JTTJUWnpYME5DZzZFTzRIUkVQYy9ZbmN1VVVtb2V2?=
 =?utf-8?B?VC96UVpLZTZvT2pBcXZXczVCd0YyQ2wyZ2hCZFRJYzc4R1VadzhlOUsyUi8z?=
 =?utf-8?B?VjJ5RnJ5YWUwLzdNb0lYWmJOWk1EZk42VVNmV255N0RqOVNKTCsweGN0Mk5D?=
 =?utf-8?B?ajlIY2tSdzAwREI4aFhzNDdkSWF4RFA2dWJRbi9KMEplNFBSNURmbmxycmlp?=
 =?utf-8?B?QWhZWERFejdEL0ZWVjdDcUlMM2Z4MHZFcjBjT21obUZYYXBBVTFkWlZ0N2xF?=
 =?utf-8?B?dGcwdTNhOGVmSkJUSnYvUSs5cGREblFHb1dhNmVxNXY4cVdQUjZIVk1KY29y?=
 =?utf-8?B?YzVJRitabFNLVU5XODJyUjY0aTdsK2ozTjJTNG53bUdJeUM5ck9MUUdCeFBv?=
 =?utf-8?B?Smd4NXc3VTU0cVB5bWJ1ZmgrNzVGRkxVZ2J6c1drVFVMS0NFUXZ3aTVnd0M4?=
 =?utf-8?B?VytVNXdXZE1oK25MaFpDcHlZRTNPbWtNYUJ0RzBMTVIySDFKT0pjUTZobFdJ?=
 =?utf-8?B?a29KOWs5Zmtaekhob3p1d1JXVjhhNkR5em5uQyszOVBTa2NwQWFOVEluNTRK?=
 =?utf-8?B?RVZJZXk5bTVEeVlncEhnYWdPNk96R1JkM0JWR0MxZ0UzSExvTVBmMjYzbE1X?=
 =?utf-8?B?Q3lIS2hrN0Yxekc5cENZRXoxbEJyWkYvbmk3bWI5RmJZOXNTdk96blRtQmtk?=
 =?utf-8?B?U0YrdnB4cDRMaHFuaGhnMkJ4U2dJLzFaRkkwa1dqclA0dUd5UjJFN1Jtckk2?=
 =?utf-8?B?YUFUYTh2eGo3d0l4bWxSTWxSSms2UWs4YkRZVkVuSXo4R3Q0djBvWGFKM29y?=
 =?utf-8?B?NUpiNFFVY2F2QmhIK2l1clB0d0JLbEkvVks0S1draDRFK2lUaDRsL3Y1S2ZP?=
 =?utf-8?B?MUF1QktWTlZmdmJTQXR5MjI3N2xCelVIQno4bUlrR2xOS3hkSk5FZkY3NFB3?=
 =?utf-8?B?R2grMzhzQ1VvOHdNTmxYOXhnNzlwOERnakRSUy9WK0NnRGRVSmtZMFlXWmF1?=
 =?utf-8?B?RVBGbHYvZmtBL3l2MFh2RDR4OVVGRFdRc2QyZUJSTnRrN1NIY0tkUlRHaGIr?=
 =?utf-8?B?RXc3c1dyMVJQVUFtV3M1dE1CYWMvTmVYVW1vY1JjUlB0bFNZL0pGVWxGMHl4?=
 =?utf-8?B?U2NxZ3RBeGNSTE15ZkFhd3ROUUk0WjJkM1U4TDcxYUk2UEVISmtZMGtsMVE0?=
 =?utf-8?B?UjdjOXFxRlZYOWV2L0RoTldZdlk3amo1ZDU1N3hNVE5oS01zUm5rVFBVMDg3?=
 =?utf-8?B?S1UxQStPUkNCN1NVNnRpdlRCNVdadFN4WGlEdUtqTTN0NTFVNDJRT2tBM0pK?=
 =?utf-8?B?VzVuYkFNc3JQOXhPL1ZjQi9udERYeTZXaG9WK1FpU1FHSmlQZmNmU3c5bjB0?=
 =?utf-8?B?NG1UZitDbEhIMHRTZ25hUlFvNWR3dkhJQzc5UHV0WXlsOXEyamhnSENjUitt?=
 =?utf-8?B?YUxzcmNZeERvdXRvV0NvOVV0VWQ1QTV2dVZtNGFhOVN4LzBVbjBPWXJXYnd5?=
 =?utf-8?B?VkpQdkJPakRhN2s1czdSMW81NXNhL3p1UU1RMm1iSUxOZHJtby9Nb2p6VmQ2?=
 =?utf-8?B?VXJWZG9ob01lYUNDbzZtNUFJbjdQSGtmLzVsMmRTd2NmelJweEpBTmRHN3pj?=
 =?utf-8?B?akwxbVUwTzI4ZFlTQmlPOUxiMXlMcWtYMmMzbnFXVmNKWnJHay9pc2doSHRZ?=
 =?utf-8?B?L05LNjdJSTN4Rk9mTnFrQWNrMHZPbFY4Smk3eER3MU5TSEZuUDNpTnVBekxn?=
 =?utf-8?Q?a494mMiT+C5fBjJf+jRBy5+9DeGqhE=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oqDSldTvn5+8+6soUffnmOhOgqjHLt0TseiFPGa1lRZx9zw7TTRdVcEIX+VwKNVLyEMvZhtl/WuSHZFAFFI8iPVlUZlts0IOnJECk0H+U+3XXUJDVZjgAjdqmMEK7crRiqgG9gR3hoqL524lrKpnbQswnUrbWAUPyEbghxttwqAwHy6RcLPLZ41JZBvI5k8g7acThH9r5IFhl+0PURu0919UfIPUvWI8JXA8W8IQH2ixCX3sFlB6o3Mb9sGgU7zxITw7mu+ZIh11YKDQER628KiXOgqtk1tnChPu+8G+K+KyB7QldGfCffbGyqzU3eP2gCMZkOQSg+pCrfCgjcBQE1bPDOe/OQ0uBz3OwssR6z979BNxQzb6TfDNrzSOybWc7bMpnfO/uKK1hilfZM1sxOL5PYPF1za6raKheM30AsS/hwyuTNgSZ16gSaesG4/NS8JgK80Rn4yZyN26/0p7uRs7txhwrLq54JVz5LTA8RtVMzPuAC51gmLDqRgR5qm9sLfVx5g6VnnxZxuuFL96FHBy0glJlAmljmn1K5uGUrsjvtp78P/dSI5Z9KyfnuaNCcJd18orUMW74b5qVdmY94Q2miDDqL0JMLvVn6BZtuLR9VQbSduTiWVGasToFL/Ve2YsSsRXjMoA7OsTemsIWKHyIpr/ex62Q9gHdfQoXvw=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:27.6932 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b0066d06-478f-4244-21fe-08dd51fa8b59
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3P190MB0844
X-BESS-ID: 1740089069-312005-29069-14096-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.11.232
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVsYGhpZGQGYGUNQgLSk50SjNzC
 jN1DzV3MIsOckgzdIwLdnE2DQtNdncQqk2FgDZ4haEQgAAAA==
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262653 [from 
 cloudscan10-185.eu-central-1a.ess.aws.cudaops.com]
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

Add initialization for the clock subsystem

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 ...00D13_U62_Si5332-GM2-RevD-1_V5-Registers.h | 425 ++++++++++++++++++
 .../net/ntnic/nthw/core/include/nthw_i2cm.h   |   1 +
 .../nthw/core/include/nthw_pcm_nt400dxx.h     |  14 +
 .../nthw/core/include/nthw_si5332_si5156.h    |  36 ++
 .../nthw/core/nt400dxx/nthw_fpga_nt400dxx.c   | 115 ++++-
 drivers/net/ntnic/nthw/core/nthw_i2cm.c       |  57 +++
 .../net/ntnic/nthw/core/nthw_si5332_si5156.c  |  93 ++++
 drivers/net/ntnic/nthw/nthw_drv.h             |   7 +-
 8 files changed, 745 insertions(+), 3 deletions(-)
 create mode 100644 drivers/net/ntnic/nthw/core/include/NT400D13_U62_Si5332-GM2-RevD-1_V5-Registers.h
 create mode 100644 drivers/net/ntnic/nthw/core/include/nthw_pcm_nt400dxx.h

diff --git a/drivers/net/ntnic/nthw/core/include/NT400D13_U62_Si5332-GM2-RevD-1_V5-Registers.h b/drivers/net/ntnic/nthw/core/include/NT400D13_U62_Si5332-GM2-RevD-1_V5-Registers.h
new file mode 100644
index 0000000000..f87828fcfe
--- /dev/null
+++ b/drivers/net/ntnic/nthw/core/include/NT400D13_U62_Si5332-GM2-RevD-1_V5-Registers.h
@@ -0,0 +1,425 @@
+/*
+ * Si5332-GM2 Rev D Configuration Register Export Header File
+ *
+ * This file represents a series of Skyworks Si5332-GM2 Rev D
+ * register writes that can be performed to load a single configuration
+ * on a device. It was created by a Skyworks ClockBuilder Pro
+ * export tool.
+ *
+ * Part:		                                       Si5332-GM2 Rev D
+ * Design ID:                                          1
+ * Includes Pre/Post Download Control Register Writes: Yes
+ * Created By:                                         ClockBuilder Pro v4.5 [2022-08-23]
+ * Timestamp:                                          2022-10-11 15:44:24 GMT+02:00
+ *
+ * A complete design report corresponding to this export is included at the end
+ * of this header file.
+ *
+ */
+
+#ifndef SI5332_GM2_REVD_REG_CONFIG_HEADER
+#define SI5332_GM2_REVD_REG_CONFIG_HEADER
+
+#define SI5332_GM2_REVD_REG_CONFIG_NUM_REGS 76
+
+typedef struct {
+	unsigned int address;	/* 8-bit register address */
+	unsigned char value;	/* 8-bit register data */
+
+} si5332_gm2_revd_register_t;
+
+si5332_gm2_revd_register_t const si5332_gm2_revd_registers[SI5332_GM2_REVD_REG_CONFIG_NUM_REGS] = {
+	/* Start configuration preamble */
+	/*    Set device in Ready mode */
+	{ 0x0006, 0x01 },
+	/* End configuration preamble */
+
+	/* Start configuration registers */
+	{ 0x0017, 0x31 },
+	{ 0x0018, 0x00 },
+	{ 0x0019, 0x00 },
+	{ 0x001A, 0x00 },
+	{ 0x001B, 0x00 },
+	{ 0x001C, 0x00 },
+	{ 0x0021, 0x6A },
+	{ 0x0024, 0x01 },
+	{ 0x0025, 0x00 },
+	{ 0x0026, 0x00 },
+	{ 0x0027, 0x50 },
+	{ 0x0028, 0x50 },
+	{ 0x0029, 0x00 },
+	{ 0x002A, 0x00 },
+	{ 0x002B, 0x10 },
+	{ 0x0036, 0x07 },
+	{ 0x0037, 0x80 },
+	{ 0x0038, 0x02 },
+	{ 0x0039, 0x80 },
+	{ 0x003A, 0x05 },
+	{ 0x003B, 0x35 },
+	{ 0x003C, 0x00 },
+	{ 0x0048, 0x00 },
+	{ 0x0054, 0x00 },
+	{ 0x0060, 0x00 },
+	{ 0x0067, 0x19 },
+	{ 0x0068, 0x00 },
+	{ 0x0069, 0x00 },
+	{ 0x006A, 0x00 },
+	{ 0x006B, 0x00 },
+	{ 0x006C, 0x01 },
+	{ 0x0073, 0x00 },
+	{ 0x0074, 0x00 },
+	{ 0x0075, 0x01 },
+	{ 0x007A, 0x07 },
+	{ 0x007B, 0x01 },
+	{ 0x007C, 0x00 },
+	{ 0x007D, 0x00 },
+	{ 0x007F, 0x07 },
+	{ 0x0080, 0x01 },
+	{ 0x0081, 0x00 },
+	{ 0x0082, 0x00 },
+	{ 0x0089, 0x07 },
+	{ 0x008A, 0x01 },
+	{ 0x008B, 0x00 },
+	{ 0x008C, 0x00 },
+	{ 0x008E, 0x07 },
+	{ 0x008F, 0x01 },
+	{ 0x0090, 0x00 },
+	{ 0x0091, 0x00 },
+	{ 0x0098, 0x07 },
+	{ 0x0099, 0x01 },
+	{ 0x009A, 0x00 },
+	{ 0x009B, 0x00 },
+	{ 0x009D, 0x07 },
+	{ 0x009E, 0x01 },
+	{ 0x009F, 0x00 },
+	{ 0x00A0, 0x00 },
+	{ 0x00A7, 0x07 },
+	{ 0x00A8, 0x01 },
+	{ 0x00A9, 0x00 },
+	{ 0x00AA, 0x00 },
+	{ 0x00AC, 0x07 },
+	{ 0x00AD, 0x01 },
+	{ 0x00AE, 0x00 },
+	{ 0x00AF, 0x00 },
+	{ 0x00B6, 0xDB },
+	{ 0x00B7, 0x06 },
+	{ 0x00B9, 0x06 },
+	{ 0x00BA, 0x5E },
+	{ 0x00BB, 0x00 },
+	{ 0x00BC, 0x00 },
+	{ 0x00BD, 0x00 },
+	{ 0x00BE, 0x20 },
+	/* End configuration registers */
+
+	/* Start configuration postamble */
+	/*    Set device in Active mode */
+	{ 0x0006, 0x02 },
+	/* End configuration postamble */
+};
+
+/*
+ * Design Report
+ *
+ * Overview
+ * ========
+ * Part:               Si5332EFL Rev D
+ * Project File:       P:\Hardware\NT
+ * Adapters\NT400D13\design\Clock_syn_design\Si5332-GM2-RevD-1-Project_V5.slabtimeproj Design ID: 1
+ * Created By:         ClockBuilder Pro v4.5 [2022-08-23]
+ * Timestamp:          2022-10-11 15:44:24 GMT+02:00
+ *
+ * Design Rule Check
+ * =================
+ * Errors:
+ * - No errors
+ *
+ * Warnings:
+ * - OUT1 [156.25 MHz] and OUT2 [166.625 MHz] may have coupling [1]
+ * - OUT5 [166.625 MHz] and OUT6 [156.25 MHz] may have coupling [1]
+ *
+ * Footnotes:
+ * [1] To avoid coupling in outputs, Skyworks recommends the following:
+ *
+ * - Avoid adjacent frequency values that are close. CBPro uses an output's integration bandwidth
+ *   (IBW) to determine whether two adjacent frequencies are too close. An IBW of 20 MHz is used
+ *   for frequencies 80 MHz and larger. Lower frequencies will use IBW of OUT/4. CBPro will flag
+ *   fundamental coupling and coupling up to the fourth harmonic, where coupling
+ *   frequency = Absolute(OUTa*x - OUTb*y) for all combinations of x and y 1 through 4. If any one
+ *   of these values is less than or equal to the IBW, the output is flagged as having possible
+ *   coupling.
+ * - Adjacent frequency values that are integer multiples of one another are okay and these
+ *   outputs should be grouped accordingly.
+ * - Unused outputs can be used to separate clock outputs that might otherwise interfere
+ *   with one another.
+ *
+ * Skyworks recommends you validate your design's jitter performance using an Evaluation Board.
+ * You can request a custom phase noise report for your design from CBPro's design dashboard.
+ *
+ * Device Grade
+ * ============
+ * Maximum Output Frequency: 166.625 MHz
+ * Frequency Synthesis Mode: Fractional
+ * Frequency Plan Grade:     F
+ * Minimum Base OPN:         Si5332F*
+ *
+ * Base       Output Clock         Supported Frequency Synthesis Modes
+ * OPN Grade  Frequency Range      (Typical Jitter)
+ * ---------  ------------------  --------------------------------------------
+ * Si5332E    5 MHz to 334 MHz    Integer (~230 fs) and fractional (~500 fs)
+ * Si5332F*   5 MHz to 200 MHz    "
+ * Si5332G    5 MHz to 334 MHz    Integer only (~230 fs)
+ * Si5332H    5 MHz to 200 MHz    "
+ * Si5332L*   5 MHz to 334 MHz    Integer (~230 fs) and fractional (~500 fs)
+ *
+ * * Based on your calculated frequency plan, a Si5332F grade device is
+ * sufficient for your design. For more in-system configuration flexibility
+ * (higher frequencies and/or to enable fractional synthesis), consider
+ * selecting device grade Si5332E when specifying an ordering part number (OPN)
+ * for your application. See the datasheet Ordering Guide for more information.
+ *
+ * Design
+ * ======
+ * Base I2C Address: 0x6A
+ *
+ * Universal Hardware Input Pins:
+ *    INPUT1 (P10): None
+ *    INPUT2 (P19): None
+ *    INPUT3 (P20): None
+ *    INPUT4 (P31): None
+ *    INPUT5 (P32): None
+ *    INPUT6 (P36): None
+ *    INPUT7 (P37): None
+ *
+ * Inputs:
+ *    XAXB: 50 MHz
+ *          Crystal Mode
+ *  CLKIN2: Unused
+ *  CLKIN3: Unused
+ *
+ * Outputs:
+ *    OUT0: 156.25 MHz LVDS Fast 1.8 V, Disabled-State: Stop Low
+ *          Power-up state: Enabled
+ *    OUT1: 156.25 MHz LVDS Fast 1.8 V, Disabled-State: Stop Low
+ *          Power-up state: Enabled
+ *    OUT2: 166.625 MHz LVDS Fast 1.8 V, Disabled-State: Stop Low
+ *          Power-up state: Enabled
+ *    OUT3: 166.625 MHz LVDS Fast 1.8 V, Disabled-State: Stop Low
+ *          Power-up state: Enabled
+ *    OUT4: 166.625 MHz LVDS Fast 1.8 V, Disabled-State: Stop Low
+ *          Power-up state: Enabled
+ *    OUT5: 166.625 MHz LVDS Fast 1.8 V, Disabled-State: Stop Low
+ *          Power-up state: Enabled
+ *    OUT6: 156.25 MHz LVDS Fast 1.8 V, Disabled-State: Stop Low
+ *          Power-up state: Enabled
+ *    OUT7: 156.25 MHz LVDS Fast 1.8 V, Disabled-State: Stop Low
+ *          Power-up state: Enabled
+ *
+ * Frequency Plan
+ * ==============
+ * Fpfd = 50 MHz
+ * Fvco = 2.5 GHz
+ *
+ * P divider = 1
+ * M = 50
+ * N dividers:
+ *    N0:
+ *       Value: 15.0037509377344336... [ 15 + 5/1333 ]
+ *       OUT2: 166.625 MHz, Error: 0 ppm
+ *       OUT3: 166.625 MHz, Error: 0 ppm
+ *       OUT4: 166.625 MHz, Error: 0 ppm
+ *       OUT5: 166.625 MHz, Error: 0 ppm
+ *    N1:
+ *       Unused
+ *
+ * O dividers:
+ *    O0:
+ *       Value: 16
+ *       OUT0: 156.25 MHz, Error: 0 ppm
+ *       OUT1: 156.25 MHz, Error: 0 ppm
+ *       OUT6: 156.25 MHz, Error: 0 ppm
+ *       OUT7: 156.25 MHz, Error: 0 ppm
+ *    O1:
+ *       Unused
+ *    O2:
+ *       Unused
+ *    O3:
+ *       Unused
+ *    O4:
+ *       Unused
+ *
+ * R dividers:
+ *    R0 = 1
+ *    R1 = 1
+ *    R2 = 1
+ *    R3 = 1
+ *    R4 = 1
+ *    R5 = 1
+ *    R6 = 1
+ *    R7 = 1
+ *
+ * Estimated Power
+ * ===============
+ * Total Power: 233 mW, On Chip Power: 220 mW, Tj: 31 °C
+ *
+ *                    Frequency    Format   Voltage   Current     Power
+ *                  -----------  --------  --------  --------  --------
+ * VDD                                        1.8 V   30.7 mA     55 mW
+ * VDD Dig                                    1.8 V    7.0 mA     13 mW
+ * VDD Xtal                                   1.8 V    2.3 mA      4 mW
+ * VDDO0
+ *            OUT0   156.25 MHz  LVDSFast     1.8 V   11.1 mA     20 mW
+ * VDDO1
+ *            OUT1   156.25 MHz  LVDSFast     1.8 V   11.1 mA     20 mW
+ * VDDO2
+ *            OUT2  166.625 MHz  LVDSFast     1.8 V   11.2 mA     20 mW
+ *            OUT3  166.625 MHz  LVDSFast     1.8 V   11.2 mA     20 mW
+ * VDDO3
+ *            OUT4  166.625 MHz  LVDSFast     1.8 V   11.2 mA     20 mW
+ *            OUT5  166.625 MHz  LVDSFast     1.8 V   11.2 mA     20 mW
+ * VDDO4
+ *            OUT6   156.25 MHz  LVDSFast     1.8 V   11.1 mA     20 mW
+ * VDDO5
+ *            OUT7   156.25 MHz  LVDSFast     1.8 V   11.1 mA     20 mW
+ *                                                   --------  --------
+ *                                            Total  129.4 mA    233 mW
+ *
+ * Note:
+ *
+ * -Tj is junction temperature. Tj must be less than 125 °C (on Si5332-GM2 Revision D) for device
+ *  to comply with datasheet specifications. Tj = Ta + Theta_JA*On_Chip_Power.
+ * -Overall power includes on-chip power dissipation and adds differential load power dissipation
+ *  to estimate total power requirements.
+ * -Above are estimates only: power and temperature should be measured on your PCB.
+ *
+ * Settings
+ * ========
+ *
+ * Location    Setting Name     Decimal Value      Hex Value
+ * ----------  ---------------  -----------------  -----------------
+ * 0x17[7:0]   DESIGN_ID0       49                 0x31
+ * 0x18[7:0]   DESIGN_ID1       0                  0x00
+ * 0x19[7:0]   DESIGN_ID2       0                  0x00
+ * 0x1A[7:0]   DESIGN_ID3       0                  0x00
+ * 0x1B[7:0]   DESIGN_ID4       0                  0x00
+ * 0x1C[7:0]   DESIGN_ID5       0                  0x00
+ * 0x21[6:0]   I2C_ADDR         106                0x6A
+ * 0x24[1:0]   IMUX_SEL         1                  0x1
+ * 0x25[1:0]   OMUX0_SEL0       0                  0x0
+ * 0x25[6:4]   OMUX0_SEL1       0                  0x0
+ * 0x26[1:0]   OMUX1_SEL0       0                  0x0
+ * 0x26[6:4]   OMUX1_SEL1       0                  0x0
+ * 0x27[1:0]   OMUX2_SEL0       0                  0x0
+ * 0x27[6:4]   OMUX2_SEL1       5                  0x5
+ * 0x28[1:0]   OMUX3_SEL0       0                  0x0
+ * 0x28[6:4]   OMUX3_SEL1       5                  0x5
+ * 0x29[1:0]   OMUX4_SEL0       0                  0x0
+ * 0x29[6:4]   OMUX4_SEL1       0                  0x0
+ * 0x2A[1:0]   OMUX5_SEL0       0                  0x0
+ * 0x2A[6:4]   OMUX5_SEL1       0                  0x0
+ * 0x2B[7:0]   HSDIV0A_DIV      16                 0x10
+ * 0x36[14:0]  ID0A_INTG        1920               0x0780
+ * 0x38[14:0]  ID0A_RES         640                0x0280
+ * 0x3A[14:0]  ID0A_DEN         1333               0x0535
+ * 0x3C[0]     ID0A_SS_ENA      0                  0x0
+ * 0x3C[2:1]   ID0A_SS_MODE     0                  0x0
+ * 0x48[0]     ID0B_SS_ENA      0                  0x0
+ * 0x48[2:1]   ID0B_SS_MODE     0                  0x0
+ * 0x54[0]     ID1A_SS_ENA      0                  0x0
+ * 0x54[2:1]   ID1A_SS_MODE     0                  0x0
+ * 0x60[0]     ID1B_SS_ENA      0                  0x0
+ * 0x60[2:1]   ID1B_SS_MODE     0                  0x0
+ * 0x67[14:0]  IDPA_INTG        6400               0x1900
+ * 0x69[14:0]  IDPA_RES         0                  0x0000
+ * 0x6B[14:0]  IDPA_DEN         1                  0x0001
+ * 0x73[1:0]   CLKIN_2_CLK_SEL  0                  0x0
+ * 0x74[1:0]   CLKIN_3_CLK_SEL  0                  0x0
+ * 0x75[4:0]   P_VAL            1                  0x01
+ * 0x7A[3:0]   OUT0_MODE        7                  0x7
+ * 0x7B[5:0]   OUT0_DIV         1                  0x01
+ * 0x7C[2:0]   OUT0_SKEW        0                  0x0
+ * 0x7D[0]     OUT0_STOP_HIGHZ  0                  0x0
+ * 0x7D[5:4]   OUT0_CMOS_INV    0                  0x0
+ * 0x7D[6]     OUT0_DIFF_INV    0                  0x0
+ * 0x7F[3:0]   OUT1_MODE        7                  0x7
+ * 0x80[5:0]   OUT1_DIV         1                  0x01
+ * 0x81[2:0]   OUT1_SKEW        0                  0x0
+ * 0x82[0]     OUT1_STOP_HIGHZ  0                  0x0
+ * 0x82[5:4]   OUT1_CMOS_INV    0                  0x0
+ * 0x82[6]     OUT1_DIFF_INV    0                  0x0
+ * 0x89[3:0]   OUT2_MODE        7                  0x7
+ * 0x8A[5:0]   OUT2_DIV         1                  0x01
+ * 0x8B[2:0]   OUT2_SKEW        0                  0x0
+ * 0x8C[0]     OUT2_STOP_HIGHZ  0                  0x0
+ * 0x8C[5:4]   OUT2_CMOS_INV    0                  0x0
+ * 0x8C[6]     OUT2_DIFF_INV    0                  0x0
+ * 0x8E[3:0]   OUT3_MODE        7                  0x7
+ * 0x8F[5:0]   OUT3_DIV         1                  0x01
+ * 0x90[2:0]   OUT3_SKEW        0                  0x0
+ * 0x91[0]     OUT3_STOP_HIGHZ  0                  0x0
+ * 0x91[5:4]   OUT3_CMOS_INV    0                  0x0
+ * 0x91[6]     OUT3_DIFF_INV    0                  0x0
+ * 0x98[3:0]   OUT4_MODE        7                  0x7
+ * 0x99[5:0]   OUT4_DIV         1                  0x01
+ * 0x9A[2:0]   OUT4_SKEW        0                  0x0
+ * 0x9B[0]     OUT4_STOP_HIGHZ  0                  0x0
+ * 0x9B[5:4]   OUT4_CMOS_INV    0                  0x0
+ * 0x9B[6]     OUT4_DIFF_INV    0                  0x0
+ * 0x9D[3:0]   OUT5_MODE        7                  0x7
+ * 0x9E[5:0]   OUT5_DIV         1                  0x01
+ * 0x9F[2:0]   OUT5_SKEW        0                  0x0
+ * 0xA0[0]     OUT5_STOP_HIGHZ  0                  0x0
+ * 0xA0[5:4]   OUT5_CMOS_INV    0                  0x0
+ * 0xA0[6]     OUT5_DIFF_INV    0                  0x0
+ * 0xA7[3:0]   OUT6_MODE        7                  0x7
+ * 0xA8[5:0]   OUT6_DIV         1                  0x01
+ * 0xA9[2:0]   OUT6_SKEW        0                  0x0
+ * 0xAA[0]     OUT6_STOP_HIGHZ  0                  0x0
+ * 0xAA[5:4]   OUT6_CMOS_INV    0                  0x0
+ * 0xAA[6]     OUT6_DIFF_INV    0                  0x0
+ * 0xAC[3:0]   OUT7_MODE        7                  0x7
+ * 0xAD[5:0]   OUT7_DIV         1                  0x01
+ * 0xAE[2:0]   OUT7_SKEW        0                  0x0
+ * 0xAF[0]     OUT7_STOP_HIGHZ  0                  0x0
+ * 0xAF[5:4]   OUT7_CMOS_INV    0                  0x0
+ * 0xAF[6]     OUT7_DIFF_INV    0                  0x0
+ * 0xB6[0]     OUT0_OE          1                  0x1
+ * 0xB6[1]     OUT1_OE          1                  0x1
+ * 0xB6[3]     OUT2_OE          1                  0x1
+ * 0xB6[4]     OUT3_OE          1                  0x1
+ * 0xB6[6]     OUT4_OE          1                  0x1
+ * 0xB6[7]     OUT5_OE          1                  0x1
+ * 0xB7[1]     OUT6_OE          1                  0x1
+ * 0xB7[2]     OUT7_OE          1                  0x1
+ * 0xB9[0]     XOSC_DIS         0                  0x0
+ * 0xB9[1]     IBUF0_DIS        1                  0x1
+ * 0xB9[2]     IBUF1_DIS        1                  0x1
+ * 0xB9[3]     IMUX_DIS         0                  0x0
+ * 0xB9[4]     PDIV_DIS         0                  0x0
+ * 0xB9[5]     PLL_DIS          0                  0x0
+ * 0xBA[5]     ID0_DIS          0                  0x0
+ * 0xBA[6]     ID1_DIS          1                  0x1
+ * 0xBA[0]     HSDIV0_DIS       0                  0x0
+ * 0xBA[1]     HSDIV1_DIS       1                  0x1
+ * 0xBA[2]     HSDIV2_DIS       1                  0x1
+ * 0xBA[3]     HSDIV3_DIS       1                  0x1
+ * 0xBA[4]     HSDIV4_DIS       1                  0x1
+ * 0xBB[0]     OMUX0_DIS        0                  0x0
+ * 0xBB[1]     OMUX1_DIS        0                  0x0
+ * 0xBB[2]     OMUX2_DIS        0                  0x0
+ * 0xBB[3]     OMUX3_DIS        0                  0x0
+ * 0xBB[4]     OMUX4_DIS        0                  0x0
+ * 0xBB[5]     OMUX5_DIS        0                  0x0
+ * 0xBC[0]     OUT0_DIS         0                  0x0
+ * 0xBC[1]     OUT1_DIS         0                  0x0
+ * 0xBC[3]     OUT2_DIS         0                  0x0
+ * 0xBC[4]     OUT3_DIS         0                  0x0
+ * 0xBC[6]     OUT4_DIS         0                  0x0
+ * 0xBC[7]     OUT5_DIS         0                  0x0
+ * 0xBD[1]     OUT6_DIS         0                  0x0
+ * 0xBD[2]     OUT7_DIS         0                  0x0
+ * 0xBE[7:0]   PLL_MODE         32                 0x20
+ *
+ *
+ */
+
+#endif
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_i2cm.h b/drivers/net/ntnic/nthw/core/include/nthw_i2cm.h
index eeb4dffe25..53aa3c018e 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_i2cm.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_i2cm.h
@@ -46,5 +46,6 @@ typedef struct nt_i2cm nthw_i2cm_t;
 
 int nthw_i2cm_read(nthw_i2cm_t *p, uint8_t dev_addr, uint8_t reg_addr, uint8_t *value);
 int nthw_i2cm_write(nthw_i2cm_t *p, uint8_t dev_addr, uint8_t reg_addr, uint8_t value);
+int nthw_i2cm_write16(nthw_i2cm_t *p, uint8_t dev_addr, uint8_t reg_addr, uint16_t value);
 
 #endif	/* __NTHW_II2CM_H__ */
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_pcm_nt400dxx.h b/drivers/net/ntnic/nthw/core/include/nthw_pcm_nt400dxx.h
new file mode 100644
index 0000000000..1e114886ca
--- /dev/null
+++ b/drivers/net/ntnic/nthw/core/include/nthw_pcm_nt400dxx.h
@@ -0,0 +1,14 @@
+/*
+ * SPDX-License-Identifier: BSD-3-Clause
+ * Copyright(c) 2023 Napatech A/S
+ */
+#ifndef __NTHW_PCM_NT400DXX_H__
+#define __NTHW_PCM_NT400DXX_H__
+
+struct nthw_pcm_nt400_dxx {
+	int mn_module_minor_version;
+};
+
+typedef struct nthw_pcm_nt400_dxx nthw_pcm_nt400dxx_t;
+
+#endif  /* __NTHW_PCM_NT400DXX_H__ */
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_si5332_si5156.h b/drivers/net/ntnic/nthw/core/include/nthw_si5332_si5156.h
index 968d7eb74a..753717ba8a 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_si5332_si5156.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_si5332_si5156.h
@@ -21,4 +21,40 @@ typedef struct nthw_pca9849 nthw_pca9849_t;
 
 int nthw_pca9849_set_channel(nthw_pca9849_t *p, uint8_t channel);
 
+/*
+ * Si5332 clock synthesizer
+ */
+
+struct nthw_si5332 {
+	nthw_i2cm_t *mp_nt_i2cm;
+	uint8_t m_dev_address;
+	nthw_pca9849_t *mp_pca9849;
+	uint8_t m_mux_channel;
+};
+
+typedef struct nthw_si5332 nthw_si5332_t;
+
+nthw_si5332_t *nthw_si5332_new(void);
+int nthw_si5332_init(nthw_si5332_t *p, nthw_i2cm_t *p_nt_i2cm, uint8_t dev_address,
+	nthw_pca9849_t *pca9849, uint8_t mux_channel);
+bool nthw_si5332_clock_active(nthw_si5332_t *p);
+void nthw_si5332_write(nthw_si5332_t *p, uint8_t address, uint8_t value);
+
+/*
+ * Si5156 MEMS Super TCXO
+ */
+struct nthw_si5156 {
+	nthw_i2cm_t *mp_nt_i2cm;
+	uint8_t m_dev_address;
+	nthw_pca9849_t *mp_pca9849;
+	uint8_t m_mux_channel;
+};
+
+typedef struct nthw_si5156 nthw_si5156_t;
+
+nthw_si5156_t *nthw_si5156_new(void);
+int nthw_si5156_init(nthw_si5156_t *p, nthw_i2cm_t *p_nt_i2cm, uint8_t dev_address,
+	nthw_pca9849_t *pca9849, uint8_t mux_channel);
+int nthw_si5156_write16(nthw_si5156_t *p, uint8_t address, uint16_t value);
+
 #endif	/* __NTHW_SI5332_SI5156_H__ */
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
index 0a5add60e0..24118822c4 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/nthw_fpga_nt400dxx.c
@@ -2,10 +2,113 @@
  * SPDX-License-Identifier: BSD-3-Clause
  * Copyright(c) 2023 Napatech A/S
  */
-
+#include "ntlog.h"
 #include "nthw_fpga.h"
 #include "ntnic_mod_reg.h"
-#include "ntlog.h"
+#include "NT400D13_U62_Si5332-GM2-RevD-1_V5-Registers.h"
+
+static int nthw_fpga_nt400dxx_init_clock_synthesizers(struct fpga_info_s *p_fpga_info)
+{
+	const char *const p_adapter_id_str = p_fpga_info->mp_adapter_id_str;
+	int res = -1;
+
+	/* Clock synthesizer on address 0x6a on channel 2 */
+	p_fpga_info->mp_nthw_agx.p_si5332 = nthw_si5332_new();
+	res = nthw_si5332_init(p_fpga_info->mp_nthw_agx.p_si5332,
+			p_fpga_info->mp_nthw_agx.p_i2cm,
+			0x6A,
+			p_fpga_info->mp_nthw_agx.p_pca9849,
+			2);
+
+	if (res) {
+		NT_LOG(ERR, NTHW, "%s: %s: Failed to initialize Si5332 clock - res=%d",
+			p_adapter_id_str, __func__, res);
+		return res;
+	}
+
+	p_fpga_info->mp_nthw_agx.p_si5156 = nthw_si5156_new();
+	res = nthw_si5156_init(p_fpga_info->mp_nthw_agx.p_si5156,
+			p_fpga_info->mp_nthw_agx.p_i2cm,
+			0x60,
+			p_fpga_info->mp_nthw_agx.p_pca9849,
+			2);
+
+	if (res) {
+		NT_LOG(ERR, NTHW, "%s: %s: Failed to initialize Si5156 clock - res=%d",
+			p_adapter_id_str, __func__, res);
+		return res;
+	}
+
+	if (nthw_si5332_clock_active(p_fpga_info->mp_nthw_agx.p_si5332)) {
+		NT_LOG(INF,
+			NTHW,
+			"%s: Fpga clock already active, skipping clock initialisation.",
+			p_adapter_id_str);
+
+	} else {
+		NT_LOG(INF, NTHW,
+			"%s: Fpga clock not active, performing full clock initialisation.",
+			p_adapter_id_str);
+
+		for (int i = 0; i < SI5332_GM2_REVD_REG_CONFIG_NUM_REGS; i++) {
+			nthw_si5332_write(p_fpga_info->mp_nthw_agx.p_si5332,
+				(uint8_t)si5332_gm2_revd_registers[i].address,
+				(uint8_t)si5332_gm2_revd_registers[i].value);
+		}
+	}
+
+	/*
+	 * TCXO capable PCM version if minor version >= 3
+	 * Unfortunately, the module version is not readily
+	 * available in the FPGA_400D1x class.
+	 */
+	bool tcxo_capable = p_fpga_info->mp_nthw_agx.p_pcm->mn_module_minor_version >= 3;
+
+	/*
+	 * This method of determining the presence of a TCXO
+	 *  will only work until non SI5156 equipped boards
+	 *  use the vacant I2C address for something else...
+	 *
+	 * There's no other way, there's no other way
+	 * All that you can do is watch them play
+	 * Clean-up when GA HW is readily available
+	 */
+	if (nthw_si5156_write16(p_fpga_info->mp_nthw_agx.p_si5156, 0x1, 0x0400) != 0) {
+		p_fpga_info->mp_nthw_agx.tcxo_capable = false;
+		p_fpga_info->mp_nthw_agx.tcxo_present = false;
+
+	} else {
+		p_fpga_info->mp_nthw_agx.tcxo_capable = tcxo_capable;
+		p_fpga_info->mp_nthw_agx.tcxo_present = true;
+	}
+
+	return 0;
+}
+
+static int nthw_fpga_nt400dxx_init_sub_systems(struct fpga_info_s *p_fpga_info)
+{
+	int res;
+	NT_LOG(INF, NTHW, "%s: Initializing NT4GA subsystems...", p_fpga_info->mp_adapter_id_str);
+
+	/* RAB subsystem */
+	NT_LOG(DBG, NTHW, "%s: Initializing RAB subsystem: flush", p_fpga_info->mp_adapter_id_str);
+	res = nthw_rac_rab_flush(p_fpga_info->mp_nthw_rac);
+
+	if (res)
+		return res;
+
+	/* clock synthesizer subsystem */
+	NT_LOG(DBG,
+		NTHW,
+		"%s: Initializing clock synthesizer subsystem",
+		p_fpga_info->mp_adapter_id_str);
+	res = nthw_fpga_nt400dxx_init_clock_synthesizers(p_fpga_info);
+
+	if (res)
+		return res;
+
+	return 0;
+}
 
 static int nthw_fpga_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 {
@@ -61,6 +164,14 @@ static int nthw_fpga_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 		return res;
 	}
 
+	res = nthw_fpga_nt400dxx_init_sub_systems(p_fpga_info);
+
+	if (res) {
+		NT_LOG(ERR, NTHW, "%s: %s: FPGA=%04d Failed to init subsystems res=%d",
+		p_adapter_id_str, __func__, p_fpga_info->n_fpga_prod_id, res);
+		return res;
+	}
+
 	res = rst_nt400dxx_ops->nthw_fpga_rst_nt400dxx_reset(p_fpga_info);
 
 	if (res) {
diff --git a/drivers/net/ntnic/nthw/core/nthw_i2cm.c b/drivers/net/ntnic/nthw/core/nthw_i2cm.c
index b5f8e299ff..f7500b2e93 100644
--- a/drivers/net/ntnic/nthw/core/nthw_i2cm.c
+++ b/drivers/net/ntnic/nthw/core/nthw_i2cm.c
@@ -73,6 +73,47 @@ static int nthw_i2cm_write_internal(nthw_i2cm_t *p, uint8_t value)
 	return 0;
 }
 
+static int nthw_i2cm_write16_internal(nthw_i2cm_t *p, uint16_t value)
+{
+	const uint8_t count = 1;
+
+	for (int8_t i = count; i >= 0; i--) {
+		uint8_t byte_value = (uint8_t)(value >> ((uint8_t)i * 8)) & 0xffU;
+
+		/* Write data to data register */
+		nthw_field_set_val_flush32(p->mp_fld_data_data, byte_value);
+
+		if (i == 0) {
+			nthw_field_set_val_flush32(p->mp_fld_cmd_status_cmd_status,
+				NT_I2C_CMD_WR | NT_I2C_CMD_IRQ_ACK);
+
+		} else {
+			nthw_field_set_val_flush32(p->mp_fld_cmd_status_cmd_status, NT_I2C_CMD_WR);
+		}
+
+		if (!nthw_i2cm_ready(p, true)) {
+			nthw_field_set_val_flush32(p->mp_fld_cmd_status_cmd_status,
+				NT_I2C_CMD_STOP | NT_I2C_CMD_IRQ_ACK);
+			NT_LOG(ERR, NTHW, "%s: Time-out writing data %u", __PRETTY_FUNCTION__,
+				value);
+			return 1;
+		}
+	}
+
+	/* Generate stop condition and clear interrupt */
+	nthw_field_set_val_flush32(p->mp_fld_cmd_status_cmd_status,
+		NT_I2C_CMD_STOP | NT_I2C_CMD_IRQ_ACK);
+
+	if (!nthw_i2cm_ready(p, true)) {
+		nthw_field_set_val_flush32(p->mp_fld_cmd_status_cmd_status,
+			NT_I2C_CMD_STOP | NT_I2C_CMD_IRQ_ACK);
+		NT_LOG(ERR, NTHW, "%s: Time-out sending stop condition", __PRETTY_FUNCTION__);
+		return 1;
+	}
+
+	return 0;
+}
+
 static int nthw_i2cm_write_reg_addr_internal(nthw_i2cm_t *p, uint8_t dev_addr, uint8_t reg_addr,
 	bool send_stop)
 {
@@ -190,3 +231,19 @@ int nthw_i2cm_write(nthw_i2cm_t *p, uint8_t dev_addr, uint8_t reg_addr, uint8_t
 
 	return 0;
 }
+
+int nthw_i2cm_write16(nthw_i2cm_t *p, uint8_t dev_addr, uint8_t reg_addr, uint16_t value)
+{
+	int status;
+	status = nthw_i2cm_write_reg_addr_internal(p, dev_addr, reg_addr, false);
+
+	if (status != 0)
+		return status;
+
+	status = nthw_i2cm_write16_internal(p, value);
+
+	if (status != 0)
+		return status;
+
+	return 0;
+}
diff --git a/drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c b/drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c
index b5560e2990..b4a7b57bcb 100644
--- a/drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c
+++ b/drivers/net/ntnic/nthw/core/nthw_si5332_si5156.c
@@ -4,6 +4,7 @@
  */
 
 #include <pthread.h>
+#include "generic/rte_spinlock.h"
 #include "nt_util.h"
 #include "ntlog.h"
 
@@ -29,3 +30,95 @@ int nthw_pca9849_set_channel(nthw_pca9849_t *p, uint8_t channel)
 
 	return 0;
 }
+
+/*
+ * Si5332 clock synthesizer
+ */
+
+nthw_si5332_t *nthw_si5332_new(void)
+{
+	nthw_si5332_t *p = malloc(sizeof(nthw_si5332_t));
+
+	if (p)
+		memset(p, 0, sizeof(nthw_si5332_t));
+
+	return p;
+}
+
+int nthw_si5332_init(nthw_si5332_t *p, nthw_i2cm_t *p_nt_i2cm, uint8_t dev_address,
+	nthw_pca9849_t *pca9849, uint8_t mux_channel)
+{
+	p->mp_nt_i2cm = p_nt_i2cm;
+	p->m_dev_address = dev_address;
+	p->m_mux_channel = mux_channel;
+	p->mp_pca9849 = pca9849;
+	return 0;
+}
+
+bool nthw_si5332_clock_active(nthw_si5332_t *p)
+{
+	uint8_t ena1, ena2;
+
+	rte_spinlock_lock(&p->mp_nt_i2cm->i2cmmutex);
+	nthw_pca9849_set_channel(p->mp_pca9849, p->m_mux_channel);
+
+	nthw_i2cm_read(p->mp_nt_i2cm, p->m_dev_address, 0xB6, &ena1);
+	NT_LOG(DBG, NTHW, "Read %x from i2c dev 0x6A, reg 0xB6", ena1);
+
+	nthw_i2cm_read(p->mp_nt_i2cm, p->m_dev_address, 0xB7, &ena2);
+	NT_LOG(DBG, NTHW, "Read %x from i2c dev 0x6A, reg 0xB7", ena2);
+	rte_spinlock_unlock(&p->mp_nt_i2cm->i2cmmutex);
+
+	return ((ena1 & 0xDB) != 0) || ((ena2 & 0x06) != 0);
+}
+
+void nthw_si5332_write(nthw_si5332_t *p, uint8_t address, uint8_t value)
+{
+	rte_spinlock_lock(&p->mp_nt_i2cm->i2cmmutex);
+	nthw_pca9849_set_channel(p->mp_pca9849, p->m_mux_channel);
+	nthw_i2cm_write(p->mp_nt_i2cm, p->m_dev_address, address, value);
+	rte_spinlock_unlock(&p->mp_nt_i2cm->i2cmmutex);
+}
+
+/*
+ * Si5156 MEMS Super TCXO
+ */
+
+nthw_si5156_t *nthw_si5156_new(void)
+{
+	nthw_si5156_t *p = malloc(sizeof(nthw_si5156_t));
+
+	if (p)
+		memset(p, 0, sizeof(nthw_si5156_t));
+
+	return p;
+}
+
+int nthw_si5156_init(nthw_si5156_t *p, nthw_i2cm_t *p_nt_i2cm, uint8_t dev_address,
+	nthw_pca9849_t *pca9849, uint8_t mux_channel)
+{
+	p->mp_nt_i2cm = p_nt_i2cm;
+	p->m_dev_address = dev_address;
+	p->m_mux_channel = mux_channel;
+	p->mp_pca9849 = pca9849;
+	return 0;
+}
+
+int nthw_si5156_write16(nthw_si5156_t *p, uint8_t address, uint16_t value)
+{
+	int res = 0;
+	rte_spinlock_lock(&p->mp_nt_i2cm->i2cmmutex);
+	res = nthw_pca9849_set_channel(p->mp_pca9849, p->m_mux_channel);
+
+	if (res)
+		goto ERROR;
+
+	res = nthw_i2cm_write16(p->mp_nt_i2cm, p->m_dev_address, address, value);
+
+	if (res)
+		goto ERROR;
+
+ERROR:
+	rte_spinlock_unlock(&p->mp_nt_i2cm->i2cmmutex);
+	return res;
+}
diff --git a/drivers/net/ntnic/nthw/nthw_drv.h b/drivers/net/ntnic/nthw/nthw_drv.h
index a3c54846f5..1d5b750db9 100644
--- a/drivers/net/ntnic/nthw/nthw_drv.h
+++ b/drivers/net/ntnic/nthw/nthw_drv.h
@@ -12,8 +12,8 @@
 #include "nthw_si5332_si5156.h"
 #include "nthw_pcal6416a.h"
 #include "nthw_pca9532.h"
-#include "nthw_phy_tile.h"
 #include "nthw_rpf.h"
+#include "nthw_pcm_nt400dxx.h"
 #include "nthw_phy_tile.h"
 
 /*
@@ -24,8 +24,13 @@ typedef struct nthw_agx_s {
 	nthw_pca9849_t *p_pca9849;
 	nthw_pcal6416a_t *p_io_nim;	/* PCAL6416A I/O expander for controlling TS */
 	nthw_pca9532_t *p_pca9532_led;
+	nthw_si5332_t *p_si5332;
+	nthw_si5156_t *p_si5156;
+	nthw_pcm_nt400dxx_t *p_pcm;
 	nthw_phy_tile_t *p_phy_tile;
 	nthw_rpf_t *p_rpf;
+	bool tcxo_present;
+	bool tcxo_capable;
 } nthw_agx_t;
 
 typedef enum nt_meta_port_type_e {
-- 
2.45.0

