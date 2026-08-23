Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50166C5DF8C
	for <dpdk-dev@archiver.kernel.org>; Sun, 23 Aug 2026 14:07:33 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6D35B402E1;
	Sun, 23 Aug 2026 16:07:27 +0200 (CEST)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012032.outbound.protection.outlook.com [52.101.53.32])
 by mails.dpdk.org (Postfix) with ESMTP id D67C3402C3
 for <dev@dpdk.org>; Sun, 23 Aug 2026 16:07:24 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Xp5zOyk2RZdWTuq6/tITWtgJqPX9C9vnBcExA1KIjnxLHp2uSkn2SkZm9usYUztER3B+BElhgy+O0nQrc6I5k7sVlUBd92qOOxs70QM4mbjjGpv8uTr0biC3vUB20wK+liWLVK+tFBO6BbJPATfsKrRJYJVDHRnvtotud/O/Rpln6nFujmZkdF419RcUBmCkTRfdbKV6vhE84B5MC5XeXfkusRn/tC9iFWSPA2tIpR3aBOsDbftn8/cKIzRRZqaSSvdKAEYst2eWYWG2QgadylSfU/oUUrk5kLhI8vubetR3gLVn/JFveiUFu3sxSUiICNz62p5LWVuw8wrmDwbqlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s5OKDvKLVxR+XZEHJb4h/jCHWbTilQa03WFCgVhOwc4=;
 b=v6pHI2cQD2u9zbifJwY1KToIpTts44VCrgpSiv8aDha4+7sET5Sjk752qfk9rxDXotWXf+Z7h0Sp0a66iWRMsawMWTi7t+TnLziBO8ROSzksfh9y9tZO3C5qjOaP141UF6MyB11EWRJjU3VUMH3CwdA5I2s5vO5X6x+pd4STYqRT6iSkBOlNMxam/JyiocjiWIvXJ+7fc5ZecVlQBWxnWp0fK33xEFOMLYS7+UgyybPj1CSLBCv+8xLX9BPnScC4fygknp2dtme+Y1kauVvabckB7Mpo4AB24saghTGI9M2NMbhtLZ4Z2Lsuby2JYcHVUv8fLWZQBdvQRfzQ1hEAfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s5OKDvKLVxR+XZEHJb4h/jCHWbTilQa03WFCgVhOwc4=;
 b=3DqeffQM+I3DM1JcpcnHTvpbkCXz4fKFg0Ff06s5JXmnhq5/tP+iTlXh0QIiOFoQN+w2a3XgbDivrW7/a9abrMtGIXU5+P+FRL5J9G67wLAKrx4tfO+eDyIaqD3V5uoe3IkGMsJ7o3DFP9NEmagIbVzc28IOtKFzU0VvdR9KKwY=
