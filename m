Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2FDC5DF94
	for <dpdk-dev@archiver.kernel.org>; Tue, 25 Aug 2026 08:17:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5F894402D4;
	Tue, 25 Aug 2026 10:17:36 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013008.outbound.protection.outlook.com
 [40.93.196.8]) by mails.dpdk.org (Postfix) with ESMTP id 88386400D5;
 Tue, 25 Aug 2026 10:17:34 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XzKpxb+2Q5K3nKya6wNF3wS5fLIEJTOfk5mNyROHi7ZGw0xngabmDd91s21YyXytg09D6SotiFZ7si+QuP6ptKcAdOgoo5w0pdLMbv2nrpUFn4j3lDLBunq3KidqfnnI5h3+yzR1zbvTb3EGO2fLI4Jw+iajR/ob3Vpjwfu2WVBYN7opv67qGZkbC17MhHZQ6A3/K8B37sfi8IgpsNyO2IvtxzAOXBBMM/FBFQrE0IetS/dWtL49nLPgj+3eiPmmu7ywEr8f+X5adF+UGYp75rKs+JaXLM86fPtDBZtz6xhetX1+uEDtBkghLLmsBW8bMaDEwiwgO2sQrPvlaHwpqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AVLWkHRbeUUWp6s81FFkLt602ybDZthLo4qLrutI+uw=;
 b=KgHNSuLznA3hUdMr04LIx6fc5eRKkHrDAF3hy3GlVFx5fxhL5TRjzD89nbSylPtknfg2tlWAt0RHY6y9FWmEYPBf1gpiduWoDpqTK4O0K8qJ8m4AiGvJz+/6g8dD4oaDeuQzhGg+72YHyVcMxXWpqACVebXrHaVY8SspE4o30/UXZXUlPjnmo55XXH3O9Shhyj2jZ2t3pOXlOiYiwSdu/XcEG68DkVTMsQelMLisE0UCEILwcWSWF+GUbWLFI4lJha76McXiqn8w3EqeG4TmbR2gWC55sINulfpaKtH2peo8Xwztx7wwgX1Qt14ykZajLHGqQH+Q0mspT9JXN5BpAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AVLWkHRbeUUWp6s81FFkLt602ybDZthLo4qLrutI+uw=;
 b=GhvgDDMH9Vchldx4dvw/LssgilYjUufWRSToF17gDsQk/VAXVr+5kWTCSmKamfDrlMYssMYcrAPZVqVaTIBcGz2l2W99EtUJoa61xcJloQoi91yuDn2DzG8gRB5JZUaCL00LlxWlw6cyT3hOZT7yLd/eEnyJ3/p+uJY94RPQ9kpKQE80YjjC58v/RjwxjG8aBJQahwL2KYUwpYWg07lgjwW3VoMu7Be165dYOMPQ7wzjXf68vC4DESFILyNxGzxzcfTe9vYszkqmvt+EW4+EjV1zFbviFWqh2z+AdeXCP1nJSvq5J0corwtSLpUl0hNhajKjV0R+y2n4PRUE9qYpmw==
