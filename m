Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02FB3C7EE30
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 04:29:40 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 80264402B2;
	Tue,  1 Jul 2025 06:29:35 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011032.outbound.protection.outlook.com [52.101.70.32])
 by mails.dpdk.org (Postfix) with ESMTP id 128614028C;
 Tue,  1 Jul 2025 06:29:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X8FVPlDP51fZJYlZlo5YbtmHAjhwqTYWo/Pq5oL149ZEgahS5dnDRMu9StTFORtRBWqCz93cmfStJsndTf7IhhJhzs839bhcsf/ep45EioPat7B9yMadKFhlXMPbUlo44ovKc+i05fJKqkGfk5QE54irAtjKCHlQf8gfEdY8Dn5cdOLdXLlgOwFGzs0ODOcGGR0j9LCXdXgcxuQHvEG7ijeVzsvSQcaF/2bTQDBg9eHPfEtBw5wqbNR5uovGujd5UweaBSU3UibKVqcH/SxWSUSVOsA+euzLswG/BHSuL5oAt6RKt4rhXL6T9F+fZt8bTjnuhnTw9JcZsBEWRhpb9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtQUNJ8PfhYMvOCwDdPT3bDS0CU1K8XnCL1rRAk01QU=;
 b=ZVKYuBx7ZQMdG78iPVWjy3TFHePggH82Q/UYnDz+TrL6Ste8x7E2DlAxLCuETQZRRSiBIwx3YbTH41bHhiiQKJHEN2BUWPTqoe7uUooecDLlgSd8lkoQOtH6U9ggPpfIFf89W6RRO7ZKOrIiNxSWnbIaxfd/4qi+cpLOD9beaSHVgcTEXmFFIvnwpluQj7qb4i6Xiv6F26XsoJp+/vzj+Lvgre4bGhNvYIS7NAnVr67F3EsdRfVDbUm8nSodl+hc5i3rrGN4QHxufe7N6sMg1MRU2zCr7FZIzm/Gr6nQTkghQ8rrpRd1ZcnoROo7JXvV1PkJNsMhlwXtSAdKkzI5Pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtQUNJ8PfhYMvOCwDdPT3bDS0CU1K8XnCL1rRAk01QU=;
 b=jgDLT54AEQ+SJ2u40ngthsCh+ugs0YB9KwIWVizhu8JCNyJIP7N4saLZfJdWzJ7ipcjcK940Lq9AA542zmZ/sAg7dXB/Bay/DY88fcY4VpMhWd4HSLhXcFMV46/CIQahSjjAvPXVBrfFMlm85ABrL3sjsdhuzaMe/7/J4yt+WUZI759qVHTdR5jD/DEYXIeVbcJXKfIhQzLUNMiHqgEPkFUnadps6bIDI6EFSrl694vmno+e5hCxwZ/aZC9BqYecXIl/5ze9ES37bJ3t6l5momqHjXZekvkQB60jvDW35qWkY+5CGzrYdiD7pHdSAPcdCCGWJsxWYE/SOcnBlxOnpw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by PA4PR04MB7647.eurprd04.prod.outlook.com (2603:10a6:102:ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Tue, 1 Jul
 2025 04:29:32 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8880.029; Tue, 1 Jul 2025
 04:29:32 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Cc: stable@dpdk.org
Subject: [PATCH v7 1/6] net/dpaa2: fix issue of extract buffer preparation
Date: Tue,  1 Jul 2025 09:59:12 +0530
Message-Id: <20250701042917.3000355-2-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250701042917.3000355-1-g.singh@nxp.com>
References: <20250630095800.2943863-1-g.singh@nxp.com>
 <20250701042917.3000355-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::8) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|PA4PR04MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d6e2a3a-50fc-43fb-35a8-08ddb857e022
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CkX67IHtItNm3jKF0Xx9/z+uW8ed7KlU6/1sNhNn3gQKubdS8qLNCYU3VZvh?=
 =?us-ascii?Q?8Cg4QAyul1KDIhHDXwpSdACCjt5gkHctjM6KxdHak/7GPkhE0WuOEC2rPP4W?=
 =?us-ascii?Q?v5MApnAwOJIICjCzZX0Ln8xTU9LrFlHF9zW22gpkOsHw9sBtsf2XWSryZ36+?=
 =?us-ascii?Q?xeQy0cO/xx82ac7+zulMGNHErDzIYgbstQS9ny2QnzsbJcvXJYynhEViaNK/?=
 =?us-ascii?Q?/53GKCdU+pGmMHssRixdFIyR6RXT3iuVun6rUO0Wp6XXwUWMypJwkaGU9td9?=
 =?us-ascii?Q?QAD4x1Llk0xgRLiwpIoauYn1LXrXg6IZpePBkMqOcsJm09AKD9MES7Al6TQe?=
 =?us-ascii?Q?Ik6TP4AKAFpvAGjB/uzqpsXcvxKQlf95/xKSp70C6iaZspDbxN7sYdFIdE4D?=
 =?us-ascii?Q?2TLBXKozQM2z8in+jWtHICjh7u1Wlo1gvys9o4o0gqCSq96Z+Vc44bliP1eF?=
 =?us-ascii?Q?mGOSBl6OC4vkhKZ1wF76TF4SzaTXZb1du1vdHFDZFSlQRyGbczCBIWk9aiCu?=
 =?us-ascii?Q?JS8EmgFNG7Xk3tRwddsh3vZCwaq/Zqpay52L+iiZnfmTpO1ddNDe7b6+sGoD?=
 =?us-ascii?Q?adM3+3YdU4ci4Sv8vGmF2KdbPT13SX0L4V6igmSUzxkARko6PryUs+dt0KUu?=
 =?us-ascii?Q?v2IDC7fX5Z3aFauFVMI8x8IGS/SuLVkgtqEzsjcg5BkHk/Ik6SZCAxMGf0Ml?=
 =?us-ascii?Q?FZNCU4m+Cc8XjLmbYxbAKQ1futI+IWmWOyxGAx9Cn2vRHBJ54yo7kEkDeACE?=
 =?us-ascii?Q?tzjXG9EKKu8SMKn0SUauTzhhB572CkuIHAj8CgoBCOe4HOk59MzoI6vGl9PC?=
 =?us-ascii?Q?+4K/lzQowgOaKYqZ74QgNJoTcZnOFG4yeV3qEnLJmJ2yywo7N5Gdp1xheb6N?=
 =?us-ascii?Q?9OfcckaGSz6U4VmeDiJ/bTDDV+zjvl2MZAvnlqmlf/yffhSspKB3ugnUPo25?=
 =?us-ascii?Q?T9cyD20zZhWMDZb4LjVC8Td1iXK5Mp76YfF1nlBHtHIL3gPknbQWmyH7YCzL?=
 =?us-ascii?Q?YgH9YamVAOFmCMV/WlrJqkmljdAPTL5mrSfMYc7J1peIBdQGVcEpDHFdRxoF?=
 =?us-ascii?Q?VlDvR+bmvATqkkR3R4T1ygEvVDKkMzw5w3hJmrbbaaiwKKufPTMSxAcMiLEy?=
 =?us-ascii?Q?9hRIUTuLRobbLSuvRZifa2ume/XuSTddORVMoV+WpKTj4358kXt8OEL0oZeF?=
 =?us-ascii?Q?q9nbwiHnqqNIpBA6eUwjgDfNJbToa3spNIDZAUwF1APl0nZf5vNkK2ZUBrKd?=
 =?us-ascii?Q?TIYFO+25PfqgfH636yvIu/hGOp5UCA9ZrJJE1/xQt5sPISPF/SGSvA7JRmoI?=
 =?us-ascii?Q?FGSnnETYusEuf4Xql2UVc9IFDseiNb/c/2r2arQBLgQ/0Xycky3m7sVEPJVf?=
 =?us-ascii?Q?cTvrK09qfsV0v75EPnHuqf2nogiAIDh65A0qK5HnHu/6bdoqo0pWl4/uvJ0k?=
 =?us-ascii?Q?YBqIy0Mp/LD2cYqV7Ru1QhLTialklmxUOIiirNI5LMRGM0Yp+aqwc+lvL7U7?=
 =?us-ascii?Q?YTu7rLlWa50QKvo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ADARVQ02MrQvveWfHzm37VZwB4MVTGCtcSru4wUauCQnSkbUAyme5zXru/bD?=
 =?us-ascii?Q?SaiylJadwyMKudxPihnz0jdG+mAF/79m0e/qHTaT2jhItuKLrtFkJ8MPY41c?=
 =?us-ascii?Q?FhmnyXinjShF1I2UeWkW6O/MTjyx9ZlVjPFubrvbpaF8hlzIlKmINrwiniPf?=
 =?us-ascii?Q?FI6y0IdZqYCR7rBNtPhHJPSepSA001oMcxguzxwFoqty35w68JXeo9LeHO8B?=
 =?us-ascii?Q?qzWX+4pOzGyAG8jT426Fcp5301FoT0QNpO7XmTUW2IAnVsOYqDliD62c50fT?=
 =?us-ascii?Q?vQ5j79uVJzIKAIPQCdPcW2KRHK3NPHImjaIk8/vvXp/Uh2TWt6mcPagjEdLy?=
 =?us-ascii?Q?JbOQtmCCUZizV4rIi9WPCt5HFp+2bpBBE7drZo+tleom8Te8o5EF1+SmdJCL?=
 =?us-ascii?Q?2tD6y0ryQifBLXcaQQ30uTYrdTA/ZCdjvHmEaYuzpr6r8XM9Rxk0N9yvXIWt?=
 =?us-ascii?Q?AXJP4/Tv7rRvw4RpmWLs+p72LMGNScrgIIQWi02BRrY/AkaZBmzg0C2b1aPD?=
 =?us-ascii?Q?0apR+CsbV5Zr03UBgTgETI43VT76C5XJc4TzCvHwN/PII4YJQTJo6NEIzLPb?=
 =?us-ascii?Q?2uAUGO2Smd0Z14FabP/DpufCE/Gu+BW3SPYM+3k4hWWSy573rV6Z21AUMV+Q?=
 =?us-ascii?Q?TzH67+JdICXKBPdNJ2zRZw00N1NOSSpEWxLBANiBp76sXLQ60lDSWroVvNYo?=
 =?us-ascii?Q?kSpB0Wqp+bytPIbA01neK4aDQO2ZUirdauiYvmP1fgUzUkLakPr5es8S99zN?=
 =?us-ascii?Q?ZKorKn8hARn21/pqkMXTBSLFLxtl3tqjqPLP0Ihn21+qLQzStQm4Uj+HAyYz?=
 =?us-ascii?Q?Ttmd0UTRiQ70ze5Bzzg/b+2XQwg0hOsHSVHPdyJc9Hrq/jyeT0c1PJXhRQmM?=
 =?us-ascii?Q?FDTWuaotfDt14HX5d0RO5/QvHdRbk7MdYixYIzbWa5kBXD8RK6wA/JfACL+y?=
 =?us-ascii?Q?FqkXK8UOhO+mbb/Vxxl3XeBttWuAYGG801azPdDSoKSe09dDVF9j4z/WYhrg?=
 =?us-ascii?Q?ZKCrrgJvXqt9vZ4F+Z3IHxafvtu0Xb6ahkaPRnCAYh80GWhMTRaQnlDwk8z1?=
 =?us-ascii?Q?MFJcZVCCDn9u1OV0Q2nVNVPYptRliJxXBLYYLZEQzZo18WlwHoSVNhV9eMak?=
 =?us-ascii?Q?EEMc+WGTPRG+BdTHI9VEq45V1/+MmKB16QGNvdwgf+daZuw/RkI4jLOt16dK?=
 =?us-ascii?Q?smgeglFyHn848xtHEIBbOwEBfIVjP5OV9Nu8I+lfgjflI575oxBKBsWjmtPo?=
 =?us-ascii?Q?UnpHRnKk2MHbuxXM+4Xgt1s/rgEo1qvMqk2Epow99djFuZdU38JCnc6Uy5T2?=
 =?us-ascii?Q?ymWNpf1p//EyB/lFI18ds9Wxw1VsnHKTl91ZCnq0XMPZ2e4xMvPkMnjabVC8?=
 =?us-ascii?Q?V4MayVnoep9w31lYVSdGHRLB/nc8b82TBxtPZUdBtUI1XLVeefD+hejKeLsm?=
 =?us-ascii?Q?DVAa3vQDXljbhsIwy40nI9ezXh2GmxR7POudZ83fPrkWba1oHz/Vydoe5at1?=
 =?us-ascii?Q?xsw59wqU805WKNGATLDypdKzVa5IKD3OWLsyOxlMDNbcfBKeGcf+IAJ6iFQR?=
 =?us-ascii?Q?rGSO3xwSUAkrHTBx07c=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d6e2a3a-50fc-43fb-35a8-08ddb857e022
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 04:29:32.1909 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5W6cWEbfbCGDWwlNgbQvUQ+sKr++7IkNGzLIxfnMiNEy9rpqmlMef8lg+Md5UP8L
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7647
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
index 998d1e7c53..1d11847d76 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -2787,7 +2787,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	/* Init fields w.r.t. classification */
 	memset(&priv->extract.qos_key_extract, 0,
 		sizeof(struct dpaa2_key_extract));
-	priv->extract.qos_extract_param = rte_malloc(NULL,
+	priv->extract.qos_extract_param = rte_zmalloc(NULL,
 		DPAA2_EXTRACT_PARAM_MAX_SIZE,
 		RTE_CACHE_LINE_SIZE);
 	if (!priv->extract.qos_extract_param) {
@@ -2798,7 +2798,7 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 	for (i = 0; i < MAX_TCS; i++) {
 		memset(&priv->extract.tc_key_extract[i], 0,
 			sizeof(struct dpaa2_key_extract));
-		priv->extract.tc_extract_param[i] = rte_malloc(NULL,
+		priv->extract.tc_extract_param[i] = rte_zmalloc(NULL,
 			DPAA2_EXTRACT_PARAM_MAX_SIZE,
 			RTE_CACHE_LINE_SIZE);
 		if (!priv->extract.tc_extract_param[i]) {
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index b9dd9b22fd..b501fc091a 100644
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

