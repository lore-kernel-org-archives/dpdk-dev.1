Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9580C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 02:55:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 44A2C40677;
	Mon,  9 Jun 2025 04:55:33 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012013.outbound.protection.outlook.com [52.101.66.13])
 by mails.dpdk.org (Postfix) with ESMTP id 325D6402C2
 for <dev@dpdk.org>; Mon,  9 Jun 2025 04:55:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C929B/WD6mPtM461IARLrezr9engYXTBDaWvE7twllMMuN1e3GEun08E1EBkpIc73LsWNsO/ew56NJB2x0W1FG/rVbt81j32bclJPJEyHFWgUR3VCIJOr46Ab7IE4V7sLVji4ng3GrLIpIYC+KaZCWQHZbf4N013CqjODxJG4SyrQ8ySafYuDlDUaSbGbBLuImpNVKaf802c40MOiXc7Nyoe4ijuj33XY99kKWXCF5GtRziI5a9QXdEuozxabzZiu88BAt214iVeka87nWQeXIGEhs8H2OaeFe1KD8OSQ5WQQ0Q8Cyq10ts47dDZqH0aNqkjLul9Nt5ayk0w00q8UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdDt7RlcMilD0rxGmIK7K4ze8JuE2v3iqfkDVi9vBH4=;
 b=Bc0LRSZQbY/o2sbwV2OXsBx/2nlnjjwDqx+DmSrB1S1wPXqUyQ/yPemdUAETZ/xiM6DfSc1ky01xdB+9DOzaL8OFR0r88xDeuVW0Xh/VlmzOxeXQKGOHwiEwS70/weL/iqL40Ab2T2OljXANw5LDLT8nvL9ZkZn9+L9ZTYuYkujWG4IV3HjfNwvBv78tnwOKaIEtN9ppSNJKR0pT9xf4GctkFs5YPNESRieRBuDlucgPpp2Bqu3Jlat2cT5plLr8S+HzbKTYK5duOKfzX4HZmad2zKidmNxreXt9BGumzRi/fBH8l7Wzuulzf2SH0Tn/4OUhlRxBmKa3dQxtnK/iQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdDt7RlcMilD0rxGmIK7K4ze8JuE2v3iqfkDVi9vBH4=;
 b=iiqKMOUnuOzGLBaYIoBhse5VvGjPF0dh0gQBvKlgKtZrgTrjOjL9TUBwPfR/MrQ2T9Db9lA8SUxX5ekovI6vGy0Zh6mJOHOS7VTfiWOhAVrqaeTSzP3YwlQc8YAyc+EogPbBpno7QCwVQsxxryzb7b8c8M0Wr1rnqgcPYD1UaVddGItHVOTNJLi6BUbslPHGivmmjLV9QJwHFOKcSc+1k2iRlBetLJCfuAjz5HausLZ1R9i4XOjPm8f0uVCbzP/kw+yHMGNuEuHVDrGCLO9LO63Oemgi4jn1HArAUjb7YlP2uHGcrNR1fYSX8ntYJEpKdsqyWfVuHWKLwwIGqKsyMA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AS8PR04MB9093.eurprd04.prod.outlook.com (2603:10a6:20b:444::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Mon, 9 Jun
 2025 02:55:14 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 02:55:14 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH v3 03/11] bus/fslmc: add DPBP APIs for setting depletion
 thresholds
