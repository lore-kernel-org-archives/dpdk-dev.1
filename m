Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A369BC677C4
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Jun 2025 10:52:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E655840685;
	Wed, 11 Jun 2025 12:52:21 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11011033.outbound.protection.outlook.com [52.101.65.33])
 by mails.dpdk.org (Postfix) with ESMTP id 82F89406A2
 for <dev@dpdk.org>; Wed, 11 Jun 2025 12:52:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bbeZoIiB1qjKSDbsTEnEe2Tj3Bd3axtVDNzJ2jVHWFHvlYPpUcOJcSP0IGBbO1reQizT8ZquRM/cKJMQE6gH6tbTLY1V8MyqF/IsJf0gsMFUEzu0cz3vce4kTgniZWHLD6IPjYVdHQtB9iXUCaOTuFqXXIG2eg10yEzjrakgEF+eUMQx7YDQt6y83zEHM+dsWMq1jrYLD8u+6jcvRvIeC4nJzHbZKNA6XiPv5ZRhYAO3EVci7idgXsGkjhRmwXQCM3NJdHrJkKI6M41xof24adWACMT6DJhYUcS+5jw2KAPcFThBxISwLEE9wOmNvpy/RXYTwopC9jQ2fJ6t9r/LTg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhbfsn9nCZ2Vkm2EjCnZRBDP2EBIlAElSJtgXdlnnSk=;
 b=sKCuIHOvt3pD3hNIh5KCQxwYZ2m2TAh75zi07rwXsF95KcQoItzvwe6N2TYWZChhDcVhf+NybkRu3q3cMsDee6Fn3RlwXCMZWUYxNzuLO+Vh4GrJcXwJTRb6gVbbp5LprnCNggIkedwXOi6AJGeT8jxHEpv1t/PiczJGN8O1q0wGD0rnFY1zlHYwio6LOx65NSQRVqzGpSOuuiJjCdtTQ0xZZdMlQv0AxxFAFDfNjrqiUz1FT7Zn1pjNi4Y6tDuEHOcJpiUOpQvLumcmhviow1Lu9wdUcU15jcuO930siudYDshwZyHDiOvo9lfx1ujyoKZCzoaQTNmqk0w85I7OWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhbfsn9nCZ2Vkm2EjCnZRBDP2EBIlAElSJtgXdlnnSk=;
 b=m7mdCgKStQrhzT6LYIM6xKipJ9D4fhHKIClpHer5JlbQx7U/nlMV3Y4J0HMiY16EiGvZSM+WF4Hs25EYr5iiMcY7uLNnqJbTn6VufIBunyrIMwg0yaAqwCMOLbwWnpM8u0T2+d0xeXe7adGS+vOUBY+zCGYYSPbR0veDzkmrkj31+xzZtDtrG+ysl1wqwpzERsKFM8mAEg0SO+Sv7gvNvi+B7fyGzyqISehN0iO43myDZz87TPEJeRgsWmYGjUW2zCyzCHfrQ450TA8uA0NpGu8e999mOvR5PR3Ay2bHVG0eI0rCo+/YFWR6bYWVU1LtpGtWRfR7SpJsYtM7xdguBA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM8PR04MB7348.eurprd04.prod.outlook.com (2603:10a6:20b:1db::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.30; Wed, 11 Jun
 2025 10:52:16 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8813.024; Wed, 11 Jun 2025
 10:52:16 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v4 04/11] mempool/dpaa2: use unified VA to IOVA conversion
Date: Wed, 11 Jun 2025 16:21:42 +0530
Message-Id: <20250611105149.655144-5-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250611105149.655144-1-g.singh@nxp.com>
References: <20250609025450.3997062-1-g.singh@nxp.com>
 <20250611105149.655144-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2P153CA0021.APCP153.PROD.OUTLOOK.COM
 (2603:1096:4:190::20) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AM8PR04MB7348:EE_
