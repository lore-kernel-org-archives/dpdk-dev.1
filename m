Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCBB3606A324
	for <dpdk-dev@archiver.kernel.org>; Thu, 19 Nov 2026 10:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=kcKBvE/L
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 4F07E402D6;
	Thu, 19 Nov 2026 11:54:20 +0100 (CET)
Received: from SJ2PR03CU001.outbound.protection.outlook.com
 (mail-westusazon11012008.outbound.protection.outlook.com [52.101.43.8])
 by mails.dpdk.org (Postfix) with ESMTPS id 059E5402DA
 for <dev@dpdk.org>; Thu, 19 Nov 2026 04:54:03 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gMzA5yTtGGFAFJ919ElqknSV7oJ3jRG8LxrGQn6+Nw3HFkzNVCR1+a2CoMPEs74zzKIxm4qGW3OAIFzBh5eQgfGAG0kyEAPPnwLmnVmx5minXB6tIQ0+yuRny4KpjXpp2g8IzO3wjptXGPKQFvizXvB0tsPMHLeT4jrum0IrMOdCUYnQU7knBO73ORnSmy44ztyWalAPKfMJ8r1maM9aPKsy2fSjdWcouTmk6g5qt51zVgRb63QFJR7+0gXUEmnH3Zy/7MBN2rJkQPApPL77ALHDnL5erSZYtOQUDue0o3hztEe50rfzrP7ao8s/itkWbxhomETIw0+MYd3pwz2SJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4a1F5OUWHXybWrKlGtR5/52VuvTe3K4Qqdp0biu1/qY=;
 b=xxNQk+JQ2luF5foGYVARYP32I2LqlU+xYBzZc2MsVrMrlfKxlcn1dbglV2s2n/4qTSfonHABCcLel6/qDbrTvzn8Y0fCwSN40EpPaR+wojlcj8DHOzr0hM91HK5xbB08ZgkWtYDWKbKNVi+pp5D2VISKo9XjgwWniiYCam0C9yqUD2R2wCwCqBH6N1WZDcCAvxfwhXr5/J3bxFT5oV/K9A5QAbwYfIoHTEXxLyaRqc/5x6LaUZ4oNQSImUHM50uMogSJt2h0An0FgZxkrOD7tURxX3NDa//npW80uolwcFnrMUph3UH+sGEpz6Lb9aZ9meUM1SSaY5ZbwR3aAlcrjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4a1F5OUWHXybWrKlGtR5/52VuvTe3K4Qqdp0biu1/qY=;
 b=kcKBvE/LJJX1S0LHQhd6GZ23Ns8LvOq/jAqQrWUlls9cwKV9r+N1FMOzZ2zmYb/p8krXP1EdLFMFAaqlrRQTLX6ZYc9GcSxDXT2xkQ9CkPL7zvS1gMJiggLNs4g+ujpovR9kQqjTo7dpAGNAlrJoIdiZTGDceueLhFae6P08mAU=
