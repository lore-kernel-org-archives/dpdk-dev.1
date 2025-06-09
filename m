Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01884C61CE7
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Jun 2025 02:55:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DAE5440685;
	Mon,  9 Jun 2025 04:55:34 +0200 (CEST)
Received: from DUZPR83CU001.outbound.protection.outlook.com
 (mail-northeuropeazon11012014.outbound.protection.outlook.com [52.101.66.14])
 by mails.dpdk.org (Postfix) with ESMTP id 460804066C
 for <dev@dpdk.org>; Mon,  9 Jun 2025 04:55:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=K8kBup56XXdUd0qtsLXLhL7nAtwP7FlnqarVGGazoCNqxr4+XU1UD89NDFngaNaG+byK160KKA7f36bZLNhCSev6S9cvmqW8CR6jK759NiWKvp83YqvregUSOhKQJgckTr+dT7MF78v0LfkCGiFc5yGYJDFjpl43AXv9CrmSzgBtudIXcmINv/EaSQ/KmoMBHOj5h3akNO6RSeo1ARWdBkZ7RiyNlot9CmLnkFuycLuLpDiBa2Z1rVTOEahdla5gHqVrxifVssREaNYdatz36GqCQ+NouhtVFZdSU3g6Erb/CC5bhQ3KN7h26qAEYovhLzkWzn3WKwUW6lVXKOOoCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8eq0sd+7N+dOCZToSvDNdKghJmwLiqN3FeK7LVan0kE=;
 b=eMHjPUKN5TkbzeVUN5IoAwzVch8lAizsxWtafqq23TQtFqXF5kHGqM+/cJyBx3BP41tWlfIvnoSM8SGglrcNHaUBbLd553UCTA41vY1WGISUIopCKAJg50qGz/MuuJZhCsHuvaeka0N83Tk02cKnh9o1jiXunhJsO9F0c97RuGZY63qltXcUz387rZ9ZeH/dcJXBxtYimjd8k+Be/e0KGrcM7bENd5oAQGXV8J0wcnxPvgZrtj20nQt27+Pn8iGPTrtvHi10/vDjpEO1xaXNruEG7EdwJaLdVAj+kUmYpN3O+ZS3jXG5hEJFsoW1xOdbfVO2XF/nT4pm7XQM8pKd3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8eq0sd+7N+dOCZToSvDNdKghJmwLiqN3FeK7LVan0kE=;
 b=kyL1okoS92xvk6xufcpxqGB5CApdEMiIFeWb0K4ayl3QAigH0gLCHhysUPnjew//srvxfufiF/NWwdqGNIV496p9b65W1/wqBA64KZGnbBnGMKBWZLZz1YnaMtOl/UUbJCvedK9KX5amGssIuyQwLn8/5kXNb+czUYtbltvePIWqLCg85fpbk0iufVjqcJPeoiPtLoqAmXjjyAi/8vln5svuIfZAs242RK/XPClxdf3Jms6blw2IpTMKc02Uakh9fTHjpXxiQq5KlPYfQfmyTfHqz2pGgK5mqLNYk3Xc00lzjb6+Sv5pzOWqYYa/IQmMKffwFt+PqbVnuGgsh+0f/Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AS8PR04MB9093.eurprd04.prod.outlook.com (2603:10a6:20b:444::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8813.20; Mon, 9 Jun
 2025 02:55:16 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8813.024; Mon, 9 Jun 2025
 02:55:16 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v3 04/11] mempool/dpaa2: use unified VA to IOVA conversion
