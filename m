Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7486E91290
	for <dpdk-dev@archiver.kernel.org>; Thu,  5 Feb 2026 09:07:18 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD60E4026D;
	Thu,  5 Feb 2026 10:07:17 +0100 (CET)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010004.outbound.protection.outlook.com [52.101.61.4])
 by mails.dpdk.org (Postfix) with ESMTP id 0276240264;
 Thu,  5 Feb 2026 10:07:15 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XPUJtyREoJRbiR+DK17RsKO6D639Yu6PJu9vsFi+gHDQuwNXIa0FFJmL4fh9gDw4kRoup+mrxKrydMCD4SYRxCsHmYgSj/r2oyocLIJEJnlWheuen3IRhABWHoLWnPyOLB9CeQZUAnNjMS3Dm7Qv+VTz2gBeXScpyPB1luW1w2k2ZWKaF284S64gxZqql0XOaitQjpwQMzCcSFE/u8UWCvy3wXhj4kSZdiNhFtCKByH0IclQauwkRIb4sMs7mR3oKCJVqb8mJcAgnW93bON+bqtwYz87VOHzxNVIpMZUdqQkpmBvZ6iZICTQIJi6j/vedrlZE1BdeiXZdq7NUomi7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0mrHgsnso510yZf8Xb3PKR9/+lePaBWuoSOZ7FSlk08=;
 b=OEfJU6gCvQ2Dzh0W25u592sSN+zkFPJdlIQzRWJvPLyUN/gFRRqn4LCV/OFLO+ZXq+1g8unOwAuQYnUiYIfrRIM0A3KVMOdDfogJeFvHLdN3O0yWWfpJbN58EhBcsPednhuGvYg+FC1Pr6iQTV8/qdNsBiJx9eQ30AK8g3XVex2L1kPLFdi5Gx88QUOEz5eH/j90U5cRDJB7PFVe7Stm5k0VspMwJ2CnUKlXB4cy23VYL/c8smAZ0kJ/fvadFhlLlkZk0btvtMfZx4+jAe9rt4wt7EWcrLh8E/+xUU+c63kSlCK9jNvAa2C1XlMGwzzP3MA/MXTLCB8kxKmc5HtMcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=huawei.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0mrHgsnso510yZf8Xb3PKR9/+lePaBWuoSOZ7FSlk08=;
 b=fgcTaaDs0eoS1RRulVosb6tHZI6jvQNfZfHiqeo3YoLiPEX5O78Bkb1ZQkWGOwCNpJLdBoGfcKBh3nL0rSWA52UJ/SYolqVbUZDClkVboo/TAd2YKI6CjyyM4XbN9amw+KVsuj+8hubAgaCVDyC7ci9knn9wGdX65JdLi0/zwIrKg/qUNkdXcjr6lupJvX8fW5g9AfygGSUnExlRc0n+/BGaVQzBV77F6VNbELFSqhp4y9jjlYGMpM2RRT/qyDpNQ8aIqXzLm+KdVoIOCKdZV+E8A+dq+d9n3tsNrlHou4ny69eORv41scd+QnALcJrdDlXkJ/oYWCboiJRjR//EWQ==
