Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 555F7CCD199
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 04:49:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B5D9B42831;
	Fri, 17 Oct 2025 06:49:17 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011059.outbound.protection.outlook.com [52.101.70.59])
 by mails.dpdk.org (Postfix) with ESMTP id 05FB142C24
 for <dev@dpdk.org>; Fri, 17 Oct 2025 06:49:16 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nCfM2jOlOjMlUPN0JuigFtAIp1r47bhfqaN3DXaSfP8zSPos3bUnMONOOuS9O0MDzvsZqM2AI9SBbUIWHhBCYERyPhh3WoHyCsd68yzkjH7isVSlkDWh1fnYMajtJmYqJT9CZOUx4ihp3csBj5QTt0wnTUFbIhug7aIyTCOCyGGhPBnhweaaIv2f/0+lhKUdABZwYvcCJDyaAQXYqxR9JL+EBNwkCh5WA/GBI7DYRFuscIgk0t3+mcWXCTK+dkOuyYBUvBsqnsuaq4nbZb8SZLTJ0vo3sAgl7UNEYN8IoUz7zu9v5xMPZOe+PRu5nmChrq49lDUAnuC+MB7SVlXs1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7D4dEr11fdoH4LbXnGYrm/tNbu2v79hHX3b1rf/jVOM=;
 b=pRvZlLaRAAUR4Ac8/ERCekW8T1Emb2PwxJQ148uaKWvOWo11tSQ1dHXoKK10V6ITEGTIYDF29ejZrAuGgP90HjJs0L5+WVtugaMSCydZ8Yu1/XX3cdrRPJbzKCQn9tCwdlsb4EgYopkZ/piLM6QPtGRX8a0yD9EAJfuDl8bI3jn+iQY2MuwbpBjDmzOfdqWiYpVqfU6YqFuLpEkI1b5qyUup4JInAVIT6DMTPNmwIXmceaTojRauEuBMERp4VUnW/d07V5R4mLhMRIhjXhm6np9vYwXPnoXvPEpn39qY0Ava2fXLQWiCD4l+zuWeMiZZeKK3FwttrzK2U4i9aJQuzQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7D4dEr11fdoH4LbXnGYrm/tNbu2v79hHX3b1rf/jVOM=;
 b=PsSHjrmsjb/BsxmrL7Y2s6cIti7G2MXZCGTYm9vtuUDIJcymMZsKSlxwTVF1K7csTJgZrOrPKJlYAu+pzlNuQIt3CX16x8Dn21rtRXDoxXjin9cY4LJK7dnRlHZtykkblWiC0bmcmn9H5iDSsGGR6wV9dDr67zGtiQjcwfDKYt3gR/UWOuYH54KVJ1kWQ+mG9CqKCTRDOQAVDb47SmetLFk02+yppEBSkdyyQxt1OyC66rrL7soTrk+bccj8qLpLzHy+corDMV7Mu2w28vcAUvy/32Y25wGc4gdUOKySrePxJeCJTm4jClLS8tmjrRepuWEr5S4DpeTt74Cw007z5w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by VI1PR04MB6942.eurprd04.prod.outlook.com (2603:10a6:803:136::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.13; Fri, 17 Oct
 2025 04:49:14 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 04:49:14 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v5 5/6] bus/dpaa: Set max push RXQ number
Date: Fri, 17 Oct 2025 10:18:47 +0530
Message-Id: <20251017044848.3269627-6-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251017044848.3269627-1-g.singh@nxp.com>
References: <20251017044256.3264737-1-g.singh@nxp.com>
 <20251017044848.3269627-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0023.apcprd02.prod.outlook.com
 (2603:1096:4:1f4::19) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|VI1PR04MB6942:EE_
