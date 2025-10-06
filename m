Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BFECAC5B8
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 08:04:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0065240609;
	Mon,  6 Oct 2025 10:04:37 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010024.outbound.protection.outlook.com [52.101.69.24])
 by mails.dpdk.org (Postfix) with ESMTP id 537414042E;
 Mon,  6 Oct 2025 10:04:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PTpSduzaehmgKQXFDbOOcrJ4ImfB4LWIaIpKcFsYeki0p793rdH3NZxfL95XTxtade9L2v0bLxqy1cNUCUujiDwnqKs5wj+b+fGbECjmxfo7WwNghR8ZWgOoeBoyUSyKN4DrPlnphzSKtFDrwgFfDXM4zu/pTbFeyeL8A/HSFI5LOcTRpEeyWuhjkYG3FgfTlajep6ohHH1ySQNfHnCW9XRBxkEYJGMhOlhEfBrfzb4qobnFTd0d7GH1B5C81kucG5iqJV0h0QUZ8RIrBtgD7UJxi6CkjCzVmoa8PYxW4hpstDKMD7zXLTF6VJIaxNfNUe732PtxXvwZh5HbouCvKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bqRR9hKabQ1rA91bVhThrc/G+C2u/vvbYTBY7PznHHk=;
 b=BXHzkdxiMCvlpBn06PmvD8kZDnnGA/CPpa+Q60sA2g4kEW9BdXlX4Rj7u1vooVm2VjnL5IynYalRQe/38GhMoTqtoxBvD9Kh4ONshjYsJaN6Q4/UPkSy6Q0kCSDFOF6z6Zp1m81YCbJg7A4z1iREZMZ7iuAmu5YroAkG5Tv5XEaevSolw68QSrDgpDuzenkOm39FXWa6LrQSISLAn3w70CLvZDOVLXIgFOo9cpHkB1SWqyNemac8AX9Y6SaP2tM+PerfiP7AKFA7H+oMYVEK//90KlcpUWq00oE8i6zlehsdYiQ2gbHeDJHV7AwoLTx3eLGq8y3UEgpsTP4OWdifNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bqRR9hKabQ1rA91bVhThrc/G+C2u/vvbYTBY7PznHHk=;
 b=HWpvuDlpq+luM4r7UzcE0t2RghibSCm61Nf6APzuv+KFrU8G6wSVCKThmmZnXDW+1/P6dkdJwfibBPmOiQc8vvfLByQGg7DiPmxRpAEaQnZfO8ZwDqVUxcZUq1Z7jf6i1RdH+IJQVMD6XikSgkiVZZIIjxhunQwnThxxgJk7JhNLESCEKuADkPSJH4AVh+FL86eBnsMYty/DWUqg3zN4tWGoL3sSf0yvFMz3V9keV30ODujv530XFe3nQH1RUYoIrmXqpj41fg08gE/sRptDR8TiyvPH7Qkd3VRCFF62KgLcOAlHvTmZ7va3W46cZe1kn3jlz8T5JY76xizZhdGEPg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by AM8PR04MB7842.eurprd04.prod.outlook.com (2603:10a6:20b:245::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 08:04:30 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 08:04:30 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org,
	stephen@networkplumber.org,
	david.marchand@redhat.com
Cc: stable@dpdk.org
Subject: [PATCH 01/11] net/enetfec: fix file descriptor leak on read error
Date: Mon,  6 Oct 2025 13:34:00 +0530
Message-Id: <20251006080410.1433284-2-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251006080410.1433284-1-hemant.agrawal@nxp.com>
References: <20251006080410.1433284-1-hemant.agrawal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|AM8PR04MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: c9fea4c6-ff8b-4b53-d60e-08de04aefa08
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?bfbUMkiRvgofBstP/IGqwvtS/QalvyZZBrGPx1VFzA9YKhaaAgGzHlmMuqxj?=
 =?us-ascii?Q?jrpKuGyhs9o48n+ko2em7XIgp8kU1t6hH5TIv5+qi1rr2uoPLXRnFhdAsHRf?=
 =?us-ascii?Q?GN7OK1qzw3u0pDH5YoJcAESG/UmSGvQ2Qe65t0Y+fuHt/NBdcVZ8sUtlVDpk?=
 =?us-ascii?Q?02HSTaYkccVqjJBjmP6PbE2zZKN2GyBdiSHIedZ2/2bO0gn0wpKvUQoYwWdn?=
 =?us-ascii?Q?hLxkvTXYRqPe5np0njG0YkbsT0UDtivBTOC3Nd4U424x25VqO6cTtCtOWRGy?=
 =?us-ascii?Q?xZmULFYDB3ys4Z6Du8qHifXr85cnZGV2/xQlAaTouzUGO212LHLuvhoZxQzr?=
 =?us-ascii?Q?BP8wAOzD1tE+I13MSfkxRva8H59BcpYZEgfCpIHz3B5UefQmDcm3TVaMiFZp?=
 =?us-ascii?Q?AXvaWISVVdosi8SN90KiMcwJ+GeoGI9u8kLT6pUumBKNzGBv6I5Vgnk33tit?=
 =?us-ascii?Q?l8U96fzzOvuFM3CdntCrhaauwVFcz1SJRKQKOXqVwzHLzLliKKpXdWOmWJqC?=
 =?us-ascii?Q?sdjPYs9ogLjKxIlkmylLnMjLpf4VLUsq3qw+bwhTRVjK86iNsBor7oPvJSU6?=
 =?us-ascii?Q?SYKvxS6JG4d30b8Z0hvTdyHiWXbKMuYzJfilr8kNh+aLr/xUPYP7pucU5wh3?=
 =?us-ascii?Q?SMFODmCknqFv7Xl48WaQs+c5B288WRuUKiQjzOJMMw4aIkXQMEKJWcVCi4YY?=
 =?us-ascii?Q?7oSJSEMcesQu0KMMgTp4aahTxNVhSweg6FvL0V7HDfXJKzRzMptT/4axCTx+?=
 =?us-ascii?Q?byIu9cfK/Is+DZcPxAdv8Mb93A8UevboCIBKiK4xVcWY8l029vrSMUfWyYmq?=
 =?us-ascii?Q?GnDyTUL3LrYNSaDMV5H5f7UxSo8UhCjyjZ6MX6AsQiNMKbXFima4CZyosDkW?=
 =?us-ascii?Q?KmmUgg4P8Q7OmvXYetJD7yLLyLOaqbr/h2y8RFclcf12pk1vROFVbgkIgjnA?=
 =?us-ascii?Q?BixI3gHKWXHiNTnZj/Xnj7DzdAb7zo99shHoVDWgUEWuj/GpdmZyMddsJB5W?=
 =?us-ascii?Q?e7eOkL7GMv51f72WlIEfCzVjRksSl8xOEq5ESh8dTQJyUa5NVK0ddq74ovYH?=
 =?us-ascii?Q?psQh3ZXOaLcBL7Fknt8GpZ3xTZ0aewMQsjeE0zpmmkMDf+IaB8umX0oeLuoh?=
 =?us-ascii?Q?gP1DYggZ53DUG1brpjjBefw4amdaxr7M5wTeeLkc+DDDcO9blSzIGUJS+RHl?=
 =?us-ascii?Q?TrIE95Wx0VNX9qTWbLFbiZ0sg18Y7HQ8Sp1SDqDJZQwMP9aoAKp+aZ6IiQNi?=
 =?us-ascii?Q?0kOg6M8b0XXKLJZXrkQbS7kf22cOzS+QXYp9eQbhgiQxI3t9cx+fn+alIj/G?=
 =?us-ascii?Q?cTr69skR9B5y76NLLJGrj0ppATz6WKAh6jLgqx2l/LF3HZ2BzkAnNC1Tahrg?=
 =?us-ascii?Q?SK6k9/xa9mkIbxxzj99sUZEKBMKu7E2lOH3cUBNe0rB7zX4fbG6Pnl65CGx7?=
 =?us-ascii?Q?HE0++qpIcFZpoWglb1Pl5rZYQZzJ/heM2pczZFoJ3XAfQiHdoN5mJ8kl2Q5k?=
 =?us-ascii?Q?+vsnUHhkvxcfJLMArj0NtZUMPzgfKe31ntRL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Oh36b/9fZUJXQ3xRMah/S4iuIsqztn05S50WrlAimzm2eCglbcXC3OIXG8Jr?=
 =?us-ascii?Q?cJg8gIfaQP47pNR5pbq+ogIHnDvGjiL3OeMWKNJaQiq3MEUUAlCAkWm+vQ9e?=
 =?us-ascii?Q?Uej3GhJM7GFJ/eVaQYQKfNvakMwGF9DChJpMmiHMiIzkJ11ot0UvkhiQFKp+?=
 =?us-ascii?Q?hPSKxo64R4iESAyTQ4kjPnBPs2h2umoyq58+BA5kR6t4tV9aSquyO9dJrS5a?=
 =?us-ascii?Q?5EB0T1gW/IeytPHpx+5tOTEfb4dhrDE+ik9wXnDBA4HUpmnHvrRbWZriroEv?=
 =?us-ascii?Q?Sk1/A0zuEUrXI0AOfgXousKkplGk6JSOW3OU4GbZN0xJ9rpDzdXASEseYJF2?=
 =?us-ascii?Q?6jxy4H9qJah7uzd73LyBYUbmPzNSCuofjKTdBnF2wREHOt3oTpL6E9ZhFjwD?=
 =?us-ascii?Q?LXziB5GGzxGEBtomHGxhfJ8m2/J4nI0d1BaZePwEH/O4GrAwMtPiqe3srnkY?=
 =?us-ascii?Q?Woyw1rYiPhjXMmdUiSXajrygxjI9TMT5L2iHTUCcm3udIKvoh5o8OR+Qg+91?=
 =?us-ascii?Q?KbkFtESMsLMroGUNEVB5tqlpm+hXgFWqtMDozGfWPjQWXS8S38oLlhSrhYfg?=
 =?us-ascii?Q?mIrbS6l6eJ/WC1nO8ff7/Nwws1M9YR4TXXIVrnOzLMEZK9lPetk5FKnh1YjI?=
 =?us-ascii?Q?mbsA3i3eAmaEizEvrGxDgOdKe7Q+izcdosJew2Om6HON51HI2y2ocbo8ZMC7?=
 =?us-ascii?Q?ZoAwUeyYjcfMg6verAzJp+4fCg2aMv2A8q9kA74yXjp+/iQZTT20sngY9Tg/?=
 =?us-ascii?Q?B6Dmw5szsoaWo/jn3YQEyNPqzjyt+Q7BYT6sGL5WO2iawCr5LQTSrpg5iMpo?=
 =?us-ascii?Q?5aS+5sAgnlzZIcCG+DC3fTKotdWni1m7BF2An0BHsUIOf0z6cOw1slnNoTK8?=
 =?us-ascii?Q?MVeiiapNXc0M8SwGMDm78S0Ar1chnAQ/FYir9VOixeMNNEeaUPdeESMxBP3n?=
 =?us-ascii?Q?UM9c39bEEsmaCq7rKQ/ZqXNXAaK1bumZ3x0p219ckUzfxn+DeU+6BdfRCQ9F?=
 =?us-ascii?Q?UqXwCpfQVOnamjtq/dg27TOr3eoXhShn895cd7E8iICQLTsgCudKDPXrkYFF?=
 =?us-ascii?Q?DmHkkJ7M1lV4VIzXcwpJ8vN8s4vshVxLLTtcdMcxLrHwEcHrIBPV9Yom9xgB?=
 =?us-ascii?Q?MZZRlRoxZzoVMnZ0dH//yzHich+rcXAc8FdgeHxzvXwyx7Cge7ndMPDbEp6A?=
 =?us-ascii?Q?5aMnL9B+CNHSbe7mxNHZp+AXZMGbt6qSmUxRsFi4fIcmtFw89o7RHG/+1cMw?=
 =?us-ascii?Q?3x373y9fKX8ZS+ogEfIusA+dTAWHkfZuQ64aCZN708lnEPVpY0fLTE0Z7buA?=
 =?us-ascii?Q?jDiwNs4jsC3AYfOJ0CSt+LXK+kIWrV9PPgd1ISzcm6nJ+1cJt4+3zLVuWpca?=
 =?us-ascii?Q?yaqb9xWut3ZZT/0Pozm049LPVE724L29p3hss9sb/eZQ0n/zQmQuJ9fLMJEq?=
 =?us-ascii?Q?/wlYcUCAEMBmLiX4xjR+xendITfa2PUJV4k6srlFfMzWOGM9/1AgA09oWy2k?=
 =?us-ascii?Q?/9tiK1QJgqOClOuPJp71Ht23V7Nto8C/3F5PY7JqtC9f99cNGaAOTDBes2Y6?=
 =?us-ascii?Q?HhxwueYTxYbm4CzEjvOZ+2GEaAKqpwFkvWS27M22?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c9fea4c6-ff8b-4b53-d60e-08de04aefa08
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 08:04:30.3315 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2AiLx8UoNBskODa2Td8/6b6BHKmMBckLW4hY9ybKuCOqtsHlQH5EH/AW09A+XTeTYKbQYGOHCC1xQw9cvywVKQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7842
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

The file descriptor was not closed when a read error occurred while
reading the first line from a UIO device file. This could lead to
resource leakage. The patch ensures the descriptor is closed in
case of read failure.

Fixes: b84fdd39638b ("net/enetfec: support UIO")
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/enetfec/enet_uio.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/enetfec/enet_uio.c b/drivers/net/enetfec/enet_uio.c
index 9f4e896985..23cb4e7e93 100644
--- a/drivers/net/enetfec/enet_uio.c
+++ b/drivers/net/enetfec/enet_uio.c
@@ -1,5 +1,5 @@
 /* SPDX-License-Identifier: BSD-3-Clause
- * Copyright 2021 NXP
+ * Copyright 2021,2024 NXP
  */
 
 #include <stdbool.h>
@@ -66,13 +66,16 @@ file_read_first_line(const char root[], const char subdir[],
 		"%s/%s/%s", root, subdir, filename);
 
 	fd = open(absolute_file_name, O_RDONLY);
-	if (fd <= 0)
+	if (fd < 0) {
 		ENETFEC_PMD_ERR("Error opening file %s", absolute_file_name);
+		return fd;
+	}
 
 	/* read UIO device name from first line in file */
 	ret = read(fd, line, FEC_UIO_MAX_DEVICE_FILE_NAME_LENGTH);
 	if (ret <= 0) {
 		ENETFEC_PMD_ERR("Error reading file %s", absolute_file_name);
+		close(fd);
 		return ret;
 	}
 	close(fd);
-- 
2.25.1

