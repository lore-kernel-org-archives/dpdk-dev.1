Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 710F4C61CE7
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 10:53:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CD4040B9F;
	Wed, 11 Jun 2025 12:52:37 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011007.outbound.protection.outlook.com [52.101.65.7])
 by mails.dpdk.org (Postfix) with ESMTP id 0326C40A8A
 for <dev@dpdk.org>; Wed, 11 Jun 2025 12:52:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=IL+k7rC5MnDv45fl/M7+bD/leeIVf1CReH7j8Lx65yMrt4noROO+ymY89MJxoI7Lk7fLFWRcivm1oKdLddJmhe4ymA1zPP6qerOovyzZF8SPTjxB5P7i6pfoWuf+gTyS8UboTeWjyx9HLwX/ZXG5IArwnQ9nzVXTou5B/QXqgB0OGBUji+YgKFyzAr2AAxzeq9lvehSvXE9kQxxfMKOt9B/HdgAKI3b4i8+icIIrXhfwnCjtFJtI8P5LqWVSREQr4L3unsdoo+gYE0CuPofP5ViMvV4v0ijn3Lbl3J1/lK1/M3JUHW8RpuEdNRb130cX8UFl+2EiZN48l3Rg7XabtA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbSMG935nAQVsn+w1fPas4D+XjTS3RLSPabxBnGNq8A=;
 b=IRB0JcYFT/uVJEH7ahqWrznT2SXQ5NZ7n/VyqtBJJGgZWN/BXeHR9Ri+BF6V2UBcc+jXTVDVR1HdedvV0Tsq5jP3pO8+sVsbT9Kq1J9ucI3OtcZ1TiyJQ0ouG02FDy4+r1WCnBd1nBgWJmaierj0R3A7QtE218vD4gA6uFBW++HIHV6842Wo7yOAJpWdijwVzIts0H1hnaKxSKiD0tTWRuuJWaAI2vgCCNUblWgasiGvKP6BVV7aqim4jDfdRZASYjMvJmAuMKrHuxUssn2i1P/Uqz0m5uwT3HeoATvchESABYSSWpOvxAQM32wftSY+Hs6CbUIzZknA08x5u4WfqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbSMG935nAQVsn+w1fPas4D+XjTS3RLSPabxBnGNq8A=;
 b=Ckc9yhNNpxIV6E6v5l5LJFbOi+6WKe9Wor5chIEYupwZFsizNjAORYB4OmFG78eLZCI4/MdB9sC4ZEvQ48ayVRPxfU+h0gzRkseS2JD9ANPFLg01vbgun+LibLDQ806zNv7nLQOA8xedcnQGCfy71TESrFlNtXdPeTQhbvqw60qIRyhkGYwvS+PpqiB9nSgnRazgybeujkusZeSYb4Upxs2K9WFn4Mhi6RjTxqs716bJqbICNTMb97LrH4fJDkIzl8FDYxJWqQeBB6Cm/cIIFZdEEIFGN7vytEyzwEi/FrbtvMQkoCH3lIRFIhhi8fTz1Ve03SdBLZnq75dw0JzmaQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM8PR04MB7348.eurprd04.prod.outlook.com (2603:10a6:20b:1db::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Wed, 11 Jun
 2025 10:52:34 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 10:52:34 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v4 11/11] net/dpaa2: enable software taildrop for ordered
 queues
