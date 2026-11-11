Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E53B4606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 07:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=s6pkYX7F
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2698641141;
	Wed, 11 Nov 2026 08:11:18 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010013.outbound.protection.outlook.com
 [40.93.198.13]) by mails.dpdk.org (Postfix) with ESMTPS id 1B0124029B
 for <dev@dpdk.org>; Wed, 11 Nov 2026 08:11:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gu8AMcyaQpCMYpC1E2ZHcJoYjhBGIWQMsGN0S5l9wLxF8yyl2lA/KxIJenNMXktbwR+gjDL2DrQ9gjMIUwNYIXToqaoLlkM9KKKYZfpSF28R48+/LO6DNCgbIXSwy+yEhEstN/2CCI4GdRzugZRPaQKkfvbO2wwQI0k7N9cPlcpyGA9qWy/26vqYc4myYyFVEVamNhAyOVeZT2lQdcM6eL1P1IB+IfPX+RtFSm5UTR86u24JPnNKA+fQ5NYxU6DSsPpVtFf6I6fAn1U/0X8lImQN9Ys5tfmHrRBveGgnDBI2+tCxAYMz9E7s9xY2d5/1T99Pa5a66WQvGtMBvOvSBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=w3tUR6g+WoRn/Y0VVlRdDdSgq30uCSwHR4XtKMBV0qg=;
 b=iHiH5R7KQQJ/qmSRe3wGFkhHTUv09ZPWGl2ywqyMIEILhVFc/sBWCw0TkAlrTveoxtnmex9H0O2B8M1RRLkfzpMLLg0tt4NKFOoyyLQoundr8SEljiuumAJN8rIcKo+C2oHXmKQWlM8a2tAev6YRTEYBgyN8oMxb/cGsQ1VVHaJD9SWV39wltrg+l9FxGkj0Jay0ExDl9PUh2g5uHsOyh6mFUxXU1F5nQXkY3OBfnGgtxxBI62Wf2XZCBtI14Y8URSyghYpklBEiKNAn9Q6FjPexKzn0F0zY8S408jvyTARo3WurmdGT7dFrT94BKSpZk55efyPZ/nnGZE1CkxDlYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=w3tUR6g+WoRn/Y0VVlRdDdSgq30uCSwHR4XtKMBV0qg=;
 b=s6pkYX7F4YEw90Ln9mgxK9t7xAJQFbc+Qh0meEeLgpcSG5PxdP8Kg1ABYrJV+ewxW1SOFxJkN1sn+fjBMkUm0vAyUVSvHxOY9CAjHNi0lrUyaQ5Xsmfw+Bje2xli1DECYjxmKH0DW4oPDxRmjorqmiwuJep9A/53bQ7kn1rcRzQ=
Received: from CH5PR03CA0020.namprd03.prod.outlook.com (2603:10b6:610:1f1::10)
 by SA1PR12MB7341.namprd12.prod.outlook.com (2603:10b6:806:2ba::18)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 07:11:07 +0000
Received: from BL2PEPF000352D6.namprd02.prod.outlook.com
 (2603:10b6:610:1f1::4) by CH5PR03CA0020.outlook.office365.com
 (2603:10b6:610:1f1::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 07:11:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL2PEPF000352D6.mail.protection.outlook.com (10.167.254.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 07:11:07 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:11:04 -0600
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:08:22 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>
Subject: [PATCH v3 12/16] doc: add IOVA requirement for NTB
Date: Wed, 11 Nov 2026 12:36:46 +0530
Message-ID: <aa73dd87103c88f46addf27fe065408cee6e4aec.1794377833.git.raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL2PEPF000352D6:EE_|SA1PR12MB7341:EE_
X-MS-Office365-Filtering-Correlation-Id: f04f0368-7ad2-4a70-3773-08df3fc2f4e4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|6133799003|261009223027099003|10067099003|3023799007|261022105027099003|261026140227099003|261026121527099003|261022075727099003|261028144727099003|261021121427099003|261102123227099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: rgn+Yq+piIlQMkqjQ/b5wa/w4envh5DBKgyB8tr+9jMDluKFvH7LYQfDAQ3XwZ9Bv4PLMiB/p7Eb28fGVAAsXWkPGvH+78/HirvJWQ7K6HYrrr9yOsjaw+gYIGvBAt7IcSy1lAzbXwDBQz8DH2k4bSiVyDTBWxznWD5MDYHFwhIg1pV4mwcAfJL9sf6QtAwIBZHyzU9WaDftIIKp2yzhlQNXIuOocV7xZ+BZ0eiJYNo+fwZFJ/y8Aqw2KjJRhuJzNBX5Hq2CRvE6UHnkuVX0BkNSpV2jbsyeZumd854e0VU0blH6o2Qj1kE+AmhQZaW7BgTHYW8M4ZLQ/V4L8rzwQyIYNNS78n3ZNQz1tXvrGieEUp6Ru4QORGTfWwT1AhRyj98bMpff+cmWWsZ7fvLwVnEDgxteWJWBTlDVHDC+JTbZecz7WU3q3uOMetEz7Lxc4dU65qk2FjuKPKPDetSqPfJIhBEp+b2urdAJ2nf2FPDPdjmHSXg8HdcUizUqP3hcBs3tu5HODCXFgV/AQCtGuyPeBSbiorGTO0+FB7soV6njmRZ34kMd/1Wq+ibjMb1DaWUFTwdgI84klie7xLP4HepHCI3Y5VrUcIt/3EFVGAt6Q2KR0C1jeDfAzUZhKo2feOwOum1b7/XoUyJFeSqaBlwb62Jhf3OQuXGV5NzZMYrbBJElH4Yt3VCIPc/jz7tt3KKplNoQwU/oEvqG43xdlQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(6133799003)(261009223027099003)(10067099003)(3023799007)(261022105027099003)(261026140227099003)(261026121527099003)(261022075727099003)(261028144727099003)(261021121427099003)(261102123227099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: dR0MTQ6ez+PC2L3QcqB8Cuu+jBt3SMIft/NBv+WRLLbAmMFGZCpolgU1Y61Z3XPCpcZdHHOuwfFodDJw2kOsbYp041xcoNS2s2Lqy2xddIkvkyx7rblHDieMyh19L3SEu0ENUrOUaZZpobVBLIds9XWsAsziu1qMHobCUViz7zdW/Z8aIwaSqhAVdx2fNYJMeCTxkE1fVj8D+n7nRCjrW/ixlyJZH3ljx4LN4ZwUu+RRm2D9ZlRXohDrPivx/q7CI4aG9tHklXFzq9jsOPGXcRCPo5LP5RlVkXC/x5l3HShvhXrVQL85TD/cvuw2CHB6NBMFv55kqk+LPLI3UF51/lhNqgcbRQ026DhpPy3wYNFE2lN4gxpl1r/483xfqps/ERZJI9VTJdpRwVgutnSQ02np5hZ9C67A34srHyH/6xJmWmyo2Ojveyuf7ZSxQJzr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:11:07.4346 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f04f0368-7ad2-4a70-3773-08df3fc2f4e4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2PEPF000352D6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7341
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

