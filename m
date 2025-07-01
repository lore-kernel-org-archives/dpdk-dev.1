Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6E02C8302F
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 04:29:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7BE8D4028C;
	Tue,  1 Jul 2025 06:29:34 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011032.outbound.protection.outlook.com [52.101.70.32])
 by mails.dpdk.org (Postfix) with ESMTP id EFCDB40276
 for <dev@dpdk.org>; Tue,  1 Jul 2025 06:29:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FI+6k1QeqNggu9GvICtYmMDpVD5yxwMtKQi7NsGw+ehz0/nY08R4v2wnYs26fj04LR8yd8+stm74eeXpvh+5gEfm8Zy6bGjb6vH8Ke5MXbvEsCmZtVcHxKg1WVqGWXOnLfWcbJ9UEAi0av9SE/Mnh9bTT7Q2K0ZpjEa6iwf5OIKD+duAIP6jkg13XIXCCfv1JjFmK884KrUqpWDQGB1EkmZc8HLEQU8SRq25sFLndmldJju/k1db4bhn1u/qiTz3n8Al8DTEXTHCIO9gDZ0YpegFi5MICIgkbV9pm9yQluw+ZSr3o2uRiB4MV5N5gf4853MtM9k6HY60ghl2qflCeQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YhvxYReVCSxKy2bYgkxyU7kli7RekPCWjiM7Kp5rYjU=;
 b=SDqs219E4cSwrPcE0aryRgSMDlm4axc7D+sKFs/fFpkdPk1hefCHgfR1lyGVjkSfE0aul+SHZ1m0D54znFr/NxrfyE4VLp8J+Lil5yvTxgsSLEOAT/yrimz7x5DDlJe82EcxSWjmU2qrj/Uosuh2ZRqFEJn7yHDQbiKklKijCDBvZsIg6l4GtQuAvMhZfo9uPSkZ1QE38VGOdQdqDlaf5+0O/7LUiCnHcJkmYbHVXcxKNXHkNansrGSg5kUcHZTrofsWl2kKZS+/0XXAPPdaLifgOwor15NrO1KM7MpM7KMUvRITGQ2NA7lFBYVoLNXit8DjBfVjUethpvr4+fopjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YhvxYReVCSxKy2bYgkxyU7kli7RekPCWjiM7Kp5rYjU=;
 b=Le5OH6qKDjcpUHu4WxvEJJdkSm8zvwRbrHJs6+2p5dfyq+dZ3NOv1GS+mgYw/O7q5i9QaH3GRuvQMNwm+Ie8hIRVHb0uxOcYGfld8MJCAPMvojoSrjM/Q9expwnrtPIMasMPlpWgBYGJ3ASvSrK8i3UgpP5Nwm98t5cKaPcWhSPRVS4YsMrFSUcvFUBsDe52B2+OIuVfHyWApOPpkLupsrAmFFK7A7/PEzfYcmBKD3s+JQ6oCTV55wx0bbjgqU6zwFxq1PgrtXSLTfik2XgJHyQc8Rt67Uc7Gka2EnyZVocyDFGX7qUOe0zZuj2JNAWAHNu2g3moYsNp9uKmdyXQSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by PA4PR04MB7647.eurprd04.prod.outlook.com (2603:10a6:102:ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Tue, 1 Jul
 2025 04:29:30 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8880.029; Tue, 1 Jul 2025
 04:29:30 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com
Subject: [PATCH v7 0/6] NXP DPAA2 driver enhancements and fixes
Date: Tue,  1 Jul 2025 09:59:11 +0530
Message-Id: <20250701042917.3000355-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250630095800.2943863-1-g.singh@nxp.com>
References: <20250630095800.2943863-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::8) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|PA4PR04MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: cfdd9f4e-f7d0-4cb6-07b9-08ddb857dece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FunmgW/lbvlJ/rK+sxCks/YUOMFRu+YkuuSGPnVoBdwhrZGVtQlmanDnxyMW?=
 =?us-ascii?Q?vuZyyKXeM+diy//Gqx2D9BIO1jQDTXv/Nc6mSqi6YZa9vnOz9SFcohnv1wu9?=
 =?us-ascii?Q?OoDDFZw3pFs3PsaVbKQvmLk82ttsXPUbAjI5qZ9Y0dw0M1fFMo/QW9jN3D1v?=
 =?us-ascii?Q?DUgTY69l2QEb0yFE1ijFqA/mi+5s0S0fV63O5TFN/GHWM0l5FaW0742tMFpA?=
 =?us-ascii?Q?ZZRSkyji+TS23FQtlJ2a/vdcATDqLuwFiEaURCY3wQ0adZ9g82y44PXpEged?=
 =?us-ascii?Q?SEQJAWZNKcRmmkWPj3yAXK9kUkAcm3jUzxUUj/BGMj/cVRAf50d6sctc+BbK?=
 =?us-ascii?Q?c9l6Sw9DIZaaW1LN8KiNXwCRf12ZFUVbqRVAiKWBqsCJJo1PJBj3eAuOvNcs?=
 =?us-ascii?Q?7V4A52fQT02mdqki0VSxMAjjE6Mvkr9j3lRhoJ6l6hUKl0BF070hQLxwfSZT?=
 =?us-ascii?Q?n443UzPQ8RuRMjUnfb3Q9mnB4KwWbzMWVTZGg3FoFBrHBkPjecvsjsHBEanq?=
 =?us-ascii?Q?q+qmBOSNd+fG22BRsGVmfrS29GfSje2q95hwR4w/EDLn9YGKFc5IrJq+CMyP?=
 =?us-ascii?Q?pyOcgd7Sob/jPL1rSbGuGuyVsyLSfxYlA0cCzLfC2Y/uElxjLMtmqwoS/AOe?=
 =?us-ascii?Q?sBFWCxee1xRPSrlDenIZAeqzeHO8HJU5rpjOaBVYYvpA7v2xq36SsuVSnaBJ?=
 =?us-ascii?Q?N4UkP7UhEFZhycwNV1IcP7k2WTjwGFa4ARbBva34UODUMb/HB8AnUoN1gXtR?=
 =?us-ascii?Q?KU01x1wc68LvFwn1zT36KZUr38Nxluj4RGpHXnP6rgor+57Z2F0cvxk2dCAf?=
 =?us-ascii?Q?v3pfuYjCGqEjBJyYAoAvLYz2fqbWcGe94VdAeV0Nqejj9Fp/HLE/BmgLbniE?=
 =?us-ascii?Q?OPct+FLJcMunU8kFd0gOqOhTo3eA6D/VLfN6rpMi4mGCKnNsOEOTUsHgcVaG?=
 =?us-ascii?Q?gg2G7+8zngYj9yZDglp7gqOzY3F4HpZ2m+rcmwvTazIvQv8YYGCrydnqqKjF?=
 =?us-ascii?Q?9nxDXY5geHl4gYT2DRSTfjoy7m2CN2HpQz+rc6JSRaxSSolG1HWinhhCzJj2?=
 =?us-ascii?Q?smDfEFCW+mTeTveTNDpKfBnqzEOZiddxXkjQq3Bas3iFYebeSUl+3SZA7qWo?=
 =?us-ascii?Q?b0zlfLoZmn0UikRXKUbIwc9hU4HML0RAYWVgFd4nVjivdOeyOosfbKcvh8LI?=
 =?us-ascii?Q?b9BMGBn9vIHuvLX0SRWPlhsCeElMwNHFRvC31R/yFx+8VYp4tF2BzDUxWyaK?=
 =?us-ascii?Q?d0T/Yo/EqcBIT0XzDBgqTpKKGgunfzUmcXV8hNDW8+l87pGUPyEqKOWT/NpW?=
 =?us-ascii?Q?VEKht5Lvbt7B4uarheaAN73A8qpjE4ggbECi8f7LJpBEb7x/gOvErof/drIk?=
 =?us-ascii?Q?7h+TS49jYe0COfIiEp2FLZBE5yPdg2tjqgHBtwftUYefldzjHFH4xf7avX1/?=
 =?us-ascii?Q?YLAD56kuBcPuISFc0fDjPI2o1XF2ojT/i/sWzeEmli2vSGn00GHzV2voj45c?=
 =?us-ascii?Q?HetNCuz2/BR/fTQ=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?MF0EuY5t8mv7oIJd5qZp9AeI+o4b67lUdUpk2zrVNZ32fgQJ4KQUUuQQTsUe?=
 =?us-ascii?Q?GZlrD0fTC5PtoOXoXQL1OueNuroqR7LI8tI5VBRoHDuABczU6+WrfEr2xAAX?=
 =?us-ascii?Q?2rj1K1fhWAIe8bl9Su4dNR3vNGCmIfCPWnxVELInMXyzBuh97G5dnAEipajg?=
 =?us-ascii?Q?T0WeYtjCngx8VIFKFh7g5vsVoZ3rZQYjOPMkpPPyqymdQVtUOzJqAF3+YJwG?=
 =?us-ascii?Q?9GoTTZkPnsMGovQxOvlePUoY+bvNEBVv+onn98QlBIbGH4TdpLT1KFHwmwUr?=
 =?us-ascii?Q?BmvMj2iVgFcnNMJRJCiD07YZxT1JTBNAwGd4Yof1k3DAhSKsZSFVM1lpjfeh?=
 =?us-ascii?Q?dSk2gmoYvkZc2lGFdzXQw2ome7RksjA3CfV5z8rK0/qhaPHqnmGVODvacv2F?=
 =?us-ascii?Q?UmiBn+NG36I2qBtuO5ulV1finO2CLvqFXk+K+4ApEhpe59NCtq0A+cyXCOBx?=
 =?us-ascii?Q?pLRGH0y9+Tm/Q5uh33UCQ/77y0d/XzvmmtiaVmJQ7c6JI8pMnBud70WOwsCs?=
 =?us-ascii?Q?l/G5nhIS57mH5NR6N77609TPNfy4i4SzvIJAQORP4ijv0voYBMFJRL24gChM?=
 =?us-ascii?Q?/JN8U13B5KyTgJTAAHj2pFG+6IGTlI0hmrkEYmw8/wN6xrPLfQLzvVeBbhDy?=
 =?us-ascii?Q?+NeOSSa6vgcYoVXDfBFH5zOoRPef7NfWmgeQzGNr6+zqIgYWWP2mRc0PrPSB?=
 =?us-ascii?Q?j4kD3E0Mg+eFtLrT8r9lMuKQTHcOIUzEgJpcVI8t7YBpPNnJjodrxBxQxGmj?=
 =?us-ascii?Q?XkU0cscc1Od0XSp4k4FAaFU5VjdssZKcXP7MDaRCcUNegzbHAfbE9JrIBQ4I?=
 =?us-ascii?Q?EuF3S5FQJzzLMyeGH9um+xON+5rPcZ7jSfweqUhsp9oj7LTMzswH+f4sbHQo?=
 =?us-ascii?Q?/0uDquqEp8mrXc0EuIPbOEig8sgd/8lkycmRZoAi5t49nLan812ehlhJz1hJ?=
 =?us-ascii?Q?2+JmRpykVqfwfU4ifth7NxvM8uyij82ISff7AARZuv9fIJwzUplrZngsMzq0?=
 =?us-ascii?Q?hJkW3AKS6+HKNRZaNKGyhmCqfcWqVUTmWKlnk1AMG/neow2O8ljOLSRH1x6w?=
 =?us-ascii?Q?d8T+PZh0iEWByCZf/ARUslJuKmqPMZOL23wNs72rgvEz0ZQvXT4d/0h6jjVQ?=
 =?us-ascii?Q?T1Q7ZacG/FDhnGCDUJ5jap40gRPfLE3W7RJezB25t9m9cM1W/EvGS+XPpHKk?=
 =?us-ascii?Q?oGo3Q0xDlq+Gai1d5uhES1sSjKriIgcw5xEct6EZU5ZOrcO9mZcBtjvjTz7y?=
 =?us-ascii?Q?bfQWoiCKwPjsZS98RIRDu9gWDvZy/vB3qL8l2av8C0CnDYk4LA99gIsLpDGV?=
 =?us-ascii?Q?FfHFU7OGK8/A1yyDFryBLr5n0jAcmzuRC3MkU3XBZ6lGDON1YzbczbUt/qEy?=
 =?us-ascii?Q?xxHH6rAH2BwOErDI+tdAgBsePtI88n45CKULEfJdEMasDdrVpHPvSTtc2ob5?=
 =?us-ascii?Q?f2uUZkjZ8HruawyY9hROo15lR77yR/xVLAs5Q8JI5AODahvrDWpKCdy09486?=
 =?us-ascii?Q?DMGegVLZdJjEosypUrEluCkNJRjgR7jQq9jb7tjx1gK1iBYRe2mPazu/CoHp?=
 =?us-ascii?Q?iG/mZjxtAD2kUj8Qijg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cfdd9f4e-f7d0-4cb6-07b9-08ddb857dece
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 04:29:29.9883 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QyahTKGc8+Ub4d0CYpjpCwDK0MTLr88KEHR3wSUww0k6ptKQj4CXgl9km7UTiSIn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7647
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

