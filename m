Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A7AAC5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 10:42:16 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C16154042F;
	Mon,  2 Jun 2025 12:41:24 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011035.outbound.protection.outlook.com
 [40.107.130.35]) by mails.dpdk.org (Postfix) with ESMTP id 5901140696
 for <dev@dpdk.org>; Mon,  2 Jun 2025 12:41:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=u3k30c5AzOQxaMSlEaVp+Xt0WyhugzzqqmSnMoypYV7YW3Ny/HUpCTBrBPgYDnGt+EXACkSigQHQXe6TZKAZwg4BGaBHfzaCuu692lcnVBB9c5URB7Q5aZAiGpKW3qHGP0U7fMdiBUX5PntLJ3AKhNoTIi1OgyGKB7lftvBNH02nFsSvlazDVwkoFaRKYYBqpNsqzMDBLqTu5DNR0cqv+Lg/I684E0Fm/CQD/iqSHXYBe1oGs38noaDEqds5/PLVdYFIpJ9dICoyQLYfqsJ6XdkeWFTlaH6fNbciCLFCkiQ+tr4f3/3Yds/PURXerIavPil42hES1WPMAtXx0WFYbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TbK4PYwJVm61RBYZe/t1y/M3IG+J1BilF93zasNSNTQ=;
 b=UgJxQem/YwyGMt8qIiol0ykWHRkYYZwnLHTgjTy+6EcXvjcCbbZKN2vPgMik/Oa+N64WYlYRUB/YLOjUMXQxHJkdq8bc2S07Xj2uch1oNCqi8WNt9VC+HmvUVGTGm+xsgdsru44cZ2Mv6onEGDJ0OMbOTYWTW67T//4KaLDXQaOmCUmjIg8rN9K6PH92fFGSNm21iuVTQAfo7qxbjjs8UTKie+gJ4pN5+oj4BJJLJ2f2X5pWI2viYm1tv3HiLEeHm0mpU6239yfE+g995QQsAz2hBFEDW0A6cuF89mGoIEAVl3XmYtJ5wB+21ruKUNBhKIBDlvHGZ2hPaXxFAIOSYA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TbK4PYwJVm61RBYZe/t1y/M3IG+J1BilF93zasNSNTQ=;
 b=MqonLtwPiF4vxwNCGw2LorKpMDsPYX207IAqNF23j/kThO4HQaqywiv6YoJrqDj7DFL747Pe+jRdbKLL0eWbKnIbvLXC7coyIaDRErunkmpvWo1L2511Lcmxy/eckVumuBYCmifEkXUc77MoFtqldhemKyEm92CzrD5weZ05vfTsoQKf3LsIXAGZI/b7Z5qVOfrcR0D/eT+noDpDcIlVQqgf6cjf2DzoyqR8CsXOTBGYzSG9gBWPU5h+C1caq3WaT199g6V+A8CMiVsruKSTZkFtSldzx+y2jbKjDKvbZgYaYtoMHRVhC3fm1kg8EmneDk5CwYasSXEAP20iuBLpHQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8194.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::7)
 by VI2PR04MB10956.eurprd04.prod.outlook.com (2603:10a6:800:276::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 2 Jun
 2025 10:41:22 +0000
Received: from AM9PR04MB8194.eurprd04.prod.outlook.com
 ([fe80::cd61:3920:b12f:6561]) by AM9PR04MB8194.eurprd04.prod.outlook.com
 ([fe80::cd61:3920:b12f:6561%4]) with mapi id 15.20.8769.029; Mon, 2 Jun 2025
 10:41:22 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v2 10/11] net/dpaa2: setup the speed cap based on the actual
 MAC
