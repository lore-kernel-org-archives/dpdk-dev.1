Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DB7FD26D7B
	for <dpdk-dev@archiver.kernel.org>; Fri,  9 Jan 2026 17:43:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5201A40C35;
	Fri,  9 Jan 2026 18:43:56 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010015.outbound.protection.outlook.com [52.101.61.15])
 by mails.dpdk.org (Postfix) with ESMTP id 6703D400D5;
 Fri,  9 Jan 2026 18:43:54 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x7nVLFDVa0MBp7qlRswzZcdszyktjcv2hrBv6SqhGIjCDIXSE+TKc2ER5cR53KUXlIqVLW/8L0bgmfm3wq6DIxfTB/rcCIRSfSaccr1LzvrqgFLkhJ4PasbT1H+LlaKxIMJzrkIOdnELYEbTh/yvyvKT1yGLkSdjB7qAjPgGkZxKr1TolLtaE6FtXIvsbP7RQ34njHmA2GlsZtZ/sGYca/8q2q92KLzBrIDrn+xHF2vqnaPgYNKj4sFXRFcX19Ag+plxSDCtEhP0VJHhywR44gsZ3vv03/yTn/Osrdc6wSYHifiPpG3ezSpb/BuDFflOx+Yw8BmsT2SVajc7+Z2oBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N2519mMub7371fQ7XLB9H+wOEkeGjnSWjizXE+dl0VQ=;
 b=iwgSvfo68VfowxRm83W8iK6Z341HLmNMZrgXARX9YmADYK62kZOsFslLkdaPNq5iUEikjc27vAxOvDAPmiFD4wQqU001YuiQwooGId4uFHFfpQs/Gkz7sdkoOLVX93K1a6n0LlpuXM32jy7SiWIeqhuV4kW4sLYlPXN5YLK5ROqUfLUDeXYMR1xbOEuxLgqtbAiB4UsE8sBqXM2YK+2rU3tIAFq6FVWpzPSWRBRnVdoL+AA5R7JCx6bEQ89VRktaxbQr9fKoeIA96NYigyrqLl+il9T1SwiqjOVuzmB0Z2m2CiQh6tvOjWg4LTUmBgjKLOuKtVcfOzWA9i5K5JruwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N2519mMub7371fQ7XLB9H+wOEkeGjnSWjizXE+dl0VQ=;
 b=fkwCOErEitXrSEhmKuIXnxTVfX3kzYuuegv7gScD3SG/IpXnkUeKIgemCVJiKTdd3s66vhOP0vbOeCITp6Cul3LnnXkpJOgenrmAODCxADxOayolGfk/OEuvYXAdkbsOvO8KbWp4xX0erJsGxiPcs+gClfO//JERJNSbaqy4S+Vl0uehLQBiu+5NNfIvVTkLDicEOB1KYe34enQBT5UFDCWHmZe/WA9pbbnAbUB3z29607uSVUKhbMUkH/U4QZ+1Bmv46kv/54hQ9bbfRiumfIF8MYlPsuvutriE8SVdE9AqocKo4qfqcTaG+rAonC9DHUnN4Z6dOnEbIYK2/5hGrg==
