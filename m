Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CC9BCCD199
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 04:49:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0296842D35;
	Fri, 17 Oct 2025 06:49:13 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013018.outbound.protection.outlook.com [52.101.72.18])
 by mails.dpdk.org (Postfix) with ESMTP id C06E4427B9
 for <dev@dpdk.org>; Fri, 17 Oct 2025 06:49:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aqCLC8zGMzcp+8uxZppPZjR29reNxCpEZSPMF/BxBQspJDqRnTycucWWxjcnDjfA57+yC1CXmAWptnQcDiDJHdc+CrkcFvsU8A15nHAz2zt11Q1sZXxw/QgUFuBafFKRoxbmy3c5q58kZm8yl3a2qqEma3xJiX5dO/TZPOTLcw/bH1XukDJoJvw+szenPb65tQGUw8OfKBq1KWCZZKwLs+7mFk9FbH0Dp2/pcQmfy/nqvYysZuQhchaaVT9Kv9pYS1+ikDf40n+aaOAwExSm8sX7Jz5gGfqPiM0Quxvdxyn7jOv/FtkzB401eqK/wv6ioNP57HKR5rWJ64Ofjbu50A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oYvQnSQI3VKXeMJkPowqtV84IRNJ6RyrNEI4pN3ayPU=;
 b=RadXVjCCEJKeITeamXi8orlqeHYni/hIP2xMTXboJl0Xg8AmreV/vT8HmqCHfPS/oBh7V1+/AJ+ASNiIiM4HT8tKLgSfp7wokRI33CKkzNrFTetmprX6sqNrVR0WDajYv3cvrJXsC8QpAsVD9Leq6y4w2O63luzhNI//cEXhowEjGjFDv/35FR9dkMHw37Hx+bypQTHBFWYlUGgMno+K94FDh2l3Wb+/xJerHXqC5m6/DAwgryrBSsQTkZKeUzRGkrjjT0pTC4ufCi39VUVe5t/tF5cecbMAoBDEyK30bKT6FDmN5uny0mSs7IhPVmBGO/+z87CrnPylUhtJgaDROQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oYvQnSQI3VKXeMJkPowqtV84IRNJ6RyrNEI4pN3ayPU=;
 b=JP9la+f0V9TDZ9e4JmF/iS12oy+k/bsrX4sm13HVQSxSo3FCgX8Z75d9BDcOrEA0UIPg/OIs/REyAauebFrCtbrhaUXNCsuh9rH+/hNra5X3/zozwS0Qr5ASpLPhZMoNSEgmdQmY/xQXWPCFur0oNFBO7xWPtIoDhD+hFAwOTCsRNpb+O/7rnyGC3sOO3AqIOdKrTTpGSsDPJglCzP6lW7HLoX11PMVvBTRl9Z4p3EEE3IcRID7rBcgUcMRcn3ivLJS62242bD67+qeFFe5JBofMoRYDCKMsBkSTcZjnTDJASW5LdTbETqE1G7rujVjbomtTLvoYHvhNNkaTBJAhPw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 04:49:09 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 04:49:09 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v5 3/6] net/dpaa: Support IEEE1588 by timesync API
