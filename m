Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC66CCF9F8
	for <dpdk-dev@archiver.kernel.org>; Wed, 12 Nov 2025 09:19:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 0EF5540656;
	Wed, 12 Nov 2025 10:19:50 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013053.outbound.protection.outlook.com
 [40.93.196.53]) by mails.dpdk.org (Postfix) with ESMTP id CB7BB402E1
 for <dev@dpdk.org>; Wed, 12 Nov 2025 10:19:48 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gYfjLgcJ37o0KmNjohHhdcn8gPpZZ5MVxr2ik4P6MKxHn78RI56JlY8UUE6MoPqUmxOJW81gkb4O6JHqLGriA5BmfifQEEnUrPdjJtvaBglYpeuSlaFhH00koNloRNYL8gihElimdXXAuVc1VoypjEBT43d1f9IqNO9NdtfK2pnT79qPZNB3wI5zohzi/xePb90rjZnqeriprEOPL2YIv6BkIv0NgiDNX/GaxEdmedDYXYFJ7Tkfxwp6lD5DRSA/NYnfsmAtoa2PIt9Kyf+z4DbfVTJFbmOv/M+tPW1cOrcCa8gdWa4I4hkv5v8JgpS2Y4vPcPktMEe9hXl7JxyBpA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nSfYEZECC9AcJqxdhhITa4/pkou3+iWleSm6CGzXDKg=;
 b=mUZU746k6BaXcTQ3aGwaIQmbbeRV438AGrGO6rfXG4T668pOVIm48n4g6rsL7EdUXDd+zPhqS+6rwtryrKg7ozDtIJe/p5nTnt6mphnnmpaC2sLamiD+QLv4Ft2Q6xXWo3u+tjg4kvWVbFgbn7wLPEIRD+P/OK+MTBxAnqqK/+ondqJbgxDfLdAESuDCAYsS0ktnuszN9S2hKdm/B5/edsvDSmHKx0B4C9BDLtFU14kyK9W0B4tYQw+cH15MvMNtvq9ncBKIb/V8M4TR+ymG+QY3Y9jqxAY1YHCj3hlgNXiW1qWbLBNBTgrpgcDQBsPlrt1mj36Qk1NSpVxJxCbNQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nSfYEZECC9AcJqxdhhITa4/pkou3+iWleSm6CGzXDKg=;
 b=H9RnUeOJy9pUXt8MldlDnvKmTsu9LmSGcWpzYUif4dyCGZcxqZl4vZ7T8/DqA6mIwzVN44Rlw067mMsmbEcmbpiJUUXTuktgbaNOD7+y+aZ7K1pr9LEzS7met5O0A7SwcHawCJtn5SK67Mq0kJmKlfjpr2fwib4B+/h1ebN9ld5wlYoCWdf7DCgBCYgeTkRhAwtS99/QO1Lz9gchnhggCa5+6tbFEpdUWVr6XWPG+IXxbFpDXX/mosJpM4RvQ1KET0pp/dzo/bwPEVOIGVTxMjmNI/32WamDlqbmIh0mYTHu9ufaFRhR4PRJJGxwRAcccxsYSQD3W6IG/urnen4xqA==
