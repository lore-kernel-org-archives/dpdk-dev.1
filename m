Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA7C0FEE4ED
	for <dpdk-dev@archiver.kernel.org>; Sat, 28 Feb 2026 15:35:52 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 14A0940B8F;
	Sat, 28 Feb 2026 16:35:51 +0100 (CET)
Received: from SN4PR2101CU001.outbound.protection.outlook.com
 (mail-southcentralusazon11012033.outbound.protection.outlook.com
 [40.93.195.33]) by mails.dpdk.org (Postfix) with ESMTP id 151434013F;
 Sat, 28 Feb 2026 16:35:50 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=kOKuNOilGu01rvYiKdsawTv+XQ42vyU4mrOJP8CyLw8xCTmpUOR/vleDcOPn6ucHF8t05PeN//SZDGXRPOM8p6zfW2rQQoJHauTarqStD/QJTMwaobDAVkJFrRpjtYYMKO/c7XkK5PA1Xd7oMpah5lL8LHRfOpX9UMda523gDuX8/cMwoXM3atzmBHA4StORPpuTj89HpMt10dKmSUfPONlB7hLE6S2MDgKCvSs7koyGQ4DXC9PGKVwtyp4LH16xNeYUMdp+6mrWDLlsW9bsKeMIjkxNOEBAuMAyFBEkLzEn3F1CYocJhpjV8qfvptvOz0RKBDNr5EdL4PVEFotTWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xcX/9oAJuNUfdcuG0qSiDEnV6Uj5VItmMC5xev4/LMQ=;
 b=U33SG5Tni3XEBGBegDAauO0k6hhQPk9CT6DprRJqxuN9Vu8QL/j+e8bmJJUj6X1n21AF/hUWUguAs/XbHcRUrTcNlvAMA0oZB3Xn0Iub35WTA7UeoAQ1VHejEENdaYJG8xn0Xbz8QOAWiPaxNwBFwkDMqwhrGEiqBnEKWEGLhHmqoo/kM6QF9vRT0yk3p6kjGOOihlSp3ld6/2lL2P+02qOyzgeCg9vpyITd22LBljIng2mOvOszlHiyG3xc2m/0hmINjpNxS30va7h/zZ6Di9/rjaDEHuAxw2lonnNau66RdOAQUZNK2Qkl/mT+i7GGPEfqFtJET5vN4ZjIG3B48Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xcX/9oAJuNUfdcuG0qSiDEnV6Uj5VItmMC5xev4/LMQ=;
 b=lweDLEPvEEQQMkrrdzOAW3o2lo2ZMrQpmGZdxADOSy/ip3ki37dBKPPO4nmHsojB84AhlfiPayJR4AWuym02cOgb572oRBSXE0qrq1lnH4WDDLyxOgeaMgMNd/y6g/zsc++dwq1Z2g4nhqJ+Oc8kyc1zMvWDP0W+iDxM94xEtqg=
Received: from SJ0P220CA0015.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:41b::19)
 by CH2PR12MB4312.namprd12.prod.outlook.com (2603:10b6:610:af::14)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.17; Sat, 28 Feb
 2026 15:35:43 +0000
