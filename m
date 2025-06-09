Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 417C1C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 02:56:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C42DA40B8F;
	Mon,  9 Jun 2025 04:55:45 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011002.outbound.protection.outlook.com [52.101.70.2])
 by mails.dpdk.org (Postfix) with ESMTP id 7D2D94067B
 for <dev@dpdk.org>; Mon,  9 Jun 2025 04:55:33 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x0rUGI2Y3vMQ+4+HVk0qtT0TC72jPXuytITuemSK14OPN4oYC9BcSxb9VpLSCWrwZZeUKLUsMA4slnu6nwK66JMwnwdVr3JbOIKBeTafZKbKdS1kcNPWypMcEXa6OanqIcMjIpLuqkVhNt93DvCp6lnyI5krNS5ucrYkscpHpCVVl3P90n1AHIh0pmgjUMM6eId/TKjZtTOBaxjlqXUo+KMRxtMXXBB8lXOnaGdF6EVfuc7vK+HEgExzpQPHy+2F1jGJ6TgkWQ7fvlGxS5M+8x98xyb46ERApZvTGddJllMnGN4JUJsLNXKCbzzS+20/Mwp50clvsPwmeJ2iHcslPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbSMG935nAQVsn+w1fPas4D+XjTS3RLSPabxBnGNq8A=;
 b=hNw5alFEeR8/0M1GKL4DsUwChcusiLf6+RlXaIETwgb+jmvenke1wdDSF/MmII3AMqz0Bld1keos0//kXEciXqVjk+rFoyd2qJBSb3SvK7NKMs+AtXGGqtDLbebp0AA+fZVkdsIgXVDpxMCEtOurUgIYpKkd+7Fd+LpvWLOuUo8lgI7fI5K3ZZgbSOKWujS0pX8Cqb43dqC2X0OUR+4lQlMu3X8NhwigfY+qn7FwQKBOVoKtk/UBHZ56ADsTvOKLvjthMECciHHGXNIQsVchuDJ+CD66HAbpuIH399T4TLVwdqDIIoCvBanjmGuI1m9vquY1WvNb+EVwoGLCnkd9iw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbSMG935nAQVsn+w1fPas4D+XjTS3RLSPabxBnGNq8A=;
 b=Kk46ZhEB7Inc7pf0dDrbY6hWqcwu9O1PCBPzQC3Yzubf5ViBP26FOTfIk0CS7rqL5iAzcRgAIN+CFpjMObXcvcHBX3wxjN9s6i0cN//vi541AOkFzgOJ1bY+eB55jEvcvZcO2KYJ6MF5tP+jNcE/L83zTDW58WIQNzJAkiBwiEIh2d0B99q8EbBPWoNLaVt/5Yx6VmPStAI1skAIIQv1sb4OOpHJMItO71HgU91wXoQTUKSKw7vOEpGrpovurrXdTU1Aa9tMSxPoRF9H/4ZdIy4BwIwRN+3hKiBk2iL8Uc2JP+y+4JiXmpEDLicdSdRobLmdSbFJzEmZROKH+z96Lg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AS8PR04MB9093.eurprd04.prod.outlook.com (2603:10a6:20b:444::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Mon, 9 Jun
 2025 02:55:32 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 02:55:32 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v3 11/11] net/dpaa2: enable software taildrop for ordered
 queues
