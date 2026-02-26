Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAC42FD8FD8
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 16:50:36 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 84A034066C;
	Thu, 26 Feb 2026 17:50:33 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012020.outbound.protection.outlook.com [52.101.53.20])
 by mails.dpdk.org (Postfix) with ESMTP id B453A40669;
 Thu, 26 Feb 2026 17:50:32 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JUCcl+qMF1EFcYU1pb4dV+CMjrUfmNBzbvCtRUaa+xDc9VRPg2KXVGClXr8S4PzchqEz11PbJ8gIKbfN5RNlNkASlpYaHuImoArI0SthfB8E8BL22gn+rQ10kwArlMyDFQKX6ZfOAulEheyIm2c4IHZQIR3n3tvxWalrCrtJZrg4I00D1E8cYM0Fx/BCSJVmx3meLn2XAiHi6XoGhYfb5LFSLUsF+3Z9UI1oTXR/+3s4smor7jxM0LIC9F2ZJKa2iCY+Pr1KDMGDAMPop8zVbf7yjvm7tIpJjzviUuHCxF95Ojp95g/MrN1aV0YOOFaJhbW7si083dpWs097AjDOAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MYWHJTxE3fwVBNf9YJ+NfR+uOieLAb+YQ9r7dNsXlXc=;
 b=pgABiHAcJ3xe6KMu6onvdc256EtpDO+LXONxigyR8ODIgeYsuSzB7zhtUtiruBG4ctqEd5rgqjkqfsJMb28yFi4IeggMnCS68UlB12aEK4NGibplNSL4t4nIUChVL09uwuVtEJeRxIQq6q+tFGhvwMs6oF2vDO22qmtfGpVN2YHEic60o6MU1ip5sJomKLH5TNnlYtLwcb69B+N6Awx1ibmXLfEclxVrc9e181JRuGXJH9/UlAVa+IAr5Ehd77eM7omzmkhV+e+xT+RWR1k36zoy+3SvXAeuWfALtKQrZ8kLvHxK+8RFU6YONAGTRPC6eP+oUc7Zt3O/a1lu+KvD9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MYWHJTxE3fwVBNf9YJ+NfR+uOieLAb+YQ9r7dNsXlXc=;
 b=z6VBN1ZMsCXjwbSzRFwSxfbG6QD1WRki+N74w45Iyo8IfihpTig30UD368C1zzoxAU34faiHDj7sJ2MbPvEfL+mnQMtJJxtycUOTL3CdMoZcwb5o13EfOBiRE1CwuiZ0gmahEBXfiJT+EswnK4uSzVrx8cflO+piTsyq72IZShs=
Received: from BY3PR03CA0006.namprd03.prod.outlook.com (2603:10b6:a03:39a::11)
 by SA5PPF8BD1FB094.namprd12.prod.outlook.com
 (2603:10b6:80f:fc04::8d3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9632.22; Thu, 26 Feb
 2026 16:50:27 +0000
Received: from SJ5PEPF000001F1.namprd05.prod.outlook.com
 (2603:10b6:a03:39a:cafe::3f) by BY3PR03CA0006.outlook.office365.com
 (2603:10b6:a03:39a::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.24 via Frontend Transport; Thu,
 26 Feb 2026 16:50:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001F1.mail.protection.outlook.com (10.167.242.69) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 16:50:27 +0000
Received: from BLRASNATARA.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 26 Feb
 2026 10:50:24 -0600
From: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
To: <dev@dpdk.org>
CC: <Selwin.Sebastian@amd.com>, Ashok Kumar Natarajan
 <ashokkumar.natarajan@amd.com>, <stable@dpdk.org>
Subject: [PATCH v3 3/3] net/axgbe: fix 100M SGMII mode
Date: Thu, 26 Feb 2026 22:19:01 +0530
Message-ID: <20260226164903.1421-1-ashokkumar.natarajan@amd.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20260225124901.1911-1-ashokkumar.natarajan@amd.com>
References: <20260225124901.1911-1-ashokkumar.natarajan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F1:EE_|SA5PPF8BD1FB094:EE_
X-MS-Office365-Filtering-Correlation-Id: bd186fed-b9f0-4d6a-c55a-08de755724bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: wo+phiGUmrkzCP51Rafdy7imok9UsKGUeB2qz+KbSovpErR3TEb5UG+rWOYgVD0n60GV+IlIN9iT9pWYZNJlHiEg9sA+vdcHCFTQI0xJzLjbfEZDgB5Bu33TZHNG55BQFpXeIuoIwEYZayoyxjM3ZlkoqLDtQxCeg1LChnatjBLoIiczNwoRfckdJsuTlRFUQQ+9Nc84eluCaP9HmfV3aMU1ULcO1B0NDztE/zOZfzymKoxAvMIJEHvJgMX2fhX500sfIY6s19NMSAZzDdpg7Itmoa62O9IDfs3C20DlclkkuC69iFUxdrGA7ZtI0LmHA2WOjWMP1KoJqaEiXN1A8sL9Cr/4IY/vwiTqr0iUkGHyeOoHno8s099IlXc/slx1CO1ZlFQ66JQa2zN71jZxngIcEwgVO+R5THKBrYR4XBbibTyYySEo5kMQKax+nWEeMs38RbxvjtL3PMfeLqOMBuf41eR5H+jDZVIgHpHedyzHmP4/ERtIxHs1B9WKVc919TJSayDSFfMrc9Zdf46FbPGWRN1Esfiz+VLLARBYTWpzOi7CCdvICx8EjU/XSWxteV0AGRgqScpFtLoqXqDGvHYUkKDBJD+tzYAgLQswstprqJoD8+kIQHYGxTNK+p4Zw8uBk7C5tIyl5ISJoWCH/wKmoQJH3JpuNSOVDQ0uZYR59CayjUoIwiUBrjEsQ0yideSB83Cbhzva4m5irC5oDteV0YVapxfJ1rtbgwqUrUTKZ7v989lb+IiHVaWzDyqPzw/rU/4U3fqNx6Nt+3keOCtisD301DTnHbv4gFAJUPRL5+00YCsk0Xdt6IAp//AoH9FxJ9ltLon7Nkfbq45pwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700013)(1800799024)(82310400026); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: +jzWV63z7Vo2NWq2qGTM11RkxTrZwr+b/d/Iy2Gh04vwpbdJrDrM0QGnW9NTRogKmhKveMPd40/Ua0akEy2crC7ctHvfX6uU6GEr6aXqUTZdS4/fu+eHitDSLM+57m1P1BEC0/EWK08uzDx/SxiFkbwCKaYu74WiSY2OwCE/Z60BQw2npd/Hrj/jpfI2TWqgKiKb0WE7MWRg4teDxHZdBDSizNlpFOfDQryJxd+G7V2qme8HR+btuMrHU6dP4XB/ZmniMB70Dd2opyoTkY6hdZD+iVUa6x6YfdmWqwGn44A87Ix2Z7YtlPaLTeOdGxS+ejlOQ/fZtEzjoUfWxjfpS6kPcg7hjIYbvnuXBohOmNIMpBkawQx84Jd6O288W/vZfpZVdd4BcGYJlHYXXkkSofaUwyWMKX3BdQhnQPaGAeGoNMs9bU459qEg9QVtj9F9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 16:50:27.0822 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bd186fed-b9f0-4d6a-c55a-08de755724bd
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001F1.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF8BD1FB094
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
index 8635a53a6d..8e94be399d 100644
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

