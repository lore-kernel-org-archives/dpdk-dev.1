Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17421FF60EE
	for <dpdk-dev@archiver.kernel.org>; Tue, 31 Mar 2026 09:06:39 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 9FA8A406A2;
	Tue, 31 Mar 2026 11:06:38 +0200 (CEST)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010033.outbound.protection.outlook.com
 [40.93.198.33]) by mails.dpdk.org (Postfix) with ESMTP id 9C2394026A;
 Tue, 31 Mar 2026 11:06:36 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=H2mpY1pPy3GyxVXAO+uifBlM6TeA8GfLkYZy28vfr0KPL+SKhiEJUWBl7eZZlkdUr0IwoL/v71wVq/+R7ZMvvymuoRvEieF541LL9UySJPuzl2dv5lrhlWPHjkik3ybC237ffd8k7zvWt7Qos1jCuZsw26whG9gSB/vHm3rgXtERAPv5VxbOMS7fkioIbOkFtSdH03vcbpY93C4yo0tSgT1nx44YQpAJ8dg8m9uhHJUDSGVzZ+tslRwkIQZJZwPpo6s5GppMa7dkCx1zQoFIscGPyF9J3+71CFdPk5XYu1y2vGdIzvxpfN8ZqWi+zlQbNPF3l1JT3MG2X8426OZ4Og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+ZVtoCKRlOnepLsMvJhrVWkvz1ww2thNb3GHEwQq7V8=;
 b=gh/XUjYJbQQ+YYxiX9Bsq/gbDetPG92Mxu4tc7F8yWq4U2ZT0v+0l7IIbkO7ch85vOYDt8l7nsxk1LsiwYkdWpxtUZZCqbogbEWN8rW6MClkXes/iVFJx6G7tQNhXr5ZuIJq7bd2sPO5lNc2AWGRYszwuuD7VP/e/8SLSxcAtWBDvXFgjwsbWmgX7RFWrOTBwxVz0HISAzPc/iamTaJmncNOfn7tyiO6EqNWYHyy/u/a2BXfLwd57sOjs0mwsUwEHcFVT79EJvtV8HH3v//oCMr/Tqk70lB7vBb3v+bEydX0zSFMf5IUfIWTz7BdBgHF5LJwk9u6aimBUi/R9ypmaw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+ZVtoCKRlOnepLsMvJhrVWkvz1ww2thNb3GHEwQq7V8=;
 b=d+jwsRc9U1zI07sBDKC6L0S48EDDh/YzWGYpUIJ0CARmXormKrlZcU7tDO18dEjqiyk07+wk9eU6lvNpWgJrEVjrxuqRNjo38ln1H66QjKheIAovHQYKdTxel5JeNYOPNPjZEP9oC8l1IGi+yfzrW8BeZ7fUFM+lIrRuXmZtMh4=
Received: from SA9PR13CA0137.namprd13.prod.outlook.com (2603:10b6:806:27::22)
 by CH1PR12MB9646.namprd12.prod.outlook.com (2603:10b6:610:2af::9)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.15; Tue, 31 Mar
 2026 09:06:32 +0000
