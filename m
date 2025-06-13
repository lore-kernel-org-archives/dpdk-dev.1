Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BABBC61CE8
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 02:11:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DDDDA402E6;
	Fri, 13 Jun 2025 04:11:43 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011023.outbound.protection.outlook.com [52.101.70.23])
 by mails.dpdk.org (Postfix) with ESMTP id 90E31402C1
 for <dev@dpdk.org>; Fri, 13 Jun 2025 04:11:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HKypCMFBZhzBaorWLHJxcxqXZ1g5efOvNfgabfIZA34KoOUMLjesuNhsrhKlOgHh6GmPC6CZtQGRbbWR1Et4lOcZttcq865Q625BTJwCgVld+Zvd8fJo4HeQcOoF/tFEXtUH+y2rK9TCaqJyFVC9XcrZBj36g9upmTT4KC8x+2A9Wt2uHOYcZU6Ofvq+jWMmDpWo327CISNc0Qq0KHhGv+op8t3aL+a5hFxiVDeTQ7NprLlQdTunBHOu3Wtq3GxYpwd90xv++XTsGVIaCzReRbUjvrWr4E+EUSP9eb5hKnRVbCf3ygblXPec5CIub4JeO267sxGfhWnIeibZSpNR8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VFNtfYzSt2HQVdUkhXVV8FAPeD0dOJyFXOceU8xAf6k=;
 b=Dct/aF1yg0vu0xPxcbRJJ81m5cRZcPMSZjwU58OewyFnma94lTxrmo+1Gf5SgJaMEO+UFSxMq1nLRf2vspTpL3BNkeh25/oWaHp3Y3w1nYMdSu/ZKg/Po/yaZNbToSLqZQxU50dYqlKqxRaOaeQwkNiMdv6+yhKTRd8vzzlQ0dWmKF6BJiZr2rQVHj+LPY18rSeLfdXLmJfgIXtbQBLPjdBIA1DCSpV4aP5fn/p6yhiWnqnz+8jy6whlv8TSpyZwJUdbcWkT4ZQ3RpX3KfCYQhflS4WlfYngujw2Pd65VykFoKdXMdHwAqtxg42ruQtjEwsECyILOH4tWGrmP+sxAg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VFNtfYzSt2HQVdUkhXVV8FAPeD0dOJyFXOceU8xAf6k=;
 b=ixNVaXe6vnLnJ+dPaWTqfEnSDk8WvIIrqM0HZ2Xxs1HF1L9xIrzIrfRYbkMrcb5K7Y2cPgJ0V0qTmanE/UbEYtfIK0IuIowvUA0HewvFEwT//ZnnkP6SYqb85gULFKd7T3yq2FAj5AihgGP3mtlysgbjsA8CRGaOpp6AmL7Eyue/uubzpE2gzcjyIKz2iERrIKyTqZgWLV1/XvMJMchnwkAv0gK8vw1sNNgJnl5X14Eui8zqFtCTPB3TwnPLvIckeTA1Jy/x1VjXk1Mr+1o9kPBgp/t45tfc1TcpRJL60k6kHOOhQuD4j2saUJPPn0OwlEp/CJtt9SA46LVkxE5dcQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by DB8PR04MB6907.eurprd04.prod.outlook.com (2603:10a6:10:119::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Fri, 13 Jun
 2025 02:11:41 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 02:11:41 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com
