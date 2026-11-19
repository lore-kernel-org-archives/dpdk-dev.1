Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E348606A320
	for <dpdk-dev@archiver.kernel.org>; Fri, 20 Nov 2026 10:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=3tOrZv40
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 6260D402E3;
	Fri, 20 Nov 2026 11:13:17 +0100 (CET)
Received: from MW6PR02CU001.outbound.protection.outlook.com
 (mail-westus2azon11012063.outbound.protection.outlook.com [52.101.48.63])
 by mails.dpdk.org (Postfix) with ESMTPS id 50CE2400D7
 for <dev@dpdk.org>; Thu, 19 Nov 2026 18:35:36 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mQ7FjX3z9XEJR0vEpbmuAhbdDBoG8izh7KCsvZb+3t5qOEzae4AAzk3gFtJUkBK6CRMwso35lHS+xI3194e7KSbnA8CsTyrpWtL5BtPXVN4F32Dat+SgGXhEmZmopY9ljj7gbAcXomScwoI3XA06nb64F+5kaYd4jtT880PmhWqUVZGB8kTdnkhdZmqsKZwtAznUueO29490Qjqh8o8idAdN24JThxwBIuevqIAz7sDC6L3SgI+gVPfjwShxda+EuvJGWuDSy3lfBrxeOfCaudOhKNzmbnor/82oCPTgHo5RkGoiUpE/1L6GGtTn28awH6p5RFV6y5ZQCIhcMlixVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cAbFeZmpkA/T8T4UQF1R9jefS9Xz90I64fhwae+VwmE=;
 b=II2d7yn3J4vl+Bj2LOrlXtOd0FidVu3b91J6Lssq8WZMB1wbEfbRmJxsp/2gcH0166gsTgZ9Kwhbq74c8a7Rkq883AZK0dVuCOGB0Q0nj0J6pX+nX08YTsYyapu83dxDAVd0+f+vl6dOAtjtlBDbGvflm95FvpnlzTAJxOg7IdAX3nFiekpkhTwwRlD5Q/Ybh4MDi1z0OwFweUl2UQ0TkCDhnpA1WYDkKzRBMypLVP2FTub/RjFl3eW7xTh+z68A2kfp7L3gPjgKiugpRKhnzjzSooiBa/KdnhB6iH8cRk8iTfvoC1TLVoUqvw1cwOrlTELCc5O1zZlSn9v0yGV5ZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cAbFeZmpkA/T8T4UQF1R9jefS9Xz90I64fhwae+VwmE=;
 b=3tOrZv40Xv1Uhc0P+FeAWDMwwoJqJNnZqHKVNBuuXYplzqQh/QziAnTUNIYOQKR1UpHz+5gMlnYhUj+11YA623VaFj/e/aA0tKDD2QqejqJTtmR3XCBveXB+0ESwzWZYNuZe9gVnnt7L455FTo5R1uwX7xHbC479AjS04d55fHI=
