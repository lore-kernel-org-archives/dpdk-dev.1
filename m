Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D93CCF9EB
	for <dpdk-dev@archiver.kernel.org>; Wed, 29 Oct 2025 09:56:44 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DD47C4060C;
	Wed, 29 Oct 2025 10:56:43 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011035.outbound.protection.outlook.com [40.107.208.35])
 by mails.dpdk.org (Postfix) with ESMTP id A770740288;
 Wed, 29 Oct 2025 10:56:42 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DoowKpfIJ3GfQv2q6k6xgSYbQQaxMvIyGklKQK3onvoWtmNypTG6RoOMY1jZj2AcnZY0VgFWamgXEF/5MttlMoQ3UR1x9WOUVt5XiJM7uaRKMkUzztP2Sgapc7f8kcdQEVnJOCt5VQkzq+4eWS7ZF/+uGcduu9g2H9Pi8ZVjo5bF3rhNMAD5PCiEWVG3sgnPw5GVq2s9LGEt3L6OSvUMXtVHfdPQBk7o3A1Z+gOIJlZVL/clkqGG8QqgjBuPaU99FFlmumczA6F7hJb2tjbKf4JL7YNmUSpQ1l1dePauIdFG0FMu2C0weDANcXCZP8q2XvhzXrkh6sOnRoACYrXJwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5VhcmNx5RSSf4nPxB9BsSQThBFNGcDPTRLYd0kt1pYQ=;
 b=Xf2gC2B4qCMQd+JG5lDRxF9CeaXiwvbmwxAUybu7c83doaiCp7mzfvOyNbtfGF1Al2E93I40SoOsDqg5XA35XNbyn1eeSfWElWbc6+kKlE6CpzDlJ2glRwLmihsTa1M1iQDe5iIAOXNeTJTRpNat2LZR3ktonn69tklWcP1PtQhFNNQ++pziAhdACi/PJiPelfGMJogwLCl+41kj77LT5uggqE+hTp63t3EjdSMVMzMdXgEbs9XvD1bE9S7OE8LdEIw2OTIHRlXoc9Cmxi591Id2YUuD5HVv66gRZRH9ONkw+mBg4UV22LTzPl+ijVFMUbSSEadMTIvQZBWQtMVSjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5VhcmNx5RSSf4nPxB9BsSQThBFNGcDPTRLYd0kt1pYQ=;
 b=KrUE3yEdA26/bxP0iNLXDNSj8uHvWFjZqlt5J6lMB/x83PIfSAicyEbIu7gzvZoBOxWIY20at/wzkNWnhEMTfOhg5FjWyV6VQZbQsjQvsOcW3G/7jr2/qisHWPHT21aRrygm/XXOaj+SrRUwwB1qv8+mt9DCLeRX6WePw1xTZB00rD2+ZwJS6RauOTsWtTJt39OT1O5cGjeCW0dm//J3rKC4rm85RWlcL2gIgotcJP5ButQnbqFQbkd+EXjoC3ySwymEGDX5NR6Mfj5j+gTjiKg5dbIEmzsaiXZWuRhnCAlqOelCRYoHYDJkDuZanGK3ko78UBv+sUCO9fFj+S0kBg==
