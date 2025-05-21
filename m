Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AEC0C2D0CD
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 May 2025 06:57:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 433D440E7C;
	Wed, 21 May 2025 08:57:17 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2069.outbound.protection.outlook.com [40.107.22.69])
 by mails.dpdk.org (Postfix) with ESMTP id B4D6740E34
 for <dev@dpdk.org>; Wed, 21 May 2025 08:57:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Js+DjAbYB23ShKo22c0BMId0PQOG0TRiEF9OpRInlQOiep7ljhLhXIFaN+DSWM6yXrHxqryO4SPVu5GcKJKz8V+GKwDSwRynkQSYe2MprOQ/rAB7qBUGdnulAWvd4klvG8Mbq/hsTFBSWBF6HYQEgvjSBealbzEf+EEzIe40Z3eRNyX2rvxIY/zbxCZGwzoYer6Q/e46rnXrPXJxpep6xUjC4JjjrqusUM35LFdrj/xbhJlw+RU7rJPO3/hZ0wg00CE311j/GHdjjIeFniPg00beKpURBkJihTuhio0OggA2wndP1iFRttjfqO9T6uVZB92hjsaOFm61dtIkDPMeew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2fATzeDqtLx6q1visr06V6S4aVBHP6GbvWL+shtSesU=;
 b=bEo531q+WGbq840kxD7O5AK2eIk/5NoDjd3MTW5qf5ggRk19QiQkGq8DENNeQSngkuMsi2GzUcl/G4udu15clUo6ZkOtFR+LrJ2BvbQF+YJNMvdm5Gmz+4RDUFKXOK9P6uJLIHvZrziJJBrEDNs+w3yEbBTn0PBNyDQPiY0PxGgzR+Zmr6QNXpHVHdkzmnxeJg48tHWqLvgyycI35Bq+oOOh2AIAKQOORBabwY4Ld7mkPjvV3Zq1YBDNt2zfyB31jP/E0Ai7x+smWlqcbkmemCM7q+IR7aI4pHKUMj6HjLBgjldMvS7oKlGHi5zopiAaCqskUicW+iY3U1LYgjVsrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2fATzeDqtLx6q1visr06V6S4aVBHP6GbvWL+shtSesU=;
 b=mMskWWrpVNZSLNVrOjp2cDl9A32zsUglFM6o2jFSKTJhVZ31GrR4BI1KOS3LDEMcsZHM5bjBkh9y10OFUozga1sQE0mLLCxJkwon6uuSV+nbRqOxJuwdD4qBL54ndqFV4VvxHI9JW4H9Te2+decxkPuXA5doru/pxWeR4UY5NQHOsIJh2WhgUenFCozue0nK+PtTZAJBYFyVD9HWsthl4MqU7F2j1N+DeknrObIpTS1vIr3V2zZ6Pk00hLg7WP+MAmXA9hkcUUI3S6tNOsPgWskBj1sbPR82n15hb8pxRFfwfH8SOJCfkjorfCqPrLKOkeNUUIrnvCZz/z06bKCzfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by PAXPR04MB8255.eurprd04.prod.outlook.com (2603:10a6:102:1ce::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8722.32; Wed, 21 May
 2025 06:57:14 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%6]) with mapi id 15.20.8769.019; Wed, 21 May 2025
 06:57:13 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org,
	gakhil@marvell.com
Cc: hemant.agrawal@nxp.com
Subject: [PATCH v2 0/9] DPAA2 crypto driver changes
Date: Wed, 21 May 2025 12:26:49 +0530
Message-Id: <20250521065658.857707-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250520055133.506071-1-g.singh@nxp.com>
References: <20250520055133.506071-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0072.apcprd02.prod.outlook.com
 (2603:1096:4:54::36) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|PAXPR04MB8255:EE_