X-MS-Office365-Filtering-Correlation-Id: b426f56f-4746-42fa-a3f2-08de0d38852f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|1800799024|366016|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9prsIIsfrubw1Cvd5EaQiDDUBrr8e9yQ6UWz2rM7/YwzBbbP1NDXBrc+g2Mx?=
 =?us-ascii?Q?e/eIrEUGJuuy2Uy6ehfdZZx7381mttEOj3nLViGsrpd2LraMbuG+MMJ8zX1O?=
 =?us-ascii?Q?nxfJb55JaC1S6AXcnm09GOJspkqyAFImMrDN3efrnzE/8fENH6mo8U5Iw8AE?=
 =?us-ascii?Q?BciQ3OUAXCyM+UP5b0IxxQ7o8qJjzMln2xYM6BFR7pI5W/judbhCitsCjCOc?=
 =?us-ascii?Q?PkoyMrYmFoyqf44eWruvJpZFlH20etoZOvC70t8g9IWZ6VbNpaUeQsGp7B5F?=
 =?us-ascii?Q?Ll/rSHx7Mj+7segog3WpD7YaeqMYNLICJoCap6pLWG267ihXTzyqSsU1ZOT8?=
 =?us-ascii?Q?a9MpqSxYxOF8+avUpL08C+FmTGmGKokDL8c4WU4W/+Y/uF6KXKqd8v8AkItJ?=
 =?us-ascii?Q?yAnO71JiJR2MrPOdKxtPeVWM0rwu4qmpv4y9XO0cU0Paer14vPyj3DzjopUf?=
 =?us-ascii?Q?1NzjwWChXH0AWoPyplDoVMf5LqMVaddBMg13d+PmxXvQdQbjqfLg2ZCjaAcK?=
 =?us-ascii?Q?d+OjDeoQBlvBA0O9sU1DXFWzlwSzsvMwLT+rWiTkPJQ+lncZeoSb3PWnzuVk?=
 =?us-ascii?Q?KfrG3tGUjJ/X/PgBi5grr2RMDkAl67vJa3lfRT7ePvQ0PAPbYkLnK0e4UFKT?=
 =?us-ascii?Q?W3D45P8Ik/AyK9VSer+SRrdJ3zMw5il9o+n60j5EP+DCBlaQkyfWyZFmUI6m?=
 =?us-ascii?Q?4Us6EmH82zmVxnGYo+GXj9odH2DUJ3qNTKCBCRvSG/huKN/xiWQK9pbyQvAl?=
 =?us-ascii?Q?gaBZnMzsbxFR3UwXucpJx9U/xhwSifu51FvDiW91IJDIaepP0+Afk2L2vdJG?=
 =?us-ascii?Q?nUulKVyfZrA/Ss4utSHj6u/F1PEFX6F/vNUR1ghT7eR42zZaYLsY0OwIQ/K0?=
 =?us-ascii?Q?5JW8zKny/2M/a7mJu3JOaX49JP1heYKUQdJpubT9+4vZKximgrQV5W4mczlX?=
 =?us-ascii?Q?aMdhIt7UTZE8LiKzWH5dquMswlmfrhitnggJTZ0pErv9ODOEGoEfSNa3o6TJ?=
 =?us-ascii?Q?z5GknDFK/oDaPyk+t2qMVokm95XMZOaxg5eDw+TsEPNmN2Bj/DLezPXFV2Tt?=
 =?us-ascii?Q?Cxy1F6/kb/FDWH08aLifJvC9cz4sZWWk2xr+/x/wQNEIP5N71LJBtrau9mA5?=
 =?us-ascii?Q?bqQfb2G9KvCBv0hvg3eaKpn2wtJFv8SxzHAdJ1mT+hiLmiZjqL0SaPtAgYor?=
 =?us-ascii?Q?SCYHlzRBALhzhyttUHTHV/xOki1JzGtAIFICKllQaAfixz7fMy5PQUjCXN3N?=
 =?us-ascii?Q?r2+g5suffB2I3JWvD/EGT1gf9PGzBGkctgmD/Z46l7UQHTHIC3h0TBUxtMqA?=
 =?us-ascii?Q?ve8RThLpZjCm3dIEQwXjy5/dDrG8Kvr5Z/XoRTo4fu7sBI1UL92ipF+4QUG8?=
 =?us-ascii?Q?zU4JkKWoLSZJeULzJoMHs+8E7l3JYU+bsaRmxPN+Y3ADU+eo1UCkeOHnk6Fo?=
 =?us-ascii?Q?3cGHuPyJbk5eTksnkbiT7+j86bjFSLeo47rUstQTXKvEUsdBlKpTJkK88eA3?=
 =?us-ascii?Q?uCmkV9N7l/C/bBiYBwU9HdzbZRmEvFfpwlLK?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(1800799024)(366016)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?chEm0j0tHH7kQs6fPOU0Vs8q/Q1DQN8OOUzY+gobl6YVZ+Z1lMj/bevhr2nv?=
 =?us-ascii?Q?fuV+0OTREzIn9HGuEMziw2/SPM4zfeGi0CMVKjxQjUynnxWimHn3ITD2rJvL?=
 =?us-ascii?Q?5WQ2AyQzXpGIc8ivkUaYyugXN+gg7TuOdLHE5qBycQ/jm4ZzKK6/BSsvHrcN?=
 =?us-ascii?Q?GoSZtXALijyuwYnUoTQRtb9xHm+dkaJ3ecfU3/vZwCtHYvqZ4hmymJVLVy5P?=
 =?us-ascii?Q?NCUn544+Uh7GdTIqT84QGw+udFd6PUe8iTEbmsu6CoLXKm5vZ2OO6bbRS23+?=
 =?us-ascii?Q?z+G8Se8/7MGoArc9GN6YP+6Lg3c6BmZP9GG1soDIXe0RyihnP1BCVhrbB2lW?=
 =?us-ascii?Q?8KDS71zys3yUPeBdyX0Je+DhdBkRPj4/Ymp7QiPDBHuoxToN0/19M/IKXBKD?=
 =?us-ascii?Q?AC8br/nI3Z3Ni+xHRVSBuwrC/gqTyGvX8MDX/1zzZW4e4F4MoKG60vnUNDTz?=
 =?us-ascii?Q?XTLkwz9BMEowFl6tKRReZ3vlAZ861ELC1ZGTjwVLZP98Y6EblkFSPJIHcj5+?=
 =?us-ascii?Q?tPHjaARi5K+71t+0O6JdjsqneFGJZjTxRgJ3qdK2MNW1/DqXZwi9siJY5H2p?=
 =?us-ascii?Q?q1j+nHalaU9e5YtBEwmX8/ZLJeokbXi94QWbdyfzLt+mnxws3BD532HYyAbZ?=
 =?us-ascii?Q?EUO+Bns1bg36Jd7sheZlQgdWA6fKgv56TKMxhcmFJG0P8I8E45H4V4U0OAdk?=
 =?us-ascii?Q?3WUAJho6ZeMTxDaH6IbNtaGgjCGyj81g+3e18DUHQ8fOyaRFzuF9uXwqR1A2?=
 =?us-ascii?Q?msoBxSaf4IhI5oHYqaolFPAzJjqrlrGLYKHR4FM5da7fzy/ckHJqp4f9h+UB?=
 =?us-ascii?Q?0tMOWh7UfaYr283NAcTDLGCigCrC8sbNypmmreh7sqK3HLKVlUi3C3UxZZtx?=
 =?us-ascii?Q?CJa28Um9DY2Z5akfh1y813RzKi01QEImcYizoO8kLPleCo2OMeZzuOFdkiso?=
 =?us-ascii?Q?25M8uzu8TqhEAUZdgwYgB2W3Z8e4Z3pQmoyEtY/ny5+YY/DacO3Y+Fa0N5Gh?=
 =?us-ascii?Q?6ga2VMi3lTGvlbqrniooXcLZgG0Tm75IdUSOvqLZbC0cqQ0q0cBEI0COxS8d?=
 =?us-ascii?Q?T30Kk960AU6basXEdXPfwWU+7YjRrLffmi//9U/NJ2e4X8cLZ21VsSBxY/xl?=
 =?us-ascii?Q?4Zb92D0JM4Jmed/6v66nFPG1uDY9kW8CmtncWrBnBk7GjwPAwaYb427+ULoY?=
 =?us-ascii?Q?qn5rMjS55NN6lBvWrmHdvkvwFuNO7mLQVNxoMTeNEGIr7W+CEJfsUe+Ai1dp?=
 =?us-ascii?Q?Q4Lbvh28U5aBHFgEtx7dBz9p6k7iHn6zeKTaSg2HKWSHGrg0S55IXGb2MyVG?=
 =?us-ascii?Q?D4HRLMOVbvwgLymV7Oo/QxWLdmgXturFtTyNeQrVZ5JQW63I52btk+V982C4?=
 =?us-ascii?Q?VU5gl8uHZ19mjXU2PMFUXSI1DfHQHNbe3VJsZe9eTO6q1/DYrAUCNdr2q9qK?=
 =?us-ascii?Q?NuXWBycyycRxRc6W1iR5MLBT0qPLNZKIMghc6+hq3IfS4PpngNBaYxMCBE5R?=
 =?us-ascii?Q?Z2sBoRo9qYaQ3ltuJJ/wp1GgM7PJwVN+DgbwNGWjrlhiAdCgK6D1RT8SOZLO?=
 =?us-ascii?Q?CELR5LOsKs9+zdFKvaAAXuG3RuKbxARqBjBpn00k?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b426f56f-4746-42fa-a3f2-08de0d38852f
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 04:49:13.9743 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: d88GqqD4U6WuErLnz+ZKBElh1sfOj/20q4+rCtrLc6YTVI7W8K1k5lu6KWT30sKa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB6942
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

