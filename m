Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBC07C5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 10:42:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F13BD406B7;
	Mon,  2 Jun 2025 12:41:30 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013020.outbound.protection.outlook.com [52.101.72.20])
 by mails.dpdk.org (Postfix) with ESMTP id CF006406B6
 for <dev@dpdk.org>; Mon,  2 Jun 2025 12:41:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pNrt9/rnynCcx1CWGkhIZ2+XkFWbuEeFjCZ3mepSR8onW2khyrjppleZ0JicF+Pl3iJnS3RjxSS5q94zys/RF1oix0+chNQcME8aR5EdaVUZ6/y7fOXohCE82+m+SQC7p+T9BH/iteVvVjjlWBUJZ5s6SwmvW4ISkrQ3n/v0Jmky/qU9BeElYn7yS7pF8CFNkCb0tZfD2ryKJ5wUa4mNCVNLRuxh7dMXHCLdmFEPh7cEuFar5DxzplOe/fLN86zK6laY1kZHokv9mf9aSuina7sL6VpEjpeqYT1T/4tssUyf2AdWPHuF4TovK2QS4L4wAMKc1NXoJRizZ0nHH7bl6A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbSMG935nAQVsn+w1fPas4D+XjTS3RLSPabxBnGNq8A=;
 b=gafFuyRi1PcPGvTm39eT71wTv3EdnMY6/dfYKePTxcxDk4pah6cbCqInm3FInDIbbksJD+ZSFEv2j1VZsiiQno8KB/Lgpt2fzMzxl/eqaslUOJntmxrqLm1/RcJD5mYSHuQjrkCdHnr3+oAy/9HPVT4MDMcOwm8cCJdim+JcYCWlltWJvaakfWihHoUX3Gz7Wfb4UkdElPYIfVm1fcayQsFXC6S7i5zPHnhIy43uo2jGqh82AruiEtNg0tr1RuSXHitQsZg0wy2xl/9DqA+aTgHxEL0Zh+flHD8Ubln2ZYEAvzRsZ/WpZRBO9oE9zaXIBHY29U5JhNP821H10r003Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbSMG935nAQVsn+w1fPas4D+XjTS3RLSPabxBnGNq8A=;
 b=ZerGWZ3cXS2/M2+pkKSv+ObCTiFniqw2dmgNEL6eTq9cPH/AeYO3DYJXbTuOiOkxNTcI8FzOSKPJ+6Xy7Bit11W/e5F7tpKbJbr55GyprFrmxwllgXlUkd/a91F6kVR7yRDB7aK+2iLnjmhEwtC60OoZFX+4hDiwLy6knGYnPzLivk39mZ32GykrWpde4b2IZQGSBz2ehhA8U1LjhMCpktCMX/Vmgbz6XxWMpwq6WMMcIYM3+Ga02LvGu1ouuZwqGhcObFzIPe6rhPRaLapRL+r0zU4S5vsUh6zwGsKC7eia2d7KXXuNk5jLmM20yCkaLRMcnTAs89hHRnHZiXlloQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8194.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::7)
 by VI2PR04MB10956.eurprd04.prod.outlook.com (2603:10a6:800:276::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 2 Jun
 2025 10:41:24 +0000
Received: from AM9PR04MB8194.eurprd04.prod.outlook.com
 ([fe80::cd61:3920:b12f:6561]) by AM9PR04MB8194.eurprd04.prod.outlook.com
 ([fe80::cd61:3920:b12f:6561%4]) with mapi id 15.20.8769.029; Mon, 2 Jun 2025
 10:41:24 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v2 11/11] net/dpaa2: enable software taildrop for ordered
 queues
Date: Mon,  2 Jun 2025 16:10:41 +0530
Message-Id: <20250602104041.3322164-12-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250602104041.3322164-1-g.singh@nxp.com>
References: <20250530071344.2939434-1-g.singh@nxp.com>
 <20250602104041.3322164-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To AM9PR04MB8194.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e6::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8194:EE_|VI2PR04MB10956:EE_