Received: from DS7P220CA0090.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:25a::9) by
 MW4PR12MB7117.namprd12.prod.outlook.com (2603:10b6:303:221::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.12; Thu, 19 Nov
 2026 17:35:23 +0000
Received: from DM3PEPF000265AE.namprd02.prod.outlook.com
 (2603:10b6:8:25a:cafe::2d) by DS7P220CA0090.outlook.office365.com
 (2603:10b6:8:25a::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Thu,
 19 Nov 2026 17:35:22 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM3PEPF000265AE.mail.protection.outlook.com (10.167.23.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Thu, 19 Nov 2026 17:35:22 +0000
Received: from cae.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Thu, 19 Nov
 2026 11:35:20 -0600
From: Ajit Kumar <Ajit.Kumar@amd.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>
Subject: [PATCH v2] net/axgbe: retry transient SFP I2C read failures
Date: Thu, 19 Nov 2026 23:05:06 +0530
Message-ID: <20261119173506.840405-1-Ajit.Kumar@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119035140.2074510-1-Ajit.Kumar@amd.com>
References: <20261119035140.2074510-1-Ajit.Kumar@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM3PEPF000265AE:EE_|MW4PR12MB7117:EE_
X-MS-Office365-Filtering-Correlation-Id: 2aebb494-bb1c-4369-7a19-08df46637ce7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700016|1800799024|82310400026|23010399003|5023799004|11063799006|261009223027099003|261021130227099003|261021123027099003|10067099003|261102123227099003|261021121427099003|261021135927099003|261026130827099003|261026121527099003|261028144727099003|261022115727099003|261022113327099003|261026140227099003|56012099006|261022105027099003|261022075727099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info: BTMZuGrwYpg1rIIpwf9wlBQ1wrXiLRmqYOkERFs56tPo6a8zIHhMwTcHSKR8ezU7QLUEaQ7EMbUkdM9EISkG4e2vdtxuJTsaiB4gzZw8Uu953Cc86zAxir+ZtNN1749bxfASNLCDTmcViQvGcpFcCp9/NjSY1zRwVkTz2Y7G9f3Ks6/cK3uZPSsJAmQ+ggz75q483Eq2PuA2TwDMSv1NhlOU6wAf2R6UeeZfVrEnheegYHajfQGdoIM5MvBpd8g3+7/LR+sKTfpQ/g6EgKuhkR0kPTxQdscXafsgiLcMPfegNOme76OipSPbYsN66HRHC5HmMoM2V5xAyJIQtmiZ828wTEPnpX9rMUtfPwQ1xK4pUZrhFqDFxItvLG/T7x+tRbPsAVajnZM/bfv6aLP1TLJ/uVv9RAr7l4un4cyZCdOpplDAVR7SrOvXsNyD0dfmUBrrw97OevIX+bb6Ub1TeQgdnF4CGYC+cbdFDX1Sopird42i4Z+DEkwSfs499qbgVfyZekcVHx1PgHxTT0rpeFNxkX81GRL2Ge6Q4x1Z6CH+CGFvB+CDEtXiasLgxpFFPy+Dr49XcrJYwJjAGrmEEGwuqXx3suUSRXRZRUoyyMt9Lkh1rAUiinRqLxXjPTwzfDw1Bb6hq6vzthZciNGPus7ZVDKyfqkk8MlwKg/Ne+/zw3QY+eQZUnyRn/6uU0oGqmLv9i7OqSTmwrJ1uPzbwA==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(376014)(36860700016)(1800799024)(82310400026)(23010399003)(5023799004)(11063799006)(261009223027099003)(261021130227099003)(261021123027099003)(10067099003)(261102123227099003)(261021121427099003)(261021135927099003)(261026130827099003)(261026121527099003)(261028144727099003)(261022115727099003)(261022113327099003)(261026140227099003)(56012099006)(261022105027099003)(261022075727099003)(22082099003)(18002099003)(6133799003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: riDFCknl5ZrJtoMkRc/M6CPu9NSiPhSiyrFGRjsoyIgRhXy+wE7H+RLm3NWU/aKeRbaOMak1DrUJH2CYR2IWBTRRmQy/gSOo4zCaq2jLIIKAsk/bKOpcY7Ox1sRzunH/J5uVYgwLQKmydghXkHN6RZmMNSDL6urGY+hSYW5Ic/89jnlEmVa7AiFVI3foBs8J5AnsB2XkphAj3uxNmQtXnuyYMjdJfrLpfxJs9p41FSgjejG1JTMevGm452z2gdspZVKwcIfkgyE+lOv2Lot6yRlUAXbITCxQWVE5AnHZsRjtSLvG8XBFGxtg5Oo1jt4DKx1H1Ax0ZQKesXCXBWPZ5Vx9j4aVu98A8HBeYu8ICqq2KS2ALJjFCTpR785+L3Av+anGQxpHzUC798l15XO5yUmXKXskDM8HPmOHzifKAQ5/ejgvXpe8HPCgDfBF1mmB
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 17:35:22.0331 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2aebb494-bb1c-4369-7a19-08df46637ce7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DM3PEPF000265AE.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB7117
X-Mailman-Approved-At: Fri, 20 Nov 2026 11:13:15 +0100
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

A port's first I2C access to its SFP cage can fail right after
axgbe_phy_init(), even alone on the bus: a quick NACK (-ENOTCONN) or
a full stall until axgbe_i2c_xfer()'s own 1s timeout (-ETIMEDOUT).
This is separate from the cross-port race fixed by
axgbe_i2c_mdio_bus_mutex; it shows up on a single port with no
sibling active, so serializing the bus doesn't help.

axgbe_phy_i2c_read() only retried -EAGAIN. Retry -ENOTCONN and
-ETIMEDOUT too, with a short settle delay, but only until the port's
bus has one successful transfer since phy_init(). After that, a
repeat is a real fault, not a settling device, and shouldn't cost
every later poll an extra second while holding the shared mutex.

Validated on AMD CRB V3C48 and Advantech FWA-1081: 0 I2C errors
across 30 iterations of the cross-port repro plus a solo-access
repro that now links up cleanly on both; both failed every time
without this change.

Depends on axgbe_i2c_mdio_bus_mutex from "net/axgbe: serialize PHY
and link status access" for the cross-port case; otherwise applies
independently.

Fixes: a5c7273771e8 ("net/axgbe: add phy programming APIs")
Cc: stable@dpdk.org

Signed-off-by: Ajit Kumar <ajit.kumar@amd.com>
---
v2:
 - the extended retry wasn't actually limited to the first access as
   claimed; nothing tracked that state, so a persistent fault paid
   the cost on every poll. Added a per-port settled flag to gate it
   correctly (per DPDK AI code-review bot).
 - switched the delay to rte_delay_us_sleep(), a real sleep, since it
   can now be held more than once.
 - cut the in-code comment, which just repeated this commit log
   (per Stephen Hemminger's review).
---
 drivers/net/axgbe/axgbe_phy_impl.c | 38 ++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/net/axgbe/axgbe_phy_impl.c b/drivers/net/axgbe/axgbe_phy_impl.c
index 55d45bfb7b..57bd1f64d4 100644
--- a/drivers/net/axgbe/axgbe_phy_impl.c
+++ b/drivers/net/axgbe/axgbe_phy_impl.c
@@ -223,6 +223,7 @@ struct axgbe_phy_data {
 	unsigned int sfp_tx_fault;
 	unsigned int sfp_mod_absent;
 	unsigned int sfp_changed;
+	unsigned int sfp_i2c_settled;
 	unsigned int sfp_phy_avail;
 	unsigned int sfp_cable_len;
 	enum axgbe_sfp_base sfp_base;
@@ -531,10 +532,29 @@ static int axgbe_phy_redrv_write(struct axgbe_port *pdata, unsigned int reg,
 	return ret;
 }
 
+/*
+ * The SFP cage mux/GPIO expander may not respond to the first access
+ * after phy_init(), either NACKing (-ENOTCONN) or stalling until the
+ * transfer times out (-ETIMEDOUT). Retry those as well as
+ * arbitration loss (-EAGAIN) after a short delay, but only until the
+ * first successful transfer; after that it's a real fault, not a
+ * settling device.
+ */
+static inline bool axgbe_i2c_retryable(int ret, bool settled)
+{
+	if (ret == -EAGAIN)
+		return true;
+
+	return !settled && (ret == -ENOTCONN || ret == -ETIMEDOUT);
+}
+
+#define AXGBE_I2C_RETRY_DELAY_US	2000
+
 static int axgbe_phy_i2c_read(struct axgbe_port *pdata, unsigned int target,
 			      void *reg, unsigned int reg_len,
 			      void *val, unsigned int val_len)
 {
+	struct axgbe_phy_data *phy_data = pdata->phy_data;
 	struct axgbe_i2c_op i2c_op;
 	int retry, ret;
 
@@ -547,8 +567,10 @@ static int axgbe_phy_i2c_read(struct axgbe_port *pdata, unsigned int target,
 	i2c_op.buf = reg;
 	ret = axgbe_phy_i2c_xfer(pdata, &i2c_op);
 	if (ret) {
-		if ((ret == -EAGAIN) && retry--)
+		if (axgbe_i2c_retryable(ret, phy_data->sfp_i2c_settled) && retry--) {
+			rte_delay_us_sleep(AXGBE_I2C_RETRY_DELAY_US);
 			goto again1;
+		}
 
 		return ret;
 	}
@@ -561,10 +583,18 @@ static int axgbe_phy_i2c_read(struct axgbe_port *pdata, unsigned int target,
 	i2c_op.len = val_len;
 	i2c_op.buf = val;
 	ret = axgbe_phy_i2c_xfer(pdata, &i2c_op);
-	if ((ret == -EAGAIN) && retry--)
-		goto again2;
+	if (ret) {
+		if (axgbe_i2c_retryable(ret, phy_data->sfp_i2c_settled) && retry--) {
+			rte_delay_us_sleep(AXGBE_I2C_RETRY_DELAY_US);
+			goto again2;
+		}
 
-	return ret;
+		return ret;
+	}
+
+	phy_data->sfp_i2c_settled = 1;
+
+	return 0;
 }
 
 static int axgbe_phy_sfp_put_mux(struct axgbe_port *pdata)
-- 
2.43.0

