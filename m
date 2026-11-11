Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBAF606A320
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 07:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=t+IKaGDA
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 12BB14279F;
	Wed, 11 Nov 2026 08:11:24 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010071.outbound.protection.outlook.com [52.101.46.71])
 by mails.dpdk.org (Postfix) with ESMTPS id 5F3BD410DF
 for <dev@dpdk.org>; Wed, 11 Nov 2026 08:11:15 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BpEfXtW4B/kyOtaqjq6rhWj5KofhKVhSG3iwBLFIsgb3N34kVN7eIU3065303K93CGzEmn3xuQ719K1+oluqwpui3rASFAiOmlO9Jd/qaPfdURhx+Q1h2UHJwuZ1Z6UW8pMYqtt0GEP0CVEoZyj92YI7ZVrQqjuOA8l0b3J859rsvbbuTbWX9LAOWJlsbKRUHVupl9ZYcZRQKx7hZxUDXmcVrxbaExkQWx5Uemr2pEoaUCU4YKMMD/1A4MgZg+THu88/4YDjCnI7r2JtMpUD1/wF/8s3sqB2b34TvZd8Hiaozn2sCWYZgNW7ajvBhvODMMtoHH2O50jvG/f1+E+/vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V+ENCPhDezhEtbrNlJYKRv06dtmrpfxbYun8h/hZN9U=;
 b=wxY/LDcU9jTdVjE/BBYv0iQBavlSjTdF90qb9JBNPoHcWlmVsYrJW3RABuUEi4PZkk4K9IY6I2C0BI3PsDKv9RXGARY0LZfxEeIZsYRZZnJmnon31y3kxTlFSoCKEAxtsOlGip2V53ABm4G2PS5rUw4ZpztCroLAYQcgvYSSSyz+7UMOqv0Mkq8c17jFRn2FEbQcNUI1gWXsnR+tZIcp5g2qTu3AVt4Ih9STFOY4jA3LUjVSmo8owgpBVXit8yPzoX9ea/PBGr0woo7hRzs82Y7Jj5UC/c0TRTIZo2QVIZuseoSqylueI454pGB1+ytZqAaF4b1XJEcIwzBHGqtb7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V+ENCPhDezhEtbrNlJYKRv06dtmrpfxbYun8h/hZN9U=;
 b=t+IKaGDASlzx9eOGGt+hOrCWCp82FY39WnBRPWJCAsNMZYplTBG1Jf/GMwMkhbKU+wYwLUzA7+API23vaPMMMChr+k7RPsk8n8rdzUhXRpzOeUstbGxnbBTaAEVzBO4bHsX4cZ0njzFOIdaAUWfsEFsyAVIIiZLG9rwwdeiRzT0=
