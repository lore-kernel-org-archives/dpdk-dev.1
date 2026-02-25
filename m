Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAC8FD3758
	for <dpdk-dev@archiver.kernel.org>; Wed, 25 Feb 2026 12:49:41 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4662A402E4;
	Wed, 25 Feb 2026 13:49:39 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012027.outbound.protection.outlook.com [52.101.43.27])
 by mails.dpdk.org (Postfix) with ESMTP id C85704027F
 for <dev@dpdk.org>; Wed, 25 Feb 2026 13:49:37 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIsHfILhmEFcq2zSiigQo6uJCGKMkZ3yN21qQl63T/7vuWrQZgV6XstdQfa51x3SNtOM6XtqNyJyWUWu/sbnpgbYv3doOOyGIgCMMILds8tNNhbhElk8A886t3ljOmNwJTtd2WSBHaCj/fP3bYLf3PfxeXunaaad551zFiNW41U2GUiweSDSDFpRluFNrV/OB5PGBQ6P2ZGNLECgTSHwvqLDIDZUHLAESo9EySQASoehJXgTpPsYwLiXGAGIE15YRVVs9zetYoW6VYp8ErCbope6FTFEEXfV9FkcO+cC7cQB22nXo30+z24Grzjy7aVzirpymRtjPawNcAOIO/kHOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=uNA7wFE7msB86/nlR5BbyOdysG2YMl5il2mEtGLN5Go=;
 b=xCIZbX5tBNlVw4+Sg8dSh8beCN5XEDJBjh7gXMinje2XFhWFKJM1jbJwp/1744RXz3Pdn5U8SCbaItm738QujCx/O6SnHTpU+9DKAlgBPLDbxJbnvqyoJisOHS5ykgU4adrWXbvsa9P/yiYkEkWNqr/gOTYzT+eBQqiHbHUGGxU/NQXSPSeh77uq9ziHCBIU15rZ2AW6vy96Xo+9X8ZaNpPiwBBacKVfqby3PT02Osn3rg+ze+2gbUaJozjL6/2VIDBMBV5SSGc1S6iOmFgeQZPYsQOtoQ8m1kQM1NP20N/TVPzvos8HD4k0DBKlECYaFaWqYCBS6mNoY6RMnlKfoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=uNA7wFE7msB86/nlR5BbyOdysG2YMl5il2mEtGLN5Go=;
 b=CHB12XA98K8+MnPceMJoT9NNZyzx4lpj9ufKYhA+xkjKr9tuzwWMsi8i0FGBwHztRlG7L9pli3dSaLxhFK3cuNmHJ9nXc3cQOfsGFSsEV+oQwC+/2qVEXSMJUKjTEmR5gPP72YPczQ2xqhXs4Tn7nuHiebFgJDP8Dh2TQdGOtq4=
Received: from BY5PR04CA0006.namprd04.prod.outlook.com (2603:10b6:a03:1d0::16)
 by IA0PR12MB7628.namprd12.prod.outlook.com (2603:10b6:208:436::6)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.25; Wed, 25 Feb
 2026 12:49:34 +0000
