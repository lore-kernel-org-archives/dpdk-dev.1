Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4394CCD199
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 04:49:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9586C42D6A;
	Fri, 17 Oct 2025 06:49:14 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013028.outbound.protection.outlook.com [52.101.72.28])
 by mails.dpdk.org (Postfix) with ESMTP id DF5CE42D28
 for <dev@dpdk.org>; Fri, 17 Oct 2025 06:49:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Y7YoxJMlqj+CN3DMAz4/kzdd6ju+KmHNSkMtPGjfaRsBdvn2gR5ohqukmL6zL/ffxQv8/8guL/kKlgR6rwlZ4PRg2Co5jvir62D+W9FrN7rScBx1au3D+3a0wK40U3GW0Lr7+DuebguJZWD7WpnFS+i4PxS0CcvmYwwHehxKEHzTbJSCAujzyln7nyS3gbpFFBLfHs/1aGK2D9G6X/CS0WdW7/02ew6eZ3IkJzl0KJ7I778TApjmfzZOxbCjw9Fl9iz1RpJRmtqD9RWkSlluaYy23P6ttaaF7pbLPAGpBtc8h5IWre6DxgrTKUN97D8sq51G2iXiVSXih7TH69JYWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZRBmqEN20PCoSJKfb/E6kzl3Cu8UmLHFAaEkK8BTc0=;
 b=qqD7gTtevT0pNGuwvu14vhSMhKfnVa1iLD8+XyP1NC0rjILYPguXH9yzZr+KQc8L/npNjd5IpNvWs4wrobCS1GVd8WGUf2LT5JKr1kaPs5kR3a727gLacQwCrAyZXpXH0AGVlfsRW0q9fr7+uWI/wU6nvjcbFjpPTLmfoUDqc9BMr5xrN9PGby+ih10vDH2sHWfgpIQ18Y2zpZCPhifPllU0CY5QNRIdMw8p4hmEOBYzLNvJvRsg76qZJimxNNZOcEqQ9Lj7xAJVCTXUTTYwbspjJcNwaptU5/p8sTJvCYz/3vw7kGcdnUI3Nz2xY8GlFH+JgNYJJgzcT8bmZE750w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZRBmqEN20PCoSJKfb/E6kzl3Cu8UmLHFAaEkK8BTc0=;
 b=DL9NicLGIVq4kgrMeFP1ioL8xKfvCpMlQ5me/aQT4C40ndKv97SGkwozXa71Yc40HvkEBbZHHD12UfM80NtU+hocUOdHLHeEsi2Eeb9f6t8DbRnAWVwzFAdOP/Jf7OGGjxn6l5oYCQpyCXNNLODmOJytnUHkG8WSmeAerTYTT8mlH8y1wCGnU5m542C9LeRZTtuk0I2qkaAKtPT/QnLvVIENCVxOPf/H1iGdQygc7nkTnDimzOGC53t+R/kw85IfYTqWSZniJKHW7hEQ23ze7Z08L2lEGsaapF/OPuYJJv1Z5MWF2oGdEOj+qLAYaPfYHc1IPPs4mJG+EiGCOB9PiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 04:49:11 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 04:49:11 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v5 4/6] bus/dpaa: Disable qman Invalid Enqueue State interrupt
