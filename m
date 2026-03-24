Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CE38D58CC9
	for <dpdk-dev@archiver.kernel.org>; Tue, 24 Mar 2026 12:37:57 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A715940664;
	Tue, 24 Mar 2026 13:37:56 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
 by mails.dpdk.org (Postfix) with ESMTP id 1381540663
 for <dev@dpdk.org>; Tue, 24 Mar 2026 13:37:55 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=lT0TWQsT/PF2exIcO14t860KI/Ad/fOo0T9ZtlJsFGHmJw+zkx9fQSsMUN8WuqzRz4jWfLVyv2p2iWo/7S9fQMwNngBrjS1jxa0lYLTS3IeJtQ+kJ9lRrkRAzexGT8XsPgmF0oczsK5kX4MgBcE/GZ+eVsNRQSjrfOTOjaz80e9qAqzZHI9nF+ZKnROp3GjNohR0LewV/mAuqg3L4NMdE2GNyollW9rVJevOyqaG+rIGybc5/yS1nmV74BFH7iQE4ORA+3nBJYYLHsVwRB1oKDc80SHkQGTGIPFOl59rVL+QT0k5LMVouJGJ/G6gDsjFe3WsT27W5o37bQNosT4bUA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Aq34skyp7avuk5svnqI5fEBJlE9uJ6d4TmUei/q+HTY=;
 b=xNOxF0ezf5INXYcfbV1B2rBoT2CktqT0riakDmaxqnInq3X6rCWV+D2AlnTc4AvmeCFu8z4Fz2uISI71SE7fu/FQUDkweiQlMIOb3ml3yMvtGw9oTOubZswDu00/z2/MRwxNtHYXxz/JfbiV4fix3PAH9tRjz0JSRoyAQtHVs8qsDr6zLeTAZ6Lbaa7lakcudXbDVCns4s9w4ohsU/7o0QPA5rjXf2aYs/EAwy1feEAGHY3nm34UNwoZKb+QoTWazs/+HJCcTl5Y5I2//xh45wAXOqb2vry/fjGkAQgP4OOuzSJWfNPymPViWX044IOELpcRjJj/UheJ1WF6vZaHiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=intel.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Aq34skyp7avuk5svnqI5fEBJlE9uJ6d4TmUei/q+HTY=;
 b=F24P7E5MI0FEjYl/0q0vAi3HLvby489E7R2sk24fJXGJYMWYtAK3nO2ti6tR6MHGMR8o6c7tA4vKMS+JPmqC3hVkeHzUFp51L9xd1LdHaJvkVM12UepqTChYM/UsdoZvyzHOWdynN1ue5PJyXMewZrQg7QWHVGshBL5MWxkjgShNLk4SDGvYNqAcIp/fud7OS8QPw97gGlMpB+Ma2w/iCvF6Sed18CkdQO4Pih7MdcX63+2LeBZmbBxO+IPrVYz3yXhxok8G0Uc6mqvYttC4QJaFSWa3tfg9o6KHT5Qfw+7Me9YNM0xe6lFo9aHx4FjhP+lynIwDG0iI8zTm7c6P5A==
