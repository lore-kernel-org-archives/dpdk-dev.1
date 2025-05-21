Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0471C54E71
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 06:57:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDC6D40F16;
	Wed, 21 May 2025 08:57:31 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05on2061.outbound.protection.outlook.com [40.107.21.61])
 by mails.dpdk.org (Postfix) with ESMTP id 3CB7C40EDF
 for <dev@dpdk.org>; Wed, 21 May 2025 08:57:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=azHoEcSJct7h1NDHYUCdgUkgJc7Ey6YpBRNe0APoRZkh7hZ8VsffZAr7HHl2OiO/924cWHIFJyJTZlxPpmhha4mqtSzjwkubR7TIXPccxMg//adcAdK/1qbIPsSiufATfjcHhetiQW8OYfEwAcYd0ivgCoRwzlou+DxWWSjzRGFOMyrW7L/Y2xO2iQPnytQVbw4WZXgrJmn8JoxVgTCUFHywWvAgup8/hrxu5edCGBG6RaNyQgVQwqC8Ff2hBf/gHPACef4zqU2lmIBBAxTKjD55i8adDsimTiS7sIn64uyeUVvpNfnLh9Qg6NQxWQ/LYIMTLpG54fbfSqUTgDIORg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fZ7rlVGD3huwm94UrOzspS9z9/bkITwFoF3us7zVdkI=;
 b=uJVP/oYsIL7bQGkpdf1R8nl5+GS7AZtFwF7Q35hL5DWkJtgRtxx4BC/2H/gqWXEOc6vD8Ri27VS8BGgih9AYJoQTniGFUo6SeI9bKzkBFbLCG6DeDJxnc6Cu9dSqFdZxXqrBNuHNAZfRNb+rOneSWBZKbf7ahGsFhlU04EM4YeiK4MEBFNrkVnI5mA1fQI2mdrMdvPeLRg/Zp7t+LTEqgyhFSfmaroMjwESc9XEMLRu7zwshMOS4p63CnNbyImkCn7vxNYSXQujE3+HOj5LB/4AWt86QrguzuFqEvbLkiT5P2X1cXGXI1c9X5vZS9xySB+3Ij3PWtqh4mu3A//LQDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZ7rlVGD3huwm94UrOzspS9z9/bkITwFoF3us7zVdkI=;
 b=VtDGbUQT9+0jq/vFEU5BEAWid+uKKHYXkX3R5t7Wc5+X5n8bKrDecRnUgFboO8Dt0tktgjGmE5XLP8YGxFa5jMzQYqIT7+xjj/E/CbsDNhRkXnxOaK0qYa1VyWb5vDHY2AelPYmJEYXlICleXJBITZoXV+pj05TS5wSnMOT14JyPUIVWOo64QQQusIcF/guyH0a6tTz1Ekml9JH08ImDV1YpkGX/5SdyvnMjJfTKD3Ou4o9s92agDvv6ZYBm08N9mpy3nXiemvNojL+Fk+fP0SKE/f51Dn693V6btVNuADbXgCrCHl2wpK4nh9Q5rHIfxpSN9l9bjTUZxI1KG/eOmw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM8PR04MB7940.eurprd04.prod.outlook.com (2603:10a6:20b:240::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Wed, 21 May
 2025 06:57:24 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%6]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 06:57:24 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, gakhil@marvell.com, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
Subject: [PATCH v2 4/9] crypto/dpaa2_sec: change custom device API to standard
Date: Wed, 21 May 2025 12:26:53 +0530
Message-Id: <20250521065658.857707-5-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250521065658.857707-1-g.singh@nxp.com>
References: <20250520055133.506071-1-g.singh@nxp.com>
 <20250521065658.857707-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0072.apcprd02.prod.outlook.com
 (2603:1096:4:54::36) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AM8PR04MB7940:EE_
