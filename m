Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44C39C3601E
	for <dpdk-dev@archiver.kernel.org>; Mon, 14 Apr 2025 06:02:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A358A402CF;
	Mon, 14 Apr 2025 08:02:49 +0200 (CEST)
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2098.outbound.protection.outlook.com [40.107.94.98])
 by mails.dpdk.org (Postfix) with ESMTP id 5BA3940265;
 Mon, 14 Apr 2025 08:02:47 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TjUj//MQmqte76dozWm6Zk2MlzuBdSiF1bP5ZV8vw1Vjy3Xa0XLRtGJdWAlhh49zMo2C7CVxnHKdW68snfy7sGozMylLy4zl965dQnh4uT3hd1U4EuWRhQ42khhTyqrEXTkrztSxRNJLGldpljCzuh7tAEPnSd5sM3IcEytc3RJcqjZgYPzC5q+cuLVLVtQVgf0YfTuRsKQEa0+pP1BKY/1SsT3sTHJlnINeD6IW9tR2RMK0rSlw76ZFQm77BLafy+nH/Zkdsni5kGuOrsEwDZ/0iaggQgk5HHld0p4uOZqLfyt2KBlJBrLWDylLX78+9fsawyDq1pS0YZZjdPoU+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=L3VFQDXRfI5EZ5QrjkvDh/hoH4cdnXkzbJaQoBWykfc=;
 b=E5ddv8+UG5GuFIH4xO41Iq9Kj2xWyTuyU7YuVc7/OJiJMJ5viO3l00GOPMddHBOrSfc3aR/m1f6/s6pJrY3FX0oTAw8W0Aq6mJLUA+fYsC90u9D9Ia3fLAgZno9VmD7pfz04yWovKVcLhnqcz4jOGSuhnyyAHWGayW4IhlnAs8BplQwOFCL+JRhCAvpML9t4wI2oNnlAS+qwIeyY5ZPglme1ucAlALxxbJWxE1rx/aZCOXN76stRzpJXM/VoSTiAmJzEv3mODtLQC47Yt6EXPyGbkBTQNqSaP984q2kGr2nLpL53MExRh16SII70WlK7iMsAlqcoNZ5ZvuLtZoWv5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=L3VFQDXRfI5EZ5QrjkvDh/hoH4cdnXkzbJaQoBWykfc=;
 b=QIwQPCg5rMid2g+UhLosZ7nk+Mt1Cj7UBuM8COFMeBpEYLYc5qJdeUO8T2qDqdM6QlkLBZJapMN/o9y9lGu94Wop2+B9IdZxt9pzAc5CZuVM9ky8g4XKLKTd/EUJSb5Zetl0UXk1V6DRZRDgVOMm5+j0nLml0KmGpC3x+eb+T54=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com (2603:10b6:a03:424::5)
 by BL3PR13MB5123.namprd13.prod.outlook.com (2603:10b6:208:352::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.34; Mon, 14 Apr
 2025 06:02:45 +0000
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833]) by SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833%6]) with mapi id 15.20.8632.025; Mon, 14 Apr 2025
 06:02:45 +0000
From: Chaoyong He <chaoyong.he@corigine.com>
To: dev@dpdk.org
Cc: oss-drivers@corigine.com, Long Wu <long.wu@corigine.com>,
 chaoyong.he@corigine.com, stable@dpdk.org
