Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EB74C8302D
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 09:59:00 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E4B34067D;
	Mon, 30 Jun 2025 11:58:34 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012030.outbound.protection.outlook.com [52.101.66.30])
 by mails.dpdk.org (Postfix) with ESMTP id B793940264
 for <dev@dpdk.org>; Mon, 30 Jun 2025 11:58:28 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ZmXvaQ+bXPSWkrAfQbLgRgZJ1GlpfncUEthnz+VzdJRiP9VjrvRfZf4nX4tuw2MV534w2KF8Buq02zC1f7XbNToZURFdyLkTdyDbDfNpisi9LSTp0lah4N3HYLwNtIN1774Xt0b9/Nh/g06EidGRFSzW8T1q11sRqdQ4N0nL15Vu7QXileEK3KV9cvpWXrk0XT6S8feqGSVTgCVRoM6idzzMarhI51tTgAQ07mJNU4zlJwLnLUJokQJbaHwdiJWEqIyHaAz2Pee2/G+e896vUFxMwzwTkLSN3bGb7B6OO3bytEok9SRGRf0qumU3XfEZKIApPlyLD2gjoiJFvCjc4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQMQDV8S61Yc6evp970OKlZttWOCYevg5erLwsYR8OM=;
 b=BGFwalyyq/xbNO1XKenaAESXcBDQQJZ91YcNKsJuFSFPSow0tvZAeuHi/uQ86twjGXJlBhTjdqriEwEzBXSzO2PULhGs40CC0O9JyMBzEYBgn5X9RJFHQmRzqRZ+kaQMDMz8PYHYOF+0LliNoC8Hd9yGZYxdl46rJen1Qytu42VA386GLca7DTiL6k1wgtI0+eShFgF5xQY+SRO0gwfwLEBTwmR2YTVOntKSQs2UKyyufLsaNFxJsN474MePvllyqaIM4rqBIYVjlGi0hlNDIg34WqC6HpjKbnp4Ig2pLg4mO2aM0WbDMpIOfB43Ssvl+9LrmDyrmBpcwaFE8eSA0Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQMQDV8S61Yc6evp970OKlZttWOCYevg5erLwsYR8OM=;
 b=Y5DXdzlEd7yZOsHJygvNDANXob1zINnQ7lTl9ihkY/kGqjWnRQjZrbMaZ9xkrDfU+vgsbZGIdLNiWDz+TauMSmj2RI8p7wERGUyeZEdZ2zQiN7pyIm3Jtp4Z9SOehVCwZ5JFNe+cJlkxCFMUektox/p68Givxd2LVAP2LMnR3zSLby4fQhqocXQ4W9hEwkfjeAAnnCxnYBCmFrw+okOSWe2a1W3z+YOTRz5/sr0KYZWjWBjUG+B5Uq+kOrMJKPJwQRVRAw626/JIpW4lxPgghRZ+eKh5B8wgyf9rHGWGR6G9BXBoyERxDqT7/LxPZlkwMBsPIRIDysEmGjg2XxB5SQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by DBAPR04MB7367.eurprd04.prod.outlook.com (2603:10a6:10:1aa::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.29; Mon, 30 Jun
 2025 09:58:27 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8880.029; Mon, 30 Jun 2025
 09:58:27 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v6 6/6] net/dpaa2: enable software taildrop for ordered queues
Date: Mon, 30 Jun 2025 15:28:00 +0530
Message-Id: <20250630095800.2943863-7-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250630095800.2943863-1-g.singh@nxp.com>
References: <20250613021125.790614-1-g.singh@nxp.com>
 <20250630095800.2943863-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::34) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|DBAPR04MB7367:EE_
