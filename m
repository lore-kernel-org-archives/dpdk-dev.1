Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FED0C021B3
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:05:03 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id A5D804069D;
	Thu, 20 Feb 2025 23:04:25 +0100 (CET)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id B9C67406BA
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:20 +0100 (CET)
Received: from EUR02-AM0-obe.outbound.protection.outlook.com
 (mail-am0eur02lp2235.outbound.protection.outlook.com [104.47.11.235]) by
 mx-outbound46-229.eu-central-1c.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:20 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FgPRJU7l7qvWmcFAel3QE+hPj0VnOnzvMnnGVgTfJmqIZ36g8GuhXrvoNTACRhgdAvbLNutRO3Uhwaug/G4T6SjfZBZMTYkSZLcouoQEX+Z4JMrBuCboMSysc2FBXoQPpapw+h3DRRHFOEWsda+ZuaO24UezgF/SAad8tLkojCrPkfrCTgm8spM2XKjxYk403WHV/e4/FyXDswRZjnKoXJfEEEwubCGeVBMsAlns85uuSgHfvhI/oR9mzBulUVTDyJlTSTG6Jh3SuJT2IJ33065NcLO3M1XOrJD+ktpIdF4A107qCMqP13W7bO5R74apGM4xw9xlpOiCr5Qvth3Prw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0T9MK38mJVcYc1jJyAKrKFhu60YqxR0FhVJAZt2V6b4=;
 b=KlwlGaXq/1FcLl4DsCDS8c2ivkOFyqLzHfN+4zy5V3WfZixATD2NhsQuDG7CRuO5vd9ChhhmO/qGOcLcmznb7mmNszOiu+OJkr9wIk2JPIBa6j1nFtOsHIUgL7hoiQfM9s6sW27I2EjAmqSgIztt+6SDCcvExLoff8g657bXsWEmBPPf1WoaJqdPHHYfyLxejXqQM/fFE6CUg54Ma4qJHyazYDcR9OHmK3KeN/1k215t1iBMhQ1O0kmGdO6YI4YulTI93uHy3y69zRI/0ssjpTwwaroF+Pv9ULPvyWPVSpb95uhrsYm+nkU6p4AmM/AWnbzUL/ITPYOil8gTk3V1dQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0T9MK38mJVcYc1jJyAKrKFhu60YqxR0FhVJAZt2V6b4=;
 b=ZdAEVkzE0nYz2W0VP9ZplFpKO5c8Hdb/VvDyhOzo8JFWcwzZcopmX7Sla/XqJw8Tez3MnRvAS5P6EuFiIeXPvegATDrsl7GbpX7DuQVSaT/p7yT0agi5JtQeGGN5GTYXfSFOD6reg1Iz09TBDny4Gdj395iMwipr0rxLwVK5uzM=
Received: from CWLP265CA0501.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::22)
 by AS8P190MB1045.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:2b7::11)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.17; Thu, 20 Feb
 2025 22:04:18 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::73) by CWLP265CA0501.outlook.office365.com
 (2603:10a6:400:18b::22) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 22:04:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:18 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 09/32] net/ntnic: add nim low power API
