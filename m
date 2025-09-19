Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07077CAC59A
	for <dpdk-dev@archiver.kernel.org>; Fri, 19 Sep 2025 09:22:15 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 8422540DF5;
	Fri, 19 Sep 2025 11:20:36 +0200 (CEST)
Received: from egress-ip42b.ess.de.barracuda.com
 (egress-ip42b.ess.de.barracuda.com [18.185.115.246])
 by mails.dpdk.org (Postfix) with ESMTP id 447E440A71
 for <dev@dpdk.org>; Fri, 19 Sep 2025 11:20:27 +0200 (CEST)
Received: from OSPPR02CU001.outbound.protection.outlook.com
 (mail-norwayeastazon11023135.outbound.protection.outlook.com
 [40.107.159.135]) by mx-outbound16-38.eu-central-1b.ess.aws.cudaops.com
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Fri, 19 Sep 2025 09:20:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gn1bv8zKsXFlSeiIoPltTPgbbe2qhDy5uu1XHjLVGJ7/Lv83nHrE/UrwwviibgrgE86Q1hBHhZM2Q90ddjlsJxRXMdKM8A1RVGLf7gWJM0PGibm6mVRDixkBZm2H3pqmzU8VsQoBzF34LqYQpOO6cdgolSp6eEm9C8Zc7zmPXlUY3UVLC5WWUUavn0hv+7dCB1oSI+MFcbJGhlIzd5EDyzUinCR6qO53ThpVwOXkB7oj0ygPjTSD2zRvx9/ii5ZvAbGzGhAjx2eWjUkPpaEN6vR3qHaAcbCChrjoCKXEcQRetZYURVhCaGbfbxlv2eNLwZj9o5rdGykqqJpQ2KuCEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEeo1+Y3gTDiU7p7qosYgVJ96utSoAHRuueLVqeMh3Y=;
 b=slHGFKeaLwC4tHTD8k4pQRDkFtRzmxqeyJJzZ+7RxrwEsgz08ft+9AmxzVnqGngsBq0poJQWsEszcP8zmbIwjWzr7lci1sK6f7RZwmotao9Z1wgAydsj5PuatS9Ak6YoteF52jurxiv6py4bOwRvH8dtES3feTs1QR4UlowdKm1fYEki2OOfE9PhmDDxcTPd3YlImqFFKRAvPquSo5Jkp2zMqgG4nDIOEGTHf9WuNp3jv4XjlJF/S9qGCtTJf2bQLeXMZzCqu4JN1REuQK9QsMZDB+2f8FLjeXNZzEfXkGVp+fP18Rl2AMrcev2cqZPnYJzCeurlim069cHRd2QFuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEeo1+Y3gTDiU7p7qosYgVJ96utSoAHRuueLVqeMh3Y=;
 b=IQvRalyNQmv+Cwh2lwODe0JT6i2EuruXwQ4z9wBYba8JgABiIt1jYVw9BhXeP+hVHK4znRKZ0cVfhumQ+uE8zkD5KiWfY3k7xX/sIBR3blnv911fA1XhG+P5e4aJ0bFbB+Hmp6vudI0VFRmgdqlELTgxPD3ZEwxNOQUcfuxicMI=
