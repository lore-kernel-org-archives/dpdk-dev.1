Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C97C7CA5FA5
	for <dpdk-dev@archiver.kernel.org>; Tue, 29 Sep 2026 12:52:04 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 1A7A9427BD;
	Tue, 29 Sep 2026 14:51:57 +0200 (CEST)
Received: from SA9PR02CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11013010.outbound.protection.outlook.com
 [40.93.196.10]) by mails.dpdk.org (Postfix) with ESMTP id BFE0342793
 for <dev@dpdk.org>; Tue, 29 Sep 2026 14:51:51 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H7wyyiptfn788uGFw3872YE8bORfYgGfYX+c6sfxWK3JGLGFy1QbV5d/EuebpYjvMWu5eIXajo/CnZv74eTq7ZhejJuhW/epa6uxO2eVqLNZ2IOdWokzBrhlWCnMFsggK1nGUHBVS5ozn/VVYMLN3JnSaW5uQ4P4dp/WBOfC68NUX6Gzuqmmi7lWBXMqj0FBaVAuv7NuczoFfEnfoOL0dQtWJNsAGvnF3tXQd67roNuioYaPNh4MUYZ1i88lsn9K4Y+MaHJ16TX+EGwI7lOdwYeV/CnCyRjv0K5BhlJgpwPQ5U8AS6p9HphutKZEaUH3BVGmZOBRGfcMFN2rJ4Y35g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcFOK9y2YP+y80tCxXVZ4AKRQDo84g5hp2enHMNBt58=;
 b=X3nfKgkn6MHYEeeaggXKS/W5ep7w1FLPZkMO4Wbka/nIDue2nm378O6KfnUStA+UYKrZ4273N7ZNsEjj1GxKzz/Fa/c899JZyJUHX8oH+WzxcutSXfhgtHzKoIYUzfkpLPOoFbX9k8NNcxOXktcGPtw3xFyma8mV+Su9aB3kl5MHisF/Vgywq4UtRZUESLkgzfQAtaRDXa6pMyTtqx/ifgLbZgQ2Yf2RETp4wPxR8jPtNi0CHXpp1njFOiZHzO1twR5qIqbFq3CQmKspe+AlFbaJN98tlHX440t24MyjEnZzIJEbv2lAzYJszpsmRbIEahp85Jb+B/WijSG//VsYPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcFOK9y2YP+y80tCxXVZ4AKRQDo84g5hp2enHMNBt58=;
 b=cj5R6EQtaVQcqwtdLhiqBWbEdK3sWBEsKGvB6s1PY5Uir+ki9fNMBYdtlQ/CewlH5j4vAJYCKR6mLJcv/QxxRQox0hhRyDozgbYbQ45ywv00gamG4Su/q5YfNxk34ozarkcitHzdGcyuT0iqfkzSKThSLuzFaLCKMLtxDu1fRvnUQmsmURgHEnykWMBye8Dpzte2HOUVge8OO6D9icKIv1gS1lRhPt7lpINfT2AYA18H7eMN2KAlN++jzfXf1k8QP9Zwk8CFQc8kyntZEEd5dwL6ml3AQ5oz+EPm62uWpql8TCvdPwWBZ42PfiWhOPxiaLaSnAW2/7KyS/zBH7CIwQ==
