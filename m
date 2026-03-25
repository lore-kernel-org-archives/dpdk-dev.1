Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18A19FEA83E
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Mar 2026 09:59:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id BC0F840E1C;
	Wed, 25 Mar 2026 10:59:07 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010057.outbound.protection.outlook.com [52.101.61.57])
 by mails.dpdk.org (Postfix) with ESMTP id 7C5AD4028E;
 Wed, 25 Mar 2026 10:59:06 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lh1aTVeQopWEziNwMfNZoby/uJGlZTPB1DiN49HW1dSaX1orowfJsY4Kw579WW66H7FQVzKJ0zfvewtcv8dmg9FggR8wMkyLsEbFL3Gbhn9qW2+WngbySFzAGc8174IUIIGzpttHyAorU+cO2PpcWiK1XevjGIIyKyUWoQ+AkCW6L/DdoUmOwjCQjTRvdDfM4oFcJA4DHBjh8/3n1be1HAu7q34/i094tBTCB7bS5X5DDrsg+EXdlb2/6D/8nDkwN5PcKGEjvqttSzBbEkXdVBbdDnR8JOnyFIGSDTNf+U8Z+xkMgptR80Oow+TEXA9lR4ZPREct8H3PlnuEt/ZK8w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QwEJZ77xaEYoRdD+kbrxg68mzRJkhn88NOgd/Uj/0Lg=;
 b=CuBfSkHqndW1JnOWtnuZ3qkNEqa8hWjTrD0+MSuFFH2wviP/vQwPeo34XReqZwSNLbskMgrj+2OkP5zguz8cx8ToOImj6NY368LYnWJjjU97AFkA9hQ7FiwiNsgwSReXYANS4t6PpP37Vbx6C4NVGjAD3MzN0Ght6OqzXBT1SmY7QBaiWq29om1XpMNTo8bnaR9u0jSkmUI6X+mjXrbAatU4wd33IdWBn4ZS3eiDxrHYiPgWpLZ+v7mJZpT+uU/T8rVZXmjc604h4Y11Jjn9hVuLPVIXFNwe+h249Z9oK4SIqpYRNaNZa2cEQuqutMsCVUQ3S4Ap1LWuCZflOq5W/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QwEJZ77xaEYoRdD+kbrxg68mzRJkhn88NOgd/Uj/0Lg=;
 b=aJwKS4A1SmSSHFFFsd0faw9of+0nW+8tfokCf5kgXLS8pVtBc89Zh+sKSigyMch3+Xb3WW4L1wkYZBKgAcT1EHet1j2RdhgDV4laTLL4p6Wsty09krEvQpqvFTBMLB6DApyjxR3gep31czx8a9a1+HftLZZGztpD2mr89jUjJEr/v8wlcoiMs6PALaikgEWqVzmn2AnQ1LlqX1jgg4lF3vOzJqCj0jBa89p2zMviXiGu7T++ep89pA4l8BA4qoZOEz7+HsHzOusUo2n1PMWoDKM6TCEi8kEZU7+/8H+v8jW8gtzcA+SI3IfQgm5n9mmMrz8PdAU4Ewq8kOthm5yXAQ==
