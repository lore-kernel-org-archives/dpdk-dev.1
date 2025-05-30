Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC046C3ABB2
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 07:14:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B85FC4025E;
	Fri, 30 May 2025 09:14:08 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011032.outbound.protection.outlook.com [52.101.65.32])
 by mails.dpdk.org (Postfix) with ESMTP id 17B104014F
 for <dev@dpdk.org>; Fri, 30 May 2025 09:14:07 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PJw/cLTwk0KxkHZ/UvxlP2n4A1iXVd0IBw7xBx2cTIWauxFLW49kk7nTjCKymq4GL6cfTs4ie9vg2w/uq3l5HQw0opi7MSoTLxOP7gT+Cp5c1n/zeJIXTDWiP1iMgirpU9cWw/kaWJnx6nK50WyFVbMnEFAhhl98JRFBw89QyOt+2x7qa661jsEHGB9at5eaXdTAddml/frhh4gvNN8ErtkpI+HW6UOjh/Ag+wdvGj6idE91Yxbw8soJkYNG0Poa9VZAufAEYcJIKeFruQcrxShrHJjAe2segm3is+DNh4k530fAG78Nhb11QuvmKZ7zyNrRBQpht6MZUCC0Y4cfNQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EcZm136qgEl0vS/Np6NN0L4xj++vdUcYg+OzBUMHcxw=;
 b=MRCoxRGGDE0xPViqJ6tgTBWPQd8QU02t59Xw0pCrjWgS6ROunpWsZVqiVaojFvUP3xJ4W2bBuiOzt/QCZ9SENJ0/o/fLBAKOt9YRhIFJlTM7TuGXWRiqFtykDtYVppbz0RVzh/jbvpma+HDRL5vOejtm0US/bR3bUvGOgpvluS8jBPO/zrTVBAN7GD5xgRnw+CpPN0YS/YdQH/QDeUXDY8QB1jzCSmGOUdA1SREjEzAquRzUoc6gIZrf1Q81GQQaID/dVV0Qk6H1riUi2+E5xTEg1OiVCkcR8AwKjG/kdOTNQr0n0XHJUBpPh8y2wzDxVK1JYEEwSg93QeAiJgeuGw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EcZm136qgEl0vS/Np6NN0L4xj++vdUcYg+OzBUMHcxw=;
 b=ejshxfPbwCWhG+Mz7gN1/ABX4gSVt8fcycBNS9Jp24xsJCqXr6Qqwnuiy5eQDPksovRXvX47snd9JxNRjD5YsrnpIgbaQHOYPTccCPDEPPo4Xq2bpX7/n5xBEUd4+MDbGcTnrK+SjRd1BpCJhL/yxVBw1Mc3pznqivNzSZtbxP8DakqLzvEq2IjHMIGmEpoWw3ifGcMTJsXkQ+cU0Bbfj0GqzWzHbZdTTLuYxxKQs7/y5DTyeCZQc/d2tqTiYXM8VHKOrtXfOJSTmWaa+vSGaTkwxW2osGlXbytypp4kMSxYUihNvTHzSuYYh17wqM4vPkVyU65ndBJYk48UvA7OLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8205.eurprd04.prod.outlook.com (2603:10a6:102:1c2::20)
 by GV1PR04MB10378.eurprd04.prod.outlook.com (2603:10a6:150:1d4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 30 May
 2025 07:14:04 +0000
Received: from PAXPR04MB8205.eurprd04.prod.outlook.com
 ([fe80::7633:884d:5973:174f]) by PAXPR04MB8205.eurprd04.prod.outlook.com
 ([fe80::7633:884d:5973:174f%4]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 07:14:04 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com
Subject: [PATCH 00/11] NXP DPAA2 driver enhancements and fixes
Date: Fri, 30 May 2025 12:43:33 +0530
Message-Id: <20250530071344.2939434-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0153.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::33) To PAXPR04MB8205.eurprd04.prod.outlook.com
 (2603:10a6:102:1c2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8205:EE_|GV1PR04MB10378:EE_
X-MS-Office365-Filtering-Correlation-Id: 58ff81eb-f3d9-4cb0-bf4e-08dd9f498f2f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ddanP5ho8QJhdD+3FpA+sbUMTy8J2VBRKXc3Igbj58kE6bFX90/CWEXraDba?=
 =?us-ascii?Q?Mu5WiDJcWGhCc+BGTwI0JtA26eZtlwYX5ePOF/9fxnj+NUIE+pT1KSEbi11P?=
 =?us-ascii?Q?lhjGbYZYCHWZwjJjLll9nd8/wC9IBkn/Qku3f0FqSsWWo5c7znyhUkL28b5M?=
 =?us-ascii?Q?RKI+n7YXYlglfCkFkJ7QHJnGWWISbAX69i38c3Mf0YHT29MtWNKQhYe3zeyp?=
 =?us-ascii?Q?olI7d51/GIe/JSJ38t7CpjWWBvl0pd6ATO8o8Boo7I8FVmmByssT0oJn1Ye3?=
 =?us-ascii?Q?aCM5Jnwe7qTYqjiC2cII8z5JXZH33TUofGYyvkTBqSRSYTIa5dBEGBCx65h2?=
 =?us-ascii?Q?OOKqclrDmsZuhiWZT2n4xkFB+CCmvs9YFkuMNgO2a5wzHmag4qbj8qIveVX+?=
 =?us-ascii?Q?kf94xqVeZbxbApOMjTDDGB7bfcOUH5TEVElj9JTp/VXPdjDAXebb/iAYu7uy?=
 =?us-ascii?Q?T8GRWMsqfR8MKpGmJ81z20tLwiPa5752lAsoQeK1CKw9GITymxboHGVfWDFp?=
 =?us-ascii?Q?M3qLnXUHOQwXJ1M5W6AkW17Are6IPrLh7ZryGhlnrQuNTGefU6WSTrcuZWti?=
 =?us-ascii?Q?mHejMfvLpDxcACDLwBavtQ0Wuhd21ZMOKYyZNjDc2rjcG7kqWEYf+xUhcveO?=
 =?us-ascii?Q?B4ZE9BahUiODA7f3jKlvLijHyrMolaWPdESdmo9ZrI5wgf+nSfCN19roeeGU?=
 =?us-ascii?Q?baQg6duG8PZ8R7lP8+xHHsW3iinhI83RhZpUK7Z9Xqwx5vOuJFgfX185Zur2?=
 =?us-ascii?Q?6eFmm+Kwu66d9wZidiFLHK4uhITqjQwv5FgYujsZ3pd6v6ieyCosA8OmHwHR?=
 =?us-ascii?Q?k0Vy3nydLUJ006CAAw+g3DGH4LKR0c0mKk1S5Dfbbaf7D+gbVj0OFf50omtj?=
 =?us-ascii?Q?fKAV8r3AAL9/wbA26bAe3Dk53Bn98hWGZ29EaOtVcBzJS61KXTBa3zCHkoco?=
 =?us-ascii?Q?m4VI1S7GcpoGE6r9WVEYlxHjMsq48rBa/ingLF3AUn144p9Llmckt8HzpjEg?=
 =?us-ascii?Q?UcxAnPOmIw4naTfMN2Xpyi4Efg1ZM2GnP9sGaNtmSHz3Eeo65cJfwZ1i4f9O?=
 =?us-ascii?Q?7gi2RqQxicgwoXQnbz5QQv4FYbq5x0r1aTt6hV52bmUI/1Oi/BOm6F5lgtwJ?=
 =?us-ascii?Q?FPorFW0wx+uwyND8UdX1C2L4q9Rh+iOHB1SjvsGXsRVd1OOIa5W3a+AFfIH7?=
 =?us-ascii?Q?Pwk383CT1yzQt+rvpFrYPlre2k1hDr7cV6fLX8MUM1+XYRcdkPONjKSKQSsc?=
 =?us-ascii?Q?yUe3P9MHe2jZ47wU5W80YCj6gvOKgCaGUcG1/APjc++1Qjp5CCH5VtWYL3z2?=
 =?us-ascii?Q?tySE6WDTIyjulMq21puDLmxDQbYkYLcPdf3eIrkcYYMLkHgGrsPx3q5M9R1q?=
 =?us-ascii?Q?HPftmHskLQO8ngE55A3snsk5tNR3Wr4W/vSyD5CEydW9HhS//kaaF0mtnK9W?=
 =?us-ascii?Q?dVcS6670Hl+7E2ELZo1TmyAnw1TDl9COWakw/LFmfHnrG2XOuWdrxiZFxV6R?=
 =?us-ascii?Q?NMJE4q/ZVKMpHYE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8205.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?w67kubcZ7Sr4zGGrbN2VNVX/uZ4xtuPIBwGk/KzQoWWidG9GxL3RtYI5/gN2?=
 =?us-ascii?Q?EOL9vYK8gvnN/BChmQhXhxhGiXtUyutlMCsdqN74C2WWd3CZgNzh56RBU2Em?=
 =?us-ascii?Q?6RV0dc4ojYzWId+VwMHsddo1oP3W4Eq2d55HD4T8CGFY3jr92K0zJMpvNgMp?=
 =?us-ascii?Q?lY++fstY4dtHbhFrhvkTUrLJDUwubywKScxw5FBg17zlg89iR90Tf57g8reF?=
 =?us-ascii?Q?Vzwzs2qJnA7jwGONa91CO2edQ17LQV8RvYRKwOJ+cNsM7AKMqBqavLJsx2s0?=
 =?us-ascii?Q?dCXBcUnANRTupmI9TWfT3rtycBmOPXwvDX1aVMFFJtt3gSvtky4RAKyW0p4C?=
 =?us-ascii?Q?ED5xK8dWmXgWJ+Qz28iZM5knEWqwR3YP873W7BguwF5iKOiF24kVC3fBf6tt?=
 =?us-ascii?Q?3Tnxa+Oqs/oXBtngw91pZPAPTWXLkhXSULPpE8MNvgavIAB5VwUiNc2eDood?=
 =?us-ascii?Q?kSnWP+jEQm5ypFtFe3JPYt60+UACMVBKLKPFwgx818gHCjf/5I3nuIBloV7W?=
 =?us-ascii?Q?AMCgF6Ah/Ru8tu9fphQqG2GQ+7QVh/czN0IdT3wO0/kvjXtG/rXhBBmJZlwQ?=
 =?us-ascii?Q?2vdNqDKw7cOPtF4KLlbdE2udLa2jwNfUefTZl8qGwmlalSTgU9QvXZBRbCLD?=
 =?us-ascii?Q?1ZP9LYWnT8ihjoH8/Ywxjs6OK+6rSdFktsbYHW0N9ehvVWpaR3sEODsF9gOv?=
 =?us-ascii?Q?VS1YlVdWeyZ6/Mf64QH1mDK638WefyQaHZDz6mqmPPlPA2Ngm9ifSbXUcAxQ?=
 =?us-ascii?Q?o7vvCGgELwC9eUouzDorKjw0okxsVcCJ6Ktv1V8GAntbvFb8oy2cwXDnEiqR?=
 =?us-ascii?Q?zQC6CJ+f4eIfI8y8uIUNAaB6UJuRA/yPYp9iTbDoOyC/i3A0U/1FI2ZgSJfk?=
 =?us-ascii?Q?Cg37qftoFCongFllwQ13RYGKJuKAWFeGf5yAzuowTFLlT1mkVOWi+vJmDJmE?=
 =?us-ascii?Q?HhFp72fJuBKSnCulXf4PEWkkHBK8rXg1c+ztXWej/hH0/6l4ESpPISFRVhYb?=
 =?us-ascii?Q?57NhHGGdHtsGp9Q1OJJcOS0PkuE+/a6RhejhKtwf4KJz0pS5AvQy4rxQvsQh?=
 =?us-ascii?Q?MZtUkDoLYr6WSvw7LDYItcLE8WJ4UWHF2aM9fCbEeClyst8gb1ZcmrMkqaFm?=
 =?us-ascii?Q?tJ+wpI6ZJNbbK2xihxFw2t5XA3LCjuVDSlgdCzkAg1nwA7beIiR9jp4nO1OC?=
 =?us-ascii?Q?tiLL3j9blEp8yvBMda1to/EZ9tUDF2lmB+DEqARWXldG/4FmRCipyUnlh2cE?=
 =?us-ascii?Q?p8eiseCuW5QqB1kiivTDnnJvxl7Qfgjiq3N01N03xV4eP1vgBeXbP0US8KvZ?=
 =?us-ascii?Q?whTagIp7UpBpuMuILNKtl3q+CK+orEMnCRQMY6dspmfqWvqqsaxeGRigszuU?=
 =?us-ascii?Q?uytPux6OuUei0kAptXYkmhvWt4EhB+WM5qlD68OAwoywDgiF6L4jAyK3zyWj?=
 =?us-ascii?Q?3pNf7QgGLIJb21auqCJr1WkHTA/kNrLC6OKRq7us0/sDMrN3+/xMPNyjiJqw?=
 =?us-ascii?Q?mJeMcCBt3pqk/P48NiEuZk7g3rlPhPw/8QfkmhqYFb4Bpbwrd/8emxloeYLb?=
 =?us-ascii?Q?UvLlHSZGUW09SxgI2Y0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58ff81eb-f3d9-4cb0-bf4e-08dd9f498f2f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8205.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 07:14:04.2875 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AkcZ3dxbtCtC4fXLAjJbTwRgkXB2lATXPmLeBdNogZF668KpakdDJ72yF4J/jCGI
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


Apeksha Gupta (4):
  net/dpaa2: add dpmac MC header file
  net/dpaa2: support dpmac counters in stats
  net/dpaa2: support dpmac Tx stats
  net/dpaa2: support dpmac Tx stats in xstats

Gagandeep Singh (2):
  net/dpaa2: fix shaper rate
  net/dpaa2: enable software taildrop for ordered queues

Ioana Ciornei (2):
  net/dpaa2: retrieve DPNI API version at init time
  net/dpaa2: setup the speed cap based on the actual MAC

Jun Yang (2):
  net/dpaa2: fix issue of extract buffer preparation
  mempool/dpaa2: use unified VA to IOVA conversion

Vanshika Shukla (1):
  bus/fslmc: add DPBP APIs for setting depletion thresholds

 .mailmap                                  |   1 +
 doc/guides/platform/dpaa2.rst             |   2 +-
 drivers/bus/fslmc/mc/dpbp.c               |  78 ++-
 drivers/bus/fslmc/mc/fsl_dpbp.h           |  41 +-
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c  | 246 ++++++----
 drivers/mempool/dpaa2/dpaa2_hw_mempool.h  |   1 +
 drivers/mempool/dpaa2/rte_dpaa2_mempool.h |  12 +
 drivers/net/dpaa2/dpaa2_ethdev.c          | 276 ++++++++++-
 drivers/net/dpaa2/dpaa2_ethdev.h          |  36 +-
 drivers/net/dpaa2/dpaa2_rxtx.c            |  24 +-
 drivers/net/dpaa2/dpaa2_tm.c              |  68 ++-
 drivers/net/dpaa2/mc/dpni.c               |  50 +-
 drivers/net/dpaa2/mc/fsl_dpmac.h          | 551 ++++++++++++++++++++++
 drivers/net/dpaa2/mc/fsl_dpni.h           |   8 +-
 drivers/net/dpaa2/mc/fsl_dpni_cmd.h       |  15 +-
 15 files changed, 1262 insertions(+), 147 deletions(-)
 create mode 100644 drivers/net/dpaa2/mc/fsl_dpmac.h

-- 
2.25.1

