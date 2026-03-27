Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF69710ED665
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 12:21:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id C813B42E36;
	Fri, 27 Mar 2026 13:21:05 +0100 (CET)
Received: from BN1PR04CU002.outbound.protection.outlook.com
 (mail-eastus2azon11010035.outbound.protection.outlook.com [52.101.56.35])
 by mails.dpdk.org (Postfix) with ESMTP id 3EFA142E24;
 Fri, 27 Mar 2026 13:21:04 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NWf0NQSDQpiNfFOL0MivjiAlAOvufkRCIJ9e0VY9vVx9foD4AVrZdHEAo36q/k6BblTnODUYH87jq9v9WtTb/lUhZ/4dP61LwrISBUwS99Lhu0h3gnx/oCl2C9wXdBVdxqqRyFB3FHzDA3UrM4xF3vExNlAXRNChKnDLLQBQByTwpQMK3XWvT7u25mqmloBJw8HOx+yaO+/81RZ6D/NA8LWSZ750w2AYZJaL2z4twBMqviTSn9F/hhIB08Dh38/VfvS8O+O1A8++9e//UMxtlGgvjCkftuLU54/7PKTihfihXMxyl4yBIvsJP585zRCP5lY93APTrXaM55q+Vm4PzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aPXcy4Nf80KXDzUPfhhgcwpGlndEGyHkGSzuCI574l4=;
 b=ppZqc6wZdWlDKWNKAIlPolQ8B4Uw4BP/XsWn6jtP3/Z0VNmooEg6gny+cI6ohNZf6gSqWxYyFeoElnSEMT0QeAN9YnohX+aV78SD9hmebJcHJ/T2wO9ofWES95fKfJ1HUBsSOjGdT+j8qvBJE0Dj+niQwnmwfKG9yOowsB1L5az4WJFPFBqwmk8Yl6vyb9D2qGcDEhruxwFS/Oy3Md5d4O/yBmSc5292WHH2mah0IcEItxb1g8tERQXSlagOYPABnoQXNafdn9JNkCK/HyVTa8hUpK0oFC/CL+jqkWCYCOgxNsZHCvztdKsmiEGjDQL6voU5wdZw31EKdAc+j+GGAA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aPXcy4Nf80KXDzUPfhhgcwpGlndEGyHkGSzuCI574l4=;
 b=dLtVooPpaghL4N+ku7RtsfDVw10q2MA2ecEKjSFABNT0HyR2fbmOoX0PbuGHSQvkEQbBbbx2YJMaDcnFRJouKfL5DfpSq2DOxIuvMvgj+6MsFwhY/2ndRH53bNIr1f1f06+cWDiarLKZssA0IYEb6wzFn6/QtjwxO4yBGAzy35s=
