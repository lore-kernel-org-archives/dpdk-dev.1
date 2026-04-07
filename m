Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D773EDB7F0
	for <dpdk-dev@archiver.kernel.org>; Tue,  7 Apr 2026 10:32:10 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4ED814025F;
	Tue,  7 Apr 2026 12:32:09 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010066.outbound.protection.outlook.com
 [52.101.193.66])
 by mails.dpdk.org (Postfix) with ESMTP id 5C84B40150;
 Tue,  7 Apr 2026 12:32:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=urev/bleoIhB4r2UUVHCPPF9nDmwZ0kyVDU2KqeiXWfY+xB8G5o8WjLEFHl/smmhHBAhVcMn1L6x2OPWN2Fo0xmDJxiOMXMuklYfj2e7UAbIP7dEw10iUHJsVFXX4IHn5mo1dlh2CcIZmlsLLll1W88hfl2q9G8gn/Iaq5prO1efB4zmFDA9YYuFS+EAd4S25P98XN3HgA2K9sn1BeFAMwTdH4myLlKYiNS6yJHfqz9Xfz8yRiCVjzKFWEr+eLvqA97Fe9352LaxtaMzWC3gWIxIpveTeQ2mA7DYiPWxRFMpf9oPo28rC68lqnCiApSS82YpV3P3kcTdPJzv2jhUyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=I7bbNikyTqvcgDahra9tPMnFbIY/cDxiT4TL22RQw7k=;
 b=JjNx7adGGy74HzEdvnG/3l2XB6f+ObYiQ0XKZu5ouWPKpRi0PquS+x7OwsDwNPWn/jKQD7YtfCjIX+BkBuV2LG3OfeIjSSNURTsKjE6afFuZ4w8k3/HMiUxRZt4Z7kSAmjTMkYezCLbC5nqP9/OJvnSdFM7NqxhXY7PfcBhPg88f7tQXhNzx/J0K4V+uV2aizGjPw9YbndezbirWetBlzky5adOLzeZzLSR00CGV396WyxVw903uHuhVTTxg1PYG64vjijBwZJ9joQTGAu/5iyNaPZ8xsbh7eMd/yrhuiiJP2jGFcOqaKq425VFqGKMdX2W2iD3eJfxTYGIZUkv3lA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=I7bbNikyTqvcgDahra9tPMnFbIY/cDxiT4TL22RQw7k=;
 b=R7/yf5j/DzSMX/SuNM13SZfpmu7VbnCN3EqgLqaK8BAGnjpnzSlJ/Cu6rHdPVeRGhLmSjCTKecMF/T1jdIaP3GYAKzcLzIguPKfQAs4CjDCEPIPSah9w6ClTipnBW5pvGXWQo0wIfhCpOWPgeiRuOPNgXahvUhAXytx5fy/sTaWv8mO/NvDpNMVmCg3hzHAahb3n47604xHtqaoUf9BZRMf96yfcQh4Saibv1yc8f93FhqKQ+BptxathBUqV3NVcSLFSdsWm1ZlBUSICiQhLVaV96V+JFRD7a3LKkEBQjmwDQr21bD2IXZmwI5dzQK0z5iDoGeX8E6wXDmWNzjdpmg==
