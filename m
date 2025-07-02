Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D44EC83013
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 09:52:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 862BB402D4;
	Wed,  2 Jul 2025 11:52:01 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010052.outbound.protection.outlook.com [52.101.84.52])
 by mails.dpdk.org (Postfix) with ESMTP id 1E7E04003C
 for <dev@dpdk.org>; Wed,  2 Jul 2025 11:52:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xieccJDdVLNQ18VsSxICQmXcnO8Z9ETw1F0mP3/Pp1ixOcKfjxUjcJmyUjQuNgVyIzDA9cHTACus7+7hGwfx1f2x+jrxUdBjHUObjnOtg6RksFDpAZ/4MQCTYSnBiVq2iUdlN+tx5y+MWqEJnqdTfF/n5ZIZ1wYR/gzzSCKh+TIEtpg90wwkbZPNAXFECGV6OrFq5BrrcMTWOWb+4PKqa8Y3a6CVUXS82Lcu9RYyNVwgmFmXMGHFUBuPJzuMe8CpavnmSZOnmawf05WmEAcK7moCrOmXZBPxXPiaaI76VMkO/NBxM6csnFB9PZceANDF/GRTxZW3y+UP9iRI6eFK2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0dMiPUd6iWlJqnXx02HuF1fCuEtFvQa6XrRYa1iEzRQ=;
 b=Z9o2L89fuRs8I3YhBqfTrStXEnkY7spL2aBI6uLwqAcrUzARU2YQT/7Nd6fGyeNzfX9eER91Pr2AFCtipXDQ/wk/szarAcGn815PC76xTowTkquY1OE9ZyjA1fT52MACVHgYoVkRN0Lo1tyt2D1gzeNu7oULZOv7OZpG7ZkHQnSd2yXPvtCdqgBNdz7Y8FHLxcH2yk65klSVM9OqZWE2ovAa36RTCr2GK6wC4j1rsTBOqD3DgwAbJ+QMYqzGceOvZXzc1BBX/4e0QCJG5MREFpxzSOrWI83MZR8TrCvQlndQL+7P/oWCJtbKxsjLVZF1BGSHdbK+SaWDVSgT/nHvKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0dMiPUd6iWlJqnXx02HuF1fCuEtFvQa6XrRYa1iEzRQ=;
 b=JwYL9G8Rfr0TLJT0cYPqbkRaN237xadtcWUc3zk/xAGRt3OQtaNSZHvvK0HXzoFHWojOfjFh81w/f9ecoZGqY18e6zi0jwz+klCf/90Y+Xid61k350LyKrtzaqdXaoYgSN/VDLWN6FmArbsCHjUGzwL3kFT9N1xAPJdybDHeF1lGZJV4q+ahKXKpP3HkEHh/hpnV3KjqZQ+hPOlzVLfEsJWFcgBuj7ssoI8P4xL494jvc8KOBXvddogtwv+XDv/aSEmAxU/pRTisMiHdu2dp57Dx0M3QeqxiC6YzA/fm8DSTkc/9szIeTTGgQl2sKdNyrvtVavcwcZbYWstVKTwtuw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AS4PR04MB9506.eurprd04.prod.outlook.com (2603:10a6:20b:4c9::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.20; Wed, 2 Jul
 2025 09:51:58 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 09:51:58 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com
Subject: [PATCH v8 0/5] NXP DPAA2 driver enhancements and fixes
Date: Wed,  2 Jul 2025 15:21:39 +0530
Message-Id: <20250702095144.3087250-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250701042917.3000355-1-g.singh@nxp.com>
References: <20250701042917.3000355-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::13) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AS4PR04MB9506:EE_
X-MS-Office365-Filtering-Correlation-Id: 6e0347dc-add7-4f0b-62c3-08ddb94e15e2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|19092799006|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?5wN8Ard8WfMdNe7wWj5TReBbS7LyWHRRvU8TYG6Bzg4OqHCE20i5lBTCabPZ?=
 =?us-ascii?Q?qawl0BvCB5xfit3q3lhNwU32KlWPZxlSvG4h8V7nUlsq5sXxVPSzY0oN79Jx?=
 =?us-ascii?Q?SwonzbxFeXzN69f+qlRjkk1vZ6ZpRU/yfFmiOGn8KThQ5onG2DlcpG5jmbVc?=
 =?us-ascii?Q?XiThMFEZA5ZV7gTpIOfgZv6FTEXgaSw426yn0w98gYvwqwlwL8V7/NwSdbGC?=
 =?us-ascii?Q?F/ECCZkBBMK80y9EB7SZAokQuM6+Yq+5UpoCCTqWlk/8d0Brvbn/wnY5Uxto?=
 =?us-ascii?Q?PkhfanHoUDTxOvDEStS6cDfP8+1MgWTJYcIW6vzc3/2nvzpiW96P1Pa327i1?=
 =?us-ascii?Q?PDE6SIUtsr2+3axzkZbPTnL19UkhnR0m2lGnFJ26NAk1kWldBTQqtkW5GbrE?=
 =?us-ascii?Q?Mfq8vx3qkrdyFfs+upKDqEUa16cTUyEj+0WljLt7LKgDxsHc6h47n78Zwi2s?=
 =?us-ascii?Q?I5xJ+l02S2yVJkiDMnqSs4UO8WE221SRCS2cuLRk0D6ARx46u1S3SYA+Ubwr?=
 =?us-ascii?Q?L6+4ihakBU8ynWwc0V2qgpQWdO24lP81MR30lJGXekxCBJn+M8SvpPitdXac?=
 =?us-ascii?Q?a8Mtmoq2wxDKJBAtDVzqsPXm6sIC/VxUNWV+/2AnGT8ZtAmYklDzpPy39as8?=
 =?us-ascii?Q?FtCRvVDCkkRwm8VRziYbFAakPVtJedg6om3ehJkWA7B1T3J185wMWxZiczw4?=
 =?us-ascii?Q?pDxfroYA8Wvf2J8JJfq+Q6I7Pbwyb7vDjSF2dR1xN52rDJXqLO+vkMPqOFlD?=
 =?us-ascii?Q?1Km0UTsv56/a/YJSrnJbGrTqXyBhTWRCzHGU1ZtsaOkJ74JpfT+w86R1Dj/m?=
 =?us-ascii?Q?68iAB2wcFqqeQgBASnl9KGe0cyNBTPWFWcUfoXL+AFLrOVdqkSlKL9lxOJNX?=
 =?us-ascii?Q?msDvpIWmrRrm34/B7mBQM/+Wzoj+DEYklLxTxEhpc2tdPirH6h7crtBik7Yn?=
 =?us-ascii?Q?TIchTek5tjx7KjxDRBCbS29O4fdoRVDOLxaweMhwiMMHiqfNauwnMzQ0OKt9?=
 =?us-ascii?Q?V+XCEiJlTXf/QOn/VJX0eaZ/IJ06Nbp3UPnB4LC7tW8oiawStrUb/bgU9ZK2?=
 =?us-ascii?Q?PNHj9ETfg5b2YaCYNgjfJjxovLHF6x8w1Ci377Jw7fXIUqYrgqSSkQKy84P2?=
 =?us-ascii?Q?HAhmJUhWxQ9Klrs4Gd4pEEiPg32JDOx7qDu45GFo9F4G2N8ILXW8KzbAHJXN?=
 =?us-ascii?Q?P4d+LhiARg030WVHhSUfva0/BHvU5MPsFcH0UihQ+beDMPKMHXRo6OeS28Lq?=
 =?us-ascii?Q?8ZZGKsH3/eWOs76Gj3OhDdM1LuDv+4tG+t1zQnxZ0nNwS/O/MfKXkoqazXW4?=
 =?us-ascii?Q?yknNTOHI57YIoVKzmlcV/fxp+4htjQl8pOD5kOzntlOqzk7fSi2A3Mush3/s?=
 =?us-ascii?Q?o1rc0YgrcBIk6xwC4mOUKg4jQjBWL5XbHImicQs/cCgb+ccwk6WDank5/bnd?=
 =?us-ascii?Q?DTk/A3V9isxKZzP5DnGxUM/HNZPbSETZ5VOiuwZoFVUCeGquGvSFJm1T7Vfa?=
 =?us-ascii?Q?lUAkrVsgjEg/q4g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(19092799006)(52116014)(376014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j6WZDOQLGzEZKFOAhsYkrOdiNsrnQcOJwvRRgatTiH+JK7WGwE5zL/fJ7UUu?=
 =?us-ascii?Q?88uQK74XN1wDqM7w2DMSj9toK4VxN3PLqPUD9wIhJS/8QT/qLS0T3kwLXcsh?=
 =?us-ascii?Q?tvWWaN2pnZCcHjjmX3EYVwCPHehnJebscLQVWSVepteRUxK0VkFCXEHOueLN?=
 =?us-ascii?Q?2CRqWPoOWl8po+fNGmPorXjxfy9eEOZMBPeJTBUonJ/319dmsZskcWA+wWxg?=
 =?us-ascii?Q?cnBmYbtqXLw8IA0afWrYmA/xG2mCtvxMs0jLFCFPuYE8V5soTCyPrfefuES7?=
 =?us-ascii?Q?Sk5ZhRxSuDmMLwY1IVkXoCE5xXX8/yfxHJplkR7NyAwjDJnSfVUgTZJiXiOL?=
 =?us-ascii?Q?52R/ecrPZzsDMNDzUBrX40uEzI72AdpMNOHX30FuLoFTxom85D7VhXGWDHVT?=
 =?us-ascii?Q?YsiYloqpdsAG7yTwxAQWYJ/n6dKQie7vMwLWRUz/B5cUaj2b5zjQy8JLoqrw?=
 =?us-ascii?Q?P79x6TF+4KDvo+v82avg+ivBrNUENvSrVwlTQ2VxCGo4gpN98v/V8IpfpPDm?=
 =?us-ascii?Q?D0AG/hsnP3Pjuz5kQquIfySkhjz4K94Osj51thfQLjM5ec01ck4waIAiztbU?=
 =?us-ascii?Q?AJ93QC2A9mI2jsCpLNJGcnapceBdvMl/Fgb+r9P9gCxajq03rKpoCgndQNJs?=
 =?us-ascii?Q?0oF9v+xj7jLD2ocs4XoK9sHZzlrBXW8sb909ajaK1z38BiQ723qf13nBaBYR?=
 =?us-ascii?Q?8NAEFWUwXDfQLdpweDElRhtZqcV9/u2VuzmUHv4t8Ktxqf/+v7fcrxKGGXra?=
 =?us-ascii?Q?W4A6Iitu64dWTDv4f/3XHBhhwoNjVBUVL3aR+BsWxRtU4KBVFLZHjAw/itLd?=
 =?us-ascii?Q?mj/kt+LA32umlVqzU3FvajhM+6bC5P3Y9hzuSUIRwrM7e+Z2DYEPWCFvFW99?=
 =?us-ascii?Q?1rmO7YVNrbbf4QP8lwrvwBhmqaYl/Stgj2L0iWT56CxyDO2F/D9FSk3TX3/q?=
 =?us-ascii?Q?wr9Qi6BoozmdkpwcMmwWTIhZ8NuscFdLtA1XfO0KSvoS604joP6pRciwXgcO?=
 =?us-ascii?Q?2zva5X9ejeHVu8ieVOgCbbF+eEdHdxVQPE/iJtnF7pON7D+AnPvHpXSJnFLQ?=
 =?us-ascii?Q?dKy8zMka0CFbxp/Js/+FUlfxPT6XWCngKVJyKjU3repqVaeN99Pn2XhEFZVq?=
 =?us-ascii?Q?ieFUSu7wmADQXeBW/NMG7paWS+dgFfQRsdPw1bX7FwiRTIOuXYuVOZLBG0oA?=
 =?us-ascii?Q?tzaOvkLWyj6Fi1urSjQ5N479XR5Jydfi625/c4/bzXu6Jwyh16V+0a/d9O5o?=
 =?us-ascii?Q?C+tgQixkQT3UQ29ZTQ8SKC21GlJf5GkSfzGFLVPwjlPOIiBDc1IeFMxH5Ndn?=
 =?us-ascii?Q?xGN30iGWeoVsTS5zqCJ2YI4pMzKjcQv8thX+96D8QjZeW5p20xae/p5mDXeA?=
 =?us-ascii?Q?VE+pMB99i6gc+tTwyW9huX+Sq0ggTMZXVDpvp8M5eGvmm+7fZSv/7Jw1LTvU?=
 =?us-ascii?Q?n6qHnbo+bqsXHnTnrf4SnUz1enb1u16Xje4ZuKDbMo+15tVtGYXmlbhMJRXn?=
 =?us-ascii?Q?id8HKDf6wlqcnVe19oChqHzQCsybMbEasOajxt2Jd3X1bMi2mu7VydHttQ8n?=
 =?us-ascii?Q?5ULlzZtV0ycn4ZDE6Tk=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6e0347dc-add7-4f0b-62c3-08ddb94e15e2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 09:51:58.4103 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: B8FL3IjtfuV3VF2RYsp6P3Zu7EAJdi3oQvifMimZTS6wRu3E4yGBSaOPmdx1ryqA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR04MB9506
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

V1-logs:
This patch series introduces enhancements and fixes to the
NXP DPAA2 Ethernet driver.
It includes support for
 - software taildrop on ordered queues.
 - setup speed capabilities.
 - DPAA2 resource version.
 - MAC level statistics.
 - improve PA-VA conversion.
 - add buffer pool depletion state configuration.
 - fixes for shaper rate and buffer prepration.

V2-Changes:
 - Fix compilation issue on UB2404-32

V3-Changes:
 - Fix missing license information in fsl_dpmac.h

V4-Changes:
 - Rebased the series to main branch top.

V5-Changes:
 - Fix spelling error

V6-Changes:
 - Remove new statistics and speed capabilities patches.
 - added release notes

V7-Changes:
 - Update taildrop packets drop logic.

V8-Changes:
 - Remove DPBP depletion API patch

Gagandeep Singh (2):
  net/dpaa2: fix shaper rate
  net/dpaa2: enable software taildrop for ordered queues

Ioana Ciornei (1):
  net/dpaa2: retrieve DPNI API version at init time

Jun Yang (2):
  net/dpaa2: fix issue of extract buffer preparation
  mempool/dpaa2: use unified VA to IOVA conversion

 .mailmap                                 |   1 +
 doc/guides/rel_notes/release_25_07.rst   |   3 +
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c | 222 +++++++++++++++--------
 drivers/net/dpaa2/dpaa2_ethdev.c         |  12 +-
 drivers/net/dpaa2/dpaa2_ethdev.h         |   9 +-
 drivers/net/dpaa2/dpaa2_rxtx.c           |  18 +-
 drivers/net/dpaa2/dpaa2_tm.c             |  68 ++++---
 7 files changed, 213 insertions(+), 120 deletions(-)

-- 
2.25.1

