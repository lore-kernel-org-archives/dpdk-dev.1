Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81694606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 07:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=oSmmSi/o
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CE4E24278D;
	Wed, 11 Nov 2026 08:11:25 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012009.outbound.protection.outlook.com
 [40.93.195.9]) by mails.dpdk.org (Postfix) with ESMTPS id 54A31410F1
 for <dev@dpdk.org>; Wed, 11 Nov 2026 08:11:16 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gj2b6mmCMkXsdSfnAzvBRZyNYo9qJtyrvxXKyh+y6YFbAgZYln2FDTuGJIhOIq6uYVyd46iqoefOrQzj+KgIZrMeetPQ2XBfWjQakW7qIpiHdfQtMy4riNGDiE16yF3Lk/gPArnSmK5hAhw+DAOz/01xQRj7g4W7DJWM2rf9TPl6j/v4rXFobufRYM/v74h5IoRdgwMQWdhHg/XR9GUTP0uoGaj4GgwW9lgAM/HW5vvIQbN7eaLzw+KMPqf74iF6WSCv7hoff+eFYHSRtU9I8aolazITBAEqC2tDCSX74wh0FKnbhqYooTHQe1Hfo6dy5ktulyNq9HJQeSYJ7bIvMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JZfJkrkyZzXO5jNCPH1ajRCtyKgoTQVGSKLqAmjZo84=;
 b=eTI+7JZFjcvfTIDcic1ChacyqUHFu+ChFCdXmpC80vkKnyVxSQqhzOOu5+nKXL/TKHnbTzIm3FdEMjs8NzSp1QQ19nCVt9XLxcvR3HqfZt4mB2zM/1yDOidknTySx5XMwimTJh3T9AcMoK8jt8htOZ4aYlZ+Pg57QahM3EOcIY01HyPZaWhYJz24vL3+6l1nUCuK8vfHBfXt1LpQqsdmdHk2oYKyXquuxFEGP3PS/nTCCNih/KISuZLK2Tji+cj2elDMbUuZC6B5G6Y3+USRHIzVbDIvzjnF1m/Pdgix8m2el69nrzke7RrQDeYAj3iqsyluSHfUUllFo3Nce1sRxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JZfJkrkyZzXO5jNCPH1ajRCtyKgoTQVGSKLqAmjZo84=;
 b=oSmmSi/oMm7qv6RhpQOx/CJNXhD928BFT0tgxrpK7YXOIzy6uPQtB3opgMZ/EH+zaKgg93oNlQ/EUKUsAGUaPamx/1jbUyOkfygGtLUhfjFrf3KACN2bmjHzRfwkEkkYe3gaXpYhhL8EKjvtSEyVsBTL6CexON9UzXMgMfknrSg=
Received: from BN9P220CA0004.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::9)
 by PH8PR12MB6794.namprd12.prod.outlook.com (2603:10b6:510:1c5::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 07:11:10 +0000
Received: from IA0PEPF00000041.namprd04.prod.outlook.com
 (2603:10b6:408:13e:cafe::72) by BN9P220CA0004.outlook.office365.com
 (2603:10b6:408:13e::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 07:11:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF00000041.mail.protection.outlook.com (10.167.249.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 07:11:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:11:04 -0600
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:08:16 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>
Subject: [PATCH v3 10/16] examples/ntb: fix raw/ntb library linking
Date: Wed, 11 Nov 2026 12:36:44 +0530
Message-ID: <1d482996034163f1863eca7195cb8bd80b892584.1794377833.git.raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1794377833.git.raghavendra.ningoji@amd.com>
References: <20261106055045.720805-1-raghavendra.ningoji@amd.com>
 <cover.1794377833.git.raghavendra.ningoji@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000041:EE_|PH8PR12MB6794:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ba476e6-5bff-4b7b-034c-08df3fc2f678
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|18002099003|22082099003|3023799007|56012099006|4143699003|261026121527099003|261102123227099003|261021121427099003|261021123027099003|11063799006|10067099003;
X-Microsoft-Antispam-Message-Info: LzjD1W+YIMsKR1MhaUeIFJBiDGFLY9mjoWtMn+Eu6QOM/ISpY1ZyVTS3WVNOfU1TpKESanWFJC9j+hDIZfQdbEL2i6RvlOeq0PZobcTCojVnv47LfY7UWY6weRqW4Y9cvHE90jk/l/2gpmlvpkbakN19qM+Fpl0cg6UmJ+sVywlKsqIT+SLmXICN2kt3luZ6quptLJJGe4EwIVEZUzu/AiTvdxs5eqjWDkQQIdBYbISeMJaLfea+BhY6dvaCzzi0apkxeVHLiq2Jx+kOt8RNLazT67DplWDUoUc+utfgJKvhtN7X8HjeUDAElgob/2UOL25tHweGeRAEaDZtDKke6VzljMCSsDoqZLXPqFgK2+xAknASAIH91/I4Bfq/pKDXQ5n60mmMs9esH6aeN2VSJG/+d9sROxdHbzECDhADAu50ynGyxOyrqtdPp5ehDtKaekEXKnV/fZo6NFJSx+YGHv5SvAeK+JEjeYQxqUi8+PJya4OmgpOJkHm0nuOPbWBWrT0u15p286xl1bpkRVGe992WpXDlzQqo30lMRUQjDOJ1hH5kvpLsxrm5baI+k5mWdiZeVNUJ7V4xsgz7snd1GMTV5zhbGn17MgrXjujRCcrSrQhFrKZb3aeJiJIc05IrgwTO/zDzygYUPc6yD4uadB4qamPBI156a19YFqXLFJ82XUI1dtZ0h4Sbca1+OvKxZPdXTU8/DCwtoo1wKw8qMQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(18002099003)(22082099003)(3023799007)(56012099006)(4143699003)(261026121527099003)(261102123227099003)(261021121427099003)(261021123027099003)(11063799006)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mLgmknLflh+LdxUG5nLYlkDte7LZGskf//t5nUPr7ZIJEPLzMdzF0ECNpCo9QGeAjwbjnCBK6iSmDfBGiJYbOT/MgzEKK6B7hexkVSYo/mr83Zi+pBBODh/UK201OyTZALSYrEBMKieEQErJZ9MEsm6+wZ5EeMqS0+Sp3FXp0oT5kFK1+Rpx8GedwlSea8P2FvYIrMJCRRXR93XRyOvR56K+hxqFm23EWVlG8M9H/UGZXmFp1lwdhSTOhEIsTAkFNkfnuVqNxnnPXABDLnTTzWPdr0NWT9rNddeeSTF0JK/RRFIs2ZxJTHPCWdSo3RGQSTxNfp9+cSQMmSkogIbq3HpNjjQj64jXULPBPn3HUU5MBOtBXwMcg9TBHjOmPI6y5apZW1P1FS72YJ05kWwX/PYNrcvuZsy0oFYmyHQH2RsPZ0Sd57B1Zv8BqE/Wg35c
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:11:10.0725 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ba476e6-5bff-4b7b-034c-08df3fc2f678
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000041.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB6794
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

