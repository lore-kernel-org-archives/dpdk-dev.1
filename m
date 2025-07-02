Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC23AC83013
	for <dpdk-dev@archiver.kernel.org>; Wed,  2 Jul 2025 09:52:23 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E5D140E03;
	Wed,  2 Jul 2025 11:52:07 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazon11012066.outbound.protection.outlook.com [52.101.71.66])
 by mails.dpdk.org (Postfix) with ESMTP id 817F740BA6
 for <dev@dpdk.org>; Wed,  2 Jul 2025 11:52:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdhQ2cw7Duv2t+8+p9furEfUQHWxjPP2WW591nPTOhjX4+OyMDk8RdOM/sz1HXzE2Cc7qX41jH35Dl8m1slaawowukoOlbXknTZzzhAmCkREkdeFc+T+E7yWXbj852QTNpxhVgCsfvWYEu5bsY7se/UJDXqD9lYFq++4hZdc9pM10+HUHJZHRCd4/KEEOGf+OSXsL7vqScjWRnWLQsV9wUvX9KLyEXVUWvw+Hh+npL9jOv7KSOLKcVTyY+QjlHfU2QuSFEfb30BKR0mLkJqPuo4bEvVoZ2HD6+k1SBoOb9mkaMhFjbkh4NYZ8KNJelemw9Xde5dUFDzvuWX5XE+DXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IrirCFNUoeZsIO3eLFu1+GykIE/MFoei4Z93EQ06+/Q=;
 b=QwBarxWc4azFfXdGmr2Mz7W5HFWk/acH83nC9XPdp39GCj5L5vFBJRU0uCGjgDnG3wgM2Zc+0ITOAea9d/ZdDIv9yi/oDz2kptdww7dZ+NUxR/BQUs3p169hISyDzTFlLa3VyxhluQM0imDKkm+h89anHqTVi93CXIl8qJQrZ7FK0LuBCCllwquYn5GPT+ooMGx1J33h5JRrXi8u51oRR+3Adf3yMgZeqvlS24zxUOhIOxqAcDyPW0XoMNf8jOpywk9E6iKNVr6+levck49KpEeBMHAXyTKb7BSI6iKSZBoG3eizgnOB2Lmcuzo6yEJapkVt5TRHHEhqVTg/cPqLHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IrirCFNUoeZsIO3eLFu1+GykIE/MFoei4Z93EQ06+/Q=;
 b=SIwyu6DDSZUCMuk8txJuTJnJpn+8rB+/yvdatHuXdbCr1NPZOn1t5J5o9kR3g8TaZJGHdg4VnA9DSKw7W37T+KB9quOXgnrFNiCWZKRT6mUEoL9NV/CcvWL/rzGCoCL9owlrLUnEwtAUtBHltQ8qxLi03zELHpiFH0IScekSzsp0YcqDSJq8WqbsnS4lY5aXMBPcK08ZEF+dpdfrr2WtQOrjFYMd9wyrEk8u/1tkmmxacST7epjWE+rExsV3yPEUCewCn3PEDX0bod0ZvhNlQjzo9PZ3tGss0DPusXVibHEPUelmTcTETZ3wEsyweGAXl/zQg5SZcW6LgszWXYrnSg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by PAXPR04MB8473.eurprd04.prod.outlook.com (2603:10a6:102:1dc::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.19; Wed, 2 Jul
 2025 09:52:04 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8901.018; Wed, 2 Jul 2025
 09:52:04 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v8 3/5] mempool/dpaa2: use unified VA to IOVA conversion
Date: Wed,  2 Jul 2025 15:21:42 +0530
Message-Id: <20250702095144.3087250-4-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250702095144.3087250-1-g.singh@nxp.com>
References: <20250701042917.3000355-1-g.singh@nxp.com>
 <20250702095144.3087250-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA1PR01CA0143.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a00:71::13) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|PAXPR04MB8473:EE_
