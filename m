Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC8C3C369B2
	for <dpdk-dev@archiver.kernel.org>; Tue, 15 Apr 2025 02:55:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A37724042F;
	Tue, 15 Apr 2025 04:55:20 +0200 (CEST)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam04on2136.outbound.protection.outlook.com [40.107.101.136])
 by mails.dpdk.org (Postfix) with ESMTP id C913A40289;
 Tue, 15 Apr 2025 04:55:18 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PEpIHP20GkMRjhLnj/7JCyC8VmG6Hf3//r2NZmg6OuD2sPD0LrppTN+U1eAo+60EV6UuqpyvqDqRSVVp59nKRh4aSGzxOWAWQXIxvNBhMnjZWr8wGcrAVy1WjqnBiA4DEnYiaZSet5fpOANmGwWTJQoFGZxmAR5uDCA0+yoAMocBnpC6aAlgc5LBsjpHx0gKygz9j/V0fpa46dqeM40az+ewQXI0BSckwqvmFwDHMUX+E6K8bD88ccp+yz+2H9OkgFzTBkDCbkuEeBLvV+UR1H4Oly1cQqfjQ50nC1PkLDr3v01cVtLfsKNniz1Cx9I8HZR1lkHDm8h8XHm7eMbC2w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RwBw1itgn8WGlQOMSHl6/FeO4A4fWGO5tf82wvTuoug=;
 b=Hxv/Frpi+9cKCHR55G/83+86q8OVJQ2roZ+XSbStkSqaTIPOBqXNY4on5YFXWL28a7HVwLaU5UgX0OOsY0VcDuWIZSNJv7A+eRTyFqlYKeKaRGzxWVrryNAmJ4P6ZnM8vK4VgeyxJThQmzyZJX5uOMf/stxLcSqBmsEKOr4Llw0/TOcoYjyaq4jB2zj5GWgi+CCu6r+KVzoyMXysd+W21kNYfJhkmn+IM8/T8cFlpjq/KRbIexiuW0ZBk2cY9YAkpMiz/NGC4CW4tHsWeblM8xcbz0UfweO3k59obDI0vv0/YQYL4x/npVMwwXZ201LotfQLSsnP7t0uR/Af9VFSSg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RwBw1itgn8WGlQOMSHl6/FeO4A4fWGO5tf82wvTuoug=;
 b=NhysYy3Xpyd1um2VQbP3MrEXjP23WUVX1InUoH0ZxmPC/9ucVaj0e5iKDLfKHd1UB4XN4WEKY/vww7Y3ne075VZeywKIo4Aqq5JIWChrh20dInPwoBIB0aR3JGXE0QzKstKyIFBsdapBDGhNP0pO/KIlYI5VLuYutrsA91rD9OU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com (2603:10b6:a03:424::5)
 by SA6PR13MB7010.namprd13.prod.outlook.com (2603:10b6:806:40a::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8632.33; Tue, 15 Apr
 2025 02:55:16 +0000
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833]) by SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833%7]) with mapi id 15.20.8632.036; Tue, 15 Apr 2025
 02:55:16 +0000
From: Chaoyong He <chaoyong.he@corigine.com>
To: dev@dpdk.org
Cc: oss-drivers@corigine.com, Chaoyong He <chaoyong.he@corigine.com>,
 stable@dpdk.org, Long Wu <long.wu@corigine.com>,
 Peng Zhang <peng.zhang@corigine.com>
