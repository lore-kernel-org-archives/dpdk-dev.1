Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C443B606A31B
	for <dpdk-dev@archiver.kernel.org>; Wed,  4 Nov 2026 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=E+b2KuQS
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 00CC3427BB;
	Wed,  4 Nov 2026 12:21:00 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012005.outbound.protection.outlook.com [52.101.53.5])
 by mails.dpdk.org (Postfix) with ESMTPS id 1EB0140A84
 for <dev@dpdk.org>; Wed,  4 Nov 2026 12:20:59 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g4wOWB4XevZEiBINSnv5k0dMe5wOGE48/2hYiTHVfwOZ+kwcP/wAbFk2oGlBHerzJ1y342xzMYN/x9jXFI9l7LJOXk6Ce+4NYK1eQuMnFNUHdZdXs51FNsubrPLm75yiwco9lhkZjgFa/RPoWiWRSSpYBHzlqK6m8xnEmxDvGYnjFu5SSRnNrKDyBvepzSsIjhUfOcm6tjG4HVJmzlUauxrOjSQXxmk+BcZY0E24icfTpHFJ9tFcvWu7otQfV/PcrItO7P1HvmJ3g1QcQmTV5eva68MyOM83CgfnqR14+z5kSr+nL43Ie8q1HzMO4pksVU1jk30HMRW0yqxq3lc8tg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nJO1vhS8AZH6p8w2wdSP8jA8IH5qZbHkMR9MatCrNtI=;
 b=YWE4aNMd/78v80XJWpNO9RakKLp+9cFkXeqKaHbrnwCfdsI+rD7MQc0KbdsjVpJcmq18vQHsecFafChOFwpwVD5Ejygp8rlxFOwKuBodK+ghDfYgugFG/w7N+4VTtFx0vH7TjbUUdTAc7uB8/PY0dfQyeeU8dF9XaSaqUyzW8NvbsAI1dg/1ebXkoc0lZvVrr42NnMfa8h3omS301HDLFwmcDfvDmmNjIsv8yfusD1+y8reUOVbMD8woGWnS+eXB8t62nPtGO1OFDpO/Yyz1CeWqAOY0eCLwhqaBOlGSBv20kshJSqxIoZCUuYzE4Lz9uGW9jN+riRGR+voqHTGKvA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nJO1vhS8AZH6p8w2wdSP8jA8IH5qZbHkMR9MatCrNtI=;
 b=E+b2KuQS+bWMj8PdO7dKVDMfz+cZF/mmYe0L1wZXS9IbgveP/PMlYQ5qcnHwK6DHLafqqiyWvyqNWfgfpShcglMYX/dyvEOZRU/HhsoxeGF5s/vjR6/St44Fg6B9Hd7U4BLwWB16f3iwneJmVdNck2/wbYp4uo9DetAWI2ZROnE=
Received: from CH5P220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:1ef::7)
 by SA1PR12MB6846.namprd12.prod.outlook.com (2603:10b6:806:25d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 11:20:55 +0000
Received: from BN3PEPF00022BC8.namprd05.prod.outlook.com
 (2603:10b6:610:1ef:cafe::8d) by CH5P220CA0001.outlook.office365.com
 (2603:10b6:610:1ef::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.10 via Frontend Transport; Wed, 4
 Nov 2026 11:20:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF00022BC8.mail.protection.outlook.com (10.167.248.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 11:20:55 +0000
Received: from cae-QUARTZ.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 05:20:52 -0600
From: Raghavendra Ningoji <raghavendra.ningoji@amd.com>
To: <dev@dpdk.org>
CC: <jingjing.wu@intel.com>, <thomas@monjalon.net>,
 <selwin.sebastian@amd.com>, <bhagyada.modali@amd.com>,
 <bruce.richardson@intel.com>, <david.marchand@redhat.com>,
 <stephen@networkplumber.org>
Subject: [PATCH 13/13] raw/ntb: remove unused AMD register definitions
Date: Wed, 4 Nov 2026 16:50:01 +0530
Message-ID: <20261104112001.661769-14-raghavendra.ningoji@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN3PEPF00022BC8:EE_|SA1PR12MB6846:EE_
X-MS-Office365-Filtering-Correlation-Id: 328d6429-8049-4418-ec14-08df3a65b1a8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|82310400026|23010399003|1800799024|10067099003|18002099003|22082099003|56012099006|11063799006|261026121527099003|261009223027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info: YdDUK0DT5fjH7V4v6Q+n3YNhHDkh+rhH1zVOqc4Ts8qVZ67qpZ39BkY4bNYm+afpy3JluJROrNY8ECEnzJjt29JSc8wrp/9gtVGrSRkYMi8+2oxVjLNRV5UKIJW9syzabHmy9WW7XmwQEbJSEFjbndrzddHVaXyH1H5/q9LDSQRC1nR359kqT1EfZeqcvfCmd1pbBNlRBkoc/hTbT1RKuUqhz7Wkmf3E8QgRjNxDgS9fHnn6beAIuJSx6FStmoZQkDWhVwGLp7tryVu2UUAqx8wR2iwt92O5fFAW1FtNfyO7CjZTxqPKpchlF9L9H+9gABVIvc1Qp+yCw4SrVcUm1wFjBZaMyKP725hfECigMteVFOFCfSOuZQl98yW6twx6nI8Ai8orza9Obj+FwNxunlKLwZLT/N1jbEYDauQCbFLm9l/BKIKW+MId+1coj48kFMGwxHpI6em+v15qhLbJLBvkBhzi6DaWDRCV0lNmrrXlq+P4FL/BphRNkKblbhLkekFkaXNkYRz+cBoTgPInJaaDlLKHrDj9N+rqqGfPw9nLwpc5J0U87RQLkhSLn272OougnQGy3GJ5Sobzv2VUGj1Gnn5ycu623exR5pnKByFEmwpM3cn/V7Kf/QCtNWITHvCD/YPE6wjE2apjtM7GT8ecoJFs1rUsXEaeO+g8p5MYgVfQXX6JoegcNXH+J78Pwk2qnkouj3rgJkaAXHCEAA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(10067099003)(18002099003)(22082099003)(56012099006)(11063799006)(261026121527099003)(261009223027099003)(261021123027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: W0+8RBGPnIOQhCytiPieQ6sm9vo02utJwxTNIFm+15QTRVvsLeuosQTEct+MO1TUck4i7jIVOfB2Ojk2ngxUUTBJZXM/Rudm6aXNtMe+TgGULeXGse/7MZ0G7WtvWbsXvGi5C9Ntu7P6qqOW8kuERUogbbLeWZ8SLwHQwfis/1eqyij7n4EOaZ5DYQAiGzIOFyaSPj038+G4yEOZpAqCGoqz1/8JmOKFQPR3Iceb0i23rOV+G7ZrrhVHKieCH2WVyDcbNnnnQChA47jps7SEmbyvSzsQ+WSx8AJIfdMZ2S/WQDp+uhPwqiONcyyxA3AvNS8ctuioJdRen57exhQNKQ4udn9EimGZ1B6q0Ukcee+u3c6LApPxF1Chds7aAhwHZyjkhnWZgOhIoW+pZSWjjSmHHZKmhu0aBqN1oKcff7KmNEPMI02aoX5wBxacZK18
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 11:20:55.6210 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 328d6429-8049-4418-ec14-08df3a65b1a8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN3PEPF00022BC8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB6846
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