From: Jun Yang <jun.yang@nxp.com>

Max push queue number is bus level number affecting all dpaa devices.
Move the configuration from PMD driver to bus driver.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/bus/dpaa/bus_dpaa_driver.h |  6 ++++
 drivers/bus/dpaa/dpaa_bus.c        | 51 ++++++++++++++++++++++++++++++
 drivers/net/dpaa/dpaa_ethdev.c     | 51 ++++++++----------------------
 3 files changed, 70 insertions(+), 38 deletions(-)

diff --git a/drivers/bus/dpaa/bus_dpaa_driver.h b/drivers/bus/dpaa/bus_dpaa_driver.h
index 976f356699..cca0543432 100644
--- a/drivers/bus/dpaa/bus_dpaa_driver.h
+++ b/drivers/bus/dpaa/bus_dpaa_driver.h
@@ -249,6 +249,12 @@ struct fm_eth_port_cfg *dpaa_get_eth_port_cfg(int dev_id);
 __rte_internal
 uint32_t dpaa_soc_ver(void);
 
+__rte_internal
+int dpaa_push_queue_num_update(void);
+
+__rte_internal
+uint16_t dpaa_push_queue_max_num(void);
+
 #ifdef __cplusplus
 }
 #endif
diff --git a/drivers/bus/dpaa/dpaa_bus.c b/drivers/bus/dpaa/dpaa_bus.c
index 1a35aa52df..d9830b68ca 100644
--- a/drivers/bus/dpaa/dpaa_bus.c
+++ b/drivers/bus/dpaa/dpaa_bus.c
@@ -50,6 +50,13 @@
 #define DPAA_SVR_MASK 0xffff0000
 #define RTE_PRIORITY_102 102
 
+#define DPAA_PUSH_RXQ_NUM_ARG "dpaa_push_rxq_num"
+/* At present we allow up to 4 push mode queues as default - as each of
+ * this queue need dedicated portal and we are short of portals.
+ */
+#define DPAA_MAX_PUSH_MODE_QUEUE 8
+#define DPAA_DEFAULT_PUSH_MODE_QUEUE 4
+
 struct rte_dpaa_bus {
 	struct rte_bus bus;
 	TAILQ_HEAD(, rte_dpaa_device) device_list;
@@ -57,6 +64,8 @@ struct rte_dpaa_bus {
 	int device_count;
 	int detected;
 	uint32_t svr_ver;
+	uint16_t max_push_rxq_num;
+	RTE_ATOMIC(uint16_t) push_rxq_num;
 };
 
 static struct rte_dpaa_bus rte_dpaa_bus;
@@ -91,6 +100,34 @@ dpaa_get_eth_port_cfg(int dev_id)
 	return &dpaa_netcfg->port_cfg[dev_id];
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_push_queue_num_update)
+int
+dpaa_push_queue_num_update(void)
+{
+	int ret = false;
+	uint16_t current, new_val;
+
+	current = rte_atomic_load_explicit(&rte_dpaa_bus.push_rxq_num,
+					   rte_memory_order_acquire);
+	if (current < rte_dpaa_bus.max_push_rxq_num) {
+		new_val = current + 1;
+		if (rte_atomic_compare_exchange_strong_explicit(&rte_dpaa_bus.push_rxq_num,
+				&current, new_val,
+				rte_memory_order_release,
+				rte_memory_order_acquire))
+			ret = true;
+	}
+
+	return ret;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(dpaa_push_queue_max_num)
+uint16_t
+dpaa_push_queue_max_num(void)
+{
+	return rte_dpaa_bus.max_push_rxq_num;
+}
+
 static int
 compare_dpaa_devices(struct rte_dpaa_device *dev1,
 		     struct rte_dpaa_device *dev2)
@@ -681,6 +718,7 @@ rte_dpaa_bus_probe(void)
 	uint32_t svr_ver;
 	int probe_all = rte_dpaa_bus.bus.conf.scan_mode != RTE_BUS_SCAN_ALLOWLIST;
 	static int process_once;
+	char *penv;
 
 	/* If DPAA bus is not present nothing needs to be done */
 	if (!rte_dpaa_bus.detected)
@@ -709,6 +747,18 @@ rte_dpaa_bus_probe(void)
 			rte_dpaa_bus.svr_ver);
 	}
 
