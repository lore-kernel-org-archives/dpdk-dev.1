Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A12FEE81BC2
	for <dpdk-dev@archiver.kernel.org>; Mon,  9 Feb 2026 13:56:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EA5D340652;
	Mon,  9 Feb 2026 14:56:58 +0100 (CET)
Received: from CH5PR02CU005.outbound.protection.outlook.com
 (mail-northcentralusazon11012031.outbound.protection.outlook.com
 [40.107.200.31]) by mails.dpdk.org (Postfix) with ESMTP id 7A9B0402B0
 for <dev@dpdk.org>; Mon,  9 Feb 2026 14:56:57 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oV1+IfLqhc1Atr+tNBst0142M+ud9zkjHzM/7IGXSXQkRTbUIp1DmbjbzxNrKoDqOAt+OfVdcWWF+5TtMQhRtvBDc37MpbfBzYRCVwTXU6f5V2GmX6i2gnr8XnjLP9VtPk1ZTJclqEBB2d0hSBOWN9f/oBodh6HCq3TjEWShYQs4ehyz0TkEjq/nn3MZXCoJP4G10eOOakhYbcA0Wo0LtMbvobZgpQR168ZdnaWbTYmr8IlKHvdAKZJrLERwJToIFxLyvvoMmL1y0Gl6dK1lfKJSwua6TVzdjDNG7WM8tfJXf5mONs8cwEmyEq3u//rrxqfhdJaIDAXTEzM6P/JrwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9y2k8X26RtGKlijJFtaW7EwVm+/OCkIhtQbV6Z9VZ7U=;
 b=KeGIjFrKRlT8HGCjvIv01GiFUYVKUFrNoFOuPOe+2AHQXg0CNhRXeJJCdPQ5hB+fzRSKmNrmjPwsagHqQxKq7rU4x8BFFK3TKjsPfX/cI4CWlfdQcjABlci0Py7Q+oT/7XCVzPnriM1M/vs9xV2NOcqTGxMMG/gHVrw2SYOr93nPnV6IyZ5Q4otiXQzBIPw5zHPEylS+z/yOlAbUtXbgebZtCnAGDijMze8d4c2m5IkoI/1XvExitNFFtUZcULG2QtRFtwbmoEZgbgTiGyG6qYi9yOgwoA4DISrI90HyTQFt7dbhnoQQjCLAMfJ1cap48UdF4OAYfvCuvVXbzXDo9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9y2k8X26RtGKlijJFtaW7EwVm+/OCkIhtQbV6Z9VZ7U=;
 b=IhRQg1Yot4WMYQYwYzX6CaMgDr9IOQ49C7uGbD2o4Co43WxKjOy35KkZOn1WUsIdxdtJmc7FdKCo5lw11NulIwPaLwv8wkE3CamKpy9ZD79lQYV79d354DrX9s0zfP64oWZnU6+HtX0weqbijhoFlMigeP+1RT/SNEVsiMELos6hlsNsaBsqzrMZRLAEhkett7zSLnQQMJItOFmjsCxyZL0SiyJ7EcaQRlea2x6FsZC4xbhEUhVcVcaoJaKEb6ek5uEiy9dsbi9YXVmFJzqcf7YXV35YoXQlk+UfdhqRBtZMStNgiVZ14uEcbHyIQ2/Pr/xN/lLDuOWwywTyKxaDAA==
