Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9289A606A31A
	for <dpdk-dev@archiver.kernel.org>; Mon, 26 Oct 2026 16:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=nj/0ScLh
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id E6BA640689;
	Mon, 26 Oct 2026 17:28:03 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012047.outbound.protection.outlook.com [52.101.48.47])
 by mails.dpdk.org (Postfix) with ESMTPS id 3C2D94067C
 for <dev@dpdk.org>; Mon, 26 Oct 2026 17:28:02 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LLbDOcgkA9qqTfvI9V/pi/xaWj9urgK5oj7fagEtmvbBEk9BnO11y6g2v29xxacLiGcs75GC4cq4Twje3xLmXL/11wEYS8IbKQWfa50vKW9yRkNYgmYrgqVoDH8NqxQ/aOPA3tlk8x6Qh3s9hs3pwAJPDw9AAxE+ba1PC6o1leRTfoQInSrIs0ZiQ4WU+g1bO3/9manfOEzYbrkg1uplK4q57YUq1TXzS79n0NZSdFtiCtUf+idzWlZJ+5RPOReQWye18sDTzU6daAJ9951QybEiOJxtLW7jr4I1LHyPau9c7db6jjBs8gHjs2AgxtZN9lAAQ/EQS0C3sq/j+JMvmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wttaS/ciSlk/lw+hSCBIIeeflExbGdFfqWLPCWdBMTY=;
 b=TwVPnYUl6FUGBkAZJuMboyThQJvWLj7aXmWyoCKfxUXAcp6fOgV+dqTjHwaBnsZ/5KLxcg9Vtbs8cYgIkjpec7YrLoE+RH8yixyoQfnO4s7Dm6bt6LZ83+PuwsDLGjLkvcoppee44g031+rK9biEO4YMkryeJaDJEX4QjTidiBCXXHlKw5pcEEAobrKcD1RdKPWgFnghbZuR5GujoD23cgr2UlHthu+/gs0DtQl+bN0AeTz9e8sPUYsfWTGwVms9Oy0Kbzo3y2K1c2FhyLT9zIt8c2dM9A7kzW8JakcY/ZTyev5V0GOgIz/HIxLTLnAcwC7n+qjPYRcvongn897VCQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wttaS/ciSlk/lw+hSCBIIeeflExbGdFfqWLPCWdBMTY=;
 b=nj/0ScLh5Tko9HrnyoYsW5/TBqGzcIZVr2Rkz6WwYxwPZprtIicaI1gYcBblpeKBSYWHtOSMiWzTRuksCTN5SqCqq60B8Wc0CAk0jMr+1EfxF4OIErEPJecCnfF1D5YakITjgDGu0Hey867paeGqKVsKSNVb2KRT3WaXHvhGnamlySqPR6TpGjMt3r1BMkmfLpRz942WacmLDEtD0YDOT1iRuk1GNazRQ8lgtaMOdMRyL5DaXEL3nwjAwe/h0RDuwV1gqlqJQwGIpwKbCSSeMzl7bWCThPh5GyfOLSi7y5QDX1aL1vWugIUrAIIxSVHTiMQME8xRt1AVktsS12bDYg==
