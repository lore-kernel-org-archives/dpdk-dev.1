Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A3EC71148
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 02:11:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C70F642D78;
	Fri, 13 Jun 2025 04:11:48 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013010.outbound.protection.outlook.com [40.107.159.10])
 by mails.dpdk.org (Postfix) with ESMTP id 2BF2A42E4E;
 Fri, 13 Jun 2025 04:11:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nR1vJDZlS1OYq8JQl6Uvo2gF2Mip1gajVjYTFRaoGtKToyC9BPBAsNxMv1F5pp3Ql4qNXLAvvqFKaxrmEz2o8BMVnkOOjL2WB6NyA0iJxEFsae9yp6NAPLoC/PBUB0frlx7fBHUndLlPR0mqDp30iTwAjig6PaD7VibyDCofEeYpYFKiV6gc0J+ItGA/XJtIWCIY/i+8jmzCBTTZcBht0DuKtqPedJg0LGUvNZEQdmTm0a4+6+t3ygrDVzKn9k7BFgKtqRMQOpvsIAgt+Ajiqjp9BxhcVwatJ1sa/jnrWc8nQ9LPtJWKM4zDewaXq6pnIV6lPlnnU4O+8qkyGl6Vtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0bzNHB+fr8iMdxTBNxdp4vZJgu3uc98ypnA/di1NeuU=;
 b=huASo3zmX8ULUjHPpWjQhkc8Ad4CsvMkqzey/FAos3p2k+Eu/YTH8pg8HWDnqwbDsydN4yY/ldqbOCXgT3EZebXDyODRRuAA8r+B1L9ik38mNyfXuGbdW+hZRF3pa5fqPSsUnrNctNuYRLrSR9wQq5ESn/p1FL0s5MjEareOi8alMPEhIpIoX8hy5FUvhqFDfnKXm3pgSz/l5iJ1ew5jD17BMv8JqCe8h8koPWC/zxfK44r3ljiG4zbX6Um5t+18D70vkuCGTxJWm2DZjEs+IFdsgkpMUcTS7a/QCuCHNgEInqvAaerTh9NZKSfSa3o3BAMkAGW86w1XqPJPuaPThQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0bzNHB+fr8iMdxTBNxdp4vZJgu3uc98ypnA/di1NeuU=;
 b=Vqmj2PPUfNTXAly2UR69bJfaDoXJyO0FJCcT4RiszgZi3UlGX9EM4k79sizlbdB6JndMjm3P74wGwUQomA+3CIH4hayeSf6Uapf5EZGkxqCUU2jYBOqLmu84ZqDs2zlBCq1+fxnFTx3UVCnqX7ZqVZ3jpHWptsy3FrGgDVPSBzUjquAgjJH2XQ9xojoScYP+CbPTDbGKLqKuQPE7nv+eDYayhjpPwBLdHFZR+/gNREkcG2A/TbWPQutJZU4U/GXVTz8rFQeBa5Pyy08i1rKS8TrpLf6l/R0OgIIyWJJ+FqDgFuARTxjXUvy174ZCDV9Zze+BDynR60XpxIc0UIbjHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by DB8PR04MB6907.eurprd04.prod.outlook.com (2603:10a6:10:119::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Fri, 13 Jun
 2025 02:11:43 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 02:11:43 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Jun Yang <jun.yang@nxp.com>
Cc: stable@dpdk.org
Subject: [PATCH v5 01/11] net/dpaa2: fix issue of extract buffer preparation
Date: Fri, 13 Jun 2025 07:41:15 +0530
Message-Id: <20250613021125.790614-2-g.singh@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b02fd1df-ddbc-49e1-b8f9-08ddaa1fa433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kx9AGM+26l9XD6K9aftoexpH+1iaJX7pr8O0GtP5REm8lUpxMVP4erhCzn90?=
 =?us-ascii?Q?Kv3psIsIsQD5Z7DPyXSUNaYlkBKmfiq0+t4J0YCCYzzwfBsqu+0Kvnq/MEjX?=
 =?us-ascii?Q?RI7FqaTMeU6zm27PV13O03u+jCf19uvKvU032L9sgNkJK0TY1bJK6p7edvn3?=
 =?us-ascii?Q?qc7nrSFVfBmVDnip1bXMJfk12hG0/Ssakd15W+QYt/A4k2mb6Mq3G6/f8hPr?=
 =?us-ascii?Q?D1jsC6j3WOfxRQb1g5KFtJmX0Drp5FVm6nVrPNxjT1paieUc6sLw++PXulXp?=
 =?us-ascii?Q?fPwlzfO6ku9MkreeIFHRt+rkEsVwrjuyaSC3OvZYyAl3YaYFIYZkfwcO0JRP?=
 =?us-ascii?Q?eeceEDaGSgNLaAZ7hTxwShXTPQU4xZpTNDh6oR596+R4LZfJpIWEkGGZZ+XJ?=
 =?us-ascii?Q?sVj97bMv9apsIKHcHYXf8MV9gyV58NERfPFjiaKGvxSlMqwbXAoONpS2C7lG?=
 =?us-ascii?Q?Y+jmR7+4KlCUgJhKqMUoFVjfrbJWLHwBooL/iYUpYJBFRi74UNZmLnhJp2qT?=
 =?us-ascii?Q?fqq4131jwD8Yth0Wafk/46rX5i6ecQnN5QNhy/biqTtvtPtHCm0lpPJAsbD8?=
 =?us-ascii?Q?9jSGFksb83+ut1AkQoigwvaIrIX7ycpsjTuRDWKisx9YRg06mkRjg6ncP2MT?=
 =?us-ascii?Q?M52M9pquPXy2i2c6AKO8zMTXTKA7CLMUrDX1db2A75tUXjPRzXfZeRIcjcyq?=
 =?us-ascii?Q?y/QLK6CvfIkXVNqFCPbTV7hArvuXKnOaF3dmjmK9clIlp0JeRzOWuBetdaA0?=
 =?us-ascii?Q?7JEktytb1I1X0FDXN7V/ZsVzAB8c8Wkpa9m19A9JUPb/V60veme22vPBwIXj?=
 =?us-ascii?Q?sG5CCkSbIbyqWS6iAhPx5UyqPQAoQRrFR/wAzMvWxRTVj7QVnJ1GZ6LxBdSH?=
 =?us-ascii?Q?GNj+eN2412YRIl6nqovoY/dVmAxlaFgQk3DvKDOj0n6jCA5/D7iALswB3P29?=
 =?us-ascii?Q?w5MaPiH8LeTXbTsb6Cy7BQ/angGjOiWc4gNatpA7r8IVvK3HCiRia+orJ7T1?=
 =?us-ascii?Q?fQ68CBqiWjxUzZJvTJHq2ghZM+ZElQqK6GWnBdMkW7ZeJbzCpgx/mZp9sufp?=
 =?us-ascii?Q?U7Fhf745KKmjeKFWa3TmmIiHInE1fkc+ffVO9pgqTaNnl3LGpnMgCwJubASc?=
 =?us-ascii?Q?rU4JpWFuAu7QlkQaLaPkdaL7UrV2+cm/LUnGs07uPnCjNbtfmgmdVwBcqfUT?=
 =?us-ascii?Q?qqpZ+D03i41FMWqoAb7BKsUVLVAqmqu7nfqQf2ugcnThQY8HbZfKyDuRwmGv?=
 =?us-ascii?Q?TXhW3X+bV5tlZZhhmwus4zVdZchtgiEozLIluNrjaDEBk5VfUmcJyo4rrC4s?=
 =?us-ascii?Q?8L0domQXScpIEhf9y8YtI7D+QFn5J8kRFTSjqnVjVX1t1hnhx/9x2cZ3L80D?=
 =?us-ascii?Q?FEw2Hd4z+wlVzt4/eLtMisDzF7BV14+aknMjfmCum9iEWAr69xI+mby4u5Rn?=
 =?us-ascii?Q?fl2rZgYRrXtMiUjoRvP34jBadykICvEncpdCspRBB/wvTwiROzu6Hw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YqjOND8658+GgEKMYzlZUakCC+C0emVUjUo/eUmm/b9X8pb/L+na2s/yUlee?=
 =?us-ascii?Q?vqQC88j7wjM64Yj9EtX9B/Y5UEda8SncBocc1CogrRkiOdqtWFP8ou56VDwY?=
 =?us-ascii?Q?Lphlcz3IvTJsQMiVnZ+RLsgMV5p9utpBHlyU9TVNPT084u8QfYgMZYch6KxM?=
 =?us-ascii?Q?Rjjw3wpK7X7TqNqS3w/4TnH8vLiBgsjgzUNpm3h/HRAHxC/DXxhOh7wYIL9Z?=
 =?us-ascii?Q?jqpIhxx11KzV9y4ZnCutoZ3LB+17Bvz2b+mBby7kE751CPNHd5Y8va2lHPl4?=
 =?us-ascii?Q?c1HBO+PJd3kOXl6XLXX+vIW5Hik+1he53dW9O4dESrIV1MrPHVU/ukD0GHij?=
 =?us-ascii?Q?h+lfeWZ7ORqZdY7He+PNSgFybzUcz0srTdS1jD0AvjSGA2ADjHGt3WGgnu4J?=
 =?us-ascii?Q?fIiHwrGinzODkXThJ1Y9AQ94c60DVLJ7lbNeVffQe/3l5vdYgh7HcJ2K85kw?=
 =?us-ascii?Q?K7tPst4OIrXnNVn5QJWoOm7fW0fmaE+aXu7C1XL3G0uoC9OS4jl1BWDsLDpb?=
 =?us-ascii?Q?x3WIAxjJeL9ljOIaHa6sEuOA+vNmVVwEbF3HmwbA6ZBhwnbyaadhzmMllNPp?=
 =?us-ascii?Q?bdOZ45pZyBT8jel8HK4yJAdBnBzNALvWGKu0QGU1pUEJZyIChE1G/nDkljeB?=
 =?us-ascii?Q?KzgKySU4RfYYaidnCz4Q3B+/XMcteY1H+FXyjcdw3HMBl0IBblbyySbvvZTb?=
 =?us-ascii?Q?S/rNYDtolx1ou5Z5COghqHFj7EjovqgmEWchFphL3oRNliLlteON6od8A6T3?=
 =?us-ascii?Q?7M+EtpqP52thXerzQFIuqdvSOJevo0mauMbJdcohInFMfgAzrTB6VZbqgY8y?=
 =?us-ascii?Q?eIbyTec/jB5b9k6NjbICm7hstGnl9KWrpPyQ3kj4kV32j4matHWavOZMGPEl?=
 =?us-ascii?Q?CfBGC0p45Cgk7g4+Xsnk0fP1Txv4n1YJ+JQNeaxfFVyPgFD1EWOfOq4Lk3tM?=
 =?us-ascii?Q?w7dxp9+8NycSHtkppdWhS3mv1ncszoZqQX7DEQ3x09IZnzbHb5jg15iLSZGO?=
 =?us-ascii?Q?1DnodJ1YP9pDUbHdNAuRMQ+j7r+r9IKFeUbj8HtBrhw7G9aEoWCCu1U+9yH6?=
 =?us-ascii?Q?d/j22dT2c7FvXsajHVtC9pI0UcKHAhpffkI6Vd+0sh9jTuFT9rUtlQQ4O6me?=
 =?us-ascii?Q?m5M9cy8XibxRnZLGHRd0aych/f+7GM8Jw6CcNAI5uE2YDTrskku5/dUKr1vU?=
 =?us-ascii?Q?WTZHGhivK/8rbSfi8vlX5fmhvYzCxqIEv/R7n9ie/mR70bo4a+TmxalQUStj?=
 =?us-ascii?Q?0zmyDloB1fK7P8T6dnGVLUkrs+s1tiYDrWWC06f5+Coo+3VMYip1n8vXi+M0?=
 =?us-ascii?Q?8QhiZU+A6Snb8aGvPE/0K+0oszs/nOKlpi319vNpUjBJ8i+Ot+3mv4zM80ux?=
 =?us-ascii?Q?o2foLvTm8bdvK/hcxA7fEZyeGrXm3wGWu93TLLjFHeByHltsQiBgfv+fuzPC?=
 =?us-ascii?Q?rjXszOsFN8Gr3CGdQs9zENINj9HndtAfV3wI5Ad6JUyCGdE6XNvdpED2V1iJ?=
 =?us-ascii?Q?+Q53t2zrc2/HmAu3KHKI6M+GYmeRFwlWD/EQVCNXN/uxQ2KiNld3blwzmJW1?=
 =?us-ascii?Q?gJGq7qQhJRQLHHxhYlQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b02fd1df-ddbc-49e1-b8f9-08ddaa1fa433
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 02:11:43.5071 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pbSzNr9yDPVewrV1jpHnECAFfaT2RcCxLshQIe/eZmKakAhwDv2R4B3aDFYLPsFq
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

