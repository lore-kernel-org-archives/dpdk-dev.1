Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E9EBC7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 04:29:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70DF14067C;
	Tue,  1 Jul 2025 06:29:39 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazon11012044.outbound.protection.outlook.com [52.101.71.44])
 by mails.dpdk.org (Postfix) with ESMTP id D60E040678
 for <dev@dpdk.org>; Tue,  1 Jul 2025 06:29:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=tdWfaw9Rb6e3IwfA+34koU6xkm6uB+0mqa3s17IR8SBZDWNNqLNIMKJxQDNwyiqP4KSXvpcT4+jI2w7a78vdz1ITgrDrudhOJG1Uoonhgb8rW9LBU8RIgA2eQK9uzBkJ+iIOELHYc+MMPFanSTGhF0lrBXZ1f4qj/0MBiLJyFu9VJYPJzCTkILaHVYWGmN+Gw7traS8WyzqT4mrw5KrZpddxTBTKSXbwCdcNkAHSZRgnYwErltJgtj1Z+uT28x78hmvwVH61OjuglAGfzm0Nyae9jBn45M4zk5TrJIXyzcNDdiY9QXnA1x9zJT744Alm+Zy2P9GWh7Pw0urMHEVzlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r+WrzGkCl6tmw5vjM0kfDyFlyp9Xt/YRLmCmSvDRt6Q=;
 b=XTt/kqF/I9Q3XgeqiEwLnMMqD1pp4THuCmgPT5bUwnoI4Y4GxFRYX2v1hJNxIL0x//4PihkLaZA+h8INJ2c3Nm5sY5+mmTVqo/W0PGWx/kq0CglAmlnWAnOEqcbGZlBHftwPM32PNeDL6Ms2kMU00fOV6EKLX/AZHi/+APCK7lQ+TWKBMou2WbuepYH9keT7p9L9AlTbya+9HGK4PtOtcR59ctTTbbFRiNbt9qGSpdsSpjXU59FvaNlnktj5T5YANWyJ9ihDIsluBP4OCM/2wB6rns7SsCzgWoVd9jyKuYfYUHIW7mO3gs9CzQkFO3lEeUa25FV7l9nEtkRry1BnVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r+WrzGkCl6tmw5vjM0kfDyFlyp9Xt/YRLmCmSvDRt6Q=;
 b=YtP+xVPgYZo4iYOCRbxsHdshFeLYFE7dSMG76OdCAyW0hl9eBCW97cArfYcrDZIpJGp4yDZ8jA7V+Gi8rCFKek841k7lFsmV86W98YfaTc9nzsmc3It6tvqmcTeLvvNuyPe3R/6fFI4eCcvFCJxhvKZrtJxOawI6oRA1GUrEQhYqe1LjPqqofvnZgs6RTZT6NUdj+ZAKt6HttUQdwPd3VEaWoijE05HVE/mRUP/hGLVOTHFrbnFWTcvF3MHyZDjfXQbcCc7P8xxz/cReItcQvnyTWIoR2LcZmMxmYLJrrUmWT9IFo+iWQm1noCEQpkwy+f/DPgrEC2gHpSAHnREbSw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by PA4PR04MB7647.eurprd04.prod.outlook.com (2603:10a6:102:ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Tue, 1 Jul
 2025 04:29:36 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8880.029; Tue, 1 Jul 2025
 04:29:36 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH v7 3/6] bus/fslmc: add DPBP APIs for setting depletion
 thresholds
