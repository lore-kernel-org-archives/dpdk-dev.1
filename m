Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 478FBCCA470
	for <dpdk-dev@archiver.kernel.org>; Wed,  8 Oct 2025 04:35:45 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9711B4060A;
	Wed,  8 Oct 2025 06:35:39 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11013021.outbound.protection.outlook.com [40.107.159.21])
 by mails.dpdk.org (Postfix) with ESMTP id 0CF2240297
 for <dev@dpdk.org>; Wed,  8 Oct 2025 06:35:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j83j0bx1VEeVKJP86f68QBq1hbAMKq0p53bHGl5PSc1ATD+Ro0wqox5TxMoZpObwRoPq2+haY/uCGETLgiNVNxr6VgvfQkQdFuGW0Im/5+Gs9jC4QpSA8n+rfK6IqO4DiJdp8I7iYrAaB+AZ/LMHalVFOG1krxF87q9e/61znexGAD1ZuFexpFFk8guSgGd88sjYJuwDLsdbRay+bP552Wa0gXDeBqErBm0y+woTlN83Z8XxPbV6Z8aDfOMLn5CpDxzEVYS3P0oqy1CihQ0UdbYQCWHP3Q9bNBGlyKcTiCEb1IenBSigYBi6zKl2gear5/K6DiR5grEob2zSnu7cZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=c7sOiyja4gKlU8QtCDTdPLOyxEqQHVHHWQHCYYcEeTc=;
 b=i3vCN8Cbd6cD6Uvne9KfTKLiFL1eRDxc9HnpIWexlOew9tf1eo/bQGHpyKzp+Mkr5HNdUIxmAbRnVh8lPHUkepgqP09t9Sx4W7yg20oREjoPnGBBk9Ph7+VbuedtHjnt3LFE5YgamaaQKPNBlqCGHyCF0QjKjcfE0WF/AnQW2pxENGbecSlIAsj+5HFftysU4g14qKxbIzbyl2nu4qZa5EDu6oPZn2+EzCmwy1J36TarNQaqsgMdkeIfo8oboHFrwUEDqqgEoQrBp21lHob5SGiXY3QaVLCGGb1QO/N+N4NfmfM+YWEzun5R9rMuiMiK/ysHYai4VGmfuAYrgCMhLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7sOiyja4gKlU8QtCDTdPLOyxEqQHVHHWQHCYYcEeTc=;
 b=a6O/PoKxESdWOpHB4hj5pWuRWhRU1PRh8kPZgZE1LXlSpV4gPsW6kbNgM+XZdhZgecCfgNresogJae5+1PxOE0fEifZ/aG1BWRxMFD/XgiEaqWvWTEHDdeVZa70as667FlYmRiJlK45Nz68fyju74aywa8u3hXB0OapC3NwuV72kKASKa2yuXK6GbN9x32GkEzDfWBigIQxYS+cSz3wdZrQd2lMj9LVC5mD/94PeOrKxO21HqbUbv9Fhi8r7FIDLZfPs2hFFjiOm2N29GeH02en0sb7vSO6x7Olsmg/hrcioEmZO1Dc0XyKsLn6j8vFDKizxS9f15hMZ74A0rpkkVg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AS8PR04MB8150.eurprd04.prod.outlook.com (2603:10a6:20b:3f0::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Wed, 8 Oct
 2025 04:35:36 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9182.017; Wed, 8 Oct 2025
 04:35:36 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v2 1/5] bus/dpaa: add FQ shutdown and improve logging
Date: Wed,  8 Oct 2025 10:05:15 +0530
Message-Id: <20251008043519.2461707-2-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251008043519.2461707-1-g.singh@nxp.com>
References: <20251007050012.2432449-1-g.singh@nxp.com>
 <20251008043519.2461707-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0031.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::11) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AS8PR04MB8150:EE_
