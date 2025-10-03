Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D9DFCCA471
	for <dpdk-dev@archiver.kernel.org>; Fri,  3 Oct 2025 17:55:34 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 57FA0402C1;
	Fri,  3 Oct 2025 19:55:33 +0200 (CEST)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
 by mails.dpdk.org (Postfix) with ESMTP id DB9EA402B5;
 Fri,  3 Oct 2025 19:55:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xDFOsM1JaOfmDxk55MtFkNjzn6G+gAbSH+eAZFPXa20SYoiaRtXu8aiCBJDwn3FiNSPOwJumBuqfxQj6Y12lzuI4RX8eurcM7PZlK6wua2tj1DIOkEM4q7gRqJGnh+9phVsVm6RpIRApGyM9XkBkyBfWzbNvem5FwxsehAk2WuHpDnwKT1ufbSYKFk/swlub5CAp8TdBa93qsvp2aiJBaRiDgVNxMAghpz5/FMEGUzZuRyXkEJ0CCpPwIjwiR0S6F/EPqldogKKAu7uvSdd8Q6yn2CFijeU92HcZ+oJJOkRZsfERh0/7SA+b12fx0bG5PcS4MU67o7njrBhSfdEGIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1TSp+Hl8c1IEf2BU9Sja9VDoinwX7tLDlGB+gYsYHew=;
 b=hA42ZQkNJBCENF1OODnYzn3c6z/FKhd2GplWfr90QLVWVzEszB5nh639xSVXVr0FgtxgkcgI3DRG4c8Akp7ApCxydRe6bvO23Rk4RKLIShct6Gb1qJ2o3YTWYRnsowNWAWxC+hMhBNmZtRsPwNH01B7TueQC947vqGpA/5tXFp9ndY7QdAOhvF44ra09/BK7rNXKRGG09AI1Rd1M+HXjbAf0jdA1wIkdn1hP3xbUMZ5Sk/ZPKkdA8roJJ/ZOQ7o92OuTQk2LgJ9dYZmlaZom1idU5oXHl3iw6JzDvVh394S84B3y7mGMW9Z1PuZG70pJ6MTyNl5UYiSljDxhHeTrEQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1TSp+Hl8c1IEf2BU9Sja9VDoinwX7tLDlGB+gYsYHew=;
 b=n9zAIfTd+1MFxRSOfX9S483Ve6ibV0DIfKDJf62lEiLKoIpyl42ihB5xc5yipAqQRqrbyVUhWA1n65WyAIS0jijJ32QKa1q3Hd9N96xLcEQaxPWVKuxy6fKT2Iw4C/QrT3njjEtHatjjUBUJfCq8oMeEBhdu2t8wVth/suOTNL0aKU7Tjk853aoDjJ0vrzr14nQ+TRtEb+YbXMu9EVw4KHgQoAOz7UpW629Br1/3tB0W7tRcjD0ZHpyCZh/t0PlcDzrBiEl9fuhgT5R/FFMSV6y2ospumtUwNxhIm63uuFR2alOVZW7P8wLIqE/3slbyED1O8KRzfikNu9xs9UcpcQ==
