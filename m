Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E38EC021B2
	for <dpdk-dev@archiver.kernel.org>; Thu, 20 Feb 2025 22:07:17 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id D7D3440E3F;
	Thu, 20 Feb 2025 23:04:50 +0100 (CET)
Received: from egress-ip11b.ess.de.barracuda.com
 (egress-ip11b.ess.de.barracuda.com [18.185.115.215])
 by mails.dpdk.org (Postfix) with ESMTP id 065FE40DF8
 for <dev@dpdk.org>; Thu, 20 Feb 2025 23:04:37 +0100 (CET)
Received: from EUR05-AM6-obe.outbound.protection.outlook.com
 (mail-am6eur05lp2106.outbound.protection.outlook.com [104.47.18.106]) by
 mx-outbound21-132.eu-central-1b.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Thu, 20 Feb 2025 22:04:36 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iprSDf0Hl4Fv1q/uzpnDKX5OrNro+qU6CQ57YJujLjJqc8S93I9pc37Ys0bNnmgnYebbtVTXPYfbQTTaRUpKTKN3ewXou/gAHcd9in82LJ8rwCW64vAAXRkX4b+auMIUmhk7DU14GY3XMQzr0su5Y8llTZLdsINbD/Si6ReZMnXB4lAfKOchA9sNTTYaFjiil7fbWLbYl2WH18BPUhspw0dYORVKmG38mqwW8oWchqM+UMhb86WkPbDHaDhLET7K2/Ae3i5HdgRIjU8DKi1CazJhxexobmkh34/ZPi878LHn39S279GcEpBoHSn48XTIOS3bkjCgTdIBZhsGNFdv1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wYH4zGRgVwh4MuX4A17Yz90VA1ZaU5ZAbtK6ERYg8hY=;
 b=vmETPEof6wniJJhYCeJgy0n6oKhyBph13OuNCgI/vHEZt8FZYZJZZZh4zE6ZJ3+ouAHkmPFXFXtyqu+2QYiBFJweHwbX0qi60LoTwkBrjGZjDrneqlODxbeeJ+VQplFZR6P2MbmyEB3yqEC49zydFKIg6LiS+V8dddRFgcBcygMCY/ssmRZ4R3umYGJbsYYg01eLU+jXUfjYcktT6iEor4lf6jRZDw2NCj6sLj/jV01GmANsx2ACNXhqaXetkyZKYbtUITnhC3DQSj+Easy9Nkfz+jhn+47DEsofGAUQm89zzeqpv0C51mdl/EDpG8N0D3iZ7fTO7n63Jyxk3/+jqQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wYH4zGRgVwh4MuX4A17Yz90VA1ZaU5ZAbtK6ERYg8hY=;
 b=GAFc5Z9n6Ri8hZfTzpGf4OhE7pLeiN6eRak1dXupgcy/aS0FKnJ1xb3zxHifhogHtOtb4Snm135mafYDZ4czXNC3JjvbElVwtWsgAJzv+a/vRGmCaMsPFsht5JeYo1d0Q3PaYiZjZCq9XR6efCTHAXR71dYQnM54Dts87EU2wLE=
