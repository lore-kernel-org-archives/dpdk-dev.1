Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477F9C021AD
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 07:09:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8CB48402CE;
	Thu, 20 Feb 2025 08:09:35 +0100 (CET)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2054.outbound.protection.outlook.com [40.107.244.54])
 by mails.dpdk.org (Postfix) with ESMTP id 0F9CE402D1;
 Thu, 20 Feb 2025 08:09:33 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yhioh31zAjfyUqj1oClqPXIu5jeEVCjEzQuWyWSixDAXRccEzywdRpOdyLehGz1040eqt6Lzki3t7Yn1CXzc4sMqyDnF5TofJYxz7hOgbF3e7eLDRksX3cYlLj03b162vgdFNSKm2jLOMtpvNiiS+uisZg/iFW3k0cJ+6WOiihY+lc31NR9bTLK2SeFN1Ys/sY67NRsxrnLOe2pVAtqP5mqF0t3Fv5pHP78KqGjLKCvHs5jdnXDSrUajOffghhoDgXp1f6PlRz1txjlNb/KPqSbWSHTmBevdv9M0qoCn6bVFTFWOq0V8CxcTzc8KcUKBBBZrF8QZNhLuR94Xus7RQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JvLclufw/TiCRQ+sKVPjEIuZiraRs0Q6Z7P4ZUjQLn4=;
 b=Av8Deu2MivWfI2zmzhgovY+xPG504536UQ1Uv7hjwzGjc/bZXq6hpxTvGjWYcBHrimYmvDcefzhPHtKSGTG2l5+qC92cqXjWLKqBtB0HA5dbz2j5BGKZGV9WuC/79H4qUROaLfcdb10MWKP5bfgI5BgQhGb3662BtRKC8yPoTOHuEL61R2gnZLZsEXePZddpOnWMj5WPRBHiu2xVss6zSzHNgnuFOSTLXcYR4XzAJY5b2LqiWMD8EdqoRy83zknvXjKMTI6O79JvjrTQQ/dhiVRnmvsjddQ1tIJBlRP8xfGRg32JS7Jwxiohv1nzgD/2UP+al9bXDpqvVK4nsrt0aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JvLclufw/TiCRQ+sKVPjEIuZiraRs0Q6Z7P4ZUjQLn4=;
 b=nYMuPUJQrtoLi9ckUm5itUKRBHp9N4+Jt/kx/num4REYEg5HXBPeQw/hdS5P+phaMX6UZWvBSwl5LS2IwATbecDY5pvz1DYxE6bQFUSFpaAT0v/dRhVGQzgucqsxnNwEIhtYdlU45AT3vFAzLlltBZZzoDWKP1Ky/9X8HpZ9+dfuEAYh54laVaNrSK8z+XujuAi0+UGg+sIYWFZ6wtQOFOfGLjy5+tKVcTicQPnh6nGbgkOAA0GAWqXphLn/+9lTUDdO+dks+7XFA92F3LgdQvSGsfBMcOW/wgy7/AmisUr0gn8oHgvHC/NjsoeqAQTp+rABissGW6IaSvc9ADzuZw==
