Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A66DCCD184
	for <dpdk-dev@archiver.kernel.org>; Fri, 17 Oct 2025 04:49:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6013A427AF;
	Fri, 17 Oct 2025 06:49:10 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013038.outbound.protection.outlook.com [52.101.72.38])
 by mails.dpdk.org (Postfix) with ESMTP id B92FF40DD7
 for <dev@dpdk.org>; Fri, 17 Oct 2025 06:49:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FWRIMB17qHKzJoB1pteR47RUOHHQklK3Ai4q8DZzn30nc9ArN6k5m3PBtSLjJAuXajJxTgNAc+IT/0lorUNom9swQKiFmUvpp4cgjJs1w3j2MtG/mzeQ3K1A6eizzML3ZjTk9/4UBezDamvZBChbWGiR2FerFcTZrWFvNgxsGqa3sqSMXKflSQiBAVD3RSVV/AWgNpy7UhWDMV3anIRVrynYlfQjtEyVKxGHW7wLVmpfYOSrO7tsaV8mMFwBsaVw/XTwdsTIlKEPngyJKna9D+XbVjrhJd0toD1TLhE+4DCZZItGP0upk+1DloJc7f/jN6PL0NlcY0YLHI/eI4nYgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=S1jeEcJfUoA80kH9M3osKdOvWHqCVt2+31Bc+blrfCA=;
 b=GdQul9Eo2aDetkQbcEyFVubuHMwtGe9D7vDcxVd2vF4aPans9d/dTxgr0r0BYT7HbIDzW1Ll6CBs3vl/w0TgILK5BLcawA79bgWavzXGOfb7l4+LB9M48mXqrl8LQ+RdUCrbeQunoVuK/BUMVyNpqmPJEw0kXZMqQC7lgn5rk3OlL1G+3cgevLQr4NS09XodYgsAqxkaHjwg/n1eFilsp3oQTcN2baYNr8zlrsXnK8J0VAetF3PWBtMTYQLTIR1nDwYLNYl3gdrn3XMeESxBkj8F78qMIN49wPs7m0J6U7uvj+S+0TdH5j3lNFhdyp9ClDLF4Yyi0UObADsUjhHd4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=S1jeEcJfUoA80kH9M3osKdOvWHqCVt2+31Bc+blrfCA=;
 b=b1corwfa7K+YSZ7gDwkgp9HdLD2r1Unrz6/TsJd423wwN5hFyyUACkChsBSUHFHwnQWHdsrULNckKcNCKMv9CX1YrFyqm9jvW9CrRNzWHsYbb0QZVNKDxcL8FNbtskKljcsyZrbmpQxO9d/+xOGWSt0LeXaSMcocPPFC5rgJnA36lObHv/O/Jz+x+XjB+FU0dZxhpUJBb3pDvwT7+k/bPe20ntWfq1vug61eVJaDiQ8FZZEt+lFsO3bX8bg1l32Z4/ys1GVN7N6w6GM70hOoeGoiCHHo9QCdOxGAj5lF7ixeresLmlwqPYEDXfR+sIO+Do9F5//F5ib7EjziHHe3yQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by PAXPR04MB8254.eurprd04.prod.outlook.com (2603:10a6:102:1cd::24)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9228.11; Fri, 17 Oct
 2025 04:49:07 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9228.012; Fri, 17 Oct 2025
 04:49:07 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Subject: [PATCH v5 2/6] bus/dpaa: imrpove DPAA bus qman logging