Received: from CWLP265CA0495.GBRP265.PROD.OUTLOOK.COM (2603:10a6:400:18b::7)
 by VE1P190MB0909.EURP190.PROD.OUTLOOK.COM (2603:10a6:800:1b0::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8466.15; Thu, 20 Feb
 2025 22:04:33 +0000
Received: from AM3PEPF00009B9C.eurprd04.prod.outlook.com
 (2603:10a6:400:18b:cafe::3d) by CWLP265CA0495.outlook.office365.com
 (2603:10a6:400:18b::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.8466.16 via Frontend Transport; Thu,
 20 Feb 2025 22:04:32 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AM3PEPF00009B9C.mail.protection.outlook.com (10.167.16.21) with Microsoft
 SMTP Server id 15.20.8466.11 via Frontend Transport; Thu, 20 Feb 2025
 22:04:32 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org, Danylo Vodopianov <dvo-plv@napatech.com>
Subject: [PATCH v1 26/32] net/ntnic: add i2cm init
Date: Thu, 20 Feb 2025 23:03:50 +0100
Message-ID: <20250220220406.3925597-27-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250220220406.3925597-1-sil-plv@napatech.com>
References: <20250220220406.3925597-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9C:EE_|VE1P190MB0909:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 0bb122aa-8482-4a44-c6f1-08dd51fa8e45
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|376014|1800799024|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ZBavPFbJtwJCZSLx9BskowbMGyXcHw9mdZOEgtYoHFMDwYzFZRIzI3TVG2Tz?=
 =?us-ascii?Q?3S6qxRVctQtYFtcjN6gPRgnQJkFTeu34sdtr9asKyfMay1dAy2eaNv4b3Lwi?=
 =?us-ascii?Q?zIsuUwzqoe4wPfb3IKpnJ7te0UBLsBTKPml2OC2avKPbZ/05cmZ6Ucj60tIE?=
 =?us-ascii?Q?QV7Vp/GcSoEq9Y/FT2R76Y4CPPp3yhb23bF6oIAmGkH+qKlMI9XJ0f26Eh/L?=
 =?us-ascii?Q?yx1MNbvWYiXQyd80T9MfKe0CzzLoae6nZKK/FBOVmY8ykQLRjnD3LGN/H/uH?=
 =?us-ascii?Q?IndOWxUBVZrHicZOdxT4YrnWzmeLwzxVs8JXAzcx9YUu2Wom39ysHQhqAITs?=
 =?us-ascii?Q?GOC8rXvTdprtjNM+tP97uWGpjshP8tfgDUt4EZTIt8Oz99Kvb7kDHJES+NaQ?=
 =?us-ascii?Q?XFwCDABBlBeBKcPLRSst6fLLFSou8pc4PC7mevsLex6SJ/7fjAYukaPj13t0?=
 =?us-ascii?Q?LllhvLtH3KeVnLS5NdI1xMZd0AZijAMu33Fnbc+TD/BevVZ771z9ta0cziY5?=
 =?us-ascii?Q?8nJ7Ku6c50lMNX3AxPfVb8mEnc9r10B3oEFxZKnt9S84LTYfi5ip/g2qYc+q?=
 =?us-ascii?Q?fM95ELom4+gOEQ+K6BANGet859Aqk4H8mo+pB6f4oLwHNX4KAkOsyGTvPBit?=
 =?us-ascii?Q?AlAzuxkbUnz/cbIdEckArZ1K1fhQjomatIHDoAvgVrU+XruwTUhYyiRYQCdj?=
 =?us-ascii?Q?oa05N68iGSy7EHKLDRdTrcxHAWXBfutDOUDvqZbWFlsj09lfGOG4tUtR5P1O?=
 =?us-ascii?Q?18tar/ro/MqMCMXIaIOW3cBsBDdU0iwReLOdlIoEztqZxLGbXmJ4RLNO2vFG?=
 =?us-ascii?Q?bjXozgVlBGaBr95/JNtI5BeF8Gjtx5v3F7inB+PG1KWkooLJqq/3YApIkiXd?=
 =?us-ascii?Q?rgm4fmXT3CeGZmwpYZvuajuaBI7M3hu0dn+jE65D/E8K9yy0cnzitalCDqeh?=
 =?us-ascii?Q?xA0PnxEzAvtLdez2Ny68khNLpH1zDrPOZIexFaA+gAOR0xf/E2lkpgMk/crx?=
 =?us-ascii?Q?lNfJ991RJyjd5tEgW39rdqoPzUGdx8EnyDG7v9XlmvqerPF+H72C5ikrBwFo?=
 =?us-ascii?Q?im0mPIU2KeXqjiA/qgvlB2Tiu/TYtB67RufPPeUumDwx7RK5QvNScZXhKc/3?=
 =?us-ascii?Q?729Ql55tiIY+WSLemrG9nyUjDO9z68uHyGXupS7RXQwUOD+P5dANip8G6I7f?=
 =?us-ascii?Q?LE09g4bKwFarlzCfsYuOCuOiIGdGkG+Rhzg7VvaMvCF2yHp68uFqWHZg7LP+?=
 =?us-ascii?Q?OOhWV6qgfRV//mRGHcHcz3TJMVM/y9Anf05SG3tXzsL4Yo2i2Jpki1WvSNyL?=
 =?us-ascii?Q?o8EUsi8nwjhB9rbKePC/wA55qBLjRpoZltdaAXEKFNXn0nUBGKZH7IxLIcBB?=
 =?us-ascii?Q?XCLaUTuzkDxbNjILZpjH9IE6Px+uL0Sdw2ga2EcfD9FXID9TRbRWP65gIbWC?=
 =?us-ascii?Q?cdoxlvh88kHW15wSywKIn2mBcE9Q0OusZf/Hi2agnE5ei+ff5GnlflFlheCR?=
 =?us-ascii?Q?mjGNQHhUGohkRKc=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(376014)(1800799024)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: hSIFErYVv895qAcCSP/j6DHcklQsOLGtaj26eJ3AMXQAjMlenHSb5LUdQKtwKORh67LiRzA2Q4742R63/eIJm3VeVSMC51O09U/1EgXNkKUTqm8SbEN/1zlnxz0LvB3Lj1Ym6YgrgYuMd6Gb2q8k9HXavEcEWbbe+uT3P2o0GJ3alRIe4ovKM85jd7/QS5UDSL296kq1OQve1TA3TfbQXy6F1tAKio/qig2W9wX4li8t3iXsrF6lezqRKj84Lb3nWKGPQWVsCgGHKvMjUi7AhARKzFrwjXo2cUKhbWhKUV2FCXUGKIYOLS+k7kuadrim3YIjKjpbvB8ruggWdlfAFPdib25bqC42ob2t716YUPEfLhrmXghiRgetlf4bpJtL8KB9xK6Jh55xrIrTZke4SJgurKrST+sGfT7S26qI5nz8FZRuamFJD8XimCw0s94eeKLGirXruIxi3A8YsvRkgG4hCVzwxnQ82IxJc0SftNjcmG1jAtPzGBVjPnsoEPfgXSuBR1LTwTGHseA0W7qFSsn9WIsgrOQwGZ+DfLfAohRpd/+Q2q8DVIfv1aEHMOVevIH9Yx9PzwZn6Ma+lxe7+3QRAvPQUDHU26gDKGCQ+vB5sdYhZIRqyoRzTQZbD/W3AuQ4/ELsfDuyBiPK3nTGkxnVjfLlpFM2g2PlX3pFspQ=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2025 22:04:32.5996 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 0bb122aa-8482-4a44-c6f1-08dd51fa8e45
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AM3PEPF00009B9C.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1P190MB0909
X-BESS-ID: 1740089076-305508-25334-16467-1
X-BESS-VER: 2019.1_20250219.2339
X-BESS-Apparent-Source-IP: 104.47.18.106
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVqaGJgZAVgZQ0CQxKcXAINXYJN
 nMPCXFMiUxKc080cTQ1NTQ3NDMJCVZqTYWANM5tZFBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.262653 [from 
 cloudscan19-102.eu-central-1b.ess.aws.cudaops.com]
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

Create and initialize I2C for FPGA.

Signed-off-by: Danylo Vodopianov <dvo-plv@napatech.com>
---
 .../net/ntnic/nthw/core/include/nthw_i2cm.h   |  2 +
 .../nt400dxx/reset/nthw_fpga_rst_nt400dxx.c   |  7 ++
 drivers/net/ntnic/nthw/core/nthw_i2cm.c       | 82 +++++++++++++++++++
 3 files changed, 91 insertions(+)

diff --git a/drivers/net/ntnic/nthw/core/include/nthw_i2cm.h b/drivers/net/ntnic/nthw/core/include/nthw_i2cm.h
index 53aa3c018e..1bf780d714 100644
--- a/drivers/net/ntnic/nthw/core/include/nthw_i2cm.h
+++ b/drivers/net/ntnic/nthw/core/include/nthw_i2cm.h
@@ -44,6 +44,8 @@ struct nt_i2cm {
 
 typedef struct nt_i2cm nthw_i2cm_t;
 
+nthw_i2cm_t *nthw_i2cm_new(void);
+int nthw_i2cm_init(nthw_i2cm_t *p, nthw_fpga_t *p_fpga, int n_i2c_instance);
 int nthw_i2cm_read(nthw_i2cm_t *p, uint8_t dev_addr, uint8_t reg_addr, uint8_t *value);
 int nthw_i2cm_write(nthw_i2cm_t *p, uint8_t dev_addr, uint8_t reg_addr, uint8_t value);
 int nthw_i2cm_write16(nthw_i2cm_t *p, uint8_t dev_addr, uint8_t reg_addr, uint16_t value);
diff --git a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
index 73feaa4ebd..bfc66a97d1 100644
--- a/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
+++ b/drivers/net/ntnic/nthw/core/nt400dxx/reset/nthw_fpga_rst_nt400dxx.c
@@ -67,6 +67,13 @@ static int nthw_fpga_rst_nt400dxx_init(struct fpga_info_s *p_fpga_info)
 
 	res = nthw_fpga_avr_probe(p_fpga, 0);
 
+	if (res != 0)
+		return res;
+
+	/* Create I2C */
+	p_fpga_info->mp_nthw_agx.p_i2cm = nthw_i2cm_new();
+	res = nthw_i2cm_init(p_fpga_info->mp_nthw_agx.p_i2cm, p_fpga, 0);
+
 	if (res != 0)
 		return res;
 
diff --git a/drivers/net/ntnic/nthw/core/nthw_i2cm.c b/drivers/net/ntnic/nthw/core/nthw_i2cm.c
index f7500b2e93..353fb3f82a 100644
--- a/drivers/net/ntnic/nthw/core/nthw_i2cm.c
+++ b/drivers/net/ntnic/nthw/core/nthw_i2cm.c
@@ -27,6 +27,88 @@
 #define NUM_RETRIES 50U
 #define SLEEP_USECS 100U/* 0.1 ms */
 
+nthw_i2cm_t *nthw_i2cm_new(void)
+{
+	nthw_i2cm_t *p = malloc(sizeof(nthw_i2cm_t));
+
+	if (p)
+		memset(p, 0, sizeof(nthw_i2cm_t));
+
+	return p;
+}
+
+int nthw_i2cm_init(nthw_i2cm_t *p, nthw_fpga_t *p_fpga, int n_i2c_instance)
+{
+	const char *const p_adapter_id_str = p_fpga->p_fpga_info->mp_adapter_id_str;
+	nthw_module_t *mod = nthw_fpga_query_module(p_fpga, MOD_I2CM, n_i2c_instance);
+
+	if (p == NULL)
+		return mod == NULL ? -1 : 0;
+
+	if (mod == NULL) {
+		NT_LOG(ERR, NTHW, "%s: I2C %d: no such instance", p_adapter_id_str,
+			n_i2c_instance);
+		return -1;
+	}
+
+	p->mp_fpga = p_fpga;
+	p->mn_i2c_instance = n_i2c_instance;
+	p->m_mod_i2cm = mod;
+
+	p->mp_reg_prer_low = nthw_module_get_register(p->m_mod_i2cm, I2CM_PRER_LOW);
+	p->mp_fld_prer_low_prer_low =
+		nthw_register_get_field(p->mp_reg_prer_low, I2CM_PRER_LOW_PRER_LOW);
+
+	p->mp_reg_prer_high = nthw_module_get_register(p->m_mod_i2cm, I2CM_PRER_HIGH);
+	p->mp_fld_prer_high_prer_high =
+		nthw_register_get_field(p->mp_reg_prer_high, I2CM_PRER_HIGH_PRER_HIGH);
+
+	p->mp_reg_ctrl = nthw_module_get_register(p->m_mod_i2cm, I2CM_CTRL);
+	p->mp_fld_ctrl_ien = nthw_register_get_field(p->mp_reg_ctrl, I2CM_CTRL_IEN);
+	p->mp_fld_ctrl_en = nthw_register_get_field(p->mp_reg_ctrl, I2CM_CTRL_EN);
+
+	p->mp_reg_data = nthw_module_get_register(p->m_mod_i2cm, I2CM_DATA);
+	p->mp_fld_data_data = nthw_register_get_field(p->mp_reg_data, I2CM_DATA_DATA);
+
+	p->mp_reg_cmd_status = nthw_module_get_register(p->m_mod_i2cm, I2CM_CMD_STATUS);
+	p->mp_fld_cmd_status_cmd_status =
+		nthw_register_get_field(p->mp_reg_cmd_status, I2CM_CMD_STATUS_CMD_STATUS);
+
+	p->mp_reg_select = nthw_module_get_register(p->m_mod_i2cm, I2CM_SELECT);
+	p->mp_fld_select_select = nthw_register_get_field(p->mp_reg_select, I2CM_SELECT_SELECT);
+
+	p->mp_reg_io_exp = nthw_module_get_register(p->m_mod_i2cm, I2CM_IO_EXP);
+	p->mp_fld_io_exp_rst = nthw_register_get_field(p->mp_reg_io_exp, I2CM_IO_EXP_RST);
+	p->mp_fld_io_exp_int_b = nthw_register_get_field(p->mp_reg_io_exp, I2CM_IO_EXP_INT_B);
+
+	nthw_field_get_updated(p->mp_fld_io_exp_rst);
+	nthw_field_set_val_flush32(p->mp_fld_io_exp_rst, 1);
+	nthw_field_set_val_flush32(p->mp_fld_io_exp_rst, 0);
+
+	/* disable interrupt and core */
+	nthw_field_get_updated(p->mp_fld_ctrl_ien);
+	nthw_field_set_val_flush32(p->mp_fld_ctrl_ien, 0);
+	nthw_field_get_updated(p->mp_fld_ctrl_en);
+	nthw_field_set_val_flush32(p->mp_fld_ctrl_en, 0);
+
+	nthw_field_set_val_flush32(p->mp_fld_prer_high_prer_high, 0);
+	nthw_field_set_val_flush32(p->mp_fld_prer_low_prer_low, 225);
+
+	/* Enable interrupt and core */
+	nthw_field_set_val_flush32(p->mp_fld_ctrl_ien, 1);
+	nthw_field_set_val_flush32(p->mp_fld_ctrl_en, 1);
+
+	nthw_field_set_val_flush32(p->mp_fld_cmd_status_cmd_status,
+		NT_I2C_CMD_STOP | NT_I2C_CMD_NACK);
+
+	NT_LOG(INF, NTHW, "%s: %s  init done", p_adapter_id_str, __PRETTY_FUNCTION__);
+	nt_os_wait_usec(10000);
+
+	/* Initialize mutex */
+	rte_spinlock_init(&p->i2cmmutex);
+
+	return 0;
+}
 
 static bool nthw_i2cm_ready(nthw_i2cm_t *p, bool wait_for_ack)
 {
-- 
2.45.0

