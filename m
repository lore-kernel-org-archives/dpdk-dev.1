Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEA31C61CE7
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 10:52:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 015664060F;
	Wed, 11 Jun 2025 12:52:10 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011016.outbound.protection.outlook.com [52.101.65.16])
 by mails.dpdk.org (Postfix) with ESMTP id CF2AB40144
 for <dev@dpdk.org>; Wed, 11 Jun 2025 12:52:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=e+Ohgvf94F9s7wkXgUjC1tGIpFmnnQ/a17A+VaWWXQ1Tg4OH8x6fZ3vCEndF0MSGgaAuaROkZAu34DBdEDffitdvc1PiMmRy/awIQlr8a4K/wzYl3mE2GrnkAp4i5yoFvLeeKxj/E7mGVNupTpKqmG7Qp14S5s3pzq9r/ivBzbj5v7qbnSVH5vs9ZjsBHr0463JUe7i9KXlt0XNWacbYbznFNIh1WktcLUSFpWVIcq99eJa0lvMlIHh+9s76dcysnlRx79i8Yv6VZbQOB1BY61ZSG5+psf0ABnqRjsHbfXg9kcQCInP0Wi+YagAtpfwOwRTJBoH5mc9BEnnPvBoMjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M08xSP0DBF9CwcHhBP0K7MyB3bl7oFzTi3YUYFfSKls=;
 b=jC3SQo+fjSk9F/1T7XWhy1Gb52Eh0lwvPlG9tFwmsCSlfHemgv3pVCfQPP2Wxzjuh7fEKE3ywJTWwjxyBvhaRho061Mwv3upOqi+VWsIklZgT/JegwtKwp0e/INyhCg/cRsAM878rI8PK/IqNlSXaJCKeKsN0B3o9pbi5NhMwp2oMR7lO3kp8i0S7Lb18IdbRigA9H9M5FV7ddABtSJD9ljaLuWlhWxfsDAB5Ox9b2BHtU5td4y88+qsqSmhcfkhtJkha2QfxN1Q/Lf9Z8wDAhrEQlvnn2zydL8uiBvXQAy7vY/PMs2BAsU5zkZbVunWqp7dkh52WLziCe+4Qu48lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M08xSP0DBF9CwcHhBP0K7MyB3bl7oFzTi3YUYFfSKls=;
 b=Frs9bO2eRLyF8S45vgUp4rlzs1AUHWBmSaXDevsdC8ErSoHXaZcWqDNMamrwaYu0udR3V4XssOom8g0XQM6QF3aT0JEU4q72PQw3j1GdyiycPulrcAmCqe4nYvO/jzYWd3OguAnG11UtbuOnowGXokt3e7D5Ba/GzO6/ZUY4CE+z0cSLVbKzamTHZmZ2yeMZDv1t8oX/xkHyCPMVOHffFHN0i8g28wUb2DWl8LawBA564t3qX3bw0BRP0D2PXAsxYMCOlHKlnV7/+F2kgZA+q8oAobvN/tqVHnn0AyB45d/QrTJeOO2SeZF/iRr0YWDH6ChbblffoBwRXMmzRRo6QA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM8PR04MB7348.eurprd04.prod.outlook.com (2603:10a6:20b:1db::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Wed, 11 Jun
 2025 10:52:07 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 10:52:07 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com
Subject: [PATCH v4 00/11] NXP DPAA2 driver enhancements and fixes
Date: Wed, 11 Jun 2025 16:21:38 +0530
Message-Id: <20250611105149.655144-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250609025450.3997062-1-g.singh@nxp.com>
References: <20250609025450.3997062-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AM8PR04MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 06f410a0-7910-4430-fef4-08dda8d60226
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?a6WdOkPAZbsutCde0G0lrfDqweLHCvVzBnrcbPCcPJebw6IfLKeTMxuPwKch?=
 =?us-ascii?Q?RgidIVYs9CKdCtJyavkNgUosEgaY8WgGm94sdx4gBsmJ1GEEUZfbV4g6f5I0?=
 =?us-ascii?Q?/cfwCWIYn47WD69xXA12gfTxkiMf2L5eUOSRITMsdzORVH/63TjYBUJqvkMj?=
 =?us-ascii?Q?Oa7kBLO36fSSgPjlzE98+FVnSpZUadmoCuACC0t2LPDV1EpZ5YPllkrBJ+0K?=
 =?us-ascii?Q?ilg1UlN60QCBX5pFFg4DC27KP0WpK0gyFpvSfV3Ek0smloaBiY1li+kImqOS?=
 =?us-ascii?Q?8n3CLFa1kewYt3XTnpjgcgQkMPeEW6o3eCV3kPdPfAqhNsGMe7A9TUdPqABv?=
 =?us-ascii?Q?t4yT0g21PLdpWeSxUvP874pTQYT3jf4GPnxeTO0nKz66Zsi/u7WYSm7VXBM/?=
 =?us-ascii?Q?AjjsTymlSVixqKXnY/gDGKRIjhEShU+OX14QUR95pi+2vw2P7AK0/nUeSAXV?=
 =?us-ascii?Q?eKll9pJLKhiCPeUg+jfs35ScSLKpHKxJCWNXveeZNV4x8MN4c/+DDKxIj0SV?=
 =?us-ascii?Q?vUHa4N9ZRkpBDp3LppC6C/x/uTBxVNuSA2LJbQoLnO/HRNHEm/Qg4fKR8iTk?=
 =?us-ascii?Q?pq7Svolu9PSqC8oo672HtGoDWToDsI9h95iKvB7frD5a4Iy1+5eBT7Zz4uoJ?=
 =?us-ascii?Q?/r4tMwjEOwOnyho89Ne2P5hUqEM1LeLq+S2JqWWx+2s6zR0PC0WEsYh+ur9N?=
 =?us-ascii?Q?mUfP2PfCxjsr2lVSXMULk1a0osIM5TKiQkvgmRPJB2tfdxH/lcdhzvK1N8kp?=
 =?us-ascii?Q?4WUds0JVHN4cMV2SKmQeEWe3NCV6CPs3FTHrj+XajkPFvjf+5JEmGm2GqhEx?=
 =?us-ascii?Q?hFfuLvyu49iX6VtfIl6PxW3qhhtuf4s+HVxKRrniGIAAnnfHeu5EaN9i/RBM?=
 =?us-ascii?Q?yftmONxJh3B5XWh9fqC+wq7s9GVP4MyjZHY+VlADI2GWE6fSBMEkhOja2cZL?=
 =?us-ascii?Q?NV0tuTyG9o2mnDiG7n0nk1LreqtgGWbNJ8jUK7ujRfbB7XWIrd9lZjqAA02h?=
 =?us-ascii?Q?VTKHw/EVNeziAVeaKGnKPwYADiQhhNiMC1E/h8C9mdIA6eMoWlRWmxxcxfeK?=
 =?us-ascii?Q?1sVkhmnFa8mbJTTzDrFhDlSC49W1YfyiQ8yLYN0znI0xH5GmkQE1vmaJ5taX?=
 =?us-ascii?Q?CdmHOcoJCXOE9brfr5zuv5WovDbJSDYuNILjzGYzYbONymgv2TK1IKu0k9E1?=
 =?us-ascii?Q?jXhj9ZPZpsRAaC70EE1E6e4q8Vm62pMpwsDWm+8nhaG5a1r4ZeVEWsuGZQL3?=
 =?us-ascii?Q?oycM4NokHzimk8zGBUVlBlwsvzEf1jqidVNhg/idlGttgzguspa69iTdiyUi?=
 =?us-ascii?Q?ZyH7PODyH5HW/0vcwFEgnsqzjZi1VcsJ+WW1e+piMH03pHz57orgeZtAMt4H?=
 =?us-ascii?Q?7/C6QfQjW5t2XK67TJGUv07EB8tUIrEmngj6VXxgJpqBAUmO/35M/gduFFC/?=
 =?us-ascii?Q?GAWSBbnB/awoApi3zzlgHfFBcxb/iZvg//nKjxt3bX3+/hbG3BTZHb0wdfy2?=
 =?us-ascii?Q?BZfi3sNrhwFduLs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cs5M7NuS+hcr4jDjyhV1gIYqhIQytWNe/9YoNBUXOAPiu9SbJEocQn0ODtyp?=
 =?us-ascii?Q?hHvC3Haw0rVCS6mjr34C+rEIuy6+BG2XgK6oWU8D/Cj+pG5lrrKzQ4Spg9R0?=
 =?us-ascii?Q?0FCsodxTU6gzwZDfIGIME3q/Jyehr4zRqa6T+9eww/3w9/Wd61hoDopZZUlx?=
 =?us-ascii?Q?1pprk6LgqY4Zheiu38+s+YNPfEUHIN67Ivir8XdNMSruWuutrg72T/vZ7bSM?=
 =?us-ascii?Q?Ych/4t78KE6HogzXgpMLN4i4Sq3TKp4HDTgZpuCUOQ15ddRx+J4rYx2fWXZu?=
 =?us-ascii?Q?4ktj0TPhrOLJ/Nr6dIIDJzlTZBUmDCHntS124otbcjz7sGUwOyHCzYL323/e?=
 =?us-ascii?Q?hZkTcI6t3P1alzwWs2MNlQ0Wn8xMHhMWd743OvU4508Zx8YAtAhASysTElxJ?=
 =?us-ascii?Q?fRs7RGrOdlWLWuEy3cmpjLA1PnyWOet++/E/25nUGQJWTch+A5PgAtsX+DpA?=
 =?us-ascii?Q?jD7bseH/CKWOYecT7pmb5vOxyvzhiLldKzkdgHwBf7Q4HM8tuODemFAPZT7M?=
 =?us-ascii?Q?q/D06/uvCZ/JunBv8X/0h4aAsNvEsdIKWdtPkkE0KzGZAKEKXCqMFL7JoTp7?=
 =?us-ascii?Q?YrOiE/Xr/3Eq/Ki5MP7VoOBIHS72pwgLMexeCBtpHrQp9MuciafR06fBhjvJ?=
 =?us-ascii?Q?LJ+mo1YnqerhY/RrKH6ykK1qkdaMjlbb9rD12LJhVTdcuyhjFTLVxefC3WL6?=
 =?us-ascii?Q?OwJAR7s0Ro7NZqGsno0NyW+VO+ERIX86U442TbyvkNu/iDeHwVnmW98x/Ec+?=
 =?us-ascii?Q?MGKbk/pnAYIWemWoLrDlSrxc4x/dCWvEcEmJOUl3zzA0uwvlye1jrcvVjs+u?=
 =?us-ascii?Q?66Kzzm0b56GYpV2jS3BHMb4+YqOT5LJcKHJ2UGxaTo2ZcJXoN9vJ0H5yDO3p?=
 =?us-ascii?Q?4qHFS9cHMbCiHjV/ua7NSgN10ROfcUmJR/U5OXv/0Mvx5rX2Ma1uUM4sZfbi?=
 =?us-ascii?Q?B7GdttlfB1V4vJEYnZP3Kdj8YvwO9RaHoTDyOkr1gmGF07uDvm1+GjqVn2eh?=
 =?us-ascii?Q?V/8mN0d3XHkt7cn9AyTEx6sFyRNudfFxNCskSi+lslD6LPpIqgsHf+JwJzqU?=
 =?us-ascii?Q?9AmVxmfvPFg+2PrHKsuUcxRRI37sPiGkUXB/DYl4rWGmLVn7ayaA5LNJbAil?=
 =?us-ascii?Q?EvLWcYM8whWCu6xmiEduv7qGakZwPglspt2HrcyGF+XKH5nahikAu5t96s6L?=
 =?us-ascii?Q?lMf/rw88E6jZFLgfhfOxGM1lUIHt8xMAhX+FyDKvKyusMFXEiqIs4bWlHWBq?=
 =?us-ascii?Q?q7+ZYUwezGvJ3PT1eQ51ic20UxJXmcBmnSIJvvCZMmpzu9MylKNtPk5keyTR?=
 =?us-ascii?Q?MEfAW7ll4GSvhl7qp8AXHCFA5iJEsV4sBDVyTU7G/AXVvxyM8dSXtMwqAljL?=
 =?us-ascii?Q?zptFqqfIddZQ4mjBtCoetfSMh2KkWuv7/W4JhvpDY+ZWw287Bs+wVD5+XuGr?=
 =?us-ascii?Q?THi9LXNYJhetQMssBpNYHtYR0V0A/6KJzhT1Dhelo0NLtsS5OOp9KKvMXDVx?=
 =?us-ascii?Q?/osodiLIMMyRVv+UqnW45n6uSn5Ws3ckZkUcfd906ZLEWzaWaUxfkbRc4SFO?=
 =?us-ascii?Q?OLdhIKYLp+0rxjwMLqM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06f410a0-7910-4430-fef4-08dda8d60226
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 10:52:07.1949 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ZovxyZx4cNmDDyh8C2bHrq2DTzsgqBmg85nN2XmiBEVqJSEY63NuQoLHoCao6+nu
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

V4-Chnages:
 - Rebased the series to master branch top.

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
 drivers/bus/fslmc/mc/dpbp.c               |  78 +++-
 drivers/bus/fslmc/mc/fsl_dpbp.h           |  41 +-
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c  | 248 ++++++----
 drivers/mempool/dpaa2/dpaa2_hw_mempool.h  |   1 +
 drivers/mempool/dpaa2/rte_dpaa2_mempool.h |  12 +
 drivers/net/dpaa2/dpaa2_ethdev.c          | 276 +++++++++++-
 drivers/net/dpaa2/dpaa2_ethdev.h          |  36 +-
 drivers/net/dpaa2/dpaa2_rxtx.c            |  24 +-
 drivers/net/dpaa2/dpaa2_tm.c              |  68 ++-
 drivers/net/dpaa2/mc/dpni.c               |  50 +-
 drivers/net/dpaa2/mc/fsl_dpmac.h          | 526 ++++++++++++++++++++++
 drivers/net/dpaa2/mc/fsl_dpni.h           |   8 +-
 drivers/net/dpaa2/mc/fsl_dpni_cmd.h       |  15 +-
 15 files changed, 1238 insertions(+), 148 deletions(-)
 create mode 100644 drivers/net/dpaa2/mc/fsl_dpmac.h

-- 
2.25.1

