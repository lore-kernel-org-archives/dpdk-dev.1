Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02C9FCAC5B8
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 08:04:58 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0B4E140668;
	Mon,  6 Oct 2025 10:04:42 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010023.outbound.protection.outlook.com [52.101.69.23])
 by mails.dpdk.org (Postfix) with ESMTP id 750174066F;
 Mon,  6 Oct 2025 10:04:40 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VFYwh+fIXxos+yCDBbHdEBs2ix6VsvOZ8o55jls2yY51KuORuDgRAEqagiLszkHJzKdqCOXg49KQjQFJ44Ym+yd/7Q3beKdzB3PW9DeALofAo1AkORZgqZKKJA0HrJQ8GEG35TeJgdwkm4I1PlgB0NRzRb2GlxRTJ7tRAO4ufic2hX2fn0v2k255nCZBPx3UTSc9rUJhGROnw1aWcAJyn7ei2+MBm43jpAcbrk/HiJt8tr15v/1HtWjwMyBYTaLsJzcNq3+feQfThFep4Zz/MjDprOMH68nMjOve76QvBMDzgBqYl2EupxoFSqHXaujCr25+C0dBVCkO1Q1OqYWrkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GrWll8jO9OBJn1OQp2Z9erH/iUs7Pwv6Z27v3k2e8Qc=;
 b=SBh8YurkxYDifolBeO/aWzbY2QF91PJ1nwQotzjFl4MReP7C0lCthuZnad+5exGlqnXZEqyz1spytT+8UMlA5dA65w7VdZAxMjbyfcLHg49R6AqvxO6N6vYut7ibkSAknbRQjGp1O7Zv0Ky3rsRxekWqI8U+i9VAEMJFAPStDsfDUgZwdEaNvzJ+9lveBSb9wwaecJdajot1PJFsEMlfc+LPUYK52QfSHmG/nEJxHZ2Bv16r248zGsjsxmtStsvFhyrCYKEwrULUjyjirNH12ul9iXsrYbVyxD53oeKZvjeVp8Hb9CF96q8zUq/EzhpIN7JU4K02dplr4BzWkJ45Kw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GrWll8jO9OBJn1OQp2Z9erH/iUs7Pwv6Z27v3k2e8Qc=;
 b=ZLkgaZmvbtWJw0R3c4vCPSBbAKZaL2o6EoO9tyPclp2ZLOx6zGJHPyk0s/T7aonqfEk/iwf190+0e8LZhd3jFuR32N7uIE73LulQjJKW2GdFxhKJEZBDRAP4iuJWtOMbe+M36uGMPF6i9/e0be8GVHzi0zBYG1xurm5YWL5NHtMB0/+Xcl1pxukzj/DQ4sk8bRl4ZjcRFRGKNSm8XM85g2IDGy3A/TSI4iCFTMPuBeOd0PPJTdw3AcRZ0l/tbVv0bkP4tgiJ/QRH+Fy13qInLRrgHFIDjUfkjI4ELeH/zGavb6BHivJqT0P69VbxlbG5ngMLTaapQ100XT79ljGvGg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by AM8PR04MB7842.eurprd04.prod.outlook.com (2603:10a6:20b:245::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 08:04:34 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 08:04:34 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org,
	stephen@networkplumber.org,
	david.marchand@redhat.com
Cc: stable@dpdk.org
Subject: [PATCH 03/11] net/enetfec: fix buffer descriptor size configuration
Date: Mon,  6 Oct 2025 13:34:02 +0530
Message-Id: <20251006080410.1433284-4-hemant.agrawal@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: ce31d25e-21c1-4a05-c34d-08de04aefc76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?efXaUQTNcE1cUfsjlBHnb5z7DynxqctM7+kSPO4finEvuMbYGxU6tvgefPlx?=
 =?us-ascii?Q?Aa6HqG+wRQa3lDxZHYL7crD6J4t/p54DHG7lmxSbGwipkje6faM/KcON4OUQ?=
 =?us-ascii?Q?CoHOHfPD2mEi3cBZa90TaFoa4AhxbShL6fO7a9oCfCFMqi3WQZKbhfgtiphv?=
 =?us-ascii?Q?k6LvUZ4UQkue0Zlfck9nJxFTKbg37ExzyBdWGgyUZo8HoC4Yi8Bnrdi2soCU?=
 =?us-ascii?Q?yThlW4lzwzmzgvn3e3t38fVLSX3nP0alJmdkbONforUQDI6vJMO815rTvysz?=
 =?us-ascii?Q?uWNU05bfhWEJ/31w9T+Low1GivrUN0+0I702rrm9/bJ3ht2GYtM6R07I+Z00?=
 =?us-ascii?Q?jm2Mm07Nl1MiI6hr3pNZKFMdr7q4qocJftFbI6X5k8NLpB+6HzzchPZe+dJo?=
 =?us-ascii?Q?JMjollOOKnhHq2kXn/pETrm15yQxqwB/KSu/aD6hv6c8FjGNuRmxWn2zdvuA?=
 =?us-ascii?Q?i54p0fMnXPOYxN7+pog7uCbQTtwUA0pxBax/5nKc7Fac7vHh0x7OadZatg18?=
 =?us-ascii?Q?aJsX0zKJ2zsvBk1zcV3CMPoft5ECKU4jSojTTkT9GvlJKxg7mBWI1LRS9FSW?=
 =?us-ascii?Q?gUDn3PSu/1YBp/ljG8iau1WgF+NoIiVbEQGI3g+QAOtKBC8ghLyXA7OvceHu?=
 =?us-ascii?Q?PiOiWfX5wCmm9LRT6QgPaJQNSpI/oNSP3HZDX+aJVy2quQQ4ThTD3dpI4dcS?=
 =?us-ascii?Q?yt73SAfKsC1YbxrrvVIthS7sbCOpncg4nLEKbpB5dd5qGbQ21XQfglSyYh4s?=
 =?us-ascii?Q?pNMiy7QD0yMk0UQ9M7LJPpx8NckVMCB4DCrn7M2icVURuBYl7obD+UG4vesN?=
 =?us-ascii?Q?bRB4uJFwHZXWvfY7kXnz233VXE36zYaPtBuur+rx84iXuonFdHrzeMZfeI0P?=
 =?us-ascii?Q?Yvy5CmA6gPQZmzAscYg7dK4OotI2n7E8VkKnx4OFwKLWzwk2NHzceGuZfr+d?=
 =?us-ascii?Q?mac8jNwxhIaG+QRAOb2CxytdoudRXufVhftRIrxTL5+2Tin/JIksufO+emag?=
 =?us-ascii?Q?66kjwX6huzxA55q/cyHDPw038Kfls6mUApPBFijrYmWWUBt0//FpCjrQSnOO?=
 =?us-ascii?Q?sdMtNMwAm3sYWhyzHNBBYzCAldhpwIwIjzP0ftxY5Pu42XWlg4tQnXLkf9Ni?=
 =?us-ascii?Q?ohFpC2xY+20Fo2NtTf2GjcptJ2t06GFG2samTiNGePaJa3E0KrrH/miSwD7m?=
 =?us-ascii?Q?Tiq1cXslkG8ZAcuJToQr/aobPm302XdP4BpMVAr+r/VTfYIxbs7G27NO74aY?=
 =?us-ascii?Q?DycjjkD4bDBjXwm/wetPt8VaWqTYRENlwAOOG1CVZ4bc3rv0Hgg5SL1zevGN?=
 =?us-ascii?Q?F32N+gHHT9K+C4F4A6vqwZnmw00CEQRjUFlu54FLtYB+8KCSxk1u0tVqd+c9?=
 =?us-ascii?Q?IlCYXpdJ5ezB3WCuoucf+w014bRzN2GIF26xvKEq4hRTGj+oWrGo++hiSY0T?=
 =?us-ascii?Q?niOD1o0ee5NtAiojGJU8I/XnxAb1reZyd52+MgkKkiRNUvRv+aDO9HK7RMoI?=
 =?us-ascii?Q?mCyNyfrQVb7OGPp0DpReAMPJA5G/LbsFo5N/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AOhorV0kTKSbadHDHHIBXZ8IqtsJVD0eQAuLQssfMBrtZUXF7LUfo155Q5nm?=
 =?us-ascii?Q?ji4WSrHLCWhQLEidBx4b3UVzpIdpGPHTnOf8CA6XNbvkKkiX7bYKaBG3qdN3?=
 =?us-ascii?Q?Y14IjOCLi3V96ooTL7o9U4fIeeusBkDbNTEgxE+wfKZs/AauPEztDsqG6kGp?=
 =?us-ascii?Q?AZ1rmmVz0/W9KBsMO0LYyQaaJXxjjAt14WDtMy8l2ZIOYArNvZTRZErxZTj9?=
 =?us-ascii?Q?+TNxI5g96quYzcXslUQZN1mjWFTR79K202zH1WxLqT1z4xpXlLc5Zysf/JzE?=
 =?us-ascii?Q?0hAcDxapl3aHgBISC/swmPzCCj5FgPtFvkksB2Is1/Me9SD6ukCJRJRtUXsZ?=
 =?us-ascii?Q?Rmm2dj+iL0aAB9cks4+PJ+GUAsS+VwwuPNWuJaG9Z04yCEzW5e4PTcW+Stkn?=
 =?us-ascii?Q?MiZAPJ2kXGF2vvNuo9ruvuTeYrC+ZZzN44Q2XuILOXUdw64lX8xDmYHewXhm?=
 =?us-ascii?Q?QI1HHM+eS8zBl87t0uOeVg7RsxojiJ61FuiB4Icp63D4XBwDlR7J/GHqaiRe?=
 =?us-ascii?Q?2mC+8DMBnkYc3zfcjQG8nYIE5Btf9Zwx/jzQdmjay2/4clMt8G9M5g1LXZfJ?=
 =?us-ascii?Q?F4n104AxKCKgbvocyHrVeNo9yRgpKP1KHNGaGPwYTs0FlKLO460Qn2hAWdM3?=
 =?us-ascii?Q?KS1LOqe6RUA4amDHeOa7YgGgJicjLYDW/laitGDTrs3fY76dicz49EIsulFg?=
 =?us-ascii?Q?PXzI2DqQDzEe1x+9uQsQK7qO6WQeRiulXwpQWaQk6SlUxPn+jh3f4zDfxopj?=
 =?us-ascii?Q?yI1Cjat+UvaZx6toTtljWWiU6CYSyz53TbsRINdrnt+7DYnfUp3XDkVn3McC?=
 =?us-ascii?Q?yvhZ5S4pbltA9i/q0ndmmFOsyw5k+WnqkDw567xmf7qOw5sjTRLYP93vy0tJ?=
 =?us-ascii?Q?ln/TfXaIHd2+SIFQgjl3qtfADEz+8kmDIVkPun5UV3mQqLroqkgmNasFD3r/?=
 =?us-ascii?Q?SfWFYKWP/3HFB4rlp0BCKYnTIUoEQ9TzNBeWRb7hpKblYggOdFOmnFdBPqig?=
 =?us-ascii?Q?kIoQ7g2Ra//yanxvMPglFy4nXy9x2u6CJw7DZkzen5njzrN0YkTiVkqz0rK9?=
 =?us-ascii?Q?9BJnTpNZnh380pmMQYUAdaNpE9dyVEgabvxkTVLMBsfjZNMb5jD3fly9PyEn?=
 =?us-ascii?Q?yzcyc3f37rW/0r7rELi8IpUJGAL+RmqHIoowFui/PcFKc58HVR8DTfd3diSz?=
 =?us-ascii?Q?ya3sXxaimzQSSkpZbTEvE5Vv/zkU/09TjgQlLDd1zN+YPtA0La6uTSlbaIOg?=
 =?us-ascii?Q?f2VUdoqZGTfc4T/U3KpQHmfgF0vpjPj3e4mC+FXh7ZElcwRVzoXlZn2caImD?=
 =?us-ascii?Q?sqOa8EV5LDQIwtGbxE/kkS9Gv3CAw2MsCnL54Q7QGXUd8oSXDMwmUC4tI7OD?=
 =?us-ascii?Q?mUnbUZ9i5y6Q018uibCmoPjrEQaHWv9cn24v4lLXx/T+u1psYORDdqtE0WBV?=
 =?us-ascii?Q?vyAipEJb1cB28WSF+n9JD+AXJmF8qc9qgOS+4Fy6uLVF97U1FtP6di+L66Fh?=
 =?us-ascii?Q?UdsF9gbV9v8U6CBsJE3ufAwzR3JboAQeP0fsw1CfXplDFBxhJ6IyxOomOsRn?=
 =?us-ascii?Q?OA3qAMMey7WxCE57VO1lIcfVcJXKPc8yr39OSsBs?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ce31d25e-21c1-4a05-c34d-08de04aefc76
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 08:04:34.4233 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PFsY4Og7QN1bXsoY6CQOdAN13sIzSGaPxsvq56VIr8SWcWmXwfZcJYsaE6wPS8bIlhm3+subVRdTu2ToCZSF1g==
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

The driver previously allowed arbitrary descriptor counts, which could
lead to misaligned buffer allocations. This patch enforces the use of
fixed descriptor ring sizes for both RX and TX queues, ensuring proper
buffer allocation and avoiding potential runtime issues.

Fixes: bb5b5bf1e5c6 ("net/enetfec: support queue configuration")
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/enetfec/enet_ethdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/enetfec/enet_ethdev.c b/drivers/net/enetfec/enet_ethdev.c
index 7c2926409e..f7a45fcd4d 100644
--- a/drivers/net/enetfec/enet_ethdev.c
+++ b/drivers/net/enetfec/enet_ethdev.c
@@ -384,7 +384,7 @@ enetfec_tx_queue_setup(struct rte_eth_dev *dev,
 		return -ENOMEM;
 	}
 
-	if (nb_desc > MAX_TX_BD_RING_SIZE) {
+	if (nb_desc != MAX_TX_BD_RING_SIZE) {
 		nb_desc = MAX_TX_BD_RING_SIZE;
 		ENETFEC_PMD_WARN("modified the nb_desc to MAX_TX_BD_RING_SIZE");
 	}
@@ -462,7 +462,7 @@ enetfec_rx_queue_setup(struct rte_eth_dev *dev,
 		return -ENOMEM;
 	}
 
-	if (nb_rx_desc > MAX_RX_BD_RING_SIZE) {
+	if (nb_rx_desc != MAX_RX_BD_RING_SIZE) {
 		nb_rx_desc = MAX_RX_BD_RING_SIZE;
 		ENETFEC_PMD_WARN("modified the nb_desc to MAX_RX_BD_RING_SIZE");
 	}
-- 
2.25.1