Received: from MW2PR2101CA0034.namprd21.prod.outlook.com (2603:10b6:302:1::47)
 by SJ2PR12MB7798.namprd12.prod.outlook.com (2603:10b6:a03:4c0::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8445.19; Thu, 20 Feb
 2025 07:09:24 +0000
Received: from MWH0EPF000A6730.namprd04.prod.outlook.com
 (2603:10b6:302:1:cafe::e0) by MW2PR2101CA0034.outlook.office365.com
 (2603:10b6:302:1::47) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8489.10 via Frontend Transport; Thu,
 20 Feb 2025 07:09:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000A6730.mail.protection.outlook.com (10.167.249.22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025 07:09:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 19 Feb
 2025 23:09:09 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 19 Feb
 2025 23:09:06 -0800
From: Junfeng Guo <junfengg@nvidia.com>
To: <dev@dpdk.org>
CC: <dsosnowski@nvidia.com>, <viacheslavo@nvidia.com>, <bingz@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>,
 <gavinl@nvidia.com>, <jiaweiw@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix err message overwrite for actions translation
Date: Thu, 20 Feb 2025 09:08:50 +0200
Message-ID: <20250220070850.6661-1-junfengg@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A6730:EE_|SJ2PR12MB7798:EE_
X-MS-Office365-Filtering-Correlation-Id: 34e21e5b-f590-40d2-5fb6-08dd517d819c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?utf-8?B?ZzJndmY1QjR3aWRMWWZ5V0ZoTE81VUtyeGFlZDJGNTlPU3pTM3ZGbkFraTdQ?=
 =?utf-8?B?OWZZU3owQkx4bTZLR0lVQ3I4YWxZYXV1S3VMV1BWWXZpa0F6YmJERGF5K05T?=
 =?utf-8?B?cG82bjhpRWRoU1QvdkFYdlVzWFkwRjY5OGNiTDFFZ0R3S3B0d2kvRmhXUndF?=
 =?utf-8?B?aUZQVHJKTEc2dk1venhsV1g3aUx4NFQwQUltMkgvODYya1Q0OGV2dWFINzA3?=
 =?utf-8?B?ZS93eXNVSndiVStFZ2hzcGJ5UFRGR3NucE8xRFl3OTVVamhURVU5TzBIM1FV?=
 =?utf-8?B?bU1NSDBpTUtMaHZMaWdLYW1aaG1tK1FGck13YmNKSUlhUXhPQkdSd0pnSnNG?=
 =?utf-8?B?ZU1aK24vK1ZxNVg1bm1ZeHRodkNCRzhraWl6NFdwdUplWjZxa3BEVGJ2WVZM?=
 =?utf-8?B?OHRwNUhBNXVwMElPZHBsVml0ek1aYk5GMjJ2RGJUaDhweXkwbU5SV3d1UjF1?=
 =?utf-8?B?eXVNVzhxWmxUcHlGSGpKNUswYXY2dHpqRHA1MXZNZWxuQnl3djA3L3p3V1Rq?=
 =?utf-8?B?d3Avd09VeVduRk1Mb0NDSmdNZmV3bG8xN0tHbTRYOHNMU1NMbnRwU3h1Zkda?=
 =?utf-8?B?c3RDbVBUbzc1TUQ0VVZ5NHkrbFpJaHZsY2JhTHRJTkl2bkNiUlVvVTBZb2xq?=
 =?utf-8?B?amdFNGdGZmZkVXFmU3FJeHVQbHB4eGZqMXJ6dkJBQ0RLRUxsZE4yaUpjUEZr?=
 =?utf-8?B?WkJuRFdua2xMbk1LaFVJM3ZuSVZBZWFSdXNGTlJud05wYlYzTkViNHM2a3dj?=
 =?utf-8?B?K2d2UW5WMFc2TW1UaGx5ZzdUOFdHSTJmN1Q2MUNJMEU0MDN1Rm1XbjhmS1dL?=
 =?utf-8?B?YnFzMlRtcWZnT1RCMjJEbW9kL3lUVzVMVmNrMlZLeEtDWlRjNFpRd1NCM1Qy?=
 =?utf-8?B?NjFsUlRUNlhMYy9tdnJSQmh2eExjNnFvM014K2paRERBc3dXM3VEQVVMVy9t?=
 =?utf-8?B?dzBMdDcxZmx1QkV3NXRtNDIyckhLcENwcVlPek83ekFvRE8rb1lsVEJ5bVhL?=
 =?utf-8?B?bGliOExLSWVEemtEblFvbWlsVk5LNUtzaC9BbXorRVRsZE1IQmwxOEhDSTVM?=
 =?utf-8?B?M2t1RE11WWhXM0pEODc3ZWVmaEIyMzFHdUpqSlU2MzJoOVl3amc3MTk0SWFn?=
 =?utf-8?B?d1RhY01tcHE2NElxa0htVXlRY1AzTWx0RmJKbDNwNHVsUGRxZXZvS3dYdjB2?=
 =?utf-8?B?RG5GZ2pnZlQ5eWFMSXl2VGdmbHVpSjNDcEtKWVE4QlRFR1N3eHZTNm1obWV4?=
 =?utf-8?B?THY2UHpqN2ZnTm1yMWlQcDlnR280cWQ3cmpZanpaWVIrYlltcEpXT0Evdit2?=
 =?utf-8?B?cFRES0NCSVpKd0dHRnBPczRaTGVvRTdRb29CYkg0cWFCeHA3MmN5alZIRVM4?=
 =?utf-8?B?NVBEK2VyU2RpQ2lwMGt4Y1pOVHhrM1FPOGFxRnhuQ2R2eEhpUzlTWE1CTExB?=
 =?utf-8?B?UFNEVVJrZmVtTmtBTDlmaG85eENjY2ZnUTZXbHByWGovM3hhVXpCNzc4cEh2?=
 =?utf-8?B?TGpNd2ZKS3FDOVoyN1pyVjJ0TGtLbkMrekd1UHZVL2JXRHZSSTBBN1FRMlo3?=
 =?utf-8?B?VE4wdlNtR3RZY21Na3hGc3UrbzR0SjEvdnBOVHRjRHQra3NSaVYwa2t5OEo1?=
 =?utf-8?B?RmdLdks2YksrR1FKR3hSQjRQcXczTnlOcWhQU1B4R3N4OWRvcnZMYkpJL0Nv?=
 =?utf-8?B?cTB5aDkvYlZJd1ozcjJsZ0tjelJrWGJyNFV3VWp1Z3JGY01RMWgvMWJnT1dU?=
 =?utf-8?B?Sis1RjZTSjJIYkQxWU9qYzhHR25DWUFJRGloTzVOMXhLUlBhYmk5SHpvU01N?=
 =?utf-8?B?S2taVjVvbTROblJ1OEx1emhzRzl6bHlDR1VnNG1pUXB2M1BjV2FZa0JnTVpk?=
 =?utf-8?B?UVF1RThRNEx4S25XbjJXVGZpN2h4a3FNM1BMSC9yTjJQWVpzRVJoWFFrdDdX?=
 =?utf-8?B?WFZ5SkxBejZqczhaSENrWTFac3d1alEra2EwcFBXV3hSMTdvbjI5ZEszSmJZ?=
 =?utf-8?Q?lqjWLh3qxCFbaS1Yb6yTop+98OZIGU=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 07:09:24.2342 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34e21e5b-f590-40d2-5fb6-08dd517d819c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A6730.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB7798
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

Function __flow_hw_translate_actions_template contains several
encapsulated functions that already have internal error handling
process via rte_flow_error_set for each case.

Thus the one (rte_flow_error_set) within the goto statement `err`
at the end of __flow_hw_translate_actions_template function may be
redundant for those failed cases. As a result, the error messages
would all be overwritten as "fail to create rte table", making it
displayed at quite large granularity.

To prevent above error messages overwrite, this patch add a local
variable `struct rte_flow_error sub_error` to the function and pass
this `sub_error` instead of `error` to each sub-function. Under error
handling process (`err` label), if `sub_error` was updated, copy its
contents to `error` and return. If it was not updated, return default
error message (`fail to create rte table`).

Also refactor the logic for SEND_TO_KERNEL, COUNT and AGE actions in
above function to align the error handling process.

Fixes: f13fab23922b ("net/mlx5: add flow jump action")
Cc: suanmingm@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Junfeng Guo <junfengg@nvidia.com>
---
 .mailmap                        |  2 +-
 drivers/net/mlx5/mlx5_flow_hw.c | 65 ++++++++++++++++++++-------------
 2 files changed, 40 insertions(+), 27 deletions(-)

diff --git a/.mailmap b/.mailmap
index a03d3cfb59..9f053334dc 100644
--- a/.mailmap
+++ b/.mailmap
@@ -760,7 +760,7 @@ Julien Hascoet <ju.hascoet@gmail.com>
 Julien Massonneau <julien.massonneau@6wind.com>
 Julien Meunier <julien.meunier@nokia.com> <julien.meunier@6wind.com>
 Július Milan <jmilan.dev@gmail.com>
-Junfeng Guo <junfeng.guo@intel.com>
+Junfeng Guo <junfengg@nvidia.com> <junfeng.guo@intel.com>
 Junjie Chen <junjie.j.chen@intel.com>
 Junjie Wan <wanjunjie@bytedance.com>
 Junlong Wang <wang.junlong1@zte.com.cn>
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index 501bf33f94..e72b87d70f 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -2543,6 +2543,11 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 	uint8_t *push_data = NULL, *push_data_m = NULL;
 	size_t data_size = 0, push_size = 0;
 	struct mlx5_hw_modify_header_action mhdr = { 0 };
+	struct rte_flow_error sub_error = {
+		.type = RTE_FLOW_ERROR_TYPE_NONE,
+		.cause = NULL,
+		.message = NULL,
+	};
 	bool actions_end = false;
 	uint32_t type;
 	bool reformat_used = false;
@@ -2662,7 +2667,7 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 					((const struct rte_flow_action_jump *)
 					actions->conf)->group;
 				acts->jump = flow_hw_jump_action_register
-						(dev, cfg, jump_group, error);
+						(dev, cfg, jump_group, &sub_error);
 				if (!acts->jump)
 					goto err;
 				acts->rule_acts[dr_pos].action = (!!attr->group) ?
@@ -2793,15 +2798,16 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 			break;
 		case RTE_FLOW_ACTION_TYPE_SEND_TO_KERNEL:
 			ret = flow_hw_translate_group(dev, cfg, attr->group,
-						&target_grp, error);
+						&target_grp, &sub_error);
 			if (ret)
-				return ret;
+				goto err;
 			if (target_grp == 0) {
 				__flow_hw_action_template_destroy(dev, acts);
-				return rte_flow_error_set(error, ENOTSUP,
-						RTE_FLOW_ERROR_TYPE_ACTION,
-						NULL,
-						"Send to kernel action on root table is not supported in HW steering mode");
+				rte_flow_error_set(&sub_error, ENOTSUP,
+					RTE_FLOW_ERROR_TYPE_ACTION,
+					NULL,
+					"Send to kernel action on root table is not supported in HW steering mode");
+				goto err;
 			}
 			table_type = attr->ingress ? MLX5DR_TABLE_TYPE_NIC_RX :
 				     ((attr->egress) ? MLX5DR_TABLE_TYPE_NIC_TX :
@@ -2811,14 +2817,14 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 		case RTE_FLOW_ACTION_TYPE_MODIFY_FIELD:
 			err = flow_hw_modify_field_compile(dev, attr, actions,
 							   masks, acts, &mhdr,
-							   src_pos, error);
+							   src_pos, &sub_error);
 			if (err)
 				goto err;
 			break;
 		case RTE_FLOW_ACTION_TYPE_REPRESENTED_PORT:
 			if (flow_hw_represented_port_compile
 					(dev, attr, actions,
-					 masks, acts, src_pos, dr_pos, error))
+					 masks, acts, src_pos, dr_pos, &sub_error))
 				goto err;
 			break;
 		case RTE_FLOW_ACTION_TYPE_METER:
