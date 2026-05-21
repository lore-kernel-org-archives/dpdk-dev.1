Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB49ACD5BAC
	for <dpdk-dev@archiver.kernel.org>; Thu, 21 May 2026 10:00:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DC228402B0;
	Thu, 21 May 2026 12:00:40 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012036.outbound.protection.outlook.com [52.101.43.36])
 by mails.dpdk.org (Postfix) with ESMTP id E1F2340290
 for <dev@dpdk.org>; Thu, 21 May 2026 12:00:39 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=C4KEhsA4THi+r1oX8sRVD8HT7KL6KqwGSUUqds7gUFGYBBwWMy/ZPCUcKSewldFQn/E/hsD6HA8+KNKN11bmkX6UVeXzzpUhRPQ/svfm+/bCiQ+EQfsW0lMotD0hlz5jxpBQyl02i3Gmuek9YQ+51chIeKAoaTdNr9/pDkBy2ekBTnGsrjo37eJ6vXPYsq93xAyKFMPfabjl9EKEEAiB7R3m3mUyW5KntrYx6ibFX8t9vyyeoVc7WsVdAXFXU54JAfeD5qkoBkjPYof9nJT2gX6AD5a7Hi1h1OA/gVk+5jbw3XGtVCxyBWJZeCEPARVXqPQ0zpZ/f9EpsliCG1lX5Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YIwCM62/BUihB2OJHyNuRgWSCGWiUXzLkbC1hjMOczc=;
 b=Siv2/FzeOvWRZbFBPnsyhsUiJdi3iKqZnplOKuZzeMrRZC4qLLAKtB4yuJutuyrRddcIkDNVC8juvErgejycJh+gLCAgBcBQ/VVBOKQLUya0t+1aUQLOy9i82qY2np/yY5N6fXA9w95ORfOqETk1ugbmpuE9x7osevGVvcGJE4XWyKXf4yzfjj3jjcYuFnpdqCgSjqudvBxW4Wf7zu5XKT7fkNwpzs4dB0gVyIHPJxMF4vtcBTZwKG7aBXofWIa4OenmltKrGUXONnyFbBCy8t823Pzj5ZaWUQ36ZJBHRLlkvyXBM72u5JMu5bQN2s5xdH8NOE311BUfGI5TIO4c9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YIwCM62/BUihB2OJHyNuRgWSCGWiUXzLkbC1hjMOczc=;
 b=L0Wb8pMJguydxWz5FaVIa4FR6eyb1jDNNvvcguyttRC9WD+NSBQmOGIHIfOZ0FLJ6GCfbmHZjNWFk8gRsF6rBtYOFPsEnvcvfIz2JHzj4/7KVAjPKrSFGpt28aipk5MYYdjCOEk4VmAZg960SFjKbL0XdIfLgNmIh8gxPHsmPncLPhchHho0XbJYtsChq78Z2vpO6m0mfFZA+ZAjLpivGL2vdQ0m6Hj8A6E5XhE1iM0Kf38Xo0Yc4Oqk0XuuITJNI1L5kzxpL16/mOZzn0Qt+DDDs+3WkyH46wQE9wCz1QA76QaZ+0Tgn9OAi2d2LpSLqztzqAOziUQArkiqvHCLlA==