Received: from BYAPR07CA0058.namprd07.prod.outlook.com (2603:10b6:a03:60::35)
 by SA1PR12MB7295.namprd12.prod.outlook.com (2603:10b6:806:2b6::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 09:59:02 +0000
Received: from CO1PEPF00012E61.namprd05.prod.outlook.com
 (2603:10b6:a03:60:cafe::8b) by BYAPR07CA0058.outlook.office365.com
 (2603:10b6:a03:60::35) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.32 via Frontend Transport; Wed,
 25 Mar 2026 09:59:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF00012E61.mail.protection.outlook.com (10.167.249.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 09:59:02 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 02:58:42 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 02:58:39 -0700
From: Bing Zhao <bingz@nvidia.com>
To: <viacheslavo@nvidia.com>, <dev@dpdk.org>, <rasland@nvidia.com>
CC: <orika@nvidia.com>, <dsosnowski@nvidia.com>, <suanmingm@nvidia.com>,
 <matan@nvidia.com>, <thomas@monjalon.net>, <stable@dpdk.org>
Subject: [PATCH] net/mlx5: fix NAT64 HW registers calculation
Date: Wed, 25 Mar 2026 11:58:26 +0200
Message-ID: <20260325095826.5459-1-bingz@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF00012E61:EE_|SA1PR12MB7295:EE_
X-MS-Office365-Filtering-Correlation-Id: 530d9722-61ee-4823-57b8-08de8a552498
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|1800799024|376014|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: e0YrK6KeXzMZHrIbrCPXBN2jOqxwZWesfENClYmcbCMbDvPuBTbhxkp5ROZWzqJdzUqwh5wRdLfviOYSsWzxOvO9Gl2RPjKBktJkysU8mH9KwtSohA6WjO4g98SsqYg9FA3SGRupllBTW87EYMLA3OoEzSKhk7lfdQRg2ibhnMKiQgN1VYfFvS/QE/Ioxy31KnA/RF1CGo5J1/HjA/QDV0x6tReIAVtWBFbYps9OrgFJCiw6zKly1x6KCzzfghRC8TzLkeVdAMPz9jb7qFumlpBhfyAp5w72KVwUfvyxQeGf12ORKPxFYDPhrNPwEUJyWNPGxfdzNqsd8ipjHTqXdOeo5hiH/ydHOO4lwYQ6TTFcp9jXJEJikG/0jXECXYaU/O0sf84vCgFp8bhlAALL6+1e9Jn0otgp2cPIf6s84H9hQ6iWCf8y0EkPNhH4i5C3cQR7tWnjX59MKjSuz07sLYMWYE8W3W6sgtKpDqRb6W6bE0dz8GN03y24El9BHIxB0Quj526K3ramuycKZGb2LxicHgrTUsEi7ESB2075m/YWmdSmrL05x//goNSBUM55R3pwjXl1sBOKCFzHxDUHsDZJBcZDTrt//Mjw/DPKvBPDrzlDyfvBuIeNLADh9pvGzUzXUwK1YjdqyW1LTLAkHPceyB/8e88b3ipWgrAAqf4u+xLfIt1vQdXN2gp21w2tH3BgqKlh+NBp5P+79wYw/h5QcpKTh/WKd1a438blaoMOydYuUQ3szgvUwFkdpCgSducRrLNEwiyV1RxjNOhyRg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rtqb305tfTRawS7DISmtPCrt11i0sEFq7Vege5qfzDGUNZ1phRMtRhGraVqEfE0XXj4XDP4H7yaRPyArtnQ3nxAlRvss0+SVsf1EFd8Wp5SbkaaJFvdOC308qxAZ2OGcO6kCwnSCi+Rl3/z5M9LTAx4ye9zuulcMUuogHIxT/FUfzbVNnVZow0ejcPj9J7SbEXnF9ldxcng7ASk4WsE8Muw8yAlmwYhHY4mUwyhPfyhkvWkBhLUf8r3hL3wASX+PEz6r/vySols0llzPoKUlK7/fzE0efiUVakwjNgqDyqpZr0B4HPZoU4NDdv686LVMm8VjzahXEzJooZ4NhAVhJE7btq7ALb2lFKyiL/W+KD1BviBiZcbrMOWIAA73uFcLHAaWOCjuRGQS3McjC8BVb9AKWpsgujj92lAjVDWA7qlqtQsU6Ew4ON/+bA+qckO8
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 09:59:02.3522 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 530d9722-61ee-4823-57b8-08de8a552498
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF00012E61.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7295
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

mlx5 PMD needs to select a set of 3 HW registers
which will be used to implement NAT64 flow action.
For compatibility reasons one of these registers has to be REG_C_6.
Offending patch introduced a bug to register selection logic.
If REG_C_6 was not available for use,
no registers were selected for NAT64.
So all the registers' information would not be initialized for the
temporary storage of headers information of NAT64.

This patch adds missing logic to use the last 3 available tag registers
in this case, allowing NAT64 flow action to be used.

Fixes: f15535128617 ("net/mlx5: fix NAT64 register selection")
Cc: dsosnowski@nvidia.com
Cc: stable@dpdk.org

Signed-off-by: Bing Zhao <bingz@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/net/mlx5/mlx5.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/mlx5/mlx5.c b/drivers/net/mlx5/mlx5.c
index d9bc5ee197..70f52df78a 100644
--- a/drivers/net/mlx5/mlx5.c
+++ b/drivers/net/mlx5/mlx5.c
@@ -1679,6 +1679,12 @@ mlx5_init_hws_flow_tags_registers(struct mlx5_dev_ctx_shared *sh)
 		reg->nat64_regs[0] = REG_C_6;
 		reg->nat64_regs[1] = reg->hw_avl_tags[j - 2];
 		reg->nat64_regs[2] = reg->hw_avl_tags[j - 1];
+	} else {
+		if (j >= MLX5_FLOW_NAT64_REGS_MAX) {
+			reg->nat64_regs[0] = reg->hw_avl_tags[j - 3];
+			reg->nat64_regs[1] = reg->hw_avl_tags[j - 2];
+			reg->nat64_regs[2] = reg->hw_avl_tags[j - 1];
+		}
 	}
 }
 
-- 
2.34.1

