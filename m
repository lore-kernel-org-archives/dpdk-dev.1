Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC143C8302F
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 04:30:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8528C4068A;
	Tue,  1 Jul 2025 06:29:44 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013041.outbound.protection.outlook.com [40.107.159.41])
 by mails.dpdk.org (Postfix) with ESMTP id 02238406B4
 for <dev@dpdk.org>; Tue,  1 Jul 2025 06:29:42 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KxGC+rqC5XfsZrm7xC2D7MbUk7E53UwCebMxJmMV+X9usGmgw+Ipbo27Tc1HYQe+aKsDDwrECiiANDTibZ8ilqYuaNWSZz59CVpWc5gf3N14ES85hIt6uhWqdsjqZYfokVsn+dhTizqkvbbf56/ngQQu4mzRt9Eytg/XvAWiug0/pDPg9QEd7arQ83Z+prPkCPSgsncSDlVeErAIYfIe0sWSFD0caAqcFsR+CBWS69HhBp/Nn1VYotsGbhPwxX2ZgoCJNbQLYAQ6YeqA4QPhHCXtgeXotQ9dZFJSQzddJWicMZJb1/9nWJDlvVndT8EB6ISHztFsY+ztyDvhQCiNhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a41fNRHz/s1fM+GDRz1MpbnntMrW4j+6r5fw3o1KVBY=;
 b=uyVWyPI5WWMTCwtDUlWF+Fx5NvN3ZCSBbLv4gQAh4EiHNtU2l9cAYCzv7KFwjhJnYBrKMx30L+dr2yFZne8f8N2HJxGMjBWN+kpkCxgTQPsopDRADrmYuZQ7a+7esFostj50U7mj+hMkkRj2O12Ef+toKmkWNI6YCMZlac/88eEF3XI4DbdSLDaeeBXtlAMq9BbUwtIhiDlTWknrHS4xPPNEhW+J2xiK819USmLKBkY6AtL1UITGUIQFFfoCaO4J+88WpbQv1Z3B1eVp/j8JvrHFedJBSkk0VnCgPEdTFtHaqmfJtVu2LMGzfXWZ4FgaDch1WrIXkD9e0UwYkQgp7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a41fNRHz/s1fM+GDRz1MpbnntMrW4j+6r5fw3o1KVBY=;
 b=HNAt93SkbwGv7icGNpaatpBh/HvXabmt29GbkimuVI7udfFD3mniYVU50Mf3rU85XdeKyY/K9l9Nix2rdphvLbTzEn+s1NX79mIMD0Jgc8YGfv4ahmdXkXeXStot7qVKMpPLXJJZ36Xv27noLU+u7nKC/hvL9gDU929sNxx2TR1ZFhHmOkUkEa8LwkfqIVzSeHrqK84scomqXSdEc5gl+KfXjyJaKdJFmwU05IUES9Aoz2l95BOPKOGvaQf7ykR6hLepwrq+OMhMAYpDZxE2tfDVxMYGD9u4QRKVhS0QSNQYYWoavJb1jfOzxtLrQSgXbir/p4+/zEdYzO0E0NSoqA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by PA4PR04MB7647.eurprd04.prod.outlook.com (2603:10a6:102:ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Tue, 1 Jul
 2025 04:29:41 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8880.029; Tue, 1 Jul 2025
 04:29:41 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v7 6/6] net/dpaa2: enable software taildrop for ordered queues
