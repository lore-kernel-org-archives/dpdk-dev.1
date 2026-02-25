Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9D13FCEE91
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 12:00:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3301F402EE;
	Wed, 25 Feb 2026 13:00:18 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010015.outbound.protection.outlook.com [52.101.46.15])
 by mails.dpdk.org (Postfix) with ESMTP id 43C93402F2
 for <dev@dpdk.org>; Wed, 25 Feb 2026 13:00:16 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=o63njVL2gualIpKlusBsmqIeHrExa3R+g/vVu6LWVA6lDb0r6vPW9T1xzC6zBKBG2oLPJRiRfnk5zY5ou6tNacNaQnpAk05qzpMq7H1v1EZr/g2L0GEIRaTde/WKsLW/hZu4JpmovE8BehlsS82jfNx4x7jiKOcqjMJ6nOzgf14Oiv2VeK0nVwI+kWqMVdjCAZq9/uba+Xqkv1KjDiPb0UazaMdM5U+ydF7JwqYNBMxypkMBJlJWiLwPf6rs0dYeTxO0TnUmhZkCmLAQS8gAnkDCDyswA5rCw6gxXIGRzBDJh4BJYPeZJdUypg3WyjfddCHwKpPfhimm7nlN22WpKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yn0OMyFUnYx9gleYqu6IZ5h5fQYcuKSVTE555iEDf8k=;
 b=NWAAZxA7sBdvGA3jXdZvrszAjY2vaC94DHUaZIIw7UTr2sgA5Bk61Xfx9v0tq9T4mtznBP2ISyJ2oke4CwhDhV6QI6pUOg6mPMnsYJ4w54VF7VN+fEl0kBjLM0IxCHn5dI49kkVeaX4hvvdbWp9m7mUp4l8O1iE3RMRiOpExYo6XpHcMKR0+E2ElSNS071cbK9n3PzYtDaYOhU5PQXhZJMdK++ZjhGUHwKNleLtSS9ddshh0eKbYKQYgdcfef0d9SlgIU4IQbMlsfEFxZmubNaHLNHkYR4y1ZHso6kP2zFL+hBRm3ipg6rCwMvd8Xx07/ei7D5dOW2Tq2iTX4zZK5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yn0OMyFUnYx9gleYqu6IZ5h5fQYcuKSVTE555iEDf8k=;
 b=Wcl3njxMJOlWPdCLQLN2GHspR6kRk/nwY6IgklhJ4cD2BgbGSSdCGQfKN7qvGVwHoUS6ksYn48jy4OsBknlMTa29Z8ZJ+KW5kcdDg0iZAhvnQoWJTYhsu7vz4ayCXpMPVvBzKwu9S0ox0RdavjmF6Mx+IHH2RDtCSeQ016kSCLnVg2nsmWYNAqi/gox4KPAiR+tK8vLQ80/W8xKbbyX2lQNSv0Ck5iFikGh5b00DfxASbcYn1Se1BWgfK5ahQYaxGzwMjpHRoipGrWpNKff38xczZdzYc8rTfvulLCy5bmp8gjI399wNNgRV/+ESU5XaE50qK2DdHKrStZx+Q6Xi8g==