Date: Fri, 17 Oct 2025 10:18:45 +0530
Message-Id: <20251017044848.3269627-4-g.singh@nxp.com>
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
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|PAXPR04MB8254:EE_
X-MS-Office365-Filtering-Correlation-Id: 8aca1a44-8c1e-4fe0-9746-08de0d3882b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ib3AIrdck+lfpvDvzsCNSk5KMZHoqYL4yim4Ogae5iHM4ejmjkaeXw+rJiCQ?=
 =?us-ascii?Q?xojCtfsmCWhnq1EfKHNOBrHOK5NQNn/vIpYc1RKy5+gQK9oFM2/p5xZrcmli?=
 =?us-ascii?Q?LasdBdpcMBcfy+SC2JI6fmOhegqoS3dMxuu1zbwrIGeUDLgFeoylwYn8Nyw9?=
 =?us-ascii?Q?KJUbnosgBgEq06xU+IH0BrmgbUdkF8SzFLFvwETdO0R9+xZ3QlXBXKfku9o+?=
 =?us-ascii?Q?GWrvqCSm4Oq/DLcUErsIjB31P4a8viuvZTAqfBlHW9QgOp6uO7Zs+TrO40+b?=
 =?us-ascii?Q?GveDPh2GQ+MgLdqbrTYYhYFF8BiOBFBX7ZExD/F8zZ5lhQhEEX6w6xHM9Z1i?=
 =?us-ascii?Q?+RbuApHZH11Fx4wbVCvwCMNnWLQQXx5He/7S0IL1xnFflsOrR1oqfYNQLyQH?=
 =?us-ascii?Q?g+yXpH7rkWsoeZ80UxpANsshFRM8y4/fwrY73t3ZBhkTHGDrDDtED8zoJNM5?=
 =?us-ascii?Q?4zaiGm2I8ndXtj1n/+YK/UGjPHhH29WlmTarXRWA5DaRjOi9uFG9P3i22eu0?=
 =?us-ascii?Q?RN0KNJ8tML0juFElHtYedTpWgiC98YQZeP3eEFPwVzASAMihPmoUGUeWm83C?=
 =?us-ascii?Q?QmOmmhtfZ6wq9cpUFF5pqABsXlOAXumdP6CjdtQYXiS/t881fXBpbNV4+B3N?=
 =?us-ascii?Q?fcGH/CiTQnLDuXoDis2/vUU4IL1egon52HmSBNG6IvHhV4+fIt8HZOHqKPVM?=
 =?us-ascii?Q?d2cqIPL6gqSMmMYXCKiI4vTMlp3q8de7HYvhOpnhiQBaMr1tmsj42zyx4dgs?=
 =?us-ascii?Q?gWMTSPmmUpWJ80oWsKe7LQ4ADMFN3jNgZoJygjHAudHQ1a75VuKCv0fJuLpa?=
 =?us-ascii?Q?8TKjKAmmVIKsJvlc6ETwhjf0nxusDU0UHnjD50ZEYh1dvMLZCVfvRYTxGvS+?=
 =?us-ascii?Q?jCqYu2USjaSihQits99otG8lt5YCC5iRqIZFcVkUQHJR7BIdzSaglS8TKiDj?=
 =?us-ascii?Q?EmsD6rmeS4QbLjO0xeGbR8IGD7sU3nX3bswFp50IngwKgy+TdCepf7Ea1qdU?=
 =?us-ascii?Q?DVxS6oxvCCh73leOzFV8Eikxhv2yLjCg0blNexwglLIDnN7BUAaRZiBJIoel?=
 =?us-ascii?Q?xkMbb9VjokR6xRWp0jXz4lM8OUboXHCoibpi9tNckl8ykR6z9Zt7EMoMHZOz?=
 =?us-ascii?Q?QEtHB7Dj637pR8snzDHBKt0UMObvngpi6gCxkR2CrJ/m1lVK3RRshf3wPsoJ?=
 =?us-ascii?Q?xJJKjKq/yICse+SwOEKaZoAC/BNL+nW0E4fld6kmJzsxPWycbl9+SNcvF1h2?=
 =?us-ascii?Q?G8A0TuHVKqJ9GE9PNQMR8Nmx0A+GVKmv0kpWKm0vVs6bDSuTuUI/7h9MNsan?=
 =?us-ascii?Q?3dYJN/NMlyOH4u8eJvdnSLdfL7qiLLMvdEjSeAT3XP9dxFfzxX5XsutH1+Wa?=
 =?us-ascii?Q?CFIFNiMvQEM1A+pinP0eIY2PsJOh5aBZAuH36jMSgM52OkQXnojKHaRC+TEu?=
 =?us-ascii?Q?lnjDfX1TugOF6zHSurw8TC+uZALEvZp9PzsFbt8gstCHGOl8t0M5n5XsVDhB?=
 =?us-ascii?Q?WMqqny2CZ4fxURibfPcIU0ttb4kvFK9vfuIS?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7cSWhcYgjEWNi2M4adI4kAq9Aa5GKoRklXu+togIgnyXe3hw0kjG8Za3Xcko?=
 =?us-ascii?Q?MUMTvUhj39V1grp9Rdg39Bt1/+jj9mP5jp7iE70h0l0RUiilg5NSNJ2hL7Sh?=
 =?us-ascii?Q?ZpJP1CJ6RiLi5ZIzy8aa1daATZOPEQ22c+tWne9CNQmvT10vzwhW3bHlLOo4?=
 =?us-ascii?Q?JahIgObL2uhHd4rnsi9Cox7ufEaYOjYK0GX3OBaOY8ltiB8fT0t42x0nPJUD?=
 =?us-ascii?Q?3/Hq4xNxeSddEmbDgqTcc/h3jli6k+Cm9j/lG3KoQIF5nU8Xdt2MpMNcBmuU?=
 =?us-ascii?Q?DruE8bMP5SK1gXJktPMfv/bWWIGwkxXOv/c43BJk7fmwMt8EiBK9gqTv16Km?=
 =?us-ascii?Q?fp4s3Ug9Ds7liHtd1JIHRv8wkxOk6Bhr+8EFgbzAa2RZTLF30QZkfnlEl/EH?=
 =?us-ascii?Q?9Fws+LFblTUXIvA3ZTrJMJeEqJv3NtbzXbfTdVSvFeQKo+llxkGpuJy3CfEv?=
 =?us-ascii?Q?z2o+FcdxlHLmTmWqsM3F2wVaon/FyEz4IsXnDEV1wvWEkIO/5DS4BYbs/tTE?=
 =?us-ascii?Q?x2TTF+Tw7A6UpsjOU5m7qo1h8pPUXNm9ML60FYcd86IrqqRurQyjZ/7BqQaY?=
 =?us-ascii?Q?CG/lQeP1ICqAlYB1BrBrwdCBnb8DoP+vz/MQZX49OJ9uoi7MxKzg5BRUtZbN?=
 =?us-ascii?Q?AndOwrvbIURow0a5Sah9iZbn8isawEj4MWqTmc2qD98iFwruM1OOKZb9aKcl?=
 =?us-ascii?Q?k1yqdT3Hl74FRCb9kL9HCfAVtOZ69tgFRmiT56yHcJNyvu5X5BkmcIu7kXl/?=
 =?us-ascii?Q?woNXXcLR5wlU04z+fnnC5Jx3iLzygn+mfm4aoPqfRi6oiZBg7pGA+j9g9xFh?=
 =?us-ascii?Q?E6Kc0AvJzwBvnQVB/Xg5vS3g7hpgkOzRn0VyuAr9x0GmWR4IOXb14vdZQDnM?=
 =?us-ascii?Q?VyrFUy08E4BU6tBYE9mj6AsPyIEYRygFxkZInJTr1iE+2F3aZHUohcabX9lH?=
 =?us-ascii?Q?RSPNg5qBfR7prFxdVzl8f2bufmnVIvvpmZVPIJqbEkDLFMw/McebuP4BgBg8?=
 =?us-ascii?Q?LiSy1U/oADej6W4j1828Nt7xFyRYsvLiI4Z1Q88FNFI+7uO2zPMxaiwGEEWl?=
 =?us-ascii?Q?BBcGsGs9C/w5Co5a1sQi1HrgzrG/bd84zCvhcj1MEavgCFL7NvAVbuXb9CjV?=
 =?us-ascii?Q?DoewVZcjT5rXZm8BoOkhBNXOnzotbOmVeSU39Mx15BDH5Lom33kEqxR12g9a?=
 =?us-ascii?Q?7jZEVq1gMXeHz6u2lKHcUoq6/f7m6o9MlXaFXVmEzkLZTbJeNc2kDhVeJbWN?=
 =?us-ascii?Q?fwf+8f45lRGQbf3gxrMcE2QU1PqELGS1fm5QnmoDFOzMmTri7nXYm1fXcrat?=
 =?us-ascii?Q?T6jKoU99PN30kZD2ZZc+XdF6aiuZbgLyh2pFFdwQsNO1AXpI7VYu78O9Vr5D?=
 =?us-ascii?Q?owX0OfmxoQF5JRlp2JRc3W/dIDcD2/fpzb/rvXrs+8cLzT4uWtoGH1mdMjEp?=
 =?us-ascii?Q?EBBF///HcLAJ1pZQ8or67Ru9JPKHC4ZL/3IinM/hOS5qEUcA+yumpXtper4/?=
 =?us-ascii?Q?h7pMJzgNKvcbJUsxnLgkQiVWgnnhiKxYVF79BSm5MMCKdrRWFy5teuZ5qq/t?=
 =?us-ascii?Q?iJEdmXCjTAwDX+BU/i2GOhX7+r9UD3sc8SqBtIPK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8aca1a44-8c1e-4fe0-9746-08de0d3882b2
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 04:49:09.7392 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: qvGVN3YRssjRpNK5I7UuvzcGxet27N159Os5sU1P4tgSr0GhPARkGiBze+nD63up
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8254
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

