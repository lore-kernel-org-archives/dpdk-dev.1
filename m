Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D1D1C369DC
	for <dpdk-dev@archiver.kernel.org>; Wed, 30 Apr 2025 13:49:30 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B82D7402C1;
	Wed, 30 Apr 2025 15:49:18 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id 4D1544028C
 for <dev@dpdk.org>; Wed, 30 Apr 2025 15:49:14 +0200 (CEST)
Received: from EUR05-VI1-obe.outbound.protection.outlook.com
 (mail-vi1eur05lp2174.outbound.protection.outlook.com [104.47.17.174]) by
 mx-outbound43-210.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 30 Apr 2025 13:49:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iZ7qLImpwDVIH94ZPBjuhmGXf0APwjYQhhq6DeRRv/HZQZN1Y9MyYSnMprsxvAPVflzOWObjdWpNTR7ESJqm7XFG9zBI+novIXe8kP3uDv1hrbDk+FWuL1cur2qItW2LV4hjXdOTE35hQFZM6MqkqpTp+c1OHmNKHEqEFE8iiHt4rUMzcOpc+L2E3pVfzIb2L3HkRnQUgzVVqBiEczHa9/7VQmQe8iEIb6G5Z08v7T8L3a1jVcKszqkb4d3QXSVrqTphVSu/AbAK+WZeDC43JeUN6S2Q697/V/t8C6wzMI1sWaHXbxQL/YiG0oYqBvgMN3NXwzB+L+1qF4/opZmUOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SQNu2jfNxbNMDICsJFLrc/sIt2TUmcdEbj5TBYHIhV0=;
 b=BzTJ8eTGbtolJuH1pvFcuzkSLwuouKKqYUZy06A+4SmMUeZcqWG4taYH+PWJqg0RJjT24GBmKEwSJwM6DJwkBJmapxImfCj0iV/5h4OrWLnu73Gfpgaawzd9fJ/FETg0PfiFqPs+ZlnwyB3vFUX710rsAt3Q8qjl9mRZuXIem4APniZbS0Ub/jHqH4uK4o1PvuWIdVM9bDuENyqx40Q2kDJXrJv+PQPxc8RBELI6427RTpDR7hW6i5/OeJB3k/alJahSjKUFKL7yZ50KkB67hqcXFI7VJjTmYwLV3EVjgWB4Cimen72yiTqE+woZTqy07z/UOsWSCFtl9plwpX+mOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SQNu2jfNxbNMDICsJFLrc/sIt2TUmcdEbj5TBYHIhV0=;
 b=n+R92eVygWH0MiFsZ8r/f/OfYe3DWg2gznL4ZoQKcvMXxbWfIHwLhjXPm4PU6yJoULXVCAeMBGVTSl7SHNZS/9u7IwSHQX6JzsHPPARewTyy8G7I8MQ0dsvCLFQjHNWsCz/2o2bg3OuH1rg/9qvqE/uvX1XslXxfbYFWVm1hQu4=
Received: from AM9P193CA0018.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:21e::23)
 by DB8P190MB0604.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:129::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8678.31; Wed, 30 Apr
 2025 13:49:09 +0000
