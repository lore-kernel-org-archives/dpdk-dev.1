Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECB10C83013
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 09:52:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9EBCB40DD1;
	Wed,  2 Jul 2025 11:52:05 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010060.outbound.protection.outlook.com [52.101.84.60])
 by mails.dpdk.org (Postfix) with ESMTP id 4F9DF40B8C;
 Wed,  2 Jul 2025 11:52:03 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Pnett/BV2NgxBhQMD3Pdl4+dihwRkTsUlsVYuCjlUOh0DHkTp64sZQUQzAY5WKkty7z8kwL5ypVayVtITtCcOFm/2hgf7mw6JVOz4xcRPJSPxtBgexdZDrSDwDbvytd7wYn5QHyRfliSzpc1gnxrVby0FzxhZfovfm/R44kY122iIovGqXFa3CGzGfGJ1JrcqqQfrTl+GXITsp/D5VG/VU52L/t9wCwLIl2ehj4UHULoPwK+tdtBerW/2/hJj712oS0xYxlx9N9J2pNLfrExXq0SPMdR+LlPJGNjL2gplJF/phyxJoDmiJzQ4aXn7S3gopwGdwsQJJA2ZbeguBoItg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVHq0TNIaGRq5TS3Hr28WJnHZgl9Sa9uOIZQWoEGCMc=;
 b=jWTNtcP2hnGeBteH7PuhPq4KyN0ZnvhB8KlZI6KhO3+zZj5yQ90lPY2CT8MLMITVijpj/Q/BzyhwQfR4QbVFf1Zr6AGUcKSyuC8tLQO58JC8JOmrBgHXCdhFQ98mtuLMqR55XJGwXOZYqTbnEY0odcdtOpxTuUiINN4u5yM/uWmUKdtsQyz0uJ2fhqu16mBCt5jAhC8woFPFPj3puY2R9TvJBm8Q2q+7Mo5ekMNpR3z3wdPwiYT/rbFzvuEPGKUx23X5CjAkfpmbuVt2CsJ1m38tp4htYcRH7IR/NEmW/yN5mHAgl0Rxck5HFwppe4OVOjQy1yfzi9pAcgxreI7Yfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVHq0TNIaGRq5TS3Hr28WJnHZgl9Sa9uOIZQWoEGCMc=;
 b=m8DTnhCnojaclqTanzVNLxp59n2UVkNw9YmLAiMvLjsDx8waDDzsYbo8Sww83M9KQoCyRoYl42fvNfUh2chHZ7jVgsswJ7GjyiiHsTNOcapH/7uq42ZLCSkCZUpAGPEK/PnQxjUTNZ/zRD+Q/ENAxMqOrhO9gMcH9nBsjcUnh0kEJDoCKu3fQbgTPVJY54SKp8IxWGfOx/fIII395ZqYiHg3wGjwA65Gfi1Gf4Pt0yzndBdm8PxP9r+A0bQfx9i9MG/sXsqos90ugZkhEi5Lf/EGKEHge1QKzT/HzgCuHeV/q7ZeOCF+qtI3WVn9zDneVEznjht0lxbGQXzcNnTfHA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by PAXPR04MB8473.eurprd04.prod.outlook.com (2603:10a6:102:1dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 09:52:02 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 09:52:02 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: stable@dpdk.org
Subject: [PATCH v8 2/5] net/dpaa2: fix shaper rate
Date: Wed,  2 Jul 2025 15:21:41 +0530
Message-Id: <20250702095144.3087250-3-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250702095144.3087250-1-g.singh@nxp.com>
References: <20250701042917.3000355-1-g.singh@nxp.com>
 <20250702095144.3087250-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::13) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|PAXPR04MB8473:EE_
