Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 178BAFD530D
	for <dpdk-dev@archiver.kernel.org>; Fri, 27 Feb 2026 08:46:21 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6925540687;
	Fri, 27 Feb 2026 09:46:20 +0100 (CET)
Received: from CO1PR03CU002.outbound.protection.outlook.com
 (mail-westus2azon11010015.outbound.protection.outlook.com [52.101.46.15])
 by mails.dpdk.org (Postfix) with ESMTP id A993D4003C;
 Fri, 27 Feb 2026 09:46:18 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O30lMRvliQjfQ22hW4QKyo79gSH4p8FkXUX4g9Byj4RFrTFCTDPPAcCep6GY+L6NQRZI0OHZdJpZ+1I3FKEThRXRThX3gLkywLhAhrsTEq6U41RhqdEnbYYxyQjBZTO1NiDBf/AkUtQW+ot2gQQin6P15Bhpf2bbYAMe9TtFvG13L3WDweuxMLIzI/8C2tjWQdpB8eGjDcSNyTcKl7EYZ6exwtglAJmbSZwUcEBv8zxwq03mslrxVHGOFJENGxfiEa0WyYw5FA2CW+f/8KANqOKW3HT0tOYrAHWytwalm0r36GwWZ8qYPonY2MrsUe4UwvPehizqaZGUbJb+U1CJDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngfn+d/UImX2kBkaaNyFNhwfB0yOxlb1fmv5vXVtuB8=;
 b=Q1obInG0hO+7Wq5nvmFkIUdxKh8PaV4Yw7DShT1o/6vcQcOc0A2o2WSts+bxJiEEWvxv0gJX+1Kv7YzIp9Kb3EyJNuztXGN1bVYSRCUvov9IdApnUUIfViszYMSd0C/i9Uh74gHMsfiiTRpi60zRCAXU2GV/7m2cR9ITvS8NRax+Zu6lbFqUB6nhiS6oWyFQcP1+de7gd9dbkX/U8GuDVHGWrjsd+YJN90tErRbA4UNWlKJRIkDPC0XweAPd1Ag3eoFqQCv9pejPIcXJuM2OHva5t9RFZXMUfMyQ7xCfZsQWmDLFE0nLitzqdwFN707GrePpWeKTeDPHeakTX9W7sA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ngfn+d/UImX2kBkaaNyFNhwfB0yOxlb1fmv5vXVtuB8=;
 b=wN7aaRaeNrBR1+Z93H/SfsFMuZzUQvIrWY+sXAQrWTrmZMtgVU9Ic4DXkqzjHFdPcg7jcOgJIir+hHa3nD5njje0d40CVABhsqeSl8nZmSBuyTWoTkAf0UIRBdAASqB4rY81aIVMzigxUbZHxmP28YMUEswrx1ZhJBDYZJe9mnQ=
Received: from BLAP220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:32c::20)
 by MW4PR12MB6708.namprd12.prod.outlook.com (2603:10b6:303:1ed::5)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.14; Fri, 27 Feb
 2026 08:46:15 +0000
