Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E709606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 11:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=L/0ovKjp
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4676E427CD;
	Wed,  4 Nov 2026 12:20:56 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013028.outbound.protection.outlook.com
 [40.93.196.28]) by mails.dpdk.org (Postfix) with ESMTPS id 2CC6E427BB
 for <dev@dpdk.org>; Wed,  4 Nov 2026 12:20:54 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=F7BEHXsSZP4kHn7o+Jq6+wfPZBxum3t+CUY4j7pvJ/KiMOPphhmvwgGx4+Y8SuQ7lMiy4YJtB/bFSalXAkdIVtXDVJwlIrtctZ93UxHEjYPrkiSR8W3y+T+hWFBsnBpBaVQx+xrwn62We8P5vBpHvtuBzYsvK9ak9f3exBC+z+/zGQYZK17fvJsIdXekbBR56OYY8gZgXtAlpTv/af5fy/8B3VuesxiONutnwCdTGX7Gtd9+41Zy55Jchm6+FWnEftQi2O42XHB5FsiqxlG0Yp0Tn173biV2lhbKrcohY7Vy5ws+UFcsdETwSRmIqCfD/om4RQj130p53u/7X7w2mQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZfJkrkyZzXO5jNCPH1ajRCtyKgoTQVGSKLqAmjZo84=;
 b=QFajKsJWhJ5Rl9eu9CMT7XZ3MwbaChGum1jKI66vXN3pEDbKypPf7QTwURJEaR+3B2To1iD2/Ch0tTILFNW+p0aB9vCxFtfFQGfEicTDMSmbJAWo5RAYd+QmjXeBtVqHNPCGF5Uyk6aIBtj1ZIM0nJS/wYmqv1CLBGLbTLqQiRHwkhxJBOJvUujTRGK/afZM9M30HCeFgkpVoHoiNW4PVB3iuAat2OXMbJx3QiEZWMvXrcF26W5lgBad5u0VOrqcSRSgc+BpXzfL0zZUdo2PD2lWj92A7WOESH7v6keDVxiZNTh07ysuEy/uh/VEViLXtnYSoic1YzHx1lz9dsxs5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZfJkrkyZzXO5jNCPH1ajRCtyKgoTQVGSKLqAmjZo84=;
 b=L/0ovKjpfJknwJWAue/r9z+FcfY0jIhNNmwdA/au0//MiFVaRBb7SLBdEGyj4JKvMLZkleeiWNknVW5KS+rGsJC4GBhyPTDDzaLev3bXUAMrEXcPfji6XKsxNKOfvP4U1DQFXADGbrexCCKE4FmXVsWOm6RVKMag/SRNRy847Q4=
Received: from CH0PR03CA0439.namprd03.prod.outlook.com (2603:10b6:610:10e::8)
 by IA1PR12MB8465.namprd12.prod.outlook.com (2603:10b6:208:457::8)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Wed, 4 Nov
 2026 11:20:47 +0000
Received: from BN3PEPF00022BC4.namprd05.prod.outlook.com
 (2603:10b6:610:10e:cafe::5) by CH0PR03CA0439.outlook.office365.com
 (2603:10b6:610:10e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 11:20:46 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC4.mail.protection.outlook.com (10.167.248.216) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 11:20:46 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 05:20:44 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <jingjing.wu@intel.com>, <thomas@monjalon.net>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>,
 <bruce.richardson@intel.com>, <david.marchand@redhat.com>,
 <stephen@networkplumber.org>
Subject: [PATCH 10/13] examples/ntb: fix raw/ntb library linking
Date: Wed, 4 Nov 2026 16:49:58 +0530
Message-ID: <20261104112001.661769-11-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104112001.661769-1-raghavendra.ningoji@amd.com>
References: <20261104112001.661769-1-raghavendra.ningoji@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC4:EE_|IA1PR12MB8465:EE_
X-MS-Office365-Filtering-Correlation-Id: 2291e390-d300-4ad1-4d77-08df3a65ac76
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|376014|82310400026|1800799024|261021123027099003|261021121427099003|261026121527099003|11063799006|10067099003|261102123227099003|22082099003|3023799007|18002099003|56012099006;
X-Microsoft-Antispam-Message-Info: 6m3km+LibMX0KHd+d1Gj8PR/iG8Ai1b5pD6G8/xuLYcoNIwDEpysyW4vN/78KAF1RX+EPXiqR+YG4L6JwwuU13UvDrZjd1bxOVFwKFzRmUBRZtBB3Vy9jCaKTIzjnfA4GbpUdFlzmGY8qsqezIoJ+rMw2JtuYjqkluWpf+3eLtC82GdtRMCRzg6I4+JLlsmuEJIbQDTyEK6oQKFYI5sFaA6Q8nVu7M5C5PBPEJRmujYXj3xQk4U4KxdOItCexjQSofWP+8KYDQeEwd2qGPJgziiT7rFPcNRYOtwWUWi2iKAAn2I7FM9qfn0op6dbmWFjeGwxfRsNQx2s7nYrkE0QfmG9EG4mFCsnf6bi1P/3N1ABWXU7YrgurfFOgD1nhybCMaKNLyiO51QpJq7E9ePPaNj9cpVAuHJ8Rj5+vSevuGuaEmxcICUyIJRgInT9oOqvvbwCEapBwqm9y5Cf9YSW2RXsnwwcAEqcakDijkCL/Jdkfq/sok4q13sMSNBvbgWA7PguMoedzSpszJnIaN1+S47VgPXrqcADS4kWcKYsvMNY0EqYfeAAktJcECza9llHTnyJdJt0eYTBNaKxl15iFlwUOX3x2TyIRG2QuHTi8hBdIuEX5av9hs0PBZr1v4wTU+dl6vRL9l8uqAGCeCUONXoRoodLp1tuVvYpn+4vU6m+f4ePhqJRMOmhKNK/W6ei/AjKNwbRWEkpHMAB5xJcdA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(376014)(82310400026)(1800799024)(261021123027099003)(261021121427099003)(261026121527099003)(11063799006)(10067099003)(261102123227099003)(22082099003)(3023799007)(18002099003)(56012099006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: ZLZedJKehHmqu3437Wmg7TuAx7EZIhydzSTFXq4uzTJB03w2wacInGizijZg02xcsY3UbtqG2fL1N/23gmBh9ol1u91KR3s33RiFFins0BKHixhG9op1lzB57+KvG5FsqPXiBCzIVJU721PotTs1NIH5+bPghuQvr+FdrKfXmkZ/PlYtUgzPg7w5jMuGxYXGbT+v4fxZCFSTGPEWxX5Gwe/NYpyjzSD60gx35/rlNOsycJ6rvKtHzpXTscG+1WLeiTcyxsNHiRxqjlLcyDy/k+AfVce7Nh+Fk5PXCuDOWgTRRrjTxGUAyQxTxGg6wS1KkEBFfbfHIky9EMlBGQW8igKOBmHv9jYmrUxNY5jHg7FUp9tpG8MQdZOX+GAsw/kJAapy4QsAsleXXrydzKZAcjMKgpAx9zVWp5R+m+tN22ha6/7UPCaWmuutQ8WpD6JH
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:20:46.9004 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2291e390-d300-4ad1-4d77-08df3a65ac76
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8465
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

