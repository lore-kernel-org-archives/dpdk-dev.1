Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98544606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 07:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=bFFxi6VW
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8E07040DD8;
	Wed, 11 Nov 2026 08:11:13 +0100 (CET)
Received: from PH8PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11012068.outbound.protection.outlook.com [40.107.209.68])
 by mails.dpdk.org (Postfix) with ESMTPS id 4B35A4026D
 for <dev@dpdk.org>; Wed, 11 Nov 2026 08:11:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XsNDPtoE62TSpJoJXxwIhsj3ENdKPNmimlgm8e0SCTDGvrBAV1SaZy+wb0Bp4RfMmW6fG6959YXmHOElhKiPTtWz8oahTvCOA45vsPxVwYL7OM0qWrZLX08unG3VXqYg+7rTAkwHVMtEt0pRysCW+CT5JH6exCSBI9xJXoIzNYb2KdA889760kn0hAJWhqeXZ0hXZiDPeZfrj60sihnzk1J+sBxm3/DzysVcJofN7YXWXrJqP506cPaLmu8IHBWad5VmtbtTd9+3RawMGBmcmXSQTyR01lTk84NBQN3dYwflXTI6ELBZtbbk9xeEBSPC7RO+FE5rvlvDFub8aRBQYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IiF2HJQPcVviKIlixTpBh3Kp6CW/KBCChx0TrOXYgqw=;
 b=U25cEoy4c2aOFtqbCeQSt0mW8PK/xu06e/uRU0uayKdiQp146M0pwbLc9jb3Z2hpy568bePE4dxEuiJF+4oUhObCfK+ik5blXcWND441ILVcP1E4DViBS66lO03zB3KWAnEq8Hw9cTJcv7glrEJOLUlbuHFd25n0HjDn4w0Topq3hS8lstVDB0Z4x4axogvmUZ8EukJRKAdX5jK8/5Y5rUe/Y+ULLIEBFWiidBN3aZamo8CxTmRbm32WVKXnE0Ip0Vc/jl8glqhJfoT+MWhdot8GwVnxo/yQolJsfDTT8PO/h6xtjVYJ6dmmici0r12dop6p6CCezrq8RhS1FdOwug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=IiF2HJQPcVviKIlixTpBh3Kp6CW/KBCChx0TrOXYgqw=;
 b=bFFxi6VW9wnv4yijW2C939xudKnBUaFiRIAwCQYLO0oWOdGZQlAavVZkCDYEj1NJSlX03YCWfZOLz9L3eWl9M7+FwSwqQ+Ly5v/INzYNB/aNmDDYzSl9/5CQi5gpSR9tP275viAA9YsHCCoq/MQzLf/P9mrB0YBZvdmZLVv3m1Q=