X-MS-Office365-Filtering-Correlation-Id: 48c61897-89eb-4b67-39fd-08dd9834b6db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2o77MRh25YpoBZE5EommvEY1Va6sp+br9FY7C2h73OIjaQ3MJLh/ggH6iOvz?=
 =?us-ascii?Q?tiHPfWkl2l3ayJqXfn0L9u05SZngdhf+zKWcvyp1gECmH/AHVKvWcsWzVHyu?=
 =?us-ascii?Q?nGlyuOxm2Hroybca/xPx5Btab0u2Njn9d+YS3hZ527XsHDGCQBNTd45Ue6vy?=
 =?us-ascii?Q?c+9lJtXYOH3qtoWbeuTsIM5N9MCG4ckyYkratg8jIAdNECksmUkcS3Wgv+dc?=
 =?us-ascii?Q?rpo9lV4jBJLMHaVNXz5r+LLx0VQcZdP3estKc0U2xnUuUO1FK8zdJzgHjauT?=
 =?us-ascii?Q?SY8hx2J3R+VV3dFH2AaPkE7xdQS1lyCKbLJvVSkkZj8rBgeSiAJQ7mpkEHlI?=
 =?us-ascii?Q?20gzI1tixAXyO017+7888f2kBpynr3Jwm+XEb9kVtSMzkR3UKspO6EUhvzHG?=
 =?us-ascii?Q?WBOQ4U4TjzvmaWi3CfgkXP2NDe/+FR+GnL+ucwcksn7fZNt9tQVANh5X5Q1T?=
 =?us-ascii?Q?lw101dwjrHXLZWC7gnDFIHXQiDxVDqrkYx6mRKYxPTVnCRiQF8S02cj1AyP9?=
 =?us-ascii?Q?ZLWEBdvg3cUOIV8uVwWH/kZDfsIFwPaHx1n5FGMAxw79FyiLsvlIipaWTnKh?=
 =?us-ascii?Q?5hlDNh0GjvsiUukhDxXir0I1yC78YfgCjdGoPtJ2K+3MH4SRLczWT7cg64Ny?=
 =?us-ascii?Q?nZuh48dWKkMM843uxSZCSJ0gGn81MFiS2phLt8zsT3U9y83R6g6s6x3V+LOT?=
 =?us-ascii?Q?dHBaccqgafhS62Jg7eNGiolocF1pN09QnGSfrFY07Zs285DAtrDDKelfj55u?=
 =?us-ascii?Q?01w4yK3H+JvNfFYBc3M+o9PNRaTxsgNwocIafC1VQpZyWvyEm720BZ5wV8ng?=
 =?us-ascii?Q?6Q8nZDuHIziTzRGFnwaGY92+kCAb6E8PTEWdkKv1CZyM882dhMWlqqUzCvKB?=
 =?us-ascii?Q?U6u+Sw3is/0Ajqz1XrCOi4AQLPlVP6v5hbFFxAuWVUq0W/+qHfAO1+LWVpvV?=
 =?us-ascii?Q?CNAqpXXaRJ5s3NhWJacotvJBOAhZmtAo73XyPx88HJSG/UaaeDM83y9vjwFv?=
 =?us-ascii?Q?kowIlfRPxILUPpvasYu8dK6v+uNDfInCgJOzr1PgkCL6ZTlE11SfkaC2WFJa?=
 =?us-ascii?Q?LWetlcVeRlwbI4/1+Zgb9sT/2yZlVWeMNjnVPGRlledwcOygK7FTvstWmJQ9?=
 =?us-ascii?Q?t2UFljrW0xrAKyq2bOVXDJlI2XZDSxEZazKKLPStRVo7znOE95pt5IJIf33B?=
 =?us-ascii?Q?RoHv5yILzujL/XPcXxkM3U9fD+YkpCaxUABCmRig1n10zxQ2ufBYRpxobhtq?=
 =?us-ascii?Q?xABiVbTUJ3SlkHnaND3VK3hdww6WRJoANc+6nn5byI6e/4oOTAjrfD3n8wG5?=
 =?us-ascii?Q?pgPXr3Z+n50T7676xBHnb5hKQlk48tl6gE4Rc8qO630DnU/kdTQVi+pTRHup?=
 =?us-ascii?Q?fEcafxqgEBQh7aJc3Y2s8mRzJ6V9LwKsySujbvRmDyeF8Izk8GbXPUWT93A3?=
 =?us-ascii?Q?W4nqUIivO4h5phyQlGmBD0Y4Y/AgF0PcCGzG4egpro8zuWC4PZizEQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?N7ga/EGtrSqTLBalrIecGSaBUH1YfY2uB4CNoVsqY5PfHowyBYx6aNAvgvQU?=
 =?us-ascii?Q?Gje3dMjGHNHoL/B4gUavBum9RMRlCbpc6Ike93ZrrQNG3+UDQWxBnurPciJI?=
 =?us-ascii?Q?ucmIIs+ZdJhaMGI1Ueauyimxo1OGSt8WWFjVEkgIg5V3deeoXAM2rOc0UDWE?=
 =?us-ascii?Q?745MKc78PoDZq0CLg5MPtmGCQEkKlLmV0ImflyvrnMnp8u2LZFZ5hYXC2z8F?=
 =?us-ascii?Q?AeI2w5qx4HCqFlMxoM4CfQ25ZOyaNs0iKu60lJzmv17T3Ok25GBRIRJ4xytb?=
 =?us-ascii?Q?jVAbdr33IyvDJeI00mI6Anba3pwnzuYkeYp7Ue8jGWrNX2k0fnozguNiXV/+?=
 =?us-ascii?Q?Pv1WClkVtMf4szCXGc4NwPi89dkPUvpgRjFpjzgTvAmkA/Uye+ecaX/o/TaC?=
 =?us-ascii?Q?qsqbZ87Qqjz+MiIHiydREcYeBO5JERZ2zVcMiu9qkBTFsad6NVUyXznVSrAs?=
 =?us-ascii?Q?ExsM+cZET99gpKAxDnrZcvbd0Gf4N1++p+S+r5tCNJ1riGPg76tnEetHV1xT?=
 =?us-ascii?Q?jO8vivE9eyAtmMifNcI4IhcNTuqh4+CDIp9nhgWBXMJu+7Xcdwhevul3DLTz?=
 =?us-ascii?Q?VEmtiqRLhzPRrjMOve2UgM3CMtg16hrjOuPDyhzoch7GLc7i6EVt+i4qDonv?=
 =?us-ascii?Q?luu+N27XK7LZ5oKZlFClC7f6ErHvuur2H+0Q5hcGKTUO/XsITRE4zxewozBJ?=
 =?us-ascii?Q?DUXkdgRwQeo6gt1WvMU6wJKI98mgl6E9oLBnhgBpbUUXH06MD9R68Mqmc81W?=
 =?us-ascii?Q?Kl3ZuHzsM1mOWzaQ3CnqOD/IVBCP9AY7VMUya06rE/VvT7kZab4OzBOmnPXH?=
 =?us-ascii?Q?5IKGVNchsWe4d4IhyYuulmHnM7rWNckkWiVZUGX78GE9tqLFkscmHsn4FO8f?=
 =?us-ascii?Q?xhjXLGa/lNW604ex8/49tetvPtGpS66qFayBUK96Xq+tud1fSRLBZLxLqN+0?=
 =?us-ascii?Q?1p1emneE05Nj084ES5dfHY4HA+XYb4gemCW1Obz6wixFYbRMGZ9+DoS7wEsn?=
 =?us-ascii?Q?Kgmg+zz3dRpgzKTWeAYSaCFYjdbdaPDnBZAgnDMdvb1PSkQdZ2WX7K2o41VT?=
 =?us-ascii?Q?AmpUD9x0PYM4cwfbSyLb9lJNHYmvNEpHctPSzhPQjAyUFjF4xBFFI6dnhocW?=
 =?us-ascii?Q?AIzYPiK1zvO2AxR4OYFY+GizbG+IP4Rk1dcuzPDd186sOYFcKWpgfpvwGUcY?=
 =?us-ascii?Q?+xOBmr78u6Gp1v/O9tLnsJdDAz3z/DxorIqWSQ3iRrawphfRPo7+fgi+K+x1?=
 =?us-ascii?Q?NxfG1Kl3LiSNipCzADv34j/DPb2Vx9e6AGpJuim7rr8vPLA9L6FctT/q9M9f?=
 =?us-ascii?Q?EKSwhfwuaGBWs06EdM9YewcoFTEmOIH6KJYfdtkhXbDN0wSb6ATTTIX96G5b?=
 =?us-ascii?Q?9ykZ/szICGW60BMTracChon8gtvbVbVSZUMlgnx2W/LBtvTtCjojvYJ6VBHx?=
 =?us-ascii?Q?IGYVU6DoKqb5inn+ATqBC5VqCxheJ/yW2+j6EDvyqNTWUndhTd1SEi4N9ciH?=
 =?us-ascii?Q?Izx86dkWhCUapz3o5cglUuzXP5sMaMsOL80ttMqYNZajmpYLxfG1DIyWvC8G?=
 =?us-ascii?Q?DDI5X+kc1DzQMTILNWg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 48c61897-89eb-4b67-39fd-08dd9834b6db
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2025 06:57:13.8060 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: di3YPVVz0oVE2TNkBcqXjc+4F+xVNYLDskIOLZKIaKVcqoWeZjCaPJ8bXLWDgEej
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8255
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

