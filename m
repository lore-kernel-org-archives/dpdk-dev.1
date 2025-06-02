Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FBFCC5AD49
	for <dpdk-dev@archiver.kernel.org>; Mon,  2 Jun 2025 10:41:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7E82340659;
	Mon,  2 Jun 2025 12:41:11 +0200 (CEST)
Received: from AM0PR02CU008.outbound.protection.outlook.com
 (mail-westeuropeazon11013041.outbound.protection.outlook.com [52.101.72.41])
 by mails.dpdk.org (Postfix) with ESMTP id EC16C4065C
 for <dev@dpdk.org>; Mon,  2 Jun 2025 12:41:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BuRjxy4YBYjv+ZrrOjnSXNI++YDfyblWIuzkD5S4sz/mdz/K6F6qwguKDF8d829JIswtgKDY8eEqhqodLU3QI3mLIHXaPukjV8qwT0zB8rvIp2joLcgE9wESyxGTerdx5rXm0CFSzkYwELwKVIeHmuR77q6AuGpneeVmyibkGsKBHUDjExowCCbxHrIq7TAoZQwTvK6quzGBYd76SPGVxcNzQo369IgVkFlks821cSixYOavSitR9JdHgyZ4F5Ou+fJRFZv7zUZvj+kdbRpswGISmzMpm1ypWSq0kbq+AyHegBJ62oMSC6I0F8xguXexIBQ96et4jECBPsArjeyKng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eq0sd+7N+dOCZToSvDNdKghJmwLiqN3FeK7LVan0kE=;
 b=zGbLvINTuZOEI3T25gQ4KHZ/RF7ja0Zxq816NLUYYifZSFPUqovTOi3S/9ND133vC7U7teJG2nnU/ykMRufJhU8bFQwAlq/WkNCBDVB9Q1EyTfaasmNhC5aO1+R6xFNv7gsh1sv46/pbm4O8HdyzEoD5kpH/jtOa2nsLo40ohL+5SCxoDxOLuZq1IgnfkE2ZbObgRNZ9Tg6+zptjsqPpOP6T28jl0I0RE8qsZwm3G5BCYmfx23vxKYM+5QlwL5WAzZtrpgIz8iOLSwi9N3fgSkixrOXaDVffM+L3qN6etKKhmafL7jZAXGHvdwTJwfHjEM23Rfb0w6XnXq2uLtHhIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eq0sd+7N+dOCZToSvDNdKghJmwLiqN3FeK7LVan0kE=;
 b=BNn5PoJ4zhhPB3Q+Lac6esfDjXRCO7j70GAcnybwQ4z0saqKW65eeAlloYaqgHeQTWgXukbYAc5CCqSMuMChYQA9otVfyegB7Pb50T3rWYt39cwni1hpSPXt993PuEPhY8Mxk694Fb5LuCIKrPuf4osGRetxW3/A86jtt9mu/Y0KxwM6Nc/aVlOqZLRV0g+Tto93fwi8xC40pTjT13Ngn3cZpxXtA/fufv+ujMlQk+Cok5xwO+Dtj91oxs3GL/uWQFmwCz5xaJy8Z7gyAMyPrh5NEDNUSfSzcmP/9J4VustiikqWbMF8ktVxt0XpKqdYUo3+mcP79zK1aE02JS7BLQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AM9PR04MB8194.eurprd04.prod.outlook.com (2603:10a6:20b:3e6::7)
 by VI2PR04MB10956.eurprd04.prod.outlook.com (2603:10a6:800:276::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Mon, 2 Jun
 2025 10:41:08 +0000
Received: from AM9PR04MB8194.eurprd04.prod.outlook.com
 ([fe80::cd61:3920:b12f:6561]) by AM9PR04MB8194.eurprd04.prod.outlook.com
 ([fe80::cd61:3920:b12f:6561%4]) with mapi id 15.20.8769.029; Mon, 2 Jun 2025
 10:41:08 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v2 04/11] mempool/dpaa2: use unified VA to IOVA conversion
