Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16D38CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 13:02:35 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0AB60402D8;
	Wed, 12 Nov 2025 14:02:35 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010038.outbound.protection.outlook.com [52.101.85.38])
 by mails.dpdk.org (Postfix) with ESMTP id F3097402D1;
 Wed, 12 Nov 2025 14:02:32 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=OO0NzcnZE143V9CkN3YxF3w547oRGkjHAHsTKKVUBXd1EnIQ1xpCDj5BOl+RvscvhaCnd8iLq8jz7ItWg2R+Y1ZMT8324CyDHmvOoRuoBRH/9l+kvYaTSO1tThWGqmYmYKHHIsm6ikDVmvNp3x1G9zm00V0s4JLOFLum5tqyXb5mQ6dTb5v72wBFQP5xTxjd7g3kXCRPl+6b5fid4WaER7ktbTwWiw5tgHMHn2NneM6e3JXX5e8GW35/wm9X7wWpO9WYMUESUw3m9TTfzPGQWYZ0LfDP0DlS61vYzcu+/YHTWkjOk03TpvKSk/GxjJ44Ok8zbUA+il3eZh5DoD0jkA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HfmX2/HaDosLRQidasRnby97S/qwmC/S5KxkbwFR4QU=;
 b=rKOgwZX2mWCs+E8AWO9aqrvO4C+vwh4GTRm08040OPGZhYFRaQY7yFh3nVtHR6iqP4xJ2ZFseppbwgJ1bCkZGmLxoQycbXh9s2DitovraRaipeCbiPHWmVqmbAjeaiDL/hEnwgKlNqcwpCt9m/2sFgWgAew9IB9YYFhGCsBx2Hil/3wahXLX6gQH6gyfl+7Aq5Dmc4j051bCVqN91eX7AyLMkdhSL73JiSno+vrbvQMRersUoG48jz8trB+7nsVqhapAC3UVf3KwXFInD2ti1EBjozt03cWZDHE0KTKLBBeON20qmzPi0oH5kFkjPL5lAxjyQE4CpYSPGrtxhOXZOw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HfmX2/HaDosLRQidasRnby97S/qwmC/S5KxkbwFR4QU=;
 b=i4ziSnrOmM0fU3XayqS6rJY/4cXhWN5+YCnKCby3Do5iaSkcXDUiYzMP4ADpG37IUk59gQh+vjg5Bxew0EXWY05syjiWAtyjoPuF35lN1Zw6+kjdB1fmd30OD2cNsfGtJT+Nfwl2dkjz062gAVeEK8dzP0cMXvkTztsFPpgAi0ZFwN55Ql+YCa56qGQICUz/mTReD6PrthSNYNkLy2/Y7lzkBGw31jC5T7h3xycuMcp4aP8jATduicEdExXV8w4JidvzNtP52fHA0CxE5S00lo4tVtwt4F/J0T+yW4mSR/lL0839/uxafq6DOq40LH+NOHRWYc0nMLK1xgayMUVI6Q==