Received: from BYAPR04CA0009.namprd04.prod.outlook.com (2603:10b6:a03:40::22)
 by LV3PR12MB9144.namprd12.prod.outlook.com (2603:10b6:408:19d::10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9587.14; Mon, 9 Feb
 2026 13:56:49 +0000
Received: from MWH0EPF000971E6.namprd02.prod.outlook.com
 (2603:10b6:a03:40:cafe::1e) by BYAPR04CA0009.outlook.office365.com
 (2603:10b6:a03:40::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.18 via Frontend Transport; Mon,
 9 Feb 2026 13:56:48 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.118.233)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 MWH0EPF000971E6.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Mon, 9 Feb 2026 13:56:48 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 9 Feb
 2026 05:56:39 -0800
Received: from drhqmail203.nvidia.com (10.126.190.182) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.20; Mon, 9 Feb 2026 05:56:39 -0800
Received: from nvidia.com (10.127.8.12) by mail.nvidia.com (10.126.190.182)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Mon, 9 Feb 2026 05:56:37 -0800
From: Shani Peretz <shperetz@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, Shani Peretz <shperetz@nvidia.com>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: [PATCH 1/2] drivers: replace LIBRTE prefix with mlx5 PMDs
Date: Mon, 9 Feb 2026 15:56:24 +0200
Message-ID: <20260209135625.165750-2-shperetz@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260209135625.165750-1-shperetz@nvidia.com>
References: <20260209135625.165750-1-shperetz@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E6:EE_|LV3PR12MB9144:EE_
X-MS-Office365-Filtering-Correlation-Id: 3cb84329-6a03-410d-8661-08de67e3117c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026|18082099003; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?8I43nnHnkQ69ZQJxRwb5ZZzl5CODYTx1IINOOuEtmFiEAjW+8UDvpoq9/U6B?=
 =?us-ascii?Q?/xXzv79cR/eWETvt1brRGekDHSmLuuJpuZ0Ut9l99YeaSA+cABVB2eJQ0PdZ?=
 =?us-ascii?Q?LkwxGfnV2tRt76ld4G0eHpbVgDtap9J+3qC3Fa/D6r/wbiLOCO8aXXultNPP?=
 =?us-ascii?Q?1NhxskeuapmkXatr9nKQF3IDwiGWDhrbCRO2U0JOiTOuEA5OkzrTja8LUVDP?=
 =?us-ascii?Q?flTh+/C9HA3xG8B/wozTJCt61iYVl+9sKyHPyAR8deUlDgAKZ8M6g8O1GIXA?=
 =?us-ascii?Q?pbbFdQIv02vCifgAIE/mgWyjrZvTAtk43WiwU3GuLNo2bk/LM3gOQJBOCe3+?=
 =?us-ascii?Q?Lz548s4IcT6Ck4s0ui4XmK6+ednC994qkDkiv3+vlZIYtnUqNikG0tAonYxn?=
 =?us-ascii?Q?zbmBcy1HmALGWEXHLI/AX3+3vwfvKhucCKwXm/4wrq5JIQDqrhUJ4K5L+Wxn?=
 =?us-ascii?Q?naLD3GBGTdPmyJd0YoKIm+a5I5Z8RE75y2eYwOQtozubAp2fSryK2YYu7IpS?=
 =?us-ascii?Q?qv3+BvnnD1e6xfvFJzKEDqbKNUhOBx4G8RKmCN4VmTVuIaExrDl6+/cWUETx?=
 =?us-ascii?Q?nhBUXqHjgswMi3vvjwP+6mYmyWoahKBLGnMhsr+264wj7pVY/mPNgzDFfisw?=
 =?us-ascii?Q?ywuryS38Z9utH29IFempy7I9kshML2LLU7KRzAg9TC+gyejwZc4VrFzGjMk2?=
 =?us-ascii?Q?ykuRosfSJ9gU+ZhCu53zCuk9emVpltHDruH/ZHog4RTiW+4uSrum7hU6PC9j?=
 =?us-ascii?Q?RclGTZcIZN0sXzyrR1IAc8mAp2MMxeoU+wMQfFgS/HAMKBVGVwwntYTDr5wE?=
 =?us-ascii?Q?JF5XH7HZmYMBemQwC84YHBC7pVejdTrcse9z2ruZaknvuSTI9dLPGIKF2lHy?=
 =?us-ascii?Q?QnaKK+nR748sba6OiV+7S1vfqk6go3EOgHGMhEJJFhmU3NJxk4FnJAH39KgQ?=
 =?us-ascii?Q?o8UiRmG4IRBK72tkFJ37vMrPeT4a4+pMF33MuIook75LRqhlI8+uYE38pZy6?=
 =?us-ascii?Q?S1w6T/LFnxpFKVH4k63u21SqjZHeAbboZpvqxDXoh2C0sVb+DQHWEnUCnHk1?=
 =?us-ascii?Q?Gq+MckpLWU5JyVe7gPOMb2gZT8dobu0OQ9vFrLs0IJkY/GxIVV/RiZv3ozzK?=
 =?us-ascii?Q?aH9kHYx/TXVJwYZP8SXbyyxXZpNyQ5xn9BEUhWOwAPk0Xv5z5GV43mDnDUdK?=
 =?us-ascii?Q?3NcsCQF9GpSnG0Iv0VcHgLBIYrYAuVRByN5uf0C+Dwv/G0XKzWZwTlH/005y?=
 =?us-ascii?Q?vHie7QGfwgSSQCsi2DF/sqKeqT0OiLZiqVnC+BoRUtLAIseTyB7VRXvHrD8S?=
 =?us-ascii?Q?cLRPuUIuVGxIg4kgzKwAgDepo2KYggKOUtk4rN8wdvdFCNovrCr1RIpQwjc3?=
 =?us-ascii?Q?DZLWy8SelRUva/CC/4oCFLb0+RhlQWxettfaYXCmOIYb6TFot6p0Oij8JUo4?=
 =?us-ascii?Q?xWokEDpQAF8FnaNIDEX1/8YVr5UT/1qAbGHzvvENX7RJ610baqLKvATCAj5f?=
 =?us-ascii?Q?MYdrFmbXAKEhBOgc5foASGqiMTuqn01B2qtO6TKfX1q2ZFyqbQN+aTTb2zPY?=
 =?us-ascii?Q?KVXX9kEtQEyHFl/NFTBTwIKt0kGEMPkCQO/1yeyJtG1PAg6mO6u/QRLY8uZ0?=
 =?us-ascii?Q?ENiZxq7NqhYFzVPKI9V0mM7iJqOttrd4ApkIYp1iJSu/TqQGBQErofre2CHn?=
 =?us-ascii?Q?1TbO+A=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.118.233; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc7edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026)(18082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: GOnCDlL8ycR2A0DsSl7t7wP3dxQwC98lPkSR/WCc14jP6ipyvJIRwIes9IuAInX4Na8+nwWSUnWZdfWL+0HxQoqJ4+IznPqWzcFfCyVqfHvgqGDxrz+lHQBnVgggGM8wMQKJBs4klPooc61g/HhPNKxmFkElyNq+bZb14DryNBCy0K72b4nW4QZ7Hsgurlb/2gZUmC70GYhUOjHYtd7tkT4jSFp83YN/dsxkyfmJFak/vhSbTbcTreg130zOggEkyP7+XPrujImMsDElR3ZI7Qv7JpGO2RkQ48XAbVjDinSQLvLSmDmwoBQ8Oh5llunECyczTtzjGBnhTiSPf5w3c70bL5oWfBWDmeOilOf5iMlzDSnWwg7YQw/+/S54A65J8oASAMKYJaxIRh9c/lMZG4HLCpBXmxIJxJcZUFGkcRop5vWR/W+E/XPFTW1Isfo9
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2026 13:56:48.0903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cb84329-6a03-410d-8661-08de67e3117c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.118.233];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV3PR12MB9144
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