Date: Wed, 11 Jun 2025 16:21:49 +0530
Message-Id: <20250611105149.655144-12-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611105149.655144-1-g.singh@nxp.com>
References: <20250609025450.3997062-1-g.singh@nxp.com>
 <20250611105149.655144-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AM8PR04MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: 75794cdb-3398-4d57-abc5-08dda8d61212
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?KCwHvsojLSeBuHWQ9RDxzT0iiRH7r48Y+fpu2B9pX5uJyWCYUwWS58uQsJzy?=
 =?us-ascii?Q?Yik9M1Qs2q9gKKXf6w+L8fb5Wi+X2M5gbNT9l3GIcbLUXGkZKTImBxBtMGV3?=
 =?us-ascii?Q?cM1EcIpXLSlK9GdgpVWrxksVn6kCA08qfKU2z4IoIR0/Ue+tqLel07mchVK6?=
 =?us-ascii?Q?jypYakuwlpVPjMdLJP3N/iolX50Nl//END4V3Ob6/xKnOo+dzEiMuHCcZiws?=
 =?us-ascii?Q?HpGb/S6sqEnXw/74BSar4STV26XVKD7nClsrXwq53PEL4/q5Ja711qooKPFc?=
 =?us-ascii?Q?SyCrmrxxubAMqzamwx7KQBvXTQ7ej7D1zjZx8QDJDQozhzcM91Gaa8pwYzpU?=
 =?us-ascii?Q?neKqsSzoO3NyOMdWE6S78rUeoFvrYXxl+o25mk9I1z7UVxz8geHztzhmm1Y6?=
 =?us-ascii?Q?jKqByr3AIC+EGL1BFpL5lqLsRiovaVrVf5WLM1kAPWLLXFxoKpyUA+0hPWwY?=
 =?us-ascii?Q?Qd83Xmwy1JaoPjh2LiBm08nGlNk4K3WpgAhIkKQaZhXeZ1NQGIGNtIDBHWbq?=
 =?us-ascii?Q?zUO3RDK21Lj1RL594KGqy0lAYELTswgnBRKqDbL1IZf8F7g0S5ud3ISzhlW4?=
 =?us-ascii?Q?9VP08M0wcYPmYgQvqdIAVCoeXcpmieq50YQAZltVspJIAaVDoLXLwDLDuhq8?=
 =?us-ascii?Q?BtY66vCSFwG6z7PCvAjVNhVpVk9WMcjdaJzO/rYe+cRPWNo2BCARFSp8HNAm?=
 =?us-ascii?Q?nZO+PWg5pjrbB/++Kba5ERIvwDL18+94GoZakIfSbg/LZouReYLTiOuzGAvF?=
 =?us-ascii?Q?gzbjzrbQwhB2P3vHKDd/QiG1LSPfNGQv30FDxlTjdSyWlsX6al1jCZM2ouhh?=
 =?us-ascii?Q?rozJquaNppF0+c8rQXVxjPVwb3OKbF11+DIL8gbedgFb7aQwg2IqWF6vgOPR?=
 =?us-ascii?Q?/NQhOg+olPB5LIjCWbYwjqNFPgF07Sgotyn4jObIk/Al6wUpVOXnvwtpvY2a?=
 =?us-ascii?Q?3OUi/MlWMwRspEjhRehyEQjOWoaIsasrEnGkKBaV2eyEhxp+E3SYPW6jv2p/?=
 =?us-ascii?Q?DLrp+AnfEJ+FTZzsPUM62OmL0ECXh/FFaljPaiRV3oytuWY2vGZO1vkKcPOb?=
 =?us-ascii?Q?50+pfq7BE4fHHEl9YJZTWyeoA02gukStYJTug+H5RhHfkg0iavWMlLunRrXD?=
 =?us-ascii?Q?hXMDcFU7w904G+3W8DOzPS/7W/wdkSf4g6nNkEyiyMC73Q0nUF0pAHycrCVy?=
 =?us-ascii?Q?AVhRdNE+ON0EXfWY8mugTHpo/89WgxK2dQefCG1i3ixAmkG39/iGqmes1IIt?=
 =?us-ascii?Q?7YYxYbTp8pLzVGQH1IB97P1c4QOxV1GKwyJjUe+QfhexNGmmJKORTT0wmwRw?=
 =?us-ascii?Q?dqkP3KKRyd777Ncb1oMjLvD6mllOjY3xznfrEzXOHoh/+AdExbz2LP61cWQs?=
 =?us-ascii?Q?SYywq0ZqApl0HK6v0QIhCyMbD/hYvF1FQ8lT4OSN76aIyWNevZ4KiTto6k4M?=
 =?us-ascii?Q?u0sLi0zaK/kdZHf9OFUeGVpw3VVX7058oEQwctubzV9diUMt3IppPA=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CfbEbdCsHo/LMRMG0SJFG/ErV467DqpKbKAomNCerZvFPwpQBPRSO9gRBJ//?=
 =?us-ascii?Q?Pi4Sye5OJ5d/xUIQeUlEoJrshrkDb/jTJ4P0BDpXQW8LUUgqgNUNvFWfeg47?=
 =?us-ascii?Q?ilvcUiBMmYSrP2gGnirE9lP+Mo8uQpxTlWlg0tKX6gyXPbY6bFWA8CaK2QP8?=
 =?us-ascii?Q?NkwTul0vux3OxkrcgrJhu0ELWIsDS4JsFvxqRQC52bpFQlHxKqeJkleFUueo?=
 =?us-ascii?Q?dkUH42tgqGBi7GLRonKZmyGQ4mRjpWoV1ATSpZiiDCwj9ZNIAP/nd6n3t3PN?=
 =?us-ascii?Q?LO3Vwzw87J6OH86dwXNkiyEF5BWU9Gtqemiq8EiwcWdqLDmSnCx4zNKHm4Zs?=
 =?us-ascii?Q?PqwWnbBDN3O9j6dR1caC4JkmA7juDEAdijvkrS5v/oiNK6tNQSjtGRnONiwd?=
 =?us-ascii?Q?6jzhhGvYzhYn3ZjBF4yPIQlqVBaYA1+YFlVdkMdO7jSeUJcd5Mof/YpHqQgd?=
 =?us-ascii?Q?HJkrq1T2llvbojBZS/GxRiU6Z5j1oijOiMHTVNOWlq+MqdP6cr2yNj+3njSR?=
 =?us-ascii?Q?9jBkJDpwbUxyYhAXoDtX6mOXkBBYCXrGhFbyOSgj1lDeVfLhPBzk08ncBL3H?=
 =?us-ascii?Q?Vk3cVivvVef160Z+gLkdgG5y8yyfeVYD6e1FAye61yLb0nFu+/sfthdozSpf?=
 =?us-ascii?Q?OjRmGZljnSce1lNrNJwLSFGgTjREQxL05r2jnaQba+/Wey5LIrOc53WAnvVu?=
 =?us-ascii?Q?uj25TDpgTb+KmaQSRDcfhyTyaI4gQEhgy2m7dBaNaaumfHbi/bYrfbXxFpiT?=
 =?us-ascii?Q?7E5JqXQyR9O4nxmMD20G4KJ4TUYybULC9T+adV+3yJH5JLtoloKYZoO9XG+c?=
 =?us-ascii?Q?OCHsmJ2bnOWwur2Sk1yvfc0YCpE7W/M6oc4EWb5nBFFhpKAS84ymba56mjfG?=
 =?us-ascii?Q?GLo380qb2iuicDqly86uZRv42616geZk+eb7l+4SS+Mz1ZxeQRAfHngC/kCw?=
 =?us-ascii?Q?eC00qDB36hH9FTj0XvpFvgGcffDJBo9d1Hked+B5yESHXhIGYeWkYqss0sPA?=
 =?us-ascii?Q?NcUSgW+SQsN0pli5UZpuLWmndr/B92dXQs0tNgetKW08o+e7PfKQqeaDjSON?=
 =?us-ascii?Q?CTVLcnSDHivdF6KNYJWSB9D4UMCKcHZHXr28QDiTmGGepwh9x3g014GD6+ql?=
 =?us-ascii?Q?Eska26K9sDYWDkLDFETIKAr8yXzAQmvKesOetKTZCKuaSgC5YWMpiTaV1x6t?=
 =?us-ascii?Q?zyMCK71mRRlzdmesekQddINBsEvgWU15wjPPG4IOL6ZMAnwJFqY39UTuqgId?=
 =?us-ascii?Q?bRTVD9B/VlLWtionhjY2klGMCfjuLtyLkw6S8Tm42mGXQPW9QXPWWKJIjOXT?=
 =?us-ascii?Q?1ih0f3iNR6g5cuuKb7ZRCoy4dmd4BmcVYHlDjmX2pHEjaMu4Z0uiuP26xL6X?=
 =?us-ascii?Q?N2g+RamnnMpB1HauDpXyDk5EW3zMZcL5eogUDYdZePy1R5dfKptr+i83mGCd?=
 =?us-ascii?Q?UvVFpTnoeKNZXg81TfX9tUchRJWdncRNCRNWEjALjVFmJfDwT+yVzm9GJWi/?=
 =?us-ascii?Q?ExDHbsCQptRu5uDn1EicbmeMIfgy4Br/KrC07A25LMl2rSuAtJb9esYIrBTZ?=
 =?us-ascii?Q?ikEIJT6pKH5AiUsIRKo5bgbHtgfi1j84LgTYYmtU?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 75794cdb-3398-4d57-abc5-08dda8d61212
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 10:52:34.0163 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7QanqEZYwQU5Y40Q2Vaa5RIQhPiLevKzCc94nlnIhqScqwYTo7m5d6xprIWxyllz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7348
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