Received: from DS7P222CA0004.NAMP222.PROD.OUTLOOK.COM (2603:10b6:8:2e::14) by
 SA3PR12MB9159.namprd12.prod.outlook.com (2603:10b6:806:3a0::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.18; Wed, 29 Oct
 2025 09:56:38 +0000
Received: from CH3PEPF00000018.namprd21.prod.outlook.com
 (2603:10b6:8:2e:cafe::1e) by DS7P222CA0004.outlook.office365.com
 (2603:10b6:8:2e::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.13 via Frontend Transport; Wed,
 29 Oct 2025 09:56:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF00000018.mail.protection.outlook.com (10.167.244.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9298.0 via Frontend Transport; Wed, 29 Oct 2025 09:56:37 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 29 Oct
 2025 02:56:23 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 29 Oct
 2025 02:56:20 -0700
From: Gregory Etelson <getelson@nvidia.com>
To: <dev@dpdk.org>
CC: <getelson@nvidia.com>, <mkashani@nvidia.com>, <rasland@nvidia.com>,
 <stable@dpdk.org>, Matan Azrad <matan@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Moti Haimovsky <motih@mellanox.com>
Subject: [PATCH 1/2] net/mlx4: fix unnecessary comma compilation warnings
Date: Wed, 29 Oct 2025 11:55:03 +0200
Message-ID: <20251029095505.100582-1-getelson@nvidia.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF00000018:EE_|SA3PR12MB9159:EE_
X-MS-Office365-Filtering-Correlation-Id: e727155d-40af-48f4-20e5-08de16d173b6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?E7P93ZzlH8tKyMxDotM7XjXjzfeZUHMHTVd/npdbWNmMvnKMVFhbQIW4Bn7A?=
 =?us-ascii?Q?c4HlQT4Y31i3Sp+dUWcBQ9dm2TwGBq5OSl/CowQMUx5ZsQisExI9eczlsmFp?=
 =?us-ascii?Q?CdSrghUyamH1WuXXm7g0bas01eMVVm9DHEmGSMk5TIUDUeN8vTt2G4b35yxg?=
 =?us-ascii?Q?+XDB0vpD01EsbuyU59LogF3+ZJePahDXxjq4T4gOlXlHtaVClM/HSoSNpVB1?=
 =?us-ascii?Q?tBR+m3RdPityJYwN5fyp+H/3OQbfyc7B0Df1scJX3fnMdzdGdF1a1gP7MKqL?=
 =?us-ascii?Q?pBiwEEZdGYow9qyBw4ytP1sJwykY57poD6CNZJedXKi5+Fx21oLC0YxeK+Ws?=
 =?us-ascii?Q?/5iMCmPl39frjdJ1M1afDCsm19iVXZ0he4B/U/1CabJlw0QSWpyqKS5N/uh+?=
 =?us-ascii?Q?ULMm9HcrqzSxQk5iDXfmqvdnigX1Jj7LptQiJ2aN6Nl5Ta91KHeLsHBgvUmn?=
 =?us-ascii?Q?pk/DW2JMWa6VCT20jq8G4GSdTQ4EJJPWtwwyh8PyG9utzcnSgk2uyIxa0UeB?=
 =?us-ascii?Q?CD56/INLFkwMjUDEBhQN7C7BwTw+Ua3M0YeDEfP0nBdt3RqphsEqX2TeXC6M?=
 =?us-ascii?Q?oTZJOwKKziHblTG4fUdb57qxNfqliRpHXRRpJvi694mFNOj4Fvf95zPma9bT?=
 =?us-ascii?Q?ObXtjKdkzLxhsuMImPwYkvyml9g5ApHdfrEPM8UaFFAIVUplZN3X7wbGn2xN?=
 =?us-ascii?Q?xXkktfPqZsFxQqN8KIW9Hflwzr8CEBQ50vuYQyD9LVq8ub9o87X28mjuiDIW?=
 =?us-ascii?Q?Jlkkj5xZspI4guTACL5my5NnMsTxS66d2z8hXHTViimEB9Uj97hWPJxdva+1?=
 =?us-ascii?Q?lPguvjQC/99M9uDhALz0NS6BZz9R1Bmp5RsyMcpo99uB0/jUXmLB/iGwBCte?=
 =?us-ascii?Q?2WkatyjOCu3BdFhfcoI8Ad23wQOk181a4w1GIIExwxAOabdeZKiXaZZGGYYE?=
 =?us-ascii?Q?TJz5CxfvauhhyJJU2LZDAW06Y/hfcOvHcTRWtBlMYAoZtmzO0jqtYQO+dJOD?=
 =?us-ascii?Q?WJ+cJR1eCSDrqwLVLy3DaoWpGZqXYl0vaiuyP4QgBZveWKFQM0/Hc4DQiNQw?=
 =?us-ascii?Q?5lU2S7d3TRuEPZVz+aM6xXgTUgu99kkEvbtH3CPqb38TZ/Whdxsm7Xo3yTiP?=
 =?us-ascii?Q?SvlYb/qfrdr1L04clrs79cCPwip6acCSRvvYYCGvpFX/41vwx6TAwCa0kiGY?=
 =?us-ascii?Q?y5qa3wFjK7Npq3qy0Y9ajeJJP4/4cqMkfOsjfCtj77xTCN5dU+bceBJRbzUT?=
 =?us-ascii?Q?OEcNccUR65uSnGvFz+44GOXaxeQ4sbJSrgH/eKkquy+C8a9vrkBqRgtD96QG?=
 =?us-ascii?Q?gVqSLL78+J6MqwGLPH/+aq+H5Fz/zuAUo4O0EDr2wsRarLPhgzRCzlQU4H4k?=
 =?us-ascii?Q?TtqIdYOFz32msPhehuch0eAi64rK9Pn2eEyuphS74Yjvi2SeGZoSV4mGEEFf?=
 =?us-ascii?Q?G3wn3pyeELZ9S5UfZj+2KT8rSShmOseppPg1MRApVpRB2uJnl57r8ZW0Tywl?=
 =?us-ascii?Q?A0elmRY5Lca17yXp9m6sgJzLOyDLt5Y2boTfn89w5sqBaITgvLKv9QKHTTPK?=
 =?us-ascii?Q?OI5P+mWzm51jq71aMzY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Oct 2025 09:56:37.6873 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e727155d-40af-48f4-20e5-08de16d173b6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF00000018.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB9159
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

The patch fixes compilation warnings produced by clang -Wcomma option.

Bugzilla ID: 1810
Fixes: ba576975a89b ("net/mlx4: support hardware TSO")
Cc: stable@dpdk.org

Signed-off-by: Gregory Etelson <getelson@nvidia.com>
---
 drivers/net/mlx4/mlx4_rxtx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/mlx4/mlx4_rxtx.c b/drivers/net/mlx4/mlx4_rxtx.c
index 947cae491c..a4df6f7bcb 100644
--- a/drivers/net/mlx4/mlx4_rxtx.c
+++ b/drivers/net/mlx4/mlx4_rxtx.c
@@ -638,7 +638,7 @@ mlx4_tx_burst_fill_tso_hdr(struct rte_mbuf *buf,
 			thdr.vto = sq->buf;
 		/* New TXBB, stash the first 32bits for later use. */
 		pv[*pv_counter].dst = (volatile uint32_t *)thdr.to;
-		pv[(*pv_counter)++].val = *(uint32_t *)from,
+		pv[(*pv_counter)++].val = *(uint32_t *)from;
 		from += sizeof(uint32_t);
 		thdr.to += sizeof(uint32_t);
 		remain_size -= txbb_avail_space + sizeof(uint32_t);
-- 
2.51.0