Date: Fri, 17 Oct 2025 10:18:46 +0530
Message-Id: <20251017044848.3269627-5-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251017044848.3269627-1-g.singh@nxp.com>
References: <20251017044256.3264737-1-g.singh@nxp.com>
 <20251017044848.3269627-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|PAXPR04MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e4e5775-b746-459e-bf02-08de0d3883f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?emEEs+he3tbvlYi0LUz2syAG4hvwFFP8GpgTme+sHI4opONZzQ/GMDPmlP4x?=
 =?us-ascii?Q?HI9r8r4KoiacpbWmDM7AwOS/lHS/RNpfIymKaCLL/5SPapzAt6bfSpQ8TuFX?=
 =?us-ascii?Q?RKN/Z3auelWk8otnQV6ZqOAPx24JVKKEgaPS0wJtcMu5B7y1ulmGcaehcKOo?=
 =?us-ascii?Q?bgNmET5QJRrvN2w0Z+59VBbNXi+BHCd6kx4LelJ6JwdvDTwROhbSZ+Bv5Ev3?=
 =?us-ascii?Q?af2kCtrq8XeGKYD31GPNL3RQ8n2DZIrfmxWLptFncV4MaG8+IfVMxeZi+SVG?=
 =?us-ascii?Q?FGYPW9+FkU//Ghy+s9Ww8ZatwdqkJZE/YcP76UxdOQBa95Ny03ydl38jIAhq?=
 =?us-ascii?Q?jPd4VumxLb3MekMY8pa4n297KmbpZeYcLukbnLDBApKVLMgFZBchfQzh6EDp?=
 =?us-ascii?Q?6w9pfV5seAJ1BProIel5PRx1IRPn4cvIkmSmF9S7CJN42wb2/i8uLBt3tRl7?=
 =?us-ascii?Q?KUcL9ChvQ5B31KEL8LXhNSydtrlgMy/z88TywtSxR30e2sbTlmuhk9AKqITh?=
 =?us-ascii?Q?9TKRIDjyMGNSLOcCC+IvDvHGQnWep1NcYqdLN/0KHmeGGhnijlLiN32WL+uE?=
 =?us-ascii?Q?fRXpc+yJIZ3JTRuN4n72KSiMTwLrYmeQn2O+U/tjbqgFOL7UpMXYivBP17bo?=
 =?us-ascii?Q?LdCc1rLZ8B3sQvMBQYCi/9QCHwf5Q1HW+DAA1VNNV0AzrjLiE2iWxSLwRADA?=
 =?us-ascii?Q?AR8MoIJTE6Ieo3lkrHKSOrKGk2ZFNvAM5qIf18XrLPl1TujHIJOEY9+2AeRS?=
 =?us-ascii?Q?0p7kNNOtmcURQll+ohvIYVeuy75jKdZvtAfLP6yq1eQNRFxe/1bRLEDWQsk4?=
 =?us-ascii?Q?5mpk1VAPlZn+lh4fbi24XMpqii8opyfgCog1uI4ZGrDjsUO3lxvC1H8vbp27?=
 =?us-ascii?Q?hNVMkDy5XH3MJk6n6bQPMtVxxK2cPhG/TkBgLB9e4d+/6PpfuQMJ/fsD0nmy?=
 =?us-ascii?Q?FIFid3itQBJClOhtaQs8aGZYppZI02BJbpsSeaRplajmYoxLfDl9s5T5PQ54?=
 =?us-ascii?Q?pclPXC9rL12lIwmvZ0rUPQ5w3iT9x3Rt1Oij2FyAyHJkE8WZkqPeNze/vQ0q?=
 =?us-ascii?Q?FNU5SPBPzp3FYxy/iKDpVuvi1Obxr9HML1Jpob3kJDpCVsBfmei07VRnw3Sv?=
 =?us-ascii?Q?orcB+Uv0X7q/aCKK7xlNNV9Us5LbC0bDVz5KNLNfpimhHvLm4ZTx51je5Kww?=
 =?us-ascii?Q?DFG8Ij8lYROQ2buqMtz/8tpJgEnqWfj2ao5/fv3RI2FTdl5EUKctBdkJ7L4q?=
 =?us-ascii?Q?HKdBGP8SiXRsAbdiBixPOA+LorTVc1k9RO5H0SBCNajHTwOwXQXUzfp25q8z?=
 =?us-ascii?Q?oxiK223cUIwvVynwC5EPx1D+nG3BU0V94/CxBie/mFKH2/ZSmFLnHtFlidRi?=
 =?us-ascii?Q?Zm0gFtO9doEANfe8Z14tUDjiaIEuhesEqLHdfqNd//WerZ28diOKR8Zu7DIG?=
 =?us-ascii?Q?y4MbJXlIuNNM2sXO0cJAJKm2kRUoKVyWL6C/XNh4XmeMY8WYF/YhTASCucV+?=
 =?us-ascii?Q?8UUNp5G+4zGrKPdYQCJO8crh3aTbQsi5+CIp?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l2b5clH29pz6/H+1iCYBzGfOU1eYYYGnUU/OM41R6mS4pRSoGciaJDWedeEc?=
 =?us-ascii?Q?sFjRzIjGFgxGPdSOdWoSZAIUxZiWUxtzN+xM462VVtqnPmZSKkg8ISnbWCDu?=
 =?us-ascii?Q?sQ1P9QwBQo8wowfoT/XK0qYYrJSoAtgAzUISa9DbPtPJAod/Fp0NXhxC8HLG?=
 =?us-ascii?Q?SxJXJc4w5qUm5hEwCIbKCTxaux+5lv0ADEcfbJ6NiWeokb8bVxFxwb+X9FwD?=
 =?us-ascii?Q?0u82LI0/n7hseUX1advWmBxgzbe0Kda/FGX1YK6sH0HN7kmACuyP57Qj70e4?=
 =?us-ascii?Q?cg6SISfbksd6cnN+GiWv4k2mNLYSfruK9K5n7TpFaSrZkUvwVIuspATPxg3k?=
 =?us-ascii?Q?Pb9lCQf/MeQwu+vg+NyAMjU3IE8xFjtUZ1KcsdskZetQR+0ID9qot4oLWjHZ?=
 =?us-ascii?Q?/L418XWJiiaSkhJOCy9lH2KgNalEorclOiEZK+luRXoVMRaLyt0r+dnu1Uzf?=
 =?us-ascii?Q?l91rYKt8Q2FK8MEfU+1dZdxo7dHMkn7TT93LOFc41s65zlahtBs3o8sF6xqv?=
 =?us-ascii?Q?N7wJP9Qd6sNaKFsgox3smI1UFeWnfUE42UgTjK/g4CZV2bI/GbguHwM9J1N3?=
 =?us-ascii?Q?bsqnqW4eBWbHyBBUURC8BENgfWQPCXBzOuJdACw4hSTfJNDyiLb7VWF3WA4b?=
 =?us-ascii?Q?ZA7OX+GYzIhQSRPCTsNxnFX2MrnrtM17OcdxXTYv1J9GdRzIRD/n8iO6FXLu?=
 =?us-ascii?Q?wOMuhTjZvzbSIA5N+7ChpvyXMfCN9qs/KuhHM7rRbkkgjnLqU+6HbtfE/cmF?=
 =?us-ascii?Q?tV1zblF40gALVQ5KyzcAqJBHA+bZw8LUFEepk2B2RjGJh0JUJ/E6cb1A/GXS?=
 =?us-ascii?Q?YAisXkr1Y+M+XdtsEbOYxBo8LCMqlfzSx9PZdiSfzP3rv9zTGQpllEoTZgXL?=
 =?us-ascii?Q?4N7k7dkUkAtTCCb/4dWscvlibuBDhwy/8KVPc/lBJJt9QsJrZxg2Fk74EJYd?=
 =?us-ascii?Q?BLF8CIpeHcLQepKUJ85GnMlN6aTQZ/JL/xGIsDKrwxqk+GtWYVUh4Cpu3YMe?=
 =?us-ascii?Q?uxGCx9h+Uar/WgF0xpkQ+7w7a/Wr7KuFGIyzYZ+JrwkSPEtUfFtzOyIglQJR?=
 =?us-ascii?Q?xhLWfuEufB7Ye/N58LY1nu51JJh1TuX7IiwJoyafbYiE0ex97Yx9dLS2MUPB?=
 =?us-ascii?Q?mIvhD113nvEEQ5vT8N/5F+XYqi9VSEntEE60jQSnfxPSbNrZgMlN4WgKM7ya?=
 =?us-ascii?Q?S8pCLq5ArueM2CZ3nRM1oNc2bk18Jwmb22SybcvZ8N1QLpwWKymxBQWBUV1+?=
 =?us-ascii?Q?770KsiKFMR+7NHZA1J0J7eQJYsFJY5cNhJk6JqVYlFCKsiQbtjSkn7FL3EAb?=
 =?us-ascii?Q?zRJzTFUxjvboU8jeQR8EIUUK7ihOzE331tiD4aa66GPwaSdJ8SFUIzw8cXrt?=
 =?us-ascii?Q?Glfx6IpFzBW1HGbwf8S3nafDBlPHUZGZlfegm63F01etMi2iJ183iR6RsoQG?=
 =?us-ascii?Q?Jsn/29IXxhql0FjXTMt06B3zaE/1TfL3ZHK9eJnIY9B3ozaUS5XwnMbhvX5H?=
 =?us-ascii?Q?FzXF0zBRpGvhW2V36ORB0SOQ1GgLoEpQo6gFz3RcGQRRWRxt9ExkFOZ1g6nk?=
 =?us-ascii?Q?QVURqjuv4L9Zd1qGYwUp6a/XBUPXFFNFsyCejZXO?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e4e5775-b746-459e-bf02-08de0d3883f1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 04:49:11.7947 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: wnAayHvBvOq9Uf67UgBBCh1099ZpQOoi8WOvUL8XXMEa7epM5oNfT4xKGjS0sb+3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8254
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

