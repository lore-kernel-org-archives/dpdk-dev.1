Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7C6BCAC5B0
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Oct 2025 05:00:42 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8EB6240608;
	Tue,  7 Oct 2025 07:00:38 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013043.outbound.protection.outlook.com [52.101.72.43])
 by mails.dpdk.org (Postfix) with ESMTP id 213C2402E2
 for <dev@dpdk.org>; Tue,  7 Oct 2025 07:00:37 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=loG8kXoaHJaNU2E4PlZJDgkwQSVcXN+C6edONDtj7BZj68DmTyz8X69bctxVJYL/znMAGBuzeHkvDAASSa30dOTYFXIJPTBAX9Oj6Selx47lYfjU7tkfpNhJACY4JxhSxFBV+i9NOIUua9rMApgH6ZLdaLlmZ0benpwPCFfOqReih5fhsqA7+js1TBZqwli0/ACZ9e67YS4x5KDb/HEJpQRnvo4E1YT3yyLvD76haU+a1qb9Dgt7JwfBI1swyP8jnmSxY3SU/DUcvCnYYSWPgAvTWolmhu3F3m5tZmcugSGKgHluKo4t0KifjYM1VHNc2AFmjiaTW7KM6oTmqMqltA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7sOiyja4gKlU8QtCDTdPLOyxEqQHVHHWQHCYYcEeTc=;
 b=Wg6jzecadLUn72Vzpz5NEiQXOd+4oAd9neJyfmKL1t7oYqXuzxqrrjbTshczIe6iY30kDVzJcfPAXmyAX9D2C27b5Fyvfi2FTKqDFrIOqGueS7H0ok7wN6t1qxs10nnyot3E0boLl8Es9CunY0S9wnXIEN8JoCsBmFmpIJSp17M/2PJ8aS0PnuHTGax7YiZ57fKEOmNAdV7mLSJ9OBcOn2omj6I9pGR6Ow+i4tHL3LQFRVmi9/m4zrq51OVKZgRF3+2I8i/ma5bDNxw43X5ZVc0OF3GGWTTQ6ky/QSouQBMR8SqBlSY2/k4GSXBF5hDX5W4EtI5lxOB81PiaqpP5FA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7sOiyja4gKlU8QtCDTdPLOyxEqQHVHHWQHCYYcEeTc=;
 b=ESpfqwpEGZE6jGy3TSKIpy7zPfz/+Ysuj1lOdp+SSmb+OJ++krlrIMFfUF0xU7W5dnPdO5XnNgxdVMHAkq3Qgr1JBWCdAlv19nM6DQ4mjQohsL4q6OPGrIUl2sAO8yLPvbBBKvVwh9uuM4gSS0XaXiuH1deUc18SupYCvl51JjLl5EZy6moZeBUEYPfJ4ESeQj+ht9uuElJMsqdn3u4Rec9s1RgXP0G+7PWeQCfkLyJfjbkQ9mJ0WziXtx0JK1wCRnK8kWAOJyN144jsBdrBWK7FHmXH+ABACFeqy04jile3NI2FJMh40fE0aQgHGwWvjXnQ7ZAi2FLH+G2HSqKp0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by PA1PR04MB10178.eurprd04.prod.outlook.com (2603:10a6:102:463::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Tue, 7 Oct
 2025 05:00:32 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9182.017; Tue, 7 Oct 2025
 05:00:32 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH 1/5] bus/dpaa: add FQ shutdown and improve logging
Date: Tue,  7 Oct 2025 10:30:08 +0530
Message-Id: <20251007050012.2432449-2-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251007050012.2432449-1-g.singh@nxp.com>
References: <20251007050012.2432449-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0117.apcprd03.prod.outlook.com
 (2603:1096:4:91::21) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|PA1PR04MB10178:EE_
X-MS-Office365-Filtering-Correlation-Id: 947320b3-ac25-43e4-6c70-08de055e7106
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|19092799006|376014|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VEtERZAcNRnjrfzTt2zjpt96pXtBH0bTXOoT5Igt7ktOD8ZQj4rmSbUUVccu?=
 =?us-ascii?Q?n2bGV0gJWHGKo5imkS1eYbSQNQZLtUQmq9eqNdogMoUFL6KMv39TH2DOdN0D?=
 =?us-ascii?Q?LCLJ8ZveN8R+sllEWwUJzHwubDzPrWzyO4n+zMEwU2x0V1RRzLyZErYohxA5?=
 =?us-ascii?Q?Md+cDUS4BbzIMPh04j1s5UwurbsClhKYxHNFs4gkDlYwyvGeEOBomAT/Oi41?=
 =?us-ascii?Q?B2HxXTFZcZ8iQqtNzXQ6fG5/WnFmiqhxIXKA29hc82iJRRZp+ed+b8e5BFFs?=
 =?us-ascii?Q?7JunUz9ZIVnTNGI87Nrf5rRZKcKFJPT0QUsxOtmVf9ixfCJN7OOm7t2wRoZG?=
 =?us-ascii?Q?8IbMuNcrtromP9qUNM00YgmEcPmnegPLmZOo6OPSnsJoIMp4xjqfwSZ+cVYv?=
 =?us-ascii?Q?88NzTBGMcgyziQDoD6NPxF611wYhNC6HFpvONqzJWurK3VYMbzgp8pq1g+ot?=
 =?us-ascii?Q?M66Lg1JIdIjO179LOwrVUZxFc96Co4iFQhK64ublQUIHJ2HzqXdITveDe3ng?=
 =?us-ascii?Q?45cMvITlFMgfkcWxAhZ4yn8YB3S6fixSlmb+bUUjAkL1rOU48UedUgSFTuwH?=
 =?us-ascii?Q?x53pcrYI4O3TelF0xeXV12r9uYn/z7AlFqlVIE6xOtJ+XCbNKtRm/yuUdMKy?=
 =?us-ascii?Q?RRA0notJ3ZU0lZpFPMew/X4fKQAWO6pD3uHMAVoeWPSD5E1pHN8mbTMuOw8d?=
 =?us-ascii?Q?Og/eoKAxdSrQSmdrFnBhY+pUQJt+IuPAUMWjyjvqy+GlTCcvLI1CjgOG/E0z?=
 =?us-ascii?Q?0K2solvnhMj8Dg6hVFlWOtIw6fGHZz4YgAioaiW3SU1g1WMCi3bRrX1215W2?=
 =?us-ascii?Q?NV9dDOYYoXlkRr8avJvujm0eXsXO2dAdB0hacTzyuQukk6ot14HD5nY6rMLl?=
 =?us-ascii?Q?NThGrwV+P7KjgB25L0wZ/+/pnHZP2alWOiMJJBzg6ts99UhzNBLhd3EE3+P3?=
 =?us-ascii?Q?y5HcvJpDvDb02kjQZJoDwLMAZlFWD5e29DZztPVghOk/H4kEEaPjquOfuFjJ?=
 =?us-ascii?Q?PrA8LloN4zW0WeaYenKFvJJH5YX1jgg1BiDqR3aEA4lxQVUk5HCzY6pZaQJw?=
 =?us-ascii?Q?IGlI3cKUancFxHQpmSulZIdeZTj+8FFe4C1lriMmnm1yfppYdc/i+KlE4kQ2?=
 =?us-ascii?Q?FUpQgdVjl8neBNI+przqxRKKiPJfljwUF0hvAscBs8m6YAuV0mExGGU8Wnf3?=
 =?us-ascii?Q?YWsDaA5MQbl6tV1Spbaa+nDqt4JfjkPv3cpZIvXe9jTjMdo+z4JvFS9KmWYe?=
 =?us-ascii?Q?hO//n9HY33ktcr+8MGdZI3gxJ9VbfePUUfVfqQDe0KZLlqhedURuh0Xb34Mz?=
 =?us-ascii?Q?U+QpUl/KMpsTR5JuniJkYvfCWR60DEZCrjeKt1QJd+1MfFeQDRAXCo/2vBtF?=
 =?us-ascii?Q?gaVDQ6Hu4penH6KWk+0tz4FE37EEhsqHBvg5ySvQzVjNFcuVo9D2jCV/hfwC?=
 =?us-ascii?Q?tvFH+kUaQfgUVKf+zDUMfIYwn8rUDsz9deGCFYVmh1OXdpr7tKwbjTGMLS8z?=
 =?us-ascii?Q?T898eEfiYeNvFXbJ/2VaA4MkIbHcm/G0AsTM?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(19092799006)(376014)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?EtaFU3lzjmCsIxXnp88Ao3M6PGmsO/JgS7IMmgry9+BurvSuyeGSXvABpb/7?=
 =?us-ascii?Q?7c245qoSXn1oFt0WNK+k5YvMjPS6ltKsqSbZo0AtKfyczbXD1DJLIlWLb1Bf?=
 =?us-ascii?Q?qyn0p/W/6+3TQu/j6zfyMpE2OyGGGKMu4hTZHL0tsEANkYPEqnOFoZmKFXjK?=
 =?us-ascii?Q?Equ+ZQeFDAwcnfXm8T8+SaU80JAY6g9bfgvQwwaLx1tI8bevq1AsmHni8a9C?=
 =?us-ascii?Q?ZmYoovnq+lqdJk/VkD2DU+lic4AO1SnggYOszpNbczwhVaF4254R9Qb036gZ?=
 =?us-ascii?Q?+J3nikbRtJUI05gb45DlWZblfXahdceiDmJeppYyzAgM5j2X07gb2sm25Pxc?=
 =?us-ascii?Q?gJ2r9bVomu/fr4m5ke7tN5MAt8SLfIcrWRsqMd3jOksXZTCFXYUti166HLHD?=
 =?us-ascii?Q?Z6liqsDELukdtx5+OijbeYPxJcGja3MBw2bOCli7tat95jIFeaPLs386SohE?=
 =?us-ascii?Q?oBJ/1rp4gTf6fVrNNTfFdRoW8MXvnCQbIIxPC2KjwVNyIMToRIUlrSCQXeoH?=
 =?us-ascii?Q?epKVt+zyUE2t78jp0QeajV6DdqrBBe4v7C6Cwazn/C6okbdhstue6l/2PnAA?=
 =?us-ascii?Q?YJxtNG8wyQgl1yoMj2V9xTAd4Kt0iA8AAtnba6r9wTRdXB6aY0R3RJbhqCNT?=
 =?us-ascii?Q?6X++np9Gh0I/oeYc4oGPzQy6aGHZ3AQDge8/3Fw+g4fNUFqHGaGqzQFUazEl?=
 =?us-ascii?Q?W185aWAUR5xlmz+ocEdOme2WMYku8NWZuWpW3iGkz/MTRqmNtN8Y0BFSHimY?=
 =?us-ascii?Q?mkjUrlMVrCbywSK18/5SBqzh9sMtq2EWVg06GARfOg+dqo4Fp2ccjC3fRWfI?=
 =?us-ascii?Q?AUQTg7mpk6re8fdbZQNHoAXW73eSv781VJHdLrdnxPDz9LgIISvc9CWJcx2w?=
 =?us-ascii?Q?Pf4JXVH62qO+/Kh3oO4K6m0yqxjwMd11T3xI8FGHOKqrqJ0lICdJAgQhx3IO?=
 =?us-ascii?Q?7eHKWdVQUdd9PAh185lUX5jYqXXzA4xJYMHxe59YyQoh7TZbzEDtANuvSj4v?=
 =?us-ascii?Q?hYdoAIc16aQhA4QPT8jojq79yPhGx7JCIh89MfqD4BTjOH9qipOUNvcWsErV?=
 =?us-ascii?Q?D2msJQLPFpAL2HOoO48qd8/6A6OI6iZsEBnwUTBVSI4S8C/kKN/nVL+jgsqA?=
 =?us-ascii?Q?iUv9MZ9FxOMVhFLCXQ25WwRO4bfG1CzNGNGYxfUcvRnIWeBNi+Dd9PLaT76u?=
 =?us-ascii?Q?gc+n6GcR3F0lng+m1zjKdfF7j60MAJE5SoDDGIYDkcpmV3U9DmLoyzY0Hffx?=
 =?us-ascii?Q?VujFgMDgQxeASRuhGGWDKdEODiqLpDOEsFuqUOwnfax/RLR5y5Bi2yU5GwDn?=
 =?us-ascii?Q?6BPxwHi55Vv0Ys5m2AGD5XDlBsdfiaApjf7jEh88sDhQTQAyCUU+JrzHUYDf?=
 =?us-ascii?Q?NLGjs/tT44dprea8A10z5T5fM4/YOF5yGnHBqyQW3esOvQd5CNVfEAZQ0Dwa?=
 =?us-ascii?Q?tfLbOXirIXA+UBz+tplz/l/kJu5wpzgCX58HETIwaaAWfd7jttka6HR2vtX+?=
 =?us-ascii?Q?U9sgrI0uW93f4DITW7EZAVWf+hZAg+jTgfY4jRxRBFR8frkq8IMsNyBWqEvZ?=
 =?us-ascii?Q?KLioi/TVUZW1yVo/T7Y=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 947320b3-ac25-43e4-6c70-08de055e7106
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2025 05:00:31.9897 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: ePQckoKzsRNYkJB4cwAxeWnriarsI9/M+9rDMcXXHVlN2BPLjoB8El3+mmvtPGkg
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10178
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

adding a FQ shutdown functionality to ensure proper cleanup of
frame queues during queue setup. This helps reset the
queues reliably and prevents potential resource leaks or
stale state issues.

Additionally, update logging to use DPAA_BUS_ERR instead
of pr_err for better consistency and clarity in error
reporting within the DPAA bus subsystem.

These changes enhance maintainability and improve
debugging experience.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/bus/dpaa/base/qbman/qman.c  | 394 +++++++++++++++++++++++++---
 drivers/bus/dpaa/include/fsl_qman.h |   3 +
 drivers/net/dpaa/dpaa_ethdev.c      |   3 +
 3 files changed, 369 insertions(+), 31 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index 60087c55a1..6ce3690366 100644
--- a/drivers/bus/dpaa/base/qbman/qman.c
+++ b/drivers/bus/dpaa/base/qbman/qman.c
@@ -10,7 +10,8 @@
 #include <bus_dpaa_driver.h>
 #include <rte_eventdev.h>
 #include <rte_byteorder.h>
-
+#include <rte_dpaa_logs.h>
+#include <eal_export.h>
 #include <dpaa_bits.h>
 
 /* Compilation constants */
@@ -137,7 +138,7 @@ static inline int table_push_fq(struct qman_portal *p, struct qman_fq *fq)
 	int ret = fqtree_push(&p->retire_table, fq);
 
 	if (ret)
-		pr_err("ERROR: double FQ-retirement %d\n", fq->fqid);
+		DPAA_BUS_ERR("ERROR: double FQ-retirement %d", fq->fqid);
 	return ret;
 }
 
@@ -161,7 +162,7 @@ int qman_setup_fq_lookup_table(size_t num_entries)
 	/* Allocate 1 more entry since the first entry is not used */
 	qman_fq_lookup_table = vmalloc((num_entries * sizeof(void *)));
 	if (!qman_fq_lookup_table) {
-		pr_err("QMan: Could not allocate fq lookup table\n");
+		DPAA_BUS_ERR("QMan: Could not allocate fq lookup table");
 		return -ENOMEM;
 	}
 	memset(qman_fq_lookup_table, 0, num_entries * sizeof(void *));
@@ -349,7 +350,8 @@ static int drain_mr_fqrni(struct qm_portal *p)
 	}
 	if ((msg->ern.verb & QM_MR_VERB_TYPE_MASK) != QM_MR_VERB_FQRNI) {
 		/* We aren't draining anything but FQRNIs */
-		pr_err("Found verb 0x%x in MR\n", msg->ern.verb);
+		DPAA_BUS_ERR("Found verb 0x%x and after mask = 0x%x in MR",
+			msg->ern.verb, msg->ern.verb & QM_MR_VERB_TYPE_MASK);
 		return -1;
 	}
 	qm_mr_next(p);
