Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 357D6C7EE39
	for <dpdk-dev@archiver.kernel.org>; Mon, 30 Jun 2025 09:58:48 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A7274066C;
	Mon, 30 Jun 2025 11:58:32 +0200 (CEST)
Received: from DB3PR0202CU003.outbound.protection.outlook.com
 (mail-northeuropeazon11010009.outbound.protection.outlook.com [52.101.84.9])
 by mails.dpdk.org (Postfix) with ESMTP id 6AC7740264
 for <dev@dpdk.org>; Mon, 30 Jun 2025 11:58:25 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hC/Pn0ZR0q9bbSutAPFkftxBn1uc44rbwHzL1w+4HQBt1bWluNmESBCf2kNzpiFKCSlre2UsAVB41n9mipv/4tk+WD1TDJ5CPaH1kj8XxDuh1eiIR+TeUK3OJx4GqEO7Cf6G1MU6URWnMBYGzj99lhfD4lU1p95k9fnscLjLgBqw1SHe4eVbl92lvvdAifl+iFwcjUc4wF4/9eE99QGMQpMPKB1mkdvghbQKm84WuhDvhtRbXI4/eZV3u0IaCi0RZCApG3TSuMRN2F5vGkkF0rVq5Ly7e6/aPaTEG5dMsnZ0BULEUW/uUSD27mypxkFlV9OJquBZ3aYfkQMooIGslA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhbfsn9nCZ2Vkm2EjCnZRBDP2EBIlAElSJtgXdlnnSk=;
 b=KEyp2MUSsNxZJROB/KygrAhe9ip2eYLPnpWBZrcjwPwEUYsR83cvQtdRvEolj6YEOi5g9LBjk8btgNRXhYqimH2BumJoFmNNnTcvQ3pMwfoEcMHcYJVyfYXD+H3mTCgHc2+BiMhh1TpzAR7Cm7P8XtjTbdWiw3wQeCStDk3bq6ui45/3WI7nLE78nV7MC7f3Y0B7tyiZn0ThRZhXNX611lM9eopAThisJxunmDlLEqyESfp9ObujYjGhf3LInQH/l+TlEPqZZfsyQ9GyPTkZPL7uKjQswWVolYJV7DZttZiltBIuSAHWivtEyBDW7SwgGneaO+zDI4+gJi6UsRVtoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhbfsn9nCZ2Vkm2EjCnZRBDP2EBIlAElSJtgXdlnnSk=;
 b=NEl7eJ8FEr6927kVgWlRsDYGH651SiD6O/K3QmjliAFebLLPdB38Sg09DV2BiSkZye2XeiQ2TcIzn+QBbOqz8eE3gYZkOjdGddyVLMd20+xuHJpkzHYUB5gCW5ejxoWs9GDfIMKmhZPs4fYQePcDb7QJBLkDSgT82iMD4ZqRpfL6369G1XxFJ/alUOTzW+K7tIL9C2KIzRSemGx4OB38cm7dizr8sNrvt4e1Wx/7u7zd/0DLltywthKGHYgpNX7iHJr7LAwFPA2YMCunYNMR06P6jKdRFu6/GqgfFEkpQ+aex0t5yXAFbwjwnfJmhZg/55N4Xy5DFeUrnPviE1Zegw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AS8PR04MB7894.eurprd04.prod.outlook.com (2603:10a6:20b:2aa::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Mon, 30 Jun
 2025 09:58:24 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8880.029; Mon, 30 Jun 2025
 09:58:23 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v6 4/6] mempool/dpaa2: use unified VA to IOVA conversion
Date: Mon, 30 Jun 2025 15:27:58 +0530
Message-Id: <20250630095800.2943863-5-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250630095800.2943863-1-g.singh@nxp.com>
References: <20250613021125.790614-1-g.singh@nxp.com>
 <20250630095800.2943863-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MAXP287CA0016.INDP287.PROD.OUTLOOK.COM
 (2603:1096:a00:49::34) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AS8PR04MB7894:EE_
