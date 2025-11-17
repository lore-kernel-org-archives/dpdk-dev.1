Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0331BCEACEF
	for <dpdk-dev@archiver.kernel.org>; Mon, 17 Nov 2025 08:45:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4B68F40EE6;
	Mon, 17 Nov 2025 09:45:37 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013037.outbound.protection.outlook.com
 [40.107.201.37])
 by mails.dpdk.org (Postfix) with ESMTP id 3BEC8427B7;
 Mon, 17 Nov 2025 09:45:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NF14q2JySenCAIKq0I2ZV3SC/lZCBYJNjKzYPCGHSZPbs6k6l74JhlfoQw1ZB2YQ574Byht5H85IiZFwseIr+I3cSfVS57ufn+9CLuabMtFnybedaqYb1oK5/D3/kivvhWZPV6tiWX69uq6mn0f66rjxHtDzRyMkD+m5CfDZ00bQVjE5GwW8Zd+IYG9Sjpa7b/Iy0HdHRaGsUA3xdocjFZ8IbElDIVOi6OBH4zgfJO8iOuE4CRQr9/5pgwEuqdKQ7wLGl5ZcbV5Z6bau5Un4Sp78DWK3t5ZaOTg3XxJMizI64qVzwzmc1Liixvkg4cF7/Hze5L3uOa2Mo7pRYcG+ow==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x+y2xO1yxeWUMW75aFydP1s2GTY0NKlUNg2z68kMY/M=;
 b=M8uXGbwDSm1VrFSirR80uQHSZVXwlLgrTCWtytNae25jg3keGptCfiYg5q+9gvUX80NACKIfSlWWY6XGxzrZrDZuChP9Zsy3mszokIoCCyJ+niv11DeOwmzuGpXrzY1o/TWiv4oo8X+FEbGUvgR7vmlCbMwIkbFqNhELZPYYUtG8mLEiAO6wpeDJDthTYezP4DqGCyLCb49+5LGYpLkzWAiSG1cvu7WXs7vI5hL4rJagqXhXhpWsQltj9cG1EF1zxq3WvdFBHU8rLxT7ODi/WMro0ayU4OKM0AB+0GPKSElRLWqCP/96xRnbcaIzHmPemt55j09ddYtTNxyJKLaqbQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x+y2xO1yxeWUMW75aFydP1s2GTY0NKlUNg2z68kMY/M=;
 b=nyJXZNaxSm8ahc44O0zaviGq/xrgQtygwAOptaiV7LfZlJ7Ty6uVQsGRuDqE4n6DlTqA/0wr9Ur9SodiB6yaoIhJ4Qb6pdQWbl4I0Nwb3bAStnxS19WaD6B6ddX2+khXQXCLfW1/O4yrwtYnJk4sdsVD61RLPsQdzRnjVJdTb4dRe/y7orlZDnmvT3OKKfcuyos4dhw71/DEC8NO6tl8CqJoqUSJ1BJrfl842/65tTJVH3FxbmjgXVxx5rHW8Y9Wgi+mGaT+MqUA/KFMa/3tAwsVn0eY1ThJitTCgD05VmoukTfXRWeJyjOXmydi+9gqZK4aKU//m8TrW7A0dIJW9Q==
