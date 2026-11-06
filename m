Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EA06606A326
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 05:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=1DSmQKZa
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2753442E48;
	Fri,  6 Nov 2026 06:51:36 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013067.outbound.protection.outlook.com
 [40.107.201.67])
 by mails.dpdk.org (Postfix) with ESMTPS id CCA3E42D7D
 for <dev@dpdk.org>; Fri,  6 Nov 2026 06:51:33 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Egs3bCRd470JR77m7D/rzBojECF0uDOPWVO20JfXMWGIgaQZCJ08IFejztBbbH5rCsPxRCahGmc8/Kq/fphJNP4EtU6149dSQ0In1XK+nyMitbzh/DvssLpC6zJVr31kqf2+XIvujnjHYli2sRhcQRDV3HuFoyWB7sJDrzrosuiX1aL+vr3D/6J6lzhSzo3nRFdupoBc+k8nQrVpISH8jjXRmgLGQp/bfl+1TXwvxYFSwPspq5oJEYrjS0m2aDpHmPDc6VjMjj/SyNYu+86ZOMRzaDsUzCX+ag3Cgk1hmNNlVC6vbMnE0QrFKE63SSus6SZJK8VaFUS7iyfwZyZQyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZfJkrkyZzXO5jNCPH1ajRCtyKgoTQVGSKLqAmjZo84=;
 b=IqdVBri1bBIT9jN2Hpghiy1xxtggA0KfDUxioCt91XIbAO83hXeG04b75LdzPrhROcSkNyB3t8Unrqai7jVN0cwzvYf6Aa2KrA4BPlvHrPho8UA7c6qEtLdGzrOHtJE6Z3zdcxwxwwg+uLG89V9RTA/tGr4z8NJkc3RICWsWYrMacR0GSRRBRctdlbP1JEUqX3xiTSl73QwcK6Kszu+0qtpyfMp8T6gZJcZnrs+z/p5c9B/ay/gkzXk0F8VIJm63jv0W5iM+fQsoiTGLWZAiOaYBvOjD79JI3UcPAyCo8mjcusM7JqQEXLPgqfnni8WaOqsASQySimbl2W3aBF7fwQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZfJkrkyZzXO5jNCPH1ajRCtyKgoTQVGSKLqAmjZo84=;
 b=1DSmQKZa6O8SsEljSARu+b8iwXy5UPbJBcBb0cZ/6MUH1DhltDH8AcqOCfdL/aSt+Z+wAoPGW10adyfZ5YMV0R8Ewx+T5m+HhMBqf+IBhc0OmAC32A09KgHeufsFQ45ecda2HpKtPUq6RKj6pFOB70fWg5El2X633mXs1AyhLfc=
