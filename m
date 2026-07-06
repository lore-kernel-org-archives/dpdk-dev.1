Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB608C43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 12:25:46 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id F1CEB40691;
	Mon,  6 Jul 2026 14:25:45 +0200 (CEST)
Received: from CH1PR05CU001.outbound.protection.outlook.com
 (mail-northcentralusazon11010032.outbound.protection.outlook.com
 [52.101.193.32]) by mails.dpdk.org (Postfix) with ESMTP id 134A1402C3
 for <dev@dpdk.org>; Mon,  6 Jul 2026 14:25:45 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=U8nsL4oDIE9lXHKBo9YywXzN61K2ve3QaRR1cKlSvoKYLO7XXi36SKfRHsSeSOmDnFnDIG4Pg55nL6VCcD01Ef021EmnTDaR90cT+qRAtboF1BEJTKL57qywhvk6q/6oUsSRsdwc1Qvv0bpf6OEd+b9abGCm/93zJpK+OzL27FNRPza8N4rDmWvh+Hsj0Jgr78/z5d+yAGo37N9kQ5KIhx8P0O4PpwvmNDB6eL7W/b1eUxqSBYVKrCf/lxBTaxc3FR5/zRIPy8rTlADDrJxrBjZwSwKgWwPCMhTP7C6l5453oOKRhHVBOWvYZZUYFpA8R+qfTHf0umjmEdgVNNNRXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oVo45Cojqn7W3Y3vwsdHLwFjLylI6E3IJprbdAor0EQ=;
 b=B1GXmkZsVENhlnqu98vvAzvEjVNLxpcLDzC4WMwMNPaDcZXnEFtCMqaKXq6bVQBo7vRPBGcHpVCdR6XJXFkB7I6prjBZ03xrTwwRdN10AzbGrtCSql2fys4mJSLZp+kXp/ZyU8lfaZNi2Gkcl1sSTvM6MW7cnRXce3CBkRCS2UCybeW7dbnZCckS9uPxnKOM4hVejdM8lP2r0yBxoCNe8NAGFTQPbtapljCq8QQnQEUlYYIjsgm0MMxsu1wVqgVyeGr71OoYo9EKRiBqvmAeCmNjzknB/sBDiwakf0qtQpZ39gkt4z+bF741J0jGTS1lu9pUOq5mzLFYkhS5ANsY8g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oVo45Cojqn7W3Y3vwsdHLwFjLylI6E3IJprbdAor0EQ=;
 b=CmyjeEvKQqhri/HYL0db78BjnRkof2bHwcMRRGlJKBXXpb/eTGjiiFtqyDvzhEi6Pp++zfDLSSGWZ9oalULTd36a9vfbU3du1MticlOzC+NPfDjpe0eIFf61bjQOD02QgXLKO+8IYn3DJy9Q/bMykneZgPPPXkDcQ3d1WiJa2Lc=
