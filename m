Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3767FCF45BC
	for <dpdk-dev@archiver.kernel.org>; Mon, 12 Jan 2026 18:18:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0FF3440281;
	Mon, 12 Jan 2026 19:18:32 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012055.outbound.protection.outlook.com [52.101.43.55])
 by mails.dpdk.org (Postfix) with ESMTP id A974D40041;
 Mon, 12 Jan 2026 19:18:30 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qbiG/TvH2HxTdv3MaKAmrozOQT0FV7XSCeEQ7v7Pt6vmJ47ztCf7TbmwTskbiFYwFyNcq6sStoO9Jc+8NXKCjLQwox1cis9C0SCAUtpdDyUPEcyzU9OAEHSnyykiMqnMW7Lczw2tcLPe7gEkogw5mh2drq/Co9pDMljtn5UMWyz2yROXWfbt/gDsJr6bimcf57hXlcGDSPuBw3mwv6ACcQS1BQ/s+qrdkGbtIqX+6ic+unR5VXbuJEY7pE9jel+pd1iKzIvhPblnCWlkbUeFAn3WxvUDZNTZRqpzqEl5X4Iaz/+6ZguuthWPwyZINB4Z3uS1PxewIhbHE1nUZkk3XQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BXLcFFPpg4gTNYDA7t2NdTbO36EQxydX6Cc1nfqWAUw=;
 b=A9p5Ve282XjLI9zC5UIVahJEB3a+EZdNs1X1+62P9tobDy92phibeYPI7H0Q0JL1aVwI46qc8a1nKdFOLT0nV7N5V9CvY1j4sYSYtv/ta9t31UiBFg/4g5NdPreZ+YjnymWg4Y2Ktk6wO0uvS5f2Nr5ryP5RVFKmsH9qcSSsMkdbh+DF2pNkWr3HEyN3LelcjD9rEyEM+Kmk7BFTixSrLsDwejjv/0x4zVIgeQQOy5hQynQGvLqt8F9RrDnH2zg1igbcVdzqWuQF+WMMMh86P9D/IkLPKBElVC1pCtWtN3RpsU1REkQFtqRAQvEXitIsQIWGItlTr5byyOS6Yic2NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BXLcFFPpg4gTNYDA7t2NdTbO36EQxydX6Cc1nfqWAUw=;
 b=qr6hc07uBb3muyVUKxH47eR5tb0yBqOcoAQX7UtAq1dAanjmRDWu4ZcYQepvvFsUN9nNmP1IUc899YS1LRHGzC1HDT8apdIuIYrBW82BgU9ZTTHDVWof5XfkwEVSEukJ02UrrZFXefOn4It1mN/D9phAW8alOKA7FHzFgm5wdEJFgl9FwuJoYs7WEU7sxII2PPOEQjxDa4OsPAv91D0x8ikvG0MhNKwbmTa4VmUAjq6pf5DL4TbbDG9enP0edsKCPE4o9mlcI7zwXDsgxh5HTopUPBPCRBmSZFiE/7IErjy9g84/uCUP6myZK1nvc1Gck7bOCQpnZSZZU/VcIez7lA==
