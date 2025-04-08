Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59C23C3600C
	for <dpdk-dev@archiver.kernel.org>; Tue,  8 Apr 2025 06:02:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 92E5E40E1D;
	Tue,  8 Apr 2025 08:02:33 +0200 (CEST)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com
 (mail-co1nam11on2138.outbound.protection.outlook.com [40.107.220.138])
 by mails.dpdk.org (Postfix) with ESMTP id D29A44026B
 for <dev@dpdk.org>; Tue,  8 Apr 2025 08:02:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U0IZbr1FVMZSwBaGpmeqm5l4pzeDp6yk8pDf9O8R7WQ1hlfNF0CrQjKrh1MJD/gkjpu7OnhARd40sEWiklwYRDitaDfE6R0RP2MOA5MuPZUE/lZ86QinWh7YwN53h5HdhEFfHwz0mNGMP/LpTugzjjZuVAAwhQBSIr7gcFwVXRsZyRUP4ha3ZCq5ZXhwMtVKnNCkmvRPvwu9qSrS77K7PgUN9ozW3x1YXnkVnxTi0MBXFk/sW5x/EvFKHWcpEPh688x+5M5dLpnsNwBY/DT8gurtRaxikXv8SwaqNPm3Wxenu8jfHIQRypViSUmZKCLuEiX0s1jazueBj5M2HLwZQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=A4ArbfIGXedXCxPQ9bGB8A2yYrnSzqMtAlYThlTBg8g=;
 b=Xnz2oyOgI+k3iAFDSGUb1pxyzZvdABYr4inETT8GODkAGZMihi0exx8x8RM2q5osrv3cqIwypKcLUuv30h4QBalCGxbF9ttiJK8+IXgOm8cCA2oa7pe6zQXLCn4BpKyFA336pzr0lbKj+si9HIYIKnSdpl+VL2aC+VpGInLUKMUJLk1N5OmQc/8rXdlk1BQFL5LINfl+83CwZjs9jdtwSJS2xubGilaIcnC+JPX0MteWr1YvvyDCLQaLV9NyebtoRIQuXVtUDaYHBi5rPyS7KbkIAGFfrp/o6vNXqQ2Ydp1YAtILB6mHr99t3buIQKvJB+e/IIiTwmXGnQX4fpDexg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=A4ArbfIGXedXCxPQ9bGB8A2yYrnSzqMtAlYThlTBg8g=;
 b=vHYRAEApNdzaJTvdcwyuJ9+m/70P/5TJRboCoieoD3Wj+atWh76sGDE2y9guLoiHCmO0nal4P5xNXQIktEyKYWTrqrx9mu6oSuTN5hFaZjtCgaGey0sg0N+aEg7vy0Tqr0Vq8dFylLcS6NMvFlg7uYEAI0Yo5x7Ff2k/ZO21CjA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com (2603:10b6:a03:424::5)
 by SJ0PR13MB5918.namprd13.prod.outlook.com (2603:10b6:a03:439::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8606.33; Tue, 8 Apr
 2025 06:02:28 +0000
Received: from SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833]) by SJ0PR13MB5545.namprd13.prod.outlook.com
 ([fe80::b900:5f05:766f:833%4]) with mapi id 15.20.8583.043; Tue, 8 Apr 2025
 06:02:28 +0000
From: Chaoyong He <chaoyong.he@corigine.com>
To: dev@dpdk.org
Cc: oss-drivers@corigine.com,
	Chaoyong He <chaoyong.he@corigine.com>
Subject: [PATCH 1/3] net/nfp: support get RSS algorithm capability
Date: Tue,  8 Apr 2025 14:02:01 +0800
Message-ID: <20250408060203.473733-2-chaoyong.he@corigine.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250408060203.473733-1-chaoyong.he@corigine.com>
References: <20250408060203.473733-1-chaoyong.he@corigine.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0032.apcprd02.prod.outlook.com
 (2603:1096:4:195::12) To SJ0PR13MB5545.namprd13.prod.outlook.com
 (2603:10b6:a03:424::5)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR13MB5545:EE_|SJ0PR13MB5918:EE_
