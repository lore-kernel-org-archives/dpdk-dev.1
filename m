Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E19F7CEBF97
	for <dpdk-dev@archiver.kernel.org>; Tue, 18 Nov 2025 14:46:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1F40A40265;
	Tue, 18 Nov 2025 15:46:34 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012002.outbound.protection.outlook.com [52.101.43.2])
 by mails.dpdk.org (Postfix) with ESMTP id E8F9C40150
 for <dev@dpdk.org>; Tue, 18 Nov 2025 15:46:31 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8bWrk/4jaiz0H4QNmP3F1nxcWCY/H2dYES6jFingNioKGICB5BjJexZFgI1zXUYnA4RmvymT9Sj7hIx5dSA23KnCjFNL9HdHMPIinY+6jehtDsyffy4r6QvvzawxmyYF9kTT9SVQtZZ4kLsxTtErEM4GahubDBdzRm1zawTGmC+F0OUJM/78sE6QxQ+X4EPoItGadlb7OO/nJvB20uRTDd2P5V7fMa1RjUasblEeJDGmsYhUWvW1FYqEk0QpUuDd5b4Wdj+3rrKVL4DTMvd3vqR+dZVcarK4qNGnwE8bImZUv+aAonctEWAn4J7VvdVp0dO6ES+8bk2GYzQsPOl8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jceJcyOai402pT6mDnj8DLbe9cSX1uyO7PlOhhKukvQ=;
 b=X8bIsl+C77fAJi+tT6VZyYmZh0KtSVmTogDHJFz/7JHjyTH7kXjkY6tXqMmVnxj8RCT2SCWK3jX/8We81E0boeBb+N8vUJIROil56ip+AmOBgL66a3f4KiWhcwBDe6kjkSizk23uYoT7NZ9eZYAlUXHKmWesOLYnwQp7ZLOBM3wBxuDCMYQtTErol3+LVKoi45LwI+B6u5OqyKdOOVyNaI+Uf7+rUHi2U5BLTKX0ECtx3MWKZyEOEqo7C1YLbb1mv647xYdHmVA4U/L3+8JgX8f4urpKk/ZT9NYMsgn9Hh+RuWcZzEPqsG4A63yxfzWh0VzISNYMHOQSaoUhC4+nqA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=networkplumber.org
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jceJcyOai402pT6mDnj8DLbe9cSX1uyO7PlOhhKukvQ=;
 b=IVE+rFmNo/G0auiLjQA6hyTqX4feNNo4SbCY2FIkPBNUuc+1e+nyzug/KdjgLPiha1twjzpwOpYV+CGtD7Q4zWX07z0T2kcNHT3lC+sKAHd9mY26vZXRfgOajCFVSsc+d/OYzPuiTZLeOayuEME1fydUP2NEXtOwh8qdUd7AleAbB5sjQ6zcwshPBNdsE3t79UzDs5b8ljTNpjGU5UOiNeHuNKiew+EWb15pP2qddMhQKCSAvMfzi2AQ9JWNPayCYdhwJqA68KB2KTqYmzBBcqNta5WOsP6p5aom6T9TNM9U9nJnOsU1nzN4YvNAWutOL1J4ZiuizCGrHyc/bEM+CA==