Received: from CH2PR05CA0069.namprd05.prod.outlook.com (2603:10b6:610:38::46)
 by SN7PR12MB8101.namprd12.prod.outlook.com (2603:10b6:806:321::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 13:02:26 +0000
Received: from CH2PEPF00000146.namprd02.prod.outlook.com
 (2603:10b6:610:38:cafe::f6) by CH2PR05CA0069.outlook.office365.com
 (2603:10b6:610:38::46) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.16 via Frontend Transport; Wed,
 12 Nov 2025 13:02:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000146.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 13:02:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:02:04 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 05:02:01 -0800
From: Gavin Li <gavinl@nvidia.com>
To: <dev@dpdk.org>, <dsosnowski@nvidia.com>, <viacheslavo@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>
CC: <jiaweiw@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>, Bing Zhao
 <bingz@nvidia.com>
Subject: [PATCH V2] net/mlx5: fix IPv6 DSCP offset in HWS sync API
Date: Wed, 12 Nov 2025 15:01:39 +0200
Message-ID: <20251112130139.194450-1-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250930072827.9630-1-gavinl@nvidia.com>
References: <20250930072827.9630-1-gavinl@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000146:EE_|SN7PR12MB8101:EE_
X-MS-Office365-Filtering-Correlation-Id: ef06e9bf-9935-4cbe-35ff-08de21ebba86
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NjCWJurBtc1NyorXz5AmX9nmD847v/nw85mrEvdR0Bx4t1orIUdaICcZY/hT?=
 =?us-ascii?Q?+XFsSbkj7j5uH8bdGd/dQXeLuGC83YkNaCmq+z0Mf2dbNakHm7FJgUocHcDc?=
 =?us-ascii?Q?TXBN6oIE2ZARCxYekMOpGzujwn2DFuLlzWDQI0GnKcyMO/BhdE6AmRQYVLEx?=
 =?us-ascii?Q?NPIw7whV1tbQSyEe40pyAp2qun09sFfbhgrwatzPsTFDpgabLjmdelRIeLO2?=
 =?us-ascii?Q?CsW4uU3nWzfu4jfaAppk1SobvSTzpTZBPfhCarlF0h3cbnJA7xrDv/WnWLJI?=
 =?us-ascii?Q?KqNB9eJxGl/x4A+nJMoh8oKVsnMLypmx8GyYKbiu9qn02HXAG43ExQmoJnwX?=
 =?us-ascii?Q?pw3Gei+lP7BslFEG68Q4nLBUXw5Vo/JK0aVYdVRV+G7wIu+z1Ot3bZtKVW4m?=
 =?us-ascii?Q?QWdvveQ87/shVk4yUYy5DEYUWJe/aX/l8CgBfuE9Gy84Hr4LGxze/IqOXa2j?=
 =?us-ascii?Q?BTg+j+dxdxsVL8jP6hMLpkHWuspvQ1ArwkElBm+1D9FkX9KtiRedxyxSZKCD?=
 =?us-ascii?Q?GGYd7sIsTrdLYgQeZNsx+v8b88HE1jA97yqw0yg6f6MjNI/lZo6uUr1wIo8f?=
 =?us-ascii?Q?bishORn1YAyn0kZlpV373oJHjxZ4z/H/3S90a+XToVpbk4A19MLGGV30KlEL?=
 =?us-ascii?Q?U2HfDFtuu60gEPcjaUEeDAl/WnJYiOOTI1pY617L0ovWjgNUTIB55VwdcuVw?=
 =?us-ascii?Q?EYnD8X/gR8o9i8UkFaI6ZPUjUfFDBfong8akCq+n+jZHC4jCS9KZU+K0I2cf?=
 =?us-ascii?Q?qgBynKlqhuOA+YLjTZD2jtyDd8FcTGjwItlUh7nQkSI/18l1rU883uPpvYvJ?=
 =?us-ascii?Q?6gF7wzUJP6gb+RNG/vOAOYdfGMwsH4x71T2/1uYzCqp6nnD3QaYA+Rxn0Mdl?=
 =?us-ascii?Q?1Nf3Y2EEQ5Wbd6R42X+U6g3uYVpdyJPWolN2tgkHhE5VShQWknHZWHZpjArC?=
 =?us-ascii?Q?Tz+dFGV2icJRsSRCgPmuE5YZJZObJE4uJjTPFhTfMr62uLen/DpVWv+EuVTS?=
 =?us-ascii?Q?62K68M+IfWxKPGJeALkh6grag+jlnlrxcMOj5JmJ9HZJTljTQH7NxgA6RD0U?=
 =?us-ascii?Q?JGuroTOUQtkZVGaCvpP9kpVqrgz5yreYYNxqbhcmuqXob+lllHNa6mgJA0JE?=
 =?us-ascii?Q?sFymL4a4nVBp70CDVmIFWL1ByMzeasCy+B1DgvWsgQJHR7H9Iynb1fQ6qRts?=
 =?us-ascii?Q?Cy+u5dsE7A+xBpnBPDfFfbcPd7Hfp2mCF0DCmnDpLij+e9JLOkVsfYXvmYi4?=
 =?us-ascii?Q?TQkuYBw3JwKCH9hh6gLPLIpJ2NSJQYRQjnHHa267T5w48EpJP1rlVf9zPH3G?=
 =?us-ascii?Q?QPWhx4BjIeJemR+cHxjS0uPulWewUMMbT/TWQ8DkRie6ImQrwRoN8q38lgQ4?=
 =?us-ascii?Q?4bcHZCMIW3O4AMmGG2rpUNnpe75cKKMYIna1V9hmGYlw6v6PYTfAyknJpvO/?=
 =?us-ascii?Q?b3zLA4nGen8dQL91n5rv8uc0TK7GxZHrrSlcXQyuiE4IPL9z3D/56r6SgR9s?=
 =?us-ascii?Q?t/DqRueqfGEaxTiakqqI20mUMzn+0UuVgwnDWxm+Mm+3HOEGkaQQ3ChiJ3wh?=
 =?us-ascii?Q?HN5Zl6e7wJimKr+TJEk=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 13:02:26.1988 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef06e9bf-9935-4cbe-35ff-08de21ebba86
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF00000146.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8101
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

The RTE action process in synchronous flow API with hardware steering
differs from the process in SWS. The bit shift handling for IPv6 DSCP was
not handled in HWS, resulting in incorrect data in the field.

To resolve this, bit shift handling should be added to HWS.

Fixes: ec1e7a5ceb69 ("net/mlx5: update IPv6 traffic class modification")
Cc: stable@dpdk.org
Signed-off-by: Gavin Li <gavinl@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow.h    | 5 +++++
 drivers/net/mlx5/mlx5_flow_dv.c | 6 ------
 drivers/net/mlx5/mlx5_flow_hw.c | 5 +++++
 3 files changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow.h b/drivers/net/mlx5/mlx5_flow.h
index e8b298dd1d..fafcdccbed 100644
--- a/drivers/net/mlx5/mlx5_flow.h
+++ b/drivers/net/mlx5/mlx5_flow.h
@@ -3715,6 +3715,11 @@ void
 mlx5_indirect_list_handles_release(struct rte_eth_dev *dev);
 
 bool mlx5_flow_is_steering_disabled(void);
+static inline bool
+mlx5_dv_modify_ipv6_traffic_class_supported(struct mlx5_priv *priv)
+{
+	return priv->sh->phdev->config.ipv6_tc_fallback == MLX5_IPV6_TC_OK;
+}
 
 #ifdef HAVE_MLX5_HWS_SUPPORT
 
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 95ca57e8c4..83046418c4 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -1638,12 +1638,6 @@ mlx5_modify_flex_item(const struct rte_eth_dev *dev,
 	}
 }
 
-static inline bool
-mlx5_dv_modify_ipv6_traffic_class_supported(struct mlx5_priv *priv)
-{
-	return priv->sh->phdev->config.ipv6_tc_fallback == MLX5_IPV6_TC_OK;
-}
-
 void
 mlx5_flow_field_id_to_modify_info
 		(const struct rte_flow_field_data *data,
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 208f50fbfd..d3d2272338 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -1629,6 +1629,11 @@ flow_hw_modify_field_compile(struct rte_eth_dev *dev,
 			value = *(const uint8_t *)item.spec << 24;
 			value = rte_cpu_to_be_32(value);
 			item.spec = &value;
+		} else if (conf->dst.field == RTE_FLOW_FIELD_IPV6_DSCP &&
+			   !(mask[0] & MLX5_IPV6_HDR_ECN_MASK) &&
+			   mlx5_dv_modify_ipv6_traffic_class_supported(dev->data->dev_private)) {
+			value = *(const unaligned_uint32_t *)item.spec << MLX5_IPV6_HDR_DSCP_SHIFT;
+			item.spec = &value;
 		}
 	} else {
 		type = conf->operation == RTE_FLOW_MODIFY_SET ?
-- 
2.34.1

