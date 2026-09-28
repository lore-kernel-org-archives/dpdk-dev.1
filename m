Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED4DC9833E
	for <dpdk-dev@archiver.kernel.org>; Mon, 28 Sep 2026 10:49:59 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E273140269;
	Mon, 28 Sep 2026 12:49:58 +0200 (CEST)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010006.outbound.protection.outlook.com [52.101.56.6])
 by mails.dpdk.org (Postfix) with ESMTP id A602C40041
 for <dev@dpdk.org>; Mon, 28 Sep 2026 12:49:57 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4pDJiCeVApSOo/JjYpUbwWXrUQsi6bL0ZTTaLbD9jbqtTKjoYN515BrhXqU1GFsZjGxJOUOROW06R3Kx7imZrfNWyRDq2/5YNDDp64hEaJ1K5f2VA8o2gbGd4OY5W5pj9ue7JuUTStZsVMz47yWguCw7JYr4nz5rT9xFaW3uVxYkPdhHHILBtUDAS2YpssYLdQq0+QFo5lTb0TOtwPIxBpr+BhcJRGXYwrXuvIErQVgPxn92WlLiNytexqZgHkP667qdGgYDQqgtYkGhZhVOYJAoEE7nlvIRx3VS18LCDtwNR4f2f8hXtJ/4a+i0mOHkp2zkM9Rn+AdzSu4plY72g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WCJ1XhGHkFLKgWiwsPOj28/QmZlEIIJdwuEEyeVS+qk=;
 b=EaIDmRQGFui2+cBYstD1h1+NZM4+/VLK95vKkBDqcrATks5kilik9TLMf1/ZoEMTzMirDzasnQyXTnQFv+Xzn3ksL71rh18G0yV1RX7dg9biOdiKSuWof9mu0/Mp6uMjg6wrtxfrldoPA3paMbQj4/Xx1MLjojXhpzor1RLZexpfVwzzMdhM0dQb8k6COz14x4QCnM5HUuTYOtz0k0EbZk1GI/nviTKDXPll2OrNQX/DrNuVzLd8dS1h02LaHRxUhtbrqRYfNh7X+uOiEFDD0kUw+RlfBR0simG95T9DiGWf69bljbo9LDB0Atsyxl57rTChcH/R9+1PrLeAAJ99+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WCJ1XhGHkFLKgWiwsPOj28/QmZlEIIJdwuEEyeVS+qk=;
 b=FRpLwdkdDUDE3W/UmBnwFb8fqRB78hH6UfJFXUzllthQIin9VDSgnWnOKzms2Ei5ajmyKg3XzONsNPq+9po2q2euygntUHZoW5GCO0CqfYGGd6ViHXLmhFDPg09Q/efP3evsz0Wyc1uvVmkptVCDWQYPu4hC6LZA4Kte5zyqjME=
Received: from MW4PR04CA0290.namprd04.prod.outlook.com (2603:10b6:303:89::25)
 by LV8PR12MB9667.namprd12.prod.outlook.com (2603:10b6:408:297::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Mon, 28 Sep
 2026 10:49:52 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:303:89:cafe::7a) by MW4PR04CA0290.outlook.office365.com
 (2603:10b6:303:89::25) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.451.24 via Frontend Transport; Mon,
 28 Sep 2026 10:49:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Mon, 28 Sep 2026 10:49:52 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Mon, 28 Sep
 2026 05:49:48 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <jingjing.wu@intel.com>, <thomas@monjalon.net>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>,
 <bruce.richardson@intel.com>, <david.marchand@redhat.com>,
 <sachin.saxena@oss.nxp.com>, <hemant.agrawal@nxp.com>, Raghavendra Ningoji
 <raghavendra.ningoji@amd.com>