Date: Mon,  9 Jun 2025 08:24:42 +0530
Message-Id: <20250609025450.3997062-4-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250609025450.3997062-1-g.singh@nxp.com>
References: <20250602104041.3322164-1-g.singh@nxp.com>
 <20250609025450.3997062-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AS8PR04MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: c247cd43-059c-4e98-b604-08dda7010ea1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xQv/bnrd6oo6rS4ymfkvzTwjXG0vbkd8n2WcHN2isxe0+8ZAhF++WJJLgMvD?=
 =?us-ascii?Q?FCaZNmh1heGT+e9MUbNPtSnI65NY+WZpIJCZRLx9U5cBYnJhxgYbNE7OVObP?=
 =?us-ascii?Q?sWNAgXbiwVgYfOzb4PAtAh4RuRDR89PPUJ/impmLGbH5BfkBRRiMjqWE9zr2?=
 =?us-ascii?Q?XOQcqF332FNlxhr+Eq6S7j0w5zcolA6fsa0HHkYU18UkXsc99WpTRTBrPjgM?=
 =?us-ascii?Q?vN3mCGhkMKMN27zNV61UfJL+3SDbxqXByseZ6tamKDoIenvV9dUAK2FIyE9l?=
 =?us-ascii?Q?cRtXL5oVzJXogIRtkJoQWaIxyX/x0p7Q/JRs3OuzMbeJhXjys0zCSu9UStj6?=
 =?us-ascii?Q?YkJLqWCHLGDQJcgjpZjAWQWyiP8XI+gaZSK+MYcX3aledwbZpAqeDD/2uvMP?=
 =?us-ascii?Q?Q+0YEf5nc3W5lR4vARExmnF+9QFZwc3i4dBcYHqj5au2eJdbkwV5aCrI7r6t?=
 =?us-ascii?Q?xWI6qYWlqpulIASCQc69NDiJkeZGd7gX43a88KdvFV90f4MRMk0+m8vUVOFq?=
 =?us-ascii?Q?3EaWF0ixybzx1sd4D8fcEJgHynDqTUu18FV1EAxMD3ZMCJB8wVazHqDU9c2V?=
 =?us-ascii?Q?ELmoeZkYb3kZ/v+kyoYwSM++1bQhmupe+7cdVSNT1JJSbGqWvGsNmRZXgKGc?=
 =?us-ascii?Q?HHoC7kZz3BA9w/d1i5Q2i0Z8n7WHWJ0qrkzI7/5lxWpwmgCLT0rElNnnTpIG?=
 =?us-ascii?Q?1V6iEWjcGftKhjB534sw8SRD8c1A4oUKsVECmQT9DgbbkKHB5304CmkhW2Hz?=
 =?us-ascii?Q?iED/Hqvx1oMjU3LFBFddniBJqiXyK4msuuzPIThrG7QA7+VteRcFTJ+hplel?=
 =?us-ascii?Q?q3/aBZeL3CL/8zO0E8yOBaCclt0g2odVM4iy5WpJfX99w9MRI6n+EYq3/X/y?=
 =?us-ascii?Q?2KcPQmGw1y/d98vOnD3TQJF3V05uR4QxGR1osqk4IJyhEhxMmgW/ZvEIpkBM?=
 =?us-ascii?Q?3xF7Xws05K1DfOz3DEJ0g5Wpbaz7xJTVQ+CEfG/2anOaF52Aod/TlK8HSoOg?=
 =?us-ascii?Q?X9qxXhJX71MnmSjQ1YG4yyy581OGI0iKXMfTAicXU/btYpTFIM4vjDavkfjR?=
 =?us-ascii?Q?EeyfcTa6kXD9azIzI45Ymqn5RwD4qQ30ArKeqW54vZRvbL8fgoT2sk9tXMG4?=
 =?us-ascii?Q?4+/bBbOVQYuUMHSPpfirh+jVU7Kg4C4Vq6oW7tEY8kdpPM++OOaCiqoJ6x0y?=
 =?us-ascii?Q?ZIsUVBS/BHj8YcanTOQXyJ7CTUixqsHvdV6M7sZ62VKHsQZ8A3KSCbGKG9Ld?=
 =?us-ascii?Q?mvHCrTM4AMzUwaTrhMVjeVujP5gUv7YBTe0KzumptTqMzVpUa2Ls/D/hOVgy?=
 =?us-ascii?Q?MlZA6Jt0rrxxz5pOPOmThpzfByA6PzuDwb7F/wj8BE7AEdPlIhV1ET7CE0b+?=
 =?us-ascii?Q?Q2aAQU6e325TMzXAjp4UYMfK5lHuU6A0QFhtWOSYOOJfbeHuyKuv6Wj1KvxL?=
 =?us-ascii?Q?1cCttV2xejBxELLVs/Xt9cVrntjGEuV/Pe2InYIaWuuwzK71VXhXKsKxEAw5?=
 =?us-ascii?Q?lQ2pRO5wH+vwz50=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZlHF+qdIFwN82b0AuvEgrV40skdhlqZwkfjolJ3jqicExE0vqy6bKAQ3x1Y8?=
 =?us-ascii?Q?ihSsE7XJHTOugl+g9cE//CuPNbyRMg+ccNT56b2hZaXizcbDf0b2D13Q5bfL?=
 =?us-ascii?Q?3k4go6u7JqvMFzH5+LrK3RLpDuRj++kETRRXKCQ4JLxijpDx2zZf89SkfGQp?=
 =?us-ascii?Q?02xj8V5ue1/RSrgxF13V+YoGqbvc26zCxurJYOwJfAvtYwVTTwUV7mIVBMQ+?=
 =?us-ascii?Q?a1u5pAh013sDO3jPPxvqLppYDdG8M4lyxxFmdM64pz152o6858ukikvbxLHa?=
 =?us-ascii?Q?oWOaw7+j9zuDB0CrANSzKYYX4zsen7fmvNxLZ/CY9EBsQFwYT4sqhNXDAfQp?=
 =?us-ascii?Q?lHrqJ8+bTF5O09oxiJRZbdW34YdbXPsTGTxmjJOE6EYuL8Ff4Hgyata2n+m5?=
 =?us-ascii?Q?qWvkZkPziCzCfZmV9L/386hBoKJGHoxPd6W40b70J2mhdCM8Qojn6oqYlKEo?=
 =?us-ascii?Q?TzYF9yPsbLrdlgQQx9gqaJft2Q/YmxlXhroCHinYZiSiIXBJXBcUikpjevEA?=
 =?us-ascii?Q?WXIJBhuJK7EeBJd04WanpGpSEQX6k7A+qlM+8nOg9TIrtMdN9DA2N62YZEQ9?=
 =?us-ascii?Q?3v2nAxybiQlUdG9T8zchml/j2DphUFtQ4NjE4O2ZmojuL6tAYohRkg5YUhkx?=
 =?us-ascii?Q?LzOdmtEE/xKr63i14gBWUvaYAnui493mNFOfifTwoDLxPPrV6TBlLURMR9/d?=
 =?us-ascii?Q?UedhFrLnH85DhMfEJcLSXM7YU14S08ZbhGoziEh6sAGW9rFlx1mlsAWadubh?=
 =?us-ascii?Q?FzBDitcMWnVXmmZIe4kGj2h3S7BONJwSqVwN1AhZ59yVT0cN28tJ6Q2JJw+U?=
 =?us-ascii?Q?gDvabJ+iwkjvlOVv/pU827jBUrXne/sYp4OY1fqs69uui0oJjleIAgfE59Ls?=
 =?us-ascii?Q?kJiKCUqG8PFNB0HA5rLOwRjYRkekK1qk2ofSsVzN9ugotkhfFH19emci5ZFi?=
 =?us-ascii?Q?9wA5h2PySdEvvoEXOKPDO+gY9KIyhlIMXPd3Zw4CI/wlgBgieMl0UjbesLFv?=
 =?us-ascii?Q?skyLUvWGY6LlDxr1Isby/3+RzN8DLkmG7OHYTpW1fWwjMYdz8ZnUNdh+j8n6?=
 =?us-ascii?Q?3334qcm+y54aNmtotm2jChZhlIKKjc/pKNDSrNufsDmsCfa4zHcWLs5fUJ6T?=
 =?us-ascii?Q?XqliJR/l2Xn3jCgIkGYPFe0ajKwYGfa+YIRuylWlXxh/E2dL3MwyuwHMQx+B?=
 =?us-ascii?Q?IuhLXMXJ4fEJJIMCutzaHLajdcd+asnk0OCRrPCwK6qk75wEZu4WFeb4MXO+?=
 =?us-ascii?Q?uUWrKYL+6iPrnLaUITcrVt+2lIXsWwcHVyd/8IZ8v1ouiOeLfdE7H+lixo91?=
 =?us-ascii?Q?B2KYhIOLTU1b5JbDCk0bFyhQ1WJvPFbm53LkgFABWMAzf7uU1CtXVD8uw97/?=
 =?us-ascii?Q?MAWcXX+YHaQZ8mv6o/xBRrSs4Lj9xGlJPrhAUI/YSjBiVJc1x1nPssVCL2H0?=
 =?us-ascii?Q?HQwJgAKmfRkU7iykuekOyiJg0iy9MJjpgonVdAwd2wCl6j0XzCz1gzXNxGMT?=
 =?us-ascii?Q?HLcYaQXxRYoawfdAR0UMwJ6ZE7CxjBy9Vgd3HMOg/7NO9tnpiWohgcdCpqzC?=
 =?us-ascii?Q?ScMQCQr+DGLGpDYJEdU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c247cd43-059c-4e98-b604-08dda7010ea1
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 02:55:14.2986 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: BEFiuCSN/xP5sM/n7ZQ9fgvsv2sDAIbAHQWeF9eEy9oO7e/IPHWUJtIoftE8VHfp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9093
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

