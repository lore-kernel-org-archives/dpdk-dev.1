Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD4BAF54ADE
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 17:11:06 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 05A464025F;
	Tue, 24 Mar 2026 18:11:06 +0100 (CET)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010027.outbound.protection.outlook.com [52.101.85.27])
 by mails.dpdk.org (Postfix) with ESMTP id 27DC14021F
 for <dev@dpdk.org>; Tue, 24 Mar 2026 18:11:05 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WjEmyTY75zDomaw0LieGTH+9/MSwU3NLwURYMiKq8+gfqgORQpzMNxpMdGwYJV26IlB+K8rn7QHH0kguozBjWkS/Y71M6EwpA+s0vsDMO+IGMHUzUIqc0KAdhGbgEYharnpTD/3yAj6OWDlCS73g/UIX0yWZW+DPlCDEMSum4c7YAin6BL17K0ITsLNCVFsCPuoxtb+2XsYPf66Tj8vxcp+6DvFcsN9nY8W6ALAl0TrcXK5fZkbB0YlFReVO+XUHGkeZuI+dfsHy1fw7zQbbdrh/6/dKDBaOq6LOi+VSek/NWrwU9hnNMV0+8dnpc1FErDHA/MyIsimyvVbC66xfJg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ofLpL0OFr0qzh90fP6EroRM3kc8sHbTW6cpE8+xU+8=;
 b=N+02er5fSQ/ip6pUC2YBy05/qROrQutdqrW9fs7iKw8dS+oEwp6cbLBccmUwWahb58GkqhNqL7zWtV/rb0CLx/LyiELCzEVJm7vHtTDNefVmSCJoK5PXSjbt/tZ91vsPripmAh9Pvtpw0hN3G+leRKdvlj3YjrmtyWAERgI3ZUy82IHJJJGetsNa/Yuv2vQmHwOHCQxKdH2bRDbGnwqINcDae9Wo+mlaa07t4PP/sOe+i6es6yeCzJ82AA3Xm4Glx2B8RcwI1Psc3oWyBz5OUDI6m3yA0c8GLvbmjDh0k79cIVP7OqHO/K9Vqqiv08cgUQeuQYQmeQZvq37lSqQ+dA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ofLpL0OFr0qzh90fP6EroRM3kc8sHbTW6cpE8+xU+8=;
 b=ryyqOPSxAfk+AMnCSHnz+nySncacRVFMuWr8zHq+oErjt+6xqSucpl0CIYH/iHPjPjBX72EUpm9owkPzV7Uv1HqapX6HlQdUZecDuIBu6iwZ5GhivBS8g5jeBF8edHrsDyYVqLKEqFzi8xtwIPqalOt4sF5JtRI9tBYnDrNeT8uXvhaxPCMUFLExQN0dWoD4WW+DQKQOfK8ahe8mwQBH0T5fxXf9A56Ge42LGUlsMxhxtoi5yOT6UV8okUm9MYH8IE4Ow5esYnoxfJxhfVjvoTdGXvCNH9Jb9Ts7Arff1gRNLbQdFzgAM+QjCipS6ngl16HdOLLYo/93VNhPZVIMHA==
