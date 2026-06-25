Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26D65CDE000
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 18:42:08 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 36017402C6;
	Thu, 25 Jun 2026 20:42:07 +0200 (CEST)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013037.outbound.protection.outlook.com
 [40.107.201.37]) by mails.dpdk.org (Postfix) with ESMTP id 73A4F402BC
 for <dev@dpdk.org>; Thu, 25 Jun 2026 20:42:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NuV82DrF54fLP37Nd9aeWR7Yzjjr2QdZAPVimwuunLsOGRfzZyeD6wmDPPhhhac0K8yuZrSnR91mGhbnkr2r3N6xao9vn55idP0QWSBvbk+0pWH0s5sDqj/4J1wwrNHOr+Ls6/fWM0T8lzPP5fcImKl8xvKQtD0Ow5g4ansBACNhZ1TF6HS3bIX4HoDNppON1U6S/PHcDQGJOIGXYmdAFRUdIjCOHeNR0rz/ps0BMgdIsthh+FENL2VaxW8FoAmgOjxTlUio2uM+37/TJYtZ4Qk06/kKW+NjFGqJifO0YlXCxjbCC3pgehXxOnxisc9D7fk7Jxx1NbwLvyzAlrUaOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2GD6QykMIKH0rH4gQYdA2a5zGWNHoYRd9l5K1GKN77c=;
 b=CUq2okgodSJB2MBUR6tiC66DleYrGKDepDIy7U8L66XvGdSp+iv2taIEyz6XRv9lSEhwbMAxVcy3iqF0YDf56lKcCDQd9XLS5yeAhpaimypkeLEtbSKEX0MzjIob+qPGh9Ttze4TXOgAkhQw5fF2ltALXix1Wis9dam3OJheKz28jw2J3iwP2jNLYr6YBRzkx6kJS/t2o5m18DU7Y12TMxRvcddXzuC3o0lLigI2tj66oDC0QaYrl8Gr9uFWjcY560CfFe5qZAj82mKjBAzJRuq2xiv/SOjckgDF/zG3zvNYmhZSroLkXJK7pEqvUIk7SYavQLGFDwimoqlt/1otQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=redhat.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2GD6QykMIKH0rH4gQYdA2a5zGWNHoYRd9l5K1GKN77c=;
 b=TMWRrZAQ6oyFeoKl5ykV4VEtsolDbALJuJUXQbg6Oo9hHBfgIHY8krGudloP+xAPauFlO7QqlR3Tf7Ba98ljetAECZaQVE0lnyUgKPjjts+xgJXO4VsxJQiCwtGTa3GHbjU4GMO/pyVYmVfLAqVyB/uPN07JHGO7Kb/YTe2KmIM=
