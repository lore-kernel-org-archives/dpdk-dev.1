Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC963CCD187
	for <dpdk-dev@archiver.kernel.org>; Tue, 14 Oct 2025 10:17:49 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C77FA40665;
	Tue, 14 Oct 2025 12:17:39 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012046.outbound.protection.outlook.com [52.101.66.46])
 by mails.dpdk.org (Postfix) with ESMTP id B188A4066B
 for <dev@dpdk.org>; Tue, 14 Oct 2025 12:17:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m7zROiwrLU/TarCpAbTHGFB4jIvyo3FT9dYl2PpUAXt3TFqQS2N/U1wcWaXWw4NclsWQdplYwmCGcnSfDjT9MuJvSPwzTSMlbg7A3iQgsTnDTnM6Qn2c6xI96NnU4ESFBDfSx6et0lMw1Rnxpe0DHPsE/Z9cVrcG8wABeDEIAIORnLXMFCdervL25O/+/LYZ4gNh/Mcqb/S+3XGn5z4MwDEJ5Z70kZ9TrL7QeisMNZdpzoHji/WhNxgY34lrY908SAicSPQlCXw1nzlT02YTbsSA+JgdzNvPaPG6QzKpedhM5rv3yEubhAbDl3eLixc1SlR4B0z3Plrbn6aLTpSl7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iBPbQdziBOkDx9MtJBcKaD/5GTSmxq61nf5hhuZyIYw=;
 b=JU1NWygYLXj7u73CXQValMqfgkTBMNf0W7fVCRjgEsROpr1IB6xTAO7odnQhp4icrC1l2HPIFjK5Wza2X+/htAxMCUQEs3+gm/T8lZNKT0KPtrBRIWq1Xx+MyInfH+UwCy3C/18dcRr5EA86nIY6KsC1l3vJo86u7uXGJcKxVop4sTmEbmuGC+Hn40QA3fDiKxUGwssPsUMyFAJqJAmpStHwPe8Tl/sG+Xd0MmpUjUkPVCHjTspHxp9pvpXVhKldAYE1fq25oHHfyCTHCGpTxCPFVodiam0bZSdafbDqOT2hhlOZtgrJGf6fDm7zqi0gj1rSb9wpuKLk2v1uEXo47w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iBPbQdziBOkDx9MtJBcKaD/5GTSmxq61nf5hhuZyIYw=;
 b=JjsF6h3iLHUog18asG6lAdDjB7ygf2bRi+88tTBsFCTb5sHL4xXYnnVqUi6O42M3Io3KhLjVG2kOKVNEOijapJjGcuIBsylXGJ16UhprAbMmXLaALbeXVdNTyxlpMaS/8FmdL0PogBZqxK1rAh4w+yccOZXQFyDu4i1/+fkyGifog9SvLajCLsStl3NmtzgWnC4DnUcyTHK24Xzy9HrVntSNshEJkgcYBCxQ5tQiSCK8HIYvUNDDjS05AKfhsvNwtBAGwMvwB0N9TZhYK5R3dPfIG/brpZlYw4dGtxxiW7/PfVvwCTr9AVkxd/dsMjewOKcmFwf/6yXgOCXtkPTmOA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM9PR04MB7617.eurprd04.prod.outlook.com (2603:10a6:20b:286::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9203.10; Tue, 14 Oct
 2025 10:17:37 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::c52d:9751:36a3:78f9%6]) with mapi id 15.20.9228.009; Tue, 14 Oct 2025
 10:17:37 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v3 2/5] net/dpaa: Support IEEE1588 by timesync API
