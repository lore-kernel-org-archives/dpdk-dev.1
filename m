Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0FC606A326
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 05:51:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=4n1hcMyF
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4C7BD427E1;
	Fri,  6 Nov 2026 06:51:15 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010038.outbound.protection.outlook.com [52.101.46.38])
 by mails.dpdk.org (Postfix) with ESMTPS id 54A574026D;
 Fri,  6 Nov 2026 06:51:12 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DNgS2MXrxIS1UlwEEQe4Zlzz2UK4HZ9tiR85G8o/fKyDoFbszMIqHr4dTnM171Y02lj6PbqjFnEVHAGDpNKye+qYI7rAdhTNv6rkqvVFlc4H3SrIX6S46lMe7T9AQQtDQUgjOpZ3h7yg/IvBrhAUZaBPE0N3DBj+pyld4hObyiROzkHzG4YRi5De4LJqO8s/oSWxdKHsdPYOmS4YkzfXBDqE8EPbgFMb5kcTg+f/Pxqlnk9b4haV/q9uoRKL600a12U2EmlBhsYcKESfkzmKPs5bMILqNuQwQeBueEmJb1EDMH9Ze4IZnaBUgi89U7KsAqArhD8r7ih0sxJXQ29ZDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iMquFWjx1vzBNUKmXoneOtgG9u+yT5ENDA+Yp/odiE=;
 b=T6Q7RYfSsELOBcH3Jz4uTxJM7ajqdSxoWgPmHAwZER7wyQ7YkFR6PHOSK/z+Gc9P7SdJJZcFamgW7i2RGpRtwLG5mO/6EEunI+vy/4lSg8gNzaIX5NrOAMggN3IylzDrvbENAHqW/mrN1UO85z9owCNLQ4MiBowsT9xdetTQXxZa+2IQo5ribOJ0W30DzwKgpRaxG3jV+TUEqTpRinC7y5DXk4uqwOcjGr8fyFNsTxTyh2/pgPSpei3qXS+2redxUHEYXVZqop/fvD2P7xwoNpbkflsggx7lfnaiQ5hNHvgsJD9XeVpDn9jF9W657RgNEMkiJ0cHR3M1NhsmDjBEdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iMquFWjx1vzBNUKmXoneOtgG9u+yT5ENDA+Yp/odiE=;
 b=4n1hcMyFtSZHZDcZzArkW4fMtpR1JZ8KUtSV761cp+ig/L2dxaNMiSQ6Xhas+AiTDBcLN5WKBX1Z1MNM+wF+IXW2Wl4sZPNxX1z0Z6PSt7zI8HtYUzu6m0MCTW5AvhzR1sVrR6QUeZoKSomcEc5LgBu68abwJUso30n0qF+IMc0=
