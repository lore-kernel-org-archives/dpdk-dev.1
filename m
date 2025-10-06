Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 048CACCA471
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 08:05:26 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0F1944067A;
	Mon,  6 Oct 2025 10:04:48 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010011.outbound.protection.outlook.com [52.101.84.11])
 by mails.dpdk.org (Postfix) with ESMTP id 75D74406BB;
 Mon,  6 Oct 2025 10:04:46 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iGfXVXmVfiBCogl4Eg8v249WtdLUCsLt+cOYYrBeMEp1ruwFW2vgrkGbKoaYc4EmxPKV+3giByDsDOVeO7pJqBYGDwUf9R+cR2PmOUzkb8QrAFsrKXu2tpSviqq2uWMQSgRKf6W2u2pFeR7Tl1oRcbOzJtnOL2CAESrL79gT9SQjtEkEgzSe+9ZSKhlHBUoxDQ+F84bmSc5fp6/ZGc8D+9LhQhUeszzRq/vgEDVBM5zgHr3Y1XbbQ/NqIn5i+LR8L0+qKnmK0c1mBezYiCQnQTDPvCp4YlCMBpPas2E6srs4LP9PjHZ9MTpIRjRkSvwl6zKrUwvTDPNRTRalMKNW0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=05oskb/bdDjbmACzreFkjjbVL/TncYuZ3h68yvG8ulk=;
 b=jvvG0bW0qXdNKDbOzqF9++MhQlHsibCMdKpSluBF7gnhpRAJIYcWtwcDshy/T+EHoBOLGiQl6Sqbz5QHhrb+VeVu90JEq3ksDrkVlqftQYxcs35X/Dyx5Mrdk7145p4hqGl8JumfyGoVbxmxYhPZZ4bvOcSbg7VhU9KONaR3F95wFfknFMXURm8jTwDbAq9nKk3FTCm9qYFZmpodRbZgiLG7SX0Y69MBDEwC5Rskud4HKMD5C82ns8IjCAifnoNT8yfA+5l4pShVPE9N+flWH1a79vZzap40u3dFrXh/xuJ+ze86xiR3W0q0p6TTi8MRJfQstX2SnDRIhIrVUFGSWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=05oskb/bdDjbmACzreFkjjbVL/TncYuZ3h68yvG8ulk=;
 b=SdGQpbJEIXT4PLJ0utSXbtXbsIw0dytDR15mVgKj6zDYCRvkghAQiXoiaxmiKNks2v7SuVhhkWKSDPpDYJ8tY8uMzKaEQ9aJscrJHKS5bjwUuWB/FdYJp7zS6NPuISjXOGn+iLU9Mba2UGozoxiMcwNMihevdaWDeTJf585RVY+VkxwOw1B6q1DIi3U3cV4GKF5UMdfJrI3yeWdbrwpQEd6rrID1VBGX84xON0iTTns+L2IHRXS/0qQHinL4JOMwH5vLRBJInoiwDYb6jaZOkq83oTJuTkjcVUzgXXRwzJGb9SSvqWbp0X7v8heGP2W0fnWhucETRhElAp5rNgklVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by AM8PR04MB7842.eurprd04.prod.outlook.com (2603:10a6:20b:245::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 08:04:40 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 08:04:40 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org,
	stephen@networkplumber.org,
	david.marchand@redhat.com
Cc: stable@dpdk.org
Subject: [PATCH 06/11] net/enetfec: fix to reject multi-queue configuration
Date: Mon,  6 Oct 2025 13:34:05 +0530
Message-Id: <20251006080410.1433284-7-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251006080410.1433284-1-hemant.agrawal@nxp.com>
References: <20251006080410.1433284-1-hemant.agrawal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|AM8PR04MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 037c5aa4-88c4-425c-6d74-08de04af0036
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?dXvxxO0utSk3bVQuhbxsGydfyGL8k94jg32oYw2UFesYj6/PfpGVpp7fe0Dj?=
 =?us-ascii?Q?bZKH6YXNKvFyY2bs1WxlYFSexwhiR4xFpT1z3KCZ1fjRE3AlP1W+3IDi63Aa?=
 =?us-ascii?Q?wWSGm/LVEJwSq6cZ9mSR5Ua3bK9aIWFlt260HTRdXV6wTD62rCnTMMNHt5u4?=
 =?us-ascii?Q?VsUhwGsWYYKVABG8qFv76iIl8s8GBgTqc/vu4IeeKmUMUI+c9+7wq8Bek3eh?=
 =?us-ascii?Q?V64DZayuU7H3mjfWkNPS/VmEpnw2HPOskB42uiDyfj8Cs9uytwvdO8XWrCpR?=
 =?us-ascii?Q?9fUrgCiHN5Xfyrnhq/HblSyECDs+cfIqNhNkgbSel8SxBuC3zF8r7sB3TAcK?=
 =?us-ascii?Q?kwL2iYU9a3Fr/w6ku/Gf585WpbyvyFxzucm8RXAeQr4832WMqk2lzXW1b0PE?=
 =?us-ascii?Q?hCn51a1G8eLjIDNFzURpEraLz18Y8D6SXdp7E+3Pd36Hr9dUz893+DoYvEHu?=
 =?us-ascii?Q?vxt1WG1ekR4bRjULRG5YvLbxtoi5o29pETDIG7GT38sjhEaSXPZsuYnG9gns?=
 =?us-ascii?Q?mfDTc5/LvTbK8ovRS7p/sBUMmJDN123wjaSEuCmsZixlQWtnT0Ejl5hwG0Tm?=
 =?us-ascii?Q?q/bvpjWbMEig58/5VuWfo7nN7ris1b8lKwBHnEGBF+DnJsGpf0MQ5bTxuD1O?=
 =?us-ascii?Q?k0JRbSTgvn8zB9uuOi+mHnHlGbaJE508sRg0ubxHLrKnIWMm37X9N1EFe/W4?=
 =?us-ascii?Q?Em1B7KZ57scqT814v9KN5JM6dCj6Q6qlhrAeyx72dZMQb7FviM/kSjxKOWar?=
 =?us-ascii?Q?atZY3wUWmepaUn1jApWhyLyYphYxH/ljFXdcSOFnuGtCfnZZ/r1+NS091fRE?=
 =?us-ascii?Q?CM59TL2H9JYaDY7or769VjibMVUB0nqm+2Qg601Uyuk9a1efg7yDZmNGlUZm?=
 =?us-ascii?Q?9wWxIaXpdJcaeOoEJlvaKj+9N3QzHqw4Jg1JgebfkflS5O1hSdVd7ypARwV6?=
 =?us-ascii?Q?w/Un+7D8bjCft9/ma0fsOY7MCt7d15z8FOzLg+S99NpMT3e+yCPKaWEh0Pgu?=
 =?us-ascii?Q?pzapVFUs03TI0/6mXq5f3+mf2GeK59i45KoPr/BolRZFmtfz2ai57Rjf5h1w?=
 =?us-ascii?Q?un+YM+NQza9hPaujuzwRjkBvxEMWxkoxyTcms5SEUoP1aXxgPaDmNf4DIzaq?=
 =?us-ascii?Q?mqmZwEAjBuuNfLOidVRTGJR/qnrPaE9YxG52CyJMXVP0iR3Pxg7Fa/Lw4ooc?=
 =?us-ascii?Q?nhzso76hPVZMXQ/VSaSovLBOFI6ykLaXXPb/wdavvxiOkMFuhfNXGxsJzVLu?=
 =?us-ascii?Q?ME/IPhBAOkI8oCZWOPx73uW5YUglCv6wzdzNGEddE3dRG3kvgSsGq5qbl+gx?=
 =?us-ascii?Q?J9qGhw06T5Gfpbtm+a5fEAz4ZcY5mYi3FoRiuf22YPrHNNZ8IKT5QlvzeIxJ?=
 =?us-ascii?Q?7oJMt7825riuEQKm/6xlKILr2bV3t4omvFk+yoHrgagqjqgez9is9K5F9OTA?=
 =?us-ascii?Q?zppCDYT2lqTF3FW6sfceXYCAt7PurrACt26ckeFHrwuUg47ttyROgXql9SD6?=
 =?us-ascii?Q?C+M1FpQGTDOpwMOhcAUkDTU3pZUxFJOrNR1U?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?44zBWfaOKJ3lAWfLghrwe6Dm3D7JglD32ZyV6C49DtpXZgD0qhE0EbrpqHV8?=
 =?us-ascii?Q?RjwIX8k3wF/6Os2MEzcZZWb6rqtncVU8jE/okXDW8vILXL9HqooZe0axOn6s?=
 =?us-ascii?Q?IWXkkRpgOgduuvtcv5PlWD5+pjpOAb6V2uYOvbF5DB4Z+qmDNSx0ynAsw9v2?=
 =?us-ascii?Q?6qjRkYqMDpALpC4VGE19KHB60n2eXkxVKcmlmBAiqQM/9G7ZkhBc4U66F0q3?=
 =?us-ascii?Q?mZxJ1c8Z6DFRUE4RdQzBKTwJPEEfKaaQVpetswkxaQ7cvj05hT0VU63DCkkF?=
 =?us-ascii?Q?+L6NkfOHbeRbXdFZK7jzNDXUX4X56Yw4H97Hr2mUyZUl+KvuAea6hx0lJ04M?=
 =?us-ascii?Q?xFM4yAv1gPTj5ASOOIJFZQUkW/UJTyzUjmgPGYgdLGaOinoI7kHUZzs/utVe?=
 =?us-ascii?Q?zmN5hisMEOOJzGC7Rl6P3TRz4E4oD+aMXGWS0LhEiq8FEDibBCUPG5XFeyNc?=
 =?us-ascii?Q?/6ILGN55i+g2NDynQIabTYW++O5sMip6zZqomBacDEWBMut/cPEVRX4J/NFf?=
 =?us-ascii?Q?H9ZbJiWhrIIDCGoQpXcGucxSHAFJpErS5cUZPvitHVIJgD1PGVupNo3KY3uC?=
 =?us-ascii?Q?/dxrOFe+7xud0zFhyAe0s2jsZTX86LVxqXXkR3vWJsTfez4N/SMq661d7C+G?=
 =?us-ascii?Q?yx8f3D1XhaR7fBvCIOabFd4jnyJQJ91jvXkljQVdzBNADoKdmIxZ3spTTJb6?=
 =?us-ascii?Q?EHvHiZ0BGrI24rkuACejka6/KP4Widd4bbY6L9mJvXgh2pl7/CIokfLzRlKI?=
 =?us-ascii?Q?HOqEGGjJ7P5xHOgvtNNdFNm2VOQhWJ4of3nYBN+rZX7Hii1Wd4aOOC/akvkd?=
 =?us-ascii?Q?+lgqRHU+LE8U44ncbDD8QHTXEFSKV5q9J9HlOqU+RN4TL+dLO/PtJgis7tf9?=
 =?us-ascii?Q?Wi4uK7OGzJmDzIg7PvuNwNmNKmWQHej4F+bPa3FS5aDYsE0d+IN9fXvMxWz3?=
 =?us-ascii?Q?IDkNs1QEFtDBH3HuZiBrH5zn2Ugzj0pDcc2jkz6oO+7So0/JQR5XcF+fMAFK?=
 =?us-ascii?Q?0sRVxNx3/HWCuQKpukn5BGpEHdOusSPjCS34Sf64ioq9nxJFu5DuziBZMrdU?=
 =?us-ascii?Q?TQs4JHKWlTW4/eTTyS0kKouSEcgiozTxXTriRovzfF3ywbuTJHG/y5rRulWG?=
 =?us-ascii?Q?ZaXonxHeG0hkw6sv97Y32TfBqiRiWSvF8VrsngSkRPgC+KmJzLbHYXXKjaHb?=
 =?us-ascii?Q?kJYNhqD1sf98Ooi+cbGQGXTXUf7Fb4qbKg5wxnV0y27QRpTjOdaDsyukA3d5?=
 =?us-ascii?Q?I+58BKF6SaFhdV8MpFynuoBmg3kl78SdZtgleY40X7ykwnUmEOpDZY5fv0xW?=
 =?us-ascii?Q?V/XQo+ZU0RoHLfgaHWEld6UEas1uBBzINJMpnuvqDbotNAkLDaoP+b5nPjCb?=
 =?us-ascii?Q?cAejtgSyBYbJ9jQL7gQQMH5mWyiWe9607pL1qMLd8HrEqQZeLXlAKew3Arjw?=
 =?us-ascii?Q?bJrL22jCtCXOOnre9OWsLKSxguWTT2SPwwqCsSIfZhSiDePXfum2xDKw/gOm?=
 =?us-ascii?Q?xJWGKkJESYNiJQXJYQVt3agEc9AGml1/pN2UgU1IstfG3UbEp2WQEtvU7kx0?=
 =?us-ascii?Q?4oQXWLBczw4RG422IcQg3BEVQQRjk31/W/RLJHhkWT1fd/oKIm6vDhbuZo+D?=
 =?us-ascii?Q?/w=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 037c5aa4-88c4-425c-6d74-08de04af0036
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 08:04:40.4542 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jZPJQYoOpjrH4COBWlRSNFH022tIs549j+t8+YwK4s5knmlP+eDV6BaMlGzAas0yIuTeV8IZtN464vZobBc0Nw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7842
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

The enetfec PMD currently supports only a single TX queue. This patch
adds a check to prevent users from configuring more than one queue,
ensuring predictable behavior and avoiding unsupported configurations.

Fixes: bb5b5bf1e5c6 ("net/enetfec: support queue configuration")
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/enetfec/enet_ethdev.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/enetfec/enet_ethdev.c b/drivers/net/enetfec/enet_ethdev.c
index 16f36a53f1..bcecab828e 100644
--- a/drivers/net/enetfec/enet_ethdev.c
+++ b/drivers/net/enetfec/enet_ethdev.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2020-2021 NXP
+ * Copyright 2020-2021,2023 NXP
  */
 
 #include <inttypes.h>
@@ -377,6 +377,11 @@ enetfec_tx_queue_setup(struct rte_eth_dev *dev,
 		sizeof(struct bufdesc);
 	unsigned int dsize_log2 = rte_fls_u64(dsize) - 1;
 
+	if (queue_idx > 0) {
+		ENETFEC_PMD_ERR("Multi queue not supported");
+		return -EINVAL;
+	}
+
 	/* allocate transmit queue */
 	txq = rte_zmalloc(NULL, sizeof(*txq), RTE_CACHE_LINE_SIZE);
 	if (txq == NULL) {
-- 
2.25.1

