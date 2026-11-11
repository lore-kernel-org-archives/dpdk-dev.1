Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38BFA606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 07:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wxiKhBlL
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A22E6410CF;
	Wed, 11 Nov 2026 08:11:26 +0100 (CET)
Received: from CY3PR05CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11013047.outbound.protection.outlook.com
 [40.93.201.47])
 by mails.dpdk.org (Postfix) with ESMTPS id 947C9410D5;
 Wed, 11 Nov 2026 08:11:14 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=aZlsC/fR2SugHiD8c48lxGxZmquE8FUD9Fi6Up4c1EufcVp2pU6PpIHIYAZXp7uyrulRzVzjxVXKOZAdPBqBexhD1KR7vykrzSVYsjq9niMmGtwyxr/AG5i6TNTXUH0pK/FRUhE1zy0PvRzClyLfxZZBFQVWCYdba2Qw3v2teWjdJN04H2NEs3ApHiireuOaGn9ajoRJmxK0mVmxPS2wgH8Vkfi2iO28K4wPqlXOmGXwseQ7N6C7kWnOMv7nJdflRwafpxTPOUV6SdnefRcjm3XUCy0qu0Ssz6IV45sGiRl67ShCXMDa1L6V/KDgUqYL2yq1SQLHra3KyAiPDjsZaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7f3VsjOD709jbsrQ5lWdimHnab6ygZltnzuTP51Zl60=;
 b=VM2UUeWp99xcxrpGZ368Mra/aotNlelMTJJrMOq7/QSRDrSBdHpKIjeJxaWBo/U1vWVJwVbx9Lu22530msE8c6mOOwg0Otr9EqLW+w2IoxcLYdrp2oKq+mWOnPhNp/5vVGHTFgmE6/f29TSp/Z+mp+4INKXOIIpi8QLww8lkl5utvWMq2CmkHy+SxSH5GW50IoAQzpMW+TpCLRglo3cUHFBefxnkgqxCqE5BeEe9lLh4Yf/vejOhbThDUKYjbUb0R1M2Ts0VRBs4YWekygzYnvcCJJLmC7ccrGjy0beZppiiT2fEE32AjwYgRCi9QxX5Eijj13ldIXNzPk23l4pP1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7f3VsjOD709jbsrQ5lWdimHnab6ygZltnzuTP51Zl60=;
 b=wxiKhBlLM461ydVD0nRbwAb23utdufs4eKgR9OajfE1LXY6cVhJdZz3QX3XbBTVJ649uyz0sZ510AZUW8+YVP3Z8C6oUsN4cEln2LQ1dB2LOf1dWxiPZsyL2qwpQWG49t5BN1WrlYAe1B1lhIKhK1RZINo6FZ+KEnJ2XE7qGj9A=
