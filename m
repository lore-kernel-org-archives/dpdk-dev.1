Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BEAFC5DF97
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Aug 2026 14:07:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E7FE740270;
	Sun, 23 Aug 2026 16:07:13 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012010.outbound.protection.outlook.com [52.101.53.10])
 by mails.dpdk.org (Postfix) with ESMTP id 0C7B440265
 for <dev@dpdk.org>; Sun, 23 Aug 2026 16:07:10 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QLHLgcqPe76PeIZLC1c6h55nFFlcsgjjXQ//owV3lXBUsT1+B/psWxwtNfdCzoof6ZpV99utJOmJwnhn/OdWHVaPxyoc/Z7BjYzAGCm7zHYV71mVNWuTm48HQp8IHb7a7cFdfP4sjdAG1EnWp8jZoClF9NHtiTHDeKteSb8n9cimGdWy7aT+egIETp7oeHjL28c4tNbLHh2xu/vQ72sgugBRpMBVZADtl9VgjiABz3kf+Ro48Atgo8yChKjwS3S/5zeUr8XDkBBmYqQY4hUF0AGtAD080wTg+OsD2MA2N3nnrFU2+9JfwXS2ppa1Z3MNmArNXQ5euz8o95zfkhF1MQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yYNFM3JkU35YWR/dunrTN7qjS6Q2inxRlF5MlCkg1Ec=;
 b=vampwwwUCHVrWIeo8OtaqDdfPSWu7DJFtoqDJL44oUyEaYu5SwJ61nUIMFgEAX+AzcEWavjK+drEdPmhdNXlGHni/1JWad08Zq4/AHg6bUHqG5P9cbOdpDqhJfoFEwycGNM1PJpdO7yKwz5zwRCdpjNH5zVmDoZQkvi0koj/d5LkzHhLzcmpo5WweeugpGjMSC+Wnx8aMJCGvNgUk1sW1r12Vb4M90g8UPPhX9eKwafGF8Z2hlKhPscPP8+St+gAwhXAtexwy6KdaWp17bQ3dymT/6AOZ1sV9bvwqqH2xhebTT+xH7msUZjZNjqlsILNAcVH8uMUMGQUH4w6FFqVFg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yYNFM3JkU35YWR/dunrTN7qjS6Q2inxRlF5MlCkg1Ec=;
 b=EmV6MeLBxvJWDI/URMeadrXT21/ARHxJMq65/EwmLIrlyGgB1k8lelnEYt+EWRkdgso0ug+KFjHwwfI1baTHwVbapTBkw+pjyYaiar9LH8Twrmwjz0TqWTfg0utZ8tUMkbJmEZXO4cgwfKMvZvPmppoH00ykT08r+gtDCa2bb68=
Received: from MW4PR03CA0095.namprd03.prod.outlook.com (2603:10b6:303:b7::10)
 by CH8PR12MB9741.namprd12.prod.outlook.com (2603:10b6:610:27a::21)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 23 Aug
 2026 14:07:06 +0000
