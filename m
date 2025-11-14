Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB6E1CDE010
	for <dpdk-dev@archiver.kernel.org>; Fri, 14 Nov 2025 06:25:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CFC5240ED2;
	Fri, 14 Nov 2025 07:25:34 +0100 (CET)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010059.outbound.protection.outlook.com [52.101.84.59])
 by mails.dpdk.org (Postfix) with ESMTP id AE18940151
 for <dev@dpdk.org>; Fri, 14 Nov 2025 07:25:15 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SrvtE47gfE6x11xTdUIbiZua/KWjZGLDGc/76cDiouPVi3hJdGxc31IsYDkLIldbpdIeVj6zit7NStCmBhn0Xkh4lE37n2jPzLC6GK5HK6c+/i5PvE35sHr1KjeCgIFPEiZeZKqrJjK+0tnXkureAZB9JF6wxppChZ8ffmEAYATrZS4LdtN0fdBO6StCxKTX/fN74CT2/B5pGPtlCbozOFgL9jqFw8xLy2cqUyu7WKZxd81Xrx9xpg2/c/SLSVRm6k5O+5h98elc4WafJZVtn1V0jbaDS7L9MP4zJU+qCgYuvrXF1TF3KBCgk5pI7wT3XL0q6YEv3kxHrQ2nHwwROQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MAJFAVMFPQFp7t1DaS0B8i7eyofAMZ8nKkRGuZW/Wrs=;
 b=lmII2uJCoOFWEAPnY3NqJ/QWszo/X6GwxSwve/GBBxojz87WlWKdTBt2uEIRMQRSiq2bmc6nn3595wh3R5GxJVuXYiQywc0GxCIuiyinOPQUv9K/UW51s3tYM2jxrbwVWOPluDf3FTYyYRH4aStMhsux3BvkZawxVdc0caCgm1fD+ZAHtzW0ZeSnbJyw3YJ2svDI8FFEmtkVT9XSMwpSPyXStf0VBNye6pPmgBaCxEAjep8PwzwfPkSXZxzulAzGeHZTfgG2jWIcLJ6uWIR1Pj5qKxenzszDHslyZbP2Q4ii9sJyab8Jl96+iC9qT9c/ujK6HZXoB5QqZYrKUvcshg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MAJFAVMFPQFp7t1DaS0B8i7eyofAMZ8nKkRGuZW/Wrs=;
 b=JJdPM4q3hWQsnxzt6bftvILknlQ3/aTIQCjwogX5D5E+ZslgrqqbijdQoLd7hJoeIOhm5NufiwzlNFIIh4WYTI2Nff+sK3lRNOCmcCLQkp+RDrX7HNM0bbdHSqy4CbYFXIQ1UftprrhCWBpDpldTYJyF6SgEohZAoBfq2WYFIr/dZ6I74vGFsAUqYy1F+hZFo5HPzk65Y5rAm1lpS6XpAFq97ux6OEEaKZREm2X4hbwCuYDACIDGCIPH3FEi8pZ6pF63amrq4Tvb+ptFeslW8ZxUEi6KIDM442KQ6plFkx6NQNORoSqMornPVm/PqUO7dhuVwsk9WC5Xx6QTaxJoFg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by GVXPR04MB11067.eurprd04.prod.outlook.com (2603:10a6:150:21a::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.16; Fri, 14 Nov
 2025 06:25:14 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9320.013; Fri, 14 Nov 2025
 06:25:14 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org, stephen@networkplumber.org, david.marchand@redhat.com,
 maxime@leroys.fr
Cc: hemant.agrawal@nxp.com
Subject: [PATCH v5 3/4] net/dpaa2: fix queue free cleanup
Date: Fri, 14 Nov 2025 11:54:53 +0530
Message-Id: <20251114062454.2731559-3-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251114062454.2731559-1-hemant.agrawal@nxp.com>
References: <20251113114355.2027438-1-hemant.agrawal@nxp.com>
 <20251114062454.2731559-1-hemant.agrawal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0031.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::11) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|GVXPR04MB11067:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b8c69a1-1075-40d2-c4f6-08de23469249
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?oqbdgfyPWMwj7GpM+enOJCALJEUPq+pNPJDGb/y3YlvOyrNWabGV6SATFjnX?=
 =?us-ascii?Q?gMUCYNZuwEAc/KInKamwdDhfSR6pDFACR/Pjaq1m2hB/td7s/X19o02UKtOM?=
 =?us-ascii?Q?WTKXfpYP2Wk9906/mDskwh/Wq2+qauaCYGTkLnXJOx3Urrro/OOQUUYuW7rp?=
 =?us-ascii?Q?+LcfdhNwdHDLQnuwH1Bt7rSsGbbK/HKpfwzWQCSVeOH0Khy7v2obJUAwcI/J?=
 =?us-ascii?Q?hMZnyZR4cv04+W8M53wna22pX7aKljAoiczsh0xQ0WiGiavA7HKq7c4YrBeh?=
 =?us-ascii?Q?LBw9ePhAzUFqShMsGXm6ewptKOBAe0gya4Fu6GiDpz6cy5184ogFnWUQd44T?=
 =?us-ascii?Q?xbNNuKWNXp2SSVl0edysyu+UtTwyZYQnuXSMruUO+HwM7MSk/Q3+4Z3KKUNV?=
 =?us-ascii?Q?vQzTTeqgykcR6OAa7qBbfOrb6AHXMH6AGoQ19oA80Bk9ulv8GQfjEFR1/0W9?=
 =?us-ascii?Q?sY2uklZKRSopPZwpgsOFCfCy3wZJzECQ7JyUWvR4gJYlX8buTjos1hGVQToi?=
 =?us-ascii?Q?ttSperHhC+D4ipRZ75HkjqybkoGrl+KnwKVljlhMWFHOAFePVWoFLL0WYN94?=
 =?us-ascii?Q?JsqC3UyBwwVbKbkalck+hPin4mj1VbHCWooJn+utaOGTlA1nIsjcdSet+qes?=
 =?us-ascii?Q?Pm/46vDpClNsiblwgw7OvXdx3PL5NQL3APd3RL/xUuwg+HQH37x9bfyGwxN/?=
 =?us-ascii?Q?T425mUvkom1Qycapf1RJnAnpvtcYr2t1kYpAzCrhQg3YmesuGQB4SWpBEUe3?=
 =?us-ascii?Q?9EN/lzoQASkhK/626Yb3MNLGUeq1uIuxFZGkSkgLM2mUZ2MS5PMutyD+yeVM?=
 =?us-ascii?Q?nqT9fE2jrhY4wZy70GQSXaL4TAqbZHVA7ZG2BWF1YApheMb3pGOtpZ1vu5B1?=
 =?us-ascii?Q?8g4BGKDf+9DqQFqvWjj3bHw01p9tpf+XnEA0ZUDJyHDBngB1Lg1hb1TIRBEi?=
 =?us-ascii?Q?L9cp5f1NfuNFIYea9u6cXswKTbQseP7sO+H1KKOnUd6z/jUCIluFFXFm04xv?=
 =?us-ascii?Q?o6fPYfp+0cPy/i8U8YKRhtKmNtOROMqNwJqzrnRDjY4nN4G/dQYLdQFtsSwF?=
 =?us-ascii?Q?qvdPVA42OBtSFuuaRJ1CHa3njCxBmWb3AgMXuI/8IMHcE2ihdMvTr9xtmiRi?=
 =?us-ascii?Q?KPUkZCJoQJI2dqavQJ2B5acJnpZkUJeRw+wcxBNVC2paw8IPEZBtVRnLp0mA?=
 =?us-ascii?Q?iGO51tThg0zORmpAR2QxJeiFmTGcDMrfpx2wXJZwLqDf+ibgDy220eOrxhyn?=
 =?us-ascii?Q?2QsOqsIn2kred00aXeWHvlGGeSgxg/tNc3vDPF++YsbDvWZ4dwKZB8K7s1EQ?=
 =?us-ascii?Q?Zh573mQMnef57S0x6ISTIOpRr9e90NJqyxqPYeGw40jjDiTNqnLYETXDEbEi?=
 =?us-ascii?Q?snswsKY7JPPUgxZCk8ZgaZz/DtSEXLugvyB+sic2Mk0+4WdFH0/9KzgGB8JG?=
 =?us-ascii?Q?RL5HEluQX+yL3u6Hk6xkqYiADacTQmJXNF2cJZILEwSSasyUj4pym1IGtWGq?=
 =?us-ascii?Q?WSPtXIdELvPlkBHBN4YAS7iar79ZhtDJkOWm?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ua1fBn5XCnplgpjv6JVwDIFMwZhKc/L7LSCIaz18i6q8uRBv1x98E90JZ6q6?=
 =?us-ascii?Q?ndl3rc2Mof//Ya0w4bwR1T9dLB4elwbXg9sF4khRcaAev+QGKrOei71Xywu8?=
 =?us-ascii?Q?jRyPeHiKhVKoeV5aaxN/m526bJ24JazsCYmmdpe9owq2uX9hfeVfNZmvklX4?=
 =?us-ascii?Q?9oEYNZq+GW2lj2UxA/PG8pPnsTUeReg4iTT/E4krI1hXQ1nmJb2jVSS8UfNa?=
 =?us-ascii?Q?oGlDbJFFVUXcBLrDgnXnGuD2EX9lsZnGCpt3firpD4F5fOeZP8unRvXKbZv4?=
 =?us-ascii?Q?YvTrmtbCsd6QYoUCImJc2NTUu7Vf78X5zMzsMukxnq43OvmYKJs+TmmhkXfC?=
 =?us-ascii?Q?l5+viImHDRHT6kggplAb+TLvvQXGmaCkypbjGH1IQUB6WEtD0xXofTUz6oYL?=
 =?us-ascii?Q?3macPRYhgrD3bLgNLprZf5Oa+LIfiaom+oatQCPqSO06j2P2MHzwXf1yfcHO?=
 =?us-ascii?Q?gaMzKDNWm6COQkbJWOZV2iROFRpLsU4FkCCI4iIElyczBXP/EkLuSR/3SwPo?=
 =?us-ascii?Q?roxk6HSzvpTBi7L3Qs06P1KRQTZZayUlPB7nwxF39+eeAuvXXougKgqTsePh?=
 =?us-ascii?Q?raJ6IKBK1jV9gDk5Yvi36oxnnDrE/PABt/gjJ/+0hpYwdjgmTIUEEg0E/JEo?=
 =?us-ascii?Q?pcmefWrg2wM27gJjT9xPPLN2S3atuwWDM2eIQ/dQX8FrWU8tPZF/a6DEart5?=
 =?us-ascii?Q?KVViAi4LnsRVZWmWJ/tUZKFBZzP2tHLeTHRGu6XMtbyYCQZt08U1jrt3ymVI?=
 =?us-ascii?Q?E9IC9yvkAtoJPNRScfwzDFO5MOiiZLTz4loGZrpIC6rRd9xIFEpTFAjurrsm?=
 =?us-ascii?Q?vmxrjsHJRfSnxV0mMU7B996LEYZqiiM1jSakbTAY93utJJC8MqRlzmFT6ptb?=
 =?us-ascii?Q?01N9U2oFSiDt/8HAbuyX0/j+rpX7gueZb0NziFRMvtk3fU2sLKrKCGmfoK9v?=
 =?us-ascii?Q?AYRP1a6ugKeEfEwLFyPl8PDX48QsP1eZQRzbdh3QxCISLhfLblpAHHfMFhaE?=
 =?us-ascii?Q?8ZIr7ZS8itD+Sf1FUCq74NK0OxfGMgADejSabbtGmkLXEKdq3DbO3daf72x0?=
 =?us-ascii?Q?SgUTH2I4moR9oY6F26M3ZQXikf9ZXZV6kXz+TPYml/3kgiAGMqv1hDna+M0A?=
 =?us-ascii?Q?ZmeTKc24EKZ8uCMIuNS9/6Jp2mrurAQjpfC5HFCLQhgE7oLyi+Yn5cgSc4aN?=
 =?us-ascii?Q?Q9bzS6AbFZvXukXGkUXPJ0xcWYXUo1UU9Bdu/y5pgiZehpLCZ2wqYHoIUSqB?=
 =?us-ascii?Q?Dx1Kb5DsvT+3H7qkC8REugN58rj5CAKYgKYVLtbnHu5dUUri0tkViC8SWuq5?=
 =?us-ascii?Q?hbLQnGl8D/bxC/FkYs742IDIAc9ZqaelV4neY9a1n0ZpF6uD12jWs7mPyUKM?=
 =?us-ascii?Q?gsnJLDpM3WVWfR6GaxpXNN+ZT9rWuodyBEMWFsCzWgxIGypJdAOH3HjnuIK5?=
 =?us-ascii?Q?1yvhk2ZvsGTlzq/hYnqE3fsMXoVeVFN2voyC1Ts94CxYWK761/23uCqnZyux?=
 =?us-ascii?Q?q6VRDKHirSubMcL354NUwjsG3RgBwRPQ/CNWbeTByOZ8wwdfd24MrNtuQeEP?=
 =?us-ascii?Q?21IDJQl7QiCMTNfZdY4JBvVuW6YqX0YY3ZfpdRZ6iC0YJWYl1mY6jejYNr8R?=
 =?us-ascii?Q?Ww=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b8c69a1-1075-40d2-c4f6-08de23469249
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Nov 2025 06:25:14.4024 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sZpd9OMiNRG9xKNy4f0x0AZ43R0ShqZBMZrMhcyR2N1oaSgopTzoMQ+DPvYL15DBtam5Ag5NFCBRB7VSX5DWvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11067
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