Date: Mon,  9 Jun 2025 08:24:50 +0530
Message-Id: <20250609025450.3997062-12-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250609025450.3997062-1-g.singh@nxp.com>
References: <20250602104041.3322164-1-g.singh@nxp.com>
 <20250609025450.3997062-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AS8PR04MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: 5098aa0e-7f2b-4223-941d-08dda70119a7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2tC0i5081LUOM6kjAHZetEhvlxhp5M4NvuxIrlNuZMyNyWpV3/ZnBVIWMMYg?=
 =?us-ascii?Q?yPrigcihgsS/R1eZ1JEIXWOTYMoY55mCnKAbUAx3uMQaASZDyjQgTzftiSa3?=
 =?us-ascii?Q?9g4P6owHxw4OvkDELTVo0jDbo2OxdBROjS45nhG2P4DNvb2kTKtwlH3fnaBV?=
 =?us-ascii?Q?0keKyXkjOEVtMuj+IYeGtC31AzR3u1crq7MATrmlP2KIgOXJSwwftl1enYIN?=
 =?us-ascii?Q?33d8ZQ8us7aKpf93dwttnbsuPNVhC7XXFxg3HboC2njF2nvnYZzcOQWJvgE3?=
 =?us-ascii?Q?+PhevIGIC2kTxdepm1zBQvNvlYCDM7wsePS6iw2cg/QucRMQsgMhJIJA/mQE?=
 =?us-ascii?Q?xmNwdbJoaO2wSNY+HpV3DUXFnBnY+KD/nFFUjLfdASagwc6BOyU3tSa0Si4k?=
 =?us-ascii?Q?n52sUrc147WWLgbESAXVfY9bkMvv7E2tyhT+FlUU3C0t4FeVu1Z0LVgN9DbN?=
 =?us-ascii?Q?/001CZg725ZpvH/t3kXxIr5JU2WHtlD1H3Zvyy9IdJtZ6FRmclIv+NL8++O+?=
 =?us-ascii?Q?dUNF3pgsjv0ieiY6E4CI6w4N4COmRvJh/pZESa4TJnOkPrU5S3HSzgKaiGTN?=
 =?us-ascii?Q?W2YRXAyOxqYoxUvLXHFHmZjn8VQLWzZg9cNb2MdvM8hBtdFcSbUck2krZ1ia?=
 =?us-ascii?Q?R0bnxQhNlw7ATxnNiSbkNp+mMKa6jy8AUZ1GI4QDap+FOjpqqoDLVmWtD4U5?=
 =?us-ascii?Q?qQJ1O4+DssECOBfvAn7/pEOCJJcvGl3+N4k6Jceq66Y7LKnvgs4uEHNN10FS?=
 =?us-ascii?Q?DjFaOF8XAvjdvFCDDICwTLY81Lkfh5ZM2MSyJxAkRA86upvErMlwxbQcsYeL?=
 =?us-ascii?Q?EWAHeYnRVVTU74Bzt9NexTloxWy8A6fLYVDavBMq2Pk8YmqAqkXl1M/2fR4w?=
 =?us-ascii?Q?ydK7V/o2Yvha0d9S3VvkgNC6udSG+k5Pg6KTrKehhF5YMOVeNc5O/7I6m1kq?=
 =?us-ascii?Q?uaGsPZUeUrlmpQDEs3kRwPS34OpHeOvL16luEhIJEtxjSfL6GmamGBMilL0a?=
 =?us-ascii?Q?1d8cG3vLw/bwYeF2Vph9M7Mev04nU943loBpztrUAD0nR7JUub7ywJ3DhB5o?=
 =?us-ascii?Q?0vHOVNIuixQiLLqXIcvoI24lkIADrU2IjiYSx8zdGU/gPYYjv0ubvllvrru6?=
 =?us-ascii?Q?h9gGK64N/HA6Zs1G86nKILqZHFPeAGjpwyWrcjjT7D1+OVTmUGQ4/5InM+FG?=
 =?us-ascii?Q?IN1o99zfsowOUTTtJX1s2wcdrZ5pt9exC5PnzRswEhgFZkaK2w4/mYtDpK7o?=
 =?us-ascii?Q?EJ2PZiPo3ddnAh8JxK4aRqar7LFFYZGiuWgAD3YF1oePyUQYwpQHcZ7n2cG0?=
 =?us-ascii?Q?Gfm7r2WNe2PuIyi4voOWbpM7nV4M3je7vCe9w9q0CMqpdgNXb8ZrUxelcoYg?=
 =?us-ascii?Q?p1SXKUMAnYx3XAHeCww5ODvf3ukHMdVFCdDhK2WFtE5Pfwh8A6JLd6MzUmsk?=
 =?us-ascii?Q?vlaCU5A+JKIKGLwGQcAwZoOFTs4cD7oKlKOOrZKwKec1FSuUZVbvijfg/3oY?=
 =?us-ascii?Q?cFhaQjtjiulEsvw=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iVQLyRo2dlY2J7YSACqDlfVYdjG2Svecrno5AmTgg4NZqCUANtB3ymSGbUD5?=
 =?us-ascii?Q?K1QuLH7UV9pJiK24wZbiQ7+FQR8PbE7q7RJpztrZVfVC4i6JJ4TN3S5Nb9fn?=
 =?us-ascii?Q?Vptsw6BI4cIFnVVEz/JORAJJ+t7KlpIRqKsNHEoaLfbevAakRgK+a/QfcGM3?=
 =?us-ascii?Q?VnZI2FUNw8e8w4yqagw+ndoaefUAXTWgRYpQH8wcEnmr03Lg6jww5fPfhvnZ?=
 =?us-ascii?Q?0AwBRUajZlihPZce5Js7jeJVEqphQDwby6FQ4z0uWJEn1cIoLo08rYdZW0Hk?=
 =?us-ascii?Q?twika5qC3auy1fZsWZ8f1+msegxX+z6Ik6+x1avFmGu4LrAhm14pyWRr/qkT?=
 =?us-ascii?Q?4wltwImqyvEKNc7yVm1X/2V8rlxWPWP47CnVhZLd5slBQ5RZ29ZWVEe8mDZv?=
 =?us-ascii?Q?rcnXbVbqrbnqVLkbSsWDeGU59Yj1ZgFojSjnjAidwB18h5k9nDkv1nmDLbEb?=
 =?us-ascii?Q?hzGRLQYimA5AxKFM7phd+uwWrWodL7ht+d5vq+fH4CpQB9yRY48y0k+7adfU?=
 =?us-ascii?Q?MyyfOu1BDI32QUNFV02IRoJgxC+E/RPwplHPXVn/PjYnD0oH4TKLvJW8/CsV?=
 =?us-ascii?Q?inSWJ287fXGsfQHPH2OWWklwzdGQdYVxGSMyF8fcDTcPDV3+8FgithTgNSc7?=
 =?us-ascii?Q?/x5JNF9HaNhi1Y42SprxmR7Uvm9ou8k4/At0extRerxgblmQkYBYYwsuQF/0?=
 =?us-ascii?Q?QAN7WbBAXMpQcN+oU7Pjj/bHNrrgWCTyWCR8VROEewD06T8kpvn+WZP2u1mv?=
 =?us-ascii?Q?0HyNJ4WWnlQa6iTUZ/0+4PKDva8kpXLGS03OPiT+r21PpjrViYjL2ymDGddS?=
 =?us-ascii?Q?oMKtyM35EBSOCpQtRZuJne7PAdBn4ePBQNKa4op52WIPWljbaDlzoPeenNlf?=
 =?us-ascii?Q?qHD6rgK6YBgrbHFFO8+j8f7p7vy91J+KamXXNemOlqLbH9h5iYU1h+po8LNg?=
 =?us-ascii?Q?0mEEmWiWiCJ7kbDolsNgn3mEqogr0/oqK/BaFOlRQji53i5NCdFiNHYhH3B/?=
 =?us-ascii?Q?MfqPCWJKjphdqbHMDRD/5otN6qdiJ71IGnktrcHNNbMk8dQvhf1GT8CBsrkc?=
 =?us-ascii?Q?QnR0x4Wk9q5PYE5awUIOaP9ir2dmfyuL0aQ3GG8RjkLhOSms+UKgbp6YkN+d?=
 =?us-ascii?Q?yIdV2brk6GBjBs3wjyv4knRimVzJ3aMOqVGhrScXsJ3HD3SOmajKXUMZOsX5?=
 =?us-ascii?Q?XXfZ3/yXvl1/CmJMFBRhxmcvvcAKLp/xZV6+Gb2EOLIROpJicSs5P/VrgFrA?=
 =?us-ascii?Q?35QNCgi37Kuq7XeGNHvd5rRTwIDPvC2fIpOAnM+CNwI3jxJe9HDzWWZNNq3r?=
 =?us-ascii?Q?x9VS+Qssv/TtYs9AsQ0r7BH7rhBv/DcdIMBCEvBC8TrFiF7giT/RALErPdX/?=
 =?us-ascii?Q?B/Q7GtAA2+aZbfvn7eBjjsuHqWLo+fZn5cwo7ygJvIGl+3oPl6bxPAYJVU4M?=
 =?us-ascii?Q?351TgiVkt+o3rQHr0yTmt1tt9Ugpt2ArBe5z7NyA4upHikmFW4WvMlRoPZgd?=
 =?us-ascii?Q?Dvzi47zMYm2ksnGc5ljcdKrCyZs0CkGtAq6uy4YMrMotnuK+g+Affh542nUb?=
 =?us-ascii?Q?bLoc6xz3zZgXFJgLmLS8i/6QUhlBHXwMFeq/55sE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5098aa0e-7f2b-4223-941d-08dda70119a7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 02:55:32.6108 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: CNEPp/3NvTZWmWQvhQ2kwKZIymGUH2zjSJX14iNwkcPBxo4qyVCz9593yELTK4S5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9093
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