Received: from MN0PR03CA0018.namprd03.prod.outlook.com (2603:10b6:208:52f::20)
 by DM4PR12MB7576.namprd12.prod.outlook.com (2603:10b6:8:10c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.5; Fri, 9 Jan
 2026 17:43:47 +0000
Received: from BN2PEPF000055E1.namprd21.prod.outlook.com
 (2603:10b6:208:52f:cafe::a4) by MN0PR03CA0018.outlook.office365.com
 (2603:10b6:208:52f::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.5 via Frontend Transport; Fri, 9
 Jan 2026 17:43:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF000055E1.mail.protection.outlook.com (10.167.245.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9542.0 via Frontend Transport; Fri, 9 Jan 2026 17:43:46 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 09:43:36 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 9 Jan
 2026 09:43:36 -0800
Date: Fri, 9 Jan 2026 18:43:15 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Rongwei Liu <rongweil@nvidia.com>
CC: <dev@dpdk.org>, <matan@nvidia.com>, <viacheslavo@nvidia.com>,
 <orika@nvidia.com>, <suanmingm@nvidia.com>, <thomas@monjalon.net>,
 <getelson@nvidia.com>, <stable@dpdk.org>, Bing Zhao <bingz@nvidia.com>
Subject: Re: [PATCH v1] net/mlx5: fix job leak on indirect meter creation
 failure
Message-ID: <ezowyzibcbouoq7njhnqqun27fjrsskdcjcve3npxcrsnoremg@yiyp2p6miwef>
References: <20251208101203.315647-1-rongweil@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251208101203.315647-1-rongweil@nvidia.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000055E1:EE_|DM4PR12MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: 6fa5b252-7d63-462d-3974-08de4fa6a422
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|376014|1800799024; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?loGDj/7YVhxk3rBpiylPJ7Ck84tRSMM+gUP8Xa7zDuMXCwqZSNebs0nFnp07?=
 =?us-ascii?Q?4z1cttPy5loV7IPvG/mVH5zkjJ85qhtxlKZz9JwCJNRaJgVQofPWlIroV88i?=
 =?us-ascii?Q?ked0nb67+FBaw49aenHs3use4ARBEfNZVG3MkpK2o55f6Jkxm0ZYlEXcGMnt?=
 =?us-ascii?Q?kZeE607NiWXDjjHba4z9JiruQasMoxyU41K1yQ5hxHdKKD8dmR77rdbYZZdO?=
 =?us-ascii?Q?IU5C03Tmhs2re1f9HC41wXoprgtbTKjw0iQfo2HittUFSalupYkaQ2b1MJZz?=
 =?us-ascii?Q?B+KLKhZYPUxUg75aKxzQ+4qHfD9zM7hBJWBdO7Z/r3L4AwdTUgUjWwbms0wM?=
 =?us-ascii?Q?b0qsIW/VjFjZU2bGJj7Oy0UJCj3kwtVBujuNpXvU5dmni13zaK0huSNNfUVm?=
 =?us-ascii?Q?Bf374G096n701CrkxgnebfjAonk8wQZ/SkvM+/CkVTGa55Sd3H8Nv0oM717G?=
 =?us-ascii?Q?pCWWzN2mHIyROSaMogP3wAEbmd+Qa+ZcEIr9VI1GIITSIGKzpozHtQhWZPYP?=
 =?us-ascii?Q?FKA3ff6x6ytkFfwfX1o/s1Ly9mbmfDR2XSWrpy1RcyujzdJO2vfHsBpoV07l?=
 =?us-ascii?Q?jjkki9WXmGi1Xrt4MmooHYxKdgRLnlI8LDAt7c7uNR8eoBfI0j31Ch7lx7jW?=
 =?us-ascii?Q?QvBneOrjeUQLJtgLvjfDWZFClOCA3E12QX5lUCU7H0HLoxoB9jCSI9y7RDfY?=
 =?us-ascii?Q?biIgJAK3s54LQqjMUNwJQRhcaBJYpAP5hT1wqpTyLwrYiUBTt8w1w38CF2Tj?=
 =?us-ascii?Q?c9I6sVtBiWm4qhPDmmE7VUcbvVbz1fX35v4U8/pV/ThvvW9Pydp/6+g4e7ef?=
 =?us-ascii?Q?t47jqBNQ1ug+eel9aa9Mtd8H8lcwsjtuVMOUjfbTG3PcgV7g5cXmgrm4530D?=
 =?us-ascii?Q?UNKcjhd6RPLPCBwuhN5o6P0x4igTs67kk3poD84qgOnbYJJyECNnnlDvz5Jg?=
 =?us-ascii?Q?f2V3AucwmToizNzLAb+xDVl2VZt0+/0eL6mPvy+M4SN+P8Y6j8iKChSPlEUQ?=
 =?us-ascii?Q?gYJ8bGSOvDrzxeo8FluWv/1qESoUoJ8goYNNThqai392G8QKHBb9c6HH3pZn?=
 =?us-ascii?Q?ldjCJ/rNUSUJ0C9H7kk+b7qbjUjr4YHZktVawXG21WAY86bfbsp4NyJdTmVI?=
 =?us-ascii?Q?t6UENuMm7zRlfECNpIet9z03moUyeY0nO/M1ihj8uyCJOCjcnY+vJbeT9xHD?=
 =?us-ascii?Q?0D48njF9c4ZyiF56sUiXIIuc3Smnwp0ytVu2XuLMVQ1NYUePG9XEyuJ0Nkth?=
 =?us-ascii?Q?qgsEFurUEzEwh3IusodPMAtYvqGZ9dgqZx0NdPpeRlHxM+kbgWWCHPN7km6X?=
 =?us-ascii?Q?6lbZudDyVWAmFj2e4TGE34f6ad53MCIdg5pHklFleH40f0tlcbfjfwxoryTm?=
 =?us-ascii?Q?p3KFjBYqwoygcnpxc2v2kSVqzMm3hETSSkxZXeTxkh5+1bnzKS53OADvh02Z?=
 =?us-ascii?Q?BMEAPL1ZZCt/bo0ODGYOwyCDCKqBn2nkeNWhAYANvEgOHVyA5YIfL2AmIcl3?=
 =?us-ascii?Q?yO6h2LMMmI7F5kmlZ2iWBrSYbPqH23dNJKmF?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(376014)(1800799024); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jan 2026 17:43:46.8251 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6fa5b252-7d63-462d-3974-08de4fa6a422
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF000055E1.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7576
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

On Mon, Dec 08, 2025 at 12:12:03PM +0200, Rongwei Liu wrote:
> Indirect meter_mark action needs to allocate a job to track
> asynchronous HW operation to create the meter object.
> 
> When meter_mark creation failed, the job may have been leaked
> because there was no job cleanup code for sync API.
> 
> Add necessary code to check if meter_mark creation failed before or
> after HW operation is enqueued and call job_put accordingly.
> 
> Fixes: 4359d9d1f76b ("net/mlx5: fix sync meter processing in HWS")
> Cc: getelson@nvidia.com
> Cc: stable@dpdk.org
> 
> Signed-off-by: Rongwei Liu <rongweil@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
