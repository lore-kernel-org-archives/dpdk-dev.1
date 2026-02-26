Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FC52FCE086
	for <dpdk-dev@archiver.kernel.org>; Thu, 26 Feb 2026 13:57:43 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 5D4254026F;
	Thu, 26 Feb 2026 14:57:42 +0100 (CET)
Received: from GVXPR05CU001.outbound.protection.outlook.com
 (mail-swedencentralazon11013019.outbound.protection.outlook.com
 [52.101.83.19]) by mails.dpdk.org (Postfix) with ESMTP id 06A374021F
 for <dev@dpdk.org>; Thu, 26 Feb 2026 14:57:40 +0100 (CET)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=r41EtdJ29etH/ASgpbslt8Onkc9UkzeRIF5DR9OC+fur4cawH571yb5pAISbhmS75YgQ8rQXm5ksc0gO532UM1/dOYg+YOP3EpJW3VfiP1DqBgAxePRYYJYSYQAhFEqRisedo2olsLOhl6UX11NZKxX9TsfPI/vAQaaQ/T5x6rThj8GqCpb6RCm/WX3uIJxZx18SjOMcu7pAQHliGRO6F5zYPjKKJvqk5IJ+KbuKLC/Je7TNITf0qfkxTqBzk+KKvffiz5YURtcDH3sANmo8ZXdtL3sTYEveb2X2OslCR/aEhU9GbTE8trK9vcB0YKqGVY1TLbEpcl7XQjPzdE3BJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gsG7V6CT/z0xtsU2gLkz43tNf7E4SPJvmBTdxNYK70c=;
 b=AN0ZdaJjuomDv7cCVm7xgRuRTy5G4OjviH9LEsud8JPrF+kJtRFWXjTJJANOarJKy09++7KydQ3sAQI2x5fb6PC5jqSMWGAftDfwEC3KF1SE4BzmB2grsCqoPbQ038f2NRNEQVm8FrU1xP9bAm1X9xqGvA+mV0GOFpTIYb0CkttpzOrmPuPf9yyHBT8MSs/hPTYqSg2YYgvHDIuvMiEOflbCeY3b3HPfWFFByCHFjMbzPpNSd3BNV3DVTjw+vMCO+IqQz8VYiqaSXRY5JwKatb2mfpw+N42kfXsmgJT018VDZuKH8H0xSJDSu0KMpuxPIOvsIV1PZgGUFouu+pqPew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 192.176.1.74) smtp.rcpttodomain=dpdk.org smtp.mailfrom=ericsson.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=ericsson.com; 
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ericsson.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gsG7V6CT/z0xtsU2gLkz43tNf7E4SPJvmBTdxNYK70c=;
 b=T0szxeM3xPF6tz8t8jS+c2GF/7j7hBQBmgpr/r3pOi7sY16owexNVd13ntn9DPDHriDy7ywgcGveJn6BbWvy+TWemWGvokHZHmh8CeJOpotzVNU91n5Rzn3nQK5BVvS2xXdQMojXvKjfYyCExOW+H5lB197AbDznILARRKnHHr6wWD84cUTB7HLiTXwM9rUnZmvYYUrNS1/qx6E2LJvNxfPWjJ+pxMHmgDrMA2BoH+coKbM2UrAENXS1RW2bSfN2GOSJ7hLFSDKVMlwC2rbas8wkRKku12Lkqsb54f7oc70l7xuJAoqAobYF8O0pmI/0SIH+1OEChv1jVAk8MAYi/A==
Received: from DUZPR01CA0056.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:469::7) by AM7PR07MB6263.eurprd07.prod.outlook.com
 (2603:10a6:20b:138::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9654.13; Thu, 26 Feb
 2026 13:57:38 +0000
Received: from DU6PEPF0000A7E2.eurprd02.prod.outlook.com
 (2603:10a6:10:469:cafe::16) by DUZPR01CA0056.outlook.office365.com
 (2603:10a6:10:469::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9632.26 via Frontend Transport; Thu,
 26 Feb 2026 13:57:34 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 192.176.1.74)
 smtp.mailfrom=ericsson.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=ericsson.com;
Received-SPF: Pass (protection.outlook.com: domain of ericsson.com designates
 192.176.1.74 as permitted sender)
 receiver=protection.outlook.com; 
 client-ip=192.176.1.74; helo=oa.msg.ericsson.com; pr=C
Received: from oa.msg.ericsson.com (192.176.1.74) by
 DU6PEPF0000A7E2.mail.protection.outlook.com (10.167.8.42) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9632.12 via Frontend Transport; Thu, 26 Feb 2026 13:57:37 +0000
Received: from seliius19819.seli.gic.ericsson.se (153.88.142.248) by
 smtp-central.internal.ericsson.com (100.87.178.65) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 26 Feb 2026 14:57:37 +0100
Received: from seliiuts03667.seli.gic.ericsson.se
 (seliiuts03667.seli.gic.ericsson.se [100.77.109.197])
 by seliius19819.seli.gic.ericsson.se (Postfix) with ESMTP id 1C15A4020B7E;
 Thu, 26 Feb 2026 14:57:37 +0100 (CET)
Received: by seliiuts03667.seli.gic.ericsson.se (Postfix, from userid 125215)
 id 0702460AE941; Thu, 26 Feb 2026 14:57:37 +0100 (CET)
From: Piotr Krzewinski <piotr.krzewinski@ericsson.com>
To: Akhil Goyal <gakhil@marvell.com>, Fan Zhang <fanzhang.oss@gmail.com>,
 Anatoly Burakov <anatoly.burakov@intel.com>
CC: <dev@dpdk.org>, Piotr Krzewinski <piotr.krzewinski@ericsson.com>
Subject: [PATCH] cryptodev: fix memory corruption in secondary process
Date: Thu, 26 Feb 2026 14:57:27 +0100
Message-ID: <20260226135727.4171394-1-piotr.krzewinski@ericsson.com>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU6PEPF0000A7E2:EE_|AM7PR07MB6263:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b76a80d-c585-42c2-7297-08de753f002f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|36860700013|82310400026|1800799024; 
X-Microsoft-Antispam-Message-Info: azqo9Nht7tya+LXdEcw/5RcFmhX1KPmIOoQGCw4o0aB2cV6vMko6fyLcDcRisTYAnKMtaCeZIe4wS8LGh2nOa3cGsc5KNxrFmYG+WtykY1WQdDY4AFhtDd37NTzDQh1Eeuyq98zGSXNK+tj/sjTYaQqfBBopUSVFK+IQWbzDFoEvO4pFxn7RavEylaqwNE/nxcHyyQ2zkWusBOaQPaan3d+DnoqI84YLCwVEf77nm5SEy+Jx2h6VYmSIH0HZv7jlsMqZ+P6C83/mX3DSmTfvaOo4SrY31L0h7ngcNvU2qFLkM3sdm7nabcsAfFchaFFy8OnTRl6j2aPPE3E0znhqxB2o2njssPXf9FLiz/nPOFqnz1ABP/j3NBlzvYcMuBhBqCGYmMJOFopIf+BaqFGEAgxvms/ET6BSXPTgqrkAOPmsK+zosugg1MwXjjzStAnUsQ4KeMXAodlZsZB0/W3vP1Agww4uqrNyducVt1M2KI9hmAbNOpV4Pyu1ufM50r+XCmnk4lbTu9oNYxc3zS7i4dvcZA0z3+6VF2wED5MssqD4wA9mOkaOX6RUsWXrx8EHV63nYjDidu7q+LBD6Z99qc/KWkWfopFndQZaEl6kLhE1GdL73oGNk0hjlhh3w5dq5LRobkcfpVuOLuPcFUQJlKOnNVi1NtFKwVlUFDtGnYOx+riH01Kv5doZovdzofmtVIbnK2Cobooku1bRAPrKm33RBl2RtBm7aGUIEe8w8U0k4b5JQXhZEhggCzBnaT1o6lTmlU+mxQwOMw6bCAKNrZ/kDow0pBdaS6syHCL2bEsCpR9IAZTwi9chcBWx/MS0eRCC9M/hGWXX0M6iObop0A==
X-Forefront-Antispam-Report: CIP:192.176.1.74; CTRY:SE; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:oa.msg.ericsson.com; PTR:office365.se.ericsson.net;
 CAT:NONE; SFS:(13230040)(376014)(36860700013)(82310400026)(1800799024);
 DIR:OUT; SFP:1101; 
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 41jDorbPKf7Qeb1VoU5HecsVju8JeoTBWMGxozPgan3PxqVqdRfwHoAFLyowCBzuvdfgabGMLjnD62ZNih+I6A7kHbwnAsJ0vlYKKMYneUkQhWs9MM6xZOguuDR0gV/bIKhZTirQyhMnJ4y1oOVIeyE6lX18FaxPXCcglv+5rvo62/tvBhl/4T7WwxfRBksi5QjtM4S8wjF0r+rWMMSbhL2SfgY47P6AIhoaHuXN5D2MCLN+x27pqkaraK1zQiAWJUqQW3sya98R2e8lXFT6JUdqdRcvbmc1Jxyam8l8Gy80e9K6mfF3eEV4W/E3ApgGfXtEPKWsFTg5hzXDWczdIi3i48Bqjpwrbom5OWvEbSBw/qcu12aflAFhh+Px0dnBrBAOe7Yv550X8+T9Bt+6WQxmSF1fS9yhWlfA2tfBnidglW+BYR9UFRM4OG+x0TOJ
X-OriginatorOrg: ericsson.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2026 13:57:37.8937 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b76a80d-c585-42c2-7297-08de753f002f
X-MS-Exchange-CrossTenant-Id: 92e84ceb-fbfd-47ab-be52-080c6b87953f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=92e84ceb-fbfd-47ab-be52-080c6b87953f; Ip=[192.176.1.74];
 Helo=[oa.msg.ericsson.com]
X-MS-Exchange-CrossTenant-AuthSource: DU6PEPF0000A7E2.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM7PR07MB6263
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

When secondary process runs with --no-pci, it skips hardware device
probing, causing different cryptodev dev_id assignments than in primary.
Since memzone lookup is based on dev_id, it leads to secondary
attaching to wrong memzone and corrupting primary's device
data structures.

Fix by making secondary process search for devices by name in existing
memzones instead of using local dev_id allocation.

Signed-off-by: Piotr Krzewinski <piotr.krzewinski@ericsson.com>
---
 lib/cryptodev/rte_cryptodev.c | 37 +++++++++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 4 deletions(-)

diff --git a/lib/cryptodev/rte_cryptodev.c b/lib/cryptodev/rte_cryptodev.c
index 7bddb154c2..50071935c2 100644
--- a/lib/cryptodev/rte_cryptodev.c
+++ b/lib/cryptodev/rte_cryptodev.c
@@ -1177,6 +1177,27 @@ rte_cryptodev_find_free_device_index(void)
 	return RTE_CRYPTO_MAX_DEVS;
 }
 
