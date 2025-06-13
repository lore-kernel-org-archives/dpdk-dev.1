Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CF9BC71148
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 02:12:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C7C9B42E5E;
	Fri, 13 Jun 2025 04:11:57 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazon11012022.outbound.protection.outlook.com [52.101.71.22])
 by mails.dpdk.org (Postfix) with ESMTP id F062442E75
 for <dev@dpdk.org>; Fri, 13 Jun 2025 04:11:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApanFFyYowadiHSlgQqQmaHqQVcVUoQHgMBkz50PnacLFewz6USG8X/2CNOy+ex9901NEtMZGxxbmP4W/sPa9ar4wWEu84TP26n2Weg1HwfNbzx9aKxhd5jdzljddcrjUXQY3vGZBWFgxQ/P/ClPaJs0pDR4mTD8GRuh3jqKuZ7543mfb/Zasl+VjVt3emhd4kcwRlRZ0/f7/BSQI+Hp9iGwvpArRxXzfiXFZLpgE0iagrGhtDLXjgfrTlaGWgN6uIfdzVFo53AJVRMPFG9F4EKBx3zN7xn+kJKnR0m34UDoKQV7gJS5qG9c76EpyXE/Wn60E0T6wy+Fo5fzK7WSrw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHFH0GrvyUJWy4AGyUbFAmoTDTgzzXw8BdUSz0+Vebw=;
 b=qtR+o08xaB1PWSmU1B1KKbNobTL21eMFjsR9WIRMab3YhpZf2tMbO0ugNbTpa2V3DG2aB7WJz2ld9QVJNwFZfozSElsfVPefwqrXqfxkS69H7TVQhV8g5fJUFj0Wvz4HzysFTcfR/pUKCGD7cqsw6/IM8L7jVkew6BjTkuJq1zqLGhZdniGsDhzxlidqCLGZkuLrF10F+PhXpSFiFMtmjlswJubGFZwnIL+FjLeJ3Fujy+33mm3nOo50gsbb5ASw0uPC3DjtGJEgJ0cFJ1+VKaX4kilj4dNPQaz1Z48bHITNTV4AWAxFc7HQc/Xkb6nd0gPCsZA8mVVoo6TipOB1eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHFH0GrvyUJWy4AGyUbFAmoTDTgzzXw8BdUSz0+Vebw=;
 b=Qst0ZqOwro21xNDSFWqHUXQX1mhtaGAYM+OoTUMpQyKE2zbstdBqoovsG432ir2qwws+eSbt8W8vSCfDi0b0Sj97iJR8OVJ+b3VzG85PFzbipii4bmm77v5yH4YA/hpUIiJvXO4aveeIZWhrnmOd+Th+1tAxP/5U03TFGWZs9JJwTnfAdjJgD6BshJ9b2jMlWRzLf727TOb1qaW11WriAAm69XDp/HmSKxD9B6MTd4ViCF8aFGGFAASu74312642hbjqcgbatvMAt4lS05rrKq3Ob+ug/NtA/7PApvEH8YdhhwyI8370kSX6sYc26LV3IT9fsziWfFtnaeThlzLhXQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by DB8PR04MB6907.eurprd04.prod.outlook.com (2603:10a6:10:119::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Fri, 13 Jun
 2025 02:11:53 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 02:11:53 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Apeksha Gupta <apeksha.gupta@nxp.com>
Subject: [PATCH v5 05/11] net/dpaa2: add dpmac MC header file
Date: Fri, 13 Jun 2025 07:41:19 +0530
Message-Id: <20250613021125.790614-6-g.singh@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 42553e6c-5eb5-44f8-a9aa-08ddaa1fa9d0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IUyxnb30q+YwNVHkhNh3jCMwy/p73Bw43eK822PJ4vwW0+DdVtU/BlB4wfza?=
 =?us-ascii?Q?Tmb5haQg4twsMidU1D1kb1eB216lzVz9MkBYQedXxzn0a5nUXPSxT/IvdbIC?=
 =?us-ascii?Q?Bcc/y0+7wh/1garqw1+FGNMkcBprUVXAVm4nFjDwBxYiicSylsKohh2kq5y/?=
 =?us-ascii?Q?9Uzo2QigT98aM8Uvig5ZEGVIxxDK7ewu2o6vCwnXY/Ii1pksgCvvmJMdh9O2?=
 =?us-ascii?Q?1teFc0O1kltMxbuKdGWg2AjMhj+hPvwbC9485EnLZmNZ9f+bxmeRuc6JFW3j?=
 =?us-ascii?Q?Rs6Yd4s4G7SJCndCgXwabtP4UZn9ShUp2vH69tIcbmoRG253/uFaMEDW+fKM?=
 =?us-ascii?Q?2TQkP4Ehduiv0zDSS4uQWkP7IjygkoSHcdEeyyCT7zzhj3k/S6pS5qvrF2aZ?=
 =?us-ascii?Q?oR+zIVwpApszdtjNvIFhL6RYds/xaYDrmwqjm29vYv+MMX2VD3SmG4VT8zTP?=
 =?us-ascii?Q?59fjAH1ujSvGkEDwJjU+YvL3U6uY3tRsbnwn6dtWPAPEivtF62P3WIB5s67p?=
 =?us-ascii?Q?HxJlRsqEwIwOwUJ6oxbaavEatinGbYcjE/tozhT+MTCLLvTj/HtRUV3dv3Cv?=
 =?us-ascii?Q?BQiXYpQ0iS5xy9J2kdALzAFQXPCDzozki56SH76s3PnCJhQ/zV8EKKLjrRgH?=
 =?us-ascii?Q?CdInRGoLn4IkGVbWkdnwpStR/HsMdi+snBx2fQnpCUxmKwWLPL7K4luaq9Xy?=
 =?us-ascii?Q?2/RmmwfB3AwZPNozg7tk53yEz1h1KpWGmKgQ8yXiwaC+1PMfHGmw5qcEcVv9?=
 =?us-ascii?Q?XaFxaIABi2rybfIIni+MUUCezI2GNcEH/47lfeAIEU25jI7ayFHR79gTa0IS?=
 =?us-ascii?Q?AEAXkG0KMAbfz9ELSnWZGiEO1PjXSvpM9V3IJSbiPmL8enpWsytf/ZQANELd?=
 =?us-ascii?Q?99f68es6sD5oQF1jGLpwRfBMVeqj7EEVzIX+mLDTTt+PfE357iNxfbQOnyo0?=
 =?us-ascii?Q?rN5F2HfOzppY+IKU6Lw6mpI7C1/+Rdv3mdbtq2A2+4azgCOKXwKGP520dvKY?=
 =?us-ascii?Q?I6NL1k9u3d4hR+6eD/F2x12AAxEAvkEiAS/yCUb8C5YR+HMK35FJ7J0TDL53?=
 =?us-ascii?Q?cPiNDAlAqqK9Bs2QJonlZm3XUso05CJwr/j/bHPJGOhjqCB/mUV5orC8mgux?=
 =?us-ascii?Q?IO/WC0M1KfS/RfDNooku/PM21dTt39a+KwmhRgBtyZ12GPGyc+Pu17PjhOMp?=
 =?us-ascii?Q?FaDOOX8SaY9nWEzW2dQZ1SZJD4xNmh6xIC34Sk7DuKyuhN+lGiAdAc+5NfZU?=
 =?us-ascii?Q?LgicSmliHQ6Ff2YZrVwXBzCPJ5DK8Hev7tzFqxJAi/fcoO67anS5jPJCf1wI?=
 =?us-ascii?Q?Dvun9RSlZFx0tBiE8iBA3h0WnE1ofb1Tsz4hm94H9OUo4ETOEHbiBJldoEXn?=
 =?us-ascii?Q?5U699fDyA0Y4HMpHth7gEoKRHhR95CaecC38RATEdKPYjT6Flzs4k1VVft4I?=
 =?us-ascii?Q?XTo7cj5PD28vDEUDXKdcN6ZKj8aJ7nZW46ONXaNNpwtBgEUoNB9+Kg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?6zslRUBoBezwIgJ/Y3p/ETwBAzb9mALkxfISoFRDpqJCkLCM7kg2OcdPrVSx?=
 =?us-ascii?Q?vkn5ekHWmCVvxSADAx7Mc+MnhXeaLWcEy+RsMskx7o9kmJ99XD33oVXJJkws?=
 =?us-ascii?Q?5+93L5dbGXdR5A6/Eu/PIXGt57AGSPSvv7/LYajnN4FlCQELEAXd7pZxhoX5?=
 =?us-ascii?Q?hcndSuJJYSMH0lARImPeFKul9xXOGNQT/lVDV5wRdFvKS/wk503QCr/21hpq?=
 =?us-ascii?Q?rRIdFcEhWWFGiY0gNJI/1Dw2XviQZRjAzMVytYJ2q2N5Zd3USxIGkyLJFLjC?=
 =?us-ascii?Q?lfwWa12lpDKNv4jPld47QBCxKN+j30FzWB4WtICFXDFjLQ4nqAA1rOXiBdrF?=
 =?us-ascii?Q?GH+tpXy1H+cGRBIgR0ExsGLwt7NcLDdOijcNwIGwLpqEu3axHa9wWwoNh2F2?=
 =?us-ascii?Q?DbItj7Id1klWhFa1pcAIfupCIcGON1+z9TQDKRkB4TUYg8/S+AShyJn6FkU4?=
 =?us-ascii?Q?XA3UCwLAOE6cXyZlnxPMR/IZPytRkYUInWMQaVu4/zkZIYzNibiW+IAHPGnd?=
 =?us-ascii?Q?x8CJnG8EBRmivLrv9mLyBUkNizG1wNKULq0Zc4BF+CQXEe5RjbK5hv8gWqQf?=
 =?us-ascii?Q?8hyOIIcjV3HFcS9jNkhe3ozLnB+U1TB3LuJoaL+LLSL9pgS6caeIvfbT6vHb?=
 =?us-ascii?Q?NVPefIv8HB6Dpz5hqVKCzAa+AE37Jtg8phoMAiaTKHp4zzA8x/e/oRO5U8Hm?=
 =?us-ascii?Q?Q23af7odHySrxfwDc59RvrNg5wISR4NwhDDxiKXozJltl04HVuAnen5F+lfJ?=
 =?us-ascii?Q?PcSDIIvn2rydFHmo8KeOViYnl2RlQ39UwPzh3bTkPIiKA0c7NTMlfm5CJGk3?=
 =?us-ascii?Q?GGlyBhPb+L0YArjpIgmzUjoRHvMLasuAYCalOozIbm4dVpulWEVumt5Oj33q?=
 =?us-ascii?Q?vwkz0gZRtEE/Hgw1mh9JosX0u25jXfNpGQYyIxgz7XqMunLnZttqHBmgveSs?=
 =?us-ascii?Q?eqKliGg16z0jFrqshI6BUiKDQICWVfKC/oZN4eTZBGLVNL5LC/hNPRZI6Zfq?=
 =?us-ascii?Q?F7h0SARDqFUdktWo2Pv8oFm5IS4+xKs7g24FU8gpiGXxoyi7ke4lUZ+08fkO?=
 =?us-ascii?Q?6h5QvUoqpPkGyPdD1iBr1G+c6FIU2CzTqNL7+QHUyLRI36XaoQbIagIuzsTX?=
 =?us-ascii?Q?g06SNSUSL/b8jnCiV4SVBq0UkeU3Pup5MynBohC5NDj357QpHcKl3cL+cyTf?=
 =?us-ascii?Q?Cfny2TZ245YndXG+SH0Ck80wGFpbXps6nnXPOc9WFNW9pf1ibF/mMeTKTNpz?=
 =?us-ascii?Q?4wRsWncZcf4ebi0OPIbYb0bOyP8C1RcmsjOH4BIEdE7NPpGH+pmkzpiRXK8v?=
 =?us-ascii?Q?BLqFUV35O3w1owwg8/0QSt356rC7jlIdvnHOTcbWxxj9bz4VISgutkYPmVqb?=
 =?us-ascii?Q?+3PjdA/zFUk/IkqdL3ZKeDQ4auiVF7agTwxQkQj8IFDe97jiALQ1450/4uN3?=
 =?us-ascii?Q?coEcDgKTaFCG7b25l7mTgjHDZzU4QlfHoWJfJ5jCDbA0adXuc/+TVs2LfM+H?=
 =?us-ascii?Q?PvOqLZNtzMtGCOlPxNyEajKzIxdHbm6nPhXo8S8vSeZjLKfO5/5lgc/F5TGH?=
 =?us-ascii?Q?j/5drQJJ5XnirGyZvH0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 42553e6c-5eb5-44f8-a9aa-08ddaa1fa9d0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 02:11:53.0203 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HNo2mpKejc5LT0fAN92Awnv/sDzISSk7isoUf1DF8ZzDStU4i8ctHLX060LGATaq
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

From: Apeksha Gupta <apeksha.gupta@nxp.com>

This patch upgrades the MC firmware release API compatibility
to 10.39.0. Added mc/fsl_dpmac.h file.

Signed-off-by: Apeksha Gupta <apeksha.gupta@nxp.com>
---
 drivers/net/dpaa2/mc/fsl_dpmac.h | 465 +++++++++++++++++++++++++++++++
 1 file changed, 465 insertions(+)
 create mode 100644 drivers/net/dpaa2/mc/fsl_dpmac.h

diff --git a/drivers/net/dpaa2/mc/fsl_dpmac.h b/drivers/net/dpaa2/mc/fsl_dpmac.h
new file mode 100644
index 0000000000..41eca47cfa
--- /dev/null
+++ b/drivers/net/dpaa2/mc/fsl_dpmac.h
@@ -0,0 +1,465 @@
+/* SPDX-License-Identifier: (BSD-3-Clause OR GPL-2.0)
+ *
+ * Copyright 2013-2016 Freescale Semiconductor Inc.
+ * Copyright 2018-2025 NXP
+ *
+ */
+
+#ifndef __FSL_DPMAC_H
+#define __FSL_DPMAC_H
+
+/** @addtogroup dpmac Data Path MAC API
+ * Contains initialization APIs and runtime control APIs for DPMAC
+ * @{
+ */
+
+struct fsl_mc_io;
+
+int dpmac_open(struct fsl_mc_io *mc_io,
+	       uint32_t cmd_flags,
+	       int dpmac_id,
+	       uint16_t *token);
+
+int dpmac_close(struct fsl_mc_io *mc_io,
+		uint32_t cmd_flags,
+		uint16_t token);
+
+/**
+ * enum dpmac_link_type -  DPMAC link type
+ * @DPMAC_LINK_TYPE_NONE: No link
+ * @DPMAC_LINK_TYPE_FIXED: Link is fixed type
+ * @DPMAC_LINK_TYPE_PHY: Link by PHY ID
+ * @DPMAC_LINK_TYPE_BACKPLANE: Backplane link type
+ */
+enum dpmac_link_type {
+	DPMAC_LINK_TYPE_NONE,
+	DPMAC_LINK_TYPE_FIXED,
+	DPMAC_LINK_TYPE_PHY,
+	DPMAC_LINK_TYPE_BACKPLANE
+};
+
+/**
+ * enum dpmac_eth_if - DPMAC Ethrnet interface
+ * @DPMAC_ETH_IF_MII: MII interface
+ * @DPMAC_ETH_IF_RMII: RMII interface
+ * @DPMAC_ETH_IF_SMII: SMII interface
+ * @DPMAC_ETH_IF_GMII: GMII interface
+ * @DPMAC_ETH_IF_RGMII: RGMII interface
+ * @DPMAC_ETH_IF_SGMII: SGMII interface
+ * @DPMAC_ETH_IF_QSGMII: QSGMII interface
+ * @DPMAC_ETH_IF_XAUI: XAUI interface
+ * @DPMAC_ETH_IF_XFI: XFI interface
+ * @DPMAC_ETH_IF_CAUI: CAUI interface
+ * @DPMAC_ETH_IF_1000BASEX: 1000BASEX interface
+ * @DPMAC_ETH_IF_USXGMII: USXGMII interface
+ */
+enum dpmac_eth_if {
+	DPMAC_ETH_IF_MII,
+	DPMAC_ETH_IF_RMII,
+	DPMAC_ETH_IF_SMII,
+	DPMAC_ETH_IF_GMII,
+	DPMAC_ETH_IF_RGMII,
+	DPMAC_ETH_IF_SGMII,
+	DPMAC_ETH_IF_QSGMII,
+	DPMAC_ETH_IF_XAUI,
+	DPMAC_ETH_IF_XFI,
+	DPMAC_ETH_IF_CAUI,
+	DPMAC_ETH_IF_1000BASEX,
+	DPMAC_ETH_IF_USXGMII,
+};
+/*
+ * @DPMAC_FEC_NONE: RS-FEC (enabled by default) is disabled
+ * @DPMAC_FEC_RS: RS-FEC (Clause 91) mode configured
+ * @DPMAC_FEC_FC: FC-FEC (Clause 74) mode configured (not yet supported)
+ */
+enum dpmac_fec_mode {
+	DPMAC_FEC_NONE,
+	DPMAC_FEC_RS,
+	DPMAC_FEC_FC,
+};
+
+/* serdes sfi/custom settings feature internals
+ * @SERDES_CFG_DEFAULT: the default configuration.
+ * @SERDES_CFG_SFI: default operating mode for XFI interfaces
+ * @SERDES_CFG_CUSTOM: It allows the user to manually configure the type of equalization,
+ *	amplitude, preq and post1q settings. Can be used with all interfaces except RGMII.
+ */
+enum serdes_eq_cfg_mode {
+	SERDES_CFG_DEFAULT = 0,
+	SERDES_CFG_SFI,
+	SERDES_CFG_CUSTOM,
+};
+
+/**
+ * struct dpmac_cfg - Structure representing DPMAC configuration
+ * @mac_id:	Represents the Hardware MAC ID; in case of multiple WRIOP,
+ *		the MAC IDs are continuous.
+ *		For example:  2 WRIOPs, 16 MACs in each:
+ *				MAC IDs for the 1st WRIOP: 1-16,
+ *				MAC IDs for the 2nd WRIOP: 17-32.
+ */
+struct dpmac_cfg {
+	uint16_t mac_id;
+};
+
+int dpmac_create(struct fsl_mc_io *mc_io,
+		 uint16_t dprc_token,
+		 uint32_t cmd_flags,
+		 const struct dpmac_cfg *cfg,
+		 uint32_t *obj_id);
+
+int dpmac_destroy(struct fsl_mc_io *mc_io,
+		  uint16_t dprc_token,
+		  uint32_t cmd_flags,
+		  uint32_t object_id);
+
+/**
+ * DPMAC IRQ Index and Events
+ */
+
+/**
+ * IRQ index
+ */
+#define DPMAC_IRQ_INDEX				0
+/**
+ * IRQ event - indicates a change in link state
+ */
+#define DPMAC_IRQ_EVENT_LINK_CFG_REQ		0x00000001
+/**
+ * IRQ event - Indicates that the link state changed
+ */
+#define DPMAC_IRQ_EVENT_LINK_CHANGED		0x00000002
+/**
+ * IRQ event - The object requests link up
+ */
+#define DPMAC_IRQ_EVENT_LINK_UP_REQ			0x00000004
+/**
+ * IRQ event - The object requests link down
+ */
+#define DPMAC_IRQ_EVENT_LINK_DOWN_REQ		0x00000008
+/**
+ * IRQ event - indicates a change in endpoint
+ */
+#define DPMAC_IRQ_EVENT_ENDPOINT_CHANGED	0x00000010
+
+int dpmac_set_irq_enable(struct fsl_mc_io *mc_io,
+			 uint32_t cmd_flags,
+			 uint16_t token,
+			 uint8_t irq_index,
+			 uint8_t en);
+
+int dpmac_get_irq_enable(struct fsl_mc_io *mc_io,
+			 uint32_t cmd_flags,
+			 uint16_t token,
+			 uint8_t irq_index,
+			 uint8_t *en);
+
+int dpmac_set_irq_mask(struct fsl_mc_io *mc_io,
+		       uint32_t cmd_flags,
+		       uint16_t token,
+		       uint8_t irq_index,
+		       uint32_t mask);
+
+int dpmac_get_irq_mask(struct fsl_mc_io *mc_io,
+		       uint32_t cmd_flags,
+		       uint16_t token,
+		       uint8_t irq_index,
+		       uint32_t *mask);
+
+int dpmac_get_irq_status(struct fsl_mc_io *mc_io,
+			 uint32_t cmd_flags,
+			 uint16_t token,
+			 uint8_t irq_index,
+			 uint32_t *status);
+
+int dpmac_clear_irq_status(struct fsl_mc_io *mc_io,
+			   uint32_t cmd_flags,
+			   uint16_t token,
+			   uint8_t irq_index,
+			   uint32_t status);
+
+/**
+ * @brief	Inter-Frame Gap mode
+ *
+ * LAN/WAN uses different Inter-Frame Gap mode
+ */
+enum dpmac_ifg_mode {
+	DPMAC_IFG_MODE_FIXED,
+	/*!< IFG length represents number of octets in steps of 4 */
+	DPMAC_IFG_MODE_STRETCHED
+	/*!< IFG length represents the stretch factor */
+};
+
+/**
+ * @brief Structure representing Inter-Frame Gap mode configuration
+ */
+struct dpmac_ifg_cfg {
+	enum dpmac_ifg_mode ipg_mode; /*!< WAN/LAN mode */
+	uint8_t ipg_length; /*!< IPG Length, default value is 0xC */
+};
+
+/**
+ * @brief Structure used to read through MDIO
+ */
+struct dpmac_mdio_read {
+	uint8_t cl45; /*!< Clause 45 */
+	uint8_t phy_addr; /*!< MDIO PHY address */
+	uint16_t reg; /*!< PHY register */
+};
+
+/**
+ * @brief Structure used to write through MDIO
+ */
+struct dpmac_mdio_write {
+	uint8_t cl45; /*!< Clause 45 */
+	uint8_t phy_addr; /*!< MDIO PHY address */
+	uint16_t reg; /*!< PHY register */
+	uint16_t data; /*!< Data to be written */
+};
+
+#define DPMAC_SET_PARAMS_IFG 0x1
+
+/**
+ * struct serdes_eq_settings - Structure  SerDes equalization settings
+ * cfg: serdes sfi/custom/default settings feature internals
+ * @eq_type: Number of levels of TX equalization
+ * @sgn_preq: Precursor sign indicating direction of eye closure
+ * @eq_preq: Drive strength of TX full swing transition bit to precursor
+ * @sgn_post1q: First post-cursor sign indicating direction of eye closure
+ * @eq_post1q: Drive strength of full swing transition bit to first post-cursor
+ * @eq_amp_red: Overall transmit amplitude reduction
+ */
+struct serdes_eq_settings {
+	enum serdes_eq_cfg_mode cfg;
+	int eq_type;
+	int sgn_preq;
+	int eq_preq;
+	int sgn_post1q;
+	int eq_post1q;
+	int eq_amp_red;
+};
+
+/**
+ * struct dpmac_attr - Structure representing DPMAC attributes
+ * @id:		DPMAC object ID
+ * @max_rate:	Maximum supported rate - in Mbps
+ * @eth_if:	Ethernet interface
+ * @link_type:	link type
+ * @fec_mode:	FEC mode - Configurable only for 25G interfaces
+ * serdes_cfg:	SerDes equalization settings
+ */
+struct dpmac_attr {
+	uint16_t id;
+	uint32_t max_rate;
+	enum dpmac_eth_if eth_if;
+	enum dpmac_link_type link_type;
+	enum dpmac_fec_mode fec_mode;
+	struct serdes_eq_settings serdes_cfg;
+	struct dpmac_ifg_cfg ifg_cfg;
+};
+
+int dpmac_get_attributes(struct fsl_mc_io *mc_io,
+			 uint32_t cmd_flags,
+			 uint16_t token,
+			 struct dpmac_attr *attr);
+
+int dpmac_set_params(struct fsl_mc_io *mc_io,
+		       uint32_t cmd_flags,
+		       uint16_t token,
+			   uint32_t flags,
+			   struct dpmac_ifg_cfg ifg_cfg);
+
+int dpmac_get_mac_addr(struct fsl_mc_io *mc_io,
+			   uint32_t cmd_flags,
+			   uint16_t token,
+			   uint8_t mac_addr[6]);
+
+/**
+ * DPMAC link configuration/state options
+ */
+
+/**
+ * Enable auto-negotiation
+ */
+#define DPMAC_LINK_OPT_AUTONEG		0x0000000000000001ULL
+/**
+ * Enable half-duplex mode
+ */
+#define DPMAC_LINK_OPT_HALF_DUPLEX	0x0000000000000002ULL
+/**
+ * Enable pause frames
+ */
+#define DPMAC_LINK_OPT_PAUSE		0x0000000000000004ULL
+/**
+ * Enable a-symmetric pause frames
+ */
+#define DPMAC_LINK_OPT_ASYM_PAUSE	0x0000000000000008ULL
+/**
+ * Advertise 10MB full duplex
+ */
+#define DPMAC_ADVERTISED_10BASET_FULL           0x0000000000000001ULL
+/**
+ * Advertise 100MB full duplex
+ */
+#define DPMAC_ADVERTISED_100BASET_FULL          0x0000000000000002ULL
+/**
+ * Advertise 1GB full duplex
+ */
+#define DPMAC_ADVERTISED_1000BASET_FULL         0x0000000000000004ULL
+/**
+ * Advertise auto-negotiation enable
+ */
+#define DPMAC_ADVERTISED_AUTONEG                0x0000000000000008ULL
+/**
+ * Advertise 10GB full duplex
+ */
+#define DPMAC_ADVERTISED_10000BASET_FULL        0x0000000000000010ULL
+/**
+ * Advertise 2.5GB full duplex
+ */
+#define DPMAC_ADVERTISED_2500BASEX_FULL         0x0000000000000020ULL
+/**
+ * Advertise 5GB full duplex
+ */
+#define DPMAC_ADVERTISED_5000BASET_FULL         0x0000000000000040ULL
+
+/**
+ * struct dpmac_link_cfg - Structure representing DPMAC link configuration
+ * @rate: Link's rate - in Mbps
+ * @options: Enable/Disable DPMAC link cfg features (bitmap)
+ * @advertising: Speeds that are advertised for autoneg (bitmap)
+ */
+struct dpmac_link_cfg {
+	uint32_t rate;
+	uint64_t options;
+	uint64_t advertising;
+};
+
+int dpmac_get_link_cfg(struct fsl_mc_io *mc_io,
+		       uint32_t cmd_flags,
+		       uint16_t token,
+		       struct dpmac_link_cfg *cfg);
+
+/**
+ * struct dpmac_link_state - DPMAC link configuration request
+ * @rate: Rate in Mbps
+ * @options: Enable/Disable DPMAC link cfg features (bitmap)
+ * @up: Link state
+ * @state_valid: Ignore/Update the state of the link
+ * @supported: Speeds capability of the phy (bitmap)
+ * @advertising: Speeds that are advertised for autoneg (bitmap)
+ */
+struct dpmac_link_state {
+	uint32_t rate;
+	uint64_t options;
+	int up;
+	int state_valid;
+	uint64_t supported;
+	uint64_t advertising;
+};
+
+int dpmac_set_link_state(struct fsl_mc_io *mc_io,
+			 uint32_t cmd_flags,
+			 uint16_t token,
+			 struct dpmac_link_state *link_state);
+
+/**
+ * enum dpmac_counter - DPMAC counter types
+ * @DPMAC_CNT_ING_FRAME_64: counts 64-bytes frames, good or bad.
+ * @DPMAC_CNT_ING_FRAME_127: counts 65- to 127-bytes frames, good or bad.
+ * @DPMAC_CNT_ING_FRAME_255: counts 128- to 255-bytes frames, good or bad.
+ * @DPMAC_CNT_ING_FRAME_511: counts 256- to 511-bytes frames, good or bad.
+ * @DPMAC_CNT_ING_FRAME_1023: counts 512- to 1023-bytes frames, good or bad.
+ * @DPMAC_CNT_ING_FRAME_1518: counts 1024- to 1518-bytes frames, good or bad.
+ * @DPMAC_CNT_ING_FRAME_1519_MAX: counts 1519-bytes frames and larger
+ *				  (up to max frame length specified),
+ *				  good or bad.
+ * @DPMAC_CNT_ING_FRAG: counts frames which are shorter than 64 bytes received
+ *			with a wrong CRC
+ * @DPMAC_CNT_ING_JABBER: counts frames longer than the maximum frame length
+ *			  specified, with a bad frame check sequence.
+ * @DPMAC_CNT_ING_FRAME_DISCARD: counts dropped frames due to internal errors.
+ *				 Occurs when a receive FIFO overflows.
+ *				 Includes also frames truncated as a result of
+ *				 the receive FIFO overflow.
+ * @DPMAC_CNT_ING_ALIGN_ERR: counts frames with an alignment error
+ *			     (optional used for wrong SFD).
+ * @DPMAC_CNT_EGR_UNDERSIZED: counts frames transmitted that was less than 64
+ *			      bytes long with a good CRC.
+ * @DPMAC_CNT_ING_OVERSIZED: counts frames longer than the maximum frame length
+ *			     specified, with a good frame check sequence.
+ * @DPMAC_CNT_ING_VALID_PAUSE_FRAME: counts valid pause frames (regular and PFC)
+ * @DPMAC_CNT_EGR_VALID_PAUSE_FRAME: counts valid pause frames transmitted
+ *				     (regular and PFC).
+ * @DPMAC_CNT_ING_BYTE: counts bytes received except preamble for all valid
+ *			frames and valid pause frames.
+ * @DPMAC_CNT_ING_MCAST_FRAME: counts received multicast frames.
+ * @DPMAC_CNT_ING_BCAST_FRAME: counts received broadcast frames.
+ * @DPMAC_CNT_ING_ALL_FRAME: counts each good or bad frames received.
+ * @DPMAC_CNT_ING_UCAST_FRAME: counts received unicast frames.
+ * @DPMAC_CNT_ING_ERR_FRAME: counts frames received with an error
+ *			     (except for undersized/fragment frame).
+ * @DPMAC_CNT_EGR_BYTE: counts bytes transmitted except preamble for all valid
+ *			frames and valid pause frames transmitted.
+ * @DPMAC_CNT_EGR_MCAST_FRAME: counts transmitted multicast frames.
+ * @DPMAC_CNT_EGR_BCAST_FRAME: counts transmitted broadcast frames.
+ * @DPMAC_CNT_EGR_UCAST_FRAME: counts transmitted unicast frames.
+ * @DPMAC_CNT_EGR_ERR_FRAME: counts frames transmitted with an error.
+ * @DPMAC_CNT_ING_GOOD_FRAME: counts frames received without error, including
+ *			      pause frames.
+ * @DPMAC_CNT_EGR_GOOD_FRAME: counts frames transmitted without error, including
+ *			      pause frames.
+ */
+enum dpmac_counter {
+	DPMAC_CNT_ING_FRAME_64,
+	DPMAC_CNT_ING_FRAME_127,
+	DPMAC_CNT_ING_FRAME_255,
+	DPMAC_CNT_ING_FRAME_511,
+	DPMAC_CNT_ING_FRAME_1023,
+	DPMAC_CNT_ING_FRAME_1518,
+	DPMAC_CNT_ING_FRAME_1519_MAX,
+	DPMAC_CNT_ING_FRAG,
+	DPMAC_CNT_ING_JABBER,
+	DPMAC_CNT_ING_FRAME_DISCARD,
+	DPMAC_CNT_ING_ALIGN_ERR,
+	DPMAC_CNT_EGR_UNDERSIZED,
+	DPMAC_CNT_ING_OVERSIZED,
+	DPMAC_CNT_ING_VALID_PAUSE_FRAME,
+	DPMAC_CNT_EGR_VALID_PAUSE_FRAME,
+	DPMAC_CNT_ING_BYTE,
+	DPMAC_CNT_ING_MCAST_FRAME,
+	DPMAC_CNT_ING_BCAST_FRAME,
+	DPMAC_CNT_ING_ALL_FRAME,
+	DPMAC_CNT_ING_UCAST_FRAME,
+	DPMAC_CNT_ING_ERR_FRAME,
+	DPMAC_CNT_EGR_BYTE,
+	DPMAC_CNT_EGR_MCAST_FRAME,
+	DPMAC_CNT_EGR_BCAST_FRAME,
+	DPMAC_CNT_EGR_UCAST_FRAME,
+	DPMAC_CNT_EGR_ERR_FRAME,
+	DPMAC_CNT_ING_GOOD_FRAME,
+	DPMAC_CNT_EGR_GOOD_FRAME
+};
+
+int dpmac_get_counter(struct fsl_mc_io *mc_io,
+		      uint32_t cmd_flags,
+		      uint16_t token,
+		      enum dpmac_counter  type,
+		      uint64_t *counter);
+
+int dpmac_get_api_version(struct fsl_mc_io *mc_io,
+			  uint32_t cmd_flags,
+			  uint16_t *major_ver,
+			  uint16_t *minor_ver);
+
+int dpmac_reset(struct fsl_mc_io *mc_io,
+		uint32_t cmd_flags,
+		uint16_t token);
+
+int dpmac_set_protocol(struct fsl_mc_io *mc_io, uint32_t cmd_flags,
+		       uint16_t token, enum dpmac_eth_if protocol);
+
+int dpmac_get_statistics(struct fsl_mc_io *mc_io, uint32_t cmd_flags, uint16_t token,
+			 uint64_t iova_cnt, uint64_t iova_values, uint32_t num_cnt);
+
+#endif /* __FSL_DPMAC_H */
-- 
2.25.1

