Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A810CDB46F
	for <dpdk-dev@archiver.kernel.org>; Tue, 23 Jun 2026 15:44:11 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3A668402E5;
	Tue, 23 Jun 2026 17:44:10 +0200 (CEST)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012004.outbound.protection.outlook.com [52.101.48.4])
 by mails.dpdk.org (Postfix) with ESMTP id 61FEA40150;
 Tue, 23 Jun 2026 17:44:08 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=asfgMY/iI173Hsz62vii1uXa621U8foegj6wgnd9unakeyD8vXQqCHX23FkT8Kb17xMePg4MMsVhjNM9GJVSxZpt4xdbsJgi4XF1860o/pqoLOFej5WrFvGgIC1ptzbUZ2jHM64KXghlLEoxRwkRGRvau/ks9JUYyLYeFZ4tFqbQ2ec9gA1rWebwujq50jhqr372aeW7gah14IEageLny6RXbn3GNBCm4cDIS8mEeUZONQVl8980/gsEdaR8fas5tGfSg6ZTExvFTT/uQtx3oVHgsODr7MNLx6S00sKlLAOlBjjYbQbGAcLFyIMQUcWAv7gScVvFCGoWvbovykmAxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Bc2E5Juch5htLjS+DUHfP2U4BkpO8yFbsi6T+sAXcGg=;
 b=RIGsf5Gv0Q6D7S7Vt5X5heP7+xh1iz1Wk84Qp4uywy7FccLN3sThgf6N4q0XDSglw7WGagqbJololWyrts2nqJaUqNxsag2inFfGE4e62sdJZZlps/bFq3TPj8VOnvrBePkMwkivL7nP9v5CzKxBzpDEW9AE1TTY0rKPKhoCkQsuTSD8zqcU90NodxHJW5GrBlmoKhi4kU927gThK/9KaXpKKZjyGGr8Ima8b0byft984LjmJW62EazBrELaqv0AQ2NXf300fZk65lcO7TEC1+ike/RtGRg6UFvvec9M+geK7s5XvpKuh/wtnvhJhu77t3ibpOFHV/vQBN8NCNgpZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Bc2E5Juch5htLjS+DUHfP2U4BkpO8yFbsi6T+sAXcGg=;
 b=BCBjeY2aGfJNUIRwUtEczDvMViCjBGjecZw1nofltgYhciuB+xqB1ulGOSK3iqn4wr/d+QiVGocaLWeRBhdAHqxo2pf95LLdXU9xrIaRehOeK0X9pWAB82aA5z3eQHQYppoRqyEH0rV6S6prM+a2+cFRv9QwEVY3FRzj8ESzt32kSYLh3HkPI5y+nxx9E2Q/nevzLDTgyAE6BCIGo1y1cSDFJq5vWb6PiFRW161zqZ53YUzwVp4l18G3/53LFqprtMNIQJAj0pEznE79jAjgFQe2pp+vJ0/mKMOSIrFJh1mFaexGfz/orzYEmyCmTaJeKerAlbsK9hcwIeNXLnTQXA==
