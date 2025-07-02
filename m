Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81C03C7EE30
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 09:52:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9DBC140E1F;
	Wed,  2 Jul 2025 11:52:10 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010045.outbound.protection.outlook.com [52.101.84.45])
 by mails.dpdk.org (Postfix) with ESMTP id F3A8640DDE
 for <dev@dpdk.org>; Wed,  2 Jul 2025 11:52:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XK3xCWcoyRgnHTy9w1+UN6mlOObHf5YQDSsiG5DPeWga33irm0P9vzVaO+3+/pyUs8veJ34pptDfKa3nOUou64tBXkJGb22cxoiYrjpLOu0x+NiOVS13g1WyNBgfz5QvJ/vYJ0DNQ3CB3xCn2xPMZkXpGZlyCAqdopGb6YZWDiFhXGVPEhdYVtI00PEKmFb/zkbga3u0r+u7+j2ftQchi3fxafD7DkgE3t+PAfFy2OkiZJlg5l9n19cf3RZ4iF4Dz6BgdxTWFXYq+eVjHh1jE5Tz4cMKclsd36AHiMDS+c+XzcC2wLMXtB11M2RPbsxmOUNkfTSd99nZePnNj4kZyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OmSEX0J5tESGcYf17uaAN3yOOQQ8T6gHS2KeSXdSDn0=;
 b=XXlK6IiHkSNUwUh+qkmz8ORGtPIgvh/+Z/ca01vJKcpf4Ef2+yaqNb2A5TRIS93e5ppkpR/I21M0ufgdMOfC2o9m8SCOkdZ+eHXhKJa5XscpMbnfXkYMOZrxFvfKoG7d/0ur45uIIy6Pu7tGW65w3iXkPxwg7qajZPZJkzcUg9Aeu+WlwXK2vo0IszicjV2u5bUDeUGYvL4CuO6VDHZIzXkytwmOUS8HsRCjyjabjOCP/jn7F6ogpFjC/UVvraVjWeMA8Dr/vDgDJCjuVihRZCRr4Bt2QnXJEaV5zXOiJI9pvhRtV+4yezJU+uiCawpiT2HqsLXVqWQiaS1A82LKUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OmSEX0J5tESGcYf17uaAN3yOOQQ8T6gHS2KeSXdSDn0=;
 b=W9JfvTaX2qgOr5vvaFtcQPvdawHJ3A6P2kUobHviCEqA/wnSrIIh99sD3i7nMwcbtM02kHVzzg6pmiEU9egf9W9Huw8dVT5jtPtIeh/ecUZDbcNNgsH/flNSC6m/NSsPnfDxPZav751onpei0G3Q8i2nvIuxMR6VKZNYDfwhqyDmbnFCFR7IGwetf+xg8II9AgNQ6dIsEp60fkWvN5UymwBtyErAG5oqQOq+gBtSPcmLcu50us/qGxmVDIrQ7P2fWTLNBOv1yFDb1kNa/oEA0+90gQzsoymuW669fDFrHOXhL1t/ik+jaQ453f+X6BcMkTsBGM2eF6LzKzGZ0N+PXg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by PAXPR04MB8473.eurprd04.prod.outlook.com (2603:10a6:102:1dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 09:52:08 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 09:52:07 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v8 5/5] net/dpaa2: enable software taildrop for ordered queues
Date: Wed,  2 Jul 2025 15:21:44 +0530
Message-Id: <20250702095144.3087250-6-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250702095144.3087250-1-g.singh@nxp.com>
References: <20250701042917.3000355-1-g.singh@nxp.com>
 <20250702095144.3087250-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::13) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|PAXPR04MB8473:EE_