Date: Fri, 17 Oct 2025 10:18:44 +0530
Message-Id: <20251017044848.3269627-3-g.singh@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: 4e11ee30-2566-47c9-89a8-08de0d38815c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|19092799006|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?nGqSC009Zyw06lco9XyeeN6XqG1lM6DIZrlco1+guzPQDMPXpYDYYlWDgy9T?=
 =?us-ascii?Q?IK5YqXwHBMDCQwm5iMG9IbV0l1I/x15bz36sJ9H6s1qdFjhFINo4cEB/0OV/?=
 =?us-ascii?Q?bcpc3qOcy+AFIWcX6sepjGJaOlHd+PmofQiRzGDLOy+iLDBTsiJ0eYmGager?=
 =?us-ascii?Q?/sZVleEjoTsBpQP2brr7tlxm4qpuz3tAVOzDEVXuI27/TJDqVdeR+DkzR08X?=
 =?us-ascii?Q?TC17Q4sNYW9w8KTBESV+PjDpQiArdA+spOPTvYuKeL2u651JA0hmvcgvGxyu?=
 =?us-ascii?Q?uIeG1Ax8YyJs8qIDq+mLYkYcY3B7hKm3cVjQds6vf2ZVmhTEjUM4WQAdRIFQ?=
 =?us-ascii?Q?hzfMjpIuYD/M/TtZEAQhUzRCPWmuJPdho8hbfPSoqAMVJqE+rOgs0DkcduQP?=
 =?us-ascii?Q?/gVXv+bahVpJhvawXpXpJdrIdXzLcmOzdyvSfX5X0AfPEy2vEX7WoUOVDLqw?=
 =?us-ascii?Q?wE3Muerb2WNhc3buAiswvlccnVRBMAToHi+rGDB5sanzoPMKyLZE9fpy0LZU?=
 =?us-ascii?Q?kKd6xYOg7rtEnSg4/pEDQ/jHPX2E1gYNxmRJ3922CuPjm5c3HA14pH6Ni+H5?=
 =?us-ascii?Q?ksiRkYnmhr/qa7K2phIaoXhQRIuGwmhikEVc/ST6CaJcN5PaHNPZg5qrkAAY?=
 =?us-ascii?Q?1v4yEgog9mkCuzMxNpkjRoGkTpwk8A7Jzbje4/l3cvQVwnGc+HvlFcxzyZ8u?=
 =?us-ascii?Q?Ju83Bc/FU+KiYpsLETj85AF3VJuYy9eBPXwuyNrZANYsdlXMYVyTExy8koAV?=
 =?us-ascii?Q?fCIFgRXkxez8b2RkhVVjCMBgiTAhsXoDX/oSQj6w1wN+VG72JM3thVBy7BRC?=
 =?us-ascii?Q?QdQvsgA/qZ2oIFC1r6aU8QJkJlmnTmVsl1qWbZ/7CxNPbR6IGRrE8NoNBWqT?=
 =?us-ascii?Q?hbNTNDw2z72sHUGk4diA1r0iWy12HjG205qbLqP8TS4QUYHdskRGfMu5VUps?=
 =?us-ascii?Q?PrSD1dAY8Vu1u0xpJ6gs70JwG2jfs1PJXDEvytv31Wn5QExAt1Vo1Jn+8hib?=
 =?us-ascii?Q?eCnH2fiq1LWFhvG6aiZ+8NjfWglZmevV8F+VPegscTGsCBNonr5uxfTgPTSb?=
 =?us-ascii?Q?dhRBWqMZFlNmmz7XX4YbiYNfwgg3UwbWgtnZj7WQNKMhYLmQfrtCN24gaMj7?=
 =?us-ascii?Q?dpgZTeckbSWvrRlzCNPIt2+Vmm4FkjMiN8bsPaB048PK3PAtWlSbg5TJCuai?=
 =?us-ascii?Q?YhRRL4/sQA6MQbdhbhWr5xtvVOiZHnBcK+irPaGcRohc/459Azyi8Eu66bJt?=
 =?us-ascii?Q?zXgYQIwOPSSpqaMSveiaoslQ7rabdOnuNfL+az/qtTNtRTrTeC4VLL/JR9j4?=
 =?us-ascii?Q?Y840U3Y8LlyU0tPmTlL6keAi5/Fc40KLgfIeh0gcmCt7RWE8o0XOQRA15KZ+?=
 =?us-ascii?Q?zxhkgQRSV5VOPN1yHt3b+Y76O8a1R9r7ZyH4MY2coYwqEUHkTHbeZYm2P/r/?=
 =?us-ascii?Q?rizjT6o+kunYoaZfBRwfsFHAz/q6lF76rXAQ2rNocJu6GmTwbFuAMQ+1623M?=
 =?us-ascii?Q?HpKvAa4dLXaj7qp3gYJbDUCzkHR185eW/Vk6?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(19092799006)(52116014)(366016)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7dcePI90CfZYjWprGDh8YMd0IEY8FRvWUBuXk2KnU1+8uI54gyqQiyctrpUf?=
 =?us-ascii?Q?yuAI86DiK5MWhtezfLxtCrp8hcNedIIDFPfN60R7ajCiuPiU8E1HFIIkROg0?=
 =?us-ascii?Q?rZRHP0zMULD2mNyhxzGIeqz+6O/n/4sIET6nqZSdaUeZGjYrSboDt0EeA8Gj?=
 =?us-ascii?Q?H2m31Vtu5KzW5ftWOgt436iGsxmXKjVjvsHTqRFUO4JgNlPxw8CB0wEgoy5l?=
 =?us-ascii?Q?euyklc/fayh8UmM7DfEJx5GjXmWxFtU77Wh2E0jsJAf9NrAHHgCFEBoYRxmy?=
 =?us-ascii?Q?qPUVivKjr2V0SaBSEr7HNJH+50SpI3pdEbysfnhE5u9x37FKJ6tQUU0AsF/G?=
 =?us-ascii?Q?PaPM8dIWtC6oDagOEM5dCdDOI2MCV85yiwVUgmH+wyjyMMFfvS17y8Nk49p1?=
 =?us-ascii?Q?c5GMNUQIRf5rwN8p1gdLcDwQh+YyoY2nJIf8poEQKUkdCFOPBZMEe02Mx8ow?=
 =?us-ascii?Q?IrGSwP2+2PhgWmAkbpfaZqWMfjoKPsJ5Dz9QhUmDUxPfkdpnLduSqyjaORq5?=
 =?us-ascii?Q?wbKp5mM++v3kREgEFmizl1AcLOCuclxbShzqPvxQCQPFLKZBCwB0hnRa7a7F?=
 =?us-ascii?Q?z6t8rvkeFhdWG+jnf72FvBigzuBv/Gn/lJifNOOhAwsMkgjc+DBh3PdSQyjx?=
 =?us-ascii?Q?g+h9CeJTLEdRFgzZsekKwD0xOUS5gy+CtpvQi/UncDkOcGDZsEBtaIpQ25AK?=
 =?us-ascii?Q?HdvJGOu/0BzIj6fC71LunZiA0Eq1EUAn8aIN3+b5SMxWfqnL+BiyI67om3Pt?=
 =?us-ascii?Q?QT4vnE+28wxGiyAhce+R8HaQXg/uQNTEHQGxNDfnL5DfozbkgVRr33olB4I9?=
 =?us-ascii?Q?HTCskPJzhTDNPqREb23WdBLOLp8ah8bRzmvpp4/M60oVbA1voi4IhbdYFEDv?=
 =?us-ascii?Q?AlQ/wwvpChZQhfgIzBfdirpGFb0Bb3RgKAF1gK28/vtltvBkiEuI4MKNfANj?=
 =?us-ascii?Q?Yqlsu0rPvCY+Cw5Fz7n1pj/DGn7tR9ZViDPPVf/oiJ2fqZyS+n60M3xThLqT?=
 =?us-ascii?Q?+VZAcSN7voZ7Hb6lSgeTZn55/cO635GpuoXfwdwD/wgji3susfRK9L868bTU?=
 =?us-ascii?Q?jTRnqHrJ1OIxKy+7urllbti5lUvWh53obHbisHE5JAe9rM3bfPXnSVX1tRxP?=
 =?us-ascii?Q?6Cm1sAWHOpgC14hZ1EqRClhxuBLZQi2+V84DHN3ENQ8VDVqLMVxz84RxU6FY?=
 =?us-ascii?Q?9vgzGnmhgmJEvoEAWS8j8okmTNwafe4CQ7EKdGJe5k9f5sWDEgQq01rGEsiG?=
 =?us-ascii?Q?VplVktT2XL/LhuAERhMkVt79be9+ScCQNRPo0HLp4z1hQcyhwGIKB9tLW5BY?=
 =?us-ascii?Q?DbVRD8gfH3QSCTGG9rpUi+FNR4/CDXJskY8EJxmzjcD1dzx3F10DWxjkoTJg?=
 =?us-ascii?Q?97jsSbegZQ7iawxxYhmwFQ4aqdetEeqsIQ8TjFPzhDtypdhjN2F3EuwT/nyn?=
 =?us-ascii?Q?KFe456lsb2EoVSZ5NqXuhFX88MJwg/IWUZzx9Qb1hfW3baqIU4nryvRb/xoN?=
 =?us-ascii?Q?0BT84vWrihKs7AvqMeHs+gln6Bo0zVa5b09bNKBqwFEn12p+WrO2AlWfm+TN?=
 =?us-ascii?Q?25ZBUtUsnlM5C1gdZm5bWFHCZAIRtezhxo8uj4fK?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e11ee30-2566-47c9-89a8-08de0d38815c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Oct 2025 04:49:07.5101 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bJmt0Ls6aof/m9lLHAaNJZ0QHYtGVVccCqzqMC/W2kM21xIh/w2K6rPs2eDEt+HU
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

