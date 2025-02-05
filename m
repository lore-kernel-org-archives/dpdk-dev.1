Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBAE4C02192
	for <dpdk-dev@archiver.kernel.org>; Wed,  5 Feb 2025 10:49:12 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6213040E0B;
	Wed,  5 Feb 2025 11:46:39 +0100 (CET)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 914A340A81
 for <dev@dpdk.org>; Wed,  5 Feb 2025 11:46:27 +0100 (CET)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2112.outbound.protection.outlook.com [104.47.17.112]) by
 mx-outbound9-60.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 05 Feb 2025 10:46:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=YWeDHBHx2T4YYaFW/g/Frs7qD1e0XohDaee9T7z72svzR5DD4qiZ9msyn2OLiLIjd9wdiLJHcqx4wLpeMhcBo/UCOVbdBseZ15eSLqLPstpcHUfpJ6VOuEyBUm2TzE3XUiDSpH9rDOiwLkx9QyFw4eL61KXLGnFb9iBr8ZGipbY5+10qgDD6y00eZKDhrXjYch5dhHObAX2iSoXhn50BPkX6Ahx7Z3bLROryEHYhjpo7niQiYbAUQBGS0vc+TGMYfncUj5DmpkCtz00YPProgR1off7Rl0NFLK1iuc/zDZXJ6ekUoDcZ+0RkaLT6ezboahMdvTXLKZKPR1e30D8cQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ninvcje7NCJK7kbxaiLbrH4XiZqYbSgzSSYQcmHhgEw=;
 b=wIg7pyjwExIVeG04UhAkNDSPr394ccOd7g+JCUOU705MFsFdyBdBD4XEqxsY9A+99LJH3DS7hFlm8PFSbzOStgt4S3WGh4lt75AX5Qp/53fynTFBHI4K4ayafbhFNN8M+mITC+c2EdAV6lRWY5Sg6/uRSZ3ElXSMjEprVaF2Dz0bwyvzsORx3rWXc4MUlkPhOUnfuWrstdIaYkPAGgBhQXW202bTBPKzgnZfF1KKdWZHph7J+LJzQsIX6qh6TolAxcqRZF9pD752GF5T0kIITMIXX+tYnx2H+EUDest2VkW4Lr7Ls+i6DBMSRZ5b4mN5i4zLNyWg/Y3AEv7CKqnBsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ninvcje7NCJK7kbxaiLbrH4XiZqYbSgzSSYQcmHhgEw=;
 b=m9UJY/DrKrpImrpgxYzqpRDVgwd6PFkzd3VK3AXHiisabCIxkKhwBnvtZKAwfrTktYOFc+maqHSgz1VscRrQMipQvi08yJMFu7xL17qi9YnyLsdo2z3Aj5nfyWdP/gLr9muQxqo/euIFtgRWzdyjhAjF8BE3g/ZgytmYFw3lLCE=
Received: from CWLP265CA0347.GBRP265.PROD.OUTLOOK.COM (2603:10a6:401:5a::23)
 by GVXP190MB2148.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:1db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8422.12; Wed, 5 Feb
 2025 10:46:22 +0000