Received: from SJ0PR13CA0161.namprd13.prod.outlook.com (2603:10b6:a03:2c7::16)
 by IA1PR12MB9500.namprd12.prod.outlook.com (2603:10b6:208:596::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.12; Tue, 23 Jun
 2026 15:44:05 +0000
Received: from MWH0EPF000C618E.namprd02.prod.outlook.com
 (2603:10b6:a03:2c7:cafe::7e) by SJ0PR13CA0161.outlook.office365.com
 (2603:10b6:a03:2c7::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.11 via Frontend Transport; Tue,
 23 Jun 2026 15:44:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 MWH0EPF000C618E.mail.protection.outlook.com (10.167.249.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.159.10 via Frontend Transport; Tue, 23 Jun 2026 15:44:04 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 08:43:37 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 23 Jun
 2026 08:43:36 -0700
Date: Tue, 23 Jun 2026 17:43:15 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: David Marchand <david.marchand@redhat.com>
CC: Thomas Monjalon <thomas@monjalon.net>, dpdk-techboard
 <techboard@dpdk.org>, Bruce Richardson <bruce.richardson@intel.com>, "Andrew
 Rybchenko" <andrew.rybchenko@oktetlabs.ru>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, <dev@dpdk.org>
Subject: Re: [PATCH 0/5] add versioned symbols for recently stabilized APIs
Message-ID: <m7s3jl2566kibbapr2mfa2ic2opuc6b4ok2g67j3il5dgduzih@cz5wcdstb75n>
References: <20260623113752.1100072-1-dsosnowski@nvidia.com>
 <CAJFAV8yS6dLM2EUDgdG13U1Zdt208nmk2T3F8DYwT97U1coF3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJFAV8yS6dLM2EUDgdG13U1Zdt208nmk2T3F8DYwT97U1coF3Q@mail.gmail.com>
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MWH0EPF000C618E:EE_|IA1PR12MB9500:EE_
X-MS-Office365-Filtering-Correlation-Id: ed1a1000-a314-4f5f-f511-08ded13e4141
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|18002099003|22082099003|56012099006|4143699003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info: jjolIF76drZDz+j2b0q+FGl598fAy9uZd0FyWh2WGhWesHPIk3Yza093Aaok0mQIVEAK78wjcfrv3kQ2Kz95VUX+C2iZbpSEsC8SyzRsWlvWodpKbX8b5tIEzObT6J+wkbw5Evv0e+5JcBAFXxLDufNRlcIAejMqOVbmT2wWXIgmDuxaLqU6Bt5MHlW5Bx0XvpuaUK8Stiu3KD/f9q9aFxbtIVCx3xCW3gILC5bZkmS3gw3lNyBghd/uAWmHvO4nvubjURCF1TLGS+qxW9uPIrx2ty0HScO+SB5dza9feL6emGIac1BBbiLQUGe+bDU4iOT7q/Sh1JLXZTI28zmC8tMn891DEFHrjbanvdKKKOT+JEcRQ1aQPI9eW4MFUtodHxoW3p9N8p3sMT0LyWFTxz+vvWndJbKO+ZkbuMEKyHKxEDlMWyPqrbXkxPbBjwXhvtTz5xZb84GWoyfZgwm3D8qF2LmC307APy7oZHxO9OrvYY8goMFGXCrIjlMlOXvEC0aTYHij7D9Z9ZazW4ZHkB1KInM24tklt7aXKs8otl6q3L8dpKCwO35dNU/qNO+jh8UbDaQdy2f+pwyp3p3gCFZISZ+13bf5dWzxUTttmosct2zV7OiR5poSytmrG0xMisPpkj1pXZi5PSv1sWdr4uCM3VdkLSm1TwA4M74Y7o7ZOPiTjy/Okr9wnHr2jxdAoSBVsvXyFNjou05jOGqH9Q==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: rWh2uOtlTLGkKme9B5xsEYxAl9q1RpBwjydEJn4gCtEvQo0zOpVUsYDuW5TKPNZj2xANF94bDhHPE/E6FyUfjtDht4z2q33dvSCSj9abiZgzPQr2/S9Ed6sUjyI6Y5dFpz9F/bBsawWezzluPPEZTNR2Vd4D9BPAFii26Km/Ns+c2qCrmZwqOnI8QIfHZE5MujvO3xMGKZqIOhi6aH0yrguv4h5OgijdCHQDegOqlxRVPNq29n4tnA86ZebnMt6wBU527AtDA40mGKNUavA07hnwfnWYp4odZkzMLORXa7qm43lHqDSQE+5ud7QjkbGSb3wAluSD8hIMxOw8vJaSXk/d44FLWyz7sDpoDb1PSmpgQZzYZVuCbu+kueZNQSA8TJAZjIrvDWawp/bgcw9vcxW3w9dOi7dD9ZW+yFNqSccZIPuGf7GqtURv2WH6VYnE
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jun 2026 15:44:04.4793 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ed1a1000-a314-4f5f-f511-08ded13e4141
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: MWH0EPF000C618E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9500
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

On Tue, Jun 23, 2026 at 03:50:52PM +0200, David Marchand wrote:
> Hello Dariusz,
> 
> On Tue, 23 Jun 2026 at 13:38, Dariusz Sosnowski <dsosnowski@nvidia.com> wrote:
> >
> > Main goal of this patchset is to address https://bugs.dpdk.org/show_bug.cgi?id=1957
> 
> It is expected that experimental symbols may disappear overnight, and
> this bug could also be closed as NOTABUG.
> 
> On the other hand, we do state in the doc that compatibility could be
> provided when stabilising an experimental API, so ok.. let's try.
> 
> > but it also handles other recently stabilized symbols and has some minor fixes:
> >
> > - Patch 1 - Fix RTE_VERSION_EXPERIMENTAL_SYMBOL macro on clang.
> 
> Ouch... /me hides.
> 
> 
> > - Patch 2 - Allow function versioning inside drivers.
> > - Patch 3 - Version the function symbols stabilized in
> >   https://git.dpdk.org/dpdk/commit/?id=e8cab133645f5466ef75e511629add43b68a5027
> > - Patch 4 - Introduce versioning macros for global variable symbols.
> > - Patch 5 - Version the function and variable symbols stabilized in
> >   https://git.dpdk.org/dpdk/commit/?id=4ee2f5c1cedf9ee7f39afa667f71b07f4004ba5c
> >
> > Issue is still not fully fixed for stabilized global variables:
> > rte_flow_dynf_metadata_offs and rte_flow_dynf_metadata_mask.
> 
> Well, symbol versioning is not something for variables.
> Exposing global variables was a mistake from the start...

After fighting with this issue for some time,
I am coming to the similar conclusion :)

> Those were exported for "performance" reasons as those are accessed
> via inline helpers (but I am not sure there were benchmarks showing
> the benefits).
> 
> I am for forbidding exports of global variables from now, unless some
> really good performance benchmark is provided (@techboard for info).

Sounds like a good proposal IMO.
Especially since, from a quick glance, almost all existing variables
expose values not expected to change frequently at runtime.
For example, like here, mbuf dynamic field offset.
These could be retrieved once and stored somewhere locally
(Rx/Tx queue context for example).

> 
> 
> Now, in practice for your issue, rather than reintroducing symbol
> aliases (technical solution that I dropped when refactoring the
> macros), I think we can do with some middle ground approach:
> - leaving the inline helpers as "stable" (not __rte_experimental),
> - restoring the EXPERIMENTAL version on the global variables, this
> will restore the location of those symbols from the previous ABI pov,
> and the checks won't catch this discrepancy anyway,
> - during 26.11, drop the EXPERIMENTAL version on those variables,
> 
> 
> In other words, stopping at your patch 3 of the series, then adding:
> 
> $ git diff
> diff --git a/lib/ethdev/rte_flow.c b/lib/ethdev/rte_flow.c
> index ec0fe08355..8bd21ccd31 100644
> --- a/lib/ethdev/rte_flow.c
> +++ b/lib/ethdev/rte_flow.c
> @@ -23,11 +23,11 @@
>  #define FLOW_LOG RTE_ETHDEV_LOG_LINE
> 
>  /* Mbuf dynamic field name for metadata. */
> -RTE_EXPORT_SYMBOL(rte_flow_dynf_metadata_offs)
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dynf_metadata_offs, 19.11)
>  int32_t rte_flow_dynf_metadata_offs = -1;
> 
>  /* Mbuf dynamic field flag bit number for metadata. */
> -RTE_EXPORT_SYMBOL(rte_flow_dynf_metadata_mask)
> +RTE_EXPORT_EXPERIMENTAL_SYMBOL(rte_flow_dynf_metadata_mask, 19.11)
>  uint64_t rte_flow_dynf_metadata_mask;
> 
>  /**

Thank you for the suggestion.
That looks good to me.
I'll prepare a v2.

> 
> > Patch 4 and 5 address the bug for these global variables,
> > by providing a single storage for both EXPERIMENTAL and
> > DPDK_26 variable symbol versions.
> > This is achieved through symbol aliasing.
> > But this solution is limited only to executables compiled with clang.
> >
> > clang and gcc have a different default behavior regarding relocations
> > of global variables exposed by shared libraries.
> >
> 
> Yeah... not even thinking about adding MSVC in the list...
> 
> 
> -- 
> David Marchand
> 