Date: Mon,  2 Jun 2025 16:10:40 +0530
Message-Id: <20250602104041.3322164-11-g.singh@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 3feeb061-7cd9-4869-e590-08dda1c203e7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4PkMz6mL6tmHVOVlfbkfoTALeHuV2Z2j9IterV6q3cSEahSlLh6Iifms7RNn?=
 =?us-ascii?Q?QgvVcXkxXsPTgW1t9M2xAVhN3rBEbf4ySB+shtcMkuZIGnUZyjcWDFEO5rDC?=
 =?us-ascii?Q?jfKmR/VByOpylmXd9pkOCBG0QzgFBRAbnCoXLXo4E6rlUu2zS49aM16DwUra?=
 =?us-ascii?Q?L07GveMeLTEnSYHO12Xk5kPHlxMHnQxRRHWabIj4p11bX6cEfw2pUHde5zzy?=
 =?us-ascii?Q?CjCc8sXfiYM5ein/Lv/ofqYpE5xnSdy6n+NNVsPdEnOHMhLGY4NmUKDBCxox?=
 =?us-ascii?Q?ZU53/oP+TbqLrXrKzN2Zj+Ao/L2jC/UMj8x3REJHGqsf+xt6tc048gnSXW2V?=
 =?us-ascii?Q?kBWfMkEIlkXgsSZLU2UPfQzi6xs4oGfOoUbssVXPSO6PMnxDGCXUG5c0jQdG?=
 =?us-ascii?Q?kTGTAtKMnKlVevRp85qGZ9Xftk3VtBhkCrwQFGz6UeqbahohF7sRNkuNVjV2?=
 =?us-ascii?Q?jSImZ1PO7T2xsYlFdRILe8aStCnYFSaagoG0JQo9w9T6us5b9SjuVkfaGxtN?=
 =?us-ascii?Q?8etYEsWIR1HeUwDXYPDOYdCdwkd372qeuJo5QOTZWtrA+7W4pWopM7gqvr4o?=
 =?us-ascii?Q?qoU14RzNlB2dwdTqDWSmhBz6PdbIw+GVbI40S64OLVwxN4rH2wlCsCP7oWYP?=
 =?us-ascii?Q?wtMIgsuRiwYTV8FJiwzetZaIr+IPov7t5V3ZJGmyc9uyLIo+VpqlEXH1POOH?=
 =?us-ascii?Q?pczQlx4nHPwSJT7JayT4tuQdH2Talrugk++us75JNGsoaprMTuI6yQO5r9Qc?=
 =?us-ascii?Q?D64ucL/hnnlcfh9IDWdbzIs2tBUAMCVs7SI44LO9vvsS1opsygFYo3Z2x/QM?=
 =?us-ascii?Q?W0ZRnjwrWfe+EGYNZPOWYvgWjzlmz2tcuROIA2cnL4b2v/cib3zqv1i6Xfrf?=
 =?us-ascii?Q?tC6TEe+KKRtzfjkW8SjpxjgtFPAUU+2fFdJWt1fP8ie5KnjBqK77NYORoSPb?=
 =?us-ascii?Q?Qc3K72wjNE6ud7LNqRacK6ljaOpA4AD9GxW2kIZhwQ3WTdvaedUfHaYDcC3C?=
 =?us-ascii?Q?2cOlSc0dD0WngmHYor3em/q2IcytFBAZSZsWJMz+t17I3EFBisz1o4fuUeiY?=
 =?us-ascii?Q?tWCxXaZz4ALPHPwZ3rBJXhTq460FWEC/a+TrA/W/b2c+PMcDk2PoCcLrIBf5?=
 =?us-ascii?Q?4RZmttahfA7//dCRaJQvTXXkGPksXKTapGLRPK5O5lduV8+fTcIzCgnn3GSw?=
 =?us-ascii?Q?1MUYnv48pm39JdLEwJJEx80cCBVdfDzY6aMQtrc35SAO1x6tXEDopyR5kQ0n?=
 =?us-ascii?Q?xYinyX1dUSOx/hUawPjgFoe5LAXUtXiN1SEByndQNVUNnlutpVBS9YVh8HFa?=
 =?us-ascii?Q?I6ZrJ3fIrjay+LEAy3zEWlsnV6VeSeYYT5Z+dOl/btnvPZZnTHpJleKw6if5?=
 =?us-ascii?Q?CQQ6/05mR5JGVcbnyHM5SN9XSCsr39z4gybvjaxUmab6g361+RuNiT1sbaD9?=
 =?us-ascii?Q?IAcNcQ2/vsawwn05wMTeWu/HL/VhEAHoSXskzeJsrfF5yTbxrvgauWV0TCL6?=
 =?us-ascii?Q?794wXxqa83bqyL0=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8194.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Gd+Y/5wjPdEvd9QdB2oTNraYoxPTa+blgnPNuoFryiaSh0DuBhHG/1gTRV9d?=
 =?us-ascii?Q?F0OEbvzXbdZXmteD/iBPIY1+8R/R3170hOnfGrXvV/o09Wed6bZslpaufY7J?=
 =?us-ascii?Q?YVy2v1wi+sGXbU5R7hGncELo6Ka3jf4aCYxOclfPxWBfOY7ZRYoFS5Yoj/XQ?=
 =?us-ascii?Q?NcwHzU2fowBDvJXDsHq23vq8ItITul1QXtOhCMHireloZjGGwBIkfzUX7EZT?=
 =?us-ascii?Q?AXtmFNeohszgZcBVb6BjgGbtxPG8+uz2ZwUFnlThPfeGKS3Z8I5eAmlDPkYc?=
 =?us-ascii?Q?jVGauHVeHNX/GfXmkmlxoCEkbP0KCxB20RJh3dYsj7vstn3KUIYPBT2n5B+b?=
 =?us-ascii?Q?3kuJptKE86hujTC4R0ICGj/5lNkjKqUrJERIUK8TV7Z5fnYQOoIoSTAUg/2N?=
 =?us-ascii?Q?MjzTO4Du2zMum0ktq2zMNqGlSE+ir1YIVjnwkyLM9zdRuY3pH6TS6m84vcGi?=
 =?us-ascii?Q?GVw2ebzsROT7g7AAti01vwt/vjUNXobChZFkx0IRT6gXp3ccDx5rS8UaSESm?=
 =?us-ascii?Q?zezDqC+ZvT//5AWA1K2A6xFTPuYzmpQvIxYITd4HCd5hVdqgyNv5P91idN8G?=
 =?us-ascii?Q?OSYAutyrXAvSwqPvoAxpRT19xA3CcLTuKGe2ap8nZ49kdmBO26E23rYg8kP5?=
 =?us-ascii?Q?vzzgvG4mXLxgOZSGsDhsTuKkqxkAkE0UYMr3876nZmdzw1MZJk6oJGq7/qmU?=
 =?us-ascii?Q?ZdQg5XeiW+U2jAHJKYEnbIhppiFA7Pgr8OoSZBa4Kusjho8wJLpOzgeA1zuz?=
 =?us-ascii?Q?rDFEuUPUTlwZnHKB4cOd/MSYDvzI8XrQvZMY8WWKWEAPUgMaaJbjQkszABlF?=
 =?us-ascii?Q?gLR9jQMMxLW3hBKS1nz6bkp4LGHoqJhNIcUAsORtvrWmA2wC+A12iok+OaR7?=
 =?us-ascii?Q?B/ZbvuQpPo2snwNwPbPtWFZCOJcCtrpRGj95aQC3rc0qSyFKwGHPRk/l2+8R?=
 =?us-ascii?Q?VI25cZIpkb3wuCTJ1FXHyvRwfhfTtZIpvX5AYZmybChldOkjnjv2KjtrWFBP?=
 =?us-ascii?Q?3Nz9Nc0CMn9TT2vzbQ8aJfbn+5wTDWgJekQIQmxzbZSJxg1AL7WpaEhbT3Ia?=
 =?us-ascii?Q?s9OKsKtTj71Qus9OHq/3apLTnjb3p6Fy+tr4YGOu37p1WlAxZTWQBhBwlSVV?=
 =?us-ascii?Q?8e6kl/o/NTSw2poks13sZLpa/T0fgkHD7xn9L7lTuFUwb59pF7SbdjR/yJ8l?=
 =?us-ascii?Q?GcclY524enncI6BExnRumDo9QAdMQ67HR7QdOfDTq31P+xkoLYr09K/WO5uu?=
 =?us-ascii?Q?5pCgKf4b+2UZ6lCJAICCgJstNJwC82UsNHoJgGqVYf6PW8Zz6FVGXQhpw532?=
 =?us-ascii?Q?046khtzYwWKTK+rGnIheBZIkuwpe9iNiyUqDMBYJ2ofg1IPcspGEB+Tq2IFd?=
 =?us-ascii?Q?78qQ8FgJbYDTwv3njkLI3XA0wEyIyBXiV72uKHjYu4xwH8BRLSKustl7nu9q?=
 =?us-ascii?Q?EwlWvFsjsx6xenDKcVX9hljnpz5LC2OJi7Zc9tyHwRDJpQ2BIEKbpnrfD8lo?=
 =?us-ascii?Q?TfFCHMzg5OjNBQkIL5ZgOTpHJqJ/tS20wYaXmIW891OQgXn+h0xW0eHoZJVe?=
 =?us-ascii?Q?09VFUqgBic5a4skWHIxYKjl8y5biQiFb0xPhgF+H?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3feeb061-7cd9-4869-e590-08dda1c203e7
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8194.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 10:41:22.0799 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W3lo6C1juF85jDpOVOX7fX+glaCEI5F8bplnvf+iPW5NZQkdifUQpz2VwWkCnxaD
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

