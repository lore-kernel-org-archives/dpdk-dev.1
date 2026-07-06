Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08C7DC43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 12:26:50 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 408B740691;
	Mon,  6 Jul 2026 14:26:50 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013021.outbound.protection.outlook.com
 [40.107.201.21]) by mails.dpdk.org (Postfix) with ESMTP id 0395E402C3
 for <dev@dpdk.org>; Mon,  6 Jul 2026 14:26:48 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=WRohxQGAYUEmlaCshwoLCSpfez0HyDwxTZ6XdbjiuvXnu7Koyje0SlBm+KBmXgkXU99pN50R9LVGUeXlf5bcNnxcrPEvXX4GCSuoOFETe5jKNg8GT53vJrTJdFN2WVXlhorK4W9WHHhsncI5HiUCgjdC/u+nhGL3503S62MyBXh6nuAiMH9VHWuTCmJ9ZNZCdGqf93q1uHSyLMAizQbb3l2Rl0FRzRil6ZRnFrg+azKpSsXDxviypwvw74cku1vSiDwXBBfvf6dZYRxIbU4bfDSQQDZYcDTiQJ+bu9wfW07u5MNjEWngOIz3xtuVTmp+MP3nljh4iCHnBmAosmK9JQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+EdxONzmJAlcFyguLLmro+GK2Cak6Ru1IIbgV4V0hwI=;
 b=QaSDYHHrr2wpY91y6kK9fCVsxdf17xiRBUyBIgiwQj3ByMf46fBqwBDJUFapZ4CqojgC0TlIS7qwllvG4wenqd2rjMLCZTVwXz+pKZAS75Liqu/pF/mDmLwUfDn7H6HHNB6S28Zc83a2pgRJo6wtUJDskvlzGQzjh/A2g39Va1hLrDJG1K7CchULRT2CmtgRqkJ9hKjEgPymgOek+R9aiHV9pRcdubY3zzFY9n100z1n7+7NgBuCjofP4moH/9JE7AU7qa5SSnMlOZ6dH8kk1QNe3BHhk+aQaF6kZ2Nf5UdCiiHR7Y3FLgFmKnsPYyEgjF0DAFlPlhTP6KV/NmJwwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+EdxONzmJAlcFyguLLmro+GK2Cak6Ru1IIbgV4V0hwI=;
 b=gZddNJ0TMJFijmnE05tdWdCehMQ2e5cxmG/5kdd5LFxyBP/88uUgSWi0DlgpkqeEdrkY7+bd9DDTv/ALf3fNKko741XLo10Kh53iIiz0u0/619qQ5d5FYSQWQsWh8RImXPJTdgUOakQ13kFjL16N8xxINgJGScE7Pjrd+UXJhTQ=
Received: from PH1PEPF000132F9.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::2a)
 by PH7PR12MB7282.namprd12.prod.outlook.com (2603:10b6:510:209::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Mon, 6 Jul 2026
 12:26:41 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2a01:111:f403:f910::1) by PH1PEPF000132F9.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 12:26:41 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 12:26:40 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 07:26:38 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: fengchengwen <fengchengwen@huawei.com>, <dev@dpdk.org>
CC: Raghavendra Ningoji <raghavendra.ningoji@amd.com>, David Marchand
 <david.marchand@redhat.com>, Bruce Richardson <bruce.richardson@intel.com>,
 <Selwin.Sebastian@amd.com>, Bhagyada Modali <bhagyada.modali@amd.com>, "Robin
 Jarry" <rjarry@redhat.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v3 3/3] dma/ae4dma: add data path operations
