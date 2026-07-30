Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38519C55164
	for <dpdk-dev@archiver.kernel.org>; Thu, 30 Jul 2026 15:45:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 2BAA240276;
	Thu, 30 Jul 2026 17:45:14 +0200 (CEST)
Received: from PH7PR06CU001.outbound.protection.outlook.com
 (mail-westus3azon11010017.outbound.protection.outlook.com [52.101.201.17])
 by mails.dpdk.org (Postfix) with ESMTP id 6235C40274
 for <dev@dpdk.org>; Thu, 30 Jul 2026 17:45:12 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t7Ikmkh/EAJK7TJvR/7Oz31rtfjCIVOO1CQW+kD98JKn0LzwBUqAWJ9cZsCKlBmc4dVFKsxA03215fCw8UT48uCup6t47tZJBEOsOaagyKuMBQo1UVbaQpffHLS2GcbFruPC1sWMECOIFTSQtLhCg9XQOGougU5wfguYtqUPOur3xXnFUshf0Wmbg0EOKatB2/KO6TYZJrWLKmyMP9FYbPZYLaEtq7mXULt+WEVia2kLscDqPm8blk+1wdlEzP2yWuzJxEWLWTEJXgX2eUfxGcwXq01DuCtQN/VZsqRMXU+8NZgxCBDXbj6mUQherY+D14FLZwZWgJ+fzmMm4DsORQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=R6Ka713pZdh4Z4AQGOFWTDgHP2Q+u28CbIBbfTzqr/w=;
 b=dtcBBgbNjjGU1gnSHE5O/Drt4D5gtaMxSzrXfjBC2/V9BlbC684plE4ICYrE/0M3tCTCJ7wo43L7FA+2MZufBix4mhoDKVh053awHSlxXvfqCikkrpjvwGZlGKgSPJiQncDkLHlpVmibJOppRVI4jsUlBYqQiwhCBAhquazsFK2BYzYiR6d24XwClpaQLEWgMnYAZvAOiw6rK4aPv+4zPrntLrtbJmjrjf/lTZtJhO6hzJo8tIcZVCp9KiSz8Yl+huITCvERRPDyN/P6b3+/jfEC06746N8928Y3Oc0KgHXm7/IR1KSAhnHk443/8f/L5JvAmyzZnYGX31GbBXCfbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=dpdk.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=R6Ka713pZdh4Z4AQGOFWTDgHP2Q+u28CbIBbfTzqr/w=;
 b=JnR/EiZw0ovnc6dTT1d4q5HEGC1fYzc4UnQKyGqnIMy6UYhGrCAD1s7h8MHzTLljrPD9Rg4MCtClKZbjeY8X6dAyaQ/k9jKCcwrSiGJyjTkqEDnjdV2OJiq2/N0oIx29FFkci/BcI8E4GArVRjzjQiZd08mI7c1cAK28JIzRNXHSXM7Q2IlPBsgwN2NMY7RPJdcvstRBHASGZMvtrzTMbiuNw3flKZbWYiipsZYye+AAj/hIlCjhz5t2GUxjeYSwCTkTJ3SrM804bQ3LqSHwVEqEdhca2iQ+OlbDhXVNTpvPJoABwf48C9OQ/M1IUIQ5KmVYdvufLYH9HVW3p/HVHg==
