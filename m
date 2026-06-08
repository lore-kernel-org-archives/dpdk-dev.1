Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE234CD8C9D
	for <dpdk-dev@archiver.kernel.org>; Mon,  8 Jun 2026 12:42:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 7197640658;
	Mon,  8 Jun 2026 14:42:00 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013002.outbound.protection.outlook.com
 [40.93.196.2]) by mails.dpdk.org (Postfix) with ESMTP id 3AACB40265;
 Mon,  8 Jun 2026 14:41:58 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h/8xiNcjyaC1KsHf/7P5cNOLfxxcsVm1xYPBYDXNZ1zdi56skewfafsGTc7Q1fPN3fqAgxHu5DptrKV+cDV9cgzCNETUDA3LVc9QACJX9ZWImJRVgz4qeQ2uDSofl3VEctDVLAj5ZACN+YAfb43gv3QqmcAsdidGRUL3ZXLAXcD3ZJhPDIz+6IEr9XY6xvz488xyaYH2RDWg07i5uhZ8bcZm3nUPP90BGnRsq/X2MQ0radxtTyHYglb6wv9GWTRjpzKvr31gQoc4dv20G4KGe0KWao0e3eZ/VHfqA09Cjz6/cU+3mEZkRlxwzcar5IWfZ9XnqLsMuikh0Ie5xUM6nQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ac7mVzrQ7g3XdGxhqtgDqe/vn/FFHGyyqXuLoPteL7M=;
 b=uQGO3NDg5HkyeYF3Cy0p6JMfepPjueb8ti4LdTgFPxo2/1Ec2k3r36zom28trBWkSQE4Grj49tTyRrBgZ0kZWt0sClOgLZFvmWdxtBzQNaG+c6T0EdeGEece4q1Ko/2nlcySJL+h0wp3idWasosBU/MtaH2h9lhyKDZ6ARV5ZFQAq+LqgHaIm1fVi5ZnBqpVvgqM8SFGwQ9kT+SCvRSe4R9u7Wbvj/Cm0R8I2Nsu5PZIdsjSgjbweiGSOMQt74z2NTWBvAJJFW1INBP5nD5whoS1t78fm8O3PgxRImhMUIB43W18aFiCuEjji2X9Yp4SljKhm4goItY3Y449+7lvcQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=gmail.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ac7mVzrQ7g3XdGxhqtgDqe/vn/FFHGyyqXuLoPteL7M=;
 b=rFAZZe1+WDYuWu0RJsEj6o/yymBnIR+F6U14EvFHKKX/mscVGOcqg7xbSwFwaYlrTg6B8GaMWvlk09chfdjnPE8ydUzWeOVOfQEzYjyi2hA8GWTcRULgNjrsXcKlJP315QSOjBsik3VYsTMQWwMFDk0QHPUyQ6nt9p4zuQ1ilCMFvMBUm8Nuspj9G5Pjehwq+YFbIMohHhx4T/exT0jMI5v2hc8ThvjWhIb87og2mPJl7HQFA/jfaSuXQRBJn+X3B+0sSz9qsVLpzGwfVcBT3Qdo48OaFutUs2Td+Vny61flSCB4q7DlLFzSzA9YtBpZhf+sjHvnf+C+ZrvqykaK5A==