Enable IEEE1588 by timesync API instead of devargs.
DPAA1 HW parser has no capability to identify ptp packets
from ingress traffic, remove ptp identification code from
driver RX callback which impacts performance significantly.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 doc/guides/nics/dpaa.rst            |  3 -
 drivers/bus/dpaa/base/qbman/qman.c  | 18 +++---
 drivers/bus/dpaa/include/fsl_qman.h |  5 +-
 drivers/common/dpaax/dpaax_ptp.h    | 95 +++++++++++++++++++++++++++++
 drivers/net/dpaa/dpaa_ethdev.c      | 15 ++---
 drivers/net/dpaa/dpaa_ethdev.h      | 13 ++--
 drivers/net/dpaa/dpaa_ptp.c         | 50 ++++++++++++---
 drivers/net/dpaa/dpaa_rxtx.c        | 93 +++++++++++++---------------
 drivers/net/dpaa/dpaa_rxtx.h        |  2 +-
 9 files changed, 204 insertions(+), 90 deletions(-)
 create mode 100644 drivers/common/dpaax/dpaax_ptp.h

diff --git a/doc/guides/nics/dpaa.rst b/doc/guides/nics/dpaa.rst
index 8cd57b21f3..8ffe31ce32 100644
--- a/doc/guides/nics/dpaa.rst
+++ b/doc/guides/nics/dpaa.rst
@@ -275,9 +275,6 @@ for details.
       Done
       testpmd>
 
-* Use dev arg option ``drv_ieee1588=1`` to enable IEEE 1588 support
-  at driver level, e.g. ``dpaa:fm1-mac3,drv_ieee1588=1``.
-
 * Use dev arg option ``recv_err_pkts=1`` to receive all packets including error packets
   and thus disabling hardware based packet handling at driver level,
   e.g. ``dpaa:fm1-mac3,recv_err_pkts=1``.
diff --git a/drivers/bus/dpaa/base/qbman/qman.c b/drivers/bus/dpaa/base/qbman/qman.c
index d6b2a58eaa..76a1d93032 100644
--- a/drivers/bus/dpaa/base/qbman/qman.c
+++ b/drivers/bus/dpaa/base/qbman/qman.c
@@ -1232,14 +1232,14 @@ u16 qman_affine_channel(int cpu)
 	return affine_channels[cpu];
 }
 
