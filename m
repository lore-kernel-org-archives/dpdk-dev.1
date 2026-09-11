Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24773C88E4C
	for <dpdk-dev@archiver.kernel.org>; Fri, 11 Sep 2026 09:19:31 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 19E7D40269;
	Fri, 11 Sep 2026 11:19:31 +0200 (CEST)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011019.outbound.protection.outlook.com [52.101.57.19])
 by mails.dpdk.org (Postfix) with ESMTP id 775E540264
 for <dev@dpdk.org>; Fri, 11 Sep 2026 11:19:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ScbtrVOGsbQ3W2yPFFafG7Gm/oKUJfM5WEbeSGQ4KOIockNLRicqiXeVurbkkQcwtv0mwU79h7HoFRAzBzLHyjYxT8vqDpRZ4Eb3aUciTac60ERPDslJxjFUG6lw7j3DtYNy1Ir5bEahU6aGzNws4tFJAS49c/a3Ihsb1T+vZZpa0vtZPbqCbB0lvLL98FaKxSIDEqbfSI9r6TVRq1/XFAfAnM7gQc2txU8sIhzycQyFZ7AXqTkA9TwXVQD2AMSYnFQd/2ZYnw/7KqERgNmH4KvVTMVe5wnbBfeulRu45fqC+4HrfHa1iDGWKI7TUe3szJL4Db6KM9r9b5dogCdZkQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a+KmJfqGk6n3RjGfHicTymG17rvNKsHPRYDKwy3ynXw=;
 b=QqV5DsfgFRVPhZHQE0z610b6LgAeplmccn5jobu6LHLIGrIZyF2VVs2xQUMOw+tneWzOL76eHxBnuYqEfpLRqY6LeJrUht/TkmnaCnMKdL8ARhK8HxpYtBXG41ZF4iAkr6HH4AJ81/6TwQ/k12LY7os5EJXPXC4GJbbfQYZGJqcQjrleQBuHwQiDC9L8L5ADGALvDplRsCqpRETyW/pV5kQUqpmAiVrwWo2cqK/bbYjyiAPkJc6Ju3D1wNTv8+dtFgW0v49i1P2D7QuTJF3oGe7DJfiGzj88sFh5OJyDsyg5mwjhQKZz4xPq9ONgLqM6NHQ21yw5ejOVlWTmuXLSQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=a+KmJfqGk6n3RjGfHicTymG17rvNKsHPRYDKwy3ynXw=;
 b=iU1bGqbvkug2hdzKyugXvncE3UrCY+LyXcZ7fBVYanOHrVwL/2uQm6ubAtFvsBe8ETdkpHFFnqUZbCgORmwQjsmcX9YYm9N7uOeMrnTIFw2h07Ai8If7l3lb0J+WvLtTBR4qT4cJ0bUqUJc2WrtXlJBiensu0yI9QSY3Y4saeAehhm291SdwKBUQrVZwFUQ9Z2fxaGktIKN3IjALQBGutMoql0C2dcofzt1OGW7TONadfBZIuKoN1IrRP3p9VMy2BHUEnhD8lX7NqOdek4ybmPQcUZrOgEuDPscQ1/u+/0QbUVl3SVbpI7lnQfcp6qBjSo3HYgHTIY7W5ZJkyNyFUA==
