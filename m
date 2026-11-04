Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1950606A326
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 11:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=T2oTfFb5
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 474134025A;
	Wed,  4 Nov 2026 12:20:26 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010040.outbound.protection.outlook.com
 [40.93.198.40]) by mails.dpdk.org (Postfix) with ESMTPS id 8A62940151
 for <dev@dpdk.org>; Wed,  4 Nov 2026 12:20:24 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=T0is9Ldq4v/AgLMyBkp1zEnkzlR+riOLj1mWrs8Vr3rzsCOA53XRLDocaVQUgofw5NjpVPVujOPBSYMQNb/JR02xJ6N8ruO4zsIydqxA0rOxvlJ6j2oG1no924SPB/BuQBeOxNGwFSvkE1OAcYLneXv+BiQJKnet+D0qVtG5w9WKm5B7gNkXEPRglr3cVX8TNyYUvwQzcWL/9HbJg63YVb1KKitNI14LbPSRrN8A4f4+Baed5GG2nq7tF1ewtJP14tXJ8qRW05We1KF/fd2gHjzCoVZhQiozHiWe8gFoun7NY0Ut+aVpVy4zvJ+9BPBpbIxI1el9gudr4h7qi3lzpw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hLNqE9kLGH2hXCyVZuxael5ZQ+ZB+DZcCU3coxGVaDs=;
 b=fpjQbkvBpJyOZeySPkzsmpraMM2Dwe+fyRDCsgjKPEmfResHnotvEaGOOFPTInc0e5w+5uWmYUeO+1apWtk6zKTFxTRyzCHyfkV8UmE9IEb9o0c3/tAlpDlxOcm50TZQepKJrJG1S6nYOoxr/NeIU8RqwQ39/56dWMUz2at9mvOlyNk3l0eUT/qCjDJAw5SH4tbnDUsT7qZfHqvtXIrdB35jeNND6KFZ/o8xZOw/1aKQJswfRgvhFz3RfE8wWVEClk9r5l3h/ZUzZll7ebYr5ckg9YkKG8/rqPgidqQVqPHaQLeoY/Ot/wqNAWW/YVEjAaofZo0eb7jWxevT2k2e6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hLNqE9kLGH2hXCyVZuxael5ZQ+ZB+DZcCU3coxGVaDs=;
 b=T2oTfFb5GA62cLmw51IADw31wzcqAvoPlHASA3rfnxNrQqQEnlFOp4r5Ewdg4QpEH+TvHSuBe8EZ4dhzbfRPOViiZxCdf6DxTYN0pxtPEQt1FzjfdFSoDkRflSEo1EvG7M33bBBnE5cRzy/a3PlPJQ2Z3hnoYgJV+mrmVlCYeBI=