-unsigned int qman_portal_poll_rx(unsigned int poll_limit,
-				 void **bufs,
-				 struct qman_portal *p)
+uint32_t
+qman_portal_poll_rx(uint32_t poll_limit, void **bufs,
+	struct qman_portal *p, struct qman_fq_cb *cb)
 {
 	struct qm_portal *portal = &p->p;
 	register struct qm_dqrr *dqrr = &portal->dqrr;
 	struct qm_dqrr_entry *dq[QM_DQRR_SIZE], *shadow[QM_DQRR_SIZE];
-	struct qman_fq *fq;
+	struct qman_fq *fq[QM_DQRR_SIZE];
 	unsigned int limit = 0, rx_number = 0;
 	uint32_t consume = 0;
 
@@ -1273,12 +1273,12 @@ unsigned int qman_portal_poll_rx(unsigned int poll_limit,
 
 		/* SDQCR: context_b points to the FQ */
 #ifdef CONFIG_FSL_QMAN_FQ_LOOKUP
-		fq = qman_fq_lookup_table[dq[rx_number]->contextB];
+		fq[rx_number] = qman_fq_lookup_table[dq[rx_number]->contextB];
 #else
-		fq = (void *)dq[rx_number]->contextB;
+		fq[rx_number] = (void *)dq[rx_number]->contextB;
 #endif
-		if (fq->cb.dqrr_prepare)
-			fq->cb.dqrr_prepare(shadow[rx_number],
+		if (fq[rx_number]->cb.dqrr_prepare)
+			fq[rx_number]->cb.dqrr_prepare(shadow[rx_number],
 					    &bufs[rx_number]);
 
 		consume |= (1 << (31 - DQRR_PTR2IDX(shadow[rx_number])));
@@ -1287,7 +1287,7 @@ unsigned int qman_portal_poll_rx(unsigned int poll_limit,
 	} while (++limit < poll_limit);
 
 	if (rx_number)
-		fq->cb.dqrr_dpdk_pull_cb(&fq, shadow, bufs, rx_number);
+		cb->dqrr_dpdk_pull_cb(fq, shadow, bufs, rx_number);
 
 	/* Consume all the DQRR enries together */
 	qm_out(DQRR_DCAP, (1 << 8) | consume);
diff --git a/drivers/bus/dpaa/include/fsl_qman.h b/drivers/bus/dpaa/include/fsl_qman.h
index 9bc4fc26b7..0494ad709d 100644
--- a/drivers/bus/dpaa/include/fsl_qman.h
+++ b/drivers/bus/dpaa/include/fsl_qman.h
@@ -1393,8 +1393,9 @@ int qman_fq_portal_irqsource_remove(struct qman_portal *p, u32 bits);
 u16 qman_affine_channel(int cpu);
 
 __rte_internal
-unsigned int qman_portal_poll_rx(unsigned int poll_limit,
-				 void **bufs, struct qman_portal *q);
+uint32_t
+qman_portal_poll_rx(uint32_t poll_limit, void **bufs,
+	struct qman_portal *p, struct qman_fq_cb *cb);
 
 /**
  * qman_set_vdq - Issue a volatile dequeue command
diff --git a/drivers/common/dpaax/dpaax_ptp.h b/drivers/common/dpaax/dpaax_ptp.h
new file mode 100644
index 0000000000..b73c16c986
--- /dev/null
+++ b/drivers/common/dpaax/dpaax_ptp.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: BSD-3-Clause
+ * Copyright 2025 NXP
+ */
+
+#ifndef _DPAAX_PTP_H_
+#define _DPAAX_PTP_H_
+#include <stdlib.h>
+#include <rte_ether.h>
+#include <rte_ip.h>
+#include <rte_udp.h>
+
+#define UDP_PTP_EVENT_DST_PORT 319
+#define UDP_PTP_GENERAL_DST_PORT 320
+
+struct __rte_packed_begin rte_dpaax_ptp_header {
+	uint8_t tsmt;  /* transportSpecific | messageType */
+	uint8_t ver;   /* reserved          | versionPTP  */
+	rte_be16_t msg_len;
+	uint8_t domain_number;
+	uint8_t rsv;
+	uint8_t flags[2];
+	rte_be64_t correction;
+	uint8_t unused[];
+} __rte_packed_end;
+
+static inline struct rte_dpaax_ptp_header *
+dpaax_timesync_ptp_parse_header(struct rte_mbuf *buf,
+	uint16_t *ts_offset, int *is_udp)
+{
+	struct rte_ether_hdr *eth = rte_pktmbuf_mtod(buf, void *);
+	void *next_hdr;
+	rte_be16_t ether_type;
+	struct rte_vlan_hdr *vlan;
+	struct rte_ipv4_hdr *ipv4;
+	struct rte_ipv6_hdr *ipv6;
+	struct rte_udp_hdr *udp;
+	struct rte_dpaax_ptp_header *ptp = NULL;
+	uint16_t offset = offsetof(struct rte_dpaax_ptp_header, correction);
+
+	if (is_udp)
+		*is_udp = false;
+
+	offset += sizeof(struct rte_ether_hdr);
+	if (eth->ether_type == htons(RTE_ETHER_TYPE_1588)) {
+		ptp = (void *)(eth + 1);
+		goto quit;
+	}
+
+	if (eth->ether_type == htons(RTE_ETHER_TYPE_VLAN)) {
+		vlan = (void *)(eth + 1);
+		ether_type = vlan->eth_proto;
+		next_hdr = (void *)(vlan + 1);
+		offset += sizeof(struct rte_vlan_hdr);
+		if (ether_type == htons(RTE_ETHER_TYPE_1588)) {
+			ptp = next_hdr;
+			goto quit;
+		}
+	} else {
+		ether_type = eth->ether_type;
+		next_hdr = (void *)(eth + 1);
+	}
+
+	if (ether_type == htons(RTE_ETHER_TYPE_IPV4)) {
+		ipv4 = next_hdr;
+		offset += sizeof(struct rte_ipv4_hdr);
+		if (ipv4->next_proto_id != IPPROTO_UDP)
+			return NULL;
+		udp = (void *)(ipv4 + 1);
+		goto parse_udp;
+	} else if (ether_type == htons(RTE_ETHER_TYPE_IPV6)) {
+		ipv6 = next_hdr;
+		offset += sizeof(struct rte_ipv6_hdr);
+		if (ipv6->proto != IPPROTO_UDP)
+			return NULL;
+		udp = (void *)(ipv6 + 1);
+		goto parse_udp;
+	} else {
+		return NULL;
+	}
+parse_udp:
+	offset += sizeof(struct rte_udp_hdr);
+	if (udp->dst_port != UDP_PTP_EVENT_DST_PORT &&
+		udp->dst_port != UDP_PTP_GENERAL_DST_PORT)
+		return NULL;
+	ptp = (void *)(udp + 1);
+	if (is_udp)
+		*is_udp = true;
+quit:
+	if (ts_offset)
+		*ts_offset = offset;
+
+	return ptp;
+}
+
+#endif /* _DPAAX_PTP_H_ */
diff --git a/drivers/net/dpaa/dpaa_ethdev.c b/drivers/net/dpaa/dpaa_ethdev.c
index 30a0c97a8b..43aab98339 100644
--- a/drivers/net/dpaa/dpaa_ethdev.c
+++ b/drivers/net/dpaa/dpaa_ethdev.c
@@ -52,7 +52,6 @@
 #include <process.h>
 #include <fmlib/fm_ext.h>
 
-#define DRIVER_IEEE1588         "drv_ieee1588"
 #define CHECK_INTERVAL          100  /* 100ms */
 #define MAX_REPEAT_TIME         90   /* 9s (90 * 100ms) in total */
 #define DRIVER_RECV_ERR_PKTS      "recv_err_pkts"
@@ -88,7 +87,6 @@ static uint64_t dev_tx_offloads_nodis =
 static int is_global_init;
 static int fmc_q = 1;	/* Indicates the use of static fmc for distribution */
 static int default_q;	/* use default queue - FMC is not executed*/
-int dpaa_ieee_1588;	/* use to indicate if IEEE 1588 is enabled for the driver */
 bool dpaa_enable_recv_err_pkts; /* Enable main queue to receive error packets */
 
 /* At present we only allow up to 4 push mode queues as default - as each of
@@ -1998,6 +1996,7 @@ static int dpaa_tx_queue_init(struct qman_fq *fq,
 		}
 	};
 	int ret;
+	struct dpaa_if *dpaa_intf = fq->dpaa_intf;
 
 	ret = qman_create_fq(0, QMAN_FQ_FLAG_DYNAMIC_FQID |
 			     QMAN_FQ_FLAG_TO_DCPORTAL, fq);
@@ -2011,7 +2010,7 @@ static int dpaa_tx_queue_init(struct qman_fq *fq,
 	opts.fqd.dest.wq = DPAA_IF_TX_PRIORITY;
 	opts.fqd.fq_ctrl = QM_FQCTRL_PREFERINCACHE;
 	opts.fqd.context_b = 0;
-	if (dpaa_ieee_1588) {
+	if (dpaa_intf->ts_enable) {
 		opts.fqd.context_a.lo = 0;
 		opts.fqd.context_a.hi =
 			fman_intf->fman->dealloc_bufs_mask_hi;
@@ -2063,7 +2062,7 @@ static int dpaa_tx_queue_init(struct qman_fq *fq,
 	return ret;
 }
 
-static int
+int
 dpaa_tx_conf_queue_init(struct qman_fq *fq)
 {
 	struct qm_mcc_initfq opts = {0};
@@ -2261,9 +2260,6 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 	dpaa_intf->ifid = dev_id;
 	dpaa_intf->cfg = cfg;
 
-	if (dpaa_get_devargs(dev->devargs, DRIVER_IEEE1588))
-		dpaa_ieee_1588 = 1;
-
 	if (dpaa_get_devargs(dev->devargs, DRIVER_RECV_ERR_PKTS))
 		dpaa_enable_recv_err_pkts = 1;
 
@@ -2432,14 +2428,14 @@ dpaa_dev_init(struct rte_eth_dev *eth_dev)
 		if (dpaa_intf->cgr_tx)
 			dpaa_intf->cgr_tx[loop].cgrid = cgrid_tx[loop];
 
+		dpaa_intf->tx_queues[loop].dpaa_intf = dpaa_intf;
 		ret = dpaa_tx_queue_init(&dpaa_intf->tx_queues[loop],
 			fman_intf,
 			dpaa_intf->cgr_tx ? &dpaa_intf->cgr_tx[loop] : NULL);
 		if (ret)
 			goto free_tx;
-		dpaa_intf->tx_queues[loop].dpaa_intf = dpaa_intf;
 
-		if (dpaa_ieee_1588) {
+		if (dpaa_intf->ts_enable) {
 			ret = dpaa_tx_conf_queue_init(&dpaa_intf->tx_conf_queues[loop]);
 			if (ret)
 				goto free_tx;
@@ -2731,6 +2727,5 @@ static struct rte_dpaa_driver rte_dpaa_pmd = {
 
 RTE_PMD_REGISTER_DPAA(net_dpaa, rte_dpaa_pmd);
 RTE_PMD_REGISTER_PARAM_STRING(net_dpaa,
-		DRIVER_IEEE1588 "=<int>"
 		DRIVER_RECV_ERR_PKTS "=<int>");
 RTE_LOG_REGISTER_DEFAULT(dpaa_logtype_pmd, NOTICE);
diff --git a/drivers/net/dpaa/dpaa_ethdev.h b/drivers/net/dpaa/dpaa_ethdev.h
index be9398004f..f400030a5c 100644
--- a/drivers/net/dpaa/dpaa_ethdev.h
+++ b/drivers/net/dpaa/dpaa_ethdev.h
@@ -119,7 +119,6 @@ enum {
 #define FMC_FILE "/tmp/fmc.bin"
 
 extern struct rte_mempool *dpaa_tx_sg_pool;
-extern int dpaa_ieee_1588;
 
 /* PMD related logs */
 extern int dpaa_logtype_pmd;
@@ -154,10 +153,12 @@ struct dpaa_if {
 	void *netenv_handle;
 	void *scheme_handle[2];
 	uint32_t scheme_count;
+	int ts_enable;
 	/*stores timestamp of last received packet on dev*/
 	uint64_t rx_timestamp;
 	/*stores timestamp of last received tx confirmation packet on dev*/
 	uint64_t tx_timestamp;
+	uint64_t tx_old_timestamp;
 	/* stores pointer to next tx_conf queue that should be processed,
 	 * it corresponds to last packet transmitted
 	 */
@@ -244,6 +245,9 @@ struct dpaa_if_rx_bmi_stats {
 	uint32_t fmbm_rbdc;		/**< Rx Buffers Deallocate Counter*/
 };
 
+int
+dpaa_tx_conf_queue_init(struct qman_fq *fq);
+
 int
 dpaa_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
 		struct timespec *timestamp);
@@ -256,18 +260,17 @@ dpaa_timesync_disable(struct rte_eth_dev *dev);
 
 int
 dpaa_timesync_read_time(struct rte_eth_dev *dev,
-		struct timespec *timestamp);
+	struct timespec *timestamp);
 
 int
 dpaa_timesync_write_time(struct rte_eth_dev *dev,
-		const struct timespec *timestamp);
+	const struct timespec *timestamp);
 int
 dpaa_timesync_adjust_time(struct rte_eth_dev *dev, int64_t delta);
 
 int
 dpaa_timesync_read_rx_timestamp(struct rte_eth_dev *dev,
-		struct timespec *timestamp,
-		uint32_t flags __rte_unused);
+	struct timespec *timestamp, uint32_t flags __rte_unused);
 
 uint8_t
 fm_default_vsp_id(struct fman_if *fif);
