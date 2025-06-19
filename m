Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B13D5C71159
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Jun 2025 07:17:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D9D3242DC1;
	Thu, 19 Jun 2025 09:17:36 +0200 (CEST)
Received: from NAM10-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam10on2069.outbound.protection.outlook.com [40.107.93.69])
 by mails.dpdk.org (Postfix) with ESMTP id 589DF4025E
 for <dev@dpdk.org>; Thu, 19 Jun 2025 09:17:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AV9M/8B+L6cjoqogNIzvfefeyTbaoLw07lnSKna8wBpbiVhDD8QgQbyzwik4Rt162VQTacuLPVXvs5+Q8cIBjKoMDgjr0J28cgjiNKVlbG7a9psI8KUS6yha6VBHD+pNNMBRgbDSYnujcHArlIhCeocSlCRjNj8vTIUVLm+q82OxFtSm0lviNoUzM/56ne4hvs71s4eHhb0EOdxp1+VRcpRSGgJ58tf/ydS76po+sVIat95PxEwo7QriP/eOREjh+xLL//GuyQKKbLP/9albEEYz8Ww5MO491A+HySbg2oVRCFhYhCQW/zX6VvHOPddqrpOlgEHzwUXCM0fvVHriGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xlcw1cVxD6NG/jB/m1bHVlSZExJeTLrNrAG9hPG0oTw=;
 b=J5vmjGAw5sTi72Zj5dVbWHZsyroGAJgcASUK4Jk1/Ns+kuDuEu47ZpoO4OYX56S/iXcIE4K3ziooj21e1WmPhyv3dtfybGYIBJ0Z8vI+hjb/yxq0vnnAD0G4lE/3T3HqEt/szsyv83/RCY/dYCml/LUVA313Knc0rwWw3GB92nr9whVX/iZAFBq/Fjp61xkd8OXBlR1rIoWQLoaqXH3W8pIe0U19PLDIz70zUhJ5jOvQYDDAHxgBRU7b21eopC04hVPpXVZg1EL54JfUnmIkFX/dW+JyA97ooRq97NwAMHULvKVnKSP3kSBOR2SkkEJqxKicqdTO8XfdLxmjodyScA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xlcw1cVxD6NG/jB/m1bHVlSZExJeTLrNrAG9hPG0oTw=;
 b=cNqvqjH6CY2+wUI8mal3+t4pRQgSskH+/0hF0wUqzo/iqpOV+m0OAFFobXgv6pL/ABkyTgecjuFTqbI+V2TTLr7bNtZDI0kroMKNXRjRYOehHjoKC6INE9u76TbozxD8LJ03URgh5KbRmGqIsBs5htEPksTYpSzcFnrqeF+CsQV1YSqOw4+keY9qk4R/ipsirwDpJt1uKy/5cwwzmh3loHbmQYc3Iaw7wMYIMREfDme3t713FfzAHN6QPoo9a5XjoFjQvcf20NNp24T73+eXBRECJ+kCsjFcdxHTTiCiIxJF3QZra+78rRv2Fz8b13dDqv/I/SYnVG+/9JxcC9fdzQ==
