Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77C4D606A326
	for <dpdk-dev@archiver.kernel.org>; Fri,  6 Nov 2026 05:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=VxTqmkul
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1754342E59;
	Fri,  6 Nov 2026 06:51:42 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012028.outbound.protection.outlook.com [52.101.48.28])
 by mails.dpdk.org (Postfix) with ESMTPS id 41D7140DD2
 for <dev@dpdk.org>; Fri,  6 Nov 2026 06:51:40 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=M/rQzcohNtEOTSppqAH0qffLh+bMm3XxthRqy/21DsSd9A/8UxzKD2svIX+2Eli1nhqjFeIDQjIxnLfTAdFuYHd1ziYAVm7bJzBtolRX/wDqS8oT1C7GVKm1kbwh9hDUbXCisBUajUzgp/007fBLLhSPGrfLAGJ5nubUc6l0KNb5OtEmYpnn7f15o2AgHbButaz0ry5qKYmQ4xavLk4tQlt8YbOs8ubl7eI4qjl35scAHmg+gkwcl2ZGgXoa/hR4ZoIXQE3gCBQR/fuvM05XeeAAzPkURhO7EmFRUC0ENOE3p3VbaHn38n0DB/KnFNUbTLg4ulVuvwq3ILLhzdN84A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJO1vhS8AZH6p8w2wdSP8jA8IH5qZbHkMR9MatCrNtI=;
 b=c1vr1z6vnmIIhmikBgDthN05kRaBNTLJW5dQk4LvE5VcQhnjX8NakcMVMrHs49+CqbwNWehSlAIxSbOlo4yxovDBMj4nGquANwMBCYV/dNEyuU9KEjpetBkOjItDaV8LZI5sb6TbE0lfkMM+hRs9w9ZjzNrcvI2s+zVsGDzdwzJHGlMDr1CNe8FN7ePC4R5IrjKKRveBDkGzrZPgMWToe6pMk+F9QJWbjCN6FB9mEQmXXZDvYnyxRVX2oHYbBTUluel35hv5mgoJq/aev8aJR8NGCaDuLCze4ZGQOYTuVLl6tM+yOdOjQDGDPh+nXD+CM+16UmZRIgtUTOC/zr/DZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJO1vhS8AZH6p8w2wdSP8jA8IH5qZbHkMR9MatCrNtI=;
 b=VxTqmkul+qcydTy0fZlntqCKE173xsGAotoK1EnF+07EXjwG7i4XIZJJD0bgTfjg5McCvP2uNgxGyxrOb9urD5dcmviH4MDxnPou8TPB5LUcU8UMiJ6PigR6JpjOUN5VNBuIWDCQYjZZapM4M0azTRAfxV2gA4jF0OjgTrOK3oM=
Received: from PH7PR10CA0009.namprd10.prod.outlook.com (2603:10b6:510:23d::29)
 by CY8PR12MB7490.namprd12.prod.outlook.com (2603:10b6:930:91::13)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.11; Fri, 6 Nov
 2026 05:51:34 +0000
Received: from CY4PEPF000392DD.namprd03.prod.outlook.com
 (2603:10b6:510:23d:cafe::64) by PH7PR10CA0009.outlook.office365.com
 (2603:10b6:510:23d::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 05:51:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CY4PEPF000392DD.mail.protection.outlook.com (10.167.247.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 05:51:34 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 5 Nov
 2026 23:51:31 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <david.marchand@redhat.com>, <stephen@networkplumber.org>,
 <jingjing.wu@intel.com>, <bhagyada.modali@amd.com>,
 <Selwin.Sebastian@amd.com>, <bruce.richardson@intel.com>
Subject: [PATCH v2 13/15] raw/ntb: remove unused AMD register definitions
Date: Fri, 6 Nov 2026 11:20:43 +0530
Message-ID: <20261106055045.720805-14-raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF000392DD:EE_|CY8PR12MB7490:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e4b5606-fc3a-4ea5-89a0-08df3bca03ec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|23010399003|1800799024|36860700016|82310400026|11063799006|56012099006|261021123027099003|261009223027099003|261026121527099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: eH4Jv3JVZha7RYx3w1z4TKyaH2NiTHlcGO4j1n1fZwiPGXwfFmtV/unKBKth3gKpm0S2OIyJE2Y+iO7aGw8FXNcCXqg+Sufo2/q6UxrApmaLEHEBdJMTS3TXPPMI2iyKhdK0Hks8QvKeCJ4pdjsxXNtHgt7E7kHE0fj6Jkn8a2yduWDf1fJwgWw1Y+OL3xpDDNn77+ei8f8XvI9iF4TDNB+yZHkSKPLk505tu3H/PsktPRSl2IhdI7B/hV98XBvZG6OzHuPZi3Si61tM9Mq1l3Oy15oTwlz9DN+0qFBejXHpOMckkLhfBhGYpoPFIXxlzYDYh+8qf6Fmfukq/dvmeC96nBCTE84Lkf4gF3dMZH1oV+mi1/s5bjlKixfX3XOgunAkpICtuq9sI0MFQnDT7uy5B3RHlcDqskusRXM1pijJAY2HS7JgM9akqLDjYaGQqrbzI+03zE39phJ5zBDJrZOMPrfk+03qne71IE7I4shC8yR17o0188VR12qFjdUzjtZuOqoKWPq0jbLJ7GxQk9TFTP7bIz9toB+SL8KvYx7i07d7D6IDl1uY15UZfI9qh/zUM6pmUEEmeZb9Hw1z5p6ML2Hn0KZVbA9pXbtcKgOoi27u88BpOgE666DiHXO6RWVOCWIDnxk42v7vuRBMYqhY8QQ/NwVKoaaPmgkXS/SP/f5eDpagpeGifXmPJAZCIHHgRZkpAGmVqKzJhDUffQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(23010399003)(1800799024)(36860700016)(82310400026)(11063799006)(56012099006)(261021123027099003)(261009223027099003)(261026121527099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jU4y4/B2v2Tj4oq+UXi8AWpYnLIjxBJRvAdYqIgklhroLzmo1VpcW8NFdVBMFOrtBEvvz7GZmr1nsTYUGAT2EYBIF7uEijc03/zvdx/4ra2q3ao7nmQpfLqVyTg+8vBoYarcOCgagEBLslLsvPH3CKSf9wmvjeGWc37BNkBq12c71aOzwhj3DR+fmRUdaCc9gvO5qOreMynicSeEDvVh77SDpZchOCuiUcUfgmgHvJi/g0uf/nfs8bLUNj/JcQIkrQl49cyquBZ+JwAzF9dMjRy0ptV0OEnW1M5ywJTuy6wlPtl2WKcwIGNCQRaABDn1gfG0w+JKamZHtPZpqT7idI5InA8a/JMzGODT1vrcoInAIASxIfhVzzqLwqalTm35TQGPtITcztOqHdSVEMBfITRX6n2Ax3mYY1RLv/EtQ9cWP+0Jytj3Dd5bJ358Ew76
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 05:51:34.4292 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e4b5606-fc3a-4ea5-89a0-08df3bca03ec
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF000392DD.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB7490
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

