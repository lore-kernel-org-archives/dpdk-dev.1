Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FF6CCF2DB
	for <dpdk-dev@archiver.kernel.org>; Mon, 19 Oct 2026 06:39:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id ED4E44028E;
	Mon, 19 Oct 2026 08:39:13 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013049.outbound.protection.outlook.com
 [40.93.196.49]) by mails.dpdk.org (Postfix) with ESMTP id 94DAB402B6
 for <dev@dpdk.org>; Mon, 19 Oct 2026 08:39:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=E5N+ON5+aoSJzxZ7d45qGnWBSB/IPHz06Aag7LiQVtt/uJc9zunnyw+MJ5hb7RHoK5CcbDTNGGX/6kTtZmrySighszeH0hrCHBIfk65UEiDoVKTD4rjaqEA9KPrAEkj8Zti87zaUaXwBXexOTytPirz6PCUkbfcn/eI/a86KK5FPHI4Fve+1sPZ7UXf6K0HLMVl2W2tGPFPLDNEspMP8aMZZvtQQz+9qfMYmq3dx5qVgHatiXm+8HDk76bOOHGLlQcsHK8e0Z3bgmNTJDcPj7vp50ZYPnOd4EW8e/SMdxIsdbXIKPFmD6LP2OPEaIlCGLhOD2ffEuJMOX/bSO69tLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cfbdQ7LQlJL5hUerNrFMGXDqjAJU392X+oLhqVJ/CrY=;
 b=mxpXxs2Fd4op0+PjhzYAsIl1J8V0lveQ0z05HECRQHytKc2+hDOg8JWV6G7bnl/QzePNj5D73rro3Nc1a4YC8rYry2TCK8e1MbAI9uCzCXqhV7mHaZPjiW1EEHJOV+cRMZSc5YMiO01fnVtMC0pm3t6v7DbQOUfJtYmM8Oqv1Bu1R7RVCU2XNiiaUD8tofFyv9pZhdQFaqay2JxYjS2YZri8OIiB2LCoTp/hzcxYGVeluMtAAG/7WJDe4szPH0bk85w2WeJjGGPwr4Rp15rpXKlmMGG/uz2QKtlajcZqz2HTGCXEhUk2EDhxK0dDjccuBtvLbQGaNCVbGfiHyy7zAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cfbdQ7LQlJL5hUerNrFMGXDqjAJU392X+oLhqVJ/CrY=;
 b=Zw2C5cPOfWe15CA1i28mhYj6VG9Ga45Oj/Ma0xXSMZ7kn1Olfhr28jAxQhiJL8alcnSYWnjBDAlljPnqsvqZwjle4JWEj6UveI0O6HMZbYTqdPFkno6EGeST3aygHm514nQC6xo2zc+8HZvjKWjGVsEE1BNrYA4tY3Aq0l/fiJs=
Received: from CH0PR03CA0063.namprd03.prod.outlook.com (2603:10b6:610:cc::8)
 by SA5PPFB29794CA1.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8dd) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.19; Mon, 19 Oct
 2026 06:39:07 +0000
