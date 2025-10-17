Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0310CCD199
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 04:43:28 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C9A341148;
	Fri, 17 Oct 2025 06:43:22 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012040.outbound.protection.outlook.com [52.101.66.40])
 by mails.dpdk.org (Postfix) with ESMTP id 0E93340E01
 for <dev@dpdk.org>; Fri, 17 Oct 2025 06:43:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XLVXwl4ufWPffMCV7ZJLTsfUHqiBkOvPMuBhYVH8bt9FnvtFdCMZ76zw8HqhYnmFYqDzKzG3tOjG8xiMDk64ImDAg+I4gYLWgl7QW6v/ZRbdg1L3dbednFjxKafjtYvKsjnfbzerQePwOQHa6yXGRW9057jWIX9piXPRuFJXrcuPaFP5oG4tNehXWZE1WWDEGmxvUr14aFG9rNIz8U4d6rbJPfppL60isAxIUZyOHn+fz1HtVkBIEUODnxeVEnrmDjVZmw6ZH+Fai3wr0y0Bb15nFjnM0r07E+Y+e4uAamaTE0qK5L9waDdPzhWXEZL/gqEyddI3vsIQc/7UKRLOGA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1jeEcJfUoA80kH9M3osKdOvWHqCVt2+31Bc+blrfCA=;
 b=cnlEvprShjehFdKvGV3NsuDIqtVfUZoD5HiotpgN0ouRVqte8H11G09DrnJXxcZaHH/SX9fRS4kWD2fVYCDRA//dJYr9azKI+YxDXHa0Dvts5r+uuNnMA9rT6X+zCbdFjhgZwfKRaXKokf3g3DuwMz025pJBOA1zqZzmG0Yv2dCDLdqFiwoUjF8q6KUXf8GQHWQQkekIc9EsuraSRZHCFp3lzG1o7EfK0dLbEi48oRZRnjQxYp+z7A1iB9mw1zo7xd0+EAzo3PV/w/hN/ZqtbeBb08SCA86J60d6KmDywPSBCQCvoCB8qp0lRsmMILTU4nzLpRImBOztTyuMVJdS7A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1jeEcJfUoA80kH9M3osKdOvWHqCVt2+31Bc+blrfCA=;
 b=DZQI33tTZrzyYQrcJEbc5Ep1+mloExxLycDRVBEOZ0/+dHioqRTLd3NQ7FixnITSnfN2o8NqzwuHkUmsfu1yWsjcTTmJBcpux122w9vJCFA10VxQWd1AbiqgORKZK4uiDpW19wA3KeaXoOKhKS50yANL+DnlnMB1UoUb26Mw3PUJMHcIkYYO3HWDwRT/BFARhMLQYrAB8daG3kxB243Jgyk+qLElDIryC6jN4TzTtpKP8CUHr5fQpeHXOYFg6ux6G1rOsoR4aOSWgup3kxfnqA2Zu7f74EJJnvuTciQliSqdmej/JJE989vTKibw6XDdD4M3HMrsmf5Q0yOXxR0Vig==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by GVXPR04MB11655.eurprd04.prod.outlook.com (2603:10a6:150:2c2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.12; Fri, 17 Oct
 2025 04:43:15 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 04:43:15 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v4 2/6] bus/dpaa: imrpove DPAA bus qman logging
Date: Fri, 17 Oct 2025 10:12:52 +0530
Message-Id: <20251017044256.3264737-3-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251017044256.3264737-1-g.singh@nxp.com>
References: <20251014101716.2885563-1-g.singh@nxp.com>
 <20251017044256.3264737-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0046.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::14) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|GVXPR04MB11655:EE_