Received: from SJ0PR13CA0068.namprd13.prod.outlook.com (2603:10b6:a03:2c4::13)
 by PH7PR12MB7795.namprd12.prod.outlook.com (2603:10b6:510:278::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.18; Mon, 17 Nov
 2025 08:45:32 +0000
Received: from CO1PEPF000042A8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::56) by SJ0PR13CA0068.outlook.office365.com
 (2603:10b6:a03:2c4::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.10 via Frontend Transport; Mon,
 17 Nov 2025 08:45:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CO1PEPF000042A8.mail.protection.outlook.com (10.167.243.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Mon, 17 Nov 2025 08:45:31 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 00:45:14 -0800
Received: from rnnvmail204.nvidia.com (10.129.68.6) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 17 Nov
 2025 00:45:13 -0800
Received: from nvidia.com (10.127.8.9) by mail.nvidia.com (10.129.68.6) with
 Microsoft SMTP Server id 15.2.2562.20 via Frontend Transport; Mon, 17 Nov
 2025 00:45:11 -0800
From: Itai Sharoni <isharoni@nvidia.com>
To: <dev@dpdk.org>
CC: <thomas@monjalon.net>, <bingz@nvidia.com>, Itai Sharoni
 <isharoni@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH v2] net/mlx5/windows: fix match criteria in flow creation
Date: Mon, 17 Nov 2025 10:45:00 +0200
Message-ID: <20251117084500.1276-1-isharoni@nvidia.com>
X-Mailer: git-send-email 2.28.0.windows.1
In-Reply-To: <11095513.IZOipudI63@thomas>
References: <11095513.IZOipudI63@thomas>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000042A8:EE_|PH7PR12MB7795:EE_
X-MS-Office365-Filtering-Correlation-Id: 198d9c81-5d09-4e65-84b8-08de25b5aae2
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Mmk7MjrUVAVrnFYmB1tVtZArlmGPyB/cSn2PQEWEc1Pd/P036uPhnFEkSYiO?=
 =?us-ascii?Q?/ueNTFaa0Eg1q6ZFJIUsjqRrjaS5Oxgm9Tl2rrDz+J1sioE0J+HY8pVHgRUf?=
 =?us-ascii?Q?X16G1ib0eveOMB/m21BWG8XMMt9zPyWr5hC5MDQP5eFM1mVe5Scy51R2LV8h?=
 =?us-ascii?Q?622muF2BUdCPNCOj9To30rE2KPMnim4HHLNmc+cC/tIa0yQM+y2KQsHyYNMr?=
 =?us-ascii?Q?ALfO22WS91uIYX/XZH8Xq4B92hN1X2llUQdxI2R54/9C2QWlFS8QsW/MR+F1?=
 =?us-ascii?Q?GhuApO49GkqiVXzu5dcoAM+boIRmmfqJowJUbmPbRuWTXQooQMdvZKG0ppOt?=
 =?us-ascii?Q?vd+gnmKgC75bfMsS5DPsEd7gYI2Tj4b3LEUPMx2z12Ju9HsR6bGuCn2DQWnZ?=
 =?us-ascii?Q?F0T7zwcQj3rEei+3MdlI+hZiTWFnlTCHMKQgpgsbPZ7P2o8HusELigJE+8B5?=
 =?us-ascii?Q?163AxPJuLZHUcOK4M8qjcUdWi5P3pN2dZW2URaRWzwExW4cBwfs0Kq4SlYPa?=
 =?us-ascii?Q?LAJkHLwFpwp/MsIizLbNNgMANTgYWpbXt7FvAk3i7tJ910fA49ppFsSSBJrt?=
 =?us-ascii?Q?az4XFgUkYXS0t9erhGQlnVv01EBCR16MB98vYaJfXrQk7poETVcqUpPsp6/I?=
 =?us-ascii?Q?IcKgTW6uibxjGldEF2ByiXjCLvFD+iCajSi51jTKxJemKFzu4MSq1WBxJyoD?=
 =?us-ascii?Q?UI98HPqNAtuzus/Iv8yH1Aqv1FsaOOK7W10lPKdvmjj4cirW3XdSI52Ohqz4?=
 =?us-ascii?Q?AXwjMR3P2RV2AlmoPZcaRHwSGsgj+ZTSjDacnbGMGlFf/yDMdNjE+/1NDI0L?=
 =?us-ascii?Q?Uxqbvo2Fcebksd/4qepU/FdzRC5bKttkTjrtjvhKYzFsYEld6ieJfK555eqU?=
 =?us-ascii?Q?poxaHoecP8KjwERC6KKRoBPsLnI+2Vjb8aQN7Rt/MqNqmk28nXZEflLWxxIw?=
 =?us-ascii?Q?WbtFfSvHmWzncJxEPnG9UZgUdlN4kkzUxj3MtkqTQHOaTFfH8byUM0QEyDnV?=
 =?us-ascii?Q?8yMwVwrNrjscHeFiL9t84fYs8obKMVjUifrabLbjQQMZHVrkUAeLtYHdge6D?=
 =?us-ascii?Q?pY9dBu2b+NeZrc1LjS94AaLs+9QsmoVmKTnU48Umb7OcPv1OlHSTanzUXUtd?=
 =?us-ascii?Q?CQp3DSDkEj71W0Bg8N2SHbJkpXe5unMQWEJDr/yeEUdz8McQQmpiU0tNs/Cy?=
 =?us-ascii?Q?bJvcR9eZB3cF6FT30R7NbUrC4TkAPT0fGlgnkJRBQsrpaBbulNwTmtq6rdBg?=
 =?us-ascii?Q?ayF3AoNaixSAAydlI9NuKJj7+TDdo1/53FPyj7ZP450RobtcJXmxroootV+X?=
 =?us-ascii?Q?Sq1M7K7427iBo8kJeVgPzV6JTe5PJt5XBo12TgBoZv33sR+rgIOmKBcemEYX?=
 =?us-ascii?Q?bPxnLGm19qEQ8reMyWcOVZOnkdzjvC886lOxF7ix3iXdwse1Y6o1SKf1v/ui?=
 =?us-ascii?Q?xtWiRR8RQ400tcIKxE16glukLLzhFrpegz6+b/cPccRZPO44k5+40dzvpIPq?=
 =?us-ascii?Q?BPQoWR3vN5XZdrK8aP/qBTr7q0r/Ft3bE9rY6K/OYXQx1Viv+d9NgM65ALaK?=
 =?us-ascii?Q?TcfL2Fe4lbPzk2/uGgw=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2025 08:45:31.8672 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 198d9c81-5d09-4e65-84b8-08de25b5aae2
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000042A8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7795
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

Currently the Windows implementation hardcodes match criteria to
MLX5_MATCH_OUTER_HEADERS when creating flow rules, which prevents
matching on inner headers and other criteria types like NVGRE.

The fix uses the matcher's match_criteria_enable attribute instead
of hardcoding OUTER_HEADERS, and moves the assignment outside the
action switch block to apply to all cases.

NVGRE item type is also added to the supported items list.

Fixes: 1d194496b9d1 ("net/mlx5: create flow rule on Windows")
Cc: stable@dpdk.org

Signed-off-by: Itai Sharoni <isharoni@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
v2:
- Added documentation for NVGRE tunnel support on Windows
- Noted requirement for DevX dynamic insertion mode

 .mailmap                                | 1 +
 doc/guides/nics/mlx5.rst                | 4 ++++
 drivers/net/mlx5/windows/mlx5_flow_os.c | 4 ++--
 drivers/net/mlx5/windows/mlx5_flow_os.h | 1 +
 4 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/.mailmap b/.mailmap
index 50a59a596a..83c2ea91a4 100644
--- a/.mailmap
+++ b/.mailmap
@@ -639,6 +639,7 @@ Intiyaz Basha <intiyaz.basha@caviumnetworks.com>
 Ioana Ciornei <ioana.ciornei@nxp.com>
 Isaac Boukris <iboukris@gmail.com>
 Itamar Gozlan <igozlan@nvidia.com>
+Itai Sharoni <isharoni@nvidia.com>
 Itsuro Oda <oda@valinux.co.jp>
 Ivan Boule <ivan.boule@6wind.com>
 Ivan Dyukov <i.dyukov@samsung.com>
diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index e0ec3e4f6f..9efd4726df 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -1233,6 +1233,10 @@ On Windows, the features are limited:
   - IPv4/TCP with CVLAN filtering
   - L4 steering rules for port RSS of IP, UDP, TCP

+- Tunnel protocol support:
+
+  - NVGRE (requires DevX dynamic insertion mode)
+

 .. _mlx5_multiproc:

diff --git a/drivers/net/mlx5/windows/mlx5_flow_os.c b/drivers/net/mlx5/windows/mlx5_flow_os.c
index 7a625fb880..15c6fc5613 100644
--- a/drivers/net/mlx5/windows/mlx5_flow_os.c
+++ b/drivers/net/mlx5/windows/mlx5_flow_os.c
@@ -219,9 +219,9 @@ mlx5_flow_os_create_flow(void *matcher, void *match_value,
 		default:
 			break;
 		}
-		MLX5_SET(devx_fs_rule_add_in, in, match_criteria_enable,
-			 MLX5_MATCH_OUTER_HEADERS);
 	}
+	MLX5_SET(devx_fs_rule_add_in, in, match_criteria_enable,
+		mlx5_matcher->attr.match_criteria_enable);
 	*flow = mlx5_glue->devx_fs_rule_add(mlx5_matcher->ctx, in, sizeof(in));
 	return (*flow) ? 0 : -1;
 }
diff --git a/drivers/net/mlx5/windows/mlx5_flow_os.h b/drivers/net/mlx5/windows/mlx5_flow_os.h
index 2cd4e95325..c087bca4be 100644
--- a/drivers/net/mlx5/windows/mlx5_flow_os.h
+++ b/drivers/net/mlx5/windows/mlx5_flow_os.h
@@ -47,6 +47,7 @@ mlx5_flow_os_item_supported(int item)
 	case RTE_FLOW_ITEM_TYPE_IPV6:
 	case RTE_FLOW_ITEM_TYPE_VLAN:
 	case RTE_FLOW_ITEM_TYPE_ESP:
+	case RTE_FLOW_ITEM_TYPE_NVGRE:
 		return true;
 	default:
 		return false;
--
2.28.0.windows.1

