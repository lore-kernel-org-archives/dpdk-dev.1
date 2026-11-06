Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9189D606A33A
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 05:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vXD98HCn
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id AE0C64029B;
	Fri,  6 Nov 2026 06:51:12 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
 by mails.dpdk.org (Postfix) with ESMTPS id D9A0D4026D
 for <dev@dpdk.org>; Fri,  6 Nov 2026 06:51:10 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JF6HelOK+IHg1CNKh+TZ+T42fz5lOQaJG+iOmw4ZZVgs6bMJC54Ma9RsYAeTUaf5f+ZlnKwDB1q2JOpxqsV3JDQj63dvuJm/em4bFF0V0LT9/hFvmAmizDpJt76If/Qq52Ewg27oDC+JnnjaJVRcqfY2tGWkDxTBq9AJiR30Tdv5KMPtdv47+H0TUDgAQyJOG58snuiW+Qs+RPmw7r/4uct0YUEE5satlPfMliR63M4dg0Rmo6qeIFGwE2/WI0rwiLOEVN9WwM4DrMoaXfCLnzfC0m0mfdqJjl1KP/Jarr8qgvLBd0OhC3SoFhWkIbuIf/NnQ4FLqq5TSpQD5JlVHw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Etjr28aPwuFhG0KmKQ/57+wOGtXE91I2KJjIxlQHbg8=;
 b=s/jvnHnjdL0/sRP6wHQzguvgk6M+0JfsBF/Oyl1jb7Msh96O/C3HhvD1zUHNzQ+Y7+v0mi4cipq1uzq/bKJ42l0nakxxhi2tzXITS5w4zRf3njFgjd3EPqYAi1HLBzUh8wxSQiV2KBJNEkHnrvpRvKyT/qfz9cmhNH9N9UFMMvtz7+eabrLp/mXZt2inqQ6xou7RRc9D0o61w/3M9GzzayLnFw9O6w3Ycw9WxPndquosnwHbUSCgbUrj9V45oearo8bY44uit01BbBjCYEd+ZHylENR9SV2jD1cz824As4dSFoEey2h+SudRF9yV4f0LIu2NnaWA0ygfHChHT8p+6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Etjr28aPwuFhG0KmKQ/57+wOGtXE91I2KJjIxlQHbg8=;
 b=vXD98HCnS16yCLYbnZ80qc1E5HmoTFV+peqwFB1eItpoxze8mSUELskYicOOnBPJIaxNPpg2NEWAirBDmJf4A3aN4PXwk0Cv9xVqbZDwvP0QBGqAybIA2PGpc/LalfQ80uX5Mdbx/7NU3THmia0Gk6tKAYAIiOj9kUZmeveNtGg=
