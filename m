Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC06C54F30
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 07:14:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A8DBA4027C;
	Fri, 30 May 2025 09:14:10 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011012.outbound.protection.outlook.com [52.101.65.12])
 by mails.dpdk.org (Postfix) with ESMTP id 8CFF94014F;
 Fri, 30 May 2025 09:14:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ENwo6yJeAGkfU2ns1dvOwV6szbBh8pl6izrgrIokjk6AG0/oumU7/e/CSaevIZ0C1hkU6Ix4RhKWXmEaF5jH2pbtZOrliPlslwedbpKbcpjIV6f7gotbhXDlQWguKlIK/z5VTY+X5haCmi5VhMuByG9IFOZjo8QKeI95hRQPPmc46SUiVDG+At83+5QHwTA1peTipZt2MRkj4XUg9e7+kbl0D49xj/iZDKbnJfkwxVsaNvUjfQdADaG2M4iSjQ7tRkWjy72JHh9Xhr0gurcavFQhIHcA0QyeGiyBIEvxVbKL5t57AESiGvBkIwyA7DBUgdTXE7KtFeQivy3tOAaWgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRJfhCnhPtAy/78KTQslBD/e+dE4if5EjNdc2JcvvMs=;
 b=QuGXNx2lt8DcWfKgMNj3XBa4wrvm2aveT0CFXadLh4YDV96o3DRJTsHhwhZz3dyqE9/yayGr4lUbies/76HB+K1AXcbOU60tqkUHv8g6bdsGwzXBfVkeYCPWiBWhwicRPXohffgV+f+9P8EZbq6i49dpaqT/DSHu0v0md6OU9OfjxEcrVqL2jt+o9S2giCXQKU5N9NA9WnvhGJjkl+9GdIPNuHglXx7cMruiCsxnEHiB6BkXM8WbDMie11ekXDfldULPxfiLg1Gtb1CAlgvX+w0sIyMvkthmnK/W2jmUSsvlJustdE9rBLV/gJrRygzBZnr54x5idZs0xmIEhZpHRA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRJfhCnhPtAy/78KTQslBD/e+dE4if5EjNdc2JcvvMs=;
 b=mTIGo7egUdK9n+X5XGuxipoSW+OWFG1EpAcz8Xuw+wO9/tX7SNEoLZAM0VUWLJa/re9lC8VrcPTaFd5m11djLFIVu5cJ5lOs07sJjG6hlZIQN61G15noYEf86hkaJ+njxA2RX4Upoi6vudQQGrXedSMmf/DCjm3R8mHIhteL5BntaiOG2VRnpd5nk+BIycbS1AdtwGdhDcV1CLV3GlsaMM7nHmCjMG99BINy7j7oQVLx7+6KAQnbIZ3Dq40mEkSIGRKU4PqspPsAcbtVkYNqpHCEFYf2aBQoCYO+DsfjERhf0u3ZMwTlhLy89YYl5mV1FekgwItfQdhvvX+LeGUzVw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8205.eurprd04.prod.outlook.com (2603:10a6:102:1c2::20)
 by GV1PR04MB10378.eurprd04.prod.outlook.com (2603:10a6:150:1d4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 30 May
 2025 07:14:07 +0000
Received: from PAXPR04MB8205.eurprd04.prod.outlook.com
 ([fe80::7633:884d:5973:174f]) by PAXPR04MB8205.eurprd04.prod.outlook.com
 ([fe80::7633:884d:5973:174f%4]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 07:14:07 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Cc: stable@dpdk.org
Subject: [PATCH 01/11] net/dpaa2: fix issue of extract buffer preparation
Date: Fri, 30 May 2025 12:43:34 +0530
Message-Id: <20250530071344.2939434-2-g.singh@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 98924519-e089-413c-e2b3-08dd9f4990b3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bWZf8zpoxZlUYDJMVb71nAF63Br8m1mvh337ld0onbS8Li+bju9LbiuNWGTd?=
 =?us-ascii?Q?Aj170iiJ5M2/qWbqptVAWZgnYZ1ClKevYsHDqf0fsPvRwX2F7Rpvwt0Ai5TP?=
 =?us-ascii?Q?hnxl8YYriNYT5opTUm7cbBqej2j0AwCixsUMW5uiLG1GReD9E/I23HMVk4E5?=
 =?us-ascii?Q?X6qp2TT8dkROXsGfTiuMc5nMll3+Q6rcFNLj2+jYG3nejhx19ufB28glDP+9?=
 =?us-ascii?Q?nkQByjSL/v5oMSo2Zl11v3wNn302mCLkinqSV7/muyhnW2tL1Yca7OW3JNX0?=
 =?us-ascii?Q?FGm/yvk62HJV01Rxk8DB3dkTYE1EMR6dNDAuomMANIZ/SKfg62GDM95vWWHA?=
 =?us-ascii?Q?/Ta3b++HgYxQF8Db07dsvXGKK4GzSG9/b58IyAYAQuaTjyRcTWBR3tJx3pV8?=
 =?us-ascii?Q?jLQJCtJGN6u43zQ+ZRKOAtRrDaINSi2Z2jRObgAbjCfFAWtXm2HWK5zty26/?=
 =?us-ascii?Q?xFWmIT7lfAOsKVncWZ20auGC89e92qneb4dDR3I9BE2t37ymutJ838nBS89e?=
 =?us-ascii?Q?u0t6E40+SFA1EECcEx2l2UheBkoGQucCv1qAO/VqA2CzTizySsMjzEC4P2fH?=
 =?us-ascii?Q?3kZ3CVwkVU/bLEq0M9EutZW9YZzEfycunzvz0i2rQ7LeFCqTk+dUrX1WtbSf?=
 =?us-ascii?Q?tyriOO86pPdX/UL2iYeB4oRb9pMERjKCsfqiHAW3lh6hFQQUZUmFymlbpfl/?=
 =?us-ascii?Q?qCPO1TIcAHg5lxXRGvevDJOlEJ/vQJ1oiQqb24TLteRVy2k7EbILlyyabbTc?=
 =?us-ascii?Q?5+kTg2Hd92HJHDD2At8LVjmpWoAa9J5IeRLOMn2mQgVVo8a3Vq68drktePQK?=
 =?us-ascii?Q?tocxFgZb2Sc6ZQJRcd/UzhEz+NNue6NIqldsqTnv1qqZvBPmV4YNzw3x6ihM?=
 =?us-ascii?Q?shKKztPHz90r12zm+32gKqPKjHCM/LB4rbouAthh+aSKct4DyDMgCCvUjKKG?=
 =?us-ascii?Q?wraFEvtGJHPjUTNcmKTVwgncOzUCAqlRBmKKlOtFDpNvm7aksZTohXfAc0G+?=
 =?us-ascii?Q?aLjs2ro3DbTMnVcPR+8Nl8SZnGwFkl5FmIXtsOVT9rzT9eJiQbxZfTy70mav?=
 =?us-ascii?Q?B2tLRVP9OiKuDpbNMpbj/fNY0U5h6bZTufJZomAKGoqXlRvFdZr8vRVBSLG0?=
 =?us-ascii?Q?YJ6SRCf+c4WzNFg7h438muM5KCFI+twGxDiz9tVIsLtWb/Y97WTiXzAzstyO?=
 =?us-ascii?Q?U5SyPAfNjp7z1Yb1JsAZHw5na5uL3BFwDwEaGa9me/2fQEr5UM73zKcVisOc?=
 =?us-ascii?Q?scN/hvpBDrOF++tZpsjHp1EJ54rNFYwFI1hPkRgBqBRR5SoGkaIeUgcRJe1r?=
 =?us-ascii?Q?JNr6vVpkhkr/ec/wKPoXjJam3xf2weQD83cdwYyqhWyvjL+Ib+kjJSD/l1uM?=
 =?us-ascii?Q?N0vtW6cPzbDOCtrbbSrcxbKTiJSFy6lYtanv/1W/FXcLrq5rD10/9HIpYer0?=
 =?us-ascii?Q?nP42WxO83p5RBJjUtWQ2URWflf3EszV/Bg7jz6kWwrUtEaPs03gOxuklqCgW?=
 =?us-ascii?Q?GbNUMN2NLDpCVWE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8205.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?fi6mT99KAugxdy7F+oiv0jrvIYkxiLk9BVK+TIWK2pbpsLSYtzKK+fWI9Mp3?=
 =?us-ascii?Q?Linyxa4QIssE/R7KXwOl2sexINWNok2zgZdr1XJFYgfDtiLABtISqZYFdlP3?=
 =?us-ascii?Q?hNQGre9jX9znW5hzTfVNkMEWe/1OqoRtoL/EWI0VURq2iryEhcztzul67AAg?=
 =?us-ascii?Q?BqTHvww2MCrHuReHNEMlCOh90CotYKLjCCrMi3T34DT4kKKArC3kTjO3J2q/?=
 =?us-ascii?Q?SzXWUC3VYMxr+Gi0wP+qYhuL6kNiHMxJ2cXtepSgg4OAFYdgqNRgKr77zL2A?=
 =?us-ascii?Q?XMrc7rQT2Ao52wZkhNcqrUxsFJt4k0u7U8HSqz0O42tPyXfHoI6CNLxIPKCx?=
 =?us-ascii?Q?6cXWovhCpwwlOAiLNGQFFAzVLWSJZNB00tctPbspTlnLEFfsZPWm3jPOSZeK?=
 =?us-ascii?Q?94JQZzx/Wbp5js84HIibgFy7NgCQ2d5zm96XN7rNV/7aS9CgUIALtzamXKQK?=
 =?us-ascii?Q?l+QAd++Q1f36LviYQ3F1prW3Y6rgWI5JKgo7piMGiyjbd2YUuaXFY3UARum7?=
 =?us-ascii?Q?lHARWsXZjCRWgx3GKmRS1j0WH+pnqZGK7GCTc43dg2OWR2htUD6QU3MHIoKF?=
 =?us-ascii?Q?mmex5k1mhFJV+oT+2AHvA/OAjIWT7sQfPB0Lx4ejTrh8aRVQ3O0sRBdAuV+b?=
 =?us-ascii?Q?ct1YknOmPnk/6xCGQ9freJAYn9J1NWZaqrQRCedP5ulqoXm1ng7rGsQjAYEt?=
 =?us-ascii?Q?5WpSsUZ5KfE5n32BvqLohimXOA4PRnh4DM/4YLjhWQcqrMy9T3Ae27mxbi+B?=
 =?us-ascii?Q?utp19rCLSnLz0u0ZCuEQufhF2sSKOBdhuj24nuliPtLEfYyHMKSaUcCsYofK?=
 =?us-ascii?Q?6zuoRx14wUI5GdRp8jZdtyt+VM1pND0j8sTj7sr8rGiEz0XVOrgwBow1X71D?=
 =?us-ascii?Q?xpBOhzIak1jsumlqsyOTn88Kj2BMQXoXZuxjsbJLLbiTOPEEr4tYQ5pP975o?=
 =?us-ascii?Q?PqyaQo7mVGvcPXiXL+7A+TT8hO/Of31tQzY2HOfbu9HzFL+3IRpCWVizXnUo?=
 =?us-ascii?Q?aHpa+gtd9nbey8Wp5M/0Ik5vIul+s3Iu30wEYuAxBMd4mkC2luU9x4o9ETGz?=
 =?us-ascii?Q?vowGOXdFbXdVNR6CESMV4JnPBNKoZrtWY2RCIKWAMGBA0QMMyquNJ990uSJQ?=
 =?us-ascii?Q?pVDX8btjAMBfXDS8M1pYMcJcID/Alt0ZRvjpHZjNp1AaaDK/DHIfdyac8y1O?=
 =?us-ascii?Q?okOABGSWnok60s2ml5FT+t1BGE4d2MX82kEP1+gzmSOl4Z7/kQs+UOC3ITWP?=
 =?us-ascii?Q?yZo+mCaUR7k7feW/UwYXJQQgEzGlZhdZhECvz5DDEg/i+dBP3n32afxkrBKd?=
 =?us-ascii?Q?kwhAgv7Pd4d3YoZgwJbSI3Pi33IFnAsUkpN2HqesorXss/9WlODCEO0z37BD?=
 =?us-ascii?Q?xCIoxKFqgFo1Uxl5YtpmkVZQTTkn7cUYcIhf/IjKT8k9F84IYpAMA78gC0TW?=
 =?us-ascii?Q?zAipMJPUu0PS7BTTIX60d6h2ZSVWs7PoHqMiuE04ogIBAdBFO90vOKyqzGox?=
 =?us-ascii?Q?ztcpPTFoutkuJXuX0PyLhEI0v40/PWWLN70IqgamksJy5eB+wlGfAdcadpzH?=
 =?us-ascii?Q?v0ZkkK3b2Opd8p/JnSY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 98924519-e089-413c-e2b3-08dd9f4990b3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8205.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 07:14:07.5008 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rxA1FvuVcdGj9iDzOh9HxwW5VbegXIuCsylbsTGPSSw+jiTWysJLuDTlOZYPwSKH
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

From: Jun Yang <jun.yang@nxp.com>

1) The max size of extract buffer should be size of
   "struct dpni_ext_set_rx_tc_dist"(488), which is greater than 256.
2) dpkg_prepare_key_cfg is responsible to clear
   extract buffer before preparing.

