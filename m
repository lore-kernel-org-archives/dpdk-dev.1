Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A93C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 10:41:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF921402D5;
	Mon,  2 Jun 2025 12:41:04 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010002.outbound.protection.outlook.com [52.101.84.2])
 by mails.dpdk.org (Postfix) with ESMTP id 9131C402EA;
 Mon,  2 Jun 2025 12:41:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vkWsK2hIUsvWcIT7+WCOFq1D2FXI6thgIEHQgcPiZfQuTcP45y4/ON19WggU9kaBbpSVPFI6/FnulKx6YnaHlsENqfqGJ8HxaqmsLV+o0xFEYTDxN+joK/t+3yjCYk6ZKBxhpQwPBDT2ZYejBCgHqMYk2FKh7r4BNMfVHtsH1LxwL5ingJRTlSLYeyjsLmnlhwgmQFSw0O7E6JAhgZfxCDCszinHFWymlmmJ19mV06SjCkXx2mfhZBQreOYhJQrjLgwUJy22SXyhRMkZP5EXlujDElL4gENgNR+jVNSyJxCxaWQNMfek/3L0bPLrsVMZFCw0+dSBYZ0YizokyGpDgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRJfhCnhPtAy/78KTQslBD/e+dE4if5EjNdc2JcvvMs=;
 b=eeBRre9NAhtYk/NN7uDcMcsUoSRQ5/8PFRugWlHMBBo+JO/xxJTw9vUVIuunzywf7p/4wt4WqFuQtKo1IeT9+sEp3V6yYLp4EJmvOC5P7qIQ+8jdeImOuKmxpTROm7h2fD0aHlGk10mpXbpsfA0EtLEnuCDzxhIvwjJXwKVAT4ulWsqbU/+9CT9wHnCG5QvU3GPnNneMprnstcnRr6lZyvCEYM8cgpghgJ5LF4V+PVyaxAa/OxyRJqfPlqHXItRyWSz8VYAZ3ANcTdps9zgwMArVZB9553fc+LmTBIq60lqgz9GHkdsT7XBJCQ2VE9JGHL/PvHoFKGr226ahjy2dKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRJfhCnhPtAy/78KTQslBD/e+dE4if5EjNdc2JcvvMs=;
 b=LV/cieUI3SU1nrkykNbgQeQsbMXaZZdnV6u66JoFNwtmqNZlVio9n7RVXOtSKAj6v9vU8vmoFzraW3SYc9OD9eE1cjozLrLlbkCEbFzIygBUAyAaDkCQ5QdOec6XitibwPxyAY1FvsazaKCUdfYT1mypniOd2raVhGshoTzNkHIbH5q2lZEzpS0ybJ2Rkv2g9JTykmgs4shleF9oPZSQJ+YWCc1+ls84+RmXV1VrevkPvLRb+mQfy8r7+xoygC3xLNX0ft5vEL9jy8qi3Ue5qWzksbWGzokQeNtYOm5tu8Zv2GBkDGOjJQqkSaKcUTzsonOQKUgt0TOXzu5NoYIEvg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8194.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::7)
 by VI2PR04MB10956.eurprd04.prod.outlook.com (2603:10a6:800:276::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 2 Jun
 2025 10:41:02 +0000
Received: from AM9PR04MB8194.eurprd04.prod.outlook.com
 ([fe80::cd61:3920:b12f:6561]) by AM9PR04MB8194.eurprd04.prod.outlook.com
 ([fe80::cd61:3920:b12f:6561%4]) with mapi id 15.20.8769.029; Mon, 2 Jun 2025
 10:41:01 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Cc: stable@dpdk.org
Subject: [PATCH v2 01/11] net/dpaa2: fix issue of extract buffer preparation
Date: Mon,  2 Jun 2025 16:10:31 +0530
Message-Id: <20250602104041.3322164-2-g.singh@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 8aa7416c-5f18-4ca4-6eed-08dda1c1f7a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dtBXOPTwbpqJ6nGLbQ1EYVLTGr07/4QqpuzzdNKB6MuyrwtwGrzbMkqK2s36?=
 =?us-ascii?Q?7lnbVM6dRyq9MjK6urpSh8zutTZ4OkwdrqV/3dJXktEJmAnoOXEbylZX1TiP?=
 =?us-ascii?Q?IDsUQK1GZlbt2/ocOtW+3S9GYWJYa4RzTh9BhIdIPmWkDafYnt3amAZ82q3v?=
 =?us-ascii?Q?i5OkW/qhtQYyHCsdcrnlLjlzxHuKNB0X8GUlFGtpzvBpicCBHWYDX49B8s8p?=
 =?us-ascii?Q?2hl6PqevAVCCnuYag86Qa2dtYuP0Cl2SEdLfXHAcdWYM/EOq68gaHjzoDiCN?=
 =?us-ascii?Q?MVlhNUDzdr5SYfYlIYC+5Dm1uXLJME99Qw1asWFql08rgu8WUMwq3Pl09IrY?=
 =?us-ascii?Q?c32MoLdQszkmP6vUdERiWmh/3RACIkoSRxtCU1IRSYhkQFjZdP3Ou9GJnfzH?=
 =?us-ascii?Q?IO4aovUdlGjD2z7cXEaKPYQsIWm6ZwbmIpysPNU3IQgGmuFn6rEcif3zTL/L?=
 =?us-ascii?Q?ApfFl3/rlDdtuTjnQG0z/c6Pof+7TqcmYpqQAdZOD4ek2WthaAkDADIa0Ptj?=
 =?us-ascii?Q?zoQJVj64YoIqjB5h6CTgOL/lSa/WwhL8C1ijS14sm7mf6jzSmU29ODEjsfUh?=
 =?us-ascii?Q?EvlzchLOX1e+cC7/THLFzogQrmLYmEqulxpICfUJlEsJ2EUWhEUIaOn9+SAA?=
 =?us-ascii?Q?Nixtr4LmJzz/rWL6iTWOMr09udOBRNJFENHJr3IEPykfn6/xsw9fGcoJ78Ak?=
 =?us-ascii?Q?zWaHZLVyqW04Kb/i8sugXorrLPADLK6XtEzhz4K0bn+YdouRnhRYgBQPz+H/?=
 =?us-ascii?Q?AThWpB0ZsHCzkEQR/9yIpPf6E58/DVeoslAJSIZY+6aFGUB67/F3SFDonYPh?=
 =?us-ascii?Q?fj0iJ7nB9WwycDJugOehBmkckl2nGsRCLoKsNIA4OnIgyWCUVVmFx3t65c9Z?=
 =?us-ascii?Q?7I+p55DKYhhFdyBTBOLXpgF+hSa4xrJ8B7tGTjOFFOW5cj6yAXQN+o7yIyn1?=
 =?us-ascii?Q?2lW/XTHzi/vaCiLE5L8zVKu04HDb5O2hCoZ2hxk8JPj8xzRnMwMfes7JBDnP?=
 =?us-ascii?Q?kVgVFnSBz11XeNdZX+FMPYJXfWpcw9FA9AoGH9lR7QHoVcaP7YbxO15LUB5S?=
 =?us-ascii?Q?oqs7A/F3Zfbh2AzRrpEedvaDxI1OYiZhg/ekUBDFIbVogbmzzVGLeIJcAorf?=
 =?us-ascii?Q?fEyvYbV5v5UqDvENvdcl4smzV4msJBRcqlT3jn4RmN2hZuvqYAZldEM1H5jp?=
 =?us-ascii?Q?0ovgevusqS74wIP2EF2Yt8794ChrRDiepSIOWADeWkhs5vfHuP7RS0qklyig?=
 =?us-ascii?Q?zf0vWgSNU3e342zniJuNv7JQjhrExF1hDTzUoKWLRDd2ajiAYypqj3BtlXt3?=
 =?us-ascii?Q?iMVqwAilhaydPhYyYe4bxzhdYyoPiywb/f5AfpPLBujO2PYrQzPYfvrkUR3F?=
 =?us-ascii?Q?nHgA//1dqxgQKTzQUIYdOn/pAtCOiQdMRvUf0108A5H9rm+DryV0Hf7c784I?=
 =?us-ascii?Q?nVKv7hPj3wyK/G/ygl45QLPpxNEhpBha9m0TcYJYpvt4ObatKNESIAWrqDVA?=
 =?us-ascii?Q?uxTN7IVHCZNmN4M=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8194.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?k2Qv8KPuzw8PeVdQXhwmT0U4i6Qbpfl2ExVyilhx2oS4x85h5gmvpsCwNfLy?=
 =?us-ascii?Q?pHnrKizrl1etaDK+M6GMk7FumqdZhbCVyawPcgdb79uFdiOTKZxdZrU4igQJ?=
 =?us-ascii?Q?uzwGgGM/aoknk2O+Hef8G0MM+p70nl1E4YlJTKFkuj1hqwGJwM6y5bRsVdan?=
 =?us-ascii?Q?G9DLHQQ/fgHavI4Ozqtp6rv9oKogrBoAFQANVhz+lhzK4f08jyWQQ8lswUp2?=
 =?us-ascii?Q?ZLyPczFPwmu76u7CIAkMYe3/Vz+WIl0v+D0CAKjDIJPjKlbc8vj5k6IP2/0a?=
 =?us-ascii?Q?dOCvVKtJlDt0SDS5ruNdGa9vNSaCq3+PnZjX6u22vhpdabnwZm3/DYSZ4LLI?=
 =?us-ascii?Q?kyIj0E3kHG9qjBnOSaikUmy8UeVqZ5yNYXNlZsIUNbRIjq6D2zM6oosGHypL?=
 =?us-ascii?Q?9TYlXa8Rm6LMzJd6zC9DoppxHpPkDfCi8DQf1EaJDjQROzVTemkLKTm902xg?=
 =?us-ascii?Q?vu3PyH2VMokSNtKCUY6sWQMeP7nkPPnVoitGd0y2llveM+RgTO9LEFQumB/Q?=
 =?us-ascii?Q?q9a0rVeOjymdXVj8nj38MHVbv6baJ7KNnAm4WyEXC9xkDvtjEtcXVYLiFsGI?=
 =?us-ascii?Q?EwPxoAjw1iG/zL9a+fVIW6wsdtZ+SiwbBoCl/pVSqMFXc8qrXaVFDQJM2AH7?=
 =?us-ascii?Q?nd9TnyWVhW9yMiQFDYVbxvRbs5DS659v++FUMWKWgwDuq+beJItKUa1VcbEX?=
 =?us-ascii?Q?Pvh9oJVbNqRjCnWC5ukc3KbIhdBcyzWs10oUTEukfPMGMKjiBzPXu3rZsQSJ?=
 =?us-ascii?Q?GzQNsx2jjKwA3G+uOspNzJDnhqYsFnebVk7jeDdo4CLIVO4Njgvhe78mruMr?=
 =?us-ascii?Q?R3tldKWDbccMh8aIXLcQozaAa+G0tIHvGAmPFnI8qj2sEvhI+BvJMuEF77/R?=
 =?us-ascii?Q?8zXSZtZDquf/WAe82LXBk8gaKbhlo7fEACCXskbPeaF8nvKTWVtcc3CwSftI?=
 =?us-ascii?Q?wjWVzX8OLy/MoHpNsNezQ9zhNeYlJ1uUvXY1d13+64qktIrnQNm0GTQWDOvq?=
 =?us-ascii?Q?3cwZFXfJe6LWkH9c2ksI62UQYG2Q6Aqr/3UkUqLZdZPf9ejCd04Wj4d+7E05?=
 =?us-ascii?Q?RIDAaOK6v8yhVWEjWpAtNiuM7gcLosLCuuHAFK+DtOV6wceckPvOxMnCWiUz?=
 =?us-ascii?Q?rsPtZ2yB1tdXGox3gLZdhHT89xDRWss+eaTzTIfJ9MGRMyME0LoXPHTLrbdh?=
 =?us-ascii?Q?y7e3+jZ3N5wjIbK0ByHgzMuAClRwYwygTHnu0641eFtsap8EDLk9hbXNNCuy?=
 =?us-ascii?Q?pJykjzun6plfJfVXw1ZjVl2zFe8RTOzVMLnQnQ0Nd34yZTPdbVoNR7pNmnFR?=
 =?us-ascii?Q?G4VV7QCtMxlCIwzV5a+KzgdHs/VUSFEMzDE8P73KMKvy9gcMyjOsr5AqXChJ?=
 =?us-ascii?Q?jl/uuiM2ZFe8Y2F17t4WmXRoeGXvDsAoXuA+o9u6a+q18B3wZQ5CoNGXb7tL?=
 =?us-ascii?Q?R68g/3iFfikjDCb2xYrKD2mXNCu6H2JL9fDTXQmX9/j9UtT2ScKFzgjFzzN+?=
 =?us-ascii?Q?qr0d0c2TpHqC2rD5utmGeiot6rYpnkuzFP68EWWYR2c90vDiZhGOhIwA7YdL?=
 =?us-ascii?Q?hI4tLQDY0Uuh3rCRa44=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aa7416c-5f18-4ca4-6eed-08dda1c1f7a8
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8194.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 10:41:01.4805 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p9MX0njAf6mD+5Q8Jy2D1zD7GMd+yxgkO5m9lOxbG9AEnDoZ6oKYYoPaD9PsiMiT
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