rename RTE_LIBRTE_MLX5_DEBUG to RTE_PMD_MLX5_DEBUG.

Bugzilla ID: 1522

Signed-off-by: Shani Peretz <shperetz@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 doc/guides/nics/mlx5.rst                   |  2 +-
 drivers/common/mlx5/linux/mlx5_common_os.c |  2 +-
 drivers/common/mlx5/linux/mlx5_nl.c        |  4 ++--
 drivers/common/mlx5/mlx5_common.h          | 14 +++++++-------
 drivers/common/mlx5/mlx5_common_mr.c       |  4 ++--
 drivers/common/mlx5/mlx5_malloc.c          | 22 +++++++++++-----------
 drivers/net/mlx5/hws/mlx5dr_internal.h     |  3 ++-
 drivers/net/mlx5/linux/mlx5_os.c           |  2 +-
 drivers/net/mlx5/mlx5.c                    |  4 ++--
 drivers/net/mlx5/mlx5_flow_dv.c            |  8 ++++----
 drivers/net/mlx5/mlx5_flow_hw.c            |  6 +++---
 drivers/net/mlx5/mlx5_tx.c                 |  2 +-
 drivers/net/mlx5/mlx5_tx.h                 |  6 +++---
 drivers/net/mlx5/mlx5_txq.c                |  2 +-
 drivers/net/mlx5/mlx5_utils.c              |  2 +-
 drivers/net/mlx5/mlx5_utils.h              |  2 +-
 drivers/net/mlx5/windows/mlx5_os.c         |  2 +-
 drivers/regex/mlx5/mlx5_regex_fastpath.c   |  2 +-
 18 files changed, 45 insertions(+), 44 deletions(-)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index c7f3981dcd..e0bcee7738 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -4430,7 +4430,7 @@ Steps to enable Tx datapath tracing:
    .. code-block:: console
 
       meson configure --buildtype=debug -Denable_trace_fp=true
