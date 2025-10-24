Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF15CCD1AB
	for <dpdk-dev@archiver.kernel.org>; Fri, 24 Oct 2025 06:19:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6C5140665;
	Fri, 24 Oct 2025 08:19:28 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011026.outbound.protection.outlook.com [52.101.70.26])
 by mails.dpdk.org (Postfix) with ESMTP id 9E87940613
 for <dev@dpdk.org>; Fri, 24 Oct 2025 08:19:27 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PQDAhrqn4xX5jJBdO1wbKHL95cQLwh5FeSe2kJKj1aDAUpW9ZOjyCEslMeA9jRZeFn0NfAFA0cEGo5UvMk61rHTl/Qj2SNZdGr4cEL10wXnIIaCt3h9ZQC3Zk69EEnkODRn+poH6LJr9snVQbYtGNYndjBUOemaJr8ZFCGGEmbuxt+A8PyYLZhcKSu6Goh5au7LAYQNyzl23pYB3C5EANnuMvhH/HoKZpuS7up8RriPxzpRNyKy1/xSDunGDx7+5++L3wYcX+KG9uKtTQw1BO1/poMa1uraGD/FqaR+T+flfMX7Gru8YLq9DF8iuFL+GYYuoWvk+BReLMk12Ep10tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1jeEcJfUoA80kH9M3osKdOvWHqCVt2+31Bc+blrfCA=;
 b=toxrNtG780/Wl6mztXtTsXvfNFaDO+FvsbLY7O7IzFZkeQYYB7CZFxXsdzB7x6i8HkFm27OdMialt8LIMEQ24trfhVEluQpQgg/lqqUntcxJcYRSjOPS7Rh2FNwwNbjTuVM5GJnazulE6DDKwFqo5fHZfHN30jL6dMjMaHPYTAotONCkve8WowYr4uO71ohva5+fK0SzlvlPsXZ90C3MdNft/wVJFKU2q6S+mXJhzN0puetVku1yB9swbxgnNJQkgRq5V7/PUzNgP1BqWi9lAviis2e8UOwQkYkD5yjw3GA7pytFv1rSFlrLNJxH2WBUUjsc1/XkaEVWXlOWHec/DA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1jeEcJfUoA80kH9M3osKdOvWHqCVt2+31Bc+blrfCA=;
 b=N8gyctAKWdHvg8dppNeuzonfbdhlKewkwzb7qNyFJVqCspfWhsCyZ1yakhnyrkh1izjfht/XrYTqTsFM4ThfUzrYh2KW9vEYXKaTFiJkwX79gGYfoaD1unhYm6qzsmuW2398Px/jOOY6H5A00anIZdMGKOkjSSpHYaOk/AZXKn8dPSNBoVhVYZK7qV8u7wQRabuK4GB9h66xeGPkWRafZC0L/QS8dvugr35Qxt6Vj1uQXTGlXPsqbVmWxC9izxGoR5xkKqXE472xgv0BhKE05iMZHTYe6XXl6teLINV6/kNQWXxZ6JkUwtfGW2i2LgR5+DCZPeu+83rNbeLw0+OmNQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by DBAPR04MB7478.eurprd04.prod.outlook.com (2603:10a6:10:1b3::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.13; Fri, 24 Oct
 2025 06:19:26 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9253.011; Fri, 24 Oct 2025
 06:19:26 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v6 2/6] bus/dpaa: improve DPAA bus qman logging
