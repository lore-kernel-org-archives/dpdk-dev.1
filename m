Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 200FDC54F30
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 07:14:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19E984042C;
	Fri, 30 May 2025 09:14:15 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012045.outbound.protection.outlook.com [52.101.66.45])
 by mails.dpdk.org (Postfix) with ESMTP id 12283402E1
 for <dev@dpdk.org>; Fri, 30 May 2025 09:14:13 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVzg/dyDV/jvQwMl0l1PZutjTAp9VgDrHgdJCZ7UAHE2r5vU16qM/eKxPug/y5pZQAaZ5Z1PwqkgT/UKlIZZ/sXqdltNhtgKAEHZC5LaE15bRRhreSrmn8Y4JHDrJdQ66WTEOZbQx+qcGXGlrzYak4fiYVGaj3emfsOdWwDCzPlsBfIsBvJ1mwnf/nURCli6KcMR9/w6lwqcm3WrVNwcaY+2x7Ub3THlnrTxNsjy+ZF1b+gFNF6EoRgtvpKkTeYerYmLru/hq6CizPRhEPwidYpbpCHf70L0lcZ8fT1xiDGS8VrogLHS9Oj8XonARMUdH+3rFdwo+oMDE2fY+wWGSA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HdDt7RlcMilD0rxGmIK7K4ze8JuE2v3iqfkDVi9vBH4=;
 b=V5WhRGUH3oS7Pg0mQ/tGOxEeq0SUBV+WsVmlwT7PALFNEYxjdsevj16f6DzcVU8TaHAqPfsvpzSOoTZGTjnyPzVIaOarCOgH5pPu0rsmVjpnkEyHkyZLKE+euSWdg41Q5+yvY8QhnyBEveatSRyAFrXGsINjJrivne99Euk5HmlghQ0aCnZMFRaJdHEyQ7TTT9OkWXi8abcyNwCvQhMhqp1de6PVtzhJtWcetyqWDksskK4mE0TUBbVD8LVFu1UzBM5DE8F3C0B93riiHFC/eWt81fWzTaTQZTGQjNqoGzWQJ0W1E3RMNAv41hBSYj6FeQOIlqCZUQRtyO2we2EIzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HdDt7RlcMilD0rxGmIK7K4ze8JuE2v3iqfkDVi9vBH4=;
 b=hhlv7w2r2Z4z4MUG1NSYYGWyinqwDV6wTJGWzHkMoOwt/WV+v2KyWr5NtH3OMEsCqimwcM6IEhilVp3Jk6IgB9ywRpMwV5VpDay2ouqPjno5iGSGg6UoDPKi7FPWT96HBMRec0mJAbTECnrWPCcQGy0hevBvfm4JNpSjv2QVgTHKFiDCIKlHt+Nw3BvxiI8sClWJzV+w8CBUDeKqkTrzlJMePrD1pyMkLFKTNPVl3YsU4vhv3RY4gJv8DMIx4ZxpZ1pMpWhpwaMDkz0M04qEOhmvZZW7JNjfyIZ199xwdvnn/xdtCYR6Vkt/u1stPfy5cCLqKOXdz/BgLmpdX7sMyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8205.eurprd04.prod.outlook.com (2603:10a6:102:1c2::20)
 by GV1PR04MB10378.eurprd04.prod.outlook.com (2603:10a6:150:1d4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 30 May
 2025 07:14:11 +0000
Received: from PAXPR04MB8205.eurprd04.prod.outlook.com
 ([fe80::7633:884d:5973:174f]) by PAXPR04MB8205.eurprd04.prod.outlook.com
 ([fe80::7633:884d:5973:174f%4]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 07:14:11 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Vanshika Shukla <vanshika.shukla@nxp.com>
Subject: [PATCH 03/11] bus/fslmc: add DPBP APIs for setting depletion
 thresholds
Date: Fri, 30 May 2025 12:43:36 +0530
Message-Id: <20250530071344.2939434-4-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250530071344.2939434-1-g.singh@nxp.com>
References: <20250530071344.2939434-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0153.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::33) To PAXPR04MB8205.eurprd04.prod.outlook.com
 (2603:10a6:102:1c2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8205:EE_|GV1PR04MB10378:EE_
X-MS-Office365-Filtering-Correlation-Id: 3f0b7dd2-188c-46f2-45d9-08dd9f49939d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?g5XjZxEDmz7bzJqdWRyVci8E0wMmC0kGzHeroO5XMGjzutTNCfAJwLDku56E?=
 =?us-ascii?Q?+DNS3oXdrAq2QQ4yQZzRRsQXbgAXYWmHXujJ/TdL7JDIu3xJ/sE6HGoN1X1W?=
 =?us-ascii?Q?vpcr+KBqP+mutcY9YrMcMyAr7wBy8YixrDamNvzdWWaPjVEqnAaUFmy3FvwN?=
 =?us-ascii?Q?lPEbgXqG1NdvdNcAJ1KfhXVehbKIx0Dg1vtHj3S2SAbe6aHQAuQBF3yv2JpH?=
 =?us-ascii?Q?HwncU06LRkC5Jcj78Qek2lgfKpITQm8xT8jWYOEXDLqRsv36+9mfcosl8KGt?=
 =?us-ascii?Q?/ETd4mixC90UU8cZn3BC/+k3S5KRAIZ53H07RK5Tj7CZKccjY2x8dywJvG5Y?=
 =?us-ascii?Q?tyngboVnzELSDPJlyCUN7cEHl5gjd5tczfzWa37Dhz+BlQIIZb3skKWpF7/y?=
 =?us-ascii?Q?H7aga2WwE2xcx2bPyvQRYB1f34dHfRhKhleOc4pnO9QPgpTl5+Fj2BRUX5Z5?=
 =?us-ascii?Q?jilV6nmPpZ5IqcnfSkVbXHHnUJQ06U4NX63OT2em6/S7J2M6Wbnw87vCtwSg?=
 =?us-ascii?Q?72CxrTAWaoJxo4lvGC/uBv33HGuAqAKzyfPFfg9IMqYXXbEQYdueZ97vGSr1?=
 =?us-ascii?Q?4ZCyoa0xSpL7j1Yj9auO3X9BW49SDa1uroQg8mjkbW8IKWGeqk5AjkTvSqPu?=
 =?us-ascii?Q?+BQ2gz5OafrnkkDvNFQr9uTs/riu7BH0QNLHExdI99ES27bkEaOHnZ/YKiAz?=
 =?us-ascii?Q?UG4ZIKH09K/x6vlAKsy5e4zvsjKks6Sr+FEK10FYXt29trHKww2/AWykjFHP?=
 =?us-ascii?Q?xtgHvWwsyXdI8/u7EkcYJ7IsvMIfK0sYswfg3SaoRNeIUw3ICXg3nrNyPQW9?=
 =?us-ascii?Q?3hSugSPvwGxr5yAJrJt2JAkiUVSv3EVzlqIOzxyn83Dhq2F22tbhc0iIKKyn?=
 =?us-ascii?Q?eYkbonjmZM/QOd1OWnsFCZyE/2nh1/8cjhNBfYb2mx7I+kq3wff6N+7zLKj1?=
 =?us-ascii?Q?sNxGTSg8GP9UbicFB5J1w31rj9GuEjLxuIP7AOfoZ1FTGyHCOZ11XRENrD47?=
 =?us-ascii?Q?WgDAttUIpjm1Ft3QLffpjP+66ppiC1yN4QKFy3QlsP6RB64FcWLi3dvTbUV3?=
 =?us-ascii?Q?6wAxWZCartF1jN1R75ikUp0jfysM5WmwcAVtbL8lEKp+PaQBuFZgYLT/ExMo?=
 =?us-ascii?Q?Gt2yX+T6+XZ4pku8o0bQ4uEEmuRbTLxaj9N5tiYqDir4ctsEyDKiycHw31Wn?=
 =?us-ascii?Q?eCg1ePGb6NGTO7tL4UQbtutZH2h3Q+tP6v0ZPFvfxcIfGA4h+6ood5fq++hs?=
 =?us-ascii?Q?vg6piEpl27cL5Ufwgs+W/q/Vu8SFnox8F1e2WudQacKUGQJBsGeHsKzljB0F?=
 =?us-ascii?Q?+IvrD3dPfCmgtlkgTmzHLJiPfVkDUGl+itwktAybytQML/XMaaMxopr39PXC?=
 =?us-ascii?Q?zrlX4xguMBNRyv8xskzXCBTLdOEhXwu2b8IMESUDtNa8XunF96EdE6nIrSLA?=
 =?us-ascii?Q?rppYmd7Js4TK84THNvo2u4KBbdS5AlFc3MtdyUBIY4c1371zJJJxjM+e3a/U?=
 =?us-ascii?Q?M3PkyzPGuc4UjIA=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8205.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NEwI1B87BTd0UYFY7CukhDRiEjD3B6jNCbx26RG4I5XiLexnEumxMxOOTqfd?=
 =?us-ascii?Q?fyHk7oO1LYtrnieZVk006ucZvlOHuK0JoM/AVwP7m6fi0lNvVS0KvmG9y0AA?=
 =?us-ascii?Q?SN0nGG4r/FIl9zPwLMQqqtTqoe56SCEMpLU6Vs6+rek02u+F0SG4UnlLb98r?=
 =?us-ascii?Q?scTcH7+didkNF0qvSv457o1Fu6KT69fEeIYtsVxwJbOXeghv0/iJCv4p5AYX?=
 =?us-ascii?Q?nrZUltJYJUsZ1fp0ow97M1pzOF5oC6EVe73mCKCpwD2N5q9iwzp6XkR8kE9F?=
 =?us-ascii?Q?KzlN/23l+7hqv63gjdxm8ctg4ziBE1Amec0NtMfkkVOcDK9LhlsyiDApFtM+?=
 =?us-ascii?Q?jxTo+XuOcs9Ys/0qq3INAdBdgwCErOsyU3+/1U/2BWnCuEqWfp4BTFwJH5sI?=
 =?us-ascii?Q?06mjXKEuIKfWPwmuW5qxWJgWYmoS89zlkX2Y2dBRDYzMToBxam8/Y3aAVzQc?=
 =?us-ascii?Q?M7WXAk4nd3QllDMwrUYp7wkDQPreUmtUCoZwWGeJX/Tf7bH9s6S0A8ik/VA6?=
 =?us-ascii?Q?vAH38vXd/GOd588x7OaW1VkhA6aVHDYMA7x/znNGVZqRATX/tYNFRHjBPdEP?=
 =?us-ascii?Q?5Et9mhZqPujAta/zDMBVuVtTG2TLU7lnrTAp5HPqyDEd/Wmlc6uBYbGsrOPF?=
 =?us-ascii?Q?w+uijxo+slhbLhiXC63T0BjB/RVUL3PbJ7egx2TaysRHQqs3nIrAtUlRk688?=
 =?us-ascii?Q?MurYd22C17udfDq+EjoERW6e7WMPNBgCzPEwXqDBAhIuaQzeho3OVkMZl602?=
 =?us-ascii?Q?VAz4U+UMWq2A0j3xlRtV/rtdVrq6vGTHYlDE/b8okigVHuTpgrKH7dnQre+H?=
 =?us-ascii?Q?3u6INToFqPiIV7HwZJj63TUfH97rmeydcO+HYNw3+guD1Kd/oK2hE2Q7MN1Q?=
 =?us-ascii?Q?MMucC9lyPJ3BTP3sifmG3ayj+vrCx4KeIx2b5H42Od5wDRtTPq0UuFhFcHB/?=
 =?us-ascii?Q?3Vchv/XpKmskcezQlnudttUWc/2xF0QXGcalwApMeAkoezp/jvO4ybIzM/vj?=
 =?us-ascii?Q?ioZwDBnWs1X/vhDyeENMB7W/b3pj9fKEUkuXUTJWAhPSfMH7QRnFHS6Qe2YV?=
 =?us-ascii?Q?qCMY13BNACS8WglSx+j2ZovJylgzovP9n9QWF6tR1UhNVLCZiW71Dxpxmpgr?=
 =?us-ascii?Q?qollKXYITUwrajQT5bdHttrRnrMwjEKDrp6db23Oi6RQE6Hkj8QgXQ7+PwoV?=
 =?us-ascii?Q?aSaUXd9WJqN4P+dGyVu80gcA3BmYhsGkPWbPgdpktsuldghOzKnoSdb/MTh4?=
 =?us-ascii?Q?X204KR2kSEnshClOH+799Pt17I8i7fBDdQMdfUE3Q06gT+UJqfXLFCgy86rS?=
 =?us-ascii?Q?3NceB7e2xaexs+yYzksIlW5Wa32uyjPnK+iImtNlgMrrXRByoGypJsiKtcQf?=
 =?us-ascii?Q?5qbgJqPQ9eS2vg+zuWDQFeka9S8C8T6yv1THodye2JCHOetVRvmqycU0XRdx?=
 =?us-ascii?Q?iYU11Uw8/GDN8ZbC9PfrhUMPeWVj6ISVtRVhrMX7GrhK4TrW/sKOEhwmAxoI?=
 =?us-ascii?Q?Sw9OkxQ4hgAwmHg5Pan2tWuDLZGm7z/hvNjs8BsPVVEYZfwA8gxIJSrLBkfb?=
 =?us-ascii?Q?a4cnglYUIuv1xwIg6l8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f0b7dd2-188c-46f2-45d9-08dd9f49939d
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8205.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 07:14:11.7984 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YOCGVuR2fTQj4nHtWyZY5IfekTw0Wi0VZkyJlIZlgeHz/rIayA10QMfT8t6DjSOF
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10378
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