X-MS-Office365-Filtering-Correlation-Id: 9a93f7a6-4fea-4bd7-ae78-08ddb94e1b88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KvYUi5VzhjMs+Zau1JzqNUZ1XGvFYRVpgZrj6MweeT0uRw3g54BH7JvxuVAD?=
 =?us-ascii?Q?Lu/9eq4f/S1NCt0ERYDt4NbZ7/kX4J8eH2teUz/tk0isf9LwuO720FmOQUXY?=
 =?us-ascii?Q?arwn0Yd+0DldnFF0SeEV5cq4zGhyU1I+4sCwxv0UXUeLUh9mkLkplx74dDoe?=
 =?us-ascii?Q?uhdIavNPjiiEQLsUsWa7LS2cgu/bG0VFCpHv/w7prg1tEDGapF9ivfN02v6g?=
 =?us-ascii?Q?A2FAsPTAPtitLEF2w4rplZ5KZsPZv8//wFbftcaSbGTNiIt+SOoywtoGk9p+?=
 =?us-ascii?Q?842H3/rhwkNU0Ov2vItc6xoSKDil17x4BX5Xol4owNG61S/IB/+olJ3uiuaf?=
 =?us-ascii?Q?GBJMnSGwPj8G/pGVnmaFNXHUHFE7icPmK0LSTfSr7batHg4Vnj+Q7iFrjJWL?=
 =?us-ascii?Q?Mw1z7H5rzRtZp518fG52Urk0mStT2VLEYUmspFaQ96cnaF3fqGZmVZWXLqB4?=
 =?us-ascii?Q?3PqyznQSh7TalnmdZQg4eAmriP799vb5XcD4mtc1qGKd01wLnanMeQZ3oHfC?=
 =?us-ascii?Q?lI52bkbpg0OXsWR8Ma+zKcYOCOTJz6VUjQ+8zjfXKkihmNaVASI+JeEeeHqn?=
 =?us-ascii?Q?SWVvRczgGA2BvLVHNg8hWTvz4UwBg9YpXZl4SnhA0aqVCDnj3gUMFaYxitQb?=
 =?us-ascii?Q?iv3K5nSoQIJKPK8tE7/5w68j72S9e6KT2bEZIZQ3M8w1PND7B+jBsYGlZbZ7?=
 =?us-ascii?Q?R/aPJEoFDdV5YK4kDPpnXmBgMDmqZXMEuSmDmjXQd76xvqG8Mg6HjF45GwHi?=
 =?us-ascii?Q?hTEl1UN9feWUww9FcejLAVbFOT0r8RSmkTfQTDDWL5IteuFgfcKY6N52pIVA?=
 =?us-ascii?Q?G5xu/loxZkCeZATDsYPvzSY+e0fdG/kppQkf4UH1MudZlEZswlh6c1jRKHGn?=
 =?us-ascii?Q?l4ZnEE4sZmXtWojGEcQD+Gd0bhsPGqpJIEbIWQ0wlbK8Bc4wEDrM764dCkdP?=
 =?us-ascii?Q?XkMz6nSQvyD9ava8X6YG9MSphNCWAJrKocRxOWe5PGOeI8T0yjaSeFRM4F2J?=
 =?us-ascii?Q?iz0hnDA2y9lK6db43Ea/pC1eb4oWbDjNIi5OqfN7SAN4k0HwjrYYb5SmYSHW?=
 =?us-ascii?Q?b9B6l0WE9ZiOLt5IBsSbIUSSAISIEWkqPlOMhDx+It6R20T5+hsmQFe7myo8?=
 =?us-ascii?Q?FN+OwoEmfKLpI+Tb0DOXbLdcDYseveFW8BLQQMSF46Syp/04ihn26SFInBRX?=
 =?us-ascii?Q?l5BiM+OWuNJ1iHyo6zBYxiFiroGhmPHJQExBhuKShNLlcZbS2JV7Q8B8/WXg?=
 =?us-ascii?Q?fKn76O6eMn06RHw9BZIMp2j/UzEjpzfCnNoeKkM292Iwsd+XHzaSp/kPz9A1?=
 =?us-ascii?Q?9+nFUN+QHTs84r1CZ0MmC8HD9XCeN3aad99X2D5ZgbGNXwXX7YhJ2OGEm/OW?=
 =?us-ascii?Q?HGHiRf9TFiDkaviRcF1EKY+eeURNJcom4apXOcgRIB9dv5vf/KeeNT+f/541?=
 =?us-ascii?Q?1+tWy4+Krqzo3CnbKZWJ0HOa7fmuQHxNN26LgiBgDjfaiPU7EYP0zqJyVSff?=
 =?us-ascii?Q?o5kOFznqSuav43g=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EzEaiiOHixDsUhedCef+lZubKOg9V+r+avTdHjfPiumg5zNpD39YVSeAbzKl?=
 =?us-ascii?Q?I6Mj4DzGBxkC6OZ0zVXg+zNngYuZaQV4yK+mIHU9pITfn1EcgxHO1tptaKrn?=
 =?us-ascii?Q?5W8SsIPWkXLZuUrwL1C+1oiidVEON/4BX37gPE3KmVZ/HBB54SFRqzIcmhN1?=
 =?us-ascii?Q?QH98PwiF/jjFgtGLvTX4dKPTf3a/e4CYW9kFa7jAQ3HV5YZvU0q/ruHOCl7+?=
 =?us-ascii?Q?7Lk7afqzJUd0oTXYVNifwFtNZc9rN75z00zpWccP4vis+xrmzYjutnnUFepL?=
 =?us-ascii?Q?65ESwTcj3NywFYvF6awmywtZgkGewWxkEoR7U4E8p+QSMH1KYt404x2YzXob?=
 =?us-ascii?Q?exooMDhhC1hCjyteJ9W1o/I7gKBsvKWNlrSWGTeF1voDnCvOy04kTJUro2+4?=
 =?us-ascii?Q?UU6bVtidAohQ3/2kaZpVzs7imJDOO9FBgG/6AS8ebDqMNWMy/uuj8kPE2mkI?=
 =?us-ascii?Q?x/CkY0Zjvyo/Ci3TBSYFndRvt7ZGBH1Y+J1s0HNdilt+wwdeWGrRdECDtPS0?=
 =?us-ascii?Q?wffZ+Ht3o05QOURi1UQ+24Lf++rnyDvmdJgzOsGUhQ+wgJL2abJ+peXvtejV?=
 =?us-ascii?Q?bP6B9a7f8IYlkSIXiWv35tX3JwmY05QLF2zRVJdqK2TZZEe1d5DxBxKaXPD4?=
 =?us-ascii?Q?ILZhP/WiekQcjGEkYgGcs30G7cOOQztdP31wAFildLoA1BUqPOxA0fkLfNvJ?=
 =?us-ascii?Q?5qBwWCzu1RDkRrEuRvh6Vxm/fyt4W18JlnG+x4cQNz/IMBgxv63q62fAyfpb?=
 =?us-ascii?Q?HPa9PHvTipkptMoupINUfthF7rbuRnMxnUHdx2ggwGfY1YdSvixa6KGdxZC8?=
 =?us-ascii?Q?eLkjX7TwfAe14Wyxa7P/Ayen7P03gwSBpGFpikPSbpwATpHhNFID24cmx0CY?=
 =?us-ascii?Q?zGcZWzq7/obhsd1bMbOpB1T7wTdC4JrfX8yRXtVkHzsKRdzElMXaHaMZLRf2?=
 =?us-ascii?Q?N1LkWDVP3DX3vItXGeNjVg1E7Xi+evt9Qk7pDMEeZyAOl7ZxmQ0SZU3ixB+Q?=
 =?us-ascii?Q?fphJ/cNCa/a6aWlLiCKHay1c5M6D1Bhc5G2YCk2/CU29Nct2//nDDONyItUE?=
 =?us-ascii?Q?oZyzfQtG2VS1RfECUId/2xPwv4VjlfXM6jj8rNwWTikO3UI3/PXuYFH/nIfW?=
 =?us-ascii?Q?m0qW60n4aFFSSJ903rZpKQ2b0unQc323Qy8nvACJRWPrqdcXE8LlU14kjvkE?=
 =?us-ascii?Q?NziQ8X/ITCeM7k6xZYQ0/CeUdDjTRJJfzrB8X9H9jrqneRDa53renYFbIwL5?=
 =?us-ascii?Q?pNvi0C+Uk6du2PaMZjzGUXXBE26dRb8lqnG6TGREjVSaPQ1pGzG6U5tHa4iB?=
 =?us-ascii?Q?H1wiCXLObcibdU48ySCULoysmDVMjrkye2yit2sbSpKRxNYNgowiktJeoRTP?=
 =?us-ascii?Q?XrA5wwH+aTaRfh7oNFf+amd9qxMJfIPAgCSrLty9zHpLo878YizTP0gsmeXj?=
 =?us-ascii?Q?To8QbbE1L1kRcClphtJvWiUdbfwZFClEGdMc1toC/MMRYV40onKr5Oo6Yk5X?=
 =?us-ascii?Q?PkdIfUhuQeBaqiqm/vHuvnF+USpbImIYR2zyYtBkuqy+Sl6d7a+MDcSZ+nYr?=
 =?us-ascii?Q?RBGOAHBvFQhXMQZyjvM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a93f7a6-4fea-4bd7-ae78-08ddb94e1b88
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 09:52:07.8699 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zT3sWTWWxr0Dgf54TwYcaqYZD/+lmNy8ip9FeN7y7Nup31nWNds4O1qvD4NtrHgM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8473
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

