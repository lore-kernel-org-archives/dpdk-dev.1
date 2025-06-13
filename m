Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B242C71148
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 02:13:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABEE142EB7;
	Fri, 13 Jun 2025 04:12:11 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012057.outbound.protection.outlook.com [52.101.66.57])
 by mails.dpdk.org (Postfix) with ESMTP id 4EBD142E95
 for <dev@dpdk.org>; Fri, 13 Jun 2025 04:12:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1geKFbgJ4CHf6YZm44vhQN2p5iqBsNmPPRwaMWsSevWD43QznatscJ0OAklw1EcP/hIKcaM0lMZW3bz9p9K5L/T4mIruFg3+1/Ui5KbSk/DQbBYAG6RWBUFZ2y5/XywUVa6CZSR0gIny0COil7pjZ+0/kcQHJCwqyR9J6K0lqkzP/95rPF3Otv12EY0cqUG9Zjy+JNgyFP3wNGCfWizydvoLfQACmdrPeaxK1kjVQPzbOS0p1TRu6bDBmEJsG833vQsjV7ha/scRxSbcmDLPn8buFosQkqKeBO/DveYpYyyrmZrs29RmMA4LwTNC7MZQ0bdHbivRgFtTs1iP/j1hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbSMG935nAQVsn+w1fPas4D+XjTS3RLSPabxBnGNq8A=;
 b=Ldf9mW9d1izjKFsH+eMYtZLTR8fc2bxPewaKSF4IOS809C1DCZY48B6WuijHRhrceP7yMpIsB4iX1mHSUz50OFvOD2qSdLBfn4csNQqIGZvtoPJw/SKoNr5Ac9jpDdwnk2LMuC2p+UmzpBPsqC8ZywgMapQiAJd5KNEH/sX9ZD4xGoB4mrIdoAGd2sKAUyva38wVStc+Bc2dZEvvvu5+OqvGfnlNRQn9JOW18NELk6pkbzuEWLWaMHLlko1Lp6E3k9VYApVyDcvf6D9FJE5aYe1tvIri6RhwRvKv5IKxEGhAxYLhzLUlkb9fVRWKj/YdoaSlk2qc0/bU0gSLVMMD8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbSMG935nAQVsn+w1fPas4D+XjTS3RLSPabxBnGNq8A=;
 b=hXSgTX+EZIYRF8sricYAywgungvEi95BDa1SVcmVVn+vHnPQnPwX1FosuynYkgbfJOGvXnhkYF9iBr3OMPmPrnJtY6BDzIIQgiXeDI6V0PtVt6e6ZT5ocpXSWq5v8y/IX3mcY4H6UJNi8HngsGN/AE0/2DXJY5CcSK5fN72x+89anph5TjD917P958W1YcmU4jUkS0trjOQpPKsEaJwTZ3gne1YPkmiNw4ihkOFdGOsxv5WGF1BDJF9x0vX3hFqdk4Wq1beWRJk9CpqeG81UCpRiVfiTOKkj6Rzid9wA+bWNZqEZUHqFUCvBbma1KI4FqXmUQwk3a4BnM/nlRyZJiQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by DB8PR04MB6907.eurprd04.prod.outlook.com (2603:10a6:10:119::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Fri, 13 Jun
 2025 02:12:07 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 02:12:07 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v5 11/11] net/dpaa2: enable software taildrop for ordered
 queues
