Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BFD64CA0FF0
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 Aug 2025 09:10:19 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 205254042C;
	Fri, 29 Aug 2025 11:10:19 +0200 (CEST)
Received: from NAM02-BN1-obe.outbound.protection.outlook.com
 (mail-bn1nam02on2047.outbound.protection.outlook.com [40.107.212.47])
 by mails.dpdk.org (Postfix) with ESMTP id C0B254025A
 for <dev@dpdk.org>; Fri, 29 Aug 2025 11:10:17 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t8AqT87Up6kSIFGSYqm1nqV3BlzeW384vGECxxCxVm7b3q2WWqwH90k0ypZQ4c8K4++BFV8iqQe0eS4Gu4Zn+CVmkQPQUnbzc5Gr2006XFjIcvo27YyYXXKtRr6/stmXlKIW18F+S7pARruyD0nhNT0cbdrdB6Ua+gyArOf1i9iblL/ReVzMujuueNpb02W+nxLHxYni/LUc4cKaQDYGevyG8kKXtyi+QlCgB3xBU0ZrbxPiikp2UzrLRWorKYofOdPuAUTLBpWCbAs8XwgiI4BpESjsMxt4UfCg/S50DVnNuag4caTLbCqcwuQxYxaOy4ppV6W4NNMH8JCmKYXpUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R103c3dS8tPL3CC1fhYbKQ7Y/KHkPNiKoS4NtAoqcTk=;
 b=C8TZytQWo/YO7OA+Dh7z0xCntYQiyG3rs0ibZbB0nBpGH4MacBZCe3NRnrR9JaYU+FidjamQE0crdbQpR/rp93p6qlE5SMqnUNI1BS+kX9YzyxRS+3Bl4RObTlgdxdmBZR7NkzIPeLl+280kr9jd266J2tzRzYFY1gWEDx+oSUCffe9L3XyrVWM5vFoTYLmQNXZwrIQazjEx7XTtarJ8Lssx3su0VD6mCo7tKbI9Uo5Gcs5+ha4ND73/vrJ5R78bXPTYWS+Ch/rLnFmS1Rj1z0EshpKfjSvN8wNOLU4Sqs6Z7qUCbBrgRhjgv2xCKFhlpZ6FTRBCfAz914rINR3lkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=monjalon.net smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R103c3dS8tPL3CC1fhYbKQ7Y/KHkPNiKoS4NtAoqcTk=;
 b=MSk6faY4xPmcsF8tjpajlSirl4oHKAlxo13EYuq1wncdMCR+DOzMeuZOHjWnMgyNFCWk39ogaTfKXoPoHlNXoEv+uNm/Ak/MNczNnMLEEuIdcgwmtUO4FeeuR/pVShbl/Byc55MVaNFiF4GYpPEtEucpEoUFsome/cZhT3fqbmHCD3tsUOkt6xGBvcYIQj9B3pPyupIDnHH60+WF4U8QWPgM2L8ZMcoS/O69Ox8Yrb8cWCuq2NGWtxl+UE6kG8HYhyAZv8fZh+brcRoENvHK6TpIoE0M3Wk+1xvJbNW81UMnRD4JU705OkU/PWaLOkk74dhVvdPrfTc0KLIVoX1qyg==
