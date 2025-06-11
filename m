Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6839FC677C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 10:52:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60E3440696;
	Wed, 11 Jun 2025 12:52:18 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011035.outbound.protection.outlook.com [52.101.70.35])
 by mails.dpdk.org (Postfix) with ESMTP id A53DC40678
 for <dev@dpdk.org>; Wed, 11 Jun 2025 12:52:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hOLJBoj3EW3iarW3EwTZ6EX9LGcq4Rv/CsjuzfcINXfR3gxSR3fwla54NdnD75GzWTDqKQtI1cCXyvVh3ymeHtfMueyzYTcKNY33p0WYjHdJ2oZny401aM/PKazzurSb6WAT3ePrueEqiinKN3bmidI2An4I4cuD1tu9eLPVkyxRwPGNU21h0uXuY2r6r68lS4sqIxz8sDlyzHHgtJb/2nXfEwVlMkoWxl6mdnzIfC4p+YNvpLxqIptVcjYn3zxyZcrgfljlPxufvmBkaq1DAMroWT94koqS9aVYqFAG5kU7c5OG99xYBtQ/iA6kI0Engt2YgEN5s1XjSwxuApt2ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLvaXgm/do1Sk2sR4ac6B7vjk7yE27XA0ZxR0vWCasQ=;
 b=HQ1WxCOyLXhUo9TBXFrbn1vxHVltRcHAbFwUJDf2Q2JcjtnkqBwdAx/Gy0nOumgTL8tp6rtHxjZ16yIYAqbLQXWW5EelQCK+Ujp5qy5KjgjyR2y98ljvbhVo7N0P4MwI+PdF2j6Y55ehudGHMkTekJcxiufRHdBlgsZ2A2MoVq2CKtifBFc7RRIEJOQ5JlmmDp20IM/J3T21B7RLPbLFwKSfNu+i25IbQdVkTpyesD4pFL/Pd2fdIm/onKmqfTacbkwpKugy3cFx33mHo2TnmSFTOFcO9SvpOt5qcEJawu2aUlbGsTmhW97z2D8TmhZhvyPYo3kCcaPya+iErjP/2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLvaXgm/do1Sk2sR4ac6B7vjk7yE27XA0ZxR0vWCasQ=;
 b=C1BvafT0Hu0MZAH9YClDduMouvdWzDtA7+LSE617kwvN5p3eZ5Oh/aaEOPGfNyVo8q7o63dtMFrCYl72Aj63V5aOJHexhdedXBDd69wVZVYmD2vCqkrwNM7RBBWwJJbhWJ6OAy16bb7uuAfls2V5gEBTpsNiRaeyz/kN8lJ50Cq6s2z0+rxrnJRkxIAPHJCSe59AFlzDp4Y7aaB1siX3MTYnjNwOhrZJnIT63Mu37nKOta0SsA68n8lH7u0QQVeodnqLinUIe80yGs9PQ1UCUeWJ5Mq1tcyXb5U0B8+LBLChnBISen2FDZD7vMZOeG4xauOZnPSIA1vlg9CxcJstng==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM8PR04MB7348.eurprd04.prod.outlook.com (2603:10a6:20b:1db::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Wed, 11 Jun
 2025 10:52:14 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 10:52:14 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH v4 03/11] bus/fslmc: add DPBP APIs for setting depletion
 thresholds
