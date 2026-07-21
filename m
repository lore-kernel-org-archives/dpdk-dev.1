Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE72C4451C
	for <dpdk-dev@archiver.kernel.org>; Tue, 21 Jul 2026 12:14:24 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E9E35402A7;
	Tue, 21 Jul 2026 14:14:23 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012066.outbound.protection.outlook.com
 [40.93.195.66]) by mails.dpdk.org (Postfix) with ESMTP id E787940294;
 Tue, 21 Jul 2026 14:14:21 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asR9BdXF7lC3c02UzxKY6J65nZmZwCvauObdfMK00joXFp1XawbOvt7ExFcYLk6G70mf56fHdtEkYJxNwQIrJCWt4/xIjgcgr+bi+zlbk3wU8MteU0o6npO++J0T183sPTQcr+BnpZQ+55cZ+Dx+kxpcCU7kmjncNhq5yWXbCfKt4fwm6Pik4FD7bJCFNwodx0JPAKGb8PbPEU5zSvFYO+yJYtvARIcNMEFEDzz8anpnS5aLAn+6NnoZ74hhqIuMnx11tHo0cUez0ldo4VFEP1IuJ2/vVgdp2H/whJdXLGjm5m71okwSsHSkC736aASUJmB5NfwktcNi8X/UA4qvDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=egWvBLBKexfQ+i06yO+XTh/HTZYalx8ELqqC+RYWKpY=;
 b=jyDrI2vPxP/UGYlbhgns/x2Hb/4vWMrM5mdhmb1eMIdME5WYZaAUNTRFgRwsSha24//t4tGko9imw1nnVgUtegCdlYhlbtepg5jVDTAicYINEK8KX2LVokfoFReSrVyk9F1pyycGaIiaX5dlIbUIYjpSUSC1ZeyerExuVq6zhQM/out3Wx6rsFPhOHNPwS0ZchqsKPzddHnp+2OB7uluSbINy1a9xIiFaXyFld2JnX7pnt16PUCNi5jl9oHscUmkXDK4YPxL5Lx8fXbkP+kH1NEcqb6wuRHDnlEEtAkyf31zOjT90XbxzwtxrMMMm7PwwCTzdF2xjqRCtq89hHFm0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=egWvBLBKexfQ+i06yO+XTh/HTZYalx8ELqqC+RYWKpY=;
 b=Q8iwVtVEx9ML2iv0yHDW9HcE0+IrAWX2Pmp4DPW9v7Ef4SzY5Os3IAENOSUXKkQjd8+yA03cmksyzCisav/sLYQRMplBviyrTp7CKj0N5CU3cS9TTezfAlF61ZhtkHDvBT+s6jZo2SiwbHLSzHjHs0dUBsQCWVZXibafI1SPgv+zzBshgDBYAZpDIZKfad+fhZgPi+lIWEdL5nxajQfYmFYDVjgrdrCKSs8P+/WZAXzohjCtBTgR3FJ+DdLQVImZNgag4bETCY5Le4SgusIEP0cRtLllgzoYmtK5/+1nndsp2CpIrXp3osImJ0HWfU3v9hziLhYxiv6RthROy3Z2yw==