Received: from SJ0PR05CA0074.namprd05.prod.outlook.com (2603:10b6:a03:332::19)
 by LV5PR12MB9828.namprd12.prod.outlook.com (2603:10b6:408:304::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Wed, 12 Nov
 2025 09:19:46 +0000
Received: from SJ1PEPF000023CF.namprd02.prod.outlook.com
 (2603:10b6:a03:332:cafe::53) by SJ0PR05CA0074.outlook.office365.com
 (2603:10b6:a03:332::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9343.5 via Frontend Transport; Wed,
 12 Nov 2025 09:19:45 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SJ1PEPF000023CF.mail.protection.outlook.com (10.167.244.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9320.13 via Frontend Transport; Wed, 12 Nov 2025 09:19:45 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 01:19:30 -0800
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 12 Nov
 2025 01:19:29 -0800
Date: Wed, 12 Nov 2025 10:19:25 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Gregory Etelson <getelson@nvidia.com>
CC: <dev@dpdk.org>, <mkashani@nvidia.com>, <rasland@nvidia.com>, "Viacheslav
 Ovsiienko" <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>
Subject: Re: [PATCH] net/mlx5: fix non-template sample action validation
Message-ID: <20251112091925.r6pvg3mphh3ls66u@ds-vm-debian.local>
References: <20251106130228.491915-1-getelson@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251106130228.491915-1-getelson@nvidia.com>
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CF:EE_|LV5PR12MB9828:EE_
X-MS-Office365-Filtering-Correlation-Id: 5f53b576-2c14-4dab-b076-08de21cc9eed
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?DgVUt00XwdR8/QTtQXDPmg04fRxMXYTnm/G0PLjE7TiRA6oEAPpNIaoZAi42?=
 =?us-ascii?Q?Y1Lz3KiQpI8RLxZ6ST/joxD2WwlwP6wE+wQqgIFDOqf0RKe5SPUXSC5MhkN7?=
 =?us-ascii?Q?PbIx0hAhhMpalivEE+Zm/4bNdhQap0qtmxM3QcbzSwnolwqqqLWdI1ItztuE?=
 =?us-ascii?Q?PoebcsL+3Ob8P6AGb5wXUpukQKIulOGGDl6SeEPk3EQgYOyLOR2dL64sAXrY?=
 =?us-ascii?Q?YId6EpObwR/ARuRBGTVOFHP5sbn59/b+vVfZR0HtGrRfSFF0pjSwRsPeF9NJ?=
 =?us-ascii?Q?18hQnb7oN5dqrliOMisnpemI693Aa4R1GJUjP1qvkoWHA9rTW22IbMnVQrgi?=
 =?us-ascii?Q?s/9sPM9JdLBe4WarboAl1B555Ou/oX4y2lZLYwuKrhrT5kfO56TAX6ph4LkX?=
 =?us-ascii?Q?cVOtyz0K93kdm6vwfy1RxlwInyFd7jZXfJAswqBOrsG1DH08HfyajqVeUi2q?=
 =?us-ascii?Q?8Y10fLDbuWKY1MVn516QpnApNm0Evk1KvQ5ySk8VW03fzyL4Z/mD4fN4ggpp?=
 =?us-ascii?Q?A6E3xsqt4TodI6BgmDQV4ruinzxvKOKCAtDAmJrrYLmuxTzbs1OjQi/sC6he?=
 =?us-ascii?Q?vhcYKbW5jWoV9Wp08WpWmY2vgGSn1G58BCJmGvfSU/LobLbCty8oZsBzEfJc?=
 =?us-ascii?Q?xST8MwTtBOwLaVXqOZR/jgsKHV1lyPdBhFrF2t8rN5qDt+WlvI6CQWSkjSe4?=
 =?us-ascii?Q?yu6XpI40R6MYy7xUkjb7UIPF4++/bPRb+5sNcGAYSkoJgEMHH7IxNkG3sGnF?=
 =?us-ascii?Q?6oKAKuVzPez+1Qg18yRyNz9NuNEl7F5koIl5hVJ1JqFjEYj2WM1xFbaqMc21?=
 =?us-ascii?Q?tfKOiD08Zo2xln70qqIqM6cLNB8cbkW53lQetlZJk1BYpja6TGxpxzmjsNpR?=
 =?us-ascii?Q?l3y7YQfjM1qeEPZZHT1jSv/uowwBUDfzG3SH314SHvSRCMS/jO1+fPO5HiIg?=
 =?us-ascii?Q?Tzp9s0viuQxkAEZUYdSpQSOJ7/SG23FO9ymIdYH9mi1JYlR7IdI5cw8hm+YC?=
 =?us-ascii?Q?6qJq2vtGOncXz7QPC7OtTSDROqoLiLGYuCpe1nSWdqgOLZtjEzbydE6bZtBT?=
 =?us-ascii?Q?s9Jq+dudrtvirZ/1ugvHotWiDXb1sFVjLdysHR5K2iK3PWINv+LuBrnAXzPV?=
 =?us-ascii?Q?fwwejMa/hQrLFvojSRtYzKjFqMfacv5ycdu1YaGFWQ78MwYGluCRHkwQZ/ME?=
 =?us-ascii?Q?zeCxpxMyBR9bV1oUFV1+fs4KyzLEAbQEMUa0tUTSBnb1jnloDA3+GHckToIt?=
 =?us-ascii?Q?yxzDAcx0/pByVT9ldglM+TwBAaNpI6ZTuMrDc/G1laZJdMMrYleul7+9eQ8f?=
 =?us-ascii?Q?d57UBKd40d+uRf/uzbEByYJ4yYCmRjbnLh986d3tu/P2fsC7lwXH2aFcsgi0?=
 =?us-ascii?Q?xvyvJqFslK6aV2G5FKEzbaSibVR0GOqydOqmRIvo90DylHj+L3At8pnchCi4?=
 =?us-ascii?Q?FzybazGApAuoAvWCSw3V9rpj0vVCdQ9HdcACCif8MYfW04y//Adca97sTyOL?=
 =?us-ascii?Q?0wQpRM+zvIZJ52o+e+ya7V8KU6ORG/MXTjXdEdkH0NIT1JH1c5cx+qGQvfgU?=
 =?us-ascii?Q?5TieUFIE5DgyvngRR8c=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(36860700013); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2025 09:19:45.5219 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5f53b576-2c14-4dab-b076-08de21cc9eed
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CF.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9828
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

On Thu, Nov 06, 2025 at 03:02:28PM +0200, Gregory Etelson wrote:
> The patch validates that sample actions include terminal action
> 
> Fixes: d986f04d6529 ("net/mlx5: add functions for non-template flow sample")
> 
> Signed-off-by: Gregory Etelson <getelson@nvidia.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
