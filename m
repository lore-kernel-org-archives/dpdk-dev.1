Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9ABD1C5AC80
	for <dpdk-dev@archiver.kernel.org>; Sun,  9 Aug 2026 09:49:09 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6BC31402E8;
	Sun,  9 Aug 2026 11:49:08 +0200 (CEST)
Received: from DM1PR04CU001.outbound.protection.outlook.com
 (mail-centralusazon11010049.outbound.protection.outlook.com [52.101.61.49])
 by mails.dpdk.org (Postfix) with ESMTP id CCA4E40298;
 Sun,  9 Aug 2026 11:49:06 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KtjZ418y5mGyPDNotgxGem8jB0zxqSriBT6pd4ngOtdeoSj4ixBng3yiPRal91m+ggwsmga4yOWgwOty5E8QIuU73ufALXHW0DLqlV/4kDqLlXM7oAEAj5GjFLOFepM7PLnW+HbMFl+S3zjKojZ8vqQ2vOyZFLdjNovrh9dzRLM22pnGJALqqcH21cp8Ilqjai7nJb5liZPwJcekcYW5Pf6isFn7W7B7IQ600F9vytqT4L8IyAuxWZjqg4Skv33gdTo7RlyYsP0aNF9aMN1rGmvv9UhylwgQ/QefRKtmOIop32OxVEZAI/W2P1wrYgWf3EtJQWKbQ6nVV5yK8MkI7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4Sts/UXH2vxUm/Jhk61ku8hObzo7Ws4HVDEy/9egXKY=;
 b=IkxwDT6byZ/iv9dNR64DROJ6+95Uoy+6vVL9Ep7A0YQIAmnqjdZ6IGEIWpIwe3oDIMt0pCpolsvLh6Bo6ckDkGoFLVrkBBQrXAUfxfwCAdwIQnRE/G2AxZavf5fjdAuZo0njNhRfkaN6i8vrkKCfuLK6z65OtLb3h3/+u0IpsXE0NIMEBTJMZKUCXFvHW1bbvbi1rQ28M7uLQMhgNPH2tF+6MKDWnQO/nfJ7T2Tm+X9JGSHPcKd2GtiNEhdj2TgAzZCX99LcfQ3jAnK9QWvJ/B1RKwbc4rWC8Iphs3Cz332MlxlwltLyg6OfcsUTNIS9Nev+OXUOocRvznpHXj96dw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4Sts/UXH2vxUm/Jhk61ku8hObzo7Ws4HVDEy/9egXKY=;
 b=AZpuIZ54EJbYbzZfj39i3LMfNi9wbdRDE3H9clBq3W423AxH6pctOAbYrgIUZ3y4OECIsqkdQCgxDpVj2mAxz4ua+e3L0DQgdp60EtHKCb+16W1PbvfW1ql3MExTyDf81dysbqxdd1n0R2b9ngytZ3EQNsOJlsakZX2oJaVdSv2MJPZY0z6NbGwLUNt6KeIeRtQIYoVBHZ1GgG0PPyWg66lMBd7CsyVMv9/oZ1V3zgdn9Fak1n3f+EBL1CnVFW16RPF5xV1HSVY5AlB6AZl4oy3+ifdwhGOn5Uz/R+gU+TojrKiK2+vUEBCFEvNelWcBgO2Vh7fOPuVDDpfMDkG+2A==
Received: from BN9PR03CA0655.namprd03.prod.outlook.com (2603:10b6:408:13b::30)
 by BN7PPF5D27497F1.namprd12.prod.outlook.com
 (2603:10b6:40f:fc02::6d1) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.23; Sun, 9 Aug
 2026 09:49:00 +0000
