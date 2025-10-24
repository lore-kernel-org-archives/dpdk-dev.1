Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85941CCD1AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 06:19:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3169740672;
	Fri, 24 Oct 2025 08:19:37 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011001.outbound.protection.outlook.com [52.101.70.1])
 by mails.dpdk.org (Postfix) with ESMTP id 086414064F
 for <dev@dpdk.org>; Fri, 24 Oct 2025 08:19:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QONUKBKOGFEMc131LevVGlbWV8YYtAW9eSsL9gZN45RlQEfDL0WLEi2i/+k5P0OqbG+m0Kpg9vO4KF3wa86Tk60bOFELwB/1X1j3t6ao7XGGA3GR15K3beZKiOeweHjGuiRXLu7+XLSWW4B4kUoMId8PTt/q8vZmRrXAH0uTxLH4B9cDcQt1XbkNfYKwlKxT2l1PRlRU88PQ+H4n6ESUa/WRWNLY1R7hwBXkCm8AZT7bwmqU1TZvQD8MeCK4nCxag5zsV0a5kmabsnykuXEqWl6UTrcGbotDPfRpCXN/t4/aDqakh3m81Q3HEmtBM4hyGZQP+/z+Md98J8+OXkB5mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZRBmqEN20PCoSJKfb/E6kzl3Cu8UmLHFAaEkK8BTc0=;
 b=bpog+F4QiXID2MvklazH4EyoRjvRshEW98Et13K+TdrDi7oi8ysRcwTU8KemWNzO92v07XvKAcjDdDUOaqmZOKgIBgGv8jf/aUaWGJLDtpHvECyvv1GC4OgMe4rm2ZRTaXCrXTjgJtE8Zpx8cPt/+DNtzwQLYEdaJUk5G+m42p+kiBebKqrsOBNBJG6qCoYgZnCxamPZKPKic7m6zowEcKu05KM+dZSqCWA4rIlwKmSlB9oUS9ETLrzghiwYM/HDmFSaWY5OTyV6LsX4kET1G7yAdoImTZZ9XPQ4A8/c4sjSCWwP2LMGuCq6RDeLMZjzsKs57rRN2DEvLZfLoP98XQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZRBmqEN20PCoSJKfb/E6kzl3Cu8UmLHFAaEkK8BTc0=;
 b=b5lYmFc0eUqF+1DwquehxS4e0xDvQuP1jJJjX8qGZinHo/BY7KB+aXQWcDDloOUPTc2/3Ch4KgFDB6OKN3IBLO+ZUNxLKdK875NO12fqhy5UaZ/oGwBTZsK1USXjLptvC1eERT/gGCMWFy8xUj96JyW3Azdu1Oy62C9yeNRODlrRg2qbarSgGC6I07zyKDx6fuJOA+5+kj6MbOOaD22JGjojHBhjUCAkXz03bpfyg7u25DjIbp0LXfJRPBsgkp6czWiE1IeRp9KA4S6URL6FeFa0Xfv+asCIfKy+Y2JIzg3XyYCSwVBI/v1eN5SulcUUDc9vANVMM0cwqGF4xYIP+w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by DBAPR04MB7478.eurprd04.prod.outlook.com (2603:10a6:10:1b3::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 06:19:31 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 06:19:31 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v6 4/6] bus/dpaa: disable qman Invalid Enqueue State interrupt
