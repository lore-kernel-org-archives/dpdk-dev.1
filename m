Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E86606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 11:20:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=F3Ok7i9W
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E560D40A8A;
	Wed,  4 Nov 2026 12:20:34 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013067.outbound.protection.outlook.com
 [40.107.201.67])
 by mails.dpdk.org (Postfix) with ESMTPS id 2F0A840A77;
 Wed,  4 Nov 2026 12:20:33 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m/GCrhOJ2Ah/piArIw8KZ8mG2T2CBgmYPtJN1hnTLi4F04CgXFNXRCvrZfpWmnoWe7/pyQ1MLYENVjX4H9jHuOeXtCRRTUnURUjQkpEMSsdlnXBkWmQSC88ckvuow0U2qIQvFDGTd8IS+F7fEtUhPxYsBkeGmHFfcZwF5Zy1HATZ8FwVoeRKiS2135e8IxHJui+7wHxuACrinAQzH+wrkg4D+ym4BctrgmmfoYDDZ+xI8hv7SKijykcihLDfGccGdlpi/crogZNnUrdjdIx0TVscPzmuw9u0jOjTj3jpLoiVsWZJhfYgGc4uVFsh+PdZOpwzRHzSbIQQ/NMjgChheA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YysTIHWvkpIVHf7Cz1DkYRpM7si3D90qfas9h6AqxJk=;
 b=MFnINSeFAm0oWEBvXUBDIjjzHqLVHvJ4VCS6RdYbCHU9UG0jvQ9eNknKXSfR/X62tyHEE5xRNHSIgc1DAkVQImp/NktlXkOwxOPlYkavdP+DQUrexw8s3ssf/mTIEVaTmkpVSjglbsecaGXYDQN1MIAklHlj5HGOzUjXnYOh42Iot2EMS6etZqGTwR7p476KWYiYTnf8mIjuG/ld54LGfvNNrE/BPITNT/OPIMpGAKT7c50l+gpFM4KN19MxWfGT37DxtbKMPzDg8lqxVCfnuzb8xv+Zpo2nAZesBGlMwtTJoVHHBNtSqg9aRLG9dFg7hs0XlZKGWmozwmrUOt0bQw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YysTIHWvkpIVHf7Cz1DkYRpM7si3D90qfas9h6AqxJk=;
 b=F3Ok7i9WfBNhC39rukCZ77ZcOfCBOi+0bvtcNLgix3iKAeb5GKlvw+SehZD2Abi51F04Z/i0+fLa8UT9ODz7Mzx9nNRS5av71UHDJ5bpSUP7LJGYUbpoaOK0FkXqDnxg9CdKXuJYs5IS+7J5E1Ho8zjOMXvEyUkjUe12QRiXWRk=
Received: from BN9PR03CA0503.namprd03.prod.outlook.com (2603:10b6:408:130::28)
 by CY5PR12MB6204.namprd12.prod.outlook.com (2603:10b6:930:23::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 11:20:28 +0000
Received: from BN3PEPF00022BC9.namprd05.prod.outlook.com
 (2603:10b6:408:130:cafe::94) by BN9PR03CA0503.outlook.office365.com
 (2603:10b6:408:130::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.8 via Frontend Transport; Wed, 4
 Nov 2026 11:20:27 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC9.mail.protection.outlook.com (10.167.248.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 11:20:27 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 05:20:24 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <jingjing.wu@intel.com>, <thomas@monjalon.net>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>,
 <bruce.richardson@intel.com>, <david.marchand@redhat.com>,
 <stephen@networkplumber.org>, <stable@dpdk.org>
Subject: [PATCH 03/13] raw/ntb: fix memory window bound in address remapping
Date: Wed, 4 Nov 2026 16:49:51 +0530
Message-ID: <20261104112001.661769-4-raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC9:EE_|CY5PR12MB6204:EE_
X-MS-Office365-Filtering-Correlation-Id: bc11552d-9682-4f6a-1499-08df3a65a0fa
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|82310400026|376014|1800799024|23010399003|6133799003|10067099003|18002099003|22082099003|56012099006|11063799006|261026121527099003|261021121427099003|261021123027099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info: pK4OseD+lIGzRqxEA8GQo0f34RrbBXgb22F9RBuwTL3jJ6f3qTCzHoQmxMPNvzt1dqwp/V8F8Gkf4x6qS9t1twBnlxG60A2fvELDXxB6LQKtKkwj8pRuHWsJCwmaJ6t/2irHwy1+SZUPpfpTvynWXAp5Bk1zTcOK6seKds8MNguf594k5BmleiaeLvaHu8IbMRsJuKT5EZA/1CYKY6y0x5xtMDeqQ62MX1dTo0WgT9gFgzkIVfpO+nMGYvkyLrTUkGdS9+X1wVR9cy/T9izXepw07t/rPw4i2xR/DUejSmwdeXeae/qE36H3u6j5JBmUreOQ54giKJaWewZE5FNFM80OJDb8w3Dk2k63YknpVtsUy2RGto0yMT2vbnSLFqie+h7UlCRJTEBNdLBuv1VtOsFX1t7MVUfcZdAy7Gi5dX0m91Kw5PXdSSQIfzS1RGd0XXIKrgTe7+05kSAGAp/wKHV9es0+PI4jlAgtjoZr25VxAJ0zNWBVCs96fNS55+i4B1WZ83DGCqGb/n0EBw5LlXVHVLuqIYlZV7TEiePy9aXxbR0HbeWbv+9DEKzNokv3dmBp2Qerkwi7Kdu1n0Vopwspx/5ypAxeERNWgmkwAhhl+ihRjDU+PMkgAj6RZAz6YP8Go8cp3ruswbFd2GkBEvw/irfJRsohwdY+9F8xbTgINOFc0pv6luWEsDfY92QpYTyTsrYqSb8H4xm6ar+7+A==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(82310400026)(376014)(1800799024)(23010399003)(6133799003)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261026121527099003)(261021121427099003)(261021123027099003)(261009223027099003)(261102123227099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 17GTPgLULSQ8exmUtZbIITt6zy7bgDBNDyovpz9icHt2qi5ePGYre0MG+VgzIShCmo+OQiCBtxuwsei+Rm9fp7e+IjPnVbfMnzPbmUCNirhEicDRpcdm0SlrM9N9sdVDW6IurD0ANVuoY6zpsOfN1fQs4LcWLcFIOgmu5pTrccUweCB9krNgLBOdEaJ66E7WayDrq9Het76Wmu7JYDim+l5zEX+XfQlVP89lp1fSffWJlnaz4hMlYpd11IYOtBJxSnSiCin4fXvXuPpv0B12QXi2Kp1yJBHwkrn7wHtP7vIy7xYe3nA5WZQANtoAuqc6OahKj0QNkWaNZ+w75AWDkrDhZcLYs/5XkhfOGI+wlwfWEGutrkdxfQiQ223O/Ze+ybkVMs0Q63ljQdKBKTFVUBQK1FUVPhpTOgDlPGyWbVAUSf4F/1lixymqjUJ8xN5r
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:20:27.6320 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bc11552d-9682-4f6a-1499-08df3a65a0fa
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6204
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