@@ -2832,7 +2838,8 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 			    ((const struct rte_flow_action_meter *)
 			     masks->conf)->mtr_id) {
 				err = flow_hw_meter_compile(dev, cfg,
-							    dr_pos, jump_pos, actions, acts, error);
+							    dr_pos, jump_pos, actions, acts,
+							    &sub_error);
 				if (err)
 					goto err;
 			} else if (__flow_hw_act_data_general_append(priv, acts,
@@ -2843,15 +2850,16 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 			break;
 		case RTE_FLOW_ACTION_TYPE_AGE:
 			ret = flow_hw_translate_group(dev, cfg, attr->group,
-						&target_grp, error);
+						&target_grp, &sub_error);
 			if (ret)
-				return ret;
+				goto err;
 			if (target_grp == 0) {
 				__flow_hw_action_template_destroy(dev, acts);
-				return rte_flow_error_set(error, ENOTSUP,
-						RTE_FLOW_ERROR_TYPE_ACTION,
-						NULL,
-						"Age action on root table is not supported in HW steering mode");
+				rte_flow_error_set(&sub_error, ENOTSUP,
+					RTE_FLOW_ERROR_TYPE_ACTION,
+					NULL,
+					"Age action on root table is not supported in HW steering mode");
+				goto err;
 			}
 			if (__flow_hw_act_data_general_append(priv, acts,
 							      actions->type,
@@ -2861,15 +2869,16 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 			break;
 		case RTE_FLOW_ACTION_TYPE_COUNT:
 			ret = flow_hw_translate_group(dev, cfg, attr->group,
-						&target_grp, error);
+						&target_grp, &sub_error);
 			if (ret)
-				return ret;
+				goto err;
 			if (target_grp == 0) {
 				__flow_hw_action_template_destroy(dev, acts);
-				return rte_flow_error_set(error, ENOTSUP,
-						RTE_FLOW_ERROR_TYPE_ACTION,
-						NULL,
-						"Counter action on root table is not supported in HW steering mode");
+				rte_flow_error_set(&sub_error, ENOTSUP,
+					RTE_FLOW_ERROR_TYPE_ACTION,
+					NULL,
+					"Counter action on root table is not supported in HW steering mode");
+				goto err;
 			}
 			if ((at->action_flags & MLX5_FLOW_ACTION_AGE) ||
 			    (at->action_flags & MLX5_FLOW_ACTION_INDIRECT_AGE))
@@ -2912,7 +2921,7 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 								 acts->rule_acts,
 								 &acts->mtr_id,
 								 MLX5_HW_INV_QUEUE,
-								 error);
+								 &sub_error);
 				if (err)
 					goto err;
 			} else if (__flow_hw_act_data_general_append(priv, acts,
@@ -2979,11 +2988,11 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 		}
 	}
 	if (mhdr.pos != UINT16_MAX) {
-		ret = mlx5_tbl_translate_modify_header(dev, cfg, acts, mp_ctx, &mhdr, error);
+		ret = mlx5_tbl_translate_modify_header(dev, cfg, acts, mp_ctx, &mhdr, &sub_error);
 		if (ret)
 			goto err;
 		if (!nt_mode && mhdr.shared) {
-			ret = mlx5_tbl_ensure_shared_modify_header(dev, cfg, acts, error);
+			ret = mlx5_tbl_ensure_shared_modify_header(dev, cfg, acts, &sub_error);
 			if (ret)
 				goto err;
 		}
@@ -2994,7 +3003,7 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 						  encap_data, encap_data_m,
 						  mp_ctx, data_size,
 						  reformat_src,
-						  refmt_type, error);
+						  refmt_type, &sub_error);
 		if (ret)
 			goto err;
 		if (!nt_mode && acts->encap_decap->shared) {
@@ -3020,6 +3029,10 @@ __flow_hw_translate_actions_template(struct rte_eth_dev *dev,
 		rte_errno = EINVAL;
 	err = rte_errno;
 	__flow_hw_action_template_destroy(dev, acts);
+	if (error != NULL && sub_error.type != RTE_FLOW_ERROR_TYPE_NONE) {
+		rte_memcpy(error, &sub_error, sizeof(sub_error));
+		return -EINVAL;
+	}
 	return rte_flow_error_set(error, err,
 				  RTE_FLOW_ERROR_TYPE_UNSPECIFIED, NULL,
 				  "fail to create rte table");
-- 
2.34.1

