Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B50710ED665
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Mar 2026 12:21:01 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A37BE402C5;
	Fri, 27 Mar 2026 13:21:00 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012065.outbound.protection.outlook.com
 [40.93.195.65]) by mails.dpdk.org (Postfix) with ESMTP id 04DE840280;
 Fri, 27 Mar 2026 13:20:59 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gs6hJMQnojunWPCZ+EQclCu1R2gh9+tLDAnU1koaptQdN7ocV5jBeZPsqv2SoojYq3cg+38AjsN0y4fk1NwArxlPsCALYWhsg15NWvtRa1ReUBv+3RAMWx4GhvWBnnhcRLpD61sYoisjqYXjLMzI2TpsTZl5jdRxgR+tOoKHd5H/VWLGRusxI+f0uPEmegLMgbQH67dfVTFP6c9Lo3UctrDM9kC0USVLm1W1kvnSbnf9MncnnGt6Af7l1p+wIU4JDnwVEkYyKWC0KS0IlW+pK74kje7XE8pFwe+Zmeh/jNTLWaWUq9HZml13Hp/BMABP6AqPtq+07I+mwcto2pkxrg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6yKCY1tOqy9wZYvaDoiFQvFKHoA0a57SS4WMY2VXzzk=;
 b=vHabSBmoy9P6ouGGBWSKiF1Op/BCSKehs/qW2TM94pSe24ukn0U54qtuafUf1k6Rl/MlwLHbzO2pIjFtNxZwzKNzIm6tB6TjYbLMVMLb4x+Nnf2h4SueTmejFIALmO8IhWPyZfoJcnxP3kdz/y2AHpI/U3KRjaRwPoqxE0g2B3jUpIqiftls+KNJUY7if3ty7aY3X4yGww+DcJmBoXCc3QIBzFvunflbc2I+h0VUpQNjT/G1+M5tRv9FCRcgHRUrvRpASbqn9vZGUIjthK5ulxFP3nWfFgpipFnCzBK5HbvIiB3QFXajkTHlrNr4d0jvBU5FgOtKaIAYEFLQ3KfDsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6yKCY1tOqy9wZYvaDoiFQvFKHoA0a57SS4WMY2VXzzk=;
 b=pOkQgV3fy1es1XeD0HamS1fdKcgJG2GCNG7vlOp62ZBZJlrKYuzVTO6POC0nsCjzDIBpcjxdwOgX5fMx6R+27Q7tGR2YkQ9ccynZtOnmzbhXZO0SYje2JyOeNpunZBwcGN1soZI/EU0zFnkd0An9pfeNMbaU7/6CG4r6t1fXwOE=
Received: from CH0PR03CA0255.namprd03.prod.outlook.com (2603:10b6:610:e5::20)
 by IA1PR12MB6139.namprd12.prod.outlook.com (2603:10b6:208:3e9::16)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.10; Fri, 27 Mar
 2026 12:20:53 +0000
