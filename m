Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB5FACDE009
	for <dpdk-dev@archiver.kernel.org>; Thu, 25 Jun 2026 18:47:55 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id DBE50402C6;
	Thu, 25 Jun 2026 20:47:54 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013021.outbound.protection.outlook.com
 [40.93.196.21]) by mails.dpdk.org (Postfix) with ESMTP id E02A9402BC
 for <dev@dpdk.org>; Thu, 25 Jun 2026 20:47:52 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qTZsxzgbmwPkvg7+L6bz7mppuV7jn3/nCbsqdfn8TRTlv8qT0xjVFpvxCVELgcf5ij/FdrUCpmdL2AuJ1IE2AmCjceGzvzXQj6j0Y6+J5jaZ3dBOIZbMM6iGeaHoLzVAuhciSe2RbuNKZwdOheD3vVEVo+FmFpuFBy626Iew5BY85kFdHNnyiqr9+XMSVATXhJDqFWj77IjMmf3iPQa9m+tpR8zjRis594snczC0XvHitNwQHw85wG9c0Xwqkly9FqojG6MeiWeRWO30agE5mb5/xakxU0WZnKBOp2yHWmCVBxR8rVXmqsJ7xWUj+anv1Qk/Xh2S6SkV1PUWWXHVnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IBG52+d0oX392zu7CJ+IiAQ5/PVK0Ngfl2u7q3wcaNs=;
 b=hSSYVNpG/t2iARg2vixnV1aa4lXdu3/pRvpDNoCZNtZonxRWLwsEsUvVC6/cmGYJOVniCJoiIgeXWusGBLTKsHPCqb/Lvxgdq+7DxXlBvbZeE1VbigxCyPc+ciN4osZkuln3uPLOIShnhGC5orvlo+jZwYbpg2sOXXTLnrPotxIjnIU95iNws4NT1pvQpVvc1JRcTUxQu40czdTUdjT5txc8o/q8mOh4S3SZsH+fVYZuC8YgdN2ffUsaQ6PNAd2hcUqh1mJWNWjpKIo3i3mvCApZIw5EiVqO2LyrlXr8hWPSCHkTLq/ivZImx90FBFcMeuOp4sMdOu7oLx0wuFvvWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IBG52+d0oX392zu7CJ+IiAQ5/PVK0Ngfl2u7q3wcaNs=;
 b=mF5pZp6ZHdMi5dk8QotCU3XzcHyk0FgYz+MpI3Zc4vrHJ8+I13f4EXJ1WVzJAKptKhtAJBOKSNhzRvY5TAflXLivecug4naWRhdd6j1s9yKdVQg4dupjeNFhlHcu/J079BtogCSGjDM1rnvCjz1cd4DAiXQkvW05kahRHuRJXEo=