Received: from SA1P222CA0160.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c3::6)
 by PH0PR12MB8774.namprd12.prod.outlook.com (2603:10b6:510:28e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.15; Thu, 30 Jul
 2026 15:45:07 +0000
Received: from SA2PEPF00003F67.namprd04.prod.outlook.com
 (2603:10b6:806:3c3:cafe::73) by SA1P222CA0160.outlook.office365.com
 (2603:10b6:806:3c3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.15 via Frontend Transport; Thu,
 30 Jul 2026 15:45:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 SA2PEPF00003F67.mail.protection.outlook.com (10.167.248.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.8 via Frontend Transport; Thu, 30 Jul 2026 15:45:06 +0000
Received: from rnnvmail204.nvidia.com (10.129.68.6) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Jul
 2026 08:44:46 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail204.nvidia.com
 (10.129.68.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Thu, 30 Jul
 2026 08:44:46 -0700
Received: from nvidia.com (10.127.8.14) by mail.nvidia.com (10.129.68.10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Thu, 30 Jul 2026 08:44:44 -0700
From: Maayan Kashani <mkashani@nvidia.com>
To: <dev@dpdk.org>
CC: <mkashani@nvidia.com>, <rasland@nvidia.com>, Dariusz Sosnowski
 <dsosnowski@nvidia.com>, Viacheslav Ovsiienko <viacheslavo@nvidia.com>, "Bing
 Zhao" <bingz@nvidia.com>, Ori Kam <orika@nvidia.com>, Suanming Mou
 <suanmingm@nvidia.com>, Matan Azrad <matan@nvidia.com>
Subject: [PATCH] doc/mlx5: document modify field limitation on group 0
Date: Thu, 30 Jul 2026 18:44:39 +0300
Message-ID: <20260730154440.216881-1-mkashani@nvidia.com>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003F67:EE_|PH0PR12MB8774:EE_
X-MS-Office365-Filtering-Correlation-Id: 069ed421-c201-4a5b-4554-08deee51874b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|376014|23010399003|82310400026|1800799024|56012099006|11063799006|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info: 7dSVxPMkfrgRpaDW4Zki+H8ydrWZC8NnKRTQtRgbLp4nVQbfYqWkJlAajOZcwx5jPz/MfuVhYm/Uo5eHdhxXHa7MjZAuRpqRemqxAE+1fDHUVVRmZZu2WYc18gJMiWgg8KawdGJmGayQNV3kTt2Nr159qEFU4fy95MWs5US3/gNwioFxzrXypz/95yJNlUL9qkSdgRlwYdIuYJOBdUvXzQ2bMOGiZz+synfKiMS3EvW6g6eiRkKyElLur2B69RcUaeQUJavuuNkfD8Xs6ROD2U/o+wuaAjlb9BTU8ghW6grL45XPa8AlboTpGWMzwON5tpvesliJyxRFmmYmqrWAyvHcqrI9qPf43/v0bRQMXuGZVU1Y59+f6bWc287bu3YeszYHjwfQOutDH4xcyoelPPAOmPsDoDxIpyqiCCV99SmNJRrZtIOAfSTKsN/r3mp7J3ctSgo6A+YiNGfS86JTmTrq0LX1BcmIhuNvorAI4TkN0iPqfFnbzpG/BELdDqx9jcKCJKWtuEtTBiGh/LDG2RKTIvDJj7FPDukN1i5WHOWCYHKjodrjWjeuc3J49ejLx2jwYwBJEaB8DlmAKV7upXHs0qLoTl09jVq7XMT5VhqbbiAqsU65AsNFIPQBrduhZcr7P9mCUhdmm7F+hcwbEde38YpH4zpkfluoRKsk+hqNY7qNuvNIvx12mq4G3wSMZV2Qu9YQC8dIjUUqPcH6Yw==
X-Forefront-Antispam-Report: CIP:216.228.117.161; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:mail.nvidia.com; PTR:dc6edge2.nvidia.com; CAT:NONE;
 SFS:(13230040)(36860700016)(376014)(23010399003)(82310400026)(1800799024)(56012099006)(11063799006)(10067099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Msv0pHlwhRbmIHBKAi2CAwGIo6+Smpa1/eXBgMGusAb1V7o0KX5aoT/IkqLySn9V1gMuZw3rd1PQt7DIPt/Tl0/Rs7KGqbjVhZuJEOZz1JMWHqvrsa7OX95ZeWePA5JuhIUiUPtn3pt2Ctav6D7zI9Qal40c7oWJJpx7duQ7/HYOkhzhx0W867Y9AAf/FvcqlCagFEWjjH2BdNHW0bL5u0mTeyU8FE3lPItG/hnvRwtCwQOCQNxo50AR7OAuCynUkqxkQBH7GllQbMHaQ0N0cYl05kseKHciO8F2VXQwtRnmtKE4Ou31V/WbVpcILE7nYekjWfhgSRS5YNW5ME2ue0AO+GJv3qAZ6djI1C8ECqAE2tZGMG58gyHpjOGCQVcI/0keSWzs2Ne3jVQbrqoh5Do5Vy7te5vCgIaZNwiY8dCvIaORFD7627k/5UOZWSVJ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jul 2026 15:45:06.1596 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 069ed421-c201-4a5b-4554-08deee51874b
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a; Ip=[216.228.117.161];
 Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF00003F67.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB8774
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

Document that on the root table, two sequential MODIFY_FIELD actions
where the second uses a field modified by the first as src are not
supported: the second action is handled before the first change is
applied. Only immediate src types (VALUE/POINTER) are allowed on
group 0 for sync HWS non-template and DV flows.

Signed-off-by: Maayan Kashani <mkashani@nvidia.com>
---
 doc/guides/nics/mlx5.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/doc/guides/nics/mlx5.rst b/doc/guides/nics/mlx5.rst
index 9b035b878e0..aa751669444 100644
--- a/doc/guides/nics/mlx5.rst
+++ b/doc/guides/nics/mlx5.rst
@@ -3425,6 +3425,12 @@ Limitations
 
 #. In template tables of group 0, the modify action must be fully masked.
 
+#. On group 0 (root table), when using sync API, two sequential
+   ``RTE_FLOW_ACTION_TYPE_MODIFY_FIELD`` actions where the first modifies a
+   packet or metadata field and the second uses that field as ``src`` are not
+   supported. On the root table the second action is handled before the first
+   change is applied, so the source still reads the original field value.
+
 #. Modification of an arbitrary place in a packet via
    the special ``RTE_FLOW_FIELD_START`` field ID is not supported.
 
-- 
2.21.0