Received: from SJ1PEPF000023CE.namprd02.prod.outlook.com
 (2603:10b6:a03:41b:cafe::4f) by SJ0P220CA0015.outlook.office365.com
 (2603:10b6:a03:41b::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Sat,
 28 Feb 2026 15:35:37 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000023CE.mail.protection.outlook.com (10.167.244.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9654.16 via Frontend Transport; Sat, 28 Feb 2026 15:35:43 +0000
Received: from BLRASNATARA.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 28 Feb
 2026 09:35:41 -0600
From: Ashok Kumar Natarajan <ashokkumar.natarajan@amd.com>
To: <dev@dpdk.org>
CC: <Selwin.Sebastian@amd.com>, Ashok Kumar Natarajan
 <ashokkumar.natarajan@amd.com>, <stable@dpdk.org>
Subject: [PATCH v5 3/3] net/axgbe: fix 100M SGMII mode
Date: Sat, 28 Feb 2026 20:10:33 +0530
Message-ID: <20260228144035.666-1-ashokkumar.natarajan@amd.com>
X-Mailer: git-send-email 2.53.0.windows.1
In-Reply-To: <20260227084546.729-1-ashokkumar.natarajan@amd.com>
References: <20260227084546.729-1-ashokkumar.natarajan@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000023CE:EE_|CH2PR12MB4312:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a7a6500-e21c-484a-957c-08de76df0913
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|82310400026|376014; 
X-Microsoft-Antispam-Message-Info: JXm3rDmc2t1lcaBFo7sMkTJI4O6O6caTV4DhhXdoi9qR4b/2ecdXsX87OEIkwP5aHcvZoooz8BRkdBjBbFCvlUpkkPC/YCcJNpIg520fEKqqMZxK8Pgm6adVEPvC6NQtal0Y2LEtidh1W0Z3pTsJzgDt5DpHqmhocnP4ulLsEmjfztmykUzHQoqW2s0SfSsYj1FPp61VZeX9P7/kBuJomLVSj7C+OYUhV3FbHUKM8qN5tQQdaRPKEio+GrOTVSPjCTYmkugIY2mbRS7GlETiAdu4wnIDlTgg9FQr+9ecksS9t+p5z0fceXLQHshJgktquMHNMUV2NdqtcEk8uMcqge5bH8fOMvJl71NMGDnYDwK2ixTmK0FP/+GJgoNN1SbCjS1DpiYiakqTF5/5H3WAjrmOzgD9mgSM7i4+uayBdGj7NjwNv+EIkwMZhmRCy5mm4qLAstV6K9RcEf4BVj5SrH4wyDEFoddEkBuwjv/3aqbePfZC5lbhoy0jkVIBExVVVabQAP8JwrXwU3Jxq/qtc3zeW/qZJ9yjoSNjyz6Sr4DJ3RTAIj1hGrYOUSSv+/yYHaL4HcA/s9/oLTRUaPs8Oo2w+8Z9x7ui/xMqdDibKk+HEw8p8AvSsgYlj6QueSFr/LDob0lGZw1NvFj8Kt/jJMlGY2Yx0WBJV3h9ss/eUacbfiPC6HWh9Qsx7hqQDYfH1zMxhQ/tzRH8k6/TOmI3XkcEF8wN+a0SJ88+zz+kTTjru6SfrVa5Fc5jAifPzPoBkbPvl7tABqVFOvwFgLBfY3+1XdGdT4UPAauh+/hth1zqlT6lZmzLu5xB2v4IMNxzUZL6ciJNllfrpmwu+mIU7Q==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700013)(1800799024)(82310400026)(376014); DIR:OUT;
 SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: mM3y0UJ02si+C2QVitFZpJASgLB5mLzb6jpY/rUCkHvfVon5tVgq8QpP7RN9tBNt/N3TkQMm8NRvaXEmgSpk0nZryPpCGULDOrVbqozWEKufSRW4jN2SZ1IYTv1ng6WujI9cpT+SF1zgaz3mRnD5vDNkn3/7h8Yvs+/6p2sPXyjkEdB0Dn3tajD8eO7LOEhQKlsxNNNUloeIN3vlbRP6PQ/jDBUtae3o7exavrwcMpBBz6wd0ES3keoEgs7l2K7MRI57muuSviRY0K6s1RO4EKb2bEVicLQWFI8bjGp/ds5dZKnDg5inV5KiMxTLb3BS7raPw45aN7OEZJaIH9mEQioQaOSqBEKN6w9a2AaYXoxOJ6aPY+AYeeYmZXo1c1EjS18X+f/UQnK5luUY2bPMEnUMSzvnkd9B+HAD6rl+rh2bFfC9Gkp8IY9WPJUJdYwk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2026 15:35:43.3984 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a7a6500-e21c-484a-957c-08de76df0913
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000023CE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4312
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
index e180fd28e1..369d766884 100644
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