X-MS-Office365-Filtering-Correlation-Id: 4cb9d183-477c-4163-5456-08ddb94e194d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|376014|19092799006|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?zOgcZiaGsExElEVYk9Ty8EHHl9OwU0Ok5f2Ei9IH+30hEt9OvNNGZw7lfZuI?=
 =?us-ascii?Q?9/y7FlCzltgK5MtO4cNznmxpmbNG7UpH1sctMElJB8P+xrmCv+dV7TN7hQTA?=
 =?us-ascii?Q?ndN0sjXvdNzu8TykOQffPU3f9hdINDX8CIjr2Wc1BJ6W4tK7hvCuTqrflf4N?=
 =?us-ascii?Q?oaIabsBnp2u0spcYMf2z/vL4psl6Z51qVOthFS94beRLGueIJfj1Vp2w3xht?=
 =?us-ascii?Q?reF9lbZpOARDVn1NYyod5uOgbEZmYF4kCIeNVMZ0X9DkTeBu5hNQjapAfkPl?=
 =?us-ascii?Q?ZhHk4VoeO24y14DTVQoYKOZltOh3txBztkQwa0v+Oi2qstej5inCUa3bWC6E?=
 =?us-ascii?Q?OhMEYxPT1HG7VajbZQ3wpvZ24RpzEhZBvziO1vrS6jkVF0l0uJ3IUdPcPw6X?=
 =?us-ascii?Q?LEYk/kgW8SP/FYi9f7ZzQLBSSaTvHZPWBT0xxt4I4xVgWOEygxOruoJIuqEl?=
 =?us-ascii?Q?4xLIwLD6rdgC/CGWoEjJTyzOXrUeC7ola2/ilYDsgUK5iB6g1tOfDPdtbnKR?=
 =?us-ascii?Q?POv7+dCefEM14omSoAR1cUBCQxBTEyCp2s/VIRE/NuOMU72kUGC6Q1YHMfgN?=
 =?us-ascii?Q?9355e5q/Fq14nHVknjlB/KCcgWGWlAS2JOR8OF7b31LRlnVPk9+8cRigQuKd?=
 =?us-ascii?Q?WW+sENUV0rMcA77xUwkZW6yGa+GoWUMz6dTOZpGlC+CL2QUF+sP8SwSzIDkX?=
 =?us-ascii?Q?WBFs1ObTemqaxZkefkvoCTSDqO1vzT1QkDopGCpLteotbBClBmuSvp0/EhmM?=
 =?us-ascii?Q?ke+XpM7vFTh2Xu/FzuFFMF2Y8i2kOTWLE/vC/jee+97zxWId9CXItUfyt26z?=
 =?us-ascii?Q?ECCG1yuFEs930a8Ma/q0BheqIVHntRlBpTDaFCqIUsPd/L6Fa5PNXK5H9k+x?=
 =?us-ascii?Q?77R3O3W8ThdZzccpMCnnopbDd9zCqIVeQ3OiKq56F1mo9v5T44NuqihH0BV6?=
 =?us-ascii?Q?zqHVMdixEsWaFYFd/8ALiahmswrwIJa7HMbwZIPLt3fhKj3oWR9LDLB0PatM?=
 =?us-ascii?Q?iycB0uyCsD4sn54iMFwH+AK+fsv77XJbi5l5AaKstWiZ+PznoIvMT53L+iE5?=
 =?us-ascii?Q?92d4WmkBOaLiNCW7qg9a/6pM+rxTcVe5yuhSDvjvSFj6p7g2yTsRt1RlRIWA?=
 =?us-ascii?Q?jEzqsCZCEjT05RDRRcAuR48vh9RUGU8ecfa4w/425JTqjKxTZErZ0A1hp06M?=
 =?us-ascii?Q?bUvg0n5HE0SwNvW61wbNAf8ECjuR2PNqJYs3BTjuGQIelmL5gLHvopzU5Bl/?=
 =?us-ascii?Q?G52gSa9/HpWz+deXfgybhPloRZnNW/3hevtOlRCd7WjbLhCtStYaOnZOhYZh?=
 =?us-ascii?Q?7fegLf19Njtq+KjgUUFMZY6UQ/afrFwM4ALGf2vhXuhRTZkmiizMHA4ciFyb?=
 =?us-ascii?Q?E1yIdVYXuuqrVLQBvX3m5VCCcnNy/x9UN5Gz+jmjAGasEhZ6HaPZnXlSXJ6h?=
 =?us-ascii?Q?Eg0mdgG8o9Trz/9Wx2HeSH0R48IWN/hXNvJwtGN2bE8fFNVzO43wyOZoBH9z?=
 =?us-ascii?Q?8YKI9ZCOHEYqkmE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(376014)(19092799006)(366016)(1800799024)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bYRUEiGgsXgZNwM5nlJC0nykUf0P1gTEr8sfFXgBTDDl7CW5+rd4ezXR6FPk?=
 =?us-ascii?Q?5RY9LElv78tkrL76qXRAmYc0b3b2k/iSuubbHsMCsFzCJcfqBGaYduxSql+s?=
 =?us-ascii?Q?hfAo7cXZMVvmHvcoy5i6LPAnMbpWq7uh188kOTgeUa3Ypap/WzOTRMgJO8qP?=
 =?us-ascii?Q?OfTV2pugrCXKCaYg6k8K1aEjSdgYLqNjePVKmyoand103TYl5SZnJUlwpBy+?=
 =?us-ascii?Q?yFlT72xLk/aD0MCbvFtEx5SXnmo6mN4iIQTNRI2dORyTr30pxOVaT4aadI/f?=
 =?us-ascii?Q?DshmGqie+3Zjn+CIcnYIBMFBV25Q2EHe/1gWVdVGXm8nwWwPsi7JktFvwhYi?=
 =?us-ascii?Q?krHqPDTicZ6OAFe77wWLkHrtS+wgeO6R8hUd634MwP7xnQ2WD9tknRUV5TFg?=
 =?us-ascii?Q?3H0omwWd9HxAGOYDTN2FcF8Waz0KA/40WXJApyHGRDVxcZWgU64K+vyce2/w?=
 =?us-ascii?Q?6XSS1JUg/Z6eCwO2TnPn1mECvNzYKxB09zvUIAsK03MQ4zLQO02veMr39HD5?=
 =?us-ascii?Q?4z+St2Jd39NEKuKWmhJl8cv5qdGqC1mhM1GW4TwAJgr1A+zav+I5WhJXXYob?=
 =?us-ascii?Q?owezx16pT0hmEtk2PG+8GzttNqVdeggV9fZ+9Jmr5tM9uPLmmbWnulDWCob7?=
 =?us-ascii?Q?tntPCiRngkWrmsMdMMYyaXPkk0Eb4l2GNfEwqJTnKZ/670QHLPBd9Krekm2Z?=
 =?us-ascii?Q?tZQ6ErCAbQzqBbfiZLHQt4hURihOJjhdCISk20xZayMqJBwzvnRDAQiAgJ9x?=
 =?us-ascii?Q?BdfnPBLNwSOrOvPNJ/GthkfuZS0H+RQYZyCNXzfzzcGPay2/w17llNTrnZS6?=
 =?us-ascii?Q?bIBjVToQc5LGqn8wHJC5vme9a4GcHMdtqPCTrfimT8sqaNNxe/FxAEAG/VkD?=
 =?us-ascii?Q?WoCn+G7YfQTHRlrp1bCJn50lHAqASeOJDYFhoiG0OMu5McfZ+lxJL7xg9rIW?=
 =?us-ascii?Q?sv4NS8VQ/ZresoqzdmlthF6Lcb3rWout1WIidkF4PFz5zSH1sA/bK0DvGSyx?=
 =?us-ascii?Q?oi+j293e4moHUTwADyb+GKb9BM1mSf6SpYOEEr/fyAoWb/gQAOj4Yo/tbwUx?=
 =?us-ascii?Q?3/Im0/3MUr+tXMxDK/P6TmOZsMYDc+aXTLGA1ehO9Ic2vhfDUCpKqeuFVow3?=
 =?us-ascii?Q?de9NDI+kik31xQJDGyA1DGWHAYnLqFvCBSjIo7RJPHbCyEBuA+DHAEpPMkSU?=
 =?us-ascii?Q?EhfkVrSvtRd1VB1Q8riYUYJ+1q5OUHYzuOR+mrZQOVp0oD9a0eI3emZi+2Mj?=
 =?us-ascii?Q?W7+e2tKMihDUFi5MZh8mWsOREdYlOLwGDCzDhm5R5d68sjZiZ6h9shfgKzQ8?=
 =?us-ascii?Q?Ut2HVQGu/8fRDf8rGt6nMVjvkG2p6QvOvAUs5X1AItGcilOSz/Ej2Gbpnnsr?=
 =?us-ascii?Q?X0Yv9APC+IFQRxrmnTwfIyOhhoPlqTBCmFTGDMPE+K24PI6tXPp4BLqJR5MW?=
 =?us-ascii?Q?PrcXwehliYiQScltxowV1O8LtHJC5rvvETK4R/eznxBU4WxWGFvDa3uQeRFb?=
 =?us-ascii?Q?s7awgwEVrvdO8YY1kijET3G+dhsQjcPDUNE+gOPCEwRI1DX43dt+4ub4QKDH?=
 =?us-ascii?Q?Q5oKcdmLyqWXQX3+55s=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4cb9d183-477c-4163-5456-08ddb94e194d
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jul 2025 09:52:04.2566 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gYlzbnozChc+Wik34pfagpIrafmcNZs2JnLuFhPm8Fv6UTJPpUnTxKS/HqXn1sQC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR04MB8473
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
index 118eb76db7..02b6741853 100644
--- a/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
+++ b/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
@@ -216,26 +216,47 @@ rte_hw_mbuf_free_pool(struct rte_mempool *mp)
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
@@ -251,51 +272,62 @@ rte_dpaa2_mbuf_release(struct rte_mempool *pool __rte_unused,
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
@@ -363,7 +395,7 @@ rte_dpaa2_mbuf_alloc_bulk(struct rte_mempool *pool,
 #endif
 	struct qbman_swp *swp;
 	uint16_t bpid;
-	size_t bufs[DPAA2_MBUF_MAX_ACQ_REL];
+	uint64_t bufs[DPAA2_MBUF_MAX_ACQ_REL];
 	int i, ret;
 	unsigned int n = 0;
 	struct dpaa2_bp_info *bp_info;
@@ -379,56 +411,79 @@ rte_dpaa2_mbuf_alloc_bulk(struct rte_mempool *pool,
 
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
@@ -436,14 +491,21 @@ rte_hw_mbuf_free_bulk(struct rte_mempool *pool,
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
@@ -489,6 +551,7 @@ dpaa2_populate(struct rte_mempool *mp, unsigned int max_objs,
 	      rte_mempool_populate_obj_cb_t *obj_cb, void *obj_cb_arg)
 {
 	struct rte_memseg_list *msl;
+	int ret;
 	/* The memsegment list exists incase the memory is not external.
 	 * So, DMA-Map is required only when memory is provided by user,
 	 * i.e. External.
@@ -497,11 +560,10 @@ dpaa2_populate(struct rte_mempool *mp, unsigned int max_objs,
 
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

