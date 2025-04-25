Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 754A1C369C2
	for <dpdk-dev@archiver.kernel.org>; Fri, 25 Apr 2025 19:33:38 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 403614025E;
	Fri, 25 Apr 2025 21:33:37 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2081.outbound.protection.outlook.com [40.107.244.81])
 by mails.dpdk.org (Postfix) with ESMTP id 5A89D4021F;
 Fri, 25 Apr 2025 21:33:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=d8mqCL9RJ250mM2M4mNNCi0Wjpv64mTq9XlrenUymcp+1jEfgHy0dx2NuaMHCqjFXxFJrdcRmq47bttbzxneY8X5nYL2GkRWTKttrjTNfnSli+swivIY67BtN7wOVgiPFNlN8tUgT9TK0T845pqUul3kyqDTIN15bu5e6LoNA5bo77+ZbEf7X7GdGVrMTiSNRw3Q2flDzL7/MbJQ9ZYrv1dCZuAqzY2frtCx973IMtBqHAloPTeZ1HdZEZiiia7bZnGRjlWEcx0MrzXckAB+RG1jIb1o6rSGz3W/d+wH/qTlhjO2naed4LXj8zcM0F0jdY9A16JuuPlzH/J5shPlfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGPgXxsWv3+rXqasAwxi6UHbtGiaI5Cfz8/Rwzbd3Ck=;
 b=Zw072oHeSQU6e8ns4A+yAB25+S5AkBR2mGi0LYRklN7SK3O+lCNbax59huNRMJy1os+Kh1zsfWJKphMtLQsOilPnuu9zyeZexuWUIOtv5FMDwYLXbOVvHWi//jbqriAdSjp4crstvzZxQXpc5QBhICLbuCXQkYLpDrjF8EObZ8DEQNERHinD6B4AjjSNrZr9EeOaCKDnQoJu0OdK57gbXswkYLBxspy+YqIsCnACKE4q2AdJ3lGGqhATYOKutLXXUziC3a/TH9hWeHMPKrUlvnjxTUvkp/uEs0YKPj4ZtE1XlU4ItJSTF2XTpk6EypzgzKHmL+WG2N2978IuNXLyKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGPgXxsWv3+rXqasAwxi6UHbtGiaI5Cfz8/Rwzbd3Ck=;
 b=IRZe5DAeIEeavO2y4EKsNlIV/8A8kyWMnzpB/Z9JEkByrRvumH9ze5lIvMReqr/AWDzK6p4s3rQHyzacLOQFmoaN1RYGWURg0WaCWimD/OmAJjn37MOKc5WxT+bomwKIl02xxEhmewWI1elJfm9YbUFHOeMk981C3km7JUPVVLrBtmw0exGr8bUVy6z9i0GIGmYqCoSbjjs/B3i0BTHhqRJv4VcX7OiZ61tOmxPqy9wEH7dJHLdNSml0J0NM0Wa0BVv43A/Lt/gQzJiB2WgDYsDewbXpW8rGXQOvxS+t44X+jFxEV4G2UenYwksNoEs8G1da+1tYDc2I5F896UbuBQ==
