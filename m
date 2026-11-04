Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CEA606A326
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 11:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=y54cq5Ge
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5363341149;
	Wed,  4 Nov 2026 12:20:37 +0100 (CET)
Received: from BN8PR05CU002.outbound.protection.outlook.com
 (mail-eastus2azon11011049.outbound.protection.outlook.com [52.101.57.49])
 by mails.dpdk.org (Postfix) with ESMTPS id 7516E40A6D;
 Wed,  4 Nov 2026 12:20:34 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=cWJPr/k/gahCoIe9x51rDByYMJ78hGixAFTk8jxV+aTaQHpp4zhx2/Uv94p29koBMrOFTPtE2+Acn6PtiFyXBhL9R4gSN8NuO012YR0pcYXoBQWG6MYdusQg+ewD1X9KLxC0pj3ejO3UvUWReFy/U5PCqwhNPQK6FDe0sB6EsvXuzheukwOfqipTyXpwOhq+gSc2F/5pMfn48phQriyY3B5+SqzYWxnuetZ/EWgqdDbZJ3PIEZecPmGLVqzUXpaJyT89UPn52Yg4Mu7ctnwX50lBjJSArd+N1t8aSGv0I9yznyG0LWWUFPZNiKcDrISKge7FkhpbNG7yOxGMTf9+Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EKLIBAHaZwkMCfw6CMRwSgA/a4mysxJIO8ceEKp2Djk=;
 b=n7ei5ZYNgbvcdPVK7fzWXg0GzVUtiWmJ30z6fWvNT0T1qwtkmpbgoQn4cvEMCd6+gHc6+ZmyavTbOvXorEkTwPT9/BiVfQ3BOWr5aKd52KV+LkRaMt3rme/XRRrZde7invzQcswcxPd8C07q+9PAVnJblcT9HnHG+jhvWNSTC5HuN9YxboQjy9UoN99uI4vcjc1VWLi6ahQwfxSl63zVbHjVwYxsuW3+K/b2F0ZaFQxVJ1vhrBA+0Xgg6s/46LBD60wpWbf1nJdFTET8a++G+58IWkVaOUxpRTD29/IUJH0AikwkCpsv4qMKNdC2TV3oL6BksSrgFJeL8hkQtYcikw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EKLIBAHaZwkMCfw6CMRwSgA/a4mysxJIO8ceEKp2Djk=;
 b=y54cq5GeBbIu4h0scCecjG7WL1/AnXcI3xuHn74rA/OPb0vkc9IuLv8TnhC4sWbiDNgnsYtYm62H+Ih3LXR/0DpXMPiezeVtoPbeUsFFgCIrAcKp8KeCP182TjzhevFVUaL67maIfahWw5i4DKr/2UB1HMX0R/iQVbTOmvl1KyI=
