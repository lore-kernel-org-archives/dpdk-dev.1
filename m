Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA38CCCA470
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Oct 2025 05:00:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8B621402DA;
	Tue,  7 Oct 2025 07:00:36 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013064.outbound.protection.outlook.com [40.107.159.64])
 by mails.dpdk.org (Postfix) with ESMTP id 43AF6402DA
 for <dev@dpdk.org>; Tue,  7 Oct 2025 07:00:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=n4Dje3L7buVa77mVzm+ZfdRgR6ZH/KFiwMR1qAOzeMQ4H9YwHEcOO9Ju6mYRD+O3/O0XwI+e7krzdrRkivBVWujWRESGmGsOQFe9bH0JV92dfLK9efdlfpmP/31EdBcYFDma7Qx5pZXsjrQOWezbLukpeMfLr2GDpxQbgPacww22dtGy1LxKwriY4Wh7wGmPxyWyOr6JxyOKplxUc65eoFfMfOhlOjpDlS45jr3/893jdvjGgcfUlWp2VBjOtIF7MpY0134ibyOqFwaHIId0+o1jO54ays5RHD9zd+Op9sHyRKQG3efv9bG6pgvu3uTz7h80E4lJlNowZ1LMTLJMmQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VdK4yidohrgtLwh1SjL02GNO1hwB32dtWIahsG2M6q8=;
 b=Pd6O7DQWewiVyVd6MRj7soMGh9TKXSLeu/UqDNcjQc64VW561e34D4gXfmDcegfno7xCbo8qvjvK04OdL2u9/4mYYSqKbHws6pr74mXlHW88oYfXmkD9M4SyKc8e/mEpja0AasJqvkUyNi3Tau6Mn4iwAnj5d7tKkp9noFSO5Gt4KrDQPBwIUzyuHneEEYGUmSeB3vzhl8zlysLoAFKJnKhrnpuDkdaEbD1D+PluoGqNXoDW05VbOVYIfFO0rlIfbCleb7hATCKgm3bDBmut0F9qD+Gpyu2QQUrfvVwSpL8Cma7RdLg/TBR3BpOLe9PguiRtg7TjaGL6LOM8SLZH/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VdK4yidohrgtLwh1SjL02GNO1hwB32dtWIahsG2M6q8=;
 b=k5sRUD5pEvSOZXGz0+eL3C2IyRPLqKWHU2knW1/Oz9gTylkvn+qs2lnz6gHqKDycfFA+o941qX53pdCnlyLiPsHslgdarE8/4pJVwJ1I7E85OF1AN+FtdRVJVxWre+SucLO0tffvyoyMvjR6ScB917kWjPIJ4iTOT8CBtldzfyc/ny7OFGUJ+O8ZMjmDo6rOmLQqWOPVJivgm6pernHUe8EhmBKtXDA6P+g7fOKNgY4OCpkWjs4CusxAOQX9gvk5OwrCn0DWTSFfbifPMp7PnjsQ7+lnQ/+Pni8iuy/H4BdJmoBQruUlhCqJmYIEw1cCj8wJHsh2TVPMa1BZPCm3Rg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by PA1PR04MB10178.eurprd04.prod.outlook.com (2603:10a6:102:463::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 05:00:29 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 05:00:29 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com
Subject: [PATCH 0/5] DPAA specific changes
Date: Tue,  7 Oct 2025 10:30:07 +0530
Message-Id: <20251007050012.2432449-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0117.apcprd03.prod.outlook.com
 (2603:1096:4:91::21) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|PA1PR04MB10178:EE_
X-MS-Office365-Filtering-Correlation-Id: 6af2c2f7-bb27-436f-41c4-08de055e6fd0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?c33/OpyWgHkbnfplfMGNuHhpN9jOJIRQE0j74sFoL2i/P9/fakCT26gqIVf4?=
 =?us-ascii?Q?wax3H9y73a86oak2fGCZSh059c+TW7dch1fDomLfZUkO8kPEks3zxY31gSR7?=
 =?us-ascii?Q?b5AHVnEBiCeHwqXzDAv48nDPIR/UXg3kotSusI60kimHpuDyOik+6nvXyBEl?=
 =?us-ascii?Q?UDOUBEEQowDP9DM3pTBCMunGCTiXvIUUgxjgsdlf340IxrHeE0Oe6VHdXN6P?=
 =?us-ascii?Q?CLBdBTF9PUsvPkDxBd3Uu1/l7s6lkqsWMUxmuiSSgzEsIr9iOJ6ijbS0wQJW?=
 =?us-ascii?Q?at+PWeNiqwLnAd12lujuL5YhMQA4NlZCgHYO16sV3+FON/2yCH9eolm3iDFb?=
 =?us-ascii?Q?ATByAc2I8seCcRb9M9BtUmwV62MeB3pcg6wqzhCM6hv8x++wCgiuQ+N4Zl7Q?=
 =?us-ascii?Q?IGx3xRrdqYoZl3ABEQ2fFsVmteB/s25MF0/R8HNLLvh19wqPsISSO5XA/yoK?=
 =?us-ascii?Q?1HLiXMtgzQxNep98qlrgKMvbmzgP84WmnDTO4rg0HVoDmJxNmn32yofjQn4+?=
 =?us-ascii?Q?rY8wvyNtLCUxMmWhitpNdfHHUxWQS9+ZxfGr+hQaxqUCA/6LlZmlcYxAsrMy?=
 =?us-ascii?Q?xme4gGGKNRRgJxizqTPCWQ7t4p8Yk8U/jWbgouX+W2PEJqGtynZuxDC5s43e?=
 =?us-ascii?Q?pP1sdDSPRihJCfcY3H0XjYlib+E5BTAWWznRANTluwUcMaTXRDIB9Xv7ghtv?=
 =?us-ascii?Q?KC3jCBYQhtK3J0Eh9nzDMchdCcQdxCXObZEJEIb4K+dPrwQB9PD8GPHDlIht?=
 =?us-ascii?Q?AgPocmD62lDT7kWDVl6TdssCz9cJes+9xrxD3RuxfHT376Osqj2oIiLKZFAm?=
 =?us-ascii?Q?FO6H+xj2AiOP3zRN7p0wnSKs5pxaQfrgPWjwS9AhnEA023PHKlSfS8CF3LOG?=
 =?us-ascii?Q?B1eE/HXgx+/LIvHB8gMSvweLCGl+UlYIIgxgPWnSGeJfxP+wU1u9TQUEqVp2?=
 =?us-ascii?Q?269UzaD/bmA4RSOrqF8gdh7hGhBLDXUTa6UGXBHrP97Sp8DvoHRxY5fk05No?=
 =?us-ascii?Q?B9EfFndRt5rZD+5uqOLLkMQoGswtkOdXhYWDUzOVL003dP80+/HPuvj7/OwC?=
 =?us-ascii?Q?2Wb2fb2xE3CtmifAS4JkVpHU9qGiykU4Az+Gi0TXRu2QzoGnzaG15PFT9oOi?=
 =?us-ascii?Q?okFWSxD3xLk03vWI0ss+guawlQbJA8sLGA0GF5ZqDmNHgDRoWF+94EU9WZOK?=
 =?us-ascii?Q?yc+9Wr2LCyXkMD0zFJvYUAtFiGTf6VcOcv2U4glUvN3EVnYW2JVD6R6iuwcy?=
 =?us-ascii?Q?0209xQnBK+CBaHyeT3Q8vQgXh4GdmcewGg14qG6WSehvQoQE/o1WPdIUJK0k?=
 =?us-ascii?Q?4Cr3fK20xPBn8V//2UchKMY0w3ya9e2gECB/2/OVkkHecMQNq7VqQo9wKYU7?=
 =?us-ascii?Q?Z5fq7AX04C0/XB+yefYbJqdvRPVNCSdMYNBKX+VrA+tLmKX39435ifor1V4M?=
 =?us-ascii?Q?VJlVLRRh6jhzvRBfhPI8qAKFQmLaZo6oNVxILEikZQDCdJcOcNUBcASVF4cH?=
 =?us-ascii?Q?D6ktR6H34m9H9kVSggGt0mhZZyrHWJKf11ao?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l2iKSNXAx+yEudgQqqeRiQt7ZyBTpaLKJEBxoNBYjeBOSGP3ZXcG+BpobKBY?=
 =?us-ascii?Q?wVElXewmgBfXxfhOiUF5ExxJncghLfLmKdYjGIK457JPqTstz1COMbgrzE9E?=
 =?us-ascii?Q?1Qb/Zqbj/QUwIlaPOjsm6QbjJLqFR5GrkVmROAevrjNQT3BS+9vNmJcyWGSQ?=
 =?us-ascii?Q?UGhu2ZPPUSYxu/0r0IWkAMan7LlE7RApTK0HBJ6Mzwud9qwmzyDPfwTJLH03?=
 =?us-ascii?Q?A0JA9INrFhjQRqQ+BI/7af9lGq9jdJ3JX1qKuHI5vEs9GeFftxejDheUA/1M?=
 =?us-ascii?Q?M91+eBZ9EUkI7jLobdDSUV2B5yhZeCrN6s7T29MlBV6gdUKhK9MgZwy20+9A?=
 =?us-ascii?Q?TVJ1frxe78vbX2OC/GWhniNuApgp1dJyZzKsbY036DS3WUbrEnVUOJUoBNnK?=
 =?us-ascii?Q?PD52FTstonXOGL9i6sxoXnQg/P3q/Phw5qe2y8elEa+cBgDzIcU5KosU1jkz?=
 =?us-ascii?Q?BX9TQLPnmLDYXKvHCJayub4h5Kfr/7gIIB+lPfYx+4terbPAv2r8Rl4sMm9O?=
 =?us-ascii?Q?hGyDWFOhRc6td8pvm0WoKGAvMeUxVdMnQ2owBVGD4guAUAJzYK+horPmZZRz?=
 =?us-ascii?Q?NHgF/POr4PJtf0rveepX8GaeYkEyVUTaqsoMvqOnPHI1xDf9xDElX02AuJ8r?=
 =?us-ascii?Q?el0+LO/Q+a7Bm7ouxBm5r7RCgwZkOuwbYZ1S0HO56aTYa39Fm/hEZzpuIIyN?=
 =?us-ascii?Q?8oB9/NfbcIRt16B1pS3oGKMBZjl02yy+OFiwkLAAbRkRnD3UX4143PrZ37dt?=
 =?us-ascii?Q?YMhcNvxVeHpr8nuRVciYdGCGav8RH1NlJsTh9EHMR8lwDMc/5QPjsOrhqN0e?=
 =?us-ascii?Q?oXqH6SayTVLpgsPXnvO1cWOqX7TfixFGZPy4RdTWTTt1DSa2aQmtHl57q4sW?=
 =?us-ascii?Q?3c+eChbwJlxTXJeiW93BS3HUf/zLl6etTMHVtHa6a9wTaZUBOrRIYBa0VcgJ?=
 =?us-ascii?Q?MzdO7Nc33FowkDB2zlTBzZxPRNZ/cz9OEzsnWSEnJivKEQqYkovRnA2Y0oKH?=
 =?us-ascii?Q?6qqlvLLM/z4ZGSLhEfHEJGxY20FnctO/H2CFtpoxrg1yBkLNfp0b36/g9oh6?=
 =?us-ascii?Q?aXD1Ts1OePmSiKd4LoqtqUNdMOEnF18q9UJPHpX629sJako2e4+XX8r/268/?=
 =?us-ascii?Q?qYarTnnTsbAmJ8pfyOyB6vYou01AK/h312BKTnBUj810jPNIRoBO/PyMVrYe?=
 =?us-ascii?Q?2Gt2GTgGnGLU79dPadrCAlvwQFsCleEm/8nGREWwhTafa3tXK6Oqo4SoyQIi?=
 =?us-ascii?Q?eJQWi/4KQxncgc4NFXxBulVHx/kn1T+3mwiV+ctFmhZq5CABYb1yF5CGFlIP?=
 =?us-ascii?Q?6N82RNZx/QfNmgTEYyIZOTh7Q11100QWA8ovgMOnxIvMjcZAKHc2RtWqSXiB?=
 =?us-ascii?Q?ae6WUT2CKuDRNEsquwqvQjVG4xSbmUenS+fA7SnHEZLHRK+FYqKgnX5oObfI?=
 =?us-ascii?Q?TtaOS+g40+ePGne9Q+JLLGS7sO2eMUHokc8awUBOnrHPmIbJ8mISJ1HqXA18?=
 =?us-ascii?Q?aYKFl9ELkxgLpN0nFcY1m29fX8AFCbxeJ6LiSVZ6LJaDQ00VDHaNjH5E1Ql4?=
 =?us-ascii?Q?Cwqh3nu4ICah6RnNu+Q=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6af2c2f7-bb27-436f-41c4-08de055e6fd0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 05:00:29.7544 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m8nEoW6rVi1ANjh1/uPliB66LmKgOQjglLx8k1PZUt7xM63bADIyzInLPHYrDcIC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10178
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

This series support timesync APIs, improves
queue reset logic and include minor fixes.

Gagandeep Singh (1):
  bus/dpaa: add FQ shutdown and improve logging

Jun Yang (3):
  net/dpaa: Support IEEE1588 by timesync API
  bus/dpaa: Disable qman Invalid Enqueue State interrupt
  bus/dpaa: Set max push RXQ number

Vanshika Shukla (1):
  net/dpaa: Fix coverity issue

 doc/guides/nics/dpaa.rst                  |   3 -
 drivers/bus/dpaa/base/qbman/qman.c        | 412 +++++++++++++++++++---
 drivers/bus/dpaa/base/qbman/qman_driver.c |  27 +-
 drivers/bus/dpaa/bus_dpaa_driver.h        |   6 +
 drivers/bus/dpaa/dpaa_bus.c               |  51 +++
 drivers/bus/dpaa/include/fsl_qman.h       |   8 +-
 drivers/common/dpaax/dpaax_ptp.h          |  95 +++++
 drivers/net/dpaa/dpaa_ethdev.c            |  69 ++--
 drivers/net/dpaa/dpaa_ethdev.h            |  13 +-
 drivers/net/dpaa/dpaa_flow.c              |   6 +-
 drivers/net/dpaa/dpaa_ptp.c               |  50 ++-
 drivers/net/dpaa/dpaa_rxtx.c              |  93 +++--
 drivers/net/dpaa/dpaa_rxtx.h              |   2 +-
 13 files changed, 672 insertions(+), 163 deletions(-)
 create mode 100644 drivers/common/dpaax/dpaax_ptp.h

-- 
2.25.1