Received: from BN9PR03CA0898.namprd03.prod.outlook.com (2603:10b6:408:13c::33)
 by MN2PR12MB4406.namprd12.prod.outlook.com (2603:10b6:208:268::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.360.6; Tue, 25 Aug
 2026 08:17:31 +0000
Received: from BL6PEPF0001AB75.namprd02.prod.outlook.com
 (2603:10b6:408:13c:cafe::8f) by BN9PR03CA0898.outlook.office365.com
 (2603:10b6:408:13c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Tue,
 25 Aug 2026 08:17:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL6PEPF0001AB75.mail.protection.outlook.com (10.167.242.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Tue, 25 Aug 2026 08:17:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 25 Aug
 2026 01:17:14 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 25 Aug
 2026 01:17:12 -0700
Date: Tue, 25 Aug 2026 10:17:09 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Adrien Mazarguil <adrien.mazarguil@6wind.com>, "Nelio
 Laranjeiro" <nelio.laranjeiro@6wind.com>
Subject: Re: [PATCH 1/2] net/mlx5: fix promiscuous inconsistency on port start
Message-ID: <udf3vw7jofx6mfnvybtvkisczr5sigjmmyghhrxndrosac5o7l@y62zc5yjcgea>
References: <20260731092332.3833632-1-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260731092332.3833632-1-david.marchand@redhat.com>
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB75:EE_|MN2PR12MB4406:EE_
X-MS-Office365-Filtering-Correlation-Id: 7261d614-45fc-4a0e-10b5-08df02814f0f
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|376014|1800799024|82310400026|10067099003|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: n09N7POmI5D0r6kjjQ/QydFnFT7FqnpTqJL28pLnSsevOXTbNQ1CUE5te/aXlzyQie9Uht0UOccRLzS4tNIjLxMHxbuxTnTXAWwJHy6SV8MsU60PZ2OtnV7mLr++rx1LZ0xhAzJbPmNokCjv466cptcwukCE5FGF3dUJy8rXA37H6RuUSdGRtlZxiaQLA6LEelPhii3V3rcPerpi2Li6bUP/7YbONv3TD0vSbV8G10qK420018DJtyw5TtpgQl9uVl1yStOpIMxWrsPy1qP1FDPbC/zqHK+nt/D1G4SpJBZR3w2TAZmyE5r+YpGTeGuNK4zinoDyquysqyTffGta0w8pd3p86Lbmw/QgaHQdi2m+iQgQDfEl6wMZ2cWhn2EGIILmfQT/yFL9Ei4/WQF+FRbYG9/b1c+K8eXzMgOJeLT6QsIOn+4ZSOY1ztzS1vtz7wNTVltMp/atmNfFDMQY9iIGHwzk3EseO/x+e2OUOx1j3cRQJ+22Oy21qleB3EMgmliKMr5xvQJd5iui+kW/ON6El6QIW5KisGUsB4Y5ZYgoPDOTB6+G5oxzMVod7wlFuLOllPh4spruvric2oBvfnalvLouZxQeVWY/yBMB82tlQtrro//FQWQdvrmDtptGU4mtPtqh6vZozta9lh5xtCVnxyASj+Zm0Y4fXGm6HeFYRCPTHsgJtGZLZGZzzBEEhVEyaGPf1564gVTaShc8ng==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(82310400026)(10067099003)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 33aaR3VOkwy2LLT1ZS+y+2TArfCLLwPkUBOSBdsbS4c8u3GxisoAEkecEDmysXSq76T3NhnhGTbC10qTKk84edJwN0JKIqO8jqynpHNihIQH+8CpHT21yUm5gEpRNNteykDCvHY1U3cUhm+2k7Ms4LEtktdQGuvyyv+7WNmQbxXiJSza200SfXDP8UJMBWPqmjKXIe9y4T9fOUCIumcAyzIvPiHpYnWD6H9WjvqqKURVOCSaQF6WxEfNYibFlOiylpTtFGpaiRAy5ecH3H7h6yK9o1ByvJIvZ6MGUSDr2DqYfrmMpq+vkxBV6BN/5nSAfhCG+Y/S60z0HpRvR08dN9R+3i4x5xNqlf3IkhHtLVd4kzUHzNxivKgJv9EP6bJmUERogqIE2hsxIzsSMP5NxsDO/BkRuH7lwPuBbRaaDe7xRIxYrjUcGVpwXX5LCRE/
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2026 08:17:30.8519 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7261d614-45fc-4a0e-10b5-08df02814f0f
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB75.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4406
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

On Fri, Jul 31, 2026 at 11:23:31AM +0200, David Marchand wrote:
> The kernel netdev promiscuous or all multicast mode could be enabled
> before DPDK starts the port. This would cause an inconsistency between
> the kernel state and DPDK's expected state
> (dev->data->promiscuous / dev->data->all_multicast).
> 
> Add mlx5_os_get_promisc() and mlx5_os_get_allmulti() to query the
> current kernel state via netlink. On port start, compare the kernel
> state with DPDK's state and sync if they differ.
> 
> On Windows, these getters always return false as there seems to be no
> API for getting the states.
> 
> Fixes: dd4bb90bc3cb ("net/mlx5: use Netlink to enable promisc/allmulti mode")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