X-MS-Office365-Filtering-Correlation-Id: aa84bd33-2edd-4446-0ae4-08dda8d607a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?/zJjpGAvt6zQpFe4LSrEL/3Ku7Mgc/b2BnyM5fu7y70iop8WD5eJ9Okjf0e+?=
 =?us-ascii?Q?TofbnlICIcjm+UqQI/ZroyW+cfH2COztr4EhyXmx32USDvKxyz896cXvIBIp?=
 =?us-ascii?Q?IZVuyX19PZJTGsD3xXNfUVY8HlbdRQvHUzCaEJWPxO5aFoJFj7/EMTWOFzIq?=
 =?us-ascii?Q?h+GG3rWZvv1FJMr7+0rRwEBzOsBXwpScUVccmumpGduSPiK0ekTZVpU7SVzy?=
 =?us-ascii?Q?8NhHHyin2SIEU5cIw6zavM7zO1vU6vVrrdwOy7eHxuOEwf/0s0s1FKgt7YYt?=
 =?us-ascii?Q?zx8PgHlkoC11VlTYR/EJPEiv7M2AVK+xceyvoRiqTrT5su5jHrOCimtHDRvO?=
 =?us-ascii?Q?OC/27wGNm877xmic9obPbc8Jv+bEdvVKkk8RM+aVdEYyJGvPDPj/TqeJ4e+G?=
 =?us-ascii?Q?mhZi/+qgei0xmwaB6TZO+PZeg10y6GSb0zvGCptJwos1V6JTyZB3wp8NVcc9?=
 =?us-ascii?Q?glVeuMSOksuyXPYq1/0rQJEnnIbliq2FeCi99/z5v30tJajAQTHJIuQfMlsH?=
 =?us-ascii?Q?dslrhRUMZSbFp/OvboK5DqdEu/xQVulujoK2Pyjzq8+Yg8Wt73eBDnpWOgEZ?=
 =?us-ascii?Q?8saoHpiq2mDjaKA00Yk/yigxDzDB/W9ME2cZBHl+kVha5BVXmkF42PoOxs/z?=
 =?us-ascii?Q?wU3sGvgxAnGvjI+B+gDTWDjM81Jj88f8oP6IFF4EJUPoF9ZE85HaSE+Z/Zvs?=
 =?us-ascii?Q?lCbjBihxY57OtzgctuWiVZultOs+ar1S58LDhmbWSc3DfYkzjTJM4YVyPFLV?=
 =?us-ascii?Q?nhnNDlapPBE6RjTpxbAnwcAIko45dbAYZ4PMX634d3vjemswNJhMD/mGNnys?=
 =?us-ascii?Q?V2oJPF+20w1FPVYxuvkM8y6mu9B+kXpXO6CsMcoPjwIgqxjAAgO3Tq2Lu8KO?=
 =?us-ascii?Q?AYQWQNFLAgISHIPu6gTX0rmMSl6W3hNa7HRrunUwyw8+EfK+irj99BNRD5Sj?=
 =?us-ascii?Q?Cqkm+BvS4GbGLGOgDKByQGeRnggWkGYBt0t97LKslIEnVw5DzOKMXlKea6fe?=
 =?us-ascii?Q?C/7v1z5jbO0zMG6d3G2812f3tESmMNrRphej3jhM920izEIAle0OOIG5rTGT?=
 =?us-ascii?Q?VE1NsRZAEAnpMH9uqVftNZuRoYbhp2Hu9y6aEPR5klbBTynIT5MtHza9/bLv?=
 =?us-ascii?Q?vVeLL+VvPEgL3PjtPbaAAxwmDmI6FXMqHg34PhQ+dS8QBv30ZYpczy4VHAE5?=
 =?us-ascii?Q?sw7OH8J2iv3W3ytuUEuVomsNTL2Vf5M36HJ5IuFXb88hGZ1fCRmTEhNv+S76?=
 =?us-ascii?Q?2iZ36I4dIg/tQ6h4jxKCZ/RBesonEVmYiD1h7FBa7GQmGi4HAxwg9QA6WFg/?=
 =?us-ascii?Q?yVQzhIXKhrDwV3YZ7qmcg7XPwC+GAGZA27/iaa7+WMsqzl0KnmDyoEgvioCA?=
 =?us-ascii?Q?S5Q49eXFMYPzQGiCgYIm9N/VxJXwSRR4sQuQnq00maKQijIzrC8nD4UP2q76?=
 =?us-ascii?Q?f6tbsxj0p9qO4Lj7/Vvsv10G8caSo3jF/3rxES3ZjgFZScWuijAahDdgS1Mk?=
 =?us-ascii?Q?u+ukP9IYjLbc8c8=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Vn050uHm91GAbic2HxZPxFiLT9WNaIM8ci3+ZH4zbeb7QF9Uh0iINXn2Pvbr?=
 =?us-ascii?Q?q2iDfdEYMwWOwt1WhbBi8lZ/GtfGg2ALMb88XM0OkIe21BO+MGcWXXdVXdYh?=
 =?us-ascii?Q?yHoVmjUClCqstKDFEUsAW5He0L3FM//UonEDsIIUV6BV3EQDYPCbdBpDmdxj?=
 =?us-ascii?Q?AGd1S6kHCH0CgR3z/J3t6KuVwG7ppQ/fdSmUrZ28S92TR99MOqxSusz2xd6Q?=
 =?us-ascii?Q?bFb6wkwawYp4JOhAqA6VD2iryQe7U4n3dSmuO4AnAvm5hYekUKYUsIk5oK8V?=
 =?us-ascii?Q?EN7gn11GmUOyPz5XGmqHcaRuKofXezfCT1NPTdUMsONqBLGln12Ww7PoCtkw?=
 =?us-ascii?Q?312/10QyLYkFuAjkeroGvEuLISOZkyMa/pY3lcPxSDj0AdI4MCHT2afpA8Lj?=
 =?us-ascii?Q?QDX0xQ80qm5OtjS5ORa+Pye8DR+3H7tYg9UMH45tKSBR1fp0UUMGyt8ao0uM?=
 =?us-ascii?Q?UTaaU0rOsZWvZLZ564yXmGQMM53nurXw9hj7zib88r/1Jn3VSYDLiooBHRN+?=
 =?us-ascii?Q?AR2lUV9A0yd+3uoM9XrSBmUnDqbH/i+ZmMyDE6LpqD2mBA+y0zl72JwhFqna?=
 =?us-ascii?Q?gS9fsqYqC5fLoE2xKMDOcj/RxN/oscmqSJQrDDK49BEJDvYEO7aYgh2wxqwE?=
 =?us-ascii?Q?U8IzBtXfsyuY6dGVfyP7EZsIPXq+EBifJxurgYGGBjmJ+YTP50DCOkc2Vwpv?=
 =?us-ascii?Q?LbWcuQke6ENJdkykmHqYfbr8OQu8pKbGZSTZy1oLIjEo+XYNqoRpjdKbkKof?=
 =?us-ascii?Q?CRzQKGRAKo3athqemm26Xs8JBY3WA7vion0MaIZH8jgWXHLV3b8IB2EIulcc?=
 =?us-ascii?Q?XkNLcLWaVvNEp9cHyp8uWCcOFj2c8Nw7LrqYi+dQynPlQvtBYH3yUQX1hBIz?=
 =?us-ascii?Q?R4ZMB9OevOCN5n+NLImLVZSTmu3aUprB+SJRp1nGUFTPAf/6yHr4yjU66sJk?=
 =?us-ascii?Q?t7TCqlK8e9NHFYCNTbpfHUgfcEwFSrq0oYIh1Y6B0V/m1IF9wext9MXh19Tn?=
 =?us-ascii?Q?jPcibijk9r9Agw1ZF4Xf4MONeTW1k/QWlLVS/fuH/hoPDPw+w0qTW3emzL/h?=
 =?us-ascii?Q?KSQDglphYSk9dlju57ttSV5ZW6tpxkcyy8+MskeHlHuTyxGu6I1G4vGxGo59?=
 =?us-ascii?Q?Rdu/dNfX4fAr8aqCgoOqZK6VRzbWV2Y7QplohvuG7/GP0Or/o/HMPFjpN/e5?=
 =?us-ascii?Q?8s8Y8XSwbYqyrO7sxn6fpgNBF9gtviLbAhd9kUmeHDnUj0RLeNtoJdfipI/V?=
 =?us-ascii?Q?VD3JWWJVawcKIcVKhscIq2XbZlE4x0ad+I7s4y8kVoUdACGvdnKabJMiwqDF?=
 =?us-ascii?Q?MyX6PaiIalfA6StnHdYZHC90fu6zH4dmd2b3rBr0gw54+mWWdnUTB36+8fuc?=
 =?us-ascii?Q?nuxQ69WtdM/tI2oD1m0hCPXp+yzUFZp0WHFAuB8RT27QU0K2RZPl92ccHIAV?=
 =?us-ascii?Q?Lak9qsxbI9xIc0evNLI15obCvP50B/S2SbSb9NqAh2JszZ2NDUVBsNaHLkld?=
 =?us-ascii?Q?waqYoZ3V5zSYXCg2oNf4kM6tkmxjOYdt6l2xFp1diqZo6TPDslWHkSc5i/V+?=
 =?us-ascii?Q?CkLaX0IPP9v0IWyCqoY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aa84bd33-2edd-4446-0ae4-08dda8d607a5
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jun 2025 10:52:16.4856 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: daZezW6jAIlahCGWUhJoZs7POrf0i979Ql6mjoGF/XfzjpTKPmtK6/Uem2UGgLt8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7348
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