Received: from CH5P220CA0020.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::18)
 by BL3PR12MB6618.namprd12.prod.outlook.com (2603:10b6:208:38d::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 11:20:19 +0000
Received: from BN3PEPF00022BC8.namprd05.prod.outlook.com
 (2603:10b6:610:1ef:cafe::a6) by CH5P220CA0020.outlook.office365.com
 (2603:10b6:610:1ef::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 11:20:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC8.mail.protection.outlook.com (10.167.248.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 11:20:18 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 05:20:16 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <jingjing.wu@intel.com>, <thomas@monjalon.net>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>,
 <bruce.richardson@intel.com>, <david.marchand@redhat.com>,
 <stephen@networkplumber.org>
Subject: [PATCH 00/13] raw/ntb: post-merge fixes
Date: Wed, 4 Nov 2026 16:49:48 +0530
Message-ID: <20261104112001.661769-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC8:EE_|BL3PR12MB6618:EE_
X-MS-Office365-Filtering-Correlation-Id: 24686c06-b0e7-4e26-1f26-08df3a659bbf
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261022105027099003|261026121527099003|261028144727099003|261026140227099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: +DZX8fc93kBYj81FXcNQnHsutFr6k4JIa1gCZ0zPa1d+FTyUgyaFGETameaaDl5mFFT38epJNa3mtZ7MSKaQ33fGgnsVxaiqOCbNExQUnXhumeVk54nWT0I9NcZ/RoPEBn0+Vsq6icqaHysB3hP4nryY3BYJbi4WU/6f2Di6uwOTWdGnEmSXsDeMOqyNycZZK1+47ItUQEtBh21k/f8lvXaM8QGiTnEeAe+os2OGn4F7sVbBfjAvgFHMzHj+4Mfb/sRq+BjnZdSlKUuydpgytrutzsHE/X5UYk+W9MpPa2gTp8zY6tEUQSZ5ctnUZ+IAmsk7LUUQwsKYgaFb/KchFHS8ThgxAhTiFWB/1lKonaiq5+aLzHc1+eL8vL2XoR3EFR4daZX4D/wL+w1kvBdgbA4VJhIQcTNKqx3ii/iJrIQkwf/KgOjQz8wtTrd5oZtOIoDUiPn7M0wIWVh00MBRAv9fDOzbuPBbA5Rx1aN1AIU1TJu1HwaftjDdHm5Gn2eMIi0X0dj+cTZL+TQgIyErRy5RWMMo7YzzDxT0SDScZfaevBX7Ae/8Ex3F4BAM+gUHsVbjFSe/Xkufrn/KGX2PNdDXNoy7Tdnxg+lYkwHS6GuzIN/w72fxC8aMt+WmssIgaIroCTU2p9+tEwXG918XbVsF+Y81OXoSmF2+nVhziwzU35TE449vpnzGjkKdkSBE
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261022105027099003)(261026121527099003)(261028144727099003)(261026140227099003)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: HjvOq8FrTjotOOxabS+Olo4rjju85jzcX4t6SKwar7ULBNvN9E6K4DEDf5xHl5/N3OaWLfS9fGL/FpYYGpZWn+PRLxhzrwyOmgUtpLUsnuJ7JnWAmwdzjAqWZgcqtoVFo3dsdWzQq9YbqVLfRDvLx85gQ9y6yo1qJZDlwYL/gDprnpWnsMRWJJmUj4ktrFnY6uKug971yQxAqyvuaBHVvQnXCSJwb0rprIewsqfvP7yhweDHIB/uu1YlVsBCTy5pso3Gje/jVFoB2o7Hd+iWwsj5TTW6Rv3iQ4N5HTFllldYN8+jM7iCjgxEh7IIr5Mkh7aRJ/EjV9XjxXUqnilJy30deeGzIKIhgdgCHqC6eAOBY83dpWT0UO9yUWsQckQghVbGa1ayKMCdG+vU6f2I+oVeMn4aMhsEjTYNEQV2ezX6XnfusIF3QlYBfjsnyHy7
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:20:18.8613 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 24686c06-b0e7-4e26-1f26-08df3a659bbf
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6618
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

- The other patches are documentation and cleanup.

The peer memory window size check suggested for the AMD handshake is
not added: all the AMD scratchpads are in use, and the window limit
register programmed with the local memzone length already bounds what
the peer can reach.

Tested with vfio-pci on two AMD EPYC Embedded hosts: handshake,
file transfer, and stop/quit with DB1/DB2 exchange.

Raghavendra Ningoji (13):
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

 doc/guides/rawdevs/ntb.rst             |  12 ++-
 doc/guides/rel_notes/release_26_11.rst |   6 +-
 drivers/raw/ntb/ntb.c                  | 136 ++++++++++++++++++++-----
 drivers/raw/ntb/ntb.h                  |   7 +-
 drivers/raw/ntb/ntb_hw_amd.c           |  54 ++--------
 drivers/raw/ntb/ntb_hw_amd.h           |  25 +----
 drivers/raw/ntb/ntb_hw_intel.c         |   9 +-
 examples/ntb/Makefile                  |   3 +-
 8 files changed, 149 insertions(+), 103 deletions(-)

-- 
2.34.1