diff --git a/drivers/net/dpaa/dpaa_ptp.c b/drivers/net/dpaa/dpaa_ptp.c
index 8482666745..e9b332c571 100644
--- a/drivers/net/dpaa/dpaa_ptp.c
+++ b/drivers/net/dpaa/dpaa_ptp.c
@@ -17,20 +17,40 @@
 #include <dpaa_rxtx.h>
 
 int
-dpaa_timesync_enable(struct rte_eth_dev *dev __rte_unused)
+dpaa_timesync_enable(struct rte_eth_dev *dev)
 {
+	struct dpaa_if *dpaa_intf = dev->data->dev_private;
+	int loop, ret = 0;
+
+	for (loop = 0; loop < MAX_DPAA_CORES; loop++) {
+		if (!dpaa_intf->tx_queues[loop].tx_conf_queue) {
+			ret = dpaa_tx_conf_queue_init(&dpaa_intf->tx_conf_queues[loop]);
+			if (ret)
+				break;
+			dpaa_intf->tx_conf_queues[loop].dpaa_intf = dpaa_intf;
+			dpaa_intf->tx_queues[loop].tx_conf_queue = &dpaa_intf->tx_conf_queues[loop];
+		}
+	}
+
+	if (ret)
+		return ret;
+
+	dpaa_intf->ts_enable = true;
 	return 0;
 }
 
 int