Received: from CH0PR03CA0253.namprd03.prod.outlook.com (2603:10b6:610:e5::18)
 by IA4PR12MB9788.namprd12.prod.outlook.com (2603:10b6:208:5d5::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9182.16; Fri, 3 Oct
 2025 17:55:24 +0000
Received: from CH2PEPF0000014A.namprd02.prod.outlook.com
 (2603:10b6:610:e5:cafe::61) by CH0PR03CA0253.outlook.office365.com
 (2603:10b6:610:e5::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9182.17 via Frontend Transport; Fri,
 3 Oct 2025 17:55:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000014A.mail.protection.outlook.com (10.167.244.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9160.9 via Frontend Transport; Fri, 3 Oct 2025 17:55:24 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Fri, 3 Oct
 2025 10:55:11 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 3 Oct
 2025 10:55:11 -0700
Date: Fri, 3 Oct 2025 19:54:04 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, Tyler Retzlaff
 <roretzla@linux.microsoft.com>
Subject: Re: [PATCH v2] test/debug: fix crash with mlx5 devices
Message-ID: <20251003175404.iu7k2tnwtfbr4mpk@ds-vm-debian.local>
References: <20251002165546.523435-1-david.marchand@redhat.com>
 <20251003065101.617467-1-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251003065101.617467-1-david.marchand@redhat.com>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000014A:EE_|IA4PR12MB9788:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e10797-4272-40a6-5ce6-08de02a6075b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|376014|36860700013|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?Hi4/Ks7/3dgu9UkYo7KPOa0Pnmsu5+bOFHza7TeS0v266BYT9BiGEaJ75nLt?=
 =?us-ascii?Q?cYgKmq1dn8KG+L2lXr6S/2Ms8ior+xrVNWBoCXWgSxoKEfjVS5BeMyTjNJbZ?=
 =?us-ascii?Q?UzjgsYurWUckQ9Ohkp6VQQSDzPXVfeuwaTr0PTqf3JaqBydsLp120yqal1GB?=
 =?us-ascii?Q?wAA4u1ipahCJaSfMGWu/55ZLqcW+Wuetfy8trnqmXSmVHRYZ7/4enXRPjYkK?=
 =?us-ascii?Q?imbMaJNCjTCGFcLbLFokfCIKJrQJG16/UjIN8kboy/xCf1qt/FVS6jPVNFgy?=
 =?us-ascii?Q?qngjA7qwGq4W58oR6ITKoyjFvjVJY6QeJkNQEY0n0Ae1DgcMWL4ZEw41EoU/?=
 =?us-ascii?Q?lvPBd39P6jkiOCFhKuR3SKteBjZ1Z/sSPtVeupPx1Ya77Ti3gZ30c1dHiOsA?=
 =?us-ascii?Q?qbvvL95QfyXMVL+9LgOyEHLdE2bZueS6I37OxrlweVkKD/PJNqZiIyyyBjG8?=
 =?us-ascii?Q?cn9aV2YN44JUbtvPIGp0IkYM3rnqCc5NRdNSR8W8FZjvtNLjY7uH52GaFnC1?=
 =?us-ascii?Q?UeNygTG0f9FMgX4RX4EaHqUhrl3diuMYHaErJ7LltnjdIrU9KjVc/t8knTSL?=
 =?us-ascii?Q?2JQp/9naCSxyZJx4EKnAOAp2JXqLWV9E7+t1uppx71HouiE/uQ1IGedlyWyd?=
 =?us-ascii?Q?3Eo9fEvzH8s2EL72T6r8RRUGiovgTYF8IzRpHsYg6nxOSylxzqtTD+OcbNmo?=
 =?us-ascii?Q?rspAfgANTefm8Ejnd/UPwqSsIh5nQilALzC3bIJmldlbrKnOfve6SjGwUrjP?=
 =?us-ascii?Q?YbF2qrgRc40Vx78oTpPwKLba6lOWOIemJFZc9DNC1U49h1WmqNGPTRsltx4n?=
 =?us-ascii?Q?jY1/yWjluMR2adYE541VPCgL7PptSZB0DKJ5AjtmqkFj1htfl+Xl6I5P16K0?=
 =?us-ascii?Q?e4/MDifUt7bFuVtc4+OTCjferKVX9GVGi4e2Zhc4Kwgaz6M1a3fYxJ3eRaJb?=
 =?us-ascii?Q?ObPYruMw6528LueIxvsis2RAMOOIrjNL40FVGkBFzL7yfYa6BB1GLvWwdGZR?=
 =?us-ascii?Q?bwxJhMxkISGAG3pZ5/J1qUmex+sXVUX7T39fHkDsAemmE8QjM29JHsabtpeQ?=
 =?us-ascii?Q?hNcNHVTTuVl9QQGepcNDhBKLO1MJZ50ySuq7yJGNHYstUMsC4rwgqCadRVnD?=
 =?us-ascii?Q?RufKlD/7hpu3ZfFb5rG7Dt1TVsZjW+BZeYpoJMLA5AfKwBVaVg4KvXT8qirg?=
 =?us-ascii?Q?Z0V4AHD42848PenYNYZPSifA4y37Up7QMMkfmK/8gPVwFRmmO5gPXParqABT?=
 =?us-ascii?Q?kKcxCgizivuX2iuCz9NbKSc2D4FavY5m/V861z7ajGfwoSRum44+9ZLUt+uS?=
 =?us-ascii?Q?FzGxBPzUhUxe9zqN3LRGAJjp0tXYUXN9PaVFLvQernLmHq8X+a4vJCdLIuZM?=
 =?us-ascii?Q?ojU7bSaLUDNnr23aWPAvMlSGCWqb7kkIokJIpFWJ4dgOusDzTGczgdakMQdh?=
 =?us-ascii?Q?kr3ArPydC6vGn+z/hDoSh+0OTqxt7VPU7ha/Noh8hS115cLL+NwyTh2+/uc7?=
 =?us-ascii?Q?y7rbS3VI0BAlYephqThayVDjDqWhnFccRPxpAIJn8Pap8/rWc3fscAtQ5Mim?=
 =?us-ascii?Q?KvMvdam7KuNhmPZ6AH0=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(376014)(36860700013)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2025 17:55:24.2903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e10797-4272-40a6-5ce6-08de02a6075b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH2PEPF0000014A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9788
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

On Fri, Oct 03, 2025 at 08:51:01AM +0200, David Marchand wrote:
> Running rte_exit() in a forked process means that shared memory will be
> released by the child process before the parent process does the same.
> This issue has been seen recently when some GHA virtual machine (with
> some mlx5 devices) runs the debug_autotest unit test.
> 
> Instead, run rte_panic() and rte_exit() from a new DPDK process spawned
> like for other recursive unit tests.
> 
> Bugzilla ID: 1796
> Fixes: af75078fece3 ("first public release")
> Cc: stable@dpdk.org
> 
> Signed-off-by: David Marchand <david.marchand@redhat.com>

Looks good to me. Thank you.

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