Received: from CY5P221CA0092.NAMP221.PROD.OUTLOOK.COM (2603:10b6:930:9::22) by
 PH7PR12MB9127.namprd12.prod.outlook.com (2603:10b6:510:2f6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.20; Tue, 7 Apr
 2026 10:32:02 +0000
Received: from CY4PEPF0000E9D9.namprd05.prod.outlook.com
 (2603:10b6:930:9:cafe::9a) by CY5P221CA0092.outlook.office365.com
 (2603:10b6:930:9::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.32 via Frontend Transport; Tue,
 7 Apr 2026 10:32:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY4PEPF0000E9D9.mail.protection.outlook.com (10.167.241.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Tue, 7 Apr 2026 10:32:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 03:31:49 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 7 Apr
 2026 03:31:47 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix skipping PF representors
Date: Tue, 7 Apr 2026 12:31:30 +0200
Message-ID: <20260407103130.142440-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000E9D9:EE_|PH7PR12MB9127:EE_
X-MS-Office365-Filtering-Correlation-Id: 06a953e2-397e-4e12-d6b9-08de9490e7e0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: 938NLIoP4BFHIZmIES5SJomjntQuCaJETryMrimyH7iHPJsPS8GRy6GVawPaRC4/Lv4UOH3nsD9JOGmdj7KB1/3hSf8Kc3OToEzxv0AViNdD5ZK5Eq6baxLgC2EoUZ8Rtp4bpU6Aq+9fpZjoDccgKl2DjSf/nvB+8G1Zvwf0q5uDKw3ZUqIt81e997T6nbA59yeuaAMaXu0K1WswsZHEiw/pA2zb/EBPHwMO0YhOkwIGuFq5FiZaxZSWauopo4aMeuqDhKmfMascyXsSRSMfD/bG+AQYmu3uqBCJWwXavyVIFIfHKMcRdN8yRZtyuPnjnKy287OUZ9cRA3U1vQft+qN8NRTOvYfmNUhSzDbvUPeQwYtva5rE6Sg1LPs9Hn4xzMmQMJCYYdYucmXTKNMKUoHoxUXxsodHd6jrdcccKebUXIpb6ITCv6tmLJW4mgmWYeH0NR82zst5ixtE+C41yGrG/r0O6tQBFw6jdONzneB8ZA791WeWNC71nJs1keQP1aJz85WpvHCv9yFqsPY+3BpBNSe27rPtA9b3w1YI5i4ZmlhuRERo6PNoqo36gZr8eR7imKo2biDl2PApyGd0MynDTWnJ5/ijx7IhrEEkTJ+o0NmvN6YJsVi5r4ZSJrUSPkCZ2oU9hyNaPXC/h5R5lqqKmnrcqm9mKUXtBbD/KyBktiz6+NKinwqWocPmCCuoKgmFeZzjM8RNBlTrYFVM3MxC3LU6zQlB2J7MjjFYlvA5AZ41q0gz6M+Gy+VLXZAdK46Z1ruXLqqHi0sIrOaj8A==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: PkWsDDm+tT4nkDAYYPgareS3ytwkXga0cSqQI+13s2LOuM4YkoU0buER7n0BNEtmHur43rJVbb89Z3PNk+tKrNSrRqSRjWRzSqiujgWlWg8ln4SBYH375T+ypzymf1UQKRuNsBkmlKIuJ6+2KZzRbiHrUPrMZiQmQ2imo/LZHbWmaP49LUGe31yGXvEzWcCA/DVpWuRmrYifU6EiMVhLSuIe/SWo291bVKo1JMp+jdyT4/GBsQnPdD1d6wsqXAoGrLEJ+RnnmYsoLzfgdjDyFJqP90qfajS4nfJ+3sZev41G0Jsqmde4pFNyahY8P37aS/TrXxUtAIVqc7dDnaZV0+WGNaKQckgoPJLrqT1tfKUtEIqpsNFoKv1tJfbRuFO1NO3qWTDkQ2g0UEQPpmufRo4xKtnQLlQLqRSZSc3WZvsLoUVVSU1hWq9IBZLTy4hy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2026 10:32:01.8568 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 06a953e2-397e-4e12-d6b9-08de9490e7e0
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000E9D9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB9127
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

Offending patch changed logic of matching IB ports to requested
representors in mlx5 driver.
Each found IB port was matched against all requested representors.
Whenever:

- requested representor was VF or SF
- PF was not ignored
- IB port was physical port
- physical port index matched requested PF index

the physical port representor was probed.
If any of the above is false, mlx5 driver should have continue testing
other requested PF representors.
In the offending patch, the representor matching loop was stopped.
As a result, if mlx5 device with MPESW enabled was probed with the
following devargs:

	-a 08:00.0,dv_flow_en=2,representor=pf[0-1]vf[0,1]

Only 5 ports were probed (physical port 0 and all VF representors),
instead of 6 ports (physical port 1 is missing).

This patch fixes that by continuing representor matching loop
on physical port to PF index mismatch as described above.

Fixes: 2f7cdd821b1b ("net/mlx5: fix probing to allow BlueField Socket Direct")
Cc: stable@dpdk.org

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Bing Zhao <bingz@nvidia.com>
---
 drivers/net/mlx5/linux/mlx5_os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index a717191002..10b947116c 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -1186,7 +1186,7 @@ representor_match_port(const struct mlx5_dev_spawn_data *spawn,
 
 		/* Uplink ports should not be matched against representor_ports. */
 		if (spawn->info.name_type == MLX5_PHYS_PORT_NAME_TYPE_UPLINK)
-			return false;
+			continue;
 
 		for (uint16_t f = 0; f < eth_da->nb_representor_ports; ++f) {
 			uint16_t port_num = eth_da->representor_ports[f];
-- 
2.47.3

