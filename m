Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49DFC43458
	for <dpdk-dev@archiver.kernel.org>; Mon,  6 Jul 2026 11:56:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A4F62402C3;
	Mon,  6 Jul 2026 13:56:03 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012020.outbound.protection.outlook.com
 [40.93.195.20]) by mails.dpdk.org (Postfix) with ESMTP id 8711F4027B
 for <dev@dpdk.org>; Mon,  6 Jul 2026 13:56:01 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lgj/TXbyPcocucxUBEP+V3MX9kuzpk4dsq1QW7JXhNvD8+eybEglQPKANHEZjhltt1DocuVGj9o4Dk6kxSXBMtbxYjaRobLzLve4/4J+Mx6x0ykuPzMBuaXocXM8aNhFZgXYVZ9Is+uNTYpG19JIzcUKUptCnf6FP6BIEyTdhi/6RdJqhtDOa3Lp9M82TJ/l76nNI01h3DScRp3hMI9n2w4LTfHr9CgL/EJrwtEi9l5CQiY3RZmlSvdLf5x4yTU2MYzQzHb53a2r9vZF+YdZZdpbenfO/w3cxutWTNMRYkzItdBpt+PtjLoD1t0hzTAZ36bhO2svKmoaQUv+mfXgAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3K5/C8J/GGghYxortuepIPhc2dX+f4RJz/NJZPOBfQ=;
 b=wadZBV5bYYYS9XODNmFTZHBgW5Rixg750S5TJwSP99SIDYtdSC+bb3P3bJnXjN6qbf5FQ+iklUZ7rOS2KyXEWeT+/psMkIpOt342I6dIfdhzFBD1glerGv4iPXEl01nlrUWZSyYaaTGNx8EU0fr/GA/qfJQPuLxHOvtkp7kUa6mDx0cyRckh7cSMEkbtUPATaXu8cXEBosCgauoWy7LM4nk0YiyTVjsxYCT4BqdEo1UL1mQbu98HK8nSJVufS6jPCPpy7VrVNNe1RJhagh8KZqFl5VTrh/25GUv7b/5orL89nk0pXbWlrojnc01+kvI8ygtXdAvumKmuozdaGTsE/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3K5/C8J/GGghYxortuepIPhc2dX+f4RJz/NJZPOBfQ=;
 b=i36N4MfV3hx6tDomUp88w762dj/qpxY4E0odEKhT5BcPmp7CKggwBBdcop5SoWbtL/gDrbOeQfbZZJvnEN5RnYOfDj198/OmnhiHJY3MYRL45BYp3GPd7NR4DPGKHoFJJLsTX+M4qzRDYrvzKNYnBJXfQkMkTdR0ADY5C7C7p50=
Received: from BY1P220CA0026.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::17)
 by SJ5PPF4C62B9E70.namprd12.prod.outlook.com
 (2603:10b6:a0f:fc02::991) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Mon, 6 Jul 2026
 11:55:55 +0000