Received: from CH2PR18CA0044.namprd18.prod.outlook.com (2603:10b6:610:55::24)
 by LV2PR12MB5965.namprd12.prod.outlook.com (2603:10b6:408:172::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9499.7; Mon, 12 Jan
 2026 18:18:21 +0000
Received: from CH1PEPF0000A34B.namprd04.prod.outlook.com
 (2603:10b6:610:55:cafe::a7) by CH2PR18CA0044.outlook.office365.com
 (2603:10b6:610:55::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9499.7 via Frontend Transport; Mon,
 12 Jan 2026 18:17:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH1PEPF0000A34B.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9520.1 via Frontend Transport; Mon, 12 Jan 2026 18:18:20 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 10:18:02 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 12 Jan
 2026 10:18:01 -0800
Date: Mon, 12 Jan 2026 19:17:59 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Maayan Kashani <mkashani@nvidia.com>
CC: <dev@dpdk.org>, <rasland@nvidia.com>, <stable@dpdk.org>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: Re: [PATCH 1/4] drivers: fix flow devarg handling for future HW
Message-ID: <xgolugkokrsrny2dfralkswdharfeylti26uhh64twc6e2s3zk@5ybbzju5vgtk>
References: <20260112092439.14843-1-mkashani@nvidia.com>
 <20260112092439.14843-2-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260112092439.14843-2-mkashani@nvidia.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A34B:EE_|LV2PR12MB5965:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a170e34-00e2-425a-7c4a-08de5206f772
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?x4q03YjUPEdXOa8AR6HaDDj0L96giq/l0vosAZcyVZMyT+cnGu00ShpfHcLT?=
 =?us-ascii?Q?yWnyguSZCqffG+YeGDKvvNqHqBQzXGEjwEHBoUASHzFw6pPR/bzt+qm9iC37?=
 =?us-ascii?Q?5pdzqGaEc46PJEnaTIKchHQ8GGr74+jF242CMc0wrtXhPknTTrccAJra+vJW?=
 =?us-ascii?Q?IBtDxJatThkbHIHB0XPv3paws1N3y8QCdmcaaqkpoldRQ2rADccX9Jb20Idr?=
 =?us-ascii?Q?J3gntGH3n4ZOSfBaPjxKvan12T93KZvcmc7MQPWXRAQXLZMcarnPJMWF8uUE?=
 =?us-ascii?Q?cOjfQxRKruWmAWm9znP3hFG0CNaTA0obm26H16U0LrTaCXviF4GHvnvYO3i7?=
 =?us-ascii?Q?F66QsguUc2tKMyFJOVl5QTdX3hFugdrcl+0ckovRelmn6E7PHOPNfJgbS3nZ?=
 =?us-ascii?Q?FloPx+WZaN9nSEQVs/QbyZ0BNxwRcZEcjADG5MmqsMREJTFC28lT1Dog32/J?=
 =?us-ascii?Q?Z8TLGciTGDuWwcngOwhB2xu276z7LQTJ61cyRuSrgtlCGpJulmijZ4XNRRKa?=
 =?us-ascii?Q?zH0cvYQSct7QcVDDzTKyiXBuXivv0NDo2FhRVHsqC4sD5LJu3ACj5Py2wmBp?=
 =?us-ascii?Q?hUgFmjF7i4VwoVoJ+ZXqpmUnYVVS9fh3QsGFJ9xNZjStwD6UwReY9KyZkxuU?=
 =?us-ascii?Q?jHeBMAHzsmjFZsvQXPO03MhsiBWEh+UZ+Juq3rqBg1ROieSZKJVOGQ26HUKQ?=
 =?us-ascii?Q?Z15n+jzBEvtZSKQzOOne0G0vL7xGUomFQ7RPET6mUYc8edmkLkuXMOIji4q4?=
 =?us-ascii?Q?gdcpaYKwSTjOQwkDOnR8gqm5NW11r7wCWDOBf4Z8UXoUsaRL8AnTEes8MQYp?=
 =?us-ascii?Q?iSOaN8Fzt18Me286XjeHZ/maeJHb3h9XEQ3qX/T6NvkMlHT0brElcSqsGNEn?=
 =?us-ascii?Q?afGg3AK/D/bka3gvACGzL+AdS9YU3IEYwidXvl7h2t2MoaLAXsehVlQBnlK7?=
 =?us-ascii?Q?IYTmUKmZoWyuZjLHs8kluzztx/bgvggzrhG22lC/ZVqnFQhFjY5KkI7yK2X5?=
 =?us-ascii?Q?CFPAwSbwEwcP/6cu9lxMsvU/HRIMftFRECQVhpJaZWyKQLg/VFQjEIE/gecv?=
 =?us-ascii?Q?ZrODg/RpoERtic+EWVaL5VFUp/ej5yDtTOw64weEy4uc3iLSzHnLLSF7qh9G?=
 =?us-ascii?Q?ttx/iT0r8/LXSGXdZsaNUiwF5lH/fXRUyzYJsAN8sKFKR3m9MOODUskQGabl?=
 =?us-ascii?Q?pvI4gQirNYoHqpY/55nhwqcSYJ4tE+okzRaEa2zFGz24BeC9Qoce/WKAdJ8R?=
 =?us-ascii?Q?h+CPlGXen2m4I3UNKEgvUGin2mpcsW3LYIJzLWxaSyWjHF9DAm448ry0v4gn?=
 =?us-ascii?Q?/JdYKILi4snxc8fGrVQFjq2sGxPMqeQnO5fBuxFWmzCAPld3BNQTvJhpPs46?=
 =?us-ascii?Q?yuK67mT8/L6/2DFgBzVYiLKP8AiBTN+H2qDY7MYzxySrAoSlo7c9enefBqh0?=
 =?us-ascii?Q?T55wvjRv6qLl60ZFZsOZXMT6FRl96YcBKzaIS0y8i6dTJyEOFb2nSJkbCjJ/?=
 =?us-ascii?Q?Yp3dvOPnKRQjh12TRj6FVruZa9SxEtDJs+slHOjd25D93pu2N1BmZWFA62HT?=
 =?us-ascii?Q?PQLKJ13aK+z7+Ee1tvU=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Jan 2026 18:18:20.6217 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a170e34-00e2-425a-7c4a-08de5206f772
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CH1PEPF0000A34B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR12MB5965
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

On Mon, Jan 12, 2026 at 11:24:35AM +0200, Maayan Kashani wrote:
> SWS (software steering) will be disabled on future hardware generations.
> This fix should check for SWS capability bits and return relevant error.
> Update the defaults for the dv_flow_en and allow_duplicate_pattern
> devargs accordingly.
> 
> - Default dv_flow_en devarg value will be chosen based on whether
>   NIC supports SW steering and/or HW steering.
> - If DV flow is not supported and allow_duplicate_pattern is
>   set by the user, forcibly disable it and emit a clear log message.
> 
> This change improves reliability by ensuring only valid
> configurations are applied, and provides clear feedback to
> the user when fallbacks are triggered.
> 
> Fixes: 1b55eeb7b76f ("common/mlx5: add ConnectX-9 SuperNIC")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Maayan Kashani <mkashani@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