Date: Fri, 13 Jun 2025 07:41:25 +0530
Message-Id: <20250613021125.790614-12-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250613021125.790614-1-g.singh@nxp.com>
References: <20250611105149.655144-1-g.singh@nxp.com>
 <20250613021125.790614-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0124.apcprd03.prod.outlook.com
 (2603:1096:4:91::28) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|DB8PR04MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: 044aedea-301a-49f3-f57b-08ddaa1fb26e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4Gf0nctzqrMOxg0RigeGypYWVSMQLSjBvy6RXAnYlaMbM0V5ZgLgTd4pmnMn?=
 =?us-ascii?Q?jL7vZ3vUt1WE5jpr1GUiGr3807Gnhgf7Opv1MS0UsmkS3tolrMorBCCm6nFZ?=
 =?us-ascii?Q?nefCfC7U1gn83Z8w+y/uB08jXTEpd2dby2DA+x7o7uw5V4SuPq7tkHk1TE3/?=
 =?us-ascii?Q?PjIR/23BzG6RGg1qwFhrbgLwJuMex6Nw6PIGu8oKUvSGn9Vo+1cDThCyCzCp?=
 =?us-ascii?Q?Dmky8V7ezTb0sdnpXfXuQP6qDuHlfPYW8z3NSb5J9ghk+/JDm83N29Aay+K7?=
 =?us-ascii?Q?HM+ZVz+s8CNDL4QakTlwYG5Z0/6tGmDvfPi1C4LMWRlMXHqF7+1e+7iGyB7v?=
 =?us-ascii?Q?+OHIZ4UtMc7Tm5SzzMrFT8qWdlB8QWYRyYgnRG8KnrQvHgCwPEjKUv7HkzrA?=
 =?us-ascii?Q?sQ8YBPz/qDZs5Y0Z7ShhbhbY/nGKUE01ziXCObR19iQRLLOSy6OzAoMdcyx8?=
 =?us-ascii?Q?jPypccyhawNT1kRP3usfgf4OnhCFaH1/O9J1QTDqTjrpobHBee+GUH8/deqE?=
 =?us-ascii?Q?4ShGUSQSLVQC/26BVD0U/R2P7nQqteX3KpCjN5nq35r9Uz3BJEMt4XOKxoWk?=
 =?us-ascii?Q?YsttLfZE4anjuKi5axo4xiHJdAQRF8cQu0cPaUPf8gLwQ8jxyD1NIoC24Q01?=
 =?us-ascii?Q?VO8v6LTEZvW0ZrMyIsMSLznebB0uYFNIqqh/XEv1eTcdHudTAKJXHSyvW0VQ?=
 =?us-ascii?Q?9ocaYlQ85niZtE0BAZSuMGKSiTMZFqZvduyMSC2gV/7DRabIQbFxorwFJ53X?=
 =?us-ascii?Q?d6KiJgIqDANUiIAJPStc+jA2u71O7VEHcrcot/rokJj9jyvGpJ7hTq0I+O3M?=
 =?us-ascii?Q?R8HnW7PHVcnNdYk/L3MCPTlf9f8ubvq5ddUr+bm3DXzdCQDB8L2+8YQqA4XO?=
 =?us-ascii?Q?BvOjgZhIhQETIA48gxafFDkAM/EPK5oZ6d6TDeGPqlQH0it7PlN5exGuEEG9?=
 =?us-ascii?Q?ZPybd0s07t3FZjR2ARReufe3sHOE6itNtsnwAMJ4tfwQEILPDrxPdnDcAJbk?=
 =?us-ascii?Q?7aMdvp+gxsxCL+gig9Ol3rvmX+efmJhBIK6ZdqjdG6iY3xr36eSbDlgYe9PD?=
 =?us-ascii?Q?VAav9/L57RZ25O3MGMXqMsm3tyj8TfWZKH1NvYbmYiTXniG4qdw7iOFs9peM?=
 =?us-ascii?Q?+UHebb5vv9tEZ5a9+tZ/h8P1hYrAubSbAZG2ymKG9ZkZ8hGeAB/EA/XiRZ8B?=
 =?us-ascii?Q?CnQb9jqj7W9XqdL0nw0Trj6FTZw+asVRX93Z+TRGWLjnu2EqwWyDj4AE4ANV?=
 =?us-ascii?Q?30QtWXdLQoVjX3nKSOEU7qZ60/DuudCZVZ2yVvdPlAClDDfe26gW5b9gSYP+?=
 =?us-ascii?Q?QCW+oQaUKranwZhLwdOnDCKYsJ33OHZz0Y/Oki0/oKUOITO9Z6cRlivh0+sa?=
 =?us-ascii?Q?j3CWZENhIZlpR70J1lP9xC0NQYAXKUhBbH2PEZt/REQiYWsV0Murp7dUiwij?=
 =?us-ascii?Q?LH0aMA8Yh5xCKJwApGnu0h1dfOVgSgL/jDYkbuLx73EAYJIEOL6chg=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ioWV7oyOz6fwBnChbx2BeE5UnZDqO3yP6ArhtWG0EhKUqQOWdiZqWZZhv0kH?=
 =?us-ascii?Q?EKjJUIBIsnT8cAKGwoif7YQFQS5cYW6FFlyjDUqWU0hzoi/eykgvamDA6vnB?=
 =?us-ascii?Q?zr/wY6pofFIJ33v1SY+f5HDhqO+r1u4W8VW+NZwelwZIEF7DB27+B9jV9iBC?=
 =?us-ascii?Q?EUhaJ57DRdoaYcQB6F1PsrrweN0IMNYs+Kfub3eLzyJmSF+Cioftog+VETTk?=
 =?us-ascii?Q?Rhv41U2hsKS95Fnu3kQK5E5pEXAGOdfrWzVeyYTwK6dmixP9AbPdWBtBGjdc?=
 =?us-ascii?Q?kXJr5OKpGzwErSJWrPDJrUyvFU5OzFwZpf4PaP8vDwx8D3E8jHBfuXFOFC1O?=
 =?us-ascii?Q?cc5MTd7odeSh4GoC9PI0t8J/LDVoPnHEo97nEloPRJ/OaB9t/oNwVyJSibxL?=
 =?us-ascii?Q?IOf1605Uw0JUGGNf8nFcgNi7P4UBISbu/4FPVCrGzQu8LhnRPPJejHazkj15?=
 =?us-ascii?Q?Ys1Dw7tvA3BfUH7KOr0kjjBy6cW4io46CxawHlwvwtj9HhhCKc8WfqdAyBQ9?=
 =?us-ascii?Q?K0h45qtKlRL3rk6v2Y8sUzeTjgv1XUczqT5TUDHMTc69TmQ5LqbGXYTv5AWP?=
 =?us-ascii?Q?CUD0VheBDNpXKHmoZXnzNi+qgiuAjnCmx/PACAtWMsFLy1fHmYCWVCmraDMu?=
 =?us-ascii?Q?L7E6BFs4NSRsT/NfrIYdAGW8bWJ/EdEfRSNbqEKlFSRwf5Liv4GFZLgJ72RX?=
 =?us-ascii?Q?QF+JXanYpZNyLbN5Jh8sWOxYIWBFu+V32OZhNqDejBtNB0lQ2rXzdFFDhf8V?=
 =?us-ascii?Q?Ym182Kywm7DOCb/9wFLiZj4u7Co0B0uAIOnuL+PqU0CRHotF2NQuAluq7lnt?=
 =?us-ascii?Q?aZB+Af4u/NW348K2BMdLxOTnh/NX7jBbCHL9BwAiDvVcfM+UJOIg7NY/+PLH?=
 =?us-ascii?Q?n67oJtMiv/bFgcdWstNXosHZiguxI1oGavrytqVE5TPCtWw8bZGOyVO1Epvf?=
 =?us-ascii?Q?cCsWNIxpC+ISdLg54mKYSHjtlbDEaQw0s8ibyN4SoJwgXcvW8dhKYTxRltnG?=
 =?us-ascii?Q?O7x2VQodoARV7+vH7lc1nRWiyKD0fvbkdNMdJmWkyk/EjMSIHOV7vYakcwX9?=
 =?us-ascii?Q?Ky7xFCKEevNdSxvqVVXSnIDbIfor+0FwBKdDB56lwgHq/xK8aF8ecnia5aFh?=
 =?us-ascii?Q?Jg0uLm6NeZrxrcrs/rblZaWi6Uz/TuZPDYV6DGWDHTZUR/Ll6Ff3NSqlrDz/?=
 =?us-ascii?Q?n9byYa10ugbtCdxF/yJa/+1onpngBhor+Rng1EQ0s/p/0CDeo8KociZXCaKz?=
 =?us-ascii?Q?jRzP7WbkJ2/k4qgLaxlRrOZdAXDWKpNMehk2MQ1C1VpOBpq+3H4XpwfmRh2b?=
 =?us-ascii?Q?817MGVL146hYJigjAgebuXZgIfBtwFuScwyDr9QTezTjQ4W+6XfhzX6KvFgh?=
 =?us-ascii?Q?3RK0miyYGTIQZq3iywAV6PXxSTAsMb2Lya1DZ25hfA5Jx/80Z/D2gb7KCDAm?=
 =?us-ascii?Q?Psd5Ab+axvii5vIEwM4oboWivH4Ljyd466BpkcIdAJvW6fPj9aATpQ6KdM+K?=
 =?us-ascii?Q?gpVpk035BjeIxWWiwhVRERabUFTNcxWozJXwaPgpYhMn7i+sl+R6bPJEq3xf?=
 =?us-ascii?Q?2KMgS1z4XegcwuxkfQc+mS+vYpjMbFwYwFCBGToY?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 044aedea-301a-49f3-f57b-08ddaa1fb26e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 02:12:07.3355 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: J5Rb78/bVUCBr2qJv9rlOzer5oMAVPV3Y0DFgOcDRIOl+avpeGjmJibvHR64ODDn
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6907
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
 drivers/net/dpaa2/dpaa2_rxtx.c | 24 +++++++++++++-
 drivers/net/dpaa2/dpaa2_tm.c   | 60 ++++++++++++++++------------------
 2 files changed, 52 insertions(+), 32 deletions(-)

diff --git a/drivers/net/dpaa2/dpaa2_rxtx.c b/drivers/net/dpaa2/dpaa2_rxtx.c
index 67d065bb7c..dce1da80bb 100644
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
@@ -1961,6 +1964,25 @@ dpaa2_dev_tx_ordered(void *queue, struct rte_mbuf **bufs, uint16_t nb_pkts)
 			rte_pktmbuf_free_seg(buf_to_free[loop].seg);
 	}
 
+	return num_tx;
+sw_td:
+	loop = 0;
+	while (loop < num_tx) {
+		if (unlikely(RTE_MBUF_HAS_EXTBUF(*bufs)))
+			rte_pktmbuf_free(*bufs);
+		bufs++;
+		loop++;
+	}
+
+	/* free the pending buffers */
+	while (nb_pkts) {
+		rte_pktmbuf_free(*bufs);
+		bufs++;
+		nb_pkts--;
+		num_tx++;
+	}
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

