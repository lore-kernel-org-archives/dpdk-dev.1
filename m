Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907C1C54F30
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 07:14:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C5FA8402D6;
	Fri, 30 May 2025 09:14:12 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012025.outbound.protection.outlook.com [52.101.66.25])
 by mails.dpdk.org (Postfix) with ESMTP id 7AED3402BC;
 Fri, 30 May 2025 09:14:11 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Z6uMYv0D5QYvACBKXFekitCPFLEaGI44V+7gv2LX9RqNQWWbBIvv/1N4NtvdMI2BIg6VkdwP6yyox9P3x93niq5X6BvEZcms9WeLZl+mmvfhE986iDbcBeoVAsuInoCDqgLaNrCy1iCFSeRJ+Uc/SphSI/hUPYMIKQYWtpsxBPOAH/i/2GesiiExRBegHeYqlq4yDdZlRtTTGAMdMMAD4TWtumQvaZ/4pmR25sfMt6dyDoLc8MbfqUyiJo4X6izr6H6JgZ489rY2yZ1UqH8UNTbDOFJ1wCz0RX9LxiqbH4u590yqheOnRF03KIkMtIADtba6+DheblDz0P9rpFwwjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVHq0TNIaGRq5TS3Hr28WJnHZgl9Sa9uOIZQWoEGCMc=;
 b=jTFVDLOiceOA2M9Xwg6RaM0bTjE/Q28u65SDAbH6B7m3EQDbP5NXAY6XsdbFvmqlD5PveRbnRMfq3FJ/QZwxCEN6KPViVf68qCBwTRsba/bGNYjJ4uUcaDnQUI9YFDOfIUinti0W0HklJoNI+BhCHNPjHmx9UJYm+TMVZr3Wbs4O1ZyD+kRoBNb3J7588zr7Dtkb+d/P3b9+d36CZ9muEXCCTmmQ1qQo4Tl+jOPixALEhNXmdg0ivN5KcNp0CVNbchDE68UIj4S2jF0ZavORGbN6vDItOAdQtHksdvweL8WltQ1mRGLjnIixD+XZGii2B9hdXtRSG6xZxlCyTdVOZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVHq0TNIaGRq5TS3Hr28WJnHZgl9Sa9uOIZQWoEGCMc=;
 b=ZM7WzQ0CQy2ckH2CqhGQJL/eFxMDLKSjC6dPLnvuFPN3c76OOZMuW1naTUSPHSXqfBoM3SAnPSyZQ4UFnBwonq+WOqSEMiEfRvsbks6Iq3mFuijzjYzT8O7ty7Fg7CMv/Sio6H71Yn9EOE2S5ZkTPBANAT20EMwgLTJTtjltl3CJcLgfxNPwL8/vOcsHZYt2l1tpWSvYh3RazN50YG01QEOOSZBHRv0DgpK0ioGnboN4KHEovcOxANbTr4qq+Ixr1Oqx25qsv/Cckl23AEPf3nDK/kUeeq9yk/JDOtshT2tN0h0KILRMRiFkxH4SaEJVrXSEK5SCpzwhuqMpQVlKaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8205.eurprd04.prod.outlook.com (2603:10a6:102:1c2::20)
 by GV1PR04MB10378.eurprd04.prod.outlook.com (2603:10a6:150:1d4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 30 May
 2025 07:14:09 +0000
Received: from PAXPR04MB8205.eurprd04.prod.outlook.com
 ([fe80::7633:884d:5973:174f]) by PAXPR04MB8205.eurprd04.prod.outlook.com
 ([fe80::7633:884d:5973:174f%4]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 07:14:09 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: stable@dpdk.org
Subject: [PATCH 02/11] net/dpaa2: fix shaper rate
Date: Fri, 30 May 2025 12:43:35 +0530
Message-Id: <20250530071344.2939434-3-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250530071344.2939434-1-g.singh@nxp.com>
References: <20250530071344.2939434-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0153.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::33) To PAXPR04MB8205.eurprd04.prod.outlook.com
 (2603:10a6:102:1c2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8205:EE_|GV1PR04MB10378:EE_
X-MS-Office365-Filtering-Correlation-Id: b5290b5e-5358-41ad-a43b-08dd9f499252
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?uGAgIjwrtzvQZ8DJjnMUsg2kZsVwuq/y/6RWlG2FH2fv3/whqRHOrGzUl10O?=
 =?us-ascii?Q?rbz8xNXKvCYJ8yFZOe8fSL13p6xmB2fUQMSgXJID0WsLmoTj9zNM/cq4xIl2?=
 =?us-ascii?Q?HLVsKcUJxvvwmdSLSXSeal4KdhJLe4mFGp2th/q1c0udzyVD382i7Hrf8RKm?=
 =?us-ascii?Q?oF4CDbKLNBMks1FQUbs/nnpd1ExOCUpBWLDAECrzuTHNXSFD0n5H02EzXeHi?=
 =?us-ascii?Q?X2JvzD/7t/te2/Up4nMDW+CRAXqBssrF2yG6lDo7kMcjb3LjQ3qJHz4ueRzj?=
 =?us-ascii?Q?SG58fP+3Mp9p2HlPfcYaXU4v71CGJnip873gUwvpIaAb8cPKsADD7cghJp4t?=
 =?us-ascii?Q?b0s26ZYTzbQVtrh3Roeq8DOeIPwHCWAR2MnOEAPoctlZ7VA2/z/Q5BEWHoKa?=
 =?us-ascii?Q?fLmIRwVguxVi6WQ+9bqnQphJfft1B/4HEdrNCZEFTGr9RcssbhBQXZAQZ+1P?=
 =?us-ascii?Q?whO64cMIq1/3N82SiMI+uOxddom4yN/83S8/0gfEL+l7EgBq0M+v0zxRE8X3?=
 =?us-ascii?Q?nydUqlHHg939a7JGrHKrKj57y/tYNrDhwp0Y3dtLSgjmXym/ZT7pvdY4m68H?=
 =?us-ascii?Q?hJEfQV+TUwjS4jcSVO2WBp/IciJjbmf55A0Tg6CifGlgCtWItcKnM5j1/1jd?=
 =?us-ascii?Q?5w3Hr5LX0MUq/+QUbDu345RmQrg+6TvUUEg2verxN444qOObRwukiFGbZZJV?=
 =?us-ascii?Q?Vbpsi/qLGwu/a459uATY9wXA0R7/oxgzjYgmcUC1foI2qubBrKa+3kRkd2+i?=
 =?us-ascii?Q?8Kn4dD6RWE7k76ubvG5qkGJ07CXqKJYoCCToU2FQiBIUTJnvKuDpkrDADSip?=
 =?us-ascii?Q?Dg/MBd2FQe698J/kG9EjHEPSw8WfFRUJRznUewQk6eJnDq4AX95zK0QAykmE?=
 =?us-ascii?Q?I7cF5Ux8AaTE1GGKZBknEU1TS44Q8mA0/Y18RT/10TR9gKeo/WRv3JMiJubv?=
 =?us-ascii?Q?MnJ0S7PvMjYGe7NDq6A7pGeujQObyNJ+AC9P6uYy7ZK8yysv3yN9l0qbOiV3?=
 =?us-ascii?Q?oju2wIKYsv35N1ii9xUVXmcyJkYYWdCzv6KyjpEa0eaF/QU9hz2VbKIvn7FD?=
 =?us-ascii?Q?09D3Iw1mTnsSVr8g29OP9/hfKlSSh9PH+HKPPSpftxPW5OsCa0t3w3iZNoS7?=
 =?us-ascii?Q?EFt9xMxhRQ7uxcfy1ISYIvYR1Gg/uy/sr2rlTRmXeySyLHe0ln644RehM84f?=
 =?us-ascii?Q?TyzILwu3VGmNHfx+j+1r3b/UudnPgGSiM0QRTae/FW6ac9fHtYgK5Q8RHt4l?=
 =?us-ascii?Q?AVZiSNocLiKTWa5AjlKb065XASA2wAOZHLzfl4M3vvx3LRrwcw676ZZwGAGy?=
 =?us-ascii?Q?G4BcHmk2RT3g74ssmTs95sjcZwOSpBsgHmnH+hwS/Ca/nceIRsjPPnvxtD2q?=
 =?us-ascii?Q?J9PGP37Ch9Sy0YTo//LEjRxNxETU+1G3zV1MQbm9EpxNHLzc6kn7Q7VRXM2V?=
 =?us-ascii?Q?2c5rSlugJG72gWFNXDYNhtuecJZQfO9DIs3ndmHVe7w7suwVCu5ANKM5x2eA?=
 =?us-ascii?Q?7FTHZPF8l73ylCI=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8205.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zjuTy3UTf0kN2ce3p2+tONd0H36Z/FsvjKt+73Rq7g6x2YxdS0lb3iXTmKvw?=
 =?us-ascii?Q?t0St2c6N6zLgoSasv14cKlPX9ra6jrDLbdQRZYtUo9mpVAzc7gEWXPe7v753?=
 =?us-ascii?Q?q+T1XrMUdfjmGqHs+zmnTa1DHHUzoo5E7k/MSmQG3soq3zyS+ZBDJ3w9ueFQ?=
 =?us-ascii?Q?Gom/XWSJjoC+8mB8GWYudfZTvAnjTfq+eEbTSExujzoquwNVpaRCSU7Eh70s?=
 =?us-ascii?Q?SSwO731ZRzHZP9ZozrCZnRX5hIt/QijfWqASjyUUS8j74vnTfqjFsu02B3Ll?=
 =?us-ascii?Q?5AAgCa2FcbWGiPUVXK1YpMsfEP6I8hBPBRj2FeuP2v4w3jQC2mCxCLBDMQ6B?=
 =?us-ascii?Q?1tgSunKYRZUyPhe0WX2a7fpq473g0rhgUP+vUeEvFEyBh7JSZd5fquaY0Med?=
 =?us-ascii?Q?ZSXt6hv/gCpRgA5YkyZEpR0Ggj+FHA4D8iYWcziFP/D8Cwrkx4uJ7EGAbZca?=
 =?us-ascii?Q?811lY1LizDgWzHSMrSu076SW5/PP6iOvNO9kDJQDWTYNn3SoIQtzp0ptbBkv?=
 =?us-ascii?Q?5f36uaV19P6FOCGmsp/pAoskS5qgU/UMP5Q6UTw7kWZJ8BpAPz64bEbWlgPC?=
 =?us-ascii?Q?cq1h3fTdq0amEW6Sk3d1bdXsSUyXZ/du2IELmZP0RqVD8CtWtxPE4YTi+P9q?=
 =?us-ascii?Q?yGP/EdEpFXmLzkBOkBDLYcRT/mzzjafrbC5pXdv8Wi6ZcbByFYvHb3MBqf9g?=
 =?us-ascii?Q?jC4/aeUbpdbHbCZc17DVta6wf+ii7HkIyQVqrVIJp/QvSJl8RFlrMt8wF9Bv?=
 =?us-ascii?Q?5gwDIljoqBL/YHrwbXWGgcVOuQFMdiqjkZIFFysbOp1h266L6aUVUbbAE0w/?=
 =?us-ascii?Q?i6YJPd6T11yJlntFuKdhPixtpg4zoRB5jt30r2Cccl/sgZkWYU5lc9md+2NJ?=
 =?us-ascii?Q?qGn1KwHsIioNApDQWHW3hUXI2rEIBozAqH4Z+MsUdgC90v/GNcbJkhSwCIba?=
 =?us-ascii?Q?iTMR3NjS4IckCW1QMmQKEx7wwFALQ0FBwNlk6tHjxcxWq5TUl+2JXDAg4L2+?=
 =?us-ascii?Q?DCG1ZSI9oreCRVeHs3TlHcsJkCm9pvjPb6jcOhqE3oq74e8Q0quU/v40hTKr?=
 =?us-ascii?Q?pBmiAE4tJOTPnFrnLCgb8Nikz5ce+r7q9qcS8YnHlMRAXwxybW3CfjLDhmtQ?=
 =?us-ascii?Q?+LM7m/yPol6Cx6Qh5uJnCPuDJo7N6CuoYh/ed/YpJX2uqw3jws3ztmD7BEw+?=
 =?us-ascii?Q?c8vC7LR2aeRQer308Hpi9idF5c3HUU8HQ2I8m+GPYJJlCEt93k4YkcxiDxUO?=
 =?us-ascii?Q?9z30wtrRgcUqX2GN8mMkMDzBlI31i2kD2U/z7KFgo7NTLCD5xzJrhPY3OYo6?=
 =?us-ascii?Q?VubFfmEOwB/C2MgKCeuWqEfIDOPrEzyIMEn/0YAbWmaEQZOsM7Oqu3JcIt/q?=
 =?us-ascii?Q?jSRaC74I01yNYtlMwWHFuZ5mg+4Z+FyOTqvuObmh5W8lru1IGb3LdXt3GZZI?=
 =?us-ascii?Q?PYC2cuGVOIt2shVVazFQtzhYPJyp1ZFJkyToiqpFCz3zwJWkNoIzLE0KH53F?=
 =?us-ascii?Q?CYCTT/FJnFYGNjCIlhD9x0qRjZBMZC7KLw8cepVmx+w7i5lyXhVU57OhEIdl?=
 =?us-ascii?Q?hoDEv+Y7alDXx/Co9iM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b5290b5e-5358-41ad-a43b-08dd9f499252
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8205.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 07:14:09.6275 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kGrT4Lq/p+DWEREGGHLuNck1bZK9jm1Mhk5PYCF/eAAX5t4Y1Ue03zSkgRLGKaxx
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10378
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