Received: from BYAPR11CA0054.namprd11.prod.outlook.com (2603:10b6:a03:80::31)
 by BY5PR12MB4036.namprd12.prod.outlook.com (2603:10b6:a03:210::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.22; Tue, 18 Nov
 2025 14:46:26 +0000
Received: from MWH0EPF000971E3.namprd02.prod.outlook.com
 (2603:10b6:a03:80:cafe::8e) by BYAPR11CA0054.outlook.office365.com
 (2603:10b6:a03:80::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9320.22 via Frontend Transport; Tue,
 18 Nov 2025 14:46:26 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000971E3.mail.protection.outlook.com (10.167.243.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9343.9 via Frontend Transport; Tue, 18 Nov 2025 14:46:26 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 06:46:03 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 18 Nov
 2025 06:46:02 -0800
Date: Tue, 18 Nov 2025 15:45:59 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Stephen Hemminger <stephen@networkplumber.org>, Yang Ming
 <mosesyyoung@gmail.com>
CC: <dev@dpdk.org>
Subject: Re: [PATCH v3 1/2] net/mlx5: improve socket file path handling
Message-ID: <20251118144559.hpcgungifxd2hv3l@ds-vm-debian.local>
References: <20250321132750.4237-1-ming.1.yang@nokia-sbell.com>
 <20250829144954.2576-1-mosesyyoung@gmail.com>
 <20251117095842.496757e5@phoenix>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251117095842.496757e5@phoenix>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000971E3:EE_|BY5PR12MB4036:EE_
X-MS-Office365-Filtering-Correlation-Id: 3b5d4e0e-73d0-40f4-3d5a-08de26b14041
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?4rsCty0sely/OYRuR0TNgewos0gqqEnydpriZhA15/mhmrtWahMVT0UOHJAe?=
 =?us-ascii?Q?NW2IdkbIj6+zdUYssz72eoPovKXMCmQE1FDyuiljBUFI8X+rtiyI9ATDJ2kB?=
 =?us-ascii?Q?+oB7miLoVnBux/NiNnBp8aA3PpMUhTmj1s07z6Bfnk2v7J7SaxcDzBTJgApB?=
 =?us-ascii?Q?n3NSbmC1uBEbKLwQcsy7d6mMqMwI5md9rGXQOV9KxYaAQcNgY3qSNITCvC8A?=
 =?us-ascii?Q?7xYdme0owdXIn6jCgnmNbZJ+vAyVcN4Jzs9XptmErd2a884Go+Ksqvtis9O7?=
 =?us-ascii?Q?9Yyd2loZIsfaf0zdSiE09jg/Kqv1leC5gX8ytl7lhF8PgepFMGgqerDLrZBZ?=
 =?us-ascii?Q?Lwzr6fy017IHyafPDbkG1Xn8gqlRk5I3JK+grKdBcPWAGnrMyvmc2MMUOxGr?=
 =?us-ascii?Q?Gc/BUYlX+Pf/ejtHpSRS9HhMob7oLK+TJqn7GGR/3bSkiTQLnhNw1N1fXfsk?=
 =?us-ascii?Q?XhpdoSLhedNunzIWfY5Kc3sL4wGG9pDXXMATKp3hinrZ6wrEmW3Ar4ef5btv?=
 =?us-ascii?Q?wT83SHT5PfMLVM8tU4K1u7W5GtXXL51iFykG2lVHe3YT/J1Kt9Pj1vXoQnW8?=
 =?us-ascii?Q?lD37KfZngPwU+M7WK0UVMWMvd3E6ZED/JTD7oj9neWUzIH61wibB7jZn8hFQ?=
 =?us-ascii?Q?g+8i+DixzxwIripbWyCjT/pnICA+P6kUuHKWVcvNW85jbbVeWeg9vTGXhpN1?=
 =?us-ascii?Q?eSm+3UXNGKGD26DQU3gtQ/vggHYdFXxy6g7d8NQorf4HWubzLOVB1s7kIvXP?=
 =?us-ascii?Q?iTs131KQkKblox+1NXr6WrBp5NLgtSRS5Hh1sR0R36Eeg84Cs2iMfKri1UXe?=
 =?us-ascii?Q?DBAhm7CmMyauTq5C/6xRQH34QyGpXko3t3UcJ5uybg+DuLwlDHT4U9m05/3p?=
 =?us-ascii?Q?z1C6qo/CX0S9gLD/kt+L8GjqbXBZN6nZOEBmw98/tnW4YK6FIEd/i9TYoi/+?=
 =?us-ascii?Q?4HNWKfbIb3zF5vysF6VulmnFTW0l60jnEEfPEkQ635vNqnUrtYqQ/vtaHAAE?=
 =?us-ascii?Q?SXoX4fY/buUYJUc83RUE0qf2LpBeUZPmki3Gs2zZL1lvpKsrZ3TwF/AK3Oii?=
 =?us-ascii?Q?DxhV8xqjbQif8Dd/5DSNPg/FsD6spTAaqq2vvwBAY0ENMFbf5E1behwp/5bq?=
 =?us-ascii?Q?vHedGDUn98MI+lTNVsnP6TSWM8H8NFKhRH7Rb7ElgXiu61yJlydGkKfD7k1G?=
 =?us-ascii?Q?/i5TSqZHR5QMylHGEUD8+nj4av6xnmvoLr2gly46kTdZ0LESH1DQnLn8yW2i?=
 =?us-ascii?Q?ge4Eup5GCmEA1f1FR5MV/5mTjP4K2pWsD9nCt30CFHY5OopGKLadGjusKf2D?=
 =?us-ascii?Q?wD0oxbJDyzI7EwpsP/NY2mm8ypdAnDhH4Pl8ndBbkZ7dLjYmISZ8aX8SpqDu?=
 =?us-ascii?Q?0mcRtwLTYMql0Yb9LmmPCf750DFQtJzf86uip8/8IEt/iORRa64aObDkc/Qx?=
 =?us-ascii?Q?AowJYuge8xak+7HUrg/MqYS6I/MjbehvQvUPYcKgTirFTLDBv1cO+VeyWUDZ?=
 =?us-ascii?Q?zeyNi+MWYLwAGDxH7MnMp0L3vPa9pnnG5bJ5LDPim7N3cPANXV0whxHCta+b?=
 =?us-ascii?Q?sq3wZ4AaKv2zjrI+3dg=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Nov 2025 14:46:26.0718 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3b5d4e0e-73d0-40f4-3d5a-08de26b14041
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000971E3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4036
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

On Mon, Nov 17, 2025 at 09:58:42AM -0800, Stephen Hemminger wrote:
> On Fri, 29 Aug 2025 22:49:52 +0800
> Yang Ming <mosesyyoung@gmail.com> wrote:
> 
> > -#define MLX5_SOCKET_PATH "/var/tmp/dpdk_net_mlx5_%d"
> > +#define MLX5_SOCKET_DPATH "/var/tmp"
> > +#define MLX5_SOCKET_FNAME "dpdk_net_mlx5"
> >  #define MLX5_ALL_PORT_IDS 0xffff
> >  
> NAK - should follow current Linux defined policy for services.
> 
> 
>     http://0pointer.net/blog/projects/tmp.html
>     https://en.wikipedia.org/wiki/Filesystem_Hierarchy_Standard
>     https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html*

We have discussed the series internally and we agree that the proper
solution would require dropping unix socket in /var/tmp and replacing it
with either DPDK runtime directory or another path in /var/run.
Since such a change would break external tooling,
we are unable to do that in time for 25.11.
Regarding the issue reported i.e., not being able to create unix socket in
/var/tmp when this directory is not writeable.
It is not critical, because it does not prevent probing.
Unix socket creation failure is logged and PMD moves on.
The series will be dropped from next-net-mlx tree and
we'll work on fixing that in next release cycle.

@Yang: We are sorry for the inconvenience caused by dropping
of this patch. Since the changes required are also depending
on tooling external to DPDK, we would like to propose that our DPDK team
will handle this fix in the next release cycle.
Of course, such a fix would include your attribution.
Thank you for raising this issue and sorry again for the inconvience.

Best regards,
Dariusz Sosnowski
