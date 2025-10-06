Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3993CAC5B8
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Oct 2025 08:05:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 88FC940613;
	Mon,  6 Oct 2025 10:04:52 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011032.outbound.protection.outlook.com
 [40.107.130.32])
 by mails.dpdk.org (Postfix) with ESMTP id 17325409FA;
 Mon,  6 Oct 2025 10:04:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d1lO998gIVX5d/Lwz1HS23IihYhn0JLuTQ+/+lVl/GrfxkT72vxTl8bix0OQnIsgkfpMb7Qxx1uwEy8mCz1F/Ejw5x8B5bzeG4LwLm98hBeaMqb1tQF1lLe+SRjvNuj1cXOGjcbXYpdeIQVBw5FINF+N/YZHqnChV3snnxv7z+H2/MkpP1j1XO9/sjt6QzxphhYXVHw3faNE4ikQwO/zISLz0W7/dGDCgHv6AnWo0P8rnGsBX4OaWNTT5B1AIPHCh4AxWV+E+94RFBCwtq6pyZU4Notqp+GSITJEC0DK8spRbU2Gb1nB/yQqZZ3ECnm44K4bQ33OwSDam28ITLmpUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Pbcc79RA442T+FKmrLkinZNgK7dssDutAkDGyHiCuY=;
 b=CzY4AS4MEiwxnxhlxwr4zHOae2YwOnYxGyVJWP0NOMyMPmUNs290AMNeOhn9iUt9tLdqMxjVbg2noRLChpA7gT6uGO0HQTUWnrinxXrLWODtxipXfbZjEnwm6FVgeqFzZgSLJAELBIrxBwfRgOpC4ma7kxAm/pIowtX25G0y2aa6DYPFyldaPfQMsTOxIn2dy2Rt9gMkuY3byCMbUltdr/Yhsnd0r5stcJN7CPP67UECmPCc3CUO5Xpe0jofYlcd6cJLC5YyPjK2KJibSa9N9lsgthk7P4jWKQbwKEDga0fGkAVqrG+Tj7HT8j9FiDabOGPq2+7gx0jnauqyGkuLoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Pbcc79RA442T+FKmrLkinZNgK7dssDutAkDGyHiCuY=;
 b=Q8/PSCcQ2Qh22fDDN9Run26h7a9y42zcoIhEB1vZqhVQD8mubGEVFz9UD8flBQodk0rsC4lVRiy8pPOAaTCxvw8wE21hCx97n1+9LUK3AVjTgeJXPkpdzVXgV0jX121S42HHmaPj8xKknp3wb6t6PZmEKX8Fh2cMipg6jqTE/0ECj0af1oKFbhw6ol3yUelqjpmwrMmW44foLVSN7dH9IJdPMPtg38hLJdgOEM7si6VtPWQheJqDv1GoFiGhunY64I5jiYZB19C3Ws8Y6u+MiZFniiuSH7/gg0fp1CVsWuRrjfQp1pFLJsjqgnDTFvJrQDc0lJ0xU4FU0RFmVazbcg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com (2603:10a6:102:2b6::15)
 by AM8PR04MB7842.eurprd04.prod.outlook.com (2603:10a6:20b:245::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.20; Mon, 6 Oct
 2025 08:04:44 +0000
Received: from PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1]) by PAXPR04MB9328.eurprd04.prod.outlook.com
 ([fe80::f268:adb3:8817:15e1%4]) with mapi id 15.20.9182.017; Mon, 6 Oct 2025
 08:04:44 +0000
From: Hemant Agrawal <hemant.agrawal@nxp.com>
To: dev@dpdk.org,
	stephen@networkplumber.org,
	david.marchand@redhat.com
