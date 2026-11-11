Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED701606A31C
	for <dpdk-dev@archiver.kernel.org>; Wed, 11 Nov 2026 07:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=H2HVBjvs
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 492E940DD8;
	Wed, 11 Nov 2026 08:11:47 +0100 (CET)
Received: from DM5PR21CU001.outbound.protection.outlook.com
 (mail-centralusazon11011019.outbound.protection.outlook.com [52.101.62.19])
 by mails.dpdk.org (Postfix) with ESMTPS id 972AC40BA4
 for <dev@dpdk.org>; Wed, 11 Nov 2026 08:11:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rVChBT6Wx4/yqwCTWn9V23O6RzlEyAsTsxQegNd9nlS11WCCY4hDxVAhCZZkAvHTAer58u+9BlinoWceheABDbWrnz2QGIdUDI0vPfD4s51j+kp0JZdKttJrtylnSsWtAQZnOJxL/v46OW6TKP0Yn2eQD5PRfysG12gJ5uD6GFtZdVbs/JFU+rGVWLNy5UePPMbHkcbCNRDN4huXDudb3u/LT+QgH/fX3TITcuauokb+slc/5ocXxH8RvIWkaTegbbhe2zFDUH7Fnaiqvo04DpEQ7HVpMO/t8I47LYFBuQFsUFV6m05vPNKY2aE0nkegRxccnc+vzUIvpd+qxDyknA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJO1vhS8AZH6p8w2wdSP8jA8IH5qZbHkMR9MatCrNtI=;
 b=lb48yVrhnCm8V+V5+pl5lkVdQWSkq8c6daikQeIEgwPzsvAvDxciUldpHSKcXWwDOlvb1jJg0SbAbFfU31v67ZVVJNE7hlse+MY14Z0TEuqLGKUQmumwNMtLJyatX749fVEQTvCxrxJmMGa4wNx2harsQO3ueBJIiQ2ckEiInSqy4zH/Cpm2Pw6RDrYtK+TUFVPBU1EyOsvTU7at+rtf87o458r1QkuRXyciC6fgGROkIIt0kfQenAfRaZz+trMkoWjowzM5YaGNUcVLLci4wWwcYZzpR6d+vLSPCSqejcgSCzsIiYvOraSg+H8XXPseDaRl1JSR3Hb2PqHer2Bq2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJO1vhS8AZH6p8w2wdSP8jA8IH5qZbHkMR9MatCrNtI=;
 b=H2HVBjvs0gzWPEAhZ2F9cI6V+NdRyedb8BWNmdmfF3mL6Yd3xj6UBsU3pfQX8wOZeEryDRNMZu1G2J4fgju+FQRK0np9ZKJxGSGUnpa18DUUMrMUeO7eI+VLObkEtWW8nLf4B7JIGrxqyP+tnany/bsVcXtGjV4h/CRJvAxyNYE=
Received: from BL1PR13CA0018.namprd13.prod.outlook.com (2603:10b6:208:256::23)
 by SJ2PR12MB8182.namprd12.prod.outlook.com (2603:10b6:a03:4fd::20)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.13; Wed, 11 Nov
 2026 07:11:11 +0000