@@ -423,11 +425,11 @@ static inline void qm_eqcr_finish(struct qm_portal *portal)
 	DPAA_ASSERT(!eqcr->busy);
 #endif
 	if (pi != EQCR_PTR2IDX(eqcr->cursor))
-		pr_crit("losing uncommitted EQCR entries\n");
+		DPAA_BUS_ERR("losing uncommitted EQCR entries");
 	if (ci != eqcr->ci)
-		pr_crit("missing existing EQCR completions\n");
+		DPAA_BUS_ERR("missing existing EQCR completions");
 	if (eqcr->ci != EQCR_PTR2IDX(eqcr->cursor))
-		pr_crit("EQCR destroyed unquiesced\n");
+		DPAA_BUS_ERR("EQCR destroyed unquiesced");
 }
 
 static inline int qm_dqrr_init(struct qm_portal *portal,
@@ -515,6 +517,7 @@ qman_init_portal(struct qman_portal *portal,
 	int ret;
 	u32 isdr;
 
+
 	p = &portal->p;
 
 	if (!c)
@@ -540,30 +543,68 @@ qman_init_portal(struct qman_portal *portal,
 	 */
 	if (qm_eqcr_init(p, qm_eqcr_pvb,
 			 portal->use_eqcr_ci_stashing, 1)) {
-		pr_err("Qman EQCR initialisation failed\n");
+		DPAA_BUS_ERR("Qman EQCR initialisation failed");
+		goto fail_eqcr;
+	}
+	if (qm_dqrr_init(p, c, qm_dqrr_dpush, qm_dqrr_pvb,
+			 qm_dqrr_cdc, DQRR_MAXFILL)) {
+		DPAA_BUS_ERR("Qman DQRR initialisation failed");
+		goto fail_dqrr;
+	}
+	if (qm_mr_init(p, qm_mr_pvb, qm_mr_cci)) {
+		DPAA_BUS_ERR("Qman MR initialisation failed");
+		goto fail_mr;
+	}
+	if (qm_mc_init(p)) {
+		DPAA_BUS_ERR("Qman MC initialisation failed");
+		goto fail_mc;
+	}
+
+	/* Reset portal before use */
+	DPAA_BUS_DEBUG("Reset portal = %p", p);
+	qm_dqrr_sdqcr_set(p, 0);
+	qm_eqcr_cce_update(p);
+	qm_eqcr_cce_update(p);
+	qm_mc_finish(p);
+	qm_mr_finish(p);
+	qm_dqrr_finish(p);
+	qm_eqcr_finish(p);
+
+	p->addr.ce = c->addr_virt[DPAA_PORTAL_CE];
+	p->addr.ci = c->addr_virt[DPAA_PORTAL_CI];
+	/*
+	 * If CI-stashing is used, the current defaults use a threshold of 3,
+	 * and stash with high-than-DQRR priority.
+	 */
+	if (qm_eqcr_init(p, qm_eqcr_pvb,
+			 portal->use_eqcr_ci_stashing, 1)) {
+		DPAA_BUS_ERR("Qman EQCR initialisation failed");
 		goto fail_eqcr;
 	}
 	if (qm_dqrr_init(p, c, qm_dqrr_dpush, qm_dqrr_pvb,
 			 qm_dqrr_cdc, DQRR_MAXFILL)) {
-		pr_err("Qman DQRR initialisation failed\n");
+		DPAA_BUS_ERR("Qman DQRR initialisation failed");
 		goto fail_dqrr;
 	}
 	if (qm_mr_init(p, qm_mr_pvb, qm_mr_cci)) {
-		pr_err("Qman MR initialisation failed\n");
+		DPAA_BUS_ERR("Qman MR initialisation failed");
 		goto fail_mr;
 	}
 	if (qm_mc_init(p)) {
-		pr_err("Qman MC initialisation failed\n");
+		DPAA_BUS_ERR("Qman MC initialisation failed");
 		goto fail_mc;
 	}
 
+
 	/* static interrupt-gating controls */
 	qm_dqrr_set_ithresh(p, 0);
 	qm_mr_set_ithresh(p, 0);
 	qm_isr_set_iperiod(p, 0);
 	portal->cgrs = kmalloc(2 * sizeof(*cgrs), GFP_KERNEL);
-	if (!portal->cgrs)
+	if (!portal->cgrs) {
+		DPAA_BUS_ERR("CGRS allocation fails");
 		goto fail_cgrs;
+	}
 	/* initial snapshot is no-depletion */
 	qman_cgrs_init(&portal->cgrs[1]);
 	if (cgrs)
@@ -580,6 +621,7 @@ qman_init_portal(struct qman_portal *portal,
 	portal->dqrr_disable_ref = 0;
 	portal->cb_dc_ern = NULL;
 	sprintf(buf, "qportal-%d", c->channel);
+	DPAA_BUS_DEBUG("PORTAL ID = %d and %p",  c->channel, p);
 	dpa_rbtree_init(&portal->retire_table);
 	isdr = 0xffffffff;
 	qm_isr_disable_write(p, isdr);
@@ -589,7 +631,7 @@ qman_init_portal(struct qman_portal *portal,
 	snprintf(portal->irqname, MAX_IRQNAME, IRQNAME, c->cpu);
 	if (request_irq(c->irq, portal_isr, 0, portal->irqname,
 			portal)) {
-		pr_err("request_irq() failed\n");
+		DPAA_BUS_ERR("request_irq() failed");
 		goto fail_irq;
 	}
 
@@ -598,19 +640,22 @@ qman_init_portal(struct qman_portal *portal,
 	qm_isr_disable_write(p, isdr);
 	ret = qm_eqcr_get_fill(p);
 	if (ret) {
-		pr_err("Qman EQCR unclean\n");
+		DPAA_BUS_ERR("Qman EQCR unclean");
 		goto fail_eqcr_empty;
 	}
 	isdr &= ~(QM_PIRQ_DQRI | QM_PIRQ_MRI);
 	qm_isr_disable_write(p, isdr);
 	if (qm_dqrr_current(p)) {
-		pr_err("Qman DQRR unclean\n");
+		DPAA_BUS_ERR("Qman DQRR unclean");
 		qm_dqrr_cdc_consume_n(p, 0xffff);
 	}
 	if (qm_mr_current(p) && drain_mr_fqrni(p)) {
 		/* special handling, drain just in case it's a few FQRNIs */
-		if (drain_mr_fqrni(p))
+		DPAA_BUS_ERR("Draining MR FQRNI");
+		if (drain_mr_fqrni(p)) {
+			DPAA_BUS_ERR("Draining MR FQRNI fails");
 			goto fail_dqrr_mr_empty;
+		}
 	}
 	/* Success */
 	portal->config = c;
@@ -652,7 +697,7 @@ qman_alloc_global_portal(struct qm_portal_config *q_pcfg)
 			return &global_portals[i];
 		}
 	}
-	pr_err("No portal available (%x)\n", MAX_GLOBAL_PORTALS);
+	DPAA_BUS_ERR("No portal available (%x)", MAX_GLOBAL_PORTALS);
 
 	return NULL;
 }
@@ -702,6 +747,7 @@ void qman_destroy_portal(struct qman_portal *qm)
 {
 	const struct qm_portal_config *pcfg;
 
+	DPAA_BUS_DEBUG("In destroy portal = %p", &qm->p);
 	/* Stop dequeues on the portal */
 	qm_dqrr_sdqcr_set(&qm->p, 0);
 
@@ -1488,7 +1534,7 @@ int qman_create_fq(u32 fqid, u32 flags, struct qman_fq *fq)
 		cpu_relax();
 	DPAA_ASSERT((mcr->verb & QM_MCR_VERB_MASK) == QM_MCC_VERB_QUERYFQ);
 	if (mcr->result != QM_MCR_RESULT_OK) {
-		pr_err("QUERYFQ failed: %s\n", mcr_result_str(mcr->result));
+		DPAA_BUS_ERR("QUERYFQ failed: %s", mcr_result_str(mcr->result));
 		goto err;
 	}
 	fqd = mcr->queryfq.fqd;
@@ -1500,7 +1546,7 @@ int qman_create_fq(u32 fqid, u32 flags, struct qman_fq *fq)
 		cpu_relax();
 	DPAA_ASSERT((mcr->verb & QM_MCR_VERB_MASK) == QM_MCC_VERB_QUERYFQ_NP);
 	if (mcr->result != QM_MCR_RESULT_OK) {
-		pr_err("QUERYFQ_NP failed: %s\n", mcr_result_str(mcr->result));
+		DPAA_BUS_ERR("QUERYFQ_NP failed: %s", mcr_result_str(mcr->result));
 		goto err;
 	}
 	np = mcr->queryfq_np;
@@ -2026,7 +2072,7 @@ int qman_query_wq(u8 query_dedicated, struct qm_mcr_querywq *wq)
 			wq->wq_len[i] = be32_to_cpu(mcr->querywq.wq_len[i]);
 	}
 	if (res != QM_MCR_RESULT_OK) {
-		pr_err("QUERYWQ failed: %s\n", mcr_result_str(res));
+		DPAA_BUS_ERR("QUERYWQ failed: %s", mcr_result_str(res));
 		return -EIO;
 	}
 	return 0;
@@ -2053,7 +2099,7 @@ int qman_testwrite_cgr(struct qman_cgr *cgr, u64 i_bcnt,
 	if (res == QM_MCR_RESULT_OK)
 		*result = mcr->cgrtestwrite;
 	if (res != QM_MCR_RESULT_OK) {
-		pr_err("CGR TEST WRITE failed: %s\n", mcr_result_str(res));
+		DPAA_BUS_ERR("CGR TEST WRITE failed: %s", mcr_result_str(res));
 		return -EIO;
 	}
 	return 0;
@@ -2077,7 +2123,7 @@ int qman_query_cgr(struct qman_cgr *cgr, struct qm_mcr_querycgr *cgrd)
 	if (res == QM_MCR_RESULT_OK)
 		*cgrd = mcr->querycgr;
 	if (res != QM_MCR_RESULT_OK) {
-		pr_err("QUERY_CGR failed: %s\n", mcr_result_str(res));
+		DPAA_BUS_ERR("QUERY_CGR failed: %s", mcr_result_str(res));
 		return -EIO;
 	}
 	cgrd->cgr.wr_parm_g.word =
@@ -2111,7 +2157,7 @@ int qman_query_congestion(struct qm_mcr_querycongestion *congestion)
 	if (res == QM_MCR_RESULT_OK)
 		*congestion = mcr->querycongestion;
 	if (res != QM_MCR_RESULT_OK) {
-		pr_err("QUERY_CONGESTION failed: %s\n", mcr_result_str(res));
+		DPAA_BUS_ERR("QUERY_CONGESTION failed: %s", mcr_result_str(res));
 		return -EIO;
 	}
 	for (i = 0; i < ARRAY_SIZE(congestion->state.state); i++)
@@ -2660,6 +2706,287 @@ int qman_delete_cgr(struct qman_cgr *cgr)
 	return ret;
 }
 
+#define GENMASK(h, l) \
+	(((~0U) >> (sizeof(unsigned int) * 8 - ((h) - (l) + 1))) << (l))
+
+/* 'fqid' is a 24-bit field in every h/w descriptor */
+#define QM_FQID_MASK    GENMASK(23, 0)
+#define qm_fqid_set(p, v) ((p)->fqid = cpu_to_be32((v) & QM_FQID_MASK))
+#define qm_fqid_get(p)    (be32_to_cpu((p)->fqid) & QM_FQID_MASK)
+
+static int
+_qm_mr_consume_and_match_verb(struct qm_portal *p, int v)
+{
+	const struct qm_mr_entry *msg;
+	int found = 0;
+
+	qm_mr_pvb_update(p);
+	msg = qm_mr_current(p);
+	while (msg) {
+		if ((msg->ern.verb & QM_MR_VERB_TYPE_MASK) == v)
+			found = 1;
+		qm_mr_next(p);
+		qm_mr_cci_consume_to_current(p);
+		qm_mr_pvb_update(p);
+		msg = qm_mr_current(p);
+	}
+	return found;
+}
+
+static int
+_qm_dqrr_consume_and_match(struct qm_portal *p, u32 fqid, int s,
+		bool wait)
+{
+	const struct qm_dqrr_entry *dqrr;
+	int found = 0;
+
+	do {
+		qm_dqrr_pvb_update(p);
+		dqrr = qm_dqrr_current(p);
+		if (!dqrr)
+			cpu_relax();
+	} while (wait && !dqrr);
+
+	while (dqrr) {
+		if (qm_fqid_get(dqrr) == fqid && (dqrr->stat & s))
+			found = 1;
+
+		qm_dqrr_cdc_consume_1ptr(p, dqrr, 0);
+		qm_dqrr_pvb_update(p);
+		qm_dqrr_next(p);
+		dqrr = qm_dqrr_current(p);
+	}
+	return found;
+}
+
+#define QM_MCR_TIMEOUT                  10000   /* us */
+
+static inline int
+qm_mc_result_timeout(struct qm_portal *portal,
+		     struct qm_mc_result **mcr)
+{
+	int timeout = QM_MCR_TIMEOUT;
+
+	do {
+		*mcr = qm_mc_result(portal);
+		if (*mcr)
+			break;
+		usleep(1);
+	} while (--timeout);
+
+	return timeout;
+}
+
+#define qm_mr_drain(p, V) \
+	_qm_mr_consume_and_match_verb(p, QM_MR_VERB_##V)
+
+#define qm_dqrr_drain(p, f, S) \
+	_qm_dqrr_consume_and_match(p, f, QM_DQRR_STAT_##S, false)
+
+#define qm_dqrr_drain_wait(p, f, S) \
+	_qm_dqrr_consume_and_match(p, f, QM_DQRR_STAT_##S, true)
+
+#define qm_dqrr_drain_nomatch(p) \
+	_qm_dqrr_consume_and_match(p, 0, 0, false)
+
+RTE_EXPORT_INTERNAL_SYMBOL(qman_shutdown_fq_new)
+int
+qman_shutdown_fq_new(u32 fqid)
+{
+	struct qman_portal *p;
+	struct qm_mc_command *mcc;
+	struct qm_mc_result *mcr;
+	int orl_empty, drain = 0, ret = 0;
+	u32 res;
+	u8 state;
+	u32 channel, wq;
+	u16 dest_wq;
+
+	DPAA_BUS_DEBUG("In shutdown for queue = %x", fqid);
+	p = get_affine_portal();
+	/* Determine the state of the FQID */
+	mcc = qm_mc_start(&p->p);
+	mcc->queryfq_np.fqid = cpu_to_be32(fqid);
+	qm_mc_commit(&p->p, QM_MCC_VERB_QUERYFQ_NP);
+	if (!qm_mc_result_timeout(&p->p, &mcr)) {
+		DPAA_BUS_ERR("QUERYFQ_NP timeout");
+		ret = -ETIMEDOUT;
+		goto out;
+	}
+	state = mcr->queryfq_np.state & QM_MCR_NP_STATE_MASK;
+	if (state == QM_MCR_NP_STATE_OOS) {
+		DPAA_BUS_ERR("Already in OOS");
+		goto out; /* Already OOS, no need to do anymore checks */
+	}
+
+	/* Query which channel the FQ is using */
+	mcc = qm_mc_start(&p->p);
+	mcc->queryfq.fqid = cpu_to_be32(fqid);
+	qm_mc_commit(&p->p, QM_MCC_VERB_QUERYFQ);
+	if (!qm_mc_result_timeout(&p->p, &mcr)) {
+		DPAA_BUS_ERR("QUERYFQ timeout");
+		ret = -ETIMEDOUT;
+		goto out;
+	}
+
+	/* Need to store these since the MCR gets reused */
+	dest_wq = be16_to_cpu(mcr->queryfq.fqd.dest_wq);
+	channel = dest_wq & 0x7;
+	wq = dest_wq >> 3;
+
+	switch (state) {
+	case QM_MCR_NP_STATE_TEN_SCHED:
+	case QM_MCR_NP_STATE_TRU_SCHED:
+	case QM_MCR_NP_STATE_ACTIVE:
+	case QM_MCR_NP_STATE_PARKED:
+		DPAA_BUS_DEBUG("In shutdown state is %d", state);
+		orl_empty = 0;
+		mcc = qm_mc_start(&p->p);
+		mcc->alterfq.fqid = cpu_to_be32(fqid);
+		qm_mc_commit(&p->p, QM_MCC_VERB_ALTER_RETIRE);
+		if (!qm_mc_result_timeout(&p->p, &mcr)) {
+			DPAA_BUS_ERR("ALTER_RETIRE timeout");
+			ret = -ETIMEDOUT;
+			goto out;
+		}
+		res = mcr->result; /* Make a copy as we reuse MCR below */
+
+		if (res == QM_MCR_RESULT_OK)
+			drain_mr_fqrni(&p->p);
+
+		if (res == QM_MCR_RESULT_PENDING) {
+			/*
+			 * Need to wait for the FQRN in the message ring, which
+			 * will only occur once the FQ has been drained.  In
+			 * order for the FQ to drain the portal needs to be set
+			 * to dequeue from the channel the FQ is scheduled on
+			 */
+			int found_fqrn = 0;
+
+			/* Flag that we need to drain FQ */
+			drain = 1;
+
+			__maybe_unused u16 dequeue_wq = 0;
+			if (channel >= qm_channel_pool1 &&
+				channel < (u16)(qm_channel_pool1 + 15)) {
+				/* Pool channel, enable the bit in the portal */
+				dequeue_wq = (channel -
+						qm_channel_pool1 + 1) << 4 | wq;
+			} else if (channel < qm_channel_pool1) {
+				/* Dedicated channel */
+				dequeue_wq = wq;
+			} else {
+				DPAA_BUS_ERR("Can't recover FQ 0x%x, ch: 0x%x",
+					fqid, channel);
+				ret = -EBUSY;
+				goto out;
+			}
+			/* Set the sdqcr to drain this channel */
+			if (channel < qm_channel_pool1)
+				qm_dqrr_sdqcr_set(&p->p,
+						  QM_SDQCR_TYPE_ACTIVE |
+						  QM_SDQCR_CHANNELS_DEDICATED);
+			else
+				qm_dqrr_sdqcr_set(&p->p,
+						  QM_SDQCR_TYPE_ACTIVE |
+						  QM_SDQCR_CHANNELS_POOL_CONV
+						  (channel));
+			do {
+				/* Keep draining DQRR while checking the MR*/
+				qm_dqrr_drain_nomatch(&p->p);
+				/* Process message ring too */
+				found_fqrn = qm_mr_drain(&p->p,
+							FQRN);
+				cpu_relax();
+			} while (!found_fqrn);
+			/* Restore SDQCR */
+			qm_dqrr_sdqcr_set(&p->p,
+					p->sdqcr);
+		}
+		if (res != QM_MCR_RESULT_OK &&
+		    res != QM_MCR_RESULT_PENDING) {
+			DPAA_BUS_ERR("retire_fq failed: FQ 0x%x, res=0x%x",
+				      fqid, res);
+			ret = -EIO;
+			goto out;
+		}
+		if (!(mcr->alterfq.fqs & QM_MCR_FQS_ORLPRESENT)) {
+			/*
+			 * ORL had no entries, no need to wait until the
+			 * ERNs come in
+			 */
+			orl_empty = 1;
+		}
+		/*
+		 * Retirement succeeded, check to see if FQ needs
+		 * to be drained
+		 */
+		if (drain || mcr->alterfq.fqs & QM_MCR_FQS_NOTEMPTY) {
+			/* FQ is Not Empty, drain using volatile DQ commands */
+			do {
+				u32 vdqcr = fqid | QM_VDQCR_NUMFRAMES_SET(3);
+
+				qm_dqrr_vdqcr_set(&p->p, vdqcr);
+				/*
+				 * Wait for a dequeue and process the dequeues,
+				 * making sure to empty the ring completely
+				 */
+			} while (!qm_dqrr_drain_wait(&p->p, fqid, FQ_EMPTY));
+		}
+		while (!orl_empty) {
+			/* Wait for the ORL to have been completely drained */
+			orl_empty = qm_mr_drain(&p->p, FQRL);
+			cpu_relax();
+		}
+		mcc = qm_mc_start(&p->p);
+		mcc->alterfq.fqid = cpu_to_be32(fqid);
+		qm_mc_commit(&p->p, QM_MCC_VERB_ALTER_OOS);
+		if (!qm_mc_result_timeout(&p->p, &mcr)) {
+			DPAA_BUS_ERR("OOS Timeout");
+			ret = -ETIMEDOUT;
+			goto out;
+		}
+
+		if (mcr->result != QM_MCR_RESULT_OK) {
+			DPAA_BUS_ERR("OOS after drain fail: FQ 0x%x (0x%x)",
+				      fqid, mcr->result);
+			ret = -EIO;
+			goto out;
+		}
+		break;
+
+	case QM_MCR_NP_STATE_RETIRED:
+		/* Send OOS Command */
+		mcc = qm_mc_start(&p->p);
+		mcc->alterfq.fqid = cpu_to_be32(fqid);
+		qm_mc_commit(&p->p, QM_MCC_VERB_ALTER_OOS);
+		if (!qm_mc_result_timeout(&p->p, &mcr)) {
+			DPAA_BUS_ERR("In RTEIRED to OOS timeout");
+			ret = -ETIMEDOUT;
+			goto out;
+		}
+
+		if (mcr->result != QM_MCR_RESULT_OK) {
+			DPAA_BUS_ERR("OOS fail: FQ 0x%x (0x%x)",
+				      fqid, mcr->result);
+			ret = -EIO;
+			goto out;
+		}
+		break;
+
+	case QM_MCR_NP_STATE_OOS:
+		/*  Done */
+		break;
+
+	default:
+		ret = -EIO;
+	}
+
+out:
+	return ret;
+}
+
+RTE_EXPORT_INTERNAL_SYMBOL(qman_shutdown_fq)
 int qman_shutdown_fq(u32 fqid)
 {
 	struct qman_portal *p;
@@ -2683,8 +3010,10 @@ int qman_shutdown_fq(u32 fqid)
 		cpu_relax();
 	DPAA_ASSERT((mcr->verb & QM_MCR_VERB_MASK) == QM_MCR_VERB_QUERYFQ_NP);
 	state = mcr->queryfq_np.state & QM_MCR_NP_STATE_MASK;
-	if (state == QM_MCR_NP_STATE_OOS)
+	if (state == QM_MCR_NP_STATE_OOS) {
+		DPAA_BUS_ERR("Already in OOS state");
 		return 0; /* Already OOS, no need to do anymore checks */
+	}
 
 	/* Query which channel the FQ is using */
 	mcc = qm_mc_start(low_p);
@@ -2714,6 +3043,9 @@ int qman_shutdown_fq(u32 fqid)
 			   QM_MCR_VERB_ALTER_RETIRE);
 		result = mcr->result; /* Make a copy as we reuse MCR below */
 
+		if (result == QM_MCR_RESULT_OK)
+			drain_mr_fqrni(low_p);
+
 		if (result == QM_MCR_RESULT_PENDING) {
 			/* Need to wait for the FQRN in the message ring, which
 			 * will only occur once the FQ has been drained.  In
@@ -2737,7 +3069,7 @@ int qman_shutdown_fq(u32 fqid)
 				/* Dedicated channel */
 				dequeue_wq = wq;
 			} else {
-				pr_info("Cannot recover FQ 0x%x,"
+				DPAA_BUS_ERR("Cannot recover FQ 0x%x,"
 					" it is scheduled on channel 0x%x",
 					fqid, channel);
 				return -EBUSY;
@@ -2782,8 +3114,8 @@ int qman_shutdown_fq(u32 fqid)
 		if (result != QM_MCR_RESULT_OK &&
 		    result !=  QM_MCR_RESULT_PENDING) {
 			/* error */
-			pr_err("qman_retire_fq failed on FQ 0x%x,"
-			       " result=0x%x\n", fqid, result);
+			DPAA_BUS_ERR("qman_retire_fq failed on FQ 0x%x, result=0x%x",
+				fqid, result);
 			return -1;
 		}
 		if (!(mcr->alterfq.fqs & QM_MCR_FQS_ORLPRESENT)) {
@@ -2853,8 +3185,8 @@ int qman_shutdown_fq(u32 fqid)
 		DPAA_ASSERT((mcr->verb & QM_MCR_VERB_MASK) ==
 			   QM_MCR_VERB_ALTER_OOS);
 		if (mcr->result != QM_MCR_RESULT_OK) {
-			pr_err(
-			"OOS after drain Failed on FQID 0x%x, result 0x%x\n",
+			DPAA_BUS_ERR(
+			"OOS after drain Failed on FQID 0x%x, result 0x%x",
 			       fqid, mcr->result);
 			return -1;
 		}
@@ -2869,8 +3201,8 @@ int qman_shutdown_fq(u32 fqid)
 			cpu_relax();
 		DPAA_ASSERT((mcr->verb & QM_MCR_VERB_MASK) ==
 			   QM_MCR_VERB_ALTER_OOS);
-		if (mcr->result) {
-			pr_err("OOS Failed on FQID 0x%x\n", fqid);
+		if (mcr->result != QM_MCR_RESULT_OK) {
+			DPAA_BUS_ERR("OOS Failed on FQID 0x%x", fqid);
 			return -1;
 		}
 		return 0;
diff --git a/drivers/bus/dpaa/include/fsl_qman.h b/drivers/bus/dpaa/include/fsl_qman.h
index 71d5b16878..5b6015a876 100644
--- a/drivers/bus/dpaa/include/fsl_qman.h
+++ b/drivers/bus/dpaa/include/fsl_qman.h
@@ -1894,7 +1894,10 @@ static inline void qman_release_fqid(u32 fqid)
 
 void qman_seed_fqid_range(u32 fqid, unsigned int count);
 
+__rte_internal
 int qman_shutdown_fq(u32 fqid);
+__rte_internal
+int qman_shutdown_fq_new(u32 fqid);
 
 /**
  * qman_reserve_fqid_range - Reserve the specified range of frame queue IDs
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 34b691fde7..30a0c97a8b 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -1134,6 +1134,9 @@ int dpaa_eth_rx_queue_setup(struct rte_eth_dev *dev, uint16_t queue_idx,
 	DPAA_PMD_INFO("Rx queue setup for queue index: %d fq_id (0x%x)",
 			queue_idx, rxq->fqid);
 
+	/* Shutdown FQ before configure */
+	qman_shutdown_fq(rxq->fqid);
+
 	if (!fif->num_profiles) {
 		if (dpaa_intf->bp_info && dpaa_intf->bp_info->bp &&
 			dpaa_intf->bp_info->mp != mp) {
-- 
2.25.1

