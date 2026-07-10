Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AD75C43458
	for <dpdk-dev@archiver.kernel.org>; Fri, 10 Jul 2026 07:36:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 60D1240274;
	Fri, 10 Jul 2026 09:36:38 +0200 (CEST)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
 by mails.dpdk.org (Postfix) with ESMTP id 322054026A
 for <dev@dpdk.org>; Fri, 10 Jul 2026 09:36:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cVjGi3eQTCTf5yR2JAKPsxF8qltyuRb4OU8xzHqwKgJjwY0XahPT8XY5Xowmbfk/2piexUngmQggwhJ5pA32IM+TV0pw2jsvIbdpb/0kYORLjGAWM0loUuoHTaJpNhyatKXuHX49vsJ/yHILEIwIFEZLWPLhF072/ZQeRKJqiRRQulxcOh4GqUEXdQRvOWL5hVyqTVbBpAIwXaqoB3489yBW3HjDTmQHTlmyvo2leImECOPU3sm2dRS04Afhjdj3G/QfDVR32l5AirP9n7uUhcdxeC4yG6mvsmbrBMvm8pltJ+1z1dRNGmobi4uGM7qWYPbEBBrUaw8/V1QHu2MrRw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=B0NSnyjc52NUUhFPQN4L8WNiSEw+Nc98AlMA+NhWiEU=;
 b=BJwdIwnpxVDhXFTjYpxGgPrbzrxApnAdkjXg08PfRIY8FDGvJbuYwjs8Cd/yEEk+qERYpvHczJ6i+jiBd5aZLyDiYU4frW7GxXAehjVueck9Br766zz63bKv3rGcDtGfnF1yYqsW0+nrGRM3b39QJHFpjvgOqEFiayva2qFrB1Hvnv+3Je8rHhrd700ziHUVVWkzUAvgnrZjxsREsVS601hKJ468j1Ke7qTbIIwQ8iKePo3LJTUgqHFrdHmx7q+wZtPWr0yu/rcIbqiWRmdlK0YfWNM7MSzHTlfr5kjn4acqQ+cPDcA7PGddxQWjXg2fGDbT/CQLnUSNK7wzsOERog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=B0NSnyjc52NUUhFPQN4L8WNiSEw+Nc98AlMA+NhWiEU=;
 b=0uuIzqqmNl1V6fF8Kpc4Z9crLsj94pdZOx3A8W4OSQKZFEauC1NoMFey9dbxxZ47o5yrdC3vyZgNn1kSLOay4cWmKxwfu1hkZe4CO+g3f9smnzz4d3vx2ujY7p8qgM2AgdpiXfMxZUFk/fuz92DsbL3sKLe3eROfaQdAVauYxU8=
