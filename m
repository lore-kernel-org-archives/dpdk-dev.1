Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78A99C5B543
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Jun 2025 08:36:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B161A402EF;
	Thu,  5 Jun 2025 10:36:00 +0200 (CEST)
Received: from NAM02-DM3-obe.outbound.protection.outlook.com
 (mail-dm3nam02on2085.outbound.protection.outlook.com [40.107.95.85])
 by mails.dpdk.org (Postfix) with ESMTP id 1A2234026F
 for <dev@dpdk.org>; Thu,  5 Jun 2025 10:36:00 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Q462Ezs2SQVU+I1cZPYGi7X6sVddu1sqlLxvy/JWNr3PyUroruyfHfpKpCHgcXYgH9OXU0yRN/PgfapsrRfsiZcX/UGU4hRmfGbvfu/B0hj9Vl6rDJBpB+zB6YgKO0N+eoIKKhMQzv/S7j3he3g7XTrJAxNKKy3TfmHfIz67YggW2OJd0bOzXCZFmFp5mME2OZa7VvLZ3wcbcaM1etmoa73eE2a2Bd3xNst8JtXRbBDyVpFof4+K+UvWjHojczJNXPpzFzNSbN9LJT2g562mmRLBVd9xmcRTMTPrDLJ/+I2DSBKVy0Y9GDbXNz1S2NlY6JPZal44V9gDxKY8w2BFXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9ZKqnD/9JcE0hxNiE+AxYeKTGoiHavfYqtWlNwsy1AU=;
 b=HGMVb+halLC6H7BuZjF2XVJnKv2wujEpaMLL0uOY0fXE0tS/2G8LipEdFTYj4eCV9dnBdj7LNkSsFYGlqozp7OH0iBZXSQruHF+KrUiT75cudj5x9Fe2RCaWU3V1eogQ3MtYSfaMyBDoetwHb7rhY3Y37nvhiwHtacUdzb64GQQ14U4LW8brrYc3hab0OLT1yOMx7kaJWUELm8CzGVU52kLj1cM072G2qFJC08V2MgtZshzwyNrUiRFbUIJEDBdfTQOrAqxIuH68iyUdo9eEs/O7mABcKbbI51HUk9CGk7OFY9B6QhHvj0FgEhVhmpOZ6mx1CITpNriCbSUwjpNNYg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=linux.microsoft.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9ZKqnD/9JcE0hxNiE+AxYeKTGoiHavfYqtWlNwsy1AU=;
 b=LtHl7499DsFCFBH2zqbL1W5L4mmc9eRPc0l11m2b/EcRuObLt2j4gqnmL73L+c/xR4QvrKl3qANWtK/EdCpPYkTDcP2Iaj7AwhVw3IQLDHiaKvGDCrlsiTMMnugkekAvqERMYsCLO/naaAMpftJDokHI6WOyjFIUU9sUjyav+bbHRk3t3dsNCrblS1YQShSaGNN/TDVBLdmJ3Nn/wwZKkPaEya5EZ3HHvVZW2u2xDaAzybqU5rtEegpsvc8IET9h0sVbFGNiv3mO0c8DxAWRDH2/ir0Uw7FR6nD4f24C/aSDapVHA8/VqkgEEl9QZqVu0HZep+s4W9YrGF25UIltuw==