Received: from PH5P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::9)
 by SN7PR12MB8172.namprd12.prod.outlook.com (2603:10b6:806:352::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:51:07 +0000
Received: from CY4PEPF000392D9.namprd03.prod.outlook.com
 (2603:10b6:510:34a:cafe::52) by PH5P220CA0012.outlook.office365.com
 (2603:10b6:510:34a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 05:51:06 +0000
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
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:51:06 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 23:51:03 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>, <stable@dpdk.org>
Subject: [PATCH v2 02/15] raw/ntb: fix peer memory window count check
Date: Fri, 6 Nov 2026 11:20:32 +0530
Message-ID: <20261106055045.720805-3-raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF000392D9:EE_|SN7PR12MB8172:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e11fb7-d9a1-43ba-129b-08df3bc9f365
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|261022075727099003|261021121427099003|261026121527099003|261009223027099003|261021123027099003|261102123227099003|11063799006|10067099003|22082099003|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 6fCpV/2mi8a1YipssHBIIbyfRKwZX/Ce9/TtTPB6tXNY/YtGgeitCn7DMHoAPmZDioHx7KcCf+4//SXYM3pEVUFJrzBvBKqpBQdXCzreY4ddjKpYoWD8qrx7TVzGMTRV9CLPAP9oEOLnPiTrtzacoelj+C7WkqFKHjL5l6nAYOPTnJOFnDmmzTt/MIzClu73xJAOug/kl9MZS2iWAqayt8+TBF+xN9HEQCxtWBsVfLPErzTfBHudi7wrmSaUWxJoAB/9gM36BvGCksXVbGGuxXM51chfgn6EdKXKte/srb9KlpqiGUyLg8zCdn8KKTxp/REMPBNNvafkR2eKKo+6ZkpyH3ZkvVu2aORwWL9ypjE9+QXMdUXsQlH94TcHWFeZK8gCVWyLnnyixbcqn5f5CWkiCYKGphasTGO1AaGQeISstkeh0HiYZZ/iVm84wDt/jufbzA+GHvFj8AN0Jg+1CYqvjUqYTTutnKqYjzTWrUyG7SgJEHdB9OmmzllBDj/uDK6Lp2dvwy9F/DM+G8xZ+m9sMTl7paLJ2TPNsaKlZSOTy1NL9IgJnlQDh3a1qkZS5gB4QrdBfKI6jKgUsS1rke03RJH/VLIgFB5wKNyiaBU1Jk+IfuCtWC1V7yoylYTx/JN2eAk/JYcpIs5+L9jBofxcUZWg+yGJTPL/bzkQ70G0o2P9bMBqgbev6LYzTAEbZwjJCyHmDT7G8JmvQuZ7pw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(261022075727099003)(261021121427099003)(261026121527099003)(261009223027099003)(261021123027099003)(261102123227099003)(11063799006)(10067099003)(22082099003)(56012099006)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: wCHGvW9qMk+OO1OBBPT/sjNZsTA05XMzGc6hgzlSlyhKATr1torcS+VMgSnYBSDgvFdhyHWmMvZZF8aupxQkrs16d9IiGQk4D5Zk3xG1KQimQOB+OIzJtOkE1rBegirPUpxX2G0JB+64cngWc6UKFFJdVvMurg/jep47aXIuBMFNr/gNL1/bo9Z4DGNguoiB133877jXVS1t/sfUSz1k+p2pKYKYK0FA1uJfmX0wnQ+CP0799xo4mV6tNAdnt5HDz/5r4CXzdt/Q2gbCj+f/NrXOKSZmlN3h2JtIoNgs1XDYmmzntjcIFA2BDXdbJamspmwbZoDColW3f5W/Q3aeF3KIiOByZa6dsmX9yWkBFTEpdBe2RvjXmzR2h8irja83hUygGkl2ab7rqFp8mdStjbIIji8uirrMCMOFZJ61DFLZwsKPzkRQSxQ8letDeFO2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:51:06.6977 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e11fb7-d9a1-43ba-129b-08df3bc9f365
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392D9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8172
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

The number of memory windows used by the peer is read from a
scratchpad register written by the peer, and is then used as the loop
bound to fill peer_mw_base[], which is allocated with mw_cnt entries.
A peer advertising more windows (bug, version mismatch, or a stale
scratchpad) makes the driver write past the end of this array.
On Intel, the 32-bit register value was also silently truncated into
the 8-bit peer_used_mws field.

Reject a peer configuration using more windows than the local device
has.

Fixes: c39d1e082a4b ("raw/ntb: setup queues")
Fixes: d6dc5a7f8b06 ("raw/ntb: support AMD NTB")
Cc: stable@dpdk.org

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 drivers/raw/ntb/ntb_hw_amd.c   | 10 ++++++++--
 drivers/raw/ntb/ntb_hw_intel.c |  7 ++++++-
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/raw/ntb/ntb_hw_amd.c b/drivers/raw/ntb/ntb_hw_amd.c
index ab78675218..dba5b03671 100644
--- a/drivers/raw/ntb/ntb_hw_amd.c
+++ b/drivers/raw/ntb/ntb_hw_amd.c
@@ -502,7 +502,7 @@ static int
 amd_ntb_read_peer_config(const struct rte_rawdev *dev)
 {
 	struct ntb_hw *ntb = dev->dev_private;
-	uint32_t info, peer_qps, peer_qsz, lo, hi;
+	uint32_t info, peer_qps, peer_qsz, peer_used_mws, lo, hi;
 	int i;
 
 	info = amd_ntb_spad_read(dev, AMD_SPAD_CNT_INFO, 0);
@@ -520,7 +520,13 @@ amd_ntb_read_peer_config(const struct rte_rawdev *dev)
 		return -EINVAL;
 	}
 
-	ntb->peer_used_mws = (info >> 16) & 0xff;
+	peer_used_mws = (info >> 16) & 0xff;
+	if (peer_used_mws > ntb->mw_cnt) {
+		NTB_LOG(ERR, "Peer used mws %u > mw cnt %u.", peer_used_mws, ntb->mw_cnt);
+		return -EINVAL;
+	}
+	ntb->peer_used_mws = peer_used_mws;
+
 	for (i = 0; i < ntb->peer_used_mws; i++) {
 		lo = amd_ntb_spad_read(dev, AMD_SPAD_MW0_BA_L + 2 * i, 0);
 		hi = amd_ntb_spad_read(dev, AMD_SPAD_MW0_BA_H + 2 * i, 0);
diff --git a/drivers/raw/ntb/ntb_hw_intel.c b/drivers/raw/ntb/ntb_hw_intel.c
index 1b784055ca..78fce9ffac 100644
--- a/drivers/raw/ntb/ntb_hw_intel.c
+++ b/drivers/raw/ntb/ntb_hw_intel.c
@@ -724,7 +724,12 @@ intel_ntb_read_peer_config(const struct rte_rawdev *dev)
 		return -EINVAL;
 	}
 
-	hw->peer_used_mws = intel_ntb_spad_read(dev, SPAD_USED_MWS, 0);
+	peer_val = intel_ntb_spad_read(dev, SPAD_USED_MWS, 0);
+	if (peer_val > hw->mw_cnt) {
+		NTB_LOG(ERR, "Peer used mws %u > mw cnt %u.", peer_val, hw->mw_cnt);
+		return -EINVAL;
+	}
+	hw->peer_used_mws = peer_val;
 
 	for (i = 0; i < hw->peer_used_mws; i++) {
 		peer_base_h = intel_ntb_spad_read(dev, SPAD_MW0_BA_H + 2 * i, 0);
-- 
2.34.1

