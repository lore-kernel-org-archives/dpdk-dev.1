Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D303C83F09
	for <dpdk-dev@archiver.kernel.org>; Wed,  9 Jul 2025 07:26:37 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 94D9B4021E;
	Wed,  9 Jul 2025 09:26:36 +0200 (CEST)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2084.outbound.protection.outlook.com [40.107.237.84])
 by mails.dpdk.org (Postfix) with ESMTP id 55C984013F
 for <dev@dpdk.org>; Wed,  9 Jul 2025 09:26:35 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t/DCmcJXr+WyTeXD5VY/KhFh+VlLwBrnMXUgBfQz3OvhKnFksOM0IbyKe/WI/8HObRIgZOn8VJ5QK5Ra+mOImroUQG6Of6QGSmHeI+TFCNSstux1rFM6I2EzxjbiH/8ORGxPs1VgODB9auq8AmqJqNQ0IZpV6yMps4SlDU9bdbBJ1z6mqB+t58chloRIY15mEbVCipZPZkXydAGq8EJljxbOdagPUynuYlK5oeVwuHZmrVNEUcfRYhxTpcSwsBJHOpbGMXM8FdH33pH1GiDS/sW9lhyL/s6IfmdkxMzrTbGIzF4olip6JAS/p6tWqP0slPhOBNim/tRWuTZ8JPL3Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CK7DR5bLQuwJvp5aFaCgRddjCW56VSlC1dhwMGSbVyM=;
 b=Beo0KABHDhyVOYnaehIFqvlbR9sby5QFyym0t0BijF2oi91KoF62eeG94roO8vWboYNFQFf6OD1N5fSJTVuvJeu83UCHOVsuyYHMcz1eA3aIqwpv+c6GrPJfE286ww/yOZJQ6O/7WMbKw6VAEDglGR0TDk+8V89wvv95gud7KXIS4KiWaCX2frNMJ+ZMkTfYXomY8k3wA28IbM71McoS/BdDoEXEFJxrIuTbo7U8MfEhi8np9EX4443z/OzXRq0a7547pjhb7RUdzRF62g6euZDlhzq76k+F92kcZmWgbU4UIfuxUUj6jVck0kpI4ME7b/eDJsqjilYpjPIJlH7t/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.microsoft.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CK7DR5bLQuwJvp5aFaCgRddjCW56VSlC1dhwMGSbVyM=;
 b=gQKhqPT2FGQq4KrI/htqFY3d6MVRiw+BaTjAXIs9oOilh8WILrNbeCUHzCpj7LBLKOtecJqZB6oHelaMqfN39ANqEitHkfnBTyJOunSVWNrzb6nhV8y5PjyhzDSvYJkdrS0PGMgLJ35blMgZDZyu0bZ3tl7/XprQf3LvvmmTAVVWwCZzmUIVbxC9kOvUpV5rOv5J5AQfwHo6H1sAIDwAvpYj1YGzcMKkSZ4uDuNrVirTv2FNaEIqqspiKwMQez2388yWjda3StofYJYg+P/4L9wXNPCeB5kYxFKVYLqpZ8zKjaVYKh2CeMsR5Fqc52KCUnegWVaEXG/7anYWMR2pDA==