-dpaa_timesync_disable(struct rte_eth_dev *dev __rte_unused)
+dpaa_timesync_disable(struct rte_eth_dev *dev)
 {
+	struct dpaa_if *dpaa_intf = dev->data->dev_private;
+
+	dpaa_intf->ts_enable = false;
 	return 0;
 }
 
 int
 dpaa_timesync_read_time(struct rte_eth_dev *dev,
-					struct timespec *timestamp)
+	struct timespec *timestamp)
 {
 	uint32_t *tmr_cnt_h, *tmr_cnt_l;
 	struct fman_if *fif;
@@ -50,7 +70,7 @@ dpaa_timesync_read_time(struct rte_eth_dev *dev,
 
 int
 dpaa_timesync_write_time(struct rte_eth_dev *dev,
-					const struct timespec *ts)
+	const struct timespec *ts)
 {
 	uint32_t *tmr_cnt_h, *tmr_cnt_l;
 	struct fman_if *fif;
@@ -88,15 +108,21 @@ dpaa_timesync_adjust_time(struct rte_eth_dev *dev, int64_t delta)
 
 int
 dpaa_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
-						struct timespec *timestamp)
+	struct timespec *timestamp)
 {
 	struct dpaa_if *dpaa_intf = dev->data->dev_private;
+	int read_count = 10000;
 
-	if (dpaa_intf->next_tx_conf_queue) {
-		while (!dpaa_intf->tx_timestamp)
+	if (dpaa_intf->ts_enable && dpaa_intf->next_tx_conf_queue) {
+		while (dpaa_intf->tx_timestamp == dpaa_intf->tx_old_timestamp) {
 			dpaa_eth_tx_conf(dpaa_intf->next_tx_conf_queue);
+			if (read_count <= 0)
+				return -EAGAIN;
+			read_count--;
+		}
+		dpaa_intf->tx_old_timestamp = dpaa_intf->tx_timestamp;
 	} else {
-		return -1;
+		return -ENOTSUP;
 	}
 	*timestamp = rte_ns_to_timespec(dpaa_intf->tx_timestamp);
 
@@ -105,10 +131,14 @@ dpaa_timesync_read_tx_timestamp(struct rte_eth_dev *dev,
 
 int
 dpaa_timesync_read_rx_timestamp(struct rte_eth_dev *dev,
-						struct timespec *timestamp,
-						uint32_t flags __rte_unused)
+	struct timespec *timestamp, uint32_t flags __rte_unused)
 {
 	struct dpaa_if *dpaa_intf = dev->data->dev_private;
+
+	if (!dpaa_intf->ts_enable)
+		return -ENOTSUP;
+
 	*timestamp = rte_ns_to_timespec(dpaa_intf->rx_timestamp);
+
 	return 0;
 }
diff --git a/drivers/net/dpaa/dpaa_rxtx.c b/drivers/net/dpaa/dpaa_rxtx.c
index 4dca63ea7e..c5e393159a 100644
--- a/drivers/net/dpaa/dpaa_rxtx.c
+++ b/drivers/net/dpaa/dpaa_rxtx.c
@@ -45,6 +45,7 @@
 #include <fsl_qman.h>
 #include <fsl_bman.h>
 #include <dpaa_of.h>
+#include <dpaax_ptp.h>
 #include <netcfg.h>
 
 #ifdef RTE_LIBRTE_DPAA_DEBUG_DRIVER
@@ -234,12 +235,11 @@ dpaa_slow_parsing(struct rte_mbuf *m,
 		m->packet_type |= RTE_PTYPE_L4_SCTP;
 }
 
-static inline void dpaa_eth_packet_info(struct rte_mbuf *m, void *fd_virt_addr)
+static inline void
+dpaa_eth_packet_info(struct dpaa_if *dpaa_intf, struct rte_mbuf *m,
+	struct annotations_t *annot)
 {
-	struct annotations_t *annot = GET_ANNOTATIONS(fd_virt_addr);
 	uint64_t prs = *((uintptr_t *)(&annot->parse)) & DPAA_PARSE_MASK;
-	struct rte_ether_hdr *eth_hdr =
-		rte_pktmbuf_mtod(m, struct rte_ether_hdr *);
 
 	DPAA_DP_LOG(DEBUG, " Parsing mbuf: %p with annotations: %p", m, annot);
 
@@ -360,9 +360,11 @@ static inline void dpaa_eth_packet_info(struct rte_mbuf *m, void *fd_virt_addr)
 		m->ol_flags |= RTE_MBUF_F_RX_VLAN;
 	/* Packet received without stripping the vlan */
 
-	if (eth_hdr->ether_type == htons(RTE_ETHER_TYPE_1588)) {
-		m->ol_flags |= RTE_MBUF_F_RX_IEEE1588_PTP;
-		m->ol_flags |= RTE_MBUF_F_RX_IEEE1588_TMST;
+	if (unlikely(dpaa_intf->ts_enable)) {
+		if (dpaax_timesync_ptp_parse_header(m, NULL, NULL)) {
+			m->ol_flags |= RTE_MBUF_F_RX_IEEE1588_PTP;
+			m->ol_flags |= RTE_MBUF_F_RX_IEEE1588_TMST;
+		}
 	}
 }
 
@@ -468,7 +470,7 @@ dpaa_unsegmented_checksum(struct rte_mbuf *mbuf, struct qm_fd *fd_arr)
 }
 
 static struct rte_mbuf *
-dpaa_eth_sg_to_mbuf(const struct qm_fd *fd, uint32_t ifid)
+dpaa_eth_sg_to_mbuf(struct dpaa_if *dpaa_intf, const struct qm_fd *fd)
 {
 	struct dpaa_bp_info *bp_info = DPAA_BPID_TO_POOL_INFO(fd->bpid);
 	struct rte_mbuf *first_seg, *prev_seg, *cur_seg, *temp;
@@ -499,7 +501,7 @@ dpaa_eth_sg_to_mbuf(const struct qm_fd *fd, uint32_t ifid)
 			(void **)&first_seg, 1, 1);
 #endif
 
-	first_seg->port = ifid;
+	first_seg->port = dpaa_intf->ifid;
 	first_seg->nb_segs = 1;
 	first_seg->ol_flags = 0;
 	prev_seg = first_seg;
@@ -529,7 +531,7 @@ dpaa_eth_sg_to_mbuf(const struct qm_fd *fd, uint32_t ifid)
 	DPAA_DP_LOG(DEBUG, "Received an SG frame len =%d, num_sg =%d",
 			first_seg->pkt_len, first_seg->nb_segs);
 
-	dpaa_eth_packet_info(first_seg, vaddr);
+	dpaa_eth_packet_info(dpaa_intf, first_seg, GET_ANNOTATIONS(vaddr));
 #ifdef RTE_LIBRTE_MEMPOOL_DEBUG
 	rte_mempool_check_cookies(rte_mempool_from_obj((void *)temp),
 			(void **)&temp, 1, 1);
@@ -540,7 +542,7 @@ dpaa_eth_sg_to_mbuf(const struct qm_fd *fd, uint32_t ifid)
 }
 
 static inline struct rte_mbuf *
-dpaa_eth_fd_to_mbuf(const struct qm_fd *fd, uint32_t ifid)
+dpaa_eth_fd_to_mbuf(struct dpaa_if *dpaa_intf, const struct qm_fd *fd)
 {
 	struct rte_mbuf *mbuf;
 	struct dpaa_bp_info *bp_info = DPAA_BPID_TO_POOL_INFO(fd->bpid);
@@ -551,7 +553,7 @@ dpaa_eth_fd_to_mbuf(const struct qm_fd *fd, uint32_t ifid)
 	uint32_t length;
 
 	if (unlikely(format == qm_fd_sg))
-		return dpaa_eth_sg_to_mbuf(fd, ifid);
+		return dpaa_eth_sg_to_mbuf(dpaa_intf, fd);
 
 	offset = (fd->opaque & DPAA_FD_OFFSET_MASK) >> DPAA_FD_OFFSET_SHIFT;
 	length = fd->opaque & DPAA_FD_LENGTH_MASK;
@@ -569,7 +571,7 @@ dpaa_eth_fd_to_mbuf(const struct qm_fd *fd, uint32_t ifid)
 	mbuf->data_len = length;
 	mbuf->pkt_len = length;
 
-	mbuf->port = ifid;
+	mbuf->port = dpaa_intf->ifid;
 	mbuf->nb_segs = 1;
 	mbuf->ol_flags = 0;
 	mbuf->next = NULL;
@@ -578,7 +580,7 @@ dpaa_eth_fd_to_mbuf(const struct qm_fd *fd, uint32_t ifid)
 	rte_mempool_check_cookies(rte_mempool_from_obj((void *)mbuf),
 			(void **)&mbuf, 1, 1);
 #endif
-	dpaa_eth_packet_info(mbuf, mbuf->buf_addr);
+	dpaa_eth_packet_info(dpaa_intf, mbuf, GET_ANNOTATIONS(mbuf->buf_addr));
 
 	return mbuf;
 }
@@ -670,11 +672,11 @@ dpaa_rx_cb_no_prefetch(struct qman_fq **fq, struct qm_dqrr_entry **dqrr,
 		}
 
 		fd = &dqrr[i]->fd;
-		dpaa_intf = fq[0]->dpaa_intf;
+		dpaa_intf = fq[i]->dpaa_intf;
 		format = (fd->opaque & DPAA_FD_FORMAT_MASK) >>
 				DPAA_FD_FORMAT_SHIFT;
 		if (unlikely(format == qm_fd_sg)) {
-			bufs[i] = dpaa_eth_sg_to_mbuf(fd, dpaa_intf->ifid);
+			bufs[i] = dpaa_eth_sg_to_mbuf(dpaa_intf, fd);
 			continue;
 		}
 
@@ -696,13 +698,11 @@ dpaa_rx_cb_no_prefetch(struct qman_fq **fq, struct qm_dqrr_entry **dqrr,
 		rte_mempool_check_cookies(rte_mempool_from_obj((void *)mbuf),
 			(void **)&mbuf, 1, 1);
 #endif
-		dpaa_eth_packet_info(mbuf, mbuf->buf_addr);
-		dpaa_display_frame_info(fd, fq[0]->fqid, true);
-		if (dpaa_ieee_1588) {
-			annot = GET_ANNOTATIONS(mbuf->buf_addr);
-			dpaa_intf->rx_timestamp =
-				rte_cpu_to_be_64(annot->timestamp);
-		}
+		annot = GET_ANNOTATIONS(mbuf->buf_addr);
+		dpaa_eth_packet_info(dpaa_intf, mbuf, annot);
+		dpaa_display_frame_info(fd, fq[i]->fqid, true);
+		if (unlikely(dpaa_intf->ts_enable))
+			dpaa_intf->rx_timestamp = rte_be_to_cpu_64(annot->timestamp);
 	}
 }
 
