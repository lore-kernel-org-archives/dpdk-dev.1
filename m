Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66363606A32C
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 11:20:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=vxDOE8/H
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E911A40A73;
	Wed,  4 Nov 2026 12:20:32 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010063.outbound.protection.outlook.com [52.101.46.63])
 by mails.dpdk.org (Postfix) with ESMTPS id 12788402D5;
 Wed,  4 Nov 2026 12:20:31 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qUQncv0zQQslcggHKDOnjfHHMh+N7dIHHLAYoBW1tida/2pf+G1rZBdo7wcUpQBc2QHjXhgxHVdfsLCh1VNNhtuR0SIGNk3Iin70pR9SxCh4L+hVc7Vtf1FolRjWMjuhmPEXq/m4g7H2X+3Q5zchC4u8ERMQF2ym/12RsELnOZAli70ftira6vEaeocvoA+4+KVlRInvrcnZ1WduQxNnsuVBoNGeCQ54qBsEBnet8LbueFm/4SS7I4Y2PTEgigZuy0KlvI8p7qU/K6gUYSSe56MI0nin/1K9LzTc3vBnDvzg7OCvgs681ZsXMvlhgxN90xL8picH3oI68qnYC8mnEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6iMquFWjx1vzBNUKmXoneOtgG9u+yT5ENDA+Yp/odiE=;
 b=njw2Oa96raLS89Nw+4u8PdqgezmJBnbpGp/j3kddr6wMiHq6hgtN+cUSCQd+pJdIvAyDENMfdtKSqSRWX4qu6juDDzrL/yUeRd6M3o0OIQURYH13+mDKLPEGyd4XnTgj8gNBObT62oLLgyhLlHBO5HEADsFLQZ9AxkSutAzp6UHASvzf0EO+hdl+j3wWSM/a5cFfdleNKJ3GmaFtlQ+YAen9xkI0zXXFyvH3Uv5ewcfiYb7HqJPA3F9eYA77oQTvcvB71MeUR2a9jPTuJIM7ur0JqDl9DdkBHRq+do61yisLD2fYvCaMgc3KaNuqZ5OCXwhNgbZDYNjKdA2vMFzIVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6iMquFWjx1vzBNUKmXoneOtgG9u+yT5ENDA+Yp/odiE=;
 b=vxDOE8/HDBTIzcHv/8xtWDuXeZgtZ/F2CajkKr0H9e0qqo6cNS3Fd+3nnfj5EqoJgvjxsVEEJoE+It9m4nSYC7ByCUu0RINjfF3WyGK8JdZ0/x8c1UaH+1docO5IIHLwqfFcc8ZfHhwnVNotnDQGGZqKSBL+u0hWKCrEO5oEFXQ=
Received: from BN9PR03CA0484.namprd03.prod.outlook.com (2603:10b6:408:130::9)
 by LV5PR12MB9780.namprd12.prod.outlook.com (2603:10b6:408:304::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 11:20:25 +0000
Received: from BN3PEPF00022BC9.namprd05.prod.outlook.com
 (2603:10b6:408:130:cafe::80) by BN9PR03CA0484.outlook.office365.com
 (2603:10b6:408:130::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.569.12 via Frontend Transport; Wed, 4
 Nov 2026 11:20:25 +0000
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
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 11:20:25 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 05:20:21 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <jingjing.wu@intel.com>, <thomas@monjalon.net>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>,
 <bruce.richardson@intel.com>, <david.marchand@redhat.com>,
 <stephen@networkplumber.org>, <stable@dpdk.org>
Subject: [PATCH 02/13] raw/ntb: fix peer memory window count check
Date: Wed, 4 Nov 2026 16:49:50 +0530
Message-ID: <20261104112001.661769-3-raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC9:EE_|LV5PR12MB9780:EE_
X-MS-Office365-Filtering-Correlation-Id: a972599c-53e1-4809-8e13-08df3a659fac
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|56012099006|11063799006|261009223027099003|261021123027099003|261021121427099003|261102123227099003|261022075727099003|261026121527099003|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: GThFwDP0bfH1bDAGPpN0tWYOAdKOCYNOIezTQnuunEGQgJeZkVBfOlx+jXctBLg7rX15zLPSy15GQV29xFVppYNFlF9NNsUIdMH1iZUmHjgDBQ1SMnBOlUb4IXuIHPdyUceSmzWAKgDaCuaQ7F6QSaSra4V/pVdB4nYGYMtC6NT3MQvr1ioCFX9Mq+RMhRTFpEN1mgrQIkOoLGIjsLrgaxAq5AgxhsMypt+i6wj75XB71cfY0NqMxH/Krcwf6lu/biTDRMUoyP79dEpmDoRoNHFeJgMf2dDhrySUBvyHuEANmE27PamOM0qb02X0hdAvGzdFq0nRfdruhG0pVZWIgoX22kGITOUeYq6qR9O9gf/EoJ12jVjP7/Q48TUYX1oT1oaNZascjmnHIyQESRydm3BPa2T2MudwbIeNDda5ZskOcHRDmcDPzZe4ypTaosufWPfET6frvZZIFYwpzBz8YB/rdWJge9PmxVw2qdvC+nma3izHWR/djJm6JvQL3R15HSqlBNG6E1zjq5uoXt6rYW7elQTk7OBl30pu2TQHRwgpmyupovbA9UizEiwzK8Zs8l8xfqtO+wOFM9jY+9ydHDSiypmNhAOXjK9R4w+et46cLskgtiAvf1Zf2S5jvKj79v8JpOQEC+0bZ+5PO5Vl20oj6t1TNjvxSMpck0mpKXCxzCxEUhJPX7eblLZXS6IL6v0OJthanb7tw8bpLMS2TQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(56012099006)(11063799006)(261009223027099003)(261021123027099003)(261021121427099003)(261102123227099003)(261022075727099003)(261026121527099003)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Twx5T8EWfI/6PzGG+y7G4sbAelbGS+cz0BAlH5AK1wYQmKaEOjL0ybqwMALwwsz95GyqNCNmL/vLfZjTnDmEgDDg80sMXnd7qC2kearbiwehZ2r7IoSFaGQAc2Z7l62r8TrK246860+tDq0PlFfvASqb+0OM9j/+wlNufOkhhAI+ueXKfpolUpNJ5fyiD6cArhtqtV+8Zn5oPFWtaHRm/Zgo/J53xokblZmHnRfOlwCK+x0pUOE4YMT8kzPE0wpqLV2u3aZxpPNC3+rkv4B7Gyz3IVXk4yStIKeJ5C6vX/puP97XXQc3kYpqaYFCsrhg02MBLJ+QxTHyzGj2d2VlvnF4GMqBYbtEVPHj6QQS6b71qRqxTxP8z1IiP9yLkAM3LlEbNQKlHMyoueq5AyTkoHjhslKeS9fRaEJ8H13Yo9o+NC/4y9v2wlWkyXnaGPJX
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:20:25.4468 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a972599c-53e1-4809-8e13-08df3a659fac
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV5PR12MB9780
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

