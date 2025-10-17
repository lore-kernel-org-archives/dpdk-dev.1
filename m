Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97BBCCCD199
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 04:43:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 59AAE427DF;
	Fri, 17 Oct 2025 06:43:27 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012016.outbound.protection.outlook.com [52.101.66.16])
 by mails.dpdk.org (Postfix) with ESMTP id 2C61C40269
 for <dev@dpdk.org>; Fri, 17 Oct 2025 06:43:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fuiByb8uFLm3EGoNDradKovtJMw9FDZYdmHJaG9VVN/eDogjN0+YHk2eWbjXUxAvj6PJ2Y+LGIMUJfcvrC57Oxo9HAX/bCmkuK5MrkNK8iIe9xjKtUY+x2wr3fvgjaLBDI//DHAqKXkIF8Cgx3iQUSXH11MWCRyjBtqfWCBlILBiwGbF2I1HR0quOsxXiUTfcV/9b0cjxLFYfRf6QNJ1/wo1wgKF0FBrD666+TLT1RZgc4WGhiLHqoUXoc4hfGLVW8Ll5qV3Ak7pLsYRcUk25zRQjuNq3g1bVrV1RlW7ZTIiJxIUm5AYJw96ZZef75amjdcEwFuKM/XHQMbW1m5B4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZRBmqEN20PCoSJKfb/E6kzl3Cu8UmLHFAaEkK8BTc0=;
 b=KAQUMU7cGMZ5SrCSTm+8Wn5j1zsfeXZGnmGTO2Zfjkm+lwl1PhN9pXTEW9RVKC9FTQFZwFFQrmG/I9GJanLgQSEMRlcd5OnCQnAcTVGgINdA7us/Bp4H+iH4jw1onNeNSAMfIrxvk6OVWAHq9NHPnRkPZTULPzE+UBROwmxjYSIh8YwSeAdGnS85S/225CmwjcH5TTfjbT3K9woR67YOLf9Le3qPr8I4CViTcoZtT6Kjwe5wK+4aSzZtppT1S4CJPUAoHYBmCFsif21e46s91yQRnbAhmhPrBHvGBfn1pU4kWUXhUVmFCk58DOBruuzmlBLSSJHtgaTl9QC72GtDCA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZRBmqEN20PCoSJKfb/E6kzl3Cu8UmLHFAaEkK8BTc0=;
 b=kF96pilU26i5DPLWT3458J4fCXmnrk4vDRD0sfhuRK5kMcXJGMommes1NysHWl8CJU8Lmjp0qxtjbeMFPmc5tfiIeyPI+CkUm1INqxyT35mtIouDAo504WpAyrE+8eS1lkIC8UkyBu/VRHKIS2WWslwy3sCLjZWX6wCrPacxMoC484429KySJ3nsgnMbRXfsJr+Tb3cHfkaK/XBAPVeUIwYrCap/UyC5ik+sfClBESEnZvKVss2dcjht59Se45IGmAp4Xo+Ywgzt2f3Tz76IWc6lYucX47Tb+7lY7TsSxGfCNV+yZdHyShtZ0JvH/KEXGaH69NN4n3KNvITp/Tq/XA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by GVXPR04MB11655.eurprd04.prod.outlook.com (2603:10a6:150:2c2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 04:43:20 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 04:43:20 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4 4/6] bus/dpaa: Disable qman Invalid Enqueue State interrupt
Date: Fri, 17 Oct 2025 10:12:54 +0530
Message-Id: <20251017044256.3264737-5-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251017044256.3264737-1-g.singh@nxp.com>
References: <20251014101716.2885563-1-g.singh@nxp.com>
 <20251017044256.3264737-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|GVXPR04MB11655:EE_