Received: from SJ0PR03CA0254.namprd03.prod.outlook.com (2603:10b6:a03:3a0::19)
 by DS0PR12MB8295.namprd12.prod.outlook.com (2603:10b6:8:f6::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.12; Sun, 23 Aug
 2026 14:07:21 +0000
Received: from CO1PEPF000075F1.namprd03.prod.outlook.com
 (2603:10b6:a03:3a0:cafe::1) by SJ0PR03CA0254.outlook.office365.com
 (2603:10b6:a03:3a0::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.12 via Frontend Transport; Sun,
 23 Aug 2026 14:07:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CO1PEPF000075F1.mail.protection.outlook.com (10.167.249.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Sun, 23 Aug 2026 14:07:21 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Sun, 23 Aug
 2026 09:07:18 -0500
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <jingjing.wu@intel.com>, <rjarry@redhat.com>, <thomas@monjalon.net>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>, Raghavendra Ningoji
 <raghavendra.ningoji@amd.com>
Subject: [PATCH v1 3/3] doc: add AMD NTB support
Date: Sun, 23 Aug 2026 19:36:39 +0530
Message-ID: <20260823140639.153997-4-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260823140639.153997-1-raghavendra.ningoji@amd.com>
References: <20260823140639.153997-1-raghavendra.ningoji@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000075F1:EE_|DS0PR12MB8295:EE_
X-MS-Office365-Filtering-Correlation-Id: 26b958ee-bfa0-49d4-666e-08df011fd965
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|36860700016|376014|56012099006|10067099003|6133799003|3023799007|22082099003|11063799006|18002099003;
X-Microsoft-Antispam-Message-Info: sHehtYQa3iWoVlsDO+glJPsi5suUYaxpmzhOp1EVYc2x8mK/amygAiBn2nYBcCQ2EYz7Frvg/o0/J6F9MiRVwVE17UW26PsnhQ6ZrA70Qlu27i9aEbtOPU0vgUCj8yMcNLCeRKY8n2QnHFEtpofKct16y7bVhjIb4cxEoR7vnxCrQ3dUrDyeeE7IA3QVPHrpmRlXi1tGf8ZGK3+ru5Fx67M5nvfQPCMCNhl0B4+bL4lHnqXKoCVA1GWKxAwikZpaSiyTIpfZ0o6x6mu44mfC9sAEGW9kc5V4npN5v65E7j5+21UiU2cOqeTObK/p+Oj/5V+wtqBEtwc1KS/+sFnyYcnaioplaZ0wSNHaolO8FccSldBAJ3qX/MqRWHJUGgZv2KZfGE3Kyk/Yj1V/BCMeHTTFJtXb7+Dgd3+viiHb5XIIwIymauIVt7nXbaV8XQZrO3oGMs4tYUJYigl2XeOXxuM/WWye68vWYgdeSJaE6hsvLiRpsKOyrMtZX/l1F2UX+O+NPMPy/q0LFXOfwYa9dFnZyajXGWfct+ijQRSltmhOtZFcw4WdEvImpfAmtdGE+OFuADpzrrNPQ5bUqTshHYtS0HXcVyvmLurLsHEl1S57OgnkaRIQMbcWaNhsrZVUzQ/A8t47U8erm00lr9JzWBZsbH+0dwLPln4UfKF5O0t9yOS6H86EBvdzkQVhWYQUfRQRYF/NApLjiA14+cTpPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(36860700016)(376014)(56012099006)(10067099003)(6133799003)(3023799007)(22082099003)(11063799006)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TfcPc8PYVAIpDxRduq+N9yNVZuf7xkGULcAjcOKPQ+m+tbQtq+G32whCM1+6w5aWI2KUqsyQYMcC3+0xPk2BBoAHmW2KOUD+mDpy5GXJkC6fa47K2QTox3aYtP2+GE6xI20X86Sebm7qLrcNYbm6pU7tPbnmB+iQrlIl0tYhEPevTFBsKImt+xDMdrI9ZDqGcfsdfguFF8wwm1/xL4AQ5l1EYB9vPTP+BFieksEiWa4DsXz5XNQ2ICpWAmqHGSiaj4k1fQBFxoftoiephvc+ORmCHiJ1tmBDj3Br2s5ElrDkgcY90zac7/gn3k78ZY7S0E6jocfIGBrxTsEuG2uai8RnDHF49i5MxNo8XBOdhhWadcrBUcpin7+kCWnMtcyELFOe2aDJfwKNtPCABoS8rqkv6JOe7DmSEclYlyLgR3QvOqSfrmxDnH+Iuv6NcBrP
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2026 14:07:21.1957 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 26b958ee-bfa0-49d4-666e-08df011fd965
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1PEPF000075F1.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8295
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

Document AMD EPYC Embedded NTB support in the raw/ntb guide, add a
release note entry, and claim maintainership of the AMD NTB support.

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 MAINTAINERS                            |  1 +
 doc/guides/rawdevs/ntb.rst             | 18 +++++++++++++++++-
 doc/guides/rel_notes/release_26_11.rst |  8 ++++++++
 3 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e99a65d197..13306345fd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1613,6 +1613,7 @@ F: doc/guides/rawdevs/cnxk_rvu_lf.rst
 
 NTB
 M: Jingjing Wu <jingjing.wu@intel.com>
+M: Bhagyada Modali <bhagyada.modali@amd.com>
 F: drivers/raw/ntb/
 F: doc/guides/rawdevs/ntb.rst
 F: examples/ntb/
diff --git a/doc/guides/rawdevs/ntb.rst b/doc/guides/rawdevs/ntb.rst
index 3721b4880e..c89eaccac8 100644
--- a/doc/guides/rawdevs/ntb.rst
+++ b/doc/guides/rawdevs/ntb.rst
@@ -37,10 +37,26 @@ then reboot.
 - Set ``PCIe PLL SSC (Spread Spectrum Clocking)`` as ``Disabled``, on both hosts.
   This is a hardware requirement when using Re-timer Cards.
 
+AMD EPYC Embedded NTB
+---------------------
+
+The driver also supports the NTB endpoints integrated in AMD EPYC Embedded
+"Turin", "Genoa" and "Siena" processors. These use a primary/secondary
+topology rather than the Intel back-to-back topology: one endpoint is
+enumerated as the primary (device ID ``0x14c0``) and the other as the
+secondary (device ID ``0x14c3``). The BIOS on both systems performs NTB link
+training; no additional NTB-specific BIOS options are required beyond enabling
+the NTB endpoints.
+
+The AMD NTB hardware exposes two memory windows (BAR23 and BAR45), 16
+doorbells and a single shared 16-register scratchpad bank. The scratchpad
+bank is split into two disjoint 8-register sets, one owned by each side, so
+the driver uses a packed handshake layout that fits within 8 registers.
+
 Device Setup
 ------------
 
-The Intel NTB devices need to be bound to a DPDK-supported kernel driver
+The NTB devices need to be bound to a DPDK-supported kernel driver
 to use, i.e. igb_uio, vfio. The ``dpdk-devbind.py`` script can be used to
 show devices status and to bind them to a suitable kernel driver. They will
 appear under the category of "Misc (rawdev) devices".
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index c8cc86295d..0b364ccbd4 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -55,6 +55,14 @@ New Features
      Also, make sure to start the actual text at the margin.
      =======================================================
 
+* **Added AMD NTB support to the NTB rawdev driver.**
+
+  Added support for the NTB endpoints integrated in AMD EPYC Embedded
+  "Turin", "Genoa" and "Siena" processors to the ``raw/ntb`` driver.
+  The NTB rawdev framework was generalized to support multiple vendors,
+  with AMD-specific hardware access, a primary/secondary topology and a
+  packed scratchpad handshake.
+
 
 Removed Items
 -------------
-- 
2.34.1