Received: from CY5PR15CA0071.namprd15.prod.outlook.com (2603:10b6:930:18::16)
 by PH7PR12MB7841.namprd12.prod.outlook.com (2603:10b6:510:273::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 16:27:57 +0000
Received: from CY6PEPF00000049.namprd03.prod.outlook.com
 (2603:10b6:930:18:cafe::87) by CY5PR15CA0071.outlook.office365.com
 (2603:10b6:930:18::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 16:27:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CY6PEPF00000049.mail.protection.outlook.com (10.167.247.134) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 16:27:56 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:27:34 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 09:27:32 -0700
From: Dariusz Sosnowski <dsosnowski@nvidia.com>
To: Viacheslav Ovsiienko <viacheslavo@nvidia.com>, Bing Zhao
 <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
CC: <dev@dpdk.org>
Subject: [PATCH 05/13] common/mlx5: add check for auxiliary device
Date: Mon, 26 Oct 2026 17:27:01 +0100
Message-ID: <20261026162709.1292958-6-dsosnowski@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261026162709.1292958-1-dsosnowski@nvidia.com>
References: <20261026162709.1292958-1-dsosnowski@nvidia.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY6PEPF00000049:EE_|PH7PR12MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: b3aeaba8-9a02-479b-656e-08df337e17a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|23010399003|36860700016|261026121527099003|11063799006|56012099006|261021121427099003|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info: TXrqv4IAW8tojLAOzpiNyNxxixL34fIMqfBOetfZcactJPWcoMieVTqJ3WcImOOe+1nAdnQLHJPnRVsNRWcB4iIdT7Rkuo4bR6rTHvhRQzpwHyrY2+P+nl9okV07/iDuMyoi65iysLqlt9X/kxWH++K841w7tEDyVaxK5umB8eaRdHMMgdf+Gr3IDM9NQ1c2/4JWkTN/qKl1Fo5+7HZzmKveBQDxM5jvhHD99A9fPXQlaMTTcR97f/WOC9GH/UsfdN7Kgb2xvbMWpx6eQC2fs3+OT5BhCORdFRfx2akZADDQgyWrUYGkcbXpDhCdqgedlZAOoJsUOo70TmLzYxuZsOe4e6Irl8tVehNe9aKBo8UomlbdspDyvG8bDtyL5ck3TtR8Y6LKQuQ5IxtXiymG/27CGZ5JuM6OBAFZMSNI3n9bKZQADKOlI8guWOV+besr7fxKyu2jMW6timj0z0jBvoJN2DPAww1Edst9R2q3iFPmPcXVbQKlfF9rxcsyqLrCXKHWo1eToTsu+38Z0jehMyjTxMwAAaV+RQt9f8VJrzDq8rlnRRhGajhvVObNHiwfC/iz/AbDudEkUg91VKe6HQ+43RIiEvPRytCVhUhP6jjhauMZW7zrRy20dry+8bPjuP2WM2m2CLOfUPTv5Uf4GlhktHHjheVa0xaQZt/WQIJbB9Q2a6VsceWhk00Jf9QtagW+mNzaVMi4USg92uM7ng==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(1800799024)(23010399003)(36860700016)(261026121527099003)(11063799006)(56012099006)(261021121427099003)(261009223027099003)(10067099003)(22082099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4f1FbYuM4Ncdb5g9JJ62wPMiXLOAPTSurrrDAMPDmcj6l8aZlM2OajusCfRNgHyz+gcwhBIoZ8h5DLOpOg6/lKYOHOAvGdmPUu9rF+XjC4DQMQRqdutZSNncqZ8Tw3fx7ZmHy5sd/jGMjkNp2qwiEeLTppxrf9a3qHfmlCzQdfiQntH/0/GFnLG7DtI+wcZLhgQXI3VvwcJWy74VenoZo96XP6gq23nfuIrwDNpWOBQyEt2azFzEAeVWv1VNoEQaYerco7UfPH1N4RaV4nufaeCXig8Rf5jYCVewLrnZ35DlkSux4mxYAtG8F0Z4DTJI0amF4canYkhCmicVH7poqWozHfz4aC9L/qiOnzvbtc+J/U/pZZlYB5EswftIY8wiyZjcxVjjN+P0Y/JHlNswtE0v9Nx9Ixk0vh0m4a9JKgLhXiTvwlJCgb+/XR2mXDVy
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 16:27:56.4433 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b3aeaba8-9a02-479b-656e-08df337e17a6
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CY6PEPF00000049.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB7841
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-19.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add function for checking whether given rte_device is probed
through auxiliary bus.

Signed-off-by: Dariusz Sosnowski <dsosnowski@nvidia.com>
Acked-by: Viacheslav Ovsiienko <viacheslavo@nvidia.com>
---
 drivers/common/mlx5/mlx5_common.c |  7 +++++++
 drivers/common/mlx5/mlx5_common.h | 13 +++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/common/mlx5/mlx5_common.c b/drivers/common/mlx5/mlx5_common.c
index f4b8904366..11a53c8b56 100644
--- a/drivers/common/mlx5/mlx5_common.c
+++ b/drivers/common/mlx5/mlx5_common.c
@@ -138,6 +138,13 @@ driver_get(uint32_t class)
 	return NULL;
 }
 
+RTE_EXPORT_INTERNAL_SYMBOL(mlx5_dev_is_auxiliary)
+bool
+mlx5_dev_is_auxiliary(const struct rte_device *dev)
+{
+	return strcmp(dev->bus->name, "auxiliary") == 0;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(mlx5_kvargs_process)
 int
 mlx5_kvargs_process(struct mlx5_kvargs_ctrl *mkvlist, const char *const keys[],
diff --git a/drivers/common/mlx5/mlx5_common.h b/drivers/common/mlx5/mlx5_common.h
index 8b8f20e2f4..f579ca0904 100644
--- a/drivers/common/mlx5/mlx5_common.h
+++ b/drivers/common/mlx5/mlx5_common.h
@@ -596,6 +596,19 @@ __rte_internal
 bool
 mlx5_dev_is_pci(const struct rte_device *dev);
 
+/**
+ * Test device is an auxiliary bus device.
+ *
+ * @param dev
+ *   Pointer to EAL device.
+ *
+ * @return
+ *   True if device is an auxiliary bus device. False otherwise.
+ */
+__rte_internal
+bool
+mlx5_dev_is_auxiliary(const struct rte_device *dev);
+
 /**
  * Test PCI device is a VF device.
  *
-- 
2.43.0

