Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B9410ED65C
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 12:21:20 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id CD00C42E47;
	Fri, 27 Mar 2026 13:21:09 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010038.outbound.protection.outlook.com
 [40.93.198.38]) by mails.dpdk.org (Postfix) with ESMTP id D716742E47;
 Fri, 27 Mar 2026 13:21:08 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kJRWanFJv4aJ0MnIviaJ9y7rbmxUlavtAiY+z6xE4PJ+/t7VRlVGQLWf2kUguP5pYFbOiibYbxAzK9+c2ACY7w21fLYM4YwNFL8ex3rjq6dwbbUO2wCtaZzjpgkkXiImeoEOaj3D8iwIfdNY+7DsU/ozb0jZJOXCBdvNOpaNfunEZdMjud2IMiqW3xGa8Ru4gyFXK8rPZ8vvGibpnXKR2nhCFiX1bABA+fDgPQx31DP4O+M1pD/R92YdT05CPrve/lTPnSW3ASVrgsCV6urpEZ5UaWc+opTV/LQdXd53zJdCo9qNeYJj2MDaTCGXr5PT6JmlIJhDIXgbi3R3Q2aFAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d+Z36J878aVHYbg7f5ffmEj1YVZ3O8atKayWVds4WO0=;
 b=TqdtfmtyYN3a7gbiaRc72NxPRvoBekQAWoUc7y11VlfKZ18kUZy82EgF05v0rBL7VDIn6SaLhtktqIRoXg1o14iX2CT5mNZ2XcAO/riKcrHHPKfGnJWpC0NiUpWotiPdDqUJbrjqJHLUpvBw/Vq2s/tOCdDSeWTgWXR9uAvy8GHrSkoAPelTUrkOPGsPDIlp9fIBOz4lQ0PnT3OIo2EtLSzseD01PnvqnF49aBtNWMG64sZClpkVea32I95n46H9Bi+AFvg9qjKj8zxvG/nc+dGX12w1oBULyhUrC/qb/zj/usVBsgpOzOuN8xQDVH8vXobxDsHwz3TCkZarRJxF3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d+Z36J878aVHYbg7f5ffmEj1YVZ3O8atKayWVds4WO0=;
 b=QTA0xQtTXz/4LP0hp6nIKigSb59pQIn9W2x+MQIIetL5DDLYsEmR6YpZyIjbT1GFMNIaMT2qPOWigqsZM+fA9/FfEtz89n01N6HAnzVqFygQ+fr4awcbImn+/N8K0aWK6ne/agbRFU8ID+Mb+CrBT9q8Iy0qskYJWH+UX5t9eQk=
Received: from MN2PR10CA0013.namprd10.prod.outlook.com (2603:10b6:208:120::26)
 by SA3PR12MB7807.namprd12.prod.outlook.com (2603:10b6:806:304::22)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.7; Fri, 27 Mar
 2026 12:21:04 +0000
