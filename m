Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CBFDCCA471
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 08:05:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 76C5D4066F;
	Mon,  6 Oct 2025 10:04:43 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010015.outbound.protection.outlook.com [52.101.69.15])
 by mails.dpdk.org (Postfix) with ESMTP id 2AD624066F;
 Mon,  6 Oct 2025 10:04:41 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/m6cv/sweZc1iQy6kkn6HHe9iPhg9RSXRT/9sfc3XuirdvvYRqTLNqwUlrT63r5ltVUJL4wQGRb33rzGw3SFEtSUoXqc5qD8fPAeOvnRWT//SwtyfRtgKBwor44DTAlRqSnEBK9rxlooPwnTkp7eBJisyH4DyDRoqbgbgcxB2YZ067arGe7nWApmrFOhvpIjOe2gmiay/FZcwHobvUOO9Jd1B+/BuJtchdR8qrEDRaXFDNmjvtgeABco3BvvuQBMo/6Ql7ZA2Wg851CqyUmomBQ6TXn21uco5I81GFBXmpg+v6RMf0iAduNaCo+rBnjP+pM6hF62ecfPva72sgi4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1cjYjDSXumZc8EsfXWztoCnP9IxMcF+CiYVLH9bWIgg=;
 b=mMUoZSshSJlpDmP9ggN332wxMq3jC0U1ZRG2SBAPz8WLWbM7/DhJB5NfYzBjLxioT8L67EzfBTNJJpfd9jKPtrG/T1UMQ8GUx6POWuw6FOZGYYQ/e7id492BvP2sbDesjo5iPIwNAZ15mstZRsodWzLTr+9mV4TlQyBlRvPjPwYajbFub5r88iidUAhlocxkF1eXxOCtCmUP9UhqdmbtD4oHDrNQfEU+qtkEzP0o9WKe5GF6SgL3m6XGlin78QLDdQVifYw0AeuhnLs8rtWzRZKj9/Wg+RgVrGJDWZgL5NwnK6AyHjDfeGjNNZ26I8flzaUlPoyKfqpfPdrziGEETQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1cjYjDSXumZc8EsfXWztoCnP9IxMcF+CiYVLH9bWIgg=;
 b=doqMhHty1fSXN7olMaKKeJCZ4X7Hzj6Vre2X8NgrKSNj5KR+ojVOicpMxx2H8Up4xPEzrOpe036e2ToXFECUiN7TXKYaNRmbZqiBhMkk7K3ctxr1NQd/6Xk4mYPalLSDxhUo0UQ1FXOk2TPGCTJaEpYIPW5sFapGwyuKMhBJb6WIpTd8l3dOCXer0K6boSNPr44aRmiBbWg/wkAk/fHM+OGgFFrXyf3rGkoJEf4+ImEsv5ZTfL6eTgoi3tmXYLpMU54cfnYW/uaXRbIEUzUia4R57hKhgZFF8ubARciTbR3zHomhJnnnauvJiTtRTDxPvJkhreCWzL532Q2eI32b0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by AM8PR04MB7842.eurprd04.prod.outlook.com (2603:10a6:20b:245::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 08:04:36 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 08:04:36 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org,
	stephen@networkplumber.org,
	david.marchand@redhat.com
Cc: stable@dpdk.org
Subject: [PATCH 04/11] net/enetfec: fix incorrect Tx queue free logic
Date: Mon,  6 Oct 2025 13:34:03 +0530
Message-Id: <20251006080410.1433284-5-hemant.agrawal@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 97894383-8ad3-4412-130a-08de04aefda5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Awf9EK7qZamNtqtuXN7cxMGr9aDqR6KlRhyTToIMFD5iFcCkAdd9pvfo67Ow?=
 =?us-ascii?Q?hXqnnufCB10ueJr0tVLrJsvJOTQ5vlK8tMT4biJaBo9roYvvYmDUcmrwe0Gb?=
 =?us-ascii?Q?GXNBFU+a1xxAVqD6jOT//SrMxe1c3HS+V7x3128uw4gBnA9tWQyQSv5p9o91?=
 =?us-ascii?Q?PWQgjRAj872Z+IkdNw789MZ6+O7i0+NXNS4wwGPl5WUoQzoYOXcqCBJpVc6D?=
 =?us-ascii?Q?r/BXW7rylL0kBe0FVAnC2ozpGC7tSoMdMXWv13TW+wPMI1GtJCSl5KK7gL6g?=
 =?us-ascii?Q?2n2X47WsIIsOpgNvcZtd6Hrl90+02HFeYtaXXbwWLXmB33TWT/xaD+Quqlbd?=
 =?us-ascii?Q?3r79ocSe2ua+DxNEAM3MIeZuhHKJhV+GBgBs2ZJVmBMN4DzWaqebq9ZBcwWJ?=
 =?us-ascii?Q?mLiuKlh7eTJoGHHhdDvYpBmZLvLmZBRRQDsYycON2wLzEG386bSb0QndDAJf?=
 =?us-ascii?Q?a7sJ4y+uthn6efAEEkRndOPQr5YuT9ssL8HF16LkihO3mQbtXbK6XaGCOL5z?=
 =?us-ascii?Q?KAl8katm1/Lsj+bL4nSeYmoXFgaTMl+Rn5rUy6XhsnsbXtiJyMULj4UOcNCh?=
 =?us-ascii?Q?tmZpUbm9aaGniS+yb8GFA+9KjfevIkxa/TNkg34l3wxBWE59T+5u1pWvFjif?=
 =?us-ascii?Q?j0NVLiDsc0xw6ed43eVsZQW+QQG5n76MBTRjQLgA2nM8STdkNB07FDiQZwj7?=
 =?us-ascii?Q?82cEEP+mGXY6vrfgJkPivndPmb1G6gRaVgBbvWUqXDZKxSQwp5YU2dTwzx0f?=
 =?us-ascii?Q?GhWduknkT9ME+Xl++JgF5urc09WvLT5YP+zcpuKILmGqrhisNv7EE+vIVOIb?=
 =?us-ascii?Q?EzR6pEmYjhEvkcnebjrEl7Ly2RPXaJn9JwyGDHHrhoq1EDi4KozZQV/yjFCn?=
 =?us-ascii?Q?UDfayE54utPNkD9WWhJrBjxrYdkKftui5X7cDU9CixlH4RzcCChGY1l+scZJ?=
 =?us-ascii?Q?pgWZNl8RSIramr5xl3vWlGiCEAqInZbbrXdldTh8PjZdkK8rGv8pTUFbJoeh?=
 =?us-ascii?Q?jgPVOOPhAa6u/ORV8CF7aZKAQI6wH8aZZ4lES1ZqbpIpoiS4L/vaMWmY/aeH?=
 =?us-ascii?Q?jbB7tX5EeDebUAaT3LxjJgsPFv1qc9NQ7J10lNlzOxEW19MTQ37vPWoLSPNP?=
 =?us-ascii?Q?0AnHg7qArq8ZutHCpExgurn7nSU8MdNiXWUDH9ZAUkD/A5dgeOq0Y5k9fCuP?=
 =?us-ascii?Q?p6i7w1+F1fJs1DkRAxJX649CxyNdnl25pkgen2UIIflUxGSt0f6I7+huV1+4?=
 =?us-ascii?Q?+iHsJf2EYHZtBoRkr8tYHoN1GgO8+b5oFIatXBFyk23gHhO8aL6CC9/UkvBF?=
 =?us-ascii?Q?HKS87fdTE5p4AzvYXwpYnP1bJxk+YDqccb1/0gBmsMwsAK2CAK2QG4drmKzA?=
 =?us-ascii?Q?yDRDCgxmteFLKvItbCnvTSJAAqJQcek0VkRkJzR6dyQ3+E8KfCvQ5EO0QsnD?=
 =?us-ascii?Q?SBd2Lti8tqeMFvXTgeSUjr8pAS6u3d6/3LtjUSj1tazkmCRzAJ4K52WSh9wZ?=
 =?us-ascii?Q?XlrbCLOllusz5ijgVRBzFYSyaqoAmWm7ud7w?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1GU1p3h+9Rvf3N+v5SbVsPmlxM7EqAoVECO1oWGTt4TfewCg5cnWsqP2KfG5?=
 =?us-ascii?Q?jKoAcb/5qkSDCKgmUYovnMZ9WCdZPVYPEDRZI2RYKX+jAXkEXx+kP8vcYrXG?=
 =?us-ascii?Q?XqfqtN5OsH7XtJDKtYz43MF8cBjJLHhdLf81GMUhxtatMTclmK03PAe7iv8/?=
 =?us-ascii?Q?FcgmSwpgcTSW1HTruL679tKKWd/yc0XV5Ql4LlUL4jhLx2wCk86/ODTbSxMa?=
 =?us-ascii?Q?TQw/Z9DIuiVAakI7Ruz4ywRS0LTll8xEpXoRw59ZnZdiXAg/m/a5HzFempUx?=
 =?us-ascii?Q?DM1taFjK/WT9guXp1n+7t11p8OqCLt6jPgWWUfPXAFuFq4z/eQQ1xoG06Z5P?=
 =?us-ascii?Q?UndRpeQdXJpBEiLPIwUuyjmfVUt7gWxRwjLTrETsCnRoigBXCgNm6qFMNOnI?=
 =?us-ascii?Q?CYKfyUwleLzJEQwWT03teaCWB9bJeuiwI6L2ZFxvfeIe2cmN3Auo6nFovDxr?=
 =?us-ascii?Q?ItlbdbtUc1Jmo1hrw96533sAB6IRk6SSyf28jwBOWYoDpjH480g4mFHO3PNs?=
 =?us-ascii?Q?w13QC4UukIPTu/mvQNj41YePwFujU9lnM1J8v/RbKEIy9E29YEMWJ2COesg0?=
 =?us-ascii?Q?nOk92Cyty+STWqq8TRPMCcfK+n/M2jeNydjNjrJqeGzr1Hk9hfb3NFngn+WJ?=
 =?us-ascii?Q?745jkfUyab1Xs4HMpjI519AmivdCVoUXViLozjO8P+w733ItenwbR2Esmrzt?=
 =?us-ascii?Q?2EgYOGt3kSWvK+d2jeXkbFfZV59HeYSH1KmuXg7ze6ohQ+VzTk6Ljsjmknn0?=
 =?us-ascii?Q?zmUw0NhxzRkHbop3zSX58oB/Ldqnyyu7e/Bzw/V0dpb7iBF+EiNc/n2fVDRN?=
 =?us-ascii?Q?3SQG0/jYTXDTzrHr1mURPGMJT/TrFcDfRccruankq783QWooO27E/tim5Kow?=
 =?us-ascii?Q?d97XJjgYOwxtugr6CmvzVhbEtt1KnSMp7pTto5KV2ScNCoEnlp8QM96BCCOK?=
 =?us-ascii?Q?gtuTX9OD386cPfHPN7sGA42VYMYCr46r3ET4/nubXBX2qqVg0l5CTuUxOz6V?=
 =?us-ascii?Q?M3peNYBx6sTUfnnC5eCmdgujf25eQ4NzJvdMAVOD1J4EcGx5Cb7Oh45C2Uus?=
 =?us-ascii?Q?a/V0CNX1Kyt+uHR+SbdRVUpU7KJCwzILvLpM81Do5X9Y5DqB4BeYvtA0pazz?=
 =?us-ascii?Q?9yz6Ndg8OuTnAzryeS/LqHsyY63kxsHK3RwflF2aEqZ0WZ7jtypv3DnoqMmT?=
 =?us-ascii?Q?iTx/z+JGdMZjKr8Fek3xg1xNi9+T3zw1G3JD780zJiGNeP0KRgHuP2ZfrVFe?=
 =?us-ascii?Q?rzp/fcfdgbApoBK5fshIOY8ra8vXM1DnzaVJK90T6Cne2oiauyEFOJVRKFLy?=
 =?us-ascii?Q?38b7Xv1yKtAYq9R9p3KF4xP5H4DFfORKvlR044xGTSpNBGfqvGUMNNTamJbe?=
 =?us-ascii?Q?de/Jlx94O2s0N+ir90B0Mb13QTNpcUphoe9/MnUkHqo9hECDF6Q+0gQidnE7?=
 =?us-ascii?Q?CH4SIXOBA1yQ+tLHEa8XymHhzF75bkq2oRPqd6/yxlefZddiUfkDOu9XSCcg?=
 =?us-ascii?Q?aPH3n8vlLUYlwl6dqnykv8Xr1besfyNiTFhHJYDpuJUwoqf91ODIwqRDBkmV?=
 =?us-ascii?Q?rrlaW0O3/sUn1Q/pYOI1ne7Lrdq50bOyZHedU+O7?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 97894383-8ad3-4412-130a-08de04aefda5
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 08:04:36.3381 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q2RVkru10tLevszeWzNuYnYMiqtTCnwnJCr8zPjo1jVd7gHwJbClgtfBdel9yewkIUp9UqZ3qVIpWY/nA9Sz5A==
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

The TX queue cleanup mistakenly freed RX queue pointers instead of TX
queue pointers. This patch corrects the loop to free the correct memory.

Fixes: ecae71571b0d ("net/enetfec: support Rx/Tx")
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/enetfec/enet_ethdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/enetfec/enet_ethdev.c b/drivers/net/enetfec/enet_ethdev.c
index f7a45fcd4d..16f36a53f1 100644
--- a/drivers/net/enetfec/enet_ethdev.c
+++ b/drivers/net/enetfec/enet_ethdev.c
@@ -350,7 +350,7 @@ enet_free_queue(struct rte_eth_dev *dev)
 	for (i = 0; i < dev->data->nb_rx_queues; i++)
 		rte_free(fep->rx_queues[i]);
 	for (i = 0; i < dev->data->nb_tx_queues; i++)
-		rte_free(fep->rx_queues[i]);
+		rte_free(fep->tx_queues[i]);
 }
 
 static const unsigned short offset_des_active_rxq[] = {
-- 
2.25.1

