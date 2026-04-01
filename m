Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ED41D35157
	for <dpdk-dev@archiver.kernel.org>; Wed,  1 Apr 2026 07:59:07 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id B2340406FF;
	Wed,  1 Apr 2026 09:59:06 +0200 (CEST)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012061.outbound.protection.outlook.com
 [40.93.195.61]) by mails.dpdk.org (Postfix) with ESMTP id 5DE59400D7;
 Wed,  1 Apr 2026 09:59:05 +0200 (CEST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=A4OLqToLCcqtfPyvqcj0DRHpzwNTPHVAqu8iEf7lXqeqjgs4sgZFLXHJ4soO9Igrp8jn+QAWDHJC6Zf/Zmlvfs8vJM/ANOSlulGX47n0E3wXRQpPJQeAXbfGss8+PD2hy7WQd34Ri/vTz7eIkraTTWbb9eJcUdXgcyhJNr+ZnbANAdlp54mYLmK4PGmwZQETvNGQrZO3KQWW+jbN6wlPp4KEXmCZbJkbzknjb6GvYEra/YoBqgifirgw5h5H1p21bvL8SYA5JcVqYrb3eSVYe7Bp7dFXFm0mUZOV3cKniSrM6Yge1YaOFhtpf15KGUajvnKTXL4z68GQwEo9wE0SXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s58Tfg+ZQq3MgdsdClL6wSkSUrkyCIhqqWzyidxDVZg=;
 b=stJBZ3l1R1fJuUnGkJOUD/hoAtoX9VAgsCDZ55BP0vUFmR3I0zMeZ50A6Mp2K6YDBYHk7pKz+UWrwB5YatBX2iW3TEg8nWuvmB0dBVZIzfwuZhy5khVlplNecDyMpfHII+yR0vd6l+tc5xGdv39LKxK5WjsbQe92ohN0Amub8DXdXmFDASRPidbxghJTXSpDSMaIUypygukopCtqK6PYcm1cuS/VJ2XY8Ama4+200TDu7EMKzh1qDJazM//s7ODel6Y2FXx/oYdQ2Wzk81SQQFbAk8EwMPUpNr8AX6tdOT8jeq6faorus7I9mR7a8/ycxvnNCvW59pSrBGtV9al+pw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s58Tfg+ZQq3MgdsdClL6wSkSUrkyCIhqqWzyidxDVZg=;
 b=DjZhI87BzlOdNosb6rNgFv8cesw9gR3O+J2kdXovysuUkRVPerhlBX8G4V0yK4ayqMaxHRp7JgBTjDoBvp1RYNoVzqEQ/ELWNSrCBTKAmP6ZDj3ZhIw+GFoAaBGkhwzMyLQq5rLTOP5bpWajj6L6b/IaNTmzdH/jZl37CIZnQrs=
Received: from DM6PR01CA0019.prod.exchangelabs.com (2603:10b6:5:296::24) by
 DM4PR12MB5819.namprd12.prod.outlook.com (2603:10b6:8:63::22) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17; Wed, 1 Apr 2026 07:59:01 +0000
Received: from DS3PEPF0000C37B.namprd04.prod.outlook.com
 (2603:10b6:5:296:cafe::40) by DM6PR01CA0019.outlook.office365.com
 (2603:10b6:5:296::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9745.30 via Frontend Transport; Wed,
 1 Apr 2026 07:59:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS3PEPF0000C37B.mail.protection.outlook.com (10.167.23.5) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Wed, 1 Apr 2026 07:59:01 +0000
Received: from BLRASNATARA.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Wed, 1 Apr
 2026 02:58:59 -0500
From: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
To: <dev@dpdk.org>
CC: <Selwin.Sebastian@amd.com>, Ashok Kumar Natarajan
 <ashokkumar.natarajan@amd.com>, <stable@dpdk.org>
Subject: [PATCH v2] net/axgbe: fix PHY auto-negotiation advertisement
Date: Wed, 1 Apr 2026 13:28:30 +0530
Message-ID: <20260401075831.568-1-ashokkumar.natarajan@amd.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20260331090427.156-1-ashokkumar.natarajan@amd.com>
References: <20260331090427.156-1-ashokkumar.natarajan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS3PEPF0000C37B:EE_|DM4PR12MB5819:EE_
X-MS-Office365-Filtering-Correlation-Id: b998331a-efa0-44d8-0561-08de8fc4893e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|36860700016|376014|1800799024|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info: Lt5ul4sQZBBpMA/yp8hoZ9gyn0YaBof1GF5+ML1svVQHcbkiM+HLJQ86Nwf/PM8nmdfPgfcVe88TK9zIgZ95XfjnU6ePjALk6qNfQtjEWWqnIvzaEDwNjC81uNVkRNeeG5ei2u3Pm7Q1YgM6kuTbnB3lX/1kemLvIuWhT8qReTyqNswyruGd0qWT+xhzhbZD2Q5BA4gFbdbHVptP8xguCkEBzDgtK9G9AomfmbX1QBDor5q75sAWgy4lQGrV47sGmackyFAxfZpiW7aJ2fmizX10UBXZqWKYtZupT51MENHmBWAEdIWglArLhaf4E1kITpVjATlJPuL4LCQltf5w18sd0SY4ZqJISFKBetxfBf5/f4IZdNudcOP7gIGx5MRHzzzkTFLqq/LpmtOrzPmtG/wzSsQX64v4L1ppjO0g5KNb2Uu6HGFPItYMb//77b6y3B/XPOXKXnqr8G0IoNXgiwyBJPyeZDar6mdeAGkE3JXK+mVshUK03PpIwejgQi+hVZrY2mmLqNTnDR1oqVQksCageZZQXaQvMCdvYBhKr1vq+tz9Q2fQoC6UdDTNXADJBIX7GZAasYPAkO+2fJ5nQ/BDAyo5aCQM8OyJjbxI1tVFo6Qjxh2XXhuA4/A4IEUOQrPe2bYP+F+VHptAP9A5n0JLQOpA9Z05e+hDP99lHTXNDG/alBBjKGiuKNTzekWllqDFh+VAWXbVPQ7qK+s5HjHh9PmQVFqLHKV9It3zPTdogrcUR+AOmLcuAvecu3iQed62+QqdMgvsyma8bTGerQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(18002099003)(56012099003)(22082099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: IVtk4sg7k0MreZ6hvJrB77+0Zmr4FagQCnrjXx6uAdDkpoJ+FJ11mISB3e181V8Qd3Adl/Xqp8MLf8hj2ZFecHaAuXqVVPGJ3WBf00+ZYsOSKnRzOvd5SLt3O/TETxl32771v8iZdU7Q4vvuXJ5a9dolv/rq9C7CCX2DNV1oq1TqafOj4ZO4RqlvCY5bjjOS05Wa/q2W7Ye6k8/Oe6vgi5hMwLJ3pBk3OZsySkkcTCAKYY+XC9RdvPWWiI+xAaBIHAKgZ/HoMkue9l+tXrLa913lg4lZvw7kqoY8DVeFhCyPDB6x/ek4CJP2cNHu3bWFMGZSpL4EDejZ0qRzSnogoEUJe2x+qIe+A6j1uwIMHATtpmImTIflAiNYovZlx3j2zvlBMsuzLMPx20wt21qVXFLUEyLzk6WZbdvCeGAfe2fL3h0vWEN3gY7xIGJkXX6E
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Apr 2026 07:59:01.1291 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b998331a-efa0-44d8-0561-08de8fc4893e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS3PEPF0000C37B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5819
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

Correct the programming of PHY auto-negotiation advertisement
registers.

AXGBE supports 10/100/1000BASE-T operation in full-duplex mode
only. Since half-duplex operation (CSMA/CD) is not supported by
the MAC, half-duplex capabilities are intentionally not
advertised. Only supported full-duplex and pause capabilities
are programmed into MII_ADVERTISE and MII_CTRL1000.

This ensures Clause 22 PHY registers are programmed according
to IEEE 802.3 and prevents advertising unsupported or
unintended capabilities.

Fixes: 7ba7d89890ab ("net/axgbe: support Marvell M88E1512 PHY")
Cc: stable@dpdk.org

Signed-off-by: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
---
 drivers/net/axgbe/axgbe_phy.h      |  1 +
 drivers/net/axgbe/axgbe_phy_impl.c | 43 +++++++++++++++++++++++++-----
 2 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/drivers/net/axgbe/axgbe_phy.h b/drivers/net/axgbe/axgbe_phy.h
index e5568cce5f..ab9c692d47 100644
--- a/drivers/net/axgbe/axgbe_phy.h
+++ b/drivers/net/axgbe/axgbe_phy.h
@@ -156,6 +156,7 @@
 #define AXGBE_M88E1512_MODE_RGMII_SGMII		4
 #define AXGBE_M88E1512_MODE_SW_RESET		0x8000
 
+#define AXGBE_PHY_MII_CTRL1000_1000T_FULL	0x0200
 
 /* Control register 1. */
 /* Enable extended speed selection */
diff --git a/drivers/net/axgbe/axgbe_phy_impl.c b/drivers/net/axgbe/axgbe_phy_impl.c
index 369d766884..aa245c1b44 100644
--- a/drivers/net/axgbe/axgbe_phy_impl.c
+++ b/drivers/net/axgbe/axgbe_phy_impl.c
@@ -303,21 +303,52 @@ static int axgbe_phy_write(struct axgbe_port *pdata, u16 reg, u16 value)
 
 static int axgbe_phy_config_advert(struct axgbe_port *pdata)
 {
+	u32 adv = pdata->phy.advertising;
 	u16 advert;
+	u16 ctrl1000;
 	int ret;
 
-	ret = pdata->phy_if.phy_impl.read(pdata, MII_ADVERTISE, &advert);
+	/*
+	 * AXGBE supports 10BASE-T and 100BASE-TX in full-duplex mode only.
+	 * Half-duplex operation (CSMA/CD) is not supported by the MAC,
+	 * so 10/100 half-duplex capabilities are intentionally not advertised.
+	 * Any ADVERTISED_10baseT_Half or ADVERTISED_100baseT_Half bits
+	 * present in the software advertising mask are therefore ignored.
+	 */
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
+	/*
+	 * AXGBE supports 1000BASE-T in full-duplex mode only.
+	 * Half-duplex operation (CSMA/CD) is not supported by the MAC,
+	 * so 1000BASE-T half-duplex is intentionally not advertised.
+	 * Any ADVERTISED_1000baseT_Half bit present in the software
+	 * advertising mask is therefore ignored here.
+	 */
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
2.43.0