Date: Mon, 6 Jul 2026 17:56:19 +0530
Message-ID: <20260706122619.2939023-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <4c75c27e-6f02-49c5-aa26-b2495739d93c@huawei.com>
References: <4c75c27e-6f02-49c5-aa26-b2495739d93c@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|PH7PR12MB7282:EE_
X-MS-Office365-Filtering-Correlation-Id: 778b986f-11f2-44ff-d809-08dedb59d531
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|82310400026|23010399003|376014|18002099003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: t9YuDUadW0CFaLkZspxfAOWlvDiab2WiQcqM7K7wIklAQukn5nwXQNqG0V5IrLdoBqwoYhAHdJKWItnH2eUKObisvpOE8x2HybvNLlfNVHonVzTMW31LqO5KPlafAGJCpMn3wFYDpT5u+FLy8qBeOuzs2vRljXNKQza91JcHgeoFUh+P7PJaT5SpD5e3OrvC1vRXJ7tFxwRwZLmYkpV/9hjlN1AKkFXLQgpleNuLQU+203PdP44wvk0yUH6brTUqvOO4WPTWKUt34TOoRYO34fwa8AeTYI9jyXVgoXLcYVv+rdYjCcebcJPs5ibtpNI6lQCQRuNZVIN/McVyufJCam0IU541jyZ+OXWkCLX0SU5Ki+EtlCFsM70Id6Oyqe0ruasA7CEIIODXwaBh5fx5HK2lgkV4a6LIbjcPvg54y73Ad7W+744wQDyDVGRafw9+zVCbrTBc4YnozTbAW80z2F14ZRNxZ4HjmrG1NSmUUw8MkQ3RvihzIywLKB+FeRrh6SY/NURCA7bsBpDAc2RgFazz9DXjC/+lb+j0cGwSS5AXrn25VUIGV2ado1EsvizCO6Dp1gi1ZbvWvJIYZYUngDN9EvxVNwcPLGp+rNeMNLr0TfQlpzTd4r5jmaarsqjvkn/BtTFGuRRYxvWB4Nq2hTDjhsbEbPKECVgjksSklKQ45YETietpCj4daLeWu14t3SWWHKGhS/8oYPsRyKz3gg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(82310400026)(23010399003)(376014)(18002099003)(22082099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Hfa6DFEWZfj/NkYpRmYDaE7kyhybJL+6G3dKnYNZV5he3b9aNPZHTDW5PZkLjwAtSXFeB6F0LcYDpsHa2JZ5PVxhaMB7ANxB2O9UeYT3upvMVNHw+RBjzwAZqgMGa63ENxhj2/BVWyDBFZcZgYWcywZXRciCFzSSuLCP5xyXovFFQqXnVAhrPU4RHR02LGa5k6oJVJA+njoJ2C7vSbH3j7Y/6aLmDnFSQzfB0MHTz0QYdWcVFHReiKZHm5xF9uaBpDzQZsNvMrPQRtw0dWlhcsy5zHV9i4TiZFaqbjBpAvVp4U+y1X3EIeWeBnVpFRMA7KgjkF8P7v1ArWaM72uCsxADS7yTlY9acnoI9OqvaTtIKZGaZqPf2L5iFk0++jDmhvfSR1/y/IdRZaQaZHtSCYS4l0xRlz1iQcb20XAexhMtK+T5fISn/ymqoB5XHPsA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:26:40.8065 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 778b986f-11f2-44ff-d809-08dedb59d531
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7282
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

On Fri, 27 Jun 2026 at 08:23, fengchengwen <fengchengwen@huawei.com> wrote:
>
> > This commit adds:
> >  - copy enqueue (rte_dma_copy): ...
> I don't think it's necessary to write in such detail because the ops
> implemented are defined by the framework. If needed, you can supplement
> by explaining what special features this driver has.

Condensed the commit log in v4. It now just lists the ops and explains
the driver-specific completion handling (the engine signals completion
by advancing read_idx rather than reliably writing a status word back).

> > +    cmd_q->next_write = (uint16_t)((write + 1) % nb);
> the next_write is [0, nb_desc-1], and it will as return value as copy,
> but the dmadev framework expect as [0, 0xFFFF], I doubt your drvier was
> not passed in any DMA test (e.g. dpdk-test, dpdk-dma-perf or examples/dma)
> ...
> > +        *last_idx = (uint16_t)((cmd_q->next_read - 1 + nb) % nb);
> the last_idx should be in range of [0, 0xFFFF]

Rather than having two counters,framework counter and h/w slot count in dricer, we had verified 
internally by wrapping counters of dma-test apps to h/w slots(32).
But again as you mentioned everything has to go with framework.v4 reworks the
indexing so next_write/next_read are free-running 16-bit counters in
[0, 0xFFFF]:
 - rte_dma_copy() returns the pre-increment free-running ring_idx.
 - completed()/completed_status() always set last_idx to the last
   completed ring_idx (next_read - 1), even when no new op is reaped.
 - the HW ring slot is derived as (hw_base + idx) & (nb_desc - 1), and
   in-flight as (next_write - next_read), which is why the depth is kept
   a power of two.
With this plus RTE_DMA_CAPA_OPS_COPY (patch 2/4), the driver follows
the framework ring-index contract.

> > +    case AE4DMA_DMA_ERR_INV_ALIGN:
> > +        /* Name matches DPDK public enum spelling. */
> > +        return RTE_DMA_STATUS_DATA_POISION;
> Suggest add RTE_DMA_STATUS_INVALID_ALIGN enum in rte_dmadev.h

Agreed that reusing DATA_POISION was wrong. For v4 the alignment error
maps to RTE_DMA_STATUS_ERROR_UNKNOWN so we no longer misuse an
unrelated code. Adding a dedicated RTE_DMA_STATUS_INVALID_ALIGNMENT to
the public rte_dmadev.h touches the dmadev API, so I would prefer to do
that as a separate follow-up patch with its own justification - happy
to send it if you agree.

> > +    if (nb < 2 || !rte_is_power_of_2(nb))
> > +        return 0;
> No need to check this

Removed; vchan_setup already guarantees a valid power-of-two depth.
burst_capacity now just computes (nb - 1) - in_flight.

Thanks,
Raghavendra