X-MS-Office365-Filtering-Correlation-Id: 99e5cdfc-6b87-4aa9-1155-08dda1c20512
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?YdkxI2zqzrqzTsjoHi172B8Fus1StFSFCDSs8jmhfQhXhsR5aZnvxFntVVxi?=
 =?us-ascii?Q?flXZa2dlFTNEpt6L/emU4dOZYl8S32OIf/w234kAHfI9wrvpzgoXmom8Rsl+?=
 =?us-ascii?Q?pklpHc2Q/qjZOQ5L0nyNNnW7QwIY6S46DJgYXRn/4jCufREtCTMpHOrZJXdh?=
 =?us-ascii?Q?+cxdPBOp8pZpobeyOHdOpGs+reVfu0FIOZabvsSdW1bVxC3oOlgdMo/P3KQk?=
 =?us-ascii?Q?upWx1llMR0G+vs1oLUDSvUeUWFZpXrCDzZN4SjM8/YfsUI9d5AplbBXg4iyo?=
 =?us-ascii?Q?YAvz2cqFusRBSRk5g+Z/ET7SW9yBk7tFyFpZ2tvox5Ibh0gBjm9Q1uIkkQN0?=
 =?us-ascii?Q?UoRbOFBb9UwiAZmYEjdRGsOWCtZrBTPBJJBsYdA+JdAnw9/mYzlKLaBU7Z6p?=
 =?us-ascii?Q?2T/261zjC9bgQNxtK2PNmLQvMllPQoQdAZQZiwVHK/WogfU5WPBJCSV75jOn?=
 =?us-ascii?Q?6CJr7+lymZUPT/8wRYnPib2ElpWmjOuEV2qLWip+RwFl0gmVa/V1wEfe7x1P?=
 =?us-ascii?Q?xUnYJjaOx6bTOK8mAuTHpOp6d/kH1pFfNWONhx07E7au1CqQrudWN1n3DeLE?=
 =?us-ascii?Q?CFPqrXCFcJxCj3b0gXTMOHNzT5dQNQCflhIGitZ4bm/m1AV3Y/UEVcOf3dcz?=
 =?us-ascii?Q?cppXef7JUxTFVMbZJmLcKwWiaEU7meIUQarHA241qFPCA2J2G5pQncczw2Do?=
 =?us-ascii?Q?q0ja8hI1btT+u6PRUZXOCcQnzp7mdmNA1uT+1MXuOAlWl3LHOEP1E3+r8sjk?=
 =?us-ascii?Q?I5UUDbLufUfl+K7JOpCnErKXbBGTVpNYphNieBUXdw4V6bji9HA6l8ZfoqR6?=
 =?us-ascii?Q?+B6DXybUmfX3IOYmd3CrkS+YknFGbeTJp7ORxlqKB0PG5cSDIVj+G+8do8nv?=
 =?us-ascii?Q?LuwkZpPN4nnATCR4JAnB0O9GrSA48bXyon5+M4P3SYcYoXqrfexOccFsTK8C?=
 =?us-ascii?Q?ZHRIADbhKpnTrO0HrA69GP6TA0J4P18N3trqNFb/DxJHhqS3rinaZT1hVrEy?=
 =?us-ascii?Q?mQniDLlHp2UuCpij+jvniik7oZzP0XAmTo1VlRQk/E4wFesa952m0okYhZP8?=
 =?us-ascii?Q?9eN5ptZWmQx9pvmxKqB/A1UYXTcn7nEzcMxgZIlOQU09e/jsU/bVw7KG4Rd+?=
 =?us-ascii?Q?td0YVITaeNwUUeWU5T1YzVdujZmYFm1Z+5OnvCez05tZVQ4Auzf4ea2wPGVh?=
 =?us-ascii?Q?AXFu0Cr8zjEGzqdk945FIcxPHston0Fyts+rng3Ttz5NsYWESpNxdBHthnum?=
 =?us-ascii?Q?witUDeguvE5oEANkLfKbHX8zXAiNJF0TUmG9J5TwRS/WqHzbrHjTDxCU8mkG?=
 =?us-ascii?Q?NdL2xiRBJ8BjtAk/J2kNEilXvliRAGGYQl7I7gvdN0QKcKksTzIIco9rCTWv?=
 =?us-ascii?Q?ipiJIW5EbXlc5iddRAda4aejal/xVYwl6E6M3SZb+8jEcOPwpAP6pYgcCBcr?=
 =?us-ascii?Q?3CqVPN4+hcLsFDnLSW02T+oDY8CtIgBgH7J5r2Pla34yl4CDMEAVCqN9Knu1?=
 =?us-ascii?Q?ahq3ifyipXsPv60=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8194.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iQOTq3JlFOOnzjbBR5gAkSd6zG3QhUCDN7DBD0oBGAJkf/t+d/tlUT4lo9pD?=
 =?us-ascii?Q?n5OYKyrhrmpR961YtNczyPE3CXB/bF12qt4lE2zi03zfkZ72YXoaLsEiFhAC?=
 =?us-ascii?Q?Ek7QcjzE53u9h9HGIhBWlS88tbng+xDT+lAP1RMrsjA8f/AR9QeVKoUgvaxi?=
 =?us-ascii?Q?3j4HztvACbSOPT6gF4I5eyc1PNdWZJEcy6sXEMgeZYDA50Xe1qpNNDlwmiV8?=
 =?us-ascii?Q?9WmQvsOxA7JYszkvAKBn6miJ+AcHHvD2Ejk6j8okOF/WM82NdGNb84OC8pL0?=
 =?us-ascii?Q?8YkfaDzI9Auis+CDLGuRQB7Sw2E7RjKf2D5oAJPYt/vF9Ope1n2UW14TFqcZ?=
 =?us-ascii?Q?qPlmSrm61PeypvkOeTa0OA6S9vOLXJ9MKltJuT4jK36S5Nx4053t6uPqt17X?=
 =?us-ascii?Q?9Yob7k8iAXgd6OyDXHeZ3Cj5EW+T6Uhc2AmXPAgpAoWiM0Tw5QT74SspCKDX?=
 =?us-ascii?Q?ERfRIl5csMvSGC1LIgGLXXHpP2MDl71MQ9+G07dHifEqKiZOJMQs18KXsDot?=
 =?us-ascii?Q?H2sFod10gVx/6DJPzOUWE5EeYCnS39GEXFvChJrvon9zdde3Owl2TfWSVkkJ?=
 =?us-ascii?Q?XwTQ3OZ0YwyYosC98ltTwMrQz8etmBUoXW8UQtBmEMCt3Z/JlRGI3Am0vV9d?=
 =?us-ascii?Q?7Hym4GLS2NSL97bR4kmJ4Tn2rlDW8+JoL5ol4D+eN/Gpnb90ndQI+xFYLyUN?=
 =?us-ascii?Q?tEiaFNYjRn61GKPy/0toFZ2rIWmOHL4CM2VwC/poDUEmdusq4eW6U+w1Ih9n?=
 =?us-ascii?Q?zvluXj2UO3BnozklSHoF6QrP94/WT3gEa3i1cbmzXJdP9iQ40dNZ3wMKR0cG?=
 =?us-ascii?Q?E2aFp824/Ce7BRer371ZNeuy0gLhAan4oH+cqvttpAdcKYKl7dm4X4xyDkzr?=
 =?us-ascii?Q?quGXhfI6scOIwuEpKLmyoRSRLZJ6RZQWSu47RN12IkVEUGyhJUi2W8NZKEnu?=
 =?us-ascii?Q?fzdAPYIan0EwZe//sd9qOitw1+g1f3Rpqh+qw4kTt1q3vwzLLJaLzT0PCZa5?=
 =?us-ascii?Q?7uSVul3KbiegFHGh4TDM1kOeFIIxQhCsbfjVcMq5Kp8H4u9NwbuhiVxJqKKw?=
 =?us-ascii?Q?tOq0sh+HYptKeNhSWUFgY5x8gV5n2lLXTI9XMOuKslrxZ1h03uC5Lo9RtIjk?=
 =?us-ascii?Q?BsgVcBlAwRr5tAzlFUkFxaaLveSjLQ07TIOWlGigiPQsz31g/PjgE6MBBCJ+?=
 =?us-ascii?Q?HVP4WGsGYpUPSgrbCc846GpD3E41l+FdlXTi9SmXNPk4gAghMHVH8Wo40spX?=
 =?us-ascii?Q?7y5bq8d85LurcZlWgmdDxbqzjoY2g2WuO1/os+1jKCZotmZgTpfvPPzkfT2Y?=
 =?us-ascii?Q?Sy0zMdQxjkMR1IrHkPAzvos0FVWV6ziW89JeecnT0yAW9ZaCyEBb+bASQ0Es?=
 =?us-ascii?Q?GMA+2pAX2WhUS2zXklG+JgeTTYe/i+93jIoVRW8HPcLMBmCzJDWYHZxHmug+?=
 =?us-ascii?Q?YlQZQGWIF5Yt/tijRcj2M8Iw5V3/9ZC3Evq9AT93ZYnS765Tkatssb1u4pvx?=
 =?us-ascii?Q?FNRX1HmidbTAuVfv88EVE17eXD3zLMnmLq5sOEarzKy2Ym7muAI2K41Ge+1u?=
 =?us-ascii?Q?Optru8ceyQJb+ChKwr78QIsubWk11MIFIqNFXgnG?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99e5cdfc-6b87-4aa9-1155-08dda1c20512
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8194.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 10:41:23.9671 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Mc37sVyRksjpDVoLv+gpJmsY+YC0OhnHlk5qoXobGOZYLEvJPvXSSxiUVLlGkoz1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10956
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

