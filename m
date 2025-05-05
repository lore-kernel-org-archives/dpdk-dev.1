Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03002C3ABB6
	for <dpdk-dev@archiver.kernel.org>; Mon,  5 May 2025 07:16:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0E6AC40695;
	Mon,  5 May 2025 09:15:22 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 0920540677
 for <dev@dpdk.org>; Mon,  5 May 2025 09:15:21 +0200 (CEST)
Received: from EUR05-DB8-obe.outbound.protection.outlook.com
 (mail-db8eur05lp2112.outbound.protection.outlook.com [104.47.17.112]) by
 mx-outbound18-65.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 05 May 2025 07:13:18 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Jiwt67+Ahik3upNYiVehxnPZ/FZ4U+a+orHe2JEMDooSsquPJRnn2MdKHD3n7RONLCHEvzStFIjFMNkdizidzDutjk69JhuKXYB3wthSMZEDeFlz5Lqe1YFCTlCMM/vzc5wQt1mv3OB1fwzUAkHpzhL6/Mtu2CUQqN+z5riMwfwqR6dqXVwUsYgSgyi6uSui5/SngEPKBJjcCMn0ht55Zem4qe22QRnQM8VMN33mIOGBRz7LWy0S75tGizMNw9tEf9ngDSeCU45D/TriMSPq3lsP9FTeF7B+RYu9e5H3Mqd5E6r/pUixZ7AVEzz86c2yy2bRxDBl2siGHvmMZLJDUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vCJTRCBMYq+QYGtU2uhT7c3QvWnWXZ5aouejh512UIc=;
 b=xkkoClZxV0FKp6kskzfi5xVWIg+4BfPWghVA3KJiJL5zv1kmqDb3SeiS5BKqHtODvtrZI1hPjizyaY+O6iLO90/WbARct80MJJbFzJimIUcM/hUsnMwkN6MYCEPqRAyVwkWXJay/9gPxoR1rqCep/btvPCK2NkqpNA/gTm7Yer/9kJxvB5NuRnwUigPAj5yqzCtWDD5ScGTgznwi8sYKIqtjw7QWffJZ9ZpOlt6rMoHlSjWYDbCJ8ohyqTFh0pUb+E+0KqvVA9StSAkoKTS2kI2++N8bBdCHE0yu7WNGe4/mwEYKPfI0O1dbd5QsfiZx7/ULsx728nkSNtyllMPwuw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vCJTRCBMYq+QYGtU2uhT7c3QvWnWXZ5aouejh512UIc=;
 b=HnxyXZigsAUr+90Fpbwxy7LnYn+U0Pj6xSCeoqzZ8ZD1RdzzxEJQIlRe3qteof7SSlNXdGDA/l66/KQgcNqKOXRoP9UdEyyk0jCUMiy2GWHYo0JGEATKfy2DdDvUSR3EZi+d5jQpH31YuCvqdh+k0KU/1F+l761tutPNSBoWlE0=
