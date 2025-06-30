Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A64E2C8302D
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 09:58:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 77BEE4065B;
	Mon, 30 Jun 2025 11:58:24 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013008.outbound.protection.outlook.com [40.107.159.8])
 by mails.dpdk.org (Postfix) with ESMTP id 9607D402F0;
 Mon, 30 Jun 2025 11:58:20 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C7ha0zkeRCW89WCKxDWvelm+A0SDH7LVGtiYDEo/Q0QB3XUYhWFu73DpwU87Xxb9wRQjuNbEQhefr1ZFi2TSpqyHk3HDqog5rTp+GznkxG0TcQetf59Cr1SqVAPBs1PK/D6VqCFpLf3GnCwzN7ZDF2ghUfOJ6clYD4BlomiaWruAHzoBVOe/Re6Uzv4dVYTxJz7vkBGVAvq+VY+b1LzH4RL5e/zUsR/Cz11Qhel2TGjJlAbYZ9+lzY34ar4zSzRQDceeAO6G4fOpQCOnMbpJnPL3Giztluot0XJ29DDp6sHlsH5NIkzb9ct3dULHMFeKgLkwxp4eVeIpD3trqNkX0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RVHq0TNIaGRq5TS3Hr28WJnHZgl9Sa9uOIZQWoEGCMc=;
 b=I1z8HIoM2qCAORSyPaANYWKbmiCJ7QOQt2zd7ClygruAjNNOYk9juCXlN9aOypnd/jEp8UBrY3b85FzK7c0i4sxqfhp6Cn94L6/z/3vcDfJGMIcyQCkH3jdqnlk9Dsai1cMy9ZXIbKSQLTbzHw4RVM4gwhRE7KuFcuSJkR/vwDV3xrRbJviev0lmsIIJALcJnB417kOEvdkytLtVKiwYNy7Pn5EENnV/x7u7Bzm4AAS9YdG3VdVAitGxjo4k5UQ/vLzICS0SPcL9WdDGvdlOncFPsR8ZJmxhJ7Z9E7YRDdeFeKUOZly1fpGe72Lue6h/49rfav7nCLS8XvCP6NzW9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RVHq0TNIaGRq5TS3Hr28WJnHZgl9Sa9uOIZQWoEGCMc=;
 b=FBCIosS+3b/a9Q2npYUeaH6y0kWeDKImHvQza63j8tqMxD3O817OSXLzFxD+QhzkSJVhPmYGL+oTAokBD2srLT5YBFgs973eguR2XY++/oR6aaFcAQnCwBDn3bIcjs3RAQWzqa6GwMiKF+P/cwiNRtURc+gqXuooQb2ueQvuniNHUSdj81oKo/YF/O33wi4AxBl6kUTUAgU8jYM+h0Bjn5Z0OfEVWfWbqok9pJkxS5HCsxeuZuVZJuM/op2wfgzFR7aA90cIGtHRaInVEnVjmdpBbGAnjuvYtz0GHUgOLIfHWAZKSBRVrKPN1RTZu0Qb4loJNNTZncpMzLDIOZhRlw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AS8PR04MB7894.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 30 Jun
 2025 09:58:19 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8880.029; Mon, 30 Jun 2025
 09:58:19 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: stable@dpdk.org
