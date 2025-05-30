Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D757C3ABB2
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 07:15:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E36404068E;
	Fri, 30 May 2025 09:14:33 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011018.outbound.protection.outlook.com [52.101.65.18])
 by mails.dpdk.org (Postfix) with ESMTP id 55FC84067A
 for <dev@dpdk.org>; Fri, 30 May 2025 09:14:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BV+N15HbTqMiVd9q2GUNjBczjMdWsdaQ9QZNWKQMJIllIecf2vh6f6qXJkBetu9CErXr/rL10y5yBBunUIQQ5W5fYS86PfaHWvQX8b+WqjlCqMQXSh8VgpLgHPGAaj0mchVg1tMwyiAz5il5nSShlsACWjbJvUTcKLikgOdZzfrYgpAk8NZ/6zFVl9tffQ+pwMa5ERJ18Lq/7LOrqAraOijdF4nU6BiY9mDjqYZaaIgRr4/Y8XhUBpae4Vqa+cFtScLJYYKWVnF/2N4jABWvdEnfRmP602YCaZNJjBDyy9m+CbbkG9/1dbFdCKHVDZ06qg+mDcGFgjgmLhQvoxmW1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PbSMG935nAQVsn+w1fPas4D+XjTS3RLSPabxBnGNq8A=;
 b=j+k7/lm/UaDhRXHDtNJgvSZu3+wPsOmuoG9Mfb0tveF+chOWm1VtUUISEXJo+zVpP2QI/F1h88ujEDPayvPF1FqUSkrZHnWFbIFz//LKoc/3c85oSgw0ur8tX7lMsjQSwiGCTKVMy5I09OTM3hTkLMN8/P7ad/enjYM4jWdmBh/uxqcfda9loWpVi2D4L8wRZcqKq+MlG3dlaBaEryUpAn1Wlc7ND1oysG9USN8MEyyISNbFKX+suHlSoZB3bv8UzQDGR6fQyrjf6LgIpvmYkDrcVzrwZJ+WdkKMJX1O463NATXl/HHSp4g30826sixIiR3e1wUA0BIX/cGUvTZ0rw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PbSMG935nAQVsn+w1fPas4D+XjTS3RLSPabxBnGNq8A=;
 b=R+mvK48YNKT4ZS1y9kWjcI1QNl8beC/ID7hNIlXndRnc1+Oz10tzK2gX5K4BqfhV42XLFmG2gD1TghE0g/aI+oEqLhnElbGGkA0DotLfVDdFW2EE5R/3o+3ab0oH95Ua6AsZCektKFq/tdPVfkT8dW8bvqmbbVhXSRTxy+IluycPsEGDy90tG8iD1Cp5jrmABFhr8B6RaGe9dOE8DDKu0Ufx+SFyO6O0+IcBKgjprKIOThGL4J0166ZQZaoCwBW9sPdjckpl7YXbNc4KZnn8p1PEXvBjdogVBrpe1a5512JMMoyVirZZb/EAA0MjS7JC5hB6i8IRqYdNILfLgK4kiA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8205.eurprd04.prod.outlook.com (2603:10a6:102:1c2::20)
 by GV1PR04MB10378.eurprd04.prod.outlook.com (2603:10a6:150:1d4::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.21; Fri, 30 May
 2025 07:14:31 +0000
Received: from PAXPR04MB8205.eurprd04.prod.outlook.com
 ([fe80::7633:884d:5973:174f]) by PAXPR04MB8205.eurprd04.prod.outlook.com
 ([fe80::7633:884d:5973:174f%4]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 07:14:31 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 11/11] net/dpaa2: enable software taildrop for ordered queues
Date: Fri, 30 May 2025 12:43:44 +0530
Message-Id: <20250530071344.2939434-12-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250530071344.2939434-1-g.singh@nxp.com>
References: <20250530071344.2939434-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0153.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::33) To PAXPR04MB8205.eurprd04.prod.outlook.com
 (2603:10a6:102:1c2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8205:EE_|GV1PR04MB10378:EE_
X-MS-Office365-Filtering-Correlation-Id: a60f2626-9fec-4666-2734-08dd9f499eef
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?14kIWq7SIzhhUiNML8+phS3APpuGKn35du19Im0LMFIPuHxpYYAeRuhZCOz7?=
 =?us-ascii?Q?yELq5JVbTXEkoj/Nu+Maskk1bRxnUbj0DCCrlleRrum+EiCqD2i9Y+lRT7fs?=
 =?us-ascii?Q?3fwaXjFz7OVubdnKoux5FzKeDeZv4MFBpKTsiMg3XaLDRFIW0wJAOdRsuoRQ?=
 =?us-ascii?Q?j9Mtk+QzatIiAoshWNhSvWFLrDl1Sq3EAO0zY2tcbEfZA6bXOuC0CY0ZzTn8?=
 =?us-ascii?Q?kOLbxEYOuwkmOAQ2OOLlQMgp33GJniXnjTamH65Woc1d+TYQoyGeuYaWkObj?=
 =?us-ascii?Q?R6B3q/wCE96hYz2di64qD9Nw6B4g6zkaRuJSbvpeMXoxxubJMZby5wGw+FHs?=
 =?us-ascii?Q?w82neFWifzhoKInLqt8IzEV+p36gwe+q0U5l571W2YxefaeNVFZ5QjL1K/JZ?=
 =?us-ascii?Q?zG9usnxyBZ8iVZTIy5qIBd8Ed0P7IJB15YKCc1340qNcVz8zrHR/PBEeHNdK?=
 =?us-ascii?Q?keDBG3rb1NG/3Vnu5m8BoyhQPsb1FI121tPMEy1FBStrH7a4PPK4WLk1QXml?=
 =?us-ascii?Q?YaJi6juRCqFBYWDxcnYNHRvMRAt7lw/xjaqznd8bGjkjiII24/NH8djRXcyX?=
 =?us-ascii?Q?UbquIxfh3Z/Pp124KyNlS1LcdwKCCoXxzD2u9DdntCpHxjZa5K6sBdpdswh1?=
 =?us-ascii?Q?1fCM5sncM+6wi4szyEadckMKgEcgxp+yLNLMaEFjOrgPfGhz7KYxmAnJ91tx?=
 =?us-ascii?Q?Icu9Qmw4ddiYtziUwb6s9Y72Ls2Eq1lpAAmZ6birWNB+OsmEW8PyT5NuQd85?=
 =?us-ascii?Q?6QT7D7vVDdZdKUHf6XMP5WuvG3j0C04PEr/nUHeo7U9UMcyMozSHAMn4XLQ8?=
 =?us-ascii?Q?/yfOAzeHyRKYJRzGHoRvkjIklDp42xeCEI35sxxwr90AFKzKhlESkQW/BYSk?=
 =?us-ascii?Q?NQKooXJ3P4h2MCYAVLLA3FD6hNlDGm2mzr1DSAFWpfpvaEwSAOsGotzjTtwB?=
 =?us-ascii?Q?PYmFlWidY18IhTkIcV+rFYNTJDBz5xadMURD/2P5BNe6j52eX3P0m0f9bZLV?=
 =?us-ascii?Q?Bky/vVfLgvRO4gW4Vn65Q4zHx85d9H6CNVwRWwo/0jDqaFaxTpZfAPpuhXEM?=
 =?us-ascii?Q?T3d+athECDvLVgt+q/2CHDe3THMWo5zCNaJ5zA4mw6OYaMB0goNutWkUOpV2?=
 =?us-ascii?Q?d2Wo4t2cyaEo4gQKOCvS5zGtYmmapF0EHeC5j62qTcBkf+ua9GaPzEe37w3V?=
 =?us-ascii?Q?7JtIr8O+Zp3DsAu/5reiGQzkbCDqjJtTIQ4tM3i1mM56Eps5SawaILPqiF4s?=
 =?us-ascii?Q?ygmuMBHTaH7NqcFzHW1fYZaw3fcddOJfp7VfabO0DhXXqHs9hC0t2DbCzpAy?=
 =?us-ascii?Q?SgoksWmPBA6v3HQvhN/Ief1y6VQo+ci+/w+Tuha4M75h4mVSeJHKF8AYd9AM?=
 =?us-ascii?Q?Nm9rPHYltXZh3nvnErvjVhbCIWxRqADVkhXiaHPDbhNoEv2mT2T83DonrLa4?=
 =?us-ascii?Q?Ckx5Sgn+if77EXXt/CyISesmEXmQpR+8/OocNDJjdf+5k95BZtTl6zdZwZrA?=
 =?us-ascii?Q?5FO1U5/7AQVApDM=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8205.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?z+yQyY77V6FDn1e5FG2b3x1L71CH9X1C0zBOyvXzTQGbhAmzuO/1Kp6NnFRr?=
 =?us-ascii?Q?Ox0tQr+WHAUX5UtVCZD0lKF9wLxFi8LSbewRnK2+hQ3ptAHJV73O/GybLoTS?=
 =?us-ascii?Q?TikoER1V/nDXboPGuRipnH9lcFl9pfYXtuY5z601Q0P5ijSAn2h41suJSNLV?=
 =?us-ascii?Q?ayU0StayK+h5y2JxaX/VR6AmoqpX19aO5Kvbpt3zp7Q3tUSHKl5aUcl1MwiV?=
 =?us-ascii?Q?2+fi5BaDshipqvuI7IsUvshQliOLYpVvDAhisjtZb5FzaY02oH7Pt8BywzGf?=
 =?us-ascii?Q?h1cb2Wisfyy7baVuH6V/bQoZcC6TQtFYrpx6ZJsfFuazNlVgmkUbKN7P6U6P?=
 =?us-ascii?Q?6/r/hNNJVsxm6Zcq4O8LaG83homGRO6nCmDOeQFz0NcKy/EKbvtpu2bVEIgf?=
 =?us-ascii?Q?4oHr5yYijOGqySoiBB/WFgRO03MizRpu5Z+MGOt/T5YBFSrBzqthTV+b6ttx?=
 =?us-ascii?Q?dWOmU8OwwGBuyspwi2G2SAvFAUwF4anixSAbA4mwkNkguOETKW+b34aO4Sip?=
 =?us-ascii?Q?40IKNJdODCRKjTk/XZX7buB44CtJTHoUlwmNM9kE18upVxdJqvKqluBUYdXE?=
 =?us-ascii?Q?eW9Hif0FB/kR+FhbMVig1oz6vhbrMXdPKOxPODqOGEyLoSrTZGIwMqaAW4O8?=
 =?us-ascii?Q?rGHeqJmXjhjo1BXb52Lv7qHFew/QEFrfWJ4sxioDhXpD0NoV8doCWQb76vNK?=
 =?us-ascii?Q?RftL3tHYqzAu/5MpnvGUUxY3q48itYDCmtFjWN7JaYvXkSncgC7QtQDkXZSK?=
 =?us-ascii?Q?LkHwmwRUiwufJeHANHi+QX/cj0rz2xhX272w1kD7ZrvlCpPeYUnLcwndFBgU?=
 =?us-ascii?Q?iqJYJi/0SYmSLwkkv9bNwVBJmYZfH/JD9Wxa2/M/YlVd8S0K9dgONvN1fFTt?=
 =?us-ascii?Q?ZvVA7JIahKySgp3ZRJIHnuSNEugNiikmbTkE7cuVaS5NK7clw+MsKUUyt77V?=
 =?us-ascii?Q?4E7Dzxz4OdEHwuELY0Ra6n/Hclxht7IZswcvFkvgo4eayFS/SrwQRyuQpRJX?=
 =?us-ascii?Q?96FnmIXpRmCQgPD3LJax6zJv+isvdgO/+PSiMHW4KbDnqhUI9o/bwGwBAMWJ?=
 =?us-ascii?Q?Xz3CjXeCTo9l5oU+53xf5JTHvRiMxfXlmaXZI35r0VdMeHSFsIt1fhC1d8nW?=
 =?us-ascii?Q?mKREWEFmRsHZXUn7a2VHCZdCIQpJNyu5nZlCtFvZ3VU3sjC6iaPRobki+Ac+?=
 =?us-ascii?Q?2WZA8JuGth5GowIo77Rnm01LKS301Ec37TjL3vIbvyfuJKPrdOdFBSpV2zTR?=
 =?us-ascii?Q?+UkOz9Y+u3axP5IBc46z0QomRd0lV25aZQJBUqsntz0/dBdcaOinw7xE+n7o?=
 =?us-ascii?Q?pTwdrEBYxxmsJ9wIStwsnbZasAD93GXUHFaqDUZwFlxckHCpNhcukqQzhx3F?=
 =?us-ascii?Q?CFxaY0udvULQIbVozTGtJD7IUBfQPdCepngBEBRQTaJyZHZGtrwDFQfwMV7Q?=
 =?us-ascii?Q?QrWn5X4EdTjs0uXNUovtj+qPOmWOfsECEPloZ4jklIQeWwOUjdiZb1uEeTIB?=
 =?us-ascii?Q?w/iNFGMc0jq5NenuXsK/qnXZLrfHSpzAktNKs9hFuZTPrsIQNgySrPV+B3+v?=
 =?us-ascii?Q?wvivpB/hqdPLAWu6lu8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a60f2626-9fec-4666-2734-08dd9f499eef
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8205.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 07:14:31.1722 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sO5YijuDiqupHpRhL0tyTX/MLAN9kRCXCUCaApt4//QRMW0O7vYeSXeX/ChpglAA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB10378
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