Received: from BLAPR05CA0001.namprd05.prod.outlook.com (2603:10b6:208:36e::6)
 by DS0PR12MB9038.namprd12.prod.outlook.com (2603:10b6:8:f2::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Wed, 25 Feb
 2026 12:00:05 +0000
Received: from BL6PEPF0001AB71.namprd02.prod.outlook.com
 (2603:10b6:208:36e:cafe::8b) by BLAPR05CA0001.outlook.office365.com
 (2603:10b6:208:36e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.23 via Frontend Transport; Wed,
 25 Feb 2026 12:00:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB71.mail.protection.outlook.com (10.167.242.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 12:00:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 03:59:51 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Feb
 2026 03:59:48 -0800
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH 1/9] net/mlx5: use DPDK be64 type in modify header pattern
Date: Wed, 25 Feb 2026 12:59:09 +0100
Message-ID: <20260225115918.233843-2-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260225115918.233843-1-dsosnowski@nvidia.com>
References: <20260225115918.233843-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB71:EE_|DS0PR12MB9038:EE_
X-MS-Office365-Filtering-Correlation-Id: fe650d61-36ea-4001-d66f-08de746569de
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: Nkya7vrN3/ENCXmUggi7+ol0N9vhCYR1L2O6ufw1yOitCIUlFILbDydNZ3ERLL9hjxZI5j7SCnRlTkhtIeiljjBOla94whOIxJA3FbEXk9b2PBR2FxNzl6XFk/cojZpAjHzmDnqJRzsYtSKd1SzxmxjmPg4IjMkHkzlfeHYtDIihQvp38fQDdYD04MDDYLWDymI8FwxlL6ljXyffkjKEudY3Z5NW9UO+GjkeoEBV9QtvYFR+tZRg37g5m3NdJlrgu4pThZvHmVqTWuWC3b2UmlXVtMM+ugr51P/CJ9iflK5JtCRMdeZ8ogFmmxYoyqO0NRgZCqMvPVos57CVJ9oqIDsLDkkyrlBHNzX6K5TvdWoCsmwPmuxZAHytmsryIINEtijriYzLdXyixqUZgp12E15hMgqO3Tsxc5g9gH31rm3PqmaI8UvdRkHWAGfl306XzRoUSd6F7a/WWwqx5eBM8xlsBIsELd2FDNW36uUH34X4EpPbvNezvK/nOo4JJn5oWzv2/VY2CVtAMBJ5voDBrHpBC4/XHXZt2ArFxGU5L90ZXtZ4Q4C/nKcqzTQ6tYR2R9XlGbThbsL8D1+PSeGXPKEw1riwY0qu7TqipQO4eFXP+F503whDF+LevH/69SAk1vuXpkWkaqmzhj9EKG8ils3hetiGKFBfKO26QTJLPyyxMWT2kkKmh9A/1a2fmOe3WvKy810r3IdcVdL4ap52prDTR6dcbrdiqFaWlXf0Rj2qp2WKb0ceNgJ3qGH4xcVY0Kc6g0uv0KLjNC4fkhMAsG8w357UwtO1Crg1xFxzpN2WAzbEQ1oiLsdn2Kb627sc+IAxqEvgMaYjTSVQvKzxsw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: D6q5RYTQdVo4/2y+yEneodCRUYE7otyO9lK5xrQ0QZtP6/Sx7BMCSCwRHEGaZHeSIHvgB+4TeCAlnHeWbT4xCPLP3nChdwtsi7bi51Spdr5vxEaRs/5Pemmh7JRLlhHe987Cgdp/iMOQbN3eh4ipOzNxM0A9GAQMbQjnPHaaJ88g6u5M+1JEzV2LRBZ6tEy/Xc783ahgnZebSQ2ZYva0b50jNB4gnQD0O6wt4rVTUwyCLq6WFMFITd1H4WFgCDNDpAHO7UXGySBFuFU2gwPAb0ivsW2ta1NzD21E0TgimxErit4++6CwAahp2g0RHxWwhKn4yXfU53O/WpMvI4kWFlY+cbzHLXAVT0ywKUIGBcUwIPr5UYxiq6sdAVoyYEQHSjflogAabvUGZ9/e2Vzzh7HEdJcZKh4A0Nu1/Hl3RGiWwnUiBA5zWmp70wvT5HVF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:00:04.7948 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fe650d61-36ea-4001-d66f-08de746569de
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB71.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB9038
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

mlx5dr.h defines mlx5dr_action_mh_pattern struct.
One of its fields is an array of modify field HW actions,
each of 64 bit size and stored as big endian.
Before this patch, this array was defined using __be64
typedef from "linux/types.h" header file.

This necessitated either inclusion of that header file
or, in case of Windows build, addition of typedef directly
whenever mlx5dr.h was included.
Follow up patches which add lazy allocation of global
HWS actions will add additional source files which would include
mlx5dr.h. To prevent additional includes/typedef definitions
required for __be64, this patch changes this definition to use
DPDK's typedef i.e., rte_be64_t.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Ori Kam <orika@nvidia.com>
---
 drivers/net/mlx5/hws/mlx5dr.h         |  3 ++-
 drivers/net/mlx5/hws/mlx5dr_action.c  | 26 +++++++++++++-------------
 drivers/net/mlx5/hws/mlx5dr_pat_arg.c | 20 ++++++++++----------
 drivers/net/mlx5/hws/mlx5dr_pat_arg.h |  8 ++++----
 drivers/net/mlx5/mlx5.h               |  2 --
 drivers/net/mlx5/mlx5_flow_dv.c       |  2 +-
 drivers/net/mlx5/mlx5_flow_hw.c       |  4 ++--
 7 files changed, 32 insertions(+), 33 deletions(-)

diff --git a/drivers/net/mlx5/hws/mlx5dr.h b/drivers/net/mlx5/hws/mlx5dr.h
index c13316305f..d358178e5b 100644
--- a/drivers/net/mlx5/hws/mlx5dr.h
+++ b/drivers/net/mlx5/hws/mlx5dr.h
@@ -5,6 +5,7 @@
 #ifndef MLX5DR_H_
 #define MLX5DR_H_
 
+#include <rte_byteorder.h>
 #include <rte_flow.h>
 
 struct mlx5dr_context;
@@ -248,7 +249,7 @@ struct mlx5dr_action_mh_pattern {
 	/* Byte size of modify actions provided by "data" */
 	size_t sz;
 	/* PRM format modify actions pattern */
-	__be64 *data;
+	rte_be64_t *data;
 };
 
 /* In actions that take offset, the offset is unique, pointing to a single
diff --git a/drivers/net/mlx5/hws/mlx5dr_action.c b/drivers/net/mlx5/hws/mlx5dr_action.c
index b35bf07c3c..439592c5e4 100644
--- a/drivers/net/mlx5/hws/mlx5dr_action.c
+++ b/drivers/net/mlx5/hws/mlx5dr_action.c
@@ -369,7 +369,7 @@ mlx5dr_action_create_nat64_copy_state(struct mlx5dr_context *ctx,
 				      struct mlx5dr_action_nat64_attr *attr,
 				      uint32_t flags)
 {
-	__be64 modify_action_data[MLX5DR_ACTION_NAT64_MAX_MODIFY_ACTIONS];
+	rte_be64_t modify_action_data[MLX5DR_ACTION_NAT64_MAX_MODIFY_ACTIONS];
 	struct mlx5dr_action_mh_pattern pat[2];
 	struct mlx5dr_action *action;
 	uint32_t packet_len_field;
@@ -484,7 +484,7 @@ mlx5dr_action_create_nat64_repalce_state(struct mlx5dr_context *ctx,
 					 uint32_t flags)
 {
 	uint32_t address_prefix[MLX5DR_ACTION_NAT64_HEADER_MINUS_ONE] = {0};
-	__be64 modify_action_data[MLX5DR_ACTION_NAT64_MAX_MODIFY_ACTIONS];
+	rte_be64_t modify_action_data[MLX5DR_ACTION_NAT64_MAX_MODIFY_ACTIONS];
 	struct mlx5dr_action_mh_pattern pat[2];
 	static struct mlx5dr_action *action;
 	uint8_t header_size_in_dw;
@@ -575,7 +575,7 @@ mlx5dr_action_create_nat64_copy_proto_state(struct mlx5dr_context *ctx,
 					    struct mlx5dr_action_nat64_attr *attr,
 					    uint32_t flags)
 {
-	__be64 modify_action_data[MLX5DR_ACTION_NAT64_MAX_MODIFY_ACTIONS];
+	rte_be64_t modify_action_data[MLX5DR_ACTION_NAT64_MAX_MODIFY_ACTIONS];
 	struct mlx5dr_action_mh_pattern pat[2];
 	struct mlx5dr_action *action;
 	uint8_t *action_ptr;
@@ -615,7 +615,7 @@ mlx5dr_action_create_nat64_copy_back_state(struct mlx5dr_context *ctx,
 					   struct mlx5dr_action_nat64_attr *attr,
 					   uint32_t flags)
 {
-	__be64 modify_action_data[MLX5DR_ACTION_NAT64_MAX_MODIFY_ACTIONS];
+	rte_be64_t modify_action_data[MLX5DR_ACTION_NAT64_MAX_MODIFY_ACTIONS];
 	struct mlx5dr_action_mh_pattern pat[2];
 	struct mlx5dr_action *action;
 	uint32_t packet_len_field;
@@ -2165,7 +2165,7 @@ mlx5dr_action_handle_tunnel_l3_to_l2(struct mlx5dr_action *action,
 
 	/* All DecapL3 cases require the same max arg size */
 	arg_obj = mlx5dr_arg_create_modify_header_arg(ctx,
-						      (__be64 *)mh_data,
+						      (rte_be64_t *)mh_data,
 						      num_of_actions,
 						      log_bulk_sz,
 						      action->flags & MLX5DR_ACTION_FLAG_SHARED);
@@ -2177,7 +2177,7 @@ mlx5dr_action_handle_tunnel_l3_to_l2(struct mlx5dr_action *action,
 		mlx5dr_action_prepare_decap_l3_actions(hdrs[i].sz, mh_data, &num_of_actions);
 		mh_data_size = num_of_actions * MLX5DR_MODIFY_ACTION_SIZE;
 
-		pat_obj = mlx5dr_pat_get_pattern(ctx, (__be64 *)mh_data, mh_data_size);
+		pat_obj = mlx5dr_pat_get_pattern(ctx, (rte_be64_t *)mh_data, mh_data_size);
 		if (!pat_obj) {
 			DR_LOG(ERR, "Failed to allocate pattern for DecapL3");
 			goto free_stc_and_pat;
@@ -2189,7 +2189,7 @@ mlx5dr_action_handle_tunnel_l3_to_l2(struct mlx5dr_action *action,
 		action[i].modify_header.arg_obj = arg_obj;
 		action[i].modify_header.pat_obj = pat_obj;
 		action[i].modify_header.require_reparse =
-			mlx5dr_pat_require_reparse((__be64 *)mh_data, num_of_actions);
+			mlx5dr_pat_require_reparse((rte_be64_t *)mh_data, num_of_actions);
 
 		ret = mlx5dr_action_create_stcs(&action[i], NULL);
 		if (ret) {
@@ -2304,7 +2304,7 @@ mlx5dr_action_create_reformat(struct mlx5dr_context *ctx,
 static int
 mlx5dr_action_create_modify_header_root(struct mlx5dr_action *action,
 					size_t actions_sz,
-					__be64 *actions)
+					rte_be64_t *actions)
 {
 	enum mlx5dv_flow_table_type ft_type = 0;
 	struct ibv_context *local_ibv_ctx;
@@ -2897,7 +2897,7 @@ static void *
 mlx5dr_action_create_pop_ipv6_route_ext_mhdr1(struct mlx5dr_action *action)
 {
 	struct mlx5dr_action_mh_pattern pattern;
-	__be64 cmd[3] = {0};
+	rte_be64_t cmd[3] = {0};
 	uint16_t mod_id;
 
 	mod_id = flow_hw_get_ipv6_route_ext_mod_id_from_ctx(action->ctx, 0);
@@ -2943,7 +2943,7 @@ mlx5dr_action_create_pop_ipv6_route_ext_mhdr2(struct mlx5dr_action *action)
 		MLX5_MODI_OUT_DIPV6_31_0
 	};
 	struct mlx5dr_action_mh_pattern pattern;
-	__be64 cmd[5] = {0};
+	rte_be64_t cmd[5] = {0};
 	uint16_t mod_id;
 	uint32_t i;
 
@@ -3001,7 +3001,7 @@ mlx5dr_action_create_pop_ipv6_route_ext_mhdr3(struct mlx5dr_action *action)
 	MLX5_SET(copy_action_in, cmd, src_field, mod_id);
 	MLX5_SET(copy_action_in, cmd, dst_field, MLX5_MODI_OUT_IP_PROTOCOL);
 
-	pattern.data = (__be64 *)cmd;
+	pattern.data = (rte_be64_t *)cmd;
 	pattern.sz = sizeof(cmd);
 
 	return mlx5dr_action_create_modify_header_reparse(action->ctx, 1, &pattern, 0,
@@ -3063,7 +3063,7 @@ mlx5dr_action_create_push_ipv6_route_ext_mhdr1(struct mlx5dr_action *action)
 	MLX5_SET(set_action_in, cmd, field, MLX5_MODI_OUT_IP_PROTOCOL);
 	MLX5_SET(set_action_in, cmd, data, IPPROTO_ROUTING);
 
-	pattern.data = (__be64 *)cmd;
+	pattern.data = (rte_be64_t *)cmd;
 	pattern.sz = sizeof(cmd);
 
 	return mlx5dr_action_create_modify_header(action->ctx, 1, &pattern, 0,
@@ -3084,7 +3084,7 @@ mlx5dr_action_create_push_ipv6_route_ext_mhdr2(struct mlx5dr_action *action,
 	struct mlx5dr_action_mh_pattern pattern;
 	uint32_t *ipv6_dst_addr = NULL;
 	uint8_t seg_left, next_hdr;
-	__be64 cmd[5] = {0};
+	rte_be64_t cmd[5] = {0};
 	uint16_t mod_id;
 	uint32_t i;
 
diff --git a/drivers/net/mlx5/hws/mlx5dr_pat_arg.c b/drivers/net/mlx5/hws/mlx5dr_pat_arg.c
index 513549ff3c..dfed5eb47a 100644
--- a/drivers/net/mlx5/hws/mlx5dr_pat_arg.c
+++ b/drivers/net/mlx5/hws/mlx5dr_pat_arg.c
@@ -37,7 +37,7 @@ uint32_t mlx5dr_arg_get_arg_size(uint16_t num_of_actions)
 	return BIT(mlx5dr_arg_get_arg_log_size(num_of_actions));
 }
 
-bool mlx5dr_pat_require_reparse(__be64 *actions, uint16_t num_of_actions)
+bool mlx5dr_pat_require_reparse(rte_be64_t *actions, uint16_t num_of_actions)
 {
 	uint16_t i, field;
 	uint8_t action_id;
@@ -98,9 +98,9 @@ void mlx5dr_pat_uninit_pattern_cache(struct mlx5dr_pattern_cache *cache)
 }
 
 static bool mlx5dr_pat_compare_pattern(int cur_num_of_actions,
-				       __be64 cur_actions[],
+				       rte_be64_t cur_actions[],
 				       int num_of_actions,
-				       __be64 actions[])
+				       rte_be64_t actions[])
 {
 	int i;
 
@@ -129,13 +129,13 @@ static bool mlx5dr_pat_compare_pattern(int cur_num_of_actions,
 static struct mlx5dr_pattern_cache_item *
 mlx5dr_pat_find_cached_pattern(struct mlx5dr_pattern_cache *cache,
 			       uint16_t num_of_actions,
-			       __be64 *actions)
+			       rte_be64_t *actions)
 {
 	struct mlx5dr_pattern_cache_item *cached_pat;
 
 	LIST_FOREACH(cached_pat, &cache->head, next) {
 		if (mlx5dr_pat_compare_pattern(cached_pat->mh_data.num_of_actions,
-					       (__be64 *)cached_pat->mh_data.data,
+					       (rte_be64_t *)cached_pat->mh_data.data,
 					       num_of_actions,
 					       actions))
 			return cached_pat;
@@ -147,7 +147,7 @@ mlx5dr_pat_find_cached_pattern(struct mlx5dr_pattern_cache *cache,
 static struct mlx5dr_pattern_cache_item *
 mlx5dr_pat_get_existing_cached_pattern(struct mlx5dr_pattern_cache *cache,
 				       uint16_t num_of_actions,
-				       __be64 *actions)
+				       rte_be64_t *actions)
 {
 	struct mlx5dr_pattern_cache_item *cached_pattern;
 
@@ -166,7 +166,7 @@ static struct mlx5dr_pattern_cache_item *
 mlx5dr_pat_add_pattern_to_cache(struct mlx5dr_pattern_cache *cache,
 				struct mlx5dr_devx_obj *pattern_obj,
 				uint16_t num_of_actions,
-				__be64 *actions)
+				rte_be64_t *actions)
 {
 	struct mlx5dr_pattern_cache_item *cached_pattern;
 
@@ -248,7 +248,7 @@ void mlx5dr_pat_put_pattern(struct mlx5dr_context *ctx,
 
 struct mlx5dr_devx_obj *
 mlx5dr_pat_get_pattern(struct mlx5dr_context *ctx,
-		       __be64 *pattern, size_t pattern_sz)
+		       rte_be64_t *pattern, size_t pattern_sz)
 {
 	uint16_t num_of_actions = pattern_sz / MLX5DR_MODIFY_ACTION_SIZE;
 	struct mlx5dr_pattern_cache_item *cached_pattern;
@@ -458,7 +458,7 @@ mlx5dr_arg_create(struct mlx5dr_context *ctx,
 
 struct mlx5dr_devx_obj *
 mlx5dr_arg_create_modify_header_arg(struct mlx5dr_context *ctx,
-				    __be64 *data,
+				    rte_be64_t *data,
 				    uint8_t num_of_actions,
 				    uint32_t log_bulk_sz,
 				    bool write_data)
@@ -477,7 +477,7 @@ mlx5dr_arg_create_modify_header_arg(struct mlx5dr_context *ctx,
 	return arg_obj;
 }
 
-bool mlx5dr_pat_verify_actions(__be64 pattern[], size_t sz)
+bool mlx5dr_pat_verify_actions(rte_be64_t pattern[], size_t sz)
 {
 	size_t i;
 
diff --git a/drivers/net/mlx5/hws/mlx5dr_pat_arg.h b/drivers/net/mlx5/hws/mlx5dr_pat_arg.h
index c4e0cbc843..3418469962 100644
--- a/drivers/net/mlx5/hws/mlx5dr_pat_arg.h
+++ b/drivers/net/mlx5/hws/mlx5dr_pat_arg.h
@@ -51,7 +51,7 @@ int mlx5dr_pat_init_pattern_cache(struct mlx5dr_pattern_cache **cache);
 
 void mlx5dr_pat_uninit_pattern_cache(struct mlx5dr_pattern_cache *cache);
 
-bool mlx5dr_pat_verify_actions(__be64 pattern[], size_t sz);
+bool mlx5dr_pat_verify_actions(rte_be64_t pattern[], size_t sz);
 
 struct mlx5dr_devx_obj *
 mlx5dr_arg_create(struct mlx5dr_context *ctx,
@@ -62,14 +62,14 @@ mlx5dr_arg_create(struct mlx5dr_context *ctx,
 
 struct mlx5dr_devx_obj *
 mlx5dr_arg_create_modify_header_arg(struct mlx5dr_context *ctx,
-				    __be64 *data,
+				    rte_be64_t *data,
 				    uint8_t num_of_actions,
 				    uint32_t log_bulk_sz,
 				    bool write_data);
 
 struct mlx5dr_devx_obj *
 mlx5dr_pat_get_pattern(struct mlx5dr_context *ctx,
-		       __be64 *pattern,
+		       rte_be64_t *pattern,
 		       size_t pattern_sz);
 
 void mlx5dr_pat_put_pattern(struct mlx5dr_context *ctx,
@@ -78,7 +78,7 @@ void mlx5dr_pat_put_pattern(struct mlx5dr_context *ctx,
 bool mlx5dr_arg_is_valid_arg_request_size(struct mlx5dr_context *ctx,
 					  uint32_t arg_size);
 
-bool mlx5dr_pat_require_reparse(__be64 *actions, uint16_t num_of_actions);
+bool mlx5dr_pat_require_reparse(rte_be64_t *actions, uint16_t num_of_actions);
 
 void mlx5dr_arg_write(struct mlx5dr_send_engine *queue,
 		      void *comp_data,
diff --git a/drivers/net/mlx5/mlx5.h b/drivers/net/mlx5/mlx5.h
index b83dda5652..e9d855e345 100644
--- a/drivers/net/mlx5/mlx5.h
+++ b/drivers/net/mlx5/mlx5.h
@@ -37,8 +37,6 @@
 #if defined(HAVE_IBV_FLOW_DV_SUPPORT) || !defined(HAVE_INFINIBAND_VERBS_H)
 #ifndef RTE_EXEC_ENV_WINDOWS
 #define HAVE_MLX5_HWS_SUPPORT 1
-#else
-#define __be64 uint64_t
 #endif
 #include "hws/mlx5dr.h"
 #endif
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 99ab0125a8..d1bed18077 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -6294,7 +6294,7 @@ mlx5_flow_modify_create_cb(void *tool_ctx, void *cb_ctx)
 #ifdef HAVE_MLX5_HWS_SUPPORT
 		struct mlx5dr_action_mh_pattern pattern = {
 			.sz = data_len,
-			.data = (__be64 *)ref->actions
+			.data = (rte_be64_t *)ref->actions
 		};
 		entry->action = mlx5dr_action_create_modify_header(ctx->data2,
 			1,
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 6ac6825c16..b29909f99d 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -2436,7 +2436,7 @@ mlx5_tbl_translate_modify_header(struct rte_eth_dev *dev,
 					  NULL, "translate modify_header: no memory for modify header context");
 	rte_memcpy(acts->mhdr, mhdr, sizeof(*mhdr));
 	if (!mhdr->shared) {
-		pattern.data = (__be64 *)acts->mhdr->mhdr_cmds;
+		pattern.data = (rte_be64_t *)acts->mhdr->mhdr_cmds;
 		typeof(mp_ctx->mh) *mh = &mp_ctx->mh;
 		uint32_t idx = mh->elements_num;
 		mh->pattern[mh->elements_num++] = pattern;
@@ -2470,7 +2470,7 @@ mlx5_tbl_ensure_shared_modify_header(struct rte_eth_dev *dev,
 	uint16_t mhdr_ix = acts->mhdr->pos;
 	uint32_t flags = mlx5_hw_act_flag[!!attr->group][tbl_type] | MLX5DR_ACTION_FLAG_SHARED;
 
-	pattern.data = (__be64 *)acts->mhdr->mhdr_cmds;
+	pattern.data = (rte_be64_t *)acts->mhdr->mhdr_cmds;
 	acts->mhdr->action = mlx5dr_action_create_modify_header(priv->dr_ctx, 1,
 								&pattern, 0, flags);
 	if (!acts->mhdr->action)
-- 
2.47.3

