Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98035C71148
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 02:12:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 68A1F42E4B;
	Fri, 13 Jun 2025 04:11:52 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazon11012039.outbound.protection.outlook.com [52.101.71.39])
 by mails.dpdk.org (Postfix) with ESMTP id C2B9642E50
 for <dev@dpdk.org>; Fri, 13 Jun 2025 04:11:49 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yOpD0LrGk2c+wVBKrQFz6+fKniAe/4Go8ns5X+ZeOrrUgDdaSwYQvPpi/uK7snYsVyELvZe+cbhwMq0RMtWinASdfVNBo/UsejkpvgF5g9bhCyiwofl3pmt/eC7oamf5JjxvXRYBLmd4iQLa53uRI0gncD+otq8AOuCjhMhH8T1jpziZUQItYubAByQypsxKgw5SCD7Ow2QGwgs+B27cx7iT8CqUT5MfNnOHTSmxsr+80W3j2gGRx8PzrhOk8bhwdDCPXmyPct6hiciZWJyYUMEBIkICbOLs9xehldr7VJ9jtZtzFZZ5byyElwKjuNxcbqLRJ+VcXK64N4D8nGNKuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLvaXgm/do1Sk2sR4ac6B7vjk7yE27XA0ZxR0vWCasQ=;
 b=OGSVqmumsVuzNyxOZyr1cCe2lWzjWy9XRw2nfVlCod1xxMoVMzBG0ESz4OrX9/ate8lNfKZEO7Zqa+3DO32s/Yf/GQBbVqp0g9ESIrUegw+/ZYwdXXyU954xFG3Qd3herJu2w+7gbp5ob6w5skI/Q0s//uVKfWj0kQ+7hSMwCbk9ZrjTDA8h2FEkAeZBPWmTSPyakrXC+OReitnxT8AOby2YnZW/YFkxDW0rDBVJT5KvFBe+8VbElyGwqD2tHTqwg72bxm9BTuI8jV/QVMPAiJAhSU38rqNDvte9gfd6N5CFLnifX4DWV6QDVJxV1b5deXAOSZX783Z4DxMUgbllGg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLvaXgm/do1Sk2sR4ac6B7vjk7yE27XA0ZxR0vWCasQ=;
 b=oUzrMTmbHUYtp13O7geJUdT1Mydy9eIQNt8Zb99YgvfZH2SIQZLc/C8l2AAIQ7036djqE+bucrVw1yWqj8W8lyYpuCP15EPj3xdAZqIP+IVYN60EttOWskpOtbrs+EpSu1zuuVOUfc1arTVWo8evD+DuYtiU3A3yOMJm7AD+BLJV2XxKBmxPWgZkDgaYQJTWmXtV+Nm3LmTMiqGm6gVHypsNIKXfbgOOpBGZpcgi0djE8N0HSGsakej9JMVZwpKYK8DRES4j76wXOHkkWRB1MgVA7G4ho4iCDsPGnYLNT4fkw/EkVivpXf5qF9u6+CM9UA5LdTkkF7cI3vN/IDVMxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by DB8PR04MB6907.eurprd04.prod.outlook.com (2603:10a6:10:119::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Fri, 13 Jun
 2025 02:11:48 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 02:11:48 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH v5 03/11] bus/fslmc: add DPBP APIs for setting depletion
 thresholds