X-MS-Office365-Filtering-Correlation-Id: 74d186d1-f31d-4436-c393-08dd7662f117
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|52116014|366016|38350700014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?HF5mlC16J2KX+F/1L96o80owxZEZYLZ09KBWWSJe/8QWcz4NlgkRWMbukp9S?=
 =?us-ascii?Q?CG7GLjWKDIBDuOPEQcuK+W2Fu1SlRaj2OQ9kdngf0qnpOqGBOaK2de+eQFPW?=
 =?us-ascii?Q?osqgXxS1O5DcVIgUWSmzTeUSvViMwq1lumlVY38cBu7r2CH9CDUS1dOd1Mv6?=
 =?us-ascii?Q?sUHaWK9f0xS1++prhdX4G1gJ0E5Onv1TwSr8cZ23kiBsR7B/u3pTBSQX1sVq?=
 =?us-ascii?Q?Y+9Nod5+tDMzp0dBsvJaA78GfJPpd+TL6OLERNwP0QUx9fxLEvf2xKfBD1Wy?=
 =?us-ascii?Q?2WxDAlrWTvuUcTmVWzX6+/LMcC7NDzobx1/CPj2bQTqkzfQXcbpIeF9gUeDC?=
 =?us-ascii?Q?aKMDhwJw9NCryi0USorKjw3rOD03xxDEtiN97luB2H8r+ErsoX1LXK9J8JzN?=
 =?us-ascii?Q?lRoioyBhrboiXZC29QS8OJ0ZkKBuUUQG73PU5IQiDMJ1Rsm5U/Z964ubGOu+?=
 =?us-ascii?Q?JXBjfMqGR5Rl7cCz8rMTbpCvwdnvjozI5wq9d32RqFGSERolrEYbQ7ouh+h6?=
 =?us-ascii?Q?jarb/E8FoQyfCkYTbJt4Ztz5c8m8bQyPUoYkZBTILqxLPBGxOkIb3AUGsqya?=
 =?us-ascii?Q?jPkvBI0zHofX92PMnQVUBoJ5tVXpMv8+XqyQaCtkYHIcsIWOO7phRnySDw2g?=
 =?us-ascii?Q?LNRJzYYdXoYJnBBuGg7UUP7OUjOnTvCV6OlH2zYJrmMyi2fFvyHsNi5Aiyk6?=
 =?us-ascii?Q?XfTvWdYkWhU2E+FlE33mjkH81cV3hFs5cZSn45KfFtcpQeXMgZyWdB/me2I6?=
 =?us-ascii?Q?Dk1CrktAddQoWdJXm4CW0ib+hSlwNa5crNtHE0K82WLUw9Qp3ylAKU9jJbZE?=
 =?us-ascii?Q?ttG+wqb3hbAdhbRqFVyRJUgFy5gzXRDoaXuxpOA80PqUx3Rsp3tn2V1kpMEp?=
 =?us-ascii?Q?Zjjl8AuYvSf7m0GIUTmLJAHh+AAuE/lcUTwf/z2SXx5aJeNZJkz5X47MNXTz?=
 =?us-ascii?Q?j39AKI2iIcWbqzQn4mwkqk/sT03TsLZh5PNBwybNGQd668eEhe/Bg3k7Nkkz?=
 =?us-ascii?Q?sYpJvqPoa0Jd0B+oYTP0T2UpTnJhqIcx7MbuXwWIjPonntl3RSvk2mvcDOhI?=
 =?us-ascii?Q?b6RDAdo645d+z5sZeXJhB3JMfoKC9/0t4UOH+UoJjR8RNvoCSkXYC06DhOko?=
 =?us-ascii?Q?PsLs8xVQT87NziFBE9cXrYRB3HTmDgdzftv1aieLBl7Mf6iA0dcJYMZ5p7tr?=
 =?us-ascii?Q?DOcvhWqwO98xA8QDHo9ztNZZkzHAjE06eZv2Vl1v4nX+4aEF5Ps9L0rPMyED?=
 =?us-ascii?Q?ZWxOatpX9L41g1L4u8oKiVpaDIYU2yImqXoi8XC5dFqHc1H7SsnD5E0iBuo5?=
 =?us-ascii?Q?akho6ZZ0uJFC5NYjyLVx/5yJIZPraVWOUWzuT34FdW4IfFNUTTH5ma+WGr9r?=
 =?us-ascii?Q?7vgA1dDlk+fHHGaOjruZ20psQvniOg9VGlL31DJ5QXGCVd8pxiFRQ14k8rSs?=
 =?us-ascii?Q?2MAzfdq7YVv0D4ubkwk+bV9E2wMNxcGNMQeiCx5DZHwMwrmZpX/Osw=3D=3D?=