Received: from IA0PEPF00000046.namprd04.prod.outlook.com
 (2603:10b6:208:256:cafe::1c) by BL1PR13CA0018.outlook.office365.com
 (2603:10b6:208:256::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.0 via Frontend Transport; Wed, 11
 Nov 2026 07:11:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 IA0PEPF00000046.mail.protection.outlook.com (10.167.249.170) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Wed, 11 Nov 2026 07:11:10 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:11:04 -0600
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 11 Nov
 2026 01:08:24 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>
Subject: [PATCH v3 13/16] raw/ntb: remove unused AMD register definitions
Date: Wed, 11 Nov 2026 12:36:47 +0530
Message-ID: <f6fb4a4af7d9384c6cbb596acee3aa894428ff8a.1794377833.git.raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: IA0PEPF00000046:EE_|SJ2PR12MB8182:EE_
X-MS-Office365-Filtering-Correlation-Id: 42189f0d-6fe4-44ac-4c2d-08df3fc2f6ab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|36860700016|82310400026|1800799024|18002099003|22082099003|4143699003|56012099006|11063799006|261026121527099003|261021123027099003|10067099003|261009223027099003;
X-Microsoft-Antispam-Message-Info: 4oUTaBjRqrj0lQ6rgX1Qc2YiVCXG54HJe/NdSYAcydgnHF8USwROcf7nDi8LlJ/H/Y1weNBoQ0HvdAijV2kGVMjDLDBGPXuXpdhl5i+HrHO8b/jyogMHgbnO0hY0/9mFYDL0+/XxSpWnY7y5ntSGtvN0t3VPw7y4ams/EG0McZoMI7RKeOqoiEm5/Fua8NDTIaUYdFgLuRjq5tcnloWVs/Yob4I1RWXLS5F0nXAcoc6kNJgwz8iSaoCekV/ah3wnRh1AwwB98teagXCIplPbCG8ODuEeQw6ftfKM/MzrgmbB+iHzTz2GD9tppFekC5LPX693CS/7YLTyuY/ymG3rnMp4BL+/6WCFD72zL6zZqhnunQes//yqqBxbfKtx3VS1NY+eE+cipI35C4GMOIchD8dWt1lzXrxvgEAINmhxaHYUkeKcZ/3XKzelTQH1LOqWmWieMlJZF3LwVMUDCyUdzhbHNU9/uKDBTJlUjEHHxsCcwChSWN3CV0As17b/k3DAtxNX61WZVtZrKKzQms45ceyQHy/CGof/LmdGomc3idIf2d/bfNVuquNjRIHXe+3tcM/6xCV0ZEkrRr1O43a1m3RMAlmV5s3ZMyobfu8ai10ZkNnRStHSuTPb1U9bKNkR653i2ViXigT1Ch49KVzPyRZ+MUrX0q9l5b36Ya+c+UbXCBGzsUoelWubNto9sd8DAQixIDjXYdPDkMCEutXLuA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb08.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(36860700016)(82310400026)(1800799024)(18002099003)(22082099003)(4143699003)(56012099006)(11063799006)(261026121527099003)(261021123027099003)(10067099003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 6EyHATZRA8TB+R1FBfIKmrDDcNcxiOmfUQs6Ay9z+XmRE2OQpCcrAiz9Enh+OikOMd9wMCGBRG9UdDJiqiwuPsbJb41AYuufks7PyBoyCkZSyyADo8hNMPLQwHfidheEWnKkzvCWBlPpqslKPILkTnBBLzRkq4naBKLJUxLyYl8ZmYqRniNugQf+su58vfMu+Ejq8YmVDZhfY0jGSGoyXqKUcL/ptyMjsXxiq3JoUxMJP5orUAlcDrrzOCVrC+C/U+48qg+3z5o182tQw2kFERRjAlX0ARHMs7DUjndki8Nyw7DEgAP8K/1yO4RK7OEwrK42gC1Mk2aD3VjP1zpZjSXk44mosqstLUMO80jsCUZ42fN2yVEIAh0EdiZcP9gyqCp8BVmrfwkRiZfriVISY+rlEaTn5X0N04wXPelqbAJDGQjYHYWtEOoKU+80cEZe
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Nov 2026 07:11:10.4086 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 42189f0d-6fe4-44ac-4c2d-08df3fc2f6ab
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: IA0PEPF00000046.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8182
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

The scratchpad mutex and doorbell flush mode registers are not used
by the driver.

Signed-off-by: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
---
 drivers/raw/ntb/ntb_hw_amd.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/raw/ntb/ntb_hw_amd.h b/drivers/raw/ntb/ntb_hw_amd.h
index 8fffa24348..eec2041ad2 100644
--- a/drivers/raw/ntb/ntb_hw_amd.h
+++ b/drivers/raw/ntb/ntb_hw_amd.h
@@ -25,14 +25,12 @@
 
 /* Primary-side MMIO register offsets (BAR0), spec Table 1. */
 #define AMD_CNTL_OFFSET			0x200	/* Link Control. */
-#define AMD_SPADMUTEX_OFFSET		0x20C	/* Scratchpad mutex. */
 #define AMD_SPAD_OFFSET			0x210	/* Scratchpad registers. */
 #define AMD_SIDEINFO_OFFSET		0x408	/* Link Status (PSIDE_INFO). */
 #define AMD_BAR23_LIMIT_OFFSET		0x418	/* MW BAR23 size. */
 #define AMD_BAR45_LIMIT_OFFSET		0x420	/* MW BAR45 size. */
 #define AMD_BAR23_XLAT_OFFSET		0x438	/* MW BAR23 translation. */
 #define AMD_BAR45_XLAT_OFFSET		0x440	/* MW BAR45 translation. */
-#define AMD_DBFM_OFFSET			0x450	/* Doorbell flush mode. */
 #define AMD_DBREQ_OFFSET		0x454	/* Doorbell request. */
 #define AMD_DBMASK_OFFSET		0x45C	/* Doorbell mask. */
 #define AMD_DBSTAT_OFFSET		0x460	/* Doorbell status. */
-- 
2.34.1