Date: Tue,  1 Jul 2025 09:59:17 +0530
Message-Id: <20250701042917.3000355-7-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250701042917.3000355-1-g.singh@nxp.com>
References: <20250630095800.2943863-1-g.singh@nxp.com>
 <20250701042917.3000355-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::8) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|PA4PR04MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: 74e30d7f-56de-40ab-69fe-08ddb857e5db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4yH1/+9n7AUnOXmPv7KlTChO6NzQA/u3QY35wxR7LDZHCT+TXzhgSA/trGoh?=
 =?us-ascii?Q?Vo2Dfe1s0HGm6fdj+WGFQVPtjk+Mc3ibGRN5A1tqfixVTNvwDwhPmDV+2mma?=
 =?us-ascii?Q?BBg/+cgrwicyeb8bCITIu71WQDZBXSdZoxYM7DxowZ+ZXh2IqhF+OB3ygSbw?=
 =?us-ascii?Q?gbXxmRFI6Pn6v3FQLxV8O/xZMsAGPvEsw5sPcqoaVT7uhrjPeGxws3ffLu/V?=
 =?us-ascii?Q?Led7R55ul9z21zE7EChvdYGCPTY+C5/SEnsZUjgidY1RjWBP58M/Eiy3siC2?=
 =?us-ascii?Q?N9Ql51NORKf1mLwUQe5aL0pGzAQJKN+mnXN8G9cke1fLLxCWm9bPFn1Of5o1?=
 =?us-ascii?Q?DGB2oyPa+wdqcw/xKlHOavdrO+QHPawNj6UlsiYPtqa2ZZjhreVrI060kEaj?=
 =?us-ascii?Q?vrKT0wsJd/I8BN+2l2wn31aCupLum58L8pKITVNmhEEEj+UYFomAVblk03wA?=
 =?us-ascii?Q?lLq3djHNIvZQXOt9dyaddAaKtKqDTxsenncOseU/aYbIVTHerUVHasDevRb2?=
 =?us-ascii?Q?sF+QGwQEXol1D1uhCyNBq5uzzvOvlhbIAz4L4VzbTKYdBblRmKogIm3W2jlc?=
 =?us-ascii?Q?jaOvGVnNEhcum55CycST2CYB+q8Lxa7gQ9S9stqSdNK0dnshWLjjYjLFYVX7?=
 =?us-ascii?Q?aGaZTppMA1N5L/jTsneBSKSLVDDQfyB7BwdL4ZOnZy8AXMAgwW+ryTMkiKAr?=
 =?us-ascii?Q?3qq6H3acWQaX9iDvDJYfHhFS/OdzVPo4wpfyNTsdiR6esVTx5dhI1cZCQG6F?=
 =?us-ascii?Q?nD1GNpnT/fTupElxJnRR9lFJFLdwR0kY5B6HX6Mpvcp0+KCB/ll8ElSGtyyD?=
 =?us-ascii?Q?SkJGKRu5j0YmOrIFmnvLYE9X/RbpzLTd8ssFnPPt/by92iRBMtVx4jJDdmpv?=
 =?us-ascii?Q?rZJptteoPZTOzPKuw+TeRRvc2O6nxWv5HV5T1C2MCJOklw8tDos3/2uS/QKf?=
 =?us-ascii?Q?CCKJKiYmByLMl3i+v+viQ648aDQCvf/ZFJNcRV2MSv5KIyhqXF1MzcF1yhw4?=
 =?us-ascii?Q?bh4ezmOg8Q7YTXlHSp2jovt1NkAmmqWN1lNo6GLZYqB4hDFqlFxZeAOEzxEU?=
 =?us-ascii?Q?MMhl4rMSp4soExSZ0JylAGrCVOWUyVDiI2DUqJQ9AjWjEice/oi37vELxmh0?=
 =?us-ascii?Q?es8TjaWRRtsXEqcPFsEXaBPyYhZeMW1JrWlyVWe+dQPOcakOSrYxaPSg6ccw?=
 =?us-ascii?Q?uN6WY91Bo6ThDmY2hW7oh/sNPN0Vm50TP2hx7mbI8shZaL6+/oCUT56UztYH?=
 =?us-ascii?Q?jgH8uc0Ac/8bsJKfkhHuUs6iRcE9k3Zdz/NHmtjbsfhGEOg7weIhKOw9V/f9?=
 =?us-ascii?Q?zN3Y4LhpRgfhlpeZWA89kINTcp+pEHcJDLu0bL9W/WLqp+ibXSZf+RlGIroe?=
 =?us-ascii?Q?yHlFKnL9APMAzfEMCqzcuFeV07XdqZX5W8rafO6sBe6ozvTxJ3wR3prZnK+R?=
 =?us-ascii?Q?Ic4NYtkkgeDdLsiKYRsxy9h/f2faNn9kFLt7DAXTef1EKKlIgR/yzuAaflEw?=
 =?us-ascii?Q?0oXs4XuCl5+5RJg=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?INPPLHYHkfZudqjjsezcsDbcRC8Rx/yA7EyAFtvmMEs1BysKonMZ1+QdKyA6?=
 =?us-ascii?Q?ggNar856WFvaJR12ZbaUCBFXcOPXSeho52RDhH6nvWtwbBqSL2WgPCIeuOcz?=
 =?us-ascii?Q?uRQSwAuFof52YZNf6lIzII91gmDZV0NuOy92PrKEPLE1WhVHHmbFzqFPh55T?=
 =?us-ascii?Q?MClnCb0kJdZCZz7Zkvss07sSFGS3hby60jzb4HgfVe1Icwaozre47q3Uc3FI?=
 =?us-ascii?Q?PpZZGX131vuRTcmCuz4BicB8K4a+RvkXcyo714qd368l2jWagXuLuP0IGWsT?=
 =?us-ascii?Q?XgkdJqyz7BHezpCy4imvT8QXkj7mWWNbCFcLFnztoRei39GiApdk2e010PA7?=
 =?us-ascii?Q?mSlm3Hkj3hbXtHhP0EgkNrby5Mf0X5l0Zseq6ZCldoG8xjIP5pzYA6K0IBcH?=
 =?us-ascii?Q?/2px+P17iE6krEu4zttt9d0e1Zgg7DE70dsmCzhYWfYicLPsFoeQwggIylKt?=
 =?us-ascii?Q?oX9qaq2EGdMK036X9pSk+LVXyQVYB8A4qP+3sRQSMpqBeTg3ZWB3j7c0xjvM?=
 =?us-ascii?Q?m8DwYyYqqljRi9Y9SdVDe7gHE4hf8PQEg+4eyfAgh6uUy1ZplolbNf1kORdh?=
 =?us-ascii?Q?F8LMuMGXUfB0jHE0zWa7tRIayH4oA9UV22k0B9iAuXIEjN/hBUL+Du/0AAlc?=
 =?us-ascii?Q?zZGoW4YJNCAwPZh4YyUPMITpr1lOlIYDrJ7+qqgnDDBrZj63CSdQTa/k6WNO?=
 =?us-ascii?Q?8Xe7tan3Y0fQg6CHjcgH4HFDfLoPfwqw/JqgtP9LfLO/7MC7shPG94S50rhF?=
 =?us-ascii?Q?uY1ZC7Hd3nWo7KyBWs0pxZiCTWJ9yaoXInWAGmnHNRO8TH8J5gZ5TsWaI73c?=
 =?us-ascii?Q?7SnQEoDMLReJtuhui3OTJu3SyoZ8aMMWM/rTzb744ONXgggCKToaFQcO6S9X?=
 =?us-ascii?Q?6oAH3hf0mLaAxMOLmMnzVMSEGWARLsNIv7TZujFi+UQRXs1ID+uf5D0yq1OI?=
 =?us-ascii?Q?CWW7gvnVQEc5qcw82NHBPPAYF7onBkwH76A271XhK6augdptdT80asN5szi3?=
 =?us-ascii?Q?4chlkOPbSeriKyzeVmqmV885eKx3S/g7Q67gXX9d0+LJDLVdOVQiwimRxs+E?=
 =?us-ascii?Q?eT2llx8eKgOV2IRhlJRpkoDrogCnGlkUHc7I+1UdOlnMaBNftWPz96148xqi?=
 =?us-ascii?Q?WM6vsTxx1ls3M04dCKO5sQCl10U7tb2aHl3crxo8ZfX/aIbDPG7xyJ8AMONV?=
 =?us-ascii?Q?B9yLqpW1gF77BfzYWnrOhzJFtKxhyRmFv/ft1L9+mI1+rlAfc7RT5m4o0T2/?=
 =?us-ascii?Q?iiP0q0SWzszHZCUHkhCvIsviaikDeeGMOjGFmSZtq6gTAq+3zFDJrKWbU8Xi?=
 =?us-ascii?Q?d8fo2x4FyvkutYZ8qm4jTMfYskTieZ/tilMos/koq/F/M0OWMBZhWm83usrL?=
 =?us-ascii?Q?XcF69qh3+OD0Igh9q/Z6Q+U+m9ZZX70EBpziZpdkK7zoXbueNYfcrbeK0U/i?=
 =?us-ascii?Q?EbMLezdb/u45nyrpKC5df+FI1Kag8Rca72Z9YI6VxqiKCCOEcwn+A1rc2EFF?=
 =?us-ascii?Q?3IbAY8AueuLQiCvSGT7r4rzlBFLRulLeYAqWfrZ/1A6YuLja110Z5L/AlzNV?=
 =?us-ascii?Q?ZPBS/iLp7nlE8sJYk2Y=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74e30d7f-56de-40ab-69fe-08ddb857e5db
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 04:29:41.5879 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2RNtUsH2keE5Yd1hx2T0sCnotLCtWqPEmxVZaRa4+B+461Omw44aCvGWIgjypiy9
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7647
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
 doc/guides/rel_notes/release_25_07.rst |  1 +
 drivers/net/dpaa2/dpaa2_rxtx.c         | 18 +++++++-
 drivers/net/dpaa2/dpaa2_tm.c           | 60 +++++++++++++-------------
 3 files changed, 47 insertions(+), 32 deletions(-)

diff --git a/doc/guides/rel_notes/release_25_07.rst b/doc/guides/rel_notes/release_25_07.rst
index 53a1c8756d..dd8bc74946 100644
--- a/doc/guides/rel_notes/release_25_07.rst
+++ b/doc/guides/rel_notes/release_25_07.rst
@@ -163,6 +163,7 @@ New Features
 * **Updated DPAA2 ethernet driver.**
 
   * Added DPBP APIs for setting mempool depletion thresholds.
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