Received: from SN7P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::6)
 by SJ1PR12MB6099.namprd12.prod.outlook.com (2603:10b6:a03:45e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Thu, 5 Jun
 2025 08:35:55 +0000
Received: from SA2PEPF00001507.namprd04.prod.outlook.com
 (2603:10b6:806:123:cafe::b3) by SN7P220CA0001.outlook.office365.com
 (2603:10b6:806:123::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8769.19 via Frontend Transport; Thu,
 5 Jun 2025 08:35:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF00001507.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Thu, 5 Jun 2025 08:35:55 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Thu, 5 Jun 2025
 01:35:41 -0700
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Thu, 5 Jun
 2025 01:35:40 -0700
Date: Thu, 5 Jun 2025 10:35:27 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <bingz@nvidia.com>, <dev@dpdk.org>, <matan@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <viacheslavo@nvidia.com>
Subject: Re: [PATCH v2] common/mlx5: use intrinsics instead of inline assembly
Message-ID: <20250605083527.ltovebzh7ispeksr@ds-vm-debian.local>
References: <1746457062-8502-1-git-send-email-andremue@linux.microsoft.com>
 <1749046525-9166-1-git-send-email-andremue@linux.microsoft.com>
 <20250605083354.em4pes3yfg3nta7h@ds-vm-debian.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250605083354.em4pes3yfg3nta7h@ds-vm-debian.local>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001507:EE_|SJ1PR12MB6099:EE_
X-MS-Office365-Filtering-Correlation-Id: c64609c1-011f-4b6d-421b-08dda40bfd2d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?rUydy62YYR/Jhp+HGYaiztyLCefSeORfP/R2j2G6y2FH94AxmBU6faKaBuaH?=
 =?us-ascii?Q?Qj71jQs9J8I+7sTeq4IDqIeelGYfVBFjVNn4ylPnqrshA2BoCetRPSXwInfk?=
 =?us-ascii?Q?YfJyX22dNEkzdZaBdbgrULTN5G68uPGmcDX/8qET1GAnXe1adIos3+dJHkOh?=
 =?us-ascii?Q?m0QBc1q0wdB8kprap2F/K7BzfrkqRZ8QbsRwPnexf4l+aZhWEWfYgk3NUQ8A?=
 =?us-ascii?Q?Ixt7GhzR3WdDkznXBcpeA4R/1lP4GjYWaozLFccK+Ba8jbptS+At0br1/oOK?=
 =?us-ascii?Q?/RDuzIsSuq0CynTfqxV1oIHyAqN5oOJFp+OiiBtovDZfbntFXKfgvNnUDkqM?=
 =?us-ascii?Q?iOolYTQXJ6+xdxWWCONhrMJVdiUoea+hdU6HKiwF4R59xdNbgc8rZEhuk8X8?=
 =?us-ascii?Q?vhOWlhIgaKR9vLTOEhUWvuYBpbrZyCwXnURc4T+O3eJ4eWrUumIurPoG/nCl?=
 =?us-ascii?Q?67hk4Lc/bA+reJXo1eAS0WdC7PCBe4DQhrfJpFuVN7xv3qqgnmV1aqhjs6vb?=
 =?us-ascii?Q?V+RQt7zH10RXr8NyErABlWWHhJ8gKbktYT/jSZ3FE+ds4Dh+UzrAtI7139a4?=
 =?us-ascii?Q?7KG9ffQCh8yoJb7shYqs1YZD7epo4deTBxqLM4AIZe8mbQnEY4Y334P2DQaY?=
 =?us-ascii?Q?MpV08q91CQ9t1TsIIPpnMRkIkaUdmFpl3U9V/C64/LJomYZA7KrnFkFzPL7O?=
 =?us-ascii?Q?DyvRXCci14om1mj5MA+sYNqSv9u1WEXT0tcheRee492jc/blHzVOprjPPprg?=
 =?us-ascii?Q?sxOPrQmzKmI5ThzlwbbIQxDm3ggHHhrb83JLOq2eglnTYsXFVp0ariQrO8As?=
 =?us-ascii?Q?oCDS+y3S19RuuJhB5ejWEGKz7QFeqs67KW3dPqwgCc4j7TyLDi14x4AOQIHt?=
 =?us-ascii?Q?vpYO9jrsENsMumGUyA+oV5FTEJ0KHVesO3cPW16J9ERxzUzUiTGwHuIlQb7B?=
 =?us-ascii?Q?LkjGlfrNHkkjpgWwaymrL188N+5r4lAe3gxU+51TDKbK1S8w7kaDsy9ASRz3?=
 =?us-ascii?Q?Ygc1jh7TZYhOm+RmQIWbo8A0Ey5c+5B7FwhcPH6nn6Ez4UwXbS+nTfYYT3w+?=
 =?us-ascii?Q?sXQkwJAy8Ulz6Bo+go4sip/K5WhR22Ih6u+PjWuR0p/E3lbeTj5z3EaLBf/e?=
 =?us-ascii?Q?eoahF+MJajgDmQfW2sM7fTwpWtlwnQlktRGtTmAWOivEpyat4U56XiHECR4L?=
 =?us-ascii?Q?hRV2q91tRJ9cN1WXX95MpItl/7/g3CbhlsJiRhM96QsGKR+1d6xNqm+4+9EV?=
 =?us-ascii?Q?dw7Y9VA09qr9XWjPbjtAJTir2nFxg2l6B3wk7/iejKHH30uciV39C+/NSNKU?=
 =?us-ascii?Q?tjRwvTdUyfNGCM2lUl+67K70YsIAfgLtAwk+pYKySUDDd9jHqYai5QgqgYyn?=
 =?us-ascii?Q?vSpJAwPtoElnmor+eLfzrl5kDMCuahyK86Nb1tS8QzJ9etVm4br9ZUkLo1Gr?=
 =?us-ascii?Q?qd4P5g9t7TlExLHg6MOls1ABRtmR2goVidBLXnf9jADp8aNK8HPjPf56+AIp?=
 =?us-ascii?Q?XDC3XhYcVgKOh8JlQCuuZ89v9GV07DCmlHYP?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jun 2025 08:35:55.4263 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c64609c1-011f-4b6d-421b-08dda40bfd2d
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00001507.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ1PR12MB6099
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

On Thu, Jun 05, 2025 at 10:33:54AM +0200, Dariusz Sosnowski wrote:
> Hi,
> 
> On Wed, Jun 04, 2025 at 07:15:25AM -0700, Andre Muezerie wrote:
> > When compiling with MSVC the errors below are hit because msvc does not
> > support inline assembly:
> > 
> > 1)
> > ../drivers/common/mlx5/mlx5_common.c(86): warning C4013: '__asm__'
> >     undefined; assuming extern returning int
> > ../drivers/common/mlx5/mlx5_common.c(87): error C2143: syntax error:
> >      missing ')' before ':'
> > 
> > 2)
> > ../drivers/net/mlx5/mlx5_txpp.c(510): error C2065: '__asm__':
> >     undeclared identifier
> > ../drivers/net/mlx5/mlx5_txpp.c(510): error C2143: syntax error:
> >     missing ';' before 'volatile'
> > 
> > The fix for (1) is to use compiler intrinsic __cpuid and for (2)
> > intrinsic _InterlockedCompareExchange128 can be used.
> > 
> > Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>
> 
> Thank you for applying the changes.
> 
> Best regards,
> Dariusz Sosnowski

Forgot about:

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