From: Ioana Ciornei <ioana.ciornei@nxp.com>

Previously, the speed_capa field from struct rte_eth_dev_info was
populated with all possible speeds that the MACs on the system could
sustain. What this meant is that the bitmap of speed capability did not
reflect what the MAC could do in the current circumstance.

Fix this by using the newly added MC command
dpni_get_mac_speed_capability() which returns a bitmap of
enum dpmac_link_speed. Since the MC API is a newly added one, we check
for the DPNI version to determine is we can use the API, if not the code
will fallback to the procedure used up until now.

Also, we interogate the MC firmware only at probe time to get the needed
into and then we store the information in the private structure to
use it any time .dev_infos_get() is called.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c    | 87 ++++++++++++++++++++++++++---
 drivers/net/dpaa2/dpaa2_ethdev.h    | 12 ++++
 drivers/net/dpaa2/mc/dpni.c         | 21 +++++++
 drivers/net/dpaa2/mc/fsl_dpmac.h    | 15 +++++
 drivers/net/dpaa2/mc/fsl_dpni.h     |  5 +-
 drivers/net/dpaa2/mc/fsl_dpni_cmd.h |  4 ++
 6 files changed, 134 insertions(+), 10 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index b88c9d748a..c661e027f5 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -290,6 +290,79 @@ dpaa2_fw_version_get(struct rte_eth_dev *dev,
 		return 0;
 }
 
