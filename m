Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EB8606A33F
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 11:21:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=zKLkWb5n
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1053242790;
	Wed,  4 Nov 2026 12:20:54 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011026.outbound.protection.outlook.com [52.101.57.26])
 by mails.dpdk.org (Postfix) with ESMTPS id 05FF3427B7
 for <dev@dpdk.org>; Wed,  4 Nov 2026 12:20:53 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O1ValnvJxXcPKK64a6IHgMC85F0KCVk7E5eVBtU9a5BCDFw9IAWXrHGr2rBXExyjxMjDLI8gtie00oSDf+ZreW/Be0xXEpiAcU0XTAEyLRmzqE0swvvdsKW33AeyYuNl48rl/IPg0Fj+eJyZ/ceJ4RCa8ujGHjEvglUJHtrnuEmPforafcIP46ZUy0xyxtoSDyeoss9LKvfw/0txW9BpCezFoPtxYVaFp8IwF+MbBPmeYduOICchpZf/GP/VSuH01O0hyPmLw6CNR32V/aunt6GHGpDiW95EzOd4TZCTmSc50zjCdJJY6j2OGYXacXXSIhIwqriTncY/Ybc/LmHqlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwnRqIbYJxv425iOWAIEJKGZF39GWylhAnsKeKerHfk=;
 b=a2FdhOedst6mePL/rb9/R9LpMgttADCLW0tnAjyxicWXKQnrn1CcwMM/GGi33GUSAQYTe3c6kF/c329J8+4WF7fuFLH6eDuODnfbKbCd/mVRdtmuSk2P5MVOcI5lSn4bV86sRbvQUpC/l/Z6+LyNrS70alPA6r7c5yFnyeP66ntRhObOH08f6GA91P5/Evcyr7Z79qHB7CQ8XtMFpxQSJ/BTQSz8aA/+YLJKRIalxjfykH30nBDOvSOiPgqLGAFns+Oe//aRhCp6RcnNXq0LatJMziKeX11Dnp/XXod/gqczP5ik0jfB18vt8+h9PIwBBBqQWlqpJdeYIX8ncDIC7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwnRqIbYJxv425iOWAIEJKGZF39GWylhAnsKeKerHfk=;
 b=zKLkWb5nU4Zs9xwXluSJ7CckLg/kS88cRHhEe1q4Zr6nskvT2txTfegE+XRN/G0UseioMHSwUk4736kv9Pb+SpHFn8tXcDZ43it/IWZIuApnDbvFrEdPELVxJF16VdX4mpAOdroAFB8i+jcInCo4FenO1uTyXSb3jIwezVSSINo=