Received: from BN9PR03CA0486.namprd03.prod.outlook.com (2603:10b6:408:130::11)
 by LV8PR12MB9665.namprd12.prod.outlook.com (2603:10b6:408:297::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Wed, 4 Nov
 2026 11:20:30 +0000
Received: from BN3PEPF00022BC9.namprd05.prod.outlook.com
 (2603:10b6:408:130:cafe::61) by BN9PR03CA0486.outlook.office365.com
 (2603:10b6:408:130::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 11:20:30 +0000
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
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 11:20:30 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 05:20:27 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <jingjing.wu@intel.com>, <thomas@monjalon.net>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>,
 <bruce.richardson@intel.com>, <david.marchand@redhat.com>,
 <stephen@networkplumber.org>, <stable@dpdk.org>
Subject: [PATCH 04/13] raw/ntb: fix memory leaks
Date: Wed, 4 Nov 2026 16:49:52 +0530
Message-ID: <20261104112001.661769-5-raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC9:EE_|LV8PR12MB9665:EE_
X-MS-Office365-Filtering-Correlation-Id: 8a4987ad-074f-4dbf-f364-08df3a65a2a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|82310400026|36860700016|11063799006|56012099006|261021121427099003|261022105027099003|261026121527099003|261028144727099003|261026140227099003|261102123227099003|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MSX43YWSMZZ+/7TaY/kuNjnbmbVPDQF5L9NwjQ4Cb0nGmet38dkQouqMJr8vqi9LmCf5z73ZJ3iv/swJSsC6nGvJeNvHr29+7t5iuVyImd8txxAs9fLOaH8i86/SnTAIDpVGSWqh2eMKEyjJ4Xnwd0Ck9UbeP3MojK1aqkdUpZ/gbtPAK0pvJCEx+yT2/DB+IROqZ7BpnfiwN0DP/P4X7mExD1j1GzwMd3/oqn+IoyeOzCBTv6Mr8CP8Caf5TMQSdO7gpHN737wEs9u8HN/VMZtIUeUeWEknY8guPMxn4l06gKnO0F491rf13G8w1uWa9veN7OwL/Xs4+8ZwPnVOyxe4UwCi38SrobO8X9z4oumMG6CuUegrqc079lI0kFjhJacIoO0TWwvJOpT193uIiiFemFM7aOswP2A1M6ddDG3k5tXxtKBUAcFWOLeiblDmE4aEWOXuJgWaH2oqwey/IVflX8mswNJdDuiKveu7rB/0Nae4XMfFW9LfkIlKWTL3fjPkmPNffF/9t5vj1U8e28AeZdfhrbAbS4iVFFSGnlDowsFCxQb7c6pAIO+lrGAl4U19dZlLoQzpExYpgUhQx7Pt9ecyFtVeXVM1cqdOlZB9OlFEZJoovCDgQmAT6F+B2/8xzbcpsZ934FjoetGPqjEmwLt/mBeYucfg8JonkF81gbpITbctEd6tc30+yL+BG88fBYVrPw3n7uu8KCAOfg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(261021121427099003)(261022105027099003)(261026121527099003)(261028144727099003)(261026140227099003)(261102123227099003)(10067099003)(18002099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: cpIzhvCw7PVd4FS4WqSixsR/h6lf8xA756b8sm2hxXdBMrNHdSjMhoEY1iKa4pILlQaX77usD9aXKsMsuD17jXTrW8TVhOqPgA8yGU1Fl9YbkbEqG3RgfOvdDOOuqM2okn6s+n2NVO309yv96QegZfP9x0tJGEmwqGtubZeCA3K+PcHt+KOBRMF7bc31HmCDqJlIukub5pY52y3OmxjXsAh5FBtQKzH32Iz/qD1c8+kkxT0FPa+jjhzbYMo+KCxt+UQ1eCam1ZmEpEOF9Ia5fmJQMKVYFY2NNsK9DYE0bPrRQXCVmKs0hPXQvGRZsUIv7Iqm1WuUfDA4PjlH5S4WxJoGmzDyioR2/gHUvVE7GDfs9dGEtIjWtaq33gL54Czvm+qB/4UedoZenAIGF1z8FiqKYqsvVhlRI2oE8SAIO2NlUkUNolIcV2uxDmFD+kEr
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:20:30.4560 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a4987ad-074f-4dbf-f364-08df3a65a2a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC9.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9665
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

The memory window size array allocated by the vendor init at probe
time was never freed.
The peer memory window base array allocated at each device start was
only freed if the start failed, so it leaked on every stop/start cycle.

Free the peer memory window base array when stopping the device, and
the memory window size array when closing it (which also happens on
device removal and on probe failure).

Fixes: c39d1e082a4b ("raw/ntb: setup queues")
Cc: stable@dpdk.org

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 drivers/raw/ntb/ntb.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index e42af0b9c5..af3fcd832b 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -820,6 +820,8 @@ ntb_dev_start(struct rte_rawdev *dev)
 
 err_up:
 	rte_free(hw->peer_mw_base);
+	hw->peer_mw_base = NULL;
+	hw->peer_used_mws = 0;
 err_q_init:
 	for (i = 0; i < hw->queue_pairs; i++) {
 		ntb_rxq_release_mbufs(hw->rx_queues[i]);
@@ -872,6 +874,10 @@ ntb_dev_stop(struct rte_rawdev *dev)
 		ntb_txq_release_mbufs(hw->tx_queues[i]);
 	}
 
+	rte_free(hw->peer_mw_base);
+	hw->peer_mw_base = NULL;
+	hw->peer_used_mws = 0;
+
 	dev->started = 0;
 }
 
@@ -890,6 +896,9 @@ ntb_dev_close(struct rte_rawdev *dev)
 		ntb_queue_release(dev, i);
 	hw->queue_pairs = 0;
 
+	rte_free(hw->mw_size);
+	hw->mw_size = NULL;
+
 	intr_handle = hw->pci_dev->intr_handle;
 	/* Disable interrupt only once */
 	if (!rte_intr_nb_efd_get(intr_handle) &&
-- 
2.34.1

