Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBACBCD5BAD
	for <dpdk-dev@archiver.kernel.org>; Thu, 13 Nov 2025 09:59:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7E2840E27;
	Thu, 13 Nov 2025 10:59:46 +0100 (CET)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013048.outbound.protection.outlook.com [40.107.159.48])
 by mails.dpdk.org (Postfix) with ESMTP id D08B740DFB
 for <dev@dpdk.org>; Thu, 13 Nov 2025 10:59:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=in8/C1g7rkoR8jCKzqKnX+B76hbPtblJDl7fQ7p98IfMoH6e8LmWvqmZDv/QxZaKduKv5shlH4G4VnHMFRmWCGfUFyX92wLNQBBXg8UGlUxq6pUBukQrqijz2k2woa/quCoBARO+u16UoYNNN4DQaLV66dTW/nR8lrDYZX7f17m83HzeD1YPPem5q3jB1Dn0gwveVgZob/SW94ct0Uw6uHy+2y2iqvaVHRT1VlBb/I0BJaUD4pgpfdOe4dmO3FjvHYkbM4dZ/cRByZw9Sk6bBOSiLrIJyIN+Ga1h5pxIGmymagals/TEVgzyZO5p6AYnpK6OJesAlFJ1gaEbTVLUuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g16oNUNSXxwD45uSB1I032QfdntXoNvDZb0JtO222ts=;
 b=CwXzdEBuy0eIieT1zwsb/LLURZjASkQ8bGk3UIGHqQOuMqG89DV5UACI4jaDosDwzTwz2ByLHOj3h8AugpRnVx7ZfB3YKdFYrZ+Ug34dtOfBtaBXEv/Xla+MZd9B6sh6YrBv89V2KurN1hGtDYaHPxW/LKC6lL4AzdG+P8BgVVPVIW5LpXdh+Y5vRygzqPFxLNvhO093OhanRII9wKRnpeh4lMvTEAg/Qbntsn49QapJSax3rJaaqDReT8HPwGc+mvZOQJSdsDB7L+ZSuvQDUiNE5X10abpIZ8cSrYAb3tMol0BiAWEfPJeGV9VR54Yyf8lGYYBKsIJVTs2n9VMENA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g16oNUNSXxwD45uSB1I032QfdntXoNvDZb0JtO222ts=;
 b=Ei7dB21ba3bHC2Ry21nx71V8BPm6MMPZEJBzgU1rr9DzqM5A9w76oABGLR3uHDV4dEB6beJE+sSkTICtNB7kjVijDs4viBxQiHTfr/aUnLPv1J2e6HnFO2/rMQXwtM5uN7pTItHsWueHn9jiNsOghvdCyF0LnaUfQaxB+Q6IG+PFwVDah7chovEcUFv7KJnVfusJjOSLjVnpxIDeMrLDanJGJuMJw79281w8JQLYoyBjKBXI5+N+N/7EMjYWc8Hww+wtV0J17nGtslvexnaPnMP4Jr9PjQ/nU816oiM7DYcJQgz5Rf2gUFucSHkFebtJQzU7/bBciuQWe2t8tYgDLg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by DBBPR04MB7530.eurprd04.prod.outlook.com (2603:10a6:10:1f5::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.17; Thu, 13 Nov
 2025 09:59:43 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 09:59:43 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org, stephen@networkplumber.org, david.marchand@redhat.com,
 maxime@leroys.fr
Cc: hemant.agrawal@nxp.com
Subject: [PATCH v3 3/4] net/dpaa2: fix queue free cleanup
Date: Thu, 13 Nov 2025 15:29:16 +0530
Message-Id: <20251113095917.1973514-3-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251113095917.1973514-1-hemant.agrawal@nxp.com>
References: <20251113052931.1784953-1-hemant.agrawal@nxp.com>
 <20251113095917.1973514-1-hemant.agrawal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0008.apcprd02.prod.outlook.com
 (2603:1096:4:194::12) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|DBBPR04MB7530:EE_
X-MS-Office365-Filtering-Correlation-Id: 555f4828-bf03-4880-2630-08de229b5e0a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|19092799006|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?cSnGGOBUIPCfqkZElqVoshy4+2Ai+B6f7n7NpoP9QpepaMnsgxyCVA7Z6Hm2?=
 =?us-ascii?Q?j/2/xXT4X4JvHZYjY90TJQcYeprkgrB2K68oQXBY5AJgZ/iHK4o8lOlYuy/m?=
 =?us-ascii?Q?mQ1Z9L4A4f+OsB0EP4qUGGW13APOAf9FjPCzmpYIetLrbmr+enX5TQ2HBc/D?=
 =?us-ascii?Q?gsJXRVqCLakE9KzAyabadsoz8lCNJLWnB1m1ln6FEWf9IpL8lxpNndAdh8Hz?=
 =?us-ascii?Q?BgDj+I0i4dOJAs3YaGsLV0o3QbEx5nf6S562qntMvxWVuBeazCEuWu5iClLq?=
 =?us-ascii?Q?0yCfvM0Tl2YxpTVBRSv28mvEMNB0/rZemJwCT66p/3HIuWe7HLnLOlsgqUUG?=
 =?us-ascii?Q?AlYo1v0x+nL8TviR7V2PMoWE5lJMEYhwJ2NdfLACHcE2mszaRTsYN7+9KHFW?=
 =?us-ascii?Q?sge3YBHxENOYolMY7HnPqJNoP5EOZEDJmId/sLHrUisReIa50ej1Y1Gpwkzl?=
 =?us-ascii?Q?Cc5C83fbmnbQ3T0dFtGsIcZ5tfdldq/vfnb4XxQvsrAQG3qnA9lV3sl6kmz0?=
 =?us-ascii?Q?UZxumfZtLOH422SemFDKd9tmlL+A+tYFI1kZNvX+ysl4Plm5oi1EJ9ihtv8e?=
 =?us-ascii?Q?pkFEiJoduFLT+TqKCoCHzxWEmLjmf2/lpI96NJK1+TkRUvTomCtr2Jk3Am9N?=
 =?us-ascii?Q?n7nXzDkmWzr3rhuAQm5VeAFCzMUSkK33n0jNDsm43OS679saBaqy5zz0VMVu?=
 =?us-ascii?Q?URkq2XdlCIoy9B94qPd2AGBluSrE1Kp+8U+AR28HeQ8j8euaO4RdxmyWz14X?=
 =?us-ascii?Q?mE2pmvhpKbMZ/P5C5ZDrfLt61E6OMnoNDCci1v950xzOCbRl7JrbO7CnhXZo?=
 =?us-ascii?Q?Y3hWRLw0H5+SoV9T/WRpu5wMBJgB8HRiq1e2K2ZFrfaI4lZo5pfiwum0UwcM?=
 =?us-ascii?Q?60sIwCGLfQBxNI9UHe97uhix90A2Wng0dCUU80ja3FXn054csIOIuwn3S51g?=
 =?us-ascii?Q?fQdD5aet1gdrIIz6H/tCuJQDU0qvBATTWZmPEnXAT+bDraLXlZ6JkvFBKVTK?=
 =?us-ascii?Q?befmxlm6B0RxL7pMIfJdJaiwAMJMwt7Rk/9JdPxUQUR0xae8rxutJnpC4IH/?=
 =?us-ascii?Q?GFg+2ZctxTO++Cq30IM9UnjhjgFCjd0tkEs48DE5UW3V+s91jKxmC0ISVYF9?=
 =?us-ascii?Q?ZkdSaR+GDoo5R/cWoXnuqeY+K10NZ5EzoROHYq6jtOon3gFUzHm/lbfhC8en?=
 =?us-ascii?Q?+PP1cVMYY0tk5iftIvcvHeYcC3xiJHpw/ix5IqW3fNM/jK/7RCRf5KFB/Ivy?=
 =?us-ascii?Q?47dP7vsKyeuAen53ijS/v1pDOvF0jkdWvJ4bGBKGJGhQrCpVBV5SUmgIJ6w9?=
 =?us-ascii?Q?RcmujSCAo2suPpXZGjbk1cTMCfpcEvKgb+HjCvU93gY5Cyp/R+tPn1CJwU16?=
 =?us-ascii?Q?qYesjlFo/QW9b2M3O/kTUHGWvIm0JbSJXaZ0v6Fi2kVigdwg+U3FqEPPCMY1?=
 =?us-ascii?Q?kLiO8zfV0liwkbfhkAyCbO1ifb9K0zKhjR0BYFjBVoCdJvObBoDlL/fT37po?=
 =?us-ascii?Q?ySLQFgx+hXYuZE3thOhVI+6X7ZH/Pfj1R+n9?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(19092799006)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?o47CSgqE8ZGJLhJpxRBn6tR2jJQk2JwCnJdxTENSQRvNb4SqePhH0BKo01Dl?=
 =?us-ascii?Q?nQRZV8KuM7rkrtHn8kuIBxh5izgJhj6/ZAzrzT70kd/ffHI+DZturPru7e+j?=
 =?us-ascii?Q?HB2GLwuY0eV7qNJyD603OPxYSOC6wVOD9f6KOYi0gw8yNAqcyv8L1yGqrlBR?=
 =?us-ascii?Q?JLAKV34aWar+phAJQhywQv/W5w+TFMQLoGVMdUPHMFCpjJRQpc9gy2G7bKh0?=
 =?us-ascii?Q?+RryF+uiJnUTMU6bQfBsnolAEJ82gf02AAVsovTV0Jagr5Zq0Phx+4zl4n6G?=
 =?us-ascii?Q?8qA6Wv1hhOcF8EWtupgsD8AQ5Cm9xvb5bq07qwUciThCcaRahcX/7si8V1Xr?=
 =?us-ascii?Q?hyLrC0j+kyCoANr/w249+SzppE9tXwaAwrsiiOYWaN80FNsQszH3CtCwXecZ?=
 =?us-ascii?Q?D+6tkJAt0c9814La5LPKkKGWh/kmGt+F8QZdLdWT+U8vgixB4YDJbM07RwDJ?=
 =?us-ascii?Q?fopQHuylZSaQuUNqe4jFX9MdZomy0XpEYepoxmR6nwfd+RTqaVmQeLpG5Yez?=
 =?us-ascii?Q?MhMf+DaMxR9RGQvlr6aZJ3ehk8qNc3I+8dOvhKNt0BoC2YWWaGrjAoZtDOhp?=
 =?us-ascii?Q?ecTVT05+RMt/7Lb45mC0PkuTsXM5iT44MkSG5eBrDYEUyq7Q9Tm5olakzYYX?=
 =?us-ascii?Q?ICW0JVr3XluPGFAhlgudtLFr0r35BmTW9XDBzgOPkUPYnbAYwT8zudhwirMn?=
 =?us-ascii?Q?Yz4LZMuWQdLLyn3LXC+D3gyRQ9cCxmGgVopBISBabkpqTtI1+AT+KdTLoRLp?=
 =?us-ascii?Q?prDBne2qJVYzC6mNpnWyQdwI0956vrLUT/z/Inv/PdWzx6pM2Wq5y9Ret0Sn?=
 =?us-ascii?Q?37zY8M0kbAJB5Vm9tfEgDdD23EGXS1In26A+myyzDGtFnnl2WJdDYEhQ4+E7?=
 =?us-ascii?Q?YS6f8ydKOR9gcvuRg/aoojQ4LuEwg7YNKsICRb99PuwOy0hDXklrYrprM9JK?=
 =?us-ascii?Q?nPrD2HgZ/n0tvoV8dlqQTK8R1fRQ+L9i5M0VWDZhzCpTGSIjenBlYfGFwE+m?=
 =?us-ascii?Q?Vh2weh5gWWdckqlKAk6+ytjgFXtBxhMP5Izq0MHQoMk5FgZf0BTMTkt3R2lN?=
 =?us-ascii?Q?ffWUeafm/kOn/KRT7nmR73CPqiyv1m6x9Wvn2GlNLqjI/4deQbNmh643BLbb?=
 =?us-ascii?Q?tI/97ePO6xRc9H+Ci6JSocLWIME5Jsk/iAcWyCdo9LlPwMP8aqAv5qwUrvrH?=
 =?us-ascii?Q?Mt+tB+oqxCRdWdj934bQLLjh/NQZMcYC4a3xOatA1lEnNh+pRsPK7KJOtrsr?=
 =?us-ascii?Q?LIlc6GKI+8WJr0TMkEk2MQP3zVFGvXb9BXsM73goY4DXTpMOEdSTqqFm0XUv?=
 =?us-ascii?Q?6jI5HbGdVSMIRZKJjvJEUz4GqD+DR4E5CmWpE0kwuKs5y44NPY84qTnIRPEc?=
 =?us-ascii?Q?JsmhuTPnF7NeVhghEqK1RZSiPdgtTgLSXLblNSL4qR+64Ss6Ki9EGmbB3ovS?=
 =?us-ascii?Q?qwS/RGRkFdgFShu2z72YFhPmhSgohetPWeI+h23nK2fDxsww29pM4QBtP8In?=
 =?us-ascii?Q?n5jmsc3ZHK5B2oxVopwsFYqZMJowVb/82ggM52lVBf3iaMJ+730gaXftG6hA?=
 =?us-ascii?Q?SDkBdLwev3d+P/x1/zWbip7snS22HLPzDbtGD15ZZAbHHUwE2c0W4LX1i6oe?=
 =?us-ascii?Q?vA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 555f4828-bf03-4880-2630-08de229b5e0a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 09:59:42.9724 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kVH1EtHU6tEnr5a8gdXpAGFfr+fFwe4wXanA3gTLLU/EFzENvoakBogpaJh/mvZIZSO1xFwVNs78lgl9R/wzfg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBPR04MB7530
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