X-MS-Office365-Filtering-Correlation-Id: bd69405e-59b5-4c1c-5e75-08de0d37b24d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zn6LHJqyUd6NfxEdxTGKAsZ5aI184zT3Usp942k1rY9x8rmAnJ/PLWtzNM88?=
 =?us-ascii?Q?RrgMuqTvYGYAZkSygcNyc4m/mqvkpoWlm4DV6wmFX1zHXX8uPwBZzuOMHsCI?=
 =?us-ascii?Q?gD326AKNtcQjAXhptq9J4K4jNbDlKNPu0TO3XXjqQR2D53HTul0MrxweC1Xn?=
 =?us-ascii?Q?CWSw9mZRun4t21GTWCU+ybQbuMedjoYrx38RO6zjLoaGHzktkqXkm1GOsLa8?=
 =?us-ascii?Q?Zy8gg4jhgvYWk7BIAxkNOCpdAct7SyJuihZNrsNLSrPOkaxPaAGKaxhz2Swh?=
 =?us-ascii?Q?mlhHdA8i0JC9geOJ1IyYH7vQKn8TE9CmzN6GGr3Q0k5ba8o5N081sXQ2ztaz?=
 =?us-ascii?Q?KTC3wU73a7UYPTYRmARIHmDtNwd2m0MzY0bnTWu1YLB2Qm/O84DBvovYLSFb?=
 =?us-ascii?Q?zkbrXp/RkBQaX6ydsUe0328x31Nvo/vz8SQ/bZUu05wZCM56ZmtRD6/LGmGz?=
 =?us-ascii?Q?yeZ3d3+dxC9MA4WzE7WHMxsR6ncdb1/428HXUHfMX+TFVaN1aFOV55hgI21b?=
 =?us-ascii?Q?i6DuDw9QqpZpm1GfiDKLQvryX0iQRfncZ8tIIemvllu2rHsedEEMHok0E/77?=
 =?us-ascii?Q?a0hBgNwt683lluQ+Yg0NdJEKdjkbDRVWzTbJEHEnS0M/N49vGoVbtNKoHvgT?=
 =?us-ascii?Q?uRiVcTMzQLRQz7fLJ4VZCkosJUA8+AgpjZY6mVsK4A7pdCYTdIqhqdB1+/nI?=
 =?us-ascii?Q?BOldY4wMviysLgDrkO1qwrQon31l3IV0SQQZVVuAd2rkuE5hdAlMTOMbAsMc?=
 =?us-ascii?Q?k3HCl7Rfxmz8p6w9+/WFyIjiTjk2hg2BP0PCzmQ+az3OqDCZmPngS9zLUq4f?=
 =?us-ascii?Q?u6jBOepyb1I2tWJNnS9Q4uF3q/H+OwmAs28ZMU7+KMvmFrBbsqFPaRUZFpOV?=
 =?us-ascii?Q?4HsSLDJWtyEXHT6VCKTY/QQPjNc6u8a3+/WhXANexOEE6YaIQRSBn21JcyWN?=
 =?us-ascii?Q?YMU8NvEb0Bu7eycMMdKxEdTVlosvKQWpXV+pb/pwXgQJrcAJXeL+Ivx6UDXb?=
 =?us-ascii?Q?DRedq0HvjRr/800PyKRdkbu6CXp23opM6XMNRA8b2+LWFoE74ggCMsOlA1Y7?=
 =?us-ascii?Q?ul2WTW3TKk16mDSyPTH2KYtpAHUAq4OaTVMt7weuVNnkNTre21EZNX8Ongzm?=
 =?us-ascii?Q?Mc1QTxLHUoCG3j+baN6nNY0ynfvLK0A/WvMASOaVgfJ37T/Iw7e1McEkBqJl?=
 =?us-ascii?Q?NxB1BKTsCCX4yoF7FfbdGL85zYwdRY7Zu/IGtRZ3VsLojSjutBcTMgHSMxqL?=
 =?us-ascii?Q?r4aoSflkfdXrL6AFJbaBrixtlO6MjdNGXnNc5nzWsul6qT5dX5ObkyJcELUr?=
 =?us-ascii?Q?oii43uXpzHfPo3fhMYpq2cNr0b2S0AbtDMwPugB7vknm52Hmu+tx4ty9du11?=
 =?us-ascii?Q?GDhaBqYic9eaDF3yIyvrl8/FUJEyCMYxkU/cbntl6m0zulSwsw5hrksrBfn7?=
 =?us-ascii?Q?T7INgnSFdbXHVMMjC5eaeYGqCuZXKIxnNZs0ovbGz5PYjE43DA5Md4XE5gDI?=
 =?us-ascii?Q?CEmx9O9n+P0Bc4/FARSoaQp2LWpfi0JA9YUq?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BsiFqPxBcwYTv27uon26bNGAS930gVpiHv3PEgJtI4EMMbD04GGp20yhgtzU?=
 =?us-ascii?Q?z+CJDxO1fmrZ1ntxZS8LRsCZcoTbm8IBVA0um5/Peh232/tCCbLixJNVVEW9?=
 =?us-ascii?Q?e2EYLGFsLywh7Nl1hJyAsnDTQ09X1ByGcKoKSTgt2ZcGTqQ3y5JGeBmVCsr4?=
 =?us-ascii?Q?S6bFkc+djsGzQ+PThxpe96oHeZgMCjQ7P3NqV8CVgwzxEb1EO9wKn5aO8ssw?=
 =?us-ascii?Q?Wf69Em9bDm6xC8J3KHEhvUuu0Sw2a3zYkCx5aQx3pHFb/MKraD+2GrBrLUca?=
 =?us-ascii?Q?uuV6esDfyfnnHdHqltFEUBl3jU3CeQfP8rs79DGRER5hTpYdPL405puC3U0z?=
 =?us-ascii?Q?2sp22aDvEa2D/x88mDGK3zMqGF1kJJMOHUvJNrXGyQ8TDWCg5NF23KuStgyd?=
 =?us-ascii?Q?f69AX50dEtlpliLNFbnYRJdN7nu3zIFQAGl9nuqptiHho4r+URv1qyZGyToG?=
 =?us-ascii?Q?GKq5ZGD3r4MvTpuF8atMBkMJWtUnRcGK8p30X+2mso5gr/NYeKAB1nXV4eRz?=
 =?us-ascii?Q?4zGEd2Pa6iuOZ5fGBRp1Gm17AvPddJ899VAlDayPn7AD5R9TJg6XuqqgLSa4?=
 =?us-ascii?Q?0SBpurxy2+K7uAGmWlMKLyhFZJ2mIXrSvHhpqKAUxtNzHu+TTlsAU4uH2pSD?=
 =?us-ascii?Q?H2/lLAcm/lugQDZEa5PGoU/wsMQ/sc7vO9L55kohIv1ZC27aEI/sgjUjFbxb?=
 =?us-ascii?Q?/OD2+S1HZRwlAaOd5zt3P/dypvXLkxxWovaC6naAvGywR32r36I1xfjKO48S?=
 =?us-ascii?Q?sa5MNKnK7t0h4B5Ro353AGIYoUK2TV0RVyuM04shidzHV1zYt5QhkAa6a1Uz?=
 =?us-ascii?Q?3Gy54g4QBKLfS12UQweMFw5ddl3Fc9B2dYS6uDSR580wuq9+bVzbdyAuGZwW?=
 =?us-ascii?Q?p+Lxnv64inoBMexuBF76WAIGBXzZZLdLhVu/x+ZiKW8cMYJjle6N9hwf+w7R?=
 =?us-ascii?Q?8TqnaL+2whMgF4r2x5iIs3AyTpDPdIhAbfWRMLG3icfNeyUo+VkjuNfXBtVG?=
 =?us-ascii?Q?5krGvHRA6dZ1bbLAHO5rQaij+dn5YLs1KYHOqG9AddiSn8n2zy5+H1IOERtt?=
 =?us-ascii?Q?iNVZQuKsGROeLIP6cI/26fgZOxdlcE/8dD2G9MclK3ZXWDnaus+FXul55L0f?=
 =?us-ascii?Q?ATAdvgxbbWZrp1aPomYR5VwB8X4QXCr/5H1zr+p0ITHSV2rD/ggTBlBL4BzF?=
 =?us-ascii?Q?uaQpIQvV6W8kMWd5N2iGLvjfqqZ30vqXdpw+vV7IiQFw6dLGwD9b30KXbdZy?=
 =?us-ascii?Q?v2trH0P06Xr7p2KtraNOkCWTgqzBkl2prWLZ4nZTM9r93WwVuFp01lALNTxM?=
 =?us-ascii?Q?hl5tmlD+bYxuimWrfio71OpaXkz6QtW+H9bELLdXRo02MW22JU3qD5ZYn9yW?=
 =?us-ascii?Q?k9lsPstVSbrkTJRhjKE7gmYMUEX0ehVeFv1Gq8OFi9pKX4jlfJ0BKUi7+iyU?=
 =?us-ascii?Q?wa251UcmKpt+eS5Met47keKjpcyxA1UuFnD5pl7d5eGFjkT2QZ+B62fqAggl?=
 =?us-ascii?Q?j33dlUuKsbrvPdweBr1zZb8MNlZt6JCpwNtETgzgSkS++YL+//lcd/8JN69o?=
 =?us-ascii?Q?gx/0SMckuFYI376OXgs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd69405e-59b5-4c1c-5e75-08de0d37b24d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 04:43:20.0515 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sJGX/ojdoFit2OpI8WEDkJNWpSaywXhSnWcbziUwlmZpiB6TNLILiEW61To5WZ2m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11655
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