Received: from BN9PR03CA0809.namprd03.prod.outlook.com (2603:10b6:408:13f::34)
 by IA1PR12MB9738.namprd12.prod.outlook.com (2603:10b6:208:465::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Thu, 21 May
 2026 10:00:36 +0000
Received: from BN1PEPF0000467F.namprd03.prod.outlook.com
 (2603:10b6:408:13f:cafe::e8) by BN9PR03CA0809.outlook.office365.com
 (2603:10b6:408:13f::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.14 via Frontend Transport; Thu, 21
 May 2026 10:00:36 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF0000467F.mail.protection.outlook.com (10.167.243.84) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.71.7 via Frontend Transport; Thu, 21 May 2026 10:00:36 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 03:00:12 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 21 May
 2026 03:00:10 -0700
Date: Thu, 21 May 2026 12:00:10 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Rayane Boussanni <rboussanni@gmail.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>
Subject: Re: [PATCH v3] net/mlx5: add validation for indirect actions
Message-ID: <qmmjiwkfpq2bgd2ld5r5blb4trsrzvjxluyyeam4f4o4dil2x7@6por6zuz7o45>
References: <20260417222104.66543-1-rboussanni@gmail.com>
 <20260514193359.195017-1-rboussanni@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260514193359.195017-1-rboussanni@gmail.com>
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000467F:EE_|IA1PR12MB9738:EE_
X-MS-Office365-Filtering-Correlation-Id: 6cb3084f-7218-47d3-5aed-08deb71fce6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|22082099003|56012099003|4143699003|11063799006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: +I9Z4sG9pUowVUGelTrkBziwTrK3CKUxac2AD3Z6yRP0LbATfe1ykcR+sqAziBYZrLYrH3rhMlzZnl3hXmlojfMCFut0IIkGT5AN+zztiVmZaehzp+X9P+plpEFqSmcYH9cdLaeCmar8eFRGhy27OP/rf1Ec2ortFtvsyyYEvIGjCPgt5DJ5sWwXRuzubUHtz3Dluwe6pMMVJrch9dBWrZM1H26Zr2EGH0V84Ru/+Gsc6MxXIQGJ+X59BsixghnUiZ2la//hqgblogqVBB5P9+VhLi8t7HRvprWykE4KZxwIHH4QXurslqqBKX85gXOyztrCk40NlF3YJkqeuBnphRtBodzY17MwzzZvr2DBKg1DHzA0OGHK+xzHY/8H9sD55G4ePbLrNoKPqzCVssxTRmA+jnYaCpT0IXEvI2JV1/wTzXbr64GDg9HsNBZh1XQ3+GgTndfbOfljIaYuaYpxTHv6x/5oipWs8sDOnMMUdRivIJpRve72qzq6Mi+2o3ajaM8IG0aZScPlZC4+giKoPJjT0RdRo3uFHfHXjLtIbmDX1HRIw0WbYtKdDpu+mjrVbAbkVbCoj73TC6jBe9+qGIPlTNezs63jlltgiKyHn5vR/b5FTUg+WiycYQdDW+6mvWwcxfpHtIBUFbn5y+uZiLUxFyOdVGfxYpguEwYeI9/E5fGOEpYtb6UUE7YicJPhpBXBBhKepLezvg0Hie/kkq0Q7/+9KpQPKUBo5FvlmcddAXe8dzB0Wa5PsAprKpyl
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(22082099003)(56012099003)(4143699003)(11063799006)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Dn7hKCEL7+YlhQVU8PEa5czAtQcNpV8UKv3Vi0LSSRAaDcZE7Xqj6UP1RWWR8CRzu1HsfOoNsSnNcD7o0+Yz7tr21NZ4CJ6gfpQbWR6Hrjyx0IpbI/+WwhcszQghw2URhlhBLm8ZOpkOFTky0153nCOtR9ja+/KbuWpuP/jUc50D8g1ohBRzlm0ARkToU6o4HvsF+zoLp/DkoRwGQ5WpWNNp5NZFRQmh7voidkQyoRIyNSt69y2UrkFGtAS0W+veIdvHBAlKZkJ3kGVd1poaFNYfNyrlfvT2K4SiGrSvI8qazFrdcCr1PhdIH+Ca+jsYw32iVijXSsraLJTLFQUG72cdZ3jP6IR2Ii3dl/iGRNzfbsAWRfxQyLt24pCQctXiUja7mtBN8/lRu0Fcoejc5Ek1MvK2I61nyJLYbAJwIsAHWbnU+9NZxEzN8EY+DUp7
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 May 2026 10:00:36.6523 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6cb3084f-7218-47d3-5aed-08deb71fce6e
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF0000467F.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9738
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

On Thu, May 14, 2026 at 03:33:59PM -0400, Rayane Boussanni wrote:
> This patch implements missing validation logic for RSS and Connection
> Tracking (ConnTrack) indirect actions in the Hardware Steering (HWS)
> flow engine.
> 
> Previously, these actions were accepted without being validated
> against hardware capabilities, which could lead to unexpected behavior
> when applying flow rules. The specialist validation functions
> (mlx5_hw_validate_action_rss and mlx5_hw_validate_action_conntrack)
> already existed but were not wired up to the indirect action handler.
> 
> The signature of flow_hw_validate_action_indirect was updated to
> include the actions template attributes (attr), allowing it to pass
> the necessary traffic direction context (ingress/egress/transfer)
> to the underlying validation specialists. For indirect RSS, only the
> template attributes are validated, as the RSS configuration itself is
> already validated when the indirect action handle is created.
> 
> Reported-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
> Signed-off-by: Rayane Boussanni <rboussanni@gmail.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Thank you for the contribution.

Could you please mark the older versions of this patch as Superseded in Patchwork?

- https://patches.dpdk.org/project/dpdk/patch/20260416001052.2624-1-rboussanni@gmail.com/
- https://patches.dpdk.org/project/dpdk/patch/20260417150153.63149-1-rboussanni@gmail.com/
- https://patches.dpdk.org/project/dpdk/patch/20260417222104.66543-1-rboussanni@gmail.com/

Best regards,
Dariusz Sosnowski
