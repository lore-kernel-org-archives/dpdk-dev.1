Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8546AC43458
	for <dpdk-dev@archiver.kernel.org>; Mon, 13 Jul 2026 11:15:56 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4A155406B6;
	Mon, 13 Jul 2026 13:15:55 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010007.outbound.protection.outlook.com [52.101.201.7])
 by mails.dpdk.org (Postfix) with ESMTP id C6E3040276;
 Mon, 13 Jul 2026 13:15:53 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gxmzJGxmO4iq/2sW6LfQxAva5Vjw15PNhdnw2G2iJQdTneHRdzaLdbsefoUIVZtmOx7MrTVKwTTZ4jZSFTk463uyxqRgvv3f1m47pdfdd6mE7gwh4hBmBOi22THIOZn79121DHwoklMfFVS9lQf9a1iSn160bOqR3FTKWUA1GFVABAjFRa14WEG1vJqyzpvh5A+K+hkM9Wm4uQnYlRfDKdrb1TSv0f4t+7Tsn09ANgZH+ToD8CCyA/3SiqEAhHypgMXblEplgPvb9e2qTPaHKK1ZwWDuiaRuniBcoIu3Pi5poQFlY4/Ac0GkIVb0IB88bJTfRQoMlYB/+UH00aGakg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Wqv8/OZbcgwUjd4R2gfjV5thUhwjP+39g9AaSo4m1gg=;
 b=qghRm8o6XlGkgepd+hxJL6rRajTF1i5SjGI68U1nYbZ/0FoKRaeEBxpjhNAFcGA2qpYXYZIu4rbTKVLI0FXmKygaXokU2F49DIM/iIZf6gbCSu5XJoHDs8NOMleBtbiT+VT6V9ObdAMFt86xN/5jHte5dokjDXsG+HU47GNeJdcCYR/Ob9LWdq8tr/QiCg+rUbFNl1/H81cNfQYbTYcIMgDC/cAKlpHXbypLT9o6DS3crL/VVedu4UMUC/aNmrIRUhmY1joo2yBMv7Xap8A4hAN/yCgUDUhPFr7aLuE+lLGfrC1xGXJc6vV8sfowbkk/eph8fpnQtlQQ9G1CUNXGCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Wqv8/OZbcgwUjd4R2gfjV5thUhwjP+39g9AaSo4m1gg=;
 b=PvjVF8IESFX++eyDQEaEQpksEMmrF+CokBkojsfdkbTYhTmSCHCI2kU/+0thVZJZ3yShcs0pGUjjEmfLAQ3nSNNZHxEL1pMvfV8L9GtBOGPqwbAQT3SQCnjt0YXC243dJnypd/+EIDrlG2jfn6KpFn6K3v2O/dNCcOVILMcDBJEvG4JS5YCrDA8oTin16KT3ExDJNjFmxBm8lZiNF61VyjK9fUIjK3Y+60sRdz04eiJRtSze4ORX2O5LHh/sEx+ixb7K8xr9hba3ITNbib2EXsQLNHVnCl9tdQdPLLRCP8qiHiuZll4WhmcgKPJVnBERvRjD6zVsxeZWsGrWAk9wCQ==
