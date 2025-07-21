Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1716CC83F25
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Jul 2025 11:52:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DF5B40651;
	Mon, 21 Jul 2025 13:52:10 +0200 (CEST)
Received: from OS8PR02CU002.outbound.protection.outlook.com
 (mail-japanwestazon11022115.outbound.protection.outlook.com [40.107.75.115])
 by mails.dpdk.org (Postfix) with ESMTP id 4C86840651;
 Mon, 21 Jul 2025 13:52:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ey2mvPpY+Pzw7NkrkqCN+O+ivgWe5SBIUm+Q0oYWJijWKSMraxoowuiJGd1HnNsphE7YeC1fBX6Qr7NIheBRdU2v36bdVjTCz4MauZvS6kHcUNMY2Fp3Hrgzw3fsPmjp5jPn7jsg74jtJ1ozQ0b7pmToJe/Q0uAl/yiLk7EAM7Wq3CuIEjusHE5QVMnIQkHwE21fCQWxBTYum0GBRBFPjqnIer9MP9rE/iaxIfgA+hr0K0A+7aOc7O8htIZecCYMweEoQKMbIvSlMAmiouUZWa6bQ8QyNsU0iEf+l7Bw9lZTe8oiWnok8Cr+cgSCy5MGVPGdOi+hl4b4fZeCAVinfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=n86Tn7Od5hgrqv53SAPbLPVtMnHSUp5+Xr25Iyn+F8I=;
 b=Enw48fUUnVF1jV76gNKEmeDtAQHmgZtiXMHHz4+iHSEyzKs8yVAfvvURE+dKe7VladoxYZF/Sb9kuCSAwPNWpw1gWRXnFvjX2cLgiEejC8tfBapWizAo6RJRb3oZFLuiDG+m2Aot5PdMwKwrx4URioDj597VqneJ43q0R4d2c08pVe/dcIDSZHZsF/YdxqHi4DMPyAWtN8YeD/klgNe1fUMTg4s9+A7NsQTh2f7L+SbB5wGlZMXO9Pn8I4w9hHj+mG6DpIhkK0UzHdzLAenBCYAiFuH8h+qB/JjkhpC+C3tHFt/B7QpXxs4Vv33OV0i4HB+73TZKOyTfNRkQEExtyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=n86Tn7Od5hgrqv53SAPbLPVtMnHSUp5+Xr25Iyn+F8I=;
 b=kV6YQpvR+iTiebi5ggPZ1BTlqHjcCOY0aqaF9J69CE1HargjyrdGFs8yt9tqDXAVwTcI0Q7v45bjYxsscVFQ4CDVbF81awXetLxXQdSAA2Y7cCKZkqAXt2UkQUJr0Jy51ziyxHauBjyFu4opqWTQjNe9P5gBa0tWOphwkjqZ0dZkqJg12BBErjPuYL6XSx9EWhVYd4WpjbWFwmFlK7naG0I47cv9aZiwHinikNRPtIMOxYvIJ+OEDh+k+3UDVMXffokBmk7IeTSGCJTZofPOojulFxWE9ng5Ru1eEZa8wtDPxcn0zPq6UE8wGJkC6SQ1OHiyVUP0KE7brADZ62OEWQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14) by KUZPR06MB8028.apcprd06.prod.outlook.com
 (2603:1096:d10:49::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8943.29; Mon, 21 Jul
 2025 11:52:05 +0000
Received: from KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb]) by KL1PR0601MB5567.apcprd06.prod.outlook.com
 ([fe80::3ad3:b4d9:7e69:85cb%4]) with mapi id 15.20.8922.037; Mon, 21 Jul 2025
 11:52:05 +0000
From: Sunyang Wu <sunyang.wu@jaguarmicro.com>
To: dev@dpdk.org
Cc: thomas@monjalon.net, ferruh.yigit@amd.com, andrew.rybchenko@oktetlabs.ru,
 stable@dpdk.org