X-Forefront-Antispam-Report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:SJ0PR13MB5545.namprd13.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(52116014)(366016)(38350700014); DIR:OUT;
 SFP:1102; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?skqEHI00Bt1X6ARbj2wEP0/THG06MCmcRnv12m8dpDgA4iUpXtIgmbFjLbI5?=
 =?us-ascii?Q?VEXtahrZUqYrO4Ojx1+YtoDpb6ZBvgYjcTI+hNrZITyWtMNkK2odS39gfG2f?=
 =?us-ascii?Q?ix+hHR09ZWPQq67Kwg+zLLk7Q+jbmlxXyMmOgCoRobzcAo5Dy65j8JP5z9DD?=
 =?us-ascii?Q?C9LPQC2c9dvk2OISPvSUSmcBi10YamHFZaptsigAf7iwxBAWGBiFpkCSQdau?=
 =?us-ascii?Q?51Mzt9KCCyXUfqrlnhz8TKHoaW3wMPRQbqYhLtj9G3fxWwnDJnXZgQBN8Fn0?=
 =?us-ascii?Q?FsjqQlr/+iJyAv+EzPqDFpTdmgAAvd51kWOv2452U7AkOki0nUGeUFaGKjE2?=
 =?us-ascii?Q?hb+AxdqY66tXCAVI4+H4hgG01xD+mkuKg2vslYbpY0IBoc38OTnpyVsptcFz?=
 =?us-ascii?Q?iOzrkN0OiyeTTwGgD/IcT1lISDErkaZI1Z/zfUSRZrJ09yEkiHJvGL9HL2zi?=
 =?us-ascii?Q?OMXzGhRCmJ6W8FNl2oYYgzOd/SiRP4OX/2piQSirBL+ASxgVucOHRafxe9Ax?=
 =?us-ascii?Q?OCZgjToef+za5UCRYUz3cmNXpdRkc5vFJ/MgHZJ9ReJhzJdj5hCPOSEZNH8p?=
 =?us-ascii?Q?zv2AaIQFO0mdW84zm3h2WYt/V+3BTBILSqrvccySC+AbowpXUzlBdZ11HFya?=
 =?us-ascii?Q?HrfDDvao60YPWegnyB27wYxEeBfxN2+nqSwe8RSF1UsbldLWJrskj2NqMaLk?=
 =?us-ascii?Q?y/7h3CVNvGeXw9OSn0RhQDCE1F3qUUyUo6AN8t5p4rlcGkqxf3MncyElAtzd?=
 =?us-ascii?Q?24coMowkRIAJD0XGqXAw1QC8cTLAUYA2E6zfVStg+qzfRcAO7MLOkOJRnARW?=
 =?us-ascii?Q?GC2lpxV+dfA3HizpAXHr76ROIJDsog91DbItvA6IFHZpLd4YJNuKicMGj+Yi?=
 =?us-ascii?Q?WzNL7eElMPXoeF0F8fXOFnvGs1JRrSaG2/RogZY3NishkuqS0T8eBdUxPxfK?=
 =?us-ascii?Q?m9mJWUUpgrFILp35hY8g4uXkd36U/GLXXpAy287Egdq8c2NrqqwjxCYBtPis?=
 =?us-ascii?Q?TWFXAYusb9Y8Eka2pgz0nnKELmzdtnqpFQwGRIoZDLrBLE5pmAx3sPA6X0/P?=
 =?us-ascii?Q?5eyt7NcriVH5XbUkrN634FDrc7KHBUZOuGTdorQjlbTOkFHTzAYmUWwtNM1y?=
 =?us-ascii?Q?td9SGTCtxQ7ANwSBhWFcx31eQNkPtgleJy4uJ6v/QO9o3jZgt/9rn247mZc7?=
 =?us-ascii?Q?ur0IlicWHzc7Kvu2qi9UfAsOv2NAMQCjPpQumJU+9B+mXE5vdPDEIeHQm/bQ?=
 =?us-ascii?Q?Iz23Dlqegelorr1psH2qqJYrS98v/V5r+gK4PEmNIAOMvSI1caC31m4+AQ5p?=
 =?us-ascii?Q?P0JfpYoCTg6TKv90tdURM2XuKFlvAS4j0gGuzToGcXef9K1QlYf2M7b5zqJ7?=
 =?us-ascii?Q?i0gZdLmJGr6AkMQdY6dVVHgdRrllsS2YeGZJvMeHHcAej7IsthXnd2J89ylM?=
 =?us-ascii?Q?mZH8ph1AE5SHBM+jHYN6Jc8x9ZmynXi9wDNK/KfbHgEX/21Z6zeFYhX8180g?=
 =?us-ascii?Q?tDBepYw7QktlGDekanQMG61DUMvlT8umU5yXZSUSnNpLhuOIm43r2hVw0weU?=
 =?us-ascii?Q?VJstTo0Ll0T1XEv7yHO/Ca4iXfTe9JOGdVgQRKUhJ4ulsaEvnkqAJ5UFLmMZ?=
 =?us-ascii?Q?BA=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d186d1-f31d-4436-c393-08dd7662f117
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR13MB5545.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Apr 2025 06:02:28.2085 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 7nEmF2OlZgu9TzM169AoN+aAY1FvVkcIY6BRDJH79FtB2KcATEztFfb4vX9rMKyv2iFZEHhQIaABq59aqvrBDNq0sDMh2TqraIiK+zpgkUc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR13MB5918
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

