Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3190C5AD49
	for <dpdk-dev@archiver.kernel.org>; Tue,  3 Jun 2025 16:42:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BAAA40E64;
	Tue,  3 Jun 2025 18:42:10 +0200 (CEST)
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2080.outbound.protection.outlook.com [40.107.244.80])
 by mails.dpdk.org (Postfix) with ESMTP id 1EF1A40E3B
 for <dev@dpdk.org>; Tue,  3 Jun 2025 18:42:09 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VqbFK2gSry1FB6fbrPQKMp13fnCHdJJbKEtvNcUMK4YLN929PNpLiaRy9d3n/sGbXn2BaGdzASLPwK/FHqIi2gCbX0e9Il7srRMKfVou0Fhl7fj07ap4hhSChmVxg6iDIwKhG4769lCae00DydT7/1eIQPCtFSkXNc4vrvQ4klpMjN5BVxDck/elASY9c0Q5TF8TUlmiu/zVQiYt0+6UyHOwtHM55iqxIxLC/ZAawOKFq8LegXn8jfNoI2e8XsRe2OpizGPH9hyyEQpoGZuP413nQh1im8oL+iECIsAS8yezR3loK34EG5Zx7CE+ad5wBFgzXiMMijNFmEqDhIadFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+V6Y3se+dalCXAetMfPwZu7xppfDfUod0Fdek4bELQs=;
 b=dckMwJcFuMX9BYAhJL5rVhiXvMN+aHMRCZzX7NWU1Vy4QyiyLoSPW12XWEznZNcfgAKLAU1tqqIOonrL0JwVbVZgyE9Xrt5HFjSRk7obU1NQpc3K3DmTYCmlf1TwWJMYeThelXnx8lAP8mwhBfy7HDlaS7xOVrnpAGTaPE8Z6FW1ZG0ZqalEMP7wFq5td93iRWUEriD0RjKJaXA3abzsVQkirjoq7QDwbUqfufOYZbkKdgewwBbNME7kHUYbmjR1gQemnTU3XISYy27NeKK+ey7soisVU09pYwuio/dW801vvrKL0iN9T0tvzSeHOSdUauVachJeiRIv/Zu41pi72Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.microsoft.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+V6Y3se+dalCXAetMfPwZu7xppfDfUod0Fdek4bELQs=;
 b=Up3Cq6Hg7Jj2h2CCgJVjc7s89AeUkE7lMZrglZAZqLfxTqriLZ924SzyRsVHeYkUkId4auS6/kTHUSb3SZ2Otnz8ZlqSghw3j8N7z6aKN6HYt9yA3sTPpW3ohEzT8I7inm+MrpflueX8M0t2DCBZPJewxfXZlXWoD5rtlVa9yJINzqbmWLDYhXnAX3ao+cyXpE6XrpjfGxh2eQF/rFMsxFWtcZkJ2PGdbSKskqeYKFWGeVhK/81vQ+IMPzeyTV6k62ffv9RsGCrEYKabCXiEGphgQcJv9M3q0PjjJ6cxAAYvLGLYrQ4V/Tn8cAjJA+rBOPeWYrv7F8FPSN4H7HOxmg==
