Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98018CD5BCF
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 11:44:27 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D256640E2B;
	Thu, 13 Nov 2025 12:44:19 +0100 (CET)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011002.outbound.protection.outlook.com [52.101.65.2])
 by mails.dpdk.org (Postfix) with ESMTP id 075E340151
 for <dev@dpdk.org>; Thu, 13 Nov 2025 12:44:18 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fEUFHM+bxsMrcJAPlZbI+PmtS768XNTBbnFcQUU72IVq9A1ZdohX7tcEOdzylbPVEfwq4+34fK+6I6kBnzPt6C/4HJKF8cJ63CPlXcfRrSE7AsI5+aNiRiDVlA/vd2l85HRE6XxFTZngncmgmHKy80MA+KQcYEtUlmZO9lGh7gajyhqNzkJspGLkay3k2icZzy2L5Qe/gCoF+jIZfsfA0zmXeoUg+haPey2IOqvy93N4gAooFa0RDD9VmQvPThY813BDUWramIz5BcusrTVX53Xfy1m0jDhPS2N09PYrXOUTq9+gdbcde26nBpDM+NZu4NnC4x/Z3I8j4MMPCY7hFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qMjCpCKPyx6YJuNU0cy7zqnqlzRbMPqeVVVV0KeZNNI=;
 b=B4wk7AHmhaYJtmoL46ZceSczFDpuZfRq4LUMAFzOgHx6M23tRuYDYeRVr/kBacmWakYbEl/7Emm5daNVE0p9lvsS4TPg4EDy5Q3evSRtKoXFe6qzg3x+Avgp1241r3guiWkztfuGIvOjt6pQ98wBdRv1o89ale0ctr8AyPv2cBkA3XvfoJoZMeOjCAHiY0ijGT7CD+5GWO3D0QteUHFwia3Ky4VaftWElmWnVCNXdhL9iZReobNJ7xwZOsQVs3vU7/IJrEJo+WhGISqLSb95W5Icx4ytdZDDPLslznkAhwso5Ejpa/vz90hNBXnJIdQDRA3MTgy3ucGm8UuwbRZoYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qMjCpCKPyx6YJuNU0cy7zqnqlzRbMPqeVVVV0KeZNNI=;
 b=J4X3hOQJA4j0oydF3fCJJNrHC0Hu8DOCrR3H2LgdY/XOUxGj2JOqjpF0BV/7RifQjSQyqcVKc8nn09+H+jMM0r/yjy4+8UJQ6RB8028DsAVDUFwV9Pdn1ae3AGykkanzumdKFA1TJ1O0laPs4Rn5r2gFaBNZSXBO95w0LpX8MqxwyzzniAY/AdmWOHUMVwRNZSPEcULXL/dKIRC1HfrbYRdRD4pvwPNZqUAHv34b6BxrCnHSMzUxVt4cRb0zkujtHXqRgFfkOeRZ+GmJZb5faOYYSqfz9gEYJZQlICXglOfmXcY2gEe5B4zuR7ntls0s3YEYCLcJJmOc1mxqEZG07Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by DB8PR04MB7035.eurprd04.prod.outlook.com (2603:10a6:10:127::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 11:44:16 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 11:44:16 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org, stephen@networkplumber.org, david.marchand@redhat.com,
 maxime@leroys.fr
Cc: hemant.agrawal@nxp.com
Subject: [PATCH v4 3/4] net/dpaa2: fix queue free cleanup
Date: Thu, 13 Nov 2025 17:13:54 +0530
Message-Id: <20251113114355.2027438-3-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251113114355.2027438-1-hemant.agrawal@nxp.com>
References: <20251113095917.1973514-1-hemant.agrawal@nxp.com>
 <20251113114355.2027438-1-hemant.agrawal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0116.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::20) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|DB8PR04MB7035:EE_