Date: Fri, 24 Oct 2025 11:49:02 +0530
Message-Id: <20251024061906.3535470-3-g.singh@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 9d9c4630-958e-4009-491b-08de12c54829
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|366016|376014|19092799006|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?UULfwc5YZMozxDm5cxPFDURdwzqot1ViQjr6CCOu4Lg+y/o4cm0Z+FeZEbv3?=
 =?us-ascii?Q?8Ef7bvrFr3UQyA3QQ8IJgJPTw2VmX/G1rToKlQhzhjo+q/GHtMwk5RMedF/n?=
 =?us-ascii?Q?xZ+zbN0ABfyIFJXAiX2DckIvetCs7opl0KH0y4c04bCJHuv+n9m0ls4SwCAc?=
 =?us-ascii?Q?fs+W/1o/rUHtIbPIbGLvYtCLyk/M3T8MjoT3KTnJz9MvcNHzb3PMQguxT48N?=
 =?us-ascii?Q?ufrkdUcjIdhMJBWq/cHxBN+FesqTegWbDND3SqA0Dt8WGdZhwcAx3GItQdl8?=
 =?us-ascii?Q?gHZRNf3OsOeYjQSBO80/ul2KKT+NSmTiG/Dbkg0ODA3Q68LISOlH6njKZmmq?=
 =?us-ascii?Q?U1m1TmFT5ZWv8Fvyjul7HBdtJRWOmCB6+TDxQtVzTNl28+qqaaY3YL9WWN8D?=
 =?us-ascii?Q?hJ/p/DtCt0CXP3QX2lnv/LoLXcBl9vilgieDtxgVpsTJV1XADTl3ZgTz7Ixq?=
 =?us-ascii?Q?zB/LKHZ8JqAcHIikJDAmqciIuxLYZREzgfYBkJuTcTjxByVeUVPTtikObUga?=
 =?us-ascii?Q?28jvOihF9gDxkEkx7I1oXYkDD2x3on45cXSjT5ASC7b5Yym0Bww8tpsKePnr?=
 =?us-ascii?Q?Tk+N9osdiamuhd97zaixvkzBDs4+iJY/uprpOh3tImxGDNiRQBr+TvmUXfpU?=
 =?us-ascii?Q?okVbsVljd80Uzd+AEogNpHXqnTklzTK+wr3+Ze2LjKXfiVSLl56giLKk3Tks?=
 =?us-ascii?Q?JPY4fj3Jz4FZXzDkiS1+kG8Vv52d28NfWWfQkhoVwFPDMc0wwKvhuZzGy3yo?=
 =?us-ascii?Q?R0mwe5d4cq8hkShg7eilK9nBof1CmqaaNtUowqM33EklZh1ejSbB4UOFYD8E?=
 =?us-ascii?Q?yFc9IllcLCZ52h9uI9i/XPqvJCS01+UAqdEwxfo7ytZZQ9jF0ofvrIYQ52H/?=
 =?us-ascii?Q?WR5PozYOmumqzHWFTSkydokqSX5LnCq2wn8cWVOwqw7t9m4mDbwamkKHJs8r?=
 =?us-ascii?Q?RHmFoUF6/qgjBf41aBsxtHwoxpeoS6ZTw+w0jUybQOrjvIVFJo69kDNIy8+X?=
 =?us-ascii?Q?m410OpqSy1SGs+udd0XykLv5xJp71CZXUTLrxJwmLUu7fWIxr3RMLkV6Q/9g?=
 =?us-ascii?Q?ft4uns8Y3SuA+DhtuD11KmM3q06ltbfcOI4L/Vt31+YhBAQ4jmMBzl7eD/WG?=
 =?us-ascii?Q?pIldU2ofIS2htxUzBq15EJEmYHDstXRS6WL6GsUxRRuVwJFLY/0p4c9SRnlA?=
 =?us-ascii?Q?/kqQR6A820qUxy+DfDi6e87JjMIzgOj0rxqInZFL2XDs/cWN/+vzOTXappus?=
 =?us-ascii?Q?j39F6ybtXk+HVqG8xTKHE1qmwfvaeS7taFZApeyteh9HPfEP5N3fEfrmxNV5?=
 =?us-ascii?Q?IPQQysMeDTzj0LMOFujU/OdO8zrVQS+yQxdUHIo0ojuyKmx4Mw502q4nx4fX?=
 =?us-ascii?Q?i6zqlblWhU8oclxNTXzPc1zq9W5lqqgFSEna7b1vQOUVPOXlwMedH1hh0Hrl?=
 =?us-ascii?Q?AuytIKCJ2IDXrEmeR11PEQi7XD68CCU4Sz8ojbF09MhjFq+LHNQ40267Nlbc?=
 =?us-ascii?Q?2gSN60W5VIDsov2keSYwgZ7IW0SRiKonfUQU?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(366016)(376014)(19092799006)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P/d1bhx0CUrGXpMZLy3J1u78j6du+RXWLyLTT0xiBVPPYOF3AVYTxFSmGkTt?=
 =?us-ascii?Q?K1D1RkCNbYO4ndcdoXaqj1TWZVx72xSRorf+RxZkLd7V7IQGrSv4LH/5dU7S?=
 =?us-ascii?Q?gz8ISv59vyI4gWreyeH+Xju9sk9UkmR6Bp3LAjHw29kduyRqLxIfPa9sqZ2i?=
 =?us-ascii?Q?vzFj3naOgwAw4mTswvuoBBTOXR4Y7jbeS/UkO5zpX+ytWYMBGNUYTO8Xf4oR?=
 =?us-ascii?Q?NG2amWfPUHbO9lbPsgZi+sFQhh6jJyRoeXutvKs0UWEDKV5FUkgpyBp1u4jg?=
 =?us-ascii?Q?kCnhlG0kBTzLNDiS/Cgh/zxevQT5AgGB3wRdQejZE7q5uge5EtSITCAFgesX?=
 =?us-ascii?Q?yrcGXqt6VnMYAlXHoko47L9jRDh2Uo8bI2j2/zqnnukbfASRAUrIV/9lBB1v?=
 =?us-ascii?Q?FcbCCsgC35rYd9fxklllW9IkiNIK/QIo4spPB1+Ckv6p5+QYX6sd+BhhuBND?=
 =?us-ascii?Q?ddRIaXyAjSNg4FWKYtP+Pxfj8HFLoGYc0R4nbnLQ1T17WXxj7rDacvnZvYXP?=
 =?us-ascii?Q?75JFbMN4Ku8rdM+wwXn8aRYyVRSG+y2u+6iBjKhFWczT6oYSay4omLY+K4mB?=
 =?us-ascii?Q?betyq+RWCUor3JNWBywCJiwJK6xqcO1F33pjVHvIQKKUhDakUTolZeWZIebw?=
 =?us-ascii?Q?EdmUWMZ+NjNC+wjvcA/T1obuuYUb4CoNPSsfGGrJaB/pk3GvXvEs0Ee3ac7l?=
 =?us-ascii?Q?wzSPmTv21Yy8TDdQ57FXn4nimbnTHOrZrevEDR4HYT/vmd9EwenS5dj+vSpH?=
 =?us-ascii?Q?bVLm6XVWaDGiBVPLXTTkMeq2G/xmd9APfvw11qHa9hx4AZxtAaslHRwxD3n+?=
 =?us-ascii?Q?Ifu2kmdHuAYearg27HaFVBV8JYnK43enexeXV2J491jGxbCrhmRQz3qe/Zc4?=
 =?us-ascii?Q?UqNZMCj9s+DF4DPliaoR10KN5L1k/otSsILAVyuvyszhm92RdBcvOo36GF6x?=
 =?us-ascii?Q?XyTagKjVYC+Lo8u2YtBYvAU+IpXrqtXyTnSRH9PbHzNFavgJH//utq4SBwJK?=
 =?us-ascii?Q?jpfCe6mTKcfOpd3w/NbNj43Pbk0kW3N8H/vgMDYrZUjLsfhNqMoxQvV9tHi+?=
 =?us-ascii?Q?cxmbgKNEPv9g1bUoWhw/Ue7cNnuJKCDAQYpHP1et/2+POtYF7q9se+gBLha0?=
 =?us-ascii?Q?Ui7kOy3FObxud+6lXXDDzMZJCbFzdKDUyEpLoAPSYWUZ8fXe/y8gBoMdgBSF?=
 =?us-ascii?Q?PkyTKRdtym5NlREkks9lH4DJukK8TFtaQvG/G3b/KPqRZ6jWCMn8lJSxuHmk?=
 =?us-ascii?Q?b+Y2cod+NS2gCTsgC4OFQt9RAtvNcwiEXXGxNfV4TVxLjrjTJyO1hvEYqjbO?=
 =?us-ascii?Q?x8D3juEPe2h3nLOjwiauLgKCi/K5n5hwVJ5KKxXAfsDfYwYV3hSM7g4FCt4A?=
 =?us-ascii?Q?Mvy63ji6w9Cc7KuSACYcNLs2p3jK0Wznw8tdJx+H3hSDnfDLqHVis797ags0?=
 =?us-ascii?Q?UJdQVrlWk87Bgf8r6cD8r279VuuhuYUHLzrBY8R8Chh0RuSEwJWJi76Zn8BL?=
 =?us-ascii?Q?astneDOQ321GKE6FCGGe+pLUN7Y2tsoKhOYEnbtZV6wX/BA6DbBaXq717wlx?=
 =?us-ascii?Q?RQklicePYGm5O00CYf8=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9c4630-958e-4009-491b-08de12c54829
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Oct 2025 06:19:26.5414 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rQzdohwW/gd4ypVRQZ6+KV50QDNK4sqBssDgNxyH/S8VixB9RDWawzBYltWtvGdh
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