@@ -720,11 +720,11 @@ dpaa_rx_cb(struct qman_fq **fq, struct qm_dqrr_entry **dqrr,
 
 	for (i = 0; i < num_bufs; i++) {
 		fd = &dqrr[i]->fd;
-		dpaa_intf = fq[0]->dpaa_intf;
+		dpaa_intf = fq[i]->dpaa_intf;
 		format = (fd->opaque & DPAA_FD_FORMAT_MASK) >>
 				DPAA_FD_FORMAT_SHIFT;
 		if (unlikely(format == qm_fd_sg)) {
-			bufs[i] = dpaa_eth_sg_to_mbuf(fd, dpaa_intf->ifid);
+			bufs[i] = dpaa_eth_sg_to_mbuf(dpaa_intf, fd);
 			continue;
 		}
 
@@ -746,13 +746,11 @@ dpaa_rx_cb(struct qman_fq **fq, struct qm_dqrr_entry **dqrr,
 		rte_mempool_check_cookies(rte_mempool_from_obj((void *)mbuf),
 			(void **)&mbuf, 1, 1);
 #endif
-		dpaa_eth_packet_info(mbuf, mbuf->buf_addr);
-		dpaa_display_frame_info(fd, fq[0]->fqid, true);
-		if (dpaa_ieee_1588) {
-			annot = GET_ANNOTATIONS(mbuf->buf_addr);
-			dpaa_intf->rx_timestamp =
-				rte_cpu_to_be_64(annot->timestamp);
-		}
+		annot = GET_ANNOTATIONS(mbuf->buf_addr);
+		dpaa_eth_packet_info(dpaa_intf, mbuf, annot);
+		dpaa_display_frame_info(fd, fq[i]->fqid, true);
+		if (unlikely(dpaa_intf->ts_enable))
+			dpaa_intf->rx_timestamp = rte_be_to_cpu_64(annot->timestamp);
 	}
 }
 
@@ -787,7 +785,7 @@ dpaa_eth_queue_portal_rx(struct qman_fq *fq,
 		fq->qp_initialized = 1;
 	}
 
-	return qman_portal_poll_rx(nb_bufs, (void **)bufs, fq->qp);
+	return qman_portal_poll_rx(nb_bufs, (void **)bufs, fq->qp, &fq->cb);
 }
 
 enum qman_cb_dqrr_result