Received: from SJ2PR07CA0017.namprd07.prod.outlook.com (2603:10b6:a03:505::17)
 by IA0PR12MB8695.namprd12.prod.outlook.com (2603:10b6:208:485::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9052.20; Fri, 29 Aug
 2025 09:10:11 +0000
Received: from SJ5PEPF000001ED.namprd05.prod.outlook.com
 (2603:10b6:a03:505:cafe::4) by SJ2PR07CA0017.outlook.office365.com
 (2603:10b6:a03:505::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9073.19 via Frontend Transport; Fri,
 29 Aug 2025 09:10:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ5PEPF000001ED.mail.protection.outlook.com (10.167.242.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9073.11 via Frontend Transport; Fri, 29 Aug 2025 09:10:10 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 02:09:57 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 29 Aug
 2025 02:09:53 -0700
From: Gavin Li <gavinl@nvidia.com>
To: <matan@nvidia.com>, <viacheslavo@nvidia.com>, <orika@nvidia.com>,
 <thomas@monjalon.net>, Dariusz Sosnowski <dsosnowski@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, "Minggang Li
 (Gavin)" <gavinl@nvidia.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>
Subject: [PATCH V4 2/2] net/mlx5: add support for flows targeting multicast
 MAC addresses
Date: Fri, 29 Aug 2025 12:08:30 +0300
Message-ID: <20250829090830.1049176-3-gavinl@nvidia.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250829090830.1049176-1-gavinl@nvidia.com>
References: <20250825141322.974335-3-gavinl@nvidia.com>
 <20250829090830.1049176-1-gavinl@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001ED:EE_|IA0PR12MB8695:EE_
X-MS-Office365-Filtering-Correlation-Id: 279d7a50-6efc-49cd-7dff-08dde6dbdb38
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?f6wm1qHv3VJgqZjSI+HxTl1GfVgh4MIeTZf2HzpyurJDBKJVbULUr8CjMdLd?=
 =?us-ascii?Q?qn801/b6SiOHWYeMRUbdf7VH4GvfjuVUo6B8o7NGtAJLLTHExNqDJxHZTeLV?=
 =?us-ascii?Q?mvuCF7GCXUO2m8qqpf1Ymf0D0oIzjobz22WzLkKzCocyNJUREr4geT85PJ+C?=
 =?us-ascii?Q?MlZwujWsj9WyDBFfJiUViKfC3FxgPjEWeuDPdR04WQOA+w+Vc7GAw3Kx1MM8?=
 =?us-ascii?Q?Emv/TnCiwpfFtZcKpbjrOr1ElXWubH1dRZT7dFc19xF7Lw523l2hjEIcUXUE?=
 =?us-ascii?Q?tzsXSzq1FqPjl+nkKFU06lMr3boz7cnRIWbjhdQJp6BAfb/OrbgCVEFGnQa9?=
 =?us-ascii?Q?5ajOEfeEhzZRT4Z7GUjAgtWVyyt0WgzVYFwtTht7q3H3ruTW958dHvkx0Wtq?=
 =?us-ascii?Q?DyhtWpIA72PergZKHzl34EZvy9YZbH1lkyEaD18bUt+xuN00BOwkDbZkWraf?=
 =?us-ascii?Q?fv9B8ZNtLNa2mobrwP46CMmLQwetGlifAwlBW2FGVlSkVhoEykwgiHOW7ael?=
 =?us-ascii?Q?OGJ2vvTBpkGP+3vZL7GA7qcDsIyQMYRGy+FcLrkMPmINLQK7UNe2JaPBgP5E?=
 =?us-ascii?Q?5xJENukFiDYjeX+YIr0BWiBmUNeb2DQe1FXt8efhpShXjq4BYEj1IrxMpNh7?=
 =?us-ascii?Q?ZAjjRKKVgon5Kf1bUqDyINN6BMmhfy7AZ1Cgo+QjS0L7NqsHbBMHBdS3A/wv?=
 =?us-ascii?Q?gH7OytR28dNLuGCYIY2ZLGRLB/H2sVZ7FxirL0T7a8gf1EVDs9dcRq/MSyvT?=
 =?us-ascii?Q?3qV1IiDXK7K//XiEZF8C3cgUWTGF2njrUp3Msd3zidMbJpsR5+rEmgUEckQv?=
 =?us-ascii?Q?T7Ceq2S1ZnhaqVcPe1i6VWAlQfhFODcMIgIyJLBda2gLBU6RAAKDc0JBbYeW?=
 =?us-ascii?Q?vKeQDwyrMfFolqqRBmJeTF1dfsHKnnzVmqknr3TNdRzAjzMvIu3PDqr8LBVg?=
 =?us-ascii?Q?+XMCnrq7KbD/Xt4YgFDIh0uQ8iTPsZPt4S7BLpnQ7mb+WVScDLShsF4g06H4?=
 =?us-ascii?Q?L3pHUbTE7/M7ltaxol5fc7mr+CcyUA4i6842McClAfT/4h72H88hw+RHsKC5?=
 =?us-ascii?Q?+1yd8ck7A8hGPTQcTop1aWbVd73JLI0Gm1if7HYH0RL//9ZP4PJzbEo2bZGP?=
 =?us-ascii?Q?k29IwUrQpHnUsfTTM+NivQLGVJ8rCPMnMcqUR0HA1rPotrkbFudMP1OyPp0r?=
 =?us-ascii?Q?skkVsiRKB9+apZ4gnTObm9JMPbCuV8GQGG8Fy8q3D9NkAdQV2aLR2F70fZ6P?=
 =?us-ascii?Q?jIjcQUF1euE2CQm6lwS02xk2+Hj3dTmWRzGA/j8NU/Au6C+6Xw1160ZVqmTg?=
 =?us-ascii?Q?zMv1vzmKE5kG4wArWO9WygNjtgfj29OhtHrh53Pl0KfbSApeu7O8jr4NRiqc?=
 =?us-ascii?Q?hlPvOXkA3SanQ4Itr7rLnB2e3k+bBGrvdHhXKl91P3f842L0FsF8+3sbFsgo?=
 =?us-ascii?Q?QBTsa8pY2hbANJn0fBLtMGoGJdHXtXcgt+Y3jBSXeA0g3TrbjmezSnk4LTnS?=
 =?us-ascii?Q?RriVQ88pkRNDLwCqc9eMje2DfP7M432TNztt?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Aug 2025 09:10:10.5311 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 279d7a50-6efc-49cd-7dff-08dde6dbdb38
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8695
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

Device multicast MAC addresses are managed using the mac_addr_add and
mac_addr_remove APIs.

In the mlx5_dev_spawn function, devices such as PF, VFs, and SFs obtain
the MAC addresses configured in netdev via netlink and store them in the
PMD device data, which also includes multicast MAC addresses. Default
rules are created for each MAC address to filter traffic accordingly.

Previously, multicast MAC address flows were mistakenly disabled, which
caused mac_addr_add to stop functioning for multicast MAC addresses,
resulting in missed multicast traffic.

To address this, default rules for multicast MAC addresses created by
PMD should now be set up within mlx5_traffic_enable to properly update
and manage multicast MAC address rules.

Fixes: 2d0665a7f771 ("net/mlx5: align PF and VF/SF MAC address handling")

Signed-off-by: Gavin Li <gavinl@nvidia.com>
---
 drivers/net/mlx5/mlx5_trigger.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 6c6f228afd..46479fbf09 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -1813,7 +1813,10 @@ mlx5_traffic_enable(struct rte_eth_dev *dev)
 	for (i = 0; i != MLX5_MAX_MAC_ADDRESSES; ++i) {
 		struct rte_ether_addr *mac = &dev->data->mac_addrs[i];
 
-		if (!memcmp(mac, &cmp, sizeof(*mac)) || rte_is_multicast_ether_addr(mac))
+		/* Add flows for unicast and multicast mac addresses added by API. */
+		if (!memcmp(mac, &cmp, sizeof(*mac)) ||
+		    !BITFIELD_ISSET(priv->mac_own, i) ||
+		    (dev->data->all_multicast && rte_is_multicast_ether_addr(mac)))
 			continue;
 		memcpy(&unicast.hdr.dst_addr.addr_bytes,
 		       mac->addr_bytes,
-- 
2.34.1