Received: from BL02EPF0002992E.namprd02.prod.outlook.com
 (2603:10b6:208:32c:cafe::3) by BLAP220CA0015.outlook.office365.com
 (2603:10b6:208:32c::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Fri,
 27 Feb 2026 08:45:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0002992E.mail.protection.outlook.com (10.167.249.59) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Fri, 27 Feb 2026 08:46:14 +0000
Received: from BLRASNATARA.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Fri, 27 Feb
 2026 02:46:13 -0600
From: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
To: <dev@dpdk.org>
CC: <Selwin.Sebastian@amd.com>, Ashok Kumar Natarajan
 <ashokkumar.natarajan@amd.com>, <stable@dpdk.org>
Subject: [PATCH v4 3/3] net/axgbe: fix 100M SGMII mode
Date: Fri, 27 Feb 2026 14:15:45 +0530
Message-ID: <20260227084546.729-1-ashokkumar.natarajan@amd.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20260226164903.1421-1-ashokkumar.natarajan@amd.com>
References: <20260226164903.1421-1-ashokkumar.natarajan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0002992E:EE_|MW4PR12MB6708:EE_
X-MS-Office365-Filtering-Correlation-Id: 5a811492-eec7-45d1-eb22-08de75dcaa94
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|82310400026|1800799024|376014; 
X-Microsoft-Antispam-Message-Info: FPlRHcP5vl4GoR3rv4IetJTU4mgNez5aq6VDhoF2kTrzE5QYoIJXGJW2bjp23qzPCVgCu0oZmN9gOCvH7mmugB4ylbm1oQr+0i/UeATt48nNT7CDCqu1ugqG2ClDax//cCu/siLHvPaljOue5TdSURJ2WU9hnggY6ZZbJtyvY98orLJwsho9tVrJSbClMC8du7FMIqE7KWWVNWcMHL//1wLJb7Tt7pWpBDNF1YVy+BNGpCN0PTl5vOy9YMWtEXXjk2S0mJDRftAHWkCAYH4rZexX+12zM1lyikfP7mV+Z+JDjrCKc1qEgq4XFzDecOzQG7dpZAWU+GU003VK78s1rbe17U0Ls+rQOHIL/GTdt3wUHj9dooB14oKoZg5pzFvVXAr4k1SVj4UWQQXSLMsuuJeQWFEk9jOC7icqBumv1whEIoOZeAUd5UGqPsEUvzQPbJbXjO2ZYho3DRYBH9NERyFUxF244QxiMRjlWcdzujeiwo6UtiAMWP1HBRNiPTvosBGWMkqekmIwnzatc9Hj2BPQwxUY0D62sw3PpoODmdhE8G2Zyh7ljLqq9H+oZYpYxf3qi8UaeeRlQzAwZ6QqEJsdbLS0tLZ6EqjyzzytuAAbCI63o5I1EtrzktkgAxY+3YzIWrHHLXrkJCSPgXBlTtQurXBG6R7KguB3CG6M7A4X2i4MeGHSS8xDhb59NGWiMGXpnz7ipwGtkTZnZKjQsxkVVkqoOtOp8ZhwSQKs3xwsvWbKT5QTYPaDd2Sro1XMa4WS2srj3V4aA7pY4JW3aujQU7MnFFQGPNL8jwnWT91PLflqjyE0ZuAZk7VK7nO0EuXf/PGise+OJiHoZ1tn0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(82310400026)(1800799024)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: TckI1/OKQ40uH5fOy2ClGAjxQrJh+0Js+NsDp1P3JoxZ69Neb9HZ6upt/iv/MbhMv3FXou0YKnmRvnH7CV7n3O2KeSp1Zxj092UDNdZPijsfNwHMCUcFngRQroNHJnn9szvh4hQlMcxDsphz5ZvA9uk8tZG7d5JCDCZSKCEWo5iUgB+H9xuTeca2eUe1KyPs1wDQXkiqzSIFQ8kaUrS3/UO6o2Qkx3BgPEDe4wNy6M6P+BBxEKffmJepJwHFLA8GQa2TkKI9etFLPdMp9IuBz2XJAObk0yM6FUFEe1NVygiFOCp0LdlhAIgIuJHdVNqy76Giw3+v5WyXsVUq+Sv05kSZCX0vfjMAb+7xFFU9R38bUTLti1iv+bcW+ZIs8VVef7f4TePtN0kQwotUqmqtaWwcZahN+4Gjnvv2FAPmm5319eUm88eIyoa/jAvj+GSd
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2026 08:46:14.7896 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5a811492-eec7-45d1-eb22-08de75dcaa94
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0002992E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB6708
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

In SGMII 100M mode, set MAC speed to 100M instead of 1G,
and add the PHY implementation for SGMII 100 mode.

Fixes: a5c7273771e8 ("net/axgbe: add phy programming APIs")
Cc: stable@dpdk.org

Signed-off-by: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
---
 drivers/net/axgbe/axgbe_mdio.c     |  4 ++--
 drivers/net/axgbe/axgbe_phy_impl.c | 15 +++++++++++++++
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/axgbe/axgbe_mdio.c b/drivers/net/axgbe/axgbe_mdio.c
index 952a0add62..a37cd8b80d 100644
--- a/drivers/net/axgbe/axgbe_mdio.c
+++ b/drivers/net/axgbe/axgbe_mdio.c
@@ -155,8 +155,8 @@ static void axgbe_sgmii_10_mode(struct axgbe_port *pdata)
 static void axgbe_sgmii_100_mode(struct axgbe_port *pdata)
 {
 
-	/* Set MAC to 1G speed */
-	pdata->hw_if.set_speed(pdata, SPEED_1000);
+	/* Set MAC to 100M speed */
+	pdata->hw_if.set_speed(pdata, SPEED_100);
 
 	/* Call PHY implementation support to complete rate change */
 	pdata->phy_if.phy_impl.set_mode(pdata, AXGBE_MODE_SGMII_100);
diff --git a/drivers/net/axgbe/axgbe_phy_impl.c b/drivers/net/axgbe/axgbe_phy_impl.c
index 8dd3090c03..88274962f0 100644
--- a/drivers/net/axgbe/axgbe_phy_impl.c
+++ b/drivers/net/axgbe/axgbe_phy_impl.c
@@ -1643,6 +1643,18 @@ static void axgbe_phy_sgmii_1000_mode(struct axgbe_port *pdata)
 	phy_data->cur_mode = AXGBE_MODE_SGMII_1000;
 }
 
+static void axgbe_phy_sgmii_100_mode(struct axgbe_port *pdata)
+{
+	struct axgbe_phy_data *phy_data = pdata->phy_data;
+
+	axgbe_phy_set_redrv_mode(pdata);
+
+	/* 100M/SGMII */
+	axgbe_phy_perform_ratechange(pdata, AXGBE_MB_CMD_SET_1G, AXGBE_MB_SUBCMD_100MBITS);
+
+	phy_data->cur_mode = AXGBE_MODE_SGMII_100;
+}
+
 static void axgbe_phy_sgmii_10_mode(struct axgbe_port *pdata)
 {
 	struct axgbe_phy_data *phy_data = pdata->phy_data;
@@ -1840,6 +1852,9 @@ static void axgbe_phy_set_mode(struct axgbe_port *pdata, enum axgbe_mode mode)
 	case AXGBE_MODE_SGMII_1000:
 		axgbe_phy_sgmii_1000_mode(pdata);
 		break;
+	case AXGBE_MODE_SGMII_100:
+		axgbe_phy_sgmii_100_mode(pdata);
+		break;
 	case AXGBE_MODE_SGMII_10:
 		axgbe_phy_sgmii_10_mode(pdata);
 		break;
-- 
2.34.1

