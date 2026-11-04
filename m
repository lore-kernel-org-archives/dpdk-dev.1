Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF4E606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 11:21:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=NPgqin7t
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 16B26427DD;
	Wed,  4 Nov 2026 12:20:58 +0100 (CET)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013069.outbound.protection.outlook.com
 [40.93.196.69]) by mails.dpdk.org (Postfix) with ESMTPS id 2FFCF427D8
 for <dev@dpdk.org>; Wed,  4 Nov 2026 12:20:57 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LrskIhHG4qmozLqMTNfITeiXKrK18jArVB+qgj1uF/5vlW/EP9YuPIuebB6T2FhlJZtsuoEHZnuDRN6Z/6bB7MHMZAvbr1Fd7dWwFpfPMtuJs2KhYKWavht8QQ5Sa+7ZXd+do9k2ooM/C0+JLO69kJbwSLmcl51ZAx+kGAwMombkFDIeS4PNgUi9xT8Bn0rSj6pmmu9cLGMYvqAf6ofgo+U1UwnMQuu2adAxrqwlNWT00eENe/BdjzFnmkSowS60M3fhqWALc9wOPXQYX8Ka+2t3ZYsmuq4fpnmgLNAHles/Vrjld7pl6mT1KdwEYojRNY3yfnQTgfnfmNcYWhr2Rg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3tUR6g+WoRn/Y0VVlRdDdSgq30uCSwHR4XtKMBV0qg=;
 b=p15WtUbvkl/XxgHyOmD22q+R1pTLOnBURqtLm5+EUBodpXhHGmNWyYw6y2bMOVb2SPdnBOclt/UeQV3SrWwZRqhP5qjHDJNmpS1FRVi4Qv2ebJMAT8GJXwsxDnBdWxYgXJhiP/SitVzULdLpNDGJKkRJSonwVxu4sePMm8NaiCOT0r9pk9OMzlkTzHtS0z0W30BsVW7+KOUEEo/q6PYEwGJT5MkrCp304LIhiCBH2w6bu787ULgjqdDGbvyAPuKlIq/rlBJ93W/9cOXNsVk0c8kDuO58SV5mG4KYc1Jh0PrMse3z/P5wjSjhJ84S5ikuGpeitVQCrValqNM5TMC+Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3tUR6g+WoRn/Y0VVlRdDdSgq30uCSwHR4XtKMBV0qg=;
 b=NPgqin7tAxtXWMI8FXACTHRvI+huvApolczpo9dWdACcb+RQe/K+A2ZkjjPqjFQAE6jcSwC8/pIZLx9u7y3sorjMy+FH9LZys6H7Bs05qfL9W+x2gc4HItwSTHbgu8ATMLb8bceDgNeyW2YBn2/zRw6qWSXhCHuxDlDpYxD9LYo=
