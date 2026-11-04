Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86825606A330
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 11:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=Lm+OuLIG
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3C4AC40616;
	Wed,  4 Nov 2026 12:22:48 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013009.outbound.protection.outlook.com
 [40.107.201.9]) by mails.dpdk.org (Postfix) with ESMTPS id C72404060F
 for <dev@dpdk.org>; Wed,  4 Nov 2026 12:22:46 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Cl4qpAX9ZyOwWSW3uZOZAAsWzby6TUCdn5P7Bb/TNFq+7lmA3JynmjfYjR2VtRNJQNBbveLK1zbyO/6i903rJ3vmXn+PdFPnRkBdFt3i+MadmlTbn8ZYnJNMeVSIk5SKtQiqowXABsMLXoBrDFYvLhsi/GRUswLZ4P2vzYEvkpn2tHXD+P4oCZIePG0OSKCtW8wJ4AdzcXhly80e1Hu0BierO5+1X0NrGQwxi2MyVnbtelXK0W5bbO3v/ZBBc4slfajAwS788tlNYK1nSgX0YXUmjBnai3wramZhpYV87aapPjrqWZYVOsD71CKh+rcK5+kW+07qIXVdc4HGp6UJ1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uRPip9szR6uen6qFcykq8mtPXKI3Y7J34qq6o0pDYw=;
 b=CV59vWtQvujJTa1QtWtCkKt0dXZtcytmyskYwbp0aN38RtErOAflvCySoV4wfbmnbQWKm5VGzuy3dOvHVJ0aO0HQ9gMmheM6diVaDCNr1/FrLCS6HQ5KS9k1EgcwTZKaUzPGlz9PJOU6KAkdoAxCbJO9khqIMHF7xbmy6A/3E//DHf7NvKVfkNG12oi9MmkakGb1xIwdBtHkua9eigFCGu7CmdEgmoCIj13QhCH8isJGDqaDpDt8V7G4AHiq26rbzNi53CDZf+ZioJ6/LAWQrFvBgPHMeXU0zvRJZDHdNSCbnT7EA2YtTuSH1oYtnnPTGxf1uHTSyisy2NvcoYCWWA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uRPip9szR6uen6qFcykq8mtPXKI3Y7J34qq6o0pDYw=;
 b=Lm+OuLIGvN4uf2DNrNDq1Wxe5UZLfzxenatmq85Sx2XsTMZWIlEHQSosnjjFGGa/4k8oRPcsmMDlqrsYZVmwVwwVYHWsUZ8ldd9yYrmNlBgDxVVlTxAEGw67H4FvyRluF30bWnrzekS1R98jceI5tuqrM/fxMMUTW5W28xKhOfU=
Received: from CH0PR03CA0427.namprd03.prod.outlook.com (2603:10b6:610:10e::30)
 by PH0PR12MB5648.namprd12.prod.outlook.com (2603:10b6:510:14b::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 11:20:40 +0000
Received: from BN3PEPF00022BC4.namprd05.prod.outlook.com
 (2603:10b6:610:10e:cafe::16) by CH0PR03CA0427.outlook.office365.com
 (2603:10b6:610:10e::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 11:20:38 +0000
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
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 11:20:38 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 05:20:33 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <jingjing.wu@intel.com>, <thomas@monjalon.net>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>,
 <bruce.richardson@intel.com>, <david.marchand@redhat.com>,
 <stephen@networkplumber.org>
Subject: [PATCH 06/13] raw/ntb: fix AMD processor names
Date: Wed, 4 Nov 2026 16:49:54 +0530
Message-ID: <20261104112001.661769-7-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104112001.661769-1-raghavendra.ningoji@amd.com>
References: <20261104112001.661769-1-raghavendra.ningoji@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC4:EE_|PH0PR12MB5648:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b45bb3c-32ce-4f57-dff8-08df3a65a789
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|36860700016|82310400026|11063799006|56012099006|261021123027099003|261021121427099003|261009223027099003|261102123227099003|261026121527099003|10067099003|22082099003|18002099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info: n0Tx+IKD2i4OuvIxO4YTF2kyBkMhGzU3Lmo6HBX6C8I5WUBufXSHG1J3GlJC+Wb4EcNYKis2yxNTLfomovGHC30SI0XmEZUPdxdH4198qVJJDVeT9cXfgtJDOAKUjIdLJzmesfRbT5u8CET8V/L9q8k2EUe794Y2hj8AysQeppDLkW6j2049IEsz5l6hA+00f+sezO3HAD6I1/FyZ/YLdwEHHvrfEi8/AeEJ7YLRxVebufb2Vkh5KUIpUVzz/aJv0MXwU1Fm8Of9mKeFtg2KMmXIHwhw/kXWpXt9hWFgls7tINWJS0rzx4Cr5jeizA9AOISN5bDsSav5zjd4qAyakynoUSa15BDVBYT3xuZBwW+8Tox2hnyfNj4FSAbKo4a3j0hL4ieP4X0mXbfVNgCAqaTChwZn2eqp0lelnAvT/c9pvGw15XNdo10vdd63skPYR5mUVpXwCO0j7sK2sIxvwv/luZCMLJ/Wq2HCjNxGIOjspr1Vg2+9MhyDMsYkJFFVMiow8W94Tts21G7s9O1VrWqG3Mta4OPwrRQw1kZ/rZ4z72uMGf47oFK67Ydo/G2eYKEPNBqM7Ax2E+BW3KE8NMXOnTHQdXJZuJBMilULPqEiKFK8WqMpbvc5qqyS3rkxIt51neqRUd02+FdRBzjXJyCVoLCazIm5WSu+X03wnRn9eaFvbyhRsFRSdZNGmqxjCj3ZMVLbCAz/pHOT2sZwQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261021123027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003)(3023799007);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S1ccVsTsBpyqVX+e39ka2ySLvBrmQ3+zgrIuMYlmuaC9YMAUc15EEnTUJgZZsTUhEhkXiVFQKlTl8uPIP/yNQf4rMGCt/4bKwqeA+Z5Gi8L2QwVSK92+fOlPN0Au0Szzwq4fnMwCS8bWNxpMIFUIddgOXk790dKOa5vEKQoJNoqlTHpAi8rSejZoL9b4GTWU7z0shiP51LHILCX3JKgFeiE6Jc5sOiYGy2BXPnY8759t1zkEV6gpFrLSwej9yGCjN/H0VbFfu+CoN456v8k+u5c3V3zh1RKtZhJqf+8c3gNp3VXQnMr1UCNa99xZR+J7jnFUAN14qIcL4x/U0TGF0SeYT3AfYL5tllN+qsNFeRgdqmx9nJfCeV0qwFLMu9jukyCBZ01cjIDwqtuUYxpwUkOmzuXzDR6e+CssOc/Spb5gSEY/XppPP2ctbxQKgzHn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:20:38.6418 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b45bb3c-32ce-4f57-dff8-08df3a65a789
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC4.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5648
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
index 8ca8379cc6..6c76c60139 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -306,8 +306,8 @@ New Features
 
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

