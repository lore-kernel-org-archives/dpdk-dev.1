Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28BCDC54FB3
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 10:41:02 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CC6F94025E;
	Mon,  2 Jun 2025 12:41:01 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010039.outbound.protection.outlook.com [52.101.69.39])
 by mails.dpdk.org (Postfix) with ESMTP id 1BF7E4025A
 for <dev@dpdk.org>; Mon,  2 Jun 2025 12:41:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rD7/IoQTBpZw+UqrPtYBriAwfiqFalIX6ENQzWbb+Exm67lqoNBIE3JS836+1BwNFpysrHqWW79zs5eQbtACU+XzBCEmRrPVBmlBNcuaeCKVgUi+E3cspDdU9AZqGEfErvRPUJ+T/rj5H6K3o+VwD5chTXx143pHI/f/m1Jjhgfg6HAGv8aOAZE90g6i9YDv8j25rXg3LZ+VZfxDVUpNiCnZ37fyOaKyeyQgNlGf84Wq9SVwWaem6PAGN1Hdva7pZfwAEhFViiVSIGL8en+5YEFwvYdvxPcqmPvwb/IBo0cgVOo1ao+qxIoNUvn4atDMsJqEhSZBJIoejfffZ/eSPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rl0VtLPAsTGkgaOzjHgHBoiVTUpTnKAlAjdMCuImYdI=;
 b=V42NPu9TwzPr+wwCTJa2s+PFe2lKnzxDB/B7UcTepbUiNANgFJnEWmAwQ/AwXfZP6koptI/HWONA22RJZrkWMjA4/EeLa7JBXXtijhh0jVnf0xtP2ILOKupYBhc0r+tZdT6IsXo6PPDCc9sVIkRRW1jcXuruHn/Q5xEQ85moVSKTXhuY/Pggy+aqCAHM+bahCCC55w3AiGwpsDobMw5h/Qg8wUzYAqWgfX8+F5O+qQTK/s0sXLNht64p6P7iIsmTC8Jyc0N73sLv2vrbAICvCZOpNbzISPbM8Wkeu7HCtZI/0JGNsHLBGFOCH6z+Q+1TCqy3kXyq4La7zk+pBDOBHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rl0VtLPAsTGkgaOzjHgHBoiVTUpTnKAlAjdMCuImYdI=;
 b=ZBzz5S7AK9avvVhMDlQNGpLkOK1EbYZ5f3YceEt0FccWQnq1AVgoHTFJrXHYNXc1aCuSsJUXT8ll/ZcCEzG65l9lx0plIqVZGOiaRcQCGVN8LcT/T/hObgl6qIpvnFMN6LdFWgaD5kzeuMGeVuryaf1AaGS7RBycVnhPvdvHiusaM/o6X2pAuzUsHPPs+xxn7zhghGHzQ+AKtRn713OvK4PT3+jY5nDz7XBtPP+W91PJaQo/7a1i2DQW8W9MaP6vVMJu0f/L9Ev7pbwJGiUQj2jfCPCMo4mrxyMSWZwyUzDC4AAfLaVIgMoQRIUixJjZhuvHduhz1bj5ojuqnXyzYw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8194.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::7)
 by VI2PR04MB10956.eurprd04.prod.outlook.com (2603:10a6:800:276::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 2 Jun
 2025 10:40:59 +0000
Received: from AM9PR04MB8194.eurprd04.prod.outlook.com
 ([fe80::cd61:3920:b12f:6561]) by AM9PR04MB8194.eurprd04.prod.outlook.com
 ([fe80::cd61:3920:b12f:6561%4]) with mapi id 15.20.8769.029; Mon, 2 Jun 2025
 10:40:59 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com
Subject: [PATCH v2 00/11] NXP DPAA2 driver enhancements and fixes
Date: Mon,  2 Jun 2025 16:10:30 +0530
Message-Id: <20250602104041.3322164-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250530071344.2939434-1-g.singh@nxp.com>
References: <20250530071344.2939434-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To AM9PR04MB8194.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e6::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8194:EE_|VI2PR04MB10956:EE_
X-MS-Office365-Filtering-Correlation-Id: 0fe636ed-6727-4a86-19be-08dda1c1f62a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?WS/MdE8h6RyOI4Y0W8ox/dvmSKqzlK1BK6cZiUhByVok8eMVv23q3PPUTU52?=
 =?us-ascii?Q?wXhPLWUZMqHkgBrAT88FoAfEDIwOUEPsgPbsrINl/RIj96icCHNlwii8mNN1?=
 =?us-ascii?Q?7NX5KLPbJEEwhvnyTa24cCJRdsH63y9Fpo0KUV2EFZ3odv/l/LG9flunP0I+?=
 =?us-ascii?Q?WQjUzYRP22HOhUPmXLRnnqfuSAnQbHQXE753OfSgU3lly3WY1esUUiQObbuc?=
 =?us-ascii?Q?qRDCanhpcmvIvesZu4qNHSrtSzT4b6BCtrmd5XABk8SHQrZdyZ0mNlqeIIT5?=
 =?us-ascii?Q?aqfL654ILLFYriLEWaRtWCoJG8jclpj5L2EKJdUfsmUtEXYZaGQY4FHAV2m/?=
 =?us-ascii?Q?S2DQWJuusw/hwTL8HIyQQuvinX0G2w1033pAUO1xQ8yL8L63hNtb6NN462we?=
 =?us-ascii?Q?k2NFtTCJQKbO7Y10y723F4egs2c6vjdlUd+j6SAzlG8amPysKizf+pyOIl1s?=
 =?us-ascii?Q?u4tT1DEz8nl1wH8DZ6wLomJpbF3NIz22vKJSWpsYm1/0NBvncjjycCiylIrK?=
 =?us-ascii?Q?mr4Egne7hd/tRVxKgVk92Bn1G1PRH+QCJ7U81rVHwuLNbzs8a7ZXvDoA5sZS?=
 =?us-ascii?Q?6nUeGw1EgiuK1mbm98ImWz0tqlstIn1fieIFE/ZX8YsDV7XNREGMDSngnQg9?=
 =?us-ascii?Q?3Nu7T9mq0/PQSmIY1uGn2ZyWhK4M2+RFnENgJxitiCFP9MMWn69NAZ1/Knm4?=
 =?us-ascii?Q?RjAvIzCWph1DOOl6xTJfuhvAs+48Ng5EWRCWYYoq631t4Evf9CQdBgLeBqrj?=
 =?us-ascii?Q?2QRg+2UO1S5f5hkxN/IvUr7TGT75IhLt8jQrmzYcupxcL9qopEQYiXY5r4xs?=
 =?us-ascii?Q?9x8K7SnAQRveZQ8Fqd6NjUByolzyqNUD7JyTZhkYo7bj5bKf6CwsllvkbYYg?=
 =?us-ascii?Q?A3at601kXJPHBuZ5ZBHkI5Sa1emgUc8Uqsuf497u56uJ3coByLrxu9IYe7rj?=
 =?us-ascii?Q?tTm48GScXmVVh/CFhljAUYN7sojQ2vE+iLz4kQgV7SttXj2tbvQuNIfS5SbF?=
 =?us-ascii?Q?wn0WYLk0rLB3iHpTYI0/IcF3qitSdivhHFuXCcztlMz3kLowYxP07vwcpn39?=
 =?us-ascii?Q?GN5lVC4M3eAMphoTPQ9xydC7qYeFsFsZZjVKhspNdZaRhS01y42YPfV9PG0y?=
 =?us-ascii?Q?r1OO0L1gaDjOaNrstVJvCJFBx0JK5e6j1+BpRwGXm8fU6oweco0j8TYLNjcN?=
 =?us-ascii?Q?NulUMFLYxKMLGW2JPi9mLimjrtloLj9w5oE+ZxxuhXfQSZjm+uISKYnDlFY2?=
 =?us-ascii?Q?gsssrNQTCvTq5DW+g/tsEiFdbauRFIvMJZ9Vo0LiHWs7u/fn/5QVCPAeokOJ?=
 =?us-ascii?Q?N5D8ACB95PtqKDLbrD5fEPC1hfgLMqDlDOV9VZAyJZOOBERQXtEUxHvLq+1G?=
 =?us-ascii?Q?VrxkcprpSjNb9tjiGETZfqNJQwctoRdAhGdhMpwCJSEFvOzrhiYLCatFccR4?=
 =?us-ascii?Q?QaYh6heyd5kaUrbTaltJvfAt9WAjCtuoRFlkJ69XIcWe97SLxtEZAYpeLPoN?=
 =?us-ascii?Q?mGodxnh5+7U6mbU=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8194.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?rVwQa9mdcZp7a+XRrKiBY+GMhXeHjDPjypXOALi57iH3n09E6vrVneNd5kMp?=
 =?us-ascii?Q?MfCeCy5iuBcGv4lZgjl7LH1spCWfCXXcGnpTx3UfujxRcW4gaWicRnnP3VWq?=
 =?us-ascii?Q?r+jHKU2EIYKRewobxAUoXvbrVyae92PEM99UV7xjWdkA+eusNi71PHrZOB7g?=
 =?us-ascii?Q?GanhdMHKlyeP5lamZFCGNgCVcRvVs+MBegHPsctffHvon9sEwhy5LjWHX/GR?=
 =?us-ascii?Q?VJxtIb2Zwot2ggSc3IaIlqzCaB3mkZanyd3otWB4/ujs4CxBx3apUtTaKrlo?=
 =?us-ascii?Q?5JGEv/ygkmYAUdEARYOAG+RaWMA7C2B/zjngsPbStcosp8FROcXjb9CEJeSe?=
 =?us-ascii?Q?yRR2NstJOOjQfmQkq6uC9jlYfp8Tj0svTbGW1pMvf5up2rhpggpvwRS/0IBB?=
 =?us-ascii?Q?+wLe7bPJ7SsgOLCm+TMxVcOt+zRPzf2y2TPj5VdoYDTINXFavXt/+0VCXlEH?=
 =?us-ascii?Q?Z1YqjPpf5SeYI63BpaLi/rFYYcakQYd+3PVmIu+sKyja4kEKUS/m+I58yXZx?=
 =?us-ascii?Q?9EGFF2INV279KsU3zoZJhPx19cnCR5yvEk12UlX8SXc+klyxe/f1Vu2NxFSK?=
 =?us-ascii?Q?nrCsiQgq/124t99HCfKzTcjmHyWnlebmwdk+zlJeSt2rnnAJ/W0Jp6bYDbte?=
 =?us-ascii?Q?yQBnUlGQVTGjjUwNB21ti5+0boM/IB5Hx5YJSivgsZ/dD4ERUSk8JFPlZ9c9?=
 =?us-ascii?Q?N1OoaJeCRsMKQ4/+eTwxBFhKMsd7kjMtNAE4eLMZmoUztZvHBHMfGXlJQwxO?=
 =?us-ascii?Q?S6xqm4vkg6M7kSrvD80ocknqQWDaFSS5HJ/Diq1X7GpoVWnlP7T1FnfK4Wvh?=
 =?us-ascii?Q?5IAMb81bCetB/ZESDzjkfM4BMKRSGl1O7LGoq72itBVNsafFVorddMxBGXQw?=
 =?us-ascii?Q?rXrTzgmlhgrzvZFolSSN/JvUsxl6ARV4o331DmNF1FcrlgxmsYo3V68LnGzX?=
 =?us-ascii?Q?nBBRLlqPhhtxkIphI1VVMKkopoS6jzeuAscoENfNPoIQSGIe2wY5O9PCWeU+?=
 =?us-ascii?Q?beB937gTgRXehP96zX+a+wga+JDDjDh1I+cDFwzHvhxymaeajjr9sy+YQPpQ?=
 =?us-ascii?Q?6T+BvmAVyFuQFfiWY7Ri9k7KxWChc+fsV1SOaa8V42fp6ClLDSPL4P68UM0M?=
 =?us-ascii?Q?NMZJL+Lx5vI9uk5/p1Hvg9gzL1QlVP4p3PQceg2AOGsJ3SIoe+VsUpRuGzve?=
 =?us-ascii?Q?BkolyN5v/pHEvqr3X6cXqSmrZaWyPX8Uc2VbXh/GxHXtj4cWyt63b3RUlMbW?=
 =?us-ascii?Q?jcJdqUdFxcLBRfOcgcc3fViLJxQfeAslTS38On1oLEh9xXKRU9Tx7XlJZVcz?=
 =?us-ascii?Q?65KYfkx6vhDf724HZWcjgbdm2Ljhl3zGZFNVqofg4HRTgQiqggyCvAFDHStD?=
 =?us-ascii?Q?DswrlayhPNd8gOuq8AGWyYoIuSd/G+iF1wfPWF4SZC1IOfXpQZacadYMDqwA?=
 =?us-ascii?Q?ffnxep0E9m3lVkvW4/vMOnYPIpL9vJPqH0kiI6ZXjbwTgzuw7JQhOR8Ds6fA?=
 =?us-ascii?Q?+a3Vf4PzDnEbRahqglLcUqR653/DdgFD9vz61HXNRbG/+vhVZJtnUFoOYhyc?=
 =?us-ascii?Q?44hlQtx+1Gz/DqDGBZ4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0fe636ed-6727-4a86-19be-08dda1c1f62a
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8194.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 10:40:59.0547 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JxgiWfzN2Sd+1c6vXwmLLRUxvIpQsVP6rIpcRml2xB7QLNMOLe0+Zd8+v2MS2+Y7
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

V2-Chages:
 - Fix compilation issue on UB2404-32

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
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c  | 248 ++++++----
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
 15 files changed, 1263 insertions(+), 148 deletions(-)
 create mode 100644 drivers/net/dpaa2/mc/fsl_dpmac.h

-- 
2.25.1

