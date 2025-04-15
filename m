Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A5AC369B4
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 02:55:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4DC1340665;
	Tue, 15 Apr 2025 04:55:25 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2136.outbound.protection.outlook.com [40.107.101.136])
 by mails.dpdk.org (Postfix) with ESMTP id 10AFD4064F;
 Tue, 15 Apr 2025 04:55:23 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sWGfYhWZDUCVg/yEWfqQak//FOoo86eEAoRoJl05SojUSNmb7ve86e9+7w95wf8K6q8ojXiHO6vUXtOdpgc3D3+qNkrxT4fJAjiA6VYCGVN8cYDtC7u4XwPHzokacLMIeogpXP1YFrYtGGPTRM0DTIHXVzvJg7BXLccsIsg/nw2WC5y3kphuIT9DJM52z6Nj0a+h3xg5AA0eKPqppzvrS36TUBtMFkWQEaXK1Zqutn8DujNDcXsB2SjPtavZLIxX4eOszHQjA1Hz+cZT23xfOi//ZvWFmSZloImwlkVPPSHu7eE+9CUSBKi7FF3PD9p7Y7yTaEH9sTQme3xctouMWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iJqRxw2npueUL1auB63J7LpWHedKlP/8dy/ZJiTIf+U=;
 b=rtIiTZCqjKNhkrrLIH9URZbYHBjEEm66Cy09wJnzti06lh0nH64vYL9oygB6xW601ZRZczXH8kJ0PEsmWGAb4CxfQ1k+tNd5fh/IqndR4lzxoxleJHKEPH8OQdJTJRN35Li3FkdARG3G9+ude7DdmCclkXSDKnFzLot1z3VU7jvxa6fVD3ZdsaCS3fu9fdmGIcGama6SkpWTrEgwF3xgyl4VmxPFkyqrLB1lytHJgS9mRtWa/CLvScnuUOTY0hVQf8Pbc8KH9X2NBQIsUlxCkE8yKgIEuK8RcPAPKI1hjLzPsfkwLgDDvgjFhZzRZiAwu4XM9GZ3pjYerIjLkux29A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iJqRxw2npueUL1auB63J7LpWHedKlP/8dy/ZJiTIf+U=;
 b=UbshSJZTTWyWGOuxUfmRchpJ/A/wHxR75a5AaexlpkMnBVxZSihT38VBwxPgLi66cQ0g365b+RoqcKIzhGssHZy2kK/1wba5uBUfAkzKBqCfhIPEmlXzsIozyrwsRqUPZVhT8t4aU4UYENo5VyXnvXjFrklfrXDeSePPzHBdebg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com (2603:10b6:a03:424::5)
 by SA6PR13MB7010.namprd13.prod.outlook.com (2603:10b6:806:40a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 02:55:21 +0000
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833]) by SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833%7]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 02:55:21 +0000
From: Chaoyong He <chaoyong.he@corigine.com>
To: dev@dpdk.org
Cc: oss-drivers@corigine.com, Chaoyong He <chaoyong.he@corigine.com>,
 stable@dpdk.org, Long Wu <long.wu@corigine.com>,
 Peng Zhang <peng.zhang@corigine.com>