Received: from BL6PEPF0006C3DC.namprd02.prod.outlook.com
 (2603:10b6:610:cc:cafe::25) by CH0PR03CA0063.outlook.office365.com
 (2603:10b6:610:cc::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.19 via Frontend Transport; Mon,
 19 Oct 2026 06:39:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0006C3DC.mail.protection.outlook.com (10.167.249.230) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 19 Oct 2026 06:39:06 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Mon, 19 Oct
 2026 01:38:56 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <jingjing.wu@intel.com>, <thomas@monjalon.net>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>,
 <bruce.richardson@intel.com>, <david.marchand@redhat.com>,
 <sachin.saxena@oss.nxp.com>, <hemant.agrawal@nxp.com>, Raghavendra Ningoji
 <raghavendra.ningoji@amd.com>
Subject: [PATCH v3 0/3] raw/ntb: add AMD NTB support
Date: Mon, 19 Oct 2026 12:08:20 +0530
Message-ID: <20261019063823.2831572-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0006C3DC:EE_|SA5PPFB29794CA1:EE_
X-MS-Office365-Filtering-Correlation-Id: a3599028-bd2f-4f67-a1a7-08df2dabac7f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|376014|36860700016|1800799024|6133799003|18002099003|10067099003|3023799007|261009223027099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: SvvnGgDa3DVerVEbnyQYLCpotYQKzKEzpS6ps7F/J19Mdb2t5Zl9fj1+XZ/awSm4+6q7nOw+dDArSWSgoP+acbhXnAHL5pPCilH0+yzDIc0YlG+vOdPNvZQURT6pAq7y4iPfVkVQcsTD0WONF4h4iIfCWOWvgbiDwBCSmvwK4otwey/2s2EE+sInZ5fv1Nm2CoF8sd8KMSBTe4zm1u7s4lxFzg3/mPWX1oY4XdEKgdyM0RbtopC3QF99Ambzff/Ctrz8iiB6b1hFsux9MxnmDEcBEvYbEcw8NI57gOCEDDZgh2US6Co0Hbg7nI56gu6K6bd/Wg2n0+LMQOClVyF7EBCXAguEyNp/TWltVLz5o4sJhQCXt5ZvF3FSMpie6UulfnVtzYxq9KjLS1M87ktL/S4OH9NI+6fsYfRhiE9MyQabiKaZIyXGT0mrctVeLq/VSMqdZbfMKgihOQfKShcOz4j3L3Ef+1qeAbpk40txug2nP+CUAowQG/vmOWGpTguD5IOfWcstILJSsCVLpmbdKm+FddZBu287WiqUwJlZzSzblxQ2P3Md3vZwNS0wjJ6FNilvWB2MlVw4j6pbXtB0KabqAvHHcEHBIKbOprRaeCszLFWJoYX8n/QHQ6lLSR5yvc2lG3IeR06oWYkk2JKEnA1lglX9B+mllkNcpOLb3Eh+aOX4sEYss2dyKmYHWjQbr/EgSIMYYgY9ljRlcDMYZg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(376014)(36860700016)(1800799024)(6133799003)(18002099003)(10067099003)(3023799007)(261009223027099003)(11063799006)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: NPegKkvDUDHQfWC2LCe+JJbDJjJEgtxjP1+diI4MozRX0d/FCZJuAVqN6dDo2MhUytaQvpqtVBsr42vnq3AmST35FTC0FfZrWBATIuOPA48DNtLRPD3/A2cGhser8HRT9d9Z6HYOZsMjVXZjJkr5oae1CwapEfLrCmRa1COa01Yir3WZ8asPGlnjQbl62aZMgimmmVyLEPns3p2mIi0y4ih0jqVXmjC7Wocx1yLKRe4BGN7CT0x+Y6vDnJqDfxwPN0jrnFat96iIjZp9ScK9r6fc59wH3PYsBYmAibwNC/1BsG0e3z2145ycnBy/sRsURbHkfPG9kI62GkWl42QiVlazKS5rA1hqU5OO0bRXS2jxbuaSRfyo4KmZ6Er001UXul32LHjTlLXZ0pHedaEph6rUHs8rNsIaecc+kcGcsyXKBvk5/0Z8+jFf1bISbnOH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Oct 2026 06:39:06.6168 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a3599028-bd2f-4f67-a1a7-08df2dabac7f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0006C3DC.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPFB29794CA1
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

Following David Marchand's review of v2, the common NTB code has been
reworked so that it no longer relies on runtime checks of the vendor ops
presence, and the vendor abstraction has been redesigned around a small
set of mandatory ops instead of optional hooks with built-in fallbacks:

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

Changes since v2:

- The series is freshly rebased on main (26.11-rc0); the release note
  and dpdk-devbind.py now apply cleanly and CI should pass.

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
 doc/guides/rawdevs/ntb.rst             |  28 +-
 doc/guides/rel_notes/release_26_11.rst |   8 +
 drivers/raw/ntb/meson.build            |   7 +-
 drivers/raw/ntb/ntb.c                  | 316 ++++-------
 drivers/raw/ntb/ntb.h                  |  27 +-
 drivers/raw/ntb/ntb_hw_amd.c           | 691 +++++++++++++++++++++++++
 drivers/raw/ntb/ntb_hw_amd.h           | 114 ++++
 drivers/raw/ntb/ntb_hw_intel.c         | 165 +++++-
 drivers/raw/ntb/rte_pmd_ntb.h          |  26 +
 examples/ntb/ntb_fwd.c                 |   6 +-
 usertools/dpdk-devbind.py              |   1 +
 12 files changed, 1169 insertions(+), 222 deletions(-)
 create mode 100644 drivers/raw/ntb/ntb_hw_amd.c
 create mode 100644 drivers/raw/ntb/ntb_hw_amd.h

-- 
2.34.1

