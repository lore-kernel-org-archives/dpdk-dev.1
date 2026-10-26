Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3701606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 08:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=s9B2A6BT
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id EF2F440151;
	Mon, 26 Oct 2026 09:55:44 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010037.outbound.protection.outlook.com [52.101.201.37])
 by mails.dpdk.org (Postfix) with ESMTPS id 3E9BC40150
 for <dev@dpdk.org>; Mon, 26 Oct 2026 09:55:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lhwKkSEvhmnMgSwzQMxbVO8g4gKNt6ll8f2WFpJqEymEQ9GqcUSLu/L8rpl5fRl/njcp1j12Hzmi47JigjMtHaBe6eE8Ofgg5uAA/wQVVPb5OrRbxqwpnpG/EiKy1nGx6J0UiUgniix8asxSQ3CZ6JbpR27TmI98Pzcf1wAu8gvaaltjWOWxaH0zbUsdnxnDcP191rHihZehqtsg6SbvcYjgcPjHST+Cr1ibKqKcHPkJWN2fNnqCoe8TKhbGaAxPzKJLUjJwseUmcM3e08YUdKFsqbGWjDoEig+H+GO8xedExJhjInZ+vmqXULFZMxpoADrNhBQHHyCGbKaK6KJevA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PI+edBUyqiL/LCYfuK+e0PkRRwB0zFQWFh9PBr0L+Fo=;
 b=VI77IRN3aPM+uAHit3pYbL/r/q/YSBfvCtUARI7i1sRO33+EhftjEJdkW531XaUw5dyT9n/MfJGddchse3fE1d8FF0mP/5MMJUuZCuE66q7B9W5NsoHOXm3hjNKA2FZL6WabwhXNGsOR0HnnWlKigIXeH3hhM0LVK60fHooILzVGQMsLqZ8puVhEw9tkDno9a9LJYKUW7cPhWOo+yTV/8ptg9ttmvPpb/FPkTRWlnTXYTR1xEdnIIp0lC9tqVZHJ/sAqSr0olpWEL9w7fZTWoFP/g5VXoaHLNXRUzwLwWHZE+3AGgrP5ahOyqlqLs0mrabSV3voSI2/KB9NVFtScmQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PI+edBUyqiL/LCYfuK+e0PkRRwB0zFQWFh9PBr0L+Fo=;
 b=s9B2A6BTru3ybK37/+sSS9UChiiAcwlFs2UMFacAJHJT2uMXxEi90ymxVP0Zp4kVetnysCATF0geMW5MxPMxQN5FLV9NV9HDN/s+sTG771wWUbexOg1a4Lbtkzb569yU+SLfCU9eGoLHZ4IEodGLhSFIao+qAC+7615B0C1yeHo=