Received: from SJ5PEPF000001D2.namprd05.prod.outlook.com
 (2603:10b6:a03:1d0:cafe::3) by BY5PR04CA0006.outlook.office365.com
 (2603:10b6:a03:1d0::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.24 via Frontend Transport; Wed,
 25 Feb 2026 12:49:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001D2.mail.protection.outlook.com (10.167.242.54) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Wed, 25 Feb 2026 12:49:33 +0000
Received: from BLRASNATARA.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 25 Feb
 2026 06:49:31 -0600
From: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
To: <dev@dpdk.org>
CC: <Selwin.Sebastian@amd.com>, Ashok Kumar Natarajan
 <ashokkumar.natarajan@amd.com>
Subject: [PATCH v2 3/3] net/axgbe: add support for 100Mbps link speed
Date: Wed, 25 Feb 2026 18:19:00 +0530
Message-ID: <20260225124901.1911-1-ashokkumar.natarajan@amd.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20260216125205.1032-3-ashokkumar.natarajan@amd.com>
References: <20260216125205.1032-3-ashokkumar.natarajan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001D2:EE_|IA0PR12MB7628:EE_
X-MS-Office365-Filtering-Correlation-Id: 020b6b19-3317-46c0-0921-08de746c5354
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: QGMVNcL7JhQ17sylr/LZ5gJX2q90Q/GL7DxInktb3kARLgnY3j7C6kZ4Tm0cSawziAnrQIYNECF3iWgE2Ow/KY0abmTa9SUt5a5AxMaqbHvuBdM56s03n1G+ib7v6+2wgQIYUfigSuajpYPptTpjDyllYeUC8qhdGn6oDNUCrj5uKDWw8e/HwHiL8q85v1YV+bOb2011+84C8nInMdl5VXU2CfP6xhhSeEd8K53Bdh7uCm+lvXTelhg/PRhRy3ZZEn5q7zCSYi2bpl0g4mJpxzNGPAKHha+zGkxq5nytUjKirrYKVft1o7i/gv+7cbgBl5A1jplI4GwnxUkYdABfvL34RdSVlYYqgBxmUIjnztqerw77obPZHky42niBVaNHIbiKZOB9BMBmQx85wDKRz8zwuADx7PpTz7LKN2/2t/PqdsWxWoBIQztYeoIfHz+U70m9SRkeNAlkJdOj4NGWmHt84DqgjzPv6oY99/aPYAZsTF8wLVeFLmpxWSY+N3uEk8fikCCgKYcOPebgnsSIomLv6TR442Kydmvwk3dM/9AsUFLI6P0UtmeFOtPB/jYdc6SpgTkU6h7GoSbkpEeSMYJfkza4+hBaJj5Jz3cv6n01gNwgcr1g0BHB4dJDpPHuMXYYnj4g+kvIVL1MxX7k1uoQXn7q3cThlioc8c6jLuLxDIolo0rThs70BxtxmAb7zxBlXE363+i253zIBbUjCHeYNxkc8WVVr20Jy8RgTNVwqQYAKPaj5XSK0+uUwv8zqqq3HeIVli2gLd/h/dW/7EtBFODPT0NPeVRRMES/VLDdtB668C6jc7q/0SjA+p04dFxCud19jY0NOfUwSEPcdw==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: x4tIxiTAUPz+m3uc/OqOIJvP+qLgZa4m129m2dkIaSbxhjv3QFYq/4Uib0ZVwJ23qcpRSYgJ9+zXCxaDQPG37JrTDsR4HDXpPYGBX9io+XbxRiIaeAqRrjXYbh96FL9UiHoS+QhQbAuh+6KU0sGT4V+7dOGm3n6QLnYovfHpIj+QrgV/dsboA6hsk3zoz0dcS8nNR5XSCurYEQlL0N/f37mDD0VWRYN83nWTyEUosrBjuV5bdv5EHSgRZwi7Hr7kNXavR4YCkX+xtHPEzOf02EmQ5mWGvWCIDHaK11OE5hlOUgtbthgwYAczI5VNRjIMMmTkuTYjJkotJsPnkbePLleNwDRXEVsMrSrCk0+OMG13ZllO5YjoiLr4hy9NKqfWK2utdaHBcmmPQlGTlgosdYs2sdZyTOOiNEHYAAyBNJewRLJtfP2KTYi/IY3b/pVs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2026 12:49:33.5145 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 020b6b19-3317-46c0-0921-08de746c5354
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001D2.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7628
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

Add 100Mbps link speed support to the axgbe driver. This update enables
the MAC and PHY configuration required to operate at 100M, including
proper mode selection and link handling.

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
index 0c23feaea3..e6a9dd39a9 100644
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

