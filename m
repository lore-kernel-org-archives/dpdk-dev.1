Return-Path: <dev-bounces@dpdk.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mails.dpdk.org (mails.dpdk.org [217.70.189.124])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6A9CCD199
	for <dpdk-dev@archiver.kernel.org>; Mon, 20 Oct 2025 16:39:14 +0000 (UTC)
Received: from mails.dpdk.org (localhost [127.0.0.1])
	by mails.dpdk.org (Postfix) with ESMTP id 671C7410ED;
	Mon, 20 Oct 2025 18:37:00 +0200 (CEST)
Received: from egress-ip42a.ess.de.barracuda.com
 (egress-ip42a.ess.de.barracuda.com [18.185.115.201])
 by mails.dpdk.org (Postfix) with ESMTP id B2B1C40DDC
 for <dev@dpdk.org>; Mon, 20 Oct 2025 18:36:44 +0200 (CEST)
Received: from DU2PR03CU002.outbound.protection.outlook.com
 (mail-northeuropeazon11021079.outbound.protection.outlook.com [52.101.65.79])
 by mx-outbound11-211.eu-central-1a.ess.aws.cudaops.com (version=TLSv1.2
 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 20 Oct 2025 16:36:44 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=KENKw8GtfVfC7PsNrL/r+N/Ckgb6ou9QdojCnaasvO5NmS/ivULVnFbzuvK3hXzDrtjokC0z7HMhAwCOzDFxCTYyh6f538tGlQlEo2fleamXKjYS7yBhI3CD4A+JaaPSx2OjG5tiuVHQjvwqbAneWD/GAM0UAhm7iHWHcEpQxiWjXyICraKeqhzTJOGHOxQhFjDCasNkcdSdYDSs4UPwlL5f7lYiPXujQcUO/cY7and/bS4EHyyuoKvuM1GAHV919ADgfDmfXekvIQE6WbxUqqAspsHarelNdeMiuj1xO8wbrzwm1soVhLBdZhu5zgSK+xK0+Wk4x0mq/GxhZ5pqvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VEeo1+Y3gTDiU7p7qosYgVJ96utSoAHRuueLVqeMh3Y=;
 b=G5vRMJlYqVJSR/Jjyj18dC9moJSHK8m2TU9+vvCfITtoM4+T6aRFbvbEjVUlAI+yeYOFNvc4jw57ib+7mzkxGWj4mM0cqPAvKU9GwDDPV9h7JQCEMK5wn3GI2ykA9RZ29TTJGSQCltPPSnCzPOk67UxvIxAMOTjJ5GoFJegw3FVFjQk/U/zcpEw3QUWPDcf32d9jRIU2HaGa5Q8rql04n4X71q0rnkkMGAZ8U8+saaTz1YeDeuA8mTTDfua1Uj3XQ8KO8BkOv/fP65/pl1h3037Xt/vlsgmgRfXVcS4uq+xyfbl0L02wL/mWJUAs9VzG3vhLcpfCN8SsySXi0e4MUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 178.72.21.4) smtp.rcpttodomain=dpdk.org smtp.mailfrom=napatech.com;
 dmarc=fail (p=reject sp=reject pct=100) action=oreject
 header.from=napatech.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=napatech.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VEeo1+Y3gTDiU7p7qosYgVJ96utSoAHRuueLVqeMh3Y=;
 b=hwtaGYoLiH9uyh6U2g7h+IebQuRjwGWqg4TRFsbA33DID50gqyin8G16Xb+Q4BQk4A5kjnCki/9Q7Iep+9dBkST4KVpbvkBFH4MlfaG8+Sab2dQR/Ew0c14AR+H3PZ4K9VQ0gd7fGnE6ChMU54aFaAwsTc9wNluqZ+h9mGSa0r0=
Received: from AS4P191CA0022.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:5d9::13)
 by AM0P190MB0706.EURP190.PROD.OUTLOOK.COM (2603:10a6:208:1a1::23)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9253.11; Mon, 20 Oct
 2025 16:36:42 +0000
Received: from AMS0EPF0000019B.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d9:cafe::ca) by AS4P191CA0022.outlook.office365.com
 (2603:10a6:20b:5d9::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9228.16 via Frontend Transport; Mon,
 20 Oct 2025 16:36:39 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 178.72.21.4)
 smtp.mailfrom=napatech.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=oreject header.from=napatech.com;
Received-SPF: Fail (protection.outlook.com: domain of napatech.com does not
 designate 178.72.21.4 as permitted sender) receiver=protection.outlook.com;
 client-ip=178.72.21.4; helo=localhost.localdomain;
