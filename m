Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86AEFC3ABDD
	for <dpdk-dev@archiver.kernel.org>; Tue, 20 May 2025 05:52:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8D1D040A71;
	Tue, 20 May 2025 07:52:16 +0200 (CEST)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05on2047.outbound.protection.outlook.com [40.107.22.47])
 by mails.dpdk.org (Postfix) with ESMTP id EE6A040A6E
 for <dev@dpdk.org>; Tue, 20 May 2025 07:52:14 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WMWkt49SJo0bEqDeeF7vMnu9mgNSkg94k+DvITFAX/Put5m/UjHmHnwwuxA1gkm7PZO9NSHVN0SPdV4jWt2glbvVJXwSr/UaH71ulwHiXW9RlloDUQNLsZgxdbup69cCm2mIhkBXHqDQGxjxVkhzIka/Dc5l87Kv4iwyQ0c9dkHkDsWfCxYNhxh+vBovo0cfhwbR+1oK+ITyxPeWxlsLwsxqs4MjVnYOGrEWU+ksrSj1H0JsWRAc/9jtT6W3YvorGDH00d3PRsf22HkKq1lgeOhab2KgeoVIxJX2zzc2kD+eS/WUSE+1NvOtCWVIvSUpl1NXtU8n01PVAVTBcA8x0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RbgWWXFBwG3TgLJctraa/L1yB0+MqONsjrVuRjxFmXg=;
 b=XkL0y6N/XIjJrA5ku0imzL9IkvWnFLDAVcVMNnnVTEPjhvZs3RnVwXlNEns4dTbHWXfiUHJDgQqywe/F3TiTr/p7RV512INxfG+Y50OCuGGZ0uYoPFSIwUGgzLfo+5EuwwttuHp2fL0mgyFeEFIZDL2KyU/kNYsH6cSNwWkPeA1rbj7PQtqgGCvOQa5yhgd1zOBKHoQs0bt17yH9vTPUu7z+vt9RJMGIpW8J3KN3ohDwU/DDt6eyALjbSJuRksiURRmjiDGPGZ/T0n8ZiOOrvSv+XMZ450cCbFQOCU97Fa+nzHR6RGBhPC4yJENjUERyjGBgfrTmNJ6VwPCANQnbjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RbgWWXFBwG3TgLJctraa/L1yB0+MqONsjrVuRjxFmXg=;
 b=S1/9Vn4bBBWMoRkzDwmcxpBoW/qhhrV96gFv5Y2CtilPiGM2sCbZEqHJbPfbLBjIeA5Q8IV3xXL592Ce1PGMwThwUO191vAF5JH9YxFAAR3r+ZtIwTDuJ5I//BhbAD+xSS9q3s/rax0NYwjDC4q09JRT73pJiwLhMHhd7gDVXoc2u/lL0DYIKjvZISbitYufTiGwLQrqATcKBhpypZgr5d/4I0/+2US94SRf1RUaWBceKqSo2+5ES7G+6TiT6ShT8AKbaETheA9zWhQipT0OujBBSELHCTB29AMTnOh1ggnzac+Z7mAtWEojJXkqaAkzBJKQ4pHF3Oc6Njq3GCOcpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com (2603:10a6:20b:3b0::14)
 by AM8PR04MB7841.eurprd04.prod.outlook.com (2603:10a6:20b:244::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8746.31; Tue, 20 May
 2025 05:52:14 +0000
Received: from AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195]) by AS8PR04MB8198.eurprd04.prod.outlook.com
 ([fe80::2e32:1a4a:7d29:195%6]) with mapi id 15.20.8746.030; Tue, 20 May 2025
 05:52:14 +0000
From: Gagandeep Singh <g.singh@nxp.com>
To: dev@dpdk.org, Hemant Agrawal <hemant.agrawal@nxp.com>,
 Sachin Saxena <sachin.saxena@nxp.com>
