Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 719D1C3ABB6
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 07:14:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BDF8740696;
	Mon,  5 May 2025 09:13:39 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id A8354406B6
 for <dev@dpdk.org>; Mon,  5 May 2025 09:13:38 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2106.outbound.protection.outlook.com [104.47.17.106]) by
 mx-outbound16-191.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 05 May 2025 07:13:19 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FBdjXi7IbZJwzMF3p+3TXcdfyr5m1mWIjuDKP9C6apTzTY69V9Ga3Xjueigvs8EvLPmX1zwAIYJSbHyGV37GRqEUryeN2rUb2EW9HUeodaQFjxrnrecJmA+uZDXTFbbGRgtBpVLgBU0IXvUHEcudXdNsyj+OiVCQvqx5YRqjdDenttkhump8edQQb266kUOKQ8u6inVm3zO8b1zaV4okeS58Em8xlUeG/TyYtj7e76/D6sug4v12LLasHR10gad5hmYEmff8ik6vff9Kk3KZctJigNbpr9R9iW0vHX2EWXkjTSV6mqHbmI0+7fehz8UZVaC7u5hpM/eRk3rRE8neyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQNu2jfNxbNMDICsJFLrc/sIt2TUmcdEbj5TBYHIhV0=;
 b=wdxfQJw5J0ZzpPibh/2DrzzxTrP6HpLbQs26mhZHnlIfONdjBoilWdcs0iGvhHPzotnqKqzQaj1Gv8H7JloFdYqwrfdKw7/+Oi7QTfdXDfYM/awiQn/QMrduifbQnoLiCMwp4F24y7tYnS07CGdmDD6Jog114yx2IHNa16JCW7UhJzobu6dmPSIW+DDcL9UqOlUbwKTjehcIgTReroT8kXDCngHZ4pRDXazzHQB9J+hhKCha71yS0RNHhhbnd0wGawxTxj1qrWvjgaVK7qCE8Ni2TiuwDakT/qEZqKPluFJtAum/HsEtdoXr94XeifZm0obTh7u373EWWJD7803H+A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQNu2jfNxbNMDICsJFLrc/sIt2TUmcdEbj5TBYHIhV0=;
 b=WKF1zSgZisE8NlVnR4nXS01m9KcN4q/QDxcvBOqa3g2IQz/K8ZEGJ0HXCe8IBvxaDNCMYSmiSJYwfKyntQ7bRCqNYj/7YlBnFzYDp1sBofr+t7Obrc/FNdqGOsH/plREkJdOG0jIoH5q3O/1ep9M6vV3cQ7FeUgsIe7aVijM78E=