Received: from BL6PEPF0001AB53.namprd02.prod.outlook.com
 (2603:10b6:208:120:cafe::a9) by MN2PR10CA0013.outlook.office365.com
 (2603:10b6:208:120::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Fri,
 27 Mar 2026 12:21:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB53.mail.protection.outlook.com (10.167.241.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 12:21:04 +0000
Received: from BLRASNATARA.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 07:21:02 -0500
From: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
To: <dev@dpdk.org>
CC: <Selwin.Sebastian@amd.com>, Ashok Kumar Natarajan
 <ashokkumar.natarajan@amd.com>, <stable@dpdk.org>
Subject: [PATCH v1 4/4] net/axgbe: fix SGMII autoneg status bits
Date: Fri, 27 Mar 2026 17:50:06 +0530
Message-ID: <20260327122011.1534-4-ashokkumar.natarajan@amd.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20260327122011.1534-1-ashokkumar.natarajan@amd.com>
References: <20260327122011.1534-1-ashokkumar.natarajan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB53:EE_|SA3PR12MB7807:EE_
X-MS-Office365-Filtering-Correlation-Id: 953e1baa-4b1b-4ae4-4904-08de8bfb5118
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|36860700016|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: k4//5PEf5C4QmTO+Q7p5NIGCHOEXpzqHpVN/eD7TUGLgT5zAVEEDhzDCG36aH/r2oAhtUQNdhhUQyfR0S7lUcR1p5ERefmMhLIRazTyds9T/lKkzziXeWi1i8VqsKiGenZ4MTZcz2sqXKk9FoJlaV/vFrL+xKs+rD30iXm+l0fufbYbxtgUYEbqRwIySMmThyECciol3WWWSdH+bw8jEKqQmk5aVyHZ7aAuGJQwiDoF5m5QY7FBBqdTlHJwPyu88L12AmAGlfW4yRdxQu9UJxW83krSnN877mTZISX8oatODTBzffovqDFk822yDOFxa04DWEHSpEvCWyFMnlzan7dCBVFcr/NXNXgcEkrRjn8ILNoNk8aFlMbH7h6Yj2DfGm/MSI7ygiv//4D6sgA/zfSggKySN2y0QzMMtdYUqM+/9YqUqQSUAwJ9FUAvdWI/+/5nNMwIq81frlyhRWyR3XRyLKCDxmfoaRJaF0ZMyBN7HL01lT5q18lnUd+AFCNRoBVrau9mqGzhTUn/YTBwlCW5mj3RohHqdLBg+BztCqHsIyydaMoW+4BcOnZ1m5WE9phvQxbhjUtaRBtr+VYeWgOtk07KiXrNScGQeFQ/Pv8CUhiXFqgH6rdmBfDCijotwVWHgeswoTDD+jLhSOZvLtxLAAMUcWH9/33lr6F2kA1WLG6kmTyHCOXVXyNOwM2vcoaJZ7a7O25G+tgUu/S3J3vO1+mELm9/a1BmuE+0oqMjutlEqrpC3E02BEO+kv2+MbgVcMj1ahfInMhb8KHxPmw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(36860700016)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 4RDSaIHs9wvyVChjnU7G3+9EO3tRc2SOEtbdAvIQbn/5QdRMBRzjD4clr2kaQRdVFpWMkIVyRrgxttCG0Uyv/0rGRorY2wK2ikAW970ENcjuXyd66zbKa5YOplDteBxW7m1DICAX6UBF+a0OuuejTJ44nxW6Gt3O3gQ2ho4toYtld925EBFSlRdX3V029Exf5X5vXAQoa/5yB6N9zrwQz0I6F3IfMjcUJSl9fcdIbQXoA7dcYQJGglCHK9SSS9MsDauNgV8q23wQcl9u++ffSevZ0PEnAtDPXL80ZwS4UBwJq3FmFO6Oyqx516bTQ2Jcjt4UJXJfR2drnoHJVKyTwZMLwTX36d52gTWYXAdhPyk94+7dTOYx1e3fwuUUeCzD4Vo1hPOVmukX1mqeeI7zifSl81keCoF2s08E1QQL5+ww219OXU721q2nh+x5ofG2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 12:21:04.6353 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 953e1baa-4b1b-4ae4-4904-08de8bfb5118
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB53.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB7807
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

The SGMII autonegotiation status bit definitions do not match the
hardware specification. The link status and duplex bits are defined
at incorrect positions, which can lead to incorrect link state and
duplex reporting.

Correct the SGMII autoneg status bit definitions to align with the
hardware specification.

Fixes: 572890ef6625 ("net/axgbe: add structs for MAC init and reset")
Cc: stable@dpdk.org

Signed-off-by: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
---
 drivers/net/axgbe/axgbe_ethdev.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/axgbe/axgbe_ethdev.h b/drivers/net/axgbe/axgbe_ethdev.h
index 24336f31f6..77c21469a8 100644
--- a/drivers/net/axgbe/axgbe_ethdev.h
+++ b/drivers/net/axgbe/axgbe_ethdev.h
@@ -114,12 +114,12 @@
 #define AXGBE_LINK_TIMEOUT		5
 #define AXGBE_KR_TRAINING_WAIT_ITER	50
 
-#define AXGBE_SGMII_AN_LINK_STATUS	BIT(1)
+#define AXGBE_SGMII_AN_LINK_STATUS	BIT(4)
 #define AXGBE_SGMII_AN_LINK_SPEED	(BIT(2) | BIT(3))
 #define AXGBE_SGMII_AN_LINK_SPEED_10	0x00
 #define AXGBE_SGMII_AN_LINK_SPEED_100	0x04
 #define AXGBE_SGMII_AN_LINK_SPEED_1000	0x08
-#define AXGBE_SGMII_AN_LINK_DUPLEX	BIT(4)
+#define AXGBE_SGMII_AN_LINK_DUPLEX	BIT(1)
 
 /* ECC correctable error notification window (seconds) */
 #define AXGBE_ECC_LIMIT			60
-- 
2.34.1