X-MS-Office365-Filtering-Correlation-Id: bb2448db-692e-4184-0e24-08de06242052
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|1800799024|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?xVKrqPVF3JNzGLqVGTrI4vnRHL2qsk9RZ4u0az/9aCkN95G/XhCZgEFXZFym?=
 =?us-ascii?Q?XcXvr1+je8dYe+xhdfLk4SitWpzEPsYsnHifAolxe9zEGPhDMZQZL1m4tmGK?=
 =?us-ascii?Q?kufTUPr2YL6rW+JMRxdQnLmbRbwS7CyCjJb1IJ/x7rl4why8QwHrYu+9ayLA?=
 =?us-ascii?Q?M6aIU7HqNq94NBmOZQu/1uNTz4uhlZg3RvB6bXSwzn0yoUP3Hw43m5LDsrTD?=
 =?us-ascii?Q?TMoEfEPEw3ml12Z12YeN/f1Eokf/yQRjUCOEO4i/BsyMq7BGTdEhOmWD4Dsd?=
 =?us-ascii?Q?SQPnDVGe4q6sOwKABZlAkdt89cLWdt5FrXLBZzSXUczbl7+IaO2nVpq+QXk1?=
 =?us-ascii?Q?S/TnO/CJPFPNbUy11QCnq0TltuIo4Wn7ibty+URdnefAgyxIRyXHiVWOscVR?=
 =?us-ascii?Q?nxm/qSKD2bXBpgSKYspo3vk20sSjh1hDOmB7vSTC38Zl/bJD5E5pT8Iu9Xqv?=
 =?us-ascii?Q?Q9lVt/lqhveitkdOXPChFKvmF/kzeyejwiLtbS1n54drfIhM5NSb6NDc91mi?=
 =?us-ascii?Q?OSnx1iz6txol0Nyq3yqwqKQ7FVqk5ifuW/Hgd3pidDAF94PcVYcMzX/XnDn+?=
 =?us-ascii?Q?9AIGm73jVbSp99F+/UauKRvlYJZomZfa9KqAZXAM35LCaCEPhiRHsqNQ4j7N?=
 =?us-ascii?Q?q7qTexnabr4WhXislDEotUhz7zZ3ycxRUA3B/LM2sv/f3jgJa8T/jJWoBpoj?=
 =?us-ascii?Q?izPqDYDT/rkV16rFhdgkVFir+L7veD3pGaQJjChopIdmT9p8a+EB2el/YAz9?=
 =?us-ascii?Q?Lvl+uru3A/2vubcACwlQM1dpLGdzgaEd5rcejyg4Yvi7vwdgd705R1qDwYwt?=
 =?us-ascii?Q?29xQ1SAVh7epUjhXzBcMNJaLVR4t6lGo5JNIlCRGUddWaooKJGLC79Extq30?=
 =?us-ascii?Q?gIWjZMDVnYfmsCtMj+lqiHbtQ0C+0mmIh4FkGTyFcsZW1a6bUYhmMw1lvI8I?=
 =?us-ascii?Q?a1KMv2YmkQ0z39Fp8n77M0Rn++VYFDV1cNzm6qtTchVspJ1qf+Vo+hXoTCA7?=
 =?us-ascii?Q?g6pnyZeIb7KI3Sooj4E6Lx3rhcnrz/1o4aGSTEM4py9LPzkTKtsYF5e+X4p7?=
 =?us-ascii?Q?E2W2yWzkFW3S4ubBYDhf+XoU1jf4MumU66atXrAsZCizdDYmnbc4PNT3pEfz?=
 =?us-ascii?Q?OrBlT0YiyBt7HRdhc+J7GD7LQjBRkdMUe/WOmLwvZEY8KFUT0pnC/9ee5wMN?=
 =?us-ascii?Q?NDNohAcUrr1h4WZf0Xjj5OuB3+/MIvVBg0YUW4wBvNOTVBmS7PpxrOAMX0P6?=
 =?us-ascii?Q?m2SUGWdLdNpV3ZWZd2TPsJ2Q4z+G0+1b9R3whvGL6f0qVXhT5LNJD7qsWPRu?=
 =?us-ascii?Q?oU+jfjd/qIPCdb0xeFc91utv5IxklG+wC3qMmtoK05Q5qzoKk05XQSutQVys?=
 =?us-ascii?Q?Z0d1PeK4RP8ZVk+XjjoGhA7nO21Ip/fcEiNfcjFbVsK7LDPD+MzZaPSBQVsv?=
 =?us-ascii?Q?cNmsO5rvvyHoerEDy7KspZGZr3UtE7J5zjDY/rcjddllcKW/se2WkYAsdD8S?=
 =?us-ascii?Q?IBcjqvYCPfsjqT5zM5Zj76Avscl0lkFVpeJT?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(1800799024)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?/4YXE5YUPnuiWGUJfnxcRCkZnq6wYUUTzfONvUTZ8u/OYs1aq6SMjjgVph7S?=
 =?us-ascii?Q?+5HK3HWiqoLUKc75P5X+U6vzStLcWRVHufOBZFKvhE8xMfG7O8k/93Nmjlbj?=
 =?us-ascii?Q?zwmQxWixt6jvZbOxWS0f3Fhpk3459EJivRoqgt+U+nNnRiPGAQxG4LSVc7I+?=
 =?us-ascii?Q?LjYeTXr5cjK/sfb3FzH22ana0maZ9FGHMSXY+uR9iYE+pSyTVUmKEOh4tqGG?=
 =?us-ascii?Q?iMMZOEr01oO9WlOTmCfRaQcUFtbPf+daYokwCsTOYrRYlKmX06Fr+GjT9vaA?=
 =?us-ascii?Q?5aDjK72w2mUrWYiVz2trTRklX58Sn1cBxg/8VMRnjqLw9qcVrMRqChcarwGc?=
 =?us-ascii?Q?VyCiOmMbQnZz3oqGHyi3jgK5r7bjkfgx5byS+uZbmUltSFY7ZnSrreVM8GoN?=
 =?us-ascii?Q?OniC/okxwFdVsH1lrb784YON9Km4oyZ8v/uVVtrnLufdrnSxOGe+i2887Tyt?=
 =?us-ascii?Q?wQ5WuIzTKVfyLu4XVx++v7exNJg0TzO8FAPyZFptJ2D5X0aZ4JnXQYHtrNn7?=
 =?us-ascii?Q?LeA3xqirpMnK0g2PbQTfi+7DVKJH+GDCGyuXhTZuczPrWkEAbYGMMrIhToj8?=
 =?us-ascii?Q?WcQmc1zFrOrt3F3IM/n6DY77vgp7V9uj6NJuH6opyKPNcdbQgBoIelz7K/dG?=
 =?us-ascii?Q?MCiQn8UQCwkoAvSkq5/44Qo6PG+kSE7xYfnKJ27fKLRmTkF3epRTrSi9bLfR?=
 =?us-ascii?Q?XgNnyGd2wThlGsgZqZwNSw4xeUrWjesgcH41OtXMjS8hsdCXvbnlz9fh+Lvy?=
 =?us-ascii?Q?aQFMENP5+jXp3lNuWh5+BdYwW6vPwEBIAiOxfRZWHiZb931fOkm3t6+ZZg6M?=
 =?us-ascii?Q?n06eGC8vwDv95ZidhCBM/T5eMX191Ks14IbVPz2OP33ECJzhUZtant3G6IVk?=
 =?us-ascii?Q?+9xg8/MuFr36L45I5QsxhsQ3DI5T/ZVDD32r4dBbUxKSEtiskQNzQfrELr+K?=
 =?us-ascii?Q?DecyXazktRLAy2nImy4oJ+tobby/9EQZCrd1XnqEmbbs9rSmdOUBgsfb/cMS?=
 =?us-ascii?Q?MUOyAPvmAwBSTaaGh+VDzL5ILCI2bEbSBo3lMX8JcAcDgwtbviStM5a/fSVl?=
 =?us-ascii?Q?47Ww8X39M/OvIOhYDRpPBhjd9WeT7kWYIzU7FuI+eBnyLmgk1sqRr0mOB4Xo?=
 =?us-ascii?Q?24eMNpwoGpbYK2+b/qqIR+R97u8vQ57WEwWNPNFTqA5o98l4fxQTYjGpD31e?=
 =?us-ascii?Q?yxwuAD7h7TEr6c8a+Q9ZcW7pmL7wKkGvJfHgl9By+eMrYtJt2bAnXp1XPuCw?=
 =?us-ascii?Q?PzpIaR/WKQzjcL0gumMUHSvwt0yiwncD7XA5Ix71xnZARxa+F6kAO8Li26dT?=
 =?us-ascii?Q?nepa3z+79+yehUhspOyy0lWzYwflVN8c2Fbvv4kMgWm4uXMYi3A6Y2UkOzdN?=
 =?us-ascii?Q?h4iTHysvva8t4mIp0rqzobrEHcTJoczOCSUtH7hZ+apFXCt73EkFan3N3Oo7?=
 =?us-ascii?Q?SuQPlCqh6leQjqeVeHBoK7TMD2xGa8cSf1X2ZpbbPzuJLoNdELbKy4wa+w1n?=
 =?us-ascii?Q?DuHYpHTHNWlTUP42mHhqMD7KCjyIu9cbqXHMl6WL5vmJrg3PpYZva4J4sDuo?=
 =?us-ascii?Q?ZcT6jsq+PJNT93vO72g=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bb2448db-692e-4184-0e24-08de06242052
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2025 04:35:36.7095 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5q8abicRTXkQvBzkxIsCQ2YxOA2grHlSnYLjqK5wiNMVAuFzg8Fm05krDL1+tBoR
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8150
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

