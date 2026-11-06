Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D24D5606A326
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 05:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=GINcnRW4
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E208B40E18;
	Fri,  6 Nov 2026 06:51:16 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011045.outbound.protection.outlook.com [52.101.52.45])
 by mails.dpdk.org (Postfix) with ESMTPS id 0776A427DC;
 Fri,  6 Nov 2026 06:51:15 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i0wBqM4Diq7us4MnQVebOSjFqFTG5VA1rs3Jj39I+xjLhoinek/UNxn7bFQiGfq3dL9yuWTb9XFmDD6jwHXrB5Hui3aED+67nCjoRcRX6Dd0+jfV8+ac43bEtpQwEkZp62yVrCCDatawyfYa9Gahs+p18FTcs7NcaT9SZyWMKzGBb6E3y9Ob/HJB2UmYH9vbns7BRKA3pI2wYovuv1Poh0/J3ARfCtbFxHxHK8BPA4PVRxGm2L7JSq5kYN0ubVL6ffBBU+DuRoh+C0KVMWQDUa28P9MWyM+8oV0W9QAESxc97yOEFXzfpUaNlc7EoHWzeqXunlN8vlp3ES9GgRSNbg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YysTIHWvkpIVHf7Cz1DkYRpM7si3D90qfas9h6AqxJk=;
 b=nvmqUe/0/oXVNrIEGQgM1V5zxRsrdOt31qtN/v0kw0ja3z0NSsnXmlhinCr5z8DfY0aJO5KHI37VAaAUl6XTwiL087KLdcQylsfybYd7axIwEhA65yeJ23lNufJ/aDFObtVXEFUaU4Sy9xfPU66ex0EtXTvRttH2oG6hGTzOJEb1oB52BIuGdCFiyjiPlDuHPNMHv11ebD3hGuBCMf7T9k3duihOKgFfHCQBsQwYIhJZeX0dvXK7VtNXtb8kjN2dFrAalirSirXnHs3wgs0qRPXYg7y09cJgYan04rwLcRSc8CNun7Et0qmTqrNxp10+cjyWlBykBZ4RjwQc7QsMfQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YysTIHWvkpIVHf7Cz1DkYRpM7si3D90qfas9h6AqxJk=;
 b=GINcnRW4d9JbmH+XUP4o/WxjTSYivsusuI3LFbNgs7BCrSufaWcyTzZewOqSdpLc+ji9y3MNj5d8q6QlxKteg+AEPZgvnFuoBsQyhDdg1ZMy88YMFgHL4mGA94T43L/SW1TbspA3RZD4vVrL1V3VNv3GfcUsQ9o0Zig7kDJEra0=
Received: from PH5P220CA0006.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::7)
 by CH1PPF68E8581EB.namprd12.prod.outlook.com (2603:10b6:61f:fc00::611) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 05:51:09 +0000
