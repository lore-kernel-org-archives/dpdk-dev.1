Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 086A6C021B1
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 13:28:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1B2F040041;
	Thu, 20 Feb 2025 14:28:52 +0100 (CET)
Received: from HK3PR03CU002.outbound.protection.outlook.com
 (mail-eastasiaazon11021110.outbound.protection.outlook.com [52.101.129.110])
 by mails.dpdk.org (Postfix) with ESMTP id 53B974003C
 for <dev@dpdk.org>; Thu, 20 Feb 2025 14:28:50 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FuQucf86HJsvAKvVrV2IYLI9vxjWgejSW5vW+qjENPOOw4abNc1aOFHObWyefvkHQ7kj5vDly6s9pkSGyQerN8XzX3TZUmGecfNAJbuoU3XrnpvXW9B6olSWVEHELAHRpQjE2NzWN0XhRcgmi4RJox6qY4m34tzLR3RLDj4AkP9czXou+tlMbSA8GXf35RjDPl9KYD4AQ/OfxdQxFQZBBv0OCpPrT0at2aCAHBlueZpI6ymuNhWkVMqJKymkbwqNH3/W9t7lTz9oiLeCe+rGigeI+wFPWAP1EOAVsKceb6aFa/YdIeiVqC6aqO7bC7p70Uuyi+AzQ/vG0hkEQn4WAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWrnA9QsqyWcTKEV9X4J0DCf2Ii1/xXm8N9l9ySE0mo=;
 b=W3WKDjYQBuwYtrZiy1NJqRU3AijONrm7Sw4BVjSecjoz60tHTe5Z3KZigd1ZCzxyJ/4Wqx6myhdUf8jCOcFmg/q3Ae0o06i5Vom73++slO24nlePLi61qWCcmo+/Z4OQgesr9eTR+xJMn5h5JrmkTngPD/lQBCyLKHjU+fPfS43z5JcVKfxFG1pBN/SRMC92UFKvaknZTnIhPjw4DbZ/e8GLOg4i9JfjPi60b23bA9fbOjhnXDJqbtU6ArtQJXJXvWyskSXrQQ7vu8vfjFMPqLATyFyMNcB1jz59Ym9CKABRGHXKx4ABfJGD4zwuWDgnsGOB8yST1FKvo6htw3S91w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=jaguarmicro.com; dmarc=pass action=none
 header.from=jaguarmicro.com; dkim=pass header.d=jaguarmicro.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jaguarmicro.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWrnA9QsqyWcTKEV9X4J0DCf2Ii1/xXm8N9l9ySE0mo=;
 b=HJeDV81LljgTrcmffHJnV7RgJ25yXhVJfKrRyxwc8z/QqjLeZSaG+Ozv7gWXOH9E9Kb0F3swdrdmw/C7ZP/lho6NHfu4kTuzTvaoQKEHXt3K2AQv7JCAMPegPxz7qG8RnXFubNVlrVzLkce/rz2nx4WE3qQTeLfc6kZ9JrMIXV6lm8rXdXLDFCZvMeY2KRXLUvYOP35LEQjU4Cr2tp9YHzr0pggpHRZRgtaI58fvpA3GIfg1M8ss3x221PPz7ma50LeZzldJHx7JuqcB1wTC+AAXjljLo9T7njV6B2kioAROdfwcsLyyP6/hhws7vIUVijahf3kB7ILai3jxQiMkyQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=jaguarmicro.com;