Received: from BN9P220CA0005.NAMP220.PROD.OUTLOOK.COM (2603:10b6:408:13e::10)
 by SJ2PR12MB9087.namprd12.prod.outlook.com (2603:10b6:a03:562::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 07:11:09 +0000
Received: from IA0PEPF00000041.namprd04.prod.outlook.com
 (2603:10b6:408:13e:cafe::26) by BN9P220CA0005.outlook.office365.com
 (2603:10b6:408:13e::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 07:11:09 +0000
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
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 07:11:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:11:03 -0600
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:07:19 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>
Subject: [PATCH v3 06/16] raw/ntb: fix AMD processor names
Date: Wed, 11 Nov 2026 12:36:40 +0530
Message-ID: <feede041a8602720f8d9461ba2462fd8d89245e0.1794377833.git.raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1794377833.git.raghavendra.ningoji@amd.com>
References: <20261106055045.720805-1-raghavendra.ningoji@amd.com>
 <cover.1794377833.git.raghavendra.ningoji@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: IA0PEPF00000041:EE_|SJ2PR12MB9087:EE_
X-MS-Office365-Filtering-Correlation-Id: 408e1d51-84a3-4b6c-405b-08df3fc2f589
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|6133799003|261009223027099003|10067099003|3023799007|261026121527099003|261021123027099003|261021121427099003|261102123227099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: ISWCYi4T/oHUKsAEOlEADFRpLQvRF36sQVhCbrO1pc2y3mCyxosHfjVEkJFlHK9B//K5rD+alTxx7EgzJbDBSNH9jk2ArHo2EeOyVzRGC4nC6rXNNAzs9c7NVP72MvG6mKi1SF2khXi1HXtIxIVKuHpCgdJth05GWvozNN0ep9axNdIA69FBE5TDZ7BGbggAOzavmwRNFTl8UAsJ+CUUZoc8qly271sKURObqByIVcgYbzVOT9gSGc4DZTdKw0O/+pAl576QQsFf/MzNVejHt2bb36UiCCyuHpBpOE4uOgb/jnDmHDkvqHvAG8G31GXW4akYDA2n8IWiNsPXhz0xRcpiY9il5Yzw9yYZCpRWpaIKm6eWtFn/g4BgnMKOKUghEr+GBeYe5e5JeFJZNwo4d+EOoQkjdUcoym2tqOJOU808oXKzg+ryPDRh5BDQpxD8UvqjHrcbn650OYxJYxry9+u+0bGFFluQmWn2xi6I/JK8+FiAl6nMZtYELmMrPnEDl2zUlEfTt70cYKHgzjGlbZjf7PXs8132vY7hiKxMF6fjU2ASIl5SAg+OBHY7YCOwKtHMTFe5zPMxhrnHwTLP/mhOJT7yUV7CKtOsaafo9SXcmqSs8PGEisfNrcJfU8mzkn3jhTJ4XKVDTbEVokMzJL5GHGL/o4vGuWlc/Pl16PrufkCTU8cl4DRO98t0cg7SVBgjPk1I8pTzvTtvW12njw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(6133799003)(261009223027099003)(10067099003)(3023799007)(261026121527099003)(261021123027099003)(261021121427099003)(261102123227099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: kxQ+yWsqdKJUmMXww+/uwmuGScHUQNtPYP2hmTAUOHilWxdYRtp27ZmBjEkINKb6AXR4S6TUvbZ4kjZfg5DLJwrIFnbaGkoamkMcx0AMbnCmestddhAi6FUrlPHaJ/9cxOKEfGR8oknM3Oh2xD7mX/BCVjUTz6mCOwS/cb4P2h/dAJj2liygbEWqnSApauNU2httUU9pMfgRLm9ebS5kZDGKv1SL4ADCWxiXFn76iNIj3YCo5M040T10AxjnFRk9rmXUhMT2+LT8vtvn5s1DpSw/p1idj6WuYRyFUcoxHJJiS4jWJDQFdlYCW2BtAGIPh0nIXzVaCXJLY6GCp1PlmQTtjK18ESrrapz+7GTiQpCrgUExsV0CbDssGRRO/vaHK+7XnlbMYiUGmTpBPgrwFj0vOZVzNrX7w4FtAyoqsH+UcolWBTAup3W1px+O1IuY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:11:08.5075 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 408e1d51-84a3-4b6c-405b-08df3fc2f589
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000041.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9087
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

Refer to the AMD processors integrating the NTB endpoints by their
EPYC Embedded 9004/9005/8004 series numbers rather than code names.

Fixes: d6dc5a7f8b06 ("raw/ntb: support AMD NTB")

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 doc/guides/rawdevs/ntb.rst             | 4 ++--
 doc/guides/rel_notes/release_26_11.rst | 4 ++--
 drivers/raw/ntb/ntb_hw_amd.h           | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/doc/guides/rawdevs/ntb.rst b/doc/guides/rawdevs/ntb.rst
index 99474745d6..37328cd9e6 100644
--- a/doc/guides/rawdevs/ntb.rst
+++ b/doc/guides/rawdevs/ntb.rst
@@ -41,7 +41,7 @@ AMD EPYC Embedded NTB
 ---------------------
 
 The driver also supports the NTB endpoints integrated in AMD EPYC Embedded
-"Turin", "Genoa" and "Siena" processors.
+9004/9005/8004 processors.
 These use a primary/secondary topology rather than the Intel back-to-back topology:
 one endpoint is enumerated as the primary (device ID ``0x14c0``) and
 the other as the secondary (device ID ``0x14c3``).
@@ -179,7 +179,7 @@ Limitation
 
 This PMD is supported on:
 
-- AMD EPYC Embedded "Turin", "Genoa" and "Siena" processors.
+- AMD EPYC Embedded 9004/9005/8004 processors.
 - 4th Generation Intel® Xeon® Scalable Processors.
 - 3rd Generation Intel® Xeon® Scalable Processors.
 - 2nd Generation Intel® Xeon® Scalable Processors.
diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 79994bb93a..06133409e1 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -311,8 +311,8 @@ New Features
 
 * **Added AMD NTB support to the NTB rawdev driver.**
 
-  Added support for the NTB endpoints integrated in AMD EPYC Embedded "Turin", "Genoa"
-  and "Siena" processors to the ``raw/ntb`` driver.
+  Added support for the NTB endpoints integrated in AMD EPYC Embedded
+  9004/9005/8004 processors to the ``raw/ntb`` driver.
   The NTB rawdev framework was generalized to support multiple vendors,
   with AMD-specific hardware access, a primary/secondary topology
   and a packed scratchpad handshake.
diff --git a/drivers/raw/ntb/ntb_hw_amd.h b/drivers/raw/ntb/ntb_hw_amd.h
index 48f0db1ad4..b03aed7d08 100644
--- a/drivers/raw/ntb/ntb_hw_amd.h
+++ b/drivers/raw/ntb/ntb_hw_amd.h
@@ -7,7 +7,7 @@
 
 #include <stdint.h>
 
-/* NTB vendor and device IDs (EPYC Embedded Turin/Genoa/Siena). */
+/* NTB vendor and device IDs (EPYC Embedded 9004/9005/8004). */
 #define NTB_AMD_VENDOR_ID		0x1022
 #define NTB_AMD_DEV_ID_PRI		0x14c0	/* Primary NTB endpoint. */
 #define NTB_AMD_DEV_ID_SEC		0x14c3	/* Secondary NTB endpoint. */
-- 
2.34.1

