Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23746606A319
	for <dpdk-dev@archiver.kernel.org>; Wed, 21 Oct 2026 18:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=Wcaf8PK/
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 11C02402D6;
	Wed, 21 Oct 2026 20:18:33 +0200 (CEST)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012026.outbound.protection.outlook.com [40.107.209.26])
 by mails.dpdk.org (Postfix) with ESMTP id 56AA1402B3
 for <dev@dpdk.org>; Wed, 21 Oct 2026 20:18:32 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=atPam6nugIS6G5hXyD9TGvqbovmlKlRKU4q9MnGQc2seGWmEbuW4J3DHH07OMYlPzXAF6tAd2JpXYJwFWdajD4wNLXdm6p8rEo+KqWmdYKWbzz+LSSNj0pDRI2fZ+m8Lhs1i/mC7pFQ6Xd8k4YMOttPwpmofKrk4Et7nrL7GUPZGVO8OnB9+YfSQPINOFbZqGLDe6OO78vUV+1R+5qvAZs3K74wOqqqWL9KlRkxNt01R1bSd+dIENwFX8SxtIi1jsPenTDS1PUzBf0EGaE676LJgNUg1I3kGcLEuMk3oqbzWlRHPFgHQJb73LMfPo69PbkxomQxGdrfs1uojsBI/Aw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nKkI1PscoEZv+lTgBp+BD/kwccEwl5/+JnXSHCxjK/U=;
 b=Ipu0rsXRZXTlxIUKRyOivZFgKB1yBV9G8ewRNQ2BkjieFrqR18yjKEbzg+IfMsyjKYZWIiTNBSkYTGnG8RAVulg4HLX6uHkjE54AztNyWfOw8/mWpCfH0qXdg2i58xVUGgmnLeBeeXvbV8HcYrDCyWGYDRGemheTr0Illao3B21hF/hPn3TLVHJDIFDNckJiVOdzPHJsWvy78Jr//fRY5mlZWzz4w+nhA+q1zYE45gsdvMUI9D/Yszvq2kfeXnTWbiiNAp6bXFfAUaNLNRydzRuqMI1ssqe4e3WTnJlBlT6h0im627yfCxHVYi81fKYy45gvVrjjiASnELalU0wTnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nKkI1PscoEZv+lTgBp+BD/kwccEwl5/+JnXSHCxjK/U=;
 b=Wcaf8PK/atY4P1S8+0bWIX52QI1pzMMQ4PxLmFx56XzGAlgkDkGxWdGVZvutM6stZ4La6cP5OQ+9m1dm/zyY3kHO9UQ2v30Cef0o/fekOJTGnsmJGcZUvrguWfBgN8pqWGnyMWQ68WWmQiGva4LhheQs3C1z9nGl3Oc1Mdt7QhjM6SiWAL5rqWghsovFb61FNCcuR2UkZfPofb3YjdFERaxb1DS+enRGtURwHMYqRm2Dv5x9uPPmmgqVaYezi15iN7+9dY7J6Hm0AmG6JupTq3PzL9Bn/13JDzeCVEXRJDE2MiJLuvSRRmvmbiIBW8ok+Lk1vEaemL7zWJOnWnmPVA==