Subject: [PATCH 1/2] net/nfp: fix flow rule free problem
Date: Mon, 14 Apr 2025 14:02:26 +0800
Message-ID: <20250414060227.1251817-2-chaoyong.he@corigine.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250414060227.1251817-1-chaoyong.he@corigine.com>
References: <20250414060227.1251817-1-chaoyong.he@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0011.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::19) To SJ0PR13MB5545.namprd13.prod.outlook.com
 (2603:10b6:a03:424::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR13MB5545:EE_|BL3PR13MB5123:EE_
X-MS-Office365-Filtering-Correlation-Id: f1e5d137-4632-4193-4a9b-08dd7b19f9c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Kv69qy3M3zPi3K0rS4SAYwcPpUKKMfwsLYJOF+Yom5sPgVtfprHntVWC6Lmb?=
 =?us-ascii?Q?NFUUOoWw3Jwjkrl9Noxym6XKaWaQDL2xDvppDpF6IovoSgNTlxagJ5t1yWHH?=
 =?us-ascii?Q?+JbutrIF6GTCnnM8+qwJ+vC7HDNDAQLy1+5CqIZsY+l6u8P2MsiEQDrgoWkS?=
 =?us-ascii?Q?sdeWWLL64yld2L71TftNX9RekksPo8HHuwkMwap8BmyQU4OzkErMVVTX1Kah?=
 =?us-ascii?Q?QqgCZKLN4pLHsYDvsk3jj7fHw/MkcZn460h1hCrljAUDwCtsTZT4KKOipqRo?=
 =?us-ascii?Q?UsNa+1QicmTqalqPS8DVsNvxJdVCxA5Hu/Nmzyb55lHqJd2Kkk+ZDyJCmdhS?=
 =?us-ascii?Q?hreuI/aapfw3prN1GcRGbg3CY5/EXzoTnVDvvXdSKvrHDZ3JP0vQAjGQXNso?=
 =?us-ascii?Q?itbjE0CtXskZ6zn4tF29JyE04FWwqRQtUo6NFJotqMmbyLt8H5UR+a0UVwi5?=
 =?us-ascii?Q?dVcH5/+CCYk03hG8meaPaYl9OmEhAqIh5K0kytHtSF9qo08GevMc8WWM4OUU?=
 =?us-ascii?Q?T9AXn7m5s8PI7DlQ2NdgG7QdMyByN5GC5uS/Mis6TGdjwMrQd41wB2TGY1cF?=
 =?us-ascii?Q?04Ug0hzCMmVcAvXCc/Qu5N67sPbzxVYHN0ULDSIBb7s7ZFjvRKB+7CMfPC3g?=
 =?us-ascii?Q?LiCMWN3X926SWAfOMWkqKkJq54pXbb5tvdZrL1oM9+9GwN2TVLqatGXl7/Qx?=
 =?us-ascii?Q?FzKlvx9wfGod4r9aBUdh3uuvCjZ7v2dgA4G1wmVzvOqiuS3m0HRXeoovY3xv?=
 =?us-ascii?Q?nak39f8XyAyetZBWiigZs9zyCKEoikawT4yQLwrxGsQXTGn9oXq+NYZo9QO4?=
 =?us-ascii?Q?XWx7ouHtEZLAnsdKpldA4GDhqtRdFY7WyYj4whhlOkfNML+vcvJ+N3bE6Oq/?=
 =?us-ascii?Q?fJCXEBiAA1JQ3w5xdR6LtBBzkMHcjgS4oDaM4+5m5Kh8du9tm6ZOxYhh2fWg?=
 =?us-ascii?Q?OFA9ghF3E7PARILy5sz7TDaNQcFJ9PGKm9/QUU81rcA8DDK7K6aKK1geJvRG?=
 =?us-ascii?Q?vL2Mm49FZEkflQEv3lb2yCYmzVW7By6nLpXsBAirfbdelwhrkr3YN2Jyyp8h?=
 =?us-ascii?Q?gtl03xSY1sL2srP38aqLkIj2yfUWRk78vr7A6Wx1l6pcoJPIYF/NoItofZ1l?=
 =?us-ascii?Q?deI/kmQbgAenyEKAKDvswznZWrJiqulD5zBIWAQJ6I7EutAGQBZwMw+YQymv?=
 =?us-ascii?Q?5nJwxvn1g9BzsWCcH2aZ46tsYPdD5kCUrviskzM1hxueRNb37i1ZilLzlSOc?=
 =?us-ascii?Q?2LdJy5IOCbznxNHpdMvGvxlbhvKKM+B/gx6RkKPZannAZTElue0Iz3u5Exhm?=
 =?us-ascii?Q?mFGv6pYMNVpJb+HPJ++3tUGmWIN7ZUxdGiDLP2BLiZKoPv3gOt/ExxseU762?=
 =?us-ascii?Q?fwsyk1SPIVRgmgXolQMeADrU/KOvnEKf7eEdAJwn98LMrRvz3SFGlmsdVdsq?=
 =?us-ascii?Q?3JHLt6pVc4AtKDXTZHwyHhvIUaEVoQIdPEX+wI3pn1OjHipAKYQzVA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR13MB5545.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?YOm9QuPm5LFtBmgQDLfddVZMjR9s8nFQdRy/pn8SkdNl00E16wHI1bF+JjWX?=
 =?us-ascii?Q?z+or4rnW5fwwGxQiEGtFiW2AMmG34SRQlUry4oqHNSSiHdezKUzSaEOJlKGw?=
 =?us-ascii?Q?HwpMQoNDrgCPP9Uxt/JblbqvqhXqG/5QjxY3lCx4XnyrCJ9fL/bObfJO7Xxv?=
 =?us-ascii?Q?+400tyH31XZa7biF2UzNl5WuZwHRpZgalaFpOtoYC9VcK54cdY3v7ziLlnaX?=
 =?us-ascii?Q?71Y+F7gIiHYMEPWs9T/rAohqHVMEouVn8F0xhnU1Q2wujPqRzxXv7+v4yT+O?=
 =?us-ascii?Q?yCPl6PW2qF6b8GZ082zEmkTmm4XFZh4+8ucqM1eT14lBl8dvjcU2cLZulwPe?=
 =?us-ascii?Q?aAhHTu6UqYK3wQL8tVmeLQXsdrcEw/453DJh8TeoUCoW0ZvoVQWV8rSi2E0F?=
 =?us-ascii?Q?hlK8YvDnRTIl6MqoiERSDLc+0mpnhX0Giw+A8hkeylb3nLR2uc1xjzv6j/P4?=
 =?us-ascii?Q?k57jsxQjOPz/DOw0A2pLTOR9dQ1MZsToLnBBbRXN8kd+/cnQjMzGOtv2MuiT?=
 =?us-ascii?Q?Ki+werooW05SukCT+bM71eVoAU0JN8/a62fTQyZAukDYzzvKk+lJuzuZsHLU?=
 =?us-ascii?Q?D8gCENL/aSB0AWz7vNOtHrlQphI0PW8TtNjwJbk5MJNpQARdLBy9wu0KowlO?=
 =?us-ascii?Q?bWW67d1VQQHG+ZvZqcXBAS0PdTQtfRXSGkcD1aQz2GT8ArbjX9sVmBZ+FpR4?=
 =?us-ascii?Q?rFvE87s5tclltRRUZiZk7rdsE4EVU+dt/NqXy26oSloqc+sSzahIs0RNegbQ?=
 =?us-ascii?Q?qhS3K++2QtzdutsD0MwrRRMiiyCoYyPbtNhp6cIX9zo6Kjx+liU6TpNJzYi+?=
 =?us-ascii?Q?G25WU+0sPFwRGJiP5kR+2lj10wHkghCGfQHBc4bmZSQMZA8otVRBSnr0ePvk?=
 =?us-ascii?Q?08Jm+jZLJ+r6zIpt9YwwgTBxNQGJNEDZs8w5diNUzdnW2yXE/Cayz74pSswg?=
 =?us-ascii?Q?DmkAk0jS+EFWp+S9/lZf1gfjmLm48u1WvNWBl0zaRRYQm7mLwsdyjXcO5Z6I?=
 =?us-ascii?Q?jWwjMm4J8BJuYTgd7Nj5BnjrXILMRp3y9TQkzFPiL9NjtDrM7IjgHH9+/0NT?=
 =?us-ascii?Q?gz77YyrmvKrDDEwAitrVX2K2DVw7F/FqyZKUjGnrMTxoGbHIbxFJuPwzCBVb?=
 =?us-ascii?Q?jqG+gl5uwBYUDZngM9IU828WbYwxsL8fmG3o2ZkfO3fqswoXJPuf2BX86iaE?=
 =?us-ascii?Q?5jW/snQ2HWutpB/nlOw4K2nOGM0Vi2NZKUfmDdV13rYord8rRvR90XXbDZAa?=
 =?us-ascii?Q?tJrAwMPdhk3hFLCsf4MnBw61UFxMA6aNuzBM/1IfXtzdb7swFSQXbqG2j8mY?=
 =?us-ascii?Q?DM6nKYgd4bwPOViESNO5zhYhej6PP7cran2EIPyv5lmVJZjlpN5UfJ4qj2As?=
 =?us-ascii?Q?DAoVI//aC797iY/w65KXZevNw+WPIJkki72mnAYfl6+qLEZLdwTa5NeN9q1H?=
 =?us-ascii?Q?Qz1JCCnzYO1uoplkbHJnDwt8sZs+7KEQXi9jmoqZXHBsJF5pEYsEK5NM7lvJ?=
 =?us-ascii?Q?XO/TWKdYeaVD+gL+50bLmbXh26S7rBAEnBvwxNWE8lz9kARpTP8dD52XOWLe?=
 =?us-ascii?Q?qQSWxYrzqR4DlhBc4F4zrIwy8fuChyrvGOiWOEcak8otOQkwRJ0svUIYwkqi?=
 =?us-ascii?Q?mQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1e5d137-4632-4193-4a9b-08dd7b19f9c0
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5545.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2025 06:02:45.4075 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: aDdy6wEx4yiMoHsvTxk/y6/FksOpR/HB/hc+KBHX95BjypD+1x3YcUnFJCO3M2MuOMZUqknzXQVhkRgVtYo5c8h+MVFht9P5KEI5gbepq9w=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR13MB5123
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

From: Long Wu <long.wu@corigine.com>

The flow number limit is stored in `priv->flow_limit` now, so
the free index should be calculated based on it, or there will
be coredump problem.

Fixes: 66df893f2fef ("net/nfp: support different flow steering rules limit")
Cc: chaoyong.he@corigine.com
Cc: stable@dpdk.org

Signed-off-by: Long Wu <long.wu@corigine.com>
Reviewed-by: Chaoyong He <chaoyong.he@corigine.com>
---
 drivers/net/nfp/nfp_net_flow.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/nfp/nfp_net_flow.c b/drivers/net/nfp/nfp_net_flow.c
index 7f3fff2186..0e5003ebe3 100644
--- a/drivers/net/nfp/nfp_net_flow.c
+++ b/drivers/net/nfp/nfp_net_flow.c
@@ -128,7 +128,7 @@ nfp_net_flow_position_free(struct nfp_net_priv *priv,
 {
 	uint32_t index;
 
-	index = NFP_NET_FLOW_LIMIT - 1 - nfp_flow->position;
+	index = priv->flow_limit - 1 - nfp_flow->position;
 
 	priv->flow_position[index] = false;
 }
-- 
2.43.5