Fixes: 25d0ae624245 ("net/dpaa2: check IOVA before sending MC command")
Cc: stable@dpdk.org

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 4 ++--
 drivers/net/dpaa2/dpaa2_ethdev.h | 6 ++++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index c53c2d0549..c154a574ce 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -2788,7 +2788,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	/* Init fields w.r.t. classification */
 	memset(&priv->extract.qos_key_extract, 0,
 		sizeof(struct dpaa2_key_extract));
-	priv->extract.qos_extract_param = rte_malloc(NULL,
+	priv->extract.qos_extract_param = rte_zmalloc(NULL,
 		DPAA2_EXTRACT_PARAM_MAX_SIZE,
 		RTE_CACHE_LINE_SIZE);
 	if (!priv->extract.qos_extract_param) {
@@ -2799,7 +2799,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	for (i = 0; i < MAX_TCS; i++) {
 		memset(&priv->extract.tc_key_extract[i], 0,
 			sizeof(struct dpaa2_key_extract));
-		priv->extract.tc_extract_param[i] = rte_malloc(NULL,
+		priv->extract.tc_extract_param[i] = rte_zmalloc(NULL,
 			DPAA2_EXTRACT_PARAM_MAX_SIZE,
 			RTE_CACHE_LINE_SIZE);
 		if (!priv->extract.tc_extract_param[i]) {
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index fd3119247a..f32c31c763 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -31,7 +31,9 @@
 #define MAX_DPNI		8
 #define DPAA2_MAX_CHANNELS	16
 
-#define DPAA2_EXTRACT_PARAM_MAX_SIZE 256
+#define DPAA2_EXTRACT_PARAM_MAX_SIZE \
+	RTE_ALIGN(sizeof(struct dpni_ext_set_rx_tc_dist), 256)
+
 #define DPAA2_EXTRACT_ALLOC_KEY_MAX_SIZE 256
 
 #define DPAA2_RX_DEFAULT_NBDESC 512
@@ -60,7 +62,7 @@
 #define CONG_RX_OAL	128
 
 /* Size of the input SMMU mapped memory required by MC */
-#define DIST_PARAM_IOVA_SIZE 256
+#define DIST_PARAM_IOVA_SIZE DPAA2_EXTRACT_PARAM_MAX_SIZE
 
 /* Enable TX Congestion control support
  * default is disable
-- 
2.25.1

