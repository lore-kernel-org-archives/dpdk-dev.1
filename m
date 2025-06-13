Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC8EC71148
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Jun 2025 02:12:13 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ABE5142E6A;
	Fri, 13 Jun 2025 04:11:53 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazon11012002.outbound.protection.outlook.com [52.101.71.2])
 by mails.dpdk.org (Postfix) with ESMTP id 9FC7342E67
 for <dev@dpdk.org>; Fri, 13 Jun 2025 04:11:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Tqih+YaZt6AAXQBUe3Ktd86OPJdb2DHjQ5R2jxD9xr68UhBWbBPkSEL4xhHARmwxGO7YjeUh2BTrm+0vN+HqCZjyFXZLel8Dun8yMhuzOUhEG9zwZPDPXl18FdMV1ejBKMVoK9TXukyshlbaot82O+sYrGczxNZsjyEXB2JChpocnmqjT194ONik4QnIaq5S7bS8bjAvPyoor/a7bttJcdZAyRcX90VZB8pfQ48yKXuJLeFkwB25sZHLrUpIxWOeg/ieCpmndgFtN7r3gDSUbsyIVLE81/0wawYsm56R15NpbXIPlovhCEwPLpYpor4AeGfdxHAIBStz3wsCMjqDcg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhbfsn9nCZ2Vkm2EjCnZRBDP2EBIlAElSJtgXdlnnSk=;
 b=en/u+T2Z1sU40drG5xBYE0n939HY+0L3K5aXSJTFSlrn+9AZj05Ebt06DWT208jJ34qUBcQlpcYd9Uh7XekCkHk4S64lZOO2Q+MgT+KKXtaYcpZzZEf5gLgbhT8cWrKZssKPkrejRCRJvlVUVSKcpLjhTuPgz7LYRwW+FYg2dW7/DztHX6pvZCJApfmAfBKxW5sN7nP5rixj0ChU+JsaZHpihg8VI8hG9DDAqm4GUvoOv/CYk2sHNtsu7Eu1JHLEel/qg0RJD7Qj24jA3+yzyK2gU8zcZv8EFocSVmvndASGYEC/dtLsbjnbQQtM+UZRWAp6wzZwOwfUzOfx5R552Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhbfsn9nCZ2Vkm2EjCnZRBDP2EBIlAElSJtgXdlnnSk=;
 b=Ae51oKKUAvVoAwXZpuqVr99rGaKLuRrjf4GhvIthyW4l6fhCp5wnffkKi0VDiBNjYqQb0zs1PONJ6uL6x/uf+waD9t6FQ5ktMJ8oAwX2lrtqfp2EbZ2ZPZA9iCiNV+tYHkUN35olf0VCWWR9eu94dD04jMWSBgPgf0Wa+W+T1BkxhFpcEpUrmamd0bhCxGUr4xigm1fKfdhRL6HhMyDL3EnONNYalzvPUC4Rq6f/lcXY72zLL/18eL2yoWPZPF0qcKVJcnteyiaJ8mbSxnPTfAW0ZgaY2ERtmWsYEASLxJZkV6hRl2sP0bCK/bJEFTH30Q5VId+UdLVOCXEdYsT3wA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by DB8PR04MB6907.eurprd04.prod.outlook.com (2603:10a6:10:119::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.23; Fri, 13 Jun
 2025 02:11:50 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8835.018; Fri, 13 Jun 2025
 02:11:50 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v5 04/11] mempool/dpaa2: use unified VA to IOVA conversion
Date: Fri, 13 Jun 2025 07:41:18 +0530
Message-Id: <20250613021125.790614-5-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250613021125.790614-1-g.singh@nxp.com>
References: <20250611105149.655144-1-g.singh@nxp.com>
 <20250613021125.790614-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR03CA0124.apcprd03.prod.outlook.com
 (2603:1096:4:91::28) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|DB8PR04MB6907:EE_