Received: from CH0PR07CA0002.namprd07.prod.outlook.com (2603:10b6:610:32::7)
 by SA1PR12MB6993.namprd12.prod.outlook.com (2603:10b6:806:24c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.18; Wed, 21 Oct
 2026 18:18:27 +0000
Received: from MN1PEPF000793FA.namprd05.prod.outlook.com
 (2603:10b6:610:32:cafe::83) by CH0PR07CA0002.outlook.office365.com
 (2603:10b6:610:32::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.15 via Frontend Transport; Wed,
 21 Oct 2026 18:18:25 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MN1PEPF000793FA.mail.protection.outlook.com (10.167.249.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.546.15 via Frontend Transport; Wed, 21 Oct 2026 18:18:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 21 Oct
 2026 11:17:59 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Wed, 21 Oct
 2026 11:17:57 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>
Subject: [PATCH] net/mlx5: log Rx queue CQ number
Date: Wed, 21 Oct 2026 20:17:38 +0200
Message-ID: <20261021181738.1385097-1-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF000793FA:EE_|SA1PR12MB6993:EE_
X-MS-Office365-Filtering-Correlation-Id: 540c38db-7db8-4308-1e2b-08df2f9fb2ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|6133799003|10067099003|18002099003|11063799006|261009223027099003|261021121427099003|56012099006;
X-Microsoft-Antispam-Message-Info: Ih1fELlw6Vs5TZhnXUFWq8CAhMNk51IH2gKqdFtMa0SdqwIcDt9RqEhNBGM5J6A17WPRGfK55CxmXjPM3Y77Z4s5SrTyHZXLBbE/tUkm5X2V43nxGpplIo3ciqJRg1OVYWNl1P9CbgGzDh5cUn7UyIZ76dvPRXfItJ5WVUZBGPLhXKq3UIJzqgO89DAttuFsHck/QWdjjtPotC+qJJ8VG5hTziR+77PqUrpG6AAv6TdtlN2O19z4uYUt+UZ8hiDZrbMA8HvXyNv95iAd7NCqB9oEw2BD++z5bUc8JHU811dYTIMo+zzJ3pDEkJYmrjYj1B0To9WAfhTqc9XnAoXqWMUJjAc2VYndHFJpfiJK7QzRrziOH6INcxOiCzses/GMv6xbCDBXSB7iv7+xqtrTJG2vgSX0xQp4WyqlWsfRAza4yiaudb5Dq0gWah8zd4QNFI9nyjBaMIzgKhAZ6cICWkpTcKs+5gmtc5NErfJjcsajFs96ITg1X6CHq2mlQf0YCx0OdhgTrpp9v8qRoLGI1CqDZDwP41rYuTgRRagOBeFu7h+2XnneZPSxKpoWnbBWSmyAKc63vMdgPGpbBGhrNMfYFMCzreJuvv6mSKTUwKvKbUU4n05EgjKjr9IBph3UpZyEnZc48awkZJ9HY3GtRGS/jZ2UC7ZRGmkyIiOs/ZVXc18Jq5BNvdtrLp/n0EbcmPa35on5sug/RX6BY6N7bQ==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(6133799003)(10067099003)(18002099003)(11063799006)(261009223027099003)(261021121427099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dmaeKxMqfhOxYlUSA//k+fr+UO5Fm7d+c+1IKLTJRbQf1e/di+GiNRFeVGTUuAQJPy3YI7jCDKtz0D50msZT8o6SV57BghD6VEyRtimoOL7TjA1l1RnkRlVGWBUNzmDSaSnH4BM+b/LeJEgaHorXNW2d5X/IxX/U0hG6A6P5jzUxVT/rA8wTiozxkwrO7iE2g5SkKkY63ZEF13CVQ/oohAUfNqeM1qYqVGRSReZCS/lru/piL++C8U/P9cnoETuyw3uzJ3MUmWGdPfvc3meB8y1jCC44ou1y6JFvLYZYtqaKtQXuNR6hv58chUR089EJ8f9jp+07G2P57nqUf/L5oeb1P2gtBftno3h2xrdAdsU5vNYDEeDqbbnAdTN2xI8V6uSZerD++moYW9sJzQraiH8s/WAEqIerAkS5XWKlV7hScQei5N4XJiscravhdjoD
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2026 18:18:25.1907 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 540c38db-7db8-4308-1e2b-08df2f9fb2ab
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF000793FA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6993
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Log CQ number of the completion queue created through DevX
for each Rx queue during port start,
to allow easier debugging with FW tools.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/net/mlx5/mlx5_devx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/mlx5/mlx5_devx.c b/drivers/net/mlx5/mlx5_devx.c
index 374d15a07c..bec0aa8ca3 100644
--- a/drivers/net/mlx5/mlx5_devx.c
+++ b/drivers/net/mlx5/mlx5_devx.c
@@ -526,6 +526,7 @@ mlx5_rxq_create_devx_cq_resources(struct mlx5_rxq_priv *rxq)
 			return -ret;
 		}
 	}
+	DRV_LOG(DEBUG, "Port %u Rx queue %u cqn=%u", port_id, rxq->idx, rxq_data->cqn);
 	return 0;
 }

--
2.43.0

