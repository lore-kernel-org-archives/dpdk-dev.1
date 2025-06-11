Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FDDFC677C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 10:52:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3185D40670;
	Wed, 11 Jun 2025 12:52:16 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011014.outbound.protection.outlook.com [52.101.65.14])
 by mails.dpdk.org (Postfix) with ESMTP id EB8E04066E;
 Wed, 11 Jun 2025 12:52:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=y/6iMDrIJygv+53BBdmvA1fW2Oio4yb9ZYZvh1mGfpf30QtYeYAxdM5EjXJN/rAyxPhPwrFgfwhN0x1iwOaKxFTPV0QIdeI9/c7fb0w7vM0eB4FtaZ5lkTgDRTXDJ147r/IssKm6VsJQLEOcYfvmZBOLvKNzUi8Fx2lpH+Vqm7Ywk56GqnjDz551pCfn7Nc6u2PowX4KAzRxAPME/DKxHD8fP4H8pyPdFOcmnptlLhZp+22sNLA4xtp/a/9ERv7wB7D8qgwjaT4Qw0AQ1RVm4XQhQDRbjHpfnjbRRzoRGWEHZWy+cUGnPnZCkmmqpVygZ2ws0RdSSoCxQ2cOKNJ//w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVHq0TNIaGRq5TS3Hr28WJnHZgl9Sa9uOIZQWoEGCMc=;
 b=VCw/8hsTdM8ewKxmo730Q8lxWyBVE9s69j7yI7DRCxBn0JeUclTwMfSnlBGDLHL9lCtqSAvUuXkeu6Tii/34ll8M2Owqnd/mvt2KjxhrBmvBc867imyfHj8kW0a51TJItQXfNY4JjpM8XO1lE01UiFX585j6QCf/vqYOeGEHaaQMzYV7prFKPzMDmFHh7ZJbo0S4N2r8dmHEv7FLRpuBiPW+7/YyramY7/H04cBbDY5TBq0pK/q9LU264gYr+AySqGaenWT7a9065qlx8CGBoSDhX+9qLbRXtpVC4W1xPBn+sggOad0XBbQ57RzggERgsUSDHovhl1OkxeQ8iA/EUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVHq0TNIaGRq5TS3Hr28WJnHZgl9Sa9uOIZQWoEGCMc=;
 b=TyjWYTS8AR3yMPiTMwq1bUQCELCyTQUdnVDIatZFAV3nMWHH+3UjpE8slCMVbnToGf2P3XhYNY++cWmg98zIort3gviX9UcnsP7wmXDN/XkBnu8ZaVg0C9s+6blmGRO4LyzhwQwo4XivsYTlfnQqoYMnhXP2X2kMO4J4Mk2ViY+lJXzI/dBLHifOtWb/1DJZ+/G68vbyfjftvWzoRRxkI6sDqd/9ZSuJP2qA6AC9zr4SzPILHJHGsp+4zC5ZED18qEJAzEzsQNmRmesza5gK995A/z/+d5k4HNcMJZGrJXyauF7wH/7l3qbCnuFPZQgMBoACKbWvlCu+RJUzU1VvTg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM8PR04MB7348.eurprd04.prod.outlook.com (2603:10a6:20b:1db::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Wed, 11 Jun
 2025 10:52:11 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 10:52:11 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: stable@dpdk.org
Subject: [PATCH v4 02/11] net/dpaa2: fix shaper rate
Date: Wed, 11 Jun 2025 16:21:40 +0530
Message-Id: <20250611105149.655144-3-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611105149.655144-1-g.singh@nxp.com>
References: <20250609025450.3997062-1-g.singh@nxp.com>
 <20250611105149.655144-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AM8PR04MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 212b0282-9e2f-4830-6889-08dda8d604e5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wzd85hAE/0jD9RAYDSpzu8WMcS7jHX2lk2sUK2qVVJBmgoExJy2uIQD0bH6p?=
 =?us-ascii?Q?fdC5TU/Ol2mkClhHE5LdPEK8fQAQvTXoRca0L2hoi9xFmVbOmduOTxqszbcL?=
 =?us-ascii?Q?VBUYE0n0Jd7xVWmfv0pwKUEATov5iGU8kYRKu1BAVGyie91eHc6WQ0qclRs6?=
 =?us-ascii?Q?9PreGJLYJ/QYxb0k1W4R6+ea5vnNCy5u9WYspTzIR6ynG0rzxgz7QIlu/qXU?=
 =?us-ascii?Q?QgVt1VVbSJnsZ9PrUd5WPo6kG2durWvRIWRVLVn+01zPiMOZ+EJdT/6BB1m9?=
 =?us-ascii?Q?RcBWLrtcymRZMuIKIBQOz8vvdFyIVp+jzW9pLCA+/gBvlXbU9SAqEPa6VQFT?=
 =?us-ascii?Q?1PvhPqwXxiLvVJExJSlacxD8Ax9+8XF2UUvPD54m4Z89q0qyE1ftvLHa4DBg?=
 =?us-ascii?Q?8R5nuxLLh+DYd4SASzwU4onNY3rp5Ye/FlyuMLJO66scK/YWbMgjGIFqvYtr?=
 =?us-ascii?Q?LMnqmtjdJrh+qc3NYquB6x8DGeHFg0KkIySPV0bq8pdhacB9hhYUzXEU51rA?=
 =?us-ascii?Q?tbCPU8+0GbL8YJ083LD585BrqBKyYymrfAG8jTzUbkd0CqFcbxNjXZJdMet2?=
 =?us-ascii?Q?aWXJvZfdV5UHIKHlspaBMDiSIDfifYzRj2ama0f4+E+sGaOnqj3r9TKVIBHB?=
 =?us-ascii?Q?vkxKrIIe9VumwJ5M0TasiwHh3Kt4o6vPP4JP+gXbX5mUzdbQT93pJWPebEHS?=
 =?us-ascii?Q?PYQidRtpgXNWJ8s4cOprSn9QKC+vxTFP5vdWJEARhP6tXTJGGddVGzGsKmic?=
 =?us-ascii?Q?dngrMiGN5y+wSankYkPFem5raiKSWe3J94x0B8nYHNa0H4/iUiT1e80KqkAr?=
 =?us-ascii?Q?kmMdJBsUC1WPT7j8EvgRDQaF0jKw8FfYr/tErA3y9QeYFRgk9dSxCVG4Kdj1?=
 =?us-ascii?Q?ieGoKVHES+PYLz6zk5ut8alcyIxNGdrkP6Cfyg/IYhBVDk9PnYDdL4HqCyXL?=
 =?us-ascii?Q?bjI6bsOy0rxUeCa6ylIIOH0MlCaB05fbKFlyuYTijgswPZ6sSQueLz6Pv9le?=
 =?us-ascii?Q?mesRuJFphvt3T6L5kTi1jMFKc7kRExojM0n7wNE6IPGLVPqodRlw2l4naUWB?=
 =?us-ascii?Q?ZVMc7qhaSxuYnhO8XP60BVdZvZI8Q72HVnMRjjD1OHwHWsHtZkRqd9OOrKvx?=
 =?us-ascii?Q?YTdTcde1KZcc5Vg9HFbQygek3QFzINEjaC+u+QNtPMh+mRTZiPdg7wjd3NB3?=
 =?us-ascii?Q?glSbuOHRwq6f15Z+mW5ZAlKxRo8lUlfTJ8eaHNGjXfHRgRo/EjFumCU31/RM?=
 =?us-ascii?Q?iKxdAKaAUuDyouwV0fGE0V4LkPI9bpGCfnmWDgdHxHDhAK6jObieUPXPTnLF?=
 =?us-ascii?Q?XuHyKPJT7HlBqxavBYNqFVmGWFNgZ921cpg7HePd66AL+ItsUdCWGCd9rx36?=
 =?us-ascii?Q?zAwyoUYo/Hpya28Vi+wCTSNitM9rn5OT+r0O81DSXKZlC7hK1YpFBXN0zwN0?=
 =?us-ascii?Q?wXIOe9WkpbfaNMaedBNlW2hEJ8XZAUcRn83AIgiwehksSpdprJ2PcA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xX+wJJ7Yws4J8uFbkwrEDyJKWcWO2cjOfUYrNt7elLgTg1NEyequ5LQpoqkL?=
 =?us-ascii?Q?bul/vYZvXrx11SvTTOZ6ODP/UsiruVBQ4aRl4hbSa90Cc6dVrFM6L2/LDInB?=
 =?us-ascii?Q?OCpdG/1Cu6IPYoNyKuOQzxLEFZ4p7epb0VnvUVp78ZURKG1E2r68uFMLce8k?=
 =?us-ascii?Q?yQjVXa1OVhUh7wwlEOrY/oGQ4aR/quLw2oC4pi1uS6BF+bUgHGzWWnLPf1YI?=
 =?us-ascii?Q?9T9uGbEeTS4d4h+xwY77oIhpGDzl91wZP6EphtIkJO8+UChj5frIeMx+UxKg?=
 =?us-ascii?Q?ntcjsXVmuJ4eSaKEo0kFsMofcWueRN66npZK3bd4jXEI6xPqFRCfxLjzrUSl?=
 =?us-ascii?Q?v6xIMOUuey4awYM3kRRVfrtIA3wrkXrst6XiwdwGJjycfcfUK7UEsgcxetUa?=
 =?us-ascii?Q?jkeEyjxvfenn9nAFN48SjfLx3AzFKZgzEaldmdAWhYGbfoXOqNBOj/VBFxNY?=
 =?us-ascii?Q?wWkzbM2bojRCMJ7Qc1mo/lJ6treh3oaTEKEYBWhtxasVJ5l+Nr+Wat0Dl+WK?=
 =?us-ascii?Q?TiE/u7jwh2flAbthE/7/xK0HRICigvEGWSizAJM8i2wNe4cDODd6a+6dsPrX?=
 =?us-ascii?Q?FvalnbzaSt7vL7fZtm8vHyKRdQ1rgRKtrFh+uzSJMIOK22GnTemTAqJ5c7fh?=
 =?us-ascii?Q?mxnxzDkpANtNm6yQfAsSBp9lOiMNL4pvI4InDaNaCPGOCZNIzNADe6TloDGH?=
 =?us-ascii?Q?BvLdUZ9vo3x775NlTJQ1R/bYRwSz/szVZTR6L8dVNEyyyJTMp8qT4n//CO81?=
 =?us-ascii?Q?JYDd0gCr0Kn6t8jTP1i3KNHrWHobk/kfsDdlKyRmnyElip8fJgIQi4WBKoO2?=
 =?us-ascii?Q?T9QIMuLZIGk5mV8d4VU32HEV+gibUSaf1SlxjsALrwm5ACkhjuerSH0uLjqy?=
 =?us-ascii?Q?m7du2nct1IF53lTrVuR3dDafF+jKd0qGNrZO6fdAqIyP7GpFV1sKivEbamCw?=
 =?us-ascii?Q?AjJg34FNtDiegCnUu1j3grrPgGjsl+LGwsJChafJehniqUpdK39POIC56uTr?=
 =?us-ascii?Q?VFliHksbh6xQZ3ZsDbvo39eJmzfUtEgjdLNbH5ICSoqpbv98OyeQwh3n1cTp?=
 =?us-ascii?Q?e8o016RdfjxBuddfMMTP/Jeg+8rgBPtnOACl349fZkqwLVmxISi/Yh0G0odS?=
 =?us-ascii?Q?fhVk1wUG04TBh+gtNe63jlPqgprC+Frpu455muZOpDRJ9tZIa/zFkCDJDg+f?=
 =?us-ascii?Q?KhrCpq+u+jfnM+KBvq3IFGl9SYiOh4zJ6Zv+u1NGwTHwQrjsdrPI38dWfsy4?=
 =?us-ascii?Q?3pIUUTZKurKER+aenZV0IxW0mQUJn8UBCuacGjr6ZS2FeU+JVslJrbmLP4cW?=
 =?us-ascii?Q?eaU6ONbypUzwjAlCoI+wnjw7eGQtbmS8gAaPYokWf9UQLFZEu9a3MxT2ytwT?=
 =?us-ascii?Q?pTs4qLJHNMx0Zp3uCWkgfvPWrqK0kPzXOssmtUdlEHVgTgac7FKnvoJAdJPt?=
 =?us-ascii?Q?AFQkvH2kN0LTkhTsOlULnH/FEQtb/FgOiXoVYrdLIVO5sHAdLUNPlDdGRA9e?=
 =?us-ascii?Q?g0sA35s1fhz1irmzKLhQR6roACnMULk+x1ybGME4IbelTPtmrr5jT2y2Pqt9?=
 =?us-ascii?Q?89Enj/ne2hbVOln3szQ=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 212b0282-9e2f-4830-6889-08dda8d604e5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 10:52:11.8413 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hLXbt8zAtZFPe5wy3E6x7AjupZvCdCi6yNfxRyJtAK+HV2tfdcSj9QDe2FyVvG1j
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7348
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