X-MS-Office365-Filtering-Correlation-Id: bd4a0dc7-15fa-4f48-d014-08ddb7bca67c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|19092799006|366016|52116014|376014|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?up8bcGcta1tJC8ZrOYIiRfAGsdGpjR4we6bDc1Q1lDQ7LPFzxfstudhpJ30O?=
 =?us-ascii?Q?UnL/j69riWKUiSgWHjFddQyk6aQxF35cjRHc1MTzxe4YTbdxliwcBW7jEtsZ?=
 =?us-ascii?Q?jiaxYyQkZaNvUNJiM4CPnf02jNZDV5bNm1O4gg8MazhGyc4pm+YlV5jCCNtK?=
 =?us-ascii?Q?umjICi32bb0DO0H+FAoLRQoFyGiOwEJXVWbNRidrHudF6DapWpk5a6/QORmr?=
 =?us-ascii?Q?mMCYCG5OaJULniYpXsjR6Nsw78+Dr4Oj/Y56pxKYxBcC32b0cXOx4nb4wLtY?=
 =?us-ascii?Q?nWLnrLo4wH/ePbmazQ677Lr7pJzijB6j+HmqlaNPWrS8oyI/GRZCsvzFDR25?=
 =?us-ascii?Q?WxnbGxl6k19Tk8ha6zZxxKAcXILRb4vD1UMVfx/wdETLBF5c+LZcV/yf07yx?=
 =?us-ascii?Q?Amcvy8qbW96hp4IxQbZUztvHTLqBLXST4rpJV8MHlltLpVhUUhZ/uNzVQtL4?=
 =?us-ascii?Q?nBMuRG4pKW+KOz82N0hE+5HabE3Aj6fxoBW8B+8X85ccr07V0izG4MEsyrrO?=
 =?us-ascii?Q?9JD0NslKIO9vn333RMqWFgMCCiW+e8hEG48yzQ7AuUA20IXdykln7Zd+Zpy8?=
 =?us-ascii?Q?J71TrcJV9j94EB+Du20Cbxbgp/BOzWtAOamGLPZc/7uBXXvB4u1Sxuobx6by?=
 =?us-ascii?Q?ucNLd3R4tqqmHuzXkUZzQwhv38JSiyv8vCZZx9/xrGdo9Ysc2crczbFEzNJW?=
 =?us-ascii?Q?T7iB8/9eUweWqBVIvN7pcsoZWEYV1JmTI6lB4sLdwelyvqq+T36YpcqhCWsI?=
 =?us-ascii?Q?aWKlV5NmYF+Obj9KSbLMRWW7OqVC3nvweKrpQxodkbUKAyc5B7y8q7C3OR6Y?=
 =?us-ascii?Q?Iqg7nZ8gwIZDvbRxD2EByLvf2cgBUWdHeZF3dHMKy0ITEoPUQAuhQGtWeNhb?=
 =?us-ascii?Q?ho6nQPpt2E31/WgSniSPqci5IUcqPnvB3U8faQmew8XYY2zlPqp4yVOlzrqh?=
 =?us-ascii?Q?yFQr3KxBetZ5gjlonbvC4bPQw307byapEPBi2u0DMuASX3yBNpla7wjDBX0h?=
 =?us-ascii?Q?NAzag9o1lOtb3IKORHV2i1sad1VhVAIbBLRdV/l+RFqT0qOIeyiAFljZFezy?=
 =?us-ascii?Q?3Ea+B2c0tEuGAgMAFwp8tWU9HUO610+AKHYxdupLE3WvXcFFEIm54gcVHgpb?=
 =?us-ascii?Q?umOjMoFiVUrSq5dpN8yvw0/7sZ1E8H/beeO22cpdt8bS/6biXgeflGBjdtBn?=
 =?us-ascii?Q?7N2UlJBKefCEWQfhgWNAjviC4o3QlnRvxa8hmv7UMZ59Sw5xK8J8e6+wtXIr?=
 =?us-ascii?Q?DwPnOQ4sxf16V/WBvqIxn2EQDy84WnbU9eIWgUGVWHIGnX2oAUcMW6h/38jl?=
 =?us-ascii?Q?9HtyCgV4R8iZ3JEfCJ9rUTLYAs6AIj1Ta/+yXa0fwnYbTAz4CDOOSJVyToty?=
 =?us-ascii?Q?SPKDRsNSdyRb0E/vcqtQuG63sOXujklPyvhB0o6MYRWh5toqffOPOr/aZR4x?=
 =?us-ascii?Q?BnTv0l9/A/dW72JQh2VX0LS6ToBPK0htAnavNXVczUgO/0tMeh7m0rqyfXCL?=
 =?us-ascii?Q?jSeEhZgdKvHskKY=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(19092799006)(366016)(52116014)(376014)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BQPb8tEwgs0FuIX3ITIr+rhXvDPODl+4ziDefkOxyo5bIM7OWK+VsdLJnIWR?=
 =?us-ascii?Q?tKLdwPjuciuWAVhbOhKkgMiW3/+2iJkCTab3H9ESQBeaNWuOrX0aVx1vak4+?=
 =?us-ascii?Q?xLaDJWIzoFuRh3Kt0dc1CX0CuKKPUZchfOL/XkpoER7Scm+BUDUBNoG4Yjwx?=
 =?us-ascii?Q?WD4ljxxPBiToDqfEv5GsYx/0I0fRQw+ohcdfr9W67+/QeHKAEeInyP7j34Ja?=
 =?us-ascii?Q?GViCzeBGNKvut6UJ5ooLny7NlhXgdfLE9cXbhC7R+cPZKP8RBQZicwzKVUHb?=
 =?us-ascii?Q?CMAOiTldTUNw2MPARnwO+aIAvFNCP3GQ6LmNGCWKdI5Ykxf7m+UHGO2daEa3?=
 =?us-ascii?Q?tEKSKwIbnWyr9gk0+N70sNB++D1hRDDMPW7EV6Jlw1hbYx56D3RRlyl80nVf?=
 =?us-ascii?Q?aYcgXMZPi8EI23Wh7bWQ2GPNKvbJqY5hGh70IHQCDcnr3nxoVjSv6+jOQAT9?=
 =?us-ascii?Q?0BNEEnv1MIwDMfzL/u8VEc6R3wLSgDmGyQWI1CL7SO8OQzgFTkAIBx6Lklrg?=
 =?us-ascii?Q?oop3idLurP2+gnobWObgC8qeu6m/OrgqGupd5SydJz3rOQcKgBXomhxolhyO?=
 =?us-ascii?Q?9Yo/WKfF5zFYpoJd5zitQ4BKOxdFP5CEE5H/G8SP1cNKnxiC122WkCHn37cD?=
 =?us-ascii?Q?ilO1Cqf7H/6c+TEr7nNF5xZkjKyByVX6ycycEYex7RhrgkoZT9EZcD2w61F+?=
 =?us-ascii?Q?qyLUl+5B7GNSFyzEaP4vk/h2TfJUbKAzdMCXnJQQ3CzVwViiFeQbkztc9USF?=
 =?us-ascii?Q?SxIrkCmq08RAC0G5JgvPZ6/D/L8QJg5mDwrtdadj9Zd+qXpsRryaI23aAUa5?=
 =?us-ascii?Q?sydUcm6KqDOf0AAXVG8ZRdKqxlWFNIZO7UR6FF5oRYKngUsxQEKK9Z1iKuCr?=
 =?us-ascii?Q?Rs6Goz9GUQqCWCI03HMLsAK8pojy2OHUvvVn1rcmcuEv0tBEFL4Lwi2wXEeQ?=
 =?us-ascii?Q?RbV8doNcIN436nG+2vhcWVzYzJFfSBtjfer4HDlM45eKaUYPbCKhpE8ViE7X?=
 =?us-ascii?Q?/e+ciPV4ItIbb544fwyzkGFAKds7J0/aPmlr1IUun3iC3Pi4uYBUE2oN9A7D?=
 =?us-ascii?Q?MMO1LE+5XY79VZOA3BY3mE3jMaGoPOUMuUeUBYDy53gmxiv2HcHLG3wZasQP?=
 =?us-ascii?Q?DZw1zUQRbWVJchanQ3GX+T7ITu1omOU0ygSQ+GuLoIC4dT4UEfzhPSwaMTBd?=
 =?us-ascii?Q?9HNdRAhibznCez60WZBrKQwUGeYo/rwkUIc7sCKWOPERCIGQirdHgrwlFDw4?=
 =?us-ascii?Q?5Gk4EX36ZHysCsua08NWbXPjFkcQjqowlP6zqYl8AhKPYbZw1PNGeEswynqa?=
 =?us-ascii?Q?I7kNzsVc5sgFbPsQ7G6YnmNwDrGJksiz1BXK/W6FT4Jo4Zc/lZ7fK/gqikPM?=
 =?us-ascii?Q?mFk19rkAUFr4cVzXQVwbzc5G2iTeCnldLYsTk3me17k6ZiAx+tsUa0g3T8k1?=
 =?us-ascii?Q?lWavoj8XkFQ5Ja+YMUuip9/4i7r7ZHipVyUQh++xeIemZGs3aCXVKilH7U5O?=
 =?us-ascii?Q?xU+zteKEIX2o5Dt8m8mlEEuqnvcg0Mtj0Q/aXG/HXoUn1/uXsGSCus5jRhYh?=
 =?us-ascii?Q?zNaZ3sr8ack+FWCSEfE=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: bd4a0dc7-15fa-4f48-d014-08ddb7bca67c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2025 09:58:23.5633 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: m89FnXdWLTfCYXvKzQBEPvUmNcfs1I4+IE2au8ndr5CaJziDalAhfx9++XTlJRiC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB7894
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

