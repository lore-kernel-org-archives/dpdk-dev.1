Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CD8FC5AE59
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 08:34:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BD234028E;
	Thu,  5 Jun 2025 10:34:31 +0200 (CEST)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com
 (mail-bn7nam10on2045.outbound.protection.outlook.com [40.107.92.45])
 by mails.dpdk.org (Postfix) with ESMTP id 3F7504026F
 for <dev@dpdk.org>; Thu,  5 Jun 2025 10:34:29 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fpCDt1A/BRI+/7oqWjvNDZVft8oyzQc0v+jRSDD0fA4KWggxpIdlrWSLHW2LR/O+j7Dmd0CoYoG16OiOfj0cpilh23ZO9cFFc4/QedWTln/dKL54yY33ezUtIUA31ysctOahg0VKvgdWD8F+7dvd+Dw/zogOKDR+8Bta6HTNz4BBkwbpUdeAA5n8ExikcJHOf8FDkXBtvcHW+iwaz1pHWuLOZgQVgPb+PQeF0hKX1gV2cfx24o28saK7c9ygZdU4kbniVF36lJyzsU7UbFrkCUeJJaKPInA7XW1GDmFEtQ3v3utQkNke6rXUHG0Y81yR1MRTAXnv0sYv3FPs3gcpGw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3g98O0H8/+fLbAoZdq99MobG3qm2MqQiE8oHecuJOBw=;
 b=MSrI/7bEtINcJXyogLLqyT3OmLJjLNx3iFGx3Ns0CMm+87koqosJ8IWBmoJlv5bsqBPGIJeJon7ltbTFTkRFXBBxI3EdLQNE8KzanUC+Q003QB7sLQRGdIugd5t3+PVX5j6NRLZXMaCxGCveiABTaba31iHCHEvBhA8iNzMhPsn6MfIjqnh6z8MQ0c9IkSsHnsxGrVhvJFgtSx5VTpEYnakg09umdEIIT2zUs9/WJujibPUN8MtqqTr9v4TZRoXycpCYNCHqSu8VnH3+YqrLxTsSj/F/m3nxe1VZbPppG471WrvD9s/gr35zWIS0/wYsnDcDVDrd1aTKB8U8DW20/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.microsoft.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3g98O0H8/+fLbAoZdq99MobG3qm2MqQiE8oHecuJOBw=;
 b=V0zy7+npsJnD4dKU9SSSJcedZUK/guXw3XINFIPSRNnQoh+urpPu7BbK35m0TuFPhKbGlltMx/9VMiPI+cdTqjAkxvnk17L+VPJCv2yt1DPnM7L9n59mwhzpjf8++KKKFKSqAFIcWGfAkXE7AjHbkp7BGJCtUG52NqFHdH7Xn3N+YEvVn7unqXL7Pn+ZAZLgSf7Vi2YRSPxGKvFJcEWq9pfheV8Gg97JCqdF08abhx60qcVB8mS2fRDnemRyugTyxfSG2dBa6HIvc/knD/vscAsdwCpDeBMQY18vfO4aMg4IqLm2gWfeEOUphnhtrDh7CJF/Z6zRt48XzxzRrEfigQ==