Received: from SA2PEPF000015CC.namprd03.prod.outlook.com
 (2603:10b6:806:27:cafe::39) by SA9PR13CA0137.outlook.office365.com
 (2603:10b6:806:27::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.27 via Frontend Transport; Tue,
 31 Mar 2026 09:06:31 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015CC.mail.protection.outlook.com (10.167.241.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Tue, 31 Mar 2026 09:06:31 +0000
Received: from BLRASNATARA.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Tue, 31 Mar
 2026 04:06:30 -0500
From: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
To: <dev@dpdk.org>
CC: <Selwin.Sebastian@amd.com>, Ashok Kumar Natarajan
 <ashokkumar.natarajan@amd.com>, <stable@dpdk.org>
Subject: [PATCH v1] net/axgbe: fix PHY auto-negotiation advertisement
Date: Tue, 31 Mar 2026 14:34:26 +0530
Message-ID: <20260331090427.156-1-ashokkumar.natarajan@amd.com>
X-Mailer: git-send-email 2.53.0.windows.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF000015CC:EE_|CH1PR12MB9646:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a803cde-bef5-4517-386f-08de8f04cd35
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|1800799024|82310400026|376014|36860700016|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info: QJTQPr8sVwEW6XgRN611kKNt3jY5F9wfCL1r1z9ZfkhF8L7Eyy28XgzJQ89fDy9i1FZQISgi78B8ZTxpAPkpcKP/mItWEWUqQv0HImTBavApiJ67rDTfhkUIebXNzYnmHH2SweFef/XA7kP4lVQ8cxLADvctgZanlGjDQLemQ6PsK/fFbbvrGTDrw3kJJForUiLHe55O5EooR/Pyia5LAFkEXnH0/ypFZiX4vBdodEHG4zmzAwQnEhqyEX8MYtJWV7S9RKzPCXL7cAaOUPcs5I3YbQQKTydqk4IXC6dP1Bq0sAEYQhW1XM6W5bESpkZshMkIVAfe8jbZo0U3Z9/rbPJfnsKKZpXVpRgGet4jMHM1xzB/eXfocZSjHxu3SOvXHHL7GZsT+t6gdeRQiPztcA5w4qqikhloXFrIDBkEApwFymwNCLGcezMXoalZTIVwaYdJoNd6dlCcMKSp9YJscRxyikfdTvNJyprmT1lHmQB8BIbdPt0iHkoaL2XGMNh2lxCLUeW918YQ8mJP8n0CuT14FPcPdQXkMUNYswgtlcjk7YR/wVEKuIvyyTI4u7CXbnPf0SO54OYwhleO1WnYA78GAzrMvG+DfLkaObW+Wd4EDbwgrJ7AKltDfejRFujO6fO8rHLtFfjMrxjrP7mZMijABLAC23hvEQHK+iOL+mtL/U1IaecZkkodXzf5vJt9wcksvVurwWm0nfo9BMfo+COFhlj4rgfNH944ZGKlrCCQVzvHLpADsXwdcxt3uzzRYPiQbxA4Nc3BLalxLC19zQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(56012099003)(18002099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IqLIAt+JDhZXXDuUS2aCx7lBzRkdiuCagJvSp8iRNQ8EedlyxMp01YYDK9f42BSupPiXcFTj7IddLgqbP8oX02ictWcS84b7R9MOLsPHt7sucCiWmmTqEChLKLWsnE9VSyWyiXrBOY2YBZGWmOl5+Fm2BioSbZCxbOhKWI5M6HYf/tz/kYU61KJ9EJVWGY4BVhXAL0/M1QdxstzSdp/49H6sLkJAVjnwIJUglnxBVubkl/Oyw/IVwR7BcFAT0LjHB3P/ZKsfMb3PGBzWTDPkVVUipimVki+1TW52QfcX14WHRpoJIIKX++hbTHjFAC/1FTRx5vwVklCaxmBNfBQ3YalYdgihBMIHKC2rwVMNDj6TvUVb5Jw62AW6tc1TOntq7hUhq88GQhmQrXVTAblnLllNN2M+57WUaCjbsxrm4sb2zKv3M7Ark4tpvBm70AaA
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Mar 2026 09:06:31.8334 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a803cde-bef5-4517-386f-08de8f04cd35
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SA2PEPF000015CC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9646
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

Correct the programming of PHY auto-negotiation advertisement registers.

Configure Clause 22 PHY registers according to IEEE 802.3 by advertising
10/100 link capabilities and flow control through MII_ADVERTISE, and
1000BASE-T capabilities through MII_CTRL1000. This avoids advertising
unsupported or unintended features such as unconditional full-duplex
and pause.

Fixes: 7ba7d89890ab ("net/axgbe: support Marvell M88E1512 PHY")
Cc: stable@dpdk.org

Signed-off-by: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
---
 drivers/net/axgbe/axgbe_phy.h      |  5 +++++
 drivers/net/axgbe/axgbe_phy_impl.c | 29 +++++++++++++++++++++++------
 2 files changed, 28 insertions(+), 6 deletions(-)

diff --git a/drivers/net/axgbe/axgbe_phy.h b/drivers/net/axgbe/axgbe_phy.h
index e5568cce5f..12b1d47244 100644
--- a/drivers/net/axgbe/axgbe_phy.h
+++ b/drivers/net/axgbe/axgbe_phy.h
@@ -156,6 +156,11 @@
 #define AXGBE_M88E1512_MODE_RGMII_SGMII		4
 #define AXGBE_M88E1512_MODE_SW_RESET		0x8000
 
+#define AXGBE_PHY_MII_CTRL1000_1000T_HALF   0x0100
+#define AXGBE_PHY_MII_CTRL1000_1000T_FULL   0x0200
+#define AXGBE_PHY_MII_CTRL1000_MS_VALUE     0x0800
+#define AXGBE_PHY_MII_CTRL1000_MS_MANUAL    0x1000
+
 
 /* Control register 1. */
 /* Enable extended speed selection */
diff --git a/drivers/net/axgbe/axgbe_phy_impl.c b/drivers/net/axgbe/axgbe_phy_impl.c
index 369d766884..b340ce02dd 100644
--- a/drivers/net/axgbe/axgbe_phy_impl.c
+++ b/drivers/net/axgbe/axgbe_phy_impl.c
@@ -303,21 +303,38 @@ static int axgbe_phy_write(struct axgbe_port *pdata, u16 reg, u16 value)
 
 static int axgbe_phy_config_advert(struct axgbe_port *pdata)
 {
+	u32 adv = pdata->phy.advertising;
 	u16 advert;
+	u16 ctrl1000;
 	int ret;
 
-	ret = pdata->phy_if.phy_impl.read(pdata, MII_ADVERTISE, &advert);
+	advert = ADVERTISE_CSMA;
+
+	if (adv & ADVERTISED_10baseT_Full)
+		advert |= ADVERTISE_10FULL;
+
+	if (adv & ADVERTISED_100baseT_Full)
+		advert |= ADVERTISE_100FULL;
+
+	if (adv & ADVERTISED_Pause)
+		advert |= ADVERTISE_PAUSE_CAP;
+
+	if (adv & ADVERTISED_Asym_Pause)
+		advert |= ADVERTISE_PAUSE_ASYM;
+
+	ret = pdata->phy_if.phy_impl.write(pdata, MII_ADVERTISE, advert);
 	if (ret) {
-		PMD_DRV_LOG_LINE(ERR, "Failed to read ADVERTISE register");
+		PMD_DRV_LOG_LINE(ERR, "Failed to write ADVERTISE register");
 		return ret;
 	}
 
-	advert |= ADVERTISE_FULL;
-	advert |= ADVERTISE_PAUSE_CAP;
+	ctrl1000 = 0;
+	if (adv & ADVERTISED_1000baseT_Full)
+		ctrl1000 |= AXGBE_PHY_MII_CTRL1000_1000T_FULL;
 
-	ret = pdata->phy_if.phy_impl.write(pdata, MII_ADVERTISE, advert);
+	ret = pdata->phy_if.phy_impl.write(pdata, MII_CTRL1000, ctrl1000);
 	if (ret) {
-		PMD_DRV_LOG_LINE(ERR, "Failed to write ADVERTISE register");
+		PMD_DRV_LOG_LINE(ERR, "Failed to write MII_CTRL1000 register");
 		return ret;
 	}
 	return 0;
-- 
2.34.1