Use DPAA2_VADDR_TO_IOVA to convert va to iova for both VA and PA modes.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c | 222 +++++++++++++++--------
 1 file changed, 142 insertions(+), 80 deletions(-)

diff --git a/drivers/mempool/dpaa2/dpaa2_hw_mempool.c b/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
index 0ba40e751e..45a8f04256 100644
--- a/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
+++ b/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
@@ -242,26 +242,47 @@ rte_hw_mbuf_free_pool(struct rte_mempool *mp)
 	dpaa2_free_dpbp_dev(dpbp_node);
 }
 
-static void
-rte_dpaa2_mbuf_release(struct rte_mempool *pool __rte_unused,
-			void * const *obj_table,
-			uint32_t bpid,
-			uint32_t meta_data_size,
-			int count)
+static inline int
+dpaa2_bman_multi_release(uint64_t *bufs, int num,
+	struct qbman_swp *swp,
+	const struct qbman_release_desc *releasedesc)
+{
+	int retry_count = 0, ret;
+
+release_again:
+	ret = qbman_swp_release(swp, releasedesc, bufs, num);
+	if (unlikely(ret == -EBUSY)) {
+		retry_count++;
+		if (retry_count <= DPAA2_MAX_TX_RETRY_COUNT)
+			goto release_again;
+
+		DPAA2_MEMPOOL_ERR("bman release retry exceeded, low fbpr?");
+		return ret;
+	}
+	if (unlikely(ret)) {
+		DPAA2_MEMPOOL_ERR("bman release failed(err=%d)", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int
+dpaa2_mbuf_release(void * const *obj_table, uint32_t bpid,
+	uint32_t meta_data_size, int count)
 {
 	struct qbman_release_desc releasedesc;
 	struct qbman_swp *swp;
 	int ret;
-	int i, n, retry_count;
+	int i, n;
 	uint64_t bufs[DPAA2_MBUF_MAX_ACQ_REL];
 
 	if (unlikely(!DPAA2_PER_LCORE_DPIO)) {
 		ret = dpaa2_affine_qbman_swp();
-		if (ret != 0) {
-			DPAA2_MEMPOOL_ERR(
-				"Failed to allocate IO portal, tid: %d",
-				rte_gettid());
-			return;
+		if (ret) {
+			DPAA2_MEMPOOL_ERR("affine portal err: %d, tid: %d",
+				ret, rte_gettid());
+			return -EIO;
 		}
 	}
 	swp = DPAA2_PER_LCORE_PORTAL;
@@ -277,51 +298,62 @@ rte_dpaa2_mbuf_release(struct rte_mempool *pool __rte_unused,
 		goto aligned;
 
 	/* convert mbuf to buffers for the remainder */
-	for (i = 0; i < n ; i++) {
-#ifdef RTE_LIBRTE_DPAA2_USE_PHYS_IOVA
-		bufs[i] = (uint64_t)rte_mempool_virt2iova(obj_table[i])
-				+ meta_data_size;
-#else
-		bufs[i] = (uint64_t)obj_table[i] + meta_data_size;
-#endif
+	if (likely(rte_eal_iova_mode() == RTE_IOVA_VA)) {
+		for (i = 0; i < n ; i++) {
+			bufs[i] = DPAA2_VAMODE_VADDR_TO_IOVA(obj_table[i]) +
+				meta_data_size;
+		}
+	} else {
+		for (i = 0; i < n ; i++) {
+			bufs[i] = DPAA2_PAMODE_VADDR_TO_IOVA(obj_table[i]) +
+				meta_data_size;
+		}
 	}
 
 	/* feed them to bman */
-	retry_count = 0;
-	while ((ret = qbman_swp_release(swp, &releasedesc, bufs, n)) ==
-			-EBUSY) {
-		retry_count++;
-		if (retry_count > DPAA2_MAX_TX_RETRY_COUNT) {
-			DPAA2_MEMPOOL_ERR("bman release retry exceeded, low fbpr?");
-			return;
-		}
-	}
+	ret = dpaa2_bman_multi_release(bufs, n, swp, &releasedesc);
+	if (unlikely(ret))
+		return 0;
 
 aligned:
 	/* if there are more buffers to free */
+	if (unlikely(rte_eal_iova_mode() != RTE_IOVA_VA))
+		goto iova_pa_release;
+
 	while (n < count) {
 		/* convert mbuf to buffers */
 		for (i = 0; i < DPAA2_MBUF_MAX_ACQ_REL; i++) {
-#ifdef RTE_LIBRTE_DPAA2_USE_PHYS_IOVA
-			bufs[i] = (uint64_t)
-				  rte_mempool_virt2iova(obj_table[n + i])
-				  + meta_data_size;
-#else
-			bufs[i] = (uint64_t)obj_table[n + i] + meta_data_size;
-#endif
+			bufs[i] = DPAA2_VAMODE_VADDR_TO_IOVA(obj_table[n + i]) +
+				meta_data_size;
 		}
 
-		retry_count = 0;
-		while ((ret = qbman_swp_release(swp, &releasedesc, bufs,
-					DPAA2_MBUF_MAX_ACQ_REL)) == -EBUSY) {
-			retry_count++;
-			if (retry_count > DPAA2_MAX_TX_RETRY_COUNT) {
-				DPAA2_MEMPOOL_ERR("bman release retry exceeded, low fbpr?");
-				return;
-			}
+		ret = dpaa2_bman_multi_release(bufs,
+				DPAA2_MBUF_MAX_ACQ_REL, swp, &releasedesc);
+		if (unlikely(ret))
+			return n;
+
+		n += DPAA2_MBUF_MAX_ACQ_REL;
+	}
+
+	return count;
+
+iova_pa_release:
+	while (n < count) {
+		/* convert mbuf to buffers */
+		for (i = 0; i < DPAA2_MBUF_MAX_ACQ_REL; i++) {
+			bufs[i] = DPAA2_PAMODE_VADDR_TO_IOVA(obj_table[n + i]) +
+				meta_data_size;
 		}
+
+		ret = dpaa2_bman_multi_release(bufs,
+				DPAA2_MBUF_MAX_ACQ_REL, swp, &releasedesc);
+		if (unlikely(ret))
+			return n;
+
 		n += DPAA2_MBUF_MAX_ACQ_REL;
 	}
+
+	return count;
 }
 
 RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_bpid_info_init)
@@ -389,7 +421,7 @@ rte_dpaa2_mbuf_alloc_bulk(struct rte_mempool *pool,
 #endif
 	struct qbman_swp *swp;
 	uint16_t bpid;
-	size_t bufs[DPAA2_MBUF_MAX_ACQ_REL];
+	uint64_t bufs[DPAA2_MBUF_MAX_ACQ_REL];
 	int i, ret;
 	unsigned int n = 0;
 	struct dpaa2_bp_info *bp_info;
@@ -405,56 +437,79 @@ rte_dpaa2_mbuf_alloc_bulk(struct rte_mempool *pool,
 
 	if (unlikely(!DPAA2_PER_LCORE_DPIO)) {
 		ret = dpaa2_affine_qbman_swp();
-		if (ret != 0) {
-			DPAA2_MEMPOOL_ERR(
-				"Failed to allocate IO portal, tid: %d",
-				rte_gettid());
+		if (ret) {
+			DPAA2_MEMPOOL_ERR("affine portal err: %d, tid: %d",
+				ret, rte_gettid());
 			return ret;
 		}
 	}
 	swp = DPAA2_PER_LCORE_PORTAL;
 
+	if (unlikely(rte_eal_iova_mode() != RTE_IOVA_VA))
+		goto iova_pa_acquire;
+
 	while (n < count) {
 		/* Acquire is all-or-nothing, so we drain in 7s,
 		 * then the remainder.
 		 */
-		if ((count - n) > DPAA2_MBUF_MAX_ACQ_REL) {
-			ret = qbman_swp_acquire(swp, bpid, (void *)bufs,
-						DPAA2_MBUF_MAX_ACQ_REL);
-		} else {
-			ret = qbman_swp_acquire(swp, bpid, (void *)bufs,
-						count - n);
+		ret = qbman_swp_acquire(swp, bpid, bufs,
+			(count - n) > DPAA2_MBUF_MAX_ACQ_REL ?
+			DPAA2_MBUF_MAX_ACQ_REL : (count - n));
+		if (unlikely(ret <= 0))
+			goto acquire_failed;
+
+		/* assigning mbuf from the acquired objects */
+		for (i = 0; i < ret; i++) {
+			DPAA2_VAMODE_MODIFY_IOVA_TO_VADDR(bufs[i],
+				size_t);
+			obj_table[n] = (void *)(uintptr_t)(bufs[i] -
+				bp_info->meta_data_size);
+			n++;
 		}
-		/* In case of less than requested number of buffers available
-		 * in pool, qbman_swp_acquire returns 0
+	}
+	goto acquire_success;
+
+iova_pa_acquire:
+
+	while (n < count) {
+		/* Acquire is all-or-nothing, so we drain in 7s,
+		 * then the remainder.
 		 */
-		if (ret <= 0) {
-			DPAA2_MEMPOOL_DP_DEBUG(
-				"Buffer acquire failed with err code: %d", ret);
-			/* The API expect the exact number of requested bufs */
-			/* Releasing all buffers allocated */
-			rte_dpaa2_mbuf_release(pool, obj_table, bpid,
-					   bp_info->meta_data_size, n);
-			return -ENOBUFS;
-		}
+		ret = qbman_swp_acquire(swp, bpid, bufs,
+			(count - n) > DPAA2_MBUF_MAX_ACQ_REL ?
+			DPAA2_MBUF_MAX_ACQ_REL : (count - n));
+		if (unlikely(ret <= 0))
+			goto acquire_failed;
+
 		/* assigning mbuf from the acquired objects */
-		for (i = 0; (i < ret) && bufs[i]; i++) {
-			DPAA2_MODIFY_IOVA_TO_VADDR(bufs[i], size_t);
-			obj_table[n] = (struct rte_mbuf *)
-				       (bufs[i] - bp_info->meta_data_size);
-			DPAA2_MEMPOOL_DP_DEBUG(
-				   "Acquired %p address %p from BMAN\n",
-				   (void *)bufs[i], (void *)obj_table[n]);
+		for (i = 0; i < ret; i++) {
+			DPAA2_PAMODE_MODIFY_IOVA_TO_VADDR(bufs[i],
+				size_t);
+			obj_table[n] = (void *)(uintptr_t)(bufs[i] -
+				bp_info->meta_data_size);
 			n++;
 		}
 	}
 
+acquire_success:
 #ifdef RTE_LIBRTE_DPAA2_DEBUG_DRIVER
 	alloc += n;
-	DPAA2_MEMPOOL_DP_DEBUG("Total = %d , req = %d done = %d\n",
-			       alloc, count, n);
+	DPAA2_MEMPOOL_DP_DEBUG("Total = %d , req = %d done = %d",
+		alloc, count, n);
 #endif
 	return 0;
+
+acquire_failed:
+	DPAA2_MEMPOOL_DP_DEBUG("Buffer acquire err: %d", ret);
+	/* The API expect the exact number of requested bufs */
+	/* Releasing all buffers allocated */
+	ret = dpaa2_mbuf_release(obj_table, bpid,
+			bp_info->meta_data_size, n);
+	if (ret != (int)n) {
+		DPAA2_MEMPOOL_ERR("%s: expect to free %d!= %d",
+			__func__, n, ret);
+	}
+	return -ENOBUFS;
 }
 
 static int
@@ -462,14 +517,21 @@ rte_hw_mbuf_free_bulk(struct rte_mempool *pool,
 		  void * const *obj_table, unsigned int n)
 {
 	struct dpaa2_bp_info *bp_info;
+	int ret;
 
 	bp_info = mempool_to_bpinfo(pool);
 	if (!(bp_info->bp_list)) {
 		DPAA2_MEMPOOL_ERR("DPAA2 buffer pool not configured");
 		return -ENOENT;
 	}
-	rte_dpaa2_mbuf_release(pool, obj_table, bp_info->bpid,
-			   bp_info->meta_data_size, n);
+	ret = dpaa2_mbuf_release(obj_table, bp_info->bpid,
+			bp_info->meta_data_size, n);
+	if (unlikely(ret != (int)n)) {
+		DPAA2_MEMPOOL_ERR("%s: expect to free %d!= %d",
+			__func__, n, ret);
+
+		return -EIO;
+	}
 
 	return 0;
 }
@@ -515,6 +577,7 @@ dpaa2_populate(struct rte_mempool *mp, unsigned int max_objs,
 	      rte_mempool_populate_obj_cb_t *obj_cb, void *obj_cb_arg)
 {
 	struct rte_memseg_list *msl;
+	int ret;
 	/* The memsegment list exists incase the memory is not external.
 	 * So, DMA-Map is required only when memory is provided by user,
 	 * i.e. External.
@@ -523,11 +586,10 @@ dpaa2_populate(struct rte_mempool *mp, unsigned int max_objs,
 
 	if (!msl) {
 		DPAA2_MEMPOOL_DEBUG("Memsegment is External.");
-		rte_fslmc_vfio_mem_dmamap((size_t)vaddr,
-				(size_t)paddr, (size_t)len);
+		ret = rte_fslmc_vfio_mem_dmamap((size_t)vaddr, paddr, len);
+		if (ret)
+			return ret;
 	}
-	/* Insert entry into the PA->VA Table */
-	dpaax_iova_table_update(paddr, vaddr, len);
 
 	return rte_mempool_op_populate_helper(mp, 0, max_objs, vaddr, paddr,
 					       len, obj_cb, obj_cb_arg);
-- 
2.25.1