Received: from DS3P221CA0010.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:45e::8) by
 MN0PR12MB6079.namprd12.prod.outlook.com (2603:10b6:208:3c9::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Mon, 6 Jul 2026
 12:25:38 +0000
Received: from CY4PEPF0000FCC2.namprd03.prod.outlook.com
 (2603:10b6:8:45e:cafe::7c) by DS3P221CA0010.outlook.office365.com
 (2603:10b6:8:45e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 12:25:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC2.mail.protection.outlook.com (10.167.242.104) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 12:25:35 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 07:25:32 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: fengchengwen <fengchengwen@huawei.com>, <dev@dpdk.org>
CC: Raghavendra Ningoji <raghavendra.ningoji@amd.com>, David Marchand
 <david.marchand@redhat.com>, Bruce Richardson <bruce.richardson@intel.com>,
 <Selwin.Sebastian@amd.com>, Bhagyada Modali <bhagyada.modali@amd.com>, "Robin
 Jarry" <rjarry@redhat.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v3 1/3] dma/ae4dma: introduce AMD AE4DMA DMA PMD
Date: Mon, 6 Jul 2026 17:55:17 +0530
Message-ID: <20260706122517.2938943-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <f1079307-3483-4d0d-9a93-2f30f54fe40b@huawei.com>
References: <f1079307-3483-4d0d-9a93-2f30f54fe40b@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC2:EE_|MN0PR12MB6079:EE_
X-MS-Office365-Filtering-Correlation-Id: 685ef46e-a68d-4886-5340-08dedb59ae69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|82310400026|1800799024|36860700016|22082099003|18002099003|3023799007|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: z74ebMlH6/6SfqUkGXOfC4zZgA9Av8EYyvri8bfUaH7VBm7qOda4Qzqq8rSoeQsqxul+ZM1iJh+RK1hwWR1dn5u3HeB1CoBmz2YonPvMhAXQKK2OuFQi7uaRCqCYVSWdTuzy1EWa1hOC4v8VPrLXev+ZuEawD8nNRLAqHBPOvxcBLHZehEKtQWazdeWXEdIRaKXV983hSJMT34/iyQ1GXc1kAAtxF2FuzuoO3Em+zpOwUjfoFhols5cqCLM6tHOpFkap95D24xDT553EvuCaPr2WZgwYhAhgiQiHF7zigl63eZas0uEKBQ/wJRsoQ9Q+NwcFTAQCe17C+n+TVQym7LBhYGVxn9VkIGcMntr9TiPJ2pGO3Omq9JPMAECpA2OYL4J7JpdYubUom/MwJoF7VlxbIY9ph/DyMe8eM0YMwi0UQ9YzQAFwP4KtbQdYdUjThwuboM3b8T+EdV4KAJjAa0orDYOhBZsQhTZ1cFNGgeB5X3iRHWNXG2ezLf3uDXtnNVQWK2E4C228rqYd3twR8VYwkaeMJl72ryWiXWhIZ7BLx65Xw022ELDuluysHyQON6QQz1ZOYXeu22PPT8faoSw5KDoOQX7wkVv5YKAVlGHIBmRqeMicJ4GUc3ua4lYB2EQhrcllGThKFVnU/JV7IcpAu95VLDywBptMrKPHw7VLNgeRb0NYJtDdhVqqTBW3c321dI+9taEXzBzD1vZ1eg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(82310400026)(1800799024)(36860700016)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bwB7AGf8Lpo86YNQXik04k3lYxJ503cfeir52WgNUyXKEiC4+xZE2GdGozDdpuaWuBfa/+RHE/9BsO6A9fHWWdhmqHe8r97pFsnxfZzJ/HAgERlqApzTT3yTcFFdT7lhiK3Q8nBPs7uDDE8OTr2sRW10iy5jsASqK1DG/VgyrC1O4+hPJ6IgnpUQa0k+NCYypOckymbS0Ag7JVL2J6CXT9Q1+w+O+l2/OTBO48IYyRAn1Rfajq0djwk3aLm/o0vGF+gfBCj/IHB9+7c2E18D3RHB1sZyR4V305GqDY54L+brDs5kPiYmzablDeTjMefIb4xK6+ipZhxGrxtYdFBhn7aFl+YBCr7rrEYEx6rM2yDgR73tWHqRxKUoNeLN6VCHzJnDTm/I6m/ycfSUZ+xuMQiwtoIJeW0KCE/1Yx8M1fqqiNfCZekYY9gaYiwMErVt
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:25:35.7021 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 685ef46e-a68d-4886-5340-08dedb59ae69
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC2.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6079
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

On Fri, 27 Jun 2026 at 08:01, fengchengwen <fengchengwen@huawei.com> wrote:
>
> > +    Copyright(c) 2025 Advanced Micro Devices, Inc.
>
> 2025 -> 2026?

Fixed in v4 (ae4dma.rst and meson.build now both say 2026).

> > +    return rte_memzone_reserve_aligned(queue_name, queue_size,
> > +            socket_id, RTE_MEMZONE_IOVA_CONTIG, queue_size);
>
> No need to do such reuse, and this resource could setup in vchan_setup ops,
> but your dmadev has max 32 descriptors and only 1 vchan per-dmadev, so I think
> it's ok to setup in the probe.

Agreed. The memzone lookup/reuse branch is removed in v4; the ring is
reserved once at probe as you suggest.

> > +    char hwq_dev_name[RTE_DEV_NAME_MAX_LEN];
>
> Please define local variables in a descending order, with longer ones
> placed at the front. It is recommended to modify the entire driver in
> this way.

Done. Local declarations are now ordered longest-first across the driver
(kept in init-dependency order where one local is computed from another).

> > +    memset(hwq_dev_name, 0, sizeof(hwq_dev_name));
>
> why not char hwq_dev_name[RTE_DEV_NAME_MAX_LEN] = {0};

Changed to the initialiser form; the memset is gone.

> > +    AE4DMA_PMD_ERR("failed");
>
> why not add more info, e.g. Probe failed!

Now logs "Failed to create dmadev %s" with the channel name.

> > +#include <rte_bus_pci.h>
> > +#include <rte_byteorder.h>
> > +#include <rte_io.h>
> > +#include <rte_pci.h>
> > +#include <rte_memzone.h>
>
> Some of the include file are not need for this head-file.

Trimmed: ae4dma_hw_defs.h now includes only <stdint.h> and
<rte_bitops.h> (for RTE_GENMASK64). The PCI/io/byteorder/memzone
includes moved to ae4dma_internal.h, which is what actually uses them.

> > +#define AE4DMA_QUEUE_SIZE(n)        (AE4DMA_DESCRIPTORS_PER_CMDQ * (n))
> > +
> > +
> two blank lines

The double blank lines in ae4dma_internal.h are collapsed to one (all
three occurrences).

> > +# Copyright 2024 Advanced Micro Devices, Inc. All rights reserved.
> 2024 -> 2026
>
> Does this also support run BSD or Windows, if not please add following instruments:
> if not is_linux
>     build = false
>     reason = 'only supported on Linux'
>     subdir_done()
> endif

Both done in v4: copyright is 2026 and the is_linux guard is added
before the x86 check.

Thanks,
Raghavendra