Subject: [PATCH v5 00/11] NXP DPAA2 driver enhancements and fixes
Date: Fri, 13 Jun 2025 07:41:14 +0530
Message-Id: <20250613021125.790614-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611105149.655144-1-g.singh@nxp.com>
References: <20250611105149.655144-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0124.apcprd03.prod.outlook.com
 (2603:1096:4:91::28) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|DB8PR04MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: c980c8e2-ce5a-446a-9114-08ddaa1fa2ad
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WLLUvsQWDQg8Bp0aJwiRv+pomZHvPG6WCIFd6ZbGJy91YR4qmEp1Mc4I4z91?=
 =?us-ascii?Q?T7SG7j0j0QmAV/Vx4HQcwKkY+K+una7Ko/solb/rhRbwdH9bGOwf5TRtb3t0?=
 =?us-ascii?Q?IAMglRLGsVCg/G5cum11VzVC08Mi1/OPZhvKpb1Ak6zZ+Ck3VDnS3mcXkrNA?=
 =?us-ascii?Q?koWbrCmrQinofeOnYidGAhrkIHi4P3OwSKN9KazDqREy/k00OYkKhSLjOK7f?=
 =?us-ascii?Q?TPzYLb4QwYW1jy2IGN4rWp5wZitPO82BarcW41dXoTm6LufJLz6Z0pQEaaq8?=
 =?us-ascii?Q?APP4h6KTPyIWPG12RP5Sv6F2EkZD/gj2GtFFKMjhS9WliO42cyAVbabI4GP0?=
 =?us-ascii?Q?6K5+JYVel4KgefQeN9ncly/I+cd5t+fguRr5aOaOARqwSFu+JQyNKA9PogWv?=
 =?us-ascii?Q?Suli7JyXgOnIQcMvU7BIL4J+BCEa1fZcOIaifwZFtgJZ5E4BbcR+hbfOFRY3?=
 =?us-ascii?Q?010UDc5U962atXUM57/sOwNDSlWKLVF0bglUYOFuiDqTCvHtELz9iHPYa+Po?=
 =?us-ascii?Q?NJNR961xlKr5s5kcRyVLv59+SnuCE7IjAdmtttjikTFI08g7Vb4BS9nVjdBz?=
 =?us-ascii?Q?6616oqVu4F1cifAM89rFJup+UJrj+m+e8uSrfZwA18N69elUdUOHkn3FDO+R?=
 =?us-ascii?Q?1OwRvhDahfkwKaDD1EsdBc3rKsdRD8/PfvFXDkQckAxHsZ4AIM3T6flh7vtG?=
 =?us-ascii?Q?gyumA71NmY3pOrGaomD1ykE5uLy/WwBOqiXfYB5Ukm0xMg4utXXPij7pWmFB?=
 =?us-ascii?Q?YoU4t6HuzzDYf7NQ0SfW3HLYOyVfL5KMvE/mwbb+t5B8HfpXzE4O287MBiqj?=
 =?us-ascii?Q?ePRfzm/HqU9CsgLOVd2roNH06dhxTOQzTlu1gPDHP/GzabDgstp5bz2tJMs3?=
 =?us-ascii?Q?oSvHAEdukwNQxpvqpYx1RLozuzzX42horMYQagMvt97eN21R76vMIRDsw8Jr?=
 =?us-ascii?Q?aQLWVKGgL6reKz/Ai0l5r1oVnCyjQpHfLRIsNcoxcQBhyjQnkrscdMwMU3zp?=
 =?us-ascii?Q?n+OBSHuLjzP4Cqxpo25nurNZojHl8AW8xHr+8xIln1Fub/h65xNhDqp0gEeq?=
 =?us-ascii?Q?9hI1NPwTzZGcw0cWm1DkVAAHhEXvDjZJ4kpDisOOTbnJIqcH8O+R2FbdJJH1?=
 =?us-ascii?Q?7JjXgloXByF2KwinfphUPCazvXL7qWeF2Wcfx2W5FjnX1O7aEWq2Toy64ddV?=
 =?us-ascii?Q?QuRQahYLBq1me6yTe82vu2IEQKnPssHBu5a5KF4hYa/dsjDgMdzNDhf7dbnX?=
 =?us-ascii?Q?UZM/BL4+nVQjA14jxjGMPZkmW+AfFpoW0d3c1YcfdjrObtMN6HzAWV7VMLx2?=
 =?us-ascii?Q?iXc+oCo1cpoTG5X5p9IO0PcYsv/6hr4nd7PHTR0kOYLr20tFbVeP2LDvq1ai?=
 =?us-ascii?Q?LitSafpIajzhubiNrI5nrv8JKrk9Tx7jHT2oJe3AsuMtdYq5/ysGwOsOZqmU?=
 =?us-ascii?Q?VpeAK4YHLHZIAj34hmGCbvfzZkUCQP+vNiFdkS5xHyg4mIiapPJYElWQyzPw?=
 =?us-ascii?Q?DpVETc5CQ/FnTwY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/gtRX5C/rhY5SRAlXE4jBEzs9puRLrzTJwmgVl/l7UzHZFO7ddimQsB628ip?=
 =?us-ascii?Q?ou9SufIkOpjlynlBgPESAEPs8Jf/xNMkzFssOuGw/zH5wYAO2/eEo+L7Ljgm?=
 =?us-ascii?Q?rFj7GH0UezHrsf54EUTdavxcWn/fvvaoIVKC2ar9VM1ehVCcBGuNHnTS86RV?=
 =?us-ascii?Q?WhkMoD5kGHq69KFVnGle4wR3HD87PTVNFuOKWTyOGxg/l42zGqP3hgUeyUWd?=
 =?us-ascii?Q?HgfIcdIXdP4AUKFt5n1MNnpFpKyXHteFbhcrQSA/rCl71CX1kWJnouXMG6Vi?=
 =?us-ascii?Q?JWXZLTQsIqJL405f5IP6uiT4h6vSYic7l60UvyZ+C/0ZW72oU12mhDK0ZAbs?=
 =?us-ascii?Q?iWToyiAbwFxTZGX/O4ulOlTFQDY2Ri4pwWf07nN/+yfdyMPGWNdtpDfkvRee?=
 =?us-ascii?Q?ah26ovkhVzlgP/2R6nvP0+Ag10S3wZ67WhF0TpaJNGa+NLGHQqA7MAJrx6wl?=
 =?us-ascii?Q?Do6tIu3C853ymbxRkve49zVxCWLsAc0fRCGZi9xgoqaDKFGISacmtmT8yWkH?=
 =?us-ascii?Q?D+l8ksYht0Ksh/XotsWhWjoh3Vkh/0cgp4h0gvCTNC2FVv0bJDFOyrYqC9M0?=
 =?us-ascii?Q?LFG8PgX2DCkpVPCY6JisHK5E3LHJvmbQ9ArzrMJAx/2FsC5FniYSBm9TbIk4?=
 =?us-ascii?Q?WveBxLt2RPXb5JnVHkWgB6r2BOpULS1FbyEbEgCJI7aT5SVv0Ya1LTIZDHJS?=
 =?us-ascii?Q?M+hxc8Fk9ORYM11SZvJMLATHd7nt26Ou2dCABZOqQx72fCkZ0VzEvo5ugqJd?=
 =?us-ascii?Q?UYkkDtAk4W4NdCYTRFl0NjJxetZbdJbahPq+5VygAJu1F37x/hH4IIpmdhsC?=
 =?us-ascii?Q?X1pGTB7fQQS0fxTYEHv67FWOQvg/kYz2rOQZ7NAgd+wjYPcjI00ykJh6Jeo8?=
 =?us-ascii?Q?uSHvfxQs9UymHeuouqHJjH+gh84/d3J44fOQkbN0BZWASpxJn7cc8RFELTf3?=
 =?us-ascii?Q?WuKRm/gMdBMJv3Ccw0mWtk9qf4VjheX3Vuv9NnLwzNURNZAN2R+Yr2YEbepU?=
 =?us-ascii?Q?lC0JhCuaryFmJJ2OEcccSaNdnRuDtNJUCj3u4DK3GJa31RZ4Agt4mxQBd3oB?=
 =?us-ascii?Q?CeJD5gDJFmn1f0+So3Fdgzz01IwshdG+r7jFNNl5G+OcpVv3gBy8HuryIsrU?=
 =?us-ascii?Q?+2ih2LZgTDllx/cqbvElzrgif3fd1MLoIRsoKyqbkhoE+T+P1zUOiQEx6h54?=
 =?us-ascii?Q?mfU4DWW3F4gl2UkQ2Lv++RuS2KcjW2fgcAo4xWixdT8K0QGOv5vg2q0AtgrL?=
 =?us-ascii?Q?nQbybPsSOhguqGk5yMSh2n9CkdkMZYYxsjfOQVt68enF0D8ZTxT493cMxe0x?=
 =?us-ascii?Q?fAn+87Is6cfn6lQrWvjA37gHe5Xz+r19P7u6VcErsT+XKNzsclXS1MxbgkVG?=
 =?us-ascii?Q?wNK0JtbGa91Emo+bt7TUswlkeXP4YTQp67B/cej09T/jybbzoY51ZP4fO8gB?=
 =?us-ascii?Q?c8KlxRBVc3NSS26rutZZI8MJy/PH0YuoopEa6QWxrJZM9TwM/8ZqJO1h2OAt?=
 =?us-ascii?Q?WMz7qQQdHAuszUDOR1SA7OQelC88INDcbqI9G3hC9rt+Qgw+TjGMNBXnK5NJ?=
 =?us-ascii?Q?v46E2PZrHl0A7PdvOk8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c980c8e2-ce5a-446a-9114-08ddaa1fa2ad
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 02:11:40.9931 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eUKD3hEsaPySDK/B3w8+E1PJgxRpkxTO8hC/keLIs92cPwJkinvMc4YQyKPB7f1r
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6907
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