Subject: [PATCH v2 0/2] raw/ntb: add AMD NTB support
Date: Mon, 28 Sep 2026 16:19:27 +0530
Message-ID: <20260928104929.2373409-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|LV8PR12MB9667:EE_
X-MS-Office365-Filtering-Correlation-Id: d7605456-1dcd-435f-4bcd-08df1d4e39f5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|1800799024|82310400026|23010399003|10067099003|3023799007|6133799003|11063799006|56012099006|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info: Ax4kCXK0pt5D2JaVk9X8AheC+K+lLbfrt3kRS9nTsY3hZN3F/U1XoEShPM41ObKEuSId8/9ZHFmk9j9GwmbEP+vZHCkquL2+AknCelJkiPAtwhJ052THiM/K68QDR7zxL/3V02eMGF5/dtacowQFuxLHbys5zzZ8F69X5i4M+eB7UqsIASTO+TWv14VxAFCWSKMrgED0ia+xdNGToAR4E8tTOQLwtAffPLdAbIDk49TrLo5Qzm6XNWwKtzNj8YWfKhCxTMfxBFVmI57Pqwi+KvQhyqT7nDmfEuFaY0rBuX/LPUg93OaCdduckRi7+h2Q+YCSFMqLgjCazIp9VFmmGf1aw+LBR3ViSkV2B2+ACVqecFv/H/jksl49LAe+xNFrdFVHoXgaj5oSf/Z0BRfbq7AFZNK49dTiiRzisiQ3gOzCgIca4+AUaKQr03F1cpFBU8tJDO3iSUSvyHhUoLRdQ+xlFSqZHuhpPhsI440aPV0/c8kIotziZUZCLPWQECvxNpTg3U5a4xhP+h2yRo6nNcC0o5Jjj6E3zvs+dHUJ3iNu3KOm1hOQBTUyWaeUVyybTT2/fyR9DeTCOW/bQ3AxYAokIUOnj0MLB2XkEx7Z+jWReyC8Zlt1QQscRSrdJVfNNhj9ayD4ZgCg9uX9+g1G3g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(23010399003)(10067099003)(3023799007)(6133799003)(11063799006)(56012099006)(18002099003)(13003099007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /PmjEHdBk+n8NOpNl0p0W9cWIlYzuqXGqoG72VxkJSkVGLcx9EiePC29L8+wcvvOnOBJBXOWqhh3MTtN7/8HzTXwnH7U46cl7ckLQWVbiJnN7vXPwT5mtDJW3Sol2jzMw+4kQ1JICkoHI1k+tKSlr46nx/fLWTuCS701VptwCuHjTiLyDfWQdtWAf5ce866oEzA9XkTItW7ZZIWkaW3RaCSEdf/4f1sCZ/dnsNYT562X06JkQ5YIJczLBskUXHxsQAQfLPDj8Ta1LX1fw0/lmrlc9C6e7CRZVREAoZOzvpD1sbTGJRUNNlRieH2QGWTbsTh2LW3A5VBU6e7DkxPfUUacrdSrdgW05PsTCRSepAbNqTOy8Rnr/PcX/jEzhOC0T1crOdbR+EfI+Ofxy2nqqH6pFHHQMJ0mw0/kSQBs6ESdEN1GI9HZP06UMd6CinBH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2026 10:49:52.5536 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d7605456-1dcd-435f-4bcd-08df1d4e39f5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9667
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
Patch 1 generalizes it so other vendors can reuse the common code, and
patch 2 adds the AMD hardware driver together with its documentation.

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
  with a set bit in the base. This is reported to applications through
  the new rte_pmd_ntb_get_mem_align() API and honoured by the ntb
  example when reserving the memory window memzone.

- Secondary-side link status. On the secondary side the device's own
  PCIe link status does not reflect the true inter-host link, so the
  speed and width are read from the upstream switch port via sysfs.

Tested on a two-node setup (primary + secondary EPYC Embedded hosts)
with the dpdk-ntb example: the link comes up at the expected speed and
width on both sides, and file transfers are byte-correct end to end for
both small and large files.

Changes since v1:

- Replaced the mw_addr_align field in struct ntb_dev_info with a
  mem_align op and the rte_pmd_ntb_get_mem_align() API, so the
  base-address alignment computation lives in the driver and the
  application just queries it. The ntb example no longer open-codes the
  power-of-two/alignment logic (Bruce Richardson's review of patch 2).

- Squashed the documentation, release note and MAINTAINERS update into
  the AMD driver patch, and documented the alignment API in the guide
  (2 patches instead of 3).

- Minor meson.build formatting cleanup (trailing comma).

- Patch 1 keeps the ntb_dev_ops hooks (interrupt_handler, dev_handshake,
  read_peer_config) as optional, with the built-in scratchpad path used
  when a hook is NULL, as discussed on the v1 thread.

v1: https://patches.dpdk.org/project/dpdk/patch/20260823140639.153997-1-raghavendra.ningoji@amd.com/

Raghavendra Ningoji (2):
  raw/ntb: generalize framework for multiple vendors
  raw/ntb: add AMD NTB support

 MAINTAINERS                            |   1 +
 doc/guides/rawdevs/ntb.rst             |  28 +-
 doc/guides/rel_notes/release_26_11.rst |   8 +
 drivers/raw/ntb/meson.build            |   7 +-
 drivers/raw/ntb/ntb.c                  | 122 +++--
 drivers/raw/ntb/ntb.h                  |  22 +
 drivers/raw/ntb/ntb_hw_amd.c           | 722 +++++++++++++++++++++++++
 drivers/raw/ntb/ntb_hw_amd.h           | 114 ++++
 drivers/raw/ntb/ntb_hw_intel.c         |  11 +
 drivers/raw/ntb/rte_pmd_ntb.h          |  26 +
 examples/ntb/ntb_fwd.c                 |   6 +-
 usertools/dpdk-devbind.py              |   4 +-
 12 files changed, 1033 insertions(+), 38 deletions(-)
 create mode 100644 drivers/raw/ntb/ntb_hw_amd.c
 create mode 100644 drivers/raw/ntb/ntb_hw_amd.h

-- 
2.34.1

