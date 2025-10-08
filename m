Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F5BCAC5BB
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 04:36:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F228840665;
	Wed,  8 Oct 2025 06:35:43 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013001.outbound.protection.outlook.com [40.107.159.1])
 by mails.dpdk.org (Postfix) with ESMTP id 4347F40659
 for <dev@dpdk.org>; Wed,  8 Oct 2025 06:35:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vy218Sgl0es9mhWkbozSr7zj1zOc+/F1eBAWb5z2mwNBtK6UfqKp58hPvvB88NuUA3o7ibglzsVNMm9PRl66RfAMZUaN9iMmtnChZf1K6IwsNuJ7MIW/lviqn7aANMfQ72F/Yqeeo9WcyD8M259xWkOtz7jGSTyiBQjArr8E0V9CnlyCr5ZI9qTB42/cHOa/UDVrpADZNTk9dNDFwxQo4jSMm+ruEgUYwbMFu5qs2JIj2DY5VeP76p7FBYea6G4QEgyj3dqV1cZDLQg9ZgOO9VBlAHgyW7rbfpHz+ynAy0mQkoLaDldOi/yNAEnxWXdIyLZEdTzflWYoovsuMHOOPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dZRBmqEN20PCoSJKfb/E6kzl3Cu8UmLHFAaEkK8BTc0=;
 b=xG5/epGnZryRw41jNRrIkoOSPBBKia/CVJnhWsbccd00qqaKWrRe5KLGrWuubiZ6MEgXzvtrHES7dI6PHZ1uuDIv9p5eIMPZWUUNCzFQ2PaYRyRgaH2NT2i3ofotod1a/Ux1RcBLFHrImy6Ps4Cm2NgcGyhAlB+5rf0DOAtiISykXTe5lzr6FQNBxs4zPHwF6V64zRFanRfYp6rpywzSLC+uqDqxO2VIPANYH5OrBGFXRk9jovIyCSJvQKiXzGg62eLGwaoD0m1hiny9KvyeRwFMci/cdL7CsZNPY0iDJopf0r3STm/H+nzYVq4XMo7qcRgLpiR3m9Ig0M6XZhcWtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dZRBmqEN20PCoSJKfb/E6kzl3Cu8UmLHFAaEkK8BTc0=;
 b=Pa6uQARdRhs6zahN3XTTh3hK4l7hXPkM6mgne0/xinlufAzxGHDkFip8AmfVdfp+AKW1lvfLDjnspOYXf9r8mkstmx5ErQTOjUjFNiqjoagYLHQTfw9JjtYgpnKMkqS8eEd8OoN6PmyeLqcoslu1REbYPOhXlRSPAr5sPKFhRUJ/IC8cszo2AbqOe0r2I9NAYat5+tMXJ+x9Bk6Fp9fuqmn1QEoac57riR8LxMBg51dl8pSFJ009A9W3gAQ3fpXwVKnucgEp2B0DnBPjBAjV8rTuOTJg5qiurGnb9M8uXirbTe525ogL8LojsLp6HLntgQumo8voYStXRfNKNbosVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AS8PR04MB8150.eurprd04.prod.outlook.com (2603:10a6:20b:3f0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 04:35:41 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 04:35:41 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v2 3/5] bus/dpaa: Disable qman Invalid Enqueue State interrupt
