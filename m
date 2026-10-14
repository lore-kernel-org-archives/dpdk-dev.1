Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B37CC6B27
	for <dpdk-dev@archiver.kernel.org>; Wed, 14 Oct 2026 09:13:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B3154066C;
	Wed, 14 Oct 2026 11:13:07 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010036.outbound.protection.outlook.com [52.101.84.36])
 by mails.dpdk.org (Postfix) with ESMTP id 4C64F4042F;
 Wed, 14 Oct 2026 11:13:04 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZVZKVzNIVYhCy4QM1P6dcvc3H6QwAx2vFCB0kyH9gUEsLCngm4d+5wpJ2Mik0xN8Rywkuh67plomPbZ55waEgg4YkPr0K7pQL+bM+j6lup2vdh14+eqxVVNoR/8hAQsmKFLABoF6NFlOjKqaOFEFQzTb6m1QAS8336septHMDrcHWTBI59A3Wmx/TFrxnYY+rtWLfTLtzh3obb2xfkmOWg32D6lWxmw68lSsy4dxT663fCfp715ayySjXqmPjH4o0tgXldvV4g0pIHJrruJrat8eqEzViLWo2MujTey1OdZlpWa4Qt0GG9MsLi9lkZ/0AUMB7kyXs/zzYvOzfdadBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fL0QOuyhves9pDmHl3lzXfu7ORMKBHTc/ozV6FnnP30=;
 b=situbn4/soosGEL1hxr/0ly7OopACpeonQP/pUaFULA5C0MkDHh1IhkzMGXuQ7z5M7NBj6CbOUB7vbEOBHO6NAGCTyQi2Cu0qpFyBWsYO/tCNyCW/5vcMGvSIlWwr57gfTyaU96NV8W/6T2au4cVVCq35mUKxFoeLohAbAr0DGLz290mm49NJrlV0HOcvWpvk7GavjMJLKJPTItgp/I5jol350oJGCTAtGhSJicSZaW6lNErsuCJk5OTa5iy0JSb2UAEwyxoUtk0ynbw/pheSQ1HwfmN9dVnjKym11w6/ITDjNKcAhRGUOXsRZtvePcVBjVIfBVvcN91QpOlYygkeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=cisco.com smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fL0QOuyhves9pDmHl3lzXfu7ORMKBHTc/ozV6FnnP30=;
 b=GurRc1OmeJ8YMqW5LUdi4sCa3cBEBQYE+egIylI7ZHsJj7NVxLc7/dtWmYi5/SbEtvjsq8gg0d1wI73EtWFPD6QAwCbNRjBsEbmzK6AiAuGxG+Af5+TqTFCBK1cWzB+LdtWuMeEMlLh/K1ulOfnQTANdH4DOnYbbPaCuNm+AyWQZ4B1Ki1+iUS3HX/e8EdVya8xkBtcrWC5DHVm2h6e1bvDykpuHK0wM6XNvmDH7Qxwb8NskjOo4s4bzt135ZTX4J8yR2zWIawmWZFGZPUNJqifCmkpo7T0D1AI+8fTJ/cR2CchyUpOY1KxTQy6Vxr6rXlkPpu3hLrXMYWLe/zyhhA==
Received: from MI0P293CA0015.ITAP293.PROD.OUTLOOK.COM (2603:10a6:290:44::8) by
 GV1PR07MB8350.eurprd07.prod.outlook.com (2603:10a6:150:1d::5) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.13; Wed, 14 Oct 2026 09:12:59 +0000