Cc: Jun Yang <jun.yang@nxp.com>
Subject: [PATCH 8/9] mempool/dpaa2: mempool operation index
Date: Tue, 20 May 2025 11:21:32 +0530
Message-Id: <20250520055133.506071-8-g.singh@nxp.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250520055133.506071-1-g.singh@nxp.com>
References: <20250520055133.506071-1-g.singh@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0026.apcprd01.prod.exchangelabs.com
 (2603:1096:4:192::16) To AS8PR04MB8198.eurprd04.prod.outlook.com
 (2603:10a6:20b:3b0::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8PR04MB8198:EE_|AM8PR04MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: 65d405c2-be55-40c1-fe8d-08dd97627886
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|52116014|366016|1800799024|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?wB0c1oMNhPqkguYoSqjwubtDu6cW4wv1Otc7W8vvLwkea1WrP+a3M1kOCWVh?=
 =?us-ascii?Q?sYCVQkfq+pWnvRW3mhoTylGuNhjU43J33223+bP+fxV/Ktx7biSmGbbkYqyf?=
 =?us-ascii?Q?sgcYvtWsC1idKX5Uvx62rK4W8gRVzSj6ID2OrLeXQA8d5O9t+EkDjM2Xkvp5?=
 =?us-ascii?Q?E4GTLVWPlvgkoIHc2MbaqH/VluEl9Zf+VC8bXi/JmGR/AvLG1wo5ZGGcBNUY?=
 =?us-ascii?Q?jR+LvgaAo5ukC2dN6c8gA0zFWEi9iXjKAzSQyayspKTA1CfWKy9v5Fhuf8AN?=
 =?us-ascii?Q?UZNkzK5r7pE/tXlv5T5OZUlaRHhRGqdyg/5ib0hKb5LJkg79VfPfIh8m/rPf?=
 =?us-ascii?Q?M9wmrH4FRtBLJ5Xfd+kvApZvry+Np9ar7LITjALo7bQBsMTs70i4i9NdhVgP?=
 =?us-ascii?Q?o/MIWPblTfeAtaR1K0w15HjQ6q1Vj1QmOTBT2iFVcRJ3RzK62lb+2at1HV1u?=
 =?us-ascii?Q?nZZWaw4Jd9FqcR5ftN5tc98BV6oqmvNhRhkIi8AnAshzKkQKtsS34kB+foG4?=
 =?us-ascii?Q?ijtUM826b0op2mT+D/9ukaudh9Xs+vwaBSbirWpn346LEQa5u2XwsZ3mn0Gw?=
 =?us-ascii?Q?wECKPduOiyRy2REcRLnOTMe09KtSjKiKJj1Z+Yi53szpXHI61e36bZ1lnm3M?=
 =?us-ascii?Q?P40GzFKR+oyRqeag8qdZtH06iQYbWhta1J3KVYgu1QlYI+cB71fUJl8HeyNA?=
 =?us-ascii?Q?+oFF+LIuQD7LAUWVz7V7/4cB5F8guFwADOYIeoxcmEJOou1H7bEfRL8hWWip?=
 =?us-ascii?Q?Q0xX00cCXYRyCjySvHQP477KWpZP/Lz6BeInNX7IzfVghn6gd50W+2cssac6?=
 =?us-ascii?Q?cIi77ZaA/n8XINtQIwZPxW24uWQmZ6ZvDjPqSLtszr6ERQ8TpKPzCq/mOvSb?=
 =?us-ascii?Q?KAIbd8a2E0Qp8nERn3BkV7WQUxf6Br383u8Iy0Os9SxYpYZkiYx8rfEm+Lf6?=
 =?us-ascii?Q?xgJXA6oNNO4OOjpSdI1W2MxkFvhXYFo4f7B1wesTKtXDdbr8b0O26ZLipdXl?=
 =?us-ascii?Q?E9BOqnKIAhYteS5scLcWgchzP103Nt9FEFrzVF8+01o86k2579iQbeXuLr4W?=
 =?us-ascii?Q?rAz6O/Q0C2VZHIqO5shWEgvxUmlXbM3H1vXQjZaiV5zaYn4kyL15rIR0Syb5?=
 =?us-ascii?Q?GaTHsVMohZESGkMup0o89L+aJMNa5SYbHPRW/5Zy3chsNFTyUum1ZrKqFDPY?=
 =?us-ascii?Q?bC+zYxSdUr7bnrunrcHIW1vsmab8zsyXeuM5hSLmiX+FjGdidUyhEHwpZDFU?=
 =?us-ascii?Q?gmKjVmqBAXtYoPvH7fZ+CGMpNVP1X7y61E6kd6vb5e8dG+NS4nfCtTPIqrDY?=
 =?us-ascii?Q?qR4GxZknqAFEvw+WP6hUcl0j3mx0UlzGheuR9iDHU3Marb75+lih+c8MvGU0?=
 =?us-ascii?Q?0lO8ALgbCcBCa1rwMF+zYyCv1Mg/5CMZqFo4LuANMobDD0WmXiip3cfa4R2p?=
 =?us-ascii?Q?63GkM0j72QIYL3dmW72W6oD1kTYq7FSxQyuxWz1+DxZioh4ekwGd7w=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:AS8PR04MB8198.eurprd04.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(376014)(52116014)(366016)(1800799024)(38350700014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?FzUyr31cvelZNWf1XQYbMLk+ue/9SggOOjbWW5h9zPmMAvwwaKNhwRwotxQY?=
 =?us-ascii?Q?pytqXTaSL4nJNy8GNEPSDqF4cYvfujx/+khcYMnmTscusU6GKJAWbmPK1GdZ?=
 =?us-ascii?Q?ep8yxgF0RKH4WXy8ZYbdLp44KPrSVGAaOUG49GGvA2cIhVYeQCC9giSKFNKC?=
 =?us-ascii?Q?3kkRSLLoeOZOWKijUOyhBZC3GBy/+29TmN3eKxXvp7ZSf4L5G0BBmqnaj0aI?=
 =?us-ascii?Q?yXv6FQBnEnMwxcYlp8tahYbS+Jf8c6b1B/zIypchIBNNe8y1xpJXVfx/py9P?=
 =?us-ascii?Q?jlFOcLp6WIZ0viW3+tecpwqG8mE0cXMp8RBLFJ/nmQo+HGsBbQhslz4D+nGH?=
 =?us-ascii?Q?x5nHX/X1kl8+5P0hk0DmU6d12Mo8LJ1CgapiWX+bUD45vqdMwT3TZx9sfpfQ?=
 =?us-ascii?Q?lKUg8ycavk9OhJB/5RBSIgBMDxXAYX46a3teCtDE5Sd6K4ELn9aV7gWjnHJY?=
 =?us-ascii?Q?jpY31glM+QKNaie3nH0R9b+MFkIrOZ/9pNJWE02DgfjkcOrFpKbiYKc0j5nN?=
 =?us-ascii?Q?LfSOUqNNEYKWtx5+Ihent5E9ZuD0fcxYNHH2KRzvdbVKGiAusjte8AdU7yeg?=
 =?us-ascii?Q?79Lq1nGjqzhXWmsuno4tNooPp6sNumzn0aW4w+fxOfYG1vscscp95Pv6JZWJ?=
 =?us-ascii?Q?DEausu7gTQY8JLBD3Aurx0C8x+KQ23IrF4QqhSM2zICS51RsQelkwgXu1L1+?=
 =?us-ascii?Q?oe7xX07OIew5rczdumyYURlc467b/bjvZh12eB1rjALKcqAy+iUR+vsjlBq8?=
 =?us-ascii?Q?hFDsUXGBCUv5aMPiX1vbnyfpO0UYrdZfd3gxI5iAbfGV5p6iKLHR/Oeph55n?=
 =?us-ascii?Q?+loT2DFCJ2bNAB3ytvAKIrBPl8A3b+j1smBrrizvCtGqZ6wKpf1JhixGffQP?=
 =?us-ascii?Q?wdR2W1woiqi1c9kuN+Mhx0b+CREqn+w+QolW8ylrbcXhcTUGz2WQXHB1saJY?=
 =?us-ascii?Q?7C4klMv5vEAgbghB/KGhjcXqLi8AMpZhEmZwvSyQ/EawL5bmkV/J7drZ0gnf?=
 =?us-ascii?Q?vEtao/cdNH0Vqkv+FjyvdS3YfKSW5KWWCoHQrR6HsOd22hPTKcVenL8Vfeul?=
 =?us-ascii?Q?iAJe60tYTC90nxNmqAtmDV6xw/LJklBDncvDtNDsXdYWitXZLT9vePBC1oCV?=
 =?us-ascii?Q?n6xUh4F8WpDzFvPdwnuV2+7G2KGhnZLu95u6H4aG3pyD3LS8hKpH5QotMYT3?=
 =?us-ascii?Q?o3vmkcwLoa3cfz6fIqc0mn8+c07MyHiIV/6l+iCKE1TjAWR+dXEaaVZlNtT7?=
 =?us-ascii?Q?IHdcwLae7XjwhP9d5EBZ/DaRwr9vkx/ao3ecojokDwcTKCGxFGn3SIdHxqtg?=
 =?us-ascii?Q?tBsU0HTTQyE1ygl/stlpx+oNQtHPLMFazInuf8Xso4id6RzDi+3yhmwlCSZn?=
 =?us-ascii?Q?ifUXWWDVH3pFkEag5bYPMZNrRQrS6IBRySoERzWdwBzw7NkytPWsaWVun93n?=
 =?us-ascii?Q?2ZHUfEDpdPM0Bb9deGW74kEzpu/dR7sMQTqTkExnPfUk6noSAgy376apkaOp?=
 =?us-ascii?Q?5dOV6muS8VUVsaH+43qGz+LjKWbArDFUFZNc+OA/UBD80NfsHeUD0L3Ba8Q+?=
 =?us-ascii?Q?MsUG6O6zu5bunSe2pvY=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 65d405c2-be55-40c1-fe8d-08dd97627886
X-MS-Exchange-CrossTenant-AuthSource: AS8PR04MB8198.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2025 05:52:14.2855 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: roNpVGfcg/j4qo0SNAOFq5jevUXSMhQAw2ML/3a1ADeiyQWup9xsWoLQ24f/uKdA
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7841
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

For user to identify dpaa2 mempool by operation index.

Signed-off-by: Jun Yang <jun.yang@nxp.com>
---
 drivers/mempool/dpaa2/dpaa2_hw_mempool.c | 20 +++++++++++++++++++-
 drivers/mempool/dpaa2/dpaa2_hw_mempool.h |  5 ++++-
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/mempool/dpaa2/dpaa2_hw_mempool.c b/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
index 09729d2828..118eb76db7 100644
--- a/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
+++ b/drivers/mempool/dpaa2/dpaa2_hw_mempool.c
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016-2019 NXP
+ *   Copyright 2016-2019,2022-2025 NXP
  *
  */
 
@@ -38,6 +38,14 @@ RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_bpid_info)
 struct dpaa2_bp_info *rte_dpaa2_bpid_info;
 static struct dpaa2_bp_list *h_bp_list;
 
+static int16_t s_dpaa2_pool_ops_idx = RTE_MEMPOOL_MAX_OPS_IDX;
+
+RTE_EXPORT_INTERNAL_SYMBOL(rte_dpaa2_mpool_get_ops_idx)
+int rte_dpaa2_mpool_get_ops_idx(void)
+{
+	return s_dpaa2_pool_ops_idx;
+}
+
 static int
 rte_hw_mbuf_create_pool(struct rte_mempool *mp)
 {
@@ -119,6 +127,14 @@ rte_hw_mbuf_create_pool(struct rte_mempool *mp)
 	bp_list->buf_pool.dpbp_node = avail_dpbp;
 	/* Identification for our offloaded pool_data structure */
 	bp_list->dpaa2_ops_index = mp->ops_index;
+	if (s_dpaa2_pool_ops_idx == RTE_MEMPOOL_MAX_OPS_IDX) {
+		s_dpaa2_pool_ops_idx = mp->ops_index;
+	} else if (s_dpaa2_pool_ops_idx != mp->ops_index) {
+		DPAA2_MEMPOOL_ERR("Only single ops index only");
+		ret = -EINVAL;
+		goto err4;
+	}
+
 	bp_list->next = h_bp_list;
 	bp_list->mp = mp;
 
@@ -150,6 +166,8 @@ rte_hw_mbuf_create_pool(struct rte_mempool *mp)
 	}
 
 	return 0;
+err4:
+	rte_free(bp_list);
 err3:
 	rte_free(bp_info);
 err2:
diff --git a/drivers/mempool/dpaa2/dpaa2_hw_mempool.h b/drivers/mempool/dpaa2/dpaa2_hw_mempool.h
index 9e21823fb6..8b2718bfa1 100644
--- a/drivers/mempool/dpaa2/dpaa2_hw_mempool.h
+++ b/drivers/mempool/dpaa2/dpaa2_hw_mempool.h
@@ -1,7 +1,7 @@
 /* SPDX-License-Identifier: BSD-3-Clause
  *
  *   Copyright (c) 2016 Freescale Semiconductor, Inc. All rights reserved.
- *   Copyright 2016-2019 NXP
+ *   Copyright 2016-2024 NXP
  *
  */
 
@@ -65,4 +65,7 @@ __rte_internal
 int rte_dpaa2_mbuf_alloc_bulk(struct rte_mempool *pool,
 		       void **obj_table, unsigned int count);
 
+__rte_internal
+int rte_dpaa2_mpool_get_ops_idx(void);
+
 #endif /* _DPAA2_HW_DPBP_H_ */
-- 
2.25.1

