Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 551D8CCD187
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 10:17:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7D2B440656;
	Tue, 14 Oct 2025 12:17:37 +0200 (CEST)
Received: from AM0PR83CU005.outbound.protection.outlook.com
 (mail-westeuropeazon11010041.outbound.protection.outlook.com [52.101.69.41])
 by mails.dpdk.org (Postfix) with ESMTP id 1C3E040649
 for <dev@dpdk.org>; Tue, 14 Oct 2025 12:17:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=X1dOBwxVRKX5yN9UKMk+vAe80boiH6RVJSasmyTIRKaMtsUkthtQ+VBbgzVVw5v7iTuzCursOnyyd6E9QGASRcTWtf8tkjte9kH4bgqsbHLM/2HwWW7TN5jrEoruDcd6EBCyWVB5FQGJZnN4FDYbMMipe9dXdJWcgtlQmG/imbDiDOBP18pyD7PH2J/Wjvpk12trP8/2NvzfoNmIGKqJz6Ea4YHeDkS285YqZix/FY2QJqqlsjnzaiAnRDsHR7uYVzoHZQ9np855as2qJpx7snBqL8G1YAmNYaRgd7VaQxHLfHnpTlPBA4sXuaDLS4t1Z9ml0IuYTeMWLTFKL38Frg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7sOiyja4gKlU8QtCDTdPLOyxEqQHVHHWQHCYYcEeTc=;
 b=vbOaDPvl1wmUZkKSKALn2QaiA5nX03HTZeiqr3VPP7Bqx+Vu6v3MiErRBg1exNevgveq+7W+EB4LhmX9DJQ0U/w4JxCZy43YXfBFBCwQPPBJGd3I73xhziFOCg4Vu1b3YtvPifR0bWbMoca7fKxdwUrjKAHX4ab25sgZLlJ2iVvuhwC2lWpT79H2LHuMNejyjq75usyuVghGXoL6XEmf8qa9w7yguo99367Y67RQUbS+xwFmqXOhhNO2R0ZxEbNq+TajKYZoQv7uBnNfgJd1FcW8cn66fOoAs0sf6n/wwYvU2YINWTVs/Hmcjvn6pN2W+XOv+rHpsYB4VrShSg7aIw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7sOiyja4gKlU8QtCDTdPLOyxEqQHVHHWQHCYYcEeTc=;
 b=kVKkNL7K3Z7ko7wYpvWSF3M/DvJfVDQjO1Kbm6DSR90gDyMtmAvLcQPFTqCST73rjlqp3RSGPIF2XcrHCUlMR+ydoBoYC7ZcEAvqCqGB/A9qbF03d/H+RCkSPnvHMdaEGAIHlW6dova4jdi6/V7VsKSbA/uWCS0GRWEkC6P/R4mAk+AkO51aTGF0OKPYydsSoKTsnLBBBV5QffchQReRajsYkzfRs8S2xBu6Dlnfni7aDpS8qxwSdBlYatH7dl3PMY71YOSTVUiKeavF8han6J/PIaBBeO4WrPu8Lonjik7CfCEFdFettv6SNv3D0eHg5vuM3XCSib/d3Shu+i/vDw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM9PR04MB7617.eurprd04.prod.outlook.com (2603:10a6:20b:286::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Tue, 14 Oct
 2025 10:17:34 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 10:17:34 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v3 1/5] bus/dpaa: add FQ shutdown and improve logging
Date: Tue, 14 Oct 2025 15:47:12 +0530
Message-Id: <20251014101716.2885563-2-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251014101716.2885563-1-g.singh@nxp.com>
References: <20251008043519.2461707-1-g.singh@nxp.com>
 <20251014101716.2885563-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0018.apcprd02.prod.outlook.com
 (2603:1096:4:194::18) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AM9PR04MB7617:EE_
