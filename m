Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57079CD8CA4
	for <dpdk-dev@archiver.kernel.org>; Tue,  9 Jun 2026 09:22:32 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9A05E402BE;
	Tue,  9 Jun 2026 11:22:31 +0200 (CEST)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010057.outbound.protection.outlook.com [52.101.46.57])
 by mails.dpdk.org (Postfix) with ESMTP id 504BB4025E;
 Tue,  9 Jun 2026 11:22:30 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dm7b79X4KBRbLM08AWlvi6C64vHTrE7wb3AOkl/6Hg/OcNpUjs38a1b8KUKgjM6UMUNIR/LpoK2TvqvLhWjCdRYdy0DQ4KdsjqC7Clda0Vawvx0lsK8UQLbZSJ+wSbiJI4Wo3g+aBEDFH5nrxT2Sgw0phv4No7WTOBzj8EAoxbHy9CgdMfgCHZUYVWNqneLiAlfsLIFEpO/krLchhWFmDQrYhtSQCNmfDHV0FxVuPpIP6p5FZoQ2ZFv5MD8fl3u5eqi4tkBv05jGYvNso1C8d+8dGYfq5DMjTHCffPmhCiwLE0hPknASRoPzpEORfZ2TppzTb57aLaeuDp4PHlvA0g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6bIzlfhsQiufT6DT79R2LSvZdBohrhbKe6ALCo38BIM=;
 b=Gzvy6kNWUSshVPiFiy8oqWq29U7zycYjtDe9Zgf4JlY/FI0fhHEwSFn4yGSo6QmI+PZiY5Alk9D13vWLvGFqUzEzIJl4SfdYb9dgcxdCglnH8jdKiAhD1tFZNslOpOgHFCPdXgDdNgprTK3FkprvTft9pAJX7YdX5jvUCEx+jeH458vxekfO788wNuq19tdhidGL5NGdyu2N5N66PuQESU8utbNpuOqPuuSW2SdsCxUo0hjBmTlu5wf6Y2DoY4y2aUPnh2tCmcrKnjdj1I0W4XIOJAziL5SQcXL+Dk0i4NWaxIqFMnPnoC7oRY65nYhG+Vwo7G1Mg3cBxDD3GV8nkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6bIzlfhsQiufT6DT79R2LSvZdBohrhbKe6ALCo38BIM=;
 b=NfRb641uqlTLdc2/wYrJtQxjyd4Rwts7fUy9ACyTD66o0ZKExBES/631yFYyRolcc4cnSj8ODNa45WGSK6/xJbDFB62SvLB0AuK8a/1YNF+Nbj9DxMNtYosoH6iOR9Ck6T94+jR6azbgxflOY+uf+33PcM76veCF1Qpw8WVBADUlKZ+pMe8hC87kc+M4Pg5xWRyglFIVG+XetidglMy5K30F142ffJ37bsDliLNzRp3x4FB9qQRv9gOq5TJ0ugJNKN9jMxcb93+c6F93DeyZ9SEcOR6t0HGiUw+IJnqhL43iyba+yaz20ddFe1APIwmyx2FSkWYLlsMPdE5L8pEvBA==
Received: from BLAPR03CA0018.namprd03.prod.outlook.com (2603:10b6:208:32b::23)
 by SJ2PR12MB9242.namprd12.prod.outlook.com (2603:10b6:a03:56f::15)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Tue, 9 Jun 2026
 09:22:23 +0000