Date: Tue,  1 Jul 2025 09:59:14 +0530
Message-Id: <20250701042917.3000355-4-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250701042917.3000355-1-g.singh@nxp.com>
References: <20250630095800.2943863-1-g.singh@nxp.com>
 <20250701042917.3000355-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::8) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|PA4PR04MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: ad3054ee-71a8-4a15-4d62-08ddb857e277
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?O6qnxSo2YrDuj0scquxN+Lw79b36KHSubGXscHevrvR7hmIu7QZ7xAbOBCqD?=
 =?us-ascii?Q?mnz7wAlhuywUQbZFfqbMUEAace3wno8FpyFJ1QLR/7ILJ5s1o1sBkxhrluZm?=
 =?us-ascii?Q?h281YdXeliFrEJ7Tp8Rv5DP6/dF24g2hlKoWpezVTnFxIqPtX9masLx4jTs4?=
 =?us-ascii?Q?ovS8m3vVY+ybr4QfvMK+7owt5AvCzYkbkMHdI6GX7+pQj8d1AZeOcTqHKSDV?=
 =?us-ascii?Q?tL8NehmtOCxUCtrCiGUXrQw37a/6eaqqOEfrbb4qzeXnl4gZgrRO818u59rS?=
 =?us-ascii?Q?PdtKNd5K4Bd1n2T7cSBs4pvhgeBxyO8z94As6bGDi0nofYWlYQ1DDdOBJc+z?=
 =?us-ascii?Q?unSUza9cZMESaB6iLWMxPiR8kCrs+b8e3Jxw0dqhiodqVgpRwk36Gsyi43wu?=
 =?us-ascii?Q?g7xajxpbIkGEFEYKo5+rjnoJpRdpsyK/LD0+UaC80DLkyI7E1c5pN8PCbSCX?=
 =?us-ascii?Q?j9n6LpbFHkdM5ZTnc7qQXACb9UgMoqo7PwTO31IiXmPCByjYfjxlTfmVmjad?=
 =?us-ascii?Q?Q4OBmEIqqRsMIMXh2HULj41KVUeU9iARchjM12r/erZJZUFXkudt6aTa9utN?=
 =?us-ascii?Q?43MzDpvukoKxP1vEmluVL54QmlhgWGfKvzBgoTqu+z6XB2hmFS394OWsB7bM?=
 =?us-ascii?Q?Q90PYSqDGc/jaYFXrFZOBxuIvnLRHMfCHeSsqx8gGLzhPFmQRTXcPpdsHyWv?=
 =?us-ascii?Q?2to/F+R2kk+D/NgCGEiTt08h+IUBFOv8osIUDKyAu7n1jpeEjuIZ0tx/9cL7?=
 =?us-ascii?Q?4OENtuIgYHAaLh9W/m0MS3iJkXOkjeBCbd0ZE5cfSNhrBpD8OiRnCJElm+eh?=
 =?us-ascii?Q?63yNIDMK6NyYr8C1q/R1m06NWE2YS6QUyWpVLNcmVSmJg9Icfec9dRRdbaNv?=
 =?us-ascii?Q?ZlarLmzGjuq4KoBFAptFi7LL9/IdINlEHqFQgthzRQxq14buehc5mP88UPb5?=
 =?us-ascii?Q?g9eDU/XsTg6qmliJG/zYwVLjo5Zyck+eyTBiJls19UaIjDbDMldu9EB9bRNY?=
 =?us-ascii?Q?b9o8+e/8sqtWHkhBaNzP84x07ig7nX+RkipGm7sXgZmAGzoOz0jOAqMyT1Ou?=
 =?us-ascii?Q?2lyqG/3XdC1ZQ8zyIv02mNIUNNffd+6fG8qVyHgvptG5k3sLbY+hoGwizOQb?=
 =?us-ascii?Q?UoGaUInhzvl8VeytTT84gZ539b1QkRx6szksbT42uXA3xgj8vCfF+KfnNiG3?=
 =?us-ascii?Q?mLXXALGvSQVvk8FCbygQ11UHREYW1Sevkhf5DyXVYRA1Lwb0S4XZ6vBMsKMj?=
 =?us-ascii?Q?3PH0fRyLS+bP0s5nNHP7lz6w7E1egvLL35DnIrQQ1v7QOUcuT9o/F/C1FcKC?=
 =?us-ascii?Q?v0EEUl+/rPnOtywI2QhLKG9K5nUKGzvX5OUeOaUUUkWYa2USuoI8o7sYMlVB?=
 =?us-ascii?Q?y1K1D7b0AAE3iV3V27mFqblbmnJMir0iRKFAajp1p03hh35OS87hGhF/CGfX?=
 =?us-ascii?Q?jCE4o98xp4VdMp56YAuCR4Tec2cOnolYpXDnlSXys3y76gPQMgkvbp8qi1wL?=
 =?us-ascii?Q?AmssG8wM1l7cLG8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BR+Iipr05HDRL1qxOy/BLtBSUxdi8i4c5YTNt305p8txFh2ep5rUdO56Aibu?=
 =?us-ascii?Q?brEbzcEX3lIBBOaD9YUrpGuWBAlgw3jVlrr3difsvYl0Vo8R5s5aVKy0G3BI?=
 =?us-ascii?Q?O6muRgDC+J8yJg6iCFPTNDAqSU0laInG+bKU/Jcq6p0pwhZX9lEoJlcsa6Ce?=
 =?us-ascii?Q?G148JXb4V2qoBE5ysM9oYJ2paPlGUlZEM/AtnXv/OYXPzzDV7Cc+kzkxfGW4?=
 =?us-ascii?Q?TXGWl/BibE/BGL8WfBAG+G9ntPVUXmMJu4OH/H70u4IjR6TxAETBoc/KB+BL?=
 =?us-ascii?Q?KmWCS7Mamgnyq+zPAyH7GuftxXuUkhkQR4bbW4dInf4mmGGpsp0dj0OZ56bU?=
 =?us-ascii?Q?3KsCs80nXNxTf5wYBG9vjtPRFPtULkkr+lWb0XN9TgwDtFbraV3HOLLhmHUQ?=
 =?us-ascii?Q?ffF2d8qPXeZi6QrdPIHZYpcmPi32RpB9d2fUy629oHgNik3isqy8FNJ+DUxL?=
 =?us-ascii?Q?bh5AYg3srhyCsUdbfapeUuHLe7CJcPcG0BMZi0vi63jRWbYrIn2f1F20DIE7?=
 =?us-ascii?Q?xMsiTolf+IB4Le5pD7QfCeSczwsvUYbpkFMwpcUpDiX9q8VKojS12H8BIQ/F?=
 =?us-ascii?Q?YtsDkRIpvkYdY9Ph3LaW+ytxfMaMithaX3PXD1WofkGaxKzgC7E1FoN+DYfb?=
 =?us-ascii?Q?CfpvCyaGUK2FkUKNFqUq70IN9+E9liZFB40oKsWXTNebqrZLLw9LJXW0mYAH?=
 =?us-ascii?Q?SrMhcUzSzgNXl1yIUS0PKeXRye2DhQ46y9VCN5BRwcsq2qgm1yJ21RrG04AI?=
 =?us-ascii?Q?cTEJJH1Sa9djSPSDsOHWgTKdpI7WW1o+4IaOJeuzDO3yVjHP5ZX7udLPt+sE?=
 =?us-ascii?Q?UEc5H58CeOFGgmpD79IFTl4iUfcQ+TC48VE7raWo8IKRXI5YSGk3Dn7bqjAz?=
 =?us-ascii?Q?b0aCw8UnqYVHJ+JxW8DVVsiBOoLSI4w1e72YY8EcFgDKAeWkoI6eMH0pI6R1?=
 =?us-ascii?Q?GRV5S5k/PlOVW1qC3lm5QuK466zMkXCI37OCBbtkcyeAgMZXtHzUN1TSWGCU?=
 =?us-ascii?Q?96jEYTdBhWpwJP2hIRKucSiM7ot9DAKmCS3XdnYMuWRP3tkhgfkCyJD0JUYK?=
 =?us-ascii?Q?sW9xuhj+9k7748El99arH5sBT+41U7fW/71dMGYbU2sD1V429IrQmWSsCypL?=
 =?us-ascii?Q?ZZuj/ncNBbaDiSvXHwypSZ47KVG38IGRTzcgdzUKaTAEuKovE/qF3n2nbsJE?=
 =?us-ascii?Q?+hYehmstUtiyC8ixyiqpri+nKLCoTRHplyR4WpVeUO3445duAtgKtrpvCFSi?=
 =?us-ascii?Q?8YOvF93XoDgzUkxYlni11xjElNQ8T6e0PDqhrVsvzL4it8pauStnDAmUP9TZ?=
 =?us-ascii?Q?OASYARRZKezB2Q9rHqyORl79UnGHcNUXShqS0/3VPrZ+O7TN+uDUzbgDZ4cG?=
 =?us-ascii?Q?2YmANTaK8s+tRu4e6+ZhMuXr/bBHE2/eDThUnbZzu1UBHebSK+hSPGI+eRsX?=
 =?us-ascii?Q?8GOSKc+5xNYGjvbn+NBaC0HRA3sp+/D/gkgTZZP9nfXodUL9Yoy0lBfH2Y71?=
 =?us-ascii?Q?8OyEQIxS0ncTqFuoveL7pgb4ueSmAsId8AO5KXdGljAuDFMETeSgEDXCgXOY?=
 =?us-ascii?Q?Ebmm5tzX33kM6PLQsF0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ad3054ee-71a8-4a15-4d62-08ddb857e277
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 04:29:36.1466 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4iN4OpC5SyOuYUP4gaQO8oOqCV4nKV34ER5fGgLxxiNZ8CNM9eFMTzyusdhagovA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7647
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