-         -Dc_args='-DRTE_LIBRTE_MLX5_DEBUG -DRTE_ENABLE_ASSERT -DALLOW_EXPERIMENTAL_API' build
+         -Dc_args='-DRTE_PMD_MLX5_DEBUG -DRTE_ENABLE_ASSERT -DALLOW_EXPERIMENTAL_API' build
 
 #. Configure the NIC
 
diff --git a/drivers/common/mlx5/linux/mlx5_common_os.c b/drivers/common/mlx5/linux/mlx5_common_os.c
index 2867e21618..b2d7fe49db 100644
--- a/drivers/common/mlx5/linux/mlx5_common_os.c
+++ b/drivers/common/mlx5/linux/mlx5_common_os.c
@@ -389,7 +389,7 @@ mlx5_glue_constructor(void)
 		goto glue_error;
 #endif
 
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 	/* Glue structure must not contain any NULL pointers. */
 	{
 		unsigned int i;
diff --git a/drivers/common/mlx5/linux/mlx5_nl.c b/drivers/common/mlx5/linux/mlx5_nl.c
index d53543a113..f6ce84fdc4 100644
--- a/drivers/common/mlx5/linux/mlx5_nl.c
+++ b/drivers/common/mlx5/linux/mlx5_nl.c
@@ -482,7 +482,7 @@ mlx5_nl_mac_addr_cb(struct nlmsghdr *nh, void *arg)
 				rte_errno = ENOMEM;
 				return -rte_errno;
 			}
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 			char m[RTE_ETHER_ADDR_FMT_SIZE];
 
 			rte_ether_format_addr(m, RTE_ETHER_ADDR_FMT_SIZE,
@@ -612,7 +612,7 @@ mlx5_nl_mac_addr_modify(int nlsk_fd, unsigned int iface_idx,
 		goto error;
 	return 0;
 error:
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 	{
 		char m[RTE_ETHER_ADDR_FMT_SIZE];
 
diff --git a/drivers/common/mlx5/mlx5_common.h b/drivers/common/mlx5/mlx5_common.h
index 9403385195..672fc39c1d 100644
--- a/drivers/common/mlx5/mlx5_common.h
+++ b/drivers/common/mlx5/mlx5_common.h
@@ -74,7 +74,7 @@ pmd_drv_log_basename(const char *s)
 			RTE_FMT_HEAD(__VA_ARGS__,), \
 		RTE_FMT_TAIL(__VA_ARGS__,)))
 
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 
 #define PMD_DRV_LOG__(level, type, name, ...) \
 	PMD_DRV_LOG___(level, type, name, "%s:%u: %s(): " __VA_ARGS__)
@@ -86,28 +86,28 @@ pmd_drv_log_basename(const char *s)
 		__func__, \
 		__VA_ARGS__)
 
-#else /* RTE_LIBRTE_MLX5_DEBUG */
+#else /* RTE_PMD_MLX5_DEBUG */
 #define PMD_DRV_LOG__(level, type, name, ...) \
 	PMD_DRV_LOG___(level, type, name, __VA_ARGS__)
 #define PMD_DRV_LOG_(level, type, name, s, ...) \
 	PMD_DRV_LOG__(level, type, name, s "\n", __VA_ARGS__)
 
-#endif /* RTE_LIBRTE_MLX5_DEBUG */
+#endif /* RTE_PMD_MLX5_DEBUG */
 
 /* claim_zero() does not perform any check when debugging is disabled. */
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 
 #define MLX5_ASSERT(exp) RTE_VERIFY(exp)
 #define claim_zero(...) MLX5_ASSERT((__VA_ARGS__) == 0)
 #define claim_nonzero(...) MLX5_ASSERT((__VA_ARGS__) != 0)
 
-#else /* RTE_LIBRTE_MLX5_DEBUG */
+#else /* RTE_PMD_MLX5_DEBUG */
 
 #define MLX5_ASSERT(exp) RTE_ASSERT(exp)
 #define claim_zero(...) (__VA_ARGS__)
 #define claim_nonzero(...) (__VA_ARGS__)
 