Date: Fri, 13 Jun 2025 07:41:17 +0530
Message-Id: <20250613021125.790614-4-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250613021125.790614-1-g.singh@nxp.com>
References: <20250611105149.655144-1-g.singh@nxp.com>
 <20250613021125.790614-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0124.apcprd03.prod.outlook.com
 (2603:1096:4:91::28) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|DB8PR04MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 0041a4c7-620e-401f-2e75-08ddaa1fa6ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Qjr76ybJuDWo5rkQO+IIPb5ileGWxXXnov7l8yqA75pxXpeiFg9ivDuNZgKi?=
 =?us-ascii?Q?arqK0AGLGomf+Jw+0JSoerA0jx2Q26qOO8OKx/6mc9fu60C/KqyqMuHoR5x/?=
 =?us-ascii?Q?cJemdROX9LOLO3jzs+DPG/z9IfhN+fVnEqbNX5UMMjDJfkcZl4LVAe75dEPz?=
 =?us-ascii?Q?A42NWIdLhn5fdttF/qqLW2PUbZ8o0PUlJicn/QINUd6+dOeVRW+4cjEhoprK?=
 =?us-ascii?Q?Cq9ZWAhPAKXeFPI1QiRqzmTT/7pjnVk9Dg036E8IzX6d8xEFATZQyKbLWslX?=
 =?us-ascii?Q?QgTaYiR/NJinsTEshgOirYZf/ml8Gb431Jp+oExf9b3/mH+FYJ0dmiJLUaEL?=
 =?us-ascii?Q?wOCypnV7tBXBDolDmeqUOPWGjHZ+OQ7C1kmRoShv0uG/J5cfcjPX52jPSwu+?=
 =?us-ascii?Q?XGWK4Bjuw7H8N7tSyoslJTEsludV1kVlK09+oKnPGakY83U7GxhXVWev3hSA?=
 =?us-ascii?Q?PpQk+SrgQ5Py96GxGNOwnpSXybohkwGDe6ZLqkIiduK+JPDEWvpJwEUNRAaN?=
 =?us-ascii?Q?HpmU+ULq6E/AzGok69tVjvHdKXLs2uThfou0EPR2I7pY0q1Pcszuhl/IDvMj?=
 =?us-ascii?Q?F28jVZ/e0pWcEpbXfMkdz39bwCxGNWmO6qFgJNhF9uBc6vZKlZsDOBhdHl19?=
 =?us-ascii?Q?yKfQhzaoTi1yPkMajKbX8v0XimB1W4zeHuOHturDH3bcGscO+iRwrFsjQe04?=
 =?us-ascii?Q?Kw9T6bfos5mu2soIrChoqhmAZ/mo4tdNa2vyV6+9Sky7scZQf4vDDNzrqM/P?=
 =?us-ascii?Q?Qnm1QL9Ma03s3ARzXW8Yp4Dx9gIxp2EDQ+FwpWLpz4we4+r/DHhFgddmGpaz?=
 =?us-ascii?Q?y5DYUX/PVawC0euHkXmYcUlGVEeLIr8YvKn1WC/ScNIn2UDfhicIrK8qXd2e?=
 =?us-ascii?Q?CjKIDsfcNX9txM8DsgPhkgak2eApEs9HDLIfvt9B/mIJENtANyzMNeuacQLe?=
 =?us-ascii?Q?+AVN4HxEMXEHxoWTV27LTH86NZW88S6k7l/EAFD8md1oHVUTXWYo+R5n9dYy?=
 =?us-ascii?Q?xN5514T/owt/NJ6AzTx8tAfS89TWeUnSuNlkvB+ALXegq7ez6e3v3KpOVZNc?=
 =?us-ascii?Q?w30tE6/m42kGwfRyVSzl1Qhf6EUBJFs2Sr2G4eyzHnnQqSBkVlW45OYar/D5?=
 =?us-ascii?Q?qK3wo4BumQjovCzNwkY1TWr/TX3X05+xcmm4WhEVGqPZz+1/wm2hitRP97eK?=
 =?us-ascii?Q?6td54p0TSz+SBi430hF/Ctls0O8/NvJXTlm+ljua1rhQGdzzQeZhgqHsA4rs?=
 =?us-ascii?Q?WiwOI7Glp/LGlxkdsWB9qZFe+w4x2FJQLch/57p7I6TeMFvC5Cv2OahWBb6U?=
 =?us-ascii?Q?RcDQRbnmpjQh+IzNSxrLqTs3tfdZuKeUg+fH9JkcnkZ7S/QGtbuzAh3eqg0b?=
 =?us-ascii?Q?q4c//KovOe/3zuomsszyyRVHOEuQzAHxNJOwnxNK8chjkihvCd0QNU2O+v8I?=
 =?us-ascii?Q?kU12d/rUJHRp45v/q+pKyLSSHzZ1+XyqMKzlBZVtBtsykKtSdlWrNg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4Ozxr0Jp/PyuKx2oAc17Zm6e6G7z6G+XQ5dW2IDcXnQ7rsbQC/9CEusH8W6V?=
 =?us-ascii?Q?XX9MZsh/iZfgioOFhOidXZ5b6Yoxl2nZKVQt5PTMX7A7vR2dKvl+3r9RwNY5?=
 =?us-ascii?Q?QVxMK4jJ/5bQV63LAN72eAY639EH852pSx6c6XhHNoEH5yUtaOkxikNJB2Ku?=
 =?us-ascii?Q?I2OkWoBeQMs5MAtoOVqLtE8e44KSts5pRgdQNuRDqQwfpMVT97IEBsSs2u39?=
 =?us-ascii?Q?/fEhKZxDCBVkbief+B752C3T6+vHPNv2uGaQZMS0azMSC2QnBQ99bmn6FM6g?=
 =?us-ascii?Q?pZ04lIrAMJI3NWLtYOHFZQjLZOR6YWmer17MGkpNNGGP1Xjvi/p7c1Y02D4c?=
 =?us-ascii?Q?qHDCcfTim3Wuik1Fj9GFlMqGJ3rMBrCAFXbVxfeG8Ck4tw+4TXt9luhM8qbp?=
 =?us-ascii?Q?/0zC0TclLSaUtcZcGbUTEi0OZ6evNNNsbx2RJwv6d0FkmEbg4PpJqzE0RewW?=
 =?us-ascii?Q?1WZ8xMQkuBFjAYw7qWF8nsiprzSGsVITc9w5UelJRSgCiDZk+ndegjvGhcFh?=
 =?us-ascii?Q?Sd+TxSDjfGsLUgn0bROj474V1tCc7nTRq+fNRQWtUAwGMbTs1K3ppIR/hmze?=
 =?us-ascii?Q?ZLePO2Wjuf0MsaiSawscD8IGQyM0b9F0WVTuHApp8V0+Q4LLDdIeSt4U016N?=
 =?us-ascii?Q?Yd8feN7z2AGmGhgEQmHm09xKl0lEShZJNkS1aVppHHhcgou2XRVMCdSeLJxM?=
 =?us-ascii?Q?wkHRK+oHNTIAhdtbXSg85C7GurPd3d/gpKO8NIcUPIW/qhkpR88FaHR1BGYE?=
 =?us-ascii?Q?8AJdfPTwFRk5Zva71sA6Z36veWsHpzeqBew+e0rCMfP1hEVGtBA8JuU7hSPs?=
 =?us-ascii?Q?x6r8vOeGyihY2SDOgrOty2dwysmmJAapEXO3yFCtrusiac/vp2nET08TYaMt?=
 =?us-ascii?Q?pClcLIdCszd9eWM3pSp3KDWapbH8R4Mn3gMUh2wg9Y/SGc7VbvXCmeEuf/tQ?=
 =?us-ascii?Q?Y3npNBK80okQGk6OqdJHhQieDuO9D17XD03mauAV6byXYi/BqtrJTepJ/J3m?=
 =?us-ascii?Q?Z0CYSvXCpSMhXtCelWrBVTk8jmeTkZz8PPL3LkDA8a9MHHHFHNUN5cQRQGh9?=
 =?us-ascii?Q?yBaXwyPpOsJbZE1oaPKihvcWtMTokEnVETo8k8oqlx8fkJPTaQwHptkmDqO9?=
 =?us-ascii?Q?P1kA8/MeXAaWL/e369SB0+B5a5Fs+05T4LvnrIdQE5mzmspDB4xVW5GXz2Im?=
 =?us-ascii?Q?Z19biQyO8vvL+DkIpqMTaE47rOTPXqEdTRak5Pb55Hdw+MsXTDy51goW4kBd?=
 =?us-ascii?Q?fSPzg7PbzFJr/MN1oHsNDIJdrdUZODGd5DYz9D42dBi2xHnhVrlBGs82RzsT?=
 =?us-ascii?Q?5ee68JGKT6yKT3wm6fRrs/v8TNCHEuneA2mqgd70946JlSFt+dzUldZBYceo?=
 =?us-ascii?Q?tnhWUciUB5rNPtvUDIwlLrdy1o36Q5K8d3jBL4MwQaGqho65uGwzAdeLaGkb?=
 =?us-ascii?Q?/chyDExuxlX3QXX+gVU8gl+T1j2R6IcimDg8df16wo3pgr9hAyZ68TLthiCU?=
 =?us-ascii?Q?VvPLKPT4HkEkjgIL+RRd3YlEPxAOR95ltkra8rTKDpOGziQE1/hmIjGMnODx?=
 =?us-ascii?Q?Y/iN/fCLviCQqK9nWE4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0041a4c7-620e-401f-2e75-08ddaa1fa6ff
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 02:11:48.3359 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vCB+c8rSkhg0tjjsA+cOFfHdcyr5ZT+foA9DOLt7UO43HucRD9N+bQtnWxxWHumP
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6907
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