Subject: [PATCH v6 2/6] net/dpaa2: fix shaper rate
Date: Mon, 30 Jun 2025 15:27:56 +0530
Message-Id: <20250630095800.2943863-3-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250630095800.2943863-1-g.singh@nxp.com>
References: <20250613021125.790614-1-g.singh@nxp.com>
 <20250630095800.2943863-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::34) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AS8PR04MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: 9e4d1d45-2897-42e8-bf71-08ddb7bca433
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?OI+G46F/Bn0YQW7Vu/7b54XfXSPfYO1DMWOxcS1/5Jb4eGR1eXcxsewV/67A?=
 =?us-ascii?Q?FMK1Z42JmG5M2l/krU2R4U2rI9Sxcgv5T5SCnUXXt+pD+f+SeuOIpaAlffDM?=
 =?us-ascii?Q?juSOnaVvDRzT+NJo+QOPpCfuB3LgiTfwAtzb54G+n5j0r/LPh7H5hLsh/6Be?=
 =?us-ascii?Q?3A07TTi1PQOwuyGXh+rXQUvVfxVkw5amsMfUXvUUWYBCgA+XCW3yfvgbzfp2?=
 =?us-ascii?Q?LS3pUevsJwR61Yme910f7WSs76vLFk3YyvSf5+W90GV9ryQZvjLkmocJ28sq?=
 =?us-ascii?Q?mUfd6rXMiffjvv274+iRRNkspFM8XBwc5vmKLuF885q3bhemJlzlHBcAco02?=
 =?us-ascii?Q?iKk+h1/Kbfl6dUoeajL5ArZHnzenjSCpHEBzy2H2kqn5vDFaJXFlm6JSkLGE?=
 =?us-ascii?Q?UiQDokm+wdAujsncFgOAcXUQq//bqTf3p91nfooeZQjVoG1WPEzdyFunDa9U?=
 =?us-ascii?Q?SoW1HadqKkqYt5MGdMY30PeOEfy0rwdbuy9+qe2Evs+E4QT11fYb8p8WWynx?=
 =?us-ascii?Q?f1A6as0fkE5FDVnLAgbTfNGTLkNRKJhtIzGlV0JxxavhmyaZ4SSsRV9QV+HK?=
 =?us-ascii?Q?/izc0mSP5HjSRrXXdp5wydukm3QtLHG50rvI11vSIKbRd7IJ3clf5NOdRYlk?=
 =?us-ascii?Q?j6nlRcEU9PgqdgNW4IUa8GWAtBqUUhjjagWQk2/XMIKbHb9K1XSuaQ71cxn6?=
 =?us-ascii?Q?k/FBJuU+kp1bPBjDt1Vmc0/VchgwNQIfKSxjfYPF8KojkEO2jsU4hjzgA2xZ?=
 =?us-ascii?Q?wjg+MkAXYsh+XNWDJkFDldQ9SlmH8bbVYjyQ81QUdJzbNXE/CQ7SnDqqbGhO?=
 =?us-ascii?Q?L8peKhBZEr5IWIcVMDgb3uLPu4eeqLM5MroS2hIiPSvM7AurCYCydn0c74e7?=
 =?us-ascii?Q?kWvCazFnUXxsa2y3muigRxZlDeoTYUN9iH0a1JB4/XCybpoxWgfHJFelWyPT?=
 =?us-ascii?Q?IrPtE02tHxawnAeRUYiE6aqNjZX7DwbxtSraa1IJLIng6Ye1sha1ryTQKr2p?=
 =?us-ascii?Q?zJb6QmjgleFe+zrHtas+yUdWrbAn5jAz/Ybg5BR6HfItdqieJkS8fGwX7JUe?=
 =?us-ascii?Q?aoUav/F13j7rrqTVrmSEWThedFxSLn5YP+gl0YTRzU7R1iqYiknxtwHPPzol?=
 =?us-ascii?Q?EqwT5BT11MxyxTEUbDUSiwomPuwPVcLN7yOVphkNCpcdz9qnPQEn+ooAs6qT?=
 =?us-ascii?Q?ktDHN1gNy42lxdEFlRP0Wi13cZj/r8tK45Z5dSB4jXXasHQv6pEZA1D05m+V?=
 =?us-ascii?Q?Y//L0TVRIgrZDaZC9bqvTBzxZwiIdGsacrpRPKlECt8wCS5CNWcZaQaPJWsQ?=
 =?us-ascii?Q?A36vEnqiv29295wLzQ/iwhS1IjW8rBZcKPupVzWMjKOl0zpj9X/CxkL7SYXR?=
 =?us-ascii?Q?vhK5U3AVeE0nDoh3bwqXatU6fy1pBEtRdC8TwxUOhCVl7fGvPzuFh+68oJG1?=
 =?us-ascii?Q?gYiw3nMcyST2LGeje0vaWlCnphT7vV3stNVV4zFnXNfgv74NKv+yLfczLGs9?=
 =?us-ascii?Q?sDNDNHLBN38WpvY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?IsNc4rkAlUGyv0n/dtzNHLZSH9YxDvoMpu9euuB4tkO1SFpwap8W3mJ/j7i9?=
 =?us-ascii?Q?Mn6UwICnSU41s29qIOEKrg9o8e5/kH0QzAceScXf26e6oc8QawtmTvCIf4kl?=
 =?us-ascii?Q?UoSk2htjCZE+YU7KRq49+PdO2CbGMphRmtucur2W3vFJb6GnKQkU0PyclEIU?=
 =?us-ascii?Q?2qe3nrE4hV5u+ODdGQ2QanWXg490AmP0Wlp+fdFlRBKn+YSNK6guNS5QHlHA?=
 =?us-ascii?Q?jt/j5eJwqj5sXXm/alP2/Dca7+Vup2Mcbdx79ATgot+MvTSODE0Zrarmh/C4?=
 =?us-ascii?Q?ggpeD6p4KJ/b+LrGVFoJK0hCQ++Q00JEjHwzQTGv10Dev62OnmUAoxLjBPBR?=
 =?us-ascii?Q?MdrqyredR76RmLk1vmI+1lcbTCZpeKm/bUMz3Vh4JFt0SM1gCxCaWQpdGgjq?=
 =?us-ascii?Q?XVDZKsJHCEnFUWGlCvcjaXbA+w7MqHFkHP3Efuaq5F10xoj7hPbcYD56WQWQ?=
 =?us-ascii?Q?MWOLsF0mjMumyewjVqWlWukwEnlmX4aJZYjPjjnyKFJSH9Gzc1JpQVUda9+k?=
 =?us-ascii?Q?gH06MfMfpo5VDBypNq1399zuLNGOctyF0Evwntz72jijlCdQ9Uakw/j0LJKS?=
 =?us-ascii?Q?d4qvgTbQ+Eh7/PRFmnNus19+KO0Jgmj+g8TXgNsgloNHpX2MyrggviPwuH/7?=
 =?us-ascii?Q?ka31dKHa0OcpP/Zrr8y97bmG7kQqePwUIFIO5Nv6C9Dvy7fDgk1Dhf2GTqP5?=
 =?us-ascii?Q?LnafMGCx4uYlE2hlZZ3L7lVDe5gTjY6ot+S34szeC7gXqfi2zyv9et2wFZJ4?=
 =?us-ascii?Q?TrTIU5BRBOvzsna0ab9jrpBZ4i9hhod4eF2z38H/sOROK7YmsgZkjGg/5x3W?=
 =?us-ascii?Q?TFCMoGDbY6WGLNtL31q1NjjthXjN5EVehCMHDfEMaJHOmz6jkEzb017iqVBe?=
 =?us-ascii?Q?fwJMbNZ1DLfOeCTo8hFKrEJlLGuz83jFY1TrqbFyBL5oV5gJnmnKjqSwsYvQ?=
 =?us-ascii?Q?fZa6W2dPPv82NCVxZ+GyJqbLlrRP1AzrBi+77SSIPwxLEzznnOfuughX0JtT?=
 =?us-ascii?Q?gz4dqh21YJzU/TBj/1/KfgAP+JHaEL2+vQrUqPG/edjeXKnDJdW/AtlxArll?=
 =?us-ascii?Q?fl8bs+9/sgfB/7qz1eXJEy61KnUDvuog2eguQgcdtk4pjKXzN/dK5AjDAs0G?=
 =?us-ascii?Q?ApuKyj0WEnu3zDnehNap77eWIG6DI50BRNxPJNFM4LDeEoDIo/+SJCmcvCFG?=
 =?us-ascii?Q?yhcp17wAX473w9Vuxm4smrgl7RppClx9iPP2iNaWh6xRFtrurVB6C0phCCDw?=
 =?us-ascii?Q?YIEoXrPS4AzXED8M+A7d9PcsmlM4SAmCJWJLnOcc+OXYIK1oeQuA4UfGFvSy?=
 =?us-ascii?Q?mIJ9Y3a8NhrEm8hdoaEKLcjVxpU+JsHuU2/760hGau7i7f3StqTVHNoU8OHm?=
 =?us-ascii?Q?0ErReVHn46ywFyxsD+SBGrvimuzecey0JrOVgbVMdIHCQkhIIlxUtP+mnb7R?=
 =?us-ascii?Q?MGILTVA5iCr9S2AqzATHya//A0T+kcxb0DcJjt4//9xOGnmypPjtMi9rkEB6?=
 =?us-ascii?Q?tjMgJU62m2GXs3efx/p07h0YiuvaSK8n1EfBaMsufMAS7VGU7xljg0mR3X0A?=
 =?us-ascii?Q?9FNLhEuOKaH0C+M4ezo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9e4d1d45-2897-42e8-bf71-08ddb7bca433
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 09:58:19.6626 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OhFkdhI+y+GksxxqQpjadVcDkV2ZZCOtahzc/1L2EzuYbVgb1wP68bef8hje3nCj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7894
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