Date: Mon,  2 Jun 2025 16:10:34 +0530
Message-Id: <20250602104041.3322164-5-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250602104041.3322164-1-g.singh@nxp.com>
References: <20250530071344.2939434-1-g.singh@nxp.com>
 <20250602104041.3322164-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR04CA0011.apcprd04.prod.outlook.com
 (2603:1096:4:197::10) To AM9PR04MB8194.eurprd04.prod.outlook.com
 (2603:10a6:20b:3e6::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB8194:EE_|VI2PR04MB10956:EE_
X-MS-Office365-Filtering-Correlation-Id: 49fd19a0-81e1-41f0-5c47-08dda1c1fb88
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?FofFga7hMpFXAGNNUYTClRSBBfFjfLkD9QqzFW7v5gVvcsShFxKrWvKyo1Tw?=
 =?us-ascii?Q?qpLO4CTM3IsNmP5uYd8vWIL5PDFivwMQ2NGxr0xI/CYVjON/VnU7crf4Z2mj?=
 =?us-ascii?Q?hTLyB5XBfsI0BFDuVAg5OjgRo2VeAlPpoH/8wUngNRtZuVJOq93P2zQpx4B9?=
 =?us-ascii?Q?VKdS6Tsg3Kzu6AUJ2pz0lVNLFVBFE2leWImoeXv9p2Iu4MXKDx0UYg9Xlt2a?=
 =?us-ascii?Q?G1EkUXc5M85h6SouCBHyNzQvVRHq/7uhAZ+zkBLPD8msFvege2eX1eLT1ncu?=
 =?us-ascii?Q?g9zH9noKwKvDfueAAPye8a92xPzePopHatMf5cBlbhkWkPy31slqD5kYVqdA?=
 =?us-ascii?Q?AKbVXf7fgnOPC7/G9YgGK7Gc7jKdg1WcRLSVES3KI1h+53/dhVFv8Lr0aRlY?=
 =?us-ascii?Q?RpaGcnyuPhYJbjw+Uut+ww7PlFWb3jhRM3nByS5ClXj5Mqtt06a8esNbqr8X?=
 =?us-ascii?Q?baUAtN34bFP2zAFtVRmUyuxs8FkALz1Hrphe7nJs2MF/iIMa6+gDRzRP75Lp?=
 =?us-ascii?Q?V6KnmNRgPr0DdA5sb5ny9b6EEl/5sqhUZW8VYrEoWhZ5B9X30OB93BtJr/D+?=
 =?us-ascii?Q?Ys84VyTwbp/iRpLiUTHD463KomtAmtddQVys3KtzibX7Bm6v4bV7ACmtDBai?=
 =?us-ascii?Q?yjxJFVl/kCSzCDoz8g5NmxM48RVeir49dj6ty6K/HfzHt914Ee7rJwB3rThD?=
 =?us-ascii?Q?8U/YLo0GPk8k5aUw/fbvp5rqtCOqxEObj20wkd5E4Wyo614AUQVFGjiVNljy?=
 =?us-ascii?Q?sZM2HFZmv+5rkQKA73LGoe71BxuC0i+iZ1nPg4PBQakBb3UOQ5fzfCmUWfXs?=
 =?us-ascii?Q?h2vq0bBI5pWLIkbhTPGeFroGAYhdyayJ+ys+wpzSPHgJNlCnz8jBxyYwUVQh?=
 =?us-ascii?Q?ea3TSw1XrZCdzBhPyPGJr4yneMAmhKqtqcCReGiuq0kdeZXj0I8jt/3XMO5j?=
 =?us-ascii?Q?x9LwaQnGrAQHjIqUrIAEvTtf3sscLKvuRtjXUp9b+AdlEeSZS5FGdnsqBk5m?=
 =?us-ascii?Q?tFwgKnO+3qifGMWygEeUTRKWrDcyxzAwynsg1DwegP8ZOOlk4GZ+fMGuZsaQ?=
 =?us-ascii?Q?QkYhYq7bKoTlrwo6lVDMhYhpU2HgzdXAlV3w9wcmWRMROv1XAHsOOCmI2H2U?=
 =?us-ascii?Q?mW8GNUFMRXI7bi3l+VwY6kbNtLu4cXy2HWTZyM3U/+6qVHCIXeiqVints0im?=
 =?us-ascii?Q?De54rzZ/CIMhcwZoYRLzMxGhoErwGiTMqZ9Ci8AnesnG6UEKWsSTB+C0D00Z?=
 =?us-ascii?Q?yykLNqiCh31H8BLZvQt6cfhcjIPuCcLOiWWgg4AHkOjIoeSOgWcdqJSaiCgj?=
 =?us-ascii?Q?WDfglu2fIdAL699j5Was2KfBCohGaM4tfc9Wc+yHN4Ny34bCFf+nNxFD5J/1?=
 =?us-ascii?Q?umg/ptweU3vhi0VRH+e4CdXjiX/fTQRfG/VZsr2w76PU0q6JKZwE6EsRmcTh?=
 =?us-ascii?Q?SPZ6q5s0YcxVa01wRjAdgfL1V9WNir8Uml6xSZjJMycRSXaxtSnbVwFydPRM?=
 =?us-ascii?Q?JUzs+Bs/ycIF11I=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AM9PR04MB8194.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?53qL/bQMNy7vttbknYq7Hyx379ERd1e2H/qw/Myepws+4SEEHiy8huGLK7ba?=
 =?us-ascii?Q?QZiSECqWdolt0gaWCDoLMhj/OWq7TZEZaxOkADjCpSwuERCGSNmba14LsLxk?=
 =?us-ascii?Q?JOGQJ3IoxkD9hM6t/oLPsJbT16EtidgagKQw68VPhil5tLZxqCNx2nEGCLMq?=
 =?us-ascii?Q?pNMXiTmkM0vtnnCNRKsLzTqNtoykJxsSkRdZba2BVJTnJbxGO2si7zV01O5U?=
 =?us-ascii?Q?lSYPcqHfhg0qr/Fe3nI4AjRzTtmuj/CZ/sxhUjwI4PVU05CoJSVDOFqxdcBb?=
 =?us-ascii?Q?pz2f4JiS3P7XfKxTxxVaGED9822ladXZKsx+nyjdiNUtFB4GkFCGsbSf+sbe?=
 =?us-ascii?Q?4dPfCl4DevLLBy7ioEIfzsuNB2kfdYErLRYLpvridFoKbBJE5RDC64yayMTJ?=
 =?us-ascii?Q?esmbX2ihqKSpwQ9zbh07OeQq9FVgkAAeD52W9b7LWkbg6ED+XH7+FeF5jzMU?=
 =?us-ascii?Q?9x58AwV0VfUHX5smnI2uUqkayOkpYQJHDn1rk4c/lykda6KFsDutrP/P1KiT?=
 =?us-ascii?Q?WK4OEQl3+ytn0vLC1/SnAIKNKFp+9tNR/pxYtpzK6e8hBCbTbIQcFHBk03F2?=
 =?us-ascii?Q?RLYR91z62RYOt/6wUTd5Na6YoVjMpXRkt1lZxXRfa5iwZDbQZJDp5YJpe5K/?=
 =?us-ascii?Q?8ZwDFBhJMvJ7wNuUHWxe1MyI+nscS+TMrTW4+uJCKJQMVJWFX/CwQIhgH9zd?=
 =?us-ascii?Q?Q915IGZtRS/nNxT1vX9TQHVKo34Y2RjE2cECwM+pcOHIMPiHHa3ZoKcbRWT0?=
 =?us-ascii?Q?OeMucGsI3xVCvd0yNDOYLiABkn+Ht+q9+De1k11nsbUJ4d3J6tZ5CIRbbAxz?=
 =?us-ascii?Q?fYZcLeEUF/lytFna5vGqECrhLDksKdiwfymG7mkbO4V2jSpvC4lxRyRrvH71?=
 =?us-ascii?Q?lD/q89Jwv5VpKAGmFVSbWURniNVzjcZkg81nhY3YtfokvA0Kzz8eSAenCX1J?=
 =?us-ascii?Q?Bmb7Jtl3lwNFpOexIP3vejjIliiQwVqfEyJ/JroT4hvBMyHGChDVqqZDBCHI?=
 =?us-ascii?Q?2/0rlhBObLinZRhEvBeXsw5/OMDuG/HKl6km0bTq8G6g8aQBFVCT52kO/m0+?=
 =?us-ascii?Q?ysRAJvYlEuuW2zb3nhvG6U4drwuh8kVfydpuWlx0nV2RXY/as5bBR7KhXvN2?=
 =?us-ascii?Q?YznTdM+Xdw6lRTw/yViirypWbkIZGJWU4UHQsmKfhZp+2xvQwfj2NdPJ0nRH?=
 =?us-ascii?Q?8HjuETYhP0esjUj+H8U52DKNZfeOAN+LH3UkboyAYWLrxfiOFyTXTx8VsqQ5?=
 =?us-ascii?Q?PEZM3Dl7oOxEHbzWZx/4ogblsdPR1r+qf7XX70Hqpua92B53XC6hKTHwnTM0?=
 =?us-ascii?Q?gR7d5Q8M8+6bkRPgfuVjRXIdd/zL9ByD4KxZAH/CjfvnHbilUAU81hOe5y0t?=
 =?us-ascii?Q?uSe2CTimYICF8uwGjheqQOzuws0FA9WPlxuoMMEjd4mnkpa1dUG+52dV3dsK?=
 =?us-ascii?Q?+Xvbut3bx/QZLjcuKuA0/LovaUwXuEIu233//0DcCrqS59jTB3scKzAvhh9y?=
 =?us-ascii?Q?FsaEdwaJpYgizskq3NEQ2QOH1jNJQr9O9pCbUaMpBYWiuRgRwi/2gNgh9AMx?=
 =?us-ascii?Q?2l/+tLeGNqwliTR3UDM=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 49fd19a0-81e1-41f0-5c47-08dda1c1fb88
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB8194.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Jun 2025 10:41:08.0652 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8tWDdMRaJ6nDfIkOHBNVvVva+eypdaF1CWzgIcmhucgpfrFdsKju33KJbmdJ1VZH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI2PR04MB10956
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
index eb22a14fb5..3c5155afde 100644
--- a/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
+++ b/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
@@ -224,26 +224,47 @@ rte_hw_mbuf_free_pool(struct rte_mempool *mp)
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
@@ -259,51 +280,62 @@ rte_dpaa2_mbuf_release(struct rte_mempool *pool __rte_unused,
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
@@ -371,7 +403,7 @@ rte_dpaa2_mbuf_alloc_bulk(struct rte_mempool *pool,
 #endif
 	struct qbman_swp *swp;
 	uint16_t bpid;
-	size_t bufs[DPAA2_MBUF_MAX_ACQ_REL];
+	uint64_t bufs[DPAA2_MBUF_MAX_ACQ_REL];
 	int i, ret;
 	unsigned int n = 0;
 	struct dpaa2_bp_info *bp_info;
@@ -387,56 +419,79 @@ rte_dpaa2_mbuf_alloc_bulk(struct rte_mempool *pool,
 
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
@@ -444,14 +499,21 @@ rte_hw_mbuf_free_bulk(struct rte_mempool *pool,
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
@@ -497,6 +559,7 @@ dpaa2_populate(struct rte_mempool *mp, unsigned int max_objs,
 	      rte_mempool_populate_obj_cb_t *obj_cb, void *obj_cb_arg)
 {
 	struct rte_memseg_list *msl;
+	int ret;
 	/* The memsegment list exists incase the memory is not external.
 	 * So, DMA-Map is required only when memory is provided by user,
 	 * i.e. External.
@@ -505,11 +568,10 @@ dpaa2_populate(struct rte_mempool *mp, unsigned int max_objs,
 
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