X-MS-Office365-Filtering-Correlation-Id: a8bee7b0-441a-4101-1cc7-08ddaa1fa86c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?2dggmYYuYRK06WNYneAZ6dVD9gBLRajdCEJoHDPk6VjaP5GXwotMVQyr3Ox2?=
 =?us-ascii?Q?ChFL5Kea0Gd3Nnqsq35L2KK3K0LF744qu8+Wuu1pWOVVKVJptUxsfxLq9OoC?=
 =?us-ascii?Q?U264ZRzWBVJz+a5Ok7mSXI99Y9qIBVGtYay7c9cnUjW8Xv8huvleY0PfUcI1?=
 =?us-ascii?Q?F0T/zjfBljsI1IKQoNdUBF0r5YRsHYXQvP2dXFi7XIX00duXjHl9KGMJleVq?=
 =?us-ascii?Q?7+7De1cQ2OzWf9BG/ThF7H2Ger8U6XJzloIBq6ISs0GXDuwdZUTQ3nXLBotx?=
 =?us-ascii?Q?emnjc+Y/mqzKjWlBWO6OxorFtsEAV2/fjJ11+cWsb/RPW7zTBYr9zZgi6qI8?=
 =?us-ascii?Q?VMFXcqZSa5jxAOOue1ILTL0ISpZozPLLexN218Nw/HVkDKL1ra5in0zA7TWa?=
 =?us-ascii?Q?+gWFCCe9HPCWL82RKdyaz9XkcvdHUtVPYMMI3P9aqG3g2W4zjMoep8fG4oTr?=
 =?us-ascii?Q?s5blDZXFYrfYE9Yb5yMDjWW4Kmv4odNLhZWxYVwCdrJ7mQN5JCB57qruAvQ/?=
 =?us-ascii?Q?Galchw9r0SkmL/EfUkLK2SGA3msxzE2ldLH1h3wYy3ejbRy5YydvpON+JB0R?=
 =?us-ascii?Q?vxbGoENe9O0SMnOFMuNFIpr7Bn+sbkHQ6+bddYceNNVpiCuedPXaUgy23kj5?=
 =?us-ascii?Q?u8wVgacbdhAjqrKQS/87h/AF0GT7uuLuPg12fflGH2o+PxnlOv9kZHnFpHtU?=
 =?us-ascii?Q?9wUyIXxbXri+oRcUa4mX3isCWLDPsQmc0CcyT9W1OgcNj1vjIi+a55/l1Ipl?=
 =?us-ascii?Q?4iFczuP5IJs6m7zqAOCTkGYxO+eL9Ql7pPEFuLWwH6KjUvIh1D34e76QSaMK?=
 =?us-ascii?Q?o0XzIVhO5nZnCIVxlwH4i7bf5l6lXFqVQTZa3oHmzFrq8E4MKqj8XAxPa+MJ?=
 =?us-ascii?Q?Xich0dNf+z7Hu9Rn2ddaUm41B7bQD3Xkke+tyclFfl/AYWaI/hj1U9QP6SDP?=
 =?us-ascii?Q?0vRZSFO426XPMDr7NOqc7e8lDy7rBo87lAWk3Q/IEEfP0ssy0d5qDGuSsdMn?=
 =?us-ascii?Q?LSJyqTkc7s8L1SlbJ3AB9Bh+QwWgLL0tBPyK15mcAH2EFEWTYYb1ly2Iw/xh?=
 =?us-ascii?Q?3jLhM3NzIfklQ4+bjnLASvw/M+5gqZqeyc7HLzTLZAFa/lp78lPCD69bKP00?=
 =?us-ascii?Q?Icqxn00RIkKy2YF+Q7geWcHVpkdm7wCuWc1TGWLeONKhQ7tzmqacNxPbVDXH?=
 =?us-ascii?Q?GQ5fInS9M/W7Jp87J+FKUmjzIkwIJ8qmayk72+JwbH6VaKh7Zc3c/JXcTWF0?=
 =?us-ascii?Q?LREWSSV5Oq8Ibg/ekIL04Tqu2+EBCT5zKJJRLr5Pg+xQNOoN4vAkr5wDVBLO?=
 =?us-ascii?Q?gi/iJbcJY0EXtvEfrYP3GNbxHtpsB7YV8KszEaz5dybbBoaXN4PvSL6katKw?=
 =?us-ascii?Q?KkPr7jRGCS3LTclex3w0HGTIlfR2sm7bmJRSiDOF/yQeQe5bLTkwpGgO4Pwd?=
 =?us-ascii?Q?CUjhng5jlEEQf6tguoCtgtgmBHCqMF8GYKk+atELBiL7YtpqIq3PAQ=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?uI6+OjSkbhfAFFtMnpHx4LPE38Pq5kbeDtSR7wmmfr/TvYu2OdVUXu1ggmP0?=
 =?us-ascii?Q?6BNJeb2YM5WsQT72VD+TL75src3H+4j1ceXKccNx82Uqa9XKaNqUId5EyzsZ?=
 =?us-ascii?Q?pr28g6nXWjwjqn0dwqcke8rhaainF6c98/Xfh8C5F7yEflvK0Isiif3gxKff?=
 =?us-ascii?Q?rSYsSFGYs/mj0dTgcN/RBRf2il00UOtP3V3roKpa/mVdVnOMQsWNuxFp7Q/b?=
 =?us-ascii?Q?jidLl7IvqQx63J9PEQyNu9ffJ/YutNRC9NmYAceTikeNR3CF2GXLaTA99E6X?=
 =?us-ascii?Q?6C2x0feOiI/hO2V0wA121c4wsHpSxaY8MaWKnall89LZcRIIhp5xumPmpx4O?=
 =?us-ascii?Q?tUxQvwIOccJPI/13ldHcJ5zxKQ8h7VIB1AetmX80ikVMcqQUqDOntgoTz3fj?=
 =?us-ascii?Q?r3gZEkOCn/5/SHEkZrQ0UhDNmQ37K2sXUbCU/cM2OST4TyHw0izQP6aslNPA?=
 =?us-ascii?Q?iHD0o31rLqVaEJI8uXxHHM7TIJV/zgq6G/I2y0J1MBwSZOLRnpjZSqbLa3v1?=
 =?us-ascii?Q?ggq8+E8Pnpzept7AMNRcA80pteLKAAH3pg6McjaVpVh163L3yippw7zJ0PSh?=
 =?us-ascii?Q?rXeujvRzh0nP5/NG+Y/vONCORZZ4Myp5ztt+A64CzpQP+BY47o7VYO46tSdX?=
 =?us-ascii?Q?613e45EHCQQbLw9b2Tj8niK94VxwR0QnLT/H6vuxg0/gi7RhOqz5xyRd2R+Q?=
 =?us-ascii?Q?RGqmVqfarD9IdpKyuowaNVY3+Ge9oxcu8EfB2cc/M0JThHrsIVbuodSowB6J?=
 =?us-ascii?Q?52jUZiZpnmDqfXwWn5RR0uDGyO563Q9d7gMQImlwAcjHHR6IDMYowBQkUPCn?=
 =?us-ascii?Q?9bS++PdGHPWfMDzjEA3CQxJeyGVs4WpRvx+jFz2jff2nFiCepZcsPlkdqBH7?=
 =?us-ascii?Q?DPbIzVzjqidQhlJ/P7bsRiNRMW7tQn7RIeT473DUqItkpmCl6WesM9YWCNfA?=
 =?us-ascii?Q?uvp2RVTKWivd6MJ5wmmJtcmbbXgBH+cE4+wVyGk6aE1dzeH+Bc24VIxhXmA1?=
 =?us-ascii?Q?v9+2C8md94tka051YXMEOO0WgbYTdV6DSQgBU2vsuifiYuOrz4LGZhb1FOPo?=
 =?us-ascii?Q?EioRD3joJPUSHbYE9R7B8Y86aESukKXkrJcN/WwpWSDgmaItDCs5S9IJCvek?=
 =?us-ascii?Q?bqGMh82Hhtl/rSYIhQXMniNoTjnH3t8zKmEvvJf95k/nM7gxDSvU7E+i2/Is?=
 =?us-ascii?Q?Hwb2dYrpLlxb7KThpyyYLBMH/o0NR80qU7byXV64HqClvxDTBfThIFI0UmjF?=
 =?us-ascii?Q?F9ZGT8XrGj+XiPRSWku+Bz2vVAi96PATnYe8h/CbzTMUJ8Iop3ZDEEmtNgRv?=
 =?us-ascii?Q?uUa6Ag9OSgPI0AYoZ2mQp+Er6vf3XGywBnDNAMIvuTJe+a9v94emunEuiPN8?=
 =?us-ascii?Q?bpcvdTer8nE1WmYFyZRxJAjUTeC5epr3b4f4fZrPzMbAMF/eqEwflCMS/lUD?=
 =?us-ascii?Q?nEaKQgQ8WHKJV/MhufPLvRbo4HZKmuPjSp4uRHggpuG1x7pG+IuBUrygZyYU?=
 =?us-ascii?Q?FMFdDGJr2IoYfMP7BD7f5EWj0tzP5KNPQyReNdY18cd0aN6pzGln19W2yPWa?=
 =?us-ascii?Q?gIIgaDHGzAX2mqqj9gI=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8bee7b0-441a-4101-1cc7-08ddaa1fa86c
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jun 2025 02:11:50.6825 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NEWU7KLp9Fdt98qFj76b7405Ff2/z3oYJKhnkQSNyYK+0naIq2KSqygrOMexSFX8
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6907
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