Received: from CY4PEPF000392D9.namprd03.prod.outlook.com
 (2603:10b6:510:34a:cafe::3d) by PH5P220CA0006.outlook.office365.com
 (2603:10b6:510:34a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 05:51:09 +0000
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
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:51:08 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 23:51:06 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>, <stable@dpdk.org>
Subject: [PATCH v2 03/15] raw/ntb: fix memory window bound in address remapping
Date: Fri, 6 Nov 2026 11:20:33 +0530
Message-ID: <20261106055045.720805-4-raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF000392D9:EE_|CH1PPF68E8581EB:EE_
X-MS-Office365-Filtering-Correlation-Id: 02699aa9-92ac-47ff-5653-08df3bc9f4ba
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|23010399003|36860700016|82310400026|11063799006|261009223027099003|261026121527099003|261021121427099003|56012099006|261021123027099003|10067099003|18002099003|261102123227099003|22082099003|6133799003;
X-Microsoft-Antispam-Message-Info: wfOKdNEdSdiqyorjUaBJvtlPNyD8OX5vU1X0huODb4u+sB3aIAtIzo8bpKVLAFVljjvzuktybpM8zWTl67WVsGFqnXJ7/qnrxu43U0Ol3Ab/wmhUHj1+BOyJswfl742yAssefzlS7zs0G9sVPqtuXwc1Vn8OatBxhQc93TUtE8jFaVZaElpUBtL1tVnDDnSfqeLwRLjhnsjGcWnmG+d+3P5f5Akrmt2hjaxnATR+/VdWhQqJ8pb/WWdnyFNc2vux84uPyPr0PXTqq1teU5swfjFJgbWLaZRKLat2LOlYGiL9wA3iSMyZExGqZSDVZcDETsV8UgHNkSpNU/y67Mbrj/Cj1Jk0ZLcde8NBnn2Wyl/4qpMTSS3u997hwXP6O5CBa9lAZ/4OaMsHzHeLYF9rqBe0qgGuX2Op2XEj3lwtVQ7EJFyy41h3KO3k7BgNFIvZLylRRPNi/P1/G5lUWF2JXeowitXqQVWc4AbMN/IxlBIPsrzr41Lhl8KIetaDZd6kwTwJHYRHYcW3X/XpMav4Bfr5b8hS70uFYJnai/AO7Z66uv4UJFpvSjIiEXu1ijs2BTpQuxH5Qn47Ks5OxuTVlBPUMc0jBZq5pisJBKAwvklmSlNcBIw1f+3rGvi99W1RIaJf/D2+fQUCjOKL76KVBulifXNjkG7xqOr9vBpJ2o0/Mic/BOtC/DH+m/e2LuUZMhntOyZ50xmgYurlRs3SxA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(23010399003)(36860700016)(82310400026)(11063799006)(261009223027099003)(261026121527099003)(261021121427099003)(56012099006)(261021123027099003)(10067099003)(18002099003)(261102123227099003)(22082099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 1IA4TCHYcsW+l8nwoF/k0GA25tbvge/C5R+qv9htttAJa/aeMal/Gfw9X5WFqaiwcqUJj9UnXImyf9r3490Czuf/JyZOgyheIyYQElHXGYe+3i3ddOn+ITE8pNnVIC/myPrLey0GKnA1RblA2WkWEWptY0sHB9ChSA6MrfJOR/gS0PpACuymb07U5MiqpI7FzIwKaMurpv35VO7ezFuRwFBdDi5wI0OCVHNFs37cDWWRNl5NkTSbgpSp/WgLOyPaIBBx5+TIsdeGhaCns2HnlVKOZMLv+AcfVpzau6WprI2vi8fhw+wVDv24mCZFY65KKKnMqM9ZOaS7gZuSKQ6gC11aL2fj0wZ3p5QP0WACHeZwhcEsxPiZDPtJ1ytHjumnFVEttAxhNGwJwIKb2yJt9x3GIpVXdIvKZCJFCLZPY2SvhJ6tA1bdISIt9oLm3jC2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:51:08.9393 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 02699aa9-92ac-47ff-5653-08df3bc9f4ba
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392D9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PPF68E8581EB
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

When translating a peer address into the local mapping of a memory
window, the end of the window was included in the accepted range,
so an address one byte past the window was mapped.

Exclude the end of the window.

Fixes: 11b5c7daf019 ("raw/ntb: add enqueue and dequeue functions")
Fixes: d6dc5a7f8b06 ("raw/ntb: support AMD NTB")
Cc: stable@dpdk.org

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 drivers/raw/ntb/ntb_hw_amd.c   | 2 +-
 drivers/raw/ntb/ntb_hw_intel.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/raw/ntb/ntb_hw_amd.c b/drivers/raw/ntb/ntb_hw_amd.c
index dba5b03671..64075501c2 100644
--- a/drivers/raw/ntb/ntb_hw_amd.c
+++ b/drivers/raw/ntb/ntb_hw_amd.c
@@ -166,7 +166,7 @@ amd_ntb_ioremap(const struct rte_rawdev *dev, uint64_t addr)
 
 	for (i = 0; i < ntb->peer_used_mws; i++) {
 		if (addr >= ntb->peer_mw_base[i] &&
-				addr <= ntb->peer_mw_base[i] + ntb->mw_size[i]) {
+				addr < ntb->peer_mw_base[i] + ntb->mw_size[i]) {
 			base = amd_ntb_get_peer_mw_addr(dev, i);
 			mapped = (void *)(size_t)(addr - ntb->peer_mw_base[i] + (size_t)base);
 			break;
diff --git a/drivers/raw/ntb/ntb_hw_intel.c b/drivers/raw/ntb/ntb_hw_intel.c
index 78fce9ffac..47d5d39339 100644
--- a/drivers/raw/ntb/ntb_hw_intel.c
+++ b/drivers/raw/ntb/ntb_hw_intel.c
@@ -312,7 +312,7 @@ intel_ntb_ioremap(const struct rte_rawdev *dev, uint64_t addr)
 
 	for (i = 0; i < hw->peer_used_mws; i++) {
 		if (addr >= hw->peer_mw_base[i] &&
-		    addr <= hw->peer_mw_base[i] + hw->mw_size[i]) {
+		    addr < hw->peer_mw_base[i] + hw->mw_size[i]) {
 			base = intel_ntb_get_peer_mw_addr(dev, i);
 			mapped = (void *)(size_t)(addr - hw->peer_mw_base[i] +
 				 (size_t)base);
-- 
2.34.1

