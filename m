Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C40AEC3ABB2
	for <dpdk-dev@archiver.kernel.org>; Fri, 30 May 2025 07:14:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2F9A940609;
	Fri, 30 May 2025 09:14:17 +0200 (CEST)
Received: from MRWPR03CU001.outbound.protection.outlook.com
 (mail-francesouthazon11011019.outbound.protection.outlook.com
 [40.107.130.19]) by mails.dpdk.org (Postfix) with ESMTP id 6A9C6402E1
 for <dev@dpdk.org>; Fri, 30 May 2025 09:14:15 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r8ygY0sryraEJRqirMULZ68rvIFua4EVbrsVHk3MzwMW88XTN06m1LxnPwMg8gDgx+Ecgqz0XJKGAa5zvvW2PTZE8npaYUUbZVaVlpeSOv3OMi3UsKItjxmkGxFLKA8kOQ9f8DtUNZi1zh2pseoShnpUKpqpBJfbI5ibXv6tNW0JYMX6NzB6085Q27YWA4rSL58qKZLGrOe4C8KbBsoN0zPQuc0X0jphGZ6cfXrZv9of1A/Nk0SFs9RzxQo6OCHkkxs3GamHC9d930iKzi7nmiuBlp7rq4RPCRQuLmjoXSrbwoXY5ZzUlOp2HDq1BJ6gdft4SO4vlpXaKJm5tkQ0xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nj6ZQsr5ZcAvWcqnrvuhMD3JvkiArci2vvf/RdtdW2k=;
 b=HUwP+ccPk1+gTDD3n324weQwdqtA2I03qCJCveFEJMkt+jPBRlITKU3WvA/ugiSHEpnwL1Hi91IDaGPUKOcA8EcTv8OrOOK6DbVOvOsmhnU6iat8ruEeYMh+JU84/BF3sfJBicuXmaatmnQZBKGRxoIP4e9bNJwUMTqWsF+ZgyMoxIX0PcwtoTkR4GPN5lst+UlJuZntLLuGDflZ+ZjuH984TWXDhZhMvay1Li3ApIzE/3bt4P9QqD3OCUWcL4otX0zO5wkavAzn4rIIQyqj1uNnQ185qIzLSM6FongS1XKdox4JgMHUvsjb9NaG+pcLq0kE2oFjLUJ7mqPGmjyn1A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nj6ZQsr5ZcAvWcqnrvuhMD3JvkiArci2vvf/RdtdW2k=;
 b=dmdeBNG8tc8F5hOZotp3QOQDJdzjAAGBpuW7B7ZYawaYw1isAqMLdL8VNcjTcahUGbJMXs1Oqg+QJNadoLO0mhzxFlA81ePO/HkJGqaOUUv1B+q6Xs1CLPCFNKeMaDDYpDViPW8PJTVJJwWZ6qCKsHmxlIqtK6ZaC44DzUuRQSQQT9YFIzzrxv6Hb/IEOd4eDIan37DPs+TsfGzvIeQiLaxFmYbqkLZQH6gZJApK8rGC5y5IwPQzecINGUR1cMEF/Cw0Vld++KUbu5oIRxZe956APOvIaXyUMptAT84L1YLmPbOa86yZpoasp5ynVRqITErYE2NtfzZZaGsqclMBkA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB8205.eurprd04.prod.outlook.com (2603:10a6:102:1c2::20)
 by DBAPR04MB7223.eurprd04.prod.outlook.com (2603:10a6:10:1a4::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.30; Fri, 30 May
 2025 07:14:14 +0000
Received: from PAXPR04MB8205.eurprd04.prod.outlook.com
 ([fe80::7633:884d:5973:174f]) by PAXPR04MB8205.eurprd04.prod.outlook.com
 ([fe80::7633:884d:5973:174f%4]) with mapi id 15.20.8769.025; Fri, 30 May 2025
 07:14:14 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH 04/11] mempool/dpaa2: use unified VA to IOVA conversion