-#endif /* RTE_LIBRTE_MLX5_DEBUG */
+#endif /* RTE_PMD_MLX5_DEBUG */
 
 /**
  * Returns true if debug mode is enabled for fast path operations.
@@ -115,7 +115,7 @@ pmd_drv_log_basename(const char *s)
 static inline bool
 mlx5_fp_debug_enabled(void)
 {
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 	return true;
 #else
 	return false;
diff --git a/drivers/common/mlx5/mlx5_common_mr.c b/drivers/common/mlx5/mlx5_common_mr.c
index 8ed988dec9..64ffc7f4ea 100644
--- a/drivers/common/mlx5/mlx5_common_mr.c
+++ b/drivers/common/mlx5/mlx5_common_mr.c
@@ -272,7 +272,7 @@ mlx5_mr_btree_free(struct mlx5_mr_btree *bt)
 void
 mlx5_mr_btree_dump(struct mlx5_mr_btree *bt __rte_unused)
 {
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 	uint32_t idx;
 	struct mr_cache_entry *lkp_tbl;
 
@@ -1319,7 +1319,7 @@ mlx5_free_mr_by_addr(struct mlx5_mr_share_cache *share_cache,
 void
 mlx5_mr_dump_cache(struct mlx5_mr_share_cache *share_cache __rte_unused)
 {
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 	struct mlx5_mr *mr;
 	int mr_n = 0;
 	int chunk_n = 0;
diff --git a/drivers/common/mlx5/mlx5_malloc.c b/drivers/common/mlx5/mlx5_malloc.c
index 28fb19b285..86e2b8881e 100644
--- a/drivers/common/mlx5/mlx5_malloc.c
+++ b/drivers/common/mlx5/mlx5_malloc.c
@@ -19,7 +19,7 @@ struct mlx5_sys_mem {
 	uint32_t reserve:30; /* Reserve. */
 	RTE_ATOMIC(struct rte_memseg_list *) last_msl;
 	/* last allocated rte memory memseg list. */
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 	uint64_t malloc_sys;
 	/* Memory allocated from system count. */
 	uint64_t malloc_rte;
@@ -43,7 +43,7 @@ struct mlx5_sys_mem {
 static struct mlx5_sys_mem mlx5_sys_mem = {
 	.init = 0,
 	.enable = 0,
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 	.malloc_sys = 0,
 	.malloc_rte = 0,
 	.realloc_sys = 0,
@@ -99,7 +99,7 @@ mlx5_mem_update_msl(void *addr)
 		rte_atomic_store_explicit(&mlx5_sys_mem.last_msl,
 			rte_mem_virt2memseg_list(addr),
 			rte_memory_order_relaxed);
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 		rte_atomic_fetch_add_explicit(&mlx5_sys_mem.msl_update, 1,
 				   rte_memory_order_relaxed);
 #endif
@@ -126,7 +126,7 @@ mlx5_mem_is_rte(void *addr)
 	    rte_atomic_load_explicit(&mlx5_sys_mem.last_msl, rte_memory_order_relaxed))) {
 		if (!rte_mem_virt2memseg_list(addr))
 			return false;
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 		rte_atomic_fetch_add_explicit(&mlx5_sys_mem.msl_miss, 1, rte_memory_order_relaxed);
 #endif
 	}
@@ -198,7 +198,7 @@ mlx5_malloc(uint32_t flags, size_t size, unsigned int align, int socket)
 			}
 		}
 		mlx5_mem_update_msl(addr);
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 		if (addr)
 			rte_atomic_fetch_add_explicit(&mlx5_sys_mem.malloc_rte, 1,
 					   rte_memory_order_relaxed);
@@ -212,7 +212,7 @@ mlx5_malloc(uint32_t flags, size_t size, unsigned int align, int socket)
 		addr = calloc(1, size);
 	else
 		addr = malloc(size);
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 	if (addr)
 		rte_atomic_fetch_add_explicit(&mlx5_sys_mem.malloc_sys, 1,
 				   rte_memory_order_relaxed);