This patch adds support for software taildrop on ordered queues
in the DPAA2 driver.
It also enables congestion notification by default on
traffic management (TM) queues,  which is a prerequisite for
software taildrop functionality.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 doc/guides/rel_notes/release_25_07.rst |  3 ++
 drivers/net/dpaa2/dpaa2_rxtx.c         | 18 +++++++-
 drivers/net/dpaa2/dpaa2_tm.c           | 60 +++++++++++++-------------
 3 files changed, 49 insertions(+), 32 deletions(-)

diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index b75405edf6..8fdc27338a 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -160,6 +160,9 @@ New Features
   (including out-of-tree nodes).
   This minimizes footprint of node specific mbuf dynamic field.
 
+* **Updated DPAA2 ethernet driver.**
+
+  * Enabled software taildrop for ordered queues.
 
 Removed Items
 -------------
diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 67d065bb7c..5bd377d4e6 100644
--- a/drivers/net/dpaa2/dpaa2_rxtx.c
+++ b/drivers/net/dpaa2/dpaa2_rxtx.c
@@ -1800,8 +1800,11 @@ dpaa2_dev_tx_ordered(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 		while (qbman_result_SCN_state(dpaa2_q->cscn)) {
 			retry_count++;
 			/* Retry for some time before giving up */
-			if (retry_count > CONG_RETRY_COUNT)
+			if (retry_count > CONG_RETRY_COUNT) {
+				if (dpaa2_q->tm_sw_td)
+					goto sw_td;
 				goto skip_tx;
+			}
 		}
 
 		frames_to_send = (nb_pkts > dpaa2_eqcr_size) ?
@@ -1961,6 +1964,19 @@ dpaa2_dev_tx_ordered(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			rte_pktmbuf_free_seg(buf_to_free[loop].seg);
 	}
 
+	return num_tx;
+sw_td:
+	for (loop = 0; loop < free_count; loop++) {
+		if (buf_to_free[loop].pkt_id < num_tx)
+			rte_pktmbuf_free_seg(buf_to_free[loop].seg);
+	}
+
+	/* free the pending buffers */
+	rte_pktmbuf_free_bulk(bufs, nb_pkts);
+
+	num_tx += nb_pkts;
+	dpaa2_q->tx_pkts += num_tx;
+
 	return num_tx;
 }
 