Date: Fri, 30 May 2025 12:43:37 +0530
Message-Id: <20250530071344.2939434-5-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250530071344.2939434-1-g.singh@nxp.com>
References: <20250530071344.2939434-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0153.apcprd01.prod.exchangelabs.com
 (2603:1096:4:8f::33) To PAXPR04MB8205.eurprd04.prod.outlook.com
 (2603:10a6:102:1c2::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB8205:EE_|DBAPR04MB7223:EE_
X-MS-Office365-Filtering-Correlation-Id: dfcec7dc-7b53-46b4-bfd0-08dd9f4994e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|52116014|1800799024|376014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?9pczlw5jzWkeHY1CjnayhKSGb+Q/VmPDZzDdrmHrcGCaO2vIOIt4ZGK+vtQz?=
 =?us-ascii?Q?GoQILa2m+vCPVsJqBNjaDRF/9USl70obyuEpn/osYn0PyZfh+SKO0ugt8RJE?=
 =?us-ascii?Q?AhFESYcowU/6W9xhf4cMYnuplDkrZUUo8gFM99mzeR/D/ao/AOZ03SXE/nYJ?=
 =?us-ascii?Q?N7k9g+/pjujLQ7erSTcNdcRQQIs+QoyRrPtlKzxCWDO4XYQdOuRZaSiHuXGi?=
 =?us-ascii?Q?6XbXF2XmN8/bkN+sUGXECVeJRysf18AYRNfLGctw+EFU48Z8Es7+x5vNpF3M?=
 =?us-ascii?Q?N7zoMDFuf6eeBYAqdvjV3ikfmbb2jgai8da4HUZSSy8HZM+1B8V2HObx0SHE?=
 =?us-ascii?Q?H5D7dGA+f/fHhW+qhj3/2wkjR4O/lgQn/HnHp2ZKSK1esvpXsLhrcH0NcBP9?=
 =?us-ascii?Q?dcjnRxqf7sq6cxGPruqenJ/ubc/ultGZxOuFQiz72L++xr3Qq419rhWS8nec?=
 =?us-ascii?Q?JtDQBtOrkuCtTpP0VCN6++czr+JPns2CyjBnoBhJi31ScjxWUc/8aTlkKDYU?=
 =?us-ascii?Q?C1/e7HpzMfqpnRT5eYafrAi69tiv0zVRPVOQsTSbXb6j1OnX3LdjOYbkxj0G?=
 =?us-ascii?Q?aFLcnMWFiH6C+JCSkV2842I9k5OIrvvuSCZ0C5xdE3n5BZksv88FIlpG2hMi?=
 =?us-ascii?Q?0W6oIm22YPZbsAxJFykQO7lgc4teLpdcgqkcXQlzN7VgV3rgeh1ok14+78Fg?=
 =?us-ascii?Q?xGC4VCqRXyKTCbx4nwe0gwkNdA8rFV128328vU/y1FU6vEoikkYWVocwV7o1?=
 =?us-ascii?Q?Cs75fAA7a15h0wHNv/0yKwN+pTSGL71oNVFCyPS+viZBssc0VvFDjYfbjMQv?=
 =?us-ascii?Q?MRQCjezl5emW9AqWxAuFCR3FIto+CqLfC7jRfutbMCwgrUQY+MQQQetWJJYz?=
 =?us-ascii?Q?2kQUfP0YWCtoZd9fB2qDmmSaqaEH/kWoiPBu72IgFY49dSMslkphCy8MgCdF?=
 =?us-ascii?Q?si+/8MQZXXGIZjHpfw8OLs7KwZaozrlY3b3zIwwGH/KNUMGrOR9OQlPIEtAt?=
 =?us-ascii?Q?PavPlA3IWvkEmjGH9SWxdTlHZEvlD9AMJYA/C737l9EFuXFY22MYIndQreh0?=
 =?us-ascii?Q?c4rr9zTpFPfh0sZMj1cSItfvElImY2A28uJ6Xxf/jDDl7z74QmIAF3tfm81j?=
 =?us-ascii?Q?Qv0E+CosY2c6MVswVFvxtwVQe4ix3smPFmCDsuQOdOCy3tTQ1aLopbbtGSIv?=
 =?us-ascii?Q?dmbtIwIJRRmSvCkcFvjcQDgp0AfrxY6Id1c/O/OPjXTEOd9WMkMocw273nV6?=
 =?us-ascii?Q?TEAGbaD/6LoeN+7+tjlW/IkyovqNGdDFxJxDsd9Gz0FHaz2sxs1aJ2wLWSFK?=
 =?us-ascii?Q?DyRJaHErm+3d6kI413iG8ERwr2Ej9Woj6OZXa9cE1guPV6SyqeqGjvi0rfiO?=
 =?us-ascii?Q?sPT9/9AKgtu6W84eRO9IYrICcxRrE2Gn9/KzHzvBzSW00OAhDAs99fJR7R4q?=
 =?us-ascii?Q?b922jN3AuAZ8/dULHKdfykLFKdI8odlbkSWAhHF3b3vC1m6GRCdd8bA4jB3J?=
 =?us-ascii?Q?qrgFuK59BevsvLE=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:PAXPR04MB8205.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(52116014)(1800799024)(376014)(366016)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cRSM+ht9a02qMSGG/EBp3d7X1ah/c3vOzEx7vWIqF3QRkvJ8lVOFwk7P16vd?=
 =?us-ascii?Q?DSlZOR9ob5ap9g0i7X8SDyDtiATdkSmQG+gHAnB0jSwGqOkruJ/hJGkJpMvy?=
 =?us-ascii?Q?b8AyuxL46bWZ4HIvJwFzOhRjcmRF/wXksr7+uNOAZde+FOkpCX4Nkb1DUrwP?=
 =?us-ascii?Q?lo+AWSZXSbiU6kBeI6SIyWm3g08bOY/Zf97oGrKrhtVW8+bydqF4U//i2mwX?=
 =?us-ascii?Q?oWaq6oUXjgVZgHQT5M5y4CVtn2vf+/aPyJAH2bBB1KuyujngCI5r4hGzC7mR?=
 =?us-ascii?Q?Q8jZblZGQgs8daTyT57cd8gDz1+upoUiA3u0z8+WacXJMYOsOrC/xmFjCO9u?=
 =?us-ascii?Q?SW6J4snmVfAbexfuFbQFRVc+6lBKWynvGwjoqql/Rh7QpKtBbfNO/cBd2sz5?=
 =?us-ascii?Q?yu2pwAoTFDIzJ1XS6QeydBDLKmt3rOJyrRwqxZ6DTeyszieeSJi50bArCL1A?=
 =?us-ascii?Q?6Srf4kCO0UR5PQE136ZLfyk3EBiK2+vt/z6FnIXeVw6xcjfDYvbnjAakoRXi?=
 =?us-ascii?Q?HJAwAVjMtKlIEgMow/WTT5wjvSzBBksWiSGO2SZb2ewYdK1eBYwnIsAjT4CU?=
 =?us-ascii?Q?8W96HQ6hR1OUpjkOJ69H8Fm/O8rEZ4Yid9PUBQs9FxbgltLd6QNH+N0QbLvl?=
 =?us-ascii?Q?p/W46GzrSBsUZBUwEELuaXUjv6DuRk5yLxm4ZablAP74/KHSrTcsh3lzDJaG?=
 =?us-ascii?Q?tlGCHMvcJpwZL3jETdeMKB375ZLoUVibLd4BCb0lzDsJyRC/98596JWJVoQT?=
 =?us-ascii?Q?aVGLELlo4Gm5MQYLljriCy4l6dLQzc4jY2lTXYvl6+j0657rWNftVK+RxUDm?=
 =?us-ascii?Q?jW+TXx+1ErvRdK+VRSfmmlOk4Nsklz5N1O06b+BgpkWOoZCWnDBfhgwuoFrX?=
 =?us-ascii?Q?JR5JDKLvL5vUARLMgvEiXflHmBsKEGxlZoX+UksNnmtepZKYsaIjZAtPSac7?=
 =?us-ascii?Q?g/LZrgz3MBxsUXsBDU43khSlvi801kAA+wRx/n+Qs9zsle6+IDuTrNEXU+Ps?=
 =?us-ascii?Q?MVvo+2FBeWttNJnz8RLIbZGusZ0xHWVIsqi/Z1AoKyA1PXLb0zQrEodUURJT?=
 =?us-ascii?Q?SizooF4HHd6vikXaJxuJExs2wWt/3R3gNIR2vGIzWgD91XTkZmx7qKTgPJwB?=
 =?us-ascii?Q?eF2WlRlC6GSstG8r2hv+iQufM4QQEfz7V3swt1MZj/qTACZ2NP3M5zouXzWg?=
 =?us-ascii?Q?QvhWEcEKnOkm0nUJ4/zWv/sv/oTLfXM28G4dxWfM0Q8lkGmYXW82ZluUEkFa?=
 =?us-ascii?Q?Zew7jH334eg88/22WRJkoJk5OG60e5RaP1h2P+8hdXUvfUBrUK9NjlJaen2K?=
 =?us-ascii?Q?aNUGLRBhy7m26PwvQH0Pnx18aoCmu7he+x2vWvXTppbtV6TU2+e3P0soAkIY?=
 =?us-ascii?Q?V4myDia5fEzBmYd0iU+c9G9UJM0bSq5xtuU4FW5AQEwI6uaUDIiXQbe8EG8Q?=
 =?us-ascii?Q?GmYjv2kvXcCWemxZHG/tYM530vtpY/eJHPeUjyauMdUp2WxDwKBr/wKmgaF5?=
 =?us-ascii?Q?rs0mlrzQf/emM7t7gjxOEOk1c97ZazvywU25NCuE8CItJvlrJE3hdW83CDEw?=
 =?us-ascii?Q?od2e6TkLcnWdO+/QVVg=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dfcec7dc-7b53-46b4-bfd0-08dd9f4994e1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB8205.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 May 2025 07:14:13.9583 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: psxlZCp2vrrOmJSum9Vu4qmRFxaEcMQgvABBrNXRPrqgM2RcNbhmtRmfnaXBMufC
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR04MB7223
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
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c | 220 +++++++++++++++--------
 1 file changed, 141 insertions(+), 79 deletions(-)

diff --git a/drivers/mempool/dpaa2/dpaa2_hw_mempool.c b/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
index eb22a14fb5..da49c25900 100644
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
+			obj_table[n] = (void *)(bufs[i] -
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
+			obj_table[n] = (void *)(bufs[i] -
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

