Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D9FCC5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 10:41:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 323F040649;
	Mon,  2 Jun 2025 12:41:06 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazon11012068.outbound.protection.outlook.com [52.101.71.68])
 by mails.dpdk.org (Postfix) with ESMTP id 2AEF940395;
 Mon,  2 Jun 2025 12:41:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gw9Rj7pbJxvH8vnZnkP8HHkbw3qMGhHJ3qIQjiJJvlC1pOgR6bkQtSZ0FqZ3Y19RkQQDfisW3bp9NSjIORPNTZQWs+rcVoojsaaoZYiCwQ4xu3e9yqAwmkSibLidbSC+ZsAkg9zorhHAC05dEDiyu61BG5gnQ5Ui09uZXXI5dHBtERPPuibBlcuLFVNUjfVOZ1ZxTmnqHjTChAxZCABiU+lVGU4neKypSHnfwYtQEcno42NLWmR6F8JKWsCVza/ZiXBEfEJZI46KxyiA3RNk+9OBycAd5gXm0sk5R/0dVzV8mUGsKk6MymToLmVE4y1ZupNVq2BhkxeqAXegu6iwbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVHq0TNIaGRq5TS3Hr28WJnHZgl9Sa9uOIZQWoEGCMc=;
 b=NXkaDa9eOBgwg35gbyNl/MRKEepVHTl/rTi/gtNyrEmpbYV/BZ89qHWBAJRQdYjHWAxCc+wJrLUpB5YCQL95FbB8h5fGcXVT2kD4k91F78SufTq4Si90oQLPx9Fz90DE8opfuLm2qAlAb79HkQN+3mgSOs2BO5VERv6uJKn1jmezAdujF9wAAwSD9+ZNnBbXGdjmVq4LhF6g9i6VVDNprXhKwATOhFeyBlDFdPF/2zZavtJKw7cjK7Vp+cZ7C9+wqjZAqm0nLaO3Q5NwuKS+0eG3QQ1n1X5PQ32APQk3t/pBYIqmlU0NpGAJZanfRCgZZ51zil6ogPCGmquH/ZQ1aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVHq0TNIaGRq5TS3Hr28WJnHZgl9Sa9uOIZQWoEGCMc=;
 b=Gz3tCvlUjHdci9MgF33CyHhJTy8kTzU78d5MXIROgN5gdoysBvd52f20fGcbSSR2tw5ADMwViBaA0QiwxZa7e7hVIW4ufthRUMdybjxFX6/d3Wdb/yoPism7oNzpkpJXAUlNxU8aVfzGGD4cdOIvlOCnW3v4AzPfIdieJ64mOrVxiPi9xmKBphHMtO33E/MhHmxM2Jm3lbqDcmWDSOOY3E88XH/EAiZpV2z8i/yI72vpHvEvBQ9hOUjMAQ1YNp1LeKP/AkcGOsct+YEU4qAch94rJbjkQaAva17bhUwPoimSZr/Nh3tSq7tJDLE0lk4Ox6+EEstdRyzfhSbvBDQ4kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8194.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::7)
 by VI2PR04MB10956.eurprd04.prod.outlook.com (2603:10a6:800:276::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 2 Jun
 2025 10:41:03 +0000
Received: from AM9PR04MB8194.eurprd04.prod.outlook.com
 ([fe80::cd61:3920:b12f:6561]) by AM9PR04MB8194.eurprd04.prod.outlook.com
 ([fe80::cd61:3920:b12f:6561%4]) with mapi id 15.20.8769.029; Mon, 2 Jun 2025
 10:41:03 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: stable@dpdk.org
Subject: [PATCH v2 02/11] net/dpaa2: fix shaper rate
Date: Mon,  2 Jun 2025 16:10:32 +0530
Message-Id: <20250602104041.3322164-3-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250602104041.3322164-1-g.singh@nxp.com>
References: <20250530071344.2939434-1-g.singh@nxp.com>
 <20250602104041.3322164-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To AM9PR04MB8194.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e6::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8194:EE_|VI2PR04MB10956:EE_
X-MS-Office365-Filtering-Correlation-Id: ed306e60-5390-4144-4f2b-08dda1c1f8ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?3ILILPvdD41cNM/HSAzaFncnhEp7/MUUGbqz9zvfeognNUJYpv2Wop6IF3Hx?=
 =?us-ascii?Q?kpzUAeqb1+hduSUzGasIsmsN8ItzBm+/VV7Kn2hi9nm4WKRUHvrCNUjOOq45?=
 =?us-ascii?Q?ZYVYpMPJHmqT2beDKHM3jOldL5kLEsVx2JVrHewdizfVhUYa6QUk0W2VA3B1?=
 =?us-ascii?Q?I/OOW8MMhV2HD+ktBIfodvTK9jJAMcLtMI0N03LmVfi2bh+sw4IiWp8a+UYk?=
 =?us-ascii?Q?w82RQWN2uhdd8DXVICZKGeDz1s+sM0I4cPdeu7CxbKl1U54d5SqsivgbqzV3?=
 =?us-ascii?Q?MwOctUu5R1gBheFgjBwc8dHv+Ju62+saJnTm1fbUQ+nDE3cOlrnkLZM0YGyX?=
 =?us-ascii?Q?DXY5YyevCf1J/Jl5WhHPNK+4gD78DM9MUNQjA/8n+GeVjd1ySMspjP9mYI1n?=
 =?us-ascii?Q?JAuOpobcxnuifa6K4zTMeV9/hT+kXRXKyKJWxrrQrjbS1sYMkWM0KdND7BDR?=
 =?us-ascii?Q?wwQ5vFnrC/Zwl1F3rAhJfZsGEl29UlJh4MPS2QSookiUy+TXdSYghmrGk8Hg?=
 =?us-ascii?Q?T3QYgB76jB7vWPECRjBlOxGwkOaaYX5BI2BvJo0yJAA4u/kadPrqTb8sWs3w?=
 =?us-ascii?Q?kjL4+U0ZY2bkArxtQis9ZJJn/RLKOB+Bb2nQtCHbfMj8GS9/U4N8eu1IPkfS?=
 =?us-ascii?Q?aHQwrVcEwUDZPVBw9j+B1KfEyoOLwgq6ZTZc+bSmJ/3IvNvZzRMjyYM4lo0/?=
 =?us-ascii?Q?3s/rBQDG2jd6WN6PGNV3y3vojZzVoa6HqAFO3NbPiXD6XUZTWH3/Ku7Ffktc?=
 =?us-ascii?Q?7MsGgin71N2lj6+KG5dtfGJQ+4wgVgNrrNNFlWNWW/TFIpm6ZC9XA+ZVR/eW?=
 =?us-ascii?Q?uB8m3R2bDX/iXX6WdMq79amUAftF2WopitUa40DCUxga2TZWAaUJL/McT8T0?=
 =?us-ascii?Q?F8dJ4mchhkYkf/Hi12NI/tMVuRhRhYEaRnv3mCw1plEoARUan7/FV2DJ2o0Z?=
 =?us-ascii?Q?CLp9GWDqjtHH7AlEbqecWTNUk87B5Y7NVOQmlPX03SttYk9cgYp56wzp8Epy?=
 =?us-ascii?Q?CqWQBXDSY0Th3mJyVWwaKHTHEvsX5O+h1BdprDJbFpxDyfTETefFqJmIvkhl?=
 =?us-ascii?Q?Bx8U5xRoajJ/8lrftSdzB251VkqkH8HXdyQt2vL2CFUiD0T6q0b2l2a3d05U?=
 =?us-ascii?Q?T2lkDoIXa+FmcoAvuUtNteVQZuu+R/VXGBCPKm2ASc5YlmuqS1ORw8+c1OFd?=
 =?us-ascii?Q?6YM1mCv6x9Rzy7lU4l18aZNi47TwsxHl7bJnWTpKbXTvXfMH1SnDmQmiuMBo?=
 =?us-ascii?Q?48OLdu4cLlja9fR4xYEUKRsFFX4y0POZvb1nVEZj2eMW+aM5aiC0L3gu+KmW?=
 =?us-ascii?Q?v/bFVIFayS3AK9+8PQfwg7+JLkLPAvTublxKqgcriJEV5YfHSNiC/VUwa1/K?=
 =?us-ascii?Q?9eFTu+V8s+wQFaF4VZ2bfTpZ95k7EYMKDLbfV4Too7UxbKEsUKDWFIzCIAlb?=
 =?us-ascii?Q?D8e/Wv6UxUSfr9e/+G5hDqQdmyyFHbE/yAdjOw+OI4h+bIoLrcyBje10VM+8?=
 =?us-ascii?Q?8SdhpRccmPS5l+Y=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8194.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1utn0Ab1bx+9TQVv0XTUI0BoE96l6Hc2DKKz+f008e3bz0jvG1P88q6wr+4s?=
 =?us-ascii?Q?stNvEuCLIlaV2U+RWvmYw30DNyXJR0unhS0NXhb1T5WIf7TpysAmz1yRrQRp?=
 =?us-ascii?Q?qC88XQy+x15l1AnuHY7CexMo3/43F90EMamEs+1pvmGUxouNuDZG9VsAjdm4?=
 =?us-ascii?Q?LYftIbgnWRh/k/1y14acWvfP9tZmIj69AyH95aQMUJY04Yib04tqsbKxH0US?=
 =?us-ascii?Q?uMTgfXDvYsu1hsXo3DcrhuhY4VlFXGEqkkdifyZf4/6C8l7rhnJFldYco7E4?=
 =?us-ascii?Q?B+dTtlrS90kTF7TIhA9qocYF1Md7ns2DZ1V2P21KnMdYsE+vLC2bMe+zQvqS?=
 =?us-ascii?Q?pL/35ZbJybcXh4LO3dh81gTKeIdbp11uC5UmO4Dn6CsMMmKgiu3PduRIqrwL?=
 =?us-ascii?Q?N506x09IcXOauctcdXVTRfxT/TYqAAWstYzqjfV/mSjBoCPtOheJeKfA/yUY?=
 =?us-ascii?Q?U9F5j7+QCU0wFcLRhQKuqUVI8rwHDAFDuaZ18dJgNRrdo2UqavgCzBaqaBTk?=
 =?us-ascii?Q?uW+dsCB3mhOVxVSCHXF537pnswhiv5LpXwcZ9lrQZzs3pO/mw44oC0H1ANNB?=
 =?us-ascii?Q?e5fYSv7k1G8qjHEyxrczbE6mfJm74EfoyibUPCGbVKTm96x6X0JUwbPImAsT?=
 =?us-ascii?Q?fZJ8x3lVmjMiXLqpjp1iDVQHHQ8951isCJj0MhDf8oOFT08p5zwSL2rI8ups?=
 =?us-ascii?Q?W/KrQnMXDjHTB+t1ks6tQpTkgMTR77bk9zF+0YDResdhzI1DlLlRy7xPv0IG?=
 =?us-ascii?Q?91fHzzfe7/ePetK11CYa8kg2le8LphX4ziy5J9J+ACpuItYFbGD2CKAOTB3F?=
 =?us-ascii?Q?oxVNH3de/CTrJueG73sNu2W6Mlg//GnWXUH12VVhQUWD6iXmHB3DaN6w1KFo?=
 =?us-ascii?Q?qpMiZ+KvTQ+PSOnVX9ltiqziL3tGCksf7RZ7kWN8i7k57B23JZMCUPdqaXwJ?=
 =?us-ascii?Q?hsmU0w3VQZUWOoORWzsmXweXpBvZ1omivpGiA23CdpQRx1ORxUUDn4eELBQS?=
 =?us-ascii?Q?zbOwDxp3LVe/0ws+zP1ooU7lOzIJJxFdicC/D1W7hAlfvGp/2WBkX0QUgZXa?=
 =?us-ascii?Q?VZ36G4A9EJSq9B3E9nuviE0i+orofTv0nIB9dKdIfSKhjU6rBFKsgcqLdNuX?=
 =?us-ascii?Q?vsuyYl9AqwBCsTVD9aJc7WQ/2FQ8sX3Ry2jaw22CIo6ndE7aRKAK8apxvf+t?=
 =?us-ascii?Q?QcnwuJXQBSNf3g6ycUqmG8bgnc4BlkCuLDCEQlwSNxbuBUaPi6PrJdySYx64?=
 =?us-ascii?Q?mcThnzhT+sCqIwlS2TwVCH0Guuc5mZ9SxRu18YFcdZR9VZQGDDZG+yZeK/bu?=
 =?us-ascii?Q?AKsDxIXHhi07pj2yPT2tPODmh8tW7vwtDIQ7/LTiDZL5l4ou6qVN+01W26OW?=
 =?us-ascii?Q?EKr0tbvh6QdZM9Gn75fWFOjNVUzdfqZQSCfhtyzpuc3G+lbKNBzOLVnbiEtW?=
 =?us-ascii?Q?hX5hj8ghy8d9R4K9bOqXxtpA5pvMOxNSFz2Rp8TARtsYO2jEolDP32rXjUZ/?=
 =?us-ascii?Q?35T7GpIlo94xe/FuKdsUiKMQYCCaF+7S8wuCZpIMuwpjKycIB3j84PVhx7Z7?=
 =?us-ascii?Q?uOW/nS6bwxEboWjBDXU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ed306e60-5390-4144-4f2b-08dda1c1f8ee
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8194.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 10:41:03.6834 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hNjYHK4Wis3D5IYfP680Q3CaipSABX3lCgGOr78Z8wsuZmMEpzwIuuamIuYlZ8h3
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10956
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

