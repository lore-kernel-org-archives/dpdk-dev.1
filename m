Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86262C61CE7
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 02:56:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BF2D40A6C;
	Mon,  9 Jun 2025 04:55:41 +0200 (CEST)
Received: from AS8PR04CU009.outbound.protection.outlook.com
 (mail-westeuropeazon11011031.outbound.protection.outlook.com [52.101.70.31])
 by mails.dpdk.org (Postfix) with ESMTP id 7D4344066E
 for <dev@dpdk.org>; Mon,  9 Jun 2025 04:55:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gqxjLYg92bJhQiixMzhfcfci7qUrimmUeW3kbHtDyfMJXrT1y4B15YmqdNYDS1VU631gCzVBVWxFyyZ8ir/FPyNQxEhNnA9qsWq+rRBGz29KycA5f+7ygxo7d5553QkE9mkr6WQ0emKYy+VVEMWo0zegnY3BL6VJfTdNpbZ4hBhP56Wzb8xfz8hGXHl7XNRQDQ1vmIzTFbBbf+ygcTktGF3/hJJqS42nr7BjKAzCxvGfMti7ncPb8+CYxtwdUpjJpPwu8T2gql9/+/3TyOIbFyRFLUYe/JlGPO+YPCunM+A0u5sG7kaIVSQ8OIaEpPikEMKlwPs8eeOeMBi82ToFmw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nRWcIPfHSb2am1ilHJsClnMYa3QyedOwxaFuNVgaP1g=;
 b=biM4xTUYtEyyjK2WuyiYMSpYmFurcVGNsKTfzSD3ORjLh1uLrVSiv5kdvl1+S3FXIrjkKUbCTpI+FiftlIq0NoDi7GwEOWGyJRAdlBoW7d2KL9NFlSE/SupqYznQvEgn/AE2XSCcG2F38SdBoc8L907MIXrb6/lHsNJdVBr7SEvLWzo3dik3G0V60cHT5OcY8Mfkx0L7deoROOkm99GwuGTzpnUWzBOJDoyMKiH+ELDyDk4CyOasLpfhsA/Lgxe4gbokN9V/k8PUuU4YWAZgn9l7+7+TKAjOHbd+FCnafRXUhx0An91RKGP+UAFsOYNHVr6WgV4Z46IU1SdHhiKItQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nRWcIPfHSb2am1ilHJsClnMYa3QyedOwxaFuNVgaP1g=;
 b=Cq2sjxixZQ1gvp5S8BjcmUDD7KzRxbCqzr6xjdYU9vaQSenY3g5Ue+VpvVqFKM3GPrmgG+on4guSBYmjRk8lbAx8JCXmsq2RgQEC8giW4nSb6ZKgED16klebDLieQf8K+NTPur7uUxePRKE52xfhZRxmZRm3K1dk8LGTrJxYnG2G1MziRwZVzCXDh5iUYbSYFB8jOmUnvbxzce7J7hs+04rRzmc2Bg46255lr1NPfE4BrEgK7nKuuzyi++us33b8at72yjjfYcbrEvpntC6l4nqy4fsY3sC9L61gq9MFI3/vsxmd8xGCwXmSa94AQnT84EkYhWY7JSlp6JHJiLtBcA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AS8PR04MB9093.eurprd04.prod.outlook.com (2603:10a6:20b:444::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Mon, 9 Jun
 2025 02:55:28 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 02:55:28 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Thomas Monjalon <thomas@monjalon.net>,
 Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Ioana Ciornei <ioana.ciornei@nxp.com>
Subject: [PATCH v3 09/11] net/dpaa2: retrieve DPNI API version at init time
Date: Mon,  9 Jun 2025 08:24:48 +0530
Message-Id: <20250609025450.3997062-10-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250609025450.3997062-1-g.singh@nxp.com>
References: <20250602104041.3322164-1-g.singh@nxp.com>
 <20250609025450.3997062-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0015.apcprd02.prod.outlook.com
 (2603:1096:4:1f7::18) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AS8PR04MB9093:EE_
X-MS-Office365-Filtering-Correlation-Id: 3ac57bdf-ed34-424c-ca0c-08dda7011737
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?hA6PE0ufgULW3rSIwLU1R7gO192qJbtgyNp+NLNbpS74phMblHQfqiI4dEQd?=
 =?us-ascii?Q?+rRhJd7Xa5yiiO8r5qAHkiguSRmN7+2uGQJgoPrwqJAOwaA4z/k+YV0soVtC?=
 =?us-ascii?Q?VJ5YRICS7x3MOCoMG2DxP88KpgVZB+38L208ZJaBdwtH3TRmPgvSyMDh8fYR?=
 =?us-ascii?Q?/1xrpTO0j4AZA1d6/GK536mHP24vEbNH3GGaOG0TUYr7PuIJdxVTr3ettCPT?=
 =?us-ascii?Q?IaZkzTXMjddz3frSI3lm1y0GRuyh7HcS6hXOiaLCWtWFc3wZquu9nE6/eDY5?=
 =?us-ascii?Q?cKi9dvBZeCGy1f17J2n/M+5QtckiM7eJNfbNLmZ+uDmMQ5/BryMVRl4oV6N+?=
 =?us-ascii?Q?uZ+f9SDv0slP9NQbC4gnpVR7RuhWn+8HVssThXV+21lEIO6kZeBxSJS0W/Xx?=
 =?us-ascii?Q?6FrXno+5BBcEjLFXbrjqpaUm+jZVVrEr4T1L2fiUgT/viFnToeIf+uydzAGA?=
 =?us-ascii?Q?bnz2RQg7IgE0emyxngNzSVdHN4OnpXxojiQJ7V9HBjRT8ipSiBc/clSrQXd5?=
 =?us-ascii?Q?1Gf/gYM3/Z3y1l2i0isg8DIN10XIFtfA6pCv9b89+IC3uZZCQLDfaE3QREBl?=
 =?us-ascii?Q?urnNA9z5bQiKIggR44lGcs2lWbyqYx3+EW93l+dE+bIGQsj6LLWZiELq5kNx?=
 =?us-ascii?Q?FkHWq9kpbdp4Qd6Za/u10CYx7qX5KmLyhTQ1yawxa1MueegwnPQZwlnTu1du?=
 =?us-ascii?Q?nyVpCqP0E4zH2YBAaLsB0SGHXP5RUyXSzKY7aPIGfs/ckcTY4tfAqSZ4T/wN?=
 =?us-ascii?Q?py9OMcRMrntNV09jBzdy9NH93fix7VmnlxJuEsnNdoyWwz/PWWXtuIgCh8z2?=
 =?us-ascii?Q?8ZkopjTHaRRTvt+bSRL6zi4SqKXG4O4xT6izAwT6V2uVKoRbFhYuxEZ4VOLB?=
 =?us-ascii?Q?MN8ofJmc7Ygqxca2ll8t3lPOf/ZY3r2V+aYP6otuqIvJDo82fN2EtHYOCv94?=
 =?us-ascii?Q?Ebd3IQXxmDgfVzm9nlOlE6RuKAcozKx4hCoyDtfESpPL/KUava1RfiQ+W0CO?=
 =?us-ascii?Q?mudH6rBraPvZkt4Kn3OTdeazVHCgcbW5lYaD4bm8a8f0dtwGVlvcv4L5kIxl?=
 =?us-ascii?Q?Dd0w+qI/bZy6vt7xbFgmzyH50d2F91OxB1xOsOHgfTaYMhFnV/8r0aj/wA9C?=
 =?us-ascii?Q?VDwcEwxQsu5odFqX4Ah4LYHNyeB/AIlFkrxjiVX9SvhmBMocojwIzl/Ecn0R?=
 =?us-ascii?Q?kvGJsDfpW0fTJ3Te+u8DwZrYpwRKBIkG7+p+dlAlCUDSOXnojb7zgMIOw6Nm?=
 =?us-ascii?Q?UwJ/Zxvbu3YFoAb7JccHkTSkjDteAdJd4e7iaPO3B3hfRa+WQLid7qWcVr2l?=
 =?us-ascii?Q?8SGWhFTQqFYQPCshaPrGhHdkF4lz5YPIIrQFMU83kzUYeccuMlv69Zp0c3Hl?=
 =?us-ascii?Q?RvP+kOYNtjUUOAtfw/NBfVb1UxKzL1zn+mnp8T/In/ioBD3oH5baRVHgUQ/u?=
 =?us-ascii?Q?ihp7Zok2EWm8EBSte9IaMx/G/Mhfw4lCxaIB/cy3KaGic42RtJuqMqgkuapw?=
 =?us-ascii?Q?Xk1UOX+ISEH+NLs=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VM0/xbOUfV980l7hjLKLD3ku8cx5movf4wHivZW1GWWFKzmYYtCuufsivAjA?=
 =?us-ascii?Q?jRZyCccqrDR+kqDn/3EiaaXdobGKTJrbWvVl2obK1YndqycOcsOqekHWK3V9?=
 =?us-ascii?Q?mSx2d35/dFDQwScpe62eCYVUJhVRKvwgQ7vZaFQXfMzggBB9R3qTvNj6h6G6?=
 =?us-ascii?Q?18OmLKSgnb3tOH3Noarn6DYOM7qAehpgwYIcZyb6WheCYg6kOOHgiDpOUVAc?=
 =?us-ascii?Q?5LCg18r98dZ0UvdS7zgxULo34Il7fsFGlW7pb/kE1QRglsXULWl+xbfrLkNb?=
 =?us-ascii?Q?zhelCwrJXICkQbWti6OPKNxQV4MoUl0MLFjWx1+QUWilhQvBw0jqZHrsKQ+t?=
 =?us-ascii?Q?770dwrhzci7egcd0129G0927Ag1FTJ2479r5rqBTzJ9Y4ZbENwbYLwLsx7Sv?=
 =?us-ascii?Q?6cGaZbTuvvUv2JPuArWz4uZydhr9Eky+9aCAEZPHqVdyzeIxLc0Svj/Tv8y7?=
 =?us-ascii?Q?7Y0R9+X7ou9/GnXOd0GBIWuWld/zIMMJ9kTV1XfOpkHDmDPT/BGwwSTjhWhW?=
 =?us-ascii?Q?YiM01KGFVmwQCoINvajcKbfcGlcCkqRKwVY3pzE52wmYiF1mG5NQPvQB+IEn?=
 =?us-ascii?Q?Xe1UR2z2vLKAWbOKbq12Fkgn0j4gJ9b7Qc45EocEnVDFkUyZUpM8MMdClQ16?=
 =?us-ascii?Q?eYzWHWIyaYLAablijVwVIvQpR1b9lGOGG/WFPzGowwMwM3wNH72l8bG1IECZ?=
 =?us-ascii?Q?LB0SpMIxRHtPFJpAbA9CNiKIw0uwu0N4OqZIESbCWBpxDFGf99Eb8LmaJ5Zm?=
 =?us-ascii?Q?K/045VnLeZN9L09euv34KggA6IIqijLj8Bi+qpX+Ip8M4CQCDSMUOdj9rIxm?=
 =?us-ascii?Q?D9IwHlDee9pJPx9KA6QI4EFZavoZ4qsCRuIJUh1TYuEEKKbOxXVSvvkhyrTf?=
 =?us-ascii?Q?jUJ1HjvJFEFLZVvf0sxMHiAf1KrASQYZh55UCmHzgGae6jHNhm52GVe9bU88?=
 =?us-ascii?Q?dEr8K9vr/QOYzwbEG2LyIlDuXXshwR2O3kPuDV9FfqveJjuNKvwPvS1/kSL7?=
 =?us-ascii?Q?ljj3D3kSDrVu+w4CUw5c1/QiVDbumS2/zC2BC2ojypqWY8nIq6pm/OCzyTqR?=
 =?us-ascii?Q?dK+W1lmRkYkyY7x5YajMJIO1gPuDlVIjoPjJxyS50qQMsetJI9Nae127TozT?=
 =?us-ascii?Q?Ke3c7w6Iti8/PTNYYmsKztwn7KmWfJNEdITAzw4RRBALSWd8WzO7PogDprmR?=
 =?us-ascii?Q?iq8sV4Bl6XAQNmX3E51DtPKOahZOE0SQ5oJfuuwL2RlfcA0xr2AGqFKBCuAs?=
 =?us-ascii?Q?MLdF0zkfEUMwgIfYpda9McSJTB/BT2nD5D+HIB+0RnvTll9Im/SLggl+0pqU?=
 =?us-ascii?Q?6LRR3ljZWepRhtf8v2kxgyXqqFOzzBCEEuLATA4nFxyML9mWZT8hYSUjp7AF?=
 =?us-ascii?Q?moN34k01gzrx2qNiViR37+H50pyfmxyJCWOodfB5NAqmajK9fJpkk0Aw3HeQ?=
 =?us-ascii?Q?cEWgP/xTplCwtsrhBulVEwiqf+zE9ND83zEQva1JqoA0Bj8GBpEL08a4tXFm?=
 =?us-ascii?Q?bemtdss8RIxHIMw30isH9AwqQtL4C/0AG5oyJwFynJG9fgah1pynLXO7gVDB?=
 =?us-ascii?Q?R73TXiea5Yo8d1mVKJ0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ac57bdf-ed34-424c-ca0c-08dda7011737
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 02:55:28.5948 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hVN6u5NlI0/GJNg/xcXmGSioVd0vaLMJ1KGTrER5/YuuZgQDLfURNpEITqG52JRK
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB9093
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

From: Ioana Ciornei <ioana.ciornei@nxp.com>

The list of availabla DPNI APIs depends on the DPNI API version
available on a system. Retrieve the API version in the init stage and
store it in the private structure so that it can be used at a later
stage.

Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
---
 .mailmap                         | 1 +
 drivers/net/dpaa2/dpaa2_ethdev.c | 8 ++++++++
 drivers/net/dpaa2/dpaa2_ethdev.h | 3 +++
 3 files changed, 12 insertions(+)

diff --git a/.mailmap b/.mailmap
index 91e08f4a1f..93905921b1 100644
--- a/.mailmap
+++ b/.mailmap
@@ -606,6 +606,7 @@ Ilya Maximets <i.maximets@ovn.org> <i.maximets@samsung.com>
 Ilya V. Matveychikov <matvejchikov@gmail.com>
 Ilyes Ben Hamouda <ilyes.ben_hamouda@6wind.com>
 Intiyaz Basha <intiyaz.basha@caviumnetworks.com>
+Ioana Ciornei <ioana.ciornei@nxp.com>
 Isaac Boukris <iboukris@gmail.com>
 Itamar Gozlan <igozlan@nvidia.com>
 Itsuro Oda <oda@valinux.co.jp>
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.c b/drivers/net/dpaa2/dpaa2_ethdev.c
index 298fded65e..b88c9d748a 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.c
+++ b/drivers/net/dpaa2/dpaa2_ethdev.c
@@ -2814,6 +2814,14 @@ dpaa2_dev_init(struct rte_eth_dev *eth_dev)
 		goto init_err;
 	}
 