Subject: [PATCH] ethdev: keep promiscuous/allmulti value before enabling
Date: Mon, 21 Jul 2025 19:51:39 +0800
Message-Id: <20250721115139.46728-1-sunyang.wu@jaguarmicro.com>
X-Mailer: git-send-email 2.19.0.rc0.windows.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0242.apcprd06.prod.outlook.com
 (2603:1096:4:ac::26) To KL1PR0601MB5567.apcprd06.prod.outlook.com
 (2603:1096:820:c5::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: KL1PR0601MB5567:EE_|KUZPR06MB8028:EE_
X-MS-Office365-Filtering-Correlation-Id: 47e07aa0-d852-4f6d-cb21-08ddc84d034c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ibDIAqnMTjp4zXpJPP8zI/8aMfETG4iBfDIIQsAJUUQLjHuXjfX4aL5FLmKE?=
 =?us-ascii?Q?kL1cYAFFhRcpdmRq7sn3vX4adsVgyuOC03Af+ZgzXXyGhqQGt2YsgI9NJHhw?=
 =?us-ascii?Q?N12M+QgI/bP4zXe1LU+XNdnBefXYG5hhWrG50+lGwcELNSL9k9QccA0TrJ6M?=
 =?us-ascii?Q?LyW2QmDwQzdLM8vDeICpW4408Mq+VmQ1Hy4x7J0vpQpbM28/xHgZRp3LOCw/?=
 =?us-ascii?Q?hBN2p10wfs0GnXFgI3dRIhzPd6hZMpt3aTEPvE6PeDncbgyIMICycOF1GJnH?=
 =?us-ascii?Q?O9FCCpGBhpRQftHlSngH3BHcgPbPghTzKfJLOluS7mLYnnG+IFc8QrMie7aU?=
 =?us-ascii?Q?73bBLqX/v55KjvAU4zSavd9fAS2sIu5/JwNnEoIoZbSPhNSX30qNxYlwJT3g?=
 =?us-ascii?Q?yw8XU61Neg8nVkn0qTTMzuitFhtdKF7bI1abcS5oPW8ky3TL6h0ANY+4YvvW?=
 =?us-ascii?Q?KJSCJNBJEVlUePuECyfBqywCncdqGcW/EC4I980WkblQuBZfdmI1wWiVp1+P?=
 =?us-ascii?Q?sL+Q8vsSwMWb7DfMosDShB5/J9LeftNo4A4BOjAhFSJmOywHR3PM2LZ0Nk10?=
 =?us-ascii?Q?EiyARwJOXCtxhHcs4kCC9ZNIx57yN4REuOEOpOJAJZuFNjASleNCxObQZZI9?=
 =?us-ascii?Q?TMJJpMtfiQHwjekKr8cULCfLvqBo/RKlgynAWHL0H2c6087lEvS7iOGG8/TZ?=
 =?us-ascii?Q?js+QFLlaKXg+nywZBqS/8dT1Zy8aYKmt0hSKijv0KtQlVNSwKvFKx9FDF9R/?=
 =?us-ascii?Q?07HSD8D+g3Ee0P9+cUjbkmunRzmG7vbzG0e8jryop1oST8O+P5KRct93YnfT?=
 =?us-ascii?Q?/+G/VMZidz2KNrCgqV6S5Ndrc7IC4ha8LTDy5nJe9TQJeOhWRFbrJhs5etvF?=
 =?us-ascii?Q?MObyHvNcGATEmSRyLnICo+aVFASJoRl21yCK06EwYZInzPN7ekwW+N0H4+q9?=
 =?us-ascii?Q?3DO7c1y4j1eJf8U5o+hG9o7HTptNBKUnsMDsEvyIU1Aw6UWcNylHjoGIi00Z?=
 =?us-ascii?Q?2ppZnUHMJE0vluA04WdbJrHAsOqmgNlDqaL9zhKDMfl8j6W+6HJGaaiQfVMz?=
 =?us-ascii?Q?SdHtgENgndxys6G5/OkAsmPrdru1Akp12axELX80UlKDWjJC+nYmOj0qar1X?=
 =?us-ascii?Q?HbfYgp/6jO8oMgnSmgq4c2ig5z1NVUDMHJoUVxl8xoxOlKN+AXeLaSzHd0zr?=
 =?us-ascii?Q?5bTLwGsKf9IPL6WaMBMrMS29TMI90xVIIK5EiYQHCt+UeKTg8NlXWktVoqg9?=
 =?us-ascii?Q?sC4/doTQiJp5w0Rf+ngRHewHUZ0BYFoeowi4CsmxYZfYk8VuaEjR8rTb7s3D?=
 =?us-ascii?Q?ywqX7oGeAeVDonLYOCFPZ6iJ206y6TVeHBK9NdVKAKbAIrj4iZmhQZYupOWv?=
 =?us-ascii?Q?Md34t4zNDqxn7GCi5sU2EcywNe61QqpIdLHOLG1xKuIC2drwd0ltChfAjskF?=
 =?us-ascii?Q?XW9FPTwArgihWAHcKq4p9+bQhrrl/DypNiUEtfXXYpwKBLTCC1uhdA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:KL1PR0601MB5567.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(52116014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ehwinojO/2G8tCMzOu53nXUmTOWrsnV98CxBKBVZbqF/QQjCuMbQHmUXB50M?=
 =?us-ascii?Q?exZqPqxgbA1krxatayJZsUQkU1Gtp5v45A9Hizif0x2X5r/q3tLHCjwSdiei?=
 =?us-ascii?Q?q8Cz/xf6MCzUbtQuEv3pUmwrmB9vKkKUzJVdGpSyvqJrYpiI4zAt96xdYG+P?=
 =?us-ascii?Q?S3gLJ+BI861U2SaDfpMNbSvSDkvoWafGUsGiCNRScVQBxQTr3KPepjF1s31B?=
 =?us-ascii?Q?OlmW/9sgIKxLaecNEhDnBuCuq3DT2ZTU0F6p7cLthO8DYEBf47YFal90rkXG?=
 =?us-ascii?Q?nbf0qoKumFRbNueJGxalkImanFljZz9ou/t3jUbugRhRWJv1bdSj6HJRFnP2?=
 =?us-ascii?Q?SBmzhQGIlxkg8PR1K1MFFpTHl5FWQtqrDYslxLmGFUxGPrzxp/5LBmmmqbm8?=
 =?us-ascii?Q?F/EVAQwRvUuYsKQlA6QuEIrSEWFmwtUAKMJFkt5SKq817K7it4QA75oXO7qT?=
 =?us-ascii?Q?EjUutE9ApxbXZw9fn4ErEKpzg30luzSYltITl6n1OAH5NvHyh17AHzm2A3sK?=
 =?us-ascii?Q?DmVWVVCQtTV5KvWGpfEA340MXkjIcgK++r03sPDsHrQvl860XUcsY+Rz4d4D?=
 =?us-ascii?Q?UuU09KMIhN2SjxgKaDNtatLTCBbRnZTPFNp2W761MAVqnAOzZm1pwldx14rc?=
 =?us-ascii?Q?excgjRvr4mZdO0k2+WqH9EIvBH/LARoHDQ5ef4Dl2BUiLPDikTeGqaf/lrWl?=
 =?us-ascii?Q?SSP7onl6HEL7t/uCqTcJztVVEMlbfCcAXO/AbNv9VPWUxxIcG4rTwYoQgz5d?=
 =?us-ascii?Q?LKJg20T/k3daUmAEAAs1FOZr1iLeMLNEhIGmXoJ6JPjCBsxLykpJCxFew3+2?=
 =?us-ascii?Q?BXh8pDuvAmFXedwdUCQRvJWhPlsVF2trpB4kp5XYCesiG/sfPFhP1j7Qr4OF?=
 =?us-ascii?Q?I0BIN2/nBiXDoRn4qoS4ORfVJAQ5rRYsP0Pk0E6vbNL1U+H7AmsPG2QHgfkW?=
 =?us-ascii?Q?k8YYISJZObey5Pc4OTVezp72vmA49CMls7RnQhE7atTq3mo/ihuP2swoZz/u?=
 =?us-ascii?Q?AIkL6J6ksULFso3lRVWXgMDcM0bqOzS80WYOIejXSJ8wsfWIum9p7m+S/iM8?=
 =?us-ascii?Q?AoDDbZBfCohZsZBdAe1TWl/Ctu87C+xZvOiUczNji8Ysl1VPbG0SS9aOFKDL?=
 =?us-ascii?Q?1bnnCx5SJ5K8cjs5aRgm2TM8oVnrXZwjjcNPi5BbQ4p8xUR0YMNTOCs5C9cj?=
 =?us-ascii?Q?ivTaJG5+hjXtVdq8yXzQ44+mNeLubGe2g0V5s6UrfbwJ31dWZCymPlHPb6lb?=
 =?us-ascii?Q?IWkK/oTlLur6mNPqO2iVqKnV4glulg3bLXIEdbivB1h9+9CxSH/7D72BBkYE?=
 =?us-ascii?Q?ciWARMUsJaZzMZR6N8D+AhYhnFW6+2t1TiwniVwThPSFksBBQVBxrf9WdPhk?=
 =?us-ascii?Q?0ZzcuhtXhNngtt2DCybYjvX074OL2CSHJWbnJpULeCkPlsdmpGFugKZlyyui?=
 =?us-ascii?Q?fqD0ErZ33e1CYRC8ChRmaaqkaEjWYJBBNd81wIy5qDy0rWX6I8RADqloMmr3?=
 =?us-ascii?Q?u9XeU5UsnTh5pN0TaqevMzKvo26mBztMZuY65I1BtwWceOs8tC9rCgKXiGEv?=
 =?us-ascii?Q?2QsMnvvMBRNcKQ9eD5rBlLHE4UNf2BJu20QNkZPx/aW2q+omFHXQRSAL74P9?=
 =?us-ascii?Q?ZQ=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47e07aa0-d852-4f6d-cb21-08ddc84d034c
X-MS-Exchange-CrossTenant-AuthSource: KL1PR0601MB5567.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2025 11:52:05.2640 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XBlew1mAq+F7Y4VHlfOSZ5K4bhvqmaETBJKEsRUfo6AMQMOyx7ty8nn4stUIWUxt9dD4p4b+lVxPzN39d8m64rzag+Prxx25x5jxHYKZLzI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: KUZPR06MB8028
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

The values of the promiscuous and allmulticast variables
are set after calling the driver, according to the return value.

Fixes: 400d75818266 ("ethdev: check device promiscuous state")
de5ccf0775ae ("ethdev:do nothing if all-multicast mode is applied
again")
Cc: stable@dpdk.org

Signed-off-by: Sunyang Wu <sunyang.wu@jaguarmicro.com>
---
 lib/ethdev/rte_ethdev.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/lib/ethdev/rte_ethdev.c b/lib/ethdev/rte_ethdev.c
index dd7c00bc94..41f96071e2 100644
--- a/lib/ethdev/rte_ethdev.c
+++ b/lib/ethdev/rte_ethdev.c
@@ -3018,7 +3018,8 @@ rte_eth_promiscuous_enable(uint16_t port_id)
 		return -ENOTSUP;
 
 	diag = dev->dev_ops->promiscuous_enable(dev);
-	dev->data->promiscuous = (diag == 0) ? 1 : 0;
+	if (diag == 0)
+		dev->data->promiscuous = 1;
 
 	diag = eth_err(port_id, diag);
 
@@ -3086,7 +3087,8 @@ rte_eth_allmulticast_enable(uint16_t port_id)
 	if (dev->dev_ops->allmulticast_enable == NULL)
 		return -ENOTSUP;
 	diag = dev->dev_ops->allmulticast_enable(dev);
-	dev->data->all_multicast = (diag == 0) ? 1 : 0;
+	if (diag == 0)
+		dev->data->all_multicast = 1;
 
 	diag = eth_err(port_id, diag);
 
-- 
2.19.0.rc0.windows.1