X-MS-Office365-Filtering-Correlation-Id: 82e4ee58-d066-4ce9-910d-08ddb94e182d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8gXyCCo1II7wF0edCjZMMMZKpEHLuVO7VCkezPkZ/aLBLrUmbvwJLbBsTd0k?=
 =?us-ascii?Q?KZIwTMYRD3Ag+EfMSQ1ZRUVl9IrfK1u/4JAM5Ey1xqh6Tq+hsxI3m2zOMwnU?=
 =?us-ascii?Q?zEp5Vvs84HX48Tm3pw6vuslH4vKatwlIK+t3JiqVHdlJ1sU+I5sm84rh2pJb?=
 =?us-ascii?Q?ePqYXQbYiAULiR2Sk5P3NsVJAwDAXszSwgmJwXtGNzWOuhzKay1at/p9dBVS?=
 =?us-ascii?Q?YnNnSKC6nVCZejMbL0ym2GFygJVrUZcwQaPdgQQeK12ImjbIhGpPTxuKgoQ4?=
 =?us-ascii?Q?9PsxeSknOHPQ6H8sfjcNqCUOHldBRNCHIHwkZKBsDDoCGPBSJ7sGZvL1P6og?=
 =?us-ascii?Q?dPQ6w7EzaLk1eJ9/uk3ZX+XrsxTEGosOK6UpA0jGTiBoEgsv4M+pYxHdE5MK?=
 =?us-ascii?Q?9kbzI7GEqVooeVlA58+UsoKANh149Seiab22d9aVWqQKdpZorhofhDE4NYxR?=
 =?us-ascii?Q?SaGQTInQML180/NU+CAq+PlIrEsUs8T3EC1eO+Mxayi77M4uxfT92Ey/9osr?=
 =?us-ascii?Q?NLCdIzBr6W9vCc11S0C3a+mD5LxfaSRzsNUKnzhUy7kNaWIJWouBxU7z9MYx?=
 =?us-ascii?Q?kLzHlpnR0xE5Za7RnYkwJS3J7UFnH7LHoY+qvEkpnH7E1C6gwr++Z4JV2vNT?=
 =?us-ascii?Q?MvWDUYJ8ogGSuqw/l9P3JCx4692jtO6oFZjvkdHxSlVkaAqTFXPhbTXDdwkk?=
 =?us-ascii?Q?fv/oLcgcKXDiG3rJ9NP11ar8KoMaQRxdAS5kOJ5r61JguPoSY1kEN2fM5GJ7?=
 =?us-ascii?Q?B4xKy9Ro+R/43Hl8ggL+r3zBUP1CGehlp2dRAz6+jrvQl24UEzQKkElePQ3S?=
 =?us-ascii?Q?aqRMUBD908xAroPPD5IyK/RfbJAwgPs8vWeLF7NwABac9T6d4iqJuzWkNbfE?=
 =?us-ascii?Q?m90GEJiP0fpp82moicX8oxWOiTFgGaobfNSW631nJq9VM6vAs139MvHCbBzO?=
 =?us-ascii?Q?P6uy2u23sMiR8oJ7H/maXPr8/042oVipAcOmphEsceAjrOfVOm4ypIJj7NtU?=
 =?us-ascii?Q?cSx94tHlS5MJrjPi78npEAYmkgptIM4j324AoDhD5x+K+aIBKRSoxHnSzgzp?=
 =?us-ascii?Q?Ca5WdC4U+CFSvItKcR+6IIWxBm0xhmpCDdTywvtQ4kzov/+XoCcrsFpd2SVP?=
 =?us-ascii?Q?ZdsDBFDcK3Hh9JOyT3rerNRia0d1kMU/sATZjdnrcBtwAYR3jrG4c1josNHf?=
 =?us-ascii?Q?oxQYHTf5blERwZNTdcB+fNaonSLaK7jOE382wbGalR6JYwPR4tCjx3b19m/t?=
 =?us-ascii?Q?3y5Ez+16QX21oHZ9XhlKKlbEF7plcykdi5NEDpYvcxU4OzScd8kK87t7RuJz?=
 =?us-ascii?Q?g7AOAnqqx/ZA+cGnZamAVEXjRiCbBL2L8s6cwOv5DN//UIYJz3B1tJKEX3uz?=
 =?us-ascii?Q?zEEvqpWwgyWh6GIv6ch5Ruxy5KqQKKefL318Y/B3FQJmyAPhYNo8Dis5532Y?=
 =?us-ascii?Q?7ZSCFinvTHxnnkHpBzubaHF1G45LC5eV9LHy6Eho0mfHdM6RXuFL078bV70c?=
 =?us-ascii?Q?VdThMJFCPYhJ2xQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?whD+kq3RgQPzYiDCWBJxqYAVJ9CrEo0kW76QTx86cZSB7fuLLT8hhkksL9V0?=
 =?us-ascii?Q?PacmsPpG5FcwyRpX8+XCx4HWpc/QhbdXAipYscGNoj0zxbCCSLoCHalLcByi?=
 =?us-ascii?Q?NDOnbDbW+TNooPZUw0NVb78LrsJhWjdixQr7ipJaSwi/uSiJ0ayyHIRSuroq?=
 =?us-ascii?Q?ZQex53QcehDTOFr5AVS/DiPH9/GehgR3Ka9T0Afy0/9LYbwmQdnuXKD3ZbGR?=
 =?us-ascii?Q?x9JNXA9IRKpSGEqNhGZHUqZKbemEnQxGRZBKhX6brURaCz4IuplH8h16BB46?=
 =?us-ascii?Q?VOEHru0SYxAxgNwMMHf9yc7B+5NmxfLWoy2wXzuGoi4SEsdJKa0nzvxQLJVN?=
 =?us-ascii?Q?zjT18Fgm5YxJR8xQbpK6iKVqMUik3VgBKhp2AtyMFgW3/sD+p2xJcXLlWSqa?=
 =?us-ascii?Q?t9GDgLU5Q0ehH7XYJgW3s/Lc2yCJDSYIq+g+3hrBIt99kPZKLEDZLOWbpbo8?=
 =?us-ascii?Q?iTzPJkY6aMq4Lnpcoz3gSHgtvGd3cOJ0GgAeXIkH8TTLJ9FXVSQBjCtOeMWB?=
 =?us-ascii?Q?iq3nRzynyk7/5dTVL7sHn1BxljpYGP35C/yAdqyPcFFaQESm2jysStngcgAu?=
 =?us-ascii?Q?Z0Q+dpTo9gWHVErkjsPT10PyNalUCU57vhCbG8lQdPoGJjYkK9YuNDyBBDpo?=
 =?us-ascii?Q?KzhLsrcGXKLzD+BxRG1HrUiH+MyqRR+DACdW2yjFd0Xs94c8gPpkmsEwrarV?=
 =?us-ascii?Q?xNx44CEbUXn07sfPFsBCd2w2q0L8EPp21CkQTbEVgphcWnLLgeVAVUnh1Jxu?=
 =?us-ascii?Q?rWfxhdrHUmK8p2CkQy1R8TzaFjFtBKFAWePvSpdK34CLedtQEiJtP29FD6h4?=
 =?us-ascii?Q?eZ5SRZbDDsvSblSd9N8YhM86m1OsqcFDBsx2Kf4G+7Vy/wGYLphIcdC3tJZ1?=
 =?us-ascii?Q?2WoBOZT4/0gCmd8jOaKhQjl52TpQWYnhlF9Azf/xyclo2hCuuGp8T3k2pKL9?=
 =?us-ascii?Q?rTy0RQJfNiZ7LtWzlgCpif1erm2M4E6sq6WYcWZaqS9dVLaan93FM72YKv3E?=
 =?us-ascii?Q?aw5m9ZY7izzBjLiDBRHcFwYOcMiUH9N/mJKyMA6NGTE1oJZZi9wYW9NH0mGU?=
 =?us-ascii?Q?vPsban/BH1cqICvOEv6u38wLzvHhLzRgG8O4TnV2HuXBAS7aVE1IGv9Wf3gY?=
 =?us-ascii?Q?qIMesHP51mPXD7XvMjl43kfDswJcsBXx/Od5hEJZ/kN61s7UN0/fBMdyVFIb?=
 =?us-ascii?Q?5Oa/zjDrHgqKd1CQVt4/Bta68geUaS/0feflG0vco3n/GDg0m3jE18cCu58e?=
 =?us-ascii?Q?5scUvyrnSgRhpq9fr1nCaQhuuHY9ZjqoeiQlVXH7nNQ06LmRjV0KAnLCpzUs?=
 =?us-ascii?Q?WyA73CRdyWuTs7xbWLVADm986zG7psP1XEFppiNZ9Q/mGblc67PrE/08zFeK?=
 =?us-ascii?Q?0ld9opr1Lu8EygCRsBHg31K+RXzqRdA4McfkClGO0HYmmuTfpqi4D/Ns3Qu0?=
 =?us-ascii?Q?DTySwdYiBgw0j0DaA9oc04sq5U/OJE+9CRHAWofv9TnChug3514pgGMHMD6Z?=
 =?us-ascii?Q?DqojwHBUGUjq6MfdXFJ/asWYDSFYsHtVMcMokxqwO0NCnvwfKYwQTv0albwq?=
 =?us-ascii?Q?4JVNaSwu9RTMg0t9138=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82e4ee58-d066-4ce9-910d-08ddb94e182d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 09:52:02.3590 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8BY/rZsyFee1fdWvleDTVoZXzovM3Iq/cvfgmsRXB/feY1ooWGho2AMJtc73YON0
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8473
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