Received: from CY5PR22CA0024.namprd22.prod.outlook.com (2603:10b6:930:16::27)
 by LV8PR12MB9405.namprd12.prod.outlook.com (2603:10b6:408:1fa::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.14; Thu, 25 Jun
 2026 18:41:59 +0000
Received: from CY4PEPF0000EE30.namprd05.prod.outlook.com
 (2603:10b6:930:16:cafe::7d) by CY5PR22CA0024.outlook.office365.com
 (2603:10b6:930:16::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.16 via Frontend Transport; Thu,
 25 Jun 2026 18:41:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF0000EE30.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 18:41:58 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 13:41:56 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: David Marchand <david.marchand@redhat.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Bhagyada Modali
 <bhagyada.modali@amd.com>, Robin Jarry <rjarry@redhat.com>,
 <Selwin.Sebastian@amd.com>, Chengwen Feng <fengchengwen@huawei.com>, "Bruce
 Richardson" <bruce.richardson@intel.com>
Subject: Re: [PATCH v2 1/3] dma/ae4dma: introduce AMD AE4DMA DMA PMD
Date: Fri, 26 Jun 2026 00:11:41 +0530
Message-ID: <20260625184141.1677717-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <CAJFAV8w_67sp9iGW9+Gpwxx0ZkDYc4Zc2JKDtsPFFccU0UHePg@mail.gmail.com>
References: <CAJFAV8w_67sp9iGW9+Gpwxx0ZkDYc4Zc2JKDtsPFFccU0UHePg@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE30:EE_|LV8PR12MB9405:EE_
X-MS-Office365-Filtering-Correlation-Id: 10d53b41-d449-4d8a-7d6f-08ded2e9708e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|36860700016|82310400026|23010399003|376014|18002099003|22082099003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: HzC//e7WO+1m4Y9xLlLOkdL+sY6stvzhms1+FnTeXNBAAyEhVRsaAhtgcA8bJzdkgiET9xUXbM9YUMrLLn179T3hllxWpeckBBJZoJG0hE2OOhyLuNWxm4CrkJiMRAS+uNlTzlDtINjUmkLEVfr3f+4fO0FUEB2S5YM+Z7j2LItaK+y8pUZuEj1zM+uhwQcu08LyJm+Kwlm9iQ6a1DbQnlLZvnvNyao2MDgqn6uL9Ovy8jBxLRstljkcqjQfVQXWCuNvXJ4z4wwO/urjhCBO6H/9pEIiHt1VIpDr5rJaD0vg729Xy6wnq9I7utzUPKjjrcgZupdnls0LQpU+i9wHaszVGPFwYPPbYzf43hJ65okVkBQ040DAOiMPHj1pmb38q0KDvtkd02jP3LPlYFNGRRYqMysV/vR0bcl2P1t8slfjPfNRl+gFmAI3EJfPC9qpSdEwiIyWDHa3yOSo06cKhOrPcDnXzNdf7B3PqntbUBjk1SPU0LptPfhcFDMcbdIdV4o0Fn7vfIJnBcoYmExD2rUQMhUzO1wjGz+kQB1BSIaheX7Khri2+F/Zxm7rd5XQcr3Nw9stF8RRZPAO1YMEbLR/5bs6fG0c8TXXdgy4GrFWMHvhYtY+dRBmBValrXb10ztBUa3QasfOrB+185Vdz33WldDDEBOJDLY2V/sJupx63no+6ckh5tkJA3j+WD1Vo/543ZGMWs/mk8UHiV8/fg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(36860700016)(82310400026)(23010399003)(376014)(18002099003)(22082099003)(5023799004)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YmO20jpAft+Zne0XSsgP9FD+vb9G5P+1z9VAbJZ/XUjGV/EkS2IL3LkGFDcPSWGTQw5d5FQ17wrzndBA67MokUbhvHYuPTRhYWpWujqg8SEOfgC+/V83etwKebPpvKMumjNON5xAk/33pLeWFTweyT2Xf0snR+rULGbFRwmhcLf//88jdSzsrdyFkPJOVsungOddhcrwhIe7aTLeqq6SzEKIneToFyUHuVkMGJ1x0LVte3IT3Ql6FxygwVkfdfuQjOITItWLqMPXWFux8BepI2pbUcJO8PEnRt+8f0qJ8ooUwFyMi7VN9TtAgYyfSf3eiTmdkEfK8MahV+WnpRn+Cnz8UC30ttfw7tf3gKuE5ICT13igO1N4tZdflsRU0cXK/MmlkpAbHdYdBhDHzlURCffRUo00Tr5fVSEwd08o5omFjELvwbnV2sVBIcjw8HgL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 18:41:58.9904 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 10d53b41-d449-4d8a-7d6f-08ded2e9708e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EE30.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9405
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

On Mon, 22 Jun 2026 at 14:06, David Marchand <david.marchand@redhat.com> wrote:
>
> Here is a superficial review.
>
> Many places are fishy when it comes to integer/pointer casts: I only
> raised a few comments on this topic.

Thanks for the review. I went through the cast usage as well; the
low32_value()/high32_value() helpers (which took an unsigned long and
were therefore broken on LLP64) are gone in v3, replaced by
lower_32_bits()/upper_32_bits() on the rte_iova_t value, and the
redundant index casts are removed. Replies inline.

> > +       q_mz = ae4dma_queue_dma_zone_reserve(cmd_q->memz_name,
> > +                       cmd_q->qsize, rte_socket_id());
>
> I see no tracking of q_mz, so I suspect this memzone is leaked on
> device probing failure, and/or unplugging.

The memzone is now stored in cmd_q->mz at probe time and freed directly
in dev_close(). dev_close() is reached on the unplug path too
(remove() -> rte_dma_pmd_release() -> rte_dma_close()), so the ring is
no longer leaked.

> > +       cmd_q->next_write = (uint16_t)AE4DMA_READ_REG(...);
>
> Strange that you need to cast.

Removed; next_read/next_write/last_write are uint16_t and the registers
are read into them without an explicit cast in v3.

> > +/* Create a dmadev(dpdk DMA device) */
>
> This is a general comment for the patch: let's avoid Lapalissade /
> trivial comments that adds nothing.

Removed the trivial "what" comments across the series.

> > +       struct rte_dma_dev *dmadev = NULL;
> > +       struct ae4dma_dmadev *ae4dma = NULL;
>
> Those variables do not need any explicit setting to NULL [...]

Done.

> > +       if (!name) {
>
> [...] This is a static helper called internally from a single
> location, remove the check.

Removed.

> > +       ae4dma->dmadev = dmadev;
>
> [...] this field is never used in the series. Please remove.

Removed the field and the assignment.

> > +       ae4dma->pci = dev;
>
> [...] no user of this field in the series, please remove.

Removed. ae4dma_add_queue() now takes the rte_pci_device pointer as an
argument instead.

> > +init_error:
> > +       AE4DMA_PMD_ERR("driver %s(): failed", __func__);
>
> __func__ is already part of AE4DMA_PMD_LOG.

Dropped __func__ from the message.

> > +       dev->device.driver = &drv->driver;
>
> Setting the driver pointer in the device object is not the driver
> responsibility anymore [...]. EAL will set this field on probe()
> success.

Removed; the drv argument is now __rte_unused.

> > +#ifndef __AE4DMA_HW_DEFS_H__
>
> Is this header autosufficient ? I see references to uint32_t below,
> so this header probably depends on stdint.h.

Added #include <stdint.h>.

> > +#ifdef __cplusplus
> > +extern "C" {
>
> Do we really need C++ guards?

Removed (internal header).

> > +       AE4DMA_HWQUEUE_NOT_EMPTY = 4
>
> For consistency with other enums, add a comma.

Done.

> > +/**
>
> This is an internal header, we don't need doxygen style comments,
> simple comments are enough.

Converted the doxygen comments to plain comments.

Sent as v3.

Thanks,
Raghavendra
