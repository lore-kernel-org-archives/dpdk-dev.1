Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7725606A338
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 05:51:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=X+Cwzb8k
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 680C440DD2;
	Fri,  6 Nov 2026 06:51:13 +0100 (CET)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
 by mails.dpdk.org (Postfix) with ESMTPS id 478D240297
 for <dev@dpdk.org>; Fri,  6 Nov 2026 06:51:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=N9B9OQ29AU13DcVaBtEwuyt21bmZKMhlk+7rzwonkgZJ9YzhS8TkjZhGsNYA3xzmNRAviN2+HPHYkd/6mdVEs3xyNHHQi+P4VauK0x+7sFjNo0uvrP7NAhoacZg8Ikjesvn9RV4ciHeltq1qF5Lu4GIh9yZaU8oqyZeoG5u3sIhfmWaLFThamENyBMQZJmM9cn3Dm/fv1UJJg9JLHvgBduV7ClsG/97xYVHTD0LF/UKsLzDVVit837UBbuJKW4isDS1B1pa19B/pubx7b3x4HWnOitbZ5SCmym7rCSZEEAq1g6+nHM3R8M9HK0JwVQL/lXPurkrRhRrt3rX+Dw/Xjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WL6goXrnkYXF1gn3edNOaT+3xPG8u6dQDoqp/aihN5o=;
 b=vqRiWsrId8xclAywn40a/gP7++0/DwEaudyqxKRyICkLMwqE7LdN76fLyJX9eZ6mb7h2ztDhwrw9bruKAv6DGuLD58/wTIi/2mHLhzwQHceoTg+g+QUpKJJhQbvXH44VD3r0pyu2ap1KCsFtF6NWn8iLtzAda1F/R0z7guW1kFo1RnIfFDsQyY2kLLxHru3R64jqEKx+794eySq1ClgfA3oECYmpsZKEOrXp3aui0yPlD+gAjnX1vB/MYZ/oYc0X1BJMJMA80j2MDXItAmFpwW302YDj66O7ONDyRyIqmZEJ8UGHGOFuynJYoYQpTdigfVKMfvr8UPyLoonUAtbDuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WL6goXrnkYXF1gn3edNOaT+3xPG8u6dQDoqp/aihN5o=;
 b=X+Cwzb8kfbvtgt+9BB4s8KimJzJtIWzn0FAzNM/dwimhXAuudYoBTQInDS2ADCBqDJiKJz0YxueAJayoxRkgJ/F0ZikSqUp/9hI8vnNv0KD8VTmJBrxNkAkCnRIS7OTHDHduxJRIUnZKsVqGdVxwRSGzf6gNGub8kurbtyaowLg=