Received: from localhost.localdomain (178.72.21.4) by
 AMS0EPF0000019B.mail.protection.outlook.com (10.167.16.247) with Microsoft
 SMTP Server id 15.20.9253.7 via Frontend Transport; Mon, 20 Oct 2025 16:36:42
 +0000
From: Serhii Iliushyk <sil-plv@napatech.com>
To: dev@dpdk.org
Cc: mko-plv@napatech.com, sil-plv@napatech.com, ckm@napatech.com,
 stephen@networkplumber.org
Subject: [PATCH v1 23/24] net/ntnic: rename nim agx setup function
Date: Mon, 20 Oct 2025 18:36:14 +0200
Message-ID: <20251020163620.282312-24-sil-plv@napatech.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20251020163620.282312-1-sil-plv@napatech.com>
References: <20250908141740.1312268-2-sil-plv@napatech.com>
 <20251020163620.282312-1-sil-plv@napatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019B:EE_|AM0P190MB0706:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 9ca3add5-d119-4554-530a-08de0ff6da0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
 ARA:13230040|36860700013|1800799024|376014|82310400026; 
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?ScDifkIWTnqTseHL1ns9+crGZRWHRLCnbzrSJrEaviPJSSavEx2I6QESjshZ?=
 =?us-ascii?Q?raYgmOmk1M3PV0LiB6c/IUcXlo2axX87rhXJLEFp2I3oiauB57hX6lf3UzbG?=
 =?us-ascii?Q?l6jIvv0cuO0lLo2pvZCnaZFfA+kqtwOiN5i/28RV2Z6grUqEiQCFSPLpGfWV?=
 =?us-ascii?Q?AUN7pW57EYOuLr2Tqoi1sppURZt43rMeIzFUCPOz/2jd3i4LhLeKJO9T09ZO?=
 =?us-ascii?Q?1LbKOT1s/d7zMlorcdDqGYnYbyPsoCtekdVLpp+LWSy4hHkfsevoHjDaOoGz?=
 =?us-ascii?Q?j6E8wTLoFEeTB6pa8fIkL/8DTB67MuuzKLseaKvxq1QHdaKhZ7LZr/bDBptt?=
 =?us-ascii?Q?KH2yztCTT7IwE/otKvaNbMVecU9jfqHjBt13GkNkYgYNw/T5yYDd5YTYQAJN?=
 =?us-ascii?Q?u62bMfQTIQSTjjH0JQDvGS3KdvOlZkL3DTF8hAsaB/LJUsFP1cOm3h50fJmQ?=
 =?us-ascii?Q?gRfCLbLzPpdJNOkPN0+KLmADSMOPMWCRJmDlc/3AbWUxDSt1c8O3y1DuP63N?=
 =?us-ascii?Q?TUMIdX60gkOuVhhenXo3iHdA8GRxQEePtrPryjgtpjKeTAhBvagMq6AyO8oR?=
 =?us-ascii?Q?zHH1JbSQ4/RDcRsN/MPdf7PGUq8sq/hXR5W/0yVoKAy//RSYfoEtL2jrbdqD?=
 =?us-ascii?Q?djMnGCKJ/wUE4JnYjU4GiYd/Gp6Y7XzvAOe62b5iHPrccWGlBNw09JNgks3d?=
 =?us-ascii?Q?L58Pbz1qnG9PUREYQ2yW6v2wCGSIP3TCwcUJTBJBGg/K1yS39wwM5QLKv3/N?=
 =?us-ascii?Q?AA8T1GTUqtGVRnD5jvD9KbbvE9zEXp/OY3FAPcXDciE4O+B6hQ8ZM/50uIbS?=
 =?us-ascii?Q?gp6qWFIfjpKlGRSukduc+ELwvHrXVr9MXej6wsNvN3XHoU1xaLKL9NjsNHCq?=
 =?us-ascii?Q?ZC2YgyX23sUnHQPlQuGuA3WGZRlq+HkNV4jyKNcLFDGO11LjPLvYXzjTGM6H?=
 =?us-ascii?Q?k0r6Hl6qc1rVqu6pm5/n4tc59JvDKMTgsmXZZudTTmxadTqAHBihl4Xlosv4?=
 =?us-ascii?Q?hF7UjhVneqqlo5//5N8ipn9Qrsdp1RSFnhyEpB+7+7YxZa/XuE3RTWszN1UU?=
 =?us-ascii?Q?jVAVNznK6j6GVckTbowTxsRvwxHJqtutiG49ksgkyLhAzH9ZjIJ2XPegTW01?=
 =?us-ascii?Q?TqPKvKybVZSoUQjTRfwdfF9/WJWsHZqtjE4DSgmHcH+YlJDaLGyqz1toa3lz?=
 =?us-ascii?Q?EZqVzUZ8sm/IBNGeEyl0SGea+4pyOMprsnkm6bI7V4myWQ9dHM+Il17FKJqz?=
 =?us-ascii?Q?1RDT3L1udRgQM7vgscoyBYXiFtn4H4fXhPkUHDijETXXzjGdSi3tow/1Eb7u?=
 =?us-ascii?Q?bnZw5qpEbHjhTFnyMUeMGsad4mISXQlUSEJ7GVSNnl1lIc2J6xZqc5Tm4PTK?=
 =?us-ascii?Q?RTMIdku5mMs/3v6ukWe3aajXQLJOuIlnuFxwveED4J/e+ub276hxTLl3g1KQ?=
 =?us-ascii?Q?kQ988taEoxoFxACCa7jysHTpK1dOWamF2SQQNhjh9BtmaP+2O/30z3m5Y877?=
 =?us-ascii?Q?CGYDZSTzbj3yNvx2oNHWcDK+fSp31Ue0s0iXXZtoqwIaadyFBo3uunWOybEE?=
 =?us-ascii?Q?BBIpVjdBvmRcdxygfSY=3D?=