diff --git a/drivers/net/dpaa2/dpaa2_tm.c b/drivers/net/dpaa2/dpaa2_tm.c
index dbf66c756e..36e815c356 100644
--- a/drivers/net/dpaa2/dpaa2_tm.c
+++ b/drivers/net/dpaa2/dpaa2_tm.c
@@ -611,41 +611,39 @@ dpaa2_tm_configure_queue(struct rte_eth_dev *dev, struct dpaa2_tm_node *node)
 	}
 	dpaa2_q->fqid = qid.fqid;
 
-	/* setting congestion notification */
-	if (!(priv->flags & DPAA2_TX_CGR_OFF)) {
-		struct dpni_congestion_notification_cfg cong_notif_cfg = {0};
-
-		cong_notif_cfg.units = DPNI_CONGESTION_UNIT_FRAMES;
-		cong_notif_cfg.threshold_entry = dpaa2_q->nb_desc;
-		/* Notify that the queue is not congested when the data in
-		 * the queue is below this thershold.(90% of value)
-		 */
-		cong_notif_cfg.threshold_exit = (dpaa2_q->nb_desc * 9) / 10;
-		cong_notif_cfg.message_ctx = 0;
-		iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(dpaa2_q->cscn,
-				sizeof(struct qbman_result));
-		if (iova == RTE_BAD_IOVA) {
-			DPAA2_PMD_ERR("No IOMMU map for cscn(%p)", dpaa2_q->cscn);
-			return -ENOBUFS;
-		}
-		cong_notif_cfg.message_iova = iova;
-		cong_notif_cfg.dest_cfg.dest_type = DPNI_DEST_NONE;
-		cong_notif_cfg.notification_mode =
+	/* setting taildrop through congestion notification */
+	struct dpni_congestion_notification_cfg cong_notif_cfg = {0};
+
+	cong_notif_cfg.units = DPNI_CONGESTION_UNIT_FRAMES;
+	cong_notif_cfg.threshold_entry = dpaa2_q->nb_desc;
+	/* Notify that the queue is not congested when the data in
+	 * the queue is below this thershold.(90% of value)
+	 */
+	cong_notif_cfg.threshold_exit = (dpaa2_q->nb_desc * 9) / 10;
+	cong_notif_cfg.message_ctx = 0;
+
+	iova = DPAA2_VADDR_TO_IOVA_AND_CHECK(dpaa2_q->cscn,
+			sizeof(struct qbman_result));
+	if (iova == RTE_BAD_IOVA) {
+		DPAA2_PMD_ERR("No IOMMU map for cscn(%p)", dpaa2_q->cscn);
+		return -ENOBUFS;
+	}
+	cong_notif_cfg.message_iova = iova;
+	cong_notif_cfg.dest_cfg.dest_type = DPNI_DEST_NONE;
+	cong_notif_cfg.notification_mode =
 					DPNI_CONG_OPT_WRITE_MEM_ON_ENTER |
 					DPNI_CONG_OPT_WRITE_MEM_ON_EXIT |
 					DPNI_CONG_OPT_COHERENT_WRITE;
-		cong_notif_cfg.cg_point = DPNI_CP_QUEUE;
+	cong_notif_cfg.cg_point = DPNI_CP_QUEUE;
 
-		ret = dpni_set_congestion_notification(dpni, CMD_PRI_LOW,
-					priv->token,
-					DPNI_QUEUE_TX,
-					((node->parent->channel_id << 8) | tc_id),
-					&cong_notif_cfg);
-		if (ret) {
-			DPAA2_PMD_ERR("Error in setting tx congestion notification: "
-				"err=%d", ret);
-			return -ret;
-		}
+	ret = dpni_set_congestion_notification(dpni, CMD_PRI_LOW,
+			priv->token, DPNI_QUEUE_TX,
+			((node->parent->channel_id << 8) | tc_id),
+			&cong_notif_cfg);
+	if (ret) {
+		DPAA2_PMD_ERR("Error in setting tx congestion notification: "
+			"err=%d", ret);
+		return -ret;
 	}
 	dpaa2_q->tm_sw_td = true;
 
-- 
2.25.1