Received: from PH5P220CA0008.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:34a::6)
 by CH1PR12MB9623.namprd12.prod.outlook.com (2603:10b6:610:2b3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.569.12; Fri, 6 Nov
 2026 05:51:03 +0000
Received: from CY4PEPF000392D9.namprd03.prod.outlook.com
 (2603:10b6:510:34a:cafe::15) by PH5P220CA0008.outlook.office365.com
 (2603:10b6:510:34a::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:51:03 +0000
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
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:51:03 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 23:51:01 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>
Subject: [PATCH v2 01/15] raw/ntb: fix device check in memory alignment query
Date: Fri, 6 Nov 2026 11:20:31 +0530
Message-ID: <20261106055045.720805-2-raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF000392D9:EE_|CH1PR12MB9623:EE_
X-MS-Office365-Filtering-Correlation-Id: 55cbd44e-e351-44ba-63a1-08df3bc9f16e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|1800799024|82310400026|23010399003|36860700016|22082099003|10067099003|18002099003|56012099006|261009223027099003|261021123027099003|261102123227099003|261021121427099003|261026121527099003|11063799006;
X-Microsoft-Antispam-Message-Info: HuuoXwRSgBWlmrb7n9uTATYnBjTkDDAUA+aQHoPXWKLLrgVgvsHGGx8WaP65OT2R0T3XujpXTLviEeTNzK1OSRQR/1SdjMfPHbJ+eWq6zSoRS26h4FnKeryTOeKzb1SGeRleUrIf6qlhm4DNpRAQVoItJ29cK7w0DKyjFBPIVFNyy1nXNvsI+r3JV2IsEdEETveR2xroeVM34ZEo09bfvL4LSPeMqk8mf6Xa9dON9S4eU8UZGIUPBax3kTb7TDFpV8KNQOCiPbo2M8TDJCtnifutQTS0aApBy+48b1lE6SwXo7D1xK8QGRivkBoxfDFdskxR4rtRY28w9KarEVg8QRWpZ4zMSn9zIAcNK7eSQx9/H2YPoVW8pSU86i6EfKm9Zijgtg/zYCb5pkh0n3/Bc46mfHs4PaU7Qs8Ga5zUmXhWGx1ITF+RhXtox/7ckvtkT3Pn2uG5jhfZ+xdQ4aKSM458wQECDAim1YJamoJ3Xq5W4YNZ2xrigIacF9euweW5ERHRGixRKE4ZNQrY8Guxv//b7xSzjbmmyQvZSkAX65B2xR9YIf4uQ95maMQ3c+nL2jxcyS8Oifg+17AWmPY7pADc6Eis6GtFY79EC3UY3yTXKPsyJe0+swFasA07vERa+u3y4XO1qE/eS2Do2fom9YCnSnBGtPBFgLpJC+tWEXZ5RrSs6xOavLkgwQeD3MxgiixRA0bqvLblJFmcXps9AQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(1800799024)(82310400026)(23010399003)(36860700016)(22082099003)(10067099003)(18002099003)(56012099006)(261009223027099003)(261021123027099003)(261102123227099003)(261021121427099003)(261026121527099003)(11063799006);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 2aY37SAcZTHsUki4JaEqTJTKXSGh5VBsSWfP8rIQ0+/JGkHYm3T1RuD5kHdfv/5fIgEIaJzY5vlpJiGV4PxPdhP3uXpO1A9m6W6MHRrbaPFzTF0CypY2dgtipDof0VHaLPsP2I5krPwKqhdwTvp/g+T9HK9ADXsXsxU2HjFxCsRxxRTKwWBPQPbPE5tnQhT264+/Nct+i9Cwl0FRCwgmDhJnIGprmusHiB+RySVIM8nQyrsLs9qjmX4ON7b/bXle1kIfveGCQwSrxkKVj/HVAwY4i1TxM8Emdkn72MxK30UyaQK6NxHq86uQK6f89uPZd0QWP0gIbp5BGig0e++9YIWw1BYd5vC+fhtzsIdH5T61GC2yBN15coOdq+UVyDEm1R/n/xBB/RajdjArxrzCh5vAmJvVLw/vA+qHUaS69u1KxDIKQHIwxdO0t8j6XW3n
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:51:03.4066 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cbd44e-e351-44ba-63a1-08df3bc9f16e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392D9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9623
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

rte_pmd_ntb_get_mem_align() only checked the device index range and
the presence of private data before casting it to struct ntb_hw.
Passing the id of a detached slot or of a rawdev from another driver
would then call through a garbage ops pointer.

Check that the device is attached and is driven by this PMD.

Also return 0 for an out of range memory window index, as documented,
instead of a cache line size.

Fixes: 5ce50c234ad1 ("raw/ntb: generalize framework for multiple vendors")

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 drivers/raw/ntb/ntb.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/raw/ntb/ntb.c b/drivers/raw/ntb/ntb.c
index fe10782ecf..e42af0b9c5 100644
--- a/drivers/raw/ntb/ntb.c
+++ b/drivers/raw/ntb/ntb.c
@@ -33,6 +33,8 @@ static const struct rte_pci_id pci_id_ntb_map[] = {
 	{ .vendor_id = 0, /* sentinel */ },
 };
 
+static const struct rte_rawdev_ops ntb_ops;
+
 /* Align with enum ntb_xstats_idx */
 static struct rte_rawdev_xstats_name ntb_xstats_names[] = {
 	{"Tx-packets"},
@@ -722,15 +724,15 @@ rte_pmd_ntb_get_mem_align(uint16_t dev_id, uint32_t mw_id, uint64_t mw_len)
 	struct rte_rawdev *dev;
 	struct ntb_hw *hw;
 
-	if (dev_id >= RTE_RAWDEV_MAX_DEVS)
+	if (dev_id >= RTE_RAWDEV_MAX_DEVS || !rte_rawdev_pmd_is_valid_dev(dev_id))
 		return 0;
 	dev = rte_rawdev_pmd_get_dev(dev_id);
-	if (dev->dev_private == NULL)
+	if (dev->dev_ops != &ntb_ops)
 		return 0;
 
 	hw = dev->dev_private;
 	if (mw_id >= hw->mw_cnt)
-		return RTE_CACHE_LINE_SIZE;
+		return 0;
 
 	return (*hw->ntb_ops->mem_align)(dev, mw_id, mw_len);
 }
-- 
2.34.1