Cc: stable@dpdk.org
Subject: [PATCH 08/11] net/enetfec: fix to add check for Rx/Tx deferred queue
Date: Mon,  6 Oct 2025 13:34:07 +0530
Message-Id: <20251006080410.1433284-9-hemant.agrawal@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251006080410.1433284-1-hemant.agrawal@nxp.com>
References: <20251006080410.1433284-1-hemant.agrawal@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0036.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::20) To PAXPR04MB9328.eurprd04.prod.outlook.com
 (2603:10a6:102:2b6::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9328:EE_|AM8PR04MB7842:EE_
X-MS-Office365-Filtering-Correlation-Id: 705391f6-7bbc-489e-0196-08de04af0275
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|366016|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TW4mwzwaRIZ03HEjnjveW+YdLWS5Se1+k3Fv8NcEUU7KqYVdDOp3tZXq0z++?=
 =?us-ascii?Q?dtemBG/WLqWYT4ifEXJSMN8HxI8FYnjseSVK5TXnpd0twdkHFpHrw5FkCxNT?=
 =?us-ascii?Q?829VqNR20dBe8y53qei35kr9By25hrGlIM4YhvoDwZu3FMtUao3uo9kztUE/?=
 =?us-ascii?Q?pzOHgowsB12KAZ1z5T4azxxk21Ybr3g+1G8oxcXnIv35ZsU76o2Z3+kpaPA2?=
 =?us-ascii?Q?oDkWbK/FVcytZMeH/h+ZLo+RpVarSiHAnu8bisl/21SreufT339dvya5NsQF?=
 =?us-ascii?Q?C6Pg2iXtqNGwA8XQVuSWeY1SC2JL3DgGl5oT6YsMh/3dbwLIIRv7isgzTlsC?=
 =?us-ascii?Q?8OQm6l5JIb0V736PT9s6Ndy4ddnUz0dEFeo2MCAPINEQ+pZ0SJka483NgS7l?=
 =?us-ascii?Q?oByoohae8UIfhf0Goo7lsxgnOQKgv4Q/o00cAjlVPIPopOyHxPqqtz2vMtEw?=
 =?us-ascii?Q?4mydOLml0ChRyFajnbJmvA/4UBxZl0H+OyluY6DL38GUsCWCo1yZO2iYWIGd?=
 =?us-ascii?Q?orfwPN/i/cTw0JvECU/eyXwVIhXhra6Ghr+ojohBjVxbGvQo86F32z/hDioj?=
 =?us-ascii?Q?tDKfZkT/N1l13awZRIHUFCs3zCrT/Rt2JmalEl5DDts2cbEDGwfnSFbMivIu?=
 =?us-ascii?Q?HFMY7kh9RE+QMkseZEkGALyYMzdEKKMSiQhBnDPVcRGwF8TPszev3ZOdj44A?=
 =?us-ascii?Q?yY84fpTR4y5FZSv1/ydRMonlK58E1rx7a+O6zUiFKZ2s/NmHbLDY1/daXQs6?=
 =?us-ascii?Q?zrXnnRHUIlGPgtdw35F8AAUmI3MvebpD5x7l3dNJVL8MmrUPGz9L4hH7t79N?=
 =?us-ascii?Q?DIYN6irGq4YLFiNbytYXsWNWSTLg53GPLlOq2x3n/BWZA4MsBE29N41cny40?=
 =?us-ascii?Q?AQop9efQXPSIRrMK6McPP8c7Hgl8OYlJLTApRM1tB96cZ72HB1X40i4rJneo?=
 =?us-ascii?Q?DIJ4JCmX8l51LoadrOjkLuy1zVQU8H7VAZhQzCutox9gJut0LqDczPxeZxfg?=
 =?us-ascii?Q?rXqbkO9E/B42tRsFp+IFEGMk5LLvkOgX7BypPKavYR1tkw4fkQ2mAQlSfP4F?=
 =?us-ascii?Q?7HuLlxWm8S+OIATSgA2eDcKsJoMteJp22JWdku+Fjwi6ibFll5/RQmaWuWvd?=
 =?us-ascii?Q?0IpAeGXTmoSK6tV82P3TubPJeBA59RYH6aLnATmrnQ9TKN9rsh9l57N+rLm7?=
 =?us-ascii?Q?7zBMRE9U5xaIKXlk5d7BebEon13Oe0FqwryEyLPraNkkFkV2MCX7OAXGCmje?=
 =?us-ascii?Q?/jsHTnQ7bxe+YpMzWEAvWYsBaDo1ILovIyEDlsaZZadoe662S/Xk0+ZBEwp3?=
 =?us-ascii?Q?Ja3EJvahVRasPk1ebbp3IeioKmJ0LYLp0X0G19L/rT0ifYUf2HQgGwLcknO4?=
 =?us-ascii?Q?5WAsJ8mIJzBhrSTd6T+6H1CKE+uCfzclaXsuOGblnKizZKI+ij9QSEhTkuZT?=
 =?us-ascii?Q?Tw5OTblWRCAV7OFgAm6DyuDqwFYA+9/IHxlsbv94QjyaNuzFQEartv8qsuft?=
 =?us-ascii?Q?guD+BUP1eQjvZ9rptje52L5ngNiQaT/Y82na?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB9328.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(366016)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?JL5lLgCwlOlh+/JwspVEmJut0Exh6WyI2p2HmVHv//2E3nsGTgJ1CjPCXhpC?=
 =?us-ascii?Q?79vRsRdGCFkXawbqJxXgWa8Pq8Ac2z1iCk+2W18FBY7A586O3uBXEIX+106J?=
 =?us-ascii?Q?L7No4sOk7zwjpTRRVHkqSuSV/khVCPWTl3DeNGEL8hUE7z1Efu2PKw8i5WXv?=
 =?us-ascii?Q?C49PtTqMASeXFIiDZEiprEB4rwPxZPP7/e1IyumI9WRnpZi5l9TBBtPTy1rA?=
 =?us-ascii?Q?DzhGz3yOQTSI1skn7Ccg2lz720nNAwwtyTQWHXTKKEmKkIyUZklGuQGlr3Nr?=
 =?us-ascii?Q?jWLgq6ylFHMvjWsyeD3tKXndci73VcPiV60AFoTE0NQg7ZWmuTEU0MB2/RvE?=
 =?us-ascii?Q?o35BfK9YD7FItDmnQZMbkQZ7QouulV+CPAyoCAN7FxuA4KWDh9W9ip7darcX?=
 =?us-ascii?Q?RQ8M0c9sgFUc2ucXFXQX68Ggc2CGl/vkoxwEruVAauiKJsKOPwMkysXi9CXU?=
 =?us-ascii?Q?LunIeyl3CUBOUaw4ZDz7VBduQf3M0NEQ3wmAn+QHa50SaEqrMVP/cddxXIQ9?=
 =?us-ascii?Q?Ttf2Fvymxv7tbCki2X/7iLRtnkQydwbgKdN2z7xTRHBQW7jk6hwjzlBG336S?=
 =?us-ascii?Q?1Eh9x4siSlAEzZ0WD0l0Dws+Iv1mWcLkcuwSwj505vikn+W6YjfcA6b276Lq?=
 =?us-ascii?Q?9QMbghIYxHUndfbDmsZAldnhNPDMQc+MGKaarAd20RWpWI9K6m3O93nzPzbX?=
 =?us-ascii?Q?P5qzDXXSBjwQnaY+BK5gPfqcgPjeCD/DlfnB4LperYdvkqIpsJCkhT7298wG?=
 =?us-ascii?Q?2qffm/Iwdwwv1AzQymZDDj0tYQhgHnJSY/OJemsoOEgViKuzOkF6dqZTuSLY?=
 =?us-ascii?Q?LHjWfASV5uyqoaI+zdwDlmnr5OxTbHsR2bNGzxaf4BfDHnfFNLvo686p9K3h?=
 =?us-ascii?Q?L03Awg4xTQSI3oEdxZLIEyqhM0f3iYHp9uFJwaINpZy4y+nWzWKkF6O5VU5y?=
 =?us-ascii?Q?pPfEAu8FUcu7kqXT21/QlbivZVK7rfvhxh2KoPoWOAEWq5QLI6a8p20GyguJ?=
 =?us-ascii?Q?VATx0Kmenr2HFul9lGcGFAtj5ZS65pdoZ4uDUS4rUDlwtcPnBQukxaTM0zeS?=
 =?us-ascii?Q?uMOQs9p24osfRlTRzAVA5E8XB/kVRvDrcj4Tfi0O9a+miSqjpUqzAVS/SaLR?=
 =?us-ascii?Q?YgOohWnDJYCdihQL2hgW8Kdn93LcweIfwJhUywx/mL0EOMwm6PzZpapf7Deh?=
 =?us-ascii?Q?wpSUuRG77VUYDWbHJiaMDD00mPe3Y1xxUfZ0BnkF8pDS7Rhs1EU1U6TiNH2G?=
 =?us-ascii?Q?HiqOZZd4pHKSo8zVBbvb/LmLUSCMd4KXmvzux8QLP8DXecHHg5rQvISuXfL9?=
 =?us-ascii?Q?C74NsS5ijEUejIHEP28RCzZfDOY1JTdwNfRDxsOLsYhG4Tj9vUVQ668FA3h1?=
 =?us-ascii?Q?lhpPsUQOkiA5+fOHI/b8hjIOiQg2EBymCMjHEIFK47uSVeYp99zD3E+N1cBJ?=
 =?us-ascii?Q?67IZRRsvP22PoEeAkgN8lCnedeypNosa8gYgqOfJQdLPLd8KUgiELyOaF0vR?=
 =?us-ascii?Q?oLg53zzmbP3eTMh7Rpjs7C3Z0CxwTgW23iPOkfA3GWB7vM/5r4SbhKlGpdRR?=
 =?us-ascii?Q?arWcwKO114pJzCQIhvT+/fHi0BWieDxpuJKDYMW2X7Nm5pWx3Ld5cdVnyn7w?=
 =?us-ascii?Q?NA=3D=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 705391f6-7bbc-489e-0196-08de04af0275
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9328.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Oct 2025 08:04:44.3479 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m4e26jNdH1feMqrcvC8mt5FCAPaHikA8ww+e0k4uPhOYoB464FrMGlfmEFeRIwfShn7QZWIzDxrDkBrDEXnLBA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7842
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

This patch adds a check to reject configuration of Tx deferred start,
which is not supported by the enetfec PMD. This ensures that unsupported
features are explicitly handled and reported.

Fixes: bb5b5bf1e5c6 ("net/enetfec: support queue configuration")
Cc: stable@dpdk.org

Signed-off-by: Hemant Agrawal <hemant.agrawal@nxp.com>
---
 drivers/net/enetfec/enet_ethdev.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/enetfec/enet_ethdev.c b/drivers/net/enetfec/enet_ethdev.c
index 60bb4f7ebd..6d4d3e0fc2 100644
--- a/drivers/net/enetfec/enet_ethdev.c
+++ b/drivers/net/enetfec/enet_ethdev.c
@@ -384,6 +384,12 @@ enetfec_tx_queue_setup(struct rte_eth_dev *dev,
 		return -EINVAL;
 	}
 
+	/* Tx deferred start is not supported */
+	if (tx_conf->tx_deferred_start) {
+		ENETFEC_PMD_ERR("Tx deferred start not supported");
+		return -EINVAL;
+	}
+
 	/* allocate transmit queue */
 	txq = rte_zmalloc(NULL, sizeof(*txq), RTE_CACHE_LINE_SIZE);
 	if (txq == NULL) {
-- 
2.25.1