@@ -247,7 +247,7 @@ mlx5_realloc(void *addr, uint32_t flags, size_t size, unsigned int align,
 	if (rte_mem) {
 		new_addr = rte_realloc_socket(addr, size, align, socket);
 		mlx5_mem_update_msl(new_addr);
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 		if (new_addr)
 			rte_atomic_fetch_add_explicit(&mlx5_sys_mem.realloc_rte, 1,
 					   rte_memory_order_relaxed);
@@ -260,7 +260,7 @@ mlx5_realloc(void *addr, uint32_t flags, size_t size, unsigned int align,
 		return NULL;
 	}
 	new_addr = realloc(addr, size);
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 	if (new_addr)
 		rte_atomic_fetch_add_explicit(&mlx5_sys_mem.realloc_sys, 1,
 				   rte_memory_order_relaxed);
@@ -275,13 +275,13 @@ mlx5_free(void *addr)
 	if (addr == NULL)
 		return;
 	if (!mlx5_mem_is_rte(addr)) {
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 		rte_atomic_fetch_add_explicit(&mlx5_sys_mem.free_sys, 1,
 				   rte_memory_order_relaxed);
 #endif
 		mlx5_os_free(addr);
 	} else {
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 		rte_atomic_fetch_add_explicit(&mlx5_sys_mem.free_rte, 1,
 				   rte_memory_order_relaxed);
 #endif
@@ -293,7 +293,7 @@ RTE_EXPORT_INTERNAL_SYMBOL(mlx5_memory_stat_dump)
 void
 mlx5_memory_stat_dump(void)
 {
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 	DRV_LOG(INFO, "System memory malloc:%"PRIi64", realloc:%"PRIi64","
 		" free:%"PRIi64"\nRTE memory malloc:%"PRIi64","
 		" realloc:%"PRIi64", free:%"PRIi64"\nMSL miss:%"PRIi64","
diff --git a/drivers/net/mlx5/hws/mlx5dr_internal.h b/drivers/net/mlx5/hws/mlx5dr_internal.h
index 6a4aafbe88..3c27206043 100644
--- a/drivers/net/mlx5/hws/mlx5dr_internal.h
+++ b/drivers/net/mlx5/hws/mlx5dr_internal.h
@@ -59,7 +59,8 @@
 #define MLX5DR_ASAN_ALIGN
 #endif
 
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
+
 /* Prevent double function name print when debug is set */
 #define DR_LOG DRV_LOG
 #else
diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 7b21bc4ec2..f900d5f160 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1592,7 +1592,7 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	DRV_LOG(INFO,
 		"port %u MAC address is " RTE_ETHER_ADDR_PRT_FMT,
 		eth_dev->data->port_id, RTE_ETHER_ADDR_BYTES(&mac));
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 	{
 		char ifname[MLX5_NAMESIZE];
 
diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index 26a05e51c2..9056020364 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -1854,7 +1854,7 @@ mlx5_unlock_physical_device(void)
 static void
 mlx5_physical_device_destroy(struct mlx5_physical_device *phdev)
 {
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 	/* Check the object presence in the list. */
 	struct mlx5_physical_device *lphdev;
 
@@ -2106,7 +2106,7 @@ mlx5_free_shared_dev_ctx(struct mlx5_dev_ctx_shared *sh)
 	int i = 0;
 
 	pthread_mutex_lock(&mlx5_dev_ctx_list_mutex);
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 	/* Check the object presence in the list. */
 	struct mlx5_dev_ctx_shared *lctx;
 
diff --git a/drivers/net/mlx5/mlx5_flow_dv.c b/drivers/net/mlx5/mlx5_flow_dv.c
index 47f6d28410..e431deae3a 100644
--- a/drivers/net/mlx5/mlx5_flow_dv.c
+++ b/drivers/net/mlx5/mlx5_flow_dv.c
@@ -9231,7 +9231,7 @@ flow_dv_prepare(struct rte_eth_dev *dev,
 	return dev_flow;
 }
 
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 /**
  * Sanity check for match mask and value. Similar to check_valid_spec() in
  * kernel driver. If unmasked bit is present in value, it returns failure.
@@ -14529,7 +14529,7 @@ flow_dv_translate_items_geneve_opt_nta(struct rte_eth_dev *dev,
 	const struct rte_flow_item_geneve_opt *geneve_opt_m = items->mask;
 	void *geneve_parser;
 	struct mlx5_priv *priv = dev->data->dev_private;
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 	struct mlx5_geneve_tlv_option *option;
 #endif
 
@@ -14549,7 +14549,7 @@ flow_dv_translate_items_geneve_opt_nta(struct rte_eth_dev *dev,
 			return rte_flow_error_set(error, EINVAL,
 				RTE_FLOW_ERROR_TYPE_ITEM, items,
 				" GENEVE OPT parser creation failed ");
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 	} else {
 		/* Check if option exist in current parser. */
 		option = mlx5_geneve_tlv_option_get(priv,
@@ -14953,7 +14953,7 @@ flow_dv_translate_items_sws(struct rte_eth_dev *dev,
 	}
 	dev_flow->handle->vf_vlan.tag = wks.vlan_tag;
 	matcher->priority = wks.priority;
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 	MLX5_ASSERT(!flow_dv_check_valid_spec(match_mask, match_value));
 #endif
 	/*
diff --git a/drivers/net/mlx5/mlx5_flow_hw.c b/drivers/net/mlx5/mlx5_flow_hw.c
index dc70909cff..d24b7909e1 100644
--- a/drivers/net/mlx5/mlx5_flow_hw.c
+++ b/drivers/net/mlx5/mlx5_flow_hw.c
@@ -17564,7 +17564,7 @@ flow_hw_async_op_validate(struct rte_eth_dev *dev,
 /**
  * Validate user input for rte_flow_async_create() implementation.
  *
- * If RTE_LIBRTE_MLX5_DEBUG macro is not defined, this function is a no-op.
+ * If RTE_PMD_MLX5_DEBUG macro is not defined, this function is a no-op.
  *
  * @param[in] dev
  *   Pointer to the rte_eth_dev structure.
@@ -17626,7 +17626,7 @@ flow_hw_async_create_validate(struct rte_eth_dev *dev,
 /**
  * Validate user input for rte_flow_async_update() implementation.
  *
- * If RTE_LIBRTE_MLX5_DEBUG macro is not defined, this function is a no-op.
+ * If RTE_PMD_MLX5_DEBUG macro is not defined, this function is a no-op.
  *
  * @param[in] dev
  *   Pointer to the rte_eth_dev structure.
@@ -17665,7 +17665,7 @@ flow_hw_async_update_validate(struct rte_eth_dev *dev,
 /**
  * Validate user input for rte_flow_async_destroy() implementation.
  *
- * If RTE_LIBRTE_MLX5_DEBUG macro is not defined, this function is a no-op.
+ * If RTE_PMD_MLX5_DEBUG macro is not defined, this function is a no-op.
  *
  * @param[in] dev
  *   Pointer to the rte_eth_dev structure.
diff --git a/drivers/net/mlx5/mlx5_tx.c b/drivers/net/mlx5/mlx5_tx.c
index fe9da7f8c1..a3a90c91a3 100644
--- a/drivers/net/mlx5/mlx5_tx.c
+++ b/drivers/net/mlx5/mlx5_tx.c
@@ -229,7 +229,7 @@ mlx5_tx_handle_completion(struct mlx5_txq_data *__rte_restrict txq,
 		}
 		/* Normal transmit completion. */
 		MLX5_ASSERT(txq->cq_ci != txq->cq_pi);
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 		MLX5_ASSERT((txq->fcqs[txq->cq_ci & txq->cqe_m] >> 16) ==
 			    cqe->wqe_counter);
 #endif
diff --git a/drivers/net/mlx5/mlx5_tx.h b/drivers/net/mlx5/mlx5_tx.h
index 16307206e2..ccec0c9220 100644
--- a/drivers/net/mlx5/mlx5_tx.h
+++ b/drivers/net/mlx5/mlx5_tx.h
@@ -154,7 +154,7 @@ struct __rte_cache_aligned mlx5_txq_data {
 	struct mlx5_mr_ctrl mr_ctrl; /* MR control descriptor. */
 	struct mlx5_wqe *wqes; /* Work queue. */
 	struct mlx5_wqe *wqes_end; /* Work queue array limit. */
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 	uint32_t *fcqs; /* Free completion queue (debug extended). */
 #else
 	uint16_t *fcqs; /* Free completion queue. */
@@ -763,7 +763,7 @@ mlx5_tx_request_completion(struct mlx5_txq_data *__rte_restrict txq,
 		last->cseg.flags = RTE_BE32(MLX5_COMP_ALWAYS <<
 					    MLX5_COMP_MODE_OFFSET);
 		/* Save elts_head in dedicated free on completion queue. */
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 		txq->fcqs[txq->cq_pi++ & txq->cqe_m] = head |
 			  (last->cseg.opcode >> 8) << 16;
 #else
@@ -808,7 +808,7 @@ mlx5_tx_request_completion_trace(struct mlx5_txq_data *__rte_restrict txq,
 			txq->elts_comp = head;
 		}
 		/* Completion request flag was set on cseg constructing. */
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 		txq->fcqs[txq->cq_pi++ & txq->cqe_m] = head |
 			  (wqe->cseg.opcode >> 8) << 16;
 #else
diff --git a/drivers/net/mlx5/mlx5_txq.c b/drivers/net/mlx5/mlx5_txq.c
index ad15b20e7b..a09a16958a 100644
--- a/drivers/net/mlx5/mlx5_txq.c
+++ b/drivers/net/mlx5/mlx5_txq.c
@@ -80,7 +80,7 @@ txq_free_elts(struct mlx5_txq_ctrl *txq_ctrl)
 
 		MLX5_ASSERT(elt != NULL);
 		rte_pktmbuf_free_seg(elt);
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 		/* Poisoning. */
 		memset(&(*elts)[elts_tail & elts_m],
 		       0x77,
diff --git a/drivers/net/mlx5/mlx5_utils.c b/drivers/net/mlx5/mlx5_utils.c
index defcf80dd7..606743c4b7 100644
--- a/drivers/net/mlx5/mlx5_utils.c
+++ b/drivers/net/mlx5/mlx5_utils.c
@@ -377,7 +377,7 @@ mlx5_ipool_allocate_from_global(struct mlx5_indexed_pool *pool, int cidx)
 		if (lc)
 			memcpy(p->trunks, lc->trunks, trunk_idx *
 		       sizeof(struct mlx5_indexed_trunk *));
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 		memset(RTE_PTR_ADD(p->trunks, trunk_idx * sizeof(void *)), 0,
 			n_grow * sizeof(void *));
 #endif
diff --git a/drivers/net/mlx5/mlx5_utils.h b/drivers/net/mlx5/mlx5_utils.h
index 95866351c2..9ab79c8ad5 100644
--- a/drivers/net/mlx5/mlx5_utils.h
+++ b/drivers/net/mlx5/mlx5_utils.h
@@ -183,7 +183,7 @@ typedef int32_t (*mlx5_l3t_alloc_callback_fn)(void *ctx,
 #define TRUNK_MAX_IDX ((1 << TRUNK_IDX_BITS) - 1)
 #define TRUNK_INVALID TRUNK_MAX_IDX
 #define MLX5_IPOOL_DEFAULT_TRUNK_SIZE (1 << (28 - TRUNK_IDX_BITS))
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 #define POOL_DEBUG 1
 #endif
 
diff --git a/drivers/net/mlx5/windows/mlx5_os.c b/drivers/net/mlx5/windows/mlx5_os.c
index 37a6bdfe9a..9019d6ca6e 100644
--- a/drivers/net/mlx5/windows/mlx5_os.c
+++ b/drivers/net/mlx5/windows/mlx5_os.c
@@ -490,7 +490,7 @@ mlx5_dev_spawn(struct rte_device *dpdk_dev,
 	DRV_LOG(INFO,
 		"port %u MAC address is " RTE_ETHER_ADDR_PRT_FMT,
 		eth_dev->data->port_id, RTE_ETHER_ADDR_BYTES(&mac));
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 	{
 		char ifname[MLX5_NAMESIZE];
 
diff --git a/drivers/regex/mlx5/mlx5_regex_fastpath.c b/drivers/regex/mlx5/mlx5_regex_fastpath.c
index 6e21574d29..3207bcbc60 100644
--- a/drivers/regex/mlx5/mlx5_regex_fastpath.c
+++ b/drivers/regex/mlx5/mlx5_regex_fastpath.c
@@ -40,7 +40,7 @@
 /* In WQE set mode, the pi should be quarter of the MLX5_REGEX_MAX_WQE_INDEX. */
 #define MLX5_REGEX_UMR_QP_PI_IDX(pi, ops) \
 	(((pi) + (ops)) & (MLX5_REGEX_MAX_WQE_INDEX >> 2))
-#ifdef RTE_LIBRTE_MLX5_DEBUG
+#ifdef RTE_PMD_MLX5_DEBUG
 #define MLX5_REGEX_DEBUG 0
 #endif
 #ifdef HAVE_MLX5_UMR_IMKEY
-- 
2.34.1