Received: from SA9P223CA0003.NAMP223.PROD.OUTLOOK.COM (2603:10b6:806:26::8) by
 BL3PR12MB6596.namprd12.prod.outlook.com (2603:10b6:208:38f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 17:11:01 +0000
Received: from SN1PEPF000252A4.namprd05.prod.outlook.com
 (2603:10b6:806:26:cafe::35) by SA9P223CA0003.outlook.office365.com
 (2603:10b6:806:26::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 17:10:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SN1PEPF000252A4.mail.protection.outlook.com (10.167.242.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 17:11:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 10:10:44 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 10:10:42 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>, Raslan Darawsheh <rasland@nvidia.com>
Subject: [PATCH 0/2] net/mlx5: small debugging improvements
Date: Tue, 24 Mar 2026 18:10:26 +0100
Message-ID: <20260324171028.26727-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF000252A4:EE_|BL3PR12MB6596:EE_
X-MS-Office365-Filtering-Correlation-Id: f3055af8-bfb8-4bc2-946a-08de89c85295
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: Iqm6isHJ7AZHoBcEWjImivghcqwDk2LskqppawEsqo/gAjqlitYMXl19dq82ddYbsb6W8waR9yq9PganmvoeyvqulrrNGQEvEETLRLpNxwLluMmMMG9ffuDVinCPnTLjM864nQu/mA1Is7WFFf330L0VSCshFdQbI/5HnwkoMYaH/8ez2gpRCl92R2VDF0YtuLba6PwJO4YXLieEvl9Quu2+1ZwWHJEOKVM1gSQjL0bmYMx4bMNCmZ7EZdxhaCh9mXsuUHipNMG8VCa5oOoJg2DRa90eFmhwUUjAWNGmirxWEFiJWkhOTUOXl8ZhgwS4lRiYlaOX43fYanKZEc/5+GjoTpKgOvBPIO5IfdPaC2drxWZDVIONfH2/UOQS8LVufafwXtnxztQF5KTO7lVfsbodhZd1g5GOyqaU5STDtJ3Oos6lVDclyyhHJFTxxo+H41fkFROHMckhaZynhxdXyajbUnd0kvKqvApMtTj2UjzF3cpuNhJw+ULx1eD0EVl9dBUK06KzY2EzIAFQUvGuBrqYU0cRps+oTf6Xj4e1YAzuVnfRS4IkxIoBMQ3p42eV4w6fngeQ0wZpvBsdUZYiOI5gJRhn3xOWVyqLoC7lUSFBVSjPY2XPqmu66FWCxioYQKT0EDIe/gkQgjPqSZQc13pWs89baocFFop6GFSuiDim9rtJlHGJHABxlNnccDugC1o8EydXIk6XPcX6iARx2JbCU+2uORwydKf999UOMR/fYFdZNi2YWBXkaHuUuTi9QsUvoCQsYAYvvXmhhZGP8Q==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dMKRkvnDo/cAOwMSDKPS+pUcLCLdkChjs6a2RUQPuD7yNArScggfY+BnNOQKb3CCqIxcq2KAALAoLLBdDb8WWKHksoOD/9SVwHy79VsxiKt1IqFUNCX1yao+ckI42u0v+iP76V6QSvQRkGn7iErhdWL4LG3DHNIf5yd/uKLcfJCMcxU0CgMb2GlJhaNPYhqjmhBa3zJrLuiuxwurgscEP9iCfk7FfM7Vssgb7apS0q/rmmoMWF4WHAAndsnyIA7C/fsi3VXEdZeemMo8K+b9LU+iSA7bPmsMkPyBI0wAb4wqndjPuaZgKBO2O6EV1GSZUEJClcT4QGgQcdftL67J1aSF7XDKrPvgOHH8zx2PRf8bCe5PZ4fyTwUr/9vefBhtPpMPx5GNYC2EhVPAw/Y5g62xcwchEpibbZwp/royyJo+hZa8F0I9N/47ickeD7bF
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 17:11:00.3748 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f3055af8-bfb8-4bc2-946a-08de89c85295
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF000252A4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6596
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

Small debugging improvements for mlx5 PMD:

- Fix error logs generated on failure to modify SQ and RQ,
  so that verbose FW error is printed.
- Add reporting share group and share queue ID
  in mlx5 implementation of rte_eth_rx_queue_info_get().

Dariusz Sosnowski (2):
  common/mlx5: fix error logging for queue modify
  net/mlx5: report share group and queue ID

 drivers/common/mlx5/mlx5_devx_cmds.c | 19 ++++++++-----------
 drivers/net/mlx5/mlx5_rx.c           |  4 ++++
 2 files changed, 12 insertions(+), 11 deletions(-)

--
2.47.3