X-MS-Office365-Filtering-Correlation-Id: 867adb91-33ca-4965-1b1f-08de0d37afb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|376014|19092799006|52116014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?GKnousBIPvOZydOPO8v+S0esptLk9A3bd3bdEoZfow4FK5kEWyURN1SAvFiq?=
 =?us-ascii?Q?oXRjdD9vT9oAGmkJhR7jtv/ggYydGKTFre9ASSXCb7rIdqwuqxUXj3AmGD6g?=
 =?us-ascii?Q?oYlLr5IXeauGurjC+YIcVTyWGjwEf7gqe/Z8nrVCR/eVyb44t/UNhEP5q0gS?=
 =?us-ascii?Q?eBwhYxPs85Z+TCGwIzfPyKGLP5X4Ihul+QrZYnUQbkAabiNPK9w3AC++qa62?=
 =?us-ascii?Q?CpOiUSsJUZ9OCS6NWbh5oHNsZ9Z2u5WZjbtFn1lXJZO/1Q2VdG/zSFXUd7po?=
 =?us-ascii?Q?YycqOjxj+8nm3dAxuUx69W0sYbHY1Ukde6Hh4qksu8V4mWCOkm2tRcDfi8zq?=
 =?us-ascii?Q?422AmS+JUs2xcsYS2u33uVp2aKL3CA8czDNG9sI3IOR0E6+3ia61s/dk5jkb?=
 =?us-ascii?Q?YZSYacrnlHUKSiplpw/zyZr1L/p1yRMGcSaxLDfdYrjnyOgFK8jjbO0T3lj7?=
 =?us-ascii?Q?24/oUy99CJJVziKAIWh8IwgRKYzZdBNY7akbqC/GlzNz0lAQ/uE+mN3mfRxZ?=
 =?us-ascii?Q?lg4h/YCqDTnjk40/IpBreZytKrZUSP52Zofvtl2tLjhfIIa6ASVca9rEnlir?=
 =?us-ascii?Q?pUkmeCs6StfyZJAaJ6Lg26pX8ZsLmyLLEXqGF5fJSUKwdYASJgTx3Cek22mO?=
 =?us-ascii?Q?54EetoJoAH73aRmgmBIjfji2yt4SFO3gEEnjpjxSO9MNW322OYalVSCmP/Sr?=
 =?us-ascii?Q?PcRsw+LIejsRc4/s6VOeokCzHOBwDYS3rusJQ+s0pxgVrHG3CpNs5hc+wzbS?=
 =?us-ascii?Q?Ot6D9B7O04gQXvMF51d9tHpOJhY1ZBNOT6oleI3NdJmNbwrYTgAiD/I4Aqgz?=
 =?us-ascii?Q?ZeNFw9iHjom52Nlx6ydkHkRqHfS6pydoM46bcFc3nGDdyoHkLCgPSznF8izi?=
 =?us-ascii?Q?bt9FTxvQ8MFwnGIdIeUxRAtAjKGl0ruwRBX2Td7tEDrlmaAi/1cKgqHLEPqs?=
 =?us-ascii?Q?Fe5Ix2GNEXIpv8dcXfaf+wV4BuQmpx5sSy4Phm+Q9PH2LnAWiDjiEu2T8zWs?=
 =?us-ascii?Q?XehWq7rujG7iqSM6TQTi8/HJ5poSkOmAorV89OMOHltoc6ZOx18dKWDT4xx+?=
 =?us-ascii?Q?ivZO9cZFfJBQBvYKRU4yu1pBHikZjcgo1y/xt0v4cNjqLBrXsFGYmYC4jJib?=
 =?us-ascii?Q?V/G3oGrWqbtJsTGL0nWEyzUungjB/wI8Mjs94hqce3XPzNqp4gKtwPiBhr3W?=
 =?us-ascii?Q?3ic7Qx/wAw0t0bMsKa26iHhTNAw1vZ+LglT155wpdPQW+XkKZ14IZZ02nEp9?=
 =?us-ascii?Q?hzJfrWsNK4s9MGXzRXz1OEGWPb6Dy91JpnvFOByNo08kJyFRJxojGlwJmF8H?=
 =?us-ascii?Q?7yBxHKSRbDD9j908KBPLRN9iRVzNIVz8zJCRDJe0N3QfLOeP+8wlHEHqcqYM?=
 =?us-ascii?Q?/pQ9T9fjiAspI8D4aLPTrr1dmBBsKro+nuX2iFoXlifpSLdMLEJgO+A86/ns?=
 =?us-ascii?Q?5gqkjnD4PAWkXvKtY/wnl5MhOug336Huu03v/wmECBZKExNhzs9SVTfj/eVx?=
 =?us-ascii?Q?4C5cx3PaAd1ncaV8SCVeTFOHQVI4k8Nw7oUb?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(376014)(19092799006)(52116014)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GLUnCZfE3ue+7tnTPD6hxKpNCzjQityn2w5egdhhxTA1HgQFYyLSJoZyg+/h?=
 =?us-ascii?Q?6kF/C+VLpPJzwOgiGF2JsKOYng+zyDkv/1zZKHPKQJHLlZDUWEa/3pTiptmn?=
 =?us-ascii?Q?wUWi6D8SP+rbHuBAINo+l7+j/kotTrwsNDOgDmGeSebRFlSLb9yX/a/U6MUK?=
 =?us-ascii?Q?2OGGbVDhXFoNz6JCAL/NMX7Uww6sR/PlXXXl7m7Ol9vg7wHdhH52OrEBqOT1?=
 =?us-ascii?Q?RVFEckZB0zPR6UqNBt9tKzRWnWBaEmfYqiM+2Q6YWGO8fpDuQkkv4924r/xN?=
 =?us-ascii?Q?bBg4Pu6I/njtX7dbD/XoltG3wqTF587NsiEhEnXsVDEECqaqlJqebIE6iz6J?=
 =?us-ascii?Q?VuaU9Dr+iwFIngnJLsbsYgHnRiGXZoePxu37NUuLanWEG9aKQhVANhWSrzkW?=
 =?us-ascii?Q?+j7za8YZJjFjG3WKKCaGsSTzbkVep9K5KN53jawF42n1Pk5NT00CKJ2lJxUQ?=
 =?us-ascii?Q?ZrDf5Q4CqovCpbcbTmPdts+pT5XzNS/del+EZuSS7yH/qhbKV+5tkJYXsc5R?=
 =?us-ascii?Q?PcYYvmuOXQgY099AR4R5vpgl4BUwSFs31YliQCRBTmgNpnCk+Y7Du3f2ptID?=
 =?us-ascii?Q?HxVVbo4t/ZlUn8gSpnREtytkmgl2m9g6hn+cAEwCIYYvfGDhlKKtWobAjmuR?=
 =?us-ascii?Q?LCSuteM+HbBP0tWSSux6rZRKMgxNVDFL3RJx4dRGJMtUAIxCbh4kSFot8ADq?=
 =?us-ascii?Q?IuGYBYz1yB4RQkiD6pAlMIA0sOTeEhYmwyLWVbhEHh7uxw1mKJtgJT8sMrrL?=
 =?us-ascii?Q?V+aThc4Qfz7QaHY9mr36dJwUTWlK/Qphm1TKWjxQNdhP9EvogCr5s95FeIcK?=
 =?us-ascii?Q?BNEyf1qNmJ7qdM4XQZoC0uPirYiC9dghcE2YA7d5HwrXzPA8EHCMuJ5+TNIK?=
 =?us-ascii?Q?xfgM4ohuvuX01IOuRse1x9nr4nY/YiUVCM0PZu00p1qY5Q2SZEQhzkjtzSTO?=
 =?us-ascii?Q?7q5Dx6Zx5iy+1QQd7sX0/dmAnryCbycqW+XoQCrm/a16AxjjlFFm/i7+KuYc?=
 =?us-ascii?Q?fYwVteKL+jzkRvhbaf5S8nCnZShG/FpS8iretgNCqPMo5Y4I4hZ0ovMhut6U?=
 =?us-ascii?Q?dOen0SrurtkrAJ3JhMSoR+TSpWPHLA570uCM9T9oeHzAZ7Krsj4LoIA+iEOR?=
 =?us-ascii?Q?Kl2VshI1mrecJ0yBS18rlJbu46j85GvovAmP8/PY8Gqiv3hvjALhxTBxYkQi?=
 =?us-ascii?Q?5/t5NnBnJmY4DDcing5mInitJHhX48eAoAFiW1QUYc+18nKKatyuhWS1YB/3?=
 =?us-ascii?Q?qPs79rQizHkWrpu0C3EAc0xLjHQGtVPrMWspPaE6pcHeZSRGBN6traa5aYDg?=
 =?us-ascii?Q?MyvWFL5DQVXjhAs2Dnk8kKZRoys63ZQy/lcey2bdEbzAqXYuqFZc//R9nLfB?=
 =?us-ascii?Q?veIdW+UHJgZavoDgf92K6869n9g1yQessAwZcjwjUxRU3dgPRY3HHUjrKiWx?=
 =?us-ascii?Q?QpMkLDaeyNJ9wGNRl15Su96GSBPFZsh2MAX79emKJFm8XkXjaLLOYGvsBuzA?=
 =?us-ascii?Q?3hLS1rjOWQYiu5te6InLMtdXJ6frDprL+oPjJ9gV3w4bdZRuiujPc/hPvjzp?=
 =?us-ascii?Q?V2B1E0m9+3k0q0Cm8D4=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 867adb91-33ca-4965-1b1f-08de0d37afb2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 04:43:15.7977 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bK5p5bCRxfMj1jeJ2F5qcn7ZeeUfVssUAoZcuL7dWXtEZg0VW/E0BDCq47jQcazR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB11655
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