Subject: [PATCH 1/3] net/nfp: standard the data endian of Rx descriptor
Date: Tue, 15 Apr 2025 10:54:51 +0800
Message-ID: <20250415025453.1348238-2-chaoyong.he@corigine.com>
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
X-MS-Office365-Filtering-Correlation-Id: ec55570a-60b5-48c5-fc42-08dd7bc8f35c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|366016|1800799024|52116014|376014|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?XrQpeMkqyGioBMVT287pMgt1SO3QKzRG5DW44rS1WdhPd+xOAc0Al+hEdh1i?=
 =?us-ascii?Q?TgUhyxAyA0wqO1uc+GZFNdvmeKjshNXNsv1NAN76k4s0D6NmsIUuVuooCs+J?=
 =?us-ascii?Q?CKdaC3wTEgcvUw/TdZ1Y3n18a9CKINirfmBeWhQvYH3VKbbTWptU8H0ub0BL?=
 =?us-ascii?Q?bcuNFLwmIX/sRxUQ+ExXzUvgFqrOFfmOWqHSsK1fyYPfZ9N9U8p0W/oqPGsF?=
 =?us-ascii?Q?nTF0FqoeuWYJ8OxLsTKU7tK8KZniYTkf5lKR9n5ZWBjmjnJVkG5L8uohz4Vk?=
 =?us-ascii?Q?vtcyWw8vP58uH8ynN1TFS0t8EYAu20C3pZzH6KGZeClEkbjYcL8igsPEOwCr?=
 =?us-ascii?Q?BhUVO28WPMzxQ8ssPYkNi04gWDbofF+hkQnqdJRoKHbZUMzgFGS1m622fjfu?=
 =?us-ascii?Q?3dVAIvFNv3RSrdPYYKl6M+QHgZtpaX9V+S2OnG3BnoeYRLH4t2AGntlVRWs8?=
 =?us-ascii?Q?HiJMSolj8bj/9PLdNx4oRVviNngOaEi6UjQUCqERJffDtM1q75PCz7YdDhkY?=
 =?us-ascii?Q?JT1N0d64x3DgKFB/MZ4Xvu/UGF9n1zoqTckU6nu4PLLvW1pii5EjFK6PHkAm?=
 =?us-ascii?Q?MfPVEszWO4fmStUIlT7Zd/4MhfceNG6Nr49n4DHvmqP/hz+vmmxB16a1shch?=
 =?us-ascii?Q?XHaAkBUNoyU8EoE0dDCNeZul82Ex8VVActtwW1ZmiDl9Ei3H0/sX570kNf1F?=
 =?us-ascii?Q?5R71oA42a66eRec4jlFMZo0DXPpjkDjGFKVj5+WAqjwV+XLnZcfix5ud28Fi?=
 =?us-ascii?Q?ZbX0lJfy0SQhPnI/pPUhDLIyZtEu78CuG6V49ih2yjyjLjtAOv+VlrixEsHy?=
 =?us-ascii?Q?49xUq0ayGEaPLKB22M6HWxuQYBYm/cVb/ogRab2oc86jwA56Kt8xo1NGMs/U?=
 =?us-ascii?Q?LvuC9sUwhhx6b2GgU1D/GJXq+s5w3tmB+pB/dEksL/2ByLyNAb087xWygr4W?=
 =?us-ascii?Q?YWVA9FVHviWEesQB6AGfsVyLVXHbYH2Wm7djNROqww5G9r5jtv1BVx5puQR2?=
 =?us-ascii?Q?cg4KJMbuMGChvnyfBBhxvYgh2rn4bJsIIghcs8fNv91DUUJdgrOShrZD0fDw?=
 =?us-ascii?Q?S7DfJTsHPoH9ZEcsQVwDRqV8M6e6HH7IakcRraKgm9OA4l9xudpGgQPbp203?=
 =?us-ascii?Q?zfksAtOmSHR1DfH7A6qGy6cTLRkNay0dq62aNIS3zpaNjzpeH3RXVQADprJ8?=
 =?us-ascii?Q?T8bugffYG13GZFROTDv+1Zi67bXNkRxd0G/L8DUXjes1xdM8gpmsoVzZFCDC?=
 =?us-ascii?Q?rNKMFi1YEdEWHWuua5F8Ka/h4+elUGAj7zaKao1yBJbTADq8mPd8IORQBFIY?=
 =?us-ascii?Q?EDEFqz/XjkFfYrgBjNnz5hlbWZyA0JGaRp1sIRSaix5X7+aI/1zUk23IXkO4?=
 =?us-ascii?Q?5E9iUM0TMEI6VO+4EvikM4pQvkG74RE1Ku99JrPxXx7cNtz2E0UGTsIxD6Jr?=
 =?us-ascii?Q?pOT8O7yrwU4RmxQ/PULz+tzxyQ1pYA+piXTr655871i5RKt6Onyj3g=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR13MB5545.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(366016)(1800799024)(52116014)(376014)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?BhCNikHV2lM7XAevyCYT/Db3biN2/+LwlKrb8MyTEZ5t8us1zG8xuSjEcPlO?=
 =?us-ascii?Q?NIZ6ezzWPqMXUvPdOSNj4IK6aaNu6o8SrdtW0+2Q8nc0O/2tvZm3qpWssTtZ?=
 =?us-ascii?Q?creby47C7gmk2KjvjYmx0GRKccJ1fg2Ex5vXHxzu5yd4fJv1oJrwLienwu27?=
 =?us-ascii?Q?U5GgyRwp0qqVT0xXcxEcuXWpuFzukd4Y2THbk4rk1DsOZ7QDJS4tkZ8r+9N8?=
 =?us-ascii?Q?ijtKZyKm4YxHleTdz1wk/+6jM9kESjnwCJ7TXeUBxgrHLpFinrlv51AbILjy?=
 =?us-ascii?Q?uzTueH1mgu3DuZkpviHZUe8ebJ0wsnIa84bExd74gmE3R1JI7ymb5lG2yZ79?=
 =?us-ascii?Q?78ccZJoPj3/ttyb5hxxguf8my/9YoamfejHwZTX0PH3g3/AO//7hzxMQj1Id?=
 =?us-ascii?Q?lZ9SbHACEyT7IHUf/9/P1ZNM9azV3DxXH+Pbn7QUzoLZYxwdfWEye73O3o9q?=
 =?us-ascii?Q?XRNw+3kfw9ZggcCSG0dBCLCpH3xfC88baGt6vGZEA2YHJjcYy6F1OSrtDccD?=
 =?us-ascii?Q?T9WzAeVz6Iz1Nm5KBMzrOTNUeQpLiwuL6zceHJPA48jvPRElWooNrSelo0P8?=
 =?us-ascii?Q?BVJr37g9m+gyVVdY/1ajoVlF916s7kTcr6gzKitNfIwV+9FzPhD4bcr7TZly?=
 =?us-ascii?Q?xQbH1QEZCtGMcEkG+F8tQehGLhWB6eOePq90AkHRjzhJSRPVG1Bt7Q1m3VLy?=
 =?us-ascii?Q?tk3SHLIRNOwZIqJANE4YssGjPcOXP00Z0v1VU6MnDnI/2YVTY9FLtBYM46o5?=
 =?us-ascii?Q?QNWewPf6x4QUJ2gMRYkTzIL82lELtp+lgvK27RTuWv6Wbyh48/GVwi56GQLC?=
 =?us-ascii?Q?7vxwoFxtGMKEKS1fgGrfffjQzYx94lHq+H1iNHs9gnn3o1tjYIaAriS7QNng?=
 =?us-ascii?Q?TEITx/86zvKnE/NsWmPeOXNIR9N1224/Fci+LgSoB4ngWiwtpFqiZs+HvkXu?=
 =?us-ascii?Q?W4B7F4gPkHKsHyoc+f/zGeXt6TNcJlBvdF194UkDscYCc5ZaPohS1NbWwt45?=
 =?us-ascii?Q?hkpUXFZdORI4eJyi9ptd0w36984C7h2ND7WmbI4Cyk0QR+JAGfZsBd1wMCwn?=
 =?us-ascii?Q?Hm6NO4kO0lrdtri1BuglMUAIcOxEWYB+i/k7yxDhXAdSuXz/RTJk0R1R0PqK?=
 =?us-ascii?Q?3yva/stPssUpKlcQINbd/ZlOcW9glxNtsZKkeJ7w5oSX2K82AWuwM1jfc/0X?=
 =?us-ascii?Q?v0gRWPQjT6dTX+2K85zGaj3yt6QaDCrM05opPTntsMeDNyrop3U23uCO4cvR?=
 =?us-ascii?Q?EP4/yLWydVB0SJ+aTRNAzNva9BrwaracQXb5ngXszGTRpIwCe6hFQiVMTYOh?=
 =?us-ascii?Q?JFQam1oHXz+0t9C6MGgB2OYK6bHV/LC9H9oc9coK/cHQ32wOd1eQZ1ia35iJ?=
 =?us-ascii?Q?7uCrRDCAv732Thmqt5LJY6N2BU5pqGSZjRC9B3CP6XTT04oPwQZ1wlWCHW40?=
 =?us-ascii?Q?hT4zsZx3pSy29HGxephJk6OWY+EsmEODdorMwAZ9YGRi9IIYu5X/3oUv3tsG?=
 =?us-ascii?Q?3Sn9o1nLMZnHBZcy1frgY8iplPrMjeLU/VUQhsAbZwc+UqDbv+UtBqanqRfB?=
 =?us-ascii?Q?yqe9dx+/aHAIG9NwioYGGCC7ISuDfrCLk8JYTdAytG2z9u6ipGNZk2Yv9zMg?=
 =?us-ascii?Q?Kw=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec55570a-60b5-48c5-fc42-08dd7bc8f35c
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5545.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2025 02:55:16.5350 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fN8E4PMV8yvC8YRHPLANu3vFbJgVfxPumhflYZo98qhxL681SOOfH9yOFupmwdg6JwrlL6w3l1WTgADOyUBDShVCnT7IwoeSwTMXk0HMH+M=
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

