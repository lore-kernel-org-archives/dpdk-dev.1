Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E053AFC5913
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 09:58:05 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3CC5340647;
	Thu, 26 Feb 2026 10:58:05 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011008.outbound.protection.outlook.com [52.101.62.8])
 by mails.dpdk.org (Postfix) with ESMTP id CF322400D6;
 Thu, 26 Feb 2026 10:58:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WzJfAqDOzjq1qwLvF8KX+zm4EdH8BDXUad09IrzdH/6qLpOTJVR1BYGlylZ42Q4JL6mv8Lye/fwtRA+bxkbrntY3RiVkTIcD8ZG7qq+NT0e1EP0ilqWfa0JBQwRG6erImtGK9pvfCkmL5h6X5NaYB4IFM9unAWDAP+Kfi91457vl5IPTADB1r8CumTUH+9HegkJKuCBgsLbotPLYS6EfCLK/PB9QeX0lBT+p1mhH3fSxI4UW10ibtTUsV53KCrzeHFiPBksqsryVMZE+dbTphg7sn6FbWUlz2MuMPOfCKPOh6MEnckwFu/0s/tpfJBjWCdBsWN1KFAtf+4q9bItBMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0eRK6kFD0Ue/5tx858SP7bAR9oNQtAF9/OWMW8RhNbY=;
 b=L3B10vQtDKFpMBbcYCEu8iRlV4IOWwEw+eHpsUvgiJn9Y1iXBXmWFEdDiAB+q0gV0Igu2WSQzySJNiharmpiTqxVQRarMg/WrA3CAp6kXH4CDth793PPazwRFwVdJpo/B2prXgEWOrpU7JUlifUFTK9xMnfCBR7zwn9q1QKew3nU4ByvmFQ3pjQmAWJCVBCCmlJzet6dxQ5Aq0LZ+9GS63Cnh2FIu1l0hsWdLOYhPUwV5mj2er4J87HCsTEWVaFlhba9PYvq0CXzwSuqFIoeBGANXSC8TszOVYfB4gejGUF82cGP1mSGVtQms0iZEWmuIA4v3X2qfVd7ZTzzTtErFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0eRK6kFD0Ue/5tx858SP7bAR9oNQtAF9/OWMW8RhNbY=;
 b=tETlL2kcmQw7xh6ktUbRIfcTjvlNff457+P306FSpn81aZTuNZslWZyhxc1+3GkTlxfgM59spLRnqd+dNb/C//Qn1sU+X1Wa9oCG5VFfeFsGW9FsQZvRV+Orvdq241oMAiRKypsyru6q+cYKV01xPXSuPk1Ce8nzUNGjs/+kTJ62jJJlLCXopHpDVe9E51JztDijQcW62gH7qCWu9NtZJSRuWD/mN9t5zc5G+P+JPIntIBZempQ0VPoqTvKl3QvMbNbvON6KLsjUBwWnIa8NoqwFE5ABe9ZTV9F4qumrqEIOYjBKYe3y3mH7Jvye61BR3YadqD6FI0xA+FcnUVXBCw==
Received: from BY5PR17CA0071.namprd17.prod.outlook.com (2603:10b6:a03:167::48)
 by DS5PPF8B1E59479.namprd12.prod.outlook.com (2603:10b6:f:fc00::659)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.21; Thu, 26 Feb
 2026 09:58:00 +0000
Received: from MWH0EPF000A672F.namprd04.prod.outlook.com
 (2603:10b6:a03:167:cafe::6e) by BY5PR17CA0071.outlook.office365.com
 (2603:10b6:a03:167::48) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 09:58:00 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 MWH0EPF000A672F.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 09:58:00 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 01:57:40 -0800
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 26 Feb
 2026 01:57:40 -0800
Date: Thu, 26 Feb 2026 10:57:34 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [RFT 3/4] net/mlx5: fix use-after-free in ASO management init
Message-ID: <kklaa5s3ggam473hhjhr4h7h2b4ewynnaugdlt6u4ylw7w7qpl@czfz5xydw7b6>
References: <20260215195348.557945-1-stephen@networkplumber.org>
 <20260217150635.134031-1-stephen@networkplumber.org>
 <20260217150635.134031-4-stephen@networkplumber.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260217150635.134031-4-stephen@networkplumber.org>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000A672F:EE_|DS5PPF8B1E59479:EE_
