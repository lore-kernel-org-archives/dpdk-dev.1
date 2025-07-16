Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B1BC83F1B
	for <dpdk-dev@archiver.kernel.org>; Wed, 16 Jul 2025 10:00:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 913E04021F;
	Wed, 16 Jul 2025 12:00:07 +0200 (CEST)
Received: from NAM11-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam11on2081.outbound.protection.outlook.com [40.107.223.81])
 by mails.dpdk.org (Postfix) with ESMTP id F2BD44021E
 for <dev@dpdk.org>; Wed, 16 Jul 2025 12:00:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=vXoF+vDZPVqP6EhmqnOVgelg3gXIuhcF6/PrSWD7Qpfs9HL5zIcu8zAmlgLazGVjsrc82n6QwZEuBXP3cDSfMHACTqtEwR3WhCvj41gYMm9r9wofapz0Igy2ocYDfyMs13ZuoUIYHGH42bd6JRu8zRZ0bsxFZm129+dp7DE5ar1x7AfSHm+NjvVuV/kVA+Ak54iYvKQYo7/+W1cFMrjBc4/W/ITS7eO3Xc3bsie4qyrg1wHaw3kh+buybCjLlMIRtJGaKmv6hHccdMZpvZH8Ko0oc9yzpaioz7ocCdY15MSv6VyJn6yM0KGCquQ/Y3TOTJjzm759cy4k+rzSXwSzug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DQBPCl/5AYEEynRELAtz893cbIRlfXRCuci9kDlP/zk=;
 b=NQZ0xIqju2rNN1R/gcbSW4STr7Xje4yhnGmT1TaEPfU0y+6tcOCXZ9uZNtTFtx/tEPXzBoXteYUKD8Zmao1m/wJpWEMqrCp6JCC966WqmpHXV1E5+5YTflVg15CUMCvdtFpzwGe5KGQIFKf570EKI2OcB1doreKunJ3Him0A/j19LHp/Fl8SDX+TJu/UeNJDvsikliG+1F6QNUKJuZ9Jw0gqGn7zPylAxBWoTgxeGi7tPd6Us4uJvVJhcakZmUb5wl7tP1rVuU+qQQxLKS1VELLo6+AL6hf54Bg+Ab65WcuPySwT7xkRiK3OjguJebxTVFnDuQh/DXisG/MwLyNTwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=linux.microsoft.com
 smtp.mailfrom=nvidia.com; dmarc=pass (p=reject sp=reject pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DQBPCl/5AYEEynRELAtz893cbIRlfXRCuci9kDlP/zk=;
 b=s8LtYLp9jVcP5vj4aHmOJdmORtyFXWuSgRtMhedFqF5ZrJtKV4ay7Cr8UvDJvcEoYF1eHzvX+tSKDOWxbqFSbXV+TAEr61MNGKU7f3CX9588QXvev85Kzc885mUgpHJzd3D+pLoiZixqz7yThPNnCPLTFtC46Ij1sQTWvIXG/oMY7KnQY0zAGhM1/gEknuLpBxVSFU5GzdNy4AbMg+AKuZA3Zx8EVdt5LiIy3x0toNFTSU6CUN8X653e031BERs2vcHOKK9ai+GyGQCpjyvQR00Bi2SpeQHwxt/pHzs79XcFn7Z7YL8jqr0hRBAGF700z2PFDhT8jgh/AVEa4O9SyQ==
Received: from SJ0PR05CA0050.namprd05.prod.outlook.com (2603:10b6:a03:33f::25)
 by PH8PR12MB7326.namprd12.prod.outlook.com (2603:10b6:510:216::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8880.23; Wed, 16 Jul
 2025 10:00:02 +0000
Received: from SN1PEPF00036F3F.namprd05.prod.outlook.com
 (2603:10b6:a03:33f:cafe::1c) by SJ0PR05CA0050.outlook.office365.com
 (2603:10b6:a03:33f::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8943.16 via Frontend Transport; Wed,
 16 Jul 2025 10:00:02 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SN1PEPF00036F3F.mail.protection.outlook.com (10.167.248.23) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.8922.22 via Frontend Transport; Wed, 16 Jul 2025 10:00:01 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 16 Jul
 2025 02:59:46 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.14; Wed, 16 Jul
 2025 02:59:45 -0700
Date: Wed, 16 Jul 2025 11:59:38 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Andre Muezerie <andremue@linux.microsoft.com>
CC: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, <dev@dpdk.org>
Subject: Re: [PATCH] doc: update parameters to use for mlx5 on Windows
Message-ID: <20250716095938.iqx7zjb4jcsabqas@ds-vm-debian.local>
References: <1746458561-13525-1-git-send-email-andremue@linux.microsoft.com>
 <20250715120345.rnr6x5bm5l3wqw5m@ds-vm-debian.local>
 <20250715135725.GA21424@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20250715135725.GA21424@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00036F3F:EE_|PH8PR12MB7326:EE_
X-MS-Office365-Filtering-Correlation-Id: 2040c3c5-4d39-4614-08e8-08ddc44f8804
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700013|376014; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?VbogxRVrqDKZQ6hXGy1kiEVM4vmNh8NWAPL8VB5pq0z6T1Qn4Bvo55nK1DVR?=
 =?us-ascii?Q?QfDlHMjZ9jbu/OTcDNkO8mTeQLkJyHaPZ0SHe2dnN6fkg+SlSh9onNy+txUR?=
 =?us-ascii?Q?D0+45CEa65DkLKih6aZ7O4Z62iSDf3qcGHNfKWtHTIQLPStI2wZv7l3Oym9w?=
 =?us-ascii?Q?RinJYLWGZ5KlATxHDhdcVe3YTm3vqsB2Ys84txVrqf7wk8CFzR5sRHmm0cks?=
 =?us-ascii?Q?w0zOEuFut77F+93mdUlurCqeqtV/k/LDuYP899xFOU33tkQsn93p8WNMbZGF?=
 =?us-ascii?Q?WJ1yeBY2ySuvBljS2A/QjWQnOZbjF8gDUokA4tx/i1BiLMagKeFEY28PNXPz?=
 =?us-ascii?Q?2KIGRIV33lDqoJJRLn1oickvZsQzPjYCCiOZfJJ8Es4ttzxY2Mxb9kEX31A1?=
 =?us-ascii?Q?uOGewIt+i62bvxRbAvshe5+1k9UeMRAIJ+R+C6xortkM11ujKFXl5XQIs6cf?=
 =?us-ascii?Q?X1buqibtSKARn2larT1M9CJOvjdGjCxEgdKhZqP8k981r9fexaAJ7Ce1bDSn?=
 =?us-ascii?Q?Pgvxf9iUUD9kwz8pRzuBVhJKs8eT0o1HVlgn6lCVgj56FNW7kV14ZlVjmN/I?=
 =?us-ascii?Q?9DxuJTPTYeyrj373JcXWPc5yNTmIyzR5si7qAKah6oFDpm3aY9ynG5UJ5/Q9?=
 =?us-ascii?Q?M5dD4KXEyYknmhO/MLVZCPQzrkjoSJ8aY1BPwwe6RCEMgqjX6Ka0QBcBUREq?=
 =?us-ascii?Q?0q3DdRaaLktajES/2SwgpPf5tLdDy/kD0BUpdLAnKBCcqtPXuTEumsCOBVV2?=
 =?us-ascii?Q?3Pt1gVKVIoxT9KiNakWsRUxbGM5Kwle13TJd53JhBlUdb5JfcG54xHNCVY+B?=
 =?us-ascii?Q?QpX7l4SG56FfIDsmz9SDKVetTeftvM1YEyqTnxb9Mj02L70fKQuM0CT10uhw?=
 =?us-ascii?Q?PvdLUs4eqHrIWr/8RQ8sTrXxjX8EnwAygtVbm2we8crsTCc1SJK4RoROXU30?=
 =?us-ascii?Q?bPuHwS2G+yXYCHfZxTcQLs7oL6FRfbhStGOuugy7sG1uCtTTC9pRG2FS9wVY?=
 =?us-ascii?Q?ug6Yc4rnktl8hU/MBfnue1exlerHohD4OoD1UqCwjGcFTcjLC/NM+/KM15cp?=
 =?us-ascii?Q?2CZngyKAOSxSByteGs189KQ1pF4zzx7tXUp6SvUANkYe/4hnQn8L1w3hGtfs?=
 =?us-ascii?Q?wHm8b+pBONN5MqF7KvTAMOL5HIGc0+uXCz/GgFPMF14Q3HFYHjjzx5hxmAiu?=
 =?us-ascii?Q?obGCEbrjZbuCpdM2Ip9imqWFLYSaFc2jonwzjddYbNnwm6YMLR+EjndpUdpu?=
 =?us-ascii?Q?NB/VxJH7nB//HwY5j4sWS3X2GA6JfH9SOL+RmHPImhyjr9ZUXRm5hxANktgY?=
 =?us-ascii?Q?x18+U18T0BPOi/WrS9XGfcuhz3xLWNPkvyb8PNb8HyLGPmUaQ+Zuy+ceyouJ?=
 =?us-ascii?Q?9G5HYR5VNv4xvjsL/4HkXZWswec4sS9k19S0+9mf96JiwhwOD+emviV6BVME?=
 =?us-ascii?Q?xXtkEndr+8se37A6nvfLeO0+Zu7jrmf2FCaXTZ8AhyQFFMcOArVVxZAsRreb?=
 =?us-ascii?Q?j7izkMtl2vE9p2xadPLwOKcbW5VrpspMbLFJ?=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700013)(376014); DIR:OUT;
 SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Jul 2025 10:00:01.8689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2040c3c5-4d39-4614-08e8-08ddc44f8804
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SN1PEPF00036F3F.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7326
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

On Tue, Jul 15, 2025 at 06:57:25AM -0700, Andre Muezerie wrote:
> On Tue, Jul 15, 2025 at 02:03:45PM +0200, Dariusz Sosnowski wrote:

*snip*

> > Shouldn't clang linker parameters stay as it was previously i.e., "-L..."?
> 
> Not on Windows. It can be confirmed by looking at build\meson-logs\meson-log.txt,
> where it can be seen that the -L option ends up being ignored:
> 
> Sanity check compiler command line: clang sanitycheckc.c -o sanitycheckc.exe -IV:\soft\MLNX_WinOF2_DevX_SDK\inc -D_FILE_OFFSET_BITS=64 -Wl,-LV:\soft\MLNX_WinOF2_DevX_SDK\lib
> Sanity check compile stdout:
> LINK : warning LNK4044: unrecognized option '/LV:\soft\MLNX_WinOF2_DevX_SDK\lib'; ignored
> 
> As a result the lib mlx5devx is not found:
> 
> Has header "mlx5devx.h" : YES
> Library mlx5devx found: NO

In our local Windows builds with clang providing LDFLAGS="-L..." works
and mlx5devx library is reported as found.
However, only Visual Studio Build Tools are installed,
not full Visual Studio package.
It seems that either meson or clang chooses lld, instead of MS linker.
I'll verify what happens there and let you know.

*snip*