Received: from CH5PR02CA0010.namprd02.prod.outlook.com (2603:10b6:610:1ed::22)
 by LV8PR12MB9184.namprd12.prod.outlook.com (2603:10b6:408:18f::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.9; Wed, 4 Nov 2026
 11:20:50 +0000
Received: from BN3PEPF00022BC2.namprd05.prod.outlook.com
 (2603:10b6:610:1ed:cafe::35) by CH5PR02CA0010.outlook.office365.com
 (2603:10b6:610:1ed::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 11:20:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC2.mail.protection.outlook.com (10.167.248.213) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 11:20:49 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 05:20:46 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <jingjing.wu@intel.com>, <thomas@monjalon.net>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>,
 <bruce.richardson@intel.com>, <david.marchand@redhat.com>,
 <stephen@networkplumber.org>
Subject: [PATCH 11/13] doc: add NTB device info change to ABI section
Date: Wed, 4 Nov 2026 16:49:59 +0530
Message-ID: <20261104112001.661769-12-raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC2:EE_|LV8PR12MB9184:EE_
X-MS-Office365-Filtering-Correlation-Id: 3c0c1e22-7942-40c1-c192-08df3a65ae38
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|23010399003|1800799024|10067099003|18002099003|22082099003|56012099006|11063799006|261021121427099003|261102123227099003|261026121527099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: ls94nRYIrXpSg5aisJ6VXTtYPHQgT+Gz+gRnqw1A0yY0IoGmnGKa1mTQyhYi0tV6RQNAqWU0wBFBdEOiyTXSKhlye2Ie85QyyByn32haOo8oRDONedL7Okgd2IIyoFHewBtDfoMXSADqIIXHy9ShiPR5N6VIKppZK08hbKPBghuOzrDfxXebGQqDXSmnTcRujvUAo3BYmtVvgvb7GD9MlGmjX8DhypyTL8AcBYIsU/7ihJCpmk+DosWtWwL3Wsn4wjpwGKvPSQUcjgtEAKjyRVE5xQwGKCJnfhEfYwa/FPK2qOsguF7/b9sprQeGMKpJxOL5cF9lrHdWRHojUzDSONQi24knNlj9GqR5uPNFTBaJ7j5qkDkCq7thI+UfRnq4KFkMUijlficLzfynkBmI1X0SxgIgXKo/HgerYtNW1wXqy0cCJ/lEOh+WD6aZ6JeopzXLScIxKtp4YyRLiWN4TOka/W6KpjZYdlAzRCqRHdHqD+xvbx6HKKzGCr6CtHSU77Rd60PPViRx2geNlCcUFvVYy4N4tCEEYJ4tqSPk1082sFq9fEPpgBXo/J4qsqYaERvyET+K1V1a+E7qtCbwhjYAYlikV4tiYy5pI90tpOZcyt2PHZsW6s6klBgsokUwO7fgjAPdaKF7zUcLp1AniNECy1al6EMrld+4vRZSYQ84GYW0yqtmOCFJiRwm6L6do8pprIawM2To+9ESNcKyqQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261021121427099003)(261102123227099003)(261026121527099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: bsfUH5Ebo14fZS9fNxE1bpycelBCrkCoT/BkfpikyxGipeJUZcjgdgKQGwA+bY6SNT3+O5HwBQ1JXsNcITgahmsg3i4vwx4vVlmLJiUU0ssmnBAyLAH2vITvlHeqY8Gn920DPCl8aGhQCSe/0080GyuW3AvCmDbin1HlKY++5TqEWZNPeHlI88TxLzLJcuFK77aVk3ZbSV0318LtkwduuP5p82Ii1b0n0j10s45SFsy0YpGUhPResOS9BSIclHHfbkp+20kXotbhlwd+sht8Z5lNbxD6CZdigPZnpqxbHVUN+fCKgNEfc2J7YTu84lgG6Z3sRgVI3gUx6tzhd3cizMZqCT047TmdLBxTXe3F6vlJCGMj8ruexqmmRbbtTs9yEaFIDCS2Td+Dubx7octeeovdpowE5qhDtihEIGyzqqS1byKKjH3NYhH5wf6TIhGJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:20:49.8526 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c0c1e22-7942-40c1-c192-08df3a65ae38
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9184
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

Removing the mw_size_align field changed the layout of the installed
struct ntb_dev_info. Mention it in the ABI changes as well.

Fixes: 5ce50c234ad1 ("raw/ntb: generalize framework for multiple vendors")

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 doc/guides/rel_notes/release_26_11.rst | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/doc/guides/rel_notes/release_26_11.rst b/doc/guides/rel_notes/release_26_11.rst
index 6c76c60139..23980d5364 100644
--- a/doc/guides/rel_notes/release_26_11.rst
+++ b/doc/guides/rel_notes/release_26_11.rst
@@ -689,6 +689,8 @@ ABI Changes
 * cryptodev: The struct ``rte_crypto_rsa_op_param``
   was updated to include ``pss_salt``.
 
+* raw/ntb: The ``mw_size_align`` field was removed from ``struct ntb_dev_info``.
+
 
 Known Issues
 ------------
-- 
2.34.1