Gagandeep Singh (2):
  net/dpaa2: fix shaper rate
  net/dpaa2: enable software taildrop for ordered queues

Ioana Ciornei (1):
  net/dpaa2: retrieve DPNI API version at init time

Jun Yang (2):
  net/dpaa2: fix issue of extract buffer preparation
  mempool/dpaa2: use unified VA to IOVA conversion

Vanshika Shukla (1):
  bus/fslmc: add DPBP APIs for setting depletion thresholds

 .mailmap                                  |   1 +
 doc/guides/platform/dpaa2.rst             |   2 +-
 doc/guides/rel_notes/release_25_07.rst    |   4 +
 drivers/bus/fslmc/mc/dpbp.c               |  78 ++++++-
 drivers/bus/fslmc/mc/fsl_dpbp.h           |  41 +++-
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c  | 248 +++++++++++++++-------
 drivers/mempool/dpaa2/dpaa2_hw_mempool.h  |   1 +
 drivers/mempool/dpaa2/rte_dpaa2_mempool.h |  12 ++
 drivers/net/dpaa2/dpaa2_ethdev.c          |  51 ++++-
 drivers/net/dpaa2/dpaa2_ethdev.h          |  10 +-
 drivers/net/dpaa2/dpaa2_rxtx.c            |  18 +-
 drivers/net/dpaa2/dpaa2_tm.c              |  68 +++---
 12 files changed, 408 insertions(+), 126 deletions(-)

-- 
2.25.1