update logging to use DPAA_BUS_XXX instead
of pr_xxx for better consistency and clarity in error
reporting within the DPAA bus subsystem.

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/bus/dpaa/base/qbman/qman.c | 74 +++++++++++++++++-------------
 1 file changed, 41 insertions(+), 33 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index 7c5ccc51bc..d6b2a58eaa 100644
--- a/drivers/bus/dpaa/base/qbman/qman.c
+++ b/drivers/bus/dpaa/base/qbman/qman.c
@@ -138,7 +138,7 @@ static inline int table_push_fq(struct qman_portal *p, struct qman_fq *fq)
 	int ret = fqtree_push(&p->retire_table, fq);
 
 	if (ret)
-		pr_err("ERROR: double FQ-retirement %d\n", fq->fqid);
+		DPAA_BUS_ERR("ERROR: double FQ-retirement %d", fq->fqid);
 	return ret;
 }
 
@@ -162,12 +162,12 @@ int qman_setup_fq_lookup_table(size_t num_entries)
 	/* Allocate 1 more entry since the first entry is not used */
 	qman_fq_lookup_table = vmalloc((num_entries * sizeof(void *)));
 	if (!qman_fq_lookup_table) {
-		pr_err("QMan: Could not allocate fq lookup table\n");
+		DPAA_BUS_ERR("QMan: Could not allocate fq lookup table");
 		return -ENOMEM;
 	}
 	memset(qman_fq_lookup_table, 0, num_entries * sizeof(void *));
 	qman_fq_lookup_table_size = num_entries;