Received: from PH7P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:510:338::27)
 by SA1PR12MB8946.namprd12.prod.outlook.com (2603:10b6:806:375::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 12:14:17 +0000
Received: from SA2PEPF000015CB.namprd03.prod.outlook.com
 (2603:10b6:510:338:cafe::70) by PH7P223CA0006.outlook.office365.com
 (2603:10b6:510:338::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.10 via Frontend Transport; Tue,
 21 Jul 2026 12:14:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF000015CB.mail.protection.outlook.com (10.167.241.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 12:14:16 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Jul
 2026 05:13:58 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 21 Jul
 2026 05:13:55 -0700
From: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
To: <dev@dpdk.org>
CC: <rasland@nvidia.com>, <matan@nvidia.com>, <suanmingm@nvidia.com>,
 <dsosnowski@nvidia.com>, <stable@dpdk.org>
Subject: [PATCH] common/mlx5: fix overlapping memory ranges
Date: Tue, 21 Jul 2026 15:13:37 +0300
Message-ID: <20260721121337.1608660-1-viacheslavo@nvidia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CB:EE_|SA1PR12MB8946:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bb722a5-aafb-421a-dcc3-08dee72195fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|82310400026|1800799024|376014|36860700016|10067099003|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: hpbhWTHoqMSGt92r+st70CEvL5YV53mfw5qDFmja4z3Iwm+RVDD/3EUOpz0zGqviakSJDY9yO3yfEgp+vR3uTDheihsrYQ4CUApa+Og7wRNk6E/MWBDzMlWC/TJpIdeG//G7UAD2S1gfDYBcwrtARC/zUQQ6drdrTaalkPurxCDjOux++kA8is/yr/1RFmE1TTFvUdIp9osFguEI7OrZjW8/SPslwvxDLLkXu6JzvzNdwGJ37uiYTe5JvQ779mrLe66QKd775WWY1E/E2ukJXqkB+Q7pIT9la36AylfugeJmofEwzLiz3nf4WJNaOXs8UM80a9Pq+fP5MrbF/2OHTbLo2zaihJT/OQFTRD0sMwPxNPtN0bZVtfLJoUHnwLwTmBMi9cnTveSss55Ty2df6p0jFAdgeZLDMiuah5f2Qz1RTgbYCVrvOqW5fNPaFx9FNDvrjGWTx+Wy6H1umVQXHxNxirQkj/qzpvjRJD7ics9v2U5lA/TFgJFERb+qvkWaW6H+tv+K4V2vt3Cc7s+8JiNYvz3Qkk6jIpoXsG4XYWP6hMCgZopps9SNTcIqY8EGmQzHOEhNk3aEuHCY6f2RE9VE2RF3ysh/1iHpKM6bt+SLqO2zRWBJ59JfPTYodCwVkkvgQ+vXOggW5S4Zk0M1d+RktO34YR/x4kCE5HmP4XbgKPtyrNqcZ4GrGDevWal75svLHwuAqnQcFmB+GOfWGQ==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(82310400026)(1800799024)(376014)(36860700016)(10067099003)(11063799006)(56012099006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: w+T7Ub+p1DvZdM2wrAO1Zafy8MVNStbbCiZXLE/3hPVwRDqheD+2bqcw/UqDdTpFqOqU/Cbht71eUWbzYoUdy7wmPe9JV9OKWZ/WFQR4uBnugfyhhENmawlly0ZeMumUV0/uoz+3Nu0yNJK2NaMtmJ39kx2Ybb1MxeikYMm30M8UsqJUjIlPtk0BOxcNN4f0SkffRpucMoFsEITpV9Rj8UWh4y9/pRnplHFOF45F9ST3nuWHozKJobQwDoZucMvISTRq0+WJiD5mBQqnFQstJnXN6ruZ8wLsQd58TxNR8oC+L6d8JXJxxpPTKrdimlGA6XN3kj4ak8GyFdgsq3szYcNihtXhX+G+/rE3JjgriXgy04rwyCkLOUd80IFYZsWsDzN77kaxpe9Ynh2SQWg9enFq7g9JO+XM299zdRjTPkFC7RyhuQJOgHKbVrF5GM+W
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 12:14:16.7994 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bb722a5-aafb-421a-dcc3-08dee72195fb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CB.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8946
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

The mlx5 driver requires special objects named Memory Regions
(MR) to perform DMA operations with network data. The memory
pool(s) is used to provide memory and to cover pool addresses
the mlx5 PMD -pre-creates the appropriate MRs on Rx queue creation.

The pool memory can be non-contigous and split into segments.
The PMD created MRs on the page alignment segment boundaries
and it could cause the overlapping MRs (in case if the end
address of one segmend is aligned to ceiling and the next
segment start address is aligned to the floor).

The MRs overlapping could cause the wrong MR fetching from the
cache for the mbufs in the overlapping area if the starting
mbuf address falls into overlapped area and raise the
hardware memory protection exception.

Fixes: 690b2a88c2f7 ("common/mlx5: add mempool registration facilities")
Cc: stable@dpdk.org

Signed-off-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 drivers/common/mlx5/mlx5_common_mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/common/mlx5/mlx5_common_mr.c b/drivers/common/mlx5/mlx5_common_mr.c
index aa2d5e88a4..e968e928a1 100644
--- a/drivers/common/mlx5/mlx5_common_mr.c
+++ b/drivers/common/mlx5/mlx5_common_mr.c
@@ -1504,7 +1504,7 @@ mlx5_get_mempool_ranges(struct rte_mempool *mp, bool is_extmem,
 	qsort(chunks, chunks_n, sizeof(chunks[0]), mlx5_range_compare_start);
 	contig_n = 1;
 	for (i = 1; i < chunks_n; i++)
-		if (chunks[i - 1].end != chunks[i].start) {
+		if (chunks[i - 1].end < chunks[i].start) {
 			chunks[contig_n - 1].end = chunks[i - 1].end;
 			chunks[contig_n] = chunks[i];
 			contig_n++;
-- 
2.34.1