Received: from SJ1PEPF00001CE4.namprd03.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::57) by BY1P220CA0026.outlook.office365.com
 (2603:10b6:a03:5c3::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.13 via Frontend Transport; Mon, 6
 Jul 2026 11:55:55 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE4.mail.protection.outlook.com (10.167.242.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Mon, 6 Jul 2026 11:55:54 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 6 Jul
 2026 06:55:51 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <fengchengwen@huawei.com>, <david.marchand@redhat.com>,
 <bruce.richardson@intel.com>, <selwin.sebastian@amd.com>,
 <bhagyada.modali@amd.com>, <rjarry@redhat.com>, <thomas@monjalon.net>,
 Raghavendra Ningoji <raghavendra.ningoji@amd.com>
Subject: [PATCH v4 0/4] dma/ae4dma: add AMD AE4DMA DMA PMD
Date: Mon, 6 Jul 2026 17:25:29 +0530
Message-ID: <20260706115533.2937512-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE4:EE_|SJ5PPF4C62B9E70:EE_
X-MS-Office365-Filtering-Correlation-Id: e1de6c5e-e4ca-4471-54d8-08dedb5588ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|6133799003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: EFH+RBpEp4NmImh9Je28nmq3cAGBMLk9QkZj1bahZldCh+BOFpaD7utDQIYstalWxFK2moSzv/HjCY5ChxIaMIl7kRpbAmLqNA1WO6ew/0FivP6Bewt6uN9cE2XhyIbpExo4OZzy6A54vEK7R5mCyhsJWmXBWbVwlOmYY52tbScf/FIqt2QAPjmUrq5TQMO/6EsKD8oyPvipo0vjQU/Jd59P1CnBiS4Uu8JFytKlselBxVg8G0eIPxTeTiIg6bmNoI7QPt98GY/6YBZjsXNk6047448/y9rGKutBqKHE1dpNodpATp5yLczT7DDfnqLys+6UbGdEGgbfbxA8UigIHq5UwKBj21qTWZErOcvZ+2wzM6RfTHgcCjLyQ4ZcyudjwCD0wcOfXgXM3R/YaSQqg1QxpYof9MERrVt/CSW2P2WmPGGe13mQb8DvBkmPUkaan0a+cbTuu+xLSBmSGVp4PI+2K3mEAMI2lG8fDexfo0I+1Nps+N47cVZBkxBpZGIz0ciXRHK29Vws+XV9x38q/uVZOVvLhGyrNOHuIUdQpD2fssEAhIheIECyZ0X5gDItsGtURv/Jss2jiVjzdlybcfrccD91pfpABrsxD1mjSL1ICJoUPmHDCbUAiiisa3+KuY6ofJygMo38OcQjZC2AxY3s+XDuFbK7PavGO5WeqH5OWNmh1mNAx/EheTdTgRYAedm+7JlEdKV6PEl50M6waA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(6133799003)(5023799004)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ltbzdYB/LJmv+tQBEQA702SRJxtJnlCPI8qOXTmWq+Lqo7Il+WvEg0+/R5MX3DXdvNWjTHZTR7I+5nb6AtyFzp5DKJ/MYKJOdBhqxbGdXnV+/7NNvjX8zwFy19qmlURvd1x2+eS7fwrRpZCY8Zhf+yOOlC+jpx0lkfTnsN2Ox8O516Q8pYcrPgy5gIYLhyQBlrH86+VeMF/SZFOM5T5OF6pyjCelV9bWhsKvxeN16kumpYZRDKzIpal8PTOkz+mBmpJjLt+drzLD7NXMJaC+/1t1L6PcY/HGocP41vAKwlcsscdnN2LmHWVE/ul3WH4corLFZMOMx2rNCnZlT7OJ2nCHDEkU3r1b1Qct2hBF9NEyqCVcc6rkiewbdV/XiVn8ZG3mgan644bksASQFBMFFlpp7RU3BvC2O7SX9spPA+u6f4VKTTqbq3M5C0Axx47/
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Jul 2026 11:55:54.7727 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e1de6c5e-e4ca-4471-54d8-08dedb5588ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ5PPF4C62B9E70
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

v4 addresses the v3 review comments from Chengwen Feng.

Changes since v3:

Patch 1/4 (introduce):
 - Fix copyright years (2025/2024 -> 2026) in ae4dma.rst and meson.build.
 - Drop the unnecessary memzone lookup/reuse logic in
   ae4dma_queue_dma_zone_reserve(); the rings are reserved once at probe.
 - Trim ae4dma_hw_defs.h includes to only what the header needs
   (stdint.h and rte_bitops.h); move the rest to ae4dma_internal.h.
 - Remove the redundant double blank lines in ae4dma_internal.h.
 - Use an initialiser instead of memset() to zero hwq_dev_name and
   reorder local variable declarations in descending length.
 - Make the probe-failure log message more descriptive.
 - Build only on Linux (add the is_linux guard to meson.build).
 - Add a hw_base field to the command queue to anchor the free-running
   ring index to the HW consumer slot (see patch 2).

Patch 2/4 (control path):
 - dev_info_get now also advertises RTE_DMA_CAPA_OPS_COPY so the device
   correctly reports memory-to-memory copy operation support.
 - Use 'conf_sz < sizeof(...)' instead of '!=' in dev_configure and
   vchan_setup to stay ABI compatible.
 - Drop the checks already performed by the dmadev framework
   (nb_desc bounds in vchan_setup, NULL/size checks in stats_get,
   size check in dev_info_get).
 - Reset the free-running ring indices in vchan_setup and dev_start so
   ring_idx restarts from 0 on every (re)start, as expected by the
   dmadev API. read_idx is HW-owned (read-only), so index 0 is anchored
   to the current HW consumer slot (hw_base) and dev_start (re)enables
   the queue and sets write_idx == read_idx to start empty.
 - Reword the commit log: the device supports a 2 to 32 descriptor
   range, not a fixed depth.

Patch 3/4 (data path):
 - Fix the framework ring-index contract: rte_dma_copy() now returns,
   and completed()/completed_status() now report last_idx as, a
   free-running 16-bit value in [0, 0xFFFF] instead of a [0, nb_desc-1]
   ring slot. The HW ring slot is derived as (hw_base + idx) & mask.
 - last_idx is always set to the last completed ring_idx, including when
   completed()/completed_status() reap nothing, matching the dmadev API
   and the ioat/idxd drivers.
 - Map the AE4DMA alignment error to RTE_DMA_STATUS_ERROR_UNKNOWN
   instead of reusing RTE_DMA_STATUS_DATA_POISION. Adding a dedicated
   RTE_DMA_STATUS_INVALID_ALIGNMENT to the public API can be a separate
   follow-up.
 - Drop the redundant power-of-two/range check in burst_capacity().
 - Document the ring-depth limitation: the hardware fixes the ring at
   32 descriptors and reserves one slot, so at most 31 operations can
   be outstanding (burst_capacity() returns at most 31).
 - Condense the commit log.

Patch 4/4 (test) - new in v4:
 - test/dma: return TEST_SKIPPED instead of failing the instance suite
   when a device reports a burst capacity below 32. The AE4DMA ring
   holds 32 descriptors and reserves one slot, so at most 31 can be
   outstanding; the instance suite enqueues 32-deep bursts and is now
   skipped rather than reported as a failure on such hardware, matching
   the existing < 64 skip used by the burst_capacity test.

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
 drivers/dma/ae4dma/ae4dma_dmadev.c     | 673 +++++++++++++++++++++++++
 drivers/dma/ae4dma/ae4dma_hw_defs.h    | 151 ++++++
 drivers/dma/ae4dma/ae4dma_internal.h   | 114 +++++
 drivers/dma/ae4dma/meson.build         |  13 +
 drivers/dma/meson.build                |   1 +
 usertools/dpdk-devbind.py              |   5 +-
 12 files changed, 1053 insertions(+), 3 deletions(-)
 create mode 100644 doc/guides/dmadevs/ae4dma.rst
 create mode 100644 drivers/dma/ae4dma/ae4dma_dmadev.c
 create mode 100644 drivers/dma/ae4dma/ae4dma_hw_defs.h
 create mode 100644 drivers/dma/ae4dma/ae4dma_internal.h
 create mode 100644 drivers/dma/ae4dma/meson.build

-- 
2.34.1