-	pr_debug("QMan: Allocated lookup table at %p, entry count %lu\n",
+	DPAA_BUS_ERR("QMan: Allocated lookup table at %p, entry count %lu",
 		qman_fq_lookup_table,
 			(unsigned long)qman_fq_lookup_table_size);
 	return 0;
@@ -350,7 +350,8 @@ static int drain_mr_fqrni(struct qm_portal *p)
 	}
 	if ((msg->ern.verb & QM_MR_VERB_TYPE_MASK) != QM_MR_VERB_FQRNI) {
 		/* We aren't draining anything but FQRNIs */
-		pr_err("Found verb 0x%x in MR\n", msg->ern.verb);
+		DPAA_BUS_ERR("Found verb 0x%x and after mask = 0x%x in MR",
+			msg->ern.verb, msg->ern.verb & QM_MR_VERB_TYPE_MASK);
 		return -1;
 	}
 	qm_mr_next(p);
@@ -424,11 +425,11 @@ static inline void qm_eqcr_finish(struct qm_portal *portal)
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
@@ -478,7 +479,7 @@ static inline void qm_dqrr_finish(struct qm_portal *portal)
 #ifdef RTE_LIBRTE_DPAA_HWDEBUG
 	if ((dqrr->cmode != qm_dqrr_cdc) &&
 	    (dqrr->ci != DQRR_PTR2IDX(dqrr->cursor)))
-		pr_crit("Ignoring completed DQRR entries\n");
+		DPAA_BUS_WARN("Ignoring completed DQRR entries");
 #endif
 }
 