Received: from CO1PEPF000075EE.namprd03.prod.outlook.com
 (2603:10b6:303:b7:cafe::2d) by MW4PR03CA0095.outlook.office365.com
 (2603:10b6:303:b7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Sun,
 23 Aug 2026 14:07:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075EE.mail.protection.outlook.com (10.167.249.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Sun, 23 Aug 2026 14:07:05 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 23 Aug
 2026 09:07:03 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <jingjing.wu@intel.com>, <rjarry@redhat.com>, <thomas@monjalon.net>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>, Raghavendra Ningoji
 <raghavendra.ningoji@amd.com>
Subject: [PATCH v1 0/3] raw/ntb: add AMD NTB support
Date: Sun, 23 Aug 2026 19:36:36 +0530
Message-ID: <20260823140639.153997-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075EE:EE_|CH8PR12MB9741:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d97f2be-0b7c-4576-02ed-08df011fd03b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|1800799024|376014|82310400026|23010399003|11063799006|56012099006|10067099003|3023799007|6133799003|18002099003;
X-Microsoft-Antispam-Message-Info: iAGuihDD78x5JssrEz3IOrx/P7o05TDP1krrcOLoL79y4vkpEx1MT4HxWxUs2HhZcKtMP/6nEQeKnQQY0Ib+wivvB4AacPz5qOOIHB3vyfw0wR30bFrXQNm+FlyaT6UC1KbEaGUO3MaZfL6mv3gGa7V2Cgs8wSvW8jswbrr6lOXqDIxeqiE6MC+wLGlpi4ybV+QKCdeS12awxoOKYuxXqcBcSb6wMBiktT5WXo7cVILI+z5JrZeKPWRZ6wehBK/cyLIq5HvD3p7OkJekz5SY/0nmfhlcwM3A1/S0kzlOv7vQy3N1YNFasYnKT/BCuGVNpJ/MzFZHETZcCCAVJyYaADu9Zu2RzOjTUqhkAAdg5Ecvv7WjRXBMEUsfFemwsAO0sas31aDcUAehWRMI/zaVB8dOJUJ3FKlB7sqwAquoVeIVe4TQQkE3GACPhdesm536JcWvTElMDZnr8eMCFMSYMizdR4AnS0XNZwLtL0IiTNQf9idkWTAln02t1aqolypZgBgE7y+vEn57FI8rk5eJVzYir5ToIOU9M0fdbNxf6T6dqNp5mTyJzgwam/SCQodkz0QM38yBBrzZ+y5D+IwUr8FGZQKMAApNiSIl4dUVCehwIN1ySkHIVaeNzO0Pey3YFCcvsaFTLxz3Et04xCsG28vMYJ6a2iQqtSpwuwJDUUkjqpz8thkVMzz3SytpJFqD1RRcjlt09g3VN2rmmXjJNA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(1800799024)(376014)(82310400026)(23010399003)(11063799006)(56012099006)(10067099003)(3023799007)(6133799003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: EvGOBkWJeubPxZnGJRUoefBwCT/ngJuy8O6Cj/AP3ZDjR/YgSDrR0XsvwkepsoY2mTpImSRO43RTB1dbk72Bhe86gQRXiPsDzKLlC+MRPw7md28ENQKlb6ZFRvXcVjiyyyBPvyYh0LD3Bl/tclOCBi8AUDRi+ljt0QdG6Xmk+KRsUnpHYMydopQZXHPonOBKt5jY8mdub5bG49uj2/89k2HezSFYAL79qm8JWETFVJAqjiQYyCHlu09kZP79x3m/WdNEDndt86CWfp5nn9J+ZbLLOC8cN44gNecp3NpB0ViIrjKJMLCopK6tTeA6DO9exiC7WLKhBDfZMbFB03W13O9UzsHgU8rb0pwySJCMEGPV6X0wVKUYI1IROKqz/NLjslbj9K0DNCljRM4sUBzAdutF/vx1Q9vYCXasFPocrotxdhXWwy69WdtygNlDXsK4
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 14:07:05.8194 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d97f2be-0b7c-4576-02ed-08df011fd03b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075EE.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB9741
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

This series adds support for the Non-Transparent Bridge (NTB) endpoints
integrated in AMD EPYC Embedded "Turin", "Genoa" and "Siena" processors
to the raw/ntb driver.

The NTB rawdev framework was originally written around the Intel
back-to-back topology and the built-in scratchpad handshake protocol.
Patch 1 generalizes it with a few vendor-neutral hooks so other vendors
can reuse the common code; the Intel driver is unaffected since the new
hooks fall back to the built-in paths when NULL. Patch 2 adds the AMD
hardware driver, and patch 3 documents the new support.

A few AMD-specific hardware details worth noting for reviewers:

- Primary/secondary topology. One endpoint enumerates as the primary
  (device ID 0x14c0) and the other as the secondary (0x14c3), rather
  than the Intel back-to-back model.

- Packed scratchpad handshake. The hardware exposes a single shared
  16-register scratchpad bank split into two disjoint 8-register sets
  (one per side), so the driver uses a packed handshake layout that
  fits in 8 registers, plugged in through the dev_handshake and
  read_peer_config hooks.

- Outbound translation window. AMD NTB uses an outbound translation
  window: a write to a BARxx memory-window offset is forwarded to
  (xlat_base | offset) in the peer's memory rather than
  (xlat_base + offset). The translation base must therefore be aligned
  to a power of two >= the window length so that no offset bit collides
  with a set bit in the base. This is reported to applications through a
  new mw_addr_align field in struct ntb_dev_info and honoured by the ntb
  example when reserving the memory window memzone.

- Secondary-side link status. On the secondary side the device's own
  PCIe link status does not reflect the true inter-host link, so the
  speed and width are read from the upstream switch port via sysfs.

Tested on a two-node setup (primary + secondary EPYC Embedded hosts)
with the dpdk-ntb example: the link comes up at the expected speed and
width on both sides, and file transfers are byte-correct end to end for
both small and large files.

Raghavendra Ningoji (3):
  raw/ntb: generalize framework for multiple vendors
  raw/ntb: add AMD NTB support
  doc: add AMD NTB support

 MAINTAINERS                            |   1 +
 doc/guides/rawdevs/ntb.rst             |  18 +-
 doc/guides/rel_notes/release_26_11.rst |   8 +
 drivers/raw/ntb/meson.build            |   3 +-
 drivers/raw/ntb/ntb.c                  | 115 ++--
 drivers/raw/ntb/ntb.h                  |  18 +
 drivers/raw/ntb/ntb_hw_amd.c           | 709 +++++++++++++++++++++++++
 drivers/raw/ntb/ntb_hw_amd.h           | 114 ++++
 drivers/raw/ntb/rte_pmd_ntb.h          |  10 +
 examples/ntb/ntb_fwd.c                 |  22 +-
 usertools/dpdk-devbind.py              |   4 +-
 11 files changed, 985 insertions(+), 37 deletions(-)
 create mode 100644 drivers/raw/ntb/ntb_hw_amd.c
 create mode 100644 drivers/raw/ntb/ntb_hw_amd.h

-- 
2.34.1