X-MS-Office365-Filtering-Correlation-Id: 7dce5394-0437-414f-3848-08ddb7bca8c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HZEdprgWQWv2ELEsE6gIYVjiKwPr9iROEJygy10iJHM9zFt6xo1HBKKSpWde?=
 =?us-ascii?Q?WQR+xHBVQ4K5JU60uCT5xiyxxdyBsMUxWbwM03UVYNtqD4xAFPb6TiiHMj0i?=
 =?us-ascii?Q?cCsg3vutHm6kMohTRZE5WwOKftT+k7L6mjm6HmSc0XGTzxKbipwkL13p1sso?=
 =?us-ascii?Q?nKlpIKKZm0hNkefoApzdasY6S2iv+91swRUlc3YzZM8DvI8QaiW4N4ncpRNC?=
 =?us-ascii?Q?0t0S04V4NSy4jlU8746xK8vJWOnY8VjUVW5cNPOPKQB+ZKJh39cRYhVTfdeD?=
 =?us-ascii?Q?FEuxTJr1vfXoORhMSTjFoJa4Mnp90DmVugDLUAQ1rhlKUskqTQuXx8JbhOyO?=
 =?us-ascii?Q?YJEaiNYBexnDwRkBqHXj+OqBNi5LbTb4UFNIg0fCcvPv54LAPffXK2iQ8tPp?=
 =?us-ascii?Q?BatiXsxBLbmdLuV4hCpbr1BxdhzA3r1qmSazsU/9aK75ReB7oA16zJa0DzH4?=
 =?us-ascii?Q?hwaJykZteea02CECUBQUhsuijys+iHxlA6Nh4TGVBSRUa74unzkHiYcaDUBX?=
 =?us-ascii?Q?Fgn5dP32vag49chKJFVYhL5db5KARrflXbf2sMlG49L1Zs9rdtAIaFf//7tj?=
 =?us-ascii?Q?Bvn4egaB593cUbmabR8yd4J7kEr2+AMBOXALiPlwwjv/u5kE1/QhnB39ZehL?=
 =?us-ascii?Q?OztIIXuE8IuhGD9qZivCZH9og8D0pLT1v99X4hnx7K4Vo3Zte4vtPqWq4qgO?=
 =?us-ascii?Q?5jyJr7HCFOv5yWbCtr6JIML1U2OrT8Ue0UuTRBI8OKHNcXj9y3gNisnhaKdZ?=
 =?us-ascii?Q?/KhuZT6mHYLuGXUMPASodAM5Rqyw1dPtTGgydd8atPJE3LuZyTGXbHKP8E8A?=
 =?us-ascii?Q?oFeCFegYqPKmbM36OnPjXH8P3wJHSYCaztOpwPzx6CuYPkfyJtrhCYXMtRdS?=
 =?us-ascii?Q?VwrWR4oSQXQc3xR3y+wB/uJ6UjbDm1QCi6h+bKu3FHBA4qOpeoXP1jLUuRsD?=
 =?us-ascii?Q?gHdXxHbxBQcVYUtlSB+f3MkeygCZcmTCDvWsNfMOHENHea7RaEjot0IyWeqp?=
 =?us-ascii?Q?JK4z2u5XWprqwWuWAXNST+lEa/uXR09CKlHbpJ59yYvaqqDwkmyb288V0SWN?=
 =?us-ascii?Q?CKvj+bP7P1XwTCCzv00qXzdSkDaB4H3kWRbuQnW8D0aIN1jK6d2t0icf5mKk?=
 =?us-ascii?Q?IkrliU3Mn7J+ssFQqgcGCTlnfpGvGwjm8Ee50XVKlG4KScz/53BugCDPoyMU?=
 =?us-ascii?Q?MQ6JJ5Rf8vg4zIh2Z8ajJdQSX74L3dl39iVjNblCDM7WhVvIBb+Xk7rxeOc6?=
 =?us-ascii?Q?8RI6rdhDSjKd1nolPZ0p270MTxGt4yEqxpYfziKZT9t79OGhnbmAaksw+8ME?=
 =?us-ascii?Q?RV9f1VSUOMZpZ6sEn9Jtn7Bc+Dy43nTaP0pKVwowUs8rgDLZTJgh6asOdC1J?=
 =?us-ascii?Q?/EcqB5H/xMs9Y9L/2gsUUt4B0z1hNL/JP0V1CXHTL1S4fHMSQ8uLG6gj17Qw?=
 =?us-ascii?Q?FV+IMpdjfWwpHprIrQ3MfZPygrnAKDLMyqKtxT5JU6YfGlQ4Cb5/D7GNyUhk?=
 =?us-ascii?Q?ZLALn/CKYl4Y69o=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?4aVG6J8AmhUi9PaJze9BLe6WJ6J6x6TGArkoE9vWM8PToLK3Wb8KBKBEY5tC?=
 =?us-ascii?Q?WvPrnax5QWBssGwbPprmsuOtTFz+s4chPw1AQ+rUI4r77xX1z1XOdpPhyGCf?=
 =?us-ascii?Q?m9hXhumysrkC49aDA+aGEYctrryyWuT41jfW4iWbc2/oj6cLEJBcBpvrzhtt?=
 =?us-ascii?Q?CB7z2+jTIjZN0mrqQTiQNUC8NjT6GUf7/pJxHhxpQ833BIeFHmCF1HN/9sb8?=
 =?us-ascii?Q?/LsVb5tBATARC1Ghse8gmWPAjgA7dIVQDqzyF8YcxpLv0Mbj0HVGJOEOcSDr?=
 =?us-ascii?Q?3aZhVHa0+OZMs0MhcvZu887v2bzP1a8kHtQYJdBgt/uPjnihTzy06cp8D9Pe?=
 =?us-ascii?Q?lziBSn/pdShUd/Qz/JD5xsyo/VZBf3jG78NwpTxSPl2gak8hW6/K0rb5sdSb?=
 =?us-ascii?Q?rFvrQQ59HZi6rfdJZyo3D6AlOKRKiytvh3gaTJ3vzT75pw/+aWGbbOoj3yQQ?=
 =?us-ascii?Q?y2Chfvqm9cgU4/uCY9iLiIs8jvsqHcF0ZtZVQO1suD7GCcCqzWva9MFiCPrS?=
 =?us-ascii?Q?Ql4yq8kgPYOerA4lb4MjoXApxHyDDD0Ay44BokBylFhh2O+f27kENiae6Jae?=
 =?us-ascii?Q?usAQles794MNMvKiWNyyp8QB46jLKALPxatdD+PzMPEloIKU3VR/YsakmzNP?=
 =?us-ascii?Q?8ofcQQmaZy21W/tKiLaDh/exbKT4ZSTFypzsz7KcdUjOYO6JgRARJQplVs0y?=
 =?us-ascii?Q?BVcTZ96cUNLs8HVw+EvMaz3cGRHUotzzEvURVClO2d/ELRnCzNNj6as3i0kn?=
 =?us-ascii?Q?rlzzSk0wjPqGPq29YMaTzSVz1/0KCERg4sYFE08BwHs323tvTXpkbwDqoWEV?=
 =?us-ascii?Q?ARnDWLlDunMDUCNfGD/vvM0eBPlm4UPbPazbbyVg++TKT4TCVZCmzYD7sBNg?=
 =?us-ascii?Q?Hi0+TUUKhTSaw4XRk+DDGp8F6FUbY4G10sGvrtuxNRWJKJ00HG5BzBQwJ1qf?=
 =?us-ascii?Q?V+2cs3lXT/bDcU3dqYw/Bj6Xyj5dSY76C9UpoUYf+AWdxP30yPzQC8ofxbIx?=
 =?us-ascii?Q?25xzeew7NAQIf9OfMNdWqjL0KLF2gFcYHRLm4KYQxM+tbRZYPiui9FtYZVMw?=
 =?us-ascii?Q?3WS1jTtbn47Ft7jT9PVTHQud1uPNzTOpGIkx9OcRKAauV2EQqQBck07QxMM9?=
 =?us-ascii?Q?wUqbg5lVOkIKY326QYupuhchCUh9QmRAsKyIi+/vHT/foMHbaNRMFX0v0xwi?=
 =?us-ascii?Q?8SOwyDgILf+qCjfiahp81F+j4ePDUgt1cVzCDvqDbnB6d2mBmUf+k37mjxNZ?=
 =?us-ascii?Q?7SjRJT1cj0orAucPo4rEmDKVMS99OKhDa46yT447gGJ0vOIuZ6IudqI8+p1K?=
 =?us-ascii?Q?Q15eXjGPHMbNhvkLcYIW2ppG6nRtusTSpXO7lzUhe65znzeISyZdHzZX0IPY?=
 =?us-ascii?Q?NSeElEubYUQMNhuUrzupHbHF03xjX9QkaWrPIogr6zb38PvwgvFNLvgmATE5?=
 =?us-ascii?Q?ePvZjOPc6iH0OgBa3EbxDMQbEtImigS4iby8dkSSAz/iEKPCXzSlIxz5yp/B?=
 =?us-ascii?Q?tYAeAGggDQ/C2xPh+OH0yFn3lEQWweM1L2OQunNYHVeAJV5u7cPy5eKP2LUH?=
 =?us-ascii?Q?sxDj5wAkQPZr0mqEp5WKWRYp23EfpdHLnmvJlg0f?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7dce5394-0437-414f-3848-08ddb7bca8c0
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 09:58:27.0880 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PL93L5UUjvhIIaXb7jAb+K160QKIcMnnxlEpZZVBgG0qgGtWe4HJ69swW+QomtMQ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7367
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
 drivers/net/dpaa2/dpaa2_rxtx.c         | 24 ++++++++++-
 drivers/net/dpaa2/dpaa2_tm.c           | 60 +++++++++++++-------------
 3 files changed, 53 insertions(+), 32 deletions(-)

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