Received: from BN1PEPF00004686.namprd03.prod.outlook.com
 (2603:10b6:408:13b:cafe::1f) by BN9PR03CA0655.outlook.office365.com
 (2603:10b6:408:13b::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.292.25 via Frontend Transport; Sun, 9
 Aug 2026 09:48:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 BN1PEPF00004686.mail.protection.outlook.com (10.167.243.91) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Sun, 9 Aug 2026 09:48:59 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Aug
 2026 02:48:45 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Sun, 9 Aug
 2026 02:48:44 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Sun, 9 Aug 2026 02:48:41 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, <stable@dpdk.org>, "Dariusz
 Sosnowski" <dsosnowski@nvidia.com>, Viacheslav Ovsiienko
 <viacheslavo@nvidia.com>, Bing Zhao <bingz@nvidia.com>, Ori Kam
 <orika@nvidia.com>, Suanming Mou <suanmingm@nvidia.com>, Matan Azrad
 <matan@nvidia.com>, Thomas Monjalon <thomas@monjalon.net>, Gregory Etelson
 <getelson@nvidia.com>
Subject: [PATCH v2] net/mlx5: fix uint16 underflow on Rx queue error path
Date: Sun, 9 Aug 2026 12:48:37 +0300
Message-ID: <20260809094837.123931-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20260730135620.213682-1-mkashani@nvidia.com>
References: <20260730135620.213682-1-mkashani@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00004686:EE_|BN7PPF5D27497F1:EE_
X-MS-Office365-Filtering-Correlation-Id: 78cc69b3-e47d-470c-4e35-08def5fb6ffc
X-LD-Processed: 43083d15-7273-40c1-b7db-39efd9ccc17a,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|36860700016|376014|23010399003|22082099003|18002099003|56012099006|11063799006|10067099003|6133799003;
X-Microsoft-Antispam-Message-Info: jBhAj0e0kj5jAS+ugwhdyNdicxKXZZnAqFSN4s2HTAzKS0Mfi93Arvotyomb6zHaHRQP9Vj5wVpTICe064lBGabXPg38r+ukUuuvWWskvRuJdjxx1yTMGeS1uNiU3jlfLlnjwzqfoiAzWEnmpB/2Euv31Jm2M0XJy4Be+Q+XW7nXqpOg0e4xWvudiB9VLbjMM4FNPOGfSAf95YZzrjG7TVaGo5shanmsHwFHCnjADOyCfyMJ83swYYzxzNbLetuXQHxFPYlzNDEwDaEbPZKtW4evneusP05L1Tb7HQ3JPy/TQ406GNk4ud15VHSvmz/LlA5MC98mdAj1jUv6KvYiPWOQ39/47C0CTrJAbI2t1JXeZLnPd7oZ2N6wHM308AYjd7tnr0eMV3PO7KnyIBeB8OwR8Qif3DKL3TMMtYSAXQCEoXoeCe9hf9249Kg3l7xoYLnSiEMjeaS5TJYhCwYibM1H13PjJdLbq4cWMWdXrhW4vCfeQFSgDWEeZIvATIg6JX8h/MjOg1IWEm4Q8la+dq7TKb3f0CJwpzuT0scUPA99yr/GtVivuCpBIPCSzRMX81uV7FMmb8XrkcFqDRHhSruGvZJRgDDfdd7dyTQnHusfdQ+cb0pct6mKk71EiWPQVeO5HHMm87ZECxrOpcmX3aPTPrkWlSFkgvAjLK+iSAPx/kvt846DLDpW5hsBvkHh
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(10067099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Fp4UKwxXKxNZ3jnXICz6GZOMEFqJeAS0tz/TFJY/k7/288uWtqsZilgeqHfEjpYd+B06Uf1JNG/CBfNdSVHIeho9hifHFBtmNKg6s2OUO+5jmR/d4DKOfL9ROHOTr13gQ0TfeBkClcPVOAou8Ah5MhNLu04EkFSGukfVMJ6DmlsEnUWBQL4iok4Z+VGwA2mZDRwiKtppn1crWfP24PpUgnTKHulMHy8Jxw7z4J88Xik8yHOSiu1sSKHxTNZ5c5yKpKzu5tldPaRzSlAXVbekt33oH7LHefbpepTKBdqoii29KfaE7o47WHlwkl+soLnHbtz4lcwU2U+EzSmwrYgAJeS0JV6IfCICJYJlfXaIj7+JFcJzEzkp+XK45oNFTesNU3V9/mzet3MH+LQE2DlB02lB5+fDj/PLvFBXpS1M6WczvgptHfM/p93biZEBe+ke
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Aug 2026 09:48:59.5745 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 78cc69b3-e47d-470c-4e35-08def5fb6ffc
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: BN1PEPF00004686.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF5D27497F1
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

Avoid post-decrementing the segment index when it is zero in the
error cleanup path of mlx5_rxq_mempool_register().

Coverity issue: 503770
Fixes: 8d1cb02da5b7 ("net/mlx5: support selective Rx")
Cc: stable@dpdk.org

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
---
 drivers/net/mlx5/mlx5_trigger.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mlx5/mlx5_trigger.c b/drivers/net/mlx5/mlx5_trigger.c
index 25847c8ba2e..25bb448a708 100644
--- a/drivers/net/mlx5/mlx5_trigger.c
+++ b/drivers/net/mlx5/mlx5_trigger.c
@@ -187,10 +187,13 @@ mlx5_rxq_mempool_register(struct mlx5_rxq_ctrl *rxq_ctrl)
 	return 0;
 
 error:
-	while (s-- > 0) {
+	while (s > 0) {
+		s--;
 		seg = &rxq_ctrl->rxq.rxseg[s];
-		mlx5_free(seg->null_mbuf);
-		seg->null_mbuf = NULL;
+		if (seg->mp == NULL) {
+			mlx5_free(seg->null_mbuf);
+			seg->null_mbuf = NULL;
+		}
 	}
 	return ret;
 }
-- 
2.21.0