Received: from IA1P220CA0010.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:461::7)
 by SJ2PR12MB8063.namprd12.prod.outlook.com (2603:10b6:a03:4d1::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.8; Fri, 27 Mar
 2026 12:21:01 +0000
Received: from BL6PEPF0001AB54.namprd02.prod.outlook.com
 (2603:10b6:208:461:cafe::79) by IA1P220CA0010.outlook.office365.com
 (2603:10b6:208:461::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Fri,
 27 Mar 2026 12:21:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB54.mail.protection.outlook.com (10.167.241.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 12:21:01 +0000
Received: from BLRASNATARA.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 07:20:59 -0500
From: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
To: <dev@dpdk.org>
CC: <Selwin.Sebastian@amd.com>, Ashok Kumar Natarajan
 <ashokkumar.natarajan@amd.com>, <stable@dpdk.org>
Subject: [PATCH v1 3/4] net/axgbe: fix auto-neg advert/supported defs
Date: Fri, 27 Mar 2026 17:50:05 +0530
Message-ID: <20260327122011.1534-3-ashokkumar.natarajan@amd.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20260327122011.1534-1-ashokkumar.natarajan@amd.com>
References: <20260327122011.1534-1-ashokkumar.natarajan@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB54:EE_|SJ2PR12MB8063:EE_
X-MS-Office365-Filtering-Correlation-Id: dc25f51e-3818-40cb-2e04-08de8bfb4f04
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: GwWHaG18XGoWfDKaZpweOAO2iQnRfMP2ycnYvF/WihXczLsi3WKC09ACMZzGlKbsm+3RJwjXDajdKLLGhW90iFkodGqcPsxgNPGmrL74nNZbpJ2BDMz89kSVIWzVtoS0lvhR1t3BUzC5W7tzC4WXjrpUYN+BlZgo/QaR1f2b0lhR7Ao2iG4RcjqnzWLQz5mBICWdq9clwN4W7HDf5oTFQFY31/GlvNEONM8XvdQ7bwEl8srPlPtyxJcm9frNMSaSoODx42EuYs+lJCkhhXncxjLH9kUNLG6ztSyU7HjmFjsCMjvxq3anQkQ7Hne5PcC2Qct3qqWuwSx3miZfoK/WkqUkI83Dl7wgEjGS5BBa/azk2xFbrEOuk/gns9eOTXVsLuXTlU1gME+jg6z5efNxZcr1sQTSmYln07eWKmjgQeQ9LgYKvDix0BFxIX/0xebn+W5oJJk7RvQiS1sCQDGTkHJsf2xAMlWBNK75b/rLW7WfgZb90iRet/W5FodkuIJr64xzsR7UZHf3RXEOU5F7mCLCsQrAKC61Mgfn91L9AKsjoP120YjxhTBOTfzlHdzvV1lEGd0QL1Dq94WI2w4rjQCluoaSe3+Q68mUKJ7CZ2jblPZBhoGzZZYSoDWTfEd9b9KvHpWo+2FxlvBon7KusSaitmfyxlYdiYSWzKQsJVOon8S8maWQDhJNY7XMdopJyMZoapglbQD5IuWsBavDTypLHq/tWV1nGdk7E4S22L8IuBel+RsVMOricVxK4p9VrhrGPAXH8yG1yDecSkU+mg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(22082099003)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: vM930WNUHseiEcIFkA+nC92SaBH78A6VMLQRrILpqrAnx0592Q94E1CVOUeEc+9spZBYjBUOhow5NB5eUkaz2q63LWLyo5nmosQgdNVDhK5ug7BVrU6v2ijs/5yiMGv16Xzi6rE4qahG0FCQyYfVAe594JGgnCA/O7j0nBmQKvfrtd5VYxzoKREi6sh8ShZv5u93/Xz7CQjj7Uuc2qUETfT9YN/1yKuPZufOzGJ61o/+IiHtbHFNSRbpxw72kMQVm4k6mO9CoKl6jAoNIzUjSw9XwcJnieCw8SjIZjxfsdjzV2v6bSgIGgM4OCFTKq5Xh9WgIP9vj2ZYnUSVzedbuY+WQEtccO/cmL0Kgw/xkchvkrmWju7O1l09BQ7xRl8RwNfeOVzaPgxMsiejahLKyLJw0iobuUfFw5cRG5a299NInz3S8k8uP5W2zcmJRQAE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 12:21:01.1469 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dc25f51e-3818-40cb-2e04-08de8bfb4f04
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB54.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8063
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

This patch corrects the auto‑negotiation advertised and supported
macro definitions in the axgbe driver. The previous mappings did not
properly reflect the PHY capabilities, leading to incorrect feature
advertisement and negotiation behavior. The updated macros ensure
accurate reporting and alignment with valid link modes.

Fixes: 562825a03435 ("net/axgbe: add phy register map and helper macros")
Cc: stable@dpdk.org

Signed-off-by: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
---
 drivers/net/axgbe/axgbe_phy.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/axgbe/axgbe_phy.h b/drivers/net/axgbe/axgbe_phy.h
index 1bedd8e132..e5568cce5f 100644
--- a/drivers/net/axgbe/axgbe_phy.h
+++ b/drivers/net/axgbe/axgbe_phy.h
@@ -211,7 +211,7 @@
 #define ADVERTISED_1000baseKX_Full	(1 << 17)
 #define ADVERTISED_1000baseT_Full	(1 << 5)
 #define ADVERTISED_100baseT_Full	(1 << 3)
-#define ADVERTISED_10baseT_Full		(1 << 2)
+#define ADVERTISED_10baseT_Full		(1 << 1)
 #define ADVERTISED_TP			(1 << 7)
 #define ADVERTISED_FIBRE		(1 << 10)
 #define ADVERTISED_Backplane            (1 << 16)
@@ -219,8 +219,8 @@
 #define SUPPORTED_1000baseKX_Full       (1 << 17)
 #define SUPPORTED_10000baseKR_Full      (1 << 19)
 #define SUPPORTED_2500baseX_Full	(1 << 15)
-#define SUPPORTED_10baseT_Full		(1 << 3)
-#define SUPPORTED_100baseT_Full         (1 << 2)
+#define SUPPORTED_10baseT_Full		(1 << 1)
+#define SUPPORTED_100baseT_Full         (1 << 3)
 #define SUPPORTED_1000baseT_Full        (1 << 5)
 #define SUPPORTED_10000baseT_Full       (1 << 12)
 #define SUPPORTED_2500baseX_Full        (1 << 15)
-- 
2.34.1

