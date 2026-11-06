Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A747606A326
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 05:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VKkwarN9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1E7F142D28;
	Fri,  6 Nov 2026 06:51:23 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012037.outbound.protection.outlook.com [52.101.43.37])
 by mails.dpdk.org (Postfix) with ESMTPS id 7B5E7427E0
 for <dev@dpdk.org>; Fri,  6 Nov 2026 06:51:21 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ATVvdf++We3URXuEj15oCq5uVVBh+vKAdYSRzBVccITnGWWaVjKa3u1dWFEyrOl/e8qgLsASswn/Dh09byd8BfM9xReBb3XZJuqmDwtzwB93GB2FS/xlZDDOXh+pwIye1DATwP1wcJu4Ss+IieSEzEkRswHbmWEJa8p3LEGsBaLILHRD2PFmdpoDV5s03iH0/ONGd6fQ+1X5erwld+NOq1ED5N7aW04NG2UlwiXlw6dhSIu7WTMtb70xous3P3PYPFmcnv2pfBgkRSZQsE8SAg2+aFS0HDOr6Ig3+1NSnpyfM3Ot1Opw991bSx7bL4b8i44rT79dJJf5ryhFduWufQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0uRPip9szR6uen6qFcykq8mtPXKI3Y7J34qq6o0pDYw=;
 b=a5ZiCiFZ1CCr74I96hHVjgbG8HiJ8IRd5HTOM84N4QxWXRoebEGgVdkQdssq4EaLdIiNf2P55deSvCtE3O1HkTX3yju79OjhHmf5AAhOqqCrerSvAkMKAyw3ha96HLUFOJQoo+pzOnfAg1JW5V/x18Y/U21ackXLhSBdFrTwzGhHLW4Cl5pnBZLMOXuYGdcFcM4hFmy+m6rPtKddK7JYuCCMhLaHUXMIhZ+Vmfn8G7ncfYAAjqtG6vdIIsegsvLHF7xc6z6zUEm5Ezo8K4l4BZGCWXMLQiYvmYdI6iTwd+gU4+qROhxV7qZN5dMu5MoRR1VW+NvBoURPB51ytzfmRQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0uRPip9szR6uen6qFcykq8mtPXKI3Y7J34qq6o0pDYw=;
 b=VKkwarN90Fuqn1fm1CYTCBcbfhKzHsqPZk59uYCc1awDb53DCw3BNzp67NzT0RF3PJMP1M0Q0PxOeWMZMEnw6zBT6+i7J7BDvIzLbtIYNcrlPtw4xh9im6ogs2aEp3nBCL9y4fe7yWcl3Vg9kfMSvYBPMzwKPRDQAmMLIOP5f8I=
Received: from CYXPR02CA0061.namprd02.prod.outlook.com (2603:10b6:930:cd::21)
 by SN7PR12MB7788.namprd12.prod.outlook.com (2603:10b6:806:345::7)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:51:17 +0000
Received: from CY4PEPF000392DA.namprd03.prod.outlook.com
 (2603:10b6:930:cd:cafe::1) by CYXPR02CA0061.outlook.office365.com
 (2603:10b6:930:cd::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:51:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392DA.mail.protection.outlook.com (10.167.247.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:51:16 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 23:51:14 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>
Subject: [PATCH v2 06/15] raw/ntb: fix AMD processor names
Date: Fri, 6 Nov 2026 11:20:36 +0530
Message-ID: <20261106055045.720805-7-raghavendra.ningoji@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261104112001.661769-1-raghavendra.ningoji@amd.com>
References: <20261104112001.661769-1-raghavendra.ningoji@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DA:EE_|SN7PR12MB7788:EE_
X-MS-Office365-Filtering-Correlation-Id: b950fc48-71fd-4687-927e-08df3bc9f93e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|23010399003|1800799024|18002099003|22082099003|6133799003|10067099003|3023799007|11063799006|261102123227099003|261026121527099003|261021123027099003|261021121427099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info: pHC64y2zafQlQhEP9ZR+3R6qVjAOPZIZGNT4/GXGIs0//gg1UyxW7QIpmJVzF9+cFo9/t282ZrRlg/a1YI+dW05GP+CGnW2E5kcz4NWLpHx/hoKh/P5m5f0aDsHUv5iqyEQjpRjDpxWDIyjK0zQI0s8LVEHpfyXS9sdeOqJgeAOp5tJJD7HGaaBTIV+yx9AD5kf3b6cZhfp/W78uImrGy5Kj5TJSNVB0I6XL6gPJOg67w6ZO6tuCQ9xu2FDKhByVtxVKpB71vLxCmCBtkq/ePC/F14cVHb2Vux4VpQoRicGen/xFiQMrYjys+DuxYb3SRule4FlZuiDOAdIU2q60KX81597R2Vf4avWS99+mUStdbaa0Qx0N6/JVpuqYOdd6bd/tfET9+GKJeBrIJdk88dv/u/j9fnXk7PlutwNdN4UmeRsZYInzgo5T9qiecPXPIqeuNSfZe8SVGboT1xFPyrjnjyVhynKsfocjyYF1hofV3qt+wFKRYDY9c3sAYPFIehLgq677ljsnX8VOAwMnKPHDFSC7mIbMS1PWJKbShFNgX/826OIUDo746qeOHjgBYje2ApGhPkdakRyLpdeQRtNalrAe81TeN99EeNjosUsG8b4tbazOyhXW+eIOmoMnX/Hu+OoxxQ0zRaJWiTOwzRXzyOK6p/XEp6sUloBUUTzaF53H6Trsv3BI+eQEiookfKu+lu7CK5/QuLD5KE0zPA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(23010399003)(1800799024)(18002099003)(22082099003)(6133799003)(10067099003)(3023799007)(11063799006)(261102123227099003)(261026121527099003)(261021123027099003)(261021121427099003)(56012099006)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Eb5TCByBCYJiJV2WZhLEZsDV8qZgKS7284ZLhB+u4NOVP822kGSd4Hu8aXQrl5VBkDFY+pWh/+J3TKdlrdCiXMKsacpUPpJIckQGU9sQbkDsp2JJ7DmzJDG5LkeKFa7kZhpWSX5dHvcDze9Ji9TofSbGEPL9CpNCnLYIiFaU0G+Mq0zZrDQ+V0F/LZsadWdhiuZfB00psK7YFkTsz9REOfa0CX8qrl1ds4aPfnJF2xrWHheBoRl16BLLJDRvvnrwwsdtQO9Ap3/kGUp9U41PDDH18ATMPNJvLoy8w4rtqv8M2VFZUOLbtPBkPXHw5tAcaLsmpxraTuGRzgQ6pKONwkIOgwCPP39YVPvKUzkss1e6Zzb9Y0mD+0yUsYR5T73w6diPq+HUwPbYXUNkzzBjomOFVgMwoTvFMnYRdmMJEEIceGns7AREsswIwQZsggid
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:51:16.5358 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b950fc48-71fd-4687-927e-08df3bc9f93e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392DA.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7788
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

