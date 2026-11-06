Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E21B6606A326
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 05:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=v62jRMt3
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2E37142DDF;
	Fri,  6 Nov 2026 06:51:45 +0100 (CET)
Received: from CH4PR04CU002.outbound.protection.outlook.com
 (mail-northcentralusazon11013024.outbound.protection.outlook.com
 [40.107.201.24])
 by mails.dpdk.org (Postfix) with ESMTPS id E8C0642E6E;
 Fri,  6 Nov 2026 06:51:43 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=L9UI6hsoLqZzKdWdQqERR9ZtlhV/QR1yhAXV4UPr/XgtYs2JBjatXkAu7uAIX9flOxgcefA6ySgFDEfNfUdZs+rgSDPDtkLdpAFUo7IEzEqolsrbbJl9fRb+ujmSU+cfeHUmqIeeVXRqulBEr9Q/ZfZm2AmY8YQXhQOVn5SJBdfD6A95BHX2g8VMRFqvdJkFWNtNjWalDeBpStGbzAeAI/ZDXkw5QbZ+pRkeb96kXgVrLIgjYeuolh9RwBL2X6ao+xcm0lR5wDGkLtxNR9JWoOGnk4G4FV27lMmWoRoMrJAt+juXBtxB2Lhre5WrDXW6wLYONdoOYQA03yWsmz0zbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7f3VsjOD709jbsrQ5lWdimHnab6ygZltnzuTP51Zl60=;
 b=xD3A1L4IiGpqiV7F5Gvqv3ddl+cUxmrGcy2BL3OORN3I9UZ33r1WeUegAifYmBlItOaL7rwqtu19Sx6p9nD+Eeiw+B+/qANgkr5OK7yxcX+LCBvQhpHExcZAONG3QRDD3YJH/uYWYjyjePeuNw2/bkWuftETZefh2FO18RpctlG6aUykTgO87429jpMmucC6+ta6zrjauFCkGWDdfTeZcYvAgk/XFgC097He/7ux6pvPEAJAISjX7EGas/Y0reII3vzcTkW/QeMl0DRhYfM3iJ3s/bYDH6zvbdlRjjJgYGJdIOjHmCUGGLic5ME9LXt8OLzLeU1QqH7qmVPRLZEV3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7f3VsjOD709jbsrQ5lWdimHnab6ygZltnzuTP51Zl60=;
 b=v62jRMt3U1Q05Xi6GMKbd51tKxAbwS3mMbBGbV12LLV3aLdlLXsS8o6Y748Po9eZj+6wg6RSMsCNdnbrvtdaOYWEKHjNSSmZ+8pHrJLRS6J09Zio+Na3WpE69Qitfw11o67bO4OJdltMa1SzQTHI5OaNhwxfOmLBdgPdI+hTv0E=
Received: from PH5P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::14)
 by LV8PR12MB9271.namprd12.prod.outlook.com (2603:10b6:408:1ff::12)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Fri, 6 Nov
 2026 05:51:40 +0000
Received: from CY4PEPF000392D9.namprd03.prod.outlook.com
 (2603:10b6:510:34a:cafe::ab) by PH5P220CA0009.outlook.office365.com
 (2603:10b6:510:34a::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Fri, 6
 Nov 2026 05:51:39 +0000
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
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:51:39 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 23:51:36 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>, <stable@dpdk.org>
Subject: [PATCH v2 15/15] raw/ntb: fix queue setup checks
Date: Fri, 6 Nov 2026 11:20:45 +0530
Message-ID: <20261106055045.720805-16-raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF000392D9:EE_|LV8PR12MB9271:EE_
X-MS-Office365-Filtering-Correlation-Id: 94ad785b-b9c9-4edb-7a17-08df3bca071e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|261021121427099003|261009223027099003|261021123027099003|261102123227099003|261022075727099003|18002099003|22082099003|6133799003|10067099003;
X-Microsoft-Antispam-Message-Info: LKdLZI88ubvBpGNL7DnhoSb/tQmuGD/rXqAv1Ulk/fqyMdTdePp3980KEP2SNuIhU/YW8pSAPDJ4mP76T/sNrwgYiP8NVNblUZ5nhLENKkt0v2smtYj/bIrN1rj16gsG9SUIf22iSwdztzKhKsfIk/lbsS77numYadkxzlEh9gpyyhQRpRwsP3hLRMPJbZp9p1310SjSaYwR0lqsq6ULRugKA3IoZ9bkfQrLQnfC/MLQ11CuRUyrIXu4baPtnX8Gu4wH1TxkkVh+UMEqJrK59taEkRX42jt5cuO0NPl1aUMJvK0czLuz4gWphgxOTRAd2xQTkMNztPR6YJX4zGZXkfXCpKTZoIhdILV0BaG9Qo7HjNnkCrXJGeyk1EiCUHeOSlUvjDOv0RKNPa8QhSWnAvrwoi6h0OAWgRc/M0t3thpAyZDCf+EGChCFDNiBzldKE/9nbv2Ie3ukly3QZXmD/IyZBbPUsKiaaijd0/KtcotZvBnwCQ8eAG1zTE/xPF8Uadi7ubr0P5DNB0Y5UgVBJmuHpnQmybZr50plbpnPivZE3e4XUFfQIGREkQuaEl1yDNdoTjkY1MKT24LC76yJGRcWzTMDPQ8RTDxENK9dEyJht2nqluvFTggQBtvKtsdWKXiM9Bn50PHGdmaBdnT7roHfrKX80qGI+xLClnA+h/SRSKBAd1w3gLAUP83w/xfuDDO5D+sB6dpp8idrxmVq5w==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(261021123027099003)(261102123227099003)(261022075727099003)(18002099003)(22082099003)(6133799003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: yoSmfz4FiKdlpYc4b8P5pNB31++Zs/TOk8t8fL520DuBqmBHYZ4Y0eZCDfH2bPHb9xRRbDcVTTGlzzuEe9Y1Kr1APbdu5h3YBBAqAYZ2DjbmS6zK58VD2TOAn2IWQW8oBE3V+/ZSazmVodkNdNsFXdNxNjN+lbj1eQT2k5hUJL+VpXRhkD36jYUgRtesC+vpAx+tBJMy63etXrsPTdvbtdDaypkd+Lsc6DSQhjqMaSilb2L75NSyieXz7vBUJ3HHwgKYBNFCY20HHbSVUmLSHfYg95ieBNtqdCMocJj6iCE5a+cqCdushe/wYrEesq/5zQ43mZFFVoiwaADm/ibHT62ByY+yCdzGvr9+hiDcrW0XuXtc0iYyBZPNudnMNn2Ic0k4xNH8J5rmWqwwTMVPvtJWR7R5LBNb0AHJvoJGwv02TvhIQ5WgmFh4c5XtdmD2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:51:39.7815 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 94ad785b-b9c9-4edb-7a17-08df3bca071e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392D9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9271
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