Received: from SJ0PR05CA0036.namprd05.prod.outlook.com (2603:10b6:a03:33f::11)
 by DM4PR12MB7768.namprd12.prod.outlook.com (2603:10b6:8:102::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 08:55:37 +0000
Received: from CO1PEPF0001885D.namprd02.prod.outlook.com
 (2603:10b6:a03:33f:cafe::7e) by SJ0PR05CA0036.outlook.office365.com
 (2603:10b6:a03:33f::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.7 via Frontend Transport; Mon, 26
 Oct 2026 08:55:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF0001885D.mail.protection.outlook.com (10.167.249.246) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 08:55:35 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 26 Oct
 2026 03:55:32 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <jingjing.wu@intel.com>, <thomas@monjalon.net>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>,
 <bruce.richardson@intel.com>, <david.marchand@redhat.com>,
 <sachin.saxena@oss.nxp.com>, <hemant.agrawal@nxp.com>, Raghavendra Ningoji
 <raghavendra.ningoji@amd.com>
Subject: [PATCH v4 0/3] raw/ntb: add AMD NTB support
Date: Mon, 26 Oct 2026 14:25:12 +0530
Message-ID: <20261026085515.3238805-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF0001885D:EE_|DM4PR12MB7768:EE_
X-MS-Office365-Filtering-Correlation-Id: 6bd90189-ece7-42fe-4fcd-08df333ee6a5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|1800799024|376014|82310400026|261009223027099003|261021121427099003|261021123027099003|261022105027099003|10067099003|56012099006|3023799007|6133799003|18002099003|11063799006;
X-Microsoft-Antispam-Message-Info: beYbZXdvPDGeSvrj2c+Mzkn34koBaeJ1LKXNjpPkwMGrdB/WBeOTQCtxzydRhULdQAcTH4hjTgxAZ9/RmKluzqDpCU8LlB0k7RB1GwHJJfWAju+IHM/4t6e0GrgS8YTdhCGI4HO5qWkniuyLK3SgT7cPWwvrrb4Ivb9CIqDxopUE/fjwz6BAOKwAB6q8557Germ8K8t1ZVoju74RFkpFG5wYYz5mnw8zIjge8wxt43hbA60CwFpHAe8N3aw3yTcGVWDMzp1nbyt5XTbyoom/gE0SsnrKApguO+M+X/kH5V9PyElBjEVBAqHSYe72NIEN902QWl62i645VNBTi7rSkBA9G5d7asj8CP6gMly1Y0RhBH4BFmcYZvuj55s69Ig6wlXg8MsSGNUcMb9RhWOuKrwFugTgLVa7fU7PbgG4wzUM1RaSoLjoh/g+eGvpcfV0B2MUU4WGXlDMyCSVZr3NQ5wUmUK90WOLFHGAWk1AyPsEIdtWFVCoQbqDBySi1WORA3C9WUAkPgICAKXJ73Nei3x/9xT8RBJyLjiuXy4V2ejkpgthq+xiBiS5mDS7aY33+modsKWyaZmYVGtXjL6nYgQUdn+qJilejSCyIx5o03E6Ap13p79sqKEEk208keoS5Re3n2G/3aZNbm0D2aqCPVM/ewdGg94KkQJOKexXArG2inB2XLsYFREg1OreWGPPVtrshJXy74jR+KS+r7ri+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(1800799024)(376014)(82310400026)(261009223027099003)(261021121427099003)(261021123027099003)(261022105027099003)(10067099003)(56012099006)(3023799007)(6133799003)(18002099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mHRTDo9/bNpBwbf8QoTE2E5SH2r99JJZ6JWDOB/v107yTOJKHnTc1a2HvaTffI9h9Q6fQ/K+ZoRi3lnYtb6fTOvF055UgOclGyt1ijVdS0IDhVC5u1cJ8zltkEfXfADiMhQe6gp0w4pnvG+QTOtrmvuD4uQfZwA/uh/QJySHvzbUa7B7UMw6RtvapAmMe8CfJxOkMHR3cfiOG9FJTs53fNiq1YrFyMHwNqwXFbWlbPnLUMogeRJWltva41Sfiswtx3mM+aqj9IzTQPhorao2DSVMesPLhULdo8fCI4a/nuJs09kScs3adIzEO0u+/jO2ATlRtY7FhYIMpHdrkAGuuK6PTDLuvNTQFvH4B+jl2ZyCpf2RYinBCGlM9wTuolZypDKvIqaVsHe8vCV21iNR3dJJrL03fbUIVOsvZFcQRwrCNL6a5vOYHNQkM31w6ulw
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 08:55:35.9656 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6bd90189-ece7-42fe-4fcd-08df333ee6a5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF0001885D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB7768
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series adds support for the Non-Transparent Bridge (NTB) endpoints
integrated in AMD EPYC Embedded "Turin", "Genoa" and "Siena" processors
to the raw/ntb driver.

The common NTB code validates the vendor ops once at probe time, and the
vendor abstraction is built around a small set of mandatory ops instead
of optional hooks with built-in fallbacks:

- Patch 1 is a preparation commit that enforces the vendor ops once, at
  probe time, and removes the per-call NULL checks that are scattered
  throughout the common code.

- Patch 2 generalizes the framework for multiple vendors. The link
  bring-up/tear-down is now expressed through mandatory ops
  (dev_handshake, peer_mw_validate, read_peer_config, link_cleanup); the
  former built-in scratchpad logic moved into the Intel driver. The
  mw_set_trans op is gone (it is now a vendor-internal concern of the
  handshake), and there is a single common interrupt handler with just
  one optional op (handle_hw_event) for vendor-specific hardware events.

- Patch 3 adds the AMD hardware driver, its documentation, release note
  and MAINTAINERS entry.

A few AMD-specific hardware details worth noting for reviewers:

- Primary/secondary topology. One endpoint enumerates as the primary
  (device ID 0x14c0) and the other as the secondary (0x14c3), rather
  than the Intel back-to-back model.

- Packed scratchpad handshake. The hardware exposes a single shared
  16-register scratchpad bank split into two disjoint 8-register sets
  (one per side), so the driver uses a packed handshake layout that
  fits in 8 registers, plugged in through the dev_handshake,
  peer_mw_validate and read_peer_config ops.

- Outbound translation window. AMD NTB uses an outbound translation
  window: a write to a BARxx memory-window offset is forwarded to
  (xlat_base | offset) in the peer's memory rather than
  (xlat_base + offset). The translation base must therefore be aligned
  to a power of two >= the window length so that no offset bit collides
  with a set bit in the base. This is reported to applications through
  the rte_pmd_ntb_get_mem_align() API and honoured by the ntb example
  when reserving the memory window memzone.

- Secondary-side link status. On the secondary side the device's own
  PCIe link status does not reflect the true inter-host link, so the
  speed and width are read from the upstream switch port via sysfs.

Tested on a two-node setup (primary + secondary EPYC Embedded hosts)
with the dpdk-ntb example: the link comes up at the expected speed and
width on both sides, and file transfers are byte-correct end to end for
both small and large files.

Changes since v3:

- Simplified the probe-time vendor ops check (patch 1) to a plain
  per-member macro instead of an offsetof() table.

- Removed the mw_size_align field from struct ntb_dev_info entirely
  (patch 2): applications must now use rte_pmd_ntb_get_mem_align(). This
  is documented in the API changes section of the release notes.

- Removed the unused pmd_private field from struct ntb_hw and the whole
  struct amd_ntb_hw (patch 3): self_mmio is just ntb->hw_addr, peer_mmio
  becomes AMD_PEER_MMIO(ntb), the scratchpad offsets become an
  AMD_SPAD_BASE(ntb, peer) macro, and int_mask/peer_status/ctl_status
  were unused.

- Sorted AMD alphabetically before Intel in meson.build, the ntb_hw
  header include, the PCI id mapping table and usertools/dpdk-devbind.py.

- Moved the primary/secondary topology definitions (NTB_TOPO_PRI/SEC)
  from patch 2 to patch 3 where they are first used.

- Updated the Limitation section of doc/guides/rawdevs/ntb.rst to list
  the supported AMD processors.

Changes since v2:

- The series is freshly rebased on main; the release note and
  dpdk-devbind.py now apply cleanly and CI should pass.

- New preparation patch (patch 1): the vendor ops are validated once at
  probe time and all the runtime ntb_ops NULL checks in the common code
  are removed.

- Reworked the vendor abstraction (patch 2): dev_handshake,
  peer_mw_validate, read_peer_config and link_cleanup are now mandatory
  ops provided by both the Intel and AMD drivers. The built-in
  scratchpad handshake/validate/cleanup/peer-config logic that used to
  live in the common code moved into the Intel driver.

- Dropped the mw_set_trans op: it is now a vendor-internal detail of the
  handshake.

- Dropped the vendor interrupt_handler op: there is now a single common
  interrupt handler, with handle_hw_event as the only optional op, used
  by AMD for its SMU/power-management events.

Changes since v1:

- Replaced the mw_addr_align field in struct ntb_dev_info with a
  mem_align op and the rte_pmd_ntb_get_mem_align() API, so the
  base-address alignment computation lives in the driver and the
  application just queries it (Bruce Richardson's review).

- Squashed the documentation, release note and MAINTAINERS update into
  the AMD driver patch, and documented the alignment API in the guide.

Raghavendra Ningoji (3):
  raw/ntb: validate vendor ops at probe
  raw/ntb: generalize framework for multiple vendors
  raw/ntb: add AMD NTB support

 MAINTAINERS                            |   2 +
 doc/guides/rawdevs/ntb.rst             |  31 +-
 doc/guides/rel_notes/release_26_11.rst |  13 +
 drivers/raw/ntb/meson.build            |   7 +-
 drivers/raw/ntb/ntb.c                  | 310 ++++--------
 drivers/raw/ntb/ntb.h                  |  24 +-
 drivers/raw/ntb/ntb_hw_amd.c           | 658 +++++++++++++++++++++++++
 drivers/raw/ntb/ntb_hw_amd.h           | 111 +++++
 drivers/raw/ntb/ntb_hw_intel.c         | 165 ++++++-
 drivers/raw/ntb/rte_pmd_ntb.h          |  28 +-
 examples/ntb/ntb_fwd.c                 |   6 +-
 usertools/dpdk-devbind.py              |   1 +
 12 files changed, 1124 insertions(+), 232 deletions(-)
 create mode 100644 drivers/raw/ntb/ntb_hw_amd.c
 create mode 100644 drivers/raw/ntb/ntb_hw_amd.h

-- 
2.34.1

