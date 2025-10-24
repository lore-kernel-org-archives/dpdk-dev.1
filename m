Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3115FCCD1A5
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 06:19:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D60340262;
	Fri, 24 Oct 2025 08:19:24 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011011.outbound.protection.outlook.com [52.101.70.11])
 by mails.dpdk.org (Postfix) with ESMTP id 610ED4025F
 for <dev@dpdk.org>; Fri, 24 Oct 2025 08:19:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OL0DiEna6Rh4eAaOrWAF1/Y9N62a8zFaYbIxAj5iP5XsT85WTHN+A8kaA5FLIUKfkXW9KbJVa/wCOnskgiMndgzC7fBV4bCFv0eBILEmkRNQEgyETbVq1M3+jRX7Z6Vbe8T/zG8RWfm+tthPwo54nXihvV5DEWLhXfin4Urtjn/PyUD0RO8apExeY/uIiqhmhdzaEqPM4SlOLNwB8PDcU76hZTbIrGYcNtRZA7xIWm2/G2Xc1SdR8+tHxvS8nFxNeICRg2d2vb+GN4o/YA+SdrzwMlR8Gcgt9mA/JIdlaZ5YyDgeGAhiBBwSvKWnxwu+xExYheZ/pXoGk/1JF4Co1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GSeT/RiDOnyc4Kf0EH8hWMNINckbH6m2paNFyAimytk=;
 b=OS+42Td+rijUapIpbowDzu8iTfBzHjDZ69FU/GTfKhBJEujjVyVhzFYlE3X6s3blld5ZCn79Sj/J+9B3o5jSqo2SOXwfRcAuvExCyqJxqiSKdFx5QDA50jTiPOQR8CogiNzlKu3xjJVCzy70xGXWFLX7MWbuGm3tO9xS/gfuvIxbMqiXGWw+XIJgWSLfVWCT7VvjwRff0xGT9YUDGwi0S9iEkwizw2HUTrel4Da5nZUNemaM0Vo9ggpLn4QMVvdMWqhzLzeWswhRT8ZGtDUOW03t7s6j/raraQxv2nDZ/cb4jO3HGjgMcYlCdr1TAL5WCRqNFGEatfIErCXM7kv9Qw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GSeT/RiDOnyc4Kf0EH8hWMNINckbH6m2paNFyAimytk=;
 b=K7WxpWtPEvDudofOlfvFFwgy1mLv9JzqEMNFcVNp6O/99wjY99ZJwTzfYr7b27HUCVEm32jtTpFoV1pg2ttOs0He91r3pYkOXtD+QqQKgcBHsi806lqO7jAyXZp15p0L24lhDEKtrE3fgeseCMWD83apoGcX0nEpkmhznCUsyKSjTtJ1B1lBOZi54aUeqQF544KS1lGzTJAyh4+rnK+ds3cOAOdCV25admCj8rwqFPiHhH3EH16KoOeEYNlyXa1W6iBsqFO7t2VwP+S5nh0oWvpfunoZ0aRU/mjhtTn9OzfdmnYhfODGZutCdmzjQWEevBTeqzbFIs/lCVq4CYXVxQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by DBAPR04MB7478.eurprd04.prod.outlook.com (2603:10a6:10:1b3::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 06:19:21 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 06:19:21 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com
Subject: [PATCH v6 0/6] DPAA specific changes
Date: Fri, 24 Oct 2025 11:49:00 +0530
Message-Id: <20251024061906.3535470-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251017044848.3269627-1-g.singh@nxp.com>
References: <20251017044848.3269627-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|DBAPR04MB7478:EE_
X-MS-Office365-Filtering-Correlation-Id: e06357b8-b3da-4844-de80-08de12c54560
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|376014|19092799006|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qqiOi7afNq0kEQwic1CsutlmK66868DzGx3msROdai8SHIXyxhASV+jptZVs?=
 =?us-ascii?Q?zMFaHe7shDX9QjntwOGsEDXNCr2YFFNgxNmLqbfAA7u7h7mMGCn5Z+60cFnv?=
 =?us-ascii?Q?nNJIMFm0Act3Ie9+HRJgJ4dQHKElP4RZa4AJQryWa74Zjwh2tCXKEo5fi2kL?=
 =?us-ascii?Q?k3um3Af2kNMGj8DYREQql4JIG8NfSzfdJ3ti4guvWso4pGdoFm7QITpAQ0Bv?=
 =?us-ascii?Q?ckMsMOArujIleXbSexZ0jMXLLYypeTnove82tXroy6MaNqtEWLrXQQW4IBVa?=
 =?us-ascii?Q?Aq4/R5I1dqTE6LbakfdL6SzdCshpUyNvA8VWBHWJO4eGS5Zj4Ii2zAGteLfx?=
 =?us-ascii?Q?XHb8c8o27f2WXTbTac7fmOBjX47pLdU8EYMPx85sxH9EBACRCvIdiQEeKQ0X?=
 =?us-ascii?Q?w7vizwrlhisTj8LxS3eqZDcltDyf2VwZlwq+tOkdxwy0ydTkwYamy+E22akV?=
 =?us-ascii?Q?TviDwbqw+OpgSM8VYGu16A7Avd5zgKxEjNoFfisgFhrdrjAaMBJbORdESwSE?=
 =?us-ascii?Q?HRktf3DCFlXeF/tetjrT0DiIHVNVrmwuGX2QHD92hmrYHVuwLuFkXxv0FoCs?=
 =?us-ascii?Q?klwwn0MNFh5aVKTU+VVQ6Y69+zZjHW6extUq/w7lPoQVXmK7jCd7PIyM7uSI?=
 =?us-ascii?Q?A3//iQmODYyDkn1MM8rlBI0Yhff041yB0eGXQFeQcIOTIAaVVMtwSQWgHGwl?=
 =?us-ascii?Q?uOAolw7gH1vQeclvo3cbtPLODSFTMGIxMDT6W9O5BeqxKNh5P0Oy1zeJdcNf?=
 =?us-ascii?Q?JFSDBsVu1ZF3N6R5Igpz92Wi8GLrVnbbu9w16saolaE0a9Q6vrgA8MsCApw5?=
 =?us-ascii?Q?y5w68GV1aEfSbrbVtZLqGDU6x0QA47v6M8sNCFeNxFooeCSlFmbquAptEvrJ?=
 =?us-ascii?Q?oSbJ+VqztXHQSJ7mHGVgDkTq3W9ETOFm7slycv0wOypimpsFbKHTe+b3bIpt?=
 =?us-ascii?Q?mpVNU7fHb3yA19e0Ah+++yg/uNPNiJjOkwpLmv4pQLhkK45z02NAu5ZQvKnH?=
 =?us-ascii?Q?Sn6i160K5R5mBpfAyGs9NBPa/5stg75PbuxPYppEUBbBiDH46Wk/BYMIo+Jt?=
 =?us-ascii?Q?FlRmjhqnQMtGifYf6bKyb79m9UZRcuzQy89uOr+O6eXSwSkodXiLxknOIX4X?=
 =?us-ascii?Q?3919JUHC+LSSS409b2+ifTWaI2YiHMEFQN6qaB+sO1zmxC9w93yG2qmxglrT?=
 =?us-ascii?Q?yF/g5currcvFOouPf19nzrfWOETO06Gy+1CfqkXvNYutu5UPFH21+9Gg9szB?=
 =?us-ascii?Q?Qm0B/eFviuQMJ0E4w39tb/D8FGZazMFJwYAq3M+zQoivOQoLCeIZOe2bMq9/?=
 =?us-ascii?Q?I0frOmv8qNH/x7xjT2vDnOA0mp4W+hTtCF590IokmiFef4CWDS7NvnfkZCzk?=
 =?us-ascii?Q?jnovOkCf7ijucjleLqBCtGoECMkejK6ipC5LR7PbAvB9Zeh6lyPkKMcstq+n?=
 =?us-ascii?Q?WS/wsOaH7xTIxqQU/dttIszozZ17xIps/B9QxmScLLi9ORujlGG0s8M8l4A0?=
 =?us-ascii?Q?WQmob6edZ5u6OprSXhti7v/DCru+IYu41M8Q?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(376014)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?l1BDES4SV8cm55AEPur1WBPDqWys8x+/nuwd5Jc9kfJNfum9P9oYEdlQAJuG?=
 =?us-ascii?Q?tuzfHU+2JkAjSpHv5T4oZBpHIpHbwqG2qcaxyHqD0qaw1GrV9Lfv3qiRwIzw?=
 =?us-ascii?Q?KC1ef5+lBx0kCT7UH6QR272aojvn5qumWWCYYjeWRUreSL5jnAWnlP6WOWhw?=
 =?us-ascii?Q?P8vsZPZJKRyD8QCtVM+Uv9HBS528FXzYWcbuqyakLTtAaartWPaoqfhp/1L1?=
 =?us-ascii?Q?Qq5B+KCSAMsHELD0WHUBnZiKc4MP5OBHKso0D3j3QoqnlauZ8MSLOtZHm/dm?=
 =?us-ascii?Q?pzB2XQ5ZGf4p+srqX4z6lM/iAXrcvIt7OH0X5ALS+ekePTCB7LX3P3r1HGIa?=
 =?us-ascii?Q?7V/UsJQ0DiQO2Fy5P4YF6AM2KBqkKuW11UruwXIiwfOFDrwydr0tFoJpP98n?=
 =?us-ascii?Q?m1CwIjWEdHLSBKO5okuntXOp6ozur2VXKGecRp85CiT5Nhr+gZ1n4KJtidzX?=
 =?us-ascii?Q?zVDj34VlzTVoafkiOlK94u2hXV7M1CuB9xczTLaxhWG2gqjqoYxgKpBRYCEl?=
 =?us-ascii?Q?ibDDVUq/e1QTUghysdPfkDN4iuZkxkIbqT7hEnc8vW96Dop6qNfLpW/Yrpde?=
 =?us-ascii?Q?HRS1Hoa6D5xFbhyTWhW9d3KLx/fDxAhgItJb+mKw7Ik4TtauQOrUxNrN1kJ5?=
 =?us-ascii?Q?m2JC8SSeE62lyoH5/OiT0/vHYTWrbSfL1qftYXOph6O+1loTL2vYPgCDFp3q?=
 =?us-ascii?Q?lwkfg59MBb9gVnAije4JCrsCtE0zlIPCXuLNHENOHmfuMd570OefFwfbkxiA?=
 =?us-ascii?Q?ay8vpCSAnj4LcgCVRlnszblApj4BSFSfwm4YjQ+3ceEYoslFE/MYXsYbsZgV?=
 =?us-ascii?Q?zbggUIV7PL8nWOfKTKpWoZGt9EDj1g1PWIFz9WKRr5IzjZVrXU2kVhF8dM9+?=
 =?us-ascii?Q?iGBhlpAye8GfB1xMaivthv5DxcF8JmiybLo9Uzo8csnpHTWLkvlmwLVmS0BZ?=
 =?us-ascii?Q?qvSCHqtCJ7P0Z/+VVoPeKiejqzz0f71+Z57IvksVmEbunPQtwiZXE8krVNtg?=
 =?us-ascii?Q?fR6YDGL4LgT4NMyDH691F8ksQ/Y3Y6tsgWhhoE3p7dmLqafxP9yocUB9x+aE?=
 =?us-ascii?Q?LsuoyVqiNbBu3i8Fx2qmKA8EmMBzjR1pEfvI/NF2Zd9+tLs42VW3GjfNpAxU?=
 =?us-ascii?Q?fk+rOM/TeIxMD+xMnD3U1YMbdu8RttGhrLwCCnok2i5Bw0ilSXGVudEeo5Kx?=
 =?us-ascii?Q?44/t2LVqvwH9Fysu5aaF0lkUi9dF7c5UkFFz1mgESOMJqpGF6bhh2/Ru98FQ?=
 =?us-ascii?Q?o5cnFHvxHWf53YVUh1EfIt+y6zan6ydVrRJG1+wFwndJ6KHk9x1MlSbctzIP?=
 =?us-ascii?Q?wY4CIVpRH8aybCPlaymmPH6kkl2ePABLCgtDHgPL8wHryEjcjF67P4zrtDOI?=
 =?us-ascii?Q?KyEAu1yo9W50kp4p1yxamxqdCdZYys1RlKzl2gdNHUBfeewHHiSnvFhMao8U?=
 =?us-ascii?Q?PKxnTf8cpwPyTNALqwdeJ1Qfugf1BqCEvZxaJTkJXnHDnRhyjl4G8DjqyDKz?=
 =?us-ascii?Q?bSj89i9J63oqSI5ih6crUhT0s+MqUFG7sOwnp6ww3YJYby6mnINZy/YCGfYB?=
 =?us-ascii?Q?fSqlVATxVyJBlaI9Xxc=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e06357b8-b3da-4844-de80-08de12c54560
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 06:19:21.7221 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bup1jCl5Eh0IRet8bMOBrYjCVYWtxZnDX0nc/9aiGF57hVRnjpFjV6U6uJirOiho
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7478
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

v2 change log:
 - fix 32 bit compilation

v3 change log:
 - update commit message of coverity fix patch

v4 change log:
 - separated queue shutdown and logging patch into two.

v5 change log:
 - update commit message for FQ shutdown patch

v6 change log:
 - Removed capitalization for support, disable and set.
 - fix typo mistake in a commit message.
 - add standard tag for coverity issue in commit.
 - update commit message for FQ shutdown fix patch.

Gagandeep Singh (2):
  bus/dpaa: fix FQ shutdown to do proper cleanup of frame queues
  bus/dpaa: improve DPAA bus qman logging

Jun Yang (3):
  net/dpaa: support IEEE1588 by timesync API
  bus/dpaa: disable qman Invalid Enqueue State interrupt
  bus/dpaa: set max push RXQ number

Vanshika Shukla (1):
  net/dpaa: fix resource leak coverity issue

 doc/guides/nics/dpaa.rst                  |   3 -
 drivers/bus/dpaa/base/qbman/qman.c        | 459 +++++++++++++---------
 drivers/bus/dpaa/base/qbman/qman_driver.c |  27 +-
 drivers/bus/dpaa/bus_dpaa_driver.h        |   6 +
 drivers/bus/dpaa/dpaa_bus.c               |  51 +++
 drivers/bus/dpaa/include/fsl_qman.h       |   6 +-
 drivers/common/dpaax/dpaax_ptp.h          |  95 +++++
 drivers/net/dpaa/dpaa_ethdev.c            |  69 +---
 drivers/net/dpaa/dpaa_ethdev.h            |  13 +-
 drivers/net/dpaa/dpaa_flow.c              |   6 +-
 drivers/net/dpaa/dpaa_ptp.c               |  50 ++-
 drivers/net/dpaa/dpaa_rxtx.c              |  93 ++---
 drivers/net/dpaa/dpaa_rxtx.h              |   2 +-
 13 files changed, 580 insertions(+), 300 deletions(-)
 create mode 100644 drivers/common/dpaax/dpaax_ptp.h

-- 
2.25.1