+static uint32_t dpaa2_speed_to_rte_link_speed(enum dpmac_link_speed dpmac_speed)
+{
+	switch (dpmac_speed) {
+	case DPMAC_LINK_SPEED_10M:
+		return RTE_ETH_LINK_SPEED_10M;
+	case DPMAC_LINK_SPEED_100M:
+		return RTE_ETH_LINK_SPEED_100M;
+	case DPMAC_LINK_SPEED_1G:
+		return RTE_ETH_LINK_SPEED_1G;
+	case DPMAC_LINK_SPEED_2_5G:
+		return RTE_ETH_LINK_SPEED_2_5G;
+	case DPMAC_LINK_SPEED_5G:
+		return RTE_ETH_LINK_SPEED_5G;
+	case DPMAC_LINK_SPEED_10G:
+		return RTE_ETH_LINK_SPEED_10G;
+	case DPMAC_LINK_SPEED_25G:
+		return RTE_ETH_LINK_SPEED_25G;
+	case DPMAC_LINK_SPEED_40G:
+		return RTE_ETH_LINK_SPEED_40G;
+	case DPMAC_LINK_SPEED_50G:
+		return RTE_ETH_LINK_SPEED_50G;
+	case DPMAC_LINK_SPEED_100G:
+		return RTE_ETH_LINK_SPEED_100G;
+	default:
+		return 0;
+	}
+}
+
+static uint32_t dpaa2_dev_get_speed_capability(struct rte_eth_dev *dev)
+{
+	struct fsl_mc_io *dpni = (struct fsl_mc_io *)dev->process_private;
+	struct dpaa2_dev_priv *priv = dev->data->dev_private;
+	enum dpmac_link_speed speed;
+	uint32_t dpmac_speed_cap;
+	uint32_t speed_capa = 0;
+	int ret;
+
+	/* The dpni_get_mac_supported_eth_if() API is only available starting
+	 * with DPNI ver 8.6.
+	 */
+	if (dpaa2_dev_cmp_dpni_ver(priv, DPNI_GET_MAC_SUPPORTED_IFS_VER_MAJOR,
+				   DPNI_GET_MAC_SUPPORTED_IFS_VER_MINOR) < 0)
+		goto fallback;
+
+	if (priv->ep_dev_type != DPAA2_MAC)
+		goto fallback;
+
+	ret = dpni_get_mac_speed_capability(dpni, CMD_PRI_LOW, priv->token,
+					    &dpmac_speed_cap);
+	if (ret < 0) {
+		DPAA2_PMD_WARN("dpni_get_mac_speed_capability() failed with %d", ret);
+		goto fallback;
+	}
+	for (speed = DPMAC_LINK_SPEED_10M; speed < DPMAC_LINK_SPEED_MAX; speed++) {
+		if ((dpmac_speed_cap & (1 << speed)) == 0)
+			continue;
+
+		speed_capa |= dpaa2_speed_to_rte_link_speed(speed);
+	}
+
+	return speed_capa;
+
+fallback:
+	speed_capa = RTE_ETH_LINK_SPEED_1G | RTE_ETH_LINK_SPEED_2_5G |
+		RTE_ETH_LINK_SPEED_10G;
+
+	if (dpaa2_svr_family == SVR_LX2160A)
+		speed_capa |= RTE_ETH_LINK_SPEED_25G | RTE_ETH_LINK_SPEED_40G |
+			RTE_ETH_LINK_SPEED_50G | RTE_ETH_LINK_SPEED_100G;
+
+	return speed_capa;
+}
+
 static int
 dpaa2_dev_info_get(struct rte_eth_dev *dev,
 	struct rte_eth_dev_info *dev_info)