X-MS-Office365-Filtering-Correlation-Id: e7cfef56-923f-4b10-3b02-08de751d866b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: Ws0dSwKGp1djazIEikwuDmYIp888/RLESYHw3owfBIcmJRaVw4B5QFQ7rY+absLfc3RPLh4H0UEryG4gjB4ib3xYP+fiEKuRUU7rHiV6OU8wwjdyhXYdh97nG76OlLTOgQqLlawqgzwXj/jouik3Kk0B1wVMru+uXykOWVtxaMRz6aQk3jbOhk/kiZC8LMjvT5cTb3veuT21wuMRfm1crW9EcFpWC+8qimkc5Tf+wBs7fIzQ6RCBziBsCfmHJQftkzQqOhPr5/MrUahPIpt3IdNnDzd16u1V2hf9gz0ACnVFfFiwbc1BnkHcKovC05ZkZwBzZgAtPIULUnhsGDofHUR53htKYBrAToUqQuAzOOcQbUZBBC3pRjjJF/72Tl3lJ0dmmeSBmb3HWtly6NaDPyqQqGAE/1qRL+WMJNILrKBi2fAcxlONFY/JGNmR+t16cmZqiCMPd2n6lByW5DIcq0Hr3ToDlq+7AAxYBnCfQaK3mxkV4ImWxfwvA5I2KBJqTD1wYg64vvkgJUMOVXrR1MXfVxHlksJu6pHbYpvmpOzM3uT0/3Q/64uw1ypXlqRem0sPIwLconUDYM21yQIW4ghFnIiYbcNG9QXD/KsIuVyVafn6tsUOgH8hxM7+jsZ2hPBvqlMBPLfqWaSk4NBzTG9QxRG1RSafEHBQCUH7AYw7wmRQGpL8Oi8qQvXnD2WWCuOPUAU280/5T7sWPUuKFdB2u39liQpntujvWLCfV3Qdlbq8zInu1s60Y3R6O1Qq6T6C0cfQve2upqamjd2+bHGLpKyOe+1mwwNk1b9HfI52+fYoQ5BywHXwfjs39tpl+X37oAjkjBT0NqquGEgvTg==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: b9m44avLHpPxQSveNRA2qIKyP/Z7oj3QW0+vig/THnHWrPeSUoJ3EqRXGaufvDdcByYiu0Tzp2Bx7zjpVYpcWECweHbUfS+NTmbP7ddxBBaE1IKsp8ctwSQo27OY0DHPgtQbrccthU/Rv/XwgnT934BMPA5duf5jC5y0JcXnWsLSw5h5PeuwjbQYvUkWy9TD/p6gLCLBtJV3vO0j1m1PM5RWSU58/MJvfkeiIH0idE0EUjISd5T6OXXuTsZ8kAJKP1XLOS51kz7Xuus0NVBdeYGfmva7v94x8ZVogtryQWPUOjabXBrwJdbcOJKtTh655wryKZDI3ykmx/RTfZi6Kz6D1Ux+1tYmALTdXMWW1klXdwEQ3+O/5QKQn7FK5SeTinXqIToa7nSQnYepYTwb3eFLevFTObD7Wm2hiTBi7NGPT8xNYB3UM1zGmh5N2hGd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 09:58:00.1761 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e7cfef56-923f-4b10-3b02-08de751d866b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000A672F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF8B1E59479
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

On Tue, Feb 17, 2026 at 07:05:01AM -0800, Stephen Hemminger wrote:
> mlx5_flow_aso_age_mng_init() and mlx5_flow_aso_ct_mng_init() each
> allocate a management structure, then call mlx5_aso_queue_init().
> If the queue init fails, the structure is freed but the pointer in
> the shared context (sh->aso_age_mng / sh->ct_mng) is not set to
> NULL.
> 
> A subsequent call to the same init function sees the non-NULL
> pointer, skips re-allocation, and returns success, leaving the
> caller operating on freed memory.
> 
> Set the pointer to NULL after freeing in both error paths.
> 
> Fixes: f935ed4b645a ("net/mlx5: support flow hit action for aging")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