Received: from BL02EPF0001A107.namprd05.prod.outlook.com
 (2603:10b6:208:32b:cafe::7f) by BLAPR03CA0018.outlook.office365.com
 (2603:10b6:208:32b::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.14 via Frontend Transport; Tue, 9
 Jun 2026 09:22:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BL02EPF0001A107.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.113.7 via Frontend Transport; Tue, 9 Jun 2026 09:22:22 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 02:22:08 -0700
Received: from nvidia.com (10.126.230.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 9 Jun
 2026 02:22:08 -0700
Date: Tue, 9 Jun 2026 11:22:05 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Linhu Li <lilinhu618@gmail.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>, <rasland@nvidia.com>
Subject: Re: [PATCH v2] net/mlx5: fix counter TAILQ race between free and
 query callback
Message-ID: <pk467b3foqd7hubnhijcehtmyudnaamaqlbrkkxqh7jku3avnq@bcocuukaxor6>
References: <20260604101112.72177-1-lilinhu618@gmail.com>
 <20260608132555.31439-1-lilinhu618@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260608132555.31439-1-lilinhu618@gmail.com>
X-Originating-IP: [10.126.230.37]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A107:EE_|SJ2PR12MB9242:EE_
X-MS-Office365-Filtering-Correlation-Id: 1e0198d0-e298-43ed-13d3-08dec6089cec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|82310400026|1800799024|56012099006|11063799006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: Duab1rH9pD5UTIQAlxqd33K4BSq7N/9i4w7ppjowVdEakjpBpw56KkZqZhslhSnGgKkBe9qCJxzensdypjTdh68JRLtuTSf6iltcaoEuqCdDJam/zM2JCMnwynFHSkDjwFhqkU24cKXx86n0dq1CQbxfNhaE6uBEFXmMX7X/4FTSIKdmcQIx8ebRmSl0+Lblox8/6aTPQwbN/qNgiXy1lbr4cg4pZ+r9ffSa2VmXUDEdPqVR3Gnnpbucoqr0kqHQmHkYB+qBLay7Q72XGjcslzrH0CRWSUZ10GTo/J885znFbdid1s3t8P2bp7g5KMlHB10S/HQnYcmh4aggGH1FKOyaz3KghcYJEadxFow/XE7e35EwuqrldJ+uTpWZbCTjlHcrYKXtYpPiDiwC0fFzGC5vfHVmxIyzVnQisrZ3ORAqYcVbu7CLD4K7PPC88WJJag/dDKKkk6r6lnLo636uiITbGXQhHZN/rJ5Fhf713ARlShflFVdl4A0DculTiSCmV71kwNTZr941uobna5HyvxysZN7/TNrGuq64qFP4ApCWi2yhlzVmkplESPu2BidcsrPjSwkqt/Q0Dkp+OH2YBNbg5V24BicSU+9/+z1HugsA7i7E+iDsLfI4ZHropzYAFmUMjeJCPEFtEze0uInuzuiXwLbLfaga9OIMKb4Z3B2XbEY3p8QepdZZS8r3wtBdSNmiEcYAfgR0APsaq+2jAiSjXAuj+40UmyCqejOxg6M=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(82310400026)(1800799024)(56012099006)(11063799006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 9SAJnY0435Yotoz26aqVnuwJVVj+z3qHmlCtcmdsiLBV+e7BaAvRyJo5mFlQ2Evbqy6isEcKI4db4hI1OFS11k1K6vcyeZ//d+O/UL5iB+WiAqI0LVc20hid3JhNsF/6JXoPYQAo5JMpwBofEFydVbPhmD/7Td8clnwEon0zC8GZCPNXhjCPYGls/RgNFDNb41LYurdKeNHJ4y8BZ1fXosOMvtjBXry7mhDx6djd5EhKgDs2r/OpLWRAnpKWWRNU+M9furYt3YwgGsZatOWVgTIkNsfBWb5Zro6Je1jBoS/EQ+AQ073zHW4D7VJKH+r88kb1wBPnPlSLmK/gmYi/SC0eZTkYsNbNqhMe8PAaU9pXddmd8awVmp/TFib2GMDvx8UBFLkkEAKrF8SvwjhctpHH6vF6wvxUB0EJkdHQoW6iMYYM5LUl4AGOBcl7rrQz
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jun 2026 09:22:22.5952 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e0198d0-e298-43ed-13d3-08dec6089cec
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A107.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9242
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

On Mon, Jun 08, 2026 at 09:25:55PM +0800, Linhu Li wrote:
> flow_dv_counter_free() inserts counters into
> pool->counters[pool->query_gen] under pool->csl. Meanwhile,
> mlx5_flow_async_pool_query_handle() moves counters from
> pool->counters[query_gen ^ 1] to the global free list via
> TAILQ_CONCAT while holding only cmng->csl, not pool->csl.
> 
> The comment in flow_dv_counter_free() claims the lock is not needed
> because the query callback and the release function operate on
> different lists. That holds only if the free path always observes
> the up-to-date query_gen. It can be violated:
> 
> 1. A counter free thread (non-PMD, e.g. OVS offload thread) reads
>    pool->query_gen == 0 and is about to insert into counters[0].
> 2. The free thread is preempted by the OS scheduler; it is a regular
>    pthread, not pinned to a core.
> 3. The eal-intr-thread alarm fires: query_gen++ (now 1) and the async
>    query is sent.
> 4. Hardware completes the query and the callback runs TAILQ_CONCAT on
>    counters[0] (= query_gen ^ 1).
> 5. The free thread resumes and runs TAILQ_INSERT_TAIL on counters[0]
>    concurrently with step 4 on another core.
> 
> Because the two paths take different locks, TAILQ_INSERT_TAIL and
> TAILQ_CONCAT run concurrently on the same list with no
> synchronization and corrupt it: the pool-local list ends up with a
> NULL head but a dangling tqh_last, and the global free list tail no
> longer points to the real tail. The just-freed counter and every
> counter inserted afterwards become unreachable and are leaked.
> 
> Non-PMD threads can be preempted for hundreds of microseconds under
> CPU pressure, which is well within the async query round-trip time,
> so the window is reachable in practice.
> 
> Fix it by taking pool->csl in the query completion callback before
> operating on pool->counters[query_gen], serializing the CONCAT with
> any concurrent INSERT. The lock is taken once per pool per query
> completion in the eal-intr-thread context, not on the datapath, so
> the cost is negligible. Lock order is pool->csl then cmng->csl,
> matching all other sites.
> 
> Also handle the error path: previously the counters accumulated in
> pool->counters[query_gen] were abandoned when a query failed. Move
> them back to the global free list to avoid a leak on persistent
> query failures.
> 
> Fixes: ac79183dc6f7 ("net/mlx5: optimize free counter lookup")
> Cc: stable@dpdk.org
> 
> Signed-off-by: Linhu Li <lilinhu618@gmail.com>

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
