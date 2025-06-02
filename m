Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA20C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 10:41:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 795AE40395;
	Mon,  2 Jun 2025 12:41:09 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010038.outbound.protection.outlook.com [52.101.84.38])
 by mails.dpdk.org (Postfix) with ESMTP id 7521B40663
 for <dev@dpdk.org>; Mon,  2 Jun 2025 12:41:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IY40H4w2TRmBRF/t4tBBdtcblKmkE2eooOLW7ogE/jZXVt4oadHDCDNIRLV8MMZOYTFE1yWI0zzdeGXwC2FYxh/Zcqo3uxL/HC7H4cX+ge2ZgrfxQ7rtp89oKsx79iW8imtRwbHCKkbvhfIeZN8p4eQzJZQzMGDPtleGhhw4JZUHmD7c2wcgivo6tis/2XgTK71sksIFHy3QkQtEVx7vgyewYQdu15uwf1UMPB5WBmAJ7F9sG80q3mdF3mkqcmBJtiW/WBwnT2Dq7ptADRo+2t6egWRaTvqUB7Y29QJ8OA2S3SEN3Gvv23eETb14SU8nK32zrWXfcnMJIHwe3AcA6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdDt7RlcMilD0rxGmIK7K4ze8JuE2v3iqfkDVi9vBH4=;
 b=f670YfM3KLlWndVJaHZHWxeaHc3AUgUXnZhYblQlH7dUS96ensaNSKP1tkOi91QgZ5tIoDglAEWwk0tnUuTZneUnUhb7EBEeAyHiUXFJr5Nn5/G3QDfZBe5O2khUH0BdcKKKwWAVV9YQEygqnbFKC2SmAwA57+LwH/y7vEO3p2w1ITPV+23oBPQ+p7KDtU01mtxG1Gzf35vBWuFqaolEx3a5x57DJhIj/6mG/0SQiqy5nXVYWn264J1CmLFVnDATVVUtxewMdpGbbeSs/I3J61brcGNp6XV1/A5V548XEihJe8/2zZWJh/3YZm3OA2NJkH20PFMtsMzXeEatmUswSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdDt7RlcMilD0rxGmIK7K4ze8JuE2v3iqfkDVi9vBH4=;
 b=O+TAqVC0q+/TZRsgsER2v5f68IdqlNc1sQfyvMT8pWikypYZ7+qXmHxY04KEGCmUsBdqrgbGGSgAfoABdDcy0H6fw+0XX5NbhFIhE+Y13eck3sOQfj5bxsQA66mXooxTLoeFXoZrXKUNP5yuZ/Bg/XSaCb2TtIJZpdINNAvRGcFj2fPUWeg7tfGam+mkKMH33DEz74XgtZ+TBswMi/dzERgSilMYVdYjv7x5puGFKGsTD+dWBbjF4iLI8JL+7JS6qmwICcSQligoLhU5CrWxpsbk+M1y7zKYGW5ppO+P8L59/FZZjKQ1DcW5Ob3p6/NST4Cl82fAsDw3Su1n4c0bgw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8194.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::7)
 by VI2PR04MB10956.eurprd04.prod.outlook.com (2603:10a6:800:276::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 2 Jun
 2025 10:41:06 +0000
Received: from AM9PR04MB8194.eurprd04.prod.outlook.com
 ([fe80::cd61:3920:b12f:6561]) by AM9PR04MB8194.eurprd04.prod.outlook.com
 ([fe80::cd61:3920:b12f:6561%4]) with mapi id 15.20.8769.029; Mon, 2 Jun 2025
 10:41:06 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH v2 03/11] bus/fslmc: add DPBP APIs for setting depletion
 thresholds
Date: Mon,  2 Jun 2025 16:10:33 +0530
Message-Id: <20250602104041.3322164-4-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250602104041.3322164-1-g.singh@nxp.com>
References: <20250530071344.2939434-1-g.singh@nxp.com>
 <20250602104041.3322164-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To AM9PR04MB8194.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e6::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8194:EE_|VI2PR04MB10956:EE_