+	/* Disabling the default push mode for LS1043A */
+	if (rte_dpaa_bus.svr_ver == SVR_LS1043A_FAMILY) {
+		rte_dpaa_bus.max_push_rxq_num = 0;
+		return 0;
+	}
+
+	penv = getenv("DPAA_PUSH_QUEUES_NUMBER");
+	if (penv)
+		rte_dpaa_bus.max_push_rxq_num = atoi(penv);
+	if (rte_dpaa_bus.max_push_rxq_num > DPAA_MAX_PUSH_MODE_QUEUE)
+		rte_dpaa_bus.max_push_rxq_num = DPAA_MAX_PUSH_MODE_QUEUE;
+
 	/* Device list creation is only done once */
 	if (!process_once) {
 		rte_dpaa_bus_dev_build();
@@ -947,6 +997,7 @@ static struct rte_dpaa_bus rte_dpaa_bus = {
 		.dev_iterate = dpaa_bus_dev_iterate,
 		.cleanup = dpaa_bus_cleanup,
 	},
+	.max_push_rxq_num = DPAA_DEFAULT_PUSH_MODE_QUEUE,
 	.device_list = TAILQ_HEAD_INITIALIZER(rte_dpaa_bus.device_list),
 	.driver_list = TAILQ_HEAD_INITIALIZER(rte_dpaa_bus.driver_list),
 	.device_count = 0,
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 43aab98339..0baf5c03fa 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -89,16 +89,6 @@ static int fmc_q = 1;	/* Indicates the use of static fmc for distribution */
 static int default_q;	/* use default queue - FMC is not executed*/
 bool dpaa_enable_recv_err_pkts; /* Enable main queue to receive error packets */
 
-/* At present we only allow up to 4 push mode queues as default - as each of
- * this queue need dedicated portal and we are short of portals.
- */
-#define DPAA_MAX_PUSH_MODE_QUEUE       8
-#define DPAA_DEFAULT_PUSH_MODE_QUEUE   4
-
-static int dpaa_push_mode_max_queue = DPAA_DEFAULT_PUSH_MODE_QUEUE;
-static int dpaa_push_queue_idx; /* Queue index which are in push mode*/
-
-
 /* Per RX FQ Taildrop in frame count */
 static unsigned int td_threshold = CGR_RX_PERFQ_THRESH;
 
@@ -1113,7 +1103,7 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	struct qman_fq *rxq = &dpaa_intf->rx_queues[queue_idx];
 	struct qm_mcc_initfq opts = {0};
 	u32 ch_id, flags = 0;
-	int ret;
+	int ret, set_push_rxq = false;
 	u32 buffsz = rte_pktmbuf_data_room_size(mp) - RTE_PKTMBUF_HEADROOM;
 	uint32_t max_rx_pktlen;
 
@@ -1214,12 +1204,12 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		DPAA_PMD_DEBUG("if:%s sg_on = %d, max_frm =%d", dpaa_intf->name,
 			       fman_if_get_sg_enable(fif), max_rx_pktlen);
 	/* checking if push mode only, no error check for now */
-	if (!rxq->is_static &&
-	    dpaa_push_mode_max_queue > dpaa_push_queue_idx) {
+	if (!rxq->is_static)
+		set_push_rxq = dpaa_push_queue_num_update();
+	if (set_push_rxq) {
 		struct qman_portal *qp;
 		int q_fd;
 
-		dpaa_push_queue_idx++;
 		opts.we_mask = QM_INITFQ_WE_FQCTRL | QM_INITFQ_WE_CONTEXTA;
 		opts.fqd.fq_ctrl = QM_FQCTRL_AVOIDBLOCK |
 				   QM_FQCTRL_CTXASTASHING |
@@ -1269,7 +1259,7 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 		qp = fsl_qman_fq_portal_create(&q_fd);
 		if (!qp) {
 			DPAA_PMD_ERR("Unable to alloc fq portal");
-			return -1;
+			return -EIO;
 		}
 		rxq->qp = qp;
 
@@ -1279,19 +1269,19 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 			struct rte_device *rdev = dev->device;
 
 			dpaa_dev = container_of(rdev, struct rte_dpaa_device,
-						device);
+				device);
 			dev->intr_handle = dpaa_dev->intr_handle;
 			if (rte_intr_vec_list_alloc(dev->intr_handle,
-					NULL, dpaa_push_mode_max_queue)) {
+					NULL, dpaa_push_queue_max_num())) {
 				DPAA_PMD_ERR("intr_vec alloc failed");
 				return -ENOMEM;
 			}
 			if (rte_intr_nb_efd_set(dev->intr_handle,
-					dpaa_push_mode_max_queue))
+					dpaa_push_queue_max_num()))
 				return -rte_errno;
 
 			if (rte_intr_max_intr_set(dev->intr_handle,
-					dpaa_push_mode_max_queue))
+					dpaa_push_queue_max_num()))
 				return -rte_errno;
 		}
 