Received: from BY3PR05CA0019.namprd05.prod.outlook.com (2603:10b6:a03:254::24)
 by DM6PR12MB4043.namprd12.prod.outlook.com (2603:10b6:5:216::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.14; Thu, 19 Nov
 2026 03:51:57 +0000
Received: from SJ5PEPF000001C8.namprd05.prod.outlook.com
 (2603:10b6:a03:254:cafe::9d) by BY3PR05CA0019.outlook.office365.com
 (2603:10b6:a03:254::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.7 via Frontend Transport; Thu, 19
 Nov 2026 03:51:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001C8.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Thu, 19 Nov 2026 03:51:56 +0000
Received: from cae.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Wed, 18 Nov
 2026 21:51:55 -0600
From: Ajit Kumar <Ajit.Kumar@amd.com>
To: <dev@dpdk.org>
Subject: [PATCH] net/axgbe: retry transient SFP I2C read failures
Date: Thu, 19 Nov 2026 09:21:40 +0530
Message-ID: <20261119035140.2074510-1-Ajit.Kumar@amd.com>
X-Mailer: git-send-email 2.43.0
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001C8:EE_|DM6PR12MB4043:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b1278dc-51b6-495c-2869-08df45f07516
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|23010399003|36860700016|82310400026|376014|1800799024|6133799003|18002099003|261009223027099003|56012099006|11063799006|261021123027099003|10067099003|261026140227099003|261026121527099003|261102123227099003|261022075727099003|261026130827099003|261021135927099003|261028144727099003|261021130227099003|261022115727099003|261022105027099003|261022113327099003|261021121427099003;
X-Microsoft-Antispam-Message-Info: 1HPe8juHxRtQgKdfNcG/GrhkYfSQD7D0IqkB0EH0VJj/B1V9ymxes8UG1eyEixeBlYjHGVYkzbpMEWm388kpnMCR1RM4I0sY6goGYXACa7QGzI6MW1HOQFum7qPsBgazaTZIOahOMSAjkhDtIllCyjV/POgGA5gobjPHXEIFYHbYsHmbi0JE1Vr4oKoJu46Tasf3Tz38LdPFU6a5nqISMsY7tLXpOytx6BIXanNWwE41E6eEEKfypxH4KStWJYiv4MeI2kmMMGkUa/BUPNMFdqb21DMigfy4UlDvnlYqjLKGsQEqBRjvPPMkevRRBtsmDORm6j3WkuartTzhx+WcncpkHJdKRd2AT7XNETZKp4nCXxtJ/mYF6vimnzld6mt+qyzk39p7tFfJIef9n4CQ8+UvVRYprWB2oyVcZJtvPW5a0CIkySdNIBO0hjqtUxsXTzXo40wAyOtsxNE93VKpbZ1sqestyVLQ2wRJydWxboM3IXuuqHryG2vwhO0KDiwOGngQVWzFL4BbhhYgQDYRXiwWzyCeJYMV8KQflflndgfvPyOjbnauCjvm9NgliBvicXFv5mnwtTEC1O5wOnt1NbakY6CPXBSuRnMRGcRnSwlqoxfSBZrA0aYleOIV9GNYZwy+oB25iHdunM2+gfBgiM+n6W6OeDJM1rfKe5FQp10Uxbi+wTALw0Rrh74xnggugfNi3SEyuAxNnRNFbUKY5g==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(23010399003)(36860700016)(82310400026)(376014)(1800799024)(6133799003)(18002099003)(261009223027099003)(56012099006)(11063799006)(261021123027099003)(10067099003)(261026140227099003)(261026121527099003)(261102123227099003)(261022075727099003)(261026130827099003)(261021135927099003)(261028144727099003)(261021130227099003)(261022115727099003)(261022105027099003)(261022113327099003)(261021121427099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: Ns9ArCofvxlgEMkSAHe6TFB57Lrvy/uK/j9wijDxi+k50MGRS7262AMoUhw0oNt1eB0WwokBBmW6AVMA6Wi4A/PWE2HDb008Sz/v9F9bWbj2fM8jctQjVrm9VywgXGC17jQago++7IGU2GAMzJN8Jz0htM9ZKYB4yeFwmZDj+SzcyUepTVTrQSOX9JY1WY8pyaqegl2445bkoMN/pMBxc9ppxLSwV4ncxxXZ517p6jEzRF/eYW+RhKieTgFd+HkRoXjV3kMYipwciJCE+dwNsGgRHBZEmJWOqCGCtu5GRQoKYY31JKxUBRy3vuiKNpmQsMRhmHWQCzDZzF9ioRbMsT0VFunxME1f+lgDSY3bfn9FkEVViQ6laot5yfrLGq1UhYLFW4y2f0nMjYF1pMqDWvBwMKdNaKGTQkHVQCvJbleoGiTiEbH9OTn8cXEDNgzZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Nov 2026 03:51:56.7450 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b1278dc-51b6-495c-2869-08df45f07516
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001C8.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4043
X-Mailman-Approved-At: Thu, 19 Nov 2026 11:54:19 +0100
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

A port's very first I2C transaction against its SFP cage
(GPIO-expander/mux), issued right after axgbe_phy_init(), can fail even
with no other port active at all: either a quick NACK (-ENOTCONN,
IC_TX_ABRT_7B_ADDR_NOACK) or a full hardware stall with zero bus
activity until axgbe_i2c_xfer()'s own 1-second timeout fires
(-ETIMEDOUT, logged as "i2c operation timed out").

This is a different failure from the cross-port bus-contention race
fixed by the driver-wide axgbe_i2c_mdio_bus_mutex ("net/axgbe: serialize
PHY and link status access"): it reproduces on a single port with no
sibling port active, immediately after that port's own phy_init(), so
serializing the shared bus does not help with it. The SFP cage's I2C
mux/GPIO-expander device appears to simply not be ready to answer the
very first probe yet.

axgbe_phy_i2c_read()'s retry loop currently only matches -EAGAIN
(arbitration lost). Extend it to also retry -ENOTCONN and -ETIMEDOUT,
with a short (2ms) settle delay first, since an immediate retry is
unlikely to help if the device is still completing its own power-on
sequence.

Cost: on the -ETIMEDOUT path, this adds up to one more full internal
1-second timeout per phase for a genuinely persistent (non-transient)
fault. This is bounded to each port's first post-init access -- a
one-time bring-up cost, not something paid on every later
link_update() poll. Like any other access to the shared I2C/MDIO bus,
it runs while axgbe_i2c_mdio_bus_mutex is held, so it can delay other
ports' bus access by the same amount; this is no different from any
other bus access taking longer under contention.

Validated on two independent physical units (AMD CRB V3C48 and
Advantech FWA-1081): 0 I2C errors across 30 iterations of the existing
cross-port repro plus a dedicated solo-access repro, which now links
up cleanly on both ports; both failed deterministically without this
change.

Depends on the axgbe_i2c_mdio_bus_mutex added by "net/axgbe: serialize
PHY and link status access" for the cross-port case; this patch's own
hunk does not otherwise overlap it and applies independently.

Fixes: a5c7273771e8 ("net/axgbe: add phy programming APIs")
Cc: stable@dpdk.org

Signed-off-by: Ajit Kumar <ajit.kumar@amd.com>
---
 drivers/net/axgbe/axgbe_phy_impl.c | 46 ++++++++++++++++++++++++++++--
 1 file changed, 44 insertions(+), 2 deletions(-)

diff --git a/drivers/net/axgbe/axgbe_phy_impl.c b/drivers/net/axgbe/axgbe_phy_impl.c
index 55d45bfb7b..a70454ecb9 100644
--- a/drivers/net/axgbe/axgbe_phy_impl.c
+++ b/drivers/net/axgbe/axgbe_phy_impl.c
@@ -531,6 +531,44 @@ static int axgbe_phy_redrv_write(struct axgbe_port *pdata, unsigned int reg,
 	return ret;
 }
 
+/*
+ * The very first I2C transaction a port issues against its SFP cage
+ * (GPIO-expander / mux), right after axgbe_phy_init(), can legitimately
+ * find that device not yet ready to respond -- observed in the field
+ * as either a quick NACK (-ENOTCONN, IC_TX_ABRT_7B_ADDR_NOACK) or a
+ * full hardware stall with zero bus activity until axgbe_i2c_xfer()'s
+ * own 1-second timeout fires (-ETIMEDOUT). This is distinct from the
+ * cross-port bus-contention race fixed by axgbe_i2c_mdio_bus_mutex in
+ * axgbe_phy_get_comm_ownership(): it reproduces on a single port with
+ * no other port active at all, immediately after that port's own
+ * phy_init(), so serializing the bus does not help with it.
+ *
+ * Retry on these two codes as well as the existing -EAGAIN, with a
+ * short settle delay first, since an immediate retry is unlikely to
+ * help if the device is still completing its own power-on sequence.
+ *
+ * Cost: on the -ETIMEDOUT path this adds up to one more full internal
+ * 1-second timeout per phase for a genuinely persistent (non-
+ * transient) fault. This is bounded to each port's first post-init
+ * access -- a one-time bring-up cost, not a recurring one paid on
+ * every subsequent link_update() poll -- and, like any I2C/MDIO bus
+ * access, runs while axgbe_i2c_mdio_bus_mutex is held, so it can
+ * delay other ports' bus access by the same amount, same as any other
+ * access to this bus.
+ *
+ * Validated on two independent physical units (AMD CRB V3C48 and
+ * Advantech FWA-1081): 0 I2C errors across 30 iterations of the
+ * original cross-port repro plus a dedicated solo-access repro, which
+ * now links up cleanly on both ports; both failed deterministically
+ * without this change.
+ */
+static inline bool axgbe_i2c_retryable(int ret)
+{
+	return ret == -EAGAIN || ret == -ENOTCONN || ret == -ETIMEDOUT;
+}
+
+#define AXGBE_I2C_RETRY_DELAY_MS	2
+
 static int axgbe_phy_i2c_read(struct axgbe_port *pdata, unsigned int target,
 			      void *reg, unsigned int reg_len,
 			      void *val, unsigned int val_len)
@@ -547,8 +585,10 @@ static int axgbe_phy_i2c_read(struct axgbe_port *pdata, unsigned int target,
 	i2c_op.buf = reg;
 	ret = axgbe_phy_i2c_xfer(pdata, &i2c_op);
 	if (ret) {
-		if ((ret == -EAGAIN) && retry--)
+		if (axgbe_i2c_retryable(ret) && retry--) {
+			rte_delay_ms(AXGBE_I2C_RETRY_DELAY_MS);
 			goto again1;
+		}
 
 		return ret;
 	}
@@ -561,8 +601,10 @@ static int axgbe_phy_i2c_read(struct axgbe_port *pdata, unsigned int target,
 	i2c_op.len = val_len;
 	i2c_op.buf = val;
 	ret = axgbe_phy_i2c_xfer(pdata, &i2c_op);
-	if ((ret == -EAGAIN) && retry--)
+	if (axgbe_i2c_retryable(ret) && retry--) {
+		rte_delay_ms(AXGBE_I2C_RETRY_DELAY_MS);
 		goto again2;
+	}
 
 	return ret;
 }
-- 
2.43.0