Received: from CH0PR03CA0215.namprd03.prod.outlook.com (2603:10b6:610:e7::10)
 by CH8PR12MB918461.namprd12.prod.outlook.com (2603:10b6:610:704::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Wed, 11 Nov
 2026 07:11:05 +0000
Received: from BL2PEPF000352D3.namprd02.prod.outlook.com
 (2603:10b6:610:e7:cafe::13) by CH0PR03CA0215.outlook.office365.com
 (2603:10b6:610:e7::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 07:11:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL2PEPF000352D3.mail.protection.outlook.com (10.167.254.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 07:11:05 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:11:02 -0600
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:07:04 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>
Subject: [PATCH v3 00/16] raw/ntb: post-merge fixes
Date: Wed, 11 Nov 2026 12:36:34 +0530
Message-ID: <cover.1794377833.git.raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261106055045.720805-1-raghavendra.ningoji@amd.com>
References: <20261106055045.720805-1-raghavendra.ningoji@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL2PEPF000352D3:EE_|CH8PR12MB918461:EE_
X-MS-Office365-Filtering-Correlation-Id: de12191d-281c-4ceb-1c97-08df3fc2f37a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|10067099003|11063799006|56012099006|261022105027099003|261021123027099003|261021121427099003|261026121527099003|261026140227099003|261028144727099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: 895LxouE3MkJUHtPh80QEaptoJ4y9KzOahUICR5JdGPM37wsjsk2dUd1gPICqJzvmdGc90zHIlbjtsPsnwVz32aV5KvLUazeC7FOqtNF6rnjcJFWym73dTQJ0Mn50MreHPbwSIxezyrFNIhoOJnXw17kfvPX6N5ffVvXTU0VvwCdc/mXymY2ITIVwLhFMfJlJ9QJNnsb9oxanqMikJIBDIa8ihRG8jOxSriAWE3EmFkKwHmN+GCCqcvCOO9EK63FB+TZa62LC/ocoHmsHSaNKsIq82BAbtMfJ6ycyYVgTN2bH2yRxEkzGkgZw3NaQR1fq7ifTp2TCUWJvrTC+100NktzgzKfPDq8yhyS5aY3ymuWSRekFB1Ls0RhGKo2LDrSF3Dirp5sd0uIUnZXKo68amzPdNBnCOpxneGjTCeNDsbItvyGEP0eQxFoTw4D4g2uQVMjOJCD8arESuEsbRkcFLoeSujKq2WsMw6p70Db8iFEl6rDS4N8U2MIuvR5gvldT2qx5gc+gd0qbCRjtdIM5k0DnFmakqKi2KDS4EsGAEWyIb9W49LX9fUEwqqoShBPztC2itZdgP2Tomjh/A7hodN8mUy2yAFVJy2L3/13fOfF7AggChHWU4OuqGC6iDmzpvilOvp+pmnXI6U4z0Hq3Be0Hs1lE4/HL7QiA7LhpUgWhhyTSP+/kqomj7MyjnpY
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(10067099003)(11063799006)(56012099006)(261022105027099003)(261021123027099003)(261021121427099003)(261026121527099003)(261026140227099003)(261028144727099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TJdukP82BMpaHuSmIrt8RxLNELOzf4YJVycLWmuyp9LHVta+ldAaP1MxvY8a+n0a4rJ772lM2p3CSb7p1+J+JNXXAuwvJrvYVMTfBWlHyHRT18hjPssfNoeqUH0TWSW2FR/IG1bp7w19130kBjvWoToGqiP0J6MfaBzSqJZEnGlo2zBkOWjK/v38RqInpXwbYks/dYeJbEZQdu5NT28tCdNAPCOobjcRqd8HJlP/O6ZUURMCXrl/jex2hD8DE0m/pUGszHNphS4AwVJ6WF4ClrM50V9Nt2rxXNB/+EQSc/ieFZHFEJ5mp/jeSIeYt7KV3yYCkGp0gWsHuillADzWf0Z4unvQGHEb5NLtT+90CBNyewl9Onf6WFqSi8NJ/TOXR332IvlwD4w2AMQg6pSyjpO4B5/fb2BUM5M7CpUmG1NHW6NZulolLNxhcoY4/VEN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:11:05.0521 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: de12191d-281c-4ceb-1c97-08df3fc2f37a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2PEPF000352D3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH8PR12MB918461
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series addresses the post-merge review of the AMD NTB support
by Stephen. Some of the issues also exist in the Intel code and in
released versions; those patches are tagged for stable.

- Patches 1-4 fix the type confusion in rte_pmd_ntb_get_mem_align(),
  the unbounded peer memory window count, the off-by-one in the
  address remapping and the memory window leaks.

- Patch 5 fixes the doorbell interrupts with vfio-pci: only MSI-X
  vector 0 (DB0) was serviced, so the DB1/DB2 exchange of dev_stop
  never completed and the stop waited for its 1s timeout.

- Patch 7 removes the AMD hardware event handling, which could not run
  as wired, and documents that hardware events are not handled.

- Patches 8-9 fix the Rx path: a partially consumed packet was leaked
  and desynchronized the ring, and an mbuf owned by the application
  could be freed again on device stop.

- Patches 14-16 fix the peer device status accesses between the
  interrupt thread and the stop/data paths, and the missing checks and
  leaks at queue setup.

- The other patches are documentation and cleanup.

The peer memory window size check suggested for the AMD handshake is
not added: all the AMD scratchpads are in use, and the window limit
register programmed with the local memzone length already bounds what
the peer can reach.

Tested with vfio-pci on two AMD EPYC Embedded hosts: handshake,
file transfer, and stop/quit with DB1/DB2 exchange.

---
Changes since v2:
- Resent with proper threading: in v2, all the patches replied to the
  v1 cover letter, so patchwork did not group them as a series and the
  CI could not apply them. No change in patches 1-15, apart from the
  rebase on current main.
- Added patch 16 for the queue setup leaks reported by Stephen on v2.

Changes since v1:
- Patch 4: embed the memory window size array in struct ntb_hw instead
  of freeing it on close, as the device stays attached after close and
  mw_size could then be dereferenced as NULL.
- Patch 5: allocate the doorbell interrupt handle array with calloc(),
  as it only holds process-private pointers.
- Added patch 14 for the peer device status atomic accesses.
- Added patch 15 for the queue setup checks, also covering the Tx side
  (unchecked nb_desc, and queue leak on invalid tx_free_thresh).

Raghavendra Ningoji (16):
  raw/ntb: fix device check in memory alignment query
  raw/ntb: fix peer memory window count check
  raw/ntb: fix memory window bound in address remapping
  raw/ntb: fix memory leaks
  raw/ntb: fix doorbell interrupts with VFIO MSI-X
  raw/ntb: fix AMD processor names
  raw/ntb: remove AMD hardware event handling
  raw/ntb: fix Rx of incomplete packets
  raw/ntb: fix double free of Rx mbufs on stop
  examples/ntb: fix raw/ntb library linking
  doc: add NTB device info change to ABI section
  doc: add IOVA requirement for NTB
  raw/ntb: remove unused AMD register definitions
  raw/ntb: fix peer device status access
  raw/ntb: fix queue setup checks
  raw/ntb: fix queue leaks on setup

 doc/guides/rawdevs/ntb.rst             |  12 +-
 doc/guides/rel_notes/release_26_11.rst |   6 +-
 drivers/raw/ntb/ntb.c                  | 266 ++++++++++++++++++-------
 drivers/raw/ntb/ntb.h                  |  17 +-
 drivers/raw/ntb/ntb_hw_amd.c           |  60 +-----
 drivers/raw/ntb/ntb_hw_amd.h           |  25 +--
 drivers/raw/ntb/ntb_hw_intel.c         |  17 +-
 examples/ntb/Makefile                  |   3 +-
 8 files changed, 242 insertions(+), 164 deletions(-)

-- 
2.34.1

