Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D50B3C8302D
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 09:58:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EA5D402F0;
	Mon, 30 Jun 2025 11:58:23 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013070.outbound.protection.outlook.com [40.107.159.70])
 by mails.dpdk.org (Postfix) with ESMTP id DC4194025D;
 Mon, 30 Jun 2025 11:58:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VS2zlK59kiMOsi5Fin0deRzuyflqKwS0Lwzo4VGPewjJ4rD/iiynaQ6vphMkE8zzYH5I8tr3tAdyTqITe891PlvN3FfGWqsZGYwtfLZO4N8RUtnzaXNwJDlZMnPY0JLxgyTO7btAVtXsEHlQE2KjIZdavyNPsh+jQ+5fNr3m1oqfCmrqEn5SbuaMrKKQH53jkdwyJ1bSmlwEE4BuKbzsb3Cqxct+ABFaYtfqxXElFuHH8R0eRxAsnkZm7EMXc2GkXeFjn8N2cxqFMKna53cwNumRPcjEe3EzuQS/wKo4VL6e7B9EM6qnj34H8eBkGiusk6iOPvcj8ZEnsvT++l+7zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OtQUNJ8PfhYMvOCwDdPT3bDS0CU1K8XnCL1rRAk01QU=;
 b=xVeE4BFA0+VXS+Cb+m0vg/CUdNNQB2Ld6tuHbKjZQUnQKsl3rm+ADVzGsFq/0fHpIpAsBj0BKqU+guNyQ0DwWCU3ebl5dyK3rolM079D0+2+8GfFX2024CTN+eWTwp2sr65et6rVu1HMmz/AU+D1MA7IDBGjAts39312uc8uNqZ3NFwNAdiXSerVe1/DQp9w/6881vOggQrTJ9fXjc96P1vTQs8h/YhfkO10SqYpWnhKNXrAorNgwSI27VodtQvbEPY6MTeP4iQZo9aPJsvJKvs9DIXPTpTHu3qqXKug39HykM/gQR7Kd1GVNel0+cWCUJzssixdr033IHSN6eOzCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OtQUNJ8PfhYMvOCwDdPT3bDS0CU1K8XnCL1rRAk01QU=;
 b=lieneHtvpasQsU0h32mYiroLzvKK4xDqNqwQuaVRvcl54M2MKVPXoP5tOTtVlKqDbej6PkhyUKtoQfSfnV60SZ7IUZQIXQhRbduiJHQNUcizoUYOaFPSpobi5gaXoG7WAeRJ+Ewvf5sWgR28Y+fiUqMBjVyYw/ET5YgprXPecIhwN25LAoWxLN1yBo52lpOo0ufoPlXRAV1etEMey8AyA6pq4kEKTpcbbabM0UeBAv5lqb2U6WrOLwiy5FFhiKK+D8kbFEESFbGfsDmsQjXPqRS3hCYlDwWZwZRaRF4mRXXksVUs3A4StVCLyab4LMtnwTzE2mSkrNBDp0+mwJY+yg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AS8PR04MB7894.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 30 Jun
 2025 09:58:17 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8880.029; Mon, 30 Jun 2025
 09:58:17 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Cc: stable@dpdk.org
