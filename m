Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71191C982DE
	for <dpdk-dev@archiver.kernel.org>; Mon, 21 Sep 2026 08:37:25 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B946B40265;
	Mon, 21 Sep 2026 10:37:24 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013038.outbound.protection.outlook.com
 [40.107.201.38])
 by mails.dpdk.org (Postfix) with ESMTP id C0EFE4025A;
 Mon, 21 Sep 2026 10:37:22 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gciB7jcKUHQ2tHWIUVqlJFn670hnZaz5I93kdjMQDIy/D+mzRhL8hEoX04lYaz0vvHj8vXxo5BqLCviw0Ko/uGK1llt7gKk/cWEEbnx1oQhLpyAQhlC2VETBRKeuGeU0kGHSNJC6n0wE+w8ewZYi9yUQFLzGsV78uBF+NGKef1inIX+v8dAYiy755jRWsrOBxhehNRHn3gtkJJb7TeSSWJ7idq3cpI8LQEkxeVpXSkcpZsbJym+WAigmywMl/4xPv/rTTIXStK0prnwW57mYfUj/16beL700Dp8fi2l5DSsF3hpCuHExRSu1GrOdiB5KDvLe2RPXqgv8ehaYLnctEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CS9G06YFepOLXgLBB/hgPkeFmyfkoUr09Hf7JJt0PMI=;
 b=kEb4hggWD45CAPXL9N1JMuP1zVF5DNvfp7ziz1BzRBxZB8gw2O+SIyqwcRlzm1COutTGgZqOM32dKrjk95mIRa6X7Y0HxXHdQI9WLpnvH2cQDTSv2ZN/Kw8YOTp3fdKjqwV8LXJITZW4dYkoPoVWp+NA9pFPxtZ2/Wu4CMyFqSUCY3ulChG7fUjYQxU0WTPaNoklSjLa5Qyv1S09KWervsympBJ2cvY0ZWTzR/fBXS89l4UExAi75PS4p4L8sw1BhxL++5Dw7FzhGBw6hemLklGZJgSMFFqlKwiXVzdrYbbhxFJ5xGMkYQtozdYsfvdKJk1SAO7Kzb1W8JcmcsQ75A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=oracle.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CS9G06YFepOLXgLBB/hgPkeFmyfkoUr09Hf7JJt0PMI=;
 b=ZGVCSWZBgL23CSDW22i5mmraxVgGqGDqyvFBdhBfuoZ1FdMYn7RXtGbzk2UIB5WR6XaxDChSKywwBoAxWRRoh/BfmDICwC5C88SwBpK/uk4s1Mus9ewnc3dlULyBWP1WbyT5nRKZMnFsVF+ZCLx7J4cB5YdsblfbRprtaOCi3so1Vl1rphCjKCPZj1dq3iZlOxCrprnw71gFslRlegtPCNlTBvyV5kN0Z4hOIIhp42noojMVwfGOwXLu6FabAIW2TuL1FPjltlfhKhi5q/u4qlU7tM7g9Hv/ywnDLPF6rXp5kYA5fawcGd9+HR6vnb7VQIvTIuZc8n1VzZMfL3eEeA==
