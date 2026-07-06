Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAF40C43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 12:26:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E68FF40691;
	Mon,  6 Jul 2026 14:26:16 +0200 (CEST)
Received: from SN4PR0501CU005.outbound.protection.outlook.com
 (mail-southcentralusazon11011002.outbound.protection.outlook.com
 [40.93.194.2]) by mails.dpdk.org (Postfix) with ESMTP id 11525402C3
 for <dev@dpdk.org>; Mon,  6 Jul 2026 14:26:16 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a0IBHwEyXSS5YL1GjlgA/c8c6W29Yp2yjoQ20Vjga+ynWpkyRfIk2j01ZK1gxAMOCNzWAoxC9W9Qdt00MlS+XdoiXyVGpmmSxr8lVqiXBwlKXksVgMRxGJnceJaYbrKMnDBbhxmxSSvJhigdevpjiTGyiczy0y2ViafHw9ratncVYmHKnTbHOHF5aBNjWczHrGu6c5qKKrEsQGi4XS85pqaL8Jw9YjEiu/6nffafciHk70SBw4e9zg1yKQ1dPRvqwhYJIXpp+p48HuxWeebEx1ueXOMKJXAWFevEfLB8JI8wTmzOmyomC5GXx4rdvr8wBK+SXq3C5bdbTJLoIVEQuQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ieHyHS54Ut3spBEJR6lEg+nr4MmZeIZROzbi7ARpMmA=;
 b=jdpMBSC15mWi2QPN7V/QNoIsDiE16KX4pfbGkEKW3Bx0OwNo1TLvF4JGI/0xM4gRdi1H9DnYXYpk0xjq5DiXeR3FoxyWPfrZ8O5O8qddm1rgMwO53mruX43rF2Vkj0wb2RLMhN58n46zvpJHtLf5IgWKX7EdO0NpYrgm5dY39DZftKQFhwZXwB2mAUHPJrbNHF3+UyZjJyrZenoy2rO6UGKMEz7eAyjSAtrJkZocMOIaFMlOVD43Pbc722DK2t3gUJfnteqaBC5b0uesa3o/z0SyzWWZP+WFcGyZlvoXDn9OzGsfxkTcJTYrZlyGuuXHYPf1PmEosFcOtNVvrAXu8w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=huawei.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ieHyHS54Ut3spBEJR6lEg+nr4MmZeIZROzbi7ARpMmA=;
 b=EG0qmIaiImt0NA0L/PMMnGmXfJXKopQO5pA9By8kXBi93x4MY70txKBtknrJyK45XITCUgiRNbv8Vet2ZLcivcwnXY5xzVv9IgC+Bs7nAL/Gs8wcG1DOQgzZVXT1ZnffPdTMVfscZo426uJjRH6tHiMLqkBEYO5VgbDb7Cw0q8g=