Date: Thu, 20 Feb 2025 23:03:33 +0100
Message-ID: <20250220220406.3925597-10-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|AS8P190MB1045:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: bf0dcc5e-c331-4c2e-ad4a-08dd51fa85d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|376014|82310400026|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?yd96/SsnKv60Jmpbm7Nr3ldYAWbvHfJQ4yaLJUCFSW9RLq5HAJzM6TEoCbym?=
 =?us-ascii?Q?bJWsY+jX1iAvFxtm8TolcFlmlZ8AE4jujQeAXkr5zgcH/iOAUYXvxfnlbWfg?=
 =?us-ascii?Q?IC72JvDBPOlsluB7kXeyKqsnUZLuKUqtGGIShNnodljVvzQggCvuREo0uVfc?=
 =?us-ascii?Q?0zYDEsBOkjVLbsLIxjl2KWjYKvWaXSx9Xv9YF1wVgb1UBPNsTPFK2aZ2Bp+l?=
 =?us-ascii?Q?7ycmuiGv/QSs8liqb9lBXzKY/UunuIJu+pzyDHDKbx9fiWIzZjpBRk4yngd7?=
 =?us-ascii?Q?J5jYmH8tSYRqZkSFbtokqNL9+0Jyhnnufn2JbJb5OMPmyp1AxgknSVl+8ZLC?=
 =?us-ascii?Q?FCkKSmR+gUnmsOCJdKSqQTUycbc4MPbLeyNX0ymEJH/VJMYoNYV5Ikx3bc7D?=
 =?us-ascii?Q?865C4MhcqKfWExN8Wm5OAVDvtHXCQVteyz91EjDktnQtJG3K9wXuO0R3QX7b?=
 =?us-ascii?Q?sI/dginYoa3oIg7VSbNLHaOPr3Zdpyao4UVysSlfREkM9s6gKpQOwkFsO3BY?=
 =?us-ascii?Q?RcF7VHJHBVcqSUWVnAYhqSgLrnM+dyiiq7sIooROCgftMEm4N54Rt4AyKZ5R?=
 =?us-ascii?Q?5bpUqxlUA/K+t1QLymelX2ca0UH0mmOH0ETmxiwdul+eE+Rg5xK3jSsUw5Iq?=
 =?us-ascii?Q?mire/zTiTYWiuOAOQKczEHtnIMD/KAfYXIXEG23/std8Dt1Zt+BMNCze0DeE?=
 =?us-ascii?Q?7782kbV5Gf3oucsGOWx2vKXPj/wvaLZJTWxmKyB60hBjRYBXBGGlUp3qVcPI?=
 =?us-ascii?Q?Qe2DYoE+BRedTp2ptwQlcqYt3eMPN/6jUKrZXlG866adVvQdmYbs99pMDFmL?=
 =?us-ascii?Q?KWFdvvQSKSrLnXvbK4Wd3ORqNFdY7s6ZOe8epulEytboeGblS0lrLCriPGog?=
 =?us-ascii?Q?wBDKG/iPOWLvgSQRE8hCJGYHmrjv71DtCMfFjZ+e652sjBntwnjMCDGbNC40?=
 =?us-ascii?Q?JmE48sK4ZDZUWFusQHZXVCSXLjn4kIiQCeXOsA26w7t4hO4HCSDYIoL/+kp8?=
 =?us-ascii?Q?5xAwA2Vd7ubmfGCxeg1fRqmSDdqBPXPZn2IAY5kqxX+moVfQxQwk9FtCWsJ5?=
 =?us-ascii?Q?DxiqcDMg8Jfu6lCtWHM5dTH6mezYaNtMDynKNQZlNUCrQw9JE3u8/dOOk8GT?=
 =?us-ascii?Q?EIK8aezqDocMec9InjTLW/YUn++6GfE0QAhVyiCBC47h40ylAm334ZF8ef8v?=
 =?us-ascii?Q?CMFPyxj7BLE+iewlJoyAvvoqPJ14u9qiOuaVp88CqIlDs/SjA8QsThOdKOA1?=
 =?us-ascii?Q?akVtE7TFbkf9UjMpDBapNAf3hjmLE+Ow2HHbXF9bjPws/ADhZqp5wv6LwozA?=
 =?us-ascii?Q?ZFExhEtIFXLI3BwY6OMaFJCe5LeuZi3dqkRWj0FCHbN83n2lPwhmMn7VviGn?=
 =?us-ascii?Q?hTYDA1zlZikZxsamuTEs8DXOQhA7kc98W/qmsiTGzg4AnCtmvtXHNCjSB5Gs?=
 =?us-ascii?Q?NVW3yStUDudUBhoqZyN6gN+MENo8Qq4VMjJd1TUa++QtzW14qMe2+IbvtBUF?=
 =?us-ascii?Q?4Gm1Lm6hMY9VCM4=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(376014)(82310400026)(1800799024)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 1/cBtsVfRNAgLwScFxYvMN/93y2pjDdD4tyonciDS8NsbZmxKoV9Tev9gs10pB/kMl8e425rAR2jD+bbrb2MGrUOtcfjVan8C8ecA9+yk1GbPFIwiu2TBN8MKKlTC3DuCCtpccoV2TVX9NkV3Uscpk8QAnG/3kbOA4LlJRYynSFUYvE3v4Y75CWA8HFJywrrdC+aCfCR3NjHHmCx0hIyko2z4y/2zdeuCd5/LpuFGILN0AkYBbeto1cI6Am6V8BQs7h3YRA8nXs+Esv23F83jlm1w2S9xvzJxK1wnv7IZNL2rPG4hrBbJp0kEUmNJWNZ6H4jbmo3m1KbgyogjTWu2/snlD1Y8smjDpgJrc+CLk54Iwxev6KJcsWJskILUm7aioz878mmpu3CYvpWYknfqebKRni8RdD1RBU1gHiGVLo5ibK+cCnX72bkIMaq4W9agZ0J5ajxYTH6jF9R4FiTA1TiQ4H/SlWgE3ANGQu5eadumlw4cu1ROa4dLPmxQohoIMaQdOfd2XIP1Pyic572nYppnIdxAdkxlIsRVuGyPE59x1XNFL4rtRQKBJYQ0TldYij2rwfjf0oJCjwBfv0Ataed6rnhFp1VouLWALKqJbxKzGoDYfxOMXVYtcmtOAxEwMU4s56gXad5//HDvqnsiCK8xT8gGxq5w3GUPFqy6Og=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:18.4275 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bf0dcc5e-c331-4c2e-ad4a-08dd51fa85d5
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8P190MB1045
X-BESS-ID: 1740089059-312005-29067-14088-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.11.235
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqaGpgZAVgZQ0BLINDJJTk0yTU
 k0NzMwTzFPMk41NrI0M0g2MTYyTVWqjQUA5qp5ZUEAAAA=
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262653 [from 
 cloudscan21-197.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
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

From: Danylo Vodopianov <dvo-plv@napatech.com>

Add NIM reset and low power functions with presence check

- Implement nim_set_reset function to handle NIM reset.
- Implement set_nim_low_power function to manage
NIM power state.
- Add code to check NIM presence before performing reset.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../link_agx_100g/nt4ga_agx_link_100g.c       | 53 +++++++++++++++++++
 .../ntnic/nthw/core/include/nthw_pcal6416a.h  |  1 +
 drivers/net/ntnic/nthw/core/nthw_pcal6416a.c  | 39 ++++++++++++++
 3 files changed, 93 insertions(+)

diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index fe2acef612..9193f21f6f 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -201,6 +201,17 @@ static int phy_set_line_loopback(adapter_info_t *drv, int port, loopback_line_t
  * Nim handling
  */
 
+static void nim_set_reset(struct nim_i2c_ctx *ctx, uint8_t nim_idx, bool reset)
+{
+	nthw_pcal6416a_t *p = ctx->hwagx.p_io_nim;
+
+	if (nim_idx == 0)
+		nthw_pcal6416a_write(p, 0, reset ? 0 : 1);
+
+	else if (nim_idx == 1)
+		nthw_pcal6416a_write(p, 4, reset ? 0 : 1);
+}
+
 static bool nim_is_present(nim_i2c_ctx_p ctx, uint8_t nim_idx)
 {
 	assert(nim_idx < NUM_ADAPTER_PORTS_MAX);
@@ -217,6 +228,20 @@ static bool nim_is_present(nim_i2c_ctx_p ctx, uint8_t nim_idx)
 	return data == 0;
 }
 
+static void set_nim_low_power(nim_i2c_ctx_p ctx, uint8_t nim_idx, bool low_power)
+{
+	nthw_pcal6416a_t *p = ctx->hwagx.p_io_nim;
+
+	if (nim_idx == 0) {
+		/* De-asserting LP mode pin 1 */
+		nthw_pcal6416a_write(p, 1, low_power ? 1 : 0);
+
+	} else if (nim_idx == 1) {
+		/* De-asserting LP mode pin 5 */
+		nthw_pcal6416a_write(p, 5, low_power ? 1 : 0);
+	}
+}
+
 /*
  * Utility functions
  */
@@ -335,6 +360,25 @@ static int create_nim(adapter_info_t *drv, int port, bool enable)
 		phy_reset_tx(drv, port);
 	}
 
+	/*
+	 * Check NIM is present before doing reset.
+	 */
+
+	if (!nim_is_present(nim_ctx, port)) {
+		NT_LOG(DBG, NTNIC, "%s: NIM module is no longer absent!",
+			drv->mp_port_id_str[port]);
+		return -1;
+	}
+
+	/*
+	 * Reset NIM
+	 */
+
+	NT_LOG(DBG, NTNIC, "%s: Performing NIM reset", drv->mp_port_id_str[port]);
+	nim_set_reset(nim_ctx, (uint8_t)port, true);
+	nt_os_wait_usec(100000);/*  pause 0.1s */
+	nim_set_reset(nim_ctx, (uint8_t)port, false);
+
 	/*
 	 * Wait a little after a module has been inserted before trying to access I2C
 	 * data, otherwise the module will not respond correctly.
@@ -369,6 +413,15 @@ static int create_nim(adapter_info_t *drv, int port, bool enable)
 		return -1;
 	}
 
+	if (enable) {
+		NT_LOG(DBG, NTNIC, "%s: De-asserting low power", drv->mp_port_id_str[port]);
+		set_nim_low_power(nim_ctx, port, false);
+
+	} else {
+		NT_LOG(DBG, NTNIC, "%s: Asserting low power", drv->mp_port_id_str[port]);
+		set_nim_low_power(nim_ctx, port, true);
+	}
+
 	return res;
 }
 
diff --git a/drivers/net/ntnic/nthw/core/include/nthw_pcal6416a.h b/drivers/net/ntnic/nthw/core/include/nthw_pcal6416a.h
index 5ef14a0bc9..a718b59a29 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_pcal6416a.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_pcal6416a.h
@@ -24,6 +24,7 @@ struct nthw_pcal6416a {
 
 typedef struct nthw_pcal6416a nthw_pcal6416a_t;
 
+void nthw_pcal6416a_write(nthw_pcal6416a_t *p, uint8_t pin, uint8_t value);
 void nthw_pcal6416a_read(nthw_pcal6416a_t *p, uint8_t pin, uint8_t *value);
 
 #endif	/* __NTHW_PCAL6416A_H__ */
diff --git a/drivers/net/ntnic/nthw/core/nthw_pcal6416a.c b/drivers/net/ntnic/nthw/core/nthw_pcal6416a.c
index 37b6e7ec57..dd803ac66d 100644
--- a/drivers/net/ntnic/nthw/core/nthw_pcal6416a.c
+++ b/drivers/net/ntnic/nthw/core/nthw_pcal6416a.c
@@ -13,11 +13,50 @@
 #include "nthw_pcal6416a.h"
 
 static const uint8_t read_port[2] = { 0x00, 0x01 };
+static const uint8_t write_port[2] = { 0x02, 0x03 };
+static const uint8_t config_port[2] = { 0x06, 0x07 };
 
 /*
  * PCAL6416A I/O expander class
  */
 
+void nthw_pcal6416a_write(nthw_pcal6416a_t *p, uint8_t pin, uint8_t value)
+{
+	uint8_t port;
+	uint8_t data;
+
+	rte_spinlock_lock(&p->mp_nt_i2cm->i2cmmutex);
+	nthw_pca9849_set_channel(p->mp_ca9849, p->m_mux_channel);
+
+	if (pin < 8) {
+		port = 0;
+
+	} else {
+		port = 1;
+		pin = (uint8_t)(pin - 8);
+	}
+
+	nthw_i2cm_read(p->mp_nt_i2cm, p->m_dev_address, write_port[port], &data);
+
+	if (value == 0)
+		data = (uint8_t)(data & (~(uint8_t)(1 << pin)));
+
+	else
+		data = (uint8_t)(data | (1 << pin));
+
+	nthw_i2cm_write(p->mp_nt_i2cm, p->m_dev_address, write_port[port], data);
+
+	/* Enable pin as output pin when writing to it first time */
+	data = (uint8_t)(p->m_config_data[port] & (~(uint8_t)(1 << pin)));
+
+	if (data != p->m_config_data[port]) {
+		nthw_i2cm_write(p->mp_nt_i2cm, p->m_dev_address, config_port[port], data);
+		p->m_config_data[port] = data;
+	}
+
+	rte_spinlock_unlock(&p->mp_nt_i2cm->i2cmmutex);
+}
+
 void nthw_pcal6416a_read(nthw_pcal6416a_t *p, uint8_t pin, uint8_t *value)
 {
 	uint8_t port;
-- 
2.45.0

