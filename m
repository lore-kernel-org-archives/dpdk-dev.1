Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA332CCD1A5
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 06:19:29 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5E7F140395;
	Fri, 24 Oct 2025 08:19:27 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011036.outbound.protection.outlook.com [52.101.70.36])
 by mails.dpdk.org (Postfix) with ESMTP id 5D6804025F
 for <dev@dpdk.org>; Fri, 24 Oct 2025 08:19:26 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=abTPNWgVCxLB7LeW85bjh4xnmzE/ufsXbuosl7i8RmDIg5PXLy06TJlhWUqBBBlp0bAHITgcyoFpDPuPhkgmJrOzngfiWtL27qfaWNv+QUAr82GKInM9tDPzVzxmNN3kGrvg3eGStKZL1gAwivWMW7f3LvGGcBx7tlOibrmvO9MtkvKeRlv1GnduoPdl6DKxIIorLCWW+doPdrOUhOFworStGx9e7Ky4Q7XEwRv+xvY2shvmKAW6T+0Yzqm8CZJ1tFkPDB9FmsSrAkDCAUeCvgWvZSy2k/BYpb442mDvXOziQrBkCLeP7GaEEnC2VEdq1HLxdYFxBK1tNgDIA0sY7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wHeBu5tWNMzjjyRzTFVjBMLUs9CaR/YwZ5v9piuLbjo=;
 b=VvLQI6SCtRwkzI4Z8J/qncVJagXcxrJQNQ34e1W2a86jmkzNWoV3Gb1EJJOt+ikJQkeKdJ6hKQV8B9Thbao+88fNtweqZ91M0b9Ue4KRSHOTPbLzg1pMOHgcxKjzP/aQEa7cLeSgLC042v6ZruG6Ulj7kA0JZ3RybiisQfp0dNdDLLl8F1T/R5BDhq30ykzbsLLb/1dYymcLtHbSpIoG4rWRO6o/FILRCEoIhsHRSt7jZglzuAzZWrOmxGg/fzLsDoako+G90Tv6D28nqp4hDusj9zuv82080SaTTyui4z0STn8DRv16o4Y8Ima64prRJUAtPvxB8rxQBfCUWtETYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wHeBu5tWNMzjjyRzTFVjBMLUs9CaR/YwZ5v9piuLbjo=;
 b=GR2QO9FQdkAW5ObNvoCGKSzxgfs2RN3dg8rQVbuZUuQ01dV6kub7hIBKptZPK+Yw5+/sUbl4ekeTIDjBQf36VnG94iyNHC1EVmBGLC7YUbLGo7hZPYW0ydKqKjSb668kP4rA1a8599uH30mp2QClLPp0w6vvQn7PS5CaA+CG+BXDvZQYIpvd3YD2NCV6JXdre54FT49lEizwlN4sJ0OSFScm6DNKh2mvgsxtJ5tQogOJhsn4L7GgOPRSoPvbNiVuCE1j3y9+w4JCH2QpCWKzQ8fST8964eit6DDbQF2xLC45Xy0gd6qslDgSFnOPoFo+eDoRGCEK7q7FCdM4KU06WA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by DBAPR04MB7478.eurprd04.prod.outlook.com (2603:10a6:10:1b3::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 06:19:24 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 06:19:24 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>, Roy Pledge <roy.pledge@nxp.com>,
 Geoff Thorpe <geoff.thorpe@nxp.com>,
 Shreyansh Jain <shreyansh.jain@nxp.com>
Subject: [PATCH v6 1/6] bus/dpaa: fix FQ shutdown to do proper cleanup of
 frame queues
Date: Fri, 24 Oct 2025 11:49:01 +0530
Message-Id: <20251024061906.3535470-2-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251024061906.3535470-1-g.singh@nxp.com>
References: <20251017044848.3269627-1-g.singh@nxp.com>
 <20251024061906.3535470-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0052.apcprd02.prod.outlook.com
 (2603:1096:4:1f5::20) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|DBAPR04MB7478:EE_
X-MS-Office365-Filtering-Correlation-Id: eec15064-a4b2-4114-7a0d-08de12c546f7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|376014|19092799006|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hKJpGZDhuAPUpnR/JkjISSKu3nN44q9h5WVY+Ipm2G9pV7itK0jeY/NDJ0T7?=
 =?us-ascii?Q?mzDt6um7mW7XHgWwmqBmPCXtzFlaVTa228X4tMJqY2DCZ/YfheW8PmWMNeFt?=
 =?us-ascii?Q?2gqA3BosuabK0ZLkssKAD3AbVZEY5CGKJkOO/pxrmVWaKR/TUKkGrFY/Gpju?=
 =?us-ascii?Q?kudG5XuL0PEjtiLtfM+e7Yu4jFw4KIUpWY1GrgSXkDMTMPLeyGSrx9aoQsN5?=
 =?us-ascii?Q?3+o7pfcGRkrh5nA01Ndqwl3t/gcLANlMYVavNjiB9fh2Mx1HYUnqWTYFE3ak?=
 =?us-ascii?Q?jqHMSZi6mY7kH++DnfCI4oX6yHUPQSx9l0vD139YcQSVqs7NR++PtLKf7+T3?=
 =?us-ascii?Q?VPtzNMcO+Y4JGm9x1CluLhPQ+zCEtAIAPQI4GyghN4//ajPfpbsXF7mzIe+P?=
 =?us-ascii?Q?GPKkhDOmIlG0ZCk6Z/tlLmfjxIYuhnr6k3BEVyPdCAw9VOiI89MN/uMmiv3o?=
 =?us-ascii?Q?GY/SeDWsVtfgJ1gyEXwspMjEkYFzK04T3PGmn4wAVvi8xpzGP9icNJYLWP2g?=
 =?us-ascii?Q?OzFJfjwrscf6zu1Bf0BCah0s7+aDu+Do/K5pC61EZ5yP+nFf3zIWdoj46C/l?=
 =?us-ascii?Q?iBzI00mEK2N4hRGf4AXutmPVuT+QHRbpG+k5qUfzNN4VB308ArYMA+IRRd2V?=
 =?us-ascii?Q?d0Q5HNqw6pkEERipCrjbDG52PUaY5vIFbTkGB85kxgDizBCVPtKHE7pTQMHC?=
 =?us-ascii?Q?uRGZcX47sgIQD/f0HtuwET/LtfTjfzwTlbdVnrxtH+2xRRb1HjLE2mzHiz5Z?=
 =?us-ascii?Q?17F4AyFSElRiMVqzuhEKZcccbPaHHqEqFpHGxMumgXGUkc+lWrJFFboQTNAw?=
 =?us-ascii?Q?AvSGWhQ06wIO/iiE6ishh8JOCA/XWyhm4iHzI0y28WsJgQunlYPhZ2t6RtLI?=
 =?us-ascii?Q?EKHrAdedF7UVoXBAc4esP+5dOhCZaRSBLWLhH+3u+QUWyng42e9iZd1Z8a76?=
 =?us-ascii?Q?huGLyz/OBAfCa+9Rwbph0Mebu3czDnYgQrGIyCjgBntqzkBOqEGSBMg46oMx?=
 =?us-ascii?Q?/QJdt144L7TE+EohPw3Ofb1LtJGQhzhjIGx3XXybWTuvPwi18ejs/4Jlc4vE?=
 =?us-ascii?Q?/KZQg7ZeaMX9/Dj8cg66rPHLxjw0z/JjE1cyzd3M790uOXC3qkHQ41s5FsjE?=
 =?us-ascii?Q?wblKSki1Z1bxJOJptwQoVVNMurcrPb8fo4se0RoKDxCsnE4PJ6GanT/Z7XFc?=
 =?us-ascii?Q?g/vNdo9kNt5p7PZBlVncyusgiv0aZiq6rYGhxU44YlMNAP7ZTMMTfb0mTvCS?=
 =?us-ascii?Q?SsckWAkSATHF9YLzwPdhBPBmum7ivN3UHgzSJblhTREsQ/cZnB6EzmgEuK9/?=
 =?us-ascii?Q?faitpWzayfO9lzCy1uOS8/1JN333j1prd2nhJKEzCqCm5srwxPlgcdkREhmg?=
 =?us-ascii?Q?2QIztAi06ZoOoWS35Qx2SSamGCesp+1DI89IcvpmpQ4XMdh2+4bbgHbZqpLd?=
 =?us-ascii?Q?usaKjrU02ZMNsQmn3NKIFiQSZe+BrDrUPHO/tyeRyeGZ4mTCQMrP9ztMLCH2?=
 =?us-ascii?Q?1qmFvLVkEcHVpgqjNxhPNirBMGSv39m/RE9x?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(376014)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7cINnbKfmLsDGyDlydcxJdEbIslaVuZRYGHSHx3JP/bSMcTxABpKTVQcZ44Q?=
 =?us-ascii?Q?9BCuOIOsg6StEC6Uaq5VfAJE7jSlU0BDSUG5QM2o/dJwB2/1OsBOLVtXQqJ7?=
 =?us-ascii?Q?ttPiyxiGVzrr0+zl0DVGByIVGFwrTCegirpaIKV2hdCTedwCcnM3Ae/fRQNu?=
 =?us-ascii?Q?OXA+Dr9h3SfXS/NaYy8pRyjqfNkHIhr/DmFfUWbjbfZGRqaDo1TKYHD/7EqN?=
 =?us-ascii?Q?3n+IcycbdIh/++udrFDxvQ0uKaJI88QreggBSe+NKVOzLGv6GMOZEtZtWeKE?=
 =?us-ascii?Q?1dynfNPFhZDMEBLiL9O76DiTQ7IKZrWyiC3zFKgUKuW7UvKBJEtwSM55o7so?=
 =?us-ascii?Q?Hi7lJ/D95AthyygXAAxPeMI+sLa+xpMbM0D32jRfDkKvCKuGkEXlkQPXkeHO?=
 =?us-ascii?Q?D3XapoY27Mjlrez00Cp1pHubq7cflXy57EnoAQIEmxQRylKu7soEQ4NuhtUe?=
 =?us-ascii?Q?A9DWbrjRKsadoiBrN6U6B1Nxkofxo1Fh5FygJe2CKauDo6MMr3Npkmn/3WNe?=
 =?us-ascii?Q?QUnNO8XOH75Rt6jlmfb28xY9L1+88jXkzZRso5sxF7ExH/TazJNOb5SWz4sv?=
 =?us-ascii?Q?474I0vTmKqwnAbtqy8/N4ObCpFuEZaRtpMIAv9uhlovxP94wULNYdAgfBWwJ?=
 =?us-ascii?Q?gvjfHmESjgJ6dsTLJBRuqnwX+lFdqpmav4wcJFuk5uxQ4XFn501tWLTAzSm3?=
 =?us-ascii?Q?BvldYer0YFFDkNp23L5RxnFxBVHwlDNlz3PkT8p2r9SjOzWjQT1BIVVU/LB6?=
 =?us-ascii?Q?L4cWgo4I+6gbHSvqyWEBS21PpU2SqYY5YNrhS343EpGQAf7yCNoRkd6u1h5l?=
 =?us-ascii?Q?/L5PlziI+EDGG8J63Mxx3qNwMImLo+q5hQ8Ac2IO7eo/ZrNt5rnlKqIQ9nvN?=
 =?us-ascii?Q?UGL08WzQsQQiBfYj1RX24gWVhBRVDN3HixLtxOtqw+UeQOlQjExV7r6OXg+s?=
 =?us-ascii?Q?0l9R7JBmCu0schtMidhqGxBI+n92g9ttZ/tfyUmX6Uxy34c3LHrq8196c4V8?=
 =?us-ascii?Q?VwF00zySxrggC8fyoUtKXN1wfNmF73H02RfkzCnVP6OiwZjPkYYaHhMHrNlE?=
 =?us-ascii?Q?LzwK2lFIgEojlAvyBaa7tHTPYCZTl7w3PNw6h6UqL99sDW+hER2iO305amqx?=
 =?us-ascii?Q?aERUqfgsTjlwNe2uNVGSDm1zhh92q/fI2NtY70cFAVM12iOI7EZPWEIrKdYe?=
 =?us-ascii?Q?8UQgMY+1S5E/TXVNT5joEt8/ZIaDf1tLDMx1IL9ce1muPKQUgNPqyGGmn2e8?=
 =?us-ascii?Q?AcTpXfCJqSXS+V+BdxVwdDgYg4Xo8mjVcx4Zek+CDGg4Zgtewn64100XeRpl?=
 =?us-ascii?Q?OgEhLZmj2zWSKX8KFY8caFXy10/bn3zbQ6nS7TVCDaIg5yEB7C0K3Ae5Rpen?=
 =?us-ascii?Q?o75+bu/cHMIBo7pg2tKYqHEi3THMgB5LWkzPLLeW7QnKWybFvV/Eekeu3Hl7?=
 =?us-ascii?Q?OF6ktXItEAIAFy7VvaFuGKUhBKa1JKEfrbywxSxqqaopBjx0U/v2FTQumiKq?=
 =?us-ascii?Q?rJfDN2SPgK0fHmmjMaw1x9lwMCDc5SSIOhPIw/R8YGifYHeTzKqtBDlrK8v9?=
 =?us-ascii?Q?hXO8PAsvd4yo2+g/6uU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eec15064-a4b2-4114-7a0d-08de12c546f7
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 06:19:24.4860 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: I4P6Ni7q5zLVCL9yoKS85OCf3l2suzzCnWWp44mE1RNa+0fMHZVvUO57UA5f9mll
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7478
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

This helps reset the queues and prevents potential resoure
leaks or stale state issues.

Fixes: c47ff048b99a ("bus/dpaa: add QMAN driver core routines")

Signed-off-by: Gagandeep Singh <g.singh@nxp.com>
---
 drivers/bus/dpaa/base/qbman/qman.c  | 367 ++++++++++++++++++----------
 drivers/bus/dpaa/include/fsl_qman.h |   1 +
 drivers/net/dpaa/dpaa_ethdev.c      |   3 +
 3 files changed, 236 insertions(+), 135 deletions(-)

diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index 60087c55a1..7c5ccc51bc 100644
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
@@ -532,6 +533,41 @@ qman_init_portal(struct qman_portal *portal,
 	 * config, everything that follows depends on it and "config" is more
 	 * for (de)reference
 	 */
+	p->addr.ce = c->addr_virt[DPAA_PORTAL_CE];
+	p->addr.ci = c->addr_virt[DPAA_PORTAL_CI];
+	/*
+	 * If CI-stashing is used, the current defaults use a threshold of 3,
+	 * and stash with high-than-DQRR priority.
+	 */
+	if (qm_eqcr_init(p, qm_eqcr_pvb,
+			 portal->use_eqcr_ci_stashing, 1)) {
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
 	p->addr.ce = c->addr_virt[DPAA_PORTAL_CE];
 	p->addr.ci = c->addr_virt[DPAA_PORTAL_CI];
 	/*
@@ -2660,39 +2696,128 @@ int qman_delete_cgr(struct qman_cgr *cgr)
 	return ret;
 }
 
-int qman_shutdown_fq(u32 fqid)
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
+RTE_EXPORT_INTERNAL_SYMBOL(qman_shutdown_fq)
+int
+qman_shutdown_fq(u32 fqid)
 {
 	struct qman_portal *p;
-	struct qm_portal *low_p;
 	struct qm_mc_command *mcc;
 	struct qm_mc_result *mcr;
+	int orl_empty, drain = 0, ret = 0;
+	u32 res;
 	u8 state;
-	int orl_empty, fq_empty, drain = 0;
-	u32 result;
 	u32 channel, wq;
 	u16 dest_wq;
 
+	DPAA_BUS_DEBUG("In shutdown for queue = %x", fqid);
 	p = get_affine_portal();
-	low_p = &p->p;
-
 	/* Determine the state of the FQID */
-	mcc = qm_mc_start(low_p);
+	mcc = qm_mc_start(&p->p);
 	mcc->queryfq_np.fqid = cpu_to_be32(fqid);
-	qm_mc_commit(low_p, QM_MCC_VERB_QUERYFQ_NP);
-	while (!(mcr = qm_mc_result(low_p)))
-		cpu_relax();
-	DPAA_ASSERT((mcr->verb & QM_MCR_VERB_MASK) == QM_MCR_VERB_QUERYFQ_NP);
+	qm_mc_commit(&p->p, QM_MCC_VERB_QUERYFQ_NP);
+	if (!qm_mc_result_timeout(&p->p, &mcr)) {
+		DPAA_BUS_ERR("QUERYFQ_NP timeout");
+		ret = -ETIMEDOUT;
+		goto out;
+	}
 	state = mcr->queryfq_np.state & QM_MCR_NP_STATE_MASK;
-	if (state == QM_MCR_NP_STATE_OOS)
-		return 0; /* Already OOS, no need to do anymore checks */
+	if (state == QM_MCR_NP_STATE_OOS) {
+		DPAA_BUS_ERR("Already in OOS");
+		goto out; /* Already OOS, no need to do anymore checks */
+	}
 
 	/* Query which channel the FQ is using */
-	mcc = qm_mc_start(low_p);
+	mcc = qm_mc_start(&p->p);
 	mcc->queryfq.fqid = cpu_to_be32(fqid);
-	qm_mc_commit(low_p, QM_MCC_VERB_QUERYFQ);
-	while (!(mcr = qm_mc_result(low_p)))
-		cpu_relax();
-	DPAA_ASSERT((mcr->verb & QM_MCR_VERB_MASK) == QM_MCR_VERB_QUERYFQ);
+	qm_mc_commit(&p->p, QM_MCC_VERB_QUERYFQ);
+	if (!qm_mc_result_timeout(&p->p, &mcr)) {
+		DPAA_BUS_ERR("QUERYFQ timeout");
+		ret = -ETIMEDOUT;
+		goto out;
+	}
 
 	/* Need to store these since the MCR gets reused */
 	dest_wq = be16_to_cpu(mcr->queryfq.fqd.dest_wq);
@@ -2704,177 +2829,149 @@ int qman_shutdown_fq(u32 fqid)
 	case QM_MCR_NP_STATE_TRU_SCHED:
 	case QM_MCR_NP_STATE_ACTIVE:
 	case QM_MCR_NP_STATE_PARKED:
+		DPAA_BUS_DEBUG("In shutdown state is %d", state);
 		orl_empty = 0;
-		mcc = qm_mc_start(low_p);
+		mcc = qm_mc_start(&p->p);
 		mcc->alterfq.fqid = cpu_to_be32(fqid);
-		qm_mc_commit(low_p, QM_MCC_VERB_ALTER_RETIRE);
-		while (!(mcr = qm_mc_result(low_p)))
-			cpu_relax();
-		DPAA_ASSERT((mcr->verb & QM_MCR_VERB_MASK) ==
-			   QM_MCR_VERB_ALTER_RETIRE);
-		result = mcr->result; /* Make a copy as we reuse MCR below */
+		qm_mc_commit(&p->p, QM_MCC_VERB_ALTER_RETIRE);
+		if (!qm_mc_result_timeout(&p->p, &mcr)) {
+			DPAA_BUS_ERR("ALTER_RETIRE timeout");
+			ret = -ETIMEDOUT;
+			goto out;
+		}
+		res = mcr->result; /* Make a copy as we reuse MCR below */
 
-		if (result == QM_MCR_RESULT_PENDING) {
-			/* Need to wait for the FQRN in the message ring, which
+		if (res == QM_MCR_RESULT_OK)
+			drain_mr_fqrni(&p->p);
+
+		if (res == QM_MCR_RESULT_PENDING) {
+			/*
+			 * Need to wait for the FQRN in the message ring, which
 			 * will only occur once the FQ has been drained.  In
 			 * order for the FQ to drain the portal needs to be set
 			 * to dequeue from the channel the FQ is scheduled on
 			 */
-			const struct qm_mr_entry *msg;
-			const struct qm_dqrr_entry *dqrr = NULL;
 			int found_fqrn = 0;
-			__maybe_unused u16 dequeue_wq = 0;
 
 			/* Flag that we need to drain FQ */
 			drain = 1;
 
+			__maybe_unused u16 dequeue_wq = 0;
 			if (channel >= qm_channel_pool1 &&
-			    channel < (u16)(qm_channel_pool1 + 15)) {
+				channel < (u16)(qm_channel_pool1 + 15)) {
 				/* Pool channel, enable the bit in the portal */
 				dequeue_wq = (channel -
-					      qm_channel_pool1 + 1) << 4 | wq;
+						qm_channel_pool1 + 1) << 4 | wq;
 			} else if (channel < qm_channel_pool1) {
 				/* Dedicated channel */
 				dequeue_wq = wq;
 			} else {
-				pr_info("Cannot recover FQ 0x%x,"
-					" it is scheduled on channel 0x%x",
+				DPAA_BUS_ERR("Can't recover FQ 0x%x, ch: 0x%x",
 					fqid, channel);
-				return -EBUSY;
+				ret = -EBUSY;
+				goto out;
 			}
 			/* Set the sdqcr to drain this channel */
 			if (channel < qm_channel_pool1)
-				qm_dqrr_sdqcr_set(low_p,
+				qm_dqrr_sdqcr_set(&p->p,
 						  QM_SDQCR_TYPE_ACTIVE |
-					  QM_SDQCR_CHANNELS_DEDICATED);
+						  QM_SDQCR_CHANNELS_DEDICATED);
 			else
-				qm_dqrr_sdqcr_set(low_p,
+				qm_dqrr_sdqcr_set(&p->p,
 						  QM_SDQCR_TYPE_ACTIVE |
 						  QM_SDQCR_CHANNELS_POOL_CONV
 						  (channel));
-			while (!found_fqrn) {
+			do {
 				/* Keep draining DQRR while checking the MR*/
-				qm_dqrr_pvb_update(low_p);
-				dqrr = qm_dqrr_current(low_p);
-				while (dqrr) {
-					qm_dqrr_cdc_consume_1ptr(
-						low_p, dqrr, 0);
-					qm_dqrr_pvb_update(low_p);
-					qm_dqrr_next(low_p);
-					dqrr = qm_dqrr_current(low_p);
-				}
+				qm_dqrr_drain_nomatch(&p->p);
 				/* Process message ring too */
-				qm_mr_pvb_update(low_p);
-				msg = qm_mr_current(low_p);
-				while (msg) {
-					if ((msg->ern.verb &
-					     QM_MR_VERB_TYPE_MASK)
-					    == QM_MR_VERB_FQRN)
-						found_fqrn = 1;
-					qm_mr_next(low_p);
-					qm_mr_cci_consume_to_current(low_p);
-					qm_mr_pvb_update(low_p);
-					msg = qm_mr_current(low_p);
-				}
+				found_fqrn = qm_mr_drain(&p->p,
+							FQRN);
 				cpu_relax();
-			}
+			} while (!found_fqrn);
+			/* Restore SDQCR */
+			qm_dqrr_sdqcr_set(&p->p,
+					p->sdqcr);
 		}
-		if (result != QM_MCR_RESULT_OK &&
-		    result !=  QM_MCR_RESULT_PENDING) {
-			/* error */
-			pr_err("qman_retire_fq failed on FQ 0x%x,"
-			       " result=0x%x\n", fqid, result);
-			return -1;
+		if (res != QM_MCR_RESULT_OK &&
+		    res != QM_MCR_RESULT_PENDING) {
+			DPAA_BUS_ERR("retire_fq failed: FQ 0x%x, res=0x%x",
+				      fqid, res);
+			ret = -EIO;
+			goto out;
 		}
 		if (!(mcr->alterfq.fqs & QM_MCR_FQS_ORLPRESENT)) {
-			/* ORL had no entries, no need to wait until the
-			 * ERNs come in.
+			/*
+			 * ORL had no entries, no need to wait until the
+			 * ERNs come in
 			 */
 			orl_empty = 1;
 		}
-		/* Retirement succeeded, check to see if FQ needs
-		 * to be drained.
+		/*
+		 * Retirement succeeded, check to see if FQ needs
+		 * to be drained
 		 */
 		if (drain || mcr->alterfq.fqs & QM_MCR_FQS_NOTEMPTY) {
 			/* FQ is Not Empty, drain using volatile DQ commands */
-			fq_empty = 0;
 			do {
-				const struct qm_dqrr_entry *dqrr = NULL;
 				u32 vdqcr = fqid | QM_VDQCR_NUMFRAMES_SET(3);
 
-				qm_dqrr_vdqcr_set(low_p, vdqcr);
-
-				/* Wait for a dequeue to occur */
-				while (dqrr == NULL) {
-					qm_dqrr_pvb_update(low_p);
-					dqrr = qm_dqrr_current(low_p);
-					if (!dqrr)
-						cpu_relax();
-				}
-				/* Process the dequeues, making sure to
-				 * empty the ring completely.
+				qm_dqrr_vdqcr_set(&p->p, vdqcr);
+				/*
+				 * Wait for a dequeue and process the dequeues,
+				 * making sure to empty the ring completely
 				 */
-				while (dqrr) {
-					if (dqrr->fqid == fqid &&
-					    dqrr->stat & QM_DQRR_STAT_FQ_EMPTY)
-						fq_empty = 1;
-					qm_dqrr_cdc_consume_1ptr(low_p,
-								 dqrr, 0);
-					qm_dqrr_pvb_update(low_p);
-					qm_dqrr_next(low_p);
-					dqrr = qm_dqrr_current(low_p);
-				}
-			} while (fq_empty == 0);
+			} while (!qm_dqrr_drain_wait(&p->p, fqid, FQ_EMPTY));
 		}
-		qm_dqrr_sdqcr_set(low_p, 0);
-
-		/* Wait for the ORL to have been completely drained */
-		while (orl_empty == 0) {
-			const struct qm_mr_entry *msg;
-
-			qm_mr_pvb_update(low_p);
-			msg = qm_mr_current(low_p);
-			while (msg) {
-				if ((msg->ern.verb & QM_MR_VERB_TYPE_MASK) ==
-				    QM_MR_VERB_FQRL)
-					orl_empty = 1;
-				qm_mr_next(low_p);
-				qm_mr_cci_consume_to_current(low_p);
-				qm_mr_pvb_update(low_p);
-				msg = qm_mr_current(low_p);
-			}
+		while (!orl_empty) {
+			/* Wait for the ORL to have been completely drained */
+			orl_empty = qm_mr_drain(&p->p, FQRL);
 			cpu_relax();
 		}
-		mcc = qm_mc_start(low_p);
+		mcc = qm_mc_start(&p->p);
 		mcc->alterfq.fqid = cpu_to_be32(fqid);
-		qm_mc_commit(low_p, QM_MCC_VERB_ALTER_OOS);
-		while (!(mcr = qm_mc_result(low_p)))
-			cpu_relax();
-		DPAA_ASSERT((mcr->verb & QM_MCR_VERB_MASK) ==
-			   QM_MCR_VERB_ALTER_OOS);
+		qm_mc_commit(&p->p, QM_MCC_VERB_ALTER_OOS);
+		if (!qm_mc_result_timeout(&p->p, &mcr)) {
+			DPAA_BUS_ERR("OOS Timeout");
+			ret = -ETIMEDOUT;
+			goto out;
+		}
+
 		if (mcr->result != QM_MCR_RESULT_OK) {
-			pr_err(
-			"OOS after drain Failed on FQID 0x%x, result 0x%x\n",
-			       fqid, mcr->result);
-			return -1;
+			DPAA_BUS_ERR("OOS after drain fail: FQ 0x%x (0x%x)",
+				      fqid, mcr->result);
+			ret = -EIO;
+			goto out;
 		}
-		return 0;
+		break;
 
 	case QM_MCR_NP_STATE_RETIRED:
 		/* Send OOS Command */
-		mcc = qm_mc_start(low_p);
+		mcc = qm_mc_start(&p->p);
 		mcc->alterfq.fqid = cpu_to_be32(fqid);
-		qm_mc_commit(low_p, QM_MCC_VERB_ALTER_OOS);
-		while (!(mcr = qm_mc_result(low_p)))
-			cpu_relax();
-		DPAA_ASSERT((mcr->verb & QM_MCR_VERB_MASK) ==
-			   QM_MCR_VERB_ALTER_OOS);
-		if (mcr->result) {
-			pr_err("OOS Failed on FQID 0x%x\n", fqid);
-			return -1;
+		qm_mc_commit(&p->p, QM_MCC_VERB_ALTER_OOS);
+		if (!qm_mc_result_timeout(&p->p, &mcr)) {
+			DPAA_BUS_ERR("In RTEIRED to OOS timeout");
+			ret = -ETIMEDOUT;
+			goto out;
 		}
-		return 0;
 
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
 	}
-	return -1;
+
+out:
+	return ret;
 }
diff --git a/drivers/bus/dpaa/include/fsl_qman.h b/drivers/bus/dpaa/include/fsl_qman.h
index 71d5b16878..9bc4fc26b7 100644
--- a/drivers/bus/dpaa/include/fsl_qman.h
+++ b/drivers/bus/dpaa/include/fsl_qman.h
@@ -1894,6 +1894,7 @@ static inline void qman_release_fqid(u32 fqid)
 
 void qman_seed_fqid_range(u32 fqid, unsigned int count);
 
+__rte_internal
 int qman_shutdown_fq(u32 fqid);
 
 /**
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

