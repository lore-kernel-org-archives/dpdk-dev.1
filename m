Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51698CCFA18
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 05:30:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5ED8140E3B;
	Thu, 13 Nov 2025 06:30:02 +0100 (CET)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011064.outbound.protection.outlook.com
 [40.107.130.64]) by mails.dpdk.org (Postfix) with ESMTP id EF21540E1B
 for <dev@dpdk.org>; Thu, 13 Nov 2025 06:29:59 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IdYVuvj4U9Cd7E9m9c6gPWshMAU15TkHuiJZvUuD5SMph16LD+v0feaUE1a2Fwjmt7x5eio1sfwoavh0L9C15zCA1bGOAiy1Pfydp3NXe3SX/SnhLVQhlNZHhsS3Hhv1UyBdvDvG+54KJsvF1FIMu1glxAlc58gFnEKRbitbS6HSKB7Uj5D+DEdP6+dph3Gqi/GpgMh72QrrdXjppNwn22xXR167/C0ermLySHaN4yOAPAFf0N9VrIQxZDUHwFGCCLehjzPj9LuOyZ8KzQE8rj0cliryq41UesTi3RCkxpdYM8lsfCNLa+FAaTfS1fuOpSdyhmK25HaPzcvxygmwtw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g16oNUNSXxwD45uSB1I032QfdntXoNvDZb0JtO222ts=;
 b=laUNMZIqLZdFyi3JPc+8iZjbHUfnYeDWR3cH6i7OcPvrx/nxyL0pk/l+KSXG2MkYm7T1oadhJexl0iVkiS1hJcEMs62wyEoekZ8YxhOND8DJZwLVvUAXLj6VU0JTWOAPbAr0jEcuq95A5B5GLiIYKeHypySmX7Nri7zCC13n7j+Po/6VupTDUl8x1bp1W7kto2HNJULcYNhdE7W/jYJB1jYSt1U2tswNJIFuSTxgR3KuK1X1AY+WUMFi2tW6nUpbGWDJhm58ja6tG0VLVMocx5vUdPXyvIS964XCg/BMXBunnjqgcapniHo6al0xpsClEREv4iS3a3vz+y8mdw8prQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g16oNUNSXxwD45uSB1I032QfdntXoNvDZb0JtO222ts=;
 b=fI/B39fgzDa1yWzeg1dZ82SiRtSnlV14Z2h8NSm31v5KvvbrZrf+3xXUeC7D4XfhihQSS0Cwg05kNcHcNXPCrBaxXMjgPjfMcf3uvvCZmk3HYIyiM4mTOZB8QwIyjyT4v8E+dZhiYkQlPtoFEMnFGl+9yF8ersKSO+TlwYt0aEyriC/cuyYBp+xn6xY+9n8a7eToWg+D+s/Dv5Ib3oc7BmTiz+BJUeTRxgDxJ7UqWU/8/qdB6P0nItl/hWrvFrHrq9mC0Chg/KxEs/dWEjexkEp11zfS7KwJiUgyu/psEXil7ylHu7cHoemRfujGfg7wN21cmVQDtrASqD8r8k8uAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by PR3PR04MB7355.eurprd04.prod.outlook.com (2603:10a6:102:8f::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 05:29:59 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 05:29:59 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org, stephen@networkplumber.org, david.marchand@redhat.com,
 maxime@leroys.fr
Cc: hemant.agrawal@nxp.com
Subject: [PATCH v2 3/5] net/dpaa2: fix queue free cleanup
Date: Thu, 13 Nov 2025 10:59:29 +0530
Message-Id: <20251113052931.1784953-3-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251113052931.1784953-1-hemant.agrawal@nxp.com>
References: <20251106163807.201451-1-hemant.agrawal@nxp.com>
 <20251113052931.1784953-1-hemant.agrawal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0045.apcprd02.prod.outlook.com
 (2603:1096:4:196::21) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|PR3PR04MB7355:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a386721-78e5-4cab-510f-08de2275afc6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VqugKKb5vlkqNhuaey/hPK5IcXcYK5t7ROriO0plrzWpmYyqtSKqYyFz4vyu?=
 =?us-ascii?Q?Pn5FwtdXCUa07iEVBne4J6hb+bS0bgmi4kg+E6bMGtPu/Tw68I55nDSWP57A?=
 =?us-ascii?Q?xOVBKhvgHNiL3XHDpoh0Ptli5+FFjDj9r340VuTTreesy3vydmazq0DVyT1R?=
 =?us-ascii?Q?fhO61ciohVKYKcPQ0XjqAaYzgIrnzppCIaVP3HnWzuPeDTB7vE3PNvIjmHxR?=
 =?us-ascii?Q?OF2XrOGII5fB2bGLdG/Nx4fgP+kVu6vqLutL93Qf9Co4ZWe5ZAT/FMf0WIhe?=
 =?us-ascii?Q?McFSEH2zdZOOH3xkBXwDpW5L8URX3OJ6L6YG4zYRodIwcKj0QIRKvAUpy1oi?=
 =?us-ascii?Q?w7VLn2StbC8bv0XewnxWjupoQ/fmrVuZSX9vOGs1wbC54aKYxZsM9yGjm9GY?=
 =?us-ascii?Q?PM9LzS9H6zfMwWC1gy96CtaBwx9yGwYSX+2PBXE4IuA8klBU4fjY4FOtJqBy?=
 =?us-ascii?Q?PYC2CpzKpSAQ4P9Q9u6Qd4MZqiycT/KD3LQ9B0saUHmh5P8tsYgOgwvVgqQ/?=
 =?us-ascii?Q?gPauuJGsVmoxn1FCvHfP24IRFk4WYlqZVc54dfKe1ldiOjm3aRc4eI8Hx9w/?=
 =?us-ascii?Q?mHveVdKQNoUYBmwPu5dl85NVVyVnC94G8tw/YdXzP74HQY1Y1csyVd2joadP?=
 =?us-ascii?Q?o5zZnxg23xymTjwpVM0VReGUBigHboF+LfJrfCtYINICjGNU66MKehWO9csn?=
 =?us-ascii?Q?BC4p4qpxO6eUqa9k/N4/AQk003lo3X2qBLCzlBc2Hz0s/wPHRJb4MJdyDt6G?=
 =?us-ascii?Q?6Ap8lfgR81caibVYAYvlCSjjSnhODqa5zSPxpjP4q6qgviLzEVADws0ElCpN?=
 =?us-ascii?Q?MyWkvcf6eFLcTwBVqXnfsf6PRKG39Gx4i1fZk7VQJzcMzeyK0a8eLxiHKeB1?=
 =?us-ascii?Q?K33E290njTVECWm6kOasfTHFJTnYKtDmvNEefNTEUf907AnKe4Zk16WAtsbb?=
 =?us-ascii?Q?qvpCU/ZmU/MiS6BHPzd3zgTVavn0XwHRr214A9J40ZNbD/gFYCLTfTo1Wq6O?=
 =?us-ascii?Q?8csTM+OSKPFAnyZX2Lw0u5WQIK/t0jdJZR+4LtejaSk6/Z6uZqcpsIHZ59ux?=
 =?us-ascii?Q?C9TceH+sHvAiWAcVgbjDfllpBAHcxw7zGIQ1EVBL/89YUiSff36aQ+8hQthH?=
 =?us-ascii?Q?C4/WfwVXeZWw3NhIOfq/3Zl8czPpPwNsz4+0y+LfGT0pW8rvCr7m2WunC/PK?=
 =?us-ascii?Q?OPj4pHNBOZeCI86iv8HIGK8++gF8In+hSQvwO9b3ZOafCg70MFjx1jSecjmQ?=
 =?us-ascii?Q?VSW3GWKSsKqmjL+rjHEPhX8DV/fmRQ4PisVolkNiuCKSOnICqFHpMeyQzaDu?=
 =?us-ascii?Q?rbPsuQHFTqAFh/X0mLEN2yirItXDiC7SjPbWwrBqeEztnxntY/iHIZzFnOMb?=
 =?us-ascii?Q?R6JWReyDlLAI/2ASDQteKfn+U4GGxfSxG4YCKjRodSxfmWGIXwg6lS+QgwOB?=
 =?us-ascii?Q?3giCPvKjpe5ymyfZjugz+wJn5ScuqQ0SWvSrmXBsGGrt4uNzZA22X/MM+vQY?=
 =?us-ascii?Q?u6h2mOUgR45TYIRZLg6vdSMIHbLfGsN+tcqG?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8wkdbcwGRB5SGc6OVzfhQpVr5VgUrgFX3GnuOcNkLSm9EsJoIhV5p2Rn6GUh?=
 =?us-ascii?Q?1OvMkXBRWn0BA9ESaOvMkGhLA6xsN7LaGfEoheakiPIa6zaM6a7ENMd3rHHV?=
 =?us-ascii?Q?KP9D8F9fSf3AfFrHSLR3ojyx+zSqpwgyis5Jln/h/wIrubICpImKbkMBtfuQ?=
 =?us-ascii?Q?Nlcw0nQhuSDK9Fzt0QMAvmphXzyJo6Am/vdJdSVUMqSCw/38a1z2fTbAaOjd?=
 =?us-ascii?Q?rzje5zIw+6+fB4dlFUlej2JnzNVmbfrpSJAMjZV4QZCo3mZOLSfPBf0CXg2Q?=
 =?us-ascii?Q?3pR6vF5UtLc367vMMLaXzJskyJ6+cxgxLVst2f/5NJHfRevhD4Qkz/5qX6Uq?=
 =?us-ascii?Q?zot7OULM8dRVAdB9B5UMP0V3HLL/Smo1N/rQXaATX5lLGm1xsx6whBLWKPgk?=
 =?us-ascii?Q?K6f18ZmHh1eVixd5Q/gIJ4IsgwIJetogiJhawIC0SciUeKWMCR70DyTXzog1?=
 =?us-ascii?Q?JGjHQQBOxPqpvhSsF1PdfSIWV8QiNitQ5Ln1CQZcaeemf33PGybyzZwY5J3Y?=
 =?us-ascii?Q?A8OFHthKmJya/WzjD0hWZzd2ruZdIq224GZwg2uFxW45O5Lx2pMnmgVd2r0g?=
 =?us-ascii?Q?pYmU9gqzNL9au3cPSKHaBj+QWh54yUU5D0EqldqgNlqpmcoGO44VEdDTNI14?=
 =?us-ascii?Q?ItSS+hAp7rFbXA+Llg4rs/GmPRQqlA6M1mBv16vWu06W20cfrdzwdVTFw1Ik?=
 =?us-ascii?Q?aKb2g7/jRhMn4DY2UA1A60gs7TlhZow85cCyHr4AswfniXBfQJGL6pN1faEu?=
 =?us-ascii?Q?hfSeSpyKhHW9Jdr9pfR7zH5MFG4pGDSrvGhJduPmyIrVtQie2vItm9D55mFW?=
 =?us-ascii?Q?HCnLAl22t8IL10ZIXUraRO1r/UnlCfvnKMfhLh4I7s+RuF7H0NGevLd2+bzt?=
 =?us-ascii?Q?beXzrMUuulwKTFlmwbLErZpN/Qb4wzoUxApmi5/8xD+URRlB3vdAxqg7TpqB?=
 =?us-ascii?Q?Py44xFIUxYk2gfV9dHuB//H4mwLO44P/Ix7fV0Cmm4chxUJVYfWKQBJ6VHW5?=
 =?us-ascii?Q?st2WTkULkrXvx0ZEaUAz2QS18N2TbNMtYrAVHIUdZDDHn+JHbVBw/zF+ZbPB?=
 =?us-ascii?Q?ot9WEkrwjYWgSh0Gh+K/+cn/Jh+toYHxsN9DgFGdHSPy0mU5QBI1unRXJ+aS?=
 =?us-ascii?Q?e7r5yDICw4FK0rrG26ZgsGj9LsM/PlxHpbFWjH7BU3GHyG6I1kBIOK7sb5dm?=
 =?us-ascii?Q?uFox73ll6tUzlvO8S1saH2UVBJE2f/hurrjb9jgDnNjdk0Cga9V7iAytoRMx?=
 =?us-ascii?Q?xwmKwX1h3DiRVdZxAQ/JUleKT0MyT0tKb+pHeTrTY5xp0WlMnSMWWbQcLKxG?=
 =?us-ascii?Q?I3fAkf+fYptxK6dZnel1hqvkJQ4NGLVeM84RvYyypH5tasD/qvLOlgzPz1qA?=
 =?us-ascii?Q?IY7YCPXOcMdcGgcB1w3oSGSoc59lvmWA2LN1430m0zJsARFMZMVauSQOnVoC?=
 =?us-ascii?Q?GaraggFPeSvrlOvERpNAUmrFHjDa07Y/AJWV1DlYwyCH35Q3hHNPKB/l0MhU?=
 =?us-ascii?Q?1N9CQr1yS+OFGnbcylQM+MzsQASj6n7cPdN4puFZmXP9VdPbt7+m52+sDMoX?=
 =?us-ascii?Q?MnixqKLFcW9WKQL0w8ExQNns4nmn24iusXmi5Jx7MXg4EdgrgMxR0skqOobM?=
 =?us-ascii?Q?Mg=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a386721-78e5-4cab-510f-08de2275afc6
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 05:29:59.0923 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KtvoaHdVj4UCqFH2aFMpsL9sbA2/brm0VQvVPw8XifjEH4D/NcMKRTChGgPmrNCB7YWfDlbSKY1Heyw25GzPvQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR04MB7355
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
---
 drivers/net/dpaa2/dpaa2_ethdev.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index c94034104a..f82c50341d 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -669,11 +669,13 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
 			dpaa2_clear_queue_active_dps(dpaa2_q);
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
@@ -681,8 +683,14 @@ dpaa2_free_rx_tx_queues(struct rte_eth_dev *dev)
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