Received: from DS1PR06CA0002.namprd06.prod.outlook.com (2603:10b6:8:458::8) by
 LV8PR12MB9232.namprd12.prod.outlook.com (2603:10b6:408:182::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Tue, 29 Sep
 2026 12:51:45 +0000
Received: from DS2PEPF000061C5.namprd02.prod.outlook.com
 (2603:10b6:8:458:cafe::88) by DS1PR06CA0002.outlook.office365.com
 (2603:10b6:8:458::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14 via Frontend Transport; Tue,
 29 Sep 2026 12:51:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 DS2PEPF000061C5.mail.protection.outlook.com (10.167.23.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Tue, 29 Sep 2026 12:51:44 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 05:51:21 -0700
Received: from nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 29 Sep
 2026 05:51:18 -0700
From: Raslan Darawsheh <rasland@nvidia.com>
To: <dev@dpdk.org>
CC: David Marchand <david.marchand@redhat.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>
Subject: Re: [PATCH v9 5/5] net/mlx5: accept more unicast MAC addresses
Date: Tue, 29 Sep 2026 15:50:53 +0300
Message-ID: <20260929125054.85048-4-rasland@nvidia.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260924063836.355745-5-david.marchand@redhat.com>
References: <20260924063836.355745-5-david.marchand@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.126.231.37]
X-ClientProxiedBy: rnnvmail203.nvidia.com (10.129.68.9) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C5:EE_|LV8PR12MB9232:EE_
X-MS-Office365-Filtering-Correlation-Id: 443ba369-0103-4c78-d68c-08df1e286adc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|376014|1800799024|11063799006|56012099006|10067099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: 5GByeBgFVbQZ44i/y7uShLtK7+526AWQlJeoCRzmnHm2mLzZ/FJT1ulynsqlbU91HQ8ISoqX+A5ieh8z/53lSEGpejwPd9tToozN/7O2yBOuyVPRrpyCeLf7u0mQZHi6pyHlccKjkW9e1MyHBSxZ6X2DQCJXf7iags99Z/Y4Pd6Bk9iLA47MO192vaKtQY/295eQNUGNyBalh6lldKtY408oKO7QswlLcfeAU1mmjNesEGlQdVakzHgiUpBV3tOX6nMlPY+PBN5KDfDtHbMJt2mhR3gE2FS2YJgzu+W5S75/8Psbq72T1H+nIyUt9EgBgmXfNa0iBrQ5NTLWKTq6rpkCdr5vDnJ/D6linokO2FWksNpAn5fx8as9agv4GSVvBd9+9N7lLHY3+KKOn5RtaNdsowZTCkwqpqT4bbROmwH2z8MNQ1KDquEORsKJKFiChWKKicqc80nadTq2vWCfWVfvH7uHeUlBMcfh7EHuK/T2T44eM17301mLZ8esYznnSRJLI5heEs5xXRBnJjJbaCQWctQVLxO+EfNGmglar9biL1wCBe0h6f+ZxvyjYl9hUzEC/i6CZAbv+T1Q6B3FE83ALJyN27bCdmfOxyy7Z1TZmqg8LF2+KBaaDYCN7cTgQMBTfAtWYobB3ZMzCDiHLdE+lye08a24YTT9FSzn8SiKbCsJijN2PdcIdc0irXTN04wgmi717SRb9TcLZJt7Tg==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(376014)(1800799024)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 7KkZQEDjcnW+Am3jD/WOj2qNt30n3MmQi+6h3/2M4RqcOyUeJOkpflyu2Ei35QA+P5kR64YYg08H4AXWlxH5e8MvtrXg8lvZhpI+S/6nZiguQZ/XlMpFYnF2FOCzfpReGz/Qdyg/nnGKDvuffyR5yqnIHuiR4kE73kLsQSw7FkSHu6i3YKmEVbjyMoBO1rE5x0DoFs6u/9WtLrnIWO/Nyl00tX6jRXnj5LDliz7sa2jIDLa8vxDhqPreXyaSTAa6vvfRM4ZoniyDdUcQpUXSr/u14WerGjModZpDmGrH3lK8MYYqWjGnWhW0Wy9Y9nlhHA/WzmlcEBPvync8cLrXrLko0s9XmJTfEHY+nEf7MhIwnWGgNsU11sskmAt1G4FqTMQtF7FnsRg+69RsnoddwZF9rm/pXwTCtPlB6FDC4rSnFmAncNvpcWsV8nLP/mTd
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Sep 2026 12:51:44.8851 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 443ba369-0103-4c78-d68c-08df1e286adc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF000061C5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9232
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

Acked-by: Raslan Darawsheh <rasland@nvidia.com>

I'll squash the following fixup into this patch during merge, to handle
non-DevX devices (where mlx5_os_capabilities_prepare() would otherwise
return before max_uc_mac_addrs/max_mc_mac_addrs/max_mac_addrs get set,
leaving them at 0):

diff --git a/drivers/net/mlx5/linux/mlx5_os.c b/drivers/net/mlx5/linux/mlx5_os.c
index 9180e9aa20..7c2c35c945 100644
--- a/drivers/net/mlx5/linux/mlx5_os.c
+++ b/drivers/net/mlx5/linux/mlx5_os.c
@@ -325,6 +325,16 @@ mlx5_os_capabilities_prepare(struct mlx5_dev_ctx_shared *sh)
 	DRV_LOG(WARNING,
 		"Tunnel offloading disabled due to old OFED/rdma-core version");
 #endif
+	if (hca_attr->log_max_current_uc_list > 0)
+		sh->dev_cap.max_uc_mac_addrs = RTE_BIT32(hca_attr->log_max_current_uc_list);
+	else
+		sh->dev_cap.max_uc_mac_addrs = MLX5_MAX_UC_MAC_ADDRESSES;
+	if (hca_attr->log_max_current_mc_list > 0)
+		sh->dev_cap.max_mc_mac_addrs = RTE_BIT32(hca_attr->log_max_current_mc_list);
+	else
+		sh->dev_cap.max_mc_mac_addrs = MLX5_MAX_MC_MAC_ADDRESSES;
+	sh->dev_cap.max_mac_addrs =
+		sh->dev_cap.max_uc_mac_addrs + sh->dev_cap.max_mc_mac_addrs;
 	if (!sh->cdev->config.devx)
 		return 0;
 	/* Check capabilities for Packet Pacing. */
@@ -389,16 +399,6 @@ mlx5_os_capabilities_prepare(struct mlx5_dev_ctx_shared *sh)
 	sh->dev_cap.esw_info.regc_mask = 0;
 #endif
 	sh->dev_cap.esw_info.is_set = 1;
-	if (hca_attr->log_max_current_uc_list > 0)
-		sh->dev_cap.max_uc_mac_addrs = RTE_BIT32(hca_attr->log_max_current_uc_list);
-	else
-		sh->dev_cap.max_uc_mac_addrs = MLX5_MAX_UC_MAC_ADDRESSES;
-	if (hca_attr->log_max_current_mc_list > 0)
-		sh->dev_cap.max_mc_mac_addrs = RTE_BIT32(hca_attr->log_max_current_mc_list);
-	else
-		sh->dev_cap.max_mc_mac_addrs = MLX5_MAX_MC_MAC_ADDRESSES;
-	sh->dev_cap.max_mac_addrs =
-		sh->dev_cap.max_uc_mac_addrs + sh->dev_cap.max_mc_mac_addrs;
 	return 0;
 }

Thanks,
Raslan