From: Vanshika Shukla <vanshika.shukla@nxp.com>

This patch adds DPBP APIs for setting and getting the depletion/surplus
thresholds for controlling pause frame generation.

By default, depletion_entry is set as 128 by MC. This API would help user
configure the buffer in depletion state as per requirement.

Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
---
 doc/guides/platform/dpaa2.rst             |  2 +-
 doc/guides/rel_notes/release_25_07.rst    |  3 +
 drivers/bus/fslmc/mc/dpbp.c               | 78 ++++++++++++++++++++++-
 drivers/bus/fslmc/mc/fsl_dpbp.h           | 41 +++++++++++-
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c  | 26 ++++++++
 drivers/mempool/dpaa2/dpaa2_hw_mempool.h  |  1 +
 drivers/mempool/dpaa2/rte_dpaa2_mempool.h | 12 ++++
 drivers/net/dpaa2/dpaa2_ethdev.c          | 39 +++++++++++-
 drivers/net/dpaa2/dpaa2_ethdev.h          |  1 +
 9 files changed, 197 insertions(+), 6 deletions(-)

diff --git a/doc/guides/platform/dpaa2.rst b/doc/guides/platform/dpaa2.rst
index c9ec21334f..e32ba5d300 100644
--- a/doc/guides/platform/dpaa2.rst
+++ b/doc/guides/platform/dpaa2.rst
@@ -106,7 +106,7 @@ separately:
 Currently supported by DPDK:
 
 - NXP SDK **LSDK 21.08++**.