X-MS-Office365-Filtering-Correlation-Id: 17eba282-b381-4b2b-8370-08de0b0ae45c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|366016|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?pzePwaNkyqKbbhtutE8fQD7jRrbieEqWN4ITXM+rEyg+6sz31vM6NdrhfeAX?=
 =?us-ascii?Q?vgEGaXocmKElKL9mqLMOFPZiWIPQV4IO5b9xoAXh6TZ7TFyFixbYc8GDFE5t?=
 =?us-ascii?Q?kSZPIGaoItZNr31tO55kuPfkpdPKzP+uF74lL3N0G51uwZB7LPcBSP67qJ1D?=
 =?us-ascii?Q?mGSWX/q51kNRA3EfPhgrRRodJXDFH/jmWC2F9QEN5Ea8ZwyN0Ukfy65mbavX?=
 =?us-ascii?Q?ewgSkm3wXPjcMOn4t0fnv4DKgIfYIqfYPxk/h04b2N0hdaV5vRz5u4Dkhu3z?=
 =?us-ascii?Q?dtNsUGN7sXszn1ujCyk1bmnU6FlGBu+ZsdZZIdVMaywrJ40rJ5DTsbuYoYSD?=
 =?us-ascii?Q?042AyMkqCozh0BUg8gkvxbDWYsK6pGVcR4nFTgA4aexYiaJUGJUJ7hivBcjP?=
 =?us-ascii?Q?gkfwcdb2HcB+2V+TMUDf95blcIV7bqxsLCpTkKcev6bwqw5YQb5jy1G5PStn?=
 =?us-ascii?Q?AWcvfDJ3P1tilTP35ChCs1BJdnS7dEnzuFgEhKRHDPU1koJzHze0bQzd39H0?=
 =?us-ascii?Q?TCUtfS+PWCh7fxCQzTW2C0hH4HaXIkmxovUDTsurwfoN6ehZI33tx/RNOAdR?=
 =?us-ascii?Q?ETNeot2tILQrBlXY9kEeOiUK6MKq4n7uhe/kSxuc/9rmgyZ1VUuWlmaF5HSM?=
 =?us-ascii?Q?hiKWf/fJOxFerwOspmSsKfUM3yHvAI+V+FBkxkpQEWgdgbIG+tawfn8lDx4C?=
 =?us-ascii?Q?9SiYBxnJ2ZlXAEqZK+otbZOLSmwABz7yhvPBS1g6+2ZO27PNEHuxt/AXhfLu?=
 =?us-ascii?Q?D7oxA5F/4jvG/ini+i3fd4AVMkJxgAQj8O8skDK+1TZiH/ESGmyhsiituSCP?=
 =?us-ascii?Q?txwHOGWRIL/XYyaTcVSok0UrA8ejNHqhVfdIm5zBQnMX2HRW1kz6Wv2n6Y4w?=
 =?us-ascii?Q?zDLEuI6+GjijyYqmGw8gOu4P8eEO8Y0DV0jmt1b7gHoRXH+7y91GIRpyPsFx?=
 =?us-ascii?Q?/PNr2VXtnvIXIXwI7sZdQdCClcDZlASfOyE5ArZV3MRc6P6q6co4Pzqr/6eG?=
 =?us-ascii?Q?Qep2lx3dPb2dj1xjp6qmd7d5viLrRNKa22IdENcXjTj6eHZ5QVTGb5zKZpVT?=
 =?us-ascii?Q?/EvqC6PiAohQtuWZs4XGhPlcXrHs6HD8n1nCnuczGp4WE9Q6dn64OUmtu6Gf?=
 =?us-ascii?Q?GnMTvjB4+8rI0ar854uVobUKTv2JC+ujq75ptnB9S/n2nomH3EfdRQEVKhkS?=
 =?us-ascii?Q?UmYuN6ccysQ8hMaol5ACVs0tKkAuKPUDbb+j4rpMR7Tp0yRGJgLrn50fcsqJ?=
 =?us-ascii?Q?GQve9p5GuR9z1Wjv6Rxqrgz7An87JufuaXUUs2fcZ275uGdDJroG7fSjO41z?=
 =?us-ascii?Q?0obUqGCzf3bAhZ3GtOwFEZK7f6HkUhifpNcVOu8ot7O8+TgL51KJpp7O9fbD?=
 =?us-ascii?Q?YuF2RuEe1rXAc01gjLzuKeaO7n4T1ZSfmk6Kfcvk3Cv6Vnv/4QQr1Evji/aw?=
 =?us-ascii?Q?L1eYhw1L9ie7q/M5VVTMwx48Kc9lOBV0Psuz/IfngnIDNN5UZnOk3EmNayJQ?=
 =?us-ascii?Q?+eH0YQdBc4Ig68jVkgMSWKumN8CbgRHH4Q3/?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(366016)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Qsy7r5OQN06uxKra8HKHNgvhEK6qKzFl2NYSxDeywAHX3r9Qn55B2Mg5/6Mz?=
 =?us-ascii?Q?RkfImr7tLcCbZn3ziZRjaBUJBZaTx9xLunnfJ1h8k2ReEiWLubk0Bl3EOoUO?=
 =?us-ascii?Q?34afJvLch5G8v3Al7JPMgPYakQakwOLM+eb/4+re13h/sk61lN9N7P2NwWaE?=
 =?us-ascii?Q?CACfuqChdfQbRU1XIdKrE9np+hcrE/E4ajSCxnzwcE+j8ahpPDAC4Ujbdnpl?=
 =?us-ascii?Q?x4qnJdeirTWkrfDMEWTd6ew+lSTzXN5sSa5fzrPuBgzX6gqbXWjpEmBG9JnC?=
 =?us-ascii?Q?AlOwYA6PkcD4fWxshpbg199A5AmnhLFuxPaRmUDe+NlRd5FxFZRj1iFk2GlR?=
 =?us-ascii?Q?U0WFM3HI4meGRXX1jdilXjvVTvTCxSuAdAdBqj1pWSZ43gCdLrlejoN8OuXL?=
 =?us-ascii?Q?GtRgxTkU49W5h5BqcjV7phCv/uPn3i6Z+kb/HuZTupBIjmaYTHht8wDIBYhQ?=
 =?us-ascii?Q?U//8r8uniy/xpJNsO636rfrOS5Z9TEj0k0wnF7284a5jcT7jQCZMRbRzMyo9?=
 =?us-ascii?Q?cQ6BWrFCt8p0hKTJVvx+2GflkNTWU4qMbvAZTVcOqv93EqaNTLI6HGzYUGnu?=
 =?us-ascii?Q?EGB7iX3hEtjjot9tmjAs7Aia4tY9S/6QgCJH9t2CNeUjJ/JyE91XRyv0NYwh?=
 =?us-ascii?Q?ldKWUs/Y7lmc4uzuLtPTD78neXqcriSPcAToJYIvT45CWZwaygsq55IzZvYU?=
 =?us-ascii?Q?2xqXK2TGG2fbKeOmLvVHFIbToNZbZhc8A0zEHABjhx9ns8tuKH3Z7vn/4wlu?=
 =?us-ascii?Q?WTNwfF1zfKL77cc+8aP8WJ5sjTnTM/TplhOK5eSov3NtZuR2tkyrBiAKS78b?=
 =?us-ascii?Q?hXfiK3Fy0GSHqV0d3EzjH1MXFFYVpba3wjyAhdQ61/CZqv4rHh199ZAhzNYy?=
 =?us-ascii?Q?GzGFSRWQBJnH+TLNhpk8tTURAq7Gc52tT/ywG7efF7sgIC6W4UexU48N7A/2?=
 =?us-ascii?Q?Wg9XL3PEBq8qGnTZGNWj7VreIn5WRNO2zu+KwDf0gpsXNOcLVEIdIHQlqsMo?=
 =?us-ascii?Q?DTNiCIOoZ7a9pPP+tj86kW6A61tYMKoKWapMjiqUORrxo0v6jJYe0vm4Kh+R?=
 =?us-ascii?Q?3KEs3DoFNZv/lskNNESFYzBDqcenRitXKPzI1/9oCoIWNtMxJ3nvpE7B8NkZ?=
 =?us-ascii?Q?kzHqBJkUZNVwCwV4n5qJo2WFJ+UsxIaTaDwRh5UFzzZCFehkHmnBf1T22tDe?=
 =?us-ascii?Q?DWYdERc7HCnYlOYwyB3XZfqPfofo1NgzaKzGoiCL55JTYttf2Qb7w8otX1bM?=
 =?us-ascii?Q?krnVp7VCpFRzPFeO03vXuapkdI1cTwMoJZTGjHqTLXCJcHkea+T9XpSudfpp?=
 =?us-ascii?Q?Zj4W6J2W4/4aRi5VZ7zl6xv1wnA7Q3p3M2WmphZnEVimugFHPBTQ25UiZpQk?=
 =?us-ascii?Q?nJJJOQVDTNYob5hd1iI4GAGjhbW5U5nkNSfedRCD0yvE2X2GzsroDPZ6GAm3?=
 =?us-ascii?Q?1AyO4LwjzHgvl66lVaCLN2TLoyjHStWlIFxMoXKf5O8nMs+6Jas3MctQnvDS?=
 =?us-ascii?Q?sVSIRyXS6JEpzNUNTkW757P0jxswc4p0ysERdmmXTycY1HUiGprhXn3ctwwP?=
 =?us-ascii?Q?lECtySCzLXg8c2R46L8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 17eba282-b381-4b2b-8370-08de0b0ae45c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 10:17:34.5764 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Udyg0GSCD9WJfGBuwnFbeBS9fVTUWVipwoqreKZACv3RcYyUm/e9yLIv6lg+KAra
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB7617
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