The data endian of Rx descriptor should be little endian, and the
related logic also should modify.

Fixes: 3745dd9dd86f ("net/nfp: adjust coding style for NFD3")
Cc: stable@dpdk.org

Signed-off-by: Chaoyong He <chaoyong.he@corigine.com>
Reviewed-by: Long Wu <long.wu@corigine.com>
Reviewed-by: Peng Zhang <peng.zhang@corigine.com>
---
 drivers/net/nfp/flower/nfp_flower_ctrl.c | 10 ++++---
 drivers/net/nfp/nfp_net_meta.c           |  8 ++++--
 drivers/net/nfp/nfp_rxtx.c               | 36 ++++++++++++++----------
 drivers/net/nfp/nfp_rxtx.h               | 16 +++++------
 drivers/net/nfp/nfp_rxtx_vec_avx2.c      |  6 ++--
 5 files changed, 45 insertions(+), 31 deletions(-)

diff --git a/drivers/net/nfp/flower/nfp_flower_ctrl.c b/drivers/net/nfp/flower/nfp_flower_ctrl.c
index 21bf26b738..23d1b770d8 100644
--- a/drivers/net/nfp/flower/nfp_flower_ctrl.c
+++ b/drivers/net/nfp/flower/nfp_flower_ctrl.c
@@ -22,6 +22,7 @@ nfp_flower_ctrl_vnic_recv(void *rx_queue,
 		struct rte_mbuf **rx_pkts,
 		uint16_t nb_pkts)
 {
+	uint16_t data_len;
 	uint64_t dma_addr;
 	uint16_t avail = 0;
 	struct rte_mbuf *mb;
@@ -78,9 +79,10 @@ nfp_flower_ctrl_vnic_recv(void *rx_queue,
 		 */
 		mb = rxb->mbuf;
 		rxb->mbuf = new_mb;
+		data_len = rte_le_to_cpu_16(rxds->rxd.data_len);
 
 		/* Size of this segment */
-		mb->data_len = rxds->rxd.data_len - NFP_DESC_META_LEN(rxds);
+		mb->data_len = data_len - NFP_DESC_META_LEN(rxds);
 		/* Size of the whole packet. We just support 1 segment */
 		mb->pkt_len = mb->data_len;
 
@@ -111,10 +113,10 @@ nfp_flower_ctrl_vnic_recv(void *rx_queue,
 		/* Now resetting and updating the descriptor */
 		rxds->vals[0] = 0;
 		rxds->vals[1] = 0;
-		dma_addr = rte_cpu_to_le_64(rte_mbuf_data_iova_default(new_mb));
+		dma_addr = rte_mbuf_data_iova_default(new_mb);
 		rxds->fld.dd = 0;
-		rxds->fld.dma_addr_hi = (dma_addr >> 32) & 0xffff;
-		rxds->fld.dma_addr_lo = dma_addr & 0xffffffff;
+		rxds->fld.dma_addr_hi = rte_cpu_to_le_16((dma_addr >> 32) & 0xffff);
+		rxds->fld.dma_addr_lo = rte_cpu_to_le_32(dma_addr & 0xffffffff);
 		nb_hold++;
 
 		rxq->rd_p++;
diff --git a/drivers/net/nfp/nfp_net_meta.c b/drivers/net/nfp/nfp_net_meta.c
index 70169eba6b..6dfe7f0eb2 100644
--- a/drivers/net/nfp/nfp_net_meta.c
+++ b/drivers/net/nfp/nfp_net_meta.c
@@ -111,6 +111,7 @@ nfp_net_meta_parse_vlan(const struct nfp_net_meta_parsed *meta,
 		struct nfp_net_rxq *rxq,
 		struct rte_mbuf *mb)
 {
+	uint16_t flags;
 	uint32_t ctrl = rxq->hw->super.ctrl;
 
 	/* Skip if hardware don't support setting vlan. */
@@ -131,7 +132,8 @@ nfp_net_meta_parse_vlan(const struct nfp_net_meta_parsed *meta,
 			mb->ol_flags |= RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED;
 		}
 	} else if ((ctrl & NFP_NET_CFG_CTRL_RXVLAN) != 0) {
-		if ((rxd->rxd.flags & PCIE_DESC_RX_VLAN) != 0) {
+		flags = rte_le_to_cpu_16(rxd->rxd.flags);
+		if ((flags & PCIE_DESC_RX_VLAN) != 0) {
 			mb->vlan_tci = rte_cpu_to_le_32(rxd->rxd.offload_info);
 			mb->ol_flags |= RTE_MBUF_F_RX_VLAN | RTE_MBUF_F_RX_VLAN_STRIPPED;
 		}
@@ -234,10 +236,12 @@ nfp_net_meta_parse(struct nfp_net_rx_desc *rxds,
 		struct rte_mbuf *mb,
 		struct nfp_net_meta_parsed *meta)
 {
+	uint16_t flags;
 	uint8_t *meta_base;
 	rte_be32_t meta_header;
 
 	meta->flags = 0;
+	flags = rte_le_to_cpu_16(rxds->rxd.flags);
 
 	if (unlikely(NFP_DESC_META_LEN(rxds) == 0))
 		return;
@@ -258,7 +262,7 @@ nfp_net_meta_parse(struct nfp_net_rx_desc *rxds,
 		}
 		break;
 	case NFP_NET_METAFORMAT_SINGLE:
-		if ((rxds->rxd.flags & PCIE_DESC_RX_RSS) != 0) {
+		if ((flags & PCIE_DESC_RX_RSS) != 0) {
 			nfp_net_meta_parse_single(meta_base, meta_header, meta);
 			nfp_net_meta_parse_hash(meta, rxq, mb);
 		}
diff --git a/drivers/net/nfp/nfp_rxtx.c b/drivers/net/nfp/nfp_rxtx.c
index e0c1fb0987..c86bba9d87 100644
--- a/drivers/net/nfp/nfp_rxtx.c
+++ b/drivers/net/nfp/nfp_rxtx.c
@@ -122,24 +122,27 @@ nfp_net_rx_cksum(struct nfp_net_rxq *rxq,
 		struct nfp_net_rx_desc *rxd,
 		struct rte_mbuf *mb)
 {
+	uint16_t flags;
 	struct nfp_net_hw *hw = rxq->hw;
 
 	if ((hw->super.ctrl & NFP_NET_CFG_CTRL_RXCSUM) == 0)
 		return;
 
+	flags = rte_le_to_cpu_16(rxd->rxd.flags);
+
 	/* If IPv4 and IP checksum error, fail */
-	if (unlikely((rxd->rxd.flags & PCIE_DESC_RX_IP4_CSUM) != 0 &&
-			(rxd->rxd.flags & PCIE_DESC_RX_IP4_CSUM_OK) == 0))
+	if (unlikely((flags & PCIE_DESC_RX_IP4_CSUM) != 0 &&
+			(flags & PCIE_DESC_RX_IP4_CSUM_OK) == 0))
 		mb->ol_flags |= RTE_MBUF_F_RX_IP_CKSUM_BAD;
 	else
 		mb->ol_flags |= RTE_MBUF_F_RX_IP_CKSUM_GOOD;
 
 	/* If neither UDP nor TCP return */
-	if ((rxd->rxd.flags & PCIE_DESC_RX_TCP_CSUM) == 0 &&
-			(rxd->rxd.flags & PCIE_DESC_RX_UDP_CSUM) == 0)
+	if ((flags & PCIE_DESC_RX_TCP_CSUM) == 0 &&
+			(flags & PCIE_DESC_RX_UDP_CSUM) == 0)
 		return;
 
-	if (likely(rxd->rxd.flags & PCIE_DESC_RX_L4_CSUM_OK) != 0)
+	if (likely(flags & PCIE_DESC_RX_L4_CSUM_OK) != 0)
 		mb->ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_GOOD;
 	else
 		mb->ol_flags |= RTE_MBUF_F_RX_L4_CKSUM_BAD;
@@ -165,12 +168,12 @@ nfp_net_rx_fill_freelist(struct nfp_net_rxq *rxq)
 			return -ENOMEM;
 		}
 
-		dma_addr = rte_cpu_to_le_64(rte_mbuf_data_iova_default(mbuf));
+		dma_addr = rte_mbuf_data_iova_default(mbuf);
 
 		rxd = &rxq->rxds[i];
 		rxd->fld.dd = 0;
-		rxd->fld.dma_addr_hi = (dma_addr >> 32) & 0xffff;
-		rxd->fld.dma_addr_lo = dma_addr & 0xffffffff;
+		rxd->fld.dma_addr_hi = rte_cpu_to_le_16((dma_addr >> 32) & 0xffff);
+		rxd->fld.dma_addr_lo = rte_cpu_to_le_32(dma_addr & 0xffffffff);
 
 		rxe[i].mbuf = mbuf;
 	}
@@ -356,13 +359,14 @@ nfp_net_parse_ptype(struct nfp_net_rxq *rxq,
 		struct nfp_net_rx_desc *rxds,
 		struct rte_mbuf *mb)
 {
+	uint16_t rxd_ptype;
 	struct nfp_net_hw *hw = rxq->hw;
 	struct nfp_ptype_parsed nfp_ptype;
-	uint16_t rxd_ptype = rxds->rxd.offload_info;
 
 	if ((hw->super.ctrl_ext & NFP_NET_CFG_CTRL_PKT_TYPE) == 0)
 		return;
 
+	rxd_ptype = rte_le_to_cpu_16(rxds->rxd.offload_info);
 	if (rxd_ptype == 0 || (rxds->rxd.flags & PCIE_DESC_RX_VLAN) != 0)
 		return;
 
@@ -410,6 +414,7 @@ nfp_net_recv_pkts(void *rx_queue,
 		struct rte_mbuf **rx_pkts,
 		uint16_t nb_pkts)
 {
+	uint16_t data_len;
 	uint64_t dma_addr;
 	uint16_t avail = 0;
 	struct rte_mbuf *mb;
@@ -470,14 +475,15 @@ nfp_net_recv_pkts(void *rx_queue,
 		 */
 		mb = rxb->mbuf;
 		rxb->mbuf = new_mb;
+		data_len = rte_le_to_cpu_16(rxds->rxd.data_len);
 
 		PMD_RX_LOG(DEBUG, "Packet len: %u, mbuf_size: %u.",
-				rxds->rxd.data_len, rxq->mbuf_size);
+				data_len, rxq->mbuf_size);
 
 		/* Size of this segment */
-		mb->data_len = rxds->rxd.data_len - NFP_DESC_META_LEN(rxds);
+		mb->data_len = data_len - NFP_DESC_META_LEN(rxds);
 		/* Size of the whole packet. We just support 1 segment */
-		mb->pkt_len = rxds->rxd.data_len - NFP_DESC_META_LEN(rxds);
+		mb->pkt_len = data_len - NFP_DESC_META_LEN(rxds);
 
 		if (unlikely((mb->data_len + hw->rx_offset) > rxq->mbuf_size)) {
 			/*
@@ -512,10 +518,10 @@ nfp_net_recv_pkts(void *rx_queue,
 		/* Now resetting and updating the descriptor */
 		rxds->vals[0] = 0;
 		rxds->vals[1] = 0;
-		dma_addr = rte_cpu_to_le_64(rte_mbuf_data_iova_default(new_mb));
+		dma_addr = rte_mbuf_data_iova_default(new_mb);
 		rxds->fld.dd = 0;
-		rxds->fld.dma_addr_hi = (dma_addr >> 32) & 0xffff;
-		rxds->fld.dma_addr_lo = dma_addr & 0xffffffff;
+		rxds->fld.dma_addr_hi = rte_cpu_to_le_16((dma_addr >> 32) & 0xffff);
+		rxds->fld.dma_addr_lo = rte_cpu_to_le_32(dma_addr & 0xffffffff);
 		nb_hold++;
 
 		rxq->rd_p++;
diff --git a/drivers/net/nfp/nfp_rxtx.h b/drivers/net/nfp/nfp_rxtx.h
index 4e0ed9da38..cbb6df201f 100644
--- a/drivers/net/nfp/nfp_rxtx.h
+++ b/drivers/net/nfp/nfp_rxtx.h
@@ -118,24 +118,24 @@ struct nfp_net_rx_desc {
 	union {
 		/** Freelist descriptor. */
 		struct __rte_packed_begin {
-			uint16_t dma_addr_hi;  /**< High bits of buffer address. */
-			uint8_t spare;         /**< Reserved, must be zero. */
-			uint8_t dd;            /**< Whether descriptor available. */
-			uint32_t dma_addr_lo;  /**< Low bits of buffer address. */
+			rte_le16_t dma_addr_hi;  /**< High bits of buffer address. */
+			uint8_t spare;           /**< Reserved, must be zero. */
+			uint8_t dd;              /**< Whether descriptor available. */
+			rte_le32_t dma_addr_lo;  /**< Low bits of buffer address. */
 		} __rte_packed_end fld;
 
 		/** RX descriptor. */
 		struct __rte_packed_begin {
-			uint16_t data_len;     /**< Length of frame + metadata. */
+			rte_le16_t data_len;     /**< Length of frame + metadata. */
 			uint8_t reserved;      /**< Reserved, must be zero. */
 			uint8_t meta_len_dd;   /**< Length of metadata + done flag. */
 
-			uint16_t flags;        /**< RX flags. */
-			uint16_t offload_info; /**< Offloading info. */
+			rte_le16_t flags;        /**< RX flags. */
+			rte_le16_t offload_info; /**< Offloading info. */
 		} __rte_packed_end rxd;
 
 		/** Reserved. */
-		uint32_t vals[2];
+		rte_le32_t vals[2];
 	};
 };
 
diff --git a/drivers/net/nfp/nfp_rxtx_vec_avx2.c b/drivers/net/nfp/nfp_rxtx_vec_avx2.c
index 66d003f64d..faf3d167d9 100644
--- a/drivers/net/nfp/nfp_rxtx_vec_avx2.c
+++ b/drivers/net/nfp/nfp_rxtx_vec_avx2.c
@@ -92,12 +92,14 @@ nfp_vec_avx2_recv_set_rxpkt1(struct nfp_net_rxq *rxq,
 		struct nfp_net_rx_desc *rxds,
 		struct rte_mbuf *rx_pkt)
 {
+	uint16_t data_len;
 	struct nfp_net_hw *hw = rxq->hw;
 	struct nfp_net_meta_parsed meta;
 
-	rx_pkt->data_len = rxds->rxd.data_len - NFP_DESC_META_LEN(rxds);
+	data_len = rte_le_to_cpu_16(rxds->rxd.data_len);
+	rx_pkt->data_len = data_len - NFP_DESC_META_LEN(rxds);
 	/* Size of the whole packet. We just support 1 segment */
-	rx_pkt->pkt_len = rxds->rxd.data_len - NFP_DESC_META_LEN(rxds);
+	rx_pkt->pkt_len = data_len - NFP_DESC_META_LEN(rxds);
 
 	/* Filling the received mbuf with packet info */
 	if (hw->rx_offset)
-- 
2.43.5