X-Forefront-Antispam-Report: CIP:178.72.21.4; CTRY:DK; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:localhost.localdomain; PTR:InfoDomainNonexistent;
 CAT:NONE; SFS:(13230040)(36860700013)(1800799024)(376014)(82310400026);
 DIR:OUT; SFP:1102; 
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: WESh+y/YMYih0uDe6vI3fvd2OcL9dYcIvogSxoMl9YPggO/6Ijlu5xrgldIXDvLdLsdqvXrzOwCx5MxJ01HCWTVjsqGr8RW/iP5lcu83kZcB/6F726IoW8OjU+vc2rqOmwjnWz2jJ3pSrgp3FGcT9MNSOMJCHEl1jilCsenitk1c7rz0LPEwR7iIGrLKWWcnqCC9TCtRL374jw7yQWy8LiBlb+/vr9cfNvJJv5Jo6aJLcth7b/Rh4+Hj4vy1k0yvKoQXFqeNiprKLqhMFIvQluemekSycx6h0ztJWt0A5rtH5WkQDMaava5PSylYT8t0rHQvghHr6d0cWmAK1Ouxb8wAfadVmGIEneotkov5jfPDgjyNd2xWxMRe0owlr/io0x8hmiKDtAFDyCMzWbtOXaiaAwZsUscrIzK9mP+Xv4rU4wEBiLaP4xhkdOfmy9fJVJ3idgjnhDnDIZdY0nkObX942TSUQ7aQShv+vhFvA+ncsUVjRukO9X48SfPVorhSVjC9KtZKn27x51pTzqkk4dDiZooEoixcM298YXjItKD3sptwedeJCnu7/TM/SZwVI+GcXwNtAjTTpGR/5b8R3XN5JgXMVkR7HPPFkzHkHiby6zxXcbVUXpV4w/N+fkAZoBe82xRt7bn/lfCl48RMzYq9JeK1uyWOEtUQpk8DQdE=
X-OriginatorOrg: napatech.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2025 16:36:42.6641 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ca3add5-d119-4554-530a-08de0ff6da0b
X-MS-Exchange-CrossTenant-Id: c4540d0b-728a-4233-9da5-9ea30c7ec3ed
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=c4540d0b-728a-4233-9da5-9ea30c7ec3ed; Ip=[178.72.21.4];
 Helo=[localhost.localdomain]
X-MS-Exchange-CrossTenant-AuthSource: AMS0EPF0000019B.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0P190MB0706
X-BESS-ID: 1760978203-303027-28478-63527-1
X-BESS-VER: 2019.1_20251001.1803
X-BESS-Apparent-Source-IP: 52.101.65.79
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVkYmZuZAVgZQMCk5ySzR0tjc0D
 DFMNEyNTUtOdHM0NA4NTEx1cjIzMxUqTYWAIFDFUZBAAAA
X-BESS-Outbound-Spam-Score: 1.00
X-BESS-Outbound-Spam-Report: Code version 3.2,
 rules version 3.2.2.268348 [from 
 cloudscan19-189.eu-central-1b.ess.aws.cudaops.com]
 Rule breakdown below
 pts rule name              description
 ---- ---------------------- --------------------------------
 0.50 BSF_RULE7568M          META: Custom Rule 7568M 
 0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
 0.50 BSF_RULE_7582B         META: Custom Rule 7582B 
X-BESS-Outbound-Spam-Status: SCORE=1.00 using account:ESS113687 scores of
 KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND, BSF_RULE_7582B
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