Received: from BN9P221CA0009.NAMP221.PROD.OUTLOOK.COM (2603:10b6:408:10a::17)
 by SA0PR12MB4384.namprd12.prod.outlook.com (2603:10b6:806:9f::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Tue, 24 Mar
 2026 12:37:51 +0000
Received: from BN1PEPF00004683.namprd03.prod.outlook.com
 (2603:10b6:408:10a:cafe::8f) by BN9P221CA0009.outlook.office365.com
 (2603:10b6:408:10a::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Tue,
 24 Mar 2026 12:37:50 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN1PEPF00004683.mail.protection.outlook.com (10.167.243.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.19 via Frontend Transport; Tue, 24 Mar 2026 12:37:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:37:34 -0700
Received: from nvidia.com (10.126.230.35) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Tue, 24 Mar
 2026 05:37:32 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Aman Singh <aman.deep.singh@intel.com>
CC: <dev@dpdk.org>, Thomas Monjalon <thomas@monjalon.net>, Raslan Darawsheh
 <rasland@nvidia.com>, Stephen Hemminger <stephen@networkplumber.org>, "Adrian
 Schollmeyer" <a.schollmeyer@syseleven.de>
Subject: [PATCH 2/2] app/testpmd: revert switch domain mismatch check
Date: Tue, 24 Mar 2026 13:37:09 +0100
Message-ID: <20260324123709.3471-3-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324123709.3471-1-dsosnowski@nvidia.com>
References: <20260324123709.3471-1-dsosnowski@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.126.230.35]
X-ClientProxiedBy: rnnvmail202.nvidia.com (10.129.68.7) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004683:EE_|SA0PR12MB4384:EE_
X-MS-Office365-Filtering-Correlation-Id: ad907cb0-3a16-4193-48a4-08de89a22971
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TapmTlfkeoi65In7BiLnfchbWwElTycKNBI5Sjn7f1sGI/8cUoeFDLFMt/7WOHnOCocdsA1bpcDx/j2dHw3PUIsFll42dsO9Xn370PzVrJYFv/aFxb/YIkTAMCeq1HiBn092lBlfFNn43fQbu8Kp0t0CXnhPRljOtSfC7ycReNwtd3X01sQFF/ROHpS5ftEPK8Hf9Bx7dG7xqF6jvrtu8hT758in8xnucABjOxtZ0ET1A1t7iwUvM0Oyjn/43EdqocAYX9W84ALWSkp+U4wCTUuFekG4BbspgK4CsKMCgC1oM5/VXh/yZDGG5dPHzV+OsAMMIPuIPfXG7RmKK6nNijFdN43YMCGJ1qZIJFbwy0K2rqlftZyVU/+KNmT6M45/WQiO4JjRGCa7PgU2knRNY9NV5sBeFUsWzvthHIyDfz6SHD3VvjlrNg+KSwfsoyGupFG0rdbFrggpiqM0rCZhq7BDagDJAIpaxZQT3RKBqLP+XkuaOZMOrIddpAD2MbGcFhGnDkmcEg+xFYtfcFvt/EezRW0HNaqgVGwta8Y/oOVov1myPxoXWtZliRlm5O1odS+Vcvr8E/B36yETy55eRfaNHBC9P2eHz10ZS98Y+gDWJ8i59GKTlItJrCHn0OIGWhzfKhicZT8fDHgn7Bk3awviSaP+aSVD9sJ8JHJuthGAKXK6Fj0McfjnDcmQ5QZYpWAR45y1MaY1lqyXbmm3hU/sqvvcPn6hmpz3wnvRht/yy7CR25DXLHPT1A6Nh4YlfQExeGsi7uZiQ2i5yovt5w==
X-Forefront-Antispam-Report: CIP:216.228.117.160; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge1.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(56012099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /wEI2cIi0qyW39cA/vZ9TjD3ixiqDVL8e9JssmkwL1Mn6tAiFHFeBOqDUs5eI8P56ZsiizsCUEM4WSI3aqhW3+dR4x4BJwK02c2luY7R0S6z/Ywarz20RNuE59TZ6FuP2e22mE6uDu5pbEDtNofJSCZ89OnVAsZAqLf2HInXfg3RI4+afaxC7PrDaefk8W7uTDfEyXgE2j29qcWHMAhKtr2quizRm5nXixqDVMu07kj3AkI9Xfo2ulq5s3OY2UIu1VjROJjOkqwiHsCTmCxGxAOMPqfhVhyojXe9rWhyzNWkeE+QXdHp7uTgllzdwnAPyyUjyRqN6BUYPL2hlW4MNclDQ8D43J6ZXqI/vmTgR5QZLU23kFrDkfOqM+w50MlvauRfhkUerWpbFkBIPEZ1H5aJXj8CSZNUhbQPMja2A1HhryAuWi9UZeqnOmxpoeiR
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Mar 2026 12:37:50.4374 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ad907cb0-3a16-4193-48a4-08de89a22971
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.160];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004683.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4384
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Unsubscribe: <https://mails.dpdk.org/options/dev>,
 <mailto:dev-request@dpdk.org?subject=unsubscribe>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
Errors-To: dev-bounces@dpdk.org

This reverts commit 8ebba91086f47c90e398d7775921e05659c0d62f.

Previous patch changed --rxq-share parameter logic.
If this parameter is passed, then unique share group index
per switch and Rx domain will be assigned to each shared Rx queue.
As a result the check for domain mismatch is not needed.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
---
 app/test-pmd/testpmd.c | 39 ---------------------------------------
 1 file changed, 39 deletions(-)

diff --git a/app/test-pmd/testpmd.c b/app/test-pmd/testpmd.c
index be8e8299e3..5542ac9855 100644
--- a/app/test-pmd/testpmd.c
+++ b/app/test-pmd/testpmd.c
@@ -2721,45 +2721,6 @@ rx_queue_setup(uint16_t port_id, uint16_t rx_queue_id,
 	uint32_t prev_hdrs = 0;
 	int ret;
 
-	if (rx_conf->share_group > 0) {
-		/* Check required switch info for Rx queue sharing */
-		const uint16_t dom_id = ports[port_id].dev_info.switch_info.domain_id;
-		const uint16_t rx_dom = ports[port_id].dev_info.switch_info.rx_domain;
-
-		uint16_t pid;
-		const char *mismatch = NULL;
-		uint16_t mismatch_pid = (uint16_t)RTE_PORT_ALL;
-
-		RTE_ETH_FOREACH_DEV(pid) {
-			struct rte_port *o_port = &ports[pid];
-			const uint16_t o_dom_id = o_port->dev_info.switch_info.domain_id;
-			const uint16_t o_rx_dom = o_port->dev_info.switch_info.rx_domain;
-
-			for (uint16_t q = 0; q < nb_rxq; ++q) {
-				struct port_rxqueue *rxq = &o_port->rxq[q];
-				if (rxq->conf.share_group != rx_conf->share_group ||
-						rxq->conf.share_qid != rx_conf->share_qid)
-					continue;
-				if (o_dom_id == dom_id && o_rx_dom == rx_dom)
-					continue;
-
-				if (o_dom_id != dom_id)
-					mismatch = "switch domain";
-				else if (o_rx_dom != rx_dom)
-					mismatch = "rx domain";
-
-				mismatch_pid = pid;
-				break;
-			}
-		}
-
-		if (mismatch) {
-			fprintf(stderr,
-				"Invalid shared rxq config: %s mismatch between ports %u and %u\n",
-				mismatch, port_id, mismatch_pid);
-			return -EINVAL;
-		}
-	}
 
 	if ((rx_pkt_nb_segs > 1) &&
 	    (rx_conf->offloads & RTE_ETH_RX_OFFLOAD_BUFFER_SPLIT)) {
-- 
2.47.3