Received: from PH1PEPF000132FA.NAMP220.PROD.OUTLOOK.COM (2603:10b6:518:1::2b)
 by IA0PR12MB8349.namprd12.prod.outlook.com (2603:10b6:208:407::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Mon, 6 Jul
 2026 12:26:08 +0000
Received: from CY4PEPF0000FCC3.namprd03.prod.outlook.com
 (2a01:111:f403:f910::1) by PH1PEPF000132FA.outlook.office365.com
 (2603:1036:903:47::3) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 12:26:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000FCC3.mail.protection.outlook.com (10.167.242.105) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 12:26:07 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 07:26:04 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: fengchengwen <fengchengwen@huawei.com>, <dev@dpdk.org>
CC: Raghavendra Ningoji <raghavendra.ningoji@amd.com>, David Marchand
 <david.marchand@redhat.com>, Bruce Richardson <bruce.richardson@intel.com>,
 <Selwin.Sebastian@amd.com>, Bhagyada Modali <bhagyada.modali@amd.com>, "Robin
 Jarry" <rjarry@redhat.com>, Thomas Monjalon <thomas@monjalon.net>
Subject: Re: [PATCH v3 2/3] dma/ae4dma: add control path operations
Date: Mon, 6 Jul 2026 17:55:47 +0530
Message-ID: <20260706122548.2938984-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <6db5bccd-f82a-4a31-ab4c-b3addbcbcc94@huawei.com>
References: <6db5bccd-f82a-4a31-ab4c-b3addbcbcc94@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000FCC3:EE_|IA0PR12MB8349:EE_
X-MS-Office365-Filtering-Correlation-Id: 58b8be5d-8fa0-4508-7e32-08dedb59c11a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|82310400026|1800799024|36860700016|56012099006|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: gKeqel6mnOlh9xAGfxbeqUrnr7ScStoX10Z9XMD8AwcywuZs0A45ZfE4HL/AX8iVwKF/scdb01SKLi/DJOHpbHW3DglM/Wa6fTQjI0ToqtcrC8DMYj1stQpMmPlKVGOyoi8+yWo0yAp02NqpCSyEqsnfHeGgl+P8l5ftHGjGFit7X/8WBLRROHrWphfYG/hbBA6AgtjD+q43JjsTV49t/FiZPbBHnz0HI+Er0kc44Z1G9JvPK+VoV9kB0X9VzqM4oHVHHxVtGHV9fuSJ1NLKv6ctrkVEgYSmer9Gp6qRkCBjnpGkfUFJnJ+yukjVhABoRayovwbfXoGUf8yDIGWMSPa10Z3m14IcumYbwuOZFR0fwzeBerzYPOFTIk7v7b8pj4mhHPrGqNIyliR0Al4MxjlwVqUwGSg05XkF9f+hztN+uCWHil6byf6s4CbsWnydEzxsKeg6LzfdJFwTTWO0lqvKbq67OjJo1m1Ete5QcaBIxBRuFEPESoQpqx6R0pNfkQrQamSqjfUluIy/ADSv4tQFSd3DQzN+GbUSXvZQukS4HyYGpkB24Av3f6OEg9kTiO9mio+B5RnKfjmoDOLw3HHLaXyVhGElLLz/PgcB2rmxio22j9RTMiEHDYU1nRITxuT71Mz9rnJa+F0E5WsrYsDEFcbz7xtOHPczr2oSpQpkoPB1lkEFzSkWCvlJiMubJ6IUtugpsBQ22931ytCxIA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(82310400026)(1800799024)(36860700016)(56012099006)(11063799006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 8T8iviANEsdP4Qm50+mBeYpqqKvuTvnmA6TAf4KeuE+RIeVEwFmlqnvi23311QdU9N24/76Dwq8yY+L9bgd9Z87aQukcD3EMIWA0mJ2B579/fXxtd0Cr489BbGD18dD15RdUYE3Cio0ipwqSCFf8KlMuBPORbdKqv+qRpFkRDxfy6z050MBcKXkShmlAPS4uPbT6b08t5ESvyKl9ZsIHncIkMT/8D5/bDlqGkewO7E4nAMGrgVOI71wP53VVbm3syxUdamt3giABJNP8gmCqj5per3bP/tRixX2lko9JPk02G/75DPx+beue4Ci1XgnvtCXxGicVGAgW1i4jlwS59rUJ7kssPJm5Ltdy/SelWpw+WiEfNJGAYsbVRErtwvXgUBwOeTlHnOgwruoNJXVqA0q0CUEgqUfka5ZId7aWSB7Mlu0TpjzpPQ5cufl15xQF
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 12:26:07.0617 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b8be5d-8fa0-4508-7e32-08dedb59c11a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000FCC3.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8349
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

On Fri, 27 Jun 2026 at 08:09, fengchengwen <fengchengwen@huawei.com> wrote:
>
> >  - dev_info_get: advertise RTE_DMA_CAPA_MEM_TO_MEM and the fixed
> >    ring depth.
>
> It seemed declare support 2~32 depth, not fixed

Right. The commit log is reworded in v4 to say the device supports a
2 to 32 descriptor range (rounded up to a power of two), not a fixed
depth.

> > +    if (sizeof(struct rte_dma_conf) != conf_sz)
> > +        return -EINVAL;
> This may break ABI compatible
> ...
> > +    if (sizeof(struct rte_dma_vchan_conf) != qconf_sz)
> > +        return -EINVAL;
> This may break ABI compatible

Both changed to "conf_sz < sizeof(...)" / "qconf_sz < sizeof(...)" in
dev_configure and vchan_setup.

> > +    if (max_desc < 2)
> > +        return -EINVAL;
> No need to do this because rte_dma_vchan_setup already do it.
> ...
> > +    if (max_desc > AE4DMA_DESCRIPTORS_PER_CMDQ) {
> No need to do this because rte_dma_vchan_setup already do it.

Removed both. The framework clamps nb_desc to the advertised
[min_desc, max_desc] range before calling us.

The power-of-two rounding is kept, though: the framework-visible ring
index is free-running and the HW ring slot is derived from it by
masking ((hw_base + idx) & (nb_desc - 1)), which is only correct for a
power-of-two depth. I added a comment to that effect.

> > +    info->dev_capa = RTE_DMA_CAPA_MEM_TO_MEM;
>
> You need also decalre support RTE_DMA_CAP_OPS_COPY, please use dpdk-test
> dmadev_autotest to test it. The dpdk-dma-perf could also test dmadev.

Added. v4 advertises RTE_DMA_CAPA_MEM_TO_MEM | RTE_DMA_CAPA_OPS_COPY.
Together with the data-path ring-index fix in patch 3/4, the device now
correctly reports memory-to-memory copy operation support.

On testing: with these fixes the device passes the DMA API tests and
dpdk-dma-perf. The "DMA dev instance" test suite enqueues 32-deep
bursts, but the AE4DMA ring holds 32 descriptors and reserves one slot
(full when (write + 1) % max == read), so at most 31 can be
outstanding. That suite is therefore skipped on this hardware; patch
4/4 makes its setup return TEST_SKIPPED rather than a hard failure,
matching the existing behaviour of the burst_capacity test (which
already skips below 64).

> > +    if (size < sizeof(*rte_stats))
> > +        return -EINVAL;
> > +    if (rte_stats == NULL)
> > +        return -EINVAL;
> No need to do this check because rte_dma_stats_get already check it
> Please make such check on other ops.

Removed the NULL/size checks in stats_get, and likewise the redundant
size check in dev_info_get (the framework validates the pointer and
passes a fixed size).

Thanks,
Raghavendra