Received: from SI2PR06MB4234.apcprd06.prod.outlook.com (2603:1096:4:15c::13)
 by SEZPR06MB6459.apcprd06.prod.outlook.com (2603:1096:101:186::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.14; Thu, 20 Feb
 2025 13:28:43 +0000
Received: from SI2PR06MB4234.apcprd06.prod.outlook.com
 ([fe80::7c6b:7e04:5448:4be4]) by SI2PR06MB4234.apcprd06.prod.outlook.com
 ([fe80::7c6b:7e04:5448:4be4%6]) with mapi id 15.20.8466.015; Thu, 20 Feb 2025
 13:28:43 +0000
From: Shaokai Zhang <felix.zhang@jaguarmicro.com>
To: dev@dpdk.org
Cc: gakhil@marvell.com, fanzhang.oss@gmail.com,
 Joey Xing <joey.xing@jaguarmicro.com>
Subject: [PATCH] test/crypto: remove unused variable
Date: Thu, 20 Feb 2025 21:28:07 +0800
Message-ID: <20250220132807.2000-1-felix.zhang@jaguarmicro.com>
X-Mailer: git-send-email 2.47.1.windows.2
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0167.apcprd01.prod.exchangelabs.com
 (2603:1096:4:28::23) To SI2PR06MB4234.apcprd06.prod.outlook.com
 (2603:1096:4:15c::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SI2PR06MB4234:EE_|SEZPR06MB6459:EE_
X-MS-Office365-Filtering-Correlation-Id: 9331ae8a-857e-4126-24eb-08dd51b27efd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|376014|52116014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?08XlbCtVsBjIt0VbFiQRuzSNjV2DmT8P7Ly4R896STdHpYUPVtcRn8XS7FH8?=
 =?us-ascii?Q?QDCC5+ILWw+s6r3aLaPZwxy1aWLeIXQh4MmKn3bEB7Svqzn0j0g6wDbXuXJ7?=
 =?us-ascii?Q?SGJROgLE82YrFa0dCN86xjyaUR3XCEmQKs6V8/EqRogyu4PAiFvPmeHqbdkT?=
 =?us-ascii?Q?0RbfDbZGYKjYzUSeDEJZSnnV0yRlKePL1nw/ZGnlUy0nphelblmhG3HiCbrb?=
 =?us-ascii?Q?jKy8jtxOcOef3jdQSPGS/opLHSXG14XtIvri96Yj0GkB9XbD9Hb5Q7K5FamQ?=
 =?us-ascii?Q?S+3Z9amNsOeg4hHoMDifq+DeJxhND2Mpnccq2SnBQMbu2N5q1USvYq14gKt/?=
 =?us-ascii?Q?cVzKJ3QHGPWCbhYlNbJNwQuq0ZHRGD2Xa75okdkKtrR6MYZQPFsPmqIdXOoY?=
 =?us-ascii?Q?86P7SEu67z/vl6Si1/1z+0G1dXS+2Dd0FKNs3lbqHq+HTYLX/ikvcM7pQ/rR?=
 =?us-ascii?Q?qaKECvcJTk75FZUGg6YHIDtN1w5xJliNm2TOqhI4kliQzLGuey7APZAETyC6?=
 =?us-ascii?Q?TcZmVTWinbbrkIf1YunHxvPwY9Cll6HYMyceaDIoUteUwL7cdDrm5zPDPbE0?=
 =?us-ascii?Q?0WXXCYslvEnWW2R7BL3vTJ7RZFToMEUTu3WMieYiqjR2/FcpJphFkaTUvBJp?=
 =?us-ascii?Q?LJIRW+9ZODCsL390Bt8/EUEyYitD8p94Gxs1HsReo9Bks+pWnwhWUO8J8pan?=
 =?us-ascii?Q?rYjgp0Y5QYf0R7RyonJUWQfwlalBrQBuRN6DQCH4R6G2sVrtaZcVpzowZrTb?=
 =?us-ascii?Q?LV8jMo12Vage5+Jf3Cp9XE8ZIpwGDWgWucY9GdqabQQm8x7a5QIN7C6bi1Ky?=
 =?us-ascii?Q?tGx8MQMznpzzf+pMGrPhZ55f4nY52Hn4BK1Q97+jdNxIzVoi76vjiMqI5EPv?=
 =?us-ascii?Q?PwGmMnUvp9TgZfyWIvtwOCCgqBLDso+9vjcv57fJzYeipErYQl11WMOtP6sU?=
 =?us-ascii?Q?4gXdxYmwJADDCL4AkPn/t6EJRfloiSo6DEYSXZ1KQuX/aA1YGpNkwyQCmpdp?=
 =?us-ascii?Q?Nl95hVdOuP0y2QPtkPaM6JNxqr5Nan1gWEUAPmVpgwSSkLaj4HGG0IGWsEhq?=
 =?us-ascii?Q?p2VwaZ37kGS4uprdLFfLkShTeMUTJJEUzXw4a6WW8rTHXBF4wlrzNjtHDK2c?=
 =?us-ascii?Q?hkbd0Y+0f4fdXYlaM+gzOW+I+dffjJ6FGkvhAsFSiHmU4PeYNJa/VB4kBKCC?=
 =?us-ascii?Q?YCTk/a09bsdHy0ZeFfFobl3hnqOWdOk7OdaDNSsSz0sZhloaTQVlyC7trBY9?=
 =?us-ascii?Q?pmrceRjqbNXeqReS1SKyetyJUVUmK7r3jtkx3Sdgwnrp3MJ/NiCSfvdHodJr?=
 =?us-ascii?Q?RTpbKnFiAuPVEwAAskpGZummS/kNxcd4emuAhsnVZyfIiZ/kQWXgpMSnDzo6?=
 =?us-ascii?Q?j3zeEvNiMz2pnrDjY6B7ZwS787g/j+Herxy38X0CPfz4NgbcSgLHu+Tagnf8?=
 =?us-ascii?Q?6dSpv6xEkM76XQeMwZmmPXxFpnE/7bCg?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SI2PR06MB4234.apcprd06.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(376014)(52116014)(1800799024)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VEH1PcEhPP6h/sb5r4leES/TOrrZ3/5BL5atnBuRURpqsfT6lPrwS0y2h+oL?=
 =?us-ascii?Q?EcQnbgrZCA/oibsgZLsToKuifGqlynnscgD6OhEnyYk7mQ8qkRZB1m1Vb1c0?=
 =?us-ascii?Q?oKaeVWFdcqZAI1zpR79lTSeBG8dlHIlEQncFLWEWPQrQvQbI9vvbg1jMm4U8?=
 =?us-ascii?Q?CD7FI6MN+ejAeMOrRSPXVG0PEZDEcBmqFVzqlwrqBJgTmF31VB6450qUgcZc?=
 =?us-ascii?Q?srnkOpmDmm2XQJJzmGV6A0tQ5kwt9/5uR5XQ3cgUW9Pei1S99XT/2+IB6xsW?=
 =?us-ascii?Q?wEGgfqFNkEL19bRUe9ar4qVDZkXKzv3l6dwuBaM3ttJM9ghDYPTjFxNA4Hwb?=
 =?us-ascii?Q?kTwM790NQg7f1OlX6xcdShB8aRAEbByFTDLiZwrkV8Ks1QzWzY3WB1xAdAVt?=
 =?us-ascii?Q?VYonwbRJtHIVNVcrtFL/E8PnPVxwsLPg6X94JD5vwPSyTRuuNUJHrX31J3gf?=
 =?us-ascii?Q?6PYVieMgu2wfq7hxutRrpu7QRtL/VnuDouxvSg3ta+uCYplEPZNLqeKQWmBK?=
 =?us-ascii?Q?Ab7kZHaTN/M/MMaCWR1KRj+akAJLeay9jg9n7SJ8egXloIuYXOilZg9FBuZS?=
 =?us-ascii?Q?7paNzZ8mttDhChRvApVIKKE45AJSZvi29A5AfIiadQr95mAe/N/o95ASrOK3?=
 =?us-ascii?Q?p71rLxDje2BoWGmkUUysvfIyjr0OxwW4W+k+VJkaxtS/5aAxeAAfneLe4UsY?=
 =?us-ascii?Q?nZ3wnP8TMm+xcYU23C76wnVdcXBRRn9BwWo7C8yZUz0Ka+l8NDtG6SkHrd2v?=
 =?us-ascii?Q?Z+As26XUAM/ZMDUOH/r98NnC1N6qn3L6yVFMhPj3fQLedRifYmfX830af4Mf?=
 =?us-ascii?Q?xmqE/I518ovI59EIXoP2V9jKxr9XjUCsWcXPKwi2GOY6Vl9sl+EQEmAjHhtN?=
 =?us-ascii?Q?vz7QUCWhRngYd4knoWk5yXKHilmYXwSnvfOdA4P0x/7doC7IFtEc5Dmx9gGp?=
 =?us-ascii?Q?EUREyr8dNiPqHQVr1mJTUObnSQpzheezaz6B4MQw7Pgipve7zdy3ZgyB8xZh?=
 =?us-ascii?Q?zZAgfSORCxUDT2JDMeNx5D9Bg5vruJKiUoSBRjuUvyp4y8GClttIpuT8P+Xg?=
 =?us-ascii?Q?Vwe/kBtwHlP/to0vXz8Kpa5pmrrKpnh2Wm/ZpGpYgGzWWxI11LHoKqbx5aVQ?=
 =?us-ascii?Q?zjuwgz/sTj67fG9Y+ui+Iwc90Q7KBoKIj/zjhcDt8RDk1DyA7NucMLe0mrzu?=
 =?us-ascii?Q?NFPF5V86dGWSjYYTQRgviJLabFGq2FJcTcFG23oZnjx3S8m3x1f/10JCXgd4?=
 =?us-ascii?Q?fgG8vFfOqdtpCVsl54nGyUyS4AuQXa+DLS9mDB+PzE+0MWkmWRACsNMzAeU/?=
 =?us-ascii?Q?XqvWoAHDHgBRf232uPfmKYO44l8F1+v1Ba7IvBaKm3ee3JqCItwhLydCDscD?=
 =?us-ascii?Q?IuqePG0V7JH3KIfSVQ75FwkOjf41AbpqpvozSOS5/4J2+VMEaWjT5VA3Bc0u?=
 =?us-ascii?Q?oxnVI9FaN0Kt8pGk4wayukhFRIGO558Ri0H4b2nrO928r7NZbqmzj0WrDZbv?=
 =?us-ascii?Q?60JGR7IQrG4I0wfUmfLv0BToCPwJIV6ggnC1jiajqYSNtv+P2HzAH3Mw8juu?=
 =?us-ascii?Q?JK658lzDbgezsJtB3qJe4pU9BGqvUactOUpf2IVf79NZNB7SNRvKnHyU01zh?=
 =?us-ascii?Q?Gg=3D=3D?=
X-OriginatorOrg: jaguarmicro.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9331ae8a-857e-4126-24eb-08dd51b27efd
X-MS-Exchange-CrossTenant-AuthSource: SI2PR06MB4234.apcprd06.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 13:28:43.5336 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 1e45a5c2-d3e1-46b3-a0e6-c5ebf6d8ba7b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2rS8TGZbkdA4LO+HgCEGXEtg3L4agAWqVAa8+xiNVFrM5f8VredKjAPqDlOlgzUvq4lT+Q93bwetzZ6C9563tMKYDVijuU0dGNbB98ulKmI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEZPR06MB6459
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

In the new session framework, each crypto session no longer requires
the session_priv_mpool, and it is no longer referenced during testsuite
setup. However, the structure `struct crypto_testsuite_params` still
contains the session_priv_mpool member, which may lead to
the misunderstanding that session_priv_mpool still needs initialization.

Fixes: bdce2564dbf7 ("cryptodev: rework session framework")
Fixes: 3f3fc3308bd0 ("security: remove private mempool usage")

Signed-off-by: Shaokai Zhang <felix.zhang@jaguarmicro.com>
Reviewed-by: Joey Xing <joey.xing@jaguarmicro.com>
---
 app/test/test_cryptodev.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/app/test/test_cryptodev.h b/app/test/test_cryptodev.h
index bb54a33d62..190a220c73 100644
--- a/app/test/test_cryptodev.h
+++ b/app/test/test_cryptodev.h
@@ -87,7 +87,6 @@ struct crypto_testsuite_params {
 	struct rte_mempool *large_mbuf_pool;
 	struct rte_mempool *op_mpool;
 	struct rte_mempool *session_mpool;
-	struct rte_mempool *session_priv_mpool;
 	struct rte_cryptodev_config conf;
 	struct rte_cryptodev_qp_conf qp_conf;
 
-- 
2.47.1.windows.2

