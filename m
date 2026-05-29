Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41B83CD6E45
	for <dpdk-dev@archiver.kernel.org>; Fri, 29 May 2026 08:45:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 589614021E;
	Fri, 29 May 2026 10:45:21 +0200 (CEST)
Received: from BYAPR05CU005.outbound.protection.outlook.com
 (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
 by mails.dpdk.org (Postfix) with ESMTP id 2B3A5400D7
 for <dev@dpdk.org>; Fri, 29 May 2026 10:45:19 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CH25y7ZginGRYFGgME2MO6kjRFXTlk+pSYb60p2Mh5shdRRgUwLMdQRKreHwDjyJkJ4SpOPFJCshakbDlwCj6GRlbWoigYZTcN+ZDaqV5Yznu1tgI690gVpgSIvwK/Lh9kXQi8+z3njH3yqHQodRJkt4eia69kAec6hBCSJ0Z5396MV4jvdR9m9h9158M13o2OZRmCB3b2qdbPt96v3C9Qnbt3w3MwrUq2nyuGCkMKPUmTu6GJP558n2DgRvS+W90w8YcwF2s7+bQqYegUP6MprWa0e/GxLESqbkV0lmdm6dpp/du8/5EnvHdSCtNTzNfn7KHnAm+d8KBiEvJ5yraA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OFkrD09QwIxPescoRGcQpgmNNEj2FKOfxLzlxpbVEr4=;
 b=QWyDEze31kZI8Fij2+6e4b2HU3LlWfjj8DzNbvEDBLt9GNUVNRXBxw6X9nh7WbgHgP6Mpl8emhfY6D1XtOsPPTSCf8cIuFDqE9pZSk6QYmbn6iRxlGnfvgtvzI4XUNnTV8pxvuo+nwhBP3v+34afRb6i1feBdjWgirLWafqJhs8zmzmTRpC3uhdyK4EL83eTkiz/4sEzL7G6GR5/sqpj55mfR6cU7HlEUYGOwnEGVQ1Gs8At5J/MuX/7V3hrllKB2H+oQDFvkIt9hvQr7LQExwk7Tytb6ZIBMFJQm/AuKkV/VjgcCDcq+HSXTtQKdPs5sEFEcr7r1gOgDd1WBi8quQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OFkrD09QwIxPescoRGcQpgmNNEj2FKOfxLzlxpbVEr4=;
 b=ePPwTmTNAaxqgqbiNZH5b4zfPp5xPDFn0G2BI4z55eojtfNFy5O9n7982UltGsud6YSlrJSop9Y6Q3aY1onxthqFt6NIJ2oK1QxbGrKcZLsc+aQn6HXefLXYYdLL5swiCGVICE8p2DRF1fy3+ILIJg4VzaiW5lQf1iSQzqp8Lcwm6V0uaZDRxGNsmQUR86w0Vcmh8BZKGpq3CSOb8Z9eiTNaqUkXCmGvgsviHBiYhn4m5/pqbhGzHcJDPdDRT2NSDVxnb5TsKdX/ENXEi1HOkOSphdOP+OnI6+CO1gpirudaXQkpbEOfXI5h1AQ7XjpUo1l0Cd/GAvsdJwprSKJzmg==
Received: from SJ0PR03CA0253.namprd03.prod.outlook.com (2603:10b6:a03:3a0::18)
 by CH8PR12MB9767.namprd12.prod.outlook.com (2603:10b6:610:275::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.71.14; Fri, 29 May
 2026 08:45:15 +0000
Received: from SJ1PEPF0000231D.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::ad) by SJ0PR03CA0253.outlook.office365.com
 (2603:10b6:a03:3a0::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.71.13 via Frontend Transport; Fri, 29
 May 2026 08:45:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SJ1PEPF0000231D.mail.protection.outlook.com (10.167.242.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.92.5 via Frontend Transport; Fri, 29 May 2026 08:45:14 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 29 May
 2026 01:44:59 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 29 May
 2026 01:44:59 -0700
Date: Fri, 29 May 2026 10:44:57 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Maxime Peim <maxime.peim@gmail.com>
CC: <dev@dpdk.org>, <viacheslavo@nvidia.com>, <bingz@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <matan@nvidia.com>
Subject: Re: [PATCH v5] net/mlx5: prepend implicit items in sync flow
 creation path
Message-ID: <ppgyzi7oiwihqtoww6edsq6ozj3lvulbempis5c35asa7eignq@64ysv7wjjehr>
References: <20260511150854.1398044-1-maxime.peim@gmail.com>
 <20260527103531.1266488-1-maxime.peim@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260527103531.1266488-1-maxime.peim@gmail.com>
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF0000231D:EE_|CH8PR12MB9767:EE_
X-MS-Office365-Filtering-Correlation-Id: ea8a3a2d-64a3-43a9-3d95-08debd5e9a91
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700016|1800799024|22082099003|18002099003|56012099006|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: ElnmnEy13uuAL21tMMKUlOAx7VbBZUBqBgbGz/TG3rj2F+c5nCBx1FRAM0tM2va5POlP53SUlYJ+wg1TO9Nz1MMoI10t/T+I1qICIUAZRpywxJ1SqbqvALR/LCqCK/4Y5OVZsZsbxyMyVXJJaho1feU6jvSWrlcRnniGKZUvMTpZ/2BL+BwDhW+NZ4aesyfB4LWv8ki80jZbigbWiUOKZg383ghiWj23ekQ7ppt4o2JOjJKe5JUYA+Xxr0+p3X2zWg/FM97Xa62inzwZbrMsGVMyz+c5iSa6Q5ySI8DVedTYiQltNXy8SER3Qt5DkyUi34kGvge8JP04kSTG1YhEoEcuq3OwDq2ej5C2dYLcV40Qr1iolq63w2f6LWfvRXNrv/Y5dcZSoUo30jeepbM9G+cFb78SXSpVTRl20n/CmmrBNKCUbPlJk2FPCiUcWH/tTRmJcwHNQK4CFaHHbdJaKkNtHGxFd2BwsvqTG4SUopJ7seF46Th1e+34Bt3xrlArysBCI8JIIteNUWx+Hf2nrIsROhqQH/BJoAaJBSZPdAaHvUtT+NBoa7VpTu/1TR8u6q2RnJ9kXyOnMMVbOXSgl8N/TUoqjVUdIQKWFt5Kj6fCWbMwdzQV6OA/MS+pYHgUNpbs7kbjzvD1dAf9e5q3+Ch0k+UulcsfkK+ULEd1zwCAnkpEdJvSotCHmBvEvkyhjf8PL8cw/qs89rq5ToA41dg9PtPYDzT/qHNTjUYqpog=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(22082099003)(18002099003)(56012099006)(11063799006)(4143699003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: xoelbjCpBXo250DAuWJejrgeJpC4CJNl3YnFvTICnsczrEuYOqs8bD3IOWsESh9OSzG/w4CGZEu0Z5haMAjzI44AH7ponhCD9MKtQm6lhAt0e2OKEzmRU0dzMRZn/hFfrh5OZ5qlZCUqODL1Qjf0ub5BIXVpi3wn+/H4wHuOXf6TMt7mBo18akc7pYw+pnDlCmJbY3Mact4aGBBBQe0jBgLHMZuloc4C3m0Q91hM9C2Iyr0Y+8EmjzUEF1G9P1fhwmUnbXUVXZi4ytNEqyJG/+jXEtzo05njcja3OkDGjVI6e93RCYl9Gj/MniJ4GkeoEq8GtikKrb/EJeD40gnt8nLECSEoI9SBoUCmCmIJA/eQmGW4+9tPA2Yn2bu3WyOcYF1xOPUleZgZm5yzaSIv0jJP1BuoVbdmPalIxUO1PnslRfjYxshEYa19Y7au2h4r
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 May 2026 08:45:14.9859 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ea8a3a2d-64a3-43a9-3d95-08debd5e9a91
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF0000231D.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9767
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

On Wed, May 27, 2026 at 12:35:31PM +0200, Maxime Peim wrote:
> In eSwitch mode, the async (template) flow creation path automatically
> prepends implicit match items to scope flow rules to the correct
> representor port:
>   - Ingress: REPRESENTED_PORT item matching dev->data->port_id
>   - Egress: REG_C_0 TAG item matching the port's tx tag value
> 
> The sync path (flow_hw_list_create) was missing this logic, causing all
> flow rules created via the non-template API to match traffic from all
> ports rather than being scoped to the specific representor.
> 
> Add the same implicit item prepending to flow_hw_list_create, right
> after pattern validation and before any branching (sample/RSS/single/
> prefix), mirroring the behavior of flow_hw_pattern_template_create
> and flow_hw_get_rule_items. The ingress case prepends
> REPRESENTED_PORT with the current port_id; the egress case prepends
> MLX5_RTE_FLOW_ITEM_TYPE_TAG with REG_C_0 value/mask (skipped when
> user provides an explicit SQ item).
> 
> Also fix a pre-existing bug where 'return split' on metadata split
> failure returned a negative int cast to uintptr_t, which callers
> would treat as a valid flow handle instead of an error.
> 
> Fixes: e38776c36c8a ("net/mlx5: introduce HWS for non-template flow API")
> Fixes: 821a6a5cc495 ("net/mlx5: add metadata split for compatibility")
> Signed-off-by: Maxime Peim <maxime.peim@gmail.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