X-MS-Office365-Filtering-Correlation-Id: 1f1a17d8-fa2a-46d4-32c9-08dd9834bd7c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|52116014|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3ZrKJPZyxaH+AM+vrBj81jL6PSm35CCxJk4yEuw/2kOpACCdIIxOWePG3591?=
 =?us-ascii?Q?mClwP21yqXqic7Bop2zEfGqni1+Dusr58igs4WJiCtPKc9Hn392bkHFCRxhE?=
 =?us-ascii?Q?AI5Wr9Xxwfxksq4ct2RfAegktlqlnRRGfZD6eiBhYckDeJXWaybk5X+Zqww8?=
 =?us-ascii?Q?f+Xsfpi8sfGQTmgPMVq3kd7xZ9UennzuNw/LnDJIhiFqJ+BK0tqnncggcmFm?=
 =?us-ascii?Q?XJElE9QID7dG6tZKvseththj9P6jum04JoWylj1D1vlCu89VisMWIdtaC7Jm?=
 =?us-ascii?Q?Fuj/3IQk+/oRxK9lp2zKqgkeuXwtAAF8+jUGYe3BUFweC4yO2bEF5vYTGBLM?=
 =?us-ascii?Q?he13Lc13EVfTuYuH1SLFEXWUxOzC8F3RIp3VlHyTKaGOlemPB9FwVXGpebK2?=
 =?us-ascii?Q?83DTThGOAw6pCOpwQ3SGZzK29FI6OiCYKbx8im3BD3iV+vzf9sUaZXTc02H/?=
 =?us-ascii?Q?SZ+pk6ch/J7t6eG8dvtBCs4ZOWOGFPcmq/z57yB6SFBeTjUHQoUNQhZ5eJQu?=
 =?us-ascii?Q?OpBAjuxUBTAEyQ8sZC1sLsmudhPnXdTTawFRs5uPNeyXwj6jMgFqZ+ZbyTZi?=
 =?us-ascii?Q?+IEaICQVIuWHcurqjDog7T5hQfKBp6VGSDRBfd3sRlIBqplRXwNSPNe96hlX?=
 =?us-ascii?Q?oJzfMIVmMo53Xdqx6khdXvnCpAeMS9EnLsEN/di7vg1zZfgSQGHBfwoUUp6/?=
 =?us-ascii?Q?ifbzLughPCTlaBSLtsfwl4vpN1tEMkG/cU2730856dNfTFurnvo5BiRK+Pm2?=
 =?us-ascii?Q?6177LlrY0tuI8nN/qBn5WRylKU0JkuwbGQYLmR0MAWfoUGGcox/FUzzjYWeU?=
 =?us-ascii?Q?tTqiIu8IIwhs593WfbjSUA3F/ELdtfvw1NpBZiT7enzWb7pjxMD8jBj2PFDs?=
 =?us-ascii?Q?8o3R4ON3nogyzHTIa5rwmF3WjkhbARj0JwqpqT2z86kkWrk8c+w5PhNiwArb?=
 =?us-ascii?Q?mBBZyQC/1p+fE+5ImSjnacl+X7n29bPLichbCCuOXugMiDpr/dFmfTVpIb7Y?=
 =?us-ascii?Q?7v8t5LxlygH0hRSITHmXWzHpO9QXgJQdgFiIh/IYVRce3IiTA3oJ3ViXBC80?=
 =?us-ascii?Q?P4/dtuMJJzlQnlnGd6Ib+cExp1pbC8Tc1QnUqtu3TN7Ij/WtFbCXuDBot9H+?=
 =?us-ascii?Q?RTDxCzx+VFt8PKDXnyF5yGK9nkolHPKgStza7a3r7d16UbRuXilYVDn3Vjdr?=
 =?us-ascii?Q?1KgL0GgjCmfVftO1kIZ4t0aFphB0+xn3BJybisXuuc3p8AV5Hrzcrl68RoA6?=
 =?us-ascii?Q?/V79bbIv8vt0IRH8Zxi54W6nmwZBWTLPJ6f1VW5MSDDgxtEHsBSysm4TPMBP?=
 =?us-ascii?Q?upJi05t24EvSHhvKmqO54ZR/eO+DABOBK6sSad6qtHfP4j287RMLAgctXWpQ?=
 =?us-ascii?Q?ad3kF3hnoNesdQnuhSyniTEDREgRfl7tv/KkxbqR+DTK7JVcZlaS/TSsHOzs?=
 =?us-ascii?Q?maq5O1h0qgRc4SbwgJknigQzmoPPqDgccnl6XL0CMmQkD9xME3lD3g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(52116014)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5EwI95efX9MlsQR8HoXVPudYbg3fW8iE0XGo9OPIu9qUoUyl9HHGoCa1QoVh?=
 =?us-ascii?Q?FkA/9PZrq1raIgoQXYzVPfkACHKOBsrYJQ4SSqhvvPeEVS3lqPfnEpEpmJba?=
 =?us-ascii?Q?YjMm7dju9luiFkEcw+BBETZt+IlGriMO/dURy6QOT4W/8CF9sFLsvF5Ttf9W?=
 =?us-ascii?Q?Q5kXoP11Rs1vB2Il8OYrcFRG146meYllCDyxzvq5yfg1fhU94YEU1kiiJN3i?=
 =?us-ascii?Q?gyYBVatNPGOCrMccnpLc2psU822HWur5JjAqceDsZmtuUvYgc4kHwCd52lgk?=
 =?us-ascii?Q?B0WHpsCuHnOYKWwpN78bJBowtZQKxSDRWeyfAsfIWlygrTp8Dfb0fWb3lgct?=
 =?us-ascii?Q?FGvUDsz809MwRW7qkPFmYV6EG6o89bddIMfNznWqliJ+2le9ueA3TGOrWz2P?=
 =?us-ascii?Q?DXrtocQ5df/irpIfSEKRYLRiyMC30tFQWQgC91z04F6tu4bhG51qurba8amF?=
 =?us-ascii?Q?Tfl2IPB+7CJShKPImDo4CWFFK3+j4tyK5ewD9tvvLGy/QE3FF+UilglRe0YV?=
 =?us-ascii?Q?cTxVI/DdINiTgvO62AxJs/uar6c2bmpNJmBUfGBQQU1h99iC5yJbpkoy/I4p?=
 =?us-ascii?Q?avSqm52fJYzGZREBGFvqOgX5QC38cA/EEtnwU65dqxRFU2bMxh6zZRw1d6ZQ?=
 =?us-ascii?Q?Z3sgdi7SUY7h+mVAtPrxODkmepTKB3nzm1YJIWRH/GR7WAQM9qGXntCEFWf9?=
 =?us-ascii?Q?y3rG3n2pqhS27QVvMA8C3j0ANyKD0alZ2wj9uKLvWWdStQ8fX0r0pOV/iUms?=
 =?us-ascii?Q?fC+NLBxApnePxXVESZbtFlczJMRfbcCxVgFM2u4/hhb4iC8k3evd4yYKUmqT?=
 =?us-ascii?Q?0OWuIL06BI8XNI+/I6VzRdKw/Bx+Ah+7cCdOOR7E+XRI1HcFaYmorDzOM/Ys?=
 =?us-ascii?Q?FZWx4XZRrYIhuXDLeFmpODAcg2+1kJMEa1qAk+tPoqVFItcEYgZpMdZI61Ih?=
 =?us-ascii?Q?WSQ3SkvpRODU1vwe6N2IqoaiHDYCgDeZ15kk3yji+nByuGM4KpGv17k55d2/?=
 =?us-ascii?Q?qPlNbem8GERKa7GE9y1Bd3zL4ixWJCIQJjQC0dVvvvKEJtjggLdEcX51n4pB?=
 =?us-ascii?Q?ykPpDkkYWm3xhMurW823YJaUgcNjrdjYXjcMVC9Gv3/rGFMR9ewNaNnTsUr3?=
 =?us-ascii?Q?ZmLjtN8gGps9lwgTA79xSjvN2orCzh47MUIqgg2aLhtU1j6sAEj2XpAaJBpN?=
 =?us-ascii?Q?GDJzlSnYt19EPRG45Vxiol4DnvChRfuMKIpZaWFKhuStQImqV4FbJLMv6ep3?=
 =?us-ascii?Q?wgjESq9qoj5Ua4htj0OR9EQA2qfikGvl+H+l6fSXGoedWq2Pwr5bVKM3N8+i?=
 =?us-ascii?Q?EoV34mpLn94iRRwRlQsA26hNfhXNHw3orkMMBJQvWF4SXGuK3DrXrbT537aT?=
 =?us-ascii?Q?LZcrpmhHBQs767Jbelg2xhUyrAbNd8cqLXkh3lRuNSrpCufagURX3iJncMTF?=
 =?us-ascii?Q?etXrdcgY5Z77mMc5+fIJZyxzrPo8tqIHMLJN9Ye2cZNAEO9qSzqjLz82Gz2G?=
 =?us-ascii?Q?O5mxdBrdvYs8HciBKn9z8PbGEfEDFIHUICIyy0mHrhc+tEHcOWW05ODEd1/L?=
 =?us-ascii?Q?E736FiEPaNyWHmENKhE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1f1a17d8-fa2a-46d4-32c9-08dd9834bd7c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 06:57:24.5069 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5qsjFazcBPTObACqOHfMpPZOZvqFlhH5zvIGQIwL0SUkgA5Cu/TNEwjWR+nGnNXp
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7940
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