Received: from DU7P191CA0003.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::8) by
 DBBP190MB2033.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:52a::18) with
 Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.20; Mon, 5 May 2025 07:13:15 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::d1) by DU7P191CA0003.outlook.office365.com
 (2603:10a6:10:54e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 5 May 2025 07:13:15 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server id 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 07:13:15
 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net
Subject: [PATCH v2 05/26] net/ntnic: include all queues into statistics
Date: Mon,  5 May 2025 09:12:45 +0200
Message-ID: <20250505071309.586015-6-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250505071309.586015-1-okl-plv@napatech.com>
References: <20250505071309.586015-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|DBBP190MB2033:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 33cb315c-7da8-4ec7-9c7d-08dd8ba44e1b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?IkBx/iNr3LVP8N7OODNq74cKjEU9ob+j5AdA23qQwskJ4a2tUc2fB1aKmklY?=
 =?us-ascii?Q?4+7oQWrsftSVvWMCDPwgbzBOxmemZgFnJm2tiET33ALC+QYIUN64a9ks52yR?=
 =?us-ascii?Q?5hjpRC6gOi3DMzvPM7ZNL9DXGw//BPz+vYepuIKFUhzioxgQKmNCzEUOZ0d1?=
 =?us-ascii?Q?s6saR9pACAoe9A5K6bR2+YfmP7kZc5ZWfJBmnQRks2ia1e+y0GSmI2TWsHHE?=
 =?us-ascii?Q?UccICiO4pudBOcDRJ8yphc3BZtSUrD4hgMJFLLDZfCh6eP0nHew6TGKyzrE5?=
 =?us-ascii?Q?9MgF4/BYq5XATk91BGDY8yi+B8cwZ4TwqIpZAkzls0zppSJoK62zeCK00U/e?=
 =?us-ascii?Q?oTuQenKhuuMdvTEr4pA81XKPnvbZYAfnsuvTAUJxdwBHz0Cx1fusRVIZlfFg?=
 =?us-ascii?Q?bBincPcykZRohkRAoUzEBihARh5IG1XJHl3BYKrT/6KOK41UMwfbYTcKsNtI?=
 =?us-ascii?Q?D7Ux3n6wRRmKOuMjm14Y+ruJSb2AwyKWRYz4IfFN469xdKtYFaYeLhPekBwA?=
 =?us-ascii?Q?vwMJDjlne+Z9+GvWfSiJP6HugACcAwECW3L19ZUVzBUprK+T6yBmDfl1xvNg?=
 =?us-ascii?Q?48/wSH4Kevj4DX/LTMZuxETJ8UUsG+CuME5pByh7fG1yFtjYxh8+3g0065tL?=
 =?us-ascii?Q?Y/AGBlLEJq55r7mKVq50nCnXYkDaFxpFwxthO0WYerVmwKN38DQeYHR679YO?=
 =?us-ascii?Q?hVS/fqfZHkclwBqjl7FnlDiSlT5idDD8RtcgMfhlAC7NWQB1EotuHGtcmy0v?=
 =?us-ascii?Q?ga75ExTsACMpN/fjmGD+In4xyJ0SR18Y6MQmEuSUaGrgVlUzvtSAFvklgdNQ?=
 =?us-ascii?Q?13Ks67nledjtNeBh4z1X2T3jwSEPwHmVoSzoDiCZ1Utaj3wbJyhsINm/uvjU?=
 =?us-ascii?Q?aTQXioo2HOIS84fTetolpUhkJHATeI3FUYUnMcbUVRtpYkrnwfky6g4Muy3R?=
 =?us-ascii?Q?WX8Nj3xpewtjgVQqnLkS/RfzQi1NlVeq4lviq4HC5IKOZoFlLZaKeX3idkfZ?=
 =?us-ascii?Q?Pxu7X3n8VRJVbQSWMgneuRbkvI+WsLnxe/ZiqLjIamFw4JFRchYLRiJy9Vr+?=
 =?us-ascii?Q?LJyMKBK8Op1cwmS+BZ5bY3ONk/wflH4MPfeWly0M+8C0AP1NPw+azPu/P4wp?=
 =?us-ascii?Q?3aaGCB9ay9OhMMDmSIT3OgvWVyTW2nzgX7k3GDpnx3EOhUK/x4KFUbU/068/?=
 =?us-ascii?Q?YFKNZgH4nKKAsEGx4jIBGwIlof005U7rAKt0T8OZRQKbUPFnZhkAxQD3tvJI?=
 =?us-ascii?Q?baf5epaeWzBBINAXaMcYE0uxL+whkdzlJdyDWA0/yIJEyfwsvtlmnug6AsCH?=
 =?us-ascii?Q?RbbLOVfNT2Mdwl7qXeYTSA862eBW8Bq6pT3ZTbeMMwdsC1I5L7z9D48kJSm/?=
 =?us-ascii?Q?GQ49UCf7frqLqgKJ7O34Wa0s+TaUmBjCJH14D0o1NTWtiB+GdYUhNF7hcFya?=
 =?us-ascii?Q?su++Hds4DoDCplF13AD1aVACD7qzQZVC6xow++1ghHh6offS8senwncvktJu?=
 =?us-ascii?Q?rvzGOeHke2YQIvklLsVpIuPQv1jD6XrliEmk?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: +lf67nMa4wpx/A2BhM1RRHbiHDe3Pjn8vBQlgeIIVGuGsIQ7aAY1zOx+eGw5vuX7EF6xIKNuWQbrSHZz3Jxy+BTBeTRiPxRi0+rDcvQ7l1PM+tP2vjmOt+Z5Jmn+dUDRJsIA+m/HFfGzhktzWvYQKlCH/YwCxipUAnj5/kwPg6MBKrT1wTw4VwVoKUB9if1voT8Q9rIT0fSIPjFWfrO8Jz7cYJVpmeBEd7Bcpj6yRYab8I+C/iGnz6VI0nITNIQ0WS6OLgKRvWyjPLXPzocBCt7T+GwI19JTyMdHa/2vPfE8kv2vXZJ3x33t7iBJSPBYvpsgNfyn6QGLWVZhf4SnQuF7KAH3Ja+o/7yUVt6DS/mxqhju8KHKJm3XW026SQu512qucAKmj9SF0JDG9OMLn/1NuqYc7YR4xWeMHlxiNHIX5KaQk/QzEkdg3U/+1xBadKVqqwt0h6xDbSIq/3EgtFOHRhlyPi2FP0kuYCHn8M2iX/h+HxDSN4nd25YDx/1oUqsUCdV6VUbfYI12ZDSdV7xmOvzjnMP+GGMVFsb384Zqhze2dfQ1R3OHetynHB+dCd0z32O8u82roOU8flJUthoAOKOQLQVqFuaSyaWQBLDtQIt6ZMtktg3CD9pEcEUFJ/spEQyhRRIJcgiAwP2/bg==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 07:13:15.6075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 33cb315c-7da8-4ec7-9c7d-08dd8ba44e1b
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBBP190MB2033
X-BESS-ID: 1746429198-304287-9867-4790-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.17.106
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaGZuZAVgZQMM08Nc0gLdUi2S
 QtNTnZxCAVKJVoZpBsYWGRkpyclqhUGwsA2NcNEkEAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264372 [from 
 cloudscan21-15.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

Queues with indices greater than or equal to RTE_ETHDEV_QUEUE_STAT_CNTRS
are ignored when calculating per-queue statistics,
however they should be taken into account for calculating the total.

Signed-off-by: Oleksandr Kolomeiets <okl-plv@napatech.com>
---
 drivers/net/ntnic/ntnic_ethdev.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index f9644b5826..6857191ef2 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -200,20 +200,24 @@ static int dpdk_stats_collect(struct pmd_internals *internals, struct rte_eth_st
 	 */
 	ntnic_filter_ops->poll_statistics(internals);
 
-	for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS && i < internals->nb_rx_queues; i++) {
-		stats->q_ipackets[i] = internals->rxq_scg[i].rx_pkts;
-		stats->q_ibytes[i] = internals->rxq_scg[i].rx_bytes;
-		rx_total += stats->q_ipackets[i];
-		rx_total_b += stats->q_ibytes[i];
-	}
-
-	for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS && i < internals->nb_tx_queues; i++) {
-		stats->q_opackets[i] = internals->txq_scg[i].tx_pkts;
-		stats->q_obytes[i] = internals->txq_scg[i].tx_bytes;
-		stats->q_errors[i] = internals->txq_scg[i].err_pkts;
-		tx_total += stats->q_opackets[i];
-		tx_total_b += stats->q_obytes[i];
-		tx_err_total += stats->q_errors[i];
+	for (i = 0; i < internals->nb_rx_queues; i++) {
+		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			stats->q_ipackets[i] = internals->rxq_scg[i].rx_pkts;
+			stats->q_ibytes[i] = internals->rxq_scg[i].rx_bytes;
+		}
+		rx_total += internals->rxq_scg[i].rx_pkts;
+		rx_total_b += internals->rxq_scg[i].rx_bytes;
+	}
+
+	for (i = 0; i < internals->nb_tx_queues; i++) {
+		if (i < RTE_ETHDEV_QUEUE_STAT_CNTRS) {
+			stats->q_opackets[i] = internals->txq_scg[i].tx_pkts;
+			stats->q_obytes[i] = internals->txq_scg[i].tx_bytes;
+			stats->q_errors[i] = internals->txq_scg[i].err_pkts;
+		}
+		tx_total += internals->txq_scg[i].tx_pkts;
+		tx_total_b += internals->txq_scg[i].tx_bytes;
+		tx_err_total += internals->txq_scg[i].err_pkts;
 	}
 
 	stats->imissed = internals->rx_missed;
-- 
2.47.1