From: Jun Yang <jun.yang@nxp.com>

ShareMAC port is still alive after dpdk process quits but RXQ setup
in dpdk process is in invalid state. If high loading ingress traffic
hits the FMan PCD then it's en-queued to the RXQ to generate frequent
interrupts. This causes system stuck.
User can disable this kind of interrupt by env to avoid this issue:
export DPAA_QMAN_IESR_ISR_DISABLE=1

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/dpaa/base/qbman/qman_driver.c | 27 ++++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman_driver.c b/drivers/bus/dpaa/base/qbman/qman_driver.c
index cdce6b777b..dc84260731 100644
--- a/drivers/bus/dpaa/base/qbman/qman_driver.c
+++ b/drivers/bus/dpaa/base/qbman/qman_driver.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
  *
  * Copyright 2008-2016 Freescale Semiconductor Inc.
- * Copyright 2017-2022 NXP
+ * Copyright 2017-2022, 2025 NXP
  *
  */
 
@@ -32,6 +32,29 @@ static __thread struct dpaa_ioctl_portal_map map = {
 	.type = dpaa_portal_qman
 };
 
+#define REG_ERR_IER 0x0e04
+#define QM_EIRQ_IESI 0x00000004
+
+static void dpaa_qm_iesr_irq_control(void)
+{
+	char *env = getenv("DPAA_QMAN_IESR_ISR_DISABLE");
+	uint32_t val;
+
+	if (!qman_ccsr_map) {
+		pr_err("qman CCSR not mapped!\n");
+		return;
+	}
+
+	val = in_be32((void *)((uintptr_t)qman_ccsr_map + REG_ERR_IER));
+
+	if (!env || atoi(env) == 0)
+		val = val | QM_EIRQ_IESI;
+	else
+		val = val & (~((uint32_t)QM_EIRQ_IESI));
+
+	out_be32((void *)((uintptr_t)qman_ccsr_map + REG_ERR_IER), val);
+}
+
 u16 dpaa_get_qm_channel_caam(void)
 {
 	return qm_channel_caam;
@@ -343,6 +366,8 @@ int qman_global_init(void)
 		return -EINVAL;
 	}
 
+	dpaa_qm_iesr_irq_control();
+
 	clk = of_get_property(dt_node, "clock-frequency", NULL);
 	if (!clk)
 		pr_warn("Can't find Qman clock frequency\n");
-- 
2.25.1