Replacing existing device creation and deletion code in probe and
remove functions with rte_cryptodev_pmd_create() and
rte_cryptodev_pmd_destroy() APIs provided by the DPDK library,
simplifying drivers initialization and teardown.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c | 38 +++++++------------
 drivers/crypto/dpaa_sec/dpaa_sec.c          | 42 +++++++--------------
 2 files changed, 27 insertions(+), 53 deletions(-)

diff --git a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
index 0ccadecff4..925d2709d2 100644
--- a/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
+++ b/drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016-2023 NXP
+ *   Copyright 2016-2025 NXP
  *
  */
 
@@ -4413,33 +4413,27 @@ cryptodev_dpaa2_sec_probe(struct rte_dpaa2_driver *dpaa2_drv __rte_unused,
 {
 	struct rte_cryptodev *cryptodev;
 	char cryptodev_name[RTE_CRYPTODEV_NAME_MAX_LEN];
-
 	int retval;
+	struct rte_cryptodev_pmd_init_params init_params = {
+		.name = "",
+		.private_data_size = sizeof(struct dpaa2_sec_dev_private),
+		.socket_id = rte_socket_id(),
+		.max_nb_queue_pairs =
+			RTE_CRYPTODEV_PMD_DEFAULT_MAX_NB_QUEUE_PAIRS,
+			/* setting default, will be updated in init. */
+	};
 
 	snprintf(cryptodev_name, sizeof(cryptodev_name), "dpsec-%d",
 			dpaa2_dev->object_id);
 
-	cryptodev = rte_cryptodev_pmd_allocate(cryptodev_name, rte_socket_id());
-	if (cryptodev == NULL)
+	cryptodev = rte_cryptodev_pmd_create(cryptodev_name, &dpaa2_dev->device,
+			&init_params);
+	if (cryptodev == NULL) {
+		DPAA2_SEC_ERR("failed to create cryptodev vdev");
 		return -ENOMEM;
-
-	if (rte_eal_process_type() == RTE_PROC_PRIMARY) {
-		cryptodev->data->dev_private = rte_zmalloc_socket(
-					"cryptodev private structure",
-					sizeof(struct dpaa2_sec_dev_private),
-					RTE_CACHE_LINE_SIZE,
-					rte_socket_id());
-
-		if (cryptodev->data->dev_private == NULL)
-			rte_panic("Cannot allocate memzone for private "
-				  "device data");
 	}
 
 	dpaa2_dev->cryptodev = cryptodev;
-	cryptodev->device = &dpaa2_dev->device;
-
-	/* init user callbacks */
-	TAILQ_INIT(&(cryptodev->link_intr_cbs));
 
 	if (dpaa2_svr_family == SVR_LX2160A)
 		rta_set_sec_era(RTA_SEC_ERA_10);
@@ -4454,11 +4448,7 @@ cryptodev_dpaa2_sec_probe(struct rte_dpaa2_driver *dpaa2_drv __rte_unused,
 		rte_cryptodev_pmd_probing_finish(cryptodev);
 		return 0;
 	}
-
-	if (rte_eal_process_type() == RTE_PROC_PRIMARY)
-		rte_free(cryptodev->data->dev_private);
-
-	cryptodev->attached = RTE_CRYPTODEV_DETACHED;
+	rte_cryptodev_pmd_destroy(cryptodev);
 
 	return -ENXIO;
 }
diff --git a/drivers/crypto/dpaa_sec/dpaa_sec.c b/drivers/crypto/dpaa_sec/dpaa_sec.c
index bcea4ff3ab..58d691d8a6 100644
--- a/drivers/crypto/dpaa_sec/dpaa_sec.c
+++ b/drivers/crypto/dpaa_sec/dpaa_sec.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2017-2024 NXP
+ *   Copyright 2017-2025 NXP
  *
  */
 
@@ -3614,16 +3614,10 @@ static const struct rte_security_ops dpaa_sec_security_ops = {
 static int
 dpaa_sec_uninit(struct rte_cryptodev *dev)
 {
-	struct dpaa_sec_dev_private *internals;
-
 	if (dev == NULL)
 		return -ENODEV;
 
-	internals = dev->data->dev_private;
 	rte_free(dev->security_ctx);
-
-	rte_free(internals);
-
 	DPAA_SEC_INFO("Closing DPAA_SEC device %s on numa socket %u",
 		      dev->data->name, rte_socket_id());
 
@@ -3780,33 +3774,26 @@ cryptodev_dpaa_sec_probe(struct rte_dpaa_driver *dpaa_drv __rte_unused,
 {
 	struct rte_cryptodev *cryptodev;
 	char cryptodev_name[RTE_CRYPTODEV_NAME_MAX_LEN];
-
 	int retval;
+	struct rte_cryptodev_pmd_init_params init_params = {
+		.name = "",
+		.private_data_size = sizeof(struct dpaa_sec_dev_private),
+		.socket_id = rte_socket_id(),
+		.max_nb_queue_pairs =
+			RTE_DPAA_MAX_NB_SEC_QPS,
+	};
 
 	if (rte_eal_process_type() != RTE_PROC_PRIMARY)
 		return 0;
 
 	snprintf(cryptodev_name, sizeof(cryptodev_name), "%s", dpaa_dev->name);
 
-	cryptodev = rte_cryptodev_pmd_allocate(cryptodev_name, rte_socket_id());
-	if (cryptodev == NULL)
+	cryptodev = rte_cryptodev_pmd_create(cryptodev_name, &dpaa_dev->device, &init_params);
+	if (cryptodev == NULL) {
+		DPAA_SEC_ERR("failed to create cryptodev vdev");
 		return -ENOMEM;
-
-	cryptodev->data->dev_private = rte_zmalloc_socket(
-				"cryptodev private structure",
-				sizeof(struct dpaa_sec_dev_private),
-				RTE_CACHE_LINE_SIZE,
-				rte_socket_id());
-
-	if (cryptodev->data->dev_private == NULL)
-		rte_panic("Cannot allocate memzone for private "
-				"device data");
-
+	}
 	dpaa_dev->crypto_dev = cryptodev;
-	cryptodev->device = &dpaa_dev->device;
-
-	/* init user callbacks */
-	TAILQ_INIT(&(cryptodev->link_intr_cbs));
 
 	/* if sec device version is not configured */
 	if (!rta_get_sec_era()) {
@@ -3841,10 +3828,7 @@ cryptodev_dpaa_sec_probe(struct rte_dpaa_driver *dpaa_drv __rte_unused,
 
 	retval = -ENXIO;
 out:
-	/* In case of error, cleanup is done */
-	rte_free(cryptodev->data->dev_private);
-
-	rte_cryptodev_pmd_release_device(cryptodev);
+	rte_cryptodev_pmd_destroy(cryptodev);
 
 	return retval;
 }
-- 
2.25.1