Received: from BN9PR03CA0339.namprd03.prod.outlook.com (2603:10b6:408:f6::14)
 by CH3PR12MB9194.namprd12.prod.outlook.com (2603:10b6:610:19f::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.202.18; Mon, 13 Jul
 2026 11:15:47 +0000
Received: from BN1PEPF00005FFF.namprd05.prod.outlook.com
 (2603:10b6:408:f6:cafe::5d) by BN9PR03CA0339.outlook.office365.com
 (2603:10b6:408:f6::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.19 via Frontend Transport; Mon,
 13 Jul 2026 11:15:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00005FFF.mail.protection.outlook.com (10.167.243.231) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.223.9 via Frontend Transport; Mon, 13 Jul 2026 11:15:47 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 04:15:30 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 13 Jul
 2026 04:15:30 -0700
Date: Mon, 13 Jul 2026 13:15:25 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: <banoth.saikumar@oracle.com>
CC: <viacheslavo@nvidia.com>, <bingz@nvidia.com>, <dev@dpdk.org>,
 <stable@dpdk.org>
Subject: Re: [PATCH v2] net/mlx5: fallback to verbs for Tx memory allocation
 if devx unsupported
Message-ID: <alpmogwsv3466g33by7pyw4quhbbu27l3ieqgiexjvqj2ebux7@xuevtradpj73>
References: <'20260323113403.1984-1-banoth.saikumar@oracle.com'>
 <20260630102311.1050-1-banoth.saikumar@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260630102311.1050-1-banoth.saikumar@oracle.com>
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00005FFF:EE_|CH3PR12MB9194:EE_
X-MS-Office365-Filtering-Correlation-Id: 118202eb-7dbb-4d9d-79fe-08dee0d016ee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|23010399003|22082099003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: HK0xnqU2nPpnBAUxiCIL7Q6T0vfa3VUyWeR0Zb9bC8oPH9sdR4vGgBJiDrhCW40ZeEdxqQEz16cFbEi6vGzIG1IdeqaSDNyQeescm/RymFA88aIVF8sReuz6i2KP8GoDWu2HNTAM710+pAdzG8rNNLNjs7zfVFzzZ1BhOo3iwCbMFjbLzpNtsne16S12m96pKia30KV6d6SVNQQRSFSIC8k5IPINPGHa1bKeBY/Tz4lF7wtqBPYu6KmP/JvofNzLrmpPHJzO0J1+GCNQW32S98tVKAMYzr4BuNagqWLt1ChF3SlHF7+f3pdqy9GmA6GBcIWOJneCETzgDCj+RzYSenw/BAhbiT/NK0MPtr+573tzKtkcqmNJi0kNqyWgnh4+/OnkQXnu9rta032R2dzueRWBHrqvdCXM+ho1wsGhYrPAupeg7cjwfIA5JY8UnZuzR2vOWRjDMcgIIxIfx3MznAxfTjdeXQgIiaPGqdbN/E/06eefiJLTrCDXYYXvbIY1brxcVuMjulpMkxFvqzbbdyTr+wAVCcyVNLIYv4T9DbwT0X7t8l2bbFtblABKfUm0Yj6IshtxLhg29XuB6TJgka6G6dsDI8WaU66VfPKtgfhzs7kapoip4t+3x2FxB+8DTEoBBx3sVk3qyp6f/4Iv1t/jFNMV6v7ZtdQq64k1p5O/mzDjFcgFoUE4bKdmSSN4Xz/FOop7HGYenAlfZSq+ig==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(4143699003)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: d07HtGRQBAY3GGNSm3edpd1I0V91/TGtnAUPOCCbRctcRngywdQY0UPru2dqnmI3rvVk56v0FGgPVFep7mtxJFJSPWkLSWl5H6ZUqPcd63HpegcPHZngaW9LV4I2SLUgQGTDLH2Q4vplEpI4p73T8qFAn09mNWpEpn2bbuID0PJh3LDaYIB9VrG2FRb5Tbr/w1TZzjAu8aEeZnvrp9Vn0csgdAC2npBmvb1awLV1WtmEhu/3pmVLp1lzqWU2UzNNZqSSPbO9FSw+9vXfrSPYr/+7uz6c2kq5mujryNxebvBpnuFOGig7DzAo1RMiEmNz5PCIcMPgZBJT6Bm66bD609yOBmFzhCMEtrUFgb6bnSgRzcdg/1RPEHiykCXAi6AZ9fhyBkx8wKkm4n6D7oiMpAxenH1A0ZsbKSL+/5y7j/rKvb7NzqFQ6Ri3FlVML6xT
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Jul 2026 11:15:47.3764 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 118202eb-7dbb-4d9d-79fe-08dee0d016ee
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00005FFF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9194
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

On Tue, Jun 30, 2026 at 03:53:11PM +0530, banoth.saikumar@oracle.com wrote:
> From: Banoth Saikumar <banoth.saikumar@oracle.com>
> 
> Previously, the mlx5 PMD attempted to allocate consecutive Tx memory
> using DevX without checking whether the NIC actually supported DevX.
> This led to allocation failures on legacy or unsupported NICs.
> 
> This patch adds a fallback mechanism: if DevX is not available, the PMD
> skips DevX-based allocation and allows the verbs path to handle memory
> allocation and registration. This improves compatibility with older
> NICs and ensures Tx queue setup proceeds correctly.
> 
> Fixes: bbfab2eb2528 ("net/mlx5: allocate and release unique
> resources for Tx queues")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Banoth Saikumar <banoth.saikumar@oracle.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