Received: from MN2PR06CA0019.namprd06.prod.outlook.com (2603:10b6:208:23d::24)
 by DS4PR12MB9769.namprd12.prod.outlook.com (2603:10b6:8:2a9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 07:11:10 +0000
Received: from IA0PEPF0000003F.namprd04.prod.outlook.com
 (2603:10b6:208:23d:cafe::78) by MN2PR06CA0019.outlook.office365.com
 (2603:10b6:208:23d::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Wed, 11
 Nov 2026 07:11:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF0000003F.mail.protection.outlook.com (10.167.249.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 07:11:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:11:04 -0600
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:08:29 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>, <stable@dpdk.org>
Subject: [PATCH v3 15/16] raw/ntb: fix queue setup checks
Date: Wed, 11 Nov 2026 12:36:49 +0530
Message-ID: <839269cbd16a84f912d6d11a26bc257df5b75122.1794377833.git.raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF0000003F:EE_|DS4PR12MB9769:EE_
X-MS-Office365-Filtering-Correlation-Id: 1370201e-d2cf-4fcf-dc32-08df3fc2f6b0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|23010399003|36860700016|6133799003|261009223027099003|10067099003|261022075727099003|261021123027099003|261021121427099003|261102123227099003|11063799006|56012099006|4143699003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: gvic9ydd0f5L+SHOH01t8LijJia++vB2PhOT2EIfy1xSzNBdKDLtb7RzB/m0dquwDxXTGczso17KiIhko1vnbh+uT14zGJ9HZsn4FSW+NVStaHfTLAqcvEAd/X4t6QOjYFNGh/WEWOhrrZe/7SEQtXL9I5KrT8B3CoWs74EcXhpVZWe/bCkA8APtIT8GZgUvWYVa062OHhIcIlvdnPkKCvAmnYbXNpdUNNAqP5zuY6bCf5zXBLndnMykscgt0PJWI/VbfOVVsFE/i4r9ASDokzyj3dLlW+sQ7XHL4U7IoXHKc9+8KJcqq5e1vjDCPgHjnuuhkBmbGIQdHu5Ha/42X7HrrzOfbmZcN35y7f/8z/IdxCa3Fgw3b8PDFaSgg5LuQmdvV0L9FrOPSYf20c+3TLJS6eUxrLBk3e0w/pFo2YJJKNJatvYZAgm+5O0Ydph1GqTQ6wsKOGWS4uEH4XtUU28sAqeqwoqWU6QIuLHnq2+BC9aTNNB1zCgPW6duPvKfm1+8o3HBwodLhrKc7nvAfOzVbzba6wWrxiI/x3qcYMZE1OQdyzjrRKgzBJgy9S8bQEt6eI5ZW8aQCErGzzurXN9TSwN9+6bquXFP3BMUENy0BI/04aNKW2V9jwvF9bT5Tw4zIeNeTmTdBRgWKFSbrD9cj+GALrPfoqSpy0eNDkL64wgLmtbycmk5t7mtfGFyNutzeJ0+WCioqY+4e5g0vA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(82310400026)(1800799024)(23010399003)(36860700016)(6133799003)(261009223027099003)(10067099003)(261022075727099003)(261021123027099003)(261021121427099003)(261102123227099003)(11063799006)(56012099006)(4143699003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 3t0GQwGcjuW6fzelzHz6IHAbjxQp86nvi2xnfXQ3GXWCCuNx11uv4667/ucVISNH83xQOIwnefvZyfyMlIka++/Y1C0oEeqio1IA0gO4CSIA0D7MRzKaQZqn3+F8T3ozqomSHfWqk6r7vfMeWv0Wxl/xLmQvsSdKMSktnz7k/ViErAi8JKarOYRKLCiMyFDnzGVQ83YH1BCn+UtOwJQp71jURtozcGfl3k4mV//y8cmFT7GbUhMG606kIlgiZUznP7Pn5EWH3NBBm0h396I5pAsAcdtko5ztSR+zGKCMhVMLjOQQPWZ6u1BsDArlG0OEdsjTyaUqiEExn5lIMzLTr7jgKVpLephEmuvI2eRq6mXrWuJf7Y1JOlkvke8oHpdqkb0tPL4pLwVXK/jI+3mEkQHdm5UtuWHJqcd4A6SrSJAws/oXyqJc7g0sZBZwG2ZI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:11:10.4516 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1370201e-d2cf-4fcf-dc32-08df3fc2f6b0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF0000003F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS4PR12MB9769
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

The number of descriptors given at queue setup was not checked, while
the ring indexes wrap with a mask, requiring a power of 2, and the
burst functions use on-stack arrays of NTB_MAX_DESC_SIZE entries.

The Rx queue structure was also leaked when no mempool was given, and
the Tx queue structure and its ring when the Tx free threshold was
invalid.

Check the configuration before allocating the queue.

Fixes: c39d1e082a4b ("raw/ntb: setup queues")
Cc: stable@dpdk.org

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 drivers/raw/ntb/ntb.c | 51 +++++++++++++++++++++++++++++++------------
 1 file changed, 37 insertions(+), 14 deletions(-)

diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index 86405ad57a..8b1c332fbb 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -246,6 +246,20 @@ ntb_rxq_release(struct ntb_rx_queue *rxq)
 	rte_free(rxq);
 }
 
+/* The ring indexes wrap with a mask and the bursts use on-stack arrays. */
+static int
+ntb_queue_nb_desc_check(uint16_t nb_desc)
+{
+	if (nb_desc < NTB_MIN_DESC_SIZE || nb_desc > NTB_MAX_DESC_SIZE ||
+	    !rte_is_power_of_2(nb_desc)) {
+		NTB_LOG(ERR, "Number of descriptors %u must be a power of 2 within [%u, %u].",
+			nb_desc, NTB_MIN_DESC_SIZE, NTB_MAX_DESC_SIZE);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
 static int
 ntb_rxq_setup(struct rte_rawdev *dev,
 	      uint16_t qp_id,
@@ -259,6 +273,14 @@ ntb_rxq_setup(struct rte_rawdev *dev,
 	if (conf_size != sizeof(*rxq_conf))
 		return -EINVAL;
 
+	if (rxq_conf->rx_mp == NULL) {
+		NTB_LOG(ERR, "Invalid null mempool pointer.");
+		return -EINVAL;
+	}
+
+	if (ntb_queue_nb_desc_check(rxq_conf->nb_desc) < 0)
+		return -EINVAL;
+
 	/* Allocate the rx queue data structure */
 	rxq = rte_zmalloc_socket("ntb rx queue",
 				 sizeof(struct ntb_rx_queue),
@@ -270,10 +292,6 @@ ntb_rxq_setup(struct rte_rawdev *dev,
 		return -ENOMEM;
 	}
 
-	if (rxq_conf->rx_mp == NULL) {
-		NTB_LOG(ERR, "Invalid null mempool pointer.");
-		return -EINVAL;
-	}
 	rxq->nb_rx_desc = rxq_conf->nb_desc;
 	rxq->mpool = rxq_conf->rx_mp;
 	rxq->port_id = dev->dev_id;
@@ -340,11 +358,24 @@ ntb_txq_setup(struct rte_rawdev *dev,
 	struct ntb_queue_conf *txq_conf = queue_conf;
 	struct ntb_hw *hw = dev->dev_private;
 	struct ntb_tx_queue *txq;
-	uint16_t i, prev;
+	uint16_t i, prev, tx_free_thresh;
 
 	if (conf_size != sizeof(*txq_conf))
 		return -EINVAL;
 
+	if (ntb_queue_nb_desc_check(txq_conf->nb_desc) < 0)
+		return -EINVAL;
+
+	tx_free_thresh = txq_conf->tx_free_thresh ?
+			 txq_conf->tx_free_thresh :
+			 NTB_DFLT_TX_FREE_THRESH;
+	if (tx_free_thresh >= txq_conf->nb_desc - 3) {
+		NTB_LOG(ERR, "tx_free_thresh must be less than nb_desc - 3. "
+			"(tx_free_thresh=%u qp_id=%u)", tx_free_thresh,
+			qp_id);
+		return -EINVAL;
+	}
+
 	/* Allocate the TX queue data structure. */
 	txq = rte_zmalloc_socket("ntb tx queue",
 				  sizeof(struct ntb_tx_queue),
@@ -383,15 +414,7 @@ ntb_txq_setup(struct rte_rawdev *dev,
 		prev = i;
 	}
 
-	txq->tx_free_thresh = txq_conf->tx_free_thresh ?
-			      txq_conf->tx_free_thresh :
-			      NTB_DFLT_TX_FREE_THRESH;
-	if (txq->tx_free_thresh >= txq->nb_tx_desc - 3) {
-		NTB_LOG(ERR, "tx_free_thresh must be less than nb_desc - 3. "
-			"(tx_free_thresh=%u qp_id=%u)", txq->tx_free_thresh,
-			qp_id);
-		return -EINVAL;
-	}
+	txq->tx_free_thresh = tx_free_thresh;
 
 	hw->tx_queues[qp_id] = txq;
 
-- 
2.34.1