Received: from PH5P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::6)
 by CH1PR12MB9623.namprd12.prod.outlook.com (2603:10b6:610:2b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 05:51:02 +0000
Received: from CY4PEPF000392D9.namprd03.prod.outlook.com
 (2603:10b6:510:34a:cafe::8f) by PH5P220CA0008.outlook.office365.com
 (2603:10b6:510:34a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:51:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392D9.mail.protection.outlook.com (10.167.247.119) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:51:01 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 23:50:58 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>
Subject: [PATCH v2 00/15] raw/ntb: post-merge fixes
Date: Fri, 6 Nov 2026 11:20:30 +0530
Message-ID: <20261106055045.720805-1-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104112001.661769-1-raghavendra.ningoji@amd.com>
References: <20261104112001.661769-1-raghavendra.ningoji@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392D9:EE_|CH1PR12MB9623:EE_
X-MS-Office365-Filtering-Correlation-Id: a71c78a7-91e2-4d0a-3ea0-08df3bc9f062
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|22082099003|10067099003|18002099003|56012099006|261009223027099003|261021123027099003|261102123227099003|261021121427099003|261026121527099003|261022105027099003|11063799006|261026140227099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: DZ9hGLpsGQwHXunuXq85EfwLz+lmLLavVObSULKEZxWp1SRTlPkYoP9gAPbjqMvUP056IfXMYyvqQPmdBO9qfLVmn7GmUtncxE2gxur6JBJLX78YCQ69eGNqRc5qL1U7FsBm1hzPFCeH9whS2KjKNlZNR8JkBQKcIr3YBG8yBgLXCKswPcYRB2Pcozto2gexnW/iWPuXCbexVPvkX5Ty5Qvow7JSQ3JfiHudmha0gkUeaH5wNe4bYP1f8Y9+tBpEhckqnGi/1d78kUKMAGmKwBiNW8dHTIfEzGz0baXJ1eAYn4yzzgQyv4fAU4+snjQ4W62t1LXXnXovsEZ+5QbaH43yfreJPqiloBRgRnkQH+6IlrzR7oXVzWNgBgKJ5aC8/xJYwwQupjYvNsEfVeuwEaJ+UR7JSnlZWKj3VyVtl/2K2tRefjP/0yJkub65SHcRiLYCr3/9ea7bXPh+yBdcYG7w3077tGPU+Qq2/byZtrSuIxPt3ISKdkSwGrG+TyV3BNuM5LosRnM2qhg7m2mA27X2yK7YL8gF480HVT/raIr+ta2myLyhAxoqHAmntJmW8GoD54x38KxYQ82X6XqTEi9pUyyiigcJzWiF487SmDNrlx4XDG3xmvbb2wtoLZ35/PNaY21ddCZV9HQ/nJcTOK5XOjnZLi3KxR0OwTxq0clTkpWYgKIUCiUpKleZDPE3
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(22082099003)(10067099003)(18002099003)(56012099006)(261009223027099003)(261021123027099003)(261102123227099003)(261021121427099003)(261026121527099003)(261022105027099003)(11063799006)(261026140227099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yZAjgQM/FdhTvPRHs/3AltxCSNlm5m5thnldIkFo2zLWieWBP3IId5rb2eqT7IvMhA6FYQGSIXQ1GZWqkBEpTw0SE0NTikTOpjdzjBsnXtiIQiHk1DwcSbOdcx7Qc7avlgkCBOcr5WkU8Q6luGyHc31s3X16wEc25ayzeDFMpfU1VRZua2NzUA2qxZCmDP/VFOSgu9txafOl+yy03atCv78Dw6rmh5W7Y0PfrHG0a6dr5PXWb5aD/W2BsEYOD4i8IfzGBe+cxVCtKkxd1o9TkdIoaHULQWEiIFRIdIbU+NiHAc+gPQsYBk0ZWweZ6T/LPvt10pu9F4iEJx6SuHKmHpfn/iSl3zMoDhY+NLXMiE0QnCBtdfvlwdNaF6Gh/nOnGD/y7OwLhwA+jaARsmCyV4NlH8MWm+oJTLPp+peQCp7yZka6ksTjXMJqsYDhlBDb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:51:01.6484 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a71c78a7-91e2-4d0a-3ea0-08df3bc9f062
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392D9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9623
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

- Patches 14-15 fix the peer device status accesses between the
  interrupt thread and the stop/data paths, and the missing checks at
  queue setup.

- The other patches are documentation and cleanup.

The peer memory window size check suggested for the AMD handshake is
not added: all the AMD scratchpads are in use, and the window limit
register programmed with the local memzone length already bounds what
the peer can reach.

Tested with vfio-pci on two AMD EPYC Embedded hosts: handshake,
file transfer, and stop/quit with DB1/DB2 exchange.

---
Changes since v1:
- Patch 4: embed the memory window size array in struct ntb_hw instead
  of freeing it on close, as the device stays attached after close and
  mw_size could then be dereferenced as NULL.
- Patch 5: allocate the doorbell interrupt handle array with calloc(),
  as it only holds process-private pointers.
- Added patch 14 for the peer device status atomic accesses.
- Added patch 15 for the queue setup checks, also covering the Tx side
  (unchecked nb_desc, and queue leak on invalid tx_free_thresh).

Raghavendra Ningoji (15):
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

 doc/guides/rawdevs/ntb.rst             |  12 +-
 doc/guides/rel_notes/release_26_11.rst |   6 +-
 drivers/raw/ntb/ntb.c                  | 212 +++++++++++++++++++------
 drivers/raw/ntb/ntb.h                  |  17 +-
 drivers/raw/ntb/ntb_hw_amd.c           |  60 ++-----
 drivers/raw/ntb/ntb_hw_amd.h           |  25 +--
 drivers/raw/ntb/ntb_hw_intel.c         |  17 +-
 examples/ntb/Makefile                  |   3 +-
 8 files changed, 210 insertions(+), 142 deletions(-)

-- 
2.34.1

