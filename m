Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C13B5606A896
	for <dpdk-dev@archiver.kernel.org>; Fri, 13 Nov 2026 16:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=mSNzcZkB
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 27C23427AD;
	Fri, 13 Nov 2026 17:05:50 +0100 (CET)
Received: from BL0PR03CU003.outbound.protection.outlook.com
 (mail-eastusazon11012051.outbound.protection.outlook.com [52.101.53.51])
 by mails.dpdk.org (Postfix) with ESMTPS id 5FC32402A2
 for <dev@dpdk.org>; Thu, 12 Nov 2026 14:56:32 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BOjsYApiVSYvfCnRmQ/7+HDWQFJlyU/WpjyYZxo9YfZBgmLEtEYEx/Ej2L5924RNAYKPJsUffwL13grkaShmUPxdDodSAwJiCxgMi84ACls92W4LL1lY1huOs5dHTzrjulv1zaeAZbsgp95q0hxfBe3vZ5/LbIvZTuhSkJZ+LeAOyNGxvh01oUqLACel3cKlsgVVbh0WstlF5vIHEJWQS6NuBF2Wt4ca6/WA1n7k3JtM4I0YzOvEEM1gNNOc5Kff8hwx1LExxF93u0z/Y2iEPVluK8RZbeiBtmAErFkxgYlqJ7Hjbp4mB8kZDcKWo9ygXf3MZ/r1MImY/yn76TPz2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=F6SKdnPBLbfjWVZCsO+xoTt2qCAgiifqNE6IVWqQH2Q=;
 b=Pde5A8fnIT69DjXhaNRx1fuNZExEHhOxNNq4SXefa1mwwnV9+BeSBwj41NSTtaudvAbVIsoBOOM7dmwK7JYM5iVcCzkSU59ZeXsJFNw8PcnKpHmnDfBSyL46KM7f59UH4JnefIwmqs2YSNTyfKq/lWJs5NS6von1Ym/XxtJGwHPtYuGPwEYwpRtRIXPnBqydJb5a5DKQmh2rYROeKNjI2t2jFo1SJv56WWIjEPPo+9YL3AUzA64I3GV3X8hcOjkOs6VX/Ut04sbZBGeAWg20L0f18GIgBJIpAr0riKzP98Mg3hv7b8r6RS8A+NBhQIrm+HJ2RYpxiW32aDqWZOK22A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=F6SKdnPBLbfjWVZCsO+xoTt2qCAgiifqNE6IVWqQH2Q=;
 b=mSNzcZkBee1n9xXLT6ZRXdfTbl7qFNUkQLCaieKGKcpIUSp5iUAEk5Cs70056XHjhqWFqsDNe4rnHoMnA7f9pVZXrJKD8Ze+5dAhmKKxZUQSub5bef7OfViIKjlT+xpoG5T20MnN1eTQSXzuAK4k8+fdi6DzEr82PFIudFUYxE8=