Received: from DU7P191CA0010.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:54e::35)
 by GV1P190MB1875.EURP190.PROD.OUTLOOK.COM (2603:10a6:150:62::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8699.26; Mon, 5 May
 2025 07:13:15 +0000
Received: from DU6PEPF00009523.eurprd02.prod.outlook.com
 (2603:10a6:10:54e:cafe::2) by DU7P191CA0010.outlook.office365.com
 (2603:10a6:10:54e::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8699.31 via Frontend Transport; Mon,
 5 May 2025 07:13:14 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU6PEPF00009523.mail.protection.outlook.com (10.167.8.4) with Microsoft SMTP
 Server id 15.20.8722.18 via Frontend Transport; Mon, 5 May 2025 07:13:14
 +0000
From: Oleksandr Kolomeiets <okl-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, thomas@monjalon.net
Subject: [PATCH v2 04/26] net/ntnic: remove extra memset
Date: Mon,  5 May 2025 09:12:44 +0200
Message-ID: <20250505071309.586015-5-okl-plv@napatech.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250505071309.586015-1-okl-plv@napatech.com>
References: <20250505071309.586015-1-okl-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF00009523:EE_|GV1P190MB1875:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 08234c1a-ac41-47d4-d189-08dd8ba44d7b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?QPR3MriUDLuXUDt1sw4pk9ZnsxYQM7TAUiOHFMpb2Sp4+0udDIxihJISf+aJ?=
 =?us-ascii?Q?uzGDZmJ5dN8jK8xWQMhJTvpFAndCrmciHNOnzA+d6vipNEyGwvl47HN0ANGk?=
 =?us-ascii?Q?9uAy0/TbZCi3XYg845XuQXKE8DaIoSmJVDXa5z1mbQW/pKlb7OwnmN0K0gqj?=
 =?us-ascii?Q?zhtBWL3AvcQM2MZl8AyeljiVFvYilKrCn5mPL0yR2L9Y/x81Y2V3eWZQmtRS?=
 =?us-ascii?Q?e7WmLgYfOEh+ddW7tyN6RrF0NY2ChqJSgAKvkduTlIaDexL35A17zl4nFwJX?=
 =?us-ascii?Q?RdTzm8N93YTPr0Wmd3lotMTXdRrbseL91zsG13SsBj62dPjLrXLt8BCaQ2oM?=
 =?us-ascii?Q?ncoixReTCNNlKFW0FrPnkybRSPDHDMraRghF48/X/e6tSxIjE6/p3XRmzqxN?=
 =?us-ascii?Q?ZAm9OuxtsuPzKue28DVxSezPOAwb3HXx9IQaDMMVv9t4lKcq8mRZOyWYD9IY?=
 =?us-ascii?Q?VYCTt3PqWaOH+VmwjR+MfPJd77mjn8Jr43zqPlWkY3DrtN3dfKbNOfoOxVua?=
 =?us-ascii?Q?pa0zT44NKSlcWFHKFaTqgsnuz6MgocIeAAV8bcbq5+XuS0g69j0ouEDyGl7D?=
 =?us-ascii?Q?SI/Vzb/SufzMAlM7D5MO6emEp7X1wquNGTsJBeuBSmrVnoZ1i5L3PQVHFBk9?=
 =?us-ascii?Q?792wVWWI5PjCPPX83wbLN6HnrWNMBEenkOAodjEGTucTYQHFeJ3EPLXhiOJg?=
 =?us-ascii?Q?6gFQ6zd/vm6YuC9N8wU+YBuwVzqumC7LH+WflqrmEg8aeQU5+UjD4EJDJ6Ww?=
 =?us-ascii?Q?D2KbhoxVdyjR0qe52LDlx/bqbW6tPUKmOgSm4K6AADFIkGCCatiLgYPCroNr?=
 =?us-ascii?Q?ZDRYLMsQfjljQF5Z65q7ISr99CAcwQ8XjZZewAN9DDvqm1hmytpao9TppqCd?=
 =?us-ascii?Q?wsRsOwq1H3hxzH30Kec0XgT/VCbTx9BKK3JSQ+KUv5VbLboVPHT0OH+wuZvY?=
 =?us-ascii?Q?hSaroXie14eU8kr22YwqTnL4DT0lvhTacFY4XL8PEMV0m0mD0yAlH6fyC3Kb?=
 =?us-ascii?Q?tkGkcgHIidY2+Fc+7b6maQ/MeRVf+pJIW2b3/W+MpjM3vS53EmmHPpVbPWiE?=
 =?us-ascii?Q?o1PbFQ3dNz1jWSbJo66zFQcqfRz2J/eTNRe3N8ycKRxa8TWaxJVLrfl9OKgY?=
 =?us-ascii?Q?MoN4dgEh9Jya4XabsqXpjeQGn2/O8NhNHUcHcRHkJsvD2+FNNYt6oPx4q2G2?=
 =?us-ascii?Q?qyVUxasdacxux8ghwCf3GY2+pa3/aauVfd6KHEO/L66wxy3l1wm2DIyPZHQV?=
 =?us-ascii?Q?rHhqOeIK9YMkgdMQwqUBfMm14FtEmLsTanh+YKBNk1Ga+R2brBIRg0ViBU6k?=
 =?us-ascii?Q?L0Aj3LyubcIBu9C0aqzx/Sd/x7k2x8Z4ZPIsFLg7Tj1yD0G5uNYub9VxgMMy?=
 =?us-ascii?Q?tGg7pXTnwb/4kl8lyIdqSleHYY2SaphMLObHHrlPdkaXVM4fRNO7bw7OXoXO?=
 =?us-ascii?Q?qjfjZs5ImkWB6GdUNnThRt37Uk9BIkg6ntRMLJetlEvd784SY5gsEV5TuYgV?=
 =?us-ascii?Q?4/fQOoRo5RnboY8zSLRKsggo82YHrek1oGL3?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: v7vbPhzM0ahqUgP/0oboj3p4sFElMYE7MFs5uQCRCh2APXg3ttglRVuZz+qWMPTLty/T2NffHN+s3T579SwUjsfFbA3GlK9ahrrihP/1VPwpQnoVVTbnfPpW46+u0/a8Xd8y+5rdJkjw5jJDLPpTXiZTV7FCXjaSiqmFszSVGzabqcF1nMe0bE1sfh8b9U9WKFfuBAYCKnQkTKzxj05kueN2mjEYbZg+B7WQ8wDdQ3KmdVydZNH49ktT0JKfYQPXYw6MQD8Y7lMCZct3Y7u0aRUdx9UZHTD79p+rr9CXoX2WeFZcIoSp3s0f9OWEtx55B2MOB3r3Az6F6LDNQsfTjuDavATQXhmIv9nIzDCPJd0zSzyn6j/F/zkielMM1PrqPEwNs+XVZz47IkuhlOHOdqHqvuqPgvWYByysz6mdf+Kyil1suvq4+OIh+SrmsXGsMZGdzstC5P4bw+KzZCtDDzfidGeSNSiDH8+UQhbhM6hiFhkC7dPVhU/eqzkVVEVHg70v1x9sOl/3hLbRzMr7y9/gnQaw7NFtjHAK+C4tshWJx3xN92YjZ+aG0Xxsuhfa8fRD6cAfOGHPqXBMOU85oGi8hIrQxj/Y9TJrBIgruDldbp775Mca+oK+NmNnzm5rqCSxWAwoN/c0FZsQFPtV0Q==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 May 2025 07:13:14.5613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 08234c1a-ac41-47d4-d189-08dd8ba44d7b
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF00009523.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1P190MB1875
X-BESS-ID: 1746429198-304673-7645-371-1
X-BESS-VER: 2019.1_20250429.1615
X-BESS-Apparent-Source-IP: 104.47.17.112
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVpZGhkBGBlDMMsnU0szAINXQ2M
 jU0CzNNNkg1TLJMjE5NTk5ydwo0UKpNhYASYG6Y0AAAAA=
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

The function rte_eth_stats_get fills the structure stats with zeroes
before it eventually calls dpdk_stats_collect.
That makes the call to memset inside dpdk_stats_collect redundant.

Signed-off-by: Oleksandr Kolomeiets <okl-plv@napatech.com>
---
 drivers/net/ntnic/ntnic_ethdev.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/net/ntnic/ntnic_ethdev.c b/drivers/net/ntnic/ntnic_ethdev.c
index 9a6667b3be..f9644b5826 100644
--- a/drivers/net/ntnic/ntnic_ethdev.c
+++ b/drivers/net/ntnic/ntnic_ethdev.c
@@ -200,8 +200,6 @@ static int dpdk_stats_collect(struct pmd_internals *internals, struct rte_eth_st
 	 */
 	ntnic_filter_ops->poll_statistics(internals);
 
-	memset(stats, 0, sizeof(*stats));
-
 	for (i = 0; i < RTE_ETHDEV_QUEUE_STAT_CNTRS && i < internals->nb_rx_queues; i++) {
 		stats->q_ipackets[i] = internals->rxq_scg[i].rx_pkts;
 		stats->q_ibytes[i] = internals->rxq_scg[i].rx_bytes;
-- 
2.47.1