Received: from CH5PR03CA0018.namprd03.prod.outlook.com (2603:10b6:610:1f1::18)
 by DM6PR12MB4123.namprd12.prod.outlook.com (2603:10b6:5:21f::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8792.34; Tue, 3 Jun
 2025 16:42:05 +0000
Received: from CH3PEPF0000000A.namprd04.prod.outlook.com
 (2603:10b6:610:1f1:cafe::90) by CH5PR03CA0018.outlook.office365.com
 (2603:10b6:610:1f1::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8792.28 via Frontend Transport; Tue,
 3 Jun 2025 16:42:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH3PEPF0000000A.mail.protection.outlook.com (10.167.244.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8792.29 via Frontend Transport; Tue, 3 Jun 2025 16:42:05 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 3 Jun 2025
 09:41:46 -0700
Received: from localhost (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Tue, 3 Jun
 2025 09:41:46 -0700
Date: Tue, 3 Jun 2025 18:41:24 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, <dev@dpdk.org>
Subject: Re: [PATCH] common/mlx5: avoid warning about operation mixing
 different enum types
Message-ID: <20250603164124.u7rrxwgwe2h5py2n@ds-vm-debian.local>
References: <1748389285-26763-1-git-send-email-andremue@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1748389285-26763-1-git-send-email-andremue@linux.microsoft.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000A:EE_|DM6PR12MB4123:EE_
X-MS-Office365-Filtering-Correlation-Id: e2ae6fc2-192c-4464-af0c-08dda2bd931c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?29n+0rDBbSudgqOwNrTW9N0EsK8xDtzkJnZfaUN1DugdBkwB3aF8aZOJq3Qa?=
 =?us-ascii?Q?K6pNuTnDHzl2cRvB/tSRyYx9RGQI87QNOZW67ZtxwwFILGN8b6ZVlZ4HRGT5?=
 =?us-ascii?Q?UtEDOb1EJHaGPtloDW5mLag0WqS7S18RaTU5kncVoGgqfsl3/E0JKTY+UM9c?=
 =?us-ascii?Q?vDUeinH54jJI9cytq7RHnXTk09giX2wr79Abtx/GiOuc6C/4+R+GacWcmnrC?=
 =?us-ascii?Q?c9Y1Q18nElHNa8Za+y2C09oY/c5xjoqT+zIGFgpme+tDa3Faa/p5RkIc34+z?=
 =?us-ascii?Q?fPZsTdBm6YJ2BQm7CQwFaJKWc1KyX1BcjgcxKpcm5iDpJbzRTUh/mfe9eq7Y?=
 =?us-ascii?Q?vqd9SYiC8efQxpH5hEUzh9DHbAhCTwvfzVQvAAAI3PbuCcmTHNWbFyjIypJp?=
 =?us-ascii?Q?iOgKghiApmEIG3zqhTjlHNedynMWux+GnVfTDmzGXLiQgT7CU9kz6qydI3h2?=
 =?us-ascii?Q?MfFJrz6vPBOKChFNoQP542VqYOJ7I0pT2Tb2HtgvY86VRyYIy9I+5LizKA4M?=
 =?us-ascii?Q?44m64DJjkA6f5j9hUCnnQjw/nxyHPUqlVOVg3VBLJXJqZ8PvxPH2RSH49h7t?=
 =?us-ascii?Q?Jt3GxlY48Qa4cwAcKQBcykwtKcUgGFuJ3CoDNiniu5xACCu/DCVzmYzZ9SFi?=
 =?us-ascii?Q?IbADVzgR0KZd0eUq2PzH4btT1SiY73yekM2zBgZwyHJ29ZbolmxlkPk/nvf1?=
 =?us-ascii?Q?zNGB00gszfmJRAl9t5VWDDPuwAmqjRLPrZXUy8rLqHxmd2kKwxzXxp0ttI+d?=
 =?us-ascii?Q?UBPGK3kqf9GXZF7l9sro2yZOGf+KaRxPfrwUIwJC0zZPnMPViPrp8++AX4KC?=
 =?us-ascii?Q?yfW23DqcpyVz/INLPwjgtT7cAkLuzV3Fh0oD58M9VO5xuuXBYiFutNdJqkjp?=
 =?us-ascii?Q?QmGum122KP/Am0A4bNx6iw1P4xAoFWJGd7tqvXF2rPaBeQb+XmtXfvYQuOPl?=
 =?us-ascii?Q?3IzB3sibL1ymoaF0AsAcf55GPfIgjYDJBLu3oefFg6FkKNPzPfs6GpW4cckG?=
 =?us-ascii?Q?rSsD1/ryW3/MZiJ3ffKYfEgCDTtr1x7s5u7jZTawafrkN96bIdZ1pmhEClSX?=
 =?us-ascii?Q?n/nTHeC70V00HVJgHcYjMqWixZLpZ+vkYWkqZFAzgooz2cwidXG/2HYh+0yg?=
 =?us-ascii?Q?L86mZXpuA0XJM2hSh3q+Vujl+lApXpryVTem8MEtYbMJKcobXROqXTzHDpG5?=
 =?us-ascii?Q?p8rBilbTiNQ1jxkEPAVMIFe/Ygz2yC3/oYSGS4m9ZK9Rsu14Iq+VIJ9tftk5?=
 =?us-ascii?Q?UdPAH69ZYUSTyIsxjrIqk9D/2pHcOwSyyGS+iLbDXzZllTg8gpD0bxtpsBRo?=
 =?us-ascii?Q?YASXLqJrGlbkwmCSCD0/nie96av9ABoHBRIqQaqjD25S3RsGTTwLURV0lgHp?=
 =?us-ascii?Q?VYEPEg1N62qslFaTbRP2ZgTbMBbVfOYxPjN99dhJjnf8phODmbwQYlw6xgFT?=
 =?us-ascii?Q?TaIBHoBaaMvE0yQ31TFNRvAtBs/lI5Lc5RF17R9n3ZzCnfugJz2MD1zKnq9M?=
 =?us-ascii?Q?cxRj9z2sKbwXkgpGuxzOScjC5Lvu85awnNvl?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2025 16:42:05.5679 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e2ae6fc2-192c-4464-af0c-08dda2bd931c
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000A.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4123
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

On Tue, May 27, 2025 at 04:41:25PM -0700, Andre Muezerie wrote:
> When compiling with MSVC, warnings like the one below pop up:
> 
> ../drivers/common/mlx5/mlx5_devx_cmds.c(554): warning C5287: operands
>     are different enum types
>     '<unnamed-enum-MLX5_GET_HCA_CAP_OP_MOD_GENERAL_DEVICE>' and
>     '<unnamed-enum-MLX5_HCA_CAP_OPMOD_GET_MAX>'; use an explicit cast
>     to silence this warning
> 
> The values in both enums indicate that this sort of mixed bit
> manipulation is intentional, so this patch just uses an explicit
> cast to avoid the warning.
> 
> Signed-off-by: Andre Muezerie <andremue@linux.microsoft.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