Date: Mon,  9 Jun 2025 08:24:43 +0530
Message-Id: <20250609025450.3997062-5-g.singh@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: c0db4d1e-66e4-477e-a176-08dda701100e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Ew0Obct88ei5wvG37u/q13TouhvOckjNCqjbXFIUVaatm5voJ0yf0aNgig1s?=
 =?us-ascii?Q?bNjzR/1fSyDs77lo3vIec6bX3H30ZbCTDpjb1c4jUhD3fx3ZmvB1dxKIs9Ri?=
 =?us-ascii?Q?IC0VQ/r0ZUeeVsuu6V5UkwD0ua6ZJTWbMxmMTe+MFOQJTPDAwdXL+fG54GCM?=
 =?us-ascii?Q?EGXKgpBFB5pyo0Vy+S5E9TUfirVXFSF7MBsq+xvB7I2m6z+Fq5QMjG/ujyo6?=
 =?us-ascii?Q?RB2CT7f2lO9AbF9kOHj9hdPI7bB8Ruy10ZR7UvGVwWRe8PTwyD46v2jcenca?=
 =?us-ascii?Q?U3LJkRr+Ik7QnuOq3B+iXt5Lj7MlkjDGP36LuwV+sQklg3ZXskW6kfuZAahV?=
 =?us-ascii?Q?W61Kw3Gg5GA2M6U9jGTs9EkpXsVyZVs4bZUZa5wezvAaRW+kj5AuJ6Fj4UCj?=
 =?us-ascii?Q?Mtr+q/8xPju6SSyzBO7Nal0v/h/riZF+VpnGDuOPFlUfiR9EJEdCisWyUEnl?=
 =?us-ascii?Q?K9kkykcY6mWeLAAOwhGtusm+AuBhdt7Ab2soDgh0hc/QJdWRsqHLjPoZ77os?=
 =?us-ascii?Q?S3X8xRlASf8oWotHc7Ay+0tol3Pt4SRK8zoXPISdObelNywchSQaYEualnq+?=
 =?us-ascii?Q?tCi90phlMjUfVajryqT/PkQ9O0Kzm87yH0YbEpDqJ2PH5pWsCDQt4Q6gwVGy?=
 =?us-ascii?Q?od9Z6FQGzFpYYKCAx8JVKfDFY/RJ4QEgvs+0HI3c1aHGKVBXEedqGtqJKmp/?=
 =?us-ascii?Q?QX5b9ZJom7pdp8yaCT+dR0qGYUZI20fV2AgnoUhV28DZXQAMqfU3kAn79mWT?=
 =?us-ascii?Q?JJR+V4+gkRu5eHhqw6zhxehiYWxzEULoWC/tOyGCcGiUE3JZu/OdzPzI311o?=
 =?us-ascii?Q?phdBqHkdEguum3Hlmhiv9/9WuC5X237iUWOJngMsBKPOK9sirzam80MoS1nE?=
 =?us-ascii?Q?TscFox0MwQZpHzLbHXk2BJ7kQTdzvuDsUJe0Wlyo3C5W+EGW+GqIwNp2dUdM?=
 =?us-ascii?Q?gKOnEM9sOkqU0NGkVde/QSu5wTURX2C/f1n1dLeUwPF285eSOyc+KO3CljXm?=
 =?us-ascii?Q?8gJHhvNZSZfO7bokvznjKRQ0xztk8jIS60l1Cfs/9udQILXbepCRoAxkoPFa?=
 =?us-ascii?Q?Il/G5UG0BkdKdTi3+/TRF/zdHFau8uS6Ju6nxhuN5C4NbL7q/BZynsz8lsQ7?=
 =?us-ascii?Q?39ad6lheJnYn3tRO7Vw9tpanfNxqVNRSWbGIRyLOvaMkt2tHT9wPPVgQ7prG?=
 =?us-ascii?Q?wduyhRlGOrtlmbwdKoCYrsPgCTa62sF+1bOMnVt75WPdZc+rkyA8qnDL+eE1?=
 =?us-ascii?Q?0DAaffnT0z4nGU1QGCo9pL29KJsWQiqER9duMq8hE6lYjUVYP00LN7FohGhP?=
 =?us-ascii?Q?KV8U9FqpjoKtoU0+fLLEQuZtsHIZW8/BThkF8o2TgVZCmijU2Xp/uHi/CsoY?=
 =?us-ascii?Q?ujkPV7jvUFaPAQOrCq+Gs+isVitgA15C71OJvHRTIoDZiiTC13rsL+GIO7ru?=
 =?us-ascii?Q?xVZdh/tZZiYRwx5YVkPT8ufXvJDu9PfeX4Y/fHCSKEIEZ6fzgMrW+1CfzMQN?=
 =?us-ascii?Q?KhBa2p7FdGSyvjo=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?TNnAebpZfOmXb//9gkfAjrE3BT/orU08tAi/50/9jGWQD0urBbqIFjCdiuNs?=
 =?us-ascii?Q?wQj6KggL/4aBMsq8jMXd9iqgT6sD8gJY+8/jW94zAF9X2iUqQ4T/dh3029jG?=
 =?us-ascii?Q?rRmHQ/jJs36cMp7hGx1A47GjoZHGqxAZ4JGu04C1RGR8HuQ3A7BxlBmZmFqx?=
 =?us-ascii?Q?Zbx6w8+v4hqqLkXQN35CyGq7YF90ktfqB/+KI6fhv4c7r0ueDyUT6GjkemtW?=
 =?us-ascii?Q?keLUosmL9u529eCEa2vEO3denP64mT3SJYwrskXRf7g9og4NQU8uGwNf2F2r?=
 =?us-ascii?Q?SRiK7142Rplqrx/wyaSYLCzzZY3xXzcP+LQmpIqK3BrEb3awwWi93sKdA4yQ?=
 =?us-ascii?Q?WbpSdiUJTEfFAaR76xLUkMEfP5QCcrIUhwIIJqkn6MrKOSo9TInTELRVmf8Y?=
 =?us-ascii?Q?9S/J+yb80SOygxDkaa41v0WzM/XacikE9iMuVTTuwIL1wAC3D1LILGe7EP+c?=
 =?us-ascii?Q?NV4ddENHewOSumjsu5rIzdtRZRY5+jMNxYyGLUJtuabnaTXMh7r3cOn/FCjN?=
 =?us-ascii?Q?uYOB4bUSVMLST5UjTfbeaa1OHcK9Waqv2EHDP33cg+i6If/Y9NmX5FyN0BSI?=
 =?us-ascii?Q?aRwez3KTeBU64uiXvauRALtPLjENi0yUyn0N+kYtR44Bf5XZy2hRUwfSzOpO?=
 =?us-ascii?Q?+szDBe77+FRMcwXgIRQArXrzgVkBjfy//foskwhAZmRHZijjnYPHj1iHiaaC?=
 =?us-ascii?Q?9hivFK/aPyEXSOU6KmmhyxboPoMUd9I9RfGtgf9QqoX5dCR5obO/WF6UJ8Cx?=
 =?us-ascii?Q?oSsQ8P8t+UJ5k4AXVEygoT8HAgSpGolaxo1Jwnp1B7g4/xhteeDKasqSvofJ?=
 =?us-ascii?Q?rOEs6tAXymckPFBaVJhqLPIGz4tChcUAxpClW+G6uHldGbGacFj7Xqyz/3ac?=
 =?us-ascii?Q?y/NATt7x9W1/H2nP1fwwBdvcNLHnoBoLSjDgDD3iyyRS2pJZPErjUVsyzmpE?=
 =?us-ascii?Q?txOjwSkUvEMSAN82+KRss2mnKDv7E5Af6iSH3Ch81YL7wh1kqNqpHISFn257?=
 =?us-ascii?Q?OpS6RINLxjvDAg+FNPe0y7YjvRH8QcLrgW7mrVG6xpWR/dQrzoslFYuO7PN+?=
 =?us-ascii?Q?yEa8+SxBAuuDShpowHRWeMNq4zgBPdFYxGXpdC8k+nzYODkAnjEUBjKNGDIk?=
 =?us-ascii?Q?k+pq9YR8oePVc3L8+BrCRC8CKsGX6jgaRaYulR/PAyzkTgPqVJdV5qdgeZFZ?=
 =?us-ascii?Q?jRKyaek1/xPGGwAW3nCklNcPz2D87tIkYOEouG6vL2m+6+bQWNLZzqZgDHMX?=
 =?us-ascii?Q?J+kAPpkSXsDHza2ioOJVHQCicqwBUTfLp1xwk85qhqLjNOvBWinjevlRdU3P?=
 =?us-ascii?Q?BRUON/Ejk1xxtmPqmudeiDb95NcDJErFLjWOjM62Mo7AW+uIoIq9xkVw4dfY?=
 =?us-ascii?Q?4qhhxEiIo0JKIL67ZO8t75NXNzej3rSoJmNIxd+WhKpgMWFGGc2QXSmW1Qi7?=
 =?us-ascii?Q?Dzc0TKqMR0pfFR1ttui82ombfH0rqr3sOspkRu0JImiTeKGKVLcuZp8gmYbe?=
 =?us-ascii?Q?ILqpngB3m0qql7FyEs7SVy3cgGGxygu6G2TS3z+ACGBeTqJIvWYvj1eGg4CG?=
 =?us-ascii?Q?bgd0eP1lwnzhTIuVBYo=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c0db4d1e-66e4-477e-a176-08dda701100e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2025 02:55:16.7202 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XFVtHZ/4/djMTBlGg4egIts6ukmKbjifPIRlmlr8r6n2hDrZOIFj+83JYSi3gPIi
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