The RX error queue was not being free.
Also, set the free queues pointers to NULL.

Fixes: 407ce3e5384b ("net/dpaa2: replace global variables with flags")
Cc: hemant.agrawal@nxp.com

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
Tested-by: Maxime Leroy <maxime@leroys.fr>
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 3fc708cb02..fd7bf94231 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -670,11 +670,13 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 						RTE_MAX_LCORE);
 			dpaa2_queue_storage_free(dpaa2_q,
 				RTE_MAX_LCORE);
+			priv->rx_vq[i] = NULL;
 		}
 		/* cleanup tx queue cscn */
 		for (i = 0; i < priv->nb_tx_queues; i++) {
 			dpaa2_q = priv->tx_vq[i];
 			rte_free(dpaa2_q->cscn);
+			priv->tx_vq[i] = NULL;
 		}
 		if (priv->flags & DPAA2_TX_CONF_ENABLE) {
 			/* cleanup tx conf queue storage */
@@ -682,8 +684,14 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 				dpaa2_q = priv->tx_conf_vq[i];
 				dpaa2_queue_storage_free(dpaa2_q,
 					RTE_MAX_LCORE);
+				priv->tx_conf_vq[i] = NULL;
 			}
 		}
+		if (priv->flags & DPAAX_RX_ERROR_QUEUE_FLAG) {
+			dpaa2_q = priv->rx_err_vq;
+			dpaa2_queue_storage_free(dpaa2_q, RTE_MAX_LCORE);
+		}
+
 		/*free memory for all queues (RX+TX) */
 		rte_free(priv->rx_vq[0]);
 		priv->rx_vq[0] = NULL;
-- 
2.25.1