Received: from PH0PR07CA0042.namprd07.prod.outlook.com (2603:10b6:510:e::17)
 by SJ0PR12MB6711.namprd12.prod.outlook.com (2603:10b6:a03:44d::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8769.37; Thu, 5 Jun
 2025 08:34:26 +0000
Received: from CO1PEPF000044FD.namprd21.prod.outlook.com
 (2603:10b6:510:e:cafe::d7) by PH0PR07CA0042.outlook.office365.com
 (2603:10b6:510:e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 5 Jun 2025 08:34:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CO1PEPF000044FD.mail.protection.outlook.com (10.167.241.203) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8835.2 via Frontend Transport; Thu, 5 Jun 2025 08:34:25 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Jun 2025
 01:34:07 -0700
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 5 Jun
 2025 01:34:06 -0700
Date: Thu, 5 Jun 2025 10:33:54 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <bingz@nvidia.com>, <dev@dpdk.org>, <matan@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <viacheslavo@nvidia.com>
Subject: Re: [PATCH v2] common/mlx5: use intrinsics instead of inline assembly
Message-ID: <20250605083354.em4pes3yfg3nta7h@ds-vm-debian.local>
References: <1746457062-8502-1-git-send-email-andremue@linux.microsoft.com>
 <1749046525-9166-1-git-send-email-andremue@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1749046525-9166-1-git-send-email-andremue@linux.microsoft.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000044FD:EE_|SJ0PR12MB6711:EE_
X-MS-Office365-Filtering-Correlation-Id: 058ee977-9855-4e0b-b33c-08dda40bc7bb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700013|82310400026|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?aGvYmX/pAfGZijiTe6IQWUakPBkN7gfk/zR49H7WDWY3bLzPbYaJ2CbjCmh1?=
 =?us-ascii?Q?+zeu+7aOWlCK4Gl059fjvkkButVdulDUwU2JteyWpyjHNyI2cF8EjN8+421e?=
 =?us-ascii?Q?8fs+sSo3YQ2M3ueaBlftQAoFg0shvwmba4iUqqpdx+Xe4QfrUA9ME9mH2wRL?=
 =?us-ascii?Q?7NYwkeTeu4biETQOyhywsHf4vveZ+J3ZgITw2omkDrRLBzePLnxmjAovbVqR?=
 =?us-ascii?Q?4LfFK7skLDo4LTUMZIlT2w2LHA4t6A6nnS/mZ8Q/JFQVNWfCuS6QfZV5uh4f?=
 =?us-ascii?Q?xB1g6r6ljtrUv5lKcDpWcI5SQ9COrWW7B3IunF9lYD8EZIH1IpUhasT6x+ue?=
 =?us-ascii?Q?MxQLfh1aVcmUyPCs9nbN3pxMzmOgh9mPm0YK076K02J2oHSgJeUy98kFUAnA?=
 =?us-ascii?Q?6YkXAmLRhUrWUJ/UOM3bS8bSmlFzIhqx8yNGTgjVquhoAK576v7NVhRoJwWA?=
 =?us-ascii?Q?c8m27Ry8AG7H3Q2Waxw2nFRRKIfMuZa8IEgq5agmFYCKCBVOC4t7WosGlaG5?=
 =?us-ascii?Q?0kTJCuG5CYHCj0gwcTG/oT5uhM34dAcFeNPCL42nbPWJUiC2V57EjWeie0tb?=
 =?us-ascii?Q?EOXN/+ABM2y9SzoEqPhZ0k7uWm2cS9IfymJRUtkVHCnxN/QYV1bW891Cu/iO?=
 =?us-ascii?Q?VUftdfISxRr05EPLhHF+rOKrIIyaeEE6Df1ylmilRfNdMDYc74iYF3atTAjE?=
 =?us-ascii?Q?0iwl/abTRwZOG9pKP6KbFelguWj/DKUeQs5sCqU0IpR5PbmUZFChw8dNaOYl?=
 =?us-ascii?Q?bWMClBNF5MEU/3//HgsxZu5ShKINZ16K9pCgLqnyY5y/qwmQblKQZLpEX+eu?=
 =?us-ascii?Q?VGu1Jq40zaUm4U422CL0LILP5lhnXliBsESZApcdAVnentCp9DOA/ayos45K?=
 =?us-ascii?Q?DepmNoWLzVkzj+lCvMcVpy0Z/kaONCQoVvUxSn8faDhoz2EM+U93RdxDXip/?=
 =?us-ascii?Q?3YCFiy2xFf30SH+Fwxt1umIKMlFLIxzSjXurJA6+tkGpcjrq5Hzb+cBR5VLy?=
 =?us-ascii?Q?+uhocWJY9EUomg8iWczIi8qEYlaA2KkSaq5HkgRzPCHy1g2M9QdeWAmAMzyE?=
 =?us-ascii?Q?8nP1T21oSmfOXWnVeE6/Si7IEkA95MHoQZ88432wgqwJarGVsWO7Nts0KzkA?=
 =?us-ascii?Q?58Z80edN71d5Elg08QZILOKfu5sJ1HrtY0vvoMNafZ/iMAf60UYspBpPWrGw?=
 =?us-ascii?Q?0IUWTtdptV5wF6OmjjgN5T/qEkZRxCSLvhaENhCKXqSCVmS2QLCJh1iER+2j?=
 =?us-ascii?Q?0E6R5tKzLcJwosbdzlP93gLJMu2aGFSB31ZjN4jkJJElWURO8pl94WmMoOYL?=
 =?us-ascii?Q?DFbHMq/Mi9CmR88fX7LVFkoZlkvOXPfwNxzpgznrhNOs3EH7+B+gxDC5d9k8?=
 =?us-ascii?Q?UhP9F07CArs4X1KbYOSyalrCb/64d88ccRnnIv5bfmH6+Pwx5KQhHmcmvt9y?=
 =?us-ascii?Q?TKhAYhXZIAw2EzqiEXlmv5R/kBVpUST9gBw7ERxohyXMz5eYC8aC5X+MShWb?=
 =?us-ascii?Q?zBhITtF3zKaX01kMaGmjduW/4GYyi5qqR0im?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700013)(82310400026)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 08:34:25.7605 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 058ee977-9855-4e0b-b33c-08dda40bc7bb
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000044FD.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR12MB6711
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

Hi,

On Wed, Jun 04, 2025 at 07:15:25AM -0700, Andre Muezerie wrote:
> When compiling with MSVC the errors below are hit because msvc does not
> support inline assembly:
> 
> 1)
> ../drivers/common/mlx5/mlx5_common.c(86): warning C4013: '__asm__'
>     undefined; assuming extern returning int
> ../drivers/common/mlx5/mlx5_common.c(87): error C2143: syntax error:
>      missing ')' before ':'
> 
> 2)
> ../drivers/net/mlx5/mlx5_txpp.c(510): error C2065: '__asm__':
>     undeclared identifier
> ../drivers/net/mlx5/mlx5_txpp.c(510): error C2143: syntax error:
>     missing ';' before 'volatile'
> 
> The fix for (1) is to use compiler intrinsic __cpuid and for (2)
> intrinsic _InterlockedCompareExchange128 can be used.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Thank you for applying the changes.

Best regards,
Dariusz Sosnowski