Received: from CH3P221CA0022.NAMP221.PROD.OUTLOOK.COM (2603:10b6:610:1e7::12)
 by SJ1PR12MB6052.namprd12.prod.outlook.com (2603:10b6:a03:489::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.16; Mon, 21 Sep
 2026 08:37:16 +0000
Received: from CH1PEPF0000AD74.namprd04.prod.outlook.com
 (2603:10b6:610:1e7:cafe::af) by CH3P221CA0022.outlook.office365.com
 (2603:10b6:610:1e7::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.428.16 via Frontend Transport; Mon,
 21 Sep 2026 08:37:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 CH1PEPF0000AD74.mail.protection.outlook.com (10.167.244.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.451.8 via Frontend Transport; Mon, 21 Sep 2026 08:37:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 01:37:00 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 21 Sep
 2026 01:36:59 -0700
Date: Mon, 21 Sep 2026 10:36:51 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Banoth Saikumar <banoth.saikumar@oracle.com>
CC: "viacheslavo@nvidia.com" <viacheslavo@nvidia.com>, "bingz@nvidia.com"
 <bingz@nvidia.com>, "dev@dpdk.org" <dev@dpdk.org>, "stable@dpdk.org"
 <stable@dpdk.org>, Maayan Kashani <mkashani@nvidia.com>
Subject: Re: [External] : Re: [PATCH v2] net/mlx5: fallback to verbs for Tx
 memory allocation if devx unsupported
Message-ID: <4v222s7oeis7cj3xi4nqhlsccsgijyahie2ezonm42pbdl3gts@h2pflc46eg4c>
References: <'20260323113403.1984-1-banoth.saikumar@oracle.com'>
 <20260630102311.1050-1-banoth.saikumar@oracle.com>
 <alpmogwsv3466g33by7pyw4quhbbu27l3ieqgiexjvqj2ebux7@xuevtradpj73>
 <CY8PR10MB721959A164FE57489EC14C6788A42@CY8PR10MB7219.namprd10.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CY8PR10MB721959A164FE57489EC14C6788A42@CY8PR10MB7219.namprd10.prod.outlook.com>
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000AD74:EE_|SJ1PR12MB6052:EE_
X-MS-Office365-Filtering-Correlation-Id: d78d4560-a60a-4fb7-0d16-08df17bb8a99
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|56012099006|11063799006|6133799003|10067099003|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: kroiP9HK0HWs6c+WGXyTZyJsBGGoiswEBz832UHWDulcqpqhXIuyMYTV8wfm3av1iuGRB20oSBkG5lfSAY+CYjFRQudu/dqUH3Px9eGfaOS4wCwGTpFHdi60wPNMDf0rvLmXvNaYLYtZnXWngzyNN+mJ9sgbxHxuRs3/A3vnKzX/7UIswxEq9gaSnAAbY9DbooN0r0spKy9dvAnC99tJWReipTK87k1qylepXW8HXZ6I7RaHCCz4XV+pWCcYpapwgJXEaVuW5yDPGcmPt2U+AZR/r/oY801o7B+EFolUIGXU0rfS975KLvBoF/zVuNEMlbwmkVlV+GqFbD5QL1ENfE4AmQGtd9Siz88OC6HfaCxlxVLUvqP8xe2wGJ7w6unIdevXDH4y2L+MLly0kQcrFQwedlfSU3pwyl67m7PXVPV5kwC67WG2AgSGSzeutX9lW19cb944/qVKZazbVuXel8xx6LMVYwejwAjrvlLCRfqtOQr9W91hItGF6YAoQ1jKt0qMeZveGl6VIymEcNvcFf1NxCrFVaq2QXomZFO5T75MCEMoRZgZ6xbbvjXxalHswT3bjUjTBhOpQRd/FKzQPshjeUo2iuMHhf0bOcTQNRKMH5LVSBQeRlSgpF+3DFG1GFr6ITxKfRXdfdTmnZvKySSxRR3BLnGVDeN7qb8HqF1//VU/0oJhMUYfryqMonqLNLO6ViQzYAOBAfvy3M3kEw==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(56012099006)(11063799006)(6133799003)(10067099003)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: l7ZcopzO0OU0U1bNNEBHfwVyuZgj96p2+2K307k7xeSB3CjVOonu+zMbnCFxIOhuyBJaBhpejhHIR85os4QOOiUK1nfAduCp0vSMxj3sdL4pIBITTSYmoI/8kR/lLeEVqnevvGf6dVU4AXiPmcW5BaFXCzuKYFNIe13AKPvO/dTDgKnOhWHNSXgJOqtI8wIsjcfxcYWg3yCUWR1sPm9chAulFRYOaXegKKkkW5GYCTSwlPEWBjKIOKqisrzn0iNCsoX/61Sv8jJyupGtawJYxNvcKkYHyQvvkLztFDC4C9ndReE51tgYlW50XxQOYusYy7Wx1IrSyIbhAYnAhu1+RKaDmpPkYfPjfLu/fnz+cJfPkHAZKGx7NHQOzDY9Sin3S7Nb2OPa5XZXPZuYyh3U0MEYuphoOs2HAPk/2Hz1e/VKVAXTb+v7Ki5g8+mgOnlk
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2026 08:37:15.9891 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d78d4560-a60a-4fb7-0d16-08df17bb8a99
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000AD74.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6052
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

I apologize for the late reply.

On Thu, Aug 20, 2026 at 04:48:08PM +0000, Banoth Saikumar wrote:
> Oracle Confidential
> 
> Hi Dariusz,
> 
> I noticed that this patch was later reverted by:
> 
> > net/mlx5: revert fallback to Verbs Tx allocation
> 
> The revert mentions that on Windows, DevX CQ creation was failing due to
> a different allocation fallback behavior.
> 
> Could you please clarify what specific behavior needs to be addressed
> for Windows?

The problem is that mlx5_devx_obj_ops_en() checks too much
for both platforms. Specifically, it returns true if:

- DevX is available (sh->cdev->config.devx) AND
- At least Direct Verbs steering is enabled (sh->config.dv_flow_en) AND
- mlx5dv_dr TIR flow action is available (sh->dev_cap.dest_tir;
  RSS action can be configured over Direct Rules with rdma-core).

On Windows, the last condition is not satisfied because
a different mechanism is used there to create flow rules.

mlx5_devx_obj_ops_en() function and its callers should be refactored
to only check the DevX state as the name suggests.
After this is done, the fix can reapplied.

We'll provide the patches which rework the above,
so that original fix can be reapplied, in this release cycle.

> 
> Should the original fallback be reworked to handle the Windows case,
> or should the fallback be avoided entirely when running on Windows?
> 
> I would like to understand the expected behavior so I can work on a
> correct fix.
> 
> Thanks,
> Banoth Saikumar

[snip]

Best regards,
Dariusz Sosnowski
