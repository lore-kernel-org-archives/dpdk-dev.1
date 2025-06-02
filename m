Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E208BC54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 10:41:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0D39940664;
	Mon,  2 Jun 2025 12:41:14 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013051.outbound.protection.outlook.com [52.101.72.51])
 by mails.dpdk.org (Postfix) with ESMTP id A02B34066F
 for <dev@dpdk.org>; Mon,  2 Jun 2025 12:41:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kFvLz8nDTdO9aK7oP6ILaDFRwwYy9BdOncxp2ZRn6RKNArUyuzisW8SjfCrrwyS2Lq0g9p8/LfI2YGHIPCH719QnuiOCRMmyqZSeuIiV2fFKHYLaYSA+XS0yUob9tjHuEKynO9+blN+DETPJcmnI50QLrqNKbUledveHiKAPpNd1B79loupSCL0arGq4Ce47Nx1J3XZj+9AMNSBZHX3QGkUvGn09crag/8Y+PtY6nRo+0/nMXZL7SmO6ASVg1Rf/li3Cl8GxH4SLO1WP542udnIr8KqCq54K//DisrBjM8YD3rjxouKy7QA7tZFJY0VIwNrkyfgzE1MOip0kNhqJUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uHKuTbxmFc1sUwGxAStyJYngmHcge4MYkx7/3D0foig=;
 b=WraoDf7aMYYEmfKRsxGj0+ECmN0LAZYlUdt7Y0pP4ww02r29Re2V/REnPYQufJuQS4CqT/k3tNa/gqQEj3P8gZeNCYJnpLuguBHBu1C7t+1U94nUlmk4wcuoq8+98j3IxfHgc2tjdJKNopFf+ytbCeBM5CJsOFIiZo0wjDU1rUjvHXcU/FahkVx0V4XyzLAP8um770LGICf7KfOa+N3t9GXYQ4zvM4cAoDnh43Lcgijg9apx6/uw9/xrkZ4+5XpN6mCCaLFlslZmFdPgn4Ie+cHO3LR62A2f9J8Mi9nTCt2t6KcPlI2vqkze8P010eTNc6JcZpkNwv2MN4euk4MZrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uHKuTbxmFc1sUwGxAStyJYngmHcge4MYkx7/3D0foig=;
 b=LmWFneLfJdccmM8iaLfTunLWEtJYoh2P/gZ1qltqPzNgnwygBQZ83fLLXtgHGspbS4q7FZhX+VqDa5/PYMjrVzHPR2XH0Ys0Os0GyRAxThCHrS2bFld1LcTRRK5xhBXaM+MUUUI9BoIcofW0jrtGZ5EU9WiomW+DaTnFMeNq3iaV71ZKo9OIwbHTkk1+nIW1mNBNlMhlZT9Oovm8jt5PfVgJtK3V2GTZ99ZIHAkLtEyShODC8JBD1be/Gp/AfieiYzmqcg3ZGHwGQyb20vygqxauqY6SHz3p9rK00MFHRcLn15BN8WZygL+p0o5DXBwtj0PpY/ku6fgJIYqEyLBqPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8194.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::7)
 by VI2PR04MB10956.eurprd04.prod.outlook.com (2603:10a6:800:276::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 2 Jun
 2025 10:41:10 +0000
Received: from AM9PR04MB8194.eurprd04.prod.outlook.com
 ([fe80::cd61:3920:b12f:6561]) by AM9PR04MB8194.eurprd04.prod.outlook.com
 ([fe80::cd61:3920:b12f:6561%4]) with mapi id 15.20.8769.029; Mon, 2 Jun 2025
 10:41:10 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Apeksha Gupta <apeksha.gupta@nxp.com>
Subject: [PATCH v2 05/11] net/dpaa2: add dpmac MC header file
Date: Mon,  2 Jun 2025 16:10:35 +0530
Message-Id: <20250602104041.3322164-6-g.singh@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: f47ee374-14c5-44de-dd65-08dda1c1fcd3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9uo9BCdSZt7ph8U1FKIVwKArkzCe6qqycvlBQwcDtdiQzvefp+RrBQ4AxY/o?=
 =?us-ascii?Q?3PG/e4crmuoNRJDeWYTv4JRD1+wvCn1NMK+VW2h79lY4+vqAG0CjSiQPWU11?=
 =?us-ascii?Q?Gz1p4pwOLJB0Ceg9FzF0sCQcZW8QRlZEHuQMTZvdLu5o31kPub4IkgWAYRD3?=
 =?us-ascii?Q?g63ofDPf4lZJIngbdRuidtbsSLiaFTGa/MpL65RXDs7SDBnyrxA5nb83MwPF?=
 =?us-ascii?Q?xasiLObJb0xXUzlkn1V0mdFIuOg50jkET065zcfbfOo5wUOqJ7Ef8cnMjcF0?=
 =?us-ascii?Q?wehIkOh0qVwihX4sZ+zcDjxmdFmNZaAWP/vPJsMBeOMZpbpVzQw5yzSWWJ+j?=
 =?us-ascii?Q?UDEYcsGdmGmsXrqFHzT4n/U//MSk/MUZWXjr3PW1uu+pV+/tDIupXBaF4BkK?=
 =?us-ascii?Q?DWdsK7g2Qj6iui/xUFMzEpk70NWAzBnCaAHL+ugdWYsQeoE70gtW4rxr4kmH?=
 =?us-ascii?Q?F4bV89Jhsy0WFNm9vq+myRTQ2fFhTX++Hj1frMObmHuGVH1PZw/Okc2Nhgvh?=
 =?us-ascii?Q?VnMqZdTVZUgsMmp3XB8F/G4WztZ3lKDq+BREpNPBR66EcuasBH3GvERKzDJr?=
 =?us-ascii?Q?GWsuS01+/Qgy0Rv1KbbNbnZjwuO982fsnPIP74/PXMGFnlp2dWaaXIHNA0+3?=
 =?us-ascii?Q?a7BTluG7YovvBBPMCv0f4cyONEfeK3+FOIOc2sG5HfWvjooMjS0VrwvNSpdZ?=
 =?us-ascii?Q?Sp/sFoc9htBpomfInpnJY2o/SXwPcKKBVydpNnyv0BUxnHSqZCBB7WLMtdkQ?=
 =?us-ascii?Q?0WXq0kkWeJfiUasHG4pLwKLN9oykYAixo/iF2uuETpkSKTSOpaCInxIHFSqD?=
 =?us-ascii?Q?vwXXRCdGOwBA8mAp3RKlYeG7l3QV9qqoTtsxKXL71M/q/dB8Hy3vrdHwIQi4?=
 =?us-ascii?Q?Ilk0fy1Zlw41SiCrCvicdrQf2iSFo889dxelgPDTiZUH8BEY2H3/j3AIhA4i?=
 =?us-ascii?Q?85zgXlISKmVN3ivluYPGwUTWTZmfuZvPsJqc8F4PK//qr3kmXu1BohOz7IMk?=
 =?us-ascii?Q?VF07aBDg5LEXIrpIQUx9ZDL5+4KSItCDspTvG3mpJ1eLhypHE8KsSXUaL+F2?=
 =?us-ascii?Q?RzvnqF1DRKw339LPAqXbxgjK+d98SPsKrWa/QUHAleXCST/dYcAFTh8d+xfY?=
 =?us-ascii?Q?CorbDVOj4uhLtYw4b2ZlJn3MhWFrlOK8yBO1C635HsvEhCytmbXy82lAIUEb?=
 =?us-ascii?Q?hLGoohw7giMNYQQemo4hkYGiGmCNxyBCK9q+pc6FbgzDLXpunq2sRgx3s/9l?=
 =?us-ascii?Q?5SVFMeD51LpE5YgVghq6CkoKSiQUpGR8Gb6603ipZq37NCeTM3KT+2bqbcCt?=
 =?us-ascii?Q?nUNqL/9NDwJ6Q2HWlabSt03EBpRuBG3s37QduTgzMGITiKy+UJCS1Ta6TW9F?=
 =?us-ascii?Q?vk3gntHLMfVKgZwxXV7v7FGPEbddfz7qFyeC8ups9X7+oYjYWQCbi/3qSSje?=
 =?us-ascii?Q?EtJFVfy60drMqO5Ti+fKx8bMsDmqjcY8LlOIo/o6lwp4HShduS03ojIEvr4B?=
 =?us-ascii?Q?4KwCOVlXII9USt4=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8194.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TJJyCiZQF6ghB4iSJ4+DGy86zwwtdPjOjSAuvFMSqIaTeiO3un+XxCeriITA?=
 =?us-ascii?Q?xB1+Zc1zL9eNxrftWNRfnmBVj3FrtlPvfsKRGVXU0URs13xV66z6AUZ/5B/1?=
 =?us-ascii?Q?9DLier7OugCaeJmOvdAhSUdrEoz1qfT40WEDX/0487VOxn/nfdW+moqxCqSQ?=
 =?us-ascii?Q?ZiF0AxAoSAGk15Bqgy3M11NE1zXEzYObrX5pC/YPfJOuHbzXzQPrK9rhIN1b?=
 =?us-ascii?Q?SN1KLR5y5qH8mi3MV+Inxaxz+5H1JYGDICWzP57yuE2RAoFZqq9lfv2pZeDx?=
 =?us-ascii?Q?o6vnDgddAyf7UgpKP5lZG5lFrTBfLadMMuqbZk129+CcNI/CkVpsc0Hl1PMp?=
 =?us-ascii?Q?fqn51xBPT2mz08b31VZORMrjZlOEygVLDnVuxulXrwH4jT8kNffvQpBTopZv?=
 =?us-ascii?Q?Gyc38jt174Z+Xg5r4Mizvmk+uV2suW8PjrX6QlJx8ZTdohwQSHSTQQgWJNgu?=
 =?us-ascii?Q?OmTE9uAGovxSxjRaEaKnZeheQ11v1hvaK8Ly+cQULTFAwvTK7seWoZmcqBzO?=
 =?us-ascii?Q?2Yg+MJ5gI4nZF1E3SuK3X8p0W/vAJRIxSIyFTqWlFo+nGK3i+NRQX6YYO0Rk?=
 =?us-ascii?Q?GZRV3nrgDH29bJlLteT1grJbs6GR5aSK108Q+oSDdAAb/bo70+jsEZbfBy0S?=
 =?us-ascii?Q?rhQ9FQ+4mQndJ2IBixbgHKh8IGBem9nXEqgEZ0xClOWES9Q81erH2vFXJnOL?=
 =?us-ascii?Q?rXgd/FXl0I9FhoVW6nkxIUQqVIfDrrsY8r7AbAFh6j+T+0hkA16WuPjhDtZ/?=
 =?us-ascii?Q?diw1EzZyRFeOxCbmn/RyBShb65kA7/mlwHO8KCeUZTcPvDl2HgChB5KjRIvx?=
 =?us-ascii?Q?Q8Hi0dpYdXNVDGtuvgEeiNVVNw9GvToZ3pAA9mMpHdf8AVMyRuN1cFM7X5+k?=
 =?us-ascii?Q?gMzKPCYcPZ5JApFJ6aLEo5C3Wgwa1D1mhu8bNypzLTagVJxYEK+0Gjgmq7Gr?=
 =?us-ascii?Q?maKb3ft2sPuABWAUXIbDwdPMYrAz8c5P84YIugT5s3t72s+kzAcsJUH4qpOq?=
 =?us-ascii?Q?x5eiiCvBP4aN0E73EZPfn/B5gz9yQdtN/tV9GGQEiMTgWiTxLajimTf37pXM?=
 =?us-ascii?Q?wP1r56Xb/svHLuY+iyDulOgGpgKpGb598jVy9zN6o1jlOudya8+KLTpvdUCP?=
 =?us-ascii?Q?M9m1aJ4ODUZqJh20jBWRkHJvInnzcNvFJ0J+E5iMzXxgecelioF5aZu6ZTGq?=
 =?us-ascii?Q?Ce1KSA4+kys5TsqPaZaPHoLJDWCbFlxOTN5AgkHihggTTmBxFisWkS1SkzK5?=
 =?us-ascii?Q?SsMe2fSzHYeMoZUynheiIe7Zt8oEUpjHb6zCthUn/LHYhbqe9yurKLcyfWjY?=
 =?us-ascii?Q?q8rGHjBy/PqlPBwVHaGx+ktKReZFw//RiBvk7vuW1xZx7EKvZH8txj7eZNXh?=
 =?us-ascii?Q?67k0QEi9YnXXY1rZ63oXbOc/RPNuZzGldET9cyXy0qTYecBP4P/7NR9OGl5F?=
 =?us-ascii?Q?+tHzuEeCMdXd10Fdh7aSJJi5uUWH/VS9K03Fee1h0N1sCjjI7C+PxtAUc+nc?=
 =?us-ascii?Q?s86mzz1v6lPWlYiiZpM/lSChiwGU+t8hwTySsgtevDc+ZDBESb/2xbq4rwvv?=
 =?us-ascii?Q?Qcfm6mYcYoqMSVMxk2U=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f47ee374-14c5-44de-dd65-08dda1c1fcd3
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8194.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 10:41:10.2263 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: A6rGl3ce9+SCJDtBbkWC2G9+MFrc0r+4sYcm5GJqQqILMtUtPGNUAjNjeS/Rdpwx
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

From: Apeksha Gupta <apeksha.gupta@nxp.com>

This patch upgrades the MC firmware release API compatibility
to 10.39.0. Added mc/fsl_dpmac.h file.

Signed-off-by: Apeksha Gupta <apeksha.gupta@nxp.com>
---
 drivers/net/dpaa2/mc/fsl_dpmac.h | 490 +++++++++++++++++++++++++++++++
 1 file changed, 490 insertions(+)
 create mode 100644 drivers/net/dpaa2/mc/fsl_dpmac.h

diff --git a/drivers/net/dpaa2/mc/fsl_dpmac.h b/drivers/net/dpaa2/mc/fsl_dpmac.h
new file mode 100644
index 0000000000..c4f16f6113
--- /dev/null
+++ b/drivers/net/dpaa2/mc/fsl_dpmac.h
@@ -0,0 +1,490 @@
+/* Copyright 2013-2016 Freescale Semiconductor Inc.
+ * Copyright 2018-2022, 2024 NXP
+ *
+ * Redistribution and use in source and binary forms, with or without
+ * modification, are permitted provided that the following conditions are met:
+ * * Redistributions of source code must retain the above copyright
+ * notice, this list of conditions and the following disclaimer.
+ * * Redistributions in binary form must reproduce the above copyright
+ * notice, this list of conditions and the following disclaimer in the
+ * documentation and/or other materials provided with the distribution.
+ * * Neither the name of the above-listed copyright holders nor the
+ * names of any contributors may be used to endorse or promote products
+ * derived from this software without specific prior written permission.
+ *
+ *
+ * ALTERNATIVELY, this software may be distributed under the terms of the
+ * GNU General Public License ("GPL") as published by the Free Software
+ * Foundation, either version 2 of that License or (at your option) any
+ * later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
+ * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
+ * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
+ * ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDERS OR CONTRIBUTORS BE
+ * LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
+ * CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
+ * SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
+ * INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
+ * CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
+ * ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
+ * POSSIBILITY OF SUCH DAMAGE.
+ */
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