Received: from BL1PR13CA0415.namprd13.prod.outlook.com (2603:10b6:208:2c2::30)
 by BY5PR12MB4145.namprd12.prod.outlook.com (2603:10b6:a03:212::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.17; Fri, 10 Jul
 2026 07:36:30 +0000
Received: from BL6PEPF0001AB59.namprd02.prod.outlook.com
 (2603:10b6:208:2c2:cafe::ab) by BL1PR13CA0415.outlook.office365.com
 (2603:10b6:208:2c2::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.3 via Frontend Transport; Fri, 10
 Jul 2026 07:36:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB59.mail.protection.outlook.com (10.167.241.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Fri, 10 Jul 2026 07:36:29 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Fri, 10 Jul
 2026 02:36:26 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <fengchengwen@huawei.com>, <david.marchand@redhat.com>,
 <bruce.richardson@intel.com>, <selwin.sebastian@amd.com>,
 <bhagyada.modali@amd.com>, <rjarry@redhat.com>, <thomas@monjalon.net>,
 Raghavendra Ningoji <raghavendra.ningoji@amd.com>
Subject: [PATCH v5 0/4] dma/ae4dma: add AMD AE4DMA DMA PMD
Date: Fri, 10 Jul 2026 13:06:04 +0530
Message-ID: <20260710073608.3034898-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB59:EE_|BY5PR12MB4145:EE_
X-MS-Office365-Filtering-Correlation-Id: 99993716-0723-492f-c7dc-08dede55f501
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|36860700016|23010399003|82310400026|56012099006|11063799006|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: p9QOxWy0k8Jfyk+EPzIUJk46+ZRJMI0K0lD2ZkvbQNXONK4wx1jCZ52iUizBtGqYa336yD+IekYQzGNAwD24l38zRyb+eU2OufEO/Ncw09eK7cShiBZZRpWbfPuK2xl9TllOa0jCnU69sXDJJ5BQujFuk0fPJwXVaTqCS99BNBFG1RtrS5V2y0kSC9NJP/A2itj9aom4Q80XlZBcWPM+y96TtWa+O8eE4OFRv5lfdnhgf92M7/rn/s12vTgCHOjehbML5qBGHz4dGDtbnhjhKzsPSZUPfp/fGxXcSwYYWdoeaJMShfawmlHuCH1v++GMDg4Q/wq+oo7S5TDonRPzFTYTIQdVZAbpe5V3v3pdgh93du0yWgzuYUwS1QH3vb+C2bk2/9IMu+v4BTQhwidQvHPE46Z29DgalYvyTdOrxwxaKxTrSwLUiLqg48qdxWf2r0MeVJMqMPAY1UktexS9puChxxW2mhTLH6pextWj5DUGr2PcC7ef7+TYgMfoo9bScYud7+RQcfCqkTLE2JLk5otimQXYXWhZjTtweCKXR4TO4DA9/UFf/pBo0iZHSXcE+nFg8+QI86oaFe0g0X9g6Gyi/xwzPoqToDah/A+sluwaKIM6q8Q9UvdXNaGfZoj5YhaKQace0PuUUlgsdvX4mDzur8KmdlRSS0ypepr+/soW4Pg26GZD0XwwE821cp/3sj6SsDV69GoD0BZ7vFXV2Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(36860700016)(23010399003)(82310400026)(56012099006)(11063799006)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: OsmR2M7fWBGfRNTkDKxT6GDIoMVNZiXCPtUg+tTurc65UvTxNfBtipx5bDnEr4e9AuKTZnOvwhdSAzLagYlxTz1Ouo+iwmYLMY38ifSQjkKDjj+HdGR9PVTfL1HzSBzwbuxkKcgowT+mMXFVYK0lDMZgGHVw9SYeMsVZ+ns3McZa7HdOigRowUyLztiI3bv50M8UeBfpOcGToKuqFz+9tq/KlVUc8A9OxEU0YmqxQm47ijlxtG+24C/PfdF0uEp+utMq91a66opDxTgyh7BGf2lxuci7gU+YPH5YAV4kE5UQ4IVCo5N1kXXKMHey/RhfpCGcvPhOcQuVk791wVByltflrFLmu+h8D+d14v+9FR/opr4W9B5leWIuIqdmRVSXWUN2RfakEc7jBQCuRI1I2wP5qJl+mRD/jNQ7r5t6eeOLgRzOq3NZNbRzmgD0DEQ8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jul 2026 07:36:29.6956 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 99993716-0723-492f-c7dc-08dede55f501
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB59.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4145
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
hardware DMA engine, split into introduction, control path and data
path patches, plus a small dmadev test-suite patch.

v5 addresses the v4 review comments from Chengwen Feng.

Changes since v4:

Patch 1/4 (introduce):
 - Drop the custom AE4DMA_BIT() macro and use RTE_BIT32() from
   rte_bitops.h for the DWORD0 control-bit and memory-type defines.
 - Remove the now-unused per-queue status[] array from
   struct ae4dma_cmd_queue (completion status is derived directly from
   the descriptors in patch 3).

Patch 3/4 (data path):
 - Fix rte_dma_completed(): stop at the first failed descriptor and
   return only the run of successful ops preceding it, set *has_error,
   and leave the failed op to be reported by rte_dma_completed_status().
   last_idx now reports the last successfully completed ring_idx.
 - Drop the redundant 'if (last_idx != NULL)' check; the framework
   always passes a non-NULL last_idx.

Patch 4/4 (test):
 - Unchanged; retains TEST_SKIPPED for sub-32 burst capacity.

Changes since v3 (carried over, for reference):

Patch 1/4 (introduce):
 - Fix copyright years (2025/2024 -> 2026) in ae4dma.rst and meson.build.
 - Drop the unnecessary memzone lookup/reuse logic; rings are reserved
   once at probe.
 - Trim ae4dma_hw_defs.h includes; move the rest to ae4dma_internal.h.
 - Remove redundant double blank lines in ae4dma_internal.h.
 - Use an initialiser instead of memset() for hwq_dev_name and reorder
   local declarations in descending length.
 - Make the probe-failure log message more descriptive.
 - Build only on Linux (add the is_linux guard to meson.build).
 - Add a hw_base field to anchor the free-running ring index.

Patch 2/4 (control path):
 - Advertise RTE_DMA_CAPA_OPS_COPY in dev_info_get.
 - Use 'conf_sz < sizeof(...)' instead of '!=' to stay ABI compatible.
 - Drop checks already performed by the dmadev framework.
 - Reset the free-running ring indices in vchan_setup and dev_start,
   anchoring index 0 to the current HW consumer slot (hw_base).
 - Reword the commit log for the 2 to 32 descriptor range.

Patch 3/4 (data path):
 - Return free-running 16-bit ring_idx values from rte_dma_copy() and
   completed()/completed_status(); HW slot = (hw_base + idx) & mask.
 - Map the AE4DMA alignment error to RTE_DMA_STATUS_ERROR_UNKNOWN.
 - Drop the redundant power-of-two/range check in burst_capacity().
 - Document the 32-descriptor / 31-outstanding ring-depth limitation.

Patch 4/4 (test) - added in v4:
 - Return TEST_SKIPPED instead of failing the instance suite when a
   device reports burst capacity below 32, matching the existing < 64
   skip used by the burst_capacity test.

Note: the power-of-two rounding of nb_desc in vchan_setup is retained
on purpose: the free-running ring index is mapped to a HW ring slot by
masking, which is only correct for a power-of-two depth.

Raghavendra Ningoji (4):
  dma/ae4dma: introduce AMD AE4DMA DMA PMD
  dma/ae4dma: add control path operations
  dma/ae4dma: add data path operations
  test/dma: skip instance suite on low burst capacity

 .mailmap                               |   1 +
 MAINTAINERS                            |   5 +
 app/test/test_dmadev.c                 |   8 +-
 doc/guides/dmadevs/ae4dma.rst          |  77 +++
 doc/guides/dmadevs/index.rst           |   1 +
 doc/guides/rel_notes/release_26_07.rst |   7 +
 drivers/dma/ae4dma/ae4dma_dmadev.c     | 677 +++++++++++++++++++++++++
 drivers/dma/ae4dma/ae4dma_hw_defs.h    | 149 ++++++
 drivers/dma/ae4dma/ae4dma_internal.h   | 113 +++++
 drivers/dma/ae4dma/meson.build         |  13 +
 drivers/dma/meson.build                |   1 +
 usertools/dpdk-devbind.py              |   5 +-
 12 files changed, 1054 insertions(+), 3 deletions(-)
 create mode 100644 doc/guides/dmadevs/ae4dma.rst
 create mode 100644 drivers/dma/ae4dma/ae4dma_dmadev.c
 create mode 100644 drivers/dma/ae4dma/ae4dma_hw_defs.h
 create mode 100644 drivers/dma/ae4dma/ae4dma_internal.h
 create mode 100644 drivers/dma/ae4dma/meson.build

-- 
2.34.1

