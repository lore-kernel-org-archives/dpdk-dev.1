Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E4CCCCF9F0
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Oct 2025 10:23:22 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1D7A24027A;
	Thu, 30 Oct 2025 11:23:21 +0100 (CET)
Received: from PH0PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11011009.outbound.protection.outlook.com [40.107.208.9])
 by mails.dpdk.org (Postfix) with ESMTP id F02EA4026F;
 Thu, 30 Oct 2025 11:23:19 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kiuewmYFUiSV8JIH/YNFpA+7AoONUIH4B1mzTGddnS8oMb1IYb31PKohyG9/eHaOj+wxAnxBcyPgec8/lJXdCuinNuTxkDJHmdokJ4WVijiJYOEfW/ujey1as7eAIs+uylsj3ZCDS9+/NvoETRS+xQUR1whFQ7f4cEJpqED1pgD6O4IYUAleJIWK7KAf9xlwRr5PwebkhoFS1uxUD/LYeZzBZUghB2mZlNOUqoTxb2sJLs3JIq3oDJuTbdXnhHfwGk4+53qzCj0tE3nsd/JwhZpoRUyRc6zbvq4thZHEXqnkMIRjahzXeaqJqYhmatIJ8VnnLVnUv5HLuLPkUSyltQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmI/rBhmfuOmLE46A2oGeV9Wte7B5MGXuwe0QyjWNbI=;
 b=X8ayoxGh269/+qlrnKTNaAjrDt0jfkLxaJv8cO0CGfg6AnYH9OOTTgn6SmFfbin8yyadDYJghVnKyM/xfVOgfkxZK7vJxoAWmdMjar9RcNoxT1/jHkGnkiepd+oPx8Qa3KKbkE4MhZ7bpN0jekiHHYJ5Ql94WIgfmEtubl8/WqsSSpAU4HdnnUnkbZU0cl8RbDAs/Sqw2YQ2di4bZ1v76BwFMNgTXhg1DKVtg3ZLWyWZ5ExaMcMWgm3fDMWxlNd4M3NtOtL2SMnG3imFE/QXEuQpgZnjfR0AHL5brBUqc9FTEUTkiGZ0KPmc47DDn0zcOU7rE3HOnchMfkQTMCia7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=syseleven.de smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmI/rBhmfuOmLE46A2oGeV9Wte7B5MGXuwe0QyjWNbI=;
 b=uKfH7cqjNz7pw7d02/fUNggZxUFK87qeO8b3PDUtKQt9TZLDFZU/yGIoG72e8fz/D56/UcL7KalG4GdaYAp3ex2CKMTjq4NaPIhS8wEns9RXKWbkB2pCi8o6O0PCwSoIOYHjL+7zXM96XHtBvBR8B8c9b1ygsR0i/vKKwpTBerUvaxtmFEZRjMYQ2qdn9lCuM4y8s/6T5QBYmIjUbuVF/ijs154HM9MUGgl2AuTSbEemdn1Hq2KLCrUiMIC9/agZOPl+hAI1dhiRGipj9zlhtZGrgWu1Nyry4zATH5OmqngtJpTlb94DLh1RaMtAO4y2jVbYOpJ0gw7RGrNBzr2Tew==