Received: from BYAPR07CA0037.namprd07.prod.outlook.com (2603:10b6:a03:60::14)
 by MN0PR12MB6365.namprd12.prod.outlook.com (2603:10b6:208:3c2::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8901.27; Wed, 9 Jul
 2025 07:26:31 +0000
Received: from MWH0EPF000989EC.namprd02.prod.outlook.com
 (2603:10b6:a03:60:cafe::ac) by BYAPR07CA0037.outlook.office365.com
 (2603:10b6:a03:60::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8922.21 via Frontend Transport; Wed,
 9 Jul 2025 07:26:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000989EC.mail.protection.outlook.com (10.167.241.139) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8901.20 via Frontend Transport; Wed, 9 Jul 2025 07:26:30 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 9 Jul 2025
 00:26:14 -0700
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 9 Jul
 2025 00:26:14 -0700
Date: Wed, 9 Jul 2025 09:26:09 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: <bingz@nvidia.com>, <dev@dpdk.org>, <matan@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <viacheslavo@nvidia.com>,
 <mkashani@nvidia.com>
Subject: Re: [PATCH v3] net/mlx5: remove use of sizeof(rte_v128u32_t)
Message-ID: <20250709072609.an5o3r423bqqapmj@ds-vm-debian.local>
References: <1746457823-11135-1-git-send-email-andremue@linux.microsoft.com>
 <1751987516-30482-1-git-send-email-andremue@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1751987516-30482-1-git-send-email-andremue@linux.microsoft.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000989EC:EE_|MN0PR12MB6365:EE_
X-MS-Office365-Filtering-Correlation-Id: b9a943b1-5848-49ba-1d8f-08ddbeb9ecaf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700013|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?naWlz9gBjM8GFsdfIQ6Bha15AMibL4XvXzzy1ZZAKXpqVycgmQgA/TqjX+qo?=
 =?us-ascii?Q?M3+b2KPtqoaZMjLxn7YDncoES2PTiRrP5dfDo+UKUDX7xfO+dDzu43Rfh9nf?=
 =?us-ascii?Q?4qMPV5/cBtGEVMGePIKosWZoU50w0aXbjXOlFacPCawqZFZDItR6NDX/PKyn?=
 =?us-ascii?Q?byUYYNp6WCJK7s2O4vAZVpKeM6g2/o7x/Ae+ahfjDsMg3hDN0s6sJ111MofT?=
 =?us-ascii?Q?ePoD6uNzDdEr8U6RZnnydFb5+iumxsXG03pzmj/LTK0hDWQ+m2BLJGPP46JR?=
 =?us-ascii?Q?ELWQjVEaPvAxtfwjilghkQL4B8BU/ilURgBEZiwSal23nyTcgcfsI1b7FvfZ?=
 =?us-ascii?Q?kMT5kcor4r6aZkj/NnMOp8LHK1uk8lZ3y8x0KyRDZdQarymXgJtOwKihDCul?=
 =?us-ascii?Q?ucOIjlPvlMTR002l0Z7a8n/Wbr7R8MeRRjjD+dmKSATlMtDdq86ygmx09nSp?=
 =?us-ascii?Q?NS6sjH7YBXMbliL09cztPtaZ2JjhhAxc1C7gQqLy+3oR6PDWAMORMJkhH6+H?=
 =?us-ascii?Q?tWZp/CC0PZtmYb5CtDv8e2w6itrj/liRxTygcpmMBEfkD64i5RfP3hb7YEEK?=
 =?us-ascii?Q?WGHXmCsIQIBjFzdRiDz+9t0A4Xg5Sif6sUj8iK1P5RmUgusAvDIaeKbnwE8v?=
 =?us-ascii?Q?6Nc0HpgzgV3u5IdS5TB3KO0BCk4VSnfMvdW89EelEIS+n2A3gppzktHNfkFb?=
 =?us-ascii?Q?pBjHyg85DYZr1pvR+LLUboIa3XJSJkMXCSfpkPaNsypNB8uYcF81Yg/q4AuD?=
 =?us-ascii?Q?d8/AEkUgtRGhyiKZiRhBO/dPPNr9Kt0rqpo2gkXeV0OggJ+v5qRFrTDXwqAp?=
 =?us-ascii?Q?btgVA3Arrt0pHU6xzIPeMHDDKsWdGBNQjbomai2nawP3CJrhL1IBJtd6fHl2?=
 =?us-ascii?Q?5tMP6bwc2R1iVXcoZM+3GgNtikK6x72wHZS3Cnf61wcnQmiRm5PgFG1jCmzm?=
 =?us-ascii?Q?BLKhJZ2uXs0/KTitq89qi+2Rf2920ZqOHKJCHHksRaslijS239IGTT22dptP?=
 =?us-ascii?Q?PE+qgiWqr7sQGSdBcowotfSl6vJCoFia5Za9XLPnKys6MAx/Y255UGyDkmrm?=
 =?us-ascii?Q?QcrFKahWi/H1trSLWxcFL0EwxBvZr/CCH2qvZI/P59ULbER5XpjWVciIDWkB?=
 =?us-ascii?Q?mL0DNTdCc1CE/ooVF5c2AM69sEQImZ/q2yf63QbpqSpSetYgyyxQWjcsPG1+?=
 =?us-ascii?Q?yKtYQ4IfgHvVSjc//qqlCnPJmACsgP9aU357AFaJxLflklF6IBM5e76S1afb?=
 =?us-ascii?Q?/GNx9pKMO8X+ABwjQ0EvTVXjKhz0rwMtiz3TJG7TbTA8ltFkCrpbQovrSjGB?=
 =?us-ascii?Q?7nJdbrQ1mz/WXKjmCO4x+cK6EhIXTMZpaK0NR7DTaatWxYXOGCRE0IjePiSF?=
 =?us-ascii?Q?En4tIpL/yvWYRy4vVZrYq7tj0WOkvbYk/JmWCcv3TDyhd3kIylFmS8B6ouTk?=
 =?us-ascii?Q?J0S/3r5yAiQrtieJDfzNgEnpzfkuldt7v9p1jYCWAUKtXBBBo7ERtJ0WM3Fw?=
 =?us-ascii?Q?Qqd3WIJZAVGN6lUFSo82E7cLdzVd/Fu7dXkD?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700013)(1800799024)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2025 07:26:30.4230 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b9a943b1-5848-49ba-1d8f-08ddbeb9ecaf
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000989EC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6365
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

Thank you for addressing the comments.

On Tue, Jul 08, 2025 at 08:11:56AM -0700, Andre Muezerie wrote:
> When compiling with MSVC the error below is hit:
> 
> drivers\net\mlx5\mlx5_tx.h(1148): error C2065: 'rte_v128u32_t':
>     undeclared identifier
> 
> The reference to rte_v128u32_t (in code and in names) can be removed,
> because the code which relies on MLX5_ESEG_MIN_INLINE_SIZE does not
> really use rte_v128u32_t type. The relevant code e.g.,
> in mlx5_tx_eseg_dmin(), always copies first 2 bytes of the packet
> (through uint16_t pointer, these would be first 2 bytes of destination
> MAC address) and then does one of the two:
> 
> 1. Copies following 16 bytes using rte_mov16().
>    (Corresponds to first static_assert for MLX5_ESEG_MIN_INLINE_SIZE).
> 2. If there is a VLAN defined in mbuf, then:
>    - the rest of destination MAC address is copied,
>    - source MAC address is copied,
>    - VLAN is inserted,
>    - 2 bytes appearing after VLAN header are copied.
>    (Corresponds to 2nd static_assert for MLX5_ESEG_MIN_INLINE_SIZE).
> 
> The amount of data copied is inferred from HW arch and packet descriptor
> layout, not rte_v128u32_t.
> 
> Since rte_mov16() is used in real code and rte_v128u32_t is only used to
> carry over the length of the copy, this patch replaces instances of
> sizeof(rte_v128u32_t) with a macro named MLX5_SIZE_MOV16 to better
> reflect the real usage in mlx5 PMD.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