Subject: [PATCH v6 1/6] net/dpaa2: fix issue of extract buffer preparation
Date: Mon, 30 Jun 2025 15:27:55 +0530
Message-Id: <20250630095800.2943863-2-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250630095800.2943863-1-g.singh@nxp.com>
References: <20250613021125.790614-1-g.singh@nxp.com>
 <20250630095800.2943863-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::34) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AS8PR04MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 02d90628-c274-494c-6071-08ddb7bca32b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Y0cjyixE8Qg70AvtbIgXnWQJH2Z3Fi7UrSoPf+5dE8SnqF2cp+rI00DvBd3R?=
 =?us-ascii?Q?6RK8n1ULwDueuCNibpZzSYMFnGDe1F0cZtP8lZiI8K4iIPjTV2B1ZJIgBOik?=
 =?us-ascii?Q?d8M3nIDAVucecy79t6YurWcEMwXOYPnGmnkK74G9m+C9sljx0ly5xHQOQHHL?=
 =?us-ascii?Q?iEMJ3cAyitK4rwjOWdVTEjAnYq4GMnTO65roKO0k9Jt7f5dI6yjiopDqYxx3?=
 =?us-ascii?Q?NB+6FIFJlABly/e645a1CGr1PkQzqYqwwGZxsFPaq2OCiD9EkUMEFqcv5Zlb?=
 =?us-ascii?Q?FxoXYi65t90fFBCRB9FctXvpvM3wrHPOqbWU3OaenpLrbU7o7aa9vCeNOU9N?=
 =?us-ascii?Q?NNc7xFnAFyRW2mdwcD6gjuNbc4iE4GwaOCF/+EmjUB6C6lXNBTbcczydgawu?=
 =?us-ascii?Q?ayRMcsSXNt8JX1TwFNRISm344aaVul29fRoc3UbJkcPaccMOSfR/9rkoK8Gh?=
 =?us-ascii?Q?8urWo3ZfkPN0TJhLdZgD/5Zbgq+uoyzLUZLMLJzTZ++p705on7aPpfSYAfeh?=
 =?us-ascii?Q?aqDFJEsnwexFkcmHZlMUpABJoZxjFQ74D1GjsaN7/E3niBxy7o7wI4HKHBRP?=
 =?us-ascii?Q?tXP1cOWloRA/BD/+UY8Jh3wi5Y16G2IDJkEH3SS+IpF9wd8ZwwNB5Fcr+TuV?=
 =?us-ascii?Q?t7EVW9foRPpSrVUZr2HiCTOQgnm59n4roa5CvG3a/c8EIhMs3j/pi6g3Y1bM?=
 =?us-ascii?Q?wHdbXd5RNefg/WoA9HUvrQ7z5aI0dpqOy8aI9TkQ4CvGNw8EWNiL3c8msAjj?=
 =?us-ascii?Q?iH6A6iDiBk0NIw5hPzd9MZrTrmB7nrlV2D1hKRvhZ07gH9Cty89DJ7R9Ejdj?=
 =?us-ascii?Q?GbP1w5m0WqZsfxjD5YA6DQFJVNB2/pZ/Qd7MSE80LwhHLyeB3SJYh9CrVU+C?=
 =?us-ascii?Q?54l4TGKmg0FtrA4DIetsDtRnA92hgkCvj3KBSBQzaYEphKk0AtuN3WsayTI7?=
 =?us-ascii?Q?tv8V97YWNzh1KS9dMlWkjVLtmU3tPFdKBjQqIUEggfVsaI56LtDTQZcMOeDF?=
 =?us-ascii?Q?R9g5TdjQbIM6eXj9vB2fTNnyaBMm4XLkWbTUNPQLrRh2GswWFjsiHeq5DYF7?=
 =?us-ascii?Q?0DG4yvRXFmZOUiVpmQ1kRg+IHHksyEzWOgocHSbN357msfGD2wkbVcQ+oKcc?=
 =?us-ascii?Q?fRF5czrZ0hut4tZkDOEu5qSaomrEfo6O6kmsAq+e8CokvsNF0n8nnkNqtf/F?=
 =?us-ascii?Q?7JmvXM4DNsJcI342vTj0B0e3+z2hO/w3FlUPLeP4WJ9Fn5WVOeNRvKlY7ViS?=
 =?us-ascii?Q?cowbaiN/rPoLcQFHKdUr3bvKCn/8cCeEy6mdJIKCm6NsjxfVeigDd9RFle5y?=
 =?us-ascii?Q?OzC2S8PcV3BnpKokKDavjGhpVdjJdRHsRn2+g5mP9Xb8TxWjgvWwRgZuEvP0?=
 =?us-ascii?Q?RLqACL6g5ODHcLYxksH/MP0fSd9RRplUG272mQSnI6n7g2W9Mwp6y39kHttk?=
 =?us-ascii?Q?WNgj5XuI2Y/7goqc2ohiv4FEjGScBIRrpxLY9k+Akq+vpfWYAznDAd5COGJE?=
 =?us-ascii?Q?KAxqhWPBZ64TJkc=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BhIBnTpH75Gtu5qzUoptf1Zk6EQchm96dyig57iJb/tPz+zF4mCR3l5fjc4y?=
 =?us-ascii?Q?Lb7SpLtYIw+IOFKSVvET63b8qa3zlCa6Ihb9Zre5duvxmLDeyV8r1j6eTv+w?=
 =?us-ascii?Q?GbgmQzlCZQIF3snlFL5rZJOdgxk4nuiTcRc9LdIha/nwoQxYkNIjrZi9gFLS?=
 =?us-ascii?Q?Cw+u3G0I4+m2p6OZY5OswLGkFhK6lkcgY/Aft9HQK2YPT7wtr0O8MV7iA/c4?=
 =?us-ascii?Q?/BVr9bUD9jD3GG2P1EW5Lr7/lO9qdVRgG1c/4A+0e14I1AaPgtpkh5kXBetk?=
 =?us-ascii?Q?l3c59akTEXWgkPmkv37YsFMX149zrxnMS6XNWepkyWxLUw1Bxl3tzo0cb/gu?=
 =?us-ascii?Q?coKEJvU/qRvZNGVZJzmw0LrdJj7/l8G6yzoLwPfhuBFVRp2nV0MgmBj+38Zf?=
 =?us-ascii?Q?CDYOPohGEYO+gLjh1TkPqChGgNvmENIZwdjYYaFkYGQsMPObbmS/E79pww3y?=
 =?us-ascii?Q?EcgP0kye6kqSBCIA9MUYWT+ZebKDrCiR4oafrc7rdkEf0vQ2matyrOsFavNh?=
 =?us-ascii?Q?xsj5oSO45QVH1kIcK1cE4+vENSyM2m6YpHpo5dJXlXr56uCx4m6GV9Xz7/NT?=
 =?us-ascii?Q?fyAVtnKqAEEybfyvG0iAlId6amPisNndCsmpt+utLPhsvb+hlqV7VtojMIYX?=
 =?us-ascii?Q?52PEAcCZI9UGbB9jmeQ2outlCKcIbeiy/wSU+Ye++bNDGsgSUn7Q//BzVvRW?=
 =?us-ascii?Q?UdrmVTzDWhwr6LhwgarhMb1ez2g2lflZ87rbaa0bwsSP7RdpqA5LHAxtPl38?=
 =?us-ascii?Q?fbbGaEZCX0NawBw54UiP+cYrjgBRCwdaY2ZC/KbtuA60CGV75/X+fxkVo4gj?=
 =?us-ascii?Q?OuT1/BJ0rrfl3H4bqVdniYdbn+iqLIFCXKhtGIotrVu5IAmnDsaOkrEcm9vF?=
 =?us-ascii?Q?fWcaPVAWmeq/MMpTKCwuekAE97IliJdbwRuVjsWuLaqdTi0poMlJAny7/ZAj?=
 =?us-ascii?Q?CO7eLM1d+toDrWk2zXrfqNBsyCrnJNnRGcHRDgBLJ3i4P4m66li6lUDvkvrh?=
 =?us-ascii?Q?wvwnitLUFve9KQZ626Km9ZPc3cb8bDNDweW6zGZ9og0IjZYLI/ZvKf53HSw6?=
 =?us-ascii?Q?+hWNQkxTqQGnozjeg/a3c/IUZccb4pDS3tIPgcCu6S/NGCdiBbouQxU7sqio?=
 =?us-ascii?Q?LML9YVDoLJOTk2d8ZODhaw3GUgMheBladET486hXDQ8zHTBLdl3n5iXPAoWm?=
 =?us-ascii?Q?HMHRb4+HcSamh1OhqiPs6842KFwRlp/QSSCvuZDGGDmg2Mok4m0kOzEP7fNU?=
 =?us-ascii?Q?3dd9e6+33oOagq2Z/OZ0mifsRvTowcV40Amp6GWhzbrTf8vS1cXRH6Iq7RpF?=
 =?us-ascii?Q?c87a47gvG5C9wjT4OxtTJYagUnShD+H32mYKDDN/uQuRPVnM/6LCDOcCNLtr?=
 =?us-ascii?Q?/jbJwbpvF0JdofNWr4YfUWOhl3Vf6b6tKorTC6RCw695dxDZKsRazErYtGyw?=
 =?us-ascii?Q?zCzWg3QKPt/0nlB3cTGIZsYDozbiD9q5gx93X57ZIxuc7lJs82/OTHb8/RO7?=
 =?us-ascii?Q?DpkZ9SRWzgOaCqvjG2xIXbyhPawDaZDx2YWurN1zsYPkrIxF0MehBJioIg6U?=
 =?us-ascii?Q?CQOM3jwhaiQWJY8PQNc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02d90628-c274-494c-6071-08ddb7bca32b
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 09:58:17.7352 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 437emYyRLvAG8UjdqUyu4D2pl8bEtyKOQsi2d389kVYuIISbZGcwHVQREQSIn1dG
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7894
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