Received: from CH0PR03CA0263.namprd03.prod.outlook.com (2603:10b6:610:e5::28)
 by IA0PR12MB7651.namprd12.prod.outlook.com (2603:10b6:208:435::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 11:20:53 +0000
Received: from BN3PEPF00022BC7.namprd05.prod.outlook.com
 (2603:10b6:610:e5:cafe::9f) by CH0PR03CA0263.outlook.office365.com
 (2603:10b6:610:e5::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 11:20:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC7.mail.protection.outlook.com (10.167.248.212) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 11:20:52 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 05:20:49 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <jingjing.wu@intel.com>, <thomas@monjalon.net>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>,
 <bruce.richardson@intel.com>, <david.marchand@redhat.com>,
 <stephen@networkplumber.org>
Subject: [PATCH 12/13] doc: add IOVA requirement for NTB
Date: Wed, 4 Nov 2026 16:50:00 +0530
Message-ID: <20261104112001.661769-13-raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC7:EE_|IA0PR12MB7651:EE_
X-MS-Office365-Filtering-Correlation-Id: d9a69dfd-26f5-4f5a-772e-08df3a65afd5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|6133799003|10067099003|22082099003|18002099003|3023799007|56012099006|261022075727099003|11063799006|261021121427099003|261102123227099003|261026140227099003|261009223027099003|261022105027099003|261026121527099003|261028144727099003;
X-Microsoft-Antispam-Message-Info: di9xFahCmgp6IimM2JRURx6uoL9bNkf9ZHlCN+2/5rkA4HEGYoHnbQiYn9nP07ZpiQT+bn0cBIOzTICRXLcY0bXiIn1Uc5aiIh0gVfjutLdrLTwALdsChZ0nCZWPR4/Aug3UD+lnr2ozQvLEcqASkd0Z02TQT6+XksDSwjmia3DW8bOchfOAf2MKcbCaOX6lGc30iLIqEEf4YcSSehChigvpcs6c6ScwHrI/Aww8PIzSuEKH17WuriM1Lwx8He+DSTcfOce1X3YmwVcpk8gQBhHV/hj2ldg1jSKu7Kfc/GxIyo9bkOd7bmAo/jaEp+i5fybVr3lLHdhfYNFb0FRUmHLfw8PZqJn1Xm9wmfsPC2MLvwGg3d4ZsTm+8R1BPl7DBTitMW0gpjTjcT+GsdQ2wL16ijqOi6Y79o6iD1XROJ5vmJfnhOCeqdn6KyPDLdV27rOTjpevSuoRU9R17ZE8Q50zIdjCR8vYLHxYZNeUfFhYs7l9c26lY/P7kRw+DKJtU88dG2OBqh7cnp9Th21AsSIGq86DJb3UDqCpqFzdv3hPzqEwJfjddAk57MK4Aw2RsqgGNfDfbQXL+YWVPEJoaXhjzfznuZdqQfM5m4ke1/DfxiZikw+LJ0o1s4FVoCwN3Flrffco78Y7WU3kEj53qkF1PQFcVMVlkiKdZaTyqCgrM0wuU1OXjv7LYBbT3Gf0KBzq3YLRa0Y3MgZEH+dcig==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(6133799003)(10067099003)(22082099003)(18002099003)(3023799007)(56012099006)(261022075727099003)(11063799006)(261021121427099003)(261102123227099003)(261026140227099003)(261009223027099003)(261022105027099003)(261026121527099003)(261028144727099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jtJNppFTZ4jSF2av6jmwSS9CQ1AanG81BAT6Hk6PQjW4y8s5srX4lnznBparfaZphhMLTn9PeMUpVATJ78IndLGnGdVgapA/h72tC7uyMSk5tpFpYVHtqcm7X0no1ZR6b+nWrUy8EAyBSbWmkVcg2UXmppDsEOiCnq2HP21+RfQK++YNDf3qbG25P00DEYzkCENhVsLptqJWvcMKB5Poot7PXxPIlvOJM7CnOuIQw4J8+JXoggGrSbiA6Y5t2XVX6xwTa47WsXWbfMpsCUKgEfpJgm359v1uzBjNYyXLfP6yvGezifIUg5JInnnSgFrD6cuM+T0gsT99BPgO0hv7OEoxIG++uodlZC3IwLE7XCWG8K0UukiJgANeZ2ec4NUPHXV5P9q77+gtzKRyVEWDDS6CQVlT7dNxG2rAmTMqYITalAtdQ4SKpPg5ZB8sL03u
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:20:52.5577 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d9a69dfd-26f5-4f5a-772e-08df3a65afd5
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC7.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7651
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

The memory window memzone is reserved with the alignment required by
the NTB hardware, but this alignment applies to the virtual address.
With IOVA as PA and a memzone larger than the hugepage size, the IOVA
may not be aligned and the device configuration fails.

Document that IOVA as VA mode or large enough hugepages are needed.

Fixes: 5ce50c234ad1 ("raw/ntb: generalize framework for multiple vendors")

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 doc/guides/rawdevs/ntb.rst | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/doc/guides/rawdevs/ntb.rst b/doc/guides/rawdevs/ntb.rst
index c4ad2f05c4..8332c27de9 100644
--- a/doc/guides/rawdevs/ntb.rst
+++ b/doc/guides/rawdevs/ntb.rst
@@ -66,6 +66,10 @@ Different NTB hardware imposes different alignment constraints,
 so applications should not assume any particular value:
 reserve each memory window memzone with the alignment returned by ``rte_pmd_ntb_get_mem_align()``
 for that window and length. The ``ntb_fwd`` example shows this usage.
+The memzone alignment applies to its virtual address.
+With IOVA as PA, the IOVA of a memzone larger than the hugepage size
+is not guaranteed to be aligned, and the device configuration fails:
+use IOVA as VA mode, or hugepages at least as large as the memory window.
 
 Device Setup
 ------------
-- 
2.34.1