@@ -576,30 +577,33 @@ qman_init_portal(struct qman_portal *portal,
 	 */
 	if (qm_eqcr_init(p, qm_eqcr_pvb,
 			 portal->use_eqcr_ci_stashing, 1)) {
-		pr_err("Qman EQCR initialisation failed\n");
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
@@ -616,6 +620,7 @@ qman_init_portal(struct qman_portal *portal,
 	portal->dqrr_disable_ref = 0;
 	portal->cb_dc_ern = NULL;
 	sprintf(buf, "qportal-%d", c->channel);
+	DPAA_BUS_DEBUG("PORTAL ID = %d and %p",  c->channel, p);
 	dpa_rbtree_init(&portal->retire_table);
 	isdr = 0xffffffff;
 	qm_isr_disable_write(p, isdr);
@@ -625,7 +630,7 @@ qman_init_portal(struct qman_portal *portal,
 	snprintf(portal->irqname, MAX_IRQNAME, IRQNAME, c->cpu);
 	if (request_irq(c->irq, portal_isr, 0, portal->irqname,
 			portal)) {
-		pr_err("request_irq() failed\n");
+		DPAA_BUS_ERR("request_irq() failed");
 		goto fail_irq;
 	}
 
@@ -634,19 +639,22 @@ qman_init_portal(struct qman_portal *portal,
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
@@ -688,7 +696,7 @@ qman_alloc_global_portal(struct qm_portal_config *q_pcfg)
 			return &global_portals[i];
 		}
 	}
-	pr_err("No portal available (%x)\n", MAX_GLOBAL_PORTALS);
+	DPAA_BUS_ERR("No portal available (%x)", MAX_GLOBAL_PORTALS);
 
 	return NULL;
 }
@@ -857,7 +865,7 @@ qman_ern_poll_free(void)
 		fd = &swapped_msg.ern.fd;
 
 		if (unlikely(verb & 0x20)) {
-			pr_warn("HW ERN notification, Nothing to do\n");
+			DPAA_BUS_WARN("HW ERN notification, Nothing to do");
 		} else {
 			if ((fd->bpid & 0xff) != 0xff)
 				qman_free_mbuf_cb(fd);
@@ -963,13 +971,13 @@ static u32 __poll_portal_slow(struct qman_portal *p, u32 is)
 					static int warn_once;
 
 					if (!warn_once) {
-						pr_crit("Leaking DCP ERNs!\n");
+						DPAA_BUS_WARN("Leaking DCP ERNs!");
 						warn_once = 1;
 					}
 				}
 				break;
 			default:
-				pr_crit("Invalid MR verb 0x%02x\n", verb);
+				DPAA_BUS_ERR("Invalid MR verb 0x%02x", verb);
 			}
 		} else {
 			/* Its a software ERN */
@@ -1508,7 +1516,7 @@ int qman_create_fq(u32 fqid, u32 flags, struct qman_fq *fq)
 	fq->cgr_groupid = 0;
 #ifdef CONFIG_FSL_QMAN_FQ_LOOKUP
 	if (unlikely(find_empty_fq_table_entry(&fq->key, fq))) {
-		pr_info("Find empty table entry failed\n");
+		DPAA_BUS_ERR("Find empty table entry failed");
 		return -ENOMEM;
 	}
 	fq->qman_fq_lookup_table = qman_fq_lookup_table;
@@ -1524,7 +1532,7 @@ int qman_create_fq(u32 fqid, u32 flags, struct qman_fq *fq)
 		cpu_relax();
 	DPAA_ASSERT((mcr->verb & QM_MCR_VERB_MASK) == QM_MCC_VERB_QUERYFQ);
 	if (mcr->result != QM_MCR_RESULT_OK) {
-		pr_err("QUERYFQ failed: %s\n", mcr_result_str(mcr->result));
+		DPAA_BUS_ERR("QUERYFQ failed: %s", mcr_result_str(mcr->result));
 		goto err;
 	}
 	fqd = mcr->queryfq.fqd;
@@ -1536,7 +1544,7 @@ int qman_create_fq(u32 fqid, u32 flags, struct qman_fq *fq)
 		cpu_relax();
 	DPAA_ASSERT((mcr->verb & QM_MCR_VERB_MASK) == QM_MCC_VERB_QUERYFQ_NP);
 	if (mcr->result != QM_MCR_RESULT_OK) {
-		pr_err("QUERYFQ_NP failed: %s\n", mcr_result_str(mcr->result));
+		DPAA_BUS_ERR("QUERYFQ_NP failed: %s", mcr_result_str(mcr->result));
 		goto err;
 	}
 	np = mcr->queryfq_np;
@@ -2062,7 +2070,7 @@ int qman_query_wq(u8 query_dedicated, struct qm_mcr_querywq *wq)
 			wq->wq_len[i] = be32_to_cpu(mcr->querywq.wq_len[i]);
 	}
 	if (res != QM_MCR_RESULT_OK) {
-		pr_err("QUERYWQ failed: %s\n", mcr_result_str(res));
+		DPAA_BUS_ERR("QUERYWQ failed: %s", mcr_result_str(res));
 		return -EIO;
 	}
 	return 0;
