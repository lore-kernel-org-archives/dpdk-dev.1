Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10FF2606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 07:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=I7OmuEpM
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E574C42795;
	Wed, 11 Nov 2026 08:11:24 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012010.outbound.protection.outlook.com [52.101.43.10])
 by mails.dpdk.org (Postfix) with ESMTPS id 03FA3410DF;
 Wed, 11 Nov 2026 08:11:16 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AXK2j4070/zAoXTfUuMZxCYScBID6En0RMROMaNI1xO/Ye1mCa7sIrzarxYOpu7xoirk9dZTc2Re+blpnG5iMX/9ECf9LckCbJoLi+qDwnQVzErh2u1AUCClJg5KMLtIherRn1ImawtJkou1esqxjPhyRrvDtuqeSEVGugk+WcD576nG+Tgj4UI71bFZMZe9KiGexM17IksNmZMWnJC3GrAbKmX8J7XfF8bVCRZS6zXdoT97ryhuBHUljFi571ldbEfU5T1QYho8zSiTWeGwqJWSf6+/lZO0sCmzP6adgTGvNxaKWhEAf43gMzxoX+647myPIS70nnlQ5Gm2d1ckOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iMquFWjx1vzBNUKmXoneOtgG9u+yT5ENDA+Yp/odiE=;
 b=y6sVdbSSxEGlkUqXQDWXJvhqfn0A3GBh2V2F+Pfshw3WLVJkewc6R4yNu/FOHS3xFCzPrUG6GI7GmVa2qBPF+B00+m7A9Z+QDWL4bkO3nRAMsYvN4CmL+tgPSIfyw4sC+AvkDCY+wPhYXTl7XbQJO6VV0XbKKNvtBCNssX+TWx1V9QBiAEcwPDiH8zBAHKNRpPf1kvgB69p1bRBh9AwzHXQC506yPbb+W8mJvcrU7s0/gZ9zvyPyJwPu1JCwwf1o+3UOISVsJqNJhK6A7mBmihNSMOmwysa0KsWbHKOz1Nsg8f+StVCfwid9YH3AgnF7nwP2xG7cIxXxHgwfmbFRAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iMquFWjx1vzBNUKmXoneOtgG9u+yT5ENDA+Yp/odiE=;
 b=I7OmuEpM3t8x7IqNbkC1z4TB3YhcGkO/lte/N+GqcDP08NeC1BYgT/5ENsiuNwltgv8ehvt+bHNax4MkZjYK6xKUykRTUGZG4IjPbYGnuQm4JcuoJ+Ka2v2CU1uvccPYO11Hacn5O1zgHkWh57ZwtIXcZa0zHCM3jNIxjYSSOwY=
Received: from BY3PR10CA0023.namprd10.prod.outlook.com (2603:10b6:a03:255::28)
 by CH3PR12MB8851.namprd12.prod.outlook.com (2603:10b6:610:180::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.12; Wed, 11 Nov
 2026 07:11:09 +0000
Received: from SJ5PEPF000001CF.namprd05.prod.outlook.com
 (2603:10b6:a03:255:cafe::27) by BY3PR10CA0023.outlook.office365.com
 (2603:10b6:a03:255::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 07:11:09 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001CF.mail.protection.outlook.com (10.167.242.43) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 07:11:08 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:11:03 -0600
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:07:09 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>, <stable@dpdk.org>
Subject: [PATCH v3 02/16] raw/ntb: fix peer memory window count check
Date: Wed, 11 Nov 2026 12:36:36 +0530
Message-ID: <8ccf3a86ed51315e37708946f4cdcbac168b5a6c.1794377833.git.raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001CF:EE_|CH3PR12MB8851:EE_
X-MS-Office365-Filtering-Correlation-Id: 57c2e10b-4101-4af4-0e09-08df3fc2f583
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|23010399003|376014|18002099003|22082099003|6133799003|10067099003|4143699003|261102123227099003|261026121527099003|261009223027099003|56012099006|261021121427099003|261021123027099003|261022075727099003|11063799006;
X-Microsoft-Antispam-Message-Info: 1nvFuZbw75fI8v6yylimR61mZ6P4cL3j0arxwsK135VveqY4/8S3Eodrll/2V89pqzIaZfvGgO81x6uyta0FNc4A1GvneOKu1XWDEg5uOWo+iMI6SsP3cZ0amtTHSfFW0Q5zTO2JLEBHpXTOQ9+eG+b2hXFYXTk46uIMLZP4KiF4de52EEhHan544eBoM70PPpu4NQV55uuRu3e/i7wof+mhmnnyvKlXMYZ1MmmLp/hZls1P5kO9bon/MjI6IYJPAZ0fChZoKFGCFzaPFMcwUUYYRDCHT0JtzqqQbUyB/7bWJ4fu8+O/RMxUUNL6u2wIUcGeOUI8GCgL1IkhXjtu+fc4/Sqkch8776gORzjEdECGUAJhgMdpQD0X+E2yyNhZCd/qc1qZgrj2cWPdE5DaHZjU4PBhpRQlSvStK9BFK0p9qgaaJZzbN4KIANu/wxfxLSv+8Z2amZmEs0wAzjkqMtSvVtSI+IZOWzJP7Po69mhMdl0X0qamzPOeO3kqetf9jbukxaa7wVrGvqgnqHCLzjKyRaCrQHJQVW3mLtxHRNL9KNB34iCUn/cnCQgpNACipm6LZV18kkMpwnUiZxL7HEfgzaK83ow14mReCGVvbsvA8jmKQVMOOn6L09/mJROixI5At5V/53cgO9rOlKbZ2tpADgjAQauI5gjUZSMsT5LLWd+e2F3wFVPsFN9LSp209YzD/96dPIqyTGsU720NiA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(23010399003)(376014)(18002099003)(22082099003)(6133799003)(10067099003)(4143699003)(261102123227099003)(261026121527099003)(261009223027099003)(56012099006)(261021121427099003)(261021123027099003)(261022075727099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: r474qd0obmydaeBkRvEordXBkNxsgT3s+Nv7wr4W6jcZ2LP4KCeArHUxMZx9oqc+NWM0gnEqmA78seqdXcC68nvGPBLTVjimlwvd6nE02LZBJy3dt8LAkfU/onx2TJ8EeehFz9qdpVp5lFyKUb+baV0Mq6FpVjFyC9aqaeP8wyL0anJLqGHLEDgNWezqesoSOWodKQRxW2J4XHHbh0uPdUa5bKr7O78E7b7PtTUKx8/8BeiDFM03smpaNMosefv2l6scAjYZYez5B6uEAk0gVKC8V0M26ORYhC89vVfl2vivCIILqZCbEro1yJf7iMrqM2tc8ejZWqMYEQABUL/iBBHctMKkyrU4+elRb2YEFeloyNYogg57uU0VLls/hh9L++fC4l51AgNemcq1yYZbGi4iJDZ/0udU/00L5jCNLccTbO6xpWICGEx+MmmGP9jJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:11:08.4472 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 57c2e10b-4101-4af4-0e09-08df3fc2f583
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001CF.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB8851
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