@@ -1339,9 +1329,8 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 RTE_EXPORT_INTERNAL_SYMBOL(dpaa_eth_eventq_attach)
 int
 dpaa_eth_eventq_attach(const struct rte_eth_dev *dev,
-		int eth_rx_queue_id,
-		u16 ch_id,
-		const struct rte_event_eth_rx_adapter_queue_conf *queue_conf)
+	int eth_rx_queue_id, u16 ch_id,
+	const struct rte_event_eth_rx_adapter_queue_conf *queue_conf)
 {
 	int ret;
 	u32 flags = 0;
@@ -1349,10 +1338,10 @@ dpaa_eth_eventq_attach(const struct rte_eth_dev *dev,
 	struct qman_fq *rxq = &dpaa_intf->rx_queues[eth_rx_queue_id];
 	struct qm_mcc_initfq opts = {0};
 
-	if (dpaa_push_mode_max_queue) {
+	if (dpaa_push_queue_max_num() > 0) {
 		DPAA_PMD_WARN("PUSH mode q and EVENTDEV are not compatible");
 		DPAA_PMD_WARN("PUSH mode already enabled for first %d queues.",
-			      dpaa_push_mode_max_queue);
+			dpaa_push_queue_max_num());
 		DPAA_PMD_WARN("To disable set DPAA_PUSH_QUEUES_NUMBER to 0");
 	}
 
@@ -2581,20 +2570,6 @@ rte_dpaa_probe(struct rte_dpaa_driver *dpaa_drv,
 			}
 		}
 
-		/* disabling the default push mode for LS1043 */
-		if (dpaa_soc_ver() == SVR_LS1043A_FAMILY)
-			dpaa_push_mode_max_queue = 0;
-
-		/* if push mode queues to be enabled. Currently we are allowing
-		 * only one queue per thread.
-		 */
-		if (getenv("DPAA_PUSH_QUEUES_NUMBER")) {
-			dpaa_push_mode_max_queue =
-					atoi(getenv("DPAA_PUSH_QUEUES_NUMBER"));
-			if (dpaa_push_mode_max_queue > DPAA_MAX_PUSH_MODE_QUEUE)
-			    dpaa_push_mode_max_queue = DPAA_MAX_PUSH_MODE_QUEUE;
-		}
-
 		is_global_init = 1;
 	}
 
-- 
2.25.1