@@ -2089,7 +2097,7 @@ int qman_testwrite_cgr(struct qman_cgr *cgr, u64 i_bcnt,
 	if (res == QM_MCR_RESULT_OK)
 		*result = mcr->cgrtestwrite;
 	if (res != QM_MCR_RESULT_OK) {
-		pr_err("CGR TEST WRITE failed: %s\n", mcr_result_str(res));
+		DPAA_BUS_ERR("CGR TEST WRITE failed: %s", mcr_result_str(res));
 		return -EIO;
 	}
 	return 0;
@@ -2113,7 +2121,7 @@ int qman_query_cgr(struct qman_cgr *cgr, struct qm_mcr_querycgr *cgrd)
 	if (res == QM_MCR_RESULT_OK)
 		*cgrd = mcr->querycgr;
 	if (res != QM_MCR_RESULT_OK) {
-		pr_err("QUERY_CGR failed: %s\n", mcr_result_str(res));
+		DPAA_BUS_ERR("QUERY_CGR failed: %s", mcr_result_str(res));
 		return -EIO;
 	}
 	cgrd->cgr.wr_parm_g.word =
@@ -2147,7 +2155,7 @@ int qman_query_congestion(struct qm_mcr_querycongestion *congestion)
 	if (res == QM_MCR_RESULT_OK)
 		*congestion = mcr->querycongestion;
 	if (res != QM_MCR_RESULT_OK) {
-		pr_err("QUERY_CONGESTION failed: %s\n", mcr_result_str(res));
+		DPAA_BUS_ERR("QUERY_CONGESTION failed: %s", mcr_result_str(res));
 		return -EIO;
 	}
 	for (i = 0; i < ARRAY_SIZE(congestion->state.state); i++)
@@ -2590,7 +2598,7 @@ int qman_create_cgr(struct qman_cgr *cgr, u32 flags,
 		/* we can't go back, so proceed and return success, but screen
 		 * and wail to the log file.
 		 */
-		pr_crit("CGR HW state partially modified\n");
+		DPAA_BUS_ERR("CGR HW state partially modified");
 		ret = 0;
 		goto release_lock;
 	}
@@ -2610,7 +2618,7 @@ int qman_create_cgr_to_dcp(struct qman_cgr *cgr, u32 flags, u16 dcp_portal,
 	int ret;
 
 	if ((qman_ip_rev & 0xFF00) < QMAN_REV30) {
-		pr_warn("QMan version doesn't support CSCN => DCP portal\n");
+		DPAA_BUS_WARN("QMan version doesn't support CSCN => DCP portal");
 		return -EINVAL;
 	}
 	/* We have to check that the provided CGRID is within the limits of the
@@ -2657,9 +2665,9 @@ int qman_delete_cgr(struct qman_cgr *cgr)
 	struct qman_portal *p = get_affine_portal();
 
 	if (cgr->chan != p->config->channel) {
-		pr_crit("Attempting to delete cgr from different portal than"
-			" it was create: create 0x%x, delete 0x%x\n",
-			cgr->chan, p->config->channel);
+		DPAA_BUS_ERR("Attempting to delete cgr from different portal than"
+			     " it was create: create 0x%x, delete 0x%x",
+			     cgr->chan, p->config->channel);
 		ret = -EINVAL;
 		goto put_portal;
 	}
-- 
2.25.1