Received: from AM4PEPF00027A69.eurprd04.prod.outlook.com
 (2603:10a6:20b:21e:cafe::d8) by AM9P193CA0018.outlook.office365.com
 (2603:10a6:20b:21e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.40 via Frontend Transport; Wed,
 30 Apr 2025 13:49:09 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM4PEPF00027A69.mail.protection.outlook.com (10.167.16.87) with Microsoft
 SMTP Server id 15.20.8699.20 via Frontend Transport; Wed, 30 Apr 2025
 13:49:09 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net
Subject: [PATCH v1 05/25] net/ntnic: include all queues into statistics
Date: Wed, 30 Apr 2025 15:48:17 +0200
Message-ID: <20250430134840.402553-6-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250430134840.402553-1-okl-plv@napatech.com>
References: <20250430134840.402553-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM4PEPF00027A69:EE_|DB8P190MB0604:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: eedc1e6b-dc2e-4066-3860-08dd87edc82f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TlhzQPTVd3yaYGo7bc9NyHDRe1EdbsTQZMNZz8tMSSASnEQnxnvHYrvXe4g8?=
 =?us-ascii?Q?WdD8WNwXXv93Ji/IBt90ycPdPS7njOzCtECESVqAbL/+qSrUsz9pzQk0RFRR?=
 =?us-ascii?Q?v8Vb0qfaJWoyFsVsZ/g6FlHBndysOWYaciRHtUo7l9fw5EM7hXKrnyvW09ak?=
 =?us-ascii?Q?wvttl9B+sv3Bn4PwS3j7Bs17m6QjilJBXcQhxViMQVhA5JrPKzY6Wee0g8OG?=
 =?us-ascii?Q?Mdvov+S637SoepHuymLZKmDM8x6kLzJkJesRjXxN6BTNh18NzRRSX4Islvsl?=
 =?us-ascii?Q?9mQoH/zow+QCAzaSlF6v+de+8wIbdFhtsjFsDtkmL7c2kb3q+q7pcTuy2fcb?=
 =?us-ascii?Q?4gd8jD8H+TN1NG3FiR6YZvgllAZ+KfH5ROmq9nLfXXPWCqB75hC0oBX6IUR1?=
 =?us-ascii?Q?jRU7KmDZXIejTUNkM3ID1gxznYE/zlrbsfalsv088n+34Nag53G6JH33wdsU?=
 =?us-ascii?Q?kTsBDnSjSAwUMxdlQQEyBfAvGkuQo/BlkmJectohwL7ktqyouVsvbiOM+6WN?=
 =?us-ascii?Q?hRjDIy/IBtjW1f7qBqP2ZFuv15zCtEr3Ln0Bbi2jmCHS2uchqT0vLYuCGTy7?=
 =?us-ascii?Q?1BHYANKxgu0ny5oNvnxw3t0UaoDpUaHRA8/aHl2/r3zWTTEQZGotF4gU1esE?=
 =?us-ascii?Q?rjjEZ9aDJsYZZx+pcJ3Bcho4DfDyrrGlWuGsyfjie/2t+/wL29+1W7TCA83j?=
 =?us-ascii?Q?3ZzFP7hACI1GNjOA17CgItgUePGF8EYjZJumvFVBW4/qa+8SQTxx1rciMjAe?=
 =?us-ascii?Q?EdPzugpdfPXF2CafssOMGQ3Bl3u+14AbeScunT0A6iluzzcvKAWKPpktionL?=
 =?us-ascii?Q?qCVEwR4GZSnPXHJIjzJf7kc7ASd3fVhzKkjyHCqrX+tRKGFvyWaMSrpv+qZs?=
 =?us-ascii?Q?FqKT1XmT4y0tstQFKWGn5YvIxiGDHlF6Z2L75Z+6mtYrgsGIlDkTK4JQMg70?=
 =?us-ascii?Q?ItaMhf7gbZROkwtAmx8Erin6tz0RqoVJ2gQVd3JJ7mqir3stAhiLXzp6nIs5?=
 =?us-ascii?Q?nc3NOAJfWAlRoPd+NLv3oZhVHq1JdYE+tXX6HZuZcDjXsMT3Wa8CbdJx+3WS?=
 =?us-ascii?Q?abTPASkHzdYXbqnwHNLn1J4jRoxqurES059bQ9KC1uuIa6u1HPqP9hFBaioQ?=
 =?us-ascii?Q?GNVEQp5wkDezTu0j6a1ZLdOl+h3L6MblCOTJRUId4Hi2S1kpDQtbJT+xr4DM?=
 =?us-ascii?Q?GyuIlInWl54tLniKI7JIXNfkRoRYhcwicrpf8uqNeObZKdWqHcnB3JeHyOzf?=
 =?us-ascii?Q?/ThJGVVWIf64eYSh9W8vfg+2VUPRRatrkaryJsLUqx6HYaOqKiyDp7zX8AXu?=
 =?us-ascii?Q?3KAGHHbL3DUSH+EFNyN0d+Fc2jAOlK4LNj6sOFEMLWeeacrKGMTPlctXqHoI?=
 =?us-ascii?Q?vvVGI29DYYeCqnv6GtU0sZaFfGdTr79g18E+NA+VWI1n/ldWqdNSzOmZVLfk?=
 =?us-ascii?Q?ynrFwmdhZmlk/7NOx8nZ/YY7kwdCLIHIeDDe6heBIRri8Xm/St2MZK2VUTiv?=
 =?us-ascii?Q?wYa1Brcs2q1yAvEYIyTchNVWilS4vNFykI4T?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: nHS5WYfBqLVZLByOsOFhZVdzgPa7OhMKyryJviTNWOoDGwKs0ZXkEQt/HQdNfCpAVspDWgj07m2NV/AlmgnBIzWEcBsB7/pFC0N5oaQudrK8jlHqPZplevF9pkN5/czttxlzLQsOlsZ+nkExE/ifrCGF4rM1d0caap27Ms1zjyHEVXnVrCrT719qB0vd4OLAHZX3b2reQ0Gdp3XRN1AaW9kt77jn0niPk5Puye/aAsO/bYjxpBgyqtn1rMphsNkkHWZGVkt9NDc4NtVGUVvGKumGXQrzaORzO/hwEJQOgwypGja4bt5HggvDPT42JrwLBs1HzZMPfwfF3IH9wbl409MubuudX693xq28XuZAnENaqOuTUFNA8lreZNCGnecbkV0F4/neA2LUrlrAdQL7R6LdOeI82VZOEBnaeQ3OAE7gWx9Ia8lprAmjlcDGFXs+pvjdqDS7kxZ75a0HBLdi/yr/rpUery/FroQCir/BkmSQ6AffYH3FOLZEIde6nloAKmBlZ+YYy9W2RGIn8Elxgpvpiiez23PB7quhjuZSa+xHEiutmr9nIoz/nK25ULZ3qMhthh31X8HpBjRTBzj5Zh2stDxSvU8YSyI6iWqi2s9fliNmda2CLuwAknOzyTYn2SBXxi/MewfF9I5R4Ggkuw==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2025 13:49:09.0763 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eedc1e6b-dc2e-4066-3860-08dd87edc82f
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM4PEPF00027A69.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8P190MB0604
X-BESS-ID: 1746020950-311218-7643-8863-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.17.174
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkaGZuZAVgZQMM08Nc0gLdUi2S
 QtNTnZxCAVKJVoZpBsYWGRkpyclqhUGwsA2NcNEkEAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.264260 [from 
 cloudscan18-239.eu-central-1b.ess.aws.cudaops.com]
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