Received: from DS7PR03CA0320.namprd03.prod.outlook.com (2603:10b6:8:2b::15) by
 IA4PR12MB9785.namprd12.prod.outlook.com (2603:10b6:208:55b::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 05:51:29 +0000
Received: from CY4PEPF000392DC.namprd03.prod.outlook.com
 (2603:10b6:8:2b:cafe::60) by DS7PR03CA0320.outlook.office365.com
 (2603:10b6:8:2b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 05:51:29 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392DC.mail.protection.outlook.com (10.167.247.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:51:28 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 23:51:24 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>
Subject: [PATCH v2 10/15] examples/ntb: fix raw/ntb library linking
Date: Fri, 6 Nov 2026 11:20:40 +0530
Message-ID: <20261106055045.720805-11-raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DC:EE_|IA4PR12MB9785:EE_
X-MS-Office365-Filtering-Correlation-Id: c5a03bc8-9739-4618-fb51-08df3bca00a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|11063799006|56012099006|261021123027099003|261021121427099003|261102123227099003|261026121527099003|10067099003|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info: XztntK0CoLKoufErhlSPAFkGbCrd0A6OFgkzb/OZSDwP+bYZa3AMvPII+BIP6fMOk6v6NgKQ86hIvtIfNb11uXQKlQr9BomyOxdr8H+CMRoQer2jeVxaKsa6ZDtXQp0lC7deced/haoayeWHbgjxQcvtZs6kZ3ALB3nu5u4K6FsN5TBjw4blwc/xvsTFn00sa3qUV/VVpkkagLGDxBCTSCtCDNKv0CWBDMS7ZokgR6Z3mi0SiCkrWI35/AaMbheoYBfeaDErrbHr2nAWeyIZx8aCU7Y0WEJJejh1no/ZDhLoDDEqcC/QE37S5FlKDRtPoSzQMSJgvHPxae7Wn5nWZnDTB+k58CP859jzgnL0ccWNwc+zJh3csPyP4uR7C31HMx5hc4E8/+q12LgOMcSfDXjGf7SJfRLbXmUlYCyC1m9NtNha+CelUAsYN4v6+2bRez/ruj0Kt9v+PtkcJR6Nsm9Fvcahz5ef8Ijq8g3s/nMr27uEteiDmxLGNemTjJSxMpzCp+QKRtWHAaNroQbtB84Q6XVEytbEDeD6USuaUn7ReSgdI+hCv588Sf6R5o3UsMIbLcIAqhXCXzUWXLd7GUkcGF7nT/aP0ivOmW8TCidrGD/b+63i17H6p1W/RgfzKWaWmor3Dq5xFkAaQ/9LYdxNYo2m1yHXrxqXJ/6OYuWstgojKERYKcZbFwpue3vkqNZtLcVKjx9fEbnjIDnf5A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261102123227099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: YdmxOJ6/YBWLxVgggue/vYBG/Ga30MOaxBvVUirsQYBcslmN1gIwwDCDfLevOUSM6JBxRvkWhy3A8So1qQdb23+GZ+KqLtVYo6Hf1qa5usJTMbC/C4ooxVE2+eI9pFqHQTvbf4EC/bvOeRvhpETy6kSJa+IPVb6kZT0gE/W4/jDQHerZhUT/an82l40ks/1/EJx008IkLlg9gMWgO6971vmBQyHTVPNyjQ+QVICmIHwMPMFBd0VWq7ic/5f91S2zHYpeqjCeSkb50Y9sJfWAqNdjAjzw2SsAgpavWU/YxJaDeLE4J2QXmixYh1Daxg4Fj8dKThgShDqA7iCbJDOIr8wl+npVSFgexcYY6MyYQHxSKfKuJyGuldHX6LKFxbz/n7iB8LUH+CbNKsTztdNcGn0o+3IG+aQ8ufxi1wdIzklhjV8/f8ooi3TfUum4iTWR
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:51:28.8995 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a03bc8-9739-4618-fb51-08df3bca00a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392DC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9785
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The raw/ntb driver library was added to the linker flags of both the
shared and static targets. For static linking, it is already part of
the libdpdk pkg-config output, so only add it to the shared target,
as done in other examples.

Fixes: 5ce50c234ad1 ("raw/ntb: generalize framework for multiple vendors")

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 examples/ntb/Makefile | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/examples/ntb/Makefile b/examples/ntb/Makefile
index 6c0307c697..a074251646 100644
--- a/examples/ntb/Makefile
+++ b/examples/ntb/Makefile
@@ -23,11 +23,12 @@ static: build/$(APP)-static
 	ln -sf $(APP)-static build/$(APP)
 
 CFLAGS += -D_FILE_OFFSET_BITS=64
-LDFLAGS += -pthread -lrte_raw_ntb
+LDFLAGS += -pthread
 
 PC_FILE := $(shell $(PKGCONF) --path libdpdk 2>/dev/null)
 CFLAGS += -O3 $(shell $(PKGCONF) --cflags libdpdk) -I build/
 LDFLAGS_SHARED = $(shell $(PKGCONF) --libs libdpdk)
+LDFLAGS_SHARED += -lrte_raw_ntb
 LDFLAGS_STATIC = $(shell $(PKGCONF) --static --libs libdpdk)
 
 build/commands.h: commands.list Makefile
-- 
2.34.1