Implement the logic of get RSS algorithm capability, also add the logic
of print RSS algorithm capability.

Signed-off-by: Chaoyong He <chaoyong.he@corigine.com>
---
 drivers/common/nfp/nfp_common.h               |  1 +
 drivers/common/nfp/nfp_common_ctrl.h          |  3 +++
 .../net/nfp/flower/nfp_flower_representor.c   |  1 +
 drivers/net/nfp/nfp_net_common.c              | 26 +++++++++++++++++++
 drivers/net/nfp/nfp_net_common.h              |  3 +++
 5 files changed, 34 insertions(+)

diff --git a/drivers/common/nfp/nfp_common.h b/drivers/common/nfp/nfp_common.h
index 7597d4090b..f0a4c557d6 100644
--- a/drivers/common/nfp/nfp_common.h
+++ b/drivers/common/nfp/nfp_common.h
@@ -39,6 +39,7 @@ struct nfp_hw {
 	uint32_t ctrl_ext;
 	rte_spinlock_t reconfig_lock;
 	struct rte_ether_addr mac_addr;
+	uint32_t cap_rss;
 };
 
 static inline uint8_t
diff --git a/drivers/common/nfp/nfp_common_ctrl.h b/drivers/common/nfp/nfp_common_ctrl.h
index 3db3cc90a3..01839c13db 100644
--- a/drivers/common/nfp/nfp_common_ctrl.h
+++ b/drivers/common/nfp/nfp_common_ctrl.h
@@ -191,6 +191,8 @@ struct nfp_net_fw_ver {
 #define NFP_NET_CFG_RX_OFFSET           0x0050
 #define NFP_NET_CFG_RX_OFFSET_DYNAMIC          0    /* Prepend mode */
 
+#define NFP_NET_CFG_RSS_CAP             0x0054
+
 /* Start anchor of the TLV area */
 #define NFP_NET_CFG_TLV_BASE            0x0058
 
@@ -248,6 +250,7 @@ struct nfp_net_fw_ver {
 #define   NFP_NET_CFG_RSS_IPV4_SCTP       (1 << 14) /* RSS for IPv4/SCTP */
 #define   NFP_NET_CFG_RSS_IPV6_SCTP       (1 << 15) /* RSS for IPv6/SCTP */
 #define   NFP_NET_CFG_RSS_TOEPLITZ        (1 << 24) /* Use Toeplitz hash */
+#define   NFP_NET_CFG_RSS_XOR             (1 << 25) /* Use XOR as hash */
 #define   NFP_NET_CFG_RSS_CRC32           (1 << 26) /* Use CRC32 hash */
 #define NFP_NET_CFG_RSS_KEY             (NFP_NET_CFG_RSS_BASE + 0x4)
 #define NFP_NET_CFG_RSS_KEY_SZ          0x28
diff --git a/drivers/net/nfp/flower/nfp_flower_representor.c b/drivers/net/nfp/flower/nfp_flower_representor.c
index e377d45e53..33fb98ceea 100644
--- a/drivers/net/nfp/flower/nfp_flower_representor.c
+++ b/drivers/net/nfp/flower/nfp_flower_representor.c
@@ -181,6 +181,7 @@ nfp_flower_repr_dev_infos_get(__rte_unused struct rte_eth_dev *dev,
 		dev_info->flow_type_rss_offloads = NFP_NET_RSS_CAP;
 		dev_info->reta_size = NFP_NET_CFG_RSS_ITBL_SZ;
 		dev_info->hash_key_size = NFP_NET_CFG_RSS_KEY_SZ;
+		nfp_net_rss_algo_capa_get(pf_hw, dev_info);
 	}
 
 	return 0;
diff --git a/drivers/net/nfp/nfp_net_common.c b/drivers/net/nfp/nfp_net_common.c
index aaa515bac2..6284c54f5b 100644
--- a/drivers/net/nfp/nfp_net_common.c
+++ b/drivers/net/nfp/nfp_net_common.c
@@ -396,6 +396,7 @@ nfp_net_log_device_information(const struct nfp_net_hw *hw,
 {
 	uint32_t cap = hw->super.cap;
 	uint32_t cap_ext = hw->super.cap_ext;
+	uint32_t cap_rss = hw->super.cap_rss;
 
 	PMD_INIT_LOG(INFO, "VER: %u.%u, Maximum supported MTU: %d.",
 			pf_dev->ver.major, pf_dev->ver.minor, hw->max_mtu);
@@ -442,6 +443,12 @@ nfp_net_log_device_information(const struct nfp_net_hw *hw,
 			cap_ext & NFP_NET_CFG_CTRL_FLOW_STEER      ? "FLOW_STEER "      : "",
 			cap_ext & NFP_NET_CFG_CTRL_IN_ORDER        ? "VIRTIO_IN_ORDER " : "");
 
+	PMD_INIT_LOG(INFO, "CAP_RSS: %#x.", cap_rss);
+	PMD_INIT_LOG(INFO, "%s%s%s",
+			cap_rss & NFP_NET_CFG_RSS_TOEPLITZ        ? "RSS_TOEPLITZ "   : "",
+			cap_rss & NFP_NET_CFG_RSS_XOR             ? "RSS_XOR "        : "",
+			cap_rss & NFP_NET_CFG_RSS_CRC32           ? "RSS_CRC32 "      : "");
+
 	PMD_INIT_LOG(INFO, "The max_rx_queues: %u, max_tx_queues: %u.",
 			hw->max_rx_queues, hw->max_tx_queues);
 }
@@ -1406,6 +1413,7 @@ nfp_net_infos_get(struct rte_eth_dev *dev, struct rte_eth_dev_info *dev_info)
 		dev_info->flow_type_rss_offloads = NFP_NET_RSS_CAP;
 		dev_info->reta_size = NFP_NET_CFG_RSS_ITBL_SZ;
 		dev_info->hash_key_size = NFP_NET_CFG_RSS_KEY_SZ;
+		nfp_net_rss_algo_capa_get(hw, dev_info);
 	}
 
 	/* Only PF supports getting speed capability. */
@@ -1430,6 +1438,7 @@ nfp_net_common_init(struct nfp_pf_dev *pf_dev,
 
 	hw->max_rx_queues = nn_cfg_readl(&hw->super, NFP_NET_CFG_MAX_RXRINGS);
 	hw->max_tx_queues = nn_cfg_readl(&hw->super, NFP_NET_CFG_MAX_TXRINGS);
+	hw->super.cap_rss = nn_cfg_readl(&hw->super, NFP_NET_CFG_RSS_CAP);
 	if (hw->max_rx_queues == 0 || hw->max_tx_queues == 0) {
 		PMD_INIT_LOG(ERR, "Device %s can not be used, there are no valid queue "
 				"pairs for use.", pci_dev->name);
@@ -3222,3 +3231,20 @@ nfp_net_led_off(struct rte_eth_dev *dev)
 {
 	return nfp_net_led_control(dev, false);
 }
+
+void
+nfp_net_rss_algo_capa_get(struct nfp_net_hw *hw,
+		struct rte_eth_dev_info *dev_info)
+{
+	uint32_t cap_rss;
+
+	cap_rss = hw->super.cap_rss;
+	if ((cap_rss & NFP_NET_CFG_RSS_TOEPLITZ) != 0)
+		dev_info->rss_algo_capa |= RTE_ETH_HASH_ALGO_CAPA_MASK(TOEPLITZ);
+
+	if ((cap_rss & NFP_NET_CFG_RSS_XOR) != 0)
+		dev_info->rss_algo_capa |= RTE_ETH_HASH_ALGO_CAPA_MASK(SIMPLE_XOR);
+
+	if ((cap_rss & NFP_NET_CFG_RSS_CRC32) != 0)
+		dev_info->rss_algo_capa |= RTE_ETH_HASH_ALGO_CAPA_MASK(DEFAULT);
+}
diff --git a/drivers/net/nfp/nfp_net_common.h b/drivers/net/nfp/nfp_net_common.h
index d85a00a75e..a6addf8610 100644
--- a/drivers/net/nfp/nfp_net_common.h
+++ b/drivers/net/nfp/nfp_net_common.h
@@ -402,6 +402,9 @@ int nfp_net_get_module_eeprom(struct rte_eth_dev *dev, struct rte_dev_eeprom_inf
 int nfp_net_led_on(struct rte_eth_dev *dev);
 int nfp_net_led_off(struct rte_eth_dev *dev);
 
+void nfp_net_rss_algo_capa_get(struct nfp_net_hw *hw,
+		struct rte_eth_dev_info *dev_info);
+
 #define NFP_PRIV_TO_APP_FW_NIC(app_fw_priv)\
 	((struct nfp_app_fw_nic *)app_fw_priv)
 
-- 
2.43.5

