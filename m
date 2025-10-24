Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D92C2CCD1AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 06:20:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0822C40671;
	Fri, 24 Oct 2025 08:19:44 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011021.outbound.protection.outlook.com [52.101.70.21])
 by mails.dpdk.org (Postfix) with ESMTP id D634D4064F;
 Fri, 24 Oct 2025 08:19:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OaAQiXjR0jcg0ewA+fFqJp9iqEpEICB8vgTiEY0RcwidOmfT87jwCrRidredCVZ7QMH7hnRrgKwzmIXCS39TQbFRAckkCTV1rCSTAyyDP0uDEIizjWfR7qeAij8azoJ1uTfO0VZsWnBjLx6MY1x+B9+aK/rVvh73vV1+wQnFTsXeNieSa3sWbaoXe/fVxdN13ko6jK2l+BRqn2KdBgZ8sdkhIEWnSc+enUhONxHuU+vUOkUctFEuhlv3U/tdIZmYCYOe+a1Pth3U4jppN8S+gZGR/ST1aBr6xsSxtdRdDKfnP03uzSeYSLCVH59J0MRoIzjp9LaJ5dPDzmstsPT0zA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9nGwDURwIQQ7X2Lf1hwnWDkbEvuDjU/JYph/l3SoK0=;
 b=cOUnfMbhZACWyyj789/62elt5h5+Zbh52EvlnplI/r2ZR8ei6xUan9s9IOd8tYUpb650o0KvUJhqZzP24hq3AIhbt5UtHecL9db+oZYGIUYAaPE2x67uc3KGSY5vJE7tvjcQ+0MZPOwlKc0MN6uzISSAa0MF84wiqQdPh3KYK4sUJp1V6v+3P7ink22kPMguEt990Bh/YYTIqAdaBdhZN1Vg36k2HoWGCru+PnXm8tsw65d2gn+2V2vZ3MdU1Mvx4kS35l0KM0VRzxMwd8keRg0UNuW/G3Q4EvfXOffMNADtXEEwtOnJknn/+b53/bMBPfbYj2i5KbOV1rDJ0khK+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9nGwDURwIQQ7X2Lf1hwnWDkbEvuDjU/JYph/l3SoK0=;
 b=Fw4M8l489TxcrisE+DFDhPP727xsfJIM4mV0Y89mXuU9rzxYGqn4RDb6x7+yFku+W4SfWLvNTpYAsPVqnI2FVk6KRhmjgScR/G/V0OugHNsoVYuxDBwun28lgEpakTwP8tNI1dKVEy15zcOL4qGNdsFIuewVzmJbI/5MfVyB34y9j4qwgwrmw0DeY10wbOPVPc4w2IabFMWXsxv1iBo0ZI38rd1yc6RKZkyrjv9ED8NIyCIveUNEEerwsBVVpG1uRNBQbbhd8JQv0h4JLLlZIht8jd1vHJlJ0jj2dm2ONyPffVjzHCj19TT2vQ/zuU8pxNfchG4Tf1wIqempzpwvcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by DBAPR04MB7478.eurprd04.prod.outlook.com (2603:10a6:10:1b3::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 06:19:35 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 06:19:35 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Vanshika Shukla <vanshika.shukla@nxp.com>,
	stable@dpdk.org
Subject: [PATCH v6 6/6] net/dpaa: fix resource leak coverity issue
Date: Fri, 24 Oct 2025 11:49:06 +0530
Message-Id: <20251024061906.3535470-7-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251024061906.3535470-1-g.singh@nxp.com>
References: <20251017044848.3269627-1-g.singh@nxp.com>
 <20251024061906.3535470-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|DBAPR04MB7478:EE_
X-MS-Office365-Filtering-Correlation-Id: e3f33bfb-cc82-472e-d9c3-08de12c54db8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|376014|19092799006|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?w/GPdhTSRPfWocmp8l+uLp0pinhIWSFKa4hZLPru5n7iEHlxCQPJxORRvkIG?=
 =?us-ascii?Q?vWKJA5/NOq9YciCRVwY6sNsloCFx//qsB8bdjA0NGN5hgPp+WmMWK2MNFYyu?=
 =?us-ascii?Q?VDgnkt7bzJq5YhemhJPcBQtVJWrbBt+UNBIlnyLXiwD9OVf0D4hEHk1cB1Ko?=
 =?us-ascii?Q?FpyOA71Mt9BGs34jlb0fVP665R4dk7ZvXrg9Ij60rXSyYZr6ADyyPdJrFtuW?=
 =?us-ascii?Q?KHmS4GRs9FhJrtxb+G0ZLI8TudZgsC3gLJMZd3h5eXZxA+O+RQEhBuKKIZq/?=
 =?us-ascii?Q?gvQCrz8XrQT0c84D3GDXwAFMstk81YcU6OLJ/hzcy5WaAYrq04XogTp+l2Qc?=
 =?us-ascii?Q?BBWu6OgLbLs0SKZ02qfiMtStA5v2BzOrsbGIRxQ8xc+qjO14Bgrr4cPOkyWx?=
 =?us-ascii?Q?iYAijaLr/PiAI3vxYpQJWvwpnBjGiiAT6tEl3s52phrZUpYtK/ws21kEeNLr?=
 =?us-ascii?Q?WYWNvF5q11qVvv0xCfMYWW1s9MU6pPsxoTC4NJxo79jx54WcGk6S8GA1bcQ3?=
 =?us-ascii?Q?K1Pi72+s05gfAbVUfldAwzzFPWFvNMIULBoHVGQ9AlyrWCj+9yf2omCafbka?=
 =?us-ascii?Q?mgQ6+GbgTFR6CCXsqqIHYPXTAmJdOLBft9gslzQuxzSkettuzEzWLRveBC9X?=
 =?us-ascii?Q?mpNMWiY06snV3g0O/FPXEZxiJiylgBeUNWhfYI12TN3zUOvrf9Q8m36Tze/a?=
 =?us-ascii?Q?okcRmELKU8B8o0lnxGeHFUJfCWmFXnpRjMZl+/mwSXlasc3Kr8T+2ljbw6lk?=
 =?us-ascii?Q?hxynFPYFaMQRq1Z5OnHXG83K6a1odFfbsRBEXVJmV+qjnSlgWIpfi1nG8UMP?=
 =?us-ascii?Q?5lFpqAAp5UT71/beLMxY/ydLtAtc33VIC+DApS+pcxO4tW2nmgBMVgEesOEs?=
 =?us-ascii?Q?u37d5uN0CBRKuvrFJwZEPqqNkPY5P52DzaA1heCVnnJ70qM14RnjP5Qel8tk?=
 =?us-ascii?Q?RiEKLJWn8rGreTGkwyMm11wIC7HE/ZhrznyL/vpCfRaMjq+svbRX07eDDtNa?=
 =?us-ascii?Q?BRmPkeAXI07J2JgTjHGANSOJbq6UV8pMvMH7X/4vyexDocz3GWpr2kVoZIYv?=
 =?us-ascii?Q?0Zd0fiABYwfDMjiIfv5S5uim0a3QYh+fiSR3Cu6VxPe1bgk5FfK9Zk9AYNXd?=
 =?us-ascii?Q?L2Kzl+9Vhnx3StLZoDDg3VN5LYbouad8zSU6wCLQyR+97L391nyyS8wWpGv2?=
 =?us-ascii?Q?WBi9i3SMjt8XT1g1DZxlopuf7BIvCOUmUZ/5EsjLgCai/QR0+4u06HzZpKNa?=
 =?us-ascii?Q?JFEizIC5O5HbSCYqBYLSgQwzK9/oSKfrxQhSS0MxZD3CkqoqXaQ1Tsl7cabq?=
 =?us-ascii?Q?csc+lW5sRbNk85YYY9hZToSvYN3nHKeCk6BMzzfzO5AjaiAAGT7UNdOyqTDF?=
 =?us-ascii?Q?fcPoLes3EbeYk+ey/7J+MnbTCpjYR3Q4JTA+ifwpMkJitm40urSly0FtBPo2?=
 =?us-ascii?Q?qjWKiqv1p4uKTW2C3P8WXxaXqOuJfYH/macslgw/boLMoc6tfG1XKVQoelK7?=
 =?us-ascii?Q?ePVDatuD/ruzbUSVkPBdOBiapSs6Rz0H9eUF?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(376014)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Ge/tMbzJDtDjxIHI75JdcuKXmcF6IyyMbC8TFYbIuiPAO2Zozhm18YOhQLH/?=
 =?us-ascii?Q?7FJMazJDyrDdZNOFG/sIF5sN00ydaGe3THKu2A5PBUbpBEJoEmzoIBVZR+lZ?=
 =?us-ascii?Q?egXGndz+iL7LX2Dwn1/Zt3Q7BlYcH6fQtxSsJRaLJ6nnU1k/5RrFVX57UA5p?=
 =?us-ascii?Q?yt5Ixp9eiac/OJDHuV3vXAysJuJ1SSaAKdwn/hgsRPFzCU7TUF5jSUOWSATf?=
 =?us-ascii?Q?b4C3mgNyJyz4ZCIyyNgRbqADx2pqoRce9KXwq/j6S4j5wkNswd8btZOuqAhO?=
 =?us-ascii?Q?Aunh+na2px1/Y1mBtHMdotd1+PX7yww8HALKsDp4XFH/OBlalFHmDBuq4/s/?=
 =?us-ascii?Q?eAAlHyrmzcpO7AVndlFU/s7nIM404ieNUCBhxxP7DCOTl1+RWG0f/PLv1Ik9?=
 =?us-ascii?Q?vGPDdus4jpGKXLbWDpnxpcgv7R40EugoIeraUMt/Uf8fhXEF8WQX0b3XFQBr?=
 =?us-ascii?Q?msXjj38pMYAsePFMVPblC1aF4acFzfPUCc3VqlVB0sFul24YwvRtWBSAKGOE?=
 =?us-ascii?Q?S41/7Q7NAKrhVyK1pG2eUTMpg6/7nQRjCuNuS9xQacO3QnTFs3nCyLtrhYfy?=
 =?us-ascii?Q?L4qyZBTMW3SKu+qyYtXbNXmKY63siBm0XLP4NAJfZrHxD7c6cagkyoqzEaud?=
 =?us-ascii?Q?K9EcVo2KdXzR0ex3TGjFPJ6E3si6hVYMKx7Xe6PMLWQceQh/x4sqaS0i8/66?=
 =?us-ascii?Q?F3ljxU/f2MGWKuYrKKtR8blv/mYoqKY1WYeYphBdLYdO8CSPS04Uf8fTx28W?=
 =?us-ascii?Q?hykSY95eOvbhx0puaXG3r9qYdL5foD+zwGHyjxcDHYn+qaQ9ulxibLroSVpr?=
 =?us-ascii?Q?Qq3Bs/jVyTcgQveD0V0q15WvotfV0dc/HXteLk9dYWSpoxi2Ti4HzZJld8Yt?=
 =?us-ascii?Q?9MG5SbTjJDyJczg9Ipfyz2KQ4GyAxXAXxLznly9qAEQHhH8NJAInEXfpnAQc?=
 =?us-ascii?Q?Dd9QLRNrz+EmW3HeYHLzEUICbuCtunlqoAPWRT+tZnwTnTBkISr8ILRB6Cgr?=
 =?us-ascii?Q?dO4TzHauzyFfzNXbZTd7MB7RX1C34syTbR5wOgaycM+7HTdvXIn5AiyPFn2Y?=
 =?us-ascii?Q?dfgpg00+Bqx1nMPqChVXZWK58QV1gYy21f6lvmmEoj/4+mjRm7vbJnh6k/qP?=
 =?us-ascii?Q?0OSDVniX0SPyoY9lVej/eWdTXiMg3rCQyRP0st5gmIR5W1PZUR1IyFJP3U67?=
 =?us-ascii?Q?FbXp5ZQynIrkxkSiFCvFWywRL9v2WZw1eC7vugr5vN31RK+n5aWZUFiyz/RY?=
 =?us-ascii?Q?QOj9XEm2abLsVheGYswfvOHKZJL7HnZm4cShGtc4hxzy8QkfIbA69fx8ySqi?=
 =?us-ascii?Q?4KIQFn/+vkyTaHMWKLYhgEBfEuGg9Gncjv9WyfRCC9SbAh1tAjgDwou5w/uk?=
 =?us-ascii?Q?XPBcm9h5pJk3Ffe92CAxjwVBlcpQ8PXpBLLn0IRvkbqWRl4vSZ0uQy52+a47?=
 =?us-ascii?Q?eOEkgefzdTKdwLyvqMA4EjF1zWKCRcmI458SvXnzlOhEgITCKwpC/2qpgE1a?=
 =?us-ascii?Q?yuVdKhMz0W0oOxN0TFSEkiQKYF4ZpayUlA9Rw0shUF2JrV+8TiQK65MXxgmd?=
 =?us-ascii?Q?1w5fvTGOjAA4hMBplHI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e3f33bfb-cc82-472e-d9c3-08de12c54db8
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 06:19:35.8269 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8VDVIaXB3SYqh80gWpaZteI1IIaA5Elv365K0PRuVkTRlLrKDU/iOtnrYSyoBL09
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7478
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

From: Vanshika Shukla <vanshika.shukla@nxp.com>

This patch correct the cleanup order of PCD and
FMan handles to prevent resource leaks reported by
coverity tool.

Coverity issue: 362787
Fixes: 4defbc8cbb6d ("net/dpaa: support FMCless mode")
Cc: sachin.saxena@nxp.com
Cc: stable@dpdk.org

Signed-off-by: Vanshika Shukla <vanshika.shukla@nxp.com>
---
 drivers/net/dpaa/dpaa_flow.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/dpaa/dpaa_flow.c b/drivers/net/dpaa/dpaa_flow.c
index 2a22b23c8f..417b9b6fbb 100644
--- a/drivers/net/dpaa/dpaa_flow.c
+++ b/drivers/net/dpaa/dpaa_flow.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2017-2019,2021-2024 NXP
+ * Copyright 2017-2019,2021-2025 NXP
  */
 
 /* System headers */
@@ -889,9 +889,9 @@ int dpaa_fm_init(void)
 	/* FM PCD Enable */
 	ret = fm_pcd_enable(pcd_handle);
 	if (ret) {
-		fm_close(fman_handle);
-		fm_pcd_close(pcd_handle);
 		DPAA_PMD_ERR("fm_pcd_enable: Failed");
+		fm_pcd_close(pcd_handle);
+		fm_close(fman_handle);
 		return -1;
 	}
 
-- 
2.25.1