This patch fixes the shaper rate by configuring the
user given rate in bytes. Earlier driver was considering
the user given rate value in bits.

Fixes: ac624068ee25 ("net/dpaa2: support traffic management")
Cc: stable@dpdk.org

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/net/dpaa2/dpaa2_tm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_tm.c b/drivers/net/dpaa2/dpaa2_tm.c
index f91392b092..dbf66c756e 100644
--- a/drivers/net/dpaa2/dpaa2_tm.c
+++ b/drivers/net/dpaa2/dpaa2_tm.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2020-2023 NXP
+ * Copyright 2020-2024 NXP
  */
 
 #include <rte_ethdev.h>
@@ -733,12 +733,12 @@ dpaa2_hierarchy_commit(struct rte_eth_dev *dev, int clear_on_fail,
 			tx_cr_shaper.max_burst_size =
 				node->profile->params.committed.size;
 			tx_cr_shaper.rate_limit =
-				node->profile->params.committed.rate /
-				(1024 * 1024);
+				(node->profile->params.committed.rate /
+				(1024 * 1024)) * 8;
 			tx_er_shaper.max_burst_size =
 				node->profile->params.peak.size;
 			tx_er_shaper.rate_limit =
-				node->profile->params.peak.rate / (1024 * 1024);
+				(node->profile->params.peak.rate / (1024 * 1024)) * 8;
 			/* root node */
 			if (node->parent == NULL) {
 				DPAA2_PMD_DEBUG("LNI S.rate = %u, burst =%u",
-- 
2.25.1