Date: Wed, 11 Jun 2025 16:21:41 +0530
Message-Id: <20250611105149.655144-4-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611105149.655144-1-g.singh@nxp.com>
References: <20250609025450.3997062-1-g.singh@nxp.com>
 <20250611105149.655144-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AM8PR04MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 8115d106-8d57-409f-2aa8-08dda8d60641
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LQ/5+dQ28xcr23XQ3mPyIWrrk6pyC6RJqCElXtDdSAgsBtqLDlb5AVcgyD34?=
 =?us-ascii?Q?g8BtVJ166Rt7cm3BGzryUOCKKdEGrK8+zT4Lxs+4WJ8f8NiufthdAMz/04qy?=
 =?us-ascii?Q?5QJnI962AW4/tKAMDw8c8Eku8VVpJ9BMsxpxq/1/wy/NiFARurNhdniM4ty7?=
 =?us-ascii?Q?Fyz5Yg/zWwAr5qhtI3c7oq4PWs7Qx06McHHiz+BPxQZ3B01jSFo+6xZ+nmio?=
 =?us-ascii?Q?pMowEJEIBEifdxqahYdR/vw2kjCLAOZLjqFiwLv/8128dwMx6MsQMgJ9nrS5?=
 =?us-ascii?Q?pAD95z1AdKtrMw3GRspflKXi4R9/tmxzyF76d7YpW8y6Y5xGH5u9doKFDr7y?=
 =?us-ascii?Q?+R2EMABdTF4AMNYvJerKKgrtexGm3HnJonlst57xCV6QE+1g9IKFjmU0GgrE?=
 =?us-ascii?Q?KzuILB6lI9W3HCodCc7YIwP9aWir4lV3KSI6XaQAcGxe2qw1N2ZvT9/JH4zY?=
 =?us-ascii?Q?80rNRFPVLzqvrPG7vwP6SuNwxWJ2UWYhWQ6A8hYd9amdzfUKUTxiOVQxWcQe?=
 =?us-ascii?Q?e+UjEMBBFLcOmXU8/HV/WpiU1x6UyxSa/OuK27pRkBezjFwXyrGlljyL9K5o?=
 =?us-ascii?Q?nxupZB66J6j+3tN2KWERQaiZ8226WcvwLjm5gEnjI3oZzIc4NhGJXf/3M4nT?=
 =?us-ascii?Q?35qtQL8QJ8OzAhizZQ8lHmLIMOA9hKC6sD1hhEeM9lPikcxhf2qtQGsvBdMy?=
 =?us-ascii?Q?pQd/AMVXVPXXbekoGTUnxhIYvJmtgW+IpERIqMwKJFv2qq9zF1UeQ30h1el0?=
 =?us-ascii?Q?fpYhy69FkKUAb+ylRawzV8QwczL8/kiKYeBZjzY4GQVerj8YV+NROZ/H7Zaf?=
 =?us-ascii?Q?H5aWNP5TfvlLIMW3+Q5NMw2woMvoq9QF1bFh9WH2QPLIjf+Spm6Wl/bXaBct?=
 =?us-ascii?Q?1ULR1A8gwmkJSFybdR7+V7IZUhYP6AGDi++W0/Lp8F9wuqrZQEcJHHSASOkG?=
 =?us-ascii?Q?6HOvVHVZDbgfGnireehWLCoPRzANgYYdbnl0/PCzP/YSfAVOxPp0GVvBWxEa?=
 =?us-ascii?Q?C2YXqX5+HuC0HyDdMCMJSokZXbnbRXoJ+tzdhIVbYRYQnHi0RMeB8LIYMiYc?=
 =?us-ascii?Q?0oKgh/3OcPtSfwzFGvmutXIQEOO8x8Cr5rDKMs9+XyrC/o3TnXsPF5SPLdsZ?=
 =?us-ascii?Q?dN0ln/jKMdW2VhcSae+cMaYusvtwnIqC4+7StpGQ8Vn9jHqEGF8QknqjkCWT?=
 =?us-ascii?Q?smkfR5hBsKOyibSmtqR4Mt8xbdW2JRd5Gxpp2FtyuXuoPFhJ7HA2tl/yNqK/?=
 =?us-ascii?Q?eqs3UCQ283aWknR4MDDWzQ/28SaKCI3pCnlt5aliNUbhIrou2xVQyH7NQgPr?=
 =?us-ascii?Q?mPjLMIyLKPgMNu9JNJd/X6xsns3TwTU73i5DhKQuwB6WGoVz7M4hlcCBO+y/?=
 =?us-ascii?Q?Vnu5Ya0lqu15vT8xsunWoYlOK5R4IaUAoOUI7VIj30mKl2oqTqAw1OvlQl/Q?=
 =?us-ascii?Q?SQAOqYBkYb1W/p6ZfddNe3K6FD6C9H82kstMfAUNzm+3JP5/ipjUhBhDNCdZ?=
 =?us-ascii?Q?xqtaYW6VePKlmyQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6n1IYR+C/0ZZCSw4ElIvx2Ap9KEwYSoqVBrAjvdxqEqCTTUo+QLLQLXjO5OR?=
 =?us-ascii?Q?zP/IDtTcNCFMWogI4smPcu+3+9abaFJ0Hz8nekJJIRBLy6IhEEybNNQo4n4j?=
 =?us-ascii?Q?c8Klzl8+Kc+ONqq2l3aUUKAg/I905QqNP8tLj7Bv2ls5ToMTHU4DLZwURcLp?=
 =?us-ascii?Q?7XYzzdqDAceW+4s77MSElUNz/f8Oh+GNMFG4kV8ecjzNArcYqf6WHGBYmvo4?=
 =?us-ascii?Q?lf+I2cJE9dkUgVygeTjx3WNt33IKCHr6lG/drNHKMa0qhkDkVmkjsPUihIPO?=
 =?us-ascii?Q?tpaWoI2olNkhA8SopY9LaKoQPPLo4/iYGNiJDlRG32lUHrVphU+BAI5wdn/R?=
 =?us-ascii?Q?3vtevUET/ca8gtUeNsKsMtJ0Bw7J07zaBzkySl6nMw747ffQuVJNoiPW4tIu?=
 =?us-ascii?Q?/Ei4aoEn5uT0suO3fC/GvjxncUKS6yh1eMV07YtEA8vgJufGS7lWB44muc/W?=
 =?us-ascii?Q?xrry1KRSZsLj0WTeDgBtBJR5LGv7WC0epP/1pwRXkVDOB6frb4Od6rLujclA?=
 =?us-ascii?Q?SbsrWHy4Sje45RXp/oFKv7azQO0atBV4UXjNUSNp28IzaXSE8C1xu80LmhqA?=
 =?us-ascii?Q?AzGqCjs+rSgCgnbN9t2dOhW3koeFSHVag5Ww63JoOMgRQCJ8Ed+XPssjqLxs?=
 =?us-ascii?Q?udNoxg8VpVq9Rng6BXM2wEh4ufObeDuT9O0MPMacSCdytgVxyrDQEb4nH1V6?=
 =?us-ascii?Q?v08hlfPQ0049Rk3KA4ZhwQcZHDwSpKLfJdHmyJLfvgLNt6iwnnq7pNqLl7QL?=
 =?us-ascii?Q?ZbyXKtY46YEIO/wTZ7sLc8gLvbk6i7ymCxoAvLce1uE7ffb6I7i+/n8gUM/X?=
 =?us-ascii?Q?pxslpREtxX7zmDNSuL7XZ36Hcguwi8nPJPtZGzEkUErFzUuffycHth4ULcLI?=
 =?us-ascii?Q?LMBlSlSwXZXacmd89RxPYNxNBBLWaXeHRc5zwuDINclErz//B87q/AZjnGUq?=
 =?us-ascii?Q?GRqvNog0vn8gi3XnllAJITeZgEtqQ2LWUzQSu5GymDffBqKGZGCTKaKk/qnr?=
 =?us-ascii?Q?IPdHjjMtWK81NC6YlJiP1k9Ofzny572Cie1gsEoCu89mxgkBedE2ZgbndhZR?=
 =?us-ascii?Q?XOMl40XDTSu3dFEF1dsAZQeKrvZ05iKWzw713cRZMz8QabAkumpnsFhNxN6h?=
 =?us-ascii?Q?7L58L3DrR9ZusoE0DX0AjSRFxYw3udp46u3eXQULsgCJNsFUgp4sC6czijNV?=
 =?us-ascii?Q?huPmlXiePHRve5vuAi62Uc8XwwoG5BCyjOT1MUm/43WJ/I9+mr0SU1rIb2Gn?=
 =?us-ascii?Q?3LD3Vi2TYl3wE2x/BnOMjOu1CJZsXmu80dFvmuseT2lCIl3U71JKkVzsAZuS?=
 =?us-ascii?Q?GAqrVfU0UJJXg77L4MfEjPavsouY7SAX4clMsap/QqxA6GCUTOh+0qovjr11?=
 =?us-ascii?Q?Y/76uGlnA/FrRAcueL+Fh4LUgohEealbdJ/aDiPJuHijOp1PP3ROwo+0bvdA?=
 =?us-ascii?Q?HC4pbwMsf0D/6yEHjykDOYqGH048V1wPDjfJLWMnvwMkQqQidOiIHrGJpZsB?=
 =?us-ascii?Q?lNdg1HDurqWjYNOq8pO0HYZovqWYFaQmxnBfL1BAUlisOqn7HAQQF0MB0unZ?=
 =?us-ascii?Q?skjwfyMxl9j7cSVqpU4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8115d106-8d57-409f-2aa8-08dda8d60641
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 10:52:14.2272 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kHSV4ZkLvapf/a7WmMNJqhC8y8OJwSmW2yCaKxDbNv0wYPLoH/ZpXXQZR91SwR90
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7348
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