Received: from AMS0EPF000001A5.eurprd05.prod.outlook.com
 (2603:10a6:401:5a:cafe::ac) by CWLP265CA0347.outlook.office365.com
 (2603:10a6:401:5a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8398.24 via Frontend Transport; Wed,
 5 Feb 2025 10:46:22 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF000001A5.mail.protection.outlook.com (10.167.16.232) with Microsoft
 SMTP Server id 15.20.8398.14 via Frontend Transport; Wed, 5 Feb 2025 10:46:22
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v2 29/34] net/ntnic: extend module mapping
Date: Wed,  5 Feb 2025 11:45:38 +0100
Message-ID: <20250205104548.1533554-30-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250205104548.1533554-1-sil-plv@napatech.com>
References: <20250121170814.3252171-2-sil-plv@napatech.com>
 <20250205104548.1533554-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A5:EE_|GVXP190MB2148:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: ec93a6fb-49ec-49c4-57ba-08dd45d254cf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?k+C5vVATu+9n851+wN7IzlBtiPhHWVdQQnD6be56F9bRjjPU7TZEwWHx3bnk?=
 =?us-ascii?Q?8BBa3MANevV1wsKO6QseNn4bVP/5qoK1iPEIoYTZrbdA34H3svbpyjwD8WQi?=
 =?us-ascii?Q?4F/59N7It2J8A+X3vmwzwmDAeWJpDoqdSvMnvzu+BK/jTRYqV/yH44Yjmad7?=
 =?us-ascii?Q?QQQyicEnAxb5Te8Gja5EnRvgJG2gHuWfMAXk4SBetmW/yMOXDlRbkLh0aKaV?=
 =?us-ascii?Q?SB1U0bSJd7VRKiJB/ObcaxBAvQbGqv/kW/f6LDzHiJcYa6LYNMlC4l45eqc3?=
 =?us-ascii?Q?6EnB66Ox21GPdHTmVo4vprO8u1yu46H9qoDOyr4IvobJhTyCb4PwlGUZ3g8k?=
 =?us-ascii?Q?uO+epQ1zqQOOXFX6gLnJyJ1M2/J9/BI3D+aCJ7UeXyGsZveI5Cg5KDBy6U0F?=
 =?us-ascii?Q?woXAQ0esnZY5+8l7gVh+ccmPDSumCJgkznnxZ6U/vFeq8otRaUxejQI5HAYK?=
 =?us-ascii?Q?Hi8R7R/WY7/cgIspvJ8qX/20rayjv3pD127bm86DT9zSo/LwX0hzxC+GMEpP?=
 =?us-ascii?Q?kJNgAQH1I7LfSDP0wl+3wAiEuJ2JfcZUI8q3BQENsbgpIFHb5vcBnGgN0iow?=
 =?us-ascii?Q?PQTdBL7VasYAGvWGHPwebO5Ha/YIVmViyDRi/leh3Gbweo+NZSDa5L4qR0N5?=
 =?us-ascii?Q?iibikSRBPjGQd0fbFc5oyPqAr7UO8x2JzBG1m5n5JJoJQUdbjSn83E7T9TQ9?=
 =?us-ascii?Q?AoD2xvk5oyXEaQ1p7145PXNXZTvr/MJlgza3XtM2wb/oTFnVNKqM8vYcwKw4?=
 =?us-ascii?Q?cCX8I/R25LncTAPFUoG4UF+Ek5MrgqW7XS0wE9+GjT+hflorv1JK3B73wuDy?=
 =?us-ascii?Q?G9bWfhD6sVqBs//tInYEQNGqNtRNEeHgb/VIuujbZqfYqDGnRj77K4PDybER?=
 =?us-ascii?Q?u32jwHRG0K1HY6Ia6f33dIBnNBYlqmkpiqYwu+DJZCRl5dDvU7zPMEMTXAlD?=
 =?us-ascii?Q?Mp6hfYleCs+VbGyKpNGTc0wliQuGpCZN/v1BZCcwhxTYh5t5MsVVlb1ptiZK?=
 =?us-ascii?Q?LRORiY4r8v7aIqo6n3l7o5k/77li8dunUnfQEbrsZfLIkRKtB6DTspNKYq0A?=
 =?us-ascii?Q?hA6jYPD6gF0fsZFaF7yvUSQ57X2istsL2vYkR+t69h9+qymFVLq5XXvMs8T/?=
 =?us-ascii?Q?BMuDhHdCTLslYs9JVV63LExI0ntXxxdFnLjzGdd/a3s/nwCrzf7q+Zq/d5Dj?=
 =?us-ascii?Q?7CYcf9c7Y8u2GRPy390lHED7RkjtnUOaOJ7yANvGTTYoRqW2SFVmbE7JwXX6?=
 =?us-ascii?Q?B8+h1i3Kbbutlntos+pefwd2EqcQQqfLrQcqJ4rNKHRmiUtQsQMJ4rkkZXls?=
 =?us-ascii?Q?o343HSGDjGvwlhvCYRKt4D0y1IY3PsCSBPPFtmJ8OpL3GheNJT7CAR83iYqF?=
 =?us-ascii?Q?b/p9rMZ+KaJ0JJRP6DVdTke+Dz9JQ6coHh729PuKdC/HytrYLPr1yaD3kUhE?=
 =?us-ascii?Q?P6kmedniMm11v+uEOM256w2ZToKQJYgBcJ/50I7MJBCBbRsEqBxCOa2sMWVe?=
 =?us-ascii?Q?9GHm7lhzhXt+TW8=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:da; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: sLr9y6u6hYUnswxkrgaor4dlHVEwMYjSA9Gf+O60MF2HO9XTpq7gjUaWOeMbRN7GursIShJKBhqLQ2ie6y8xkPnpXqDB3l4ZzgHhoU+7GIMeXpwnT7YS4Z63NP07XNdD98ZyBOdQF3kAbnrqqaJwmKfMs1bIxiNSeMFb3tvAxrAoWV5amghr1iPue5BMMKFL2CtTAg4W7qVt+bDP52UxSYOFNXaGj4nOslmoqagu2SzldLt7QrbOUZO+/ISNz8+DhKUwXEIpksmWVEpanwmzAKydhfXtLWHuN8faP8B3OTawLABYQBDRNdDXG0ByTyZAC4fhRMkDH9dHTErdJAp9p6d2BW30/CISaief3IV3zIIAvD7p62agrm+RnApXe2Kwv+iednGlQ2n8XDaWBbCH7ppUO/xWTDetbc5nnHF1wIs0AQtGitaYx/4QH7lsmHm9aJasCyFiurWY0d5mL7mUBjEOTTZ5iHORXp877v5yGsmF5MEOG6fcJGV1te3FPpharic/G6TRy2nq0zZ8PwNvDB1Ipg3eP8oQaj102E6G3cSWwv5Qzp3UiHkxGbF0j3emKJpRHoTpkhz8/Rh+XU/o740eOjBHDCT1y7HHabc/mc+uo5lyAcCWRZFzHM0gHIRZUBmDCZb46iqddlXubThTww==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2025 10:46:22.3551 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ec93a6fb-49ec-49c4-57ba-08dd45d254cf
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF000001A5.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXP190MB2148
X-BESS-ID: 1738752386-302364-7587-684-1
X-BESS-VER: 2019.1_20250203.2302
X-BESS-Apparent-Source-IP: 104.47.17.112
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoZmxuZAVgZQ0DLNwMQsKdHc3C
 LRwMDQ3NLIMskoNSXJJCXR3NTCwsxAqTYWAH7jnXRBAAAA
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262304 [from 
 cloudscan21-135.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
 0.50 BSF_RULE7568M          META: Custom Rule 7568M 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_RULE7568M
X-BESS-BRTS-Status: 1
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

FPGA module mapping(to string) was extended with new fpga's modules.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 .../nthw/supported/nthw_fpga_mod_str_map.c    | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/net/ntnic/nthw/supported/nthw_fpga_mod_str_map.c b/drivers/net/ntnic/nthw/supported/nthw_fpga_mod_str_map.c
index e8ed7faf0d..459cc724c2 100644
--- a/drivers/net/ntnic/nthw/supported/nthw_fpga_mod_str_map.c
+++ b/drivers/net/ntnic/nthw/supported/nthw_fpga_mod_str_map.c
@@ -6,20 +6,44 @@
 
 #include "nthw_fpga_mod_str_map.h"
 const struct nthw_fpga_mod_str_s sa_nthw_fpga_mod_str_map[] = {
+	{ MOD_CAT, "CAT" },
+	{ MOD_CPY, "CPY" },
+	{ MOD_CSU, "CSU" },
+	{ MOD_DBS, "DBS" },
+	{ MOD_FLM, "FLM" },
 	{ MOD_GFG, "GFG" },
 	{ MOD_GMF, "GMF" },
 	{ MOD_GPIO_PHY, "GPIO_PHY" },
+	{ MOD_HFU, "HFU" },
 	{ MOD_HIF, "HIF" },
+	{ MOD_HSH, "HSH" },
 	{ MOD_I2CM, "I2CM" },
+	{ MOD_IFR, "IFR" },
 	{ MOD_IIC, "IIC" },
+	{ MOD_INS, "INS" },
+	{ MOD_KM, "KM" },
 	{ MOD_MAC_PCS, "MAC_PCS" },
 	{ MOD_PCIE3, "PCIE3" },
+	{ MOD_MAC_RX, "MAC_RX" },
+	{ MOD_MAC_TX, "MAC_TX" },
 	{ MOD_PCI_RD_TG, "PCI_RD_TG" },
 	{ MOD_PCI_WR_TG, "PCI_WR_TG" },
+	{ MOD_PCIE3, "PCIE3" },
+	{ MOD_PDB, "PDB" },
+	{ MOD_QSL, "QSL" },
 	{ MOD_RAC, "RAC" },
+	{ MOD_RMC, "RMC" },
+	{ MOD_RPF, "RPF" },
+	{ MOD_RPL, "RPL" },
+	{ MOD_RPP_LR, "RPP_LR" },
 	{ MOD_RST9563, "RST9563" },
 	{ MOD_SDC, "SDC" },
+	{ MOD_SLC_LR, "SLC_LR" },
+	{ MOD_SLC, "SLC" },
 	{ MOD_STA, "STA" },
 	{ MOD_TSM, "TSM" },
+	{ MOD_TX_CPY, "TX_CPY" },
+	{ MOD_TX_INS, "TX_INS" },
+	{ MOD_TX_RPL, "TX_RPL" },
 	{ 0UL, NULL }
 };
-- 
2.45.0