Received: from BN9PR03CA0403.namprd03.prod.outlook.com (2603:10b6:408:111::18)
 by MN2PR12MB4176.namprd12.prod.outlook.com (2603:10b6:208:1d5::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9564.16; Thu, 5 Feb
 2026 09:07:10 +0000
Received: from BN1PEPF00006002.namprd05.prod.outlook.com
 (2603:10b6:408:111:cafe::3b) by BN9PR03CA0403.outlook.office365.com
 (2603:10b6:408:111::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9587.13 via Frontend Transport; Thu,
 5 Feb 2026 09:06:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00006002.mail.protection.outlook.com (10.167.243.234) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9587.10 via Frontend Transport; Thu, 5 Feb 2026 09:07:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 01:06:52 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 5 Feb
 2026 01:06:51 -0800
Date: Thu, 5 Feb 2026 10:06:52 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Yunjian Wang <wangyunjian@huawei.com>
CC: <dev@dpdk.org>, <matan@nvidia.com>, <suanmingm@nvidia.com>,
 <jerry.lilijun@huawei.com>, <stable@dpdk.org>
Subject: Re: [PATCH v2] net/mlx5: fix memoy leak after device spawn failure
Message-ID: <eqzc6ilpcsbapvbszeiw7ucmnacuta5zyz4vq5ca7gvuucqfty@d4sx7oewq34m>
References: <1766050280-21036-1-git-send-email-wangyunjian@huawei.com>
 <1766055446-41476-1-git-send-email-wangyunjian@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <1766055446-41476-1-git-send-email-wangyunjian@huawei.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00006002:EE_|MN2PR12MB4176:EE_
X-MS-Office365-Filtering-Correlation-Id: 5418fb6b-c50d-4117-8400-08de6495f107
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?qUS8QoV3ruRs3D63YK3FxJ22UK830KLN4l4EHkOdfxX24sfpHi7PvzHQ9GWX?=
 =?us-ascii?Q?aDexNc0PTnn/8EkyjcW/xt9rE5KZVr4DSGfnn/3iM+B2K4r+1KRyi8WEMmij?=
 =?us-ascii?Q?l8i57JoUUDNHAd5EsUOoKZLhXE46j4Y6dguH9idKj/Rfogn91QL8tvbSYcKD?=
 =?us-ascii?Q?nFRvUD5OQ8fOxqFBCw5ghsEIfO6Ztwowi5JpQe3cvTgbnR2QPLgO7DIO8fun?=
 =?us-ascii?Q?fxt/A+jf2CXiyVLrVV/HLHvZEfV/19qenhovOvJVNRJRxkaSqKHMdyos+noX?=
 =?us-ascii?Q?7wldOpShw2Y4F0IehtusYKGS5L9SJPf5wI0aOXgGMkM+APkAwje7amPicoea?=
 =?us-ascii?Q?e1qnd/Hi510f1QXXWLMJVDheJOeLZknrcFkXuCa84gwCJn2+sZCsgxLlGbqG?=
 =?us-ascii?Q?pvDYHs4llLjMP8vgGT9XMZszEOgWh2IehI+WEaQFWwqQuAB4ak/T4cbrL9QI?=
 =?us-ascii?Q?IHqVgnC3jn7oIphLaDA8R54ww6xbGz9COW/iaqQkdnGxRY9/TwnvB+KTig3t?=
 =?us-ascii?Q?TFL80f/2QTY4eIAcg4R9n8GZ5Q6UFcpwCqpW+MOqMeEqseKpB4vtGhmJI9Iq?=
 =?us-ascii?Q?pr5VvvJ939m2TNaJ02lrzh8qFDYzBAjqk3Xd70Bbf+igYxdAmIujocvW6h4H?=
 =?us-ascii?Q?nA5pfzaF98sLST9ASI8mjg2M2YCG2vyKvK35IUsFUGAFNiAEAYXX5HiGvGMo?=
 =?us-ascii?Q?+4rI5mFWLRtQxmZy30iU22p8IZK5DeAQAQOKG9SF/k9u5cT6H3HMLdF6O9D4?=
 =?us-ascii?Q?Mj+k515T9hONe6sqD5iN0QkLn3vjHMs/46gXWb1l8jr+eJB+Wrfq6SSK0S2H?=
 =?us-ascii?Q?+K42NqLYuuOIzspnO79kFI7rFJXkmGLnyPyjdMEuNMJaS8OpiPvXuSwDaRme?=
 =?us-ascii?Q?WD6NiqvgsenGsJsREgrucCTETQ0gVEYGFHpg0vO1rm9TEgGk8mRlGpEP83vV?=
 =?us-ascii?Q?7L+wc16hMA+vHRPdq8AwPNyKGwZGD42DjG/FttWbuGi7NeU/M9isvuZzC1R4?=
 =?us-ascii?Q?8mWC4f2agNxB5I77cOCrGSREcmoijje5eApgj5/ZYHXDNPAQ7UCvsn6QFxsp?=
 =?us-ascii?Q?g9esxS3lzgDonW5K0Dd9nYA3sM+i4exA1xVYWQLK+2uCMBQvkl55Gr4C2im6?=
 =?us-ascii?Q?sryaWm0dqgHMdnruFD5STyRGDl60xb22E0vpc9XXNszKZzutdlwQURjZuYtv?=
 =?us-ascii?Q?e+rM4tIVOegtNHkaframgBN6oGTWthLYwz06yjRWbO3xkYyBNc6OH+r23x+r?=
 =?us-ascii?Q?ub+VW2kh05mjJf0uLueQc99mvz1zS8aWnzf7Uim92vgJEMPWxY6352TyGOCK?=
 =?us-ascii?Q?SXJiYsn36GWlK5gS3W+or9BaZzTFUFzI/E9DY1ZcBSr/EmXldjM4Kd6WdrE8?=
 =?us-ascii?Q?8tfqBMwy4eupIRT6yjwL0wM66M8CuNuelrYr+s2SnzKli7XOOR0eYf1sDqmU?=
 =?us-ascii?Q?KLxMRu6CphM2xmjWly4/LmuSCGmaGtrtOsCVbSBD7L6H/sEQ73+NoPuHVAG/?=
 =?us-ascii?Q?Da5ahPIiVW9XLrFNtN5wGNKwSvX9vDAwes5Xg3GEDiB3CSN1T0Z7h2oivARj?=
 =?us-ascii?Q?QXR2qoXkHls+0bFpVj/eHYxvLMGO2x4fQvOmKyk0PeuPUGs+iAnpcYKYwpRQ?=
 =?us-ascii?Q?9R2mkJ5b50UDtXd55629a2azVLaXZ5nrYmmf27ksXnlWDJrlAhSZGCACMnxf?=
 =?us-ascii?Q?cc3AvA=3D=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014)(7053199007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Pb1AnDIGh5Y41xw1OnUdyulr6tj2d3/tTxKEKcslmw++rDJQk+/wJf3aw2KGXdASQOoziVCPko+fH5E/SES/dcXLLX724qHj8wpKnQzS49mYmHGeOf15Y72UGxokVtAiev+VBhDcBUepSbHFzOJpAlyXvOhP3pLfuOXlBwPEaxIiux/7RQI+KiDiEf7UivKwyqfBPqZEhfoaLjtOVd7MmS3XyZIaveVYaVjToKWSEMp/3JRigJdlOggnmKOOSP6u69gEqWEjXYaO+Z+yxqVveaz8sKlKEakqAQAfy4OMrpefXbeDPBeUN9iIPaPGShh72D2foUMuFhvet8PFlauBAe2Cp8Gt+CApRv7jWQB2r2hHsco28q2YuG5TYxPAtkzMiwAwjOQMEFFwOGVHTrwGb9fZS4YFFNB6aVYPhvaApOX6x+Cv8oE2Q8YQC3r5NPy+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2026 09:07:08.7900 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5418fb6b-c50d-4117-8400-08de6495f107
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00006002.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4176
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

On Thu, Dec 18, 2025 at 06:57:26PM +0800, Yunjian Wang wrote:
> In mlx5_dev_spawn() allocated memory for the 'priv->flows',
> we should free it when errors occur, otherwise it will lead
> to memory leak.
> 
> Fixes: b4edeaf3efd5 ("net/mlx5: replace flow list with indexed pool")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>

Nice catch! Thank you for the contribution.

There's one small typo in commit title: memoy -> memory
We'll fix that when applying.

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski

