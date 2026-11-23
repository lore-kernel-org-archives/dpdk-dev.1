Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E297606A31E
	for <dpdk-dev@archiver.kernel.org>; Mon, 23 Nov 2026 12:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=tI1iVr/9
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 70BA440395;
	Mon, 23 Nov 2026 13:57:10 +0100 (CET)
Received: from CY7PR03CU001.outbound.protection.outlook.com
 (mail-westcentralusazon11010010.outbound.protection.outlook.com
 [40.93.198.10]) by mails.dpdk.org (Postfix) with ESMTPS id 88E4E40262
 for <dev@dpdk.org>; Mon, 23 Nov 2026 12:52:45 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nUNexN1PtxxIzoNFs/8kQuJZTE7UwCLI8EJGf7MlBPP6eKftMCQFOTXoaEeltsUQR7NL50lVyhDavV6oHpGdKJW7h7UtbQJS1A3ZXu0O0QJxYNhKdEZXwauOdZSw6pb/q4MltISx9+E9y3+k8EsBnjqF0CpOFk7fJpOmyHMOox+Tf75CWtCw58bjNCzaYMLqlb3dNGL5ouVYl8DSuIH3agnHIhG9jkrNUuhmXJcBEK+n2lTJNVVK8RH2e+PPh+E2UDPA5Gl5fgPi14cyz/s+c6rp9GTI3zEJ4/qfxs1JDkDMXSOYDpkNEf5Mr2YgQoMA3K7CnK0jsM4FCNkVLwWfFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eoYode0gjuaxboBE9S988TGcPc9cr+npcKzZabbyXMI=;
 b=G1guBLvTi3LXKCku8OW/G53F6co+PlzGqe6d3TTieaa38lVhFSaTe0yn0OmFsIM+aOpFIkGw4+y5xmoWcNGJBMruA9wgEruin6e1r3nl+UjNVQkblKv7G4qIEy7G16EFWuWIbegnNqUdoUC4Tf+nUgsKp/ZmE/7MxRAF75BbSBeOCYT0YqLjlzdImFnfr86FlPCwqS95UpCD4GPXl8mlfAR5kdiv7e0qZpAzK+pJ6GJXsaBu4xmKwKaDw94qSSjrVhz/uJAlFvXofZZPWS3d78tKr1u1cx2hCjV52EgpMdb5hcgzzJTEzsQYcRyyPc4hoQ0mWNWwag3TlaYxoZso3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=dpdk.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1; 
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eoYode0gjuaxboBE9S988TGcPc9cr+npcKzZabbyXMI=;
 b=tI1iVr/9UYfCAC7SijWQ1oSe9L0IzuPzhWtAkTkqo+G4iLKlxf4L1Lk+z0MfHG/vr9G1dJ+uHhs9HsNOoVbpHpKrKDyZQ5yNjCt0HfQbAGeZ0hAZON6oi90eVo+ZT9tbGzy1oSjURWPTo1GccP/jGt+U0P8LMBr/x8cc1XAVRbA=
Received: from BY1P220CA0019.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::15)
 by DS6PR12MB316809.namprd12.prod.outlook.com (2603:10b6:8:4f6::17)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.14; Mon, 23 Nov
 2026 11:52:41 +0000
Received: from SJ1PEPF000026C6.namprd04.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::9) by BY1P220CA0019.outlook.office365.com
 (2603:10b6:a03:5c3::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Mon,
 23 Nov 2026 11:52:41 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com;
 dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF000026C6.mail.protection.outlook.com (10.167.244.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 11:52:40 +0000
Received: from cae.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.57; Mon, 23 Nov
 2026 05:52:38 -0600
From: Ajit Kumar <Ajit.Kumar@amd.com>
To: <dev@dpdk.org>
CC: <stephen@networkplumber.org>
Subject: [PATCH] [PATCH v3] net/axgbe: wait for SFP cage I2C readiness on
 first probe
Date: Mon, 23 Nov 2026 17:22:24 +0530
Message-ID: <20261123115224.2199549-1-Ajit.Kumar@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261119173506.840405-1-Ajit.Kumar@amd.com>
References: <20261119173506.840405-1-Ajit.Kumar@amd.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF000026C6:EE_|DS6PR12MB316809:EE_
X-MS-Office365-Filtering-Correlation-Id: c400acf2-b818-4162-1537-08df495846ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700016|23010399003|82310400026|1800799024|376014|261102123227099003|261028144727099003|261021123027099003|261021121427099003|261021135927099003|261022115727099003|261022075727099003|261022105027099003|261022113327099003|261021130227099003|261026121527099003|261026140227099003|261026130827099003|11063799006|5023799004|56012099006|10067099003|22082099003|18002099003|6133799003|261009223027099003;
X-Microsoft-Antispam-Message-Info: QQNFE5RkxPs0MyqmKSpVt6IZDh2H/FInKc8JGgUz1uRI4Sy+scx6eg9bAQrgF4O3RZtVYhzQMChgUYHMBz7oLRh+82/B9eALr+gFIDYMhureltrjnHlZ6OnynvmTM1gOKMf2jHifDSFnnC7pD4yaIgvtxlWvGrqZMAyesgSR0R8IYdIx0jeJSBrRcm0wnUCaC5SOdwMX5HjXz+/3UdA7kuQRSC5NW0Yne9Rs5qEwjp3wfN3t8cSaJBFcLrsfqAJodNeNXkuL4i6517I+BzS2xJy1oA3SdJS9ZsyRaWjTfBIOZs8SB5soqoL2whk47mtM0CLH9Z1JNVgMBMPCuMRKSNrlDL4XUy8PqH0GIg2c8rTqsRpUuy0828suKiRMzYuNbiN2gyS1i4pQV/7qNEogkU0K+KKBgGt/gh1wtlaz5ayaTDKLL4ARdMfpP8bVNjX/n8rmGcm7Eq2ONYJ0GPukzZj5eDM2US3PLmrJBWlfSpV3o04uYGYmfg0WNaGJKD+tziYX6RZ4HSHN2lB14+bQJYNWu8LfsN5KmLPc4dacG4htS25cQWHUHix5WSyLQYnXURsqhKGhhLQwVlOA9Kg0rsm0qO4zKUepRerFD1lgRx5w0bucD97Al9QeCdRIlA5Nw+mQ5jKuLBRh8cCpkILs/i94YdsWhEL0hathocd5bzpjs9GE+PAb8DE/6GeZwGqh4J7ZPHnMwBd2FAv+rKZ/Dg==
X-Forefront-Antispam-Report: CIP:165.204.84.17; CTRY:US; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:satlexmb07.amd.com; PTR:InfoDomainNonexistent; CAT:NONE;
 SFS:(13230040)(36860700016)(23010399003)(82310400026)(1800799024)(376014)(261102123227099003)(261028144727099003)(261021123027099003)(261021121427099003)(261021135927099003)(261022115727099003)(261022075727099003)(261022105027099003)(261022113327099003)(261021130227099003)(261026121527099003)(261026140227099003)(261026130827099003)(11063799006)(5023799004)(56012099006)(10067099003)(22082099003)(18002099003)(6133799003)(261009223027099003);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: jo8tJphfp/YJxAML9LJKl55xM3JSyOV/svgSledfwLUj55t4Mb9Fc/VCQJq8S4SJrHKcHrc789YHWfYon6qEgeLsZ3Cegcyu3J0MxTXUozUruYUc/eSjSwxscZ5UJgnPbAf7PvrPkTphEHFsAan4VLOfuQG5gVbHPvd/HLFMDQtR/BirZsjmf4icZ//ceFXH73t8ggo+ZqXrPfYWr7RMUftreJxdEuVU0a5bpdAyawRYwYvyrtycvaS1KISt7Vl8ZM5sD2gh2Yq6LwWHn7s7S/cPwFO/z3q0M25gli/4IqbZiEDxbmLk9adZeCYuaVcL37GMXT8OmJ21SC8Q2OXYuYx2WXeDID5uBKIwajjyZlLmnk3ZDrPobWwaoBlQfFeQKw0VmZ3FGys5nhbE8+Qi/E/T5xStGYhe+lBTuiR7JFfQys8EJTE7nH/diZqfg9sY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 11:52:40.5689 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c400acf2-b818-4162-1537-08df495846ff
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d; Ip=[165.204.84.17];
 Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF000026C6.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS6PR12MB316809
X-Mailman-Approved-At: Mon, 23 Nov 2026 13:57:08 +0100
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

A port's first I2C access to its SFP cage after axgbe_phy_start() can
fail with a quick NACK (-ENOTCONN) or a stall until the 1-second I2C
timeout (-ETIMEDOUT). This is distinct from the cross-port race fixed
by the driver-wide I2C/MDIO bus mutex: it reproduces on a single port
with no sibling active, right after that port's own phy_start().

v2 retried these codes inside axgbe_phy_i2c_read(), gated by a flag
set on first success. Two problems: the flag lives in phy_data,
allocated once at probe and never cleared across phy_start()/
phy_stop(), so it doesn't track the access it's meant to gate; and a
device that never responds never sets it, so a persistent fault pays
the extra retry on every later link_update() poll, unbounded. The
retry also ran while holding the bus mutex, blocking other ports for
its duration, the concern raised against the original combined patch.

Drop the retry and the flag. Instead, wait briefly in
axgbe_phy_start() before the first SFP probe, before the bus mutex is
even taken. Fixed, known cost per phy_start(), no state to go stale,
nothing held while waiting. axgbe_phy_i2c_read() reverts to its
original -EAGAIN-only retry, unchanged.

Fixes: a5c7273771e8 ("net/axgbe: add phy programming APIs")
Cc: stable@dpdk.org

Signed-off-by: Ajit Kumar <ajit.kumar@amd.com>
---
Depends on the driver-wide I2C/MDIO bus mutex from "net/axgbe:
serialize PHY and link status access" for the cross-port case;
applies independently otherwise.

v3: dropped the retry/flag design, replaced with a settle delay before
the first SFP probe in axgbe_phy_start(), outside the bus mutex.
axgbe_phy_i2c_read() is unchanged from upstream.
v2: gated the extended retry with a per-port settled flag (bounded to
first access, per CI bot); switched to a real sleep; shortened the
comment.
---
 drivers/net/axgbe/axgbe_phy_impl.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/axgbe/axgbe_phy_impl.c b/drivers/net/axgbe/axgbe_phy_impl.c
index 55d45bfb7b..83e6a16753 100644
--- a/drivers/net/axgbe/axgbe_phy_impl.c
+++ b/drivers/net/axgbe/axgbe_phy_impl.c
@@ -2520,6 +2520,8 @@ static void axgbe_phy_stop(struct axgbe_port *pdata)
 	pdata->i2c_if.i2c_stop(pdata);
 }
 
+#define AXGBE_SFP_I2C_SETTLE_DELAY_US	2000
+
 static int axgbe_phy_start(struct axgbe_port *pdata)
 {
 	struct axgbe_phy_data *phy_data = pdata->phy_data;
@@ -2536,9 +2538,16 @@ static int axgbe_phy_start(struct axgbe_port *pdata)
 	/* Reset CDR support */
 	axgbe_phy_cdr_track(pdata);
 
-	/* After starting the I2C controller, we can check for an SFP */
+	/*
+	 * After starting the I2C controller, we can check for an SFP. The
+	 * cage's GPIO expander/mux may not yet be ready to respond to the
+	 * very first access, so give it a short settle delay before the
+	 * first probe instead of failing and leaving recovery to a later
+	 * poll.
+	 */
 	switch (phy_data->port_mode) {
 	case AXGBE_PORT_MODE_SFP:
+		rte_delay_us_sleep(AXGBE_SFP_I2C_SETTLE_DELAY_US);
 		axgbe_phy_sfp_detect(pdata);
 		break;
 	default:
-- 
2.43.0