-- MC Firmware version **10.37.0** and higher.
+- MC Firmware version **10.39.0** and higher.
 - Supported architectures:  **arm64 LE**.
 
 - Follow the DPDK :ref:`Getting Started Guide for Linux <linux_gsg>`
diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index b75405edf6..53a1c8756d 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -160,6 +160,9 @@ New Features
   (including out-of-tree nodes).
   This minimizes footprint of node specific mbuf dynamic field.
 
+* **Updated DPAA2 ethernet driver.**
+
+  * Added DPBP APIs for setting mempool depletion thresholds.
 
 Removed Items
 -------------
diff --git a/drivers/bus/fslmc/mc/dpbp.c b/drivers/bus/fslmc/mc/dpbp.c
index 08f24d33e8..5529a1fe9c 100644
--- a/drivers/bus/fslmc/mc/dpbp.c
+++ b/drivers/bus/fslmc/mc/dpbp.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2016-2017 NXP
+ * Copyright 2016-2017, 2025 NXP
  *
  */
 #include <fsl_mc_sys.h>
@@ -362,3 +362,79 @@ int dpbp_get_num_free_bufs(struct fsl_mc_io *mc_io,
 
 	return 0;
 }
+
+/**
+ * dpbp_set_notifications() - Set notifications towards software
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPBP object
+ * @cfg:	notifications configuration
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+RTE_EXPORT_INTERNAL_SYMBOL(dpbp_set_notifications)
+int dpbp_set_notifications(struct fsl_mc_io *mc_io,
+	uint32_t cmd_flags,
+	uint16_t token,
+	struct dpbp_notification_cfg *cfg)
+{
+	struct dpbp_cmd_set_notifications *cmd_params;
+	struct mc_command cmd = { 0 };
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPBP_CMDID_SET_NOTIFICATIONS,
+			cmd_flags, token);
+	cmd_params = (struct dpbp_cmd_set_notifications *)cmd.params;
+	cmd_params->depletion_entry = cpu_to_le32(cfg->depletion_entry);
+	cmd_params->depletion_exit = cpu_to_le32(cfg->depletion_exit);
+	cmd_params->surplus_entry = cpu_to_le32(cfg->surplus_entry);
+	cmd_params->surplus_exit = cpu_to_le32(cfg->surplus_exit);
+	cmd_params->options = cpu_to_le32(cfg->options);
+	cmd_params->message_ctx = cpu_to_le64(cfg->message_ctx);
+	cmd_params->message_iova = cpu_to_le64(cfg->message_iova);
+
+	/* send command to mc*/
+	return mc_send_command(mc_io, &cmd);
+}
+
+/**
+ * dpbp_get_notifications() - Get the notifications configuration
+ * @mc_io:	Pointer to MC portal's I/O object
+ * @cmd_flags:	Command flags; one or more of 'MC_CMD_FLAG_'
+ * @token:	Token of DPBP object
+ * @cfg:	notifications configuration
+ *
+ * Return:	'0' on Success; Error code otherwise.
+ */
+RTE_EXPORT_INTERNAL_SYMBOL(dpbp_get_notifications)
+int dpbp_get_notifications(struct fsl_mc_io *mc_io,
+	uint32_t cmd_flags,
+	uint16_t token,
+	struct dpbp_notification_cfg *cfg)
+{
+	struct dpbp_rsp_get_notifications *rsp_params;
+	struct mc_command cmd = { 0 };
+	int err;
+
+	/* prepare command */
+	cmd.header = mc_encode_cmd_header(DPBP_CMDID_GET_NOTIFICATIONS,
+			  cmd_flags,
+			  token);
+
+	/* send command to mc*/
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	/* retrieve response parameters */
+	rsp_params = (struct dpbp_rsp_get_notifications *)cmd.params;
+	cfg->depletion_entry = le32_to_cpu(rsp_params->depletion_entry);
+	cfg->depletion_exit = le32_to_cpu(rsp_params->depletion_exit);
+	cfg->surplus_entry = le32_to_cpu(rsp_params->surplus_entry);
+	cfg->surplus_exit = le32_to_cpu(rsp_params->surplus_exit);
+	cfg->options = le32_to_cpu(rsp_params->options);
+	cfg->message_ctx = le64_to_cpu(rsp_params->message_ctx);
+	cfg->message_iova = le64_to_cpu(rsp_params->message_iova);
+
+	return 0;
+}
diff --git a/drivers/bus/fslmc/mc/fsl_dpbp.h b/drivers/bus/fslmc/mc/fsl_dpbp.h
index 8a021f55f1..c79b511715 100644
--- a/drivers/bus/fslmc/mc/fsl_dpbp.h
+++ b/drivers/bus/fslmc/mc/fsl_dpbp.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2016-2017 NXP
+ * Copyright 2016-2017, 2025 NXP
  *
  */
 #ifndef __FSL_DPBP_H