Subject: [PATCH 3/3] net/nfp: standard the data endian of NFDk Tx descritor
Date: Tue, 15 Apr 2025 10:54:53 +0800
Message-ID: <20250415025453.1348238-4-chaoyong.he@corigine.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250415025453.1348238-1-chaoyong.he@corigine.com>
References: <20250415025453.1348238-1-chaoyong.he@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SGBP274CA0018.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b0::30)
 To SJ0PR13MB5545.namprd13.prod.outlook.com
 (2603:10b6:a03:424::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR13MB5545:EE_|SA6PR13MB7010:EE_
X-MS-Office365-Filtering-Correlation-Id: eeaadfbe-5988-48c5-9e48-08dd7bc8f662
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?BiGRMA5hk/0scJ80sVitG42KWNVbFO6W0AmOywIk1u3u32mBH2nKWLMHFuyu?=
 =?us-ascii?Q?mavohH/i4tTrM7f2nVp97EodOmSFeNYf6XMFf+FgEyHAnWebCVZUNGHNQXnM?=
 =?us-ascii?Q?kJBmv3tH6qOLg8zySzMkogttkyjoEtGR64Gy6qGt+Qs/63njKNHBcP1pKvJI?=
 =?us-ascii?Q?bJE973zws5uZYl5H4/oeFw1cLUj8eKnW4y8A6VPWCPZdV/qhalKHi67w7JhS?=
 =?us-ascii?Q?2Vwl7QOooBSRHaynG1QOFmYlfekk3KSqFNQcvMtgQd7S0Yx5htCBooR5irUb?=
 =?us-ascii?Q?zjSG7zd1iWDn1uFVBYayAEUmKCPkGZnWyxwmGdplocQF1R9/+QR5RfnFKFji?=
 =?us-ascii?Q?+5e1fnXHYrI3ujDsmVLwlMbar0qXUCOjQth+aQBuAz9Ejjz+yrAqrYIYGJFI?=
 =?us-ascii?Q?0ze43F06zwg7u/FQoBBFJQfPvTy8fhCRgVAbksp12C9WjRGnQnXvyH+7/kuE?=
 =?us-ascii?Q?KWEoQTXKu1yeazQEIYr3hBCG1dlNfW7o3SQ/fnINtg04asrZWK+j4Fz/CoRR?=
 =?us-ascii?Q?6Os9dsCJoSbAdoFeycj6U0svX7iokS6JDo4xVmKwMIXPRva6Asl2inMjGfe4?=
 =?us-ascii?Q?/HYBmM9xX+ZKZFU3/skiJaUY3UY3PT1OFF3oWaPxqQfrulQvp7VyiTim70f9?=
 =?us-ascii?Q?1MDdMR4Bz5l/4BaZpZYMfmaM3xZbelJIkE/rF2qinkl4kYWth2duksvxr4zO?=
 =?us-ascii?Q?UODmiOC0b0EtMCWyosUWPdL62Rh56WPd6zlC3lTq8+/+bSqHUtsD3Lh0BDhP?=
 =?us-ascii?Q?05Jg6IzZc0CHWKs2+mZnjQbOj6EDiUJUDPCHKBaYrRKZcY7+8urTAiYfkEpF?=
 =?us-ascii?Q?8oQE44/iq3iCG7wSx6LpWgsh6lDqOMEKxBqnQbC4ixpxiSa92K251/FsT6RF?=
 =?us-ascii?Q?i7ncNNeU+OikhUdTn4EvfG6BDoLFqxL2qPA2I8EqSSEvB7+XBKAfjbMa1LRv?=
 =?us-ascii?Q?LuJaNO4M8LpIwrat+CXa46SY2ZLb6yGf8lQrT3GYrkeJebh/tGMwNo+qT/Da?=
 =?us-ascii?Q?Qi+QDnXVn1/jGjSFz1dk00zwYm7q6qeXOATdXf6h2J4aTs3Jv69MNCsalDsA?=
 =?us-ascii?Q?60ld5UEeCh80AskoScrl2zv8VEzvCcAGdvFHrYwYHhByQSzHyKFKA0PFdYOe?=
 =?us-ascii?Q?JK/ESWMQT5s5wnawGrVyFXTM/9dcyEkA/JTjhO2ek57nHmhI8VKiqSuzeafN?=
 =?us-ascii?Q?pDu0NCv54BJfIhhppYs9WCobo4WKMdiKkxZPzwnqSE/5pU/FDI9VJef1H21J?=
 =?us-ascii?Q?ZkIL/jMo1l7aWtJGdwDvU9ZVsyXKHhDROn+W/oGoit7awsxHJpoKANEcIP7j?=
 =?us-ascii?Q?ks+VFcyHRrztVIn73EHEKh78R9rzb05CkSJ+sck/5n94AeGr6ivTD07LWc/+?=
 =?us-ascii?Q?fG9GDmd5YGK7QZNeNcm/ekQmBrByYwcTkmwKD9p/6DtdQT++CWmIQV62va3a?=
 =?us-ascii?Q?EFnE40KzE8rVz1WeK4XhWIsKgPrKgsKsQKV4dMVI5/7qSO1IjXwCXw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR13MB5545.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?AiDf3lcfzerkJ1V0ZDv32LG2Z6wD5g+oRpLycXQP5ssXDibCnyIEoXobf784?=
 =?us-ascii?Q?73+ZKV96oDaJ3lSnuHd7q+UMM5nliv5AEAQoahk3Vz7t8rgIoFnX7hRPTAke?=
 =?us-ascii?Q?OnZeGIVDXo76CwN5ujvTACV1J2jYZJ9n78jCypHH0+nfYwxNNi1CoDUHPAe6?=
 =?us-ascii?Q?e9l7XOzlfM9CtecwiCwEDyjcCgYnZK2LaDLuOdgdYUUoo3Df1aJRe5Br8jWO?=
 =?us-ascii?Q?fLU92vIi1jpMOpoa+9j4UsdtW0P5o/cC0+Wh3EfDOT5zb1B6y7U7iiznH7WL?=
 =?us-ascii?Q?OMkxpzPr/lrrFctxkMEXQuADNf67h2+2UwXvX/1KHhI5WIYV3LGu89dT53uu?=
 =?us-ascii?Q?cXHpMuaPuItiQtOhHdHhp3/oNd5t+vu6osUU5GKnD8cGJoAVTqMXRq5ZVfEU?=
 =?us-ascii?Q?CmZ/GOjPILuJ0+4u2/NLidxh9IrRckDKFuSlJj4RilIBWvG3G+Q+TroNlU1P?=
 =?us-ascii?Q?Swy1mgYoQS3uN0+sX6awIGyIS75KtD8A6C/3QVHnxJwsgdABm9Z8xoLO9t3i?=
 =?us-ascii?Q?MOfacb2R8eRZp8rHsV9ykap5zLSzOuoFUIpQmvoSWBgOvOvVOSckDfZuoXNt?=
 =?us-ascii?Q?sxJQCOfcT+8wM07ivOQiMOPNiu7nQBr3vRtidtaU60nrqHNgalaxHrhxGM0r?=
 =?us-ascii?Q?AR2Q0rtyQAV5S7C4ydixzDxPKJoGiCGqx+C4RpkDp72CtVlPc1P036U2qgqt?=
 =?us-ascii?Q?u/KnVbmssDCKuoDnIRS3pWWWemX+6zTS9GpWWZ0XXt4Df48DJ7x1cFHlbtld?=
 =?us-ascii?Q?Gy8yNiiSSgmdDtG6Dh5esgr/Cm4o0RJrfyBDFXHc/kDu0wN9uiEYmvFLSVUW?=
 =?us-ascii?Q?Z9cDeA+9JeeFqFuN+r6MzPYNL68AxqxDu2ivTuAsKhOWFlHHTNCtvO9NZIm7?=
 =?us-ascii?Q?Rnkni9KFnDqmsX5muuNtgxzF39+3wWSAcE35MVTQVNcb0IG4zdJTpFuMe2an?=
 =?us-ascii?Q?pooFGrm0griUfgJcr69+nMA77Xfppuf1NPVG7OWQYR933N0fYdwQqtOZ/71w?=
 =?us-ascii?Q?OMtC3L3ZHpYNu3qLFeqYscR9KMPJYk3JSTPjQFVtENd+5HIjhkVPMwbsX3pv?=
 =?us-ascii?Q?/4AXMaibH8lo+uO2T0ASNOH+pzVHKfoyuPJZ8CE0pG+XLK9sxJvSNjCBce1s?=
 =?us-ascii?Q?3CKPJ2xblEE1GZYlcb3fNb2CNyNL8ooFSJoj0ltHyLe59yrLXFZB0k04UnV0?=
 =?us-ascii?Q?gNolbU/A5gcnn1ky5jjjbZSK/NtxKbKB6KIQusryiebuvNlSurweulKVEwg2?=
 =?us-ascii?Q?TAWmzZd5LSRVosxhNTTvTgZ/zbRP7AxU9D4VCrokaPUZKj2fcpl/xBXpmCz0?=
 =?us-ascii?Q?sRfb9HZWq/MCosNy3mgr5DCcMiR0YRpnvXMrbCVpah5cI1JlArD8qCyW9jdi?=
 =?us-ascii?Q?kAUs76prrYJCeqhEz2UmUbsVp6nQo9nChmp48oaPEeZqmbH5I39VoM9h2JFX?=
 =?us-ascii?Q?fFrHfIeyuppza8FQSi3M0HAisFkaaju7RCb6S6bmuc2RKHKXDH3FozCQfn1U?=
 =?us-ascii?Q?jXD5OLiOjPu7tco0lTmwRJnyHcONzZB9uBcyKKvX0NkNuby2O1XvB8wKgTvH?=
 =?us-ascii?Q?pX7k12QIAZC7OGTHisL9db3fjHUlHVbNgVbXYeKOBO4A0sE3M6R5bc6pQHjv?=
 =?us-ascii?Q?2Q=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eeaadfbe-5988-48c5-9e48-08dd7bc8f662
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5545.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 02:55:21.6491 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7qfBLcCC3UGkKsE0/L/FMvHj3nf4dop+QxSV/Ft75oXhmvI0tCKatMtqN0Y0DeT8wyYUzjKm9Rk0tzk2gToNYv0/Me/3hXDf0fAv8Auj6rU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA6PR13MB7010
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

The data endian of NFDk Tx descriptor should be little, and the related
logic also should modify.

Fixes: d7f6d9b21ffa ("net/nfp: adjust coding style for NFDk")
Cc: stable@dpdk.org

Signed-off-by: Chaoyong He <chaoyong.he@corigine.com>
Reviewed-by: Long Wu <long.wu@corigine.com>
Reviewed-by: Peng Zhang <peng.zhang@corigine.com>
---
 drivers/net/nfp/nfdk/nfp_nfdk.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/nfp/nfdk/nfp_nfdk.h b/drivers/net/nfp/nfdk/nfp_nfdk.h
index 29d862f6f0..64c2b31308 100644
--- a/drivers/net/nfp/nfdk/nfp_nfdk.h
+++ b/drivers/net/nfp/nfdk/nfp_nfdk.h
@@ -109,19 +109,19 @@ struct nfp_net_nfdk_tx_desc {
 	union {
 		/** Address descriptor */
 		struct {
-			uint16_t dma_addr_hi;  /**< High bits of host buf address */
-			uint16_t dma_len_type; /**< Length to DMA for this desc */
-			uint32_t dma_addr_lo;  /**< Low 32bit of host buf addr */
+			rte_le16_t dma_addr_hi;  /**< High bits of host buf address */
+			rte_le16_t dma_len_type; /**< Length to DMA for this desc */
+			rte_le32_t dma_addr_lo;  /**< Low 32bit of host buf addr */
 		};
 
 		/** TSO descriptor */
 		struct {
-			uint16_t mss;          /**< MSS to be used for LSO */
+			rte_le16_t mss;        /**< MSS to be used for LSO */
 			uint8_t lso_hdrlen;    /**< LSO, TCP payload offset */
 			uint8_t lso_totsegs;   /**< LSO, total segments */
 			uint8_t l3_offset;     /**< L3 header offset */
 			uint8_t l4_offset;     /**< L4 header offset */
-			uint16_t lso_meta_res; /**< Rsvd bits in TSO metadata */
+			rte_le16_t lso_meta_res; /**< Rsvd bits in TSO metadata */
 		};
 
 		/** Metadata descriptor */
@@ -130,8 +130,8 @@ struct nfp_net_nfdk_tx_desc {
 			uint8_t reserved[7];   /**< Meta byte place holder */
 		};
 
-		uint32_t vals[2];
-		uint64_t raw;
+		rte_le32_t vals[2];
+		rte_le64_t raw;
 	};
 };
 
-- 
2.43.5