Received: from BN9PR03CA0217.namprd03.prod.outlook.com (2603:10b6:408:f8::12)
 by CY5PR12MB6107.namprd12.prod.outlook.com (2603:10b6:930:28::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.13; Mon, 8 Jun 2026
 12:41:51 +0000
Received: from BN3PEPF0000B06F.namprd21.prod.outlook.com
 (2603:10b6:408:f8:cafe::99) by BN9PR03CA0217.outlook.office365.com
 (2603:10b6:408:f8::12) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.92.13 via Frontend Transport; Mon, 8
 Jun 2026 12:41:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN3PEPF0000B06F.mail.protection.outlook.com (10.167.243.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.1 via Frontend Transport; Mon, 8 Jun 2026 12:41:51 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Jun
 2026 05:41:36 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 8 Jun
 2026 05:41:35 -0700
Date: Mon, 8 Jun 2026 14:41:32 +0200
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Laaahu <lilinhu618@gmail.com>
CC: <dev@dpdk.org>, <stable@dpdk.org>
Subject: Re: [PATCH] net/mlx5: fix counter TAILQ race between free and query
 callback
Message-ID: <jwu6tpfmwtp4qmalicegmfrnmr2i3h4ahakldpsbd6fhatguxw@kromc5k7fnhg>
References: <20260604101112.72177-1-lilinhu618@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260604101112.72177-1-lilinhu618@gmail.com>
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B06F:EE_|CY5PR12MB6107:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ec132ae-9a08-45a3-fb49-08dec55b504b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700016|13003099007|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: bNEqBA7vZBUbkpwkWZG5vqBNq7tSWZu5stcnHN+BlTffxBWiHVDg2q/VSgpg5lml0kPw//FqgI8QK79z6fdw16SE8wIDrbNCEG3EW9YJX6D5Jm5SMHtTgtH1AeOW2abhDaVBAjK7IcdcnbifhhJLVgW8SIjUij3yaGdnCeDu6fyG+VcyKu0a3Sv4EROFdLqSkS25dhL4isdbE4TvGyD8Y8Ww7sM0Vc0pX3eEmMTL0Ygtt8hvqwOR7zK5T7ZeiL/xO0L2apStBSQj9HO/oF7fVSAqcrUjdNZcG1qnovMfoiC2PF6+XUM2xqEup4hx9txX/G6BtVm1DZLeErONGWtWp4QawDTN+z+zyZWxnV5lgAOK1NgIk1D9uZ7yPUSF+AaHu4WLE7QiLa0c8O6fbP6gaHUha+JEHDuTXIw7HI+R1RunfsNWli9jFTFMdrLOqLM/Cd4VxDHHivwW4e9tXy5cLB5fetq8d9gpgzSPmhNMnHTXnyLCxNjpiT0krFmez+ZQDNc+YIERXFPjCjZ3uAsOK+herofGYTXvGCkiUC6WUSWFOnfUGQX3tHNmVjktI2fDyjM9hJd14lcZv/hbAu2VCLONU7285Vaqz1UylweGZ4j/VJ7clVsSU3tRPt7+Si3Fuh67+6IFhXJAkfI3aoxg/2bsxUgnruGkyMqblJh+ibNxfxwB7Uc9Zx0VohpJi+lkiU7GIonwY+1fz668qwKD4bN/5HIiqFATIiSlerTikP4=
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(36860700016)(13003099007)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZEUF3KWrUCWeawuNxJ173fd1gYbQTBWzxC7PYq0A2eeuWv5YuUY0W2C7ZEkq9qDyI/0FfJTaHBwVYkQxw7fPhqhVxY6ygAXuh/2yC3t4MgZyfYe4fimO387bcBVsGRu8w/UuHjaCleQpkKbNYVAkG8jykREnIpSrFr04ZvhfGiRDwOeAa3ICYF2NN0M0TD7jXl1EaIF4oehBxrWKyW1Y+K+xwu9Qbx6KZR6LZiX5iPX3LK61e8ey7vqhlNXqRqk10Tc7XjqVPekn3tNPi8Pp+Z+1ZGBhNHWkamVV44d2W3DM+TbJ3uACenpQ9geYMXnDgClMgX/tpyHeu7CctcLDN5267+alq1AgdKwbESzmldJvqC9WPLEBXocxHm1+FHKCV5zPyCaqQPAEFzN7n4hxd24tdm5mcpskj1IOkTZLgFf8VZIKBAovnRFia3rZXw8n
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jun 2026 12:41:51.0993 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ec132ae-9a08-45a3-fb49-08dec55b504b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF0000B06F.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6107
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

Thank you for the contribution.

On Thu, Jun 04, 2026 at 06:11:12PM +0800, Laaahu wrote:
> From: lilinhu <lilinhu618@gmail.com>
> 
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
> Signed-off-by: lilinhu <lilinhu618@gmail.com>

Code looks good to me.

Acked-by: Dariusz Sosnowski <dsosnowski@nvidia.com>

DPDK community uses Signed-off-by to indicate
Developer's Certificate of Origin:
https://developercertificate.org/

This requires full name in the Signed-off-by tag.
Could you please help with providing us with your full name
in English alphabet?

Best regards,
Dariusz Sosnowski