@@ -16,6 +16,34 @@
 
 struct fsl_mc_io;
 
+/**
+ * struct dpbp_notification_cfg - Structure representing DPBP notifications
+ *	towards software
+ * @depletion_entry: below this threshold the pool is "depleted";
+ *	set it to '0' to disable it
+ * @depletion_exit: greater than or equal to this threshold the pool exit its
+ *	"depleted" state
+ * @surplus_entry: above this threshold the pool is in "surplus" state;
+ *	set it to '0' to disable it
+ * @surplus_exit: less than or equal to this threshold the pool exit its
+ *	"surplus" state
+ * @message_iova: MUST be given if either 'depletion_entry' or 'surplus_entry'
+ *	is not '0' (enable); I/O virtual address (must be in DMA-able memory),
+ *	must be 16B aligned.
+ * @message_ctx: The context that will be part of the BPSCN message and will
+ *	be written to 'message_iova'
+ * @options: Mask of available options; use 'DPBP_NOTIF_OPT_<X>' values
+ */
+struct dpbp_notification_cfg {
+	uint32_t depletion_entry;
+	uint32_t depletion_exit;
+	uint32_t surplus_entry;
+	uint32_t surplus_exit;
+	uint64_t message_iova;
+	uint64_t message_ctx;
+	uint32_t options;
+};
+
 __rte_internal
 int dpbp_open(struct fsl_mc_io *mc_io,
 	      uint32_t cmd_flags,
@@ -25,7 +53,18 @@ int dpbp_open(struct fsl_mc_io *mc_io,
 int dpbp_close(struct fsl_mc_io *mc_io,
 	       uint32_t cmd_flags,
 	       uint16_t token);
+__rte_internal
+int dpbp_set_notifications(struct fsl_mc_io *mc_io,
+		uint32_t cmd_flags,
+		uint16_t token,
+		struct dpbp_notification_cfg *cfg);
+__rte_internal
+int dpbp_get_notifications(struct fsl_mc_io *mc_io,
+		uint32_t cmd_flags,
+		uint16_t token,
+		struct dpbp_notification_cfg *cfg);
 
+#define DPBP_NOTIF_OPT_WRIOP               0x00010000
 /**
  * struct dpbp_cfg - Structure representing DPBP configuration
  * @options:	place holder
diff --git a/drivers/mempool/dpaa2/dpaa2_hw_mempool.c b/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
index 118eb76db7..0ba40e751e 100644
--- a/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
+++ b/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
@@ -46,6 +46,32 @@ int rte_dpaa2_mpool_get_ops_idx(void)
 	return s_dpaa2_pool_ops_idx;
 }
 
+int
+rte_dpaa2_dpbp_set_notifications(struct rte_mempool *mp,
+					struct dpaa2_dpbp_cfg *dpbp_cfg)
+{
+	struct dpaa2_dpbp_dev *avail_dpbp;
+	struct dpaa2_bp_info *bpinfo;
+	struct dpaa2_bp_list *bp;
+	int ret;
+
+	bpinfo = mempool_to_bpinfo(mp);
+	bp = bpinfo->bp_list;
+
+	avail_dpbp = bp->buf_pool.dpbp_node;
+
+	ret = dpbp_set_notifications(&avail_dpbp->dpbp, CMD_PRI_LOW,
+					avail_dpbp->token,
+					(struct dpbp_notification_cfg *) dpbp_cfg);
+	if (ret) {
+		DPAA2_MEMPOOL_ERR("DPBP set notifications failure!");
+		return ret;
+	}
+	bp->dpbp_notification_enable = true;
+
+	return 0;
+}
+
 static int
 rte_hw_mbuf_create_pool(struct rte_mempool *mp)
 {
diff --git a/drivers/mempool/dpaa2/dpaa2_hw_mempool.h b/drivers/mempool/dpaa2/dpaa2_hw_mempool.h
index 8b2718bfa1..47ad7efb6c 100644
--- a/drivers/mempool/dpaa2/dpaa2_hw_mempool.h
+++ b/drivers/mempool/dpaa2/dpaa2_hw_mempool.h
@@ -48,6 +48,7 @@ struct dpaa2_bp_list {
 	struct rte_mempool *mp; /**< DPDK RTE EAL pool reference */
 	int32_t dpaa2_ops_index; /**< Index into DPDK Mempool ops table */
 	struct buf_pool buf_pool;
+	bool dpbp_notification_enable;
 };
 
 struct dpaa2_bp_info {
diff --git a/drivers/mempool/dpaa2/rte_dpaa2_mempool.h b/drivers/mempool/dpaa2/rte_dpaa2_mempool.h
index 0286090b1b..c1cf160a21 100644
--- a/drivers/mempool/dpaa2/rte_dpaa2_mempool.h
+++ b/drivers/mempool/dpaa2/rte_dpaa2_mempool.h
@@ -19,6 +19,16 @@
 extern "C" {
 #endif
 
+struct dpaa2_dpbp_cfg {
+	uint32_t depletion_entry;
+	uint32_t depletion_exit;
+	uint32_t surplus_entry;
+	uint32_t surplus_exit;
+	uint64_t message_iova;
+	uint64_t message_ctx;
+	uint32_t options;
+};
+
 /**
  * Get BPID corresponding to the packet pool
  *
@@ -62,6 +72,8 @@ rte_dpaa2_mbuf_from_buf_addr(struct rte_mempool *mp, void *buf_addr);
 __rte_internal
 int rte_dpaa2_bpid_info_init(struct rte_mempool *mp);
 
+int rte_dpaa2_dpbp_set_notifications(struct rte_mempool *mp, struct dpaa2_dpbp_cfg *dpbp_cfg);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 1d11847d76..bf6d6fc418 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -745,6 +745,9 @@ dpaa2_dev_rx_queue_setup(struct rte_eth_dev *dev,
 	dpaa2_q->nb_desc = UINT16_MAX;
 	dpaa2_q->offloads = rx_conf->offloads;
 
+	if (priv->bp_list->dpbp_notification_enable)
+		priv->enable_bp_flow_ctrl = true;
+
 	/*Get the flow id from given VQ id*/
 	flow_id = dpaa2_q->flow_id;
 	memset(&cfg, 0, sizeof(struct dpni_queue));
@@ -1176,7 +1179,7 @@ dpaa2_eth_setup_irqs(struct rte_eth_dev *dev, int enable)
 
 	return err;
 }
-
+static int dpaa2_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf);
 static int
 dpaa2_dev_start(struct rte_eth_dev *dev)
 {
@@ -1191,11 +1194,27 @@ dpaa2_dev_start(struct rte_eth_dev *dev)
 	struct dpaa2_queue *dpaa2_q;
 	int ret, i;
 	struct rte_intr_handle *intr_handle;
+	struct rte_eth_fc_conf *fc_conf;
+
+	PMD_INIT_FUNC_TRACE();
 
 	dpaa2_dev = container_of(rdev, struct rte_dpaa2_device, device);
 	intr_handle = dpaa2_dev->intr_handle;
 
-	PMD_INIT_FUNC_TRACE();
+	if (priv->enable_bp_flow_ctrl) {
+		fc_conf = rte_zmalloc(NULL, sizeof(struct rte_eth_fc_conf),
+				RTE_CACHE_LINE_SIZE);
+		fc_conf->autoneg = 0;
+		fc_conf->mode = RTE_ETH_FC_FULL;
+
+		ret = dpaa2_flow_ctrl_set(dev, fc_conf);
+		if (ret) {
+			DPAA2_PMD_ERR("Unable to set flow ctrl");
+			return ret;
+		}
+		rte_free(fc_conf);
+	}
+
 	ret = dpni_enable(dpni, CMD_PRI_LOW, priv->token);
 	if (ret) {
 		DPAA2_PMD_ERR("Failure in enabling dpni %d device: err=%d",
@@ -1298,6 +1317,7 @@ dpaa2_dev_stop(struct rte_eth_dev *dev)
 	struct rte_device *rdev = dev->device;
 	struct rte_intr_handle *intr_handle;
 	struct rte_dpaa2_device *dpaa2_dev;
+	struct rte_eth_fc_conf *fc_conf;
 	uint16_t i;
 
 	dpaa2_dev = container_of(rdev, struct rte_dpaa2_device, device);
@@ -1305,6 +1325,19 @@ dpaa2_dev_stop(struct rte_eth_dev *dev)
 
 	PMD_INIT_FUNC_TRACE();
 
+	if (priv->enable_bp_flow_ctrl) {
+		fc_conf = rte_zmalloc(NULL, sizeof(struct rte_eth_fc_conf),
+			RTE_CACHE_LINE_SIZE);
+		fc_conf->mode = RTE_ETH_FC_NONE;
+
+		ret = dpaa2_flow_ctrl_set(dev, fc_conf);
+		if (ret) {
+			DPAA2_PMD_ERR("Unable to set flow ctrl");
+			return ret;
+		}
+		rte_free(fc_conf);
+	}
+
 	/* reset interrupt callback  */
 	if (intr_handle && rte_intr_fd_get(intr_handle) &&
 	    dev->data->dev_conf.intr_conf.lsc != 0) {
@@ -2110,7 +2143,7 @@ dpaa2_flow_ctrl_get(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
 	return ret;
 }
 
-static int
+int
 dpaa2_flow_ctrl_set(struct rte_eth_dev *dev, struct rte_eth_fc_conf *fc_conf)
 {
 	int ret = -EINVAL;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index b501fc091a..4e3e0338aa 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -413,6 +413,7 @@ struct dpaa2_dev_priv {
 	struct rte_eth_dev *eth_dev; /**< Pointer back to holding ethdev */
 	rte_spinlock_t lpbk_qp_lock;
 
+	bool enable_bp_flow_ctrl;
 	uint8_t channel_inuse;
 	/* Stores correction offset for one step timestamping */
 	uint16_t ptp_correction_offset;
-- 
2.25.1