Date: Fri, 24 Oct 2025 11:49:04 +0530
Message-Id: <20251024061906.3535470-5-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251024061906.3535470-1-g.singh@nxp.com>
References: <20251017044848.3269627-1-g.singh@nxp.com>
 <20251024061906.3535470-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|DBAPR04MB7478:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ff33464-972d-402f-1229-08de12c54af9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|376014|19092799006|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?kSOM5tpsCVj16VVPhW7bNUACbVvIRLsCNpq/N/zr1aBkqTHoBtcLgXs/U3CN?=
 =?us-ascii?Q?5Hm6j8L6+iuWxVkXXGAXzQ5FLcX7QQmRSayDTNKUhKVEE50ghlwQITA3PxLX?=
 =?us-ascii?Q?bwEsyf9HPjGYnMSTWpvX4xjv/6EqRnD4urTVuwoP0HL79fuaa++FFCYM8zAW?=
 =?us-ascii?Q?4bvHQgvieqQEIqfAM7cSfHTpEHJU9mRr+jsx7859fzidroRD7OFkQomEkrp8?=
 =?us-ascii?Q?p+6NBSrLZciad0ZCHJzUxvksWkjCNJpfeZi9x0QvDOanaTJXUs4fP7swvPd6?=
 =?us-ascii?Q?K4OnHkonOghJO1Ck7LoUiN1WSzWtWI1bkNMwPvwmEaaL3sf2MaWmNAz/RRwI?=
 =?us-ascii?Q?M+nwhpE10ZkjXF+r5KQ5EjNgCzMJqwduRNlDNyD7XhbnHOIHVqlMwWpAtOtl?=
 =?us-ascii?Q?TlsGzO/gEwqlhYJpFyZDlXXbrUvtsx+Cw97KoTnV/bMpK0qmU6L2fESb/3ms?=
 =?us-ascii?Q?0lLEqP2FAON//IteYUtDHrGFPBM8n89fF64tK+YaYnhtA7OrYyrew9h3eZVW?=
 =?us-ascii?Q?OGcSVUlTzboF6YrE9XICHuYDPy7t3qCVzQwAmpz/6zZGO55FHrfbm339YM11?=
 =?us-ascii?Q?WimHCgigj50n/LQLTtfxa3nBgAQ9KQuZ7NEE3i6QuV0cSRT7mhE0cy7mdn9x?=
 =?us-ascii?Q?6pcONRbqSGEcfXQeEp/1eq93xG677ToAHQ0WQJBRCqx+pRUe/Z3o5ZX4wSiN?=
 =?us-ascii?Q?zDnDDeA3vhtRTU1dWl8NHxm0ZbwCbjvJEAEHSt5gu5k7ZTKInI+8cuQ5iDrX?=
 =?us-ascii?Q?1rlsdtkGMdm5pLaJwumFOhTiCa8mQKI6qkT0XA9dMWxQVsNbSmvOELSqcv4I?=
 =?us-ascii?Q?IF3Bww7wmrAEEvFUEy6Hws+CFu2nnAf33J0j7K6Vp+2yYoTsz9N3sQQGuxNF?=
 =?us-ascii?Q?YiiloWRKU9P4Rkk2qkTe9l8emVZxAMFWaXkghN7GWanvg1TLz5xlTYiWcABm?=
 =?us-ascii?Q?LhgYnlLsVUMtQLE2gY8RsrBdrtAM4Ovof5QjKj+AxXT5hsjKJk09hN1SYxDU?=
 =?us-ascii?Q?9gS99rUeTSPhKg4eDmJMzGnpbN2gSWguVguUa0QUlebhvqngU99EcJSG2I8J?=
 =?us-ascii?Q?ollYyLrEvOyIyF2vFhFbimMQkFXlRBl/93fvdNcLvDS/d1Fe/BVMPwioc92V?=
 =?us-ascii?Q?mLqkGeZ9j3y3V/V/v2VxcdFs0MtDc9gtJHqaDLW4MR7oE69Z3YugYw0akq/8?=
 =?us-ascii?Q?Dtk8DwFz9ZGQZq1yBxzatxIvZvVqUt6aUnV5Im/UW2eZUGBj6lXojapoivb+?=
 =?us-ascii?Q?0YRc6edcTterjQAJHzihdPeEb2Y6kY4SUfypgAa/SNyx59veZ6SBMLcTXw8/?=
 =?us-ascii?Q?2bt3BI+fjOG1R+5lLN9LHt9BK7pD17diBHY2kzPAWs1UUWlvTaJcel/cdMDg?=
 =?us-ascii?Q?S5cHA7aO1xovpMH9jqVl99nV3iuGxyKwEfjXrn/yNlwis+77qFlDX8wnG9F0?=
 =?us-ascii?Q?cZEgnWeuXdti3WBv1G9/+ZcQlhB+xndukhf8E8dOA2qGxLGNG0x2EB/Yz1lf?=
 =?us-ascii?Q?F5xhw4ewH82dpzLwAlHLaKCeIULkAZc0FNoN?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(376014)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?swjez5j7gO/Y5ETnl9kZuutZPYI/O5K2iHUnen8Rd2LG3mcq1R+OlQkEMilt?=
 =?us-ascii?Q?17PwNHGgnmTfDy3CKdK5/zE1ZyDUvPPtcV6KfnaO+6/X2gG3vsR/uIGsvG1t?=
 =?us-ascii?Q?kuNJMfsP91bVfQUFMX9hRMqsysCl1jogauSUU8ipmFjPal+/A84lz1CqU5kq?=
 =?us-ascii?Q?NXLNh6+7lNZHAMzvaGrI6rmVRFbtSaewAvCRsjvHBW2xhr3tZC47wtGVdMQF?=
 =?us-ascii?Q?FYdX6jeb3rGasJSbbPJcbEbz5w2Z/F8K5pllrkkkppwQQAl01RF1AvIfK74l?=
 =?us-ascii?Q?hAi8Ete+K4rRRCDR+TD3f9lGrqxAmf+KqOu6Mdf9krTbt5p+kRK6yH7WpIIX?=
 =?us-ascii?Q?p0WVo0nELOR8QwEu7YNZWWU+kt0W+vtJvUaxeku+dnuwqoFBpP4kqH5ZJf2i?=
 =?us-ascii?Q?7eF0/l69yyh4OkCUfmVvZIeLPuOmoEydOE8qDGsZK4bETSDmKDjAcfNkRIQt?=
 =?us-ascii?Q?PkgY07j7bjbIBo6C6aBCxZN8oNN5SxCLA8pUCO0hLTg+wNE6NpKh9T862vsl?=
 =?us-ascii?Q?qbRo1YmERsx4p8X+/EFzCwbFtlVJScMKpm9vwv6JHL0HW53L2YReCqgsatpw?=
 =?us-ascii?Q?mzkvyoSsTLML5r5TB2XrPCggqpi1hUyFjp70OqBAvEUM55W4ObQq6KC/wmiV?=
 =?us-ascii?Q?Y0/yxTo3ATFwDdoAe2fC4dmAPzZxJBFnK664WUQRdtHplQ47vnBNlJL1CqM+?=
 =?us-ascii?Q?dqeJFCX5Kl7RXVDo2OJSTivdA68irpLT4hdFCOgMkeJaV3A2UgApeCthwsLf?=
 =?us-ascii?Q?uTsLgxFeCeo6Xxkt36e0fJsBZIjo+/S79uJNBFqsEKokOZOwJJFajCQJ5zmL?=
 =?us-ascii?Q?SOLpxHeJU+H8j5HcwYc14+BmKuf5bAYPUv7zdLjl3NNDZ2dH6Me6SIsifBit?=
 =?us-ascii?Q?bGZWVKQlSAQFJ8OH+shqiOG8lrrzCGLa+xIxLRYnJ10kJih/vAJSFiWwA9eJ?=
 =?us-ascii?Q?fc6fy9+d6U2usjeAN5kq1Kl7XDwTu0Syw1A5lt7GnwCuWTqnt3hWXsrchQlY?=
 =?us-ascii?Q?S/itPOPG3+9kL6eorlmIf4pMTMeKf2TS7YgBS2Bw7pil/eEHa6OPB+OKYUMu?=
 =?us-ascii?Q?/CfLvBEm2dCrah5SnHNOVKe456MYPfgN/09v8BNb47emhSL3Ry/49IgJe0qZ?=
 =?us-ascii?Q?EhDDn+pug6EM9WLyIz+MewJRoDrhzaY4ki9/kXzfpi4ee1U1yzZjTs/M02nZ?=
 =?us-ascii?Q?ccfJyWwF817XZ7kO9jv9uJe/Ake//2satzs2eKRo4TZDxezKkN5t1z/X3b2V?=
 =?us-ascii?Q?AkeCyuN0S6rpkC9cBCFNP0Be77KxDhgvLW0iYDMPAzpYS806e0c3haUsu5bK?=
 =?us-ascii?Q?zx/MPjFb1W+dP+rM6RGpRIIitx8thbpoVtzS/77homVAixKwcT8BWufsan1X?=
 =?us-ascii?Q?b1MdW3puj+unp0nx+X82xw3KiLYE2RZzPju2/B6zCROd1kA9CsOOijXpaieR?=
 =?us-ascii?Q?DuxU+6L3DaA4cIXBICbzsXhmnPkNEX4CEa2FUjW1GLBuf2BYVQ+PllLwi0Ow?=
 =?us-ascii?Q?DUgA/PsTLmTVmXLbvznTup78NOmUbIHA3W0ibxlYwabhqrD3dFtFMB7sz/L1?=
 =?us-ascii?Q?JTwGETfrcaFamIsdZfo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ff33464-972d-402f-1229-08de12c54af9
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 06:19:31.0876 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nb6FIEAZ4aek4bqJIEq7qjmIK3UjurH9H/mCza3QKceUsKfvAtbRgyLbkI1Kd/un
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7478
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