@@ -307,9 +380,6 @@ dpaa2_dev_info_get(struct rte_eth_dev *dev,
 					dev_rx_offloads_nodis;
 	dev_info->tx_offload_capa = dev_tx_offloads_sup |
 					dev_tx_offloads_nodis;
-	dev_info->speed_capa = RTE_ETH_LINK_SPEED_1G |
-			RTE_ETH_LINK_SPEED_2_5G |
-			RTE_ETH_LINK_SPEED_10G;
 	dev_info->dev_capa &= ~RTE_ETH_DEV_CAPA_FLOW_RULE_KEEP;
 
 	dev_info->max_hash_mac_addrs = 0;
@@ -326,12 +396,7 @@ dpaa2_dev_info_get(struct rte_eth_dev *dev,
 	dev_info->default_txportconf.ring_size = CONG_ENTER_TX_THRESHOLD;
 	dev_info->default_rxportconf.ring_size = DPAA2_RX_DEFAULT_NBDESC;
 
-	if (dpaa2_svr_family == SVR_LX2160A) {
-		dev_info->speed_capa |= RTE_ETH_LINK_SPEED_25G |
-				RTE_ETH_LINK_SPEED_40G |
-				RTE_ETH_LINK_SPEED_50G |
-				RTE_ETH_LINK_SPEED_100G;
-	}
+	dev_info->speed_capa = priv->speed_capa;
 
 	return 0;
 }
@@ -1133,6 +1198,7 @@ dpaa2_supported_ptypes_get(struct rte_eth_dev *dev, size_t *no_of_elements)
 		/*todo -= add more types */
 		RTE_PTYPE_L2_ETHER,
 		RTE_PTYPE_L3_IPV4,
+
 		RTE_PTYPE_L3_IPV4_EXT,
 		RTE_PTYPE_L3_IPV6,
 		RTE_PTYPE_L3_IPV6_EXT,
@@ -3010,6 +3076,9 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	DPAA2_PMD_INFO("%s: netdev created, connected to %s",
 		eth_dev->data->name, dpaa2_dev->ep_name);
 
+
+	priv->speed_capa = dpaa2_dev_get_speed_capability(eth_dev);
+
 	return 0;
 init_err:
 	dpaa2_dev_close(eth_dev);
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index ee5ae3b70a..70357f0351 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -396,6 +396,7 @@ struct dpaa2_dev_priv {
 
 	uint16_t dpni_ver_major;
 	uint16_t dpni_ver_minor;
+	uint32_t speed_capa;
 
 	enum rte_dpaa2_dev_type ep_dev_type;   /**< Endpoint Device Type */
 	uint16_t ep_object_id;                 /**< Endpoint DPAA2 Object ID */
@@ -433,6 +434,17 @@ struct dpaa2_dev_priv {
 	LIST_HEAD(shaper_profiles, dpaa2_tm_shaper_profile) shaper_profiles;
 };
 
+#define DPNI_GET_MAC_SUPPORTED_IFS_VER_MAJOR	8
+#define DPNI_GET_MAC_SUPPORTED_IFS_VER_MINOR	6
+
+static inline int dpaa2_dev_cmp_dpni_ver(struct dpaa2_dev_priv *priv,
+					 uint16_t ver_major, uint16_t ver_minor)
+{
+	if (priv->dpni_ver_major == ver_major)
+		return priv->dpni_ver_minor - ver_minor;
+	return priv->dpni_ver_major - ver_major;
+}
+
 int dpaa2_distset_to_dpkg_profile_cfg(uint64_t req_dist_set,
 				      struct dpkg_profile_cfg *kg_cfg);
 
diff --git a/drivers/net/dpaa2/mc/dpni.c b/drivers/net/dpaa2/mc/dpni.c
index f651f29b02..a1f168dd04 100644
--- a/drivers/net/dpaa2/mc/dpni.c
+++ b/drivers/net/dpaa2/mc/dpni.c
@@ -3493,6 +3493,7 @@ int dpni_sp_enable(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
 	/* send command to MC */
 	return mc_send_command(mc_io, &cmd);
 }
+
 /**
  * dpni_get_mac_statistics() - Get statistics on the connected DPMAC objects
  * @mc_io:       Pointer to opaque I/O object
@@ -3520,3 +3521,23 @@ int dpni_get_mac_statistics(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_
 
 	return mc_send_command(mc_io, &cmd);
 }
+
+int dpni_get_mac_speed_capability(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
+				  uint32_t *speed_cap)
+{
+	struct dpni_rsp_mac_speed_cap *rsp_params;
+	struct mc_command cmd = { 0 };
+	int err;
+
+	cmd.header = mc_encode_cmd_header(DPNI_CMDID_GET_MAC_SPEED_CAPABILITY,
+					  cmd_flags, token);
+
+	err = mc_send_command(mc_io, &cmd);
+	if (err)
+		return err;
+
+	rsp_params = (struct dpni_rsp_mac_speed_cap *)cmd.params;
+	*speed_cap = le32_to_cpu(rsp_params->speed_cap);
+
+	return 0;
+}
diff --git a/drivers/net/dpaa2/mc/fsl_dpmac.h b/drivers/net/dpaa2/mc/fsl_dpmac.h
index 13b5a94b8c..ed73939ec0 100644
--- a/drivers/net/dpaa2/mc/fsl_dpmac.h
+++ b/drivers/net/dpaa2/mc/fsl_dpmac.h
@@ -92,6 +92,21 @@ enum dpmac_eth_if {
 	DPMAC_ETH_IF_1000BASEX,
 	DPMAC_ETH_IF_USXGMII,
 };
+
+enum dpmac_link_speed {
+	DPMAC_LINK_SPEED_10M = 0,
+	DPMAC_LINK_SPEED_100M,
+	DPMAC_LINK_SPEED_1G,
+	DPMAC_LINK_SPEED_2_5G,
+	DPMAC_LINK_SPEED_5G,
+	DPMAC_LINK_SPEED_10G,
+	DPMAC_LINK_SPEED_25G,
+	DPMAC_LINK_SPEED_40G,
+	DPMAC_LINK_SPEED_50G,
+	DPMAC_LINK_SPEED_100G,
+	DPMAC_LINK_SPEED_MAX,
+};
+
 /*
  * @DPMAC_FEC_NONE: RS-FEC (enabled by default) is disabled
  * @DPMAC_FEC_RS: RS-FEC (Clause 91) mode configured
diff --git a/drivers/net/dpaa2/mc/fsl_dpni.h b/drivers/net/dpaa2/mc/fsl_dpni.h
index 2f8125314c..8d28b8ce76 100644
--- a/drivers/net/dpaa2/mc/fsl_dpni.h
+++ b/drivers/net/dpaa2/mc/fsl_dpni.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
  *
  * Copyright 2013-2016 Freescale Semiconductor Inc.
- * Copyright 2016-2023 NXP
+ * Copyright 2016-2025 NXP
  *
  */
 #ifndef __FSL_DPNI_H
@@ -2017,4 +2017,7 @@ int dpni_sp_enable(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
 int dpni_get_mac_statistics(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
 			    uint64_t iova_cnt, uint64_t iova_values, uint32_t num_cnt);
 
+int dpni_get_mac_speed_capability(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
+				  uint32_t *speed_cap);
+
 #endif /* __FSL_DPNI_H */
diff --git a/drivers/net/dpaa2/mc/fsl_dpni_cmd.h b/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
index f653f2c0e4..cf4558d540 100644
--- a/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
+++ b/drivers/net/dpaa2/mc/fsl_dpni_cmd.h
@@ -132,6 +132,7 @@
 #define DPNI_CMDID_SET_QUEUE_TX_CONFIRMATION_MODE	DPNI_CMD(0x281)
 #define DPNI_CMDID_GET_QUEUE_TX_CONFIRMATION_MODE	DPNI_CMD(0x282)
 #define DPNI_CMDID_GET_MAC_STATISTICS			DPNI_CMD(0x283)
+#define DPNI_CMDID_GET_MAC_SPEED_CAPABILITY		DPNI_CMD(0x284)
 
 /* Macros for accessing command fields smaller than 1byte */
 #define DPNI_MASK(field)	\
@@ -1031,5 +1032,8 @@ struct dpni_cmd_get_mac_statistics {
 	uint32_t num_cnt;
 };
 
+struct dpni_rsp_mac_speed_cap {
+	uint32_t speed_cap;
+};
 #pragma pack(pop)
 #endif /* _FSL_DPNI_CMD_H */
-- 
2.25.1

