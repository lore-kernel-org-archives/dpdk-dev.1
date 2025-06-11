Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723DCC677C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 10:52:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E919C409FA;
	Wed, 11 Jun 2025 12:52:22 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011046.outbound.protection.outlook.com [52.101.70.46])
 by mails.dpdk.org (Postfix) with ESMTP id 8D8FE409FA
 for <dev@dpdk.org>; Wed, 11 Jun 2025 12:52:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=umYEFKjHrqe49eNzP299NXXesTiBxFHKxr/fO4ufs+MuA4xUHr7ZL9SJJqCERAZ8y6UG6bNjprmg8S80UxtmvESnXclC3P5mCBZXYE9scHy2IPxD9b+DWoR38tE62bBbDnX5uB6sUVDb0loV9rg2s3DxpIRxacEd9M0tjwP2emS3eqW+aZpZEJomjYD9+gnHMdaxqRHNbE83M1e5MG2C56l9so30FjsKBa98/yjOqLV+DedTfcda7wyT/2BQTKZCvUtG6JqvXTvELgLaLCDSRqTHtUwl56v8x4R3tq/dJWMVWT8WawP70lQ8oCwXHGzo4sjtBvwq62YnvHYAG27rvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHFH0GrvyUJWy4AGyUbFAmoTDTgzzXw8BdUSz0+Vebw=;
 b=JeQWUY9IeMbkV/BJuSWDAlqggv/z0ad/rHib/u9Dq8HvNPDIJSEtBI0Cu9s+Ko1bPTHi2rkak3z3pIwe/8uGgCKhftMf+7lvfwwd46Paf+ps7Qg2WfZAML7X4uzMPCjImwOQ7y9YcrJjF+Wp1C5FjmPmHo38bQ0iDLUy4K+PwrzB1s5e+C/gTOqwfvuzXHr/ACatT8KzwRPS+BDCrGmhttWgsXY9J1sAkUG34VMwMMHMIoQoO+a4TfJ/6jscrtV6aq/7/T3/x6VwCWlFrsUVb0DMy0p2bkKSuuyuEd5ctZokf8mo3sBQCd5ihpFOy7L0OXtTujVRTyy1hghBkIfZjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHFH0GrvyUJWy4AGyUbFAmoTDTgzzXw8BdUSz0+Vebw=;
 b=i7urJlayOIgDNUS2XcSPG9+RRCPiWf8sQqFSEIIz4ev1jnYPqXxBu7WaZgMKu9ZTuDGj9QzgDEg7gtrDMlQdlFpX6BmeWI898hTESC1vRSipwulScTLqicn0h8tVvs052lZRYfdM+kL7Y8njxUGTWPpeiZWJ2UL0QrzkKFK20SqMvcnd+uvptoc/ricaFOMSLxXBpG3G2/5RtrxSGNtKA/kVb00C9JyZWhIMGpHEhAgXvobbMMkrpVEYb+dFY4rbAKFwdiInP5zfHtcaNcsOyDFkcPIqo+pXLKDmZ8B1BSMXNA376UUzLZiS+NxqhiyoCZEg3ZSU7rhSr8jiLybklQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM8PR04MB7348.eurprd04.prod.outlook.com (2603:10a6:20b:1db::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Wed, 11 Jun
 2025 10:52:19 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 10:52:19 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Apeksha Gupta <apeksha.gupta@nxp.com>
Subject: [PATCH v4 05/11] net/dpaa2: add dpmac MC header file
Date: Wed, 11 Jun 2025 16:21:43 +0530
Message-Id: <20250611105149.655144-6-g.singh@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 94758211-ffc1-482f-4431-08dda8d60907
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KewbVcMSke/x842se5czzy7G1YvCaU5z3JjKHe7QMoEEvkICCTA3NSZbq7bL?=
 =?us-ascii?Q?BQJvjgmG15ZYZLZ83t+HvTO/kK50BZ72FOhH2P/+db8TgraD6knNR4ZyhRYW?=
 =?us-ascii?Q?x9HZ6s3SZI+Ty2WSVeBAbDMbhi3BIqcc+TRcFl9BPsGV/A+jmaa9KI+UYbg/?=
 =?us-ascii?Q?6Widd/hhzHdcxAioaE2c+OXfzsZOrI1pyxlcumur4KvdXIxQctk2i4sy9/vW?=
 =?us-ascii?Q?TMSt3ZEoEiUpHhnE9nVwCCRhPlHy8KrJ/rHyzT7eiEymsgIoLUJrP2B0euov?=
 =?us-ascii?Q?I4VcvttDwO6wFO4f58GmTS10buZ0/vI35hapkSRv5h/76oG4qopyfztfZ60p?=
 =?us-ascii?Q?2+IDk0aRkino7USA90UbwmmhQJsa18w+i2T7cGFUXULJ6idYbMFcIT3u9igv?=
 =?us-ascii?Q?ju0f3vhR52Z+YVNQKTJhRf0YwwoqtF9XW0C2RIYlKEcBE5f5cxJLYQ/6ZcpH?=
 =?us-ascii?Q?iQN9+Wb6H4dlUwDbrXofgg0TY209LjjpuHwc/C72fX3cH1OWz5QUITGM4VaK?=
 =?us-ascii?Q?ES5sQXbE3RbH9ahmhxO+RFArCNwakZD4gX12DFXkvV+HZ3qmKyBNAfM+OKEc?=
 =?us-ascii?Q?FiJl4C8Q1DSVEK/aR7w2FksCC1jz2etifOqbPDzEEjD0ccVZTFzURZTfq3OJ?=
 =?us-ascii?Q?5v421sqJjkGwLz5HiSC86GallSbdBXqb3DdbiTcsagCndGHuFi4su/ywZPhb?=
 =?us-ascii?Q?yZw9OWIEZ2rPyNkvuoRBQy8pUTYZcKvMq7vNjGzhxUnTXVj0g6BPD6M3jFPS?=
 =?us-ascii?Q?65colGraX/R8KJk50C18YBSii7CmLEGVu1czy0vnniggRIt8onvvaTF3xZn9?=
 =?us-ascii?Q?q+zDPiqJtuQUJbIRbMWqrqbc/+hPxhQR41Ol8I7kPPCVckxIS39lVUZbs+j3?=
 =?us-ascii?Q?/NpbvnUmKpWtK+8tD5HfvydBa3lGFn+1eUKhAxIY/Qsb20T1vyqICtYZVvY/?=
 =?us-ascii?Q?rqUz+c0hBq+XNhMQgnPd5Ap+H5CfV9sZV3N28oTP5xpFxKRPPX+0RhwKHf16?=
 =?us-ascii?Q?7WknmZPm3CpxKk2N/7/sy8VbUTH7fOnOqjfYXtuoKXZvbRcT4F2HBGBe1RI0?=
 =?us-ascii?Q?v/h3SP7uBAdNCsapE22fjDLe8Fy53dTWbVS5Al9OY2GW06+b8RQlVTJZ6E2A?=
 =?us-ascii?Q?B7mnqnw+VhDvHsABK7m8pc5KCqU1Y4r5AHbzeW+yJDDVZoPUoFexjeq1gzH7?=
 =?us-ascii?Q?r69avf/HXTww6Uzy+qHpPolMDdIkX57g30CpYrSyyydRX5OhCa0/4TUFuGrY?=
 =?us-ascii?Q?zIdRobCCM8/Xv73Tow+P1J5Iwvs7ShoInJ/AfaOylSyszTlXL3eFYu4IysF9?=
 =?us-ascii?Q?/CLgqVZOp/27N9mhskza57URGJ5M4tUwXCWHb6E1ARTTi+Zk5GX3HFFkLJkM?=
 =?us-ascii?Q?yrONggHUuwJzCKgClEcH5HG167m1mK7Mk1C2rbYgmDksVrO3XKfn2zgP47Iw?=
 =?us-ascii?Q?HcZRm1IkfGUbsb+bgLZW6nAa6WwepXxB9MkF2Ee7slScE1beZH0q3Dz10/cc?=
 =?us-ascii?Q?+VVBPbuMBYy0ua4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bzCHoZPgtuR8P9Pj9xU0gvUHU7PDdfRN8B+jHd2Nu8rx9hGzHS3NDvYMH2z6?=
 =?us-ascii?Q?onMDOaUrl4tLbJVy8seM252ovQwmA6ruqKOMQe/JtRzVSwFb8Lyvb1r2n6fl?=
 =?us-ascii?Q?t6M2yjMm3DGJhbhep69MRo21rpraZEbAka//LQ3B3ReUjT/FvADZ8/t1SdkS?=
 =?us-ascii?Q?mk3MbV1e52oYBm9lPt42cJoRjb+iGVK1+lWOpqwk1NjWW0+xmzs7/I/EfsFI?=
 =?us-ascii?Q?PI8nneucKZDi20T/exReXNlFkvZfH+eTPxpVcNZkVWTY4OlNthHyxopsrhAS?=
 =?us-ascii?Q?rp1Xrumlrksl30zGiYgbwRo9P9yFb/FNHKoI8mh9rO8lSNLJCvz89ZB+nDj2?=
 =?us-ascii?Q?CXNKX9tfa4jnXQUra91X8odPV7q35jwfDbg0LnjtQCtd2KxZW6vGYap9llgK?=
 =?us-ascii?Q?AuYxzoJwPhpb1rpUk9Z5d5NbR8eJxBXTR7oRqG4+P4Gc5fUh+KJo9ceoSYMZ?=
 =?us-ascii?Q?NbKbqBoAhVYJXIooXwBLXjIwEJHOx9QnzieVpvwd6o5fOX8ZQGWFKw3BtKOE?=
 =?us-ascii?Q?3srubCdnDWmAx7b6FK5HkeTNfMk7gOEx7fAm0G5+DfCdaasOyjY0aEo+1C+X?=
 =?us-ascii?Q?MOuaA4pyDlk2evcKTFM1XH5WwKCAQ13yeSc/jV1pfQzeHDkwjG2YTMudI15g?=
 =?us-ascii?Q?XjQCiinKPrntbms31pKX5m+PPFg62M6dfcgRucJb2l/cJtGcbIP58hs+Yni+?=
 =?us-ascii?Q?vVpsUm1We5KaqzJMC7zJUBLBfb9HZZdtTGhBS8pmvYkaaz8UoX7Psrlp3zbq?=
 =?us-ascii?Q?n+g9uMuQizl7Z/w0V3PaiE2yd5R4AqoqQhrJD1JGsG/W9nCP2ic+MvTDGO9o?=
 =?us-ascii?Q?OYIMrDNJ62OQTq4Ny8qco2tlS19hrcCaA20qU48hVe4BjJ2f63zzxKyDUubQ?=
 =?us-ascii?Q?XuBDx/530BB24BDcZ5cyTH/khT2/epm8gDplPb43ndpg1eluDtQiuew6goke?=
 =?us-ascii?Q?lXUbDIK0thcS1SeL/rkRN2df1RFlGeN+yhicyHr4o6USMKcaCCSjlQThynLo?=
 =?us-ascii?Q?+6SRe/QqdMuRwjsDjio7eaMasMmi+c/FBtgIJg2MrZ7DE2O2+qSGWai84X0n?=
 =?us-ascii?Q?C43XMy5B3gKYMTPMIZd2m04jcyUpXBa6OSnprN0q7N0WY/YsxOGzOnIeqPbm?=
 =?us-ascii?Q?XaHolZAQ1XpIlmTL1h0Ql5kfYcBcBCdrMjQN923h0zkjYzdYCFXGryL2TFCS?=
 =?us-ascii?Q?XDoc1Chx1mNOfXmYn5Cn69+0dGqpWVG2+llecIIWEon3pr+JKrm94WQbJOKq?=
 =?us-ascii?Q?hTgP0tBn/NADSZH547qP1XFow+PRKQ/gIVYOLSNk8nqSEz1Oz0+kb5Cc+LsW?=
 =?us-ascii?Q?pSeV5gt7orYLBXu0b3JuO/E97JAmOt2A9+fSsNXEugwlMk7EPeDz/PwHG6Xh?=
 =?us-ascii?Q?0N+5SYtcWjFe0fxDf7yml74DYDA+dw0mRnLP4qvb1XcokgTGzt57ocOg6saX?=
 =?us-ascii?Q?R54qfjPZdDh/f9bc7jUrFaCLN+ow/kJji9c+l9TLeOPCAvk91sP4EvdRax4n?=
 =?us-ascii?Q?sprOz44gy8UN8LbmK4iMqWq9PkwhA9NWwmNJub13ul/GESh3Bw47GYOK0Hgu?=
 =?us-ascii?Q?r3SKEBHMYq0zu0dzq/w=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94758211-ffc1-482f-4431-08dda8d60907
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 10:52:19.1016 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: iMhSXn46NcXVv/+9Ar04hAb7TB2dQZOPMeQz5q4PGhRpQfEursRVQDwcUabL7zOf
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