Received: from BYAPR11CA0067.namprd11.prod.outlook.com (2603:10b6:a03:80::44)
 by SA1PR12MB6800.namprd12.prod.outlook.com (2603:10b6:806:25c::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8835.27; Thu, 19 Jun
 2025 07:17:31 +0000
Received: from BY1PEPF0001AE1A.namprd04.prod.outlook.com
 (2603:10b6:a03:80:cafe::65) by BYAPR11CA0067.outlook.office365.com
 (2603:10b6:a03:80::44) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8835.34 via Frontend Transport; Thu,
 19 Jun 2025 07:17:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF0001AE1A.mail.protection.outlook.com (10.167.242.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8857.21 via Frontend Transport; Thu, 19 Jun 2025 07:17:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 19 Jun
 2025 00:17:21 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 19 Jun
 2025 00:17:18 -0700
From: Rongwei Liu <rongweil@nvidia.com>
To: <dev@dpdk.org>, <matan@nvidia.com>, <viacheslavo@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <thomas@monjalon.net>
CC: Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao <bingz@nvidia.com>
Subject: [PATCH v1] net/mlx5: use reg to match eswitch manager
Date: Thu, 19 Jun 2025 10:17:04 +0300
Message-ID: <20250619071704.1718079-1-rongweil@nvidia.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE1A:EE_|SA1PR12MB6800:EE_
X-MS-Office365-Filtering-Correlation-Id: 88697654-08c4-4ec4-50c6-08ddaf015ab1
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?LKZXD8jZZJeKqcbQCl+CDCl5zznthZB0g22Tx46RMjFY4jr0Ewhg1YpVJTD8?=
 =?us-ascii?Q?Wmh9DpUvzuO66FZxey57/+TE4bh4yXB0qzyone/iedkLYyxkQ2Q+Z6ronrMe?=
 =?us-ascii?Q?YpVcnU6OiQsbRQeEPk00LGVnmXqa800ttbMVYvh9mOUomKV/EzjzxPstloIc?=
 =?us-ascii?Q?M1Z0elX4ayQQfWTouemBaohOYFcxdBHzDCHTAe2mIwZrSgWUpaf1bEzKPVs6?=
 =?us-ascii?Q?eW4574QQqkCmdDE3dsogYBhTFh0WUJSG+1u8Q8kYLoGmc+uYE0N/UDqM4uQJ?=
 =?us-ascii?Q?GClkrABXgt9YcTULxPkwfMCIxpBDFYxtaw5b3tFUAqxf/Srlj3WiAsK1jDTZ?=
 =?us-ascii?Q?H2qK6g8UrJUjogzc75GpROXAJGH77lLVRkKjn7ySXXk4gUM/doxnk9PhhSO1?=
 =?us-ascii?Q?c2pQOW5LhBRrUY3p/wFPbnZ5TkwALhda4QpBp4Jjhn3raG7l9/8n6jsx8eS3?=
 =?us-ascii?Q?X0o60JsmrtQrrK9akOFB6Ov/ji02AVLHbPH/SQUqEXBuZc6UkZRG+KW7w5ov?=
 =?us-ascii?Q?p1b/MK49vSDQqIQOS08P04ahfHtPVAVpAfLKCdA/uCCFioKnbinQCjZEkRO4?=
 =?us-ascii?Q?RfSgh429Guo9V7+ABYdYvEgjni/OtiRTo5d/aWNGDi7hujNoJbgJQ0kx1YYF?=
 =?us-ascii?Q?EghdsgvQd1ZmkNP9PA+P/ltjtcipryLk+JVb+z5U5PtaVtmAV7cBdfpVMrA7?=
 =?us-ascii?Q?cZ3Hk6kC9TVJxRIfbd812jcl2R59xJHCKZAAfuys4wjHiIHih9oKAAnThihF?=
 =?us-ascii?Q?uzJkQ4ypqEicaj8dR/bb6vP4ENb0XrjdQ7USKuzOfvClDebZ6aBl59mlaB/4?=
 =?us-ascii?Q?giC89nvYtuKDjGINoWL3IiuFsdPPRsa6gYH2FVre2XmNSPoGfDCzWBtBjczd?=
 =?us-ascii?Q?kUQFMo1f+OECNTUO5WYzAPTLXvxNvGniEJzZke55W4nBdbw25v2eoWN6FEYI?=
 =?us-ascii?Q?vJIk/373Iqq724cOAKuEKeiXVUvikfMc6vVHT3AJ1js1nancoRb0XUXLtien?=
 =?us-ascii?Q?Kc5n+lbwTPX4yENDNESbkjWGaiGIEhbLJ+LGEDXPjlHJFDzDtxA1hawsgpu9?=
 =?us-ascii?Q?AJc4rsOISRIXB5ZSBU3LY/DanhgX5bRohui7BZSfiXLWWil9SkGfYRI8xAPH?=
 =?us-ascii?Q?Hb42Cc3J3eciFOfc7JghHfAP8zQmxq6DERsQFrx//cdW43YWxTBk85Pr0CAZ?=
 =?us-ascii?Q?/bYUAFkXgmJzTsPDc2jhrXfoVZ3vqEBq1osuK4GX7HuRZTLn39VFpp6DfTXB?=
 =?us-ascii?Q?CnAQpurAUYRhQkDqk5uRFkrR7tqcGg0YpHYZ129YiuSJlWFAp0AoHILD5GI0?=
 =?us-ascii?Q?0dDiRupiZYpwpGjGrSOIDb0UDqBBSDR2Ir/mPW77OgRlfMG/k3kkEx01nHf6?=
 =?us-ascii?Q?idrno3J/MdubUUERzd/0WMNrlQZ2IGQKaDL2FzWkOMyorsJX/5y2WpvKO+u6?=
 =?us-ascii?Q?Z/Zdk9GdlrXHd89dSq+4RYc3fSAf0bGhW5fvRFjJy3UqUlOc8ADt8st5bd8H?=
 =?us-ascii?Q?ooA7IORx/aFzWAvxZDZYw7xwrhQInPsr1TIG?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Jun 2025 07:17:30.7223 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 88697654-08c4-4ec4-50c6-08ddaf015ab1
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BY1PEPF0001AE1A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6800
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

Rdma-core exposes E-Switch Manager vport metadata
for matching in flow rules.
Use that metadata when available.

Signed-off-by: Rongwei Liu <rongweil@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_dv.c | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index c217634d9b..d555a9cdcb 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -10885,9 +10885,21 @@ flow_dv_translate_item_port_id(struct rte_eth_dev *dev, void *key,
 
 	MLX5_ASSERT(wks);
 	if (pid_v && pid_v->id == MLX5_PORT_ESW_MGR) {
-		flow_dv_translate_item_source_vport(key,
-				key_type & MLX5_SET_MATCHER_V ?
-				mlx5_flow_get_esw_manager_vport_id(dev) : 0xffff);
+		priv = dev->data->dev_private;
+		if (priv->sh->dev_cap.esw_info.regc_mask) {
+			if (key_type & MLX5_SET_MATCHER_M) {
+				vport_meta = priv->sh->dev_cap.esw_info.regc_mask;
+			} else {
+				vport_meta = priv->sh->dev_cap.esw_info.regc_value;
+				wks->vport_meta_tag = vport_meta;
+			}
+			flow_dv_translate_item_meta_vport(key, vport_meta,
+							  priv->sh->dev_cap.esw_info.regc_mask);
+		} else {
+			flow_dv_translate_item_source_vport(key,
+					key_type & MLX5_SET_MATCHER_V ?
+					mlx5_flow_get_esw_manager_vport_id(dev) : 0xffff);
+		}
 		return 0;
 	}
 	mask = pid_m ? pid_m->id : 0xffff;
-- 
2.27.0