Received: from DS1PR03CA0015.namprd03.prod.outlook.com (2603:10b6:8:233::10)
 by CH3PR12MB9432.namprd12.prod.outlook.com (2603:10b6:610:1c7::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.9; Thu, 12 Nov
 2026 13:56:28 +0000
Received: from BN2PEPF0000A802.namprd02.prod.outlook.com
 (2603:10b6:8:233:cafe::75) by DS1PR03CA0015.outlook.office365.com
 (2603:10b6:8:233::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Thu, 12
 Nov 2026 13:56:28 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN2PEPF0000A802.mail.protection.outlook.com (10.167.245.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 12 Nov 2026 13:56:27 +0000
Received: from cae.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Thu, 12 Nov
 2026 07:56:26 -0600
From: Ajit Kumar <Ajit.Kumar@amd.com>
To: <dev@dpdk.org>
Subject: [PATCH] net/axgbe: serialize PHY and link status access
Date: Thu, 12 Nov 2026 19:26:11 +0530
Message-ID: <20261112135611.2757325-1-Ajit.Kumar@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A802:EE_|CH3PR12MB9432:EE_
X-MS-Office365-Filtering-Correlation-Id: 7664d77c-7894-43a3-e5a0-08df40c4bf58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|23010399003|36860700016|1800799024|18002099003|11063799006|261026121527099003|261022105027099003|261026140227099003|261022075727099003|261009223027099003|261028144727099003|56012099006|261021123027099003|261021121427099003|261021135927099003|261102123227099003|10067099003;
X-Microsoft-Antispam-Message-Info: 9dMhZaDS5qQN5TexXkV0csrvfuk3PJS1lglNjzQ6UReFvcCUSWLz5ig2g+0FZXqFbKhVm1tbeTWFrWXFrMIQyZEMKivF3+A2absahlRuq92PUMUYI1w324M+RYQgkwn7bKG73p0eTbpDBSrJeVUzafikDSI8SSPjIcuKZsTax8fKliTqIvZzZYPRZX7yKI42AceIfMdhT1eOB5E0uVi6nkc5OYvqllcSUMVRcY9tdEVFPLivo7QX9gCmx8o03aC4i5SYL+FuKKdbz55sJNU+oOrAgIia4k5aGKa8JemNbBw7Mt6x8KwLhW4HkWhztgE/VJcMJf8UWZatrvHBZD4tkVYTp0PC5nSowoCtsD5BorwklAcCOfPYuuACtY9Hy7CYrOOOgfaNQQWtFsWXsotDk3kTJc3vBEZU3iDeVcBOsWt2PKMwRhY+0o5+qxARqm2ExK8Y5DBmOLY3AiiwF8UjthTa5vWlX7nUG5CXJ7JERPWv2WsZhxh/BP/SXpFWD2Gz6AMDJGY88eSkxip1Etr4u5701sPsPdd05/crSpqTc8HHBM9INrwqfGD06lufpv96gmq/DvNZznEa+v8xQWqIujisAnikfTvT6AmhtD+kifdj0/dXJ8GU0iw38NFE0HJAAKqbTMeLT4jM3YIll3Rf4tYVa7ROirlkH62WxBfzX9UThaIr7kRK7q+hrvVozh+FnrEmLEHG3kVjRJjWQgKTFA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(82310400026)(376014)(23010399003)(36860700016)(1800799024)(18002099003)(11063799006)(261026121527099003)(261022105027099003)(261026140227099003)(261022075727099003)(261009223027099003)(261028144727099003)(56012099006)(261021123027099003)(261021121427099003)(261021135927099003)(261102123227099003)(10067099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 34ypIQY9dJ9Ze4IXnxT4j72LHLi3WI3dWg2Xyrgp9NJMposgHB7m7ClRx6cwZn/opsHOLrokpbB5OThLHgb2/sLUGgKGwTQR3V/RISO4c9xovFDj0zW7141uQBm84QZePjPjKsvft2I0GUkt/qgIMpZFpCi0CGMPi7ZsTykYF2rGudZ9REV1eStDpXcFKwB+XY4HSNuapzcA56gKOBfmW0Zjn5ZohPud7FzU+9BkcJrq3U4JoFv9dLtUy+qx2M7auh2J3GVU8E7Fw1jvs7c634JeTUlnBCiVPqLxaWWcTxTruEol7Wd1gft5hsTrJhHl7vJ4RXA6JE5BBcw4O5aBn6YUsYJcC3VqV90t3Qhf0BBznbMSES0mu16ThzwBjoykbHHyG+q9QazUszx08XTlHXGav5kHXgCCKDAFIoyZKNWspggSo5aiJzOn/t9XpGzk
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Nov 2026 13:56:27.7545 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7664d77c-7894-43a3-e5a0-08df40c4bf58
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BN2PEPF0000A802.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB9432
X-Mailman-Approved-At: Fri, 13 Nov 2026 17:05:48 +0100
X-BeenThere: dev@dpdk.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: DPDK patches and discussions <dev.dpdk.org>
List-Archive: <http://mails.dpdk.org/archives/dev/>
List-Post: <mailto:dev@dpdk.org>
List-Help: <mailto:dev-request@dpdk.org?subject=help>
List-Subscribe: <https://mails.dpdk.org/listinfo/dev>,
 <mailto:dev-request@dpdk.org?subject=subscribe>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

From: Ajit Kumar <ajit.kumar@amd.com>

Concurrent link status polling and PHY access can result in
simultaneous I2C/MDIO bus transactions. On systems with multiple
AXGBE ports this may lead to I2C transfer failures such as
-EAGAIN, -ENOTCONN, or -ETIMEDOUT and can cause incorrect link
status reporting.

Serialize access to shared PHY communication resources by
protecting PHY status updates and introducing a mutex around
I2C/MDIO ownership acquisition. Also add retry delays for
recoverable I2C transfer failures.

Signed-off-by: Ajit Kumar <ajit.kumar@amd.com>
---
 drivers/net/axgbe/axgbe_ethdev.c   |  3 +++
 drivers/net/axgbe/axgbe_ethdev.h   |  1 +
 drivers/net/axgbe/axgbe_phy_impl.c | 18 ++++++++++++++++--
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/drivers/net/axgbe/axgbe_ethdev.c b/drivers/net/axgbe/axgbe_ethdev.c
index 2411e74d97..9e36186eca 100644
--- a/drivers/net/axgbe/axgbe_ethdev.c
+++ b/drivers/net/axgbe/axgbe_ethdev.c
@@ -760,7 +760,9 @@ axgbe_dev_link_update(struct rte_eth_dev *dev,
 	PMD_INIT_FUNC_TRACE();
 	rte_delay_ms(800);
 
+	pthread_mutex_lock(&pdata->link_status_mutex);
 	pdata->phy_if.phy_status(pdata);
+	pthread_mutex_unlock(&pdata->link_status_mutex);
 
 	memset(&link, 0, sizeof(struct rte_eth_link));
 	link.link_duplex = pdata->phy.duplex;
@@ -2406,6 +2408,7 @@ eth_axgbe_dev_init(struct rte_eth_dev *eth_dev)
 	rte_thread_mutex_init_shared(&pdata->i2c_mutex);
 	rte_thread_mutex_init_shared(&pdata->an_mutex);
 	rte_thread_mutex_init_shared(&pdata->phy_mutex);
+	rte_thread_mutex_init_shared(&pdata->link_status_mutex);
 
 	ret = pdata->phy_if.phy_init(pdata);
 	if (ret) {
diff --git a/drivers/net/axgbe/axgbe_ethdev.h b/drivers/net/axgbe/axgbe_ethdev.h
index 77c21469a8..5bbda1b684 100644
--- a/drivers/net/axgbe/axgbe_ethdev.h
+++ b/drivers/net/axgbe/axgbe_ethdev.h
@@ -654,6 +654,7 @@ struct axgbe_port {
 	pthread_mutex_t i2c_mutex;
 	pthread_mutex_t an_mutex;
 	pthread_mutex_t phy_mutex;
+	pthread_mutex_t link_status_mutex;
 
 	/* Flow control settings */
 	unsigned int pause_autoneg;
diff --git a/drivers/net/axgbe/axgbe_phy_impl.c b/drivers/net/axgbe/axgbe_phy_impl.c
index 4abf5fdea9..43a258984f 100644
--- a/drivers/net/axgbe/axgbe_phy_impl.c
+++ b/drivers/net/axgbe/axgbe_phy_impl.c
@@ -531,6 +531,10 @@ static int axgbe_phy_redrv_write(struct axgbe_port *pdata, unsigned int reg,
 	return ret;
 }
 
+#define AXGBE_I2C_RETRYABLE(_ret) \
+	((_ret) == -EAGAIN || (_ret) == -ENOTCONN || (_ret) == -ETIMEDOUT)
+#define AXGBE_I2C_RETRY_DELAY_MS	2
+
 static int axgbe_phy_i2c_read(struct axgbe_port *pdata, unsigned int target,
 			      void *reg, unsigned int reg_len,
 			      void *val, unsigned int val_len)
@@ -547,8 +551,10 @@ static int axgbe_phy_i2c_read(struct axgbe_port *pdata, unsigned int target,
 	i2c_op.buf = reg;
 	ret = axgbe_phy_i2c_xfer(pdata, &i2c_op);
 	if (ret) {
-		if ((ret == -EAGAIN) && retry--)
+		if (AXGBE_I2C_RETRYABLE(ret) && retry--) {
+			rte_delay_ms(AXGBE_I2C_RETRY_DELAY_MS);
 			goto again1;
+	}
 
 		return ret;
 	}
@@ -561,8 +567,10 @@ static int axgbe_phy_i2c_read(struct axgbe_port *pdata, unsigned int target,
 	i2c_op.len = val_len;
 	i2c_op.buf = val;
 	ret = axgbe_phy_i2c_xfer(pdata, &i2c_op);
-	if ((ret == -EAGAIN) && retry--)
+	if (ret && AXGBE_I2C_RETRYABLE(ret) && retry--) {
+		rte_delay_ms(AXGBE_I2C_RETRY_DELAY_MS);
 		goto again2;
+	}
 
 	return ret;
 }
@@ -605,9 +613,12 @@ static int axgbe_phy_sfp_get_mux(struct axgbe_port *pdata)
 	return axgbe_phy_i2c_xfer(pdata, &i2c_op);
 }
 
+static pthread_mutex_t axgbe_i2c_mdio_bus_mutex = PTHREAD_MUTEX_INITIALIZER;
+
 static void axgbe_phy_put_comm_ownership(struct axgbe_port *pdata)
 {
 	pthread_mutex_unlock(&pdata->phy_mutex);
+	pthread_mutex_unlock(&axgbe_i2c_mdio_bus_mutex);
 }
 
 static int axgbe_phy_get_comm_ownership(struct axgbe_port *pdata)
@@ -616,6 +627,8 @@ static int axgbe_phy_get_comm_ownership(struct axgbe_port *pdata)
 	uint64_t timeout;
 	unsigned int mutex_id;
 
+	pthread_mutex_lock(&axgbe_i2c_mdio_bus_mutex);
+
 	/* The I2C and MDIO/GPIO bus is multiplexed between multiple devices,
 	 * the driver needs to take the software mutex and then the hardware
 	 * mutexes before being able to use the busses.
@@ -648,6 +661,7 @@ static int axgbe_phy_get_comm_ownership(struct axgbe_port *pdata)
 	}
 
 	pthread_mutex_unlock(&pdata->phy_mutex);
+	pthread_mutex_unlock(&axgbe_i2c_mdio_bus_mutex);
 
 	PMD_DRV_LOG_LINE(ERR, "unable to obtain hardware mutexes");
 
-- 
2.43.0