Date: Tue, 14 Oct 2025 15:47:13 +0530
Message-Id: <20251014101716.2885563-3-g.singh@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: e6ed31a0-ebbb-4d5c-48a6-08de0b0ae5cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|52116014|366016|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x6eT2qXDWtDlZxyoQsnl2oQoGhfUuooEq7Qh3Jfsd5f0dQYRu2/8rgyfwI+i?=
 =?us-ascii?Q?P5mD9zQ3mzwuux6ftUjUtmDrail4Msa7W3WXXVIPdlTHD/dqCcUR31qz6hSm?=
 =?us-ascii?Q?ALR7dJKnKJK5iHmeZWGiApAna4w3EY3zGvn5c+lkrylfKpHrXWu8opJ6kDCs?=
 =?us-ascii?Q?47KDstz8iwrQo+KNQxgLN1nr7jko+DeUsvr8MTCrHhHUsKHDebPp+vK5xPH+?=
 =?us-ascii?Q?RM7aKuBbe/QRFYSgLm8fPSM27d4dlBgJW50a3MHQ8AssxZ4Q51QNRHVvBhWL?=
 =?us-ascii?Q?ed+soZGThiewrG1qAsIbgdjN5DG8T2b2eCgCUJfbWaYMgT67fTJuVYjPt9i/?=
 =?us-ascii?Q?EadK5REvi6LskYLS8d/Y0vGGx7AeodENaw4QCz1NPozwLZnx72hSXiVFK/wN?=
 =?us-ascii?Q?ms8kdYEOc1DXbqvjtKuk8KBgD15bWMZOAZXli+HYUy2D0uXw/snChys8fXHz?=
 =?us-ascii?Q?NXA8mT/9xI1DrLWuQoOI9XeRQzoWmMjodTSjQR+7C298oYNUkowlof9Lhdfv?=
 =?us-ascii?Q?xT45XrqApH0cuYu80jnzP4xikrnMlMaCOahb9jiw5xwKimAcq6MwdVmNVpYt?=
 =?us-ascii?Q?XEbonMMVmztFX2T1IBtlXltj7VnITbUy3jOboS/RfzJ2lGCB+Y6RcXKJEmJy?=
 =?us-ascii?Q?gXXyhIMXI9IAme02TFLvxvQN/hTQCEkvsSYC3VzaOIpmz0J0s5WynBcNB+qR?=
 =?us-ascii?Q?BdbjMSkf48+vsBjoxIT2LcH31R2L02YywHvzTpEwArE0AHoX9hHhiT6y/oMj?=
 =?us-ascii?Q?ok7wflRkkCGsYxuqj8hxIBrnr0yUXdGdVckFI9EBUklI74UTwQa4R1l6trU9?=
 =?us-ascii?Q?EeR8wqU/yfuk0bzg9+LJNX1sDdvmFx1ev8U5t8Z4xHqFQeekRS4nphOlij2n?=
 =?us-ascii?Q?zMYz2qqgs11xoE8M+buajuTh1U4ILeNTDpSqe5wMbBFsAAK431JuUbFgbqJt?=
 =?us-ascii?Q?wZbi5Pbpn2Mt7LJJaOjf+VJgwkMZT9Q/hLcnMEh3LEQXYvQJd50fJlA68pPC?=
 =?us-ascii?Q?JfOn6WIuBl27JyvYR5KiebXvJdrDf/6goaUvigNxkTUEezWwdsxpZoeLSpZK?=
 =?us-ascii?Q?KWO8+g0JRyIn3YJab5s1JiZgMEIzhAvAlnmb2ftta80GMHw7T82s9ZbYoc64?=
 =?us-ascii?Q?4jgeObuhkJsWai4aLBHARA/K4GB1VbfSld+C01YqdXjA6H30RWsMDW1liJAj?=
 =?us-ascii?Q?MfuZ7TQQnuppN4yNukxPFtsqrw5gWs68nIsa42agkWtGjltV4GhBgsb9Uisa?=
 =?us-ascii?Q?ZBslthNYi5QXWgMsfLehTN/+rFej8Bv6FnywDJjlzUa8AgIbbAyU8QLl0MIo?=
 =?us-ascii?Q?ffe1eo2PlVkKHptPCOtvmavP9M8tMb0j7lgmWo8aIAmhsMT+rIXRe5tecaDL?=
 =?us-ascii?Q?WFIZ1jG1NWI98avias45OuVbldceeNXs7tdjLYTWHDFmPkFgK7Wwbe+7LXRg?=
 =?us-ascii?Q?/ADEzCTsgHktj4lJ6v0LJLKSw8/UH1ogyxf9H70ZUTM522cJGwnqF8tWVhGS?=
 =?us-ascii?Q?YVvL+q46q1Y4RrStXX97tE7IxbjWjaaH+h2C?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(52116014)(366016)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8A3CMWowdgd4HmY2MNoACJpjQ9XA/Zc396EUnCOdM0DYl60w64Br6XnvfLe2?=
 =?us-ascii?Q?KCuK9e9cwGFWsEYuVgVqaFOkn7gi5LIjINMMRqDVpO9yTE9yCZvDXFEJirXy?=
 =?us-ascii?Q?kbMp22MCEYDoFv8wK0JfXP6Bqd707PgNzp6/U5QVpDnQrjJVp+ChoR9wTPV2?=
 =?us-ascii?Q?TbbrMksfDJQOtPv5538yOdh8dFg6QS7xbwffrEaCA034rWxYUSIDcDbgAIu8?=
 =?us-ascii?Q?WnAc331LtPcV2az0eCc8WIDJA8lopQ7Z+OTqfKZkA3gEth4YMKEip1ca46s+?=
 =?us-ascii?Q?oLXNxDBUNP5TgIMnRDvDzPrFr+CE31YMZ6WeyWBHVY0KwzK5iuYKxF03Glen?=
 =?us-ascii?Q?Fki+KiZFLoRi+vpJICzHLSKqyyNM4uM5qN3b3sdV+RDZxw7RnRdiR49oHtIC?=
 =?us-ascii?Q?RZ8JNX9a9ycUQZ2Rb+2CtH6F/CDu+dBUbj4I5uXdaxaC9PfTo0RiTyKkkVG5?=
 =?us-ascii?Q?PEWr1LZGzFAjJ6wIgIrWWnlYPm4pGaZSzhEQNWLF53ETxGCj6ZiNv2ymMpXc?=
 =?us-ascii?Q?IQQACTgH8Sz05UE+exeerHrIr90nJhBdu2S/TI0V9t8q8BlJyaA+//+DjJPm?=
 =?us-ascii?Q?caDN1RV7bEL70Ba58SKDIYXxcKMB9uGVYpI4QqsQBnob4T+cj/yEUMaa3yAp?=
 =?us-ascii?Q?0ELM6H1JlmPrj8g12dygm4v5biIDzEQl1NFG2CN5JNdOQKOuV6ra58AEnfdA?=
 =?us-ascii?Q?ko1+UU8Cty48ha5PhoEx5pPtb81nTLMxKBPJYxdhywvyZ8ZDZJxYWM3q1io6?=
 =?us-ascii?Q?UIkxMQEql3FiggZ9q5vsfqzZyKRl0RS4/g/XsuVsdRUgO/7iYg8Frw+a0NvQ?=
 =?us-ascii?Q?LHdCmIVcJt0H+opqH0dinOM3ihhH25JG18urNEvQIgTNIzzgpjFzr67ZrDAO?=
 =?us-ascii?Q?pvY1PW+pIyNfIcsY60jR4aR7HIrHr5qV6X97GYwJw7NTRM1NzGQMAOGmyE5F?=
 =?us-ascii?Q?4IHkUfMizKKpsXgImFHKbfgKQ5JK+5WQ6acQ+jZ7w3s0fuqcfD9Jx3KvPwew?=
 =?us-ascii?Q?Za7pSiFYo6itUElvcZMre5DP7PZTFhE5U4dJlzi/MavoeYJ3doshbc/mThIX?=
 =?us-ascii?Q?A9G39+3F/DaUgpBUifVqxWN/StuS3QiomGDQi8stHDBhC78QfRw0uUqfBrpS?=
 =?us-ascii?Q?ita8BNbhPwJ0jmIeJrgwLZgrF9CFCV86JxBy4OqlZtUx/Pwtud34zakMJFpp?=
 =?us-ascii?Q?M7P2UdBzP8DntWFZBfToyjh95wwg929R43e+0oOY+aa6kSLQSiGQL4dwVA0Q?=
 =?us-ascii?Q?IelyNKzdJeC42ujq9ZW64gehfXGawNbcfUUfjC2fZCqC/UtFlFcVq5eKMJtm?=
 =?us-ascii?Q?YbzjZyeBEZ3YKNkNMFoM0yNTPYhBmv5GCdslTApseksm1t9ZLGKb/qPA9C81?=
 =?us-ascii?Q?M8fDs8fr3xGDpY64HQZvKJkc6AHety5+unLpgZxtzigKA0qkXljjGkisdiHk?=
 =?us-ascii?Q?M2IA6Duz7k+az2ZTKIh9g5InzqujM/yLy5acNIlE/1A9xnWULkB1jszKL2Rv?=
 =?us-ascii?Q?tUogJMShhtYfwf4e9YloltsGHzO+Fs5yW0VI0lAe5DqpJlgmegCMhYuo4qWq?=
 =?us-ascii?Q?Harq5uZhr3ayOIXG8L0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e6ed31a0-ebbb-4d5c-48a6-08de0b0ae5cc
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2025 10:17:37.0386 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: E1uBc1ZFWs+LQ9JspGglpn1wgP6vzRnYE1xczy6Wj9hi2k2VoWYflwGC05FGAJtY
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
index 6ce3690366..ec1fdb7cd3 100644
--- a/drivers/bus/dpaa/base/qbman/qman.c
+++ b/drivers/bus/dpaa/base/qbman/qman.c
@@ -1234,14 +1234,14 @@ u16 qman_affine_channel(int cpu)
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
 
@@ -1275,12 +1275,12 @@ unsigned int qman_portal_poll_rx(unsigned int poll_limit,
 
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
@@ -1289,7 +1289,7 @@ unsigned int qman_portal_poll_rx(unsigned int poll_limit,
 	} while (++limit < poll_limit);
 
 	if (rx_number)
-		fq->cb.dqrr_dpdk_pull_cb(&fq, shadow, bufs, rx_number);
+		cb->dqrr_dpdk_pull_cb(fq, shadow, bufs, rx_number);
 
 	/* Consume all the DQRR enries together */
 	qm_out(DQRR_DCAP, (1 << 8) | consume);
diff --git a/drivers/bus/dpaa/include/fsl_qman.h b/drivers/bus/dpaa/include/fsl_qman.h
index 5b6015a876..93611cc234 100644
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