X-MS-Office365-Filtering-Correlation-Id: 8adf063e-d3a3-43a9-56fd-08dda1c1fa43
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?beb1Ncp42pLOqXr723kqAAcssGDKGB9iRhcDSMZC9B1tnqZkHLR1YEYt2KK2?=
 =?us-ascii?Q?+rmx4xlL/tZIQ1demKYOLBAa/AkH351gZGbGDWb+WI/7RyWNAGvC/nt58AOF?=
 =?us-ascii?Q?DLIPSzYk9iaUzwbmy0SU7Pm/moxte7DUs290fNAuWXii6wppVlVGaeqd9Jo3?=
 =?us-ascii?Q?7G2D5qMS9S1qiohxcRmVRQflHmZX+Jsu6hzpQtcjH5NJ/4TMaxWsKbNIYgVl?=
 =?us-ascii?Q?tepNUZ4P/jlihxWx3Ev/XZNGDX4bsnJZP/3V9yn4QmFpjiyWehDJTeqK8c5s?=
 =?us-ascii?Q?rDqhEesyILzxcpne+MKvMe4qXi8DJupoiGY2u0IJrdg8JpqLbB1VT+CTR/nH?=
 =?us-ascii?Q?nV20dHFVx9fstVRy37n4mTYv3O7iAuM+ahNHavnH3s4VHzUjivkA+T4/6w3C?=
 =?us-ascii?Q?2pod/E9ZVuaYiUEQBxciDulwem6FV0YOEW3gXbqxo0lLZ9AIc6s04bbDEn/G?=
 =?us-ascii?Q?1dl3DS9vIzw5Npf1T9mlj/2/JeWtwu58dQm6Y8R/ilktycvyscXbPUmBpUtt?=
 =?us-ascii?Q?CBSSoMR6PVdv/4NmzXRKh5WZupcfM8fBSFvWJRAOMqOnogcbKcQRNtcrm35I?=
 =?us-ascii?Q?vrlnQ6kSjG0oDFTZbhw8NluVwheIo5hLJnc0RhVRzhUvxS0UF6O30gDkdgt0?=
 =?us-ascii?Q?52Ovy+GRfjB3Devm5AOHGgABbuadNUBBQA9/OxUTrMyRz5s07mIB8PtNBN/f?=
 =?us-ascii?Q?Loc2Vk/LrH+/6uEHaaoj6sH+rPsC0NxhInfwIns13wNfB/1s2k0vvS2G3FnO?=
 =?us-ascii?Q?bNZc6BQL9rLWndbeIVbL/z8x+ga2zTdeBv1pC903y6caW81XbZaDVoM6s59e?=
 =?us-ascii?Q?KrBqs+Y6ItPo/GQQAb4wrH7/xzQ68sppvZkQsitMgFgEqGUh70T48i2S1MSt?=
 =?us-ascii?Q?ACgdjoMKpz4DJuaXUX/mfmbifBAGuhcAaRQ1+dX2hO5g+p+OAByLR+nO5uFW?=
 =?us-ascii?Q?WFnGiHIZ7WdBXkZHnVmjyFUdEPVokRibDPlsW+Egq4YcDI+dv//NSmQmaVlt?=
 =?us-ascii?Q?sgor5RmwDSHpBbiv12B4MknMe2Dfgomm2Ye8+9h7gVUa4KunZjzCbonKs/Tz?=
 =?us-ascii?Q?7ef9AfhxCzfb8dW513MwUfWNcJmfC4jPS0CfhNs/GpJv+eEKXLqaopY3qqHD?=
 =?us-ascii?Q?2J8S1Rm15ErAusY7EqCAcURVMETy7Ou+mfJPvFxzgSNXMbGkvr9ZJu/1xwmo?=
 =?us-ascii?Q?xzMtioPyU0kE9KPbDF3oNxckY03v09DNlRuabmVjvp2605PYYFvDPA9Snad+?=
 =?us-ascii?Q?FhDbeXy+/lXTz8c5WQ5IaxVk4joIbnIQofSIk+4Vb866CYjPHVx45Hrh4pKS?=
 =?us-ascii?Q?7sufv5r/qWmpmcNtFEbvFXG8lnXmB/gvnaksTOtnA7oChgLvDvDqdMLhyV4G?=
 =?us-ascii?Q?c+4WFd0r6XUwh2XuowQmPG0+ks4LUl0CKbkO1CZRiMUtmyb8P5QhWs+p3esW?=
 =?us-ascii?Q?uQHD1yf7VKctEZUjR6+2+94e2hj8ArotQcqJ3LP6SuqTuQ+wCFZpQyC4HRXY?=
 =?us-ascii?Q?KMZg9ohQqM3KVJY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8194.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?97BSvkB7tG95KL6Oy5gTbb74+ZKKQNO9oQTUhHcI6Rt/og8ikduzLDlwRcQs?=
 =?us-ascii?Q?QV1nCCMUvFiaiPyZdWXebMGgDxYkpZERn5/11FlilCMixz2B1BCxliatv6+9?=
 =?us-ascii?Q?Yw4Cbu0p41mGlmHe6AfAdySmFW9UaOFyc+esqzSPDXGcg/DOHufsYbj4VmQh?=
 =?us-ascii?Q?tusHN6RLwldSlNnnV1O/ncV834xJidICzb879mmnvTEYzdI5QRfnqAPRm+Yw?=
 =?us-ascii?Q?Hm29NqOmJc4V4L/XGvh4fTMsVtbrG8Ie9BxL4vWKDWq2zW2iQaXfDvo1amKj?=
 =?us-ascii?Q?h00KJH2jLNMMJBo80LCUY/qnXT/wI9dDuekt4oQCHw8Ci8pprArZDOLsbP6U?=
 =?us-ascii?Q?zASjo0V7fu411/L+Lt59Oze00BwG5I3gNduIX/9i/G7QkyC7LvxeVX3BE6Qm?=
 =?us-ascii?Q?bahx9/Ly+683dDaFp+KA1QNM2Y/fmoPY67MBPGRY4DkPsPRIkV1wc0whVwX+?=
 =?us-ascii?Q?0P5shESrHo4ZgaMpT0+1CW79fAdYvRLdFqXbZNTs0I4s5tNBMoxCY7SbTa9a?=
 =?us-ascii?Q?eA3Y9Z+tpZdArGhQIR2EF8BzzLgX8b4+Inuj6Diw8JJ/v2THR/Vr/AdoJgLw?=
 =?us-ascii?Q?CZ0aQsmXh2KnV+dpaFvpS0Di7+JwDGkRE3FFF9qfnwm+Hdom8aqHIJ41r6bD?=
 =?us-ascii?Q?DsmKFz2atspC6MRdbeNDRXzfHTwjWFtKA3qTjdPZVqAYj3DnQIsbUFXP6zJs?=
 =?us-ascii?Q?ciKeuf/yVXOn3I532slViNzvjhhqLlhoNcgnapVtHpQ46wITQ7VAvBJQofW5?=
 =?us-ascii?Q?QpPS4H48X0M/Y646+dRm6y7OL5i2tFtzFf9qjXsRuxUAjr/Q8egVm5XL96LK?=
 =?us-ascii?Q?5pduzPnIvdQsZjoBkOlENZSfNipfIN1clls9IJM+IuX8NKuevKF4N3nfJnpt?=
 =?us-ascii?Q?q69Z7OSZwN4fZNndOfxwWHU0TfhLEPsD80yfNU/dieHFQEsFsMOtAGqvdtn1?=
 =?us-ascii?Q?hhXrPSnPu2eODmtKyvnySCCx1CVspcLqZz3/RChAvaCxgIo7PMxQuK0fDXjo?=
 =?us-ascii?Q?bWjRLmWf4N1LVIjPIpD1bVJbY9iJs8Kqv4ivNXulKj+x9P9UAk4nktR7ZvHd?=
 =?us-ascii?Q?d1f8zcw+YTxE4i1Ve3pNdD7jlVZ5r3yYblbxqlYS0kUhyLV+sDNiWiMAx0AI?=
 =?us-ascii?Q?j0stZzMj7mz5xOHXIOwzBz4Hors1oQVUH7L7CIkWQKX2iW2E9/G4Bx/kREnt?=
 =?us-ascii?Q?qNoXU1ycLXmO7+9NOcQnwHbn/OqGRRMxL7/muSHXkeOYCCGh79KXe8HxQHmk?=
 =?us-ascii?Q?NMMxPMfqqbP9UACqAiR+XKZdDXzztcpXWtvB/JNS23edmza/etJH/DabcsRZ?=
 =?us-ascii?Q?Rl89Gk4lKISP1KpRlL8SA/879Nnm4WOx8uq+I5P7b44IxovQcfv14yg28F87?=
 =?us-ascii?Q?o8F3PcsUV1Vp8PRPhiTRACJ2VjZdtkeM638ojjkdtMx5p/qrTMNtI7YY4/8T?=
 =?us-ascii?Q?YE0p48hWa7v1YsOMqNk1rt5TeLZK1q4caiWQr3WayujgfF9czFuOPcrt1LbX?=
 =?us-ascii?Q?RNXYHfH6GCkeGPfC3C04eI60monBG84ah0Q27A++YQbD3GYc7UMi9v9/GsgO?=
 =?us-ascii?Q?1ltzebPGXo4+oAu3biQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8adf063e-d3a3-43a9-56fd-08dda1c1fa43
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8194.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 10:41:05.9229 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mKyCdabpagBygqjcKy93HWWXiSiPjmA0hPO59vs0Ks5hmiPWA0OEXNfAIx9MMseB
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10956
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
 drivers/bus/fslmc/mc/dpbp.c               | 78 ++++++++++++++++++++++-
 drivers/bus/fslmc/mc/fsl_dpbp.h           | 41 +++++++++++-
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c  | 26 ++++++++
 drivers/mempool/dpaa2/dpaa2_hw_mempool.h  |  1 +
 drivers/mempool/dpaa2/rte_dpaa2_mempool.h | 12 ++++
 drivers/net/dpaa2/dpaa2_ethdev.c          | 39 +++++++++++-
 drivers/net/dpaa2/dpaa2_ethdev.h          |  1 +
 8 files changed, 194 insertions(+), 6 deletions(-)

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
index 09729d2828..eb22a14fb5 100644
--- a/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
+++ b/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
@@ -38,6 +38,32 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_bpid_info)
 struct dpaa2_bp_info *rte_dpaa2_bpid_info;
 static struct dpaa2_bp_list *h_bp_list;
 
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
index 9e21823fb6..f2583be4c6 100644
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
index c154a574ce..d17785a6ee 100644
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
index f32c31c763..103fa2ca67 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -409,6 +409,7 @@ struct dpaa2_dev_priv {
 	struct rte_eth_dev *eth_dev; /**< Pointer back to holding ethdev */
 	rte_spinlock_t lpbk_qp_lock;
 
+	bool enable_bp_flow_ctrl;
 	uint8_t channel_inuse;
 	/* Stores correction offset for one step timestamping */
 	uint16_t ptp_correction_offset;
-- 
2.25.1