Date: Wed,  8 Oct 2025 10:05:17 +0530
Message-Id: <20251008043519.2461707-4-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251008043519.2461707-1-g.singh@nxp.com>
References: <20251007050012.2432449-1-g.singh@nxp.com>
 <20251008043519.2461707-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AS8PR04MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: a78845dc-e922-4cf6-7da8-08de06242310
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|1800799024|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BW9+GggR3/OrRc+kYWdtoqJEwK1h8vJwiN+CFSnAQ4GOU70jRupMqIfeANJ6?=
 =?us-ascii?Q?ze7OLBPNCzgu8DnF7ECwXQxXl2VYJOHmMF75xyp5byk0UIVnoZQZpSBp9wje?=
 =?us-ascii?Q?/nqNa2x641eOaaRWfCd0Z9pnB2ftSeR9iyUf99KtjnWVDnJGLvcgdRjVArtH?=
 =?us-ascii?Q?88EBHco69afGYGz5aOHiq7V18tj35rQLm3OnEPIbGnB7rwAaLt+IM4EjdnCE?=
 =?us-ascii?Q?9WbkIqjzjXTrY+Hi3g7ZRlHkuAg70+sCISBE9CdG+REdX85pGMr/V1wLFgyX?=
 =?us-ascii?Q?sA9Ss+i+skL/7dNgyVsraMzrjDzm9pWvP5qPld52y+ckq99Ohv7r4ZztKAdK?=
 =?us-ascii?Q?SqVQaG2uQYoHQnT/0vHEOL6wxxBDWvuBTnQqhUHS9ODpVsThXXOPM7oH63HR?=
 =?us-ascii?Q?1LwiwIBLhgbMT/cdGRbTANlne/JCw773M2oBUqzJeeL0RSYb8yjr9IuZTCEA?=
 =?us-ascii?Q?lAX09u9b6/P13i/NJqh0wDuF3AX2wCyZAxXgQs0N3Grie2dfEQNIaCKa/GrQ?=
 =?us-ascii?Q?AC+KD2jwDS9Go7PG3Vo/sKbj8NYJVpQhDv5iEhGhl741x2C+sHUmKkXjFAIC?=
 =?us-ascii?Q?UMzSrZROqWkczKn+QCj9h2RjHgn3HKcNO1HRkA7Hu1NizQ9hXn+pfM4vMYST?=
 =?us-ascii?Q?GhG1Q4nMGYxnkVgvqCKXU/3efXLVlA0Us8gSOwGgChy3+zYhWi7BqTVQCAMp?=
 =?us-ascii?Q?raHqiPUkNzOXHzNDzG/zHlzDq510jwUa7wTSka6TddMHdK+6yzwQcJJ3TDUA?=
 =?us-ascii?Q?+7vbAY2mha7g52PjoE8wEcJK0MzPHskGELpV+EDXMszarW5IcUwzWDmyVzjc?=
 =?us-ascii?Q?YBloBQjD+QcjXZiB2Lcz3c6Ji5fUAciHiTUCNEeSqjxbjjUdhVjAorzigwON?=
 =?us-ascii?Q?nfHqkn3ccR//sFuaYIcESuTCd/SW665sF6Bg0QPGPyFlnEva1e5+TLUs3N/2?=
 =?us-ascii?Q?V7/09lBr30LaizUN+jsFg20pDpsZDWMFAwUicWX89OQr4O3nurd2qOs6V2U1?=
 =?us-ascii?Q?xPEroAmAXYObKgjvJR7SlC1EIMP/T8/LJVBK3bAdvpFnCHo+N8yI2XE/pU6E?=
 =?us-ascii?Q?NN5W2XmS9U1bMT6viNecmVWg3vXaqGpMFuKYq8NzNeMtWu/2N6zN0nRMppSD?=
 =?us-ascii?Q?wxzNwwaJlOO6kgSYB/pbgn9zyqtAjnuSNiyMD3wR0mLI4is3OgbsOQPfb++H?=
 =?us-ascii?Q?zJw+2/v+wVp4QkbuqQC62CrJW07NdvkyMCWZNCuBV5sCKwIvsoTLgbp6vZX5?=
 =?us-ascii?Q?8U5kqJH3T4sD6mfHVFt/f2f82Apmv2j+oMeBN9ze2Onn08SFS4DgRqerbpBq?=
 =?us-ascii?Q?KgHdcze3aAxFRXLX5AxWKtdjwhC2ptYs+590Q73wZbIIcsBUUvcgGv4HRsgD?=
 =?us-ascii?Q?p0xPzYMuXnGvYrihlUIauDv7gzbkYk3/C2I375Dljyd2bmdeAe4HomXc3kBY?=
 =?us-ascii?Q?5OBXjB3RpJ+5HyB6P5VSxJS7ar3Ag2lhlu3NZgy8954bpmu+ElHtui0ELngr?=
 =?us-ascii?Q?Pnr6JeC8wchLRFojEUnnRMF66g9tei7hKO5d?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(1800799024)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?pPdwVH+iEFGPUJ59n1B51TifJfoghbqLf6y0BCSqh2xbizVH8gsYwFW+uH11?=
 =?us-ascii?Q?bYo7lqIpF+H4PHPWtXXLdFETT0mTfNZdfeuXJQ0VyIIgo6LV+nA628mIKCSZ?=
 =?us-ascii?Q?XOaspdbEllPAza3DCq0C8QcMdKoa67unKJ7CbZEpy4aPhwh6uios2D/Ia0FW?=
 =?us-ascii?Q?l4J1mhXC6wYk7kqL3VtbXtCpsKMfEBPf5zS6Mmzkg0KkRTWoClLuX8lWANmB?=
 =?us-ascii?Q?E3dlR+0B1qXxg/DLLoC2tFjxXh0GhHovgtQJSQ2aXEMPbf3d4z7gDC1zOjWd?=
 =?us-ascii?Q?T8iws/dG6i6F6sQ06xVZ5oSGklUodh8Fr40gSzIA4vcndzvKhRCca1s1AHH5?=
 =?us-ascii?Q?C9tMMkjJ5tlNWsFnnDZFU70/8kvJ5sHUYYj1zzv6u/lYhJ1rJRHJrhdg8qhR?=
 =?us-ascii?Q?tdLi/8oCmVo7ZcwEN5jpUt3cv/DSvySpC7BLyxYPMx5lMUuzQQFzrOcTFEdv?=
 =?us-ascii?Q?JzJF19ggv+wP5F2Bx6csGUq2va3jlPCOvx/d0LlW7CAS4lQgve3JOTZXcbT1?=
 =?us-ascii?Q?kh06Yr68sX3tI34F6+vicxMohJWzhAbhQzIoj4aiRtSvEx/m73m1vWp8WUb1?=
 =?us-ascii?Q?+pnV9ZxJfDRmyCOPHqddP34iHpZ/dGaY0ZRXaXNgpIjuE86wQy0gjDUaSbrB?=
 =?us-ascii?Q?aoGxmrTxtZ1LOcMJ1SoEfGE3tsxtbt5qRZPSPMNn3i64mK2ufbs8Dgee35HW?=
 =?us-ascii?Q?3bo6l8DXe+2s9f57D7W/MciSPNvX95+B6y3US0NKA+09svVwWZCVRStFaKaJ?=
 =?us-ascii?Q?d6pkgP+poCbW0j0U707GDaUTUrMph3X8/mI68ROHWQbgVAlLKPDuPZGqFurU?=
 =?us-ascii?Q?Af5IoenO2aLWVlkBQgAbi8UYyolGWdTbhZ691cm6SnPnwqq+wrWjDuL7a9EY?=
 =?us-ascii?Q?+L/OpnEuTahJZcATbo/JerVdQpJxaAE9KQ1tbSrHzJ5+IaKxNw3a6V38Q+qW?=
 =?us-ascii?Q?euzM5zfVMM5SxzpZZEs6UCr/h5G1508hEVCLugzdmeX/9r4Q3bKbfJKahVq2?=
 =?us-ascii?Q?GnGhEXDoCe6j6+GcjBJG6K9853U9SMZwsf/rJRImnQO6uWuvb2B41wx4J41E?=
 =?us-ascii?Q?tCMXbblcIGIGsBrePLP9iv/GQB8uSbEBDqi0I962WxZ//ciFos/IZFBz+AjX?=
 =?us-ascii?Q?mMAAel/crkNeCa88UN6xzHSPbng/0VoYpgwszDEOFhHgvKoSyWrv6DwMRbMj?=
 =?us-ascii?Q?IOBaMcs8gC/LVgbPp8GQuYyWOZ25dVZHTHVPh6cQfD/hdbYNawcNBSksKZyC?=
 =?us-ascii?Q?esyb2RbOWqorHbXTEVE5kuqpsysz3/v31OGTzNTYGJxUjzExI8EEIBsJa3w9?=
 =?us-ascii?Q?sPSQ3Qfp8oVn4lZw0qVjq+iSMul1b2+2jpwFmvAIfpQLSVrv2obOJ8QtKtC/?=
 =?us-ascii?Q?OIRiz/JTgWyGHGPNIvfr6Y79YWWZ/u2OwWgJPION9Svn6/7XKh+ZKeuzigxM?=
 =?us-ascii?Q?+bW9i8jES+40sRMn4XyaHPMrIfKmOn9H9wP6ZJ3CjQaCKOWick3E4X70Xwe6?=
 =?us-ascii?Q?vPpP7PrA1Rdp9DbUHtpJqujXhgYaExca9ROMMd7a9HwOVa96Sy6T2QuGyLlp?=
 =?us-ascii?Q?rifCcTjizhAWTJl49s8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a78845dc-e922-4cf6-7da8-08de06242310
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 04:35:41.1978 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LxxeGVN+V7YhYHijHBBciLYaATtjmaAlh0mV9SKa4yfteetOnyjD7F7WD8dTkmnO
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8150
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