+static uint8_t
+rte_cryptodev_find_device_by_name(const char *name)
+{
+	char mz_name[RTE_MEMZONE_NAMESIZE];
+	const struct rte_memzone *mz;
+	struct rte_cryptodev_data *data;
+	uint8_t dev_id;
+
+	for (dev_id = 0; dev_id < RTE_CRYPTO_MAX_DEVS; dev_id++) {
+		snprintf(mz_name, sizeof(mz_name), "rte_cryptodev_data_%u", dev_id);
+		mz = rte_memzone_lookup(mz_name);
+		if (mz == NULL)
+			continue;
+
+		data = mz->addr;
+		if (strncmp(data->name, name, RTE_CRYPTODEV_NAME_MAX_LEN) == 0)
+			return dev_id;
+	}
+	return RTE_CRYPTO_MAX_DEVS;
+}
+
 RTE_EXPORT_INTERNAL_SYMBOL(rte_cryptodev_pmd_allocate)
 struct rte_cryptodev *
 rte_cryptodev_pmd_allocate(const char *name, int socket_id)
@@ -1190,10 +1211,18 @@ rte_cryptodev_pmd_allocate(const char *name, int socket_id)
 		return NULL;
 	}
 
-	dev_id = rte_cryptodev_find_free_device_index();
-	if (dev_id == RTE_CRYPTO_MAX_DEVS) {
-		CDEV_LOG_ERR("Reached maximum number of crypto devices");
-		return NULL;
+	if (rte_eal_process_type() == RTE_PROC_SECONDARY) {
+		dev_id = rte_cryptodev_find_device_by_name(name);
+		if (dev_id == RTE_CRYPTO_MAX_DEVS) {
+			CDEV_LOG_ERR("Device %s does not exist in primary process", name);
+			return NULL;
+		}
+	} else {
+		dev_id = rte_cryptodev_find_free_device_index();
+		if (dev_id == RTE_CRYPTO_MAX_DEVS) {
+			CDEV_LOG_ERR("Reached maximum number of crypto devices");
+			return NULL;
+		}
 	}
 
 	cryptodev = rte_cryptodev_pmd_get_dev(dev_id);
-- 
2.34.1

