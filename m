Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03006C61CE7
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 02:55:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B384140661;
	Mon,  9 Jun 2025 04:55:10 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012041.outbound.protection.outlook.com [52.101.66.41])
 by mails.dpdk.org (Postfix) with ESMTP id 99AF3402BB
 for <dev@dpdk.org>; Mon,  9 Jun 2025 04:55:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cdNhCKuCX+Vgo1/EsVigrJI3r1PEqSz4vg0f98oGoHyaWLb9GHjxZdPX3Nq7ZriYQIo0gZVB2HOWODDGfKZuC4DetxKLmSBb0KB6W+SptxtEHmYSYv7rPUMr/hNe0rqSe6CMOfHGVqkgf0BrGuzEsEolGmA8IP1drzkWPGg0LVL/dk28RL9X2uuL/k1Xm8rdeR00BE6KDO3J+9QyyZOg9Vh2zurdpTZCxAfq63D9Sj+a5Jb6GHmQm+x+2gT73EXq+eRU2RMFkNU4ZsBC/RLuRFfOHglfOOjHz/nY8E+GTZTDJWM8W50YPP/ijICDvCi+fItAo1FTYrY6a3cD16+O9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JTvb+c6/pO5ytkMw84TDdcheb+XiZx7QrKIu8/HhLTs=;
 b=muPwsajoZ95+iTGy4nI1EtPhOdHf62NGvllENU+r1qrF2Zwl9V9NZ4iW6LhE3h490LIQni5F8YZHr2l6sEANeJoqA0GQhundeFnUjibzIlqqcPcNZMhZvwOTNOvivpjHsSO5h1ZJ4a77dZ9HERjBvpReZFatvmrGZly+dVH9u1WNyhlbQNU+/J7SxPLAumkBtclH6vSqlYMct4sze4Njp+C3Erm/9qwuPuKIhS1/RNQqic0Q7VuMOzkG14LtghF5UEggMcvRu8HDznaeXMgRSQagD340vcArUEVFStV6KFRQxvAm2yk86nJW4lQLw7qyIkAZBe3LcBQ9FlZ0BOwfJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JTvb+c6/pO5ytkMw84TDdcheb+XiZx7QrKIu8/HhLTs=;
 b=Iw/JNt9bwcT16tlpS81W1hs+9aqwwwKMLpV3vpksD0t293kaKThFi9ewFYF6aPR5B5sSKx9J7rZog1a41VOS7DUm6Wq8VRzR/8JxDjXt8sog4+AGnXXfL6k16bymM/ZHvb39YKP0nXZ1lBMc+uVry3i0t1nx8DH2p7ZseeaKU9o92jvIpFySyrMX6jU4Lf6wq9enXL3kZgHFQ7TZJP5l2x5Va/YI1cTHCQMoTU7OhX6agnFaQUMyukixA5BvhCe22xidxjmNWS8pr85N4QVpWsNvGWyWx1UgsoFAJge7gQFlicu70SjXMl9EKgJwzwx/vZKPB2pwDjdLmttpmxG2Xw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AS8PR04MB9093.eurprd04.prod.outlook.com (2603:10a6:20b:444::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Mon, 9 Jun
 2025 02:55:07 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 02:55:07 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org
Cc: hemant.agrawal@nxp.com
Subject: [PATCH v3 00/11] NXP DPAA2 driver enhancements and fixes
Date: Mon,  9 Jun 2025 08:24:39 +0530
Message-Id: <20250609025450.3997062-1-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250602104041.3322164-1-g.singh@nxp.com>
References: <20250602104041.3322164-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AS8PR04MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: be1a17fe-d48c-41e9-f152-08dda7010a73
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nEBbkjpMti2DGBYDCO2F8RFmZ99iybhN4nfWVQkTJl2mmn9heCrvCLi6mxzN?=
 =?us-ascii?Q?itqC9OTRQTClKRdz7V/vzKMsFnbB3aeiitZKGpbC459tKe6qVs54fDXPP7sv?=
 =?us-ascii?Q?Ru5a2csL6QJpwj308EJEbsaI7QEskjQvxER/xmHyyEd8TnCqD0xNPgzA2HCO?=
 =?us-ascii?Q?jus8NNSvzwXVhtonBGvcwtcs6CHsNxdpAKSjfjrHgHrSoQ0rEQ97Jxq3pYXE?=
 =?us-ascii?Q?FjQ05xBtmAicd65ENgbUGDq2TJ0kGPTJnJxGwt4mJcuwr6IbVeMlqul2rB9j?=
 =?us-ascii?Q?icSdH1+gIGGCEN8/jS+Pg2pkrh1mBv2WiFXemlWDar/T90CXxc7EcLKAxTR1?=
 =?us-ascii?Q?o0dm3cWZagTqFX2kOPJmzzGozsXgyBOwto6HVCIFMM5dQdHdP1twJ8THFEuD?=
 =?us-ascii?Q?aTWlySeD+pH256n69U0aFCompxlHqs3MYR3+lOpRzchVVBOu+Eio+xCfj+iw?=
 =?us-ascii?Q?BoZSohf+3XOfra/4rSRCmInYKP8waWdhqausEf9BG1HH/ij9NrQQBo4FA/Gt?=
 =?us-ascii?Q?cDBYOz2gbQZbjfB4RNWXcIYOPGajuSvTW6X1gH+MGNtpjUDKjgLy+i6iHXn/?=
 =?us-ascii?Q?+xFCb1xWy+BtQZx7JWCEx8ZIIkhRjT1fkNoFMpOHoRsYZEwVSGHUgYHrHIIf?=
 =?us-ascii?Q?82iEJ8vVhoiJiK0t8jA36dMgdx66EPuNLF0Ogcyb+Yvx9oMi5+c55JG4Jhec?=
 =?us-ascii?Q?4Shm4zyY+OXC+PH+UhOEkwwaLoYxkuaLo1i4wbqXef7eTxcetT5laSyEHpRF?=
 =?us-ascii?Q?m7LT9kK8czvnCZIY/Z75wg4j2b8qzA/Oeie/LSu9ZcAqT8kRHTi2B99uK5Re?=
 =?us-ascii?Q?4Dr5yVPoAGQALYQr4wF/BQXpwysM8cj2cmFeuFNBoW9iCJ+7AMe/8ptw6V2C?=
 =?us-ascii?Q?FG5zvZzfQqlOZicX8pwjEBsuLPWbI23Ytsf4coIdxyQB333Y25x6xCOu193q?=
 =?us-ascii?Q?jAGQP/b1/kNWjZbSb1n51MGQpxT0HIU78XRHkBkb5VYQaWh5QCV/EQgUXPqL?=
 =?us-ascii?Q?mMDEYRVVQJfLsq9Vwwml3uqVernCspqN6Jk4W6m34Fx9pif7/fFZ3Sf/tF5M?=
 =?us-ascii?Q?XBwwVXjim60jvdpMeyfWHPH4glfMQCAcIrhIB/z0bqSgOlwbzNeuxiwK5z6D?=
 =?us-ascii?Q?cH76KzM+FoVCFDRr5xOtqvGpTcNREaaJr8gSOyTXA0SEk6LTdICpElQ6qbpp?=
 =?us-ascii?Q?3afJCOR4Tyvia3i0YZNIFtAjwc7dQGGhxF6OUjSCORNvNUQwGiUPd/cDrWX7?=
 =?us-ascii?Q?SlQVD++1zztfaLRUJ9rG3FJOEnHzAoB2KGDfYMflBgCFuAUwBRfIiS1Nu73f?=
 =?us-ascii?Q?0XzkkH0v3ZULQSKfE1BGafP7RmhKbG3RA6bjdLIrnKNrrxqraZa8NjcAigoh?=
 =?us-ascii?Q?ASB7LkT0YAI8Gc/a2JH7/qkzdZh6PgByf8O2wJA2d5itzGpV1nv8qrnnSVtP?=
 =?us-ascii?Q?RwkwMlo6HLgJpwJIcz71xzb+pN880X3t/Iplq5p5jUADqADm3cCLvPBtJhnL?=
 =?us-ascii?Q?VxhKKO7v4C/LlqE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?HWfOtodzAtkr+6fU1AffGoz5+sPPNt1403XIkRYrd2ZWJp2uZSbxcYCFN7eQ?=
 =?us-ascii?Q?2KPfNVaQI6gfai1Nto95yrLyZt23dfTLo6VPFIehwG4zaKZES1idu88hykXa?=
 =?us-ascii?Q?pkwV59teb9mkSbhfdaF0Z2ppWdjN67QUBM/BTSObsTpgJRObpUnVMS5ct2as?=
 =?us-ascii?Q?IpBtGFSDwXp1zdItfhFvRs3tgViA+0JMaZrjL9MYFVQBiLYyK4cjcXrMvRhB?=
 =?us-ascii?Q?Sw1SQnjCgfS4/K9KqWKXox7K6G5+I6d59lYPyzxOqKUDTnwT4YRHLKuL6FoL?=
 =?us-ascii?Q?IZtmrrenIIXB+jfO9BsUFGqP/eyqw0wZFCK/K/ymPdIudg4wwwqQtt4r7lWv?=
 =?us-ascii?Q?oNllsuczOFkLVhOgpy1MbUyXyCyYd0mX8RMlFCcr2P6RbV0OwnahQleNmSt8?=
 =?us-ascii?Q?XfroxxCrrZpZ00gtvbmLqY2EYVAixf5rEhsKxaDbjqXwZEZhYpp1aNbOrjtB?=
 =?us-ascii?Q?D2JkxN0Gu4JncaOY1w2dlI7nqZWi88+CON0HbaKUmqDInAPoH4Vs12W2Re3u?=
 =?us-ascii?Q?BLy9B8OPgTlPXB1ANkL8uVaTcuQ8/pkSi5O/2Ec2lJfUznxaySt398SDO3XV?=
 =?us-ascii?Q?scn7O4viMU0x0DZw46mLS+V+5OShpqdoLypx9I1k5YoupM9SlmJ8NqbNI2KV?=
 =?us-ascii?Q?dGFFPbKaO8jFfotLVdLhcul8pek6GyG3AfQmywWiNucP/q2rx3GXrhRwpogF?=
 =?us-ascii?Q?gUpDY9H8moV+dh81bycCtHEYq3/cp6RF70t70sTVd4OxRn+bwlrwnggnLzGi?=
 =?us-ascii?Q?75x5Zni3gPvc/RRAxIzhXemsbFXBz5I5xJwOd/BPQDfZnR47mgrqyfAEL80/?=
 =?us-ascii?Q?bVJPqt+kxlbOEMy6WSLvBxWKNKby81ykrU4MEXpR6U84Q+TPqAhztnCmu2pa?=
 =?us-ascii?Q?D3dPPzwYVBopAfXpo2C5vzlWu4A3Ei2gKWLneUE2DxQCJvyOvldj0QZwLUiN?=
 =?us-ascii?Q?oKuKqQJyfpeuHaexLXfIoTzKAZXezkPODcXsWqfplxqYsbxuWpJwsfgmuqsS?=
 =?us-ascii?Q?Ll7UK5BTC/VBNN6ggTi0zO3KnZZVGJBu+5m4P+WOsa7PDwjTNlSEPwuk4lft?=
 =?us-ascii?Q?EuuBpS+G+Hj3SUvP31cLf4Fe4TNOCL7/NeYUS8veVcuLEj6g1nLTm8i6N3u9?=
 =?us-ascii?Q?YvMhzflOC7wM7p07lOhQm3cAveiaVojlaml3G4Qvkf69ICHzyOrnW4NH4xIj?=
 =?us-ascii?Q?wFAIUz4BTmbaQL4Ev8YiGoKS6IB+IH0NcLZQLryY+SDBbw+KzIqwJgKxOjyB?=
 =?us-ascii?Q?I0lB6sm6g4G18vQHuxqE78525vLLZN/AIwZ77/bqud6ESlsmnmmpUbN8ULEW?=
 =?us-ascii?Q?Wef07ezvdGSIOGLOO7ug7uwojOTBNVe3KUU4PPZWZ7EC6l4yBln00f7+lLJ+?=
 =?us-ascii?Q?mUIuTw044O/ScqJ5veMmLB+nl8yHJEq9PqIgjUpPCD/M/4C/fb93X/J4LGai?=
 =?us-ascii?Q?90QgrCfzHn15+j6YwvVDj/Q603G3GANq7MvxMe7c8UmhJcGZKL6vLJNtTy4B?=
 =?us-ascii?Q?QIxg/W0KcA1yMradg+r91H5eESyj/qlS0rD9mcNm6GUKbLicmYlgGUCZ7pCb?=
 =?us-ascii?Q?CI1M7eY2aMC43WPWggs=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be1a17fe-d48c-41e9-f152-08dda7010a73
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 02:55:07.3328 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uURbO/hcZUs7FB7w0tpOi1B3MIkKgaUYqxQNm/QjSi603x+4hy2Ff1cDMAjbSSVS
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9093
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

