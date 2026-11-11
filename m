Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD0E8606A320
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 07:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=wE/xqu4m
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 3E2A341132;
	Wed, 11 Nov 2026 08:11:17 +0100 (CET)
Received: from BL2PR02CU003.outbound.protection.outlook.com
 (mail-eastusazon11011017.outbound.protection.outlook.com [52.101.52.17])
 by mails.dpdk.org (Postfix) with ESMTPS id DE5214026D
 for <dev@dpdk.org>; Wed, 11 Nov 2026 08:11:11 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l+enIEH5dd5L4X9D3yIsobNaLpNIsRTtnuLkKkJ8WrUXw9Ljw+Lqke8mCqoS45sL6ePTnEjbHHxsKqoL7g4gounUKFo5Af5fjYjgQIyvjel7SeAFbQeYLX+0cR+ADT8LWPWQkBMV8Q20V6QyXC+W95Gl5MG8FTNQwCbt0b9iLJ+3YpQPv7893/AsvH5sOWG+pYKJnEGfHh6lcTllRpn4Pda+yNOP7DPR/OBjHDs3gRlgILUlt7bQPn5ENbNqfKYL2PsrkZfl++V/42Qrtcjm1aKrTJvOVOdXHqsDGHcZ7pQrnv58FC5pD56UDGChswUVyj3LrwI9KDfMLoWPjfEjUw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WL6goXrnkYXF1gn3edNOaT+3xPG8u6dQDoqp/aihN5o=;
 b=I1cS5n5wNEhm994LgUhRaozf3TTIbJs3tQl/M68yP8r6+i40oMagePe1QQLI990ZliiLnJbaq1/qw5X2JRzZ6BdjfnxOvEdjMdsFDjOKtxFpt7SSy+qpdLJF5ynzx59EawfqN+1Qg3uYVWkefbpKZzd36GR3YC3zDurDTmFsVYv6ymL53fjAWiYSDqy2GBl7eskP2/TtrMNOFEHr59Uhy08zkDAffEmtj/LCVZnlybKJyI/3Y+aEw05Y7jBKRD+3ynAoTtfUnsqUBzBqKBPFA/ZdYLQia1CXP7zwMWNqT5tmXat8tKHxINoBZOWyKPbSSQuS54FGSJanqseQqYqUqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WL6goXrnkYXF1gn3edNOaT+3xPG8u6dQDoqp/aihN5o=;
 b=wE/xqu4mpdHjO+F0vAjf5QusclPF/0y2S4XxJ3U57JQFjPdfsFyJ7P+11Jt1SwalE1PNwdSs6vxo7LewiOxMQEwbaQmNUzHeoCA8znCSPSfdK6hOO+KSSAvFeEyv6KkvOmE83eJ1ODfvk8yyjXiRHCCo+x+hJGbj6W8cn6rGgzU=
Received: from CH2PR03CA0020.namprd03.prod.outlook.com (2603:10b6:610:59::30)
 by DM6PR12MB4204.namprd12.prod.outlook.com (2603:10b6:5:212::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Wed, 11 Nov
 2026 07:11:06 +0000
Received: from BL2PEPF000352D5.namprd02.prod.outlook.com
 (2603:10b6:610:59:cafe::6d) by CH2PR03CA0020.outlook.office365.com
 (2603:10b6:610:59::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.8 via Frontend Transport; Wed, 11
 Nov 2026 07:11:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL2PEPF000352D5.mail.protection.outlook.com (10.167.254.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 07:11:05 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:11:03 -0600
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:07:06 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>
Subject: [PATCH v3 01/16] raw/ntb: fix device check in memory alignment query
Date: Wed, 11 Nov 2026 12:36:35 +0530
Message-ID: <21ccd78965fa5ff7dee11485bedc414dbdb281b6.1794377833.git.raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL2PEPF000352D5:EE_|DM6PR12MB4204:EE_
X-MS-Office365-Filtering-Correlation-Id: 16e2cd73-f66f-4aca-ab4f-08df3fc2f3cc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|261026121527099003|261009223027099003|261021123027099003|261021121427099003|10067099003|261102123227099003|11063799006|4143699003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: LxACBdsRKRWgsYfJQtm8eyehL4CTqc5bLYP+MhMRg05taSrGLaoBDf16MDTNK1sfAYcvMmYip0ala9l5LnILQJGQWzfMrNChWDhYZnuRkcsU7H1uheMjbVxMi9tj2RJqi7Ao6n2PRDdNIxjpQF9udCWWacaX0HL0rlomCnLXI4dIdvvgsj3H2D7WwZI8yYl6vpabP3kmAIE9BwQ+VDoW2kNpfvrooVGLmItQP7smPJyS+zGHbbPpyYUC1pIcKPGuPvRNKYuN6MI6+FCKloAMCZYJ5qPWpVMwhMt2YtcCR6t/yxGC0DEPMf/zZLGf8KhKsmi+54pMPqFy50UkvJ4QRULn9o9af8yubSi1H6h6Fj5jH3Z/VDg/1+pJYIQa7x6okVnSBIus6vIm6MiVjxr4V8kbi8X/Bkp71bG16Nx0hyfFYUbALVdpJK3QJyaYa3mZ+GNjTLGKM13anm2BRLBYmF9FdZvMGkwUtXAAXV0cSRlGB9UQA71tPjdxQ+3fwCGJ9JHzVvAkE8xi7kqsfgISZ9zcSOF+kBN+/9H4SwwkOO6PlN9yaWj1hADkaGgYlaE8/zdiM4bM+yIP4JfK1IbKIsDtLeK+ajPzqb7vNwXUyjKMiBIhKStQsrHM0j0KJtkW+oPW3K2q0plONxxMBkIwBsP0kp5PLkpxNg5XKxraflxZm6Oogk58teGt3/q/VvPxfUTmPCB7bHRP3uW+LTcaUQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(261026121527099003)(261009223027099003)(261021123027099003)(261021121427099003)(10067099003)(261102123227099003)(11063799006)(4143699003)(56012099006)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: /WtEARfsxsx4VNk11vnOVu0FYUOas3EtOULrSWKcfFabojWRzWYzqYQMeZxNLWfj/gxkWZvnoVGaJGrjyt1Y0ndzA3S3QIxvT8Lf/nnLfYEgrFJ2H80ddTwyrYSYkvvdGxMHVOOAjQB70/wT8PQnABpTX2cbjv7orj8/uqO1ewtFseQzv1GtBiWYnu1lBQUu/D+IyiI06dEFMk0b3QMEPVgUtLkTCZEnEc0crUWWAQszbWFoserlTKU70O5axAavHv2bxC3fUPTnd7A+PFW12spf3hIVSp9BwNjTc0+VwtSKkyewT8hY3lYQaFDMIZsE1zpvBElg64C4vTrxXjyhrljLqtffJHsGAeDS2xIDNd1XI6IbXbAn5vpvzhWXfpaWB4F2tJIDYQIjKQ0dxDgA4oACmVJ/fFE41u2bhhiy9lXYQnZO8V/7yYsfXBuYh8sV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:11:05.5903 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 16e2cd73-f66f-4aca-ab4f-08df3fc2f3cc
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL2PEPF000352D5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4204
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