Received: from DS7PR03CA0281.namprd03.prod.outlook.com (2603:10b6:5:3ad::16)
 by CH1PR12MB9669.namprd12.prod.outlook.com (2603:10b6:610:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.17; Thu, 25 Jun
 2026 18:47:46 +0000
Received: from DS3PEPF0000C381.namprd04.prod.outlook.com
 (2603:10b6:5:3ad:cafe::89) by DS7PR03CA0281.outlook.office365.com
 (2603:10b6:5:3ad::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.15 via Frontend Transport; Thu,
 25 Jun 2026 18:47:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C381.mail.protection.outlook.com (10.167.23.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 25 Jun 2026 18:47:45 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 25 Jun
 2026 13:47:42 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <bruce.richardson@intel.com>,
 <fengchengwen@huawei.com>, <Selwin.Sebastian@amd.com>,
 <bhagyada.modali@amd.com>, <rjarry@redhat.com>, <thomas@monjalon.net>,
 Raghavendra Ningoji <raghavendra.ningoji@amd.com>
Subject: [PATCH v3 0/3] dma/ae4dma: add AMD AE4DMA DMA PMD
Date: Fri, 26 Jun 2026 00:17:25 +0530
Message-ID: <20260625184728.1678328-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260525184244.1758825-1-raghavendra.ningoji@amd.com>
References: <20260525184244.1758825-1-raghavendra.ningoji@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C381:EE_|CH1PR12MB9669:EE_
X-MS-Office365-Filtering-Correlation-Id: 0ad7b05f-ddc3-4e24-9126-08ded2ea3f39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|1800799024|36860700016|13003099007|6133799003|56012099006|11063799006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: KrONWPcIPP4eI8k15l0NsoFPuE1Df8MKj+keCkHGkXL1Z7ZOR9HxRbsdYGF4903acY+fGmaYD0SwGRIuCOh8fDeSFlsvYmoDwOuSBZ7UTWhGoYa9lFkxKqg6vDEaJYTO+UcYJkHz3n6Am2LmNxAiFPEVbXOZfWhKxjBeiWqsgV/hPEvjqCIwRb1Wnj9q9BZX+vOJAMvEp9xQhAWcEnUj1wP8GUZduxO3V59vq8TjelQjVymdngunAjqT03rDXhseGq/LF+lTKdeuV8xMX/jRnehaEjxTSBk+MuT4ljYjBrd1J44l2Xs5p4ZYoX5AlVpzb2buVVtgomLd3vdSB8MvNnawxS5gPQn1tmQNZoJjffwYg0qBCE41rGHhvAwf0ahqtEJewCDNBq5SJBx3irGVtE9dTqH3uLgPCYmUTrJSDrlUAHGVsGTWfQarDRSL2dJ3QwI21A21eMPikyzzOnUIhDL9TcSTIoPvqdJW30kKwBH7AXF4O5YOetVmL9zWa8e2rjXOExojTYZ8oMFDQmKF2HvwWkPmhmXdFkI3JulazwHmPXpFycWbuAVkqV7S0LoeXd7HGxl9LETPAwlj7SDtCEhWib2sgbwbZpIJzKyrlkFNOUqScgv2nq/GMoIpv+DpX938lm7F2z4Dp+SS5hclTcclnguv9Qhiq10fO9wmtjws1HAok+SPkJtAiyFaPddjrC4VqAyao6OmQkcAEORDSw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(1800799024)(36860700016)(13003099007)(6133799003)(56012099006)(11063799006)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ma+zTm7MImfzxHQyTDW992LWa+g4cDTBm/gXKD8T0ZNX6m/TL1nK93zjYi11WFlcSj721VocUmMffOWvPPgMqh2FtF6lm/Lki8Q7I0POJ/+dMt970jFVc/kbaiALuNup2yG/ZXF+MKrBCCnagdWDqLnBUKsLshmk0wFyLcr5Sk1RfHVIzyqLnTDfvvPpACwr2fixwsfFQWuXDhdyDzbRwj0SuFJG0sRXRcEZ9tMEuuGULbkehahO/YbxASkXTDdvtFbhNJkAvECXaLeK17ieM5f/ad0u1woHOpdTfI2wQctndbvZtWqZZcgZW0j22l7m2AT+Yl0eXUjUCDlQRkP0vYqe5XjxFmSchUR7F8ppguXhWz8AyGXiYQ+Dwvkt8lNLqc4Pg2kdb/UiUPELUrnyBevq9RQHuhAydctlIrSFTlc04gUcgilelR2t30o1LE0o
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jun 2026 18:47:45.7269 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0ad7b05f-ddc3-4e24-9126-08ded2ea3f39
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C381.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9669
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

This series adds a new dmadev poll-mode driver for the AMD AE4DMA
hardware DMA engine. An AE4DMA engine exposes 16 hardware command
queues, each with a 32-entry descriptor ring; the PMD maps each
hardware channel to its own dmadev with a single virtual channel,
so a PCI function appears as 16 dmadevs named "<pci-bdf>-ch0" ..
"<pci-bdf>-ch15".

Driver characteristics:

 - Memory-to-memory copy operations only (RTE_DMA_CAPA_MEM_TO_MEM).
 - Completion is detected via the hardware's per-queue read_idx
   register, which the engine advances as it processes descriptors.
   The descriptor status / err_code bytes are read only to classify
   each drained slot as success or failure.
 - vchan_status reports IDLE/ACTIVE based on HW read_idx vs write_idx
   and HALTED_ERROR when the queue is not enabled.
 - depends on bus_pci and dmadev.

The driver is introduced in three logical patches, following the
pattern of the recent hisi_acc dmadev driver:

  1/3 - introduce driver (probe, remove, per-queue HW init)
  2/3 - add control path operations (dev_ops)
  3/3 - add data path operations (copy, submit, completion)

Changes in v3:
 - Address review comments from David Marchand on patch 1/3 and 2/3:
     * Track the descriptor-ring memzone in the queue structure and
       free it directly in dev_close() instead of re-resolving it by
       name (also fixes the potential leak noted on probe/unplug).
     * Drop the unused back-references (ae4dma->dmadev, ae4dma->pci);
       pass the rte_pci_device to ae4dma_add_queue() instead.
     * Stop setting dev->device.driver in probe(); EAL sets it on
       probe() success since commit f282771a04ef.
     * Remove the redundant NULL name check in the single-caller
       helper, the needless NULL initialisers and the __func__ in the
       error log (already added by the log macro), and the NULL test
       before rte_memzone_free().
     * Remove the info->dev_name assignment (set by rte_dma_info_get()).
     * Replace the unsigned-long low32_value()/high32_value() helpers
       with lower_32_bits()/upper_32_bits() and drop the redundant
       index casts.
     * ae4dma_hw_defs.h: include <stdint.h>, drop the C++ guards and
       add the missing trailing enum comma; ae4dma_internal.h: convert
       doxygen comments to plain comments.
     * Remove trivial "what" comments throughout.
 - Reorder the .mailmap entry into alphabetical position.
 - Naming/architecture (16 dmadevs per PCI function, "<bdf>-chX")
   acknowledged as acceptable by Chengwen Feng and Bruce Richardson;
   kept unchanged.

Changes in v2:
 - Split the monolithic v1 patch into three logical patches
   (introduce / control path / data path), mirroring the
   structure used by drivers/dma/hisi_acc.
 - Fix checkpatches.sh warnings in ae4dma_internal.h (RTE_LOG_LINE_PREFIX,
   C99 __VA_ARGS__, __rte_cache_aligned placement).

v1: https://patches.dpdk.org/project/dpdk/patch/20260518181856.1228373-1-raghavendra.ningoji@amd.com/
v2: https://patches.dpdk.org/project/dpdk/patch/20260525184244.1758825-1-raghavendra.ningoji@amd.com/

Raghavendra Ningoji (3):
  dma/ae4dma: introduce AMD AE4DMA DMA PMD
  dma/ae4dma: add control path operations
  dma/ae4dma: add data path operations

 .mailmap                               |   1 +
 MAINTAINERS                            |   5 +
 doc/guides/dmadevs/ae4dma.rst          |  75 +++
 doc/guides/dmadevs/index.rst           |   1 +
 doc/guides/rel_notes/release_26_07.rst |   7 +
 drivers/dma/ae4dma/ae4dma_dmadev.c     | 718 +++++++++++++++++++++++++
 drivers/dma/ae4dma/ae4dma_hw_defs.h    | 154 ++++++
 drivers/dma/ae4dma/ae4dma_internal.h   |  97 ++++
 drivers/dma/ae4dma/meson.build         |   7 +
 drivers/dma/meson.build                |   1 +
 usertools/dpdk-devbind.py              |   5 +-
 11 files changed, 1070 insertions(+), 1 deletion(-)
 create mode 100644 doc/guides/dmadevs/ae4dma.rst
 create mode 100644 drivers/dma/ae4dma/ae4dma_dmadev.c
 create mode 100644 drivers/dma/ae4dma/ae4dma_hw_defs.h
 create mode 100644 drivers/dma/ae4dma/ae4dma_internal.h
 create mode 100644 drivers/dma/ae4dma/meson.build


base-commit: f724d1c0d1c1636b9c171c34db3f17c3defaa2f3
-- 
2.34.1