+	ret = dpni_get_api_version(dpni_dev, CMD_PRI_LOW, &priv->dpni_ver_major,
+				   &priv->dpni_ver_minor);
+	if (ret) {
+		DPAA2_PMD_ERR("Failure in get dpni@%d API version, err code %d",
+			hw_id, ret);
+		goto init_err;
+	}
+
 	priv->num_rx_tc = attr.num_rx_tcs;
 	priv->num_tx_tc = attr.num_tx_tcs;
 	priv->qos_entries = attr.qos_entries;
diff --git a/drivers/net/dpaa2/dpaa2_ethdev.h b/drivers/net/dpaa2/dpaa2_ethdev.h
index 570b1608a0..ee5ae3b70a 100644
--- a/drivers/net/dpaa2/dpaa2_ethdev.h
+++ b/drivers/net/dpaa2/dpaa2_ethdev.h
@@ -394,6 +394,9 @@ struct dpaa2_dev_priv {
 	uint8_t max_cgs;
 	uint8_t cgid_in_use[MAX_RX_QUEUES];
 
+	uint16_t dpni_ver_major;
+	uint16_t dpni_ver_minor;
+
 	enum rte_dpaa2_dev_type ep_dev_type;   /**< Endpoint Device Type */
 	uint16_t ep_object_id;                 /**< Endpoint DPAA2 Object ID */
 	char ep_name[RTE_DEV_NAME_MAX_LEN];
-- 
2.25.1