This patch fixes the shaper rate by configuring the
user given rate in bytes. Earlier driver was considering
the user given rate value in bits.

Fixes: ac624068ee25 ("net/dpaa2: support traffic management")
Cc: stable@dpdk.org

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/net/dpaa2/dpaa2_tm.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_tm.c b/drivers/net/dpaa2/dpaa2_tm.c
index f91392b092..dbf66c756e 100644
--- a/drivers/net/dpaa2/dpaa2_tm.c
+++ b/drivers/net/dpaa2/dpaa2_tm.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2020-2023 NXP
+ * Copyright 2020-2024 NXP
  */
 
 #include <rte_ethdev.h>
@@ -733,12 +733,12 @@ dpaa2_hierarchy_commit(struct rte_eth_dev *dev, int clear_on_fail,
 			tx_cr_shaper.max_burst_size =
 				node->profile->params.committed.size;
 			tx_cr_shaper.rate_limit =
-				node->profile->params.committed.rate /
-				(1024 * 1024);
+				(node->profile->params.committed.rate /
+				(1024 * 1024)) * 8;
 			tx_er_shaper.max_burst_size =
 				node->profile->params.peak.size;
 			tx_er_shaper.rate_limit =
-				node->profile->params.peak.rate / (1024 * 1024);
+				(node->profile->params.peak.rate / (1024 * 1024)) * 8;
 			/* root node */
 			if (node->parent == NULL) {
 				DPAA2_PMD_DEBUG("LNI S.rate = %u, burst =%u",
-- 
2.25.1