Received: from BL0PR05CA0009.namprd05.prod.outlook.com (2603:10b6:208:91::19)
 by PH7PR12MB8827.namprd12.prod.outlook.com (2603:10b6:510:26b::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8655.35; Fri, 25 Apr
 2025 19:33:30 +0000
Received: from BN3PEPF0000B06E.namprd21.prod.outlook.com
 (2603:10b6:208:91:cafe::3a) by BL0PR05CA0009.outlook.office365.com
 (2603:10b6:208:91::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8655.33 via Frontend Transport; Fri,
 25 Apr 2025 19:33:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN3PEPF0000B06E.mail.protection.outlook.com (10.167.243.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8699.1 via Frontend Transport; Fri, 25 Apr 2025 19:33:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Fri, 25 Apr
 2025 12:33:17 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 25 Apr
 2025 12:33:15 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix modify field action on group 0
Date: Fri, 25 Apr 2025 21:32:57 +0200
Message-ID: <20250425193258.38994-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06E:EE_|PH7PR12MB8827:EE_
X-MS-Office365-Filtering-Correlation-Id: 68372835-b3ff-41a0-357f-08dd84300f41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|36860700013|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?NMaXkK5TZidf+7bqYQUPFY9ffbESe0grk1gN3lLsEdyO5cUCpCQXdoyonflR?=
 =?us-ascii?Q?1GPBQ5ieTMU5DE/w0T2tkzR5W82ZTbrrFleXKGon/zcAX3XjP3aD45yo1O5Z?=
 =?us-ascii?Q?kFlWuEJR3h5ajKnRMZHWbjv58rWVmFUnZgPxiqdBQjFOtU401tiUyaeoAZZs?=
 =?us-ascii?Q?fv/FwLJiLoXhGx5ztGZ4aZESF/bhx25kHb6NMJTtdFN2BWFsSSprdatOsN7G?=
 =?us-ascii?Q?D45VDSiDmhbOYVNSxsoeKzug578VLnyV+w+29crKqq5VGb+7gAdRFQQPcEn9?=
 =?us-ascii?Q?tgyR/8P3D7VqIAjwmKZEAbp93Mn1hucwqwHP+4hp2FA0jGZNrtQg0XwqB5Lq?=
 =?us-ascii?Q?oPaBH/68s2dxRFO+5jSnjvQYmwn1FdqS9gzOVKdUntXYDkJ2dWE7NNJlqD7n?=
 =?us-ascii?Q?LX9uWj2DYpe1Ptrp13A8tPyxuFV717yPlwgE8WNekGXq2QNhYKAUbs2Mivow?=
 =?us-ascii?Q?A16UGeJZpG/kj0Pi8FJB8/fJyU2gSgL0ThTfSjOC0cRKAMhF4WVUdShmv48g?=
 =?us-ascii?Q?6ct4ibKW/qA9ZZesHTTwXUL9V1wW/7s6sDkKYY+8GlCSKKgmgozO64Ii1Ui2?=
 =?us-ascii?Q?pkcT12FOdn/rDuAfbrh9RE1+5+K9tDK8/eZAEjR+w1cSvLieNBU5ZQphJgNi?=
 =?us-ascii?Q?DTPFDCwM312Snw/YcKTVwgO508ZIcV49Z6+OuaG1A5b84Z0HmBuLWa9c/hWS?=
 =?us-ascii?Q?n+DL2OQk4nm1t1Y/VjvXe2BtYc+BNj4Uuwbcjz3cLRzwh51oXdz2BcwvvMmX?=
 =?us-ascii?Q?HtbSJYtc62bSyCxxwuVztn3Def5fCjCuBwlBPchQCdQJhbSeWSb/xJq0KtA9?=
 =?us-ascii?Q?WHZ9GuJDUs2uu6LsiJsKe3q1pPiMctzxXnaP4lor6S4OuMLxRxd3Y3CpAnAa?=
 =?us-ascii?Q?l6rVh7MIIo0TEcKHA3mDY8LKgxcfhMru3S8eJB1vMQwJ6wNHWPA8F8U4Ox/q?=
 =?us-ascii?Q?T/JTRStkJciTay7eVLUy35rpuepCMxyiWLAUrSKMOYcqOqtXgnYaH6WkMHEl?=
 =?us-ascii?Q?3i81zrg42OI2hxd13x/HcnQWJdTB2HkHVYxfi1l+3bbM93NOjGDecnnp4MUU?=
 =?us-ascii?Q?Xn7jQOQjPBohAmuVts8eoc8c6Mat9xaAXDg9hr6SIQxuJ8Waq4gnGnmz+ST4?=
 =?us-ascii?Q?O21PFP9jh1JsF1WS85XC2eZZNbNPYwL5Fl+gQxCLyYvhopbBLH5SeoBGFaFv?=
 =?us-ascii?Q?+Dta5ZGhSE/O2KVmyJ/HxUkBXPKJ+im0ojZ1Id0umXn7Nwh3LaKyEPkDadnd?=
 =?us-ascii?Q?n53YHDrEddH36GHnxPd4OPVmkN2cteERcTfB5HE1w0DCNOfoLZWLncw6NYZ6?=
 =?us-ascii?Q?IVGEqhz0XTAu8Wc+vFH26iQ0tAYy9fJKJaMZsPU4fMoBXyayENR9iNz939N/?=
 =?us-ascii?Q?GKpGMeXxQdHJHopUISKnuZWHkd3ii33bfZE3axKeMGhEVvzssIDMfo7BEqUD?=
 =?us-ascii?Q?1wlzToz99vxUFfKHOcCBhHH/TDJexLA0ySuxoyBe/qfBb1y/4xaB2cBJ7afC?=
 =?us-ascii?Q?9Bx9cHLNwQ9iSvUIUMXZVnbmI4v8QZbvg7dG?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(36860700013)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2025 19:33:30.3745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 68372835-b3ff-41a0-357f-08dd84300f41
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06E.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8827
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

HW modify header commands generated for multiple modify field
flow actions, which modify/access the same packet fields
do not have to be separated by NOPs when used on group 0.
This is because:

- On group > 0, HW uses Modify Header Pattern objects
  which require NOP explicitly.
- On group 0, modify field action is implemented using
  Modify Header Context object managed by FW.
  FW inserts requires NOPs internally.

mlx5 PMD inserted NOP always, which caused flow/table creation
failures on group 0 flow rules.
This patch addresses that.

Fixes: 0f4aa72b99da ("net/mlx5: support flow modify field with HWS")
Cc: suanmingm@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/mlx5_flow_hw.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 20d38ce414..5ae6ac1cfa 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -1422,7 +1422,8 @@ flow_hw_action_modify_field_is_shared(const struct rte_flow_action *action,
 
 static __rte_always_inline bool
 flow_hw_should_insert_nop(const struct mlx5_hw_modify_header_action *mhdr,
-			  const struct mlx5_modification_cmd *cmd)
+			  const struct mlx5_modification_cmd *cmd,
+			  const struct rte_flow_attr *attr)
 {
 	struct mlx5_modification_cmd last_cmd = { { 0 } };
 	struct mlx5_modification_cmd new_cmd = { { 0 } };
@@ -1430,6 +1431,15 @@ flow_hw_should_insert_nop(const struct mlx5_hw_modify_header_action *mhdr,
 	unsigned int last_type;
 	bool should_insert = false;
 
+	/*
+	 * Modify header action list does not require NOPs in root table,
+	 * because different type of underlying object is used:
+	 * - in root table - MODIFY_HEADER_CONTEXT (does not require NOPs),
+	 * - in non-root - either inline modify action or based on Modify Header Pattern
+	 *   (which requires NOPs).
+	 */
+	if (attr->group == 0)
+		return false;
 	if (cmds_num == 0)
 		return false;
 	last_cmd = *(&mhdr->mhdr_cmds[cmds_num - 1]);
@@ -1508,7 +1518,8 @@ flow_hw_mhdr_cmd_append(struct mlx5_hw_modify_header_action *mhdr,
 
 static __rte_always_inline int
 flow_hw_converted_mhdr_cmds_append(struct mlx5_hw_modify_header_action *mhdr,
-				   struct mlx5_flow_dv_modify_hdr_resource *resource)
+				   struct mlx5_flow_dv_modify_hdr_resource *resource,
+				   const struct rte_flow_attr *attr)
 {
 	uint32_t idx;
 	int ret;
@@ -1516,7 +1527,7 @@ flow_hw_converted_mhdr_cmds_append(struct mlx5_hw_modify_header_action *mhdr,
 	for (idx = 0; idx < resource->actions_num; ++idx) {
 		struct mlx5_modification_cmd *src = &resource->actions[idx];
 
-		if (flow_hw_should_insert_nop(mhdr, src)) {
+		if (flow_hw_should_insert_nop(mhdr, src, attr)) {
 			ret = flow_hw_mhdr_cmd_nop_append(mhdr);
 			if (ret)
 				return ret;
@@ -1639,14 +1650,14 @@ flow_hw_modify_field_compile(struct rte_eth_dev *dev,
 	 * This NOP command will not be a part of action's command range used to update commands
 	 * on rule creation.
 	 */
-	if (flow_hw_should_insert_nop(mhdr, &resource->actions[0])) {
+	if (flow_hw_should_insert_nop(mhdr, &resource->actions[0], attr)) {
 		ret = flow_hw_mhdr_cmd_nop_append(mhdr);
 		if (ret)
 			return rte_flow_error_set(error, ret, RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
 						  NULL, "too many modify field operations specified");
 	}
 	cmds_start = mhdr->mhdr_cmds_num;
-	ret = flow_hw_converted_mhdr_cmds_append(mhdr, resource);
+	ret = flow_hw_converted_mhdr_cmds_append(mhdr, resource, attr);
 	if (ret)
 		return rte_flow_error_set(error, ret, RTE_FLOW_ERROR_TYPE_UNSPECIFIED,
 					  NULL, "too many modify field operations specified");
-- 
2.39.5

