Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 482C8C28B30
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Mar 2025 08:15:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F3C3A402C4;
	Thu, 20 Mar 2025 09:15:23 +0100 (CET)
Received: from APC01-TYZ-obe.outbound.protection.outlook.com
 (mail-tyzapc01on2122.outbound.protection.outlook.com [40.107.117.122])
 by mails.dpdk.org (Postfix) with ESMTP id 12259402AF;
 Thu, 20 Mar 2025 09:15:23 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XHF7CaN8ZorTbCIR/6LPLcHbceQrPQkNrwbnvf7NkQRwWXXsnOw2Ck8cvGQSBG39XzwNoyP/2BcGtOhN/vaH10nDrdeK+laCZmSDXvHgNW/yu+6IIcyQN0jLweEl53wEvxm69v/Lqely0JursGJ5MZpLyesnPEZR9K2zKlXz6INyrfJ4COKqxHIlg3Vqw2x/LO+EhFn/SzvO/C5QqW/VQDtedDk+tWy94hk2CGZtjQgBqhdeKqIwwsC/zJXtIyoxyhy+NF2y5PMC/Hq/OEu/ei1422Yh6ixoBEueJW20I8kDhE/77NGxV9dix5aPWeERjAjz8kBBFBZUfJXjmQ4umw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CejAZMbaT7o9IgLyJmggRvtpzqizj6umaTMYwL/OXt0=;
 b=RCyEPacI2UdjS6XlWYaBQUsnc1QY0WqYidVyA6n88KC+qeStGHuHxJ7mf289rh4XjT3Gwm25e+ucakIPt+JV9hMOOIgeEmDJj6HOjiAYqJUMB9twAeC5GyjS38f4QTa297Vq6qkj+D/TRb9d7uM7cMpFSKSy52HNuM4zxhnlHMAdLyRifZ6DpgSgWEGrsB+rSgDaBIlkzHussg7XNq0jienpoDQoHZHMTZ5ECaq4tBHiyXVVxwYPDCvUN2ubZPx0rwFNzPuwsAfHOtgFkHv4En3Yweyc897uNWOk6Mh8Yofq0poJp/n1QbwmfGHolpvbj5ugRhskq0+2Xx6kqSbH5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CejAZMbaT7o9IgLyJmggRvtpzqizj6umaTMYwL/OXt0=;
 b=qjp/GF2ZWZsZK/qDsZfZoqfD7TI67/SVDAuMkmZaVETDrmc1Z7AaM+Zr9cQXRn8dXx4Z6PFH4pOxI0ytl8UtunLdSDUj6ty24m+XCN7ZZyUUUAn/H3w6+WIAdMuO9m/OY+IxloyBAPUWcjY+YFxdMo33T6XI/6Cu8f1hzHqWi7OuKYYilO7QTmhHXC2171sPtkOZk21uKyAZ/IquBcXA5ztoLPskHAAHTgsKs/nGvRJBYufxPpHOPycvc1qC0S2dxc83UsCSM/zGxZ7TcZJpPG+Yj1JuMWQGXJhoFnAnIfaOKxN2JX1gRVpwTXfURGqE+kBW1ZP7uE/XWSI55PeFkg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SI2PR06MB4234.apcprd06.prod.outlook.com (2603:1096:4:15c::13)
 by SG2PR06MB5238.apcprd06.prod.outlook.com (2603:1096:4:1d8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8534.34; Thu, 20 Mar
 2025 08:15:19 +0000
Received: from SI2PR06MB4234.apcprd06.prod.outlook.com
 ([fe80::7c6b:7e04:5448:4be4]) by SI2PR06MB4234.apcprd06.prod.outlook.com
 ([fe80::7c6b:7e04:5448:4be4%6]) with mapi id 15.20.8534.034; Thu, 20 Mar 2025
 08:15:19 +0000
From: Shaokai Zhang <felix.zhang@jaguarmicro.com>
To: dev@dpdk.org
Cc: linville@tuxdriver.com, stable@dpdk.org,
 Joey Xing <joey.xing@jaguarmicro.com>
Subject: [PATCH] net/af_packet: register supported param fanout mode
Date: Thu, 20 Mar 2025 16:15:03 +0800
Message-ID: <20250320081503.5505-1-felix.zhang@jaguarmicro.com>
X-Mailer: git-send-email 2.47.1.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0170.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::26) To SI2PR06MB4234.apcprd06.prod.outlook.com
 (2603:1096:4:15c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB4234:EE_|SG2PR06MB5238:EE_
X-MS-Office365-Filtering-Correlation-Id: 7106e8a7-758b-4fd0-2203-08dd67875a17
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Zs1+jzcvTJeBeFEaHPnNVPN6X40CqxRqadI3UMxvyslOzawPwMenl+YRqv9B?=
 =?us-ascii?Q?2dRDTmvx35YybMM/gSEu4ayZZQuy+FWOQX0qWJW8vd8xG+UXEIZ2qct1Wv5z?=
 =?us-ascii?Q?r0eW4e+kquonIp5wQTwPAkFd8l3OMTVSBJDbSIiuVJim0H+8lEjDIGzoLEVu?=
 =?us-ascii?Q?NVzhHiG0ESazAQq1jJpqvIxAf7So4aA5jzroQgkcoXxyOVlwPviUJJKT+mSl?=
 =?us-ascii?Q?gMN6W9hqfOlqseEwKbSfuycp8w0bLNO5H8T7hfS2X/jWIfdCXopjZQKEZw2x?=
 =?us-ascii?Q?SelabXaoYE01xVvR789DHZaz2KuJX/ZViix7OQWZyoVciuz6iv65Rc5aMsD3?=
 =?us-ascii?Q?1arxYcnTGAOXs8OCVvCs3jYPlszduRrsk0MlWXrTzS+pTtF/f6R6rSZZWxkF?=
 =?us-ascii?Q?1bKSBB3N9zJl0p4YTPFogrmthAvnLCC/3E0oHODmBauF2jK17HqF7CIfL8LJ?=
 =?us-ascii?Q?VpHtl5Ancolfp1hrprOcfrbSut4H8m7grFc2YomqGkyTimgdNzRbXSi+Opk2?=
 =?us-ascii?Q?GydORbbu610ko1BII3M5WVwX/WjRgFAjvd9iHyoLJfGVovfT83xIy9Bs8dlZ?=
 =?us-ascii?Q?+rZKyRkHLMNWNi/lJg8I/kMiI6t6PMSGzdvh+3TrVpQTa5R2uU/3AbtIK1KS?=
 =?us-ascii?Q?0Yf1hFYhqwt7r7pntGeycXjD61NdXAWvZb5lZyjjPt5pR7r3dbk+yFTCcKOp?=
 =?us-ascii?Q?jI0hRoaGlGt//1nmHmUcOzONNHryTQOULAsob+Zti5GH0ULV08EiKMEtThez?=
 =?us-ascii?Q?dk/3pzZ9hNzAcDlyLofTtY5ezWdRfgxtIta3G7dYXvSEiwOiA6f/Kzt2lBEf?=
 =?us-ascii?Q?oacWv957ph7lMyaHtIuq6Diqm3NlwWxf4+XKv/A3rY1BN4w3hswPkrAtT95h?=
 =?us-ascii?Q?iHBPbYs6xk0EirfRCLj/IgU3KnpLI6foDHw0/UqdOQzs8J/FX9whxaWr/H4n?=
 =?us-ascii?Q?9UJAXg/ZTTMxOvfuDLYsyYpJ9UcHzDf1GixzgdmEnja2c+6n6YNU7leBLLRs?=
 =?us-ascii?Q?AkxMyr84MIZ2TmIostNkExXLChTBCXs5D5w2mHymxJ2Hrob2DDGYiLf0KVm3?=
 =?us-ascii?Q?CUSPvz0jY+T1X0UHKyGVhKQoR8+4fDFpuaeeI6R7k4t4qxmaALJ452ZB66Mj?=
 =?us-ascii?Q?vuW50zsyl6Rf1ZyxLCtk48QFJpXoWTttX/RphfHkHbJx/DO2PJEdmgZNrFrn?=
 =?us-ascii?Q?6Fz5ZV1R5omNTVS8smCUUHpaNyVbnOqKOdtJjSiWUnT06m/aY5CdxBeZZqbZ?=
 =?us-ascii?Q?uL3E9UenwcLUrGoUvsg6COqSwmViKr9aqFa1NprD3SmMz0oL/dGs6oNfc4GI?=
 =?us-ascii?Q?XuaruG1GR4upJs92J++47KFdlpTO+QOitO8+t8oY6Iiib8DmnaFfFdJRumoS?=
 =?us-ascii?Q?R6V0FAOb4WsIqi5CPovYgABvhNzsQikYoyQZonqBen2xt+scTGv/51D1kBAD?=
 =?us-ascii?Q?NlTqMJkXBe3rbKTJTDjwUUROCE3dmR+y?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI2PR06MB4234.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bajQWXniExo9f0FnM0kjtX1I36MixMFpsyUXj6OjjZzkf0P9uYVQjKbdFyEb?=
 =?us-ascii?Q?DmWDScKgcTwNgsiey//c1ZMo44TTslNqtpV4R7AWU4MvNLf3gYmfmTJiyCt8?=
 =?us-ascii?Q?pjcO7QyIhqBTmnko0O9rOLWCUOCCsIn9nx7LdpKETcMtTUhhfpQEpJSyV6Z+?=
 =?us-ascii?Q?Vxb3j8Ff3NTXinoe/uFxuX5Sp8Xb9WbyD3TmXCEli8EZJC50R9UsWoymaslU?=
 =?us-ascii?Q?MAlceuSvhb1/Wnr6khclUhaBgTd/lmaVrFCR9J8xd+X5s/HsSPu0VPNzo/Iu?=
 =?us-ascii?Q?CDqD2JjlutBWnOPThC6tvM4hQcppU7gC7HDmJ4YISXuySWdNJ/ljrIzoygTM?=
 =?us-ascii?Q?P1QuQ4cXVXn5YR9Nkv4+46hQfz1j2vfinX4ZsNZwmyorT8FoSrUC6K0lR9fy?=
 =?us-ascii?Q?jzVDaBbneKsB37l7pkI6zdnIrQJ4KIGjh/1y6aYkbagXB38mo5/VNSCjSBYQ?=
 =?us-ascii?Q?h0tbhQQs2bENuuT63ijS55tm+FvrJM4uIDNSvfXHwWobuC9EvIoor/qDJwGP?=
 =?us-ascii?Q?eW0nnUUnH/UNrUuOSeDpgGcqdae6IWgM2m2jPQOyXAuBJafSmWatZfusLiIo?=
 =?us-ascii?Q?x7+/bDIDq0ZqGyozOLJIzGJ02GBBk4lbpodIZM2JjinPR21mX5csnAgtj0nl?=
 =?us-ascii?Q?b9csiAwMUM2Q6M96dQPi1ft150rHq+bwlqb3ESkbEp5jRxfs5J2j/HsGJUvy?=
 =?us-ascii?Q?5OqjvY8aHTDLgWLIX06q9ZygZe/JM5V3C5Nb6yu1fkb/P4v3ka0vT8dom1gk?=
 =?us-ascii?Q?oeLWsyPJbGTfvg6c7wbOBevuBkrJhjlTpQWWmQUe4/dqw/xAJxFglpVo3RB3?=
 =?us-ascii?Q?7UcSHiXBSu19an6iysErRBFgA92dMp7LF5y3pPSNY2f5j1dnKP6QWWTlUbjg?=
 =?us-ascii?Q?hVb7BCIee3FW2HZXg/aLxtuKkDWKaP7vSJjEvy6P1JieC4iWxLRS0ZmpiElG?=
 =?us-ascii?Q?bCGBFqqTz90gd8lpb4/lQLub07svNFUAJTe+WPYLi/bD561OX9QTJvdohgjO?=
 =?us-ascii?Q?HrMnR11nB/2l/1zo/M/rKHJYMGrWxeCJNy+OCJHG1/4VJ6B2Bp7l5OxhyHgH?=
 =?us-ascii?Q?hrd3CYig5bf6UFKv4x8fJlZsavmsJVcH5Jh5Nj/HwC3LvZT0CxM8f6I8emQU?=
 =?us-ascii?Q?DS608CKWUM6RWOZlPH/xNHRTbvTMITEKCrpsVhTBDeOrKq/xyboFrCDYqi8q?=
 =?us-ascii?Q?Ea1/s47gUDZ8hhokKOHvyrRdoUATH9o7t68ho6ftjBFdOj0FnHiFWi5GenNn?=
 =?us-ascii?Q?+rPoJ9Djnd/IN57slCBKmUCSbpFA0pNzV1kJHnjRVl/VpJbXKmf/FkaYebHb?=
 =?us-ascii?Q?5PA9le72yKdmlu9ze8xBAPSoDId8hbz7WNOwf9Q9gOoCr/8ulm5VcUVVBM/l?=
 =?us-ascii?Q?CPk8L0UX7M0PpNyGkm0A2RqBj46KtBC1frtrhZNdSMZxv7uWdlWAtUHB5pMA?=
 =?us-ascii?Q?Q55v/QhWbEqoAjH+Ys8lpwL7byRU2cNwxrvRlWDlr9XmOvK46bbM5m2I783P?=
 =?us-ascii?Q?/nmWSg5Rlbtp+LgTEjF+QquD4Q/gwUdTG/MuZVxrgVzpOxaYtb20FgH/3qyX?=
 =?us-ascii?Q?8k6dQxn7DUR80FzLAFydzuUcE3YzyL1xnMPWXZeG01wP7EnBfYGI7bNiashy?=
 =?us-ascii?Q?Pw=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7106e8a7-758b-4fd0-2203-08dd67875a17
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB4234.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2025 08:15:18.9678 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S+RxnceqYmcPN6XhZ9eEHzzteyhD3KHC4LSdBfdQbdaR6DlOFvDcJ28aFiaXBEzKTh/g/rMkPjilu1BLpzmHKMGZZQML2tDiETRNksn89HQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SG2PR06MB5238
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

Although af_packet PMD supports setting the fanout algorithm, it is not
explicitly declared during registration. Add fanout parameter registration
to facilitate users in quickly obtaining supported fanout algorithms.

Additionally, add configuration parameter printing during initialization.

Fixes: d3bc77ab05a4 ("net/af_packet: allow changing fanout mode")
Cc: stable@dpdk.org

Signed-off-by: Shaokai Zhang <felix.zhang@jaguarmicro.com>
Reviewed-by: Joey Xing <joey.xing@jaguarmicro.com>
---
 drivers/net/af_packet/rte_eth_af_packet.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/net/af_packet/rte_eth_af_packet.c b/drivers/net/af_packet/rte_eth_af_packet.c
index ab34285ed9..76f09dbe01 100644
--- a/drivers/net/af_packet/rte_eth_af_packet.c
+++ b/drivers/net/af_packet/rte_eth_af_packet.c
@@ -791,8 +791,8 @@ rte_pmd_init_internals(struct rte_vdev_device *dev,
                        unsigned int blockcnt,
                        unsigned int framesize,
                        unsigned int framecnt,
-		       unsigned int qdisc_bypass,
-		       const char *fanout_mode,
+                       unsigned int qdisc_bypass,
+                       const char *fanout_mode,
                        struct pmd_internals **internals,
                        struct rte_eth_dev **eth_dev,
                        struct rte_kvargs *kvlist)
@@ -1172,6 +1172,11 @@ rte_eth_from_packet(struct rte_vdev_device *dev,
 	PMD_LOG(INFO, "%s:\tblock count %d", name, blockcount);
 	PMD_LOG(INFO, "%s:\tframe size %d", name, framesize);
 	PMD_LOG(INFO, "%s:\tframe count %d", name, framecount);
+	PMD_LOG(INFO, "%s:\tqdisc bypass %d", name, qdisc_bypass);
+	if (fanout_mode)
+		PMD_LOG(INFO, "%s:\tfanout mode %s", name, fanout_mode);
+	else
+		PMD_LOG(INFO, "%s:\tfanout mode %s", name, "default PACKET_FANOUT_HASH");
 
 	if (rte_pmd_init_internals(dev, *sockfd, qpairs,
 				   blocksize, blockcount,
@@ -1274,4 +1279,5 @@ RTE_PMD_REGISTER_PARAM_STRING(net_af_packet,
 	"blocksz=<int> "
 	"framesz=<int> "
 	"framecnt=<int> "
-	"qdisc_bypass=<0|1>");
+	"qdisc_bypass=<0|1> "
+	"fanout_mode=<hash|lb|cpu|rollover|rnd|qm>");
-- 
2.47.1.windows.2