Received: from BN1PR13CA0026.namprd13.prod.outlook.com (2603:10b6:408:e2::31)
 by IA3PR12MB024753.namprd12.prod.outlook.com (2603:10b6:208:53f::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.406.9; Fri, 11 Sep
 2026 09:19:26 +0000
Received: from BN2PEPF0000449F.namprd02.prod.outlook.com
 (2603:10b6:408:e2:cafe::5c) by BN1PR13CA0026.outlook.office365.com
 (2603:10b6:408:e2::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.6 via Frontend Transport; Fri, 11
 Sep 2026 09:19:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF0000449F.mail.protection.outlook.com (10.167.243.150) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.406.5 via Frontend Transport; Fri, 11 Sep 2026 09:19:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 02:19:09 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 11 Sep
 2026 02:19:08 -0700
Date: Fri, 11 Sep 2026 11:18:59 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <hkalra@marvell.com>, Matan Azrad <matan@nvidia.com>,
 Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>, Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [RFC v4 1/5] vdpa/mlx5: fix check on err interrupt FD
Message-ID: <pllz2nlnttiwzxlxhlaof6mkwu5jjxombpmo6d7cjk7cwkxwxl@knx6kyjyriin>
References: <20260908073835.3422310-1-david.marchand@redhat.com>
 <20260908073835.3422310-2-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260908073835.3422310-2-david.marchand@redhat.com>
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000449F:EE_|IA3PR12MB024753:EE_
X-MS-Office365-Filtering-Correlation-Id: 182ef7c4-f786-488f-d7b1-08df0fe5c6ed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|10067099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: b3dmvj8vjXrgBerh0q/meL46wv4s13nVKcqt4rsU70wKg4Qmo5NBpG3que7zcFi6RL1fBXVs+t7N0l3zPIP9LeolVWPln3CVpKC1Yu/bjtrMxb41cp/uMhrecUDMeMGqGsgEmpP/8E4pV3m1p0RhTq+GOBlQIO4fgSZr0728vjAPRqmcuBDdDK44U3F6iKp7iIl0oQ/2Zb7wDZQiYkU8yRKYRz6GoQ75vf9LiUE8/KpFCK49e2AXVKTnujDjiWCDMRxsY8x9gDBJal3jm7ftTfTMvjnWXmOocH8OCscii768UNk5gLRu6pTbxCdtWs9oU4X0LliHEnPbLOoT/fWlGBLI2yDougrJO0QJErCUt5t2LArHbdR6UR6h96R4cOlU26AsPrUSHY8PK4ufQbSug7Rk6J916GKW2kRTgQT/vAsxM0wIvT0JyM8s7BC0GaO/f+v9Wtj65khYuOtv4t9QTmW8zjojVrcUD/qTTZEqI+EOxWp+86DpqV98vW5zTRy0jI+FtwZgUaY4jpIA9I0/dXDrzbeqLx7dk/CdgcdXAzewTWlIZOoJu5bRVi2PoYXK0YWOqMX/PQfYT2dGEb0x2094mSaptzhWd31idAdx0qkViWn5dJmLANJ91Qz+GL87xSIVH9gijNr1VZLEHw0F3PWG8G8FzZ10CYa7aQUW/MJ81upvXUa23DGrKLJNK/nlyPSHcQyF9Hlo9O4ciN/Deg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(10067099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7eNkqSVYx4szdYQvjuv3ZC/jl9g3S8BXpD3E+74R/3PFpJ/TCvIU4cEvND6DA7ikfe0GGGPZt0vE4aK140973VdfuW6W30lLwXxcL4WMmODwNgGx4I6quZCjx1Mr3TfMk9qhUmbgjzIgUeZlXx1YBWCCUKXjFoZD4bigBzeZSxo0HQkTxc3Gs5qyi7RnabenN+S3p2VDwNfUFb7GTh/g/xepCiHTWHabKYFhGX5Hp6/yI41sOxDkYKw3hIVeiaNCsGevC0g0StWZzMSeUkjOZSDgLLiSXaYB5SP9BOJ5nZQgc69oh5h9ZbGTus6xTC6SzIjpstzBsWOwgOZFrMm/DH1etJ8omnkOCwsB5QmwF6IDV1Ex4KNvUniAzK6p9lhK0me9Jl3sWyqHBbT6UGw0NiBuRpL0MHcJJGGGinTNgVUszbjHwey2Zs4WOX73C3sK
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Sep 2026 09:19:26.7446 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 182ef7c4-f786-488f-d7b1-08df0fe5c6ed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000449F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA3PR12MB024753
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

On Tue, Sep 08, 2026 at 09:38:30AM +0200, David Marchand wrote:
> A 0 file descriptor is valid.
> Prefer setting to -1 to indicate an invalid FD.
> 
> Fixes: 0474419bae7c ("vdpa/mlx5: handle hardware error")
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