Received: from MI3PEPF00008497.eurprd03.prod.outlook.com
 (2603:10a6:290:44:cafe::66) by MI0P293CA0015.outlook.office365.com
 (2603:10a6:290:44::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Wed, 14
 Oct 2026 09:12:59 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 MI3PEPF00008497.mail.protection.outlook.com (10.167.240.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 09:12:59 +0000
Received: from seliius19697.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.43; Wed, 14 Oct 2026 11:12:58 +0200
Received: from seliiuvd10563.seli.gic.ericsson.se
 (seliiuvd10563.seli.gic.ericsson.se [10.120.141.220])
 by seliius19697.seli.gic.ericsson.se (Postfix) with ESMTP id D98BE4020B41;
 Wed, 14 Oct 2026 11:12:57 +0200 (CEST)
Received: by seliiuvd10563.seli.gic.ericsson.se (Postfix, from userid 93258)
 id A2868617B837; Wed, 14 Oct 2026 11:12:57 +0200 (CEST)
From: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
To: <dev@dpdk.org>
CC: Stephen Hemminger <stephen@networkplumber.org>, Sriram Yagnaraman
 <sriram.yagnaraman@ericsson.com>, Jakub Grajciar <jgrajcia@cisco.com>,
 <stable@dpdk.org>
Subject: [PATCH 1/6] net/memif: guard against empty Tx burst
Date: Wed, 14 Oct 2026 11:12:52 +0200
Message-ID: <20261014091257.1051190-2-sriram.yagnaraman@ericsson.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261014091257.1051190-1-sriram.yagnaraman@ericsson.com>
References: <20261014091257.1051190-1-sriram.yagnaraman@ericsson.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008497:EE_|GV1PR07MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: ef7cbd79-d461-4332-9c32-08df29d35789
X-SMTP-Server: smtp-central.internal.ericsson.com
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|36860700016|376014|1800799024|22082099003|18002099003|10067099003|11063799006|261009223027099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info: HaXHLaWkzARHjxs6g7AG8NZEKbCKDA253Y/O12lO8VbnOT6Q3V7zgTaKy81h2FI03oTjsQsYzl0k8QKhsfs2o1syThgonSFTiBTJU05e+12jlqnrds4MxTPo/PxYXe+p41GmJAw1cAzoS2BSvAanPsujoxW6w9qmx/b5Xq5vFq54W0DpTGC7hGPJiVwq8ybwLOoe0hpwm+Jp9V/kr6H8z5zqYDzjhXHTm8gkes/RW7N42nSoMzezrvWaoDEGWfBXUdOxrwBFKFZYPvnaGPrmwDLBdaQmbPKmbmjdIyuHjdu6Zr6vE/ixdlO6mhHFauoeWQUC0Z4qxi87hqu90VQLUSz32YjSciie70RTGFuHA1qM5HUfFo76FbFBN2/+h+oTp1RFeoTogMLi6awUAL2vV//cyIXf6nwD6B8BrZP9b+Ggt1BFS+4VA9j1Axy/5j5CK5IktleSFVcmngGOvl6fWJ9ueuKXaMN9f/7DPxuknZh6He/N3skW9zHD7jCeAhpQB7tDAcYTV36Y/SehgY/MBO9ITZ1yskcYdqPZO2vZHQ/JKjo4YcU8snNMyPci8jYpmGG71FJ5GQw9ZeYeO4VRWDj5rUTtr/A6Ui+qMm3+/G90elQzbnqJmQeTFfgQkfr2ltVG2V0D7J0l5LXrmZCn1nLPVIaK6SWUCBcgr4GVroKHUriJExSRsw2bT7J6vUYc+PQdYty1kIL0Ab5Zl+uIfA==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(10067099003)(11063799006)(261009223027099003)(5023799004)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Oqn88ZUCd+rqobXsgCJ3BDFVAB3tMONRjBEBC/FEu5489TaJVyv/hG9W0u3XOQw32bvw+2s/tHab12UvUKfk/clQuoV9STxn1gCAvSFqSr5gy+Y+RDinMtH16bMtm7kHSFxry+hUroi22VuNQtwGtWobxQfoKYU28RTcTHWKkej1mcbPua8wwRfu+CYSzErX7kuUrMJYBUCDz/glYkFeuXdEYTMuxnjYVr3BJBOAQ1MnPNTN9Hf7ZQlkt1NUzLp7RHlDvlKQXY5ru0zqzwGazHgHDV4ABQO1MM2LITU23cuK//XzE4gFXUkm2CqpH9/2jijSSqOfS1ZBk+p3k6eU6GYAdtr+VNasRbN+14Y8at/r4U57jM820LDtcqpkuUcy3NaHI3CnwyJ2hzq696xnxwR5XjStH5+AmWGzdo3CwoiqcotUhcAzbbmTgU4T5OCz
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 09:12:59.2500 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef7cbd79-d461-4332-9c32-08df29d35789
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: MI3PEPF00008497.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR07MB8350
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

eth_memif_tx() reads bufs[0]->pool before any check on nb_pkts, to pick
the mempool for its fast-path single-pool test. A caller that passes
nb_pkts == 0 therefore dereferences bufs[0], which is out of bounds for
an empty burst. Return early when there is nothing to transmit.

Fixes: 09c7e63a71f9 ("net/memif: introduce memory interface PMD")
Cc: stable@dpdk.org

Signed-off-by: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
---
 drivers/net/memif/rte_eth_memif.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/memif/rte_eth_memif.c b/drivers/net/memif/rte_eth_memif.c
index 2d42338e48..5e28db782d 100644
--- a/drivers/net/memif/rte_eth_memif.c
+++ b/drivers/net/memif/rte_eth_memif.c
@@ -894,6 +894,8 @@ eth_memif_tx(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 
 	if (unlikely((pmd->flags & ETH_MEMIF_FLAG_CONNECTED) == 0))
 		return 0;
+	if (unlikely(nb_pkts == 0))
+		return 0;
 	if (unlikely(ring == NULL)) {
 		int ret;
 
-- 
2.43.7