@@ -797,11 +795,10 @@ dpaa_rx_cb_parallel(void *event,
 		    const struct qm_dqrr_entry *dqrr,
 		    void **bufs)
 {
-	u32 ifid = ((struct dpaa_if *)fq->dpaa_intf)->ifid;
 	struct rte_mbuf *mbuf;
 	struct rte_event *ev = (struct rte_event *)event;
 
-	mbuf = dpaa_eth_fd_to_mbuf(&dqrr->fd, ifid);
+	mbuf = dpaa_eth_fd_to_mbuf(fq->dpaa_intf, &dqrr->fd);
 	ev->event_ptr = (void *)mbuf;
 	ev->flow_id = fq->ev.flow_id;
 	ev->sub_event_type = fq->ev.sub_event_type;
@@ -825,11 +822,10 @@ dpaa_rx_cb_atomic(void *event,
 		  void **bufs)
 {
 	u8 index;
-	u32 ifid = ((struct dpaa_if *)fq->dpaa_intf)->ifid;
 	struct rte_mbuf *mbuf;
 	struct rte_event *ev = (struct rte_event *)event;
 
-	mbuf = dpaa_eth_fd_to_mbuf(&dqrr->fd, ifid);
+	mbuf = dpaa_eth_fd_to_mbuf(fq->dpaa_intf, &dqrr->fd);
 	ev->event_ptr = (void *)mbuf;
 	ev->flow_id = fq->ev.flow_id;
 	ev->sub_event_type = fq->ev.sub_event_type;
@@ -900,7 +896,7 @@ dpaa_eth_err_queue(struct qman_fq *fq)
 			dpaa_display_frame_info(fd, debug_fq->fqid,
 				i == DPAA_DEBUG_FQ_RX_ERROR);
 
-			mbuf = dpaa_eth_fd_to_mbuf(fd, dpaa_intf->ifid);
+			mbuf = dpaa_eth_fd_to_mbuf(dpaa_intf, fd);
 			rte_pktmbuf_free(mbuf);
 			qman_dqrr_consume(debug_fq, dq);
 		} while (debug_fq->flags & QMAN_FQ_STATE_VDQCR);
@@ -908,13 +904,12 @@ dpaa_eth_err_queue(struct qman_fq *fq)
 }
 #endif
 
-uint16_t dpaa_eth_queue_rx(void *q,
-			   struct rte_mbuf **bufs,
-			   uint16_t nb_bufs)
+uint16_t
+dpaa_eth_queue_rx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 {
 	struct qman_fq *fq = q;
 	struct qm_dqrr_entry *dq;
-	uint32_t num_rx = 0, ifid = ((struct dpaa_if *)fq->dpaa_intf)->ifid;
+	uint32_t num_rx = 0;
 	int num_rx_bufs, ret;
 	uint32_t vdqcr_flags = 0;
 	struct annotations_t *annot;
@@ -959,11 +954,11 @@ uint16_t dpaa_eth_queue_rx(void *q,
 		dq = qman_dequeue(fq);
 		if (!dq)
 			continue;
-		bufs[num_rx++] = dpaa_eth_fd_to_mbuf(&dq->fd, ifid);
+		bufs[num_rx++] = dpaa_eth_fd_to_mbuf(dpaa_intf, &dq->fd);
 		dpaa_display_frame_info(&dq->fd, fq->fqid, true);
-		if (dpaa_ieee_1588) {
+		if (unlikely(dpaa_intf->ts_enable)) {
 			annot = GET_ANNOTATIONS(bufs[num_rx - 1]->buf_addr);
-			dpaa_intf->rx_timestamp = rte_cpu_to_be_64(annot->timestamp);
+			dpaa_intf->rx_timestamp = rte_be_to_cpu_64(annot->timestamp);
 		}
 		qman_dqrr_consume(fq, dq);
 	} while (fq->flags & QMAN_FQ_STATE_VDQCR);
@@ -1314,10 +1309,9 @@ dpaa_eth_queue_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 
 	DPAA_DP_LOG(DEBUG, "Transmitting %d buffers on queue: %p", nb_bufs, q);
 
-	if (dpaa_ieee_1588) {
+	if (unlikely(dpaa_intf->ts_enable)) {
 		dpaa_intf->next_tx_conf_queue = fq_txconf;
 		dpaa_eth_tx_conf(fq_txconf);
-		dpaa_intf->tx_timestamp = 0;
 	}
 
 	while (nb_bufs) {
@@ -1326,7 +1320,7 @@ dpaa_eth_queue_tx(void *q, struct rte_mbuf **bufs, uint16_t nb_bufs)
 		for (loop = 0; loop < frames_to_send; loop++) {
 			mbuf = *(bufs++);
 			fd_arr[loop].cmd = 0;
-			if (dpaa_ieee_1588) {
+			if (unlikely(dpaa_intf->ts_enable)) {
 				fd_arr[loop].cmd |= DPAA_FD_CMD_FCO |
 					qman_fq_fqid(fq_txconf);
 				fd_arr[loop].cmd |= DPAA_FD_CMD_RPD |
@@ -1481,8 +1475,7 @@ dpaa_eth_tx_conf(void *q)
 
 			if (mbuf->ol_flags & RTE_MBUF_F_TX_IEEE1588_TMST) {
 				annot = GET_ANNOTATIONS(mbuf->buf_addr);
-				dpaa_intf->tx_timestamp =
-					rte_cpu_to_be_64(annot->timestamp);
+				dpaa_intf->tx_timestamp = rte_be_to_cpu_64(annot->timestamp);
 			}
 			dpaa_display_frame_info(&dq->fd, fq->fqid, true);
 			qman_dqrr_consume(fq, dq);
diff --git a/drivers/net/dpaa/dpaa_rxtx.h b/drivers/net/dpaa/dpaa_rxtx.h
index edb29788fb..233339a488 100644
--- a/drivers/net/dpaa/dpaa_rxtx.h
+++ b/drivers/net/dpaa/dpaa_rxtx.h
@@ -239,7 +239,7 @@ struct __rte_packed_begin dpaa_eth_parse_results_t {
 struct annotations_t {
 	uint8_t reserved[DEFAULT_RX_ICEOF];
 	struct dpaa_eth_parse_results_t parse;	/**< Pointer to Parsed result*/
-	uint64_t timestamp;
+	rte_be64_t timestamp;
 	uint64_t hash;			/**< Hash Result */
 };
 
-- 
2.25.1