Received: from DU2PR04CA0348.eurprd04.prod.outlook.com (2603:10a6:10:2b4::9)
 by DBAP190MB0807.EURP190.PROD.OUTLOOK.COM (2603:10a6:10:1a9::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9137.13; Fri, 19 Sep
 2025 09:20:24 +0000
Received: from DU2PEPF00028D0E.eurprd03.prod.outlook.com
 (2603:10a6:10:2b4:cafe::9a) by DU2PR04CA0348.outlook.office365.com
 (2603:10a6:10:2b4::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9137.14 via Frontend Transport; Fri,
 19 Sep 2025 09:20:24 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 DU2PEPF00028D0E.mail.protection.outlook.com (10.167.242.22) with Microsoft
 SMTP Server id 15.20.9137.12 via Frontend Transport; Fri, 19 Sep 2025
 09:20:24 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 15/16] net/ntnic: rename nim agx setup function
Date: Fri, 19 Sep 2025 11:15:00 +0200
Message-ID: <20250919091504.1548351-16-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20250919091504.1548351-1-sil-plv@napatech.com>
References: <20250919091504.1548351-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D0E:EE_|DBAP190MB0807:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3cd70701-f66d-47cd-b136-08ddf75dc3b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|82310400026|376014|1800799024|36860700013; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?TYqThOXxlfa+RJmMV+OYPkmLls2z7irRKWOCE6ZHbD9urG4GQMp+GMT6SHSw?=
 =?us-ascii?Q?Jdpdrd/xogl5vwYf+bOdtA5p9tebfnm9WNbNZZDoAbKwC79fjn6dimzpPr97?=
 =?us-ascii?Q?LktY3j/y5dFwamfkiu5W3m6a6AQ2xQWsB63GMjzJak5o4moA6GJBlEcI7KUA?=
 =?us-ascii?Q?CvJKFTprlLWRUUWZTfEnTuNMH6YM2GzB8zwy1L/zPRlJL2b0OZFLNCRIuAGI?=
 =?us-ascii?Q?e4mrhlMFHIzWuAFITlhBFj9TdZ7IcWsuvjhSJSYGQyC8/Ged5zkSK071qoHG?=
 =?us-ascii?Q?vh4ySJSctrCo13uDaQgEEt+thlYbYAluhCbyXaankcc07B83lVg1lWKkcTkV?=
 =?us-ascii?Q?O3UglCF3ttRAS4/ek+2kWjCs6kKT0m9bMgSvZ6Hh4/Rl9FZVBRkpM8k1xfMP?=
 =?us-ascii?Q?InexcTNahS3qYYm9/0eYSX8eWKuEygeIb4gQ4c3KmC5bQKbdvORTQAT12xiX?=
 =?us-ascii?Q?nQnaf1kOAQkqmkHj6qKpOglJU59pId9uTMwfY33Zd9DHvupvFy0inJ2+WKCO?=
 =?us-ascii?Q?yUkLkUbC8U0iQqi0jPuMyt8K0Nsc6vcnYZIMK+XkDRJmvgiN/56dmcgtTHRc?=
 =?us-ascii?Q?n717I14Yx/rxo+alvRUjS8Vdg+epg47H1l9ECv8tOfKUZDR3iKQNcU7yjSuH?=
 =?us-ascii?Q?yQjt2ii+MatsPJFWJckrNtNIPagiB45/BNOS5qFwN41fFnjsB40LU0T7uHLE?=
 =?us-ascii?Q?/OpAFcYcQX5/5gV7W14ELKtbCH96C47skHkkTi4iYuafGwJ+5/mkZRh1fbhu?=
 =?us-ascii?Q?CLzxR0wveChv6s+kXb02D0Znv7npiD1J3+I0jome2AZzeC+d2ZtM14NVp9s4?=
 =?us-ascii?Q?GP5tZ16J+hIe52GFYLvYKdf+dWkEt3Cu7IQhi9fQRzyOvQ6uPNMCp5NeQG6m?=
 =?us-ascii?Q?l0jxO1YQGpOjAUjb16mmFRUNEtLUxZPCZSRH4k4of4ZNhrIIVO1opNB0c0ne?=
 =?us-ascii?Q?irX5boh3CWybLeJAnHQHQLqCqLmPJzE9yAr8IGcvKX+7soW2ivq4x5RhLmtH?=
 =?us-ascii?Q?Mm9gGm9QuVGwEnGlBxnBRHH7j7Qr5fkGEha/YDBw5PzIsYoOrRJtSJuRGqvG?=
 =?us-ascii?Q?6/c9cdNcToXY4FREfKW6BR9OcUTHSSDNGxrv8A/IPvtQMuaHrlpkrhjgsU2a?=
 =?us-ascii?Q?O15+m1oKQA3fqtwzYDAmW4O58XhX2RWRjhH4yMxl537r5QX8pFQ1Rj0IcPLm?=
 =?us-ascii?Q?Vj+TfXfU+jcfUWjP5KQCClTSivT+wjI7XUwR+Yi1M2mt04jcaslAQP05ZUpD?=
 =?us-ascii?Q?uJcOcJ1wqZbUU9+CkgdTb/RtFp1g0lsAU+0Yq8zk/FB7g0iRkJus8dVVoT42?=
 =?us-ascii?Q?pPLvqr9qJypr/Q0YyHAX6figqdVNH0Ai42asI0tMiqW9+UAInf6KazRQAeor?=
 =?us-ascii?Q?345Vm0YXRxFIEG8hjoJ5mrhRYJJedG5wnbsPH9XL+DikwDSNiskg7sKjeKJ9?=
 =?us-ascii?Q?0sIe7Tgw7kKA+XJCdbJpIDs7Isi72m0RTQa1g7zJ4ihXomnuJP6RUJCeMx9y?=
 =?us-ascii?Q?WmWKawUUYFIDeM5LeDq75axBA3mRVpw0VeQJ?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(82310400026)(376014)(1800799024)(36860700013);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: oQmOuJG/5ynKNm69vQLWtQBDnBCZdBfiUFZFJ5o1aav/AwHHAsk7Cm/2DFraTY0ovOkUj6fSCYI/IogZ/Eiaybnb0WsAAaLQ/cJO05TUm0oOBcEmD4gFKunuxNEGy51zXN0MtddBz1R2IWorPpYggLzK5gvoStorkTs2ZFwjBLSJlJpLjSgJ1YbF/bNQgZ8RPUDERLK8YDtAGf8G7kjV6MlXIU9o01c7IQ0UqujgyBkY1sCtTDpDEs/8BL6cAtjofp/4bylr3VoIYRtHl6XHwhL/yJCqCyWPW8UIxrY/OOd3CGvSb+5riKqH7NUGvRBmax+5+lvmgeZ5vJC0y/dFyqSllKNNU6+XQMekQzpzC/9EIVtwcRNFs2fXl7yuLT/OXQ18JSEQYSF3FknhLnBHD9oKXUwQseSB8w7pKnYAtSs49AeUWrhY+qMVzQl8craKxY3Ew5dqIzXSEZTcrJGZqnJLqU7ytRolStOfXrfi4ddkjw7ScHH8wNWBLxS7Dvpacah2UOAOfxhdLzr/SjpjafNBjTzwuxkTbDVPIu/8GaVl61HGDsXwn+/l7mUaWC6JNzCjNzxAmrzh1P7UNpyFtC+/ePi7UfJ9i+OJg3J5BSuYjBQq3EWZ6UB9vlsvq2vSwzXM+Lt5EezDhTIOX+68KQ==
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2025 09:20:24.2254 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3cd70701-f66d-47cd-b136-08ddf75dc3b2
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: DU2PEPF00028D0E.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAP190MB0807
X-BESS-ID: 1758273626-304134-7644-1102-1
X-BESS-VER: 2019.1_20250904.2304
X-BESS-Apparent-Source-IP: 40.107.159.135
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYmZuZAVgZQMCk5ySzR0tjc0D
 DFMNEyNTUtOdHM0NA4NTEx1cjIzMxUqTYWAIFDFUZBAAAA
X-BESS-Outbound-Spam-Score: 1.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.267598 [from 
 cloudscan19-0.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.50 BSF_RULE7568M          META: Custom Rule 7568M 
 0.50 BSF_RULE_7582B         META: Custom Rule 7582B 
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=1.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_RULE_7582B, BSF_BESS_OUTBOUND
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

Add prefix nthw_ to nim_agx_setup to follow naming convention.

Signed-off-by: Serhii Iliushyk <sil-plv@napatech.com>
---
 drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c | 2 +-
 drivers/net/ntnic/nim/i2c_nim.c                                 | 2 +-
 drivers/net/ntnic/nim/i2c_nim.h                                 | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
index 36ecf0d0ec..8bd6584b1d 100644
--- a/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
+++ b/drivers/net/ntnic/link_mgmt/link_agx_100g/nt4ga_agx_link_100g.c
@@ -991,7 +991,7 @@ int nt4ga_agx_link_100g_ports_init(struct adapter_info_s *p_adapter_info, nthw_f
 		for (i = 0; i < nb_ports; i++) {
 			/* 2 + adapter port number */
 			const uint8_t instance = (uint8_t)(2U + i);
-			nim_agx_setup(&nim_ctx[i], p_nthw_agx->p_io_nim, p_nthw_agx->p_i2cm,
+			nthw_nim_agx_setup(&nim_ctx[i], p_nthw_agx->p_io_nim, p_nthw_agx->p_i2cm,
 				p_nthw_agx->p_pca9849);
 			nim_ctx[i].hwagx.mux_channel = i;
 			nim_ctx[i].instance = instance;	/* not used */
diff --git a/drivers/net/ntnic/nim/i2c_nim.c b/drivers/net/ntnic/nim/i2c_nim.c
index a394b4c5d4..9393467904 100644
--- a/drivers/net/ntnic/nim/i2c_nim.c
+++ b/drivers/net/ntnic/nim/i2c_nim.c
@@ -881,7 +881,7 @@ bool nthw_qsfp28_set_fec_enable(nim_i2c_ctx_p ctx, bool media_side_fec, bool hos
 	return true;
 }
 
-void nim_agx_setup(struct nim_i2c_ctx *ctx, nthw_pcal6416a_t *p_io_nim, nthw_i2cm_t *p_nt_i2cm,
+void nthw_nim_agx_setup(struct nim_i2c_ctx *ctx, nthw_pcal6416a_t *p_io_nim, nthw_i2cm_t *p_nt_i2cm,
 	nthw_pca9849_t *p_ca9849)
 {
 	ctx->hwagx.p_nt_i2cm = p_nt_i2cm;
diff --git a/drivers/net/ntnic/nim/i2c_nim.h b/drivers/net/ntnic/nim/i2c_nim.h
index 61dfedaa4f..2fdfd37a03 100644
--- a/drivers/net/ntnic/nim/i2c_nim.h
+++ b/drivers/net/ntnic/nim/i2c_nim.h
@@ -36,7 +36,7 @@ int nthw_construct_and_preinit_nim(nim_i2c_ctx_p ctx, void *extra);
 void nthw_qsfp28_set_high_power(nim_i2c_ctx_p ctx);
 bool nthw_qsfp28_set_fec_enable(nim_i2c_ctx_p ctx, bool media_side_fec, bool host_side_fec);
 
-void nim_agx_setup(struct nim_i2c_ctx *ctx, nthw_pcal6416a_t *p_io_nim, nthw_i2cm_t *p_nt_i2cm,
+void nthw_nim_agx_setup(struct nim_i2c_ctx *ctx, nthw_pcal6416a_t *p_io_nim, nthw_i2cm_t *p_nt_i2cm,
 	nthw_pca9849_t *p_ca9849);
 
 #endif	/* I2C_NIM_H_ */
-- 
2.45.0