X-MS-Office365-Filtering-Correlation-Id: d4edf0dd-c1a0-4457-30ba-08de22a9f961
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|366016|52116014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?CS1OwihwK47hOGsNZC5wPL/x7PAq1xqRTSruqqgzBCTlPH1KUrXbqceHxXfE?=
 =?us-ascii?Q?CEwYuuWOt0pO5DcJ67KUySuXnT8T8ZPrVET2LSo56AXMJ7YeVL7XC4/WMTrj?=
 =?us-ascii?Q?VaTxAcjOGDTbbn2QUIYev4dkq1YRU/fXxJqJBIgvX5hH5FMzW+UYdqClfVrU?=
 =?us-ascii?Q?mAyRReGE3JaNi7cL6/FL+6Q9tSM59rjt43/nsLvFl7BKbPW1GsHskcWB/ZUc?=
 =?us-ascii?Q?L7Nre94pf4wYmmzO0salz7nYKQEt4bU4dv/Dt4BkeWZ/6jqDWlqAZO2/A/77?=
 =?us-ascii?Q?KHHLhUWVfaLD/iUY7WQ2vb9tkX+JeONpvxweLqYIVdYTtax3QI7RxSirnhN9?=
 =?us-ascii?Q?2YooHeJYKGixVytgEDR7Th+x5WbL6kS7xCxamo8a2P9XNsMJnl0/EfZEUWj7?=
 =?us-ascii?Q?GO7C8uFE+08uKESLxVoxRawRRpC7CT5rxlj0ZbZVzc9vKSHR1kydYhSjHGcr?=
 =?us-ascii?Q?CpYQavdQYWxqBoqOlgKTrutx9eIjlljIrfDJMM2LtUFe5OYwIVDHtSIykZaL?=
 =?us-ascii?Q?pQf+fs+ns51u2KkXHmxULf12gxfHbLma33yJw7EvnN7ckslLz0btm/1KuGd/?=
 =?us-ascii?Q?5JGnRtB7IqwzgaJOwwn3wu/WIEFpZpYwEwfJqwQWy3upgHddc6Kq8Y+3bFXu?=
 =?us-ascii?Q?yaukza3wzqvVaTbMDcZdxW0BCGPYdNFai73jA0fEXssz6g9p1fu9izgZmW4o?=
 =?us-ascii?Q?/wC5dv8HzZn7fXbhIYaFIPUmhpYCsMtVv2pQVlG/DSyuD+Ias1naV0TNq7SR?=
 =?us-ascii?Q?yps191ykZDLK7fhmEYN1Ilt3cojKkHdyHFgUJxaB+UQO4b0ty1l0kf8FHC6H?=
 =?us-ascii?Q?sDS1yg3imbup2Rbhz/ND3oZiXVw8gEDyZDO7XtzHHAda4XPtirQIDXSuA0qu?=
 =?us-ascii?Q?Re5Plbp3q2OXOkHFUB/sK1syBta7n8073TnV2UxcuTTxvN31hVT405NdJO82?=
 =?us-ascii?Q?dnuuVemHpV1E9Mb4Mcpr7Lrlpl63HkrnNzo0dxHpF2QkEElC7ok6JNHWYO7b?=
 =?us-ascii?Q?ESdbsFc8X0kVeHs8SFO749Y36sELEw7TgmYQHZNbalouRgwXcJUmTcywB7Gt?=
 =?us-ascii?Q?hynLL/Mzx+lfAFVNag5KFcvvSWMcHKHqPI4fieUILamlcklqnwIdLK9NWGU/?=
 =?us-ascii?Q?UUtavEl0Ts+Araq8PUQOr1oeS3WrB0Gi9gYVjwtGw+fmy5fl8OQntlsH44Bm?=
 =?us-ascii?Q?+3XEP0+ddN8V7xQE/aRF7rEZJVjT0vuttrsvOQKS80FgmIomP1FPOSwEtki4?=
 =?us-ascii?Q?4Q23KsycKHq51WBgHeFLlDHpo36U1AQdPuuujvErAAe9LJjMScT8xAnhM8FM?=
 =?us-ascii?Q?zaKjkBAiBDDjMZPsdtQI5PVKx31UZlpMuxkl6yK5opYn4hRa08nGY9x7FgGt?=
 =?us-ascii?Q?NTMkBYue+pbwdxY0OnLeh4UjnuTBr4sLf2TEZdNB9JuXo5RPVnz88pPLFT8y?=
 =?us-ascii?Q?/LmPA102U0GlU5KgTI4bg1DpcndsNfjCKkCG2itkHM+6okAlqgQdeO71igJ6?=
 =?us-ascii?Q?b66iJXJ0PMyBU9CNOKXXdLv7f+03fqA5Cd/S?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(366016)(52116014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AzIWVK8MJhlD5+mp9HpUxkUu2xZziRJgLGTLT4IT619Orankg+gA64/THnNU?=
 =?us-ascii?Q?RYzKqRi55bD9EoAhpm65B4Db1MYb7wke2Hd6hXGxNkWtQhVcrpRCIgml/Iw0?=
 =?us-ascii?Q?r3/W9OHmPSbKxxYQkom32Foop6uI2/qugTOC9evlZ6mPggdJ1nlR+fIuHROJ?=
 =?us-ascii?Q?U0ULwTQecbX70U1IELQg4V5wZMuY2Ko8LJDsXjGF8hso6eeuOwhrxhb4dJZ1?=
 =?us-ascii?Q?1+YFrSz66TRZFKVO6kACQjcUMBD//emrP1rIR5wddK0u4UDRKGGF5ecQ7rZx?=
 =?us-ascii?Q?yf0zUKDw7Qu7c5rhW4PjOusFtx2a79mUnVoh5n4NuWZQJtHR5F/WAFwULThu?=
 =?us-ascii?Q?DuL0oJ+fcID1lnfFSFbt7/r6ke6EE6m62c+qWbskmV3TSigpzsoCGmN7UNg4?=
 =?us-ascii?Q?ZNZ/B8E2XW2reQQ4ujtrYFhV0MdpqyNojR6sFDtp0bR5E92vqU8oLNOSbVG6?=
 =?us-ascii?Q?+JDLL+5T2Z7liWxDuQ2jVH/vyGxOAKBpYBLFdi+J90Ee6Zaexsiza8V1VGqp?=
 =?us-ascii?Q?kxeExleza0tgxK0L65srQEXV1vxLUH7mF0zsaE6Aj5G1xiMZra3nOGfNFCG7?=
 =?us-ascii?Q?tIGv59086sjYAQN62kTKOTA2VARKh0CFq/SJZoRm3eZuNYOoEuQ17jN6xDfz?=
 =?us-ascii?Q?3OasOseUnr5hgNeigd/hdi1OYME7FxJN8gTsslmqMWd2QvTAx2KNWXtQZm7l?=
 =?us-ascii?Q?uwpqt0liLYLVXuB/Ku7XguOTbDupXPeK2mhc6zhYdTW//oSJEeuoukxK0CNL?=
 =?us-ascii?Q?Y18VVG6OEktiiqH9lCe+02p0DQc1DxfrQE6PJwMUDqSa5OeQTN4mSS+84+AQ?=
 =?us-ascii?Q?eDHyvANETet0WmRHJ64lfzN2TKAcNSKkWv62iBdbbVpB6fd4c/4H8H5MPHyf?=
 =?us-ascii?Q?S43D7oQyfjGlLi9QTVNbh3sY1RYOlKYb/EcQppDfqNud+eN7d8dSkc3qC03u?=
 =?us-ascii?Q?9ci0LW0spLBnJF7lpnv05UfKeh9l8DAAuRQ8623b2mjSefdGneqio9CMMzLZ?=
 =?us-ascii?Q?qER2pAJxuToyo+R77LrgVCms5QvTrGLAMaz3zXbOMc866EuOp07US7eAmKY7?=
 =?us-ascii?Q?uyN3Fv+VNY8EcxQAD6UBYAb5RsULAX7t8ejdl1GX2KkFRgKu6nGpzS9h5sw3?=
 =?us-ascii?Q?/Ib8GsAeXnHgLyMqoSNTEVF4h9rFcm8kBIRhDFP8ORwv7gNzm5lK5f+gr21T?=
 =?us-ascii?Q?NU2f1aSl94pnKTyRScoY72/GVpigTMcyOicEHoNfvIUdoeD3VEL4uXl6AEzP?=
 =?us-ascii?Q?nxuHaMRTyrOu5Ua4uZUJXWCCicY92etAGRLh7cQmJKg3OzAcKj08jcRJ/JjV?=
 =?us-ascii?Q?Y5bZaT8DbY2bYSMztqvsrmsR50bFoa2mfjXzDHdirytgaKff0ZP9uqRgeuth?=
 =?us-ascii?Q?l5kRrwev+FUAppWvEze/SxQwcflwCKv8dwt7/0nfsUYC8LYQxTXx6RU2U9qZ?=
 =?us-ascii?Q?6p2NM206kzaowNIdIWV6OjaVtK+rRVawF/WYxlJqx7S3Xo3SSdlrouVwPTDS?=
 =?us-ascii?Q?G/SJW6S6o+B6WwKTIQ4DpZVFVf2I4+h+nkrnCtKHGoQZiugDe0QZmEkv3CDH?=
 =?us-ascii?Q?vmkynucR4FjQAXTnDrFKwVIUw8hK7LBkFdl0JVzwBBx/O1wi/BA+Yot9xidJ?=
 =?us-ascii?Q?MQ=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d4edf0dd-c1a0-4457-30ba-08de22a9f961
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 11:44:16.7680 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: VRus+Jp1cEjB/oPm0OyfDoIc9zeaOWMEYjzgeus0Nd6eDftcLP7i06V7n3P8oVojj15PIfh0LN36OFJPem0Ofw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7035
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
index 3c3a1508fc..cf53ddf639 100644
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