Received: from CH3PEPF0000000F.namprd04.prod.outlook.com
 (2603:10b6:610:e5:cafe::9d) by CH0PR03CA0255.outlook.office365.com
 (2603:10b6:610:e5::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.23 via Frontend Transport; Fri,
 27 Mar 2026 12:20:53 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH3PEPF0000000F.mail.protection.outlook.com (10.167.244.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Fri, 27 Mar 2026 12:20:53 +0000
Received: from BLRASNATARA.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Mar
 2026 07:20:44 -0500
From: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
To: <dev@dpdk.org>
CC: <Selwin.Sebastian@amd.com>, Ashok Kumar Natarajan
 <ashokkumar.natarajan@amd.com>, <stable@dpdk.org>
Subject: [PATCH v1 1/4] net/axgbe: fix MAC TCR speed select field width
Date: Fri, 27 Mar 2026 17:50:03 +0530
Message-ID: <20260327122011.1534-1-ashokkumar.natarajan@amd.com>
X-Mailer: git-send-email 2.53.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH3PEPF0000000F:EE_|IA1PR12MB6139:EE_
X-MS-Office365-Filtering-Correlation-Id: 9ce01d1a-ccc0-4212-cbb8-08de8bfb4a96
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|1800799024|36860700016|376014|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info: 6r0OVc+qamZ95Gxt8nxTfiFQSK+EhknAiBMchZ/nQ18EzoliPpZFzDzP6694DhfOxAi4LkJT1KhU8Y2JqPNeIu66vszfuOuwuZr/Ogll1UrBgE5XCvEfa+RC59gwGvVsGSajpxd1jRRqmbdlHVWBee6yLrcyFArllQX+ZzxsYEjVRDkbr1YGf3DKE92FT7JVqQt6tYCaLbU/cqe5PWd+qn8jATEN04ukd9feZgg+jWaZrPGMp70DrA6lB9FKgBtXgiqgppNlSv5Gdab0x+exjcMSOevfSLDpZ/qEncwqgCI4ENCwws/OsNtnUsTZ5RVa7Fbr1f27jUZ+fF9TITeoS99oQRsPArRRdaoEp8ofiYkKLfROzCMECtqJ33YVPkQwz0HIZhfenD+y0Kgmyk57xvvBYQzzTW4p6aC39RQhsYBg2sdV66Z4oC0kRd/AlY5KuSux4C/cw1Z71a2EKg0JvU5dcO7SR5UWb+IG41H72McjmlfIM2zCs1fXnbGksRYHiPjS6XE1aWHDZU1nHMPMeNbKTcqMlWjFsW9NrnwJxD1nlqpk5ON7jnV4R3c7gTL4hWjO2W3zXA84UoD0oZ8s8MJA7pzjUflXBNChwwIQmFGJrK5WfIghQWc3wx9iZiotWrfx/1VaVoi5Kut6eEX4DDlb3fFCm52DF1LFKPcHyPR6K7IX7Ac71GaOwcbDsf3sXJ5Y6uSU6R5UskKG41N9kQqBzlaQswaBdhytC4aroPSc/pctIUvzz0NS6fq5Xk0z89tuX6pqIlaMpkbpcp78KQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(18002099003)(56012099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: U93/VLTJlD64hFfQ38IWfD4EvyjxTH3dm7VhSjP6BsJigmEi/W5Dt1MraY5SUlYabCuTg6eRKJd9grVBkTlvzuQQ5RZaSruT9iT2eFAhSOf7V5N40XjmHB0Ix4J8a9bC4FW1GJQ+NzGo5DmG+2qDFjvXK/VP+Jq4M/Dwr5sXMzAEll9YGg3SRjSWFKG7Xgujme9aKu0+aMS2SE90j0rWnjf8niuu0XkaQ6bmE7s4IFcpxtzZyTjvu5RDPMv9FjdqiY0xt+8o2w+aQjJ/0qU4B8U2MXsUuOh5NkWMZQluRH/wdzMJWrrUPJyD5uNxHHLznvlO7jGKpXdsDIc+AluReid0o4eEraETcq4TtWMR3Ao+wYVhIcY0O2Ofic8x0AVzvp8AjN13ErF9cSe566hBH7aO/ydC6AsgsklkIlErIQNlgwAGCr2wENV8gxGLX9kx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Mar 2026 12:20:53.7110 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ce01d1a-ccc0-4212-cbb8-08de8bfb4a96
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CH3PEPF0000000F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB6139
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

The MAC Transmit Configuration Register (TCR) speed select (SS)
field is defined as 2 bits wide, while the hardware specification
defines this field as 3 bits to encode all supported MAC speeds.

Update the SS field width to 3 bits to match the hardware
specification and avoid truncation of speed select values.

Fixes: 69e209be5464 ("net/axgbe: add register map and related macros")
Cc: stable@dpdk.org

Signed-off-by: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
---
 drivers/net/axgbe/axgbe_common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/axgbe/axgbe_common.h b/drivers/net/axgbe/axgbe_common.h
index 0bceff5774..842077d972 100644
--- a/drivers/net/axgbe/axgbe_common.h
+++ b/drivers/net/axgbe/axgbe_common.h
@@ -492,7 +492,7 @@
 #define MAC_SSIR_SSINC_INDEX		16
 #define MAC_SSIR_SSINC_WIDTH		8
 #define MAC_TCR_SS_INDEX		29
-#define MAC_TCR_SS_WIDTH		2
+#define MAC_TCR_SS_WIDTH		3
 #define MAC_TCR_TE_INDEX		0
 #define MAC_TCR_TE_WIDTH		1
 #define MAC_TSCR_AV8021ASMEN_INDEX	28
-- 
2.34.1

