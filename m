Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5ED1C8302F
	for <dpdk-dev@archiver.kernel.org>; Tue,  1 Jul 2025 04:30:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6FF9240655;
	Tue,  1 Jul 2025 06:29:41 +0200 (CEST)
Received: from AS8PR03CU001.outbound.protection.outlook.com
 (mail-westeuropeazon11012019.outbound.protection.outlook.com [52.101.71.19])
 by mails.dpdk.org (Postfix) with ESMTP id D656D402B1
 for <dev@dpdk.org>; Tue,  1 Jul 2025 06:29:38 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T+uaBsy2E5AsGeSfP2wHhX/29rqNZ8wRzd0twcIVooA9D8lIaR3S3cU2z1QFx0kxXYXjnJNTYristorzLV7iAoO4UdI+meDaOrP7w8StoA69rH2KHpzF84Z6t9XSe6q0+wBgX1BF7chLiA62vy3qz8O5/Rj//8kotI07Gt40i+vucgMxvmpPduwprf76sVQWe7WwEwiImctd82qnupmpUg+1w055GIhtJpk2j9YbWXMpmpH/gRftCcM10S2Oaw1bEBAeqMiSb7WbBREhCjijOUjcCoIyHIAVngF1OPyxeNyNIIWi/B2RN/o+iprQjON1EUlFZtS8kqE3N75+dIZ2HA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xhbfsn9nCZ2Vkm2EjCnZRBDP2EBIlAElSJtgXdlnnSk=;
 b=RlzqnK21jQhQZiTpLRbxXYvkO/X00Q51H2OovlOj6qAhQIN+vjO3st/XJUKNLsMwj4ZESmEambOXsjkx41x3PpnGbSYUGxEumpR10sqboR0FVU0YUSAEdhQbp0QWZXAOAYnLNUrsG9KyDuncshsEQNrgi4Ph1VfDVgr/cHWrGZaS/N/faYDz7QXIZrGmyux4jua9yrK5OR1PX63LiYk79soJROXtyf12WhlMrYdnsBNJJuRNrSny/bq0+iCjeDkjViCg8f/aQykcRbI8l35z5SWHq2a3Mu0WGZusdaTZ2mPqphfmp/wlLL6VFbJGjkzelZ8XBTAnoaMWYsl3RZW6wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xhbfsn9nCZ2Vkm2EjCnZRBDP2EBIlAElSJtgXdlnnSk=;
 b=B7C8KBZzrbw+/gRFiKRPVdksB7N32D0yZF8EtkZck5QYvNsbVB8WQcfmXknbVyHA2GcwwWhvISO0nNXFRE7OHqoapOZ72n5AWn3bBLySptO76KDaWqqzcVD/llDvMX8mf0teZRJLg5BsafVX4+fKCOyfep2U6ENQ+EH8Cd8BcIJhUd14458w2CUPcaU/5+tHsfROHhs7xC/QCR1FCwoT7H5FRMrIR3gaoSe4QjS8bbY52gaQE04F7FwfyShe5Sp3Z/ScT5nr2MMFV1IrDEwAgQCIPkhDFAJjanaYSQlTh8lY7K+NLLC/cXT+X/b/PVDPFT4OsIsODhTJ5OUqdozLmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by PA4PR04MB7647.eurprd04.prod.outlook.com (2603:10a6:102:ef::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.32; Tue, 1 Jul
 2025 04:29:38 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%4]) with mapi id 15.20.8880.029; Tue, 1 Jul 2025
 04:29:38 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH v7 4/6] mempool/dpaa2: use unified VA to IOVA conversion
Date: Tue,  1 Jul 2025 09:59:15 +0530
Message-Id: <20250701042917.3000355-5-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250701042917.3000355-1-g.singh@nxp.com>
References: <20250630095800.2943863-1-g.singh@nxp.com>
 <20250701042917.3000355-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: MA0PR01CA0109.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:a01:11d::8) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|PA4PR04MB7647:EE_