Received: from BN9PR03CA0890.namprd03.prod.outlook.com (2603:10b6:408:13c::25)
 by MN0PR12MB6271.namprd12.prod.outlook.com (2603:10b6:208:3c1::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9275.13; Thu, 30 Oct
 2025 10:23:16 +0000
Received: from BN1PEPF00004684.namprd03.prod.outlook.com
 (2603:10b6:408:13c:cafe::b4) by BN9PR03CA0890.outlook.office365.com
 (2603:10b6:408:13c::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9275.14 via Frontend Transport; Thu,
 30 Oct 2025 10:23:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004684.mail.protection.outlook.com (10.167.243.90) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9275.10 via Frontend Transport; Thu, 30 Oct 2025 10:23:15 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 03:23:00 -0700
Received: from nvidia.com (10.126.231.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Oct
 2025 03:22:59 -0700
Date: Thu, 30 Oct 2025 11:21:55 +0100
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: <a.schollmeyer@syseleven.de>
CC: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>, Xueming Li
 <xuemingl@nvidia.com>, <dev@dpdk.org>, Michael Rossberg
 <michael.rossberg@tu-ilmenau.de>, Erez Ferber <erezf@nvidia.com>,
 <stable@dpdk.org>
Subject: Re: [PATCH v2] net/mlx5: store rxq MTU at allocation time
Message-ID: <20251030102155.m2uk2us7vzgh3k7h@ds-vm-debian.local>
References: <20251028100144.36284-1-a.schollmeyer@syseleven.de>
 <20251030091313.55152-1-a.schollmeyer@syseleven.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20251030091313.55152-1-a.schollmeyer@syseleven.de>
X-Originating-IP: [10.126.231.35]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004684:EE_|MN0PR12MB6271:EE_
X-MS-Office365-Filtering-Correlation-Id: afbf12bf-139a-468c-9ba7-08de179e5658
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|36860700013|1800799024|7053199007; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?+DyTDm+YcSOUQWD2lpnbs6sJkhZ864Np9/EeILi3rgPOAZaKXnSrbs+WbLod?=
 =?us-ascii?Q?2iFvRB9QmeBjxEsPKBIo5Hg9RwOlzH4+/5nO0Bz0vw5aeA9ZSJ0ggUVwtVHn?=
 =?us-ascii?Q?iqx1mnKTRznn/nyovUjN6doQonMG+dr674G84vMmtOVVIhFphiqKTiwcYfDZ?=
 =?us-ascii?Q?GG8Ef05dOOO+5CONodHtsmP4gd+D6XErwEXCoE/In+irTaW5Fr3eN8oKEaSl?=
 =?us-ascii?Q?MFY8+zcFymlFi0s/YMmWS9HzqBOpFafBysReNEO7dsDh4XnpxZMO3mTSU+YN?=
 =?us-ascii?Q?M8S2uVibwLsr31P/ePzlckHBQdwBgUZBEfinSwVCLFJie0vFZf9NS69CrAmI?=
 =?us-ascii?Q?hJvnK3F88AHGcTGbss+ExROAjQIsqSI5f59YH0voogJcag7lNLokqMNkA8SJ?=
 =?us-ascii?Q?0+guaGN8HXKlpdMUYlOR7e68ngiuINJoozhddSNNmCWXEohHM85bJ599A9Cm?=
 =?us-ascii?Q?3WQW2CWkV+U1pD60gwBDPDntGGJFnatJ1HFWqFPw7m4ySuErCYSj2CLelZHm?=
 =?us-ascii?Q?AAAYOjb5cov9Mz0Y0vez06yAjRZELV3RIWOn8dwgVZv/yQFr0ZNhbQPmN+ji?=
 =?us-ascii?Q?kqG2yosJwWbvWZUuzgVoC8EHmAEDhpPiQTtHb5zSRe/fWDG9d2eseqUBvnoB?=
 =?us-ascii?Q?rnNEB5ts2K8CYF3izGvDEWJr9Zj36irB/wXgoR4jZOw1KEgPAAO2E5EurOpJ?=
 =?us-ascii?Q?DhWvgkt2zqWQ+Kn9Dy6hRiQZjcg5dgXa5occLkHsZd0cZDq04j6yOaWhEUei?=
 =?us-ascii?Q?3UStMOuIc12VlOZnWGEpLlmCZdMXEM3SXvWUCLHAdTAReXiK8PX0hJEWlAbK?=
 =?us-ascii?Q?IFsJgPvBMuH2X7SBUs8qVK5q78Ms+oEEdATlygp8BWN9BMBfJIxOBSOBkGjo?=
 =?us-ascii?Q?CmCsBY5srvbG/S82pKuzVYKEXAAkbx2Fp1NG/WuR5XoeeuZaWypFgCjnh7Io?=
 =?us-ascii?Q?P2EBSfOWX+K1dD4ClXwFjn7jRTaBGOlV0PLDpxEwE6xmNtdnE+MtjY2ZsvuA?=
 =?us-ascii?Q?Vpim59nXQMeEtgLn6toRY5xsfaiAh4tEkm7u1jpAIROsOHyoHJn1oNknIvJ/?=
 =?us-ascii?Q?9wIeFywxsAvh3IywCi1vY5MiFq1aRrecq45cSRlUqHxGgq3qcqiPLdO8ZFB0?=
 =?us-ascii?Q?XtZ1BzR9gIzGTFKUUZIAfBp43f41Dhr+5STSOGUyFS9KP5KbMxz55GW8hf1q?=
 =?us-ascii?Q?Ke/tIb17j7V1WDfN98fho8KQ87/QcYSBE/Yuk6QmSXJYuJ+UaEZS5uBx1AQo?=
 =?us-ascii?Q?/CBpMqwzGJ4v4/bifr73mpvpFfdoEHg8iXG4r3Fueg8SME5ctspkJ9+3vJaM?=
 =?us-ascii?Q?BIQ2dxTfWBvz+79MXtVehtpH/BKwNS/nWee7ubo7uUB4PV7BqvTDIOdS7goq?=
 =?us-ascii?Q?mwo5SQqG46IbchDQPGZASZTcFK+78tNpQgKt9XGZMvxXLuAFRIqy682IacPR?=
 =?us-ascii?Q?odILaAAO+7a0D1biCgMHtz/tZKBPpYzLuW5dANEXLQIM8W9qNZmcl1vdO2zz?=
 =?us-ascii?Q?23WREDMXZecyFl08jy5sOIENv5I23kuz1pAHo7dbfNwPrBA3E2SsLoh5aExi?=
 =?us-ascii?Q?BYL2qtEyYsB9UFKBozY=3D?=
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(36860700013)(1800799024)(7053199007);
 DIR:OUT; SFP:1101; 
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2025 10:23:15.2292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: afbf12bf-139a-468c-9ba7-08de179e5658
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004684.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6271
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

Thank you very much for applying the changes from last review.

On Thu, Oct 30, 2025 at 10:13:13AM +0100, a.schollmeyer@syseleven.de wrote:
> From: Adrian Schollmeyer <a.schollmeyer@syseleven.de>
> 
> For shared Rx queues, equal MTU for all ports sharing queues is enforced
> using mlx5_shared_rxq_match() to make sure, the memory allocated in the
> Rx buffer is large enough. The check uses the MTU as reported by the
> ports' private dev_data structs, which contain the MTU currently set for
> the device. In case one port's MTU is altered after Rx queues are
> allocated and then a second port joins the shared Rx queue with the old,
> yet correct MTU, the check fails despite the fact that the Rx buffer
> size is correct for both ports.
> 
> This patch adds a new entry to the Rx queue control structure that
> captures the MTU at the time the Rx buffer was allocated, since this is
> the relevant information that needs to be checked when a port joins a
> shared Rx queue.
> 
> Fixes: 09c2555303be ("net/mlx5: support shared Rx queue")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Adrian Schollmeyer <a.schollmeyer@syseleven.de>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

Best regards,
Dariusz Sosnowski