V2 changes:
 - fix checkpatch warning
 - fix 32 bit compilation error
 - fix a commit message
 - update document

Gagandeep Singh (5):
  common/dpaax: fix invalid key command error
  common/dpaax: fix for PDCP AES only 12bit SN case
  common/dpaax: support 12bit SN in pdcp uplane
  crypto/dpaa2_sec: change custom device API to standard
  crypto/dpaa2_sec: add null algo capability

Jun Yang (3):
  net/dpaa2: configure buffer layout
  mempool/dpaa2: mempool operation index
  crypto/dpaa2_sec: add support for simple IPsec FD

Vanshika Shukla (1):
  crypto/dpaa2_sec: fix coverity Issues

 doc/guides/cryptodevs/dpaa2_sec.rst          |   2 +
 doc/guides/cryptodevs/features/dpaa2_sec.ini |   2 +
 drivers/bus/fslmc/portal/dpaa2_hw_pvt.h      |  10 +
 drivers/common/dpaax/caamflib/desc/pdcp.h    |  31 +++-
 drivers/crypto/dpaa2_sec/dpaa2_sec_dpseci.c  | 182 ++++++++++++-------
 drivers/crypto/dpaa2_sec/dpaa2_sec_priv.h    |  45 ++++-
 drivers/crypto/dpaa2_sec/meson.build         |   3 +-
 drivers/crypto/dpaa_sec/dpaa_sec.c           |  42 ++---
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c     |  20 +-
 drivers/mempool/dpaa2/dpaa2_hw_mempool.h     |   5 +-
 drivers/net/dpaa2/base/dpaa2_hw_dpni.c       |  18 +-
 drivers/net/dpaa2/base/dpaa2_hw_dpni_annot.h |   6 +
 drivers/net/dpaa2/dpaa2_ethdev.h             |   6 +-
 13 files changed, 263 insertions(+), 109 deletions(-)

-- 
2.25.1