X-MS-Office365-Filtering-Correlation-Id: 78d28735-8100-41bb-fb08-08ddb857e39e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|366016|52116014|376014|19092799006|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Nx9xPRYtUqIUYpLrCYlhqqoMFe8GwQFkWU5mm77L/9sQyfZEkQsbR7zvp8oK?=
 =?us-ascii?Q?hEyBEbETanCWEMTuKdSE+P5gRVv9o5iKzJ6NczuLE6ztgdjBtW2vItFjqwcj?=
 =?us-ascii?Q?VUQZmHNTDLQzJ0Vfmxr2XWG+TDl6MM8UmGOlGSew8IOdPhzYngPP3GufyFr0?=
 =?us-ascii?Q?ALbHW8zICxqjsb1ijk9q2I1rBY2DbrYWZ02+WLGYilETNV/mzYuO4OABjHEo?=
 =?us-ascii?Q?ObjqAfYLZa9XQtc2OXdC7BWXujLrVD+piLvOGLUwQdBSBuAHHNMGvdbvzklP?=
 =?us-ascii?Q?k7Q77KD0d5DIxaPFF1Cr3eICJKqiYFwFeY11bO5xKdfZVqsmfzJp3TcDb+4W?=
 =?us-ascii?Q?ujL5BO6bA5Ig8wfPX/km3Yio44OZmRf9B1dTRS7XObtPYb2GIXxwVnLf6FUs?=
 =?us-ascii?Q?1guH3p3I+l/p7uXjkNF7Svq6fLIrPbS+eOXLU7UUqDNQCqbeWZa+dcEHQC8y?=
 =?us-ascii?Q?k6k4BGP8/8ylq0u0Tqq+2SnXTcg3cT1qTIkjN8XYngEbAkdsWOqBD4KzoHr0?=
 =?us-ascii?Q?3gvB3cch5/1IvaSHHt46miHWdXSs+U3zUHr1ceiwvdny5MwMNPe7ZqnYCsQs?=
 =?us-ascii?Q?YvSdbv96BURKYROFLQPp1eZwB7p6JbWTtZlm0pBj/5JocIVNFaPDIj9SWPav?=
 =?us-ascii?Q?uSFegx8Fm7reKNTJVlIGj6W2z37NALCs+iu13ZYpL/Ej8fCjEgnm3bnrylyX?=
 =?us-ascii?Q?aZCFJqUXU2/BR61VJ2dzdiy+R3JOs7/Tb60ySIBU8UBPLLfX98h/23xbI4jY?=
 =?us-ascii?Q?OCcckYmGfMPCNmse4TMGml8rTkguWvPps3C6ZCVsn2JflJL6piIAew1MfCg6?=
 =?us-ascii?Q?Yhiu/h7MDyttN5gKkwqeR71NXTSxr+C2RVX9FTrs/1yHxRZJikKYVBWwRy1l?=
 =?us-ascii?Q?wuNgfBlkTeeJKvSZQTSM2UQ6uymmdZyfOL1DCRG7SvKq0+MEvbnWxURdX97m?=
 =?us-ascii?Q?IZ3AA3BYgNVX8QsYtik4Vj067Vv+a+WExkWnv1qU5G1dLyjLy1Xz+uog6BAq?=
 =?us-ascii?Q?RLmuY97QpFac8mTNh1Bmrl4CAE+Eyz3KX2exr7QlTJaNIoLuZcf7b/LAFaMj?=
 =?us-ascii?Q?WFVsIM06lyhJzXJmgRlPQd2EBD3rRj0CEtOTG0nEn30FXwxXzxPFh7fZKyRD?=
 =?us-ascii?Q?PiZKkhS2h0Xbaz7NTVzZPooyv1HeHXIOeECxVGePj0RhCZoaGz7lMFVVLjvV?=
 =?us-ascii?Q?7f897LbTjKhT9C24RZKt4x1GhSUNlVK0ZV9yXSPRuf0pBNyWtBBL4T5smISm?=
 =?us-ascii?Q?v4ZzCzO4kz2ekO1LqIaic3OoTyVFpG6yd/CgPj6I5PXSvfOqK9ShtVPukamJ?=
 =?us-ascii?Q?8bGG+Ky5u19li++UMFu9yBICZej0CN8y0NThIlAyYjRuJ89RDfy0bqF4w581?=
 =?us-ascii?Q?UcMJJsXVhxVbnd5v0CEq530RygiJlwywCHvnxj4XXrjgNspcJIbbkLI+vFmA?=
 =?us-ascii?Q?bnRUgmmk/xgifIkKKi6dI0bGJGCKstIvmg85lcjePeQoDxdayTiUB66h5re5?=
 =?us-ascii?Q?v1Toz7MKDKD8u2k=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(366016)(52116014)(376014)(19092799006)(38350700014);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sBv4Rq7zOpdxhghrPFuJoboDAhiG4qrOlgOSKj2DwTPF+48ItFuG/sFb31Ai?=
 =?us-ascii?Q?08+Oaq3tJ5qy52UF8znWbKasdugZS6KLv+gqrdSUg+/zMMdqO130lS2n+wAQ?=
 =?us-ascii?Q?9zVm231TX3cQFQpIjz80o0p9hjExR72K30ZH9pHe8Dbif8Od9YV9JGDFdOrI?=
 =?us-ascii?Q?gJ+uaeP19ozEyC+hvxf17AgMeaUIQGaw210T3UIP7Ongcr4g21H1zIBbz5TT?=
 =?us-ascii?Q?fl99VNl5krJQy2dLNe4QQQWc0oCkc0STPKg5o/46F4/qWoCyyT6ZwpX2fxxR?=
 =?us-ascii?Q?rInv0txplfHrxcP68mYk9GvONZxG4XPRMihQszioskx/MVm0DyrEci4AHqPr?=
 =?us-ascii?Q?39skINXCk08cwzjOJUQmxcmxn1briA3lrVWDdoVnhVMUNv15fnuqGFrbGbYl?=
 =?us-ascii?Q?344qOA3cegO3VTiKq8msPpJDJPAIMbRVcmCqlgQSIYaP5t4mzp1Vsd7AOGVk?=
 =?us-ascii?Q?MgXDzsfGIA0lS5LGtqAsrPzc3Kq9sMUmNJ9YjXcVATXdgNKJ+D3HEPI3bKMr?=
 =?us-ascii?Q?zyaaG6gRUSQ8dJlaeek+8kcwl2uncdM2/RBXoc5v5zQGMSIJYMqgfCvBZHKa?=
 =?us-ascii?Q?t8O9kFK5TtDeZD/CY+sF0p7YLC/WJas8SZSQ9ZjOXrLrEIHzQLPRe18XECP4?=
 =?us-ascii?Q?N9qn/5SRubaSaaj/af05thOxTiHNDMyJ0HxmYADirQ31Mf4rJ1RobTC7oH2j?=
 =?us-ascii?Q?cS9U8TMKFmF9Mu6/27zY2HhHyUTwkm2ijNgZ/mGlm6baS3bERjWNcZrVg0t5?=
 =?us-ascii?Q?q7Dmw9nm5P49ino7RaEDeKX/GM/p0FwCxBNcTbxAxIMzigOhkaLVcw7Gnrka?=
 =?us-ascii?Q?ufr2KCAtCcq/G3i5LJ4iWT4bXvyxE1x6936Kmz4A1Ngn+MCkzDYoGX0KzKeU?=
 =?us-ascii?Q?QGW2m6UPDhTJMe3l9wr5WyEV6geDdtstXQZEr6QTXGIIUkvZbo49LpPzIRrJ?=
 =?us-ascii?Q?03C+siRRdPRgDNfoCkSKm4wlbLeErSt/DiLXWKjBTpp1VyqD6ldBldJTjkv4?=
 =?us-ascii?Q?D6uy9pXSbPED8jYBkmvHa3X/fxJz0Ac7WmCtSwpUZXpTTKnS7kgwjR77zPt0?=
 =?us-ascii?Q?SNMCXQMXFCNKzV0wLE4r6Kz+UujQS7RZUJuhmironJb3zHH7pkLANjof9Y0j?=
 =?us-ascii?Q?jrbNcr+fPPh6hEDoimhvLaYafKnKbjO3rK/WJXBWITfrDuUJ8MCZGz1wbBlf?=
 =?us-ascii?Q?JOTpfHRUbfeFvwrzkhRLi6XkX8qz6T0XBxkOw+cOOacFkJ8YRbM93v1xbOJ7?=
 =?us-ascii?Q?3BDytkKz/HaVSE0gX+Ckv+z3OUrgC/DyQwoC+/VLEydmD1oC07yOXeNQwJNz?=
 =?us-ascii?Q?PweaQipIErHYeBs7AgyQgd+v15pTTcIAsnKVMvZCYmrSGfArKPwqRxHAW9LF?=
 =?us-ascii?Q?5Cqa0JHU7zVc6pa1MJwRBDl4CwKCFrg+KzxXlVu2ePZwjKK3wSlkIebHWJy0?=
 =?us-ascii?Q?dG0kQ5osD6rk5iSx4Jeo9BpfkThUw8pr+jgfT8ozgCO/AWTZGaZgb5ddNXfZ?=
 =?us-ascii?Q?e/j2lkQ8gOFVdRrMvlhl11LYrtfgUdFBrXx/jQva3e5mXq5nRTXrBx4Algpv?=
 =?us-ascii?Q?RX4HxcTxfJnHPotgfiU=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 78d28735-8100-41bb-fb08-08ddb857e39e
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2025 04:29:37.9823 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tcZEHYEY5efLyL+kOjMCXfMcGbdHwsne3//5lyTtXl1D4Q3jBKDYw3eTiQJTZm6l
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7647
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

